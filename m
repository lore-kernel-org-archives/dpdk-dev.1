Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC715606F637
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WWzAZRmI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AA9142E7C;
	Tue,  3 Nov 2026 16:12:07 +0100 (CET)
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
 by mails.dpdk.org (Postfix) with ESMTPS id 40B7642E7A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:12:06 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=6yv6cyz1w5FzhI5qOR465e4PpqrDYzD7iywTSMorWsQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718725; v=1; x=1794323525;
 b=WWzAZRmIb5gH6l6PWszvk9GlWv2lT0eO0ulQGuL0uTNaGd/2PQMYFoeaPMUTXcz8KZD4wIq7
 GhbAxd/EOzfCFEKK4tfhlClV6WLVcSb0I8dr4gmJUOEP/i4xLGiLYWljCLzz4LsuvAV9Chbvdt4
 qwLjidDtEady+okEqAL35e1Q=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id af63bbcd51bfa0c8;
 Tue, 03 Nov 2026 15:12:05 +0000
X-Mizu-Trace-ID: af63bbcd51bfa0c8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 119/227] net/failsafe: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:17 +0800
Message-ID: <20261103145306.487255-120-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/failsafe/failsafe.c         |  6 +++---
 drivers/net/failsafe/failsafe_ether.c   |  4 ++--
 drivers/net/failsafe/failsafe_ops.c     | 12 ++++++------
 drivers/net/failsafe/failsafe_private.h |  4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/failsafe/failsafe.c b/drivers/net/failsafe/failsafe.c
index 3ba143924d..5f2555ee76 100644
--- a/drivers/net/failsafe/failsafe.c
+++ b/drivers/net/failsafe/failsafe.c
@@ -168,14 +168,14 @@ fs_eth_dev_create(struct rte_vdev_device *vdev)
 	struct fs_priv *priv;
 	struct sub_device *sdev;
 	const char *params;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	uint8_t i;
 	int ret;
 
 	dev = NULL;
 	priv = NULL;
-	socket_id = rte_socket_id();
-	INFO("Creating fail-safe device on NUMA socket %u", socket_id);
+	numa_id = rte_numa_id();
+	INFO("Creating fail-safe device on NUMA socket %u", numa_id);
 	params = rte_vdev_device_args(vdev);
 	if (params == NULL) {
 		ERROR("This PMD requires sub-devices, none provided");
diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index 307f2abfa5..0215970492 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -87,7 +87,7 @@ fs_eth_dev_conf_apply(struct rte_eth_dev *dev,
 
 		rxq = dev->data->rx_queues[i];
 		ret = rte_eth_rx_queue_setup(PORT_ID(sdev), i,
-				rxq->info.nb_desc, rxq->socket_id,
+				rxq->info.nb_desc, rxq->numa_id,
 				&rxq->info.conf, rxq->info.mp);
 		if (ret) {
 			ERROR("rx_queue_setup failed");
@@ -100,7 +100,7 @@ fs_eth_dev_conf_apply(struct rte_eth_dev *dev,
 
 		txq = dev->data->tx_queues[i];
 		ret = rte_eth_tx_queue_setup(PORT_ID(sdev), i,
-				txq->info.nb_desc, txq->socket_id,
+				txq->info.nb_desc, txq->numa_id,
 				&txq->info.conf);
 		if (ret) {
 			ERROR("tx_queue_setup failed");
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 5680451f21..b993b804e0 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -431,7 +431,7 @@ static int
 fs_rx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t rx_queue_id,
 		uint16_t nb_rx_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool)
 {
@@ -467,7 +467,7 @@ fs_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	rxq->qid = rx_queue_id;
-	rxq->socket_id = socket_id;
+	rxq->numa_id = numa_id;
 	rxq->info.mp = mb_pool;
 	rxq->info.conf = *rx_conf;
 	rxq->info.nb_desc = nb_rx_desc;
@@ -487,7 +487,7 @@ fs_rx_queue_setup(struct rte_eth_dev *dev,
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
 		ret = rte_eth_rx_queue_setup(PORT_ID(sdev),
 				rx_queue_id,
-				nb_rx_desc, socket_id,
+				nb_rx_desc, numa_id,
 				rx_conf, mb_pool);
 		if ((ret = fs_err(sdev, ret))) {
 			ERROR("RX queue setup failed for sub_device %d", i);
@@ -608,7 +608,7 @@ static int
 fs_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	struct sub_device *sdev;
@@ -643,7 +643,7 @@ fs_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	txq->qid = tx_queue_id;
-	txq->socket_id = socket_id;
+	txq->numa_id = numa_id;
 	txq->info.conf = *tx_conf;
 	txq->info.nb_desc = nb_tx_desc;
 	txq->priv = PRIV(dev);
@@ -651,7 +651,7 @@ fs_tx_queue_setup(struct rte_eth_dev *dev,
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
 		ret = rte_eth_tx_queue_setup(PORT_ID(sdev),
 				tx_queue_id,
-				nb_tx_desc, socket_id,
+				nb_tx_desc, numa_id,
 				tx_conf);
 		if ((ret = fs_err(sdev, ret))) {
 			ERROR("TX queue setup failed for sub_device %d", i);
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index a565ee2fbc..4235764dc9 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -71,7 +71,7 @@ struct rxq {
 	uint16_t qid;
 	/* next sub_device to poll */
 	struct sub_device *sdev;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	int event_fd;
 	unsigned int enable_events:1;
 	struct rte_eth_rxq_info info;
@@ -81,7 +81,7 @@ struct rxq {
 struct txq {
 	struct fs_priv *priv;
 	uint16_t qid;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	struct rte_eth_txq_info info;
 	RTE_ATOMIC(uint64_t) refcnt[];
 };
-- 
2.55.0

