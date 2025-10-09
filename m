Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C9CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A6FA40669;
	Thu,  9 Oct 2025 13:16:42 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 202E1402A3
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:37 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED15C201F3A;
 Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7DD4201F2F;
 Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 31CE51800096;
 Thu,  9 Oct 2025 19:16:36 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v1 04/12] net/enetc: Add TX checksum offload and RX checksum
 validation
Date: Thu,  9 Oct 2025 16:46:25 +0530
Message-Id: <20251009111633.3585957-5-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
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

This patch add support for:

- L3 (IPv4, IPv6) TX checksum offload
- L4 (TCP, UDP) TX checksum offload
- RX checksum validation for IPv4, IPv6, TCP, UDP

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |  2 ++
 drivers/net/enetc/base/enetc4_hw.h  | 14 ++++++++++
 drivers/net/enetc/base/enetc_hw.h   | 18 ++++++++++---
 drivers/net/enetc/enetc.h           |  5 ++++
 drivers/net/enetc/enetc4_ethdev.c   | 40 +++++++++++++++++++++++++++++
 drivers/net/enetc/enetc_rxtx.c      | 22 ++++++++++++++++
 6 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 37b548dcab..55b3b95953 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,8 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+L3 checksum offload  = Y
+L4 checksum offload  = Y
 Queue start/stop     = Y
 Linux                = Y
 ARMv8                = Y
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 759cfaba28..114d27f34b 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -14,12 +14,26 @@
 #define ENETC4_DEV_ID_VF	0xef00
 #define PCI_VENDOR_ID_NXP	0x1131
 
+/* enetc4 txbd flags */
+#define ENETC4_TXBD_FLAGS_L4CS		BIT(0)
+#define ENETC4_TXBD_FLAGS_L_TX_CKSUM	BIT(3)
 #define ENETC4_TXBD_FLAGS_F		BIT(7)
+/* L4 type */
+#define ENETC4_TXBD_L4T_UDP		BIT(0)
+#define ENETC4_TXBD_L4T_TCP		BIT(1)
+/* L3 type is set to 0 for IPv4 and 1 for IPv6 */
+#define ENETC4_TXBD_L3T			0
+/* IPv4 checksum */
+#define ENETC4_TXBD_IPCS		1
 
 /***************************ENETC port registers**************************/
 #define ENETC4_PMR		0x10
 #define ENETC4_PMR_EN		(BIT(16) | BIT(17) | BIT(18))
 
+#define ENETC4_PARCSCR		0x9c
+#define L3_CKSUM		BIT(0)
+#define L4_CKSUM		BIT(1)
+
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR		0x200
 #define PSIPMMR_SI0_MAC_UP	BIT(0)
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 2d63c54db6..3cdfe23fc0 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -189,8 +189,7 @@ enum enetc_bdr_type {TX, RX};
 
 #define ENETC_TX_ADDR(txq, addr) ((void *)((txq)->enetc_txbdr + (addr)))
 
-#define ENETC_TXBD_FLAGS_IE		BIT(13)
-#define ENETC_TXBD_FLAGS_F		BIT(15)
+#define ENETC_TXBD_FLAGS_F		BIT(7)
 
 /* ENETC Parsed values (Little Endian) */
 #define ENETC_PARSE_ERROR		0x8000
@@ -249,8 +248,19 @@ struct enetc_tx_bd {
 	uint64_t addr;
 	uint16_t buf_len;
 	uint16_t frm_len;
-	uint16_t err_csum;
-	uint16_t flags;
+	union {
+		struct {
+			uint8_t l3_start:7;
+			uint8_t ipcs:1;
+			uint8_t l3_hdr_size:7;
+			uint8_t l3t:1;
+			uint8_t resv:5;
+			uint8_t l4t:3;
+			uint8_t flags;
+		};/* default layout */
+		uint32_t txstart;
+		uint32_t lstatus;
+	};
 };
 
 /* RX buffer descriptor */
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 99a2d22b22..ab9e6cbd6b 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -45,6 +45,11 @@
 #define ENETC_TXBD(BDR, i) (&(((struct enetc_tx_bd *)((BDR).bd_base))[i]))
 #define ENETC_RXBD(BDR, i) (&(((union enetc_rx_bd *)((BDR).bd_base))[i]))
 
+#define ENETC4_MBUF_F_TX_IP_IPV4 (RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_IPV4)
+#define ENETC4_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM | \
+				    RTE_MBUF_F_TX_TCP_CKSUM | \
+				    RTE_MBUF_F_TX_UDP_CKSUM)
+
 struct enetc_swbd {
 	struct rte_mbuf *buffer_addr;
 };
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 6970626220..0eb9551b63 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -10,6 +10,18 @@
 #include "enetc_logs.h"
 #include "enetc.h"
 
+/* Supported Rx offloads */
+static uint64_t dev_rx_offloads_sup =
+	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+	RTE_ETH_RX_OFFLOAD_TCP_CKSUM;
+
+/* Supported Tx offloads */
+static uint64_t dev_tx_offloads_sup =
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM;
+
 static int
 enetc4_dev_start(struct rte_eth_dev *dev)
 {
@@ -127,6 +139,8 @@ enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
 	dev_info->max_rx_queues = MAX_RX_RINGS;
 	dev_info->max_tx_queues = MAX_TX_RINGS;
 	dev_info->max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
+	dev_info->rx_offload_capa = dev_rx_offloads_sup;
+	dev_info->tx_offload_capa = dev_tx_offloads_sup;
 
 	return 0;
 }
@@ -464,6 +478,10 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 {
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_conf *eth_conf = &dev->data->dev_conf;
+	uint64_t rx_offloads = eth_conf->rxmode.offloads;
+	uint64_t tx_offloads = eth_conf->txmode.offloads;
+	uint32_t checksum = L3_CKSUM | L4_CKSUM;
 	struct enetc_hw *enetc_hw = &hw->hw;
 	uint32_t max_len;
 	uint32_t val;
@@ -477,6 +495,28 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	val = ENETC4_MAC_MAXFRM_SIZE | SDU_TYPE_MPDU;
 	enetc4_port_wr(enetc_hw, ENETC4_PTCTMSDUR(0), val | SDU_TYPE_MPDU);
 
+	/* Rx offloads which are enabled by default */
+	if (dev_rx_offloads_sup & ~rx_offloads) {
+		ENETC_PMD_INFO("Some of rx offloads enabled by default"
+				" - requested 0x%" PRIx64 " fixed are 0x%" PRIx64,
+				rx_offloads, dev_rx_offloads_sup);
+	}
+
+	/* Tx offloads which are enabled by default */
+	if (dev_tx_offloads_sup & ~tx_offloads) {
+		ENETC_PMD_INFO("Some of tx offloads enabled by default"
+			       " - requested 0x%" PRIx64 " fixed are 0x%" PRIx64,
+			       tx_offloads, dev_tx_offloads_sup);
+	}
+
+	if (rx_offloads & RTE_ETH_RX_OFFLOAD_IPV4_CKSUM)
+		checksum &= ~L3_CKSUM;
+
+	if (rx_offloads & (RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM))
+		checksum &= ~L4_CKSUM;
+
+	enetc4_port_wr(enetc_hw, ENETC4_PARCSCR, checksum);
+
 	return 0;
 }
 
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index 9922915cf5..6680b46103 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -124,6 +124,26 @@ enetc_xmit_pkts(void *tx_queue,
 	return start;
 }
 
+static void
+enetc4_tx_offload_checksum(struct rte_mbuf *mbuf, struct enetc_tx_bd *txbd)
+{
+	if ((mbuf->ol_flags & (RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_IPV4))
+						== ENETC4_MBUF_F_TX_IP_IPV4) {
+		txbd->l3t = ENETC4_TXBD_L3T;
+		txbd->ipcs = ENETC4_TXBD_IPCS;
+		txbd->l3_start = mbuf->l2_len;
+		txbd->l3_hdr_size = mbuf->l3_len / 4;
+		txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_L_TX_CKSUM);
+		if ((mbuf->ol_flags & RTE_MBUF_F_TX_UDP_CKSUM) == RTE_MBUF_F_TX_UDP_CKSUM) {
+			txbd->l4t = rte_cpu_to_le_16(ENETC4_TXBD_L4T_UDP);
+			txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_L4CS);
+		} else if ((mbuf->ol_flags & RTE_MBUF_F_TX_TCP_CKSUM) == RTE_MBUF_F_TX_TCP_CKSUM) {
+			txbd->l4t = rte_cpu_to_le_16(ENETC4_TXBD_L4T_TCP);
+			txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_L4CS);
+		}
+	}
+}
+
 uint16_t
 enetc_xmit_pkts_nc(void *tx_queue,
 		struct rte_mbuf **tx_pkts,
@@ -153,6 +173,8 @@ enetc_xmit_pkts_nc(void *tx_queue,
 
 		txbd = ENETC_TXBD(*tx_ring, i);
 		txbd->flags = rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
+		if (tx_ring->q_swbd[i].buffer_addr->ol_flags & ENETC4_TX_CKSUM_OFFLOAD_MASK)
+			enetc4_tx_offload_checksum(tx_ring->q_swbd[i].buffer_addr, txbd);
 
 		tx_swbd = &tx_ring->q_swbd[i];
 		txbd->frm_len = buflen;
-- 
2.25.1

