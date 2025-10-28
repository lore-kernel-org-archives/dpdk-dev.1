Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3FACCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 17:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC4540430;
	Mon, 27 Oct 2025 18:27:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D5E454021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 18:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761586059; x=1793122059;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fxXIvQkwG1tIrRbuGl1NukuecMhzxL/W6pM5rs34ks8=;
 b=LgIYwr+h1HH1WEoKIwLFflyTrEjR1myebCQDFumxoO8DupZkMsaz5Ox6
 YndH7mzms5LSaNcgCt8h7sQfbV5VyXCIXSiBm4T1M2URExSQNGosSyqGY
 bW+PtAsAlSrFOrCxsak/Xbj/kUu6EEid36pOSbc0N7V8AMSvUooGlUwMl
 SQgP8Qrgdm4gsvpRlD4our3q3grAq2OS9zb7gHv/1WmjyzV3CkwdNk4V+
 2dNe83BmMIKRF+thpFCO8sQX4jksZuJFFEHwKRdlPzOBepIW5X76vt99H
 ES7JBWoSggKFc6fECrGeMa+RbkGg3LwnwxqfF6QFrWlefuMg5h9ivdP6q w==;
X-CSE-ConnectionGUID: mnrIR0U4QySV1QZWV7GURg==
X-CSE-MsgGUID: /OFh/tbrQ7a/QdbZKUrNuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74350892"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; d="scan'208";a="74350892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 10:27:38 -0700
X-CSE-ConnectionGUID: qwh69dKGQcidD1YKzt/QLg==
X-CSE-MsgGUID: sjTXtR6xTdCICBX+j7L+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; d="scan'208";a="189140752"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa003.jf.intel.com with ESMTP; 27 Oct 2025 10:27:36 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v2 2/4] net/idpf: add PTP virtchnl2 support
Date: Tue, 28 Oct 2025 02:07:56 -0400
Message-ID: <20251028060758.233929-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028060758.233929-1-soumyadeep.hore@intel.com>
References: <20251024120840.420016-5-soumyadeep.hore@intel.com>
 <20251028060758.233929-1-soumyadeep.hore@intel.com>
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
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  34 +-
 drivers/net/intel/idpf/idpf_ptp.c             | 646 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 227 ++++++
 drivers/net/intel/idpf/meson.build            |   1 +
 5 files changed, 910 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index c32dcfbb12..3c84b96225 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -90,6 +90,7 @@ struct idpf_adapter {
 
 	/* For timestamp */
 	uint64_t time_hw;
+	struct idpf_ptp *ptp;
 
 	enum idpf_rx_func_type rx_func_type;
 };
@@ -161,6 +162,9 @@ struct idpf_vport {
 	/* Event from ipf */
 	bool link_up;
 	uint32_t link_speed;
+
+	/* For PTP */
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 };
 
 /* Message type read in virtual channel from PF */
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index e927d7415a..a28bc9bee6 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -4,6 +4,7 @@
 
 #include "idpf_common_virtchnl.h"
 #include "idpf_common_logs.h"
+#include "idpf_ptp.h"
 
 #include <eal_export.h>
 
@@ -38,6 +39,28 @@ idpf_vc_clean(struct idpf_adapter *adapter)
 	return 0;
 }
 
+/**
+ * idpf_ptp_is_mb_msg - Check if the message is PTP-related
+ * @op: virtchnl opcode
+ *
+ * Returns true if msg is PTP-related, false otherwise
+ */
+static inline bool idpf_ptp_is_mb_msg(uint32_t op)
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
@@ -71,8 +94,15 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,
 
 	memcpy(dma_mem->va, msg, msg_size);
 
-	ctlq_msg->opcode = idpf_mbq_opc_send_msg_to_pf;
-	ctlq_msg->func_id = 0;
+	if (idpf_ptp_is_mb_msg(op) && adapter->ptp->secondary_mbx.valid) {
+		ctlq_msg->opcode = idpf_mbq_opc_send_msg_to_peer_drv;
+		ctlq_msg->func_id = adapter->ptp->secondary_mbx.peer_mbx_q_id;
+		ctlq_msg->host_id = adapter->ptp->secondary_mbx.peer_id;
+	} else {
+		ctlq_msg->opcode = idpf_mbq_opc_send_msg_to_pf;
+		ctlq_msg->func_id = 0;
+	}
+
 	ctlq_msg->data_len = msg_size;
 	ctlq_msg->cookie.mbx.chnl_opcode = op;
 	ctlq_msg->cookie.mbx.chnl_retval = VIRTCHNL_STATUS_SUCCESS;
diff --git a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idpf/idpf_ptp.c
new file mode 100644
index 0000000000..3a364adc93
--- /dev/null
+++ b/drivers/net/intel/idpf/idpf_ptp.c
@@ -0,0 +1,646 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2001-2025 Intel Corporation
+ */
+
+#include "idpf_ptp.h"
+#include <base/virtchnl2.h>
+#include "idpf_common_virtchnl.h"
+
+/**
+ * idpf_ptp_get_access - Determine the access type of the PTP features
+ * @adapter: Driver specific private structure
+ * @direct: Capability that indicates the direct access
+ * @mailbox: Capability that indicates the mailbox access
+ *
+ * Return: the type of supported access for the PTP feature.
+ */
+static enum idpf_ptp_access
+idpf_ptp_get_access(const struct idpf_adapter *adapter, u32 direct, u32 mailbox)
+{
+	if (adapter->ptp->caps & direct)
+		return IDPF_PTP_DIRECT;
+	else if (adapter->ptp->caps & mailbox)
+		return IDPF_PTP_MAILBOX;
+	else
+		return IDPF_PTP_NONE;
+}
+
+/**
+ * idpf_ptp_get_features_access - Determine the access type of PTP features
+ * @adapter: Driver specific private structure
+ *
+ * Fulfill the adapter structure with type of the supported PTP features
+ * access.
+ */
+static void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	u32 direct, mailbox;
+
+	/* Get the device clock time */
+	direct = VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB;
+	ptp->get_dev_clk_time_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
+	/* Get the cross timestamp */
+	direct = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB;
+	ptp->get_cross_tstamp_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
+	/* Set the device clock time */
+	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
+	ptp->set_dev_clk_time_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
+	/* Adjust the device clock time */
+	direct = VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK;
+	mailbox = VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB;
+	ptp->adj_dev_clk_time_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
+	/* Tx timestamping */
+	direct = VIRTCHNL2_CAP_PTP_TX_TSTAMPS;
+	mailbox = VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB;
+	ptp->tx_tstamp_access = idpf_ptp_get_access(adapter,
+						    direct,
+						    mailbox);
+}
+
+/**
+ * idpf_ptp_get_caps - Send virtchnl get ptp capabilities message
+ * @adapter: Driver specific private structure
+ *
+ * Send virtchnl get PTP capabilities message.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int idpf_ptp_get_caps(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
+	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
+	struct virtchnl2_ptp_get_caps send_ptp_caps_msg = { };
+	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
+	struct virtchnl2_ptp_get_caps *recv_ptp_caps_msg;
+	struct idpf_cmd_info args = { };
+	struct idpf_ptp_secondary_mbx *scnd_mbx;
+	struct idpf_ptp *ptp = adapter->ptp;
+	struct idpf_hw *hw = &adapter->hw;
+	enum idpf_ptp_access access_type;
+	int err = 0;
+	u32 temp_offset;
+
+	send_ptp_caps_msg.caps = CPU_TO_LE32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME |
+					     VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
+					     VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
+					     VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
+					     VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |
+					     VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
+					     VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
+					     VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
+					     VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
+					     VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);
+
+	args.ops = VIRTCHNL2_OP_PTP_GET_CAPS;
+	args.in_args = (uint8_t *)&send_ptp_caps_msg;
+	args.in_args_size = sizeof(send_ptp_caps_msg);
+	recv_ptp_caps_msg = rte_zmalloc(NULL,
+					sizeof(struct virtchnl2_ptp_get_caps), 0);
+	if (!recv_ptp_caps_msg)
+		return -ENOMEM;
+
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = sizeof(*recv_ptp_caps_msg);
+
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		goto free_mem;
+
+	recv_ptp_caps_msg = (struct virtchnl2_ptp_get_caps *)args.out_buffer;
+	ptp->caps = LE32_TO_CPU(recv_ptp_caps_msg->caps);
+	ptp->base_incval = LE64_TO_CPU(recv_ptp_caps_msg->base_incval);
+	ptp->max_adj = LE32_TO_CPU(recv_ptp_caps_msg->max_adj);
+
+	scnd_mbx = &ptp->secondary_mbx;
+	scnd_mbx->peer_mbx_q_id = LE16_TO_CPU(recv_ptp_caps_msg->peer_mbx_q_id);
+
+	/* if the ptp_mb_q_id holds invalid value (0xffff), the secondary
+	 * mailbox is not supported.
+	 */
+	scnd_mbx->valid = scnd_mbx->peer_mbx_q_id != 0xffff;
+	if (scnd_mbx->valid)
+		scnd_mbx->peer_id = recv_ptp_caps_msg->peer_id;
+
+	/* Determine the access type for the PTP features */
+	idpf_ptp_get_features_access(adapter);
+
+	access_type = ptp->get_dev_clk_time_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		goto cross_tstamp;
+
+	clock_offsets = recv_ptp_caps_msg->clk_offsets;
+
+	temp_offset = LE32_TO_CPU(clock_offsets.dev_clk_ns_l);
+	ptp->dev_clk_regs.dev_clk_ns_l = IDPF_PCI_REG_ADDR(hw,
+							   temp_offset);
+	temp_offset = LE32_TO_CPU(clock_offsets.dev_clk_ns_h);
+	ptp->dev_clk_regs.dev_clk_ns_h = IDPF_PCI_REG_ADDR(hw,
+							   temp_offset);
+	temp_offset = LE32_TO_CPU(clock_offsets.phy_clk_ns_l);
+	ptp->dev_clk_regs.phy_clk_ns_l = IDPF_PCI_REG_ADDR(hw,
+				  temp_offset);
+	temp_offset = LE32_TO_CPU(clock_offsets.phy_clk_ns_h);
+	ptp->dev_clk_regs.phy_clk_ns_h = IDPF_PCI_REG_ADDR(hw,
+				  temp_offset);
+	temp_offset = LE32_TO_CPU(clock_offsets.cmd_sync_trigger);
+	ptp->dev_clk_regs.cmd_sync = IDPF_PCI_REG_ADDR(hw, temp_offset);
+
+cross_tstamp:
+	access_type = ptp->get_cross_tstamp_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		goto discipline_clock;
+
+	cross_tstamp_offsets = recv_ptp_caps_msg->cross_time_offsets;
+
+	temp_offset = LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_l);
+	ptp->dev_clk_regs.sys_time_ns_l = IDPF_PCI_REG_ADDR(hw,
+					temp_offset);
+	temp_offset = LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_h);
+	ptp->dev_clk_regs.sys_time_ns_h = IDPF_PCI_REG_ADDR(hw,
+					temp_offset);
+	temp_offset = LE32_TO_CPU(cross_tstamp_offsets.cmd_sync_trigger);
+	ptp->dev_clk_regs.cmd_sync = IDPF_PCI_REG_ADDR(hw, temp_offset);
+
+discipline_clock:
+	access_type = ptp->adj_dev_clk_time_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		return err;
+
+	clk_adj_offsets = recv_ptp_caps_msg->clk_adj_offsets;
+
+	/* Device clock offsets */
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_cmd_type);
+	ptp->dev_clk_regs.cmd = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_l);
+	ptp->dev_clk_regs.incval_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_h);
+	ptp->dev_clk_regs.incval_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_l);
+	ptp->dev_clk_regs.shadj_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_h);
+	ptp->dev_clk_regs.shadj_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+
+	/* PHY clock offsets */
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_cmd_type);
+	ptp->dev_clk_regs.phy_cmd = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_l);
+	ptp->dev_clk_regs.phy_incval_l = IDPF_PCI_REG_ADDR(hw,
+				  temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_h);
+	ptp->dev_clk_regs.phy_incval_h = IDPF_PCI_REG_ADDR(hw,
+				  temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_l);
+	ptp->dev_clk_regs.phy_shadj_l = IDPF_PCI_REG_ADDR(hw, temp_offset);
+	temp_offset = LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_h);
+	ptp->dev_clk_regs.phy_shadj_h = IDPF_PCI_REG_ADDR(hw, temp_offset);
+
+free_mem:
+	rte_free(recv_ptp_caps_msg);
+
+	return err;
+}
+
+/**
+ * idpf_ptp_enable_shtime - Enable shadow time and execute a command
+ * @adapter: Driver specific private structure
+ */
+static void idpf_ptp_enable_shtime(struct idpf_adapter *adapter)
+{
+	uint32_t shtime_enable, exec_cmd;
+
+	/* Get offsets */
+	shtime_enable = adapter->ptp->cmd.shtime_enable_mask;
+	exec_cmd = adapter->ptp->cmd.exec_cmd_mask;
+
+	/* Set the shtime en and the sync field */
+	IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, shtime_enable);
+	IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, exec_cmd | shtime_enable);
+}
+
+/**
+ * idpf_ptp_get_dev_clk_time - Send virtchnl get device clk time message
+ * @adapter: Driver specific private structure
+ * @dev_clk_time: Pointer to the device clock structure where the value is set
+ *
+ * Send virtchnl get time message to get the time of the clock.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+			      struct idpf_ptp_dev_timers *dev_clk_time)
+{
+	struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg = { };
+	struct idpf_cmd_info args = { };
+	int err = 0;
+	u64 dev_time;
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
+	get_dev_clk_time_msg = *(struct virtchnl2_ptp_get_dev_clk_time *)args.out_buffer;
+	dev_time = LE64_TO_CPU(get_dev_clk_time_msg.dev_time_ns);
+	dev_clk_time->dev_clk_time_ns = dev_time;
+
+	return err;
+}
+
+/**
+ * idpf_ptp_get_cross_time - Send virtchnl get cross time message
+ * @adapter: Driver specific private structure
+ * @cross_time: Pointer to the device clock structure where the value is set
+ *
+ * Send virtchnl get cross time message to get the time of the clock and the
+ * system time.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time)
+{
+	struct virtchnl2_ptp_get_cross_time cross_time_msg = { };
+	struct idpf_cmd_info args = { };
+	int err = 0;
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
+	cross_time_msg = *(struct virtchnl2_ptp_get_cross_time *)args.out_buffer;
+	cross_time->dev_clk_time_ns = LE64_TO_CPU(cross_time_msg.dev_time_ns);
+	cross_time->sys_time_ns = LE64_TO_CPU(cross_time_msg.sys_time_ns);
+
+	return err;
+}
+
+/**
+ * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
+ * @adapter: Driver specific private structure
+ * @time: New time value
+ *
+ * Send virtchnl set time message to set the time of the clock.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
+{
+	struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg = { };
+	struct idpf_cmd_info args = { };
+	int err = 0;
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
+/**
+ * idpf_ptp_adj_dev_clk_time - Send virtchnl adj device clock time message
+ * @adapter: Driver specific private structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * Send virtchnl adj time message to adjust the clock by the indicated delta.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
+{
+	struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg = { };
+	struct idpf_cmd_info args = { };
+	int err = 0;
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
+/**
+ * idpf_ptp_adj_dev_clk_fine - Send virtchnl adj time message
+ * @adapter: Driver specific private structure
+ * @incval: Source timer increment value per clock cycle
+ *
+ * Send virtchnl adj fine message to adjust the frequency of the clock by
+ * incval.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval)
+{
+	struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg = { };
+	struct idpf_cmd_info args = { };
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
+/**
+ * idpf_ptp_get_vport_tstamps_caps - Send virtchnl to get tstamps caps for vport
+ * @vport: Virtual port structure
+ *
+ * Send virtchnl get vport tstamps caps message to receive the set of tstamp
+ * capabilities per vport.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
+{
+	struct virtchnl2_ptp_get_vport_tx_tstamp_caps send_tx_tstamp_caps = { };
+	struct virtchnl2_ptp_get_vport_tx_tstamp_caps *rcv_tx_tstamp_caps;
+	struct virtchnl2_ptp_tx_tstamp_latch_caps tx_tstamp_latch_caps;
+	enum idpf_ptp_access tstamp_access, get_dev_clk_access;
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
+	struct idpf_ptp *ptp = vport->adapter->ptp;
+	struct idpf_cmd_info args = { };
+	int err = 0;
+	u16 num_latches, i;
+	u32 size;
+
+	if (!ptp)
+		return -EOPNOTSUPP;
+
+	tstamp_access = ptp->tx_tstamp_access;
+	get_dev_clk_access = ptp->get_dev_clk_time_access;
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
+	rcv_tx_tstamp_caps = (struct virtchnl2_ptp_get_vport_tx_tstamp_caps *)
+			     args.out_buffer;
+	num_latches = LE16_TO_CPU(rcv_tx_tstamp_caps->num_latches);
+	size = sizeof(struct idpf_ptp_vport_tx_tstamp_caps) +
+	       sizeof(struct idpf_ptp_tx_tstamp) * num_latches;
+	tstamp_caps = rte_zmalloc(NULL, size, 0);
+	if (!tstamp_caps)
+		return -ENOMEM;
+
+	tstamp_caps->access = true;
+	tstamp_caps->num_entries = num_latches;
+
+	tstamp_caps->tstamp_ns_lo_bit = rcv_tx_tstamp_caps->tstamp_ns_lo_bit;
+
+	for (i = 0; i < tstamp_caps->num_entries; i++) {
+		__le32 offset_l, offset_h;
+
+		tx_tstamp_latch_caps = rcv_tx_tstamp_caps->tstamp_latches[i];
+
+		if (tstamp_access == IDPF_PTP_DIRECT) {
+			offset_l = tx_tstamp_latch_caps.tx_latch_reg_offset_l;
+			offset_h = tx_tstamp_latch_caps.tx_latch_reg_offset_h;
+			tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_l = LE32_TO_CPU(offset_l);
+			tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_h = LE32_TO_CPU(offset_h);
+		}
+		tstamp_caps->tx_tstamp[i].idx = tx_tstamp_latch_caps.index;
+	}
+
+	tstamp_caps->latched_idx = -1;
+	vport->tx_tstamp_caps = tstamp_caps;
+
+	return err;
+}
+
+/**
+ * idpf_ptp_get_tstamp_value - Get the Tx timestamp value and provide it
+ *			       back to the skb.
+ * @vport: Virtual port structure
+ * @tstamp_latch: Tx timestamp latch structure fulfilled by the Control Plane
+ * @tx_tstamp: Tx timestamp structure to be fulfilled with the timestamp value
+ *
+ * Read the value of the Tx timestamp for a given latch received from the
+ * Control Plane.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
+			  struct virtchnl2_ptp_tx_tstamp_latch *tstamp_latch,
+			  struct idpf_ptp_tx_tstamp *tx_tstamp)
+{
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+	u8 tstamp_ns_lo_bit;
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
+/**
+ * idpf_ptp_get_tx_tstamp - Send virtchnl get Tx timestamp latches message
+ * @vport: Virtual port structure
+ *
+ * Send virtchnl get Tx tstamp message to read the value of the HW timestamp.
+ * The message contains a list of indexes set in the Tx descriptors.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
+{
+	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_msg;
+	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *recv_tx_tstamp_msg;
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+	struct virtchnl2_ptp_tx_tstamp_latch tstamp_latch;
+	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
+	struct idpf_cmd_info args = { };
+	int size, msg_size;
+	u32 vport_id;
+	u16 num_latches, id;
+	int err = 0;
+
+	tx_tstamp_caps = vport->tx_tstamp_caps;
+	ptp_tx_tstamp = tx_tstamp_caps->tx_tstamp;
+
+	size = sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+	      sizeof(struct virtchnl2_ptp_tx_tstamp_latch) *
+	      tx_tstamp_caps->num_entries;
+	send_tx_tstamp_msg = rte_zmalloc(NULL, size, 0);
+	if (!send_tx_tstamp_msg)
+		return -ENOMEM;
+
+	for (id = 0; id < tx_tstamp_caps->num_entries; id++,
+		ptp_tx_tstamp++)
+		send_tx_tstamp_msg->tstamp_latches[id].index =
+										ptp_tx_tstamp->idx;
+	send_tx_tstamp_msg->get_devtime_with_txtstmp = 1;
+
+	msg_size = sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+		   sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;
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
+	recv_tx_tstamp_msg = (struct virtchnl2_ptp_get_vport_tx_tstamp_latches *)
+			     args.out_buffer;
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
+		if (!err) {
+			tx_tstamp_caps->latched_idx = id;
+			vport->adapter->time_hw = recv_tx_tstamp_msg->device_time;
+		}
+		break;
+	}
+	return err;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
+ * @adapter: Driver specific private structure
+ *
+ * Return: the device clock time.
+ */
+static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	u32 hi, lo;
+
+	idpf_ptp_enable_shtime(adapter);
+
+	lo = IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_l);
+	hi = IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_h);
+
+	return ((u64)hi << 32) | lo;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value through mailbox
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,
+					     u64 *src_clk)
+{
+	struct idpf_ptp_dev_timers clk_time;
+	int err = 0;
+
+	err = idpf_ptp_get_dev_clk_time(adapter, &clk_time);
+	if (err)
+		return err;
+
+	*src_clk = clk_time.dev_clk_time_ns;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg - Read the main timer value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: the device clock time on success, -errno otherwise.
+ */
+int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk)
+{
+	if (!adapter->ptp)
+		return 0;
+	switch (adapter->ptp->get_dev_clk_time_access) {
+	case IDPF_PTP_NONE:
+		return -EOPNOTSUPP;
+	case IDPF_PTP_MAILBOX:
+		return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);
+	case IDPF_PTP_DIRECT:
+		*src_clk = idpf_ptp_read_src_clk_reg_direct(adapter);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/idpf_ptp.h
new file mode 100644
index 0000000000..3fc000a5a6
--- /dev/null
+++ b/drivers/net/intel/idpf/idpf_ptp.h
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2001-2025 Intel Corporation
+ */
+
+#ifndef _IDPF_PTP_H_
+#define _IDPF_PTP_H_
+
+#include "idpf_osdep.h"
+#include "rte_time.h"
+#include "idpf_common_device.h"
+
+/**
+ * struct idpf_ptp_cmd - PTP command masks
+ * @exec_cmd_mask: mask to trigger command execution
+ * @shtime_enable_mask: mask to enable shadow time
+ */
+struct idpf_ptp_cmd {
+	u32 exec_cmd_mask;
+	u32 shtime_enable_mask;
+};
+
+/* struct idpf_ptp_dev_clk_regs - PTP device registers
+ * @dev_clk_ns_l: low part of the device clock register
+ * @dev_clk_ns_h: high part of the device clock register
+ * @phy_clk_ns_l: low part of the PHY clock register
+ * @phy_clk_ns_h: high part of the PHY clock register
+ * @sys_time_ns_l: low part of the system time register
+ * @sys_time_ns_h: high part of the system time register
+ * @incval_l: low part of the increment value register
+ * @incval_h: high part of the increment value register
+ * @shadj_l: low part of the shadow adjust register
+ * @shadj_h: high part of the shadow adjust register
+ * phy_incval_l: low part of the PHY increment value register
+ * phy_incval_h: high part of the PHY increment value register
+ * phy_shadj_l: low part of the PHY shadow adjust register
+ * phy_shadj_h: high part of the PHY shadow adjust register
+ * @cmd: PTP command register
+ * @phy_cmd: PHY command register
+ * @cmd_sync: PTP command synchronization register
+ */
+struct idpf_ptp_dev_clk_regs {
+	/* Main clock */
+	volatile uint32_t *dev_clk_ns_l;
+	volatile uint32_t *dev_clk_ns_h;
+
+	/* PHY timer */
+	volatile uint32_t *phy_clk_ns_l;
+	volatile uint32_t *phy_clk_ns_h;
+
+	/* System time */
+	volatile uint32_t *sys_time_ns_l;
+	volatile uint32_t *sys_time_ns_h;
+
+	/* Main timer adjustments */
+	volatile uint32_t *incval_l;
+	volatile uint32_t *incval_h;
+	volatile uint32_t *shadj_l;
+	volatile uint32_t *shadj_h;
+
+	/* PHY timer adjustments */
+	volatile uint32_t *phy_incval_l;
+	volatile uint32_t *phy_incval_h;
+	volatile uint32_t *phy_shadj_l;
+	volatile uint32_t *phy_shadj_h;
+
+	/* Command */
+	volatile uint32_t *cmd;
+	volatile uint32_t *phy_cmd;
+	volatile uint32_t *cmd_sync;
+};
+
+/**
+ * enum idpf_ptp_access - the type of access to PTP operations
+ * @IDPF_PTP_NONE: no access
+ * @IDPF_PTP_DIRECT: direct access through BAR registers
+ * @IDPF_PTP_MAILBOX: access through mailbox messages
+ */
+enum idpf_ptp_access {
+	IDPF_PTP_NONE = 0,
+	IDPF_PTP_DIRECT,
+	IDPF_PTP_MAILBOX,
+};
+
+/**
+ * struct idpf_ptp_secondary_mbx - PTP secondary mailbox
+ * @peer_mbx_q_id: PTP mailbox queue ID
+ * @peer_id: Peer ID for PTP Device Control daemon
+ * @valid: indicates whether secondary mailblox is supported by the Control
+ *	   Plane
+ */
+struct idpf_ptp_secondary_mbx {
+	u16 peer_mbx_q_id;
+	u16 peer_id;
+	bool valid:1;
+};
+
+/**
+ * enum idpf_ptp_tx_tstamp_state - Tx timestamp states
+ * @IDPF_PTP_FREE: Tx timestamp index free to use
+ * @IDPF_PTP_REQUEST: Tx timestamp index set to the Tx descriptor
+ * @IDPF_PTP_READ_VALUE: Tx timestamp value ready to be read
+ */
+enum idpf_ptp_tx_tstamp_state {
+	IDPF_PTP_FREE,
+	IDPF_PTP_REQUEST,
+	IDPF_PTP_READ_VALUE,
+};
+
+/**
+ * struct idpf_ptp_tx_tstamp - Parameters for Tx timestamping
+ * @list_member: the list member structure
+ * @tx_latch_reg_offset_l: Tx tstamp latch low register offset
+ * @tx_latch_reg_offset_h: Tx tstamp latch high register offset
+ * @tstamp: the Tx tstamp value
+ * @idx: the index of the Tx tstamp
+ */
+struct idpf_ptp_tx_tstamp {
+	u32 tx_latch_reg_offset_l;
+	u32 tx_latch_reg_offset_h;
+	u64 tstamp;
+	u32 idx;
+};
+
+/**
+ * struct idpf_ptp_vport_tx_tstamp_caps - Tx timestamp capabilities
+ * @vport_id: the vport id
+ * @num_entries: the number of negotiated Tx timestamp entries
+ * @tstamp_ns_lo_bit: first bit for nanosecond part of the timestamp
+ * @access: indicates an access to Tx timestamp
+ * @latches_index: the index  of the latched Tx timestamps
+ * @tx_tstamp: array of Tx timestamp parameters
+ */
+struct idpf_ptp_vport_tx_tstamp_caps {
+	u32 vport_id;
+	u16 num_entries;
+	u16 tstamp_ns_lo_bit;
+	bool access:1;
+	u16 latched_idx;
+	struct idpf_ptp_tx_tstamp tx_tstamp[];
+};
+
+/**
+ * struct idpf_ptp - PTP parameters
+ * @base_incval: base increment value of the PTP clock
+ * @max_adj: maximum adjustment of the PTP clock
+ * @cmd: HW specific command masks
+ * @dev_clk_regs: the set of registers to access the device clock
+ * @caps: PTP capabilities negotiated with the Control Plane
+ * @get_dev_clk_time_access: access type for getting the device clock time
+ * @get_cross_tstamp_access: access type for the cross timestamping
+ * @set_dev_clk_time_access: access type for setting the device clock time
+ * @adj_dev_clk_time_access: access type for the adjusting the device clock
+ * @tx_tstamp_access: access type for the Tx timestamp value read
+ * @rsv: Reserved fields
+ * @secondary_mbx: parameters for using dedicated PTP mailbox
+ */
+struct idpf_ptp {
+	u64 base_incval;
+	u64 max_adj;
+	struct idpf_ptp_cmd cmd;
+	struct idpf_ptp_dev_clk_regs dev_clk_regs;
+	u32 caps;
+	enum idpf_ptp_access get_dev_clk_time_access:2;
+	enum idpf_ptp_access get_cross_tstamp_access:2;
+	enum idpf_ptp_access set_dev_clk_time_access:2;
+	enum idpf_ptp_access adj_dev_clk_time_access:2;
+	enum idpf_ptp_access tx_tstamp_access:2;
+	u8 rsv:6;
+	struct idpf_ptp_secondary_mbx secondary_mbx;
+};
+
+/**
+ * struct idpf_ptp_dev_timers - System time and device time values
+ * @sys_time_ns: system time value expressed in nanoseconds
+ * @dev_clk_time_ns: device clock time value expressed in nanoseconds
+ */
+struct idpf_ptp_dev_timers {
+	u64 sys_time_ns;
+	u64 dev_clk_time_ns;
+};
+
+int idpf_ptp_get_caps(struct idpf_adapter *adapter);
+int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk);
+int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+			      struct idpf_ptp_dev_timers *dev_clk_time);
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time);
+int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time);
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval);
+int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta);
+int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
+int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
+
+/* Helper function to convert a 32b nanoseconds timestamp to 64b. */
+static inline uint64_t
+idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
+			    bool is_rx, uint32_t in_timestamp)
+{
+	const uint64_t mask = 0xFFFFFFFF;
+	uint32_t phc_time_lo, delta;
+	uint64_t ns;
+
+	if (flag != 0)
+		idpf_ptp_read_src_clk_reg(ad, &ad->time_hw);
+
+    /* Extract the lower 32 bits of the PHC time */
+	phc_time_lo = (uint32_t)(ad->time_hw);
+
+	/* Calculate the delta between the lower 32bits of the cached PHC
+	 * time and the in_timestamp value.
+	 */
+	delta = in_timestamp - phc_time_lo;
+
+	if (delta > mask / 2) {
+		/* Reverse the delta calculation here */
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
+#endif /* _IDPF_PTP_H_ */
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index a805d02ea2..5a4a3c2259 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -18,6 +18,7 @@ sources += files(
 
         'idpf_ethdev.c',
         'idpf_rxtx.c',
+        'idpf_ptp.c',
 )
 
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') == 1
-- 
2.47.1

