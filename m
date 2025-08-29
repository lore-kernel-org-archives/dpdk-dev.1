Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8164CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4989440676;
	Fri, 29 Aug 2025 10:24:40 +0200 (CEST)
Received: from lf-1-19.ptr.blmpb.com (lf-1-19.ptr.blmpb.com [103.149.242.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6D6B540608
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455873; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JA1kIVZHu3iVFrUZJO+aM5WvjMGz9naOiF4bJnF+Pts=;
 b=N6aFpzCcLDWOP99BX5NEo+T9DeITriqSjiDC3sL6UOjRKYsNhwtPBDz8Wm17p9CYiK3uGE
 I0StZ4qcx3Lz/mGtQu10vLIvc0gxgUsgmr/OMk7Sh1UQrunT6N1YAGD0+pX/9isLpjFkVl
 I8D3D1ki/EBK6dB9pEIfIB8Y2p5VrZEMMiAKk7Q28cSPg/uVgCTD9kH5chA/rL4ORZIbMD
 68r0hYDk+I3V7+7/x4P+MxBe5IphoiP/Uu5U4sBo4Yb21xpguQnnww52zfIM2VgXa/ELAF
 J9tJ2m5UFa61ZF65eubIacymGAg8u8cdiEZsVpuAK8TRH5vMYz6w5gEJbLS4Ag==
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:31 +0800
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:31 +0800
X-Lms-Return-Path: <lba+268b163bf+887483+dpdk.org+wanry@yunsilicon.com>
Message-Id: <20250829082430.24369-12-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 11/14] net/xsc: optimize stop and close
References: <20250829082406.24369-1-wanry@yunsilicon.com>
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

Refactor the stop and close paths for xsc PMD.

Previously, stopping or closing queues could leave partially freed
resources and relied on flags to track queue initialization.
This patch ensures all queue resources are properly released, improves
code clarity, and makes stop/close operations safer and more predictable.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 68 +++++++++++++++---------------------
 drivers/net/xsc/xsc_ethdev.h |  4 ---
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index fc88caa9a2..70417b2d5b 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -94,8 +94,9 @@ xsc_ethdev_txq_release(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 	struct xsc_txq_data *txq_data = xsc_txq_get(priv, idx);
+	uint8_t txq_state = dev->data->tx_queue_state[idx];
 
-	if (txq_data == NULL)
+	if (txq_data == NULL || txq_state == RTE_ETH_QUEUE_STATE_STOPPED)
 		return;
 
 	xsc_dev_set_qpsetid(priv->xdev, txq_data->qpn, 0);
@@ -103,10 +104,7 @@ xsc_ethdev_txq_release(struct rte_eth_dev *dev, uint16_t idx)
 	rte_free(txq_data->fcqs);
 	txq_data->fcqs = NULL;
 	xsc_txq_elts_free(txq_data);
-	rte_free(txq_data);
-	(*priv->txqs)[idx] = NULL;
 
-	dev->data->tx_queues[idx] = NULL;
 	dev->data->tx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STOPPED;
 }
 
@@ -115,15 +113,14 @@ xsc_ethdev_rxq_release(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 	struct xsc_rxq_data *rxq_data = xsc_rxq_get(priv, idx);
+	uint8_t rxq_state = dev->data->rx_queue_state[idx];
 
-	if (rxq_data == NULL)
+	if (rxq_data == NULL || rxq_state == RTE_ETH_QUEUE_STATE_STOPPED)
 		return;
+
 	xsc_rxq_rss_obj_release(priv->xdev, rxq_data);
 	xsc_rxq_elts_free(rxq_data);
-	rte_free(rxq_data);
-	(*priv->rxqs)[idx] = NULL;
 
-	dev->data->rx_queues[idx] = NULL;
 	dev->data->rx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STOPPED;
 }
 
@@ -207,8 +204,6 @@ xsc_rxq_stop(struct rte_eth_dev *dev)
 
 	for (i = 0; i != priv->num_rq; ++i)
 		xsc_ethdev_rxq_release(dev, i);
-	priv->rxqs = NULL;
-	priv->flags &= ~XSC_FLAG_RX_QUEUE_INIT;
 }
 
 static void
@@ -219,8 +214,6 @@ xsc_txq_stop(struct rte_eth_dev *dev)
 
 	for (i = 0; i != priv->num_sq; ++i)
 		xsc_ethdev_txq_release(dev, i);
-	priv->txqs = NULL;
-	priv->flags &= ~XSC_FLAG_TX_QUEUE_INIT;
 }
 
 static int
@@ -232,12 +225,6 @@ xsc_txq_start(struct xsc_ethdev_priv *priv)
 	int ret;
 	size_t size;
 
-	if (priv->flags & XSC_FLAG_TX_QUEUE_INIT) {
-		for (i = 0; i != priv->num_sq; ++i)
-			dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
-		return 0;
-	}
-
 	for (i = 0; i != priv->num_sq; ++i) {
 		txq_data = xsc_txq_get(priv, i);
 		if (txq_data == NULL)
@@ -259,7 +246,6 @@ xsc_txq_start(struct xsc_ethdev_priv *priv)
 		}
 	}
 
-	priv->flags |= XSC_FLAG_TX_QUEUE_INIT;
 	return 0;
 
 error:
@@ -271,25 +257,16 @@ static int
 xsc_rxq_start(struct xsc_ethdev_priv *priv)
 {
 	struct xsc_rxq_data *rxq_data;
-	struct rte_eth_dev *dev = priv->eth_dev;
 	uint16_t i;
 	int ret;
 
-	if (priv->flags & XSC_FLAG_RX_QUEUE_INIT) {
-		for (i = 0; i != priv->num_sq; ++i)
-			dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
-		return 0;
-	}
-
 	for (i = 0; i != priv->num_rq; ++i) {
 		rxq_data = xsc_rxq_get(priv, i);
 		if (rxq_data == NULL)
 			goto error;
-		if (dev->data->rx_queue_state[i] != RTE_ETH_QUEUE_STATE_STARTED) {
-			ret = xsc_rxq_elts_alloc(rxq_data);
-			if (ret != 0)
-				goto error;
-		}
+		ret = xsc_rxq_elts_alloc(rxq_data);
+		if (ret != 0)
+			goto error;
 	}
 
 	ret = xsc_rxq_rss_obj_new(priv, priv->dev_data->port_id);
@@ -299,7 +276,6 @@ xsc_rxq_start(struct xsc_ethdev_priv *priv)
 	for (i = 0; i != priv->num_rq; ++i)
 		priv->dev_data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
-	priv->flags |= XSC_FLAG_RX_QUEUE_INIT;
 	return 0;
 error:
 	/* Queue resources are released by xsc_ethdev_start calling the stop interface */
@@ -350,20 +326,14 @@ xsc_ethdev_start(struct rte_eth_dev *dev)
 static int
 xsc_ethdev_stop(struct rte_eth_dev *dev)
 {
-	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
-	uint16_t i;
-
 	PMD_DRV_LOG(DEBUG, "Port %u stopping", dev->data->port_id);
 	dev->data->dev_started = 0;
 	dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
 	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
 	rte_wmb();
 
-	rte_delay_us_sleep(1000 * priv->num_rq);
-	for (i = 0; i < priv->num_rq; ++i)
-		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
-	for (i = 0; i < priv->num_sq; ++i)
-		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	xsc_txq_stop(dev);
+	xsc_rxq_stop(dev);
 
 	return 0;
 }
@@ -371,6 +341,9 @@ xsc_ethdev_stop(struct rte_eth_dev *dev)
 static int
 xsc_ethdev_close(struct rte_eth_dev *dev)
 {
+	int idx;
+	struct xsc_rxq_data *rxq_data;
+	struct xsc_txq_data *txq_data;
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 
 	PMD_DRV_LOG(DEBUG, "Port %u closing", dev->data->port_id);
@@ -381,6 +354,21 @@ xsc_ethdev_close(struct rte_eth_dev *dev)
 	xsc_txq_stop(dev);
 	xsc_rxq_stop(dev);
 
+	for (idx = 0; idx < priv->num_rq; idx++) {
+		rxq_data = xsc_rxq_get(priv, idx);
+		rte_free(rxq_data);
+		dev->data->rx_queues[idx] = NULL;
+	}
+
+	for (idx = 0; idx < priv->num_sq; idx++) {
+		txq_data = xsc_txq_get(priv, idx);
+		rte_free(txq_data);
+		dev->data->tx_queues[idx] = NULL;
+	}
+
+	priv->rxqs = NULL;
+	priv->txqs = NULL;
+
 	rte_free(priv->rss_conf.rss_key);
 	if (!xsc_dev_is_vf(priv->xdev))
 		xsc_dev_intr_handler_uninstall(priv->xdev);
diff --git a/drivers/net/xsc/xsc_ethdev.h b/drivers/net/xsc/xsc_ethdev.h
index 0b307c2828..ed7d4ee60f 100644
--- a/drivers/net/xsc/xsc_ethdev.h
+++ b/drivers/net/xsc/xsc_ethdev.h
@@ -7,9 +7,6 @@
 
 #include "xsc_dev.h"
 
-#define XSC_FLAG_RX_QUEUE_INIT		0x1
-#define XSC_FLAG_TX_QUEUE_INIT		0x2
-
 struct xsc_ethdev_priv {
 	struct rte_eth_dev *eth_dev;
 	struct rte_pci_device *pci_dev;
@@ -37,7 +34,6 @@ struct xsc_ethdev_priv {
 	uint16_t num_sq;
 	uint16_t num_rq;
 
-	uint16_t flags;
 	struct xsc_txq_data *(*txqs)[];
 	struct xsc_rxq_data *(*rxqs)[];
 };
-- 
2.25.1
