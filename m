Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE7DCA5FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 09:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5FBC40B9F;
	Fri,  9 Oct 2026 11:11:21 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7947D402E2
 for <dev@dpdk.org>; Fri,  9 Oct 2026 11:11:09 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B99E200311;
 Fri,  9 Oct 2026 11:11:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2782C20030D;
 Fri,  9 Oct 2026 11:11:09 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9899118000B5;
 Fri,  9 Oct 2026 17:11:08 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v23 13/27] drivers: add BMI Tx statistics
Date: Fri,  9 Oct 2026 14:40:47 +0530
Message-Id: <20261009091101.1703494-14-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261009091101.1703494-1-hemant.agrawal@nxp.com>
References: <20261007072439.3135351-1-hemant.agrawal@nxp.com>
 <20261009091101.1703494-1-hemant.agrawal@nxp.com>
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

Add support for BMI (Buffer Manager Interface) Tx statistics
counters. Extend fman to read Tx BMI registers and expose
them through the xstats interface.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman_hw.c | 98 +++++++++++++++++++++-------
 drivers/bus/dpaa/include/fman.h      | 28 ++++++++
 drivers/net/dpaa/dpaa_ethdev.c       | 33 ++++++++--
 drivers/net/dpaa/dpaa_ethdev.h       | 11 +++-
 4 files changed, 142 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman_hw.c b/drivers/bus/dpaa/base/fman/fman_hw.c
index 731ba6aa25..3aa502c6e1 100644
--- a/drivers/bus/dpaa/base/fman/fman_hw.c
+++ b/drivers/bus/dpaa/base/fman/fman_hw.c
@@ -296,13 +296,24 @@ fman_if_bmi_stats_enable(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
 	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
+	struct tx_bmi_regs *tx_regs = (struct tx_bmi_regs *)m->tx_bmi_map;
 	uint32_t tmp;
 
-	tmp = in_be32(&regs->fmbm_rstc);
+	if (regs) {
+		tmp = in_be32(&regs->fmbm_rstc);
 
-	tmp |= FMAN_BMI_COUNTERS_EN;
+		tmp |= FMAN_BMI_COUNTERS_EN;
 
-	out_be32(&regs->fmbm_rstc, tmp);
+		out_be32(&regs->fmbm_rstc, tmp);
+	}
+
+	if (tx_regs) {
+		tmp = in_be32(&tx_regs->fmbm_tstc);
+
+		tmp |= FMAN_BMI_COUNTERS_EN;
+
+		out_be32(&tx_regs->fmbm_tstc, tmp);
+	}
 }
 
 void
@@ -310,13 +321,24 @@ fman_if_bmi_stats_disable(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
 	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
+	struct tx_bmi_regs *tx_regs = (struct tx_bmi_regs *)m->tx_bmi_map;
 	uint32_t tmp;
 
-	tmp = in_be32(&regs->fmbm_rstc);
+	if (regs) {
+		tmp = in_be32(&regs->fmbm_rstc);
 
-	tmp &= ~FMAN_BMI_COUNTERS_EN;
+		tmp &= ~FMAN_BMI_COUNTERS_EN;
 
-	out_be32(&regs->fmbm_rstc, tmp);
+		out_be32(&regs->fmbm_rstc, tmp);
+	}
+
+	if (tx_regs) {
+		tmp = in_be32(&tx_regs->fmbm_tstc);
+
+		tmp &= ~FMAN_BMI_COUNTERS_EN;
+
+		out_be32(&tx_regs->fmbm_tstc, tmp);
+	}
 }
 
 void
@@ -324,16 +346,37 @@ fman_if_bmi_stats_get_all(struct fman_if *p, uint64_t *value)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
 	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
+	struct tx_bmi_regs *tx_regs = (struct tx_bmi_regs *)m->tx_bmi_map;
+
 	int i = 0;
 
-	value[i++] = (u32)in_be32(&regs->fmbm_rfrc);
-	value[i++] = (u32)in_be32(&regs->fmbm_rfbc);
-	value[i++] = (u32)in_be32(&regs->fmbm_rlfc);
-	value[i++] = (u32)in_be32(&regs->fmbm_rffc);
-	value[i++] = (u32)in_be32(&regs->fmbm_rfdc);
-	value[i++] = (u32)in_be32(&regs->fmbm_rfldec);
-	value[i++] = (u32)in_be32(&regs->fmbm_rodc);
-	value[i++] = (u32)in_be32(&regs->fmbm_rbdc);
+	/* Report zero for register blocks that are not mapped for this port
+	 * type, the caller expects a fixed number of values in a fixed order.
+	 */
+	if (regs) {
+		value[i++] = (u32)in_be32(&regs->fmbm_rfrc);
+		value[i++] = (u32)in_be32(&regs->fmbm_rfbc);
+		value[i++] = (u32)in_be32(&regs->fmbm_rlfc);
+		value[i++] = (u32)in_be32(&regs->fmbm_rffc);
+		value[i++] = (u32)in_be32(&regs->fmbm_rfdc);
+		value[i++] = (u32)in_be32(&regs->fmbm_rfldec);
+		value[i++] = (u32)in_be32(&regs->fmbm_rodc);
+		value[i++] = (u32)in_be32(&regs->fmbm_rbdc);
+	} else {
+		while (i < (int)FMAN_IF_BMI_RX_STATS_COUNT)
+			value[i++] = 0;
+	}
+
+	if (tx_regs) {
+		value[i++] = (u32)in_be32(&tx_regs->fmbm_tfrc);
+		value[i++] = (u32)in_be32(&tx_regs->fmbm_tfdc);
+		value[i++] = (u32)in_be32(&tx_regs->fmbm_tfledc);
+		value[i++] = (u32)in_be32(&tx_regs->fmbm_tfufdc);
+		value[i++] = (u32)in_be32(&tx_regs->fmbm_tbdc);
+	} else {
+		while (i < (int)FMAN_IF_BMI_STATS_COUNT)
+			value[i++] = 0;
+	}
 }
 
 void
@@ -341,15 +384,26 @@ fman_if_bmi_stats_reset(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
 	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
+	struct tx_bmi_regs *tx_regs = (struct tx_bmi_regs *)m->tx_bmi_map;
+
+	if (regs) {
+		out_be32(&regs->fmbm_rfrc, 0);
+		out_be32(&regs->fmbm_rfbc, 0);
+		out_be32(&regs->fmbm_rlfc, 0);
+		out_be32(&regs->fmbm_rffc, 0);
+		out_be32(&regs->fmbm_rfdc, 0);
+		out_be32(&regs->fmbm_rfldec, 0);
+		out_be32(&regs->fmbm_rodc, 0);
+		out_be32(&regs->fmbm_rbdc, 0);
+	}
 
-	out_be32(&regs->fmbm_rfrc, 0);
-	out_be32(&regs->fmbm_rfbc, 0);
-	out_be32(&regs->fmbm_rlfc, 0);
-	out_be32(&regs->fmbm_rffc, 0);
-	out_be32(&regs->fmbm_rfdc, 0);
-	out_be32(&regs->fmbm_rfldec, 0);
-	out_be32(&regs->fmbm_rodc, 0);
-	out_be32(&regs->fmbm_rbdc, 0);
+	if (tx_regs) {
+		out_be32(&tx_regs->fmbm_tfrc, 0);
+		out_be32(&tx_regs->fmbm_tfdc, 0);
+		out_be32(&tx_regs->fmbm_tfledc, 0);
+		out_be32(&tx_regs->fmbm_tfufdc, 0);
+		out_be32(&tx_regs->fmbm_tbdc, 0);
+	}
 }
 
 void
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index d949b38b8d..f642faf3b3 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -306,6 +306,13 @@ struct tx_bmi_regs {
 	uint32_t fmbm_tfene;		/**< Tx Frame Enqueue Next Engine*/
 	uint32_t fmbm_trlmts;		/**< Tx Rate Limiter Scale*/
 	uint32_t fmbm_trlmt;		/**< Tx Rate Limiter*/
+	uint32_t reserved0034[0x73];	/**< (0x034 - 0x1FF) */
+	uint32_t fmbm_tstc;		/**< Tx Statistics Counters*/
+	uint32_t fmbm_tfrc;		/**< Tx Frame Counter*/
+	uint32_t fmbm_tfdc;		/**< Tx Frames Discard Counter*/
+	uint32_t fmbm_tfledc;		/**< Tx Frames Length Error Discard Counter*/
+	uint32_t fmbm_tfufdc;		/**< Tx Frames Unsupported Format Discard Counter*/
+	uint32_t fmbm_tbdc;		/**< Tx Buffers Deallocate Counter*/
 };
 
 /* Description FM RTC timer alarm */
@@ -468,6 +475,27 @@ struct __fman_if {
 	void *qmi_map;
 };
 
+#define MEMMAC_REG_OFFSET(reg) offsetof(struct memac_regs, reg)
+#define BMI_RX_REG_OFFSET(reg) offsetof(struct rx_bmi_regs, reg)
+#define BMI_TX_REG_OFFSET(reg) offsetof(struct tx_bmi_regs, reg)
+
+#define FMAN_IF_BMI_RX_STAT_OFFSET_START BMI_RX_REG_OFFSET(fmbm_rfrc)
+#define FMAN_IF_BMI_RX_STAT_OFFSET_END BMI_RX_REG_OFFSET(fmbm_rbdc)
+#define FMAN_IF_BMI_TX_STAT_OFFSET_START BMI_TX_REG_OFFSET(fmbm_tfrc)
+#define FMAN_IF_BMI_TX_STAT_OFFSET_END BMI_TX_REG_OFFSET(fmbm_tbdc)
+
+/* Number of BMI counters in each contiguous register window. Derived from
+ * the window bounds above so they cannot drift from the register layout.
+ */
+#define FMAN_IF_BMI_RX_STATS_COUNT \
+	((FMAN_IF_BMI_RX_STAT_OFFSET_END - \
+	  FMAN_IF_BMI_RX_STAT_OFFSET_START) / sizeof(uint32_t) + 1)
+#define FMAN_IF_BMI_TX_STATS_COUNT \
+	((FMAN_IF_BMI_TX_STAT_OFFSET_END - \
+	  FMAN_IF_BMI_TX_STAT_OFFSET_START) / sizeof(uint32_t) + 1)
+#define FMAN_IF_BMI_STATS_COUNT \
+	(FMAN_IF_BMI_RX_STATS_COUNT + FMAN_IF_BMI_TX_STATS_COUNT)
+
 /* And this is the base list node that the interfaces are added to. (See
  * fman_if_enable_all_rx() below for an example of its use.)
  */
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 18c1a8c820..bf006fefc7 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -146,8 +146,33 @@ static const struct rte_dpaa_xstats_name_off dpaa_xstats_strings[] = {
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rodc)},
 	{"rx_buf_deallocate",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rbdc)},
+	{"tx_frame_counter",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfrc)},
+	{"tx_bad_frames_count",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfdc)},
+	{"tx_frame_length_discard",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfledc)},
+	{"tx_frames_unsupported_format",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfufdc)},
+	{"tx_buf_deallocate",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tbdc)},
 };
 
+/* Number of BMI entries at the tail of dpaa_xstats_strings[].
+ * Must equal RTE_DIM(dpaa_xstats_strings) - number_of_non_bmi_entries.
+ */
+#define DPAA_MAC_XSTATS_COUNT   13
+#define DPAA_BMI_XSTATS_COUNT   (RTE_DIM(dpaa_xstats_strings) - DPAA_MAC_XSTATS_COUNT)
+static_assert(sizeof(struct dpaa_if_rx_bmi_stats) / sizeof(uint32_t)
+		+ sizeof(struct dpaa_if_tx_bmi_stats) / sizeof(uint32_t)
+		== DPAA_BMI_XSTATS_COUNT,
+		"DPAA_BMI_XSTATS_COUNT out of sync with BMI stats structs");
+/* Every BMI counter read by fman_if_bmi_stats_get_all() must have a name
+ * entry above, and vice versa.
+ */
+static_assert(FMAN_IF_BMI_STATS_COUNT == DPAA_BMI_XSTATS_COUNT,
+		"DPAA_BMI_XSTATS_COUNT out of sync with BMI register windows");
+
 static struct rte_dpaa_driver rte_dpaa_pmd;
 int dpaa_valid_dev;
 struct rte_mempool *dpaa_tx_sg_pool;
@@ -917,7 +942,7 @@ dpaa_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 {
 	unsigned int i = 0, j, num = RTE_DIM(dpaa_xstats_strings);
 	uint64_t values[sizeof(struct dpaa_if_stats) / 8];
-	unsigned int bmi_count = sizeof(struct dpaa_if_rx_bmi_stats) / 4;
+	unsigned int bmi_count = DPAA_BMI_XSTATS_COUNT;
 
 	if (n < num)
 		return num;
@@ -928,7 +953,7 @@ dpaa_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 	fman_if_stats_get_all(dev->process_private, values,
 			      sizeof(struct dpaa_if_stats) / 8);
 
-	for (i = 0; i < num - (bmi_count - 1); i++) {
+	for (i = 0; i < num - bmi_count; i++) {
 		xstats[i].id = i;
 		xstats[i].value = values[dpaa_xstats_strings[i].offset / 8];
 	}
@@ -966,7 +991,7 @@ dpaa_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 {
 	unsigned int i, j, stat_cnt = RTE_DIM(dpaa_xstats_strings);
 	uint64_t values_copy[sizeof(struct dpaa_if_stats) / 8];
-	unsigned int bmi_count = sizeof(struct dpaa_if_rx_bmi_stats) / 4;
+	unsigned int bmi_count = DPAA_BMI_XSTATS_COUNT;
 
 	if (!ids) {
 		if (n < stat_cnt)
@@ -978,7 +1003,7 @@ dpaa_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		fman_if_stats_get_all(dev->process_private, values_copy,
 				      sizeof(struct dpaa_if_stats) / 8);
 
-		for (i = 0; i < stat_cnt - (bmi_count - 1); i++)
+		for (i = 0; i < stat_cnt - bmi_count; i++)
 			values[i] =
 				values_copy[dpaa_xstats_strings[i].offset / 8];
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.h b/drivers/net/dpaa/dpaa_ethdev.h
index f400030a5c..d342d98f23 100644
--- a/drivers/net/dpaa/dpaa_ethdev.h
+++ b/drivers/net/dpaa/dpaa_ethdev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2014-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017-2024 NXP
+ *   Copyright 2017-2026 NXP
  *
  */
 #ifndef __DPAA_ETHDEV_H__
@@ -234,7 +234,6 @@ dpaa_rx_cb_atomic(void *event,
 		  void **bufs);
 
 struct dpaa_if_rx_bmi_stats {
-	uint32_t fmbm_rstc;		/**< Rx Statistics Counters*/
 	uint32_t fmbm_rfrc;		/**< Rx Frame Counter*/
 	uint32_t fmbm_rfbc;		/**< Rx Bad Frames Counter*/
 	uint32_t fmbm_rlfc;		/**< Rx Large Frames Counter*/
@@ -245,6 +244,14 @@ struct dpaa_if_rx_bmi_stats {
 	uint32_t fmbm_rbdc;		/**< Rx Buffers Deallocate Counter*/
 };
 
+struct dpaa_if_tx_bmi_stats {
+	uint32_t fmbm_tfrc;		/**< Tx Frame Counter*/
+	uint32_t fmbm_tfdc;		/**< Tx Frames Discard Counter*/
+	uint32_t fmbm_tfledc;	/**< Tx Frames Length Error Discard*/
+	uint32_t fmbm_tfufdc;	/**< Tx Frames Unsupported Format*/
+	uint32_t fmbm_tbdc;		/**< Tx Buffers Deallocate Counter */
+};
+
 int
 dpaa_tx_conf_queue_init(struct qman_fq *fq);
 
-- 
2.25.1

