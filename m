Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D49CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAEDA406B6;
	Sat, 30 Aug 2025 14:41:02 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 7D81840685
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=PKObYCRHG8Hkcnsj2PIEFewrgNr8p2xt5UZPi3Lrigo=;
 b=cjOA1jhqdpSfWsVF34r+wcaUtdldYQYt46OKmQ+eca0+MK3OLeWmMo0jI+CIWf
 gHmP2/pVO7SmPD18MZcWX3S+addqvQ/oWh9+SUjH20VlrRDtMPrsUil6rxwyrICX
 xWVF7MlknSSqyzZo8yxxJdTEd+OmfoRd1RGfia33tDnPk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S13;
 Sat, 30 Aug 2025 20:40:57 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 09/18] net/hinic3: add a NIC business configuration module
Date: Sat, 30 Aug 2025 20:39:21 +0800
Message-ID: <20250830123942.5037-10-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S13
X-Coremail-Antispam: 1Uf129KBjvAXoWDKr1xXw4xtryfGw1kJFy8Grg_yoW3tF1xKo
 WfJr43Kr1Fqr1fCa17Xw1xGFZ3XayqkFn3Aws5tFWSqanrJ34rJF43Ww1aqa4xuFWYyFnI
 kayag39aqrW5J3Z3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFXo2UUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHwK5Cmiy3h4h3AAAsJ
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

From: Yi Chen <chenyi221@huawei.com>=0D

The items of configurations and queries for NIC business include=0D
MAC, VLAN, MTU, RSS and so on. These configurations and queries=0D
are handled by mgmt module. This patch introduces related=0D
data structures and function codes.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 1828 ++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 1527 ++++++++++++++++++=0D
 2 files changed, 3355 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
new file mode 100644=0D
index 0000000000..918ebc37e9=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -0,0 +1,1828 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_atomic.h>=0D
+#include <rte_ether.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_cmdq.h"=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+struct vf_msg_handler {=0D
+	u16 cmd;=0D
+};=0D
+=0D
+static const struct vf_msg_handler vf_cmd_handler[] =3D {=0D
+	{=0D
+		.cmd =3D HINIC3_NIC_CMD_VF_REGISTER,=0D
+	},=0D
+=0D
+	{=0D
+		.cmd =3D HINIC3_NIC_CMD_GET_MAC,=0D
+	},=0D
+=0D
+	{=0D
+		.cmd =3D HINIC3_NIC_CMD_SET_MAC,=0D
+	},=0D
+=0D
+	{=0D
+		.cmd =3D HINIC3_NIC_CMD_DEL_MAC,=0D
+	},=0D
+=0D
+	{=0D
+		.cmd =3D HINIC3_NIC_CMD_UPDATE_MAC,=0D
+	},=0D
+=0D
+	{=0D
+		.cmd =3D HINIC3_NIC_CMD_VF_COS,=0D
+	},=0D
+};=0D
+=0D
+static const struct vf_msg_handler vf_mag_cmd_handler[] =3D {=0D
+	{=0D
+		.cmd =3D MAG_CMD_GET_LINK_STATUS,=0D
+	},=0D
+};=0D
+=0D
+static int mag_msg_to_mgmt_sync(void *hwdev, u16 cmd, void *buf_in, u16 in=
_size,=0D
+				void *buf_out, u16 *out_size);=0D
+=0D
+/**=0D
+ * If device is VF and command is found in a predefined list, send to PF, =
else=0D
+ * send to management module.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the hardware device structure.=0D
+ * @param[in] cmd=0D
+ * The command to send.=0D
+ * @param[in] buf_in=0D
+ * The input buffer containing the request data.=0D
+ * @param[in] in_size=0D
+ * The size of the input buffer.=0D
+ * @param[out] buf_out=0D
+ * The output buffer to receive the response data.=0D
+ * @param[out] out_size=0D
+ * The size of the output buffer on return.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+l2nic_msg_to_mgmt_sync(void *hwdev, u16 cmd, void *buf_in, u16 in_size,=0D
+		       void *buf_out, u16 *out_size)=0D
+{=0D
+	u32 i, cmd_cnt =3D ARRAY_LEN(vf_cmd_handler);=0D
+	bool cmd_to_pf =3D false;=0D
+=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF) {=0D
+		for (i =3D 0; i < cmd_cnt; i++) {=0D
+			if (cmd =3D=3D vf_cmd_handler[i].cmd)=0D
+				cmd_to_pf =3D true;=0D
+		}=0D
+	}=0D
+=0D
+	if (cmd_to_pf) {=0D
+		return hinic3_mbox_to_pf(hwdev, HINIC3_MOD_L2NIC, cmd, buf_in,=0D
+					 in_size, buf_out, out_size, 0);=0D
+	}=0D
+=0D
+	return hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, cmd, buf_in,=0D
+				       in_size, buf_out, out_size, 0);=0D
+}=0D
+=0D
+/**=0D
+ * Set CI table for a SQ.=0D
+ *=0D
+ * Configure the CI table with attributes like CI address, pending limit,=
=0D
+ * coalescing time, and optional interrupt settings for specified SQ.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] attr=0D
+ * Attributes to configure for CI table.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_set_ci_table(void *hwdev, struct hinic3_sq_attr *attr)=0D
+{=0D
+	struct hinic3_cmd_cons_idx_attr cons_idx_attr;=0D
+	u16 out_size =3D sizeof(cons_idx_attr);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !attr)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&cons_idx_attr, 0, sizeof(cons_idx_attr));=0D
+	cons_idx_attr.func_idx =3D hinic3_global_func_id(hwdev);=0D
+	cons_idx_attr.dma_attr_off =3D attr->dma_attr_off;=0D
+	cons_idx_attr.pending_limit =3D attr->pending_limit;=0D
+	cons_idx_attr.coalescing_time =3D attr->coalescing_time;=0D
+=0D
+	if (attr->intr_en) {=0D
+		cons_idx_attr.intr_en =3D attr->intr_en;=0D
+		cons_idx_attr.intr_idx =3D attr->intr_idx;=0D
+	}=0D
+=0D
+	cons_idx_attr.l2nic_sqn =3D attr->l2nic_sqn;=0D
+	cons_idx_attr.ci_addr =3D attr->ci_dma_base;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SQ_CI_ATTR_SET,=0D
+				     &cons_idx_attr, sizeof(cons_idx_attr),=0D
+				     &cons_idx_attr, &out_size);=0D
+	if (err || !out_size || cons_idx_attr.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set ci attribute table failed, "=0D
+			    "err: %d, status: 0x%x, out_size: 0x%x",=0D
+			    err, cons_idx_attr.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+#define PF_SET_VF_MAC(hwdev, status)           \=0D
+	(hinic3_func_type(hwdev) =3D=3D TYPE_VF && \=0D
+	 (status) =3D=3D HINIC3_PF_SET_VF_ALREADY)=0D
+=0D
+static int=0D
+hinic3_check_mac_info(void *hwdev, u8 status, u16 vlan_id)=0D
+{=0D
+	if ((status && status !=3D HINIC3_MGMT_STATUS_EXIST) ||=0D
+	    ((vlan_id & CHECK_IPSU_15BIT) &&=0D
+	     status =3D=3D HINIC3_MGMT_STATUS_EXIST)) {=0D
+		if (PF_SET_VF_MAC(hwdev, status))=0D
+			return 0;=0D
+=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+#define VLAN_N_VID 4096=0D
+=0D
+int=0D
+hinic3_set_mac(void *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id)=
=0D
+{=0D
+	struct hinic3_port_mac_set mac_info;=0D
+	u16 out_size =3D sizeof(mac_info);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !mac_addr)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&mac_info, 0, sizeof(mac_info));=0D
+=0D
+	if (vlan_id >=3D VLAN_N_VID) {=0D
+		PMD_DRV_LOG(ERR, "Invalid VLAN number: %d", vlan_id);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	mac_info.func_id =3D func_id;=0D
+	mac_info.vlan_id =3D vlan_id;=0D
+	memmove(mac_info.mac, mac_addr, ETH_ALEN);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_MAC, &mac_info,=
=0D
+				     sizeof(mac_info), &mac_info, &out_size);=0D
+	if (err || !out_size ||=0D
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,=0D
+				  mac_info.vlan_id)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Update MAC failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, mac_info.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "PF has already set VF mac, Ignore set operation");=0D
+		return HINIC3_PF_SET_VF_ALREADY;=0D
+	}=0D
+=0D
+	if (mac_info.msg_head.status =3D=3D HINIC3_MGMT_STATUS_EXIST) {=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "MAC is repeated. Ignore update operation");=0D
+		return 0;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_del_mac(void *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id)=
=0D
+{=0D
+	struct hinic3_port_mac_set mac_info;=0D
+	u16 out_size =3D sizeof(mac_info);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !mac_addr)=0D
+		return -EINVAL;=0D
+=0D
+	if (vlan_id >=3D VLAN_N_VID) {=0D
+		PMD_DRV_LOG(ERR, "Invalid VLAN number: %d", vlan_id);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&mac_info, 0, sizeof(mac_info));=0D
+	mac_info.func_id =3D func_id;=0D
+	mac_info.vlan_id =3D vlan_id;=0D
+	memmove(mac_info.mac, mac_addr, ETH_ALEN);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_DEL_MAC, &mac_info,=
=0D
+				     sizeof(mac_info), &mac_info, &out_size);=0D
+	if (err || !out_size ||=0D
+	    (mac_info.msg_head.status &&=0D
+	     !PF_SET_VF_MAC(hwdev, mac_info.msg_head.status))) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Delete MAC failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, mac_info.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {=0D
+		PMD_DRV_LOG(WARNING,=0D
+			"PF has already set VF mac, Ignore delete operation");=0D
+		return HINIC3_PF_SET_VF_ALREADY;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_update_mac(void *hwdev, u8 *old_mac, u8 *new_mac, u16 vlan_id,=0D
+		  u16 func_id)=0D
+{=0D
+	struct hinic3_port_mac_update mac_info;=0D
+	u16 out_size =3D sizeof(mac_info);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !old_mac || !new_mac)=0D
+		return -EINVAL;=0D
+=0D
+	if (vlan_id >=3D VLAN_N_VID) {=0D
+		PMD_DRV_LOG(ERR, "Invalid VLAN number: %d", vlan_id);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&mac_info, 0, sizeof(mac_info));=0D
+	mac_info.func_id =3D func_id;=0D
+	mac_info.vlan_id =3D vlan_id;=0D
+	memcpy(mac_info.old_mac, old_mac, ETH_ALEN);=0D
+	memcpy(mac_info.new_mac, new_mac, ETH_ALEN);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_UPDATE_MAC,=0D
+				     &mac_info, sizeof(mac_info), &mac_info,=0D
+				     &out_size);=0D
+	if (err || !out_size ||=0D
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,=0D
+				  mac_info.vlan_id)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Update MAC failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, mac_info.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (PF_SET_VF_MAC(hwdev, mac_info.msg_head.status)) {=0D
+		PMD_DRV_LOG(WARNING,=0D
+			"PF has already set VF MAC. Ignore update operation");=0D
+		return HINIC3_PF_SET_VF_ALREADY;=0D
+	}=0D
+=0D
+	if (mac_info.msg_head.status =3D=3D HINIC3_MGMT_STATUS_EXIST) {=0D
+		PMD_DRV_LOG(INFO, "MAC is repeated. Ignore update operation");=0D
+		return 0;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_default_mac(void *hwdev, u8 *mac_addr, int ether_len)=0D
+{=0D
+	struct hinic3_port_mac_set mac_info;=0D
+	u16 out_size =3D sizeof(mac_info);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !mac_addr)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&mac_info, 0, sizeof(mac_info));=0D
+	mac_info.func_id =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_GET_MAC, &mac_info,=
=0D
+				     sizeof(mac_info), &mac_info, &out_size);=0D
+	if (err || !out_size || mac_info.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Get MAC failed, err: %d, status: 0x%x, out size: 0x%x",=0D
+			err, mac_info.msg_head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memmove(mac_addr, mac_info.mac, ether_len);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_config_vlan(void *hwdev, u8 opcode, u16 vlan_id, u16 func_id)=0D
+{=0D
+	struct hinic3_cmd_vlan_config vlan_info;=0D
+	u16 out_size =3D sizeof(vlan_info);=0D
+	int err;=0D
+=0D
+	memset(&vlan_info, 0, sizeof(vlan_info));=0D
+	vlan_info.opcode =3D opcode;=0D
+	vlan_info.func_id =3D func_id;=0D
+	vlan_info.vlan_id =3D vlan_id;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_FUNC_VLAN,=0D
+				     &vlan_info, sizeof(vlan_info), &vlan_info,=0D
+				     &out_size);=0D
+	if (err || !out_size || vlan_info.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"%s vlan failed, err: %d, status: 0x%x, out size: 0x%x",=0D
+			opcode =3D=3D HINIC3_CMD_OP_ADD ? "Add" : "Delete", err,=0D
+			vlan_info.msg_head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_add_vlan(void *hwdev, u16 vlan_id, u16 func_id)=0D
+{=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_config_vlan(hwdev, HINIC3_CMD_OP_ADD, vlan_id, func_id);=0D
+}=0D
+=0D
+int=0D
+hinic3_del_vlan(void *hwdev, u16 vlan_id, u16 func_id)=0D
+{=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_config_vlan(hwdev, HINIC3_CMD_OP_DEL, vlan_id, func_id);=0D
+}=0D
+=0D
+int=0D
+hinic3_get_port_info(void *hwdev, struct nic_port_info *port_info)=0D
+{=0D
+	struct hinic3_cmd_port_info port_msg;=0D
+	u16 out_size =3D sizeof(port_msg);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !port_info)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&port_msg, 0, sizeof(port_msg));=0D
+	port_msg.port_id =3D hinic3_physical_port_id(hwdev);=0D
+=0D
+	err =3D mag_msg_to_mgmt_sync(hwdev, MAG_CMD_GET_PORT_INFO, &port_msg,=0D
+				   sizeof(port_msg), &port_msg, &out_size);=0D
+	if (err || !out_size || port_msg.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get port info failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, port_msg.msg_head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	port_info->autoneg_cap =3D port_msg.autoneg_cap;=0D
+	port_info->autoneg_state =3D port_msg.autoneg_state;=0D
+	port_info->duplex =3D port_msg.duplex;=0D
+	port_info->port_type =3D port_msg.port_type;=0D
+	port_info->speed =3D port_msg.speed;=0D
+	port_info->fec =3D port_msg.fec;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_link_state(void *hwdev, u8 *link_state)=0D
+{=0D
+	struct hinic3_cmd_link_state get_link;=0D
+	u16 out_size =3D sizeof(get_link);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !link_state)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&get_link, 0, sizeof(get_link));=0D
+	get_link.port_id =3D hinic3_physical_port_id(hwdev);=0D
+	err =3D mag_msg_to_mgmt_sync(hwdev, MAG_CMD_GET_LINK_STATUS, &get_link,=0D
+				   sizeof(get_link), &get_link, &out_size);=0D
+	if (err || !out_size || get_link.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get link state failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, get_link.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	*link_state =3D get_link.state;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_vport_enable(void *hwdev, bool enable)=0D
+{=0D
+	struct hinic3_vport_state en_state;=0D
+	u16 out_size =3D sizeof(en_state);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&en_state, 0, sizeof(en_state));=0D
+	en_state.func_id =3D hinic3_global_func_id(hwdev);=0D
+	en_state.state =3D enable ? 1 : 0;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_VPORT_ENABLE,=0D
+				     &en_state, sizeof(en_state), &en_state,=0D
+				     &out_size);=0D
+	if (err || !out_size || en_state.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set vport state failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, en_state.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_port_enable(void *hwdev, bool enable)=0D
+{=0D
+	struct mag_cmd_set_port_enable en_state;=0D
+	u16 out_size =3D sizeof(en_state);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF)=0D
+		return 0;=0D
+=0D
+	memset(&en_state, 0, sizeof(en_state));=0D
+	en_state.function_id =3D hinic3_global_func_id(hwdev);=0D
+	en_state.state =3D enable ? MAG_CMD_TX_ENABLE | MAG_CMD_RX_ENABLE=0D
+				: MAG_CMD_PORT_DISABLE;=0D
+=0D
+	err =3D mag_msg_to_mgmt_sync(hwdev, MAG_CMD_SET_PORT_ENABLE, &en_state,=0D
+				   sizeof(en_state), &en_state, &out_size);=0D
+	if (err || !out_size || en_state.head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set port state failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, en_state.head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_flush_qps_res(void *hwdev)=0D
+{=0D
+	struct hinic3_cmd_clear_qp_resource sq_res;=0D
+	u16 out_size =3D sizeof(sq_res);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&sq_res, 0, sizeof(sq_res));=0D
+	sq_res.func_id =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CLEAR_QP_RESOURCE,=0D
+				     &sq_res, sizeof(sq_res), &sq_res,=0D
+				     &out_size);=0D
+	if (err || !out_size || sq_res.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Clear sq resources failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, sq_res.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get or set the flow control (pause frame) settings for NIC.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to the hardware device.=0D
+ * @param[in] opcode=0D
+ * The operation to perform. Use `HINIC3_CMD_OP_SET` to set the pause sett=
ings=0D
+ * and `HINIC3_CMD_OP_GET` to get them.=0D
+ * @param[out] nic_pause=0D
+ * Pointer to the `nic_pause_config` structure. This structure contains th=
e flow=0D
+ * control settings (auto-negotiation, Rx pause, and Tx pause). It is upda=
ted=0D
+ * when getting settings. When setting, the values in this structure are u=
sed.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -EIO if the operation failed.=0D
+ */=0D
+static int=0D
+hinic3_cfg_hw_pause(void *hwdev, u8 opcode, struct nic_pause_config *nic_p=
ause)=0D
+{=0D
+	struct hinic3_cmd_pause_config pause_info =3D {0};=0D
+	u16 out_size =3D sizeof(pause_info);=0D
+	int err =3D 0;=0D
+=0D
+	pause_info.port_id =3D hinic3_physical_port_id(hwdev);=0D
+	pause_info.opcode =3D opcode;=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_SET) {=0D
+		pause_info.auto_neg =3D nic_pause->auto_neg;=0D
+		pause_info.rx_pause =3D nic_pause->rx_pause;=0D
+		pause_info.tx_pause =3D nic_pause->tx_pause;=0D
+	}=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_PAUSE_INFO,=0D
+				     &pause_info, sizeof(pause_info),=0D
+				     &pause_info, &out_size);=0D
+	if (err || !out_size || pause_info.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "%s pause info failed, err: %d, status: 0x%x, out "=0D
+			    "size: 0x%x",=0D
+			    opcode =3D=3D HINIC3_CMD_OP_SET ? "Set" : "Get", err,=0D
+			    pause_info.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_GET) {=0D
+		nic_pause->auto_neg =3D pause_info.auto_neg;=0D
+		nic_pause->rx_pause =3D pause_info.rx_pause;=0D
+		nic_pause->tx_pause =3D pause_info.tx_pause;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_pause_info(void *hwdev, struct nic_pause_config nic_pause)=0D
+{=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_cfg_hw_pause(hwdev, HINIC3_CMD_OP_SET, &nic_pause);=0D
+}=0D
+=0D
+int=0D
+hinic3_get_pause_info(void *hwdev, struct nic_pause_config *nic_pause)=0D
+{=0D
+	if (!hwdev || !nic_pause)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_cfg_hw_pause(hwdev, HINIC3_CMD_OP_GET, nic_pause);=0D
+}=0D
+=0D
+int=0D
+hinic3_get_vport_stats(void *hwdev, struct hinic3_vport_stats *stats)=0D
+{=0D
+	struct hinic3_port_stats_info stats_info;=0D
+	struct hinic3_cmd_vport_stats vport_stats;=0D
+	u16 out_size =3D sizeof(vport_stats);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !stats)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&stats_info, 0, sizeof(stats_info));=0D
+	memset(&vport_stats, 0, sizeof(vport_stats));=0D
+=0D
+	stats_info.func_id =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_GET_VPORT_STAT,=0D
+				     &stats_info, sizeof(stats_info),=0D
+				     &vport_stats, &out_size);=0D
+	if (err || !out_size || vport_stats.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get function stats failed, err: %d, status: 0x%x, "=0D
+			    "out size: 0x%x",=0D
+			    err, vport_stats.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	memcpy(stats, &vport_stats.stats, sizeof(*stats));=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_phy_port_stats(void *hwdev, struct mag_phy_port_stats *stats)=0D
+{=0D
+	struct mag_cmd_get_port_stat *port_stats =3D NULL;=0D
+	struct mag_cmd_port_stats_info stats_info;=0D
+	u16 out_size =3D sizeof(*port_stats);=0D
+	int err;=0D
+=0D
+	port_stats =3D rte_zmalloc("port_stats", sizeof(*port_stats), 0);=0D
+	if (!port_stats)=0D
+		return -ENOMEM;=0D
+=0D
+	memset(&stats_info, 0, sizeof(stats_info));=0D
+	stats_info.port_id =3D hinic3_physical_port_id(hwdev);=0D
+=0D
+	err =3D mag_msg_to_mgmt_sync(hwdev, MAG_CMD_GET_PORT_STAT, &stats_info,=0D
+				   sizeof(stats_info), port_stats, &out_size);=0D
+	if (err || !out_size || port_stats->head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to get port statistics, err: %d, status: "=0D
+			    "0x%x, out size: 0x%x",=0D
+			    err, port_stats->head.status, out_size);=0D
+		err =3D -EIO;=0D
+		goto out;=0D
+	}=0D
+=0D
+	memcpy(stats, &port_stats->counter, sizeof(*stats));=0D
+=0D
+out:=0D
+	rte_free(port_stats);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_clear_vport_stats(void *hwdev)=0D
+{=0D
+	struct hinic3_cmd_clear_vport_stats clear_vport_stats;=0D
+	u16 out_size =3D sizeof(clear_vport_stats);=0D
+	int err;=0D
+=0D
+	if (!hwdev) {=0D
+		PMD_DRV_LOG(ERR, "Hwdev is NULL");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&clear_vport_stats, 0, sizeof(clear_vport_stats));=0D
+	clear_vport_stats.func_id =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_NIC_CMD_CLEAN_VPORT_STAT, &clear_vport_stats,=0D
+		sizeof(clear_vport_stats), &clear_vport_stats, &out_size);=0D
+	if (err || !out_size || clear_vport_stats.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Clear vport stats failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, clear_vport_stats.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_clear_phy_port_stats(void *hwdev)=0D
+{=0D
+	struct mag_cmd_port_stats_info port_stats;=0D
+	u16 out_size =3D sizeof(port_stats);=0D
+	int err;=0D
+=0D
+	port_stats.port_id =3D hinic3_physical_port_id(hwdev);=0D
+=0D
+	err =3D mag_msg_to_mgmt_sync(hwdev, MAG_CMD_CLR_PORT_STAT, &port_stats,=0D
+				   sizeof(port_stats), &port_stats, &out_size);=0D
+	if (err || !out_size || port_stats.head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to get port statistics, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, port_stats.head.status, out_size);=0D
+		err =3D -EIO;=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_function_table(void *hwdev, u32 cfg_bitmap,=0D
+			  struct hinic3_func_tbl_cfg *cfg)=0D
+{=0D
+	struct hinic3_cmd_set_func_tbl cmd_func_tbl;=0D
+	u16 out_size =3D sizeof(cmd_func_tbl);=0D
+	int err;=0D
+=0D
+	memset(&cmd_func_tbl, 0, sizeof(cmd_func_tbl));=0D
+	cmd_func_tbl.func_id =3D hinic3_global_func_id(hwdev);=0D
+	cmd_func_tbl.cfg_bitmap =3D cfg_bitmap;=0D
+	cmd_func_tbl.tbl_cfg =3D *cfg;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_FUNC_TBL,=0D
+				     &cmd_func_tbl, sizeof(cmd_func_tbl),=0D
+				     &cmd_func_tbl, &out_size);=0D
+	if (err || cmd_func_tbl.msg_head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set func table failed, bitmap: 0x%x, err: %d, "=0D
+			    "status: 0x%x, out size: 0x%x",=0D
+			    cfg_bitmap, err, cmd_func_tbl.msg_head.status,=0D
+			    out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_init_function_table(void *hwdev, u16 rx_buff_len)=0D
+{=0D
+	struct hinic3_func_tbl_cfg func_tbl_cfg;=0D
+	u32 cfg_bitmap =3D BIT(FUNC_CFG_INIT) | BIT(FUNC_CFG_MTU) |=0D
+			 BIT(FUNC_CFG_RX_BUF_SIZE);=0D
+=0D
+	memset(&func_tbl_cfg, 0, sizeof(func_tbl_cfg));=0D
+	func_tbl_cfg.mtu =3D 0x3FFF; /**< Default, max mtu */=0D
+	func_tbl_cfg.rx_wqe_buf_size =3D rx_buff_len;=0D
+=0D
+	return hinic3_set_function_table(hwdev, cfg_bitmap, &func_tbl_cfg);=0D
+}=0D
+=0D
+int=0D
+hinic3_set_port_mtu(void *hwdev, u16 new_mtu)=0D
+{=0D
+	struct hinic3_func_tbl_cfg func_tbl_cfg;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	if (new_mtu < HINIC3_MIN_MTU_SIZE) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Invalid mtu size: %ubytes, mtu size < %ubytes",=0D
+			    new_mtu, HINIC3_MIN_MTU_SIZE);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Invalid mtu size: %ubytes, mtu size > %ubytes",=0D
+			    new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&func_tbl_cfg, 0, sizeof(func_tbl_cfg));=0D
+	func_tbl_cfg.mtu =3D new_mtu;=0D
+	return hinic3_set_function_table(hwdev, BIT(FUNC_CFG_MTU),=0D
+					 &func_tbl_cfg);=0D
+}=0D
+=0D
+static int=0D
+nic_feature_nego(void *hwdev, u8 opcode, u64 *s_feature, u16 size)=0D
+{=0D
+	struct hinic3_cmd_feature_nego feature_nego;=0D
+	u16 out_size =3D sizeof(feature_nego);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !s_feature || size > MAX_FEATURE_QWORD)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&feature_nego, 0, sizeof(feature_nego));=0D
+	feature_nego.func_id =3D hinic3_global_func_id(hwdev);=0D
+	feature_nego.opcode =3D opcode;=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_SET)=0D
+		memcpy(feature_nego.s_feature, s_feature, size * sizeof(u64));=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_FEATURE_NEGO,=0D
+				     &feature_nego, sizeof(feature_nego),=0D
+				     &feature_nego, &out_size);=0D
+	if (err || !out_size || feature_nego.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to negotiate nic feature, err:%d, status: "=0D
+			    "0x%x, out_size: 0x%x",=0D
+			    err, feature_nego.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_GET)=0D
+		memcpy(s_feature, feature_nego.s_feature, size * sizeof(u64));=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_feature_from_hw(void *hwdev, u64 *s_feature, u16 size)=0D
+{=0D
+	return nic_feature_nego(hwdev, HINIC3_CMD_OP_GET, s_feature, size);=0D
+}=0D
+=0D
+int=0D
+hinic3_set_feature_to_hw(void *hwdev, u64 *s_feature, u16 size)=0D
+{=0D
+	return nic_feature_nego(hwdev, HINIC3_CMD_OP_SET, s_feature, size);=0D
+}=0D
+=0D
+static int=0D
+hinic3_vf_func_init(void *hwdev)=0D
+{=0D
+	struct hinic3_cmd_register_vf register_info;=0D
+	u16 out_size =3D sizeof(register_info);=0D
+	int err;=0D
+=0D
+	if (hinic3_func_type(hwdev) !=3D TYPE_VF)=0D
+		return 0;=0D
+=0D
+	memset(&register_info, 0, sizeof(register_info));=0D
+	register_info.op_register =3D 1;=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_VF_REGISTER,=0D
+				     &register_info, sizeof(register_info),=0D
+				     &register_info, &out_size);=0D
+	if (err || register_info.msg_head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Register VF failed, err: %d, status: 0x%x, out "=0D
+			    "size: 0x%x",=0D
+			    err, register_info.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_vf_func_free(void *hwdev)=0D
+{=0D
+	struct hinic3_cmd_register_vf unregister;=0D
+	u16 out_size =3D sizeof(unregister);=0D
+	int err;=0D
+=0D
+	if (hinic3_func_type(hwdev) !=3D TYPE_VF)=0D
+		return 0;=0D
+=0D
+	memset(&unregister, 0, sizeof(unregister));=0D
+	unregister.op_register =3D 0;=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_VF_REGISTER,=0D
+				     &unregister, sizeof(unregister),=0D
+				     &unregister, &out_size);=0D
+	if (err || unregister.msg_head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Unregister VF failed, err: %d, status: 0x%x, out "=0D
+			    "size: 0x%x",=0D
+			    err, unregister.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_init_nic_hwdev(void *hwdev)=0D
+{=0D
+	return hinic3_vf_func_init(hwdev);=0D
+}=0D
+=0D
+void=0D
+hinic3_free_nic_hwdev(void *hwdev)=0D
+{=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	if (hinic3_func_type(hwdev) !=3D TYPE_VF)=0D
+		hinic3_set_link_status_follow(hwdev, HINIC3_LINK_FOLLOW_DEFAULT);=0D
+=0D
+	hinic3_vf_func_free(hwdev);=0D
+}=0D
+=0D
+int=0D
+hinic3_set_rx_mode(void *hwdev, u32 enable)=0D
+{=0D
+	struct hinic3_rx_mode_config rx_mode_cfg;=0D
+	u16 out_size =3D sizeof(rx_mode_cfg);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&rx_mode_cfg, 0, sizeof(rx_mode_cfg));=0D
+	rx_mode_cfg.func_id =3D hinic3_global_func_id(hwdev);=0D
+	rx_mode_cfg.rx_mode =3D enable;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RX_MODE,=0D
+				     &rx_mode_cfg, sizeof(rx_mode_cfg),=0D
+				     &rx_mode_cfg, &out_size);=0D
+	if (err || !out_size || rx_mode_cfg.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set rx mode failed, err: %d, status: 0x%x, out "=0D
+			    "size: 0x%x",=0D
+			    err, rx_mode_cfg.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_rx_vlan_offload(void *hwdev, u8 en)=0D
+{=0D
+	struct hinic3_cmd_vlan_offload vlan_cfg;=0D
+	u16 out_size =3D sizeof(vlan_cfg);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&vlan_cfg, 0, sizeof(vlan_cfg));=0D
+	vlan_cfg.func_id =3D hinic3_global_func_id(hwdev);=0D
+	vlan_cfg.vlan_offload =3D en;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD,=
=0D
+				     &vlan_cfg, sizeof(vlan_cfg), &vlan_cfg,=0D
+				     &out_size);=0D
+	if (err || !out_size || vlan_cfg.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set rx vlan offload failed, err: %d, status: "=0D
+			    "0x%x, out size: 0x%x",=0D
+			    err, vlan_cfg.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_vlan_filter(void *hwdev, u32 vlan_filter_ctrl)=0D
+{=0D
+	struct hinic3_cmd_set_vlan_filter vlan_filter;=0D
+	u16 out_size =3D sizeof(vlan_filter);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&vlan_filter, 0, sizeof(vlan_filter));=0D
+	vlan_filter.func_id =3D hinic3_global_func_id(hwdev);=0D
+	vlan_filter.vlan_filter_ctrl =3D vlan_filter_ctrl;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_VLAN_FILTER_EN,=
=0D
+				     &vlan_filter, sizeof(vlan_filter),=0D
+				     &vlan_filter, &out_size);=0D
+	if (err || !out_size || vlan_filter.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to set vlan filter, err: %d, status: 0x%x, "=0D
+			    "out size: 0x%x",=0D
+			    err, vlan_filter.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_rx_lro(void *hwdev, u8 ipv4_en, u8 ipv6_en, u8 lro_max_pkt_len)=
=0D
+{=0D
+	struct hinic3_cmd_lro_config lro_cfg =3D {0};=0D
+	u16 out_size =3D sizeof(lro_cfg);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	lro_cfg.func_id =3D hinic3_global_func_id(hwdev);=0D
+	lro_cfg.opcode =3D HINIC3_CMD_OP_SET;=0D
+	lro_cfg.lro_ipv4_en =3D ipv4_en;=0D
+	lro_cfg.lro_ipv6_en =3D ipv6_en;=0D
+	lro_cfg.lro_max_pkt_len =3D lro_max_pkt_len;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_RX_LRO, &lro_cfg=
,=0D
+				     sizeof(lro_cfg), &lro_cfg, &out_size);=0D
+	if (err || !out_size || lro_cfg.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set lro offload failed, err: %d, status: 0x%x, "=0D
+			    "out size: 0x%x",=0D
+			    err, lro_cfg.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_rx_lro_timer(void *hwdev, u32 timer_value)=0D
+{=0D
+	struct hinic3_cmd_lro_timer lro_timer;=0D
+	u16 out_size =3D sizeof(lro_timer);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&lro_timer, 0, sizeof(lro_timer));=0D
+	lro_timer.opcode =3D HINIC3_CMD_OP_SET;=0D
+	lro_timer.timer =3D timer_value;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_LRO_TIMER,=0D
+				     &lro_timer, sizeof(lro_timer), &lro_timer,=0D
+				     &out_size);=0D
+	if (err || !out_size || lro_timer.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set lro timer failed, err: %d, status: 0x%x, out "=0D
+			    "size: 0x%x",=0D
+			    err, lro_timer.msg_head.status, out_size);=0D
+=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_rx_lro_state(void *hwdev, u8 lro_en, u32 lro_timer,=0D
+			u32 lro_max_pkt_len)=0D
+{=0D
+	u8 ipv4_en =3D 0, ipv6_en =3D 0;=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	ipv4_en =3D lro_en ? 1 : 0;=0D
+	ipv6_en =3D lro_en ? 1 : 0;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Set LRO max coalesce packet size to %uK",=0D
+		    lro_max_pkt_len);=0D
+=0D
+	err =3D hinic3_set_rx_lro(hwdev, ipv4_en, ipv6_en, (u8)lro_max_pkt_len);=
=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	/* We don't set LRO timer for VF */=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF)=0D
+		return 0;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Set LRO timer to %u", lro_timer);=0D
+=0D
+	return hinic3_set_rx_lro_timer(hwdev, lro_timer);=0D
+}=0D
+=0D
+/* RSS config */=0D
+int=0D
+hinic3_rss_template_alloc(void *hwdev)=0D
+{=0D
+	struct hinic3_rss_template_mgmt template_mgmt;=0D
+	u16 out_size =3D sizeof(template_mgmt);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&template_mgmt, 0, sizeof(struct hinic3_rss_template_mgmt));=0D
+	template_mgmt.func_id =3D hinic3_global_func_id(hwdev);=0D
+	template_mgmt.cmd =3D NIC_RSS_CMD_TEMP_ALLOC;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_RSS_TEMP_MGR,=0D
+				     &template_mgmt, sizeof(template_mgmt),=0D
+				     &template_mgmt, &out_size);=0D
+	if (err || !out_size || template_mgmt.msg_head.status) {=0D
+		if (template_mgmt.msg_head.status =3D=3D=0D
+		    HINIC3_MGMT_STATUS_TABLE_FULL) {=0D
+			PMD_DRV_LOG(ERR, "There is no more template available");=0D
+			return -ENOSPC;=0D
+		}=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Alloc rss template failed, err: %d, "=0D
+			    "status: 0x%x, out size: 0x%x",=0D
+			    err, template_mgmt.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_template_free(void *hwdev)=0D
+{=0D
+	struct hinic3_rss_template_mgmt template_mgmt;=0D
+	u16 out_size =3D sizeof(template_mgmt);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&template_mgmt, 0, sizeof(struct hinic3_rss_template_mgmt));=0D
+	template_mgmt.func_id =3D hinic3_global_func_id(hwdev);=0D
+	template_mgmt.cmd =3D NIC_RSS_CMD_TEMP_FREE;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_RSS_TEMP_MGR,=0D
+				     &template_mgmt, sizeof(template_mgmt),=0D
+				     &template_mgmt, &out_size);=0D
+	if (err || !out_size || template_mgmt.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Free rss template failed, err: %d, "=0D
+			    "status: 0x%x, out size: 0x%x",=0D
+			    err, template_mgmt.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_rss_cfg_hash_key(void *hwdev, u8 opcode, u8 *key, u16 key_size)=0D
+{=0D
+	struct hinic3_cmd_rss_hash_key hash_key;=0D
+	u16 out_size =3D sizeof(hash_key);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !key)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&hash_key, 0, sizeof(struct hinic3_cmd_rss_hash_key));=0D
+	hash_key.func_id =3D hinic3_global_func_id(hwdev);=0D
+	hash_key.opcode =3D opcode;=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_SET)=0D
+		memcpy(hash_key.key, key, key_size);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_RSS_HASH_KEY,=0D
+				     &hash_key, sizeof(hash_key), &hash_key,=0D
+				     &out_size);=0D
+	if (err || !out_size || hash_key.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "%s hash key failed, err: %d, "=0D
+			    "status: 0x%x, out size: 0x%x",=0D
+			    opcode =3D=3D HINIC3_CMD_OP_SET ? "Set" : "Get", err,=0D
+			    hash_key.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_GET)=0D
+		memcpy(key, hash_key.key, key_size);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_set_hash_key(void *hwdev, u8 *key, u16 key_size)=0D
+{=0D
+	if (!hwdev || !key)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_rss_cfg_hash_key(hwdev, HINIC3_CMD_OP_SET, key, key_size);=
=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_get_indir_tbl(void *hwdev, u32 *indir_table, u32 indir_table_si=
ze)=0D
+{=0D
+	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
+	u16 *indir_tbl =3D NULL;=0D
+	int err;=0D
+	u32 i;=0D
+=0D
+	if (!hwdev || !indir_table)=0D
+		return -EINVAL;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buf failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	cmd_buf->size =3D sizeof(struct nic_rss_indirect_tbl);=0D
+	err =3D hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,=0D
+				      cmd_buf, cmd_buf, 0);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get rss indir table failed");=0D
+		hinic3_free_cmd_buf(cmd_buf);=0D
+		return err;=0D
+	}=0D
+=0D
+	indir_tbl =3D (u16 *)cmd_buf->buf;=0D
+	for (i =3D 0; i < indir_table_size; i++)=0D
+		indir_table[i] =3D *(indir_tbl + i);=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_set_indir_tbl(void *hwdev, const u32 *indir_table,=0D
+			 u32 indir_table_size)=0D
+{=0D
+	struct nic_rss_indirect_tbl *indir_tbl =3D NULL;=0D
+	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
+	u32 i, size;=0D
+	u32 *temp =3D NULL;=0D
+	u64 out_param =3D 0;=0D
+	int err;=0D
+=0D
+	if (!hwdev || !indir_table)=0D
+		return -EINVAL;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buf failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	cmd_buf->size =3D sizeof(struct nic_rss_indirect_tbl);=0D
+	indir_tbl =3D (struct nic_rss_indirect_tbl *)cmd_buf->buf;=0D
+	memset(indir_tbl, 0, sizeof(*indir_tbl));=0D
+=0D
+	for (i =3D 0; i < indir_table_size; i++)=0D
+		indir_tbl->entry[i] =3D (u16)(*(indir_table + i));=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	size =3D sizeof(indir_tbl->entry) / sizeof(u16);=0D
+	temp =3D (u32 *)indir_tbl->entry;=0D
+	for (i =3D 0; i < size; i++)=0D
+		temp[i] =3D cpu_to_be32(temp[i]);=0D
+=0D
+	err =3D hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,=0D
+				      cmd_buf, &out_param, 0);=0D
+	if (err || out_param !=3D 0) {=0D
+		PMD_DRV_LOG(ERR, "Set rss indir table failed");=0D
+		err =3D -EFAULT;=0D
+	}=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_cmdq_set_rss_type(void *hwdev, struct hinic3_rss_type rss_type)=0D
+{=0D
+	struct nic_rss_context_tbl *ctx_tbl =3D NULL;=0D
+	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
+	u32 ctx =3D 0;=0D
+	u64 out_param =3D 0;=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buf failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	ctx |=3D HINIC3_RSS_TYPE_SET(1, VALID) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv4, IPV4) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6, IPV6) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);=0D
+=0D
+	cmd_buf->size =3D sizeof(struct nic_rss_context_tbl);=0D
+	ctx_tbl =3D (struct nic_rss_context_tbl *)cmd_buf->buf;=0D
+	memset(ctx_tbl, 0, sizeof(*ctx_tbl));=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	ctx_tbl->ctx =3D cpu_to_be32(ctx);=0D
+=0D
+	/* Cfg the RSS context table by command queue. */=0D
+	err =3D hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE,=0D
+				      cmd_buf, &out_param, 0);=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+=0D
+	if (err || out_param !=3D 0) {=0D
+		PMD_DRV_LOG(ERR, "Cmdq set rss context table failed, err: %d",=0D
+			    err);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_mgmt_set_rss_type(void *hwdev, struct hinic3_rss_type rss_type)=0D
+{=0D
+	struct hinic3_rss_context_table ctx_tbl;=0D
+	u32 ctx =3D 0;=0D
+	u16 out_size =3D sizeof(ctx_tbl);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&ctx_tbl, 0, sizeof(ctx_tbl));=0D
+	ctx_tbl.func_id =3D hinic3_global_func_id(hwdev);=0D
+	ctx |=3D HINIC3_RSS_TYPE_SET(1, VALID) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv4, IPV4) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6, IPV6) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |=0D
+	       HINIC3_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);=0D
+	ctx_tbl.context =3D ctx;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC, &ctx_tbl,=0D
+		sizeof(ctx_tbl), &ctx_tbl, &out_size);=0D
+	if (ctx_tbl.msg_head.status =3D=3D HINIC3_MGMT_CMD_UNSUPPORTED) {=0D
+		return HINIC3_MGMT_CMD_UNSUPPORTED;=0D
+	} else if (err || !out_size || ctx_tbl.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Mgmt set rss context table failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, ctx_tbl.msg_head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_rss_type(void *hwdev, struct hinic3_rss_type rss_type)=0D
+{=0D
+	int err;=0D
+	err =3D hinic3_mgmt_set_rss_type(hwdev, rss_type);=0D
+	if (err =3D=3D HINIC3_MGMT_CMD_UNSUPPORTED)=0D
+		err =3D hinic3_cmdq_set_rss_type(hwdev, rss_type);=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_rss_type(void *hwdev, struct hinic3_rss_type *rss_type)=0D
+{=0D
+	struct hinic3_rss_context_table ctx_tbl;=0D
+	u16 out_size =3D sizeof(ctx_tbl);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !rss_type)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&ctx_tbl, 0, sizeof(struct hinic3_rss_context_table));=0D
+	ctx_tbl.func_id =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_GET_RSS_CTX_TBL,=0D
+				     &ctx_tbl, sizeof(ctx_tbl), &ctx_tbl,=0D
+				     &out_size);=0D
+	if (err || !out_size || ctx_tbl.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get hash type failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, ctx_tbl.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	rss_type->ipv4 =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV4);=0D
+	rss_type->ipv6 =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV6);=0D
+	rss_type->ipv6_ext =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, IPV6_EXT);=0D
+	rss_type->tcp_ipv4 =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV4);=0D
+	rss_type->tcp_ipv6 =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6);=0D
+	rss_type->tcp_ipv6_ext =3D=0D
+		HINIC3_RSS_TYPE_GET(ctx_tbl.context, TCP_IPV6_EXT);=0D
+	rss_type->udp_ipv4 =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV4);=0D
+	rss_type->udp_ipv6 =3D HINIC3_RSS_TYPE_GET(ctx_tbl.context, UDP_IPV6);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_rss_cfg_hash_engine(void *hwdev, u8 opcode, u8 *type)=0D
+{=0D
+	struct hinic3_cmd_rss_engine_type hash_type;=0D
+	u16 out_size =3D sizeof(hash_type);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !type)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&hash_type, 0, sizeof(struct hinic3_cmd_rss_engine_type));=0D
+	hash_type.func_id =3D hinic3_global_func_id(hwdev);=0D
+	hash_type.opcode =3D opcode;=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_SET)=0D
+		hash_type.hash_engine =3D *type;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE,=
=0D
+				     &hash_type, sizeof(hash_type), &hash_type,=0D
+				     &out_size);=0D
+	if (err || !out_size || hash_type.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "%s hash engine failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    opcode =3D=3D HINIC3_CMD_OP_SET ? "Set" : "Get", err,=0D
+			    hash_type.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D HINIC3_CMD_OP_GET)=0D
+		*type =3D hash_type.hash_engine;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_get_hash_engine(void *hwdev, u8 *type)=0D
+{=0D
+	if (!hwdev || !type)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_rss_cfg_hash_engine(hwdev, HINIC3_CMD_OP_GET, type);=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_set_hash_engine(void *hwdev, u8 type)=0D
+{=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_rss_cfg_hash_engine(hwdev, HINIC3_CMD_OP_SET, &type);=0D
+}=0D
+=0D
+int=0D
+hinic3_rss_cfg(void *hwdev, u8 rss_en, u8 tc_num, u8 *prio_tc)=0D
+{=0D
+	struct hinic3_cmd_rss_config rss_cfg;=0D
+	u16 out_size =3D sizeof(rss_cfg);=0D
+	int err;=0D
+=0D
+	/* Ucode requires number of TC should be power of 2. */=0D
+	if (!hwdev || !prio_tc || (tc_num & (tc_num - 1)))=0D
+		return -EINVAL;=0D
+=0D
+	memset(&rss_cfg, 0, sizeof(struct hinic3_cmd_rss_config));=0D
+	rss_cfg.func_id =3D hinic3_global_func_id(hwdev);=0D
+	rss_cfg.rss_en =3D rss_en;=0D
+	rss_cfg.rq_priority_number =3D tc_num ? (u8)ilog2(tc_num) : 0;=0D
+=0D
+	memcpy(rss_cfg.prio_tc, prio_tc, HINIC3_DCB_UP_MAX);=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_RSS_CFG, &rss_cfg,=0D
+				     sizeof(rss_cfg), &rss_cfg, &out_size);=0D
+	if (err || !out_size || rss_cfg.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set rss cfg failed, err: %d, "=0D
+			    "status: 0x%x, out size: 0x%x",=0D
+			    err, rss_cfg.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_vf_get_default_cos(void *hwdev, u8 *cos_id)=0D
+{=0D
+	struct hinic3_cmd_vf_dcb_state vf_dcb;=0D
+	u16 out_size =3D sizeof(vf_dcb);=0D
+	int err;=0D
+=0D
+	memset(&vf_dcb, 0, sizeof(vf_dcb));=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_VF_COS, &vf_dcb,=0D
+				     sizeof(vf_dcb), &vf_dcb, &out_size);=0D
+	if (err || !out_size || vf_dcb.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get VF default cos failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, vf_dcb.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	*cos_id =3D vf_dcb.state.default_cos;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Set the Ethernet type filtering rule for the FDIR of a NIC.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] pkt_type=0D
+ * Indicate the packet type.=0D
+ * @param[in] queue_id=0D
+ * Indicate the queue id.=0D
+ * @param[in] en=0D
+ * Indicate whether to add or delete an operation. 1 - add; 0 - delete.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_set_fdir_ethertype_filter(void *hwdev, u8 pkt_type, u16 queue_id, u=
8 en)=0D
+{=0D
+	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;=0D
+	u16 out_size =3D sizeof(ethertype_cmd);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&ethertype_cmd, 0,=0D
+	       sizeof(struct hinic3_set_fdir_ethertype_rule));=0D
+	ethertype_cmd.func_id =3D hinic3_global_func_id(hwdev);=0D
+	ethertype_cmd.pkt_type =3D pkt_type;=0D
+	ethertype_cmd.pkt_type_en =3D en;=0D
+	ethertype_cmd.qid =3D (u8)queue_id;=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_FDIR_STATUS,=0D
+				     &ethertype_cmd, sizeof(ethertype_cmd),=0D
+				     &ethertype_cmd, &out_size);=0D
+	if (err || ethertype_cmd.head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "set fdir ethertype rule failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x, func_id %d",=0D
+			    err, ethertype_cmd.head.status, out_size,=0D
+			    ethertype_cmd.func_id);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_add_tcam_rule(void *hwdev, struct hinic3_tcam_cfg_rule *tcam_rule,=
=0D
+		     u8 tcam_rule_type)=0D
+{=0D
+	struct hinic3_fdir_add_rule tcam_cmd;=0D
+	u16 out_size =3D sizeof(tcam_cmd);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !tcam_rule)=0D
+		return -EINVAL;=0D
+	/* Check whether the index is out of range. */=0D
+	if (tcam_rule->index >=3D HINIC3_MAX_TCAM_RULES_NUM) {=0D
+		PMD_DRV_LOG(ERR, "Tcam rules num to add is invalid");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&tcam_cmd, 0, sizeof(struct hinic3_fdir_add_rule));=0D
+	tcam_cmd.func_id =3D hinic3_global_func_id(hwdev);=0D
+	memcpy((void *)&tcam_cmd.rule, (void *)tcam_rule,=0D
+	       sizeof(struct hinic3_tcam_cfg_rule));=0D
+	tcam_cmd.type =3D tcam_rule_type;=0D
+=0D
+	/* Synchronize the information to the management module. */=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_ADD_TC_FLOW,=0D
+				     &tcam_cmd, sizeof(tcam_cmd), &tcam_cmd,=0D
+				     &out_size);=0D
+	if (err || tcam_cmd.msg_head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Add tcam rule failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, tcam_cmd.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_del_tcam_rule(void *hwdev, u32 index, u8 tcam_rule_type)=0D
+{=0D
+	struct hinic3_fdir_del_rule tcam_cmd;=0D
+	u16 out_size =3D sizeof(tcam_cmd);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+	/* Check whether the index is out of range. */=0D
+	if (index >=3D HINIC3_MAX_TCAM_RULES_NUM) {=0D
+		PMD_DRV_LOG(ERR, "Tcam rules num to del is invalid");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&tcam_cmd, 0, sizeof(struct hinic3_fdir_del_rule));=0D
+	tcam_cmd.func_id =3D hinic3_global_func_id(hwdev);=0D
+	tcam_cmd.index_start =3D index;=0D
+	tcam_cmd.index_num =3D 1;=0D
+	tcam_cmd.type =3D tcam_rule_type;=0D
+=0D
+	/* Synchronize the information to the management module. */=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_DEL_TC_FLOW,=0D
+				     &tcam_cmd, sizeof(tcam_cmd), &tcam_cmd,=0D
+				     &out_size);=0D
+	if (err || tcam_cmd.msg_head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Del tcam rule failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, tcam_cmd.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_cfg_tcam_block(void *hwdev, u8 alloc_en, u16 *index)=0D
+{=0D
+	struct hinic3_tcam_block tcam_block_info;=0D
+	u16 out_size =3D sizeof(tcam_block_info);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+	/* Initialization TCAM block structure. */=0D
+	memset(&tcam_block_info, 0, sizeof(struct hinic3_tcam_block));=0D
+	tcam_block_info.func_id =3D hinic3_global_func_id(hwdev);=0D
+	tcam_block_info.alloc_en =3D alloc_en;=0D
+	tcam_block_info.tcam_type =3D HINIC3_TCAM_BLOCK_NORMAL_TYPE;=0D
+	tcam_block_info.tcam_block_index =3D *index;=0D
+=0D
+	/* Synchronize the information to the management module. */=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CFG_TCAM_BLOCK,=0D
+				     &tcam_block_info, sizeof(tcam_block_info),=0D
+				     &tcam_block_info, &out_size);=0D
+	if (err || !out_size || tcam_block_info.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set tcam block failed, err: %d, status: 0x%x, out "=0D
+			    "size: 0x%x",=0D
+			    err, tcam_block_info.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	/* Update TCAM block of index. */=0D
+	if (alloc_en)=0D
+		*index =3D tcam_block_info.tcam_block_index;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_alloc_tcam_block(void *hwdev, u16 *index)=0D
+{=0D
+	return hinic3_cfg_tcam_block(hwdev, HINIC3_TCAM_BLOCK_ENABLE, index);=0D
+}=0D
+=0D
+int=0D
+hinic3_free_tcam_block(void *hwdev, u16 *index)=0D
+{=0D
+	return hinic3_cfg_tcam_block(hwdev, HINIC3_TCAM_BLOCK_DISABLE, index);=0D
+}=0D
+=0D
+int=0D
+hinic3_flush_tcam_rule(void *hwdev)=0D
+{=0D
+	struct hinic3_flush_tcam_rules tcam_flush;=0D
+	u16 out_size =3D sizeof(tcam_flush);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&tcam_flush, 0, sizeof(struct hinic3_flush_tcam_rules));=0D
+	tcam_flush.func_id =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_NIC_CMD_FLUSH_TCAM, &tcam_flush,=0D
+		sizeof(struct hinic3_flush_tcam_rules), &tcam_flush, &out_size);=0D
+	if (tcam_flush.msg_head.status =3D=3D HINIC3_MGMT_CMD_UNSUPPORTED) {=0D
+		err =3D HINIC3_MGMT_CMD_UNSUPPORTED;=0D
+		PMD_DRV_LOG(INFO,=0D
+			    "Firmware/uP doesn't support flush tcam fdir");=0D
+	} else if (err || (!out_size) || tcam_flush.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Flush tcam fdir rules failed, err: %d, status: "=0D
+			    "0x%x, out size: 0x%x",=0D
+			    err, tcam_flush.msg_head.status, out_size);=0D
+		err =3D -EIO;=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_fdir_tcam_rule_filter(void *hwdev, bool enable)=0D
+{=0D
+	struct hinic3_port_tcam_info port_tcam_cmd;=0D
+	u16 out_size =3D sizeof(port_tcam_cmd);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+	/* Initialization information. */=0D
+	memset(&port_tcam_cmd, 0, sizeof(port_tcam_cmd));=0D
+	port_tcam_cmd.func_id =3D hinic3_global_func_id(hwdev);=0D
+	port_tcam_cmd.tcam_enable =3D (u8)enable;=0D
+=0D
+	/* Synchronize the information to the management module. */=0D
+	err =3D l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_ENABLE_TCAM,=0D
+				     &port_tcam_cmd, sizeof(port_tcam_cmd),=0D
+				     &port_tcam_cmd, &out_size);=0D
+	if ((port_tcam_cmd.msg_head.status !=3D HINIC3_MGMT_CMD_UNSUPPORTED &&=0D
+	     port_tcam_cmd.msg_head.status) ||=0D
+	    err || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set fdir tcam filter failed, err: %d, "=0D
+			    "status: 0x%x, out size: 0x%x, enable: 0x%x",=0D
+			    err, port_tcam_cmd.msg_head.status, out_size,=0D
+			    enable);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (port_tcam_cmd.msg_head.status =3D=3D HINIC3_MGMT_CMD_UNSUPPORTED) {=0D
+		err =3D HINIC3_MGMT_CMD_UNSUPPORTED;=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "Fw doesn't support setting fdir tcam filter");=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_rq_flush(void *hwdev, u16 q_id)=0D
+{=0D
+	struct hinic3_cmd_set_rq_flush *rq_flush_msg =3D NULL;=0D
+	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
+	u64 out_param =3D EIO;=0D
+	int err;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate cmd buf");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	cmd_buf->size =3D sizeof(*rq_flush_msg);=0D
+=0D
+	rq_flush_msg =3D cmd_buf->buf;=0D
+	rq_flush_msg->local_rq_id =3D q_id;=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	rq_flush_msg->value =3D cpu_to_be32(rq_flush_msg->value);=0D
+=0D
+	err =3D hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_UCODE_CMD_SET_RQ_FLUSH, cmd_buf,=0D
+				      &out_param, 0);=0D
+	if (err || out_param !=3D 0) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Failed to set rq flush, err:%d, out_param:0x%" PRIx64,=0D
+			err, out_param);=0D
+		err =3D -EFAULT;=0D
+	}=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+_mag_msg_to_mgmt_sync(void *hwdev, u16 cmd, void *buf_in, u16 in_size,=0D
+		      void *buf_out, u16 *out_size)=0D
+{=0D
+	u32 i, cmd_cnt =3D ARRAY_LEN(vf_mag_cmd_handler);=0D
+=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF) {=0D
+		for (i =3D 0; i < cmd_cnt; i++) {=0D
+			if (cmd =3D=3D vf_mag_cmd_handler[i].cmd)=0D
+				return hinic3_mbox_to_pf(hwdev,=0D
+					HINIC3_MOD_HILINK, cmd, buf_in,=0D
+					in_size, buf_out, out_size, 0);=0D
+		}=0D
+	}=0D
+=0D
+	return hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK, cmd, buf_in,=0D
+				       in_size, buf_out, out_size, 0);=0D
+}=0D
+=0D
+static int=0D
+mag_msg_to_mgmt_sync(void *hwdev, u16 cmd, void *buf_in, u16 in_size,=0D
+		     void *buf_out, u16 *out_size)=0D
+{=0D
+	return _mag_msg_to_mgmt_sync(hwdev, cmd, buf_in, in_size, buf_out,=0D
+				     out_size);=0D
+}=0D
+=0D
+int=0D
+hinic3_set_link_status_follow(void *hwdev,=0D
+			      enum hinic3_link_follow_status status)=0D
+{=0D
+	struct mag_cmd_set_link_follow follow;=0D
+	u16 out_size =3D sizeof(follow);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	if (status >=3D HINIC3_LINK_FOLLOW_STATUS_MAX) {=0D
+		PMD_DRV_LOG(ERR, "Invalid link follow status: %d", status);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	memset(&follow, 0, sizeof(follow));=0D
+	follow.function_id =3D hinic3_global_func_id(hwdev);=0D
+	follow.follow =3D status;=0D
+=0D
+	err =3D mag_msg_to_mgmt_sync(hwdev, MAG_CMD_SET_LINK_FOLLOW, &follow,=0D
+				   sizeof(follow), &follow, &out_size);=0D
+	if ((follow.head.status !=3D HINIC3_MGMT_CMD_UNSUPPORTED &&=0D
+	     follow.head.status) ||=0D
+	    err || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to set link status follow port status, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, follow.head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return follow.head.status;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
new file mode 100644=0D
index 0000000000..e6a863eb4d=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -0,0 +1,1527 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_NIC_CFG_H_=0D
+#define _HINIC3_NIC_CFG_H_=0D
+=0D
+#include "hinic3_mgmt.h"=0D
+=0D
+#ifndef ETH_ALEN=0D
+#define ETH_ALEN 6=0D
+#endif=0D
+=0D
+#define OS_VF_ID_TO_HW(os_vf_id) ((os_vf_id) + 1)=0D
+#define HW_VF_ID_TO_OS(hw_vf_id) ((hw_vf_id) - 1)=0D
+=0D
+#define HINIC3_VLAN_PRIORITY_SHIFT 13=0D
+=0D
+#define HINIC3_DCB_UP_MAX 0x8=0D
+=0D
+#define HINIC3_MAX_NUM_RQ 256=0D
+=0D
+#define HINIC3_MAX_MTU_SIZE 9600=0D
+#define HINIC3_MIN_MTU_SIZE 256=0D
+=0D
+#define HINIC3_COS_NUM_MAX 8=0D
+=0D
+#define HINIC3_VLAN_TAG_SIZE 4=0D
+#define HINIC3_ETH_OVERHEAD \=0D
+	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + HINIC3_VLAN_TAG_SIZE * 2)=0D
+=0D
+#define HINIC3_MIN_FRAME_SIZE	    (HINIC3_MIN_MTU_SIZE + HINIC3_ETH_OVERHE=
AD)=0D
+#define HINIC3_MAX_JUMBO_FRAME_SIZE (HINIC3_MAX_MTU_SIZE + HINIC3_ETH_OVER=
HEAD)=0D
+=0D
+#define HINIC3_MTU_TO_PKTLEN(mtu) (mtu)=0D
+=0D
+#define HINIC3_PKTLEN_TO_MTU(pktlen) (pktlen)=0D
+=0D
+#define HINIC3_PF_SET_VF_ALREADY 0x4=0D
+#define HINIC3_MGMT_STATUS_EXIST 0x6=0D
+#define CHECK_IPSU_15BIT	 0x8000=0D
+=0D
+#define HINIC3_MGMT_STATUS_TABLE_EMPTY 0xB=0D
+#define HINIC3_MGMT_STATUS_TABLE_FULL  0xC=0D
+=0D
+#define HINIC3_MGMT_CMD_UNSUPPORTED 0xFF=0D
+=0D
+#define HINIC3_MAX_UC_MAC_ADDRS 128=0D
+#define HINIC3_MAX_MC_MAC_ADDRS 2048=0D
+=0D
+#define CAP_INFO_MAX_LEN 512=0D
+#define VENDOR_MAX_LEN	 17=0D
+=0D
+/* Structures for RSS config. */=0D
+#define HINIC3_RSS_INDIR_SIZE	   256=0D
+#define HINIC3_RSS_INDIR_CMDQ_SIZE 128=0D
+#define HINIC3_RSS_KEY_SIZE	   40=0D
+#define HINIC3_RSS_ENABLE	   0x01=0D
+#define HINIC3_RSS_DISABLE	   0x00=0D
+#define HINIC3_INVALID_QID_BASE	   0xffff=0D
+=0D
+#ifndef ETH_SPEED_NUM_200G=0D
+#define ETH_SPEED_NUM_200G 200000 /**< 200 Gbps. */=0D
+#endif=0D
+=0D
+struct hinic3_rss_type {=0D
+	u8 tcp_ipv6_ext;=0D
+	u8 ipv6_ext;=0D
+	u8 tcp_ipv6;=0D
+	u8 ipv6;=0D
+	u8 tcp_ipv4;=0D
+	u8 ipv4;=0D
+	u8 udp_ipv6;=0D
+	u8 udp_ipv4;=0D
+};=0D
+=0D
+enum hinic3_rss_hash_type {=0D
+	HINIC3_RSS_HASH_ENGINE_TYPE_XOR =3D 0,=0D
+	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP,=0D
+	HINIC3_RSS_HASH_ENGINE_TYPE_MAX,=0D
+};=0D
+=0D
+#define MAX_FEATURE_QWORD 4=0D
+struct hinic3_cmd_feature_nego {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode; /**< 1: set, 0: get. */=0D
+	u8 rsvd;=0D
+	u64 s_feature[MAX_FEATURE_QWORD];=0D
+};=0D
+=0D
+/* Structures for port info. */=0D
+struct nic_port_info {=0D
+	u8 port_type;=0D
+	u8 autoneg_cap;=0D
+	u8 autoneg_state;=0D
+	u8 duplex;=0D
+	u8 speed;=0D
+	u8 fec;=0D
+};=0D
+=0D
+enum hinic3_link_status { HINIC3_LINK_DOWN =3D 0, HINIC3_LINK_UP };=0D
+=0D
+enum nic_media_type {=0D
+	MEDIA_UNKNOWN =3D -1,=0D
+	MEDIA_FIBRE =3D 0,=0D
+	MEDIA_COPPER,=0D
+	MEDIA_BACKPLANE=0D
+};=0D
+=0D
+enum nic_speed_level {=0D
+	LINK_SPEED_NOT_SET =3D 0,=0D
+	LINK_SPEED_10MB,=0D
+	LINK_SPEED_100MB,=0D
+	LINK_SPEED_1GB,=0D
+	LINK_SPEED_10GB,=0D
+	LINK_SPEED_25GB,=0D
+	LINK_SPEED_40GB,=0D
+	LINK_SPEED_50GB,=0D
+	LINK_SPEED_100GB,=0D
+	LINK_SPEED_200GB,=0D
+	LINK_SPEED_LEVELS,=0D
+};=0D
+=0D
+enum hinic3_nic_event_type {=0D
+	EVENT_NIC_LINK_DOWN,=0D
+	EVENT_NIC_LINK_UP,=0D
+	EVENT_NIC_PORT_MODULE_EVENT,=0D
+	EVENT_NIC_DCB_STATE_CHANGE,=0D
+};=0D
+=0D
+enum hinic3_link_port_type {=0D
+	LINK_PORT_UNKNOWN,=0D
+	LINK_PORT_OPTICAL_MM,=0D
+	LINK_PORT_OPTICAL_SM,=0D
+	LINK_PORT_PAS_COPPER,=0D
+	LINK_PORT_ACC,=0D
+	LINK_PORT_BASET,=0D
+	LINK_PORT_AOC =3D 0x40,=0D
+	LINK_PORT_ELECTRIC,=0D
+	LINK_PORT_BACKBOARD_INTERFACE,=0D
+};=0D
+=0D
+enum hilink_fibre_subtype {=0D
+	FIBRE_SUBTYPE_SR =3D 1,=0D
+	FIBRE_SUBTYPE_LR,=0D
+	FIBRE_SUBTYPE_MAX,=0D
+};=0D
+=0D
+enum hilink_fec_type {=0D
+	HILINK_FEC_NOT_SET,=0D
+	HILINK_FEC_RSFEC,=0D
+	HILINK_FEC_BASEFEC,=0D
+	HILINK_FEC_NOFEC,=0D
+	HILINK_FEC_LLRSFE,=0D
+	HILINK_FEC_MAX_TYPE,=0D
+};=0D
+=0D
+enum mag_cmd_port_an {=0D
+	PORT_AN_NOT_SET =3D 0,=0D
+	PORT_CFG_AN_ON =3D 1,=0D
+	PORT_CFG_AN_OFF =3D 2=0D
+};=0D
+=0D
+enum mag_cmd_port_speed {=0D
+	PORT_SPEED_NOT_SET =3D 0,=0D
+	PORT_SPEED_10MB =3D 1,=0D
+	PORT_SPEED_100MB =3D 2,=0D
+	PORT_SPEED_1GB =3D 3,=0D
+	PORT_SPEED_10GB =3D 4,=0D
+	PORT_SPEED_25GB =3D 5,=0D
+	PORT_SPEED_40GB =3D 6,=0D
+	PORT_SPEED_50GB =3D 7,=0D
+	PORT_SPEED_100GB =3D 8,=0D
+	PORT_SPEED_200GB =3D 9,=0D
+	PORT_SPEED_UNKNOWN=0D
+};=0D
+=0D
+struct hinic3_sq_attr {=0D
+	u8 dma_attr_off;=0D
+	u8 pending_limit;=0D
+	u8 coalescing_time;=0D
+	u8 intr_en;=0D
+	u16 intr_idx;=0D
+	u32 l2nic_sqn;=0D
+	u64 ci_dma_base;=0D
+};=0D
+=0D
+struct hinic3_cmd_cons_idx_attr {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_idx;=0D
+	u8 dma_attr_off;=0D
+	u8 pending_limit;=0D
+	u8 coalescing_time;=0D
+	u8 intr_en;=0D
+	u16 intr_idx;=0D
+	u32 l2nic_sqn;=0D
+	u32 rsvd;=0D
+	u64 ci_addr;=0D
+};=0D
+=0D
+struct hinic3_port_mac_set {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 vlan_id;=0D
+	u16 rsvd1;=0D
+	u8 mac[ETH_ALEN];=0D
+};=0D
+=0D
+struct hinic3_port_mac_update {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 vlan_id;=0D
+	u16 rsvd1;=0D
+	u8 old_mac[ETH_ALEN];=0D
+	u16 rsvd2;=0D
+	u8 new_mac[ETH_ALEN];=0D
+};=0D
+=0D
+struct hinic3_ppa_cfg_state_cmd {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 ppa_state;=0D
+	u8 rsvd;=0D
+};=0D
+=0D
+struct hinic3_ppa_cfg_mode_cmd {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 rsvd0;=0D
+	u8 ppa_mode;=0D
+	u8 qpc_func_nums;=0D
+	u16 base_qpc_func_id;=0D
+	u16 rsvd1;=0D
+};=0D
+=0D
+struct hinic3_ppa_cfg_flush_cmd {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 rsvd0;=0D
+	u8 flush_en; /**< 0: flush done, 1: in flush operation. */=0D
+	u8 rsvd1;=0D
+};=0D
+=0D
+struct hinic3_ppa_fdir_query_cmd {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u32 index;=0D
+	u32 rsvd;=0D
+	u64 pkt_nums;=0D
+	u64 pkt_bytes;=0D
+};=0D
+=0D
+#define HINIC3_CMD_OP_ADD 1=0D
+#define HINIC3_CMD_OP_DEL 0=0D
+=0D
+struct hinic3_cmd_vlan_config {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode;=0D
+	u8 rsvd1;=0D
+	u16 vlan_id;=0D
+	u16 rsvd2;=0D
+};=0D
+=0D
+struct hinic3_cmd_set_vlan_filter {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 resvd[2];=0D
+	/* Bit0: vlan filter en, bit1: broadcast filter en. */=0D
+	u32 vlan_filter_ctrl;=0D
+};=0D
+=0D
+struct hinic3_cmd_port_info {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u8 port_id;=0D
+	u8 rsvd1[3];=0D
+	u8 port_type;=0D
+	u8 autoneg_cap;=0D
+	u8 autoneg_state;=0D
+	u8 duplex;=0D
+	u8 speed;=0D
+	u8 fec;=0D
+	u16 rsvd2;=0D
+	u32 rsvd3[4];=0D
+};=0D
+=0D
+struct hinic3_cmd_link_state {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u8 port_id;=0D
+	u8 state;=0D
+	u16 rsvd1;=0D
+};=0D
+=0D
+struct nic_pause_config {=0D
+	u8 auto_neg;=0D
+	u8 rx_pause;=0D
+	u8 tx_pause;=0D
+};=0D
+=0D
+struct hinic3_cmd_pause_config {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u8 port_id;=0D
+	u8 opcode;=0D
+	u16 rsvd1;=0D
+	u8 auto_neg;=0D
+	u8 rx_pause;=0D
+	u8 tx_pause;=0D
+	u8 rsvd2[5];=0D
+};=0D
+=0D
+struct hinic3_vport_state {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+	u8 state; /**< 0:disable, 1:enable. */=0D
+	u8 rsvd2[3];=0D
+};=0D
+=0D
+#define MAG_CMD_PORT_DISABLE 0x0=0D
+#define MAG_CMD_TX_ENABLE    0x1=0D
+#define MAG_CMD_RX_ENABLE    0x2=0D
+/**=0D
+ * The physical port is disable only when all pf of the port are set to do=
wn, if=0D
+ * any pf is enable, the port is enable.=0D
+ */=0D
+struct mag_cmd_set_port_enable {=0D
+	struct mgmt_msg_head head;=0D
+	/* function_id should not more than the max support pf_id(32). */=0D
+	u16 function_id;=0D
+	u16 rsvd0;=0D
+=0D
+	/* bitmap bit0:tx_en, bit1:rx_en. */=0D
+	u8 state;=0D
+	u8 rsvd1[3];=0D
+};=0D
+=0D
+struct mag_cmd_get_port_enable {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	u8 port;=0D
+	u8 state; /**< bitmap bit0:tx_en, bit1:rx_en. */=0D
+	u8 rsvd0[2];=0D
+};=0D
+=0D
+struct hinic3_cmd_clear_qp_resource {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+};=0D
+=0D
+struct hinic3_port_stats_info {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+};=0D
+=0D
+struct hinic3_vport_stats {=0D
+	u64 tx_unicast_pkts_vport;=0D
+	u64 tx_unicast_bytes_vport;=0D
+	u64 tx_multicast_pkts_vport;=0D
+	u64 tx_multicast_bytes_vport;=0D
+	u64 tx_broadcast_pkts_vport;=0D
+	u64 tx_broadcast_bytes_vport;=0D
+=0D
+	u64 rx_unicast_pkts_vport;=0D
+	u64 rx_unicast_bytes_vport;=0D
+	u64 rx_multicast_pkts_vport;=0D
+	u64 rx_multicast_bytes_vport;=0D
+	u64 rx_broadcast_pkts_vport;=0D
+	u64 rx_broadcast_bytes_vport;=0D
+=0D
+	u64 tx_discard_vport;=0D
+	u64 rx_discard_vport;=0D
+	u64 tx_err_vport;=0D
+	u64 rx_err_vport;=0D
+};=0D
+=0D
+struct hinic3_cmd_vport_stats {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u32 stats_size;=0D
+	u32 rsvd1;=0D
+	struct hinic3_vport_stats stats;=0D
+	u64 rsvd2[6];=0D
+};=0D
+=0D
+struct hinic3_phy_port_stats {=0D
+	u64 mac_rx_total_octs_port;=0D
+	u64 mac_tx_total_octs_port;=0D
+	u64 mac_rx_under_frame_pkts_port;=0D
+	u64 mac_rx_frag_pkts_port;=0D
+	u64 mac_rx_64_oct_pkts_port;=0D
+	u64 mac_rx_127_oct_pkts_port;=0D
+	u64 mac_rx_255_oct_pkts_port;=0D
+	u64 mac_rx_511_oct_pkts_port;=0D
+	u64 mac_rx_1023_oct_pkts_port;=0D
+	u64 mac_rx_max_oct_pkts_port;=0D
+	u64 mac_rx_over_oct_pkts_port;=0D
+	u64 mac_tx_64_oct_pkts_port;=0D
+	u64 mac_tx_127_oct_pkts_port;=0D
+	u64 mac_tx_255_oct_pkts_port;=0D
+	u64 mac_tx_511_oct_pkts_port;=0D
+	u64 mac_tx_1023_oct_pkts_port;=0D
+	u64 mac_tx_max_oct_pkts_port;=0D
+	u64 mac_tx_over_oct_pkts_port;=0D
+	u64 mac_rx_good_pkts_port;=0D
+	u64 mac_rx_crc_error_pkts_port;=0D
+	u64 mac_rx_broadcast_ok_port;=0D
+	u64 mac_rx_multicast_ok_port;=0D
+	u64 mac_rx_mac_frame_ok_port;=0D
+	u64 mac_rx_length_err_pkts_port;=0D
+	u64 mac_rx_vlan_pkts_port;=0D
+	u64 mac_rx_pause_pkts_port;=0D
+	u64 mac_rx_unknown_mac_frame_port;=0D
+	u64 mac_tx_good_pkts_port;=0D
+	u64 mac_tx_broadcast_ok_port;=0D
+	u64 mac_tx_multicast_ok_port;=0D
+	u64 mac_tx_underrun_pkts_port;=0D
+	u64 mac_tx_mac_frame_ok_port;=0D
+	u64 mac_tx_vlan_pkts_port;=0D
+	u64 mac_tx_pause_pkts_port;=0D
+};=0D
+=0D
+struct mag_phy_port_stats {=0D
+	u64 mac_tx_fragment_pkt_num;=0D
+	u64 mac_tx_undersize_pkt_num;=0D
+	u64 mac_tx_undermin_pkt_num;=0D
+	u64 mac_tx_64_oct_pkt_num;=0D
+	u64 mac_tx_65_127_oct_pkt_num;=0D
+	u64 mac_tx_128_255_oct_pkt_num;=0D
+	u64 mac_tx_256_511_oct_pkt_num;=0D
+	u64 mac_tx_512_1023_oct_pkt_num;=0D
+	u64 mac_tx_1024_1518_oct_pkt_num;=0D
+	u64 mac_tx_1519_2047_oct_pkt_num;=0D
+	u64 mac_tx_2048_4095_oct_pkt_num;=0D
+	u64 mac_tx_4096_8191_oct_pkt_num;=0D
+	u64 mac_tx_8192_9216_oct_pkt_num;=0D
+	u64 mac_tx_9217_12287_oct_pkt_num;=0D
+	u64 mac_tx_12288_16383_oct_pkt_num;=0D
+	u64 mac_tx_1519_max_bad_pkt_num;=0D
+	u64 mac_tx_1519_max_good_pkt_num;=0D
+	u64 mac_tx_oversize_pkt_num;=0D
+	u64 mac_tx_jabber_pkt_num;=0D
+	u64 mac_tx_bad_pkt_num;=0D
+	u64 mac_tx_bad_oct_num;=0D
+	u64 mac_tx_good_pkt_num;=0D
+	u64 mac_tx_good_oct_num;=0D
+	u64 mac_tx_total_pkt_num;=0D
+	u64 mac_tx_total_oct_num;=0D
+	u64 mac_tx_uni_pkt_num;=0D
+	u64 mac_tx_multi_pkt_num;=0D
+	u64 mac_tx_broad_pkt_num;=0D
+	u64 mac_tx_pause_num;=0D
+	u64 mac_tx_pfc_pkt_num;=0D
+	u64 mac_tx_pfc_pri0_pkt_num;=0D
+	u64 mac_tx_pfc_pri1_pkt_num;=0D
+	u64 mac_tx_pfc_pri2_pkt_num;=0D
+	u64 mac_tx_pfc_pri3_pkt_num;=0D
+	u64 mac_tx_pfc_pri4_pkt_num;=0D
+	u64 mac_tx_pfc_pri5_pkt_num;=0D
+	u64 mac_tx_pfc_pri6_pkt_num;=0D
+	u64 mac_tx_pfc_pri7_pkt_num;=0D
+	u64 mac_tx_control_pkt_num;=0D
+	u64 mac_tx_err_all_pkt_num;=0D
+	u64 mac_tx_from_app_good_pkt_num;=0D
+	u64 mac_tx_from_app_bad_pkt_num;=0D
+=0D
+	u64 mac_rx_fragment_pkt_num;=0D
+	u64 mac_rx_undersize_pkt_num;=0D
+	u64 mac_rx_undermin_pkt_num;=0D
+	u64 mac_rx_64_oct_pkt_num;=0D
+	u64 mac_rx_65_127_oct_pkt_num;=0D
+	u64 mac_rx_128_255_oct_pkt_num;=0D
+	u64 mac_rx_256_511_oct_pkt_num;=0D
+	u64 mac_rx_512_1023_oct_pkt_num;=0D
+	u64 mac_rx_1024_1518_oct_pkt_num;=0D
+	u64 mac_rx_1519_2047_oct_pkt_num;=0D
+	u64 mac_rx_2048_4095_oct_pkt_num;=0D
+	u64 mac_rx_4096_8191_oct_pkt_num;=0D
+	u64 mac_rx_8192_9216_oct_pkt_num;=0D
+	u64 mac_rx_9217_12287_oct_pkt_num;=0D
+	u64 mac_rx_12288_16383_oct_pkt_num;=0D
+	u64 mac_rx_1519_max_bad_pkt_num;=0D
+	u64 mac_rx_1519_max_good_pkt_num;=0D
+	u64 mac_rx_oversize_pkt_num;=0D
+	u64 mac_rx_jabber_pkt_num;=0D
+	u64 mac_rx_bad_pkt_num;=0D
+	u64 mac_rx_bad_oct_num;=0D
+	u64 mac_rx_good_pkt_num;=0D
+	u64 mac_rx_good_oct_num;=0D
+	u64 mac_rx_total_pkt_num;=0D
+	u64 mac_rx_total_oct_num;=0D
+	u64 mac_rx_uni_pkt_num;=0D
+	u64 mac_rx_multi_pkt_num;=0D
+	u64 mac_rx_broad_pkt_num;=0D
+	u64 mac_rx_pause_num;=0D
+	u64 mac_rx_pfc_pkt_num;=0D
+	u64 mac_rx_pfc_pri0_pkt_num;=0D
+	u64 mac_rx_pfc_pri1_pkt_num;=0D
+	u64 mac_rx_pfc_pri2_pkt_num;=0D
+	u64 mac_rx_pfc_pri3_pkt_num;=0D
+	u64 mac_rx_pfc_pri4_pkt_num;=0D
+	u64 mac_rx_pfc_pri5_pkt_num;=0D
+	u64 mac_rx_pfc_pri6_pkt_num;=0D
+	u64 mac_rx_pfc_pri7_pkt_num;=0D
+	u64 mac_rx_control_pkt_num;=0D
+	u64 mac_rx_sym_err_pkt_num;=0D
+	u64 mac_rx_fcs_err_pkt_num;=0D
+	u64 mac_rx_send_app_good_pkt_num;=0D
+	u64 mac_rx_send_app_bad_pkt_num;=0D
+	u64 mac_rx_unfilter_pkt_num;=0D
+};=0D
+=0D
+struct mag_cmd_port_stats_info {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	u8 port_id;=0D
+	u8 rsvd0[3];=0D
+};=0D
+=0D
+struct mag_cmd_get_port_stat {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	struct mag_phy_port_stats counter;=0D
+	u64 rsvd1[15];=0D
+};=0D
+=0D
+struct param_head {=0D
+	u8 valid_len;=0D
+	u8 info_type;=0D
+	u8 rsvd[2];=0D
+};=0D
+=0D
+struct mag_port_link_param {=0D
+	struct param_head head;=0D
+=0D
+	u8 an;=0D
+	u8 fec;=0D
+	u8 speed;=0D
+	u8 rsvd0;=0D
+=0D
+	u32 used;=0D
+	u32 an_fec_ability;=0D
+	u32 an_speed_ability;=0D
+	u32 an_pause_ability;=0D
+};=0D
+=0D
+struct mag_port_wire_info {=0D
+	struct param_head head;=0D
+=0D
+	u8 status;=0D
+	u8 rsvd0[3];=0D
+=0D
+	u8 wire_type;=0D
+	u8 default_fec;=0D
+	u8 speed;=0D
+	u8 rsvd1;=0D
+	u32 speed_ability;=0D
+};=0D
+=0D
+struct mag_port_adapt_info {=0D
+	struct param_head head;=0D
+=0D
+	u32 adapt_en;=0D
+	u32 flash_adapt;=0D
+	u32 rsvd0[2];=0D
+=0D
+	u32 wire_node;=0D
+	u32 an_en;=0D
+	u32 speed;=0D
+	u32 fec;=0D
+};=0D
+=0D
+struct mag_port_param_info {=0D
+	u8 parameter_cnt;=0D
+	u8 lane_id;=0D
+	u8 lane_num;=0D
+	u8 rsvd0;=0D
+=0D
+	struct mag_port_link_param default_cfg;=0D
+	struct mag_port_link_param bios_cfg;=0D
+	struct mag_port_link_param tool_cfg;=0D
+	struct mag_port_link_param final_cfg;=0D
+=0D
+	struct mag_port_wire_info wire_info;=0D
+	struct mag_port_adapt_info adapt_info;=0D
+};=0D
+=0D
+#define XSFP_VENDOR_NAME_LEN 16=0D
+struct mag_cmd_event_port_info {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	u8 port_id;=0D
+	u8 event_type;=0D
+	u8 rsvd0[2];=0D
+=0D
+	/* Optical Module Related. */=0D
+	u8 vendor_name[XSFP_VENDOR_NAME_LEN];=0D
+	u32 port_type;	   /**< fiber / copper. */=0D
+	u32 port_sub_type; /**< sr / lr. */=0D
+	u32 cable_length;  /**< 1 / 3 / 5 m. */=0D
+	u8 cable_temp;	   /**< Temperature. */=0D
+	u8 max_speed;	   /**< Max rate of optical module. */=0D
+	u8 sfp_type;	   /**< sfp / qsfp. */=0D
+	u8 rsvd1;=0D
+	u32 power[4]; /**< Optical power. */=0D
+=0D
+	u8 an_state;=0D
+	u8 fec;=0D
+	u16 speed;=0D
+=0D
+	u8 gpio_insert; /**< 0: present, 1: absent. */=0D
+	u8 alos;=0D
+	u8 rx_los;=0D
+	u8 pma_ctrl;=0D
+=0D
+	u32 pma_fifo_reg;=0D
+	u32 pma_signal_ok_reg;=0D
+	u32 pcs_64_66b_reg;=0D
+	u32 rf_lf;=0D
+	u8 pcs_link;=0D
+	u8 pcs_mac_link;=0D
+	u8 tx_enable;=0D
+	u8 rx_enable;=0D
+	u32 pcs_err_cnt;=0D
+=0D
+	u8 eq_data[38];=0D
+	u8 rsvd2[2];=0D
+=0D
+	u32 his_link_machine_state;=0D
+	u32 cur_link_machine_state;=0D
+	u8 his_machine_state_data[128];=0D
+	u8 cur_machine_state_data[128];=0D
+	u8 his_machine_state_length;=0D
+	u8 cur_machine_state_length;=0D
+=0D
+	struct mag_port_param_info param_info;=0D
+	u8 rsvd3[360];=0D
+};=0D
+=0D
+struct hinic3_port_stats {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	struct hinic3_phy_port_stats stats;=0D
+};=0D
+=0D
+struct hinic3_cmd_clear_vport_stats {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd;=0D
+};=0D
+=0D
+struct hinic3_cmd_clear_port_stats {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd;=0D
+};=0D
+=0D
+struct hinic3_cmd_qpn {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 base_qpn;=0D
+};=0D
+=0D
+enum hinic3_func_tbl_cfg_bitmap {=0D
+	FUNC_CFG_INIT,=0D
+	FUNC_CFG_RX_BUF_SIZE,=0D
+	FUNC_CFG_MTU,=0D
+};=0D
+=0D
+struct hinic3_func_tbl_cfg {=0D
+	u16 rx_wqe_buf_size;=0D
+	u16 mtu;=0D
+	u32 rsvd[9];=0D
+};=0D
+=0D
+struct hinic3_cmd_set_func_tbl {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd;=0D
+=0D
+	u32 cfg_bitmap;=0D
+	struct hinic3_func_tbl_cfg tbl_cfg;=0D
+};=0D
+=0D
+struct hinic3_rx_mode_config {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+	u32 rx_mode;=0D
+};=0D
+=0D
+struct hinic3_cmd_vlan_offload {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 vlan_offload;=0D
+	u8 rsvd1[5];=0D
+};=0D
+=0D
+#define HINIC3_CMD_OP_GET 0=0D
+#define HINIC3_CMD_OP_SET 1=0D
+=0D
+struct hinic3_cmd_lro_config {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode;=0D
+	u8 rsvd1;=0D
+	u8 lro_ipv4_en;=0D
+	u8 lro_ipv6_en;=0D
+	u8 lro_max_pkt_len; /**< Unit size is 1K. */=0D
+	u8 resv2[13];=0D
+};=0D
+=0D
+struct hinic3_cmd_lro_timer {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u8 opcode; /**< 1: set timer value, 0: get timer value. */=0D
+	u8 rsvd1;=0D
+	u16 rsvd2;=0D
+	u32 timer;=0D
+};=0D
+=0D
+struct hinic3_rss_template_mgmt {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 cmd;=0D
+	u8 template_id;=0D
+	u8 rsvd1[4];=0D
+};=0D
+=0D
+struct hinic3_cmd_rss_hash_key {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode;=0D
+	u8 rsvd1;=0D
+	u8 key[HINIC3_RSS_KEY_SIZE];=0D
+};=0D
+=0D
+struct hinic3_rss_indir_table {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+	u8 indir[HINIC3_RSS_INDIR_SIZE];=0D
+};=0D
+=0D
+struct nic_rss_indirect_tbl {=0D
+	u32 rsvd[4]; /**< Make sure that 16B beyond entry[]. */=0D
+	u16 entry[HINIC3_RSS_INDIR_SIZE];=0D
+};=0D
+=0D
+struct nic_rss_context_tbl {=0D
+	u32 rsvd[4];=0D
+	u32 ctx;=0D
+};=0D
+=0D
+struct hinic3_rss_context_table {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+	u32 context;=0D
+};=0D
+=0D
+struct hinic3_cmd_rss_engine_type {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode;=0D
+	u8 hash_engine;=0D
+	u8 rsvd1[4];=0D
+};=0D
+=0D
+struct hinic3_cmd_rss_config {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 rss_en;=0D
+	u8 rq_priority_number;=0D
+	u8 prio_tc[HINIC3_DCB_UP_MAX];=0D
+	u32 rsvd1;=0D
+};=0D
+=0D
+enum {=0D
+	HINIC3_IFLA_VF_LINK_STATE_AUTO,	   /**< Link state of the uplink. */=0D
+	HINIC3_IFLA_VF_LINK_STATE_ENABLE,  /**< Link always up. */=0D
+	HINIC3_IFLA_VF_LINK_STATE_DISABLE, /**< Link always down. */=0D
+};=0D
+=0D
+struct hinic3_dcb_state {=0D
+	u8 dcb_on;=0D
+	u8 default_cos;=0D
+	u8 trust;=0D
+	u8 rsvd1;=0D
+	u8 up_cos[HINIC3_DCB_UP_MAX];=0D
+	u8 dscp2cos[64];=0D
+	u32 rsvd2[7];=0D
+};=0D
+=0D
+struct hinic3_cmd_vf_dcb_state {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	struct hinic3_dcb_state state;=0D
+};=0D
+=0D
+struct hinic3_cmd_register_vf {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u8 op_register; /* 0: unregister, 1: register. */=0D
+	u8 rsvd[39];=0D
+};=0D
+=0D
+struct hinic3_tcam_result {=0D
+	u32 qid;=0D
+	u32 rsvd;=0D
+};=0D
+=0D
+#define HINIC3_TCAM_FLOW_KEY_SIZE     44=0D
+#define HINIC3_MAX_TCAM_RULES_NUM     4096=0D
+#define HINIC3_TCAM_BLOCK_ENABLE      1=0D
+#define HINIC3_TCAM_BLOCK_DISABLE     0=0D
+#define HINIC3_TCAM_BLOCK_NORMAL_TYPE 0=0D
+=0D
+struct hinic3_tcam_key_x_y {=0D
+	u8 x[HINIC3_TCAM_FLOW_KEY_SIZE];=0D
+	u8 y[HINIC3_TCAM_FLOW_KEY_SIZE];=0D
+};=0D
+=0D
+struct hinic3_tcam_cfg_rule {=0D
+	u32 index;=0D
+	struct hinic3_tcam_result data;=0D
+	struct hinic3_tcam_key_x_y key;=0D
+};=0D
+=0D
+/* Define the TCAM type. */=0D
+#define TCAM_RULE_FDIR_TYPE 0=0D
+#define TCAM_RULE_PPA_TYPE  1=0D
+=0D
+struct hinic3_fdir_add_rule {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 type;=0D
+	u8 rsvd;=0D
+	struct hinic3_tcam_cfg_rule rule;=0D
+};=0D
+=0D
+struct hinic3_fdir_del_rule {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 type;=0D
+	u8 rsvd;=0D
+	u32 index_start;=0D
+	u32 index_num;=0D
+};=0D
+=0D
+struct hinic3_flush_tcam_rules {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd;=0D
+};=0D
+=0D
+struct hinic3_tcam_block {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 alloc_en; /* 0: free tcam block, 1: alloc tcam block. */=0D
+	u8 tcam_type;=0D
+	u16 tcam_block_index;=0D
+	u16 rsvd;=0D
+};=0D
+=0D
+struct hinic3_port_tcam_info {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	u16 func_id;=0D
+	u8 tcam_enable;=0D
+	u8 rsvd1;=0D
+	u32 rsvd2;=0D
+};=0D
+=0D
+struct hinic3_set_fdir_ethertype_rule {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+	u8 pkt_type_en;=0D
+	u8 pkt_type;=0D
+	u8 qid;=0D
+	u8 rsvd2;=0D
+};=0D
+=0D
+struct hinic3_cmd_set_rq_flush {=0D
+	union {=0D
+		struct {=0D
+			u16 global_rq_id;=0D
+			u16 local_rq_id;=0D
+		};=0D
+		u32 value;=0D
+	};=0D
+};=0D
+=0D
+enum hinic3_link_follow_status {=0D
+	HINIC3_LINK_FOLLOW_DEFAULT,=0D
+	HINIC3_LINK_FOLLOW_PORT,=0D
+	HINIC3_LINK_FOLLOW_SEPARATE,=0D
+	HINIC3_LINK_FOLLOW_STATUS_MAX,=0D
+};=0D
+=0D
+struct mag_cmd_set_link_follow {=0D
+	struct mgmt_msg_head head;=0D
+	u16 function_id;=0D
+	u16 rsvd0;=0D
+	u8 follow;=0D
+	u8 rsvd1[3];=0D
+};=0D
+=0D
+int l2nic_msg_to_mgmt_sync(void *hwdev, u16 cmd, void *buf_in, u16 in_size=
,=0D
+			   void *buf_out, u16 *out_size);=0D
+=0D
+int hinic3_set_ci_table(void *hwdev, struct hinic3_sq_attr *attr);=0D
+=0D
+/**=0D
+ * Update MAC address to hardware.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] old_mac=0D
+ * Old MAC addr to delete.=0D
+ * @param[in] new_mac=0D
+ * New MAC addr to update.=0D
+ * @param[in] vlan_id=0D
+ * Vlan id.=0D
+ * @param func_id=0D
+ * Function index.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_update_mac(void *hwdev, u8 *old_mac, u8 *new_mac, u16 vlan_id,=
=0D
+		      u16 func_id);=0D
+=0D
+/**=0D
+ * Get the default mac address.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] mac_addr=0D
+ * Mac address from hardware.=0D
+ * @param[in] ether_len=0D
+ * The length of mac address.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_default_mac(void *hwdev, u8 *mac_addr, int ether_len);=0D
+=0D
+/**=0D
+ * Set mac address.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] mac_addr=0D
+ * Mac address from hardware.=0D
+ * @param[in] vlan_id=0D
+ * Vlan id.=0D
+ * @param[in] func_id=0D
+ * Function index.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_mac(void *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_=
id);=0D
+=0D
+/**=0D
+ * Delete MAC address.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] mac_addr=0D
+ * MAC address from hardware.=0D
+ * @param[in] vlan_id=0D
+ * Vlan id.=0D
+ * @param[in] func_id=0D
+ * Function index.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_del_mac(void *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_=
id);=0D
+=0D
+/**=0D
+ * Set function mtu.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] new_mtu=0D
+ * MTU value.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_port_mtu(void *hwdev, u16 new_mtu);=0D
+=0D
+/**=0D
+ * Set function valid status.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] enable=0D
+ * 0: disable, 1: enable.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_vport_enable(void *hwdev, bool enable);=0D
+=0D
+/**=0D
+ * Set port status.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev=0D
+ * @param[in] enable=0D
+ * 0: disable, 1: enable.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_port_enable(void *hwdev, bool enable);=0D
+=0D
+/**=0D
+ * Get link state.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] link_state=0D
+ * Link state, 0: link down, 1: link up.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_link_state(void *hwdev, u8 *link_state);=0D
+=0D
+/**=0D
+ * Flush queue pairs resource in hardware.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_flush_qps_res(void *hwdev);=0D
+=0D
+/**=0D
+ * Set pause info.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] nic_pause=0D
+ * Pause info.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_pause_info(void *hwdev, struct nic_pause_config nic_pause);=
=0D
+=0D
+/**=0D
+ * Get pause info.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] nic_pause=0D
+ * Pause info.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_pause_info(void *hwdev, struct nic_pause_config *nic_pause)=
;=0D
+=0D
+/**=0D
+ * Get function stats.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] stats=0D
+ * Function stats.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_vport_stats(void *hwdev, struct hinic3_vport_stats *stats);=
=0D
+=0D
+/**=0D
+ * Get port stats.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] stats=0D
+ * Port stats.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+=0D
+int hinic3_get_phy_port_stats(void *hwdev, struct mag_phy_port_stats *stat=
s);=0D
+=0D
+int hinic3_clear_vport_stats(void *hwdev);=0D
+=0D
+int hinic3_clear_phy_port_stats(void *hwdev);=0D
+=0D
+/**=0D
+ * Init nic hwdev.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_init_nic_hwdev(void *hwdev);=0D
+=0D
+/**=0D
+ * Free nic hwdev.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ */=0D
+void hinic3_free_nic_hwdev(void *hwdev);=0D
+=0D
+/**=0D
+ * Set function rx mode.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] enable=0D
+ * Rx mode state, 0-disable, 1-enable.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_rx_mode(void *hwdev, u32 enable);=0D
+=0D
+/**=0D
+ * Set function vlan offload valid state.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] enable=0D
+ * Rx mode state, 0-disable, 1-enable.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_rx_vlan_offload(void *hwdev, u8 en);=0D
+=0D
+/**=0D
+ * Set rx LRO configuration.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] lro_en=0D
+ * LRO enable state, 0-disable, 1-enable.=0D
+ * @param[in] lro_timer=0D
+ * LRO aggregation timeout.=0D
+ * @param[in] lro_max_pkt_len=0D
+ * LRO coalesce packet size(unit size is 1K).=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_rx_lro_state(void *hwdev, u8 lro_en, u32 lro_timer,=0D
+			    u32 lro_max_pkt_len);=0D
+=0D
+/**=0D
+ * Get port info.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] port_info=0D
+ * Port info, including autoneg, port type, duplex, speed and fec mode.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_port_info(void *hwdev, struct nic_port_info *port_info);=0D
+=0D
+int hinic3_init_function_table(void *hwdev, u16 rx_buff_len);=0D
+=0D
+/**=0D
+ * Alloc RSS template table.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_template_alloc(void *hwdev);=0D
+=0D
+/**=0D
+ * Free RSS template table.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_template_free(void *hwdev);=0D
+=0D
+/**=0D
+ * Set RSS indirect table.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] indir_table=0D
+ * RSS indirect table.=0D
+ * @param[in] indir_table_size=0D
+ * RSS indirect table size.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_set_indir_tbl(void *hwdev, const u32 *indir_table,=0D
+			     u32 indir_table_size);=0D
+=0D
+/**=0D
+ * Get RSS indirect table.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] indir_table=0D
+ * RSS indirect table.=0D
+ * @param[in] indir_table_size=0D
+ * RSS indirect table size.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_get_indir_tbl(void *hwdev, u32 *indir_table,=0D
+			     u32 indir_table_size);=0D
+=0D
+/**=0D
+ * Set RSS type.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] rss_type=0D
+ * RSS type, including ipv4, tcpv4, ipv6, tcpv6 and etc.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_rss_type(void *hwdev, struct hinic3_rss_type rss_type);=0D
+=0D
+/**=0D
+ * Get RSS type.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] rss_type=0D
+ * RSS type, including ipv4, tcpv4, ipv6, tcpv6 and etc.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_rss_type(void *hwdev, struct hinic3_rss_type *rss_type);=0D
+=0D
+/**=0D
+ * Get RSS hash engine.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] type=0D
+ * RSS hash engine, pmd driver only supports Toeplitz.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_get_hash_engine(void *hwdev, u8 *type);=0D
+=0D
+/**=0D
+ * Set RSS hash engine.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] type=0D
+ * RSS hash engine, pmd driver only supports Toeplitz.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_set_hash_engine(void *hwdev, u8 type);=0D
+=0D
+/**=0D
+ * Set RSS configuration.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] rss_en=0D
+ * RSS enable lag, 0-disable, 1-enable.=0D
+ * @param[in] tc_num=0D
+ * Number of TC.=0D
+ * @param[in] prio_tc=0D
+ * Priority of TC.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_cfg(void *hwdev, u8 rss_en, u8 tc_num, u8 *prio_tc);=0D
+=0D
+/**=0D
+ * Set RSS hash key.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] key=0D
+ * RSS hash key.=0D
+ * @param[in] key_size=0D
+ * hash key size.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_rss_set_hash_key(void *hwdev, u8 *key, u16 key_size);=0D
+=0D
+/**=0D
+ * Add vlan to hardware.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] vlan_id=0D
+ * Vlan id.=0D
+ * @param[in] func_id=0D
+ * Function id.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_add_vlan(void *hwdev, u16 vlan_id, u16 func_id);=0D
+=0D
+/**=0D
+ * Delete vlan.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] vlan_id=0D
+ * Vlan id.=0D
+ * @param[in] func_id=0D
+ * Function id.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_del_vlan(void *hwdev, u16 vlan_id, u16 func_id);=0D
+=0D
+/**=0D
+ * Set vlan filter.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] vlan_filter_ctrl=0D
+ * Vlan filter enable flag, 0-disable, 1-enable.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_vlan_filter(void *hwdev, u32 vlan_filter_ctrl);=0D
+=0D
+/**=0D
+ * Get VF function default cos.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[out] cos_id=0D
+ * Cos id.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_vf_get_default_cos(void *hwdev, u8 *cos_id);=0D
+=0D
+/**=0D
+ * Add tcam rules.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] tcam_rule=0D
+ * Tcam rule, including tcam rule index, tcam action, tcam key and etc.=0D
+ * @param[in] tcam_rule_type=0D
+ * Tcam rule type.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_add_tcam_rule(void *hwdev, struct hinic3_tcam_cfg_rule *tcam_ru=
le,=0D
+			 u8 tcam_rule_type);=0D
+=0D
+/**=0D
+ * Del tcam rules.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] index=0D
+ * Tcam rule index.=0D
+ * @param[in] tcam_rule_type=0D
+ * Tcam rule type.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_del_tcam_rule(void *hwdev, u32 index, u8 tcam_rule_type);=0D
+=0D
+/**=0D
+ * Alloc tcam block.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] index=0D
+ * Tcam block index.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_alloc_tcam_block(void *hwdev, u16 *index);=0D
+=0D
+/**=0D
+ * Free tcam block.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] index=0D
+ * Tcam block index.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_free_tcam_block(void *hwdev, u16 *index);=0D
+=0D
+/**=0D
+ * Set fdir tcam function enable or disable.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] enable=0D
+ * Tcam enable flag, 1-enable, 0-disable.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_fdir_tcam_rule_filter(void *hwdev, bool enable);=0D
+=0D
+/**=0D
+ * Flush fdir tcam rule.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Device pointer to hwdev.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_flush_tcam_rule(void *hwdev);=0D
+=0D
+int hinic3_set_rq_flush(void *hwdev, u16 q_id);=0D
+=0D
+/**=0D
+ * Get service feature HW supported.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] size=0D
+ * s_feature's array size.=0D
+ * @param[out] s_feature=0D
+ * s_feature HW supported.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_feature_from_hw(void *hwdev, u64 *s_feature, u16 size);=0D
+=0D
+/**=0D
+ * Set service feature driver supported to hardware.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Device pointer to hwdev.=0D
+ * @param[in] size=0D
+ * s_feature's array size.=0D
+ * @param[out] s_feature=0D
+ * s_feature HW supported.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_feature_to_hw(void *hwdev, u64 *s_feature, u16 size);=0D
+=0D
+int hinic3_set_fdir_ethertype_filter(void *hwdev, u8 pkt_type, u16 queue_i=
d,=0D
+				     u8 en);=0D
+=0D
+int hinic3_set_link_status_follow(void *hwdev,=0D
+				  enum hinic3_link_follow_status status);=0D
+#endif /* _HINIC3_NIC_CFG_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

