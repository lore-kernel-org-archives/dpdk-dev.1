Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42472C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:55:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4633942DBD;
	Thu,  3 Sep 2026 15:54:19 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EB88242D92
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:14 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CE6B8200490;
 Thu,  3 Sep 2026 15:54:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A058D20048D;
 Thu,  3 Sep 2026 15:54:14 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1FD3F180006C;
 Thu,  3 Sep 2026 21:54:12 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 14/45] mempool/dpaa2: support ops index from primary in
 secondary
Date: Thu,  3 Sep 2026 19:23:22 +0530
Message-ID: <20260903135353.3358303-15-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

Secondary processes call rte_dpaa2_mpool_get_ops_idx() but the ops
index is registered only in the primary process. The secondary had no
way to learn the index, causing it to use the initial sentinel value
RTE_MEMPOOL_MAX_OPS_IDX and return an error.

Register an IPC action handler in the primary during pool creation.
Secondary processes send DPAA2_POOL_OPS_IDX_REQ over the
dpaa2_pool_mp_sync channel and receive the ops index back.

Also handle the case where rte_mp_action_register returns ENOTSUP
(e.g. no secondary process support enabled at build time) by
treating it as non-fatal, and improve the error message in
rte_hw_mbuf_free_pool to include the pool name.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 88 +++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index ee001d8ce0..f19b6c039a 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -34,16 +34,90 @@
 
 #include <dpaax_iova_table.h>
 
+#define DPAA2_POOL_MP_SYNC "dpaa2_pool_mp_sync"
+#define DPAA2_POOL_OPS_IDX_REQ 0x100
+#define DPAA2_POOL_OPS_IDX_RSP 0x101
+
+static int s_dpaa2_pool_mp_msg_setup;
+
+struct dpaa2_pool_mp_msg {
+	uint16_t msg_type;
+	uint8_t msg_data[];
+};
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info)
 struct dpaa2_bp_info *rte_dpaa2_bpid_info;
 static struct dpaa2_bp_list *h_bp_list;
 
 static int16_t s_dpaa2_pool_ops_idx = RTE_MEMPOOL_MAX_OPS_IDX;
 
+static int
+dpaa2_mbuf_pool_mp_primary(const struct rte_mp_msg *msg,
+	const void *peer)
+{
+	struct rte_mp_msg reply;
+	const struct dpaa2_pool_mp_msg *req_msg = (const void *)msg->param;
+	struct dpaa2_pool_mp_msg *rsp_msg = (void *)reply.param;
+
+	memset(&reply, 0, sizeof(reply));
+
+	switch (req_msg->msg_type) {
+	case DPAA2_POOL_OPS_IDX_REQ:
+		rsp_msg->msg_type = DPAA2_POOL_OPS_IDX_RSP;
+		rte_memcpy(rsp_msg->msg_data, &s_dpaa2_pool_ops_idx,
+			sizeof(s_dpaa2_pool_ops_idx));
+		break;
+	default:
+		DPAA2_MEMPOOL_ERR("%s received invalid request(%d)",
+			__func__, req_msg->msg_type);
+		return -ENOTSUP;
+	}
+
+	strlcpy(reply.name, DPAA2_POOL_MP_SYNC, sizeof(reply.name));
+	return rte_mp_reply(&reply, peer);
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mpool_get_ops_idx)
 int rte_dpaa2_mpool_get_ops_idx(void)
 {
-	return s_dpaa2_pool_ops_idx;
+	struct rte_mp_msg mp_req;
+	struct rte_mp_reply mp_reply;
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	int ret = 0;
+	struct dpaa2_pool_mp_msg *req_msg = (void *)mp_req.param;
+	struct dpaa2_pool_mp_msg *rsp_msg;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY ||
+		s_dpaa2_pool_ops_idx != RTE_MEMPOOL_MAX_OPS_IDX)
+		return s_dpaa2_pool_ops_idx;
+
+	strlcpy(mp_req.name, DPAA2_POOL_MP_SYNC, sizeof(mp_req.name));
+	req_msg->msg_type = DPAA2_POOL_OPS_IDX_REQ;
+	memset(&mp_reply, 0, sizeof(struct rte_mp_reply));
+	ret = rte_mp_request_sync(&mp_req, &mp_reply, &ts);
+	if (ret) {
+		DPAA2_MEMPOOL_ERR("%s Failed to get response(%d)",
+			__func__, ret);
+		return ret;
+	}
+	if (!mp_reply.msgs) {
+		DPAA2_MEMPOOL_ERR("%s Failed to get response message",
+			__func__);
+		return -EINVAL;
+	}
+	rsp_msg = (void *)mp_reply.msgs;
+	if (rsp_msg->msg_type == DPAA2_POOL_OPS_IDX_RSP) {
+		rte_memcpy(&s_dpaa2_pool_ops_idx, rsp_msg->msg_data,
+			sizeof(s_dpaa2_pool_ops_idx));
+		ret = 0;
+	} else {
+		DPAA2_MEMPOOL_ERR("%s received invalid response(%d)",
+			__func__, rsp_msg->msg_type);
+		ret = -EINVAL;
+	}
+	free(mp_reply.msgs);
+
+	return ret;
 }
 
 static int
@@ -128,10 +202,18 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	if (s_dpaa2_pool_ops_idx == RTE_MEMPOOL_MAX_OPS_IDX) {
 		s_dpaa2_pool_ops_idx = mp->ops_index;
 	} else if (s_dpaa2_pool_ops_idx != mp->ops_index) {
-		DPAA2_MEMPOOL_ERR("Only single ops index only");
+		DPAA2_MEMPOOL_ERR("Single ops index only");
 		ret = -EINVAL;
 		goto err4;
 	}
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+		!s_dpaa2_pool_mp_msg_setup) {
+		ret = rte_mp_action_register(DPAA2_POOL_MP_SYNC,
+			dpaa2_mbuf_pool_mp_primary);
+		if (ret && rte_errno != ENOTSUP)
+			return ret;
+		s_dpaa2_pool_mp_msg_setup = 1;
+	}
 
 	bp_list->next = h_bp_list;
 	bp_list->mp = mp;
@@ -172,7 +254,7 @@ rte_hw_mbuf_free_pool(struct rte_mempool *mp)
 	struct dpaa2_dpbp_dev *dpbp_node;
 
 	if (!mp->pool_data) {
-		DPAA2_MEMPOOL_ERR("Not a valid dpaa2 buffer pool");
+		DPAA2_MEMPOOL_ERR("Not a valid dpaa2 buffer pool %s", mp->name);
 		return;
 	}
 
-- 
2.43.0

