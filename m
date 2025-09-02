Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8638CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F234E406B8;
	Tue,  2 Sep 2025 19:27:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id D93EA4066A
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834047; x=1788370047;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Gu4Ilp8USuqS+FUDT/YfW5e94paQKjRMQbtj4xgBgWM=;
 b=jsFa8ZzZTTAFsFphpmeNZkVNTcR7blv+Hy/fEEjxil999+3J6ytfP7es
 lJiLbbvkS64hbbsr2FJ2CZlXWw8Q23tGfxGZY+ThCXRF8NTmym0hgZv8J
 hPV/+QXnkc+GeHwKNz1uki+les9dqTgVjmq4EiMjOH6P+tg171Qk8xWtY
 kL5RV6HwBbjH1Bm525TD29x3lSCk5YuqzeaatXhodUDzDJxpDH3cHJmXR
 HEviyERrv+l6ruoe8miRMQ+HDSFbXhjp4PHmIVR8+uxZiucUtaK1IUwYe
 b3JzAdSuPpoJKfIRLSXXhzagyrO02Cu8cEKT69HTvmOYFXTy9A6hNm7I/ w==;
X-CSE-ConnectionGUID: lE95gIfQQL+HhnGgCNT7YA==
X-CSE-MsgGUID: iFZ8mKcYSV+QIwMaVjWAew==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731993"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731993"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:20 -0700
X-CSE-ConnectionGUID: s2XuD4GyRTiCabHZpNh7xA==
X-CSE-MsgGUID: cHYwBcAxSZiq6WDOjk79bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229117"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 05/12] net/ice/base: clean up RSS LUT selection
Date: Tue,  2 Sep 2025 18:26:55 +0100
Message-ID: <247421eff2190715c8ec74663620698757b11c5b.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
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

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Refactor __ice_aq_get_set_rss_lut():
- Use enumeration to specify different available LUT sizes
- Use enumeration to specify different LUT types
- Refactor setting/validating various LUT settings
- Use params->lut_size and params->lut_type to communicate LUT size

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_adminq_cmd.h |  18 ++-
 drivers/net/intel/ice/base/ice_common.c     | 124 ++++++++++----------
 2 files changed, 81 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_adminq_cmd.h b/drivers/net/intel/ice/base/ice_adminq_cmd.h
index 1fa8bbad29..a5817daca9 100644
--- a/drivers/net/intel/ice/base/ice_adminq_cmd.h
+++ b/drivers/net/intel/ice/base/ice_adminq_cmd.h
@@ -2385,6 +2385,20 @@ struct ice_aqc_get_set_rss_keys {
 	u8 extended_hash_key[ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE];
 };
 
+enum ice_lut_type {
+	ICE_LUT_VSI = 0,
+	ICE_LUT_PF = 1,
+	ICE_LUT_GLOBAL = 2,
+	ICE_LUT_TYPE_MASK = 3
+};
+
+enum ice_lut_size {
+	ICE_LUT_SIZE_64 = 64,
+	ICE_LUT_SIZE_128 = 128,
+	ICE_LUT_SIZE_512 = 512,
+	ICE_LUT_SIZE_2048 = 2048,
+};
+
 /* Get/Set RSS LUT (indirect 0x0B05/0x0B03) */
 struct ice_aqc_get_set_rss_lut {
 #define ICE_AQC_GSET_RSS_LUT_VSI_VALID	BIT(15)
@@ -2393,7 +2407,7 @@ struct ice_aqc_get_set_rss_lut {
 	__le16 vsi_id;
 #define ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_S	0
 #define ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_M	\
-				(0x3 << ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_S)
+		(ICE_LUT_TYPE_MASK << ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_S)
 
 #define ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_VSI	 0
 #define ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF	 1
@@ -2401,7 +2415,7 @@ struct ice_aqc_get_set_rss_lut {
 
 #define ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S	 2
 #define ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M	 \
-				(0x3 << ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S)
+		(ICE_LUT_TYPE_MASK << ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S)
 
 #define ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128	 128
 #define ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG 0
diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index dfc2fd69e7..8be56f0aab 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -4332,6 +4332,50 @@ ice_aq_read_topo_dev_nvm(struct ice_hw *hw,
 	return 0;
 }
 
+static u16 ice_lut_is_valid_size(u16 lut_type, u16 lut_size)
+{
+	switch (lut_type) {
+	case ICE_LUT_VSI:
+		return lut_size == ICE_LUT_SIZE_64;
+	case ICE_LUT_GLOBAL:
+		switch (lut_size) {
+		case ICE_LUT_SIZE_128:
+		case ICE_LUT_SIZE_512:
+			return true;
+		default:
+			return false;
+		}
+	case ICE_LUT_PF:
+		switch (lut_size) {
+		case ICE_LUT_SIZE_128:
+		case ICE_LUT_SIZE_512:
+		case ICE_LUT_SIZE_2048:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+}
+
+static u16 ice_lut_size_to_flag(u16 lut_size)
+{
+	u16 f = 0;
+
+	switch (lut_size) {
+	case ICE_LUT_SIZE_512:
+		f = ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512_FLAG;
+		break;
+	case ICE_LUT_SIZE_2048:
+		f = ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG;
+		break;
+	default:
+		break;
+	}
+	return f << ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S;
+}
+
 /**
  * __ice_aq_get_set_rss_lut
  * @hw: pointer to the hardware structure
@@ -4343,7 +4387,7 @@ ice_aq_read_topo_dev_nvm(struct ice_hw *hw,
 static int
 __ice_aq_get_set_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *params, bool set)
 {
-	u16 flags = 0, vsi_id, lut_type, lut_size, glob_lut_idx, vsi_handle;
+	u16 flags, vsi_id, lut_type, lut_size, glob_lut_idx = 0, vsi_handle;
 	struct ice_aqc_get_set_rss_lut *cmd_resp;
 	struct ice_aq_desc desc;
 	int status;
@@ -4355,15 +4399,23 @@ __ice_aq_get_set_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params
 	vsi_handle = params->vsi_handle;
 	lut = params->lut;
 
-	if (!ice_is_vsi_valid(hw, vsi_handle) || !lut)
-		return ICE_ERR_PARAM;
-
+	lut_type = params->lut_type;
 	lut_size = params->lut_size;
 	lut_type = params->lut_type;
-	glob_lut_idx = params->global_lut_id;
-	vsi_id = ice_get_hw_vsi_num(hw, vsi_handle);
-
 	cmd_resp = &desc.params.get_set_rss_lut;
+	if (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_GLOBAL)
+		glob_lut_idx = params->global_lut_id;
+
+	if (!lut || !ice_is_vsi_valid(hw, vsi_handle))
+		return ICE_ERR_PARAM;
+
+	if (lut_type & ~ICE_LUT_TYPE_MASK)
+		return ICE_ERR_PARAM;
+
+	if (!ice_lut_is_valid_size(lut_type, lut_size))
+		return ICE_ERR_INVAL_SIZE;
+
+	vsi_id = ice_get_hw_vsi_num(hw, vsi_handle);
 
 	if (set) {
 		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_rss_lut);
@@ -4377,61 +4429,15 @@ __ice_aq_get_set_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params
 					ICE_AQC_GSET_RSS_LUT_VSI_ID_M) |
 				       ICE_AQC_GSET_RSS_LUT_VSI_VALID);
 
-	switch (lut_type) {
-	case ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_VSI:
-	case ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF:
-	case ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_GLOBAL:
-		flags |= ((lut_type << ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_S) &
-			  ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_M);
-		break;
-	default:
-		status = ICE_ERR_PARAM;
-		goto ice_aq_get_set_rss_lut_exit;
-	}
+	flags = ice_lut_size_to_flag(lut_size) |
+			((lut_type << ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_S) &
+				ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_M) |
+			((glob_lut_idx << ICE_AQC_GSET_RSS_LUT_GLOBAL_IDX_S) &
+				ICE_AQC_GSET_RSS_LUT_GLOBAL_IDX_M);
 
-	if (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_GLOBAL) {
-		flags |= ((glob_lut_idx << ICE_AQC_GSET_RSS_LUT_GLOBAL_IDX_S) &
-			  ICE_AQC_GSET_RSS_LUT_GLOBAL_IDX_M);
-
-		if (!set)
-			goto ice_aq_get_set_rss_lut_send;
-	} else if (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF) {
-		if (!set)
-			goto ice_aq_get_set_rss_lut_send;
-	} else {
-		goto ice_aq_get_set_rss_lut_send;
-	}
-
-	/* LUT size is only valid for Global and PF table types */
-	switch (lut_size) {
-	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128:
-		flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG <<
-			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-		break;
-	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512:
-		flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512_FLAG <<
-			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-		break;
-	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K:
-		if (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF) {
-			flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG <<
-				  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-				 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-			break;
-		}
-		/* fall-through */
-	default:
-		status = ICE_ERR_PARAM;
-		goto ice_aq_get_set_rss_lut_exit;
-	}
-
-ice_aq_get_set_rss_lut_send:
 	cmd_resp->flags = CPU_TO_LE16(flags);
 	status = ice_aq_send_cmd(hw, &desc, lut, lut_size, NULL);
-
-ice_aq_get_set_rss_lut_exit:
+	params->lut_size = LE16_TO_CPU(desc.datalen);
 	return status;
 }
 
-- 
2.47.3

