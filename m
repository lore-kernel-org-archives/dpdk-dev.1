Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD98F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 974EE40DD2;
	Tue, 24 Feb 2026 16:15:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 78D5D4027F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946105; x=1803482105;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nefms4ZJM2HWpsXL4OnZ/WUxQQczQE2FoLoDu1tNOW0=;
 b=nY+gEp+vCbFNgIDQMc9vScnzU84qPq9l8rHdEQDbY8rgcY3+xNQQR81q
 axiLvwjoY1eaCchJV1kRcNAwtdMdP47B31V1WcEFGU/sv1/FHLIwlumDt
 /iPRx0SwhMAMXGZfKvkzHDW6nql++uxNiU7lqZ/6yRPEHFiLstJH4U/Fw
 5lwCd1aZCiNIA8AQC83Z2RgU0ynogVlpH1+f3zzAM943Mx3DeEczX1gdD
 uIuFe1j5vYtFenTlvruzp4PvHNv4SIyMnmlzMP7D4J1FNDceqs3q5QePK
 nyLmtyWXEzRAUvhwoyqW+wFGwJOGYAoxNrqGJyRXtiaN7bVbMCGdr9xrX Q==;
X-CSE-ConnectionGUID: aadQOYZ8T4mpqOrTy+MAjA==
X-CSE-MsgGUID: Uk6gNBFaS8+xc2yPPoC53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056281"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056281"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:15:05 -0800
X-CSE-ConnectionGUID: YkJeu8NoTx66RC0wPfovWA==
X-CSE-MsgGUID: qh+ZUlg9Q2Sm/iiiOjn4Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526269"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:15:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 26/26] net/ice: avoid rte malloc in flow pattern match
Date: Tue, 24 Feb 2026 15:14:31 +0000
Message-ID: <9e693ae2ed0890f0e3f122211a86cee7344e7617.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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

Currently, when allocating buffers for pattern match items and flow item
storage, we are using rte_zmalloc followed by immediate rte_free. This
memory does not need to be stored in hugepage memory, so replace it with
regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    |  3 ++-
 drivers/net/intel/ice/ice_fdir_filter.c   |  5 +++--
 drivers/net/intel/ice/ice_generic_flow.c  | 15 +++++++--------
 drivers/net/intel/ice/ice_hash.c          |  3 ++-
 drivers/net/intel/ice/ice_switch_filter.c |  5 +++--
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 38e30a4f62..6754a40044 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
@@ -1009,7 +1010,7 @@ ice_acl_parse(struct ice_adapter *ad,
 		*meta = filter;
 
 error:
-	rte_free(item);
+	free(item);
 	return ret;
 }
 
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 0b92b9ab38..93ab803b44 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <rte_flow.h>
 #include <rte_hash.h>
 #include <rte_hash_crc.h>
@@ -2845,11 +2846,11 @@ ice_fdir_parse(struct ice_adapter *ad,
 		rte_free(filter->pkt_buf);
 	}
 
-	rte_free(item);
+	free(item);
 	return ret;
 error:
 	rte_free(filter->pkt_buf);
-	rte_free(item);
+	free(item);
 	return ret;
 }
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 644958cccf..62f0c334a1 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 
 #include <rte_ether.h>
 #include <ethdev_driver.h>
@@ -2313,19 +2314,17 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 	}
 	item_num++;
 
-	items = rte_zmalloc("ice_pattern",
-			    item_num * sizeof(struct rte_flow_item), 0);
+	items = calloc(item_num, sizeof(struct rte_flow_item));
 	if (!items) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
 				   NULL, "No memory for PMD internal items.");
 		return NULL;
 	}
-	pattern_match_item = rte_zmalloc("ice_pattern_match_item",
-			sizeof(struct ice_pattern_match_item), 0);
+	pattern_match_item = calloc(1, sizeof(struct ice_pattern_match_item));
 	if (!pattern_match_item) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "Failed to allocate memory.");
-		rte_free(items);
+		free(items);
 		return NULL;
 	}
 
@@ -2344,7 +2343,7 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 			pattern_match_item->pattern_list =
 				array[i].pattern_list;
 			pattern_match_item->meta = array[i].meta;
-			rte_free(items);
+			free(items);
 			return pattern_match_item;
 		}
 	}
@@ -2352,8 +2351,8 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 unsupported:
 	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 			   pattern, "Unsupported pattern");
-	rte_free(items);
-	rte_free(pattern_match_item);
+	free(items);
+	free(pattern_match_item);
 	return NULL;
 }
 
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index f9db530504..77829e607b 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 
 #include <rte_debug.h>
 #include <rte_ether.h>
@@ -1236,7 +1237,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 		*meta = rss_meta_ptr;
 	else
 		rte_free(rss_meta_ptr);
-	rte_free(pattern_match_item);
+	free(pattern_match_item);
 
 	return ret;
 }
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 28bc775a2c..b25e5eaad3 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
@@ -1877,14 +1878,14 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		rte_free(sw_meta_ptr);
 	}
 
-	rte_free(pattern_match_item);
+	free(pattern_match_item);
 
 	return 0;
 
 error:
 	rte_free(list);
 	rte_free(sw_meta_ptr);
-	rte_free(pattern_match_item);
+	free(pattern_match_item);
 
 	return -rte_errno;
 }
-- 
2.47.3

