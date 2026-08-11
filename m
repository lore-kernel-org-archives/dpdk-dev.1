Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B1C5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9E24410E3;
	Tue, 11 Aug 2026 13:57:40 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6222540ED9
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:57:39 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C42E2001AE;
 Tue, 11 Aug 2026 13:57:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EF982001A0;
 Tue, 11 Aug 2026 13:57:39 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8620A18000B0;
 Tue, 11 Aug 2026 19:57:37 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v8 02/26] drivers: improve  crypto fq resource handling
Date: Tue, 11 Aug 2026 17:27:07 +0530
Message-Id: <20260811115731.3421032-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
References: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
 <20260811115731.3421032-1-hemant.agrawal@nxp.com>
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

Release resource in fallback and quit processes.
Alloc multiple FQIDs from kernel by single ioctl to reduce boot/quit time.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |   1 +
 drivers/bus/dpaa/include/fsl_qman.h      |   1 +
 drivers/crypto/dpaa_sec/dpaa_sec.c       | 106 +++++++++++++++++++----
 3 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 522cdca27e..c2726f2d59 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -51,6 +51,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_release_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 82269cdf99..52027b194d 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1887,6 +1887,7 @@ static inline int qman_alloc_fqid(u32 *result)
  * This function can also be used to seed the allocator with ranges of FQIDs
  * that it can subsequently allocate from.
  */
+__rte_internal
 void qman_release_fqid_range(u32 fqid, unsigned int count);
 static inline void qman_release_fqid(u32 fqid)
 {
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..52666150f6 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -188,16 +188,15 @@ dqrr_out_fq_cb_rx(struct qman_portal *qm __always_unused,
 
 /* caam result is put into this queue */
 static int
-dpaa_sec_init_tx(struct qman_fq *fq)
+dpaa_sec_init_tx(struct qman_fq *fq, uint32_t fqid)
 {
 	int ret;
 	struct qm_mcc_initfq opts;
 	uint32_t flags;
 
-	flags = QMAN_FQ_FLAG_NO_ENQUEUE | QMAN_FQ_FLAG_LOCKED |
-		QMAN_FQ_FLAG_DYNAMIC_FQID;
+	flags = QMAN_FQ_FLAG_NO_ENQUEUE | QMAN_FQ_FLAG_LOCKED;
 
-	ret = qman_create_fq(0, flags, fq);
+	ret = qman_create_fq(fqid, flags, fq);
 	if (unlikely(ret)) {
 		DPAA_SEC_ERR("qman_create_fq failed");
 		return ret;
@@ -3614,12 +3613,37 @@ static const struct rte_security_ops dpaa_sec_security_ops = {
 static int
 dpaa_sec_uninit(struct rte_cryptodev *dev)
 {
-	if (dev == NULL)
+	struct dpaa_sec_dev_private *internals;
+	uint32_t i, fqid;
+	int ret;
+
+	if (!dev)
 		return -ENODEV;
+	internals = dev->data->dev_private;
+	fqid = internals->qps[0].outq.fqid;
+	for (i = 0; i < internals->max_nb_queue_pairs; i++) {
+		ret = qman_shutdown_fq(&internals->qps[i].outq);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown TXQ(0x%08x)",
+				dev->data->name, ret, internals->qps[i].outq.fqid);
+		}
+	}
+	if (fqid)
+		qman_release_fqid_range(fqid, internals->max_nb_queue_pairs);
+
+	fqid = internals->inq[0].fqid;
+	for (i = 0; i < RTE_DPAA_MAX_RX_QUEUE; i++) {
+		ret = qman_shutdown_fq(&internals->inq[i]);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown RXQ[%d](0x%08x)",
+				dev->data->name, ret, i, internals->inq[i].fqid);
+		}
+	}
+	qman_release_fqid_range(fqid, RTE_DPAA_MAX_RX_QUEUE);
 
 	rte_free(dev->security_ctx);
 	DPAA_SEC_INFO("Closing DPAA_SEC device %s on numa socket %u",
-		      dev->data->name, rte_socket_id());
+		dev->data->name, rte_socket_id());
 
 	return 0;
 }
@@ -3666,10 +3690,9 @@ dpaa_sec_dev_init(struct rte_cryptodev *cryptodev)
 	struct dpaa_sec_dev_private *internals;
 	struct rte_security_ctx *security_instance;
 	struct dpaa_sec_qp *qp;
-	uint32_t i, flags;
-	int ret;
+	uint32_t i, j, flags, fqids[RTE_DPAA_MAX_RX_QUEUE];
+	int ret, num = 0, map_fd = -1;
 	void *cmd_map;
-	int map_fd = -1;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -3735,24 +3758,48 @@ dpaa_sec_dev_init(struct rte_cryptodev *cryptodev)
 	security_instance->sess_cnt = 0;
 	cryptodev->security_ctx = security_instance;
 	rte_spinlock_init(&internals->lock);
+	num = qman_alloc_fqid_range(fqids, internals->max_nb_queue_pairs, 0, 0);
+	if (num < (int)internals->max_nb_queue_pairs) {
+		if (num < 0) {
+			DPAA_SEC_ERR("%s: Failed(%d) to alloc %d TX fqids",
+				cryptodev->data->name, num, internals->max_nb_queue_pairs);
+		} else {
+			DPAA_SEC_ERR("%s: Alloc %d fqids < %d",
+				cryptodev->data->name, num, internals->max_nb_queue_pairs);
+			qman_release_fqid_range(fqids[0], num);
+		}
+		ret = -ENODEV;
+		goto init_error;
+	}
 	for (i = 0; i < internals->max_nb_queue_pairs; i++) {
 		/* init qman fq for queue pair */
 		qp = &internals->qps[i];
-		ret = dpaa_sec_init_tx(&qp->outq);
+		ret = dpaa_sec_init_tx(&qp->outq, fqids[i]);
 		if (ret) {
-			DPAA_SEC_ERR("config tx of queue pair  %d", i);
-			goto init_error;
+			DPAA_SEC_ERR("%s: Failed(%d) to init TXQ[%d](0x%08x)",
+				cryptodev->data->name, ret, i, fqids[i]);
+			goto init_error1;
 		}
 	}
 
-	flags = QMAN_FQ_FLAG_LOCKED | QMAN_FQ_FLAG_DYNAMIC_FQID |
-		QMAN_FQ_FLAG_TO_DCPORTAL;
+	flags = QMAN_FQ_FLAG_LOCKED | QMAN_FQ_FLAG_TO_DCPORTAL;
+	num = qman_alloc_fqid_range(fqids, RTE_DPAA_MAX_RX_QUEUE, 0, 0);
+	if (num < RTE_DPAA_MAX_RX_QUEUE) {
+		if (num < 0) {
+			DPAA_SEC_ERR("Failed(%d) to alloc %d fqids", ret, RTE_DPAA_MAX_RX_QUEUE);
+		} else {
+			DPAA_SEC_ERR("Alloc %d fqids < %d", ret, RTE_DPAA_MAX_RX_QUEUE);
+			qman_release_fqid_range(fqids[0], num);
+		}
+		goto init_error2;
+	}
 	for (i = 0; i < RTE_DPAA_MAX_RX_QUEUE; i++) {
 		/* create rx qman fq for sessions*/
-		ret = qman_create_fq(0, flags, &internals->inq[i]);
-		if (unlikely(ret != 0)) {
-			DPAA_SEC_ERR("sec qman_create_fq failed");
-			goto init_error;
+		ret = qman_create_fq(fqids[i], flags, &internals->inq[i]);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to create RXQ[%d](0x%08x)",
+				cryptodev->data->name, ret, i, fqids[i]);
+			goto init_error3;
 		}
 	}
 
@@ -3761,6 +3808,29 @@ dpaa_sec_dev_init(struct rte_cryptodev *cryptodev)
 	DPAA_SEC_INFO("%s cryptodev init", cryptodev->data->name);
 	return 0;
 
+init_error3:
+	for (j = 0; j < i; j++) {
+		ret = qman_shutdown_fq(&internals->inq[j]);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown RXQ(0x%08x)",
+				cryptodev->data->name, ret, internals->inq[j].fqid);
+		}
+	}
+	qman_release_fqid_range(fqids[0], RTE_DPAA_MAX_RX_QUEUE);
+init_error2:
+	i = internals->max_nb_queue_pairs;
+	fqids[0] = internals->qps[0].outq.fqid;
+init_error1:
+	for (j = 0; j < i; j++) {
+		qp = &internals->qps[j];
+		ret = qman_shutdown_fq(&qp->outq);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown TXQ(0x%08x)",
+				cryptodev->data->name, ret, qp->outq.fqid);
+		}
+	}
+	qman_release_fqid_range(fqids[0], internals->max_nb_queue_pairs);
+
 init_error:
 	DPAA_SEC_ERR("driver %s: create failed", cryptodev->data->name);
 
-- 
2.25.1

