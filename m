Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC442606A335
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HvqyZJOQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A237A42EF8;
	Tue,  3 Nov 2026 16:17:17 +0100 (CET)
Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
 by mails.dpdk.org (Postfix) with ESMTPS id E885A42EF8
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:15 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=fpr6UjQxXWbjJMrQyi8IaeSX+qmlRNe/C81BCVRnM4g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719035; v=1; x=1794323835;
 b=HvqyZJOQUOk/qiVqiH4Ap31DGdeTC+77xDncnig+ajiMxWdR40I//KSFU+uSU7PDrnwWkTjD
 VHGc9jScwIorDOaYhgRA2jLWjpi0t9t/F+gYULEM5KEXFYctfVxV2x/uABR8AKI1W2q65XFpsA/
 Pf4DIo1JoQwxsmiPUQiGIOuI=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 65cb6f149e40bbea;
 Tue, 03 Nov 2026 15:17:15 +0000
X-Mizu-Trace-ID: 65cb6f149e40bbea
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 155/227] net/xsc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:53 +0800
Message-ID: <20261103145306.487255-156-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/xsc/xsc_ethdev.c    |  4 ++--
 drivers/net/xsc/xsc_rx.c        |  2 +-
 drivers/net/xsc/xsc_rxtx.h      |  6 +++---
 drivers/net/xsc/xsc_tx.c        |  4 ++--
 drivers/net/xsc/xsc_vfio.c      | 18 +++++++++---------
 drivers/net/xsc/xsc_vfio_mbox.c |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 20d6f58f68..5a5c3976b2 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -497,7 +497,7 @@ xsc_ethdev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	if (!rte_is_power_of_2(desc))
 		desc_n = 1 << rte_log2_u32(desc);
 
-	rxq_data = rte_malloc_socket(NULL, sizeof(*rxq_data) + desc_n * sizeof(struct rte_mbuf *),
+	rxq_data = rte_malloc_numa(NULL, sizeof(*rxq_data) + desc_n * sizeof(struct rte_mbuf *),
 				     RTE_CACHE_LINE_SIZE, socket);
 	if (rxq_data == NULL) {
 		PMD_DRV_LOG(ERR, "Port %u create rxq idx %d failure",
@@ -543,7 +543,7 @@ xsc_ethdev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	if (!rte_is_power_of_2(desc))
 		desc_n = 1 << rte_log2_u32(desc);
 
-	txq = rte_malloc_socket(NULL, sizeof(*txq) + desc_n * sizeof(struct rte_mbuf *),
+	txq = rte_malloc_numa(NULL, sizeof(*txq) + desc_n * sizeof(struct rte_mbuf *),
 				RTE_CACHE_LINE_SIZE, socket);
 	txq->offloads = conf->offloads | dev->data->dev_conf.txmode.offloads;
 	txq->priv = priv;
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 13b2e26908..54329c350c 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -535,7 +535,7 @@ xsc_rxq_rss_obj_new(struct xsc_ethdev_priv *priv, uint16_t port_id)
 		cq_params.port_id = rxq_data->port_id;
 		cq_params.qp_id = rxq_data->idx;
 		cq_params.wqe_s = rxq_data->wqe_s;
-		cq_params.socket_id = rxq_data->socket;
+		cq_params.numa_id = rxq_data->socket;
 
 		ret = xsc_dev_rx_cq_create(xdev, &cq_params, &cq_info);
 		if (ret) {
diff --git a/drivers/net/xsc/xsc_rxtx.h b/drivers/net/xsc/xsc_rxtx.h
index 129bbd2fa4..de282b3a2f 100644
--- a/drivers/net/xsc/xsc_rxtx.h
+++ b/drivers/net/xsc/xsc_rxtx.h
@@ -124,7 +124,7 @@ struct xsc_tx_cq_params {
 	uint16_t port_id;
 	uint16_t qp_id;
 	uint16_t elts_n;
-	int socket_id;
+	int numa_id;
 };
 
 struct xsc_tx_cq_info {
@@ -142,7 +142,7 @@ struct xsc_tx_qp_params {
 	uint16_t port_id;
 	uint16_t qp_id;
 	uint16_t elts_n;
-	int socket_id;
+	int numa_id;
 };
 
 struct xsc_tx_qp_info {
@@ -167,7 +167,7 @@ struct xsc_rx_cq_params {
 	uint16_t port_id;
 	uint16_t qp_id;
 	uint16_t wqe_s;
-	int socket_id;
+	int numa_id;
 };
 
 struct xsc_rx_cq_info {
diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index 265439fec0..d94aa75167 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -37,7 +37,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data, uint16_t id
 	cq_params.port_id = txq_data->port_id;
 	cq_params.qp_id = txq_data->idx;
 	cq_params.elts_n = txq_data->elts_n;
-	cq_params.socket_id = txq_data->socket;
+	cq_params.numa_id = txq_data->socket;
 	ret = xsc_dev_tx_cq_create(xdev, &cq_params, &cq_info);
 	if (ret) {
 		rte_errno = errno;
@@ -61,7 +61,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data, uint16_t id
 	qp_params.port_id = txq_data->port_id;
 	qp_params.qp_id = idx;
 	qp_params.elts_n = txq_data->elts_n;
-	qp_params.socket_id = txq_data->socket;
+	qp_params.numa_id = txq_data->socket;
 	ret = xsc_dev_tx_qp_create(xdev, &qp_params, &qp_info);
 
 	if (ret != 0) {
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 0a1e507f7d..520c28722e 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -559,9 +559,9 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	void *cmd_buf;
 	int numa_node = xdev->pci_dev->device.numa_node;
 
-	if (numa_node != cq_params->socket_id)
+	if (numa_node != cq_params->numa_id)
 		PMD_DRV_LOG(WARNING, "Port %u rxq %u: cq numa_node=%u, device numa_node=%u",
-			    port_id, idx, cq_params->socket_id, numa_node);
+			    port_id, idx, cq_params->numa_id, numa_node);
 
 	cqe_n = cq_params->wqe_s * 2;
 	log_cq_sz = rte_log2_u32(cqe_n);
@@ -598,7 +598,7 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	snprintf(name, sizeof(name), "mz_cqe_mem_rx_%u_%u", port_id, idx);
 	cq_pas = rte_memzone_reserve_aligned(name,
 					     (XSC_PAGE_SIZE * pa_num),
-					     cq_params->socket_id,
+					     cq_params->numa_id,
 					     RTE_MEMZONE_IOVA_CONTIG,
 					     XSC_PAGE_SIZE);
 	if (cq_pas == NULL) {
@@ -664,10 +664,10 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	void *cmd_buf = NULL;
 	int numa_node = xdev->pci_dev->device.numa_node;
 
-	if (numa_node != cq_params->socket_id)
+	if (numa_node != cq_params->numa_id)
 		PMD_DRV_LOG(WARNING, "Port %u txq %u: cq numa_node=%u, device numa_node=%u",
 			    cq_params->port_id, cq_params->qp_id,
-			    cq_params->socket_id, numa_node);
+			    cq_params->numa_id, numa_node);
 
 	cq = rte_zmalloc(NULL, sizeof(struct xsc_vfio_cq), 0);
 	if (cq == NULL) {
@@ -682,7 +682,7 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 	snprintf(name, sizeof(name), "mz_cqe_mem_tx_%u_%u", cq_params->port_id, cq_params->qp_id);
 	cq_pas = rte_memzone_reserve_aligned(name,
 					     (XSC_PAGE_SIZE * pa_num),
-					     cq_params->socket_id,
+					     cq_params->numa_id,
 					     RTE_MEMZONE_IOVA_CONTIG,
 					     XSC_PAGE_SIZE);
 	if (cq_pas == NULL) {
@@ -772,10 +772,10 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	bool tso_en = !!(qp_params->tx_offloads & RTE_ETH_TX_OFFLOAD_TCP_TSO);
 	int numa_node = xdev->pci_dev->device.numa_node;
 
-	if (numa_node != qp_params->socket_id)
+	if (numa_node != qp_params->numa_id)
 		PMD_DRV_LOG(WARNING, "Port %u: txq %u numa_node=%u, device numa_node=%u",
 			    qp_params->port_id, qp_params->qp_id,
-			    qp_params->socket_id, numa_node);
+			    qp_params->numa_id, numa_node);
 
 	qp = rte_zmalloc(NULL, sizeof(struct xsc_vfio_qp), 0);
 	if (qp == NULL) {
@@ -791,7 +791,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	snprintf(name, sizeof(name), "mz_wqe_mem_tx_%u_%u", qp_params->port_id, qp_params->qp_id);
 	qp_pas = rte_memzone_reserve_aligned(name,
 					     (XSC_PAGE_SIZE * pa_num),
-					     qp_params->socket_id,
+					     qp_params->numa_id,
 					     RTE_MEMZONE_IOVA_CONTIG,
 					     XSC_PAGE_SIZE);
 	if (qp_pas == NULL) {
diff --git a/drivers/net/xsc/xsc_vfio_mbox.c b/drivers/net/xsc/xsc_vfio_mbox.c
index 6d6cc677a7..da063249c4 100644
--- a/drivers/net/xsc/xsc_vfio_mbox.c
+++ b/drivers/net/xsc/xsc_vfio_mbox.c
@@ -562,7 +562,7 @@ xsc_vfio_mbox_init(struct xsc_dev *xdev)
 	snprintf(name, RTE_MEMZONE_NAMESIZE, "%s_cmdq", xdev->pci_dev->device.name);
 	size = (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_req_layout);
 	cmdq->req_mz = rte_memzone_reserve_aligned(name,
-						   size, SOCKET_ID_ANY,
+						   size, RTE_NUMA_ID_ANY,
 						   RTE_MEMZONE_IOVA_CONTIG,
 						   XSC_PAGE_SIZE);
 	if (cmdq->req_mz == NULL) {
@@ -574,7 +574,7 @@ xsc_vfio_mbox_init(struct xsc_dev *xdev)
 	snprintf(name, RTE_MEMZONE_NAMESIZE, "%s_cmd_cq", xdev->pci_dev->device.name);
 	size = (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_layout); /* -V1048 */
 	cmdq->rsp_mz = rte_memzone_reserve_aligned(name,
-						   size, SOCKET_ID_ANY,
+						   size, RTE_NUMA_ID_ANY,
 						   RTE_MEMZONE_IOVA_CONTIG,
 						   XSC_PAGE_SIZE);
 	if (cmdq->rsp_mz == NULL) {
@@ -588,7 +588,7 @@ xsc_vfio_mbox_init(struct xsc_dev *xdev)
 						 sizeof(struct xsc_cmdq_mbox_buf),
 						 XSC_MBOX_BUF_CACHE_SIZE, 0,
 						 NULL, NULL, NULL, NULL,
-						 SOCKET_ID_ANY, 0);
+						 RTE_NUMA_ID_ANY, 0);
 	if (cmdq->mbox_buf_pool == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to create mailbox buf pool");
 		goto error;
-- 
2.55.0

