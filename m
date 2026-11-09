Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9596606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=CjB9b/+E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33C124113D;
	Mon,  9 Nov 2026 17:21:14 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTPS id 9E9C240A84
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=bwJuDysf8S3wF5Fzzzp1TLQ4C3HHaeF+43PtbOivIHg=;
 b=CjB9b/+E5wNR+1cFjDzf/JsdsrAupl8DElXfKzyywa2IvngvVkcHptr8Q3VIej
 wii5Ri7YJ9FH+AIys3Rd1kwN9J4in8Q9DU2+o/hd1aZPjWMyxCTWTOe5iO8/F3PD
 VvceIMDjotLr08fXEHu0Xu0VQoQiWmlj4GiKXxvmiLTDg=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 20/28] net/hinic3: add SP560 NIC type identification and
 handling
Date: Tue, 10 Nov 2026 00:20:24 +0800
Message-ID: <20261109162033.1144-21-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S22
X-Coremail-Antispam: 1Uf129KBjvAXoWfArykAFW8trWkWw1UuFykXwb_yoW5tw13Zo
 WftF1Svw1xJr1xCF90gw4DtayDA34kXan5Ja9xWF9IgFy7GF1UGas8Aw4F93Wagw4rC3W3
 AFn7KF90y3yDZ3y5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrUUUDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwkOGGrx8ukPTwAA3o
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

Identify the new SP560 NIC through its PCI device ID and select NIC-type
specific operations, and add 400G/800G line rate support. Enable the
software compact CQE feature for the SP560.

Split prefetch, packet-drop, and CEQ context setup into per-tile cmdq ops,
so the SP560 stn tile can configure its own prefetch and coalescing
parameters, distinct from the htn tile used by the SP230. The htn ops also
move the SP230 queue context to the tile-recommended values: drop
threshold off 0xFFFF, SQ prefetch 4/5/48, RQ prefetch 2/4/32 and PFH_TH 7,
replacing the generic values inherited from the shared code.

The SW compact CQE path keeps Rx interrupts usable: when it is active, the
RQ CEQ EN bit enables the compact CEQ context instead of masking
interrupts, and interrupt delivery is controlled by the vector number in
the INTR field. The NIC therefore keeps advertising Rx interrupt support.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/hinic3.rst                    |   2 +-
 doc/guides/rel_notes/release_26_11.rst        |   1 +
 drivers/net/hinic3/base/hinic3_csr.h          |   4 +
 drivers/net/hinic3/base/hinic3_hwif.c         |   4 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |   3 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |   6 +
 drivers/net/hinic3/base/hinic3_nic_event.c    |  62 +++++++-
 drivers/net/hinic3/hinic3_ethdev.c            |  20 ++-
 drivers/net/hinic3/hinic3_ethdev.h            |   6 +-
 drivers/net/hinic3/hinic3_nic_io.c            | 132 ++++--------------
 drivers/net/hinic3/hinic3_nic_io.h            |  87 ++++++++++++
 drivers/net/hinic3/hinic3_rx.c                |  19 +++
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  48 +++++++
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |  57 ++++++++
 14 files changed, 332 insertions(+), 119 deletions(-)

diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
index d07e8605c0..bc518ce7fc 100644
--- a/doc/guides/nics/hinic3.rst
+++ b/doc/guides/nics/hinic3.rst
@@ -5,7 +5,7 @@ HINIC3 Poll Mode Driver
 =======================
 
 The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
-for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
+for 25Gbps/100Gbps/200Gbps/400Gbps Huawei SP230, SP560 and SP620 series Network Adapters.
 
 
 Features
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e13a54d7b3..059fd29035 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -170,6 +170,7 @@ New Features
   * Added Class of Service (COS) mask and map support.
   * Updated RSS hash type configuration.
   * Added mailbox message counter reporting through the device private dump API.
+  * Added support for the SP560 NIC.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index 7cae2419c0..82f20e2ea7 100644
--- a/drivers/net/hinic3/base/hinic3_csr.h
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -15,6 +15,10 @@
 
 #define HINIC3_DEV_ID_SP920	0x0224
 
+#define HINIC3_DEV_ID_SP560		0x0230
+#define HINIC3_DEV_ID_VF_SP560		0x0231
+#define HINIC3_DEV_ID_HYPER_VF_SP560	0x0232
+
 /*
  * Bit30/bit31 for bar index flag.
  * 00: bar0
diff --git a/drivers/net/hinic3/base/hinic3_hwif.c b/drivers/net/hinic3/base/hinic3_hwif.c
index c82b223fa0..af1dddabf4 100644
--- a/drivers/net/hinic3/base/hinic3_hwif.c
+++ b/drivers/net/hinic3/base/hinic3_hwif.c
@@ -141,7 +141,9 @@
 static inline bool hinic3_is_vf_dev(const struct rte_pci_device *pdev)
 {
 	return pdev->id.device_id == HINIC3_DEV_ID_VF_SP620 ||
-	       pdev->id.device_id == HINIC3_DEV_ID_VF_SP230;
+	       pdev->id.device_id == HINIC3_DEV_ID_VF_SP230 ||
+	       pdev->id.device_id == HINIC3_DEV_ID_VF_SP560 ||
+	       pdev->id.device_id == HINIC3_DEV_ID_HYPER_VF_SP560;
 }
 
 uint32_t
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 3ba8b9bd41..7766acfb87 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -455,7 +455,8 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 	en_state.func_id = hinic3_global_func_id(hwdev);
 	en_state.state = enable ? 1 : 0;
 	en_state.num_qps = nic_dev->num_rqs;
-	en_state.rx_compact_wqe_en = HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev);
+	en_state.rx_compact_wqe_en = HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+				     HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev);
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 8c48f6d8a9..d7e7adf7be 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -62,6 +62,8 @@
 	((hinic3_get_driver_feature(dev) & NIC_F_##feature) != 0)
 #define HINIC3_SUPPORT_RX_HW_COMPACT_CQE(dev) \
 	HINIC3_SUPPORT_FEATURE(dev, RX_HW_COMPACT_CQE)
+#define HINIC3_SUPPORT_RX_SW_COMPACT_CQE(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, RX_SW_COMPACT_CQE)
 #define HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(dev) \
 	HINIC3_SUPPORT_FEATURE(dev, TX_WQE_COMPACT_TASK)
 #define HINIC3_SUPPORT_VXLAN_OFFLOAD(dev) \
@@ -126,6 +128,8 @@ enum nic_speed_level {
 	LINK_SPEED_50GB,
 	LINK_SPEED_100GB,
 	LINK_SPEED_200GB,
+	LINK_SPEED_400GB,
+	LINK_SPEED_800GB,
 	LINK_SPEED_LEVELS,
 };
 
@@ -180,6 +184,8 @@ enum mag_cmd_port_speed {
 	PORT_SPEED_50GB    = 7,
 	PORT_SPEED_100GB   = 8,
 	PORT_SPEED_200GB   = 9,
+	PORT_SPEED_400GB   = 10,
+	PORT_SPEED_800GB   = 11,
 	PORT_SPEED_UNKNOWN
 };
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic3/base/hinic3_nic_event.c
index 0fe7b54981..c00b5185f4 100644
--- a/drivers/net/hinic3/base/hinic3_nic_event.c
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c
@@ -15,6 +15,7 @@ static const char *g_hw_to_char_fec[HILINK_FEC_MAX_TYPE] = {
 static const char *g_hw_to_speed_info[PORT_SPEED_UNKNOWN] = {
 	"not set", "10MB", "100MB", "1GB",   "10GB",
 	"25GB",	   "40GB", "50GB",  "100GB", "200GB",
+	"400GB",   "800GB",
 };
 static const char *g_hw_to_an_state_info[PORT_CFG_AN_OFF + 1] = {
 	"not set", "on", "off",
@@ -25,6 +26,37 @@ struct port_type_table {
 	const char *port_type_name;
 };
 
+/*
+ * Hardware cable speed modes.
+ *
+ * The firmware reports the cable speed mode as a uint8_t value. Speeds whose raw
+ * Gbps value cannot be represented in 8 bits (notably 400G and 800G) are
+ * therefore encoded with indirection codes instead, and must be translated
+ * back to their real speeds through speed_mode_map[] below.
+ */
+enum {
+	HW_CABLE_SPEED_MODE_200G = 200,
+	HW_CABLE_SPEED_MODE_400G = 201,
+	HW_CABLE_SPEED_MODE_800G = 202,
+};
+
+/* Real cable speeds in Gbps, as exposed to the upper layer. */
+enum {
+	REAL_CABLE_SPEED_400G    = 400,
+	REAL_CABLE_SPEED_800G    = 800,
+};
+
+/* Mapping between a cable speed mode (uint8_t) and its real speed in Gbps. */
+struct speed_mode_map_entry {
+	uint8_t speed_mode;
+	uint32_t real_speed;
+};
+
+static const struct speed_mode_map_entry speed_mode_map[] = {
+	{HW_CABLE_SPEED_MODE_400G, REAL_CABLE_SPEED_400G},
+	{HW_CABLE_SPEED_MODE_800G, REAL_CABLE_SPEED_800G},
+};
+
 void
 hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, uint8_t link_state,
 	      struct rte_eth_link *link)
@@ -35,6 +67,7 @@ hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, uint8_t link_state,
 		RTE_ETH_SPEED_NUM_10G,	RTE_ETH_SPEED_NUM_25G,
 		RTE_ETH_SPEED_NUM_40G,	RTE_ETH_SPEED_NUM_50G,
 		RTE_ETH_SPEED_NUM_100G, RTE_ETH_SPEED_NUM_200G,
+		RTE_ETH_SPEED_NUM_400G, RTE_ETH_SPEED_NUM_800G
 	};
 	struct nic_port_info port_info = {0};
 	int err;
@@ -53,6 +86,13 @@ hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, uint8_t link_state,
 			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 			link->link_autoneg = RTE_ETH_LINK_FIXED;
 		} else {
+			if (port_info.speed >= LINK_SPEED_LEVELS) {
+				PMD_DRV_LOG(WARNING,
+					"Invalid port speed %u reported by firmware, reset to %u",
+					port_info.speed,
+					port_info.speed % LINK_SPEED_LEVELS);
+			}
+
 			link->link_speed =
 				port_speed[port_info.speed % LINK_SPEED_LEVELS];
 			link->link_duplex = port_info.duplex;
@@ -176,6 +216,22 @@ get_port_temperature_power(struct mag_cmd_event_port_info *info, char *str)
 	return 0;
 }
 
+static uint32_t
+get_real_cable_speed(uint8_t speed)
+{
+	uint32_t i;
+
+	if (speed <= HW_CABLE_SPEED_MODE_200G)
+		return speed;
+	for (i = 0; i < RTE_DIM(speed_mode_map); i++) {
+		if (speed_mode_map[i].speed_mode == speed)
+			return speed_mode_map[i].real_speed;
+	}
+
+	PMD_DRV_LOG(ERR, "unsupported cable speed mode: 0x%x", speed);
+	return speed;
+}
+
 static void
 print_cable_info(struct mag_cmd_event_port_info *port_info)
 {
@@ -201,9 +257,9 @@ print_cable_info(struct mag_cmd_event_port_info *port_info)
 	memcpy(vendor, port_info->vendor_name,
 	       sizeof(port_info->vendor_name));
 	snprintf(str, CAP_INFO_MAX_LEN - 1,
-		     "Vendor: %s, %s, length: %um, max_speed: %uGbps",
-		     vendor, port_type, port_info->cable_length,
-		     port_info->max_speed);
+	     "Vendor: %s, %s, length: %um, max_speed: %uGbps",
+	     vendor, port_type, port_info->cable_length,
+	     get_real_cable_speed(port_info->max_speed));
 
 	if (port_info->port_type == LINK_PORT_OPTICAL_MM ||
 	    port_info->port_type == LINK_PORT_AOC) {
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index d82aa07912..85ad0b327b 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -553,6 +553,10 @@ hinic3_get_nic_type(struct rte_pci_device *pci_dev)
 	case HINIC3_DEV_ID_SP230:
 	case HINIC3_DEV_ID_VF_SP230:
 		return NIC_SP230;
+	case HINIC3_DEV_ID_SP560:
+	case HINIC3_DEV_ID_VF_SP560:
+	case HINIC3_DEV_ID_HYPER_VF_SP560:
+		return NIC_SP560;
 	default:
 		return NIC_UNKNOWN;
 	}
@@ -573,6 +577,7 @@ hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev)
 	static const struct hinic3_nic_cmdq_ops *cmdq_ops[] = {
 		[NIC_SP620]   = &hinic3_stn_cmdq_ops,
 		[NIC_SP230]   = &hinic3_htn_cmdq_ops,
+		[NIC_SP560]   = &hinic3_stn_cmdq_ops,
 		[NIC_UNKNOWN] = &hinic3_stn_cmdq_ops,
 	};
 
@@ -1188,7 +1193,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	}
 
 	/* If NIC support compact CQE, use compact wqe as default. */
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) {
 		rxq->wqe_type = HINIC3_COMPACT_RQ_WQE;
 	} else {
 		if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
@@ -1248,7 +1254,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto alloc_rx_info_fail;
 	}
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) {
 		ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,
 						sizeof(*rxq->rq_ci),
 						RTE_CACHE_LINE_SIZE, (int)socket_id);
@@ -1487,7 +1494,8 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	hinic3_free_rxq_mbufs(rxq);
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev))
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev))
 		hinic3_memzone_free(rxq->ci_mz);
 	else
 		hinic3_memzone_free(rxq->cqe_mz);
@@ -3776,7 +3784,8 @@ static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
 	else
 		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_normal_task_offload;
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) {
 		nic_dev->rx_ops->nic_rx_get_cqe_info = hinic3_rx_get_compact_cqe_info;
 		nic_dev->rx_ops->nic_rx_cqe_done = hinic3_rx_integrated_cqe_done;
 		nic_dev->rx_ops->nic_rx_poll_rq_empty = hinic3_poll_integrated_cqe_rq_empty;
@@ -4066,6 +4075,9 @@ static const struct rte_pci_id pci_id_hinic3_map[] = {
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP230)},
 
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP920)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP560)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP560)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_HYPER_VF_SP560)},
 
 	{.vendor_id = 0},
 };
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 13c9c69e7f..e4f1a5b51c 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -102,7 +102,7 @@ enum nic_feature_cap {
 
 };
 
-#define DEFAULT_DRV_FEATURE		0x3FC3FFF
+#define DEFAULT_DRV_FEATURE		0x0BFC3FFF
 
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
@@ -110,7 +110,8 @@ TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
 enum nic_type {
 	NIC_SP620 = 0,
 	NIC_SP230 = 1,
-	NIC_UNKNOWN = 2,
+	NIC_SP560 = 2,
+	NIC_UNKNOWN = 3,
 };
 
 struct hinic3_nic_dev {
@@ -172,6 +173,7 @@ struct hinic3_nic_dev {
 
 #define HINIC3_IS_SP620_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP620)
 #define HINIC3_IS_SP230_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP230)
+#define HINIC3_IS_SP560_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP560)
 
 extern const struct rte_flow_ops hinic3_flow_ops;
 
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index 361586868e..d4c53645c4 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -13,12 +13,6 @@
 
 #define HINIC3_DEAULT_TX_CI_PENDING_LIMIT	3
 #define HINIC3_DEAULT_TX_CI_COALESCING_TIME	16
-#define HINIC3_DEAULT_DROP_THD_ON		0xFFFF
-#define HINIC3_DEAULT_DROP_THD_OFF		0
-
-#define WQ_PREFETCH_MAX				6
-#define WQ_PREFETCH_MIN				1
-#define WQ_PREFETCH_THRESHOLD			256
 
 #define CI_IDX_HIGH_SHIFH			12
 
@@ -53,16 +47,6 @@
 	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)
 
-#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0
-#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16
-
-#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU
-#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU
-
-#define SQ_CTXT_PKT_DROP_THD_SET(val, member)		\
-	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK)	\
-	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)
-
 #define SQ_CTXT_GLOBAL_SQ_ID_SHIFT		0
 
 #define SQ_CTXT_GLOBAL_SQ_ID_MASK		0x1FFFU
@@ -84,30 +68,6 @@
 	(((val) & SQ_CTXT_VLAN_##member##_MASK)		\
 	 << SQ_CTXT_VLAN_##member##_SHIFT)
 
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
-#define SQ_CTXT_PREF_CACHE_MAX_SHIFT		14
-#define SQ_CTXT_PREF_CACHE_MIN_SHIFT		25
-
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
-#define SQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
-#define SQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
-
-#define SQ_CTXT_PREF_CI_HI_SHIFT		0
-#define SQ_CTXT_PREF_OWNER_SHIFT		4
-
-#define SQ_CTXT_PREF_CI_HI_MASK			0xFU
-#define SQ_CTXT_PREF_OWNER_MASK			0x1U
-
-#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
-#define SQ_CTXT_PREF_CI_LOW_SHIFT		20
-
-#define SQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
-#define SQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
-
-#define SQ_CTXT_PREF_SET(val, member)			\
-	(((val) & SQ_CTXT_PREF_##member##_MASK)		\
-	 << SQ_CTXT_PREF_##member##_SHIFT)
-
 #define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0
 
 #define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU
@@ -125,18 +85,6 @@
 #define RQ_CTXT_CI_PI_SET(val, member)			\
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
 
-#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT		21
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT		30
-#define RQ_CTXT_CEQ_ATTR_EN_SHIFT		31
-
-#define RQ_CTXT_CEQ_ATTR_INTR_MASK		0x3FFU
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK		0x1U
-#define RQ_CTXT_CEQ_ATTR_EN_MASK		0x1U
-
-#define RQ_CTXT_CEQ_ATTR_SET(val, member)		\
-	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK)	\
-	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)
-
 #define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0
 #define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT		28
 #define RQ_CTXT_WQ_PAGE_OWNER_SHIFT		31
@@ -149,37 +97,6 @@
 	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)
 
-#define RQ_CTXT_CQE_LEN_SHIFT			28
-
-#define RQ_CTXT_CQE_LEN_MASK			0x3U
-
-#define RQ_CTXT_CQE_LEN_SET(val, member)		\
-	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
-
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
-#define RQ_CTXT_PREF_CACHE_MAX_SHIFT		14
-#define RQ_CTXT_PREF_CACHE_MIN_SHIFT		25
-
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
-#define RQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
-#define RQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
-
-#define RQ_CTXT_PREF_CI_HI_SHIFT		0
-#define RQ_CTXT_PREF_OWNER_SHIFT		4
-
-#define RQ_CTXT_PREF_CI_HI_MASK			0xFU
-#define RQ_CTXT_PREF_OWNER_MASK			0x1U
-
-#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
-#define RQ_CTXT_PREF_CI_LOW_SHIFT		20
-
-#define RQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
-#define RQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
-
-#define RQ_CTXT_PREF_SET(val, member)			\
-	(((val) & RQ_CTXT_PREF_##member##_MASK)		\
-	 << RQ_CTXT_PREF_##member##_SHIFT)
-
 #define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0
 
 #define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU
@@ -206,6 +123,10 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
 	uint16_t pi_start, ci_start;
 
+	memset(sq_ctxt, 0, sizeof(*sq_ctxt));
+
+	hinic3_cmdq_get_ops(sq->nic_dev)->prepare_sq_ctxt_drop_and_prefetch(sq_ctxt);
+
 	ci_start = sq->cons_idx & sq->q_mask;
 	pi_start = sq->prod_idx & sq->q_mask;
 
@@ -232,10 +153,6 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 
 	sq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
 
-	sq_ctxt->pkt_drop_thd =
-		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
-		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
-
 	sq_ctxt->global_sq_id =
 		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);
 
@@ -245,11 +162,6 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 
 	sq_ctxt->rsvd0 = 0;
 
-	sq_ctxt->pref_cache =
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
-
 	sq_ctxt->pref_ci_owner =
 		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
 		SQ_CTXT_PREF_SET(1, OWNER);
@@ -278,6 +190,9 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 	uint16_t pi_start, ci_start;
 	uint16_t wqe_type = rq->wqe_type;
 	uint8_t intr_disable;
+	bool support_rq_sw_compact_cqe = false;
+
+	memset(rq_ctxt, 0, sizeof(*rq_ctxt));
 
 	/* RQ depth is in unit of 8 Bytes. */
 	ci_start = (uint16_t)((rq->cons_idx & rq->q_mask) << wqe_type);
@@ -292,38 +207,47 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 
 	/* Use 0-level CLA. */
 	wq_block_pfn = WQ_BLOCK_PFN(wq_page_addr);
+
 	wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
 	wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
 
 	rq_ctxt->ci_pi = RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
 			 RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
 
-	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable. */
+	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable */
 	intr_disable = rq->dp_intr_en ? 0 : 1;
-	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |
-			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |
-			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);
+	support_rq_sw_compact_cqe = HINIC3_SUPPORT_RX_SW_COMPACT_CQE(rq->nic_dev);
+	hinic3_cmdq_get_ops(rq->nic_dev)->prepare_rq_ctxt_ceq_and_prefetch(rq_ctxt,
+		wqe_type, rq->msix_entry_idx, support_rq_sw_compact_cqe, intr_disable);
 
-	/* Use 32Byte WQE with SGE for CQE in default. */
+	/* Use 32Byte WQE with SGE for CQE in default */
 	rq_ctxt->wq_pfn_hi_type_owner =
 		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
 		RQ_CTXT_WQ_PAGE_SET(1, OWNER);
+	rq_ctxt->pi_paddr_hi = upper_32_bits(rq->pi_dma_addr);
+	rq_ctxt->pi_paddr_lo = lower_32_bits(rq->pi_dma_addr);
 
 	switch (wqe_type) {
 	case HINIC3_EXTEND_RQ_WQE:
-		/* Use 32Byte WQE with SGE for CQE. */
+		/* Use 32Byte WQE with SGE for CQE */
 		rq_ctxt->wq_pfn_hi_type_owner |=
 			RQ_CTXT_WQ_PAGE_SET(0, WQE_TYPE);
 		break;
 	case HINIC3_NORMAL_RQ_WQE:
-		/* Use 16Byte WQE with 32Bytes SGE for CQE. */
+		/* Use 16Byte WQE with 32Bytes SGE for CQE */
 		rq_ctxt->wq_pfn_hi_type_owner |=
 			RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);
 		rq_ctxt->cqe_sge_len = RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);
 		break;
 	case HINIC3_COMPACT_RQ_WQE:
-		/* Use 8Byte WQE without SGE for CQE. */
+		/* Use 8Byte WQE without SGE for CQE */
 		rq_ctxt->wq_pfn_hi_type_owner |= RQ_CTXT_WQ_PAGE_SET(3, WQE_TYPE);
+		if (HINIC3_SUPPORT_RX_SW_COMPACT_CQE(rq->nic_dev)) {
+			rq_ctxt->cqe_sge_len |=
+				RQ_CTXT_CQE_LEN_SET(RQ_CQE_AGGREGATE_NUM, MAX_COUNT);
+			rq_ctxt->pi_paddr_hi = upper_32_bits(rq->rq_ci_paddr >> RQ_CI_ADDR_SHIFT);
+			rq_ctxt->pi_paddr_lo = lower_32_bits(rq->rq_ci_paddr >> RQ_CI_ADDR_SHIFT);
+		}
 		break;
 	default:
 		PMD_DRV_LOG(INFO, "Invalid rq wqe type: %u", wqe_type);
@@ -331,11 +255,6 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 
 	rq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
 
-	rq_ctxt->pref_cache =
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
-
 	rq_ctxt->pref_ci_owner =
 		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
 		RQ_CTXT_PREF_SET(1, OWNER);
@@ -346,8 +265,7 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 
 	rq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
 
-	rq_ctxt->pi_paddr_hi = upper_32_bits(rq->pi_dma_addr);
-	rq_ctxt->pi_paddr_lo = lower_32_bits(rq->pi_dma_addr);
+
 
 	rq_ctxt->wq_block_pfn_hi =
 		RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
index d7ec81f2e6..3b99c9ba68 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -28,6 +28,81 @@
 
 #define HINIC3_Q_CTXT_MAX ((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))
 
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT		14
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT		25
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
+#define RQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
+#define RQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
+
+#define RQ_CTXT_PREF_CI_HI_SHIFT		0
+#define RQ_CTXT_PREF_OWNER_SHIFT		4
+
+#define RQ_CTXT_PREF_CI_HI_MASK			0xFU
+#define RQ_CTXT_PREF_OWNER_MASK			0x1U
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
+#define RQ_CTXT_PREF_CI_LOW_SHIFT		20
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
+#define RQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
+
+#define RQ_CTXT_PREF_SET(val, member)		(((val) & \
+						RQ_CTXT_PREF_##member##_MASK) << \
+						RQ_CTXT_PREF_##member##_SHIFT)
+
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)	(((val) & \
+						RQ_CTXT_CEQ_ATTR_##member##_MASK) \
+						<< RQ_CTXT_CEQ_ATTR_##member##_SHIFT)
+
+#define RQ_CTXT_CQE_LEN_SHIFT			28
+#define RQ_CTXT_MAX_COUNT_SHIFT			18
+
+#define RQ_CTXT_CQE_LEN_MASK			0x3U
+#define RQ_CTXT_MAX_COUNT_MASK			0x3FFU
+#define RQ_CTXT_CQE_LEN_SET(val, member)	(((val) & \
+						RQ_CTXT_##member##_MASK) << \
+						RQ_CTXT_##member##_SHIFT)
+
+#define SQ_CI_ADDR_SHIFT	2
+#define RQ_CI_ADDR_SHIFT	4
+#define RQ_CQE_AGGREGATE_NUM		768
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT		14
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT		25
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
+#define SQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
+#define SQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
+
+#define SQ_CTXT_PREF_CI_HI_SHIFT		0
+#define SQ_CTXT_PREF_OWNER_SHIFT		4
+
+#define SQ_CTXT_PREF_CI_HI_MASK			0xFU
+#define SQ_CTXT_PREF_OWNER_MASK			0x1U
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
+#define SQ_CTXT_PREF_CI_LOW_SHIFT		20
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
+#define SQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
+
+#define SQ_CTXT_PREF_SET(val, member)		(((val) & \
+						SQ_CTXT_PREF_##member##_MASK) \
+						<< SQ_CTXT_PREF_##member##_SHIFT)
+
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16
+
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU
+
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)	(((val) & \
+						SQ_CTXT_PKT_DROP_##member##_MASK) \
+						<< SQ_CTXT_PKT_DROP_##member##_SHIFT)
+
 enum hinic3_rq_wqe_type {
 	HINIC3_COMPACT_RQ_WQE,
 	HINIC3_NORMAL_RQ_WQE,
@@ -69,6 +144,16 @@ typedef uint8_t  (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_nic_dev
 /* Configure RSS indir table */
 typedef void     (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_buf *cmd_buf,
 						 uint32_t *indir_table);
+struct hinic3_rq_ctxt;
+struct hinic3_sq_ctxt;
+
+typedef void	 (*prepare_rq_ctxt_ceq_and_prefetch_t)(struct hinic3_rq_ctxt *rq_ctxt,
+						       uint16_t wqe_type,
+						       uint16_t msix_entry_idx,
+						       bool support_rq_sw_compact_cqe,
+						       uint8_t intr_disable);
+
+typedef void	 (*prepare_sq_ctxt_drop_and_prefetch_t)(struct hinic3_sq_ctxt *sq_ctxt);
 
 struct hinic3_nic_cmdq_ops {
 	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_space;
@@ -77,6 +162,8 @@ struct hinic3_nic_cmdq_ops {
 	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_table;
 	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_table;
 	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;
+	prepare_rq_ctxt_ceq_and_prefetch_t		prepare_rq_ctxt_ceq_and_prefetch;
+	prepare_sq_ctxt_drop_and_prefetch_t		prepare_sq_ctxt_drop_and_prefetch;
 };
 
 /**
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index e7dd0edb52..ae48f676f9 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -639,6 +639,25 @@ hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)
 	rq_ci.dw1.value = hinic3_hw_cpu32(val);
 	hw_ci = rq_ci.dw1.bs.hw_ci;
 
+	if (HINIC3_IS_SP560_NIC(rxq->nic_dev)) {
+		uint16_t sw_pi = hinic3_get_rq_local_pi(rxq);
+		uint64_t end;
+
+		end = cycles + msecs_to_cycles(HINIC3_FLUSH_QUEUE_TIMEOUT);
+		do {
+			val = rte_read32(&rxq->rq_ci->dw1.value);
+			rq_ci.dw1.value = hinic3_hw_cpu32(val);
+			hw_ci = rq_ci.dw1.bs.hw_ci;
+			if (sw_pi == hw_ci)
+				break;
+
+			rte_delay_us(1);
+		} while (time_before(cycles, end));
+
+		if (sw_pi != hw_ci)
+			return -EFAULT;
+	}
+
 	while (sw_ci != hw_ci) {
 		rx_info = &rxq->rx_info[sw_ci];
 		rte_pktmbuf_free(rx_info->mbuf);
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
index 607fe2d0fe..abf6644f35 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
@@ -8,6 +8,27 @@
 #include "hinic3_hwif.h"
 #include "hinic3_htn_cmdq.h"
 
+#define HINIC3_DEFAULT_DROP_THD_OFF	0xFFFF
+#define HINIC3_DEFAULT_DROP_THD_ON	0xFFFF
+
+#define SQ_PREFETCH_MAX			5
+#define SQ_PREFETCH_MIN			4
+#define SQ_PREFETCH_THRESHOLD		48
+
+#define RQ_PREFETCH_MAX			4
+#define RQ_PREFETCH_MIN			2
+#define RQ_PREFETCH_THRESHOLD		32
+
+#define RQ_PFH_TH			7
+
+#define RQ_CTXT_CEQ_ATTR_PFH_TH_SHIFT	0
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT	21
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT	31
+
+#define RQ_CTXT_CEQ_ATTR_PFH_TH_MASK	0x1FU
+#define RQ_CTXT_CEQ_ATTR_EN_MASK	0x1U
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK	0x3FFU
+
 #define HTN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_ctxt_header) \
 						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
 #define HTN_RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_ctxt_header) \
@@ -152,6 +173,31 @@ static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uin
 		indir_table[i] = *(indir_tbl + i);
 }
 
+static void
+prepare_sq_ctxt_drop_and_prefetch(struct hinic3_sq_ctxt *sq_ctxt)
+{
+	sq_ctxt->pkt_drop_thd = SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEFAULT_DROP_THD_ON, THD_ON) |
+				SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEFAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->pref_cache = SQ_CTXT_PREF_SET(SQ_PREFETCH_MIN, CACHE_MIN) |
+			      SQ_CTXT_PREF_SET(SQ_PREFETCH_MAX, CACHE_MAX) |
+			      SQ_CTXT_PREF_SET(SQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
+static void
+prepare_rq_ctxt_ceq_and_prefetch(struct hinic3_rq_ctxt *rq_ctxt, uint16_t wqe_type __rte_unused,
+	uint16_t msix_entry_idx, bool support_rq_sw_compact_cqe __rte_unused,
+	uint8_t intr_disable)
+{
+	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |
+			    RQ_CTXT_CEQ_ATTR_SET(RQ_PFH_TH, PFH_TH) |
+			    RQ_CTXT_CEQ_ATTR_SET(msix_entry_idx, INTR);
+
+	rq_ctxt->pref_cache = RQ_CTXT_PREF_SET(RQ_PREFETCH_MIN, CACHE_MIN) |
+			      RQ_CTXT_PREF_SET(RQ_PREFETCH_MAX, CACHE_MAX) |
+			      RQ_CTXT_PREF_SET(RQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
 const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops = {
 	.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
 	.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
@@ -159,4 +205,6 @@ const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops = {
 	.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
 	.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
 	.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+	.prepare_sq_ctxt_drop_and_prefetch =      prepare_sq_ctxt_drop_and_prefetch,
+	.prepare_rq_ctxt_ceq_and_prefetch =       prepare_rq_ctxt_ceq_and_prefetch,
 };
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
index 23adbc79f4..be23f991f1 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
@@ -8,6 +8,24 @@
 #include "hinic3_hwif.h"
 #include "hinic3_stn_cmdq.h"
 
+#define HINIC3_DEFAULT_DROP_THD_ON			0xFFFF
+#define HINIC3_DEFAULT_DROP_THD_OFF			0
+#define WQ_PREFETCH_MAX					6
+#define WQ_PREFETCH_MIN					1
+#define WQ_PREFETCH_THRESHOLD				256
+
+#define RQ_CTXT_CEQ_ATTR_CI_WR_SHIFT			0
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT			21
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT			30
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT			31
+
+#define RQ_CTXT_CEQ_ATTR_CI_WR_MASK			0x1U
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK			0x3FFU
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK			0x1U
+#define RQ_CTXT_CEQ_ATTR_EN_MASK			0x1U
+/* Indicate ucode that this is an interrupt in the DPDK scenario. */
+#define RQ_CTXT_INVALID_INTR_NUM			0x1FFU
+
 #define STN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_ctxt_header) \
 						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
 #define STN_RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_ctxt_header) \
@@ -136,6 +154,43 @@ static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uin
 		indir_table[i] = *(indir_tbl + i);
 }
 
+static void
+prepare_sq_ctxt_drop_and_prefetch(struct hinic3_sq_ctxt *sq_ctxt)
+{
+	sq_ctxt->pkt_drop_thd = SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEFAULT_DROP_THD_ON, THD_ON) |
+				SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEFAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->pref_cache = SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
+			      SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
+			      SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
+static void
+prepare_rq_ctxt_ceq_and_prefetch(struct hinic3_rq_ctxt *rq_ctxt, uint16_t wqe_type,
+	uint16_t msix_entry_idx, bool support_rq_sw_compact_cqe, uint8_t intr_disable)
+{
+	uint16_t ceq_intr = intr_disable ? RQ_CTXT_INVALID_INTR_NUM : msix_entry_idx;
+
+	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |
+			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |
+			    RQ_CTXT_CEQ_ATTR_SET(ceq_intr, INTR);
+	if (wqe_type == HINIC3_COMPACT_RQ_WQE && support_rq_sw_compact_cqe) {
+		/*
+		 * With the SW compact CQE, EN enables the CEQ context and must
+		 * be set for the attributes below to take effect; it does not
+		 * mask Rx interrupts. Interrupt delivery is controlled by the
+		 * INTR field above, where RQ_CTXT_INVALID_INTR_NUM keeps the
+		 * queue silent while a valid vector enables the interrupt.
+		 */
+		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, EN);
+		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, CI_WR);
+		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, INTR_ARM);
+	}
+	rq_ctxt->pref_cache = RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
+			      RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
+			      RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
 const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops = {
 	.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
 	.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
@@ -143,4 +198,6 @@ const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops = {
 	.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
 	.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
 	.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+	.prepare_sq_ctxt_drop_and_prefetch =      prepare_sq_ctxt_drop_and_prefetch,
+	.prepare_rq_ctxt_ceq_and_prefetch =       prepare_rq_ctxt_ceq_and_prefetch,
 };
-- 
2.33.0

