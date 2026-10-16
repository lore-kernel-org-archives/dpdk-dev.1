Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64379CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFBE140E0B;
	Fri, 16 Oct 2026 13:20:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9E7E740B8C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:20:10 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80644200201;
 Fri, 16 Oct 2026 13:20:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 535A12001FF;
 Fri, 16 Oct 2026 13:20:10 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CAF14180006C;
 Fri, 16 Oct 2026 19:20:09 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v27 24/25] drivers: improve DPAA crypto fq resource handling
Date: Fri, 16 Oct 2026 16:49:57 +0530
Message-Id: <20261016111958.163060-25-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016111958.163060-1-hemant.agrawal@nxp.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
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

Release resources on probe failure and on uninit, and allocate the FQID
range for a queue pair with a single ioctl instead of one per FQID to
cut boot and quit time.

Export qman_release_fqid_range() from the bus, which dpaa_sec_uninit()
needs to return the queue FQIDs in ranges.

qman_shutdown_fq() falls back to get_affine_portal() when fq->qp is
NULL, so affine a portal first in dpaa_sec_uninit() as probe does;
rte_dev_remove() can run on a thread that never did. Release an FQID
only once its queue actually shut down, in both uninit and the probe
error paths: one that did not is still live in QMan, and handing its
FQID back would let qman_alloc_fqid() give it to another user.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c       |   6 +
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |   2 +
 drivers/bus/dpaa/include/fsl_qman.h      |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c       | 176 ++++++++++++++++++++---
 4 files changed, 168 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 584abdc293..62cb5e4cba 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1585,6 +1585,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 	return -EIO;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qman_destroy_fq)
 void qman_destroy_fq(struct qman_fq *fq, u32 flags __maybe_unused)
 {
 	/*
@@ -2987,6 +2988,11 @@ qman_shutdown_fq(struct qman_fq *fq)
 		ret = -EIO;
 	}
 
+	if (!ret) {
+		fq->state = qman_fq_state_oos;
+		qman_destroy_fq(fq, 0);
+	}
+
 out:
 	return ret;
 }
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 0927e5fe2c..ec3dd2913f 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -52,6 +52,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_release_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
@@ -79,6 +80,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(qman_dqrr_consume)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_static_dequeue_add)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_dca_index)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_create_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_destroy_fq)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_fqid)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_state)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_init_fq)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 59b41e17f0..8d0d1df950 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1585,6 +1585,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq);
  * FQ must be in the 'out-of-service' state unless the QMAN_FQ_FREE_PARKED flag
  * is specified, in which case it may also be in the 'parked' state.
  */
+__rte_internal
 void qman_destroy_fq(struct qman_fq *fq, u32 flags);
 
 /**
@@ -1895,6 +1896,7 @@ static inline int qman_alloc_fqid(u32 *result)
  * This function can also be used to seed the allocator with ranges of FQIDs
  * that it can subsequently allocate from.
  */
+__rte_internal
 void qman_release_fqid_range(u32 fqid, unsigned int count);
 static inline void qman_release_fqid(u32 fqid)
 {
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..6972699c51 100644
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
@@ -3614,12 +3613,73 @@ static const struct rte_security_ops dpaa_sec_security_ops = {
 static int
 dpaa_sec_uninit(struct rte_cryptodev *dev)
 {
-	if (dev == NULL)
+	struct dpaa_sec_dev_private *internals;
+	uint32_t i, fqid, base, run;
+	int ret;
+
+	if (!dev)
 		return -ENODEV;
 
+	/* FQs and FQIDs are owned by the primary process. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	/* qman_shutdown_fq() needs an affine portal for fq->qp == NULL. */
+	if (unlikely(!DPAA_PER_LCORE_PORTAL)) {
+		ret = rte_dpaa_portal_init((void *)0);
+		if (ret) {
+			DPAA_SEC_ERR("Failure in affining portal");
+			return ret;
+		}
+	}
+
+	internals = dev->data->dev_private;
+	/* Only release the FQID of a queue that actually shut down: one that
+	 * did not is still live in QMan. Free in runs of adjacent FQIDs.
+	 */
+	base = 0;
+	run = 0;
+	for (i = 0; i < internals->max_nb_queue_pairs; i++) {
+		fqid = internals->qps[i].outq.fqid;
+		ret = qman_shutdown_fq(&internals->qps[i].outq);
+		if (ret)
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown TXQ(0x%08x), fqid not released",
+				dev->data->name, ret, fqid);
+		if (run && (ret || fqid != base + run)) {
+			qman_release_fqid_range(base, run);
+			run = 0;
+		}
+		if (ret || !fqid)
+			continue;
+		if (run++ == 0)
+			base = fqid;
+	}
+	if (run)
+		qman_release_fqid_range(base, run);
+
+	base = 0;
+	run = 0;
+	for (i = 0; i < RTE_DPAA_MAX_RX_QUEUE; i++) {
+		fqid = internals->inq[i].fqid;
+		ret = qman_shutdown_fq(&internals->inq[i]);
+		if (ret)
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown RXQ[%d](0x%08x), fqid not released",
+				dev->data->name, ret, i, fqid);
+		if (run && (ret || fqid != base + run)) {
+			qman_release_fqid_range(base, run);
+			run = 0;
+		}
+		if (ret || !fqid)
+			continue;
+		if (run++ == 0)
+			base = fqid;
+	}
+	if (run)
+		qman_release_fqid_range(base, run);
+
 	rte_free(dev->security_ctx);
 	DPAA_SEC_INFO("Closing DPAA_SEC device %s on numa socket %u",
-		      dev->data->name, rte_socket_id());
+		dev->data->name, rte_socket_id());
 
 	return 0;
 }
@@ -3666,10 +3726,10 @@ dpaa_sec_dev_init(struct rte_cryptodev *cryptodev)
 	struct dpaa_sec_dev_private *internals;
 	struct rte_security_ctx *security_instance;
 	struct dpaa_sec_qp *qp;
-	uint32_t i, flags;
-	int ret;
+	uint32_t i, j, flags, fqids[RTE_DPAA_MAX_RX_QUEUE];
+	uint32_t fqid, base, run;
+	int ret, num = 0, map_fd = -1;
 	void *cmd_map;
-	int map_fd = -1;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -3735,24 +3795,47 @@ dpaa_sec_dev_init(struct rte_cryptodev *cryptodev)
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
+			DPAA_SEC_ERR("Failed(%d) to alloc %d fqids", num, RTE_DPAA_MAX_RX_QUEUE);
+		} else {
+			DPAA_SEC_ERR("Alloc %d fqids < %d", num, RTE_DPAA_MAX_RX_QUEUE);
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
 
@@ -3761,6 +3844,63 @@ dpaa_sec_dev_init(struct rte_cryptodev *cryptodev)
 	DPAA_SEC_INFO("%s cryptodev init", cryptodev->data->name);
 	return 0;
 
+init_error3:
+	/* Same rule as in uninit: do not release the FQID of a queue that
+	 * failed to shut down.
+	 */
+	base = 0;
+	run = 0;
+	for (j = 0; j < i; j++) {
+		fqid = internals->inq[j].fqid;
+		ret = qman_shutdown_fq(&internals->inq[j]);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown RXQ(0x%08x), fqid not released",
+				cryptodev->data->name, ret, fqid);
+		}
+		if (run && (ret || fqid != base + run)) {
+			qman_release_fqid_range(base, run);
+			run = 0;
+		}
+		if (ret || !fqid)
+			continue;
+		if (run++ == 0)
+			base = fqid;
+	}
+	if (run)
+		qman_release_fqid_range(base, run);
+	/* FQIDs of the queues that were never created */
+	if (i < RTE_DPAA_MAX_RX_QUEUE)
+		qman_release_fqid_range(fqids[i], RTE_DPAA_MAX_RX_QUEUE - i);
+init_error2:
+	i = internals->max_nb_queue_pairs;
+	fqids[0] = internals->qps[0].outq.fqid;
+init_error1:
+	base = 0;
+	run = 0;
+	for (j = 0; j < i; j++) {
+		qp = &internals->qps[j];
+		fqid = qp->outq.fqid;
+		ret = qman_shutdown_fq(&qp->outq);
+		if (ret) {
+			DPAA_SEC_ERR("%s: Failed(%d) to shutdown TXQ(0x%08x), fqid not released",
+				cryptodev->data->name, ret, fqid);
+		}
+		if (run && (ret || fqid != base + run)) {
+			qman_release_fqid_range(base, run);
+			run = 0;
+		}
+		if (ret || !fqid)
+			continue;
+		if (run++ == 0)
+			base = fqid;
+	}
+	if (run)
+		qman_release_fqid_range(base, run);
+	/* FQIDs of the queues that were never created */
+	if (i < internals->max_nb_queue_pairs)
+		qman_release_fqid_range(fqids[i],
+			internals->max_nb_queue_pairs - i);
+
 init_error:
 	DPAA_SEC_ERR("driver %s: create failed", cryptodev->data->name);
 
-- 
2.25.1

