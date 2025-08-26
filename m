Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659D7C8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 00:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C21040667;
	Tue, 26 Aug 2025 02:03:50 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id AC6E2402DA
 for <dev@dpdk.org>; Tue, 26 Aug 2025 02:03:47 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-76ff2335c1eso3578950b3a.1
 for <dev@dpdk.org>; Mon, 25 Aug 2025 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756166627; x=1756771427; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kaoVqJdRRKvdIHyNnX+1i/u9ASreTgtPANbMoomYmVc=;
 b=JtjFuDbA3+2O5677tdPAHuFJb2YimpcCDbPvdtk/SOCPjDryBSV+0bYPIxVYsVM9dm
 kneZnncbduAvctA1FQnGDgWjiT6XTXlql+QNkUn74jB3OJU9MP/m7BZNvC85QKK23lA5
 K/SS/A6OAF9Yh3vM9LPKPu8AQTHUI4oSaC81pc1xTsK4h758YDKIDV7jG8H6vVC8OhaM
 zgUUNsieNhcGrgwd/rWY5adgKm2pULcW7y0BdXtNZPC8Dw3NFVRilZuu5HANvfK33Fa0
 NXBPvLOVPPgNWoqQ+yw+TWvPb1/RdtOiyMFQhNM9BJXXTxaRw/0WbZIypg7FBo1TeaHm
 ayPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756166627; x=1756771427;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kaoVqJdRRKvdIHyNnX+1i/u9ASreTgtPANbMoomYmVc=;
 b=XqwSOMXvWka40REcIE0ZZNnit7rvhsG/BQEVe70z68YZaWb3y65sHMepRCajBugLaw
 JZ7Y1EpgSKQFwhPSuQmsCuPdC5QF0OIq9/zt2sfPXK1FRuE15acr3HllErRzQaTA9GHW
 EIaQWZrkoshd2DsBgwpvP5b5I0fWdsUvIjO86zvLfHH8a+hCFcAO9CyU9rCP5495sdxC
 bwjIPdqKqtSBqBgJakLKAJmqHgaxJtxZlYdWi1jAugRY2yE8+XqviUb23UDaPqBNBhOB
 PfBBARGSPdTAcXVzCSqJA2/QMEqhoxmeSY4eN1JnR3d34V77UIXZD615YkbZcCSSkfoW
 6IkQ==
X-Gm-Message-State: AOJu0Yyo30UqoH0Ob6Nvr+yicyrdqADBRFbKJ2jzG++VsTCxApc5HWE3
 8bqbPRyUxnW/BJsqv1aiM7Os1faaFgiA2z9P7FSYiMIhpqpiGfMrDTU1957X9aPmJIOmYQuPFJT
 Qpb/nC6iZLrjk8A==
X-Google-Smtp-Source: AGHT+IFM4Jx9Vz4iZdDZlIZyS28v4YpMKteBpq96WMBToDPVgddPmSniMdmRAjXXDoPu2/08r4sHswtGhbCRsA==
X-Received: from pfbdh12.prod.google.com
 ([2002:a05:6a00:478c:b0:771:bfea:b530])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:21c1:b0:76b:c9b9:a11b with SMTP id
 d2e1a72fcca58-7702f9d8b5fmr16935393b3a.3.1756166626714; 
 Mon, 25 Aug 2025 17:03:46 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:03:37 -0700
In-Reply-To: <20250826000337.3922883-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250826000337.3922883-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826000337.3922883-5-joshwash@google.com>
Subject: [PATCH 4/4] net/gve: support for out of order completions on DQ Rx
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The DPDK DQ driver made an implicit assumption that buffers will be
returned from the NIC in the order which they are posted. While this is
generally the case, there are certain edge cases, such as HW GRO, where
buffers may be completed out of order. In such cases, the driver would
have returned the wrong mbuf to the program, which would cause issues if
the mbuf is freed while the NIC still expects to own the buffer or the
application receives a buffer which contains garbage data.

This patch updates the RX path behavior more in line with what is
expected by the NIC by utilizing the buf_id in the completion descriptor
to decide which buffer to complete. A stack is introduced to hold the
available buf_ids when posting to handle the fact that buf_ids can come
back from the hardware out of order.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_ethdev.h |   4 ++
 drivers/net/gve/gve_rx_dqo.c | 119 ++++++++++++++++++++++++++---------
 2 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index b36f0ff746..f7cc781640 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -242,6 +242,10 @@ struct gve_rx_queue {
 	uint8_t cur_gen_bit;
 	uint16_t bufq_tail;
 
+	/* List of buffers which are known to be completed by the hardware. */
+	int16_t *completed_buf_list;
+	int16_t completed_buf_list_head;
+
 	/* Only valid for DQO_RDA queue format */
 	struct gve_rx_queue *bufq;
 
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index ccaca1b0ea..a0ef21bc8e 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -7,22 +7,55 @@
 #include "gve_ethdev.h"
 #include "base/gve_adminq.h"
 #include "rte_mbuf_ptype.h"
+#include "rte_atomic.h"
+
+static inline void
+gve_completed_buf_list_init(struct gve_rx_queue *rxq)
+{
+	for (int i = 0; i < rxq->nb_rx_desc; i++)
+		rxq->completed_buf_list[i] = -1;
+
+	rxq->completed_buf_list_head = -1;
+}
+
+/* Assumes buf_id < nb_rx_desc */
+static inline void
+gve_completed_buf_list_push(struct gve_rx_queue *rxq, uint16_t buf_id)
+{
+	rxq->completed_buf_list[buf_id] = rxq->completed_buf_list_head;
+	rxq->completed_buf_list_head = buf_id;
+}
+
+static inline int16_t
+gve_completed_buf_list_pop(struct gve_rx_queue *rxq)
+{
+	int16_t head = rxq->completed_buf_list_head;
+	if (head != -1)
+		rxq->completed_buf_list_head = rxq->completed_buf_list[head];
+
+	return head;
+}
 
 static inline void
 gve_rx_refill_dqo(struct gve_rx_queue *rxq)
 {
 	volatile struct gve_rx_desc_dqo *rx_buf_desc;
-	struct rte_mbuf *nmb[rxq->nb_rx_hold];
-	uint16_t nb_refill = rxq->nb_rx_hold;
+	struct rte_mbuf *new_bufs[rxq->nb_rx_desc];
+	uint16_t rx_mask = rxq->nb_rx_desc - 1;
 	uint16_t next_avail = rxq->bufq_tail;
 	struct rte_eth_dev *dev;
+	uint16_t nb_refill;
 	uint64_t dma_addr;
+	int16_t buf_id;
+	int diag;
 	int i;
 
-	if (rxq->nb_rx_hold < rxq->free_thresh)
+	nb_refill = rxq->nb_rx_hold;
+	if (nb_refill < rxq->free_thresh)
 		return;
 
-	if (unlikely(rte_pktmbuf_alloc_bulk(rxq->mpool, nmb, nb_refill))) {
+	diag = rte_pktmbuf_alloc_bulk(rxq->mpool, new_bufs, nb_refill);
+	if (unlikely(diag < 0)) {
 		rxq->stats.no_mbufs_bulk++;
 		rxq->stats.no_mbufs += nb_refill;
 		dev = &rte_eth_devices[rxq->port_id];
@@ -33,17 +66,31 @@ gve_rx_refill_dqo(struct gve_rx_queue *rxq)
 		return;
 	}
 
+	/* Mbuf allocation succeeded, so refill buffers. */
 	for (i = 0; i < nb_refill; i++) {
 		rx_buf_desc = &rxq->rx_ring[next_avail];
-		rxq->sw_ring[next_avail] = nmb[i];
-		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb[i]));
+		buf_id = gve_completed_buf_list_pop(rxq);
+
+		/* Out of buffers. Free remaining mbufs and return. */
+		if (unlikely(buf_id == -1)) {
+			PMD_DRV_DP_LOG(ERR,
+				       "No free entries in sw_ring for port %d, queue %d.",
+				       rxq->port_id, rxq->queue_id);
+			rte_pktmbuf_free_bulk(new_bufs + i, nb_refill - i);
+			nb_refill = i;
+			break;
+		}
+		rxq->sw_ring[buf_id] = new_bufs[i];
+		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_bufs[i]));
+		rx_buf_desc->buf_id = buf_id;
 		rx_buf_desc->header_buf_addr = 0;
 		rx_buf_desc->buf_addr = dma_addr;
-		next_avail = (next_avail + 1) & (rxq->nb_rx_desc - 1);
+
+		next_avail = (next_avail + 1) & rx_mask;
 	}
+
 	rxq->nb_rx_hold -= nb_refill;
 	rte_write32(next_avail, rxq->qrx_tail);
-
 	rxq->bufq_tail = next_avail;
 }
 
@@ -109,11 +156,10 @@ gve_rx_set_mbuf_ptype(struct gve_priv *priv, struct rte_mbuf *rx_mbuf,
 uint16_t
 gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	volatile struct gve_rx_compl_desc_dqo *rx_compl_ring;
 	volatile struct gve_rx_compl_desc_dqo *rx_desc;
 	struct gve_rx_queue *rxq;
 	struct rte_mbuf *rxm;
-	uint16_t rx_id_bufq;
+	uint16_t rx_buf_id;
 	uint16_t pkt_len;
 	uint16_t rx_id;
 	uint16_t nb_rx;
@@ -123,11 +169,9 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	nb_rx = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_id_bufq = rxq->next_avail;
-	rx_compl_ring = rxq->compl_ring;
 
 	while (nb_rx < nb_pkts) {
-		rx_desc = &rx_compl_ring[rx_id];
+		rx_desc = &rxq->compl_ring[rx_id];
 
 		/* check status */
 		if (rx_desc->generation != rxq->cur_gen_bit)
@@ -135,25 +179,25 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 		rte_io_rmb();
 
-		if (unlikely(rx_desc->rx_error)) {
-			rxq->stats.errors++;
-			continue;
-		}
-
-		pkt_len = rx_desc->packet_len;
-
+		rxq->nb_rx_hold++;
 		rx_id++;
 		if (rx_id == rxq->nb_rx_desc) {
 			rx_id = 0;
 			rxq->cur_gen_bit ^= 1;
 		}
 
-		rxm = rxq->sw_ring[rx_id_bufq];
-		rx_id_bufq++;
-		if (rx_id_bufq == rxq->nb_rx_desc)
-			rx_id_bufq = 0;
-		rxq->nb_rx_hold++;
+		rx_buf_id = rte_le_to_cpu_16(rx_desc->buf_id);
+		rxm = rxq->sw_ring[rx_buf_id];
+		gve_completed_buf_list_push(rxq, rx_buf_id);
 
+		/* Free buffer and report error. */
+		if (unlikely(rx_desc->rx_error)) {
+			rxq->stats.errors++;
+			rte_pktmbuf_free(rxm);
+			continue;
+		}
+
+		pkt_len = rte_le_to_cpu_16(rx_desc->packet_len);
 		rxm->pkt_len = pkt_len;
 		rxm->data_len = pkt_len;
 		rxm->port = rxq->port_id;
@@ -168,7 +212,6 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 	if (nb_rx > 0) {
 		rxq->rx_tail = rx_id;
-		rxq->next_avail = rx_id_bufq;
 
 		rxq->stats.packets += nb_rx;
 		rxq->stats.bytes += bytes;
@@ -203,6 +246,7 @@ gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 
 	gve_release_rxq_mbufs_dqo(q);
 	rte_free(q->sw_ring);
+	rte_free(q->completed_buf_list);
 	rte_memzone_free(q->compl_ring_mz);
 	rte_memzone_free(q->mz);
 	rte_memzone_free(q->qres_mz);
@@ -211,7 +255,7 @@ gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 }
 
 static void
-gve_reset_rxq_dqo(struct gve_rx_queue *rxq)
+gve_reset_rx_ring_state_dqo(struct gve_rx_queue *rxq)
 {
 	struct rte_mbuf **sw_ring;
 	uint32_t size, i;
@@ -233,8 +277,9 @@ gve_reset_rxq_dqo(struct gve_rx_queue *rxq)
 	for (i = 0; i < rxq->nb_rx_desc; i++)
 		sw_ring[i] = NULL;
 
+	gve_completed_buf_list_init(rxq);
+
 	rxq->bufq_tail = 0;
-	rxq->next_avail = 0;
 	rxq->nb_rx_hold = rxq->nb_rx_desc - 1;
 
 	rxq->rx_tail = 0;
@@ -306,6 +351,16 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 		goto free_rxq;
 	}
 
+	/* Allocate completed bufs list */
+	rxq->completed_buf_list = rte_zmalloc_socket("gve completed buf list",
+		nb_desc * sizeof(*rxq->completed_buf_list), RTE_CACHE_LINE_SIZE,
+		socket_id);
+	if (rxq->completed_buf_list == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate completed buffer list.");
+		err = -ENOMEM;
+		goto free_rxq_sw_ring;
+	}
+
 	/* Allocate RX buffer queue */
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
 				      nb_desc * sizeof(struct gve_rx_desc_dqo),
@@ -313,7 +368,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX buffer queue");
 		err = -ENOMEM;
-		goto free_rxq_sw_ring;
+		goto free_rxq_completed_buf_list;
 	}
 	rxq->rx_ring = (struct gve_rx_desc_dqo *)mz->addr;
 	rxq->rx_ring_phys_addr = mz->iova;
@@ -345,7 +400,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->qres = (struct gve_queue_resources *)mz->addr;
 	rxq->qres_mz = mz;
 
-	gve_reset_rxq_dqo(rxq);
+	gve_reset_rx_ring_state_dqo(rxq);
 
 	dev->data->rx_queues[queue_id] = rxq;
 
@@ -355,6 +410,8 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	rte_memzone_free(rxq->compl_ring_mz);
 free_rxq_mz:
 	rte_memzone_free(rxq->mz);
+free_rxq_completed_buf_list:
+	rte_free(rxq->completed_buf_list);
 free_rxq_sw_ring:
 	rte_free(rxq->sw_ring);
 free_rxq:
@@ -440,7 +497,7 @@ gve_rx_queue_stop_dqo(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 
 	rxq = dev->data->rx_queues[rx_queue_id];
 	gve_release_rxq_mbufs_dqo(rxq);
-	gve_reset_rxq_dqo(rxq);
+	gve_reset_rx_ring_state_dqo(rxq);
 
 	dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
-- 
2.51.0.rc1.167.g924127e9c0-goog

