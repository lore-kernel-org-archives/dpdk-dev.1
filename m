Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE0606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A006427A5;
	Fri, 23 Oct 2026 15:45:01 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id E67DF40E4C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:49 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC0E6200038;
 Fri, 23 Oct 2026 15:44:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 96B7A200031;
 Fri, 23 Oct 2026 15:44:49 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 453B4180006C;
 Fri, 23 Oct 2026 21:44:48 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 53/65] net/dpaa2: add API to clean Tx confirmation queue
Date: Fri, 23 Oct 2026 19:13:33 +0530
Message-ID: <20261023134346.37727-54-prashant.gupta_3@nxp.com>
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

When Tx confirmation is enabled, transmitted mbufs are only released
back to their pool once the corresponding Tx-confirm frames are
dequeued. On a port that stops transmitting, these confirmations are
never drained and the mbufs stay held. Applications had no way to
force this cleanup.

Add rte_pmd_dpaa2_clean_tx_conf() so an application can drain the
Tx-confirm queue associated with a given port and Tx queue on demand.

To support this, dpaa2_dev_tx_conf() is changed to take the
tx-confirm queue directly instead of the Tx queue, and its callers are
updated to pass tx_conf_queue explicitly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c  | 22 ++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_ethdev.h  |  2 +-
 drivers/net/dpaa2/dpaa2_ptp.c     |  2 +-
 drivers/net/dpaa2/dpaa2_rxtx.c    | 22 ++++++++++------------
 drivers/net/dpaa2/rte_pmd_dpaa2.h |  4 ++++
 5 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index d8a183453b..fe43779b10 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1240,6 +1240,28 @@ dpaa2_dev_dcb_info(struct rte_eth_dev *dev,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_clean_tx_conf, 26.11)
+uint16_t
+rte_pmd_dpaa2_clean_tx_conf(uint32_t eth_id, uint16_t txq_id)
+{
+	struct rte_eth_dev *dev;
+	struct dpaa2_queue *txq;
+
+	if (unlikely(!rte_pmd_dpaa2_dev_is_dpaa2(eth_id))) {
+		DPAA2_PMD_WARN("eth%d is NOT dpaa2 device", eth_id);
+		return 0;
+	}
+
+	dev = &rte_eth_devices[eth_id];
+	txq = dev->data->tx_queues[txq_id];
+
+	if (txq->tx_conf_queue)
+		return dpaa2_dev_tx_conf(txq->tx_conf_queue, true);
+
+	DPAA2_PMD_WARN("TX confirm not enabled on %s", dev->data->name);
+	return 0;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_configure_default_action, 26.11)
 int
 rte_pmd_dpaa2_dev_configure_default_action(uint16_t port_id,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index d1ddea7c64..2f3f5bae2a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -981,7 +981,7 @@ uint16_t dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
 void dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id,
 	enum dpaa2_flow_dist_type type);
-uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
+uint16_t dpaa2_dev_tx_conf(struct dpaa2_queue *tx_conf_q, int drain);
 
 void
 dpaa2_dev_tx_ptp_one_step_runtime(struct rte_eth_dev *dev,
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 00f6d04c92..90de203f93 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -218,7 +218,7 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 		rte_memory_order_relaxed);
 	while (txq && rte_atomic_load_explicit(&txq->ts_to_cnfd,
 		rte_memory_order_relaxed) > 0) {
-		dpaa2_dev_tx_conf(txq, false);
+		dpaa2_dev_tx_conf(txq->tx_conf_queue, false);
 		txq = rte_atomic_load_explicit(&priv->next_txq_to_cnf,
 			rte_memory_order_relaxed);
 	}
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index efaa862623..4f712ec9f7 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1417,14 +1417,14 @@ dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
 }
 
 static __rte_always_inline void __rte_hot
-dpaa2_dev_tx_cnf_fd_to_mbuf(struct dpaa2_queue *dpaa2_q,
+dpaa2_dev_tx_cnf_fd_to_mbuf(struct dpaa2_queue *tx_conf_q,
 	const struct qbman_fd *fd, const struct qbman_fd **fds,
 	struct rte_mbuf **mbuf)
 {
 	void *v_addr;
 	struct dpaa2_annot_hdr *annotation;
-	struct dpaa2_queue *dpaa2_txq = dpaa2_q->tx_queue;
-	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
+	struct dpaa2_queue *dpaa2_txq = tx_conf_q->tx_queue;
+	struct dpaa2_dev_priv *priv = tx_conf_q->eth_data->dev_private;
 
 	RTE_SET_USED(fds);
 
@@ -1436,17 +1436,15 @@ dpaa2_dev_tx_cnf_fd_to_mbuf(struct dpaa2_queue *dpaa2_q,
 			annotation->word2, rte_memory_order_relaxed);
 		rte_atomic_store_explicit(&priv->next_txq_to_cnf,
 			dpaa2_txq, rte_memory_order_relaxed);
-		rte_atomic_fetch_sub_explicit(&dpaa2_q->ts_to_cnfd, 1,
+		rte_atomic_fetch_sub_explicit(&tx_conf_q->ts_to_cnfd, 1,
 			rte_memory_order_relaxed);
 		dpaa2_timestamp_debug(priv, __func__, priv->tx_timestamp);
 	}
 }
 
-uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
+uint16_t dpaa2_dev_tx_conf(struct dpaa2_queue *tx_conf_q, int drain)
 {
 	/* Function receive frames for a given device and VQ*/
-	struct dpaa2_queue *dpaa2_txq = txq;
-	struct dpaa2_queue *dpaa2_q = dpaa2_txq->tx_conf_queue;
 	uint16_t num_rx, total = 0, idx;
 	int bulk_free;
 	struct rte_mbuf *mbufs[dpaa2_dqrr_size];
@@ -1455,7 +1453,7 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 		dpaa2_dev_prefetch_next_psr_dummy : dpaa2_dev_prefetch_next_psr;
 
 dq_again:
-	num_rx = dpaa2_dev_prefetch_rx_common(dpaa2_q, NULL, mbufs, dpaa2_dqrr_size,
+	num_rx = dpaa2_dev_prefetch_rx_common(tx_conf_q, NULL, mbufs, dpaa2_dqrr_size,
 		dpaa2_dev_tx_cnf_fd_to_mbuf, dq_prefetch);
 	bulk_free = true;
 	mp = NULL;
@@ -1548,7 +1546,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	hw_mp = priv->bp_list->mp;
 
 	if (dpaa2_q->tx_conf_queue)
-		dpaa2_dev_tx_conf(dpaa2_q, false);
+		dpaa2_dev_tx_conf(dpaa2_q->tx_conf_queue, false);
 
 	/*Prepare enqueue descriptor*/
 	qbman_eq_desc_clear(&eqdesc);
@@ -1874,10 +1872,10 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 		}
 	}
 	for (i = 0; i < loop; i++) {
-		if (unlikely(dpaa2_q[i]->tx_conf_queue)) {
-			dpaa2_dev_tx_conf(dpaa2_q[i], false);
+		cnf_q = dpaa2_q[i]->tx_conf_queue;
+		if (unlikely(cnf_q)) {
+			dpaa2_dev_tx_conf(cnf_q, false);
 			if (tstamp[i]) {
-				cnf_q = dpaa2_q[i]->tx_conf_queue;
 				rte_atomic_fetch_add_explicit(&cnf_q->ts_to_cnfd,
 					1, rte_memory_order_relaxed);
 			}
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index 5a61a952bf..0e447cb58d 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -203,6 +203,10 @@ int
 rte_pmd_dpaa2_dev_configure_default_action(uint16_t port_id,
 	struct rte_pmd_dpaa2_default_action_conf *def_act_conf);
 
+__rte_experimental
+uint16_t
+rte_pmd_dpaa2_clean_tx_conf(uint32_t eth_id, uint16_t txq_id);
+
 #define RTE_DPAA2_EVENT_PORT_CFG_ATOMIC RTE_BIT32(31)
 
 /** RTE_DPAA2_MIX_GROUP_FLOW has same behavio as RTE_DPAA2_FLAT_GROUP_FLOW*/
-- 
2.43.0

