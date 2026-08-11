Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B0C5B574
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E5240E18;
	Tue, 11 Aug 2026 09:40:40 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id AE8D340272
 for <dev@dpdk.org>; Tue, 11 Aug 2026 09:40:37 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FCCB1A016D;
 Tue, 11 Aug 2026 09:40:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 595EE1A016C;
 Tue, 11 Aug 2026 09:40:37 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 86DC218000B1;
 Tue, 11 Aug 2026 15:40:36 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v6 01/13] net/enetc: add keep-CRC Rx offload for ENETC4
Date: Tue, 11 Aug 2026 13:10:20 +0530
Message-Id: <20260811074032.3646324-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811074032.3646324-1-g.singh@nxp.com>
References: <20260810104815.2827703-1-g.singh@nxp.com>
 <20260811074032.3646324-1-g.singh@nxp.com>
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

The legacy ENETC (LS1028A) driver already supports the
RTE_ETH_RX_OFFLOAD_KEEP_CRC offload, but ENETC4 (i.MX95 NETC) did not.

Add KEEP_CRC support for ENETC4 (both PF and VF):

- Advertise RTE_ETH_RX_OFFLOAD_KEEP_CRC in the supported Rx offloads
  for the ENETC4 PF and VF. The VF reuses the PF Rx queue setup, so the
  HW configuration and datapath handling apply to both.
- Configure the per-ring RBaMR[CRC] bit in the Rx queue setup so that
  HW preserves the Ethernet FCS in the receive buffer when the offload
  is requested (0 = FCS removed, 1 = FCS preserved).
- Follow the DPDK convention used by the legacy ENETC and ixgbe drivers:
  set crc_len to RTE_ETHER_CRC_LEN when KEEP_CRC is enabled and have the
  datapath subtract crc_len from pkt_len/data_len. ENETC and ENETC4 share
  the same datapath (enetc_rxtx.c), so the semantics stay consistent.
- Handle the scatter-gather boundary case where the 4-byte FCS straddles
  the last two segments: drop the trailing segment, decrement nb_segs and
  trim the carry-over from its predecessor.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini    |  1 +
 doc/guides/rel_notes/release_26_11.rst |  6 ++++
 drivers/net/enetc/base/enetc4_hw.h     |  3 ++
 drivers/net/enetc/enetc4_ethdev.c      | 45 ++++++++++++++++----------
 drivers/net/enetc/enetc4_vf.c          |  1 +
 drivers/net/enetc/enetc_rxtx.c         | 39 +++++++++++++++++++---
 6 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 698140e30b..91b18d979e 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -16,6 +16,7 @@ Packet type parsing  = Y
 Basic stats          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
+CRC offload          = Y
 Queue start/stop     = Y
 Scattered Rx         = Y
 Linux                = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..3678dd6894 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -56,6 +56,12 @@ New Features
      =======================================================
 
 
+* **Updated NXP ENETC4 PMD.**
+
+  Updated the NXP ENETC4 poll mode driver for i.MX95:
+
+  * Added KEEP_CRC Rx offload support for the ENETC4 PMD to preserve the Ethernet FCS.
+
 Removed Items
 -------------
 
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 9685e7e1e5..c81ac00ec6 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -68,6 +68,9 @@ struct enetc_msg_swbd {
 #define PM_CMD_CFG_TX_EN		BIT(0)
 #define PM_CMD_CFG_RX_EN		BIT(1)
 
+/* RBaMR[CRC]: 0 = FCS removed, 1 = FCS preserved (KEEP_CRC) */
+#define ENETC4_RBMR_CRC			BIT(8)
+
 /* i.MX95 supports jumbo frame, but it is recommended to set the max frame
  * size to 2000 bytes.
  */
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 2ddd63dafb..91e2cdb129 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -11,6 +11,21 @@
 #include "enetc_logs.h"
 #include "enetc.h"
 
+/* Supported Rx offloads */
+static uint64_t dev_rx_offloads_sup =
+	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+	RTE_ETH_RX_OFFLOAD_SCATTER |
+	RTE_ETH_RX_OFFLOAD_KEEP_CRC;
+
+/* Supported Tx offloads */
+static uint64_t dev_tx_offloads_sup =
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+	RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
 #define ENETC4_TXQ_PRIORITIES	"enetc4_txq_prior"
 #define ENETC4_NC_MEMORY	"nc"
 
@@ -93,20 +108,6 @@ enetc4_get_devargs(struct rte_eth_dev *dev, const char *key)
 	return 0;
 }
 
-/* Supported Rx offloads */
-static uint64_t dev_rx_offloads_sup =
-	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
-	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
-	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-	RTE_ETH_RX_OFFLOAD_SCATTER;
-
-/* Supported Tx offloads */
-static uint64_t dev_tx_offloads_sup =
-	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
-	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
-	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
-	RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-
 static int
 enetc4_dev_start(struct rte_eth_dev *dev)
 {
@@ -536,6 +537,7 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	struct enetc_eth_adapter *adapter =
 			ENETC_DEV_PRIVATE(data->dev_private);
 	uint64_t rx_offloads = data->dev_conf.rxmode.offloads;
+	bool keep_crc;
 
 	PMD_INIT_FUNC_TRACE();
 	if (nb_rx_desc > MAX_BD_COUNT)
@@ -549,6 +551,9 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	rx_ring->index = rx_queue_id;
+	keep_crc = !!(rx_offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC);
+	rx_ring->crc_len = (uint8_t)(keep_crc ? RTE_ETHER_CRC_LEN : 0);
+
 	err = enetc4_alloc_rxbdr(rx_ring, nb_rx_desc);
 	if (err)
 		goto fail;
@@ -562,19 +567,25 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	data->rx_queues[rx_queue_id] = rx_ring;
 	rx_ring->rx_deferred_start = rx_conf->rx_deferred_start;
 
+	if (keep_crc)
+		rx_enable |= ENETC4_RBMR_CRC;
+	else
+		rx_enable &= ~ENETC4_RBMR_CRC;
+
 	if (!rx_conf->rx_deferred_start) {
 		/* enable ring */
+		rx_enable |= ENETC_RBMR_EN;
 		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index, ENETC_RBMR,
-			       ENETC_RBMR_EN);
+			       rx_enable);
 		dev->data->rx_queue_state[rx_ring->index] =
 			       RTE_ETH_QUEUE_STATE_STARTED;
 	} else {
+		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index, ENETC_RBMR,
+			       rx_enable);
 		dev->data->rx_queue_state[rx_ring->index] =
 			       RTE_ETH_QUEUE_STATE_STOPPED;
 	}
 
-	rx_ring->crc_len = (uint8_t)((rx_offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC) ?
-				     RTE_ETHER_CRC_LEN : 0);
 	return 0;
 fail:
 	rte_free(rx_ring);
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index ef5f1e6d66..83a1e4931f 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -52,6 +52,7 @@ static uint64_t dev_rx_offloads_sup =
 	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
 	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
 	RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+	RTE_ETH_RX_OFFLOAD_KEEP_CRC |
 	RTE_ETH_RX_OFFLOAD_SCATTER;
 
 /* Supported Tx offloads */
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index 8678bafece..d5855e69a3 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -530,6 +530,28 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	return rx_frm_cnt;
 }
 
+/*
+ * Trim the Ethernet FCS from a received cluster when HW CRC strip is
+ * disabled. pkt_len is reduced by crc_len. If the FCS straddles the last
+ * two segments (last seg holds fewer bytes than crc_len), drop the trailing
+ * segment and trim the carry-over from its predecessor. prev_seg is the
+ * segment preceding last_seg in the chain (the caller already tracks it).
+ */
+static inline void
+enetc_rx_crc_trim(struct rte_mbuf *first_seg, struct rte_mbuf *prev_seg,
+		  struct rte_mbuf *last_seg, uint16_t crc_len)
+{
+	first_seg->pkt_len -= crc_len;
+	if (likely(last_seg->data_len > crc_len)) {
+		last_seg->data_len -= crc_len;
+	} else if (prev_seg != NULL) {
+		first_seg->nb_segs--;
+		prev_seg->data_len -= crc_len - last_seg->data_len;
+		prev_seg->next = NULL;
+		rte_pktmbuf_free_seg(last_seg);
+	}
+}
+
 static int
 enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 		    struct rte_mbuf **rx_pkts,
@@ -539,7 +561,7 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 	int cleaned_cnt, i;
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd, rxbd_temp;
-	struct rte_mbuf *first_seg, *cur_seg;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL, *prev_seg = NULL;
 	uint32_t bd_status;
 	uint8_t *data;
 	uint32_t j;
@@ -572,6 +594,7 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 		if (!first_seg) {
 			first_seg = seg;
 			cur_seg = seg;
+			prev_seg = NULL;
 			first_seg->pkt_len = data_len;
 			enetc_dev_rx_parse(first_seg, rxbd_temp.r.parse_summary);
 			first_seg->hash.rss = rxbd_temp.r.rss_hash;
@@ -579,6 +602,7 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 			first_seg->pkt_len += data_len;
 			first_seg->nb_segs++;
 			cur_seg->next = seg;
+			prev_seg = cur_seg;
 			cur_seg = seg;
 		}
 
@@ -590,7 +614,9 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 
 		if (bd_status & ENETC_RXBD_LSTATUS_F) {
 			seg->next = NULL;
-			first_seg->pkt_len -= rx_ring->crc_len;
+			if (rx_ring->crc_len)
+				enetc_rx_crc_trim(first_seg, prev_seg, seg,
+						  rx_ring->crc_len);
 			rx_pkts[rx_frm_cnt] = first_seg;
 			rx_frm_cnt++;
 			first_seg = NULL;
@@ -760,7 +786,7 @@ enetc_clean_rx_ring_cacheable(struct enetc_bdr *rx_ring,
 	int cleaned_cnt, i;
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd;
-	struct rte_mbuf *first_seg, *cur_seg;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL, *prev_seg = NULL;
 	uint32_t bd_status;
 	uint8_t *data;
 	uint32_t j;
@@ -815,6 +841,7 @@ enetc_clean_rx_ring_cacheable(struct enetc_bdr *rx_ring,
 		if (!first_seg) {
 			first_seg = seg;
 			cur_seg = seg;
+			prev_seg = NULL;
 			first_seg->pkt_len = data_len;
 			enetc_dev_rx_parse(first_seg,
 					   rxbd->r.parse_summary);
@@ -823,6 +850,7 @@ enetc_clean_rx_ring_cacheable(struct enetc_bdr *rx_ring,
 			first_seg->pkt_len += data_len;
 			first_seg->nb_segs++;
 			cur_seg->next = seg;
+			prev_seg = cur_seg;
 			cur_seg = seg;
 		}
 
@@ -838,7 +866,10 @@ enetc_clean_rx_ring_cacheable(struct enetc_bdr *rx_ring,
 
 		if (bd_status & ENETC_RXBD_LSTATUS_F) {
 			seg->next = NULL;
-			first_seg->pkt_len -= rx_ring->crc_len;
+			if (rx_ring->crc_len)
+				enetc_rx_crc_trim(first_seg, prev_seg, seg,
+						  rx_ring->crc_len);
+
 			rx_pkts[rx_frm_cnt] = first_seg;
 			rx_frm_cnt++;
 			first_seg = NULL;
-- 
2.25.1

