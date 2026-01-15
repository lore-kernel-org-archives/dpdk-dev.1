Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711CD44C59
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5882E427DB;
	Thu, 15 Jan 2026 15:41:15 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 0D01C4278E
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768488069;
 bh=l/a7g3s0BdtVg/YHMZMMsxUhzND4CHrqsy1SEFykT7Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lEgSvfHXKZq79Z9/z/xkuvFvmPdkGZq1z4t5NErUwDa1JAJfQg4OEWLt/VMMQxK9h
 +WiPFY6P/1xGxeWy4v75FeyKX+qeBGNMrTLX5rbOABBTOm9mQXCX86SSTdL6YYf0Sp
 wSh+HSYGDy9c3Guubwhh2A25is20lz/RDNcJVWCk0DmZgGB9Fj83vtErfh7uuBNut1
 bYDMdQm3eLwVCdnHXQY/SrkkFyZo62g/WGeQXy93cZ7HCCBwE3yIAHPGMQENCZukU6
 zJGydFIUZocKnS9T11mUb6+fUoIVi+bUFEKaXXjeaUidmD543+4+TM83V28xidtUvQ
 z5foIN71192NA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id E530F118007E;
 Thu, 15 Jan 2026 15:41:09 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 4/6] net/nfb: use process private variable for internal data
Date: Thu, 15 Jan 2026 15:40:38 +0100
Message-ID: <20260115144040.345873-5-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115144040.345873-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260115144040.345873-1-spinler@cesnet.cz>
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

Internal structures of libnfb can't be shared between processes.
Move these structures from dev_private to process_private, which allows
secondary process to correctly initialize and uninitialize the eth_dev.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  2 +
 drivers/net/nfb/nfb_ethdev.c | 99 +++++++++++++++++++++---------------
 drivers/net/nfb/nfb_rx.c     |  2 +-
 drivers/net/nfb/nfb_rxmode.c | 12 ++---
 drivers/net/nfb/nfb_tx.c     |  2 +-
 5 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 8f8577860a..d85c5fba62 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -48,7 +48,9 @@ struct pmd_internals {
 	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
 	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
 	struct nfb_device *nfb;
+};
 
+struct pmd_priv {
 	int max_rx_queues;
 	int max_tx_queues;
 };
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 7a472a5f1e..d7fa1444dd 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -145,7 +145,7 @@ nfb_eth_dev_start(struct rte_eth_dev *dev)
 	return ret;
 }
 
-/**
+/* *
  * DPDK callback to stop the device.
  *
  * Stop device by stopping all configured queues.
@@ -184,7 +184,7 @@ static int
 nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 {
 	int ret;
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_internals *internals = dev->process_private;
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
 	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
@@ -207,7 +207,7 @@ nfb_eth_get_max_mac_address_count(struct rte_eth_dev *dev)
 	uint16_t i;
 	uint32_t c;
 	uint32_t ret = (uint32_t)-1;
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_internals *internals = dev->process_private;
 
 	/*
 	 * Go through all RX MAC components in firmware and find
@@ -237,13 +237,13 @@ static int
 nfb_eth_dev_info(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_priv *priv = dev->data->dev_private;
 
 	dev_info->max_mac_addrs = nfb_eth_get_max_mac_address_count(dev);
 
 	dev_info->max_rx_pktlen = (uint32_t)-1;
-	dev_info->max_rx_queues = internals->max_rx_queues;
-	dev_info->max_tx_queues = internals->max_tx_queues;
+	dev_info->max_rx_queues = priv->max_rx_queues;
+	dev_info->max_tx_queues = priv->max_tx_queues;
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_100G;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
@@ -262,20 +262,20 @@ nfb_eth_dev_info(struct rte_eth_dev *dev,
 static int
 nfb_eth_dev_close(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_internals *internals = dev->process_private;
 	uint16_t i;
 	uint16_t nb_rx = dev->data->nb_rx_queues;
 	uint16_t nb_tx = dev->data->nb_tx_queues;
 	int ret;
 
+	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
+	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
 	ret = nfb_eth_dev_stop(dev);
 
-	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
-	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
-
 	for (i = 0; i < nb_rx; i++) {
 		nfb_eth_rx_queue_release(dev, i);
 		dev->data->rx_queues[i] = NULL;
@@ -310,7 +310,7 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 	struct rte_eth_link link;
 	memset(&link, 0, sizeof(link));
 
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_internals *internals = dev->process_private;
 
 	status.speed = MAC_SPEED_UNKNOWN;
 
@@ -365,7 +365,7 @@ static int
 nfb_eth_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 
 	uint16_t i;
 	for (i = 0; i < internals->max_rxmac; ++i)
@@ -390,7 +390,7 @@ static int
 nfb_eth_dev_set_link_down(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 
 	uint16_t i;
 	for (i = 0; i < internals->max_rxmac; ++i)
@@ -431,9 +431,8 @@ nfb_eth_mac_addr_set(struct rte_eth_dev *dev,
 {
 	unsigned int i;
 	uint64_t mac;
-	struct rte_eth_dev_data *data = dev->data;
 	struct pmd_internals *internals = (struct pmd_internals *)
-		data->dev_private;
+		dev->process_private;
 
 	mac = nfb_eth_mac_addr_conv(mac_addr);
 	/* Until no real multi-port support, configure all RX MACs the same */
@@ -449,9 +448,8 @@ nfb_eth_mac_addr_add(struct rte_eth_dev *dev,
 {
 	unsigned int i;
 	uint64_t mac;
-	struct rte_eth_dev_data *data = dev->data;
 	struct pmd_internals *internals = (struct pmd_internals *)
-		data->dev_private;
+		dev->process_private;
 
 	mac = nfb_eth_mac_addr_conv(mac_addr);
 	for (i = 0; i < internals->max_rxmac; ++i)
@@ -464,9 +462,8 @@ static void
 nfb_eth_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
 	unsigned int i;
-	struct rte_eth_dev_data *data = dev->data;
 	struct pmd_internals *internals = (struct pmd_internals *)
-		data->dev_private;
+		dev->process_private;
 
 	for (i = 0; i < internals->max_rxmac; ++i)
 		nc_rxmac_set_mac(internals->rxmac[i], index, 0, 0);
@@ -512,10 +509,11 @@ static const struct eth_dev_ops ops = {
 static int
 nfb_eth_dev_init(struct rte_eth_dev *dev)
 {
+	int ret;
 	uint32_t mac_count;
 	struct rte_eth_dev_data *data = dev->data;
-	struct pmd_internals *internals = (struct pmd_internals *)
-		data->dev_private;
+	struct pmd_internals *internals;
+	struct pmd_priv *priv = data->dev_private;
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct rte_ether_addr eth_addr_init;
@@ -525,6 +523,16 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		pci_addr->domain, pci_addr->bus, pci_addr->devid,
 		pci_addr->function);
 
+	internals = rte_zmalloc_socket("nfb_internals",
+			sizeof(struct pmd_internals), RTE_CACHE_LINE_SIZE,
+			dev->device->numa_node);
+	if (internals == NULL) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	dev->process_private = internals;
+
 	snprintf(nfb_dev, sizeof(nfb_dev),
 		"/dev/nfb/by-pci-slot/" PCI_PRI_FMT,
 		pci_addr->domain, pci_addr->bus, pci_addr->devid,
@@ -538,10 +546,11 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	internals->nfb = nfb_open(nfb_dev);
 	if (internals->nfb == NULL) {
 		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
+		rte_free(internals);
 		return -EINVAL;
 	}
-	internals->max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
-	internals->max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
+	priv->max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
+	priv->max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
 
 	NFB_LOG(INFO, "Available NDP queues RX: %u TX: %u",
 		data->nb_rx_queues, data->nb_tx_queues);
@@ -563,28 +572,31 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	/* Get link state */
 	nfb_eth_link_update(dev, 0);
 
-	/* Allocate space for MAC addresses */
-	mac_count = nfb_eth_get_max_mac_address_count(dev);
-	data->mac_addrs = rte_zmalloc(data->name,
-		sizeof(struct rte_ether_addr) * mac_count, RTE_CACHE_LINE_SIZE);
-	if (data->mac_addrs == NULL) {
-		NFB_LOG(ERR, "Could not alloc space for MAC address");
-		nfb_close(internals->nfb);
-		return -EINVAL;
-	}
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* Allocate space for MAC addresses */
+		mac_count = nfb_eth_get_max_mac_address_count(dev);
+		data->mac_addrs = rte_zmalloc(data->name,
+			sizeof(struct rte_ether_addr) * mac_count, RTE_CACHE_LINE_SIZE);
+		if (data->mac_addrs == NULL) {
+			NFB_LOG(ERR, "Could not alloc space for MAC address");
+			nfb_close(internals->nfb);
+			rte_free(internals);
+			return -EINVAL;
+		}
 
-	rte_eth_random_addr(eth_addr_init.addr_bytes);
-	eth_addr_init.addr_bytes[0] = eth_addr.addr_bytes[0];
-	eth_addr_init.addr_bytes[1] = eth_addr.addr_bytes[1];
-	eth_addr_init.addr_bytes[2] = eth_addr.addr_bytes[2];
+		rte_eth_random_addr(eth_addr_init.addr_bytes);
+		eth_addr_init.addr_bytes[0] = eth_addr.addr_bytes[0];
+		eth_addr_init.addr_bytes[1] = eth_addr.addr_bytes[1];
+		eth_addr_init.addr_bytes[2] = eth_addr.addr_bytes[2];
 
-	nfb_eth_mac_addr_set(dev, &eth_addr_init);
-	rte_ether_addr_copy(&eth_addr_init, &dev->data->mac_addrs[0]);
+		nfb_eth_mac_addr_set(dev, &eth_addr_init);
+		rte_ether_addr_copy(&eth_addr_init, &data->mac_addrs[0]);
 
-	data->promiscuous = nfb_eth_promiscuous_get(dev);
-	data->all_multicast = nfb_eth_allmulticast_get(dev);
+		data->promiscuous = nfb_eth_promiscuous_get(dev);
+		data->all_multicast = nfb_eth_allmulticast_get(dev);
 
-	dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+		data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	}
 
 	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully initialized",
 		pci_addr->domain, pci_addr->bus, pci_addr->devid,
@@ -607,9 +619,12 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_pci_addr *pci_addr = &pci_dev->addr;
+	struct pmd_internals *internals = dev->process_private;
 
 	nfb_eth_dev_close(dev);
 
+	rte_free(internals);
+
 	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully uninitialized",
 		pci_addr->domain, pci_addr->bus, pci_addr->devid,
 		pci_addr->function);
@@ -644,7 +659,7 @@ nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		struct rte_pci_device *pci_dev)
 {
 	return rte_eth_dev_pci_generic_probe(pci_dev,
-		sizeof(struct pmd_internals), nfb_eth_dev_init);
+		sizeof(struct pmd_priv), nfb_eth_dev_init);
 }
 
 /**
diff --git a/drivers/net/nfb/nfb_rx.c b/drivers/net/nfb/nfb_rx.c
index 462bc3b50d..413d275853 100644
--- a/drivers/net/nfb/nfb_rx.c
+++ b/drivers/net/nfb/nfb_rx.c
@@ -60,7 +60,7 @@ nfb_eth_rx_queue_setup(struct rte_eth_dev *dev,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool)
 {
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_internals *internals = dev->process_private;
 
 	struct ndp_rx_queue *rxq;
 	int ret;
diff --git a/drivers/net/nfb/nfb_rxmode.c b/drivers/net/nfb/nfb_rxmode.c
index ca6e4d5578..dc560d638b 100644
--- a/drivers/net/nfb/nfb_rxmode.c
+++ b/drivers/net/nfb/nfb_rxmode.c
@@ -11,7 +11,7 @@ int
 nfb_eth_promiscuous_enable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 	uint16_t i;
 
 	for (i = 0; i < internals->max_rxmac; ++i) {
@@ -26,7 +26,7 @@ int
 nfb_eth_promiscuous_disable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 	uint16_t i;
 	enum nc_rxmac_mac_filter filter = RXMAC_MAC_FILTER_TABLE_BCAST;
 
@@ -44,7 +44,7 @@ int
 nfb_eth_promiscuous_get(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 
 	struct nc_rxmac_status status;
 	status.mac_filter = RXMAC_MAC_FILTER_PROMISCUOUS;
@@ -59,7 +59,7 @@ int
 nfb_eth_allmulticast_enable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 
 	uint16_t i;
 	if (dev->data->promiscuous)
@@ -76,7 +76,7 @@ int
 nfb_eth_allmulticast_disable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 
 	uint16_t i;
 
@@ -95,7 +95,7 @@ int
 nfb_eth_allmulticast_get(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->data->dev_private;
+		dev->process_private;
 
 	struct nc_rxmac_status status;
 	status.mac_filter = RXMAC_MAC_FILTER_PROMISCUOUS;
diff --git a/drivers/net/nfb/nfb_tx.c b/drivers/net/nfb/nfb_tx.c
index cf99268c43..1f997ce22f 100644
--- a/drivers/net/nfb/nfb_tx.c
+++ b/drivers/net/nfb/nfb_tx.c
@@ -53,7 +53,7 @@ nfb_eth_tx_queue_setup(struct rte_eth_dev *dev,
 	unsigned int socket_id,
 	const struct rte_eth_txconf *tx_conf __rte_unused)
 {
-	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_internals *internals = dev->process_private;
 	int ret;
 	struct ndp_tx_queue *txq;
 
-- 
2.52.0

