Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF3606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E5840E4D;
	Fri, 23 Oct 2026 15:44:29 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3166540E19
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:21 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13F55200020;
 Fri, 23 Oct 2026 15:44:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB9A720002B;
 Fri, 23 Oct 2026 15:44:20 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 548C21800068;
 Fri, 23 Oct 2026 21:44:19 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 26/65] net/dpaa2: program flow table miss actions via
 rte_flow
Date: Fri, 23 Oct 2026 19:13:06 +0530
Message-ID: <20261023134346.37727-27-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Push the per-table "miss" behavior for the DPAA2 QoS and FS tables
through the standard rte_flow_group_set_miss_actions() API instead
of leaving it implicit, and tidy up the surrounding dev-ops code.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 440 +++++++++++++++++--------------
 1 file changed, 243 insertions(+), 197 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7cd83149dd..9f92789d4e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -459,11 +459,52 @@ static const struct rte_eth_stats dpaa2_stats_xstat_ids = {
 #define DPAA2_MAC_XSTATS_START_ID DPAA2_DPNI_XSTAT_MAX_NUM
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
-static int dpaa2_dev_link_update(struct rte_eth_dev *dev,
-				 int wait_to_complete);
-static int dpaa2_dev_set_link_up(struct rte_eth_dev *dev);
-static int dpaa2_dev_set_link_down(struct rte_eth_dev *dev);
-static int dpaa2_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
+
+static int
+dpaa2_setup_table_miss_action(struct rte_eth_dev *eth_dev,
+	uint8_t tc_index)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct rte_flow_group_attr attr;
+	struct rte_flow_action actions[2];
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.ingress = 1;
+	if (tc_index < priv->num_rx_tc) {
+		tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+		if (tbl_profile->default_drop) {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else if (tbl_profile->default_queue.index >= eth_dev->data->nb_rx_queues) {
+			DPAA2_PMD_DEBUG("%s-tc%d-default-rxq(%d) >= max rxq(%d), Force to drop.",
+				eth_dev->data->name, tc_index, tbl_profile->default_queue.index,
+				eth_dev->data->nb_rx_queues);
+			tbl_profile->default_drop = true;
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+			actions[0].conf = &tbl_profile->default_queue;
+		}
+	} else {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		if (tbl_profile->default_drop) {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else if (tbl_profile->default_jump.group >= priv->num_rx_tc) {
+			DPAA2_PMD_DEBUG("%s-default-tc(%d) >= max tc(%d), Force to drop.",
+				eth_dev->data->name, tbl_profile->default_jump.group,
+				priv->num_rx_tc);
+			tbl_profile->default_drop = true;
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+			actions[0].conf = &tbl_profile->default_jump;
+		}
+	}
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	return rte_flow_group_set_miss_actions(eth_dev->data->port_id,
+			tc_index, &attr, actions, NULL);
+}
 
 static int
 dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
@@ -1162,18 +1203,14 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 
 	/* Rx offloads which are enabled by default */
 	if (dev_rx_offloads_nodis & ~rx_offloads) {
-		DPAA2_PMD_INFO(
-		"Some of rx offloads enabled by default - requested 0x%" PRIx64
-		" fixed are 0x%" PRIx64,
-		rx_offloads, dev_rx_offloads_nodis);
+		DPAA2_PMD_INFO("RX offloads requested/fixed: 0x%" PRIx64 "/0x%" PRIx64,
+			rx_offloads, dev_rx_offloads_nodis);
 	}
 
 	/* Tx offloads which are enabled by default */
 	if (dev_tx_offloads_nodis & ~tx_offloads) {
-		DPAA2_PMD_INFO(
-		"Some of tx offloads enabled by default - requested 0x%" PRIx64
-		" fixed are 0x%" PRIx64,
-		tx_offloads, dev_tx_offloads_nodis);
+		DPAA2_PMD_INFO("TX offloads requested/fixed: 0x%" PRIx64 "/0x%" PRIx64,
+			tx_offloads, dev_tx_offloads_nodis);
 	}
 
 	max_rx_pktlen = eth_conf->rxmode.mtu + RTE_ETHER_HDR_LEN +
@@ -1181,16 +1218,31 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	if (max_rx_pktlen <= DPAA2_MAX_RX_PKT_LEN) {
 		ret = dpni_set_max_frame_length(dpni, CMD_PRI_LOW,
 			priv->token, max_rx_pktlen - RTE_ETHER_CRC_LEN);
-		if (ret != 0) {
+		if (ret) {
 			DPAA2_PMD_ERR("Unable to set mtu. check config");
 			return ret;
 		}
 		DPAA2_PMD_DEBUG("MTU configured for the device: %d",
 				dev->data->mtu);
 	} else {
-		DPAA2_PMD_ERR("Configured mtu %d and calculated max-pkt-len is %d which should be <= %d",
-			eth_conf->rxmode.mtu, max_rx_pktlen, DPAA2_MAX_RX_PKT_LEN);
-		return -1;
+		DPAA2_PMD_ERR("MAX MTU(%d) to configure > %d",
+			max_rx_pktlen, DPAA2_MAX_RX_PKT_LEN);
+		return -ENOTSUP;
+	}
+
+	if (priv->fs_entries) {
+		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
+			ret = dpaa2_setup_table_miss_action(dev, tc_index);
+			if (ret) {
+				DPAA2_PMD_ERR("Error(%d) to set miss action of %s-tc%d table",
+					ret, dev->data->name, tc_index);
+			}
+		}
+	}
+	ret = dpaa2_setup_table_miss_action(dev, priv->num_rx_tc);
+	if (ret) {
+		DPAA2_PMD_ERR("Error(%d) to set miss action of %s-QoS table",
+			ret, dev->data->name);
 	}
 
 	if (eth_conf->rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
@@ -1784,6 +1836,171 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
+/* return 0 means link status changed, -1 means not changed */
+static int
+dpaa2_dev_link_update(struct rte_eth_dev *dev,
+	int wait_to_complete)
+{
+	int ret;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = dev->process_private;
+	struct rte_eth_link link;
+	struct dpni_link_state state = {0};
+	uint8_t count;
+
+	if (!dpni) {
+		DPAA2_PMD_ERR("dpni is NULL");
+		return 0;
+	}
+
+	for (count = 0; count <= MAX_REPEAT_TIME; count++) {
+		ret = dpni_get_link_state(dpni, CMD_PRI_LOW, priv->token, &state);
+		if (ret < 0) {
+			DPAA2_PMD_DEBUG("error: dpni_get_link_state %d", ret);
+			return ret;
+		}
+		if (state.up == RTE_ETH_LINK_DOWN &&
+		    wait_to_complete)
+			rte_delay_ms(CHECK_INTERVAL);
+		else
+			break;
+	}
+
+	memset(&link, 0, sizeof(struct rte_eth_link));
+	link.link_status = state.up;
+	link.link_speed = state.rate;
+
+	if (state.options & DPNI_LINK_OPT_HALF_DUPLEX)
+		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+	else
+		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+
+	ret = rte_eth_linkstatus_set(dev, &link);
+	if (ret < 0) {
+		DPAA2_PMD_DEBUG("No change in status");
+	} else {
+		DPAA2_PMD_INFO("Port %d Link is %s", dev->data->port_id,
+			link.link_status ? "Up" : "Down");
+	}
+
+	return ret;
+}
+
+/**
+ * Toggle the DPNI to enable, if not already enabled.
+ * This is not strictly PHY up/down - it is more of logical toggling.
+ */
+static int
+dpaa2_dev_set_link_up(struct rte_eth_dev *dev)
+{
+	int ret, en = 0;
+	struct dpaa2_dev_priv *priv;
+	struct fsl_mc_io *dpni;
+	struct dpni_link_state state = {0};
+
+	priv = dev->data->dev_private;
+	dpni = dev->process_private;
+
+	if (!dpni) {
+		DPAA2_PMD_ERR("dpni is NULL");
+		return -ENODEV;
+	}
+
+	/* Check if DPNI is currently enabled */
+	ret = dpni_is_enabled(dpni, CMD_PRI_LOW, priv->token, &en);
+	if (ret) {
+		/* Unable to obtain dpni status; Not continuing */
+		DPAA2_PMD_ERR("Interface Link UP failed (%d)", ret);
+		return ret;
+	}
+
+	/* Enable link if not already enabled */
+	if (!en) {
+		ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
+		if (ret) {
+			DPAA2_PMD_ERR("Interface Link UP failed (%d)", ret);
+			return ret;
+		}
+	}
+	ret = dpni_get_link_state(dpni, CMD_PRI_LOW, priv->token, &state);
+	if (ret < 0) {
+		DPAA2_PMD_DEBUG("Unable to get link state (%d)", ret);
+		return ret;
+	}
+
+	/* changing tx burst function to start enqueues */
+	dev->tx_pkt_burst = dpaa2_dev_tx;
+	dev->data->dev_link.link_status = state.up;
+	dev->data->dev_link.link_speed = state.rate;
+
+	if (state.options & DPNI_LINK_OPT_HALF_DUPLEX)
+		dev->data->dev_link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+	else
+		dev->data->dev_link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+
+	if (state.up)
+		DPAA2_PMD_DEBUG("Port %d Link is Up", dev->data->port_id);
+	else
+		DPAA2_PMD_DEBUG("Port %d Link is Down", dev->data->port_id);
+	return ret;
+}
+
+/**
+ * Toggle the DPNI to disable, if not already disabled.
+ * This is not strictly PHY up/down - it is more of logical toggling.
+ */
+static int
+dpaa2_dev_set_link_down(struct rte_eth_dev *dev)
+{
+	int ret, dpni_enabled = 0, retries = 10;
+	struct dpaa2_dev_priv *priv;
+	struct fsl_mc_io *dpni;
+
+	PMD_INIT_FUNC_TRACE();
+
+	priv = dev->data->dev_private;
+	dpni = dev->process_private;
+
+	if (!dpni) {
+		DPAA2_PMD_ERR("Device has not yet been configured");
+		return -ENODEV;
+	}
+
+	/*changing  tx burst function to avoid any more enqueues */
+	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+
+	/* Loop while dpni_disable() attempts to drain the egress FQs
+	 * and confirm them back to us.
+	 */
+	do {
+		ret = dpni_disable(dpni, 0, priv->token);
+		if (ret) {
+			DPAA2_PMD_ERR("dpni disable failed (%d)", ret);
+			return ret;
+		}
+		ret = dpni_is_enabled(dpni, 0, priv->token, &dpni_enabled);
+		if (ret) {
+			DPAA2_PMD_ERR("dpni enable check failed (%d)", ret);
+			return ret;
+		}
+		if (dpni_enabled)
+			/* Allow the MC some slack */
+			rte_delay_ms(CHECK_INTERVAL);
+	} while (dpni_enabled && --retries);
+
+	if (!retries) {
+		DPAA2_PMD_WARN("Retry count exceeded disabling dpni");
+		/* todo- we may have to manually cleanup queues.
+		 */
+	} else {
+		DPAA2_PMD_INFO("Port %d Link DOWN successful", dev->data->port_id);
+	}
+
+	dev->data->dev_link.link_status = 0;
+
+	return ret;
+}
+
 /**
  * Dpaa2 link Interrupt handler
  *
@@ -1842,19 +2059,18 @@ dpaa2_eth_setup_irqs(struct rte_eth_dev *dev, int enable)
 
 	PMD_INIT_FUNC_TRACE();
 
-	err = dpni_set_irq_mask(dpni, CMD_PRI_LOW, priv->token,
-				irq_index, mask);
+	err = dpni_set_irq_mask(dpni, CMD_PRI_LOW, priv->token, irq_index, mask);
 	if (err < 0) {
 		DPAA2_PMD_ERR("Error: dpni_set_irq_mask():%d (%s)", err,
-			      strerror(-err));
+			strerror(-err));
 		return err;
 	}
 
-	err = dpni_set_irq_enable(dpni, CMD_PRI_LOW, priv->token,
-				  irq_index, enable);
-	if (err < 0)
+	err = dpni_set_irq_enable(dpni, CMD_PRI_LOW, priv->token, irq_index, enable);
+	if (err < 0) {
 		DPAA2_PMD_ERR("Error: dpni_set_irq_enable():%d (%s)", err,
-			      strerror(-err));
+			strerror(-err));
+	}
 
 	return err;
 }
@@ -2021,8 +2237,7 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 
 		/* Unregistering LSC interrupt handler */
 		rte_intr_callback_unregister(intr_handle,
-					     dpaa2_interrupt_handler,
-					     (void *)dev);
+			dpaa2_interrupt_handler, (void *)dev);
 	}
 
 	dpaa2_dev_set_link_down(dev);
@@ -2233,14 +2448,14 @@ dpaa2_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 
 	if (!dpni) {
 		DPAA2_PMD_ERR("dpni is NULL");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	/* Set the Max Rx frame length as 'mtu' +
 	 * Maximum Ethernet header length
 	 */
 	ret = dpni_set_max_frame_length(dpni, CMD_PRI_LOW, priv->token,
-					frame_size - RTE_ETHER_CRC_LEN);
+			frame_size - RTE_ETHER_CRC_LEN);
 	if (ret) {
 		DPAA2_PMD_ERR("Setting the max frame length failed");
 		return ret;
@@ -2676,175 +2891,6 @@ dpaa2_dev_stats_reset(struct rte_eth_dev *dev)
 	return retcode;
 };
 
-/* return 0 means link status changed, -1 means not changed */
-static int
-dpaa2_dev_link_update(struct rte_eth_dev *dev,
-		      int wait_to_complete)
-{
-	int ret;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = dev->process_private;
-	struct rte_eth_link link;
-	struct dpni_link_state state = {0};
-	uint8_t count;
-
-	if (!dpni) {
-		DPAA2_PMD_ERR("dpni is NULL");
-		return 0;
-	}
-
-	for (count = 0; count <= MAX_REPEAT_TIME; count++) {
-		ret = dpni_get_link_state(dpni, CMD_PRI_LOW, priv->token,
-					  &state);
-		if (ret < 0) {
-			DPAA2_PMD_DEBUG("error: dpni_get_link_state %d", ret);
-			return ret;
-		}
-		if (state.up == RTE_ETH_LINK_DOWN &&
-		    wait_to_complete)
-			rte_delay_ms(CHECK_INTERVAL);
-		else
-			break;
-	}
-
-	memset(&link, 0, sizeof(struct rte_eth_link));
-	link.link_status = state.up;
-	link.link_speed = state.rate;
-
-	if (state.options & DPNI_LINK_OPT_HALF_DUPLEX)
-		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
-	else
-		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-
-	ret = rte_eth_linkstatus_set(dev, &link);
-	if (ret < 0)
-		DPAA2_PMD_DEBUG("No change in status");
-	else
-		DPAA2_PMD_INFO("Port %d Link is %s", dev->data->port_id,
-			       link.link_status ? "Up" : "Down");
-
-	return ret;
-}
-
-/**
- * Toggle the DPNI to enable, if not already enabled.
- * This is not strictly PHY up/down - it is more of logical toggling.
- */
-static int
-dpaa2_dev_set_link_up(struct rte_eth_dev *dev)
-{
-	int ret = -EINVAL;
-	struct dpaa2_dev_priv *priv;
-	struct fsl_mc_io *dpni;
-	int en = 0;
-	struct dpni_link_state state = {0};
-
-	priv = dev->data->dev_private;
-	dpni = dev->process_private;
-
-	if (!dpni) {
-		DPAA2_PMD_ERR("dpni is NULL");
-		return ret;
-	}
-
-	/* Check if DPNI is currently enabled */
-	ret = dpni_is_enabled(dpni, CMD_PRI_LOW, priv->token, &en);
-	if (ret) {
-		/* Unable to obtain dpni status; Not continuing */
-		DPAA2_PMD_ERR("Interface Link UP failed (%d)", ret);
-		return ret;
-	}
-
-	/* Enable link if not already enabled */
-	if (!en) {
-		ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
-		if (ret) {
-			DPAA2_PMD_ERR("Interface Link UP failed (%d)", ret);
-			return ret;
-		}
-	}
-	ret = dpni_get_link_state(dpni, CMD_PRI_LOW, priv->token, &state);
-	if (ret < 0) {
-		DPAA2_PMD_DEBUG("Unable to get link state (%d)", ret);
-		return ret;
-	}
-
-	/* changing tx burst function to start enqueues */
-	dev->tx_pkt_burst = dpaa2_dev_tx;
-	dev->data->dev_link.link_status = state.up;
-	dev->data->dev_link.link_speed = state.rate;
-
-	if (state.options & DPNI_LINK_OPT_HALF_DUPLEX)
-		dev->data->dev_link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
-	else
-		dev->data->dev_link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-
-	if (state.up)
-		DPAA2_PMD_DEBUG("Port %d Link is Up", dev->data->port_id);
-	else
-		DPAA2_PMD_DEBUG("Port %d Link is Down", dev->data->port_id);
-	return ret;
-}
-
-/**
- * Toggle the DPNI to disable, if not already disabled.
- * This is not strictly PHY up/down - it is more of logical toggling.
- */
-static int
-dpaa2_dev_set_link_down(struct rte_eth_dev *dev)
-{
-	int ret = -EINVAL;
-	struct dpaa2_dev_priv *priv;
-	struct fsl_mc_io *dpni;
-	int dpni_enabled = 0;
-	int retries = 10;
-
-	PMD_INIT_FUNC_TRACE();
-
-	priv = dev->data->dev_private;
-	dpni = dev->process_private;
-
-	if (!dpni) {
-		DPAA2_PMD_ERR("Device has not yet been configured");
-		return ret;
-	}
-
-	/*changing  tx burst function to avoid any more enqueues */
-	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
-
-	/* Loop while dpni_disable() attempts to drain the egress FQs
-	 * and confirm them back to us.
-	 */
-	do {
-		ret = dpni_disable(dpni, 0, priv->token);
-		if (ret) {
-			DPAA2_PMD_ERR("dpni disable failed (%d)", ret);
-			return ret;
-		}
-		ret = dpni_is_enabled(dpni, 0, priv->token, &dpni_enabled);
-		if (ret) {
-			DPAA2_PMD_ERR("dpni enable check failed (%d)", ret);
-			return ret;
-		}
-		if (dpni_enabled)
-			/* Allow the MC some slack */
-			rte_delay_ms(CHECK_INTERVAL);
-	} while (dpni_enabled && --retries);
-
-	if (!retries) {
-		DPAA2_PMD_WARN("Retry count exceeded disabling dpni");
-		/* todo- we may have to manually cleanup queues.
-		 */
-	} else {
-		DPAA2_PMD_INFO("Port %d Link DOWN successful",
-			       dev->data->port_id);
-	}
-
-	dev->data->dev_link.link_status = 0;
-
-	return ret;
-}
-
 static int
 dpaa2_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
-- 
2.43.0

