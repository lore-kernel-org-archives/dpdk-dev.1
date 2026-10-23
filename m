Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34649606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A61C40DC9;
	Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id E30B140E4B
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:37 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C789720002B;
 Fri, 23 Oct 2026 15:44:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 939E7200040;
 Fri, 23 Oct 2026 15:44:37 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 913D918000B7;
 Fri, 23 Oct 2026 21:44:36 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 42/65] event/dpaa2: report available DPIO count and fix
 create cleanup
Date: Fri, 23 Oct 2026 19:13:22 +0530
Message-ID: <20261023134346.37727-43-prashant.gupta_3@nxp.com>
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

max_event_ports was reported as the total number of DPAA2_IO devices,
including DPIOs already claimed by other users(affine portals).
Add an internal helper rte_dpaa2_available_dpio_device() that counts
only DPIOs with a zero reference count, and use it so the eventdev
advertises the number of ports it can actually acquire.

Rework dpaa2_eventdev_create() error handling. The device creation
loop now iterates over a fixed range and, on any DPCI attach failure,
frees the DPCON and DPCI acquired for the current event queue and
breaks out instead of returning with resources leaked. A single done
path releases the DPCON/DPCI of all event queues set up so far when an
error occurred, and the function returns a meaningful error code
rather than a fixed -EFAULT.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 15 +++++++
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |  4 ++
 drivers/event/dpaa2/dpaa2_eventdev.c     | 52 +++++++++++++++---------
 drivers/event/dpaa2/dpaa2_eventdev.h     | 23 ++++++++++-
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 55dcef41d1..654472b284 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -465,6 +465,21 @@ void rte_dpaa2_free_dpio_device(struct dpaa2_dpio_dev *dpio_dev)
 	dpaa2_put_qbman_swp(dpio_dev);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_available_dpio_device)
+uint16_t
+rte_dpaa2_available_dpio_device(void)
+{
+	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	uint16_t available_num = 0;
+
+	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+		if (dpio_dev && !rte_atomic16_read(&dpio_dev->ref_count))
+			available_num++;
+	}
+
+	return available_num;
+}
+
 static void
 dpaa2_close_dpio_device(int object_id)
 {
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index ae0f5993d6..d28fdb03b7 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -78,4 +78,8 @@ __rte_internal
 void
 rte_dpaa2_free_dpio_device(struct dpaa2_dpio_dev *dpio_dev);
 
+__rte_internal
+uint16_t
+rte_dpaa2_available_dpio_device(void);
+
 #endif /* _DPAA2_HW_DPIO_H_ */
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 4c20e26870..5badc17af7 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -401,7 +401,7 @@ dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 		DPAA2_EVENT_MAX_QUEUE_PRIORITY_LEVELS;
 	dev_info->max_event_priority_levels =
 		DPAA2_EVENT_MAX_EVENT_PRIORITY_LEVELS;
-	dev_info->max_event_ports = rte_fslmc_get_device_count(DPAA2_IO);
+	dev_info->max_event_ports = rte_dpaa2_available_dpio_device();
 	if (dev_info->max_event_ports > dev_info->max_event_queues)
 		dev_info->max_event_ports = dev_info->max_event_queues;
 	/* we only support dpio up to number of cores */
@@ -1209,17 +1209,18 @@ static int
 dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 {
 	struct rte_eventdev *eventdev;
-	struct dpaa2_eventdev *priv;
+	struct dpaa2_eventdev *priv = NULL;
 	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
 	struct dpaa2_eventq *evq_info;
-	int ret;
+	int ret = 0, i;
 
 	eventdev = rte_event_pmd_vdev_init(name,
 		sizeof(struct dpaa2_eventdev), rte_socket_id(), vdev);
 	if (!eventdev) {
+		ret = -ENOMEM;
 		DPAA2_EVENTDEV_ERR("Failed to create Event device %s", name);
-		goto fail;
+		goto done;
 	}
 
 	eventdev->dev_ops = &dpaa2_eventdev_ops;
@@ -1237,8 +1238,8 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 	priv = eventdev->data->dev_private;
 	memset(priv, 0, sizeof(struct dpaa2_eventdev));
 
-	do {
-		evq_info = &priv->evq_info[priv->max_event_queues];
+	for (i = 0; i < DPAA2_EVENT_MAX_QUEUES; i++) {
+		evq_info = &priv->evq_info[i];
 		dpcon_dev = rte_dpaa2_alloc_dpcon_dev();
 		if (!dpcon_dev)
 			break;
@@ -1256,10 +1257,8 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 			dpaa2_eventdev_process_parallel,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_PARALLEL]);
 		if (ret) {
-			rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
-			rte_dpaa2_free_dpci_dev(evq_info->dpci);
 			DPAA2_EVENTDEV_ERR("DPCI attach parallel RX failed: err(%d)", ret);
-			break;
+			goto err_break;
 		}
 
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
@@ -1267,10 +1266,8 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 			dpaa2_eventdev_process_atomic,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ATOMIC]);
 		if (ret) {
-			rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
-			rte_dpaa2_free_dpci_dev(evq_info->dpci);
 			DPAA2_EVENTDEV_ERR("DPCI attach atomic RX failed: err(%d)", ret);
-			break;
+			goto err_break;
 		}
 
 		/** TO DO: order schedule.*/
@@ -1279,17 +1276,32 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 		evq_info->event_queue_id = priv->max_event_queues;
 
 		priv->max_event_queues++;
-		if (priv->max_event_queues >= DPAA2_EVENT_MAX_QUEUES)
-			break;
-	} while (dpcon_dev && dpci_dev);
-
-	DPAA2_EVENTDEV_INFO("%s eventdev created", name);
+		continue;
+err_break:
+		if (evq_info->dpcon)
+			rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
+		if (evq_info->dpci)
+			rte_dpaa2_free_dpci_dev(evq_info->dpci);
+		break;
+	}
 
 done:
+	if (ret && priv) {
+		for (i = 0; i < priv->max_event_queues; i++) {
+			evq_info = &priv->evq_info[i];
+			if (evq_info->dpcon)
+				rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
+			if (evq_info->dpci)
+				rte_dpaa2_free_dpci_dev(evq_info->dpci);
+		}
+	}
 	event_dev_probing_finish(eventdev);
-	return 0;
-fail:
-	return -EFAULT;
+	if (ret)
+		DPAA2_EVENTDEV_ERR("Failed(%d) to create event device(%s)", ret, name);
+	else
+		DPAA2_EVENTDEV_INFO("Create event device(%s)", name);
+
+	return ret;
 }
 
 static int
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index c0ce42c83f..af1c831b92 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -8,6 +8,9 @@
 #include <eventdev_pmd.h>
 #include <eventdev_pmd_vdev.h>
 #include <rte_atomic.h>
+#include <rte_common.h>
+#include <rte_eventdev.h>
+
 #include <mc/fsl_dpcon.h>
 #include <mc/fsl_mc_sys.h>
 
@@ -15,6 +18,7 @@
 
 #define DPAA2_EVENT_DEFAULT_DPCI_PRIO 0
 
+#define DPAA2_EVENT_MAX_PORTS			16
 #define DPAA2_EVENT_MAX_QUEUES			16
 #define DPAA2_EVENT_MIN_DEQUEUE_TIMEOUT		1
 #define DPAA2_EVENT_MAX_DEQUEUE_TIMEOUT		(UINT32_MAX - 1)
@@ -51,7 +55,24 @@ enum {
  * the ethdev to eventdev with DPAA2 devices.
  */
 
-#define DPAA2_EVENTQ_LINK_CONF_MAX 4 /** Max schedule type + 1.*/
+/*
+ * Size of the per-eventq dpci_txqs[] array. It is indexed directly by
+ * event->sched_type, so it must be (largest sched-type value) + 1.
+ * RTE_SCHED_TYPE_{ORDERED,ATOMIC,PARALLEL} are plain macros (0, 1, 2) with
+ * no upstream MAX definition, so compute the maximum explicitly here rather
+ * than assuming PARALLEL is numerically largest. If the sched-type values are
+ * ever renumbered upstream, this expression still yields the correct bound.
+ *
+ * A plain ternary max is used (not RTE_MAX): RTE_MAX expands to a GCC
+ * statement-expression ({ ... }), which is not a constant expression and
+ * cannot size an array at file scope.
+ */
+#define DPAA2_EVENTQ_MAX2(a, b) ((a) > (b) ? (a) : (b))
+#define DPAA2_EVENTQ_LINK_CONF_MAX \
+	(DPAA2_EVENTQ_MAX2(RTE_SCHED_TYPE_ORDERED, \
+		DPAA2_EVENTQ_MAX2(RTE_SCHED_TYPE_ATOMIC, \
+			RTE_SCHED_TYPE_PARALLEL)) + 1)
+
 struct dpaa2_eventq {
 	int valid;
 	uint8_t link_num;
-- 
2.43.0

