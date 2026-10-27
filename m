Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182B606A323
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JeIGvEjO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E4A40613;
	Tue, 27 Oct 2026 19:58:24 +0100 (CET)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mails.dpdk.org (Postfix) with ESMTPS id 603B1400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:58:23 +0100 (CET)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so159682a91.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127502; x=1793732302; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FCQ8/kFxTFnnvGx0ZriExN0mNVdrwBp/Fojef2YRiP8=;
 b=JeIGvEjOoijspxMVjm0iud7MxZZUrNm2gkyUoNNqDVr1Yo1P2dqlLQRq4ic84tJZtf
 zQSq45Eo6VXh/PzautSGhjpkNtZu2FRY14QVFNSStGlQpBakuWnWLomTtaoFLfLBiMbR
 ibNKPyFYUUczu7UYMSPtvvb6SwM1vTy/0nu7aneXWLLtSyHXsxL6OygAQYpSoAP8JiZh
 1W1Ut5ow9CxUXNFEe4Z8GTorswGcu2xS4ivdRFjKceeRYa2M2CTkURq7X+tCCPkSQ3IS
 cIYg/7Aqe1a6lVtewg1rq5eGQegjTKYKHJFNWp9vtcD6QiPOJQlnnruYpyqESexD5pQX
 Uk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127502; x=1793732302;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FCQ8/kFxTFnnvGx0ZriExN0mNVdrwBp/Fojef2YRiP8=;
 b=ex9HriId9vRFE1YMVD0gMSmDPxbKHaz+Oh9y0eScfBNolXOgQ2/4NrhQ6RVTYXuSHk
 3M5BSWZ6iSZbEiCp7ABc1WnNGw9pA4lNfrvZkcFc4eW/KOsSUNWdEwkzObyF7vNh/6lg
 uj6BwWiRsEJvPywvbbRtg0Fqaf4ftE0nKTf9S/NEUh7IQnADws3y/IV886rIZVdKk6OE
 6eU2mr9BjNcl2cNWILSaAiWcF7IDx/RohHbuPehiqdPF/GbWpuIQOD3HvBsiF5ooJR5L
 bRJKQ6lhVAgzn9W6YXLZ+zBTfxRlFERAFid7bQMnenmRFMRF5afM7Oosyx+obufrL9BK
 2x0w==
X-Gm-Message-State: AFq9FYKRFhXnQMSmSkukoKFIFGkLTpJhJZJLid9k2wtMTvWA5FrxLiZM
 fGeunXJgZv1phGQz7xHJHufQSEcOsQYkmSvib/VuD2hPtUIcxAxNtlibEbgPSbOpBdnPK9KpgQR
 1Ft5JMePMVtF4uC+vXIs55o3LLHm37s3RgZUkcG2fl/+jYLOy1jUhc1Eh5x7QcuREFtfjxkPN4w
 +EuaEgrsTlCtqdedUCg/UN9X2aDFUd+H7a1pfKZ0jjq4m8UXAcIA==
X-Received: from pjdw9.prod.google.com ([2002:a17:90a:15c9:b0:3ac:a379:dc7c])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c12:b0:3ac:6e91:3f22 with SMTP id
 98e67ed59e1d1-3adeafca234mr7439642a91.52.1793127501385; 
 Tue, 27 Oct 2026 11:58:21 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:17 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-9-jtranoleary@google.com>
Subject: [PATCH 8/9] net/gve: remove unused device reset parameter
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

With proactive device reset introduced, gve_init_priv is now only called
during initial device probe with skip_describe_device set to false.
Remove the unused skip_describe_device parameter and its associated
conditional branches.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 66a77c123..c2cfd18dc 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1973,7 +1973,7 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 };
 
 static int
-gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+gve_init_priv(struct gve_priv *priv)
 {
 	struct gve_process_private *process_priv;
 	int num_ntfy;
@@ -1987,9 +1987,6 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		return err;
 	}
 
-	if (skip_describe_device)
-		goto setup_device;
-
 	/* Set default descriptor counts */
 	gve_set_default_ring_size_bounds(priv);
 
@@ -2057,7 +2054,6 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		goto free_queue_configs;
 	}
 
-setup_device:
 	if (process_priv->ctrl_ops->query_rss != NULL)
 		priv->rss_cache_dirty = true;
 	if (priv->max_flow_rules) {
@@ -2080,16 +2076,14 @@ free_flow_subsystem:
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
 free_queue_configs:
-	if (!skip_describe_device) {
-		rte_free(priv->zombie_tx_queues);
-		priv->zombie_tx_queues = NULL;
-		rte_free(priv->zombie_rx_queues);
-		priv->zombie_rx_queues = NULL;
-		rte_free(priv->txq_configs);
-		priv->txq_configs = NULL;
-		rte_free(priv->rxq_configs);
-		priv->rxq_configs = NULL;
-	}
+	rte_free(priv->zombie_tx_queues);
+	priv->zombie_tx_queues = NULL;
+	rte_free(priv->zombie_rx_queues);
+	priv->zombie_rx_queues = NULL;
+	rte_free(priv->txq_configs);
+	priv->txq_configs = NULL;
+	rte_free(priv->rxq_configs);
+	priv->rxq_configs = NULL;
 free_ctrl_plane:
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
 	gve_free_device_resources(priv);
@@ -2164,7 +2158,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	pthread_mutexattr_destroy(&mutexattr);
 
 	priv->mbuf_timestamp_offset = -1;
-	err = gve_init_priv(priv, false);
+	err = gve_init_priv(priv);
 	if (err) {
 		pthread_mutex_destroy(&priv->flow_rule_lock);
 		pthread_mutex_destroy(&priv->nic_ts_lock);
-- 
2.56.0.307.g5fe7bd680c-goog

