Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BDDE81A3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A031940657;
	Mon, 16 Feb 2026 17:25:17 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 6779D40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:25:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771259111;
 bh=cmWTEMu8yMKwwnuxgP4Qm0oZ/p5EkH8K8bR01eFsigM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SadR9G3jSEouhn+gTJgw5aGx62C0xmoeVo474OLupuerbhJZI8t1TdHa6oQjMwJLa
 ChtQxvpIoXBu6zbrYO5lj/XTjP2GKPFUclQAEMnN4rPQZDj/Gcge8GeDmBSvseA4fL
 z5jPA0e8QPU8K/Y5tApTYukwz4mAInIZu/qyXzUGfgGsq/HvspE/IbqKw7UgtMn/bQ
 YlcdiVh214lPJmBF7DEPlpgCRRwC5WKsNb1txFzU4Yt2bv9TNwvRafj7yOZa9nppjG
 Hd8WH/rDRw4wbT0BAFhxJNR5wqV4WRTCuAUY5l5zZchcr9mO0NnqR+ug4TFpUHrGzJ
 y+Ue7H1cgeCqA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 449C3118007E;
 Mon, 16 Feb 2026 17:25:11 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v9 5/8] net/nfb: init only MACs associated with device
Date: Mon, 16 Feb 2026 17:25:03 +0100
Message-ID: <20260216162506.2702066-6-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216162506.2702066-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260216162506.2702066-1-spinler@cesnet.cz>
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

Use information obtained from the new manner of creating NFB ethdevs
and initialize only RxMACs / TxMACs associated with actual ethdev.

This enables separated management and configuration of interface ports.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  12 +--
 drivers/net/nfb/nfb_ethdev.c | 149 ++++++++++++++++++-----------------
 2 files changed, 79 insertions(+), 82 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 22fcb68cd7..ea8e4fd255 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -36,10 +36,6 @@ extern int nfb_logtype;
 #define RTE_ETH_NDP_MAX_RX_QUEUES 32
 #define RTE_ETH_NDP_MAX_TX_QUEUES 32
 
-/* Max index of rx/tx dmas */
-#define RTE_MAX_NC_RXMAC 256
-#define RTE_MAX_NC_TXMAC 256
-
 #define RTE_NFB_DRIVER_NAME net_nfb
 
 /* Device arguments */
@@ -54,10 +50,10 @@ extern int nfb_logtype;
  * Stored inside dev->process_private.
  */
 struct pmd_internals {
-	uint16_t         max_rxmac;
-	uint16_t         max_txmac;
-	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
-	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
+	uint16_t         max_rxmac;     /**< Count of valid rxmac items */
+	uint16_t         max_txmac;     /**< Count of valid txmac items */
+	struct nc_rxmac  **rxmac;       /**< Array of Rx MAC handles */
+	struct nc_txmac  **txmac;       /**< Array of Tx MAC handles */
 	struct nfb_device *nfb;
 
 	TAILQ_ENTRY(pmd_internals) eth_dev_list;  /**< Item in list of all devices */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 83601b3c2e..82b39a0bfe 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -55,81 +55,87 @@ static const struct rte_ether_addr eth_addr = {
 };
 
 /**
- * Open all RX DMA queues
+ * Open Rx and Tx MAC components associated with current ifc
  *
- * @param dev
- *   Pointer to nfb device.
- * @param[out] rxmac
- *   Pointer to output array of nc_rxmac
- * @param[out] max_rxmac
- *   Pointer to output max index of rxmac
+ * @param intl
+ *   Pointer to driver internal structure
+ * @param params
+ *   Pointer to init parameters structure
  */
-static void
-nfb_nc_rxmac_init(struct nfb_device *nfb,
-	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC],
-	uint16_t *max_rxmac)
+static int
+nfb_nc_eth_init(struct pmd_internals *intl, struct nfb_ifc_create_params *params)
 {
-	*max_rxmac = 0;
-	while ((rxmac[*max_rxmac] = nc_rxmac_open_index(nfb, *max_rxmac)))
-		++(*max_rxmac);
-}
+	int ret;
+	int i, rxm, txm;
+	struct nc_ifc_info *ifc = params->ifc_info;
+	struct nc_ifc_map_info *mi = &params->map_info;
 
-/**
- * Open all TX DMA queues
- *
- * @param dev
- *   Pointer to nfb device.
- * @param[out] txmac
- *   Pointer to output array of nc_txmac
- * @param[out] max_rxmac
- *   Pointer to output max index of txmac
- */
-static void
-nfb_nc_txmac_init(struct nfb_device *nfb,
-	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC],
-	uint16_t *max_txmac)
-{
-	*max_txmac = 0;
-	while ((txmac[*max_txmac] = nc_txmac_open_index(nfb, *max_txmac)))
-		++(*max_txmac);
-}
+	ret = -ENOMEM;
+	if (ifc->eth_cnt == 0)
+		return 0;
 
-/**
- * Close all RX DMA queues
- *
- * @param rxmac
- *   Pointer to array of nc_rxmac
- * @param max_rxmac
- *   Maximum index of rxmac
- */
-static void
-nfb_nc_rxmac_deinit(struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC],
-	uint16_t max_rxmac)
-{
-	uint16_t i;
-	for (i = 0; i < max_rxmac; i++) {
-		nc_rxmac_close(rxmac[i]);
-		rxmac[i] = NULL;
+	intl->rxmac = calloc(ifc->eth_cnt, sizeof(*intl->rxmac));
+	if (intl->rxmac == NULL)
+		goto err_alloc_rxmac;
+
+	intl->txmac = calloc(ifc->eth_cnt, sizeof(*intl->txmac));
+	if (intl->txmac == NULL)
+		goto err_alloc_txmac;
+
+	/* Some eths may not have assigned MAC nodes, hence use separate var for indexing */
+	rxm = 0;
+	txm = 0;
+	for (i = 0; i < mi->eth_cnt; i++) {
+		if (mi->eth[i].ifc != ifc->id)
+			continue;
+
+		if (rxm >= ifc->eth_cnt || txm >= ifc->eth_cnt) {
+			NFB_LOG(ERR, "MAC mapping inconsistent");
+			ret = -EINVAL;
+			goto err_map_inconsistent;
+		}
+
+		intl->rxmac[rxm] = nc_rxmac_open(intl->nfb, mi->eth[i].node_rxmac);
+		if (intl->rxmac[rxm])
+			rxm++;
+
+		intl->txmac[txm] = nc_txmac_open(intl->nfb, mi->eth[i].node_txmac);
+		if (intl->txmac[txm])
+			txm++;
 	}
+
+	intl->max_rxmac = rxm;
+	intl->max_txmac = txm;
+	return 0;
+
+err_map_inconsistent:
+	for (i = 0; i < txm; i++)
+		nc_txmac_close(intl->txmac[i]);
+	for (i = 0; i < rxm; i++)
+		nc_rxmac_close(intl->rxmac[i]);
+	free(intl->txmac);
+err_alloc_txmac:
+	free(intl->rxmac);
+err_alloc_rxmac:
+	return ret;
 }
 
 /**
- * Close all TX DMA queues
- *
- * @param txmac
- *   Pointer to array of nc_txmac
- * @param max_txmac
- *   Maximum index of txmac
+ * Close all Rx+Tx MAC components
+ * @param intl
+ *   Pointer to internal driver structure
  */
 static void
-nfb_nc_txmac_deinit(struct nc_txmac *txmac[RTE_MAX_NC_TXMAC],
-	uint16_t max_txmac)
+nfb_nc_eth_deinit(struct pmd_internals *intl)
 {
 	uint16_t i;
-	for (i = 0; i < max_txmac; i++) {
-		nc_txmac_close(txmac[i]);
-		txmac[i] = NULL;
-	}
+	for (i = 0; i < intl->max_txmac; i++)
+		nc_txmac_close(intl->txmac[i]);
+	for (i = 0; i < intl->max_rxmac; i++)
+		nc_rxmac_close(intl->rxmac[i]);
+
+	free(intl->txmac);
+	free(intl->rxmac);
 }
 
 /**
@@ -346,7 +352,7 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_SPEED_FIXED;
 
-	if (internals->rxmac[0] != NULL) {
+	if (internals->max_rxmac) {
 		nc_rxmac_read_status(internals->rxmac[0], &status);
 
 		switch (status.speed) {
@@ -571,12 +577,9 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 	max_rx_queues = ifc->rxq_cnt;
 	max_tx_queues = ifc->txq_cnt;
 
-	nfb_nc_rxmac_init(internals->nfb,
-		internals->rxmac,
-		&internals->max_rxmac);
-	nfb_nc_txmac_init(internals->nfb,
-		internals->txmac,
-		&internals->max_txmac);
+	ret = nfb_nc_eth_init(internals, params);
+	if (ret)
+		goto err_nc_eth_init;
 
 	/* Set rx, tx burst functions */
 	dev->rx_pkt_burst = nfb_eth_ndp_rx;
@@ -662,10 +665,9 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 	rte_free(priv->queue_map_rx);
 err_alloc_queue_map:
 err_secondary_not_ready:
-	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
-	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_nc_eth_deinit(internals);
+err_nc_eth_init:
 	nfb_close(internals->nfb);
-
 err_nfb_open:
 	rte_free(internals);
 err_alloc_internals:
@@ -692,8 +694,7 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 
 	TAILQ_REMOVE(&nfb_eth_dev_list, internals, eth_dev_list);
 
-	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
-	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_nc_eth_deinit(internals);
 	nfb_close(internals->nfb);
 
 	rte_free(internals);
-- 
2.53.0

