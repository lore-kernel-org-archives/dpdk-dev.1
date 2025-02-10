Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DDC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A96A427C0;
	Mon, 10 Feb 2025 08:28:06 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 322444278C
 for <dev@dpdk.org>; Mon, 10 Feb 2025 08:28:00 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 079D3A3A4C; Mon, 10 Feb 2025 15:27:27 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v8 27/28] net/rnp: add queue info operation.
Date: Mon, 10 Feb 2025 15:26:54 +0800
Message-Id: <1739172415-48507-28-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
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

add support get queue configure info for user debug

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |  2 ++
 drivers/net/rnp/rnp_rxtx.c   | 42 ++++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h   |  4 ++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index a5ae670c96..0d37dd60b0 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1466,6 +1466,8 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.rx_queue_release             = rnp_dev_rx_queue_release,
 	.tx_queue_setup               = rnp_tx_queue_setup,
 	.tx_queue_release             = rnp_dev_tx_queue_release,
+	.rxq_info_get                 = rnp_rx_queue_info_get,
+	.txq_info_get                 = rnp_tx_queue_info_get,
 	/* rss impl */
 	.reta_update                  = rnp_dev_rss_reta_update,
 	.reta_query                   = rnp_dev_rss_reta_query,
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 6498b012ca..c5661a0f7a 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1718,3 +1718,45 @@ int rnp_tx_func_select(struct rte_eth_dev *dev)
 
 	return 0;
 }
+
+void
+rnp_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		      struct rte_eth_rxq_info *qinfo)
+{
+	struct rnp_rx_queue *rxq;
+
+	rxq = dev->data->rx_queues[queue_id];
+	if (!rxq)
+		return;
+	qinfo->mp = rxq->mb_pool;
+	qinfo->scattered_rx = dev->data->scattered_rx;
+	qinfo->queue_state = rxq->rxq_started;
+	qinfo->nb_desc = rxq->attr.nb_desc;
+	qinfo->rx_buf_size = rxq->rx_buf_len;
+
+	qinfo->conf.rx_deferred_start = rxq->rx_deferred_start;
+	qinfo->conf.rx_free_thresh = rxq->rx_free_thresh;
+	qinfo->conf.rx_thresh.pthresh = rxq->pthresh;
+	qinfo->conf.rx_thresh.hthresh = rxq->pburst;
+	qinfo->conf.offloads = rxq->rx_offloads;
+}
+
+void
+rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		      struct rte_eth_txq_info *qinfo)
+{
+	struct rnp_tx_queue *txq;
+
+	txq = dev->data->tx_queues[queue_id];
+	if (!txq)
+		return;
+	qinfo->queue_state = txq->txq_started;
+	qinfo->nb_desc = txq->attr.nb_desc;
+
+	qinfo->conf.tx_deferred_start = txq->tx_deferred_start;
+	qinfo->conf.tx_free_thresh = txq->tx_free_thresh;
+	qinfo->conf.tx_rs_thresh = txq->tx_rs_thresh;
+	qinfo->conf.tx_thresh.pthresh = txq->pthresh;
+	qinfo->conf.tx_thresh.hthresh = txq->pburst;
+	qinfo->conf.offloads = txq->tx_offloads;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 51e5d4b600..dc4a8ea9dd 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -148,5 +148,9 @@ int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_rx_func_select(struct rte_eth_dev *dev);
 int rnp_tx_func_select(struct rte_eth_dev *dev);
+void rnp_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			   struct rte_eth_rxq_info *qinfo);
+void rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			   struct rte_eth_txq_info *qinfo);
 
 #endif /* _RNP_RXTX_H_ */
-- 
2.34.1

