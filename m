Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4E3606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1EE642708;
	Fri, 23 Oct 2026 15:44:55 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 30D28410DF
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:42 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13A8D200031;
 Fri, 23 Oct 2026 15:44:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3BF6200044;
 Fri, 23 Oct 2026 15:44:41 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D256618000BF;
 Fri, 23 Oct 2026 21:44:40 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 46/65] bus/fslmc: use EAL API for DPIO interrupt
Date: Fri, 23 Oct 2026 19:13:26 +0530
Message-ID: <20261023134346.37727-47-prashant.gupta_3@nxp.com>
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

The DPIO interrupt path created a private epoll instance with the raw
epoll_create/epoll_ctl/epoll_wait syscalls and cached its fd in
dpaa2_dpio_dev::epoll_fd. This duplicated the epoll bookkeeping already
provided by the EAL interrupt handle and split the interrupt state
across two owners.

Switch to the EAL rte_epoll wrappers. dpaa2_dpio_intr_init() now arms
the interrupt handle's epoll event via rte_epoll_ctl(),
dpaa2_dpio_intr_deinit() removes it, and the event PMD dequeue wait
uses rte_epoll_wait() on the handle's epoll fd. The now redundant
epoll_fd field is removed from struct dpaa2_dpio_dev.

While converting, tidy the init/deinit error handling to use goto
labels so the interrupt is disabled and the epoll fd closed on every
failure path.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 58 ++++++++++++++++--------
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h  |  1 -
 drivers/event/dpaa2/dpaa2_eventdev.c     |  7 ++-
 3 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 4affd4e0b4..e95345627d 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -184,7 +184,7 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 	int timeout, bool build_epoll)
 {
 	int eventfd, dpio_epoll_fd, ret;
-	struct epoll_event epoll_ev;
+	struct rte_epoll_event *epoll_ev;
 
 	if (dpio_dev->intr_enabled)
 		return 0;
@@ -201,8 +201,6 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 	qbman_swp_dqrr_thrshld_write(dpio_dev->sw_portal, threshold);
 	qbman_swp_intr_timeout_write(dpio_dev->sw_portal, timeout);
 
-	dpio_dev->epoll_fd = -1;
-
 	/* The event PMD dequeues by sleeping on a private epoll instance owned
 	 * by the portal, so build it here. The net rx-queue-interrupt path
 	 * exposes the raw eventfd through the generic ethdev API and waits on
@@ -212,45 +210,65 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 		dpio_epoll_fd = epoll_create1(EPOLL_CLOEXEC);
 		if (dpio_epoll_fd < 0) {
 			DPAA2_BUS_ERR("epoll_create failed");
-			rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
-			return -errno;
+			ret = -errno;
+			goto int_disable_err;
 		}
 
 		eventfd = rte_intr_fd_get(dpio_dev->intr_handle);
-		epoll_ev.events = EPOLLIN | EPOLLPRI | EPOLLET;
-		epoll_ev.data.fd = eventfd;
-
-		ret = epoll_ctl(dpio_epoll_fd, EPOLL_CTL_ADD, eventfd, &epoll_ev);
+		if (eventfd < 0) {
+			ret = eventfd;
+			goto epoll_close_err;
+		}
+		epoll_ev = rte_intr_elist_index_get(dpio_dev->intr_handle, 0);
+		if (rte_atomic_load_explicit(&epoll_ev->status,
+			rte_memory_order_relaxed) != RTE_EPOLL_INVALID) {
+			DPAA2_BUS_ERR("Event already been added.");
+			ret = -EEXIST;
+			goto epoll_close_err;
+		}
+		epoll_ev->epdata.event = EPOLLIN | EPOLLPRI | EPOLLET;
+		ret = rte_epoll_ctl(dpio_epoll_fd, EPOLL_CTL_ADD, eventfd, epoll_ev);
 		if (ret < 0) {
-			DPAA2_BUS_ERR("epoll_ctl failed");
-			rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
-			close(dpio_epoll_fd);
-			return -1;
+			DPAA2_BUS_ERR("Epoll control add failed(%d)", ret);
+			goto epoll_close_err;
 		}
-		dpio_dev->epoll_fd = dpio_epoll_fd;
 	}
 
 	dpio_dev->intr_enabled = 1;
 
 	return 0;
+
+epoll_close_err:
+	close(dpio_epoll_fd);
+int_disable_err:
+	rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
+	return ret;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_deinit)
 void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 {
-	int ret;
+	int ret, epfd;
+	struct rte_epoll_event *epoll_ev;
 
 	if (!dpio_dev->intr_enabled)
 		return;
 
+	epoll_ev = rte_intr_elist_index_get(dpio_dev->intr_handle, 0);
+	if (rte_atomic_load_explicit(&epoll_ev->status,
+		rte_memory_order_relaxed) != RTE_EPOLL_INVALID) {
+		epoll_ev->epdata.event = EPOLLIN | EPOLLPRI | EPOLLET;
+		epfd = epoll_ev->epfd;
+		ret = rte_epoll_ctl(epfd, EPOLL_CTL_DEL, epoll_ev->fd, epoll_ev);
+		if (ret < 0)
+			DPAA2_BUS_ERR("Epoll control delete failed(%d)", ret);
+		close(epfd);
+	}
+
 	ret = rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
 	if (ret)
-		DPAA2_BUS_ERR("DPIO interrupt disable failed");
+		DPAA2_BUS_ERR("DPIO interrupt disable failed(%d)", ret);
 
-	if (dpio_dev->epoll_fd >= 0) {
-		close(dpio_dev->epoll_fd);
-		dpio_dev->epoll_fd = -1;
-	}
 	dpio_dev->intr_enabled = 0;
 }
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index f67f2283db..52ec660fb9 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -133,7 +133,6 @@ struct dpaa2_dpio_dev {
 		/**< Physical address of Cache Inhibit Area */
 	uintptr_t ci_size; /**< Size of the CI region */
 	struct rte_intr_handle *intr_handle; /* Interrupt related info */
-	int32_t	epoll_fd; /**< File descriptor created for interrupt polling */
 	int32_t hw_id; /**< An unique ID of this DPIO device instance */
 	uint8_t intr_enabled; /**< DQRI portal interrupt already set up */
 	int32_t cpu_affine;
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 592b3bf4a4..f4dbf47b18 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -233,10 +233,13 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 static void dpaa2_eventdev_dequeue_wait(struct dpaa2_dpio_dev *dpio_dev,
 	uint32_t timeout_ms)
 {
-	struct epoll_event epoll_ev;
+	int ret;
+	struct rte_epoll_event *epoll_event;
 
 	qbman_swp_interrupt_clear_status(dpio_dev->sw_portal, QBMAN_SWP_INTERRUPT_DQRI);
-	epoll_wait(dpio_dev->epoll_fd, &epoll_ev, 1, timeout_ms);
+	epoll_event = rte_intr_elist_index_get(dpio_dev->intr_handle, 0);
+	ret = rte_epoll_wait(epoll_event->epfd, epoll_event, 1, timeout_ms);
+	DPAA2_PMD_DP_DEBUG("%s: poll return(%d)", __func__, ret);
 }
 
 static void dpaa2_eventdev_process_parallel(struct dpaa2_dpio_dev *dpio_dev,
-- 
2.43.0

