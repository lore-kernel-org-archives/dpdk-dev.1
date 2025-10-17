Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3423ECCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D14D42DA3;
	Fri, 17 Oct 2025 11:19:43 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id BA94C42D0B
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:34 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98869203629;
 Fri, 17 Oct 2025 11:19:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 388C4200E78;
 Fri, 17 Oct 2025 11:19:34 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A33E4180007D;
 Fri, 17 Oct 2025 17:19:33 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v2 06/12] net/enetc: Add packet type parsing support
Date: Fri, 17 Oct 2025 14:49:23 +0530
Message-Id: <20251017091929.2723044-7-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251017091929.2723044-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Introduces packet type parsing for ENETC4 PMD, supporting:

- RTE_PTYPE_L2_ETHER (Ethernet II)
- RTE_PTYPE_L3_IPV4 (IPv4)
- RTE_PTYPE_L3_IPV6 (IPv6)
- RTE_PTYPE_L4_TCP (TCP)
- RTE_PTYPE_L4_UDP (UDP)
- RTE_PTYPE_L4_SCTP (SCTP)
- RTE_PTYPE_L4_ICMP (ICMP)
- RTE_PTYPE_L4_FRAG (IPv4/IPv6 fragmentation)
- RTE_PTYPE_TUNNEL_ESP (ESP tunneling)

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |   2 +
 drivers/net/enetc/base/enetc4_hw.h  |  11 +
 drivers/net/enetc/base/enetc_hw.h   |  25 ++-
 drivers/net/enetc/enetc.h           |  39 +++-
 drivers/net/enetc/enetc4_ethdev.c   | 159 ++++++++++++--
 drivers/net/enetc/enetc4_vf.c       |  11 +-
 drivers/net/enetc/enetc_cbdr.c      | 311 ++++++++++++++++++++++++++++
 drivers/net/enetc/enetc_rxtx.c      |  10 +
 drivers/net/enetc/meson.build       |   5 +-
 drivers/net/enetc/ntmp.h            | 110 ++++++++++
 10 files changed, 652 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/enetc/enetc_cbdr.c
 create mode 100644 drivers/net/enetc/ntmp.h

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index e814852d2d..79430d0018 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,8 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+RSS hash             = Y
+Packet type parsing  = Y
 Basic stats          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index af3d4fa256..ca5af2375f 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -112,6 +112,17 @@
 #define ENETC4_SITFRM0           0x328
 #define ENETC4_SITDFCR           0x340
 
+/* Control BDR regs */
+#define ENETC4_SICBDRMR		0x800
+#define ENETC4_SICBDRSR		0x804   /* RO */
+#define ENETC4_SICBDRBAR0	0x810
+#define ENETC4_SICBDRBAR1	0x814
+#define ENETC4_SICBDRPIR	0x818
+#define ENETC4_SICBDRCIR	0x81c
+#define ENETC4_SICBDRLENR	0x820
+#define ENETC4_SICTR0		0x18
+#define ENETC4_SICTR1		0x1c
+
 /* general register accessors */
 #define enetc4_rd_reg(reg)	rte_read32((void *)(reg))
 #define enetc4_wr_reg(reg, val)  rte_write32((val), (void *)(reg))
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 290eaf577c..173d677fd0 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -21,13 +21,17 @@
 /* SI regs, offset: 0h */
 #define ENETC_SIMR			0x0
 #define ENETC_SIMR_EN			BIT(31)
+#define ENETC_SIMR_RSSE			BIT(0)
 
+/* BDR grouping*/
+#define ENETC_SIRBGCR			0x38
 #define ENETC_SICAR0			0x40
 #define ENETC_SICAR0_COHERENT		0x2B2B6727
 #define ENETC_SIPMAR0			0x80
 #define ENETC_SIPMAR1			0x84
 
 #define ENETC_SICAPR0			0x900
+#define ENETC_SICAPR0_BDR_MASK		0xFF
 #define ENETC_SICAPR1			0x904
 
 #define ENETC_SIMSITRV(n)		(0xB00 + (n) * 0x4)
@@ -35,6 +39,11 @@
 
 #define ENETC_SICCAPR			0x1200
 
+#define ENETC_SIPCAPR0			0x20
+#define ENETC_SIPCAPR0_RSS		BIT(8)
+#define ENETC_SIRSSCAPR			0x1600
+#define ENETC_SIRSSCAPR_GET_NUM_RSS(val) (BIT((val) & 0xf) * 32)
+
 /* enum for BD type */
 enum enetc_bdr_type {TX, RX};
 
@@ -44,6 +53,7 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_RBMR		0x0 /* RX BDR mode register*/
 #define ENETC_RBMR_EN		BIT(31)
 
+#define ENETC_BMR_RESET		0x0 /* BDR reset*/
 #define ENETC_RBSR		0x4  /* Rx BDR status register*/
 #define ENETC_RBBSR		0x8  /* Rx BDR buffer size register*/
 #define ENETC_RBCIR		0xc  /* Rx BDR consumer index register*/
@@ -196,6 +206,7 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PKT_TYPE_ETHER            0x0060
 #define ENETC_PKT_TYPE_IPV4             0x0000
 #define ENETC_PKT_TYPE_IPV6             0x0020
+#define ENETC_PKT_TYPE_IPV6_EXT         0x0080
 #define ENETC_PKT_TYPE_IPV4_TCP \
 			(0x0010 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_TCP \
@@ -208,6 +219,10 @@ enum enetc_bdr_type {TX, RX};
 			(0x0013 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_SCTP \
 			(0x0013 | ENETC_PKT_TYPE_IPV6)
+#define ENETC_PKT_TYPE_IPV4_FRAG \
+			(0x0001 | ENETC_PKT_TYPE_IPV4)
+#define ENETC_PKT_TYPE_IPV6_FRAG \
+			(0x0001 | ENETC_PKT_TYPE_IPV6_EXT | ENETC_PKT_TYPE_IPV6)
 #define ENETC_PKT_TYPE_IPV4_ICMP \
 			(0x0003 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_ICMP \
@@ -226,15 +241,6 @@ struct enetc_eth_mac_info {
 	uint8_t get_link_status;
 };
 
-struct enetc_eth_hw {
-	struct rte_eth_dev *ndev;
-	struct enetc_hw hw;
-	uint16_t device_id;
-	uint16_t vendor_id;
-	uint8_t revision_id;
-	struct enetc_eth_mac_info mac;
-};
-
 /* Transmit Descriptor */
 struct enetc_tx_desc {
 	uint64_t addr;
@@ -287,5 +293,4 @@ union enetc_rx_bd {
 		};
 	} r;
 };
-
 #endif
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index c9da68e719..cfc160789a 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -10,7 +10,9 @@
 
 #include "compat.h"
 #include "base/enetc_hw.h"
+#include "base/enetc4_hw.h"
 #include "enetc_logs.h"
+#include "ntmp.h"
 
 #define PCI_VENDOR_ID_FREESCALE 0x1957
 
@@ -50,6 +52,18 @@
 				    RTE_MBUF_F_TX_TCP_CKSUM | \
 				    RTE_MBUF_F_TX_UDP_CKSUM)
 
+#define ENETC_CBD(R, i)	(&(((struct enetc_cbd *)((R).bd_base))[i]))
+#define ENETC_CBDR_TIMEOUT	1000 /* In multiple of ENETC_CBDR_DELAY */
+#define ENETC_CBDR_DELAY	100 /* usecs */
+#define ENETC_CBDR_SIZE		64
+#define ENETC_CBDR_ALIGN	128
+
+/* supported RSS */
+#define ENETC_RSS_OFFLOAD_ALL ( \
+	RTE_ETH_RSS_IP | \
+	RTE_ETH_RSS_UDP | \
+	RTE_ETH_RSS_TCP)
+
 struct enetc_swbd {
 	struct rte_mbuf *buffer_addr;
 };
@@ -75,6 +89,19 @@ struct enetc_bdr {
 	uint64_t ierrors;
 };
 
+struct enetc_eth_hw {
+	struct rte_eth_dev *ndev;
+	struct enetc_hw hw;
+	uint16_t device_id;
+	uint16_t vendor_id;
+	uint8_t revision_id;
+	struct enetc_eth_mac_info mac;
+	struct netc_cbdr cbdr;
+	uint32_t num_rss;
+	uint32_t max_rx_queues;
+	uint32_t max_tx_queues;
+};
+
 /*
  * Structure to store private data for each driver instance (for each port).
  */
@@ -101,7 +128,7 @@ struct enetc_eth_adapter {
 int enetc4_pci_remove(struct rte_pci_device *pci_dev);
 int enetc4_dev_configure(struct rte_eth_dev *dev);
 int enetc4_dev_close(struct rte_eth_dev *dev);
-int enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+int enetc4_dev_infos_get(struct rte_eth_dev *dev,
 			 struct rte_eth_dev_info *dev_info);
 int enetc4_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 			  uint16_t nb_rx_desc, unsigned int socket_id __rte_unused,
@@ -116,6 +143,8 @@ int enetc4_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 int enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx);
 int enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
 void enetc4_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+const uint32_t *enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+			size_t *no_of_elements);
 
 /*
  * enetc4_vf function prototype
@@ -146,4 +175,12 @@ enetc_bd_unused(struct enetc_bdr *bdr)
 
 	return bdr->bd_count + bdr->next_to_clean - bdr->next_to_use - 1;
 }
+
+/* CBDR prototypes */
+int enetc4_setup_cbdr(struct rte_eth_dev *dev, struct enetc_hw *hw,
+			int bd_count, struct netc_cbdr *cbdr);
+void enetc_free_cbdr(struct netc_cbdr *cbdr);
+int enetc_ntmp_rsst_query_or_update_entry(struct netc_cbdr *cbdr, uint32_t *table,
+			int count, bool query);
+
 #endif /* _ENETC_H_ */
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 5c34102ddd..2233bc4c0f 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -122,10 +122,14 @@ enetc4_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
 }
 
 int
-enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+enetc4_dev_infos_get(struct rte_eth_dev *dev,
 		    struct rte_eth_dev_info *dev_info)
 {
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
 	PMD_INIT_FUNC_TRACE();
+
 	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
 		.nb_max = MAX_BD_COUNT,
 		.nb_min = MIN_BD_COUNT,
@@ -136,11 +140,12 @@ enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
 		.nb_min = MIN_BD_COUNT,
 		.nb_align = BD_ALIGN,
 	};
-	dev_info->max_rx_queues = MAX_RX_RINGS;
-	dev_info->max_tx_queues = MAX_TX_RINGS;
+	dev_info->max_rx_queues = hw->max_rx_queues;
+	dev_info->max_tx_queues = hw->max_tx_queues;
 	dev_info->max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
 	dev_info->rx_offload_capa = dev_rx_offloads_sup;
 	dev_info->tx_offload_capa = dev_tx_offloads_sup;
+	dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL;
 
 	return 0;
 }
@@ -255,17 +260,20 @@ void
 enetc4_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
 	void *txq = dev->data->tx_queues[qid];
+	struct enetc_hw *hw;
+	struct enetc_swbd *tx_swbd;
+	int i;
+	uint32_t val;
+	struct enetc_bdr *tx_ring;
+	struct enetc_eth_hw *eth_hw;
 
+	PMD_INIT_FUNC_TRACE();
 	if (txq == NULL)
 		return;
 
-	struct enetc_bdr *tx_ring = (struct enetc_bdr *)txq;
-	struct enetc_eth_hw *eth_hw =
+	tx_ring = (struct enetc_bdr *)txq;
+	eth_hw =
 		ENETC_DEV_PRIVATE_TO_HW(tx_ring->ndev->data->dev_private);
-	struct enetc_hw *hw;
-	struct enetc_swbd *tx_swbd;
-	int i;
-	uint32_t val;
 
 	/* Disable the ring */
 	hw = &eth_hw->hw;
@@ -403,17 +411,20 @@ void
 enetc4_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
 	void *rxq = dev->data->rx_queues[qid];
+	struct enetc_swbd *q_swbd;
+	struct enetc_hw *hw;
+	uint32_t val;
+	int i;
+	struct enetc_bdr *rx_ring;
+	struct enetc_eth_hw *eth_hw;
 
+	PMD_INIT_FUNC_TRACE();
 	if (rxq == NULL)
 		return;
 
-	struct enetc_bdr *rx_ring = (struct enetc_bdr *)rxq;
-	struct enetc_eth_hw *eth_hw =
+	rx_ring = (struct enetc_bdr *)rxq;
+	eth_hw =
 		ENETC_DEV_PRIVATE_TO_HW(rx_ring->ndev->data->dev_private);
-	struct enetc_swbd *q_swbd;
-	struct enetc_hw *hw;
-	uint32_t val;
-	int i;
 
 	/* Disable the ring */
 	hw = &eth_hw->hw;
@@ -479,10 +490,22 @@ enetc4_stats_reset(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void
+enetc4_rss_configure(struct enetc_hw *hw, int enable)
+{
+	uint32_t reg;
+
+	reg = enetc4_rd(hw, ENETC_SIMR);
+	reg &= ~ENETC_SIMR_RSSE;
+	reg |= (enable) ? ENETC_SIMR_RSSE : 0;
+	enetc4_wr(hw, ENETC_SIMR, reg);
+}
+
 int
 enetc4_dev_close(struct rte_eth_dev *dev)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
 	uint16_t i;
 	int ret;
 
@@ -495,6 +518,13 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 	else
 		ret = enetc4_dev_stop(dev);
 
+	if (dev->data->nb_rx_queues > 1) {
+		/* Disable RSS */
+		enetc4_rss_configure(enetc_hw, false);
+		/* Free CBDR */
+		enetc_free_cbdr(&hw->cbdr);
+	}
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		enetc4_rx_queue_release(dev, i);
 		dev->data->rx_queues[i] = NULL;
@@ -524,7 +554,9 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	uint32_t checksum = L3_CKSUM | L4_CKSUM;
 	struct enetc_hw *enetc_hw = &hw->hw;
 	uint32_t max_len;
-	uint32_t val;
+	uint32_t val, num_rss;
+	uint32_t ret = 0, i;
+	uint32_t *rss_table;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -557,6 +589,70 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 
 	enetc4_port_wr(enetc_hw, ENETC4_PARCSCR, checksum);
 
+	/* Disable and reset RX and TX rings */
+	for (i = 0; i < dev->data->nb_rx_queues; i++)
+		enetc4_rxbdr_wr(enetc_hw, i, ENETC_RBMR, ENETC_BMR_RESET);
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++)
+		enetc4_rxbdr_wr(enetc_hw, i, ENETC_TBMR, ENETC_BMR_RESET);
+
+	if (dev->data->nb_rx_queues <= 1)
+		return 0;
+
+	/* Setup RSS */
+	/* Setup control BDR */
+	ret = enetc4_setup_cbdr(dev, enetc_hw, ENETC_CBDR_SIZE, &hw->cbdr);
+	if (ret) {
+		/* Disable RSS */
+		enetc4_rss_configure(enetc_hw, false);
+		return ret;
+	}
+
+	/* Reset CIR again after enable CBDR*/
+	rte_delay_us(ENETC_CBDR_DELAY);
+	ENETC_PMD_DEBUG("CIR %x after CBDR enable", rte_read32(hw->cbdr.regs.cir));
+	rte_write32(0, hw->cbdr.regs.cir);
+	ENETC_PMD_DEBUG("CIR %x after reset", rte_read32(hw->cbdr.regs.cir));
+
+	val = enetc_rd(enetc_hw, ENETC_SIPCAPR0);
+	if (val & ENETC_SIPCAPR0_RSS) {
+		num_rss = enetc_rd(enetc_hw, ENETC_SIRSSCAPR);
+		hw->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(num_rss);
+		ENETC_PMD_DEBUG("num_rss = %d", hw->num_rss);
+
+		/* Add number of BDR groups */
+		enetc4_wr(enetc_hw, ENETC_SIRBGCR, dev->data->nb_rx_queues);
+
+
+		/* Configuring indirecton table with default values
+		 * Hash algorithm and RSS secret key to be filled by PF
+		 */
+		rss_table = rte_malloc(NULL, hw->num_rss * sizeof(*rss_table), ENETC_CBDR_ALIGN);
+		if (!rss_table) {
+			enetc4_rss_configure(enetc_hw, false);
+			enetc_free_cbdr(&hw->cbdr);
+			return -ENOMEM;
+		}
+
+		ENETC_PMD_DEBUG("Enabling RSS for port %s with queues = %d", dev->device->name,
+							dev->data->nb_rx_queues);
+		for (i = 0; i < hw->num_rss; i++)
+			rss_table[i] = i % dev->data->nb_rx_queues;
+
+		ret = enetc_ntmp_rsst_query_or_update_entry(&hw->cbdr,
+					rss_table, hw->num_rss, false);
+		if (ret) {
+			ENETC_PMD_WARN("RSS indirection table update fails,"
+					"Scaling behaviour is undefined");
+			enetc4_rss_configure(enetc_hw, false);
+			enetc_free_cbdr(&hw->cbdr);
+		}
+		rte_free(rss_table);
+
+		/* Enable RSS */
+		enetc4_rss_configure(enetc_hw, true);
+	}
+
 	return 0;
 }
 
@@ -648,6 +744,28 @@ enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
 	return 0;
 }
 
+const uint32_t *
+enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+			    size_t *no_of_elements)
+{
+	PMD_INIT_FUNC_TRACE();
+	static const uint32_t ptypes[] = {
+		RTE_PTYPE_L2_ETHER,
+		RTE_PTYPE_L3_IPV4,
+		RTE_PTYPE_L3_IPV6,
+		RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_L4_SCTP,
+		RTE_PTYPE_L4_ICMP,
+		RTE_PTYPE_L4_FRAG,
+		RTE_PTYPE_TUNNEL_ESP,
+		RTE_PTYPE_UNKNOWN
+	};
+
+	*no_of_elements = RTE_DIM(ptypes);
+	return ptypes;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -673,6 +791,7 @@ static const struct eth_dev_ops enetc4_ops = {
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
 /*
@@ -718,11 +837,19 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
 	int error = 0;
+	uint32_t si_cap;
+	struct enetc_hw *enetc_hw = &hw->hw;
 
 	PMD_INIT_FUNC_TRACE();
 	eth_dev->dev_ops = &enetc4_ops;
 	enetc4_dev_hw_init(eth_dev);
 
+	si_cap = enetc_rd(enetc_hw, ENETC_SICAPR0);
+	hw->max_tx_queues = si_cap & ENETC_SICAPR0_BDR_MASK;
+	hw->max_rx_queues = (si_cap >> 16) & ENETC_SICAPR0_BDR_MASK;
+
+	ENETC_PMD_DEBUG("Max RX queues = %d Max TX queues = %d",
+			hw->max_rx_queues, hw->max_tx_queues);
 	error = enetc4_mac_init(hw, eth_dev);
 	if (error != 0) {
 		ENETC_PMD_ERR("MAC initialization failed");
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 534cf4b45c..efb43e3b00 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -5,8 +5,6 @@
 #include <stdbool.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
-#include "base/enetc4_hw.h"
-#include "base/enetc_hw.h"
 #include "enetc_logs.h"
 #include "enetc.h"
 
@@ -73,6 +71,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
 static int
@@ -136,11 +135,19 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 			    ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
 	int error = 0;
+	uint32_t si_cap;
+	struct enetc_hw *enetc_hw = &hw->hw;
 
 	PMD_INIT_FUNC_TRACE();
 	eth_dev->dev_ops = &enetc4_vf_ops;
 	enetc4_dev_hw_init(eth_dev);
 
+	si_cap = enetc_rd(enetc_hw, ENETC_SICAPR0);
+	hw->max_tx_queues = si_cap & ENETC_SICAPR0_BDR_MASK;
+	hw->max_rx_queues = (si_cap >> 16) & ENETC_SICAPR0_BDR_MASK;
+
+	ENETC_PMD_DEBUG("Max RX queues = %d Max TX queues = %d",
+			hw->max_rx_queues, hw->max_tx_queues);
 	error = enetc4_vf_mac_init(hw, eth_dev);
 	if (error != 0) {
 		ENETC_PMD_ERR("MAC initialization failed!!");
diff --git a/drivers/net/enetc/enetc_cbdr.c b/drivers/net/enetc/enetc_cbdr.c
new file mode 100644
index 0000000000..10e3f65408
--- /dev/null
+++ b/drivers/net/enetc/enetc_cbdr.c
@@ -0,0 +1,311 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ */
+
+#include <ethdev_pci.h>
+
+#include "enetc_logs.h"
+#include "enetc.h"
+
+#define NTMP_RSST_ID                    3
+
+/* Define NTMP Access Method */
+#define NTMP_AM_ENTRY_ID                0
+#define NTMP_AM_EXACT_KEY               1
+#define NTMP_AM_SEARCH                  2
+#define NTMP_AM_TERNARY_KEY             3
+
+/* Define NTMP Header Version */
+#define NTMP_HEADER_VERSION2            2
+
+#define NTMP_REQ_HDR_NPF                BIT(15)
+
+#define NTMP_RESP_LEN_MASK              GENMASK(19, 0)
+#define NTMP_REQ_LEN_MASK               GENMASK(31, 20)
+
+#define ENETC_NTMP_ENTRY_ID_SIZE        4
+
+#define ENETC_RSS_TABLE_ENTRY_NUM       64
+#define ENETC_RSS_CFGEU                 BIT(0)
+#define ENETC_RSS_STSEU                 BIT(1)
+#define ENETC_RSS_STSE_DATA_SIZE(n)     ((n) * 8)
+#define ENETC_RSS_CFGE_DATA_SIZE(n)     (n)
+
+#define NTMP_REQ_RESP_LEN(req, resp)    (((req) << 20 & NTMP_REQ_LEN_MASK) | \
+					((resp) & NTMP_RESP_LEN_MASK))
+
+static inline uint32_t
+netc_cbdr_read(void *reg)
+{
+	return rte_read32(reg);
+}
+
+static inline void
+netc_cbdr_write(void *reg, uint32_t val)
+{
+	rte_write32(val, reg);
+}
+
+static inline void
+ntmp_fill_request_headr(union netc_cbd *cbd, dma_addr_t dma,
+			int len, int table_id, int cmd,
+			int access_method)
+{
+	dma_addr_t dma_align;
+
+	memset(cbd, 0, sizeof(*cbd));
+	dma_align = dma;
+	cbd->ntmp_req_hdr.addr = dma_align;
+	cbd->ntmp_req_hdr.len = len;
+	cbd->ntmp_req_hdr.cmd = cmd;
+	cbd->ntmp_req_hdr.access_method = access_method;
+	cbd->ntmp_req_hdr.table_id = table_id;
+	cbd->ntmp_req_hdr.hdr_ver = NTMP_HEADER_VERSION2;
+	cbd->ntmp_req_hdr.cci = 0;
+	cbd->ntmp_req_hdr.rr = 0;       /* Must be set to 0 by SW. */
+	/* For NTMP version 2.0 or later version */
+	cbd->ntmp_req_hdr.npf = NTMP_REQ_HDR_NPF;
+}
+
+static inline int
+netc_get_free_cbd_num(struct netc_cbdr *cbdr)
+{
+	return (cbdr->next_to_clean - cbdr->next_to_use - 1 + cbdr->bd_num) %
+		cbdr->bd_num;
+}
+
+static inline union
+netc_cbd *netc_get_cbd(struct netc_cbdr *cbdr, int index)
+{
+	return &((union netc_cbd *)(cbdr->addr_base_align))[index];
+}
+
+static void
+netc_clean_cbdr(struct netc_cbdr *cbdr)
+{
+	union netc_cbd *cbd;
+	uint32_t i;
+
+	i = cbdr->next_to_clean;
+	while (netc_cbdr_read(cbdr->regs.cir) != i) {
+		cbd = netc_get_cbd(cbdr, i);
+		memset(cbd, 0, sizeof(*cbd));
+		dcbf(cbd);
+		i = (i + 1) % cbdr->bd_num;
+	}
+
+	cbdr->next_to_clean = i;
+}
+
+static int
+netc_xmit_ntmp_cmd(struct netc_cbdr *cbdr, union netc_cbd *cbd)
+{
+	union netc_cbd *ring_cbd;
+	uint32_t i, err = 0;
+	uint16_t status;
+	uint32_t timeout = cbdr->timeout;
+	uint32_t delay = cbdr->delay;
+
+	if (unlikely(!cbdr->addr_base))
+		return -EFAULT;
+
+	rte_spinlock_lock(&cbdr->ring_lock);
+
+	if (unlikely(!netc_get_free_cbd_num(cbdr)))
+		netc_clean_cbdr(cbdr);
+
+	i = cbdr->next_to_use;
+	ring_cbd = netc_get_cbd(cbdr, i);
+
+	/* Copy command BD to the ring */
+	*ring_cbd = *cbd;
+	/* Update producer index of both software and hardware */
+	i = (i + 1) % cbdr->bd_num;
+	dcbf(ring_cbd);
+	cbdr->next_to_use = i;
+	netc_cbdr_write(cbdr->regs.pir, i);
+	ENETC_PMD_DEBUG("Control msg sent PIR = %d, CIR = %d", netc_cbdr_read(cbdr->regs.pir),
+					netc_cbdr_read(cbdr->regs.cir));
+	do {
+		if (netc_cbdr_read(cbdr->regs.cir) == i) {
+			dccivac(ring_cbd);
+			ENETC_PMD_DEBUG("got response");
+			ENETC_PMD_DEBUG("Matched = %d, status = 0x%x",
+					ring_cbd->ntmp_resp_hdr.num_matched,
+					ring_cbd->ntmp_resp_hdr.error_rr);
+			break;
+		}
+		rte_delay_us(delay);
+	} while (timeout--);
+
+	if (timeout <= 0)
+		ENETC_PMD_ERR("no response of RSS configuration");
+
+	ENETC_PMD_DEBUG("CIR after receive = %d, SICBDRSR = 0x%x",
+					netc_cbdr_read(cbdr->regs.cir),
+					netc_cbdr_read(cbdr->regs.st));
+	/* Check the writeback error status */
+	status = ring_cbd->ntmp_resp_hdr.error_rr & NTMP_RESP_HDR_ERR;
+	if (unlikely(status)) {
+		ENETC_PMD_ERR("Command BD error: 0x%04x", status);
+		err = -EIO;
+	}
+
+	netc_clean_cbdr(cbdr);
+	rte_spinlock_unlock(&cbdr->ring_lock);
+
+	return err;
+}
+
+int
+enetc_ntmp_rsst_query_or_update_entry(struct netc_cbdr *cbdr, uint32_t *table,
+				int count, bool query)
+{
+	struct rsst_req_update *requ;
+	struct rsst_req_query *req;
+	union netc_cbd cbd;
+	uint32_t len, data_size;
+	dma_addr_t dma;
+	int err, i;
+	void *tmp;
+
+	if (count != ENETC_RSS_TABLE_ENTRY_NUM)
+		/* HW only takes in a full 64 entry table */
+		return -EINVAL;
+
+	if (query)
+		data_size = ENETC_NTMP_ENTRY_ID_SIZE + ENETC_RSS_STSE_DATA_SIZE(count) +
+			ENETC_RSS_CFGE_DATA_SIZE(count);
+	else
+		data_size = sizeof(*requ) + count * sizeof(uint8_t);
+
+	tmp = rte_malloc(NULL, data_size, ENETC_CBDR_ALIGN);
+	if (!tmp)
+		return -ENOMEM;
+
+	dma = rte_mem_virt2iova(tmp);
+	req = tmp;
+	/* Set the request data buffer */
+	if (query) {
+		len = NTMP_REQ_RESP_LEN(sizeof(*req), data_size);
+		ntmp_fill_request_headr(&cbd, dma, len, NTMP_RSST_ID,
+					NTMP_CMD_QUERY, NTMP_AM_ENTRY_ID);
+	} else {
+		requ = (struct rsst_req_update *)req;
+		requ->crd.update_act = (ENETC_RSS_CFGEU | ENETC_RSS_STSEU);
+		for (i = 0; i < count; i++)
+			requ->groups[i] = (uint8_t)(table[i]);
+
+		len = NTMP_REQ_RESP_LEN(data_size, 0);
+		ntmp_fill_request_headr(&cbd, dma, len, NTMP_RSST_ID,
+				NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+		dcbf(requ);
+	}
+
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd);
+	if (err) {
+		ENETC_PMD_ERR("%s RSS table entry failed (%d)!",
+				query ? "Query" : "Update", err);
+		goto end;
+	}
+
+	if (query) {
+		uint8_t *group = (uint8_t *)req;
+
+		group += ENETC_NTMP_ENTRY_ID_SIZE + ENETC_RSS_STSE_DATA_SIZE(count);
+		for (i = 0; i < count; i++)
+			table[i] = group[i];
+	}
+end:
+	rte_free(tmp);
+
+	return err;
+}
+
+static int
+netc_setup_cbdr(struct rte_eth_dev *dev, int cbd_num,
+		struct netc_cbdr_regs *regs,
+		struct netc_cbdr *cbdr)
+{
+	int size;
+
+	size = cbd_num * sizeof(union netc_cbd) +
+		NETC_CBDR_BASE_ADDR_ALIGN;
+
+	cbdr->addr_base = rte_malloc(NULL, size, ENETC_CBDR_ALIGN);
+	if (!cbdr->addr_base)
+		return -ENOMEM;
+
+	cbdr->dma_base = rte_mem_virt2iova(cbdr->addr_base);
+	cbdr->dma_size = size;
+	cbdr->bd_num = cbd_num;
+	cbdr->regs = *regs;
+	cbdr->dma_dev = dev;
+	cbdr->timeout = ENETC_CBDR_TIMEOUT;
+	cbdr->delay = ENETC_CBDR_DELAY;
+
+	if (getenv("ENETC4_CBDR_TIMEOUT"))
+		cbdr->timeout = atoi(getenv("ENETC4_CBDR_TIMEOUT"));
+
+	if (getenv("ENETC4_CBDR_DELAY"))
+		cbdr->delay = atoi(getenv("ENETC4_CBDR_DELAY"));
+
+
+	ENETC_PMD_DEBUG("CBDR timeout = %u and delay = %u", cbdr->timeout,
+						cbdr->delay);
+	/* The base address of the Control BD Ring must be 128 bytes aligned */
+	cbdr->dma_base_align =  cbdr->dma_base;
+	cbdr->addr_base_align = cbdr->addr_base;
+
+	cbdr->next_to_clean = 0;
+	cbdr->next_to_use = 0;
+	rte_spinlock_init(&cbdr->ring_lock);
+
+	netc_cbdr_write(cbdr->regs.mr, ~((uint32_t)NETC_CBDRMR_EN));
+	/* Step 1: Configure the base address of the Control BD Ring */
+	netc_cbdr_write(cbdr->regs.bar0, lower_32_bits(cbdr->dma_base_align));
+	netc_cbdr_write(cbdr->regs.bar1, upper_32_bits(cbdr->dma_base_align));
+
+	/* Step 2: Configure the producer index register */
+	netc_cbdr_write(cbdr->regs.pir, cbdr->next_to_clean);
+
+	/* Step 3: Configure the consumer index register */
+	netc_cbdr_write(cbdr->regs.cir, cbdr->next_to_use);
+	/* Step4: Configure the number of BDs of the Control BD Ring */
+	netc_cbdr_write(cbdr->regs.lenr, cbdr->bd_num);
+
+	/* Step 5: Enable the Control BD Ring */
+	netc_cbdr_write(cbdr->regs.mr, NETC_CBDRMR_EN);
+
+	return 0;
+}
+
+void
+enetc_free_cbdr(struct netc_cbdr *cbdr)
+{
+	/* Disable the Control BD Ring */
+	if (cbdr->regs.mr != NULL) {
+		netc_cbdr_write(cbdr->regs.mr, 0);
+		rte_free(cbdr->addr_base);
+		memset(cbdr, 0, sizeof(*cbdr));
+	}
+}
+
+int
+enetc4_setup_cbdr(struct rte_eth_dev *dev, struct enetc_hw *hw,
+		  int bd_count, struct netc_cbdr *cbdr)
+{
+	struct netc_cbdr_regs regs;
+
+	regs.pir = (void *)((size_t)hw->reg + ENETC4_SICBDRPIR);
+	regs.cir = (void *)((size_t)hw->reg + ENETC4_SICBDRCIR);
+	regs.mr = (void *)((size_t)hw->reg + ENETC4_SICBDRMR);
+	regs.st = (void *)((size_t)hw->reg + ENETC4_SICBDRSR);
+	regs.bar0 = (void *)((size_t)hw->reg + ENETC4_SICBDRBAR0);
+	regs.bar1 = (void *)((size_t)hw->reg + ENETC4_SICBDRBAR1);
+	regs.lenr = (void *)((size_t)hw->reg + ENETC4_SICBDRLENR);
+	regs.sictr0 = (void *)((size_t)hw->reg + ENETC4_SICTR0);
+	regs.sictr1 = (void *)((size_t)hw->reg + ENETC4_SICTR1);
+
+	return netc_setup_cbdr(dev, bd_count, &regs, cbdr);
+}
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index 6680b46103..a2b8153085 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -389,6 +389,16 @@ enetc_dev_rx_parse(struct rte_mbuf *m, uint16_t parse_results)
 				 RTE_PTYPE_L3_IPV6 |
 				 RTE_PTYPE_L4_ICMP;
 		return;
+	case ENETC_PKT_TYPE_IPV4_FRAG:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+				 RTE_PTYPE_L3_IPV4 |
+				 RTE_PTYPE_L4_FRAG;
+		return;
+	case ENETC_PKT_TYPE_IPV6_FRAG:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+				 RTE_PTYPE_L3_IPV6 |
+				 RTE_PTYPE_L4_FRAG;
+		return;
 	/* More switch cases can be added */
 	default:
 		enetc_slow_parsing(m, parse_results);
diff --git a/drivers/net/enetc/meson.build b/drivers/net/enetc/meson.build
index 6e00758a36..fe8fdc07f3 100644
--- a/drivers/net/enetc/meson.build
+++ b/drivers/net/enetc/meson.build
@@ -8,10 +8,11 @@ endif
 
 deps += ['common_dpaax']
 sources = files(
-	'enetc4_ethdev.c',
-	'enetc4_vf.c',
+        'enetc4_ethdev.c',
+        'enetc4_vf.c',
         'enetc_ethdev.c',
         'enetc_rxtx.c',
+        'enetc_cbdr.c',
 )
 
 includes += include_directories('base')
diff --git a/drivers/net/enetc/ntmp.h b/drivers/net/enetc/ntmp.h
new file mode 100644
index 0000000000..0dbc006f26
--- /dev/null
+++ b/drivers/net/enetc/ntmp.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ */
+
+#ifndef ENETC_NTMP_H
+#define ENETC_NTMP_H
+
+#include "compat.h"
+#include <linux/types.h>
+
+#define BITS_PER_LONG   (__SIZEOF_LONG__ * 8)
+#define BITS_PER_LONG_LONG  (__SIZEOF_LONG_LONG__ * 8)
+#define GENMASK(h, l)       (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+
+/* define NTMP Operation Commands */
+#define NTMP_CMD_DELETE			BIT(0)
+#define NTMP_CMD_UPDATE			BIT(1)
+#define NTMP_CMD_QUERY			BIT(2)
+
+#define NETC_CBDR_TIMEOUT		1000 /* us */
+#define NETC_CBDR_BD_NUM		256
+#define NETC_CBDR_BASE_ADDR_ALIGN	128
+#define NETC_CBD_DATA_ADDR_ALIGN	16
+#define NETC_CBDRMR_EN			BIT(31)
+
+#define NTMP_RESP_HDR_ERR		GENMASK(11, 0)
+
+struct common_req_data {
+	uint16_t update_act;
+	uint8_t dbg_opt;
+	uint8_t query_act:4;
+	uint8_t tbl_ver:4;
+};
+
+/* RSS Table Request and Response Data Buffer Format */
+struct rsst_req_query {
+	struct common_req_data crd;
+	uint32_t entry_id;
+};
+
+/* struct for update operation */
+struct rsst_req_update {
+	struct common_req_data crd;
+	uint32_t entry_id;
+	uint8_t groups[];
+};
+
+/* The format of conctrol buffer descriptor */
+union netc_cbd {
+	struct {
+		uint64_t addr;
+		uint32_t len;
+		uint8_t cmd;
+		uint8_t resv1:4;
+		uint8_t access_method:4;
+		uint8_t table_id;
+		uint8_t hdr_ver:6;
+		uint8_t cci:1;
+		uint8_t rr:1;
+		uint32_t resv2[3];
+		uint32_t npf;
+	} ntmp_req_hdr;	/* NTMP Request Message Header Format */
+
+	struct {
+		uint32_t resv1[3];
+		uint16_t num_matched;
+		uint16_t error_rr; /* bit0~11: error, bit12~14: reserved, bit15: rr */
+		uint32_t resv3[4];
+	} ntmp_resp_hdr; /* NTMP Response Message Header Format */
+};
+
+struct netc_cbdr_regs {
+	void *pir;
+	void *cir;
+	void *mr;
+	void *st;
+
+	void *bar0;
+	void *bar1;
+	void *lenr;
+
+	/* station interface current time register */
+	void *sictr0;
+	void *sictr1;
+};
+
+struct netc_cbdr {
+	struct netc_cbdr_regs regs;
+
+	int bd_num;
+	int next_to_use;
+	int next_to_clean;
+
+	int dma_size;
+	void *addr_base;
+	void *addr_base_align;
+	dma_addr_t dma_base;
+	dma_addr_t dma_base_align;
+	struct rte_eth_dev *dma_dev;
+
+	rte_spinlock_t ring_lock; /* Avoid race condition */
+
+	/* bitmap of used words of SGCL table */
+	unsigned long *sgclt_used_words;
+	uint32_t sgclt_words_num;
+	uint32_t timeout;
+	uint32_t delay;
+};
+
+#endif /* ENETC_NTMP_H */
-- 
2.25.1

