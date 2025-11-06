Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D642CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 17:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6648E4021F;
	Thu,  6 Nov 2025 18:17:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6E6154013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 18:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762449460; x=1793985460;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fcso5rwdheQlbMiWN1+DIWDnWu6jNLwk+2TfVs01Bz4=;
 b=HcMUyd3y6kcs9aphCstiDGT5BKLcPeg6yHWplfuL4Xlg03Dr70+VWa7f
 /UEiZzPZ+6n2LFzptU+9ZG5hPHzz0UWm3akqwB0RSsonBqi1TA6FRovyJ
 sxeqLfptsvsHNbb1HudqlAalfMpWBYNVL3VhJiRb3QnjlL3SgYO/j8K6l
 zUz4qX2eHS/eSIYMgVxCt1NwuUzyeFCO1PuadKw67B4nYapnCfe0pb+Xd
 RNTIFX6r4pHVj551R3jNjEdaaQhRHWP34UspCgPXV6xAyeLfsFoHiAFiG
 Uag0xnl3A33GT567IPncKBBawgdrKFwPscjW4hRCXYU/ayg0AZd0DKvHD Q==;
X-CSE-ConnectionGUID: QxlydKsVTfe6bCZHta2KRw==
X-CSE-MsgGUID: 1Wjbhm6dRVuZZLtxRsAXiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75711385"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="75711385"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:17:39 -0800
X-CSE-ConnectionGUID: JhXGBl70Q/arVVUy4vayLA==
X-CSE-MsgGUID: j4CvQ3+7SXqX0dmAeHho4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="188094480"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 06 Nov 2025 09:17:38 -0800
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH] net/ice: adjust RSS LUT settings
Date: Thu,  6 Nov 2025 17:17:36 +0000
Message-ID: <20251106171736.163516-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
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

For E830 using global RSS LUT for PFs with a small number of
queues shows better performance than using per-PF RSS LUT. This patch
adds a condition to use global RSS LUT instead of PF LUT if number of
queues is less than 64.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 42 ++++++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  2 ++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..1c8540ef1d 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -104,6 +104,8 @@ enum ice_link_state_on_close {
 #define ICE_MAC_TC_MAX_WATERMARK	(((hw)->mac_type == ICE_MAC_E830) ?	\
 				ICE_MAC_E830_MAX_WATERMARK : ICE_MAC_E810_MAX_WATERMARK)
 
+#define ICE_RSS_LUT_GLOBAL_QUEUE_NB	64
+
 static int ice_dev_configure(struct rte_eth_dev *dev);
 static int ice_dev_start(struct rte_eth_dev *dev);
 static int ice_dev_stop(struct rte_eth_dev *dev);
@@ -3769,11 +3771,47 @@ static int ice_init_rss(struct ice_pf *pf)
 	for (i = 0; i < vsi->rss_lut_size; i++)
 		vsi->rss_lut[i] = i % nb_q;
 
+	if (nb_q <= ICE_RSS_LUT_GLOBAL_QUEUE_NB && (hw)->mac_type == ICE_MAC_E830) {
+		struct ice_vsi_ctx vsi_ctx;
+		uint16_t global_lut;
+
+		if (!vsi->global_lut_allocated) {
+			ret = ice_alloc_rss_global_lut(hw, false, &global_lut);
+			if (ret)
+				goto out;
+			vsi->global_lut_allocated = true;
+			vsi->global_lut_id = global_lut;
+		}
+		global_lut = vsi->global_lut_id;
+
+		vsi_ctx.flags = ICE_AQ_VSI_TYPE_PF;
+		vsi_ctx.info = vsi->info;
+		vsi_ctx.info.q_opt_rss &= ICE_AQ_VSI_Q_OPT_RSS_LUT_M |
+					ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M;
+		vsi_ctx.info.q_opt_rss |= ICE_AQ_VSI_Q_OPT_RSS_LUT_GBL |
+			((global_lut << ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_S) &
+			 ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M);
+
+		vsi_ctx.info.valid_sections =
+			rte_cpu_to_le_16(ICE_AQ_VSI_PROP_Q_OPT_VALID);
+
+		ret = ice_update_vsi(hw, vsi->idx, &vsi_ctx, NULL);
+		if (ret != ICE_SUCCESS) {
+			PMD_INIT_LOG(ERR, "update vsi failed, err = %d", ret);
+			goto out;
+		}
+
+		vsi->info = vsi_ctx.info;
+		lut_params.lut_type = ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_GLOBAL;
+		lut_params.global_lut_id = global_lut;
+	} else {
+		lut_params.lut_type = ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF;
+		lut_params.global_lut_id = 0;
+	}
+
 	lut_params.vsi_handle = vsi->idx;
 	lut_params.lut_size = vsi->rss_lut_size;
-	lut_params.lut_type = ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF;
 	lut_params.lut = vsi->rss_lut;
-	lut_params.global_lut_id = 0;
 	ret = ice_aq_set_rss_lut(hw, &lut_params);
 	if (ret)
 		goto out;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 6478d6dfbd..efa90cf39a 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -333,6 +333,8 @@ struct ice_vsi {
 	uint8_t vlan_anti_spoof_on; /* The VLAN anti-spoofing enabled */
 	uint8_t vlan_filter_on; /* The VLAN filter enabled */
 	/* information about rss configuration */
+	uint8_t global_lut_allocated : 1;
+	uint8_t global_lut_id : 7;
 	u32 rss_key_size;
 	u32 rss_lut_size;
 	uint8_t *rss_lut;
-- 
2.43.0

