Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E35CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 04:03:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB6A340A67;
	Tue,  2 Sep 2025 06:02:37 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 25E3E4065C
 for <dev@dpdk.org>; Tue,  2 Sep 2025 06:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=8lds5h7T5+cuh2uKXhE09jo3XB9VIAkgv88lLW6PNvM=;
 b=V5gJiDxGO4YGCG5mH6guV5WjDYcqKNCicCyiOiSq9ZKFWSi0HHSKnqpkWGj0nw
 visuUV0kQuu8uuCnJXSqbcUCAXgZXW2o81lKkbTAGldzzsk3pd2IrlLR0xdG+Vbf
 SX6fEXA6EJ4s2Ll2OBEJ2RKHGGhfDrAxWmHPW6FJO6sZw=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgC3XbtJbLZoaQXrAg--.25878S13;
 Tue, 02 Sep 2025 12:02:28 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V7 09/17] net/hinic3: add a NIC business configuration module
Date: Tue,  2 Sep 2025 12:01:43 +0800
Message-ID: <20250902040204.9572-10-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250902040204.9572-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250902040204.9572-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgC3XbtJbLZoaQXrAg--.25878S13
X-Coremail-Antispam: 1Uf129KBjvAXoWDKr1xXw4xtryfGw1kJFy8Grg_yoWfXw1DZo
 WfJr43Kr1Fqr1xCw4Utw1xGFZ3X3yq9FnxJ39xGFW2qan2k34rGF43Ww13ta4xZFWYyFnx
 uFWag3ySqr9xJ3Z3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAhG8Cmi2Um5rSgAAsm
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

From: Yi Chen <chenyi221@huawei.com>

The items of configurations and queries for NIC business include
MAC, VLAN, MTU, RSS and so on. These configurations and queries
are handled by mgmt module. This patch introduces related
data structures and function codes.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 1784 ++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 1529 ++++++++++++++++++
 drivers/net/hinic3/base/meson.build      |    1 +
 3 files changed, 3314 insertions(+)
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
new file mode 100644
index 0000000000..1eb2b5194a
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -0,0 +1,1784 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "hinic3_compat.h"
+#include "hinic3_cmd.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mbox.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_wq.h"
+
+struct vf_msg_handler {
+	uint16_t cmd;
+};
+
+static const struct vf_msg_handler vf_cmd_handler[] = {
+	{
+		.cmd = HINIC3_NIC_CMD_VF_REGISTER,
+	},
+
+	{
+		.cmd = HINIC3_NIC_CMD_GET_MAC,
+	},
+
+	{
+		.cmd = HINIC3_NIC_CMD_SET_MAC,
+	},
+
+	{
+		.cmd = HINIC3_NIC_CMD_DEL_MAC,
+	},
+
+	{
+		.cmd = HINIC3_NIC_CMD_UPDATE_MAC,
+	},
+
+	{
+		.cmd = HINIC3_NIC_CMD_VF_COS,
+	},
+};
+
+static const struct vf_msg_handler vf_mag_cmd_handler[] = {
+	{
+		.cmd = MAG_CMD_GET_LINK_STATUS,
+	},
+};
+
+/**
+ * Set CI table for a SQ.
+ *
+ * Configure the CI table with attributes like CI address, pending limit,
+ * coalescing time, and optional interrupt settings for specified SQ.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] attr
+ * Attributes to configure for CI table.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int
+hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr)
+{
+	struct hinic3_cmd_cons_idx_attr cons_idx_attr;
+	uint16_t out_size = sizeof(cons_idx_attr);
+	int err;
+
+	if (!hwdev || !attr)
+		return -EINVAL;
+
+	memset(&cons_idx_attr, 0, sizeof(cons_idx_attr));
+	cons_idx_attr.func_idx = hinic3_global_func_id(hwdev);
+	cons_idx_attr.dma_attr_off = attr->dma_attr_off;
+	cons_idx_attr.pending_limit = attr->pending_limit;
+	cons_idx_attr.coalescing_time = attr->coalescing_time;
+
+	if (attr->intr_en) {
+		cons_idx_attr.intr_en = attr->intr_en;
+		cons_idx_attr.intr_idx = attr->intr_idx;
+	}
+
+	cons_idx_attr.l2nic_sqn = attr->l2nic_sqn;
+	cons_idx_attr.ci_addr = attr->ci_dma_base;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SQ_CI_ATTR_SET,
+				     &cons_idx_attr, sizeof(cons_idx_attr),
+				     &cons_idx_attr, &out_size);
+	if (err || !out_size || cons_idx_attr.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set ci attribute table failed, "
+			    "err: %d, status: 0x%x, out_size: 0x%x",
+			    err, cons_idx_attr.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define PF_HAS_SET_VF_MAC(hwdev, status)           \
+	(hinic3_func_type(hwdev) == TYPE_VF && \
+	 (status) == HINIC3_PF_SET_VF_ALREADY)
+
+static int
+hinic3_check_mac_info(struct hinic3_hwdev *hwdev, uint8_t status, uint16_t vlan_id)
+{
+	if ((status && status != HINIC3_MGMT_STATUS_EXIST) ||
+	    ((vlan_id & CHECK_IPSU_15BIT) &&
+	     status == HINIC3_MGMT_STATUS_EXIST)) {
+		if (PF_HAS_SET_VF_MAC(hwdev, status))
+			return 0;
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define VLAN_N_VID 4096
+
+int
+hinic3_set_mac(struct hinic3_hwdev *hwdev,
+			 const uint8_t *mac_addr, uint16_t vlan_id, uint16_t func_id)
+{
+	struct hinic3_port_mac_set mac_info;
+	uint16_t out_size = sizeof(mac_info);
+	int err;
+
+	if (!hwdev || !mac_addr)
+		return -EINVAL;
+
+	memset(&mac_info, 0, sizeof(mac_info));
+
+	if (vlan_id >= VLAN_N_VID) {
+		PMD_DRV_LOG(ERR, "Invalid VLAN number: %d", vlan_id);
+		return -EINVAL;
+	}
+
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	memcpy(mac_info.mac, mac_addr, ETH_ALEN);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_MAC, &mac_info,
+				     sizeof(mac_info), &mac_info, &out_size);
+	if (err || !out_size ||
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,
+				  mac_info.vlan_id)) {
+		PMD_DRV_LOG(ERR,
+			    "Update MAC failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (PF_HAS_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
+		PMD_DRV_LOG(WARNING,
+			    "PF has already set VF mac, Ignore set operation");
+		return HINIC3_PF_SET_VF_ALREADY;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_MGMT_STATUS_EXIST) {
+		PMD_DRV_LOG(WARNING,
+			    "MAC is repeated. Ignore update operation");
+		return 0;
+	}
+
+	return 0;
+}
+
+int
+hinic3_del_mac(struct hinic3_hwdev *hwdev,
+			 const uint8_t *mac_addr, uint16_t vlan_id, uint16_t func_id)
+{
+	struct hinic3_port_mac_set mac_info;
+	uint16_t out_size = sizeof(mac_info);
+	int err;
+
+	if (!hwdev || !mac_addr)
+		return -EINVAL;
+
+	if (vlan_id >= VLAN_N_VID) {
+		PMD_DRV_LOG(ERR, "Invalid VLAN number: %d", vlan_id);
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	memcpy(mac_info.mac, mac_addr, ETH_ALEN);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_DEL_MAC, &mac_info,
+				     sizeof(mac_info), &mac_info, &out_size);
+	if (err || !out_size ||
+	    (mac_info.msg_head.status &&
+	     !PF_HAS_SET_VF_MAC(hwdev, mac_info.msg_head.status))) {
+		PMD_DRV_LOG(ERR,
+			    "Delete MAC failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (PF_HAS_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
+		PMD_DRV_LOG(WARNING,
+			"PF has already set VF mac, Ignore delete operation");
+		return HINIC3_PF_SET_VF_ALREADY;
+	}
+
+	return 0;
+}
+
+int
+hinic3_update_mac(struct hinic3_hwdev *hwdev,
+			 uint8_t *old_mac, uint8_t *new_mac, uint16_t vlan_id,
+		  uint16_t func_id)
+{
+	struct hinic3_port_mac_update mac_info;
+	uint16_t out_size = sizeof(mac_info);
+	int err;
+
+	if (!hwdev || !old_mac || !new_mac)
+		return -EINVAL;
+
+	if (vlan_id >= VLAN_N_VID) {
+		PMD_DRV_LOG(ERR, "Invalid VLAN number: %d", vlan_id);
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	memcpy(mac_info.old_mac, old_mac, ETH_ALEN);
+	memcpy(mac_info.new_mac, new_mac, ETH_ALEN);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_UPDATE_MAC,
+				     &mac_info, sizeof(mac_info), &mac_info,
+				     &out_size);
+	if (err || !out_size ||
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,
+				  mac_info.vlan_id)) {
+		PMD_DRV_LOG(ERR,
+			    "Update MAC failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (PF_HAS_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {
+		PMD_DRV_LOG(WARNING,
+			"PF has already set VF MAC. Ignore update operation");
+		return HINIC3_PF_SET_VF_ALREADY;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_MGMT_STATUS_EXIST) {
+		PMD_DRV_LOG(INFO, "MAC is repeated. Ignore update operation");
+		return 0;
+	}
+
+	return 0;
+}
+
+int
+hinic3_get_default_mac(struct hinic3_hwdev *hwdev, uint8_t *mac_addr, int ether_len)
+{
+	struct hinic3_port_mac_set mac_info;
+	uint16_t out_size = sizeof(mac_info);
+	int err;
+
+	if (!hwdev || !mac_addr)
+		return -EINVAL;
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = hinic3_global_func_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_GET_MAC, &mac_info,
+				     sizeof(mac_info), &mac_info, &out_size);
+	if (err || !out_size || mac_info.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			"Get MAC failed, err: %d, status: 0x%x, out size: 0x%x",
+			err, mac_info.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	memcpy(mac_addr, mac_info.mac, ether_len);
+
+	return 0;
+}
+
+static int
+hinic3_config_vlan(struct hinic3_hwdev *hwdev, uint8_t opcode, uint16_t vlan_id, uint16_t func_id)
+{
+	struct hinic3_cmd_vlan_config vlan_info;
+	uint16_t out_size = sizeof(vlan_info);
+	int err;
+
+	memset(&vlan_info, 0, sizeof(vlan_info));
+	vlan_info.opcode = opcode;
+	vlan_info.func_id = func_id;
+	vlan_info.vlan_id = vlan_id;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_FUNC_VLAN,
+				     &vlan_info, sizeof(vlan_info), &vlan_info,
+				     &out_size);
+	if (err || !out_size || vlan_info.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			"%s vlan failed, err: %d, status: 0x%x, out size: 0x%x",
+			opcode == HINIC3_CMD_OP_ADD ? "Add" : "Delete", err,
+			vlan_info.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int
+hinic3_add_vlan(struct hinic3_hwdev *hwdev, uint16_t vlan_id, uint16_t func_id)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	return hinic3_config_vlan(hwdev, HINIC3_CMD_OP_ADD, vlan_id, func_id);
+}
+
+int
+hinic3_del_vlan(struct hinic3_hwdev *hwdev, uint16_t vlan_id, uint16_t func_id)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	return hinic3_config_vlan(hwdev, HINIC3_CMD_OP_DEL, vlan_id, func_id);
+}
+
+int
+hinic3_get_port_info(struct hinic3_hwdev *hwdev, struct nic_port_info *port_info)
+{
+	struct hinic3_cmd_port_info port_msg;
+	uint16_t out_size = sizeof(port_msg);
+	int err;
+
+	if (!hwdev || !port_info)
+		return -EINVAL;
+
+	memset(&port_msg, 0, sizeof(port_msg));
+	port_msg.port_id = hinic3_physical_port_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_GET_PORT_INFO, &port_msg,
+				   sizeof(port_msg), &port_msg, &out_size);
+	if (err || !out_size || port_msg.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Get port info failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, port_msg.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	port_info->autoneg_cap = port_msg.autoneg_cap;
+	port_info->autoneg_state = port_msg.autoneg_state;
+	port_info->duplex = port_msg.duplex;
+	port_info->port_type = port_msg.port_type;
+	port_info->speed = port_msg.speed;
+	port_info->fec = port_msg.fec;
+
+	return 0;
+}
+
+int
+hinic3_get_link_state(struct hinic3_hwdev *hwdev, uint8_t *link_state)
+{
+	struct hinic3_cmd_link_state get_link;
+	uint16_t out_size = sizeof(get_link);
+	int err;
+
+	if (!hwdev || !link_state)
+		return -EINVAL;
+
+	memset(&get_link, 0, sizeof(get_link));
+	get_link.port_id = hinic3_physical_port_id(hwdev);
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_GET_LINK_STATUS, &get_link,
+				   sizeof(get_link), &get_link, &out_size);
+	if (err || !out_size || get_link.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Get link state failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, get_link.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	*link_state = get_link.state;
+
+	return 0;
+}
+
+int
+hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
+{
+	struct hinic3_vport_state en_state;
+	uint16_t out_size = sizeof(en_state);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&en_state, 0, sizeof(en_state));
+	en_state.func_id = hinic3_global_func_id(hwdev);
+	en_state.state = enable ? 1 : 0;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_VPORT_ENABLE,
+				     &en_state, sizeof(en_state), &en_state,
+				     &out_size);
+	if (err || !out_size || en_state.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set vport state failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, en_state.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable)
+{
+	struct mag_cmd_set_port_enable en_state;
+	uint16_t out_size = sizeof(en_state);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	if (hinic3_func_type(hwdev) == TYPE_VF)
+		return 0;
+
+	memset(&en_state, 0, sizeof(en_state));
+	en_state.function_id = hinic3_global_func_id(hwdev);
+	en_state.state = enable ? MAG_CMD_TX_ENABLE | MAG_CMD_RX_ENABLE
+				: MAG_CMD_PORT_DISABLE;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_SET_PORT_ENABLE, &en_state,
+				   sizeof(en_state), &en_state, &out_size);
+	if (err || !out_size || en_state.head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set port state failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, en_state.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_flush_qps_res(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_clear_qp_resource sq_res;
+	uint16_t out_size = sizeof(sq_res);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&sq_res, 0, sizeof(sq_res));
+	sq_res.func_id = hinic3_global_func_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CLEAR_QP_RESOURCE,
+				     &sq_res, sizeof(sq_res), &sq_res,
+				     &out_size);
+	if (err || !out_size || sq_res.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Clear sq resources failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, sq_res.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * Get or set the flow control (pause frame) settings for NIC.
+ *
+ * @param[in] hwdev
+ * Pointer to the hardware device.
+ * @param[in] opcode
+ * The operation to perform. Use `HINIC3_CMD_OP_SET` to set the pause settings
+ * and `HINIC3_CMD_OP_GET` to get them.
+ * @param[out] nic_pause
+ * Pointer to the `nic_pause_config` structure. This structure contains the flow
+ * control settings (auto-negotiation, Rx pause, and Tx pause). It is updated
+ * when getting settings. When setting, the values in this structure are used.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ * - -EIO if the operation failed.
+ */
+static int
+hinic3_cfg_hw_pause(struct hinic3_hwdev *hwdev, uint8_t opcode, struct nic_pause_config *nic_pause)
+{
+	struct hinic3_cmd_pause_config pause_info = {0};
+	uint16_t out_size = sizeof(pause_info);
+	int err = 0;
+
+	pause_info.port_id = hinic3_physical_port_id(hwdev);
+	pause_info.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET) {
+		pause_info.auto_neg = nic_pause->auto_neg;
+		pause_info.rx_pause = nic_pause->rx_pause;
+		pause_info.tx_pause = nic_pause->tx_pause;
+	}
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_PAUSE_INFO,
+				     &pause_info, sizeof(pause_info),
+				     &pause_info, &out_size);
+	if (err || !out_size || pause_info.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "%s pause info failed, err: %d, status: 0x%x, out "
+			    "size: 0x%x",
+			    opcode == HINIC3_CMD_OP_SET ? "Set" : "Get", err,
+			    pause_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET) {
+		nic_pause->auto_neg = pause_info.auto_neg;
+		nic_pause->rx_pause = pause_info.rx_pause;
+		nic_pause->tx_pause = pause_info.tx_pause;
+	}
+
+	return 0;
+}
+
+int
+hinic3_set_pause_info(struct hinic3_hwdev *hwdev, struct nic_pause_config nic_pause)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	return hinic3_cfg_hw_pause(hwdev, HINIC3_CMD_OP_SET, &nic_pause);
+}
+
+int
+hinic3_get_pause_info(struct hinic3_hwdev *hwdev, struct nic_pause_config *nic_pause)
+{
+	if (!hwdev || !nic_pause)
+		return -EINVAL;
+
+	return hinic3_cfg_hw_pause(hwdev, HINIC3_CMD_OP_GET, nic_pause);
+}
+
+int
+hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, struct hinic3_vport_stats *stats)
+{
+	struct hinic3_port_stats_info stats_info;
+	struct hinic3_cmd_vport_stats vport_stats;
+	uint16_t out_size = sizeof(vport_stats);
+	int err;
+
+	if (!hwdev || !stats)
+		return -EINVAL;
+
+	memset(&stats_info, 0, sizeof(stats_info));
+	memset(&vport_stats, 0, sizeof(vport_stats));
+
+	stats_info.func_id = hinic3_global_func_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_GET_VPORT_STAT,
+				     &stats_info, sizeof(stats_info),
+				     &vport_stats, &out_size);
+	if (err || !out_size || vport_stats.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Get function stats failed, err: %d, status: 0x%x, "
+			    "out size: 0x%x",
+			    err, vport_stats.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	memcpy(stats, &vport_stats.stats, sizeof(*stats));
+
+	return 0;
+}
+
+int
+hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev, struct mag_phy_port_stats *stats)
+{
+	struct mag_cmd_get_port_stat *port_stats = NULL;
+	struct mag_cmd_port_stats_info stats_info;
+	uint16_t out_size = sizeof(*port_stats);
+	int err;
+
+	port_stats = rte_zmalloc("port_stats", sizeof(*port_stats), 0);
+	if (!port_stats)
+		return -ENOMEM;
+
+	memset(&stats_info, 0, sizeof(stats_info));
+	stats_info.port_id = hinic3_physical_port_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_GET_PORT_STAT, &stats_info,
+				   sizeof(stats_info), port_stats, &out_size);
+	if (err || !out_size || port_stats->head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to get port statistics, err: %d, status: "
+			    "0x%x, out size: 0x%x",
+			    err, port_stats->head.status, out_size);
+		err = -EIO;
+		goto out;
+	}
+
+	memcpy(stats, &port_stats->counter, sizeof(*stats));
+
+out:
+	rte_free(port_stats);
+
+	return err;
+}
+
+int
+hinic3_clear_vport_stats(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_clear_vport_stats clear_vport_stats;
+	uint16_t out_size = sizeof(clear_vport_stats);
+	int err;
+
+	if (!hwdev) {
+		PMD_DRV_LOG(ERR, "Hwdev is NULL");
+		return -EINVAL;
+	}
+
+	memset(&clear_vport_stats, 0, sizeof(clear_vport_stats));
+	clear_vport_stats.func_id = hinic3_global_func_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
+		HINIC3_NIC_CMD_CLEAN_VPORT_STAT, &clear_vport_stats,
+		sizeof(clear_vport_stats), &clear_vport_stats, &out_size);
+	if (err || !out_size || clear_vport_stats.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Clear vport stats failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, clear_vport_stats.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_clear_phy_port_stats(struct hinic3_hwdev *hwdev)
+{
+	struct mag_cmd_port_stats_info port_stats;
+	uint16_t out_size = sizeof(port_stats);
+	int err;
+
+	port_stats.port_id = hinic3_physical_port_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_CLR_PORT_STAT, &port_stats,
+				   sizeof(port_stats), &port_stats, &out_size);
+	if (err || !out_size || port_stats.head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to get port statistics, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, port_stats.head.status, out_size);
+		err = -EIO;
+	}
+
+	return err;
+}
+
+static int
+hinic3_set_function_table(struct hinic3_hwdev *hwdev, uint32_t cfg_bitmap,
+			  struct hinic3_func_tbl_cfg *cfg)
+{
+	struct hinic3_cmd_set_func_tbl cmd_func_tbl;
+	uint16_t out_size = sizeof(cmd_func_tbl);
+	int err;
+
+	memset(&cmd_func_tbl, 0, sizeof(cmd_func_tbl));
+	cmd_func_tbl.func_id = hinic3_global_func_id(hwdev);
+	cmd_func_tbl.cfg_bitmap = cfg_bitmap;
+	cmd_func_tbl.tbl_cfg = *cfg;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_FUNC_TBL,
+				     &cmd_func_tbl, sizeof(cmd_func_tbl),
+				     &cmd_func_tbl, &out_size);
+	if (err || cmd_func_tbl.msg_head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Set func table failed, bitmap: 0x%x, err: %d, "
+			    "status: 0x%x, out size: 0x%x",
+			    cfg_bitmap, err, cmd_func_tbl.msg_head.status,
+			    out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_init_function_table(struct hinic3_hwdev *hwdev, uint16_t rx_buff_len)
+{
+	struct hinic3_func_tbl_cfg func_tbl_cfg;
+	uint32_t cfg_bitmap = RTE_BIT32(FUNC_CFG_INIT) | RTE_BIT32(FUNC_CFG_MTU) |
+			 RTE_BIT32(FUNC_CFG_RX_BUF_SIZE);
+
+	memset(&func_tbl_cfg, 0, sizeof(func_tbl_cfg));
+	func_tbl_cfg.mtu = 0x3FFF; /**< Default, max mtu */
+	func_tbl_cfg.rx_wqe_buf_size = rx_buff_len;
+
+	return hinic3_set_function_table(hwdev, cfg_bitmap, &func_tbl_cfg);
+}
+
+int
+hinic3_set_port_mtu(struct hinic3_hwdev *hwdev, uint16_t new_mtu)
+{
+	struct hinic3_func_tbl_cfg func_tbl_cfg;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
+		PMD_DRV_LOG(ERR,
+			    "Invalid mtu size: %ubytes, mtu size < %ubytes",
+			    new_mtu, HINIC3_MIN_MTU_SIZE);
+		return -EINVAL;
+	}
+
+	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
+		PMD_DRV_LOG(ERR,
+			    "Invalid mtu size: %ubytes, mtu size > %ubytes",
+			    new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
+		return -EINVAL;
+	}
+
+	memset(&func_tbl_cfg, 0, sizeof(func_tbl_cfg));
+	func_tbl_cfg.mtu = new_mtu;
+	return hinic3_set_function_table(hwdev, RTE_BIT32(FUNC_CFG_MTU),
+					 &func_tbl_cfg);
+}
+
+static int
+nic_feature_nego(struct hinic3_hwdev *hwdev, uint8_t opcode, uint64_t *s_feature, uint16_t size)
+{
+	struct hinic3_cmd_feature_nego feature_nego;
+	uint16_t out_size = sizeof(feature_nego);
+	int err;
+
+	if (!hwdev || !s_feature || size > MAX_FEATURE_QWORD)
+		return -EINVAL;
+
+	memset(&feature_nego, 0, sizeof(feature_nego));
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, size * sizeof(uint64_t));
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_FEATURE_NEGO,
+				     &feature_nego, sizeof(feature_nego),
+				     &feature_nego, &out_size);
+	if (err || !out_size || feature_nego.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to negotiate nic feature, err:%d, status: "
+			    "0x%x, out_size: 0x%x",
+			    err, feature_nego.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, size * sizeof(uint64_t));
+
+	return 0;
+}
+
+int
+hinic3_get_feature_from_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size)
+{
+	return nic_feature_nego(hwdev, HINIC3_CMD_OP_GET, s_feature, size);
+}
+
+int
+hinic3_set_feature_to_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size)
+{
+	return nic_feature_nego(hwdev, HINIC3_CMD_OP_SET, s_feature, size);
+}
+
+static int
+hinic3_vf_func_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_register_vf register_info;
+	uint16_t out_size = sizeof(register_info);
+	int err;
+
+	if (hinic3_func_type(hwdev) != TYPE_VF)
+		return 0;
+
+	memset(&register_info, 0, sizeof(register_info));
+	register_info.op_register = 1;
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_VF_REGISTER,
+				     &register_info, sizeof(register_info),
+				     &register_info, &out_size);
+	if (err || register_info.msg_head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Register VF failed, err: %d, status: 0x%x, out "
+			    "size: 0x%x",
+			    err, register_info.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_vf_func_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_register_vf unregister;
+	uint16_t out_size = sizeof(unregister);
+	int err;
+
+	if (hinic3_func_type(hwdev) != TYPE_VF)
+		return 0;
+
+	memset(&unregister, 0, sizeof(unregister));
+	unregister.op_register = 0;
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_VF_REGISTER,
+				     &unregister, sizeof(unregister),
+				     &unregister, &out_size);
+	if (err || unregister.msg_head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Unregister VF failed, err: %d, status: 0x%x, out "
+			    "size: 0x%x",
+			    err, unregister.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_init_nic_hwdev(struct hinic3_hwdev *hwdev)
+{
+	return hinic3_vf_func_init(hwdev);
+}
+
+void
+hinic3_free_nic_hwdev(struct hinic3_hwdev *hwdev)
+{
+	if (!hwdev)
+		return;
+
+	if (hinic3_func_type(hwdev) != TYPE_VF)
+		hinic3_set_link_status_follow(hwdev, HINIC3_LINK_FOLLOW_DEFAULT);
+
+	hinic3_vf_func_free(hwdev);
+}
+
+int
+hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, uint32_t enable)
+{
+	struct hinic3_rx_mode_config rx_mode_cfg;
+	uint16_t out_size = sizeof(rx_mode_cfg);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&rx_mode_cfg, 0, sizeof(rx_mode_cfg));
+	rx_mode_cfg.func_id = hinic3_global_func_id(hwdev);
+	rx_mode_cfg.rx_mode = enable;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_RX_MODE,
+				     &rx_mode_cfg, sizeof(rx_mode_cfg),
+				     &rx_mode_cfg, &out_size);
+	if (err || !out_size || rx_mode_cfg.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set rx mode failed, err: %d, status: 0x%x, out "
+			    "size: 0x%x",
+			    err, rx_mode_cfg.msg_head.status, out_size);
+		return -EIO;
+	}
+	return 0;
+}
+
+int
+hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, uint8_t en)
+{
+	struct hinic3_cmd_vlan_offload vlan_cfg;
+	uint16_t out_size = sizeof(vlan_cfg);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&vlan_cfg, 0, sizeof(vlan_cfg));
+	vlan_cfg.func_id = hinic3_global_func_id(hwdev);
+	vlan_cfg.vlan_offload = en;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD,
+				     &vlan_cfg, sizeof(vlan_cfg), &vlan_cfg,
+				     &out_size);
+	if (err || !out_size || vlan_cfg.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set rx vlan offload failed, err: %d, status: "
+			    "0x%x, out size: 0x%x",
+			    err, vlan_cfg.msg_head.status, out_size);
+		return -EIO;
+	}
+	return 0;
+}
+
+int
+hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, uint32_t vlan_filter_ctrl)
+{
+	struct hinic3_cmd_set_vlan_filter vlan_filter;
+	uint16_t out_size = sizeof(vlan_filter);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&vlan_filter, 0, sizeof(vlan_filter));
+	vlan_filter.func_id = hinic3_global_func_id(hwdev);
+	vlan_filter.vlan_filter_ctrl = vlan_filter_ctrl;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_VLAN_FILTER_EN,
+				     &vlan_filter, sizeof(vlan_filter),
+				     &vlan_filter, &out_size);
+	if (err || !out_size || vlan_filter.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to set vlan filter, err: %d, status: 0x%x, "
+			    "out size: 0x%x",
+			    err, vlan_filter.msg_head.status, out_size);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int
+hinic3_set_rx_lro(struct hinic3_hwdev *hwdev, uint8_t ipv4_en,
+				uint8_t ipv6_en, uint8_t lro_max_pkt_len)
+{
+	struct hinic3_cmd_lro_config lro_cfg = {0};
+	uint16_t out_size = sizeof(lro_cfg);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	lro_cfg.func_id = hinic3_global_func_id(hwdev);
+	lro_cfg.opcode = HINIC3_CMD_OP_SET;
+	lro_cfg.lro_ipv4_en = ipv4_en;
+	lro_cfg.lro_ipv6_en = ipv6_en;
+	lro_cfg.lro_max_pkt_len = lro_max_pkt_len;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_RX_LRO, &lro_cfg,
+				     sizeof(lro_cfg), &lro_cfg, &out_size);
+	if (err || !out_size || lro_cfg.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set lro offload failed, err: %d, status: 0x%x, "
+			    "out size: 0x%x",
+			    err, lro_cfg.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, uint32_t timer_value)
+{
+	struct hinic3_cmd_lro_timer lro_timer;
+	uint16_t out_size = sizeof(lro_timer);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&lro_timer, 0, sizeof(lro_timer));
+	lro_timer.opcode = HINIC3_CMD_OP_SET;
+	lro_timer.timer = timer_value;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_LRO_TIMER,
+				     &lro_timer, sizeof(lro_timer), &lro_timer,
+				     &out_size);
+	if (err || !out_size || lro_timer.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set lro timer failed, err: %d, status: 0x%x, out "
+			    "size: 0x%x",
+			    err, lro_timer.msg_head.status, out_size);
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32_t lro_timer,
+			uint32_t lro_max_pkt_len)
+{
+	uint8_t ipv4_en = 0, ipv6_en = 0;
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	ipv4_en = lro_en ? 1 : 0;
+	ipv6_en = lro_en ? 1 : 0;
+
+	PMD_DRV_LOG(INFO, "Set LRO max coalesce packet size to %uK",
+		    lro_max_pkt_len);
+
+	err = hinic3_set_rx_lro(hwdev, ipv4_en, ipv6_en, (uint8_t)lro_max_pkt_len);
+	if (err)
+		return err;
+
+	/* We don't set LRO timer for VF */
+	if (hinic3_func_type(hwdev) == TYPE_VF)
+		return 0;
+
+	PMD_DRV_LOG(INFO, "Set LRO timer to %u", lro_timer);
+
+	return hinic3_set_rx_lro_timer(hwdev, lro_timer);
+}
+
+/* RSS config */
+int
+hinic3_rss_template_alloc(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_rss_template_mgmt template_mgmt;
+	uint16_t out_size = sizeof(template_mgmt);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&template_mgmt, 0, sizeof(struct hinic3_rss_template_mgmt));
+	template_mgmt.func_id = hinic3_global_func_id(hwdev);
+	template_mgmt.cmd = NIC_RSS_CMD_TEMP_ALLOC;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_RSS_TEMP_MGR,
+				     &template_mgmt, sizeof(template_mgmt),
+				     &template_mgmt, &out_size);
+	if (err || !out_size || template_mgmt.msg_head.status) {
+		if (template_mgmt.msg_head.status ==
+		    HINIC3_MGMT_STATUS_TABLE_FULL) {
+			PMD_DRV_LOG(ERR, "There is no more template available");
+			return -ENOSPC;
+		}
+		PMD_DRV_LOG(ERR,
+			    "Alloc rss template failed, err: %d, "
+			    "status: 0x%x, out size: 0x%x",
+			    err, template_mgmt.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_rss_template_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_rss_template_mgmt template_mgmt;
+	uint16_t out_size = sizeof(template_mgmt);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&template_mgmt, 0, sizeof(struct hinic3_rss_template_mgmt));
+	template_mgmt.func_id = hinic3_global_func_id(hwdev);
+	template_mgmt.cmd = NIC_RSS_CMD_TEMP_FREE;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_RSS_TEMP_MGR,
+				     &template_mgmt, sizeof(template_mgmt),
+				     &template_mgmt, &out_size);
+	if (err || !out_size || template_mgmt.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Free rss template failed, err: %d, "
+			    "status: 0x%x, out size: 0x%x",
+			    err, template_mgmt.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_rss_cfg_hash_key(struct hinic3_hwdev *hwdev, uint8_t opcode, uint8_t *key, uint16_t key_size)
+{
+	struct hinic3_cmd_rss_hash_key hash_key;
+	uint16_t out_size = sizeof(hash_key);
+	int err;
+
+	if (!hwdev || !key)
+		return -EINVAL;
+
+	memset(&hash_key, 0, sizeof(struct hinic3_cmd_rss_hash_key));
+	hash_key.func_id = hinic3_global_func_id(hwdev);
+	hash_key.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET)
+		memcpy(hash_key.key, key, key_size);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_RSS_HASH_KEY,
+				     &hash_key, sizeof(hash_key), &hash_key,
+				     &out_size);
+	if (err || !out_size || hash_key.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "%s hash key failed, err: %d, "
+			    "status: 0x%x, out size: 0x%x",
+			    opcode == HINIC3_CMD_OP_SET ? "Set" : "Get", err,
+			    hash_key.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		memcpy(key, hash_key.key, key_size);
+
+	return 0;
+}
+
+int
+hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, uint8_t *key, uint16_t key_size)
+{
+	if (!hwdev || !key)
+		return -EINVAL;
+
+	return hinic3_rss_cfg_hash_key(hwdev, HINIC3_CMD_OP_SET, key, key_size);
+}
+
+int
+hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev,
+			 uint32_t *indir_table, uint32_t indir_table_size)
+{
+	struct hinic3_cmd_buf *cmd_buf = NULL;
+	uint16_t *indir_tbl = NULL;
+	int err;
+	uint32_t i;
+
+	if (!hwdev || !indir_table)
+		return -EINVAL;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Allocate cmd buf failed");
+		return -ENOMEM;
+	}
+
+	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl);
+	err = hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,
+				      cmd_buf, cmd_buf, 0);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get rss indir table failed");
+		hinic3_free_cmd_buf(cmd_buf);
+		return err;
+	}
+
+	indir_tbl = (uint16_t *)cmd_buf->buf;
+	for (i = 0; i < indir_table_size; i++)
+		indir_table[i] = *(indir_tbl + i);
+
+	hinic3_free_cmd_buf(cmd_buf);
+	return 0;
+}
+
+int
+hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table,
+			 uint32_t indir_table_size)
+{
+	struct nic_rss_indirect_tbl *indir_tbl = NULL;
+	struct hinic3_cmd_buf *cmd_buf = NULL;
+	uint32_t i, size;
+	uint32_t *temp = NULL;
+	uint64_t out_param = 0;
+	int err;
+
+	if (!hwdev || !indir_table)
+		return -EINVAL;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Allocate cmd buf failed");
+		return -ENOMEM;
+	}
+
+	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl);
+	indir_tbl = (struct nic_rss_indirect_tbl *)cmd_buf->buf;
+	memset(indir_tbl, 0, sizeof(*indir_tbl));
+
+	for (i = 0; i < indir_table_size; i++)
+		indir_tbl->entry[i] = (uint16_t)(*(indir_table + i));
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	size = sizeof(indir_tbl->entry) / sizeof(uint16_t);
+	temp = (uint32_t *)indir_tbl->entry;
+	for (i = 0; i < size; i++)
+		temp[i] = rte_cpu_to_be_32(temp[i]);
+
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,
+				      cmd_buf, &out_param, 0);
+	if (err || out_param != 0) {
+		PMD_DRV_LOG(ERR, "Set rss indir table failed");
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(cmd_buf);
+	return err;
+}
+
+static int
+hinic3_cmdq_set_rss_type(struct hinic3_hwdev *hwdev, struct hinic3_rss_type rss_type)
+{
+	struct nic_rss_context_tbl *ctx_tbl = NULL;
+	struct hinic3_cmd_buf *cmd_buf = NULL;
+	uint32_t ctx = 0;
+	uint64_t out_param = 0;
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Allocate cmd buf failed");
+		return -ENOMEM;
+	}
+
+	ctx |= HINIC3_RSS_TYPE_SET(1, VALID) |
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv4, IPV4) |
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6, IPV6) |
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);
+
+	cmd_buf->size = sizeof(struct nic_rss_context_tbl);
+	ctx_tbl = (struct nic_rss_context_tbl *)cmd_buf->buf;
+	memset(ctx_tbl, 0, sizeof(*ctx_tbl));
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	ctx_tbl->ctx = rte_cpu_to_be_32(ctx);
+
+	/* Cfg the RSS context table by command queue. */
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE,
+				      cmd_buf, &out_param, 0);
+
+	hinic3_free_cmd_buf(cmd_buf);
+
+	if (err || out_param != 0) {
+		PMD_DRV_LOG(ERR, "Cmdq set rss context table failed, err: %d",
+			    err);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_mgmt_set_rss_type(struct hinic3_hwdev *hwdev, struct hinic3_rss_type rss_type)
+{
+	struct hinic3_rss_context_table ctx_tbl;
+	uint32_t ctx = 0;
+	uint16_t out_size = sizeof(ctx_tbl);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&ctx_tbl, 0, sizeof(ctx_tbl));
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+	ctx |= HINIC3_RSS_TYPE_SET(1, VALID) |
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv4, IPV4) |
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6, IPV6) |
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);
+	ctx_tbl.context = ctx;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
+		HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC, &ctx_tbl,
+		sizeof(ctx_tbl), &ctx_tbl, &out_size);
+	if (ctx_tbl.msg_head.status == HINIC3_MGMT_CMD_UNSUPPORTED) {
+		return HINIC3_MGMT_CMD_UNSUPPORTED;
+	} else if (err || !out_size || ctx_tbl.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Mgmt set rss context table failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, ctx_tbl.msg_head.status, out_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int
+hinic3_set_rss_type(struct hinic3_hwdev *hwdev, struct hinic3_rss_type rss_type)
+{
+	int err;
+	err = hinic3_mgmt_set_rss_type(hwdev, rss_type);
+	if (err == HINIC3_MGMT_CMD_UNSUPPORTED)
+		err = hinic3_cmdq_set_rss_type(hwdev, rss_type);
+	return err;
+}
+
+int
+hinic3_get_rss_type(struct hinic3_hwdev *hwdev, struct hinic3_rss_type *rss_type)
+{
+	struct hinic3_rss_context_table ctx_tbl;
+	uint16_t out_size = sizeof(ctx_tbl);
+	int err;
+
+	if (!hwdev || !rss_type)
+		return -EINVAL;
+
+	memset(&ctx_tbl, 0, sizeof(struct hinic3_rss_context_table));
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_GET_RSS_CTX_TBL,
+				     &ctx_tbl, sizeof(ctx_tbl), &ctx_tbl,
+				     &out_size);
+	if (err || !out_size || ctx_tbl.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Get hash type failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, ctx_tbl.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	rss_type->ipv4 = HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV4);
+	rss_type->ipv6 = HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV6);
+	rss_type->ipv6_ext = HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV6_EXT);
+	rss_type->tcp_ipv4 = HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV4);
+	rss_type->tcp_ipv6 = HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6);
+	rss_type->tcp_ipv6_ext =
+		HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6_EXT);
+	rss_type->udp_ipv4 = HINIC3_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV4);
+	rss_type->udp_ipv6 = HINIC3_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV6);
+
+	return 0;
+}
+
+static int
+hinic3_rss_cfg_hash_engine(struct hinic3_hwdev *hwdev, uint8_t opcode, uint8_t *type)
+{
+	struct hinic3_cmd_rss_engine_type hash_type;
+	uint16_t out_size = sizeof(hash_type);
+	int err;
+
+	if (!hwdev || !type)
+		return -EINVAL;
+
+	memset(&hash_type, 0, sizeof(struct hinic3_cmd_rss_engine_type));
+	hash_type.func_id = hinic3_global_func_id(hwdev);
+	hash_type.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET)
+		hash_type.hash_engine = *type;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE,
+				     &hash_type, sizeof(hash_type), &hash_type,
+				     &out_size);
+	if (err || !out_size || hash_type.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "%s hash engine failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    opcode == HINIC3_CMD_OP_SET ? "Set" : "Get", err,
+			    hash_type.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		*type = hash_type.hash_engine;
+
+	return 0;
+}
+
+int
+hinic3_rss_get_hash_engine(struct hinic3_hwdev *hwdev, uint8_t *type)
+{
+	if (!hwdev || !type)
+		return -EINVAL;
+
+	return hinic3_rss_cfg_hash_engine(hwdev, HINIC3_CMD_OP_GET, type);
+}
+
+int
+hinic3_rss_set_hash_engine(struct hinic3_hwdev *hwdev, uint8_t type)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	return hinic3_rss_cfg_hash_engine(hwdev, HINIC3_CMD_OP_SET, &type);
+}
+
+int
+hinic3_rss_cfg(struct hinic3_hwdev *hwdev, uint8_t rss_en, uint8_t tc_num, uint8_t *prio_tc)
+{
+	struct hinic3_cmd_rss_config rss_cfg;
+	uint16_t out_size = sizeof(rss_cfg);
+	int err;
+
+	/* Ucode requires number of TC should be power of 2. */
+	if (!hwdev || !prio_tc || (tc_num & (tc_num - 1)))
+		return -EINVAL;
+
+	memset(&rss_cfg, 0, sizeof(struct hinic3_cmd_rss_config));
+	rss_cfg.func_id = hinic3_global_func_id(hwdev);
+	rss_cfg.rss_en = rss_en;
+	rss_cfg.rq_priority_number = tc_num ? (uint8_t)rte_log2_u32(tc_num) : 0;
+
+	memcpy(rss_cfg.prio_tc, prio_tc, HINIC3_DCB_UP_MAX);
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_RSS_CFG, &rss_cfg,
+				     sizeof(rss_cfg), &rss_cfg, &out_size);
+	if (err || !out_size || rss_cfg.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set rss cfg failed, err: %d, "
+			    "status: 0x%x, out size: 0x%x",
+			    err, rss_cfg.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
+{
+	struct hinic3_cmd_vf_dcb_state vf_dcb;
+	uint16_t out_size = sizeof(vf_dcb);
+	int err;
+
+	memset(&vf_dcb, 0, sizeof(vf_dcb));
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_VF_COS, &vf_dcb,
+				     sizeof(vf_dcb), &vf_dcb, &out_size);
+	if (err || !out_size || vf_dcb.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Get VF default cos failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, vf_dcb.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	*cos_id = vf_dcb.state.default_cos;
+
+	return 0;
+}
+
+/**
+ * Set the Ethernet type filtering rule for the FDIR of a NIC.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] pkt_type
+ * Indicate the packet type.
+ * @param[in] queue_id
+ * Indicate the queue id.
+ * @param[in] en
+ * Indicate whether to add or delete an operation. 1 - add; 0 - delete.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int
+hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,
+			 uint8_t pkt_type, uint16_t queue_id, uint8_t en)
+{
+	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;
+	uint16_t out_size = sizeof(ethertype_cmd);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&ethertype_cmd, 0,
+	       sizeof(struct hinic3_set_fdir_ethertype_rule));
+	ethertype_cmd.func_id = hinic3_global_func_id(hwdev);
+	ethertype_cmd.pkt_type = pkt_type;
+	ethertype_cmd.pkt_type_en = en;
+	ethertype_cmd.qid = (uint8_t)queue_id;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_FDIR_STATUS,
+				     &ethertype_cmd, sizeof(ethertype_cmd),
+				     &ethertype_cmd, &out_size);
+	if (err || ethertype_cmd.head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "set fdir ethertype rule failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x, func_id %d",
+			    err, ethertype_cmd.head.status, out_size,
+			    ethertype_cmd.func_id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_add_tcam_rule(struct hinic3_hwdev *hwdev, struct hinic3_tcam_cfg_rule *tcam_rule,
+		     uint8_t tcam_rule_type)
+{
+	struct hinic3_fdir_add_rule tcam_cmd;
+	uint16_t out_size = sizeof(tcam_cmd);
+	int err;
+
+	if (!hwdev || !tcam_rule)
+		return -EINVAL;
+	/* Check whether the index is out of range. */
+	if (tcam_rule->index >= HINIC3_MAX_TCAM_RULES_NUM) {
+		PMD_DRV_LOG(ERR, "Tcam rules num to add is invalid");
+		return -EINVAL;
+	}
+
+	memset(&tcam_cmd, 0, sizeof(struct hinic3_fdir_add_rule));
+	tcam_cmd.func_id = hinic3_global_func_id(hwdev);
+	memcpy((void *)&tcam_cmd.rule, (void *)tcam_rule,
+	       sizeof(struct hinic3_tcam_cfg_rule));
+	tcam_cmd.type = tcam_rule_type;
+
+	/* Synchronize the information to the management module. */
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_ADD_TC_FLOW,
+				     &tcam_cmd, sizeof(tcam_cmd), &tcam_cmd,
+				     &out_size);
+	if (err || tcam_cmd.msg_head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Add tcam rule failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, tcam_cmd.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_del_tcam_rule(struct hinic3_hwdev *hwdev, uint32_t index, uint8_t tcam_rule_type)
+{
+	struct hinic3_fdir_del_rule tcam_cmd;
+	uint16_t out_size = sizeof(tcam_cmd);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+	/* Check whether the index is out of range. */
+	if (index >= HINIC3_MAX_TCAM_RULES_NUM) {
+		PMD_DRV_LOG(ERR, "Tcam rules num to del is invalid");
+		return -EINVAL;
+	}
+
+	memset(&tcam_cmd, 0, sizeof(struct hinic3_fdir_del_rule));
+	tcam_cmd.func_id = hinic3_global_func_id(hwdev);
+	tcam_cmd.index_start = index;
+	tcam_cmd.index_num = 1;
+	tcam_cmd.type = tcam_rule_type;
+
+	/* Synchronize the information to the management module. */
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_DEL_TC_FLOW,
+				     &tcam_cmd, sizeof(tcam_cmd), &tcam_cmd,
+				     &out_size);
+	if (err || tcam_cmd.msg_head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Del tcam rule failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, tcam_cmd.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_cfg_tcam_block(struct hinic3_hwdev *hwdev, uint8_t alloc_en, uint16_t *index)
+{
+	struct hinic3_tcam_block tcam_block_info;
+	uint16_t out_size = sizeof(tcam_block_info);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+	/* Initialization TCAM block structure. */
+	memset(&tcam_block_info, 0, sizeof(struct hinic3_tcam_block));
+	tcam_block_info.func_id = hinic3_global_func_id(hwdev);
+	tcam_block_info.alloc_en = alloc_en;
+	tcam_block_info.tcam_type = HINIC3_TCAM_BLOCK_NORMAL_TYPE;
+	tcam_block_info.tcam_block_index = *index;
+
+	/* Synchronize the information to the management module. */
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_CFG_TCAM_BLOCK,
+				     &tcam_block_info, sizeof(tcam_block_info),
+				     &tcam_block_info, &out_size);
+	if (err || !out_size || tcam_block_info.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set tcam block failed, err: %d, status: 0x%x, out "
+			    "size: 0x%x",
+			    err, tcam_block_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	/* Update TCAM block of index. */
+	if (alloc_en)
+		*index = tcam_block_info.tcam_block_index;
+
+	return 0;
+}
+
+int
+hinic3_alloc_tcam_block(struct hinic3_hwdev *hwdev, uint16_t *index)
+{
+	return hinic3_cfg_tcam_block(hwdev, HINIC3_TCAM_BLOCK_ENABLE, index);
+}
+
+int
+hinic3_free_tcam_block(struct hinic3_hwdev *hwdev, uint16_t *index)
+{
+	return hinic3_cfg_tcam_block(hwdev, HINIC3_TCAM_BLOCK_DISABLE, index);
+}
+
+int
+hinic3_flush_tcam_rule(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_flush_tcam_rules tcam_flush;
+	uint16_t out_size = sizeof(tcam_flush);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&tcam_flush, 0, sizeof(struct hinic3_flush_tcam_rules));
+	tcam_flush.func_id = hinic3_global_func_id(hwdev);
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
+		HINIC3_NIC_CMD_FLUSH_TCAM, &tcam_flush,
+		sizeof(struct hinic3_flush_tcam_rules), &tcam_flush, &out_size);
+	if (tcam_flush.msg_head.status == HINIC3_MGMT_CMD_UNSUPPORTED) {
+		err = HINIC3_MGMT_CMD_UNSUPPORTED;
+		PMD_DRV_LOG(INFO,
+			    "Firmware/uP doesn't support flush tcam fdir");
+	} else if (err || (!out_size) || tcam_flush.msg_head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Flush tcam fdir rules failed, err: %d, status: "
+			    "0x%x, out size: 0x%x",
+			    err, tcam_flush.msg_head.status, out_size);
+		err = -EIO;
+	}
+
+	return err;
+}
+
+int
+hinic3_set_fdir_tcam_rule_filter(struct hinic3_hwdev *hwdev, bool enable)
+{
+	struct hinic3_port_tcam_info port_tcam_cmd;
+	uint16_t out_size = sizeof(port_tcam_cmd);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+	/* Initialization information. */
+	memset(&port_tcam_cmd, 0, sizeof(port_tcam_cmd));
+	port_tcam_cmd.func_id = hinic3_global_func_id(hwdev);
+	port_tcam_cmd.tcam_enable = (uint8_t)enable;
+
+	/* Synchronize the information to the management module. */
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_ENABLE_TCAM,
+				     &port_tcam_cmd, sizeof(port_tcam_cmd),
+				     &port_tcam_cmd, &out_size);
+	if ((port_tcam_cmd.msg_head.status != HINIC3_MGMT_CMD_UNSUPPORTED &&
+	     port_tcam_cmd.msg_head.status) ||
+	    err || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Set fdir tcam filter failed, err: %d, "
+			    "status: 0x%x, out size: 0x%x, enable: 0x%x",
+			    err, port_tcam_cmd.msg_head.status, out_size,
+			    enable);
+		return -EIO;
+	}
+
+	if (port_tcam_cmd.msg_head.status == HINIC3_MGMT_CMD_UNSUPPORTED) {
+		err = HINIC3_MGMT_CMD_UNSUPPORTED;
+		PMD_DRV_LOG(WARNING,
+			    "Fw doesn't support setting fdir tcam filter");
+	}
+
+	return err;
+}
+
+int
+hinic3_set_rq_flush(struct hinic3_hwdev *hwdev, uint16_t q_id)
+{
+	struct hinic3_cmd_set_rq_flush *rq_flush_msg = NULL;
+	struct hinic3_cmd_buf *cmd_buf = NULL;
+	uint64_t out_param = EIO;
+	int err;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Failed to allocate cmd buf");
+		return -ENOMEM;
+	}
+
+	cmd_buf->size = sizeof(*rq_flush_msg);
+
+	rq_flush_msg = cmd_buf->buf;
+	rq_flush_msg->local_rq_id = q_id;
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	rq_flush_msg->value = rte_cpu_to_be_32(rq_flush_msg->value);
+
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_SET_RQ_FLUSH, cmd_buf,
+				      &out_param, 0);
+	if (err || out_param != 0) {
+		PMD_DRV_LOG(ERR,
+			"Failed to set rq flush, err:%d, out_param:0x%" PRIx64,
+			err, out_param);
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(cmd_buf);
+
+	return err;
+}
+
+int
+msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod,
+				uint16_t cmd, void *buf_in, uint16_t in_size, void *buf_out, uint16_t *out_size)
+{
+	uint32_t i;
+	bool cmd_to_pf = false;
+	if (hinic3_func_type(hwdev) == TYPE_VF) {
+		if (mod == HINIC3_MOD_HILINK) {
+			for (i = 0; i < RTE_DIM(vf_mag_cmd_handler); i++) {
+				if (cmd == vf_mag_cmd_handler[i].cmd)
+					cmd_to_pf = true;
+			}
+		} else if (mod == HINIC3_MOD_L2NIC) {
+			for (i = 0; i < RTE_DIM(vf_cmd_handler); i++) {
+				if (cmd == vf_cmd_handler[i].cmd)
+					cmd_to_pf = true;
+			}
+		}
+	}
+	if (cmd_to_pf)
+		return hinic3_send_mbox_to_mgmt(hwdev, mod, cmd, hinic3_pf_id_of_vf(hwdev),
+		buf_in, in_size, buf_out, out_size, 0);
+	return hinic3_msg_to_mgmt_sync(hwdev, mod, cmd, buf_in,
+				       in_size, buf_out, out_size, 0);
+}
+
+int
+hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
+			      enum hinic3_link_follow_status status)
+{
+	struct mag_cmd_set_link_follow follow;
+	uint16_t out_size = sizeof(follow);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	if (status >= HINIC3_LINK_FOLLOW_STATUS_MAX) {
+		PMD_DRV_LOG(ERR, "Invalid link follow status: %d", status);
+		return -EINVAL;
+	}
+
+	memset(&follow, 0, sizeof(follow));
+	follow.function_id = hinic3_global_func_id(hwdev);
+	follow.follow = status;
+
+	err = msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, MAG_CMD_SET_LINK_FOLLOW, &follow,
+				   sizeof(follow), &follow, &out_size);
+	if ((follow.head.status != HINIC3_MGMT_CMD_UNSUPPORTED &&
+	     follow.head.status) ||
+	    err || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to set link status follow port status, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, follow.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return follow.head.status;
+}
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
new file mode 100644
index 0000000000..7658ae45c3
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -0,0 +1,1529 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_NIC_CFG_H_
+#define _HINIC3_NIC_CFG_H_
+
+#include "hinic3_mgmt.h"
+
+#ifndef ETH_ALEN
+#define ETH_ALEN 6
+#endif
+
+#define OS_VF_ID_TO_HW(os_vf_id) ((os_vf_id) + 1)
+#define HW_VF_ID_TO_OS(hw_vf_id) ((hw_vf_id) - 1)
+
+#define HINIC3_VLAN_PRIORITY_SHIFT 13
+
+#define HINIC3_DCB_UP_MAX 0x8
+
+#define HINIC3_MAX_NUM_RQ 256
+
+#define HINIC3_MAX_MTU_SIZE 9600
+#define HINIC3_MIN_MTU_SIZE 256
+
+#define HINIC3_COS_NUM_MAX 8
+
+#define HINIC3_VLAN_TAG_SIZE 4
+#define HINIC3_ETH_OVERHEAD \
+	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + HINIC3_VLAN_TAG_SIZE * 2)
+
+#define HINIC3_MIN_FRAME_SIZE	    (HINIC3_MIN_MTU_SIZE + HINIC3_ETH_OVERHEAD)
+#define HINIC3_MAX_JUMBO_FRAME_SIZE (HINIC3_MAX_MTU_SIZE + HINIC3_ETH_OVERHEAD)
+
+#define HINIC3_MTU_TO_PKTLEN(mtu) (mtu)
+
+#define HINIC3_PKTLEN_TO_MTU(pktlen) (pktlen)
+
+#define HINIC3_PF_SET_VF_ALREADY 0x4
+#define HINIC3_MGMT_STATUS_EXIST 0x6
+#define CHECK_IPSU_15BIT	 0x8000
+
+#define HINIC3_MGMT_STATUS_TABLE_EMPTY 0xB
+#define HINIC3_MGMT_STATUS_TABLE_FULL  0xC
+
+#define HINIC3_MGMT_CMD_UNSUPPORTED 0xFF
+
+#define HINIC3_MAX_UC_MAC_ADDRS 128
+#define HINIC3_MAX_MC_MAC_ADDRS 2048
+
+#define CAP_INFO_MAX_LEN 512
+#define VENDOR_MAX_LEN	 17
+
+/* Structures for RSS config. */
+#define HINIC3_RSS_INDIR_SIZE	   256
+#define HINIC3_RSS_INDIR_CMDQ_SIZE 128
+#define HINIC3_RSS_KEY_SIZE	   40
+#define HINIC3_RSS_ENABLE	   0x01
+#define HINIC3_RSS_DISABLE	   0x00
+#define HINIC3_INVALID_QID_BASE	   0xffff
+
+#ifndef ETH_SPEED_NUM_200G
+#define ETH_SPEED_NUM_200G 200000 /**< 200 Gbps. */
+#endif
+
+struct hinic3_rss_type {
+	uint8_t tcp_ipv6_ext;
+	uint8_t ipv6_ext;
+	uint8_t tcp_ipv6;
+	uint8_t ipv6;
+	uint8_t tcp_ipv4;
+	uint8_t ipv4;
+	uint8_t udp_ipv6;
+	uint8_t udp_ipv4;
+};
+
+enum hinic3_rss_hash_type {
+	HINIC3_RSS_HASH_ENGINE_TYPE_XOR = 0,
+	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP,
+	HINIC3_RSS_HASH_ENGINE_TYPE_MAX,
+};
+
+#define MAX_FEATURE_QWORD 4
+struct hinic3_cmd_feature_nego {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t opcode; /**< 1: set, 0: get. */
+	uint8_t rsvd;
+	uint64_t s_feature[MAX_FEATURE_QWORD];
+};
+
+/* Structures for port info. */
+struct nic_port_info {
+	uint8_t port_type;
+	uint8_t autoneg_cap;
+	uint8_t autoneg_state;
+	uint8_t duplex;
+	uint8_t speed;
+	uint8_t fec;
+};
+
+enum hinic3_link_status { HINIC3_LINK_DOWN = 0, HINIC3_LINK_UP };
+
+enum nic_media_type {
+	MEDIA_UNKNOWN = -1,
+	MEDIA_FIBRE = 0,
+	MEDIA_COPPER,
+	MEDIA_BACKPLANE
+};
+
+enum nic_speed_level {
+	LINK_SPEED_NOT_SET = 0,
+	LINK_SPEED_10MB,
+	LINK_SPEED_100MB,
+	LINK_SPEED_1GB,
+	LINK_SPEED_10GB,
+	LINK_SPEED_25GB,
+	LINK_SPEED_40GB,
+	LINK_SPEED_50GB,
+	LINK_SPEED_100GB,
+	LINK_SPEED_200GB,
+	LINK_SPEED_LEVELS,
+};
+
+enum hinic3_nic_event_type {
+	EVENT_NIC_LINK_DOWN,
+	EVENT_NIC_LINK_UP,
+	EVENT_NIC_PORT_MODULE_EVENT,
+	EVENT_NIC_DCB_STATE_CHANGE,
+};
+
+enum hinic3_link_port_type {
+	LINK_PORT_UNKNOWN,
+	LINK_PORT_OPTICAL_MM,
+	LINK_PORT_OPTICAL_SM,
+	LINK_PORT_PAS_COPPER,
+	LINK_PORT_ACC,
+	LINK_PORT_BASET,
+	LINK_PORT_AOC = 0x40,
+	LINK_PORT_ELECTRIC,
+	LINK_PORT_BACKBOARD_INTERFACE,
+};
+
+enum hilink_fibre_subtype {
+	FIBRE_SUBTYPE_SR = 1,
+	FIBRE_SUBTYPE_LR,
+	FIBRE_SUBTYPE_MAX,
+};
+
+enum hilink_fec_type {
+	HILINK_FEC_NOT_SET,
+	HILINK_FEC_RSFEC,
+	HILINK_FEC_BASEFEC,
+	HILINK_FEC_NOFEC,
+	HILINK_FEC_LLRSFE,
+	HILINK_FEC_MAX_TYPE,
+};
+
+enum mag_cmd_port_an {
+	PORT_AN_NOT_SET = 0,
+	PORT_CFG_AN_ON = 1,
+	PORT_CFG_AN_OFF = 2
+};
+
+enum mag_cmd_port_speed {
+	PORT_SPEED_NOT_SET = 0,
+	PORT_SPEED_10MB = 1,
+	PORT_SPEED_100MB = 2,
+	PORT_SPEED_1GB = 3,
+	PORT_SPEED_10GB = 4,
+	PORT_SPEED_25GB = 5,
+	PORT_SPEED_40GB = 6,
+	PORT_SPEED_50GB = 7,
+	PORT_SPEED_100GB = 8,
+	PORT_SPEED_200GB = 9,
+	PORT_SPEED_UNKNOWN
+};
+
+struct hinic3_sq_attr {
+	uint8_t dma_attr_off;
+	uint8_t pending_limit;
+	uint8_t coalescing_time;
+	uint8_t intr_en;
+	uint16_t intr_idx;
+	uint32_t l2nic_sqn;
+	uint64_t ci_dma_base;
+};
+
+struct hinic3_cmd_cons_idx_attr {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_idx;
+	uint8_t dma_attr_off;
+	uint8_t pending_limit;
+	uint8_t coalescing_time;
+	uint8_t intr_en;
+	uint16_t intr_idx;
+	uint32_t l2nic_sqn;
+	uint32_t rsvd;
+	uint64_t ci_addr;
+};
+
+struct hinic3_port_mac_set {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t vlan_id;
+	uint16_t rsvd1;
+	uint8_t mac[ETH_ALEN];
+};
+
+struct hinic3_port_mac_update {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t vlan_id;
+	uint16_t rsvd1;
+	uint8_t old_mac[ETH_ALEN];
+	uint16_t rsvd2;
+	uint8_t new_mac[ETH_ALEN];
+};
+
+struct hinic3_ppa_cfg_state_cmd {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t ppa_state;
+	uint8_t rsvd;
+};
+
+struct hinic3_ppa_cfg_mode_cmd {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t rsvd0;
+	uint8_t ppa_mode;
+	uint8_t qpc_func_nums;
+	uint16_t base_qpc_func_id;
+	uint16_t rsvd1;
+};
+
+struct hinic3_ppa_cfg_flush_cmd {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t rsvd0;
+	uint8_t flush_en; /**< 0: flush done, 1: in flush operation. */
+	uint8_t rsvd1;
+};
+
+struct hinic3_ppa_fdir_query_cmd {
+	struct mgmt_msg_head msg_head;
+
+	uint32_t index;
+	uint32_t rsvd;
+	uint64_t pkt_nums;
+	uint64_t pkt_bytes;
+};
+
+#define HINIC3_CMD_OP_ADD 1
+#define HINIC3_CMD_OP_DEL 0
+
+struct hinic3_cmd_vlan_config {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t opcode;
+	uint8_t rsvd1;
+	uint16_t vlan_id;
+	uint16_t rsvd2;
+};
+
+struct hinic3_cmd_set_vlan_filter {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t rsvd[2];
+	/* Bit0: vlan filter en, bit1: broadcast filter en. */
+	uint32_t vlan_filter_ctrl;
+};
+
+struct hinic3_cmd_port_info {
+	struct mgmt_msg_head msg_head;
+
+	uint8_t port_id;
+	uint8_t rsvd1[3];
+	uint8_t port_type;
+	uint8_t autoneg_cap;
+	uint8_t autoneg_state;
+	uint8_t duplex;
+	uint8_t speed;
+	uint8_t fec;
+	uint16_t rsvd2;
+	uint32_t rsvd3[4];
+};
+
+struct hinic3_cmd_link_state {
+	struct mgmt_msg_head msg_head;
+
+	uint8_t port_id;
+	uint8_t state;
+	uint16_t rsvd1;
+};
+
+struct nic_pause_config {
+	uint8_t auto_neg;
+	uint8_t rx_pause;
+	uint8_t tx_pause;
+};
+
+struct hinic3_cmd_pause_config {
+	struct mgmt_msg_head msg_head;
+
+	uint8_t port_id;
+	uint8_t opcode;
+	uint16_t rsvd1;
+	uint8_t auto_neg;
+	uint8_t rx_pause;
+	uint8_t tx_pause;
+	uint8_t rsvd2[5];
+};
+
+struct hinic3_vport_state {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+	uint8_t state; /**< 0:disable, 1:enable. */
+	uint8_t rsvd2[3];
+};
+
+#define MAG_CMD_PORT_DISABLE 0x0
+#define MAG_CMD_TX_ENABLE    0x1
+#define MAG_CMD_RX_ENABLE    0x2
+/**
+ * The physical port is disable only when all pf of the port are set to down, if
+ * any pf is enable, the port is enable.
+ */
+struct mag_cmd_set_port_enable {
+	struct mgmt_msg_head head;
+	/* function_id should not more than the max support pf_id(32). */
+	uint16_t function_id;
+	uint16_t rsvd0;
+
+	/* bitmap bit0:tx_en, bit1:rx_en. */
+	uint8_t state;
+	uint8_t rsvd1[3];
+};
+
+struct mag_cmd_get_port_enable {
+	struct mgmt_msg_head head;
+
+	uint8_t port;
+	uint8_t state; /**< bitmap bit0:tx_en, bit1:rx_en. */
+	uint8_t rsvd0[2];
+};
+
+struct hinic3_cmd_clear_qp_resource {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+};
+
+struct hinic3_port_stats_info {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+};
+
+struct hinic3_vport_stats {
+	uint64_t tx_unicast_pkts_vport;
+	uint64_t tx_unicast_bytes_vport;
+	uint64_t tx_multicast_pkts_vport;
+	uint64_t tx_multicast_bytes_vport;
+	uint64_t tx_broadcast_pkts_vport;
+	uint64_t tx_broadcast_bytes_vport;
+
+	uint64_t rx_unicast_pkts_vport;
+	uint64_t rx_unicast_bytes_vport;
+	uint64_t rx_multicast_pkts_vport;
+	uint64_t rx_multicast_bytes_vport;
+	uint64_t rx_broadcast_pkts_vport;
+	uint64_t rx_broadcast_bytes_vport;
+
+	uint64_t tx_discard_vport;
+	uint64_t rx_discard_vport;
+	uint64_t tx_err_vport;
+	uint64_t rx_err_vport;
+};
+
+struct hinic3_cmd_vport_stats {
+	struct mgmt_msg_head msg_head;
+
+	uint32_t stats_size;
+	uint32_t rsvd1;
+	struct hinic3_vport_stats stats;
+	uint64_t rsvd2[6];
+};
+
+struct hinic3_phy_port_stats {
+	uint64_t mac_rx_total_octs_port;
+	uint64_t mac_tx_total_octs_port;
+	uint64_t mac_rx_under_frame_pkts_port;
+	uint64_t mac_rx_frag_pkts_port;
+	uint64_t mac_rx_64_oct_pkts_port;
+	uint64_t mac_rx_127_oct_pkts_port;
+	uint64_t mac_rx_255_oct_pkts_port;
+	uint64_t mac_rx_511_oct_pkts_port;
+	uint64_t mac_rx_1023_oct_pkts_port;
+	uint64_t mac_rx_max_oct_pkts_port;
+	uint64_t mac_rx_over_oct_pkts_port;
+	uint64_t mac_tx_64_oct_pkts_port;
+	uint64_t mac_tx_127_oct_pkts_port;
+	uint64_t mac_tx_255_oct_pkts_port;
+	uint64_t mac_tx_511_oct_pkts_port;
+	uint64_t mac_tx_1023_oct_pkts_port;
+	uint64_t mac_tx_max_oct_pkts_port;
+	uint64_t mac_tx_over_oct_pkts_port;
+	uint64_t mac_rx_good_pkts_port;
+	uint64_t mac_rx_crc_error_pkts_port;
+	uint64_t mac_rx_broadcast_ok_port;
+	uint64_t mac_rx_multicast_ok_port;
+	uint64_t mac_rx_mac_frame_ok_port;
+	uint64_t mac_rx_length_err_pkts_port;
+	uint64_t mac_rx_vlan_pkts_port;
+	uint64_t mac_rx_pause_pkts_port;
+	uint64_t mac_rx_unknown_mac_frame_port;
+	uint64_t mac_tx_good_pkts_port;
+	uint64_t mac_tx_broadcast_ok_port;
+	uint64_t mac_tx_multicast_ok_port;
+	uint64_t mac_tx_underrun_pkts_port;
+	uint64_t mac_tx_mac_frame_ok_port;
+	uint64_t mac_tx_vlan_pkts_port;
+	uint64_t mac_tx_pause_pkts_port;
+};
+
+struct mag_phy_port_stats {
+	uint64_t mac_tx_fragment_pkt_num;
+	uint64_t mac_tx_undersize_pkt_num;
+	uint64_t mac_tx_undermin_pkt_num;
+	uint64_t mac_tx_64_oct_pkt_num;
+	uint64_t mac_tx_65_127_oct_pkt_num;
+	uint64_t mac_tx_128_255_oct_pkt_num;
+	uint64_t mac_tx_256_511_oct_pkt_num;
+	uint64_t mac_tx_512_1023_oct_pkt_num;
+	uint64_t mac_tx_1024_1518_oct_pkt_num;
+	uint64_t mac_tx_1519_2047_oct_pkt_num;
+	uint64_t mac_tx_2048_4095_oct_pkt_num;
+	uint64_t mac_tx_4096_8191_oct_pkt_num;
+	uint64_t mac_tx_8192_9216_oct_pkt_num;
+	uint64_t mac_tx_9217_12287_oct_pkt_num;
+	uint64_t mac_tx_12288_16383_oct_pkt_num;
+	uint64_t mac_tx_1519_max_bad_pkt_num;
+	uint64_t mac_tx_1519_max_good_pkt_num;
+	uint64_t mac_tx_oversize_pkt_num;
+	uint64_t mac_tx_jabber_pkt_num;
+	uint64_t mac_tx_bad_pkt_num;
+	uint64_t mac_tx_bad_oct_num;
+	uint64_t mac_tx_good_pkt_num;
+	uint64_t mac_tx_good_oct_num;
+	uint64_t mac_tx_total_pkt_num;
+	uint64_t mac_tx_total_oct_num;
+	uint64_t mac_tx_uni_pkt_num;
+	uint64_t mac_tx_multi_pkt_num;
+	uint64_t mac_tx_broad_pkt_num;
+	uint64_t mac_tx_pause_num;
+	uint64_t mac_tx_pfc_pkt_num;
+	uint64_t mac_tx_pfc_pri0_pkt_num;
+	uint64_t mac_tx_pfc_pri1_pkt_num;
+	uint64_t mac_tx_pfc_pri2_pkt_num;
+	uint64_t mac_tx_pfc_pri3_pkt_num;
+	uint64_t mac_tx_pfc_pri4_pkt_num;
+	uint64_t mac_tx_pfc_pri5_pkt_num;
+	uint64_t mac_tx_pfc_pri6_pkt_num;
+	uint64_t mac_tx_pfc_pri7_pkt_num;
+	uint64_t mac_tx_control_pkt_num;
+	uint64_t mac_tx_err_all_pkt_num;
+	uint64_t mac_tx_from_app_good_pkt_num;
+	uint64_t mac_tx_from_app_bad_pkt_num;
+
+	uint64_t mac_rx_fragment_pkt_num;
+	uint64_t mac_rx_undersize_pkt_num;
+	uint64_t mac_rx_undermin_pkt_num;
+	uint64_t mac_rx_64_oct_pkt_num;
+	uint64_t mac_rx_65_127_oct_pkt_num;
+	uint64_t mac_rx_128_255_oct_pkt_num;
+	uint64_t mac_rx_256_511_oct_pkt_num;
+	uint64_t mac_rx_512_1023_oct_pkt_num;
+	uint64_t mac_rx_1024_1518_oct_pkt_num;
+	uint64_t mac_rx_1519_2047_oct_pkt_num;
+	uint64_t mac_rx_2048_4095_oct_pkt_num;
+	uint64_t mac_rx_4096_8191_oct_pkt_num;
+	uint64_t mac_rx_8192_9216_oct_pkt_num;
+	uint64_t mac_rx_9217_12287_oct_pkt_num;
+	uint64_t mac_rx_12288_16383_oct_pkt_num;
+	uint64_t mac_rx_1519_max_bad_pkt_num;
+	uint64_t mac_rx_1519_max_good_pkt_num;
+	uint64_t mac_rx_oversize_pkt_num;
+	uint64_t mac_rx_jabber_pkt_num;
+	uint64_t mac_rx_bad_pkt_num;
+	uint64_t mac_rx_bad_oct_num;
+	uint64_t mac_rx_good_pkt_num;
+	uint64_t mac_rx_good_oct_num;
+	uint64_t mac_rx_total_pkt_num;
+	uint64_t mac_rx_total_oct_num;
+	uint64_t mac_rx_uni_pkt_num;
+	uint64_t mac_rx_multi_pkt_num;
+	uint64_t mac_rx_broad_pkt_num;
+	uint64_t mac_rx_pause_num;
+	uint64_t mac_rx_pfc_pkt_num;
+	uint64_t mac_rx_pfc_pri0_pkt_num;
+	uint64_t mac_rx_pfc_pri1_pkt_num;
+	uint64_t mac_rx_pfc_pri2_pkt_num;
+	uint64_t mac_rx_pfc_pri3_pkt_num;
+	uint64_t mac_rx_pfc_pri4_pkt_num;
+	uint64_t mac_rx_pfc_pri5_pkt_num;
+	uint64_t mac_rx_pfc_pri6_pkt_num;
+	uint64_t mac_rx_pfc_pri7_pkt_num;
+	uint64_t mac_rx_control_pkt_num;
+	uint64_t mac_rx_sym_err_pkt_num;
+	uint64_t mac_rx_fcs_err_pkt_num;
+	uint64_t mac_rx_send_app_good_pkt_num;
+	uint64_t mac_rx_send_app_bad_pkt_num;
+	uint64_t mac_rx_unfilter_pkt_num;
+};
+
+struct mag_cmd_port_stats_info {
+	struct mgmt_msg_head head;
+
+	uint8_t port_id;
+	uint8_t rsvd0[3];
+};
+
+struct mag_cmd_get_port_stat {
+	struct mgmt_msg_head head;
+
+	struct mag_phy_port_stats counter;
+	uint64_t rsvd1[15];
+};
+
+struct param_head {
+	uint8_t valid_len;
+	uint8_t info_type;
+	uint8_t rsvd[2];
+};
+
+struct mag_port_link_param {
+	struct param_head head;
+
+	uint8_t an;
+	uint8_t fec;
+	uint8_t speed;
+	uint8_t rsvd0;
+
+	uint32_t used;
+	uint32_t an_fec_ability;
+	uint32_t an_speed_ability;
+	uint32_t an_pause_ability;
+};
+
+struct mag_port_wire_info {
+	struct param_head head;
+
+	uint8_t status;
+	uint8_t rsvd0[3];
+
+	uint8_t wire_type;
+	uint8_t default_fec;
+	uint8_t speed;
+	uint8_t rsvd1;
+	uint32_t speed_ability;
+};
+
+struct mag_port_adapt_info {
+	struct param_head head;
+
+	uint32_t adapt_en;
+	uint32_t flash_adapt;
+	uint32_t rsvd0[2];
+
+	uint32_t wire_node;
+	uint32_t an_en;
+	uint32_t speed;
+	uint32_t fec;
+};
+
+struct mag_port_param_info {
+	uint8_t parameter_cnt;
+	uint8_t lane_id;
+	uint8_t lane_num;
+	uint8_t rsvd0;
+
+	struct mag_port_link_param default_cfg;
+	struct mag_port_link_param bios_cfg;
+	struct mag_port_link_param tool_cfg;
+	struct mag_port_link_param final_cfg;
+
+	struct mag_port_wire_info wire_info;
+	struct mag_port_adapt_info adapt_info;
+};
+
+#define XSFP_VENDOR_NAME_LEN 16
+struct mag_cmd_event_port_info {
+	struct mgmt_msg_head head;
+
+	uint8_t port_id;
+	uint8_t event_type;
+	uint8_t rsvd0[2];
+
+	/* Optical Module Related. */
+	uint8_t vendor_name[XSFP_VENDOR_NAME_LEN];
+	uint32_t port_type;	   /**< fiber / copper. */
+	uint32_t port_sub_type; /**< sr / lr. */
+	uint32_t cable_length;  /**< 1 / 3 / 5 m. */
+	uint8_t cable_temp;	   /**< Temperature. */
+	uint8_t max_speed;	   /**< Max rate of optical module. */
+	uint8_t sfp_type;	   /**< sfp / qsfp. */
+	uint8_t rsvd1;
+	uint32_t power[4]; /**< Optical power. */
+
+	uint8_t an_state;
+	uint8_t fec;
+	uint16_t speed;
+
+	uint8_t gpio_insert; /**< 0: present, 1: absent. */
+	uint8_t alos;
+	uint8_t rx_los;
+	uint8_t pma_ctrl;
+
+	uint32_t pma_fifo_reg;
+	uint32_t pma_signal_ok_reg;
+	uint32_t pcs_64_66b_reg;
+	uint32_t rf_lf;
+	uint8_t pcs_link;
+	uint8_t pcs_mac_link;
+	uint8_t tx_enable;
+	uint8_t rx_enable;
+	uint32_t pcs_err_cnt;
+
+	uint8_t eq_data[38];
+	uint8_t rsvd2[2];
+
+	uint32_t his_link_machine_state;
+	uint32_t cur_link_machine_state;
+	uint8_t his_machine_state_data[128];
+	uint8_t cur_machine_state_data[128];
+	uint8_t his_machine_state_length;
+	uint8_t cur_machine_state_length;
+
+	struct mag_port_param_info param_info;
+	uint8_t rsvd3[360];
+};
+
+struct hinic3_port_stats {
+	struct mgmt_msg_head msg_head;
+
+	struct hinic3_phy_port_stats stats;
+};
+
+struct hinic3_cmd_clear_vport_stats {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd;
+};
+
+struct hinic3_cmd_clear_port_stats {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd;
+};
+
+struct hinic3_cmd_qpn {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t base_qpn;
+};
+
+enum hinic3_func_tbl_cfg_bitmap {
+	FUNC_CFG_INIT,
+	FUNC_CFG_RX_BUF_SIZE,
+	FUNC_CFG_MTU,
+};
+
+struct hinic3_func_tbl_cfg {
+	uint16_t rx_wqe_buf_size;
+	uint16_t mtu;
+	uint32_t rsvd[9];
+};
+
+struct hinic3_cmd_set_func_tbl {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd;
+
+	uint32_t cfg_bitmap;
+	struct hinic3_func_tbl_cfg tbl_cfg;
+};
+
+struct hinic3_rx_mode_config {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+	uint32_t rx_mode;
+};
+
+struct hinic3_cmd_vlan_offload {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t vlan_offload;
+	uint8_t rsvd1[5];
+};
+
+#define HINIC3_CMD_OP_GET 0
+#define HINIC3_CMD_OP_SET 1
+
+struct hinic3_cmd_lro_config {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t opcode;
+	uint8_t rsvd1;
+	uint8_t lro_ipv4_en;
+	uint8_t lro_ipv6_en;
+	uint8_t lro_max_pkt_len; /**< Unit size is 1K. */
+	uint8_t rsvd2[13];
+};
+
+struct hinic3_cmd_lro_timer {
+	struct mgmt_msg_head msg_head;
+
+	uint8_t opcode; /**< 1: set timer value, 0: get timer value. */
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint32_t timer;
+};
+
+struct hinic3_rss_template_mgmt {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t cmd;
+	uint8_t template_id;
+	uint8_t rsvd1[4];
+};
+
+struct hinic3_cmd_rss_hash_key {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t opcode;
+	uint8_t rsvd1;
+	uint8_t key[HINIC3_RSS_KEY_SIZE];
+};
+
+struct hinic3_rss_indir_table {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+	uint8_t indir[HINIC3_RSS_INDIR_SIZE];
+};
+
+struct nic_rss_indirect_tbl {
+	uint32_t rsvd[4]; /**< Make sure that 16B beyond entry[]. */
+	uint16_t entry[HINIC3_RSS_INDIR_SIZE];
+};
+
+struct nic_rss_context_tbl {
+	uint32_t rsvd[4];
+	uint32_t ctx;
+};
+
+struct hinic3_rss_context_table {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+	uint32_t context;
+};
+
+struct hinic3_cmd_rss_engine_type {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t opcode;
+	uint8_t hash_engine;
+	uint8_t rsvd1[4];
+};
+
+struct hinic3_cmd_rss_config {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t rss_en;
+	uint8_t rq_priority_number;
+	uint8_t prio_tc[HINIC3_DCB_UP_MAX];
+	uint32_t rsvd1;
+};
+
+enum {
+	HINIC3_IFLA_VF_LINK_STATE_AUTO,	   /**< Link state of the uplink. */
+	HINIC3_IFLA_VF_LINK_STATE_ENABLE,  /**< Link always up. */
+	HINIC3_IFLA_VF_LINK_STATE_DISABLE, /**< Link always down. */
+};
+
+struct hinic3_dcb_state {
+	uint8_t dcb_on;
+	uint8_t default_cos;
+	uint8_t trust;
+	uint8_t rsvd1;
+	uint8_t up_cos[HINIC3_DCB_UP_MAX];
+	uint8_t dscp2cos[64];
+	uint32_t rsvd2[7];
+};
+
+struct hinic3_cmd_vf_dcb_state {
+	struct mgmt_msg_head msg_head;
+
+	struct hinic3_dcb_state state;
+};
+
+struct hinic3_cmd_register_vf {
+	struct mgmt_msg_head msg_head;
+
+	uint8_t op_register; /* 0: unregister, 1: register. */
+	uint8_t rsvd[39];
+};
+
+struct hinic3_tcam_result {
+	uint32_t qid;
+	uint32_t rsvd;
+};
+
+#define HINIC3_TCAM_FLOW_KEY_SIZE     44
+#define HINIC3_MAX_TCAM_RULES_NUM     4096
+#define HINIC3_TCAM_BLOCK_ENABLE      1
+#define HINIC3_TCAM_BLOCK_DISABLE     0
+#define HINIC3_TCAM_BLOCK_NORMAL_TYPE 0
+
+struct hinic3_tcam_key_x_y {
+	uint8_t x[HINIC3_TCAM_FLOW_KEY_SIZE];
+	uint8_t y[HINIC3_TCAM_FLOW_KEY_SIZE];
+};
+
+struct hinic3_tcam_cfg_rule {
+	uint32_t index;
+	struct hinic3_tcam_result data;
+	struct hinic3_tcam_key_x_y key;
+};
+
+/* Define the TCAM type. */
+#define TCAM_RULE_FDIR_TYPE 0
+#define TCAM_RULE_PPA_TYPE  1
+
+struct hinic3_fdir_add_rule {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t type;
+	uint8_t rsvd;
+	struct hinic3_tcam_cfg_rule rule;
+};
+
+struct hinic3_fdir_del_rule {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t type;
+	uint8_t rsvd;
+	uint32_t index_start;
+	uint32_t index_num;
+};
+
+struct hinic3_flush_tcam_rules {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint16_t rsvd;
+};
+
+struct hinic3_tcam_block {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t alloc_en; /* 0: free tcam block, 1: alloc tcam block. */
+	uint8_t tcam_type;
+	uint16_t tcam_block_index;
+	uint16_t rsvd;
+};
+
+struct hinic3_port_tcam_info {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t tcam_enable;
+	uint8_t rsvd1;
+	uint32_t rsvd2;
+};
+
+struct hinic3_set_fdir_ethertype_rule {
+	struct mgmt_msg_head head;
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+	uint8_t pkt_type_en;
+	uint8_t pkt_type;
+	uint8_t qid;
+	uint8_t rsvd2;
+};
+
+struct hinic3_cmd_set_rq_flush {
+	union {
+		struct {
+			uint16_t global_rq_id;
+			uint16_t local_rq_id;
+		};
+		uint32_t value;
+	};
+};
+
+enum hinic3_link_follow_status {
+	HINIC3_LINK_FOLLOW_DEFAULT,
+	HINIC3_LINK_FOLLOW_PORT,
+	HINIC3_LINK_FOLLOW_SEPARATE,
+	HINIC3_LINK_FOLLOW_STATUS_MAX,
+};
+
+struct mag_cmd_set_link_follow {
+	struct mgmt_msg_head head;
+	uint16_t function_id;
+	uint16_t rsvd0;
+	uint8_t follow;
+	uint8_t rsvd1[3];
+};
+
+int msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod, uint16_t cmd,
+			void *buf_in, uint16_t in_size, void *buf_out, uint16_t *out_size);
+
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr);
+
+/**
+ * Update MAC address to hardware.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] old_mac
+ * Old MAC addr to delete.
+ * @param[in] new_mac
+ * New MAC addr to update.
+ * @param[in] vlan_id
+ * Vlan id.
+ * @param func_id
+ * Function index.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, uint8_t *old_mac,
+				uint8_t *new_mac, uint16_t vlan_id, uint16_t func_id);
+
+/**
+ * Get the default mac address.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] mac_addr
+ * Mac address from hardware.
+ * @param[in] ether_len
+ * The length of mac address.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, uint8_t *mac_addr, int ether_len);
+
+/**
+ * Set mac address.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] mac_addr
+ * Mac address from hardware.
+ * @param[in] vlan_id
+ * Vlan id.
+ * @param[in] func_id
+ * Function index.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const uint8_t *mac_addr,
+				 uint16_t vlan_id, uint16_t func_id);
+
+/**
+ * Delete MAC address.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] mac_addr
+ * MAC address from hardware.
+ * @param[in] vlan_id
+ * Vlan id.
+ * @param[in] func_id
+ * Function index.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const uint8_t *mac_addr,
+				 uint16_t vlan_id, uint16_t func_id);
+
+/**
+ * Set function mtu.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] new_mtu
+ * MTU value.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_port_mtu(struct hinic3_hwdev *hwdev, uint16_t new_mtu);
+
+/**
+ * Set function valid status.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] enable
+ * 0: disable, 1: enable.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable);
+
+/**
+ * Set port status.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev
+ * @param[in] enable
+ * 0: disable, 1: enable.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
+
+/**
+ * Get link state.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] link_state
+ * Link state, 0: link down, 1: link up.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_link_state(struct hinic3_hwdev *hwdev, uint8_t *link_state);
+
+/**
+ * Flush queue pairs resource in hardware.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
+
+/**
+ * Set pause info.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] nic_pause
+ * Pause info.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_pause_info(struct hinic3_hwdev *hwdev, struct nic_pause_config nic_pause);
+
+/**
+ * Get pause info.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] nic_pause
+ * Pause info.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_pause_info(struct hinic3_hwdev *hwdev, struct nic_pause_config *nic_pause);
+
+/**
+ * Get function stats.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] stats
+ * Function stats.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, struct hinic3_vport_stats *stats);
+
+/**
+ * Get port stats.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] stats
+ * Port stats.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev, struct mag_phy_port_stats *stats);
+
+int hinic3_clear_vport_stats(struct hinic3_hwdev *hwdev);
+
+int hinic3_clear_phy_port_stats(struct hinic3_hwdev *hwdev);
+
+/**
+ * Init nic hwdev.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_init_nic_hwdev(struct hinic3_hwdev *hwdev);
+
+/**
+ * Free nic hwdev.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ */
+void hinic3_free_nic_hwdev(struct hinic3_hwdev *hwdev);
+
+/**
+ * Set function rx mode.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] enable
+ * Rx mode state, 0-disable, 1-enable.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, uint32_t enable);
+
+/**
+ * Set function vlan offload valid state.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] enable
+ * Rx mode state, 0-disable, 1-enable.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, uint8_t en);
+
+/**
+ * Set rx LRO configuration.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] lro_en
+ * LRO enable state, 0-disable, 1-enable.
+ * @param[in] lro_timer
+ * LRO aggregation timeout.
+ * @param[in] lro_max_pkt_len
+ * LRO coalesce packet size(unit size is 1K).
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32_t lro_timer,
+			    uint32_t lro_max_pkt_len);
+
+/**
+ * Get port info.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] port_info
+ * Port info, including autoneg, port type, duplex, speed and fec mode.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_port_info(struct hinic3_hwdev *hwdev, struct nic_port_info *port_info);
+
+int hinic3_init_function_table(struct hinic3_hwdev *hwdev, uint16_t rx_buff_len);
+
+/**
+ * Alloc RSS template table.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_template_alloc(struct hinic3_hwdev *hwdev);
+
+/**
+ * Free RSS template table.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_template_free(struct hinic3_hwdev *hwdev);
+
+/**
+ * Set RSS indirect table.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] indir_table
+ * RSS indirect table.
+ * @param[in] indir_table_size
+ * RSS indirect table size.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table,
+			     uint32_t indir_table_size);
+
+/**
+ * Get RSS indirect table.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] indir_table
+ * RSS indirect table.
+ * @param[in] indir_table_size
+ * RSS indirect table size.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table,
+			     uint32_t indir_table_size);
+
+/**
+ * Set RSS type.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] rss_type
+ * RSS type, including ipv4, tcpv4, ipv6, tcpv6 and etc.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_rss_type(struct hinic3_hwdev *hwdev, struct hinic3_rss_type rss_type);
+
+/**
+ * Get RSS type.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] rss_type
+ * RSS type, including ipv4, tcpv4, ipv6, tcpv6 and etc.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_rss_type(struct hinic3_hwdev *hwdev, struct hinic3_rss_type *rss_type);
+
+/**
+ * Get RSS hash engine.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] type
+ * RSS hash engine, pmd driver only supports Toeplitz.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_get_hash_engine(struct hinic3_hwdev *hwdev, uint8_t *type);
+
+/**
+ * Set RSS hash engine.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] type
+ * RSS hash engine, pmd driver only supports Toeplitz.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_set_hash_engine(struct hinic3_hwdev *hwdev, uint8_t type);
+
+/**
+ * Set RSS configuration.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] rss_en
+ * RSS enable lag, 0-disable, 1-enable.
+ * @param[in] tc_num
+ * Number of TC.
+ * @param[in] prio_tc
+ * Priority of TC.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_cfg(struct hinic3_hwdev *hwdev, uint8_t rss_en, uint8_t tc_num, uint8_t *prio_tc);
+
+/**
+ * Set RSS hash key.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] key
+ * RSS hash key.
+ * @param[in] key_size
+ * hash key size.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, uint8_t *key, uint16_t key_size);
+
+/**
+ * Add vlan to hardware.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] vlan_id
+ * Vlan id.
+ * @param[in] func_id
+ * Function id.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_add_vlan(struct hinic3_hwdev *hwdev, uint16_t vlan_id, uint16_t func_id);
+
+/**
+ * Delete vlan.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] vlan_id
+ * Vlan id.
+ * @param[in] func_id
+ * Function id.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_del_vlan(struct hinic3_hwdev *hwdev, uint16_t vlan_id, uint16_t func_id);
+
+/**
+ * Set vlan filter.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] vlan_filter_ctrl
+ * Vlan filter enable flag, 0-disable, 1-enable.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, uint32_t vlan_filter_ctrl);
+
+/**
+ * Get VF function default cos.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[out] cos_id
+ * Cos id.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id);
+
+/**
+ * Add tcam rules.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] tcam_rule
+ * Tcam rule, including tcam rule index, tcam action, tcam key and etc.
+ * @param[in] tcam_rule_type
+ * Tcam rule type.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_add_tcam_rule(struct hinic3_hwdev *hwdev, struct hinic3_tcam_cfg_rule *tcam_rule,
+			 uint8_t tcam_rule_type);
+
+/**
+ * Del tcam rules.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] index
+ * Tcam rule index.
+ * @param[in] tcam_rule_type
+ * Tcam rule type.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_del_tcam_rule(struct hinic3_hwdev *hwdev, uint32_t index, uint8_t tcam_rule_type);
+
+/**
+ * Alloc tcam block.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] index
+ * Tcam block index.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_alloc_tcam_block(struct hinic3_hwdev *hwdev, uint16_t *index);
+
+/**
+ * Free tcam block.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] index
+ * Tcam block index.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_free_tcam_block(struct hinic3_hwdev *hwdev, uint16_t *index);
+
+/**
+ * Set fdir tcam function enable or disable.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ * @param[in] enable
+ * Tcam enable flag, 1-enable, 0-disable.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_fdir_tcam_rule_filter(struct hinic3_hwdev *hwdev, bool enable);
+
+/**
+ * Flush fdir tcam rule.
+ *
+ * @param[in] hwdev
+ * Device pointer to hwdev.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_flush_tcam_rule(struct hinic3_hwdev *hwdev);
+
+int hinic3_set_rq_flush(struct hinic3_hwdev *hwdev, uint16_t q_id);
+
+/**
+ * Get service feature HW supported.
+ *
+ * @param[in] dev
+ * Device pointer to hwdev.
+ * @param[in] size
+ * s_feature's array size.
+ * @param[out] s_feature
+ * s_feature HW supported.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_feature_from_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size);
+
+/**
+ * Set service feature driver supported to hardware.
+ *
+ * @param[in] dev
+ * Device pointer to hwdev.
+ * @param[in] size
+ * s_feature's array size.
+ * @param[out] s_feature
+ * s_feature HW supported.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_feature_to_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size);
+
+int hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,
+				uint8_t pkt_type, uint16_t queue_id, uint8_t en);
+
+int hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
+				  enum hinic3_link_follow_status status);
+#endif /* _HINIC3_NIC_CFG_H_ */
diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/meson.build
index 881d1203c6..2acf9e76dc 100644
--- a/drivers/net/hinic3/base/meson.build
+++ b/drivers/net/hinic3/base/meson.build
@@ -9,6 +9,7 @@ sources = files(
         'hinic3_hwdev.c',
         'hinic3_hwif.c',
         'hinic3_mgmt.c',
+        'hinic3_nic_cfg.c',
         'hinic3_nic_event.c',
 )
 
-- 
2.47.0.windows.2

