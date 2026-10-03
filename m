Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC1CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290C8402B8;
	Sat,  3 Oct 2026 04:51:50 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mails.dpdk.org (Postfix) with ESMTP id DCD314003C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:46 +0200 (CEST)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so27352a12.3
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995906; x=1791600706; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/JEtItayedicqmTFoBU4lv/lNRSqmmfpJxe4Ead8O6U=;
 b=mDVSGu/lfqhysqS/JP53ts9jx4azbj2iDENucfMNjZERlrozjiNVTKJllBlhfhndai
 S+MviccsFcf9AbA6MFFqRybxJ1BqOV0HednAgN5oYhI+8xSJrGCdQe3pzCbDm9xW0E8I
 Zj5pQqAu5LJ4jGbbv2IzCPNYdqwHFMeEECV+C8LuNG6ZzlrPwabVJ+34eDHvgTCDyTv3
 7h1bnUFnct4brqyy+cna4LFdXuRASvVWljwZjI1jQbuZPn6CpDuR8+GgpZrc4eoLLb4m
 YnCsMdEEHr/JEaQ8UDii6hK5xhGTLmRT2hvx5hDkGYw3Hh/DWZXoNycSzJFNeix8uAKD
 n8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995906; x=1791600706;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/JEtItayedicqmTFoBU4lv/lNRSqmmfpJxe4Ead8O6U=;
 b=pWHAwYHCcCCK1rxAOTPkaW5blDQY2Oq5gPoiJbimLa2a1DxGGhmNv1hMQAyTYcaOMk
 YMZRxSwZBrkUH8X9HtYJa248g6unHhrLHObrR1AK3tAXLPXiqsUIRJLM88E5VLpKDG8t
 4BqSYuoRkgc6x4bdccfrYuAcOb407tz2gUuP3tJH/GO+S84mphKbyxWYMVstu4MHViJN
 YYDS6Qcg5HNkApUfqJhmrIdRVkLBT7muuEaw4qut0ph/E5UEj94OosHubVkQD8XTkP30
 1sB3+8H5o5JmF5oAE3wBsGZ0Ay++q1oFjvcyMY/wDWjeqGWkVVzCzxrYWPjJRoXAfBLc
 koLQ==
X-Gm-Message-State: AFuF++mJ9P27bv1WLy6B0OaqOdvHPfabq/9XiCtwZ1GllOzgKDjuCQtt
 1vPHRh2CZRJ3d8TVUha1HuBuwZpAnhSZXFHBlIQ5TlMSIzISxa0Nukf7tfNMOP9WNKC/hfQyXtG
 otE+GXum7CniECw==
X-Received: from pgcv6.prod.google.com ([2002:a05:6a02:5306:b0:cc7:a18a:c58f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210a:b0:3de:3f4d:f2e8 with SMTP id
 adf61e73a8af0-3e0bd195fcdmr4390024637.25.1790995905482; 
 Fri, 02 Oct 2026 19:51:45 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:33 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-2-joshwash@google.com>
Subject: [PATCH 1/8] net/gve: refactor ethdev for control ops interface
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>
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

From: Mark Blasko <blasko@google.com>

Abstract control plane operations into a control operations interface.
This decouples the core driver logic from the AQ implementation.

Align AdminQ function parameters to match control operations signatures:
- gve_adminq_configure_device_resources(): read counter array and IRQ
  doorbell DMA addresses/counts directly from struct gve_priv (wired to
  the get_interrupt_dbs control op).
- gve_adminq_get_ptype_map_dqo(): populate priv->ptype_lut_dqo directly
  from struct gve_priv (wired to the get_ptype_map control op).

Move the max_tx_queues and max_rx_queues register reads from
gve_dev_init() into gve_adminq_get_device_properties(), as maximum
queue counts are retrieved via get_device_properties in mailbox mode.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_adminq.c |  18 ++---
 drivers/net/gve/base/gve_adminq.h |   9 +--
 drivers/net/gve/gve_ethdev.c      | 108 +++++++++++++++++++-----------
 drivers/net/gve/gve_ethdev.h      |  45 +++++++++++++
 drivers/net/gve/gve_flow_rule.c   |   6 +-
 drivers/net/gve/gve_rx.c          |   2 +-
 drivers/net/gve/gve_rx_dqo.c      |   2 +-
 drivers/net/gve/gve_tx.c          |   2 +-
 drivers/net/gve/gve_tx_dqo.c      |   2 +-
 9 files changed, 130 insertions(+), 64 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 89bf669c24..74b9a0125c 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -664,11 +664,7 @@ int gve_adminq_report_nic_timestamp(struct gve_priv *priv, dma_addr_t nic_ts_rep
  * gve arranges the msix vectors so that the management vector is last.
  */
 #define GVE_NTFY_BLK_BASE_MSIX_IDX	0
-int gve_adminq_configure_device_resources(struct gve_priv *priv,
-					  dma_addr_t counter_array_bus_addr,
-					  u32 num_counters,
-					  dma_addr_t db_array_bus_addr,
-					  u32 num_ntfy_blks)
+int gve_adminq_configure_device_resources(struct gve_priv *priv)
 {
 	union gve_adminq_command cmd;
 
@@ -676,10 +672,10 @@ int gve_adminq_configure_device_resources(struct gve_priv *priv,
 	cmd.opcode = cpu_to_be32(GVE_ADMINQ_CONFIGURE_DEVICE_RESOURCES);
 	cmd.configure_device_resources =
 		(struct gve_adminq_configure_device_resources) {
-		.counter_array = cpu_to_be64(counter_array_bus_addr),
-		.num_counters = cpu_to_be32(num_counters),
-		.irq_db_addr = cpu_to_be64(db_array_bus_addr),
-		.num_irq_dbs = cpu_to_be32(num_ntfy_blks),
+		.counter_array = cpu_to_be64(priv->cnt_array_mz->iova),
+		.num_counters = cpu_to_be32(priv->num_event_counters),
+		.irq_db_addr = cpu_to_be64(priv->irq_dbs_mz->iova),
+		.num_irq_dbs = cpu_to_be32(priv->num_ntfy_blks),
 		.irq_db_stride = cpu_to_be32(sizeof(*priv->irq_dbs)),
 		.ntfy_blk_msix_base_idx =
 					cpu_to_be32(GVE_NTFY_BLK_BASE_MSIX_IDX),
@@ -1198,9 +1194,9 @@ int gve_adminq_report_link_speed(struct gve_priv *priv)
 	return err;
 }
 
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut)
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv)
 {
+	struct gve_ptype_lut *ptype_lut = priv->ptype_lut_dqo;
 	struct gve_dma_mem ptype_map_dma_mem;
 	struct gve_ptype_map *ptype_map;
 	union gve_adminq_command cmd;
diff --git a/drivers/net/gve/base/gve_adminq.h b/drivers/net/gve/base/gve_adminq.h
index 954be39fbf..5002cdf783 100644
--- a/drivers/net/gve/base/gve_adminq.h
+++ b/drivers/net/gve/base/gve_adminq.h
@@ -523,11 +523,7 @@ int gve_adminq_alloc(struct gve_priv *priv);
 void gve_adminq_free(struct gve_priv *priv);
 void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
-int gve_adminq_configure_device_resources(struct gve_priv *priv,
-					  dma_addr_t counter_array_bus_addr,
-					  u32 num_counters,
-					  dma_addr_t db_array_bus_addr,
-					  u32 num_ntfy_blks);
+int gve_adminq_configure_device_resources(struct gve_priv *priv);
 int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
 int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 num_queues);
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 queue_id);
@@ -542,8 +538,7 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 
 struct gve_ptype_lut;
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);
 
 int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
 					   u64 driver_info_len,
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index c990920a4d..6704cc40b3 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -181,7 +181,7 @@ gve_setup_queue_page_list(struct gve_priv *priv, uint16_t queue_id, bool is_rx,
 			    priv->max_registered_pages);
 		goto cleanup_qpl;
 	}
-	err = gve_adminq_register_page_list(priv, qpl);
+	err = priv->ctrl_ops->register_page_list(priv, qpl);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to register %s qpl for queue %hu.",
@@ -200,7 +200,7 @@ int
 gve_teardown_queue_page_list(struct gve_priv *priv,
 	struct gve_queue_page_list *qpl)
 {
-	int err = gve_adminq_unregister_page_list(priv, qpl->id);
+	int err = priv->ctrl_ops->unregister_page_list(priv, qpl->id);
 	if (err) {
 		PMD_DRV_LOG(CRIT, "Unable to unregister qpl %d!", qpl->id);
 		return err;
@@ -239,7 +239,7 @@ gve_dev_configure(struct rte_eth_dev *dev)
 		gve_init_rss_config_from_priv(priv, &update_reta_config);
 		gve_generate_rss_reta(dev, &update_reta_config);
 
-		err = gve_adminq_configure_rss(priv, &update_reta_config);
+		err = priv->ctrl_ops->configure_rss(priv, &update_reta_config);
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not reconfigure RSS redirection table.");
@@ -270,7 +270,7 @@ gve_link_update(struct rte_eth_dev *dev, __rte_unused int wait_to_complete)
 	} else {
 		link.link_status = RTE_ETH_LINK_UP;
 		PMD_DRV_LOG(DEBUG, "Get link status from hw");
-		err = gve_adminq_report_link_speed(priv);
+		err = priv->ctrl_ops->report_link_speed(priv);
 		if (err) {
 			PMD_DRV_LOG(ERR, "Failed to get link speed.");
 			priv->link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
@@ -366,7 +366,7 @@ gve_start_queues(struct rte_eth_dev *dev)
 
 	num_queues = dev->data->nb_tx_queues;
 	priv->txqs = (struct gve_tx_queue **)dev->data->tx_queues;
-	ret = gve_adminq_create_tx_queues(priv, num_queues);
+	ret = priv->ctrl_ops->create_tx_queues(priv, num_queues);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to create %u tx queues.", num_queues);
 		return ret;
@@ -384,7 +384,7 @@ gve_start_queues(struct rte_eth_dev *dev)
 
 	num_queues = dev->data->nb_rx_queues;
 	priv->rxqs = (struct gve_rx_queue **)dev->data->rx_queues;
-	ret = gve_adminq_create_rx_queues(priv, num_queues);
+	ret = priv->ctrl_ops->create_rx_queues(priv, num_queues);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to create %u rx queues.", num_queues);
 		goto err_tx;
@@ -450,11 +450,11 @@ gve_dev_start(struct rte_eth_dev *dev)
 				"Failed to allocate region for stats reporting.");
 			return ret;
 		}
-		ret = gve_adminq_report_stats(priv, priv->stats_report_len,
+		ret = priv->ctrl_ops->setup_stats_report(priv, priv->stats_report_len,
 				priv->stats_report_mem->iova,
 				GVE_STATS_REPORT_TIMER_PERIOD);
 		if (ret != 0) {
-			PMD_DRV_LOG(ERR, "gve_adminq_report_stats command failed.");
+			PMD_DRV_LOG(ERR, "setup_stats_report command failed.");
 			return ret;
 		}
 	}
@@ -478,7 +478,7 @@ gve_read_nic_clock(void *arg)
 	pthread_mutex_lock(&priv->nic_ts_lock);
 	memset(priv->nic_ts_report, 0, sizeof(struct gve_nic_ts_report));
 
-	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+	err = priv->ctrl_ops->report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
 	if (err == 0) {
 		ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
 		pthread_mutex_unlock(&priv->nic_ts_lock);
@@ -682,7 +682,7 @@ gve_teardown_device_resources(struct gve_priv *priv)
 
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
-		err = gve_adminq_deconfigure_device_resources(priv);
+		err = priv->ctrl_ops->free_db_resources(priv);
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not deconfigure device resources: err=%d",
@@ -722,7 +722,7 @@ gve_dev_close(struct rte_eth_dev *dev)
 
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
+	priv->ctrl_ops->free_ctrl_plane(priv);
 
 	pthread_mutex_destroy(&priv->flow_rule_lock);
 	pthread_mutex_destroy(&priv->nic_ts_lock);
@@ -756,7 +756,7 @@ gve_dev_reset(struct rte_eth_dev *dev)
 	 */
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
+	priv->ctrl_ops->free_ctrl_plane(priv);
 
 	err = gve_init_priv(priv, true);
 	if (err != 0) {
@@ -967,7 +967,10 @@ gve_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EBUSY;
 	}
 
-	err = gve_adminq_set_mtu(priv, mtu);
+	if (priv->ctrl_ops->set_mtu == NULL)
+		return -ENOTSUP;
+
+	err = priv->ctrl_ops->set_mtu(priv, mtu);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to set mtu as %u err = %d", mtu, err);
 		return err;
@@ -1157,7 +1160,7 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 		memcpy(gve_rss_conf.indir, priv->rss_config.indir,
 			gve_rss_conf.indir_size * sizeof(*priv->rss_config.indir));
 
-	err = gve_adminq_configure_rss(priv, &gve_rss_conf);
+	err = priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
 	if (!err)
 		gve_update_priv_rss_config(priv, &gve_rss_conf);
 
@@ -1233,7 +1236,7 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 			table_id++;
 	}
 
-	err = gve_adminq_configure_rss(priv, &gve_rss_conf);
+	err = priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
 	if (err)
 		PMD_DRV_LOG(ERR, "Problem configuring RSS with device.");
 	else
@@ -1310,7 +1313,8 @@ gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 		return -EIO;
 
 	pthread_mutex_lock(&priv->nic_ts_lock);
-	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+
+	err = priv->ctrl_ops->report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
 	if (err != 0) {
 		pthread_mutex_unlock(&priv->nic_ts_lock);
 		return err;
@@ -1456,11 +1460,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 	priv->irq_dbs = (struct gve_irq_db *)mz->addr;
 	priv->irq_dbs_mz = mz;
 
-	err = gve_adminq_configure_device_resources(priv,
-						    priv->cnt_array_mz->iova,
-						    priv->num_event_counters,
-						    priv->irq_dbs_mz->iova,
-						    priv->num_ntfy_blks);
+	err = priv->ctrl_ops->get_interrupt_dbs(priv);
 	if (unlikely(err)) {
 		PMD_DRV_LOG(ERR, "Could not config device resources: err=%d", err);
 		goto free_irq_dbs;
@@ -1473,7 +1473,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 			err = -ENOMEM;
 			goto free_irq_dbs;
 		}
-		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
+		err = priv->ctrl_ops->get_ptype_map(priv);
 		if (unlikely(err)) {
 			PMD_DRV_LOG(ERR, "Failed to get ptype map: err=%d", err);
 			goto free_ptype_lut;
@@ -1562,21 +1562,58 @@ gve_stop_dev_status_polling(struct rte_eth_dev *dev)
 }
 
 static int
-gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+gve_adminq_get_device_properties(struct gve_priv *priv)
 {
-	int num_ntfy;
 	int err;
 
-	/* Set up the adminq */
-	err = gve_adminq_alloc(priv);
+	err = gve_verify_driver_compatibility(priv);
 	if (err) {
-		PMD_DRV_LOG(ERR, "Failed to alloc admin queue: err=%d", err);
+		PMD_DRV_LOG(ERR, "Could not verify driver compatibility: err=%d", err);
 		return err;
 	}
-	err = gve_verify_driver_compatibility(priv);
+
+	/* Get max queues to alloc etherdev */
+	priv->max_nb_txq = ioread32be(&priv->reg_bar0->max_tx_queues);
+	priv->max_nb_rxq = ioread32be(&priv->reg_bar0->max_rx_queues);
+
+	return gve_adminq_describe_device(priv);
+}
+
+static const struct gve_ctrl_ops gve_adminq_ops = {
+	.init_ctrl_plane = gve_adminq_alloc,
+	.free_ctrl_plane = gve_adminq_free,
+	.get_device_properties = gve_adminq_get_device_properties,
+	.get_ptype_map = gve_adminq_get_ptype_map_dqo,
+	.get_interrupt_dbs = gve_adminq_configure_device_resources,
+	.create_tx_queues = gve_adminq_create_tx_queues,
+	.destroy_tx_queues = gve_adminq_destroy_tx_queues,
+	.create_rx_queues = gve_adminq_create_rx_queues,
+	.destroy_rx_queues = gve_adminq_destroy_rx_queues,
+	.report_link_speed = gve_adminq_report_link_speed,
+	.configure_rss = gve_adminq_configure_rss,
+	.add_flow_rule = gve_adminq_add_flow_rule,
+	.del_flow_rule = gve_adminq_del_flow_rule,
+	.reset_flow_rules = gve_adminq_reset_flow_rules,
+	.free_db_resources = gve_adminq_deconfigure_device_resources,
+	.setup_stats_report = gve_adminq_report_stats,
+	.report_nic_timestamp = gve_adminq_report_nic_timestamp,
+	.set_mtu = gve_adminq_set_mtu,
+	.register_page_list = gve_adminq_register_page_list,
+	.unregister_page_list = gve_adminq_unregister_page_list,
+};
+
+static int
+gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+{
+	int num_ntfy;
+	int err;
+
+	priv->ctrl_ops = &gve_adminq_ops;
+
+	err = priv->ctrl_ops->init_ctrl_plane(priv);
 	if (err) {
-		PMD_DRV_LOG(ERR, "Could not verify driver compatibility: err=%d", err);
-		goto free_adminq;
+		PMD_DRV_LOG(ERR, "Failed to alloc control plane: err=%d", err);
+		return err;
 	}
 
 	if (skip_describe_device)
@@ -1586,7 +1623,7 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	gve_set_default_ring_size_bounds(priv);
 
 	/* Get the initial information we need from the device */
-	err = gve_adminq_describe_device(priv);
+	err = priv->ctrl_ops->get_device_properties(priv);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Could not get device information: err=%d", err);
 		goto free_adminq;
@@ -1636,7 +1673,7 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	if (!err)
 		return 0;
 free_adminq:
-	gve_adminq_free(priv);
+	priv->ctrl_ops->free_ctrl_plane(priv);
 	return err;
 }
 
@@ -1644,7 +1681,6 @@ static int
 gve_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct gve_priv *priv = eth_dev->data->dev_private;
-	int max_tx_queues, max_rx_queues;
 	struct rte_pci_device *pci_dev;
 	struct gve_registers *reg_bar;
 	pthread_mutexattr_t mutexattr;
@@ -1679,18 +1715,12 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	gve_write_version(&reg_bar->driver_version);
-	/* Get max queues to alloc etherdev */
-	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
-	max_rx_queues = ioread32be(&reg_bar->max_rx_queues);
 
 	priv->reg_bar0 = reg_bar;
 	priv->db_bar2 = db_bar;
 	priv->pci_dev = pci_dev;
 	priv->state_flags = 0x0;
 
-	priv->max_nb_txq = max_tx_queues;
-	priv->max_nb_rxq = max_rx_queues;
-
 	pthread_mutexattr_init(&mutexattr);
 	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
 	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..f57e81dbc9 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -272,7 +272,52 @@ struct gve_flow {
 
 extern const struct rte_flow_ops gve_flow_ops;
 
+struct gve_priv;
+struct gve_flow_rule_params;
+
+struct gve_ctrl_ops {
+	int (*init_ctrl_plane)(struct gve_priv *priv);
+	void (*free_ctrl_plane)(struct gve_priv *priv);
+	int (*get_device_properties)(struct gve_priv *priv);
+	int (*get_ptype_map)(struct gve_priv *priv);
+	int (*get_interrupt_dbs)(struct gve_priv *priv);
+	int (*create_tx_queues)(struct gve_priv *priv, uint32_t num_queues);
+	int (*destroy_tx_queues)(struct gve_priv *priv, uint32_t num_queues);
+	int (*create_rx_queues)(struct gve_priv *priv, uint32_t num_queues);
+	int (*destroy_rx_queues)(struct gve_priv *priv, uint32_t num_queues);
+	int (*report_link_speed)(struct gve_priv *priv);
+	int (*configure_rss)(struct gve_priv *priv,
+			     struct gve_rss_config *rss_conf);
+	int (*add_flow_rule)(struct gve_priv *priv,
+			     struct gve_flow_rule_params *rule, uint32_t loc);
+	int (*del_flow_rule)(struct gve_priv *priv, uint32_t loc);
+	int (*reset_flow_rules)(struct gve_priv *priv);
+
+	/*
+	 * Optional control operations not supported by all control plane modes:
+	 * - free_db_resources: AdminQ only
+	 * - query_rss: Mailbox only
+	 * - setup_stats_report: AdminQ only
+	 * - report_nic_timestamp: AdminQ only (Mailbox uses MMIO clock read)
+	 * - set_mtu: AdminQ only
+	 * - register_page_list / unregister_page_list: AdminQ QPL mode only
+	 */
+	int (*free_db_resources)(struct gve_priv *priv);
+	int (*query_rss)(struct gve_priv *priv);
+	int (*setup_stats_report)(struct gve_priv *priv,
+				 uint64_t stats_report_len,
+				 dma_addr_t stats_report_addr,
+				 uint64_t interval_ms);
+	int (*report_nic_timestamp)(struct gve_priv *priv, dma_addr_t dma_addr);
+	int (*set_mtu)(struct gve_priv *priv, uint64_t mtu);
+	int (*register_page_list)(struct gve_priv *priv,
+				  struct gve_queue_page_list *qpl);
+	int (*unregister_page_list)(struct gve_priv *priv,
+				    uint32_t page_list_id);
+};
+
 struct gve_priv {
+	const struct gve_ctrl_ops *ctrl_ops;
 	struct gve_irq_db *irq_dbs; /* array of num_ntfy_blks */
 	const struct rte_memzone *irq_dbs_mz;
 	uint32_t mgmt_msix_idx;
diff --git a/drivers/net/gve/gve_flow_rule.c b/drivers/net/gve/gve_flow_rule.c
index 1266e197ea..5959489791 100644
--- a/drivers/net/gve/gve_flow_rule.c
+++ b/drivers/net/gve/gve_flow_rule.c
@@ -450,7 +450,7 @@ gve_free_flow_rules(struct gve_priv *priv)
 	int err = 0;
 
 	if (!TAILQ_EMPTY(&priv->active_flows)) {
-		err = gve_adminq_reset_flow_rules(priv);
+		err = priv->ctrl_ops->reset_flow_rules(priv);
 		if (err) {
 			PMD_DRV_LOG(ERR,
 				"Failed to reset flow rules, internal device err=%d",
@@ -516,7 +516,7 @@ gve_create_flow_rule(struct rte_eth_dev *dev,
 		goto free_flow_and_unlock;
 	}
 
-	err = gve_adminq_add_flow_rule(priv, &rule, flow->rule_id);
+	err = priv->ctrl_ops->add_flow_rule(priv, &rule, flow->rule_id);
 	if (err) {
 		rte_bitmap_set(priv->avail_flow_rule_bmp, flow->rule_id);
 		rte_flow_error_set(error, -err,
@@ -588,7 +588,7 @@ gve_destroy_flow_rule(struct rte_eth_dev *dev, struct rte_flow *flow_handle,
 		goto unlock;
 	}
 
-	err = gve_adminq_del_flow_rule(priv, flow->rule_id);
+	err = priv->ctrl_ops->del_flow_rule(priv, flow->rule_id);
 	if (err) {
 		rte_flow_error_set(error, -err,
 			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index d14902c662..2f542c7a66 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -525,7 +525,7 @@ gve_stop_rx_queues(struct rte_eth_dev *dev)
 	if (!gve_is_gqi(hw))
 		return gve_stop_rx_queues_dqo(dev);
 
-	err = gve_adminq_destroy_rx_queues(hw, dev->data->nb_rx_queues);
+	err = hw->ctrl_ops->destroy_rx_queues(hw, dev->data->nb_rx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy rxqs");
 
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 3665d9e4cd..81d7cacaf6 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -560,7 +560,7 @@ gve_stop_rx_queues_dqo(struct rte_eth_dev *dev)
 	uint16_t i;
 	int err;
 
-	err = gve_adminq_destroy_rx_queues(hw, dev->data->nb_rx_queues);
+	err = hw->ctrl_ops->destroy_rx_queues(hw, dev->data->nb_rx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy rxqs");
 
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index c0400b07bf..333e82b141 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -732,7 +732,7 @@ gve_stop_tx_queues(struct rte_eth_dev *dev)
 	if (!gve_is_gqi(hw))
 		return gve_stop_tx_queues_dqo(dev);
 
-	err = gve_adminq_destroy_tx_queues(hw, dev->data->nb_tx_queues);
+	err = hw->ctrl_ops->destroy_tx_queues(hw, dev->data->nb_tx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy txqs");
 
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 5c03d3d1a2..a44a20b139 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -612,7 +612,7 @@ gve_stop_tx_queues_dqo(struct rte_eth_dev *dev)
 	uint16_t i;
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(hw, dev->data->nb_tx_queues);
+	err = hw->ctrl_ops->destroy_tx_queues(hw, dev->data->nb_tx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy txqs");
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

