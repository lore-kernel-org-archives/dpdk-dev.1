Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93FCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:46:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 637904275A;
	Tue, 29 Sep 2026 12:45:43 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 334A740E7C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:45:26 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 143FF2000D5;
 Tue, 29 Sep 2026 12:45:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A95AE2000F0;
 Tue, 29 Sep 2026 12:45:25 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2987C180006C;
 Tue, 29 Sep 2026 18:45:25 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v17 08/23] drivers: add DPAA cgrid cleanup support
Date: Tue, 29 Sep 2026 16:15:04 +0530
Message-Id: <20260929104519.1770698-9-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
References: <20260928065849.126909-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-1-hemant.agrawal@nxp.com>
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

A congestion group must have no member frame queues left when it is
deleted, and its CGRID must be returned to the allocator once the group
is gone. Neither was handled on the net/dpaa close and probe-failure
paths.

Add qman_pending_fq_by_cgrid() to ask QMan for a frame queue still
associated with a given CGID. Frame queues left behind by a previous run
of the application are not owned by this process, so they can only be
found this way. The helper first checks the CGR byte count and skips the
frame queue scan when the group is idle, which is the normal case on a
clean shutdown.

In dpaa_eth_dev_close(), shut down any such stale frame queue before
deleting each Rx and Tx CGR, and release the CGRID range afterwards so
the IDs do not leak across device close.

In dpaa_dev_init(), the error paths freed cgr_rx and cgr_tx without
deleting the congestion groups that had already been created. Every
created CGR is linked into the QMan portal's cgr_cbs list, so the portal
was left with dangling pointers into freed memory. Track how many groups
were created, delete them on the error paths before freeing the arrays,
release the reserved CGRID ranges and clear the pointers.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c       | 51 +++++++++++++
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |  2 +
 drivers/bus/dpaa/include/fsl_qman.h      | 20 ++++++
 drivers/net/dpaa/dpaa_ethdev.c           | 92 ++++++++++++++++++++++--
 4 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 2315b81065..434b3ca338 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2977,3 +2977,54 @@ qman_shutdown_fq(struct qman_fq *fq)
 out:
 	return ret;
 }
+
+int qman_pending_fq_by_cgrid(u32 cgrid, u32 start_fqid, u32 *fqid)
+{
+	struct qman_fq fq = {
+		.fqid = start_fqid ? start_fqid : 1
+	};
+	struct qm_mcr_queryfq_np np;
+	struct qm_fqd fqd;
+	int err;
+
+	/*
+	 * Do not use the CGR byte count to decide whether to scan. An FQ is a
+	 * member of the group whenever it is scheduled with CGE set and a
+	 * matching cgid, whether or not it currently holds any frames, and the
+	 * group cannot be deleted while such a member exists. Skipping the
+	 * scan for an empty CGR would let an idle stale FQ survive and its
+	 * CGRID be released while still referenced. This runs from the device
+	 * close path only, so the scan cost is acceptable.
+	 */
+	DPAA_BUS_DEBUG("Scanning FQs for cgrid(0x%x)", cgrid);
+
+	/* FQID space is 24 bits wide; stop before wrapping. */
+	for (; fq.fqid <= QMAN_MAX_FQID; fq.fqid++) {
+		err = qman_query_fq_np(&fq, &np);
+		if (err == -ERANGE) {
+			/*
+			 * FQID is not implemented on this device, so there is
+			 * nothing beyond it either.
+			 */
+			break;
+		} else if (err) {
+			DPAA_BUS_WARN("Failed(%d) to Query np FQ(fqid=0x%x)",
+				err, fq.fqid);
+			return err;
+		}
+		if ((np.state & QM_MCR_NP_STATE_MASK) != QM_MCR_NP_STATE_OOS) {
+			err = qman_query_fq(&fq, &fqd);
+			if (err) {
+				DPAA_BUS_WARN("Failed(%d) to Query FQ(fqid=0x%x)",
+					err, fq.fqid);
+			} else if ((fqd.fq_ctrl & QM_FQCTRL_CGE) &&
+				fqd.cgid == cgrid) {
+				if (fqid)
+					*fqid = fq.fqid;
+				return 0;
+			}
+		}
+	}
+	DPAA_BUS_INFO("No FQ found with cgrid(0x%x)", cgrid);
+	return -ERANGE;
+}
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 522cdca27e..b1e5d445e3 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -51,10 +51,12 @@ RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_release_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_pending_fq_by_cgrid)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 673859ed2e..871cafb832 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1276,6 +1276,9 @@ struct qman_cgr {
 	struct list_head node;
 };
 
+/* Maximum FQID value: frame queue IDs are 24 bits wide. */
+#define QMAN_MAX_FQID			0x00FFFFFFu
+
 /* Flags to qman_create_fq() */
 #define QMAN_FQ_FLAG_NO_ENQUEUE      0x00000001 /* can't enqueue */
 #define QMAN_FQ_FLAG_NO_MODIFY       0x00000002 /* can only enqueue */
@@ -1887,6 +1890,7 @@ static inline int qman_alloc_fqid(u32 *result)
  * This function can also be used to seed the allocator with ranges of FQIDs
  * that it can subsequently allocate from.
  */
+__rte_internal
 void qman_release_fqid_range(u32 fqid, unsigned int count);
 static inline void qman_release_fqid(u32 fqid)
 {
@@ -1907,6 +1911,22 @@ static inline int qman_shutdown_fq_by_fqid(u32 fqid)
 	return qman_shutdown_fq(&fq);
 }
 
+/**
+ * qman_pending_fq_by_cgrid - Find an FQ still attached to a CGR.
+ *
+ * @cgrid: the congestion group id to search for.
+ * @start_fqid: FQID to begin the scan from (0 or 1 means scan from the
+ *   start). A caller shutting down several stale FQs can pass the previously
+ *   returned FQID + 1 to resume the scan instead of restarting from the
+ *   beginning each time, avoiding an O(N^2) rescan.
+ * @fqid: on success, holds the FQID that is still attached to @cgrid.
+ *
+ * Return 0 and set *fqid when a matching FQ is found, -ERANGE when none is
+ * left, or a negative error code on query failure.
+ */
+__rte_internal
+int qman_pending_fq_by_cgrid(u32 cgrid, u32 start_fqid, u32 *fqid);
+
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
  * @fqid: the base FQID of the range to deallocate
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 76ca11db3f..4454f8b364 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -57,6 +57,9 @@
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
 #define RTE_PRIORITY_103 103
 
+/* Maximum number of stale frame queues cleaned up per congestion group. */
+#define DPAA_CGR_STALE_FQ_MAX     64
+
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_SCATTER;
@@ -494,6 +497,42 @@ static int dpaa_eth_dev_stop(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* Shut down any frame queue still linked to this CGR.
+ *
+ * A CGR must have no members left when it is deleted. FQs left behind by a
+ * previous run of the application are not owned by this process, so they can
+ * only be found by asking QMan. There may be more than one, hence the loop.
+ */
+static void
+dpaa_cgr_stale_fq_cleanup(struct rte_eth_dev *dev, uint32_t cgrid,
+			  const char *dir, uint32_t idx)
+{
+	uint32_t start_fqid = 1;
+	uint32_t fqid;
+	uint32_t loop;
+	int ret;
+
+	for (loop = 0; loop < DPAA_CGR_STALE_FQ_MAX; loop++) {
+		if (qman_pending_fq_by_cgrid(cgrid, start_fqid, &fqid))
+			break;
+		/* Should be FQ not cleaned in previous program. */
+		DPAA_PMD_DEBUG("FQ(fqid=0x%x) with %s cgid=%d is still alive?",
+			fqid, dir, cgrid);
+		ret = qman_shutdown_fq_by_fqid(fqid);
+		if (ret) {
+			DPAA_PMD_WARN("%s: Failed(%d) to shutdown %sq%d's fq(fqid=0x%x)",
+				dev->data->name, ret, dir, idx, fqid);
+			/* Do not spin on an FQ that refuses to shut down. */
+			break;
+		}
+		/* Resume the scan past the FQ just handled instead of
+		 * restarting from the beginning, which would be O(N^2) for
+		 * N stale FQs.
+		 */
+		start_fqid = fqid + 1;
+	}
+}
+
 static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 {
 	struct fman_if *fif = dev->process_private;
@@ -503,7 +542,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	struct rte_eth_link *link = &dev->data->dev_link;
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
 	struct qman_fq *fq;
-	int loop;
+	uint32_t loop;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -569,12 +608,15 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
 		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+			dpaa_cgr_stale_fq_cleanup(dev,
+				dpaa_intf->cgr_rx[loop].cgrid, "rx", loop);
 			ret = qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
 			if (ret) {
 				DPAA_PMD_WARN("%s: delete rxq%d's cgr err(%d)",
 					dev->data->name, loop, ret);
 			}
 		}
+		qman_release_cgrid_range(dpaa_intf->cgr_rx[0].cgrid, dpaa_intf->nb_rx_queues);
 		rte_free(dpaa_intf->cgr_rx);
 		dpaa_intf->cgr_rx = NULL;
 	}
@@ -582,12 +624,16 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	/* Release TX congestion Groups */
 	if (dpaa_intf->cgr_tx) {
 		for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
+			dpaa_cgr_stale_fq_cleanup(dev,
+				dpaa_intf->cgr_tx[loop].cgrid, "tx", loop);
 			ret = qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
 			if (ret) {
 				DPAA_PMD_WARN("%s: delete txq%d's cgr err(%d)",
 					dev->data->name, loop, ret);
 			}
 		}
+		qman_release_cgrid_range(dpaa_intf->cgr_tx[0].cgrid,
+					 MAX_DPAA_CORES);
 		rte_free(dpaa_intf->cgr_tx);
 		dpaa_intf->cgr_tx = NULL;
 	}
@@ -1899,6 +1945,7 @@ static int dpaa_rx_queue_init(struct qman_fq *fq, struct qman_cgr *cgr_rx,
 {
 	struct qm_mcc_initfq opts = {0};
 	int ret;
+	bool cgr_created = false;
 	u32 flags = QMAN_FQ_FLAG_NO_ENQUEUE;
 	struct qm_mcc_initcgr cgr_opts = {
 		.we_mask = QM_CGR_WE_CS_THRES |
@@ -1945,11 +1992,19 @@ static int dpaa_rx_queue_init(struct qman_fq *fq, struct qman_cgr *cgr_rx,
 		opts.we_mask |= QM_INITFQ_WE_CGID;
 		opts.fqd.cgid = cgr_rx->cgrid;
 		opts.fqd.fq_ctrl |= QM_FQCTRL_CGE;
+		cgr_created = true;
 	}
 without_cgr:
 	ret = qman_init_fq(fq, 0, &opts);
-	if (ret)
+	if (ret) {
 		DPAA_PMD_ERR("init rx fqid 0x%x failed with ret:%d", fqid, ret);
+		/* The caller only counts this CGR once this function returns
+		 * success, so its error path will not delete it. Unlink it here
+		 * or the portal keeps a pointer into memory the caller frees.
+		 */
+		if (cgr_created)
+			qman_delete_cgr(cgr_rx);
+	}
 	return ret;
 }
 
@@ -1980,6 +2035,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 		}
 	};
 	int ret;
+	bool cgr_created = false;
 	struct dpaa_if *dpaa_intf = fq->dpaa_intf;
 
 	ret = qman_create_fq(0, QMAN_FQ_FLAG_DYNAMIC_FQID |
@@ -2036,13 +2092,18 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 		opts.we_mask |= QM_INITFQ_WE_CGID;
 		opts.fqd.cgid = cgr_tx->cgrid;
 		opts.fqd.fq_ctrl |= QM_FQCTRL_CGE;
+		cgr_created = true;
 		DPAA_PMD_DEBUG("Tx FQ tail drop enabled, threshold = %d",
 				td_tx_threshold);
 	}
 without_cgr:
 	ret = qman_init_fq(fq, QMAN_INITFQ_FLAG_SCHED, &opts);
-	if (ret)
+	if (ret) {
 		DPAA_PMD_ERR("init tx fqid 0x%x failed %d", fq->fqid, ret);
+		/* See the equivalent comment in dpaa_rx_queue_init(). */
+		if (cgr_created)
+			qman_delete_cgr(cgr_tx);
+	}
 	return ret;
 }
 
@@ -2214,6 +2275,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	int num_rx_fqs, fqid;
 	int loop, ret = 0;
 	int dev_id;
+	int nb_rx_cgr = 0, nb_tx_cgr = 0;
+	bool rx_cgrid_allocated = false, tx_cgrid_allocated = false;
 	struct rte_dpaa_device *dpaa_device;
 	struct dpaa_if *dpaa_intf;
 	struct fm_eth_port_cfg *cfg;
@@ -2334,6 +2397,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			ret = -EINVAL;
 			goto free_rx;
 		}
+		rx_cgrid_allocated = true;
 	} else {
 		dpaa_intf->cgr_rx = NULL;
 	}
@@ -2368,6 +2432,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			fqid);
 		if (ret)
 			goto free_rx;
+		if (dpaa_intf->cgr_rx)
+			nb_rx_cgr++;
 		dpaa_intf->rx_queues[loop].vsp_id = vsp_id;
 		dpaa_intf->rx_queues[loop].dpaa_intf = dpaa_intf;
 	}
@@ -2408,11 +2474,11 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			ret = -EINVAL;
 			goto free_rx;
 		}
+		tx_cgrid_allocated = true;
 	} else {
 		dpaa_intf->cgr_tx = NULL;
 	}
 
-
 	for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
 		if (dpaa_intf->cgr_tx)
 			dpaa_intf->cgr_tx[loop].cgrid = cgrid_tx[loop];
@@ -2423,6 +2489,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			dpaa_intf->cgr_tx ? &dpaa_intf->cgr_tx[loop] : NULL);
 		if (ret)
 			goto free_tx;
+		if (dpaa_intf->cgr_tx)
+			nb_tx_cgr++;
 
 		if (dpaa_intf->ts_enable) {
 			ret = dpaa_tx_conf_queue_init(&dpaa_intf->tx_conf_queues[loop]);
@@ -2502,6 +2570,15 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 free_tx:
+	/* Every created Tx CGR was linked into the QMan portal's cgr_cbs
+	 * list by qman_create_cgr(). Delete them before freeing cgr_tx so
+	 * the portal does not retain dangling pointers into freed memory,
+	 * then release the reserved CGRID range.
+	 */
+	for (loop = 0; loop < nb_tx_cgr; loop++)
+		qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
+	if (tx_cgrid_allocated)
+		qman_release_cgrid_range(cgrid_tx[0], MAX_DPAA_CORES);
 	rte_free(dpaa_intf->tx_conf_queues);
 	dpaa_intf->tx_conf_queues = NULL;
 	rte_free(dpaa_intf->tx_queues);
@@ -2509,8 +2586,15 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	dpaa_intf->nb_tx_queues = 0;
 
 free_rx:
+	/* Same as above for the Rx CGRs. */
+	for (loop = 0; loop < nb_rx_cgr; loop++)
+		qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
+	if (rx_cgrid_allocated)
+		qman_release_cgrid_range(cgrid[0], num_rx_fqs);
 	rte_free(dpaa_intf->cgr_rx);
+	dpaa_intf->cgr_rx = NULL;
 	rte_free(dpaa_intf->cgr_tx);
+	dpaa_intf->cgr_tx = NULL;
 	rte_free(dpaa_intf->rx_queues);
 	dpaa_intf->rx_queues = NULL;
 	dpaa_intf->nb_rx_queues = 0;
-- 
2.25.1

