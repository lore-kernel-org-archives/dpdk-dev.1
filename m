Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73505C624A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F4440BA2;
	Tue,  1 Sep 2026 05:08:19 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 13F8140DD1;
 Tue,  1 Sep 2026 05:08:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACX_zmdQZZqUPohBw--.58097S2;
 Tue, 01 Sep 2026 11:08:15 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v8 30/49] net/sxe2: unify vectorized Tx buffer handling
Date: Tue,  1 Sep 2026 11:08:12 +0800
Message-ID: <20260901030812.3685253-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACX_zmdQZZqUPohBw--.58097S2
X-Coremail-Antispam: 1UD129KBjvAXoW3KFy5ZryUZw1fAF1fZFW5Wrg_yoW8WF1UXo
 WI9w40vF1Igry8ZFWUW3Z7WF9rW3yaq345GayFkFs8u3WUAwnrta47Jw1UJF1UGF1Y9F1D
 Wa48Ar48CrZ3Gr4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYF7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
 Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjwID7
 UUUUU==
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

Add a union of the scalar and vectorized buffer ring pointers to the
Tx queue structure so the vectorized path can use sxe2_tx_buffer_vec
directly. Rename the mbuf fill helper to sxe2_tx_pkts_mbuf_fill_vec,
switch the vectorized Tx burst and mbuf release paths to the
buffer_ring_vec member, and drop the AVX512-specific fill handling and
conditional branching.

Fixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_queue.h           |   5 +-
 drivers/net/sxe2/sxe2_txrx_vec.c        |  57 ++--------
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c   |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c | 133 +-----------------------
 drivers/net/sxe2/sxe2_txrx_vec_common.h |   9 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c   |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_sse.c    |  10 +-
 7 files changed, 40 insertions(+), 194 deletions(-)

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
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.c b/drivers/net/sxe2/sxe2_txrx_vec.c
index 1442d5d119..c9363444df 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -165,66 +165,31 @@ int32_t __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, uint32_t *
 
 static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq)
 {
-	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer_vec *buffer_vec;
 	uint16_t i;
 
-	if (unlikely(txq == NULL || txq->buffer_ring == NULL)) {
+	if (unlikely(txq == NULL || txq->buffer_ring_vec == NULL)) {
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
+	if (txq->next_use < i) {
+		for ( ; i < txq->ring_depth; ++i) {
 			if (buffer_vec[i].mbuf != NULL) {
 				rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
 				buffer_vec[i].mbuf = NULL;
 			}
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
+	for ( ; i < txq->next_use; ++i) {
+		if (buffer_vec[i].mbuf != NULL) {
+			rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+			buffer_vec[i].mbuf = NULL;
 		}
 	}
 }
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
index a830c7a33b..6c8415ee5a 100644
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
@@ -207,16 +97,6 @@ void sxe2_tx_desc_fill_avx512(volatile union sxe2_tx_data_desc *desc, struct rte
 	}
 }
 
-static __rte_always_inline void
-sxe2_tx_pkts_mbuf_fill_avx512(struct sxe2_tx_buffer_vec *buffer,
-	struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-{
-	uint16_t i;
-
-	for (i = 0; i < nb_pkts; ++i)
-		buffer[i].mbuf = tx_pkts[i];
-}
-
 static __rte_always_inline uint16_t
 sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
 	uint16_t nb_pkts, bool with_offloads)
@@ -228,7 +108,7 @@ sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pk
 	uint16_t tx_num;
 
 	if (txq->desc_free_num < txq->free_thresh)
-		(void)sxe2_tx_bufs_free_vec_avx512(txq);
+		(void)sxe2_tx_bufs_free_vec(txq);
 
 	nb_pkts = RTE_MIN(txq->desc_free_num, nb_pkts);
 	if (unlikely(nb_pkts == 0)) {
@@ -241,15 +121,14 @@ sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pk
 
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
@@ -265,10 +144,10 @@ sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pk
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
@@ -863,5 +742,3 @@ uint16_t sxe2_rx_pkts_scattered_vec_avx512_offload(void *rx_queue,
 	return sxe2_rx_pkts_scattered_common_vec_avx512(rx_queue,
 			rx_pkts, nb_pkts, true);
 }
-
-#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_common.h b/drivers/net/sxe2/sxe2_txrx_vec_common.h
index 9ac99cf0fa..ede4c236b1 100644
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
@@ -36,7 +37,7 @@ sxe2_tx_pkts_mbuf_fill(struct sxe2_tx_buffer *buffer,
 static __rte_always_inline int32_t
 sxe2_tx_bufs_free_vec(struct sxe2_tx_queue *txq)
 {
-	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer_vec *buffer;
 	struct rte_mbuf *mbuf;
 	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
 	int32_t ret;
@@ -50,7 +51,7 @@ sxe2_tx_bufs_free_vec(struct sxe2_tx_queue *txq)
 		goto l_end;
 	}
 	rs_thresh = txq->rs_thresh;
-	buffer = &txq->buffer_ring[txq->next_dd - (rs_thresh - 1)];
+	buffer = &txq->buffer_ring_vec[txq->next_dd - (rs_thresh - 1)];
 	mbuf = rte_pktmbuf_prefree_seg(buffer[0].mbuf);
 	if (likely(mbuf)) {
 		mbuf_free_arr[0] = mbuf;
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_neon.c b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
index 4e5cb87cd5..b51cc55368 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_neon.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
@@ -39,7 +39,7 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 			uint16_t nb_pkts, bool with_offloads)
 {
 	volatile union sxe2_tx_data_desc *desc;
-	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer_vec *buffer;
 	uint16_t next_use;
 	uint16_t res_num;
 	uint16_t tx_num;
@@ -59,14 +59,14 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 
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
 			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
@@ -82,10 +82,10 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 		next_use     = 0;
 		txq->next_rs = txq->rs_thresh - 1;
 		desc         = &txq->desc_ring[next_use];
-		buffer       = &txq->buffer_ring[next_use];
+		buffer       = &txq->buffer_ring_vec[next_use];
 	}
 
-	sxe2_tx_pkts_mbuf_fill(buffer, tx_pkts, tx_num);
+	sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, tx_num);
 
 	for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
 		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
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
-- 
2.52.0

