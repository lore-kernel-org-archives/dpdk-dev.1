Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62145C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7929F40DDE;
	Mon, 11 Aug 2025 15:43:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 85F7D402AC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 15:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754919787; x=1786455787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qArfouuv9YAxGcBlATV0rk8feQtjvk1sewC2MxK1Xck=;
 b=fpPtHtxlNjFHIAJ39uDp0F6qbVWpJVWdd+Ra9rUK4BouyioYtnTpotQo
 q64aB7ghXfYNqM2hI6JC9aLJyaXlxr3Z41UduujowvOdy2ZHXDzVx6fgQ
 L8f/EoFB5QeRUj6aHyKzph6SLt2kV4qF/XtB1zQh83c/Xnw6YUryaSlew
 s6JrpPHtXbvxCypIip3QYNiV2wF6Mh+x2IU4J5YzDfTGUvmtBu/Vnyw7v
 ReomQboAgapJ1yRjWYRbN67MzI5189o4hgiJol/cTpvGNnecp3xqH/obu
 1yb7f2LeOHSXsumyB3og2SO/65PH0hIAlfK6OzP4JzCT8+libTndGyuPm g==;
X-CSE-ConnectionGUID: ubZ0ioTQQ6q9qK/PmGvweA==
X-CSE-MsgGUID: 1OXXfGdFQ62BaYQej9Gt6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57041881"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57041881"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 06:43:06 -0700
X-CSE-ConnectionGUID: /sW3FxO6Tf+VSH4O0xm17w==
X-CSE-MsgGUID: A1Qqw3h+Sc6rHwTZiFn4xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="171169009"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa004.fm.intel.com with ESMTP; 11 Aug 2025 06:43:05 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v2 1/6] net/ice/base: add utility functions
Date: Mon, 11 Aug 2025 13:42:56 +0000
Message-ID: <20250811134301.459523-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
 <20250811134301.459523-1-vladimir.medvedkin@intel.com>
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
 drivers/net/intel/ice/base/ice_common.c | 28 +++++++++++++++++++++++++
 drivers/net/intel/ice/base/ice_common.h |  8 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index dfc2fd69e7..8bca256b34 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -6579,3 +6579,31 @@ bool ice_is_fw_auto_drop_supported(struct ice_hw *hw)
 		return true;
 	return false;
 }
+
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
+u8
+ice_get_tc_by_up(struct ice_hw *hw, u8 up)
+{
+	struct ice_port_info *port_info = hw->port_info;
+	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
+	struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
+
+	up &= (ICE_MAX_TRAFFIC_CLASS - 1);
+
+	return local_dcb_conf->etscfg.prio_table[up];
+}
+
+int
+ice_get_cgd_idx(struct ice_hw *hw, u8 tc)
+{
+	return hw->port_info->lport * ice_get_port_max_cgd(hw) + tc;
+}
diff --git a/drivers/net/intel/ice/base/ice_common.h b/drivers/net/intel/ice/base/ice_common.h
index f7e7ff5aaf..2d4f4871e6 100644
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
+u8 ice_get_tc_by_up(struct ice_hw *hw, u8 up);
+int ice_get_cgd_idx(struct ice_hw *hw, u8 tc);
 #endif /* _ICE_COMMON_H_ */
-- 
2.43.0

