Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E432606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF0C940E01;
	Fri, 23 Oct 2026 15:44:13 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 789EE40B98
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:06 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 55539200041;
 Fri, 23 Oct 2026 15:44:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED04F200020;
 Fri, 23 Oct 2026 15:44:05 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8FAE318000B7;
 Fri, 23 Oct 2026 21:44:04 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 13/65] net/dpaa2: support runtime IEEE1588 timestamping
Date: Fri, 23 Oct 2026 19:12:53 +0530
Message-ID: <20261023134346.37727-14-prashant.gupta_3@nxp.com>
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

IEEE1588 timestamping in the dpaa2 PMD was only available when the
whole DPDK build was compiled with RTE_LIBRTE_IEEE1588. The timesync
ops, the Tx confirmation timestamp read and the one-step PTP setup
were all guarded by that build-time macro, and the Rx timestamp relied
on the global dpaa2_enable_ts[] / dpaa2_timestamp_dynfield_offset
state. This made PTP a compile-time decision shared by all ports and
prevented enabling it per device at runtime.

Rework the timestamping path to be controlled at runtime:

- Drop the RTE_LIBRTE_IEEE1588 guards around the timesync ops and the
  dprtc object registration, and remove the global dpaa2_enable_ts[],
  dpaa2_timestamp_rx_dynflag and dpaa2_timestamp_dynfield_offset
  variables. Rx/Tx timestamping is now tracked per device through
  priv->flags (DPAA2_IEEE1588_RX_TS_FLAG / DPAA2_IEEE1588_TX_TS_FLAG)
  and the per-device rx_ts_offset / rx_ts_flag dynfield registration.

- Enable Tx one-step PTP at timesync_enable() time and update the
  correction offset at runtime from the actual PTP header of each
  transmitted frame (dpaa2_dev_tx_ptp_one_step_runtime), using the
  shared dpaax_ptp helpers to parse the header. The Tx path marks
  timestamp requests, forces dynamic confirmation for those frames,
  and the Tx confirmation handler records the egress timestamp.

- Make the shared PTP state SMP-safe by converting rx_timestamp,
  tx_timestamp, next_txq_to_cnf and the per-queue ts_to_cnfd pending
  counter to C11 atomics, and read the Tx timestamp by draining the
  confirmation queue until the pending count reaches zero.

- Add an optional debug trace (DPAA2_IEEE1588_DEBUG_FLAG, enabled when
  the PMD log level is DEBUG) for the timesync operations.

Since one-step PTP is now configured internally, remove the
experimental APIs rte_pmd_dpaa2_set_one_step_ts() and
rte_pmd_dpaa2_get_one_step_ts() and document their removal in the
26.11 release notes.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst  |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   1 +
 drivers/net/dpaa2/dpaa2_ethdev.c        |  89 +----------
 drivers/net/dpaa2/dpaa2_ethdev.h        |  38 ++++-
 drivers/net/dpaa2/dpaa2_ptp.c           | 175 ++++++++++++++++++----
 drivers/net/dpaa2/dpaa2_rxtx.c          | 190 +++++++++++++++++++-----
 drivers/net/dpaa2/rte_pmd_dpaa2.h       |  10 --
 7 files changed, 335 insertions(+), 170 deletions(-)

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
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 48a465c206..9dba5dbbd1 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -199,6 +199,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint16_t tm_sw_td;	/*!< TM software taildrop */
 	uint64_t offloads;
 	uint64_t lpbk_cntx;
+	RTE_ATOMIC(int32_t) ts_to_cnfd;
 	uint8_t data_stashing_off;
 	/* NAPI rx-interrupt: per-queue DPCON bound to this FQ at dev_start
 	 * (DEST_DPCON, static); the polling worker points the channel's CDAN at
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f4ed12f45a..f2ba6d2c7c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -135,11 +135,6 @@ static uint64_t dev_tx_offloads_sup =
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
@@ -791,9 +786,6 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	int tx_l4_csum_offload = false;
 	int ret, tc_index;
 	uint32_t max_rx_pktlen;
-#if defined(RTE_LIBRTE_IEEE1588)
-	uint16_t ptp_correction_offset;
-#endif
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -875,25 +867,15 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
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
 
@@ -3377,7 +3359,6 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
-#if defined(RTE_LIBRTE_IEEE1588)
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
 	.timesync_read_time   = dpaa2_timesync_read_time,
@@ -3385,7 +3366,6 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.timesync_adjust_time = dpaa2_timesync_adjust_time,
 	.timesync_read_rx_timestamp = dpaa2_timesync_read_rx_timestamp,
 	.timesync_read_tx_timestamp = dpaa2_timesync_read_tx_timestamp,
-#endif
 };
 
 /* Populate the mac address from physically available (u-boot/firmware) and/or
@@ -3596,10 +3576,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->options = attr.options;
 	priv->max_mac_filters = attr.mac_filter_entries;
 	priv->max_vlan_filters = attr.vlan_filter_entries;
-#if defined(RTE_LIBRTE_IEEE1588)
-	DPAA2_PMD_INFO("DPDK IEEE1588 is enabled");
-	priv->flags |= DPAA2_TX_CONF_ENABLE;
-#endif
 
 	/* Allocate memory for hardware structure for queues */
 	ret = dpaa2_alloc_rx_tx_queues(eth_dev);
@@ -3763,61 +3739,6 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
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
index 28d6eb04ac..ddc205c2d4 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -8,6 +8,7 @@
 #ifndef _DPAA2_ETHDEV_H
 #define _DPAA2_ETHDEV_H
 
+#include <rte_time.h>
 #include <rte_compat.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_pmd_dpaa2.h>
@@ -102,6 +103,12 @@
 
 #define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(10)
 
+#define DPAA2_IEEE1588_DEBUG_FLAG RTE_BIT32(11)
+
+#define DPAA2_IEEE1588_TX_TS_FLAG RTE_BIT32(12)
+
+#define DPAA2_IEEE1588_RX_TS_FLAG RTE_BIT32(13)
+
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
@@ -220,11 +227,6 @@ struct sw_buf_free {
 	struct rte_mbuf *seg;
 };
 
-/* enable timestamp in mbuf*/
-extern bool dpaa2_enable_ts[];
-extern uint64_t dpaa2_timestamp_rx_dynflag;
-extern int dpaa2_timestamp_dynfield_offset;
-
 /* Externally defined */
 extern const struct rte_flow_ops dpaa2_flow_ops;
 
@@ -482,14 +484,16 @@ struct dpaa2_dev_priv {
 	uint64_t ss_iova;
 	uint64_t ss_param_iova;
 	/*stores timestamp of last received packet on dev*/
-	uint64_t rx_timestamp;
+	RTE_ATOMIC(uint64_t) rx_timestamp;
 	/*stores timestamp of last received tx confirmation packet on dev*/
-	uint64_t tx_timestamp;
+	RTE_ATOMIC(uint64_t) tx_timestamp;
 
+	int rx_ts_offset;
+	uint64_t rx_ts_flag;
 	/* stores next tx queue to be confirmed that should be processed,
 	 * it corresponds to last packet transmitted
 	 */
-	struct dpaa2_queue *next_txq_to_cnf;
+	RTE_ATOMIC(struct dpaa2_queue *) next_txq_to_cnf;
 
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
@@ -560,6 +564,21 @@ dpaa2_dev_rx_print_parser_result(struct dpaa2_dev_priv *priv,
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
+	dpaa2_dump_print("DPAA2 TS DBG: %s: ns(%" PRIu64 ")->%" PRId64
+		" seconds/%" PRId64 " nanoseconds",
+		prefix, timestamp, (int64_t)ts.tv_sec, (int64_t)ts.tv_nsec);
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
@@ -622,6 +641,9 @@ void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
 void dpaa2_flow_clean(struct rte_eth_dev *dev);
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
 
+void
+dpaa2_dev_tx_ptp_one_step_runtime(struct rte_eth_dev *dev,
+	struct rte_mbuf *buf, int *tstamp, int *set);
 int dpaa2_timesync_enable(struct rte_eth_dev *dev);
 int dpaa2_timesync_disable(struct rte_eth_dev *dev);
 int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 2863cad4dd..00f6d04c92 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
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
+{
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
+	return 0;
+}
+
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
+	if (rte_log_get_level(dpaa2_logtype_pmd) == RTE_LOG_DEBUG)
+		priv->flags |= DPAA2_IEEE1588_DEBUG_FLAG;
+
 	return 0;
 }
 
-int dpaa2_timesync_disable(struct rte_eth_dev *dev __rte_unused)
+int dpaa2_timesync_disable(struct rte_eth_dev *dev)
 {
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
@@ -102,64 +197,85 @@ int dpaa2_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
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
-
-	if (priv->next_txq_to_cnf) {
-		while (!priv->tx_timestamp)
-			dpaa2_dev_tx_conf(priv->next_txq_to_cnf, false);
-	} else {
-		return -1;
+	struct dpaa2_queue *txq;
+	uint64_t ts;
+
+	if (!(priv->flags & DPAA2_IEEE1588_TX_TS_FLAG) ||
+		priv->tx_conf_type == DPAA2_TX_NO_CONF)
+		return -EINVAL;
+
+	txq = rte_atomic_load_explicit(&priv->next_txq_to_cnf,
+		rte_memory_order_relaxed);
+	while (txq && rte_atomic_load_explicit(&txq->ts_to_cnfd,
+		rte_memory_order_relaxed) > 0) {
+		dpaa2_dev_tx_conf(txq, false);
+		txq = rte_atomic_load_explicit(&priv->next_txq_to_cnf,
+			rte_memory_order_relaxed);
 	}
-	*timestamp = rte_ns_to_timespec(priv->tx_timestamp);
+
+	ts = rte_atomic_load_explicit(&priv->tx_timestamp,
+		rte_memory_order_relaxed);
+	*timestamp = rte_ns_to_timespec(ts);
+	dpaa2_timestamp_debug(priv, __func__, ts);
 
 	return 0;
 }
 
 int dpaa2_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp,
-						uint32_t flags __rte_unused)
+	struct timespec *timestamp, uint32_t flags __rte_unused)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	*timestamp = rte_ns_to_timespec(priv->rx_timestamp);
+	uint64_t ts;
+
+	if (!(priv->flags & DPAA2_IEEE1588_RX_TS_FLAG))
+		return -EINVAL;
+
+	ts = rte_atomic_load_explicit(&priv->rx_timestamp,
+		rte_memory_order_relaxed);
+	*timestamp = rte_ns_to_timespec(ts);
+	dpaa2_timestamp_debug(priv, __func__, ts);
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
@@ -172,7 +288,7 @@ dpaa2_create_dprtc_device(int vdev_fd __rte_unused,
 init_err:
 	rte_free(dprtc_dev);
 
-	return -1;
+	return ret;
 }
 
 static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
@@ -181,4 +297,3 @@ static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
 };
 
 RTE_PMD_REGISTER_DPAA2_OBJECT(dprtc, rte_dpaa2_dprtc_obj);
-#endif
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 24631b16c5..3e8fc29baa 100644
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
@@ -171,6 +165,28 @@ dpaa2_dev_rx_mbuf_flc_offload(struct rte_mbuf *m,
 	}
 }
 
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
+	rte_atomic_store_explicit(&priv->rx_timestamp, *ts, rte_memory_order_relaxed);
+	dpaa2_timestamp_debug(priv, __func__, priv->rx_timestamp);
+}
+
 static inline void __rte_hot
 dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *m, const struct qbman_fd *fd,
@@ -243,13 +259,6 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 	if (unlikely(is_vlan && !default_parsed))
 		dpaa2_dev_rx_parse_vlan(m, &m->packet_type, frc_parse, annotation);
 
-	if (dpaa2_enable_ts[m->port]) {
-		*dpaa2_timestamp_dynfield(m) = annotation->word2;
-		m->ol_flags |= dpaa2_timestamp_rx_dynflag;
-		DPAA2_PMD_DP_DEBUG("pkt timestamp: 0x%" PRIx64 "",
-				*dpaa2_timestamp_dynfield(m));
-	}
-
 	DPAA2_PMD_DP_DEBUG("HW frc = 0x%x packet type = 0x%x ol_flags = 0x%lx",
 		frc_u.u16, m->packet_type, m->ol_flags);
 }
@@ -369,13 +378,6 @@ dpaa2_dev_rx_parse(struct dpaa2_dev_priv *priv,
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
@@ -532,6 +534,27 @@ dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
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
@@ -554,18 +577,31 @@ dpaa2_dev_mbuf_copy_one_seg(const struct rte_mbuf *sgm, struct rte_mempool *mp)
 
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
@@ -682,7 +718,7 @@ static int __rte_noinline __rte_hot
 dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	struct rte_mbuf *mbuf, struct qbman_fd *fd,
 	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
-	uint8_t *dy_conf)
+	uint8_t *dy_conf, int tstamp)
 {
 	struct rte_mbuf *cur_seg = mbuf, *sg_mbuf;
 	struct qbman_sge *sgt;
@@ -695,7 +731,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 		while (cur_seg) {
 			if (!RTE_MBUF_DIRECT(cur_seg) ||
 				cur_seg->pool->ops_index != hw_mp->ops_index ||
-				rte_mbuf_refcnt_read(cur_seg) > 1) {
+				rte_mbuf_refcnt_read(cur_seg) > 1 || tstamp) {
 				need_dyconf = true;
 				break;
 			}
@@ -706,7 +742,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	if (need_dyconf || conf == DPAA2_TX_ABSOLUTE_CONF)
 		need_conf = true;
 
-	if (need_dyconf)
+	if (need_dyconf || tstamp)
 		offset = DPAA2_FD_PTA_SIZE + DPAA2_DYN_TX_MIN_FD_OFFSET;
 
 	if (mbuf->pool->ops_index == hw_mp->ops_index &&
@@ -769,7 +805,9 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	else
 		DPAA2_RESET_FD_FLC(fd);
 	if (need_dyconf)
-		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true);
+		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true, tstamp);
+	else if (tstamp)
+		dpaa2_dev_tx_enable_tstamp(fd);
 
 	if (cur_seg != sg_mbuf && need_conf)
 		sg_mbuf->next = cur_seg;
@@ -809,7 +847,7 @@ static int __rte_noinline __rte_hot
 dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	struct rte_mbuf *mbuf, struct qbman_fd *fd,
 	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
-	uint8_t *dy_conf)
+	uint8_t *dy_conf, int tstamp)
 {
 	int need_dyconf = false, need_conf = false;
 	struct rte_mbuf *mi;
@@ -829,7 +867,7 @@ dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	if (conf == DPAA2_TX_DYNAMIC_CONF &&
 		(mbuf->pool->ops_index != hw_mp->ops_index ||
 		RTE_MBUF_HAS_EXTBUF(mbuf) ||
-		rte_mbuf_refcnt_read(mbuf) > 1))
+		rte_mbuf_refcnt_read(mbuf) > 1 || tstamp))
 		need_dyconf = true;
 	if (conf == DPAA2_TX_ABSOLUTE_CONF || need_dyconf)
 		need_conf = true;
@@ -847,9 +885,11 @@ dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	}
 
 	if (need_dyconf) {
-		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true);
+		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true, tstamp);
 		if (dy_conf)
 			*dy_conf = true;
+	} else if (tstamp) {
+		dpaa2_dev_tx_enable_tstamp(fd);
 	}
 
 	return ret;
@@ -935,6 +975,8 @@ dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
 		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
 
+		dpaa2_dev_rx_read_timestamp(priv, mbuf);
+
 		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
 		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
 		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
@@ -1105,6 +1147,8 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
+		dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
+
 		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 		dq_storage++;
@@ -1356,6 +1400,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
+			dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
 			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 			dq_storage++;
@@ -1399,6 +1444,8 @@ dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
 	return true;
 }
 
+#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 {
 	/* Function receive frames for a given device and VQ*/
@@ -1416,7 +1463,10 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 
 	struct rte_mbuf *mbufs[dpaa2_dqrr_size];
 	struct rte_mempool *mp = NULL;
-	#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+	struct dpaa2_annot_hdr *annotation;
+	void *v_addr;
 
 conf_again:
 	bulk_free = true;
@@ -1514,6 +1564,17 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 		if (bulk_free &&
 			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx]))
 			bulk_free = false;
+		if (unlikely(mbufs[idx]->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
+			v_addr = mbufs[idx]->buf_addr;
+			annotation = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
+			rte_atomic_store_explicit(&priv->tx_timestamp,
+				annotation->word2, rte_memory_order_relaxed);
+			rte_atomic_store_explicit(&priv->next_txq_to_cnf,
+				dpaa2_txq, rte_memory_order_relaxed);
+			rte_atomic_fetch_sub_explicit(&dpaa2_q->ts_to_cnfd, 1,
+				rte_memory_order_relaxed);
+			dpaa2_timestamp_debug(priv, __func__, priv->tx_timestamp);
+		}
 		idx++;
 		dq_storage++;
 		if (idx >= dpaa2_dqrr_size)
@@ -1592,7 +1653,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to given device and VQ*/
 	uint32_t loop, retry_count, i;
-	int32_t ret;
+	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send;
 	struct qbman_eq_desc eqdesc;
@@ -1638,6 +1699,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 tx_again:
 	/*Check if the queue is congested*/
 	retry_count = 0;
+	ptp_set_count = 0;
 	while (qbman_result_SCN_state(dpaa2_q->cscn)) {
 		retry_count++;
 		/* Retry for some time before giving up */
@@ -1666,6 +1728,19 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				goto send_n_return;
 		}
 
+		tstamp[loop] = false;
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
+
 		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
 			*bufs, &fd_arr[loop], priv->tx_conf_type);
 		if (likely(!ret)) {
@@ -1673,12 +1748,13 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			continue;
 		}
 
+skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q, priv->tx_conf_type, &dy_conf[loop]);
+				dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
 		} else {
 			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q, priv->tx_conf_type, &dy_conf[loop]);
+				dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
 		}
 		if (ret)
 			goto send_n_return;
@@ -1706,6 +1782,14 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	num_tx += loop;
 	nb_pkts -= loop;
+	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
+		for (i = 0; i < loop; i++) {
+			if (tstamp[i]) {
+				rte_atomic_fetch_add_explicit(&dpaa2_q->tx_conf_queue->ts_to_cnfd,
+					1, rte_memory_order_relaxed);
+			}
+		}
+	}
 	if (nb_pkts > 0)
 		goto tx_again;
 
@@ -1730,6 +1814,15 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 	}
 	num_tx += i;
+	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
+		loop = i;
+		for (i = 0; i < loop; i++) {
+			if (tstamp[i]) {
+				rte_atomic_fetch_add_explicit(&dpaa2_q->tx_conf_queue->ts_to_cnfd,
+					1, rte_memory_order_relaxed);
+			}
+		}
+	}
 
 skip_tx:
 	dpaa2_q->tx_pkts += num_tx;
@@ -1809,8 +1902,8 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
-	uint32_t loop, retry_count, sent = 0;
-	int32_t ret = 0;
+	uint32_t loop, retry_count, sent = 0, i;
+	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
@@ -1833,6 +1926,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	swp = DPAA2_PER_LCORE_PORTAL;
 
 tx_again:
+	ptp_set_count = 0;
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
 		dpaa2_eqcr_size : nb_pkts;
 
@@ -1888,6 +1982,19 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
 		}
 
+		tstamp[loop] = false;
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
+
 		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
 				*bufs, &fd_arr[loop], priv->tx_conf_type);
 		if (likely(!ret)) {
@@ -1897,12 +2004,13 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			continue;
 		}
 
+skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop]);
+				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
 		} else {
 			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop]);
+				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
 		}
 		if (ret)
 			goto send_frames;
@@ -1930,6 +2038,12 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	}
 	nb_pkts -= loop;
 	sent += loop;
+	for (i = 0; i < loop; i++) {
+		if (tstamp[i] && dpaa2_q[i]->tx_conf_queue) {
+			rte_atomic_fetch_add_explicit(&dpaa2_q[i]->tx_conf_queue->ts_to_cnfd,
+				1, rte_memory_order_relaxed);
+		}
+	}
 	if (nb_pkts > 0 && !ret)
 		goto tx_again;
 
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index 128adf3d1d..a6441eed65 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -148,14 +148,4 @@ __rte_experimental
 int
 rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
 	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off);
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

