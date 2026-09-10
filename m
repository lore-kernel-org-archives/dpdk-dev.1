Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D9C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9DF242E50;
	Thu, 10 Sep 2026 15:52:38 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A6A2342E0C
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:27 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8614B1A0072;
 Thu, 10 Sep 2026 15:52:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50B2E1A044C;
 Thu, 10 Sep 2026 15:52:27 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4937818000B5;
 Thu, 10 Sep 2026 21:52:26 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 21/47] net/dpaa2: identify Rx mbuf hash information by FLC
Date: Thu, 10 Sep 2026 19:21:32 +0530
Message-ID: <20260910135158.2181141-22-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

For default RSS distribution, mbuf is marked with RTE_MBUF_F_RX_RSS_HASH
and the hash value from the high word of FLC.

Configure the flow steering action with FLC enabled to align the stashing
setting with the RSS configuration. The TC ID and flow ID are packed into
the FLC for mbuf Rx scheduling. An Rx mbuf received from the FS table is
marked with RTE_MBUF_F_RX_FDIR along with the TC and flow ID decoded from
the FLC low word.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h | 12 +++++++++
 drivers/net/dpaa2/dpaa2_flow.c   | 42 ++++++++++++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_rxtx.c   | 18 ++++++++++++--
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 4501bd9e49..c693989998 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -282,6 +282,18 @@ enum dpaa2_ecpri_fafe_type {
 /* ECPRI shares SP context with VXLAN*/
 #define DPAA2_ECPRI_MSG_OFFSET DPAA2_VXLAN_VNI_OFFSET
 
+#define DPAA2_FS_FLC_FS_MARK_OFFSET \
+	(DPAA2_FLC_DATA_STASHING + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
+
+#define DPAA2_FS_FLC_TC_OFFSET \
+	(DPAA2_FS_FLC_FS_MARK_OFFSET + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
+
+#define DPAA2_FS_FLC_TC_BIT_SIZE (sizeof(uint8_t) * 8)
+#define DPAA2_FS_FLC_TC_MASK ((1 << DPAA2_FS_FLC_TC_BIT_SIZE) - 1)
+
+#define DPAA2_FS_FLC_FLOW_OFFSET \
+	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
+
 #define DPAA2_ECPRI_MAX_EXTRACT_NB 8
 
 struct ipv4_sd_addr_extract_rule {
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 750b93498b..dfe1774d25 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -4384,6 +4384,13 @@ dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
 		switch (actions[j].type) {
 		case RTE_FLOW_ACTION_TYPE_QUEUE:
 			dest_queue = actions[j].conf;
+			if (dest_queue->index >= MAX_RX_QUEUES ||
+				!priv->rx_vq[dest_queue->index]) {
+				DPAA2_PMD_ERR("Invalid FSQ index(%d)",
+					dest_queue->index);
+
+				return -EINVAL;
+			}
 			rxq = priv->rx_vq[dest_queue->index];
 			if (attr->group != rxq->tc_index) {
 				DPAA2_PMD_ERR("FSQ(%d.%d) not in TC[%d]",
@@ -4446,6 +4453,7 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 	struct dpaa2_dev_priv *dest_priv;
 	const struct rte_flow_action_queue *dest_queue;
 	struct dpaa2_queue *dest_q;
+	uint64_t flc = 0;
 
 	memset(&flow->fs_action_cfg, 0,
 		sizeof(struct dpni_fs_action_cfg));
@@ -4453,7 +4461,41 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 
 	if (flow->action_type == RTE_FLOW_ACTION_TYPE_QUEUE) {
 		dest_queue = rte_action->conf;
+		if (dest_queue->index >= MAX_RX_QUEUES ||
+			!priv->rx_vq[dest_queue->index]) {
+			DPAA2_PMD_ERR("Invalid FSQ index(%d)",
+				dest_queue->index);
+
+			return -EINVAL;
+		}
 		dest_q = priv->rx_vq[dest_queue->index];
+		if (flow->tc_id != dest_q->tc_index) {
+			DPAA2_PMD_ERR("RXQ[%d](%d.%d) not in TC[%d]",
+				dest_queue->index,
+				dest_q->tc_index, dest_q->flow_id,
+				flow->tc_id);
+
+			return -EINVAL;
+		}
+		flow->fs_action_cfg.options =
+			DPNI_FS_OPT_SET_FLC | DPNI_FS_OPT_SET_STASH_CONTROL;
+
+		if (dest_q->data_stashing_off) {
+			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING,
+				0, &flc);
+		} else {
+			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING,
+				1, &flc);
+		}
+		if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A) {
+			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING,
+				1, &flc);
+		}
+
+		flc |= ((uint64_t)1) << DPAA2_FS_FLC_FS_MARK_OFFSET;
+		flc |= ((uint64_t)dest_q->tc_index) << DPAA2_FS_FLC_TC_OFFSET;
+		flc |= ((uint64_t)dest_q->flow_id) << DPAA2_FS_FLC_FLOW_OFFSET;
+		flow->fs_action_cfg.flc = flc;
 		flow->fs_action_cfg.flow_id = dest_q->flow_id;
 	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
 		   flow->action_type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index c31d6556ad..7ba6a4563f 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -58,6 +58,7 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
 	uint16_t frc = DPAA2_GET_FD_FRC_PARSE_SUM(fd);
 	struct dpaa2_annot_hdr *annotation =
 			(struct dpaa2_annot_hdr *)hw_annot_addr;
+	uint32_t flc_lo, tc, flow;
 
 	if (unlikely(dpaa2_print_parser_result))
 		dpaa2_print_parse_result(annotation);
@@ -118,8 +119,21 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
 	default:
 		m->packet_type = dpaa2_dev_rx_parse_slow(m, annotation);
 	}
-	m->hash.rss = fd->simple.flc_hi;
-	m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+	flc_lo = fd->simple.flc_lo;
+	if (flc_lo & (1 << DPAA2_FS_FLC_FS_MARK_OFFSET)) {
+		m->ol_flags |= RTE_MBUF_F_RX_FDIR;
+		tc = (flc_lo >> DPAA2_FS_FLC_TC_OFFSET) &
+			DPAA2_FS_FLC_TC_MASK;
+		flow = flc_lo >> DPAA2_FS_FLC_FLOW_OFFSET;
+		rte_mbuf_sched_set(m, flow, tc, 0);
+		DPAA2_PMD_DP_DEBUG("FS frame received from TC[%d]->flow%d",
+			tc, flow);
+	} else {
+		m->hash.rss = fd->simple.flc_hi;
+		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+		DPAA2_PMD_DP_DEBUG("Hash frame received with RSS(%08x)",
+			m->hash.rss);
+	}
 
 	if (dpaa2_enable_ts[m->port]) {
 		*dpaa2_timestamp_dynfield(m) = annotation->word2;
-- 
2.43.0

