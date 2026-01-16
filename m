Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408AFC982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 16:45:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EF2B42E61;
	Fri, 16 Jan 2026 17:44:49 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 4430842E4B
 for <dev@dpdk.org>; Fri, 16 Jan 2026 17:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768581885;
 bh=6fhVXUSNS0yOqGp+DmhatfG4Bz+xlqm3lVVH/bi4NtE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cFHySy/QL3EetZyhC8PUhbqJnYTSGJ9m2WLSlQJovjB2Me+am3Rv3WlVEmLY7MuJG
 F5QDJzijT5p30bvqRHt3tWSpz004HEXn0I5EYm9DIniKKJgjPWXhX901K/XFh4e391
 sHGHcQVXczNvnzcjGboi06adx8IzDzWfvec2G1cBuYq9AszorLuqFKiQwAhffykImh
 by2lGuH8/tb/DK4LZ1wua9S0GYg31PIvCCfyBLFKa6k+oCw7dWH/TfM0dBeh2yQTWb
 OvSEbeHdSma8s1BesKkjvwVAhu7XrdukG9bg9j4vfQ0go4rK+3Pu8yhqv7XEVbhpQI
 3SVwEC5FyQFjQ==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 1414B1180082;
 Fri, 16 Jan 2026 17:44:45 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 2/8] net/nfb: create ethdev for every eth port/channel
Date: Fri, 16 Jan 2026 17:44:30 +0100
Message-ID: <20260116164436.1649047-3-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116164436.1649047-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260116164436.1649047-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb.h        |  24 +++++
 drivers/net/nfb/nfb_ethdev.c | 180 ++++++++++++++++++++++++++---------
 2 files changed, 159 insertions(+), 45 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 0361859fc1..bd381d4320 100644
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
 
@@ -59,4 +63,24 @@ struct pmd_priv {
 	uint16_t max_tx_queues;
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
+int
+nfb_eth_common_probe(struct rte_device *device,
+		ethdev_bus_specific_init specific_init, void *specific_device,
+		struct nfb_init_params *params, int ep_index);
+__rte_internal
+int nfb_eth_common_remove(struct rte_device *dev);
+
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 238a3004c5..2afd2a42db 100644
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
@@ -507,22 +518,18 @@ static const struct eth_dev_ops ops = {
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
@@ -534,27 +541,13 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 
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
-		priv->max_rx_queues, priv->max_tx_queues);
 
 	nfb_nc_rxmac_init(internals->nfb,
 		internals->rxmac,
@@ -567,6 +560,10 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	dev->rx_pkt_burst = nfb_eth_ndp_rx;
 	dev->tx_pkt_burst = nfb_eth_ndp_tx;
 
+	/* Get number of available DMA RX and TX queues */
+	priv->max_rx_queues = ifc->rxq_cnt;
+	priv->max_tx_queues = ifc->txq_cnt;
+
 	internals->queue_map_rx = rte_malloc("NFB queue map",
 			sizeof(*internals->queue_map_rx) *
 			(priv->max_rx_queues + priv->max_tx_queues), 0);
@@ -576,11 +573,17 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	}
 	internals->queue_map_tx = internals->queue_map_rx + priv->max_rx_queues;
 
-	/* default queue mapping is 1:1 */
-	for (i = 0; i < priv->max_rx_queues; i++)
-		internals->queue_map_rx[i] = i;
-	for (i = 0; i < priv->max_tx_queues; i++)
-		internals->queue_map_tx[i] = i;
+	cnt = 0;
+	for (i = 0; i < mi->rxq_cnt; i++) {
+		if (mi->rxq[i].ifc == ifc->id)
+			internals->queue_map_rx[cnt++] = mi->rxq[i].id;
+	}
+
+	cnt = 0;
+	for (i = 0; i < mi->txq_cnt; i++) {
+		if (mi->txq[i].ifc == ifc->id)
+			internals->queue_map_tx[cnt++] = mi->txq[i].id;
+	}
 
 	/* Set function callbacks for Ethernet API */
 	dev->dev_ops = &ops;
@@ -590,9 +593,9 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 
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
@@ -613,10 +616,6 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 	}
 
-	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully initialized",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
-
 	return 0;
 
 err_malloc_mac_addrs:
@@ -644,10 +643,10 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
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
@@ -655,9 +654,61 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	rte_free(internals->queue_map_rx);
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
@@ -688,8 +739,47 @@ static int
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
+	 * find the base char device ID for the current PCI device
+	 */
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
@@ -706,7 +796,7 @@ nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 static int
 nfb_eth_pci_remove(struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_remove(pci_dev, nfb_eth_dev_uninit);
+	return nfb_eth_common_remove(&pci_dev->device);
 }
 
 static struct rte_pci_driver nfb_eth_driver = {
-- 
2.52.0

