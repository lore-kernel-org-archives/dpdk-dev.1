Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4B7C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 10:08:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 730C1402CE;
	Thu,  6 Feb 2025 11:08:29 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EC7834026C;
 Thu,  6 Feb 2025 11:08:27 +0100 (CET)
Received: from alhe-manarx-xub.corp.microsoft.com (ext.mail.microsoft.com
 [131.107.8.37])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0DB63203F5A9;
 Thu,  6 Feb 2025 02:08:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DB63203F5A9
From: Wei Hu <weh@microsoft.com>
To: dev@dpdk.org, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Cc: stable@dpdk.org
Subject: [PATCH 1/1] net/mana: do not ring short doorbell for every mbuf
 allocation
Date: Thu,  6 Feb 2025 02:07:43 -0800
Message-Id: <20250206100744.734612-1-weh@microsoft.com>
X-Mailer: git-send-email 2.34.1
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

In the 32bit rx path, it rings short doorbell after receiving
one packet and alocating the new mbuf. This significantly
impacets the rx performance. Fix this problem by ringing the
short doorbell in batch.

Fixes: eeb37809601b ("net/mana: use bulk mbuf allocation for Rx WQEs")
Cc: stable@dpdk.org

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/net/mana/rx.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c
index 0c26702b73..f196d43aee 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -121,6 +121,10 @@ mana_alloc_and_post_rx_wqes(struct mana_rxq *rxq, uint32_t count)
 	uint32_t i, batch_count;
 	struct rte_mbuf *mbufs[MANA_MBUF_BULK];
 
+#ifdef RTE_ARCH_32
+	rxq->wqe_cnt_to_short_db = 0;
+#endif
+
 more_mbufs:
 	batch_count = RTE_MIN(count, MANA_MBUF_BULK);
 	ret = rte_pktmbuf_alloc_bulk(rxq->mp, mbufs, batch_count);
@@ -132,9 +136,6 @@ mana_alloc_and_post_rx_wqes(struct mana_rxq *rxq, uint32_t count)
 		goto out;
 	}
 
-#ifdef RTE_ARCH_32
-	rxq->wqe_cnt_to_short_db = 0;
-#endif
 	for (i = 0; i < batch_count; i++) {
 		ret = mana_post_rx_wqe(rxq, mbufs[i]);
 		if (ret) {
@@ -448,10 +449,6 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	uint32_t i;
 	int polled = 0;
 
-#ifdef RTE_ARCH_32
-	rxq->wqe_cnt_to_short_db = 0;
-#endif
-
 repoll:
 	/* Polling on new completions if we have no backlog */
 	if (rxq->comp_buf_idx == rxq->comp_buf_len) {
@@ -570,25 +567,6 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		wqe_consumed++;
 		if (pkt_received == pkts_n)
 			break;
-
-#ifdef RTE_ARCH_32
-		/* Always post WQE as soon as it's consumed for short DB */
-		ret = mana_alloc_and_post_rx_wqes(rxq, wqe_consumed);
-		if (ret) {
-			DRV_LOG(ERR, "failed to post %d WQEs, ret %d",
-				wqe_consumed, ret);
-			return pkt_received;
-		}
-		wqe_consumed = 0;
-
-		/* Ring short doorbell if approaching the wqe increment
-		 * limit.
-		 */
-		if (rxq->wqe_cnt_to_short_db > RX_WQE_SHORT_DB_THRESHOLD) {
-			mana_rq_ring_doorbell(rxq);
-			rxq->wqe_cnt_to_short_db = 0;
-		}
-#endif
 	}
 
 	rxq->backlog_idx = pkt_idx;
-- 
2.34.1

