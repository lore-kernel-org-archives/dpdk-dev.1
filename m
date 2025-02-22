Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176A6C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1256E427DF;
	Sat, 22 Feb 2025 04:57:48 +0100 (CET)
Received: from lf-2-36.ptr.blmpb.com (lf-2-36.ptr.blmpb.com [101.36.218.36])
 by mails.dpdk.org (Postfix) with ESMTP id 8A09C427CC
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196660; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QtdMpqztskfaCCuqWuqKbjgOkXQZsI/ZEg6EGeWBLFw=;
 b=Kx1cvRQhTagKGqT2H7Eag0efqcKdFJC+LSZmueTDiN9Jy1aVqk9CXqYhyNhvzPJ9LmgQ2B
 MPoq2SPCPQap9BwtsvQekHpRXtxDwh79PuMyrZqwRbv/W7tLxvqaSDLYZoyTHrFEXCoxan
 EWZMiPgQQiI8ATkAIsbbX3JO55g6C7+kooqUus9maIIv9rfdWClBSUE2Zo/QFm8Gcg22Qh
 k4SBg5FjuY0Uaut4GRLF+jyyqg3tJ++QwGP3fOfTktAc30avrn5zxHMa6j6INtwrsBi+v1
 8l4o6UJo1hacKERyI5WRODyQlCCR39iUckysHpTX69hVgKOkmyYAhIjT2bodYQ==
Message-Id: <20250222035736.2290067-4-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 03/12] net/xsc: address incorrect format warnings
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:37 +0800
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b32+e1adb5+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Sat, 22 Feb 2025 11:57:37 +0800
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

These warnings reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v576/

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c       | 2 +-
 drivers/net/xsc/xsc_rx.c        | 4 ++--
 drivers/net/xsc/xsc_tx.c        | 4 ++--
 drivers/net/xsc/xsc_vfio.c      | 4 ++--
 drivers/net/xsc/xsc_vfio_mbox.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index c836f2f35a..1e3dd493f9 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -289,7 +289,7 @@ xsc_dev_repr_ports_probe(struct xsc_dev *xdev, int nb_repr_ports, int max_eth_po
 
 	xdev->num_repr_ports = nb_repr_ports + XSC_PHY_PORT_NUM;
 	if (xdev->num_repr_ports > max_eth_ports) {
-		PMD_DRV_LOG(ERR, "Repr ports num %u, should be less than max %u",
+		PMD_DRV_LOG(ERR, "Repr ports num %d, should be less than max %d",
 			    xdev->num_repr_ports, max_eth_ports);
 		return -EINVAL;
 	}
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 58a9cc2f26..3230710656 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -358,7 +358,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		xsc_rxq_initialize(xdev, rxq_data);
 		rxq_data->cq_ci = 0;
 		priv->dev_data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
-		PMD_DRV_LOG(INFO, "Port %u create rx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%d",
+		PMD_DRV_LOG(INFO, "Port %d create rx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%u",
 			    port_id,
 			    rxq_data->wqe_s, rxq_data->wqe_n,
 			    rxq_data->rq_db, rxq_data->qpn);
@@ -407,7 +407,7 @@ xsc_rxq_rss_obj_new(struct xsc_ethdev_priv *priv, uint16_t port_id)
 		rxq_data->cq_db = cq_info.cq_db;
 		rxq_data->cqn = cq_info.cqn;
 
-		PMD_DRV_LOG(INFO, "Port %u create rx cq, cqe_s:%d, cqe_n:%d, cq_db=%p, cqn:%d",
+		PMD_DRV_LOG(INFO, "Port %u create rx cq, cqe_s:%d, cqe_n:%d, cq_db=%p, cqn:%u",
 			    port_id,
 			    rxq_data->cqe_s, rxq_data->cqe_n,
 			    rxq_data->cq_db, rxq_data->cqn);
diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index 1d31e84d69..0d6a9981d0 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -52,7 +52,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
 	txq_data->cqes = cq_info.cqes;
 	txq_data->cqe_m = (uint16_t)(1 << cq_info.cqe_n) - 1;
 
-	PMD_DRV_LOG(INFO, "Create tx cq, cqe_s:%d, cqe_n:%d, cq_db=%p, cqn:%d",
+	PMD_DRV_LOG(INFO, "Create tx cq, cqe_s:%d, cqe_n:%d, cq_db=%p, cqn:%u",
 		    txq_data->cqe_s, txq_data->cqe_n,
 		    txq_data->cq_db, txq_data->cqn);
 
@@ -83,7 +83,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
 	txq_data->wqe_pi = 0;
 	txq_data->wqe_comp = 0;
 
-	PMD_DRV_LOG(INFO, "Create tx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%d",
+	PMD_DRV_LOG(INFO, "Create tx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%u",
 		    txq_data->wqe_s, txq_data->wqe_n,
 		    txq_data->qp_db, txq_data->qpn);
 	return 0;
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index e8fefb9e94..6c679449af 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -337,7 +337,7 @@ xsc_vfio_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcod
 
 		ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
 		if (ret != 0 || out->hdr.status != 0) {
-			PMD_DRV_LOG(ERR, "Modify qp status failed, qpn=%d, err=%d, out.status=%u",
+			PMD_DRV_LOG(ERR, "Modify qp status failed, qpn=%u, err=%d, out.status=%u",
 				    qpn + i, ret, out->hdr.status);
 			rte_errno = ENOEXEC;
 			ret = -rte_errno;
@@ -483,7 +483,7 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	cq_info->cqn = rte_be_to_cpu_32(out->cqn);
 	cq->cqn = cq_info->cqn;
 	cq->xdev = xdev;
-	PMD_DRV_LOG(INFO, "Port id=%d, Rx cqe_n:%d, cqn:%d",
+	PMD_DRV_LOG(INFO, "Port id=%d, Rx cqe_n:%d, cqn:%u",
 		    port_id, cq_info->cqe_n, cq_info->cqn);
 
 	free(in);
diff --git a/drivers/net/xsc/xsc_vfio_mbox.c b/drivers/net/xsc/xsc_vfio_mbox.c
index 454fe64645..c465679527 100644
--- a/drivers/net/xsc/xsc_vfio_mbox.c
+++ b/drivers/net/xsc/xsc_vfio_mbox.c
@@ -515,7 +515,7 @@ xsc_cmdq_req_status_restore(struct xsc_dev *xdev, struct xsc_cmd_queue *cmdq)
 	if (req_pid >= (uint32_t)(1 << cmdq->depth_n) ||
 	    req_cid >= (uint32_t)(1 << cmdq->depth_n)) {
 		PMD_DRV_LOG(ERR, "Request pid %u and cid %u must be less than %u",
-			    req_pid, req_cid, 1 << cmdq->depth_n);
+			    req_pid, req_cid, (uint32_t)(1 << cmdq->depth_n));
 		return -1;
 	}
 
-- 
2.25.1
