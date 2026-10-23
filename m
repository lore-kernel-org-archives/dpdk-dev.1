Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C2606A333
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E33640ECF;
	Fri, 23 Oct 2026 15:44:43 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C859840EE4
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:32 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA0991A0021;
 Fri, 23 Oct 2026 15:44:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AD581A000A;
 Fri, 23 Oct 2026 15:44:32 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 42DB118000B1;
 Fri, 23 Oct 2026 21:44:31 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 37/65] event/dpaa2: track and detach attached Rx queues
Date: Fri, 23 Oct 2026 19:13:17 +0530
Message-ID: <20261023134346.37727-38-prashant.gupta_3@nxp.com>
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

The DPAA2 eventdev previously attached ethdev/crypto Rx queues to an
event queue but never tracked or detached them, so device close and
ethdev stop left the queues wired to a DPCON and leaked event state.

Track each attached DPNI Rx queue in the owning event queue and add
the plumbing to tear it down cleanly:

- Record attached Rx queues:
  dpaa2_eventq now keeps an array of attached DPNI Rx queues
  (dpni_rxqs / dpni_rxq_num, capped at DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX)
  and dpaa2_queue gains an event_attached flag. The ethdev tracks the
  number of attached queues in evq_attach_num and warns on close if any
  remain.

- Detach by Rx queue:
  add dpaa2_eth_eventq_detach_by_rxq(), which detaches a queue given its
  dpaa2_queue directly (looking up the DPNI from the queue's eth_data),
  and refuses queues that were never attached. dpaa2_eth_eventq_detach()
  now validates the queue id and delegates to it. rx_queue_release skips
  queues still attached to the event device.

- Eventdev lifecycle:
  add a DPAA2_EVENTDEV_CREATED/STARTED/STOPPED status and implement
  eth_queue_del, eth_stop, and close so they drain traffic and detach all
  attached Rx queues. eth_stop drains ingress by cycling stop/start on a
  local copy of the device before detaching.

- Error propagation:
  crypto_queue_add_all now returns the last attach error instead of
  discarding it, and crypto_queue_add reports the queue-pair index.

- Scheduler teardown:
  rte_dpaa2_scheduler_destroy() now detaches the event queues it attached
  (tracked via attach_num) as part of destroy.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   1 +
 drivers/event/dpaa2/dpaa2_eventdev.c    | 308 ++++++++++++++++--------
 drivers/event/dpaa2/dpaa2_eventdev.h    |  11 +-
 drivers/event/dpaa2/dpaa2_scheduler.c   |  28 ++-
 drivers/net/dpaa2/dpaa2_ethdev.c        |  57 ++++-
 drivers/net/dpaa2/dpaa2_ethdev.h        |   4 +
 6 files changed, 293 insertions(+), 116 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index b00e52a9b7..a0b1d2abfa 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -192,6 +192,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint8_t options;
 	struct rte_event ev;
 	struct rte_mempool *env_pool;
+	uint8_t event_attached;
 	dpaa2_queue_cb_dqrr_t *cb;
 	dpaa2_queue_cb_eqresp_free_t *cb_eqresp_free;
 	struct dpaa2_bp_info *bp_array;
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 78a069b456..476decbbdc 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -41,6 +41,32 @@
 #include <portal/dpaa2_hw_pvt.h>
 #include <mc/fsl_dpci.h>
 
+static int
+dpaa2_eventdev_attach_eth_rxq(const struct rte_eth_dev *dev,
+	struct dpaa2_eventdev *priv, uint16_t rxq_id,
+	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+{
+	int ret;
+	uint8_t ev_qid = queue_conf->ev.queue_id;
+	uint8_t idx = priv->evq_info[ev_qid].dpni_rxq_num;
+	struct dpaa2_dpcon_dev *dpcon = priv->evq_info[ev_qid].dpcon;
+
+	if (idx >= DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX) {
+		DPAA2_EVENTDEV_ERR("Too many queues to attach.");
+		return -ENOMEM;
+	}
+	ret = dpaa2_eth_eventq_attach(dev, rxq_id, dpcon, queue_conf);
+	if (ret) {
+		DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
+
+		return ret;
+	}
+	priv->evq_info[ev_qid].dpni_rxqs[idx] = dev->data->rx_queues[rxq_id];
+	priv->evq_info[ev_qid].dpni_rxq_num++;
+
+	return 0;
+}
+
 /* Clarifications
  * Evendev = SoC Instance
  * Eventport = DPIO Instance
@@ -309,6 +335,45 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 	return num_pkts;
 }
 
+static void
+dpaa2_eventdev_dequeue_drain(const struct rte_eventdev *dev)
+{
+	uint16_t num, i, max;
+	struct rte_event ev;
+	struct dpaa2_port *dpaa2_portal;
+
+	for (i = 0; i < dev->data->nb_ports; i++) {
+		dpaa2_portal = dev->data->ports[i];
+		if (!dpaa2_portal || !dpaa2_portal->num_linked_evq)
+			continue;
+		/* Workers must be quiesced before this function is called.
+		 * Concurrent portal access from a worker lcore during drain is undefined.
+		 * Mark the port as draining so the dequeue path skips the
+		 * cross-lcore warning. Do not touch cpu_affine here: it is
+		 * read on the data path and mutating it would be a data race.
+		 */
+		rte_atomic_store_explicit(&dpaa2_portal->flushing, 1,
+			rte_memory_order_relaxed);
+		max = 0;
+dq_again:
+		rte_delay_us(100);
+		num = dpaa2_eventdev_dequeue_burst(dpaa2_portal, &ev, 1, 1);
+		max++;
+		if (num && dev->dev_ops->dev_stop_flush) {
+			dev->dev_ops->dev_stop_flush(dev->data->dev_id,
+				ev, dev->data->dev_stop_flush_arg);
+		}
+		if (!num || max > 10000) {
+			rte_atomic_store_explicit(&dpaa2_portal->flushing, 0,
+				rte_memory_order_relaxed);
+			if (max > 10000 && num)
+				DPAA2_EVENTDEV_WARN("Quit with pending buffers");
+			continue;
+		}
+		goto dq_again;
+	}
+}
+
 static void
 dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 	struct rte_event_dev_info *dev_info)
@@ -392,9 +457,11 @@ dpaa2_eventdev_configure(const struct rte_eventdev *dev)
 static int
 dpaa2_eventdev_start(struct rte_eventdev *dev)
 {
+	struct dpaa2_eventdev *priv = dev->data->dev_private;
+
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
+	priv->status = DPAA2_EVENTDEV_STARTED;
 
 	return 0;
 }
@@ -402,52 +469,120 @@ dpaa2_eventdev_start(struct rte_eventdev *dev)
 static void
 dpaa2_eventdev_stop(struct rte_eventdev *dev)
 {
-	uint16_t num, i, max;
-	struct rte_event ev;
-	struct dpaa2_port *dpaa2_portal;
+	struct dpaa2_eventdev *priv = dev->data->dev_private;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	for (i = 0; i < dev->data->nb_ports; i++) {
-		dpaa2_portal = dev->data->ports[i];
-		if (!dpaa2_portal || !dpaa2_portal->num_linked_evq)
-			continue;
-		/* Workers must be quiesced before rte_event_dev_stop() is called.
-		 * Concurrent portal access from a worker lcore during drain is undefined.
-		 * Mark the port as draining so the dequeue path skips the
-		 * cross-lcore warning. Do not touch cpu_affine here: it is
-		 * read on the data path and mutating it would be a data race.
-		 */
-		rte_atomic_store_explicit(&dpaa2_portal->flushing, 1,
-			rte_memory_order_relaxed);
-		max = 0;
-dq_again:
-		rte_delay_us(100);
-		num = dpaa2_eventdev_dequeue_burst(dpaa2_portal, &ev, 1, 1);
-		max++;
-		if (num && dev->dev_ops->dev_stop_flush) {
-			dev->dev_ops->dev_stop_flush(dev->data->dev_id,
-				ev, dev->data->dev_stop_flush_arg);
+	dpaa2_eventdev_dequeue_drain(dev);
+
+	priv->status = DPAA2_EVENTDEV_STOPPED;
+}
+
+static void
+dpaa2_eventdev_port_release(void *port)
+{
+	struct dpaa2_port *portal = port;
+	uint8_t port_id;
+	struct rte_eventdev *eventdev;
+	int ret;
+
+	EVENTDEV_INIT_FUNC_TRACE();
+
+	if (!portal)
+		return;
+
+	port_id = portal->port_id;
+	eventdev = portal->eventdev;
+
+	/* TODO: Cleanup is required when ports are in linked state. */
+	if (portal->num_linked_evq && eventdev) {
+		ret = rte_event_port_unlink(eventdev->data->dev_id, port_id, NULL, 0);
+		if (ret < 0) {
+			DPAA2_EVENTDEV_ERR("Event port.%d unlink all failed(%d)",
+				portal->port_id, ret);
 		}
-		if (!num || max > 10000) {
-			rte_atomic_store_explicit(&dpaa2_portal->flushing, 0,
-				rte_memory_order_relaxed);
-			if (max > 10000 && num)
-				DPAA2_EVENTDEV_WARN("Quit with pending buffers");
+	}
+
+	if (portal->dpio_dev)
+		rte_dpaa2_free_dpio_device(portal->dpio_dev);
+
+	rte_free(portal);
+	if (eventdev)
+		eventdev->data->ports[port_id] = NULL;
+}
+
+static int
+dpaa2_eventdev_eth_queue_del(const struct rte_eventdev *dev,
+	const struct rte_eth_dev *eth_dev, int32_t rx_queue_id)
+{
+	struct dpaa2_eventdev *priv = dev->data->dev_private;
+	struct dpaa2_eventq *evq;
+	uint8_t i, j, k, found = false;
+	int ret;
+
+	EVENTDEV_INIT_FUNC_TRACE();
+
+	if (!eth_dev || rx_queue_id < 0) {
+		for (i = 0; i < priv->max_event_queues; i++) {
+			if (!priv->evq_info[i].valid)
+				continue;
+			evq = &priv->evq_info[i];
+			for (j = 0; j < evq->dpni_rxq_num; j++) {
+				ret = dpaa2_eth_eventq_detach_by_rxq(evq->dpni_rxqs[j]);
+				if (ret)
+					return ret;
+			}
+			evq->dpni_rxq_num = 0;
+		}
+
+		return 0;
+	}
+
+	for (i = 0; i < priv->max_event_queues; i++) {
+		if (!priv->evq_info[i].valid)
 			continue;
+		evq = &priv->evq_info[i];
+		for (j = 0; j < evq->dpni_rxq_num; j++) {
+			if (evq->dpni_rxqs[j] == eth_dev->data->rx_queues[rx_queue_id]) {
+				found = true;
+				for (k = j + 1; k < evq->dpni_rxq_num; k++)
+					evq->dpni_rxqs[k - 1] = evq->dpni_rxqs[k];
+				evq->dpni_rxq_num--;
+				goto start_detach;
+			}
 		}
-		goto dq_again;
 	}
+
+start_detach:
+	if (found)
+		return dpaa2_eth_eventq_detach(eth_dev, rx_queue_id);
+
+	return -ENODEV;
 }
 
 static int
 dpaa2_eventdev_close(struct rte_eventdev *dev)
 {
+	struct dpaa2_eventdev *priv = dev->data->dev_private;
+	int i, ret;
+
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
+	if (priv->status == DPAA2_EVENTDEV_CREATED)
+		return 0;
+	if (priv->status == DPAA2_EVENTDEV_STARTED)
+		dpaa2_eventdev_stop(dev);
 
-	return 0;
+	for (i = 0; i < dev->data->nb_ports; i++) {
+		if (dev->data->ports[i])
+			dpaa2_eventdev_port_release(dev->data->ports[i]);
+	}
+
+	ret = dpaa2_eventdev_eth_queue_del(dev, NULL, -1);
+	if (!ret)
+		priv->status = DPAA2_EVENTDEV_CREATED;
+
+	return ret;
 }
 
 static void
@@ -650,39 +785,6 @@ dpaa2_eventdev_port_link(struct rte_eventdev *dev, void *port,
 	return ret;
 }
 
-static void
-dpaa2_eventdev_port_release(void *port)
-{
-	struct dpaa2_port *portal = port;
-	uint8_t port_id;
-	struct rte_eventdev *eventdev;
-	int ret;
-
-	EVENTDEV_INIT_FUNC_TRACE();
-
-	if (!portal)
-		return;
-
-	port_id = portal->port_id;
-	eventdev = portal->eventdev;
-
-	/* TODO: Cleanup is required when ports are in linked state. */
-	if (portal->num_linked_evq && eventdev) {
-		ret = rte_event_port_unlink(eventdev->data->dev_id, port_id, NULL, 0);
-		if (ret < 0) {
-			DPAA2_EVENTDEV_ERR("Event port.%d unlink all failed(%d)",
-				portal->port_id, ret);
-		}
-	}
-
-	if (portal->dpio_dev)
-		rte_dpaa2_free_dpio_device(portal->dpio_dev);
-
-	rte_free(portal);
-	if (eventdev)
-		eventdev->data->ports[port_id] = NULL;
-}
-
 static int
 dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	const struct rte_event_port_conf *port_conf)
@@ -766,14 +868,12 @@ dpaa2_eventdev_eth_queue_add_all(const struct rte_eventdev *dev,
 		const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
-	uint8_t ev_qid = queue_conf->ev.queue_id;
-	struct dpaa2_dpcon_dev *dpcon = priv->evq_info[ev_qid].dpcon;
-	int i, ret;
+	int i, ret, ret1;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
-		ret = dpaa2_eth_eventq_attach(eth_dev, i, dpcon, queue_conf);
+		ret = dpaa2_eventdev_attach_eth_rxq(eth_dev, priv, i, queue_conf);
 		if (ret) {
 			DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
 			goto fail;
@@ -781,8 +881,11 @@ dpaa2_eventdev_eth_queue_add_all(const struct rte_eventdev *dev,
 	}
 	return 0;
 fail:
-	for (i = (i - 1); i >= 0 ; i--)
-		dpaa2_eth_eventq_detach(eth_dev, i);
+	for (i = (i - 1); i >= 0 ; i--) {
+		ret1 = dpaa2_eventdev_eth_queue_del(dev, eth_dev, i);
+		if (ret1)
+			DPAA2_EVENTDEV_ERR("Failed(%d) to del q.%d in rollback", ret1, i);
+	}
 
 	return ret;
 }
@@ -794,34 +897,13 @@ dpaa2_eventdev_eth_queue_add(const struct rte_eventdev *dev,
 		const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
-	uint8_t ev_qid = queue_conf->ev.queue_id;
-	struct dpaa2_dpcon_dev *dpcon = priv->evq_info[ev_qid].dpcon;
-	int ret;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	if (rx_queue_id < 0)
 		return dpaa2_eventdev_eth_queue_add_all(dev, eth_dev, queue_conf);
 
-	ret = dpaa2_eth_eventq_attach(eth_dev, rx_queue_id, dpcon, queue_conf);
-	if (ret)
-		DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
-
-	return ret;
-}
-
-static int
-dpaa2_eventdev_eth_queue_del(const struct rte_eventdev *dev,
-			     const struct rte_eth_dev *eth_dev,
-			     int32_t rx_queue_id)
-{
-	EVENTDEV_INIT_FUNC_TRACE();
-
-	RTE_SET_USED(dev);
-	RTE_SET_USED(eth_dev);
-	RTE_SET_USED(rx_queue_id);
-
-	return 0;
+	return dpaa2_eventdev_attach_eth_rxq(eth_dev, priv, rx_queue_id, queue_conf);
 }
 
 static int
@@ -838,12 +920,36 @@ dpaa2_eventdev_eth_start(const struct rte_eventdev *dev,
 
 static int
 dpaa2_eventdev_eth_stop(const struct rte_eventdev *dev,
-			const struct rte_eth_dev *eth_dev)
+	const struct rte_eth_dev *eth_dev)
 {
+	struct dpaa2_eventdev *priv = dev->data->dev_private;
+	int i, j, k, ret;
+	struct dpaa2_eventq *evq;
+
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
-	RTE_SET_USED(eth_dev);
+	/** Drain ingress traffic.*/
+	dpaa2_eventdev_dequeue_drain(dev);
+
+	for (i = 0; i < priv->max_event_queues; i++) {
+		evq = &priv->evq_info[i];
+		if (!evq->valid)
+			continue;
+search_again:
+		for (j = 0; j < evq->dpni_rxq_num; j++) {
+			if (evq->dpni_rxqs[j]->eth_data == eth_dev->data) {
+				ret = dpaa2_eth_eventq_detach_by_rxq(evq->dpni_rxqs[j]);
+				if (ret) {
+					DPAA2_EVENTDEV_ERR("detach rxq failed(%d)", ret);
+					return ret;
+				}
+				for (k = j + 1; k < evq->dpni_rxq_num; k++)
+					evq->dpni_rxqs[k - 1] = evq->dpni_rxqs[k];
+				evq->dpni_rxq_num--;
+				goto search_again;
+			}
+		}
+	}
 
 	return 0;
 }
@@ -875,7 +981,7 @@ dpaa2_eventdev_crypto_queue_add_all(const struct rte_eventdev *dev,
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
 	uint8_t ev_qid = ev->queue_id;
 	struct dpaa2_dpcon_dev *dpcon = priv->evq_info[ev_qid].dpcon;
-	int i, ret;
+	int i, ret, ret1;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
@@ -888,8 +994,11 @@ dpaa2_eventdev_crypto_queue_add_all(const struct rte_eventdev *dev,
 	}
 	return 0;
 fail:
-	for (i = (i - 1); i >= 0 ; i--)
-		dpaa2_sec_eventq_detach(cryptodev, i);
+	for (i = (i - 1); i >= 0 ; i--) {
+		ret1 = dpaa2_sec_eventq_detach(cryptodev, i);
+		if (ret1)
+			DPAA2_EVENTDEV_ERR("Failed(%d) to detach qp.%d in rollback", ret1, i);
+	}
 
 	return ret;
 }
@@ -1162,7 +1271,6 @@ dpaa2_eventdev_destroy(const char *name)
 
 		if (priv->evq_info[i].dpci)
 			rte_dpaa2_free_dpci_dev(priv->evq_info[i].dpci);
-
 	}
 	priv->max_event_queues = 0;
 
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index b6f23ec2e2..0a98088fe1 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -52,6 +52,7 @@ enum {
  */
 
 #define DPAA2_EVENTQ_LINK_CONF_MAX 4 /** Max schedule type + 1.*/
+#define DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX 128
 struct dpaa2_eventq {
 	int valid;
 	void *event_port;
@@ -63,6 +64,8 @@ struct dpaa2_eventq {
 	uint32_t event_queue_cfg;
 	uint32_t event_queue_id;
 	struct dpaa2_queue *dpci_txqs[DPAA2_EVENTQ_LINK_CONF_MAX];
+	uint8_t dpni_rxq_num;
+	struct dpaa2_queue *dpni_rxqs[DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX];
 };
 
 struct dpaa2_port {
@@ -83,13 +86,19 @@ struct dpaa2_port {
 	uint64_t timeout_us;
 };
 
+enum dpaa2_eventdev_status {
+	DPAA2_EVENTDEV_CREATED,
+	DPAA2_EVENTDEV_STARTED,
+	DPAA2_EVENTDEV_STOPPED
+};
+
 struct dpaa2_eventdev {
 	struct dpaa2_eventq evq_info[DPAA2_EVENT_MAX_QUEUES];
 	uint32_t dequeue_timeout_ns;
 	uint8_t max_event_queues;
 	uint8_t nb_event_queues;
 	uint8_t nb_event_ports;
-	uint8_t resvd_1;
+	uint8_t status;
 	uint32_t nb_event_queue_flows;
 	uint32_t nb_event_port_dequeue_depth;
 	uint32_t nb_event_port_enqueue_depth;
diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
index 26e3f50cf7..6a4ec04aae 100644
--- a/drivers/event/dpaa2/dpaa2_scheduler.c
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -524,8 +524,27 @@ int rte_dpaa2_scheduler_start(void *scheduler_handle)
 	return ret;
 }
 
+static void
+dpaa2_scheduler_eventq_detach(struct dpaa2_sch_dev *sch_dev,
+	uint16_t un_attach_num)
+{
+	uint16_t i;
+	int ret;
+
+	for (i = 0; i < un_attach_num; i++) {
+		ret = dpaa2_eth_eventq_detach(sch_dev->port_queue[i].eth_dev,
+			sch_dev->port_queue[i].rxq_id);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failed(%d) to detach %s's rxq%d",
+				ret, sch_dev->port_queue[i].eth_dev->data->name,
+				sch_dev->port_queue[i].rxq_id);
+		}
+	}
+}
+
 static int
-dpaa2_scheduler_rx_core_push_drain(struct dpaa2_sch_dev *sch_dev, uint16_t core)
+dpaa2_scheduler_rx_core_push_drain(struct dpaa2_sch_dev *sch_dev,
+	uint16_t core, uint16_t *attach_num)
 {
 	struct dpaa2_dpio_dev *dpio_dev;
 	struct dpaa2_dpcon_dev *dpcon_dev;
@@ -544,6 +563,8 @@ dpaa2_scheduler_rx_core_push_drain(struct dpaa2_sch_dev *sch_dev, uint16_t core)
 		DPAA2_EVENTDEV_WARN("Drain %d buffer(s) from core%d", drain_num, core);
 
 	qbman_swp_push_set(dpio_dev->sw_portal, dpcon_dev->channel_index, 0);
+	if (attach_num)
+		(*attach_num)++;
 	ret = dpio_remove_static_dequeue_channel(dpio_dev->dpio,
 		0, dpio_dev->token, dpcon_dev->dpcon_id);
 	if (ret)
@@ -579,17 +600,20 @@ int rte_dpaa2_scheduler_destroy(void *scheduler_handle)
 	struct dpaa2_dpcon_dev *dpcon_dev;
 	struct dpaa2_dpci_dev *dpci_dev;
 	int32_t ret = 0, _ret, i;
+	uint16_t attach_num = 0;
 
 	if (sch_dev->sch_mode == RTE_DPAA2_SCH_PUSH) {
 		/** Make sure all data threads quit.*/
 		for (i = 0; i < RTE_MAX_LCORE; i++) {
-			_ret = dpaa2_scheduler_rx_core_push_drain(sch_dev, i);
+			_ret = dpaa2_scheduler_rx_core_push_drain(sch_dev, i, &attach_num);
 			if (_ret)
 				ret = _ret;
 		}
 	} else {
 		dpaa2_scheduler_rx_pull_drain(sch_dev);
+		attach_num = sch_dev->port_queue_num;
 	}
+	dpaa2_scheduler_eventq_detach(sch_dev, attach_num);
 
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		dpcon_dev = sch_dev->dpcon_dev[i];
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 849ab7049f..c1a0ae7763 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1182,10 +1182,8 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 				rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio,
 						NULL, rte_memory_order_release);
 			}
-			dpaa2_clear_queue_active_dps(dpaa2_q,
-						RTE_MAX_LCORE);
-			dpaa2_queue_storage_free(dpaa2_q,
-				RTE_MAX_LCORE);
+			dpaa2_clear_queue_active_dps(dpaa2_q, RTE_MAX_LCORE);
+			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
 			if (dpaa2_q->cfg)
 				rte_free(dpaa2_q->cfg);
 			dpaa2_q->cfg = NULL;
@@ -1557,6 +1555,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	qopt |= DPNI_QUEUE_OPT_USER_CTX;
 	cfg->user_context = (size_t)(dpaa2_q);
+	cfg->destination.type = DPNI_DEST_NONE;
 
 	/* napi: schedule the FQ to its DPCON once, when the channel is first
 	 * grabbed; never re-bound (the MC refuses scheduled->parked at runtime)
@@ -1834,6 +1833,9 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (dpaa2_q->event_attached)
+		return;
+
 	total_nb_rx_desc -= dpaa2_q->nb_desc;
 
 	if (cfg) {
@@ -2363,6 +2365,11 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
+	if (priv->evq_attach_num) {
+		DPAA2_PMD_WARN("%s's %d rxq(s) are not detached from event device..",
+			dev->data->name, priv->evq_attach_num);
+	}
+
 	dpaa2_tm_deinit(dev);
 	dpaa2_flow_clean(dev, MAX_TCS, DPAA2_FLOW_ALL_TYPE);
 	/** No matter dcb flows are created or not, they are destroyed in flow clean.*/
@@ -3400,29 +3407,53 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	dpaa2_ethq->ev.op = RTE_EVENT_OP_NEW;
 	dpaa2_ethq->ev.queue_id = eth_rx_queue_id;
 
+	dpaa2_ethq->event_attached = true;
+	eth_priv->evq_attach_num++;
+
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_detach)
-int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
-		int eth_rx_queue_id)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_detach_by_rxq)
+int dpaa2_eth_eventq_detach_by_rxq(struct dpaa2_queue *dpaa2_ethq)
 {
-	struct dpaa2_dev_priv *eth_priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
-	struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
+	struct dpaa2_dev_priv *eth_priv = dpaa2_ethq->eth_data->dev_private;
+	struct fsl_mc_io *dpni = eth_priv->hw;
 	struct dpni_queue *cfg;
 	int ret;
 
+	if (!dpaa2_ethq->event_attached) {
+		DPAA2_PMD_ERR("%s-tc%d-flow%d is not attached to event device.",
+			dpaa2_ethq->eth_data->name, dpaa2_ethq->tc_index,
+			dpaa2_ethq->flow_id);
+
+		return -EINVAL;
+	}
 	cfg = dpaa2_ethq->cfg;
 	cfg->destination.type = DPNI_DEST_NONE;
 	dpaa2_ethq->options &= ~DPNI_QUEUE_OPT_DEST;
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, eth_priv->token, DPNI_QUEUE_RX,
 		dpaa2_ethq->tc_index, dpaa2_ethq->flow_id, dpaa2_ethq->options, cfg);
-	if (ret)
-		DPAA2_PMD_ERR("Error in dpni_set_queue: ret: %d", ret);
+	if (ret) {
+		DPAA2_PMD_ERR("%s: failed(%d) to set rxq", __func__, ret);
+		return ret;
+	}
 
-	return ret;
+	dpaa2_ethq->event_attached = false;
+	eth_priv->evq_attach_num--;
+
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_detach)
+int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev, int queue_id)
+{
+	struct dpaa2_dev_priv *eth_priv = dev->data->dev_private;
+
+	if (queue_id >= eth_priv->nb_rx_queues || queue_id < 0)
+		return -EINVAL;
+
+	return dpaa2_eth_eventq_detach_by_rxq(eth_priv->rx_vq[queue_id]);
 }
 
 static int
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index e4b896f17c..8c0be81c95 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -426,6 +426,7 @@ struct dpaa2_dev_priv {
 	uint8_t cgid_in_use[MAX_TCS];
 
 	rte_spinlock_t meter_lock;
+	uint16_t evq_attach_num;
 
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
@@ -945,6 +946,9 @@ __rte_internal
 int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id);
 
+__rte_internal
+int dpaa2_eth_eventq_detach_by_rxq(struct dpaa2_queue *dpaa2_ethq);
+
 uint16_t dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts);
 
 uint16_t dpaa2_dev_loopback_rx(void *queue, struct rte_mbuf **bufs,
-- 
2.43.0

