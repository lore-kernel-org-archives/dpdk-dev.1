Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD3606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2270410D5;
	Fri, 23 Oct 2026 15:44:41 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id C32D240E5A
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:30 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A62C4200034;
 Fri, 23 Oct 2026 15:44:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70CBF200020;
 Fri, 23 Oct 2026 15:44:30 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 153EF18000B1;
 Fri, 23 Oct 2026 21:44:28 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 35/65] event/dpaa2: add push mode to DPCON Rx scheduler
Date: Fri, 23 Oct 2026 19:13:15 +0530
Message-ID: <20261023134346.37727-36-prashant.gupta_3@nxp.com>
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

Extend the DPCON standalone Rx scheduler with a second scheduling mode
so callers can choose how packets reach the poll path. The mode is
selected at init time through a new enum rte_dpaa2_sch_mode argument to
rte_dpaa2_scheduler_init():

pull
   The original behaviour. A single shared DPCON channel is allocated
   and ethdev Rx queues are attached to it up front; packets are pulled
   from that channel via the plain or prefetch receive path.

push
   A per-lcore DPCON plus DPCI pair is allocated lazily on first
   receive. The DPCI is linked to the DPCON, the pending Rx queues are
   attached, and the DPCON channel is added as a static dequeue channel
   so frames are pushed into the software portal DQRR and consumed
   in place (dpaa2_scheduler_dpci_recv).

To support push mode, struct dpaa2_sch_dev now holds per-lcore dpcon
and dpci arrays and a per-lcore linked flag instead of a single DPCON
pointer. rte_dpaa2_scheduler_add() defers hardware attach for push mode
(recording the queue and doing the attach on the first receive on each
lcore), while pull mode still attaches immediately. start and destroy
are updated to walk the per-lcore arrays: destroy stops linked DPCONs,
frees both the DPCON and DPCI devices, and reports the first stop error
while still freeing everything.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_scheduler.c | 189 ++++++++++++++++++++++----
 drivers/net/dpaa2/rte_pmd_dpaa2.h     |   7 +-
 2 files changed, 167 insertions(+), 29 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
index e553c4d3f6..51956ac1e5 100644
--- a/drivers/event/dpaa2/dpaa2_scheduler.c
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -41,9 +41,12 @@ struct dpaa2_sch_port_queue {
 };
 
 struct dpaa2_sch_dev {
-	struct dpaa2_dpcon_dev *dpcon_dev;
+	struct dpaa2_dpcon_dev *dpcon_dev[RTE_MAX_LCORE];
+	struct dpaa2_dpci_dev *dpci_dev[RTE_MAX_LCORE];
+	uint8_t linked[RTE_MAX_LCORE];
 	struct dpaa2_sch_port_queue port_queue[DPAA2_SCH_PORT_QUEUE_MAX_NUM];
 	uint8_t port_queue_num;
+	enum rte_dpaa2_sch_mode sch_mode;
 	struct queue_storage_info_t q_storage[RTE_MAX_LCORE];
 	uint16_t (*rx_schedule)(struct dpaa2_sch_dev *dev,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
@@ -83,11 +86,110 @@ dpaa2_qbman_pull_desc_channel_set(struct qbman_pull_desc *pulldesc,
 		iova_storage, 1);
 }
 
+static uint16_t
+dpaa2_scheduler_dpci_recv(struct dpaa2_sch_dev *sch_dev,
+	struct rte_mbuf **mbuf, uint16_t nb_pkts)
+{
+	const struct qbman_result *dq;
+	struct dpaa2_dpcon_dev *dpcon_dev;
+	struct dpaa2_dpci_dev *dpci_dev;
+	struct dpaa2_dpio_dev *dpio_dev;
+	struct qbman_swp *swp;
+	const struct qbman_fd *fd;
+	struct dpaa2_queue *rxq;
+	struct dpaa2_sch_port_queue *port_queue;
+	struct rte_event_eth_rx_adapter_queue_conf *queue_conf;
+	uint16_t num_pkts = 0, i = 0;
+	int ret;
+	struct dpaa2_dev_priv *priv;
+	uint32_t cpu = rte_lcore_id();
+
+	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+		ret = dpaa2_affine_qbman_ethrx_swp();
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failure(%d) in affining portal", ret);
+			return 0;
+		}
+	}
+	dpio_dev = DPAA2_PER_LCORE_ETHRX_DPIO;
+	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+	if (likely(sch_dev->linked[cpu] == sch_dev->port_queue_num))
+		goto start_dq;
+	if (!sch_dev->dpcon_dev[cpu])
+		sch_dev->dpcon_dev[cpu] = rte_dpaa2_alloc_dpcon_dev();
+	if (!sch_dev->dpci_dev[cpu])
+		sch_dev->dpci_dev[cpu] = rte_dpaa2_alloc_dpci_dev();
+	if (!sch_dev->dpcon_dev[cpu] || !sch_dev->dpci_dev[cpu])
+		return 0;
+	dpcon_dev = sch_dev->dpcon_dev[cpu];
+	dpci_dev = sch_dev->dpci_dev[cpu];
+	ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
+		dpcon_dev->dpcon_id, 0, NULL, NULL);
+	if (ret) {
+		DPAA2_EVENTDEV_ERR("DPCI link attaches dpcon failed: err(%d)", ret);
+		return 0;
+	}
+	for (i = 0; i < sch_dev->port_queue_num; i++) {
+		port_queue = &sch_dev->port_queue[i];
+		if (port_queue->configured)
+			continue;
+		queue_conf = &port_queue->queue_conf;
+		dpaa2_eth_eventq_prio_dpcon_to_ev(port_queue->priority,
+			dpcon_dev, queue_conf);
+		ret = dpaa2_eth_eventq_attach(port_queue->eth_dev,
+			port_queue->rxq_id, dpcon_dev, queue_conf);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failure(%d) attaching %s-rxq%d to eventq",
+				ret, port_queue->eth_dev->data->name,
+				port_queue->rxq_id);
+			return 0;
+		}
+		port_queue->configured = true;
+	}
+	ret = dpio_add_static_dequeue_channel(dpio_dev->dpio,
+			CMD_PRI_LOW, dpio_dev->token,
+			dpcon_dev->dpcon_id,
+			&dpcon_dev->channel_index);
+	if (ret) {
+		DPAA2_EVENTDEV_ERR("Failure(%d) adding dpcon%d to static dq channel",
+			ret, dpcon_dev->dpcon_id);
+		return 0;
+	}
+
+	qbman_swp_push_set(swp, dpcon_dev->channel_index, 1);
+	sch_dev->linked[cpu] = sch_dev->port_queue_num;
+
+start_dq:
+	do {
+		dq = qbman_swp_dqrr_next(swp);
+		if (!dq)
+			goto quit;
+
+		qbman_swp_prefetch_dqrr_next(swp);
+
+		fd = qbman_result_DQ_fd(dq);
+		rxq = (void *)qbman_result_DQ_fqd_ctx(dq);
+		priv = rxq->eth_data->dev_private;
+		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+			mbuf[num_pkts] = dpaa2_eth_sg_fd_to_mbuf_export(priv, fd);
+		else
+			mbuf[num_pkts] = dpaa2_eth_fd_to_mbuf_export(priv, fd);
+		dpaa2_dev_rx_mbuf_flc_offload_export(mbuf[num_pkts], fd);
+		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf[num_pkts]);
+		qbman_swp_dqrr_consume(swp, dq);
+
+		num_pkts++;
+	} while (num_pkts < nb_pkts);
+
+quit:
+	return num_pkts;
+}
+
 static uint16_t
 dpaa2_scheduler_recv(struct dpaa2_sch_dev *sch_dev,
 	struct rte_mbuf **mbuf, uint16_t nb_pkts)
 {
-	struct dpaa2_dpcon_dev *dpcon_dev = sch_dev->dpcon_dev;
+	struct dpaa2_dpcon_dev *dpcon_dev = sch_dev->dpcon_dev[0];
 	uint16_t ch_id = dpcon_dev->qbman_ch_id;
 	struct qbman_result *dq_sch_storage;
 	uint16_t total_nb_pkts = nb_pkts;
@@ -179,7 +281,7 @@ static uint16_t
 dpaa2_scheduler_prefetch_recv(struct dpaa2_sch_dev *sch_dev,
 	struct rte_mbuf **mbuf, uint16_t nb_pkts)
 {
-	struct dpaa2_dpcon_dev *dpcon_dev = sch_dev->dpcon_dev;
+	struct dpaa2_dpcon_dev *dpcon_dev = sch_dev->dpcon_dev[0];
 	uint16_t ch_id = dpcon_dev->qbman_ch_id, pull_size;
 	struct qbman_result *dq_storage, *dq_storage1 = NULL, *active;
 	struct qbman_pull_desc pulldesc;
@@ -314,7 +416,7 @@ dpaa2_scheduler_prefetch_recv(struct dpaa2_sch_dev *sch_dev,
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_init, 26.11)
-void *rte_dpaa2_scheduler_init(void)
+void *rte_dpaa2_scheduler_init(enum rte_dpaa2_sch_mode sch_mode)
 {
 	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
 	struct dpaa2_sch_dev *sch_dev = NULL;
@@ -331,16 +433,24 @@ void *rte_dpaa2_scheduler_init(void)
 	if (ret)
 		goto err;
 
-	dpcon_dev = rte_dpaa2_alloc_dpcon_dev();
-	if (!dpcon_dev) {
-		DPAA2_EVENTDEV_ERR("Failed alloc dpcon device!!");
+	if (sch_mode == RTE_DPAA2_SCH_PULL) {
+		dpcon_dev = rte_dpaa2_alloc_dpcon_dev();
+		if (!dpcon_dev) {
+			DPAA2_EVENTDEV_ERR("Failed alloc dpcon device!!");
+			goto err;
+		}
+		sch_dev->dpcon_dev[0] = dpcon_dev;
+		if (prefetch_enable)
+			sch_dev->rx_schedule = dpaa2_scheduler_prefetch_recv;
+		else
+			sch_dev->rx_schedule = dpaa2_scheduler_recv;
+	} else if (sch_mode == RTE_DPAA2_SCH_PUSH) {
+		sch_dev->rx_schedule = dpaa2_scheduler_dpci_recv;
+	} else {
+		DPAA2_EVENTDEV_ERR("Invalid schedule mode(%d)!!", sch_mode);
 		goto err;
 	}
-	sch_dev->dpcon_dev = dpcon_dev;
-	if (prefetch_enable)
-		sch_dev->rx_schedule = dpaa2_scheduler_prefetch_recv;
-	else
-		sch_dev->rx_schedule = dpaa2_scheduler_recv;
+	sch_dev->sch_mode = sch_mode;
 
 	return sch_dev;
 err:
@@ -361,15 +471,22 @@ int rte_dpaa2_scheduler_start(void *scheduler_handle)
 	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
 	int32_t ret = 0;
 
-	if (sch_dev->dpcon_dev) {
-		ret = rte_dpaa2_dpcon_start(sch_dev->dpcon_dev);
-		if (ret)
+	if (sch_dev->sch_mode == RTE_DPAA2_SCH_PUSH)
+		goto start_quit;
+
+	if (sch_dev->dpcon_dev[0]) {
+		ret = rte_dpaa2_dpcon_start(sch_dev->dpcon_dev[0]);
+		if (ret) {
 			DPAA2_EVENTDEV_ERR("Failed(%d) to start dpcon", ret);
+			return ret;
+		}
+		sch_dev->linked[0] = 1;
 	} else {
 		DPAA2_EVENTDEV_ERR("No dpcon allocated");
 		ret = -ENODEV;
 	}
 
+start_quit:
 	return ret;
 }
 
@@ -377,15 +494,27 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_destroy, 26.11)
 int rte_dpaa2_scheduler_destroy(void *scheduler_handle)
 {
 	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
-	int32_t ret = 0;
+	struct dpaa2_dpcon_dev *dpcon_dev;
+	struct dpaa2_dpci_dev *dpci_dev;
+	int32_t ret = 0, _ret, i;
 
-	if (sch_dev->dpcon_dev) {
-		ret = rte_dpaa2_dpcon_stop(sch_dev->dpcon_dev);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR("Failed(%d) to stop dpcon", ret);
-			/** Free anyway.*/
+	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		dpcon_dev = sch_dev->dpcon_dev[i];
+		dpci_dev = sch_dev->dpci_dev[i];
+		if (dpcon_dev) {
+			if (sch_dev->linked[i]) {
+				_ret = rte_dpaa2_dpcon_stop(dpcon_dev);
+				if (_ret) {
+					DPAA2_EVENTDEV_ERR("Failed(%d) to stop dpcon[%d]", _ret, i);
+					/** Free anyway.*/
+					ret = _ret;
+				}
+			}
+			rte_dpaa2_free_dpcon_dev(dpcon_dev);
 		}
-		rte_dpaa2_free_dpcon_dev(sch_dev->dpcon_dev);
+		if (dpci_dev)
+			rte_dpaa2_free_dpci_dev(dpci_dev);
+		sch_dev->linked[i] = 0;
 	}
 
 	rte_free(sch_dev);
@@ -421,17 +550,21 @@ int rte_dpaa2_scheduler_add(void *scheduler_handle,
 	}
 
 	memset(&queue_conf, 0, sizeof(struct rte_event_eth_rx_adapter_queue_conf));
-	dpcon_dev = sch_dev->dpcon_dev;
-	dpaa2_eth_eventq_prio_dpcon_to_ev(priority, dpcon_dev, &queue_conf);
-	queue_conf.ev.sched_type = RTE_SCHED_TYPE_PARALLEL;
-	ret = dpaa2_eth_eventq_attach(dev, rxq_id, dpcon_dev, &queue_conf);
+	ret = 0;
+	if (sch_dev->sch_mode == RTE_DPAA2_SCH_PULL) {
+		dpcon_dev = sch_dev->dpcon_dev[0];
+		dpaa2_eth_eventq_prio_dpcon_to_ev(priority, dpcon_dev, &queue_conf);
+		queue_conf.ev.sched_type = RTE_SCHED_TYPE_PARALLEL;
+		ret = dpaa2_eth_eventq_attach(dev, rxq_id, dpcon_dev, &queue_conf);
+	}
 	if (!ret) {
 		sch_dev->port_queue[sch_dev->port_queue_num].eth_dev = dev;
 		sch_dev->port_queue[sch_dev->port_queue_num].rxq_id = rxq_id;
 		sch_dev->port_queue[sch_dev->port_queue_num].priority = priority;
 		rte_memcpy(&sch_dev->port_queue[sch_dev->port_queue_num].queue_conf,
 			&queue_conf, sizeof(struct rte_event_eth_rx_adapter_queue_conf));
-		sch_dev->port_queue[sch_dev->port_queue_num].configured = true;
+		if (sch_dev->sch_mode == RTE_DPAA2_SCH_PULL)
+			sch_dev->port_queue[sch_dev->port_queue_num].configured = true;
 		sch_dev->port_queue_num++;
 	}
 
@@ -454,5 +587,5 @@ rte_dpaa2_scheduler_max_prio(void *scheduler_handle)
 {
 	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
 
-	return sch_dev->dpcon_dev->num_priorities;
+	return sch_dev->dpcon_dev[0]->num_priorities;
 }
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index eb038011c9..5125ec5bf7 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -129,9 +129,14 @@ int
 rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
 	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off);
 
+enum rte_dpaa2_sch_mode {
+	RTE_DPAA2_SCH_PULL,
+	RTE_DPAA2_SCH_PUSH
+};
+
 __rte_experimental
 void *
-rte_dpaa2_scheduler_init(void);
+rte_dpaa2_scheduler_init(enum rte_dpaa2_sch_mode sch_mode);
 __rte_experimental
 int
 rte_dpaa2_scheduler_start(void *scheduler_handle);
-- 
2.43.0

