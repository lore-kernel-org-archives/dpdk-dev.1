Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A863606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZzpNOe2F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FE474060C;
	Tue, 27 Oct 2026 19:56:21 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTPS id C6F304060C
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:56:19 +0100 (CET)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e8ba4757baso1008395ad.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127378; x=1793732178; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UXekL2wTJEZgotGuSEz0w1miaC1cVv/BI+TkalcicJ0=;
 b=ZzpNOe2Fhmy12EaYnwD6+7QQtF/CrxjkV3tY8widBkWqO+x7RRP0ydURBz+n04Up08
 8b9gzzHgQKWw7ZA993pq0ayB3NO4qJuOuhUmxtxocXJ5xFVOSp3SHUrOA8+zBJoALm2B
 S798AFNjxze9/t3VXWIoSLqkexvXLWrJj+KhQ/MalyJF1eNZohy3csZCMqLqgeOaVITV
 fvsNjLFRL0D/6hdJRH0Nxg0jukSIqYSFFQPFi8E5LhIuQkyzx4urdkFGUkq4nSNIlmzf
 QsPBTW0+yKvJtdhBC52ihZW4DZlSay/PVT6KP9PDRfY4wRnYHvaS31rFvYQiYpNGEBS3
 Jeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127378; x=1793732178;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UXekL2wTJEZgotGuSEz0w1miaC1cVv/BI+TkalcicJ0=;
 b=OFINkWCveS4tnPVGSKUY2LSeKX6bVYKmCrSglMlfXtBgBFr9GVN2u1tpFJkybTH5Gu
 zqR7Q2AugOUF5bmkbANYsb8LfgfE3DwsJvF0U4bl4+DWuCP+2uaiUfb8QIOW4xNk9450
 IK+BN7vdFfJ+JWbdibZrXyG66Jt+GimFrmbGy0pNm2IUho35UGwjo7k/v6/NsvDXbqcT
 JCJYavVeGkIMtalF4qfRLWr+Msd2Drr/VNvXbzDKzjHTZehTb0bgaaig2sDM6C7iDOqc
 2GXHUh6/ORzglpdpA85pM8TXOnW89Vs903Nk69nGaK7c/qAGZJDNdoRhybbYl4qzkzNP
 +VWw==
X-Gm-Message-State: AFq9FYKFYSw5BzJABuQCzNji0mURCUcjXGk+UjKljpl5E9nA6pGtveiJ
 0O5JF378pRmzbX86QclZdSoyOeogSh0fInSkkQ7ft357mIX1UF/2pDydeSo/imQJo2vMQKNW93h
 NBiS6CJ7ZUNpVQF5g+KTOQtW6kU8FgTNojwOp2x3us0ZrK8ngWbGxydncJT8AG0Xe3PQ0jC5+l9
 UYBKCDbYldTe3LyYurN5huhBLY8WYPCddxuc9LkamNOuK5v9qxow==
X-Received: from plblh15.prod.google.com ([2002:a17:903:290f:b0:2ea:ff0c:b0a7])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c06:b0:2dd:ad74:ac28 with SMTP id
 d9443c01a7336-2eb003b2f49mr2301705ad.26.1793127377939; 
 Tue, 27 Oct 2026 11:56:17 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:12 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-4-jtranoleary@google.com>
Subject: [PATCH 3/9] net/gve: add deferred queue memory reclamation
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

Add zombie queue infrastructure to defer freeing retired queue memory
and descriptor rings across resets. This gives concurrent packet burst
workers a grace period before memzones are released, preventing
use-after-free.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 93 ++++++++++++++++++++++++++++++-
 drivers/net/gve/gve_ethdev.h | 23 ++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 47714844e..680fc9947 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -58,6 +58,76 @@ gve_free_txq(struct gve_priv *priv, struct gve_tx_queue *txq)
 		gve_tx_queue_release_internal_dqo(txq);
 }
 
+void
+gve_add_zombie_rx_queue(struct gve_priv *priv, struct gve_rx_queue *rxq)
+{
+	uint16_t queue_id;
+
+	if (!rxq)
+		return;
+
+	queue_id = rxq->queue_id;
+	if (queue_id >= priv->max_nb_rxq)
+		return;
+
+	if (priv->zombie_rx_queues[queue_id])
+		gve_free_rxq(priv, priv->zombie_rx_queues[queue_id]);
+
+	priv->zombie_rx_queues[queue_id] = rxq;
+
+	rxq->zombie_retire_time =
+		rte_get_timer_cycles() + (rte_get_timer_hz() * ZOMBIE_QUEUE_TTL_S);
+}
+
+void
+gve_add_zombie_tx_queue(struct gve_priv *priv, struct gve_tx_queue *txq)
+{
+	uint16_t queue_id;
+
+	if (!txq)
+		return;
+
+	queue_id = txq->queue_id;
+	if (queue_id >= priv->max_nb_txq)
+		return;
+
+	if (priv->zombie_tx_queues[queue_id])
+		gve_free_txq(priv, priv->zombie_tx_queues[queue_id]);
+
+	priv->zombie_tx_queues[queue_id] = txq;
+
+	txq->zombie_retire_time =
+		rte_get_timer_cycles() + (rte_get_timer_hz() * ZOMBIE_QUEUE_TTL_S);
+}
+
+void
+gve_clean_zombie_queues(struct gve_priv *priv, bool force)
+{
+	uint64_t now = rte_get_timer_cycles();
+	struct gve_rx_queue *rxq;
+	struct gve_tx_queue *txq;
+	int i;
+
+	if (!priv || !priv->zombie_rx_queues || !priv->zombie_tx_queues)
+		return;
+
+	for (i = 0; i < priv->max_nb_rxq; i++) {
+		rxq = priv->zombie_rx_queues[i];
+		if (rxq && (rxq->zombie_retire_time <= now || force)) {
+			gve_free_rxq(priv, rxq);
+			priv->zombie_rx_queues[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < priv->max_nb_txq; i++) {
+		txq = priv->zombie_tx_queues[i];
+		if (txq && (txq->zombie_retire_time <= now || force)) {
+			gve_free_txq(priv, txq);
+			priv->zombie_tx_queues[i] = NULL;
+		}
+	}
+}
+
 static int
 gve_alloc_using_malloc(void **bufs, uint32_t num_entries)
 {
@@ -788,6 +858,12 @@ gve_dev_close(struct rte_eth_dev *dev)
 		gve_teardown_flow_subsystem(priv);
 
 	gve_free_queues(dev);
+	gve_clean_zombie_queues(priv, true);
+	rte_free(priv->zombie_rx_queues);
+	rte_free(priv->zombie_tx_queues);
+	priv->zombie_rx_queues = NULL;
+	priv->zombie_tx_queues = NULL;
+
 	gve_teardown_device_resources(priv);
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
 
@@ -1765,7 +1841,18 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 			    sizeof(struct gve_txq_config) * priv->max_nb_txq,
 			    RTE_CACHE_LINE_SIZE);
 
-	if (!priv->rxq_configs || !priv->txq_configs) {
+	priv->zombie_rx_queues =
+		rte_zmalloc("gve_zombie_rxqs",
+			    sizeof(struct gve_rx_queue *) * priv->max_nb_rxq,
+			    RTE_CACHE_LINE_SIZE);
+
+	priv->zombie_tx_queues =
+		rte_zmalloc("gve_zombie_txqs",
+			    sizeof(struct gve_tx_queue *) * priv->max_nb_txq,
+			    RTE_CACHE_LINE_SIZE);
+
+	if (!priv->rxq_configs || !priv->txq_configs ||
+	    !priv->zombie_rx_queues || !priv->zombie_tx_queues) {
 		err = -ENOMEM;
 		goto free_queue_configs;
 	}
@@ -1790,6 +1877,10 @@ free_flow_subsystem:
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
 free_queue_configs:
+	rte_free(priv->zombie_tx_queues);
+	priv->zombie_tx_queues = NULL;
+	rte_free(priv->zombie_rx_queues);
+	priv->zombie_rx_queues = NULL;
 	rte_free(priv->txq_configs);
 	priv->txq_configs = NULL;
 	rte_free(priv->rxq_configs);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 8df4fa54c..c56a8a693 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -39,6 +39,8 @@
 #define GVE_RX_MIN_BUF_SIZE_GQI		2048
 #define GVE_RX_MAX_BUF_SIZE_GQI		4096
 
+#define ZOMBIE_QUEUE_TTL_S		5
+
 #define GVE_RSS_HASH_KEY_SIZE 40
 #define GVE_RSS_INDIR_SIZE 128
 
@@ -199,6 +201,10 @@ struct gve_tx_queue {
 	struct gve_tx_queue *complq;
 
 	uint8_t is_gqi_qpl;
+
+	/* For handling deferred freeing after device reset */
+	struct gve_tx_queue *zombie_next;
+	uint64_t zombie_retire_time;
 };
 
 struct gve_rx_ctx {
@@ -262,6 +268,10 @@ struct gve_rx_queue {
 
 	uint8_t is_gqi_qpl;
 	bool timestamp_enabled;
+
+	/* For handling deferred freeing after device reset */
+	struct gve_rx_queue *zombie_next;
+	uint64_t zombie_retire_time;
 };
 
 struct gve_flow {
@@ -371,6 +381,10 @@ struct gve_priv {
 	struct gve_txq_config *txq_configs;
 	uint32_t reset_generation;
 
+	struct gve_rx_queue **zombie_rx_queues;
+	struct gve_tx_queue **zombie_tx_queues;
+	rte_spinlock_t zombie_lock;
+
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
 	rte_be32_t __iomem *db_bar; /* "array" of doorbells */
 	struct rte_pci_device *pci_dev;
@@ -645,6 +659,15 @@ gve_tx_queue_release_internal(struct gve_tx_queue *txq);
 void
 gve_tx_queue_release_internal_dqo(struct gve_tx_queue *txq);
 
+void
+gve_add_zombie_rx_queue(struct gve_priv *priv, struct gve_rx_queue *rxq);
+
+void
+gve_add_zombie_tx_queue(struct gve_priv *priv, struct gve_tx_queue *txq);
+
+void
+gve_clean_zombie_queues(struct gve_priv *priv, bool force);
+
 int
 gve_rx_queue_start_dqo(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 
-- 
2.56.0.307.g5fe7bd680c-goog

