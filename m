Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED94CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1BEB40E22;
	Mon,  5 Oct 2026 21:40:13 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id BBC8C40E1C
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:12 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e2d3a3ff86so29677915ad.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229212; x=1791834012; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r1X/P3A0kuKidXWopfxWPucHm5BfO/XgbnxjdtktLrU=;
 b=JbMHjIlpmqpBD0Kcj8Ea634Hjc1qbXd2hBrapSt79Dp1t0KM1qhJhBI9r17RCH4HOF
 +MRywBSWTzpPmWymLx7z0KiQDAhxP1bTh7RLPMXsqs3fvA92nEHITykZI/e/2oPbtllq
 kogbnUwaSB5NEdnYy3BbXN6bo6N7QbECilbKKTt+ZP0i990SdjyAUuzu14pZiMACgAhT
 nMuLhbNUo6nJFqZZU+TuIEEboTKnqLVYi+CFQh9OLjwbUPq5Ugl/EtKW1QC5uUcWhvYE
 3paPJ5WO79MzR4kJvEEfOUdDSrBHHq7g65/iPHVROL9FhbSwgACeUwTtRRxxoesPjfOU
 cY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229212; x=1791834012;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r1X/P3A0kuKidXWopfxWPucHm5BfO/XgbnxjdtktLrU=;
 b=hGjgE+qItOWYgnvptXZRY5rNbN0dn2JvZnGgKRKJYZNV8VmpG9kEBYmscYBBgOPZfh
 vQwVkIL6sonoTcYc8QGTRKH3B7FfvgntULyrvv43OwOy1+hNo/UmUXtqIYFe3GSRzKER
 oghuGle3VD39P8+1ZBi6Z3YkwPmAH4GmPEC1gXYRYBf8kAm91OkY8emTcIMVFwGPnVyP
 83ilUddoK+HbOaJU+1XxnvVJcJg420uX7+rRL6pLCOTN/u0RbCOelSVgK1xmlDzz2P/u
 fUk9K/stkhZmV4ETN0wC3ImbX48hiS/BYrii+3OuoGmE4vCpb0531fQTFKlU6M/TNfKA
 yFbQ==
X-Gm-Message-State: AFq9FYIPpNXd1D6ei/paKL0IBF08So3zrkT29krgkHEKVc/UW9a5drPD
 4Y5j3Jf75vQsjWCeH4jdjey3WPV8PuZo/X6S/qZ0/So1TbBGaV3q9hpkx3k94/KkNSFHafwZhxi
 HoJQbnlhqVNYt4g==
X-Received: from plxq13.prod.google.com ([2002:a17:902:dacd:b0:2e4:b726:a820])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1c2:b0:2e2:d64f:1a59 with SMTP id
 d9443c01a7336-2e49b67da45mr109469405ad.36.1791229211630; 
 Mon, 05 Oct 2026 12:40:11 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:37 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-7-joshwash@google.com>
Subject: [PATCH v2 6/8] net/gve: add RSS cache boolean flag
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
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

Introduce a flag that determines whether the RSS configuration stored in
priv is the latest from the device or not. When sending a control plane
message to configure RSS, the cache will be invalidated. Upon storing
the latest configuration in priv, the cache will be considered clean and
ready to be read.

The RSS configuration should never be read if the cache is dirty.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
v2:
- Remove -ENODATA return for Freebsd compatibility.
---
 drivers/net/gve/base/gve_adminq.c |  1 +
 drivers/net/gve/gve_ethdev.c      | 76 ++++++++++++++++++++++++-------
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_rss.c         |  2 +
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index db3e43c6b0..60e8544ef4 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -1278,6 +1278,7 @@ int gve_adminq_configure_rss(struct gve_priv *priv,
 	};
 
 	err = gve_adminq_execute_cmd(priv, &cmd);
+	priv->rss_cache_dirty = true;
 	if (err == 0)
 		gve_update_priv_rss_config(priv, rss_config);
 
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 49604f9362..22f7d30a6a 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -210,6 +210,28 @@ gve_teardown_queue_page_list(struct gve_priv *priv,
 	return 0;
 }
 
+static int
+gve_rss_update_cache(struct gve_priv *priv)
+{
+	if (priv->rss_cache_dirty) {
+		int err;
+
+		if (priv->ctrl_ops->query_rss == NULL) {
+			PMD_DRV_LOG(ERR,
+				    "No RSS query functionality present in ops table");
+			return -ENOENT;
+		}
+
+		err = priv->ctrl_ops->query_rss(priv);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to query device for RSS info.");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int
 gve_dev_configure(struct rte_eth_dev *dev)
 {
@@ -233,19 +255,24 @@ gve_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
-	/* Reset RSS RETA in case number of queues changed. */
+	/* Reset RSS RETA in case number of queues changed, but don't fail
+	 * configure if the cache cannot be updated.
+	 */
 	if (priv->rss_config.indir) {
-		struct gve_rss_config update_reta_config;
-		gve_init_rss_config_from_priv(priv, &update_reta_config);
-		gve_generate_rss_reta(dev, &update_reta_config);
-
-		err = priv->ctrl_ops->configure_rss(priv, &update_reta_config);
-		if (err)
-			PMD_DRV_LOG(ERR,
-				"Could not reconfigure RSS redirection table.");
+		err = gve_rss_update_cache(priv);
+		if (err == 0) {
+			struct gve_rss_config update_reta_config;
+			gve_init_rss_config_from_priv(priv, &update_reta_config);
+			gve_generate_rss_reta(dev, &update_reta_config);
+
+			err = priv->ctrl_ops->configure_rss(priv, &update_reta_config);
+			if (err)
+				PMD_DRV_LOG(ERR,
+					"Could not reconfigure RSS redirection table.");
 
-		gve_free_rss_config(&update_reta_config);
-		return err;
+			gve_free_rss_config(&update_reta_config);
+			return err;
+		}
 	}
 
 	return 0;
@@ -1093,7 +1120,6 @@ gve_xstats_get_names(struct rte_eth_dev *dev,
 	return count;
 }
 
-
 static int
 gve_rss_hash_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
@@ -1143,6 +1169,10 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 	if (err)
 		return err;
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		goto err;
+
 	gve_rss_conf.alg = GVE_RSS_HASH_TOEPLITZ;
 	err = gve_update_rss_hash_types(priv, &gve_rss_conf, rss_conf);
 	if (err)
@@ -1170,6 +1200,7 @@ gve_rss_hash_conf_get(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
 	struct gve_priv *priv = dev->data->dev_private;
+	int err;
 
 	if (!(dev->data->dev_conf.rxmode.offloads &
 			RTE_ETH_RX_OFFLOAD_RSS_HASH)) {
@@ -1177,6 +1208,9 @@ gve_rss_hash_conf_get(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		return err;
 
 	gve_to_rte_rss_hf(priv->rss_config.hash_types, rss_conf);
 	rss_conf->rss_key_len = priv->rss_config.key_size;
@@ -1202,6 +1236,10 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 	int err;
 	int i;
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		return err;
+
 	/* RSS key must be set before the redirection table can be set. */
 	if (!priv->rss_config.key || priv->rss_config.key_size == 0) {
 		PMD_DRV_LOG(ERR, "RSS hash key msut be set before the "
@@ -1246,6 +1284,7 @@ gve_rss_reta_query(struct rte_eth_dev *dev,
 {
 	struct gve_priv *priv = dev->data->dev_private;
 	int table_id;
+	int err;
 	int i;
 
 	if (!(dev->data->dev_conf.rxmode.offloads &
@@ -1254,10 +1293,13 @@ gve_rss_reta_query(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
-	/* RSS key must be set before the redirection table can be queried. */
-	if (!priv->rss_config.key) {
-		PMD_DRV_LOG(ERR, "RSS hash key must be set before the "
-			"redirection table can be initialized.");
+	err = gve_rss_update_cache(priv);
+	if (err != 0)
+		return err;
+
+	if (priv->ctrl_ops->query_rss == NULL && priv->rss_config.key == NULL) {
+		/* RSS key must be set before the redirection table can be queried. */
+		PMD_DRV_LOG(ERR, "RSS hash key must be set before the redirection table can be initialized.");
 		return -ENOTSUP;
 	}
 
@@ -1655,6 +1697,8 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		    priv->max_nb_txq, priv->max_nb_rxq);
 
 setup_device:
+	if (priv->ctrl_ops->query_rss != NULL)
+		priv->rss_cache_dirty = true;
 	if (priv->max_flow_rules) {
 		err = gve_setup_flow_subsystem(priv);
 		if (err)
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 9d8939da33..ef93db0c1d 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -399,6 +399,7 @@ struct gve_priv {
 	uint16_t stats_end_idx; /* end index of array of stats written by NIC */
 
 	struct gve_rss_config rss_config;
+	bool rss_cache_dirty;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Flow rule management */
diff --git a/drivers/net/gve/gve_rss.c b/drivers/net/gve/gve_rss.c
index 67b910ed22..5cd65f2df9 100644
--- a/drivers/net/gve/gve_rss.c
+++ b/drivers/net/gve/gve_rss.c
@@ -120,6 +120,8 @@ gve_update_priv_rss_config(struct gve_priv *priv, struct gve_rss_config *config)
 	memcpy(priv_config->key, config->key,
 		config->key_size * sizeof(*priv_config->key));
 
+	priv->rss_cache_dirty = false;
+
 	return 0;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

