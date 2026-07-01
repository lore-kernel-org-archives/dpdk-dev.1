Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5536BC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 06:15:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23EAA402E0;
	Wed,  1 Jul 2026 08:15:33 +0200 (CEST)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id BDADE40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 08:15:31 +0200 (CEST)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqqWN2vXpz24JXK;
 Wed,  1 Jul 2026 14:15:28 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqqWM5hclz24JXK;
 Wed,  1 Jul 2026 14:15:27 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 4712C91E4;
 Wed,  1 Jul 2026 14:15:22 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 14:15:28 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <maxime.coquelin@redhat.com>, <chenbox@nvidia.com>
CC: <dev@dpdk.org>, Liangxing Wang <wangliangxing@hygon.cn>
Subject: [PATCH] net/vhost: support queue info query
Date: Wed, 1 Jul 2026 06:14:12 +0000
Message-ID: <20260701061412.154739-1-wangliangxing@hygon.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.22.47]
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)
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

Add Rx and Tx queue info callbacks to report the vhost-user vring
size as the queue descriptor number.

The vhost-user PMD does not use the descriptor count passed by
rte_eth_rx_queue_setup() and rte_eth_tx_queue_setup(). The actual queue
depth is negotiated with the virtio frontend and maintained by the
vhost library. Query the vhost vring and report its size through
rxq_info_get and txq_info_get.

With this change, testpmd using vhost-user PMD can display the correct
Rx and Tx queue descriptor number in the port start log.

Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
---
 drivers/net/vhost/rte_eth_vhost.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..af023c7639 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1480,12 +1480,50 @@ vhost_dev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	return 0;
 }
 
+static void
+eth_rxq_info_get(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+		 struct rte_eth_rxq_info *qinfo)
+{
+	struct rte_vhost_vring vring;
+	struct vhost_queue *vq = dev->data->rx_queues[rx_queue_id];
+
+	qinfo->nb_desc = 0;
+
+	if (vq == NULL || vq->vid < 0)
+		return;
+
+	if (rte_vhost_get_vhost_vring(vq->vid, vq->virtqueue_id, &vring) < 0)
+		return;
+
+	qinfo->nb_desc = vring.size;
+}
+
+static void
+eth_txq_info_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+		 struct rte_eth_txq_info *qinfo)
+{
+	struct rte_vhost_vring vring;
+	struct vhost_queue *vq = dev->data->tx_queues[tx_queue_id];
+
+	qinfo->nb_desc = 0;
+
+	if (vq == NULL || vq->vid < 0)
+		return;
+
+	if (rte_vhost_get_vhost_vring(vq->vid, vq->virtqueue_id, &vring) < 0)
+		return;
+
+	qinfo->nb_desc = vring.size;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
 	.dev_close = eth_dev_close,
 	.dev_configure = eth_dev_configure,
 	.dev_infos_get = eth_dev_info,
+	.rxq_info_get = eth_rxq_info_get,
+	.txq_info_get = eth_txq_info_get,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
 	.rx_queue_release = eth_rx_queue_release,
-- 
2.43.0


