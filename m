Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA100F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F41F40C35;
	Tue, 24 Feb 2026 16:15:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4EFF440612
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946102; x=1803482102;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WKITX3Fs3abQF5bMmO74jo91dBgRF0L1povID0W4f0I=;
 b=PC+2W8qAfSVUGLuvXxcJA2bjFrO1obd78YfgDyPloSeoApUke/NboLRZ
 68/UP1fNpFI3mvxrEotnK9Ouc3hFqBaK8hiD2DgHu9MJrH6Aq0OTwmPQY
 MRzmaWibxvtSVbu6hEF9bWJz/X610AhuryVZtnB4ElT1ZH9qMn84JsGCM
 UcexMlFfWAnYbVWbhPwPRwvU7Os8ypD3WAZqSVzb0YYLh807bk8SFNg9U
 tpWWFcHNpXDePn9ulTW2NlXVlXr5XvdnchVCkUM/cGZcz9cSrOwiORotS
 8bNarAqg9vZvAwBNrHSwGf4UJcerhTZWQOU4Ldo19hojDG2yoaDUb+el1 A==;
X-CSE-ConnectionGUID: cNP4dMe4QfyNh8hif9RNgA==
X-CSE-MsgGUID: O8ratVzPQA6rRBBteoeflg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056277"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056277"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:15:02 -0800
X-CSE-ConnectionGUID: rYAmFoxWTEmLCEsiL+7BwA==
X-CSE-MsgGUID: rfIvBmmkTCaSz7TwI92XWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526241"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:15:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 23/26] net/ice: avoid rte malloc in RSS RETA operations
Date: Tue, 24 Feb 2026 15:14:28 +0000
Message-ID: <65ebb6bc737a471d661d1e951648a76ebcbcd351.1771945933.git.anatoly.burakov@intel.com>
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

