Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A2606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 04:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A40940A7F;
	Fri, 30 Oct 2026 05:43:33 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id D86A840151;
 Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0CEA200094;
 Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4437C2000C9;
 Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6C81A1800226;
 Fri, 30 Oct 2026 12:43:23 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 4/4] drivers: add DPAA cgrid cleanup support
Date: Fri, 30 Oct 2026 10:13:18 +0530
Message-Id: <20261030044318.1892998-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030044318.1892998-1-g.singh@nxp.com>
References: <20261028085517.705621-1-g.singh@nxp.com>
 <20261030044318.1892998-1-g.singh@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

A congestion group must have no member frame queues left when it is
deleted, and its CGRID must be returned to the allocator once the group
is gone. Neither was handled on the net/dpaa close and probe-failure
paths.

This also changes probe behaviour: a qman_create_cgr() failure in
dpaa_rx_queue_init() or dpaa_tx_queue_init() now fails the probe
instead of continuing without tail drop on that queue. The probe error
path deletes one CGR per initialised queue, and a CGR whose creation
failed was never linked into the portal list.

Fixes: 62f53995caaf ("net/dpaa: add frame count based tail drop with CGR")
Fixes: 9124e65dd3eb ("net/dpaa: enable Tx queue taildrop")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c       |  61 ++++++++
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |   1 +
 drivers/bus/dpaa/include/fsl_qman.h      |  27 ++++
 drivers/net/dpaa/dpaa_ethdev.c           | 173 +++++++++++++++++++++--
 4 files changed, 250 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 3c056e4547..fa3387c6bd 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2993,3 +2993,64 @@ qman_shutdown_fq(struct qman_fq *fq)
 out:
 	return ret;
 }
+
+int qman_pending_fq_by_cgrid_range(u32 cgrid_start, u32 cgrid_num,
+	u32 start_fqid, u32 *fqid, u32 *cgrid)
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
+	 *
+	 * The whole CGRID range of a port is matched in a single pass, so a
+	 * port with many congestion groups does not need one full FQID space
+	 * scan per group.
+	 */
+	DPAA_BUS_DEBUG("Scanning FQs for cgrid(0x%x..0x%x)",
+		cgrid_start, cgrid_start + cgrid_num - 1);
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
+				fqd.cgid >= cgrid_start &&
+				fqd.cgid < cgrid_start + cgrid_num) {
+				if (fqid)
+					*fqid = fq.fqid;
+				if (cgrid)
+					*cgrid = fqd.cgid;
+				return 0;
+			}
+		}
+	}
+	DPAA_BUS_DEBUG("No FQ left in cgrid(0x%x..0x%x)",
+		cgrid_start, cgrid_start + cgrid_num - 1);
+	return -ERANGE;
+}
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index aaa9f9bec2..4da43f293d 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -57,6 +57,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_pending_fq_by_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index b2674ce5d0..6d76722275 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1284,6 +1284,9 @@ struct qman_cgr {
  */
 #define QMAN_FQRN_WAIT_MAX		10000000u
 
+/* Maximum FQID value: frame queue IDs are 24 bits wide. */
+#define QMAN_MAX_FQID			0x00FFFFFFu
+
 /* Flags to qman_create_fq() */
 #define QMAN_FQ_FLAG_NO_ENQUEUE      0x00000001 /* can't enqueue */
 #define QMAN_FQ_FLAG_NO_MODIFY       0x00000002 /* can only enqueue */
@@ -1916,6 +1919,30 @@ static inline int qman_shutdown_fq_by_fqid(u32 fqid)
 	return qman_shutdown_fq(&fq);
 }
 
+/**
+ * qman_pending_fq_by_cgrid_range - Find an FQ still attached to a CGR range.
+ *
+ * @cgrid_start: first congestion group id of the range to search for.
+ * @cgrid_num: number of consecutive congestion group ids in the range.
+ * @start_fqid: FQID to begin the scan from (0 or 1 means scan from the
+ *   start). A caller shutting down several stale FQs can pass the previously
+ *   returned FQID + 1 to resume the scan instead of restarting from the
+ *   beginning each time.
+ * @fqid: on success, holds the FQID that is still attached to the range.
+ * @cgrid: on success, holds the congestion group id that FQ belongs to.
+ *   May be NULL.
+ *
+ * Matching a whole range in one pass lets a caller with many congestion
+ * groups, such as a port releasing all of its Rx or Tx CGRs, avoid one full
+ * FQID space scan per group.
+ *
+ * Return 0 and set *fqid when a matching FQ is found, -ERANGE when none is
+ * left, or a negative error code on query failure.
+ */
+__rte_internal
+int qman_pending_fq_by_cgrid_range(u32 cgrid_start, u32 cgrid_num,
+		u32 start_fqid, u32 *fqid, u32 *cgrid);
+
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
  * @fqid: the base FQID of the range to deallocate
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index a821e68807..1f5e03a8ac 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -114,6 +114,9 @@ dpaa_get_kernel_ifname(const char *node_path, char *name, size_t size)
 	return ret;
 }
 
+/* Maximum number of stale frame queues cleaned up per congestion group. */
+#define DPAA_CGR_STALE_FQ_MAX     64
+
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_SCATTER;
@@ -585,6 +588,49 @@ static int dpaa_eth_dev_stop(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* Shut down any frame queue still linked to this CGR.
+ *
+ * A CGR must have no members left when it is deleted. FQs left behind by a
+ * previous run of the application are not owned by this process, so they can
+ * only be found by asking QMan. There may be more than one, hence the loop.
+ *
+ * Returns true if the FQID range was fully scanned (i.e. no stale FQ was
+ * left behind), false if an FQ refused to shut down and the scan had to
+ * stop early.
+ */
+static bool
+dpaa_cgr_stale_fq_cleanup(struct rte_eth_dev *dev, uint32_t cgrid_start,
+			  uint32_t cgrid_num, const char *dir)
+{
+	uint32_t start_fqid = 1;
+	uint32_t fqid, cgrid;
+	uint32_t loop, max_loop;
+	int ret;
+
+	max_loop = cgrid_num * DPAA_CGR_STALE_FQ_MAX;
+	for (loop = 0; loop < max_loop; loop++) {
+		if (qman_pending_fq_by_cgrid_range(cgrid_start, cgrid_num,
+						   start_fqid, &fqid, &cgrid))
+			return true;
+		/* Should be FQ not cleaned in previous program. */
+		DPAA_PMD_DEBUG("FQ(fqid=0x%x) with %s cgid=%u is still alive?",
+			fqid, dir, cgrid);
+		ret = qman_shutdown_fq_by_fqid(fqid);
+		if (ret) {
+			DPAA_PMD_WARN("%s: Failed(%d) to shutdown %s cgid=%u's fq(fqid=0x%x)",
+				dev->data->name, ret, dir, cgrid, fqid);
+			/* Do not spin on an FQ that refuses to shut down. */
+			return false;
+		}
+		/* Resume the scan past the FQ just handled instead of
+		 * restarting from the beginning, which would be O(N^2) for
+		 * N stale FQs.
+		 */
+		start_fqid = fqid + 1;
+	}
+	return true;
+}
+
 static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 {
 	struct fman_if *fif = dev->process_private;
@@ -594,7 +640,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	struct rte_eth_link *link = &dev->data->dev_link;
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
 	struct qman_fq *fq;
-	int loop;
+	uint32_t loop;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -669,26 +715,81 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	/* Release congestion Groups after releasing FQIDs */
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
+		bool cgrid_ok;
+
+		/* The CGRIDs are a contiguous range, so one scan of the FQID
+		 * space covers all of them. This catches any FQ left behind
+		 * by a previous, non-gracefully-terminated run of this
+		 * process that is still linked to one of these CGRs.
+		 */
+		cgrid_ok = dpaa_cgr_stale_fq_cleanup(dev, dpaa_intf->cgr_rx[0].cgrid,
+					  dpaa_intf->nb_rx_queues, "rx");
+
+		/* These are this port's own Rx FQs from the current run, so
+		 * their FQIDs are already known. Shut each one down so it is
+		 * no longer a member of its CGR, since a CGR must have no
+		 * members left when it is deleted.
+		 */
+		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+			ret = qman_shutdown_fq(&dpaa_intf->rx_queues[loop]);
+			if (ret) {
+				DPAA_PMD_WARN("%s: shutdown rxq%d err(%d)",
+					dev->data->name, loop, ret);
+				cgrid_ok = false;
+			}
+		}
 		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
 			ret = qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
 			if (ret) {
 				DPAA_PMD_WARN("%s: delete rxq%d's cgr err(%d)",
 					dev->data->name, loop, ret);
+				cgrid_ok = false;
 			}
 		}
+		/* Only hand the CGRIDs back to the allocator if every member
+		 * FQ was confirmed shut down and every CGR deleted; otherwise
+		 * deliberately leak them rather than reuse a CGRID that may
+		 * still be referenced by a live FQ.
+		 */
+		if (cgrid_ok)
+			qman_release_cgrid_range(dpaa_intf->cgr_rx[0].cgrid,
+					dpaa_intf->nb_rx_queues);
 		rte_free(dpaa_intf->cgr_rx);
 		dpaa_intf->cgr_rx = NULL;
 	}
 
 	/* Release TX congestion Groups */
 	if (dpaa_intf->cgr_tx) {
+		bool cgrid_ok;
+
+		/* See the equivalent comment for the Rx CGRs above about
+		 * cleaning up stale FQs left behind by a previous run.
+		 */
+		cgrid_ok = dpaa_cgr_stale_fq_cleanup(dev, dpaa_intf->cgr_tx[0].cgrid,
+					  MAX_DPAA_CORES, "tx");
+
+		/* See the equivalent comment for the Rx CGRs above about
+		 * shutting down this port's own FQs.
+		 */
+		for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
+			ret = qman_shutdown_fq(&dpaa_intf->tx_queues[loop]);
+			if (ret) {
+				DPAA_PMD_WARN("%s: shutdown txq%d err(%d)",
+					dev->data->name, loop, ret);
+				cgrid_ok = false;
+			}
+		}
 		for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
 			ret = qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
 			if (ret) {
 				DPAA_PMD_WARN("%s: delete txq%d's cgr err(%d)",
 					dev->data->name, loop, ret);
+				cgrid_ok = false;
 			}
 		}
+		if (cgrid_ok)
+			qman_release_cgrid_range(dpaa_intf->cgr_tx[0].cgrid,
+						 MAX_DPAA_CORES);
 		rte_free(dpaa_intf->cgr_tx);
 		dpaa_intf->cgr_tx = NULL;
 	}
@@ -2039,19 +2140,32 @@ static int dpaa_rx_queue_init(struct qman_fq *fq, struct qman_cgr *cgr_rx,
 		ret = qman_create_cgr(cgr_rx, QMAN_CGR_FLAG_USE_INIT,
 				      &cgr_opts);
 		if (ret) {
-			DPAA_PMD_WARN(
-				"rx taildrop init fail on rx fqid 0x%x(ret=%d)",
+			/* Do not fall back to running without the CGR. The
+			 * caller counts one CGR per queue it initialised and
+			 * deletes cgr_rx[0..n) on its error path, so a queue
+			 * without a CGR would make it delete an object that
+			 * was never added to the portal list, whose node is
+			 * still zeroed from rte_zmalloc().
+			 */
+			DPAA_PMD_ERR("rx taildrop init fail on rx fqid 0x%x(ret=%d)",
 				fq->fqid, ret);
-			goto without_cgr;
+			return ret;
 		}
 		opts.we_mask |= QM_INITFQ_WE_CGID;
 		opts.fqd.cgid = cgr_rx->cgrid;
 		opts.fqd.fq_ctrl |= QM_FQCTRL_CGE;
 	}
-without_cgr:
+
 	ret = qman_init_fq(fq, 0, &opts);
-	if (ret)
+	if (ret) {
 		DPAA_PMD_ERR("init rx fqid 0x%x failed with ret:%d", fqid, ret);
+		/* The caller only counts this CGR once this function returns
+		 * success, so its error path will not delete it. Unlink it here
+		 * or the portal keeps a pointer into memory the caller frees.
+		 */
+		if (cgr_rx)
+			qman_delete_cgr(cgr_rx);
+	}
 	return ret;
 }
 
@@ -2130,10 +2244,12 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 		ret = qman_create_cgr(cgr_tx, QMAN_CGR_FLAG_USE_INIT,
 				      &cgr_opts);
 		if (ret) {
-			DPAA_PMD_WARN(
-				"rx taildrop init fail on rx fqid 0x%x(ret=%d)",
+			/* See the equivalent comment in
+			 * dpaa_rx_queue_init().
+			 */
+			DPAA_PMD_ERR("tx taildrop init fail on tx fqid 0x%x(ret=%d)",
 				fq->fqid, ret);
-			goto without_cgr;
+			return ret;
 		}
 		opts.we_mask |= QM_INITFQ_WE_CGID;
 		opts.fqd.cgid = cgr_tx->cgrid;
@@ -2141,10 +2257,14 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 		DPAA_PMD_DEBUG("Tx FQ tail drop enabled, threshold = %d",
 				td_tx_threshold);
 	}
-without_cgr:
+
 	ret = qman_init_fq(fq, QMAN_INITFQ_FLAG_SCHED, &opts);
-	if (ret)
+	if (ret) {
 		DPAA_PMD_ERR("init tx fqid 0x%x failed %d", fq->fqid, ret);
+		/* See the equivalent comment in dpaa_rx_queue_init(). */
+		if (cgr_tx)
+			qman_delete_cgr(cgr_tx);
+	}
 	return ret;
 }
 
@@ -2316,6 +2436,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	int num_rx_fqs, fqid;
 	int loop, ret = 0;
 	int dev_id;
+	int nb_rx_cgr = 0, nb_tx_cgr = 0;
+	bool rx_cgrid_allocated = false, tx_cgrid_allocated = false;
 	struct rte_dpaa_device *dpaa_device;
 	struct dpaa_if *dpaa_intf;
 	struct fm_eth_port_cfg *cfg;
@@ -2437,6 +2559,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			ret = -EINVAL;
 			goto free_rx;
 		}
+		rx_cgrid_allocated = true;
 	} else {
 		dpaa_intf->cgr_rx = NULL;
 	}
@@ -2471,6 +2594,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			fqid);
 		if (ret)
 			goto free_rx;
+		if (dpaa_intf->cgr_rx)
+			nb_rx_cgr++;
 		dpaa_intf->rx_queues[loop].vsp_id = vsp_id;
 		dpaa_intf->rx_queues[loop].dpaa_intf = dpaa_intf;
 	}
@@ -2511,11 +2636,11 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			ret = -EINVAL;
 			goto free_tx;
 		}
+		tx_cgrid_allocated = true;
 	} else {
 		dpaa_intf->cgr_tx = NULL;
 	}
 
-
 	for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
 		if (dpaa_intf->cgr_tx)
 			dpaa_intf->cgr_tx[loop].cgrid = cgrid_tx[loop];
@@ -2526,6 +2651,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 			dpaa_intf->cgr_tx ? &dpaa_intf->cgr_tx[loop] : NULL);
 		if (ret)
 			goto free_tx;
+		if (dpaa_intf->cgr_tx)
+			nb_tx_cgr++;
 
 		if (dpaa_intf->ts_enable) {
 			ret = dpaa_tx_conf_queue_init(&dpaa_intf->tx_conf_queues[loop]);
@@ -2605,6 +2732,17 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 free_tx:
+	/* A CGR must have no members when deleted, so shut down the FQs
+	 * already linked to it first. Each CGR was also linked into the
+	 * QMan portal's cgr_cbs list by qman_create_cgr(), so deleting it
+	 * here avoids leaving the portal with dangling pointers.
+	 */
+	for (loop = 0; loop < nb_tx_cgr; loop++)
+		qman_shutdown_fq(&dpaa_intf->tx_queues[loop]);
+	for (loop = 0; loop < nb_tx_cgr; loop++)
+		qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
+	if (tx_cgrid_allocated)
+		qman_release_cgrid_range(cgrid_tx[0], MAX_DPAA_CORES);
 	rte_free(dpaa_intf->tx_conf_queues);
 	dpaa_intf->tx_conf_queues = NULL;
 	rte_free(dpaa_intf->tx_queues);
@@ -2612,8 +2750,19 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	dpaa_intf->nb_tx_queues = 0;
 
 free_rx:
+	/* Same as above for the Rx CGRs: shut down the FQs still linked to
+	 * their CGR before deleting it.
+	 */
+	for (loop = 0; loop < nb_rx_cgr; loop++)
+		qman_shutdown_fq(&dpaa_intf->rx_queues[loop]);
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

