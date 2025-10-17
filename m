Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472FCCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFE7E42DD9;
	Fri, 17 Oct 2025 11:19:49 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2C48442B71
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:37 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FB10200D88;
 Fri, 17 Oct 2025 11:19:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CE940200E59;
 Fri, 17 Oct 2025 11:19:36 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 50AC81800079;
 Fri, 17 Oct 2025 17:19:36 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v2 12/12] net/enetc: Add support for deferred queue and queue info
 callbacks
Date: Fri, 17 Oct 2025 14:49:29 +0530
Message-Id: <20251017091929.2723044-13-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251017091929.2723044-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This patch adds:
- Support for deferred queue start/stop functionality to the ENETC4 driver.
- rxq_info_get and txq_info_get callbacks to report queue information

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/enetc/enetc.h         |  2 ++
 drivers/net/enetc/enetc4_ethdev.c | 57 ++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 09168c90db..4d99b5b0cf 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -92,6 +92,8 @@ struct enetc_bdr {
 	struct rte_mempool *mb_pool;   /* mbuf pool to populate RX ring. */
 	struct rte_eth_dev *ndev;
 	uint64_t ierrors;
+	uint8_t rx_deferred_start;
+	uint8_t tx_deferred_start;
 };
 
 struct enetc_eth_hw {
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 988c60aa68..b0d52e0058 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -28,10 +28,32 @@ enetc4_dev_start(struct rte_eth_dev *dev)
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_bdr *txq, *rxq;
 	uint32_t val;
+	int i, ret;
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Start TX queues that are not deferred */
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (txq && !txq->tx_deferred_start) {
+			ret = enetc4_tx_queue_start(dev, i);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Start RX queues that are not deferred */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		if (rxq && !rxq->rx_deferred_start) {
+			ret = enetc4_rx_queue_start(dev, i);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
 	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
 		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
@@ -281,6 +303,7 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 	tx_ring->ndev = dev;
 	enetc4_setup_txbdr(&priv->hw.hw, tx_ring);
 	data->tx_queues[queue_idx] = tx_ring;
+	tx_ring->tx_deferred_start = tx_conf->tx_deferred_start;
 	if (!tx_conf->tx_deferred_start) {
 		/* enable ring */
 		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index,
@@ -429,6 +452,7 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	rx_ring->ndev = dev;
 	enetc4_setup_rxbdr(&adapter->hw.hw, rx_ring, mb_pool);
 	data->rx_queues[rx_queue_id] = rx_ring;
+	rx_ring->rx_deferred_start = rx_conf->rx_deferred_start;
 
 	if (!rx_conf->rx_deferred_start) {
 		/* enable ring */
@@ -447,7 +471,7 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 fail:
 	rte_free(rx_ring);
 
-	return err;
+return err;
 }
 
 void
@@ -837,6 +861,35 @@ enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
 	return 0;
 }
 
+static void
+enetc4_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			struct rte_eth_rxq_info *qinfo)
+{
+	struct enetc_bdr *rxq = dev->data->rx_queues[queue_id];
+
+	qinfo->mp = rxq->mb_pool;
+	qinfo->scattered_rx = dev->data->scattered_rx;
+	qinfo->nb_desc = rxq->bd_count;
+	qinfo->conf.rx_free_thresh = 0;
+	qinfo->conf.rx_deferred_start = rxq->rx_deferred_start;
+	qinfo->conf.rx_drop_en = 0;
+}
+
+static void
+enetc4_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			struct rte_eth_txq_info *qinfo)
+{
+	struct enetc_bdr *txq = dev->data->tx_queues[queue_id];
+
+	qinfo->nb_desc = txq->bd_count;
+	qinfo->conf.tx_thresh.pthresh = 0;
+	qinfo->conf.tx_thresh.hthresh = 0;
+	qinfo->conf.tx_thresh.wthresh = 0;
+	qinfo->conf.tx_deferred_start = txq->tx_deferred_start;
+	qinfo->conf.tx_free_thresh = 0;
+	qinfo->conf.tx_rs_thresh = 0;
+}
+
 const uint32_t *
 enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 			    size_t *no_of_elements)
@@ -883,10 +936,12 @@ static const struct eth_dev_ops enetc4_ops = {
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
 	.rx_queue_release     = enetc4_rx_queue_release,
+	.rxq_info_get         = enetc4_rxq_info_get,
 	.tx_queue_setup       = enetc4_tx_queue_setup,
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.txq_info_get         = enetc4_txq_info_get,
 	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
-- 
2.25.1

