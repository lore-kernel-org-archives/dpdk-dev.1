Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C88E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:24:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D29940672;
	Thu, 19 Feb 2026 17:23:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id D07DD4064A
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518207; x=1803054207;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GP6FRuWhdL3SZ+vcRtOyIxe4vB8kCIMgQZNFx+ZGet4=;
 b=bQyKItUmIfK9GNPrGIOBSgnmNuTwtKriqBgMjHsi1YFKyU7jTIFHig5N
 FgUqX0lZ8T3IHbnkPmH0eeLfPMEord17qSR/TkXrrcUrDXpfCFaW8m7ci
 raQtYnOEibytjt7gpCRN5hDLG0U2nhkPq4yDNnHkknjvvwIBDNUnTRt2C
 ebz+4h6ASHe2LlzolIYrTNsVEc431fxxcQtob8rZTZvdP+EEjk4u/OIJZ
 elserz9dy94ohqCagHSoFsB4LqwB+4KdCCYVbytaMg9qnK4p929ODa7yt
 ZNG3fiEKwabSjm6J/cKtz6iOeO+YOGmzVlUz5UDtfx9sXMF6A8Vn5zyy6 A==;
X-CSE-ConnectionGUID: 4McEu14ORh2a+PMuGmbBVA==
X-CSE-MsgGUID: geOZI/5fT3KF8nr+oNhyGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231434"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231434"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:27 -0800
X-CSE-ConnectionGUID: kMc84QvlRf6N6ONF4UzbPA==
X-CSE-MsgGUID: 4gHS/DeuRQmfbNQZeGvbbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699835"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 08/27] net/i40e: remove global pattern variable
Date: Thu, 19 Feb 2026 16:22:51 +0000
Message-ID: <f449669f73eda278559964d14759f2b38290c2bf.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index e611de0c06..2791139e59 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 
 #include <rte_debug.h>
 #include <rte_ether.h>
@@ -145,9 +146,6 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.query = i40e_flow_query,
 };
 
-/* internal pattern w/o VOID items */
-struct rte_flow_item g_items[32];
-
 /* Pattern matched ethertype filter */
 static enum rte_flow_item_type pattern_ethertype[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
@@ -3837,19 +3835,13 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3862,8 +3854,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
 					   pattern, "Unsupported pattern");
 
-			if (items != g_items)
-				rte_free(items);
+			free(items);
 			return -rte_errno;
 		}
 
@@ -3873,8 +3864,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
 
-	if (items != g_items)
-		rte_free(items);
+	free(items);
 
 	return ret;
 }
-- 
2.47.3

