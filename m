Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA6CD3424
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 06:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B0EC40A4B;
	Wed,  6 May 2026 08:13:35 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1AF784069D
 for <dev@dpdk.org>; Wed,  6 May 2026 08:13:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7sX_2_ppDUE1EA--.16873S12;
 Wed, 06 May 2026 14:13:22 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v8 10/10] net/sxe2: add vectorized Rx and Tx
Date: Wed,  6 May 2026 14:12:59 +0800
Message-ID: <20260506061301.817613-11-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506061301.817613-1-liujie5@linkdatatechnology.com>
References: <20260506033123.726997-10-liujie5@linkdatatechnology.com>
 <20260506061301.817613-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7sX_2_ppDUE1EA--.16873S12
X-Coremail-Antispam: 1UD129KBjvAXoWDJFWxZr1fAr4DZw1ftFWkZwb_yoWxJw43Ko
 Wxur4fXF1xXr18Aws5Ww1xuFy0qa15K34UA3yF9Fs8Xa15Aw1jyasFk3W7Zr1UX3WrtF4q
 ga4xXFZay393JrZ7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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

This patch implements the vectorized data path for the sxe2 PMD.
It utilizes SIMD instructions (e.g., SSE) to process multiple
packets simultaneously, significantly improving throughput for
small packet processing.

The implementation includes:
* Vectorized Rx burst function for bulk descriptor processing.
* Vectorized Tx burst function with optimized resource cleanup.
* Capability flags update to reflect vectorized path support.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build            |   9 +
 drivers/net/sxe2/sxe2_ethdev.c          |   8 +-
 drivers/net/sxe2/sxe2_txrx.c            | 224 +++++++---
 drivers/net/sxe2/sxe2_txrx.h            |  12 +-
 drivers/net/sxe2/sxe2_txrx_poll.c       | 184 ++++++++
 drivers/net/sxe2/sxe2_txrx_poll.h       |   3 +-
 drivers/net/sxe2/sxe2_txrx_vec.c        | 188 ++++++++
 drivers/net/sxe2/sxe2_txrx_vec.h        |  72 ++++
 drivers/net/sxe2/sxe2_txrx_vec_common.h | 235 ++++++++++
 drivers/net/sxe2/sxe2_txrx_vec_sse.c    | 547 ++++++++++++++++++++++++
 10 files changed, 1417 insertions(+), 65 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_common.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_sse.c

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 728a88b6a1..b9618f2964 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -12,6 +12,14 @@ cflags += ['-g']
 
 deps += ['common_sxe2', 'hash','cryptodev','security']
 
+if arch_subdir == 'x86'
+        sources += files('sxe2_txrx_vec_sse.c')
+
+        if is_windows and cc.get_id() != 'clang'
+                cflags += ['-fno-asynchronous-unwind-tables']
+        endif
+endif
+
 sources += files(
         'sxe2_ethdev.c',
         'sxe2_cmd_chnl.c',
@@ -21,6 +29,7 @@ sources += files(
         'sxe2_rx.c',
         'sxe2_txrx_poll.c',
         'sxe2_txrx.c',
+        'sxe2_txrx_vec.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 68d7e36cf1..7eaa1722d0 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -58,17 +58,11 @@ static const struct rte_pci_id pci_id_sxe2_tbl[] = {
 };
 
 static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
-	/* SXE2_PCI_MAP_RES_INVALID */
 	{0, 0, 0},
-	/* SXE2_PCI_MAP_RES_DOORBELL_TX */
 	{ SXE2_TXQ_LEGACY_DBLL(0), 0, 4},
-	/* SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL */
 	{ SXE2_RXQ_TAIL(0), 0, 4},
-	/* SXE2_PCI_MAP_RES_IRQ_DYN */
 	{ SXE2_VF_DYN_CTL(0), 0, 4},
-	/* SXE2_PCI_MAP_RES_IRQ_ITR(默认使用ITR0) */
 	{ SXE2_VF_INT_ITR(0, 0), 0, 4},
-	/* SXE2_PCI_MAP_RES_IRQ_MSIX */
 	{ SXE2_BAR4_MSIX_CTL(0), 4, 0x10},
 };
 
@@ -312,6 +306,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 
 	.rxq_info_get               = sxe2_rx_queue_info_get,
 	.txq_info_get               = sxe2_tx_queue_info_get,
+	.rx_burst_mode_get          = sxe2_rx_burst_mode_get,
+	.tx_burst_mode_get          = sxe2_tx_burst_mode_get,
 };
 
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index 3e88ab5241..b6d9520841 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -9,12 +9,11 @@
 #include <rte_memzone.h>
 #include <ethdev_driver.h>
 #include <unistd.h>
-
 #include "sxe2_txrx.h"
 #include "sxe2_txrx_common.h"
+#include "sxe2_txrx_vec.h"
 #include "sxe2_txrx_poll.h"
 #include "sxe2_ethdev.h"
-
 #include "sxe2_common_log.h"
 #include "sxe2_errno.h"
 #include "sxe2_osal.h"
@@ -22,18 +21,38 @@
 #if defined(RTE_ARCH_ARM64)
 #include <rte_cpuflags.h>
 #endif
-
+s32 __rte_cold
+sxe2_tx_simple_batch_support_check(struct rte_eth_dev *dev,
+		u32 *batch_flags)
+{
+	struct sxe2_tx_queue *txq;
+	s32 ret = SXE2_SUCCESS;
+	u16 i;
+	for (i = 0; i < dev->data->nb_tx_queues; ++i) {
+		txq = (struct sxe2_tx_queue *)dev->data->tx_queues[i];
+		if (txq == NULL) {
+			ret = SXE2_ERR_INVAL;
+			goto l_end;
+		}
+		if (txq->offloads != (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) ||
+		     txq->rs_thresh < SXE2_TX_PKTS_BURST_BATCH_NUM) {
+			ret = SXE2_ERR_NOTSUP;
+			goto l_end;
+		}
+	}
+	*batch_flags = SXE2_TX_MODE_SIMPLE_BATCH;
+l_end:
+	return ret;
+}
 static s32 sxe2_tx_desciptor_status(void *tx_queue, u16 offset)
 {
 	struct sxe2_tx_queue *txq = (struct sxe2_tx_queue *)tx_queue;
 	s32 ret;
 	u16 desc_idx;
-
 	if (unlikely(offset >= txq->ring_depth)) {
 		ret = SXE2_ERR_INVAL;
 		goto l_end;
 	}
-
 	desc_idx = txq->next_use + offset;
 	desc_idx = DIV_ROUND_UP(desc_idx, txq->rs_thresh) * (txq->rs_thresh);
 	if (desc_idx >= txq->ring_depth) {
@@ -41,19 +60,16 @@ static s32 sxe2_tx_desciptor_status(void *tx_queue, u16 offset)
 		if (desc_idx >= txq->ring_depth)
 			desc_idx -= txq->ring_depth;
 	}
-
 	if (desc_idx == 0)
 		desc_idx = txq->rs_thresh - 1;
 	else
 		desc_idx -= 1;
-
 	if (rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE) ==
 		(txq->desc_ring[desc_idx].wb.dd &
 		rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_MASK)))
 		ret = RTE_ETH_TX_DESC_DONE;
 	else
 		ret = RTE_ETH_TX_DESC_FULL;
-
 l_end:
 	return ret;
 }
@@ -61,13 +77,11 @@ static s32 sxe2_tx_desciptor_status(void *tx_queue, u16 offset)
 static inline s32 sxe2_tx_mbuf_empty_check(struct rte_mbuf *mbuf)
 {
 	struct rte_mbuf *m_seg = mbuf;
-
 	while (m_seg != NULL) {
 		if (m_seg->data_len == 0)
 			return SXE2_ERR_INVAL;
 		m_seg = m_seg->next;
 	}
-
 	return SXE2_SUCCESS;
 }
 
@@ -79,7 +93,6 @@ u16 sxe2_tx_pkts_prepare(__rte_unused void *tx_queue,
 	u64 ol_flags = 0;
 	s32 ret = SXE2_SUCCESS;
 	s32 i = 0;
-
 	for (i = 0; i < nb_pkts; i++) {
 		mbuf = tx_pkts[i];
 		if (!mbuf)
@@ -98,12 +111,10 @@ u16 sxe2_tx_pkts_prepare(__rte_unused void *tx_queue,
 			rte_errno = -SXE2_ERR_INVAL;
 			goto l_end;
 		}
-
 		if (mbuf->pkt_len < SXE2_TX_MIN_PKT_LEN) {
 			rte_errno = -SXE2_ERR_INVAL;
 			goto l_end;
 		}
-
 #ifdef RTE_ETHDEV_DEBUG_TX
 		ret = rte_validate_tx_offload(mbuf);
 		if (ret != SXE2_SUCCESS) {
@@ -116,14 +127,12 @@ u16 sxe2_tx_pkts_prepare(__rte_unused void *tx_queue,
 			rte_errno = -ret;
 			goto l_end;
 		}
-
 		ret = sxe2_tx_mbuf_empty_check(mbuf);
 		if (ret != SXE2_SUCCESS) {
 			rte_errno = -ret;
 			goto l_end;
 		}
 	}
-
 l_end:
 	return i;
 }
@@ -132,42 +141,119 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	u32 tx_mode_flags = 0;
-
+	s32 ret;
+	u32 vec_flags;
+	u32 batch_flags;
+	RTE_SET_USED(vec_flags);
 	PMD_INIT_FUNC_TRACE();
-
-	dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
-	dev->tx_pkt_burst = sxe2_tx_pkts;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = sxe2_tx_vec_support_check(dev, &vec_flags);
+		if (ret == SXE2_SUCCESS &&
+				(rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)) {
+#ifdef RTE_ARCH_X86
+			if ((rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512) &&
+					(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
+					(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)) {
+#ifdef CC_AVX512_SUPPORT
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_AVX512);
+#else
+				PMD_LOG_INFO(TX, "AVX512 is not supported in build env.");
+#endif
+			}
+			if ((0 == (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)) &&
+					((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1) ||
+					(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1)) &&
+					(rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)) {
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_AVX2);
+			}
+			if ((0 == (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)))
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_SSE);
+#endif
+			if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
+				ret = sxe2_tx_queues_vec_prepare(dev);
+				if (ret != SXE2_SUCCESS)
+					tx_mode_flags &= (~SXE2_TX_MODE_VEC_SET_MASK);
+			}
+		}
+		ret = sxe2_tx_simple_batch_support_check(dev, &batch_flags);
+		if (ret == SXE2_SUCCESS && batch_flags == SXE2_TX_MODE_SIMPLE_BATCH)
+			tx_mode_flags |= SXE2_TX_MODE_SIMPLE_BATCH;
+	}
+	if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
+		dev->tx_pkt_prepare = NULL;
+#ifdef RTE_ARCH_X86
+		if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
+			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+			dev->tx_pkt_burst = sxe2_tx_pkts_vec_sse;
+		} else {
+			dev->tx_pkt_burst = sxe2_tx_pkts_vec_sse_simple;
+		}
+#endif
+	} else {
+		if (tx_mode_flags & SXE2_TX_MODE_SIMPLE_BATCH) {
+			dev->tx_pkt_prepare = NULL;
+			dev->tx_pkt_burst = sxe2_tx_pkts_simple;
+		} else {
+			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+			dev->tx_pkt_burst = sxe2_tx_pkts;
+		}
+	}
 	adapter->q_ctxt.tx_mode_flags = tx_mode_flags;
 	PMD_LOG_DEBUG(TX, "Tx mode flags:0x%016x port_id:%u.",
 				tx_mode_flags, dev->data->port_id);
 }
 
+static const struct {
+	eth_tx_burst_t tx_burst;
+	const char *info;
+} sxe2_tx_burst_infos[] = {
+	{ sxe2_tx_pkts,   "Scalar" },
+#ifdef RTE_ARCH_X86
+	{ sxe2_tx_pkts_vec_sse,        "Vector SSE" },
+	{ sxe2_tx_pkts_vec_sse_simple, "Vector SSE Simple" },
+#endif
+};
+
+s32 sxe2_tx_burst_mode_get(struct rte_eth_dev *dev,
+		__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	s32 ret = SXE2_ERR_INVAL;
+	u32 i;
+	u32 size;
+	size = RTE_DIM(sxe2_tx_burst_infos);
+	for (i = 0; i < size; ++i) {
+		if (pkt_burst == sxe2_tx_burst_infos[i].tx_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+					sxe2_tx_burst_infos[i].info);
+			ret = SXE2_SUCCESS;
+			break;
+		}
+	}
+	return ret;
+}
+
 static s32 sxe2_rx_desciptor_status(void *rx_queue, u16 offset)
 {
 	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
 	volatile union sxe2_rx_desc *desc;
 	s32 ret;
-
 	if (unlikely(offset >= rxq->ring_depth)) {
 		ret = SXE2_ERR_INVAL;
 		goto l_end;
 	}
-
 	if (offset >= rxq->ring_depth - rxq->hold_num) {
 		ret = RTE_ETH_RX_DESC_UNAVAIL;
 		goto l_end;
 	}
-
 	if (rxq->processing_idx + offset >= rxq->ring_depth)
 		desc = &rxq->desc_ring[rxq->processing_idx + offset - rxq->ring_depth];
 	else
 		desc = &rxq->desc_ring[rxq->processing_idx + offset];
-
 	if (rte_le_to_cpu_64(desc->wb.status_err_ptype_len) & SXE2_RX_DESC_STATUS_DD_MASK)
 		ret = RTE_ETH_RX_DESC_DONE;
 	else
 		ret = RTE_ETH_RX_DESC_AVAIL;
-
 l_end:
 	PMD_LOG_DEBUG(RX, "Rx queue desc[%u] status:%d queue_id:%u port_id:%u",
 				offset, ret, rxq->queue_id, rxq->port_id);
@@ -179,7 +265,6 @@ static s32 sxe2_rx_queue_count(void *rx_queue)
 	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
 	volatile union sxe2_rx_desc *desc;
 	u16 done_num = 0;
-
 	desc = &rxq->desc_ring[rxq->processing_idx];
 	while ((done_num < rxq->ring_depth) &&
 		(rte_le_to_cpu_64(desc->wb.status_err_ptype_len) &
@@ -190,59 +275,94 @@ static s32 sxe2_rx_queue_count(void *rx_queue)
 		else
 			desc += SXE2_RX_QUEUE_CHECK_INTERVAL_NUM;
 	}
-
 	PMD_LOG_DEBUG(RX, "Rx queue done desc count:%u queue_id:%u port_id:%u",
 				done_num, rxq->queue_id, rxq->port_id);
-
 	return done_num;
 }
 
-static bool __rte_cold sxe2_rx_offload_en_check(struct rte_eth_dev *dev, u64 offload)
-{
-	struct sxe2_rx_queue *rxq;
-	bool en = false;
-	u16 i;
-
-	for (i = 0; i < dev->data->nb_rx_queues; ++i) {
-		rxq = (struct sxe2_rx_queue *)dev->data->rx_queues[i];
-		if (rxq == NULL)
-			continue;
-
-		if (0 != (rxq->offloads & offload)) {
-			en = true;
-			goto l_end;
-		}
-	}
-
-l_end:
-	return en;
-}
-
 void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	u32 rx_mode_flags = 0;
+	s32 ret;
+	u32 vec_flags;
 
 	PMD_INIT_FUNC_TRACE();
-
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = sxe2_rx_vec_support_check(dev, &vec_flags);
+		if (ret == SXE2_SUCCESS &&
+			 rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
+#ifdef RTE_ARCH_X86
+			if (((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) == 0) &&
+				((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1) ||
+				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1)) &&
+				(rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)) {
+				rx_mode_flags |= (vec_flags | SXE2_RX_MODE_VEC_AVX2);
+			}
+			if (((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) == 0) &&
+				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
+				rx_mode_flags |= (vec_flags | SXE2_RX_MODE_VEC_SSE);
+			}
+#endif
+			if ((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) != 0) {
+				ret = sxe2_rx_queues_vec_prepare(dev);
+				if (ret != SXE2_SUCCESS)
+					rx_mode_flags &= (~SXE2_RX_MODE_VEC_SET_MASK);
+			}
+		}
+	}
+#ifdef RTE_ARCH_X86
+	if (rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) {
+		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_sse_offload;
+		goto l_end;
+	}
+#endif
 	if (sxe2_rx_offload_en_check(dev, RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_split;
 	else
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered;
-
+	goto l_end;
+l_end:
 	PMD_LOG_DEBUG(RX, "Rx mode flags:0x%016x port_id:%u.",
 				rx_mode_flags, dev->data->port_id);
 	adapter->q_ctxt.rx_mode_flags = rx_mode_flags;
 }
 
+static const struct {
+	eth_rx_burst_t rx_burst;
+	const char *info;
+} sxe2_rx_burst_infos[] = {
+	{ sxe2_rx_pkts_scattered,          "Scalar Scattered" },
+	{ sxe2_rx_pkts_scattered_split,          "Scalar Scattered split" },
+#ifdef RTE_ARCH_X86
+	{ sxe2_rx_pkts_scattered_vec_sse_offload,      "Vector SSE Scattered" },
+#endif
+};
+
+s32 sxe2_rx_burst_mode_get(struct rte_eth_dev *dev,
+			__rte_unused u16 queue_id, struct rte_eth_burst_mode *mode)
+{
+	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
+	s32 ret = SXE2_ERR_INVAL;
+	u32 i, size;
+	size = RTE_DIM(sxe2_rx_burst_infos);
+	for (i = 0; i < size; ++i) {
+		if (pkt_burst == sxe2_rx_burst_infos[i].rx_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 sxe2_rx_burst_infos[i].info);
+			ret = SXE2_SUCCESS;
+			break;
+		}
+	}
+	return ret;
+}
+
 void sxe2_set_common_function(struct rte_eth_dev *dev)
 {
 	PMD_INIT_FUNC_TRACE();
-
 	dev->rx_queue_count = sxe2_rx_queue_count;
 	dev->rx_descriptor_status = sxe2_rx_desciptor_status;
 	dev->rx_pkt_burst = sxe2_rx_pkts_scattered;
-
 	dev->tx_descriptor_status = sxe2_tx_desciptor_status;
 	dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
 	dev->tx_pkt_burst = sxe2_tx_pkts;
diff --git a/drivers/net/sxe2/sxe2_txrx.h b/drivers/net/sxe2/sxe2_txrx.h
index cd9ebfa32f..7bb852789c 100644
--- a/drivers/net/sxe2/sxe2_txrx.h
+++ b/drivers/net/sxe2/sxe2_txrx.h
@@ -6,16 +6,16 @@
 #define SXE2_TXRX_H
 #include <ethdev_driver.h>
 #include "sxe2_queue.h"
-
 void sxe2_set_common_function(struct rte_eth_dev *dev);
-
+s32 __rte_cold sxe2_tx_simple_batch_support_check(struct rte_eth_dev *dev,
+	u32 *batch_flags);
 u16 sxe2_tx_pkts_prepare(__rte_unused void *tx_queue,
 		struct rte_mbuf **tx_pkts, u16 nb_pkts);
-
 void sxe2_tx_mode_func_set(struct rte_eth_dev *dev);
-
 void __rte_cold sxe2_rx_queue_reset(struct sxe2_rx_queue *rxq);
-
 void sxe2_rx_mode_func_set(struct rte_eth_dev *dev);
-
+s32 sxe2_tx_burst_mode_get(struct rte_eth_dev *dev,
+			__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
+s32 sxe2_rx_burst_mode_get(struct rte_eth_dev *dev,
+			__rte_unused u16 queue_id, struct rte_eth_burst_mode *mode);
 #endif
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index 55bea8b74c..41f7288318 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -19,6 +19,66 @@
 #include "sxe2_common_log.h"
 #include "sxe2_errno.h"
 
+static __rte_always_inline s32
+sxe2_tx_bufs_free(struct sxe2_tx_queue *txq)
+{
+	struct sxe2_tx_buffer *buffer;
+	struct rte_mbuf *mbuf;
+	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX];
+	s32 ret;
+	u32 i;
+	u16 rs_thresh;
+	u16 free_num;
+	if ((txq->desc_ring[txq->next_dd].wb.dd &
+		     rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_MASK)) !=
+		     rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE)) {
+		ret = 0;
+		goto l_end;
+	}
+	rs_thresh = txq->rs_thresh;
+	buffer = &txq->buffer_ring[txq->next_dd - rs_thresh + 1];
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+		if (likely(rs_thresh <= SXE2_TX_FREE_BUFFER_SIZE_MAX)) {
+			mbuf = buffer[0].mbuf;
+			mbuf_free_arr[0] = mbuf;
+			free_num = 1;
+			for (i = 1; i < rs_thresh; ++i) {
+				mbuf = buffer[i].mbuf;
+				if (likely(mbuf->pool == mbuf_free_arr[0]->pool)) {
+					mbuf_free_arr[free_num] = mbuf;
+					free_num++;
+				} else {
+					rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
+								(void *)mbuf_free_arr, free_num);
+					mbuf_free_arr[0] = mbuf;
+					free_num = 1;
+				}
+			}
+			rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
+						(void *)mbuf_free_arr, free_num);
+		} else {
+			for (i = 0; i < rs_thresh; ++i, ++buffer) {
+				rte_mempool_put(buffer->mbuf->pool, buffer->mbuf);
+				buffer->mbuf = NULL;
+			}
+		}
+	} else {
+		for (i = 0; i < rs_thresh; ++i, ++buffer) {
+			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
+				if (mbuf != NULL)
+					rte_mempool_put(mbuf->pool, mbuf);
+			buffer->mbuf = NULL;
+		}
+	}
+	txq->desc_free_num += rs_thresh;
+	txq->next_dd       += rs_thresh;
+	if (txq->next_dd >= txq->ring_depth)
+		txq->next_dd = rs_thresh - 1;
+	ret = rs_thresh;
+l_end:
+	return ret;
+}
+
 static inline s32 sxe2_tx_cleanup(struct sxe2_tx_queue *txq)
 {
 	s32 ret = SXE2_SUCCESS;
@@ -330,6 +390,130 @@ u16 sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts)
 	return tx_num;
 }
 
+static __rte_always_inline void
+sxe2_tx_data_desc_fill(volatile union sxe2_tx_data_desc *desc,
+		struct rte_mbuf **tx_pkts)
+{
+	rte_iova_t buf_dma_addr;
+	u32 desc_offset;
+	buf_dma_addr = rte_mbuf_data_iova(*tx_pkts);
+	desc->read.buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+	desc_offset = SXE2_TX_DATA_DESC_MACLEN_VAL((*tx_pkts)->l2_len);
+	desc->read.type_cmd_off_bsz_l2t =
+				sxe2_tx_data_desc_build_cobt(SXE2_TX_DATA_DESC_CMD_EOP,
+					desc_offset, (*tx_pkts)->data_len, 0);
+}
+static __rte_always_inline void
+sxe2_tx_data_desc_fill_batch(volatile union sxe2_tx_data_desc *desc,
+		struct rte_mbuf **tx_pkts)
+{
+	rte_iova_t buf_dma_addr;
+	u32 i;
+	u32 desc_offset;
+	for (i = 0; i < SXE2_TX_FILL_PER_LOOP; ++i, ++desc, ++tx_pkts) {
+		buf_dma_addr = rte_mbuf_data_iova(*tx_pkts);
+		desc->read.buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+		desc_offset = SXE2_TX_DATA_DESC_MACLEN_VAL((*tx_pkts)->l2_len);
+		desc->read.type_cmd_off_bsz_l2t =
+			sxe2_tx_data_desc_build_cobt(SXE2_TX_DATA_DESC_CMD_EOP,
+					desc_offset,
+					(*tx_pkts)->data_len,
+					0);
+	}
+}
+
+static inline void sxe2_tx_ring_fill(struct sxe2_tx_queue *txq,
+				struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	struct sxe2_tx_buffer *buffer = &txq->buffer_ring[txq->next_use];
+	volatile union sxe2_tx_data_desc *desc = &txq->desc_ring[txq->next_use];
+	u32 i, j;
+	u32	mainpart;
+	u32 leftover;
+	mainpart = nb_pkts & ((u32)~SXE2_TX_FILL_PER_LOOP_MASK);
+	leftover = nb_pkts & ((u32)SXE2_TX_FILL_PER_LOOP_MASK);
+	for (i = 0; i < mainpart; i += SXE2_TX_FILL_PER_LOOP) {
+		for (j = 0; j < SXE2_TX_FILL_PER_LOOP; ++j)
+			(buffer + i + j)->mbuf = *(tx_pkts + i + j);
+		sxe2_tx_data_desc_fill_batch(desc + i, tx_pkts + i);
+	}
+	if (unlikely(leftover > 0)) {
+		for (i = 0; i < leftover; ++i) {
+			(buffer + mainpart + i)->mbuf = *(tx_pkts + mainpart + i);
+			sxe2_tx_data_desc_fill(desc + mainpart + i,
+					tx_pkts + mainpart + i);
+		}
+	}
+}
+
+static inline u16 sxe2_tx_pkts_batch(void *tx_queue,
+			struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	struct sxe2_tx_queue *txq = (struct sxe2_tx_queue *)tx_queue;
+	volatile union sxe2_tx_data_desc *desc_ring = txq->desc_ring;
+	u16 res_num = 0;
+	if (txq->desc_free_num < txq->free_thresh)
+		(void)sxe2_tx_bufs_free(txq);
+	nb_pkts = RTE_MIN(txq->desc_free_num, nb_pkts);
+	if (unlikely(nb_pkts == 0)) {
+		PMD_LOG_TX_DEBUG("Tx batch: may not enough free desc, "
+				"free_desc=%u, need_tx_pkts=%u",
+				txq->desc_free_num, nb_pkts);
+		goto l_end;
+	}
+	txq->desc_free_num -= nb_pkts;
+	if ((txq->next_use + nb_pkts) > txq->ring_depth) {
+		res_num = txq->ring_depth - txq->next_use;
+		sxe2_tx_ring_fill(txq, tx_pkts, res_num);
+		desc_ring[txq->next_rs].read.type_cmd_off_bsz_l2t |=
+				rte_cpu_to_le_64(SXE2_TX_DATA_DESC_CMD_RS_MASK);
+		txq->next_rs = txq->rs_thresh - 1;
+		txq->next_use = 0;
+	}
+	sxe2_tx_ring_fill(txq, tx_pkts + res_num, nb_pkts - res_num);
+	txq->next_use = txq->next_use + (nb_pkts - res_num);
+	if (txq->next_use > txq->next_rs) {
+		desc_ring[txq->next_rs].read.type_cmd_off_bsz_l2t |=
+				rte_cpu_to_le_64(SXE2_TX_DATA_DESC_CMD_RS_MASK);
+		txq->next_rs += txq->rs_thresh;
+		if (txq->next_rs >= txq->ring_depth)
+			txq->next_rs = txq->rs_thresh - 1;
+	}
+	if (txq->next_use >= txq->ring_depth)
+		txq->next_use = 0;
+	PMD_LOG_TX_DEBUG("port_id=%u queue_id=%u next_use=%u send_pkts=%u",
+			txq->port_id, txq->queue_id, txq->next_use, nb_pkts);
+	SXE2_PCI_REG_WRITE_WC(txq->tdt_reg_addr, txq->next_use);
+	SXE2_TX_STATS_CNT(tx_queue, tx_pkts_num, nb_pkts);
+l_end:
+	return nb_pkts;
+}
+
+u16 sxe2_tx_pkts_simple(void *tx_queue,
+			struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	u16 tx_done_num;
+	u16 tx_once_num;
+	u16 tx_need_num;
+	if (likely(nb_pkts <= SXE2_TX_PKTS_BURST_BATCH_NUM)) {
+		tx_done_num = sxe2_tx_pkts_batch(tx_queue,
+				tx_pkts, nb_pkts);
+		goto l_end;
+	}
+	tx_done_num = 0;
+	while (nb_pkts) {
+		tx_need_num = RTE_MIN(nb_pkts, SXE2_TX_PKTS_BURST_BATCH_NUM);
+		tx_once_num = sxe2_tx_pkts_batch(tx_queue,
+					&tx_pkts[tx_done_num], tx_need_num);
+		nb_pkts     -= tx_once_num;
+		tx_done_num += tx_once_num;
+		if (tx_once_num < tx_need_num)
+			break;
+	}
+l_end:
+	return tx_done_num;
+}
+
 static inline void
 sxe2_update_rx_tail(struct sxe2_rx_queue *rxq, u16 hold_num, u16 rx_id)
 {
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.h b/drivers/net/sxe2/sxe2_txrx_poll.h
index 4924b0f41f..67da08e58e 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.h
+++ b/drivers/net/sxe2/sxe2_txrx_poll.h
@@ -8,7 +8,8 @@
 #include "sxe2_queue.h"
 
 u16 sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts);
-
+u16 sxe2_tx_pkts_simple(void *tx_queue,
+			struct rte_mbuf **tx_pkts, u16 nb_pkts);
 u16 sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
 
 u16 sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.c b/drivers/net/sxe2/sxe2_txrx_vec.c
new file mode 100644
index 0000000000..1e44d510cd
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -0,0 +1,188 @@
+#include "sxe2_txrx_vec.h"
+#include "sxe2_txrx_vec_common.h"
+#include "sxe2_queue.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_errno.h"
+
+s32 __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, u32 *vec_flags)
+{
+	struct sxe2_rx_queue *rxq;
+	s32 ret = SXE2_SUCCESS;
+	u16 i;
+	*vec_flags = SXE2_RX_MODE_VEC_SIMPLE;
+	for (i = 0; i < dev->data->nb_rx_queues; ++i) {
+		rxq = (struct sxe2_rx_queue *)dev->data->rx_queues[i];
+		if (rxq == NULL) {
+			ret = SXE2_ERR_INVAL;
+			goto l_end;
+		}
+		if (!rte_is_power_of_2(rxq->ring_depth)) {
+			ret = SXE2_ERR_NOTSUP;
+			goto l_end;
+		}
+		if (rxq->rx_free_thresh < SXE2_RX_PKTS_BURST_BATCH_NUM_VEC &&
+			 (rxq->ring_depth % rxq->rx_free_thresh) != 0) {
+			ret = SXE2_ERR_NOTSUP;
+			goto l_end;
+		}
+		if ((rxq->offloads & SXE2_RX_VEC_NO_SUPPORT_OFFLOAD) != 0) {
+			ret = SXE2_ERR_NOTSUP;
+			goto l_end;
+		}
+		if ((rxq->offloads & SXE2_RX_VEC_SUPPORT_OFFLOAD) != 0)
+			*vec_flags = SXE2_RX_MODE_VEC_OFFLOAD;
+	}
+l_end:
+	return ret;
+}
+
+bool __rte_cold sxe2_rx_offload_en_check(struct rte_eth_dev *dev, u64 offload)
+{
+	struct sxe2_rx_queue *rxq;
+	bool en = false;
+	u16 i;
+	for (i = 0; i < dev->data->nb_rx_queues; ++i) {
+		rxq = (struct sxe2_rx_queue *)dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+		if ((rxq->offloads & offload) != 0) {
+			en = true;
+			goto l_end;
+		}
+	}
+l_end:
+	return en;
+}
+
+static inline void sxe2_rx_queue_mbufs_release_vec(struct sxe2_rx_queue *rxq)
+{
+	const u16 mask = rxq->ring_depth - 1;
+	u16 i;
+	if (unlikely(!rxq->buffer_ring)) {
+		PMD_LOG_DEBUG(RX, "Rx queue release mbufs vec, buffer_ring if NULL."
+				"port_id:%u queue_id:%u", rxq->port_id, rxq->queue_id);
+		return;
+	}
+	if (rxq->realloc_num >= rxq->ring_depth)
+		return;
+	if (rxq->realloc_num == 0) {
+		for (i = 0; i < rxq->ring_depth; ++i) {
+			if (rxq->buffer_ring[i]) {
+				rte_pktmbuf_free_seg(rxq->buffer_ring[i]);
+				rxq->buffer_ring[i] = NULL;
+			}
+		}
+	} else {
+		for (i = rxq->processing_idx;
+				i != rxq->realloc_start;
+				i = (i + 1) & mask) {
+			if (rxq->buffer_ring[i]) {
+				rte_pktmbuf_free_seg(rxq->buffer_ring[i]);
+				rxq->buffer_ring[i] = NULL;
+			}
+		}
+	}
+	rxq->realloc_num = rxq->ring_depth;
+	memset(rxq->buffer_ring, 0, rxq->ring_depth * sizeof(rxq->buffer_ring[0]));
+}
+
+static inline void sxe2_rx_queue_vec_init(struct sxe2_rx_queue *rxq)
+{
+	uintptr_t data;
+	struct rte_mbuf mbuf_def;
+	mbuf_def.buf_addr = 0;
+	mbuf_def.nb_segs = 1;
+	mbuf_def.data_off = RTE_PKTMBUF_HEADROOM;
+	mbuf_def.port = rxq->port_id;
+	rte_mbuf_refcnt_set(&mbuf_def, 1);
+	rte_compiler_barrier();
+	data = (uintptr_t)&mbuf_def.rearm_data;
+	rxq->mbuf_init_value = *(u64 *)data;
+}
+
+s32 __rte_cold sxe2_rx_queues_vec_prepare(struct rte_eth_dev *dev)
+{
+	struct sxe2_rx_queue *rxq = NULL;
+	s32 ret = SXE2_SUCCESS;
+	u16 i;
+	for (i = 0; i < dev->data->nb_rx_queues; ++i) {
+		rxq = (struct sxe2_rx_queue *)dev->data->rx_queues[i];
+		if (rxq == NULL) {
+			PMD_LOG_INFO(RX, "Failed to prepare rx queue, rxq[%d] is NULL", i);
+			continue;
+		}
+		rxq->ops.mbufs_release = sxe2_rx_queue_mbufs_release_vec;
+		sxe2_rx_queue_vec_init(rxq);
+	}
+	return ret;
+}
+
+s32 __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, u32 *vec_flags)
+{
+	struct sxe2_tx_queue *txq;
+	s32 ret = SXE2_SUCCESS;
+	u32 i;
+	*vec_flags = SXE2_TX_MODE_VEC_SIMPLE;
+	for (i = 0; i < dev->data->nb_tx_queues; ++i) {
+		txq = (struct sxe2_tx_queue *)dev->data->tx_queues[i];
+		if (txq == NULL) {
+			ret = SXE2_ERR_INVAL;
+			goto l_end;
+		}
+		if (txq->rs_thresh < SXE2_TX_RS_THRESH_MIN_VEC ||
+			 txq->rs_thresh > SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC) {
+			ret = SXE2_ERR_NOTSUP;
+			goto l_end;
+		}
+		if ((txq->offloads & SXE2_TX_VEC_NO_SUPPORT_OFFLOAD) != 0) {
+			ret = SXE2_ERR_NOTSUP;
+			goto l_end;
+		}
+		if ((txq->offloads & SXE2_TX_VEC_SUPPORT_OFFLOAD) != 0)
+			*vec_flags = SXE2_TX_MODE_VEC_OFFLOAD;
+	}
+l_end:
+	return ret;
+}
+
+static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq)
+{
+	struct sxe2_tx_buffer *buffer;
+	u16 i;
+	if (unlikely(txq == NULL || txq->buffer_ring == NULL)) {
+		PMD_LOG_ERR(TX, "Tx release mbufs vec, invalid params.");
+		goto l_end;
+	}
+	i = txq->next_dd - (txq->rs_thresh - 1);
+	buffer = txq->buffer_ring;
+	if (txq->next_use < i) {
+		for ( ; i < txq->ring_depth; ++i) {
+			rte_pktmbuf_free_seg(buffer[i].mbuf);
+			buffer[i].mbuf = NULL;
+		}
+		i = 0;
+	}
+	for (; i < txq->next_use; ++i) {
+		rte_pktmbuf_free_seg(buffer[i].mbuf);
+		buffer[i].mbuf = NULL;
+	}
+l_end:
+	return;
+}
+
+s32 __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev)
+{
+	struct sxe2_tx_queue *txq = NULL;
+	s32 ret = SXE2_SUCCESS;
+	u16 i;
+	for (i = 0; i < dev->data->nb_tx_queues; ++i) {
+		txq = dev->data->tx_queues[i];
+		if (txq == NULL) {
+			PMD_LOG_INFO(TX, "Failed to prepare tx queue, txq[%d] is NULL", i);
+			continue;
+		}
+		txq->ops.mbufs_release = sxe2_tx_queue_mbufs_release_vec;
+	}
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.h b/drivers/net/sxe2/sxe2_txrx_vec.h
new file mode 100644
index 0000000000..cb6a3dd3b8
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_vec.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef _SXE2_TXRX_VEC_H_
+#define _SXE2_TXRX_VEC_H_
+#include <ethdev_driver.h>
+#include "sxe2_queue.h"
+#include "sxe2_type.h"
+#define SXE2_RX_MODE_VEC_SIMPLE    RTE_BIT32(0)
+#define SXE2_RX_MODE_VEC_OFFLOAD   RTE_BIT32(1)
+#define SXE2_RX_MODE_VEC_SSE       RTE_BIT32(2)
+#define SXE2_RX_MODE_VEC_AVX2      RTE_BIT32(3)
+#define SXE2_RX_MODE_VEC_AVX512    RTE_BIT32(4)
+#define SXE2_RX_MODE_VEC_NEON      RTE_BIT32(5)
+#define SXE2_RX_MODE_BATCH_ALLOC   RTE_BIT32(10)
+#define SXE2_RX_MODE_VEC_SET_MASK	(SXE2_RX_MODE_VEC_SIMPLE | \
+			SXE2_RX_MODE_VEC_OFFLOAD | SXE2_RX_MODE_VEC_SSE | \
+			SXE2_RX_MODE_VEC_AVX2 | SXE2_RX_MODE_VEC_AVX512 | \
+			SXE2_RX_MODE_VEC_NEON)
+#define SXE2_TX_MODE_VEC_SIMPLE   RTE_BIT32(0)
+#define SXE2_TX_MODE_VEC_OFFLOAD  RTE_BIT32(1)
+#define SXE2_TX_MODE_VEC_SSE      RTE_BIT32(2)
+#define SXE2_TX_MODE_VEC_AVX2     RTE_BIT32(3)
+#define SXE2_TX_MODE_VEC_AVX512   RTE_BIT32(4)
+#define SXE2_TX_MODE_VEC_NEON     RTE_BIT32(5)
+#define SXE2_TX_MODE_SIMPLE_BATCH RTE_BIT32(10)
+#define SXE2_TX_MODE_VEC_SET_MASK	(SXE2_TX_MODE_VEC_SIMPLE | \
+			SXE2_TX_MODE_VEC_OFFLOAD | SXE2_TX_MODE_VEC_SSE | \
+			SXE2_TX_MODE_VEC_AVX2 | SXE2_TX_MODE_VEC_AVX512 | \
+			SXE2_TX_MODE_VEC_NEON)
+#define SXE2_TX_VEC_NO_SUPPORT_OFFLOAD (		  \
+			RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		  \
+			RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	  \
+			RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM | \
+			RTE_ETH_TX_OFFLOAD_TCP_TSO |	      \
+			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |    \
+			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |      \
+			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |     \
+			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |   \
+			RTE_ETH_TX_OFFLOAD_SECURITY |   \
+			RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
+#define SXE2_TX_VEC_SUPPORT_OFFLOAD (		    \
+			RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+			RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+			RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+			RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+			RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
+#define SXE2_RX_VEC_NO_SUPPORT_OFFLOAD (	    \
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |      \
+		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |    \
+		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM | \
+		RTE_ETH_RX_OFFLOAD_SECURITY |        \
+		RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
+#define SXE2_RX_VEC_SUPPORT_OFFLOAD (		\
+		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |	    \
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH)
+#ifdef RTE_ARCH_X86
+u16 sxe2_tx_pkts_vec_sse(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts);
+u16 sxe2_tx_pkts_vec_sse_simple(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts);
+u16 sxe2_rx_pkts_scattered_vec_sse_offload(void *rx_queue,
+		struct rte_mbuf **rx_pkts, u16 nb_pkts);
+#endif
+s32 __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, u32 *vec_flags);
+s32 __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev);
+s32 __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, u32 *vec_flags);
+bool __rte_cold sxe2_rx_offload_en_check(struct rte_eth_dev *dev, u64 offload);
+s32 __rte_cold sxe2_rx_queues_vec_prepare(struct rte_eth_dev *dev);
+#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_common.h b/drivers/net/sxe2/sxe2_txrx_vec_common.h
new file mode 100644
index 0000000000..c0405c9a59
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_vec_common.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_TXRX_VEC_COMMON_H__
+#define __SXE2_TXRX_VEC_COMMON_H__
+#include <rte_atomic.h>
+#ifdef PCLINT
+#include "avx_stub.h"
+#endif
+#include "sxe2_rx.h"
+#include "sxe2_queue.h"
+#include "sxe2_tx.h"
+#include "sxe2_vsi.h"
+#include "sxe2_ethdev.h"
+#define SXE2_RX_NUM_PER_LOOP_SSE    4
+#define SXE2_RX_NUM_PER_LOOP_AVX     8
+#define SXE2_RX_NUM_PER_LOOP_NEON    4
+#define SXE2_RX_REARM_THRESH_VEC       64
+#define SXE2_RX_PKTS_BURST_BATCH_NUM_VEC   32
+#define SXE2_TX_RS_THRESH_MIN_VEC	32
+#define SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC  64
+
+static __rte_always_inline void
+sxe2_tx_pkts_mbuf_fill(struct sxe2_tx_buffer *buffer,
+		struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	u16 i;
+	for (i = 0; i < nb_pkts; ++i)
+		buffer[i].mbuf = tx_pkts[i];
+}
+
+static __rte_always_inline s32
+sxe2_tx_bufs_free_vec(struct sxe2_tx_queue *txq)
+{
+	struct sxe2_tx_buffer *buffer;
+	struct rte_mbuf *mbuf;
+	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
+	s32 ret;
+	u32 i;
+	u16 rs_thresh;
+	u16 free_num;
+	if ((txq->desc_ring[txq->next_dd].wb.dd &
+			 rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_MASK)) !=
+			 rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE)) {
+		ret = 0;
+		goto l_end;
+	}
+	rs_thresh = txq->rs_thresh;
+	buffer = &txq->buffer_ring[txq->next_dd - (rs_thresh - 1)];
+	mbuf = rte_pktmbuf_prefree_seg(buffer[0].mbuf);
+	if (likely(mbuf)) {
+		mbuf_free_arr[0] = mbuf;
+		free_num = 1;
+		for (i = 1; i < rs_thresh; ++i) {
+			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
+			if (likely(mbuf)) {
+				if (likely(mbuf->pool == mbuf_free_arr[0]->pool)) {
+					mbuf_free_arr[free_num] = mbuf;
+					free_num++;
+				} else {
+					rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
+								(void *)mbuf_free_arr, free_num);
+					mbuf_free_arr[0] = mbuf;
+					free_num = 1;
+				}
+			}
+		}
+		rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
+							(void *)mbuf_free_arr, free_num);
+	} else {
+		for (i = 1; i < rs_thresh; ++i) {
+			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
+			if (mbuf != NULL)
+				rte_mempool_put(mbuf->pool, mbuf);
+		}
+	}
+	txq->desc_free_num += rs_thresh;
+	txq->next_dd       += rs_thresh;
+	if (txq->next_dd >= txq->ring_depth)
+		txq->next_dd = rs_thresh - 1;
+	ret = rs_thresh;
+l_end:
+	return ret;
+}
+
+static inline void
+sxe2_tx_desc_fill_offloads(struct rte_mbuf *mbuf, u64 *desc_qw1)
+{
+	u64 offloads = mbuf->ol_flags;
+	u32 desc_cmd = 0;
+	u32 desc_offset = 0;
+	if (offloads & RTE_MBUF_F_TX_IP_CKSUM) {
+		desc_cmd    |= SXE2_TX_DATA_DESC_CMD_IIPT_IPV4_CSUM;
+		desc_offset |= SXE2_TX_DATA_DESC_IPLEN_VAL(mbuf->l3_len);
+	} else if (offloads & RTE_MBUF_F_TX_IPV4) {
+		desc_cmd    |= SXE2_TX_DATA_DESC_CMD_IIPT_IPV4;
+		desc_offset |= SXE2_TX_DATA_DESC_IPLEN_VAL(mbuf->l3_len);
+	} else if (offloads & RTE_MBUF_F_TX_IPV6) {
+		desc_cmd    |= SXE2_TX_DATA_DESC_CMD_IIPT_IPV6;
+		desc_offset |= SXE2_TX_DATA_DESC_IPLEN_VAL(mbuf->l3_len);
+	}
+	switch (offloads & RTE_MBUF_F_TX_L4_MASK) {
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_TCP;
+		desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(mbuf->l4_len);
+		break;
+	case RTE_MBUF_F_TX_SCTP_CKSUM:
+		desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_SCTP;
+		desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(mbuf->l4_len);
+		break;
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_UDP;
+		desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(mbuf->l4_len);
+		break;
+	default:
+		break;
+	}
+	*desc_qw1 |= ((u64)desc_offset) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+	if (offloads & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+		desc_cmd |= SXE2_TX_DATA_DESC_CMD_IL2TAG1;
+		*desc_qw1 |= ((u64)mbuf->vlan_tci) << SXE2_TX_DATA_DESC_L2TAG1_SHIFT;
+	}
+	*desc_qw1 |= ((u64)desc_cmd) << SXE2_TX_DATA_DESC_CMD_SHIFT;
+}
+#define SXE2_RX_UMBCAST_FLAGS_VAL_GET(_flags) \
+		(((_flags) & 0x30) >> 4)
+
+static inline void sxe2_vf_rx_vec_sw_stats_cnt(struct sxe2_rx_queue *rxq,
+		struct rte_mbuf *mbuf, u8 umbcast_flag)
+{
+	if (rxq->vsi->adapter->devargs.sw_stats_en) {
+		rte_atomic_fetch_add_explicit(&rxq->sw_stats.pkts, 1,
+					rte_memory_order_relaxed);
+		rte_atomic_fetch_add_explicit(&rxq->sw_stats.bytes,
+				 mbuf->pkt_len + RTE_ETHER_CRC_LEN, rte_memory_order_relaxed);
+		switch (SXE2_RX_UMBCAST_FLAGS_VAL_GET(umbcast_flag)) {
+		case SXE2_RX_DESC_STATUS_UNICAST:
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.unicast_pkts, 1,
+					rte_memory_order_relaxed);
+			break;
+		case SXE2_RX_DESC_STATUS_MUTICAST:
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.multicast_pkts, 1,
+					rte_memory_order_relaxed);
+			break;
+		case SXE2_RX_DESC_STATUS_BOARDCAST:
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.broadcast_pkts, 1,
+					rte_memory_order_relaxed);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static inline u16
+sxe2_rx_pkts_refactor(struct sxe2_rx_queue *rxq,
+		struct rte_mbuf **mbuf_bufs, u16 mbuf_num,
+		u8 *split_rxe_flags, u8 *umbcast_flags)
+{
+	struct rte_mbuf *done_pkts[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
+	struct rte_mbuf *last_seg  = rxq->pkt_last_seg;
+	struct rte_mbuf *tmp_seg;
+	u16 done_num, buf_idx;
+	done_num = 0;
+	for (buf_idx = 0; buf_idx < mbuf_num; buf_idx++) {
+		if (last_seg) {
+			last_seg->next = mbuf_bufs[buf_idx];
+			mbuf_bufs[buf_idx]->data_len += rxq->crc_len;
+			first_seg->nb_segs++;
+			first_seg->pkt_len += mbuf_bufs[buf_idx]->data_len;
+			last_seg = last_seg->next;
+			if (split_rxe_flags[buf_idx] == 0) {
+				first_seg->hash = last_seg->hash;
+				first_seg->vlan_tci = last_seg->vlan_tci;
+				first_seg->ol_flags = last_seg->ol_flags;
+				first_seg->pkt_len -= rxq->crc_len;
+				if (last_seg->data_len > rxq->crc_len) {
+					last_seg->data_len -= rxq->crc_len;
+				} else {
+					tmp_seg = first_seg;
+					first_seg->nb_segs--;
+					while (tmp_seg->next != last_seg)
+						tmp_seg = tmp_seg->next;
+					tmp_seg->data_len -= (rxq->crc_len - last_seg->data_len);
+					tmp_seg->next = NULL;
+					rte_pktmbuf_free_seg(last_seg);
+					last_seg = NULL;
+				}
+				done_pkts[done_num++] = first_seg;
+				sxe2_vf_rx_vec_sw_stats_cnt(rxq, first_seg, umbcast_flags[buf_idx]);
+				first_seg = NULL;
+				last_seg  = NULL;
+			} else if (split_rxe_flags[buf_idx] & SXE2_RX_DESC_STATUS_EOP_MASK) {
+				continue;
+			} else {
+				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
+					rte_memory_order_relaxed);
+				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
+				 first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
+				 rte_memory_order_relaxed);
+				rte_pktmbuf_free(first_seg);
+				first_seg = NULL;
+				last_seg  = NULL;
+				continue;
+			}
+		} else {
+			if (split_rxe_flags[buf_idx] == 0) {
+				done_pkts[done_num++] = mbuf_bufs[buf_idx];
+				sxe2_vf_rx_vec_sw_stats_cnt(rxq, mbuf_bufs[buf_idx],
+					 umbcast_flags[buf_idx]);
+				continue;
+			} else if (split_rxe_flags[buf_idx] & SXE2_RX_DESC_STATUS_EOP_MASK) {
+				first_seg = mbuf_bufs[buf_idx];
+				last_seg  = first_seg;
+				mbuf_bufs[buf_idx]->data_len += rxq->crc_len;
+				mbuf_bufs[buf_idx]->pkt_len  += rxq->crc_len;
+			} else {
+				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
+					rte_memory_order_relaxed);
+				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
+				 mbuf_bufs[buf_idx]->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
+				 rte_memory_order_relaxed);
+				rte_pktmbuf_free_seg(mbuf_bufs[buf_idx]);
+				continue;
+			}
+		}
+	}
+	rxq->pkt_first_seg = first_seg;
+	rxq->pkt_last_seg  = last_seg;
+	rte_memcpy(mbuf_bufs, done_pkts, done_num * (sizeof(struct rte_mbuf *)));
+	return done_num;
+}
+#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_sse.c b/drivers/net/sxe2/sxe2_txrx_vec_sse.c
new file mode 100644
index 0000000000..9bc291577b
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_vec_sse.c
@@ -0,0 +1,547 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <ethdev_driver.h>
+#include <rte_bitops.h>
+#include <rte_malloc.h>
+#include <rte_mempool.h>
+#include <rte_vect.h>
+#include "rte_common.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_queue.h"
+#include "sxe2_txrx_vec.h"
+#include "sxe2_txrx_vec_common.h"
+#include "sxe2_vsi.h"
+
+static __rte_always_inline void
+sxe2_tx_desc_fill_one_sse(volatile union sxe2_tx_data_desc *desc,
+		struct rte_mbuf *pkt,
+		u64 desc_cmd, bool with_offloads)
+{
+	__m128i data_desc;
+	u64 desc_qw1;
+	u32 desc_offset;
+	desc_qw1 = (SXE2_TX_DESC_DTYPE_DATA |
+		    ((u64)desc_cmd) << SXE2_TX_DATA_DESC_CMD_SHIFT |
+		    ((u64)pkt->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT);
+	desc_offset = SXE2_TX_DATA_DESC_MACLEN_VAL(pkt->l2_len);
+	desc_qw1 |= ((u64)desc_offset) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+	if (with_offloads)
+		sxe2_tx_desc_fill_offloads(pkt, &desc_qw1);
+	data_desc = _mm_set_epi64x(desc_qw1, rte_pktmbuf_iova(pkt));
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, desc), data_desc);
+}
+
+static __rte_always_inline u16
+sxe2_tx_pkts_vec_sse_batch(struct sxe2_tx_queue *txq,
+		struct rte_mbuf **tx_pkts,
+		u16 nb_pkts, bool with_offloads)
+{
+	volatile union sxe2_tx_data_desc *desc;
+	struct sxe2_tx_buffer *buffer;
+	u16 next_use;
+	u16 res_num;
+	u16 tx_num;
+	u16 i;
+	if (txq->desc_free_num < txq->free_thresh)
+		(void)sxe2_tx_bufs_free_vec(txq);
+	nb_pkts = RTE_MIN(txq->desc_free_num, nb_pkts);
+	if (unlikely(nb_pkts == 0)) {
+		PMD_LOG_TX_DEBUG("Tx pkts sse batch: may not enough free desc, "
+				"free_desc=%u, need_tx_pkts=%u",
+				txq->desc_free_num, nb_pkts);
+		goto l_end;
+	}
+	tx_num = nb_pkts;
+	next_use = txq->next_use;
+	desc     = &txq->desc_ring[next_use];
+	buffer   = &txq->buffer_ring[next_use];
+	txq->desc_free_num -= nb_pkts;
+	res_num = txq->ring_depth - txq->next_use;
+	if (tx_num >= res_num) {
+		sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, res_num);
+		for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
+			sxe2_tx_desc_fill_one_sse(desc, *tx_pkts,
+						  SXE2_TX_DATA_DESC_CMD_EOP,
+						  with_offloads);
+		}
+		sxe2_tx_desc_fill_one_sse(desc, *tx_pkts++,
+			(SXE2_TX_DATA_DESC_CMD_EOP | SXE2_TX_DATA_DESC_CMD_RS),
+			with_offloads);
+		tx_num -= res_num;
+		next_use     = 0;
+		txq->next_rs = txq->rs_thresh - 1;
+		desc         = &txq->desc_ring[next_use];
+		buffer       = &txq->buffer_ring[next_use];
+	}
+	sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, tx_num);
+	for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
+		sxe2_tx_desc_fill_one_sse(desc, *tx_pkts,
+					  SXE2_TX_DATA_DESC_CMD_EOP,
+					  with_offloads);
+	}
+	next_use += tx_num;
+	if (next_use > txq->next_rs) {
+		txq->desc_ring[txq->next_rs].read.type_cmd_off_bsz_l2t |=
+			rte_cpu_to_le_64(SXE2_TX_DATA_DESC_CMD_RS_MASK);
+		txq->next_rs += txq->rs_thresh;
+	}
+	txq->next_use = next_use;
+	SXE2_PCI_REG_WRITE_WC(txq->tdt_reg_addr, next_use);
+	PMD_LOG_TX_DEBUG("port_id=%u queue_id=%u next_use=%u send_pkts=%u",
+			 txq->port_id, txq->queue_id, next_use, nb_pkts);
+	SXE2_TX_STATS_CNT(txq, tx_pkts_num, nb_pkts);
+l_end:
+	return nb_pkts;
+}
+
+static __rte_always_inline u16
+sxe2_tx_pkts_vec_sse_common(struct sxe2_tx_queue *txq,
+		struct rte_mbuf **tx_pkts,
+		u16 nb_pkts, bool with_offloads)
+{
+	u16 tx_done_num = 0;
+	u16 tx_once_num;
+	u16 tx_need_num;
+	while (nb_pkts) {
+		tx_need_num = RTE_MIN(nb_pkts, txq->rs_thresh);
+		tx_once_num = sxe2_tx_pkts_vec_sse_batch(txq,
+				tx_pkts + tx_done_num,
+				tx_need_num, with_offloads);
+		nb_pkts     -= tx_once_num;
+		tx_done_num += tx_once_num;
+		if (tx_once_num < tx_need_num)
+			break;
+	}
+	return tx_done_num;
+}
+
+u16 sxe2_tx_pkts_vec_sse_simple(void *tx_queue,
+			struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	return sxe2_tx_pkts_vec_sse_common((struct sxe2_tx_queue *)tx_queue,
+				tx_pkts, nb_pkts, false);
+}
+u16 sxe2_tx_pkts_vec_sse(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	return sxe2_tx_pkts_vec_sse_common((struct sxe2_tx_queue *)tx_queue,
+				tx_pkts, nb_pkts, true);
+}
+
+static inline void sxe2_rx_queue_rearm_sse(struct sxe2_rx_queue *rxq)
+{
+	volatile union sxe2_rx_desc *desc;
+	struct rte_mbuf **buffer;
+	struct rte_mbuf *mbuf0, *mbuf1;
+	__m128i dma_addr0, dma_addr1;
+	__m128i virt_addr0, virt_addr1;
+	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
+				RTE_PKTMBUF_HEADROOM);
+	s32 ret;
+	u16 i;
+	u16 new_tail;
+	buffer = &rxq->buffer_ring[rxq->realloc_start];
+	desc = &rxq->desc_ring[rxq->realloc_start];
+	ret = rte_mempool_get_bulk(rxq->mb_pool, (void *)buffer,
+			SXE2_RX_REARM_THRESH_VEC);
+	if (ret != 0) {
+		PMD_LOG_RX_INFO("Rx mbuf vec alloc failed port_id=%u "
+				"queue_id=%u", rxq->port_id, rxq->queue_id);
+		if ((rxq->realloc_num + SXE2_RX_REARM_THRESH_VEC) >= rxq->ring_depth) {
+			dma_addr0 = _mm_setzero_si128();
+			for (i = 0; i < SXE2_RX_NUM_PER_LOOP_SSE; ++i) {
+				buffer[i] = &rxq->fake_mbuf;
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc[i].read),
+						dma_addr0);
+			}
+		}
+		rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed +=
+				SXE2_RX_REARM_THRESH_VEC;
+		goto l_end;
+	}
+	for (i = 0; i < SXE2_RX_REARM_THRESH_VEC; i += 2, buffer += 2) {
+		mbuf0 = buffer[0];
+		mbuf1 = buffer[1];
+#if RTE_IOVA_IN_MBUF
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				 offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		virt_addr0 = _mm_loadu_si128((__m128i *)&mbuf0->buf_addr);
+		virt_addr1 = _mm_loadu_si128((__m128i *)&mbuf1->buf_addr);
+#if RTE_IOVA_IN_MBUF
+		dma_addr0 = _mm_unpackhi_epi64(virt_addr0, virt_addr0);
+		dma_addr1 = _mm_unpackhi_epi64(virt_addr1, virt_addr1);
+#else
+		dma_addr0 = _mm_unpacklo_epi64(virt_addr0, virt_addr0);
+		dma_addr1 = _mm_unpacklo_epi64(virt_addr1, virt_addr1);
+#endif
+		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
+		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc++->read), dma_addr0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc++->read), dma_addr1);
+	}
+	rxq->realloc_start += SXE2_RX_REARM_THRESH_VEC;
+	if (rxq->realloc_start >= rxq->ring_depth)
+		rxq->realloc_start = 0;
+	rxq->realloc_num -= SXE2_RX_REARM_THRESH_VEC;
+	new_tail = (rxq->realloc_start == 0) ?
+		(rxq->ring_depth - 1) : (rxq->realloc_start - 1);
+	SXE2_PCI_REG_WRITE_WC(rxq->rdt_reg_addr, new_tail);
+l_end:
+	return;
+}
+
+static __rte_always_inline __m128i
+sxe2_rx_desc_fnav_flags_sse(__m128i descs_arr[4])
+{
+	__m128i descs_tmp1, descs_tmp2;
+	__m128i descs_fnav_vld;
+	__m128i v_zeros, v_ffff, v_u32_one;
+	__m128i m_flags;
+	const __m128i fdir_flags = _mm_set1_epi32(RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID);
+	descs_tmp1 = _mm_unpacklo_epi32(descs_arr[0], descs_arr[1]);
+	descs_tmp2 = _mm_unpacklo_epi32(descs_arr[2], descs_arr[3]);
+	descs_fnav_vld = _mm_unpacklo_epi64(descs_tmp1, descs_tmp2);
+	descs_fnav_vld = _mm_slli_epi32(descs_fnav_vld, 26);
+	descs_fnav_vld = _mm_srli_epi32(descs_fnav_vld, 31);
+	v_zeros = _mm_setzero_si128();
+	v_ffff = _mm_cmpeq_epi32(v_zeros, v_zeros);
+	v_u32_one = _mm_srli_epi32(v_ffff, 31);
+	m_flags = _mm_cmpeq_epi32(descs_fnav_vld, v_u32_one);
+	m_flags = _mm_and_si128(m_flags, fdir_flags);
+	return m_flags;
+}
+
+static __rte_always_inline void
+sxe2_rx_desc_offloads_para_fill_sse(struct sxe2_rx_queue *rxq,
+		volatile union sxe2_rx_desc *desc __rte_unused,
+		__m128i descs_arr[4],
+		struct rte_mbuf **rx_pkts)
+{
+	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_init_value);
+	__m128i rearm_arr[4];
+	__m128i tmp_desc_lo, tmp_desc_hi, flags, tmp_flags;
+	const __m128i desc_flags_mask = _mm_set_epi32(0x00001C04, 0x00001C04,
+						      0x00001C04, 0x00001C04);
+	const __m128i desc_flags_rss_mask = _mm_set_epi32(0x20000000, 0x20000000,
+							  0x20000000, 0x20000000);
+	const __m128i vlan_flags = _mm_set_epi8(0, 0, 0, 0,
+						0, 0, 0, 0,
+						0, 0, 0, RTE_MBUF_F_RX_VLAN |
+						RTE_MBUF_F_RX_VLAN_STRIPPED,
+						0, 0, 0, 0);
+	const __m128i rss_flags = _mm_set_epi8(0, 0, 0, 0,
+						0, 0, 0, 0, 0, 0, 0, RTE_MBUF_F_RX_RSS_HASH,
+						0, 0, 0, 0);
+	const __m128i cksum_flags =
+			_mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0,
+				     ((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+						RTE_MBUF_F_RX_L4_CKSUM_BAD |
+						RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+				     ((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+						RTE_MBUF_F_RX_L4_CKSUM_BAD |
+						RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+				     ((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+						RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+						RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+				     ((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+						RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+						RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+				     ((RTE_MBUF_F_RX_L4_CKSUM_BAD |
+						RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+				     ((RTE_MBUF_F_RX_L4_CKSUM_BAD |
+						RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+				     ((RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+						RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+				     ((RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+						RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1));
+	const __m128i cksum_mask =
+			_mm_set_epi32(RTE_MBUF_F_RX_IP_CKSUM_MASK |
+				      RTE_MBUF_F_RX_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+				      RTE_MBUF_F_RX_IP_CKSUM_MASK |
+				      RTE_MBUF_F_RX_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+				      RTE_MBUF_F_RX_IP_CKSUM_MASK |
+				      RTE_MBUF_F_RX_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+				      RTE_MBUF_F_RX_IP_CKSUM_MASK |
+				      RTE_MBUF_F_RX_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
+				      RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD);
+	const __m128i vlan_mask =
+			_mm_set_epi32(RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+				      RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+				      RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN |
+				      RTE_MBUF_F_RX_VLAN_STRIPPED,
+				      RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
+	flags = _mm_unpackhi_epi32(descs_arr[0], descs_arr[1]);
+	tmp_flags = _mm_unpackhi_epi32(descs_arr[2], descs_arr[3]);
+	tmp_desc_lo = _mm_unpacklo_epi64(flags, tmp_flags);
+	tmp_desc_hi = _mm_unpackhi_epi64(flags, tmp_flags);
+	tmp_desc_lo = _mm_and_si128(tmp_desc_lo, desc_flags_mask);
+	tmp_desc_hi = _mm_and_si128(tmp_desc_hi, desc_flags_rss_mask);
+	tmp_flags = _mm_shuffle_epi8(vlan_flags, tmp_desc_lo);
+	flags = _mm_and_si128(tmp_flags, vlan_mask);
+	tmp_desc_lo = _mm_srli_epi32(tmp_desc_lo, 10);
+	tmp_flags = _mm_shuffle_epi8(cksum_flags, tmp_desc_lo);
+	tmp_flags = _mm_slli_epi32(tmp_flags, 1);
+	tmp_flags = _mm_and_si128(tmp_flags, cksum_mask);
+	flags = _mm_or_si128(flags, tmp_flags);
+	tmp_desc_hi = _mm_srli_epi32(tmp_desc_hi, 27);
+	tmp_flags = _mm_shuffle_epi8(rss_flags, tmp_desc_hi);
+	flags = _mm_or_si128(flags, tmp_flags);
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+	if (rxq->fnav_enable) {
+		__m128i tmp_fnav_flags = sxe2_rx_desc_fnav_flags_sse(descs_arr);
+		flags = _mm_or_si128(flags, tmp_fnav_flags);
+		rx_pkts[0]->hash.fdir.hi = desc[0].wb.fd_filter_id;
+		rx_pkts[1]->hash.fdir.hi = desc[1].wb.fd_filter_id;
+		rx_pkts[2]->hash.fdir.hi = desc[2].wb.fd_filter_id;
+		rx_pkts[3]->hash.fdir.hi = desc[3].wb.fd_filter_id;
+	}
+#endif
+	rearm_arr[0] = _mm_blend_epi16(mbuf_init, _mm_slli_si128(flags, 8), 0x30);
+	rearm_arr[1] = _mm_blend_epi16(mbuf_init, _mm_slli_si128(flags, 4), 0x30);
+	rearm_arr[2] = _mm_blend_epi16(mbuf_init, flags, 0x30);
+	rearm_arr[3] = _mm_blend_epi16(mbuf_init, _mm_srli_si128(flags, 4), 0x30);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
+			 offsetof(struct rte_mbuf, rearm_data) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
+			 RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, &rx_pkts[0]->rearm_data), rearm_arr[0]);
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, &rx_pkts[1]->rearm_data), rearm_arr[1]);
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, &rx_pkts[2]->rearm_data), rearm_arr[2]);
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, &rx_pkts[3]->rearm_data), rearm_arr[3]);
+}
+
+static inline u16
+sxe2_rx_pkts_common_vec_sse(struct sxe2_rx_queue *rxq,
+		struct rte_mbuf **rx_pkts, u16 nb_pkts, u8 *split_rxe_flags,
+		u8 *umbcast_flags)
+{
+	volatile union sxe2_rx_desc *desc;
+	struct rte_mbuf **buffer;
+	__m128i descs_arr[SXE2_RX_NUM_PER_LOOP_SSE];
+	__m128i mbuf_arr[SXE2_RX_NUM_PER_LOOP_SSE];
+	__m128i staterr, sterr_tmp1, sterr_tmp2;
+	__m128i pmbuf0;
+	__m128i ptype_all;
+#ifdef RTE_ARCH_X86_64
+	__m128i pmbuf1;
+#endif
+	u32 i;
+	u32 bit_num;
+	u16 done_num = 0;
+	const u32 *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const __m128i crc_adjust =
+			_mm_set_epi16(0, 0, 0,
+				      -rxq->crc_len,
+				      0, -rxq->crc_len,
+				      0, 0);
+	const __m128i rvp_shuf_mask =
+			_mm_set_epi8(7, 6, 5, 4,
+				     3, 2,
+				     13, 12,
+				     0XFF, 0xFF, 13, 12,
+				     0xFF, 0xFF, 0xFF, 0xFF);
+	const __m128i dd_mask = _mm_set_epi64x(0x0000000100000001LL,
+					0x0000000100000001LL);
+	const __m128i eop_mask = _mm_slli_epi32(dd_mask,
+					SXE2_RX_DESC_STATUS_EOP_SHIFT);
+	const __m128i rxe_mask = _mm_set_epi64x(0x0000208000002080LL,
+					0x0000208000002080LL);
+	const __m128i eop_shuf_mask = _mm_set_epi8(0xFF, 0xFF,
+						   0xFF, 0xFF,
+						   0xFF, 0xFF,
+						   0xFF, 0xFF,
+						   0xFF, 0xFF,
+						   0xFF, 0xFF,
+						   0x04, 0x0C,
+						   0x00, 0x08);
+	const __m128i ptype_mask = _mm_set_epi16(SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT, 0,
+						 SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT, 0,
+						 SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT, 0,
+						 SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT, 0);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
+	desc = &rxq->desc_ring[rxq->processing_idx];
+	rte_prefetch0(desc);
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, SXE2_RX_NUM_PER_LOOP_SSE);
+	if (rxq->realloc_num > SXE2_RX_REARM_THRESH_VEC)
+		sxe2_rx_queue_rearm_sse(rxq);
+	if ((rte_le_to_cpu_64(desc->wb.status_err_ptype_len) &
+		     SXE2_RX_DESC_STATUS_DD_MASK) == 0)
+		goto l_end;
+	buffer = &rxq->buffer_ring[rxq->processing_idx];
+	for (i = 0; i < nb_pkts; i += SXE2_RX_NUM_PER_LOOP_SSE,
+				desc += SXE2_RX_NUM_PER_LOOP_SSE) {
+		pmbuf0 = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, &buffer[i]));
+		descs_arr[3] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, desc + 3));
+		rte_compiler_barrier();
+		_mm_storeu_si128((__m128i *)&rx_pkts[i], pmbuf0);
+#ifdef RTE_ARCH_X86_64
+		pmbuf1 = _mm_loadu_si128((__m128i *)&buffer[i + 2]);
+#endif
+		descs_arr[2] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, desc + 2));
+		rte_compiler_barrier();
+		descs_arr[1] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, desc + 1));
+		rte_compiler_barrier();
+		descs_arr[0] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, desc));
+#ifdef RTE_ARCH_X86_64
+		_mm_storeu_si128((__m128i *)&rx_pkts[i + 2], pmbuf1);
+#endif
+		if (split_rxe_flags) {
+			rte_mbuf_prefetch_part2(rx_pkts[i]);
+			rte_mbuf_prefetch_part2(rx_pkts[i + 1]);
+			rte_mbuf_prefetch_part2(rx_pkts[i + 2]);
+			rte_mbuf_prefetch_part2(rx_pkts[i + 3]);
+		}
+		rte_compiler_barrier();
+		mbuf_arr[3] = _mm_shuffle_epi8(descs_arr[3], rvp_shuf_mask);
+		mbuf_arr[2] = _mm_shuffle_epi8(descs_arr[2], rvp_shuf_mask);
+		mbuf_arr[1] = _mm_shuffle_epi8(descs_arr[1], rvp_shuf_mask);
+		mbuf_arr[0] = _mm_shuffle_epi8(descs_arr[0], rvp_shuf_mask);
+		sterr_tmp2 = _mm_unpackhi_epi32(descs_arr[3], descs_arr[2]);
+		sterr_tmp1 = _mm_unpackhi_epi32(descs_arr[1], descs_arr[0]);
+		sxe2_rx_desc_offloads_para_fill_sse(rxq, desc, descs_arr, rx_pkts);
+		mbuf_arr[3] = _mm_add_epi16(mbuf_arr[3], crc_adjust);
+		mbuf_arr[2] = _mm_add_epi16(mbuf_arr[2], crc_adjust);
+		mbuf_arr[1] = _mm_add_epi16(mbuf_arr[1], crc_adjust);
+		mbuf_arr[0] = _mm_add_epi16(mbuf_arr[0], crc_adjust);
+		staterr = _mm_unpacklo_epi32(sterr_tmp1, sterr_tmp2);
+		ptype_all = _mm_and_si128(staterr, ptype_mask);
+		_mm_storeu_si128((void *)&rx_pkts[i + 3]->rx_descriptor_fields1,
+					mbuf_arr[3]);
+		_mm_storeu_si128((void *)&rx_pkts[i + 2]->rx_descriptor_fields1,
+					mbuf_arr[2]);
+		if (umbcast_flags != NULL) {
+			const __m128i umbcast_mask =
+				_mm_set_epi32(SXE2_RX_DESC_STATUS_UMBCAST_MASK,
+					      SXE2_RX_DESC_STATUS_UMBCAST_MASK,
+					      SXE2_RX_DESC_STATUS_UMBCAST_MASK,
+					      SXE2_RX_DESC_STATUS_UMBCAST_MASK);
+			const __m128i umbcast_shuf_mask =
+				_mm_set_epi8(0xFF, 0xFF,
+					     0xFF, 0xFF,
+					     0xFF, 0xFF,
+					     0xFF, 0xFF,
+					     0xFF, 0xFF,
+					     0xFF, 0xFF,
+					     0x07, 0x0F,
+					     0x03, 0x0B);
+			__m128i umbcast_bits = _mm_and_si128(staterr, umbcast_mask);
+			umbcast_bits = _mm_shuffle_epi8(umbcast_bits, umbcast_shuf_mask);
+			*(s32 *)umbcast_flags = _mm_cvtsi128_si32(umbcast_bits);
+			umbcast_flags += SXE2_RX_NUM_PER_LOOP_SSE;
+		}
+		if (split_rxe_flags != NULL) {
+			__m128i eop_bits = _mm_andnot_si128(staterr, eop_mask);
+			__m128i rxe_bits = _mm_and_si128(staterr, rxe_mask);
+			rxe_bits = _mm_srli_epi32(rxe_bits, 7);
+			eop_bits = _mm_or_si128(eop_bits, rxe_bits);
+			eop_bits = _mm_shuffle_epi8(eop_bits, eop_shuf_mask);
+			*(s32 *)split_rxe_flags = _mm_cvtsi128_si32(eop_bits);
+			split_rxe_flags += SXE2_RX_NUM_PER_LOOP_SSE;
+		}
+		staterr = _mm_and_si128(staterr, dd_mask);
+		staterr = _mm_packs_epi32(staterr, _mm_setzero_si128());
+		_mm_storeu_si128((void *)&rx_pkts[i + 1]->rx_descriptor_fields1,
+					mbuf_arr[1]);
+		_mm_storeu_si128((void *)&rx_pkts[i]->rx_descriptor_fields1,
+					mbuf_arr[0]);
+		rx_pkts[i + 3]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 3)];
+		rx_pkts[i + 2]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 7)];
+		rx_pkts[i + 1]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 1)];
+		rx_pkts[i]->packet_type     = ptype_tbl[_mm_extract_epi16(ptype_all, 5)];
+		bit_num = rte_popcount64(_mm_cvtsi128_si64(staterr));
+		done_num += bit_num;
+		if (likely(bit_num != SXE2_RX_NUM_PER_LOOP_SSE))
+			break;
+	}
+	rxq->processing_idx += done_num;
+	rxq->processing_idx &= (rxq->ring_depth - 1);
+	rxq->realloc_num    += done_num;
+	PMD_LOG_RX_DEBUG("port_id=%u queue_id=%u last_id=%u recv_pkts=%d",
+			rxq->port_id, rxq->queue_id, rxq->processing_idx, done_num);
+l_end:
+	return done_num;
+}
+static __rte_always_inline u16
+sxe2_rx_pkts_scattered_batch_vec_sse(struct sxe2_rx_queue *rxq,
+		struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	const u64 *split_rxe_flags64;
+	u8 split_rxe_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	u8 umbcast_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	u16 rx_done_num;
+	u16 rx_pkt_done_num;
+	rx_pkt_done_num = 0;
+	if (rxq->vsi->adapter->devargs.sw_stats_en) {
+		rx_done_num = sxe2_rx_pkts_common_vec_sse(rxq, rx_pkts,
+				nb_pkts, split_rxe_flags, umbcast_flags);
+	} else {
+		rx_done_num = sxe2_rx_pkts_common_vec_sse(rxq, rx_pkts,
+				nb_pkts, split_rxe_flags, NULL);
+	}
+	if (rx_done_num == 0)
+		goto l_end;
+	if (!rxq->vsi->adapter->devargs.sw_stats_en) {
+		split_rxe_flags64 = (u64 *)split_rxe_flags;
+		if (rxq->pkt_first_seg == NULL &&
+			split_rxe_flags64[0] == 0 &&
+			split_rxe_flags64[1] == 0 &&
+			split_rxe_flags64[2] == 0 &&
+			split_rxe_flags64[3] == 0) {
+			rx_pkt_done_num = rx_done_num;
+			goto l_end;
+		}
+		if (rxq->pkt_first_seg == NULL) {
+			while (rx_pkt_done_num < rx_done_num &&
+			       split_rxe_flags[rx_pkt_done_num] == 0)
+				rx_pkt_done_num++;
+			if (rx_pkt_done_num == rx_done_num)
+				goto l_end;
+			rxq->pkt_first_seg = rx_pkts[rx_pkt_done_num];
+		}
+	}
+	rx_pkt_done_num += sxe2_rx_pkts_refactor(rxq, &rx_pkts[rx_pkt_done_num],
+			rx_done_num - rx_pkt_done_num, &split_rxe_flags[rx_pkt_done_num],
+			&umbcast_flags[rx_pkt_done_num]);
+l_end:
+	return rx_pkt_done_num;
+}
+
+u16 sxe2_rx_pkts_scattered_vec_sse_offload(void *rx_queue,
+		struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	u16 done_num = 0;
+	u16 once_num;
+	while (nb_pkts > SXE2_RX_PKTS_BURST_BATCH_NUM_VEC) {
+		once_num =
+			sxe2_rx_pkts_scattered_batch_vec_sse((struct sxe2_rx_queue *)rx_queue,
+							     rx_pkts + done_num,
+							     SXE2_RX_PKTS_BURST_BATCH_NUM_VEC);
+		done_num += once_num;
+		nb_pkts  -= once_num;
+		if (once_num < SXE2_RX_PKTS_BURST_BATCH_NUM_VEC)
+			goto l_end;
+	}
+	done_num +=
+		sxe2_rx_pkts_scattered_batch_vec_sse((struct sxe2_rx_queue *)rx_queue,
+						     rx_pkts + done_num, nb_pkts);
+l_end:
+	SXE2_RX_STATS_CNT(rx_queue, rx_pkts_num, done_num);
+	return done_num;
+}
-- 
2.47.3

