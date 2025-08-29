Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197BC8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76EF04066E;
	Fri, 29 Aug 2025 10:24:35 +0200 (CEST)
Received: from lf-2-38.ptr.blmpb.com (lf-2-38.ptr.blmpb.com [101.36.218.38])
 by mails.dpdk.org (Postfix) with ESMTP id 9459A4065C
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455869; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=M9X+O3OkSlBw98wyxacXrKdZHOEg155gD3wIOuUEU3w=;
 b=B8WTLyDN7TJjA7cgQTTI30i8vNIkWc+ZTGCzbE1V33HcQmL4+ywLDx50XnI8JK3MYeUHUC
 Dp+qzZrhQoFMyvdGumhsPzWaO74XUcGDTCBWSKCQbvW+RVLpPBFy8FkABHHtCOFsT38mD6
 tkLWLilE6BvTsX4qiABDky36Y2a7Qlw/1y3L/I9bG32Hn/LvsxL4tUBjIJPR2+CNvcJCcL
 sOJv+NXcMgf94g2omEQRzm1vZEosLeMXsk2AeY5XPukxH3d0cZTbFRGsGlic75ckjCEH1q
 FEvKYBh4cmuUTSMocLrgEsaEjHCSflpT+JcLMCYN0gkmGu0Uh0Ad+Hcjj+UPRw==
X-Lms-Return-Path: <lba+268b163ba+bae027+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Mime-Version: 1.0
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:26 +0800
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Subject: [PATCH 09/14] net/xsc: optimize QP and CQ memory allocation
Date: Fri, 29 Aug 2025 16:24:26 +0800
Message-Id: <20250829082425.24369-10-wanry@yunsilicon.com>
To: <dev@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
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

Refactor memory allocation for XSC QP and CQ to use the local NUMA node.
Previously, allocations used SOCKET_ID_ANY, which could lead to remote
memory accesses. This patch ensures PAS and CQE memory are allocated
on the same NUMA node as the device, improving locality and performance.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_rx.c   | 11 +++++++++--
 drivers/net/xsc/xsc_rxtx.h |  3 +++
 drivers/net/xsc/xsc_tx.c   |  2 ++
 drivers/net/xsc/xsc_vfio.c | 32 ++++++++++++++++++++++++++------
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index c65afab51d..332ceb9606 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -383,6 +383,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	struct xsc_cmd_create_qp_request *req, *info;
 	struct xsc_hwinfo *hwinfo = &xdev->hwinfo;
 	char name[RTE_ETH_NAME_MAX_LEN] = { 0 };
+	uint32_t numa_node = priv->eth_dev->device->numa_node;
 
 	rxq_data = xsc_rxq_get(priv, 0);
 	if (rxq_data == NULL) {
@@ -390,6 +391,10 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		return -rte_errno;
 	}
 
+	if (numa_node != rxq_data->socket)
+		PMD_DRV_LOG(WARNING, "Port %u: rxq numa_node=%u, device numa_node=%u",
+			    port_id, rxq_data->socket, numa_node);
+
 	log_ele = rte_log2_u32(sizeof(struct xsc_wqe_data_seg));
 	wqe_n = rxq_data->wqe_s;
 	log_rq_sz = rte_log2_u32(wqe_n * hwinfo->recv_seg_num);
@@ -429,8 +434,9 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		snprintf(name, sizeof(name), "wqe_mem_rx_%d_%d", port_id, i);
 		rxq_data->rq_pas = rte_memzone_reserve_aligned(name,
 							       (XSC_PAGE_SIZE * pa_num),
-							       SOCKET_ID_ANY,
-							       0, XSC_PAGE_SIZE);
+							       rxq_data->socket,
+							       RTE_MEMZONE_IOVA_CONTIG,
+							       XSC_PAGE_SIZE);
 		if (rxq_data->rq_pas == NULL) {
 			rte_errno = ENOMEM;
 			PMD_DRV_LOG(ERR, "Failed to alloc rxq pas memory");
@@ -519,6 +525,7 @@ xsc_rxq_rss_obj_new(struct xsc_ethdev_priv *priv, uint16_t port_id)
 		cq_params.port_id = rxq_data->port_id;
 		cq_params.qp_id = rxq_data->idx;
 		cq_params.wqe_s = rxq_data->wqe_s;
+		cq_params.socket_id = rxq_data->socket;
 
 		ret = xsc_dev_rx_cq_create(xdev, &cq_params, &cq_info);
 		if (ret) {
diff --git a/drivers/net/xsc/xsc_rxtx.h b/drivers/net/xsc/xsc_rxtx.h
index 3606c151e6..129bbd2fa4 100644
--- a/drivers/net/xsc/xsc_rxtx.h
+++ b/drivers/net/xsc/xsc_rxtx.h
@@ -124,6 +124,7 @@ struct xsc_tx_cq_params {
 	uint16_t port_id;
 	uint16_t qp_id;
 	uint16_t elts_n;
+	int socket_id;
 };
 
 struct xsc_tx_cq_info {
@@ -141,6 +142,7 @@ struct xsc_tx_qp_params {
 	uint16_t port_id;
 	uint16_t qp_id;
 	uint16_t elts_n;
+	int socket_id;
 };
 
 struct xsc_tx_qp_info {
@@ -165,6 +167,7 @@ struct xsc_rx_cq_params {
 	uint16_t port_id;
 	uint16_t qp_id;
 	uint16_t wqe_s;
+	int socket_id;
 };
 
 struct xsc_rx_cq_info {
diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index 07888a5641..265439fec0 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -37,6 +37,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data, uint16_t id
 	cq_params.port_id = txq_data->port_id;
 	cq_params.qp_id = txq_data->idx;
 	cq_params.elts_n = txq_data->elts_n;
+	cq_params.socket_id = txq_data->socket;
 	ret = xsc_dev_tx_cq_create(xdev, &cq_params, &cq_info);
 	if (ret) {
 		rte_errno = errno;
@@ -60,6 +61,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data, uint16_t id
 	qp_params.port_id = txq_data->port_id;
 	qp_params.qp_id = idx;
 	qp_params.elts_n = txq_data->elts_n;
+	qp_params.socket_id = txq_data->socket;
 	ret = xsc_dev_tx_qp_create(xdev, &qp_params, &qp_info);
 
 	if (ret != 0) {
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 34b2a4c58b..1650a3ab2b 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -556,6 +556,11 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	struct xsc_cmd_create_cq_mbox_in *in = NULL;
 	struct xsc_cmd_create_cq_mbox_out *out = NULL;
 	void *cmd_buf;
+	int numa_node = xdev->pci_dev->device.numa_node;
+
+	if (numa_node != cq_params->socket_id)
+		PMD_DRV_LOG(WARNING, "Port %u rxq %u: cq numa_node=%u, device numa_node=%u",
+			    port_id, idx, cq_params->socket_id, numa_node);
 
 	cqe_n = cq_params->wqe_s;
 	log_cq_sz = rte_log2_u32(cqe_n);
@@ -592,8 +597,9 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	snprintf(name, sizeof(name), "mz_cqe_mem_rx_%u_%u", port_id, idx);
 	cq_pas = rte_memzone_reserve_aligned(name,
 					     (XSC_PAGE_SIZE * pa_num),
-					     SOCKET_ID_ANY,
-					     0, XSC_PAGE_SIZE);
+					     cq_params->socket_id,
+					     RTE_MEMZONE_IOVA_CONTIG,
+					     XSC_PAGE_SIZE);
 	if (cq_pas == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc rx cq pas memory");
@@ -658,6 +664,12 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	uint64_t iova;
 	int i;
 	void *cmd_buf = NULL;
+	int numa_node = xdev->pci_dev->device.numa_node;
+
+	if (numa_node != cq_params->socket_id)
+		PMD_DRV_LOG(WARNING, "Port %u txq %u: cq numa_node=%u, device numa_node=%u",
+			    cq_params->port_id, cq_params->qp_id,
+			    cq_params->socket_id, numa_node);
 
 	cq = rte_zmalloc(NULL, sizeof(struct xsc_vfio_cq), 0);
 	if (cq == NULL) {
@@ -672,8 +684,9 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	snprintf(name, sizeof(name), "mz_cqe_mem_tx_%u_%u", cq_params->port_id, cq_params->qp_id);
 	cq_pas = rte_memzone_reserve_aligned(name,
 					     (XSC_PAGE_SIZE * pa_num),
-					     SOCKET_ID_ANY,
-					     0, XSC_PAGE_SIZE);
+					     cq_params->socket_id,
+					     RTE_MEMZONE_IOVA_CONTIG,
+					     XSC_PAGE_SIZE);
 	if (cq_pas == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc tx cq pas memory");
@@ -762,6 +775,12 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	char name[RTE_ETH_NAME_MAX_LEN] = {0};
 	void *cmd_buf = NULL;
 	bool tso_en = !!(qp_params->tx_offloads & RTE_ETH_TX_OFFLOAD_TCP_TSO);
+	int numa_node = xdev->pci_dev->device.numa_node;
+
+	if (numa_node != qp_params->socket_id)
+		PMD_DRV_LOG(WARNING, "Port %u: txq %u numa_node=%u, device numa_node=%u",
+			    qp_params->port_id, qp_params->qp_id,
+			    qp_params->socket_id, numa_node);
 
 	qp = rte_zmalloc(NULL, sizeof(struct xsc_vfio_qp), 0);
 	if (qp == NULL) {
@@ -777,8 +796,9 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	snprintf(name, sizeof(name), "mz_wqe_mem_tx_%u_%u", qp_params->port_id, qp_params->qp_id);
 	qp_pas = rte_memzone_reserve_aligned(name,
 					     (XSC_PAGE_SIZE * pa_num),
-					     SOCKET_ID_ANY,
-					     0, XSC_PAGE_SIZE);
+					     qp_params->socket_id,
+					     RTE_MEMZONE_IOVA_CONTIG,
+					     XSC_PAGE_SIZE);
 	if (qp_pas == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc tx qp pas memory");
-- 
2.25.1
