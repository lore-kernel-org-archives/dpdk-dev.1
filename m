Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674DEE6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:15:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E684F40269;
	Tue, 17 Feb 2026 13:14:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C605A4066E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330488; x=1802866488;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tpY1zZUfX3dXSxSwbKfunr75qqqj8SlbcuNCgEm0poA=;
 b=DqqvRGLmMKSKi1OPc1kUeTcKkGR5U+qX+8G20ahgXnmqqnk/gvnopsrP
 BTTqAOa96+3wBHR4bWIDsRvbWeAsXmAJCaDLUOlOLeUpIQFl8grSYmGGP
 9vRAIRaqcpGh7+8z8ld0DNXvGhh4S0t9IJgSxNq0B8Ss0eLjERbnQQnXi
 AQHtuFbeFKZ/eimWQIC+jDDLFqjytuPhah97l4/gi8i3g8HNn9HpCo4wk
 xXKpafMO5XPRP7Zayq08BEgq7lWOt9uS+YN5+eQnS8u0OY5wzEQ1xqRrT
 LE8QzpahBtzKbiabfjo02MsOUTD1zJnn44n7A4Dm9I5TM4JSY4CyhLioV g==;
X-CSE-ConnectionGUID: WEtzOlIHRSSy4NDu3arPyw==
X-CSE-MsgGUID: lzT5HM3iTKO/vkw9BzWymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996026"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996026"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:47 -0800
X-CSE-ConnectionGUID: nRf5gEc0Rvi/sKK7ftSg2g==
X-CSE-MsgGUID: b/4vqio6RmKiLgXeCEztCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396789"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 08/27] net/i40e: remove global pattern variable
Date: Tue, 17 Feb 2026 12:13:57 +0000
Message-ID: <8602d4158b18913dc7d1be64224013d11cae9661.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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

When parsing flow patterns, current code cleans up the pattern list by
removing void flow items, and copies the patterns into an array. That
array, when dealing with under 32 flow items, is allocated on the stack,
but when the pattern is big enough, a new list is dynamically allocated.
This allocated list is a global variable, and is allocated using
rte_zmalloc call which seems like overkill for this use case.

Remove the global variable, and replace the split behavior with
unconditional allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index e611de0c06..c5bb787f28 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -145,9 +145,6 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.query = i40e_flow_query,
 };
 
-/* internal pattern w/o VOID items */
-struct rte_flow_item g_items[32];
-
 /* Pattern matched ethertype filter */
 static enum rte_flow_item_type pattern_ethertype[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
@@ -3837,19 +3834,13 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		i++;
 	}
 	item_num++;
-
-	if (item_num <= ARRAY_SIZE(g_items)) {
-		items = g_items;
-	} else {
-		items = rte_zmalloc("i40e_pattern",
-				    item_num * sizeof(struct rte_flow_item), 0);
-		if (!items) {
-			rte_flow_error_set(error, ENOMEM,
-					RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-					NULL,
-					"No memory for PMD internal items.");
-			return -ENOMEM;
-		}
+	items = calloc(item_num, sizeof(struct rte_flow_item));
+	if (items == NULL) {
+		rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_ITEM_NUM,
+				NULL,
+				"No memory for PMD internal items.");
+		return -ENOMEM;
 	}
 
 	i40e_pattern_skip_void_item(items, pattern);
@@ -3862,8 +3853,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
 					   pattern, "Unsupported pattern");
 
-			if (items != g_items)
-				rte_free(items);
+			free(items);
 			return -rte_errno;
 		}
 
@@ -3873,8 +3863,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
 
-	if (items != g_items)
-		rte_free(items);
+	free(items);
 
 	return ret;
 }
-- 
2.47.3

