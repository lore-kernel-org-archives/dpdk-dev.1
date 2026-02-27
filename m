Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A02FC592F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4765C40608;
	Thu, 26 Feb 2026 12:58:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4F21A402F2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772107092; x=1803643092;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kBmCdsihUJc6Kw85tEFGtdCpOvqr1W/4DFGvTEHGMkU=;
 b=makKXO4W5X0Rrk2Pa9+AEl4Uo60EKe4BrQsNzbpcIoyF4tR8tHSjELU8
 +8SpYbjpGL0SeNnEibQW9nkQ+yYhJKYFXuAab2lO5L2Vi0Im33CZS/qe/
 0Ifu7W8vpkIp4Q0YQ1pQUumYPdsV/fT17wkkNLEzBBml4YMICy4qZdBSY
 xV9daV74FC9vM5+BgCDH7ocvq/9x40jh1mJgPgngGHp0fYyQLZa/LDRIt
 6eTnDK/tBKxWDW6PYQ5qMGjESa0wP4ViNdHiuTyzHLXL5t2EbW6SpJtzi
 /JEC3WnHH3kNjCZdnYint3On3iiSP2kNMfKCaVKrOAUJKFewToxNGcV7Q w==;
X-CSE-ConnectionGUID: HWHPEww+S52CB0gVtLW/IQ==
X-CSE-MsgGUID: 9LAwvUw+Q9uudSrPxaS3Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="77033345"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="77033345"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:58:12 -0800
X-CSE-ConnectionGUID: 84GfLC6lRKOhl27kzCpR/Q==
X-CSE-MsgGUID: jFCUzHKLQpa0vOMoj24NSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="244135165"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 03:58:09 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: [PATCH v7 2/4] net/idpf: add PTP virtchnl2 support
Date: Thu, 26 Feb 2026 19:33:12 -0500
Message-ID: <20260227003314.439267-3-soumyadeep.hore@intel.com>
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

Add a new file - idpf_ptp - to handle PTP virtchnl messages.
Keep the registers addresses in the PTP struct.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h   |   4 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  31 +-
 drivers/net/intel/idpf/idpf_ptp.c             | 504 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 130 +++++
 drivers/net/intel/idpf/meson.build            |   1 +
 5 files changed, 668 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 31915a03d4..e45795c18b 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -103,6 +103,7 @@ struct idpf_adapter {
 
 	/* For timestamp */
 	uint64_t time_hw;
+	struct idpf_ptp *ptp;
 
 	enum idpf_rx_func_type rx_func_type;
 	enum idpf_tx_func_type tx_func_type;
@@ -173,6 +174,9 @@ struct idpf_vport {
 	/* Event from ipf */
 	bool link_up;
 	uint32_t link_speed;
+
+	/* For PTP */
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 };
 
 /* Message type read in virtual channel from PF */
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index e927d7415a..f8c487c537 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -4,6 +4,7 @@
 
 #include "idpf_common_virtchnl.h"
 #include "idpf_common_logs.h"
+#include "idpf_ptp.h"
 
 #include <eal_export.h>
 
@@ -38,6 +39,24 @@ idpf_vc_clean(struct idpf_adapter *adapter)
 	return 0;
 }
 
+	/* Helper to detect PTP-related mailbox messages */
+static inline bool
+idpf_mb_msg_is_ptp(uint32_t op)
+{
+	switch (op) {
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:
+	case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
+	case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,
 		 uint16_t msg_size, uint8_t *msg)
@@ -71,8 +90,16 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,
 
 	memcpy(dma_mem->va, msg, msg_size);
 
-	ctlq_msg->opcode = idpf_mbq_opc_send_msg_to_pf;
-	ctlq_msg->func_id = 0;
+	if (adapter->ptp != NULL &&
+	    idpf_mb_msg_is_ptp(op) &&
+	    adapter->ptp->secondary_mbx.valid) {
+		ctlq_msg->opcode = idpf_mbq_opc_send_msg_to_peer_drv;
+		ctlq_msg->func_id = adapter->ptp->secondary_mbx.peer_mbx_q_id;
+		ctlq_msg->host_id = adapter->ptp->secondary_mbx.peer_id;
+	} else {
+		ctlq_msg->opcode = idpf_mbq_opc_send_msg_to_pf;
+		ctlq_msg->func_id = 0;
+	}
 	ctlq_msg->data_len = msg_size;
 	ctlq_msg->cookie.mbx.chnl_opcode = op;
 	ctlq_msg->cookie.mbx.chnl_retval = VIRTCHNL_STATUS_SUCCESS;
diff --git a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idpf/idpf_ptp.c
new file mode 100644
index 0000000000..5c3fcb90e4
--- /dev/null
+++ b/drivers/net/intel/idpf/idpf_ptp.c
@@ -0,0 +1,504 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#include "idpf_ptp.h"
+#include "idpf_common_virtchnl.h"
+#include "base/virtchnl2.h"
+
+static enum idpf_ptp_access
+idpf_ptp_get_access(const struct idpf_adapter *adapter, uint32_t direct,
+		    uint32_t mailbox)
+{
+	if (adapter->ptp->caps & direct)
+		return IDPF_PTP_DIRECT;
+	else if (adapter->ptp->caps & mailbox)
+		return IDPF_PTP_MAILBOX;
+	else
+		return IDPF_PTP_NONE;
+}
+
+#define IDPF_PTP_ACCESS(adapter, cap) \
+	((uint8_t)idpf_ptp_get_access((adapter), (cap), (cap##_MB)))
+
+static void
+idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	ptp->get_dev_clk_time_access =
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME);
+	ptp->get_cross_tstamp_access =
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_CROSS_TIME);
+	ptp->set_dev_clk_time_access =
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME);
+	ptp->adj_dev_clk_time_access =
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK);
+	ptp->tx_tstamp_access =
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_TX_TSTAMPS);
+}
+
+int
+idpf_ptp_get_caps(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
+	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
+	struct virtchnl2_ptp_get_caps send_ptp_caps_msg = {0};
+	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
+	struct virtchnl2_ptp_get_caps *recv_ptp_caps_msg;
+	struct idpf_cmd_info args = {0};
+	struct idpf_ptp_secondary_mbx *scnd_mbx;
+	struct idpf_ptp *ptp = adapter->ptp;
+	struct idpf_hw *hw = &adapter->hw;
+	enum idpf_ptp_access access_type;
+	int err;
+	uint32_t temp_offset;
+
+	send_ptp_caps_msg.caps = CPU_TO_LE32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME |
+		VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
+		VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
+		VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
+		VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |
+		VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
+		VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
+		VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
+		VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
+		VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);
+
+	args.ops = VIRTCHNL2_OP_PTP_GET_CAPS;
+	args.in_args = (uint8_t *)&send_ptp_caps_msg;
+	args.in_args_size = sizeof(send_ptp_caps_msg);
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(*recv_ptp_caps_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	recv_ptp_caps_msg = (struct virtchnl2_ptp_get_caps *)args.out_buffer;
+	ptp->caps = LE32_TO_CPU(recv_ptp_caps_msg->caps);
+	ptp->base_incval = LE64_TO_CPU(recv_ptp_caps_msg->base_incval);
+	ptp->max_adj = LE32_TO_CPU(recv_ptp_caps_msg->max_adj);
+
+	scnd_mbx = &ptp->secondary_mbx;
+	scnd_mbx->peer_mbx_q_id = LE16_TO_CPU(recv_ptp_caps_msg->peer_mbx_q_id);
+	scnd_mbx->valid = scnd_mbx->peer_mbx_q_id != 0xffff;
+	if (scnd_mbx->valid)
+		scnd_mbx->peer_id = recv_ptp_caps_msg->peer_id;
+
+	idpf_ptp_get_features_access(adapter);
+
+	access_type = (enum idpf_ptp_access)ptp->get_dev_clk_time_access;
+	if (access_type == IDPF_PTP_DIRECT) {
+		clock_offsets = recv_ptp_caps_msg->clk_offsets;
+
+		temp_offset = LE32_TO_CPU(clock_offsets.dev_clk_ns_l);
+		ptp->dev_clk_regs.dev_clk_ns_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clock_offsets.dev_clk_ns_h);
+		ptp->dev_clk_regs.dev_clk_ns_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clock_offsets.phy_clk_ns_l);
+		ptp->dev_clk_regs.phy_clk_ns_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clock_offsets.phy_clk_ns_h);
+		ptp->dev_clk_regs.phy_clk_ns_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clock_offsets.cmd_sync_trigger);
+		ptp->dev_clk_regs.cmd_sync = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	}
+
+	access_type = (enum idpf_ptp_access)ptp->get_cross_tstamp_access;
+	if (access_type == IDPF_PTP_DIRECT) {
+		cross_tstamp_offsets = recv_ptp_caps_msg->cross_time_offsets;
+
+		temp_offset = LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_l);
+		ptp->dev_clk_regs.sys_time_ns_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_h);
+		ptp->dev_clk_regs.sys_time_ns_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(cross_tstamp_offsets.cmd_sync_trigger);
+		ptp->dev_clk_regs.cmd_sync = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	}
+
+	access_type = (enum idpf_ptp_access)ptp->adj_dev_clk_time_access;
+	if (access_type == IDPF_PTP_DIRECT) {
+		clk_adj_offsets = recv_ptp_caps_msg->clk_adj_offsets;
+
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_cmd_type);
+		ptp->dev_clk_regs.cmd = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_l);
+		ptp->dev_clk_regs.incval_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_h);
+		ptp->dev_clk_regs.incval_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_l);
+		ptp->dev_clk_regs.shadj_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_h);
+		ptp->dev_clk_regs.shadj_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_cmd_type);
+		ptp->dev_clk_regs.phy_cmd = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_l);
+		ptp->dev_clk_regs.phy_incval_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_h);
+		ptp->dev_clk_regs.phy_incval_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_l);
+		ptp->dev_clk_regs.phy_shadj_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_h);
+		ptp->dev_clk_regs.phy_shadj_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	}
+
+	return err;
+}
+
+static void
+idpf_ptp_enable_shtime(struct idpf_adapter *adapter)
+{
+	uint32_t shtime_enable, exec_cmd;
+
+	shtime_enable = adapter->ptp->cmd.shtime_enable_mask;
+	exec_cmd = adapter->ptp->cmd.exec_cmd_mask;
+
+	IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, shtime_enable);
+	IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync,
+			  exec_cmd | shtime_enable);
+}
+
+int
+idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+			  struct idpf_ptp_dev_timers *dev_clk_time)
+{
+	struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg = {0};
+	struct idpf_cmd_info args = {0};
+	int err;
+	uint64_t dev_time;
+
+	args.ops = VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME;
+	args.in_args = (uint8_t *)&get_dev_clk_time_msg;
+	args.in_args_size = sizeof(get_dev_clk_time_msg);
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(get_dev_clk_time_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	get_dev_clk_time_msg =
+		*(struct virtchnl2_ptp_get_dev_clk_time *)args.out_buffer;
+	dev_time = LE64_TO_CPU(get_dev_clk_time_msg.dev_time_ns);
+	dev_clk_time->dev_clk_time_ns = dev_time;
+
+	return err;
+}
+
+int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			 struct idpf_ptp_dev_timers *cross_time)
+{
+	struct virtchnl2_ptp_get_cross_time cross_time_msg = {0};
+	struct idpf_cmd_info args = {0};
+	int err;
+
+	args.ops = VIRTCHNL2_OP_PTP_GET_CROSS_TIME;
+	args.in_args = (uint8_t *)&cross_time_msg;
+	args.in_args_size = sizeof(cross_time_msg);
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(cross_time_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	cross_time_msg =
+		*(struct virtchnl2_ptp_get_cross_time *)args.out_buffer;
+	cross_time->dev_clk_time_ns = LE64_TO_CPU(cross_time_msg.dev_time_ns);
+	cross_time->sys_time_ns = LE64_TO_CPU(cross_time_msg.sys_time_ns);
+
+	return err;
+}
+
+int
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)
+{
+	struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg = {0};
+	struct idpf_cmd_info args = {0};
+	int err;
+
+	set_dev_clk_time_msg.dev_time_ns = CPU_TO_LE64(time);
+
+	args.ops = VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME;
+	args.in_args = (uint8_t *)&set_dev_clk_time_msg;
+	args.in_args_size = sizeof(set_dev_clk_time_msg);
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(set_dev_clk_time_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int
+idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta)
+{
+	struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg = {0};
+	struct idpf_cmd_info args = {0};
+	int err;
+
+	adj_dev_clk_time_msg.delta = CPU_TO_LE64(delta);
+
+	args.ops = VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME;
+	args.in_args = (uint8_t *)&adj_dev_clk_time_msg;
+	args.in_args_size = sizeof(adj_dev_clk_time_msg);
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(adj_dev_clk_time_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int
+idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval)
+{
+	struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg = {0};
+	struct idpf_cmd_info args = {0};
+	int err;
+
+	adj_dev_clk_fine_msg.incval = CPU_TO_LE64(incval);
+
+	args.ops = VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE;
+	args.in_args = (uint8_t *)&adj_dev_clk_fine_msg;
+	args.in_args_size = sizeof(adj_dev_clk_fine_msg);
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(adj_dev_clk_fine_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int
+idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
+{
+	struct virtchnl2_ptp_get_vport_tx_tstamp_caps send_tx_tstamp_caps = {0};
+	struct virtchnl2_ptp_get_vport_tx_tstamp_caps *rcv_tx_tstamp_caps;
+	struct virtchnl2_ptp_tx_tstamp_latch_caps tx_tstamp_latch_caps;
+	enum idpf_ptp_access tstamp_access, get_dev_clk_access;
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
+	struct idpf_ptp *ptp = vport->adapter->ptp;
+	struct idpf_cmd_info args = {0};
+	int err;
+	uint16_t num_latches, id;
+	uint32_t size;
+
+	if (ptp == NULL)
+		return -EOPNOTSUPP;
+
+	tstamp_access = (enum idpf_ptp_access)ptp->tx_tstamp_access;
+	get_dev_clk_access = (enum idpf_ptp_access)ptp->get_dev_clk_time_access;
+	if (tstamp_access == IDPF_PTP_NONE ||
+	    get_dev_clk_access == IDPF_PTP_NONE)
+		return -EOPNOTSUPP;
+
+	send_tx_tstamp_caps.vport_id = CPU_TO_LE32(vport->vport_id);
+
+	args.ops = VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS;
+	args.in_args = (uint8_t *)&send_tx_tstamp_caps;
+	args.in_args_size = sizeof(send_tx_tstamp_caps);
+	args.out_size = IDPF_CTLQ_MAX_BUF_LEN;
+	args.out_buffer = vport->adapter->mbx_resp;
+
+	err = idpf_vc_cmd_execute(vport->adapter, &args);
+	if (err < 0)
+		return err;
+
+	rcv_tx_tstamp_caps =
+		(struct virtchnl2_ptp_get_vport_tx_tstamp_caps *)args.out_buffer;
+	num_latches = LE16_TO_CPU(rcv_tx_tstamp_caps->num_latches);
+	size = sizeof(struct idpf_ptp_vport_tx_tstamp_caps) +
+		sizeof(struct idpf_ptp_tx_tstamp) * num_latches;
+	tstamp_caps = rte_zmalloc(NULL, size, 0);
+	if (tstamp_caps == NULL)
+		return -ENOMEM;
+
+	tstamp_caps->access = true;
+	tstamp_caps->num_entries = num_latches;
+	tstamp_caps->tstamp_ns_lo_bit = rcv_tx_tstamp_caps->tstamp_ns_lo_bit;
+
+	for (id = 0; id < tstamp_caps->num_entries; id++) {
+		__le32 offset_l, offset_h;
+
+		tx_tstamp_latch_caps = rcv_tx_tstamp_caps->tstamp_latches[id];
+
+		if (tstamp_access == IDPF_PTP_DIRECT) {
+			offset_l = tx_tstamp_latch_caps.tx_latch_reg_offset_l;
+			offset_h = tx_tstamp_latch_caps.tx_latch_reg_offset_h;
+			tstamp_caps->tx_tstamp[id].tx_latch_reg_offset_l =
+				LE32_TO_CPU(offset_l);
+			tstamp_caps->tx_tstamp[id].tx_latch_reg_offset_h =
+				LE32_TO_CPU(offset_h);
+		}
+		tstamp_caps->tx_tstamp[id].idx = tx_tstamp_latch_caps.index;
+	}
+
+	tstamp_caps->latched_idx = -1;
+	vport->tx_tstamp_caps = tstamp_caps;
+
+	return err;
+}
+
+static int
+idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
+			 struct virtchnl2_ptp_tx_tstamp_latch *tstamp_latch,
+			 struct idpf_ptp_tx_tstamp *tx_tstamp)
+{
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+	uint8_t tstamp_ns_lo_bit;
+
+	tx_tstamp_caps = vport->tx_tstamp_caps;
+	tstamp_ns_lo_bit = tx_tstamp_caps->tstamp_ns_lo_bit;
+
+	tx_tstamp->tstamp = LE64_TO_CPU(tstamp_latch->tstamp);
+	tx_tstamp->tstamp >>= tstamp_ns_lo_bit;
+
+	return 0;
+}
+
+int
+idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
+{
+	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_msg;
+	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *recv_tx_tstamp_msg;
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+	struct virtchnl2_ptp_tx_tstamp_latch tstamp_latch;
+	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
+	struct idpf_cmd_info args = {0};
+	int size, msg_size;
+	uint32_t vport_id;
+	uint16_t num_latches, id;
+	int err;
+
+	tx_tstamp_caps = vport->tx_tstamp_caps;
+	ptp_tx_tstamp = tx_tstamp_caps->tx_tstamp;
+
+	size = sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+		sizeof(struct virtchnl2_ptp_tx_tstamp_latch) *
+		tx_tstamp_caps->num_entries;
+	send_tx_tstamp_msg = rte_zmalloc(NULL, size, 0);
+	if (send_tx_tstamp_msg == NULL)
+		return -ENOMEM;
+
+	for (id = 0; id < tx_tstamp_caps->num_entries; id++, ptp_tx_tstamp++)
+		send_tx_tstamp_msg->tstamp_latches[id].index = ptp_tx_tstamp->idx;
+	send_tx_tstamp_msg->get_devtime_with_txtstmp = 1;
+
+	msg_size = sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+		sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;
+	send_tx_tstamp_msg->vport_id = CPU_TO_LE32(vport->vport_id);
+	send_tx_tstamp_msg->num_latches = CPU_TO_LE16(id);
+
+	args.ops = VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP;
+	args.in_args = (uint8_t *)send_tx_tstamp_msg;
+	args.in_args_size = msg_size;
+	args.out_size = msg_size;
+	args.out_buffer = vport->adapter->mbx_resp;
+
+	err = idpf_vc_cmd_execute(vport->adapter, &args);
+	rte_free(send_tx_tstamp_msg);
+	if (err < 0)
+		return err;
+
+	recv_tx_tstamp_msg =
+		(struct virtchnl2_ptp_get_vport_tx_tstamp_latches *)args.out_buffer;
+	vport_id = LE32_TO_CPU(recv_tx_tstamp_msg->vport_id);
+	if (vport->vport_id != vport_id)
+		return -EINVAL;
+
+	num_latches = LE16_TO_CPU(recv_tx_tstamp_msg->num_latches);
+
+	ptp_tx_tstamp = tx_tstamp_caps->tx_tstamp;
+	for (id = 0; id < num_latches; id++, ptp_tx_tstamp++) {
+		tstamp_latch = recv_tx_tstamp_msg->tstamp_latches[id];
+
+		if (!tstamp_latch.valid)
+			continue;
+
+		err = idpf_ptp_get_tstamp_value(vport, &tstamp_latch,
+						ptp_tx_tstamp);
+		if (err == 0) {
+			tx_tstamp_caps->latched_idx = id;
+			vport->adapter->time_hw = recv_tx_tstamp_msg->device_time;
+		}
+		break;
+	}
+
+	return err;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter, uint64_t *src_clk)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	uint32_t hi, lo;
+
+	idpf_ptp_enable_shtime(adapter);
+
+	lo = IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_l);
+	hi = IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_h);
+
+	*src_clk = ((uint64_t)hi << 32) | lo;
+	return 0;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value through mailbox
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,
+					    uint64_t *src_clk)
+{
+	struct idpf_ptp_dev_timers clk_time;
+	int err;
+
+	err = idpf_ptp_get_dev_clk_time(adapter, &clk_time);
+	if (err)
+		return err;
+
+	*src_clk = clk_time.dev_clk_time_ns;
+	return 0;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg - Read the main timer value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *src_clk)
+{
+	if (adapter->ptp == NULL)
+		return -EINVAL;
+
+	switch ((enum idpf_ptp_access)adapter->ptp->get_dev_clk_time_access) {
+	case IDPF_PTP_MAILBOX:
+		return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);
+	case IDPF_PTP_DIRECT:
+		return idpf_ptp_read_src_clk_reg_direct(adapter, src_clk);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/idpf_ptp.h
new file mode 100644
index 0000000000..0c901440fb
--- /dev/null
+++ b/drivers/net/intel/idpf/idpf_ptp.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _IDPF_PTP_H_
+#define _IDPF_PTP_H_
+
+#include "base/idpf_osdep.h"
+#include <rte_time.h>
+#include "idpf_common_device.h"
+
+struct idpf_ptp_cmd {
+	uint32_t exec_cmd_mask;
+	uint32_t shtime_enable_mask;
+};
+
+struct idpf_ptp_dev_clk_regs {
+	volatile uint32_t *dev_clk_ns_l;
+	volatile uint32_t *dev_clk_ns_h;
+	volatile uint32_t *phy_clk_ns_l;
+	volatile uint32_t *phy_clk_ns_h;
+	volatile uint32_t *sys_time_ns_l;
+	volatile uint32_t *sys_time_ns_h;
+	volatile uint32_t *incval_l;
+	volatile uint32_t *incval_h;
+	volatile uint32_t *shadj_l;
+	volatile uint32_t *shadj_h;
+	volatile uint32_t *phy_incval_l;
+	volatile uint32_t *phy_incval_h;
+	volatile uint32_t *phy_shadj_l;
+	volatile uint32_t *phy_shadj_h;
+	volatile uint32_t *cmd;
+	volatile uint32_t *phy_cmd;
+	volatile uint32_t *cmd_sync;
+};
+
+enum idpf_ptp_access {
+	IDPF_PTP_NONE = 0,
+	IDPF_PTP_DIRECT,
+	IDPF_PTP_MAILBOX,
+};
+
+struct idpf_ptp_secondary_mbx {
+	uint16_t peer_mbx_q_id;
+	uint16_t peer_id;
+	bool valid:1;
+};
+
+enum idpf_ptp_tx_tstamp_state {
+	IDPF_PTP_FREE,
+	IDPF_PTP_REQUEST,
+	IDPF_PTP_READ_VALUE,
+};
+
+struct idpf_ptp_tx_tstamp {
+	uint64_t tstamp;
+	uint32_t tx_latch_reg_offset_l;
+	uint32_t tx_latch_reg_offset_h;
+	uint32_t idx;
+};
+
+struct idpf_ptp_vport_tx_tstamp_caps {
+	uint32_t vport_id;
+	uint16_t num_entries;
+	uint16_t tstamp_ns_lo_bit;
+	uint16_t latched_idx;
+	bool access:1;
+	struct idpf_ptp_tx_tstamp tx_tstamp[];
+};
+
+struct idpf_ptp {
+	uint64_t base_incval;
+	uint64_t max_adj;
+	struct idpf_ptp_cmd cmd;
+	struct idpf_ptp_dev_clk_regs dev_clk_regs;
+	uint32_t caps;
+	uint8_t get_dev_clk_time_access:2;
+	uint8_t get_cross_tstamp_access:2;
+	uint8_t set_dev_clk_time_access:2;
+	uint8_t adj_dev_clk_time_access:2;
+	uint8_t tx_tstamp_access:2;
+	uint8_t rsv:6;
+	struct idpf_ptp_secondary_mbx secondary_mbx;
+};
+
+struct idpf_ptp_dev_timers {
+	uint64_t sys_time_ns;
+	uint64_t dev_clk_time_ns;
+};
+
+int idpf_ptp_get_caps(struct idpf_adapter *adapter);
+int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *src_clk);
+int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+			     struct idpf_ptp_dev_timers *dev_clk_time);
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time);
+int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time);
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval);
+int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta);
+int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
+int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
+
+static inline uint64_t
+idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
+			    bool is_rx, uint32_t in_timestamp)
+{
+	const uint64_t mask = 0xFFFFFFFFULL;
+	uint32_t phc_time_lo, delta;
+	uint64_t ns;
+
+	if (flag != 0)
+		idpf_ptp_read_src_clk_reg(ad, &ad->time_hw);
+
+	phc_time_lo = (uint32_t)(ad->time_hw);
+	delta = in_timestamp - phc_time_lo;
+
+	if (delta > mask / 2) {
+		delta = phc_time_lo - in_timestamp;
+		ns = ad->time_hw - delta;
+	} else {
+		if (is_rx)
+			ns = ad->time_hw - delta;
+		else
+			ns = ad->time_hw + delta;
+	}
+
+	return ns;
+}
+
+#endif /* _IDPF_PTP_H_ */
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index a805d02ea2..740c1a5985 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -17,6 +17,7 @@ sources += files(
         'idpf_common_virtchnl.c',
 
         'idpf_ethdev.c',
+        'idpf_ptp.c',
         'idpf_rxtx.c',
 )
 
-- 
2.47.1

