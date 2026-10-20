Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3CC606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52FF940A76;
	Tue, 20 Oct 2026 16:49:07 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1BFE640A6C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:48:54 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F01CD2000D0;
 Tue, 20 Oct 2026 16:48:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBDC42000B1;
 Tue, 20 Oct 2026 16:48:53 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 691BA1800068;
 Tue, 20 Oct 2026 22:48:52 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v14-S2 07/10] net/dpaa2: identify Rx mbuf hash information by
 FLC
Date: Tue, 20 Oct 2026 20:18:38 +0530
Message-ID: <20261020144841.506038-8-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

For default RSS distribution, the mbuf is marked with
RTE_MBUF_F_RX_RSS_HASH and the hash value is taken from the high
word of FLC.

Configure flow steering actions with FLC enabled to align the
stashing settings with the RSS configuration. The TC ID and flow ID
are packed into the FLC low word by the hardware. An Rx mbuf received
from the FS table has the FS_MARK bit set in the FLC low word; such
mbufs are marked with RTE_MBUF_F_RX_FDIR and the TC and flow ID are
encoded in hash.fdir.hi.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h | 12 +++++++++
 drivers/net/dpaa2/dpaa2_flow.c   | 42 ++++++++++++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_rxtx.c   | 18 ++++++++++++--
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 149954fb6b..2569b2bd83 100644
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
index 04b6618bbf..28106a033a 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -4383,6 +4383,13 @@ dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
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
@@ -4445,6 +4452,7 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 	struct dpaa2_dev_priv *dest_priv;
 	const struct rte_flow_action_queue *dest_queue;
 	struct dpaa2_queue *dest_q;
+	uint64_t flc = 0;
 
 	memset(&flow->fs_action_cfg, 0,
 		sizeof(struct dpni_fs_action_cfg));
@@ -4452,7 +4460,41 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 
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
index c31d6556ad..71e292fea6 100644
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
+		tc = (flc_lo >> DPAA2_FS_FLC_TC_OFFSET) &
+			DPAA2_FS_FLC_TC_MASK;
+		flow = flc_lo >> DPAA2_FS_FLC_FLOW_OFFSET;
+		m->ol_flags |= RTE_MBUF_F_RX_FDIR;
+		m->hash.fdir.hi = (tc << 16) | flow;
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

