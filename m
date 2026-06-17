Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D862BCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 401E340A73;
	Wed, 17 Jun 2026 10:24:14 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 9953F4064F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:24:12 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so33487805e9.1
 for <dev@dpdk.org>; Wed, 17 Jun 2026 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781684652; x=1782289452; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL+CxImv/xE7Eo5oy6wp2Feiq5R5lN/NuBl0JiHZNsk=;
 b=TD/GihgA3B6pvs0nbcf6c99ZDYYbI5zX00f0/eN0UtmbXE89iLVhx5x1sF3MUkWfq2
 IqL3RjI7gDGzKelMp8BWnWOoQi5uZrTi+dC21gMDNEtcr7T52aOaPBdBBE7I7sE0lVON
 EzWO9qIdmUayJgvOKW3XjLunDw7wXGu1f+XamPxKFrUUPt1RRFjztGJz9j9cWvaa+APq
 opjN8IcIbdjkiXkvJxMUJcml6iadoTpQM0d2+pw92QSjd3Fzppg4B4LlPUQDchZHtJdy
 +zfzNzGtM78DLoHKm63Qjmr3R3sLbdb95GaHPmpRpQDYYWJktEcqBzGjYa/fg7gNr4yX
 3lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781684652; x=1782289452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TL+CxImv/xE7Eo5oy6wp2Feiq5R5lN/NuBl0JiHZNsk=;
 b=cWMmWHfAvnOgIl4EAtozsJwpleltj1hEZeET08WiAiJ3CUFkSnLZBfL/6+kb2Lq+3E
 U7JLXu/id7AW2LY0qCCh9yIsHV64A8q69FK+uyRFK1gBHxqgCovgkginqPe6ksDgxMwx
 i97AjSW//yTsqqMgDanzNGq4++/Vdzc3pGdXUU93TxSAKYJZYDdv9Q4iIL+75y5+P0sS
 Ea3px6aScpyXsVufGFONvqMPCR9O8Dbid3lmDhV3cpQ780aQwAaleY9bEIFPb6c/UBIN
 0vboRenh18EERaSlH1n/A/9uIb6+JUjScrRNROZh4xSOQTqdYldkLqtIhXDEKFwitKHp
 /bew==
X-Gm-Message-State: AOJu0Ywjl146Iw0rUFCP0EyNiibd8Bfr4+QHXj0zKy016hRzsWFrb3Qj
 Dk6nlftJnNvWVQc8XRBpWG9zWqhed4qpZMwydjZLhn15k40K/8hMnxqb
X-Gm-Gg: Acq92OGuTpziULomHtiziDw7+5g59/ne33QwMLIhwMJhnHWkqQkqdKreAKv0KgyDz23
 Qa2kAYQ9O7PdgqK7feHP58dFMYMqm6HQTMQGLU4vegm2PhsmGuslpFH6Odj+NkztbNPevkpNjWb
 FnWYrMFewTGIUZExWGtescSGWqW+nhoqOgl1KBBwCXA9ozTNkMO/iK4Qh1FE7N+oOWOTnuOcg+C
 eb0WLOFGRkSHxx7y6kHFYmBAF6T4saf+vBdLnT2e6DF7IiHmSoRO+C3/ufZhdzVh4XujVTyb4J6
 arQJKndyTD7SEQQlNpKStv9g38KVM/uYTkPpZ7buiggGs06TZs1wyg5YGvHq6QSz9Ukmmq79PuP
 58SEDSjjyx2FyZvooXYUVUbssjPAEoImk/zuTwZkYShY4E7ReD1cxXENud5gvFTsmGqJBNG8wlY
 R2hdhAl6OFcNM1L0ulwwkmYPF9sAKdLA9wuix2chN/2aK0
X-Received: by 2002:a05:600c:6386:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-49234b36ee5mr16412335e9.0.1781684652077; 
 Wed, 17 Jun 2026 01:24:12 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49234daafc7sm21526155e9.10.2026.06.17.01.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:24:11 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>,
	stable@dpdk.org
Subject: [PATCH v2 1/3] fib6: fix tbl8 reservation drift in trie
Date: Wed, 17 Jun 2026 10:23:58 +0200
Message-ID: <20260617082400.142129-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617082400.142129-1-maxime@leroys.fr>
References: <20260522145855.1748406-1-maxime@leroys.fr>
 <20260617082400.142129-1-maxime@leroys.fr>
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

trie_modify() maintained rsvd_tbl8s incrementally: it added a
depth_diff at ADD and subtracted one at DEL. Each depth_diff was an
independent estimate derived from the covering parent returned by a
lookup at the time of the operation. The parent seen at an ADD could
differ from the one seen at the matching DEL (a covering parent added
or removed in between), so the amount subtracted did not match the
amount added. rsvd_tbl8s was not tied to any function of the current
route set, so nothing corrected the accumulating error; it eventually
wrapped to UINT32_MAX, rejecting all subsequent /25+ ADDs with -ENOSPC.

Define rsvd_tbl8s as the number of tbl8 levels the current route set
needs: one per byte boundary (24, 32, ..., 120) whose supernet holds
at least one longer prefix. count_empty_levels(node) returns how many
of those levels the node occupies on its own in the committed RIB:
zero if it still has more specifics, otherwise CEIL(depth, 8) -
CEIL(parent_depth, 8) in tbl8 units (has_children + parent depth). On
ADD that is the levels the node is first to occupy; on DEL the levels
it is last to vacate. The per-node increment and decrement need not
match (deleting a prefix that still has a more specific frees nothing,
and that level is released later by whichever prefix leaves last), yet
rsvd_tbl8s stays equal to the number of occupied levels at every step,
so it tracks the RIB exactly and cannot drift.

Add the internal RIB helpers rte_rib6_node_has_children() and
rte_rib6_get_parent() used by the count.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c          | 83 +++++++++++++++++++++--------------------
 lib/rib/rib6_internal.h | 22 +++++++++++
 lib/rib/rte_rib6.c      | 15 ++++++++
 3 files changed, 80 insertions(+), 40 deletions(-)
 create mode 100644 lib/rib/rib6_internal.h

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 99272f45bd..187360d1c8 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -13,6 +13,7 @@
 
 #include <rte_rib6.h>
 #include <rte_fib6.h>
+#include <rib6_internal.h>
 #include "fib_log.h"
 #include "trie.h"
 
@@ -534,19 +535,47 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	return 0;
 }
 
+/*
+ * Count number of TBL8s that can be freed after deleting a prefix or allocated
+ * after adding a prefix.
+ */
+static uint8_t
+count_empty_levels(const struct rte_rib6_node *node)
+{
+	struct rte_rib6_node *parent;
+	uint8_t depth, parent_depth = 24;
+
+	/* more specifics present */
+	if (rte_rib6_node_has_children(node))
+		return 0;
+
+	rte_rib6_get_depth(node, &depth);
+	depth = RTE_MAX(depth, 24);
+
+	/* we know parent depth lt a target node depth
+	 * also, there exists tbl8 path up to RTE_ALIGN_CEIL(parent depth, 8)
+	 */
+	parent = rte_rib6_get_parent(node);
+	if (parent != NULL) {
+		rte_rib6_get_depth(parent, &parent_depth);
+		parent_depth = RTE_MAX(parent_depth, 24);
+	}
+
+	return (RTE_ALIGN_CEIL(depth, 8) - RTE_ALIGN_CEIL(parent_depth, 8)) >> 3;
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
@@ -559,37 +588,6 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
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
@@ -604,12 +602,16 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return ret;
 		}
 
-		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
-			return -ENOSPC;
-
 		node = rte_rib6_insert(rib, &ip_masked, depth);
 		if (node == NULL)
 			return -rte_errno;
+
+		new_levels = count_empty_levels(node);
+		if (dp->rsvd_tbl8s + new_levels > dp->number_tbl8s) {
+			rte_rib6_remove(rib, &ip_masked, depth);
+			return -ENOSPC;
+		}
+
 		rte_rib6_set_nh(node, next_hop);
 		parent = rte_rib6_lookup_parent(node);
 		if (parent != NULL) {
@@ -623,7 +625,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return ret;
 		}
 successfully_added:
-		dp->rsvd_tbl8s += depth_diff;
+		dp->rsvd_tbl8s += new_levels;
 		return 0;
 	case RTE_FIB6_DEL:
 		if (node == NULL)
@@ -641,9 +643,10 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 
 		if (ret != 0)
 			return ret;
-		rte_rib6_remove(rib, ip, depth);
 
-		dp->rsvd_tbl8s -= depth_diff;
+		dp->rsvd_tbl8s -= count_empty_levels(node);
+		rte_rib6_remove(rib, &ip_masked, depth);
+
 		return 0;
 	default:
 		break;
diff --git a/lib/rib/rib6_internal.h b/lib/rib/rib6_internal.h
new file mode 100644
index 0000000000..0f8b5955bb
--- /dev/null
+++ b/lib/rib/rib6_internal.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#ifndef _RIB6_INTERNAL_H_
+#define _RIB6_INTERNAL_H_
+
+#include <stdbool.h>
+
+#include <rte_compat.h>
+
+struct rte_rib6_node;
+
+__rte_internal
+bool
+rte_rib6_node_has_children(const struct rte_rib6_node *node);
+
+__rte_internal
+struct rte_rib6_node *
+rte_rib6_get_parent(const struct rte_rib6_node *node);
+
+#endif /* _RIB6_INTERNAL_H_ */
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ec8ff68e87..918ddbdfd3 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -19,6 +19,7 @@
 #include <rte_rib6.h>
 
 #include "rib_log.h"
+#include "rib6_internal.h"
 
 #define RTE_RIB_VALID_NODE	1
 /* Maximum length of a RIB6 name. */
@@ -424,6 +425,20 @@ rte_rib6_get_depth(const struct rte_rib6_node *node, uint8_t *depth)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_rib6_node_has_children)
+bool
+rte_rib6_node_has_children(const struct rte_rib6_node *node)
+{
+	return node->left != NULL || node->right != NULL;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_rib6_get_parent)
+struct rte_rib6_node *
+rte_rib6_get_parent(const struct rte_rib6_node *node)
+{
+	return node->parent;
+}
+
 RTE_EXPORT_SYMBOL(rte_rib6_get_ext)
 void *
 rte_rib6_get_ext(struct rte_rib6_node *node)
-- 
2.43.0

