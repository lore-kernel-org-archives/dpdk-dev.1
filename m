Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E1D44C63
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 15:17:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C48CB427A9;
	Thu, 15 Jan 2026 16:17:05 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 8C45740BA6
 for <dev@dpdk.org>; Thu, 15 Jan 2026 16:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768490223;
 bh=zaVOGBioeTQ1Nsr6pRFUGDph+Z7fUlzjOuGFf/SWd6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OTjIBMA2UkrulYfG40s0sl6rUX4hiPFngRrWTTp3/9Kkdv1CY5nRSTbYm1JVc3YJC
 EhKqtQ2pQmn6YPUXH/gmCAK+xX5I+y/RslT8SsjDlA16IrGfVwvlafn037HKAi1zYS
 1RbtROixyxYn0/CqdTsQ907RzHJw8aZxWoyu0tahb14F1tkrHGN+PDqWDBa6ARYbew
 CZVb4ZyvJLyQDrKyosAFJ/AkGAYMMPzGici2xmfDg9PMck6Zsj/2Q2HiaInBO9laOW
 tnjFydSIhO6wBfpFXGBiOA4XxXH6K4gkUgwnY5oez2dgLZwWuID6DMeuL3ciQRsgpT
 7YW0wBfU8MflA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 4B9EE1180085;
 Thu, 15 Jan 2026 16:17:03 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 1/8] net/nfb: prepare for indirect queue mapping scheme
Date: Thu, 15 Jan 2026 16:16:49 +0100
Message-ID: <20260115151656.393106-2-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115151656.393106-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

This prepares queue mapping for port-aware driver implementation.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  4 ++++
 drivers/net/nfb/nfb_ethdev.c | 21 +++++++++++++++++++++
 drivers/net/nfb/nfb_rx.c     | 21 ++++++++++++---------
 drivers/net/nfb/nfb_tx.c     | 21 ++++++++++++---------
 4 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index d85c5fba62..ef41d100ac 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -47,6 +47,10 @@ struct pmd_internals {
 	uint16_t         max_txmac;
 	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
 	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
+
+	int             *queue_map_rx;
+	int             *queue_map_tx;
+
 	struct nfb_device *nfb;
 };
 
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 74728f91dd..247f78fe24 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -510,6 +510,7 @@ static const struct eth_dev_ops ops = {
 static int
 nfb_eth_dev_init(struct rte_eth_dev *dev)
 {
+	int i;
 	int ret;
 	uint32_t mac_count;
 	struct rte_eth_dev_data *data = dev->data;
@@ -567,6 +568,23 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	dev->rx_pkt_burst = nfb_eth_ndp_rx;
 	dev->tx_pkt_burst = nfb_eth_ndp_tx;
 
+	internals->queue_map_rx = rte_malloc("NFB queue map",
+			sizeof(*internals->queue_map_rx) *
+			(priv->max_rx_queues + priv->max_tx_queues), 0);
+	if (internals->queue_map_rx == NULL) {
+		ret = -ENOMEM;
+		goto err_alloc_queue_map;
+	}
+	internals->queue_map_tx = internals->queue_map_rx + priv->max_rx_queues;
+
+	/* default queue mapping is 1:1 */
+	for (i = 0; i < priv->max_rx_queues; i++) {
+		internals->queue_map_rx[i] = i;
+	}
+	for (i = 0; i < priv->max_tx_queues; i++) {
+		internals->queue_map_tx[i] = i;
+	}
+
 	/* Set function callbacks for Ethernet API */
 	dev->dev_ops = &ops;
 
@@ -605,6 +623,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	return 0;
 
 err_malloc_mac_addrs:
+	rte_free(internals->queue_map_rx);
+err_alloc_queue_map:
 	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
 	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
 	nfb_close(internals->nfb);
@@ -635,6 +655,7 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
 	nfb_close(internals->nfb);
 
+	rte_free(internals->queue_map_rx);
 	rte_free(internals);
 
 	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully uninitialized",
diff --git a/drivers/net/nfb/nfb_rx.c b/drivers/net/nfb/nfb_rx.c
index 413d275853..0881d8b6b8 100644
--- a/drivers/net/nfb/nfb_rx.c
+++ b/drivers/net/nfb/nfb_rx.c
@@ -63,6 +63,7 @@ nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 	struct pmd_internals *internals = dev->process_private;
 
 	struct ndp_rx_queue *rxq;
+	int nfb_qid;
 	int ret;
 
 	rxq = rte_zmalloc_socket("ndp rx queue",
@@ -77,17 +78,19 @@ nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 
 	rxq->flags = 0;
 
-	ret = nfb_eth_rx_queue_init(internals->nfb,
-		rx_queue_id,
-		dev->data->port_id,
-		mb_pool,
-		rxq);
+	/* nfb queue id doesn't neccessary corresponds to txq_id */
+	nfb_qid = internals->queue_map_rx[rx_queue_id];
 
-	if (ret == 0)
-		dev->data->rx_queues[rx_queue_id] = rxq;
-	else
-		rte_free(rxq);
+	ret = nfb_eth_rx_queue_init(internals->nfb, nfb_qid,
+			dev->data->port_id, mb_pool, rxq);
+	if (ret)
+		goto err_queue_init;
+
+	dev->data->rx_queues[rx_queue_id] = rxq;
+	return 0;
 
+err_queue_init:
+	rte_free(rxq);
 	return ret;
 }
 
diff --git a/drivers/net/nfb/nfb_tx.c b/drivers/net/nfb/nfb_tx.c
index 1f997ce22f..e24db8939c 100644
--- a/drivers/net/nfb/nfb_tx.c
+++ b/drivers/net/nfb/nfb_tx.c
@@ -55,10 +55,10 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 {
 	struct pmd_internals *internals = dev->process_private;
 	int ret;
+	int nfb_qid;
 	struct ndp_tx_queue *txq;
 
-	txq = rte_zmalloc_socket("ndp tx queue",
-		sizeof(struct ndp_tx_queue),
+	txq = rte_zmalloc_socket("ndp tx queue", sizeof(struct ndp_tx_queue),
 		RTE_CACHE_LINE_SIZE, socket_id);
 
 	if (txq == NULL) {
@@ -67,15 +67,18 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
-	ret = nfb_eth_tx_queue_init(internals->nfb,
-		tx_queue_id,
-		txq);
+	/* nfb queue id doesn't neccessary corresponds to tx_queue_id */
+	nfb_qid = internals->queue_map_tx[tx_queue_id];
 
-	if (ret == 0)
-		dev->data->tx_queues[tx_queue_id] = txq;
-	else
-		rte_free(txq);
+	ret = nfb_eth_tx_queue_init(internals->nfb, nfb_qid, txq);
+	if (ret)
+		goto err_queue_init;
+
+	dev->data->tx_queues[tx_queue_id] = txq;
+	return 0;
 
+err_queue_init:
+	rte_free(txq);
 	return ret;
 }
 
-- 
2.52.0

