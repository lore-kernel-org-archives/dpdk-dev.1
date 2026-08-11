Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294BBC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E3B415D7;
	Tue, 11 Aug 2026 13:57:51 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1FB1E41157
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:57:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02EF91A01BA;
 Tue, 11 Aug 2026 13:57:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C196F1A01B6;
 Tue, 11 Aug 2026 13:57:47 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3F86618000B0;
 Tue, 11 Aug 2026 19:57:46 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v8 09/26] bus/dpaa: enhance DPAA FQ shutdown
Date: Tue, 11 Aug 2026 17:27:14 +0530
Message-Id: <20260811115731.3421032-10-hemant.agrawal@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Improve the FQ shutdown sequence to handle edge cases more
robustly, including better handling of ORL (Order Restoration
List) presence and improved error recovery paths.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c | 45 ++++++++++++++++--------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 6cf303de59..56dc1cba45 100644
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
@@ -2853,28 +2854,29 @@ qman_shutdown_fq(struct qman_fq *fq)
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
-				DPAA_BUS_ERR("Can't recover FQ 0x%x, Invalid channel: 0x%x",
-					fqid, channel);
+				DPAA_BUS_ERR("Invalid channel 0x%x for FQ 0x%x",
+					channel, fqid);
 				ret = -EBUSY;
 				goto out;
 			}
@@ -2882,15 +2884,16 @@ qman_shutdown_fq(struct qman_fq *fq)
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
@@ -2933,7 +2936,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 		if (mcr->result != QM_MCR_RESULT_OK) {
 			DPAA_BUS_ERR("OOS after drain fail: FQ 0x%x (0x%x)",
-				      fqid, mcr->result);
+				fqid, mcr->result);
 			ret = -EIO;
 			goto out;
 		}
@@ -2952,7 +2955,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 		if (mcr->result != QM_MCR_RESULT_OK) {
 			DPAA_BUS_ERR("OOS fail: FQ 0x%x (0x%x)",
-				      fqid, mcr->result);
+				fqid, mcr->result);
 			ret = -EIO;
 			goto out;
 		}
-- 
2.25.1

