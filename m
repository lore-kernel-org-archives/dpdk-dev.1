Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725FCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC16440647;
	Fri, 26 Sep 2025 18:35:27 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 9E6D940262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:35:26 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso24873766d6.2
 for <dev@dpdk.org>; Fri, 26 Sep 2025 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758904526;
 x=1759509326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=17Yw5CQV4qoEuhuBZH/oIPORdugBEDTW1nIxdCyVn6g=;
 b=BWuwYCxeHDiP2dIeOpVTARWumicrmK0N+llbEvzTNFIfjhxN7N0nT2IWuQAe+xA3B5
 suRK3d0Hq6UoayIkeWVvUl83P0qscvT0ssUbB8zODbcUVWSk5wOa3Qbk/W0TjsBQ58dx
 RZ9kjONNCbx+p1FfzSqoOsziYeXrvKgUVUWjQdGUagC/2Yaz3veVegp6C4p2LrZC3UXw
 5FPmRVi+ZSzvpyzOvPgn/IWhJf2EoGg8LahEHU+a2nONB+BqGI7Qe9gdZGnJ0J7yKK1i
 Ejl/zqMOrf8x2R4rTK4AQGooPix9oWbqNlSgDYr5JmSMTZyED5ylkywCHLNMLCrrsHh+
 aX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758904526; x=1759509326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17Yw5CQV4qoEuhuBZH/oIPORdugBEDTW1nIxdCyVn6g=;
 b=SLaIwE9vVBM6SFbkcbhROCJ+R6CCC1YFD7osekIpE71lNuiO9jf4OLOG+nhXehH5Uc
 FH4vdR9gdAG6a9EEWr9YrJN9yNC1LaRNdpwXALaVQkkH8egcIBBUXpbI55r5CgbITHF/
 XpIzL7sJbX4crpIP3jJ+SlpZv4RALngY0jmDJve2/aBzd9QEDBMm9wj09IVT8AcMLbBJ
 FSx4X4eFiYX9aSRmN36alirBpYHlHXKIg0ctOnDI+/pwKFo+t29CbAH30GyH7ZutyZes
 BlP+V+I2dx3nSAaxEtIw5d4T8S62rYZtf0pvX4TeNImasBLrCxEOQK14dIgkkgRBUw1m
 C/xw==
X-Gm-Message-State: AOJu0YyVRjcbKJep6ITqfUZE4Ww1l7Sidta59wArrKDsksN5EQGcn+WG
 s//e+Dw5uLQCoyEf0YzpJM9VkcyRORFvvzaAiSwif+qdBXEMksTvJtBY/2Vm48V562PPgfTgUOG
 Iefv2UMw=
X-Gm-Gg: ASbGnctgVd9op7iIGljvtVXUv211eoD8rDOfSd8Td74kTDiptw1uO6vXwIf5Z/LzjWx
 EPiwnhztXSLC5y9QQhvFRfBat+TZpaOQL4b/UBaX4oe+LBMJbmM7F6O3T8JZ/k1o9fw2tKtXYH9
 /q4q0/1k7PE7ZfC5hjhLkL5VVBr4M3uDFnR3iRIsgWcXAinwJynVl6wFmTLdixtAwIxkaJiyFnA
 cVbVOy3kY8pgx3McRvUKVbdy3t6LJ6I2+OjwHJag0qTaDViJQywMzdYFNT2tuPREEKxoQR84vx5
 z80Qt9qhpG1CzlyC8KcGpjtCTtnTRcusCexWEoc4ElpWP+/XWYBUmThnPWd6Z9zByvrR1qSgdxz
 Qc3xO7gsARJiwDpeTaYIOGoFl9WSj5UVsAY5yWGyRMLTkVxy+/EBjE0XvOM60eE8IUtbq/Geg
X-Google-Smtp-Source: AGHT+IEqcXoH02+6XnfcC+K2jve3zPtu2PoWZa2QxgK44x1Lg84vfbNx0ICFfpaxxHn7SWDfykw/yQ==
X-Received: by 2002:a05:6214:2aa2:b0:796:db6:98e1 with SMTP id
 6a1803df08f44-7fc48d5bbebmr108754676d6.67.1758904525482; 
 Fri, 26 Sep 2025 09:35:25 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80143051a1bsm28659516d6.31.2025.09.26.09.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:35:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [RFC] net/ark: use ark_ prefix on on global variables
Date: Fri, 26 Sep 2025 09:35:19 -0700
Message-ID: <20250926163519.430680-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

Rather than eth_ark_XXX use ark_XXX as prefix on all visible
global variables. This makes device consistent with other PMD's.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ark/ark_ethdev.c    | 154 ++++++++++++++++----------------
 drivers/net/ark/ark_ethdev_rx.c |  50 +++++------
 drivers/net/ark/ark_ethdev_rx.h |  18 ++--
 drivers/net/ark/ark_ethdev_tx.c |  32 +++----
 drivers/net/ark/ark_ethdev_tx.h |  14 +--
 5 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8d3c0a1b02..04a15d006f 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -22,32 +22,32 @@
 #include "ark_pktchkr.h"
 
 /*  Internal prototypes */
-static int eth_ark_check_args(struct ark_adapter *ark, const char *params);
-static int eth_ark_dev_init(struct rte_eth_dev *dev);
+static int ark_check_args(struct ark_adapter *ark, const char *params);
+static int ark_dev_init(struct rte_eth_dev *dev);
 static int ark_config_device(struct rte_eth_dev *dev);
-static int eth_ark_dev_uninit(struct rte_eth_dev *eth_dev);
-static int eth_ark_dev_configure(struct rte_eth_dev *dev);
-static int eth_ark_dev_start(struct rte_eth_dev *dev);
-static int eth_ark_dev_stop(struct rte_eth_dev *dev);
-static int eth_ark_dev_close(struct rte_eth_dev *dev);
-static int eth_ark_dev_info_get(struct rte_eth_dev *dev,
+static int ark_dev_uninit(struct rte_eth_dev *eth_dev);
+static int ark_dev_configure(struct rte_eth_dev *dev);
+static int ark_dev_start(struct rte_eth_dev *dev);
+static int ark_dev_stop(struct rte_eth_dev *dev);
+static int ark_dev_close(struct rte_eth_dev *dev);
+static int ark_dev_info_get(struct rte_eth_dev *dev,
 				struct rte_eth_dev_info *dev_info);
-static int eth_ark_dev_link_update(struct rte_eth_dev *dev,
+static int ark_dev_link_update(struct rte_eth_dev *dev,
 				   int wait_to_complete);
-static int eth_ark_dev_set_link_up(struct rte_eth_dev *dev);
-static int eth_ark_dev_set_link_down(struct rte_eth_dev *dev);
-static int eth_ark_dev_stats_get(struct rte_eth_dev *dev,
+static int ark_dev_set_link_up(struct rte_eth_dev *dev);
+static int ark_dev_set_link_down(struct rte_eth_dev *dev);
+static int ark_dev_stats_get(struct rte_eth_dev *dev,
 				  struct rte_eth_stats *stats);
-static int eth_ark_dev_stats_reset(struct rte_eth_dev *dev);
-static int eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
+static int ark_dev_stats_reset(struct rte_eth_dev *dev);
+static int ark_set_default_mac_addr(struct rte_eth_dev *dev,
 					 struct rte_ether_addr *mac_addr);
-static int eth_ark_macaddr_add(struct rte_eth_dev *dev,
+static int ark_macaddr_add(struct rte_eth_dev *dev,
 			       struct rte_ether_addr *mac_addr,
 			       uint32_t index,
 			       uint32_t pool);
-static void eth_ark_macaddr_remove(struct rte_eth_dev *dev,
+static void ark_macaddr_remove(struct rte_eth_dev *dev,
 				   uint32_t index);
-static int  eth_ark_set_mtu(struct rte_eth_dev *dev, uint16_t size);
+static int  ark_set_mtu(struct rte_eth_dev *dev, uint16_t size);
 
 /*
  * The packet generator is a functional block used to generate packet
@@ -145,7 +145,7 @@ ark_device_caps[] = {
 };
 
 static int
-eth_ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		struct rte_pci_device *pci_dev)
 {
 	struct rte_eth_dev *eth_dev;
@@ -156,7 +156,7 @@ eth_ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	if (eth_dev == NULL)
 		return -ENOMEM;
 
-	ret = eth_ark_dev_init(eth_dev);
+	ret = ark_dev_init(eth_dev);
 	if (ret)
 		rte_eth_dev_release_port(eth_dev);
 
@@ -164,47 +164,47 @@ eth_ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 }
 
 static int
-eth_ark_pci_remove(struct rte_pci_device *pci_dev)
+ark_pci_remove(struct rte_pci_device *pci_dev)
 {
-	return rte_eth_dev_pci_generic_remove(pci_dev, eth_ark_dev_uninit);
+	return rte_eth_dev_pci_generic_remove(pci_dev, ark_dev_uninit);
 }
 
 static struct rte_pci_driver rte_ark_pmd = {
 	.id_table = pci_id_ark_map,
 	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
-	.probe = eth_ark_pci_probe,
-	.remove = eth_ark_pci_remove,
+	.probe = ark_pci_probe,
+	.remove = ark_pci_remove,
 };
 
 static const struct eth_dev_ops ark_eth_dev_ops = {
-	.dev_configure = eth_ark_dev_configure,
-	.dev_start = eth_ark_dev_start,
-	.dev_stop = eth_ark_dev_stop,
-	.dev_close = eth_ark_dev_close,
+	.dev_configure = ark_dev_configure,
+	.dev_start = ark_dev_start,
+	.dev_stop = ark_dev_stop,
+	.dev_close = ark_dev_close,
 
-	.dev_infos_get = eth_ark_dev_info_get,
+	.dev_infos_get = ark_dev_info_get,
 
-	.rx_queue_setup = eth_ark_dev_rx_queue_setup,
-	.tx_queue_setup = eth_ark_tx_queue_setup,
+	.rx_queue_setup = ark_dev_rx_queue_setup,
+	.tx_queue_setup = ark_tx_queue_setup,
 
-	.link_update = eth_ark_dev_link_update,
-	.dev_set_link_up = eth_ark_dev_set_link_up,
-	.dev_set_link_down = eth_ark_dev_set_link_down,
+	.link_update = ark_dev_link_update,
+	.dev_set_link_up = ark_dev_set_link_up,
+	.dev_set_link_down = ark_dev_set_link_down,
 
-	.rx_queue_start = eth_ark_rx_start_queue,
-	.rx_queue_stop = eth_ark_rx_stop_queue,
+	.rx_queue_start = ark_rx_start_queue,
+	.rx_queue_stop = ark_rx_stop_queue,
 
-	.tx_queue_start = eth_ark_tx_queue_start,
-	.tx_queue_stop = eth_ark_tx_queue_stop,
+	.tx_queue_start = ark_tx_queue_start,
+	.tx_queue_stop = ark_tx_queue_stop,
 
-	.stats_get = eth_ark_dev_stats_get,
-	.stats_reset = eth_ark_dev_stats_reset,
+	.stats_get = ark_dev_stats_get,
+	.stats_reset = ark_dev_stats_reset,
 
-	.mac_addr_add = eth_ark_macaddr_add,
-	.mac_addr_remove = eth_ark_macaddr_remove,
-	.mac_addr_set = eth_ark_set_default_mac_addr,
+	.mac_addr_add = ark_macaddr_add,
+	.mac_addr_remove = ark_macaddr_remove,
+	.mac_addr_set = ark_set_default_mac_addr,
 
-	.mtu_set = eth_ark_set_mtu,
+	.mtu_set = ark_set_mtu,
 };
 
 static int
@@ -297,7 +297,7 @@ check_for_ext(struct ark_adapter *ark)
 }
 
 static int
-eth_ark_dev_init(struct rte_eth_dev *dev)
+ark_dev_init(struct rte_eth_dev *dev)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 	struct rte_pci_device *pci_dev;
@@ -376,7 +376,7 @@ eth_ark_dev_init(struct rte_eth_dev *dev)
 		return -1;
 
 	dev->dev_ops = &ark_eth_dev_ops;
-	dev->rx_queue_count = eth_ark_dev_rx_queue_count;
+	dev->rx_queue_count = ark_dev_rx_queue_count;
 
 	dev->data->mac_addrs = rte_zmalloc("ark", RTE_ETHER_ADDR_LEN, 0);
 	if (!dev->data->mac_addrs) {
@@ -398,7 +398,7 @@ eth_ark_dev_init(struct rte_eth_dev *dev)
 	}
 
 	if (pci_dev->device.devargs)
-		ret = eth_ark_check_args(ark, pci_dev->device.devargs->args);
+		ret = ark_check_args(ark, pci_dev->device.devargs->args);
 	else
 		ARK_PMD_LOG(INFO, "No Device args found\n");
 
@@ -539,7 +539,7 @@ ark_config_device(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_uninit(struct rte_eth_dev *dev)
+ark_dev_uninit(struct rte_eth_dev *dev)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 
@@ -559,11 +559,11 @@ eth_ark_dev_uninit(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_configure(struct rte_eth_dev *dev)
+ark_dev_configure(struct rte_eth_dev *dev)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 
-	eth_ark_dev_set_link_up(dev);
+	ark_dev_set_link_up(dev);
 	if (ark->user_ext.dev_configure)
 		return ark->user_ext.dev_configure(dev,
 			   ark->user_data[dev->data->port_id]);
@@ -571,23 +571,23 @@ eth_ark_dev_configure(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_start(struct rte_eth_dev *dev)
+ark_dev_start(struct rte_eth_dev *dev)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 	int i;
 
 	/* RX Side */
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-		eth_ark_rx_start_queue(dev, i);
+		ark_rx_start_queue(dev, i);
 
 	/* TX Side */
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
-		eth_ark_tx_queue_start(dev, i);
+		ark_tx_queue_start(dev, i);
 
 	ark->started = 1;
 	/* set xmit and receive function */
-	dev->rx_pkt_burst = &eth_ark_recv_pkts;
-	dev->tx_pkt_burst = &eth_ark_xmit_pkts;
+	dev->rx_pkt_burst = &ark_recv_pkts;
+	dev->tx_pkt_burst = &ark_xmit_pkts;
 
 	if (!ark->isvf && ark->start_pg)
 		ark_pktchkr_run(ark->pc);
@@ -618,7 +618,7 @@ eth_ark_dev_start(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_stop(struct rte_eth_dev *dev)
+ark_dev_stop(struct rte_eth_dev *dev)
 {
 	uint16_t i;
 	int status;
@@ -645,11 +645,11 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)
 
 	/* Stop RX Side */
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-		eth_ark_rx_stop_queue(dev, i);
+		ark_rx_stop_queue(dev, i);
 
 	/* STOP TX Side */
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-		status = eth_ark_tx_queue_stop(dev, i);
+		status = ark_tx_queue_stop(dev, i);
 		if (status != 0) {
 			uint16_t port = dev->data->port_id;
 			ARK_PMD_LOG(ERR,
@@ -662,7 +662,7 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)
 	ark_udm_dump_stats(ark->udm.v, "Post stop");
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-		eth_ark_rx_dump_queue(dev, i, __func__);
+		ark_rx_dump_queue(dev, i, __func__);
 
 	/* Stop the packet checker if it is running */
 	if (!ark->isvf && ark->start_pg) {
@@ -674,7 +674,7 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_close(struct rte_eth_dev *dev)
+ark_dev_close(struct rte_eth_dev *dev)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 	uint16_t i;
@@ -686,7 +686,7 @@ eth_ark_dev_close(struct rte_eth_dev *dev)
 		ark->user_ext.dev_close(dev,
 		 ark->user_data[dev->data->port_id]);
 
-	eth_ark_dev_stop(dev);
+	ark_dev_stop(dev);
 
 	/*
 	 * This should only be called once for the device during shutdown
@@ -696,12 +696,12 @@ eth_ark_dev_close(struct rte_eth_dev *dev)
 		ark_pktdir_setup(ark->pd, ARK_PKT_DIR_INIT_VAL);
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-		eth_ark_tx_queue_release(dev->data->tx_queues[i]);
+		ark_tx_queue_release(dev->data->tx_queues[i]);
 		dev->data->tx_queues[i] = 0;
 	}
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		eth_ark_dev_rx_queue_release(dev->data->rx_queues[i]);
+		ark_dev_rx_queue_release(dev->data->rx_queues[i]);
 		dev->data->rx_queues[i] = 0;
 	}
 
@@ -709,7 +709,7 @@ eth_ark_dev_close(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_info_get(struct rte_eth_dev *dev,
+ark_dev_info_get(struct rte_eth_dev *dev,
 		     struct rte_eth_dev_info *dev_info)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
@@ -749,7 +749,7 @@ eth_ark_dev_info_get(struct rte_eth_dev *dev,
 }
 
 static int
-eth_ark_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
+ark_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
 	ARK_PMD_LOG(DEBUG, "link status = %d\n",
 			dev->data->dev_link.link_status);
@@ -764,7 +764,7 @@ eth_ark_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 }
 
 static int
-eth_ark_dev_set_link_up(struct rte_eth_dev *dev)
+ark_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	dev->data->dev_link.link_status = 1;
 	struct ark_adapter *ark = dev->data->dev_private;
@@ -776,7 +776,7 @@ eth_ark_dev_set_link_up(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_set_link_down(struct rte_eth_dev *dev)
+ark_dev_set_link_down(struct rte_eth_dev *dev)
 {
 	dev->data->dev_link.link_status = 0;
 	struct ark_adapter *ark = dev->data->dev_private;
@@ -788,7 +788,7 @@ eth_ark_dev_set_link_down(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 {
 	uint16_t i;
 	struct ark_adapter *ark = dev->data->dev_private;
@@ -801,9 +801,9 @@ eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	stats->oerrors = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
-		eth_tx_queue_stats_get(dev->data->tx_queues[i], stats);
+		ark_tx_queue_stats_get(dev->data->tx_queues[i], stats);
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-		eth_rx_queue_stats_get(dev->data->rx_queues[i], stats);
+		ark_rx_queue_stats_get(dev->data->rx_queues[i], stats);
 	if (ark->user_ext.stats_get)
 		return ark->user_ext.stats_get(dev, stats,
 			ark->user_data[dev->data->port_id]);
@@ -811,15 +811,15 @@ eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 }
 
 static int
-eth_ark_dev_stats_reset(struct rte_eth_dev *dev)
+ark_dev_stats_reset(struct rte_eth_dev *dev)
 {
 	uint16_t i;
 	struct ark_adapter *ark = dev->data->dev_private;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
-		eth_tx_queue_stats_reset(dev->data->tx_queues[i]);
+		ark_tx_queue_stats_reset(dev->data->tx_queues[i]);
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-		eth_rx_queue_stats_reset(dev->data->rx_queues[i]);
+		ark_rx_queue_stats_reset(dev->data->rx_queues[i]);
 	if (ark->user_ext.stats_reset)
 		ark->user_ext.stats_reset(dev,
 			  ark->user_data[dev->data->port_id]);
@@ -828,7 +828,7 @@ eth_ark_dev_stats_reset(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_macaddr_add(struct rte_eth_dev *dev,
+ark_macaddr_add(struct rte_eth_dev *dev,
 		    struct rte_ether_addr *mac_addr,
 		    uint32_t index,
 		    uint32_t pool)
@@ -847,7 +847,7 @@ eth_ark_macaddr_add(struct rte_eth_dev *dev,
 }
 
 static void
-eth_ark_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
+ark_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 
@@ -857,7 +857,7 @@ eth_ark_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 }
 
 static int
-eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
+ark_set_default_mac_addr(struct rte_eth_dev *dev,
 			     struct rte_ether_addr *mac_addr)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
@@ -871,7 +871,7 @@ eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
 }
 
 static int
-eth_ark_set_mtu(struct rte_eth_dev *dev, uint16_t  size)
+ark_set_mtu(struct rte_eth_dev *dev, uint16_t  size)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
 
@@ -936,7 +936,7 @@ process_file_args(const char *key, const char *value, void *extra_args)
 }
 
 static int
-eth_ark_check_args(struct ark_adapter *ark, const char *params)
+ark_check_args(struct ark_adapter *ark, const char *params)
 {
 	struct rte_kvargs *kvlist;
 	unsigned int k_idx;
diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 8b18d93eaa..f221137931 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -22,11 +22,11 @@ struct ark_rx_meta;
 
 static void dump_mbuf_data(struct rte_mbuf *mbuf, uint16_t lo, uint16_t hi);
 static void ark_ethdev_rx_dump(const char *name, struct ark_rx_queue *queue);
-static uint32_t eth_ark_rx_jumbo(struct ark_rx_queue *queue,
+static uint32_t ark_rx_jumbo(struct ark_rx_queue *queue,
 				 struct ark_rx_meta *meta,
 				 struct rte_mbuf *mbuf0,
 				 uint32_t cons_index);
-static inline int eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue);
+static inline int ark_rx_seed_mbufs(struct ark_rx_queue *queue);
 
 /* ************************************************************************* */
 struct __rte_cache_aligned ark_rx_queue {
@@ -67,7 +67,7 @@ struct __rte_cache_aligned ark_rx_queue {
 
 /* ************************************************************************* */
 static int
-eth_ark_rx_hw_setup(struct rte_eth_dev *dev,
+ark_rx_hw_setup(struct rte_eth_dev *dev,
 		    struct ark_rx_queue *queue,
 		    uint16_t rx_queue_idx)
 {
@@ -100,18 +100,18 @@ eth_ark_rx_hw_setup(struct rte_eth_dev *dev,
 }
 
 static inline void
-eth_ark_rx_update_cons_index(struct ark_rx_queue *queue, uint32_t cons_index)
+ark_rx_update_cons_index(struct ark_rx_queue *queue, uint32_t cons_index)
 {
 	queue->cons_index = cons_index;
 	if ((cons_index + queue->queue_size - queue->seed_index) >= ARK_RX_MPU_CHUNK) {
-		eth_ark_rx_seed_mbufs(queue);
+		ark_rx_seed_mbufs(queue);
 		ark_mpu_set_producer(queue->mpu, queue->seed_index);
 	}
 }
 
 /* ************************************************************************* */
 int
-eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
+ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
 			   unsigned int socket_id,
@@ -129,7 +129,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* We may already be setup, free memory prior to re-allocation */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
-		eth_ark_dev_rx_queue_release(dev->data->rx_queues[queue_idx]);
+		ark_dev_rx_queue_release(dev->data->rx_queues[queue_idx]);
 		dev->data->rx_queues[queue_idx] = NULL;
 	}
 
@@ -215,7 +215,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	ark_udm_queue_stats_reset(queue->udm);
 
 	/* populate mbuf reserve */
-	status = eth_ark_rx_seed_mbufs(queue);
+	status = ark_rx_seed_mbufs(queue);
 
 	if (queue->seed_index != nb_desc) {
 		ARK_PMD_LOG(ERR, "Failed to allocate %u mbufs for RX queue %d\n",
@@ -224,7 +224,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 	/* MPU Setup */
 	if (status == 0)
-		status = eth_ark_rx_hw_setup(dev, queue, queue_idx);
+		status = ark_rx_hw_setup(dev, queue, queue_idx);
 
 	if (unlikely(status != 0)) {
 		struct rte_mbuf **mbuf;
@@ -248,7 +248,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 /* ************************************************************************* */
 uint16_t
-eth_ark_recv_pkts(void *rx_queue,
+ark_recv_pkts(void *rx_queue,
 		  struct rte_mbuf **rx_pkts,
 		  uint16_t nb_pkts)
 {
@@ -267,7 +267,7 @@ eth_ark_recv_pkts(void *rx_queue,
 	if (unlikely(nb_pkts == 0))
 		return 0;
 	if (unlikely(queue->starvation))
-		eth_ark_rx_seed_mbufs(queue);
+		ark_rx_seed_mbufs(queue);
 
 	prod_index = queue->prod_index;
 	cons_index = queue->cons_index;
@@ -318,7 +318,7 @@ eth_ark_recv_pkts(void *rx_queue,
 		}
 
 		if (unlikely(meta->pkt_len > queue->dataroom)) {
-			uint32_t tcons = eth_ark_rx_jumbo(queue, meta, mbuf, cons_index + 1);
+			uint32_t tcons = ark_rx_jumbo(queue, meta, mbuf, cons_index + 1);
 			if ((int32_t)(prod_index - tcons) >= 0)
 				cons_index = tcons; /* nominal condition */
 			else
@@ -340,14 +340,14 @@ eth_ark_recv_pkts(void *rx_queue,
 		rx_user_meta_hook(mbuf, meta->user_meta, queue->ext_user_data);
 	}
 
-	eth_ark_rx_update_cons_index(queue, cons_index);
+	ark_rx_update_cons_index(queue, cons_index);
 
 	return nb;
 }
 
 /* ************************************************************************* */
 static uint32_t
-eth_ark_rx_jumbo(struct ark_rx_queue *queue,
+ark_rx_jumbo(struct ark_rx_queue *queue,
 		 struct ark_rx_meta *meta,
 		 struct rte_mbuf *mbuf0,
 		 uint32_t cons_index)
@@ -388,7 +388,7 @@ eth_ark_rx_jumbo(struct ark_rx_queue *queue,
 
 /* Drain the internal queue allowing hw to clear out. */
 static void
-eth_ark_rx_queue_drain(struct ark_rx_queue *queue)
+ark_rx_queue_drain(struct ark_rx_queue *queue)
 {
 	register uint32_t cons_index;
 	struct rte_mbuf *mbuf;
@@ -400,12 +400,12 @@ eth_ark_rx_queue_drain(struct ark_rx_queue *queue)
 		mbuf = queue->reserve_q[cons_index & queue->queue_mask];
 		rte_pktmbuf_free(mbuf);
 		cons_index++;
-		eth_ark_rx_update_cons_index(queue, cons_index);
+		ark_rx_update_cons_index(queue, cons_index);
 	}
 }
 
 int
-eth_ark_dev_rx_queue_count(void *rx_queue)
+ark_dev_rx_queue_count(void *rx_queue)
 {
 	struct ark_rx_queue *queue;
 
@@ -415,7 +415,7 @@ eth_ark_dev_rx_queue_count(void *rx_queue)
 
 /* ************************************************************************* */
 int
-eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id)
+ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct ark_rx_queue *queue;
 
@@ -438,7 +438,7 @@ eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 /* Queue can be restarted.   data remains
  */
 int
-eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
+ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct ark_rx_queue *queue;
 
@@ -455,7 +455,7 @@ eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 
 /* ************************************************************************* */
 static inline int
-eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
+ark_rx_seed_mbufs(struct ark_rx_queue *queue)
 {
 	uint32_t limit = RTE_ALIGN_FLOOR(queue->cons_index, ARK_RX_MPU_CHUNK) +
 		queue->queue_size;
@@ -539,7 +539,7 @@ eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
 }
 
 void
-eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
+ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
 		      const char *msg)
 {
 	struct ark_rx_queue *queue;
@@ -552,7 +552,7 @@ eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
 /* ************************************************************************* */
 /* Call on device closed no user API, queue is stopped */
 void
-eth_ark_dev_rx_queue_release(void *vqueue)
+ark_dev_rx_queue_release(void *vqueue)
 {
 	struct ark_rx_queue *queue;
 
@@ -565,7 +565,7 @@ eth_ark_dev_rx_queue_release(void *vqueue)
 	ark_mpu_stop(queue->mpu);
 
 	/* Need to clear out mbufs here, dropping packets along the way */
-	eth_ark_rx_queue_drain(queue);
+	ark_rx_queue_drain(queue);
 
 	rte_free(queue->reserve_q);
 	rte_free(queue->paddress_q);
@@ -573,7 +573,7 @@ eth_ark_dev_rx_queue_release(void *vqueue)
 }
 
 void
-eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
+ark_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
 {
 	struct ark_rx_queue *queue;
 	struct ark_udm_t *udm;
@@ -596,7 +596,7 @@ eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
 }
 
 void
-eth_rx_queue_stats_reset(void *vqueue)
+ark_rx_queue_stats_reset(void *vqueue)
 {
 	struct ark_rx_queue *queue;
 
diff --git a/drivers/net/ark/ark_ethdev_rx.h b/drivers/net/ark/ark_ethdev_rx.h
index 12d4f61637..7a5bab20a9 100644
--- a/drivers/net/ark/ark_ethdev_rx.h
+++ b/drivers/net/ark/ark_ethdev_rx.h
@@ -11,21 +11,21 @@
 #include <rte_mempool.h>
 #include <ethdev_driver.h>
 
-int eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
+int ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
 			       unsigned int socket_id,
 			       const struct rte_eth_rxconf *rx_conf,
 			       struct rte_mempool *mp);
-int eth_ark_dev_rx_queue_count(void *rx_queue);
-int eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id);
-int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);
-uint16_t eth_ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
+int ark_dev_rx_queue_count(void *rx_queue);
+int ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id);
+int ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);
+uint16_t ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts);
-void eth_ark_dev_rx_queue_release(void *rx_queue);
-void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
-void eth_rx_queue_stats_reset(void *vqueue);
-void eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
+void ark_dev_rx_queue_release(void *rx_queue);
+void ark_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
+void ark_rx_queue_stats_reset(void *vqueue);
+void ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
 			   const char *msg);
 
 #endif
diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev_tx.c
index ca6cd297a1..2c61cd5486 100644
--- a/drivers/net/ark/ark_ethdev_tx.c
+++ b/drivers/net/ark/ark_ethdev_tx.c
@@ -53,15 +53,15 @@ struct __rte_cache_aligned ark_tx_queue {
 };
 
 /* Forward declarations */
-static int eth_ark_tx_jumbo(struct ark_tx_queue *queue,
+static int ark_tx_jumbo(struct ark_tx_queue *queue,
 			    struct rte_mbuf *mbuf,
 			    uint32_t *user_meta, uint8_t meta_cnt);
-static int eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue);
+static int ark_tx_hw_queue_config(struct ark_tx_queue *queue);
 static void free_completed_tx(struct ark_tx_queue *queue);
 
 /* ************************************************************************* */
 static inline void
-eth_ark_tx_desc_fill(struct ark_tx_queue *queue,
+ark_tx_desc_fill(struct ark_tx_queue *queue,
 		     struct rte_mbuf *mbuf,
 		     uint8_t  flags,
 		     uint32_t *user_meta,
@@ -101,7 +101,7 @@ eth_ark_tx_desc_fill(struct ark_tx_queue *queue,
 
 /* ************************************************************************* */
 uint16_t
-eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ark_tx_queue *queue;
 	struct rte_mbuf *mbuf;
@@ -159,12 +159,12 @@ eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			tx_user_meta_hook(mbuf, user_meta, &user_len,
 					  queue->ext_user_data);
 		if (unlikely(mbuf->nb_segs != 1)) {
-			stat = eth_ark_tx_jumbo(queue, mbuf,
+			stat = ark_tx_jumbo(queue, mbuf,
 						user_meta, user_len);
 			if (unlikely(stat != 0))
 				break;		/* Queue is full */
 		} else {
-			eth_ark_tx_desc_fill(queue, mbuf,
+			ark_tx_desc_fill(queue, mbuf,
 					     ARK_DDM_SOP | ARK_DDM_EOP,
 					     user_meta, user_len);
 		}
@@ -195,7 +195,7 @@ eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 /* ************************************************************************* */
 static int
-eth_ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,
+ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,
 		 uint32_t *user_meta, uint8_t meta_cnt)
 {
 	struct rte_mbuf *next;
@@ -212,7 +212,7 @@ eth_ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,
 		next = mbuf->next;
 		flags |= (next == NULL) ? ARK_DDM_EOP : 0;
 
-		eth_ark_tx_desc_fill(queue, mbuf, flags, user_meta, meta_cnt);
+		ark_tx_desc_fill(queue, mbuf, flags, user_meta, meta_cnt);
 
 		flags &= ~ARK_DDM_SOP;	/* drop SOP flags */
 		meta_cnt = 0;		/* Meta only on SOP */
@@ -224,7 +224,7 @@ eth_ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,
 
 /* ************************************************************************* */
 int
-eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
+ark_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
 		       unsigned int socket_id,
@@ -291,7 +291,7 @@ eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
 	queue->ddm = RTE_PTR_ADD(ark->ddm.v, qidx * ARK_DDM_QOFFSET);
 	queue->mpu = RTE_PTR_ADD(ark->mputx.v, qidx * ARK_MPU_QOFFSET);
 
-	status = eth_ark_tx_hw_queue_config(queue);
+	status = ark_tx_hw_queue_config(queue);
 
 	if (unlikely(status != 0)) {
 		rte_free(queue->meta_q);
@@ -305,7 +305,7 @@ eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
 
 /* ************************************************************************* */
 static int
-eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue)
+ark_tx_hw_queue_config(struct ark_tx_queue *queue)
 {
 	rte_iova_t queue_base, ring_base, cons_index_addr;
 
@@ -333,7 +333,7 @@ eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue)
 
 /* ************************************************************************* */
 void
-eth_ark_tx_queue_release(void *vtx_queue)
+ark_tx_queue_release(void *vtx_queue)
 {
 	struct ark_tx_queue *queue;
 
@@ -352,7 +352,7 @@ eth_ark_tx_queue_release(void *vtx_queue)
 
 /* ************************************************************************* */
 int
-eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)
+ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct ark_tx_queue *queue;
 	int cnt = 0;
@@ -376,7 +376,7 @@ eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)
 }
 
 int
-eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id)
+ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct ark_tx_queue *queue;
 
@@ -415,7 +415,7 @@ free_completed_tx(struct ark_tx_queue *queue)
 
 /* ************************************************************************* */
 void
-eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
+ark_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
 {
 	struct ark_tx_queue *queue;
 	struct ark_ddm_t *ddm;
@@ -435,7 +435,7 @@ eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
 }
 
 void
-eth_tx_queue_stats_reset(void *vqueue)
+ark_tx_queue_stats_reset(void *vqueue)
 {
 	struct ark_tx_queue *queue;
 	struct ark_ddm_t *ddm;
diff --git a/drivers/net/ark/ark_ethdev_tx.h b/drivers/net/ark/ark_ethdev_tx.h
index 7134dbfeed..ee66ed19cc 100644
--- a/drivers/net/ark/ark_ethdev_tx.h
+++ b/drivers/net/ark/ark_ethdev_tx.h
@@ -10,18 +10,18 @@
 #include <ethdev_driver.h>
 
 
-uint16_t eth_ark_xmit_pkts(void *vtxq,
+uint16_t ark_xmit_pkts(void *vtxq,
 			   struct rte_mbuf **tx_pkts,
 			   uint16_t nb_pkts);
-int eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
+int ark_tx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
 			   unsigned int socket_id,
 			   const struct rte_eth_txconf *tx_conf);
-void eth_ark_tx_queue_release(void *vtx_queue);
-int eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
-int eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
-void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
-void eth_tx_queue_stats_reset(void *vqueue);
+void ark_tx_queue_release(void *vtx_queue);
+int ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
+int ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
+void ark_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
+void ark_tx_queue_stats_reset(void *vqueue);
 
 #endif
-- 
2.47.3

