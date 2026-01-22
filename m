Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D1C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2399440299;
	Thu, 22 Jan 2026 08:27:33 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 74BAD40156
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769066849;
 bh=XvqCUtyQ7NgiN1UZ7DhoUZRw3JWRGFcJHeaslCCwtRc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h0fs7EV6fbhyOYIV6i96yiUrpPfTL1UNS6gKEt23heZCXJW4gEDZ60gpnvjb38jmo
 iaRZEiqxhWjIpFOaP/8YYhkRo9VYkmk5ulKMJOmIsCld3uqex70Q7zu3/yYLx8TMYB
 pooVd1JjTiscW0/Ke47r9RzEBr5umhQbtexysUUmZZCsgsekbeOWg17P7c1sarHkiO
 9ObFXYyhBHxKmSMzocqIbczRVvnq+Z1/IrBX1QJ7R4eM5VIoL6DNGmAhtQi7B5HnML
 SnKfX1A4AmA5lR2Jw2VD8phszmYTWiUJuo30uFb3qAtyQsdHGhu12mbsSHh3LTsGjp
 UziHo/hwyMTog==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 3ADED1180080;
 Thu, 22 Jan 2026 08:27:29 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 2/8] net/nfb: create ethdev for every eth port/channel
Date: Thu, 22 Jan 2026 08:27:13 +0100
Message-ID: <20260122072719.505185-3-spinler@cesnet.cz>
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

The existing driver creates one ethdev/port for one PCI device.
As the CESNET-NDK-based cards are mostly unable to represent
each physical port with one PCI device, this atypical behaviour
often limits the user.

The nfb-framework comes with generic port representation API,
which provides information about ports and their mapping to firmware
resource (physical ports, DMA queues, processing pipelines).

This driver design switches from one rte_eth_dev_pci_generic_probe call
to multiple rte_eth_dev_create calls, while parses the firmware mapping
information.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  23 +++++
 drivers/net/nfb/nfb_ethdev.c | 181 ++++++++++++++++++++++++++---------
 2 files changed, 160 insertions(+), 44 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 3821732c37..d0d46f4a38 100644
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
 	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
 	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
 	struct nfb_device *nfb;
+
+	TAILQ_ENTRY(pmd_internals) eth_dev_list;
+	struct rte_eth_dev *eth_dev;
 };
 
 /*
@@ -65,4 +69,23 @@ struct pmd_priv {
 	int             *queue_map_tx;
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
+__rte_internal
+int nfb_eth_common_probe(struct rte_device *device,
+		ethdev_bus_specific_init specific_init, void *specific_device,
+		struct nfb_init_params *params, int ep_index);
+__rte_internal
+int nfb_eth_common_remove(struct rte_device *dev);
+
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 803815138c..3c009fc1a4 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -4,6 +4,10 @@
  * All rights reserved.
  */
 
+#include <sys/queue.h>
+#include <eal_export.h>
+#include <rte_tailq.h>
+
 #include <nfb/nfb.h>
 #include <nfb/ndp.h>
 #include <netcope/rxmac.h>
@@ -18,6 +22,13 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+/* The TAILQ entries are used for cleanup of allocated resources
+ * in situations, where dev_close is not called.
+ */
+TAILQ_HEAD(pmd_internals_head, pmd_internals);
+static struct pmd_internals_head nfb_eth_dev_list =
+	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
+
 static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
 
 /**
@@ -507,23 +518,19 @@ static const struct eth_dev_ops ops = {
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
 	uint16_t max_rx_queues, max_tx_queues;
-	char nfb_dev[PATH_MAX];
-
-	NFB_LOG(INFO, "Initializing NFB device (" PCI_PRI_FMT ")",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
 
 	internals = rte_zmalloc_socket("nfb_internals",
 			sizeof(struct pmd_internals), RTE_CACHE_LINE_SIZE,
@@ -535,27 +542,17 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 
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
-	max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
-	max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
 
-	NFB_LOG(INFO, "Available NDP queues RX: %u TX: %u",
-		max_rx_queues, max_tx_queues);
+	/* Get number of available DMA RX and TX queues */
+	max_rx_queues = ifc->rxq_cnt;
+	max_tx_queues = ifc->txq_cnt;
 
 	nfb_nc_rxmac_init(internals->nfb,
 		internals->rxmac,
@@ -586,16 +583,23 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		}
 		priv->queue_map_tx = priv->queue_map_rx + max_rx_queues;
 
-		/* default queue mapping is 1:1 */
-		for (i = 0; i < max_rx_queues; i++)
-			priv->queue_map_rx[i] = i;
-		for (i = 0; i < max_tx_queues; i++)
-			priv->queue_map_tx[i] = i;
+		/* Use queue mapping provided by libnfb */
+		cnt = 0;
+		for (i = 0; i < mi->rxq_cnt; i++) {
+			if (mi->rxq[i].ifc == ifc->id)
+				priv->queue_map_rx[cnt++] = mi->rxq[i].id;
+		}
+
+		cnt = 0;
+		for (i = 0; i < mi->txq_cnt; i++) {
+			if (mi->txq[i].ifc == ifc->id)
+				priv->queue_map_tx[cnt++] = mi->txq[i].id;
+		}
 
 		/* Allocate space for MAC addresses */
-		mac_count = nfb_eth_get_max_mac_address_count(dev);
+		cnt = nfb_eth_get_max_mac_address_count(dev);
 		data->mac_addrs = rte_zmalloc(data->name,
-			sizeof(struct rte_ether_addr) * mac_count, RTE_CACHE_LINE_SIZE);
+			sizeof(struct rte_ether_addr) * cnt, RTE_CACHE_LINE_SIZE);
 		if (data->mac_addrs == NULL) {
 			NFB_LOG(ERR, "Could not alloc space for MAC address");
 			ret = -ENOMEM;
@@ -616,10 +620,6 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 	}
 
-	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully initialized",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
-
 	return 0;
 
 err_malloc_mac_addrs:
@@ -647,23 +647,75 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 static int
 nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
-	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct pmd_internals *internals = dev->process_private;
 	struct pmd_priv *priv = dev->data->dev_private;
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
 		rte_free(priv->queue_map_rx);
 
+	TAILQ_REMOVE(&nfb_eth_dev_list, internals, eth_dev_list);
+
 	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
 	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
 	nfb_close(internals->nfb);
 
 	rte_free(internals);
 
-	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully uninitialized",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_probe)
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
+		ifc = &params->map_info.ifc[i];
+		params->ifc_info = ifc;
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
@@ -694,8 +746,49 @@ static int
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
+	/*
+	 * NFB device can be composed from multiple PCI devices,
+	 * find the base char device ID for the current PCI device
+	 */
+	ret = nc_get_composed_device_info_by_pci(NULL, params.name, &comp_dev_info);
+	if (ret) {
+		NFB_LOG(ERR, "Could not find NFB device for %s", params.name);
+		return -ENODEV;
+	}
+
+	ret = snprintf(path, sizeof(path), NFB_BASE_DEV_PATH "%d", comp_dev_info.nfb_id);
+	if (ret < 0 || ret >= (signed int)sizeof(path))
+		return -EINVAL;
+
+	params.args = pci_dev->device.devargs ? pci_dev->device.devargs->args : NULL;
+	params.path = path;
+	params.nfb_id = comp_dev_info.nfb_id;
+
+	return nfb_eth_common_probe(&pci_dev->device, eth_dev_pci_specific_init, pci_dev, &params,
+			comp_dev_info.ep_index);
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(nfb_eth_common_remove)
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
@@ -712,7 +805,7 @@ nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 static int
 nfb_eth_pci_remove(struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_remove(pci_dev, nfb_eth_dev_uninit);
+	return nfb_eth_common_remove(&pci_dev->device);
 }
 
 static struct rte_pci_driver nfb_eth_driver = {
-- 
2.52.0

