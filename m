Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94C606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4D5E40E96;
	Fri, 23 Oct 2026 15:44:42 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id E6B6D40ED8
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C3A211A003D;
 Fri, 23 Oct 2026 15:44:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C8511A0021;
 Fri, 23 Oct 2026 15:44:31 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 346C818000B5;
 Fri, 23 Oct 2026 21:44:30 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 36/65] event/dpaa2: drain Rx scheduler queues on destroy
Date: Fri, 23 Oct 2026 19:13:16 +0530
Message-ID: <20261023134346.37727-37-prashant.gupta_3@nxp.com>
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

Refactor the per-DQRR-entry receive code into a shared helper
(dpaa2_scheduler_swp_mbuf_dq) used by both the fast-path push receive
and the new teardown drain, then drain any in-flight packets when the
scheduler is destroyed so buffers are not leaked or left stuck in the
hardware channel.

For push mode, destroy now walks each lcore that has an active portal:
it repeatedly dequeues and frees frames from the software portal
(dpaa2_scheduler_dpio_drain), clears the push enable, and removes the
DPCON static dequeue channel before the DPCON and DPCI devices are
freed. A per-lcore dpio_dev array is added to struct dpaa2_sch_dev so
destroy can find the portal that was bound on first receive.

For pull mode, destroy repeatedly calls the configured receive path and
frees the returned mbufs in bulk until the channel is empty
(dpaa2_scheduler_rx_pull_drain).

Any nonzero drained count is logged as a warning, and channel-removal
errors are propagated as the destroy return value while teardown still
completes.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_scheduler.c | 141 +++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 24 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
index 51956ac1e5..26e3f50cf7 100644
--- a/drivers/event/dpaa2/dpaa2_scheduler.c
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -43,6 +43,7 @@ struct dpaa2_sch_port_queue {
 struct dpaa2_sch_dev {
 	struct dpaa2_dpcon_dev *dpcon_dev[RTE_MAX_LCORE];
 	struct dpaa2_dpci_dev *dpci_dev[RTE_MAX_LCORE];
+	struct dpaa2_dpio_dev *dpio_dev[RTE_MAX_LCORE];
 	uint8_t linked[RTE_MAX_LCORE];
 	struct dpaa2_sch_port_queue port_queue[DPAA2_SCH_PORT_QUEUE_MAX_NUM];
 	uint8_t port_queue_num;
@@ -86,22 +87,68 @@ dpaa2_qbman_pull_desc_channel_set(struct qbman_pull_desc *pulldesc,
 		iova_storage, 1);
 }
 
+static inline struct rte_mbuf *
+dpaa2_scheduler_swp_mbuf_dq(struct qbman_swp *swp)
+{
+	const struct qbman_result *dq;
+	const struct qbman_fd *fd;
+	struct dpaa2_queue *rxq;
+	struct dpaa2_dev_priv *priv;
+	struct rte_mbuf *mbuf;
+
+	dq = qbman_swp_dqrr_next(swp);
+	if (!dq)
+		return NULL;
+
+	qbman_swp_prefetch_dqrr_next(swp);
+	fd = qbman_result_DQ_fd(dq);
+	rxq = (void *)qbman_result_DQ_fqd_ctx(dq);
+	priv = rxq->eth_data->dev_private;
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		mbuf = dpaa2_eth_sg_fd_to_mbuf_export(priv, fd);
+	else
+		mbuf = dpaa2_eth_fd_to_mbuf_export(priv, fd);
+	dpaa2_dev_rx_mbuf_flc_offload_export(mbuf, fd);
+	dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
+	qbman_swp_dqrr_consume(swp, dq);
+
+	return mbuf;
+}
+
+static uint32_t
+dpaa2_scheduler_dpio_drain(struct dpaa2_dpio_dev *dpio_dev)
+{
+	struct qbman_swp *swp;
+	uint32_t num_pkts = 0;
+	int max_drain = 1000;
+	struct rte_mbuf *mbuf;
+
+	swp = dpio_dev->sw_portal;
+
+	while (max_drain--) {
+		mbuf = dpaa2_scheduler_swp_mbuf_dq(swp);
+		if (!mbuf)
+			break;
+		rte_pktmbuf_free(mbuf);
+		num_pkts++;
+		rte_delay_ms(1);
+	}
+
+	return num_pkts;
+}
+
 static uint16_t
 dpaa2_scheduler_dpci_recv(struct dpaa2_sch_dev *sch_dev,
 	struct rte_mbuf **mbuf, uint16_t nb_pkts)
 {
-	const struct qbman_result *dq;
 	struct dpaa2_dpcon_dev *dpcon_dev;
 	struct dpaa2_dpci_dev *dpci_dev;
 	struct dpaa2_dpio_dev *dpio_dev;
 	struct qbman_swp *swp;
-	const struct qbman_fd *fd;
-	struct dpaa2_queue *rxq;
 	struct dpaa2_sch_port_queue *port_queue;
 	struct rte_event_eth_rx_adapter_queue_conf *queue_conf;
 	uint16_t num_pkts = 0, i = 0;
 	int ret;
-	struct dpaa2_dev_priv *priv;
 	uint32_t cpu = rte_lcore_id();
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
@@ -158,30 +205,17 @@ dpaa2_scheduler_dpci_recv(struct dpaa2_sch_dev *sch_dev,
 
 	qbman_swp_push_set(swp, dpcon_dev->channel_index, 1);
 	sch_dev->linked[cpu] = sch_dev->port_queue_num;
+	sch_dev->dpio_dev[cpu] = dpio_dev;
 
 start_dq:
-	do {
-		dq = qbman_swp_dqrr_next(swp);
-		if (!dq)
-			goto quit;
-
-		qbman_swp_prefetch_dqrr_next(swp);
-
-		fd = qbman_result_DQ_fd(dq);
-		rxq = (void *)qbman_result_DQ_fqd_ctx(dq);
-		priv = rxq->eth_data->dev_private;
-		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-			mbuf[num_pkts] = dpaa2_eth_sg_fd_to_mbuf_export(priv, fd);
+	while (num_pkts < nb_pkts) {
+		mbuf[num_pkts] = dpaa2_scheduler_swp_mbuf_dq(swp);
+		if (likely(mbuf[num_pkts]))
+			num_pkts++;
 		else
-			mbuf[num_pkts] = dpaa2_eth_fd_to_mbuf_export(priv, fd);
-		dpaa2_dev_rx_mbuf_flc_offload_export(mbuf[num_pkts], fd);
-		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf[num_pkts]);
-		qbman_swp_dqrr_consume(swp, dq);
-
-		num_pkts++;
-	} while (num_pkts < nb_pkts);
+			break;
+	}
 
-quit:
 	return num_pkts;
 }
 
@@ -490,6 +524,54 @@ int rte_dpaa2_scheduler_start(void *scheduler_handle)
 	return ret;
 }
 
+static int
+dpaa2_scheduler_rx_core_push_drain(struct dpaa2_sch_dev *sch_dev, uint16_t core)
+{
+	struct dpaa2_dpio_dev *dpio_dev;
+	struct dpaa2_dpcon_dev *dpcon_dev;
+	uint16_t drain_num;
+	int ret;
+
+	if (!sch_dev->dpio_dev[core])
+		return 0;
+
+	dpio_dev = sch_dev->dpio_dev[core];
+	dpcon_dev = sch_dev->dpcon_dev[core];
+	if (!dpcon_dev)
+		return -ENODEV;
+	drain_num = dpaa2_scheduler_dpio_drain(dpio_dev);
+	if (drain_num > 0)
+		DPAA2_EVENTDEV_WARN("Drain %d buffer(s) from core%d", drain_num, core);
+
+	qbman_swp_push_set(dpio_dev->sw_portal, dpcon_dev->channel_index, 0);
+	ret = dpio_remove_static_dequeue_channel(dpio_dev->dpio,
+		0, dpio_dev->token, dpcon_dev->dpcon_id);
+	if (ret)
+		DPAA2_EVENTDEV_ERR("Failed(%d) to remove channel on core%d", ret, core);
+
+	return ret;
+}
+
+static void
+dpaa2_scheduler_rx_pull_drain(struct dpaa2_sch_dev *sch_dev)
+{
+	uint16_t drain_num = 0, rx;
+	struct rte_mbuf *mbufs[16];
+	int max_drain = 1000;
+
+rx_again:
+	rx = sch_dev->rx_schedule(sch_dev, mbufs, 16);
+	rte_pktmbuf_free_bulk(mbufs, rx);
+	drain_num += rx;
+	if (rx > 0 && max_drain > 0) {
+		rte_delay_ms(1);
+		max_drain--;
+		goto rx_again;
+	}
+	if (drain_num > 0)
+		DPAA2_EVENTDEV_WARN("Drain %d buffer(s) from scheduler.", drain_num);
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_destroy, 26.11)
 int rte_dpaa2_scheduler_destroy(void *scheduler_handle)
 {
@@ -498,6 +580,17 @@ int rte_dpaa2_scheduler_destroy(void *scheduler_handle)
 	struct dpaa2_dpci_dev *dpci_dev;
 	int32_t ret = 0, _ret, i;
 
+	if (sch_dev->sch_mode == RTE_DPAA2_SCH_PUSH) {
+		/** Make sure all data threads quit.*/
+		for (i = 0; i < RTE_MAX_LCORE; i++) {
+			_ret = dpaa2_scheduler_rx_core_push_drain(sch_dev, i);
+			if (_ret)
+				ret = _ret;
+		}
+	} else {
+		dpaa2_scheduler_rx_pull_drain(sch_dev);
+	}
+
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		dpcon_dev = sch_dev->dpcon_dev[i];
 		dpci_dev = sch_dev->dpci_dev[i];
-- 
2.43.0

