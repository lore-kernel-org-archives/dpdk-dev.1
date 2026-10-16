Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D0CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F64E4067A;
	Fri, 16 Oct 2026 16:02:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7B766400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159348; x=1823695348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lUpITLqSTPub/HvXAaDGg2WQ8n3YIECSUR6KKNJN+VA=;
 b=Sx7GMUExbnyznBxvrQ/NpCrVZeQYjjLA4kqKBwJK97vIFBSFP/70sIaY
 U25HSV/8K67p/XGOm7CZuw3aecPurDVwkddXcKSvf3BowKsOW4Hrh1kaF
 aEJ7I6U9R69nlW+5LyeJNfIj9gV0OZv5yj439yF9ghXO3UCg1X1P/dg8t
 /pg3WZGlUu9uJB06P3dcyv7RLQekIgeRoi9J93EYgp20Ha3/QHK8PEaiQ
 Hq3xtdud9P0YzFfrD0VR+8fUx2VDnHs6ZoHm7PVjmLuRHLUqIDdiOXWZq
 TTTun5eAbIHQhGVW70kQfnoYHj8JGQSD39v8njNSjKSm6fkOemdusZ3xg g==;
X-CSE-ConnectionGUID: eTpO184LQ1+E56EVqdQ8cw==
X-CSE-MsgGUID: 4uekuP0VQFKUBiQ+q0EKeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043671"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:25 -0700
X-CSE-ConnectionGUID: Jx9pQPl0Q36oRAEEXaO49A==
X-CSE-MsgGUID: aKl0EJLGS/6+y/gCH/rK5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951683"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [27.03 RFC PATCH v1 5/8] acl: use usage counters for ref counting
Date: Fri, 16 Oct 2026 15:02:12 +0100
Message-ID: <4bcaf123a11ef7c64b34d8951859f258bbd0b012.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
References: 
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

Replace raw integer refcounts with EAL usage counters.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/acl/acl.h     | 4 +++-
 lib/acl/acl_bld.c | 9 ++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/acl/acl.h b/lib/acl/acl.h
index e1ecd1567b..8159915ea3 100644
--- a/lib/acl/acl.h
+++ b/lib/acl/acl.h
@@ -5,6 +5,8 @@
 #ifndef	_ACL_H_
 #define	_ACL_H_
 
+#include <rte_usage_count.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif /* __cplusplus */
@@ -104,7 +106,7 @@ struct rte_acl_match_results {
 struct rte_acl_node {
 	uint64_t node_index;  /* index for this node */
 	uint32_t level;       /* level 0-n in the trie */
-	uint32_t ref_count;   /* ref count for this node */
+	rte_usage_count_t ref_count; /* ref count for this node */
 	struct rte_acl_bitset  values;
 	/* set of all values that map to another node
 	 * (union of bits in each transition.
diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 99d1dbc467..60ca33a077 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -296,7 +296,7 @@ acl_add_ptr(struct acl_build_context *context,
 			acl_include(&node->ptrs[n].values, bits, 0);
 			acl_include(&node->values, bits, -1);
 			if (ptr != NULL)
-				ptr->ref_count++;
+				rte_usage_count_claim(&ptr->ref_count);
 			if (node->num_ptrs <= n)
 				node->num_ptrs = n + 1;
 			return 0;
@@ -411,7 +411,7 @@ acl_dup_node(struct acl_build_context *context, struct rte_acl_node *node)
 	for (n = 0; n < node->num_ptrs; n++) {
 		if (node->ptrs[n].ptr != NULL) {
 			next->ptrs[n].ptr = node->ptrs[n].ptr;
-			next->ptrs[n].ptr->ref_count++;
+			rte_usage_count_claim(&next->ptrs[n].ptr->ref_count);
 			acl_include(&next->ptrs[n].values,
 				&node->ptrs[n].values, -1);
 		}
@@ -449,8 +449,7 @@ acl_deref_ptr(struct acl_build_context *context,
 	/* De-reference the node at the specified pointer */
 	if (node != NULL && node->ptrs[index].ptr != NULL) {
 		ref_node = node->ptrs[index].ptr;
-		ref_node->ref_count--;
-		if (ref_node->ref_count == 0)
+		if (rte_usage_count_release(&ref_node->ref_count))
 			acl_free_node(context, ref_node);
 	}
 }
@@ -966,7 +965,7 @@ build_trie(struct acl_build_context *context, struct rte_acl_build_rule *head,
 
 		root = acl_alloc_node(context, 0);
 
-		root->ref_count = 1;
+		rte_usage_count_claim(&root->ref_count);
 		end = root;
 
 		for (n = 0; n < rule->config->num_fields; n++) {
-- 
2.52.0

