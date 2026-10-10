Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F8CA9EBB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D7440697;
	Sat, 10 Oct 2026 03:00:05 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 679C240698
 for <dev@dpdk.org>; Sat, 10 Oct 2026 03:00:04 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e8621795e7so2439515ad.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791594003; x=1792198803; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BBJzztWCZuPhh+Lwi2G5KCDKU1uL1WJQxPkXaH4o3Wg=;
 b=V1R+ZVwP9Tic1otQruWHdIl22Nm20YwfitC/rhDesELshmTwIftsam+U45YWGvLwKF
 wacTAW3ifUryF+f5Tgref1D3UZM9i/XLMKhcmCkyPuA9JXyu4T5bobG7WvAWYKtPNYbC
 zOuw1Z1zpAtELjmlLGRhMsJC9LSLQKcRXpHBB0sT12//HPmxIs3VBdGtFJab42Lzy3db
 De4zUp1RXfFM0X+OONYQBCNynd/4H4jQ+J+YRMBCJ20KGHgLcsWuWhjj7E9BqbiGMTEt
 iRbZvuOFKqxf0n5ovMtPXNbVlfPm7Dyvqo75wxtihix/eIyHL9q0tV1W2faTzULKAclp
 Fbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791594003; x=1792198803;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BBJzztWCZuPhh+Lwi2G5KCDKU1uL1WJQxPkXaH4o3Wg=;
 b=t3NfRQ4i17AKycaioeZeOO/suLTArcm08NBNYwyHZhz85rIV5tJsB8eN7xLAUzt7bC
 lKZQjnrpWioX0X93TwdpJISh4uGuHMVXmoiyLQSRVCX8oRulxz2X4EmGk0zKAkDPDi4X
 m5rPHoRTNkH2QJ06cp6qtrYqpbYAFCBTmVR9cHJn9F0Ven4WEixIS2DrsF6pxKf/pnKf
 h1Egatu7djaLhUyCYQMxG2FFfsiry7Qwg8tlm3IQxR2UHF3es37NxPfBzBGqhaEgkrqj
 e2rky/7Jx4HSi1xHSmtEc0NYXLXHSeD4VuLAftPZUN5VYq84Ym362qJAv2gIsTzI6Nr8
 EcAA==
X-Gm-Message-State: AFq9FYKcxPCM6qk3nijdG4/VyMpPGik2bHni1kocCUzRyhf00cWgZzSs
 IHJNWV3rEhIFQzk6cn85SdupxMScM9NekjvRSdQvPX9hqW1lGo6/dK4a/Nz66jQBgyb9GZbiTW6
 11nykr6FqnWUoww==
X-Received: from plbbh1.prod.google.com ([2002:a17:902:a981:b0:2e2:f305:e980])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c3:b0:2e8:1361:e50c with SMTP id
 d9443c01a7336-2e8427f030amr33394465ad.4.1791594003341; 
 Fri, 09 Oct 2026 18:00:03 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:39 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-8-joshwash@google.com>
Subject: [PATCH v3 7/8] net/gve: add RSS cache boolean flag
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com
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
priv is the latest from the device or not.

This functionality is contingent on query support. If RSS queries are
supported, then when sending a control plane message to configure RSS,
the cache will be invalidated. Upon storing the latest configuration in
priv, the cache will be considered clean and ready to be read.

If RSS queries are not supported, as is the case for the current admin
queue implementation, the RSS cache is not cleared when sending a
configuration update to avoid causing the cache to become permanently
stale.

The RSS configuration should never be read if the cache is dirty.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
  - Avoid clearing the RSS cache, as the driver is the source of truth.
v2:
  - Remove -ENODATA return for Freebsd compatibility.
---
 drivers/net/gve/gve_ethdev.c | 81 +++++++++++++++++++++++++++++-------
 drivers/net/gve/gve_ethdev.h |  1 +
 drivers/net/gve/gve_rss.c    |  2 +
 3 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index d117b28dd0..31698bc38a 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -217,6 +217,32 @@ gve_teardown_queue_page_list(struct gve_priv *priv,
 	return 0;
 }
 
+static int
+gve_rss_update_cache(struct gve_priv *priv)
+{
+	struct gve_process_private *process_priv;
+
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
+	if (priv->rss_cache_dirty) {
+		int err;
+
+		if (process_priv->ctrl_ops->query_rss == NULL) {
+			PMD_DRV_LOG(ERR,
+				    "No RSS query functionality present in ops table");
+			return -ENOENT;
+		}
+
+		err = process_priv->ctrl_ops->query_rss(priv);
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
@@ -241,19 +267,25 @@ gve_dev_configure(struct rte_eth_dev *dev)
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
+		err = gve_rss_update_cache(priv);
+		if (err == 0) {
+			struct gve_rss_config update_reta_config;
 
-		err = process_priv->ctrl_ops->configure_rss(priv, &update_reta_config);
-		if (err)
-			PMD_DRV_LOG(ERR,
-				"Could not reconfigure RSS redirection table.");
+			gve_init_rss_config_from_priv(priv, &update_reta_config);
+			gve_generate_rss_reta(dev, &update_reta_config);
 
-		gve_free_rss_config(&update_reta_config);
-		return err;
+			err = process_priv->ctrl_ops->configure_rss(priv, &update_reta_config);
+			if (err)
+				PMD_DRV_LOG(ERR,
+					"Could not reconfigure RSS redirection table.");
+
+			gve_free_rss_config(&update_reta_config);
+			return err;
+		}
 	}
 
 	return 0;
@@ -1118,7 +1150,6 @@ gve_xstats_get_names(struct rte_eth_dev *dev,
 	return count;
 }
 
-
 static int
 gve_rss_hash_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
@@ -1169,6 +1200,10 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 	if (err)
 		return err;
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		goto err;
+
 	gve_rss_conf.alg = GVE_RSS_HASH_TOEPLITZ;
 	err = gve_update_rss_hash_types(priv, &gve_rss_conf, rss_conf);
 	if (err)
@@ -1196,6 +1231,7 @@ gve_rss_hash_conf_get(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
 	struct gve_priv *priv = dev->data->dev_private;
+	int err;
 
 	if (!(dev->data->dev_conf.rxmode.offloads &
 			RTE_ETH_RX_OFFLOAD_RSS_HASH)) {
@@ -1203,6 +1239,9 @@ gve_rss_hash_conf_get(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		return err;
 
 	gve_to_rte_rss_hf(priv->rss_config.hash_types, rss_conf);
 	rss_conf->rss_key_len = priv->rss_config.key_size;
@@ -1229,6 +1268,10 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 	int err;
 	int i;
 
+	err = gve_rss_update_cache(priv);
+	if (err)
+		return err;
+
 	/* RSS key must be set before the redirection table can be set. */
 	if (!priv->rss_config.key || priv->rss_config.key_size == 0) {
 		PMD_DRV_LOG(ERR, "RSS hash key msut be set before the "
@@ -1271,8 +1314,10 @@ static int
 gve_rss_reta_query(struct rte_eth_dev *dev,
 	struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	int table_id;
+	int err;
 	int i;
 
 	if (!(dev->data->dev_conf.rxmode.offloads &
@@ -1281,10 +1326,14 @@ gve_rss_reta_query(struct rte_eth_dev *dev,
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
+	if (process_priv->ctrl_ops->query_rss == NULL &&
+	    priv->rss_config.key == NULL) {
+		/* RSS key must be set before the redirection table can be queried. */
+		PMD_DRV_LOG(ERR, "RSS hash key must be set before the redirection table can be initialized.");
 		return -ENOTSUP;
 	}
 
@@ -1686,6 +1735,8 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		    priv->max_nb_txq, priv->max_nb_rxq);
 
 setup_device:
+	if (process_priv->ctrl_ops->query_rss != NULL)
+		priv->rss_cache_dirty = true;
 	if (priv->max_flow_rules) {
 		err = gve_setup_flow_subsystem(priv);
 		if (err)
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 5d4797bfd6..b6c06cd82d 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -395,6 +395,7 @@ struct gve_priv {
 	uint16_t stats_end_idx; /* end index of array of stats written by NIC */
 
 	struct gve_rss_config rss_config;
+	bool rss_cache_dirty;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Flow rule management */
diff --git a/drivers/net/gve/gve_rss.c b/drivers/net/gve/gve_rss.c
index 4084d7955f..691ec6dab1 100644
--- a/drivers/net/gve/gve_rss.c
+++ b/drivers/net/gve/gve_rss.c
@@ -119,6 +119,8 @@ gve_update_priv_rss_config(struct gve_priv *priv, struct gve_rss_config *config)
 	memcpy(priv_config->key, config->key,
 		config->key_size * sizeof(*priv_config->key));
 
+	priv->rss_cache_dirty = false;
+
 	return 0;
 }
 
-- 
2.56.0.170.g584c36229d-goog

