Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273FFC5DF67
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 02:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A123406BA;
	Sun, 16 Aug 2026 04:52:57 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id A2E654064C
 for <dev@dpdk.org>; Sun, 16 Aug 2026 04:52:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAn+u32JYFqrYDQBQ--.14967S11;
 Sun, 16 Aug 2026 10:52:45 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 09/13] net/sxe2: optimize vectorized Tx/Rx path
Date: Sun, 16 Aug 2026 10:52:29 +0800
Message-ID: <20260816025233.2727226-10-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
References: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAn+u32JYFqrYDQBQ--.14967S11
X-Coremail-Antispam: 1UD129KBjvAXoWfXw15GrWDCFy5XF4DtFyfXrb_yoWrGw17to
 WIgw4rXF17JryxZrWDWwn7WFy7Jay3K34UGayF9Fs8u3W8Cw1Uta47Jw17AF1UGF1Y9F1D
 ua4xArZ7CrZ3Jr4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

This patch optimizes vectorized packet processing with improved buffer
management and unified buffer structure:

- Introduce unified Tx buffer structure:
  * Add union in sxe2_tx_queue for buffer_ring/buffer_ring_vec
  * Use sxe2_tx_buffer_vec for vectorized Tx path
  * Eliminate runtime type checking and branching

- Refactor Tx queue reset operations:
  * Extract desc ring reset to sxe2_tx_queue_desc_ring_reset
  * Add sxe2_tx_queue_reset_vec for vectorized queues
  * Simplify buffer initialization in vector mode

- Optimize Tx vector path mbuf release:
  * Remove conditional AVX512 branching
  * Use direct buffer_vec access without casting
  * Simplify loop logic with consistent pattern
  * Remove NULL checks after initialization validation

- Refactor Tx queue operations:
  * Export sxe2_tx_buffer_ring_free as public API
  * Add sxe2_tx_vec_ops_get() for vector operations
  * Use operation table instead of direct function calls

- Improve VSI management:
  * Initialize other_vsi_list before main VSI creation
  * Ignore -EPERM errors when destroying VSI in uninit
  * Set main_vsi to NULL after successful destroy
  * Prevent dangling pointer references

- Enhance Tx mode function selection:
  * Use rte_eth_tx_pkt_prepare_dummy for vectorized paths
  * Split NEON simple/offload mode selection logic
  * Clean up conditional compilation structure

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_queue.h           |   5 +-
 drivers/net/sxe2/sxe2_rx.c              |   5 +-
 drivers/net/sxe2/sxe2_switchdev.c       |   8 +-
 drivers/net/sxe2/sxe2_tx.c              |  42 +++--
 drivers/net/sxe2/sxe2_tx.h              |   4 +
 drivers/net/sxe2/sxe2_txrx.c            |  19 ++-
 drivers/net/sxe2/sxe2_txrx_poll.h       |   2 -
 drivers/net/sxe2/sxe2_txrx_vec.c        |  77 +++------
 drivers/net/sxe2/sxe2_txrx_vec.h        |   1 +
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c   |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c | 123 +-------------
 drivers/net/sxe2/sxe2_txrx_vec_common.h |   5 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c   | 215 ++++++++++++++++--------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c    |  10 +-
 drivers/net/sxe2/sxe2_vsi.c             |   8 +-
 15 files changed, 247 insertions(+), 287 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_queue.h b/drivers/net/sxe2/sxe2_queue.h
index 10bdaf5b8d..e53a1ce852 100644
--- a/drivers/net/sxe2/sxe2_queue.h
+++ b/drivers/net/sxe2/sxe2_queue.h
@@ -62,7 +62,10 @@ struct sxe2_txq_ops {
 };
 struct sxe2_tx_queue {
 	volatile union sxe2_tx_data_desc *desc_ring;
-	struct sxe2_tx_buffer *buffer_ring;
+	union {
+		struct sxe2_tx_buffer *buffer_ring;
+		struct sxe2_tx_buffer_vec *buffer_ring_vec;
+	};
 	volatile uint32_t *tdt_reg_addr;
 
 	uint64_t offloads;
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index d700c60083..6340ed933a 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -319,7 +319,8 @@ int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
 		rxq->mb_pool = mp;
 	}
 
-	rxq->rx_free_thresh = rx_conf->rx_free_thresh;
+	rxq->rx_free_thresh = (rx_conf->rx_free_thresh == 0) ?
+		SXE2_DEFAULT_RX_FREE_THRESH : rx_conf->rx_free_thresh;
 	rxq->port_id = dev->data->port_id;
 	rxq->offloads = offloads;
 	if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
@@ -550,7 +551,7 @@ void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev)
 static int32_t sxe2_monitor_callback(const uint64_t value,
 				 const uint64_t arg[RTE_POWER_MONITOR_OPAQUE_SZ] __rte_unused)
 {
-	const uint64_t dd_state = rte_cpu_to_le_64(SXE2_RX_DESC_STATUS_DD_MASK);
+	const uint64_t dd_state = rte_cpu_to_le_64(SXE2_RX_DESC_STATUS_DD_SHIFT);
 	return (value & dd_state) == dd_state ? -1 : 0;
 }
 
diff --git a/drivers/net/sxe2/sxe2_switchdev.c b/drivers/net/sxe2/sxe2_switchdev.c
index efb1468b91..374cc4e223 100644
--- a/drivers/net/sxe2/sxe2_switchdev.c
+++ b/drivers/net/sxe2/sxe2_switchdev.c
@@ -316,13 +316,7 @@ int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id;
 	repr_priv_data->repr_vf_backup_vsi_id =
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
-
-	repr_priv_data->repr_vf_vsi_id =
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id !=
-		SXE2_INVALID_VSI_ID ?
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id :
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
-
+	repr_priv_data->repr_vf_vsi_id = repr_priv_data->repr_vf_primary_vsi_id;
 	adapter->repr_priv_data = repr_priv_data;
 	goto l_end;
 l_free:
diff --git a/drivers/net/sxe2/sxe2_tx.c b/drivers/net/sxe2/sxe2_tx.c
index f49238ceef..94a6e9afc7 100644
--- a/drivers/net/sxe2/sxe2_tx.c
+++ b/drivers/net/sxe2/sxe2_tx.c
@@ -19,6 +19,17 @@ static void *sxe2_tx_doorbell_addr_get(struct sxe2_adapter *adapter, uint16_t qu
 				     queue_id);
 }
 
+static void sxe2_tx_queue_desc_ring_reset(struct sxe2_tx_queue *txq)
+{
+	uint16_t i;
+	static const union sxe2_tx_data_desc zeroed_desc = {{0}};
+
+	for (i = 0; i < txq->ring_depth; i++) {
+		txq->desc_ring[i] = zeroed_desc;
+		txq->desc_ring[i].wb.dd = rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE);
+	}
+}
+
 static void sxe2_tx_tail_init(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq)
 {
 	txq->tdt_reg_addr = sxe2_tx_doorbell_addr_get(adapter, txq->queue_id);
@@ -28,20 +39,12 @@ static void sxe2_tx_tail_init(struct sxe2_adapter *adapter, struct sxe2_tx_queue
 void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq)
 {
 	uint16_t prev, i;
-	volatile union sxe2_tx_data_desc *txd;
-	static const union sxe2_tx_data_desc zeroed_desc = {{0}};
 	struct sxe2_tx_buffer *tx_buffer = txq->buffer_ring;
 
-	for (i = 0; i < txq->ring_depth; i++)
-		txq->desc_ring[i] = zeroed_desc;
+	sxe2_tx_queue_desc_ring_reset(txq);
 
 	prev = txq->ring_depth - 1;
 	for (i = 0; i < txq->ring_depth; i++) {
-		txd = &txq->desc_ring[i];
-		if (txd == NULL)
-			continue;
-
-		txd->wb.dd = rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE);
 		tx_buffer[i].mbuf       = NULL;
 		tx_buffer[i].last_id    = i;
 		tx_buffer[prev].next_id = i;
@@ -56,6 +59,21 @@ void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq)
 	txq->next_rs       = txq->rs_thresh  - 1;
 }
 
+void __rte_cold sxe2_tx_queue_reset_vec(struct sxe2_tx_queue *txq)
+{
+	sxe2_tx_queue_desc_ring_reset(txq);
+
+	memset(txq->buffer_ring, 0,
+		sizeof(struct sxe2_tx_buffer) * txq->ring_depth);
+
+	txq->desc_used_num = 0;
+	txq->desc_free_num = txq->ring_depth - 1;
+	txq->next_use      = 0;
+	txq->next_clean    = txq->ring_depth - 1;
+	txq->next_dd       = txq->rs_thresh  - 1;
+	txq->next_rs       = txq->rs_thresh  - 1;
+}
+
 void __rte_cold sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq)
 {
 	uint32_t i;
@@ -70,10 +88,12 @@ void __rte_cold sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq)
 	}
 }
 
-static void sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq)
+void __rte_cold sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq)
 {
-	if (txq != NULL && txq->buffer_ring != NULL)
+	if (txq != NULL && txq->buffer_ring != NULL) {
 		rte_free(txq->buffer_ring);
+		txq->buffer_ring = NULL;
+	}
 }
 
 const struct sxe2_txq_ops sxe2_default_txq_ops = {
diff --git a/drivers/net/sxe2/sxe2_tx.h b/drivers/net/sxe2/sxe2_tx.h
index f4823126b3..bc5ff1c2bc 100644
--- a/drivers/net/sxe2/sxe2_tx.h
+++ b/drivers/net/sxe2/sxe2_tx.h
@@ -9,6 +9,10 @@
 
 void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq);
 
+void __rte_cold sxe2_tx_queue_reset_vec(struct sxe2_tx_queue *txq);
+
+void __rte_cold sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq);
+
 int32_t __rte_cold sxe2_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
 
 void sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq);
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index 79870866d1..d27d2ce630 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -358,7 +358,7 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 	}
 
 	if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 #ifdef RTE_ARCH_X86
 		if (tx_mode_flags & SXE2_TX_MODE_VEC_AVX512) {
 #ifdef CC_AVX512_SUPPORT
@@ -386,21 +386,25 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 		}
 #elif defined(RTE_ARCH_ARM64)
 		if (tx_mode_flags & SXE2_TX_MODE_VEC_NEON) {
-			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
-			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
-		} else {
-			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+			if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
+				dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
+			} else {
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+			}
 		}
 #endif
 	} else {
 		if (tx_mode_flags & SXE2_TX_MODE_SIMPLE_BATCH) {
-			dev->tx_pkt_prepare = NULL;
+			dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 			dev->tx_pkt_burst = sxe2_tx_pkts_simple;
 		} else {
 			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
 			dev->tx_pkt_burst = sxe2_tx_pkts;
 		}
 	}
+	PMD_LOG_DEBUG(TX, "Tx mode flags:0x%016x port_id:%u.",
+				tx_mode_flags, dev->data->port_id);
 }
 
 static const struct {
@@ -582,6 +586,9 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_split;
 	else
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered;
+
+	PMD_LOG_DEBUG(RX, "Rx mode flags:0x%016x port_id:%u.",
+				rx_mode_flags, dev->data->port_id);
 }
 
 static const struct {
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.h b/drivers/net/sxe2/sxe2_txrx_poll.h
index 708e3839d7..bfa099c097 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.h
+++ b/drivers/net/sxe2/sxe2_txrx_poll.h
@@ -13,8 +13,6 @@ uint16_t sxe2_tx_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t
 
 uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
-uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
-
 uint16_t sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
 #endif /* SXE2_TXRX_POLL_H */
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.c b/drivers/net/sxe2/sxe2_txrx_vec.c
index cf004f5eb2..31ab66708c 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -8,6 +8,19 @@
 #include "sxe2_ethdev.h"
 #include "sxe2_common_log.h"
 
+static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq);
+
+struct sxe2_txq_ops sxe2_tx_vec_ops_get(void)
+{
+	static const struct sxe2_txq_ops ops = {
+		.queue_reset      = sxe2_tx_queue_reset_vec,
+		.mbufs_release    = sxe2_tx_queue_mbufs_release_vec,
+		.buffer_ring_free = sxe2_tx_buffer_ring_free,
+	};
+
+	return ops;
+}
+
 int32_t __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags)
 {
 	struct sxe2_rx_queue *rxq;
@@ -157,67 +170,28 @@ int32_t __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, uint32_t *
 
 static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq)
 {
-	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer_vec *buffer_vec;
 	uint16_t i;
 
 	if (unlikely(txq == NULL || txq->buffer_ring == NULL)) {
 		PMD_LOG_ERR(TX, "Tx release mbufs vec, invalid params.");
 		return;
 	}
-	i = txq->next_dd - (txq->rs_thresh - 1);
-#ifdef CC_AVX512_SUPPORT
-	struct rte_eth_dev *dev;
-	struct sxe2_tx_buffer_vec *buffer_vec;
 
-	dev = &rte_eth_devices[txq->port_id];
-
-	if (dev->tx_pkt_burst == sxe2_tx_pkts_vec_avx512 ||
-		dev->tx_pkt_burst == sxe2_tx_pkts_vec_avx512_simple) {
-		buffer_vec = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
+	i = txq->next_dd - (txq->rs_thresh - 1);
+	buffer_vec = txq->buffer_ring_vec;
 
-		if (txq->next_use < i) {
-			for ( ; i < txq->ring_depth; ++i) {
-				if (buffer_vec[i].mbuf != NULL) {
-					rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
-					buffer_vec[i].mbuf = NULL;
-				}
-			}
-			i = 0;
-		}
-		for ( ; i < txq->next_use; ++i) {
-			if (buffer_vec[i].mbuf != NULL) {
-				rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
-				buffer_vec[i].mbuf = NULL;
-			}
+	if (txq->next_use < i) {
+		for ( ; i < txq->ring_depth; ++i) {
+			rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+			buffer_vec[i].mbuf = NULL;
 		}
-	} else {
-#endif
-		buffer = txq->buffer_ring;
-		buffer = txq->buffer_ring;
-		if (txq->next_use < i) {
-			for ( ; i < txq->ring_depth; ++i) {
-				if (buffer[i].mbuf != NULL) {
-					rte_pktmbuf_free_seg(buffer[i].mbuf);
-					buffer[i].mbuf = NULL;
-				}
-			}
-			i = 0;
-		}
-		for (; i < txq->next_use; ++i) {
-			if (buffer[i].mbuf != NULL) {
-				rte_pktmbuf_free_seg(buffer[i].mbuf);
-				buffer[i].mbuf = NULL;
-			}
-		}
-#ifdef CC_AVX512_SUPPORT
+		i = 0;
 	}
-#endif
 
-	for (; i < txq->next_use; ++i) {
-		if (buffer[i].mbuf != NULL) {
-			rte_pktmbuf_free_seg(buffer[i].mbuf);
-			buffer[i].mbuf = NULL;
-		}
+	for ( ; i < txq->next_use; ++i) {
+		rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+		buffer_vec[i].mbuf = NULL;
 	}
 }
 
@@ -233,7 +207,8 @@ int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev)
 			PMD_LOG_INFO(TX, "Failed to prepare tx queue, txq[%d] is NULL", i);
 			continue;
 		}
-		txq->ops.mbufs_release = sxe2_tx_queue_mbufs_release_vec;
+		txq->ops = sxe2_tx_vec_ops_get();
+		txq->ops.queue_reset(txq);
 	}
 	return ret;
 }
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.h b/drivers/net/sxe2/sxe2_txrx_vec.h
index c139aed776..b9bc4f9c27 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec.h
@@ -89,6 +89,7 @@ uint16_t sxe2_rx_pkts_scattered_vec_neon_offload(void *rx_queue, struct rte_mbuf
 uint16_t sxe2_tx_pkts_vec_neon_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t sxe2_tx_pkts_vec_neon(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 #endif
+struct sxe2_txq_ops sxe2_tx_vec_ops_get(void);
 int32_t __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags);
 int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev);
 int32_t __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx2.c b/drivers/net/sxe2/sxe2_txrx_vec_avx2.c
index 0618e6d988..da96ca3064 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_avx2.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx2.c
@@ -115,7 +115,7 @@ sxe2_tx_pkts_vec_avx2_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 			    uint16_t nb_pkts, bool with_offloads)
 {
 	volatile union sxe2_tx_data_desc *desc;
-	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer_vec *buffer;
 	uint16_t next_use;
 	uint16_t res_num;
 	uint16_t tx_num;
@@ -134,14 +134,14 @@ sxe2_tx_pkts_vec_avx2_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 
 	next_use = txq->next_use;
 	desc     = &txq->desc_ring[next_use];
-	buffer   = &txq->buffer_ring[next_use];
+	buffer   = &txq->buffer_ring_vec[next_use];
 
 	txq->desc_free_num -= nb_pkts;
 
 	res_num = txq->ring_depth - txq->next_use;
 
 	if (tx_num >= res_num) {
-		sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, res_num);
+		sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, res_num);
 
 		sxe2_tx_desc_fill_avx2(desc, tx_pkts, res_num,
 				SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
@@ -157,10 +157,10 @@ sxe2_tx_pkts_vec_avx2_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 		next_use     = 0;
 		txq->next_rs = txq->rs_thresh - 1;
 		desc         = &txq->desc_ring[next_use];
-		buffer       = &txq->buffer_ring[next_use];
+		buffer       = &txq->buffer_ring_vec[next_use];
 	}
 
-	sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, tx_num);
+	sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, tx_num);
 
 	sxe2_tx_desc_fill_avx2(desc, tx_pkts, tx_num,
 			SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
index a830c7a33b..deea4c2720 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
  */
-
-#ifndef SXE2_TEST
 #include <rte_vect.h>
 
 #include "sxe2_ethdev.h"
@@ -12,114 +10,6 @@
 #include "sxe2_txrx_vec_common.h"
 #include "sxe2_vsi.h"
 
-static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_queue *txq)
-{
-	struct sxe2_tx_buffer_vec *buffer;
-	struct rte_mbuf *mbuf;
-	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
-	struct rte_mempool *mp;
-	struct rte_mempool_cache *cache;
-	void **cache_objs;
-	uint32_t copied;
-	uint32_t i;
-	int32_t ret;
-	uint16_t rs_thresh;
-	uint16_t free_num;
-
-	if (rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE) !=
-		(txq->desc_ring[txq->next_dd].wb.dd &
-			rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_MASK))) {
-		ret = 0;
-		goto l_end;
-	}
-
-	rs_thresh = txq->rs_thresh;
-
-	buffer = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
-	buffer += txq->next_dd - (rs_thresh - 1);
-
-	if ((txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
-			(rs_thresh & 31) == 0) {
-		mp = buffer[0].mbuf->pool;
-		cache = rte_mempool_default_cache(mp, rte_lcore_id());
-
-		if (cache == NULL || cache->len)
-			goto normal;
-
-		if (rs_thresh > RTE_MEMPOOL_CACHE_MAX_SIZE) {
-			(void)rte_mempool_ops_enqueue_bulk(mp, (void *)buffer, rs_thresh);
-			goto done;
-		}
-		cache_objs = &cache->objs[cache->len];
-
-		copied = 0;
-		while (copied < rs_thresh) {
-			const __m512i objs0 = _mm512_loadu_si512(&buffer[copied]);
-			const __m512i objs1 = _mm512_loadu_si512(&buffer[copied + 8]);
-			const __m512i objs2 = _mm512_loadu_si512(&buffer[copied + 16]);
-			const __m512i objs3 = _mm512_loadu_si512(&buffer[copied + 24]);
-
-			_mm512_storeu_si512(&cache_objs[copied], objs0);
-			_mm512_storeu_si512(&cache_objs[copied + 8], objs1);
-			_mm512_storeu_si512(&cache_objs[copied + 16], objs2);
-			_mm512_storeu_si512(&cache_objs[copied + 24], objs3);
-			copied += 32;
-		}
-		cache->len += rs_thresh;
-
-		if (cache->len >= cache->flushthresh) {
-			(void)rte_mempool_ops_enqueue_bulk(mp,
-					&cache->objs[cache->size], cache->len - cache->size);
-			cache->len = cache->size;
-		}
-		goto done;
-	}
-
-normal:
-	mbuf = rte_pktmbuf_prefree_seg(buffer[0].mbuf);
-
-	if (likely(mbuf)) {
-		mbuf_free_arr[0] = mbuf;
-		free_num = 1;
-
-		for (i = 1; i < rs_thresh; ++i) {
-			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
-
-			if (likely(mbuf)) {
-				if (likely(mbuf->pool == mbuf_free_arr[0]->pool)) {
-					mbuf_free_arr[free_num] = mbuf;
-					free_num++;
-				} else {
-					rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
-						(void *)mbuf_free_arr, free_num);
-
-				mbuf_free_arr[0] = mbuf;
-				free_num = 1;
-			}
-			}
-		}
-
-		rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
-						(void *)mbuf_free_arr, free_num);
-	} else {
-		for (i = 1; i < rs_thresh; ++i) {
-			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
-			if (mbuf != NULL)
-				rte_mempool_put(mbuf->pool, mbuf);
-		}
-	}
-
-done:
-	txq->desc_free_num += txq->rs_thresh;
-	txq->next_dd       += txq->rs_thresh;
-	if (txq->next_dd >= txq->ring_depth)
-		txq->next_dd = txq->rs_thresh - 1;
-	ret = rs_thresh;
-
-l_end:
-	return ret;
-}
-
 static __rte_always_inline void
 sxe2_tx_desc_fill_one_avx512(volatile union sxe2_tx_data_desc *desc, struct rte_mbuf *pkt,
 	uint64_t desc_cmd, bool with_offloads)
@@ -228,7 +118,7 @@ sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pk
 	uint16_t tx_num;
 
 	if (txq->desc_free_num < txq->free_thresh)
-		(void)sxe2_tx_bufs_free_vec_avx512(txq);
+		(void)sxe2_tx_bufs_free_vec(txq);
 
 	nb_pkts = RTE_MIN(txq->desc_free_num, nb_pkts);
 	if (unlikely(nb_pkts == 0)) {
@@ -241,15 +131,14 @@ sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pk
 
 	next_use = txq->next_use;
 	desc     = &txq->desc_ring[next_use];
-	buffer   = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
-	buffer  += next_use;
+	buffer   = &txq->buffer_ring_vec[next_use];
 
 	txq->desc_free_num -= nb_pkts;
 
 	res_num = txq->ring_depth - txq->next_use;
 
 	if (tx_num >= res_num) {
-		sxe2_tx_pkts_mbuf_fill_avx512(buffer, tx_pkts, res_num);
+		sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, res_num);
 
 		sxe2_tx_desc_fill_avx512(desc, tx_pkts, res_num,
 					SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
@@ -265,10 +154,10 @@ sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pk
 		next_use     = 0;
 		txq->next_rs = txq->rs_thresh - 1;
 		desc         = txq->desc_ring;
-		buffer       = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
+		buffer       = &txq->buffer_ring_vec[next_use];
 	}
 
-	sxe2_tx_pkts_mbuf_fill_avx512(buffer, tx_pkts, tx_num);
+	sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, tx_num);
 
 	sxe2_tx_desc_fill_avx512(desc, tx_pkts, tx_num,
 			SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
@@ -863,5 +752,3 @@ uint16_t sxe2_rx_pkts_scattered_vec_avx512_offload(void *rx_queue,
 	return sxe2_rx_pkts_scattered_common_vec_avx512(rx_queue,
 			rx_pkts, nb_pkts, true);
 }
-
-#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_common.h b/drivers/net/sxe2/sxe2_txrx_vec_common.h
index 9ac99cf0fa..d16d0a5a5a 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_common.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec_common.h
@@ -25,10 +25,11 @@
 #define SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC  64
 
 static __rte_always_inline void
-sxe2_tx_pkts_mbuf_fill(struct sxe2_tx_buffer *buffer,
-		struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+sxe2_tx_pkts_mbuf_fill_vec(struct sxe2_tx_buffer_vec *buffer,
+			   struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	uint16_t i;
+
 	for (i = 0; i < nb_pkts; ++i)
 		buffer[i].mbuf = tx_pkts[i];
 }
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_neon.c b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
index 4e5cb87cd5..c39e4ad81c 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_neon.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
@@ -34,6 +34,51 @@ sxe2_tx_desc_fill_one_neon(volatile union sxe2_tx_data_desc *desc,
 	vst1q_u64(RTE_CAST_PTR(uint64_t *, desc), data_desc);
 }
 
+static __rte_always_inline void
+sxe2_tx_desc_fill_4_neon_simple(volatile union sxe2_tx_data_desc *desc,
+				struct rte_mbuf **pkts)
+{
+	uint64x2_t d0, d1, d2, d3;
+	uint64x2x4_t v;
+	const u64 cmd_base = ((u64)SXE2_TX_DESC_DTYPE_DATA) |
+				((u64)SXE2_TX_DATA_DESC_CMD_EOP) << SXE2_TX_DATA_DESC_CMD_SHIFT;
+
+	d0 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[0]),
+		cmd_base |
+		((u64)pkts[0]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((u64)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[0]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+	d1 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[1]),
+		cmd_base |
+		((u64)pkts[1]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((u64)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[1]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+	d2 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[2]),
+		cmd_base |
+		((u64)pkts[2]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((u64)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[2]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+	d3 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[3]),
+		cmd_base |
+		((u64)pkts[3]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((u64)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[3]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+
+	v.val[0] = d0;
+	v.val[1] = d1;
+	v.val[2] = d2;
+	v.val[3] = d3;
+	vst1q_u64_x4((u64 *)desc, v);
+}
+
 static __rte_always_inline uint16_t
 sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
 			uint16_t nb_pkts, bool with_offloads)
@@ -66,11 +111,19 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 	res_num = txq->ring_depth - txq->next_use;
 
 	if (tx_num >= res_num) {
-		sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, res_num);
-
-		for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
-			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
-					SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+		sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, res_num);
+		if (with_offloads) {
+			for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
+				sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+						SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+			}
+		} else {
+			for (i = 0; i + 3 < res_num - 1; i += 4, tx_pkts += 4, desc += 4)
+				sxe2_tx_desc_fill_4_neon_simple(desc, tx_pkts);
+			for (; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
+				sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+						SXE2_TX_DATA_DESC_CMD_EOP, false);
+			}
 		}
 
 		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts++,
@@ -82,14 +135,23 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 		next_use     = 0;
 		txq->next_rs = txq->rs_thresh - 1;
 		desc         = &txq->desc_ring[next_use];
-		buffer       = &txq->buffer_ring[next_use];
+		buffer       = &txq->buffer_ring_vec[next_use];
 	}
 
-	sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, tx_num);
+	sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, tx_num);
 
-	for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
-		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
-				SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+	if (with_offloads) {
+		for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
+			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+					SXE2_TX_DATA_DESC_CMD_EOP, true);
+		}
+	} else {
+		for (i = 0; i + 3 < tx_num; i += 4, tx_pkts += 4, desc += 4)
+			sxe2_tx_desc_fill_4_neon_simple(desc, tx_pkts);
+		for (; i < tx_num; ++i, ++tx_pkts, ++desc) {
+			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+					SXE2_TX_DATA_DESC_CMD_EOP, false);
+		}
 	}
 
 	next_use += tx_num;
@@ -150,22 +212,24 @@ uint16_t sxe2_tx_pkts_vec_neon(void *tx_queue,
 }
 
 static __rte_always_inline void
-sxe2_rx_desc_ptype_fill_neon(uint16x8_t staterr, struct rte_mbuf **__rte_restrict rx_pkts)
+sxe2_rx_desc_ptype_fill_neon(uint32x4_t desc_lo,
+							 struct rte_mbuf **__rte_restrict rx_pkts,
+							 const u32 *__rte_restrict ptype_tbl)
 {
-	uint16x8_t ptype_mask = {
-		0, 0x3FFULL,
-		0, 0x3FFULL,
-		0, 0x3FFULL,
-		0, 0x3FFULL,
+	const uint32x4_t ptype_mask = {
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
 	};
 	uint16x8_t ptype_all;
 
-	ptype_all = vandq_u16(staterr, ptype_mask);
+	ptype_all = vreinterpretq_u16_u32(vandq_u32(desc_lo, ptype_mask));
 
-	rx_pkts[3]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 3)];
-	rx_pkts[2]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 7)];
-	rx_pkts[1]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 1)];
-	rx_pkts[0]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 5)];
+	rx_pkts[0]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 1)];
+	rx_pkts[1]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 3)];
+	rx_pkts[2]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 5)];
+	rx_pkts[3]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 7)];
 }
 
 static __rte_always_inline uint32x4_t
@@ -208,9 +272,10 @@ sxe2_rx_desc_fnav_flags_neon(uint64x2_t descs_arr[4])
 static __rte_always_inline void
 sxe2_rx_desc_offloads_para_fill_neon(struct sxe2_rx_queue *rxq,
 			volatile union sxe2_rx_desc *desc,
-			uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
+			uint64x2_t descs[4], uint32x4_t desc_lo, uint32x4_t desc_hi,
+			struct rte_mbuf **rx_pkts)
 {
-	uint32x4_t desc_lo, desc_hi, flags, tmp_flags;
+	uint32x4_t flags, tmp_flags;
 	const uint64x2_t mbuf_init = {rxq->mbuf_init_value, 0};
 	uint64x2_t rearm0, rearm1, rearm2, rearm3;
 
@@ -267,23 +332,6 @@ sxe2_rx_desc_offloads_para_fill_neon(struct sxe2_rx_queue *rxq,
 		0, 0, 0, 0, 0, 0, 0, 0
 	};
 
-	{
-		uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
-		uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
-		uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
-		uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
-		uint64x2_t f64, t64;
-
-		flags = vzip2q_u32(d1, d0);
-		tmp_flags = vzip2q_u32(d3, d2);
-		f64 = vreinterpretq_u64_u32(flags);
-		t64 = vreinterpretq_u64_u32(tmp_flags);
-		desc_lo = vreinterpretq_u32_u64(vcombine_u64(vget_low_u64(f64),
-							     vget_low_u64(t64)));
-		desc_hi = vreinterpretq_u32_u64(vcombine_u64(vget_high_u64(f64),
-							     vget_high_u64(t64)));
-	}
-
 	desc_lo = vandq_u32(desc_lo, desc_msk);
 	desc_hi = vandq_u32(desc_hi, rss_msk);
 
@@ -407,6 +455,7 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 	struct rte_mbuf **buffer;
 	uint32_t i;
 	uint16_t done_num = 0;
+	const u32 *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
 
 	uint8x16_t rvp_shuf_mask = {
 		0xFF, 0xFF, 0xFF, 0xFF,
@@ -442,25 +491,39 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 		uint64x2_t descs[SXE2_RX_NUM_PER_LOOP_NEON];
 		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		uint64x2_t mbp1, mbp2;
+		uint32x4_t desc_lo, desc_hi;
 		uint16x8_t staterr;
 		uint16x8_t tmp;
 		uint16_t bit_num;
 
 		descs[3] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc + 3));
-		rte_atomic_thread_fence(rte_memory_order_acquire);
 		descs[2] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc + 2));
-		rte_atomic_thread_fence(rte_memory_order_acquire);
 		descs[1] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc + 1));
-		rte_atomic_thread_fence(rte_memory_order_acquire);
 		descs[0] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc));
 
 		rte_atomic_thread_fence(rte_memory_order_acquire);
-
 		descs[3] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc + 3), descs[3], 0);
 		descs[2] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc + 2), descs[2], 0);
 		descs[1] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc + 1), descs[1], 0);
 		descs[0] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc), descs[0], 0);
 
+		{
+			uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
+			uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
+			uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
+			uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
+
+			uint32x4_t q1_01 = vzip2q_u32(d0, d1);
+			uint32x4_t q1_23 = vzip2q_u32(d2, d3);
+			uint64x2_t q1_01_64 = vreinterpretq_u64_u32(q1_01);
+			uint64x2_t q1_23_64 = vreinterpretq_u64_u32(q1_23);
+
+			desc_lo = vreinterpretq_u32_u64(vcombine_u64(vget_low_u64(q1_01_64),
+							vget_low_u64(q1_23_64)));
+			desc_hi = vreinterpretq_u32_u64(vcombine_u64(vget_high_u64(q1_01_64),
+							vget_high_u64(q1_23_64)));
+		}
+
 		mbp1 = vld1q_u64((uint64_t *)&buffer[i]);
 		mbp2 = vld1q_u64((uint64_t *)&buffer[i + 2]);
 
@@ -480,7 +543,8 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 		pkt_mb1 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[0]), rvp_shuf_mask);
 
 		if (do_offload) {
-			sxe2_rx_desc_offloads_para_fill_neon(rxq, desc, descs, &rx_pkts[i]);
+			sxe2_rx_desc_offloads_para_fill_neon(rxq, desc, descs, desc_lo,
+							     desc_hi, &rx_pkts[i]);
 		} else {
 			const uint64x2_t mbuf_init = {
 				rxq->mbuf_init_value,
@@ -515,55 +579,48 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 			rte_prefetch_non_temporal(desc + SXE2_RX_NUM_PER_LOOP_NEON);
 
 		{
-			uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
-			uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
-			uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
-			uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
-			uint32x4_t sterr_tmp1 = vzip2q_u32(d1, d0);
-			uint32x4_t sterr_tmp2 = vzip2q_u32(d3, d2);
-			uint32x4_t sterr_u32 = vzip1q_u32(sterr_tmp1, sterr_tmp2);
-
-			staterr = vreinterpretq_u16_u32(sterr_u32);
+			uint16x8_t sterr_tmp1 = vzip2q_u16(vreinterpretq_u16_u64(descs[0]),
+							   vreinterpretq_u16_u64(descs[2]));
+			uint16x8_t sterr_tmp2 = vzip2q_u16(vreinterpretq_u16_u64(descs[1]),
+							   vreinterpretq_u16_u64(descs[3]));
+			staterr = vzip1q_u16(sterr_tmp1, sterr_tmp2);
 		}
 
-		sxe2_rx_desc_ptype_fill_neon(staterr, &rx_pkts[i]);
+		sxe2_rx_desc_ptype_fill_neon(desc_lo, &rx_pkts[i], ptype_tbl);
 
 		if (umbcast_flags != NULL) {
-			uint32x4_t umbcast_mask = {
-				SXE2_RX_DESC_STATUS_UMBCAST_MASK, SXE2_RX_DESC_STATUS_UMBCAST_MASK,
-				SXE2_RX_DESC_STATUS_UMBCAST_MASK, SXE2_RX_DESC_STATUS_UMBCAST_MASK,
-			};
-
+			const uint32x4_t umbcast_mask =
+				vdupq_n_u32(SXE2_RX_DESC_STATUS_UMBCAST_MASK);
 			uint8x16_t umbcast_shuf_mask = {
-				0x0B, 0x03, 0x0F, 0x07,
+				3, 7, 11, 15,
 				0xFF, 0xFF, 0xFF, 0xFF,
 				0xFF, 0xFF, 0xFF, 0xFF,
 				0xFF, 0xFF, 0xFF, 0xFF,
 			};
 			uint8x16_t umbcast_bits =
-				vreinterpretq_u8_u32(vandq_u32(vreinterpretq_u32_u16(staterr),
-							       umbcast_mask));
+				vreinterpretq_u8_u32(vandq_u32(desc_lo, umbcast_mask));
 
 			umbcast_bits = vqtbl1q_u8(umbcast_bits, umbcast_shuf_mask);
-			vst1q_lane_u32((uint32_t *)umbcast_flags,
-					vreinterpretq_u32_u8(umbcast_bits), 0);
+			*(u32 *)umbcast_flags =
+				vgetq_lane_u32(vreinterpretq_u32_u8(umbcast_bits), 0);
 			umbcast_flags += SXE2_RX_NUM_PER_LOOP_NEON;
 		}
 
 		if (split_rxe_flags) {
 			uint8x16_t eop_shuf_mask = {
-					0x08, 0x00, 0x0C, 0x04,
+					0, 2, 4, 6,
 					0xFF, 0xFF, 0xFF, 0xFF,
 					0xFF, 0xFF, 0xFF, 0xFF,
 					0xFF, 0xFF, 0xFF, 0xFF};
 			uint8x16_t eop_bits;
 			uint32x4_t rxe_mask = {
-				0x2080, 0x2080, 0x2080, 0x2080
+				0x20802080, 0x20802080, 0x20802080, 0x20802080
 			};
 			uint32x4_t rxe_bits;
 			uint32x4_t eop_mask;
 
-			eop_mask = vshlq_n_u32(vdupq_n_u32(1), SXE2_RX_DESC_STATUS_EOP_SHIFT);
+			eop_mask = vdupq_n_u32((1U << SXE2_RX_DESC_STATUS_EOP_SHIFT) |
+					(1U << (SXE2_RX_DESC_STATUS_EOP_SHIFT + 16)));
 			eop_bits = vandq_u8(vmvnq_u8(vreinterpretq_u8_u16(staterr)),
 					vreinterpretq_u8_u32(eop_mask));
 
@@ -587,12 +644,22 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 		}
 
 		{
-			uint32x4_t dd_mask = vdupq_n_u32(1);
-			uint32x4_t sterr_dd = vandq_u32(vreinterpretq_u32_u16(staterr), dd_mask);
-			uint16x4_t packed_lo = vmovn_u32(sterr_dd);
-			uint64_t dd64 = vget_lane_u64(vreinterpret_u64_u16(packed_lo), 0);
-
-			bit_num = (uint16_t)rte_popcount64(dd64);
+			const uint16x8_t dd_check = {
+				0x0001, 0x0001, 0x0001, 0x0001,
+				0, 0, 0, 0
+			};
+			uint16x8_t sterr_dd;
+			uint64_t stat;
+			sterr_dd = vandq_u16(staterr, dd_check);
+			sterr_dd = vshlq_n_u16(sterr_dd, 15);
+			sterr_dd =
+				vreinterpretq_u16_s16(vshrq_n_s16(vreinterpretq_s16_u16(sterr_dd),
+								  15));
+			stat = ~vgetq_lane_u64(vreinterpretq_u64_u16(sterr_dd), 0);
+			if (likely(stat == 0))
+				bit_num = SXE2_RX_NUM_PER_LOOP_NEON;
+			else
+				bit_num = (u16)(rte_ctz64(stat) / 16);
 		}
 		done_num += bit_num;
 		if (likely(bit_num != SXE2_RX_NUM_PER_LOOP_NEON))
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_sse.c b/drivers/net/sxe2/sxe2_txrx_vec_sse.c
index c3e8a2983b..181bb40041 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_sse.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_sse.c
@@ -40,7 +40,7 @@ sxe2_tx_pkts_vec_sse_batch(struct sxe2_tx_queue *txq,
 		uint16_t nb_pkts, bool with_offloads)
 {
 	volatile union sxe2_tx_data_desc *desc;
-	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer_vec *buffer;
 	uint16_t next_use;
 	uint16_t res_num;
 	uint16_t tx_num;
@@ -57,11 +57,11 @@ sxe2_tx_pkts_vec_sse_batch(struct sxe2_tx_queue *txq,
 	tx_num = nb_pkts;
 	next_use = txq->next_use;
 	desc     = &txq->desc_ring[next_use];
-	buffer   = &txq->buffer_ring[next_use];
+	buffer   = &txq->buffer_ring_vec[next_use];
 	txq->desc_free_num -= nb_pkts;
 	res_num = txq->ring_depth - txq->next_use;
 	if (tx_num >= res_num) {
-		sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, res_num);
+		sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, res_num);
 		for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
 			sxe2_tx_desc_fill_one_sse(desc, *tx_pkts,
 						  SXE2_TX_DATA_DESC_CMD_EOP,
@@ -74,9 +74,9 @@ sxe2_tx_pkts_vec_sse_batch(struct sxe2_tx_queue *txq,
 		next_use     = 0;
 		txq->next_rs = txq->rs_thresh - 1;
 		desc         = &txq->desc_ring[next_use];
-		buffer       = &txq->buffer_ring[next_use];
+		buffer       = &txq->buffer_ring_vec[next_use];
 	}
-	sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, tx_num);
+	sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, tx_num);
 	for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
 		sxe2_tx_desc_fill_one_sse(desc, *tx_pkts,
 					  SXE2_TX_DATA_DESC_CMD_EOP,
diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
index d29480b931..ba4cc7414e 100644
--- a/drivers/net/sxe2/sxe2_vsi.c
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -230,7 +230,7 @@ int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 	uint16_t srcvsi_cnt;
 
 	PMD_INIT_FUNC_TRACE();
-
+	TAILQ_INIT(&adapter->vsi_ctxt.other_vsi_list);
 	ret = sxe2_main_vsi_create(adapter);
 	if (ret) {
 		PMD_LOG_ERR(DRV, "Failed to create main VSI, ret=%d", ret);
@@ -283,13 +283,14 @@ void sxe2_vsi_uninit(struct rte_eth_dev *dev)
 
 l_free:
 	ret = sxe2_vsi_destroy(adapter, adapter->vsi_ctxt.main_vsi);
-	if (ret) {
+	if (ret && ret != -EPERM) {
 		PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
 		goto l_end;
 	}
+	adapter->vsi_ctxt.main_vsi = NULL;
 	RTE_TAILQ_FOREACH_SAFE(var, &adapter->vsi_ctxt.other_vsi_list, next, tvar) {
 		ret = sxe2_vsi_destroy(adapter, var);
-		if (ret) {
+		if (ret && ret != -EPERM) {
 			PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
 			break;
 		}
@@ -357,4 +358,5 @@ void sxe2_vsi_repr_main_vsi_destroy(struct rte_eth_dev *dev)
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 
 	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+	adapter->vsi_ctxt.main_vsi = NULL;
 }
-- 
2.52.0

