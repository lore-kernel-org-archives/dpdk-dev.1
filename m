Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED49C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A2D040A79;
	Sun, 22 Feb 2026 18:32:57 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id AA4684066D
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:43 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d4beaf25deso2877193a34.0
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781563;
 x=1772386363; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfpIL/sEzyK6ZGktGXtnT7Nt4r1e0w4j4UpakEzXESw=;
 b=Qpgw6b+vyHx/uIBYS+d0sShsS0dUHIXtOddSgqwMHJCUplafZbK2xaznaqatxP7UrN
 nrizVT6+vADy9W/gVSt6RBvLREsfphc1WRHe1OvJoWFUpt9GgcCPnr4emM5AejjpIC5z
 yuoEXcIt9bHZgg8YA1mkfa6fBpPRaN+3hF04vtnBwsWKkJkJfFtYtfRr+4GsMq3PxHpZ
 a1JW+kQNqAm+XgARgaLdj8Dy5w9mUWWqLrL2ziQe2nTzHZ7OpXHSfPVKwa1mG059IaFk
 i97M10GlhHTSrnZ0m2DZbe3fipCcOSAR0akDkEjMyEZgMIQJa4ug4nmoMgQ2cIUaDlmt
 pxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781563; x=1772386363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QfpIL/sEzyK6ZGktGXtnT7Nt4r1e0w4j4UpakEzXESw=;
 b=G6p+CyJMejwc8LVfgftyTyTPvkgVcZRAeF5VuL81ykzDRdf/vi1BtCQl8Twe8DIeQ0
 stquRvZYFHEqBlcCHgqL0BkmXs9I2P/8VRSdCMV37OX13YGPyeW/t8xyHS7DlbfU0o9b
 1TwNMXFbqJFMcihFyY27lhwePPmLMVFoOBbTB6+Iolki1oUCqrdhm9/JModWL0NSVaVI
 Ty0mQlAb1ntokYcV2D8CmzqCdE7lvA0Ms1H1ru/wZPUb0tGWQFAzEid/wGVe4Crzm1uG
 mkBOfXjpPK9HHXePbk1q669X+itNV0CgRcN6OfPjaqJeYX3K8aw+SdF8UVScScUTUXSr
 6lZw==
X-Gm-Message-State: AOJu0YxEmZsaQeUIuUSYvdMa9AqtmsFjf1N9PR6wAcQTcnn+MWjH9nz4
 uTYJX/DvkCEwfng35a3/+tGsiXoni0ReBjOppIif9oGllwU2pDouA2McPU0NfPJBGrbYBg+iN85
 SRci/
X-Gm-Gg: AZuq6aKAyH9ussbqxsYOusmPJYWm71xDMyoF5nBpWJQQa5Cy4R3aFOlukBwseiQB3TO
 dLzAiyXp7PqehIaVA7CI4kuQy59QX11sV+qLboeZwfZAVc41srHsT/C1ryZ2fwJ2ScPdXpCxXBm
 BrZ4MOUW1MzXAVAJ0lwXw402PWsd4joxma1wRs9zB8yeRm2/H/9rD7Zu9d0hdsJeDNR3TSfw4LC
 6YbLo/i6iT6F3zMp3Mg5DOlBnIiB96PooXkq3EkXwYYGdOk37l6/R5J1p3D/PsdCXpwgA5mJrjE
 3f0jRaiwrTJ7fO+WBXirxLOIrgqs54p/8gdjZfJCeUsADh/IPmokTEJndw/eeENlZDBcjJF7eCC
 l0+ZQuHqmyHrcwZRgQ2b8wtoyJRBLq3v1HBtKw6ZoRvns09qQqjrZAN/DOkn4lHVVzJ7/EME1Xk
 6jBGsaxT2mZqWSFd+ylH/pNWCp6ov7tajy4POZD6HT2y8/sf82Pv6yup9ppzlRWg==
X-Received: by 2002:a05:6820:1508:b0:679:9654:9daf with SMTP id
 006d021491bc7-679b1036473mr7369193eaf.22.1771781562928; 
 Sun, 22 Feb 2026 09:32:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 13/19] net/tap: dynamically allocate queue structures
Date: Sun, 22 Feb 2026 09:30:48 -0800
Message-ID: <20260222173225.522754-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

Replace embedded rxq/txq arrays in pmd_internals with per-queue
allocations using rte_zmalloc_socket during queue setup. Queue
structures are freed in queue release and device close.

This reduces the size of pmd_internals and allocates queue resources.

Can safely remove some redundant checks in rx_queue_setup
since these checks are already done in the ethdev layer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 130 +++++++++++++++++++++++-----------
 drivers/net/tap/rte_eth_tap.h |   3 +-
 2 files changed, 90 insertions(+), 43 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 6640ac1596..75fa517ae2 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -942,29 +942,36 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 	uint64_t rx_total = 0, tx_total = 0, tx_err_total = 0;
 	uint64_t rx_bytes_total = 0, tx_bytes_total = 0;
 	uint64_t rx_nombuf = 0, ierrors = 0;
-	const struct pmd_internals *pmd = dev->data->dev_private;
 
 	/* rx queue statistics */
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq == NULL)
+			continue;
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = pmd->rxq[i].stats.ipackets;
-			qstats->q_ibytes[i] = pmd->rxq[i].stats.ibytes;
+			qstats->q_ipackets[i] = rxq->stats.ipackets;
+			qstats->q_ibytes[i] = rxq->stats.ibytes;
 		}
-		rx_total += pmd->rxq[i].stats.ipackets;
-		rx_bytes_total += pmd->rxq[i].stats.ibytes;
-		rx_nombuf += pmd->rxq[i].stats.rx_nombuf;
-		ierrors += pmd->rxq[i].stats.ierrors;
+		rx_total += rxq->stats.ipackets;
+		rx_bytes_total += rxq->stats.ibytes;
+		rx_nombuf += rxq->stats.rx_nombuf;
+		ierrors += rxq->stats.ierrors;
 	}
 
 	/* tx queue statistics */
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct tx_queue *txq = dev->data->tx_queues[i];
+
+		if (txq == NULL)
+			continue;
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = pmd->txq[i].stats.opackets;
-			qstats->q_obytes[i] = pmd->txq[i].stats.obytes;
+			qstats->q_opackets[i] = txq->stats.opackets;
+			qstats->q_obytes[i] = txq->stats.obytes;
 		}
-		tx_total += pmd->txq[i].stats.opackets;
-		tx_bytes_total += pmd->txq[i].stats.obytes;
-		tx_err_total += pmd->txq[i].stats.errs;
+		tx_total += txq->stats.opackets;
+		tx_bytes_total += txq->stats.obytes;
+		tx_err_total += txq->stats.errs;
 	}
 
 	tap_stats->ipackets = rx_total;
@@ -981,11 +988,19 @@ static int
 tap_stats_reset(struct rte_eth_dev *dev)
 {
 	unsigned int i;
-	struct pmd_internals *pmd = dev->data->dev_private;
 
-	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
-		memset(&pmd->rxq[i].stats, 0, sizeof(struct pkt_stats));
-		memset(&pmd->txq[i].stats, 0, sizeof(struct pkt_stats));
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq != NULL)
+			memset(&rxq->stats, 0, sizeof(struct pkt_stats));
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct tx_queue *txq = dev->data->tx_queues[i];
+
+		if (txq != NULL)
+			memset(&txq->stats, 0, sizeof(struct pkt_stats));
 	}
 
 	return 0;
@@ -1028,14 +1043,21 @@ tap_dev_close(struct rte_eth_dev *dev)
 #endif
 
 	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
-		struct rx_queue *rxq = &internals->rxq[i];
+		struct rx_queue *rxq = dev->data->rx_queues[i];
 
 		tap_queue_close(process_private, i);
 
-		tap_rxq_pool_free(rxq->pool);
-		rte_free(rxq->iovecs);
-		rxq->pool = NULL;
-		rxq->iovecs = NULL;
+		if (rxq != NULL) {
+			tap_rxq_pool_free(rxq->pool);
+			rte_free(rxq->iovecs);
+			rte_free(rxq);
+			dev->data->rx_queues[i] = NULL;
+		}
+
+		if (dev->data->tx_queues[i] != NULL) {
+			rte_free(dev->data->tx_queues[i]);
+			dev->data->tx_queues[i] = NULL;
+		}
 	}
 
 	if (internals->remote_if_index) {
@@ -1094,11 +1116,12 @@ tap_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 	tap_rxq_pool_free(rxq->pool);
 	rte_free(rxq->iovecs);
-	rxq->pool = NULL;
-	rxq->iovecs = NULL;
 
 	if (dev->data->tx_queues[qid] == NULL)
 		tap_queue_close(process_private, qid);
+
+	rte_free(rxq);
+	dev->data->rx_queues[qid] = NULL;
 }
 
 static void
@@ -1113,6 +1136,9 @@ tap_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	process_private = rte_eth_devices[txq->out_port].process_private;
 	if (dev->data->rx_queues[qid] == NULL)
 		tap_queue_close(process_private, qid);
+
+	rte_free(txq);
+	dev->data->tx_queues[qid] = NULL;
 }
 
 static int
@@ -1424,16 +1450,14 @@ tap_gso_ctx_setup(struct rte_gso_ctx *gso_ctx, struct rte_eth_dev *dev)
 
 static int
 tap_setup_queue(struct rte_eth_dev *dev,
-		struct pmd_internals *internals,
 		uint16_t qid,
 		int is_rx)
 {
 	int fd, ret;
 	struct pmd_internals *pmd = dev->data->dev_private;
 	struct pmd_process_private *process_private = dev->process_private;
-	struct rx_queue *rx = &internals->rxq[qid];
-	struct tx_queue *tx = &internals->txq[qid];
-	struct rte_gso_ctx *gso_ctx = is_rx ? NULL : &tx->gso_ctx;
+	struct tx_queue *tx = dev->data->tx_queues[qid];
+	struct rte_gso_ctx *gso_ctx = (is_rx || tx == NULL) ? NULL : &tx->gso_ctx;
 	const char *dir = is_rx ? "rx" : "tx";
 
 	fd = process_private->fds[qid];
@@ -1455,16 +1479,16 @@ tap_setup_queue(struct rte_eth_dev *dev,
 		process_private->fds[qid] = fd;
 	}
 
-	tx->mtu = &dev->data->mtu;
-	rx->rxmode = &dev->data->dev_conf.rxmode;
+	if (tx != NULL) {
+		tx->mtu = &dev->data->mtu;
+		tx->type = pmd->type;
+	}
 	if (gso_ctx) {
 		ret = tap_gso_ctx_setup(gso_ctx, dev);
 		if (ret)
 			return -1;
 	}
 
-	tx->type = pmd->type;
-
 	return fd;
 }
 
@@ -1478,8 +1502,8 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 {
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pmd_process_private *process_private = dev->process_private;
-	struct rx_queue *rxq = &internals->rxq[rx_queue_id];
-	struct rte_mbuf **tmp = &rxq->pool;
+	struct rx_queue *rxq;
+	struct rte_mbuf **tmp;
 	long iov_max = sysconf(_SC_IOV_MAX);
 
 	if (iov_max <= 0) {
@@ -1502,23 +1526,35 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 		return -1;
 	}
 
+	rxq = rte_zmalloc_socket(dev->device->name, sizeof(*rxq), 0,
+				  socket_id);
+	if (!rxq) {
+		TAP_LOG(ERR,
+			"%s: Couldn't allocate rx queue structure",
+			dev->device->name);
+		return -ENOMEM;
+	}
+	tmp = &rxq->pool;
+
 	rxq->mp = mp;
 	rxq->trigger_seen = 1; /* force initial burst */
 	rxq->in_port = dev->data->port_id;
 	rxq->queue_id = rx_queue_id;
 	rxq->nb_rx_desc = nb_desc;
+	rxq->rxmode = &dev->data->dev_conf.rxmode;
 	iovecs = rte_zmalloc_socket(dev->device->name, sizeof(*iovecs), 0,
 				    socket_id);
 	if (!iovecs) {
 		TAP_LOG(WARNING,
 			"%s: Couldn't allocate %d RX descriptors",
 			dev->device->name, nb_desc);
+		rte_free(rxq);
 		return -ENOMEM;
 	}
 	rxq->iovecs = iovecs;
 
 	dev->data->rx_queues[rx_queue_id] = rxq;
-	fd = tap_setup_queue(dev, internals, rx_queue_id, 1);
+	fd = tap_setup_queue(dev, rx_queue_id, 1);
 	if (fd == -1) {
 		ret = fd;
 		goto error;
@@ -1556,9 +1592,9 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 
 error:
 	tap_rxq_pool_free(rxq->pool);
-	rxq->pool = NULL;
 	rte_free(rxq->iovecs);
-	rxq->iovecs = NULL;
+	rte_free(rxq);
+	dev->data->rx_queues[rx_queue_id] = NULL;
 	return ret;
 }
 
@@ -1566,7 +1602,7 @@ static int
 tap_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t tx_queue_id,
 		   uint16_t nb_tx_desc __rte_unused,
-		   unsigned int socket_id __rte_unused,
+		   unsigned int socket_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -1577,8 +1613,17 @@ tap_tx_queue_setup(struct rte_eth_dev *dev,
 
 	if (tx_queue_id >= dev->data->nb_tx_queues)
 		return -1;
-	dev->data->tx_queues[tx_queue_id] = &internals->txq[tx_queue_id];
-	txq = dev->data->tx_queues[tx_queue_id];
+
+	txq = rte_zmalloc_socket(dev->device->name, sizeof(*txq), 0,
+				  socket_id);
+	if (!txq) {
+		TAP_LOG(ERR,
+			"%s: Couldn't allocate tx queue structure",
+			dev->device->name);
+		return -ENOMEM;
+	}
+
+	dev->data->tx_queues[tx_queue_id] = txq;
 	txq->out_port = dev->data->port_id;
 	txq->queue_id = tx_queue_id;
 
@@ -1588,9 +1633,12 @@ tap_tx_queue_setup(struct rte_eth_dev *dev,
 			 RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
 			 RTE_ETH_TX_OFFLOAD_TCP_CKSUM));
 
-	ret = tap_setup_queue(dev, internals, tx_queue_id, 0);
-	if (ret == -1)
+	ret = tap_setup_queue(dev, tx_queue_id, 0);
+	if (ret == -1) {
+		rte_free(txq);
+		dev->data->tx_queues[tx_queue_id] = NULL;
 		return -1;
+	}
 	TAP_LOG(DEBUG,
 		"  TX TUNTAP device name %s, qid %d on fd %d csum %s",
 		internals->name, tx_queue_id,
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 7be8f4d01b..365d5a5fe1 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -88,8 +88,7 @@ struct pmd_internals {
 	LIST_HEAD(tap_implicit_flows, rte_flow) implicit_flows;
 #endif
 
-	struct rx_queue rxq[RTE_PMD_TAP_MAX_QUEUES]; /* List of RX queues */
-	struct tx_queue txq[RTE_PMD_TAP_MAX_QUEUES]; /* List of TX queues */
+
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
 	int ka_fd;                        /* keep-alive file descriptor */
 	struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
-- 
2.51.0

