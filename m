Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE51606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIW1Qw/N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5C8B40151;
	Tue, 27 Oct 2026 19:58:18 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mails.dpdk.org (Postfix) with ESMTPS id 3E667400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:58:17 +0100 (CET)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so995815ad.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127496; x=1793732296; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CjYX37QY+qDSutYwlZKxasHeAyFpDVQIRVWewXZS31c=;
 b=LIW1Qw/N+o0gk7jEuaIZq5lokJuxbLnkkIe9YqJOjaSwbr83Qe3oUy7Vo0SA335ECg
 Ja1L3m0Lx5qhh4unEICKLlAnkZ/T6obDJCCmgfDfwHtHPj2V+Zi6P4puR7gvfvv+qwLk
 bveURsblVLPosPqcvQ1LOjGfjWiCi7ZSuvG/z2p2bSC323W+yWz7A1iIKC4mqxMm3502
 9UmcyMZ915QNXtIg3ZoQk+cQogRo3YkrgR/T4dGhwMitOgJBPxUaEHtFuXMQQ/h7Nbw/
 i8aioIR0gpYIHjMfRUuX7WqP4GlUWe59K3vUsjtj2jJSQsyvRW7/SRXnqfC0K/RFFnTV
 vpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127496; x=1793732296;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CjYX37QY+qDSutYwlZKxasHeAyFpDVQIRVWewXZS31c=;
 b=TSObw37T3njrAQgtq/E3eMRPJzfKFMrc7IbQAYlA9QncR04S0Ys9ogBm/hwCmrfoIa
 +NwC7z6FBXVAwm2HvRQUQKTOZgHhvcHDp9agbsQyHrLPw6idbsU/F8PBhdfPAaaWEZwG
 8XMvKCML4CW6GN9macBTobNOSEaXTkyJVD21fUUYkoJRn3NYVPYEQFIsdfjF+weo5KvL
 bwaZT8YnEFeyIuSTIqdJeuZbKWtY8QdXf45DCYuqczAleoJP6b5avD7gRJlZ0NYde/es
 YKvsCKo5LrQVwdGGIIvTHvR8KkKoZ05und9bABTVMBNw9TNZxKZPy9j0fJQejQm7gXdI
 2iLg==
X-Gm-Message-State: AFq9FYK94X3UvWDNIUfeouRL4Mud365ZuJih4F5Dx+xnYS03LPjL8IHY
 iS8iqxITC6/sgKrZENIDsziCQhKd5I41MDWHJvB4lAXhNGMYebtY7li2z267va3D8nho63UGJUg
 wE3GNR9xbm4fmR2ysVD+cUexB+QxaVNQKBDdKuiqI2xY0N03gQ8U0pQXto3onaWzLe+5k8cY4Pc
 p1Rp6LiKFxT/JiR/WuNESpA4yeNyqem0ohbtPojwPbArmi5bBCAg==
X-Received: from plv18.prod.google.com ([2002:a17:903:bd2:b0:2e4:b784:a1a5])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef06:b0:2e8:c3e1:e1e with SMTP id
 d9443c01a7336-2eb00530368mr2230725ad.52.1793127495268; 
 Tue, 27 Oct 2026 11:58:15 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:16 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-8-jtranoleary@google.com>
Subject: [PATCH 7/9] net/gve: implement proactive device reset
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>
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

Report RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE in device info and monitor
for device reset requests during periodic status polling. When a reset
is detected, spawn a dedicated control recovery thread to re-establish
the control plane, re-create queues from saved configurations, redirect
the fast-path operations table to prevent concurrent crashes, and emit
proactive recovery DPDK lifecycle events (ERR_RECOVERING,
RECOVERY_SUCCESS, RECOVERY_FAILED).

Proactive device reset supercedes the previously implemented passive
device reset convention for the gve driver.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 doc/guides/nics/gve.rst                |  67 ++--
 doc/guides/rel_notes/release_26_11.rst |   5 +
 drivers/net/gve/gve_ethdev.c           | 384 ++++++++++++++------
 3 files changed, 321 insertions(+), 135 deletions(-)

diff --git a/doc/guides/nics/gve.rst b/doc/guides/nics/gve.rst
index c5e9ab70d..1b7a72cf1 100644
--- a/doc/guides/nics/gve.rst
+++ b/doc/guides/nics/gve.rst
@@ -153,37 +153,60 @@ require the DQO queue format.
 Device Reset
 ^^^^^^^^^^^^
 
-The driver allows an application to reset the gVNIC device.
-This function will tear down and reinitialize the device's resources,
-including queues and administrative queues.
-
-It is the application's responsibility to reinitialize
-and restart the device after resetting it.
-
-In addition, the driver supports device-requested resets, which are triggered
-when the device encounters an unrecoverable error. The driver detects this via
-a device status register and raises an ``RTE_ETH_EVENT_INTR_RESET`` event.
-
-The application must register a callback to handle this event. The callback
-should handle the reset process (reset, reconfigure, restart).
+The driver supports proactive error recovery
+(``RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE``)
+for both device-requested resets and application-initiated resets
+via ``rte_eth_dev_reset()``.
+
+A background control thread periodically polls the device status register
+to detect when the device requests a reset.
+When a reset is triggered, the driver automatically recovers the port
+without requiring the application to reconfigure or restart the device:
+
+- Emits ``RTE_ETH_EVENT_ERR_RECOVERING`` and redirects Rx/Tx burst functions
+  to dummy handlers so concurrent datapath threads can continue polling safely.
+- Tears down and re-initializes the control plane,
+  re-registers device resources,
+  and recreates Rx and Tx queues from their saved configurations.
+- Restarts the device (if it was previously started),
+  restores the active Rx/Tx burst functions,
+  and emits ``RTE_ETH_EVENT_RECOVERY_SUCCESS``
+  (or ``RTE_ETH_EVENT_RECOVERY_FAILED`` if recovery fails).
+
+Applications do not need to call ``rte_eth_dev_reset()`` in response to a
+device-requested reset,
+but may optionally register callbacks for the recovery lifecycle events
+to monitor reset progress or handle unrecoverable failures:
 
 .. code-block:: c
 
    static int
-   dev_rst_req_callback(uint16_t port_id, enum rte_eth_event_type type,
-                        void *param, void *ret_param)
+   dev_recovery_callback(uint16_t port_id, enum rte_eth_event_type type,
+                         void *param, void *ret_param)
    {
        RTE_SET_USED(param);
        RTE_SET_USED(ret_param);
 
-       if (type == RTE_ETH_EVENT_INTR_RESET) {
-           printf("Device requested reset on port %u\n", port_id);
-           rte_eth_dev_reset(port_id);
-           /* Reconfigure and restart port ... */
+       switch (type) {
+       case RTE_ETH_EVENT_ERR_RECOVERING:
+           printf("Port %u: entering recovery\n", port_id);
+           break;
+       case RTE_ETH_EVENT_RECOVERY_SUCCESS:
+           printf("Port %u: recovery succeeded\n", port_id);
+           break;
+       case RTE_ETH_EVENT_RECOVERY_FAILED:
+           printf("Port %u: recovery failed\n", port_id);
+           break;
+       default:
+           break;
        }
        return 0;
    }
 
-   /* Register this callback in the main execution flow */
-   rte_eth_dev_callback_register(port_id, RTE_ETH_EVENT_INTR_RESET,
-                     dev_rst_req_callback, NULL);
+   /* Optionally register callbacks in the main execution flow */
+   rte_eth_dev_callback_register(port_id, RTE_ETH_EVENT_ERR_RECOVERING,
+                                 dev_recovery_callback, NULL);
+   rte_eth_dev_callback_register(port_id, RTE_ETH_EVENT_RECOVERY_SUCCESS,
+                                 dev_recovery_callback, NULL);
+   rte_eth_dev_callback_register(port_id, RTE_ETH_EVENT_RECOVERY_FAILED,
+                                 dev_recovery_callback, NULL);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c62d9e897..abaad4677 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -146,6 +146,11 @@ New Features
   * Raised the maximum Tx and Rx ring descriptor counts
     from 4096/8192 to 16384 each.
 
+* **Updated Google Virtual Ethernet (gve) ethernet driver.**
+
+  * Added support for proactive device reset recovery
+    (``RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE``).
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index cfd043dbf..66a77c123 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -13,7 +13,6 @@
 #include <ethdev_driver.h>
 #include <rte_cycles.h>
 
-static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device);
 static void gve_start_dev_status_polling(struct rte_eth_dev *dev);
 static void gve_stop_dev_status_polling(struct rte_eth_dev *dev);
 
@@ -907,50 +906,6 @@ gve_dev_close(struct rte_eth_dev *dev)
 	return err;
 }
 
-static int
-gve_dev_reset(struct rte_eth_dev *dev)
-{
-	struct gve_process_private *process_priv = dev->process_private;
-	struct gve_priv *priv = dev->data->dev_private;
-	int err;
-
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
-		PMD_DRV_LOG(ERR,
-			"Device reset on port %u not supported in secondary processes.",
-			dev->data->port_id);
-		return -EPERM;
-	}
-
-	pthread_mutex_lock(&priv->reset_lock);
-
-	/* Tear down all device resources before re-initializing. */
-	if (gve_get_flow_subsystem_ok(priv))
-		gve_teardown_flow_subsystem(priv);
-
-	/*
-	 * Note that gve_teardown_flow_subsystem does not destroy the
-	 * flow_rule_lock. The lock is preserved across device resets and only
-	 * destroyed on dev_close.
-	 */
-	gve_free_queues(dev);
-	gve_deconfigure_device_resources(priv);
-	process_priv->ctrl_ops->free_ctrl_plane(priv);
-	gve_free_device_resources(priv);
-
-	err = gve_init_priv(priv, true);
-	if (err != 0) {
-		PMD_DRV_LOG(ERR,
-			"Failed to re-init device on port %u after reset.",
-			dev->data->port_id);
-		pthread_mutex_unlock(&priv->reset_lock);
-		return err;
-	}
-
-	pthread_mutex_unlock(&priv->reset_lock);
-
-	return 0;
-}
-
 static int
 gve_verify_driver_compatibility(struct gve_priv *priv)
 {
@@ -1071,6 +1026,7 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->flow_type_rss_offloads = GVE_RTE_RSS_OFFLOAD_ALL;
 	dev_info->hash_key_size = GVE_RSS_HASH_KEY_SIZE;
 	dev_info->reta_size = GVE_RSS_INDIR_SIZE;
+	dev_info->err_handle_mode = RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE;
 
 	return 0;
 }
@@ -1529,63 +1485,6 @@ gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 	return 0;
 }
 
-static const struct eth_dev_ops gve_eth_dev_ops = {
-	.dev_configure        = gve_dev_configure,
-	.dev_start            = gve_dev_start,
-	.dev_stop             = gve_dev_stop,
-	.dev_close            = gve_dev_close,
-	.dev_reset            = gve_dev_reset,
-	.dev_infos_get        = gve_dev_info_get,
-	.rx_queue_setup       = gve_rx_queue_setup,
-	.tx_queue_setup       = gve_tx_queue_setup,
-	.rx_queue_release     = gve_rx_queue_release,
-	.tx_queue_release     = gve_tx_queue_release,
-	.rx_queue_start       = gve_rx_queue_start,
-	.tx_queue_start       = gve_tx_queue_start,
-	.rx_queue_stop        = gve_rx_queue_stop,
-	.tx_queue_stop        = gve_tx_queue_stop,
-	.flow_ops_get         = gve_flow_ops_get,
-	.link_update          = gve_link_update,
-	.stats_get            = gve_dev_stats_get,
-	.stats_reset          = gve_dev_stats_reset,
-	.mtu_set              = gve_dev_mtu_set,
-	.xstats_get           = gve_xstats_get,
-	.xstats_get_names     = gve_xstats_get_names,
-	.rss_hash_update      = gve_rss_hash_update,
-	.rss_hash_conf_get    = gve_rss_hash_conf_get,
-	.reta_update          = gve_rss_reta_update,
-	.reta_query           = gve_rss_reta_query,
-};
-
-static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
-	.dev_configure        = gve_dev_configure,
-	.dev_start            = gve_dev_start,
-	.dev_stop             = gve_dev_stop,
-	.dev_close            = gve_dev_close,
-	.dev_reset            = gve_dev_reset,
-	.dev_infos_get        = gve_dev_info_get,
-	.rx_queue_setup       = gve_rx_queue_setup_dqo,
-	.tx_queue_setup       = gve_tx_queue_setup_dqo,
-	.rx_queue_release     = gve_rx_queue_release_dqo,
-	.tx_queue_release     = gve_tx_queue_release_dqo,
-	.rx_queue_start       = gve_rx_queue_start_dqo,
-	.tx_queue_start       = gve_tx_queue_start_dqo,
-	.rx_queue_stop        = gve_rx_queue_stop_dqo,
-	.tx_queue_stop        = gve_tx_queue_stop_dqo,
-	.flow_ops_get         = gve_flow_ops_get,
-	.link_update          = gve_link_update,
-	.stats_get            = gve_dev_stats_get,
-	.stats_reset          = gve_dev_stats_reset,
-	.mtu_set              = gve_dev_mtu_set,
-	.xstats_get           = gve_xstats_get,
-	.xstats_get_names     = gve_xstats_get_names,
-	.rss_hash_update      = gve_rss_hash_update,
-	.rss_hash_conf_get    = gve_rss_hash_conf_get,
-	.reta_update          = gve_rss_reta_update,
-	.reta_query           = gve_rss_reta_query,
-	.read_clock           = gve_read_clock,
-};
-
 static int
 pci_dev_msix_vec_count(struct rte_pci_device *pdev)
 {
@@ -1708,6 +1607,171 @@ gve_set_default_ring_size_bounds(struct gve_priv *priv)
 	priv->min_rx_desc_cnt = GVE_DEFAULT_MIN_RX_RING_SIZE;
 }
 
+static int
+gve_recreate_queues(struct rte_eth_dev *dev)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	uint16_t port_id = dev->data->port_id;
+	uint16_t i;
+	int ret;
+
+	if (priv->rxq_configs == NULL || priv->txq_configs == NULL) {
+		PMD_DRV_LOG(ERR, "Port %u: Queue configurations not allocated",
+			    port_id);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct gve_rxq_config *rx_cfg = &priv->rxq_configs[i];
+
+		if (!rx_cfg->allocated)
+			continue;
+
+		ret = dev->dev_ops->rx_queue_setup(dev, i, rx_cfg->nb_descriptors,
+						   rx_cfg->socket_id,
+						   &rx_cfg->conf,
+						   rx_cfg->mb_pool);
+		if (ret != 0) {
+			PMD_DRV_LOG(ERR,
+				    "Port %u: Failed to re-create RX queue %u",
+				    port_id, i);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct gve_txq_config *tx_cfg = &priv->txq_configs[i];
+
+		if (!tx_cfg->allocated)
+			continue;
+
+		ret = dev->dev_ops->tx_queue_setup(dev, i, tx_cfg->nb_descriptors,
+						   tx_cfg->socket_id,
+						   &tx_cfg->conf);
+		if (ret != 0) {
+			PMD_DRV_LOG(ERR,
+				    "Port %u: Failed to re-create TX queue %u",
+				    port_id, i);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int
+gve_internal_recover_device(struct rte_eth_dev *dev)
+{
+	struct gve_process_private *process_priv = dev->process_private;
+	struct gve_priv *priv = dev->data->dev_private;
+	uint16_t port_id = dev->data->port_id;
+	uint16_t i;
+	int ret;
+
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_ERR_RECOVERING, NULL);
+
+	rte_eth_fp_ops[port_id].rx_pkt_burst = rte_eth_pkt_burst_dummy;
+	rte_eth_fp_ops[port_id].tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
+	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+
+	/* Ensure dummy burst fns are visible before clearing queue pointers. */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		if (dev->data->rx_queues[i] != NULL) {
+			gve_add_zombie_rx_queue(priv, dev->data->rx_queues[i]);
+			dev->data->rx_queues[i] = NULL;
+		}
+	}
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		if (dev->data->tx_queues[i] != NULL) {
+			gve_add_zombie_tx_queue(priv, dev->data->tx_queues[i]);
+			dev->data->tx_queues[i] = NULL;
+		}
+	}
+
+	gve_stop_dev_status_polling(dev);
+
+	if (gve_is_gqi(priv))
+		gve_free_stats_report(dev);
+
+	gve_deconfigure_device_resources(priv);
+
+	process_priv->ctrl_ops->free_ctrl_plane(priv);
+
+	/*
+	 * Keep device resources allocated, except for the RSS config which must
+	 * be freed as the driver cache will be stale after reset.
+	 */
+	gve_free_rss_config(&priv->rss_config);
+	if (process_priv->ctrl_ops->query_rss != NULL)
+		priv->rss_cache_dirty = true;
+
+	priv->reset_generation++;
+	priv->num_registered_pages = 0;
+	ret = process_priv->ctrl_ops->init_ctrl_plane(priv);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR,
+			    "Port %u: Failed to re-init control plane after reset",
+			    port_id);
+		goto recover_fail;
+	}
+
+	ret = gve_configure_device_resources(priv);
+	if (ret != 0)
+		goto recover_fail;
+
+	ret = gve_recreate_queues(dev);
+	if (ret != 0)
+		goto recover_fail;
+
+	ret = gve_dev_start(dev);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR,
+			    "Port %u: Failed to restart device after reset",
+			    port_id);
+		goto recover_fail;
+	}
+
+	if (gve_is_gqi(priv)) {
+		gve_set_rx_function(dev);
+		gve_set_tx_function(dev);
+	} else {
+		gve_set_rx_function_dqo(dev);
+		gve_set_tx_function_dqo(dev);
+	}
+
+	rte_eth_fp_ops[port_id].rxq.data = dev->data->rx_queues;
+	rte_eth_fp_ops[port_id].txq.data = dev->data->tx_queues;
+
+	/* Ensure queue data pointers are visible before restoring burst fns. */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
+	rte_eth_fp_ops[port_id].rx_pkt_burst = dev->rx_pkt_burst;
+	rte_eth_fp_ops[port_id].tx_pkt_burst = dev->tx_pkt_burst;
+
+	PMD_DRV_LOG(INFO, "Port %u: Proactive reset recovery successful",
+		    port_id);
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_RECOVERY_SUCCESS, NULL);
+
+	return 0;
+
+recover_fail:
+	gve_free_queues(dev);
+	gve_deconfigure_device_resources(priv);
+
+	process_priv->ctrl_ops->free_ctrl_plane(priv);
+
+	rte_eth_fp_ops[port_id].rx_pkt_burst = rte_eth_pkt_burst_dummy;
+	rte_eth_fp_ops[port_id].tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	PMD_DRV_LOG(ERR, "Port %u: Proactive reset recovery failed",
+		    port_id);
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_RECOVERY_FAILED, NULL);
+
+	return ret;
+}
+
 static void
 gve_check_device_status(void *arg)
 {
@@ -1716,22 +1780,39 @@ gve_check_device_status(void *arg)
 	struct gve_priv *priv = dev->data->dev_private;
 	int ret;
 
-	process_priv = rte_eth_devices[priv->port_id].process_private;
+	process_priv = dev->process_private;
+
+	gve_clean_zombie_queues(priv, false);
 
 	if (process_priv->ctrl_ops->check_device_needs_reset(priv)) {
-		PMD_DRV_LOG(INFO,
-			"Device on port %u requests a reset. Stopping device status polling.",
-			dev->data->port_id);
-		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RESET,
-			NULL);
-	} else {
+		pthread_mutex_lock(&priv->reset_lock);
+
+		/*
+		 * Defend against TOCTOU by checking if a reset is still needed
+		 * after acquiring the lock.
+		 */
+		if (process_priv->ctrl_ops->check_device_needs_reset(priv)) {
+			PMD_DRV_LOG(NOTICE,
+				    "Port %u: Device requested reset. Executing proactive recovery.",
+				    dev->data->port_id);
+
+			ret = gve_internal_recover_device(dev);
+			if (ret == 0) {
+				pthread_mutex_unlock(&priv->reset_lock);
+				return;
+			}
+		}
+
+		pthread_mutex_unlock(&priv->reset_lock);
+	}
+
+	if (dev->data->dev_started) {
 		ret = rte_eal_alarm_set(GVE_DEV_POLL_INTERVAL_US,
 					gve_check_device_status, dev);
-		if (ret != 0) {
+		if (ret != 0)
 			PMD_DRV_LOG(ERR,
-				"Port %u: Failed to re-arm alarm poller!",
-				dev->data->port_id);
-		}
+				    "Port %u: Failed to re-arm alarm poller!",
+				    dev->data->port_id);
 	}
 }
 
@@ -1765,6 +1846,83 @@ gve_stop_dev_status_polling(struct rte_eth_dev *dev)
 	rte_eal_alarm_cancel(gve_check_device_status, dev);
 }
 
+static int
+gve_dev_reset(struct rte_eth_dev *dev)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_DRV_LOG(ERR,
+			    "Device reset on port %u not supported in secondary processes.",
+			    dev->data->port_id);
+		return -EPERM;
+	}
+
+	pthread_mutex_lock(&priv->reset_lock);
+	ret = gve_internal_recover_device(dev);
+	pthread_mutex_unlock(&priv->reset_lock);
+
+	return ret;
+}
+
+static const struct eth_dev_ops gve_eth_dev_ops = {
+	.dev_configure        = gve_dev_configure,
+	.dev_start            = gve_dev_start,
+	.dev_stop             = gve_dev_stop,
+	.dev_close            = gve_dev_close,
+	.dev_reset            = gve_dev_reset,
+	.dev_infos_get        = gve_dev_info_get,
+	.rx_queue_setup       = gve_rx_queue_setup,
+	.tx_queue_setup       = gve_tx_queue_setup,
+	.rx_queue_release     = gve_rx_queue_release,
+	.tx_queue_release     = gve_tx_queue_release,
+	.rx_queue_start       = gve_rx_queue_start,
+	.tx_queue_start       = gve_tx_queue_start,
+	.rx_queue_stop        = gve_rx_queue_stop,
+	.tx_queue_stop        = gve_tx_queue_stop,
+	.flow_ops_get         = gve_flow_ops_get,
+	.link_update          = gve_link_update,
+	.stats_get            = gve_dev_stats_get,
+	.stats_reset          = gve_dev_stats_reset,
+	.mtu_set              = gve_dev_mtu_set,
+	.xstats_get           = gve_xstats_get,
+	.xstats_get_names     = gve_xstats_get_names,
+	.rss_hash_update      = gve_rss_hash_update,
+	.rss_hash_conf_get    = gve_rss_hash_conf_get,
+	.reta_update          = gve_rss_reta_update,
+	.reta_query           = gve_rss_reta_query,
+};
+
+static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
+	.dev_configure        = gve_dev_configure,
+	.dev_start            = gve_dev_start,
+	.dev_stop             = gve_dev_stop,
+	.dev_close            = gve_dev_close,
+	.dev_reset            = gve_dev_reset,
+	.dev_infos_get        = gve_dev_info_get,
+	.rx_queue_setup       = gve_rx_queue_setup_dqo,
+	.tx_queue_setup       = gve_tx_queue_setup_dqo,
+	.rx_queue_release     = gve_rx_queue_release_dqo,
+	.tx_queue_release     = gve_tx_queue_release_dqo,
+	.rx_queue_start       = gve_rx_queue_start_dqo,
+	.tx_queue_start       = gve_tx_queue_start_dqo,
+	.rx_queue_stop        = gve_rx_queue_stop_dqo,
+	.tx_queue_stop        = gve_tx_queue_stop_dqo,
+	.flow_ops_get         = gve_flow_ops_get,
+	.link_update          = gve_link_update,
+	.stats_get            = gve_dev_stats_get,
+	.stats_reset          = gve_dev_stats_reset,
+	.mtu_set              = gve_dev_mtu_set,
+	.xstats_get           = gve_xstats_get,
+	.xstats_get_names     = gve_xstats_get_names,
+	.rss_hash_update      = gve_rss_hash_update,
+	.rss_hash_conf_get    = gve_rss_hash_conf_get,
+	.reta_update          = gve_rss_reta_update,
+	.reta_query           = gve_rss_reta_query,
+	.read_clock           = gve_read_clock,
+};
+
 static int
 gve_adminq_get_device_properties(struct gve_priv *priv)
 {
-- 
2.56.0.307.g5fe7bd680c-goog

