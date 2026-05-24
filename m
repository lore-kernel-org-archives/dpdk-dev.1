Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B321CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84B8440693;
	Sun, 24 May 2026 11:33:19 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 9A6EB4042F
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:09 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S12;
 Sun, 24 May 2026 17:33:07 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 10/23] net/sxe2: add NEON vec Rx/Tx burst functions
Date: Sun, 24 May 2026 17:32:46 +0800
Message-ID: <20260524093259.397506-11-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S12
X-Coremail-Antispam: 1UD129KBjvAXoWfuF43XF1fGFWDArWDCw18uFg_yoW5Cr4rXo
 Wxur4fJr47Jr18Zws8ur1xZFyUtw4UZ34UCayF9F9xu3WkCFn0ka43t3WayFy7Gr4ftFs0
 ga4Iyas3trZ3XrWxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
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

- Implement sxe2_recv_pkts_vec_neon for bulk packet receiving.
- Implement sxe2_xmit_pkts_vec_neon for bulk packet transmission.
- Added logic to select the vectorized path based on runtime config
  and CPU flags (RTE_ARCH_ARM64).

Vectorized path improves throughput for small packets by processing
multiple descriptors simultaneously using SIMD instructions.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build            |   2 +
 drivers/net/sxe2/sxe2_txrx.c            |  36 ++
 drivers/net/sxe2/sxe2_txrx_vec.h        |  16 +-
 drivers/net/sxe2/sxe2_txrx_vec_common.h |   1 -
 drivers/net/sxe2/sxe2_txrx_vec_neon.c   | 707 ++++++++++++++++++++++++
 5 files changed, 759 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index c73e13bbad..0658b2ee3a 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -48,6 +48,8 @@ if arch_subdir == 'x86'
                 include_directories: includes,
                 c_args: [cflags, '-mavx2'])
         objs += sxe2_avx2_lib.extract_objects('sxe2_txrx_vec_avx2.c')
+elif arch_subdir == 'arm'
+        sources += files('sxe2_txrx_vec_neon.c')
 endif
 
 sources += files(
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index dcfaf7278d..2eb8365457 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -176,6 +176,10 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 
 			if ((0 == (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)))
 				tx_mode_flags |=  SXE2_TX_MODE_VEC_SSE;
+#elif defined(RTE_ARCH_ARM64)
+			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_NEON) == 1) {
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_NEON);
+			}
 #endif
 			if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
 				ret = sxe2_tx_queues_vec_prepare(dev);
@@ -228,6 +232,13 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 				dev->tx_pkt_burst = sxe2_tx_pkts_vec_sse_simple;
 			}
 		}
+#elif defined(RTE_ARCH_ARM64)
+		if (adapter->tx_mode_flags & SXE2_TX_MODE_VEC_NEON) {
+			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
+		} else {
+			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+		}
 	} else {
 #endif
 		if (tx_mode_flags & SXE2_TX_MODE_SIMPLE_BATCH) {
@@ -263,6 +274,12 @@ static const struct {
 	{ sxe2_tx_pkts_vec_sse_simple,
 	      "Vector SSE Simple" },
 #endif
+#ifdef RTE_ARCH_ARM64
+	{ sxe2_tx_pkts_vec_neon,
+	  "Vector NEON" },
+	{ sxe2_tx_pkts_vec_neon_simple,
+	  "Vector NEON Simple" },
+#endif
 };
 
 int32_t sxe2_tx_burst_mode_get(struct rte_eth_dev *dev,
@@ -366,6 +383,11 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 			if (((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) == 0) &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)
 				rx_mode_flags |= SXE2_RX_MODE_VEC_SSE;
+
+#elif defined(RTE_ARCH_ARM64)
+			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_NEON) == 1) {
+				rx_mode_flags |= (vec_flags | SXE2_RX_MODE_VEC_NEON);
+			}
 #endif
 			if ((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) != 0) {
 				ret = sxe2_rx_queues_vec_prepare(dev);
@@ -397,6 +419,14 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 		}
 		return;
 	}
+#elif defined(RTE_ARCH_ARM64)
+	if (rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) {
+		if (rx_mode_flags & SXE2_RX_MODE_VEC_OFFLOAD)
+			dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_neon_offload;
+		else
+			dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_neon;
+		goto l_end;
+	}
 #endif
 	if (sxe2_rx_offload_en_check(dev, RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_split;
@@ -426,6 +456,12 @@ static const struct {
 	{ sxe2_rx_pkts_scattered_vec_sse_offload,
 	      "Vector SSE Scattered" },
 #endif
+#ifdef RTE_ARCH_ARM64
+	{ sxe2_rx_pkts_scattered_vec_neon,
+	  "Vector NEON Scattered" },
+	{ sxe2_rx_pkts_scattered_vec_neon_offload,
+	  "Offload Vector NEON Scattered" },
+#endif
 };
 
 int32_t sxe2_rx_burst_mode_get(struct rte_eth_dev *dev,
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.h b/drivers/net/sxe2/sxe2_txrx_vec.h
index d7a0ce6ca5..02b1743e3e 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec.h
@@ -12,19 +12,23 @@
 #define SXE2_RX_MODE_VEC_SSE       RTE_BIT32(2)
 #define SXE2_RX_MODE_VEC_AVX2      RTE_BIT32(3)
 #define SXE2_RX_MODE_VEC_AVX512    RTE_BIT32(4)
+#define SXE2_RX_MODE_VEC_NEON      RTE_BIT32(5)
 #define SXE2_RX_MODE_BATCH_ALLOC   RTE_BIT32(10)
 #define SXE2_RX_MODE_VEC_SET_MASK	(SXE2_RX_MODE_VEC_SIMPLE | \
 			SXE2_RX_MODE_VEC_OFFLOAD | SXE2_RX_MODE_VEC_SSE | \
-			SXE2_RX_MODE_VEC_AVX2 | SXE2_RX_MODE_VEC_AVX512)
+			SXE2_RX_MODE_VEC_AVX2 | SXE2_RX_MODE_VEC_AVX512 | \
+			SXE2_RX_MODE_VEC_NEON)
 #define SXE2_TX_MODE_VEC_SIMPLE   RTE_BIT32(0)
 #define SXE2_TX_MODE_VEC_OFFLOAD  RTE_BIT32(1)
 #define SXE2_TX_MODE_VEC_SSE      RTE_BIT32(2)
 #define SXE2_TX_MODE_VEC_AVX2     RTE_BIT32(3)
 #define SXE2_TX_MODE_VEC_AVX512   RTE_BIT32(4)
+#define SXE2_TX_MODE_VEC_NEON     RTE_BIT32(5)
 #define SXE2_TX_MODE_SIMPLE_BATCH RTE_BIT32(10)
 #define SXE2_TX_MODE_VEC_SET_MASK	(SXE2_TX_MODE_VEC_SIMPLE | \
 			SXE2_TX_MODE_VEC_OFFLOAD | SXE2_TX_MODE_VEC_SSE | \
-			SXE2_TX_MODE_VEC_AVX2 | SXE2_TX_MODE_VEC_AVX512)
+			SXE2_TX_MODE_VEC_AVX2 | SXE2_TX_MODE_VEC_AVX512 | \
+			SXE2_TX_MODE_VEC_NEON)
 #define SXE2_TX_VEC_NO_SUPPORT_OFFLOAD (		  \
 			RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		  \
 			RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	  \
@@ -75,6 +79,14 @@ uint16_t sxe2_rx_pkts_scattered_vec_avx2(void *rx_queue,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 uint16_t sxe2_rx_pkts_scattered_vec_avx2_offload(void *rx_queue,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+
+#elif defined(RTE_ARCH_ARM64)
+uint16_t sxe2_rx_pkts_scattered_vec_neon(void *rx_queue, struct rte_mbuf **rx_pkts,
+					 uint16_t nb_pkts);
+uint16_t sxe2_rx_pkts_scattered_vec_neon_offload(void *rx_queue, struct rte_mbuf **rx_pkts,
+						 uint16_t nb_pkts);
+uint16_t sxe2_tx_pkts_vec_neon_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t sxe2_tx_pkts_vec_neon(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 #endif
 int32_t __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags);
 int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_common.h b/drivers/net/sxe2/sxe2_txrx_vec_common.h
index 138b748f4a..8fce2bb7cc 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_common.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec_common.h
@@ -4,7 +4,6 @@
 
 #ifndef __SXE2_TXRX_VEC_COMMON_H__
 #define __SXE2_TXRX_VEC_COMMON_H__
-#include <rte_atomic.h>
 #ifdef PCLINT
 #include "avx_stub.h"
 #endif
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_neon.c b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
new file mode 100644
index 0000000000..e50a0b21bf
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
@@ -0,0 +1,707 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifdef RTE_ARCH_ARM64
+#include <arm_neon.h>
+#include <rte_vect.h>
+
+#include "sxe2_txrx_vec_common.h"
+#include "sxe2_txrx_vec.h"
+#include "sxe2_common_log.h"
+
+#define PKTLEN_SHIFT     10
+#define SXE2_UINT16_BIT (CHAR_BIT * sizeof(uint16_t))
+
+static __rte_always_inline void
+sxe2_tx_desc_fill_one_neon(volatile union sxe2_tx_data_desc *desc,
+			struct rte_mbuf *pkt, uint64_t desc_cmd, bool with_offloads)
+{
+	uint64_t desc_qw1;
+	uint32_t desc_offset;
+
+	desc_qw1 = (SXE2_TX_DESC_DTYPE_DATA |
+				((uint64_t)desc_cmd) << SXE2_TX_DATA_DESC_CMD_SHIFT |
+				((uint64_t)pkt->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT);
+
+	desc_offset = SXE2_TX_DATA_DESC_MACLEN_VAL(pkt->l2_len);
+	desc_qw1 |= ((uint64_t)desc_offset) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+	if (with_offloads)
+		sxe2_tx_desc_fill_offloads(pkt, &desc_qw1);
+
+	uint64x2_t data_desc = { rte_pktmbuf_iova(pkt), desc_qw1 };
+
+	vst1q_u64((uint64_t *)desc, data_desc);
+}
+
+static __rte_always_inline uint16_t
+sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
+			uint16_t nb_pkts, bool with_offloads)
+{
+	volatile union sxe2_tx_data_desc *desc;
+	struct sxe2_tx_buffer *buffer;
+	uint16_t next_use;
+	uint16_t res_num;
+	uint16_t tx_num;
+	uint16_t i;
+
+	if (txq->desc_free_num < txq->free_thresh)
+		(void)sxe2_tx_bufs_free_vec(txq);
+
+	nb_pkts = RTE_MIN(txq->desc_free_num, nb_pkts);
+	if (unlikely(nb_pkts == 0)) {
+		PMD_LOG_TX_DEBUG("Tx pkts neon batch: may not enough free desc, "
+				"free_desc=%u, need_tx_pkts=%u",
+				txq->desc_free_num, nb_pkts);
+		goto l_end;
+	}
+	tx_num = nb_pkts;
+
+	next_use = txq->next_use;
+	desc     = &txq->desc_ring[next_use];
+	buffer   = &txq->buffer_ring[next_use];
+
+	txq->desc_free_num -= nb_pkts;
+
+	res_num = txq->ring_depth - txq->next_use;
+
+	if (tx_num >= res_num) {
+		sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, res_num);
+
+		for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
+			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+					SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+		}
+
+		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts++,
+					(SXE2_TX_DATA_DESC_CMD_EOP | SXE2_TX_DATA_DESC_CMD_RS),
+					with_offloads);
+
+		tx_num -= res_num;
+
+		next_use     = 0;
+		txq->next_rs = txq->rs_thresh - 1;
+		desc         = &txq->desc_ring[next_use];
+		buffer       = &txq->buffer_ring[next_use];
+	}
+
+	sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, tx_num);
+
+	for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
+		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+				SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+	}
+
+	next_use += tx_num;
+	if (next_use > txq->next_rs) {
+		txq->desc_ring[txq->next_rs].read.type_cmd_off_bsz_l2t |=
+			rte_cpu_to_le_64(SXE2_TX_DATA_DESC_CMD_RS_MASK);
+
+		txq->next_rs += txq->rs_thresh;
+	}
+	txq->next_use = next_use;
+
+	SXE2_PCI_REG_WRITE_WC(txq->tdt_reg_addr, txq->next_use);
+
+l_end:
+	return nb_pkts;
+}
+
+static __rte_always_inline uint16_t
+sxe2_tx_pkts_vec_neon_common(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
+			uint16_t nb_pkts, bool with_offloads)
+{
+	uint16_t tx_done_num = 0;
+	uint16_t tx_once_num;
+	uint16_t tx_need_num;
+
+	while (nb_pkts) {
+		tx_need_num = RTE_MIN(nb_pkts, txq->rs_thresh);
+		tx_once_num = sxe2_tx_pkts_vec_neon_batch(txq,
+					tx_pkts + tx_done_num,
+					tx_need_num, with_offloads);
+
+		nb_pkts     -= tx_once_num;
+		tx_done_num += tx_once_num;
+
+		if (tx_once_num < tx_need_num)
+			break;
+	}
+
+	PMD_LOG_TX_DEBUG("Tx pkts neon: port_id=%u, queue_id=%u, "
+			"nb_pkts=%u, tx_done_num=%u with_offloads=%u",
+			txq->port_id, txq->idx_in_pf, nb_pkts, tx_done_num, with_offloads);
+
+	SXE2_TX_STATS_CNT(txq, tx_pkts_num, tx_done_num);
+	return tx_done_num;
+}
+
+uint16_t sxe2_tx_pkts_vec_neon_simple(void *tx_queue,
+			struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return sxe2_tx_pkts_vec_neon_common((struct sxe2_tx_queue *)tx_queue,
+				tx_pkts, nb_pkts, false);
+}
+
+uint16_t sxe2_tx_pkts_vec_neon(void *tx_queue,
+			struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return sxe2_tx_pkts_vec_neon_common((struct sxe2_tx_queue *)tx_queue,
+				tx_pkts, nb_pkts, true);
+}
+
+static __rte_always_inline void
+sxe2_rx_desc_ptype_fill_neon(uint16x8_t staterr, struct rte_mbuf **__rte_restrict rx_pkts,
+		const uint32_t *__rte_restrict ptype_tbl)
+{
+	uint16x8_t ptype_mask = {
+		0, 0x3FFULL,
+		0, 0x3FFULL,
+		0, 0x3FFULL,
+		0, 0x3FFULL,
+	};
+	uint16x8_t ptype_all;
+
+	ptype_all = vandq_u16(staterr, ptype_mask);
+
+	rx_pkts[3]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 3)];
+	rx_pkts[2]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 7)];
+	rx_pkts[1]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 1)];
+	rx_pkts[0]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 5)];
+}
+
+static __rte_always_inline uint32x4_t
+sxe2_rx_desc_fnav_flags_neon(uint64x2_t descs_arr[4])
+{
+	uint32x4_t descs_tmp1, descs_tmp2;
+	uint32x4_t descs_fnav_vld;
+	uint32x4_t v_zeros, v_ffff, v_u32_one;
+	uint32x4_t m_flags;
+
+	const uint32x4_t fdir_flags = vdupq_n_u32(RTE_MBUF_F_RX_FDIR |
+						RTE_MBUF_F_RX_FDIR_ID);
+
+	{
+		uint32x4_t d0 = vreinterpretq_u32_u64(descs_arr[0]);
+		uint32x4_t d1 = vreinterpretq_u32_u64(descs_arr[1]);
+		uint32x4_t d2 = vreinterpretq_u32_u64(descs_arr[2]);
+		uint32x4_t d3 = vreinterpretq_u32_u64(descs_arr[3]);
+
+		descs_tmp1 = vzip1q_u32(d1, d
+
+static __rte_always_inline void
+sxe2_rx_desc_offloads_para_fill_neon(struct sxe2_rx_queue *rxq,
+			volatile union sxe2_rx_desc *desc,
+			uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
+{
+	uint32x4_t desc_lo, desc_hi, flags, tmp_flags;
+	const uint64x2_t mbuf_init = {rxq->mbuf_init_value, 0};
+	uint64x2_t rearm0, rearm1, rearm2, rearm3;
+
+	const uint32x4_t desc_msk = {
+		0x00001C04, 0x00001C04, 0x00001C04, 0x00001C04};
+
+	const uint32x4_t rss_msk = {
+		0x20000000, 0x20000000, 0x20000000, 0x20000000};
+
+	const uint32x4_t vlan_msk = {
+		RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+		RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+		RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+		RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED
+	};
+	const uint8x16_t vlan_flags = {
+		0, 0, 0, 0,
+		RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0
+	};
+
+	const uint8x16_t rss_flags = {
+		0, 0, 0, 0,
+		RTE_MBUF_F_RX_RSS_HASH, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0
+	};
+
+	const uint32x4_t cksum_mask = {
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+	};
+
+	const uint8x16_t cksum_flags = {
+		((RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+		((RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+		((RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+		((RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+		((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+			RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+		((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+			RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+		((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+			RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+		((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+			RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+		0, 0, 0, 0, 0, 0, 0, 0
+	};
+
+	{
+		uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
+		uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
+		uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
+		uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
+		uint64x2_t f64, t64;
+
+		flags = vzip2q_u32(d1, d0);
+		tmp_flags = vzip2q_u32(d3, d2);
+		f64 = vreinterpretq_u64_u32(flags);
+		t64 = vreinterpretq_u64_u32(tmp_flags);
+		desc_lo = vreinterpretq_u32_u64(vcombine_u64(vget_low_u64(f64),
+							     vget_low_u64(t64)));
+		desc_hi = vreinterpretq_u32_u64(vcombine_u64(vget_high_u64(f64),
+							     vget_high_u64(t64)));
+	}
+
+	desc_lo = vandq_u32(desc_lo, desc_msk);
+	desc_hi = vandq_u32(desc_hi, rss_msk);
+
+	tmp_flags = vreinterpretq_u32_u8(vqtbl1q_u8(vlan_flags,
+						vreinterpretq_u8_u32(desc_lo)));
+	flags = vandq_u32(tmp_flags, vlan_msk);
+
+	desc_lo = vshrq_n_u32(desc_lo, 10);
+	tmp_flags = vreinterpretq_u32_u8(vqtbl1q_u8(cksum_flags,
+					 vreinterpretq_u8_u32(desc_lo)));
+	tmp_flags = vshlq_n_u32(tmp_flags, 1);
+	tmp_flags = vandq_u32(tmp_flags, cksum_mask);
+	flags = vorrq_u32(flags, tmp_flags);
+
+	desc_hi = vshrq_n_u32(desc_hi, 27);
+	tmp_flags = vreinterpretq_u32_u8(vqtbl1q_u8(rss_flags,
+					 vreinterpretq_u8_u32(desc_hi)));
+	flags = vorrq_u32(flags, tmp_flags);
+
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+	if (rxq->fnav_enable) {
+		uint32x4_t tmp_fnav_flags = sxe2_rx_desc_fnav_flags_neon(descs);
+		flags = vorrq_u32(flags, tmp_fnav_flags);
+
+		rx_pkts[0]->hash.fdir.hi = desc[0].wb.fd_filter_id;
+		rx_pkts[1]->hash.fdir.hi = desc[1].wb.fd_filter_id;
+		rx_pkts[2]->hash.fdir.hi = desc[2].wb.fd_filter_id;
+		rx_pkts[3]->hash.fdir.hi = desc[3].wb.fd_filter_id;
+	}
+#endif
+
+	rearm0 = vsetq_lane_u64(vgetq_lane_u32(flags, 0), mbuf_init, 1);
+	rearm1 = vsetq_lane_u64(vgetq_lane_u32(flags, 1), mbuf_init, 1);
+	rearm2 = vsetq_lane_u64(vgetq_lane_u32(flags, 2), mbuf_init, 1);
+	rearm3 = vsetq_lane_u64(vgetq_lane_u32(flags, 3), mbuf_init, 1);
+
+	vst1q_u64((uint64_t *)&rx_pkts[0]->rearm_data, rearm0);
+	vst1q_u64((uint64_t *)&rx_pkts[1]->rearm_data, rearm1);
+	vst1q_u64((uint64_t *)&rx_pkts[2]->rearm_data, rearm2);
+	vst1q_u64((uint64_t *)&rx_pkts[3]->rearm_data, rearm3);
+}
+
+static inline void sxe2_rx_queue_rearm_neon(struct sxe2_rx_queue *rxq)
+{
+	volatile union sxe2_rx_desc *desc;
+	struct rte_mbuf **buffer;
+	struct rte_mbuf *mbuf0, *mbuf1;
+	uint64x2_t dma_addr0, dma_addr1;
+	uint64x2_t zero = vdupq_n_u64(0);
+	uint64x2_t virt_addr0, virt_addr1;
+	uint64x2_t hdr_room = vdupq_n_u64(RTE_PKTMBUF_HEADROOM);
+	int32_t ret;
+	uint16_t i;
+	uint16_t new_tail;
+
+	buffer = &rxq->buffer_ring[rxq->realloc_start];
+	desc = &rxq->desc_ring[rxq->realloc_start];
+
+	ret = rte_mempool_get_bulk(rxq->mb_pool, (void *)buffer,
+			SXE2_RX_REARM_THRESH_VEC);
+	if (ret != 0) {
+		PMD_LOG_RX_INFO("Rx mbuf vec alloc failed port_id=%u "
+				"queue_id=%u", rxq->port_id,
+				rxq->idx_in_pf);
+
+		if ((rxq->realloc_num + SXE2_RX_REARM_THRESH_VEC) >= rxq->ring_depth) {
+			for (i = 0; i < SXE2_RX_NUM_PER_LOOP_NEON; ++i) {
+				buffer[i] = &rxq->fake_mbuf;
+				vst1q_u64((uint64_t *)&desc[i].read, zero);
+			}
+		}
+
+		rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed +=
+				SXE2_RX_REARM_THRESH_VEC;
+		goto l_end;
+	}
+
+	for (i = 0; i < SXE2_RX_REARM_THRESH_VEC; i += 2, buffer += 2) {
+		mbuf0 = buffer[0];
+		mbuf1 = buffer[1];
+#if RTE_IOVA_IN_MBUF
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				 offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		virt_addr0 = vld1q_u64((uint64_t *)&mbuf0->buf_addr);
+		virt_addr1 = vld1q_u64((uint64_t *)&mbuf1->buf_addr);
+
+#if RTE_IOVA_IN_MBUF
+		dma_addr0 = vdupq_n_u64((uint64_t)vget_high_u64(virt_addr0));
+		dma_addr1 = vdupq_n_u64((uint64_t)vget_high_u64(virt_addr1));
+#else
+		dma_addr0 = vdupq_n_u64((uint64_t)vget_low_u64(virt_addr0));
+		dma_addr1 = vdupq_n_u64((uint64_t)vget_low_u64(virt_addr1));
+#endif
+		dma_addr0 = vaddq_u64(dma_addr0, hdr_room);
+		dma_addr1 = vaddq_u64(dma_addr1, hdr_room);
+
+		vst1q_u64((uint64_t *)&desc++->read, dma_addr0);
+		vst1q_u64((uint64_t *)&desc++->read, dma_addr1);
+	}
+
+	rxq->realloc_start += SXE2_RX_REARM_THRESH_VEC;
+	if (rxq->realloc_start >= rxq->ring_depth)
+		rxq->realloc_start = 0;
+	rxq->realloc_num -= SXE2_RX_REARM_THRESH_VEC;
+
+	new_tail = (rxq->realloc_start == 0) ?
+		(rxq->ring_depth - 1) : (rxq->realloc_start - 1);
+
+	SXE2_PCI_REG_WRITE_WC(rxq->rdt_reg_addr, new_tail);
+
+l_end:
+	return;
+}
+
+static __rte_always_inline uint16_t
+sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts, uint8_t *split_rxe_flags, uint8_t *umbcast_flags,
+		bool do_offload)
+{
+	volatile union sxe2_rx_desc *desc;
+	struct rte_mbuf **buffer;
+	uint32_t i;
+	uint16_t done_num = 0;
+	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+
+	uint8x16_t rvp_shuf_mask = {
+		0xFF, 0xFF, 0xFF, 0xFF,
+		12, 13, 0xFF, 0xFF,
+		12, 13,
+		2, 3,
+		4, 5, 6, 7
+	};
+
+	uint16x8_t crc_adjust = {
+		0, 0,
+		rxq->crc_len,
+		0, rxq->crc_len,
+		0, 0, 0
+	};
+
+	desc = &rxq->desc_ring[rxq->processing_idx];
+	rte_prefetch0(desc);
+
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, SXE2_RX_NUM_PER_LOOP_NEON);
+
+	if (rxq->realloc_num > SXE2_RX_REARM_THRESH_VEC)
+		sxe2_rx_queue_rearm_neon(rxq);
+
+	if ((rte_le_to_cpu_64(desc->wb.status_err_ptype_len) &
+			SXE2_RX_DESC_STATUS_DD_MASK) == 0) {
+		goto l_end;
+	}
+
+	buffer = &rxq->buffer_ring[rxq->processing_idx];
+	for (i = 0; i < nb_pkts; i += SXE2_RX_NUM_PER_LOOP_NEON,
+				desc += SXE2_RX_NUM_PER_LOOP_NEON) {
+		uint64x2_t descs[SXE2_RX_NUM_PER_LOOP_NEON];
+		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
+		uint64x2_t mbp1, mbp2;
+		uint16x8_t staterr;
+		uint16x8_t tmp;
+		uint16_t bit_num;
+
+		descs[3] = vld1q_u64((uint64_t *)(desc + 3));
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		descs[2] = vld1q_u64((uint64_t *)(desc + 2));
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		descs[1] = vld1q_u64((uint64_t *)(desc + 1));
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		descs[0] = vld1q_u64((uint64_t *)(desc));
+
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+
+		descs[3] = vld1q_lane_u64((uint64_t *)(desc + 3), descs[3], 0);
+		descs[2] = vld1q_lane_u64((uint64_t *)(desc + 2), descs[2], 0);
+		descs[1] = vld1q_lane_u64((uint64_t *)(desc + 1), descs[1], 0);
+		descs[0] = vld1q_lane_u64((uint64_t *)(desc), descs[0], 0);
+
+		mbp1 = vld1q_u64((uint64_t *)&buffer[i]);
+		mbp2 = vld1q_u64((uint64_t *)&buffer[i + 2]);
+
+		vst1q_u64((uint64_t *)&rx_pkts[i], mbp1);
+		vst1q_u64((uint64_t *)&rx_pkts[i + 2], mbp2);
+
+		if (split_rxe_flags) {
+			rte_mbuf_prefetch_part2(rx_pkts[i]);
+			rte_mbuf_prefetch_part2(rx_pkts[i + 1]);
+			rte_mbuf_prefetch_part2(rx_pkts[i + 2]);
+			rte_mbuf_prefetch_part2(rx_pkts[i + 3]);
+		}
+
+		pkt_mb4 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[3]), rvp_shuf_mask);
+		pkt_mb3 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[2]), rvp_shuf_mask);
+		pkt_mb2 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[1]), rvp_shuf_mask);
+		pkt_mb1 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[0]), rvp_shuf_mask);
+
+		if (do_offload) {
+			sxe2_rx_desc_offloads_para_fill_neon(rxq, desc, descs, &rx_pkts[i]);
+		} else {
+			const uint64x2_t mbuf_init = {
+				rxq->mbuf_init_value,
+				0,
+			};
+
+			vst1q_u64((uint64_t *)&rx_pkts[i]->rearm_data, mbuf_init);
+			vst1q_u64((uint64_t *)&rx_pkts[i + 1]->rearm_data, mbuf_init);
+			vst1q_u64((uint64_t *)&rx_pkts[i + 2]->rearm_data, mbuf_init);
+			vst1q_u64((uint64_t *)&rx_pkts[i + 3]->rearm_data, mbuf_init);
+		}
+
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb4), crc_adjust);
+		pkt_mb4 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb3), crc_adjust);
+		pkt_mb3 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb2), crc_adjust);
+		pkt_mb2 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb1), crc_adjust);
+		pkt_mb1 = vreinterpretq_u8_u16(tmp);
+
+		vst1q_u8((void *)&rx_pkts[i + 3]->rx_descriptor_fields1,
+				pkt_mb4);
+		vst1q_u8((void *)&rx_pkts[i + 2]->rx_descriptor_fields1,
+				pkt_mb3);
+		vst1q_u8((void *)&rx_pkts[i + 1]->rx_descriptor_fields1,
+				pkt_mb2);
+		vst1q_u8((void *)&rx_pkts[i]->rx_descriptor_fields1,
+				pkt_mb1);
+
+		if (likely(i + SXE2_RX_NUM_PER_LOOP_NEON < nb_pkts))
+			rte_prefetch_non_temporal(desc + SXE2_RX_NUM_PER_LOOP_NEON);
+
+		{
+			uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
+			uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
+			uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
+			uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
+			uint32x4_t sterr_tmp1 = vzip2q_u32(d1, d0);
+			uint32x4_t sterr_tmp2 = vzip2q_u32(d3, d2);
+			uint32x4_t sterr_u32 = vzip1q_u32(sterr_tmp1, sterr_tmp2);
+
+			staterr = vreinterpretq_u16_u32(sterr_u32);
+		}
+
+		sxe2_rx_desc_ptype_fill_neon(staterr, &rx_pkts[i], ptype_tbl);
+
+		if (umbcast_flags != NULL) {
+			uint32x4_t umbcast_mask = {
+				SXE2_RX_DESC_STATUS_UMBCAST_MASK, SXE2_RX_DESC_STATUS_UMBCAST_MASK,
+				SXE2_RX_DESC_STATUS_UMBCAST_MASK, SXE2_RX_DESC_STATUS_UMBCAST_MASK,
+			};
+
+			uint8x16_t umbcast_shuf_mask = {
+				0x0B, 0x03, 0x0F, 0x07,
+				0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF,
+			};
+			uint8x16_t umbcast_bits =
+				vreinterpretq_u8_u32(vandq_u32(vreinterpretq_u32_u16(staterr),
+							       umbcast_mask));
+
+			umbcast_bits = vqtbl1q_u8(umbcast_bits, umbcast_shuf_mask);
+			vst1q_lane_u32((uint32_t *)umbcast_flags,
+					vreinterpretq_u32_u8(umbcast_bits), 0);
+			umbcast_flags += SXE2_RX_NUM_PER_LOOP_NEON;
+		}
+
+		if (split_rxe_flags) {
+			uint8x16_t eop_shuf_mask = {
+					0x08, 0x00, 0x0C, 0x04,
+					0xFF, 0xFF, 0xFF, 0xFF,
+					0xFF, 0xFF, 0xFF, 0xFF,
+					0xFF, 0xFF, 0xFF, 0xFF};
+			uint8x16_t eop_bits;
+			uint32x4_t rxe_mask = {
+				0x2080, 0x2080, 0x2080, 0x2080
+			};
+			uint32x4_t rxe_bits;
+			uint32x4_t eop_mask;
+
+			eop_mask = vshlq_n_u32(vdupq_n_u32(1), SXE2_RX_DESC_STATUS_EOP_SHIFT);
+			eop_bits = vandq_u8(vmvnq_u8(vreinterpretq_u8_u16(staterr)),
+					vreinterpretq_u8_u32(eop_mask));
+
+			rxe_bits = vandq_u32(vreinterpretq_u32_u16(staterr), rxe_mask);
+			rxe_bits = vshrq_n_u32(rxe_bits, 7);
+
+			eop_bits = vorrq_u8(eop_bits, vreinterpretq_u8_u32(rxe_bits));
+
+			eop_bits = vqtbl1q_u8(eop_bits, eop_shuf_mask);
+
+			vst1q_lane_u32((uint32_t *)split_rxe_flags,
+				       vreinterpretq_u32_u8(eop_bits), 0);
+			split_rxe_flags += SXE2_RX_NUM_PER_LOOP_NEON;
+
+#ifdef RTE_IOVA_IN_MBUF
+			rx_pkts[i]->next = NULL;
+			rx_pkts[i + 1]->next = NULL;
+			rx_pkts[i + 2]->next = NULL;
+			rx_pkts[i + 3]->next = NULL;
+#endif
+		}
+
+		{
+			uint32x4_t dd_mask = vdupq_n_u32(1);
+			uint32x4_t sterr_dd = vandq_u32(vreinterpretq_u32_u16(staterr), dd_mask);
+			uint16x4_t packed_lo = vmovn_u32(sterr_dd);
+			uint64_t dd64 = vget_lane_u64(vreinterpret_u64_u16(packed_lo), 0);
+
+			bit_num = (uint16_t)rte_popcount64(dd64);
+		}
+		done_num += bit_num;
+		if (likely(bit_num != SXE2_RX_NUM_PER_LOOP_NEON))
+			break;
+	}
+
+	rxq->processing_idx += done_num;
+	rxq->processing_idx &= (rxq->ring_depth - 1);
+	rxq->realloc_num    += done_num;
+
+l_end:
+	return done_num;
+}
+
+static __rte_always_inline uint16_t
+sxe2_rx_pkts_scattered_batch_vec_neon(struct sxe2_rx_queue *rxq,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts, bool do_offload)
+{
+	const uint64_t *split_flags64;
+	uint8_t split_rxe_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	uint8_t umbcast_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	uint16_t rx_done_num;
+	uint16_t rx_pkt_done_num;
+
+	rx_pkt_done_num = 0;
+
+	if (rxq->vsi->adapter->devargs.sw_stats_en) {
+		rx_done_num = sxe2_rx_pkts_common_vec_neon((struct sxe2_rx_queue *)rxq,
+					rx_pkts, nb_pkts, split_rxe_flags, umbcast_flags,
+					do_offload);
+	} else {
+		rx_done_num = sxe2_rx_pkts_common_vec_neon((struct sxe2_rx_queue *)rxq,
+					rx_pkts, nb_pkts, split_rxe_flags, NULL,
+					do_offload);
+	}
+
+	if (rx_done_num == 0)
+		goto l_end;
+
+	if (!rxq->vsi->adapter->devargs.sw_stats_en) {
+		split_flags64 = (uint64_t *)split_rxe_flags;
+
+		if (rxq->pkt_first_seg == NULL &&
+				split_flags64[0] == 0 && split_flags64[1] == 0 &&
+				split_flags64[2] == 0 && split_flags64[3] == 0) {
+			rx_pkt_done_num = rx_done_num;
+			goto l_end;
+		}
+
+		if (rxq->pkt_first_seg == NULL) {
+			while (rx_pkt_done_num < rx_done_num &&
+					split_rxe_flags[rx_pkt_done_num] == 0) {
+				rx_pkt_done_num++;
+			}
+
+			if (rx_pkt_done_num == rx_done_num)
+				goto l_end;
+
+			rxq->pkt_first_seg = rx_pkts[rx_pkt_done_num];
+		}
+	}
+
+	rx_pkt_done_num += sxe2_rx_pkts_refactor(rxq, &rx_pkts[rx_pkt_done_num],
+			rx_done_num - rx_pkt_done_num, &split_rxe_flags[rx_pkt_done_num],
+			&umbcast_flags[rx_pkt_done_num]);
+
+l_end:
+	return rx_pkt_done_num;
+}
+
+uint16_t sxe2_rx_pkts_scattered_vec_neon_offload(void *rx_queue,
+			struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	uint16_t done_num = 0;
+	uint16_t once_num;
+
+	while (nb_pkts > SXE2_RX_PKTS_BURST_BATCH_NUM_VEC) {
+		once_num = sxe2_rx_pkts_scattered_batch_vec_neon((struct sxe2_rx_queue *)rx_queue,
+								 rx_pkts + done_num,
+								 SXE2_RX_PKTS_BURST_BATCH_NUM_VEC,
+								 true);
+
+		done_num += once_num;
+		nb_pkts  -= once_num;
+
+		if (once_num < SXE2_RX_PKTS_BURST_BATCH_NUM_VEC)
+			goto l_end;
+	}
+
+	done_num += sxe2_rx_pkts_scattered_batch_vec_neon((struct sxe2_rx_queue *)rx_queue,
+							  rx_pkts + done_num,
+							  nb_pkts,
+							  true);
+l_end:
+	SXE2_RX_STATS_CNT(rx_queue, rx_pkts_num, done_num);
+	return done_num;
+}
+
+uint16_t sxe2_rx_pkts_scattered_vec_neon(void *rx_queue,
+			struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	uint16_t done_num = 0;
+	uint16_t once_num;
+
+	while (nb_pkts > SXE2_RX_PKTS_BURST_BATCH_NUM_VEC) {
+		once_num = sxe2_rx_pkts_scattered_batch_vec_neon((struct sxe2_rx_queue *)rx_queue,
+								 rx_pkts + done_num,
+								 SXE2_RX_PKTS_BURST_BATCH_NUM_VEC,
+								 false);
+
+		done_num += once_num;
+		nb_pkts  -= once_num;
+
+		if (once_num < SXE2_RX_PKTS_BURST_BATCH_NUM_VEC)
+			goto l_end;
+	}
+
+	done_num += sxe2_rx_pkts_scattered_batch_vec_neon((struct sxe2_rx_queue *)rx_queue,
+							  rx_pkts + done_num,
+							  nb_pkts,
+							  false);
+l_end:
+	SXE2_RX_STATS_CNT(rx_queue, rx_pkts_num, done_num);
+	return done_num;
+}
+#endif
-- 
2.47.3

