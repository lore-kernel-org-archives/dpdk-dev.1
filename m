Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7C1CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:59:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 944F440695;
	Fri, 22 May 2026 16:59:11 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id B2E5140693
 for <dev@dpdk.org>; Fri, 22 May 2026 16:59:10 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso41861625e9.3
 for <dev@dpdk.org>; Fri, 22 May 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461950; x=1780066750; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9Hlm3kdB1OSTr+Fa2VrRl3ieLnsYNvG8o9yXYVgY8Y=;
 b=SuQh5d4K1kGMM1ClSJOlnPQqrdfO2FbBRuSqqqaKYtBBELlQOrF7ReMFVHasSNjj9w
 j+21F1RmUhmCkwy2fGpufQBVJmETp2g1eYGvoWyQCK/xAa3YvDtjGYjpb87mkiHUfxqo
 0X6/NIunl9fKC44XkEneqe7k+14Z/TPkf9KIOaoQJNT1xPN6HWvQB9vIRfZPhXirieg/
 ZU+oynDmbu/ctsJrwxlNAjXLvLAGPcB6OlQI0DV0mX0cO/TJ5J9WF9bgCXweIAxyfvGu
 2CFA08qhYFGjoY/IILPeIayCAYKnhT2LgWRvLqzi5XfcKA6Y68BmNLgyq8c8wJTwq8PT
 x+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461950; x=1780066750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9Hlm3kdB1OSTr+Fa2VrRl3ieLnsYNvG8o9yXYVgY8Y=;
 b=CHqeKrX+/9jJaVBD9CeZME6wvUbX20BrTsyykQk/NVsVGdsEEpBupOF0AdNg5nEY7g
 BWTtXWXDmgzN7DXVVOpnTFg4gODh0dhPF4VqQdfqazFkxdI6OMHHAep/bhW8DbXiY14c
 B3UPDgZZEwHkmdUQfagMC8e6G8GFB+XiC4cbUi+2oTst/Kj7CD/O6XZzptotPNeLMO3K
 hfl5i+iXP6SZUnA/L/i+DvwzF1E8LN6IM3OnfbZFPVuVwksF7EnFHiuzkykyHK9H9C9x
 iHlxHrssB81H9vj8q0hemvsCdeb0gAsJDXKoaspZBLs4G37gNPgdT+l/GetpXy0pBGHi
 xPQA==
X-Gm-Message-State: AOJu0YzgkkhzsV+CQAXOGl/lhADzg38fUi0prS+G9AG7zTYSTAoug03p
 nnDOfavqh4d3Q0HK+grquuJlKcxC9S9HDG2jNtoSAhW9Jnis45Gu55Ax
X-Gm-Gg: Acq92OEoXPfO+HabNyL7T+JXnEgwAWzEyIQnJpS/qXhao8lUOTFUxY3gECV9kSppvyk
 vmH68ga2UMS4Py6JcOPtM9X/KfuUxNsNEmLj9/zNQL6a59JQgXYleB0e/XitEZG63SxSz8e0ohe
 vloeLoG/6XX4w2qlhiGCalldpLWMv0K0BqYfsI0HELcmE9hWP5VC+zURnKzY4zqhtGp/ODIfIqu
 xcvYoNErgCE7Kg3GFDNEhF5ssx6Yk0tgcIyMIfuNh5GjsB1DHbZHnIcwnyr7EfWwf0Q0/L2U8S+
 5gDq1jKL+fFi3K0yL4I0xTk5qbDJKqfpEXxOMkIy+pfhHkcfKLiA990ozfWaKwb4G6kiLAsHzGD
 hHD+APkHl004ek5AiAZh6gZBp0itTBStGsNF5fUS+2rffVXFyT6CLpgywHG+HLgn8pW0FAJWD5a
 XXZQMY/7IrU5UqQDqZvryICH4wm1roJ3Fro2jWCn9NqjFM6K1w819JvmvB8QZu4DBevw==
X-Received: by 2002:a05:600c:3b27:b0:490:3b87:be0f with SMTP id
 5b1f17b1804b1-490428d750fmr54986535e9.23.1779461950182; 
 Fri, 22 May 2026 07:59:10 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a33dsm49325775e9.11.2026.05.22.07.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:59:09 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 4/5] rib: track valid descendant count per node
Date: Fri, 22 May 2026 16:58:53 +0200
Message-ID: <20260522145855.1748406-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145855.1748406-1-maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
 <20260522145855.1748406-1-maxime@leroys.fr>
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

Add a uint32_t field to struct rte_rib6_node that counts valid prefixes
in the node's subtree (excluding self). Maintained incrementally on
insert (when a node becomes valid) and remove (when a node becomes
invalid), in O(tree depth) per operation.

The field fits in the padding before ext[]; the node size and ext[]
offset are unchanged. uint32_t is required because a single subtree
may hold more than 65535 BGP routes.

Expose an __rte_internal helper rte_rib6_count_empty_supernets()
via a new private header lib/rib/rib6_internal.h that descends the
tree once and reports how many byte boundaries below a given prefix
have no valid descendant. lib/fib uses this to maintain tbl8
reservation accounting in a single tree walk instead of one
rte_rib6_get_nxt() call per byte boundary.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_rib6.c    | 92 +++++++++++++++++++++++++++++++++++++++++
 lib/rib/rib6_internal.h | 37 +++++++++++++++++
 lib/rib/rte_rib6.c      | 80 +++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 lib/rib/rib6_internal.h

diff --git a/app/test/test_rib6.c b/app/test/test_rib6.c
index 0295a9640c..a1a6ab17f4 100644
--- a/app/test/test_rib6.c
+++ b/app/test/test_rib6.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <rte_ip6.h>
 #include <rte_rib6.h>
+#include <rib6_internal.h>
 
 #include "test.h"
 
@@ -20,6 +21,7 @@ static int32_t test_insert_invalid(void);
 static int32_t test_get_fn(void);
 static int32_t test_basic(void);
 static int32_t test_tree_traversal(void);
+static int32_t test_empty_supernets(void);
 
 #define MAX_DEPTH 128
 #define MAX_RULES (1 << 22)
@@ -322,6 +324,95 @@ test_tree_traversal(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Exercise rte_rib6_count_empty_supernets() which depends on the
+ * valid_descendants counter maintained on insert/remove.
+ */
+int32_t
+test_empty_supernets(void)
+{
+	struct rte_rib6 *rib = NULL;
+	struct rte_rib6_conf config;
+	struct rte_ipv6_addr ip = RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr sibling = RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 1);
+	uint8_t cnt;
+
+	config.max_nodes = 64;
+	config.ext_sz = 0;
+
+	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
+
+	/* depth <= 24: no byte boundaries above to inspect. */
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 24);
+	RTE_TEST_ASSERT(cnt == 0, "depth 24 must return 0, got %u\n", cnt);
+
+	/* Empty RIB, /128 query: 13 byte boundaries (24..120) all empty. */
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 13, "empty RIB /128 must return 13, got %u\n", cnt);
+
+	/* Insert a /32 ancestor: level 24 now has a descendant, levels
+	 * 32..120 still empty -> 12.
+	 */
+	RTE_TEST_ASSERT(rte_rib6_insert(rib, &ip, 32) != NULL,
+		"Failed to insert /32\n");
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 12, "after /32 ADD: expected 12, got %u\n", cnt);
+
+	/* Insert a /48 below: levels 24, 32 and 40 see /48 as descendant,
+	 * 48..120 empty -> 10.
+	 */
+	RTE_TEST_ASSERT(rte_rib6_insert(rib, &ip, 48) != NULL,
+		"Failed to insert /48\n");
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 10, "after /48 ADD: expected 10, got %u\n", cnt);
+
+	/* Insert a sibling /128 that shares a long common prefix with ip
+	 * but differs in the last bits. This forces creation of a
+	 * common_node and exercises the inherited valid_descendants of
+	 * that synthesized intermediate.
+	 */
+	RTE_TEST_ASSERT(rte_rib6_insert(rib, &sibling, 128) != NULL,
+		"Failed to insert sibling /128\n");
+	/* sibling shares prefix with ip down to bit 127; for the query on
+	 * ip/128, all byte boundaries 24..120 have descendants (the /32,
+	 * /48 and the sibling /128 chain) -> 0 empty levels.
+	 */
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 0, "fully populated chain: expected 0, got %u\n",
+		cnt);
+
+	/* Remove the /32 ancestor: /48 and /128 sibling still cover all
+	 * byte boundaries 24..120 -> still 0 empty levels.
+	 */
+	rte_rib6_remove(rib, &ip, 32);
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 0,
+		"after /32 DEL still covered: expected 0, got %u\n", cnt);
+
+	/* Remove the /48: only the /128 sibling remains. For an ip/128
+	 * query, levels 24..120 each see the sibling as descendant, so
+	 * count is still 0.
+	 */
+	rte_rib6_remove(rib, &ip, 48);
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 0,
+		"after /48 DEL still covered: expected 0, got %u\n", cnt);
+
+	/* Remove the sibling /128: RIB now empty again. */
+	rte_rib6_remove(rib, &sibling, 128);
+	cnt = rte_rib6_count_empty_supernets(rib, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 13,
+		"after final DEL: expected 13, got %u\n", cnt);
+
+	/* Invalid input: NULL rib. */
+	cnt = rte_rib6_count_empty_supernets(NULL, &ip, 128);
+	RTE_TEST_ASSERT(cnt == 0, "NULL rib must return 0, got %u\n", cnt);
+
+	rte_rib6_free(rib);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite rib6_tests = {
 	.suite_name = "rib6 autotest",
 	.setup = NULL,
@@ -333,6 +424,7 @@ static struct unit_test_suite rib6_tests = {
 		TEST_CASE(test_get_fn),
 		TEST_CASE(test_basic),
 		TEST_CASE(test_tree_traversal),
+		TEST_CASE(test_empty_supernets),
 		TEST_CASES_END()
 	}
 };
diff --git a/lib/rib/rib6_internal.h b/lib/rib/rib6_internal.h
new file mode 100644
index 0000000000..8246626de9
--- /dev/null
+++ b/lib/rib/rib6_internal.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#ifndef _RIB6_INTERNAL_H_
+#define _RIB6_INTERNAL_H_
+
+#include <stdint.h>
+
+#include <rte_compat.h>
+#include <rte_ip6.h>
+
+struct rte_rib6;
+
+/**
+ * @internal
+ * Count byte boundaries L in {24, 32, 40, ..., RTE_ALIGN_CEIL(depth, 8) - 8}
+ * for which the supernet of ip at level L has no valid descendant with
+ * depth > L. Used by lib/fib to maintain tbl8 reservation accounting in
+ * a single descent of the binary tree.
+ *
+ * @param rib
+ *  RIB object handle
+ * @param ip
+ *  IPv6 prefix address
+ * @param depth
+ *  prefix length
+ * @return
+ *  number of empty byte boundaries (0 if all levels have descendants
+ *  or depth <= 24)
+ */
+__rte_internal
+uint8_t
+rte_rib6_count_empty_supernets(struct rte_rib6 *rib,
+	const struct rte_ipv6_addr *ip, uint8_t depth);
+
+#endif /* _RIB6_INTERNAL_H_ */
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ec8ff68e87..ae8aba6563 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -18,6 +18,7 @@
 
 #include <rte_rib6.h>
 
+#include "rib6_internal.h"
 #include "rib_log.h"
 
 #define RTE_RIB_VALID_NODE	1
@@ -36,6 +37,7 @@ struct rte_rib6_node {
 	struct rte_rib6_node	*parent;
 	uint64_t		nh;
 	struct rte_ipv6_addr	ip;
+	uint32_t		valid_descendants;
 	uint8_t			depth;
 	uint8_t			flag;
 	uint64_t ext[];
@@ -104,10 +106,35 @@ node_alloc(struct rte_rib6 *rib)
 	ret = rte_mempool_get(rib->node_pool, (void *)&ent);
 	if (unlikely(ret != 0))
 		return NULL;
+	ent->valid_descendants = 0;
 	++rib->cur_nodes;
 	return ent;
 }
 
+/* Increment valid_descendants along the parent chain when node becomes valid. */
+static inline void
+inc_valid_descendants(struct rte_rib6_node *node)
+{
+	struct rte_rib6_node *p = node->parent;
+
+	while (p != NULL) {
+		p->valid_descendants++;
+		p = p->parent;
+	}
+}
+
+/* Decrement valid_descendants along the parent chain when node becomes invalid. */
+static inline void
+dec_valid_descendants(struct rte_rib6_node *node)
+{
+	struct rte_rib6_node *p = node->parent;
+
+	while (p != NULL) {
+		p->valid_descendants--;
+		p = p->parent;
+	}
+}
+
 static void
 node_free(struct rte_rib6 *rib, struct rte_rib6_node *ent)
 {
@@ -250,6 +277,7 @@ rte_rib6_remove(struct rte_rib6 *rib,
 
 	--rib->cur_routes;
 	cur->flag &= ~RTE_RIB_VALID_NODE;
+	dec_valid_descendants(cur);
 	while (!is_valid_node(cur)) {
 		if ((cur->left != NULL) && (cur->right != NULL))
 			return;
@@ -320,6 +348,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
 			*tmp = new_node;
 			new_node->parent = prev;
 			++rib->cur_routes;
+			inc_valid_descendants(new_node);
 			return *tmp;
 		}
 		/*
@@ -332,6 +361,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
 			node_free(rib, new_node);
 			(*tmp)->flag |= RTE_RIB_VALID_NODE;
 			++rib->cur_routes;
+			inc_valid_descendants(*tmp);
 			return *tmp;
 		}
 
@@ -371,6 +401,9 @@ rte_rib6_insert(struct rte_rib6 *rib,
 			new_node->left = *tmp;
 		new_node->parent = (*tmp)->parent;
 		(*tmp)->parent = new_node;
+		/* new_node inherits *tmp's subtree */
+		new_node->valid_descendants = (is_valid_node(*tmp) ? 1 : 0) +
+			(*tmp)->valid_descendants;
 		*tmp = new_node;
 	} else {
 		/* create intermediate node */
@@ -386,6 +419,11 @@ rte_rib6_insert(struct rte_rib6 *rib,
 		common_node->parent = (*tmp)->parent;
 		new_node->parent = common_node;
 		(*tmp)->parent = common_node;
+		/* common_node inherits *tmp's subtree (new_node will be
+		 * counted by inc_valid_descendants below).
+		 */
+		common_node->valid_descendants = (is_valid_node(*tmp) ? 1 : 0) +
+			(*tmp)->valid_descendants;
 		if (get_dir(&(*tmp)->ip, common_depth) == 1) {
 			common_node->left = new_node;
 			common_node->right = *tmp;
@@ -396,6 +434,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
 		*tmp = common_node;
 	}
 	++rib->cur_routes;
+	inc_valid_descendants(new_node);
 	return new_node;
 }
 
@@ -606,3 +645,44 @@ rte_rib6_free(struct rte_rib6 *rib)
 	rte_free(rib);
 	rte_free(te);
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_rib6_count_empty_supernets)
+uint8_t
+rte_rib6_count_empty_supernets(struct rte_rib6 *rib,
+	const struct rte_ipv6_addr *ip, uint8_t depth)
+{
+	uint8_t top = RTE_ALIGN_CEIL(depth, 8);
+	struct rte_rib6_node *cur;
+	bool has_descendant;
+	uint8_t level;
+
+	if (unlikely(rib == NULL || ip == NULL || depth > RTE_IPV6_MAX_DEPTH))
+		return 0;
+	if (depth <= 24)
+		return 0;
+
+	cur = rib->tree;
+
+	/* Single descent through the binary tree, checking each byte
+	 * boundary on the way. NULL at level L propagates upward, so we
+	 * stop at the first empty supernet and tally the remaining levels.
+	 */
+	for (level = 24; level < top; level += 8) {
+		while (cur != NULL && cur->depth < level)
+			cur = get_nxt_node(cur, ip);
+
+		if (cur == NULL || !rte_ipv6_addr_eq_prefix(&cur->ip, ip, level))
+			return (top - level) >> 3;
+
+		if (cur->depth > level)
+			has_descendant = is_valid_node(cur) ||
+				cur->valid_descendants > 0;
+		else
+			has_descendant = cur->valid_descendants > 0;
+
+		if (!has_descendant)
+			return (top - level) >> 3;
+	}
+	return 0;
+}
+
-- 
2.43.0

