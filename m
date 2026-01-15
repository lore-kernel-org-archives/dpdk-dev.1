Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D451D44C61
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 15:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9594542831;
	Thu, 15 Jan 2026 16:17:09 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id D192F40BA6
 for <dev@dpdk.org>; Thu, 15 Jan 2026 16:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768490223;
 bh=RNqTPFe7rzQ0zRlymHXfrJ+Rom7dJ4cPClBlvzt/Zqg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KJ9GKI6kYI2QJetSUnaLfBS3sElb7wS2jp8BqNBD6NGWUCas+CYiB/3i0t2mn7K4d
 oEN8DUCSApW8iSPwiidA/W8VvjW0IAsrr8zYGO5Epx8ek7BqY3WExIwxaYp/bhgNg1
 y7O/OqZ2pmoNXkW1t0MTArgflYRS/kkKMFi+LhlkjGE5l330ysRVBuajlQsC305ZoH
 HbH9vtEM0Bfs4yKw5pmqcwLk5zapLr2cej6NYEDRH8vPT6LzXUo+cD4QSpPmQ1SUlz
 4qug5NQxbErGFZ7jRls3/+ONkIKX262VvcoRt2NSiZ70ZIM+JhmHDQ240Vxciz5f7M
 Qyx98Dq2gfYog==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id B4AAB1180089;
 Thu, 15 Jan 2026 16:17:03 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 5/8] net/nfb: init only MACs associated with device
Date: Thu, 15 Jan 2026 16:16:53 +0100
Message-ID: <20260115151656.393106-6-spinler@cesnet.cz>
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

Use informations obtained from the new manner of creating NFB ethdevs
and initialize only RxMACs / TxMACs associated with actual ethdev.

This enables separated management and configuration of interface ports.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |   9 +--
 drivers/net/nfb/nfb_ethdev.c | 136 +++++++++++++++++++----------------
 2 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 86fcc1862c..8a4e79a479 100644
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
@@ -56,9 +52,8 @@ static const char * const VALID_KEYS[] = {
 struct pmd_internals {
 	uint16_t         max_rxmac;
 	uint16_t         max_txmac;
-	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
-	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
-
+	struct nc_rxmac **rxmac;
+	struct nc_txmac **txmac;
 	int             *queue_map_rx;
 	int             *queue_map_tx;
 
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 7f0303e389..53925bef9e 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -39,81 +39,95 @@ static const struct rte_ether_addr eth_addr = {
 };
 
 /**
- * Open all RX DMA queues
+ * Open RX MAC components associated with current ifc
  *
- * @param dev
- *   Pointer to nfb device.
- * @param[out] rxmac
- *   Pointer to output array of nc_rxmac
- * @param[out] max_rxmac
- *   Pointer to output max index of rxmac
+ * @param priv
+ *   Pointer to driver private structure
+ * @param params
+ *   Pointer to init parameters structure
  */
-static void
-nfb_nc_rxmac_init(struct nfb_device *nfb,
-	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC],
-	uint16_t *max_rxmac)
+static int
+nfb_nc_rxmac_init(struct pmd_internals *priv, struct nfb_init_params *params)
 {
-	*max_rxmac = 0;
-	while ((rxmac[*max_rxmac] = nc_rxmac_open_index(nfb, *max_rxmac)))
-		++(*max_rxmac);
+	int i, j;
+	struct nc_ifc_info *ifc = params->ifc_info;
+	struct nc_ifc_map_info *mi = &params->map_info;
+
+	priv->rxmac = rte_zmalloc("NFB RxMAC", sizeof(*priv->rxmac) * ifc->eth_cnt, 0);
+	if (priv->rxmac == NULL)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < mi->eth_cnt && j < ifc->eth_cnt; i++) {
+		if (mi->eth[i].ifc != ifc->id)
+			continue;
+		priv->rxmac[j] = nc_rxmac_open(priv->nfb, mi->eth[i].node_rxmac);
+		if (priv->rxmac[j])
+			j++;
+	}
+
+	priv->max_rxmac = j;
+	return 0;
 }
 
 /**
- * Open all TX DMA queues
+ * Open TX MAC components associated with current ifc
  *
- * @param dev
- *   Pointer to nfb device.
- * @param[out] txmac
- *   Pointer to output array of nc_txmac
- * @param[out] max_rxmac
- *   Pointer to output max index of txmac
+ * @param priv
+ *   Pointer to driver private structure
+ * @param params
+ *   Pointer to init parameters structure
  */
-static void
-nfb_nc_txmac_init(struct nfb_device *nfb,
-	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC],
-	uint16_t *max_txmac)
+static int
+nfb_nc_txmac_init(struct pmd_internals *priv, struct nfb_init_params *params)
 {
-	*max_txmac = 0;
-	while ((txmac[*max_txmac] = nc_txmac_open_index(nfb, *max_txmac)))
-		++(*max_txmac);
+
+	int i, j;
+	struct nc_ifc_info *ifc = params->ifc_info;
+	struct nc_ifc_map_info *mi = &params->map_info;
+
+	priv->txmac = rte_zmalloc("NFB TxMAC", sizeof(*priv->txmac) * ifc->eth_cnt, 0);
+	if (priv->txmac == NULL)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < mi->eth_cnt && j < ifc->eth_cnt; i++) {
+		if (mi->eth[i].ifc != ifc->id)
+			continue;
+		priv->txmac[j] = nc_txmac_open(priv->nfb, mi->eth[i].node_txmac);
+		if (priv->txmac[j])
+			j++;
+	}
+
+	priv->max_txmac = j;
+	return 0;
 }
 
 /**
- * Close all RX DMA queues
- *
- * @param rxmac
- *   Pointer to array of nc_rxmac
- * @param max_rxmac
- *   Maximum index of rxmac
+ * Close all RX MAC components
+ * @param priv
+ *   Pointer to driver private structure
  */
 static void
-nfb_nc_rxmac_deinit(struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC],
-	uint16_t max_rxmac)
+nfb_nc_rxmac_deinit(struct pmd_internals *priv)
 {
 	uint16_t i;
-	for (i = 0; i < max_rxmac; i++) {
-		nc_rxmac_close(rxmac[i]);
-		rxmac[i] = NULL;
-	}
+	for (i = 0; i < priv->max_rxmac; i++)
+		nc_rxmac_close(priv->rxmac[i]);
+
+	rte_free(priv->rxmac);
 }
 
 /**
- * Close all TX DMA queues
- *
- * @param txmac
- *   Pointer to array of nc_txmac
- * @param max_txmac
- *   Maximum index of txmac
+ * Close all TX MAC components
+ * @param priv
+ *   Pointer to driver private structure
  */
 static void
-nfb_nc_txmac_deinit(struct nc_txmac *txmac[RTE_MAX_NC_TXMAC],
-	uint16_t max_txmac)
+nfb_nc_txmac_deinit(struct pmd_internals *priv)
 {
 	uint16_t i;
-	for (i = 0; i < max_txmac; i++) {
-		nc_txmac_close(txmac[i]);
-		txmac[i] = NULL;
-	}
+	for (i = 0; i < priv->max_txmac; i++)
+		nc_txmac_close(priv->txmac[i]);
+	rte_free(priv->txmac);
 }
 
 /**
@@ -330,7 +344,7 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_SPEED_FIXED;
 
-	if (internals->rxmac[0] != NULL) {
+	if (internals->max_rxmac) {
 		nc_rxmac_read_status(internals->rxmac[0], &status);
 
 		switch (status.speed) {
@@ -549,12 +563,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 		goto err_nfb_open;
 	}
 
-	nfb_nc_rxmac_init(internals->nfb,
-		internals->rxmac,
-		&internals->max_rxmac);
-	nfb_nc_txmac_init(internals->nfb,
-		internals->txmac,
-		&internals->max_txmac);
+	nfb_nc_rxmac_init(internals, params);
+	nfb_nc_txmac_init(internals, params);
 
 	/* Set rx, tx burst functions */
 	dev->rx_pkt_burst = nfb_eth_ndp_rx;
@@ -623,8 +633,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 err_malloc_mac_addrs:
 	rte_free(internals->queue_map_rx);
 err_alloc_queue_map:
-	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
-	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_nc_rxmac_deinit(internals);
+	nfb_nc_txmac_deinit(internals);
 	nfb_close(internals->nfb);
 
 err_nfb_open:
@@ -649,8 +659,8 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 
 	TAILQ_REMOVE(&nfb_eth_dev_list, internals, eth_dev_list);
 
-	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
-	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_nc_rxmac_deinit(internals);
+	nfb_nc_txmac_deinit(internals);
 	nfb_close(internals->nfb);
 
 	rte_free(internals->queue_map_rx);
-- 
2.52.0

