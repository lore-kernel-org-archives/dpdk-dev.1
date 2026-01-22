Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54FC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9A5940278;
	Thu, 22 Jan 2026 08:27:31 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 505784013F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769066849;
 bh=1MWA1B9GB/pyXs7tL1PelIxQ4yUW8hzGyb+tu4FWWNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F+yTuCpHa5m4UYWAoSkjSfn9C/kR6teJTCeHSNCteZ6y/XHVQYGMiEquhRU60mYIW
 A81g3q05plorCMwG6vnlDgQgO44R0u5q+XYvUsJDThMRLjjAxBPCCtSskx4BQ678JR
 lUhgdkxrfht3Zo86p9A8rLW1S0CY4p0s8nceqmbY6yDdZrqvHdBxiOz9RWQqeUKmNv
 kOSCyQfVaRBQtTAftNt2BVLo6V5z1iai930V5YXpXbTwQtFHIu6enslxAJxxlrOsyd
 9DXY5dcO3y4YfzdaJl7akBd5OSjCbVwjRH4Wq1vzRUB3yFVPYqB1yDnxRsjqBxt3oa
 8LIDNQ0uCHpDw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 203DF118007F;
 Thu, 22 Jan 2026 08:27:29 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 1/8] net/nfb: prepare for indirect queue mapping scheme
Date: Thu, 22 Jan 2026 08:27:12 +0100
Message-ID: <20260122072719.505185-2-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122072719.505185-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb.h        |  3 +++
 drivers/net/nfb/nfb_ethdev.c | 21 +++++++++++++++++++++
 drivers/net/nfb/nfb_rx.c     | 30 +++++++++++++++---------------
 drivers/net/nfb/nfb_rx.h     |  9 ++++-----
 drivers/net/nfb/nfb_tx.c     | 27 +++++++++++++++------------
 drivers/net/nfb/nfb_tx.h     |  7 +++----
 6 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 90b04c6151..3821732c37 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -60,6 +60,9 @@ struct pmd_internals {
 struct pmd_priv {
 	uint16_t max_rx_queues;
 	uint16_t max_tx_queues;
+
+	int             *queue_map_rx;
+	int             *queue_map_tx;
 };
 
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 947ee9e21d..803815138c 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -509,6 +509,7 @@ static const struct eth_dev_ops ops = {
 static int
 nfb_eth_dev_init(struct rte_eth_dev *dev)
 {
+	int i;
 	int ret;
 	uint32_t mac_count;
 	struct rte_eth_dev_data *data = dev->data;
@@ -577,6 +578,20 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		priv->max_rx_queues = max_rx_queues;
 		priv->max_tx_queues = max_tx_queues;
 
+		priv->queue_map_rx = rte_calloc("NFB queue map", (max_rx_queues + max_tx_queues),
+				sizeof(*priv->queue_map_rx), 0);
+		if (priv->queue_map_rx == NULL) {
+			ret = -ENOMEM;
+			goto err_alloc_queue_map;
+		}
+		priv->queue_map_tx = priv->queue_map_rx + max_rx_queues;
+
+		/* default queue mapping is 1:1 */
+		for (i = 0; i < max_rx_queues; i++)
+			priv->queue_map_rx[i] = i;
+		for (i = 0; i < max_tx_queues; i++)
+			priv->queue_map_tx[i] = i;
+
 		/* Allocate space for MAC addresses */
 		mac_count = nfb_eth_get_max_mac_address_count(dev);
 		data->mac_addrs = rte_zmalloc(data->name,
@@ -608,6 +623,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	return 0;
 
 err_malloc_mac_addrs:
+	rte_free(priv->queue_map_rx);
+err_alloc_queue_map:
 	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
 	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
 	nfb_close(internals->nfb);
@@ -633,6 +650,10 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct pmd_internals *internals = dev->process_private;
+	struct pmd_priv *priv = dev->data->dev_private;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_free(priv->queue_map_rx);
 
 	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
 	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
diff --git a/drivers/net/nfb/nfb_rx.c b/drivers/net/nfb/nfb_rx.c
index 413d275853..ff630f32f4 100644
--- a/drivers/net/nfb/nfb_rx.c
+++ b/drivers/net/nfb/nfb_rx.c
@@ -61,12 +61,13 @@ nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 		struct rte_mempool *mb_pool)
 {
 	struct pmd_internals *internals = dev->process_private;
+	struct pmd_priv *priv = dev->data->dev_private;
 
-	struct ndp_rx_queue *rxq;
 	int ret;
+	int qid;
+	struct ndp_rx_queue *rxq;
 
-	rxq = rte_zmalloc_socket("ndp rx queue",
-			sizeof(struct ndp_rx_queue),
+	rxq = rte_zmalloc_socket("ndp rx queue", sizeof(struct ndp_rx_queue),
 			RTE_CACHE_LINE_SIZE, socket_id);
 
 	if (rxq == NULL) {
@@ -77,23 +78,23 @@ nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 
 	rxq->flags = 0;
 
-	ret = nfb_eth_rx_queue_init(internals->nfb,
-		rx_queue_id,
-		dev->data->port_id,
-		mb_pool,
-		rxq);
+	qid = priv->queue_map_rx[rx_queue_id];
 
-	if (ret == 0)
-		dev->data->rx_queues[rx_queue_id] = rxq;
-	else
-		rte_free(rxq);
+	ret = nfb_eth_rx_queue_init(internals->nfb, qid, dev->data->port_id, mb_pool, rxq);
+	if (ret)
+		goto err_queue_init;
 
+	dev->data->rx_queues[rx_queue_id] = rxq;
+	return 0;
+
+err_queue_init:
+	rte_free(rxq);
 	return ret;
 }
 
 int
 nfb_eth_rx_queue_init(struct nfb_device *nfb,
-		uint16_t rx_queue_id,
+		int qid,
 		uint16_t port_id,
 		struct rte_mempool *mb_pool,
 		struct ndp_rx_queue *rxq)
@@ -104,12 +105,11 @@ nfb_eth_rx_queue_init(struct nfb_device *nfb,
 	if (nfb == NULL)
 		return -EINVAL;
 
-	rxq->queue = ndp_open_rx_queue(nfb, rx_queue_id);
+	rxq->queue = ndp_open_rx_queue(nfb, qid);
 	if (rxq->queue == NULL)
 		return -EINVAL;
 
 	rxq->nfb = nfb;
-	rxq->rx_queue_id = rx_queue_id;
 	rxq->in_port = port_id;
 	rxq->mb_pool = mb_pool;
 	rxq->buf_size = (uint16_t)(mbp_priv->mbuf_data_room_size -
diff --git a/drivers/net/nfb/nfb_rx.h b/drivers/net/nfb/nfb_rx.h
index 67b3b00e2a..831945c577 100644
--- a/drivers/net/nfb/nfb_rx.h
+++ b/drivers/net/nfb/nfb_rx.h
@@ -30,7 +30,6 @@ nfb_timestamp_dynfield(struct rte_mbuf *mbuf)
 struct ndp_rx_queue {
 	struct nfb_device *nfb;	     /* nfb dev structure */
 	struct ndp_queue *queue;     /* rx queue */
-	uint16_t rx_queue_id;	     /* index */
 	uint8_t in_port;	     /* port */
 	uint8_t flags;               /* setup flags */
 
@@ -47,8 +46,8 @@ struct ndp_rx_queue {
  *
  * @param nfb
  *   Pointer to nfb device structure.
- * @param rx_queue_id
- *   RX queue index.
+ * @param qid
+ *   RX queue ID.
  * @param port_id
  *   Device [external] port identifier.
  * @param mb_pool
@@ -60,7 +59,7 @@ struct ndp_rx_queue {
  */
 int
 nfb_eth_rx_queue_init(struct nfb_device *nfb,
-	uint16_t rx_queue_id,
+	int qid,
 	uint16_t port_id,
 	struct rte_mempool *mb_pool,
 	struct ndp_rx_queue *rxq);
@@ -70,7 +69,7 @@ nfb_eth_rx_queue_init(struct nfb_device *nfb,
  *
  * @param dev
  *   Pointer to Ethernet device structure.
- * @param idx
+ * @param rx_queue_id
  *   RX queue index.
  * @param desc
  *   Number of descriptors to configure in queue.
diff --git a/drivers/net/nfb/nfb_tx.c b/drivers/net/nfb/nfb_tx.c
index 1f997ce22f..b5cbedeaf6 100644
--- a/drivers/net/nfb/nfb_tx.c
+++ b/drivers/net/nfb/nfb_tx.c
@@ -54,11 +54,13 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 	const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->process_private;
+	struct pmd_priv *priv = dev->data->dev_private;
+
 	int ret;
+	int qid;
 	struct ndp_tx_queue *txq;
 
-	txq = rte_zmalloc_socket("ndp tx queue",
-		sizeof(struct ndp_tx_queue),
+	txq = rte_zmalloc_socket("ndp tx queue", sizeof(struct ndp_tx_queue),
 		RTE_CACHE_LINE_SIZE, socket_id);
 
 	if (txq == NULL) {
@@ -67,32 +69,33 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
-	ret = nfb_eth_tx_queue_init(internals->nfb,
-		tx_queue_id,
-		txq);
+	qid = priv->queue_map_tx[tx_queue_id];
 
-	if (ret == 0)
-		dev->data->tx_queues[tx_queue_id] = txq;
-	else
-		rte_free(txq);
+	ret = nfb_eth_tx_queue_init(internals->nfb, qid, txq);
+	if (ret)
+		goto err_queue_init;
 
+	dev->data->tx_queues[tx_queue_id] = txq;
+	return 0;
+
+err_queue_init:
+	rte_free(txq);
 	return ret;
 }
 
 int
 nfb_eth_tx_queue_init(struct nfb_device *nfb,
-	uint16_t tx_queue_id,
+	int qid,
 	struct ndp_tx_queue *txq)
 {
 	if (nfb == NULL)
 		return -EINVAL;
 
-	txq->queue = ndp_open_tx_queue(nfb, tx_queue_id);
+	txq->queue = ndp_open_tx_queue(nfb, qid);
 	if (txq->queue == NULL)
 		return -EINVAL;
 
 	txq->nfb = nfb;
-	txq->tx_queue_id = tx_queue_id;
 
 	txq->tx_pkts = 0;
 	txq->tx_bytes = 0;
diff --git a/drivers/net/nfb/nfb_tx.h b/drivers/net/nfb/nfb_tx.h
index f107cf914b..c253af1a86 100644
--- a/drivers/net/nfb/nfb_tx.h
+++ b/drivers/net/nfb/nfb_tx.h
@@ -17,7 +17,6 @@
 struct ndp_tx_queue {
 	struct nfb_device *nfb;     /* nfb dev structure */
 	struct ndp_queue *queue;    /* tx queue */
-	uint16_t          tx_queue_id;       /* index */
 	volatile uint64_t tx_pkts;  /* packets transmitted */
 	volatile uint64_t tx_bytes; /* bytes transmitted */
 	volatile uint64_t err_pkts; /* erroneous packets */
@@ -54,8 +53,8 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
  *
  * @param nfb
  *   Pointer to nfb device structure.
- * @param tx_queue_id
- *   TX queue index.
+ * @param qid
+ *   TX queue ID.
  * @param[out] txq
  *   Pointer to ndp_tx_queue output structure
  *
@@ -64,7 +63,7 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
  */
 int
 nfb_eth_tx_queue_init(struct nfb_device *nfb,
-	uint16_t tx_queue_id,
+	int qid,
 	struct ndp_tx_queue *txq);
 
 /**
-- 
2.52.0

