Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86436CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ED3442EBA;
	Sat,  3 Oct 2026 04:51:58 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 3536242EB6
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:57 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e2f3251e91so448515ad.1
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995916; x=1791600716; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jUiBDLn5w8uazzUQ82YOFW5A1uPWQOGJX1n0GhKdSyY=;
 b=L7dcBZYbANaaCBmkclDZAduUD4xdIPsnTeDf0Nvruw+QEB7Kba+rES5TloJj4QfIUl
 SBFM4CeVIdLhs49FwGRNli2srr+Wz3ro/Drsv55c30kGJRnqoOhkCLMH7kQdr+3w3JmW
 qQEztqius6Cro8tizvuYcj6V5CF9RcpKos0e+eWOdZZyUGFcY8POCeijaJ0JisaR2SvS
 hrJw+qlvF+Eg2mt90CH+6l9RxfW+I5OQzVZvCEq3tNwpZgFOHUWzSsbEyeCKmKB96lWC
 NT6oSLPzY55s6o0n4m4o40Dun0rbEsF165Uk3LAaNn0LkGv2M9ko+xjZWVsuwSYOT7qW
 Id0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995916; x=1791600716;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jUiBDLn5w8uazzUQ82YOFW5A1uPWQOGJX1n0GhKdSyY=;
 b=GW35Ta9ei1hwxO+y6SMbVd+p9MOFWt4Q3dT9aOznBmpNRGAzXOb3pAXODICoXX5b/1
 BFUYS0R/fi9Y+a6RSWS6QqrEzYtdzcSHZPqcYKfzX7ZEdHT6+CmcWI6OjfhvAGfFxTFb
 QrXjhBF4b77c21SOSXINBVlvaDKOGIKa4TfPeH61kgXMmthzMumbM5Ztal/BBmn/N2XT
 J8Dz/hiSD06Z8ijnOlrDrRIvUE7uOvkIHADi2lC/zaaLwFAIQk5edyuobrsQZR9izJnm
 cqJbZcZ5XBejxRAQ65/rllSBLziOHEcDYG6e+hEpj/+uYu27OS5m+lhJUf5xVOiultJ2
 +05A==
X-Gm-Message-State: AFq9FYLGCmhHxDJlXMrGZc0KUiKxpzx73Y3EDdnWSkIDVEg0NafX438R
 K1XDGrGGEeKdVP+gFAzzSPraP3QAHbkNhRMJaOReE26DrAdnnMCAbx2dDd65Ka4wi1UGxRlEb++
 Pw/DimQiOG8t83A==
X-Received: from pldv2.prod.google.com ([2002:a17:902:ca82:b0:2e1:32ec:8412])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32cb:b0:2e2:ffcb:87a8 with SMTP id
 d9443c01a7336-2e49b6069abmr41407655ad.10.1790995916038; 
 Fri, 02 Oct 2026 19:51:56 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:38 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-7-joshwash@google.com>
Subject: [PATCH 6/8] net/gve: add RSS cache boolean flag
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
 drivers/net/gve/base/gve_adminq.c |  1 +
 drivers/net/gve/gve_ethdev.c      | 75 ++++++++++++++++++++++++-------
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_rss.c         |  2 +
 4 files changed, 63 insertions(+), 16 deletions(-)

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
index 49604f9362..fd77b5928a 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -210,6 +210,27 @@ gve_teardown_queue_page_list(struct gve_priv *priv,
 	return 0;
 }
 
+static int
+gve_rss_update_cache(struct gve_priv *priv)
+{
+	if (priv->rss_cache_dirty) {
+		if (priv->ctrl_ops->query_rss == NULL) {
+			PMD_DRV_LOG(ERR,
+				    "No RSS query functionality present in ops table");
+			return -ENOENT;
+		}
+
+		priv->ctrl_ops->query_rss(priv);
+		if (priv->rss_cache_dirty) {
+			PMD_DRV_LOG(ERR,
+				    "RSS cache not updated after querying device.");
+			return -ENODATA;
+		}
+	}
+
+	return 0;
+}
+
 static int
 gve_dev_configure(struct rte_eth_dev *dev)
 {
@@ -233,19 +254,24 @@ gve_dev_configure(struct rte_eth_dev *dev)
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
@@ -1093,7 +1119,6 @@ gve_xstats_get_names(struct rte_eth_dev *dev,
 	return count;
 }
 
-
 static int
 gve_rss_hash_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
@@ -1143,6 +1168,10 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 	if (err)
 		return err;
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		goto err;
+
 	gve_rss_conf.alg = GVE_RSS_HASH_TOEPLITZ;
 	err = gve_update_rss_hash_types(priv, &gve_rss_conf, rss_conf);
 	if (err)
@@ -1170,6 +1199,7 @@ gve_rss_hash_conf_get(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
 	struct gve_priv *priv = dev->data->dev_private;
+	int err;
 
 	if (!(dev->data->dev_conf.rxmode.offloads &
 			RTE_ETH_RX_OFFLOAD_RSS_HASH)) {
@@ -1177,6 +1207,9 @@ gve_rss_hash_conf_get(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		return err;
 
 	gve_to_rte_rss_hf(priv->rss_config.hash_types, rss_conf);
 	rss_conf->rss_key_len = priv->rss_config.key_size;
@@ -1202,6 +1235,10 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 	int err;
 	int i;
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		return err;
+
 	/* RSS key must be set before the redirection table can be set. */
 	if (!priv->rss_config.key || priv->rss_config.key_size == 0) {
 		PMD_DRV_LOG(ERR, "RSS hash key msut be set before the "
@@ -1246,6 +1283,7 @@ gve_rss_reta_query(struct rte_eth_dev *dev,
 {
 	struct gve_priv *priv = dev->data->dev_private;
 	int table_id;
+	int err;
 	int i;
 
 	if (!(dev->data->dev_conf.rxmode.offloads &
@@ -1254,10 +1292,13 @@ gve_rss_reta_query(struct rte_eth_dev *dev,
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
 
@@ -1655,6 +1696,8 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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

