Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922DC83F34
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 18:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D66A340E22;
	Fri, 18 Jul 2025 20:28:12 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id 56D8240B8F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 20:28:11 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-748fd21468cso2307623b3a.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752863290; x=1753468090; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FYdBXXl1KZbBiQL/IDgq+Ntbd11p5uq+47X8jjsHF7g=;
 b=4iNft6nzR5UpkfZj9SfGaVmOWoFQKQ+5lW2zBvMhfHO3355SaA651hPlNezrdpwGzi
 GwuaNehApEZisi1IhYUWuXjvshCV71JPcHMCUe8cONjTce74CNoq8pdCUJsbNV3ntq/q
 PdHdiO/TW3T7iEPSM5MKEXRj3zjFM6Mx3oUDDRM15smdePvlHBzN7SH12ivTPBPdhn1z
 w12Iwd5d5HZ6/p6ylGyMWeLoMy6571t7L/HGweox32h3ThYTAp72ulkQ3N3MGvfVINeo
 89tOJVYsX3C8+nQhX+4eL3rs/f7n2Hd6hOruqZpsz4CS1MSNNiMEZhOQQw9YbVP62ylj
 dz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752863290; x=1753468090;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FYdBXXl1KZbBiQL/IDgq+Ntbd11p5uq+47X8jjsHF7g=;
 b=Nidv2ukyZbdkFCvmW4ndJUU9yuCHoyF+E7WadLTM5t/hk1fDk1LAx9GLQm1f+Jwvr8
 IFm1v+ne05jH7Yq8WqGz37cg0qvIsaCU86m3lzy0UG7VbLnrbpqW0Gdy08072hvOjilr
 zdSZlJn5nk32tjAn6IH8zEOn617PUSD7QXEBHDdtmvk7t0xAPdadKOI6sjez9R+h310+
 KPX/BM1E7fGDyR1PJc5k1M0UHYVQckiMMyzzRf/guVCWhcUmzCdWjDifFjBuWyTHGXdS
 7C79hmE0886w/yK+YA57EmxVwK06sf5yiHcB6XnxktjqL4WEEkED80nfHDlt0wkU69oe
 5Wug==
X-Gm-Message-State: AOJu0YwINuQhVMxcBrxr4fBLaIo4Dd3mYdUqJDGMurBOlIrvFT2ZXkkF
 7wzT9/X96AgZoFXIcNSOgNivz8P6vc9woPm0QkZYnDmThPF0SC3X4azCJXDPRkFM8AhS1QaerJW
 Luk02zlDloa6xmpJIk/83F/yDMw==
X-Google-Smtp-Source: AGHT+IH/RhujPEGnE5T5qgz8Wq5KDI8aBKH+FJUbbGidggY3xig/Zw+PchnWjz7XQ1CPM4TfJAEXqiItTepoffJWBg==
X-Received: from pfblg20.prod.google.com
 ([2002:a05:6a00:7094:b0:746:1a2e:b29b])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da8:b0:239:c7c:8de8 with SMTP id
 adf61e73a8af0-2390c7cf703mr12415382637.12.1752863290323; 
 Fri, 18 Jul 2025 11:28:10 -0700 (PDT)
Date: Fri, 18 Jul 2025 18:27:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718182725.467544-1-jtranoleary@google.com>
Subject: [PATCH] net/gve: free device resources in gve_dev_close
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: joshwash@google.com
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>,
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Previously, upon a device close, the driver would only stop its queues,
whereas a device remove would cause the driver to free its resources.
However, expected behavior in DPDK is to have a device close free all of
its resources because ports are not reused.

This patch adds all device teardown functionality within the device
close function. It also flattens and refactors steps related to freeing
device resources such that gve_dev_close reads more linearly.

Fixes: 457967cd2b2d ("net/gve: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_adminq.c |   2 -
 drivers/net/gve/gve_ethdev.c      | 139 +++++++++++++++++++++--------------------
 2 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 4b250a9..15a05da 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -276,8 +276,6 @@ void gve_adminq_release(struct gve_priv *priv)
 			msleep(GVE_ADMINQ_SLEEP_LEN);
 		}
 	}
-	gve_clear_device_rings_ok(priv);
-	gve_clear_device_resources_ok(priv);
 	gve_clear_admin_queue_ok(priv);
 }

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index ef1c543..56e1a47 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -383,6 +383,8 @@ gve_start_queues(struct rte_eth_dev *dev)
 		}
 	}

+	gve_set_device_rings_ok(priv);
+
 	return 0;

 err_rx:
@@ -395,6 +397,8 @@ err_tx:
 		gve_stop_tx_queues(dev);
 	else
 		gve_stop_tx_queues_dqo(dev);
+
+	gve_clear_device_rings_ok(priv);
 	return ret;
 }

@@ -440,8 +444,11 @@ static int
 gve_dev_stop(struct rte_eth_dev *dev)
 {
 	struct gve_priv *priv = dev->data->dev_private;
+
+	dev->data->dev_started = 0;
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;

+	gve_clear_device_rings_ok(priv);
 	if (gve_is_gqi(priv)) {
 		gve_stop_tx_queues(dev);
 		gve_stop_rx_queues(dev);
@@ -450,27 +457,18 @@ gve_dev_stop(struct rte_eth_dev *dev)
 		gve_stop_rx_queues_dqo(dev);
 	}

-	dev->data->dev_started = 0;
-
 	if (gve_is_gqi(dev->data->dev_private))
 		gve_free_stats_report(dev);

 	return 0;
 }

-static int
-gve_dev_close(struct rte_eth_dev *dev)
+static void
+gve_free_queues(struct rte_eth_dev *dev)
 {
 	struct gve_priv *priv = dev->data->dev_private;
-	int err = 0;
 	uint16_t i;

-	if (dev->data->dev_started) {
-		err = gve_dev_stop(dev);
-		if (err != 0)
-			PMD_DRV_LOG(ERR, "Failed to stop dev.");
-	}
-
 	if (gve_is_gqi(priv)) {
 		for (i = 0; i < dev->data->nb_tx_queues; i++)
 			gve_tx_queue_release(dev, i);
@@ -484,8 +482,67 @@ gve_dev_close(struct rte_eth_dev *dev)
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
 			gve_rx_queue_release_dqo(dev, i);
 	}
+}
+
+static void
+gve_free_counter_array(struct gve_priv *priv)
+{
+	rte_memzone_free(priv->cnt_array_mz);
+	priv->cnt_array = NULL;
+}
+
+static void
+gve_free_irq_db(struct gve_priv *priv)
+{
+	rte_memzone_free(priv->irq_dbs_mz);
+	priv->irq_dbs = NULL;
+}
+
+static void
+gve_free_ptype_lut_dqo(struct gve_priv *priv)
+{
+	if (!gve_is_gqi(priv)) {
+		rte_free(priv->ptype_lut_dqo);
+		priv->ptype_lut_dqo = NULL;
+	}
+}

-	rte_free(priv->adminq);
+static void
+gve_teardown_device_resources(struct gve_priv *priv)
+{
+	int err;
+
+	/* Tell device its resources are being freed */
+	if (gve_get_device_resources_ok(priv)) {
+		err = gve_adminq_deconfigure_device_resources(priv);
+		if (err)
+			PMD_DRV_LOG(ERR, "Could not deconfigure device resources: err=%d", err);
+	}
+
+	gve_free_ptype_lut_dqo(priv);
+	gve_free_counter_array(priv);
+	gve_free_irq_db(priv);
+	gve_clear_device_resources_ok(priv);
+}
+
+static int
+gve_dev_close(struct rte_eth_dev *dev)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	int err = 0;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	if (dev->data->dev_started) {
+		err = gve_dev_stop(dev);
+		if (err != 0)
+			PMD_DRV_LOG(ERR, "Failed to stop dev.");
+	}
+
+	gve_free_queues(dev);
+	gve_teardown_device_resources(priv);
+	gve_adminq_free(priv);

 	dev->data->mac_addrs = NULL;

@@ -1056,41 +1113,6 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
 	.reta_query           = gve_rss_reta_query,
 };

-static void
-gve_free_counter_array(struct gve_priv *priv)
-{
-	rte_memzone_free(priv->cnt_array_mz);
-	priv->cnt_array = NULL;
-}
-
-static void
-gve_free_irq_db(struct gve_priv *priv)
-{
-	rte_memzone_free(priv->irq_dbs_mz);
-	priv->irq_dbs = NULL;
-}
-
-static void
-gve_teardown_device_resources(struct gve_priv *priv)
-{
-	int err;
-
-	/* Tell device its resources are being freed */
-	if (gve_get_device_resources_ok(priv)) {
-		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err)
-			PMD_DRV_LOG(ERR, "Could not deconfigure device resources: err=%d", err);
-	}
-
-	if (!gve_is_gqi(priv)) {
-		rte_free(priv->ptype_lut_dqo);
-		priv->ptype_lut_dqo = NULL;
-	}
-	gve_free_counter_array(priv);
-	gve_free_irq_db(priv);
-	gve_clear_device_resources_ok(priv);
-}
-
 static int
 pci_dev_msix_vec_count(struct rte_pci_device *pdev)
 {
@@ -1160,6 +1182,8 @@ gve_setup_device_resources(struct gve_priv *priv)
 		}
 	}

+	gve_set_device_resources_ok(priv);
+
 	return 0;
 free_ptype_lut:
 	rte_free(priv->ptype_lut_dqo);
@@ -1252,13 +1276,6 @@ free_adminq:
 	return err;
 }

-static void
-gve_teardown_priv_resources(struct gve_priv *priv)
-{
-	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
-}
-
 static int
 gve_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -1328,18 +1345,6 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 }

-static int
-gve_dev_uninit(struct rte_eth_dev *eth_dev)
-{
-	struct gve_priv *priv = eth_dev->data->dev_private;
-
-	gve_teardown_priv_resources(priv);
-
-	eth_dev->data->mac_addrs = NULL;
-
-	return 0;
-}
-
 static int
 gve_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,
 	      struct rte_pci_device *pci_dev)
@@ -1350,7 +1355,7 @@ gve_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,
 static int
 gve_pci_remove(struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_remove(pci_dev, gve_dev_uninit);
+	return rte_eth_dev_pci_generic_remove(pci_dev, gve_dev_close);
 }

 static const struct rte_pci_id pci_id_gve_map[] = {
--
2.50.0.727.gbf7dc18ff4-goog

