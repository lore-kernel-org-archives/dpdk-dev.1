Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C48606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B0F54279F;
	Fri, 23 Oct 2026 15:45:00 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B44EA40B8C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:48 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 95D20200038;
 Fri, 23 Oct 2026 15:44:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 38CD520002B;
 Fri, 23 Oct 2026 15:44:48 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 37A8218000B5;
 Fri, 23 Oct 2026 21:44:47 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 52/65] net/dpaa2: bind per-queue DPIO for rx-queue
 interrupts
Date: Fri, 23 Oct 2026 19:13:32 +0530
Message-ID: <20261023134346.37727-53-prashant.gupta_3@nxp.com>
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

The DPAA2 rx-queue interrupt path never delivered a wakeup to the
application. The per-queue wakeup eventfd was published into
dev->intr_handle lazily, from inside the arm path (rx_queue_intr_enable),
which only runs on the polling lcore just before it sleeps. The generic
rte_eth_dev_rx_intr_ctl_q() flow, however, reads dev->intr_handle and
registers the application epoll once at setup time, before any arm. It
therefore registered an unset/stale fd and never saw the portal DQRI wake
edge.

Fix the ordering by giving each napi rx queue its own dedicated DPIO
(dpaa2_q->napi_dpio), allocated in dpaa2_dev_rx_queue_setup(), and publish
that portal's eventfd into dev->intr_handle there - before the application
registers its epoll. The one-shot CDAN enable and the in-flight VDQ
quiesce stay in rx_queue_intr_enable()/disable(), which run on the polling
lcore where q_storage[rte_lcore_id()] is valid; these must not move.

Because the queue now owns a fixed DPIO instead of borrowing the per-lcore
ethrx portal, the rx burst paths (dpaa2_dev_prefetch_rx_common,
dpaa2_dev_rx_common) pull on dpaa2_q->napi_dpio and re-affine it to the
current lcore on migration. This removes the napi_sub_dpio atomic
subscribe/re-home dance and the shared-portal ethrx_intr_refcnt bookkeeping.

The DPIO interrupt affinity, stashing and cpufreq-governor setup are
consolidated into dpaa2_dpio_intr_thread_affinity()/_restore(), and
rte_dpaa2_alloc_dpio_device() gains a build_epoll argument so the rx-queue
intr path (application epoll) and the eventdev path (private epoll) can
share one allocator. Internal-only helpers (intr_affinity_set,
configure_stashing, cpufreq_governor, dpio_intr_init) are made static.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 156 ++++++++-------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |  23 +--
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h  |   3 +-
 drivers/event/dpaa2/dpaa2_eventdev.c     |  35 +---
 drivers/net/dpaa2/dpaa2_ethdev.c         | 234 +++++++++--------------
 drivers/net/dpaa2/dpaa2_rxtx.c           |  67 ++++---
 6 files changed, 234 insertions(+), 284 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 17af74aad8..a32406b1b3 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -112,13 +112,13 @@ dpaa2_get_core_id(void)
 	return cpu_id;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_affinity_set)
-int dpaa2_dpio_intr_affinity_set(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
+static int
+dpaa2_dpio_intr_affinity_set(struct dpaa2_dpio_dev *dpio_dev)
 {
 	char line[512], match[32], path[64];
 	FILE *fp;
 	long irq = -1;
-	int32_t dpio_id = dpio_dev->hw_id, ret = 0;
+	int32_t dpio_id = dpio_dev->hw_id, cpu_id = dpio_dev->cpu_affine, ret = 0;
 
 #define IRQ_ALL_F "/proc/interrupts"
 #define IRQ_SMP_AFFINITY_F "/proc/irq/%ld/smp_affinity_list"
@@ -200,22 +200,6 @@ int dpaa2_dpio_intr_affinity_set(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 	return ret;
 }
 
-/* Pin the dpio's MSI IRQ to the calling lcore's core (best-effort), so a
- * worker sleeping on this portal's eventfd is woken on its own core.
- */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_affine_intr_to_core)
-void
-dpaa2_dpio_affine_intr_to_core(struct dpaa2_dpio_dev *dpio_dev)
-{
-	int cpu_id = dpaa2_get_core_id(), ret;
-
-	if (cpu_id >= 0) {
-		ret = dpaa2_dpio_intr_affinity_set(dpio_dev, cpu_id);
-		if (ret)
-			DPAA2_BUS_ERR("Failed(%d) to affinity interrupt on core.%d", ret, cpu_id);
-	}
-}
-
 static int _dpaa2_dpio_cpufreq_governor(uint32_t cpu_id, bool restore)
 {
 	struct dpaa2_dpio_gov_save *gov;
@@ -283,8 +267,7 @@ static int _dpaa2_dpio_cpufreq_governor(uint32_t cpu_id, bool restore)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_cpufreq_governor)
-int dpaa2_dpio_cpufreq_governor(int cpu_id, bool restore)
+static int dpaa2_dpio_cpufreq_governor(int cpu_id, bool restore)
 {
 	bool governor_all = cpu_id < 0 ? true : false;
 	int ret = 0;
@@ -305,14 +288,72 @@ int dpaa2_dpio_cpufreq_governor(int cpu_id, bool restore)
 	return ret;
 }
 
+static int
+dpaa2_dpio_configure_stashing(struct dpaa2_dpio_dev *dpio_dev)
+{
+	int sdest, ret;
+
+	/* Set the STASH Destination depending on Current CPU ID.
+	 * Valid values of SDEST are 4,5,6,7. Where,
+	 */
+	sdest = fslmc_vfio_core_cluster_sdest(dpio_dev->cpu_affine);
+	DPAA2_BUS_DEBUG("Portal= %d  CPU= %u SDEST= %d",
+		dpio_dev->index, dpio_dev->cpu_affine, sdest);
+	if (sdest < 0)
+		return sdest;
+
+	ret = dpio_set_stashing_destination(dpio_dev->dpio, CMD_PRI_LOW,
+		dpio_dev->token, sdest);
+	if (ret) {
+		DPAA2_BUS_ERR("Failed(%d) to set stashing(%02x) of dpio.%d/cpu.%d",
+		 ret, sdest, dpio_dev->hw_id, dpio_dev->cpu_affine);
+	}
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_thread_affinity)
+void dpaa2_dpio_intr_thread_affinity(struct dpaa2_dpio_dev *dpio_dev)
+{
+	int ret;
+
+	ret = dpaa2_dpio_intr_affinity_set(dpio_dev);
+	if (ret) {
+		DPAA2_BUS_WARN("Failed(%d) to affinity dpio.%d's interrupt on core%d",
+			ret, dpio_dev->hw_id, dpio_dev->cpu_affine);
+	}
+	ret = dpaa2_dpio_configure_stashing(dpio_dev);
+	if (ret) {
+		DPAA2_BUS_WARN("Failed(%d) to configure dpio.%d's stashing on core%d",
+			ret, dpio_dev->hw_id, dpio_dev->cpu_affine);
+	};
+
+	ret = dpaa2_dpio_cpufreq_governor(dpio_dev->cpu_affine, false);
+	if (ret) {
+		DPAA2_BUS_WARN("Failed(%d) to set governor of core%d",
+			ret, dpio_dev->cpu_affine);
+	}
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_thread_restore)
+void dpaa2_dpio_intr_thread_restore(struct dpaa2_dpio_dev *dpio_dev)
+{
+	int ret, cpu_id = dpio_dev ? dpio_dev->cpu_affine : -1;
+
+	ret = dpaa2_dpio_cpufreq_governor(cpu_id, true);
+	if (ret) {
+		DPAA2_BUS_WARN("Failed(%d) to restore governor of core%d",
+			ret, cpu_id);
+	}
+}
+
 /* threshold: DQRR fill raising DQRI (< ring depth); timeout: holdoff in ITP units.
  * Per-mode values from the caller (eventdev vs rx-queue intr).
  * The DQRI config is portal-wide and this is idempotent: the first caller to
  * arm a portal wins, a later caller's values are ignored (a portal normally
  * serves a single mode).
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
-int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
+static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 	int timeout, bool build_epoll)
 {
 	int eventfd, dpio_epoll_fd, ret, index;
@@ -412,30 +453,6 @@ void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 	dpio_dev->intr_enabled = false;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_configure_stashing)
-int
-dpaa2_dpio_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
-{
-	int sdest, ret;
-
-	/* Set the STASH Destination depending on Current CPU ID.
-	 * Valid values of SDEST are 4,5,6,7. Where,
-	 */
-	sdest = fslmc_vfio_core_cluster_sdest(cpu_id);
-	DPAA2_BUS_DEBUG("Portal= %d  CPU= %u SDEST= %d", dpio_dev->index, cpu_id, sdest);
-	if (sdest < 0)
-		return sdest;
-
-	ret = dpio_set_stashing_destination(dpio_dev->dpio, CMD_PRI_LOW,
-		dpio_dev->token, sdest);
-	if (ret) {
-		DPAA2_BUS_ERR("Failed(%d) to set stashing(%02x) of dpio.%d/cpu.%d",
-		 ret, sdest, dpio_dev->hw_id, cpu_id);
-	}
-
-	return ret;
-}
-
 static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 {
 	if (dpio_dev) {
@@ -454,28 +471,29 @@ static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 	}
 }
 
-static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
+static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
 {
 	struct dpaa2_dpio_dev *dpio_dev;
 	/* Set the Stashing Destination */
 	int cpu_id = dpaa2_get_core_id(), ret;
 
-	dpio_dev = rte_dpaa2_alloc_dpio_device((ethrx && cpu_id >= 0) ?
-		true : false, DPAA2_PORTAL_INTR_COALESC_DISABLE, cpu_id);
+	dpio_dev = rte_dpaa2_alloc_dpio_device(false, DPAA2_PORTAL_INTR_COALESC_DISABLE,
+		cpu_id, false);
 	if (!dpio_dev) {
 		DPAA2_BUS_ERR("No software portal resource left");
 		return NULL;
 	}
 
 	DPAA2_BUS_DEBUG("New Portal %p (%d) affined thread - %u",
-			dpio_dev, dpio_dev->index, rte_gettid());
+		dpio_dev, dpio_dev->index, rte_gettid());
 
+	dpio_dev->cpu_affine = cpu_id;
 	if (cpu_id < 0) {
 		DPAA2_BUS_WARN("Thread not affined to a single core");
 		if (dpaa2_svr_family != SVR_LX2160A)
 			qbman_swp_update(dpio_dev->sw_portal, 1);
 	} else {
-		ret = dpaa2_dpio_configure_stashing(dpio_dev, cpu_id);
+		ret = dpaa2_dpio_configure_stashing(dpio_dev);
 		if (ret) {
 			DPAA2_BUS_ERR("Failed(%d) to configure stashing", ret);
 			rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
@@ -483,7 +501,6 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 			return NULL;
 		}
 	}
-	dpio_dev->cpu_affine = cpu_id;
 
 	ret = pthread_setspecific(dpaa2_portal_key, (void *)dpio_dev);
 	if (ret) {
@@ -504,10 +521,10 @@ dpaa2_affine_qbman_swp(void)
 
 	/* Populate the dpaa2_io_portal structure */
 	if (!RTE_PER_LCORE(_dpaa2_io).dpio_dev) {
-		dpio_dev = dpaa2_get_qbman_swp(false);
+		dpio_dev = dpaa2_get_qbman_swp();
 		if (!dpio_dev) {
 			DPAA2_BUS_ERR("Error in software portal allocation");
-			return -1;
+			return -ENODEV;
 		}
 		RTE_PER_LCORE(_dpaa2_io).dpio_dev = dpio_dev;
 
@@ -526,10 +543,10 @@ dpaa2_affine_qbman_ethrx_swp(void)
 
 	/* Populate the dpaa2_io_portal structure */
 	if (!RTE_PER_LCORE(_dpaa2_io).ethrx_dpio_dev) {
-		dpio_dev = dpaa2_get_qbman_swp(true);
+		dpio_dev = dpaa2_get_qbman_swp();
 		if (!dpio_dev) {
 			DPAA2_BUS_ERR("Error in software portal allocation");
-			return -1;
+			return -ENODEV;
 		}
 		RTE_PER_LCORE(_dpaa2_io).ethrx_dpio_dev = dpio_dev;
 
@@ -551,13 +568,12 @@ static void dpaa2_portal_finish(void *arg)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpio_device)
 struct dpaa2_dpio_dev *
-rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine)
+rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold,
+	int32_t cpu_affine, bool build_epoll)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
-#ifdef RTE_EVENT_DPAA2
 	int ret, timeout = 0xff;
 	char *env;
-#endif
 	uint16_t expected = 0;
 
 	/* Get DPIO dev handle from list using index */
@@ -571,7 +587,9 @@ rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine)
 		DPAA2_BUS_ERR("No software portal resource left");
 		return NULL;
 	}
- #ifdef RTE_EVENT_DPAA2
+
+	dpio_dev->cpu_affine = cpu_affine;
+
 	if (!isr)
 		goto quit;
 	env = getenv("DPAA2_PORTAL_INTR_THRESHOLD");
@@ -580,28 +598,24 @@ rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine)
 	if (threshold > DPAA2_PORTAL_INTR_THRESH_MAX) {
 		DPAA2_BUS_ERR("Invalid threshold(%d) from %s",
 			threshold, env ? "environment" : "parameter");
-			threshold = DPAA2_PORTAL_INTR_COALESC_DISABLE;
+		threshold = DPAA2_PORTAL_INTR_COALESC_DISABLE;
 	}
 	env = getenv("DPAA2_PORTAL_INTR_TIMEOUT");
 	if (env)
 		sscanf(env, "%x", &timeout);
-	ret = dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, true);
+	ret = dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, build_epoll);
 	if (ret) {
 		DPAA2_BUS_ERR("Failed(%d) to init DPIO interrupt", ret);
 		rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
 			rte_memory_order_release);
+		dpio_dev->cpu_affine = -1;
 		return NULL;
 	}
-	if (cpu_affine >= 0)
-		dpaa2_dpio_intr_affinity_set(dpio_dev, cpu_affine);
-quit:
-#else
-	RTE_SET_USED(isr);
-	RTE_SET_USED(threshold);
-#endif
 
-	dpio_dev->cpu_affine = cpu_affine;
+	if (dpio_dev->cpu_affine >= 0)
+		dpaa2_dpio_intr_affinity_set(dpio_dev);
 
+quit:
 	return dpio_dev;
 }
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 7c089408c5..c61f8ee0a2 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -38,14 +38,11 @@ RTE_DECLARE_PER_LCORE(struct dpaa2_io_portal_t, _dpaa2_io);
 #define DPAA2_PER_LCORE_DQRR_MBUF(i) \
 	RTE_PER_LCORE(_dpaa2_io).dpio_dev->dpaa2_held_bufs.mbuf[i]
 
-__rte_internal int
-dpaa2_dpio_intr_affinity_set(struct dpaa2_dpio_dev *dpio_dev, int cpu_id);
+__rte_internal void
+dpaa2_dpio_intr_thread_affinity(struct dpaa2_dpio_dev *dpio_dev);
 
-__rte_internal int
-dpaa2_dpio_cpufreq_governor(int cpu_id, bool restore);
-
-__rte_internal int
-dpaa2_dpio_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id);
+__rte_internal void
+dpaa2_dpio_intr_thread_restore(struct dpaa2_dpio_dev *dpio_dev);
 
 /* Affine a DPIO portal to current processing thread */
 __rte_internal
@@ -55,18 +52,9 @@ int dpaa2_affine_qbman_swp(void);
 __rte_internal
 int dpaa2_affine_qbman_ethrx_swp(void);
 
-/* set up / tear down a DPIO portal's DQRI interrupt (rx-queue interrupt mode) */
-__rte_internal
-int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
-			 int timeout, bool build_epoll);
-
 __rte_internal
 void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev);
 
-/* pin a DPIO's MSI IRQ to the calling lcore's core (rx-queue interrupt mode) */
-__rte_internal
-void dpaa2_dpio_affine_intr_to_core(struct dpaa2_dpio_dev *dpio_dev);
-
 /* allocate memory for FQ - dq storage */
 __rte_internal
 int
@@ -84,7 +72,8 @@ dpaa2_free_eq_descriptors(void);
 
 __rte_internal
 struct dpaa2_dpio_dev *
-rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine);
+rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold,
+	int32_t cpu_affine, bool build_epoll);
 
 __rte_internal
 void
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 3a92a1c0de..1731999257 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -139,7 +139,6 @@ struct dpaa2_dpio_dev {
 	int32_t hw_id; /**< An unique ID of this DPIO device instance */
 	uint8_t intr_enabled; /**< DQRI portal interrupt already set up */
 	int32_t cpu_affine;
-	uint16_t ethrx_intr_refcnt; /**< rx queues currently armed on this portal */
 	struct dpaa2_portal_dqrr dpaa2_held_bufs;
 };
 
@@ -213,7 +212,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	 * its ethrx portal, arms the DQRI, and drains by channel volatile pull.
 	 */
 	struct dpaa2_dpcon_dev *napi_dpcon;	/*!< notif channel, NULL = napi off */
-	RTE_ATOMIC(struct dpaa2_dpio_dev *) napi_sub_dpio;	/*!< subscribed portal or NULL */
+	struct dpaa2_dpio_dev *napi_dpio;
 	uint8_t napi_armed;			/*!< this queue requests DQRI wakeups */
 };
 
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index ad80fd51f5..01c71fc0d2 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -88,7 +88,7 @@ static __rte_always_inline struct dpaa2_dpio_dev *
 dpaa2_event_portal_io_prepare(struct dpaa2_port *dpaa2_portal)
 {
 	struct dpaa2_dpio_dev *dpio_dev;
-	int ret, cpu = rte_lcore_id();
+	int cpu = rte_lcore_id();
 
 	if (unlikely(!dpaa2_portal->dpio_dev)) {
 		DPAA2_EVENTDEV_ERR("Event port%d not setup", dpaa2_portal->port_id);
@@ -111,19 +111,7 @@ dpaa2_event_portal_io_prepare(struct dpaa2_port *dpaa2_portal)
 		DPAA2_EVENTDEV_DEBUG("Event port%d affine CPU from %d->%d",
 			dpaa2_portal->port_id, dpio_dev->cpu_affine, cpu);
 		dpio_dev->cpu_affine = cpu;
-		ret = dpaa2_dpio_intr_affinity_set(dpio_dev, cpu);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR("Failed(%d) to affinity dpio.%d's interrupt on core%d",
-				ret, dpio_dev->hw_id, cpu);
-		}
-		ret = dpaa2_dpio_cpufreq_governor(cpu, false);
-		if (ret)
-			DPAA2_EVENTDEV_WARN("Failed(%d) to set governor of core%d", ret, cpu);
-		ret = dpaa2_dpio_configure_stashing(dpio_dev, cpu);
-		if (ret) {
-			DPAA2_EVENTDEV_WARN("Failed(%d) to configure dpio.%d's stashing on core%d",
-				ret, dpio_dev->hw_id, cpu);
-		}
+		dpaa2_dpio_intr_thread_affinity(dpio_dev);
 	}
 
 	return dpio_dev;
@@ -527,8 +515,14 @@ dpaa2_eventdev_port_release(void *port)
 		}
 	}
 
-	if (portal->dpio_dev)
+	if (portal->dpio_dev) {
+		/*
+		 * Restore CPU-frequency governor that the optional first-touch
+		 * binding on this DPIO may have forced.
+		 */
+		dpaa2_dpio_intr_thread_restore(portal->dpio_dev);
 		rte_dpaa2_free_dpio_device(portal->dpio_dev);
+	}
 
 	rte_free(portal);
 	if (eventdev)
@@ -602,15 +596,6 @@ dpaa2_eventdev_close(struct rte_eventdev *dev)
 			dpaa2_eventdev_port_release(dev->data->ports[i]);
 	}
 
-	/*
-	 * Restore any CPU-frequency governor that the optional first-touch
-	 * binding may have forced (see dpaa2_dpio_cpufreq_governor(cpu, false)).
-	 * Best-effort and a no-op when the governor was never touched.
-	 */
-	ret = dpaa2_dpio_cpufreq_governor(-1, true);
-	if (ret)
-		DPAA2_EVENTDEV_ERR("Failed(%d) to restore all cpus' governors", ret);
-
 	ret = dpaa2_eventdev_eth_queue_del(dev, NULL, -1);
 	if (!ret)
 		priv->status = DPAA2_EVENTDEV_CREATED;
@@ -880,7 +865,7 @@ dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	}
 
 	portal->dpio_dev = rte_dpaa2_alloc_dpio_device(true,
-		DPAA2_PORTAL_INTR_COALESC_DISABLE, -1);
+		DPAA2_PORTAL_INTR_COALESC_DISABLE, -1, true);
 	if (!portal->dpio_dev) {
 		rte_free(portal);
 		return -ENODEV;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c91dfb7893..d8a183453b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1173,12 +1173,16 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
-			if (dpaa2_q->napi_dpcon) {	/* release the rx-intr channel */
-				dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+			/* release the rx-intr channel */
+			dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+			if (dpaa2_q->napi_dpcon) {
 				rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
 				dpaa2_q->napi_dpcon = NULL;
-				rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio,
-						NULL, rte_memory_order_release);
+			}
+			if (dpaa2_q->napi_dpio) {
+				dpaa2_dpio_intr_thread_restore(dpaa2_q->napi_dpio);
+				rte_dpaa2_free_dpio_device(dpaa2_q->napi_dpio);
+				dpaa2_q->napi_dpio = NULL;
 			}
 			dpaa2_clear_queue_active_dps(dpaa2_q, RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
@@ -1486,11 +1490,10 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	 */
 	if (dev->data->dev_conf.intr_conf.rxq && dev->intr_handle == NULL) {
 		dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-		if (!dev->intr_handle ||
-		    rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
-				priv->nb_rx_queues) ||
-		    rte_intr_nb_efd_set(dev->intr_handle, priv->nb_rx_queues) ||
-		    rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_EXT)) {
+		if (!dev->intr_handle || rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
+			priv->nb_rx_queues) || rte_intr_nb_efd_set(dev->intr_handle,
+			priv->nb_rx_queues) || rte_intr_type_set(dev->intr_handle,
+			RTE_INTR_HANDLE_EXT)) {
 			DPAA2_PMD_ERR("Failed to set up rx-queue interrupts");
 			/* capture the error before cleanup may clobber rte_errno */
 			ret = rte_errno ? -rte_errno : -EIO;
@@ -1579,17 +1582,11 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
 	dpaa2_q->offloads = rx_conf->offloads;
 
-	/* NAPI: grab a DPCON channel so dev_start can bind this FQ statically.
-	 * The DQRR burst replaces the poll path for every queue at once, so a
-	 * missing channel is fatal rather than a silent per-queue fallback.
-	 */
-	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
-			rte_memory_order_release);
-	if (dev->data->dev_conf.intr_conf.rxq && !dpaa2_q->napi_dpcon) {
-		dpaa2_q->napi_dpcon = rte_dpaa2_alloc_dpcon_dev();
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		if (!dpaa2_q->napi_dpcon)
+			dpaa2_q->napi_dpcon = rte_dpaa2_alloc_dpcon_dev();
 		if (!dpaa2_q->napi_dpcon) {
-			DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue interrupts",
-				rx_queue_id);
+			DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue interrupts", rx_queue_id);
 			ret = -ENODEV;
 			goto err_quit;
 		}
@@ -1600,6 +1597,27 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			DPAA2_PMD_ERR("rxq %d: dpcon_enable: %d", rx_queue_id, ret);
 			goto err_quit;
 		}
+		if (!dpaa2_q->napi_dpio) {
+			dpaa2_q->napi_dpio = rte_dpaa2_alloc_dpio_device(true,
+				DPAA2_PORTAL_INTR_COALESC_DISABLE, -1, false);
+		}
+		if (!dpaa2_q->napi_dpio) {
+			ret = -ENODEV;
+			DPAA2_PMD_ERR("rxq %d: no DPIO for rx-queue interrupts",
+				rx_queue_id);
+			goto err_quit;
+		}
+		/** Register the interrupt here; the hardware will be enabled in
+		 * dpaa2_dev_rx_queue_intr_enable().
+		 */
+		ret = rte_intr_vec_list_index_set(dev->intr_handle, rx_queue_id,
+				rx_queue_id + RTE_INTR_VEC_RXTX_OFFSET);
+		if (ret)
+			goto err_quit;
+		ret = rte_intr_efds_index_set(dev->intr_handle, rx_queue_id,
+				rte_intr_fd_get(dpaa2_q->napi_dpio->intr_handle));
+		if (ret)
+			goto err_quit;
 	}
 
 	/*Get the flow id from given VQ id*/
@@ -1635,17 +1653,14 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		cfg->flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg->flc.value);
 		if (priv->flags & DPAA2_RX_DATA_STASHING_OFF_FLAG) {
-			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
-				&cfg->flc.value);
+			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0, &cfg->flc.value);
 			dpaa2_q->data_stashing_off = 1;
 		} else {
-			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 1,
-				&cfg->flc.value);
+			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 1, &cfg->flc.value);
 			dpaa2_q->data_stashing_off = 0;
 		}
 		if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A) {
-			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING, 1,
-				&cfg->flc.value);
+			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING, 1, &cfg->flc.value);
 		}
 	}
 
@@ -1704,13 +1719,17 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		rte_free(dpaa2_q->cfg);
 		dpaa2_q->cfg = NULL;
 	}
-	/* free only the DPCON this call allocated; a pre-existing one belongs to
-	 * an earlier setup and is released at dev_close
+	/* free only the DPCON/DPIO this call allocated; a pre-existing one
+	 * belongs to an earlier setup and is released at dev_close.
 	 */
 	if (dpaa2_q->napi_dpcon) {
 		rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
 		dpaa2_q->napi_dpcon = NULL;
 	}
+	if (dpaa2_q->napi_dpio) {
+		rte_dpaa2_free_dpio_device(dpaa2_q->napi_dpio);
+		dpaa2_q->napi_dpio = NULL;
+	}
 	return ret;
 }
 
@@ -1865,14 +1884,10 @@ dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q)
 	/* the portal (CDAN, DQRI) can only be torn down on the polling lcore;
 	 * warn if the app skipped rte_eth_dev_rx_intr_disable() before stop/close
 	 */
-	if (dpaa2_q->napi_armed)
-		DPAA2_PMD_WARN("rxq flow %u freed while armed; call "
-			       "rte_eth_dev_rx_intr_disable() on the polling "
-			       "lcore before stop/close", dpaa2_q->flow_id);
-
-	/* CDAN and DQRI teardown is the worker's job via rte_eth_dev_rx_intr_disable() */
-	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
-			rte_memory_order_release);
+	if (dpaa2_q->napi_armed) {
+		DPAA2_PMD_WARN("rxq flow %u freed while armed; disable intr before stop",
+			dpaa2_q->flow_id);
+	}
 }
 
 static void
@@ -3651,53 +3666,31 @@ dpaa2_napi_set_cdan_dest(struct dpaa2_queue *dpaa2_q, struct dpaa2_dpio_dev *dpi
  */
 static int
 dpaa2_napi_subscribe(struct rte_eth_dev *dev, uint16_t queue_id,
-		     struct dpaa2_dpio_dev *dpio, struct dpaa2_dpio_dev *old)
+	struct dpaa2_dpio_dev *dpio)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
 	uint16_t chid = dpaa2_q->napi_dpcon->qbman_ch_id;
 	int ret;
 
-	if (old) {
-		/* re-home: CDAN already off old (-EBUSY ensures it was disabled
-		 * first); just drop the sub, never touch a foreign portal.
-		 */
-		rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
-				rte_memory_order_release);
-	}
 	/* push_set ORs the channel-0 bit (idempotent across queues sharing the
 	 * portal); CDAN context = the queue, so the wake path can demux it.
 	 */
 	qbman_swp_push_set(dpio->sw_portal, 0, 1);
 	/* context only; the arm path is the sole place that enables the CDAN */
-	ret = qbman_swp_CDAN_set_context(dpio->sw_portal, chid,
-			(uint64_t)(uintptr_t)dpaa2_q);
+	ret = qbman_swp_CDAN_set_context(dpio->sw_portal, chid, (uint64_t)dpaa2_q);
 	if (ret) {
 		DPAA2_PMD_ERR("napi: CDAN set_context rxq %d: %d", queue_id, ret);
 		return ret;
 	}
 	ret = dpaa2_napi_set_cdan_dest(dpaa2_q, dpio);
 	if (ret) {
-		DPAA2_PMD_ERR("napi: dpcon_set_notification rxq %d: %d",
-			      queue_id, ret);
+		DPAA2_PMD_ERR("napi: dpcon_set_notification rxq %d: %d", queue_id, ret);
 		return ret;		/* CDAN not enabled here -> nothing to unwind */
 	}
 	DPAA2_PMD_DEBUG("napi-cdan rxq=%u dpio=%u chid=%u",
 		queue_id, dpio->index, chid);
-	/* point the queue's eventfd at the portal DQRI fd for the generic epoll */
-	if (rte_intr_vec_list_index_set(dev->intr_handle, queue_id,
-			queue_id + RTE_INTR_VEC_RXTX_OFFSET) ||
-	    rte_intr_efds_index_set(dev->intr_handle, queue_id,
-			rte_intr_fd_get(dpio->intr_handle))) {
-		DPAA2_PMD_ERR("napi: efd wiring rxq %d", queue_id);
-		return -EIO;
-	}
-	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, dpio,
-			rte_memory_order_release);
-	/* pin this portal's MSI to the worker's core: a CDAN wake then lands on
-	 * the same core the worker sleeps on, instead of the default spread.
-	 */
-	dpaa2_dpio_affine_intr_to_core(dpio);
+
 	return 0;
 }
 
@@ -3706,74 +3699,42 @@ dpaa2_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
-	struct dpaa2_dpio_dev *dpio, *old;
 	int ret;
 
-	/* the generic API has no dev_started guard (unlike the burst dummy ops),
-	 * so it can reach us after a stop; do not arm a stopped port, let the
-	 * caller fall back to polling.
-	 */
-	if (!dev->data->dev_started)
-		return -EIO;
-	if (!dpaa2_q->napi_dpcon)
-		return -ENOTSUP;	/* no channel -> caller keeps polling */
-
-	if (dpaa2_affine_qbman_ethrx_swp())
-		return -EIO;
-	dpio = DPAA2_PER_LCORE_ETHRX_DPIO;
+	if (dpaa2_q->napi_armed)
+		return 0;
 
-	old = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_memory_order_acquire);
-	if (old && old != dpio && dpaa2_q->napi_armed) {
-		DPAA2_PMD_ERR("rxq %d still armed on another portal; disable it first",
-			      queue_id);
-		return -EBUSY;
-	}
+	if (!dpaa2_q->napi_dpcon || !dpaa2_q->napi_dpio)
+		return -ENOTSUP;
 
 	ret = dpaa2_napi_quiesce_vdq(dpaa2_q);
 	if (ret)
-		return ret;
+		goto err_quit;
 
-	/* holdoff 0: the DQRI fires immediately on the first entry, so the
-	 * threshold is moot (1 here). build_epoll=false: the generic rx-intr API
-	 * waits on the application epoll, not the portal's private one. Idempotent
-	 * per dpio.
-	 */
-	ret = dpaa2_dpio_intr_init(dpio, 1, 0, false);
+	ret = dpaa2_napi_subscribe(dev, queue_id, dpaa2_q->napi_dpio);
 	if (ret)
-		return ret;
-
-	if (old != dpio) {
-		ret = dpaa2_napi_subscribe(dev, queue_id, dpio, old);
-		if (ret)
-			return ret;
-	}
-
-	/* first arm on this portal: mask + drain stale CDANs, so the unmask on
-	 * the 0 -> 1 edge below is the sole DQRI open (independent of prior state)
-	 */
-	if (!dpaa2_q->napi_armed && dpio->ethrx_intr_refcnt == 0) {
-		qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
-		dpaa2_napi_drain_portal(dpio);
-	}
+		goto err_quit;
 
 	/* CDAN is one-shot and the sole arming point, re-armed every sleep.
 	 * Publish armed/refcnt only on a successful initial enable.
 	 */
-	ret = qbman_swp_CDAN_enable(dpio->sw_portal, dpaa2_q->napi_dpcon->qbman_ch_id);
+	ret = qbman_swp_CDAN_enable(dpaa2_q->napi_dpio->sw_portal,
+			dpaa2_q->napi_dpcon->qbman_ch_id);
 	if (ret) {
 		DPAA2_PMD_DEBUG("napi: CDAN arm rxq %d: %d", queue_id, ret);
 		/* initial arm: nothing published; re-arm: state kept. Don't sleep. */
-		return -EAGAIN;
+		ret = -EAGAIN;
+		goto err_quit;
 	}
 
-	if (!dpaa2_q->napi_armed) {
-		dpaa2_q->napi_armed = 1;
-		/* unmask the portal DQRI once, on the 0 -> 1 armed-queue edge */
-		if (dpio->ethrx_intr_refcnt++ == 0)
-			qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 0);
-	}
+	qbman_swp_interrupt_set_inhibit(dpaa2_q->napi_dpio->sw_portal, 0);
+
+	dpaa2_q->napi_armed = true;
 
 	return 0;
+err_quit:
+
+	return ret;
 }
 
 /* Disarm rx-queue interrupts for this queue. The portal DQRI is masked only
@@ -3785,38 +3746,33 @@ dpaa2_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
-	struct dpaa2_dpio_dev *dpio;
+	struct dpaa2_dpio_dev *dpio = dpaa2_q->napi_dpio;
 	uint64_t ev;
 	ssize_t nb;
 
-	dpio = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_memory_order_acquire);
-	if (dpio && dpaa2_q->napi_armed) {
-		dpaa2_q->napi_armed = 0;
-		/* Silence this queue's CDAN on the portal the worker owns. Runs on
-		 * the polling lcore, so this is the only safe place to drive the
-		 * single-owner software portal. It also returns the channel to the
-		 * pool clean (CDAN disabled) and lets a sibling queue keep its own
-		 * interrupt (per-queue, unlike the portal-wide DQRI mask below).
-		 */
-		qbman_swp_CDAN_disable(dpio->sw_portal,
-				dpaa2_q->napi_dpcon->qbman_ch_id);
-		if (dpio->ethrx_intr_refcnt > 0 &&
-		    --dpio->ethrx_intr_refcnt == 0) {
-			/* last queue on the shared portal: drain + clear so the next
-			 * arm sees a clean portal (once per wake), then mask.
-			 */
-			dpaa2_napi_drain_portal(dpio);
-			qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
-			/* drain the VFIO eventfd: it is EPOLLET and the EAL leaves
-			 * RTE_INTR_HANDLE_EXT undrained, so a stale count suppresses the
-			 * next wake edge. Same as dpaa/mlx4/mlx5 do on disarm.
-			 */
-			nb = read(rte_intr_fd_get(dpio->intr_handle), &ev, sizeof(ev));
-			if (nb != (ssize_t)sizeof(ev) && errno != EAGAIN)
-				DPAA2_PMD_DEBUG("napi: eventfd drain rxq %d (%zd)",
-						queue_id, nb);
-		}
-	}
+	if (!dpaa2_q->napi_armed || !dpio)
+		return 0;
+
+	/* Silence this queue's CDAN on the portal the worker owns. Runs on
+	 * the polling lcore, so this is the only safe place to drive the
+	 * single-owner software portal. It also returns the channel to the
+	 * pool clean (CDAN disabled) and lets a sibling queue keep its own
+	 * interrupt (per-queue, unlike the portal-wide DQRI mask below).
+	 */
+	qbman_swp_CDAN_disable(dpio->sw_portal, dpaa2_q->napi_dpcon->qbman_ch_id);
+	/* last queue on the shared portal: drain + clear so the next
+	 * arm sees a clean portal (once per wake), then mask.
+	 */
+	dpaa2_napi_drain_portal(dpio);
+	qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
+	/* drain the VFIO eventfd: it is EPOLLET and the EAL leaves
+	 * RTE_INTR_HANDLE_EXT undrained, so a stale count suppresses the
+	 * next wake edge. Same as dpaa/mlx4/mlx5 do on disarm.
+	 */
+	nb = read(rte_intr_fd_get(dpio->intr_handle), &ev, sizeof(ev));
+	if (nb != sizeof(ev) && errno != EAGAIN)
+		DPAA2_PMD_DEBUG("napi: eventfd drain rxq %d (%zd)", queue_id, nb);
+	dpaa2_q->napi_armed = false;
 
 	return 0;
 }
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 0df758148c..efaa862623 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -963,7 +963,7 @@ dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dpaa2_q,
 {
 	/* Function receive frames for a given device and VQ*/
 	struct qbman_result *dq_storage, *dq_storage1 = NULL;
-	int ret, num_rx = 0;
+	int ret, num_rx = 0, cpu = rte_lcore_id();
 	bool by_channel = dpaa2_q->napi_dpcon ? true : false;
 	uint32_t id, pull_size;
 	uint8_t pending, status;
@@ -971,26 +971,36 @@ dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dpaa2_q,
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
 	struct queue_storage_info_t *q_storage;
+	struct dpaa2_dpio_dev *dpio;
 
-	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
+	q_storage = dpaa2_q->q_storage[cpu];
 
-	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
-		ret = dpaa2_affine_qbman_ethrx_swp();
-		if (ret) {
-			DPAA2_PMD_ERR("Failure in affining portal");
-			return 0;
+	if (dpaa2_q->napi_dpio) {
+		dpio = dpaa2_q->napi_dpio;
+		if (unlikely(dpio->cpu_affine != cpu)) {
+			dpio->cpu_affine = cpu;
+			dpaa2_dpio_intr_thread_affinity(dpio);
 		}
+	} else {
+		if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+			ret = dpaa2_affine_qbman_ethrx_swp();
+			if (ret) {
+				DPAA2_PMD_ERR("Failure in affining portal");
+				return 0;
+			}
+		}
+		dpio = DPAA2_PER_LCORE_ETHRX_DPIO;
 	}
+	swp = dpio->sw_portal;
 
-	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
 	if (dpaa2_q->napi_dpcon)
 		id = dpaa2_q->napi_dpcon->qbman_ch_id;
 	else
 		id = dpaa2_q->fqid;
 	pull_size = (nb_pkts > dpaa2_dqrr_size) ? dpaa2_dqrr_size : nb_pkts;
 	if (unlikely(!q_storage->active_dqs)) {
-		dpaa2_dev_rx_active_dq_storage(q_storage, DPAA2_PER_LCORE_ETHRX_DPIO,
-			id, pull_size, by_channel, qbman_pull_type_active);
+		dpaa2_dev_rx_active_dq_storage(q_storage, dpio, id, pull_size,
+			by_channel, qbman_pull_type_active);
 	}
 
 	dq_storage = q_storage->active_dqs;
@@ -1044,11 +1054,10 @@ dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dpaa2_q,
 		num_rx++;
 	} while (pending);
 
-	if (check_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)) {
-		while (!qbman_check_command_complete(
-		       get_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)))
+	if (check_swp_active_dqs(dpio->index)) {
+		while (!qbman_check_command_complete(get_swp_active_dqs(dpio->index)))
 			;
-		clear_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index);
+		clear_swp_active_dqs(dpio->index);
 	}
 	/* issue a volatile dequeue command for next pull */
 	while (1) {
@@ -1059,8 +1068,8 @@ dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dpaa2_q,
 		break;
 	}
 	q_storage->active_dqs = dq_storage1;
-	q_storage->active_dpio_id = DPAA2_PER_LCORE_ETHRX_DPIO->index;
-	set_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index, dq_storage1);
+	q_storage->active_dpio_id = dpio->index;
+	set_swp_active_dqs(dpio->index, dq_storage1);
 
 	dpaa2_q->rx_pkts += num_rx;
 
@@ -1176,8 +1185,7 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs,
 	if (unlikely(!rte_dpaa2_bpid_info &&
 		rte_eal_process_type() == RTE_PROC_SECONDARY))
 		rte_dpaa2_bpid_info = dpaa2_q->bp_array;
-	if (unlikely((priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) &&
-		!dpaa2_q->napi_dpcon))
+	if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 		dpaa2_dev_prefetch_rx_err_pkts_dump(priv->rx_err_vq);
 
 	if (likely(!(priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN) &&
@@ -1265,32 +1273,31 @@ dpaa2_dev_rx_common(struct dpaa2_queue *dpaa2_q,
 	uint32_t next_pull = nb_pkts, id, pull_size;
 	uint16_t num_rx = 0, num_pulled;
 	bool by_channel = dpaa2_q->napi_dpcon ? true : false;
-	int ret;
+	int ret, cpu = rte_lcore_id();
 	uint8_t pending, status;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
+	struct dpaa2_dpio_dev *dpio;
 
-	if (by_channel) {
-		if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
-			ret = dpaa2_affine_qbman_ethrx_swp();
-			if (ret) {
-				DPAA2_PMD_ERR("Failure in affining portal");
-				return 0;
-			}
+	if (dpaa2_q->napi_dpio) {
+		dpio = dpaa2_q->napi_dpio;
+		if (unlikely(dpio->cpu_affine != cpu)) {
+			dpio->cpu_affine = cpu;
+			dpaa2_dpio_intr_thread_affinity(dpio);
 		}
-		swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
 	} else {
 		if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 			ret = dpaa2_affine_qbman_swp();
 			if (ret) {
-				DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d",
-					rte_gettid());
+				DPAA2_PMD_ERR("Failure in affining portal");
 				return 0;
 			}
 		}
-		swp = DPAA2_PER_LCORE_PORTAL;
+		dpio = DPAA2_PER_LCORE_DPIO;
 	}
+	swp = dpio->sw_portal;
+
 	if (dpaa2_q->napi_dpcon)
 		id = dpaa2_q->napi_dpcon->qbman_ch_id;
 	else
-- 
2.43.0

