Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED8FC5915
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B990402E4;
	Thu, 26 Feb 2026 12:58:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 98B76402CE
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772107089; x=1803643089;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v+S+Z0bdxJiZWg2gPTSy6uT1YvRJVL1kLXOmjegkKuI=;
 b=OauFA2aZErR0ognuBdvzn4Dy5UT5rNzu/AzydSl968bNe/Fp0OQ9raDw
 b4yk1rwP4HLJ/AyHecGal6bLShmELRTwcpeV6jHOoGMNZ2v749KdR9DGe
 KGQEvxfkV6WCNvzn9XZztAhR3XIc9jDg1SO2LsPjO2brwPZ1+nExsSOQY
 piBYBB1FKmhDLYiAJ+aJykSHcXlFNyVAehHhBb5nedu5srkMxfxFjknQ2
 v+7roVpGN7ukXEe9zsgZCiKPaVHok80t33GO+z+ze65TsoZaqdNUyTUXZ
 aU3gMmGRGkB9Yrqw0lnE/sbUod3BSA64DUXOjlpYTEnOcGO83vfW9KKEw Q==;
X-CSE-ConnectionGUID: Jd9BArEvRDi4s5XjUI/o3g==
X-CSE-MsgGUID: QGWZvy22TU+88TrtrV6u+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="77033342"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="77033342"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:58:09 -0800
X-CSE-ConnectionGUID: 7Arr34RPS4SSg+4tzOIH2w==
X-CSE-MsgGUID: 4SBi6BarR5e4rgIg5eeqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="244135158"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 03:58:06 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Cc: Milena Olech <milena.olech@intel.com>
Subject: [PATCH v7 1/4] net/idpf/base: add a new API for PTP support
Date: Thu, 26 Feb 2026 19:33:11 -0500
Message-ID: <20260227003314.439267-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260227003314.439267-1-soumyadeep.hore@intel.com>
References: <20260214194920.139066-5-soumyadeep.hore@intel.com>
 <20260227003314.439267-1-soumyadeep.hore@intel.com>
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

From: Milena Olech <milena.olech@intel.com>

Add PTP capabilities to determine which PTP features are enabled -
get/set the time, cross timestamp, adjust the clock and timestamping.

Create appropriate structures and opcodes to support features introduced by
capabilities.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Acked-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 drivers/net/intel/idpf/base/virtchnl2.h | 324 +++++++++++++++++-------
 1 file changed, 235 insertions(+), 89 deletions(-)

diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
index 6cfb4f56fa..0b01daee30 100644
--- a/drivers/net/intel/idpf/base/virtchnl2.h
+++ b/drivers/net/intel/idpf/base/virtchnl2.h
@@ -118,8 +118,14 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_DEL_QUEUE_GROUPS		= 539,
 	VIRTCHNL2_OP_GET_PORT_STATS		= 540,
 	/* TimeSync opcodes */
-	VIRTCHNL2_OP_GET_PTP_CAPS		= 541,
-	VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES	= 542,
+	VIRTCHNL2_OP_PTP_GET_CAPS			= 541,
+	VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP		= 542,
+	VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME		= 543,
+	VIRTCHNL2_OP_PTP_GET_CROSS_TIME			= 544,
+	VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME		= 545,
+	VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE		= 546,
+	VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME		= 547,
+	VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS	= 548,
 };
 
 #define VIRTCHNL2_RDMA_INVALID_QUEUE_IDX	0xFFFF
@@ -1813,123 +1819,180 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_promisc_info);
  * enum virtchnl2_ptp_caps - PTP capabilities
  */
 enum virtchnl2_ptp_caps {
-	VIRTCHNL2_PTP_CAP_LEGACY_CROSS_TIME	= BIT(0),
-	VIRTCHNL2_PTP_CAP_PTM			= BIT(1),
-	VIRTCHNL2_PTP_CAP_DEVICE_CLOCK_CONTROL	= BIT(2),
-	VIRTCHNL2_PTP_CAP_TX_TSTAMPS_DIRECT	= BIT(3),
-	VIRTCHNL2_PTP_CAP_TX_TSTAMPS_VIRTCHNL	= BIT(4),
-};
-
-/**
- * struct virtchnl2_ptp_legacy_cross_time_reg - Legacy cross time registers
- *						offsets.
+	VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME		= BIT(0),
+	VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB	= BIT(1),
+	VIRTCHNL2_CAP_PTP_GET_CROSS_TIME		= BIT(2),
+	VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB		= BIT(3),
+	VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME		= BIT(4),
+	VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB	= BIT(5),
+	VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK		= BIT(6),
+	VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB		= BIT(7),
+	VIRTCHNL2_CAP_PTP_TX_TSTAMPS			= BIT(8),
+	VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB			= BIT(9),
+};
+
+/**
+ * struct virtchnl2_ptp_clk_reg_offsets - Offsets of device and PHY clocks
+ *					  registers
+ * @dev_clk_ns_l: Device clock low register offset
+ * @dev_clk_ns_h: Device clock high register offset
+ * @phy_clk_ns_l: PHY clock low register offset
+ * @phy_clk_ns_h: PHY clock high register offset
+ * @cmd_sync_trigger: The command sync trigger register offset
+ * @pad: Padding for future extensions
  */
-struct virtchnl2_ptp_legacy_cross_time_reg {
-	__le32 shadow_time_0;
-	__le32 shadow_time_l;
-	__le32 shadow_time_h;
-	__le32 cmd_sync;
+struct virtchnl2_ptp_clk_reg_offsets {
+	__le32 dev_clk_ns_l;
+	__le32 dev_clk_ns_h;
+	__le32 phy_clk_ns_l;
+	__le32 phy_clk_ns_h;
+	__le32 cmd_sync_trigger;
+	u8 pad[4];
 };
 
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_legacy_cross_time_reg);
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_clk_reg_offsets);
 
 /**
- * struct virtchnl2_ptp_ptm_cross_time_reg - PTM cross time registers offsets
+ * struct virtchnl2_ptp_cross_time_reg_offsets - Offsets of the device cross
+ *						 time registers
+ * @sys_time_ns_l: System time low register offset
+ * @sys_time_ns_h: System time high register offset
+ * @cmd_sync_trigger: The command sync trigger register offset
+ * @pad: Padding for future extensions
  */
-struct virtchnl2_ptp_ptm_cross_time_reg {
-	__le32 art_l;
-	__le32 art_h;
-	__le32 cmd_sync;
+struct virtchnl2_ptp_cross_time_reg_offsets {
+	__le32 sys_time_ns_l;
+	__le32 sys_time_ns_h;
+	__le32 cmd_sync_trigger;
 	u8 pad[4];
 };
 
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_ptm_cross_time_reg);
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_cross_time_reg_offsets);
 
 /**
- * struct virtchnl2_ptp_device_clock_control - Registers needed to control the
- *					       main clock.
+ * struct virtchnl2_ptp_clk_adj_reg_offsets - Offsets of device and PHY clocks
+ *					      adjustments registers
+ * @dev_clk_cmd_type: Device clock command type register offset
+ * @dev_clk_incval_l: Device clock increment value low register offset
+ * @dev_clk_incval_h: Device clock increment value high registers offset
+ * @dev_clk_shadj_l: Device clock shadow adjust low register offset
+ * @dev_clk_shadj_h: Device clock shadow adjust high register offset
+ * @phy_clk_cmd_type: PHY timer command type register offset
+ * @phy_clk_incval_l: PHY timer increment value low register offset
+ * @phy_clk_incval_h: PHY timer increment value high register offset
+ * @phy_clk_shadj_l: PHY timer shadow adjust low register offset
+ * @phy_clk_shadj_h: PHY timer shadow adjust high register offset
  */
-struct virtchnl2_ptp_device_clock_control {
-	__le32 cmd;
-	__le32 incval_l;
-	__le32 incval_h;
-	__le32 shadj_l;
-	__le32 shadj_h;
-	u8 pad[4];
+struct virtchnl2_ptp_clk_adj_reg_offsets {
+	__le32 dev_clk_cmd_type;
+	__le32 dev_clk_incval_l;
+	__le32 dev_clk_incval_h;
+	__le32 dev_clk_shadj_l;
+	__le32 dev_clk_shadj_h;
+	__le32 phy_clk_cmd_type;
+	__le32 phy_clk_incval_l;
+	__le32 phy_clk_incval_h;
+	__le32 phy_clk_shadj_l;
+	__le32 phy_clk_shadj_h;
 };
 
-VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_device_clock_control);
+VIRTCHNL2_CHECK_STRUCT_LEN(40, virtchnl2_ptp_clk_adj_reg_offsets);
 
 /**
- * struct virtchnl2_ptp_tx_tstamp_entry - PTP TX timestamp entry
- * @tx_latch_register_base: TX latch register base
- * @tx_latch_register_offset: TX latch register offset
- * @index: Index
- * @pad: Padding
+ * struct virtchnl2_ptp_tx_tstamp_latch_caps - PTP Tx timestamp latch
+ *					       capabilities
+ * @tx_latch_reg_offset_l: Tx timestamp latch low register offset
+ * @tx_latch_reg_offset_h: Tx timestamp latch high register offset
+ * @index: Latch index provided to the Tx descriptor
+ * @pad: Padding for future extensions
  */
-struct virtchnl2_ptp_tx_tstamp_entry {
-	__le32 tx_latch_register_base;
-	__le32 tx_latch_register_offset;
+struct virtchnl2_ptp_tx_tstamp_latch_caps {
+	__le32 tx_latch_reg_offset_l;
+	__le32 tx_latch_reg_offset_h;
 	u8 index;
 	u8 pad[7];
 };
 
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_entry);
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_latch_caps);
 
 /**
- * struct virtchnl2_ptp_tx_tstamp - Structure that defines tx tstamp entries
+ * struct virtchnl2_ptp_get_vport_tx_tstamp_caps - Structure that defines Tx
+ *						   tstamp entries
+ * @vport_id: Vport number
  * @num_latches: Total number of latches
- * @latch_size: Latch size expressed in bits
- * @pad: Padding
- * @ptp_tx_tstamp_entries: Aarray of TX timestamp entries
+ * @tstamp_ns_lo_bit: First bit for nanosecond part of the timestamp
+ * @tstamp_ns_hi_bit: Last bit for nanosecond part of the timestamp
+ * @pad: Padding for future tstamp granularity extensions
+ * @tstamp_latches: Capabilities of Tx timestamp entries
+ *
+ * PF/VF sends this message to negotiate the Tx timestamp latches for each
+ * Vport.
+ *
+ * Associated with VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS
  */
-struct virtchnl2_ptp_tx_tstamp {
+struct virtchnl2_ptp_get_vport_tx_tstamp_caps {
+	__le32 vport_id;
 	__le16 num_latches;
-	__le16 latch_size;
-	u8 pad[4];
-	struct virtchnl2_ptp_tx_tstamp_entry ptp_tx_tstamp_entries[STRUCT_VAR_LEN];
+	u8 tstamp_ns_lo_bit;
+	u8 tstamp_ns_hi_bit;
+	u8 pad[8];
+
+	struct virtchnl2_ptp_tx_tstamp_latch_caps tstamp_latches[STRUCT_VAR_LEN];
 };
-VIRTCHNL2_CHECK_STRUCT_VAR_LEN(24, virtchnl2_ptp_tx_tstamp,
-			       ptp_tx_tstamp_entries);
+VIRTCHNL2_CHECK_STRUCT_VAR_LEN(32, virtchnl2_ptp_get_vport_tx_tstamp_caps,
+			       tstamp_latches);
 
 /**
- * struct virtchnl2_get_ptp_caps - Get PTP capabilities
- * @ptp_caps: PTP capability bitmap. See enum virtchnl2_ptp_caps.
- * @pad: Padding
- * @legacy_cross_time_reg: Legacy cross time register
- * @ptm_cross_time_reg: PTM cross time register
- * @device_clock_control: Device clock control
- * @tx_tstamp: TX timestamp
+ * struct virtchnl2_ptp_get_caps - Get PTP capabilities
+ * @caps: PTP capability bitmap. See enum virtchnl2_ptp_caps
+ * @max_adj: The maximum possible frequency adjustment
+ * @base_incval: The default timer increment value
+ * @peer_mbx_q_id: ID of the PTP Device Control daemon queue
+ * @peer_id: Peer ID for PTP Device Control daemon
+ * @secondary_mbx: Indicates to the driver that it should create a secondary
+ *		   mailbox to inetract with control plane for PTP
+ * @pad: Padding for future extensions
+ * @clk_offsets: Main timer and PHY registers offsets
+ * @cross_time_offsets: Cross time registers offsets
+ * @clk_adj_offsets: Offsets needed to adjust the PHY and the main timer
  *
- * PV/VF sends this message to negotiate PTP capabilities. CP updates bitmap
+ * PF/VF sends this message to negotiate PTP capabilities. CP updates bitmap
  * with supported features and fulfills appropriate structures.
- *
- * Associated with VIRTCHNL2_OP_GET_PTP_CAPS.
- */
-struct virtchnl2_get_ptp_caps {
-	__le32 ptp_caps;
+ * If HW uses primary MBX for PTP: secondary_mbx is set to false.
+ * If HW uses secondary MBX for PTP: secondary_mbx is set to true.
+ *	Control plane has 2 MBX and the driver has 1 MBX, send to peer
+ *	driver may be used to send a message using valid ptp_peer_mb_q_id and
+ *	ptp_peer_id.
+ * If HW does not use send to peer driver: secondary_mbx is no care field and
+ * peer_mbx_q_id holds invalid value (0xFFFF).
+ *
+ * Associated with VIRTCHNL2_OP_PTP_GET_CAPS.
+ */
+struct virtchnl2_ptp_get_caps {
+	__le32 caps;
+	__le32 max_adj;
+	__le64 base_incval;
+	__le16 peer_mbx_q_id;
+	u8 peer_id;
+	u8 secondary_mbx;
 	u8 pad[4];
 
-	struct virtchnl2_ptp_legacy_cross_time_reg legacy_cross_time_reg;
-	struct virtchnl2_ptp_ptm_cross_time_reg ptm_cross_time_reg;
-	struct virtchnl2_ptp_device_clock_control device_clock_control;
-	struct virtchnl2_ptp_tx_tstamp tx_tstamp;
+	struct virtchnl2_ptp_clk_reg_offsets clk_offsets;
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_time_offsets;
+	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
 };
-VIRTCHNL2_CHECK_STRUCT_VAR_LEN(88, virtchnl2_get_ptp_caps,
-			       tx_tstamp.ptp_tx_tstamp_entries);
+VIRTCHNL2_CHECK_STRUCT_LEN(104, virtchnl2_ptp_get_caps);
 
 /**
  * struct virtchnl2_ptp_tx_tstamp_latch - Structure that describes tx tstamp
  *					  values, index and validity.
- * @tstamp_h: Timestamp high
- * @tstamp_l: Timestamp low
+ * @tstamp: Timestamp value
  * @index: Index
  * @valid: Timestamp validity
- * @pad: Padding
+ * @pad: Padding for future extensions
  */
 struct virtchnl2_ptp_tx_tstamp_latch {
-	__le32 tstamp_h;
-	__le32 tstamp_l;
+	__le64 tstamp;
 	u8 index;
 	u8 valid;
 	u8 pad[6];
@@ -1938,26 +2001,97 @@ struct virtchnl2_ptp_tx_tstamp_latch {
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_latch);
 
 /**
- * struct virtchnl2_ptp_tx_tstamp_latches - PTP TX timestamp latches
+ * struct virtchnl2_ptp_get_vport_tx_tstamp_latches - Tx timestamp latches
+ *						      associated with the vport
+ * @vport_id: Number of vport that requests the timestamp
  * @num_latches: Number of latches
- * @latch_size: Latch size expressed in bits
- * @pad: Padding
+ * @get_devtime_with_txtstmp: Flag to request device time along with Tx timestamp
+ * @pad: Padding for future extensions
+ * @device_time: device time if get_devtime_with_txtstmp was set in request
  * @tstamp_latches: PTP TX timestamp latch
  *
  * PF/VF sends this message to receive a specified number of timestamps
  * entries.
  *
- * Associated with VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES.
+ * Associated with VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP.
  */
-struct virtchnl2_ptp_tx_tstamp_latches {
+struct virtchnl2_ptp_get_vport_tx_tstamp_latches {
+	__le32 vport_id;
 	__le16 num_latches;
-	__le16 latch_size;
-	u8 pad[4];
+	u8 get_devtime_with_txtstmp;
+	u8 pad[1];
+	u64 device_time;
 	struct virtchnl2_ptp_tx_tstamp_latch tstamp_latches[STRUCT_VAR_LEN];
 };
-VIRTCHNL2_CHECK_STRUCT_VAR_LEN(24, virtchnl2_ptp_tx_tstamp_latches,
+
+VIRTCHNL2_CHECK_STRUCT_VAR_LEN(32, virtchnl2_ptp_get_vport_tx_tstamp_latches,
 			       tstamp_latches);
 
+/* VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME
+ * @dev_time_ns: Device clock time value in nanoseconds
+ * @pad: Padding for future extensions
+ *
+ * PF/VF sends this message to receive the time from the main timer
+ */
+struct virtchnl2_ptp_get_dev_clk_time {
+	__le64 dev_time_ns;
+	u8 pad[8];
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_dev_clk_time);
+
+/* VIRTCHNL2_OP_PTP_GET_CROSS_TIME
+ * @sys_time_ns: System counter value expressed in nanoseconds, read
+ *		 synchronously with device time
+ * @dev_time_ns: Device clock time value expressed in nanoseconds
+ * @pad: Padding for future extensions
+ *
+ * PF/VF sends this message to receive the cross time
+ */
+struct virtchnl2_ptp_get_cross_time {
+	__le64 sys_time_ns;
+	__le64 dev_time_ns;
+	u8 pad[8];
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_get_cross_time);
+
+/* VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME
+ * @dev_time_ns: Device time value expressed in nanoseconds to set
+ * @pad: Padding for future extensions
+ *
+ * PF/VF sends this message to set the time of the main timer
+ */
+struct virtchnl2_ptp_set_dev_clk_time {
+	__le64 dev_time_ns;
+	u8 pad[8];
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_set_dev_clk_time);
+
+/* VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE
+ * @incval: Source timer increment value per clock cycle
+ *
+ * PF/VF sends this message to adjust the frequency of the main timer by the
+ * indicated scaled ppm.
+ */
+struct virtchnl2_ptp_adj_dev_clk_fine {
+	__le64 incval;
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_adj_dev_clk_fine);
+
+/* VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * PF/VF sends this message to adjust the time of the main timer by the delta
+ */
+struct virtchnl2_ptp_adj_dev_clk_time {
+	__le64 delta;
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_adj_dev_clk_time);
+
 static inline const char *virtchnl2_op_str(__le32 v_opcode)
 {
 	switch (v_opcode) {
@@ -2025,10 +2159,22 @@ static inline const char *virtchnl2_op_str(__le32 v_opcode)
 		return "VIRTCHNL2_OP_DEL_QUEUE_GROUPS";
 	case VIRTCHNL2_OP_GET_PORT_STATS:
 		return "VIRTCHNL2_OP_GET_PORT_STATS";
-	case VIRTCHNL2_OP_GET_PTP_CAPS:
-		return "VIRTCHNL2_OP_GET_PTP_CAPS";
-	case VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES:
-		return "VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES";
+	case VIRTCHNL2_OP_PTP_GET_CAPS:
+		return "VIRTCHNL2_OP_PTP_GET_CAPS";
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:
+		return "VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP";
+	case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
+		return "VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME";
+	case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
+		return "VIRTCHNL2_OP_PTP_GET_CROSS_TIME";
+	case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
+		return "VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME";
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
+		return "VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE";
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
+		return "VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME";
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS:
+		return "VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS";
 	default:
 		return "Unsupported (update virtchnl2.h)";
 	}
-- 
2.47.1

