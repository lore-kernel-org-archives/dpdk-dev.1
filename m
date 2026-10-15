Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DBCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 377C040BA0;
	Thu, 15 Oct 2026 16:12:10 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id CC355406B8;
 Thu, 15 Oct 2026 16:11:51 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B06A2200098;
 Thu, 15 Oct 2026 16:11:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BEE1200087;
 Thu, 15 Oct 2026 16:11:51 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DF7E21800068;
 Thu, 15 Oct 2026 22:11:50 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v26 11/26] bus/dpaa: fix hang on FQ shutdown
Date: Thu, 15 Oct 2026 19:41:29 +0530
Message-Id: <20261015141144.3140281-12-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
References: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
 <20261015141144.3140281-1-hemant.agrawal@nxp.com>
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

qman_shutdown_fq() waits for the FQRN in an unbounded
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

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 65 +++++++++++++++++------------
 drivers/bus/dpaa/include/fsl_qman.h |  5 +++
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 2315b81065..896adaa1a6 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2791,8 +2791,9 @@ qman_shutdown_fq(struct qman_fq *fq)
 	struct qm_mc_result *mcr;
 	int orl_empty, drain = 0, ret = 0;
 	u32 res, fqid = fq->fqid;
+	u32 loop;
 	u8 state;
-	u32 channel, wq;
+	u32 channel;
 
 	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
 	if (!p)
@@ -2824,7 +2825,6 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 	/* Need to store these since the MCR gets reused */
 	channel = qm_fqd_get_chan(&mcr->queryfq.fqd);
-	wq = qm_fqd_get_wq(&mcr->queryfq.fqd);
 
 	switch (state) {
 	case QM_MCR_NP_STATE_TEN_SCHED:
@@ -2858,42 +2858,53 @@ qman_shutdown_fq(struct qman_fq *fq)
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
index 673859ed2e..d67b571dcc 100644
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
-- 
2.25.1

