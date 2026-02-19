Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1302DE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:26:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE4A40DD2;
	Thu, 19 Feb 2026 17:24:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id BB8D54060C
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518227; x=1803054227;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ILeyLa9zuohOpJbdBayRbTckRAg/7i3v46YPLqgpL7c=;
 b=Jc8YdR03Q4MMOFLmnTsfcZXToFPDNLV+RiA2A8RGeAG5xB3xBvbkK5+I
 sYlwaUdHiJgSY5Zp9/yiNFQNHnCQu8JBr56qa7ILlYJinFHzr9O+AIs8Y
 nY+1v6xKzlLpM28icoFuQsFHAjHv23JUVh+Zlsb+UjqLtv4SsmGxgSLvE
 5ctuhMW5cyhtF5EftM2IP2EuEG7hJeRSsqXKUTFNxX42smRfUpRUqleES
 9vKCJ809Fk83cAgp4x0aCP3GL53rMl0M5C+TeEwdJxvClSQY7HbZUb4nz
 pNHylRkoha92UGw2WPswodocVghrTbq4Q8ViFxjKMScMhalqsIMyqf5cG A==;
X-CSE-ConnectionGUID: N83+sbQyR8GlF9e087hf/g==
X-CSE-MsgGUID: 8WHZPvmXQ96sgO1cX2SkBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231478"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231478"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:47 -0800
X-CSE-ConnectionGUID: tfhIdXERSmmo20xdSZhRXQ==
X-CSE-MsgGUID: gh4I2GeGQl2m2Mz/f+Xk/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218700051"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 27/27] net/ice: avoid rte malloc in flow pattern match
Date: Thu, 19 Feb 2026 16:23:10 +0000
Message-ID: <f71aa535c3acd188c906c7e5352ce7837dd6bd4b.1771518103.git.anatoly.burakov@intel.com>
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
index 5f44b5c818..8cca831fa9 100644
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

