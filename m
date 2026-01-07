Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4A9CF6BF4
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 08:00:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA0EF40267;
	Wed,  7 Jan 2026 09:00:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0B6084021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 09:00:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767772822; x=1799308822;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c40MJmVT6+drtGZrqu/wbspd6H6fioW8kjf75Xn7EyQ=;
 b=hgu8nz1DSkBk6vG6dlxzEKfaWdIGF3MYJ+iWSxQYkatCtO30akd7N09u
 3GRKQHDaoM7ar0qj+YyYTIN0l/1kdICuwz9k7H8Gb+Sb3s3tTPP3K2vzV
 jlOlbkYo0TtPODcDHdKeu4dIlOvlqca+FN8Dho2S2DY/IXUI8EmAw4EVT
 AhBpE7kg6NxDUIskRBkQuDdWHeiZBScDqaX69VLgbAdVRt+7v2nh5y69G
 dFOUaBjeRf4LOmgjGGQCV6iuZ9V7lRNmLpqE7VNFRZeMHQBWXJRt+I+H8
 AgLEoj5zntOKKgStVr4QSKue/LJzXWRfYk1VE46oXg9JS01Ep7R/xr1PP Q==;
X-CSE-ConnectionGUID: RMuye4WhRQaEPACAqsKHYA==
X-CSE-MsgGUID: 7YXVxpHGQkuc9+fEZOOPkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72992832"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="72992832"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 00:00:21 -0800
X-CSE-ConnectionGUID: xQHq7if9QMW2V2DvWyVk0w==
X-CSE-MsgGUID: sGMtlbDBQ4qGo1bDYIcJ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="203308789"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa009.fm.intel.com with ESMTP; 07 Jan 2026 00:00:18 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/intel: check raw item spec/mask for null
Date: Wed,  7 Jan 2026 13:29:05 +0530
Message-Id: <20260107075905.179912-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

adds explicit NULL pointer checks for the RAW flow item’s
spec and mask fields in both the IAVF and ICE PMDs.
This prevents potential null pointer dereferences
and provides clearer error reporting to the user.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c      |  9 +++++++++
 drivers/net/intel/iavf/iavf_fsub.c      |  8 ++++++++
 drivers/net/intel/iavf/iavf_hash.c      | 11 ++++++++++-
 drivers/net/intel/ice/ice_fdir_filter.c |  7 +++++++
 drivers/net/intel/ice/ice_hash.c        | 10 +++++++++-
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 3213464254..0ef6e0d04a 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -773,6 +773,15 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 			raw_spec = item->spec;
 			raw_mask = item->mask;
 
+			if (!raw_spec || !raw_mask) {
+				PMD_DRV_LOG(ERR, "NULL RAW spec/mask");
+				rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item,
+						"NULL RAW spec/mask");
+				return -rte_errno;
+			}
+
 			if (item_num != 1)
 				return -rte_errno;
 
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index eb5a3feab1..18df9c6500 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -185,6 +185,14 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 			raw_spec = item->spec;
 			raw_mask = item->mask;
 
+			if (!raw_spec || !raw_mask) {
+				PMD_DRV_LOG(ERR, "NULL RAW spec/mask");
+				rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item, "NULL RAW spec/mask");
+				return -rte_errno;
+			}
+
 			if (item_num != 1)
 				return -rte_errno;
 
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 217f0500ab..b433a89b3b 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -883,6 +883,7 @@ iavf_hash_parse_pattern(const struct rte_flow_item pattern[], uint64_t *phint,
 
 static int
 iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
+			struct rte_flow_error *error,
 			struct iavf_rss_meta *meta)
 {
 	const struct rte_flow_item_raw *raw_spec, *raw_mask;
@@ -895,6 +896,14 @@ iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
 	raw_spec = item->spec;
 	raw_mask = item->mask;
 
+	if (!raw_spec || !raw_mask) {
+		PMD_DRV_LOG(ERR, "NULL RAW spec/mask");
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "NULL RAW spec/mask");
+		return -rte_errno;
+	}
+
 	spec_len = strlen((char *)(uintptr_t)raw_spec->pattern);
 	if (strlen((char *)(uintptr_t)raw_mask->pattern) !=
 		spec_len)
@@ -1545,7 +1554,7 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 
 	if (phint == IAVF_PHINT_RAW) {
 		rss_meta_ptr->raw_ena = true;
-		ret = iavf_hash_parse_raw_pattern(pattern, rss_meta_ptr);
+		ret = iavf_hash_parse_raw_pattern(pattern, error, rss_meta_ptr);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 9dfe5c02cb..f7730ec6ab 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1853,6 +1853,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			raw_spec = item->spec;
 			raw_mask = item->mask;
 
+			if (!raw_spec || !raw_mask) {
+				rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item, "NULL RAW spec/mask");
+				return -rte_errno;
+			}
+
 			if (item_num != 1)
 				break;
 
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index aa6a21c055..afdc8f220a 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -641,6 +641,7 @@ ice_hash_parse_pattern(const struct rte_flow_item pattern[], uint64_t *phint,
 static int
 ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 				const struct rte_flow_item *item,
+				struct rte_flow_error *error,
 				struct ice_rss_meta *meta)
 {
 	const struct rte_flow_item_raw *raw_spec, *raw_mask;
@@ -658,6 +659,13 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 	raw_spec = item->spec;
 	raw_mask = item->mask;
 
+	if (!raw_spec || !raw_mask) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "NULL RAW spec/mask");
+		return -rte_errno;
+	}
+
 	spec_len = strnlen((char *)(uintptr_t)raw_spec->pattern,
 		raw_spec->length + 1);
 	if (spec_len != raw_spec->length)
@@ -1185,7 +1193,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 
 	if (phint == ICE_PHINT_RAW) {
 		rss_meta_ptr->raw.raw_ena = true;
-		ret = ice_hash_parse_raw_pattern(ad, pattern, rss_meta_ptr);
+		ret = ice_hash_parse_raw_pattern(ad, pattern, error, rss_meta_ptr);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
-- 
2.34.1

