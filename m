Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3C606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aBK+cOb4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66BCA40151;
	Tue, 27 Oct 2026 19:56:17 +0100 (CET)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTPS id 61133400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:56:16 +0100 (CET)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2eaf8ea208bso1032375ad.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127375; x=1793732175; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UM1QAJx6CjVL3DMiBDluGJ9VYuVL/qjfGKBs3Rn3kRU=;
 b=aBK+cOb4G6rr6RU2arq4fsMdXLGp9n76Us2UU8rePZ6z2OtXtK4mZPwvunQg5uSZKB
 xM395drhm+3XRC7ejFCrorIPERGWktqpc50ck3ZutOltgHeJl6uh0mfqhhwT1/rDQwTW
 S/dtczJKi5YFcRO2jDsInLOeulBqBf+RLuD7OtNbCXGyH+TBW72VrOyCVH66GAnvrx/M
 6oABXpbZx3ppfipIKrxXdWeNblnbCUT9OcIXxqc9BxMw8DjuyfXij1aDTaETquHXnbEL
 N8wnR51IKmXvtgkzNDPYoQqMihMMUa/ZAw+r2NHRAUeKDD02yak1cQE67xfLSk20sMPi
 RVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127375; x=1793732175;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UM1QAJx6CjVL3DMiBDluGJ9VYuVL/qjfGKBs3Rn3kRU=;
 b=CU1qgEZaE55vSGDXbdMlRqShNU+ygfkO6ckXAOZHZq7H7v0FarqDBvj+Gg1Dk5F+vm
 tIVnFe2vyH5LFORorjZ4tVjvHHC/+ToGfYjd6FfIfRLd7B2u+DfQzJ6FnMSEg8xTyxnf
 Q4IRrDzFFyrPLyLJl/AhYjnrCSEIpT0gZmE9qOEK5mQG+TC3ulfLOupkpav/A+BcJTnT
 Qhu+n3dq9jbU7LopHDRuFahFfvwoOnmYlEzlq5wKeVT59VtBhBf5f2QycU75E3UVdMcb
 /f6yDgxxf4DimoSGEof3d+Su0IEzXJPDMb5kg7IHvIk5cmsGvevWV9LKlHP90LUNElKm
 hPDw==
X-Gm-Message-State: AFq9FYJ7ZiDrrX7KpHdssEQhbNVnt2KXYlw7rX95+JP3MjAfNPuLIrJy
 /pY5t+kndx7XYuZsVOsJvGdbRRx5gsjN8HuSIwCCvbBEbYu/1MGFDEoM7I650cWS8UFoZ0jh0NT
 nFbDr0pKs9wDkG02LoqfFwrm4jxxSjhm7JRp3pHiibh5P8IoesAfRXPwqTPkJr0fp+LkGf/LQ8G
 gUn+ide6f/fHNDiTOH4qJ/Mk3/i1IXRo9W5RTz9EFTB3DwseTmuQ==
X-Received: from plka14.prod.google.com ([2002:a17:903:f8e:b0:2e2:f8c9:e138])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:458d:b0:2dd:c053:82f1 with SMTP id
 d9443c01a7336-2eb004fa307mr2087915ad.40.1793127374486; 
 Tue, 27 Oct 2026 11:56:14 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:11 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-3-jtranoleary@google.com>
Subject: [PATCH 2/9] net/gve: snapshot queue configurations
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Cc: "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Snapshot RX and TX queue setup parameters in priv->rxq_configs and
priv->txq_configs during queue setup so that queues can be reconstructed
identically during a proactive reset recovery.
In addition, suffix DMA ring and resource memzone names with the current
reset generation number (rx_ring_g%u, tx_ring_g%u, etc.) so that new
memzones can be allocated during recovery before old memzones are
retired.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 67 +++++++++++++++++++++++++------
 drivers/net/gve/gve_ethdev.h | 31 ++++++++++++++
 drivers/net/gve/gve_rx.c     | 36 ++++++++++++++---
 drivers/net/gve/gve_rx_dqo.c | 36 ++++++++++++++---
 drivers/net/gve/gve_tx.c     | 32 ++++++++++++---
 drivers/net/gve/gve_tx_dqo.c | 35 +++++++++++++---
 6 files changed, 201 insertions(+), 36 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 90d8797b0..47714844e 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -40,6 +40,24 @@ gve_alloc_using_mz(const char *name, uint32_t num_pages)
 	return mz;
 }
 
+static void
+gve_free_rxq(struct gve_priv *priv, struct gve_rx_queue *rxq)
+{
+	if (gve_is_gqi(priv))
+		gve_rx_queue_release_internal(rxq);
+	else
+		gve_rx_queue_release_internal_dqo(rxq);
+}
+
+static void
+gve_free_txq(struct gve_priv *priv, struct gve_tx_queue *txq)
+{
+	if (gve_is_gqi(priv))
+		gve_tx_queue_release_internal(txq);
+	else
+		gve_tx_queue_release_internal_dqo(txq);
+}
+
 static int
 gve_alloc_using_malloc(void **bufs, uint32_t num_entries)
 {
@@ -162,8 +180,9 @@ gve_setup_queue_page_list(struct gve_priv *priv, uint16_t queue_id, bool is_rx,
 	process_priv = rte_eth_devices[priv->port_id].process_private;
 
 	/* Allocate a new QPL. */
-	snprintf(qpl_name, sizeof(qpl_name), "gve_%s_%s_qpl%d",
-		priv->pci_dev->device.name, queue_type_string, queue_id);
+	snprintf(qpl_name, sizeof(qpl_name), "gve_p%u_%s_qpl%u_g%u",
+		 priv->port_id, queue_type_string, queue_id,
+		 priv->reset_generation);
 	qpl = gve_alloc_queue_page_list(qpl_name, num_pages, is_rx);
 	if (!qpl) {
 		PMD_DRV_LOG(ERR,
@@ -639,18 +658,14 @@ gve_free_queues(struct rte_eth_dev *dev)
 	struct gve_priv *priv = dev->data->dev_private;
 	uint16_t i;
 
-	if (gve_is_gqi(priv)) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++)
-			gve_tx_queue_release(dev, i);
-
-		for (i = 0; i < dev->data->nb_rx_queues; i++)
-			gve_rx_queue_release(dev, i);
-	} else {
-		for (i = 0; i < dev->data->nb_tx_queues; i++)
-			gve_tx_queue_release_dqo(dev, i);
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		gve_free_txq(priv, dev->data->tx_queues[i]);
+		dev->data->tx_queues[i] = NULL;
+	}
 
-		for (i = 0; i < dev->data->nb_rx_queues; i++)
-			gve_rx_queue_release_dqo(dev, i);
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		gve_free_rxq(priv, dev->data->rx_queues[i]);
+		dev->data->rx_queues[i] = NULL;
 	}
 }
 
@@ -779,6 +794,11 @@ gve_dev_close(struct rte_eth_dev *dev)
 	pthread_mutex_destroy(&priv->flow_rule_lock);
 	pthread_mutex_destroy(&priv->nic_ts_lock);
 
+	rte_free(priv->rxq_configs);
+	priv->rxq_configs = NULL;
+	rte_free(priv->txq_configs);
+	priv->txq_configs = NULL;
+
 	dev->data->mac_addrs = NULL;
 
 	free(dev->process_private);
@@ -1735,6 +1755,21 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	PMD_DRV_LOG(INFO, "Max TX queues %d, Max RX queues %d",
 		    priv->max_nb_txq, priv->max_nb_rxq);
 
+	priv->rxq_configs =
+		rte_zmalloc("gve_rxq_configs",
+			    sizeof(struct gve_rxq_config) * priv->max_nb_rxq,
+			    RTE_CACHE_LINE_SIZE);
+
+	priv->txq_configs =
+		rte_zmalloc("gve_txq_configs",
+			    sizeof(struct gve_txq_config) * priv->max_nb_txq,
+			    RTE_CACHE_LINE_SIZE);
+
+	if (!priv->rxq_configs || !priv->txq_configs) {
+		err = -ENOMEM;
+		goto free_queue_configs;
+	}
+
 setup_device:
 	if (process_priv->ctrl_ops->query_rss != NULL)
 		priv->rss_cache_dirty = true;
@@ -1754,6 +1789,11 @@ setup_device:
 free_flow_subsystem:
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
+free_queue_configs:
+	rte_free(priv->txq_configs);
+	priv->txq_configs = NULL;
+	rte_free(priv->rxq_configs);
+	priv->rxq_configs = NULL;
 free_adminq:
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
 	return err;
@@ -1814,6 +1854,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	priv->pci_dev = pci_dev;
 	priv->port_id = eth_dev->data->port_id;
 	priv->state_flags = 0x0;
+	priv->reset_generation = 0;
 
 	pthread_mutexattr_init(&mutexattr);
 	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 19eac9ec0..8df4fa54c 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -279,6 +279,21 @@ enum gve_dev_clk_type {
 	GVE_DEV_CLK_CMD,
 };
 
+struct gve_rxq_config {
+	uint16_t nb_descriptors;
+	unsigned int socket_id;
+	struct rte_eth_rxconf conf;
+	struct rte_mempool *mb_pool;
+	bool allocated;
+};
+
+struct gve_txq_config {
+	uint16_t nb_descriptors;
+	unsigned int socket_id;
+	struct rte_eth_txconf conf;
+	bool allocated;
+};
+
 struct gve_ctrl_ops {
 	int (*init_ctrl_plane)(struct gve_priv *priv);
 	void (*free_ctrl_plane)(struct gve_priv *priv);
@@ -352,6 +367,10 @@ struct gve_priv {
 	uint16_t max_nb_rxq;
 	uint32_t num_ntfy_blks; /* spilt between TX and RX so must be even */
 
+	struct gve_rxq_config *rxq_configs;
+	struct gve_txq_config *txq_configs;
+	uint32_t reset_generation;
+
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
 	rte_be32_t __iomem *db_bar; /* "array" of doorbells */
 	struct rte_pci_device *pci_dev;
@@ -614,6 +633,18 @@ gve_tx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid);
 void
 gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid);
 
+void
+gve_rx_queue_release_internal(struct gve_rx_queue *rxq);
+
+void
+gve_rx_queue_release_internal_dqo(struct gve_rx_queue *rxq);
+
+void
+gve_tx_queue_release_internal(struct gve_tx_queue *txq);
+
+void
+gve_tx_queue_release_internal_dqo(struct gve_tx_queue *txq);
+
 int
 gve_rx_queue_start_dqo(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 7995560d3..f09ec40f8 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -274,10 +274,8 @@ gve_release_rxq_mbufs(struct gve_rx_queue *rxq)
 }
 
 void
-gve_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+gve_rx_queue_release_internal(struct gve_rx_queue *q)
 {
-	struct gve_rx_queue *q = dev->data->rx_queues[qid];
-
 	if (!q)
 		return;
 
@@ -293,7 +291,21 @@ gve_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+}
 
+void
+gve_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct gve_rx_queue *q = dev->data->rx_queues[qid];
+	struct gve_priv *priv = dev->data->dev_private;
+
+	if (!q)
+		return;
+
+	if (priv->rxq_configs)
+		priv->rxq_configs[qid].allocated = false;
+
+	gve_rx_queue_release_internal(q);
 	dev->data->rx_queues[qid] = NULL;
 }
 
@@ -303,6 +315,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 		const struct rte_eth_rxconf *conf, struct rte_mempool *pool)
 {
 	struct gve_priv *hw = dev->data->dev_private;
+	char ring_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
 	struct gve_rx_queue *rxq;
 	uint16_t free_thresh;
@@ -366,7 +379,8 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 		goto err_rxq;
 	}
 
-	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "rx_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      nb_desc * sizeof(struct gve_rx_desc),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -378,7 +392,8 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->rx_ring_phys_addr = mz->iova;
 	rxq->mz = mz;
 
-	mz = rte_eth_dma_zone_reserve(dev, "gve rx data ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "rx_data_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      sizeof(union gve_rx_data_slot) * nb_desc,
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -402,7 +417,8 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 		}
 	}
 
-	mz = rte_eth_dma_zone_reserve(dev, "rxq_res", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "rxq_res_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      sizeof(struct gve_queue_resources),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -415,6 +431,14 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	gve_reset_rxq(rxq);
 
+	if (hw->rxq_configs) {
+		hw->rxq_configs[queue_id].nb_descriptors = nb_desc;
+		hw->rxq_configs[queue_id].socket_id = socket_id;
+		hw->rxq_configs[queue_id].conf = *conf;
+		hw->rxq_configs[queue_id].mb_pool = pool;
+		hw->rxq_configs[queue_id].allocated = true;
+	}
+
 	dev->data->rx_queues[queue_id] = rxq;
 
 	return 0;
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 03c62edee..448025b94 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -266,10 +266,8 @@ gve_release_rxq_mbufs_dqo(struct gve_rx_queue *rxq)
 }
 
 void
-gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
+gve_rx_queue_release_internal_dqo(struct gve_rx_queue *q)
 {
-	struct gve_rx_queue *q = dev->data->rx_queues[qid];
-
 	if (q == NULL)
 		return;
 
@@ -282,7 +280,21 @@ gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+}
 
+void
+gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct gve_rx_queue *q = dev->data->rx_queues[qid];
+	struct gve_priv *priv = dev->data->dev_private;
+
+	if (q == NULL)
+		return;
+
+	if (priv->rxq_configs)
+		priv->rxq_configs[qid].allocated = false;
+
+	gve_rx_queue_release_internal_dqo(q);
 	dev->data->rx_queues[qid] = NULL;
 }
 
@@ -325,6 +337,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 		       struct rte_mempool *pool)
 {
 	struct gve_priv *hw = dev->data->dev_private;
+	char ring_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
 	struct gve_rx_queue *rxq;
 	uint16_t free_thresh;
@@ -409,7 +422,8 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* Allocate RX buffer queue */
-	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "rx_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      nb_desc * sizeof(struct gve_rx_desc_dqo),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -422,7 +436,8 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->mz = mz;
 
 	/* Allocate RX completion queue */
-	mz = rte_eth_dma_zone_reserve(dev, "compl_ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "rx_compl_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      nb_desc * sizeof(struct gve_rx_compl_desc_dqo),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -436,7 +451,8 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->compl_ring_phys_addr = mz->iova;
 	rxq->compl_ring_mz = mz;
 
-	mz = rte_eth_dma_zone_reserve(dev, "rxq_res", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "rxq_res_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      sizeof(struct gve_queue_resources),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -449,6 +465,14 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	gve_reset_rx_ring_state_dqo(rxq);
 
+	if (hw->rxq_configs) {
+		hw->rxq_configs[queue_id].nb_descriptors = nb_desc;
+		hw->rxq_configs[queue_id].socket_id = socket_id;
+		hw->rxq_configs[queue_id].conf = *conf;
+		hw->rxq_configs[queue_id].mb_pool = pool;
+		hw->rxq_configs[queue_id].allocated = true;
+	}
+
 	dev->data->rx_queues[queue_id] = rxq;
 
 	return 0;
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 47389836d..51c2fac09 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -537,10 +537,8 @@ gve_release_txq_mbufs(struct gve_tx_queue *txq)
 }
 
 void
-gve_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+gve_tx_queue_release_internal(struct gve_tx_queue *q)
 {
-	struct gve_tx_queue *q = dev->data->tx_queues[qid];
-
 	if (!q)
 		return;
 
@@ -556,7 +554,21 @@ gve_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+}
 
+void
+gve_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct gve_tx_queue *q = dev->data->tx_queues[qid];
+	struct gve_priv *priv = dev->data->dev_private;
+
+	if (!q)
+		return;
+
+	if (priv->txq_configs)
+		priv->txq_configs[qid].allocated = false;
+
+	gve_tx_queue_release_internal(q);
 	dev->data->tx_queues[qid] = NULL;
 }
 
@@ -565,6 +577,7 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 		   unsigned int socket_id, const struct rte_eth_txconf *conf)
 {
 	struct gve_priv *hw = dev->data->dev_private;
+	char ring_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
 	struct gve_tx_queue *txq;
 	uint16_t free_thresh;
@@ -619,7 +632,8 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 		goto err_txq;
 	}
 
-	mz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "tx_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      nb_desc * sizeof(union gve_tx_desc),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -652,7 +666,8 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 		}
 	}
 
-	mz = rte_eth_dma_zone_reserve(dev, "txq_res", queue_id, sizeof(struct gve_queue_resources),
+	snprintf(ring_name, sizeof(ring_name), "txq_res_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id, sizeof(struct gve_queue_resources),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX resource");
@@ -664,6 +679,13 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 
 	gve_reset_txq(txq);
 
+	if (hw->txq_configs) {
+		hw->txq_configs[queue_id].nb_descriptors = nb_desc;
+		hw->txq_configs[queue_id].socket_id = socket_id;
+		hw->txq_configs[queue_id].conf = *conf;
+		hw->txq_configs[queue_id].allocated = true;
+	}
+
 	dev->data->tx_queues[queue_id] = txq;
 
 	return 0;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index e6c1cd29b..64470ce23 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -362,10 +362,8 @@ gve_release_txq_mbufs_dqo(struct gve_tx_queue *txq)
 }
 
 void
-gve_tx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
+gve_tx_queue_release_internal_dqo(struct gve_tx_queue *q)
 {
-	struct gve_tx_queue *q = dev->data->tx_queues[qid];
-
 	if (q == NULL)
 		return;
 
@@ -376,7 +374,21 @@ gve_tx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+}
 
+void
+gve_tx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct gve_tx_queue *q = dev->data->tx_queues[qid];
+	struct gve_priv *priv = dev->data->dev_private;
+
+	if (q == NULL)
+		return;
+
+	if (priv->txq_configs)
+		priv->txq_configs[qid].allocated = false;
+
+	gve_tx_queue_release_internal_dqo(q);
 	dev->data->tx_queues[qid] = NULL;
 }
 
@@ -453,6 +465,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 		       const struct rte_eth_txconf *conf)
 {
 	struct gve_priv *hw = dev->data->dev_private;
+	char ring_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
 	struct gve_tx_queue *txq;
 	uint16_t free_thresh;
@@ -506,7 +519,8 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->sw_size = sw_size;
 
 	/* Allocate TX hardware ring descriptors. */
-	mz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "tx_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      nb_desc * sizeof(union gve_tx_desc_dqo),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -519,7 +533,8 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->mz = mz;
 
 	/* Allocate TX completion ring descriptors. */
-	mz = rte_eth_dma_zone_reserve(dev, "tx_compl_ring", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "tx_compl_ring_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				       txq->nb_complq_desc * sizeof(struct gve_tx_compl_desc),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -531,7 +546,8 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->compl_ring_phys_addr = mz->iova;
 	txq->compl_ring_mz = mz;
 
-	mz = rte_eth_dma_zone_reserve(dev, "txq_res", queue_id,
+	snprintf(ring_name, sizeof(ring_name), "txq_res_g%u", hw->reset_generation);
+	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
 				      sizeof(struct gve_queue_resources),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
@@ -544,6 +560,13 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	gve_reset_tx_ring_state_dqo(txq);
 
+	if (hw->txq_configs) {
+		hw->txq_configs[queue_id].nb_descriptors = nb_desc;
+		hw->txq_configs[queue_id].socket_id = socket_id;
+		hw->txq_configs[queue_id].conf = *conf;
+		hw->txq_configs[queue_id].allocated = true;
+	}
+
 	dev->data->tx_queues[queue_id] = txq;
 
 	return 0;
-- 
2.56.0.307.g5fe7bd680c-goog

