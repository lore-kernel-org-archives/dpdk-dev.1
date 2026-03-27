Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F27F10AB82F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A877542D9D;
	Fri, 27 Mar 2026 01:19:36 +0100 (CET)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id A97DF4027F
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:19:35 +0100 (CET)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso4849430a91.0
 for <dev@dpdk.org>; Thu, 26 Mar 2026 17:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774570775; x=1775175575; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt3BJBI/cdM9YJuyP1LkaOPvi6bjmf4hREiR3Q7QSTg=;
 b=iq2mUnXEYEf85eQbfyKmr9KWqThhm7FSZ5hFoqSNGtXbx0fEoaWqk0AcmhNnjZ6QHi
 yDrGykaF3ofAOFLkqLpKH3V17ZEcpinwx6UuhisaBpJQB0GmU8qFOH8YuMuvAQylgOR2
 lnWnFdIeqTGt3NAi0L2DMPVqjYgDETL87VvlDpWLIpt6IR0R830z8ZNEv9/4n8x8xfAb
 aIqmjldHOk0AJuEPTdo55FUGIelmAEYrR2Vqeen6z04WR83Gkg6IAaCmY6gP5/pTUt3D
 ONGOxkk7nmMGDtnMeaYil/AEH4gBRefMyVrYAYYHP4h3ko1k6Jzkn7k1T5HjWhPMv+sR
 7O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570775; x=1775175575;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt3BJBI/cdM9YJuyP1LkaOPvi6bjmf4hREiR3Q7QSTg=;
 b=C6egAnlvTKo1VXcRCXpLl99af4iZ7WQ5+s4g9uIrOScBFmsWIkx4OvEdKjSCpZvtRz
 qJzggS1esG3diSsOFt+xhlGXpRIlyGjOc1VPc+sCkqtPthj15O2Zxr+HOz5SefvV+yoY
 JQFeYHcSBqQyU6853tjY20ZiQ5aZO4voEiG88iHEqdlxHRHRlHrr+zLURobpNThM0EO4
 91GHqy7EuQwGD+ecurB0GYloX9EosY1dUcgJ4x74VuO71Bpys3ascpzbtQ/0hU3FUJCQ
 cK4IgJHmI+4DWZ651Ls7hlZTi/SktpbcAVsL2r+AVhz6+5sUMluqABXqlMkWrHo8tRgI
 tFEg==
X-Gm-Message-State: AOJu0YzZYESSqVJHnQW46qwCA3hR+BpuZX856XRHNEVMFGAOnkOAjQKm
 SicEhfhHsj6X2vTkIBbQQ047J9UR+8fO2Xarv91lc7zC3Y1HU1lzKTRatQmPSKad1wkF4UcTznM
 zvYeiCCdTbnkWMAMWuCza31DlSw==
X-Received: from pjbiq8.prod.google.com ([2002:a17:90a:fb48:b0:35c:afc:54bb])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d48:b0:35b:a170:f266 with SMTP id
 98e67ed59e1d1-35c3001a5b3mr593596a91.13.1774570774655; 
 Thu, 26 Mar 2026 17:19:34 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:18:25 +0000
In-Reply-To: <20260327001827.3385001-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260327001827.3385001-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260327001827.3385001-3-jtranoleary@google.com>
Subject: [PATCH 2/4] net/gve: remove variable length array in rx refill
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Joshua Washington <joshwash@google.com>
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

The new_bufs array in gve_rx_refill_dqo was being allocated on the
stack as a variable length array. With a large descriptor count, this
could lead to excessive stack usage or potential stack overflows, and
triggers -Wvla warnings during compilation.

To fix this, replace the stack array with a buffer allocated on the
heap during queue setup. This buffer, refill_bufs, is stored in the
rxq structure and is sized to the queue's descriptor count. This moves
the allocation from the datapath stack to the heap at initialization,
resolving the stack overflow risk while maintaining the efficiency of a
single bulk mbuf allocation.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.h |  1 +
 drivers/net/gve/gve_rx_dqo.c | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 2d570d0..8fd098c 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -250,6 +250,7 @@ struct gve_rx_queue {
 
 	/* Only valid for DQO_RDA queue format */
 	struct gve_rx_queue *bufq;
+	struct rte_mbuf **refill_bufs;
 
 	uint8_t is_gqi_qpl;
 };
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 3aa82b3..8035aee 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -40,12 +40,12 @@ static inline void
 gve_rx_refill_dqo(struct gve_rx_queue *rxq)
 {
 	volatile struct gve_rx_desc_dqo *rx_buf_desc;
-	struct rte_mbuf *new_bufs[rxq->nb_rx_desc];
 	uint16_t rx_mask = rxq->nb_rx_desc - 1;
 	uint16_t next_avail = rxq->bufq_tail;
 	struct rte_eth_dev *dev;
 	uint16_t nb_refill;
 	uint64_t dma_addr;
+	rte_iova_t iova;
 	int16_t buf_id;
 	int diag;
 	int i;
@@ -54,7 +54,7 @@ gve_rx_refill_dqo(struct gve_rx_queue *rxq)
 	if (nb_refill < rxq->free_thresh)
 		return;
 
-	diag = rte_pktmbuf_alloc_bulk(rxq->mpool, new_bufs, nb_refill);
+	diag = rte_pktmbuf_alloc_bulk(rxq->mpool, rxq->refill_bufs, nb_refill);
 	if (unlikely(diag < 0)) {
 		rxq->stats.no_mbufs_bulk++;
 		rxq->stats.no_mbufs += nb_refill;
@@ -76,12 +76,14 @@ gve_rx_refill_dqo(struct gve_rx_queue *rxq)
 			PMD_DRV_DP_LOG(ERR,
 				       "No free entries in sw_ring for port %d, queue %d.",
 				       rxq->port_id, rxq->queue_id);
-			rte_pktmbuf_free_bulk(new_bufs + i, nb_refill - i);
+			rte_pktmbuf_free_bulk(rxq->refill_bufs + i,
+					      nb_refill - i);
 			nb_refill = i;
 			break;
 		}
-		rxq->sw_ring[buf_id] = new_bufs[i];
-		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_bufs[i]));
+		rxq->sw_ring[buf_id] = rxq->refill_bufs[i];
+		iova = rte_mbuf_data_iova_default(rxq->refill_bufs[i]);
+		dma_addr = rte_cpu_to_le_64(iova);
 		rx_buf_desc->buf_id = buf_id;
 		rx_buf_desc->header_buf_addr = 0;
 		rx_buf_desc->buf_addr = dma_addr;
@@ -247,6 +249,7 @@ gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 	gve_release_rxq_mbufs_dqo(q);
 	rte_free(q->sw_ring);
 	rte_free(q->completed_buf_list);
+	rte_free(q->refill_bufs);
 	rte_memzone_free(q->compl_ring_mz);
 	rte_memzone_free(q->mz);
 	rte_memzone_free(q->qres_mz);
@@ -363,6 +366,16 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 		goto free_rxq_sw_ring;
 	}
 
+	/* Allocate buffer for reallocating mbufs */
+	rxq->refill_bufs = rte_zmalloc_socket("gve rx refill bufs",
+		nb_desc * sizeof(*rxq->refill_bufs), RTE_CACHE_LINE_SIZE,
+		socket_id);
+	if (rxq->refill_bufs == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate rx refill bufs.");
+		err = -ENOMEM;
+		goto free_rxq_completed_buf_list;
+	}
+
 	/* Allocate RX buffer queue */
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
 				      nb_desc * sizeof(struct gve_rx_desc_dqo),
@@ -370,7 +383,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX buffer queue");
 		err = -ENOMEM;
-		goto free_rxq_completed_buf_list;
+		goto free_rxq_refill_bufs;
 	}
 	rxq->rx_ring = (struct gve_rx_desc_dqo *)mz->addr;
 	rxq->rx_ring_phys_addr = mz->iova;
@@ -412,6 +425,8 @@ free_rxq_cq_mz:
 	rte_memzone_free(rxq->compl_ring_mz);
 free_rxq_mz:
 	rte_memzone_free(rxq->mz);
+free_rxq_refill_bufs:
+	rte_free(rxq->refill_bufs);
 free_rxq_completed_buf_list:
 	rte_free(rxq->completed_buf_list);
 free_rxq_sw_ring:
-- 
2.53.0.1118.gaef5881109-goog

