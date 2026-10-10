Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF0CA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CBF640653;
	Sat, 10 Oct 2026 02:59:52 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id F0EB7402E0
 for <dev@dpdk.org>; Sat, 10 Oct 2026 02:59:49 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e601800e58so4035795ad.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791593989; x=1792198789; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I9N8NnDHAYVUO6oxnWZvQPnS20+Gpo97D867M1+CCrs=;
 b=j+2orIfcGaOsrD0+ttpblno1KJfV/j+EVj/LMsD98vrfwkrHa1qLygAmW8RqMCm+kf
 KpxhhwRMa5YfAvPlH0OZcktfj0n2laV4sms22Pk8iyK3HE9TthRBQ+TvkvT6V4bXz9FR
 Vic06l+xLU9J91vwK3UwTDolkODHYc94UgaxKvaMQ3iro7Ojg0JXFkRWJ0ydgKKpMSoM
 Ww8dEMTTWgO+9wNBFmBOT9NGckAFfkuIAw3ziOuNVTWeeUcwlm9kzy5LPNZyVcNRnQ8n
 RqJ6BtR21X8A4XCjlAolt5EjyBwQusNUuy90VI1HHuIbnhtVoQAUAkvBLNo0FBiCD9fR
 FWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791593989; x=1792198789;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I9N8NnDHAYVUO6oxnWZvQPnS20+Gpo97D867M1+CCrs=;
 b=EdoTPl4xzjjSJFyYpt3GZ/iCoVMOY0uMB0ix4ijRsPwkslEP1moT1GNAcLnDsQcPxB
 0raEd6daeyeT8yHRXMVexKjdOZSiCEtXnrYf2oVn44eN8FKC74+bvUD5W+QvvuBolbev
 vMTu4C0jnp1+WeMleq6rA32kRMI/yJqzVpkQGaxT2yj4AwYjaUA8OOJKyPwfyVsJUIw6
 SMoZ2Y/fHgiVovWkaKc2bcsElOVhGHjN2T6IvRT4ijV6VHrsYT8bqZc0CDjaH5q+2TDI
 8iX/579VgaEPiGJChs13jl1CK6Pu9uWtoF3Sk7SkpXQz2W+jSZqiwoamdgBAVN+Z5o/E
 cXTw==
X-Gm-Message-State: AFq9FYKX/vP7HW8fVxdgY8atRCkoYW4/mkiY7+Ce8KUr+q2SfcRwUfsr
 u4rso5r2ODGAS52+Q5aZM+V2ssoua1k9OlJbZiILEDiCn0dbuMYHSMuifss22p6zy2IOvh3sWE/
 ds4XcyleolnAEjQ==
X-Received: from plpl17.prod.google.com ([2002:a17:903:3dd1:b0:2e4:a7ee:52bc])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:11c7:b0:2dd:c100:a5e3 with SMTP id
 d9443c01a7336-2e842dfc284mr34031595ad.55.1791593988660; 
 Fri, 09 Oct 2026 17:59:48 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:34 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-3-joshwash@google.com>
Subject: [PATCH v3 2/8] net/gve: refactor ethdev for control ops interface
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
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

From: Mark Blasko <blasko@google.com>

Abstract control plane operations into a control operations interface.
This decouples the core driver logic from the AQ implementation.

Store the ops table pointer in a per-process struct gve_process_private
attached to eth_dev->process_private instead of in struct gve_priv:
dev_private is shared with secondary processes, which may map the
driver at a different address. Functions that only have struct gve_priv
look up their ethdev through a new port_id field.

Align AdminQ function parameters to match control operations signatures:
- gve_adminq_configure_device_resources(): read counter array and IRQ
  doorbell DMA addresses/counts directly from struct gve_priv (wired to
  the get_interrupt_dbs control op).
- gve_adminq_get_ptype_map_dqo(): populate priv->ptype_lut_dqo directly
  from struct gve_priv (wired to the get_ptype_map control op).

Move the AdminQ driver compatibility check from gve_init_priv() into
gve_adminq_get_device_properties(). Since gve_init_priv() skips
get_device_properties on device reset, the check now only runs at probe
time and is no longer repeated after a reset.

Move the max_tx_queues and max_rx_queues register reads from
gve_dev_init() into gve_adminq_get_device_properties(), as maximum
queue counts are retrieved via get_device_properties in mailbox mode.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
- Store the control ops table pointer in eth_dev->process_private
  (struct gve_process_private) instead of in dev_private, which is
  shared with secondary processes. Add port_id to struct gve_priv so
  functions that only have priv can reach it.
- Mention in the commit message that the driver compatibility check no
  longer runs on device reset.
- Only mark query_rss as optional and drop the set_mtu NULL check.
---
 drivers/net/gve/base/gve_adminq.c |  18 ++--
 drivers/net/gve/base/gve_adminq.h |   9 +-
 drivers/net/gve/gve_ethdev.c      | 163 ++++++++++++++++++++++--------
 drivers/net/gve/gve_ethdev.h      |  41 ++++++++
 drivers/net/gve/gve_flow_rule.c   |  11 +-
 drivers/net/gve/gve_rx.c          |   3 +-
 drivers/net/gve/gve_rx_dqo.c      |   3 +-
 drivers/net/gve/gve_tx.c          |   3 +-
 drivers/net/gve/gve_tx_dqo.c      |   3 +-
 9 files changed, 186 insertions(+), 68 deletions(-)

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
index 80623979a8..ecf4247c19 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -153,10 +153,13 @@ gve_setup_queue_page_list(struct gve_priv *priv, uint16_t queue_id, bool is_rx,
 	uint32_t num_pages)
 {
 	const char *queue_type_string = is_rx ? "rx" : "tx";
+	struct gve_process_private *process_priv;
 	char qpl_name[RTE_MEMZONE_NAMESIZE];
 	struct gve_queue_page_list *qpl;
 	int err;
 
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
 	/* Allocate a new QPL. */
 	snprintf(qpl_name, sizeof(qpl_name), "gve_%s_%s_qpl%d",
 		priv->pci_dev->device.name, queue_type_string, queue_id);
@@ -181,7 +184,7 @@ gve_setup_queue_page_list(struct gve_priv *priv, uint16_t queue_id, bool is_rx,
 			    priv->max_registered_pages);
 		goto cleanup_qpl;
 	}
-	err = gve_adminq_register_page_list(priv, qpl);
+	err = process_priv->ctrl_ops->register_page_list(priv, qpl);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to register %s qpl for queue %hu.",
@@ -200,7 +203,11 @@ int
 gve_teardown_queue_page_list(struct gve_priv *priv,
 	struct gve_queue_page_list *qpl)
 {
-	int err = gve_adminq_unregister_page_list(priv, qpl->id);
+	struct gve_process_private *process_priv;
+	int err;
+
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+	err = process_priv->ctrl_ops->unregister_page_list(priv, qpl->id);
 	if (err) {
 		PMD_DRV_LOG(CRIT, "Unable to unregister qpl %d!", qpl->id);
 		return err;
@@ -213,6 +220,7 @@ gve_teardown_queue_page_list(struct gve_priv *priv,
 static int
 gve_dev_configure(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	int err;
 
@@ -239,7 +247,7 @@ gve_dev_configure(struct rte_eth_dev *dev)
 		gve_init_rss_config_from_priv(priv, &update_reta_config);
 		gve_generate_rss_reta(dev, &update_reta_config);
 
-		err = gve_adminq_configure_rss(priv, &update_reta_config);
+		err = process_priv->ctrl_ops->configure_rss(priv, &update_reta_config);
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not reconfigure RSS redirection table.");
@@ -256,6 +264,7 @@ gve_dev_configure(struct rte_eth_dev *dev)
 static int
 gve_link_update(struct rte_eth_dev *dev, __rte_unused int wait_to_complete)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	struct rte_eth_link link;
 	int err;
@@ -270,7 +279,7 @@ gve_link_update(struct rte_eth_dev *dev, __rte_unused int wait_to_complete)
 	} else {
 		link.link_status = RTE_ETH_LINK_UP;
 		PMD_DRV_LOG(DEBUG, "Get link status from hw");
-		err = gve_adminq_report_link_speed(priv);
+		err = process_priv->ctrl_ops->report_link_speed(priv);
 		if (err) {
 			PMD_DRV_LOG(ERR, "Failed to get link speed.");
 			priv->link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
@@ -359,6 +368,7 @@ gve_get_imissed_from_nic(struct rte_eth_dev *dev)
 static int
 gve_start_queues(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	uint16_t num_queues;
 	uint16_t i;
@@ -366,7 +376,7 @@ gve_start_queues(struct rte_eth_dev *dev)
 
 	num_queues = dev->data->nb_tx_queues;
 	priv->txqs = (struct gve_tx_queue **)dev->data->tx_queues;
-	ret = gve_adminq_create_tx_queues(priv, num_queues);
+	ret = process_priv->ctrl_ops->create_tx_queues(priv, num_queues);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to create %u tx queues.", num_queues);
 		return ret;
@@ -384,7 +394,7 @@ gve_start_queues(struct rte_eth_dev *dev)
 
 	num_queues = dev->data->nb_rx_queues;
 	priv->rxqs = (struct gve_rx_queue **)dev->data->rx_queues;
-	ret = gve_adminq_create_rx_queues(priv, num_queues);
+	ret = process_priv->ctrl_ops->create_rx_queues(priv, num_queues);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to create %u rx queues.", num_queues);
 		goto err_tx;
@@ -422,6 +432,7 @@ gve_start_queues(struct rte_eth_dev *dev)
 static int
 gve_dev_start(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv;
 	int ret;
 
@@ -450,11 +461,12 @@ gve_dev_start(struct rte_eth_dev *dev)
 				"Failed to allocate region for stats reporting.");
 			return ret;
 		}
-		ret = gve_adminq_report_stats(priv, priv->stats_report_len,
+		ret = process_priv->ctrl_ops->setup_stats_report(priv,
+				priv->stats_report_len,
 				priv->stats_report_mem->iova,
 				GVE_STATS_REPORT_TIMER_PERIOD);
 		if (ret != 0) {
-			PMD_DRV_LOG(ERR, "gve_adminq_report_stats command failed.");
+			PMD_DRV_LOG(ERR, "setup_stats_report command failed.");
 			return ret;
 		}
 	}
@@ -467,6 +479,7 @@ gve_dev_start(struct rte_eth_dev *dev)
 static void
 gve_read_nic_clock(void *arg)
 {
+	struct gve_process_private *process_priv;
 	struct gve_priv *priv = arg;
 	uint32_t fails;
 	uint64_t ts;
@@ -475,10 +488,12 @@ gve_read_nic_clock(void *arg)
 	if (!priv || !priv->nic_ts_report_mz)
 		return;
 
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
 	pthread_mutex_lock(&priv->nic_ts_lock);
 	memset(priv->nic_ts_report, 0, sizeof(struct gve_nic_ts_report));
 
-	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+	err = process_priv->ctrl_ops->report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
 	if (err == 0) {
 		ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
 		pthread_mutex_unlock(&priv->nic_ts_lock);
@@ -678,11 +693,14 @@ gve_teardown_flow_subsystem(struct gve_priv *priv)
 static void
 gve_teardown_device_resources(struct gve_priv *priv)
 {
+	struct gve_process_private *process_priv;
 	int err;
 
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
-		err = gve_adminq_deconfigure_device_resources(priv);
+		err = process_priv->ctrl_ops->free_db_resources(priv);
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not deconfigure device resources: err=%d",
@@ -706,11 +724,15 @@ gve_teardown_device_resources(struct gve_priv *priv)
 static int
 gve_dev_close(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	int err = 0;
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		free(dev->process_private);
+		dev->process_private = NULL;
 		return 0;
+	}
 
 	if (dev->data->dev_started) {
 		err = gve_dev_stop(dev);
@@ -723,19 +745,23 @@ gve_dev_close(struct rte_eth_dev *dev)
 
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
+	process_priv->ctrl_ops->free_ctrl_plane(priv);
 
 	pthread_mutex_destroy(&priv->flow_rule_lock);
 	pthread_mutex_destroy(&priv->nic_ts_lock);
 
 	dev->data->mac_addrs = NULL;
 
+	free(dev->process_private);
+	dev->process_private = NULL;
+
 	return err;
 }
 
 static int
 gve_dev_reset(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	int err;
 
@@ -757,7 +783,7 @@ gve_dev_reset(struct rte_eth_dev *dev)
 	 */
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
+	process_priv->ctrl_ops->free_ctrl_plane(priv);
 
 	err = gve_init_priv(priv, true);
 	if (err != 0) {
@@ -953,6 +979,7 @@ gve_dev_stats_reset(struct rte_eth_dev *dev)
 static int
 gve_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	int err;
 
@@ -968,7 +995,7 @@ gve_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EBUSY;
 	}
 
-	err = gve_adminq_set_mtu(priv, mtu);
+	err = process_priv->ctrl_ops->set_mtu(priv, mtu);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to set mtu as %u err = %d", mtu, err);
 		return err;
@@ -1098,6 +1125,7 @@ static int
 gve_rss_hash_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	struct gve_rss_config gve_rss_conf;
 	int rss_reta_size;
@@ -1158,7 +1186,7 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 		memcpy(gve_rss_conf.indir, priv->rss_config.indir,
 			gve_rss_conf.indir_size * sizeof(*priv->rss_config.indir));
 
-	err = gve_adminq_configure_rss(priv, &gve_rss_conf);
+	err = process_priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
 	if (!err)
 		gve_update_priv_rss_config(priv, &gve_rss_conf);
 
@@ -1198,6 +1226,7 @@ static int
 gve_rss_reta_update(struct rte_eth_dev *dev,
 	struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	struct gve_rss_config gve_rss_conf;
 	int table_id;
@@ -1234,7 +1263,7 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 			table_id++;
 	}
 
-	err = gve_adminq_configure_rss(priv, &gve_rss_conf);
+	err = process_priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
 	if (err)
 		PMD_DRV_LOG(ERR, "Problem configuring RSS with device.");
 	else
@@ -1300,6 +1329,7 @@ gve_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
 static int
 gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	uint64_t ts;
 	int err;
@@ -1311,7 +1341,7 @@ gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 		return -EIO;
 
 	pthread_mutex_lock(&priv->nic_ts_lock);
-	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+	err = process_priv->ctrl_ops->report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
 	if (err != 0) {
 		pthread_mutex_unlock(&priv->nic_ts_lock);
 		return err;
@@ -1428,10 +1458,13 @@ gve_setup_nic_timestamp(struct gve_priv *priv)
 static int
 gve_setup_device_resources(struct gve_priv *priv)
 {
+	struct gve_process_private *process_priv;
 	char z_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
 	int err = 0;
 
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
 	snprintf(z_name, sizeof(z_name), "gve_%s_cnt_arr", priv->pci_dev->device.name);
 	mz = rte_memzone_reserve_aligned(z_name,
 					 priv->num_event_counters * sizeof(*priv->cnt_array),
@@ -1457,11 +1490,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 	priv->irq_dbs = (struct gve_irq_db *)mz->addr;
 	priv->irq_dbs_mz = mz;
 
-	err = gve_adminq_configure_device_resources(priv,
-						    priv->cnt_array_mz->iova,
-						    priv->num_event_counters,
-						    priv->irq_dbs_mz->iova,
-						    priv->num_ntfy_blks);
+	err = process_priv->ctrl_ops->get_interrupt_dbs(priv);
 	if (unlikely(err)) {
 		PMD_DRV_LOG(ERR, "Could not config device resources: err=%d", err);
 		goto free_irq_dbs;
@@ -1474,7 +1503,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 			err = -ENOMEM;
 			goto free_irq_dbs;
 		}
-		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
+		err = process_priv->ctrl_ops->get_ptype_map(priv);
 		if (unlikely(err)) {
 			PMD_DRV_LOG(ERR, "Failed to get ptype map: err=%d", err);
 			goto free_ptype_lut;
@@ -1563,21 +1592,59 @@ gve_stop_dev_status_polling(struct rte_eth_dev *dev)
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
+	struct gve_process_private *process_priv;
+	int num_ntfy;
+	int err;
+
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
+	err = process_priv->ctrl_ops->init_ctrl_plane(priv);
 	if (err) {
-		PMD_DRV_LOG(ERR, "Could not verify driver compatibility: err=%d", err);
-		goto free_adminq;
+		PMD_DRV_LOG(ERR, "Failed to alloc control plane: err=%d", err);
+		return err;
 	}
 
 	if (skip_describe_device)
@@ -1587,7 +1654,7 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	gve_set_default_ring_size_bounds(priv);
 
 	/* Get the initial information we need from the device */
-	err = gve_adminq_describe_device(priv);
+	err = process_priv->ctrl_ops->get_device_properties(priv);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Could not get device information: err=%d", err);
 		goto free_adminq;
@@ -1637,7 +1704,7 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	if (!err)
 		return 0;
 free_adminq:
-	gve_adminq_free(priv);
+	process_priv->ctrl_ops->free_ctrl_plane(priv);
 	return err;
 }
 
@@ -1645,13 +1712,21 @@ static int
 gve_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct gve_priv *priv = eth_dev->data->dev_private;
-	int max_tx_queues, max_rx_queues;
+	struct gve_process_private *process_priv;
 	struct rte_pci_device *pci_dev;
 	struct gve_registers *reg_bar;
 	pthread_mutexattr_t mutexattr;
 	rte_be32_t *db_bar;
 	int err;
 
+	process_priv = calloc(1, sizeof(struct gve_process_private));
+	if (!process_priv) {
+		PMD_DRV_LOG(ERR, "Failed to alloc process_private");
+		return -ENOMEM;
+	}
+	process_priv->ctrl_ops = &gve_adminq_ops;
+	eth_dev->process_private = process_priv;
+
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		if (gve_is_gqi(priv)) {
 			gve_set_rx_function(eth_dev);
@@ -1670,28 +1745,25 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	reg_bar = pci_dev->mem_resource[GVE_REG_BAR].addr;
 	if (!reg_bar) {
 		PMD_DRV_LOG(ERR, "Failed to map pci bar!");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_process_priv;
 	}
 
 	db_bar = pci_dev->mem_resource[GVE_DB_BAR].addr;
 	if (!db_bar) {
 		PMD_DRV_LOG(ERR, "Failed to map doorbell bar!");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_process_priv;
 	}
 
 	gve_write_version(&reg_bar->driver_version);
-	/* Get max queues to alloc etherdev */
-	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
-	max_rx_queues = ioread32be(&reg_bar->max_rx_queues);
 
 	priv->reg_bar0 = reg_bar;
 	priv->db_bar2 = db_bar;
 	priv->pci_dev = pci_dev;
+	priv->port_id = eth_dev->data->port_id;
 	priv->state_flags = 0x0;
 
-	priv->max_nb_txq = max_tx_queues;
-	priv->max_nb_rxq = max_rx_queues;
-
 	pthread_mutexattr_init(&mutexattr);
 	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
 	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
@@ -1703,7 +1775,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	if (err) {
 		pthread_mutex_destroy(&priv->flow_rule_lock);
 		pthread_mutex_destroy(&priv->nic_ts_lock);
-		return err;
+		goto free_process_priv;
 	}
 
 	if (gve_is_gqi(priv)) {
@@ -1719,6 +1791,11 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->data->mac_addrs = &priv->dev_addr;
 
 	return 0;
+
+free_process_priv:
+	free(eth_dev->process_private);
+	eth_dev->process_private = NULL;
+	return err;
 }
 
 static int
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..7dbc1753a5 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -272,6 +272,46 @@ struct gve_flow {
 
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
+	int (*free_db_resources)(struct gve_priv *priv);
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
+
+	/* Optional, may be NULL. Callers must check before use. */
+	int (*query_rss)(struct gve_priv *priv);
+};
+
+struct gve_process_private {
+	const struct gve_ctrl_ops *ctrl_ops;
+};
+
 struct gve_priv {
 	struct gve_irq_db *irq_dbs; /* array of num_ntfy_blks */
 	const struct rte_memzone *irq_dbs_mz;
@@ -310,6 +350,7 @@ struct gve_priv {
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
 	rte_be32_t __iomem *db_bar2; /* "array" of doorbells */
 	struct rte_pci_device *pci_dev;
+	uint16_t port_id;
 
 	/* Admin queue - see gve_adminq.h*/
 	union gve_adminq_command *adminq;
diff --git a/drivers/net/gve/gve_flow_rule.c b/drivers/net/gve/gve_flow_rule.c
index 1266e197ea..aec039c32b 100644
--- a/drivers/net/gve/gve_flow_rule.c
+++ b/drivers/net/gve/gve_flow_rule.c
@@ -446,11 +446,14 @@ gve_flow_free_bmp(struct gve_priv *priv)
 int
 gve_free_flow_rules(struct gve_priv *priv)
 {
+	struct gve_process_private *process_priv;
 	struct gve_flow *flow;
 	int err = 0;
 
+	process_priv = rte_eth_devices[priv->port_id].process_private;
+
 	if (!TAILQ_EMPTY(&priv->active_flows)) {
-		err = gve_adminq_reset_flow_rules(priv);
+		err = process_priv->ctrl_ops->reset_flow_rules(priv);
 		if (err) {
 			PMD_DRV_LOG(ERR,
 				"Failed to reset flow rules, internal device err=%d",
@@ -475,6 +478,7 @@ gve_create_flow_rule(struct rte_eth_dev *dev,
 		     const struct rte_flow_action actions[],
 		     struct rte_flow_error *error)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	struct gve_flow_rule_params rule = {0};
 	uint64_t slab_bits = 0;
@@ -516,7 +520,7 @@ gve_create_flow_rule(struct rte_eth_dev *dev,
 		goto free_flow_and_unlock;
 	}
 
-	err = gve_adminq_add_flow_rule(priv, &rule, flow->rule_id);
+	err = process_priv->ctrl_ops->add_flow_rule(priv, &rule, flow->rule_id);
 	if (err) {
 		rte_bitmap_set(priv->avail_flow_rule_bmp, flow->rule_id);
 		rte_flow_error_set(error, -err,
@@ -541,6 +545,7 @@ static int
 gve_destroy_flow_rule(struct rte_eth_dev *dev, struct rte_flow *flow_handle,
 		      struct rte_flow_error *error)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *priv = dev->data->dev_private;
 	struct gve_flow *flow;
 	bool flow_rule_active;
@@ -588,7 +593,7 @@ gve_destroy_flow_rule(struct rte_eth_dev *dev, struct rte_flow *flow_handle,
 		goto unlock;
 	}
 
-	err = gve_adminq_del_flow_rule(priv, flow->rule_id);
+	err = process_priv->ctrl_ops->del_flow_rule(priv, flow->rule_id);
 	if (err) {
 		rte_flow_error_set(error, -err,
 			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index d14902c662..472d8406ba 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -518,6 +518,7 @@ gve_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 void
 gve_stop_rx_queues(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *hw = dev->data->dev_private;
 	uint16_t i;
 	int err;
@@ -525,7 +526,7 @@ gve_stop_rx_queues(struct rte_eth_dev *dev)
 	if (!gve_is_gqi(hw))
 		return gve_stop_rx_queues_dqo(dev);
 
-	err = gve_adminq_destroy_rx_queues(hw, dev->data->nb_rx_queues);
+	err = process_priv->ctrl_ops->destroy_rx_queues(hw, dev->data->nb_rx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy rxqs");
 
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 3665d9e4cd..1f901c5fd4 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -556,11 +556,12 @@ gve_rx_queue_stop_dqo(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 void
 gve_stop_rx_queues_dqo(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *hw = dev->data->dev_private;
 	uint16_t i;
 	int err;
 
-	err = gve_adminq_destroy_rx_queues(hw, dev->data->nb_rx_queues);
+	err = process_priv->ctrl_ops->destroy_rx_queues(hw, dev->data->nb_rx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy rxqs");
 
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index c0400b07bf..568e948daa 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -725,6 +725,7 @@ gve_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 void
 gve_stop_tx_queues(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *hw = dev->data->dev_private;
 	uint16_t i;
 	int err;
@@ -732,7 +733,7 @@ gve_stop_tx_queues(struct rte_eth_dev *dev)
 	if (!gve_is_gqi(hw))
 		return gve_stop_tx_queues_dqo(dev);
 
-	err = gve_adminq_destroy_tx_queues(hw, dev->data->nb_tx_queues);
+	err = process_priv->ctrl_ops->destroy_tx_queues(hw, dev->data->nb_tx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy txqs");
 
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 5c03d3d1a2..0b4d6074ab 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -608,11 +608,12 @@ gve_tx_queue_stop_dqo(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 void
 gve_stop_tx_queues_dqo(struct rte_eth_dev *dev)
 {
+	struct gve_process_private *process_priv = dev->process_private;
 	struct gve_priv *hw = dev->data->dev_private;
 	uint16_t i;
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(hw, dev->data->nb_tx_queues);
+	err = process_priv->ctrl_ops->destroy_tx_queues(hw, dev->data->nb_tx_queues);
 	if (err != 0)
 		PMD_DRV_LOG(WARNING, "failed to destroy txqs");
 
-- 
2.56.0.170.g584c36229d-goog

