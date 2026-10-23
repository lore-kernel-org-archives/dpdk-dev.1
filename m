Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FF2606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94CE94111C;
	Fri, 23 Oct 2026 15:44:54 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9684740FDE
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:40 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 787121A0038;
 Fri, 23 Oct 2026 15:44:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 170AB1A000A;
 Fri, 23 Oct 2026 15:44:40 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B048B1800068;
 Fri, 23 Oct 2026 21:44:38 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 44/65] bus/fslmc: consolidate DPIO interrupt setup and
 bound coalescing
Date: Fri, 23 Oct 2026 19:13:24 +0530
Message-ID: <20261023134346.37727-45-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Move the DPIO DQRI interrupt setup into rte_dpaa2_alloc_dpio_device()
so that both the event PMD and the portal-affine path share a single
entry point. The allocator now takes the interrupt-enable flag, the
DQRR coalescing threshold and the target CPU, and it optionally pins
the portal IRQ to that core. This removes the duplicated interrupt
init that previously lived in dpaa2_configure_stashing().

Validate the coalescing configuration on the way in:

  - The DQRR threshold is capped at the portal DQRR ring depth minus
    one (DPAA2_PORTAL_INTR_THRESH_MAX). An out-of-range value from the
    DPAA2_PORTAL_INTR_THRESHOLD environment variable or the caller is
    rejected and coalescing is disabled.
  - qbman_swp_dqrr_thrshld_write() clamps the threshold to the ring
    size, and qbman_swp_intr_timeout_write() clamps the ITP tick to
    QBMAN_CINH_SWP_ITPR_MAX (12-bit field).

Also clean up the QBMan portal interrupt helpers:

  - Add QBMAN_SWP_INTERRUPT_ALL and use it when clearing the portal
    interrupt status instead of the bare 0xffffffff mask.
  - Fix qbman_swp_interrupt_set_inhibit() to write the single LSB
    inhibit bit as described by the reference manual rather than an
    all-ones mask.
  - Rename the misleading "mask" parameters of the threshold and
    timeout writers to "threshold" and "qbman_tick".

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 103 ++++++++----------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |   5 +-
 .../fslmc/qbman/include/fsl_qbman_portal.h    |  12 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        |  22 +++-
 drivers/bus/fslmc/qbman/qbman_sys.h           |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev.c          |   3 +-
 6 files changed, 79 insertions(+), 70 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 654472b284..4affd4e0b4 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -181,7 +181,7 @@ dpaa2_dpio_affine_intr_to_core(int32_t dpio_id)
  */
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
 int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
-			 int timeout, bool build_epoll)
+	int timeout, bool build_epoll)
 {
 	int eventfd, dpio_epoll_fd, ret;
 	struct epoll_event epoll_ev;
@@ -191,13 +191,12 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 
 	ret = rte_dpaa2_intr_enable(dpio_dev->intr_handle, 0);
 	if (ret) {
-		DPAA2_BUS_ERR("Interrupt registration failed");
-		return -1;
+		DPAA2_BUS_ERR("Failed(%d) to enable dpio interrupt", ret);
+		return ret;
 	}
 
-	qbman_swp_interrupt_set_trigger(dpio_dev->sw_portal,
-					QBMAN_SWP_INTERRUPT_DQRI);
-	qbman_swp_interrupt_clear_status(dpio_dev->sw_portal, 0xffffffff);
+	qbman_swp_interrupt_set_trigger(dpio_dev->sw_portal, QBMAN_SWP_INTERRUPT_DQRI);
+	qbman_swp_interrupt_clear_status(dpio_dev->sw_portal, QBMAN_SWP_INTERRUPT_ALL);
 	qbman_swp_interrupt_set_inhibit(dpio_dev->sw_portal, 0);
 	qbman_swp_dqrr_thrshld_write(dpio_dev->sw_portal, threshold);
 	qbman_swp_intr_timeout_write(dpio_dev->sw_portal, timeout);
@@ -214,7 +213,7 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 		if (dpio_epoll_fd < 0) {
 			DPAA2_BUS_ERR("epoll_create failed");
 			rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
-			return -1;
+			return -errno;
 		}
 
 		eventfd = rte_intr_fd_get(dpio_dev->intr_handle);
@@ -256,7 +255,7 @@ void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 }
 
 static int
-dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx)
+dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 {
 	int sdest, ret;
 
@@ -276,29 +275,6 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx
 		return ret;
 	}
 
-#ifdef RTE_EVENT_DPAA2
-	/* Only the event PMD's portal is set up here (coalesced DQRI, private
-	 * epoll). The net rx-interrupt portal (ethrx) is configured by the net
-	 * PMD in rx_queue_intr_enable, so do not touch it here.
-	 */
-	if (!ethrx) {
-		int threshold = 3, timeout = 0xFF;
-
-		if (getenv("DPAA2_PORTAL_INTR_THRESHOLD"))
-			threshold = atoi(getenv("DPAA2_PORTAL_INTR_THRESHOLD"));
-		if (getenv("DPAA2_PORTAL_INTR_TIMEOUT"))
-			sscanf(getenv("DPAA2_PORTAL_INTR_TIMEOUT"), "%x", &timeout);
-
-		if (dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, true)) {
-			DPAA2_BUS_ERR("Interrupt registration failed for dpio");
-			return -1;
-		}
-		dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_id);
-	}
-#else
-	RTE_SET_USED(ethrx);
-#endif
-
 	return 0;
 }
 
@@ -316,25 +292,18 @@ static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 		dpaa2_dpio_intr_deinit(dpio_dev);
 		dpio_dev->cpu_affine = -1;
 		rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
-					  rte_memory_order_release);
+			rte_memory_order_release);
 	}
 }
 
 static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 {
-	struct dpaa2_dpio_dev *dpio_dev = NULL;
-	int cpu_id;
-	int ret;
-
-	/* Get DPIO dev handle from list using index */
-	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
-		uint16_t expected = 0;
+	struct dpaa2_dpio_dev *dpio_dev;
+	/* Set the Stashing Destination */
+	int cpu_id = dpaa2_get_core_id(), ret;
 
-		if (rte_atomic_compare_exchange_strong_explicit(&dpio_dev->ref_count,
-				&expected, 1, rte_memory_order_acquire,
-				rte_memory_order_relaxed))
-			break;
-	}
+	dpio_dev = rte_dpaa2_alloc_dpio_device((ethrx && cpu_id >= 0) ?
+		true : false, DPAA2_PORTAL_INTR_COALESC_DISABLE, cpu_id);
 	if (!dpio_dev) {
 		DPAA2_BUS_ERR("No software portal resource left");
 		return NULL;
@@ -343,18 +312,16 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 	DPAA2_BUS_DEBUG("New Portal %p (%d) affined thread - %u",
 			dpio_dev, dpio_dev->index, rte_gettid());
 
-	/* Set the Stashing Destination */
-	cpu_id = dpaa2_get_core_id();
 	if (cpu_id < 0) {
 		DPAA2_BUS_WARN("Thread not affined to a single core");
 		if (dpaa2_svr_family != SVR_LX2160A)
 			qbman_swp_update(dpio_dev->sw_portal, 1);
 	} else {
-		ret = dpaa2_configure_stashing(dpio_dev, cpu_id, ethrx);
+		ret = dpaa2_configure_stashing(dpio_dev, cpu_id);
 		if (ret) {
 			DPAA2_BUS_ERR("dpaa2_configure_stashing failed");
 			rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
-						  rte_memory_order_release);
+				rte_memory_order_release);
 			return NULL;
 		}
 	}
@@ -426,9 +393,13 @@ static void dpaa2_portal_finish(void *arg)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpio_device)
 struct dpaa2_dpio_dev *
-rte_dpaa2_alloc_dpio_device(int32_t cpu_affine)
+rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
+#ifdef RTE_EVENT_DPAA2
+	int ret, timeout = 0xff;
+	char *env;
+#endif
 	uint16_t expected = 0;
 
 	/* Get DPIO dev handle from list using index */
@@ -442,18 +413,35 @@ rte_dpaa2_alloc_dpio_device(int32_t cpu_affine)
 		DPAA2_BUS_ERR("No software portal resource left");
 		return NULL;
 	}
-
-	DPAA2_BUS_DEBUG("New Portal %p (%d) affined thread - %u",
-		dpio_dev, dpio_dev->index, rte_gettid());
-
-#ifdef RTE_EVENT_DPAA2
-	if (dpaa2_dpio_intr_init(dpio_dev, 1, 0, false)) {
-		DPAA2_BUS_ERR("Interrupt registration failed for dpio");
+ #ifdef RTE_EVENT_DPAA2
+	if (!isr)
+		goto quit;
+	env = getenv("DPAA2_PORTAL_INTR_THRESHOLD");
+	if (env)
+		threshold = atoi(env);
+	if (threshold > DPAA2_PORTAL_INTR_THRESH_MAX) {
+		DPAA2_BUS_ERR("Invalid threshold(%d) from %s",
+			threshold, env ? "environment" : "parameter");
+			threshold = DPAA2_PORTAL_INTR_COALESC_DISABLE;
+	}
+	env = getenv("DPAA2_PORTAL_INTR_TIMEOUT");
+	if (env)
+		sscanf(env, "%x", &timeout);
+	ret = dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, true);
+	if (ret) {
+		DPAA2_BUS_ERR("Failed(%d) to init DPIO interrupt", ret);
 		rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
 			rte_memory_order_release);
 		return NULL;
 	}
+	if (cpu_affine >= 0)
+		dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_affine);
+quit:
+#else
+	RTE_SET_USED(isr);
+	RTE_SET_USED(threshold);
 #endif
+
 	dpio_dev->cpu_affine = cpu_affine;
 
 	return dpio_dev;
@@ -473,7 +461,8 @@ rte_dpaa2_available_dpio_device(void)
 	uint16_t available_num = 0;
 
 	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
-		if (dpio_dev && !rte_atomic16_read(&dpio_dev->ref_count))
+		if (dpio_dev && !rte_atomic_load_explicit(&dpio_dev->ref_count,
+			rte_memory_order_acquire))
 			available_num++;
 	}
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index d28fdb03b7..0d0894572a 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -19,6 +19,9 @@ struct dpaa2_io_portal_t {
 	struct dpaa2_dpio_dev *ethrx_dpio_dev;
 };
 
+#define DPAA2_PORTAL_INTR_COALESC_DISABLE 0
+#define DPAA2_PORTAL_INTR_THRESH_MAX (qbman_swp_portal_dqrr_size(NULL) - 1)
+
 /*! Global per thread DPIO portal */
 RTE_DECLARE_PER_LCORE(struct dpaa2_io_portal_t, _dpaa2_io);
 
@@ -72,7 +75,7 @@ dpaa2_free_eq_descriptors(void);
 
 __rte_internal
 struct dpaa2_dpio_dev *
-rte_dpaa2_alloc_dpio_device(int32_t cpu_affine);
+rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine);
 
 __rte_internal
 void
diff --git a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
index fb1c6046ae..7855172074 100644
--- a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
@@ -92,6 +92,10 @@ const struct qbman_swp_desc *qbman_swp_get_desc(struct qbman_swp *p);
 /* Volatile dequeue command interrupt */
 #define QBMAN_SWP_INTERRUPT_VDCI ((uint32_t)0x00000020)
 
+#define QBMAN_SWP_INTERRUPT_ALL \
+	(QBMAN_SWP_INTERRUPT_EQRI | QBMAN_SWP_INTERRUPT_EQDI | \
+	QBMAN_SWP_INTERRUPT_DQRI | QBMAN_SWP_INTERRUPT_RCRI | \
+	QBMAN_SWP_INTERRUPT_RCDI | QBMAN_SWP_INTERRUPT_VDCI)
 /**
  * qbman_swp_interrupt_get_vanish() - Get the data in software portal
  * interrupt status disable register.
@@ -138,9 +142,9 @@ uint32_t qbman_swp_dqrr_thrshld_read_status(struct qbman_swp *p);
  * qbman_swp_dqrr_thrshld_write() - Set the data in software portal
  * DQRR interrupt threshold register.
  * @p: the given software portal object.
- * @mask: The value to set in SWP_DQRR_ITR register.
+ * @threshold: The value to set in SWP_DQRR_ITR register.
  */
-void qbman_swp_dqrr_thrshld_write(struct qbman_swp *p, uint32_t mask);
+void qbman_swp_dqrr_thrshld_write(struct qbman_swp *p, uint32_t threshold);
 
 /**
  * qbman_swp_intr_timeout_read_status() - Get the data in software portal
@@ -153,9 +157,9 @@ uint32_t qbman_swp_intr_timeout_read_status(struct qbman_swp *p);
  * qbman_swp_intr_timeout_write() - Set the data in software portal
  * Interrupt Time-Out period register.
  * @p: the given software portal object.
- * @mask: The value to set in SWP_ITPR register.
+ * @qbman_tick: The value to set in SWP_ITPR register.
  */
-void qbman_swp_intr_timeout_write(struct qbman_swp *p, uint32_t mask);
+void qbman_swp_intr_timeout_write(struct qbman_swp *p, uint32_t qbman_tick);
 
 /**
  * qbman_swp_interrupt_get_trigger() - Get the data in software portal
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 307c0e3d24..6a027b4aec 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -447,9 +447,14 @@ uint32_t qbman_swp_dqrr_thrshld_read_status(struct qbman_swp *p)
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_DQRR_ITR);
 }
 
-void qbman_swp_dqrr_thrshld_write(struct qbman_swp *p, uint32_t mask)
+void qbman_swp_dqrr_thrshld_write(struct qbman_swp *p, uint32_t threshold)
 {
-	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_DQRR_ITR, mask);
+	if (threshold >= p->dqrr.dqrr_size) {
+		pr_warn("Invalid threshold(%d) >= DRQQ size(%d)",
+			threshold, p->dqrr.dqrr_size);
+		threshold = p->dqrr.dqrr_size - 1;
+	}
+	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_DQRR_ITR, threshold);
 }
 
 uint32_t qbman_swp_intr_timeout_read_status(struct qbman_swp *p)
@@ -457,9 +462,14 @@ uint32_t qbman_swp_intr_timeout_read_status(struct qbman_swp *p)
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_ITPR);
 }
 
-void qbman_swp_intr_timeout_write(struct qbman_swp *p, uint32_t mask)
+void qbman_swp_intr_timeout_write(struct qbman_swp *p, uint32_t qbman_tick)
 {
-	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_ITPR, mask);
+	if (qbman_tick > QBMAN_CINH_SWP_ITPR_MAX) {
+		pr_warn("Invalid tick(%d) > MAX ISR time-out period(%d)",
+			qbman_tick, QBMAN_CINH_SWP_ITPR_MAX);
+		qbman_tick = QBMAN_CINH_SWP_ITPR_MAX;
+	}
+	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_ITPR, qbman_tick);
 }
 
 uint32_t qbman_swp_interrupt_get_trigger(struct qbman_swp *p)
@@ -480,8 +490,8 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
 RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_set_inhibit)
 void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
 {
-	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_IIR,
-			 inhibit ? 0xffffffff : 0);
+	/** RM 4.3.2.1.32.4, LSB bit interrupt inhibited*/
+	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_IIR, inhibit ? 1 : 0);
 }
 
 /***********************/
diff --git a/drivers/bus/fslmc/qbman/qbman_sys.h b/drivers/bus/fslmc/qbman/qbman_sys.h
index 61f817c477..8a8018943a 100644
--- a/drivers/bus/fslmc/qbman/qbman_sys.h
+++ b/drivers/bus/fslmc/qbman/qbman_sys.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Copyright 2019-2020 NXP
+ * Copyright 2019-2020, 2026 NXP
  */
 /* qbman_sys_decl.h and qbman_sys.h are the two platform-specific files in the
  * driver. They are only included via qbman_private.h, which is itself a
@@ -47,6 +47,8 @@
 #define QBMAN_CINH_SWP_IIR          0xec0
 #define QBMAN_CINH_SWP_ITPR         0xf40
 
+#define QBMAN_CINH_SWP_ITPR_MAX ((1 << 12) - 1)
+
 /* CENA register offsets */
 #define QBMAN_CENA_SWP_EQCR(n) (0x000 + ((uint32_t)(n) << 6))
 #define QBMAN_CENA_SWP_DQRR(n) (0x200 + ((uint32_t)(n) << 6))
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index be23dbf4dc..30a3119e62 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -849,7 +849,8 @@ dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		return -ENOMEM;
 	}
 
-	portal->dpio_dev = rte_dpaa2_alloc_dpio_device(-1);
+	portal->dpio_dev = rte_dpaa2_alloc_dpio_device(true,
+		DPAA2_PORTAL_INTR_COALESC_DISABLE, -1);
 	if (!portal->dpio_dev) {
 		rte_free(portal);
 		return -ENODEV;
-- 
2.43.0

