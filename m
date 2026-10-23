Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE79606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A768406B8;
	Fri, 23 Oct 2026 15:44:41 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D341140E21
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:29 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B577D20003F;
 Fri, 23 Oct 2026 15:44:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5901220002B;
 Fri, 23 Oct 2026 15:44:29 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 075DB1800068;
 Fri, 23 Oct 2026 21:44:27 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 34/65] event/dpaa2: add DPCON based standalone Rx
 scheduler
Date: Fri, 23 Oct 2026 19:13:14 +0530
Message-ID: <20261023134346.37727-35-prashant.gupta_3@nxp.com>
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

Add a standalone DPCON-based Rx scheduler API that lets applications
aggregate multiple ethdev Rx queues onto a single DPCON channel and
receive packets directly, without going through the eventdev framework.

The new API is exposed as experimental in rte_pmd_dpaa2.h:

- rte_dpaa2_scheduler_init():     allocate a DPCON device and select the
                                  receive path (plain or prefetch, chosen
                                  by the DPAA2_SCHEDULE_RX_PREFETCH env).
- rte_dpaa2_scheduler_add():      attach an ethdev Rx queue to the DPCON
                                  channel with a given priority.
- rte_dpaa2_scheduler_start():    enable the DPCON channel.
- rte_dpaa2_scheduler_rx():       dequeue packets from the channel.
- rte_dpaa2_scheduler_destroy():  disable the DPCON channel.
- rte_dpaa2_scheduler_max_prio(): Get the maximum supported priority.
                                  The priority specified in
                                  rte_dpaa2_scheduler_add() must not
                                  exceed this value.

Two receive implementations are provided: a plain single-buffer pull
(dpaa2_scheduler_recv) and a double-buffered prefetch variant
(dpaa2_scheduler_prefetch_recv) that overlaps the next pull with mbuf
extraction.

To support this, the fslmc bus exposes internal helpers
rte_dpaa2_dpcon_start()/stop() to enable/disable a DPCON, extends
struct dpaa2_dpcon_dev with per-lcore dequeue storage and an rx_schedule
callback, and caches the dequeue storage IOVA in
struct queue_storage_info_t to avoid repeated address translation on the
receive path.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c |  25 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c  |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h   |   5 +
 drivers/event/dpaa2/dpaa2_scheduler.c     | 458 ++++++++++++++++++++++
 drivers/event/dpaa2/meson.build           |   3 +-
 drivers/net/dpaa2/dpaa2_ethdev.c          |   4 +-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  38 ++
 drivers/net/dpaa2/dpaa2_rxtx.c            |  21 +
 drivers/net/dpaa2/rte_pmd_dpaa2.h         |  28 ++
 9 files changed, 579 insertions(+), 5 deletions(-)
 create mode 100644 drivers/event/dpaa2/dpaa2_scheduler.c

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
index eff8bc2445..400fb35c46 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017, 2020, 2023 NXP
+ *   Copyright 2017, 2020, 2023, 2026 NXP
  *
  */
 
@@ -121,6 +121,29 @@ void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_dpcon_start)
+int32_t rte_dpaa2_dpcon_start(struct dpaa2_dpcon_dev *dpcon_dev)
+{
+	int32_t ret;
+
+	ret = dpcon_enable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
+	if (ret)
+		DPAA2_BUS_ERR("Failed(%d) to enable dpcon.%d", ret, dpcon_dev->dpcon_id);
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_dpcon_stop)
+int32_t rte_dpaa2_dpcon_stop(struct dpaa2_dpcon_dev *dpcon_dev)
+{
+	int32_t ret;
+
+	ret = dpcon_disable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
+	if (ret)
+		DPAA2_BUS_ERR("Failed(%d) to disable dpcon.%d", ret, dpcon_dev->dpcon_id);
+
+	return ret;
+}
 
 static void
 rte_dpaa2_close_dpcon_device(int object_id)
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e88334088b..55dcef41d1 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -692,6 +692,8 @@ dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage)
 			RTE_CACHE_LINE_SIZE);
 		if (!q_storage->dq_storage[i])
 			goto fail;
+		q_storage->iova_dq_storage[i] =
+			DPAA2_VADDR_TO_IOVA(q_storage->dq_storage[i]);
 	}
 	return 0;
 fail:
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index f80abffb40..b00e52a9b7 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -152,6 +152,7 @@ struct dpaa2_dpbp_dev {
 
 struct queue_storage_info_t {
 	struct qbman_result *dq_storage[NUM_DQS_PER_QUEUE];
+	uint64_t iova_dq_storage[NUM_DQS_PER_QUEUE];
 	struct qbman_result *active_dqs;
 	uint8_t active_dpio_id;
 	uint8_t toggle;
@@ -297,6 +298,10 @@ __rte_internal
 struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void);
 __rte_internal
 void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon);
+__rte_internal
+int32_t rte_dpaa2_dpcon_start(struct dpaa2_dpcon_dev *dpcon_dev);
+__rte_internal
+int32_t rte_dpaa2_dpcon_stop(struct dpaa2_dpcon_dev *dpcon_dev);
 
 /* Refer to Table 7-3 in SEC BG */
 #define QBMAN_FLE_WORD4_FMT_SBF 0x0    /* Single buffer frame */
diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
new file mode 100644
index 0000000000..e553c4d3f6
--- /dev/null
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -0,0 +1,458 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <string.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <rte_malloc.h>
+#include <rte_memcpy.h>
+#include <rte_string_fns.h>
+#include <rte_cycles.h>
+#include <rte_kvargs.h>
+#include <eal_export.h>
+#include <dev_driver.h>
+#include <ethdev_driver.h>
+#include <rte_event_eth_rx_adapter.h>
+
+#include <bus_fslmc_driver.h>
+#include <mc/fsl_dpcon.h>
+#include <portal/dpaa2_hw_pvt.h>
+#include <dpaa2_hw_dpio.h>
+#include <compat.h>
+#include "dpaa2_ethdev.h"
+#include "dpaa2_eventdev.h"
+#include "dpaa2_eventdev_logs.h"
+#include "rte_pmd_dpaa2.h"
+
+#define DPAA2_SCH_PORT_QUEUE_MAX_NUM 64
+struct dpaa2_sch_port_queue {
+	struct rte_eth_dev *eth_dev;
+	uint16_t port_id;
+	uint16_t rxq_id;
+	uint8_t priority;
+	struct rte_event_eth_rx_adapter_queue_conf queue_conf;
+	int configured;
+};
+
+struct dpaa2_sch_dev {
+	struct dpaa2_dpcon_dev *dpcon_dev;
+	struct dpaa2_sch_port_queue port_queue[DPAA2_SCH_PORT_QUEUE_MAX_NUM];
+	uint8_t port_queue_num;
+	struct queue_storage_info_t q_storage[RTE_MAX_LCORE];
+	uint16_t (*rx_schedule)(struct dpaa2_sch_dev *dev,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+};
+
+static int
+dpaa2_scheduler_dq_storage_init(struct dpaa2_sch_dev *sch_dev)
+{
+	int i, ret = 0;
+
+	memset(&sch_dev->q_storage, 0,
+		sizeof(struct queue_storage_info_t) * RTE_MAX_LCORE);
+
+	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		ret = dpaa2_alloc_dq_storage(&sch_dev->q_storage[i]);
+		if (ret)
+			goto err;
+	}
+	return 0;
+err:
+	for (i = 0; i < RTE_MAX_LCORE; i++)
+		dpaa2_free_dq_storage(&sch_dev->q_storage[i]);
+
+	return ret;
+}
+
+static inline void
+dpaa2_qbman_pull_desc_channel_set(struct qbman_pull_desc *pulldesc,
+	uint32_t num, uint16_t ch_id, struct qbman_result *dq_sch_storage,
+	uint64_t iova_storage)
+{
+	qbman_pull_desc_clear(pulldesc);
+	qbman_pull_desc_set_numframes(pulldesc, num);
+	qbman_pull_desc_set_channel(pulldesc, ch_id,
+		qbman_pull_type_prio);
+	qbman_pull_desc_set_storage(pulldesc, dq_sch_storage,
+		iova_storage, 1);
+}
+
+static uint16_t
+dpaa2_scheduler_recv(struct dpaa2_sch_dev *sch_dev,
+	struct rte_mbuf **mbuf, uint16_t nb_pkts)
+{
+	struct dpaa2_dpcon_dev *dpcon_dev = sch_dev->dpcon_dev;
+	uint16_t ch_id = dpcon_dev->qbman_ch_id;
+	struct qbman_result *dq_sch_storage;
+	uint16_t total_nb_pkts = nb_pkts;
+	struct qbman_pull_desc pulldesc;
+	const struct qbman_fd *fd;
+	struct dpaa2_queue *rvq;
+	bool is_last, next_pull;
+	int ret, rcvd_pkts = 0;
+	struct qbman_swp *swp;
+	uint8_t status;
+	struct queue_storage_info_t *q_storage;
+	uint64_t iova_storage;
+	struct dpaa2_dev_priv *priv;
+
+	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+		ret = dpaa2_affine_qbman_ethrx_swp();
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failure(%d) in affining portal", ret);
+			return 0;
+		}
+	}
+	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+	q_storage = &sch_dev->q_storage[rte_lcore_id()];
+	dq_sch_storage = q_storage->dq_storage[0];
+	iova_storage = q_storage->iova_dq_storage[0];
+
+	do {
+		is_last = false;
+		next_pull = false;
+		dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts, ch_id,
+			dq_sch_storage, iova_storage);
+
+		while (1) {
+			if (qbman_swp_pull(swp, &pulldesc)) {
+				DPAA2_EVENTDEV_DEBUG("Line(%d): QBMAN is busy", __LINE__);
+				/* Portal was busy, try again */
+				continue;
+			}
+			break;
+		}
+		/* Receive the packets till Last Dequeue entry is found with
+		 * respect to the above issues PULL command.
+		 */
+		while (!is_last) {
+			/* Loop until the dq_storage is updated with
+			 * new result by QBMAN
+			 */
+			while (!qbman_result_has_new_result(swp, dq_sch_storage))
+				;
+
+			/* Check whether Last Pull command is Expired and
+			 * setting Condition for Loop termination
+			 */
+			if (qbman_result_DQ_is_pull_complete(dq_sch_storage)) {
+				is_last = true;
+				/* Check for valid frame. */
+				status = qbman_result_DQ_flags(dq_sch_storage);
+				if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME))) {
+					next_pull = true;
+					DPAA2_EVENTDEV_DEBUG("No frame is delivered");
+					break;
+				}
+				nb_pkts = total_nb_pkts - (rcvd_pkts + 1);
+				if (!nb_pkts)
+					next_pull = true;
+			}
+
+			fd = qbman_result_DQ_fd(dq_sch_storage);
+			rvq = (void *)qbman_result_DQ_fqd_ctx(dq_sch_storage);
+			priv = rvq->eth_data->dev_private;
+			if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+				mbuf[rcvd_pkts] = dpaa2_eth_sg_fd_to_mbuf_export(priv, fd);
+			else
+				mbuf[rcvd_pkts] = dpaa2_eth_fd_to_mbuf_export(priv, fd);
+			dpaa2_dev_rx_mbuf_flc_offload_export(mbuf[rcvd_pkts], fd);
+			dpaa2_dev_rx_print_parser_result(priv, fd, mbuf[rcvd_pkts]);
+			rcvd_pkts++;
+			dq_sch_storage++;
+			iova_storage += sizeof(struct qbman_result);
+		}
+	} while (!next_pull);
+	/* End of Packet Rx loop */
+	DPAA2_EVENTDEV_DEBUG("DPCONC Received %d Packets", rcvd_pkts);
+
+	return rcvd_pkts;
+}
+
+static uint16_t
+dpaa2_scheduler_prefetch_recv(struct dpaa2_sch_dev *sch_dev,
+	struct rte_mbuf **mbuf, uint16_t nb_pkts)
+{
+	struct dpaa2_dpcon_dev *dpcon_dev = sch_dev->dpcon_dev;
+	uint16_t ch_id = dpcon_dev->qbman_ch_id, pull_size;
+	struct qbman_result *dq_storage, *dq_storage1 = NULL, *active;
+	struct qbman_pull_desc pulldesc;
+	struct queue_storage_info_t *q_storage;
+	uint64_t iova_storage;
+	const struct qbman_fd *fd;
+	struct dpaa2_queue *rvq;
+	int ret, rcvd_pkts = 0;
+	struct qbman_swp *swp;
+	struct dpaa2_dpio_dev *ethrx_dpio_dev;
+	uint8_t status, pending;
+	struct dpaa2_dev_priv *priv;
+
+	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+		ret = dpaa2_affine_qbman_ethrx_swp();
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failure(%d) in affining portal", ret);
+			return 0;
+		}
+	}
+	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+	ethrx_dpio_dev = DPAA2_PER_LCORE_ETHRX_DPIO;
+	q_storage = &sch_dev->q_storage[rte_lcore_id()];
+
+	pull_size = (nb_pkts > dpaa2_dqrr_size) ?
+		dpaa2_dqrr_size : nb_pkts;
+	if (likely(q_storage->active_dqs))
+		goto pull_active_dqs;
+
+	q_storage->toggle = 0;
+	dq_storage = q_storage->dq_storage[q_storage->toggle];
+	iova_storage = q_storage->iova_dq_storage[q_storage->toggle];
+	q_storage->last_num_pkts = pull_size;
+	dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts,
+		ch_id, dq_storage, iova_storage);
+	if (check_swp_active_dqs(ethrx_dpio_dev->index)) {
+		do {
+			active = get_swp_active_dqs(ethrx_dpio_dev->index);
+			if (qbman_check_command_complete(active))
+				break;
+		} while (1);
+		clear_swp_active_dqs(ethrx_dpio_dev->index);
+	}
+	while (1) {
+		if (qbman_swp_pull(swp, &pulldesc)) {
+			DPAA2_EVENTDEV_DEBUG("Line(%d): QBMAN is busy", __LINE__);
+			/* Portal was busy, try again */
+			continue;
+		}
+		break;
+	}
+	q_storage->active_dqs = dq_storage;
+	q_storage->active_dpio_id = ethrx_dpio_dev->index;
+	set_swp_active_dqs(ethrx_dpio_dev->index, dq_storage);
+
+pull_active_dqs:
+
+	dq_storage = q_storage->active_dqs;
+	rte_prefetch0((void *)(size_t)(dq_storage));
+	rte_prefetch0((void *)(size_t)(dq_storage + 1));
+
+	/* Prepare next pull descriptor. This will give space for the
+	 * prefetching done on DQRR entries
+	 */
+	q_storage->toggle ^= 1;
+	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
+	iova_storage = q_storage->iova_dq_storage[q_storage->toggle];
+	dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts,
+		ch_id, dq_storage1, iova_storage);
+
+	while (!qbman_check_command_complete(dq_storage))
+		;
+	active = get_swp_active_dqs(q_storage->active_dpio_id);
+	if (dq_storage == active)
+		clear_swp_active_dqs(q_storage->active_dpio_id);
+
+	pending = 1;
+
+	do {
+		/* Loop until the dq_storage is updated with
+		 * new token by QBMAN
+		 */
+		while (!qbman_check_new_result(dq_storage))
+			;
+		rte_prefetch0((void *)((size_t)(dq_storage + 2)));
+		/* Check whether Last Pull command is Expired and
+		 * setting Condition for Loop termination
+		 */
+		if (qbman_result_DQ_is_pull_complete(dq_storage)) {
+			pending = 0;
+			/* Check for valid frame. */
+			status = qbman_result_DQ_flags(dq_storage);
+			if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME)))
+				continue;
+		}
+
+		fd = qbman_result_DQ_fd(dq_storage);
+		rvq = (void *)qbman_result_DQ_fqd_ctx(dq_storage);
+		priv = rvq->eth_data->dev_private;
+		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+			mbuf[rcvd_pkts] = dpaa2_eth_sg_fd_to_mbuf_export(priv, fd);
+		else
+			mbuf[rcvd_pkts] = dpaa2_eth_fd_to_mbuf_export(priv, fd);
+		dpaa2_dev_rx_mbuf_flc_offload_export(mbuf[rcvd_pkts], fd);
+		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf[rcvd_pkts]);
+		rcvd_pkts++;
+
+		dq_storage++;
+	} while (pending);
+
+	if (check_swp_active_dqs(ethrx_dpio_dev->index)) {
+		do {
+			active = get_swp_active_dqs(ethrx_dpio_dev->index);
+			if (qbman_check_command_complete(active))
+				break;
+		} while (1);
+		clear_swp_active_dqs(ethrx_dpio_dev->index);
+	}
+	/* issue a volatile dequeue command for next pull */
+	while (1) {
+		if (qbman_swp_pull(swp, &pulldesc)) {
+			DPAA2_EVENTDEV_DEBUG("Line(%d): QBMAN is busy", __LINE__);
+			continue;
+		}
+		break;
+	}
+	q_storage->active_dqs = dq_storage1;
+	q_storage->active_dpio_id = ethrx_dpio_dev->index;
+	set_swp_active_dqs(ethrx_dpio_dev->index, dq_storage1);
+
+	return rcvd_pkts;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_init, 26.11)
+void *rte_dpaa2_scheduler_init(void)
+{
+	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
+	struct dpaa2_sch_dev *sch_dev = NULL;
+	char *env = getenv("DPAA2_SCHEDULE_RX_PREFETCH");
+	int prefetch_enable = env ? atoi(env) : 1, ret, i;
+
+	sch_dev = rte_zmalloc(NULL, sizeof(struct dpaa2_sch_dev), 0);
+	if (!sch_dev) {
+		DPAA2_EVENTDEV_ERR("Failed alloc scheduler device!!");
+		goto err;
+	}
+
+	ret = dpaa2_scheduler_dq_storage_init(sch_dev);
+	if (ret)
+		goto err;
+
+	dpcon_dev = rte_dpaa2_alloc_dpcon_dev();
+	if (!dpcon_dev) {
+		DPAA2_EVENTDEV_ERR("Failed alloc dpcon device!!");
+		goto err;
+	}
+	sch_dev->dpcon_dev = dpcon_dev;
+	if (prefetch_enable)
+		sch_dev->rx_schedule = dpaa2_scheduler_prefetch_recv;
+	else
+		sch_dev->rx_schedule = dpaa2_scheduler_recv;
+
+	return sch_dev;
+err:
+	if (dpcon_dev)
+		rte_dpaa2_free_dpcon_dev(dpcon_dev);
+	if (sch_dev) {
+		for (i = 0; i < RTE_MAX_LCORE; i++)
+			dpaa2_free_dq_storage(&sch_dev->q_storage[i]);
+		rte_free(sch_dev);
+	}
+
+	return NULL;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_start, 26.11)
+int rte_dpaa2_scheduler_start(void *scheduler_handle)
+{
+	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
+	int32_t ret = 0;
+
+	if (sch_dev->dpcon_dev) {
+		ret = rte_dpaa2_dpcon_start(sch_dev->dpcon_dev);
+		if (ret)
+			DPAA2_EVENTDEV_ERR("Failed(%d) to start dpcon", ret);
+	} else {
+		DPAA2_EVENTDEV_ERR("No dpcon allocated");
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_destroy, 26.11)
+int rte_dpaa2_scheduler_destroy(void *scheduler_handle)
+{
+	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
+	int32_t ret = 0;
+
+	if (sch_dev->dpcon_dev) {
+		ret = rte_dpaa2_dpcon_stop(sch_dev->dpcon_dev);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failed(%d) to stop dpcon", ret);
+			/** Free anyway.*/
+		}
+		rte_dpaa2_free_dpcon_dev(sch_dev->dpcon_dev);
+	}
+
+	rte_free(sch_dev);
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_add, 26.11)
+int rte_dpaa2_scheduler_add(void *scheduler_handle,
+	uint16_t port_id, uint16_t rxq_id, uint8_t priority)
+{
+	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
+	struct dpaa2_dpcon_dev *dpcon_dev;
+	struct rte_eth_dev *dev;
+	struct dpaa2_dev_priv *priv;
+	struct rte_event_eth_rx_adapter_queue_conf queue_conf;
+	int ret;
+
+	if (!rte_pmd_dpaa2_dev_is_dpaa2(port_id))
+		return -ENODEV;
+
+	dev = &rte_eth_devices[port_id];
+	priv = dev->data->dev_private;
+	if (rxq_id >= priv->nb_rx_queues) {
+		DPAA2_EVENTDEV_ERR("rxq_id(%d) >= queue number(%d)",
+			rxq_id, priv->nb_rx_queues);
+		return -EINVAL;
+	}
+
+	if (sch_dev->port_queue_num >= DPAA2_SCH_PORT_QUEUE_MAX_NUM) {
+		DPAA2_EVENTDEV_ERR("Too many schedule queues");
+		return -EINVAL;
+	}
+
+	memset(&queue_conf, 0, sizeof(struct rte_event_eth_rx_adapter_queue_conf));
+	dpcon_dev = sch_dev->dpcon_dev;
+	dpaa2_eth_eventq_prio_dpcon_to_ev(priority, dpcon_dev, &queue_conf);
+	queue_conf.ev.sched_type = RTE_SCHED_TYPE_PARALLEL;
+	ret = dpaa2_eth_eventq_attach(dev, rxq_id, dpcon_dev, &queue_conf);
+	if (!ret) {
+		sch_dev->port_queue[sch_dev->port_queue_num].eth_dev = dev;
+		sch_dev->port_queue[sch_dev->port_queue_num].rxq_id = rxq_id;
+		sch_dev->port_queue[sch_dev->port_queue_num].priority = priority;
+		rte_memcpy(&sch_dev->port_queue[sch_dev->port_queue_num].queue_conf,
+			&queue_conf, sizeof(struct rte_event_eth_rx_adapter_queue_conf));
+		sch_dev->port_queue[sch_dev->port_queue_num].configured = true;
+		sch_dev->port_queue_num++;
+	}
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_rx, 26.11)
+uint16_t
+rte_dpaa2_scheduler_rx(void *scheduler_handle, struct rte_mbuf **mbuf,
+	uint16_t nb_pkts)
+{
+	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
+
+	return sch_dev->rx_schedule(sch_dev, mbuf, nb_pkts);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_scheduler_max_prio, 26.11)
+uint16_t
+rte_dpaa2_scheduler_max_prio(void *scheduler_handle)
+{
+	struct dpaa2_sch_dev *sch_dev = scheduler_handle;
+
+	return sch_dev->dpcon_dev->num_priorities;
+}
diff --git a/drivers/event/dpaa2/meson.build b/drivers/event/dpaa2/meson.build
index 62b8507652..d4aca38d02 100644
--- a/drivers/event/dpaa2/meson.build
+++ b/drivers/event/dpaa2/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2018 NXP
+# Copyright 2018, 2026 NXP
 
 if not is_linux
     build = false
@@ -9,6 +9,7 @@ deps += ['bus_vdev', 'net_dpaa2', 'crypto_dpaa2_sec']
 sources = files(
         'dpaa2_eventdev.c',
         'dpaa2_eventdev_selftest.c',
+        'dpaa2_scheduler.c'
 )
 
 includes += include_directories('../../crypto/dpaa2_sec/')
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 552ac4c94d..849ab7049f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3332,14 +3332,12 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	else
 		return -EINVAL;
 
-	priority = (RTE_EVENT_DEV_PRIORITY_LOWEST / queue_conf->ev.priority) *
-		   (dpcon->num_priorities - 1);
-
 	if (!cfg) {
 		DPAA2_PMD_ERR("%s: %s-rxq%d was not setup yet!",
 			__func__, dev->data->name, eth_rx_queue_id);
 		return -EINVAL;
 	}
+	priority = dpaa2_eth_eventq_prio_ev_to_dpcon(dpcon, queue_conf);
 	options = DPNI_QUEUE_OPT_DEST;
 	cfg->destination.type = DPNI_DEST_DPCON;
 	cfg->destination.id = dpcon->dpcon_id;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index d46fbd6d7d..e4b896f17c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -908,6 +908,33 @@ dpaa2_dpkg_insert_extract(struct dpkg_profile_cfg *kg_cfg,
 	kg_cfg->num_extracts++;
 }
 
+static inline void
+dpaa2_eth_eventq_prio_dpcon_to_ev(uint8_t priority,
+	struct dpaa2_dpcon_dev *dpcon,
+	struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+{
+	uint8_t priority_step;
+	uint32_t priority_ev;
+
+	priority_step = (RTE_EVENT_DEV_PRIORITY_LOWEST + 1 -
+		RTE_EVENT_DEV_PRIORITY_HIGHEST) / dpcon->num_priorities;
+	priority_ev = priority * priority_step;
+	if (priority_ev > RTE_EVENT_DEV_PRIORITY_LOWEST)
+		priority_ev = RTE_EVENT_DEV_PRIORITY_LOWEST;
+	queue_conf->ev.priority = priority_ev;
+}
+
+static inline uint8_t
+dpaa2_eth_eventq_prio_ev_to_dpcon(struct dpaa2_dpcon_dev *dpcon,
+	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+{
+	uint8_t priority_step;
+
+	priority_step = (RTE_EVENT_DEV_PRIORITY_LOWEST + 1 -
+		RTE_EVENT_DEV_PRIORITY_HIGHEST) / dpcon->num_priorities;
+	return queue_conf->ev.priority / priority_step;
+}
+
 __rte_internal
 int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
@@ -971,5 +998,16 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 int dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev);
 int dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev);
 
+__rte_internal
+struct rte_mbuf *
+dpaa2_eth_fd_to_mbuf_export(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd);
+__rte_internal
+struct rte_mbuf *
+dpaa2_eth_sg_fd_to_mbuf_export(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd);
+__rte_internal
+void
+dpaa2_dev_rx_mbuf_flc_offload_export(struct rte_mbuf *m,
+	const struct qbman_fd *fd);
+
 int dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops);
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index d0d4536ab4..0d4fc18455 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -165,6 +165,13 @@ dpaa2_dev_rx_mbuf_flc_offload(struct rte_mbuf *m,
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_rx_mbuf_flc_offload_export)
+void dpaa2_dev_rx_mbuf_flc_offload_export(struct rte_mbuf *m,
+	const struct qbman_fd *fd)
+{
+	dpaa2_dev_rx_mbuf_flc_offload(m, fd);
+}
+
 static inline void
 dpaa2_dev_rx_read_timestamp(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *m)
@@ -479,6 +486,13 @@ dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	return (void *)first_seg;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_sg_fd_to_mbuf_export)
+struct rte_mbuf *
+dpaa2_eth_sg_fd_to_mbuf_export(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
+{
+	return dpaa2_eth_sg_fd_to_mbuf(priv, fd);
+}
+
 static inline struct rte_mbuf *__rte_hot
 dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
@@ -534,6 +548,13 @@ dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	return mbuf;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_fd_to_mbuf_export)
+struct rte_mbuf *
+dpaa2_eth_fd_to_mbuf_export(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
+{
+	return dpaa2_eth_fd_to_mbuf(priv, fd);
+}
+
 static void dpaa2_dev_tx_enable_tstamp(struct qbman_fd *fd)
 {
 	struct dpaa2_faead *fd_faead;
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index b28962c5f8..eb038011c9 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -129,6 +129,34 @@ int
 rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
 	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off);
 
+__rte_experimental
+void *
+rte_dpaa2_scheduler_init(void);
+__rte_experimental
+int
+rte_dpaa2_scheduler_start(void *scheduler_handle);
+__rte_experimental
+int
+rte_dpaa2_scheduler_destroy(void *scheduler_handle);
+__rte_experimental
+uint16_t
+rte_dpaa2_scheduler_max_prio(void *scheduler_handle);
+__rte_experimental
+int
+rte_dpaa2_scheduler_add(void *scheduler_handle,
+	uint16_t port_id, uint16_t rxq_id, uint8_t priority);
+
+/* rte_dpaa2_scheduler_rx()- DPCON scheduler receive function
+ * @scheduler_handle: DPCON scheduler handle
+ * @mbuf:             Packet mbuf
+ * @nb_pkts:          Number of packets to be received.
+ * Return Number of received packet.
+ */
+__rte_experimental
+uint16_t
+rte_dpaa2_scheduler_rx(void *scheduler_handle, struct rte_mbuf **mbuf,
+	uint16_t nb_pkts);
+
 #define RTE_DPAA2_EVENT_PORT_CFG_ATOMIC RTE_BIT32(31)
 
 /** RTE_DPAA2_MIX_GROUP_FLOW has same behavio as RTE_DPAA2_FLAT_GROUP_FLOW*/
-- 
2.43.0

