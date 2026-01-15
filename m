Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D2CD44C4F
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD26E427C0;
	Thu, 15 Jan 2026 15:02:02 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 9D0D140E45
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768485717;
 bh=ZyGajKqzpi/eb/yNSfBsVHTHE644zYuSGu+vklOXsuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Df+tII+4tZfVdljs71PfwingbJHZqw75NVx4WMEj4/w2m6NvNKUX8f5qvq5eIDON1
 pm/6TsExSHE8REMkWSUPy2Z1zwfwD43eMpe+zdGKlPfS/uM5G6YmIPysptFV7cMLYk
 vkGZNwtdRTpufQDkED6oeAU4ObKeL6mjNbHsYwiKQ+lhYLn2YN0d8tyRq3Mn2pqibS
 Q+ylDvPbaopLUjZBafSFoKRjNo9agpck3elQUzPJj7QFudcCmXuJMLnthaecUM7mC9
 SEv8A6ddA2MHQb02310mMiM1xaM9PbKa6HkkowD2rvv72b7FzlAFA+exN+3U5VnCTO
 2mAdvyN7+Ft8Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 7C9B6118007E;
 Thu, 15 Jan 2026 15:01:57 +0100 (CET)
From: spinler@cesnet.cz
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: [PATCH 5/6] net/nfb: release allocated resources correctly
Date: Thu, 15 Jan 2026 15:01:33 +0100
Message-ID: <20260115140134.235877-6-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115140134.235877-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
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

Internal handles are initialized in eth_dev_init, so the cleanup
should be done in eth_dev_uninit.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 79 +++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index d73a5330ce..3bd9cab5fa 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -18,6 +18,9 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+
+static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
+
 /**
  * Default MAC addr
  */
@@ -160,8 +163,6 @@ nfb_eth_dev_stop(struct rte_eth_dev *dev)
 	uint16_t nb_rx = dev->data->nb_rx_queues;
 	uint16_t nb_tx = dev->data->nb_tx_queues;
 
-	dev->data->dev_started = 0;
-
 	for (i = 0; i < nb_tx; i++)
 		nfb_eth_tx_queue_stop(dev, i);
 
@@ -181,10 +182,9 @@ nfb_eth_dev_stop(struct rte_eth_dev *dev)
  *   0 on success, a negative errno value otherwise.
  */
 static int
-nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+nfb_eth_dev_configure(struct rte_eth_dev *dev)
 {
 	int ret;
-	struct pmd_internals *internals = dev->process_private;
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
 	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
@@ -193,12 +193,16 @@ nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 				&nfb_timestamp_rx_dynflag);
 		if (ret != 0) {
 			NFB_LOG(ERR, "Cannot register Rx timestamp field/flag %d", ret);
-			nfb_close(internals->nfb);
-			return -rte_errno;
+			ret = -ENOMEM;
+			goto err_ts_register;
 		}
 	}
 
 	return 0;
+
+err_ts_register:
+	nfb_eth_dev_uninit(dev);
+	return ret;
 }
 
 static uint32_t
@@ -262,32 +266,28 @@ nfb_eth_dev_info(struct rte_eth_dev *dev,
 static int
 nfb_eth_dev_close(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *internals = dev->process_private;
 	uint16_t i;
 	uint16_t nb_rx = dev->data->nb_rx_queues;
 	uint16_t nb_tx = dev->data->nb_tx_queues;
-	int ret;
 
-	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
-	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
-
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
-		return 0;
-
-	ret = nfb_eth_dev_stop(dev);
-
-	for (i = 0; i < nb_rx; i++) {
-		nfb_eth_rx_queue_release(dev, i);
-		dev->data->rx_queues[i] = NULL;
-	}
-	dev->data->nb_rx_queues = 0;
-	for (i = 0; i < nb_tx; i++) {
-		nfb_eth_tx_queue_release(dev, i);
-		dev->data->tx_queues[i] = NULL;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		for (i = 0; i < nb_rx; i++) {
+			if (dev->data->rx_queues[i]) {
+				nfb_eth_rx_queue_release(dev, i);
+				dev->data->rx_queues[i] = NULL;
+			}
+		}
+		for (i = 0; i < nb_tx; i++) {
+			if (dev->data->tx_queues[i]) {
+				nfb_eth_tx_queue_release(dev, i);
+				dev->data->tx_queues[i] = NULL;
+			}
+		}
 	}
-	dev->data->nb_tx_queues = 0;
 
-	return ret;
+	nfb_eth_dev_uninit(dev);
+
+	return 0;
 }
 
 /**
@@ -509,6 +509,7 @@ static const struct eth_dev_ops ops = {
 static int
 nfb_eth_dev_init(struct rte_eth_dev *dev)
 {
+	int ret;
 	uint32_t mac_count;
 	struct rte_eth_dev_data *data = dev->data;
 	struct pmd_internals *internals;
@@ -526,7 +527,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 			sizeof(struct pmd_internals), RTE_CACHE_LINE_SIZE,
 			dev->device->numa_node);
 	if (internals == NULL) {
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_alloc_internals;
 	}
 
 	dev->process_private = internals;
@@ -544,8 +546,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	internals->nfb = nfb_open(nfb_dev);
 	if (internals->nfb == NULL) {
 		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
-		rte_free(internals);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_nfb_open;
 	}
 	priv->max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
 	priv->max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
@@ -577,9 +579,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 			sizeof(struct rte_ether_addr) * mac_count, RTE_CACHE_LINE_SIZE);
 		if (data->mac_addrs == NULL) {
 			NFB_LOG(ERR, "Could not alloc space for MAC address");
-			nfb_close(internals->nfb);
-			rte_free(internals);
-			return -EINVAL;
+			ret = -ENOMEM;
+			goto err_malloc_mac_addrs;
 		}
 
 		rte_eth_random_addr(eth_addr_init.addr_bytes);
@@ -601,6 +602,16 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		pci_addr->function);
 
 	return 0;
+
+err_malloc_mac_addrs:
+	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
+	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_close(internals->nfb);
+
+err_nfb_open:
+	rte_free(internals);
+err_alloc_internals:
+	return ret;
 }
 
 /**
@@ -619,7 +630,9 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct pmd_internals *internals = dev->process_private;
 
-	nfb_eth_dev_close(dev);
+	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
+	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_close(internals->nfb);
 
 	rte_free(internals);
 
-- 
2.52.0

