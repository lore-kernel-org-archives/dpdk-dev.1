Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5CCDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 02:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1A0140662;
	Wed, 24 Jun 2026 04:02:32 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6F8402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 04:02:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHW9KvOjtqo4SoFQ--.11902S2;
 Wed, 24 Jun 2026 10:02:23 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v6 01/23] net/sxe2: remove software statistics devargs
Date: Wed, 24 Jun 2026 10:02:22 +0800
Message-ID: <20260624020222.3687094-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622092731.3092201-1-liujie5@linkdatatechnology.com>
References: <20260622092731.3092201-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHW9KvOjtqo4SoFQ--.11902S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGFy5Cw45Jr1fuw4DKr45Jrb_yoW8XF4xCo
 WxZr4UAa45urnrGrs09F1ruFyDXw4DZwnrJayfJF909a92kF4UXF97Gw13Jrn8tw1rJFWD
 uFyvv3ZIgrs3tw4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYn7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWU
 JVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOa0PDUUUU
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

Remove the optional drv-sw-stats device argument and make software
statistics always-on. Per-queue software statistics are point-in-time
measurements used for accumulation at queue stop/dump, so atomic
operations with rte_memory_order_relaxed add unnecessary overhead
without correctness benefit.

Also rename high_performance_mode field to no_sched_mode to match
the devargs string definition.

Changes:
- Remove sw_stats_en field from struct sxe2_devargs
- Remove RTE_ATOMIC qualifiers from sxe2_rxq_sw_stats fields
- Replace rte_atomic_fetch_add_explicit(relaxed) with plain addition
- Replace rte_atomic_store/load_explicit(relaxed) with plain assignment
- Remove sw_stats_en conditional checks in Rx fast path
- Always pass umbcast_flags to vec Rx functions
- Remove unused #include <rte_stdatomic.h>
- Rename high_performance_mode → no_sched_mode in devargs struct
- Fix int → int32_t for return type in sxe2_parse_eth_devargs

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c          |  2 +-
 drivers/net/sxe2/sxe2_ethdev.h          |  3 +-
 drivers/net/sxe2/sxe2_queue.h           | 15 ++++---
 drivers/net/sxe2/sxe2_rx.c              | 55 +++++++------------------
 drivers/net/sxe2/sxe2_txrx_poll.c       | 38 ++++++-----------
 drivers/net/sxe2/sxe2_txrx_vec_common.h | 52 ++++++++++-------------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c    | 29 +------------
 7 files changed, 61 insertions(+), 133 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index b6cc8703a7..066e1faf7e 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -891,7 +891,7 @@ static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
 static int32_t sxe2_parse_eth_devargs(struct rte_device *dev,
 			  struct rte_eth_devargs *eth_da)
 {
-	int ret = 0;
+	int32_t ret = 0;
 
 	if (dev->devargs == NULL)
 		return 0;
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index a3706945e8..8015d9a064 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -130,9 +130,8 @@ struct sxe2_devargs {
 	uint8_t flow_dup_pattern_mode;
 	uint8_t func_flow_direct_en;
 	uint8_t fnav_stat_type;
-	uint8_t high_performance_mode;
+	uint8_t no_sched_mode;
 	uint8_t sched_layer_mode;
-	uint8_t sw_stats_en;
 	uint8_t rx_low_latency;
 };
 
diff --git a/drivers/net/sxe2/sxe2_queue.h b/drivers/net/sxe2/sxe2_queue.h
index adb4be1214..a300b66771 100644
--- a/drivers/net/sxe2/sxe2_queue.h
+++ b/drivers/net/sxe2/sxe2_queue.h
@@ -7,7 +7,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_io.h>
-#include <rte_stdatomic.h>
 #include <ethdev_driver.h>
 
 #include "sxe2_drv_cmd.h"
@@ -123,13 +122,13 @@ struct sxe2_rxq_stats {
 };
 
 struct sxe2_rxq_sw_stats {
-	RTE_ATOMIC(uint64_t)pkts;
-	RTE_ATOMIC(uint64_t)bytes;
-	RTE_ATOMIC(uint64_t)drop_pkts;
-	RTE_ATOMIC(uint64_t)drop_bytes;
-	RTE_ATOMIC(uint64_t)unicast_pkts;
-	RTE_ATOMIC(uint64_t)multicast_pkts;
-	RTE_ATOMIC(uint64_t)broadcast_pkts;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t drop_pkts;
+	uint64_t drop_bytes;
+	uint64_t unicast_pkts;
+	uint64_t multicast_pkts;
+	uint64_t broadcast_pkts;
 };
 
 struct sxe2_rx_queue {
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 28832d5f71..543d825166 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -479,20 +479,13 @@ int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev)
 			goto l_free_started_queue;
 		}
 
-		rte_atomic_store_explicit(&rxq->sw_stats.pkts, 0,
-			rte_memory_order_relaxed);
-		rte_atomic_store_explicit(&rxq->sw_stats.bytes, 0,
-			rte_memory_order_relaxed);
-		rte_atomic_store_explicit(&rxq->sw_stats.drop_pkts, 0,
-			rte_memory_order_relaxed);
-		rte_atomic_store_explicit(&rxq->sw_stats.drop_bytes, 0,
-			rte_memory_order_relaxed);
-		rte_atomic_store_explicit(&rxq->sw_stats.unicast_pkts, 0,
-			rte_memory_order_relaxed);
-		rte_atomic_store_explicit(&rxq->sw_stats.broadcast_pkts, 0,
-			rte_memory_order_relaxed);
-		rte_atomic_store_explicit(&rxq->sw_stats.multicast_pkts, 0,
-			rte_memory_order_relaxed);
+		rxq->sw_stats.pkts = 0;
+		rxq->sw_stats.bytes = 0;
+		rxq->sw_stats.drop_pkts = 0;
+		rxq->sw_stats.drop_bytes = 0;
+		rxq->sw_stats.unicast_pkts = 0;
+		rxq->sw_stats.broadcast_pkts = 0;
+		rxq->sw_stats.multicast_pkts = 0;
 	}
 	ret = 0;
 	goto l_end;
@@ -524,31 +517,15 @@ void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev)
 
 		rxq = dev->data->rx_queues[nb_rxq];
 		if (rxq) {
-			sw_stats_prev->ipackets +=
-				rte_atomic_load_explicit(&rxq->sw_stats.pkts,
-					rte_memory_order_relaxed);
-			sw_stats_prev->ierrors +=
-				rte_atomic_load_explicit(&rxq->sw_stats.drop_pkts,
-					rte_memory_order_relaxed);
-			sw_stats_prev->ibytes +=
-				rte_atomic_load_explicit(&rxq->sw_stats.bytes,
-					rte_memory_order_relaxed);
-
-			sw_stats_prev->rx_sw_unicast_packets +=
-				rte_atomic_load_explicit(&rxq->sw_stats.unicast_pkts,
-					rte_memory_order_relaxed);
-			sw_stats_prev->rx_sw_broadcast_packets +=
-				rte_atomic_load_explicit(&rxq->sw_stats.broadcast_pkts,
-					rte_memory_order_relaxed);
-			sw_stats_prev->rx_sw_multicast_packets +=
-				rte_atomic_load_explicit(&rxq->sw_stats.multicast_pkts,
-					rte_memory_order_relaxed);
-			sw_stats_prev->rx_sw_drop_packets +=
-				rte_atomic_load_explicit(&rxq->sw_stats.drop_pkts,
-					rte_memory_order_relaxed);
-			sw_stats_prev->rx_sw_drop_bytes +=
-				rte_atomic_load_explicit(&rxq->sw_stats.drop_bytes,
-					rte_memory_order_relaxed);
+			sw_stats_prev->ipackets += rxq->sw_stats.pkts;
+			sw_stats_prev->ierrors += rxq->sw_stats.drop_pkts;
+			sw_stats_prev->ibytes += rxq->sw_stats.bytes;
+
+			sw_stats_prev->rx_sw_unicast_packets += rxq->sw_stats.unicast_pkts;
+			sw_stats_prev->rx_sw_broadcast_packets += rxq->sw_stats.broadcast_pkts;
+			sw_stats_prev->rx_sw_multicast_packets += rxq->sw_stats.multicast_pkts;
+			sw_stats_prev->rx_sw_drop_packets += rxq->sw_stats.drop_pkts;
+			sw_stats_prev->rx_sw_drop_bytes += rxq->sw_stats.drop_bytes;
 		}
 	}
 }
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index b9d34afb31..947a5247ed 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -682,23 +682,17 @@ sxe2_rx_sw_stats_update(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf,
 		union sxe2_rx_desc *rxd)
 {
 	uint64_t qword1 = rte_le_to_cpu_64(rxd->wb.status_err_ptype_len);
-	rte_atomic_fetch_add_explicit(&rxq->sw_stats.pkts, 1,
-		rte_memory_order_relaxed);
-	rte_atomic_fetch_add_explicit(&rxq->sw_stats.bytes,
-			mbuf->pkt_len + RTE_ETHER_CRC_LEN,
-			rte_memory_order_relaxed);
+	rxq->sw_stats.pkts += 1;
+	rxq->sw_stats.bytes += mbuf->pkt_len + RTE_ETHER_CRC_LEN;
 	switch (SXE2_RX_DESC_STATUS_UMBCAST_VAL_GET(qword1)) {
 	case SXE2_RX_DESC_STATUS_UNICAST:
-		rte_atomic_fetch_add_explicit(&rxq->sw_stats.unicast_pkts, 1,
-			rte_memory_order_relaxed);
+		rxq->sw_stats.unicast_pkts += 1;
 		break;
 	case SXE2_RX_DESC_STATUS_MULTICAST:
-		rte_atomic_fetch_add_explicit(&rxq->sw_stats.multicast_pkts, 1,
-			rte_memory_order_relaxed);
+		rxq->sw_stats.multicast_pkts += 1;
 		break;
 	case SXE2_RX_DESC_STATUS_BROADCAST:
-		rte_atomic_fetch_add_explicit(&rxq->sw_stats.broadcast_pkts, 1,
-			rte_memory_order_relaxed);
+		rxq->sw_stats.broadcast_pkts += 1;
 		break;
 	default:
 		break;
@@ -787,11 +781,9 @@ uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint1
 
 		if (unlikely(qword1 & SXE2_RX_DESC_ERROR_RXE_MASK) ||
 			unlikely(qword1 & SXE2_RX_DESC_ERROR_OVERSIZE_MASK)) {
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
-				rte_memory_order_relaxed);
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
-				first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
-				rte_memory_order_relaxed);
+			rxq->sw_stats.drop_pkts += 1;
+			rxq->sw_stats.drop_bytes +=
+				first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN;
 			rte_pktmbuf_free(first_seg);
 			first_seg = NULL;
 			continue;
@@ -822,8 +814,7 @@ uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint1
 
 		sxe2_rx_mbuf_common_fields_fill(rxq, first_seg, &desc_tmp);
 
-		if (rxq->vsi->adapter->devargs.sw_stats_en)
-			sxe2_rx_sw_stats_update(rxq, first_seg, &desc_tmp);
+		sxe2_rx_sw_stats_update(rxq, first_seg, &desc_tmp);
 
 		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr, first_seg->data_off));
 
@@ -990,11 +981,9 @@ uint16_t sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		if (unlikely(qword1 & SXE2_RX_DESC_ERROR_RXE_MASK) ||
 			unlikely(qword1 & SXE2_RX_DESC_ERROR_OVERSIZE_MASK)) {
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
-				rte_memory_order_relaxed);
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
-				first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
-				rte_memory_order_relaxed);
+			rxq->sw_stats.drop_pkts += 1;
+			rxq->sw_stats.drop_bytes +=
+				first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN;
 			rte_pktmbuf_free(first_seg);
 			first_seg = NULL;
 			continue;
@@ -1023,8 +1012,7 @@ uint16_t sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts,
 		first_seg->port = rxq->port_id;
 		sxe2_rx_mbuf_common_fields_fill(rxq, first_seg, &desc_tmp);
 
-		if (rxq->vsi->adapter->devargs.sw_stats_en)
-			sxe2_rx_sw_stats_update(rxq, first_seg, &desc_tmp);
+		sxe2_rx_sw_stats_update(rxq, first_seg, &desc_tmp);
 
 		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr, first_seg->data_off));
 
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_common.h b/drivers/net/sxe2/sxe2_txrx_vec_common.h
index 6b1649c390..cc74f6e582 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_common.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec_common.h
@@ -130,27 +130,20 @@ sxe2_tx_desc_fill_offloads(struct rte_mbuf *mbuf, uint64_t *desc_qw1)
 static inline void sxe2_vf_rx_vec_sw_stats_cnt(struct sxe2_rx_queue *rxq,
 		struct rte_mbuf *mbuf, uint8_t umbcast_flag)
 {
-	if (rxq->vsi->adapter->devargs.sw_stats_en) {
-		rte_atomic_fetch_add_explicit(&rxq->sw_stats.pkts, 1,
-					rte_memory_order_relaxed);
-		rte_atomic_fetch_add_explicit(&rxq->sw_stats.bytes,
-				 mbuf->pkt_len + RTE_ETHER_CRC_LEN, rte_memory_order_relaxed);
-		switch (SXE2_RX_UMBCAST_FLAGS_VAL_GET(umbcast_flag)) {
-		case SXE2_RX_DESC_STATUS_UNICAST:
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.unicast_pkts, 1,
-					rte_memory_order_relaxed);
-			break;
-		case SXE2_RX_DESC_STATUS_MULTICAST:
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.multicast_pkts, 1,
-					rte_memory_order_relaxed);
-			break;
-		case SXE2_RX_DESC_STATUS_BROADCAST:
-			rte_atomic_fetch_add_explicit(&rxq->sw_stats.broadcast_pkts, 1,
-					rte_memory_order_relaxed);
-			break;
-		default:
-			break;
-		}
+	rxq->sw_stats.pkts += 1;
+	rxq->sw_stats.bytes += mbuf->pkt_len + RTE_ETHER_CRC_LEN;
+	switch (SXE2_RX_UMBCAST_FLAGS_VAL_GET(umbcast_flag)) {
+	case SXE2_RX_DESC_STATUS_UNICAST:
+		rxq->sw_stats.unicast_pkts += 1;
+		break;
+	case SXE2_RX_DESC_STATUS_MULTICAST:
+		rxq->sw_stats.multicast_pkts += 1;
+		break;
+	case SXE2_RX_DESC_STATUS_BROADCAST:
+		rxq->sw_stats.broadcast_pkts += 1;
+		break;
+	default:
+		break;
 	}
 }
 
@@ -196,11 +189,9 @@ sxe2_rx_pkts_refactor(struct sxe2_rx_queue *rxq,
 			} else if (split_rxe_flags[buf_idx] & SXE2_RX_DESC_STATUS_EOP_MASK) {
 				continue;
 			} else {
-				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
-					rte_memory_order_relaxed);
-				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
-				 first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
-				 rte_memory_order_relaxed);
+				rxq->sw_stats.drop_pkts += 1;
+				rxq->sw_stats.drop_bytes +=
+					first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN;
 				rte_pktmbuf_free(first_seg);
 				first_seg = NULL;
 				last_seg  = NULL;
@@ -218,11 +209,10 @@ sxe2_rx_pkts_refactor(struct sxe2_rx_queue *rxq,
 				mbuf_bufs[buf_idx]->data_len += rxq->crc_len;
 				mbuf_bufs[buf_idx]->pkt_len  += rxq->crc_len;
 			} else {
-				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
-					rte_memory_order_relaxed);
-				rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
-				 mbuf_bufs[buf_idx]->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
-				 rte_memory_order_relaxed);
+				rxq->sw_stats.drop_pkts += 1;
+				rxq->sw_stats.drop_bytes +=
+					mbuf_bufs[buf_idx]->pkt_len - rxq->crc_len +
+					RTE_ETHER_CRC_LEN;
 				rte_pktmbuf_free_seg(mbuf_bufs[buf_idx]);
 				continue;
 			}
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_sse.c b/drivers/net/sxe2/sxe2_txrx_vec_sse.c
index f6e3f45937..182a7dfc17 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_sse.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_sse.c
@@ -483,41 +483,16 @@ static __rte_always_inline uint16_t
 sxe2_rx_pkts_scattered_batch_vec_sse(struct sxe2_rx_queue *rxq,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	const uint64_t *split_rxe_flags64;
 	uint8_t split_rxe_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
 	uint8_t umbcast_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
 	uint16_t rx_done_num;
 	uint16_t rx_pkt_done_num;
 	rx_pkt_done_num = 0;
 
-	if (rxq->vsi->adapter->devargs.sw_stats_en) {
-		rx_done_num = sxe2_rx_pkts_common_vec_sse(rxq, rx_pkts,
-				nb_pkts, split_rxe_flags, umbcast_flags);
-	} else {
-		rx_done_num = sxe2_rx_pkts_common_vec_sse(rxq, rx_pkts,
-				nb_pkts, split_rxe_flags, NULL);
-	}
+	rx_done_num = sxe2_rx_pkts_common_vec_sse(rxq, rx_pkts,
+			nb_pkts, split_rxe_flags, umbcast_flags);
 	if (rx_done_num == 0)
 		goto l_end;
-	if (!rxq->vsi->adapter->devargs.sw_stats_en) {
-		split_rxe_flags64 = (uint64_t *)split_rxe_flags;
-		if (rxq->pkt_first_seg == NULL &&
-			split_rxe_flags64[0] == 0 &&
-			split_rxe_flags64[1] == 0 &&
-			split_rxe_flags64[2] == 0 &&
-			split_rxe_flags64[3] == 0) {
-			rx_pkt_done_num = rx_done_num;
-			goto l_end;
-		}
-		if (rxq->pkt_first_seg == NULL) {
-			while (rx_pkt_done_num < rx_done_num &&
-			       split_rxe_flags[rx_pkt_done_num] == 0)
-				rx_pkt_done_num++;
-			if (rx_pkt_done_num == rx_done_num)
-				goto l_end;
-			rxq->pkt_first_seg = rx_pkts[rx_pkt_done_num];
-		}
-	}
 	rx_pkt_done_num += sxe2_rx_pkts_refactor(rxq, &rx_pkts[rx_pkt_done_num],
 			rx_done_num - rx_pkt_done_num, &split_rxe_flags[rx_pkt_done_num],
 			&umbcast_flags[rx_pkt_done_num]);
-- 
2.52.0

