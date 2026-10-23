Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C56606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E5B840B9F;
	Fri, 23 Oct 2026 15:44:06 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 94A6F40A72
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:43:59 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 78D211A0038;
 Fri, 23 Oct 2026 15:43:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42CC61A0021;
 Fri, 23 Oct 2026 15:43:59 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DCE34180006C;
 Fri, 23 Oct 2026 21:43:57 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 07/65] net/dpaa2: optimize dpaa2 Tx queue and channel
 mapping
Date: Fri, 23 Oct 2026 19:12:47 +0530
Message-ID: <20261023134346.37727-8-prashant.gupta_3@nxp.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Allocate TX queues based on dpni attribute and align the
bounds check with the RX queue logic:
- compute nb_tx_queues from num_tx_tcs * num_queues (respecting
  DPNI_OPT_SINGLE_SENDER) and cap at MAX_TX_QUEUES (128)
- cap nb_rx_queues at MAX_RX_QUEUES (128)
- cap num_channels at DPAA2_MAX_CHANNELS
- assign tc_index/flow_id at queue-allocation time instead of
  at queue-setup time
- replace the open-coded (channel << 8 | tc) with
  DPNI_BUILD_PARAM(channel, tc) throughout tx_queue_setup
- initialize fqid to DPAA2_INVALID_FQ_ID and use it as the
  already-configured guard (replacing DPAA2_INVALID_FLOW_ID)
- add a per-device tx_channels[] array for channel mapping

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   1 +
 drivers/net/dpaa2/dpaa2_ethdev.c        | 119 +++++++++++++++---------
 drivers/net/dpaa2/dpaa2_ethdev.h        |   5 +-
 3 files changed, 78 insertions(+), 47 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 556e1b01c0..52f4434928 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -83,6 +83,7 @@
 
 #define DPAA2_DPCI_MAX_QUEUES 2
 #define DPAA2_INVALID_FLOW_ID 0xffff
+#define DPAA2_INVALID_FQ_ID ((uint32_t)(-1))
 #define DPAA2_INVALID_CGID 0xff
 
 #define SEC_FLC_DHR_OUTBOUND	(-114)
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9a0dacfe4e..f697454d1a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -558,17 +558,13 @@ static int
 dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	uint16_t dist_idx;
-	uint32_t vq_id;
-	uint8_t num_rxqueue_per_tc;
-	struct dpaa2_queue *mc_q, *mcq;
+	uint8_t num_queue_per_tc;
+	struct dpaa2_queue *mc_q, *dpaa2_q;
 	uint32_t tot_queues;
 	int i, ret = 0;
-	struct dpaa2_queue *dpaa2_q;
 
 	PMD_INIT_FUNC_TRACE();
 
-	num_rxqueue_per_tc = (priv->nb_rx_queues / priv->num_rx_tc);
 	if (priv->flags & DPAA2_TX_CONF_ENABLE)
 		tot_queues = priv->nb_rx_queues + 2 * priv->nb_tx_queues;
 	else
@@ -580,8 +576,12 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		return -ENOBUFS;
 	}
 
+	num_queue_per_tc = (priv->nb_rx_queues / priv->num_rx_tc);
 	for (i = 0; i < priv->nb_rx_queues; i++) {
 		mc_q->eth_data = dev->data;
+		mc_q->tc_index = i / num_queue_per_tc;
+		mc_q->flow_id = i % num_queue_per_tc;
+		mc_q->fqid = DPAA2_INVALID_FQ_ID;
 		priv->rx_vq[i] = mc_q++;
 		dpaa2_q = priv->rx_vq[i];
 		ret = dpaa2_queue_storage_alloc(dpaa2_q,
@@ -605,9 +605,12 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 			goto fail;
 	}
 
+	num_queue_per_tc = (priv->nb_tx_queues / priv->num_tx_tc);
 	for (i = 0; i < priv->nb_tx_queues; i++) {
 		mc_q->eth_data = dev->data;
-		mc_q->flow_id = DPAA2_INVALID_FLOW_ID;
+		mc_q->tc_index = i / num_queue_per_tc;
+		mc_q->flow_id = i % num_queue_per_tc;
+		mc_q->fqid = DPAA2_INVALID_FQ_ID;
 		priv->tx_vq[i] = mc_q++;
 		dpaa2_q = (struct dpaa2_queue *)priv->tx_vq[i];
 		dpaa2_q->cscn = rte_malloc(NULL,
@@ -622,8 +625,9 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		/*Setup tx confirmation queues*/
 		for (i = 0; i < priv->nb_tx_queues; i++) {
 			mc_q->eth_data = dev->data;
-			mc_q->tc_index = i;
-			mc_q->flow_id = 0;
+			mc_q->tc_index = i / num_queue_per_tc;
+			mc_q->flow_id = i % num_queue_per_tc;
+			mc_q->fqid = DPAA2_INVALID_FQ_ID;
 			priv->tx_conf_vq[i] = mc_q++;
 			dpaa2_q = priv->tx_conf_vq[i];
 			ret = dpaa2_queue_storage_alloc(dpaa2_q,
@@ -633,14 +637,6 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		}
 	}
 
-	vq_id = 0;
-	for (dist_idx = 0; dist_idx < priv->nb_rx_queues; dist_idx++) {
-		mcq = priv->rx_vq[vq_id];
-		mcq->tc_index = dist_idx / num_rxqueue_per_tc;
-		mcq->flow_id = dist_idx % num_rxqueue_per_tc;
-		vq_id++;
-	}
-
 	return 0;
 fail_tx_conf:
 	i -= 1;
@@ -1016,6 +1012,12 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			return ret;
 	}
 	dpaa2_q = priv->rx_vq[rx_queue_id];
+	if (dpaa2_q->fqid != DPAA2_INVALID_FQ_ID) {
+		DPAA2_PMD_WARN("%s: RXQ[%d] has been setup",
+			dev->data->name, rx_queue_id);
+		dev->data->rx_queues[rx_queue_id] = dpaa2_q;
+		return 0;
+	}
 	dpaa2_q->mb_pool = mb_pool; /**< mbuf pool to populate RX ring. */
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
 	dpaa2_q->offloads = rx_conf->offloads;
@@ -1204,7 +1206,9 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->offloads = tx_conf->offloads;
 
 	/* Return if queue already configured */
-	if (dpaa2_q->flow_id != DPAA2_INVALID_FLOW_ID) {
+	if (dpaa2_q->fqid != DPAA2_INVALID_FQ_ID) {
+		DPAA2_PMD_WARN("%s: TXQ[%d] has been setup",
+			dev->data->name, tx_queue_id);
 		dev->data->tx_queues[tx_queue_id] = dpaa2_q;
 		return 0;
 	}
@@ -1212,26 +1216,24 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	memset(&tx_conf_cfg, 0, sizeof(struct dpni_queue));
 	memset(&tx_flow_cfg, 0, sizeof(struct dpni_queue));
 
-	tc_id = tx_queue_id % priv->num_tx_tc;
-	channel_id = (uint8_t)(tx_queue_id / priv->num_tx_tc) % priv->num_channels;
-	flow_id = 0;
+	tc_id = dpaa2_q->tc_index;
+	flow_id = dpaa2_q->flow_id;
+	if (tc_id < priv->num_channels)
+		channel_id = priv->tx_channels[tc_id];
+	else
+		channel_id = priv->tx_channels[priv->num_channels - 1];
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token, DPNI_QUEUE_TX,
-			((channel_id << 8) | tc_id), flow_id, options, &tx_flow_cfg);
+			DPNI_BUILD_PARAM(channel_id, tc_id), flow_id, options, &tx_flow_cfg);
 	if (ret) {
-		DPAA2_PMD_ERR("Error in setting the tx flow: "
-			"tc_id=%d, flow=%d err=%d",
-			tc_id, flow_id, ret);
-			return ret;
+		DPAA2_PMD_ERR("Failed(%d) to set %s's TC[%d].txq[%d]",
+			ret, dev->data->name, tc_id, flow_id);
+		return ret;
 	}
 
-	dpaa2_q->flow_id = flow_id;
-
-	dpaa2_q->tc_index = tc_id;
-
 	ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
-			DPNI_QUEUE_TX, ((channel_id << 8) | dpaa2_q->tc_index),
-			dpaa2_q->flow_id, &tx_flow_cfg, &qid);
+			DPNI_QUEUE_TX, DPNI_BUILD_PARAM(channel_id, tc_id),
+			flow_id, &tx_flow_cfg, &qid);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in getting LFQID err=%d", ret);
 		return ret;
@@ -1270,10 +1272,9 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 		ret = dpni_set_congestion_notification(dpni,
 				CMD_PRI_LOW, priv->token, DPNI_QUEUE_TX,
-				((channel_id << 8) | tc_id), &cong_notif_cfg);
+				DPNI_BUILD_PARAM(channel_id, tc_id), &cong_notif_cfg);
 		if (ret) {
-			DPAA2_PMD_ERR("Set TX congestion notification err=%d",
-			   ret);
+			DPAA2_PMD_ERR("Set TX congestion notification err=%d", ret);
 			return ret;
 		}
 	}
@@ -1281,31 +1282,32 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	dev->data->tx_queues[tx_queue_id] = dpaa2_q;
 
 	if (priv->flags & DPAA2_TX_CONF_ENABLE) {
+		tc_id = dpaa2_tx_conf_q->tc_index;
+		flow_id = dpaa2_tx_conf_q->flow_id;
 		dpaa2_q->tx_conf_queue = dpaa2_tx_conf_q;
 		options = options | DPNI_QUEUE_OPT_USER_CTX;
 		tx_conf_cfg.user_context = (size_t)(dpaa2_q);
 		ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token,
 				DPNI_QUEUE_TX_CONFIRM,
-				((channel_id << 8) | dpaa2_tx_conf_q->tc_index),
-				dpaa2_tx_conf_q->flow_id,
-				options, &tx_conf_cfg);
+				DPNI_BUILD_PARAM(channel_id, tc_id),
+				flow_id, options, &tx_conf_cfg);
 		if (ret) {
 			DPAA2_PMD_ERR("Set TC[%d].TX[%d] conf flow err=%d",
-				dpaa2_tx_conf_q->tc_index,
-				dpaa2_tx_conf_q->flow_id, ret);
+				tc_id, flow_id, ret);
 			return ret;
 		}
 
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 				DPNI_QUEUE_TX_CONFIRM,
-				((channel_id << 8) | dpaa2_tx_conf_q->tc_index),
-				dpaa2_tx_conf_q->flow_id, &tx_conf_cfg, &qid);
+				DPNI_BUILD_PARAM(channel_id, tc_id),
+				flow_id, &tx_conf_cfg, &qid);
 		if (ret) {
 			DPAA2_PMD_ERR("Error in getting LFQID err=%d", ret);
 			return ret;
 		}
 		dpaa2_tx_conf_q->fqid = qid.fqid;
 	}
+
 	return 0;
 }
 
@@ -1364,6 +1366,8 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	/* keep the DPCON on the FQ across a reconfigure; freed at dev_close */
 	if (dpaa2_q->napi_dpcon)
 		dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+
+	dpaa2_q->fqid = DPAA2_INVALID_FQ_ID;
 }
 
 static int
@@ -3448,6 +3452,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
 	struct dpni_buffer_layout layout;
 	int ret, hw_id, i;
+	uint16_t num_q_per_tc, max_q_per_tc;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -3534,10 +3539,34 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < priv->max_cgs; i++)
 		priv->cgid_in_use[i] = 0;
 
-	for (i = 0; i < attr.num_rx_tcs; i++)
-		priv->nb_rx_queues += attr.num_queues;
+	num_q_per_tc = attr.num_queues;
+	max_q_per_tc = MAX_RX_QUEUES / attr.num_rx_tcs;
+
+	if (num_q_per_tc > max_q_per_tc) {
+		DPAA2_PMD_WARN("Too many RXQs per TC(%u) > %u, reduce it to %u",
+			num_q_per_tc, max_q_per_tc, max_q_per_tc);
+		num_q_per_tc = max_q_per_tc;
+	}
+	priv->nb_rx_queues = attr.num_rx_tcs * num_q_per_tc;
 
-	priv->nb_tx_queues = attr.num_tx_tcs * attr.num_channels;
+	max_q_per_tc = MAX_TX_QUEUES / attr.num_tx_tcs;
+	if (attr.options & DPNI_OPT_SINGLE_SENDER)
+		num_q_per_tc = 1;
+	else
+		num_q_per_tc = attr.num_queues;
+	if (num_q_per_tc > max_q_per_tc) {
+		DPAA2_PMD_WARN("Too many TXQs per TC(%u) > %u, reduce it to %u",
+			num_q_per_tc, max_q_per_tc, max_q_per_tc);
+		num_q_per_tc = max_q_per_tc;
+	}
+	priv->nb_tx_queues = attr.num_tx_tcs * num_q_per_tc;
+	if (priv->num_channels > DPAA2_MAX_CHANNELS) {
+		DPAA2_PMD_WARN("Too many TX channels(%d) > %d, reduce it to %d",
+			priv->num_channels, DPAA2_MAX_CHANNELS, DPAA2_MAX_CHANNELS);
+		priv->num_channels = DPAA2_MAX_CHANNELS;
+	}
+	for (i = 0; i < priv->num_channels; i++)
+		priv->tx_channels[i] = i;
 
 	DPAA2_PMD_DEBUG("RX-TC= %d, rx_queues= %d, tx_queues=%d, max_cgs=%d",
 			priv->num_rx_tc, priv->nb_rx_queues,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 98430e3f66..16e55412db 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -30,7 +30,7 @@
 
 #define MAX_TCS			DPNI_MAX_TC
 #define MAX_RX_QUEUES		128
-#define MAX_TX_QUEUES		16
+#define MAX_TX_QUEUES		128
 #define MAX_DPNI		8
 #define DPAA2_MAX_CHANNELS	16
 
@@ -438,13 +438,14 @@ struct dpaa2_dev_priv {
 	int32_t hw_id;
 	int32_t qdid;
 	uint16_t token;
+	uint16_t tx_channels[DPAA2_MAX_CHANNELS];
 	uint8_t nb_tx_queues;
 	uint8_t nb_rx_queues;
 	uint32_t options;
 	void *rx_vq[MAX_RX_QUEUES];
 	void *tx_vq[MAX_TX_QUEUES];
 	struct dpaa2_bp_list *bp_list; /**<Attached buffer pool list */
-	void *tx_conf_vq[MAX_TX_QUEUES * DPAA2_MAX_CHANNELS];
+	void *tx_conf_vq[MAX_TX_QUEUES];
 	void *rx_err_vq;
 	uint32_t flags; /*dpaa2 config flags */
 	uint32_t psr_dynfield_offset;
-- 
2.43.0

