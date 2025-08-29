Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FAC8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:24:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 643E74064C;
	Fri, 29 Aug 2025 10:24:26 +0200 (CEST)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id E15F340430
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455852; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=hnRf9cb5DcYTs+OrITRKmj97JbcA9gpMOz8pSi2LtAA=;
 b=U9aVKNXW6CH9M5U648YK3/x/I1+aKp8NcXEnw3nh6fdyxGyUikslQJN/Fp45Qz5q5PaG3K
 J66oS+pClkKAqiBOBZjC770uRQSIM+MzN19VKWv/rvKbKijhLOR1013OoyxgDP3WMPH5Rv
 jDtCq1h3+UBU5On9xvbamm1i8gR77tNj3VDWW89+jt+YrnXtBgmbaIOTskQChC8EWGb1C6
 7zbD08nJ0lqWty4GOFwZtCDxJpHTQt6zCJRRqFHH3pBB1Wkm9aBzLv7uH/FRzkSi+4tMi1
 BHQ/APRpeqZRxj/+406gWOVDIaNLwpnmd4BRJlThsdqxt0R0nnbeDEsg0r5HcQ==
Subject: [PATCH 02/14] net/xsc: add TSO support
Date: Fri, 29 Aug 2025 16:24:10 +0800
Mime-Version: 1.0
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
X-Lms-Return-Path: <lba+268b163ab+95621b+dpdk.org+wanry@yunsilicon.com>
Message-Id: <20250829082409.24369-3-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:10 +0800
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

Introduce TCP segmentation offload (TSO) support for xsc PMD.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |  1 +
 drivers/net/xsc/xsc_ethdev.c     |  3 +--
 drivers/net/xsc/xsc_tx.c         | 12 +++++++-----
 drivers/net/xsc/xsc_tx.h         |  3 +--
 drivers/net/xsc/xsc_vfio.c       |  4 +++-
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index e0f7b0bc1f..3b02289764 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 MTU update           = Y
+TSO                  = Y
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 79c4e13cd4..9a70be0543 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -223,7 +223,6 @@ xsc_txq_start(struct xsc_ethdev_priv *priv)
 {
 	struct xsc_txq_data *txq_data;
 	struct rte_eth_dev *dev = priv->eth_dev;
-	uint64_t offloads = dev->data->dev_conf.txmode.offloads;
 	uint16_t i;
 	int ret;
 	size_t size;
@@ -239,7 +238,7 @@ xsc_txq_start(struct xsc_ethdev_priv *priv)
 		if (txq_data == NULL)
 			goto error;
 		xsc_txq_elts_alloc(txq_data);
-		ret = xsc_txq_obj_new(priv->xdev, txq_data, offloads, i);
+		ret = xsc_txq_obj_new(priv->xdev, txq_data, i);
 		if (ret < 0)
 			goto error;
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index d1a0f3284b..07888a5641 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -26,8 +26,7 @@ xsc_txq_elts_alloc(struct xsc_txq_data *txq_data)
 }
 
 int
-xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
-		uint64_t offloads, uint16_t idx)
+xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data, uint16_t idx)
 {
 	int ret = 0;
 	struct xsc_tx_cq_params cq_params = {0};
@@ -57,7 +56,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
 		    txq_data->cq_db, txq_data->cqn);
 
 	qp_params.cq = txq_data->cq;
-	qp_params.tx_offloads = offloads;
+	qp_params.tx_offloads = txq_data->offloads;
 	qp_params.port_id = txq_data->port_id;
 	qp_params.qp_id = idx;
 	qp_params.elts_n = txq_data->elts_n;
@@ -76,6 +75,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
 	txq_data->wqe_m = txq_data->wqe_s - 1;
 	txq_data->wqe_ds_n = rte_log2_u32(xdev->hwinfo.send_seg_num);
 	txq_data->qp_db =  qp_info.qp_db;
+	txq_data->tso_en = qp_info.tso_en ? 1 : 0;
 
 	txq_data->cq_ci = 0;
 	txq_data->cq_pi = 0;
@@ -83,9 +83,11 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
 	txq_data->wqe_pi = 0;
 	txq_data->wqe_comp = 0;
 
-	PMD_DRV_LOG(INFO, "Create tx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%u",
+	PMD_DRV_LOG(INFO, "Create tx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%u, %s",
 		    txq_data->wqe_s, txq_data->wqe_n,
-		    txq_data->qp_db, txq_data->qpn);
+		    txq_data->qp_db, txq_data->qpn,
+		    txq_data->tso_en ? "tso" : "non-tso");
+
 	return 0;
 
 error:
diff --git a/drivers/net/xsc/xsc_tx.h b/drivers/net/xsc/xsc_tx.h
index 88419dd3a0..a6a034a8ea 100644
--- a/drivers/net/xsc/xsc_tx.h
+++ b/drivers/net/xsc/xsc_tx.h
@@ -53,8 +53,7 @@ struct __rte_cache_aligned xsc_txq_data {
 };
 
 uint16_t xsc_tx_burst(void *dpdk_txq, struct rte_mbuf **pkts, uint16_t pkts_n);
-int xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
-		    uint64_t offloads, uint16_t idx);
+int xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data, uint16_t idx);
 void xsc_txq_elts_alloc(struct xsc_txq_data *txq_data);
 void xsc_txq_obj_release(struct xsc_dev *xdev, struct xsc_txq_data *txq_data);
 void xsc_txq_elts_free(struct xsc_txq_data *txq_data);
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 857fa449f0..f61cf92569 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -649,6 +649,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	uint64_t iova;
 	char name[RTE_ETH_NAME_MAX_LEN] = {0};
 	void *cmd_buf = NULL;
+	bool tso_en = !!(qp_params->tx_offloads & RTE_ETH_TX_OFFLOAD_TCP_TSO);
 
 	qp = rte_zmalloc(NULL, sizeof(struct xsc_vfio_qp), 0);
 	if (qp == NULL) {
@@ -689,7 +690,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_QP);
 	in->req.input_qpn = 0;
 	in->req.pa_num = rte_cpu_to_be_16(pa_num);
-	in->req.qp_type = XSC_QUEUE_TYPE_RAW_TX;
+	in->req.qp_type = tso_en ? XSC_QUEUE_TYPE_RAW_TSO : XSC_QUEUE_TYPE_RAW_TX;
 	in->req.log_sq_sz = log_sq_sz;
 	in->req.log_rq_sz = log_rq_sz;
 	in->req.dma_direct = 0;
@@ -717,6 +718,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	qp_info->qpn = qp->qpn;
 	qp_info->wqes = (struct xsc_wqe *)qp->mz->addr;
 	qp_info->wqe_n = rte_log2_u32(wqe_s);
+	qp_info->tso_en = tso_en ? 1 : 0;
 
 	if (xsc_dev_is_vf(xdev))
 		qp_info->qp_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_VF_TX_DB_ADDR);
-- 
2.25.1
