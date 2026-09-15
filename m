Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9218C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 661DD42E81;
	Tue, 15 Sep 2026 14:02:28 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9728242D28
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:02:22 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7260F1A0033;
 Tue, 15 Sep 2026 14:02:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B7451A0049;
 Tue, 15 Sep 2026 14:02:22 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C923F18000BF;
 Tue, 15 Sep 2026 20:02:20 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3-S3 10/10] drivers: align dpaa2 event port depths with
 hardware rings
Date: Tue, 15 Sep 2026 17:32:08 +0530
Message-ID: <20260915120208.4185877-11-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
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

The event port dequeue and enqueue depths were fixed at 8. A dequeue
drains the portal DQRR and an enqueue fills the EQCR, so the real limits
are the sizes of those two rings, which differ per SoC and are known at
run time. Report them instead, adding qbman_swp_portal_dqrr_size() to
query the DQRR size (the EQCR size is already available as
dpaa2_eqcr_size).

The Tx adapter enqueue helpers sized their on-stack mbuf arrays from the
advertised enqueue depth, which no longer bounds the burst the adapter
may hand them, so bound the copy by the array itself and transmit in
chunks.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 .../fslmc/qbman/include/fsl_qbman_portal.h    |  7 ++
 drivers/bus/fslmc/qbman/qbman_portal.c        | 15 ++++
 drivers/event/dpaa2/dpaa2_eventdev.c          | 72 ++++++++++++-------
 drivers/event/dpaa2/dpaa2_eventdev.h          |  4 +-
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
index 73e57bcdc1..fb1c6046ae 100644
--- a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
@@ -1222,6 +1222,13 @@ __rte_internal
 int qbman_swp_acquire(struct qbman_swp *s, uint16_t bpid, uint64_t *buffers,
 		      unsigned int num_buffers);
 
+/**
+ * qbman_swp_portal_dqrr_size() - Number of entries in a portal's DQRR.
+ * @p: the software portal object, NULL to query the SoC's DQRR size.
+ */
+__rte_internal
+uint32_t qbman_swp_portal_dqrr_size(struct qbman_swp *p);
+
 	/*****************/
 	/* FQ management */
 	/*****************/
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 4902ca4ccb..462e2ed75f 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -73,6 +73,11 @@ enum qbman_sdqcr_fc {
 static struct qbman_swp *portal_idx_map[MAX_QBMAN_PORTALS];
 
 uint32_t qman_version;
+/* DQRR size of the portals initialised so far. All portals of a SoC have the
+ * same size, so this doubles as the SoC's DQRR size for callers that have no
+ * portal at hand.
+ */
+static uint32_t dpaa2_portal_dqrr_size = 8;
 
 /* Internal Function declaration */
 static int
@@ -239,6 +244,15 @@ static int (*qbman_swp_release_ptr)(struct qbman_swp *s,
 			const uint64_t *buffers, unsigned int num_buffers)
 			= qbman_swp_release_direct;
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_portal_dqrr_size)
+uint32_t qbman_swp_portal_dqrr_size(struct qbman_swp *p)
+{
+	if (p != NULL)
+		return p->dqrr.dqrr_size;
+
+	return dpaa2_portal_dqrr_size;
+}
+
 /*********************************/
 /* Portal constructor/destructor */
 /*********************************/
@@ -298,6 +312,7 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 	 */
 	p->dqrr.ci_vec_en = p->dqrr.dqrr_size <= (32 - DQRR_DCAP_CI_VEC_OFFSET);
 	p->dqrr.ci_flush_th = p->dqrr.dqrr_size / 2;
+	dpaa2_portal_dqrr_size = p->dqrr.dqrr_size;
 
 	ret = qbman_swp_sys_init(&p->sys, d, p->dqrr.dqrr_size);
 	if (ret) {
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 5d32bd9fd6..ddcf7b3678 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017,2019-2022 NXP
+ * Copyright 2017,2019-2022,2026 NXP
  */
 
 #include <assert.h>
@@ -389,10 +389,11 @@ dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 	/* we only support dpio up to number of cores */
 	if (dev_info->max_event_ports > rte_lcore_count())
 		dev_info->max_event_ports = rte_lcore_count();
-	dev_info->max_event_port_dequeue_depth =
-		DPAA2_EVENT_MAX_PORT_DEQUEUE_DEPTH;
-	dev_info->max_event_port_enqueue_depth =
-		DPAA2_EVENT_MAX_PORT_ENQUEUE_DEPTH;
+	/* A dequeue drains the portal DQRR and an enqueue fills the EQCR, so
+	 * the hardware ring sizes are the real limits.
+	 */
+	dev_info->max_event_port_dequeue_depth = qbman_swp_portal_dqrr_size(NULL);
+	dev_info->max_event_port_enqueue_depth = dpaa2_eqcr_size;
 	dev_info->max_num_events = DPAA2_EVENT_MAX_NUM_EVENTS;
 	dev_info->event_dev_cap = RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED |
 		RTE_EVENT_DEV_CAP_ATOMIC |
@@ -527,12 +528,9 @@ dpaa2_eventdev_port_def_conf(struct rte_eventdev *dev, uint8_t port_id,
 	RTE_SET_USED(dev);
 	RTE_SET_USED(port_id);
 
-	port_conf->new_event_threshold =
-		DPAA2_EVENT_MAX_NUM_EVENTS;
-	port_conf->dequeue_depth =
-		DPAA2_EVENT_MAX_PORT_DEQUEUE_DEPTH;
-	port_conf->enqueue_depth =
-		DPAA2_EVENT_MAX_PORT_ENQUEUE_DEPTH;
+	port_conf->new_event_threshold = DPAA2_EVENT_MAX_NUM_EVENTS;
+	port_conf->dequeue_depth = qbman_swp_portal_dqrr_size(NULL);
+	port_conf->enqueue_depth = dpaa2_eqcr_size;
 	port_conf->event_port_cfg = 0;
 }
 
@@ -977,18 +975,31 @@ dpaa2_eventdev_txa_enqueue_same_dest(void *port,
 				     struct rte_event ev[],
 				     uint16_t nb_events)
 {
-	struct rte_mbuf *m[DPAA2_EVENT_MAX_PORT_ENQUEUE_DEPTH], *m0;
-	uint8_t qid, i;
+	struct rte_mbuf *m[MAX_TX_RING_SLOTS], *m0;
+	uint16_t sent = 0, burst, i, port_id;
+	uint8_t qid;
 
 	RTE_SET_USED(port);
 
-	m0 = (struct rte_mbuf *)ev[0].mbuf;
+	m0 = ev[0].mbuf;
 	qid = rte_event_eth_tx_adapter_txq_get(m0);
+	port_id = m0->port;
+
+	/* The advertised enqueue depth is the EQCR size, which may exceed the
+	 * on-stack burst array, so transmit in ring-sized chunks.
+	 */
+	while (sent < nb_events) {
+		burst = RTE_MIN(nb_events - sent, (uint16_t)RTE_DIM(m));
+		for (i = 0; i < burst; i++)
+			m[i] = ev[sent + i].mbuf;
+
+		i = rte_eth_tx_burst(port_id, qid, m, burst);
+		sent += i;
+		if (i < burst)
+			break;
+	}
 
-	for (i = 0; i < nb_events; i++)
-		m[i] = (struct rte_mbuf *)ev[i].mbuf;
-
-	return rte_eth_tx_burst(m0->port, qid, m, nb_events);
+	return sent;
 }
 
 static uint16_t
@@ -996,19 +1007,28 @@ dpaa2_eventdev_txa_enqueue(void *port,
 			   struct rte_event ev[],
 			   uint16_t nb_events)
 {
-	void *txq[DPAA2_EVENT_MAX_PORT_ENQUEUE_DEPTH];
-	struct rte_mbuf *m[DPAA2_EVENT_MAX_PORT_ENQUEUE_DEPTH];
-	uint8_t qid, i;
+	void *txq[MAX_TX_RING_SLOTS];
+	struct rte_mbuf *m[MAX_TX_RING_SLOTS];
+	uint16_t sent = 0, burst, i;
+	uint8_t qid;
 
 	RTE_SET_USED(port);
 
-	for (i = 0; i < nb_events; i++) {
-		m[i] = (struct rte_mbuf *)ev[i].mbuf;
-		qid = rte_event_eth_tx_adapter_txq_get(m[i]);
-		txq[i] = rte_eth_devices[m[i]->port].data->tx_queues[qid];
+	while (sent < nb_events) {
+		burst = RTE_MIN(nb_events - sent, (uint16_t)RTE_DIM(m));
+		for (i = 0; i < burst; i++) {
+			m[i] = ev[sent + i].mbuf;
+			qid = rte_event_eth_tx_adapter_txq_get(m[i]);
+			txq[i] = rte_eth_devices[m[i]->port].data->tx_queues[qid];
+		}
+
+		i = dpaa2_dev_tx_multi_txq_ordered(txq, m, burst);
+		sent += i;
+		if (i < burst)
+			break;
 	}
 
-	return dpaa2_dev_tx_multi_txq_ordered(txq, m, nb_events);
+	return sent;
 }
 
 static struct eventdev_ops dpaa2_eventdev_ops = {
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index 3883a26c91..a054dfdbd7 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017 NXP
+ * Copyright 2017,2026 NXP
  */
 
 #ifndef __DPAA2_EVENTDEV_H__
@@ -22,8 +22,6 @@
 #define DPAA2_EVENT_MAX_QUEUE_FLOWS		2048
 #define DPAA2_EVENT_MAX_QUEUE_PRIORITY_LEVELS	8
 #define DPAA2_EVENT_MAX_EVENT_PRIORITY_LEVELS	0
-#define DPAA2_EVENT_MAX_PORT_DEQUEUE_DEPTH	8
-#define DPAA2_EVENT_MAX_PORT_ENQUEUE_DEPTH	8
 #define DPAA2_EVENT_MAX_NUM_EVENTS		(INT32_MAX - 1)
 
 #define DPAA2_EVENT_QUEUE_ATOMIC_FLOWS		2048
-- 
2.43.0

