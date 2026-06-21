Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B81CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 15:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE80402ED;
	Sun, 21 Jun 2026 17:22:40 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7FEE1402D9
 for <dev@dpdk.org>; Sun, 21 Jun 2026 17:22:37 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 56AC31A01DE;
 Sun, 21 Jun 2026 17:22:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F7D21A000C;
 Sun, 21 Jun 2026 17:22:37 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 93D11180007B;
 Sun, 21 Jun 2026 23:22:35 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3 03/19] drivers: add BMI Tx statistics
Date: Sun, 21 Jun 2026 20:52:12 +0530
Message-Id: <20260621152228.2777171-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
References: <20260621101651.1081425-1-hemant.agrawal@nxp.com>
 <20260621152228.2777171-1-hemant.agrawal@nxp.com>
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
counters. Extend fman_hw to read Tx BMI registers and expose
them through the xstats interface.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman_hw.c |  2 --
 drivers/bus/dpaa/include/fman.h      | 24 ++++++++++++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c       | 10 +++++++++-
 drivers/net/dpaa/dpaa_ethdev.h       | 11 +++++++++--
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman_hw.c b/drivers/bus/dpaa/base/fman/fman_hw.c
index ce68581555..aab04bf76a 100644
--- a/drivers/bus/dpaa/base/fman/fman_hw.c
+++ b/drivers/bus/dpaa/base/fman/fman_hw.c
@@ -301,7 +301,6 @@ fman_if_bmi_stats_enable(struct fman_if *p)
 	uint32_t tmp;
 
 	tmp = in_be32(&regs->fmbm_rstc);
-
 	tmp |= FMAN_BMI_COUNTERS_EN;
 
 	out_be32(&regs->fmbm_rstc, tmp);
@@ -315,7 +314,6 @@ fman_if_bmi_stats_disable(struct fman_if *p)
 	uint32_t tmp;
 
 	tmp = in_be32(&regs->fmbm_rstc);
-
 	tmp &= ~FMAN_BMI_COUNTERS_EN;
 
 	out_be32(&regs->fmbm_rstc, tmp);
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index a248edf4d8..2bddf489b8 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -306,6 +306,21 @@ struct tx_bmi_regs {
 	uint32_t fmbm_tfene;		/**< Tx Frame Enqueue Next Engine*/
 	uint32_t fmbm_trlmts;		/**< Tx Rate Limiter Scale*/
 	uint32_t fmbm_trlmt;		/**< Tx Rate Limiter*/
+	uint32_t reserved0034[0x73];/**< (0x0034 0x01FF) */
+	uint32_t fmbm_tstc;		/**< Tx Statistics Counters*/
+	uint32_t fmbm_tfrc;		/**< Tx Frame Counter*/
+	uint32_t fmbm_tfdc;		/**< Tx Frames Discard Counter*/
+	uint32_t fmbm_tfledc;	/**< Tx Frames Length Error Discard*/
+	uint32_t fmbm_tfufdc;	/**< Tx Frames Unsupported Format*/
+	uint32_t fmbm_tbdc;		/**< Tx Buffers Deallocate Counter */
+	uint32_t reserved0218[0x1a];/**< (0x0218 0x027F) */
+	uint32_t fmbm_tpc;		/**< Tx Performance Counters*/
+	uint32_t fmbm_tpcp;		/**< Tx Performance Count Parameters */
+	uint32_t fmbm_tccn;		/**< Tx Cycle Counter*/
+	uint32_t fmbm_ttuc;		/**< Tx Tasks Utilization Counter */
+	uint32_t fmbm_ttcquc;	/**< Tx Transmit Confirm Queue Utilization Counter*/
+	uint32_t fmbm_tduc;		/**< Tx DMA Utilization Counter */
+	uint32_t fmbm_tfuc;		/**< Tx FIFO Utilization Counter */
 };
 
 /* Description FM RTC timer alarm */
@@ -468,6 +483,15 @@ struct __fman_if {
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
 /* And this is the base list node that the interfaces are added to. (See
  * fman_if_enable_all_rx() below for an example of its use.)
  */
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 9f976d179b..8fb2e33e0a 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017-2020,2022-2025 NXP
+ *   Copyright 2017-2020,2022-2026 NXP
  *
  */
 /* System headers */
@@ -143,6 +143,14 @@ static const struct rte_dpaa_xstats_name_off dpaa_xstats_strings[] = {
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rodc)},
 	{"rx_buf_diallocate",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rbdc)},
+	{"tx_bad_frames_count",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfdc)},
+	{"tx_frame_length_discard",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfledc)},
+	{"tx_frames_unsupported_format",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfufdc)},
+	{"tx_buf_diallocate",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tbdc)},
 };
 
 static struct rte_dpaa_driver rte_dpaa_pmd;
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

