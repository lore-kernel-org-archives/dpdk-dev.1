Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5430110FC466
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 01:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1C42402E4;
	Thu,  9 Apr 2026 03:55:30 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C233C402B3;
 Thu,  9 Apr 2026 03:55:29 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 3A64C20B6F01; Wed,  8 Apr 2026 18:55:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A64C20B6F01
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH] net/mana: fix RX mempool leak on port stop
Date: Wed,  8 Apr 2026 18:55:19 -0700
Message-ID: <20260409015519.350034-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The RX descriptor ring drain loop in mana_stop_rx_queues() uses
'while (tail != head)' to free posted mbufs. The RX ring is likely
completely full because every consumed WQE is immediately replenished,
so head == tail when the ring is full. The drain loop never executes,
leaking all RX mbufs on every port stop.

Fix by adding a desc_ring_len counter to mana_rxq (matching mana_txq)
and using 'while (desc_ring_len > 0)' as the drain condition. Apply
the same change to the TX drain loop for consistency.

Fixes: 5f705ac26259 ("net/mana: start/stop Rx queues")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.h | 2 +-
 drivers/net/mana/rx.c   | 6 +++++-
 drivers/net/mana/tx.c   | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 7d94840dc4..79cc47b6ab 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -443,7 +443,7 @@ struct mana_rxq {
 	/* desc_ring_head is where we put pending requests to ring,
 	 * completion pull off desc_ring_tail
 	 */
-	uint32_t desc_ring_head, desc_ring_tail;
+	uint32_t desc_ring_head, desc_ring_tail, desc_ring_len;
 
 #ifdef RTE_ARCH_32
 	/* For storing wqe increment count btw each short doorbell ring */
diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c
index f196d43aee..1b8ba1f3a9 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -102,6 +102,7 @@ mana_post_rx_wqe(struct mana_rxq *rxq, struct rte_mbuf *mbuf)
 		rxq->wqe_cnt_to_short_db += wqe_size_in_bu;
 #endif
 		rxq->desc_ring_head = (rxq->desc_ring_head + 1) % rxq->num_desc;
+		rxq->desc_ring_len++;
 	} else {
 		DP_LOG(DEBUG, "failed to post recv ret %d", ret);
 		return ret;
@@ -215,7 +216,7 @@ mana_stop_rx_queues(struct rte_eth_dev *dev)
 		}
 
 		/* Drain and free posted WQEs */
-		while (rxq->desc_ring_tail != rxq->desc_ring_head) {
+		while (rxq->desc_ring_len > 0) {
 			struct mana_rxq_desc *desc =
 				&rxq->desc_ring[rxq->desc_ring_tail];
 
@@ -223,9 +224,11 @@ mana_stop_rx_queues(struct rte_eth_dev *dev)
 
 			rxq->desc_ring_tail =
 				(rxq->desc_ring_tail + 1) % rxq->num_desc;
+			rxq->desc_ring_len--;
 		}
 		rxq->desc_ring_head = 0;
 		rxq->desc_ring_tail = 0;
+		rxq->desc_ring_len = 0;
 
 		memset(&rxq->gdma_rq, 0, sizeof(rxq->gdma_rq));
 		memset(&rxq->gdma_cq, 0, sizeof(rxq->gdma_cq));
@@ -560,6 +563,7 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			rxq->desc_ring_tail = 0;
 
 		rxq->gdma_rq.tail += desc->wqe_size_in_bu;
+		rxq->desc_ring_len--;
 
 		/* Record the number of the RX WQE we need to post to replenish
 		 * consumed RX requests
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index e5ab566e8a..57dbbc3651 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -39,7 +39,7 @@ mana_stop_tx_queues(struct rte_eth_dev *dev)
 		}
 
 		/* Drain and free posted WQEs */
-		while (txq->desc_ring_tail != txq->desc_ring_head) {
+		while (txq->desc_ring_len > 0) {
 			struct mana_txq_desc *desc =
 				&txq->desc_ring[txq->desc_ring_tail];
 
-- 
2.43.0

