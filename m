Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A0CD6E74
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 13:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E7D3402BA;
	Fri,  5 Jun 2026 15:03:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 637F24026A;
 Fri,  5 Jun 2026 15:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780664603; x=1812200603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hzeaNS5gVB37KDM4/e2dsv8UIwLaiCyUnm2VSVOkW6w=;
 b=GTcd1e5fUh/5bR/IvwJ5Z4DdYlBMfO52djTEO9Iwi5tRFw1XhK5dWsJK
 Zn3J0EVs5wQtd2FZ30gaCF4yFPs3VjcKII4m52Si15YRyfbXJkIJkN2nU
 05SaAPh7Kvl2fqNxDx+bjA1IhXboZHsLegiVcCSQdUSenVohjipvyCO7+
 b4iPsWKSl12O1MSKLZjWIS2z5uHSFqJKvk2OXKApl/eKx/i/V/INQvjT9
 nYulYpAj9bjH4LX/PcJtRwF1vlnMYd6cdKcGppLuSJtTIVAzVOUqGVfBG
 0fsPdtwtpnt2zbMZ3j1YrkZkCDL9Qgpj0bVffxBUNnAy49ei9eJOo7Fty g==;
X-CSE-ConnectionGUID: zv3rSAmZQze4mbObJwajmA==
X-CSE-MsgGUID: BkMTyDn9QaSfgoRXjs5AIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85386255"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="85386255"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:03:22 -0700
X-CSE-ConnectionGUID: Ud9gHdNHT+myeUS/T/xiNA==
X-CSE-MsgGUID: ypcgG4yvROep2VPq6b0v0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="244001639"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa010.jf.intel.com with ESMTP; 05 Jun 2026 06:03:20 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: maxime@leroys.fr,
	stable@dpdk.org
Subject: [PATCH 1/3] fib6: fix tbl8 reservation drift in trie
Date: Fri,  5 Jun 2026 13:03:17 +0000
Message-ID: <20260605130317.896413-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145855.1748406-2-maxime@leroys.fr>
References: <20260522145855.1748406-2-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Maxime Leroy <maxime@leroys.fr>

trie_modify() maintained rsvd_tbl8s by computing a depth_diff from
the current RIB topology at both ADD and DEL. The two values diverge
when the RIB changes between an ADD and its later DEL (a covering
parent added or removed), and rsvd_tbl8s eventually wraps to
UINT32_MAX, rejecting all subsequent /25+ ADDs with -ENOSPC.

A helper count_empty_levels() was added to fix the issue.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c          | 81 +++++++++++++++++++++--------------------
 lib/rib/rib6_internal.h | 24 ++++++++++++
 lib/rib/rte_rib6.c      | 12 +-----
 3 files changed, 66 insertions(+), 51 deletions(-)
 create mode 100644 lib/rib/rib6_internal.h

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..e9f1141cef 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -15,6 +15,7 @@
 #include <rte_fib6.h>
 #include "fib_log.h"
 #include "trie.h"
+#include <rib6_internal.h>
 
 #ifdef CC_AVX512_SUPPORT
 
@@ -534,19 +535,45 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	return 0;
 }
 
+/*
+ * Count bumber of TBL8s that can be freed after deleting a prefix or allocated
+ * after adding a prefix.
+ */
+static uint8_t
+count_empty_levels(struct rte_rib6 *rib, const struct rte_ipv6_addr *ip, uint8_t depth)
+{
+	struct rte_rib6_node *cur = rte_rib6_lookup_exact(rib, ip, depth);
+	/* expect prefix exists */
+	if (cur == NULL)
+		return 0;
+
+	/* more specifics present */
+	if (cur->left != NULL || cur->right != NULL)
+		return 0;
+
+	struct rte_rib6_node *parent = cur->parent;
+	/* we know parent->depth lt a target cur->depth
+	 * also, there exists tbl8 path up to RTE_ALIGN_CEIL(parent->depth, 8)
+	 */
+	depth = RTE_MAX(depth, 24);
+	uint8_t parent_depth = (parent) ? RTE_MAX(parent->depth, 24) : 24;
+	uint8_t depth_diff = (RTE_ALIGN_CEIL(depth, 8) - RTE_ALIGN_CEIL(parent_depth, 8)) >> 3;
+
+	return depth_diff;
+}
+
 int
 trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop, int op)
 {
 	struct rte_trie_tbl *dp;
 	struct rte_rib6 *rib;
-	struct rte_rib6_node *tmp = NULL;
 	struct rte_rib6_node *node;
 	struct rte_rib6_node *parent;
-	struct rte_ipv6_addr ip_masked, tmp_ip;
+	struct rte_ipv6_addr ip_masked;
 	int ret = 0;
 	uint64_t par_nh, node_nh;
-	uint8_t tmp_depth, depth_diff = 0, parent_depth = 24;
+	uint8_t new_levels;
 
 	if ((fib == NULL) || (ip == NULL) || (depth > RTE_IPV6_MAX_DEPTH))
 		return -EINVAL;
@@ -559,37 +586,6 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	ip_masked = *ip;
 	rte_ipv6_addr_mask(&ip_masked, depth);
 
-	if (depth > 24) {
-		tmp = rte_rib6_get_nxt(rib, &ip_masked,
-			RTE_ALIGN_FLOOR(depth, 8), NULL,
-			RTE_RIB6_GET_NXT_ALL);
-		if (tmp && op == RTE_FIB6_DEL) {
-			/* in case of delete operation, skip the prefix we are going to delete */
-			rte_rib6_get_ip(tmp, &tmp_ip);
-			rte_rib6_get_depth(tmp, &tmp_depth);
-			if (rte_ipv6_addr_eq(&ip_masked, &tmp_ip) && depth == tmp_depth)
-				tmp = rte_rib6_get_nxt(rib, &ip_masked,
-					RTE_ALIGN_FLOOR(depth, 8), tmp, RTE_RIB6_GET_NXT_ALL);
-		}
-
-		if (tmp == NULL) {
-			tmp = rte_rib6_lookup(rib, ip);
-			/**
-			 * in case of delete operation, lookup returns the prefix
-			 * we are going to delete. Find the parent.
-			 */
-			if (tmp && op == RTE_FIB6_DEL)
-				tmp = rte_rib6_lookup_parent(tmp);
-
-			if (tmp != NULL) {
-				rte_rib6_get_depth(tmp, &tmp_depth);
-				parent_depth = RTE_MAX(tmp_depth, 24);
-			}
-			depth_diff = RTE_ALIGN_CEIL(depth, 8) -
-				RTE_ALIGN_CEIL(parent_depth, 8);
-			depth_diff = depth_diff >> 3;
-		}
-	}
 	node = rte_rib6_lookup_exact(rib, &ip_masked, depth);
 	switch (op) {
 	case RTE_FIB6_ADD:
@@ -603,12 +599,16 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return 0;
 		}
 
-		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
-			return -ENOSPC;
-
 		node = rte_rib6_insert(rib, &ip_masked, depth);
 		if (node == NULL)
 			return -rte_errno;
+
+		new_levels = count_empty_levels(rib, &ip_masked, depth);
+		if (dp->rsvd_tbl8s + new_levels > dp->number_tbl8s) {
+			rte_rib6_remove(rib, &ip_masked, depth);
+			return -ENOSPC;
+		}
+
 		rte_rib6_set_nh(node, next_hop);
 		parent = rte_rib6_lookup_parent(node);
 		if (parent != NULL) {
@@ -622,7 +622,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return ret;
 		}
 successfully_added:
-		dp->rsvd_tbl8s += depth_diff;
+		dp->rsvd_tbl8s += new_levels;
 		return 0;
 	case RTE_FIB6_DEL:
 		if (node == NULL)
@@ -640,9 +640,10 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 
 		if (ret != 0)
 			return ret;
-		rte_rib6_remove(rib, ip, depth);
 
-		dp->rsvd_tbl8s -= depth_diff;
+		dp->rsvd_tbl8s -= count_empty_levels(rib, &ip_masked, depth);
+		rte_rib6_remove(rib, &ip_masked, depth);
+
 		return 0;
 	default:
 		break;
diff --git a/lib/rib/rib6_internal.h b/lib/rib/rib6_internal.h
new file mode 100644
index 0000000000..674befc152
--- /dev/null
+++ b/lib/rib/rib6_internal.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018 Vladimir Medvedkin <medvedkinv@gmail.com>
+ * Copyright(c) 2019 Intel Corporation
+ */
+
+#ifndef _RIB6_INTERNAL_H_
+#define _RIB6_INTERNAL_H_
+
+#include <stdint.h>
+
+#include <rte_ip6.h>
+
+struct rte_rib6_node {
+	struct rte_rib6_node	*left;
+	struct rte_rib6_node	*right;
+	struct rte_rib6_node	*parent;
+	uint64_t		nh;
+	struct rte_ipv6_addr	ip;
+	uint8_t			depth;
+	uint8_t			flag;
+	uint64_t ext[];
+};
+
+#endif /* _RIB6_INTERNAL_H_ */
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ec8ff68e87..f9023fca59 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -19,6 +19,7 @@
 #include <rte_rib6.h>
 
 #include "rib_log.h"
+#include "rib6_internal.h"
 
 #define RTE_RIB_VALID_NODE	1
 /* Maximum length of a RIB6 name. */
@@ -30,17 +31,6 @@ static struct rte_tailq_elem rte_rib6_tailq = {
 };
 EAL_REGISTER_TAILQ(rte_rib6_tailq)
 
-struct rte_rib6_node {
-	struct rte_rib6_node	*left;
-	struct rte_rib6_node	*right;
-	struct rte_rib6_node	*parent;
-	uint64_t		nh;
-	struct rte_ipv6_addr	ip;
-	uint8_t			depth;
-	uint8_t			flag;
-	uint64_t ext[];
-};
-
 struct rte_rib6 {
 	char		name[RTE_RIB6_NAMESIZE];
 	struct rte_rib6_node	*tree;
-- 
2.43.0

