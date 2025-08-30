Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16458CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C7674066A;
	Sat, 30 Aug 2025 14:40:57 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 9B33640653
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=JENVNcY0HEq7xKeYsMNvwbZ4MM02T0QVX/jU/esoFwo=;
 b=HSrG7OfwRmT/x4bYtuArazaVsxmDevmuwBcy6P/Znz9ejyr8pGCdjhESYSs+8u
 rRCwtbD5R7xOuVO9c4mmOuxSiQiZics301fFCpy5tDuAJamKBUehQX+K3KRp+G6/
 GdYNBK1coMyjryg51GJ+KzO2UeAbw/EPSDZVrAOuwNHcw=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S9;
 Sat, 30 Aug 2025 20:40:51 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 05/18] net/hinic3: add NIC event module
Date: Sat, 30 Aug 2025 20:39:17 +0800
Message-ID: <20250830123942.5037-6-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S9
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFykGr15Cr1fAFWDWr1xXwb_yoW8Xryrto
 WSgw45WrnYqryxCay0qFn7GFZ7ZrWvgFZ5t3yYyFW3Gw17X34jqayfXr4Yva40gr4YkrW3
 A3WDtayIyw4UJwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFGYpUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiBhC5Cmiyd2a+9QAAsl
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

From: Xin Wang <wangxin679@h-partners.com>=0D

Currently, there are two types of events: pf/vf connection status=0D
and port information printing. This patch contains related data=0D
structures and function codes.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_nic_event.c | 433 +++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_event.h |  39 ++=0D
 2 files changed, 472 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic=
3/base/hinic3_nic_event.c=0D
new file mode 100644=0D
index 0000000000..fb779fcf25=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c=0D
@@ -0,0 +1,433 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_nic_event.h"=0D
+#include "hinic3_ethdev.h"=0D
+=0D
+static const char *g_hw_to_char_fec[HILINK_FEC_MAX_TYPE] =3D {=0D
+	"not set", "rsfec", "basefec", "nofec", "llrsfec",=0D
+};=0D
+static const char *g_hw_to_speed_info[PORT_SPEED_UNKNOWN] =3D {=0D
+	"not set", "10MB", "100MB", "1GB",   "10GB",=0D
+	"25GB",	   "40GB", "50GB",  "100GB", "200GB",=0D
+};=0D
+static const char *g_hw_to_an_state_info[PORT_CFG_AN_OFF + 1] =3D {=0D
+	"not set",=0D
+	"on",=0D
+	"off",=0D
+};=0D
+=0D
+struct port_type_table {=0D
+	u32 port_type;=0D
+	const char *port_type_name;=0D
+};=0D
+=0D
+void=0D
+get_port_info(struct hinic3_hwdev *hwdev, u8 link_state,=0D
+	      struct rte_eth_link *link)=0D
+{=0D
+	uint32_t port_speed[LINK_SPEED_LEVELS] =3D {=0D
+		RTE_ETH_SPEED_NUM_NONE, RTE_ETH_SPEED_NUM_10M,=0D
+		RTE_ETH_SPEED_NUM_100M, RTE_ETH_SPEED_NUM_1G,=0D
+		RTE_ETH_SPEED_NUM_10G,	RTE_ETH_SPEED_NUM_25G,=0D
+		RTE_ETH_SPEED_NUM_40G,	RTE_ETH_SPEED_NUM_50G,=0D
+		RTE_ETH_SPEED_NUM_100G, RTE_ETH_SPEED_NUM_200G,=0D
+	};=0D
+	struct nic_port_info port_info =3D {0};=0D
+	int err;=0D
+=0D
+	if (!link_state) {=0D
+		link->link_status =3D RTE_ETH_LINK_DOWN;=0D
+		link->link_speed =3D RTE_ETH_SPEED_NUM_NONE;=0D
+		link->link_duplex =3D RTE_ETH_LINK_HALF_DUPLEX;=0D
+		link->link_autoneg =3D RTE_ETH_LINK_FIXED;=0D
+	} else {=0D
+		link->link_status =3D RTE_ETH_LINK_UP;=0D
+=0D
+		err =3D hinic3_get_port_info(hwdev, &port_info);=0D
+		if (err) {=0D
+			link->link_speed =3D RTE_ETH_SPEED_NUM_NONE;=0D
+			link->link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX;=0D
+			link->link_autoneg =3D RTE_ETH_LINK_FIXED;=0D
+		} else {=0D
+			link->link_speed =3D=0D
+				port_speed[port_info.speed % LINK_SPEED_LEVELS];=0D
+			link->link_duplex =3D port_info.duplex;=0D
+			link->link_autoneg =3D port_info.autoneg_state;=0D
+		}=0D
+	}=0D
+}=0D
+=0D
+static void=0D
+hinic3_link_event_stats(void *dev, u8 link)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D dev;=0D
+=0D
+	if (link)=0D
+		rte_atomic_fetch_add_explicit(&hwdev->hw_stats.link_event_stats.link_up_=
stats,=0D
+			1, rte_memory_order_seq_cst);=0D
+	else=0D
+		rte_atomic_fetch_add_explicit(&hwdev->hw_stats.link_event_stats.link_dow=
n_stats,=0D
+			1, rte_memory_order_seq_cst);=0D
+}=0D
+=0D
+static void=0D
+hinic3_set_vport_state(struct hinic3_hwdev *hwdev,=0D
+		       struct hinic3_cmd_link_state *link_state)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	int err =3D 0;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV((struct rte_eth_dev *)(hwde=
v->eth_dev));=0D
+=0D
+	if (link_state->state) {=0D
+		if (hinic3_get_bit(HINIC3_DEV_START, &nic_dev->dev_status))=0D
+			err =3D hinic3_set_vport_enable(hwdev, true);=0D
+	} else {=0D
+		err =3D hinic3_set_vport_enable(hwdev, false);=0D
+	}=0D
+=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Set vport status failed");=0D
+}=0D
+=0D
+static void=0D
+link_status_event_handler(void *hwdev, void *buf_in, __rte_unused u16 in_s=
ize,=0D
+			  __rte_unused void *buf_out,=0D
+			  __rte_unused u16 *out_size)=0D
+{=0D
+	struct hinic3_cmd_link_state *link_status =3D NULL;=0D
+	struct rte_eth_link link;=0D
+	struct hinic3_hwdev *dev =3D hwdev;=0D
+	int err;=0D
+=0D
+	link_status =3D buf_in;=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Link status report received, func_id: %d, status: %d(%s)",=0D
+		    hinic3_global_func_id(hwdev), link_status->state,=0D
+		    link_status->state ? "UP" : "DOWN");=0D
+=0D
+	hinic3_link_event_stats(hwdev, link_status->state);=0D
+=0D
+	hinic3_set_vport_state(dev, link_status);=0D
+=0D
+	/* Link event reported only after set vport enable. */=0D
+	get_port_info(dev, link_status->state, &link);=0D
+	err =3D rte_eth_linkstatus_set((struct rte_eth_dev *)(dev->eth_dev),=0D
+				     &link);=0D
+	if (!err)=0D
+		rte_eth_dev_callback_process(dev->eth_dev,=0D
+					     RTE_ETH_EVENT_INTR_LSC, NULL);=0D
+}=0D
+=0D
+static const char *=0D
+get_port_type_name(u32 type)=0D
+{=0D
+	int i;=0D
+	const struct port_type_table port_optical_type_table_s[] =3D {=0D
+		{LINK_PORT_UNKNOWN, "UNKNOWN"},=0D
+		{LINK_PORT_OPTICAL_MM, "optical_sr"},=0D
+		{LINK_PORT_OPTICAL_SM, "optical_lr"},=0D
+		{LINK_PORT_PAS_COPPER, "copper"},=0D
+		{LINK_PORT_ACC, "ACC"},=0D
+		{LINK_PORT_BASET, "baset"},=0D
+		{LINK_PORT_AOC, "AOC"},=0D
+		{LINK_PORT_ELECTRIC, "electric"},=0D
+		{LINK_PORT_BACKBOARD_INTERFACE, "interface"},=0D
+	};=0D
+=0D
+	for (i =3D 0; i < ARRAY_LEN(port_optical_type_table_s); i++) {=0D
+		if (type =3D=3D port_optical_type_table_s[i].port_type)=0D
+			return port_optical_type_table_s[i].port_type_name;=0D
+	}=0D
+	return "UNKNOWN TYPE";=0D
+}=0D
+=0D
+static void=0D
+get_port_type(struct mag_cmd_event_port_info *port_info, const char **port=
_type)=0D
+{=0D
+	if (port_info->port_type <=3D LINK_PORT_BACKBOARD_INTERFACE)=0D
+		*port_type =3D get_port_type_name(port_info->port_type);=0D
+	else=0D
+		PMD_DRV_LOG(INFO, "Unknown port type: %u",=0D
+			    port_info->port_type);=0D
+}=0D
+=0D
+static int=0D
+get_port_temperature_power(struct mag_cmd_event_port_info *info, char *str=
)=0D
+{=0D
+	char arr[CAP_INFO_MAX_LEN];=0D
+=0D
+	snprintf(arr, CAP_INFO_MAX_LEN - 1, "%s, %s, Temperature: %u", str,=0D
+		 info->sfp_type ? "QSFP" : "SFP", info->cable_temp);=0D
+	if (info->sfp_type)=0D
+		snprintf(str, CAP_INFO_MAX_LEN - 1,=0D
+			 "%s, rx power: %uuw %uuW %uuW %uuW", arr,=0D
+			 info->power[0x0], info->power[0x1], info->power[0x2],=0D
+			 info->power[0x3]);=0D
+	else=0D
+		snprintf(str, CAP_INFO_MAX_LEN - 1,=0D
+			 "%s, rx power: %uuW, tx power: %uuW", arr,=0D
+			 info->power[0x0], info->power[0x1]);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+print_cable_info(struct mag_cmd_event_port_info *port_info)=0D
+{=0D
+	char tmp_str[CAP_INFO_MAX_LEN] =3D {0};=0D
+	char tmp_vendor[VENDOR_MAX_LEN] =3D {0};=0D
+	const char *port_type =3D "Unknown port type";=0D
+	int i;=0D
+	int err =3D 0;=0D
+	if (port_info->gpio_insert) {=0D
+		PMD_DRV_LOG(INFO, "Cable unpresent");=0D
+		return;=0D
+	}=0D
+=0D
+	get_port_type(port_info, &port_type);=0D
+=0D
+	for (i =3D (int)sizeof(port_info->vendor_name) - 1; i >=3D 0; i--) {=0D
+		if (port_info->vendor_name[i] =3D=3D ' ')=0D
+			port_info->vendor_name[i] =3D '\0';=0D
+		else=0D
+			break;=0D
+	}=0D
+=0D
+	memcpy(tmp_vendor, port_info->vendor_name,=0D
+	       sizeof(port_info->vendor_name));=0D
+	snprintf(tmp_str, CAP_INFO_MAX_LEN - 1,=0D
+		     "Vendor: %s, %s, length: %um, max_speed: %uGbps",=0D
+		     tmp_vendor, port_type, port_info->cable_length,=0D
+		     port_info->max_speed);=0D
+=0D
+	if (port_info->port_type =3D=3D LINK_PORT_OPTICAL_MM ||=0D
+	    port_info->port_type =3D=3D LINK_PORT_AOC) {=0D
+		err =3D get_port_temperature_power(port_info, tmp_str);=0D
+		if (err)=0D
+			return;=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(INFO, "Cable information: %s", tmp_str);=0D
+}=0D
+=0D
+static void=0D
+print_link_info(struct mag_cmd_event_port_info *port_info)=0D
+{=0D
+	const char *fec =3D "None";=0D
+	const char *speed =3D "None";=0D
+	const char *an_state =3D "None";=0D
+=0D
+	if (port_info->fec < HILINK_FEC_MAX_TYPE)=0D
+		fec =3D g_hw_to_char_fec[port_info->fec];=0D
+	else=0D
+		PMD_DRV_LOG(INFO, "Unknown fec type: %u", port_info->fec);=0D
+=0D
+	if (port_info->an_state > PORT_CFG_AN_OFF) {=0D
+		PMD_DRV_LOG(INFO, "an_state %u is invalid",=0D
+			    port_info->an_state);=0D
+		return;=0D
+	}=0D
+=0D
+	an_state =3D g_hw_to_an_state_info[port_info->an_state];=0D
+=0D
+	if (port_info->speed >=3D PORT_SPEED_UNKNOWN) {=0D
+		PMD_DRV_LOG(INFO, "speed %u is invalid", port_info->speed);=0D
+		return;=0D
+	}=0D
+=0D
+	speed =3D g_hw_to_speed_info[port_info->speed];=0D
+	PMD_DRV_LOG(INFO, "Link information: speed %s, %s, autoneg %s", speed,=0D
+		    fec, an_state);=0D
+}=0D
+=0D
+static void=0D
+print_port_info(void *hwdev, struct mag_cmd_event_port_info *port_info, u8=
 type)=0D
+{=0D
+	print_cable_info(port_info);=0D
+=0D
+	print_link_info(port_info);=0D
+=0D
+	if (type =3D=3D RTE_ETH_LINK_UP)=0D
+		return;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Function %d link down msg:",=0D
+		    hinic3_global_func_id(hwdev));=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "PMA ctrl: %s, tx %s, rx %s, PMA fifo reg: 0x%x, "=0D
+		    "PMA signal ok reg: 0x%x, RF/LF status reg: 0x%x",=0D
+		    port_info->pma_ctrl =3D=3D 1 ? "off" : "on",=0D
+		    port_info->tx_enable ? "enable" : "disable",=0D
+		    port_info->rx_enable ? "enable" : "disable",=0D
+		    port_info->pma_fifo_reg, port_info->pma_signal_ok_reg,=0D
+		    port_info->rf_lf);=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "alos: %u, rx_los: %u, PCS 64 66b reg: 0x%x, "=0D
+		    "PCS link: 0x%x, MAC link: 0x%x, PCS_err_cnt: 0x%x",=0D
+		    port_info->alos, port_info->rx_los,=0D
+		    port_info->pcs_64_66b_reg, port_info->pcs_link,=0D
+		    port_info->pcs_mac_link, port_info->pcs_err_cnt);=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "his_link_machine_state =3D 0x%08x, "=0D
+		    "cur_link_machine_state =3D 0x%08x",=0D
+		    port_info->his_link_machine_state,=0D
+		    port_info->cur_link_machine_state);=0D
+}=0D
+=0D
+static void=0D
+port_info_event_printf(void *hwdev, void *buf_in, __rte_unused u16 in_size=
,=0D
+		       __rte_unused void *buf_out, __rte_unused u16 *out_size)=0D
+{=0D
+	struct mag_cmd_event_port_info *port_info =3D buf_in;=0D
+	((struct mag_cmd_event_port_info *)buf_out)->head.status =3D 0;=0D
+	enum hinic3_nic_event_type type =3D port_info->event_type;=0D
+	if (type < RTE_ETH_LINK_DOWN || type > RTE_ETH_LINK_UP) {=0D
+		PMD_DRV_LOG(ERR, "Invalid hilink info report, type: %d",=0D
+			    type);=0D
+		return;=0D
+	}=0D
+=0D
+	print_port_info(hwdev, port_info, type);=0D
+}=0D
+=0D
+struct nic_event_handler {=0D
+	u16 cmd;=0D
+	void (*handler)(void *hwdev, void *buf_in, u16 in_size, void *buf_out,=0D
+			u16 *out_size);=0D
+};=0D
+=0D
+static const struct nic_event_handler nic_cmd_handler[] =3D {};=0D
+=0D
+/**=0D
+ * Handle NIC event based on the provided command.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] cmd=0D
+ * The command associated with the NIC event to be handled.=0D
+ * @param[in] buf_in=0D
+ * The input buffer containing the event data.=0D
+ * @param[in] in_size=0D
+ * The size of the input buffer.=0D
+ * @param[out] buf_out=0D
+ * The output buffer to store the event response.=0D
+ * @param[out] out_size=0D
+ * The size of the output data stored in the output buffer.=0D
+ */=0D
+static void=0D
+nic_event_handler(void *hwdev, u16 cmd, void *buf_in, u16 in_size,=0D
+		  void *buf_out, u16 *out_size)=0D
+{=0D
+	u32 i, size =3D ARRAY_LEN(nic_cmd_handler);=0D
+=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	*out_size =3D 0;=0D
+=0D
+	for (i =3D 0; i < size; i++) {=0D
+		if (cmd =3D=3D nic_cmd_handler[i].cmd) {=0D
+			nic_cmd_handler[i].handler(hwdev, buf_in, in_size,=0D
+						   buf_out, out_size);=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	if (i =3D=3D size)=0D
+		PMD_DRV_LOG(WARNING, "Unsupported nic event cmd(%d) to process",=0D
+			    cmd);=0D
+}=0D
+=0D
+/*=0D
+ * VF handler mbox msg from ppf/pf.=0D
+ * VF link change event.=0D
+ */=0D
+int=0D
+hinic3_vf_event_handler(void *hwdev, __rte_unused void *pri_handle, u16 cm=
d,=0D
+			void *buf_in, u16 in_size, void *buf_out, u16 *out_size)=0D
+{=0D
+	nic_event_handler(hwdev, cmd, buf_in, in_size, buf_out, out_size);=0D
+	return 0;=0D
+}=0D
+=0D
+/* NIC event of PF/PPF handler reported by mgmt cpu. */=0D
+void=0D
+hinic3_pf_event_handler(void *hwdev, __rte_unused void *pri_handle, u16 cm=
d,=0D
+			void *buf_in, u16 in_size, void *buf_out, u16 *out_size)=0D
+{=0D
+	nic_event_handler(hwdev, cmd, buf_in, in_size, buf_out, out_size);=0D
+}=0D
+=0D
+static const struct nic_event_handler mag_cmd_handler[] =3D {=0D
+	{=0D
+		.cmd =3D MAG_CMD_GET_LINK_STATUS,=0D
+		.handler =3D link_status_event_handler,=0D
+	},=0D
+	{=0D
+		.cmd =3D MAG_CMD_EVENT_PORT_INFO,=0D
+		.handler =3D port_info_event_printf,=0D
+	},=0D
+};=0D
+=0D
+static int=0D
+hinic3_mag_event_handler(void *hwdev, u16 cmd, void *buf_in, u16 in_size,=
=0D
+			 void *buf_out, u16 *out_size)=0D
+{=0D
+	u32 size =3D ARRAY_LEN(mag_cmd_handler);=0D
+	u32 i;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	*out_size =3D 0;=0D
+	for (i =3D 0; i < size; i++) {=0D
+		if (cmd =3D=3D mag_cmd_handler[i].cmd) {=0D
+			mag_cmd_handler[i].handler(hwdev, buf_in, in_size,=0D
+						   buf_out, out_size);=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	/* Can't find this event cmd. */=0D
+	if (i =3D=3D size)=0D
+		PMD_DRV_LOG(ERR, "Unsupported mag event, cmd: %u", cmd);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_vf_mag_event_handler(void *hwdev, __rte_unused void *pri_handle, u1=
6 cmd,=0D
+			    void *buf_in, u16 in_size, void *buf_out,=0D
+			    u16 *out_size)=0D
+{=0D
+	return hinic3_mag_event_handler(hwdev, cmd, buf_in, in_size, buf_out,=0D
+					out_size);=0D
+}=0D
+=0D
+/* pf/ppf handler mgmt cpu report hilink event. */=0D
+void=0D
+hinic3_pf_mag_event_handler(void *hwdev, __rte_unused void *pri_handle, u1=
6 cmd,=0D
+			    void *buf_in, u16 in_size, void *buf_out,=0D
+			    u16 *out_size)=0D
+{=0D
+	hinic3_mag_event_handler(hwdev, cmd, buf_in, in_size, buf_out,=0D
+				 out_size);=0D
+}=0D
+=0D
+u8=0D
+hinic3_nic_sw_aeqe_handler(__rte_unused void *hwdev, u8 event, u8 *data)=0D
+{=0D
+	PMD_DRV_LOG(ERR,=0D
+		    "Received nic ucode aeq event type: 0x%x, data: %" PRIu64,=0D
+		    event, *((u64 *)data));=0D
+=0D
+	return 0;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.h b/drivers/net/hinic=
3/base/hinic3_nic_event.h=0D
new file mode 100644=0D
index 0000000000..6a792e6af5=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_event.h=0D
@@ -0,0 +1,39 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_NIC_EVENT_H_=0D
+#define _HINIC3_NIC_EVENT_H_=0D
+=0D
+/**=0D
+ * Get the Ethernet port link information based on the link state.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The hardware device context.=0D
+ * @param[in] link_state=0D
+ * The current link state (0 =3D down, non-zero =3D up).=0D
+ * @param[out] link=0D
+ * Pointer to the `rte_eth_link` structure.=0D
+ */=0D
+void get_port_info(struct hinic3_hwdev *hwdev, u8 link_state,=0D
+		   struct rte_eth_link *link);=0D
+=0D
+int hinic3_vf_event_handler(void *hwdev, __rte_unused void *pri_handle, u1=
6 cmd,=0D
+			    void *buf_in, u16 in_size, void *buf_out,=0D
+			    u16 *out_size);=0D
+=0D
+void hinic3_pf_event_handler(void *hwdev, __rte_unused void *pri_handle,=0D
+			     u16 cmd, void *buf_in, u16 in_size, void *buf_out,=0D
+			     u16 *out_size);=0D
+=0D
+int hinic3_vf_mag_event_handler(void *hwdev, void *pri_handle, u16 cmd,=0D
+				void *buf_in, u16 in_size, void *buf_out,=0D
+				u16 *out_size);=0D
+=0D
+void hinic3_pf_mag_event_handler(void *hwdev, void *pri_handle, u16 cmd,=0D
+				 void *buf_in, u16 in_size, void *buf_out,=0D
+				 u16 *out_size);=0D
+=0D
+u8 hinic3_nic_sw_aeqe_handler(__rte_unused void *hwdev, u8 event, u8 *data=
);=0D
+=0D
+#endif /* _HINIC3_NIC_EVENT_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

