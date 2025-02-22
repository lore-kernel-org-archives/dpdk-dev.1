Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D26C021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8316D42D97;
	Sat, 22 Feb 2025 04:58:08 +0100 (CET)
Received: from lf-1-16.ptr.blmpb.com (lf-1-16.ptr.blmpb.com [103.149.242.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6573D42D3F
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196679; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lf/v4leLpSn3KWqrsBeWHKsstkYWUzCh8SLsDp/l+fE=;
 b=SiyE4GY32Fl+D2djaBXKYJdQz/S5/0hvtVR74mKY0MQVTORRSjKJZYhNm69sZD+GC8dNJT
 bAIG91dlEYuSfeB78ZIXN53Yump3knZoAsN31FnOADWAPQCBgPYsHjMjtKTMGWGVYcFRrj
 Ib455V4sIIdtPqxWYU9yXpnFxBcJC+Hyl6Tzw543oMOigam/BzdKtb1t/m0Z7pJZfRR6sc
 fgXnr5YavNmDfdIM4FZXdyHjf4Uo/6Xb6RUMjF3fyibOwzOntBL5d6Vo0J5+/lazMjLk2z
 A0ids3zDXy6rgSqm69Lcl1m7MZqOOvnMt9FbLdQvgrqHuE+08EgoituQqbM7rw==
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b45+c9fa5d+dpdk.org+wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
To: <dev@dpdk.org>
Subject: [PATCH 12/12] net/xsc: avoid pointer cast to unrelated class
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:57 +0800
Message-Id: <20250222035756.2290067-13-wanry@yunsilicon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Sat, 22 Feb 2025 11:57:57 +0800
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v1027/

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_np.c   | 10 +++--
 drivers/net/xsc/xsc_rx.c   | 12 ++---
 drivers/net/xsc/xsc_vfio.c | 91 +++++++++++++++++++++++---------------
 3 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index 7ff39f83c9..f96797b7a4 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -162,18 +162,20 @@ xsc_dev_np_exec(struct xsc_dev *xdev, void *cmd, int len, int table, int opmod)
 	int data_len;
 	int cmd_len;
 	int ret;
+	void *cmd_buf;
 
 	data_len = sizeof(struct xsc_np_data_tl) + len;
 	in_len = sizeof(struct xsc_np_mbox_in) + data_len;
 	out_len = sizeof(struct xsc_np_mbox_out) + data_len;
 	cmd_len = RTE_MAX(in_len, out_len);
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc np cmd memory");
 		return -rte_errno;
 	}
 
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_EXEC_NP);
 	in->len = rte_cpu_to_be_16(data_len);
@@ -185,10 +187,10 @@ xsc_dev_np_exec(struct xsc_dev *xdev, void *cmd, int len, int table, int opmod)
 	if (cmd && len)
 		memcpy(tl + 1, cmd, len);
 
-	out = (struct xsc_np_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_dev_mailbox_exec(xdev, in, in_len, out, out_len);
 
-	free(in);
+	free(cmd_buf);
 	return ret;
 }
 
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index ca832dab23..a702b9592b 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -276,6 +276,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	struct xsc_dev *xdev = priv->xdev;
 	struct xsc_hwinfo *hwinfo = &xdev->hwinfo;
 	char name[RTE_ETH_NAME_MAX_LEN] = { 0 };
+	void *cmd_buf;
 
 	rxq_data = xsc_rxq_get(priv, 0);
 	if (rxq_data == NULL)
@@ -293,13 +294,14 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	in_len = sizeof(struct xsc_cmd_create_multiqp_mbox_in) + entry_total_len;
 	out_len = sizeof(struct xsc_cmd_create_multiqp_mbox_out) + entry_total_len;
 	cmd_len = RTE_MAX(in_len, out_len);
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Alloc rss qp create cmd memory failed");
 		goto error;
 	}
 
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 	in->qp_num = rte_cpu_to_be_16((uint16_t)priv->num_rq);
 	in->qp_type = XSC_QUEUE_TYPE_RAW;
@@ -333,7 +335,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	}
 
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_MULTI_QP);
-	out = (struct xsc_cmd_create_multiqp_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_dev_mailbox_exec(xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
 		PMD_DRV_LOG(ERR,
@@ -365,11 +367,11 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 			    rxq_data->rq_db, rxq_data->qpn);
 	}
 
-	free(in);
+	free(cmd_buf);
 	return 0;
 
 error:
-	free(in);
+	free(cmd_buf);
 	return -rte_errno;
 }
 
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 2cd796ba26..8330483523 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -70,22 +70,24 @@ xsc_vfio_hwinfo_init(struct xsc_dev *xdev)
 	struct xsc_cmd_query_hca_cap_mbox_in *in;
 	struct xsc_cmd_query_hca_cap_mbox_out *out;
 	struct xsc_cmd_hca_cap *hca_cap;
+	void *cmd_buf;
 
 	in_len = sizeof(struct xsc_cmd_query_hca_cap_mbox_in);
 	out_len = sizeof(struct xsc_cmd_query_hca_cap_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
 
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to alloc dev hwinfo cmd memory");
 		rte_errno = ENOMEM;
 		return -rte_errno;
 	}
 
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_QUERY_HCA_CAP);
 	in->hdr.ver = rte_cpu_to_be_16(XSC_CMD_QUERY_HCA_CAP_V1);
-	out = (struct xsc_cmd_query_hca_cap_mbox_out *)in;
+	out = cmd_buf;
 
 	ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
@@ -126,7 +128,7 @@ xsc_vfio_hwinfo_init(struct xsc_dev *xdev)
 	xsc_vfio_pcie_no_init(&xdev->hwinfo);
 
 exit:
-	free(in);
+	free(cmd_buf);
 	return ret;
 }
 
@@ -189,22 +191,24 @@ xsc_vfio_destroy_qp(void *qp)
 	struct xsc_cmd_destroy_qp_mbox_in *in;
 	struct xsc_cmd_destroy_qp_mbox_out *out;
 	struct xsc_vfio_qp *data = (struct xsc_vfio_qp *)qp;
+	void *cmd_buf;
 
 	in_len = sizeof(struct xsc_cmd_destroy_qp_mbox_in);
 	out_len = sizeof(struct xsc_cmd_destroy_qp_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
 
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc qp destroy cmd memory");
 		return -rte_errno;
 	}
-	memset(in, 0, cmd_len);
 
+	in = cmd_buf;
+	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_DESTROY_QP);
 	in->qpn = rte_cpu_to_be_32(data->qpn);
-	out = (struct xsc_cmd_destroy_qp_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_vfio_mbox_exec(data->xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
 		PMD_DRV_LOG(ERR, "Failed to destroy qp, type=%d, err=%d, out.status=%u",
@@ -218,7 +222,7 @@ xsc_vfio_destroy_qp(void *qp)
 	rte_free(qp);
 
 exit:
-	free(in);
+	free(cmd_buf);
 	return ret;
 }
 
@@ -230,22 +234,25 @@ xsc_vfio_destroy_cq(void *cq)
 	struct xsc_cmd_destroy_cq_mbox_in *in;
 	struct xsc_cmd_destroy_cq_mbox_out *out;
 	struct xsc_vfio_cq *data = (struct xsc_vfio_cq *)cq;
+	void *cmd_buf;
 
 	in_len = sizeof(struct xsc_cmd_destroy_cq_mbox_in);
 	out_len = sizeof(struct xsc_cmd_destroy_cq_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
 
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc cq destroy cmd memory");
 		return -rte_errno;
 	}
+
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_DESTROY_CQ);
 	in->cqn = rte_cpu_to_be_32(data->cqn);
-	out = (struct xsc_cmd_destroy_cq_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_vfio_mbox_exec(data->xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
 		PMD_DRV_LOG(ERR, "Failed to destroy cq, type=%d, err=%d, out.status=%u",
@@ -259,7 +266,7 @@ xsc_vfio_destroy_cq(void *cq)
 	rte_free(cq);
 
 exit:
-	free(in);
+	free(cmd_buf);
 	return ret;
 }
 
@@ -314,20 +321,22 @@ xsc_vfio_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcod
 	int in_len, out_len, cmd_len;
 	struct xsc_cmd_modify_qp_mbox_in *in;
 	struct xsc_cmd_modify_qp_mbox_out *out;
+	void *cmd_buf;
 
 	in_len = sizeof(struct xsc_cmd_modify_qp_mbox_in);
 	out_len = sizeof(struct xsc_cmd_modify_qp_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
 
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to alloc cmdq qp modify status");
 		rte_errno = ENOMEM;
 		return -rte_errno;
 	}
 
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
-	out = (struct xsc_cmd_modify_qp_mbox_out *)in;
+	out = cmd_buf;
 
 	for (i = 0; i < num; i++) {
 		in->hdr.opcode = rte_cpu_to_be_16(opcode);
@@ -346,7 +355,7 @@ xsc_vfio_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcod
 	}
 
 exit:
-	free(in);
+	free(cmd_buf);
 	return ret;
 }
 
@@ -357,18 +366,20 @@ xsc_vfio_modify_qp_qostree(struct xsc_dev *xdev, uint16_t qpn)
 	int in_len, out_len, cmd_len;
 	struct xsc_cmd_modify_raw_qp_mbox_in *in;
 	struct xsc_cmd_modify_raw_qp_mbox_out *out;
+	void *cmd_buf;
 
 	in_len = sizeof(struct xsc_cmd_modify_raw_qp_mbox_in);
 	out_len = sizeof(struct xsc_cmd_modify_raw_qp_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
 
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to alloc cmdq qp modify qostree");
 		rte_errno = ENOMEM;
 		return -rte_errno;
 	}
 
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_MODIFY_RAW_QP);
 	in->req.prio = 0;
@@ -377,7 +388,7 @@ xsc_vfio_modify_qp_qostree(struct xsc_dev *xdev, uint16_t qpn)
 	in->req.func_id = rte_cpu_to_be_16(xdev->hwinfo.func_id);
 	in->req.dma_direct = 0;
 	in->req.qpn = rte_cpu_to_be_16(qpn);
-	out = (struct xsc_cmd_modify_raw_qp_mbox_out *)in;
+	out = cmd_buf;
 
 	ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
@@ -389,7 +400,7 @@ xsc_vfio_modify_qp_qostree(struct xsc_dev *xdev, uint16_t qpn)
 	}
 
 exit:
-	free(in);
+	free(cmd_buf);
 	return ret;
 }
 
@@ -413,6 +424,7 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	struct xsc_cqe *cqes;
 	struct xsc_cmd_create_cq_mbox_in *in = NULL;
 	struct xsc_cmd_create_cq_mbox_out *out = NULL;
+	void *cmd_buf;
 
 	cqe_n = cq_params->wqe_s;
 	log_cq_sz = rte_log2_u32(cqe_n);
@@ -430,13 +442,14 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 		return -rte_errno;
 	}
 
-	in = malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc rx cq exec cmd memory");
 		goto error;
 	}
 
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_CQ);
 	in->ctx.eqn = 0;
@@ -460,7 +473,7 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	for (i = 0; i < pa_num; i++)
 		in->pas[i] = rte_cpu_to_be_64(cq_pas->iova + i * XSC_PAGE_SIZE);
 
-	out = (struct xsc_cmd_create_cq_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
 		PMD_DRV_LOG(ERR,
@@ -486,11 +499,11 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	PMD_DRV_LOG(INFO, "Port id=%d, Rx cqe_n:%d, cqn:%u",
 		    port_id, cq_info->cqe_n, cq_info->cqn);
 
-	free(in);
+	free(cmd_buf);
 	return 0;
 
 error:
-	free(in);
+	free(cmd_buf);
 	rte_memzone_free(cq_pas);
 	rte_free(cq);
 	return -rte_errno;
@@ -513,6 +526,7 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	int cqe_s = 1 << cq_params->elts_n;
 	uint64_t iova;
 	int i;
+	void *cmd_buf = NULL;
 
 	cq = rte_zmalloc(NULL, sizeof(struct xsc_vfio_cq), 0);
 	if (cq == NULL) {
@@ -539,12 +553,14 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	in_len = (sizeof(struct xsc_cmd_create_cq_mbox_in) + (pa_num * sizeof(uint64_t)));
 	out_len = sizeof(struct xsc_cmd_create_cq_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
-	in = (struct xsc_cmd_create_cq_mbox_in *)malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc tx cq exec cmd memory");
 		goto error;
 	}
+
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_CQ);
@@ -557,7 +573,7 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	for (i = 0; i < pa_num; i++)
 		in->pas[i] = rte_cpu_to_be_64(iova + i * XSC_PAGE_SIZE);
 
-	out = (struct xsc_cmd_create_cq_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
 		PMD_DRV_LOG(ERR, "Failed to create tx cq, port id=%u, err=%d, out.status=%u",
@@ -583,11 +599,11 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 		((volatile struct xsc_cqe *)(cqes + i))->owner = 1;
 	cq_info->cqes = cqes;
 
-	free(in);
+	free(cmd_buf);
 	return 0;
 
 error:
-	free(in);
+	free(cmd_buf);
 	rte_memzone_free(cq_pas);
 	rte_free(cq);
 	return -rte_errno;
@@ -613,6 +629,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	int i;
 	uint64_t iova;
 	char name[RTE_ETH_NAME_MAX_LEN] = {0};
+	void *cmd_buf = NULL;
 
 	qp = rte_zmalloc(NULL, sizeof(struct xsc_vfio_qp), 0);
 	if (qp == NULL) {
@@ -640,12 +657,14 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	in_len = (sizeof(struct xsc_cmd_create_qp_mbox_in) + (pa_num * sizeof(uint64_t)));
 	out_len = sizeof(struct xsc_cmd_create_qp_mbox_out);
 	cmd_len = RTE_MAX(in_len, out_len);
-	in = (struct xsc_cmd_create_qp_mbox_in *)malloc(cmd_len);
-	if (in == NULL) {
+	cmd_buf = malloc(cmd_len);
+	if (cmd_buf == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc tx qp exec cmd memory");
 		goto error;
 	}
+
+	in = cmd_buf;
 	memset(in, 0, cmd_len);
 
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_QP);
@@ -663,7 +682,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	for (i = 0; i < pa_num; i++)
 		in->req.pas[i] = rte_cpu_to_be_64(iova + i * XSC_PAGE_SIZE);
 
-	out = (struct xsc_cmd_create_qp_mbox_out *)in;
+	out = cmd_buf;
 	ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
 	if (ret != 0 || out->hdr.status != 0) {
 		PMD_DRV_LOG(ERR, "Failed to create tx qp, port id=%u, err=%d, out.status=%u",
@@ -685,11 +704,11 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	else
 		qp_info->qp_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_PF_TX_DB_ADDR);
 
-	free(in);
+	free(cmd_buf);
 	return 0;
 
 error:
-	free(in);
+	free(cmd_buf);
 	rte_memzone_free(qp_pas);
 	rte_free(qp);
 	return -rte_errno;
-- 
2.25.1
