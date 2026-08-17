Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD9C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F29640655;
	Mon, 17 Aug 2026 08:35:04 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0FBF140294
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:35:00 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DBEC42001DA;
 Mon, 17 Aug 2026 08:34:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A6522001D2;
 Mon, 17 Aug 2026 08:34:59 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9DDF618000B0;
 Mon, 17 Aug 2026 14:34:58 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v10 02/14] net/enetc: add TSO support for ENETC4 VF
Date: Mon, 17 Aug 2026 12:04:42 +0530
Message-Id: <20260817063454.3290854-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817063454.3290854-1-g.singh@nxp.com>
References: <20260813121358.1321196-1-g.singh@nxp.com>
 <20260817063454.3290854-1-g.singh@nxp.com>
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

Add TCP and UDP segmentation offload (TSO) for the ENETC4 virtual
function. The offload is advertised through the VF Tx capabilities and
is enabled on a per-queue basis when an application requests the TSO
offload flags during Tx queue setup.

A dedicated Tx burst, enetc_xmit_pkts_lso(), builds the large-send
descriptor chain: a standard header BD, a 16B extension BD carrying the
segment size and frame length extension, and one BD per payload buffer
with the final-frame flag on the last BD. To make room for the extra
extension BD, an LSO-enabled Tx ring is allocated with twice the number
of descriptors. The existing non-TSO Tx paths are left unchanged.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             |   2 +
 doc/guides/nics/features/enetc4.ini    |   1 +
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/base/enetc4_hw.h     |  34 +++-
 drivers/net/enetc/enetc.h              |   3 +
 drivers/net/enetc/enetc4_ethdev.c      |  54 +++++-
 drivers/net/enetc/enetc4_vf.c          |   2 +
 drivers/net/enetc/enetc_rxtx.c         | 257 +++++++++++++++++++++++++
 8 files changed, 349 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index f0dd039f6e..4d27e4048e 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -53,6 +53,8 @@ Key functionality includes:
 - Receive processing: Upon packet reception, the BD Ring status bit is set,
   facilitating packet processing.
 - Transmission: Packet transmission precedes reception, ensuring efficient data transfer.
+- TCP and UDP segmentation offload (TSO) on VFs, enabled per Tx queue
+  when the TSO offload flag is requested.
 
 
 Prerequisites
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 91b18d979e..8ec1e8d00f 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -7,6 +7,7 @@
 Link status event    = Y
 Speed capabilities   = Y
 Link status          = Y
+TSO                  = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 3678dd6894..6a348ab4e0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -61,6 +61,7 @@ New Features
   Updated the NXP ENETC4 poll mode driver for i.MX95:
 
   * Added KEEP_CRC Rx offload support for the ENETC4 PMD to preserve the Ethernet FCS.
+  * Added TCP Segmentation Offload (TSO) support for the ENETC4 VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index c81ac00ec6..6bc462a93e 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2024 NXP
+ * Copyright 2024-2026 NXP
  *
  * This header file defines the register offsets and bit fields
  * of ENETC4 PF and VFs.
@@ -24,7 +24,12 @@ struct enetc_msg_swbd {
 
 /* enetc4 txbd flags */
 #define ENETC4_TXBD_FLAGS_L4CS		BIT(0)
+/* Request LSO (Large Send Offload) segmentation for this frame */
+#define ENETC4_TXBD_FLAGS_LSO		BIT(1)
+/* L4 checksum insertion (also used for checksum update on LSO) */
 #define ENETC4_TXBD_FLAGS_L_TX_CKSUM	BIT(3)
+/* Extended descriptor: the next 16B ring entry is an extension BD */
+#define ENETC4_TXBD_FLAGS_EXT		BIT(6)
 #define ENETC4_TXBD_FLAGS_F		BIT(7)
 /* L4 type */
 #define ENETC4_TXBD_L4T_UDP		BIT(0)
@@ -34,6 +39,33 @@ struct enetc_msg_swbd {
 /* IPv4 checksum */
 #define ENETC4_TXBD_IPCS		1
 
+/*
+ * Extension Transmit Buffer Descriptor (16B). When the standard BD has the
+ * extended flag set, this occupies the next ring entry and carries the extra
+ * fields required by LSO.
+ */
+struct enetc_tx_bd_ext {
+	uint32_t timestamp;	/* PTP timestamp, unused for LSO */
+	uint32_t vlan;		/* VLAN insert, unused for LSO */
+	uint32_t lso;		/* LSO_MAX_SEG_SIZE and FRM_LEN_EXT */
+	uint32_t flags;		/* extension flags */
+};
+
+/* LSO_MAX_SEG_SIZE occupies bits 13-0 of the LSO word */
+#define ENETC4_TXBD_EXT_LSO_SEG_MASK	0x3fff
+#define ENETC4_TXBD_EXT_LSO_SEG(mss) \
+		((uint32_t)((mss) & ENETC4_TXBD_EXT_LSO_SEG_MASK))
+/* FRM_LEN_EXT occupies bits 19-16 of the LSO word (top 4 bits of data len) */
+#define ENETC4_TXBD_EXT_FRM_LEN_EXT(x) \
+		(((uint32_t)((x) & 0xf)) << 16)
+/* Final flag in the extension flags word (bit 127 -> local bit 31) */
+#define ENETC4_TXBD_EXT_FLAGS_F		BIT(31)
+
+/* NETC does not create LSO frames larger than this many bytes */
+#define ENETC4_LSO_MAX_FRAME		9600
+/* Maximum LSO data unit (payload to be segmented) supported by HW: 256KB */
+#define ENETC4_LSO_MAX_DATA_UNIT	(256 * 1024)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_PMR		0x10
 #define ENETC4_PMR_EN		(BIT(16) | BIT(17) | BIT(18))
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index d3a8b8e34a..6cd031f269 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -99,6 +99,7 @@ struct enetc_bdr {
 	uint64_t ierrors;
 	uint8_t rx_deferred_start;
 	uint8_t tx_deferred_start;
+	uint8_t lso_enable;
 };
 
 struct enetc_eth_hw {
@@ -312,6 +313,8 @@ uint16_t enetc_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
 uint16_t enetc_xmit_pkts_nc(void *txq, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
+uint16_t enetc_xmit_pkts_lso(void *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts);
 uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 uint16_t enetc_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 91e2cdb129..0ee5e36609 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -24,7 +24,9 @@ static uint64_t dev_tx_offloads_sup =
 	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
 	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
 	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
-	RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+	RTE_ETH_TX_OFFLOAD_TCP_TSO |
+	RTE_ETH_TX_OFFLOAD_UDP_TSO;
 
 #define ENETC4_TXQ_PRIORITIES	"enetc4_txq_prior"
 #define ENETC4_NC_MEMORY	"nc"
@@ -309,22 +311,37 @@ static int
 enetc4_alloc_txbdr(struct enetc_bdr *txr, uint16_t nb_desc)
 {
 	int size;
+	uint32_t ring_desc;
 
-	size = nb_desc * sizeof(struct enetc_swbd);
+	/*
+	 * On LSO-enabled rings each frame uses an extra 16B extension BD
+	 * (logical 32B descriptor) plus the payload BDs.  Size the ring with
+	 * twice the requested entries so the effective frame capacity is
+	 * preserved.  Non-LSO rings are sized exactly as requested.
+	 */
+	ring_desc = txr->lso_enable ? (uint32_t)nb_desc * 2 : (uint32_t)nb_desc;
+	if (ring_desc > MAX_BD_COUNT) {
+		ENETC_PMD_ERR("LSO ring_desc %u > MAX_BD_COUNT %u; "
+			      "reduce nb_desc to <= %u with LSO enabled",
+			      ring_desc, MAX_BD_COUNT, MAX_BD_COUNT / 2);
+		return -EINVAL;
+	}
+
+	size = ring_desc * sizeof(struct enetc_swbd);
 	/* Zero q_swbd so buffer_addr is NULL for all uninitialized slots. */
 	txr->q_swbd = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (txr->q_swbd == NULL)
 		return -ENOMEM;
 
 	/* Allocate the TX BD ring: each BD is struct enetc_tx_bd (16 bytes). */
-	size = nb_desc * sizeof(struct enetc_tx_bd);
+	size = ring_desc * sizeof(struct enetc_tx_bd);
 	txr->bd_base = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (txr->bd_base == NULL) {
 		rte_free(txr->q_swbd);
 		txr->q_swbd = NULL;
 		return -ENOMEM;
 	}
-	txr->bd_count = nb_desc;
+	txr->bd_count = ring_desc;
 	txr->next_to_clean = 0;
 	txr->next_to_use = 0;
 
@@ -376,6 +393,7 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 	struct rte_eth_dev_data *data = dev->data;
 	struct enetc_eth_adapter *priv =
 			ENETC_DEV_PRIVATE(data->dev_private);
+	uint64_t tx_offloads;
 
 	PMD_INIT_FUNC_TRACE();
 	if (nb_desc > MAX_BD_COUNT)
@@ -389,6 +407,34 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	tx_ring->index = queue_idx;
+	/*
+	 * LSO (TCP/UDP segmentation) is a port-level offload. The Tx burst is
+	 * a single device-level function pointer, so it must be consistent for
+	 * all queues; likewise every ring must be sized the same way. Decide
+	 * from the port offloads only (not the per-queue tx_conf) so that all
+	 * queues either use the LSO burst with a doubled ring, or none do.
+	 * The LSO burst also handles non-TSO packets, so it is safe on queues
+	 * that never carry TSO traffic. LSO needs HW FCS insertion, so it is
+	 * incompatible with KEEP_CRC on Rx.
+	 */
+	tx_offloads = data->dev_conf.txmode.offloads;
+	if (tx_offloads & (RTE_ETH_TX_OFFLOAD_TCP_TSO |
+			   RTE_ETH_TX_OFFLOAD_UDP_TSO)) {
+		if (data->dev_conf.rxmode.offloads &
+		    RTE_ETH_RX_OFFLOAD_KEEP_CRC) {
+			ENETC_PMD_ERR("LSO (TSO) is incompatible with KEEP_CRC");
+			rte_free(tx_ring);
+			return -EINVAL;
+		}
+		tx_ring->lso_enable = 1;
+		dev->tx_pkt_burst = &enetc_xmit_pkts_lso;
+	} else {
+		struct enetc_eth_hw *hw =
+			ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+		dev->tx_pkt_burst = hw->nc_mode ? &enetc_xmit_pkts_nc :
+						  &enetc_xmit_pkts_cacheable;
+	}
+
 	err = enetc4_alloc_txbdr(tx_ring, nb_desc);
 	if (err)
 		goto fail;
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 83a1e4931f..3083a56335 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -60,6 +60,8 @@ static uint64_t dev_tx_offloads_sup =
 	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
 	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
 	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+	RTE_ETH_TX_OFFLOAD_TCP_TSO |
+	RTE_ETH_TX_OFFLOAD_UDP_TSO |
 	RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 static void
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index d5855e69a3..0bb5a86dd8 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -221,6 +221,263 @@ enetc_xmit_pkts_nc(void *tx_queue,
 	return start;
 }
 
+/*
+ * LSO (Large Send Offload) Tx burst.
+ *
+ * Dedicated burst used on Tx rings with LSO enabled (txr->lso_enable). It
+ * follows the same non-cache-coherent discipline as enetc_xmit_pkts_cacheable:
+ * payload lines are flushed with dcbf before handing the frame to HW and the
+ * written BD cache lines are flushed at the end of the batch.
+ *
+ * A TSO/USO frame uses an extended Tx descriptor: the standard BD points at
+ * the L2/L3/L4 header template (BUF_LEN = header length, FRM_LEN = payload
+ * length), followed by an extension BD in the next ring slot holding the
+ * segment size, then one BD per payload buffer with the F flag on the last.
+ * Non-TSO packets fall through to the normal encoding so mixed traffic works.
+ */
+uint16_t
+enetc_xmit_pkts_lso(void *tx_queue,
+		struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts)
+{
+	int i, start, bds_to_use;
+	struct enetc_tx_bd *txbd = NULL;
+	struct enetc_tx_bd_ext *txbd_ext;
+	struct enetc_bdr *tx_ring = (struct enetc_bdr *)tx_queue;
+	unsigned int j;
+	uint8_t *data;
+	struct rte_mbuf *seg;
+	uint16_t seg_len, segs_per_pkt;
+	bool is_first_seg;
+	int first_bd_idx, bd_count;
+
+	i = tx_ring->next_to_use;
+	bds_to_use = enetc_bd_unused(tx_ring);
+	bd_count = tx_ring->bd_count;
+	start = 0;
+
+	first_bd_idx = i;
+
+	while (start < nb_pkts) {
+		seg = tx_pkts[start];
+		segs_per_pkt = seg->nb_segs;
+
+		if (seg->ol_flags &
+		    (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
+			bool is_udp_seg =
+				!!(seg->ol_flags & RTE_MBUF_F_TX_UDP_SEG);
+			uint32_t hdr_len = seg->l2_len + seg->l3_len +
+					   seg->l4_len;
+			uint32_t data_unit;
+			uint16_t first_payload;
+			struct rte_mbuf *dseg;
+			int bds_needed;
+
+			/* Header BD + extension BD + one BD per segment. */
+			bds_needed = 2 + segs_per_pkt;
+			if (bds_to_use < bds_needed)
+				break;
+
+			/*
+			 * Skip frames with nothing to segment, or whose
+			 * headers are not fully contained in the first
+			 * segment. The first BD carries the header template
+			 * and first_payload is computed as (first segment
+			 * data_len - hdr_len), so the L2/L3/L4 headers must
+			 * reside contiguously in the first mbuf; otherwise the
+			 * unsigned subtraction would underflow.
+			 */
+			if (unlikely(hdr_len >= rte_pktmbuf_pkt_len(seg) ||
+				     hdr_len > rte_pktmbuf_data_len(seg))) {
+				rte_pktmbuf_free(seg);
+				start++;
+				continue;
+			}
+			data_unit = rte_pktmbuf_pkt_len(seg) - hdr_len;
+
+			/*
+			 * Skip frames that violate HW LSO limits: a zero
+			 * segment size, a payload larger than the HW data
+			 * unit, or a per-segment frame (headers + segment)
+			 * bigger than the maximum LSO frame size.
+			 */
+			if (unlikely(seg->tso_segsz == 0 ||
+				     data_unit > ENETC4_LSO_MAX_DATA_UNIT ||
+				     hdr_len + seg->tso_segsz >
+					     ENETC4_LSO_MAX_FRAME)) {
+				rte_pktmbuf_free(seg);
+				start++;
+				continue;
+			}
+
+			/* Standard (first) BD: header template only. */
+			data = rte_pktmbuf_mtod(seg, void *);
+
+			seg_len = rte_pktmbuf_data_len(seg);
+			for (j = 0; j < seg_len; j += RTE_CACHE_LINE_SIZE)
+				dcbf(data + j);
+			dcbf(data + (seg_len - 1));
+
+			txbd = ENETC_TXBD(*tx_ring, i);
+			memset(txbd, 0, sizeof(*txbd));
+			tx_ring->q_swbd[i].buffer_addr = seg;
+
+			/* FRM_LEN low 16 bits = payload length, BUF_LEN = hdr. */
+			txbd->frm_len = rte_cpu_to_le_16(data_unit & 0xffff);
+			txbd->buf_len = rte_cpu_to_le_16((uint16_t)hdr_len);
+			txbd->addr = rte_cpu_to_le_64(rte_mbuf_data_iova(seg));
+
+			/* Checksum control for the per-segment L3/L4 rewrite. */
+			txbd->l3_start = seg->l2_len;
+			txbd->l3_hdr_size = seg->l3_len / 4;
+			if (seg->ol_flags & RTE_MBUF_F_TX_IPV6) {
+				txbd->l3t = 1;
+			} else {
+				txbd->l3t = ENETC4_TXBD_L3T;
+				txbd->ipcs = ENETC4_TXBD_IPCS;
+			}
+			txbd->l4t = is_udp_seg ? ENETC4_TXBD_L4T_UDP :
+						 ENETC4_TXBD_L4T_TCP;
+			txbd->flags = ENETC4_TXBD_FLAGS_L_TX_CKSUM |
+				      ENETC4_TXBD_FLAGS_L4CS |
+				      ENETC4_TXBD_FLAGS_LSO |
+				      ENETC4_TXBD_FLAGS_EXT;
+
+			i++;
+			bds_to_use--;
+			if (unlikely(i == bd_count))
+				i = 0;
+
+			/* Extension BD occupies the next ring slot. */
+			tx_ring->q_swbd[i].buffer_addr = NULL;
+			txbd_ext = (struct enetc_tx_bd_ext *)
+				   ENETC_TXBD(*tx_ring, i);
+			memset(txbd_ext, 0, sizeof(*txbd_ext));
+			txbd_ext->lso = rte_cpu_to_le_32(ENETC4_TXBD_EXT_LSO_SEG(seg->tso_segsz) |
+					ENETC4_TXBD_EXT_FRM_LEN_EXT(data_unit >> 16));
+
+			i++;
+			bds_to_use--;
+			if (unlikely(i == bd_count))
+				i = 0;
+
+			/*
+			 * Payload BDs. The first segment's payload starts after
+			 * the header template; remaining segments are pure
+			 * payload.
+			 */
+			first_payload = (uint16_t)(seg_len - hdr_len);
+			dseg = seg;
+			is_first_seg = true;
+			while (dseg) {
+				uint16_t dlen;
+				uint64_t daddr;
+
+				if (is_first_seg) {
+					dlen = first_payload;
+					daddr = rte_mbuf_data_iova(dseg) +
+						hdr_len;
+					is_first_seg = false;
+				} else {
+					dlen = rte_pktmbuf_data_len(dseg);
+					data = rte_pktmbuf_mtod(dseg, void *);
+					for (j = 0; j < dlen;
+					     j += RTE_CACHE_LINE_SIZE)
+						dcbf(data + j);
+					dcbf(data + (dlen - 1));
+					daddr = rte_mbuf_data_iova(dseg);
+				}
+
+				if (dlen == 0) {
+					dseg = dseg->next;
+					continue;
+				}
+
+				tx_ring->q_swbd[i].buffer_addr = NULL;
+				txbd = ENETC_TXBD(*tx_ring, i);
+				memset(txbd, 0, sizeof(*txbd));
+				txbd->buf_len = rte_cpu_to_le_16(dlen);
+				txbd->addr = rte_cpu_to_le_64(daddr);
+				i++;
+				bds_to_use--;
+				if (unlikely(i == bd_count))
+					i = 0;
+				dseg = dseg->next;
+			}
+
+			/* Mark the last written BD as frame-last. */
+			txbd->flags |= ENETC4_TXBD_FLAGS_F;
+			start++;
+			continue;
+		}
+
+		/* Non-TSO packet: standard single/multi-seg encoding. */
+		if (bds_to_use < segs_per_pkt)
+			break;
+
+		is_first_seg = true;
+		while (seg) {
+			tx_ring->q_swbd[i].buffer_addr = NULL;
+			seg_len = rte_pktmbuf_data_len(seg);
+			data = rte_pktmbuf_mtod(seg, void *);
+
+			for (j = 0; j < seg_len; j += RTE_CACHE_LINE_SIZE)
+				dcbf(data + j);
+			dcbf(data + (seg_len - 1));
+
+			txbd = ENETC_TXBD(*tx_ring, i);
+			txbd->flags = 0;
+			if (is_first_seg) {
+				tx_ring->q_swbd[i].buffer_addr = seg;
+				txbd->frm_len = rte_pktmbuf_pkt_len(seg);
+				if (seg->ol_flags & ENETC4_TX_CKSUM_OFFLOAD_MASK)
+					enetc4_tx_offload_checksum(seg, txbd);
+				is_first_seg = false;
+			}
+
+			txbd->buf_len = rte_cpu_to_le_16(seg_len);
+			txbd->addr = rte_cpu_to_le_64(rte_mbuf_data_iova(seg));
+			seg = seg->next;
+			i++;
+			bds_to_use--;
+
+			if (unlikely(i == bd_count))
+				i = 0;
+		}
+
+		txbd->flags |= ENETC4_TXBD_FLAGS_F;
+		start++;
+	}
+
+	/*
+	 * Flush TX BDs to PoC so HW (non-cache-coherent i.MX95) can read the
+	 * descriptors from memory.  Same discipline as enetc_xmit_pkts_cacheable:
+	 * walk from the cache-line-aligned start of first_bd_idx to just past
+	 * the last written BD, one dcbf per 64-byte (4-BD) line.
+	 */
+	if (likely(start > 0)) {
+		int n = first_bd_idx & ~ENETC_BD_PER_CL_MASK;
+		int written = (i - n + bd_count) % bd_count;
+
+		if (written == 0)
+			written = bd_count;
+		written = (written + ENETC_BD_PER_CL_MASK) &
+			  ~ENETC_BD_PER_CL_MASK;
+
+		while (written > 0) {
+			dcbf((void *)ENETC_TXBD(*tx_ring, n));
+			n = (n + ENETC_BD_PER_CL) % bd_count;
+			written -= ENETC_BD_PER_CL;
+		}
+	}
+
+	enetc_clean_tx_ring(tx_ring);
+	tx_ring->next_to_use = i;
+	enetc_wr_reg(tx_ring->tcir, i);
+
+	return start;
+}
+
 int
 enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 {
-- 
2.25.1

