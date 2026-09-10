Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5533CC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B386142E89;
	Thu, 10 Sep 2026 15:52:52 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 40C2842E5C
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:40 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22A5E200026;
 Thu, 10 Sep 2026 15:52:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7AB6200035;
 Thu, 10 Sep 2026 15:52:39 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 481BC18000B5;
 Thu, 10 Sep 2026 21:52:38 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 32/47] net/dpaa2: ptp enhancements
Date: Thu, 10 Sep 2026 19:21:43 +0530
Message-ID: <20260910135158.2181141-33-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

1) Correct TX timestamp only for PTP sync packets.
2) Runtime configure TX timestamp offset by parsing current TX
   PTP packet format.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c |  92 ++----------------
 drivers/net/dpaa2/dpaa2_ethdev.h |  26 +++++
 drivers/net/dpaa2/dpaa2_ptp.c    | 161 +++++++++++++++++++++++++------
 drivers/net/dpaa2/dpaa2_rxtx.c   |  78 ++++++++++++++-
 4 files changed, 239 insertions(+), 118 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 61b7ae138c..58b4cedee3 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -72,11 +72,6 @@ static uint64_t dev_tx_offloads_sup =
 static uint64_t dev_tx_offloads_nodis =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
-/* enable timestamp in mbuf */
-bool dpaa2_enable_ts[RTE_MAX_ETHPORTS];
-uint64_t dpaa2_timestamp_rx_dynflag;
-int dpaa2_timestamp_dynfield_offset = -1;
-
 bool dpaa2_print_parser_result;
 
 /* Rx descriptor limit when DPNI loads PFDRs in PEB */
@@ -730,9 +725,6 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	int tx_l4_csum_offload = false;
 	int ret, tc_index;
 	uint32_t max_rx_pktlen;
-#if defined(RTE_LIBRTE_IEEE1588)
-	uint16_t ptp_correction_offset;
-#endif
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -814,25 +806,15 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 		return ret;
 	}
 
-#if !defined(RTE_LIBRTE_IEEE1588)
-	if (rx_offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
-#endif
-	{
-		ret = rte_mbuf_dyn_rx_timestamp_register(
-				&dpaa2_timestamp_dynfield_offset,
-				&dpaa2_timestamp_rx_dynflag);
-		if (ret != 0) {
+	if (rx_offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+		ret = rte_mbuf_dyn_rx_timestamp_register(&priv->rx_ts_offset,
+			&priv->rx_ts_flag);
+		if (ret) {
 			DPAA2_PMD_ERR("Error to register timestamp field/flag");
-			return -rte_errno;
+			return ret;
 		}
-		dpaa2_enable_ts[dev->data->port_id] = true;
 	}
 
-#if defined(RTE_LIBRTE_IEEE1588)
-	/* By default setting ptp correction offset for Ethernet SYNC packets */
-	ptp_correction_offset = RTE_ETHER_HDR_LEN + 8;
-	rte_pmd_dpaa2_set_one_step_ts(dev->data->port_id, ptp_correction_offset, 0);
-#endif
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
 		tx_l3_csum_offload = true;
 
@@ -3315,8 +3297,6 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
-	.mtr_ops_get	      = dpaa2_mtr_ops_get,
-#if defined(RTE_LIBRTE_IEEE1588)
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
 	.timesync_read_time   = dpaa2_timesync_read_time,
@@ -3324,7 +3304,7 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.timesync_adjust_time = dpaa2_timesync_adjust_time,
 	.timesync_read_rx_timestamp = dpaa2_timesync_read_rx_timestamp,
 	.timesync_read_tx_timestamp = dpaa2_timesync_read_tx_timestamp,
-#endif
+	.mtr_ops_get	      = dpaa2_mtr_ops_get,
 };
 
 /* Populate the mac address from physically available (u-boot/firmware) and/or
@@ -3589,11 +3569,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->options = attr.options;
 	priv->max_mac_filters = attr.mac_filter_entries;
 	priv->max_vlan_filters = attr.vlan_filter_entries;
-	priv->flags = 0;
-#if defined(RTE_LIBRTE_IEEE1588)
-	DPAA2_PMD_INFO("DPDK IEEE1588 is enabled");
-	priv->flags |= DPAA2_TX_CONF_ENABLE;
-#endif
 	priv->tx_conf_type = DPAA2_TX_NO_CONF;
 
 	/* Used with ``fslmc:dpni.1,drv_tx_conf=1`` */
@@ -3803,61 +3778,6 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 	return priv->ep_name;
 }
 
-#if defined(RTE_LIBRTE_IEEE1588)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_one_step_ts, 24.11)
-int
-rte_pmd_dpaa2_get_one_step_ts(uint16_t port_id, bool mc_query)
-{
-	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = priv->eth_dev->process_private;
-	struct dpni_single_step_cfg ptp_cfg;
-	int err;
-
-	if (!mc_query)
-		return priv->ptp_correction_offset;
-
-	err = dpni_get_single_step_cfg(dpni, CMD_PRI_LOW, priv->token, &ptp_cfg);
-	if (err) {
-		DPAA2_PMD_ERR("Failed to retrieve onestep configuration");
-		return err;
-	}
-
-	if (!ptp_cfg.ptp_onestep_reg_base) {
-		DPAA2_PMD_ERR("1588 onestep reg not available");
-		return -1;
-	}
-
-	priv->ptp_correction_offset = ptp_cfg.offset;
-
-	return priv->ptp_correction_offset;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_set_one_step_ts, 24.11)
-int
-rte_pmd_dpaa2_set_one_step_ts(uint16_t port_id, uint16_t offset, uint8_t ch_update)
-{
-	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = dev->process_private;
-	struct dpni_single_step_cfg cfg;
-	int err;
-
-	cfg.en = 1;
-	cfg.ch_update = ch_update;
-	cfg.offset = offset;
-	cfg.peer_delay = 0;
-
-	err = dpni_set_single_step_cfg(dpni, CMD_PRI_LOW, priv->token, &cfg);
-	if (err)
-		return err;
-
-	priv->ptp_correction_offset = offset;
-
-	return 0;
-}
-#endif
-
 static int dpaa2_tx_sg_pool_init(void)
 {
 	char name[RTE_MEMZONE_NAMESIZE];
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index c9b7a8ae17..33195f0584 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -8,6 +8,9 @@
 #ifndef _DPAA2_ETHDEV_H
 #define _DPAA2_ETHDEV_H
 
+#include <rte_time.h>
+#include <rte_log.h>
+#include <rte_string_fns.h>
 #include <rte_compat.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_pmd_dpaa2.h>
@@ -101,6 +104,11 @@
 
 #define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(12)
 
+#define DPAA2_IEEE1588_DEBUG_FLAG RTE_BIT32(13)
+
+#define DPAA2_IEEE1588_TX_TS_FLAG RTE_BIT32(14)
+#define DPAA2_IEEE1588_RX_TS_FLAG RTE_BIT32(15)
+
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
@@ -589,6 +597,21 @@ dpaa2_dev_rx_print_parser_result(struct dpaa2_dev_priv *priv,
 	}
 }
 
+static inline void
+dpaa2_timestamp_debug(struct dpaa2_dev_priv *priv,
+	const char *prefix, uint64_t timestamp)
+{
+	struct timespec ts;
+
+	if (likely(!(priv->flags & DPAA2_IEEE1588_DEBUG_FLAG)))
+		return;
+
+	ts = rte_ns_to_timespec(timestamp);
+	fprintf(rte_log_get_stream(),
+		"DPAA2 TS DBG: %s: ns(%" PRIu64 ")->%ld seconds/%ld nanoseconds\n",
+		prefix, timestamp, ts.tv_sec, ts.tv_nsec);
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
@@ -651,6 +674,9 @@ void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
 void dpaa2_flow_clean(struct rte_eth_dev *dev);
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
 
+void
+dpaa2_dev_tx_ptp_one_step_runtime(struct rte_eth_dev *dev,
+	struct rte_mbuf *buf, int *tstamp, int *set);
 int dpaa2_timesync_enable(struct rte_eth_dev *dev);
 int dpaa2_timesync_disable(struct rte_eth_dev *dev);
 int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index c845291c68..171d8025e7 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2019, 2023 NXP
+ * Copyright 2019, 2023-2026 NXP
  */
 
 #include <sys/queue.h>
@@ -22,6 +22,7 @@
 
 #include <dpaa2_ethdev.h>
 #include <dpaa2_pmd_logs.h>
+#include <dpaax_ptp.h>
 
 struct dpaa2_dprtc_dev {
 	struct fsl_mc_io dprtc;  /** handle to DPRTC portal object */
@@ -30,52 +31,144 @@ struct dpaa2_dprtc_dev {
 };
 static struct dpaa2_dprtc_dev *dprtc_dev;
 
-int dpaa2_timesync_enable(struct rte_eth_dev *dev __rte_unused)
+static int
+dpaa2_timesync_set_one_step(struct rte_eth_dev *dev,
+	uint16_t offset, int udp)
 {
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = dev->process_private;
+	struct dpni_single_step_cfg cfg;
+	int err;
+
+	memset(&cfg, 0, sizeof(struct dpni_single_step_cfg));
+	cfg.en = 1;
+	cfg.ch_update = udp;
+	cfg.offset = offset;
+	cfg.peer_delay = 0;
+
+	err = dpni_set_single_step_cfg(dpni, CMD_PRI_LOW, priv->token, &cfg);
+	if (err)
+		return err;
+
+	priv->ptp_correction_offset = offset;
+
 	return 0;
 }
 
-int dpaa2_timesync_disable(struct rte_eth_dev *dev __rte_unused)
+void
+dpaa2_dev_tx_ptp_one_step_runtime(struct rte_eth_dev *dev,
+	struct rte_mbuf *buf, int *tstamp, int *set)
 {
+	uint16_t ts_offset;
+	int is_udp = false, ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	if (tstamp)
+		*tstamp = false;
+	if (set)
+		*set = false;
+
+	if (!dpaax_timesync_ptp_parse_header(buf,
+		&ts_offset, &is_udp)) {
+		DPAA2_PMD_WARN("Tx packet is not PTP frame.");
+		ret = -EINVAL;
+	} else {
+		if (ts_offset != priv->ptp_correction_offset) {
+			ret = dpaa2_timesync_set_one_step(dev, ts_offset, is_udp);
+			if (ret) {
+				DPAA2_PMD_WARN("Change one step failed(%d)", ret);
+			} else {
+				DPAA2_PMD_INFO("Change one step from offset %d to %d",
+					priv->ptp_correction_offset, ts_offset);
+				priv->ptp_correction_offset = ts_offset;
+				if (set)
+					*set = true;
+			}
+		}
+	}
+
+	if (!ret && tstamp)
+		*tstamp = true;
+}
+
+int dpaa2_timesync_enable(struct rte_eth_dev *dev)
+{
+	uint16_t default_offset;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret;
+
+	default_offset = RTE_ETHER_HDR_LEN +
+		offsetof(struct rte_dpaax_ptp_header, correction);
+
+	ret = dpaa2_timesync_set_one_step(dev, default_offset, false);
+	if (ret) {
+		DPAA2_PMD_ERR("%s one step timesyc set failed(%d)",
+			dev->data->name, ret);
+	} else {
+		priv->flags |= DPAA2_IEEE1588_TX_TS_FLAG;
+	}
+	priv->flags |= DPAA2_IEEE1588_RX_TS_FLAG;
+	if (priv->tx_conf_type == DPAA2_TX_NO_CONF) {
+		DPAA2_PMD_WARN("%s Unable to read TX timestamp",
+			dev->data->name);
+	}
+	if (getenv("DPAA2_IEEE1588_DEBUG_ENABLE"))
+		priv->flags |= DPAA2_IEEE1588_DEBUG_FLAG;
+
+	return 0;
+}
+
+int dpaa2_timesync_disable(struct rte_eth_dev *dev)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	priv->ptp_correction_offset = 0;
+	priv->flags &= ~DPAA2_IEEE1588_RX_TS_FLAG;
+	priv->flags &= ~DPAA2_IEEE1588_TX_TS_FLAG;
 	return 0;
 }
 
 int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
-					struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	uint64_t ns;
 	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	RTE_SET_USED(dev);
+	if (!dprtc_dev)
+		return -ENODEV;
 
 	ret = dprtc_get_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, &ns);
+			dprtc_dev->token, &ns);
 	if (ret) {
 		DPAA2_PMD_ERR("dprtc_get_time failed ret: %d", ret);
 		return ret;
 	}
 
 	*timestamp = rte_ns_to_timespec(ns);
+	dpaa2_timestamp_debug(priv, __func__, ns);
 
 	return 0;
 }
 
 int dpaa2_timesync_write_time(struct rte_eth_dev *dev,
-					const struct timespec *ts)
+	const struct timespec *ts)
 {
 	uint64_t ns;
 	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	RTE_SET_USED(dev);
+	if (!dprtc_dev)
+		return -ENODEV;
 
 	ns = rte_timespec_to_ns(ts);
-
 	ret = dprtc_set_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, ns);
+			dprtc_dev->token, ns);
 	if (ret) {
 		DPAA2_PMD_ERR("dprtc_set_time failed ret: %d", ret);
 		return ret;
 	}
+	dpaa2_timestamp_debug(priv, __func__, ns);
 
 	return 0;
 }
@@ -84,11 +177,13 @@ int dpaa2_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 {
 	uint64_t ns;
 	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	RTE_SET_USED(dev);
+	if (!dprtc_dev)
+		return -ENODEV;
 
 	ret = dprtc_get_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, &ns);
+			dprtc_dev->token, &ns);
 	if (ret) {
 		DPAA2_PMD_ERR("dprtc_get_time failed ret: %d", ret);
 		return ret;
@@ -102,64 +197,73 @@ int dpaa2_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 		DPAA2_PMD_ERR("dprtc_set_time failed ret: %d", ret);
 		return ret;
 	}
+	dpaa2_timestamp_debug(priv, "adjust delata", delta);
+	dpaa2_timestamp_debug(priv, "adjust absolute", ns);
 
 	return 0;
 }
 
 int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	if (priv->next_txq_to_cnf) {
-		while (!priv->tx_timestamp)
-			dpaa2_dev_tx_conf(priv->next_txq_to_cnf, false);
-	} else {
-		return -1;
-	}
+	if (!(priv->flags & DPAA2_IEEE1588_TX_TS_FLAG) ||
+		priv->tx_conf_type == DPAA2_TX_NO_CONF)
+		return -EINVAL;
+
+	while (priv->next_txq_to_cnf &&
+		priv->next_txq_to_cnf->ts_to_cnfd > 0)
+		dpaa2_dev_tx_conf(priv->next_txq_to_cnf, false);
+
 	*timestamp = rte_ns_to_timespec(priv->tx_timestamp);
+	dpaa2_timestamp_debug(priv, __func__, priv->tx_timestamp);
 
 	return 0;
 }
 
 int dpaa2_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp,
-						uint32_t flags __rte_unused)
+	struct timespec *timestamp, uint32_t flags __rte_unused)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	if (!(priv->flags & DPAA2_IEEE1588_RX_TS_FLAG))
+		return -EINVAL;
+
 	*timestamp = rte_ns_to_timespec(priv->rx_timestamp);
+	dpaa2_timestamp_debug(priv, __func__, priv->rx_timestamp);
+
 	return 0;
 }
 
-#if defined(RTE_LIBRTE_IEEE1588)
 static int
 dpaa2_create_dprtc_device(int vdev_fd __rte_unused,
 	struct vfio_device_info *obj_info __rte_unused,
 	struct rte_dpaa2_device *obj)
 {
 	struct dprtc_attr attr;
-	int ret, dprtc_id = obj->object_id;
+	int ret = 0, dprtc_id = obj->object_id;
 
 	PMD_INIT_FUNC_TRACE();
 
 	/* Allocate DPAA2 dprtc handle */
-	dprtc_dev = rte_malloc(NULL, sizeof(struct dpaa2_dprtc_dev), 0);
+	dprtc_dev = rte_zmalloc(NULL, sizeof(struct dpaa2_dprtc_dev), 0);
 	if (!dprtc_dev) {
 		DPAA2_PMD_ERR("Memory allocation failed for DPRTC Device");
-		return -1;
+		return -ENOMEM;
 	}
 
 	/* Open the dprtc object */
 	dprtc_dev->dprtc.regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 	ret = dprtc_open(&dprtc_dev->dprtc, CMD_PRI_LOW, dprtc_id,
-			  &dprtc_dev->token);
+			&dprtc_dev->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Unable to open dprtc object: err(%d)", ret);
 		goto init_err;
 	}
 
 	ret = dprtc_get_attributes(&dprtc_dev->dprtc, CMD_PRI_LOW,
-				    dprtc_dev->token, &attr);
+			dprtc_dev->token, &attr);
 	if (ret) {
 		DPAA2_PMD_ERR("Unable to get dprtc attr: err(%d)", ret);
 		goto init_err;
@@ -172,7 +276,7 @@ dpaa2_create_dprtc_device(int vdev_fd __rte_unused,
 init_err:
 	rte_free(dprtc_dev);
 
-	return -1;
+	return ret;
 }
 
 static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
@@ -181,4 +285,3 @@ static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
 };
 
 RTE_PMD_REGISTER_DPAA2_OBJECT(dprtc, rte_dpaa2_dprtc_obj);
-#endif
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 3212790957..5c46c0f6d2 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -22,6 +22,7 @@
 #include <dpaa2_hw_pvt.h>
 #include <dpaa2_hw_dpio.h>
 #include <dpaa2_hw_mempool.h>
+#include <dpaax_ptp.h>
 
 #include "dpaa2_pmd_logs.h"
 #include "dpaa2_ethdev.h"
@@ -108,6 +109,30 @@ dpaa2_dev_rx_mbuf_sched_set(struct rte_mbuf *m,
 			m->hash.rss);
 	}
 }
+
+static inline void
+dpaa2_dev_rx_read_timestamp(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *m)
+{
+	struct dpaa2_annot_hdr *annotation;
+	rte_mbuf_timestamp_t *ts;
+
+	if (!(priv->flags & DPAA2_IEEE1588_RX_TS_FLAG))
+		return;
+
+	annotation = (void *)((uint8_t *)m->buf_addr + DPAA2_FD_PTA_SIZE);
+	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_PTP)) {
+		m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+		m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+	}
+	ts = RTE_MBUF_DYNFIELD(m, priv->rx_ts_offset, void *);
+	*ts = annotation->word2;
+	m->ol_flags |= priv->rx_ts_flag;
+	rte_atomic_store_explicit(&priv->rx_timestamp, *ts,
+		rte_memory_order_relaxed);
+	dpaa2_timestamp_debug(priv, __func__, priv->rx_timestamp);
+}
+
 static void __rte_hot
 dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *m, const struct qbman_fd *fd,
@@ -948,6 +973,8 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 		if (priv->psr_dynfield_offset >= 0)
 			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
 
+		dpaa2_dev_rx_read_timestamp(priv, mbuf);
+
 		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
 		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
 		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
@@ -1123,6 +1150,8 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 		if (priv->psr_dynfield_offset >= 0)
 			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
+		dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
+
 		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 		dq_storage++;
@@ -1373,6 +1402,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 			if (priv->psr_dynfield_offset >= 0)
 				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
+			dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
 			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 			dq_storage++;
@@ -1416,6 +1446,8 @@ dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
 	return true;
 }
 
+#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 {
 	/* Function receive frames for a given device and VQ*/
@@ -1433,7 +1465,10 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 
 	struct rte_mbuf *mbufs[dpaa2_dqrr_size];
 	struct rte_mempool *mp = NULL;
-	#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+	struct dpaa2_annot_hdr *annotation;
+	void *v_addr;
 
 conf_again:
 	bulk_free = true;
@@ -1531,6 +1566,17 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 		if (bulk_free == true &&
 			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx]))
 			bulk_free = false;
+		if (unlikely(mbufs[idx]->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
+			v_addr = mbufs[idx]->buf_addr;
+			annotation = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
+			rte_atomic_store_explicit(&priv->tx_timestamp,
+				annotation->word2,
+				rte_memory_order_relaxed);
+			rte_atomic_store_explicit(&priv->next_txq_to_cnf,
+				dpaa2_txq, rte_memory_order_relaxed);
+			dpaa2_q->ts_to_cnfd--;
+			dpaa2_timestamp_debug(priv, __func__, priv->tx_timestamp);
+		}
 		idx++;
 		dq_storage++;
 		if (idx >= dpaa2_dqrr_size)
@@ -1613,7 +1659,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to given device and VQ*/
 	uint32_t loop, retry_count, i;
-	int32_t ret, tstamp[MAX_TX_RING_SLOTS];
+	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send;
 	struct qbman_eq_desc eqdesc;
@@ -1659,6 +1705,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 tx_again:
 	/*Check if the queue is congested*/
 	retry_count = 0;
+	ptp_set_count = 0;
 	while (qbman_result_SCN_state(dpaa2_q->cscn)) {
 		retry_count++;
 		/* Retry for some time before giving up */
@@ -1688,6 +1735,17 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		tstamp[loop] = false;
+		if (unlikely(((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) &&
+			(priv->flags & DPAA2_IEEE1588_TX_TS_FLAG))) {
+			ptp_set = false;
+			dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, *bufs,
+				&tstamp[loop], &ptp_set);
+			if (ptp_set)
+				ptp_set_count++;
+			if (ptp_set_count > 1)
+				DPAA2_PMD_WARN("Multiple ptp formats in burst transmission!");
+			goto skip_fast_mbuf2fd;
+		}
 
 		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
 			*bufs, &fd_arr[loop], priv->tx_conf_type);
@@ -1696,6 +1754,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			continue;
 		}
 
+skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
 				dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
@@ -1846,7 +1905,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
 	uint32_t loop, retry_count, sent = 0, i;
-	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS];
+	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
@@ -1869,6 +1928,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	swp = DPAA2_PER_LCORE_PORTAL;
 
 tx_again:
+	ptp_set_count = 0;
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
 		dpaa2_eqcr_size : nb_pkts;
 
@@ -1925,6 +1985,17 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 		}
 
 		tstamp[loop] = false;
+		if (unlikely(((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) &&
+			(priv->flags & DPAA2_IEEE1588_TX_TS_FLAG))) {
+			ptp_set = false;
+			dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, *bufs,
+				&tstamp[loop], &ptp_set);
+			if (ptp_set)
+				ptp_set_count++;
+			if (ptp_set_count > 1)
+				DPAA2_PMD_WARN("Multiple ptp formats in burst transmission!");
+			goto skip_fast_mbuf2fd;
+		}
 
 		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
 				*bufs, &fd_arr[loop], priv->tx_conf_type);
@@ -1935,6 +2006,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			continue;
 		}
 
+skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
 				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
-- 
2.43.0

