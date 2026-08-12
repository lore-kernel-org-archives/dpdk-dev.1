Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3205C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B16D4279E;
	Wed, 12 Aug 2026 19:46:25 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 79B8040E0C
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:46:22 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C21C20004F;
 Wed, 12 Aug 2026 19:46:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2698220003D;
 Wed, 12 Aug 2026 19:46:22 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7920B18000B0;
 Thu, 13 Aug 2026 01:46:20 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v9 06/25] bus/dpaa: improve FQ shutdown with channel validation
Date: Wed, 12 Aug 2026 23:15:49 +0530
Message-Id: <20260812174609.1100111-7-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
References: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
 <20260812174609.1100111-1-hemant.agrawal@nxp.com>
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

Improve hardcoded channel range check by using DTS-derived pool
channel start/end values. Add validation that the portal's
affine channel matches the FQ's channel for pool-channel FQs,
and only restore SDQCR when it was actually changed.

Improve the FQ shutdown sequence to handle edge cases more
robustly, including better handling of ORL (Order Restoration
List) presence and improved error recovery paths.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c        | 59 +++++++++++------------
 drivers/bus/dpaa/base/qbman/qman_driver.c | 29 +++++++++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |  1 +
 drivers/bus/dpaa/include/fsl_qman.h       |  8 +--
 4 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 2315b81065..56dc1cba45 100644
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
 
@@ -2792,7 +2792,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 	int orl_empty, drain = 0, ret = 0;
 	u32 res, fqid = fq->fqid;
 	u8 state;
-	u32 channel, wq;
+	u16 channel;
 
 	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
 	if (!p)
@@ -2806,9 +2806,10 @@ qman_shutdown_fq(struct qman_fq *fq)
 		ret = -ETIMEDOUT;
 		goto out;
 	}
+
 	state = mcr->queryfq_np.state & QM_MCR_NP_STATE_MASK;
 	if (state == QM_MCR_NP_STATE_OOS) {
-		DPAA_BUS_ERR("Already in OOS");
+		DPAA_BUS_DEBUG("fqid(0x%x) Already in OOS", fqid);
 		goto out; /* Already OOS, no need to do anymore checks */
 	}
 
@@ -2824,7 +2825,6 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 	/* Need to store these since the MCR gets reused */
 	channel = qm_fqd_get_chan(&mcr->queryfq.fqd);
-	wq = qm_fqd_get_wq(&mcr->queryfq.fqd);
 
 	switch (state) {
 	case QM_MCR_NP_STATE_TEN_SCHED:
@@ -2858,47 +2858,42 @@ qman_shutdown_fq(struct qman_fq *fq)
 			/* Flag that we need to drain FQ */
 			drain = 1;
 
-			__maybe_unused u16 dequeue_wq = 0;
-			if (channel >= qm_channel_pool1 &&
-				channel < (u16)(qm_channel_pool1 + 15)) {
-				/* Pool channel, enable the bit in the portal */
-				dequeue_wq = (channel -
-						qm_channel_pool1 + 1) << 4 | wq;
-			} else if (channel < qm_channel_pool1) {
+			const u16 pool_ch_start = dpaa_get_qm_channel_pool();
+			const u16 pool_ch_end = pool_ch_start +
+					dpaa_get_qm_channel_pool_num();
+			if (channel >= pool_ch_start && channel < pool_ch_end) {
+				/* Pool channel - must use affine portal */
+				if (p->config->channel != channel) {
+					DPAA_BUS_ERR("Portal ch(0x%04x) != FQ ch(0x%04x)",
+						p->config->channel, channel);
+					ret = -EINVAL;
+					goto out;
+				}
+			} else if (channel < pool_ch_start) {
 				/* Dedicated channel */
-				dequeue_wq = wq;
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_DEDICATED);
 			} else {
-				DPAA_BUS_ERR("Can't recover FQ 0x%x, ch: 0x%x",
-					fqid, channel);
+				DPAA_BUS_ERR("Invalid channel 0x%x for FQ 0x%x",
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
 			do {
 				/* Keep draining DQRR while checking the MR*/
 				qm_dqrr_drain_nomatch(&p->p);
 				/* Process message ring too */
-				found_fqrn = qm_mr_drain(&p->p,
-							FQRN);
+				found_fqrn = qm_mr_drain(&p->p, FQRN);
 				cpu_relax();
 			} while (!found_fqrn);
-			/* Restore SDQCR */
-			qm_dqrr_sdqcr_set(&p->p,
-					p->sdqcr);
+			qm_dqrr_sdqcr_set(&p->p, p->sdqcr);
+
 		}
 		if (res != QM_MCR_RESULT_OK &&
 		    res != QM_MCR_RESULT_PENDING) {
 			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x",
-				      fqid, res);
+				fqid, res);
 			ret = -EIO;
 			goto out;
 		}
@@ -2941,7 +2936,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 		if (mcr->result != QM_MCR_RESULT_OK) {
 			DPAA_BUS_ERR("OOS after drain fail: FQ 0x%x (0x%x)",
-				      fqid, mcr->result);
+				fqid, mcr->result);
 			ret = -EIO;
 			goto out;
 		}
@@ -2960,7 +2955,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 
 		if (mcr->result != QM_MCR_RESULT_OK) {
 			DPAA_BUS_ERR("OOS fail: FQ 0x%x (0x%x)",
-				      fqid, mcr->result);
+				fqid, mcr->result);
 			ret = -EIO;
 			goto out;
 		}
diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index 45b094e0c6..451adb6afa 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -17,9 +17,10 @@
  * where CCSR isn't available).
  */
 u16 qman_ip_rev;
-u16 qm_channel_pool1 = QMAN_CHANNEL_POOL1;
-u16 qm_channel_caam = QMAN_CHANNEL_CAAM;
-u16 qm_channel_pme = QMAN_CHANNEL_PME;
+static u16 qm_channel_pool1 = QMAN_CHANNEL_POOL1;
+static u16 qm_channel_caam = QMAN_CHANNEL_CAAM;
+static u16 qm_channel_pme = QMAN_CHANNEL_PME;
+static u16 qm_channel_pool_num;
 
 /* Ccsr map address to access ccsrbased register */
 static void *qman_ccsr_map;
@@ -65,6 +66,11 @@ u16 dpaa_get_qm_channel_pool(void)
 	return qm_channel_pool1;
 }
 
+u16 dpaa_get_qm_channel_pool_num(void)
+{
+	return qm_channel_pool_num;
+}
+
 static int fsl_qman_portal_init(uint32_t index, int is_shared)
 {
 	struct qman_portal *portal;
@@ -275,7 +281,7 @@ int qman_global_init(void)
 	uint64_t phys_addr;
 	uint64_t regs_size;
 	const u32 *clk;
-
+	u16 pool_channel;
 	static int done;
 
 	if (done)
@@ -336,6 +342,21 @@ int qman_global_init(void)
 		return -EINVAL;
 	}
 
+	if (lenp != sizeof(rte_be32_t) * 2) {
+		pr_err("pool-channel-range should have 2 items.\n");
+		return -EINVAL;
+	}
+	pool_channel = rte_be_to_cpu_32(chanid[0]);
+	qm_channel_pool_num = rte_be_to_cpu_32(chanid[1]);
+
+	if (pool_channel != qm_channel_pool1) {
+		pr_warn("Pool channel(%04x) configured != default(0x%04x)\n",
+			pool_channel, qm_channel_pool1);
+	}
+	qm_channel_pool1 = pool_channel;
+	pr_debug("Pool channel starts from 0x%04x, number=%d, lenp:%zu\n",
+		qm_channel_pool1, qm_channel_pool_num, lenp);
+
 	/* get ccsr base */
 	dt_node = of_find_compatible_node(NULL, NULL, "fsl,qman");
 	if (!dt_node) {
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 522cdca27e..bb308e0d61 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -55,6 +55,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool_num)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 673859ed2e..bd46207232 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
- * Copyright 2019-2022 NXP
+ * Copyright 2019-2022, 2026 NXP
  *
  */
 
@@ -35,9 +35,6 @@ extern "C" {
 #define QMAN_CHANNEL_POOL1_REV3 0x401
 #define QMAN_CHANNEL_CAAM_REV3 0x840
 #define QMAN_CHANNEL_PME_REV3 0x860
-extern u16 qm_channel_pool1;
-extern u16 qm_channel_caam;
-extern u16 qm_channel_pme;
 enum qm_dc_portal {
 	qm_dc_portal_fman0 = 0,
 	qm_dc_portal_fman1 = 1,
@@ -51,6 +48,9 @@ u16 dpaa_get_qm_channel_caam(void);
 __rte_internal
 u16 dpaa_get_qm_channel_pool(void);
 
+__rte_internal
+u16 dpaa_get_qm_channel_pool_num(void);
+
 /* Portal processing (interrupt) sources */
 #define QM_PIRQ_CCSCI	0x00200000	/* CEETM Congestion State Change */
 #define QM_PIRQ_CSCI	0x00100000	/* Congestion State Change */
-- 
2.25.1

