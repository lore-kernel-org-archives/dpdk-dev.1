Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506CC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB1BA40DD0;
	Thu, 20 Aug 2026 16:43:34 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B5B9940BA3
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:43:28 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94E7F2001C7;
 Thu, 20 Aug 2026 16:43:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EEB92001BD;
 Thu, 20 Aug 2026 16:43:28 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF39D18000B1;
 Thu, 20 Aug 2026 22:43:26 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v14 09/23] bus/dpaa: improve FQ shutdown with channel
 validation
Date: Thu, 20 Aug 2026 20:12:58 +0530
Message-Id: <20260820144312.3922316-10-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
References: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
 <20260820144312.3922316-1-hemant.agrawal@nxp.com>
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

Replace the hardcoded pool channel range check with DTS-derived pool
channel start/end values (dpaa_get_qm_channel_pool() and the new
dpaa_get_qm_channel_pool_num()).

Remove the old portal affinity check for pool-channel FQs. The portal's
dedicated channel (p->config->channel) never equals a pool channel, so
that check could never pass. Any portal can subscribe to any pool
channel via SDQCR, so simply program SDQCR to drain the FQ's channel
and restore the portal SDQCR unconditionally afterwards for both
dedicated and pool channels.

Read the pool-channel-range property from the device tree, validate it
has two items, and store the pool channel start and count. Warn if the
configured pool channel differs from the default.

Use the channel information obtained from DTS (parsed in an earlier
patch) to select the correct portal when shutting down push-mode Rx
queues. Previously the channel was hardcoded, causing incorrect portal
access on multi-block DPAA setups. Also clean up CGRID and other queue
parameters on shutdown.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c        | 67 ++++++++++++-----------
 drivers/bus/dpaa/base/qbman/qman_driver.c | 29 ++++++++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |  1 +
 drivers/bus/dpaa/include/fsl_qman.h       |  6 +-
 4 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 8dd55080d8..b429e61e1a 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
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
@@ -2843,10 +2843,9 @@ qman_shutdown_fq(struct qman_fq *fq)
 		}
 		res = mcr->result; /* Make a copy as we reuse MCR below */
 
-		if (res == QM_MCR_RESULT_OK)
+		if (res == QM_MCR_RESULT_OK) {
 			drain_mr_fqrni(&p->p);
-
-		if (res == QM_MCR_RESULT_PENDING) {
+		} else if (res == QM_MCR_RESULT_PENDING) {
 			/*
 			 * Need to wait for the FQRN in the message ring, which
 			 * will only occur once the FQ has been drained.  In
@@ -2858,47 +2857,51 @@ qman_shutdown_fq(struct qman_fq *fq)
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
+				/*
+				 * Pool channel: subscribe this portal to it so
+				 * the hardware can deliver frames and the FQ
+				 * retires.  p->config->channel is the portal's
+				 * dedicated channel and never equals a pool
+				 * channel, so the old affinity check always
+				 * failed.  Any portal can subscribe to any pool
+				 * channel via SDQCR.
+				 */
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_POOL_CONV(channel));
+			} else if (channel < pool_ch_start) {
 				/* Dedicated channel */
-				dequeue_wq = wq;
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_DEDICATED);
 			} else {
-				DPAA_BUS_ERR("Can't recover FQ 0x%x, ch: 0x%x",
-					fqid, channel);
+				/* Channel is in DCP portal range (e.g. FM0); not drainable here */
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
+
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
+
+			/* Restore portal SDQCR for both dedicated and pool channels */
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
diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index 45b094e0c6..b71cafae4c 100644
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
+		pr_warn("Pool channel(0x%04x) configured != default(0x%04x)\n",
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
index b1e5d445e3..b806b44d29 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -61,6 +61,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_link_status)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool_num)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_status)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_speed)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_restart_link_autoneg)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 871cafb832..5d254768b9 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
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

