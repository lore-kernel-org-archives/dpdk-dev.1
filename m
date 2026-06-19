Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F5FCD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CE440E3E;
	Fri, 19 Jun 2026 14:29:40 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2AB9040E2D
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:29:38 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03EE420024D;
 Fri, 19 Jun 2026 14:29:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0FAF200238;
 Fri, 19 Jun 2026 14:29:37 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4397B180007B;
 Fri, 19 Jun 2026 20:29:36 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 08/18] bus/dpaa: enhance DPAA FQ shutdown
Date: Fri, 19 Jun 2026 17:59:06 +0530
Message-Id: <20260619122922.3774666-10-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Improve the FQ shutdown sequence to handle edge cases more
robustly, including better handling of ORL (Order Restoration
List) presence and improved error recovery paths.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c | 79 ++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 9d2ca25f0e..9832c0be24 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017,2019-2025 NXP
+ * Copyright 2017,2019-2026 NXP
  *
  */
 
@@ -2843,9 +2843,10 @@ qman_shutdown_fq(struct qman_fq *fq)
 		}
 		res = mcr->result; /* Make a copy as we reuse MCR below */
 
-		if (res == QM_MCR_RESULT_OK) {
+		if (res == QM_MCR_RESULT_OK)
 			drain_mr_fqrni(&p->p);
-		} else if (res == QM_MCR_RESULT_PENDING) {
+
+		if (res == QM_MCR_RESULT_PENDING) {
 			/*
 			 * Need to wait for the FQRN in the message ring, which
 			 * will only occur once the FQ has been drained.  In
@@ -2853,27 +2854,29 @@ qman_shutdown_fq(struct qman_fq *fq)
 			 * to dequeue from the channel the FQ is scheduled on
 			 */
 			int found_fqrn = 0;
-			const u16 pool_ch_start = dpaa_get_qm_channel_pool();
-			const u16 pool_ch_end = pool_ch_start + dpaa_get_qm_channel_pool_num();
-			u32 sdqcr = p->sdqcr;
 
 			/* Flag that we need to drain FQ */
 			drain = 1;
 
+			const u16 pool_ch_start = dpaa_get_qm_channel_pool();
+			const u16 pool_ch_end = pool_ch_start +
+					dpaa_get_qm_channel_pool_num();
 			if (channel >= pool_ch_start && channel < pool_ch_end) {
-				/* Pool channel, enable the bit in the portal */
+				/* Pool channel - must use affine portal */
 				if (p->config->channel != channel) {
-					DPAA_BUS_ERR("Portal affine channel(0x%04x) != wq channel(0x%04x)",
+					DPAA_BUS_ERR("Portal ch(0x%04x) != FQ ch(0x%04x)",
 						p->config->channel, channel);
 					ret = -EINVAL;
 					goto out;
 				}
 			} else if (channel < pool_ch_start) {
 				/* Dedicated channel */
-				sdqcr = QM_SDQCR_TYPE_ACTIVE | QM_SDQCR_CHANNELS_DEDICATED;
-				qm_dqrr_sdqcr_set(&p->p, sdqcr);
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_DEDICATED);
 			} else {
-				DPAA_BUS_ERR("Can't recover FQ 0x%x, Invalid channel: 0x%x", fqid, channel);
+				DPAA_BUS_ERR("Invalid channel 0x%x for FQ 0x%x",
+					channel, fqid);
 				ret = -EBUSY;
 				goto out;
 			}
@@ -2881,15 +2884,16 @@ qman_shutdown_fq(struct qman_fq *fq)
 				/* Keep draining DQRR while checking the MR*/
 				qm_dqrr_drain_nomatch(&p->p);
 				/* Process message ring too */
-				found_fqrn = qm_mr_drain(&p->p,
-							FQRN);
+				found_fqrn = qm_mr_drain(&p->p, FQRN);
 				cpu_relax();
 			} while (!found_fqrn);
-			/* Restore SDQCR */
-			if (sdqcr != p->sdqcr)
-				qm_dqrr_sdqcr_set(&p->p, p->sdqcr);
-		} else {
-			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x", fqid, res);
+			qm_dqrr_sdqcr_set(&p->p, p->sdqcr);
+
+		}
+		if (res != QM_MCR_RESULT_OK &&
+		    res != QM_MCR_RESULT_PENDING) {
+			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x",
+				fqid, res);
 			ret = -EIO;
 			goto out;
 		}
@@ -2932,7 +2936,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 		if (mcr->result != QM_MCR_RESULT_OK) {
 			DPAA_BUS_ERR("OOS after drain fail: FQ 0x%x (0x%x)",
-				      fqid, mcr->result);
+				fqid, mcr->result);
 			ret = -EIO;
 			goto out;
 		}
@@ -2951,7 +2955,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 		if (mcr->result != QM_MCR_RESULT_OK) {
 			DPAA_BUS_ERR("OOS fail: FQ 0x%x (0x%x)",
-				      fqid, mcr->result);
+				fqid, mcr->result);
 			ret = -EIO;
 			goto out;
 		}
@@ -2968,3 +2972,38 @@ qman_shutdown_fq(struct qman_fq *fq)
 out:
 	return ret;
 }
+
+int qman_find_fq_by_cgrid(u32 cgrid, u32 *fqid)
+{
+	struct qman_fq fq = {
+		.fqid = 1
+	};
+	struct qm_mcr_queryfq_np np;
+	struct qm_fqd fqd;
+	int err;
+
+	do {
+		err = qman_query_fq_np(&fq, &np);
+		if (err == -ERANGE) {
+			DPAA_BUS_INFO("No FQ found with cgrid(0x%x)", cgrid);
+			return err;
+		} else if (err) {
+			DPAA_BUS_WARN("Failed(%d) to Query np FQ(fqid=0x%x)", err, fq.fqid);
+			return err;
+		}
+		if ((np.state & QM_MCR_NP_STATE_MASK) != QM_MCR_NP_STATE_OOS) {
+			err = qman_query_fq(&fq, &fqd);
+			if (err) {
+				DPAA_BUS_WARN("Failed(%d) to Query FQ(fqid=0x%x)", err, fq.fqid);
+			} else if ((fqd.fq_ctrl & QM_FQCTRL_CGE) && fqd.cgid == cgrid) {
+				if (fqid)
+					*fqid = fq.fqid;
+				return 0;
+			}
+		}
+		/* Move to the next FQID */
+		fq.fqid++;
+	} while (1);
+
+	return -ENODEV;
+}
-- 
2.25.1

