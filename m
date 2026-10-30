Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1687606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61A204025A;
	Fri, 30 Oct 2026 06:20:48 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id BC81F40DCE
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:37 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86B661A00BC;
 Fri, 30 Oct 2026 06:20:37 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 264991A00B3;
 Fri, 30 Oct 2026 06:20:37 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 86A431800068;
 Fri, 30 Oct 2026 13:20:35 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 14/14] net/dpaa2: support runtime IEEE1588 timestamping
Date: Fri, 30 Oct 2026 10:50:16 +0530
Message-ID: <20261030052016.3301766-15-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
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

Replace the experimental one-step timestamp configuration APIs with
internal runtime handling. The driver now parses outgoing PTP packets
and updates the one-step correction field offset automatically when
required.

Introduce a dedicated timesync context to consolidate RX/TX timestamp
state, dynamic timestamp registration, and timestamp tracking. Add
timestamp extraction for RX packets and timestamp handling for TX
confirmations through the standard ethdev timesync callbacks.

As a result, the experimental APIs
rte_pmd_dpaa2_set_one_step_ts() and
rte_pmd_dpaa2_get_one_step_ts() are removed.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |   2 +
 drivers/net/dpaa2/dpaa2_ethdev.c       |  91 +---------
 drivers/net/dpaa2/dpaa2_ethdev.h       |  50 ++++--
 drivers/net/dpaa2/dpaa2_ptp.c          | 141 +++++++++++++--
 drivers/net/dpaa2/dpaa2_rxtx.c         | 234 +++++++++++++------------
 drivers/net/dpaa2/rte_pmd_dpaa2.h      |  10 --
 6 files changed, 289 insertions(+), 239 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9835d74b17..70266464d2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -163,6 +163,8 @@ Removed Items
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+* net/dpaa2: Removed the experimental one-step PTP APIs
+  ``rte_pmd_dpaa2_set_one_step_ts()`` and ``rte_pmd_dpaa2_get_one_step_ts()``.
 
 * Removed deprecated symbols:
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 68e70cdb45..762bdb6532 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -147,11 +147,6 @@ static uint64_t dev_tx_offloads_sup =
 /* Tx offloads which cannot be disabled */
 static uint64_t dev_tx_offloads_nodis = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
-/* enable timestamp in mbuf */
-bool dpaa2_enable_ts[RTE_MAX_ETHPORTS];
-uint64_t dpaa2_timestamp_rx_dynflag;
-int dpaa2_timestamp_dynfield_offset = -1;
-
 /* Rx descriptor limit when DPNI loads PFDRs in PEB */
 #define MAX_NB_RX_DESC_IN_PEB	11264
 static int total_nb_rx_desc;
@@ -799,9 +794,7 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	int tx_l4_csum_offload = false;
 	int ret, tc_index;
 	uint32_t max_rx_pktlen;
-#if defined(RTE_LIBRTE_IEEE1588)
-	uint16_t ptp_correction_offset;
-#endif
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -883,25 +876,16 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
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
+		ret = rte_mbuf_dyn_rx_timestamp_register(&tm_sync->rx_ts_offset,
+			&tm_sync->rx_ts_flag);
+		if (ret) {
 			DPAA2_PMD_ERR("Error to register timestamp field/flag");
-			return -rte_errno;
+			return ret;
 		}
-		dpaa2_enable_ts[dev->data->port_id] = true;
+		tm_sync->rx_tm_en = true;
 	}
 
-#if defined(RTE_LIBRTE_IEEE1588)
-	/* By default setting ptp correction offset for Ethernet SYNC packets */
-	ptp_correction_offset = RTE_ETHER_HDR_LEN + 8;
-	rte_pmd_dpaa2_set_one_step_ts(dev->data->port_id, ptp_correction_offset, 0);
-#endif
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
 		tx_l3_csum_offload = true;
 
@@ -3375,7 +3359,6 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
-#if defined(RTE_LIBRTE_IEEE1588)
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
 	.timesync_read_time   = dpaa2_timesync_read_time,
@@ -3383,7 +3366,6 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.timesync_adjust_time = dpaa2_timesync_adjust_time,
 	.timesync_read_rx_timestamp = dpaa2_timesync_read_rx_timestamp,
 	.timesync_read_tx_timestamp = dpaa2_timesync_read_tx_timestamp,
-#endif
 };
 
 /* Populate the mac address from physically available (u-boot/firmware) and/or
@@ -3662,10 +3644,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->options = attr.options;
 	priv->max_mac_filters = attr.mac_filter_entries;
 	priv->max_vlan_filters = attr.vlan_filter_entries;
-#if defined(RTE_LIBRTE_IEEE1588)
-	DPAA2_PMD_INFO("DPDK IEEE1588 is enabled");
-	priv->tx_conf_type = DPAA2_TX_ABSOLUTE_CONF;
-#endif
 
 	/* Allocate memory for hardware structure for queues */
 	ret = dpaa2_alloc_rx_tx_queues(eth_dev);
@@ -3828,61 +3806,6 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
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
index 573a23d00f..215a36ce9c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -7,6 +7,8 @@
 
 #ifndef _DPAA2_ETHDEV_H
 #define _DPAA2_ETHDEV_H
+
+#include <rte_time.h>
 #include <rte_compat.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_pmd_dpaa2.h>
@@ -219,11 +221,6 @@ struct sw_buf_free {
 	struct rte_mbuf *seg;
 };
 
-/* enable timestamp in mbuf*/
-extern bool dpaa2_enable_ts[];
-extern uint64_t dpaa2_timestamp_rx_dynflag;
-extern int dpaa2_timestamp_dynfield_offset;
-
 /* Externally defined */
 extern const struct rte_flow_ops dpaa2_flow_ops;
 
@@ -423,6 +420,20 @@ enum dpaa2_tx_conf_type {
 	DPAA2_TX_DYNAMIC_CONF
 };
 
+struct dpaa2_dev_tm_sync {
+	bool rx_tm_en;
+	bool tx_tm_en;
+	bool debug_en;
+	int rx_ts_offset;
+	uint64_t rx_ts_flag;
+	/* Stores correction offset for one step timestamping */
+	uint16_t tx_tm_offset;
+	/*stores timestamp of last received packet on dev*/
+	RTE_ATOMIC(uint64_t) rx_timestamp;
+	/*stores timestamp of last received tx confirmation packet on dev*/
+	RTE_ATOMIC(uint64_t) tx_timestamp;
+};
+
 struct dpaa2_dev_priv {
 	void *hw;
 	int32_t hw_id;
@@ -474,15 +485,8 @@ struct dpaa2_dev_priv {
 	uint16_t ss_offset;
 	uint64_t ss_iova;
 	uint64_t ss_param_iova;
-	/*stores timestamp of last received packet on dev*/
-	uint64_t rx_timestamp;
-	/*stores timestamp of last received tx confirmation packet on dev*/
-	uint64_t tx_timestamp;
 
-	/* stores next tx queue to be confirmed that should be processed,
-	 * it corresponds to last packet transmitted
-	 */
-	struct dpaa2_queue *next_txq_to_cnf;
+	struct dpaa2_dev_tm_sync tm_sync;
 
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
@@ -492,8 +496,6 @@ struct dpaa2_dev_priv {
 	/* Rx-interrupt mode latched at the first dev_configure */
 	uint8_t intr_mode;
 	uint8_t intr_mode_set;
-	/* Stores correction offset for one step timestamping */
-	uint16_t ptp_correction_offset;
 	/* for mac counters */
 	uint32_t *cnt_idx_dma_mem;
 	uint64_t *cnt_values_dma_mem;
@@ -553,6 +555,21 @@ dpaa2_dev_rx_print_parser_result(struct dpaa2_dev_priv *priv,
 		rxq->tc_index, rxq->flow_id, i);
 }
 
+static inline void
+dpaa2_timestamp_debug(const struct dpaa2_dev_tm_sync *tm_sync,
+	const char *prefix, uint64_t timestamp)
+{
+	struct timespec ts;
+
+	if (likely(!tm_sync->debug_en))
+		return;
+
+	ts = rte_ns_to_timespec(timestamp);
+	dpaa2_dump_print("DPAA2 TS DBG: %s: ns(%" PRIu64 ")->%" PRId64
+		" seconds/%" PRId64 " nanoseconds",
+		prefix, timestamp, (int64_t)ts.tv_sec, (int64_t)ts.tv_nsec);
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
@@ -615,6 +632,9 @@ void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
 void dpaa2_flow_clean(struct rte_eth_dev *dev);
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
 
+int
+dpaa2_dev_tx_ptp_one_step_runtime(struct rte_eth_dev *dev,
+	struct rte_mbuf *buf);
 int dpaa2_timesync_enable(struct rte_eth_dev *dev);
 int dpaa2_timesync_disable(struct rte_eth_dev *dev);
 int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 774fe58d77..dfb42643a1 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -20,17 +20,110 @@
 
 #include <dpaa2_ethdev.h>
 #include <dpaa2_pmd_logs.h>
+#include <dpaax_ptp.h>
 
-int dpaa2_timesync_enable(struct rte_eth_dev *dev __rte_unused)
+static int
+dpaa2_timesync_set_one_step(struct rte_eth_dev *dev,
+	uint16_t offset, int udp, bool enable)
 {
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = dev->process_private;
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+	struct dpni_single_step_cfg cfg;
+	int err;
+
+	memset(&cfg, 0, sizeof(struct dpni_single_step_cfg));
+	cfg.en = enable;
+	cfg.ch_update = udp;
+	cfg.offset = offset;
+	cfg.peer_delay = 0;
+
+	err = dpni_set_single_step_cfg(dpni, CMD_PRI_LOW, priv->token, &cfg);
+	if (err)
+		return err;
+
+	tm_sync->tx_tm_offset = offset;
+
 	return 0;
 }
 
-int dpaa2_timesync_disable(struct rte_eth_dev *dev __rte_unused)
+int
+dpaa2_dev_tx_ptp_one_step_runtime(struct rte_eth_dev *dev,
+	struct rte_mbuf *buf)
+{
+	uint16_t ts_offset = 0;
+	int is_udp = false, ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+
+	if (!tm_sync->tx_tm_en) {
+		ret = -ENOTSUP;
+	} else if (unlikely(buf->nb_segs > 1)) {
+		DPAA2_PMD_WARN("PTP frame doesn't support multi seg mbuf");
+		ret = -ENOTSUP;
+	} else if (!dpaax_timesync_ptp_parse_header(buf,
+		&ts_offset, &is_udp)) {
+		DPAA2_PMD_WARN("Tx packet is not PTP frame.");
+		ret = -EINVAL;
+	} else if (unlikely(ts_offset != tm_sync->tx_tm_offset)) {
+		ret = dpaa2_timesync_set_one_step(dev, ts_offset, is_udp, true);
+		if (ret) {
+			DPAA2_PMD_WARN("Change one step failed(%d)", ret);
+		} else {
+			DPAA2_PMD_INFO("Change one step from offset %d to %d",
+				tm_sync->tx_tm_offset, ts_offset);
+			tm_sync->tx_tm_offset = ts_offset;
+		}
+	}
+
+	if (ret)
+		buf->ol_flags &= ~RTE_MBUF_F_TX_IEEE1588_TMST;
+	return ret;
+}
+
+int dpaa2_timesync_enable(struct rte_eth_dev *dev)
 {
+	uint16_t default_offset;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+	int ret;
+
+	if (priv->tx_conf_type == DPAA2_TX_NO_CONF) {
+		DPAA2_PMD_ERR("%s Unable to read TX timestamp",
+			dev->data->name);
+		return -ENOTSUP;
+	}
+
+	default_offset = RTE_ETHER_HDR_LEN +
+		offsetof(struct rte_dpaax_ptp_header, correction);
+
+	ret = dpaa2_timesync_set_one_step(dev, default_offset, false, true);
+	if (ret) {
+		DPAA2_PMD_ERR("%s one step timesyc set failed(%d)",
+			dev->data->name, ret);
+		return ret;
+	}
+	tm_sync->tx_tm_en = true;
+
+	if (rte_log_get_level(dpaa2_logtype_pmd) == RTE_LOG_DEBUG)
+		tm_sync->debug_en = true;
+
 	return 0;
 }
 
+int dpaa2_timesync_disable(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	ret = dpaa2_timesync_set_one_step(dev, 0, false, false);
+	if (ret) {
+		DPAA2_PMD_ERR("%s one step timesyc set failed(%d)",
+			dev->data->name, ret);
+	}
+
+	return ret;
+}
+
 int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
 	struct timespec *timestamp)
 {
@@ -48,6 +141,7 @@ int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
 	}
 
 	*timestamp = rte_ns_to_timespec(ns);
+	dpaa2_timestamp_debug(&priv->tm_sync, __func__, ns);
 
 	return 0;
 }
@@ -68,6 +162,7 @@ int dpaa2_timesync_write_time(struct rte_eth_dev *dev,
 		DPAA2_PMD_ERR("Failed(%d) to set rtc", ret);
 		return ret;
 	}
+	dpaa2_timestamp_debug(&priv->tm_sync, __func__, ns);
 
 	return 0;
 }
@@ -94,31 +189,49 @@ int dpaa2_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 		DPAA2_PMD_ERR("Failed(%d) to set rtc", ret);
 		return ret;
 	}
+	dpaa2_timestamp_debug(&priv->tm_sync, "adjust delata", delta);
+	dpaa2_timestamp_debug(&priv->tm_sync, "adjust absolute", ns);
 
 	return 0;
 }
 
-int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp)
+int
+dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
+	struct timespec *timestamp)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+	uint64_t ts;
 
-	if (priv->next_txq_to_cnf) {
-		while (!priv->tx_timestamp)
-			dpaa2_dev_tx_conf(priv->next_txq_to_cnf, false);
-	} else {
-		return -1;
-	}
-	*timestamp = rte_ns_to_timespec(priv->tx_timestamp);
+	if (!tm_sync->tx_tm_en)
+		return -EINVAL;
+
+	ts = rte_atomic_exchange_explicit(&tm_sync->tx_timestamp, 0,
+		rte_memory_order_acquire);
+	if (!ts)
+		return -EAGAIN;
+
+	*timestamp = rte_ns_to_timespec(ts);
+
+	dpaa2_timestamp_debug(tm_sync, __func__, ts);
 
 	return 0;
 }
 
 int dpaa2_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp,
-						uint32_t flags __rte_unused)
+	struct timespec *timestamp, uint32_t flags __rte_unused)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	*timestamp = rte_ns_to_timespec(priv->rx_timestamp);
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+	uint64_t ts;
+
+	if (!tm_sync->rx_tm_en)
+		return -EINVAL;
+
+	ts = rte_atomic_load_explicit(&tm_sync->rx_timestamp,
+		rte_memory_order_relaxed);
+	*timestamp = rte_ns_to_timespec(ts);
+	dpaa2_timestamp_debug(tm_sync, __func__, ts);
+
 	return 0;
 }
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index c7f58b41cb..da1ac200fc 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -22,6 +22,7 @@
 #include <dpaa2_hw_pvt.h>
 #include <dpaa2_hw_dpio.h>
 #include <dpaa2_hw_mempool.h>
+#include <dpaax_ptp.h>
 
 #include "dpaa2_pmd_logs.h"
 #include "dpaa2_ethdev.h"
@@ -39,13 +40,6 @@
 #define DPAA2_FAST_PATH_PTYPE_ETH_IPV6_TCP \
 	(DPAA2_FAST_PATH_PTYPE_ETH_IPV6 | RTE_PTYPE_L4_TCP)
 
-static inline rte_mbuf_timestamp_t *
-dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
-{
-	return RTE_MBUF_DYNFIELD(mbuf,
-		dpaa2_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
-}
-
 static inline void
 dpaa2_dev_rx_annot_prefetch(const struct qbman_fd *fd)
 {
@@ -129,6 +123,29 @@ dpaa2_dev_rx_mbuf_flc_offload(struct rte_mbuf *m,
 	}
 }
 
+static inline void
+dpaa2_dev_rx_read_timestamp(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *m)
+{
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+	struct dpaa2_annot_hdr *annotation;
+	rte_mbuf_timestamp_t *ts;
+
+	if (!tm_sync->rx_tm_en)
+		return;
+
+	annotation = (void *)((uint8_t *)m->buf_addr + DPAA2_FD_PTA_SIZE);
+	if (!BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_PTP))
+		return;
+	m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+	m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+	ts = RTE_MBUF_DYNFIELD(m, tm_sync->rx_ts_offset, void *);
+	*ts = annotation->word2;
+	m->ol_flags |= tm_sync->rx_ts_flag;
+	rte_atomic_store_explicit(&tm_sync->rx_timestamp, *ts, rte_memory_order_relaxed);
+	dpaa2_timestamp_debug(tm_sync, __func__, tm_sync->rx_timestamp);
+}
+
 static inline void __rte_hot
 dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *m, const struct qbman_fd *fd,
@@ -201,13 +218,6 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 	if (unlikely(is_vlan && !default_parsed))
 		dpaa2_dev_rx_parse_vlan(m, &m->packet_type, frc_parse, annotation);
 
-	if (dpaa2_enable_ts[m->port]) {
-		*dpaa2_timestamp_dynfield(m) = annotation->word2;
-		m->ol_flags |= dpaa2_timestamp_rx_dynflag;
-		DPAA2_PMD_DP_DEBUG("pkt timestamp: 0x%" PRIx64 "",
-				*dpaa2_timestamp_dynfield(m));
-	}
-
 	DPAA2_PMD_DP_DEBUG("HW frc = 0x%x packet type = 0x%x ol_flags = 0x%" PRIx64,
 		frc_u.u16, m->packet_type, m->ol_flags);
 }
@@ -222,13 +232,6 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 	DPAA2_PMD_DP_DEBUG("(slow parse)annotation(3)=0x%" PRIx64 "\t"
 		"(4)=0x%" PRIx64 "\t", annotation->word3, annotation->word4);
 
-#if defined(RTE_LIBRTE_IEEE1588)
-	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_PTP)) {
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
-	}
-#endif
-
 	if (BIT_ISSET_AT_POS(annotation->word3, L2_VLAN_1_PRESENT |
 		L2_VLAN_N_PRESENT)) {
 		vlan_tci = rte_pktmbuf_mtod_offset(mbuf, uint16_t *,
@@ -343,13 +346,6 @@ dpaa2_dev_rx_parse(struct dpaa2_dev_priv *priv,
 	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CV))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
-	if (dpaa2_enable_ts[mbuf->port]) {
-		*dpaa2_timestamp_dynfield(mbuf) = annotation->word2;
-		mbuf->ol_flags |= dpaa2_timestamp_rx_dynflag;
-		DPAA2_PMD_DP_DEBUG("pkt timestamp: 0x%" PRIx64 "",
-				*dpaa2_timestamp_dynfield(mbuf));
-	}
-
 	/* Check detailed parsing requirement */
 	if (unlikely(annotation->word3 & 0x7FFFFC3FFFF))
 		return dpaa2_dev_rx_parse_slow(mbuf, annotation);
@@ -506,6 +502,27 @@ dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	return mbuf;
 }
 
+static void dpaa2_dev_tx_enable_tstamp(struct qbman_fd *fd)
+{
+	struct dpaa2_faead *fd_faead;
+	void *fd_va = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+
+	/* Set frame annotation status field as valid */
+	(fd)->simple.frc |= DPAA2_FD_FRC_FASV;
+
+	/* Set frame annotation egress action descriptor as valid */
+	(fd)->simple.frc |= DPAA2_FD_FRC_FAEADV;
+
+	/* Set Annotation Length as 128B */
+	(fd)->simple.ctrl |= DPAA2_FD_CTRL_ASAL;
+
+	/* enable update of confirmation frame annotation */
+	fd_faead = (void *)((size_t)fd_va +
+		DPAA2_FD_PTA_SIZE + DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
+	fd_faead->ctrl |= (DPAA2_ANNOT_FAEAD_A2V |
+		DPAA2_ANNOT_FAEAD_UPDV | DPAA2_ANNOT_FAEAD_UPD);
+}
+
 static inline struct rte_mbuf *
 dpaa2_dev_mbuf_copy_one_seg(const struct rte_mbuf *sgm, struct rte_mempool *mp)
 {
@@ -528,18 +545,31 @@ dpaa2_dev_mbuf_copy_one_seg(const struct rte_mbuf *sgm, struct rte_mempool *mp)
 
 static inline void
 dpaa2_dev_tx_config_dynamic_confirm(struct qbman_fd *fd,
-	struct dpaa2_queue *txq, int enable)
+	struct dpaa2_queue *txq, int enable, int tstamp)
 {
 	struct dpaa2_faead *fd_faead;
 	void *fd_va = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
 
-	DPAA2_SET_FD_FRC(fd, DPAA2_GET_FD_FRC(fd) | DPAA2_FD_FRC_FAEADV);
+	if (tstamp) {
+		DPAA2_SET_FD_FRC(fd,
+			DPAA2_GET_FD_FRC(fd) |
+			DPAA2_FD_FRC_FAEADV | DPAA2_FD_FRC_FASV);
+		fd->simple.ctrl |= DPAA2_FD_CTRL_ASAL;
+	} else {
+		DPAA2_SET_FD_FRC(fd, DPAA2_GET_FD_FRC(fd) |
+			DPAA2_FD_FRC_FAEADV);
+	}
 	/* enable update of confirmation frame annotation */
 	fd_faead = (void *)((size_t)fd_va +
 			DPAA2_FD_PTA_SIZE + DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
 	if (enable) {
 		fd_faead->fqid = txq->tx_conf_queue->fqid;
 		fd_faead->ctrl = DPAA2_TX_CONFIRM_ENABLE;
+		if (tstamp) {
+			fd_faead->ctrl |= (DPAA2_ANNOT_FAEAD_A2V |
+				DPAA2_ANNOT_FAEAD_UPDV |
+				DPAA2_ANNOT_FAEAD_UPD);
+		}
 	} else {
 		fd_faead->fqid = 0;
 		fd_faead->ctrl &= (~DPAA2_TX_CONFIRM_ENABLE);
@@ -735,7 +765,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	else
 		DPAA2_RESET_FD_FLC(fd);
 	if (need_dyconf)
-		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true);
+		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true, false);
 
 	if (need_conf) {
 		dpaa2_dev_tx_conf_mbuf_to_sge(sgt, cur_seg, nb_segs, sg_mbuf);
@@ -772,7 +802,7 @@ static int __rte_noinline __rte_hot
 dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	struct rte_mbuf *mbuf, struct qbman_fd *fd,
 	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
-	uint8_t *dy_conf)
+	uint8_t *dy_conf, int tstamp)
 {
 	int need_dyconf = false, need_conf = false, need_copy = false;
 	struct rte_mbuf *copy_mbuf;
@@ -786,8 +816,8 @@ dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	}
 	if (mbuf->pool->ops_index != hw_mp->ops_index ||
 		RTE_MBUF_HAS_EXTBUF(mbuf) ||
-		rte_mbuf_refcnt_read(mbuf) > 1) {
-		if (conf == DPAA2_TX_DYNAMIC_CONF &&
+		rte_mbuf_refcnt_read(mbuf) > 1 || tstamp) {
+		if ((conf == DPAA2_TX_DYNAMIC_CONF || tstamp) &&
 			rte_pktmbuf_headroom(mbuf) >=
 			(DPAA2_FD_PTA_SIZE + DPAA2_DYN_TX_MIN_FD_OFFSET))
 			need_dyconf = true;
@@ -811,9 +841,11 @@ dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	}
 
 	if (need_dyconf) {
-		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true);
+		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true, tstamp);
 		if (dy_conf)
 			*dy_conf = true;
+	} else if (tstamp) {
+		dpaa2_dev_tx_enable_tstamp(fd);
 	}
 
 	return 0;
@@ -899,6 +931,8 @@ dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
 		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
 
+		dpaa2_dev_rx_read_timestamp(priv, mbuf);
+
 		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf, dpaa2_q);
 
 		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
@@ -1070,6 +1104,8 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
+		dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
+
 		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx], dpaa2_q);
 
 		dq_storage++;
@@ -1341,12 +1377,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
-#if defined(RTE_LIBRTE_IEEE1588)
-			if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
-				priv->rx_timestamp =
-					*dpaa2_timestamp_dynfield(bufs[num_rx]);
-			}
-#endif
+			dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
 			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx], dpaa2_q);
 
 			dq_storage++;
@@ -1390,6 +1421,8 @@ dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
 	return true;
 }
 
+#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 {
 	/* Function receive frames for a given device and VQ*/
@@ -1407,7 +1440,11 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 
 	struct rte_mbuf *mbufs[dpaa2_dqrr_size];
 	struct rte_mempool *mp = NULL;
-	#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+	struct dpaa2_dev_tm_sync *tm_sync = &priv->tm_sync;
+	struct dpaa2_annot_hdr *annotation;
+	void *v_addr;
 
 conf_again:
 	bulk_free = true;
@@ -1497,25 +1534,6 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 		}
 
 		fd = qbman_result_DQ_fd(dq_storage);
-
-#if defined(RTE_LIBRTE_IEEE1588)
-		{
-			struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-			struct dpaa2_dev_priv *priv = eth_data->dev_private;
-			struct rte_mbuf *mbuf;
-			struct dpaa2_annot_hdr *annotation;
-			void *vaddr;
-
-			mbuf = (void *)DPAA2_GET_FD_FLC(fd);
-
-			if (mbuf && (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
-				vaddr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
-				annotation = (void *)((size_t)vaddr + DPAA2_FD_PTA_SIZE);
-				priv->tx_timestamp = annotation->word2;
-			}
-		}
-#endif
-
 		mbufs[idx] = (void *)DPAA2_GET_FD_FLC(fd);
 		if (unlikely(!mp))
 			mp = mbufs[idx]->pool;
@@ -1524,6 +1542,13 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 		if (bulk_free &&
 			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx]))
 			bulk_free = false;
+		if (unlikely(mbufs[idx]->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
+			v_addr = mbufs[idx]->buf_addr;
+			annotation = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
+			rte_atomic_store_explicit(&tm_sync->tx_timestamp,
+				annotation->word2, rte_memory_order_relaxed);
+			dpaa2_timestamp_debug(tm_sync, __func__, tm_sync->tx_timestamp);
+		}
 		idx++;
 		dq_storage++;
 		if (idx >= dpaa2_dqrr_size) {
@@ -1567,30 +1592,6 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 	return total;
 }
 
-#ifdef RTE_LIBRTE_IEEE1588
-/* Configure the egress frame annotation for timestamp update */
-static void enable_tx_tstamp(struct qbman_fd *fd)
-{
-	struct dpaa2_faead *fd_faead;
-
-	/* Set frame annotation status field as valid */
-	(fd)->simple.frc |= DPAA2_FD_FRC_FASV;
-
-	/* Set frame annotation egress action descriptor as valid */
-	(fd)->simple.frc |= DPAA2_FD_FRC_FAEADV;
-
-	/* Set Annotation Length as 128B */
-	(fd)->simple.ctrl |= DPAA2_FD_CTRL_ASAL;
-
-	/* enable update of confirmation frame annotation */
-	fd_faead = (struct dpaa2_faead *)((size_t)
-			DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd)) +
-			DPAA2_FD_PTA_SIZE + DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
-	fd_faead->ctrl = DPAA2_ANNOT_FAEAD_A2V | DPAA2_ANNOT_FAEAD_UPDV |
-				DPAA2_ANNOT_FAEAD_UPD;
-}
-#endif
-
 static inline int
 dpaa2_dev_tx_fast_mbuf_to_fd(struct rte_eth_dev_data *dev,
 	struct rte_mbuf *buf, struct qbman_fd *fd,
@@ -1630,7 +1631,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to given device and VQ*/
 	uint32_t loop, retry_count = 0, i;
-	int32_t ret;
+	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set_count;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send;
 	struct qbman_eq_desc eqdesc;
@@ -1657,17 +1658,6 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	DPAA2_PMD_DP_DEBUG("===> eth_data =%p, fqid =%d",
 		eth_data, dpaa2_q->fqid);
 
-#ifdef RTE_LIBRTE_IEEE1588
-		/* IEEE1588 driver need pointer to tx confirmation queue
-		 * corresponding to last packet transmitted for reading
-		 * the timestamp
-		 */
-		if ((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) {
-			priv->next_txq_to_cnf = dpaa2_q;
-			dpaa2_dev_tx_conf(dpaa2_q, false);
-			priv->tx_timestamp = 0;
-		}
-#endif
 	if (unlikely(!priv->bp_list)) {
 		DPAA2_PMD_ERR("%s's buffer pool not initialized!",
 			eth_data->name);
@@ -1678,18 +1668,6 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (dpaa2_q->tx_conf_queue)
 		dpaa2_dev_tx_conf(dpaa2_q, false);
 
-#ifdef RTE_LIBRTE_IEEE1588
-	/* IEEE1588 driver need pointer to tx confirmation queue
-	 * corresponding to last packet transmitted for reading
-	 * the timestamp
-	*/
-	if ((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) {
-		priv->next_txq_to_cnf = dpaa2_q;
-		dpaa2_dev_tx_conf(dpaa2_q, false);
-		priv->tx_timestamp = 0;
-	}
-#endif
-
 	/*Prepare enqueue descriptor*/
 	qbman_eq_desc_clear(&eqdesc);
 	qbman_eq_desc_set_no_orp(&eqdesc, DPAA2_EQ_RESP_ERR_FQ);
@@ -1700,6 +1678,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 tx_again:
 	/*Check if the queue is congested*/
 	retry_count = 0;
+	ptp_set_count = 0;
 	while (qbman_result_SCN_state(dpaa2_q->cscn)) {
 		retry_count++;
 		/* Retry for some time before giving up */
@@ -1728,9 +1707,18 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				goto send_n_return;
 		}
 
-#ifdef RTE_LIBRTE_IEEE1588
-		enable_tx_tstamp(&fd_arr[loop]);
-#endif
+		tstamp[loop] = false;
+		if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
+			ret = dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, *bufs);
+			if (!ret) {
+				ptp_set_count++;
+				tstamp[loop] = true;
+			}
+			if (ptp_set_count > 1)
+				DPAA2_PMD_WARN("Multiple ptp formats in burst transmission!");
+			goto skip_fast_mbuf2fd;
+		}
+
 		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
 			*bufs, &fd_arr[loop], priv->tx_conf_type);
 		if (likely(!ret)) {
@@ -1738,16 +1726,16 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			continue;
 		}
 
+skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
 				dpaa2_q, priv->tx_conf_type, &dy_conf[loop]);
 		} else {
 			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q, priv->tx_conf_type, &dy_conf[loop]);
+				dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
 		}
 		if (ret)
 			goto send_n_return;
-
 		bufs++;
 	}
 
@@ -1876,7 +1864,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
 	uint32_t loop, retry_count, sent = 0;
-	int32_t ret = 0;
+	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_set_count;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
@@ -1899,6 +1887,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	swp = DPAA2_PER_LCORE_PORTAL;
 
 tx_again:
+	ptp_set_count = 0;
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
 		dpaa2_eqcr_size : nb_pkts;
 
@@ -1954,6 +1943,18 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
 		}
 
+		tstamp[loop] = false;
+		if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
+			ret = dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, *bufs);
+			if (!ret) {
+				tstamp[loop] = true;
+				ptp_set_count++;
+			}
+			if (ptp_set_count > 1)
+				DPAA2_PMD_WARN("Multiple ptp formats in burst transmission!");
+			goto skip_fast_mbuf2fd;
+		}
+
 		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
 				*bufs, &fd_arr[loop], priv->tx_conf_type);
 		if (likely(!ret)) {
@@ -1963,12 +1964,13 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			continue;
 		}
 
+skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
 				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop]);
 		} else {
 			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop]);
+				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
 		}
 		if (ret)
 			goto send_frames;
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index cef2e84143..2bfe1966b9 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -167,14 +167,4 @@ struct dpaa2_dyn_rx_protocol_pos {
  *	pos = RTE_MBUF_DYNFIELD(m, offset, struct dpaa2_dyn_rx_protocol_pos);
  *	return pos;
  */
-
-#if defined(RTE_LIBRTE_IEEE1588)
-__rte_experimental
-int
-rte_pmd_dpaa2_set_one_step_ts(uint16_t port_id, uint16_t offset, uint8_t ch_update);
-
-__rte_experimental
-int
-rte_pmd_dpaa2_get_one_step_ts(uint16_t port_id, bool mc_query);
-#endif
 #endif /* _RTE_PMD_DPAA2_H */
-- 
2.43.0

