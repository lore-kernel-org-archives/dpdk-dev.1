Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37CBC5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 622E34278A;
	Tue, 11 Aug 2026 13:57:53 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA24415D7
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:57:50 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 717B51A01A3;
 Tue, 11 Aug 2026 13:57:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 377761A001C;
 Tue, 11 Aug 2026 13:57:50 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AD53118000B0;
 Tue, 11 Aug 2026 19:57:48 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v8 11/26] drivers: add BMI Tx statistics
Date: Tue, 11 Aug 2026 17:27:16 +0530
Message-Id: <20260811115731.3421032-12-hemant.agrawal@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

Add support for BMI (Buffer Manager Interface) Tx statistics
counters. Extend fman_hw to read Tx BMI registers and expose
them through the xstats interface.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/include/fman.h |  9 +++++++++
 drivers/net/dpaa/dpaa_ethdev.c  |  8 ++++++++
 drivers/net/dpaa/dpaa_ethdev.h  | 11 +++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index d949b38b8d..6ffa470f36 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -468,6 +468,15 @@ struct __fman_if {
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
index 82e5f496cd..7318cd7f34 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -143,6 +143,14 @@ static const struct rte_dpaa_xstats_name_off dpaa_xstats_strings[] = {
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rodc)},
 	{"rx_buf_deallocate",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rbdc)},
+	{"tx_bad_frames_count",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfdc)},
+	{"tx_frame_length_discard",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfledc)},
+	{"tx_frames_unsupported_format",
+		offsetof(struct dpaa_if_tx_bmi_stats, fmbm_tfufdc)},
+	{"tx_buf_deallocate",
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

