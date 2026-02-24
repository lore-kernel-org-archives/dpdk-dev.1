Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA5E9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5530640B92;
	Tue, 24 Feb 2026 13:24:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D11084068A
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935845; x=1803471845;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WKITX3Fs3abQF5bMmO74jo91dBgRF0L1povID0W4f0I=;
 b=bG5S3zNl3uBWNc4HJkP388IFWt5PoruEdUD/w7GCA+F+tdi77Y8SrVw/
 YYAxwO8u94fIS6kZwiKDADoKcrjW0FxKxadS/2Dg82xVg/yCWwrib3pWE
 Y4ZxULi9Log1nzU36+xMSo9FBmNZcAE0iSBzpYbYZIr1/XRxODpg+eOrv
 lvzEgAC6SUt/31q4Ja0EnoQL9F0h1WFufZ010pLPKm1M0rOPDCf3FvoLO
 eX/h0N/4VhfDFqW4rHi+pEZdpAjS+0w5yB+SzQIfhQh8+EL+HUXfknJVO
 H3jR4/u75P6YaSlggx/UMUj6ZH4KiHBisglSM5O6h4PqHHoQusoemReLL A==;
X-CSE-ConnectionGUID: Rtndo4WAT+WbUEresjSfFQ==
X-CSE-MsgGUID: FakoWldkQCaVpfUYw12Arw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158145"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:24:05 -0800
X-CSE-ConnectionGUID: XSAfFYRhRnyqwBIliXwOiQ==
X-CSE-MsgGUID: gma4IcTQTVigKxTR7BC69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854489"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:24:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 23/26] net/ice: avoid rte malloc in RSS RETA operations
Date: Tue, 24 Feb 2026 12:23:32 +0000
Message-ID: <ad40f003fc9fb9d977c020f3fb307e0f9a5cb843.1771935744.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771935744.git.anatoly.burakov@intel.com>
 <cover.1771935744.git.anatoly.burakov@intel.com>
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

