Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5AC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8704442ED5;
	Thu, 10 Sep 2026 15:53:03 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4CCC342E78
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:50 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3207A200432;
 Thu, 10 Sep 2026 15:52:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EF9BF200035;
 Thu, 10 Sep 2026 15:52:49 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D3B318000B5;
 Thu, 10 Sep 2026 21:52:48 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 41/47] drivers: consume dpaa2 DQRR entries in batches
Date: Thu, 10 Sep 2026 19:21:52 +0530
Message-ID: <20260910135158.2181141-42-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Each DQRR entry consumed by the software portal costs a write to the
cache-invalidate DCAP register. The DCAP register also supports a vector
mode where a bitmap of DQRR indices is consumed with a single write, so
accumulate the indices and flush the vector once half the ring is
pending. A smaller threshold gives little benefit, and a threshold close
to the ring size starves WRIOP of DQRR space.

Because entries are now released in batches, a caller that stops polling
a portal must flush the pending vector explicitly. Pass a NULL dequeue
result to qbman_swp_dqrr_consume() to do that when the eventdev dequeue
finds the portal dry, when the net PMD finishes draining a portal, and
when a portal is released back to the bus.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  4 ++
 .../fslmc/qbman/include/fsl_qbman_portal.h    |  5 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        | 68 +++++++++++++++++--
 drivers/bus/fslmc/qbman/qbman_portal.h        | 11 ++-
 drivers/event/dpaa2/dpaa2_eventdev.c          |  4 ++
 drivers/net/dpaa2/dpaa2_ethdev.c              |  2 +
 6 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 20d1bb2a66..cfd9548fb0 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -305,6 +305,10 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx
 static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 {
 	if (dpio_dev) {
+		/* consume indices may still be pending in the portal's DQRR
+		 * consume vector; flush them before the portal is released.
+		 */
+		qbman_swp_dqrr_consume(dpio_dev->sw_portal, NULL);
 		/* rx-queue interrupts (net PMD) can arm a portal without the
 		 * event driver; tear it down unconditionally. Safe when never
 		 * armed: intr_deinit returns early if intr is not enabled.
diff --git a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
index b9e7789766..73e57bcdc1 100644
--- a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
@@ -451,7 +451,10 @@ void qbman_swp_prefetch_dqrr_next(struct qbman_swp *s);
  * qbman_swp_dqrr_consume() -  Consume DQRR entries previously returned from
  * qbman_swp_dqrr_next().
  * @s: the software portal object.
- * @dq: the DQRR entry to be consumed.
+ * @dq: the DQRR entry to be consumed, NULL to consume the entries accumulated
+ * so far. Entries are accumulated and consumed in batches, so a caller which
+ * stops polling the portal must call this with a NULL dq to release the
+ * entries it has already processed.
  */
 __rte_internal
 void qbman_swp_dqrr_consume(struct qbman_swp *s, const struct qbman_result *dq);
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index c93bec5dd3..64b61a5551 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Copyright 2018-2020,2023-2024 NXP
+ * Copyright 2018-2020,2023-2024,2026 NXP
  *
  */
 
@@ -9,13 +9,20 @@
 #include "qbman_portal.h"
 
 #include <eal_export.h>
+#include <rte_bitops.h>
 
 /* QBMan portal management command codes */
 #define QBMAN_MC_ACQUIRE       0x30
 #define QBMAN_WQCHAN_CONFIGURE 0x46
 
 /* Reverse mapping of QBMAN_CENA_SWP_DQRR() */
-#define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)p & 0x1ff) >> 6)
+#define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)(p) & 0x1ff) >> 6)
+
+/* DCAP consume-index-vector mode: the vector of DQRR indices to consume starts
+ * at bit 16 of DCAP and bit 8 selects vector mode over single-index mode.
+ */
+#define DQRR_DCAP_CI_VEC_OFFSET 16
+#define DQRR_DCAP_CI_VEC_SELECT 0x100
 
 /* QBMan FQ management command codes */
 #define QBMAN_FQ_SCHEDULE	0x48
@@ -284,6 +291,18 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 		p->dqrr.dqrr_size = 8;
 		p->dqrr.reset_bug = 0;
 	}
+	/* Consume DQRR entries in vector mode by default and flush the vector
+	 * once half the ring is pending. A smaller threshold gives little
+	 * benefit; a threshold close to the ring size starves WRIOP of DQRR
+	 * space and slows its enqueues down.
+	 *
+	 * The DCAP consume vector only holds (32 - DQRR_DCAP_CI_VEC_OFFSET)
+	 * index bits, so vector mode can only address a ring that fits in
+	 * them; fall back to per-entry consume for anything larger.
+	 */
+	p->dqrr.ci_vec_en =
+		p->dqrr.dqrr_size <= (32 - DQRR_DCAP_CI_VEC_OFFSET);
+	p->dqrr.ci_flush_th = p->dqrr.dqrr_size / 2;
 
 	ret = qbman_swp_sys_init(&p->sys, d, p->dqrr.dqrr_size);
 	if (ret) {
@@ -2225,13 +2244,47 @@ const struct qbman_result *qbman_swp_dqrr_next_mem_back(struct qbman_swp *s)
 	return p;
 }
 
-/* Consume DQRR entries previously returned from qbman_swp_dqrr_next(). */
+/* Write the pending consume vector to DCAP if it holds at least "threshold"
+ * indices, consuming all of them with a single register access.
+ */
+static inline void
+qbman_swp_dqrr_vec_flush(struct qbman_swp *s, uint8_t threshold)
+{
+	if (s->dqrr.ci_count < threshold)
+		return;
+
+	qbman_cinh_write(&s->sys, QBMAN_CINH_SWP_DCAP,
+			 s->dqrr.ci_vector | DQRR_DCAP_CI_VEC_SELECT);
+	s->dqrr.ci_vector = 0;
+	s->dqrr.ci_count = 0;
+}
+
+/* Add a DQRR index to the pending consume vector, flushing it once the
+ * configured threshold is reached.
+ */
+static inline void
+qbman_swp_dqrr_vec_consume(struct qbman_swp *s, uint8_t idx)
+{
+	s->dqrr.ci_vector |= RTE_BIT32(idx + DQRR_DCAP_CI_VEC_OFFSET);
+	s->dqrr.ci_count++;
+	qbman_swp_dqrr_vec_flush(s, s->dqrr.ci_flush_th);
+}
+
+/* Consume DQRR entries previously returned from qbman_swp_dqrr_next().
+ * A NULL dq flushes any indices still pending in the consume vector, which
+ * the caller must do before it stops polling the portal.
+ */
 RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_consume)
 void qbman_swp_dqrr_consume(struct qbman_swp *s,
 			    const struct qbman_result *dq)
 {
-	qbman_cinh_write(&s->sys,
-			QBMAN_CINH_SWP_DCAP, QBMAN_IDX_FROM_DQRR(dq));
+	if (unlikely(dq == NULL))
+		qbman_swp_dqrr_vec_flush(s, 1);
+	else if (s->dqrr.ci_vec_en)
+		qbman_swp_dqrr_vec_consume(s, QBMAN_IDX_FROM_DQRR(dq));
+	else
+		qbman_cinh_write(&s->sys, QBMAN_CINH_SWP_DCAP,
+				 QBMAN_IDX_FROM_DQRR(dq));
 }
 
 /* Consume DQRR entries previously returned from qbman_swp_dqrr_next(). */
@@ -2239,7 +2292,10 @@ RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_idx_consume)
 void qbman_swp_dqrr_idx_consume(struct qbman_swp *s,
 			    uint8_t dqrr_index)
 {
-	qbman_cinh_write(&s->sys, QBMAN_CINH_SWP_DCAP, dqrr_index);
+	if (s->dqrr.ci_vec_en)
+		qbman_swp_dqrr_vec_consume(s, dqrr_index);
+	else
+		qbman_cinh_write(&s->sys, QBMAN_CINH_SWP_DCAP, dqrr_index);
 }
 
 /*********************************/
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.h b/drivers/bus/fslmc/qbman/qbman_portal.h
index 1cf7918309..db74db5fe1 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/qbman_portal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Copyright 2018-2020 NXP
+ * Copyright 2018-2020, 2026 NXP
  *
  */
 
@@ -93,6 +93,15 @@ struct qbman_swp {
 		uint32_t valid_bit;
 		uint8_t dqrr_size;
 		int reset_bug;
+		/* Consume index vector: instead of writing DCAP once per
+		 * consumed entry, the indices are accumulated in ci_vector
+		 * and written with a single DCAP access once ci_count
+		 * reaches ci_flush_th.
+		 */
+		bool ci_vec_en;
+		uint8_t ci_count;
+		uint8_t ci_flush_th;
+		uint32_t ci_vector;
 	} dqrr;
 	struct {
 		uint32_t pi;
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 95d9154b11..5d32bd9fd6 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -320,6 +320,10 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 	do {
 		dq = qbman_swp_dqrr_next(swp);
 		if (!dq) {
+			/* portal is dry: consume whatever is still pending in
+			 * the DQRR consume vector before leaving it idle.
+			 */
+			qbman_swp_dqrr_consume(swp, NULL);
 			if (!num_pkts && timeout_ticks) {
 				dpaa2_eventdev_dequeue_wait(timeout_ticks);
 				timeout_ticks = 0;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index e44c073f82..27ddb106c8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3518,6 +3518,8 @@ dpaa2_napi_drain_portal(struct dpaa2_dpio_dev *dpio)
 
 	while ((dq = qbman_swp_dqrr_next(dpio->sw_portal)))
 		qbman_swp_dqrr_consume(dpio->sw_portal, dq);
+	/* flush the indices still pending in the DQRR consume vector */
+	qbman_swp_dqrr_consume(dpio->sw_portal, NULL);
 	qbman_swp_interrupt_clear_status(dpio->sw_portal, 0xffffffff);
 }
 
-- 
2.43.0

