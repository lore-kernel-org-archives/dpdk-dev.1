Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CE606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J2B2YEjq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F09840656;
	Tue, 27 Oct 2026 19:56:23 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mails.dpdk.org (Postfix) with ESMTPS id DA52640679
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:56:21 +0100 (CET)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad3fc547bfso240853a91.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127380; x=1793732180; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ixv6fBauVU45ZtT4X7L1Cfkkewjs+vCZeyvbPUIM8k0=;
 b=J2B2YEjqMVLIU3djm9oboCEGW6rhVP0QWYHOad4HiFXrPJzbZ9n5t0AKR/WUJ21Ixl
 vdDjYblFb9wDBb6ImSuaFvSYfHLS3S1ZFVP6VSwVOgvHdED5f4hiJM1Bm3GxlaFU/vUp
 yu5R9TzLe1UA3znBbVpp2wTRMxWbksGwWVulbcBw9k2J5UoBgtGZvtUVwqhvBUZvHapT
 JVhaaIw03qtlfLn87huV7M9kQDyD0rnUMErtn35BWVR5RcV3ZIR+Axl9NzYsSLunC8Ed
 surVsmM01y7hNkiSQC0TVGEyvNqwNQlbWzyMT5Z74oGY2iMvRWZLna9rL6mblbJ6iY1E
 i+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127380; x=1793732180;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ixv6fBauVU45ZtT4X7L1Cfkkewjs+vCZeyvbPUIM8k0=;
 b=a59xp5XvYf21cYmhhNNYyvqgGzRuhhz/pr0SDS/MWvq2KkP0E7U0+4mVAFfczd1ElM
 5hdzBZIhLhQALRjtNGUoulPwoymAcwC9JJKH2wFhbZrWeuO76tQh8Wwi7AAWN+FunKY/
 6atuH2t8K4l9StOd2CphiH2K04D0C8tQdMjZZsYM0Jahu3qBgLFYd1AuWesvJZlS97wy
 WUsff76UwnGWA3JBTB5IuILOJU3G0ZWf7oEf1QTpJCPCgftGaxFIc8T9HbdUCFHGIwjf
 42B4VQ5U72L1fhs9JDsghU56bCy1/B6+KsF8BzfuK2D8NTmgK/l1zFd83D/eJh23l3UP
 lSGQ==
X-Gm-Message-State: AFq9FYIIHtc9IkGmBKwmowbKxIPSZWIYbyP5W/bWu/5Ir4v9GeQZJFCv
 DNkcFEeeBkfu4HyGhey5yD1AiVLyrLb+fxn8hzGBvgAysA+5ZiaU56c8bgkEzG5x6iz5F46uP0z
 v6xxKDNQe+Gmg+Xdc6G6ChMBjgZynBx1UBDajnoppzKi7feI6Z3Ff/OaINREEJfKKyDiz73xY4q
 fJeXofTlSPo6DUkAVX8taVyRA+AFqRLNOcm5xd5BU9R7YjtozuhA==
X-Received: from pjbpv16.prod.google.com ([2002:a17:90b:3c90:b0:3a8:1ac4:b8f])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b89:b0:3ad:eb15:aed9 with SMTP id
 98e67ed59e1d1-3ae57e2ef27mr979a91.9.1793127380041; 
 Tue, 27 Oct 2026 11:56:20 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:13 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-5-jtranoleary@google.com>
Subject: [PATCH 4/9] net/gve: separate device resource alloc and config
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

Separate gve_setup_device_resources into two distinct functions:
- gve_alloc_device_resources: allocates host DMA memory structures
  (counter array, IRQ doorbells, ptype LUT).
- gve_configure_device_resources: registers and configures those
  allocated resources with the device hardware.

Symmetrically, partition gve_teardown_device_resources into a function
for freeing memory and one for deconfiguring resources.

This clean separation allows device resources to be re-configured
with the hardware during device reset recovery without re-allocating
host memory.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 172 +++++++++++++++++-------------
 1 file changed, 97 insertions(+), 75 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 680fc9947..44810b864 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -742,15 +742,20 @@ gve_free_queues(struct rte_eth_dev *dev)
 static void
 gve_free_counter_array(struct gve_priv *priv)
 {
-	rte_memzone_free(priv->cnt_array_mz);
-	priv->cnt_array = NULL;
+	if (priv->cnt_array_mz) {
+		rte_memzone_free(priv->cnt_array_mz);
+		priv->cnt_array_mz = NULL;
+		priv->cnt_array = NULL;
+	}
 }
-
 static void
 gve_free_irq_db(struct gve_priv *priv)
 {
-	rte_memzone_free(priv->irq_dbs_mz);
-	priv->irq_dbs = NULL;
+	if (priv->irq_dbs_mz) {
+		rte_memzone_free(priv->irq_dbs_mz);
+		priv->irq_dbs_mz = NULL;
+		priv->irq_dbs = NULL;
+	}
 }
 
 static void
@@ -805,33 +810,38 @@ gve_teardown_flow_subsystem(struct gve_priv *priv)
 }
 
 static void
-gve_teardown_device_resources(struct gve_priv *priv)
+gve_free_device_resources(struct gve_priv *priv)
+{
+	gve_free_nic_ts_report(priv);
+	gve_free_ptype_lut_dqo(priv);
+	gve_free_counter_array(priv);
+	gve_free_irq_db(priv);
+	gve_free_rss_config(&priv->rss_config);
+}
+
+static void
+gve_deconfigure_device_resources(struct gve_priv *priv)
 {
 	struct gve_process_private *process_priv;
 	int err;
 
-	process_priv = rte_eth_devices[priv->port_id].process_private;
-
-	/* Tell device its resources are being freed */
-	if (gve_get_device_resources_ok(priv)) {
-		err = process_priv->ctrl_ops->free_db_resources(priv);
-		if (err)
-			PMD_DRV_LOG(ERR,
-				"Could not deconfigure device resources: err=%d",
-				err);
-	}
+	if (!gve_get_device_resources_ok(priv))
+		return;
 
 	if (priv->nic_ts_report_mz) {
 		rte_atomic_store_explicit(&priv->nic_ts_thread_should_stop, 1,
 					  rte_memory_order_relaxed);
 		rte_thread_join(priv->nic_ts_thread_id, NULL);
-		gve_free_nic_ts_report(priv);
 	}
 
-	gve_free_ptype_lut_dqo(priv);
-	gve_free_counter_array(priv);
-	gve_free_irq_db(priv);
-	gve_free_rss_config(&priv->rss_config);
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+	if (process_priv->ctrl_ops->free_db_resources) {
+		err = process_priv->ctrl_ops->free_db_resources(priv);
+		if (err)
+			PMD_DRV_LOG(ERR,
+				    "Could not deconfigure device resources: err=%d",
+				    err);
+	}
 	gve_clear_device_resources_ok(priv);
 }
 
@@ -864,8 +874,9 @@ gve_dev_close(struct rte_eth_dev *dev)
 	priv->zombie_rx_queues = NULL;
 	priv->zombie_tx_queues = NULL;
 
-	gve_teardown_device_resources(priv);
+	gve_deconfigure_device_resources(priv);
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
+	gve_free_device_resources(priv);
 
 	pthread_mutex_destroy(&priv->flow_rule_lock);
 	pthread_mutex_destroy(&priv->nic_ts_lock);
@@ -907,8 +918,9 @@ gve_dev_reset(struct rte_eth_dev *dev)
 	 * destroyed on dev_close.
 	 */
 	gve_free_queues(dev);
-	gve_teardown_device_resources(priv);
+	gve_deconfigure_device_resources(priv);
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
+	gve_free_device_resources(priv);
 
 	err = gve_init_priv(priv, true);
 	if (err != 0) {
@@ -1574,36 +1586,27 @@ gve_setup_nic_timestamp(struct gve_priv *priv)
 {
 	int err;
 
-	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
+	if (!priv->nic_ts_report_mz)
 		return;
 
 	rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&priv->nic_ts_stale, 1, rte_memory_order_relaxed);
-	err = gve_alloc_nic_ts_report(priv);
-	if (err == 0) {
-		gve_read_nic_clock(priv);
-		rte_atomic_store_explicit(&priv->nic_ts_thread_should_stop, 0,
-					  rte_memory_order_relaxed);
-		err = rte_thread_create_internal_control(&priv->nic_ts_thread_id, "gve-ts",
-							 gve_nic_ts_thread, priv);
-		if (err != 0) {
-			PMD_DRV_LOG(ERR, "Failed to create NIC clock sync thread, err=%d", err);
-			gve_free_nic_ts_report(priv);
-		}
-	} else {
-		PMD_DRV_LOG(ERR, "Failed to allocate memory for NIC timestamping subsystem. Please reset device to retry.");
+	gve_read_nic_clock(priv);
+	rte_atomic_store_explicit(&priv->nic_ts_thread_should_stop, 0,
+				  rte_memory_order_relaxed);
+	err = rte_thread_create_internal_control(&priv->nic_ts_thread_id, "gve-ts",
+						 gve_nic_ts_thread, priv);
+	if (err != 0) {
+		PMD_DRV_LOG(ERR, "Failed to create NIC clock sync thread, err=%d", err);
+		gve_free_nic_ts_report(priv);
 	}
 }
 
 static int
-gve_setup_device_resources(struct gve_priv *priv)
+gve_alloc_device_resources(struct gve_priv *priv)
 {
-	struct gve_process_private *process_priv;
 	char z_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
-	int err = 0;
-
-	process_priv = rte_eth_devices[priv->port_id].process_private;
 
 	snprintf(z_name, sizeof(z_name), "gve_%s_cnt_arr", priv->pci_dev->device.name);
 	mz = rte_memzone_reserve_aligned(z_name,
@@ -1619,34 +1622,56 @@ gve_setup_device_resources(struct gve_priv *priv)
 
 	snprintf(z_name, sizeof(z_name), "gve_%s_irqmz", priv->pci_dev->device.name);
 	mz = rte_memzone_reserve_aligned(z_name,
-					 sizeof(*priv->irq_dbs) * (priv->num_ntfy_blks),
+					 sizeof(*priv->irq_dbs) * priv->num_ntfy_blks,
 					 rte_socket_id(), RTE_MEMZONE_IOVA_CONTIG,
 					 PAGE_SIZE);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Could not alloc memzone for irq_dbs");
-		err = -ENOMEM;
-		goto free_cnt_array;
+		goto err_free;
 	}
 	priv->irq_dbs = (struct gve_irq_db *)mz->addr;
 	priv->irq_dbs_mz = mz;
 
-	err = process_priv->ctrl_ops->get_interrupt_dbs(priv);
-	if (unlikely(err)) {
-		PMD_DRV_LOG(ERR, "Could not config device resources: err=%d", err);
-		goto free_irq_dbs;
-	}
 	if (!gve_is_gqi(priv)) {
 		priv->ptype_lut_dqo = rte_zmalloc("gve_ptype_lut_dqo",
 			sizeof(struct gve_ptype_lut), 0);
 		if (priv->ptype_lut_dqo == NULL) {
 			PMD_DRV_LOG(ERR, "Failed to alloc ptype lut.");
-			err = -ENOMEM;
-			goto free_irq_dbs;
+			goto err_free;
 		}
+	}
+
+	if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED) {
+		if (gve_alloc_nic_ts_report(priv) != 0)
+			PMD_DRV_LOG(ERR, "Failed to allocate memory for NIC timestamping subsystem.");
+	}
+
+	return 0;
+
+err_free:
+	gve_free_device_resources(priv);
+	return -ENOMEM;
+}
+
+static int
+gve_configure_device_resources(struct gve_priv *priv)
+{
+	struct gve_process_private *process_priv;
+	int err;
+
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
+	err = process_priv->ctrl_ops->get_interrupt_dbs(priv);
+	if (unlikely(err)) {
+		PMD_DRV_LOG(ERR, "Could not config device resources: err=%d", err);
+		return err;
+	}
+
+	if (!gve_is_gqi(priv)) {
 		err = process_priv->ctrl_ops->get_ptype_map(priv);
 		if (unlikely(err)) {
 			PMD_DRV_LOG(ERR, "Failed to get ptype map: err=%d", err);
-			goto free_ptype_lut;
+			return err;
 		}
 	}
 	gve_setup_nic_timestamp(priv);
@@ -1654,15 +1679,6 @@ gve_setup_device_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 
 	return 0;
-free_ptype_lut:
-	rte_free(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-free_irq_dbs:
-	gve_free_irq_db(priv);
-free_cnt_array:
-	gve_free_counter_array(priv);
-
-	return err;
 }
 
 static void
@@ -1797,19 +1813,19 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	err = process_priv->ctrl_ops->get_device_properties(priv);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Could not get device information: err=%d", err);
-		goto free_adminq;
+		goto free_ctrl_plane;
 	}
 
 	num_ntfy = pci_dev_msix_vec_count(priv->pci_dev);
 	if (num_ntfy <= 0) {
 		PMD_DRV_LOG(ERR, "Could not count MSI-x vectors");
 		err = -EIO;
-		goto free_adminq;
+		goto free_ctrl_plane;
 	} else if (num_ntfy < GVE_MIN_MSIX) {
 		PMD_DRV_LOG(ERR, "GVE needs at least %d MSI-x vectors, but only has %d",
 			    GVE_MIN_MSIX, num_ntfy);
 		err = -EINVAL;
-		goto free_adminq;
+		goto free_ctrl_plane;
 	}
 
 	priv->num_registered_pages = 0;
@@ -1867,8 +1883,11 @@ setup_device:
 				    "Failed to set up flow subsystem: err=%d, flow steering will be disabled.",
 				    err);
 	}
+	err = gve_alloc_device_resources(priv);
+	if (err)
+		goto free_flow_subsystem;
 
-	err = gve_setup_device_resources(priv);
+	err = gve_configure_device_resources(priv);
 	if (err)
 		goto free_flow_subsystem;
 
@@ -1877,16 +1896,19 @@ free_flow_subsystem:
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
 free_queue_configs:
-	rte_free(priv->zombie_tx_queues);
-	priv->zombie_tx_queues = NULL;
-	rte_free(priv->zombie_rx_queues);
-	priv->zombie_rx_queues = NULL;
-	rte_free(priv->txq_configs);
-	priv->txq_configs = NULL;
-	rte_free(priv->rxq_configs);
-	priv->rxq_configs = NULL;
-free_adminq:
+	if (!skip_describe_device) {
+		rte_free(priv->zombie_tx_queues);
+		priv->zombie_tx_queues = NULL;
+		rte_free(priv->zombie_rx_queues);
+		priv->zombie_rx_queues = NULL;
+		rte_free(priv->txq_configs);
+		priv->txq_configs = NULL;
+		rte_free(priv->rxq_configs);
+		priv->rxq_configs = NULL;
+	}
+free_ctrl_plane:
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
+	gve_free_device_resources(priv);
 	return err;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

