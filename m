Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF305C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72BB540E11;
	Wed, 28 May 2025 12:39:49 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2323B40B9C
 for <dev@dpdk.org>; Wed, 28 May 2025 12:39:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 02AF420119E;
 Wed, 28 May 2025 12:39:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71BD520119F;
 Wed, 28 May 2025 12:39:40 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D1A441800083;
 Wed, 28 May 2025 18:39:39 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [v1 09/10] bus/dpaa: improve DPAA cleanup
Date: Wed, 28 May 2025 16:09:33 +0530
Message-Id: <20250528103934.1001747-10-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Gagandeep Singh <g.singh@nxp.com>

This patch addresses DPAA driver issues with the introduction of
rte_eal_cleanup, which caused driver-specific destructors to fail
due to memory cleanup.
To resolve this, we remove the driver destructor and relocate the
code to the bus cleanup function.

So, this patch also implements DPAA bus cleanup.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
 drivers/bus/dpaa/dpaa_bus.c               |  58 ++++++
 drivers/net/dpaa/dpaa_ethdev.c            | 217 ++++++++++++++++------
 3 files changed, 215 insertions(+), 62 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index 7a129a2d86..cdce6b777b 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -228,8 +228,6 @@ int fsl_qman_fq_portal_destroy(struct qman_portal *qp)
 	if (ret)
 		pr_err("qman_free_global_portal() (%d)\n", ret);
 
-	kfree(qp);
-
 	process_portal_irq_unmap(cfg->irq);
 
 	addr.cena = cfg->addr_virt[DPAA_PORTAL_CE];
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 7abc2235e7..4d7e7ea3df 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -63,6 +63,9 @@ static struct netcfg_info *dpaa_netcfg;
 
 /* define a variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa_portal_key;
+/* dpaa lcore specific  portals */
+struct dpaa_portal *dpaa_portals[RTE_MAX_LCORE] = {NULL};
+static int dpaa_bus_global_init;
 
 #define FSL_DPAA_BUS_NAME	dpaa_bus
 
@@ -402,6 +405,7 @@ int rte_dpaa_portal_init(void *arg)
 
 		return ret;
 	}
+	dpaa_portals[lcore] = DPAA_PER_LCORE_PORTAL;
 
 	DPAA_BUS_LOG(DEBUG, "QMAN thread initialized");
 
@@ -461,6 +465,8 @@ dpaa_portal_finish(void *arg)
 	rte_free(dpaa_io_portal);
 	dpaa_io_portal = NULL;
 	DPAA_PER_LCORE_PORTAL = NULL;
+	dpaa_portals[rte_lcore_id()] = NULL;
+	DPAA_BUS_DEBUG("Portal cleanup done for lcore = %d", rte_lcore_id());
 }
 
 static int
@@ -771,6 +777,7 @@ rte_dpaa_bus_probe(void)
 			break;
 		}
 	}
+	dpaa_bus_global_init = 1;
 
 	return 0;
 }
@@ -878,6 +885,56 @@ dpaa_bus_dev_iterate(const void *start, const char *str,
 	return NULL;
 }
 
+static int
+dpaa_bus_cleanup(void)
+{
+	struct rte_dpaa_device *dev, *tmp_dev;
+
+	BUS_INIT_FUNC_TRACE();
+	RTE_TAILQ_FOREACH_SAFE(dev, &s_rte_dpaa_bus.device_list, next, tmp_dev) {
+		struct rte_dpaa_driver *drv = dev->driver;
+		int ret = 0;
+
+		if (!rte_dev_is_probed(&dev->device))
+			continue;
+		if (!drv || !drv->remove)
+			continue;
+		ret = drv->remove(dev);
+		if (ret < 0) {
+			rte_errno = errno;
+			return -1;
+		}
+		dev->driver = NULL;
+		dev->device.driver = NULL;
+	}
+	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
+	dpaa_bus_global_init = 0;
+	DPAA_BUS_DEBUG("Bus cleanup done");
+
+	return 0;
+}
+
+/* Adding destructor for double check in case non-gracefully
+ * exit.
+ */
+static void __attribute__((destructor(102)))
+dpaa_cleanup(void)
+{
+	unsigned int lcore_id;
+
+	if (!dpaa_bus_global_init)
+		return;
+
+	/* cleanup portals in case non-gracefull exit */
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		/* Check for non zero id */
+		dpaa_portal_finish((void *)dpaa_portals[lcore_id]);
+	}
+	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
+	dpaa_bus_global_init = 0;
+	DPAA_BUS_DEBUG("Worker thread clean up done");
+}
+
 static struct rte_dpaa_bus s_rte_dpaa_bus = {
 	.bus = {
 		.scan = rte_dpaa_bus_scan,
@@ -888,6 +945,7 @@ static struct rte_dpaa_bus s_rte_dpaa_bus = {
 		.plug = dpaa_bus_plug,
 		.unplug = dpaa_bus_unplug,
 		.dev_iterate = dpaa_bus_dev_iterate,
+		.cleanup = dpaa_bus_cleanup,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(s_rte_dpaa_bus.device_list),
 	.driver_list = TAILQ_HEAD_INITIALIZER(s_rte_dpaa_bus.driver_list),
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 62cafb7073..85122c24b3 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -310,11 +310,12 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 	}
 
 	if (!(default_q || fmc_q)) {
-		if (dpaa_fm_config(dev,
-			eth_conf->rx_adv_conf.rss_conf.rss_hf)) {
+		ret = dpaa_fm_config(dev,
+			eth_conf->rx_adv_conf.rss_conf.rss_hf);
+		if (ret) {
 			dpaa_write_fm_config_to_file();
-			DPAA_PMD_ERR("FM port configuration: Failed");
-			return -1;
+			DPAA_PMD_ERR("FM port configuration: Failed(%d)", ret);
+			return ret;
 		}
 		dpaa_write_fm_config_to_file();
 	}
@@ -517,6 +518,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	struct rte_intr_handle *intr_handle;
 	struct rte_eth_link *link = &dev->data->dev_link;
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	struct qman_fq *fq;
 	int loop;
 	int ret;
 
@@ -526,14 +528,17 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		return 0;
 
 	if (!dpaa_intf) {
-		DPAA_PMD_WARN("Already closed or not started");
-		return -1;
+		DPAA_PMD_DEBUG("Already closed or not started");
+		return -ENOENT;
 	}
 
 	/* DPAA FM deconfig */
 	if (!(default_q || fmc_q)) {
-		if (dpaa_fm_deconfig(dpaa_intf, dev->process_private))
-			DPAA_PMD_WARN("DPAA FM deconfig failed");
+		ret = dpaa_fm_deconfig(dpaa_intf, dev->process_private);
+		if (ret) {
+			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
+				dev->data->name, ret);
+		}
 	}
 
 	dpaa_dev = container_of(rdev, struct rte_dpaa_device, device);
@@ -541,21 +546,37 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	__fif = container_of(fif, struct __fman_if, __if);
 
 	ret = dpaa_eth_dev_stop(dev);
+	if (ret) {
+		DPAA_PMD_WARN("%s: stop device failed(%d)",
+			dev->data->name, ret);
+	}
 
 	if (fif->mac_type == fman_offline_internal ||
 	    fif->mac_type == fman_onic)
 		return 0;
 
 	/* Reset link to autoneg */
-	if (link->link_status && !link->link_autoneg)
-		dpaa_restart_link_autoneg(__fif->node_name);
+	if (link->link_status && !link->link_autoneg) {
+		ret = dpaa_restart_link_autoneg(__fif->node_name);
+		if (ret) {
+			DPAA_PMD_WARN("%s: restart link failed(%d)",
+				dev->data->name, ret);
+		}
+	}
 
 	if (intr_handle && rte_intr_fd_get(intr_handle) &&
 	    dev->data->dev_conf.intr_conf.lsc != 0) {
-		dpaa_intr_disable(__fif->node_name);
-		rte_intr_callback_unregister(intr_handle,
-					     dpaa_interrupt_handler,
-					     (void *)dev);
+		ret = dpaa_intr_disable(__fif->node_name);
+		if (ret) {
+			DPAA_PMD_WARN("%s: disable interrupt failed(%d)",
+				dev->data->name, ret);
+		}
+		ret = rte_intr_callback_unregister(intr_handle,
+			dpaa_interrupt_handler, (void *)dev);
+		if (ret) {
+			DPAA_PMD_WARN("%s: unregister interrupt failed(%d)",
+				dev->data->name, ret);
+		}
 	}
 
 	/* release configuration memory */
@@ -563,33 +584,60 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
-		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++)
-			qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
+		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+			ret = qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
+			if (ret) {
+				DPAA_PMD_WARN("%s: delete rxq%d's cgr err(%d)",
+					dev->data->name, loop, ret);
+			}
+		}
 		rte_free(dpaa_intf->cgr_rx);
 		dpaa_intf->cgr_rx = NULL;
 	}
 
 	/* Release TX congestion Groups */
 	if (dpaa_intf->cgr_tx) {
-		for (loop = 0; loop < MAX_DPAA_CORES; loop++)
-			qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
+		for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
+			ret = qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
+			if (ret) {
+				DPAA_PMD_WARN("%s: delete txq%d's cgr err(%d)",
+					dev->data->name, loop, ret);
+			}
+		}
 		rte_free(dpaa_intf->cgr_tx);
 		dpaa_intf->cgr_tx = NULL;
 	}
 
+	/* Freeing queue specific portals */
+	for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+		if (!dpaa_intf->rx_queues)
+			break;
+
+		fq = &dpaa_intf->rx_queues[loop];
+		if (fq->qp_initialized) {
+			rte_dpaa_portal_fq_close(fq);
+			fq->qp_initialized = 0;
+		}
+	}
+
 	rte_free(dpaa_intf->rx_queues);
 	dpaa_intf->rx_queues = NULL;
 
 	rte_free(dpaa_intf->tx_queues);
 	dpaa_intf->tx_queues = NULL;
 	if (dpaa_intf->port_handle) {
-		if (dpaa_fm_deconfig(dpaa_intf, fif))
-			DPAA_PMD_WARN("DPAA FM "
-				"deconfig failed");
+		ret = dpaa_fm_deconfig(dpaa_intf, fif);
+		if (ret) {
+			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
+				dev->data->name, ret);
+		}
 	}
 	if (fif->num_profiles) {
-		if (dpaa_port_vsp_cleanup(dpaa_intf, fif))
-			DPAA_PMD_WARN("DPAA FM vsp cleanup failed");
+		ret = dpaa_port_vsp_cleanup(dpaa_intf, fif);
+		if (ret) {
+			DPAA_PMD_WARN("%s: cleanup VSP failed(%d)",
+				dev->data->name, ret);
+		}
 	}
 
 	return ret;
@@ -1462,6 +1510,8 @@ dpaa_flow_ctrl_set(struct rte_eth_dev *dev,
 {
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
 	struct rte_eth_fc_conf *net_fc;
+	struct fman_if *fm_if = dev->process_private;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1480,19 +1530,31 @@ dpaa_flow_ctrl_set(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	if (fc_conf->mode == RTE_ETH_FC_NONE) {
+	if (fc_conf->mode == RTE_ETH_FC_NONE)
 		return 0;
-	} else if (fc_conf->mode == RTE_ETH_FC_TX_PAUSE ||
-		 fc_conf->mode == RTE_ETH_FC_FULL) {
-		fman_if_set_fc_threshold(dev->process_private,
+
+	if (fc_conf->mode != RTE_ETH_FC_TX_PAUSE &&
+		fc_conf->mode != RTE_ETH_FC_FULL)
+		goto save_fc;
+
+	ret = fman_if_set_fc_threshold(fm_if,
 					 fc_conf->high_water,
 					 fc_conf->low_water,
 					 dpaa_intf->bp_info->bpid);
-		if (fc_conf->pause_time)
-			fman_if_set_fc_quanta(dev->process_private,
-					      fc_conf->pause_time);
+	if (ret) {
+		DPAA_PMD_ERR("Set %s's fc on bpid(%d) err(%d)",
+				dev->data->name, dpaa_intf->bp_info->bpid,
+				ret);
+	}
+	if (fc_conf->pause_time) {
+		ret = fman_if_set_fc_quanta(fm_if, fc_conf->pause_time);
+		if (ret) {
+			DPAA_PMD_ERR("Set %s's fc pause time err(%d)",
+				dev->data->name, ret);
+		}
 	}
 
+save_fc:
 	/* Save the information in dpaa device */
 	net_fc->pause_time = fc_conf->pause_time;
 	net_fc->high_water = fc_conf->high_water;
@@ -1619,13 +1681,15 @@ dpaa_dev_rss_hash_update(struct rte_eth_dev *dev,
 {
 	struct rte_eth_dev_data *data = dev->data;
 	struct rte_eth_conf *eth_conf = &data->dev_conf;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
 	if (!(default_q || fmc_q)) {
-		if (dpaa_fm_config(dev, rss_conf->rss_hf)) {
-			DPAA_PMD_ERR("FM port configuration: Failed");
-			return -1;
+		ret = dpaa_fm_config(dev, rss_conf->rss_hf);
+		if (ret) {
+			DPAA_PMD_ERR("FM port configuration: Failed(%d)", ret);
+			return ret;
 		}
 		eth_conf->rx_adv_conf.rss_conf.rss_hf = rss_conf->rss_hf;
 	} else {
@@ -2233,8 +2297,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	/* Each device can not have more than DPAA_MAX_NUM_PCD_QUEUES RX
 	 * queues.
 	 */
-	if (num_rx_fqs < 0 || num_rx_fqs > DPAA_MAX_NUM_PCD_QUEUES) {
-		DPAA_PMD_ERR("Invalid number of RX queues");
+	if (num_rx_fqs > DPAA_MAX_NUM_PCD_QUEUES) {
+		DPAA_PMD_ERR("Invalid number of RX queues(%d)", num_rx_fqs);
 		return -EINVAL;
 	}
 
@@ -2494,8 +2558,8 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 		eth_dev->dev_ops = &dpaa_devops;
 
 		ret = dpaa_dev_init_secondary(eth_dev);
-		if (ret != 0) {
-			DPAA_PMD_ERR("secondary dev init failed");
+		if (ret) {
+			DPAA_PMD_ERR("secondary dev init failed(%d)", ret);
 			return ret;
 		}
 
@@ -2510,9 +2574,10 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 		}
 
 		if (!(default_q || fmc_q)) {
-			if (dpaa_fm_init()) {
-				DPAA_PMD_ERR("FM init failed");
-				return -1;
+			ret = dpaa_fm_init();
+			if (ret) {
+				DPAA_PMD_ERR("FM init failed(%d)", ret);
+				return ret;
 			}
 		}
 
@@ -2587,39 +2652,71 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 	return diag;
 }
 
-static int
-rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
+/* Adding destructor for double check in case non-gracefully
+ * exit.
+ */
+static void __attribute__((destructor(103)))
+dpaa_finish(void)
 {
-	struct rte_eth_dev *eth_dev;
-	int ret;
+	struct dpaa_if *dpaa_intf;
+	int loop;
+	struct qman_fq *fq;
+	uint16_t portid;
+	struct rte_eth_dev *dev;
 
 	PMD_INIT_FUNC_TRACE();
-
-	eth_dev = dpaa_dev->eth_dev;
-	dpaa_eth_dev_close(eth_dev);
-	dpaa_valid_dev--;
-	if (!dpaa_valid_dev)
-		rte_mempool_free(dpaa_tx_sg_pool);
-	ret = rte_eth_dev_release_port(eth_dev);
-
-	return ret;
-}
-
-static void __attribute__((destructor(102))) dpaa_finish(void)
-{
 	/* For secondary, primary will do all the cleanup */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return;
 
+	if (!is_global_init)
+		return;
+
 	if (!(default_q || fmc_q)) {
-		if (is_global_init)
 			if (dpaa_fm_term())
 				DPAA_PMD_WARN("DPAA FM term failed");
 
-		is_global_init = 0;
-
 		DPAA_PMD_INFO("DPAA fman cleaned up");
 	}
+
+	RTE_ETH_FOREACH_DEV(portid) {
+		dev = &rte_eth_devices[portid];
+		if (strcmp(dev->device->driver->name,
+			rte_dpaa_pmd.driver.name))
+			continue;
+		dpaa_intf = dev->data->dev_private;
+		/* Freeing queue specific portals */
+		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+			if (!dpaa_intf->rx_queues)
+				break;
+
+			fq = &dpaa_intf->rx_queues[loop];
+			if (fq->qp_initialized) {
+				rte_dpaa_portal_fq_close(fq);
+				fq->qp_initialized = 0;
+			}
+		}
+	}
+	is_global_init = 0;
+}
+
+static int
+rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
+{
+	struct rte_eth_dev *eth_dev;
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	eth_dev = dpaa_dev->eth_dev;
+	dpaa_eth_dev_close(eth_dev);
+	ret = rte_eth_dev_release_port(eth_dev);
+	dpaa_valid_dev--;
+	if (!dpaa_valid_dev) {
+		rte_mempool_free(dpaa_tx_sg_pool);
+		dpaa_finish();
+	}
+	return ret;
 }
 
 static struct rte_dpaa_driver rte_dpaa_pmd = {
-- 
2.25.1

