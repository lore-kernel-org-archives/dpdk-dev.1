Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156FCA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EC3D40667;
	Fri, 29 Aug 2025 10:24:34 +0200 (CEST)
Received: from lf-2-36.ptr.blmpb.com (lf-2-36.ptr.blmpb.com [101.36.218.36])
 by mails.dpdk.org (Postfix) with ESMTP id 15DCB4065A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455866; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nT76aYNmJjJhQo9QqwzH76junu3c9AlPPJiMQ/n5Oi8=;
 b=adsBo2+w7fupbEL9YFWEUHFVejx+2WwoHBBUBmASWBL39EElDjgHnvHaYNSDV5R9bA3Y4z
 ppG2oR/unQSkyYm4wH1Ycvo3QzJ5YfLL0sQt6MEdfuMu2sytCJ3J+zxymJmvBvNVnCzmSC
 yQ1KH9JvWFZ8o1vUztdr8Q7rSN90/gz8K86iIRj1R3oGAyQs00zCMuFFcSdNy8FNaSpltD
 6vxHwIqmCsz30Z3ZT+1UdcYrVdVSyISwtDw9hHKtaTq3ASPG18ddAJT8t+JByIfHCYqwLD
 rMoQn5yFatSxCj/gqKqEPIUCFja7+OBmIVIwvNLpJMAY7hkeaA2mCAcCWVSSRw==
Subject: [PATCH 08/14] net/xsc: optimize RSS queue creation
Message-Id: <20250829082423.24369-9-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:24 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
X-Lms-Return-Path: <lba+268b163b8+35c7b9+dpdk.org+wanry@yunsilicon.com>
Mime-Version: 1.0
From: "Renyong Wan" <wanry@yunsilicon.com>
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:24 +0800
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

Refactor RSS RX queue creation for the XSC PMD.

This patch introduces proper QPN allocation and per-QP info setup,
improving memory management and error handling. It makes RSS
queue creation more robust, avoiding partial resource leaks in
case of failures.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_cmd.h    |  47 ++++++++
 drivers/net/xsc/xsc_ethdev.c |   3 +
 drivers/net/xsc/xsc_rx.c     | 219 ++++++++++++++++++++++++++---------
 3 files changed, 216 insertions(+), 53 deletions(-)

diff --git a/drivers/net/xsc/xsc_cmd.h b/drivers/net/xsc/xsc_cmd.h
index 2746131cf1..abf9d06197 100644
--- a/drivers/net/xsc/xsc_cmd.h
+++ b/drivers/net/xsc/xsc_cmd.h
@@ -23,6 +23,10 @@ enum xsc_cmd_opcode {
 	XSC_CMD_OP_RTR2RTS_QP			= 0x504,
 	XSC_CMD_OP_QP_2RST			= 0x50A,
 	XSC_CMD_OP_CREATE_MULTI_QP		= 0x515,
+	XSC_CMD_OP_ALLOC_QPN			= 0x519,
+	XSC_CMD_OP_FREE_QPN			= 0x520,
+	XSC_CMD_OP_SET_QP_INFO			= 0x521,
+	XSC_CMD_QP_UNSET_QP_INFO		= 0x522,
 	XSC_CMD_OP_ACCESS_REG			= 0x805,
 	XSC_CMD_OP_MODIFY_NIC_HCA		= 0x812,
 	XSC_CMD_OP_MODIFY_RAW_QP		= 0x81f,
@@ -497,4 +501,47 @@ struct xsc_cmd_modify_fecparam_mbox_out {
 	uint32_t status;
 };
 
+struct xsc_cmd_alloc_qpn_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	rte_be16_t qp_cnt;
+	uint8_t qp_type;
+	uint8_t rsvd[5];
+};
+
+struct xsc_cmd_alloc_qpn_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	rte_be16_t qpn_base;
+};
+
+struct xsc_cmd_free_qpn_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	rte_be16_t qpn_base;
+	rte_be16_t qp_cnt;
+	uint8_t qp_type;
+	uint8_t rsvd[3];
+};
+
+struct xsc_cmd_free_qpn_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+};
+
+struct xsc_cmd_set_qp_info_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	struct xsc_cmd_create_qp_request qp_info;
+};
+
+struct xsc_cmd_set_qp_info_out {
+	struct xsc_cmd_outbox_hdr hdr;
+};
+
+struct xsc_cmd_unset_qp_info_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	rte_be16_t qpn;
+	uint8_t rsvd[6];
+};
+
+struct xsc_cmd_unset_qp_info_out {
+	struct xsc_cmd_outbox_hdr hdr;
+};
+
 #endif /* _XSC_CMD_H_ */
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 261b49cff4..fc88caa9a2 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -296,6 +296,9 @@ xsc_rxq_start(struct xsc_ethdev_priv *priv)
 	if (ret != 0)
 		goto error;
 
+	for (i = 0; i != priv->num_rq; ++i)
+		priv->dev_data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+
 	priv->flags |= XSC_FLAG_RX_QUEUE_INIT;
 	return 0;
 error:
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 65d63b94de..c65afab51d 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -256,31 +256,139 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 	rte_write32(rte_cpu_to_le_32(recv_db.recv_data), rxq_data->rq_db);
 }
 
+static int
+xsc_alloc_qpn(struct xsc_dev *xdev, uint16_t *qpn_base, uint16_t qp_cnt)
+{
+	int ret;
+	struct xsc_cmd_alloc_qpn_mbox_in in = { };
+	struct xsc_cmd_alloc_qpn_mbox_out out = { };
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_ALLOC_QPN);
+	in.qp_cnt = rte_cpu_to_be_16(qp_cnt);
+	in.qp_type = XSC_QUEUE_TYPE_RAW;
+
+	ret = xsc_dev_mailbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to allocate qpn, port id=%d, qp num=%d, "
+			    "ret=%d, out.status=%u",
+			    xdev->port_id, qp_cnt, ret, out.hdr.status);
+		rte_errno = ENOEXEC;
+		goto error;
+	}
+
+	*qpn_base = rte_be_to_cpu_16(out.qpn_base);
+	return 0;
+
+error:
+	return -rte_errno;
+}
+
+static int
+xsc_free_qpn(struct xsc_dev *xdev, uint16_t qpn_base, uint16_t qp_cnt)
+{
+	int ret;
+	struct xsc_cmd_free_qpn_mbox_in in = { };
+	struct xsc_cmd_free_qpn_mbox_out out = { };
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_FREE_QPN);
+	in.qpn_base = rte_cpu_to_be_16(qpn_base);
+	in.qp_cnt = rte_cpu_to_be_16(qp_cnt);
+	in.qp_type = XSC_QUEUE_TYPE_RAW;
+
+	ret = xsc_dev_mailbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to free qpn, port id=%d, qpn base=%u, qp num=%d, "
+			    "ret=%d, out.status=%u",
+			    xdev->port_id, qpn_base, qp_cnt, ret, out.hdr.status);
+		rte_errno = ENOEXEC;
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+static int
+xsc_set_qp_info(struct xsc_dev *xdev, struct xsc_cmd_create_qp_request *qp_info, size_t pas_size)
+{
+	int ret;
+	size_t in_size;
+	struct xsc_cmd_set_qp_info_in *in;
+	struct xsc_cmd_set_qp_info_out out = { };
+
+	in_size = sizeof(*in) + pas_size;
+	in = malloc(in_size);
+	if (in == NULL) {
+		rte_errno = ENOMEM;
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for setting qp info");
+		return -rte_errno;
+	}
+
+	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_SET_QP_INFO);
+	memcpy(&in->qp_info, qp_info, sizeof(*qp_info) + pas_size);
+	ret = xsc_dev_mailbox_exec(xdev, in, in_size, &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to set qp info, port id=%d, ret=%d, out.status=%u",
+			    xdev->port_id, ret, out.hdr.status);
+		rte_errno = ENOEXEC;
+		goto error;
+	}
+
+	free(in);
+	return 0;
+error:
+	free(in);
+	return -rte_errno;
+}
+
+static int
+xsc_unset_qp_info(struct xsc_dev *xdev, uint16_t qpn)
+{
+	int ret;
+	struct xsc_cmd_unset_qp_info_in in = { };
+	struct xsc_cmd_unset_qp_info_out out = { };
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_QP_UNSET_QP_INFO);
+	in.qpn = rte_cpu_to_be_16(qpn);
+
+	ret = xsc_dev_mailbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to unset qp info, port id=%d, ret=%d, out.status=%u",
+			    xdev->port_id, ret, out.hdr.status);
+		rte_errno = ENOEXEC;
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
 static int
 xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 {
-	struct xsc_cmd_create_multiqp_mbox_in *in;
-	struct xsc_cmd_create_qp_request *req;
-	struct xsc_cmd_create_multiqp_mbox_out *out;
-	uint8_t log_ele;
-	uint64_t iova;
+	int ret;
 	int wqe_n;
-	int in_len, out_len, cmd_len;
 	int entry_total_len, entry_len;
-	uint8_t log_rq_sz, log_sq_sz = 0;
 	uint32_t wqe_total_len;
-	int j, ret;
-	uint16_t i, pa_num;
-	int rqn_base;
+	uint16_t rqn_base, pa_num;
+	uint16_t i, j;
+	uint16_t set_last_no = 0;
+	uint8_t log_ele, log_rq_sz, log_sq_sz = 0;
+	uint64_t iova;
+	size_t pas_size;
 	struct xsc_rxq_data *rxq_data;
 	struct xsc_dev *xdev = priv->xdev;
+	struct xsc_cmd_create_qp_request *req, *info;
 	struct xsc_hwinfo *hwinfo = &xdev->hwinfo;
 	char name[RTE_ETH_NAME_MAX_LEN] = { 0 };
-	void *cmd_buf;
 
 	rxq_data = xsc_rxq_get(priv, 0);
-	if (rxq_data == NULL)
-		return -EINVAL;
+	if (rxq_data == NULL) {
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
 
 	log_ele = rte_log2_u32(sizeof(struct xsc_wqe_data_seg));
 	wqe_n = rxq_data->wqe_s;
@@ -291,37 +399,32 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	entry_len = sizeof(struct xsc_cmd_create_qp_request) + sizeof(uint64_t) * pa_num;
 	entry_total_len = entry_len * priv->num_rq;
 
-	in_len = sizeof(struct xsc_cmd_create_multiqp_mbox_in) + entry_total_len;
-	out_len = sizeof(struct xsc_cmd_create_multiqp_mbox_out) + entry_total_len;
-	cmd_len = RTE_MAX(in_len, out_len);
-	cmd_buf = malloc(cmd_len);
-	if (cmd_buf == NULL) {
+	req = malloc(entry_total_len);
+	if (req == NULL) {
 		rte_errno = ENOMEM;
-		PMD_DRV_LOG(ERR, "Alloc rss qp create cmd memory failed");
-		goto error;
+		PMD_DRV_LOG(ERR, "Failed to alloc create qp request cmd memory");
+		return -rte_errno;
 	}
 
-	in = cmd_buf;
-	memset(in, 0, cmd_len);
-	in->qp_num = rte_cpu_to_be_16((uint16_t)priv->num_rq);
-	in->qp_type = XSC_QUEUE_TYPE_RAW;
-	in->req_len = rte_cpu_to_be_32(cmd_len);
+	ret = xsc_alloc_qpn(xdev, &rqn_base, priv->num_rq);
+	if (ret != 0)
+		goto alloc_qpn_fail;
 
 	for (i = 0; i < priv->num_rq; i++) {
 		rxq_data = xsc_rxq_get(priv, i);
 		if (rxq_data == NULL) {
 			rte_errno = EINVAL;
-			goto error;
+			goto set_qp_fail;
 		}
 
-		req = (struct xsc_cmd_create_qp_request *)(&in->data[0] + entry_len * i);
-		req->input_qpn = rte_cpu_to_be_16(0); /* useless for eth */
-		req->pa_num = rte_cpu_to_be_16(pa_num);
-		req->qp_type = XSC_QUEUE_TYPE_RAW;
-		req->log_rq_sz = log_rq_sz;
-		req->cqn_recv = rte_cpu_to_be_16((uint16_t)rxq_data->cqn);
-		req->cqn_send = req->cqn_recv;
-		req->glb_funcid = rte_cpu_to_be_16((uint16_t)hwinfo->func_id);
+		info = (struct xsc_cmd_create_qp_request *)((uint8_t *)req + entry_len * i);
+		info->input_qpn = rte_cpu_to_be_16(rqn_base + i);
+		info->pa_num = rte_cpu_to_be_16(pa_num);
+		info->qp_type = XSC_QUEUE_TYPE_RAW;
+		info->log_rq_sz = log_rq_sz;
+		info->cqn_recv = rte_cpu_to_be_16((uint16_t)rxq_data->cqn);
+		info->cqn_send = info->cqn_recv;
+		info->glb_funcid = rte_cpu_to_be_16((uint16_t)hwinfo->func_id);
 		/* Alloc pas addr */
 		snprintf(name, sizeof(name), "wqe_mem_rx_%d_%d", port_id, i);
 		rxq_data->rq_pas = rte_memzone_reserve_aligned(name,
@@ -330,32 +433,27 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 							       0, XSC_PAGE_SIZE);
 		if (rxq_data->rq_pas == NULL) {
 			rte_errno = ENOMEM;
-			PMD_DRV_LOG(ERR, "Alloc rxq pas memory failed");
-			goto error;
+			PMD_DRV_LOG(ERR, "Failed to alloc rxq pas memory");
+			goto set_qp_fail;
 		}
 
 		iova = rxq_data->rq_pas->iova;
 		for (j = 0; j < pa_num; j++)
-			req->pas[j] = rte_cpu_to_be_64(iova + j * XSC_PAGE_SIZE);
-	}
+			info->pas[j] = rte_cpu_to_be_64(iova + j * XSC_PAGE_SIZE);
 
-	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_MULTI_QP);
-	out = cmd_buf;
-	ret = xsc_dev_mailbox_exec(xdev, in, in_len, out, out_len);
-	if (ret != 0 || out->hdr.status != 0) {
-		PMD_DRV_LOG(ERR,
-			    "Create rss rq failed, port id=%d, qp_num=%d, ret=%d, out.status=%u",
-			    port_id, priv->num_rq, ret, out->hdr.status);
-		rte_errno = ENOEXEC;
-		goto error;
+		pas_size = pa_num * sizeof(uint64_t);
+		ret = xsc_set_qp_info(xdev, info, pas_size);
+		if (ret != 0)
+			goto set_qp_fail;
+
+		set_last_no++;
 	}
-	rqn_base = rte_be_to_cpu_32(out->qpn_base) & 0xffffff;
 
 	for (i = 0; i < priv->num_rq; i++) {
 		rxq_data = xsc_rxq_get(priv, i);
 		if (rxq_data == NULL) {
 			rte_errno = EINVAL;
-			goto error;
+			goto set_qp_fail;
 		}
 
 		rxq_data->wqes = rxq_data->rq_pas->addr;
@@ -370,18 +468,33 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		xsc_dev_modify_qp_status(xdev, rxq_data->qpn, 1, XSC_CMD_OP_RTR2RTS_QP);
 		xsc_rxq_initialize(xdev, rxq_data);
 		rxq_data->cq_ci = 0;
-		priv->dev_data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 		PMD_DRV_LOG(INFO, "Port %d create rx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%u",
 			    port_id,
 			    rxq_data->wqe_s, rxq_data->wqe_n,
 			    rxq_data->rq_db, rxq_data->qpn);
 	}
 
-	free(cmd_buf);
+	free(req);
 	return 0;
 
-error:
-	free(cmd_buf);
+set_qp_fail:
+	free(req);
+	for (i = 0; i < set_last_no; i++) {
+		xsc_unset_qp_info(xdev, rqn_base + i);
+		rxq_data = xsc_rxq_get(priv, i);
+		if (rxq_data == NULL) {
+			rte_errno = EINVAL;
+			goto set_qp_fail;
+		}
+		rte_memzone_free(rxq_data->rq_pas);
+		rxq_data->rq_pas = NULL;
+	}
+
+	xsc_free_qpn(xdev, rqn_base, priv->num_rq);
+	return -rte_errno;
+
+alloc_qpn_fail:
+	free(req);
 	return -rte_errno;
 }
 
-- 
2.25.1
