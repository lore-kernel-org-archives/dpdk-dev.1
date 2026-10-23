Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FC606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D60C40E78;
	Fri, 23 Oct 2026 15:44:37 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 78A5E40E35
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:24 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 585C41A0021;
 Fri, 23 Oct 2026 15:44:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECC021A000A;
 Fri, 23 Oct 2026 15:44:23 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9396118000B7;
 Fri, 23 Oct 2026 21:44:22 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 29/65] bus/fslmc: support DPCI peer and dynamic queues
Date: Fri, 23 Oct 2026 19:13:09 +0530
Message-ID: <20261023134346.37727-30-prashant.gupta_3@nxp.com>
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

Add dpci_get_peer_attributes() to query the DPCI object a given DPCI is
connected to, and use it to fix the DPCI Tx fqid. A DPCI's Tx fqid only
equals its Rx fqid when the DPCI is self-connected; when it has a real
peer, the Tx fqids must come from dpci_get_tx_queue().

Rework DPCI device creation accordingly:

  - Replace the fixed DPAA2_DPCI_MAX_QUEUES arrays with dynamically
    allocated rx_queue/tx_queue arrays sized from the object's own
    num_of_priorities and the peer's num_of_priorities.
  - Determine the peer via dpci_get_peer_attributes(); fall back to
    self-connection when no peer is present.
  - Use rte_zmalloc for the node, zero the attribute structs, and
    replace the single err label with staged open_err/queue_err/
    enable_err cleanup that closes/disables and frees only what was
    allocated.
  - Rename the internal create/close callbacks to the dpaa2_ prefix.

Add rte_dpaa2_dpci_link_attach() so a consumer can bind a free DPCI Rx
queue to a destination (e.g. a DPCON), install its dequeue callback and
obtain the matching peer Tx queue. The event PMD uses this in place of
its private dpaa2_eventdev_setup_dpci(): each event queue now tracks a
per-sched-type Tx queue array (dpci_txqs[]) and the owning event port,
and the enqueue path selects the Tx fqid by event->queue_id and
sched_type while validating port ownership.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/mc/dpci.c              |  37 +++-
 drivers/bus/fslmc/mc/fsl_dpci.h          |  12 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c | 225 ++++++++++++++++-------
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h  |  16 +-
 drivers/event/dpaa2/dpaa2_eventdev.c     | 122 ++++++------
 drivers/event/dpaa2/dpaa2_eventdev.h     |   8 +-
 6 files changed, 282 insertions(+), 138 deletions(-)

diff --git a/drivers/bus/fslmc/mc/dpci.c b/drivers/bus/fslmc/mc/dpci.c
index 4188325fb9..1588ba04c4 100644
--- a/drivers/bus/fslmc/mc/dpci.c
+++ b/drivers/bus/fslmc/mc/dpci.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2019 NXP
+ * Copyright 2017-2019, 2026 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -304,6 +304,41 @@ int dpci_get_attributes(struct fsl_mc_io *mc_io,
 	return 0;
 }
 
+/**
+ * dpci_get_peer_attributes() - Retrieve DPCI peer attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPCI object
+ * @attr:	Returned DPCI peer's attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpci_get_peer_attributes(struct fsl_mc_io *mc_io,
+			uint32_t cmd_flags,
+			uint16_t token,
+			struct dpci_peer_attr *attr)
+{
+	struct dpci_rsp_get_attr *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPCI_CMDID_GET_PEER_ATTR,
+					cmd_flags, token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpci_rsp_get_attr *)cmd.params;
+	attr->peer_id = le32_to_cpu(rsp_params->id);
+	attr->num_of_priorities = rsp_params->num_of_priorities;
+
+	return 0;
+}
+
 /**
  * dpci_set_rx_queue() - Set Rx queue configuration
  * @mc_io:	Pointer to MC portal's I/O object
diff --git a/drivers/bus/fslmc/mc/fsl_dpci.h b/drivers/bus/fslmc/mc/fsl_dpci.h
index 55b67244c1..a1fb747011 100644
--- a/drivers/bus/fslmc/mc/fsl_dpci.h
+++ b/drivers/bus/fslmc/mc/fsl_dpci.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2019 NXP
+ * Copyright 2017-2019, 2026 NXP
  *
  */
 #ifndef __FSL_DPCI_H
@@ -111,6 +111,16 @@ int dpci_get_attributes(struct fsl_mc_io *mc_io,
 			uint16_t token,
 			struct dpci_attr *attr);
 
+struct dpci_peer_attr {
+	int peer_id;
+	uint8_t num_of_priorities;
+};
+
+int dpci_get_peer_attributes(struct fsl_mc_io *mc_io,
+			uint32_t cmd_flags,
+			uint16_t token,
+			struct dpci_peer_attr *attr);
+
 /**
  * enum dpci_dest - DPCI destination types
  * @DPCI_DEST_NONE:	Unassigned destination; The queue is set in parked mode
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index 20371fe062..f2bfb2a75c 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017, 2020, 2023 NXP
+ *   Copyright 2017, 2020, 2023, 2026 NXP
  *
  */
 
@@ -45,19 +45,23 @@ static struct dpaa2_dpci_dev *get_dpci_from_id(uint32_t dpci_id)
 }
 
 static int
-rte_dpaa2_create_dpci_device(int vdev_fd __rte_unused,
+dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 	struct vfio_device_info *obj_info __rte_unused,
 	struct rte_dpaa2_device *obj)
 {
 	struct dpaa2_dpci_dev *dpci_node;
 	struct dpci_attr attr;
+	struct dpci_peer_attr peer_attr;
 	struct dpci_rx_queue_cfg rx_queue_cfg;
 	struct dpci_rx_queue_attr rx_attr;
 	struct dpci_tx_queue_attr tx_attr;
 	int ret, i, dpci_id = obj->object_id;
 
+	memset(&attr, 0, sizeof(struct dpci_attr));
+	memset(&peer_attr, 0, sizeof(struct dpci_peer_attr));
+
 	/* Allocate DPAA2 dpci handle */
-	dpci_node = rte_malloc(NULL, sizeof(struct dpaa2_dpci_dev), 0);
+	dpci_node = rte_zmalloc(NULL, sizeof(struct dpaa2_dpci_dev), 0);
 	if (!dpci_node) {
 		DPAA2_BUS_ERR("Memory allocation failed for DPCI Device");
 		return -ENOMEM;
@@ -65,88 +69,119 @@ rte_dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 
 	/* Open the dpci object */
 	dpci_node->dpci.regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
-	ret = dpci_open(&dpci_node->dpci,
-			CMD_PRI_LOW, dpci_id, &dpci_node->token);
+	ret = dpci_open(&dpci_node->dpci, CMD_PRI_LOW, dpci_id, &dpci_node->token);
 	if (ret) {
 		DPAA2_BUS_ERR("Resource alloc failure with err code: %d", ret);
-		goto err;
+		goto open_err;
 	}
 
 	/* Get the device attributes */
 	ret = dpci_get_attributes(&dpci_node->dpci,
-				  CMD_PRI_LOW, dpci_node->token, &attr);
-	if (ret != 0) {
+		CMD_PRI_LOW, dpci_node->token, &attr);
+	if (ret) {
 		DPAA2_BUS_ERR("Reading device failed with err code: %d", ret);
-		goto err;
+		goto open_err;
+	} else {
+		if (dpci_id != attr.id) {
+			ret = -EINVAL;
+			goto open_err;
+		}
+		dpci_node->dpci_id = attr.id;
+		dpci_node->rx_queue_num = attr.num_of_priorities;
 	}
 
-	for (i = 0; i < DPAA2_DPCI_MAX_QUEUES; i++) {
-		struct dpaa2_queue *rxq;
+	if (dpci_node->rx_queue_num) {
+		dpci_node->rx_queue = rte_zmalloc(NULL,
+			sizeof(struct dpaa2_queue) * dpci_node->rx_queue_num, 0);
+		if (!dpci_node->rx_queue) {
+			DPAA2_BUS_ERR("DPCI.%d alloc rxq failed!", dpci_id);
+			ret = -ENOMEM;
+			goto open_err;
+		}
+	}
 
+	for (i = 0; i < dpci_node->rx_queue_num; i++) {
 		memset(&rx_queue_cfg, 0, sizeof(struct dpci_rx_queue_cfg));
-		ret = dpci_set_rx_queue(&dpci_node->dpci,
-					CMD_PRI_LOW,
-					dpci_node->token,
-					i, &rx_queue_cfg);
+		rx_queue_cfg.user_ctx = (uint64_t)&dpci_node->rx_queue[i];
+		rx_queue_cfg.dest_cfg.dest_type = DPCI_DEST_NONE;
+		ret = dpci_set_rx_queue(&dpci_node->dpci, CMD_PRI_LOW,
+			dpci_node->token, i, &rx_queue_cfg);
 		if (ret) {
-			DPAA2_BUS_ERR("Setting Rx queue failed with err code: %d",
-				      ret);
-			goto err;
+			DPAA2_BUS_ERR("Setting Rx queue failed with err code: %d", ret);
+			goto queue_err;
 		}
 
-		/* Allocate DQ storage for the DPCI Rx queues */
-		rxq = &dpci_node->rx_queue[i];
-		ret = dpaa2_queue_storage_alloc(rxq, 1);
-		if (ret)
-			goto err;
+		ret = dpci_get_rx_queue(&dpci_node->dpci, CMD_PRI_LOW,
+			dpci_node->token, i, &rx_attr);
+		if (ret) {
+			DPAA2_BUS_ERR("Rx queue fetch failed with err code: %d", ret);
+			goto queue_err;
+		}
+		dpci_node->rx_queue[i].fqid = rx_attr.fqid;
 	}
 
 	/* Enable the device */
-	ret = dpci_enable(&dpci_node->dpci,
-			  CMD_PRI_LOW, dpci_node->token);
-	if (ret != 0) {
+	ret = dpci_enable(&dpci_node->dpci, CMD_PRI_LOW, dpci_node->token);
+	if (ret) {
 		DPAA2_BUS_ERR("Enabling device failed with err code: %d", ret);
-		goto err;
-	}
-
-	for (i = 0; i < DPAA2_DPCI_MAX_QUEUES; i++) {
-		/* Get the Rx FQID's */
-		ret = dpci_get_rx_queue(&dpci_node->dpci,
-					CMD_PRI_LOW,
-					dpci_node->token, i,
-					&rx_attr);
-		if (ret != 0) {
-			DPAA2_BUS_ERR("Rx queue fetch failed with err code: %d",
-				      ret);
-			goto err;
+		goto enable_err;
+	}
+
+	ret = dpci_get_peer_attributes(&dpci_node->dpci,
+		CMD_PRI_LOW, dpci_node->token, &peer_attr);
+	if (ret) {
+		DPAA2_BUS_ERR("Getting peer failed with err code: %d", ret);
+		goto enable_err;
+	} else if (peer_attr.peer_id < 0) {
+		DPAA2_BUS_INFO("DPCI.%d has no peer, self connected.", dpci_node->dpci_id);
+		/** Connect to self.*/
+		dpci_node->peer_id = dpci_node->dpci_id;
+		dpci_node->tx_queue_num = dpci_node->rx_queue_num;
+	} else {
+		dpci_node->peer_id = peer_attr.peer_id;
+		dpci_node->tx_queue_num = peer_attr.num_of_priorities;
+	}
+
+	if (dpci_node->tx_queue_num) {
+		dpci_node->tx_queue = rte_zmalloc(NULL,
+			sizeof(struct dpaa2_queue) * dpci_node->tx_queue_num, 0);
+		if (!dpci_node->tx_queue) {
+			DPAA2_BUS_ERR("DPCI.%d alloc txq failed!", dpci_id);
+			ret = -ENOMEM;
+			goto enable_err;
 		}
-		dpci_node->rx_queue[i].fqid = rx_attr.fqid;
+	}
 
-		ret = dpci_get_tx_queue(&dpci_node->dpci,
-					CMD_PRI_LOW,
-					dpci_node->token, i,
-					&tx_attr);
-		if (ret != 0) {
-			DPAA2_BUS_ERR("Reading device failed with err code: %d",
-				      ret);
-			goto err;
+	for (i = 0; i < dpci_node->tx_queue_num; i++) {
+		if (dpci_node->peer_id != dpci_node->dpci_id) {
+			ret = dpci_get_tx_queue(&dpci_node->dpci, CMD_PRI_LOW,
+				dpci_node->token, i, &tx_attr);
+			if (ret) {
+				DPAA2_BUS_ERR("Tx queue fetch failed with err code: %d", ret);
+				goto enable_err;
+			}
+			dpci_node->tx_queue[i].fqid = tx_attr.fqid;
+		} else {
+			dpci_node->tx_queue[i].fqid = dpci_node->rx_queue[i].fqid;
 		}
-		dpci_node->tx_queue[i].fqid = tx_attr.fqid;
 	}
 
-	dpci_node->dpci_id = dpci_id;
 	rte_atomic_store_explicit(&dpci_node->in_use, 0, rte_memory_order_relaxed);
 
 	TAILQ_INSERT_TAIL(&dpci_dev_list, dpci_node, next);
 
 	return 0;
 
-err:
-	for (i = 0; i < DPAA2_DPCI_MAX_QUEUES; i++) {
-		struct dpaa2_queue *rxq = &dpci_node->rx_queue[i];
+enable_err:
+	if (dpci_node->tx_queue)
+		rte_free(dpci_node->tx_queue);
+	dpci_disable(&dpci_node->dpci, CMD_PRI_LOW, dpci_node->token);
+queue_err:
+	if (dpci_node->rx_queue)
+		rte_free(dpci_node->rx_queue);
+open_err:
+	dpci_close(&dpci_node->dpci, CMD_PRI_LOW, dpci_node->token);
 
-		dpaa2_queue_storage_free(rxq, 1);
-	}
 	rte_free(dpci_node);
 
 	return ret;
@@ -156,14 +191,13 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpci_dev)
 struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
+	uint16_t expected = 0;
 
 	/* Get DPCI dev handle from list using index */
 	TAILQ_FOREACH(dpci_dev, &dpci_dev_list, next) {
-		uint16_t expected = 0;
-
-		if (rte_atomic_compare_exchange_strong_explicit(&dpci_dev->in_use,
-				&expected, 1, rte_memory_order_acquire,
-				rte_memory_order_relaxed))
+		if (dpci_dev &&
+			rte_atomic_compare_exchange_strong_explicit(&dpci_dev->in_use,
+			&expected, 1, rte_memory_order_acquire, rte_memory_order_relaxed))
 			break;
 	}
 
@@ -178,33 +212,90 @@ void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci)
 	/* Match DPCI handle and mark it free */
 	TAILQ_FOREACH(dpci_dev, &dpci_dev_list, next) {
 		if (dpci_dev == dpci) {
-			rte_atomic_store_explicit(&dpci_dev->in_use, 0,
-						  rte_memory_order_release);
+			rte_atomic_fetch_sub_explicit(&dpci_dev->in_use, 1,
+				rte_memory_order_acq_rel);
 			return;
 		}
 	}
 }
 
-
 static void
-rte_dpaa2_close_dpci_device(int object_id)
+dpaa2_close_dpci_device(int object_id)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
 
 	dpci_dev = get_dpci_from_id((uint32_t)object_id);
 
 	if (dpci_dev) {
-		rte_dpaa2_free_dpci_dev(dpci_dev);
+		dpci_disable(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token);
+		rte_free(dpci_dev->rx_queue);
+		rte_free(dpci_dev->tx_queue);
 		dpci_close(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token);
 		TAILQ_REMOVE(&dpci_dev_list, dpci_dev, next);
 		rte_free(dpci_dev);
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_dpci_link_attach)
+int
+rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
+	enum dpci_dest dest_type, uint32_t dest_id, uint8_t priority,
+	dpaa2_queue_cb_dqrr_t *rx_cb, struct dpaa2_queue **txq)
+{
+	struct dpci_rx_queue_cfg rx_queue_cfg;
+	uint16_t i;
+	int ret;
+	struct dpaa2_dpci_dev *peer_dpci;
+
+	memset(&rx_queue_cfg, 0, sizeof(struct dpci_rx_queue_cfg));
+	if (dpci_dev->dpci_id == dpci_dev->peer_id) {
+		peer_dpci = dpci_dev;
+	} else {
+		peer_dpci = get_dpci_from_id(dpci_dev->peer_id);
+		if (!peer_dpci) {
+			DPAA2_BUS_ERR("Get peer of DPCI.%d failed",
+				dpci_dev->dpci_id);
+			return -ENODEV;
+		}
+	}
+
+	/*Do settings to get the frame on a DPCON object*/
+	rx_queue_cfg.options = DPCI_QUEUE_OPT_DEST |
+		  DPCI_QUEUE_OPT_USER_CTX;
+	rx_queue_cfg.dest_cfg.dest_type = dest_type;
+	rx_queue_cfg.dest_cfg.dest_id = dest_id;
+	rx_queue_cfg.dest_cfg.priority = priority;
+	rx_queue_cfg.order_preservation_en = 0;
+
+	for (i = 0; i < dpci_dev->rx_queue_num; i++) {
+		if (!dpci_dev->rx_queue[i].cb)
+			break;
+	}
+	if (i >= dpci_dev->rx_queue_num || i >= dpci_dev->tx_queue_num) {
+		DPAA2_BUS_ERR("DPCI.%d No queue pair available!", dpci_dev->dpci_id);
+		return -EBUSY;
+	}
+
+	rx_queue_cfg.user_ctx = (uint64_t)(&dpci_dev->rx_queue[i]);
+	ret = dpci_set_rx_queue(&dpci_dev->dpci, CMD_PRI_LOW,
+		dpci_dev->token, i, &rx_queue_cfg);
+	if (ret) {
+		DPAA2_BUS_ERR("DPCI.%d Rx queue%d setup failed: err(%d)",
+			dpci_dev->dpci_id, i, ret);
+		return ret;
+	}
+	dpci_dev->rx_queue[i].cb = rx_cb;
+
+	if (txq)
+		*txq = &dpci_dev->tx_queue[i];
+
+	return 0;
+}
+
 static struct rte_dpaa2_object rte_dpaa2_dpci_obj = {
 	.dev_type = DPAA2_CI,
-	.create = rte_dpaa2_create_dpci_device,
-	.close = rte_dpaa2_close_dpci_device,
+	.create = dpaa2_create_dpci_device,
+	.close = dpaa2_close_dpci_device,
 };
 
 RTE_PMD_REGISTER_DPAA2_OBJECT(dpci, rte_dpaa2_dpci_obj);
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 9dba5dbbd1..ed82eb123a 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -14,6 +14,7 @@
 #include <dpaax_iova_table.h>
 
 #include <mc/fsl_mc_sys.h>
+#include <mc/fsl_dpci.h>
 #include <fsl_qbman_portal.h>
 #include <bus_fslmc_driver.h>
 
@@ -81,7 +82,6 @@
 #define DPAA2_HW_BUF_RESERVE	0
 #define DPAA2_PACKET_LAYOUT_ALIGN	64 /*changing from 256 */
 
-#define DPAA2_DPCI_MAX_QUEUES 2
 #define DPAA2_INVALID_FLOW_ID 0xffff
 #define DPAA2_INVALID_FQ_ID ((uint32_t)(-1))
 #define DPAA2_INVALID_CGID 0xff
@@ -267,13 +267,16 @@ struct dpaa2_dprc_dev {
 
 struct dpaa2_dpci_dev {
 	TAILQ_ENTRY(dpaa2_dpci_dev) next;
-		/**< Pointer to Next device instance */
+	/**< Pointer to Next device instance */
 	struct fsl_mc_io dpci;  /** handle to DPCI portal object */
 	uint16_t token;
 	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpci_id; /*HW ID for DPCI object */
-	struct dpaa2_queue rx_queue[DPAA2_DPCI_MAX_QUEUES];
-	struct dpaa2_queue tx_queue[DPAA2_DPCI_MAX_QUEUES];
+	uint32_t peer_id;
+	uint16_t rx_queue_num;
+	uint16_t tx_queue_num;
+	struct dpaa2_queue *rx_queue;
+	struct dpaa2_queue *tx_queue;
 };
 
 struct dpaa2_dpcon_dev {
@@ -577,6 +580,11 @@ struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void);
 __rte_internal
 void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci);
 
+__rte_internal
+int rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
+	enum dpci_dest dest_type, uint32_t dest_id, uint8_t priority,
+	dpaa2_queue_cb_dqrr_t *rx_cb, struct dpaa2_queue **txq);
+
 /* Global MCP pointer */
 __rte_internal
 void *dpaa2_get_mcp_ptr(int portal_idx);
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index ddcf7b3678..28ed07bd97 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -55,12 +55,12 @@ static uint16_t
 dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			     uint16_t nb_events)
 {
-
 	struct dpaa2_port *dpaa2_portal = port;
 	struct dpaa2_dpio_dev *dpio_dev;
-	uint32_t queue_id = ev[0].queue_id;
+	struct rte_eventdev *eventdev = dpaa2_portal->eventdev;
+	struct dpaa2_eventdev *priv = eventdev->data->dev_private;
 	struct dpaa2_eventq *evq_info;
-	uint32_t fqid, retry_count;
+	uint32_t queue_id, retry_count;
 	struct qbman_swp *swp;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t loop, frames_to_send;
@@ -68,6 +68,8 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 	uint16_t num_tx = 0;
 	int i, n, ret;
 	uint8_t channel_index;
+	const struct rte_event *event;
+	struct dpaa2_queue *dpci_txq;
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		/* Affine current thread context to a qman portal */
@@ -109,25 +111,33 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 	dpaa2_portal->is_port_linked = true;
 
 skip_linking:
-	evq_info = &dpaa2_portal->evq_info[queue_id];
-
 	while (nb_events) {
 		frames_to_send = (nb_events > dpaa2_eqcr_size) ?
 			dpaa2_eqcr_size : nb_events;
 
 		for (loop = 0; loop < frames_to_send; loop++) {
-			const struct rte_event *event = &ev[num_tx + loop];
-
-			if (event->sched_type != RTE_SCHED_TYPE_ATOMIC)
-				fqid = evq_info->dpci->rx_queue[
-					DPAA2_EVENT_DPCI_PARALLEL_QUEUE].fqid;
-			else
-				fqid = evq_info->dpci->rx_queue[
-					DPAA2_EVENT_DPCI_ATOMIC_QUEUE].fqid;
+			event = &ev[num_tx + loop];
+			queue_id = event->queue_id;
+			if (unlikely(queue_id >= DPAA2_EVENT_MAX_QUEUES ||
+				priv->evq_info[queue_id].event_port != dpaa2_portal)) {
+				DPAA2_EVENTDEV_ERR("Event queue%d is not handled by port%d",
+					queue_id, dpaa2_portal->port_id);
+				ret = -EINVAL;
+				goto send_partial;
+			}
+			evq_info = &priv->evq_info[queue_id];
+			if (unlikely(event->sched_type >= DPAA2_EVENTQ_LINK_CONF_MAX ||
+				!evq_info->dpci_txqs[event->sched_type])) {
+				DPAA2_EVENTDEV_ERR("Event sched_type(%d) is not supported",
+					event->sched_type);
+				ret = -ENOTSUP;
+				goto send_partial;
+			}
+			dpci_txq = evq_info->dpci_txqs[event->sched_type];
 
 			/* Prepare enqueue descriptor */
 			qbman_eq_desc_clear(&eqdesc[loop]);
-			qbman_eq_desc_set_fq(&eqdesc[loop], fqid);
+			qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq->fqid);
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], 0);
 			qbman_eq_desc_set_response(&eqdesc[loop], 0, 0);
 
@@ -401,7 +411,6 @@ dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 		RTE_EVENT_DEV_CAP_BURST_MODE|
 		RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK |
 		RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT |
-		RTE_EVENT_DEV_CAP_NONSEQ_MODE |
 		RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES |
 		RTE_EVENT_DEV_CAP_CARRY_FLOW_ID |
 		RTE_EVENT_DEV_CAP_MAINTENANCE_FREE;
@@ -498,7 +507,6 @@ dpaa2_eventdev_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	switch (queue_conf->schedule_type) {
 	case RTE_SCHED_TYPE_PARALLEL:
 	case RTE_SCHED_TYPE_ATOMIC:
-	case RTE_SCHED_TYPE_ORDERED:
 		break;
 	default:
 		DPAA2_EVENTDEV_ERR("Schedule type is not supported.");
@@ -546,13 +554,14 @@ dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	RTE_SET_USED(port_conf);
 
 	sprintf(event_port_name, "event-port-%d", port_id);
-	portal = rte_malloc(event_port_name, sizeof(struct dpaa2_port), 0);
+	portal = rte_zmalloc(event_port_name, sizeof(struct dpaa2_port), 0);
 	if (!portal) {
 		DPAA2_EVENTDEV_ERR("Memory allocation failure");
 		return -ENOMEM;
 	}
+	portal->eventdev = dev;
 
-	memset(portal, 0, sizeof(struct dpaa2_port));
+	portal->port_id = port_id;
 	dev->data->ports[port_id] = portal;
 	return 0;
 }
@@ -1062,41 +1071,6 @@ static struct eventdev_ops dpaa2_eventdev_ops = {
 	.crypto_adapter_stop		= dpaa2_eventdev_crypto_stop,
 };
 
-static int
-dpaa2_eventdev_setup_dpci(struct dpaa2_dpci_dev *dpci_dev,
-			  struct dpaa2_dpcon_dev *dpcon_dev)
-{
-	struct dpci_rx_queue_cfg rx_queue_cfg;
-	int ret, i;
-
-	/*Do settings to get the frame on a DPCON object*/
-	rx_queue_cfg.options = DPCI_QUEUE_OPT_DEST |
-		  DPCI_QUEUE_OPT_USER_CTX;
-	rx_queue_cfg.dest_cfg.dest_type = DPCI_DEST_DPCON;
-	rx_queue_cfg.dest_cfg.dest_id = dpcon_dev->dpcon_id;
-	rx_queue_cfg.dest_cfg.priority = DPAA2_EVENT_DEFAULT_DPCI_PRIO;
-
-	dpci_dev->rx_queue[DPAA2_EVENT_DPCI_PARALLEL_QUEUE].cb =
-		dpaa2_eventdev_process_parallel;
-	dpci_dev->rx_queue[DPAA2_EVENT_DPCI_ATOMIC_QUEUE].cb =
-		dpaa2_eventdev_process_atomic;
-
-	for (i = 0 ; i < DPAA2_EVENT_DPCI_MAX_QUEUES; i++) {
-		rx_queue_cfg.user_ctx = (size_t)(&dpci_dev->rx_queue[i]);
-		ret = dpci_set_rx_queue(&dpci_dev->dpci,
-					CMD_PRI_LOW,
-					dpci_dev->token, i,
-					&rx_queue_cfg);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR(
-				"DPCI Rx queue setup failed: err(%d)",
-				ret);
-			return ret;
-		}
-	}
-	return 0;
-}
-
 static int
 dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 {
@@ -1104,12 +1078,12 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 	struct dpaa2_eventdev *priv;
 	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
+	struct dpaa2_eventq *evq_info;
 	int ret;
 
 	eventdev = rte_event_pmd_vdev_init(name,
-					   sizeof(struct dpaa2_eventdev),
-					   rte_socket_id(), vdev);
-	if (eventdev == NULL) {
+		sizeof(struct dpaa2_eventdev), rte_socket_id(), vdev);
+	if (!eventdev) {
 		DPAA2_EVENTDEV_ERR("Failed to create Event device %s", name);
 		goto fail;
 	}
@@ -1127,27 +1101,49 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 		goto done;
 
 	priv = eventdev->data->dev_private;
-	priv->max_event_queues = 0;
+	memset(priv, 0, sizeof(struct dpaa2_eventdev));
 
 	do {
+		evq_info = &priv->evq_info[priv->max_event_queues];
 		dpcon_dev = rte_dpaa2_alloc_dpcon_dev();
 		if (!dpcon_dev)
 			break;
-		priv->evq_info[priv->max_event_queues].dpcon = dpcon_dev;
+		evq_info->dpcon = dpcon_dev;
 
 		dpci_dev = rte_dpaa2_alloc_dpci_dev();
 		if (!dpci_dev) {
 			rte_dpaa2_free_dpcon_dev(dpcon_dev);
 			break;
 		}
-		priv->evq_info[priv->max_event_queues].dpci = dpci_dev;
+		evq_info->dpci = dpci_dev;
 
-		ret = dpaa2_eventdev_setup_dpci(dpci_dev, dpcon_dev);
+		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
+			dpcon_dev->dpcon_id, 0,
+			dpaa2_eventdev_process_parallel,
+			&evq_info->dpci_txqs[RTE_SCHED_TYPE_PARALLEL]);
 		if (ret) {
-			DPAA2_EVENTDEV_ERR(
-				    "DPCI setup failed: err(%d)", ret);
-			return ret;
+			rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
+			rte_dpaa2_free_dpci_dev(evq_info->dpci);
+			DPAA2_EVENTDEV_ERR("DPCI attach parallel RX failed: err(%d)", ret);
+			break;
 		}
+
+		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
+			dpcon_dev->dpcon_id, 0,
+			dpaa2_eventdev_process_atomic,
+			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ATOMIC]);
+		if (ret) {
+			rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
+			rte_dpaa2_free_dpci_dev(evq_info->dpci);
+			DPAA2_EVENTDEV_ERR("DPCI attach atomic RX failed: err(%d)", ret);
+			break;
+		}
+
+		/** TO DO: order schedule.*/
+
+		evq_info->valid = true;
+		evq_info->event_port = NULL;
+
 		priv->max_event_queues++;
 	} while (dpcon_dev && dpci_dev);
 
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index a054dfdbd7..9f0abae9d4 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -51,20 +51,24 @@ enum {
  * the ethdev to eventdev with DPAA2 devices.
  */
 
+#define DPAA2_EVENTQ_LINK_CONF_MAX 4 /** Max schedule type + 1.*/
 struct dpaa2_eventq {
+	int valid;
+	void *event_port;
 	/* DPcon device */
 	struct dpaa2_dpcon_dev *dpcon;
 	/* Attached DPCI device */
 	struct dpaa2_dpci_dev *dpci;
-	/* Mapped event port */
-	struct dpaa2_io_portal_t *event_port;
 	/* Configuration provided by the user */
 	uint32_t event_queue_cfg;
 	uint32_t event_queue_id;
+	struct dpaa2_queue *dpci_txqs[DPAA2_EVENTQ_LINK_CONF_MAX];
 };
 
 struct dpaa2_port {
+	struct rte_eventdev *eventdev;
 	struct dpaa2_eventq evq_info[DPAA2_EVENT_MAX_QUEUES];
+	uint8_t port_id;
 	uint8_t num_linked_evq;
 	uint8_t is_port_linked;
 	uint64_t timeout_us;
-- 
2.43.0

