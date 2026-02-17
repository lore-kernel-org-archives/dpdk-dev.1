Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470D3E63F29
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 07:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 692B040648;
	Tue, 17 Feb 2026 08:10:47 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 22EC14029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 08:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771312243;
 bh=lzgM9uPGZKu3596zwWI7yRfrhsJvyhGIxsk6Docu2Vg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OyNdTQGzPoisjqLBqNmFLO4mlN+BTjU9punE8DrKjAvlHVmv3KIWssrGOKxDqYJwI
 7GtCRjQWpP2WWmSHJk1BkkxaeIDLf8XDitEzj5EAN70cR+6+uLL5zpHwF28QDygONQ
 3eqmvhzGyjYWGnWROl9txC+h8lB2e03oyGLqH8cc+xJTUEvzwWmxPFJPRk5fbnBHJs
 6IlBtGfro8W6erLooEnIMglEqRg/d39BLeHLCoxqRQoiOje7jJbTMFmyownoDx4HOu
 AYnQ21HoUjKcYEYyyOdSBsNd3tw5xxYCRXPlJGOtOAoktPi5Mn4xBUmjChMl3NTHqo
 9FXZrFpItAdhw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id E6027118008D;
 Tue, 17 Feb 2026 08:10:43 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v10 2/8] net/nfb: create one ethdev per ethernet port
Date: Tue, 17 Feb 2026 08:10:34 +0100
Message-ID: <20260217071040.2855133-3-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217071040.2855133-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260217071040.2855133-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb.h        |  25 ++++
 drivers/net/nfb/nfb_ethdev.c | 232 ++++++++++++++++++++++++++++-------
 2 files changed, 216 insertions(+), 41 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index fa51afc7de..a854d16426 100644
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
+	TAILQ_ENTRY(pmd_internals) eth_dev_list;  /**< Item in list of all devices */
+	struct rte_eth_dev *eth_dev;  /**< Handle for matching the device being removed */
 };
 
 /*
@@ -68,4 +72,25 @@ struct pmd_priv {
 	bool ready;     /**< This structure is initialized for usage in secondary process */
 };
 
+/* Data for common device probing */
+struct nfb_probe_params {
+	/** Generic device information */
+	struct rte_device *device;
+	/** Port bus specific initialisation callback function */
+	ethdev_bus_specific_init specific_init;
+	/** Port bus specific initialisation parameters */
+	void *specific_device;
+
+	const char *path;       /**< libnfb device string */
+	const char *args;	/**< Device arguments */
+	int nfb_id;             /**< ID of NFB device in system */
+	int ep_index;           /**< (PCIe) endpoint index for matching assigned interfaces */
+
+	char name[RTE_DEV_NAME_MAX_LEN];  /**< Probed name (e.g. PCI device name) */
+};
+
+
+int nfb_eth_common_probe(struct nfb_probe_params *params);
+int nfb_eth_common_remove(struct rte_device *dev);
+
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index c0a2905249..233eb91e18 100644
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
@@ -18,6 +22,21 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+struct nfb_ifc_create_params {
+	struct nfb_probe_params *probe_params;
+	struct nc_ifc_map_info map_info;
+	struct nc_ifc_info *ifc_info;
+
+	int basename_len;       /* Cached real length of original probe_params->name */
+};
+
+/* The TAILQ entries are used for cleanup of allocated resources
+ * in situations, where dev_close is not called.
+ */
+TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);
+static struct nfb_pmd_internals_head nfb_eth_dev_list =
+	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
+
 static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
 
 /**
@@ -507,23 +526,20 @@ static const struct eth_dev_ops ops = {
  *   0 on success, a negative errno value otherwise.
  */
 static int
-nfb_eth_dev_init(struct rte_eth_dev *dev)
+nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 {
 	int i;
+	int cnt;
 	int ret;
 	uint32_t mac_count;
 	struct rte_eth_dev_data *data = dev->data;
 	struct pmd_internals *internals;
+	struct nfb_ifc_create_params *params = init_data;
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
@@ -535,27 +551,17 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 
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
+	internals->nfb = nfb_open(params->probe_params->path);
 	if (internals->nfb == NULL) {
-		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
+		NFB_LOG(ERR, "nfb_open(): failed to open %s", params->probe_params->path);
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
@@ -586,11 +592,30 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
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
+			if (mi->rxq[i].ifc == ifc->id) {
+				if (cnt >= max_rx_queues) {
+					NFB_LOG(ERR, "RX queue mapping inconsistent");
+					ret = -EINVAL;
+					goto err_queue_map;
+				}
+				priv->queue_map_rx[cnt++] = mi->rxq[i].id;
+			}
+		}
+
+		cnt = 0;
+		for (i = 0; i < mi->txq_cnt; i++) {
+			if (mi->txq[i].ifc == ifc->id) {
+				if (cnt >= max_tx_queues) {
+					NFB_LOG(ERR, "TX queue mapping inconsistent");
+					ret = -EINVAL;
+					goto err_queue_map;
+				}
+				priv->queue_map_tx[cnt++] = mi->txq[i].id;
+			}
+		}
 
 		/* Allocate space for MAC addresses */
 		mac_count = nfb_eth_get_max_mac_address_count(dev);
@@ -622,13 +647,10 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		}
 	}
 
-	NFB_LOG(INFO, "NFB device (" PCI_PRI_FMT ") successfully initialized",
-		pci_addr->domain, pci_addr->bus, pci_addr->devid,
-		pci_addr->function);
-
 	return 0;
 
 err_malloc_mac_addrs:
+err_queue_map:
 	rte_free(priv->queue_map_rx);
 err_alloc_queue_map:
 err_secondary_not_ready:
@@ -654,25 +676,111 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
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
+static int
+nfb_eth_dev_create_for_ifc(struct nfb_ifc_create_params *cp)
+{
+	int ret;
+	struct nc_ifc_info *ifc;
+	struct nfb_probe_params *pp;
+	struct rte_eth_dev *eth_dev;
+	struct pmd_internals *p;
+
+	ifc = cp->ifc_info;
+	pp = cp->probe_params;
+
+	/* Skip interfaces which doesn't belong to the probed PCI device */
+	if ((pp->ep_index != -1 && ifc->ep != pp->ep_index) ||
+			(ifc->flags & NC_IFC_INFO_FLAG_ACTIVE) == 0)
+		return 0;
+
+	ret = snprintf(pp->name + cp->basename_len, sizeof(pp->name) - cp->basename_len,
+			"_eth%d", ifc->id);
+	if (ret < 0 || ret >= (signed int)sizeof(pp->name) - cp->basename_len)
+		return -EINVAL;
+
+	ret = rte_eth_dev_create(pp->device, pp->name,
+			sizeof(struct pmd_priv),
+			pp->specific_init, pp->specific_device,
+			nfb_eth_dev_init, cp);
+	if (ret)
+		goto out;
+
+	eth_dev = rte_eth_dev_get_by_name(pp->name);
+	if (eth_dev == NULL) {
+		NFB_LOG(ERR, "Failed to get created device %s", pp->name);
+		ret = -ENODEV;
+		goto out;
+	}
+	p = eth_dev->process_private;
+	p->eth_dev = eth_dev;
+	TAILQ_INSERT_TAIL(&nfb_eth_dev_list, p, eth_dev_list);
+
+out:
+	/* return to original name (just for clarity) */
+	pp->name[cp->basename_len] = '\0';
+	return ret;
+}
+
+int
+nfb_eth_common_probe(struct nfb_probe_params *params)
+{
+	int i;
+	int ret;
+
+	struct nfb_device *nfb_dev;
+	struct nfb_ifc_create_params ifc_params;
+
+	/* Open the device handle just for parsing ifc_params.
+	 * A separate handle is used later for each netdev.
+	 */
+	nfb_dev = nfb_open(params->path);
+	if (nfb_dev == NULL) {
+		NFB_LOG(ERR, "nfb_open(): failed to open %s", params->path);
+		return -EINVAL;
+	}
+
+	ret = nc_ifc_map_info_create_ordinary(nfb_dev, &ifc_params.map_info);
+	if (ret)
+		goto err_map_info_create;
+
+	ifc_params.probe_params = params;
+	ifc_params.basename_len = strlen(params->name);
+
+	for (i = 0; i < ifc_params.map_info.ifc_cnt; i++) {
+		ifc_params.ifc_info = &ifc_params.map_info.ifc[i];
+		ret = nfb_eth_dev_create_for_ifc(&ifc_params);
+		if (ret)
+			goto err_dev_create;
+	}
+
+	nc_map_info_destroy(&ifc_params.map_info);
+	nfb_close(nfb_dev);
 
 	return 0;
+
+err_dev_create:
+	nfb_eth_common_remove(params->device);
+	nc_map_info_destroy(&ifc_params.map_info);
+err_map_info_create:
+	nfb_close(nfb_dev);
+	return ret;
 }
 
 static const struct rte_pci_id nfb_pci_id_table[] = {
@@ -701,8 +809,50 @@ static int
 nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_probe(pci_dev,
-		sizeof(struct pmd_priv), nfb_eth_dev_init);
+	int ret;
+	char path[PATH_MAX];
+
+	struct nc_composed_device_info comp_dev_info;
+	struct nfb_probe_params params = {0};
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
+	params.ep_index = comp_dev_info.ep_index;
+
+	params.device = &pci_dev->device;
+	params.specific_init = eth_dev_pci_specific_init;
+	params.specific_device = pci_dev;
+
+	return nfb_eth_common_probe(&params);
+}
+
+int
+nfb_eth_common_remove(struct rte_device *dev)
+{
+	struct pmd_internals *entry, *temp;
+
+	RTE_TAILQ_FOREACH_SAFE(entry, &nfb_eth_dev_list, eth_dev_list, temp) {
+		if (dev == entry->eth_dev->device)
+			rte_eth_dev_destroy(entry->eth_dev, nfb_eth_dev_uninit);
+	}
+	return 0;
 }
 
 /**
@@ -719,7 +869,7 @@ nfb_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 static int
 nfb_eth_pci_remove(struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_remove(pci_dev, nfb_eth_dev_uninit);
+	return nfb_eth_common_remove(&pci_dev->device);
 }
 
 static struct rte_pci_driver nfb_eth_driver = {
-- 
2.53.0

