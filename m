Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0376CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 929DB40671;
	Fri, 16 Oct 2026 13:20:09 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 81C9740430;
 Fri, 16 Oct 2026 13:20:04 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EFF0200210;
 Fri, 16 Oct 2026 13:20:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15EA920020F;
 Fri, 16 Oct 2026 13:20:04 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7A81818000B6;
 Fri, 16 Oct 2026 19:20:03 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org, Jun Yang <jun.yang@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v27 06/25] bus/dpaa: fix hang on FQ shutdown
Date: Fri, 16 Oct 2026 16:49:39 +0530
Message-Id: <20261016111958.163060-7-hemant.agrawal@nxp.com>
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

qman_shutdown_fq() took only an fqid and always drained the FQ through
get_affine_portal(), the portal of the calling thread. A frame queue
that belongs to a different portal cannot be drained that way. Take
the FQ descriptor instead and use fq->qp when the caller has one,
falling back to the affine portal otherwise, so a caller that owns the
queue can drain it on the portal the queue is bound to. Add a
qman_shutdown_fq_by_fqid() wrapper for the one caller that only has an
fqid: net/dpaa cleans up a frame queue left behind by a previous run
before the queue is initialized, so no descriptor exists yet.

qman_shutdown_fq() also waits for the FQRN in an unbounded
do { } while (!found_fqrn) loop and picks the SDQCR drain source from
the channel the FQ sits on.

QM_SDQCR_CHANNELS_DEDICATED only dequeues the calling portal's own
channel, so an FQ on another portal's dedicated channel never delivers
the notification and the loop spins forever. Push-mode Rx queues are
such FQs. A channel in the DCP portal range cannot be drained from
software at all.

Reject both with -EBUSY instead of draining, bound the wait by
QMAN_FQRN_WAIT_MAX, and restore the portal SDQCR on every path.

Fixes: c47ff048b99a ("bus/dpaa: add QMAN driver core routines")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 74 +++++++++++++++++------------
 drivers/bus/dpaa/include/fsl_qman.h | 16 ++++++-
 drivers/net/dpaa/dpaa_ethdev.c      |  2 +-
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 931d487de4..896adaa1a6 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2784,18 +2784,20 @@ qm_mc_result_timeout(struct qm_portal *portal,
 
 RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq)
 int
-qman_shutdown_fq(u32 fqid)
+qman_shutdown_fq(struct qman_fq *fq)
 {
-	struct qman_portal *p;
+	struct qman_portal *p = fq->qp;
 	struct qm_mc_command *mcc;
 	struct qm_mc_result *mcr;
 	int orl_empty, drain = 0, ret = 0;
-	u32 res;
+	u32 res, fqid = fq->fqid;
+	u32 loop;
 	u8 state;
-	u32 channel, wq;
+	u32 channel;
 
 	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
-	p = get_affine_portal();
+	if (!p)
+		p = get_affine_portal();
 	/* Determine the state of the FQID */
 	mcc = qm_mc_start(&p->p);
 	mcc->queryfq_np.fqid = cpu_to_be32(fqid);
@@ -2823,7 +2825,6 @@ qman_shutdown_fq(u32 fqid)
 
 	/* Need to store these since the MCR gets reused */
 	channel = qm_fqd_get_chan(&mcr->queryfq.fqd);
-	wq = qm_fqd_get_wq(&mcr->queryfq.fqd);
 
 	switch (state) {
 	case QM_MCR_NP_STATE_TEN_SCHED:
@@ -2857,42 +2858,53 @@ qman_shutdown_fq(u32 fqid)
 			/* Flag that we need to drain FQ */
 			drain = 1;
 
-			__maybe_unused u16 dequeue_wq = 0;
 			if (channel >= qm_channel_pool1 &&
 				channel < (u16)(qm_channel_pool1 + 15)) {
-				/* Pool channel, enable the bit in the portal */
-				dequeue_wq = (channel -
-						qm_channel_pool1 + 1) << 4 | wq;
+				/* Any portal may subscribe to a pool channel. */
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_POOL_CONV(channel));
 			} else if (channel < qm_channel_pool1) {
-				/* Dedicated channel */
-				dequeue_wq = wq;
+				/* DEDICATED only dequeues our own channel, so
+				 * another portal's FQ would never retire here.
+				 */
+				if (channel != p->config->channel) {
+					DPAA_BUS_ERR("FQ 0x%x on portal channel 0x%x, not ours(0x%x)",
+						fqid, channel,
+						p->config->channel);
+					ret = -EBUSY;
+					goto out;
+				}
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_DEDICATED);
 			} else {
-				DPAA_BUS_ERR("Can't recover FQ 0x%x, ch: 0x%x",
-					fqid, channel);
+				/* DCP portal channel, not drainable from software. */
+				DPAA_BUS_ERR("DCP portal channel 0x%x for FQ 0x%x",
+					channel, fqid);
 				ret = -EBUSY;
 				goto out;
 			}
-			/* Set the sdqcr to drain this channel */
-			if (channel < qm_channel_pool1)
-				qm_dqrr_sdqcr_set(&p->p,
-						  QM_SDQCR_TYPE_ACTIVE |
-						  QM_SDQCR_CHANNELS_DEDICATED);
-			else
-				qm_dqrr_sdqcr_set(&p->p,
-						  QM_SDQCR_TYPE_ACTIVE |
-						  QM_SDQCR_CHANNELS_POOL_CONV
-						  (channel));
-			do {
+
+			for (loop = 0; loop < QMAN_FQRN_WAIT_MAX; loop++) {
 				/* Keep draining DQRR while checking the MR*/
 				qm_dqrr_drain_nomatch(&p->p);
 				/* Process message ring too */
-				found_fqrn = qm_mr_drain(&p->p,
-							FQRN);
+				found_fqrn = qm_mr_drain(&p->p, FQRN);
+				if (found_fqrn)
+					break;
 				cpu_relax();
-			} while (!found_fqrn);
-			/* Restore SDQCR */
-			qm_dqrr_sdqcr_set(&p->p,
-					p->sdqcr);
+			}
+
+			/* Restore portal SDQCR. */
+			qm_dqrr_sdqcr_set(&p->p, p->sdqcr);
+
+			if (!found_fqrn) {
+				DPAA_BUS_ERR("FQ 0x%x retire did not complete",
+					fqid);
+				ret = -EBUSY;
+				goto out;
+			}
 		}
 		if (res != QM_MCR_RESULT_OK &&
 		    res != QM_MCR_RESULT_PENDING) {
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 82269cdf99..d67b571dcc 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1276,6 +1276,11 @@ struct qman_cgr {
 	struct list_head node;
 };
 
+/* Polling bound while waiting for an FQ retirement notification. A retire
+ * that has not been reported by then is not going to complete on this portal.
+ */
+#define QMAN_FQRN_WAIT_MAX		10000000u
+
 /* Flags to qman_create_fq() */
 #define QMAN_FQ_FLAG_NO_ENQUEUE      0x00000001 /* can't enqueue */
 #define QMAN_FQ_FLAG_NO_MODIFY       0x00000002 /* can only enqueue */
@@ -1896,7 +1901,16 @@ static inline void qman_release_fqid(u32 fqid)
 void qman_seed_fqid_range(u32 fqid, unsigned int count);
 
 __rte_internal
-int qman_shutdown_fq(u32 fqid);
+int qman_shutdown_fq(struct qman_fq *fq);
+
+static inline int qman_shutdown_fq_by_fqid(u32 fqid)
+{
+	struct qman_fq fq;
+
+	memset(&fq, 0, sizeof(struct qman_fq));
+	fq.fqid = fqid;
+	return qman_shutdown_fq(&fq);
+}
 
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 1688acfb30..f6170f557d 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2359,7 +2359,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 		/* Clean up a frame queue left behind by a previous run
 		 * before it is initialized.
 		 */
-		qman_shutdown_fq(fqid);
+		qman_shutdown_fq_by_fqid(fqid);
 
 		if (dpaa_intf->cgr_rx)
 			dpaa_intf->cgr_rx[loop].cgrid = cgrid[loop];
-- 
2.25.1

