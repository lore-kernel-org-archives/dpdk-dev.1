Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E47C5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD9E040E13;
	Fri, 20 Feb 2026 11:15:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 37F9F40A8A
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582518; x=1803118518;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WKITX3Fs3abQF5bMmO74jo91dBgRF0L1povID0W4f0I=;
 b=ah34km2x9VfVVSbCtxHX1UWPw1op+N1+q2j1e8j4cRtuLP8u5P0J+pUi
 gkSXoYrl8IN9hDMhJU2qHR89dW2C3Kv/6Dg8cbmGWFdSJBB8Z+X/lFBQE
 51LUKab8a3Gh3N7x5GUFWqXMPZeSdrihRNwDBSQtdrw1xfQYc9ercuEk5
 GbatTZOPxQYmlyBz4VBg/sjmaMyVXNpUQ/WjCzHhAU/Nzw+I73NMeQ9vQ
 tsb02/2t1uhDcuAsJid+mdrwgcTxoorVfI3rBf0wnuApHW7wCyz80y6pJ
 rknHwty+TKVvbOLwEfLvC76B3LLMvWIYjYlisr66+63Gvgefj6v6PyEQC w==;
X-CSE-ConnectionGUID: dSr1nkPGSFeAbg0TyA9XnQ==
X-CSE-MsgGUID: PLecofV9QB6H1orEjY2qNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283373"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283373"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:18 -0800
X-CSE-ConnectionGUID: zXgrFccLQzeShqu45gQ0IQ==
X-CSE-MsgGUID: kd+7yOQSQhWeHGBl1VSwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038574"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 24/27] net/ice: avoid rte malloc in RSS RETA operations
Date: Fri, 20 Feb 2026 10:14:31 +0000
Message-ID: <b78682aa5b7d838f3ceff0a0aa6f17d477c0de8b.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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

Currently, when updating or querying RSS redirection table (RETA), we
are using rte_zmalloc followed by an immediate rte_free. This memory does
not need to be stored in hugepage memory, so replace it with stack
allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c |  4 ++--
 drivers/net/intel/ice/ice_ethdev.c     | 29 ++++++--------------------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index abd7875e7b..388495d69c 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1336,7 +1336,7 @@ ice_dcf_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -1356,7 +1356,7 @@ ice_dcf_dev_rss_reta_update(struct rte_eth_dev *dev,
 	ret = ice_dcf_configure_rss_lut(hw);
 	if (ret) /* revert back */
 		rte_memcpy(hw->rss_lut, lut, reta_size);
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 41474b7002..0d6b030536 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -5564,7 +5564,7 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint16_t i, lut_size = pf->hash_lut_size;
 	uint16_t idx, shift;
-	uint8_t *lut;
+	uint8_t lut[ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K] = {0};
 	int ret;
 
 	if (reta_size != ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128 &&
@@ -5581,14 +5581,9 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 	/* It MUST use the current LUT size to get the RSS lookup table,
 	 * otherwise if will fail with -100 error code.
 	 */
-	lut = rte_zmalloc(NULL,  RTE_MAX(reta_size, lut_size), 0);
-	if (!lut) {
-		PMD_DRV_LOG(ERR, "No memory can be allocated");
-		return -ENOMEM;
-	}
 	ret = ice_get_rss_lut(pf->main_vsi, lut, lut_size);
 	if (ret)
-		goto out;
+		return ret;
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -5604,10 +5599,7 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 		pf->hash_lut_size = reta_size;
 	}
 
-out:
-	rte_free(lut);
-
-	return ret;
+	return 0;
 }
 
 static int
@@ -5618,7 +5610,7 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint16_t i, lut_size = pf->hash_lut_size;
 	uint16_t idx, shift;
-	uint8_t *lut;
+	uint8_t lut[ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K] = {0};
 	int ret;
 
 	if (reta_size != lut_size) {
@@ -5630,15 +5622,9 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc(NULL, reta_size, 0);
-	if (!lut) {
-		PMD_DRV_LOG(ERR, "No memory can be allocated");
-		return -ENOMEM;
-	}
-
 	ret = ice_get_rss_lut(pf->main_vsi, lut, reta_size);
 	if (ret)
-		goto out;
+		return ret;
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -5647,10 +5633,7 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 			reta_conf[idx].reta[shift] = lut[i];
 	}
 
-out:
-	rte_free(lut);
-
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.47.3

