Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47815CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 12:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 437C440DDD;
	Wed,  1 Oct 2025 14:29:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 780D840B9E
 for <dev@dpdk.org>; Wed,  1 Oct 2025 14:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759321756; x=1790857756;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9rxGTyTNTCCt3A2ZfRSn1i8IPcD0pp9fmgKv55D3CfA=;
 b=gSva6APZ/Qjylit9tcuoneLi0pPlLzBtU/qbkXnVMntXpDrIceXlSb51
 O9HOeHLGy8kYlWhy1JGUezkTk8x86SmM67IifSD6V+bKp3VGWfIuZizsq
 V+BBojSnbmD7RC7q6/29TcDbl1pYzHSHxizkXH1cOJb99DxlQR1Zcf3iI
 4+QgoRKK49Dtz5zxPvFxjTkFspkwVsEzC2MEC9qdxjjJ3MEjprcyWx6AV
 whn0Q87gXwU/oY3YUeeDW3bCW2FlzIvjC06oMfnu3IbHWC1flRvAwwzKv
 jQOO/LoRw1taY8WcuL8HHwUXrlbqudg0ePEMw3dWfc6diWikJa+AphzAF w==;
X-CSE-ConnectionGUID: U6AC3tYlTMewFy//hTw8vQ==
X-CSE-MsgGUID: wUGUlA5CTB2DvyxhY6mqAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60807870"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="60807870"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 05:29:16 -0700
X-CSE-ConnectionGUID: iio5tXqQQoGxwzSXuTwnQQ==
X-CSE-MsgGUID: RlEnLvTwTm639t4h+r6caQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2025 05:29:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: vladimir.medvedkin@intel.com
Subject: [PATCH v2 2/5] net/ice/base: add utility functions
Date: Wed,  1 Oct 2025 13:29:05 +0100
Message-ID: <52b408d3a1f16d26852993d105be34d7cd2de1ae.1759321681.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759321681.git.anatoly.burakov@intel.com>
 <cover.1759321681.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Add the following utility functions related to DCB:

* Get number of Congestion Domains per port
* Resolve Traffic Class(TC) by 802.1p VLAN User Priority(UP)
* Get absolute index of the Congestion Domain by TC

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 48 +++++++++++++++++++++++++
 drivers/net/intel/ice/base/ice_common.h |  8 +++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index d9520097bd..63c72f77a5 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -6594,3 +6594,51 @@ bool ice_is_fw_auto_drop_supported(struct ice_hw *hw)
 		return true;
 	return false;
 }
+
+/**
+ * ice_get_port_max_cgd
+ * @hw: pointer to the hardware structure
+ *
+ * Returns the number of congestion domains (cgds) for a port
+ */
+enum ice_cgd_per_port
+ice_get_port_max_cgd(struct ice_hw *hw)
+{
+#define ICE_8_PORTS_LINK_TOPO	0x2
+	u32 link_topo = LE32_TO_CPU(rd32(hw, GLGEN_MAC_LINK_TOPO)) &
+		GLGEN_MAC_LINK_TOPO_LINK_TOPO_M;
+
+	return (link_topo == ICE_8_PORTS_LINK_TOPO) ? ICE_4_CGD_PER_PORT : ICE_8_CGD_PER_PORT;
+}
+
+/**
+ * ice_get_tc_by_priority
+ * @hw: pointer to the hardware structure
+ * @prio: VLAN PCP
+ *
+ * Returns the index of Traffic Class(TC) associated with the User Priority
+ */
+u8
+ice_get_tc_by_priority(struct ice_hw *hw, u8 prio)
+{
+	struct ice_port_info *port_info = hw->port_info;
+	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
+	struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
+
+	prio &= (ICE_MAX_TRAFFIC_CLASS - 1);
+
+	return local_dcb_conf->etscfg.prio_table[prio];
+}
+
+/**
+ * ice_get_cgd_idx
+ * @hw: pointer to the hardware structure
+ * @tc: index of Traffic Class
+ *
+ * Returns the absolute index of the congestion domain by its TC
+ */
+int
+ice_get_cgd_idx(struct ice_hw *hw, u8 tc)
+{
+	return hw->port_info->lport * ice_get_port_max_cgd(hw) + tc;
+}
diff --git a/drivers/net/intel/ice/base/ice_common.h b/drivers/net/intel/ice/base/ice_common.h
index f7e7ff5aaf..77ceccc6bd 100644
--- a/drivers/net/intel/ice/base/ice_common.h
+++ b/drivers/net/intel/ice/base/ice_common.h
@@ -25,6 +25,11 @@ enum ice_fw_modes {
 	ICE_FW_MODE_ROLLBACK
 };
 
+enum ice_cgd_per_port {
+	ICE_4_CGD_PER_PORT = 4,
+	ICE_8_CGD_PER_PORT = 8
+};
+
 int ice_init_fltr_mgmt_struct(struct ice_hw *hw);
 void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw);
 void ice_set_umac_shared(struct ice_hw *hw);
@@ -335,4 +340,7 @@ ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
 /* AQ API version for FW auto drop reports */
 bool ice_is_fw_auto_drop_supported(struct ice_hw *hw);
+enum ice_cgd_per_port ice_get_port_max_cgd(struct ice_hw *hw);
+u8 ice_get_tc_by_priority(struct ice_hw *hw, u8 prio);
+int ice_get_cgd_idx(struct ice_hw *hw, u8 tc);
 #endif /* _ICE_COMMON_H_ */
-- 
2.47.3

