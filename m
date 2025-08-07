Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BABCC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C1C240609;
	Thu,  7 Aug 2025 14:22:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 490B04027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:22:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754569364; x=1786105364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UW1GsbS0fndlO12y6ml3gYDwUM8mLnLLrhfEJSFC7TI=;
 b=AFVov5ioEQ7lCOX1ulyPhjtwH7sVE9qrs5fTZ6bqS9t66L5n7pHr0jGV
 0Jc2xk1NCDjXwVD3Wyxf/mMzM5asq0xm4M8nOSkgEhIod7YLnGIUJE4at
 qQkiucB/Nccb3RtjXWKDzRmVy+YkDK2XDI+jROl7HSBaAqsamGFOSSbHJ
 W6DGjq4tm3hai/ZQikLXrOJCJietXhUmKdFIOEmkSNJtHWrmpv0ILG7mt
 FYK2hPYcamNi7BWTic/PotiRT2u/7eNkXKxui8YFIWshOFD6kG7b4Tv2/
 QPTVCiprdbcckJoh9PVlZP3j9PCIqij0lmAcqq47dh2G14P2fB3/DtDf1 Q==;
X-CSE-ConnectionGUID: 5WBGgc9jQVSO2jsd288WQQ==
X-CSE-MsgGUID: HpUx7yo3TSaLUDnRM+lI7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59517163"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="59517163"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:22:43 -0700
X-CSE-ConnectionGUID: vghr7cuBTjO7zf+MNqr8nA==
X-CSE-MsgGUID: UU0qcJ/YS9eOVHBXsiA/gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="169171617"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2025 05:22:42 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH 1/6] net/ice/base: add utility functions
Date: Thu,  7 Aug 2025 12:22:32 +0000
Message-ID: <20250807122238.334177-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
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
 drivers/net/intel/ice/base/ice_common.c | 27 +++++++++++++++++++++++++
 drivers/net/intel/ice/base/ice_common.h |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index dfc2fd69e7..58e1b76214 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -6579,3 +6579,30 @@ bool ice_is_fw_auto_drop_supported(struct ice_hw *hw)
 		return true;
 	return false;
 }
+
+enum ice_cgd_per_port
+ice_get_port_max_cgd(struct ice_hw *hw)
+{
+#define ICE_8_PORTS_LINK_TOPO	0x2
+	u32 link_topo = rd32(hw, GLGEN_MAC_LINK_TOPO) & GLGEN_MAC_LINK_TOPO_LINK_TOPO_M;
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

