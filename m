Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA223CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 648CC40BA2;
	Wed, 14 Oct 2026 17:09:55 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id DCB6E40687
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=fcPmC9xlYbPSyEMIlLXi5yGVGbwMCmXDsBlMjioiUeE=;
 b=cyxwtKI4lABPb/ONVYvxTrMyZPBEvbpUULZ9n2TlZyv7pb/wBaH5/4mqfNHFPA
 AQ/SRerIbZXPmVV9hl53QXl5KTUUxRf/MDkicHPhf4YJaBelKzikSttfoI7yveoM
 xzZ/StJiOGMdHSZgkUpN0Gb+08lomqS2Jsb55SyPMANsU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 09/26] net/hinic3: add FEC mode get/set and capability
 support
Date: Wed, 14 Oct 2026 23:09:05 +0800
Message-ID: <20261014150923.838-10-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S11
X-Coremail-Antispam: 1Uf129KBjvJXoW3CryfWr1xZFW5GFWUXr18Zrb_yoWDAw18pa
 1UGF98Jr98GF4xZrnxJwsrA3W5Gw1fJ3y0qa4IkFySkan2vr40vFy5Ja9FvF13KrW7Xa4x
 ZF4qgFWDKw4Fqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UR7KsUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhiDjWrPmzgfbgAA3X
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

High-speed links need a configurable FEC mode to interoperate with the
peer, so add FEC get/set/capability callbacks. The advertised/supported
FEC values are converted between the firmware and DPDK representations.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/features/hinic3.ini      |   1 +
 doc/guides/rel_notes/release_26_11.rst   |   1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 114 +++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h |  33 +++++++
 drivers/net/hinic3/hinic3_ethdev.c       |  90 ++++++++++++++++++
 5 files changed, 239 insertions(+)

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index 6cdd240a82..8083dc63d1 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -26,6 +26,7 @@ Flow control         = Y
 CRC offload          = Y
 VLAN offload         = Y
 QinQ offload         = P
+FEC                  = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Inner L3 checksum    = P
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 606a201ae9..06312632d0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -117,6 +117,7 @@ New Features
 * **Updated Huawei hinic3 ethernet driver.**
 
   * Added CIR drop statistics and VF link aggregation (LAG) support.
+  * Added FEC mode get and set support.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 1c0e6df081..520ee1e2a2 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -1755,6 +1755,120 @@ hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 	return follow.head.status;
 }
 
+static void
+hinic3_fec_param_convert(uint32_t opcode, uint8_t in_fec_param, uint8_t *out_fec_param)
+{
+	uint8_t fec_value_table_length;
+	uint8_t i;
+
+	struct hinic3_fec_param_value_map fec_value_table[] = {
+		{HINIC3_PORT_FEC_NOT_SET, RTE_BIT32(HINIC3_PORT_FEC_NOT_SET), 0},
+		{HINIC3_PORT_FEC_RSFEC, RTE_BIT32(HINIC3_PORT_FEC_RSFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(RS)},
+		{HINIC3_PORT_FEC_BASEFEC, RTE_BIT32(HINIC3_PORT_FEC_BASEFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(BASER)},
+		{HINIC3_PORT_FEC_NOFEC, RTE_BIT32(HINIC3_PORT_FEC_NOFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC)},
+		{HINIC3_PORT_FEC_LLRSFEC, RTE_BIT32(HINIC3_PORT_FEC_LLRSFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(LLRS)},
+		{HINIC3_PORT_FEC_AUTO, RTE_BIT32(HINIC3_PORT_FEC_AUTO),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(AUTO)}
+	};
+
+	*out_fec_param = 0;
+	fec_value_table_length =
+		(uint8_t)(sizeof(fec_value_table) / sizeof(struct hinic3_fec_param_value_map));
+
+	if (opcode == HINIC3_FEC_MODE_OPCODE_SET) {
+		for (i = 0; i < fec_value_table_length; i++) {
+			if ((in_fec_param & fec_value_table[i].ethtool_fec_value) != 0)
+				*out_fec_param = fec_value_table[i].fec_offset;
+		}
+	}
+
+	if (opcode == HINIC3_FEC_MODE_OPCODE_GET) {
+		for (i = 0; i < fec_value_table_length; i++) {
+			if ((in_fec_param & fec_value_table[i].hinic3_fec_value) != 0)
+				*out_fec_param |= fec_value_table[i].ethtool_fec_value;
+		}
+	}
+}
+
+int
+hinic3_set_fec_mode(struct hinic3_hwdev *hwdev, uint8_t fecparam)
+{
+	struct mag_cmd_cfg_fec_mode fec_msg = { 0 };
+	uint16_t out_size = sizeof(fec_msg);
+	uint8_t advertised_fec = 0;
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	hinic3_fec_param_convert(HINIC3_FEC_MODE_OPCODE_SET, fecparam, &advertised_fec);
+	fec_msg.opcode = HINIC3_FEC_MODE_OPCODE_SET;
+	fec_msg.port_id = hinic3_physical_port_id(hwdev);
+	fec_msg.advertised_fec = advertised_fec;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK,
+				      MAG_CMD_CFG_FEC_MODE,
+				      &fec_msg, sizeof(fec_msg),
+				      &fec_msg, &out_size);
+
+	if (fec_msg.head.status != 0 || err) {
+		PMD_DRV_LOG(ERR, "Failed to set fec mode failed, err: %d, status: 0x%x, out size: 0x%x",
+			    err, fec_msg.head.status, out_size);
+		return -EINVAL;
+	}
+
+	PMD_DRV_LOG(INFO, "Set fec mode success, active fec capa mode: %d", fecparam);
+	return 0;
+}
+
+int
+hinic3_get_fec_mode(struct hinic3_hwdev *hwdev, uint8_t *advertised_fec,
+		    uint8_t *supported_fec)
+{
+	struct mag_cmd_cfg_fec_mode fec_msg = { 0 };
+	uint16_t out_size = sizeof(fec_msg);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	if (advertised_fec != NULL)
+		*advertised_fec = 0;
+
+	if (supported_fec != NULL)
+		*supported_fec = 0;
+
+	fec_msg.opcode = HINIC3_FEC_MODE_OPCODE_GET;
+	fec_msg.port_id = hinic3_physical_port_id(hwdev);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK,
+				      MAG_CMD_CFG_FEC_MODE,
+				      &fec_msg, sizeof(fec_msg),
+				      &fec_msg, &out_size);
+
+	if (fec_msg.head.status != 0 || err) {
+		PMD_DRV_LOG(ERR, "Failed to get fec mode failed, err: %d, status: 0x%x, out size: 0x%x",
+			    err, fec_msg.head.status, out_size);
+		return -EINVAL;
+	}
+
+	if (advertised_fec != NULL)
+		hinic3_fec_param_convert(HINIC3_FEC_MODE_OPCODE_GET,
+					RTE_BIT32(fec_msg.advertised_fec),
+					advertised_fec);
+
+	if (supported_fec != NULL)
+		hinic3_fec_param_convert(HINIC3_FEC_MODE_OPCODE_GET,
+					fec_msg.supported_fec,
+					supported_fec);
+
+	return 0;
+}
+
 bool
 hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode)
 {
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 6fb56fff4f..4d4cb2d8cb 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -967,6 +967,34 @@ int hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod
 
 int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr);
 
+enum hinic3_fec_mode_opcode {
+	HINIC3_FEC_MODE_OPCODE_GET = 0,
+	HINIC3_FEC_MODE_OPCODE_SET = 1,
+};
+
+struct mag_cmd_cfg_fec_mode {
+	struct mgmt_msg_head head;
+	uint8_t port_id;
+	uint8_t opcode;
+	uint8_t advertised_fec;
+	uint8_t supported_fec;
+};
+
+enum hinic3_cmd_port_fec {
+	HINIC3_PORT_FEC_NOT_SET = 0,
+	HINIC3_PORT_FEC_RSFEC = 1,
+	HINIC3_PORT_FEC_BASEFEC = 2,
+	HINIC3_PORT_FEC_NOFEC = 3,
+	HINIC3_PORT_FEC_LLRSFEC = 4,
+	HINIC3_PORT_FEC_AUTO = 5,
+};
+
+struct hinic3_fec_param_value_map {
+	uint8_t fec_offset;
+	uint8_t hinic3_fec_value;
+	uint8_t ethtool_fec_value;
+};
+
 /**
  * Update MAC address to hardware.
  *
@@ -1583,4 +1611,9 @@ int hinic3_get_cir_drop(void *hwdev, struct hinic3_cir_drop *stats);
 
 bool hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode);
 
+int hinic3_set_fec_mode(struct hinic3_hwdev *hwdev, uint8_t fecparam);
+
+int hinic3_get_fec_mode(struct hinic3_hwdev *hwdev, uint8_t *advertised_fec,
+			uint8_t *supported_fec);
+
 #endif /* _HINIC3_NIC_CFG_H_ */
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 6dd617f6d1..f09b6248a7 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3358,6 +3358,93 @@ hinic3_dev_filter_ctrl(struct rte_eth_dev *dev, const struct rte_flow_ops **arg)
 	return 0;
 }
 
+static const uint32_t HINIC3_FEC_CAPA_NUM_PER_SPEED = 1;
+
+static bool
+hinic3_fec_param_valid(uint32_t fec_param)
+{
+	if (fec_param == RTE_ETH_FEC_MODE_CAPA_MASK(LLRS) ||
+	    fec_param == RTE_ETH_FEC_MODE_CAPA_MASK(RS) ||
+	    fec_param == RTE_ETH_FEC_MODE_CAPA_MASK(BASER) ||
+	    fec_param == RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC)) {
+		return true;
+	}
+
+	return false;
+}
+
+static int
+hinic3_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int err;
+
+	if (hinic3_fec_param_valid(fec_capa) == false) {
+		PMD_DRV_LOG(ERR, "Fec param is invalid, failed to set fec param.");
+		return -EINVAL;
+	}
+
+	err = hinic3_set_fec_mode(nic_dev->hwdev, (uint8_t)fec_capa);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set fec param failed: %d.", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint8_t advertised_fec = 0;
+	int err;
+
+	err = hinic3_get_fec_mode(nic_dev->hwdev, &advertised_fec, NULL);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get fec parma failed: %d.", err);
+		return err;
+	}
+
+	*fec_capa = (uint32_t)advertised_fec;
+
+	return 0;
+}
+
+static int
+hinic3_fec_capability_get(struct rte_eth_dev *dev,
+			  struct rte_eth_fec_capa *speed_fec_capa,
+			  unsigned int num)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint8_t supported_fec = 0;
+	int err;
+
+	if (speed_fec_capa == NULL)
+		return HINIC3_FEC_CAPA_NUM_PER_SPEED;
+
+	if (num < HINIC3_FEC_CAPA_NUM_PER_SPEED) {
+		PMD_DRV_LOG(ERR, "Not enough array size(%u) to store FEC capabilities, should not be less than %u.",
+			    num, HINIC3_FEC_CAPA_NUM_PER_SPEED);
+		return -EINVAL;
+	}
+
+	err = hinic3_get_fec_mode(nic_dev->hwdev, NULL, &supported_fec);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed to get fec capability, err: %d.", err);
+		return err;
+	}
+
+	speed_fec_capa->speed = dev->data->dev_link.link_speed;
+	speed_fec_capa->capa = (uint32_t)supported_fec;
+
+	if (speed_fec_capa->speed == RTE_ETH_SPEED_NUM_NONE ||
+		speed_fec_capa->capa == 0)
+		return -ENOTSUP;
+
+	return HINIC3_FEC_CAPA_NUM_PER_SPEED;
+}
+
 static const struct eth_dev_ops hinic3_pmd_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
@@ -3404,6 +3491,9 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.fec_get_capability            = hinic3_fec_capability_get,
+	.fec_get                       = hinic3_fec_get,
+	.fec_set                       = hinic3_fec_set,
 };
 
 static const struct eth_dev_ops hinic3_pmd_vf_ops = {
-- 
2.33.0

