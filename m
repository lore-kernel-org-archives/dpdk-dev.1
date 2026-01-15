Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D3D44C63
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 15:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7CDC427C7;
	Thu, 15 Jan 2026 16:17:06 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 9A32740EE4
 for <dev@dpdk.org>; Thu, 15 Jan 2026 16:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768490223;
 bh=ixabn+DDD7VL3HqTZpogBzX6E7qkrNaOkJcuBQlpmpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i5be4NGRxCBJRqhoLLheobHByv8WMoFK/cyJ0Syw7InGKUaUlR8Pxt27sk2tVp13B
 op6b9bXuWoeaTElMvlTQnS0AAYnNh1U96ansRypR5hkXpynGfhXyN4Wk2+bWD6x/7x
 CoQP2rJKK62w7TpmB14wyeQ/vGJGT7CVvOp+3cizdGhY0b3oGM4bID+ozuRtT1s6Wm
 uJUWAI2V6DjAutrTaBBCn1yf7Cc/DrPgi7IVpfN7+bM45ohZHdCamRkEu4SunLn7Gd
 suKJjPZfQ3SRyYsDCxG5MywYr8BcTyLnAwE8OOYgh6x+7bpdW0LS6V4T+7BFnaAFp+
 TV6MCv+6qnD1Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 6646B1180086;
 Thu, 15 Jan 2026 16:17:03 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 2/8] net/nfb: create ethdev for every eth port/channel
Date: Thu, 15 Jan 2026 16:16:50 +0100
Message-ID: <20260115151656.393106-3-spinler@cesnet.cz>
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

The existing driver creates one ethdev/port for one PCI device.
As the CESNET-NDK-based cards are mostly unable to represent
each physical port with one PCI device, this atypical behaviour
often limits the user.

The nfb-framework comes with generic port representation API,
which provides information about ports and their mapping to firmware
resource (physical ports, DMA queues, processing pipelines).

This driver design switches from one rte_eth_dev_pci_generic_probe call
to multiple rte_eth_dev_create calls, while parses the firmware mapping
informations.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  22 +++++
 drivers/net/nfb/nfb_ethdev.c | 175 ++++++++++++++++++++++++++---------
 2 files changed, 152 insertions(+), 45 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index ef41d100ac..9c0d1a06f8 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -11,6 +11,7 @@
 #include <nfb/ndp.h>
 #include <netcope/rxmac.h>
 #include <netcope/txmac.h>
+#include <netcope/info.h>
 
 extern int nfb_logtype;
 #define RTE_LOGTYPE_NFB nfb_logtype
@@ -51,6 +52,9 @@ struct pmd_internals {
 	int             *queue_map_rx;
 	int             *queue_map_tx;
 
+	TAILQ_ENTRY(pmd_internals) eth_dev_list;
+	struct rte_eth_dev *eth_dev;
+
 	struct nfb_device *nfb;
 };
 
@@ -59,4 +63,22 @@ struct pmd_priv {
 	int max_tx_queues;
 };
 
+struct nfb_init_params {
+	const char *path;
+	const char *args;
+	int nfb_id;
+
+	struct nc_ifc_map_info map_info;
+	struct nc_ifc_info *ifc_info;
+
+	char name[RTE_DEV_NAME_MAX_LEN];
+};
+
+
+int
+nfb_eth_common_probe(struct rte_device *device,
+		ethdev_bus_specific_init specific_init, void *specific_device,
+		struct nfb_init_params *params, int ep_index);
+int nfb_eth_common_remove(struct rte_device *dev);
+
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 247f78fe24..4a6648059e 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -4,6 +4,9 @@
  * All rights reserved.
  */
 
+#include <sys/queue.h>
+#include <rte_tailq.h>
+
 #include <nfb/nfb.h>
 #include <nfb/ndp.h>
 #include <netcope/rxmac.h>
@@ -19,6 +22,13 @@
 #include "nfb.h"
 
 
+/* The TAILQ entries are used for cleanup of allocated resources
+ * in situations, where dev_close is not called.
+ */
+TAILQ_HEAD(pmd_internals_head, pmd_internals);
+static struct pmd_internals_head nfb_eth_dev_list =
+                TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
+
 static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
 
 /**
@@ -508,22 +518,18 @@ static const struct eth_dev_ops ops = {
  *   0 on success, a negative errno value otherwise.
  */
 static int
-nfb_eth_dev_init(struct rte_eth_dev *dev)
+nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 {
 	int i;
+	int cnt;
 	int ret;
-	uint32_t mac_count;
 	struct rte_eth_dev_data *data = dev->data;
 	struct pmd_internals *internals;
+	struct nfb_init_params *params = init_data;
+	struct nc_ifc_info *ifc = params->ifc_info;
+	struct nc_ifc_map_info *mi = &params->map_info;
 	struct pmd_priv *priv = data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
-	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct rte_ether_addr eth_addr_init;
-	char nfb_dev[PATH_MAX];
-
-	NFB_LOG(INFO, "Initializing NFB device (" PCI_PRI_FMT ")",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
 
 	internals = rte_zmalloc_socket("nfb_internals",
 			sizeof(struct pmd_internals), RTE_CACHE_LINE_SIZE,
@@ -535,27 +541,13 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 
 	dev->process_private = internals;
 
-	snprintf(nfb_dev, sizeof(nfb_dev),
-		"/dev/nfb/by-pci-slot/" PCI_PRI_FMT,
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
-
-	/*
-	 * Get number of available DMA RX and TX queues, which is maximum
-	 * number of queues that can be created and store it in private device
-	 * data structure.
-	 */
-	internals->nfb = nfb_open(nfb_dev);
+	/* Open device handle */
+	internals->nfb = nfb_open(params->path);
 	if (internals->nfb == NULL) {
-		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
+		NFB_LOG(ERR, "nfb_open(): failed to open %s", params->path);
 		ret = -EINVAL;
 		goto err_nfb_open;
 	}
-	priv->max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
-	priv->max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
-
-	NFB_LOG(INFO, "Available NDP queues RX: %u TX: %u",
-		data->nb_rx_queues, data->nb_tx_queues);
 
 	nfb_nc_rxmac_init(internals->nfb,
 		internals->rxmac,
@@ -568,6 +560,10 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	dev->rx_pkt_burst = nfb_eth_ndp_rx;
 	dev->tx_pkt_burst = nfb_eth_ndp_tx;
 
+	/* Get number of available DMA RX and TX queues */
+	priv->max_rx_queues = ifc->rxq_cnt;
+	priv->max_tx_queues = ifc->txq_cnt;
+
 	internals->queue_map_rx = rte_malloc("NFB queue map",
 			sizeof(*internals->queue_map_rx) *
 			(priv->max_rx_queues + priv->max_tx_queues), 0);
@@ -577,12 +573,18 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	}
 	internals->queue_map_tx = internals->queue_map_rx + priv->max_rx_queues;
 
-	/* default queue mapping is 1:1 */
-	for (i = 0; i < priv->max_rx_queues; i++) {
-		internals->queue_map_rx[i] = i;
+	cnt = 0;
+	for (i = 0; i < mi->rxq_cnt; i++) {
+		if (mi->rxq[i].ifc == ifc->id) {
+			internals->queue_map_rx[cnt++] = mi->rxq[i].id;
+		}
 	}
-	for (i = 0; i < priv->max_tx_queues; i++) {
-		internals->queue_map_tx[i] = i;
+
+	cnt = 0;
+	for (i = 0; i < mi->txq_cnt; i++) {
+		if (mi->txq[i].ifc == ifc->id) {
+			internals->queue_map_tx[cnt++] = mi->txq[i].id;
+		}
 	}
 
 	/* Set function callbacks for Ethernet API */
@@ -593,9 +595,9 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* Allocate space for MAC addresses */
-		mac_count = nfb_eth_get_max_mac_address_count(dev);
+		cnt = nfb_eth_get_max_mac_address_count(dev);
 		data->mac_addrs = rte_zmalloc(data->name,
-			sizeof(struct rte_ether_addr) * mac_count, RTE_CACHE_LINE_SIZE);
+			sizeof(struct rte_ether_addr) * cnt, RTE_CACHE_LINE_SIZE);
 		if (data->mac_addrs == NULL) {
 			NFB_LOG(ERR, "Could not alloc space for MAC address");
 			ret = -ENOMEM;
@@ -616,10 +618,6 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 	}
 
-	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully initialized",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
-
 	return 0;
 
 err_malloc_mac_addrs:
@@ -647,10 +645,10 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 static int
 nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
-	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct pmd_internals *internals = dev->process_private;
 
+	TAILQ_REMOVE(&nfb_eth_dev_list, internals, eth_dev_list);
+
 	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
 	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
 	nfb_close(internals->nfb);
@@ -658,9 +656,59 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	rte_free(internals->queue_map_rx);
 	rte_free(internals);
 
-	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully uninitialized",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
+	return 0;
+}
+
+int
+nfb_eth_common_probe(struct rte_device *device,
+		ethdev_bus_specific_init specific_init, void *specific_device,
+		struct nfb_init_params *params, int ep_index)
+{
+	int i;
+	int ret;
+	int basename_len;
+
+	struct nc_ifc_info *ifc;
+	struct nfb_device *nfb_dev;
+	struct rte_eth_dev *eth_dev;
+	struct pmd_internals *p;
+
+	basename_len = strlen(params->name);
+
+	nfb_dev = nfb_open(params->path);
+	if (nfb_dev == NULL) {
+		NFB_LOG(ERR, "nfb_open(): failed to open %s", params->path);
+		return -EINVAL;
+	}
+
+	nc_ifc_map_info_create_ordinary(nfb_dev, &params->map_info);
+
+	for (i = 0; i < params->map_info.ifc_cnt; i++) {
+		ifc = params->ifc_info = &params->map_info.ifc[i];
+
+		/* Skip interfaces which doesn't belong to this PCI device */
+		if ((ep_index != -1 && ifc->ep != ep_index) ||
+				(ifc->flags & NC_IFC_INFO_FLAG_ACTIVE) == 0)
+			continue;
+
+		snprintf(params->name + basename_len, sizeof(params->name) - basename_len,
+				"_eth%d", params->ifc_info->id);
+
+		ret = rte_eth_dev_create(device, params->name,
+				sizeof(struct pmd_priv),
+				specific_init, specific_device,
+				nfb_eth_dev_init, params);
+
+		if (ret == 0) {
+			eth_dev = rte_eth_dev_get_by_name(params->name);
+			p = eth_dev->process_private;
+			p->eth_dev = eth_dev;
+			TAILQ_INSERT_TAIL(&nfb_eth_dev_list, p, eth_dev_list);
+		}
+	}
+
+	nc_map_info_destroy(&params->map_info);
+	nfb_close(nfb_dev);
 
 	return 0;
 }
@@ -691,8 +739,45 @@ static int
 nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_probe(pci_dev,
-		sizeof(struct pmd_priv), nfb_eth_dev_init);
+	int ret;
+	char path[PATH_MAX];
+
+	struct nc_composed_device_info comp_dev_info;
+	struct nfb_init_params params = {0};
+
+	rte_pci_device_name(&pci_dev->addr, params.name, sizeof(params.name));
+
+	/* NFB device can be composed from multiple PCI devices,
+	 * find the base char device ID for the current PCI device */
+	ret = nc_get_composed_device_info_by_pci(NULL, params.name, &comp_dev_info);
+	if (ret) {
+		NFB_LOG(ERR, "Could not find NFB device for %s", params.name);
+		return -ENODEV;
+	}
+
+	ret = snprintf(path, sizeof(path), NFB_BASE_DEV_PATH "%d", comp_dev_info.nfb_id);
+	RTE_ASSERT(ret > 0 && ret < sizeof(path));
+
+	params.args = pci_dev->device.devargs ? pci_dev->device.devargs->args : NULL;
+	params.path = path;
+	params.nfb_id = comp_dev_info.nfb_id;
+
+	return nfb_eth_common_probe(&pci_dev->device, eth_dev_pci_specific_init, pci_dev, &params,
+			comp_dev_info.ep_index);
+}
+
+int
+nfb_eth_common_remove(struct rte_device *dev)
+{
+	struct pmd_internals *entry, *temp;
+
+	RTE_TAILQ_FOREACH_SAFE(entry, &nfb_eth_dev_list, eth_dev_list, temp) {
+		if (dev == entry->eth_dev->device) {
+			TAILQ_REMOVE(&nfb_eth_dev_list, entry, eth_dev_list);
+			rte_eth_dev_destroy(entry->eth_dev, nfb_eth_dev_uninit);
+		}
+	}
+	return 0;
 }
 
 /**
@@ -709,7 +794,7 @@ nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 static int
 nfb_eth_pci_remove(struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_remove(pci_dev, nfb_eth_dev_uninit);
+	return nfb_eth_common_remove(&pci_dev->device);
 }
 
 static struct rte_pci_driver nfb_eth_driver = {
-- 
2.52.0

