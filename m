Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD27AC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37E8940648;
	Tue, 12 Aug 2025 19:33:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 93AE2400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 19:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755019979; x=1786555979;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=isipMp/xdVS/H5gbDBIFAY/+7Pm8kw7n2a82g41p6H4=;
 b=i42JgrgEOj9ZOfiXWKLLKymHeuACmSvjgbGiLsdevoAEdolpDcctQMLR
 EokZBUtHHW4FvZlhycagElSj4SD20SUBgyx2va6vYZedkgxK+SuU9cZ53
 qmHLcbaj2ZHL+LmFtxQjHaCHZzxXaH/X7rWd0B8AWUhwy7H5iIvO4Ok2v
 DKZ12hxJXWFkl7JSddmC3XCq5Aam3YW6rAgsO9CNr3vgbeFya2GGOqSQm
 Yg9SDMbaWhX95bE7/mCyUrFvDvlaw/Pehk48e5wRfp8EUyX1azYKnDoEx
 FEZ7x5VOLvv3d7IKvUk33zLB7m/+rBichqgG8XJB3WNIjGeHckPvZmnMn g==;
X-CSE-ConnectionGUID: pqr/n26iTweTRxQrStqFfA==
X-CSE-MsgGUID: +/eIdhYwQ9+gVAa0cVwrJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74751867"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="74751867"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 10:32:58 -0700
X-CSE-ConnectionGUID: X/fP4IjuQXydEVbaZro0BA==
X-CSE-MsgGUID: HJpXP1SJR8WXGNhOxluckA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="170472894"
Received: from unknown (HELO silpixa00401176.ger.corp.intel.com)
 ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 10:32:56 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v3 1/6] net/ice/base: add utility functions
Date: Tue, 12 Aug 2025 17:32:47 +0000
Message-ID: <20250812173252.507954-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
References: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
 <20250812173252.507954-1-vladimir.medvedkin@intel.com>
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

Add the following function related to DCB:

* Get number of Congestion Domains per port
* Resolve Traffic Class(TC) by 802.1p VLAN User Priority(UP)
* Get absolute index of the Congestion Domain by the TC

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 31 +++++++++++++++++++++++++
 drivers/net/intel/ice/base/ice_common.h |  8 +++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index dfc2fd69e7..68c873f71c 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -6579,3 +6579,34 @@ bool ice_is_fw_auto_drop_supported(struct ice_hw *hw)
 		return true;
 	return false;
 }
+
+/* get the number of congestion domains (cgds) for a port */
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
+/* get the Traffic Class(TC) index associated with the User Priority */
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
+/* get the absolute index of the congestion domain by its TC */
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
2.43.0

