Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2008E606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 174E04275A;
	Fri, 23 Oct 2026 15:44:48 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 08B4B40E64
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:37 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E0B70200038;
 Fri, 23 Oct 2026 15:44:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84B1C200020;
 Fri, 23 Oct 2026 15:44:36 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 83B4F18000B5;
 Fri, 23 Oct 2026 21:44:35 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 41/65] event/dpaa2: allow event queue link to multiple
 ports
Date: Fri, 23 Oct 2026 19:13:21 +0530
Message-ID: <20261023134346.37727-42-prashant.gupta_3@nxp.com>
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

The event queue previously stored a single owning event port and each
DPCON kept a single channel_index, so a queue could be linked to only
one port and the static dequeue channel could be added to only one
DPIO at a time. This prevented linking the same event queue from
several ports.

Track the DPCON static dequeue channel per DPIO by replacing the
single channel_index with ch_idx[]/dpio_idx[] arrays and a ch_idx_num
count (bounded by DPAA2_DPCON_MAX_CH_IDX_NUM). On link, add a channel
for the linking DPIO and record its index; on unlink, look up the
channel by DPIO index and remove it, compacting the arrays.

Replace the exclusive evq_info->event_port ownership with a per-queue
link_num reference count and a per-port evq_map[] that resolves an
event queue id to its evq_info during enqueue. This drops the old
per-enqueue owner check in favour of a direct map lookup.

Add range checks on event queue id in queue setup and Rx queue attach,
verify the queue index matches its event_queue_id, reject linking a
queue configured as single link when already linked, and return
specific error codes. Lower a couple of noisy messages from ERR/WARN
to WARN/DEBUG. Update the scheduler DPCI receive and drain paths to
the new per-DPIO channel index tracking.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   6 +-
 drivers/event/dpaa2/dpaa2_eventdev.c    | 207 ++++++++++++++----------
 drivers/event/dpaa2/dpaa2_eventdev.h    |   3 +-
 drivers/event/dpaa2/dpaa2_scheduler.c   |  10 +-
 4 files changed, 140 insertions(+), 86 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index a0b1d2abfa..f67f2283db 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -283,6 +283,8 @@ struct dpaa2_dpci_dev {
 	struct dpaa2_queue *tx_queue;
 };
 
+#define DPAA2_DPCON_MAX_CH_IDX_NUM 16
+
 struct dpaa2_dpcon_dev {
 	TAILQ_ENTRY(dpaa2_dpcon_dev) next;
 	struct fsl_mc_io dpcon;
@@ -291,7 +293,9 @@ struct dpaa2_dpcon_dev {
 	uint32_t dpcon_id;
 	uint16_t qbman_ch_id;
 	uint8_t num_priorities;
-	uint8_t channel_index;
+	uint8_t ch_idx[DPAA2_DPCON_MAX_CH_IDX_NUM];
+	uint16_t dpio_idx[DPAA2_DPCON_MAX_CH_IDX_NUM];
+	uint8_t ch_idx_num;
 };
 
 /* DPCON channel pool, shared by the net rx-interrupt path and the event PMD */
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index cd2b00c3c9..4c20e26870 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -47,14 +47,21 @@ dpaa2_eventdev_attach_eth_rxq(const struct rte_eth_dev *dev,
 	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
 {
 	int ret;
-	uint8_t ev_qid = queue_conf->ev.queue_id;
-	uint16_t idx = priv->evq_info[ev_qid].dpni_rxq_num;
-	struct dpaa2_dpcon_dev *dpcon = priv->evq_info[ev_qid].dpcon;
+	uint16_t ev_qid = queue_conf->ev.queue_id, idx;
+	struct dpaa2_dpcon_dev *dpcon;
+
+	if (ev_qid >= priv->max_event_queues) {
+		DPAA2_EVENTDEV_ERR("Invalid event queue ID(%d) >= %d",
+			ev_qid, priv->max_event_queues);
+		return -EINVAL;
+	}
 
+	idx = priv->evq_info[ev_qid].dpni_rxq_num;
 	if (idx >= DPAA2_EVENT_MAX_QUEUE_FLOWS) {
 		DPAA2_EVENTDEV_ERR("Too many flows to attach eventq%d", ev_qid);
 		return -ENOMEM;
 	}
+	dpcon = priv->evq_info[ev_qid].dpcon;
 	ret = dpaa2_eth_eventq_attach(dev, rxq_id, dpcon, queue_conf);
 	if (ret) {
 		DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
@@ -114,8 +121,6 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 {
 	struct dpaa2_port *dpaa2_portal = port;
 	struct dpaa2_dpio_dev *dpio_dev;
-	struct rte_eventdev *eventdev = dpaa2_portal->eventdev;
-	struct dpaa2_eventdev *priv = eventdev->data->dev_private;
 	struct dpaa2_eventq *evq_info;
 	uint32_t queue_id, retry_count, loop, frames_to_send, i;
 	struct qbman_swp *swp;
@@ -145,13 +150,13 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			event = &ev[num_tx + loop];
 			queue_id = event->queue_id;
 			if (unlikely(queue_id >= DPAA2_EVENT_MAX_QUEUES ||
-				priv->evq_info[queue_id].event_port != dpaa2_portal)) {
-				DPAA2_EVENTDEV_ERR("Event queue%d is not handled by port%d",
+				!dpaa2_portal->evq_map[queue_id])) {
+				DPAA2_EVENTDEV_ERR("Event queue%d not linked to port%d",
 					queue_id, dpaa2_portal->port_id);
 				ret = -EINVAL;
 				goto send_partial;
 			}
-			evq_info = &priv->evq_info[queue_id];
+			evq_info = dpaa2_portal->evq_map[queue_id];
 			if (unlikely(event->sched_type >= DPAA2_EVENTQ_LINK_CONF_MAX ||
 				!evq_info->dpci_txqs[event->sched_type])) {
 				DPAA2_EVENTDEV_ERR("Event sched_type(%d) is not supported",
@@ -606,20 +611,32 @@ dpaa2_eventdev_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 			   const struct rte_event_queue_conf *queue_conf)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
-	struct dpaa2_eventq *evq_info = &priv->evq_info[queue_id];
+	struct dpaa2_eventq *evq_info;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
+	if (queue_id >= priv->max_event_queues) {
+		DPAA2_EVENTDEV_ERR("Invalid queue ID(%d) >= %d", queue_id,
+			priv->max_event_queues);
+		return -EINVAL;
+	}
+	evq_info = &priv->evq_info[queue_id];
+	if (queue_id != evq_info->event_queue_id) {
+		DPAA2_EVENTDEV_ERR("Queue index(%d) != event queue ID(%d)?",
+			queue_id, evq_info->event_queue_id);
+		return -EACCES;
+	}
+
 	switch (queue_conf->schedule_type) {
 	case RTE_SCHED_TYPE_PARALLEL:
 	case RTE_SCHED_TYPE_ATOMIC:
 		break;
 	default:
-		DPAA2_EVENTDEV_ERR("Schedule type is not supported.");
-		return -1;
+		DPAA2_EVENTDEV_ERR("Schedule type(%d) is not supported.",
+			queue_conf->schedule_type);
+		return -ENOTSUP;
 	}
 	evq_info->event_queue_cfg = queue_conf->event_queue_cfg;
-	evq_info->event_queue_id = queue_id;
 
 	return 0;
 }
@@ -657,40 +674,83 @@ dpaa2_eventdev_port_unlink(struct rte_eventdev *dev, void *port,
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
 	struct dpaa2_eventq *evq_info;
 	struct qbman_swp *swp;
-	uint8_t total_queues[DPAA2_EVENT_MAX_QUEUES];
 	struct dpaa2_eventq *evq_infos[DPAA2_EVENT_MAX_QUEUES];
+	uint16_t pos[DPAA2_DPCON_MAX_CH_IDX_NUM], ch_idx;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	RTE_SET_USED(dev);
-	if (!queues) {
-		queues = total_queues;
+	dpio_dev = dpaa2_portal->dpio_dev;
+	if (!dpio_dev)
+		return 0;
+
+	swp = dpio_dev->sw_portal;
+	if (!queues)
 		nb_unlinks = dpaa2_portal->num_linked_evq;
-		for (i = 0; i < nb_unlinks; i++)
-			queues[i] = dpaa2_portal->evq_info[i]->event_queue_id;
+
+	for (i = 0; i < nb_unlinks; i++) {
+		if (!queues) {
+			evq_info = dpaa2_portal->evq_info[i];
+			goto map_check;
+		}
+		evq_info = NULL;
+		for (j = 0; j < dpaa2_portal->num_linked_evq; j++) {
+			if (queues[i] == dpaa2_portal->evq_info[j]->event_queue_id) {
+				evq_info = dpaa2_portal->evq_info[j];
+				break;
+			}
+		}
+		if (!evq_info) {
+			DPAA2_EVENTDEV_WARN("Event port%d doesn't handle queues[%d](%d)",
+				dpaa2_portal->port_id, i, queues[i]);
+			return -EINVAL;
+		}
+map_check:
+		if (dpaa2_portal->evq_map[evq_info->event_queue_id] != evq_info) {
+			DPAA2_EVENTDEV_ERR("Event queue mapping[%d] mismatch.",
+				evq_info->event_queue_id);
+			return -EINVAL;
+		}
+		for (j = 0; j < evq_info->dpcon->ch_idx_num; j++) {
+			if (evq_info->dpcon->dpio_idx[j] == dpio_dev->index)
+				break;
+		}
+		if (j == evq_info->dpcon->ch_idx_num) {
+			DPAA2_EVENTDEV_ERR("Event queue.%d was NOT attached to dpio.%d.",
+				evq_info->event_queue_id, dpio_dev->index);
+			return -EINVAL;
+		}
+		pos[i] = j;
+		evq_infos[i] = evq_info;
 	}
 
 	for (i = 0; i < nb_unlinks; i++) {
+		evq_info = evq_infos[i];
+		ch_idx = evq_info->dpcon->ch_idx[pos[i]];
+		qbman_swp_push_set(swp, ch_idx, 0);
+		ret = dpio_remove_static_dequeue_channel(dpio_dev->dpio,
+				0, dpio_dev->token, evq_info->dpcon->dpcon_id);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failed(%d) to remove channel (dpio.%d/dpcon.%d)",
+				ret, dpio_dev->index, evq_info->dpcon->dpcon_id);
+			break;
+		}
+		memmove(&evq_info->dpcon->ch_idx[pos[i]],
+			&evq_info->dpcon->ch_idx[pos[i] + 1],
+			evq_info->dpcon->ch_idx_num - (pos[i] + 1));
+		memmove(&evq_info->dpcon->dpio_idx[pos[i]],
+			&evq_info->dpcon->dpio_idx[pos[i] + 1],
+			(evq_info->dpcon->ch_idx_num - (pos[i] + 1)) * sizeof(uint16_t));
+		evq_info->dpcon->ch_idx_num--;
 		for (j = 0; j < dpaa2_portal->num_linked_evq; j++) {
-			evq_info = dpaa2_portal->evq_info[j];
-			if (evq_info && evq_info->event_queue_id == queues[i]) {
-				dpio_dev = dpaa2_portal->dpio_dev;
-				swp = dpio_dev->sw_portal;
-				qbman_swp_push_set(swp, evq_info->dpcon->channel_index, 0);
-				ret = dpio_remove_static_dequeue_channel(dpio_dev->dpio,
-					0, dpio_dev->token, evq_info->dpcon->dpcon_id);
-				if (ret)
-					DPAA2_EVENTDEV_WARN("Failed(%d) to remove channel", ret);
-				evq_info->event_port = NULL;
+			if (dpaa2_portal->evq_info[j] == evq_info) {
 				dpaa2_portal->evq_info[j] = NULL;
-				num++;
 				break;
 			}
 		}
-		if (j == dpaa2_portal->num_linked_evq) {
-			DPAA2_EVENTDEV_WARN("%s: Event port%d doesn't handle queue[%d]:%d",
-				__func__, dpaa2_portal->port_id, i, queues[i]);
-		}
+		dpaa2_portal->evq_map[evq_info->event_queue_id] = NULL;
+		evq_info->link_num--;
+		num++;
 	}
 
 	for (i = 0; i < dpaa2_portal->num_linked_evq; i++) {
@@ -714,75 +774,60 @@ dpaa2_eventdev_port_link(struct rte_eventdev *dev, void *port,
 	uint16_t nb_links)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
-	struct dpaa2_port *dpaa2_portal = port, *ev_port;
+	struct dpaa2_port *dpaa2_portal = port;
 	struct dpaa2_dpio_dev *dpio_dev = dpaa2_portal->dpio_dev;
 	struct dpaa2_eventq *evq_info;
-	int ret = 0;
 	uint16_t i;
-	uint8_t channel_index;
+	uint8_t ch_idx;
+	int ret = 0;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	RTE_SET_USED(priorities);
 
-	if (dpaa2_portal->num_linked_evq > 0) {
-		ret = rte_event_port_unlink(dev->data->dev_id,
-			dpaa2_portal->port_id, NULL, 0);
-		if (ret)
-			return ret;
-	}
-
 	for (i = 0; i < nb_links; i++) {
+		if (queues[i] >= priv->max_event_queues) {
+			DPAA2_EVENTDEV_ERR("Event port%d: queues[%d](%d) >= %d",
+				dpaa2_portal->port_id, i, queues[i], priv->max_event_queues);
+			break;
+		}
 		evq_info = &priv->evq_info[queues[i]];
-		if (!evq_info->valid) {
-			DPAA2_EVENTDEV_WARN("%s: Event port%d.queue%d is not valid!",
-				__func__, dpaa2_portal->port_id, queues[i]);
-			return -EINVAL;
+		if (evq_info->link_num > 0 &&
+			(evq_info->event_queue_cfg & RTE_EVENT_QUEUE_CFG_SINGLE_LINK)) {
+			DPAA2_EVENTDEV_ERR("Event queue[%d] is configured as single link",
+				queues[i]);
+			break;
 		}
-		if (evq_info->event_port) {
-			ev_port = evq_info->event_port;
-			DPAA2_EVENTDEV_WARN("%s: queue%d is occupied by event port%d",
-				__func__, queues[i], ev_port->port_id);
-			return -ENODEV;
+		if (evq_info->dpcon->ch_idx_num >= DPAA2_DPCON_MAX_CH_IDX_NUM) {
+			DPAA2_EVENTDEV_ERR("Too many channel to be added with dpcon(ID=%d)",
+				evq_info->dpcon->dpcon_id);
+			break;
+		}
+		if (dpaa2_portal->evq_map[queues[i]]) {
+			DPAA2_EVENTDEV_ERR("Event port%d: queue%d already mapped",
+				dpaa2_portal->port_id, queues[i]);
+			break;
 		}
-	}
-
-	for (i = 0; i < nb_links; i++) {
-		evq_info = &priv->evq_info[queues[i]];
 		ret = dpio_add_static_dequeue_channel(dpio_dev->dpio,
 			CMD_PRI_LOW, dpio_dev->token,
-			evq_info->dpcon->dpcon_id, &channel_index);
+			evq_info->dpcon->dpcon_id, &ch_idx);
 		if (ret) {
 			DPAA2_EVENTDEV_ERR("Event port%d.queue%d static dequeue config failed(%d)",
 				dpaa2_portal->port_id, queues[i], ret);
-			goto err;
+			break;
 		}
-
-		qbman_swp_push_set(dpio_dev->sw_portal, channel_index, 1);
-		evq_info->dpcon->channel_index = channel_index;
-
 		dpaa2_portal->evq_info[dpaa2_portal->num_linked_evq] = evq_info;
-		evq_info->event_port = dpaa2_portal;
 		dpaa2_portal->num_linked_evq++;
-	}
+		evq_info->dpcon->ch_idx[evq_info->dpcon->ch_idx_num] = ch_idx;
+		evq_info->dpcon->dpio_idx[evq_info->dpcon->ch_idx_num] = dpio_dev->index;
+		evq_info->dpcon->ch_idx_num++;
+		evq_info->link_num++;
+		dpaa2_portal->evq_map[queues[i]] = evq_info;
 
-err:
-	if (!ret)
-		return nb_links;
-
-	nb_links = i;
-	for (i = 0; i < nb_links; i++) {
-		evq_info = &priv->evq_info[queues[i]];
-		evq_info->event_port = NULL;
-		qbman_swp_push_set(dpio_dev->sw_portal, evq_info->dpcon->channel_index, 0);
-		if (dpio_remove_static_dequeue_channel(dpio_dev->dpio,
-			0, dpio_dev->token, evq_info->dpcon->dpcon_id)) {
-			DPAA2_EVENTDEV_ERR("Event port%d.queue%d remove failed!",
-				dpaa2_portal->port_id, queues[i]);
-		}
-		dpaa2_portal->num_linked_evq--;
+		qbman_swp_push_set(dpio_dev->sw_portal, ch_idx, 1);
 	}
-	return ret;
+
+	return i;
 }
 
 static int
@@ -795,7 +840,7 @@ dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	if (dev->data->ports[port_id]) {
-		DPAA2_EVENTDEV_WARN("Event port%d exists!", port_id);
+		DPAA2_EVENTDEV_DEBUG("Event port%d exists!", port_id);
 		dpaa2_eventdev_port_release(dev->data->ports[port_id]);
 	}
 
@@ -1231,7 +1276,7 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 		/** TO DO: order schedule.*/
 
 		evq_info->valid = true;
-		evq_info->event_port = NULL;
+		evq_info->event_queue_id = priv->max_event_queues;
 
 		priv->max_event_queues++;
 		if (priv->max_event_queues >= DPAA2_EVENT_MAX_QUEUES)
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index adeb22bda6..c0ce42c83f 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -54,7 +54,7 @@ enum {
 #define DPAA2_EVENTQ_LINK_CONF_MAX 4 /** Max schedule type + 1.*/
 struct dpaa2_eventq {
 	int valid;
-	void *event_port;
+	uint8_t link_num;
 	/* DPcon device */
 	struct dpaa2_dpcon_dev *dpcon;
 	/* Attached DPCI device */
@@ -80,6 +80,7 @@ struct dpaa2_port {
 	RTE_ATOMIC(uint32_t) flushing;
 
 	struct dpaa2_eventq *evq_info[DPAA2_EVENT_MAX_QUEUES];
+	struct dpaa2_eventq *evq_map[DPAA2_EVENT_MAX_QUEUES];
 	uint8_t port_id;
 	uint8_t num_linked_evq;
 	uint64_t timeout_us;
diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
index 6a4ec04aae..9e58b4253f 100644
--- a/drivers/event/dpaa2/dpaa2_scheduler.c
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -196,16 +196,18 @@ dpaa2_scheduler_dpci_recv(struct dpaa2_sch_dev *sch_dev,
 	ret = dpio_add_static_dequeue_channel(dpio_dev->dpio,
 			CMD_PRI_LOW, dpio_dev->token,
 			dpcon_dev->dpcon_id,
-			&dpcon_dev->channel_index);
+			&dpcon_dev->ch_idx[dpcon_dev->ch_idx_num]);
 	if (ret) {
 		DPAA2_EVENTDEV_ERR("Failure(%d) adding dpcon%d to static dq channel",
 			ret, dpcon_dev->dpcon_id);
 		return 0;
 	}
+	dpcon_dev->dpio_idx[dpcon_dev->ch_idx_num] = dpio_dev->index;
 
-	qbman_swp_push_set(swp, dpcon_dev->channel_index, 1);
+	qbman_swp_push_set(swp, dpcon_dev->ch_idx[dpcon_dev->ch_idx_num], 1);
 	sch_dev->linked[cpu] = sch_dev->port_queue_num;
 	sch_dev->dpio_dev[cpu] = dpio_dev;
+	dpcon_dev->ch_idx_num++;
 
 start_dq:
 	while (num_pkts < nb_pkts) {
@@ -562,7 +564,9 @@ dpaa2_scheduler_rx_core_push_drain(struct dpaa2_sch_dev *sch_dev,
 	if (drain_num > 0)
 		DPAA2_EVENTDEV_WARN("Drain %d buffer(s) from core%d", drain_num, core);
 
-	qbman_swp_push_set(dpio_dev->sw_portal, dpcon_dev->channel_index, 0);
+	qbman_swp_push_set(dpio_dev->sw_portal,
+		dpcon_dev->ch_idx[dpcon_dev->ch_idx_num - 1], 0);
+	dpcon_dev->ch_idx_num--;
 	if (attach_num)
 		(*attach_num)++;
 	ret = dpio_remove_static_dequeue_channel(dpio_dev->dpio,
-- 
2.43.0

