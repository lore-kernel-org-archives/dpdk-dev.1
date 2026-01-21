Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27E0C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE57A42DF1;
	Wed, 21 Jan 2026 18:02:04 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 93E8A42D96;
 Wed, 21 Jan 2026 18:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769014918;
 bh=elit+O+EVgZVbeCfQC3UHY4Jj3MNhnfxUkBm7oTCvXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TOTHat/EEf3peI/xkI1XgW9W4uO6qyzvVzVQEyGqR5nA5WIym/KQEQHt4sJR0rhYg
 7h/hD4f++m80IdggX/VY7gr2s/wsNrMw++x5Ln4yqorWgDgW8tzMomRSLhJOqggad+
 LB7totL3fVcV4ePdtvYkc31BdNG0yZ+/LBS/7c4bULRICgiqOCGauPlGriXvvwAkHp
 STnKaJ/k3kqPAiKPZkXYkCKi2B7RGUGagZfaLWnV3uSjK4wAsvHmaN30Odz0qBH/zb
 WzyIhGDlIfaC578Pz/Hv993a1n5+nBHDUxXKfPGIk5w+j7XrGE82SmGRSX4qYk2mVM
 dgfSvPKJGOkqw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 660001180072;
 Wed, 21 Jan 2026 18:01:58 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>,
	stable@dpdk.org
Subject: [PATCH v4 5/6] net/nfb: release allocated resources correctly
Date: Wed, 21 Jan 2026 18:01:19 +0100
Message-ID: <20260121170120.268553-6-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121170120.268553-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
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

Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 74 ++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 7dbdde2715..abc5c12b1e 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -18,6 +18,8 @@
 #include "nfb_rxmode.h"
 #include "nfb.h"
 
+static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
+
 /**
  * Default MAC addr
  */
@@ -160,8 +162,6 @@ nfb_eth_dev_stop(struct rte_eth_dev *dev)
 	uint16_t nb_rx = dev->data->nb_rx_queues;
 	uint16_t nb_tx = dev->data->nb_tx_queues;
 
-	dev->data->dev_started = 0;
-
 	for (i = 0; i < nb_tx; i++)
 		nfb_eth_tx_queue_stop(dev, i);
 
@@ -184,7 +184,6 @@ static int
 nfb_eth_dev_configure(struct rte_eth_dev *dev)
 {
 	int ret;
-	struct pmd_internals *internals = dev->process_private;
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
 	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
@@ -193,12 +192,16 @@ nfb_eth_dev_configure(struct rte_eth_dev *dev)
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
@@ -262,32 +265,28 @@ nfb_eth_dev_info(struct rte_eth_dev *dev,
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
@@ -529,7 +528,7 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 			dev->device->numa_node);
 	if (internals == NULL) {
 		ret = -ENOMEM;
-		return ret;
+		goto err_alloc_internals;
 	}
 
 	dev->process_private = internals;
@@ -547,8 +546,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 	internals->nfb = nfb_open(nfb_dev);
 	if (internals->nfb == NULL) {
 		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
-		rte_free(internals);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_nfb_open;
 	}
 	max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
 	max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
@@ -583,9 +582,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
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
@@ -607,6 +605,16 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
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
@@ -625,7 +633,9 @@ nfb_eth_dev_uninit(struct rte_eth_dev *dev)
 	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	struct pmd_internals *internals = dev->process_private;
 
-	nfb_eth_dev_close(dev);
+	nfb_nc_rxmac_deinit(internals->rxmac, internals->max_rxmac);
+	nfb_nc_txmac_deinit(internals->txmac, internals->max_txmac);
+	nfb_close(internals->nfb);
 
 	rte_free(internals);
 
-- 
2.52.0

