Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B5BCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06BB140E22;
	Wed, 14 Oct 2026 17:10:02 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 98C6F406A2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=GsVJ4I4f/Ypi8/r09LensFEqMJHPCKgOwT6vYpCB+DE=;
 b=WHn6qMA18XgogZ4uIzDs+sT4MssaCaRIOTlbj5FiTwyYgYuLvfgfq8VZNiJ+Ej
 I5iPh0CWKBE8M10gHvHvQzZWHbmmtm7EXsHJfGkjd9KjiLUzGm1YULAciLrq6uUH
 rVv8cTozCTmQxlXC5HumDGdtymMF6140Jhd16LvBJbzFc=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 16/26] net/hinic3: add SP560 NIC type identification and
 handling
Date: Wed, 14 Oct 2026 23:09:12 +0800
Message-ID: <20261014150923.838-17-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S18
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cry7AFyUKw15Zry8KFyfWFg_yoWkJr1xpa
 17ArZ3ZrWDKF4UXwn5Ga1DA3W5Xa13C3yjg34xAasa9Fn8Zr1UZa4UGrWIvrZxKr4xZFy2
 vr1jk39Fy3Wjqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxqDjWrPmzofiQAA3x
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

Identify the new SP560 NIC through its PCI device ID and select NIC-type
specific operations, and add 400G/800G line rate support.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/hinic3.rst                 |  2 +-
 doc/guides/rel_notes/release_26_11.rst     |  1 +
 drivers/net/hinic3/base/hinic3_csr.h       |  6 ++-
 drivers/net/hinic3/base/hinic3_hwif.c      |  4 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.h   |  4 ++
 drivers/net/hinic3/base/hinic3_nic_event.c | 62 ++++++++++++++++++++--
 drivers/net/hinic3/hinic3_ethdev.c         |  8 +++
 drivers/net/hinic3/hinic3_ethdev.h         |  6 ++-
 drivers/net/hinic3/hinic3_rx.c             | 19 +++++++
 9 files changed, 104 insertions(+), 8 deletions(-)

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
index 3f106bfe31..fc5d7f74b2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -121,6 +121,7 @@ New Features
   * Added Class of Service (COS) mask and map support.
   * Updated RSS hash type configuration.
   * Added mailbox message counter reporting through the device private dump API.
+  * Added support for the SP560 NIC.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index 7cae2419c0..fba2f6838a 100644
--- a/drivers/net/hinic3/base/hinic3_csr.h
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -8,13 +8,17 @@
 #define PCI_VENDOR_ID_HUAWEI	0x19e5
 
 #define HINIC3_DEV_ID_SP620	0x0222
-#define HINIC3_DEV_ID_VF_SP620	0x375F
+#define HINIC3_DEV_ID_VF_SP620	0x375f
 
 #define HINIC3_DEV_ID_SP230	0x0229
 #define HINIC3_DEV_ID_VF_SP230	0x022a
 
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
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index d8b7dd9bc4..79375bbf91 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -127,6 +127,8 @@ enum nic_speed_level {
 	LINK_SPEED_50GB,
 	LINK_SPEED_100GB,
 	LINK_SPEED_200GB,
+	LINK_SPEED_400GB,
+	LINK_SPEED_800GB,
 	LINK_SPEED_LEVELS,
 };
 
@@ -181,6 +183,8 @@ enum mag_cmd_port_speed {
 	PORT_SPEED_50GB    = 7,
 	PORT_SPEED_100GB   = 8,
 	PORT_SPEED_200GB   = 9,
+	PORT_SPEED_400GB   = 10,
+	PORT_SPEED_800GB   = 11,
 	PORT_SPEED_UNKNOWN
 };
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic3/base/hinic3_nic_event.c
index 787b4b0739..6939f3d9cb 100644
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
@@ -175,6 +215,22 @@ get_port_temperature_power(struct mag_cmd_event_port_info *info, char *str)
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
@@ -200,9 +256,9 @@ print_cable_info(struct mag_cmd_event_port_info *port_info)
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
index f3dc5a15a6..ccc013462e 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -551,6 +551,10 @@ hinic3_get_nic_type(struct rte_pci_device *pci_dev)
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
@@ -571,6 +575,7 @@ hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev)
 	static const struct hinic3_nic_cmdq_ops *cmdq_ops[] = {
 		[NIC_SP620]   = &hinic3_stn_cmdq_ops,
 		[NIC_SP230]   = &hinic3_htn_cmdq_ops,
+		[NIC_SP560]   = &hinic3_stn_cmdq_ops,
 		[NIC_UNKNOWN] = &hinic3_stn_cmdq_ops,
 	};
 
@@ -3952,6 +3957,9 @@ static const struct rte_pci_id pci_id_hinic3_map[] = {
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP230)},
 
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP920)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP560)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP560)},
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_HYPER_VF_SP560)},
 
 	{.vendor_id = 0},
 };
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index f7d3dfcff6..7ab9b661d5 100644
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
@@ -170,6 +171,7 @@ struct hinic3_nic_dev {
 
 #define HINIC3_IS_SP620_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP620)
 #define HINIC3_IS_SP230_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP230)
+#define HINIC3_IS_SP560_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP560)
 
 extern const struct rte_flow_ops hinic3_flow_ops;
 
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index a4846dc695..9627b608f4 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -637,6 +637,25 @@ hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)
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
-- 
2.33.0

