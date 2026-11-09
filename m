Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA65606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=NyczWrVz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 458E540EA5;
	Mon,  9 Nov 2026 17:21:05 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 9123D40A67
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=jaHotJJTU7lEK0ypmyBxsnTStBRpvh51qA0eTPD/zTE=;
 b=NyczWrVz/QPVWiyCMwomAattpxjV1abvOL8KcPUHMUrg3uF6wMnf3rVVWR59eu
 jDmaUgX0dkr3Z/9ia9eyO5ZP2IkgjYpQu4PbIgvneiFumamQsXXLie52DP+rdQPy
 Ty9BBLbq7of/VTIBDbeoJJZQPw+8D3sle/A0Vnb78/SeQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 13/28] net/hinic3: add FEC mode get/set and capability
 support
Date: Tue, 10 Nov 2026 00:20:17 +0800
Message-ID: <20261109162033.1144-14-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S15
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cr4UZw1UuF48Gw4xAryftFb_yoW8JFyxKo
 WxJr4aqr1Yqr4xCFyjvr1vyFnrXr1q9rn5G39xCF43uan29ry8Ga43XFnaya47Zw4rAry3
 Ca48t3yftw4vg3sxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNAcNF2rx8ucJoQAA3P
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

High-speed links need a configurable FEC mode to interoperate with the
peer, so add FEC get/set/capability callbacks. The advertised/supported
FEC values are converted between the firmware and DPDK representations.

When no FEC mode has been forced firmware reports
HINIC3_PORT_FEC_NOT_SET. Map that to RTE_ETH_FEC_MODE_CAPA_MASK(AUTO) for
rte_eth_fec_get() instead of returning 0, which is not a valid mode mask.
Reject out-of-range firmware values and an empty converted mask so an
unknown value is not reported as a valid mode.

AUTO itself is not settable through the PMD: the firmware rejects a
request to configure auto negotiation (management status 0x10). Keep
rejecting AUTO in fec_set, mask it out of the reported capabilities, and
report the state when the firmware rejects a forced mode because
hinicadm5 has the port in AUTO.

rte_eth_fec_get_capability() expects a too small array to return the
required entry count rather than an error, so return
HINIC3_FEC_CAPA_NUM_PER_SPEED in that case. Also validate out_size in the
FEC mgmt helpers, as the other mgmt helpers in that file do.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/features/hinic3.ini      |   1 +
 doc/guides/rel_notes/release_26_11.rst   |   1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 124 +++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h |  32 ++++++
 drivers/net/hinic3/hinic3_ethdev.c       | 130 +++++++++++++++++++++++
 5 files changed, 288 insertions(+)

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index 3405a837bf..dc4a92fc41 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -25,6 +25,7 @@ VLAN filter          = Y
 Flow control         = Y
 CRC offload          = Y
 VLAN offload         = Y
+FEC                  = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Inner L3 checksum    = P
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e0c0e700a7..8a353476e5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -166,6 +166,7 @@ New Features
 * **Updated Huawei hinic3 ethernet driver.**
 
   * Added CIR drop statistics and VF link aggregation (LAG) support.
+  * Added FEC mode get and set support.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 853ca0a41b..5fcc641ac3 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -1753,6 +1753,130 @@ hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 	return follow.head.status;
 }
 
+static void
+hinic3_fec_param_convert(uint32_t opcode, uint8_t in_fec_param, uint8_t *out_fec_param)
+{
+	uint8_t fec_value_table_length;
+	uint8_t i;
+
+	struct hinic3_fec_param_value_map fec_value_table[] = {
+		{HINIC3_PORT_FEC_NOT_SET, RTE_BIT32(HINIC3_PORT_FEC_NOT_SET),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(AUTO)},
+		{HINIC3_PORT_FEC_RSFEC, RTE_BIT32(HINIC3_PORT_FEC_RSFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(RS)},
+		{HINIC3_PORT_FEC_BASEFEC, RTE_BIT32(HINIC3_PORT_FEC_BASEFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(BASER)},
+		{HINIC3_PORT_FEC_NOFEC, RTE_BIT32(HINIC3_PORT_FEC_NOFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC)},
+		{HINIC3_PORT_FEC_LLRSFEC, RTE_BIT32(HINIC3_PORT_FEC_LLRSFEC),
+		 RTE_ETH_FEC_MODE_CAPA_MASK(LLRS)}
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
+	if (err || !out_size || fec_msg.head.status) {
+		PMD_DRV_LOG(ERR, "Failed to set fec mode, err: %d, status: 0x%x, out size: 0x%x",
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
+	if (err || !out_size || fec_msg.head.status) {
+		PMD_DRV_LOG(ERR, "Failed to get fec mode, err: %d, status: 0x%x, out size: 0x%x",
+			    err, fec_msg.head.status, out_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * Reject out-of-range values instead of turning them into an invalid
+	 * DPDK mode mask. advertised_fec is an enum, supported_fec is a bitmap
+	 * of the same values.
+	 */
+	if ((advertised_fec != NULL &&
+	     fec_msg.advertised_fec > HINIC3_PORT_FEC_LLRSFEC) ||
+	    (supported_fec != NULL &&
+	     (fec_msg.supported_fec & ~((1U << (HINIC3_PORT_FEC_LLRSFEC + 1)) - 1)) != 0))
+		return -EINVAL;
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
index 6fb56fff4f..9458a576c4 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -967,6 +967,33 @@ int hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod
 
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
@@ -1583,4 +1610,9 @@ int hinic3_get_cir_drop(void *hwdev, struct hinic3_cir_drop *stats);
 
 bool hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode);
 
+int hinic3_set_fec_mode(struct hinic3_hwdev *hwdev, uint8_t fecparam);
+
+int hinic3_get_fec_mode(struct hinic3_hwdev *hwdev, uint8_t *advertised_fec,
+			uint8_t *supported_fec);
+
 #endif /* _HINIC3_NIC_CFG_H_ */
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 46cc19613a..a076c8ebb2 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3406,6 +3406,133 @@ hinic3_dev_filter_ctrl(struct rte_eth_dev *dev, const struct rte_flow_ops **arg)
 	return 0;
 }
 
+static const uint32_t HINIC3_FEC_CAPA_NUM_PER_SPEED = 1;
+
+static const uint32_t hinic3_speed_capa[] = {
+	RTE_ETH_SPEED_NUM_NONE, RTE_ETH_SPEED_NUM_10M,
+	RTE_ETH_SPEED_NUM_100M, RTE_ETH_SPEED_NUM_1G,
+	RTE_ETH_SPEED_NUM_10G, RTE_ETH_SPEED_NUM_25G,
+	RTE_ETH_SPEED_NUM_40G, RTE_ETH_SPEED_NUM_50G,
+	RTE_ETH_SPEED_NUM_100G, RTE_ETH_SPEED_NUM_200G,
+	RTE_ETH_SPEED_NUM_400G, RTE_ETH_SPEED_NUM_800G
+};
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
+	if (!hinic3_fec_param_valid(fec_capa)) {
+		if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(AUTO))
+			PMD_DRV_LOG(ERR,
+				    "Unsupported fec param 0x%x, AUTO is configured by hinicadm5.",
+				    fec_capa);
+		else
+			PMD_DRV_LOG(ERR, "Unsupported fec param 0x%x.", fec_capa);
+		return -EINVAL;
+	}
+
+	err = hinic3_set_fec_mode(nic_dev->hwdev, (uint8_t)fec_capa);
+	if (err) {
+		/*
+		 * A forced FEC mode can only be configured after
+		 * auto-negotiation is disabled with the hinicadm5 tool.
+		 * While auto-negotiation is on, the firmware rejects the SET
+		 * request (management status 0x10), and the PMD has no way to
+		 * toggle it. The firmware also reports the negotiated mode on
+		 * GET, so the AUTO state cannot be detected before the attempt.
+		 */
+		PMD_DRV_LOG(ERR,
+			    "Failed to set fec param 0x%x, err %d (AUTO is managed by hinicadm5).",
+			    fec_capa, err);
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
+		PMD_DRV_LOG(ERR, "Get fec param failed: %d.", err);
+		return err;
+	}
+
+	if (advertised_fec == 0) {
+		PMD_DRV_LOG(ERR, "Firmware reported an unknown FEC mode.");
+		return -EINVAL;
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
+	struct nic_port_info port_info = { 0 };
+	uint8_t supported_fec = 0;
+	int err;
+
+	if (speed_fec_capa == NULL)
+		return HINIC3_FEC_CAPA_NUM_PER_SPEED;
+
+	if (num < HINIC3_FEC_CAPA_NUM_PER_SPEED) {
+		PMD_DRV_LOG(ERR, "Not enough array size(%u) to store FEC capabilities, should not be less than %u.",
+			    num, HINIC3_FEC_CAPA_NUM_PER_SPEED);
+		return HINIC3_FEC_CAPA_NUM_PER_SPEED;
+	}
+
+	err = hinic3_get_fec_mode(nic_dev->hwdev, NULL, &supported_fec);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed to get fec capability, err: %d.", err);
+		return err;
+	}
+
+	err = hinic3_get_port_info(nic_dev->hwdev, &port_info);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed to get port info, err: %d.", err);
+		return err;
+	}
+
+	if (port_info.speed >= RTE_DIM(hinic3_speed_capa))
+		return -EINVAL;
+
+	speed_fec_capa->speed = hinic3_speed_capa[port_info.speed];
+	/* AUTO is managed by hinicadm5 and cannot be set through the PMD. */
+	speed_fec_capa->capa = (uint32_t)supported_fec &
+			       ~RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+
+	if (speed_fec_capa->capa == 0)
+		return -ENOTSUP;
+
+	return HINIC3_FEC_CAPA_NUM_PER_SPEED;
+}
+
 static const struct eth_dev_ops hinic3_pmd_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
@@ -3452,6 +3579,9 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
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

