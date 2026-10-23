Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3F606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44E8342670;
	Fri, 23 Oct 2026 15:44:55 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 71267410D4
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56A1F200040;
 Fri, 23 Oct 2026 15:44:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 225F720002B;
 Fri, 23 Oct 2026 15:44:41 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C125018000B1;
 Fri, 23 Oct 2026 21:44:39 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 45/65] event/dpaa2: honor configured dequeue timeout
Date: Fri, 23 Oct 2026 19:13:25 +0530
Message-ID: <20261023134346.37727-46-prashant.gupta_3@nxp.com>
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

The dequeue timeout handling used a fixed 1ms-per-tick scale and a
hardcoded DPAA2_EVENT_PORT_DEQUEUE_TIMEOUT_NS default, and reported
that constant from info_get() regardless of the value the application
configured. It also passed raw timeout_ticks straight to epoll_wait(),
which expects a value in milliseconds.

Convert timeouts using the timer frequency. Cache rte_get_timer_hz()
in priv->event_hz at configure time, compute timeout_ticks in
timeout_ticks() from the requested ns, and convert ticks back to
milliseconds before calling epoll_wait(). info_get() now reports the
configured dequeue_timeout_ns, and configure() no longer overrides a
zero timeout with the removed default constant.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 36 ++++++++++++++++------------
 drivers/event/dpaa2/dpaa2_eventdev.h |  2 +-
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 30a3119e62..592b3bf4a4 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -231,12 +231,12 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 }
 
 static void dpaa2_eventdev_dequeue_wait(struct dpaa2_dpio_dev *dpio_dev,
-	uint64_t timeout_ticks)
+	uint32_t timeout_ms)
 {
 	struct epoll_event epoll_ev;
 
 	qbman_swp_interrupt_clear_status(dpio_dev->sw_portal, QBMAN_SWP_INTERRUPT_DQRI);
-	epoll_wait(dpio_dev->epoll_fd, &epoll_ev, 1, timeout_ticks);
+	epoll_wait(dpio_dev->epoll_fd, &epoll_ev, 1, timeout_ms);
 }
 
 static void dpaa2_eventdev_process_parallel(struct dpaa2_dpio_dev *dpio_dev,
@@ -274,10 +274,12 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 	const struct qbman_result *dq;
 	struct dpaa2_dpio_dev *dpio_dev;
 	struct dpaa2_port *dpaa2_portal = port;
+	struct dpaa2_eventdev *priv;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct dpaa2_queue *rxq;
 	uint16_t num_pkts = 0, i = 0;
+	uint32_t timeout_ms;
 
 	if (unlikely(dpaa2_portal->port_atomic))
 		rte_spinlock_lock(&dpaa2_portal->port_lock);
@@ -287,6 +289,7 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 		goto quit;
 
 	swp = dpio_dev->sw_portal;
+	priv = dpaa2_portal->eventdev->data->dev_private;
 
 	/* Check if there are atomic contexts to be released */
 
@@ -305,6 +308,10 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 		i++;
 	}
 	dpio_dev->dpaa2_held_bufs.dqrr_held = 0;
+	if (timeout_ticks)
+		timeout_ms = timeout_ticks * 1000 / priv->event_hz;
+	else
+		timeout_ms = priv->dequeue_timeout_ns / (1000 * 1000);
 
 	do {
 		dq = qbman_swp_dqrr_next(swp);
@@ -313,9 +320,9 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 			 * the DQRR consume vector before leaving it idle.
 			 */
 			qbman_swp_dqrr_consume(swp, NULL);
-			if (!num_pkts && timeout_ticks) {
-				dpaa2_eventdev_dequeue_wait(dpio_dev, timeout_ticks);
-				timeout_ticks = 0;
+			if (!num_pkts && timeout_ms) {
+				dpaa2_eventdev_dequeue_wait(dpio_dev, timeout_ms);
+				timeout_ms = 0;
 				continue;
 			}
 			goto quit;
@@ -390,8 +397,7 @@ dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 		DPAA2_EVENT_MIN_DEQUEUE_TIMEOUT;
 	dev_info->max_dequeue_timeout_ns =
 		DPAA2_EVENT_MAX_DEQUEUE_TIMEOUT;
-	dev_info->dequeue_timeout_ns =
-		DPAA2_EVENT_PORT_DEQUEUE_TIMEOUT_NS;
+	dev_info->dequeue_timeout_ns = priv->dequeue_timeout_ns;
 	dev_info->max_event_queues = priv->max_event_queues;
 	dev_info->max_event_queue_flows =
 		DPAA2_EVENT_MAX_QUEUE_FLOWS;
@@ -437,6 +443,7 @@ dpaa2_eventdev_configure(const struct rte_eventdev *dev)
 	priv->nb_event_port_dequeue_depth = conf->nb_event_port_dequeue_depth;
 	priv->nb_event_port_enqueue_depth = conf->nb_event_port_enqueue_depth;
 	priv->event_dev_cfg = conf->event_dev_cfg;
+	priv->event_hz = rte_get_timer_hz();
 
 	/* Check dequeue timeout method is per dequeue or global */
 	if (priv->event_dev_cfg & RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT) {
@@ -446,14 +453,11 @@ dpaa2_eventdev_configure(const struct rte_eventdev *dev)
 		 */
 		priv->dequeue_timeout_ns = 0;
 
-	} else if (conf->dequeue_timeout_ns == 0) {
-		priv->dequeue_timeout_ns = DPAA2_EVENT_PORT_DEQUEUE_TIMEOUT_NS;
 	} else {
 		priv->dequeue_timeout_ns = conf->dequeue_timeout_ns;
 	}
 
-	DPAA2_EVENTDEV_DEBUG("Configured eventdev devid=%d",
-			     dev->data->dev_id);
+	DPAA2_EVENTDEV_DEBUG("Configured eventdev devid=%d", dev->data->dev_id);
 	return 0;
 }
 
@@ -869,14 +873,16 @@ dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 
 static int
 dpaa2_eventdev_timeout_ticks(struct rte_eventdev *dev, uint64_t ns,
-			     uint64_t *timeout_ticks)
+	uint64_t *timeout_ticks)
 {
-	uint32_t scale = 1000 * 1000;
+	struct dpaa2_eventdev *priv = dev->data->dev_private;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
-	*timeout_ticks = ns / scale;
+	if (!priv->event_hz)
+		priv->event_hz = rte_get_timer_hz();
+
+	*timeout_ticks = ns * priv->event_hz / 1000000000ULL;
 
 	return 0;
 }
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index af1c831b92..30911382f3 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -22,7 +22,6 @@
 #define DPAA2_EVENT_MAX_QUEUES			16
 #define DPAA2_EVENT_MIN_DEQUEUE_TIMEOUT		1
 #define DPAA2_EVENT_MAX_DEQUEUE_TIMEOUT		(UINT32_MAX - 1)
-#define DPAA2_EVENT_PORT_DEQUEUE_TIMEOUT_NS	100UL
 #define DPAA2_EVENT_MAX_QUEUE_FLOWS		1024
 #define DPAA2_EVENT_MAX_QUEUE_PRIORITY_LEVELS	8
 #define DPAA2_EVENT_MAX_EVENT_PRIORITY_LEVELS	0
@@ -124,6 +123,7 @@ struct dpaa2_eventdev {
 	uint32_t nb_event_port_dequeue_depth;
 	uint32_t nb_event_port_enqueue_depth;
 	uint32_t event_dev_cfg;
+	uint64_t event_hz;
 };
 
 int test_eventdev_dpaa2(void);
-- 
2.43.0

