Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D2CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D12A40DCB;
	Thu, 15 Oct 2026 16:12:11 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4B755406B8
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:11:52 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DD991A007D;
 Thu, 15 Oct 2026 16:11:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA6EF1A00AA;
 Thu, 15 Oct 2026 16:11:51 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5395618000B6;
 Thu, 15 Oct 2026 22:11:51 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v26 12/26] bus/dpaa: scan pool channel range from DTS
Date: Thu, 15 Oct 2026 19:41:30 +0530
Message-Id: <20261015141144.3140281-13-hemant.agrawal@nxp.com>
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

qman_shutdown_fq() bounds the pool channel range with a hardcoded 15
channels past the first pool channel. Read the actual range from the
fsl,pool-channel-range device tree node instead, validate that the
property has two items, and store the start and the count.

Warn if the configured start differs from the compiled-in default, and
expose the count through the new dpaa_get_qm_channel_pool_num() so the
shutdown path can use the DTS-derived bound.

qm_channel_pool1 and qm_channel_caam become static as they are now only
reached through their accessors. qm_channel_pme is dropped: it is no
longer exported and nothing reads it.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c        | 20 +++++++++-------
 drivers/bus/dpaa/base/qbman/qman_driver.c | 29 +++++++++++++++++++----
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |  1 +
 drivers/bus/dpaa/include/fsl_qman.h       |  9 ++++---
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 896adaa1a6..584abdc293 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2793,7 +2793,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 	u32 res, fqid = fq->fqid;
 	u32 loop;
 	u8 state;
-	u32 channel;
+	u16 channel;
 
 	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
 	if (!p)
@@ -2807,9 +2807,10 @@ qman_shutdown_fq(struct qman_fq *fq)
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
 
@@ -2843,10 +2844,9 @@ qman_shutdown_fq(struct qman_fq *fq)
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
@@ -2858,13 +2858,15 @@ qman_shutdown_fq(struct qman_fq *fq)
 			/* Flag that we need to drain FQ */
 			drain = 1;
 
-			if (channel >= qm_channel_pool1 &&
-				channel < (u16)(qm_channel_pool1 + 15)) {
+			const u16 pool_ch_start = dpaa_get_qm_channel_pool();
+			const u16 pool_ch_end = pool_ch_start +
+					dpaa_get_qm_channel_pool_num();
+			if (channel >= pool_ch_start && channel < pool_ch_end) {
 				/* Any portal may subscribe to a pool channel. */
 				qm_dqrr_sdqcr_set(&p->p,
 						  QM_SDQCR_TYPE_ACTIVE |
 						  QM_SDQCR_CHANNELS_POOL_CONV(channel));
-			} else if (channel < qm_channel_pool1) {
+			} else if (channel < pool_ch_start) {
 				/* DEDICATED only dequeues our own channel, so
 				 * another portal's FQ would never retire here.
 				 */
@@ -2909,7 +2911,7 @@ qman_shutdown_fq(struct qman_fq *fq)
 		if (res != QM_MCR_RESULT_OK &&
 		    res != QM_MCR_RESULT_PENDING) {
 			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x",
-				      fqid, res);
+				fqid, res);
 			ret = -EIO;
 			goto out;
 		}
diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index bbe2640c52..1d91cd21e1 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -17,9 +17,9 @@
  * where CCSR isn't available).
  */
 u16 qman_ip_rev;
-u16 qm_channel_pool1 = QMAN_CHANNEL_POOL1;
-u16 qm_channel_caam = QMAN_CHANNEL_CAAM;
-u16 qm_channel_pme = QMAN_CHANNEL_PME;
+static u16 qm_channel_pool1 = QMAN_CHANNEL_POOL1;
+static u16 qm_channel_caam = QMAN_CHANNEL_CAAM;
+static u16 qm_channel_pool_num;
 
 /* Ccsr map address to access ccsrbased register */
 static void *qman_ccsr_map;
@@ -63,6 +63,11 @@ u16 dpaa_get_qm_channel_pool(void)
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
@@ -273,7 +278,7 @@ int qman_global_init(void)
 	uint64_t phys_addr;
 	uint64_t regs_size;
 	const u32 *clk;
-
+	u16 pool_channel;
 	static int done;
 
 	if (done)
@@ -320,7 +325,6 @@ int qman_global_init(void)
 	if ((qman_ip_rev & 0xFF00) >= QMAN_REV30) {
 		qm_channel_pool1 = QMAN_CHANNEL_POOL1_REV3;
 		qm_channel_caam = QMAN_CHANNEL_CAAM_REV3;
-		qm_channel_pme = QMAN_CHANNEL_PME_REV3;
 	}
 
 	dt_node = of_find_compatible_node(NULL, NULL, "fsl,pool-channel-range");
@@ -334,6 +338,21 @@ int qman_global_init(void)
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
index 522cdca27e..3e243a4426 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -59,6 +59,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_link_status)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool_num)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_status)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_speed)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_restart_link_autoneg)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index d67b571dcc..59b41e17f0 100644
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
@@ -1276,6 +1276,9 @@ struct qman_cgr {
 	struct list_head node;
 };
 
+/* Maximum FQID value: frame queue IDs are 24 bits wide. */
+#define QMAN_MAX_FQID			0x00FFFFFFu
+
 /* Polling bound while waiting for an FQ retirement notification. A retire
  * that has not been reported by then is not going to complete on this portal.
  */
-- 
2.25.1

