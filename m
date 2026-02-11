Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F52AE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B699140E3F;
	Wed, 11 Feb 2026 14:54:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 154DC40E0F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818045; x=1802354045;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FSdwF8j+2z0l9xr/RmXZdQitUXFV2sNiX7temLy55UA=;
 b=kOBi7Xc0Xpmaa8OTK+6yWwv2C1h6v7pQASfplxdloYWR8D59c0hG6TmG
 k4PHgWqtYgg82mtkld0RQE65LSapjSuDrpUUE+UmcBJF7vYqlApQUzKvz
 h384BFKv64wzki/wVNtDqYpYcY0anKeugupdXOwqdSYq7mQDg4n2XABkw
 CvHA4gsbYATK0ccrKWOIu3iE7rft/zXEBLOnSVTA/HrIGYNzQg1fepZ1v
 8SGn4XbEduinTcsFwtKy5ym+suIrSSQGujmKw5d+4bxQBwUSyryIoWht3
 lDjyF2V/Wq5LP4+QOJzsMZwvGfrHfJahsSYm9QpaS+dwk2wg4eUW3ZIDj Q==;
X-CSE-ConnectionGUID: EwQ5iNrDQzGFfXw+thKV1w==
X-CSE-MsgGUID: C/PCPvqpQK+bP5VSv2QJqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808290"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808290"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:54:04 -0800
X-CSE-ConnectionGUID: QJmasAxNSs6EPbRUQQAAAg==
X-CSE-MsgGUID: wJ6iuEtcRhWc8AJCSGE4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359718"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:54:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 27/27] net/ice: avoid rte malloc in flow pattern match
Date: Wed, 11 Feb 2026 13:53:09 +0000
Message-ID: <c2fd41801eaf6c177cd812a49fac9c6dc97a0985.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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
storage, we are using rte_zmalloc followed by immediate rte_free. This is
not needed as these buffers are only used temporarily within the function
scope, so replace it with regular calloc/free.

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
index 3db13dba96..62f1257e27 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <rte_flow.h>
 #include <rte_hash.h>
 #include <rte_hash_crc.h>
@@ -2504,11 +2505,11 @@ ice_fdir_parse(struct ice_adapter *ad,
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
index 4049157eab..3f7a9f4714 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 
 #include <rte_ether.h>
 #include <ethdev_driver.h>
@@ -2136,19 +2137,17 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
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
 
@@ -2167,7 +2166,7 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 			pattern_match_item->pattern_list =
 				array[i].pattern_list;
 			pattern_match_item->meta = array[i].meta;
-			rte_free(items);
+			free(items);
 			return pattern_match_item;
 		}
 	}
@@ -2175,8 +2174,8 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
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
index 854c6e8dca..1174c505da 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdlib.h>
 
 #include <rte_debug.h>
 #include <rte_ether.h>
@@ -1211,7 +1212,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
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

