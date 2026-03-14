Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7639105F79E
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Mar 2026 08:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11954402A3;
	Sat, 14 Mar 2026 09:58:53 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id C113D4060F
 for <dev@dpdk.org>; Sat, 14 Mar 2026 09:58:50 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-03 (Coremail) with SMTP id rQCowAB3ktm2IbVp1GKhCg--.37229S14;
 Sat, 14 Mar 2026 16:52:07 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v19 12/13] net/sxe: add simd function
Date: Sat, 14 Mar 2026 16:52:04 +0800
Message-Id: <20260314085205.2419952-13-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
References: <20260303091057.2952214-14-liujie5@linkdatatechnology.com>
 <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: rQCowAB3ktm2IbVp1GKhCg--.37229S14
X-Coremail-Antispam: 1UD129KBjvAXoWDJFyfZFyxCrWUZF15CF1kuFg_yoW7CryrWo
 WIvw4fJr4ruF1xAr1kuw1UuFy2vF4F9ryUCrZY9393Zay8CrySk34xAw15AF98Kw1jkFn5
 Xa4xta9ayrW3Jr4fn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO57AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 kIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
 6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
 v_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvE
 c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
 AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
 vjfU5l1vDUUUU
X-Originating-IP: [221.238.36.162]
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

Add simd function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_queue_common.c |  52 +-
 drivers/net/sxe/base/sxe_rx_common.c    | 124 ++++-
 drivers/net/sxe/pf/sxe_vec_common.h     | 321 ++++++++++++
 drivers/net/sxe/pf/sxe_vec_neon.c       | 600 +++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_vec_sse.c        | 622 ++++++++++++++++++++++++
 5 files changed, 1716 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/sxe/pf/sxe_vec_common.h
 create mode 100644 drivers/net/sxe/pf/sxe_vec_neon.c
 create mode 100644 drivers/net/sxe/pf/sxe_vec_sse.c

diff --git a/drivers/net/sxe/base/sxe_queue_common.c b/drivers/net/sxe/base/sxe_queue_common.c
index da44270019..991b374667 100644
--- a/drivers/net/sxe/base/sxe_queue_common.c
+++ b/drivers/net/sxe/base/sxe_queue_common.c
@@ -13,6 +13,10 @@
 #include "sxe_logs.h"
 #include "sxe_regs.h"
 #include "sxe.h"
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include "sxe_vec_common.h"
+#include <rte_vect.h>
+#endif
 #include "sxe_queue_common.h"
 #include "sxe_queue.h"
 
@@ -57,6 +61,10 @@ s32 __rte_cold __sxe_rx_queue_setup(struct rx_setup *rx_setup, bool is_vf)
 	u16 len;
 	u64 offloads;
 	s32 ret = 0;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	struct sxe_adapter *pf_adapter = dev->data->dev_private;
+	struct sxevf_adapter *vf_adapter = dev->data->dev_private;
+#endif
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -161,6 +169,23 @@ s32 __rte_cold __sxe_rx_queue_setup(struct rx_setup *rx_setup, bool is_vf)
 				"dma_addr=0x%" SXE_PRIX64,
 			 rxq->buffer_ring, rxq->sc_buffer_ring, rxq->desc_ring,
 			 rxq->base_addr);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	if (!rte_is_power_of_2(desc_num)) {
+		PMD_LOG_DEBUG(INIT, "queue[%d] doesn't meet Vector Rx "
+					"preconditions - canceling the feature for "
+					"the whole port[%d]",
+				 rxq->queue_id, rxq->port_id);
+		if (is_vf)
+			vf_adapter->rx_vec_allowed = false;
+		else
+			pf_adapter->rx_vec_allowed = false;
+
+	} else {
+		sxe_rxq_vec_setup(rxq);
+	}
+#endif
+
 	dev->data->rx_queues[queue_idx] = rxq;
 
 	sxe_rx_queue_init(*rx_setup->rx_batch_alloc_allowed, rxq);
@@ -254,6 +279,9 @@ void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
 		struct rte_eth_recycle_rxq_info *q_info)
 {
 	struct sxe_rx_queue *rxq;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	struct sxe_adapter *adapter = dev->data->dev_private;
+#endif
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -261,9 +289,21 @@ void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
 	q_info->mp = rxq->mb_pool;
 	q_info->mbuf_ring_size = rxq->ring_depth;
 	q_info->receive_tail = &rxq->processing_idx;
-
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	if (adapter->rx_vec_allowed) {
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+		q_info->refill_requirement = rxq->realloc_num;
+		q_info->refill_head = &rxq->realloc_start;
+#endif
+	} else {
+		q_info->refill_requirement = rxq->batch_alloc_size;
+		q_info->refill_head = &rxq->batch_alloc_trigger;
+	}
+#else
 	q_info->refill_requirement = rxq->batch_alloc_size;
 	q_info->refill_head = &rxq->batch_alloc_trigger;
+#endif
+	return;
 }
 
 void __sxe_tx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
@@ -289,7 +329,17 @@ s32 __sxe_tx_done_cleanup(void *tx_queue, u32 free_cnt)
 	struct sxe_tx_queue *txq = (struct sxe_tx_queue *)tx_queue;
 	if (txq->offloads == 0 &&
 		txq->rs_thresh >= RTE_PMD_SXE_MAX_TX_BURST) {
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+		if (txq->rs_thresh <= RTE_SXE_MAX_TX_FREE_BUF_SZ &&
+			(rte_eal_process_type() != RTE_PROC_PRIMARY ||
+			txq->buffer_ring_vec != NULL)) {
+			ret = sxe_tx_done_cleanup_vec(txq, free_cnt);
+		} else {
+			ret = sxe_tx_done_cleanup_simple(txq, free_cnt);
+		}
+#else
 		ret = sxe_tx_done_cleanup_simple(txq, free_cnt);
+#endif
 
 	} else {
 		ret = sxe_tx_done_cleanup_full(txq, free_cnt);
diff --git a/drivers/net/sxe/base/sxe_rx_common.c b/drivers/net/sxe/base/sxe_rx_common.c
index ae97b719e7..5e46ff76f3 100644
--- a/drivers/net/sxe/base/sxe_rx_common.c
+++ b/drivers/net/sxe/base/sxe_rx_common.c
@@ -18,6 +18,10 @@
 #include "sxe_errno.h"
 #include "sxe_irq.h"
 #include "sxe_rx_common.h"
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include "sxe_vec_common.h"
+#include "rte_vect.h"
+#endif
 
 static inline void sxe_rx_resource_prefetch(u16 next_idx,
 				struct sxe_rx_buffer *buf_ring,
@@ -29,12 +33,61 @@ static inline void sxe_rx_resource_prefetch(u16 next_idx,
 		rte_sxe_prefetch(&desc_ring[next_idx]);
 		rte_sxe_prefetch(&buf_ring[next_idx]);
 	}
+
 }
 
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+static void sxe_recycle_rx_descriptors_refill_vec(void *rx_queue, u16 nb_mbufs)
+{
+	struct sxe_rx_queue *rxq = rx_queue;
+	struct sxe_rx_buffer *rxep;
+	volatile union sxe_rx_data_desc *rxdp;
+	u16 rx_id;
+	u64 paddr;
+	u64 dma_addr;
+	u16 i;
+
+	rxdp = rxq->desc_ring + rxq->realloc_start;
+	rxep = &rxq->buffer_ring[rxq->realloc_start];
+
+	for (i = 0; i < nb_mbufs; i++) {
+		paddr = (rxep[i].mbuf)->buf_iova + RTE_PKTMBUF_HEADROOM;
+		dma_addr = rte_cpu_to_le_64(paddr);
+		rxdp[i].read.hdr_addr = 0;
+		rxdp[i].read.pkt_addr = dma_addr;
+	}
+
+	rxq->realloc_start += nb_mbufs;
+	if (rxq->realloc_start >= rxq->ring_depth)
+		rxq->realloc_start = 0;
+
+	rxq->realloc_num -= nb_mbufs;
+
+	rx_id = (u16)((rxq->realloc_start == 0) ?
+					(rxq->ring_depth - 1) : (rxq->realloc_start - 1));
+
+	SXE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr, rx_id);
+}
+#endif
+#endif
+
 void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 	bool rx_batch_alloc_allowed, bool *rx_vec_allowed)
 {
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	u16  i, is_using_sse;
+
+	if (sxe_rx_vec_condition_check(dev) ||
+		!rx_batch_alloc_allowed
+		) {
+		PMD_LOG_DEBUG(INIT, "Port[%d] doesn't meet Vector Rx "
+					"preconditions", dev->data->port_id);
+		*rx_vec_allowed = false;
+	}
+#else
 	UNUSED(rx_vec_allowed);
+#endif
 
 	if (dev->data->lro) {
 		if (rx_batch_alloc_allowed) {
@@ -47,7 +100,27 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 			dev->rx_pkt_burst = sxe_single_alloc_lro_pkts_recv;
 		}
 	} else if (dev->data->scattered_rx) {
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+		if (*rx_vec_allowed) {
+			PMD_LOG_DEBUG(INIT, "Using Vector Scattered Rx "
+						"callback (port=%d).",
+					 dev->data->port_id);
+
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+			dev->recycle_rx_descriptors_refill = sxe_recycle_rx_descriptors_refill_vec;
+
+#endif
+			dev->rx_pkt_burst = sxe_scattered_pkts_vec_recv;
+
+#endif
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+
+		} else if (rx_batch_alloc_allowed) {
+#else
 		if (rx_batch_alloc_allowed) {
+#endif
+
 			PMD_LOG_DEBUG(INIT, "Using a Scattered with bulk "
 					   "allocation callback (port=%d).",
 					 dev->data->port_id);
@@ -62,7 +135,22 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 
 			dev->rx_pkt_burst = sxe_single_alloc_lro_pkts_recv;
 		}
-	} else if (rx_batch_alloc_allowed) {
+	}
+	#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	else if (*rx_vec_allowed) {
+		PMD_LOG_DEBUG(INIT, "Vector rx enabled, please make sure RX "
+					"burst size no less than %d (port=%d).",
+				 SXE_DESCS_PER_LOOP,
+				 dev->data->port_id);
+
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+		dev->recycle_rx_descriptors_refill = sxe_recycle_rx_descriptors_refill_vec;
+
+#endif
+		dev->rx_pkt_burst = sxe_pkts_vec_recv;
+	}
+#endif
+	else if (rx_batch_alloc_allowed) {
 		PMD_LOG_DEBUG(INIT, "Rx Burst Bulk Alloc Preconditions are "
 					"satisfied. Rx Burst Bulk Alloc function "
 					"will be used on port=%d.",
@@ -77,6 +165,19 @@ void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
 
 		dev->rx_pkt_burst = sxe_pkts_recv;
 	}
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	is_using_sse =
+		(dev->rx_pkt_burst == sxe_scattered_pkts_vec_recv ||
+		dev->rx_pkt_burst == sxe_pkts_vec_recv);
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct sxe_rx_queue *rxq = dev->data->rx_queues[i];
+
+		rxq->is_using_sse = is_using_sse;
+	}
+#endif
+
 }
 
 s32 __sxe_rx_descriptor_status(void *rx_queue, u16 offset)
@@ -93,7 +194,15 @@ s32 __sxe_rx_descriptor_status(void *rx_queue, u16 offset)
 		ret = -EINVAL;
 		goto l_end;
 	}
-	hold_num = rxq->hold_num;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#if defined(RTE_ARCH_X86)
+	if (rxq->is_using_sse)
+		hold_num = rxq->realloc_num;
+	else
+#endif
+#endif
+		hold_num = rxq->hold_num;
 	if (offset >= rxq->ring_depth - hold_num) {
 		ret = RTE_ETH_RX_DESC_UNAVAIL;
 		goto l_end;
@@ -233,6 +342,17 @@ const u32 *__sxe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of
 		goto l_end;
 	}
 
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#if defined(RTE_ARCH_X86)
+	if (dev->rx_pkt_burst == sxe_pkts_vec_recv ||
+		dev->rx_pkt_burst == sxe_scattered_pkts_vec_recv) {
+		*no_of_elements = RTE_DIM(ptypes_arr);
+		ptypes = ptypes_arr;
+	}
+
+#endif
+#endif
+
 l_end:
 	return ptypes;
 }
diff --git a/drivers/net/sxe/pf/sxe_vec_common.h b/drivers/net/sxe/pf/sxe_vec_common.h
new file mode 100644
index 0000000000..90ace4c324
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_vec_common.h
@@ -0,0 +1,321 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_VEC_COMMON_H__
+#define __SXE_VEC_COMMON_H__
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include <stdint.h>
+#include <rte_mempool.h>
+#include <ethdev_driver.h>
+#include <dev_driver.h>
+#include <rte_malloc.h>
+#include "sxe.h"
+#include "sxe_queue.h"
+#include "sxe_rx.h"
+
+#define RTE_SXE_MAX_TX_FREE_BUF_SZ	64
+#define SXE_TXD_STAT_DD				0x00000001
+
+static __rte_always_inline s32
+sxe_tx_bufs_vec_free(struct sxe_tx_queue *txq)
+{
+	struct sxe_tx_buffer_vec *txep;
+	u32 status;
+	u32 n;
+	u32 i;
+	s32 ret;
+	s32 nb_free = 0;
+	struct rte_mbuf *m, *free[RTE_SXE_MAX_TX_FREE_BUF_SZ];
+
+	status = txq->desc_ring[txq->next_dd].wb.status;
+	if (!(status & SXE_TXD_STAT_DD)) {
+		ret = 0;
+		goto out;
+	}
+
+	n = txq->rs_thresh;
+
+	txep = &txq->buffer_ring_vec[txq->next_dd - (n - 1)];
+	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
+
+	if (likely(m != NULL)) {
+		free[0] = m;
+		nb_free = 1;
+		for (i = 1; i < n; i++) {
+			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
+			if (likely(m != NULL)) {
+				if (likely(m->pool == free[0]->pool)) {
+					free[nb_free++] = m;
+				} else {
+					rte_mempool_put_bulk(free[0]->pool,
+							(void *)free, nb_free);
+					free[0] = m;
+					nb_free = 1;
+				}
+			}
+		}
+		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+	} else {
+		for (i = 1; i < n; i++) {
+			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
+			if (m != NULL)
+				rte_mempool_put(m->pool, m);
+		}
+	}
+
+	txq->desc_free_num = (u16)(txq->desc_free_num + txq->rs_thresh);
+	txq->next_dd = (u16)(txq->next_dd + txq->rs_thresh);
+	if (txq->next_dd >= txq->ring_depth)
+		txq->next_dd = (u16)(txq->rs_thresh - 1);
+
+	ret = txq->rs_thresh;
+out:
+	return ret;
+}
+
+static inline u16
+sxe_packets_reassemble(sxe_rx_queue_s *rxq, struct rte_mbuf **rx_bufs,
+			u16 bufs_num, u8 *split_flags)
+{
+	struct rte_mbuf **pkts = (struct rte_mbuf **)malloc(bufs_num * sizeof(struct rte_mbuf *));
+	if (pkts == NULL) {
+		perror("pkts malloc failed");
+		exit(EXIT_FAILURE);
+	}
+	struct rte_mbuf *start = rxq->pkt_first_seg;
+	struct rte_mbuf *end = rxq->pkt_last_seg;
+	u32 pkt_idx, buf_idx;
+
+	for (buf_idx = 0, pkt_idx = 0; buf_idx < bufs_num; buf_idx++) {
+		if (end != NULL) {
+			end->next = rx_bufs[buf_idx];
+			rx_bufs[buf_idx]->data_len += rxq->crc_len;
+
+			start->nb_segs++;
+			start->pkt_len += rx_bufs[buf_idx]->data_len;
+			end = end->next;
+
+			if (!split_flags[buf_idx]) {
+				start->hash = end->hash;
+				start->ol_flags = end->ol_flags;
+				start->pkt_len -= rxq->crc_len;
+				if (end->data_len > rxq->crc_len) {
+					end->data_len -= rxq->crc_len;
+				} else {
+					struct rte_mbuf *secondlast = start;
+
+					start->nb_segs--;
+					while (secondlast->next != end)
+						secondlast = secondlast->next;
+
+					secondlast->data_len -= (rxq->crc_len -
+							end->data_len);
+					secondlast->next = NULL;
+					rte_pktmbuf_free_seg(end);
+				}
+				pkts[pkt_idx++] = start;
+				start = NULL;
+				end = NULL;
+			}
+		} else {
+			if (!split_flags[buf_idx]) {
+				pkts[pkt_idx++] = rx_bufs[buf_idx];
+				continue;
+			}
+			start = rx_bufs[buf_idx];
+			end = rx_bufs[buf_idx];
+			rx_bufs[buf_idx]->data_len += rxq->crc_len;
+			rx_bufs[buf_idx]->pkt_len += rxq->crc_len;
+		}
+	}
+
+	rxq->pkt_first_seg = start;
+	rxq->pkt_last_seg = end;
+	memcpy(rx_bufs, pkts, pkt_idx * (sizeof(*pkts)));
+
+	free(pkts);
+	return pkt_idx;
+}
+
+static inline void
+sxe_rx_vec_mbufs_release(sxe_rx_queue_s *rxq)
+{
+	u16 i;
+
+	if (rxq->buffer_ring == NULL || rxq->realloc_num >= rxq->ring_depth)
+		return;
+
+	if (rxq->realloc_num == 0) {
+		for (i = 0; i < rxq->ring_depth; i++) {
+			if (rxq->buffer_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(rxq->buffer_ring[i].mbuf);
+		}
+	} else {
+		for (i = rxq->processing_idx;
+			 i != rxq->realloc_start;
+			 i = (i + 1) % rxq->ring_depth) {
+			if (rxq->buffer_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(rxq->buffer_ring[i].mbuf);
+		}
+	}
+
+	rxq->realloc_num = rxq->ring_depth;
+
+	memset(rxq->buffer_ring, 0, sizeof(rxq->buffer_ring[0]) * rxq->ring_depth);
+}
+
+static inline s32
+sxe_default_rxq_vec_setup(sxe_rx_queue_s *rxq)
+{
+	uintptr_t p;
+	struct rte_mbuf mbuf = { .buf_addr = 0 };
+
+	mbuf.nb_segs = 1;
+	mbuf.data_off = RTE_PKTMBUF_HEADROOM;
+	mbuf.port = rxq->port_id;
+	rte_mbuf_refcnt_set(&mbuf, 1);
+
+	rte_compiler_barrier();
+	p = (uintptr_t)&mbuf.rearm_data;
+	rxq->mbuf_init_value = *(u64 *)p;
+
+	return 0;
+}
+
+static inline s32
+sxe_default_rx_vec_condition_check(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+
+#ifndef RTE_LIBRTE_IEEE1588
+	struct rte_eth_fdir_conf *fnav_conf = SXE_DEV_FNAV_CONF(dev);
+	if (fnav_conf->mode != RTE_FDIR_MODE_NONE)
+		ret = -1;
+#else
+	RTE_SET_USED(dev);
+	ret = -1;
+#endif
+
+	return ret;
+}
+
+static __rte_always_inline void
+sxe_vec_mbuf_fill(struct sxe_tx_buffer_vec *buffer_ring,
+		 struct rte_mbuf **tx_pkts, u16 pkts_num)
+{
+	s32 i;
+
+	for (i = 0; i < pkts_num; ++i)
+		buffer_ring[i].mbuf = tx_pkts[i];
+}
+
+static inline void
+sxe_tx_queue_vec_init(sxe_tx_queue_s *txq)
+{
+	u16 i;
+	volatile sxe_tx_data_desc_u *txd;
+	static const sxe_tx_data_desc_u zeroed_desc = { {0} };
+	struct sxe_tx_buffer_vec *tx_buffer = txq->buffer_ring_vec;
+
+	for (i = 0; i < txq->ring_depth; i++)
+		txq->desc_ring[i] = zeroed_desc;
+
+	for (i = 0; i < txq->ring_depth; i++) {
+		txd = &txq->desc_ring[i];
+		txd->wb.status = SXE_TX_DESC_STAT_DD;
+		tx_buffer[i].mbuf = NULL;
+	}
+
+	txq->ctx_curr	  = 0;
+	txq->desc_used_num = 0;
+	txq->desc_free_num = txq->ring_depth - 1;
+	txq->next_to_use   = 0;
+	txq->next_to_clean = txq->ring_depth - 1;
+	txq->next_dd	   = txq->rs_thresh  - 1;
+	txq->next_rs	   = txq->rs_thresh  - 1;
+	memset((void *)&txq->ctx_cache, 0,
+			SXE_CTXT_DESC_NUM * sizeof(struct sxe_ctxt_info));
+}
+
+static inline void
+sxe_tx_mbufs_vec_release(sxe_tx_queue_s *txq)
+{
+	u16 i;
+	struct sxe_tx_buffer_vec *tx_buffer;
+	const u16 max_desc = (u16)(txq->ring_depth - 1);
+
+	if (txq->buffer_ring_vec == NULL || txq->desc_free_num == max_desc)
+		return;
+
+	for (i = txq->next_dd - (txq->rs_thresh - 1);
+		 i != txq->next_to_use;
+		 i = (i + 1) % txq->ring_depth) {
+		tx_buffer = &txq->buffer_ring_vec[i];
+		rte_pktmbuf_free_seg(tx_buffer->mbuf);
+	}
+	txq->desc_free_num = max_desc;
+
+	for (i = 0; i < txq->ring_depth; i++) {
+		tx_buffer = &txq->buffer_ring_vec[i];
+		tx_buffer->mbuf = NULL;
+	}
+}
+
+static inline void
+sxe_tx_buffer_ring_vec_free(sxe_tx_queue_s *txq)
+{
+	if (txq == NULL)
+		return;
+
+	if (txq->buffer_ring_vec != NULL) {
+		rte_free(txq->buffer_ring_vec - 1);
+		txq->buffer_ring_vec = NULL;
+	}
+}
+
+static inline s32
+sxe_default_txq_vec_setup(sxe_tx_queue_s *txq,
+				const struct sxe_txq_ops *txq_ops)
+{
+	s32 ret = 0;
+
+	if (txq->buffer_ring_vec == NULL) {
+		ret = -1;
+		goto l_out;
+	}
+
+	txq->buffer_ring_vec = txq->buffer_ring_vec + 1;
+	txq->ops = txq_ops;
+
+l_out:
+	return ret;
+}
+
+static inline int
+sxe_tx_done_cleanup_vec(sxe_tx_queue_s *txq, u32 free_cnt)
+{
+	UNUSED(txq);
+	UNUSED(free_cnt);
+
+	return -ENOTSUP;
+}
+
+s32 sxe_txq_vec_setup(sxe_tx_queue_s *txq);
+
+s32 sxe_rx_vec_condition_check(struct rte_eth_dev *dev);
+
+s32 sxe_rxq_vec_setup(sxe_rx_queue_s *rxq);
+
+void sxe_rx_queue_vec_mbufs_release(sxe_rx_queue_s *rxq);
+
+u16 sxe_scattered_pkts_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 pkts_num);
+
+u16 sxe_pkts_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 pkts_num);
+
+u16
+__sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
+			   u16 pkts_num);
+
+#endif
+#endif
diff --git a/drivers/net/sxe/pf/sxe_vec_neon.c b/drivers/net/sxe/pf/sxe_vec_neon.c
new file mode 100644
index 0000000000..6d261dd7bc
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_vec_neon.c
@@ -0,0 +1,600 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include <stdint.h>
+#include <ethdev_driver.h>
+#include <rte_malloc.h>
+
+#include <rte_vect.h>
+#include "sxe_vec_common.h"
+
+#define RTE_SXE_DESCS_PER_LOOP			4
+#define SXE_PACKET_TYPE_MASK_TUNNEL		0xFF
+#define SXE_PACKET_TYPE_SHIFT			0x04
+#define SXE_RXDADV_ERR_TCPE				0x40000000
+#define SXE_VPMD_DESC_EOP_MASK			0x02020202
+#define SXE_UINT8_BIT					(CHAR_BIT * sizeof(u8))
+
+static inline void
+sxe_rxq_rearm(struct sxe_rx_queue *rxq)
+{
+	s32 i;
+	u16 rx_id;
+	volatile union sxe_rx_data_desc *rxdp;
+	struct sxe_rx_buffer *rxep = &rxq->buffer_ring[rxq->realloc_start];
+	struct rte_mbuf *mb0, *mb1;
+	uint64x2_t dma_addr0, dma_addr1;
+	uint64x2_t zero = vdupq_n_u64(0);
+	u64 paddr;
+	uint8x8_t p;
+
+	rxdp = rxq->desc_ring + rxq->realloc_start;
+
+	if (unlikely(rte_mempool_get_bulk(rxq->mb_pool,
+					  (void *)rxep,
+					  RTE_PMD_SXE_MAX_RX_BURST) < 0)) {
+		if (rxq->realloc_num + RTE_PMD_SXE_MAX_RX_BURST >=
+			rxq->ring_depth) {
+			for (i = 0; i < RTE_SXE_DESCS_PER_LOOP; i++) {
+				rxep[i].mbuf = &rxq->fake_mbuf;
+				vst1q_u64(RTE_CAST_PTR(u64 *, &rxdp[i].read),
+					  zero);
+			}
+		}
+		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
+			RTE_PMD_SXE_MAX_RX_BURST;
+		return;
+	}
+
+	p = vld1_u8((u8 *)&rxq->mbuf_init_value);
+
+	for (i = 0; i < RTE_PMD_SXE_MAX_RX_BURST; i += 2, rxep += 2) {
+		mb0 = rxep[0].mbuf;
+		mb1 = rxep[1].mbuf;
+
+		vst1_u8((u8 *)&mb0->rearm_data, p);
+		paddr = mb0->buf_iova + RTE_PKTMBUF_HEADROOM;
+		dma_addr0 = vsetq_lane_u64(paddr, zero, 0);
+
+		vst1q_u64(RTE_CAST_PTR(u64 *, &rxdp++->read), dma_addr0);
+
+		vst1_u8((u8 *)&mb1->rearm_data, p);
+		paddr = mb1->buf_iova + RTE_PKTMBUF_HEADROOM;
+		dma_addr1 = vsetq_lane_u64(paddr, zero, 0);
+		vst1q_u64(RTE_CAST_PTR(u64 *, &rxdp++->read), dma_addr1);
+	}
+
+	rxq->realloc_start += RTE_PMD_SXE_MAX_RX_BURST;
+	if (rxq->realloc_start >= rxq->ring_depth)
+		rxq->realloc_start = 0;
+
+	rxq->realloc_num -= RTE_PMD_SXE_MAX_RX_BURST;
+
+	rx_id = (u16)((rxq->realloc_start == 0) ?
+				(rxq->ring_depth - 1) : (rxq->realloc_start - 1));
+
+	sxe_write_addr(rx_id, rxq->rdt_reg_addr);
+}
+
+static inline void
+sxe_desc_to_olflags_v(uint8x16x2_t sterr_tmp1, uint8x16x2_t sterr_tmp2,
+		  uint8x16_t staterr, u8 vlan_flags, u16 udp_p_flag,
+		  struct rte_mbuf **rx_pkts)
+{
+	u16 udp_p_flag_hi;
+	uint8x16_t ptype, udp_csum_skip;
+	uint32x4_t temp_udp_csum_skip = {0, 0, 0, 0};
+	uint8x16_t vtag_lo, vtag_hi, vtag;
+	uint8x16_t temp_csum;
+	uint32x4_t csum = {0, 0, 0, 0};
+
+	union {
+		u16 e[4];
+		u64 word;
+	} vol;
+
+	const uint8x16_t rsstype_msk = {
+			0x0F, 0x0F, 0x0F, 0x0F,
+			0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00};
+
+	const uint8x16_t rss_flags = {
+			0, RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_RSS_HASH,
+			0, RTE_MBUF_F_RX_RSS_HASH, 0, RTE_MBUF_F_RX_RSS_HASH,
+			RTE_MBUF_F_RX_RSS_HASH, 0, 0, 0,
+			0, 0, 0, RTE_MBUF_F_RX_FDIR};
+
+	const uint8x16_t vlan_csum_msk = {
+			SXE_RXD_STAT_VP, SXE_RXD_STAT_VP,
+			SXE_RXD_STAT_VP, SXE_RXD_STAT_VP,
+			0, 0, 0, 0,
+			0, 0, 0, 0,
+			(SXE_RXDADV_ERR_TCPE | SXE_RXDADV_ERR_IPE) >> 24,
+			(SXE_RXDADV_ERR_TCPE | SXE_RXDADV_ERR_IPE) >> 24,
+			(SXE_RXDADV_ERR_TCPE | SXE_RXDADV_ERR_IPE) >> 24,
+			(SXE_RXDADV_ERR_TCPE | SXE_RXDADV_ERR_IPE) >> 24};
+
+	const uint8x16_t vlan_csum_map_lo = {
+			RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+			RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+			RTE_MBUF_F_RX_IP_CKSUM_BAD,
+			RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+			0, 0, 0, 0,
+			vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+			vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+			vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_BAD,
+			vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+			0, 0, 0, 0};
+
+	const uint8x16_t vlan_csum_map_hi = {
+			RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8), 0,
+			RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8), 0,
+			0, 0, 0, 0,
+			RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8), 0,
+			RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8), 0,
+			0, 0, 0, 0};
+
+	udp_p_flag_hi = udp_p_flag >> 8;
+
+	const uint8x16_t udp_hdr_p_msk = {
+			0, 0, 0, 0,
+			udp_p_flag_hi, udp_p_flag_hi, udp_p_flag_hi, udp_p_flag_hi,
+			0, 0, 0, 0,
+			0, 0, 0, 0};
+
+	const uint8x16_t udp_csum_bad_shuf = {
+			0xFF, ~(u8)RTE_MBUF_F_RX_L4_CKSUM_BAD, 0, 0,
+			0, 0, 0, 0,
+			0, 0, 0, 0,
+			0, 0, 0, 0};
+
+	ptype = vzipq_u8(sterr_tmp1.val[0], sterr_tmp2.val[0]).val[0];
+
+	udp_csum_skip = vandq_u8(ptype, udp_hdr_p_msk);
+
+	temp_udp_csum_skip = vcopyq_laneq_u32(temp_udp_csum_skip, 0,
+				vreinterpretq_u32_u8(udp_csum_skip), 1);
+
+	ptype = vandq_u8(ptype, rsstype_msk);
+	ptype = vqtbl1q_u8(rss_flags, ptype);
+
+	vtag = vandq_u8(staterr, vlan_csum_msk);
+
+	temp_csum = vshrq_n_u8(vtag, 6);
+
+	csum = vsetq_lane_u32(vgetq_lane_u32(vreinterpretq_u32_u8(temp_csum), 3), csum, 0);
+	vtag = vorrq_u8(vreinterpretq_u8_u32(csum), vtag);
+
+	vtag_hi = vqtbl1q_u8(vlan_csum_map_hi, vtag);
+	vtag_hi = vshrq_n_u8(vtag_hi, 7);
+
+	vtag_lo = vqtbl1q_u8(vlan_csum_map_lo, vtag);
+	vtag_lo = vorrq_u8(ptype, vtag_lo);
+
+	udp_csum_skip = vshrq_n_u8(vreinterpretq_u8_u32(temp_udp_csum_skip), 1);
+	udp_csum_skip = vqtbl1q_u8(udp_csum_bad_shuf, udp_csum_skip);
+	vtag_lo = vandq_u8(vtag_lo, udp_csum_skip);
+
+	vtag = vzipq_u8(vtag_lo, vtag_hi).val[0];
+	vol.word = vgetq_lane_u64(vreinterpretq_u64_u8(vtag), 0);
+
+	rx_pkts[0]->ol_flags = vol.e[0];
+	rx_pkts[1]->ol_flags = vol.e[1];
+	rx_pkts[2]->ol_flags = vol.e[2];
+	rx_pkts[3]->ol_flags = vol.e[3];
+}
+
+static inline u32
+sxe_get_packet_type(u32 pkt_info,
+		u32 etqf_check,
+		u32 tunnel_check)
+{
+	u32 rte;
+
+	if (etqf_check) {
+		rte = RTE_PTYPE_UNKNOWN;
+		goto out;
+	}
+
+	if (tunnel_check) {
+		pkt_info &= SXE_PACKET_TYPE_MASK_TUNNEL;
+		rte = sxe_ptype_table_tn[pkt_info];
+		goto out;
+	}
+
+	pkt_info &= SXE_PACKET_TYPE_MASK;
+	rte = sxe_ptype_table[pkt_info];
+
+out:
+	return rte;
+}
+
+static inline void
+sxe_desc_to_ptype_v(uint64x2_t descs[4], u16 pkt_type_mask,
+		struct rte_mbuf **rx_pkts)
+{
+	uint32x4_t etqf_check, tunnel_check;
+	uint32x4_t etqf_mask = vdupq_n_u32(0x8000);
+	uint32x4_t tunnel_mask = vdupq_n_u32(0x10000);
+	uint32x4_t ptype_mask = vdupq_n_u32((u32)pkt_type_mask);
+	uint32x4_t ptype0 = vzipq_u32(vreinterpretq_u32_u64(descs[0]),
+				vreinterpretq_u32_u64(descs[2])).val[0];
+	uint32x4_t ptype1 = vzipq_u32(vreinterpretq_u32_u64(descs[1]),
+				vreinterpretq_u32_u64(descs[3])).val[0];
+
+	ptype0 = vzipq_u32(ptype0, ptype1).val[0];
+
+	etqf_check = vandq_u32(ptype0, etqf_mask);
+	tunnel_check = vandq_u32(ptype0, tunnel_mask);
+
+	ptype0 = vandq_u32(vshrq_n_u32(ptype0, SXE_PACKET_TYPE_SHIFT),
+			ptype_mask);
+
+	rx_pkts[0]->packet_type =
+		sxe_get_packet_type(vgetq_lane_u32(ptype0, 0),
+				vgetq_lane_u32(etqf_check, 0),
+				vgetq_lane_u32(tunnel_check, 0));
+	rx_pkts[1]->packet_type =
+		sxe_get_packet_type(vgetq_lane_u32(ptype0, 1),
+				vgetq_lane_u32(etqf_check, 1),
+				vgetq_lane_u32(tunnel_check, 1));
+	rx_pkts[2]->packet_type =
+		sxe_get_packet_type(vgetq_lane_u32(ptype0, 2),
+				vgetq_lane_u32(etqf_check, 2),
+				vgetq_lane_u32(tunnel_check, 2));
+	rx_pkts[3]->packet_type =
+		sxe_get_packet_type(vgetq_lane_u32(ptype0, 3),
+				vgetq_lane_u32(etqf_check, 3),
+				vgetq_lane_u32(tunnel_check, 3));
+}
+
+static inline u16
+sxe_recv_raw_pkts_vec(struct sxe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+		   u16 nb_pkts, u8 *split_packet)
+{
+	volatile union sxe_rx_data_desc *rxdp;
+	struct sxe_rx_buffer *sw_ring;
+	u16 nb_pkts_recd;
+	s32 pos;
+	u16 rte;
+	uint8x16_t shuf_msk = {
+		0xFF, 0xFF,
+		0xFF, 0xFF,
+		12, 13,
+		0xFF, 0xFF,
+		12, 13,
+		14, 15,
+		4, 5, 6, 7
+		};
+	uint16x8_t crc_adjust = {0, 0, rxq->crc_len, 0,
+				 rxq->crc_len, 0, 0, 0};
+
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_SXE_DESCS_PER_LOOP);
+
+	rxdp = rxq->desc_ring + rxq->processing_idx;
+
+	rte_prefetch_non_temporal(rxdp);
+
+	if (rxq->realloc_num > RTE_PMD_SXE_MAX_RX_BURST)
+		sxe_rxq_rearm(rxq);
+
+	if (!(rxdp->wb.upper.status_error &
+				rte_cpu_to_le_32(SXE_RXDADV_STAT_DD))) {
+		rte = 0;
+		goto out;
+	}
+
+	sw_ring = &rxq->buffer_ring[rxq->processing_idx];
+
+	RTE_BUILD_BUG_ON((RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED) > UINT8_MAX);
+
+	u16 udp_p_flag = SXE_RXDADV_PKTTYPE_UDP;
+	u8 vlan_flags = rxq->vlan_flags & UINT8_MAX;
+
+	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
+			pos += RTE_SXE_DESCS_PER_LOOP,
+			rxdp += RTE_SXE_DESCS_PER_LOOP) {
+		uint64x2_t descs[RTE_SXE_DESCS_PER_LOOP];
+		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
+		uint8x16x2_t sterr_tmp1, sterr_tmp2;
+		uint64x2_t mbp1, mbp2;
+		uint8x16_t staterr;
+		uint16x8_t tmp;
+		u32 stat;
+
+		mbp1 = vld1q_u64((u64 *)&sw_ring[pos]);
+
+		vst1q_u64((u64 *)&rx_pkts[pos], mbp1);
+
+		mbp2 = vld1q_u64((u64 *)&sw_ring[pos + 2]);
+
+		descs[0] =  vld1q_u64(RTE_CAST_PTR(u64 *, (rxdp)));
+		descs[1] =  vld1q_u64(RTE_CAST_PTR(u64 *, (rxdp + 1)));
+		descs[2] =  vld1q_u64(RTE_CAST_PTR(u64 *, (rxdp + 2)));
+		descs[3] =  vld1q_u64(RTE_CAST_PTR(u64 *, (rxdp + 3)));
+
+		vst1q_u64((u64 *)&rx_pkts[pos + 2], mbp2);
+
+		if (split_packet) {
+			rte_mbuf_prefetch_part2(rx_pkts[pos]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 1]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 2]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 3]);
+		}
+
+		pkt_mb4 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[3]), shuf_msk);
+		pkt_mb3 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[2]), shuf_msk);
+
+		pkt_mb2 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[1]), shuf_msk);
+		pkt_mb1 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[0]), shuf_msk);
+
+		sterr_tmp2 = vzipq_u8(vreinterpretq_u8_u64(descs[1]),
+					  vreinterpretq_u8_u64(descs[3]));
+		sterr_tmp1 = vzipq_u8(vreinterpretq_u8_u64(descs[0]),
+					  vreinterpretq_u8_u64(descs[2]));
+
+		staterr = vzipq_u8(sterr_tmp1.val[1], sterr_tmp2.val[1]).val[0];
+
+		sxe_desc_to_olflags_v(sterr_tmp1, sterr_tmp2, staterr, vlan_flags,
+				  udp_p_flag, &rx_pkts[pos]);
+
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb4), crc_adjust);
+		pkt_mb4 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb3), crc_adjust);
+		pkt_mb3 = vreinterpretq_u8_u16(tmp);
+
+		vst1q_u8((void *)&rx_pkts[pos + 3]->rx_descriptor_fields1,
+			 pkt_mb4);
+		vst1q_u8((void *)&rx_pkts[pos + 2]->rx_descriptor_fields1,
+			 pkt_mb3);
+
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb2), crc_adjust);
+		pkt_mb2 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb1), crc_adjust);
+		pkt_mb1 = vreinterpretq_u8_u16(tmp);
+
+		if (split_packet) {
+			stat = vgetq_lane_u32(vreinterpretq_u32_u8(staterr), 0);
+			*(s32 *)split_packet = ~stat & SXE_VPMD_DESC_EOP_MASK;
+
+			split_packet += RTE_SXE_DESCS_PER_LOOP;
+		}
+
+		staterr = vshlq_n_u8(staterr, SXE_UINT8_BIT - 1);
+		staterr = vreinterpretq_u8_s8
+				(vshrq_n_s8(vreinterpretq_s8_u8(staterr),
+					SXE_UINT8_BIT - 1));
+		stat = ~vgetq_lane_u32(vreinterpretq_u32_u8(staterr), 0);
+
+		rte_prefetch_non_temporal(rxdp + RTE_SXE_DESCS_PER_LOOP);
+
+		vst1q_u8((u8 *)&rx_pkts[pos + 1]->rx_descriptor_fields1,
+			 pkt_mb2);
+		vst1q_u8((u8 *)&rx_pkts[pos]->rx_descriptor_fields1,
+			 pkt_mb1);
+
+		sxe_desc_to_ptype_v(descs, rxq->pkt_type_mask, &rx_pkts[pos]);
+
+		if (unlikely(stat == 0)) {
+			nb_pkts_recd += RTE_SXE_DESCS_PER_LOOP;
+		} else {
+			nb_pkts_recd += rte_ctz32(stat) / SXE_UINT8_BIT;
+			break;
+		}
+	}
+
+	rxq->processing_idx = (u16)(rxq->processing_idx + nb_pkts_recd);
+	rxq->processing_idx = (u16)(rxq->processing_idx & (rxq->ring_depth - 1));
+	rxq->realloc_num = (u16)(rxq->realloc_num + nb_pkts_recd);
+
+	rte = nb_pkts_recd;
+
+out:
+	return rte;
+}
+
+u16 sxe_pkts_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	return sxe_recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
+}
+
+static u16 sxe_recv_scattered_burst_vec(void *rx_queue,
+			struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	u32 i = 0;
+	struct sxe_rx_queue *rxq = rx_queue;
+	u8 split_flags[RTE_PMD_SXE_MAX_RX_BURST] = {0};
+
+	u16 nb_bufs = sxe_recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
+			split_flags);
+	if (nb_bufs == 0)
+		goto l_out;
+
+	const u64 *split_fl64 = (u64 *)split_flags;
+	if (rxq->pkt_first_seg == NULL &&
+			split_fl64[0] == 0 && split_fl64[1] == 0 &&
+			split_fl64[2] == 0 && split_fl64[3] == 0)
+		goto l_out;
+
+	if (rxq->pkt_first_seg == NULL) {
+		while (i < nb_bufs && !split_flags[i])
+			i++;
+		if (i == nb_bufs)
+			goto l_out;
+		rxq->pkt_first_seg = rx_pkts[i];
+	}
+
+	nb_bufs = i + sxe_packets_reassemble(rxq, &rx_pkts[i], nb_bufs - i,
+		&split_flags[i]);
+
+l_out:
+	return nb_bufs;
+}
+
+u16
+sxe_scattered_pkts_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts,
+				  u16 nb_pkts)
+{
+	u16 retval = 0;
+
+	while (nb_pkts > RTE_PMD_SXE_MAX_RX_BURST) {
+		u16 burst;
+
+		burst = sxe_recv_scattered_burst_vec(rx_queue,
+							   rx_pkts + retval,
+							   RTE_PMD_SXE_MAX_RX_BURST);
+		retval += burst;
+		nb_pkts -= burst;
+		if (burst < RTE_PMD_SXE_MAX_RX_BURST)
+			goto l_out;
+	}
+
+	retval += sxe_recv_scattered_burst_vec(rx_queue,
+						rx_pkts + retval,
+						nb_pkts);
+l_out:
+	return retval;
+}
+
+static inline void
+sxe_single_vec_desc_fill(volatile union sxe_tx_data_desc *txdp,
+		struct rte_mbuf *pkt, u64 flags)
+{
+	uint64x2_t descriptor = {
+			pkt->buf_iova + pkt->data_off,
+			(u64)pkt->pkt_len << 46 | flags | pkt->data_len};
+
+	vst1q_u64(RTE_CAST_PTR(u64 *, &txdp->read), descriptor);
+}
+
+static inline void
+sxe_vec_desc_fill(volatile union sxe_tx_data_desc *txdp,
+		struct rte_mbuf **pkt, u16 nb_pkts,  u64 flags)
+{
+	s32 i;
+
+	for (i = 0; i < nb_pkts; ++i, ++txdp, ++pkt)
+		sxe_single_vec_desc_fill(txdp, *pkt, flags);
+}
+
+u16 __sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
+			   u16 nb_pkts)
+{
+	struct sxe_tx_queue *txq = (struct sxe_tx_queue *)tx_queue;
+	volatile union sxe_tx_data_desc *txdp;
+	struct sxe_tx_buffer_vec *txep;
+	u16 n, nb_commit, tx_id;
+	u64 flags = SXE_TX_DESC_FLAGS;
+	u64 rs = SXE_TX_DESC_RS_MASK | SXE_TX_DESC_FLAGS;
+	s32 i;
+
+	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+
+	if (txq->desc_free_num < txq->free_thresh)
+		sxe_tx_bufs_vec_free(txq);
+
+	nb_pkts = (u16)RTE_MIN(txq->desc_free_num, nb_pkts);
+	nb_commit = nb_pkts;
+	if (unlikely(nb_pkts == 0))
+		goto l_out;
+
+	tx_id = txq->next_to_use;
+	txdp = &txq->desc_ring[tx_id];
+	txep = &txq->buffer_ring_vec[tx_id];
+
+	txq->desc_free_num = (u16)(txq->desc_free_num - nb_pkts);
+
+	n = (u16)(txq->ring_depth - tx_id);
+	if (nb_commit >= n) {
+		sxe_vec_mbuf_fill(txep, tx_pkts, n);
+
+		for (i = 0; i < n - 1; ++i, ++tx_pkts, ++txdp)
+			sxe_single_vec_desc_fill(txdp, *tx_pkts, flags);
+
+		sxe_single_vec_desc_fill(txdp, *tx_pkts++, rs);
+
+		nb_commit = (u16)(nb_commit - n);
+
+		tx_id = 0;
+		txq->next_rs = (u16)(txq->rs_thresh - 1);
+
+		txdp = &txq->desc_ring[tx_id];
+		txep = &txq->buffer_ring_vec[tx_id];
+	}
+
+	sxe_vec_mbuf_fill(txep, tx_pkts, nb_commit);
+	sxe_vec_desc_fill(txdp, tx_pkts, nb_commit, flags);
+
+	tx_id = (u16)(tx_id + nb_commit);
+	if (tx_id > txq->next_rs) {
+		txq->desc_ring[txq->next_rs].read.cmd_type_len |=
+			rte_cpu_to_le_32(SXE_TX_DESC_RS_MASK);
+		txq->next_rs = (u16)(txq->next_rs +
+			txq->rs_thresh);
+	}
+
+	txq->next_to_use = tx_id;
+
+	sxe_write_addr(txq->next_to_use, txq->tdt_reg_addr);
+
+l_out:
+	return nb_pkts;
+}
+
+static void __rte_cold
+sxe_tx_queue_release_mbufs_vec(struct sxe_tx_queue *txq)
+{
+	sxe_tx_mbufs_vec_release(txq);
+}
+
+void __rte_cold
+sxe_rx_queue_vec_mbufs_release(struct sxe_rx_queue *rxq)
+{
+	sxe_rx_vec_mbufs_release(rxq);
+}
+
+static void __rte_cold
+sxe_tx_free_swring(struct sxe_tx_queue *txq)
+{
+	sxe_tx_buffer_ring_vec_free(txq);
+}
+
+static void __rte_cold
+sxe_reset_tx_queue(struct sxe_tx_queue *txq)
+{
+	sxe_tx_queue_vec_init(txq);
+}
+
+static const struct sxe_txq_ops vec_txq_ops = {
+	.init = sxe_reset_tx_queue,
+	.mbufs_release = sxe_tx_queue_release_mbufs_vec,
+	.buffer_ring_free = sxe_tx_free_swring,
+};
+
+s32 __rte_cold
+sxe_rxq_vec_setup(struct sxe_rx_queue *rxq)
+{
+	return sxe_default_rxq_vec_setup(rxq);
+}
+
+s32 __rte_cold
+sxe_txq_vec_setup(struct sxe_tx_queue *txq)
+{
+	return sxe_default_txq_vec_setup(txq, &vec_txq_ops);
+}
+
+s32 __rte_cold
+sxe_rx_vec_condition_check(struct rte_eth_dev *dev)
+{
+	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
+
+	if (rxmode->offloads & DEV_RX_OFFLOAD_CHECKSUM)
+		return -1;
+
+	return sxe_default_rx_vec_condition_check(dev);
+}
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_vec_sse.c b/drivers/net/sxe/pf/sxe_vec_sse.c
new file mode 100644
index 0000000000..3d687f33df
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_vec_sse.c
@@ -0,0 +1,622 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include <stdint.h>
+#include <ethdev_driver.h>
+#include <rte_malloc.h>
+#include <rte_vect.h>
+
+#include "sxe_vec_common.h"
+#include "sxe_compat_version.h"
+
+#define SXE_MAX_TX_FREE_BUF_SZ 64
+
+static inline void
+sxe_rxq_realloc(sxe_rx_queue_s *rx_queue)
+{
+	s32 i;
+	u16 rx_index;
+	volatile union sxe_rx_data_desc *desc_ring;
+	sxe_rx_buffer_s *buf_ring =
+			&rx_queue->buffer_ring[rx_queue->realloc_start];
+	struct rte_mbuf *mbuf_0, *mbuf_1;
+	__m128i head_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
+			RTE_PKTMBUF_HEADROOM);
+	__m128i dma_addr0, dma_addr1;
+
+	const __m128i addr_mask = _mm_set_epi64x(0, UINT64_MAX);
+
+	desc_ring = rx_queue->desc_ring + rx_queue->realloc_start;
+
+	if (rte_mempool_get_bulk(rx_queue->mb_pool,
+				 (void *)buf_ring,
+				 RTE_PMD_SXE_MAX_RX_BURST) < 0) {
+		if (rx_queue->realloc_num + RTE_PMD_SXE_MAX_RX_BURST >=
+			rx_queue->ring_depth) {
+			dma_addr0 = _mm_setzero_si128();
+			for (i = 0; i < SXE_DESCS_PER_LOOP; i++) {
+				buf_ring[i].mbuf = &rx_queue->fake_mbuf;
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc_ring[i].read),
+						dma_addr0);
+			}
+		}
+		rte_eth_devices[rx_queue->port_id].data->rx_mbuf_alloc_failed +=
+			RTE_PMD_SXE_MAX_RX_BURST;
+		return;
+	}
+
+	for (i = 0; i < RTE_PMD_SXE_MAX_RX_BURST; i += 2, buf_ring += 2) {
+		__m128i vaddr0, vaddr1;
+
+		mbuf_0 = buf_ring[0].mbuf;
+		mbuf_1 = buf_ring[1].mbuf;
+
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+
+		vaddr0 = _mm_loadu_si128((__m128i *)&mbuf_0->buf_addr);
+		vaddr1 = _mm_loadu_si128((__m128i *)&mbuf_1->buf_addr);
+
+		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
+		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
+
+		dma_addr0 = _mm_add_epi64(dma_addr0, head_room);
+		dma_addr1 = _mm_add_epi64(dma_addr1, head_room);
+
+		dma_addr0 = _mm_and_si128(dma_addr0, addr_mask);
+		dma_addr1 = _mm_and_si128(dma_addr1, addr_mask);
+
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc_ring++->read), dma_addr0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc_ring++->read), dma_addr1);
+	}
+
+	rx_queue->realloc_start += RTE_PMD_SXE_MAX_RX_BURST;
+	if (rx_queue->realloc_start >= rx_queue->ring_depth)
+		rx_queue->realloc_start = 0;
+
+	rx_queue->realloc_num -= RTE_PMD_SXE_MAX_RX_BURST;
+
+	rx_index = (u16)((rx_queue->realloc_start == 0) ?
+			(rx_queue->ring_depth - 1) : (rx_queue->realloc_start - 1));
+
+	SXE_PCI_REG_WC_WRITE_RELAXED(rx_queue->rdt_reg_addr, rx_index);
+}
+
+static inline void
+sxe_desc_to_olflags(__m128i descs[4], __m128i mbuf_init, u8 vlan_flags,
+			u16 udp_p_flag, struct rte_mbuf **rx_pkts)
+{
+	__m128i ptype0, ptype1, vtype0, vtype1, csum, udp_csum_skip;
+	__m128i rearm0, rearm1, rearm2, rearm3;
+
+	const __m128i rsstype_mask = _mm_set_epi16
+			(0x0000, 0x0000, 0x0000, 0x0000,
+			0x000F, 0x000F, 0x000F, 0x000F);
+
+	const __m128i ol_flags_mask = _mm_set_epi16
+			(0x0000, 0x0000, 0x0000, 0x0000,
+			0x00FF, 0x00FF, 0x00FF, 0x00FF);
+
+	const __m128i rss_flags = _mm_set_epi8(RTE_MBUF_F_RX_FDIR, 0, 0, 0,
+			0, 0, 0, RTE_MBUF_F_RX_RSS_HASH,
+			RTE_MBUF_F_RX_RSS_HASH, 0, RTE_MBUF_F_RX_RSS_HASH, 0,
+			RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_RSS_HASH, 0);
+
+	const __m128i vlan_csum_mask = _mm_set_epi16
+		((SXE_RXDADV_ERR_L4E | SXE_RXDADV_ERR_IPE) >> 16,
+		(SXE_RXDADV_ERR_L4E | SXE_RXDADV_ERR_IPE) >> 16,
+		(SXE_RXDADV_ERR_L4E | SXE_RXDADV_ERR_IPE) >> 16,
+		(SXE_RXDADV_ERR_L4E | SXE_RXDADV_ERR_IPE) >> 16,
+		SXE_RXD_STAT_VP, SXE_RXD_STAT_VP,
+		SXE_RXD_STAT_VP, SXE_RXD_STAT_VP);
+
+	const __m128i vlan_csum_map_low = _mm_set_epi8
+		(0, 0, 0, 0,
+		vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+		vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_BAD,
+		vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+		vlan_flags | RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+		0, 0, 0, 0,
+		RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_GOOD);
+
+	const __m128i vlan_csum_map_high = _mm_set_epi8
+		(0, 0, 0, 0,
+		0, RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8), 0,
+		RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8),
+		0, 0, 0, 0,
+		0, RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8), 0,
+		RTE_MBUF_F_RX_L4_CKSUM_GOOD >> sizeof(u8));
+
+	const __m128i udp_hdr_p_msk = _mm_set_epi16
+		(0, 0, 0, 0,
+		 udp_p_flag, udp_p_flag, udp_p_flag, udp_p_flag);
+
+	const __m128i udp_csum_bad_shuf = _mm_set_epi8
+		(0, 0, 0, 0, 0, 0, 0, 0,
+		 0, 0, 0, 0, 0, 0, ~(u8)RTE_MBUF_F_RX_L4_CKSUM_BAD, 0xFF);
+
+	ptype0 = _mm_unpacklo_epi16(descs[0], descs[1]);
+	ptype1 = _mm_unpacklo_epi16(descs[2], descs[3]);
+
+	vtype0 = _mm_unpackhi_epi16(descs[0], descs[1]);
+	vtype1 = _mm_unpackhi_epi16(descs[2], descs[3]);
+
+	ptype0 = _mm_unpacklo_epi32(ptype0, ptype1);
+
+	udp_csum_skip = _mm_and_si128(ptype0, udp_hdr_p_msk);
+
+	ptype0 = _mm_and_si128(ptype0, rsstype_mask);
+
+	ptype0 = _mm_shuffle_epi8(rss_flags, ptype0);
+
+	vtype1 = _mm_unpacklo_epi32(vtype0, vtype1);
+	vtype1 = _mm_and_si128(vtype1, vlan_csum_mask);
+
+	csum = _mm_srli_epi16(vtype1, 14);
+
+	csum = _mm_srli_si128(csum, 8);
+	vtype1 = _mm_or_si128(csum, vtype1);
+
+	vtype0 = _mm_shuffle_epi8(vlan_csum_map_high, vtype1);
+	vtype0 = _mm_slli_epi16(vtype0, sizeof(u8));
+
+	vtype1 = _mm_shuffle_epi8(vlan_csum_map_low, vtype1);
+	vtype1 = _mm_and_si128(vtype1, ol_flags_mask);
+	vtype1 = _mm_or_si128(vtype0, vtype1);
+
+	vtype1 = _mm_or_si128(ptype0, vtype1);
+
+	udp_csum_skip = _mm_srli_epi16(udp_csum_skip, 9);
+	udp_csum_skip = _mm_shuffle_epi8(udp_csum_bad_shuf, udp_csum_skip);
+	vtype1 = _mm_and_si128(vtype1, udp_csum_skip);
+
+	rearm0 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(vtype1, 8), 0x10);
+	rearm1 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(vtype1, 6), 0x10);
+	rearm2 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(vtype1, 4), 0x10);
+	rearm3 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(vtype1, 2), 0x10);
+
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
+			offsetof(struct rte_mbuf, rearm_data) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
+			RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
+
+	_mm_store_si128((__m128i *)&rx_pkts[0]->rearm_data, rearm0);
+	_mm_store_si128((__m128i *)&rx_pkts[1]->rearm_data, rearm1);
+	_mm_store_si128((__m128i *)&rx_pkts[2]->rearm_data, rearm2);
+	_mm_store_si128((__m128i *)&rx_pkts[3]->rearm_data, rearm3);
+}
+
+static inline u32 sxe_packet_type_get(int index,
+					u32 pkt_info,
+					u32 etqf_check)
+{
+	if (etqf_check & (0x02 << (index * SXE_DESCS_PER_LOOP)))
+		return RTE_PTYPE_UNKNOWN;
+
+	pkt_info &= SXE_PACKET_TYPE_MASK;
+	return sxe_ptype_table[pkt_info];
+}
+
+static inline void
+sxe_desc_to_ptype_vec(__m128i descs[4], u16 pkt_type_mask,
+		struct rte_mbuf **rx_pkts)
+{
+	__m128i etqf_mask = _mm_set_epi64x(0x800000008000LL, 0x800000008000LL);
+	__m128i ptype_mask = _mm_set_epi32(pkt_type_mask,
+			pkt_type_mask, pkt_type_mask, pkt_type_mask);
+
+	u32 etqf_check, pkt_info;
+
+	__m128i ptype0 = _mm_unpacklo_epi32(descs[0], descs[2]);
+	__m128i ptype1 = _mm_unpacklo_epi32(descs[1], descs[3]);
+
+	ptype0 = _mm_unpacklo_epi32(ptype0, ptype1);
+
+	etqf_check = _mm_movemask_epi8(_mm_and_si128(ptype0, etqf_mask));
+
+	ptype0 = _mm_and_si128(_mm_srli_epi32(ptype0, SXE_RXDADV_PKTTYPE_ETQF_SHIFT),
+				   ptype_mask);
+
+
+	pkt_info = _mm_extract_epi32(ptype0, 0);
+	rx_pkts[0]->packet_type =
+		sxe_packet_type_get(0, pkt_info, etqf_check);
+	pkt_info = _mm_extract_epi32(ptype0, 1);
+	rx_pkts[1]->packet_type =
+		sxe_packet_type_get(1, pkt_info, etqf_check);
+	pkt_info = _mm_extract_epi32(ptype0, 2);
+	rx_pkts[2]->packet_type =
+		sxe_packet_type_get(2, pkt_info, etqf_check);
+	pkt_info = _mm_extract_epi32(ptype0, 3);
+	rx_pkts[3]->packet_type =
+		sxe_packet_type_get(3, pkt_info, etqf_check);
+}
+
+static inline u16
+sxe_raw_pkts_vec_recv(sxe_rx_queue_s *rx_queue, struct rte_mbuf **rx_pkts,
+		u16 pkts_num, u8 *split_packet)
+{
+	volatile union sxe_rx_data_desc *desc_ring;
+	sxe_rx_buffer_s *buffer_ring;
+	u16 pkts_recd_num;
+	s32 pos;
+	u64 var;
+	__m128i shuf_msk;
+	__m128i crc_adjust = _mm_set_epi16
+				(0, 0, 0,
+				-rx_queue->crc_len,
+				0,
+				-rx_queue->crc_len,
+				0, 0
+			);
+
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+	__m128i dd_check, eop_check;
+	__m128i mbuf_init;
+	u8 vlan_flags;
+	u16 udp_p_flag = 0;
+
+	pkts_num = RTE_MIN(pkts_num, RTE_PMD_SXE_MAX_RX_BURST);
+
+	pkts_num = RTE_ALIGN_FLOOR(pkts_num, SXE_DESCS_PER_LOOP);
+
+	desc_ring = rx_queue->desc_ring + rx_queue->processing_idx;
+
+	rte_prefetch0(desc_ring);
+
+	if (rx_queue->realloc_num > RTE_PMD_SXE_MAX_RX_BURST)
+		sxe_rxq_realloc(rx_queue);
+
+	if (!(desc_ring->wb.upper.status_error &
+				rte_cpu_to_le_32(SXE_RXDADV_STAT_DD))) {
+		pkts_recd_num = 0;
+		goto l_out;
+	}
+
+	udp_p_flag = SXE_RXDADV_PKTTYPE_UDP;
+
+	dd_check = _mm_set_epi64x(0x0000000100000001LL, 0x0000000100000001LL);
+
+	eop_check = _mm_set_epi64x(0x0000000200000002LL, 0x0000000200000002LL);
+
+	shuf_msk = _mm_set_epi8
+		(7, 6, 5, 4,
+		15, 14,
+		13, 12,
+		0xFF, 0xFF,
+		13, 12,
+		0xFF, 0xFF,
+		0xFF, 0xFF
+		);
+
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
+
+	mbuf_init = _mm_set_epi64x(0, rx_queue->mbuf_init_value);
+
+	buffer_ring = &rx_queue->buffer_ring[rx_queue->processing_idx];
+
+	RTE_BUILD_BUG_ON((RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED) > UINT8_MAX);
+	vlan_flags = rx_queue->vlan_flags & UINT8_MAX;
+
+	for (pos = 0, pkts_recd_num = 0; pos < pkts_num;
+			pos += SXE_DESCS_PER_LOOP,
+			desc_ring += SXE_DESCS_PER_LOOP) {
+		__m128i descs[SXE_DESCS_PER_LOOP];
+		__m128i pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
+		__m128i zero, staterr, state_err1, state_err2;
+		__m128i mbp1;
+#if defined(RTE_ARCH_X86_64)
+		__m128i mbp2;
+#endif
+
+		mbp1 = _mm_loadu_si128((__m128i *)&buffer_ring[pos]);
+
+		descs[3] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, (desc_ring + 3)));
+		rte_compiler_barrier();
+
+		_mm_storeu_si128((__m128i *)&rx_pkts[pos], mbp1);
+
+#if defined(RTE_ARCH_X86_64)
+		mbp2 = _mm_loadu_si128((__m128i *)&buffer_ring[pos + 2]);
+#endif
+
+		descs[2] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, (desc_ring + 2)));
+		rte_compiler_barrier();
+		descs[1] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, (desc_ring + 1)));
+		rte_compiler_barrier();
+		descs[0] = _mm_loadu_si128(RTE_CAST_PTR(__m128i *, (desc_ring)));
+
+#if defined(RTE_ARCH_X86_64)
+		_mm_storeu_si128((__m128i *)&rx_pkts[pos + 2], mbp2);
+#endif
+
+		if (split_packet) {
+			rte_mbuf_prefetch_part2(rx_pkts[pos]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 1]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 2]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 3]);
+		}
+
+		rte_compiler_barrier();
+
+		pkt_mb4 = _mm_shuffle_epi8(descs[3], shuf_msk);
+		pkt_mb3 = _mm_shuffle_epi8(descs[2], shuf_msk);
+		pkt_mb2 = _mm_shuffle_epi8(descs[1], shuf_msk);
+		pkt_mb1 = _mm_shuffle_epi8(descs[0], shuf_msk);
+
+		state_err2 = _mm_unpackhi_epi32(descs[3], descs[2]);
+		state_err1 = _mm_unpackhi_epi32(descs[1], descs[0]);
+
+		sxe_desc_to_olflags(descs, mbuf_init, vlan_flags, udp_p_flag,
+					&rx_pkts[pos]);
+
+		pkt_mb4 = _mm_add_epi16(pkt_mb4, crc_adjust);
+		pkt_mb3 = _mm_add_epi16(pkt_mb3, crc_adjust);
+
+		zero = _mm_xor_si128(dd_check, dd_check);
+
+		staterr = _mm_unpacklo_epi32(state_err1, state_err2);
+
+		_mm_storeu_si128((void *)&rx_pkts[pos + 3]->rx_descriptor_fields1,
+				pkt_mb4);
+		_mm_storeu_si128((void *)&rx_pkts[pos + 2]->rx_descriptor_fields1,
+				pkt_mb3);
+
+		pkt_mb2 = _mm_add_epi16(pkt_mb2, crc_adjust);
+		pkt_mb1 = _mm_add_epi16(pkt_mb1, crc_adjust);
+
+		if (split_packet) {
+			__m128i eop_shuf_mask = _mm_set_epi8
+				(0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF,
+				0x04, 0x0C, 0x00, 0x08
+				);
+
+			__m128i eop_bits = _mm_andnot_si128(staterr, eop_check);
+			eop_bits = _mm_shuffle_epi8(eop_bits, eop_shuf_mask);
+			*(int *)split_packet = _mm_cvtsi128_si32(eop_bits);
+			split_packet += SXE_DESCS_PER_LOOP;
+		}
+
+		staterr = _mm_and_si128(staterr, dd_check);
+
+		staterr = _mm_packs_epi32(staterr, zero);
+
+		_mm_storeu_si128((void *)&rx_pkts[pos + 1]->rx_descriptor_fields1,
+				pkt_mb2);
+		_mm_storeu_si128((void *)&rx_pkts[pos]->rx_descriptor_fields1,
+				pkt_mb1);
+
+		sxe_desc_to_ptype_vec(descs, rx_queue->pkt_type_mask, &rx_pkts[pos]);
+		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
+		pkts_recd_num += var;
+		if (likely(var != SXE_DESCS_PER_LOOP))
+			break;
+	}
+
+	rx_queue->processing_idx = (u16)(rx_queue->processing_idx + pkts_recd_num);
+	rx_queue->processing_idx = (u16)(rx_queue->processing_idx & (rx_queue->ring_depth - 1));
+	rx_queue->realloc_num = (u16)(rx_queue->realloc_num + pkts_recd_num);
+
+l_out:
+	return pkts_recd_num;
+}
+
+u16
+sxe_pkts_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 pkts_num)
+{
+	return sxe_raw_pkts_vec_recv(rx_queue, rx_pkts, pkts_num, NULL);
+}
+
+static u16
+sxe_scattered_burst_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts,
+				u16 pkts_num)
+{
+	u16 i = 0;
+	u16 bufs_num;
+	sxe_rx_queue_s *rxq = rx_queue;
+	u8 split_flags[RTE_PMD_SXE_MAX_RX_BURST] = {0};
+
+	bufs_num = sxe_raw_pkts_vec_recv(rxq, rx_pkts, pkts_num,
+			split_flags);
+	if (bufs_num == 0)
+		goto l_out;
+
+	const u64 *split_flag_64 = (u64 *)split_flags;
+	if (rxq->pkt_first_seg == NULL &&
+		split_flag_64[0] == 0 && split_flag_64[1] == 0 &&
+		split_flag_64[2] == 0 && split_flag_64[3] == 0)
+		goto l_out;
+
+	if (rxq->pkt_first_seg == NULL) {
+		while (i < bufs_num && !split_flags[i])
+			i++;
+		if (i == bufs_num)
+			goto l_out;
+		rxq->pkt_first_seg = rx_pkts[i];
+	}
+
+	bufs_num = i + sxe_packets_reassemble(rxq, &rx_pkts[i], bufs_num - i,
+		&split_flags[i]);
+
+l_out:
+	return bufs_num;
+}
+
+u16
+sxe_scattered_pkts_vec_recv(void *rx_queue, struct rte_mbuf **rx_pkts,
+				  u16 pkts_num)
+{
+	u16 ret = 0;
+
+	while (pkts_num > RTE_PMD_SXE_MAX_RX_BURST) {
+		u16 burst;
+
+		burst = sxe_scattered_burst_vec_recv(rx_queue,
+						rx_pkts + ret,
+						RTE_PMD_SXE_MAX_RX_BURST);
+		ret += burst;
+		pkts_num -= burst;
+		if (burst < RTE_PMD_SXE_MAX_RX_BURST)
+			goto l_out;
+	}
+
+	ret += sxe_scattered_burst_vec_recv(rx_queue,
+					rx_pkts + ret,
+					pkts_num);
+l_out:
+	return ret;
+}
+
+void __rte_cold
+sxe_rx_queue_vec_mbufs_release(sxe_rx_queue_s *rx_queue)
+{
+	sxe_rx_vec_mbufs_release(rx_queue);
+}
+
+s32 __rte_cold
+sxe_rxq_vec_setup(sxe_rx_queue_s *rx_queue)
+{
+	return sxe_default_rxq_vec_setup(rx_queue);
+}
+
+s32 __rte_cold
+sxe_rx_vec_condition_check(struct rte_eth_dev *dev)
+{
+	return sxe_default_rx_vec_condition_check(dev);
+}
+
+static inline void
+sxe_single_vec_desc_fill(volatile sxe_tx_data_desc_u *desc_ring,
+		struct rte_mbuf *pkts, u64 flags)
+{
+	__m128i descriptor = _mm_set_epi64x((u64)pkts->pkt_len << 46 |
+			flags | pkts->data_len,
+			pkts->buf_iova + pkts->data_off);
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc_ring->read), descriptor);
+}
+
+static inline void
+sxe_vec_desc_fill(volatile sxe_tx_data_desc_u *desc_ring,
+		struct rte_mbuf **pkts, u16 pkts_num, u64 flags)
+{
+	s32 i;
+
+	for (i = 0; i < pkts_num; ++i, ++desc_ring, ++pkts)
+		sxe_single_vec_desc_fill(desc_ring, *pkts, flags);
+}
+
+u16
+__sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
+			   u16 pkts_num)
+{
+	sxe_tx_queue_s *txq = (sxe_tx_queue_s *)tx_queue;
+	volatile sxe_tx_data_desc_u *desc_ring;
+	struct sxe_tx_buffer_vec *buffer_ring;
+	u16 n, commit_num, ntu, xmit_pkts_num;
+	u64 flags = SXE_TX_DESC_FLAGS;
+	u64 rs_flags = SXE_TX_DESC_RS_MASK | SXE_TX_DESC_FLAGS;
+	s32 i;
+
+	if (txq->desc_free_num < txq->free_thresh)
+		sxe_tx_bufs_vec_free(txq);
+
+	xmit_pkts_num = RTE_MIN(pkts_num, txq->rs_thresh);
+	xmit_pkts_num = (u16)RTE_MIN(txq->desc_free_num, xmit_pkts_num);
+
+	commit_num = xmit_pkts_num;
+	if (unlikely(commit_num == 0))
+		goto l_out;
+
+	ntu = txq->next_to_use;
+	desc_ring = &txq->desc_ring[ntu];
+	buffer_ring = &txq->buffer_ring_vec[ntu];
+
+	txq->desc_free_num = (u16)(txq->desc_free_num - xmit_pkts_num);
+
+	n = (u16)(txq->ring_depth - ntu);
+	if (commit_num >= n) {
+		sxe_vec_mbuf_fill(buffer_ring, tx_pkts, n);
+
+		for (i = 0; i < n - 1; ++i, ++tx_pkts, ++desc_ring)
+			sxe_single_vec_desc_fill(desc_ring, *tx_pkts, flags);
+
+		sxe_single_vec_desc_fill(desc_ring, *tx_pkts++, rs_flags);
+
+		commit_num = (u16)(commit_num - n);
+
+		ntu = 0;
+		txq->next_rs = (u16)(txq->rs_thresh - 1);
+
+		desc_ring = &txq->desc_ring[ntu];
+		buffer_ring = &txq->buffer_ring_vec[ntu];
+	}
+
+	sxe_vec_mbuf_fill(buffer_ring, tx_pkts, commit_num);
+
+	sxe_vec_desc_fill(desc_ring, tx_pkts, commit_num, flags);
+
+	ntu = (u16)(ntu + commit_num);
+	if (ntu > txq->next_rs) {
+		txq->desc_ring[txq->next_rs].read.cmd_type_len |=
+			rte_cpu_to_le_32(SXE_TX_DESC_RS_MASK);
+		txq->next_rs = (u16)(txq->next_rs +
+			txq->rs_thresh);
+	}
+
+	txq->next_to_use = ntu;
+	rte_wmb();
+	rte_write32_wc_relaxed((rte_cpu_to_le_32(txq->next_to_use)),
+							txq->tdt_reg_addr);
+
+l_out:
+	return xmit_pkts_num;
+}
+
+static void __rte_cold
+sxe_tx_queue_init(sxe_tx_queue_s *tx_queue)
+{
+	sxe_tx_queue_vec_init(tx_queue);
+}
+
+static void __rte_cold
+sxe_tx_queue_mbufs_release(sxe_tx_queue_s *tx_queue)
+{
+	sxe_tx_mbufs_vec_release(tx_queue);
+}
+
+static void __rte_cold
+sxe_tx_buffer_ring_free(sxe_tx_queue_s *tx_queue)
+{
+	sxe_tx_buffer_ring_vec_free(tx_queue);
+}
+
+static const struct sxe_txq_ops txq_vec_ops = {
+	.init			 = sxe_tx_queue_init,
+	.mbufs_release	= sxe_tx_queue_mbufs_release,
+	.buffer_ring_free = sxe_tx_buffer_ring_free,
+};
+
+s32 __rte_cold
+sxe_txq_vec_setup(sxe_tx_queue_s *tx_queue)
+{
+	return sxe_default_txq_vec_setup(tx_queue, &txq_vec_ops);
+}
+
+#endif
-- 
2.18.2

