Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D2CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 18:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C45402ED;
	Tue, 14 Oct 2025 20:18:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5D96A40288;
 Tue, 14 Oct 2025 20:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760465880; x=1792001880;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FjKHjoVaEvSRvR1cEU1VpS38FgOJZ4Ej7OphHa7wxbo=;
 b=UzpN1SSUr70yePbThp12A9eRWLr92PnIPID2d9fnBNtsKqxs0blQJ9CE
 6qPSNAvXxKShdg4FaipIf9lio2KUIzkX0WBwqStLQ095iZcxJ6+qptYDM
 UyTTjoXRgbF/LyUlVM4kq/apddHCmp/mQAC0tqZ+A5y2Y6SkjUk1ah0wZ
 /LsAhYml/XjzyNFAHCoFqcPOwAgUTvc0voR0YNcvpps3FwzLVHh2ITcEz
 n18mEXGSIHaW/pq/Aa17bm6IWdV4bH6wJVLhJjIKEV5/uQ2R6PoHDtSSJ
 pfUbFCa8MQkt5N94GKUNueVjjH0ASPljvrtxeu/6m0yN0/WAEIaWECwz/ A==;
X-CSE-ConnectionGUID: 4hGe2yblS6O393v9FE1ZOA==
X-CSE-MsgGUID: dWWyJPKGQhu6xGxH4qlEKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66286125"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="66286125"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 11:17:58 -0700
X-CSE-ConnectionGUID: 1nQRNbuGTSa1+kuqOPMbcg==
X-CSE-MsgGUID: qLWV7GreTEaPqRzld+SRLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="212571009"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa002.jf.intel.com with ESMTP; 14 Oct 2025 11:17:57 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	stable@dpdk.org
Subject: [PATCH 1/2] fib6: fix memory leak on delete operation
Date: Tue, 14 Oct 2025 18:17:54 +0000
Message-ID: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
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

When deleting a prefix, the first attempt to get next prefix cannot
return NULL as we will at a minimum get the prefix we are trying to
delete, whereas we were rather interested in whether there are other
prefixes within the same subtree, not counting the prefix we are
deleting. To address this, we check if we have found the exact prefix we
started with, and perform another search to see if there are more
prefixes to be found.

In addition to that, doing the searches with _COVER rather than _ALL is
incorrect, because if we are doing search with _COVER rather than _ALL, we
do not dive into the tree to find more specific prefixes within the
prefix we are going to delete, and thus will not notice if our subtree
also has more specific prefixes. To fix it, perform first (and
subsequent) searches with _ALL rather than _COVER.

Finally, when we hit the "tmp == NULL" branch (meaning, when we are
deleting the only node that exists in our subtree), we know that the
rib6_lookup will always return us the node that we are trying to delete,
but this is incorrect because further code will consider this to be our
parent node. Address this by doing another search to find the parent of
the current node.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index ff4c750952..5a9978b4ca 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -516,7 +516,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	struct rte_rib6_node *tmp = NULL;
 	struct rte_rib6_node *node;
 	struct rte_rib6_node *parent;
-	struct rte_ipv6_addr ip_masked;
+	struct rte_ipv6_addr ip_masked, tmp_ip;
 	int ret = 0;
 	uint64_t par_nh, node_nh;
 	uint8_t tmp_depth, depth_diff = 0, parent_depth = 24;
@@ -535,9 +535,25 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	if (depth > 24) {
 		tmp = rte_rib6_get_nxt(rib, &ip_masked,
 			RTE_ALIGN_FLOOR(depth, 8), NULL,
-			RTE_RIB6_GET_NXT_COVER);
+			RTE_RIB6_GET_NXT_ALL);
+		if (tmp && op == RTE_FIB6_DEL) {
+			/* in case of delete operation, skip the prefix we are going to delete */
+			rte_rib6_get_ip(tmp, &tmp_ip);
+			rte_rib6_get_depth(tmp, &tmp_depth);
+			if (rte_ipv6_addr_eq(&ip_masked, &tmp_ip) && depth == tmp_depth)
+				tmp = rte_rib6_get_nxt(rib, &ip_masked,
+					RTE_ALIGN_FLOOR(depth, 8), tmp, RTE_RIB6_GET_NXT_ALL);
+		}
+
 		if (tmp == NULL) {
 			tmp = rte_rib6_lookup(rib, ip);
+			/**
+			 * in case of delete operation, lookup returns the prefix
+			 * we are going to delete. Find the parent.
+			 */
+			if (tmp && op == RTE_FIB6_DEL)
+				tmp = rte_rib6_lookup_parent(tmp);
+
 			if (tmp != NULL) {
 				rte_rib6_get_depth(tmp, &tmp_depth);
 				parent_depth = RTE_MAX(tmp_depth, 24);
-- 
2.43.0

