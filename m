Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74984C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:56:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ED6142ED2;
	Thu, 10 Sep 2026 15:53:02 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id B6FFC42E7D
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9912A1A0043;
 Thu, 10 Sep 2026 15:52:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 61B3B1A0072;
 Thu, 10 Sep 2026 15:52:48 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A9CC18000B1;
 Thu, 10 Sep 2026 21:52:47 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 40/47] net/dpaa2: support Rx mempool per traffic class
Date: Thu, 10 Sep 2026 19:21:51 +0530
Message-ID: <20260910135158.2181141-41-prashant.gupta_3@nxp.com>
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

Support configuring RX mempool per TC.
This patch isolates mempools by traffic class to avoid
individual TC's performance being impacted by lack of memory.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 119 ++++++++++++++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h |   2 +-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 812e3f529f..e44c073f82 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -546,6 +546,101 @@ dpaa2_update_flow_rss_dist(struct rte_eth_dev *eth_dev,
 	return ret;
 }
 
+static int
+dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
+	struct fsl_mc_io *dpni, void *blist, uint8_t tc_id)
+{
+	/* Function to attach a DPNI with a buffer pool list. Buffer pool list
+	 * handle is passed in blist.
+	 */
+	int32_t retcode;
+	struct dpni_pools_cfg *bpool_cfg = &priv->pools_cfg;
+	struct dpaa2_bp_list *bp_list = blist;
+	struct dpni_buffer_layout layout;
+	int tot_size, out_min_hdr_room, in_min_hdr_room;
+	uint8_t bp_idx;
+	struct rte_mempool *mp = bp_list->mp;
+
+	if (priv->flow_profile.mempool[tc_id] != mp) {
+		if (!priv->flow_profile.mempool[tc_id]) {
+			bp_idx = bpool_cfg->num_dpbp;
+			bpool_cfg->num_dpbp++;
+			priv->flow_profile.bp_idx[tc_id] = bp_idx;
+		} else {
+			bp_idx = priv->flow_profile.bp_idx[tc_id];
+		}
+		priv->flow_profile.mempool[tc_id] = mp;
+	} else {
+		bp_idx = priv->flow_profile.bp_idx[tc_id];
+	}
+
+	/* ... rx buffer layout .
+	 * Check alignment for buffer layouts first
+	 */
+
+	/* ... rx buffer layout ... */
+	if (priv->tx_conf_type == DPAA2_TX_DYNAMIC_CONF) {
+		/** Additional headroom layout for IPSec with TX configure
+		 * dynamic enabled.
+		 */
+		in_min_hdr_room = DPAA2_RX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_IB_MIN;
+		out_min_hdr_room = DPAA2_DYN_TX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_OB_MIN;
+		tot_size = RTE_MAX(in_min_hdr_room, out_min_hdr_room);
+		if (tot_size < RTE_PKTMBUF_HEADROOM)
+			tot_size = RTE_PKTMBUF_HEADROOM;
+	} else {
+		tot_size = RTE_PKTMBUF_HEADROOM;
+	}
+	tot_size = RTE_ALIGN_CEIL(tot_size, DPAA2_PACKET_LAYOUT_ALIGN);
+
+	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
+	layout.options = DPNI_BUF_LAYOUT_OPT_DATA_HEAD_ROOM |
+		DPNI_BUF_LAYOUT_OPT_FRAME_STATUS |
+		DPNI_BUF_LAYOUT_OPT_PARSER_RESULT |
+		DPNI_BUF_LAYOUT_OPT_DATA_ALIGN |
+		DPNI_BUF_LAYOUT_OPT_TIMESTAMP |
+		DPNI_BUF_LAYOUT_OPT_PRIVATE_DATA_SIZE;
+
+	layout.pass_timestamp = true;
+	layout.pass_frame_status = 1;
+	layout.private_data_size = DPAA2_FD_PTA_SIZE;
+	layout.pass_parser_result = 1;
+	layout.data_align = DPAA2_PACKET_LAYOUT_ALIGN;
+	layout.data_head_room = tot_size - DPAA2_FD_PTA_SIZE -
+		DPAA2_MBUF_HW_ANNOTATION;
+	retcode = dpni_set_buffer_layout(dpni, CMD_PRI_LOW, priv->token,
+			DPNI_QUEUE_RX, &layout);
+	if (retcode) {
+		DPAA2_PMD_ERR("Error configuring buffer pool Rx layout (%d)",
+			retcode);
+		return retcode;
+	}
+
+	/*Attach buffer pool to the network interface as described by the user*/
+	bpool_cfg->pools[bp_idx].dpbp_id = bp_list->buf_pool.dpbp_node->dpbp_id;
+	bpool_cfg->pools[bp_idx].backup_pool = 0;
+	bpool_cfg->pools[bp_idx].buffer_size = RTE_ALIGN_CEIL(bp_list->buf_pool.size,
+		DPAA2_PACKET_LAYOUT_ALIGN);
+	/* priority_mask is a bitmask of the traffic classes served by this
+	 * buffer pool, not a traffic class index. MC treats a zero mask as
+	 * 0xff (all traffic classes).
+	 */
+	bpool_cfg->pools[bp_idx].priority_mask = RTE_BIT32(tc_id);
+
+	retcode = dpni_set_pools(dpni, CMD_PRI_LOW, priv->token, bpool_cfg);
+	if (retcode) {
+		DPAA2_PMD_ERR("Error(%d) configuring pools[%d](id=%d) on %s.",
+			retcode, bp_idx, bpool_cfg->pools[bp_idx].dpbp_id,
+			priv->eth_dev->data->name);
+		return retcode;
+	}
+
+	priv->bp_list = bp_list;
+	return 0;
+}
+
 static int
 dpaa2_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
@@ -1321,7 +1416,8 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	struct dpni_taildrop taildrop;
 	uint8_t qopt = 0;
 	uint16_t flow_id;
-	int ret;
+	uint32_t bpid;
+	int ret, ops_idx;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1346,6 +1442,27 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		dev->data->rx_queues[rx_queue_id] = dpaa2_q;
 		return 0;
 	}
+
+	ops_idx = rte_dpaa2_mpool_get_ops_idx();
+	if (ops_idx != mb_pool->ops_index) {
+		DPAA2_PMD_ERR("MP(%s)'s ops index(%d) != %d",
+			mb_pool->name, mb_pool->ops_index, ops_idx);
+		return -EINVAL;
+	}
+
+	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
+		if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+			ret = rte_dpaa2_bpid_info_init(mb_pool);
+			if (ret)
+				return ret;
+		}
+		bpid = mempool_to_bpid(mb_pool);
+		ret = dpaa2_attach_bp_list(priv, dpni,
+				rte_dpaa2_bpid_info[bpid].bp_list,
+				dpaa2_q->tc_index);
+		if (ret)
+			return ret;
+	}
 	cfg = rte_zmalloc(NULL, sizeof(struct dpni_queue), 0);
 	if (!cfg)
 		return -ENOMEM;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 312738931f..0934e04198 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -405,7 +405,7 @@ struct dpaa2_dev_priv {
 	/** RXQs in same TC share same cgid.*/
 	uint8_t cgid_in_use[MAX_TCS];
 	rte_spinlock_t meter_lock;
-
+	struct dpni_pools_cfg pools_cfg;
 	/* Current hash distribution size per RX TC, written by
 	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
 	 * Zero means "use default" (= nb_rx_queues clamped to dist_queues).
-- 
2.43.0

