Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBE5D10372
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 02:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1083F40B98;
	Wed, 26 Nov 2025 03:54:50 +0100 (CET)
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com
 [115.124.28.99]) by mails.dpdk.org (Postfix) with ESMTP id 369174029A
 for <dev@dpdk.org>; Wed, 26 Nov 2025 03:54:46 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fW.b7b3_1764125683 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 26 Nov 2025 10:54:44 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: fix Rx/Tx stats concurrency
Date: Tue, 25 Nov 2025 18:54:36 -0800
Message-Id: <20251126025436.3714568-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126025436.3714568-1-dimon.zhao@nebula-matrix.com>
References: <20251126025436.3714568-1-dimon.zhao@nebula-matrix.com>
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

Queue statistics are being continuously updated in Rx/Tx burst
routines while handling traffic. In addition to that, statistics
can be reset (written with zeroes) on statistics reset in other
threads, causing a race condition, which in turn could result in
wrong stats.

The patch provides an approach with reference values, allowing
the actual counters to be writable within Rx/Tx burst threads
only, and updating reference values on stats reset.

Fixes: 661c0ccf2512 ("net/nbl: support statistics")

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h |  2 ++
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 38 +++++++++++++--------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index aba0f8e0c1..1f6515f64d 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -141,6 +141,7 @@ struct nbl_res_tx_ring {
 	const struct rte_eth_dev *eth_dev;
 	struct nbl_common_info *common;
 	struct nbl_txq_stats txq_stats;
+	struct nbl_txq_stats txq_stats_reset;
 	u64 default_hdr[2];
 
 	enum nbl_product_type product;
@@ -182,6 +183,7 @@ struct nbl_res_rx_ring {
 	const struct rte_eth_dev *eth_dev;
 	struct nbl_common_info *common;
 	struct nbl_rxq_stats rxq_stats;
+	struct nbl_rxq_stats rxq_stats_reset;
 	uint64_t mbuf_initializer; /**< value to init mbufs */
 	struct rte_mbuf fake_mbuf;
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index d7ce725872..650790b4fc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -727,9 +727,9 @@ static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats,
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
 	struct rte_eth_dev *eth_dev = res_mgt->eth_dev;
 	struct nbl_res_rx_ring *rxq;
-	struct nbl_rxq_stats *rxq_stats;
+	struct nbl_rxq_stats *rxq_stats, *rxq_stats_reset;
 	struct nbl_res_tx_ring  *txq;
-	struct nbl_txq_stats *txq_stats;
+	struct nbl_txq_stats *txq_stats, *txq_stats_reset;
 	uint32_t i;
 	uint16_t idx;
 
@@ -739,16 +739,18 @@ static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats,
 		if (unlikely(rxq  == NULL))
 			return -EINVAL;
 		rxq_stats = &rxq->rxq_stats;
+		rxq_stats_reset = &rxq->rxq_stats_reset;
 		idx = rxq->queue_id;
 
 		if (qstats && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[idx] += rxq_stats->rx_packets;
-			qstats->q_ibytes[idx] += rxq_stats->rx_bytes;
+			qstats->q_ipackets[idx] += rxq_stats->rx_packets -
+							rxq_stats_reset->rx_packets;
+			qstats->q_ibytes[idx] += rxq_stats->rx_bytes - rxq_stats_reset->rx_bytes;
 		}
-		rte_stats->ipackets += rxq_stats->rx_packets;
-		rte_stats->ibytes += rxq_stats->rx_bytes;
-		rte_stats->rx_nombuf += rxq_stats->rx_nombuf;
-		rte_stats->ierrors += rxq_stats->rx_ierror;
+		rte_stats->ipackets += rxq_stats->rx_packets - rxq_stats_reset->rx_packets;
+		rte_stats->ibytes += rxq_stats->rx_bytes - rxq_stats_reset->rx_bytes;
+		rte_stats->rx_nombuf += rxq_stats->rx_nombuf - rxq_stats_reset->rx_nombuf;
+		rte_stats->ierrors += rxq_stats->rx_ierror - rxq_stats_reset->rx_ierror;
 	}
 
 	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
@@ -756,15 +758,17 @@ static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats,
 		if (unlikely(txq  == NULL))
 			return -EINVAL;
 		txq_stats = &txq->txq_stats;
+		txq_stats_reset = &txq->txq_stats_reset;
 		idx = txq->queue_id;
 
 		if (qstats && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[idx] += txq_stats->tx_packets;
-			qstats->q_obytes[idx] += txq_stats->tx_bytes;
+			qstats->q_opackets[idx] += txq_stats->tx_packets -
+							txq_stats_reset->tx_packets;
+			qstats->q_obytes[idx] += txq_stats->tx_bytes - txq_stats_reset->tx_bytes;
 		}
-		rte_stats->opackets += txq_stats->tx_packets;
-		rte_stats->obytes += txq_stats->tx_bytes;
-		rte_stats->oerrors += txq_stats->tx_errors;
+		rte_stats->opackets += txq_stats->tx_packets - txq_stats_reset->tx_packets;
+		rte_stats->obytes += txq_stats->tx_bytes - txq_stats_reset->tx_bytes;
+		rte_stats->oerrors += txq_stats->tx_errors - txq_stats_reset->tx_errors;
 	}
 
 	return 0;
@@ -776,9 +780,7 @@ nbl_res_txrx_reset_stats(void *priv)
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
 	struct rte_eth_dev *eth_dev = res_mgt->eth_dev;
 	struct nbl_res_rx_ring *rxq;
-	struct nbl_rxq_stats *rxq_stats;
 	struct nbl_res_tx_ring  *txq;
-	struct nbl_txq_stats *txq_stats;
 	uint32_t i;
 
 	/* Add software counters. */
@@ -787,8 +789,7 @@ nbl_res_txrx_reset_stats(void *priv)
 		if (unlikely(rxq == NULL))
 			continue;
 
-		rxq_stats = &rxq->rxq_stats;
-		memset(rxq_stats, 0, sizeof(struct nbl_rxq_stats));
+		rxq->rxq_stats_reset = rxq->rxq_stats;
 	}
 
 	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
@@ -796,8 +797,7 @@ nbl_res_txrx_reset_stats(void *priv)
 		if (unlikely(txq == NULL))
 			continue;
 
-		txq_stats = &txq->txq_stats;
-		memset(txq_stats, 0, sizeof(struct nbl_txq_stats));
+		txq->txq_stats_reset = txq->txq_stats;
 	}
 
 	return 0;
-- 
2.34.1

