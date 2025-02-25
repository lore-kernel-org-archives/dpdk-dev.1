Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D956C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 21:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 460E5402DA;
	Tue, 25 Feb 2025 22:17:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0C66D402D7
 for <dev@dpdk.org>; Tue, 25 Feb 2025 22:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740518245; x=1772054245;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2b2yLVRcnVsVoAfcTRJq4XTerXDhnLTIHXNC7dd3SGI=;
 b=b17dtOJ7b8AIMRUlD/tvIJ7S2mImjxIt2BcW1WPyLOpAH2ClGxks1vsP
 t5rj800vSxzxRSRVT/1HnIJS2hEGrPiyjk2uASSStz/Xd4y83kCxQqHen
 SBJyoWCvgBpT1ah5zjFbJqpKkMaSaT5+fleCXi7bNdKejQFpoHpiH47gp
 4pOi3MOnUa3XAxCiN3b9eBMMS76djgz3rtWngr5urF5DBzaX+K8f4WQ8O
 CMSfogazbRffGEVYc6ujzrCxL8+w3J+Cd/eIOQ53KEQ40po1xjwikas1C
 OfYOdw7syXYnvHvlZjQjX+oD4GtRnI9Ga9VGBoorWtzlwSc/BkCYOQk37 g==;
X-CSE-ConnectionGUID: FO2wA6MEQW2AlikPmLItWQ==
X-CSE-MsgGUID: XmuFoy4kRhug4/cjWWVYMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41366180"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="41366180"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 13:17:23 -0800
X-CSE-ConnectionGUID: a02Z6LLbQVemFwHOPDApoA==
X-CSE-MsgGUID: 93PYo8exQe6+6PkrOBDVzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="147329022"
Received: from unknown (HELO gnr-bkc.iind.intel.com) ([10.145.178.220])
 by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 13:17:20 -0800
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1] event/dlb2: enhancement to DLB credit management
Date: Tue, 25 Feb 2025 16:17:10 -0500
Message-ID: <20250225211715.412663-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Updates are added to enable releasing of unused credits by threads
to avoid deadlock and starving of other active threads needing credits.
It also adds compile time options to enable/disable credit checks.

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 .mailmap                       |   1 +
 doc/guides/eventdevs/dlb2.rst  |  19 ++
 drivers/event/dlb2/dlb2.c      | 316 +++++++++++++++++++++++++++------
 drivers/event/dlb2/dlb2_priv.h |   4 +-
 drivers/event/dlb2/meson.build |  15 ++
 5 files changed, 298 insertions(+), 57 deletions(-)

diff --git a/.mailmap b/.mailmap
index a03d3cfb59..9688941c92 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1556,6 +1556,7 @@ Tim Shearer <tim.shearer@overturenetworks.com>
 Ting-Kai Ku <ting-kai.ku@intel.com>
 Ting Xu <ting.xu@intel.com>
 Tingting Liao <tingtingx.liao@intel.com>
+Tirthendu Sarkar <tirthendu.sarkar@intel.com>
 Tiwei Bie <tiwei.bie@intel.com> <btw@mail.ustc.edu.cn>
 Todd Fujinaka <todd.fujinaka@intel.com>
 Tomáš Ďurovec <tomas.durovec@pantheon.tech>
diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index 2532d92888..0ac3027f93 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -456,6 +456,25 @@ Example command to enable QE Weight feature:
 
        --allow ea:00.0,enable_cq_weight=<y/Y>
 
+Credit Handling Scenario Improvements
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is possible for ports to hold on to unused credits and not release them
+due to insufficient accumulation (i.e. less than 2 * credit quanta). This
+can result in credit deadlocks situation. DLB2 PMD makes worker ports to
+release all accumulated credits when back-to-back zero poll count reaches
+a preset threshold and makes producer ports release all the accumulated
+credits if enqueue fails for a consecutive number of retries.
+
+New meson options are provided through c_args for enabling and disabling
+credits handling option flags. Credit checks are enabled by default.
+
+Example command to use as meson option for credit handling:
+
+    .. code-block:: console
+
+       meson configure -Dc_args='-DDLB_SW_CREDITS_CHECKS=0 -DDLB_HW_CREDITS_CHECKS=1'
+
 Running Eventdev Applications with DLB Device
 ---------------------------------------------
 
diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 934fcafcfe..286241ea41 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -43,7 +43,63 @@
  * to DLB can go ahead of relevant application writes like updates to buffers
  * being sent with event
  */
+#ifndef DLB2_BYPASS_FENCE_ON_PP
 #define DLB2_BYPASS_FENCE_ON_PP 0  /* 1 == Bypass fence, 0 == do not bypass */
+#endif
+
+/*
+ * Optimization switches for improving driver performance.
+ * WARNING: Do not change any of the below switches without first
+ * consulting with DLB2 software development team.
+ *
+ * HW credit checks can only be turned off for DLB2 device if following
+ * is true for each created eventdev
+ * LDB credits <= DIR credits + minimum CQ Depth
+ * (CQ Depth is minimum of all ports configured within eventdev)
+ * This needs to be true for all eventdevs created on any DLB2 device
+ * managed by this driver.
+ * DLB2.5 does not any such restriction as it has single credit pool
+ */
+#ifndef DLB_HW_CREDITS_CHECKS
+#define DLB_HW_CREDITS_CHECKS 0
+#endif
+
+/*
+ * SW credit checks can only be turned off if application has a way to
+ * limit input events to the eventdev below assigned credit limit
+ */
+#ifndef DLB_SW_CREDITS_CHECKS
+#define DLB_SW_CREDITS_CHECKS 1
+#endif
+
+/*
+ * This check can only be disabled if application is not using
+ * queues of RTE_EVENT_QUEUE_CFG_ALL_TYPES type.
+ * Once such application is fully validated, type check can be turned off.
+ * HW will continue checking for correct type and generate alarm on mismatch
+ */
+#ifndef DLB_TYPE_CHECK
+#define DLB_TYPE_CHECK 1
+#endif
+#define DLB_TYPE_MACRO 0x010002
+
+/*
+ * To avoid deadlock situations, by default, per port new_event_threshold
+ * check is disabled. nb_events_limit is still checked while allocating
+ * new event credits.
+ */
+#define ENABLE_PORT_THRES_CHECK 1
+/*
+ * To avoid deadlock, ports holding to credits will release them after these
+ * many consecutive zero dequeues
+ */
+#define DLB2_ZERO_DEQ_CREDIT_RETURN_THRES 16384
+
+/*
+ * To avoid deadlock, ports holding to credits will release them after these
+ * many consecutive enqueue failures
+ */
+#define DLB2_ENQ_FAIL_CREDIT_RETURN_THRES 100
 
 /*
  * Resources exposed to eventdev. Some values overridden at runtime using
@@ -52,6 +108,7 @@
 #if (RTE_EVENT_MAX_QUEUES_PER_DEV > UINT8_MAX)
 #error "RTE_EVENT_MAX_QUEUES_PER_DEV cannot fit in member max_event_queues"
 #endif
+
 static struct rte_event_dev_info evdev_dlb2_default_info = {
 	.driver_name = "", /* probe will set */
 	.min_dequeue_timeout_ns = DLB2_MIN_DEQUEUE_TIMEOUT_NS,
@@ -375,6 +432,33 @@ set_max_num_events(const char *key __rte_unused,
 	return 0;
 }
 
+static int
+set_max_num_events_v2_5(const char *key __rte_unused,
+			const char *value,
+			void *opaque)
+{
+	int *max_num_events = opaque;
+	int ret;
+
+	if (value == NULL || opaque == NULL) {
+		DLB2_LOG_ERR("NULL pointer");
+		return -EINVAL;
+	}
+
+	ret = dlb2_string_to_int(max_num_events, value);
+	if (ret < 0)
+		return ret;
+
+	if (*max_num_events < 0 || *max_num_events >
+			DLB2_MAX_NUM_CREDITS(DLB2_HW_V2_5)) {
+		DLB2_LOG_ERR("dlb2: max_num_events must be between 0 and %d",
+			     DLB2_MAX_NUM_CREDITS(DLB2_HW_V2_5));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 set_num_dir_credits(const char *key __rte_unused,
 		    const char *value,
@@ -915,6 +999,15 @@ dlb2_hw_reset_sched_domain(const struct rte_eventdev *dev, bool reconfig)
 	dlb2->num_queues = 0;
 	dlb2->num_ldb_queues = 0;
 	dlb2->num_dir_queues = 0;
+	if (dlb2->version == DLB2_HW_V2_5) {
+		dlb2->num_credits = 0;
+		dlb2->max_credits = 0;
+	} else {
+		dlb2->num_ldb_credits = 0;
+		dlb2->num_dir_credits = 0;
+		dlb2->max_ldb_credits = 0;
+		dlb2->max_dir_credits = 0;
+	}
 	dlb2->configured = false;
 }
 
@@ -1023,11 +1116,14 @@ dlb2_eventdev_configure(const struct rte_eventdev *dev)
 	if (dlb2->version == DLB2_HW_V2_5) {
 		dlb2->credit_pool = rsrcs->num_credits;
 		dlb2->max_credits = rsrcs->num_credits;
+		dlb2->num_credits = rsrcs->num_credits;
 	} else {
 		dlb2->ldb_credit_pool = rsrcs->num_ldb_credits;
 		dlb2->max_ldb_credits = rsrcs->num_ldb_credits;
+		dlb2->num_ldb_credits = rsrcs->num_ldb_credits;
 		dlb2->dir_credit_pool = rsrcs->num_dir_credits;
 		dlb2->max_dir_credits = rsrcs->num_dir_credits;
+		dlb2->num_dir_credits = rsrcs->num_dir_credits;
 	}
 
 	dlb2->configured = true;
@@ -1614,6 +1710,12 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 
 	qm_port->id = qm_port_id;
 
+	if (dlb2->version == DLB2_HW_V2) {
+		qm_port->cached_ldb_credits = 0;
+		qm_port->cached_dir_credits = 0;
+	} else
+		qm_port->cached_credits = 0;
+
 	if (dlb2->version == DLB2_HW_V2_5 && (dlb2->enable_cq_weight == true)) {
 		struct dlb2_enable_cq_weight_args cq_weight_args = { {0} };
 		cq_weight_args.port_id = qm_port->id;
@@ -1985,18 +2087,6 @@ dlb2_eventdev_port_setup(struct rte_eventdev *dev,
 	ev_port->credit_update_quanta = sw_credit_quanta;
 	ev_port->qm_port.hw_credit_quanta = hw_credit_quanta;
 
-	/*
-	 * Validate credit config before creating port
-	 */
-
-	if (port_conf->enqueue_depth > sw_credit_quanta ||
-	    port_conf->enqueue_depth > hw_credit_quanta) {
-		DLB2_LOG_ERR("Invalid port config. Enqueue depth %d must be <= credit quanta %d and batch size %d",
-			     port_conf->enqueue_depth,
-			     sw_credit_quanta,
-			     hw_credit_quanta);
-		return -EINVAL;
-	}
 	ev_port->enq_retries = port_conf->enqueue_depth;
 
 	ev_port->qm_port.reorder_id = 0;
@@ -2436,6 +2526,64 @@ dlb2_event_queue_detach_ldb(struct dlb2_eventdev *dlb2,
 	return ret;
 }
 
+static inline void
+dlb2_port_credits_return(struct dlb2_port *qm_port)
+{
+	/* Return all port credits */
+	if (qm_port->dlb2->version == DLB2_HW_V2_5) {
+		if (qm_port->cached_credits) {
+			rte_atomic_fetch_add_explicit(qm_port->credit_pool[DLB2_COMBINED_POOL],
+					   qm_port->cached_credits, rte_memory_order_seq_cst);
+			qm_port->cached_credits = 0;
+		}
+	} else {
+		if (qm_port->cached_ldb_credits) {
+			rte_atomic_fetch_add_explicit(qm_port->credit_pool[DLB2_LDB_QUEUE],
+					   qm_port->cached_ldb_credits, rte_memory_order_seq_cst);
+			qm_port->cached_ldb_credits = 0;
+		}
+		if (qm_port->cached_dir_credits) {
+			rte_atomic_fetch_add_explicit(qm_port->credit_pool[DLB2_DIR_QUEUE],
+					   qm_port->cached_dir_credits, rte_memory_order_seq_cst);
+			qm_port->cached_dir_credits = 0;
+		}
+	}
+}
+
+static inline void
+dlb2_release_sw_credits(struct dlb2_eventdev *dlb2,
+			struct dlb2_eventdev_port *ev_port, uint16_t val)
+{
+	if (ev_port->inflight_credits) {
+		rte_atomic_fetch_sub_explicit(&dlb2->inflights, val, rte_memory_order_seq_cst);
+		ev_port->inflight_credits -= val;
+	}
+}
+
+static void dlb2_check_and_return_credits(struct dlb2_eventdev_port *ev_port,
+					  bool cond, uint32_t threshold)
+{
+#if DLB_SW_CREDITS_CHECKS || DLB_HW_CREDITS_CHECKS
+	if (cond) {
+		if (++ev_port->credit_return_count > threshold) {
+#if DLB_SW_CREDITS_CHECKS
+			dlb2_release_sw_credits(ev_port->dlb2, ev_port,
+						ev_port->inflight_credits);
+#endif
+#if DLB_HW_CREDITS_CHECKS
+			dlb2_port_credits_return(&ev_port->qm_port);
+#endif
+			ev_port->credit_return_count = 0;
+		}
+	} else {
+		ev_port->credit_return_count = 0;
+	}
+#else
+/* Avoid compilation warning of unused parameters */
+(void)ev_port, (void)cond, (void)threshold;
+#endif
+}
+
 static int
 dlb2_eventdev_port_unlink(struct rte_eventdev *dev, void *event_port,
 			  uint8_t queues[], uint16_t nb_unlinks)
@@ -2455,7 +2603,8 @@ dlb2_eventdev_port_unlink(struct rte_eventdev *dev, void *event_port,
 
 	if (queues == NULL || nb_unlinks == 0) {
 		DLB2_LOG_LINE_DBG("dlb2: queues is NULL or nb_unlinks is 0");
-		return 0; /* Ignore and return success */
+		nb_unlinks = 0; /* Ignore and return success */
+		goto ret_credits;
 	}
 
 	if (ev_port->qm_port.is_directed) {
@@ -2501,6 +2650,10 @@ dlb2_eventdev_port_unlink(struct rte_eventdev *dev, void *event_port,
 		ev_queue->num_links--;
 	}
 
+ret_credits:
+	if (ev_port->inflight_credits)
+		dlb2_check_and_return_credits(ev_port, true, 0);
+
 	return nb_unlinks;
 }
 
@@ -2700,8 +2853,7 @@ dlb2_replenish_sw_credits(struct dlb2_eventdev *dlb2,
 		/* Replenish credits, saving one quanta for enqueues */
 		uint16_t val = ev_port->inflight_credits - quanta;
 
-		rte_atomic_fetch_sub_explicit(&dlb2->inflights, val, rte_memory_order_seq_cst);
-		ev_port->inflight_credits -= val;
+		dlb2_release_sw_credits(dlb2, ev_port, val);
 	}
 }
 
@@ -2732,9 +2884,15 @@ dlb2_check_enqueue_sw_credits(struct dlb2_eventdev *dlb2,
 			return 1;
 		}
 
-		rte_atomic_fetch_add_explicit(&dlb2->inflights, credit_update_quanta,
-				   rte_memory_order_seq_cst);
-		ev_port->inflight_credits += (credit_update_quanta);
+		/* Application will retry if this attempt fails due to contention */
+		if (rte_atomic_compare_exchange_strong_explicit(&dlb2->inflights, &sw_inflights,
+			(sw_inflights+credit_update_quanta), rte_memory_order_seq_cst,
+			rte_memory_order_seq_cst))
+			ev_port->inflight_credits += (credit_update_quanta);
+		else {
+			rte_errno = -ENOSPC;
+			return 1;
+		}
 
 		if (ev_port->inflight_credits < num) {
 			DLB2_INC_STAT(
@@ -2896,7 +3054,9 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 {
 	struct dlb2_eventdev *dlb2 = ev_port->dlb2;
 	struct dlb2_eventdev_queue *ev_queue;
+#if DLB_HW_CREDITS_CHECKS
 	uint16_t *cached_credits = NULL;
+#endif
 	struct dlb2_queue *qm_queue;
 
 	ev_queue = &dlb2->ev_queues[ev->queue_id];
@@ -2908,6 +3068,7 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 		goto op_check;
 
 	if (!qm_queue->is_directed) {
+#if DLB_HW_CREDITS_CHECKS
 		/* Load balanced destination queue */
 
 		if (dlb2->version == DLB2_HW_V2) {
@@ -2923,6 +3084,8 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 			}
 			cached_credits = &qm_port->cached_credits;
 		}
+#endif
+#if DLB_TYPE_CHECK
 		switch (ev->sched_type) {
 		case RTE_SCHED_TYPE_ORDERED:
 			DLB2_LOG_LINE_DBG("dlb2: put_qe: RTE_SCHED_TYPE_ORDERED");
@@ -2951,9 +3114,20 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 			rte_errno = -EINVAL;
 			return 1;
 		}
+#else
+#if (RTE_SCHED_TYPE_PARALLEL != 2) || (RTE_SCHED_TYPE_ATOMIC != 1)
+#error "ERROR: RTE event schedule type values changed. Needs a code change"
+#endif
+		/* Map RTE eventdev schedule type to DLB HW schedule type */
+		if (qm_queue->sched_type != RTE_SCHED_TYPE_ORDERED)
+			/* RTE-Parallel -> DLB-UnOrd 2->1, RTE-Atm -> DLB-Atm 1->0 */
+			*sched_type = ev->sched_type - 1;
+		else /* To support CFG_ALL_TYPEs */
+			*sched_type = DLB2_SCHED_ORDERED; /* RTE-Ord -> DLB-Ord 0->2 */
+#endif
 	} else {
 		/* Directed destination queue */
-
+#if DLB_HW_CREDITS_CHECKS
 		if (dlb2->version == DLB2_HW_V2) {
 			if (dlb2_check_enqueue_hw_dir_credits(qm_port)) {
 				rte_errno = -ENOSPC;
@@ -2967,6 +3141,7 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 			}
 			cached_credits = &qm_port->cached_credits;
 		}
+#endif
 		DLB2_LOG_LINE_DBG("dlb2: put_qe: RTE_SCHED_TYPE_DIRECTED");
 
 		*sched_type = DLB2_SCHED_DIRECTED;
@@ -2975,13 +3150,17 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 op_check:
 	switch (ev->op) {
 	case RTE_EVENT_OP_NEW:
+#if DLB_SW_CREDITS_CHECKS
 		/* Check that a sw credit is available */
 		if (dlb2_check_enqueue_sw_credits(dlb2, ev_port)) {
 			rte_errno = -ENOSPC;
 			return 1;
 		}
 		ev_port->inflight_credits--;
+#endif
+#if DLB_HW_CREDITS_CHECKS
 		(*cached_credits)--;
+#endif
 		break;
 	case RTE_EVENT_OP_FORWARD:
 		/* Check for outstanding_releases underflow. If this occurs,
@@ -2992,10 +3171,14 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 		RTE_ASSERT(ev_port->outstanding_releases > 0);
 		ev_port->outstanding_releases--;
 		qm_port->issued_releases++;
+#if DLB_HW_CREDITS_CHECKS
 		(*cached_credits)--;
+#endif
 		break;
 	case RTE_EVENT_OP_RELEASE:
+#if DLB_SW_CREDITS_CHECKS
 		ev_port->inflight_credits++;
+#endif
 		/* Check for outstanding_releases underflow. If this occurs,
 		 * the application is not using the EVENT_OPs correctly; for
 		 * example, forwarding or releasing events that were not
@@ -3005,8 +3188,10 @@ dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 		ev_port->outstanding_releases--;
 		qm_port->issued_releases++;
 
+#if DLB_SW_CREDITS_CHECKS
 		/* Replenish s/w credits if enough are cached */
 		dlb2_replenish_sw_credits(dlb2, ev_port);
+#endif
 		break;
 	}
 
@@ -3280,6 +3465,8 @@ __dlb2_event_enqueue_burst(void *event_port,
 			break;
 	}
 
+	dlb2_check_and_return_credits(ev_port, !i,
+				      DLB2_ENQ_FAIL_CREDIT_RETURN_THRES);
 	return i;
 }
 
@@ -3404,53 +3591,45 @@ dlb2_event_release(struct dlb2_eventdev *dlb2,
 		return;
 	}
 	ev_port->outstanding_releases -= i;
+#if DLB_SW_CREDITS_CHECKS
 	ev_port->inflight_credits += i;
 
 	/* Replenish s/w credits if enough releases are performed */
 	dlb2_replenish_sw_credits(dlb2, ev_port);
+#endif
 }
 
 static inline void
 dlb2_port_credits_inc(struct dlb2_port *qm_port, int num)
 {
 	uint32_t batch_size = qm_port->hw_credit_quanta;
+	int val;
 
 	/* increment port credits, and return to pool if exceeds threshold */
-	if (!qm_port->is_directed) {
-		if (qm_port->dlb2->version == DLB2_HW_V2) {
-			qm_port->cached_ldb_credits += num;
-			if (qm_port->cached_ldb_credits >= 2 * batch_size) {
-				rte_atomic_fetch_add_explicit(
-					qm_port->credit_pool[DLB2_LDB_QUEUE],
-					batch_size, rte_memory_order_seq_cst);
-				qm_port->cached_ldb_credits -= batch_size;
-			}
-		} else {
-			qm_port->cached_credits += num;
-			if (qm_port->cached_credits >= 2 * batch_size) {
-				rte_atomic_fetch_add_explicit(
-				      qm_port->credit_pool[DLB2_COMBINED_POOL],
-				      batch_size, rte_memory_order_seq_cst);
-				qm_port->cached_credits -= batch_size;
-			}
+	if (qm_port->dlb2->version == DLB2_HW_V2_5) {
+		qm_port->cached_credits += num;
+		if (qm_port->cached_credits >= 2 * batch_size) {
+			val = qm_port->cached_credits - batch_size;
+			rte_atomic_fetch_add_explicit(
+			    qm_port->credit_pool[DLB2_COMBINED_POOL], val,
+			    rte_memory_order_seq_cst);
+			qm_port->cached_credits -= val;
+		}
+	} else if (!qm_port->is_directed) {
+		qm_port->cached_ldb_credits += num;
+		if (qm_port->cached_ldb_credits >= 2 * batch_size) {
+			val = qm_port->cached_ldb_credits - batch_size;
+			rte_atomic_fetch_add_explicit(qm_port->credit_pool[DLB2_LDB_QUEUE],
+					   val, rte_memory_order_seq_cst);
+			qm_port->cached_ldb_credits -= val;
 		}
 	} else {
-		if (qm_port->dlb2->version == DLB2_HW_V2) {
-			qm_port->cached_dir_credits += num;
-			if (qm_port->cached_dir_credits >= 2 * batch_size) {
-				rte_atomic_fetch_add_explicit(
-					qm_port->credit_pool[DLB2_DIR_QUEUE],
-					batch_size, rte_memory_order_seq_cst);
-				qm_port->cached_dir_credits -= batch_size;
-			}
-		} else {
-			qm_port->cached_credits += num;
-			if (qm_port->cached_credits >= 2 * batch_size) {
-				rte_atomic_fetch_add_explicit(
-				      qm_port->credit_pool[DLB2_COMBINED_POOL],
-				      batch_size, rte_memory_order_seq_cst);
-				qm_port->cached_credits -= batch_size;
-			}
+		qm_port->cached_ldb_credits += num;
+		if (qm_port->cached_ldb_credits >= 2 * batch_size) {
+			val = qm_port->cached_ldb_credits - batch_size;
+			rte_atomic_fetch_add_explicit(qm_port->credit_pool[DLB2_LDB_QUEUE],
+					   val, rte_memory_order_seq_cst);
+			qm_port->cached_ldb_credits -= val;
 		}
 	}
 }
@@ -3481,6 +3660,15 @@ dlb2_dequeue_wait(struct dlb2_eventdev *dlb2,
 
 	/* Wait/poll time expired */
 	if (elapsed_ticks >= timeout) {
+		/* Return all credits before blocking if remaining credits in
+		 * system is less than quanta.
+		 */
+		uint32_t sw_inflights = rte_atomic_load_explicit(&dlb2->inflights,
+			rte_memory_order_seq_cst);
+		uint32_t quanta = ev_port->credit_update_quanta;
+
+		if (dlb2->new_event_limit - sw_inflights < quanta)
+			dlb2_check_and_return_credits(ev_port, true, 0);
 		return 1;
 	} else if (dlb2->umwait_allowed) {
 		struct rte_power_monitor_cond pmc;
@@ -4114,7 +4302,9 @@ dlb2_hw_dequeue_sparse(struct dlb2_eventdev *dlb2,
 
 		ev_port->outstanding_releases += num;
 
+#if DLB_HW_CREDITS_CHECKS
 		dlb2_port_credits_inc(qm_port, num);
+#endif
 	}
 
 	return num;
@@ -4242,7 +4432,9 @@ dlb2_hw_dequeue(struct dlb2_eventdev *dlb2,
 
 		ev_port->outstanding_releases += num;
 
+#if DLB_HW_CREDITS_CHECKS
 		dlb2_port_credits_inc(qm_port, num);
+#endif
 	}
 
 	return num;
@@ -4289,6 +4481,8 @@ dlb2_event_dequeue_burst(void *event_port, struct rte_event *ev, uint16_t num,
 
 	DLB2_INC_STAT(ev_port->stats.traffic.total_polls, 1);
 	DLB2_INC_STAT(ev_port->stats.traffic.zero_polls, ((cnt == 0) ? 1 : 0));
+	dlb2_check_and_return_credits(ev_port, !cnt,
+				      DLB2_ZERO_DEQ_CREDIT_RETURN_THRES);
 
 	return cnt;
 }
@@ -4347,6 +4541,9 @@ dlb2_event_dequeue_burst_sparse(void *event_port, struct rte_event *ev,
 
 	DLB2_INC_STAT(ev_port->stats.traffic.total_polls, 1);
 	DLB2_INC_STAT(ev_port->stats.traffic.zero_polls, ((cnt == 0) ? 1 : 0));
+	dlb2_check_and_return_credits(ev_port, !cnt,
+				      DLB2_ZERO_DEQ_CREDIT_RETURN_THRES);
+
 	return cnt;
 }
 
@@ -4868,9 +5065,18 @@ dlb2_parse_params(const char *params,
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist, DLB2_MAX_NUM_EVENTS,
-						 set_max_num_events,
-						 &dlb2_args->max_num_events);
+			if (version == DLB2_HW_V2) {
+				ret = rte_kvargs_process(kvlist,
+						DLB2_MAX_NUM_EVENTS,
+						set_max_num_events,
+						&dlb2_args->max_num_events);
+			} else {
+				ret = rte_kvargs_process(kvlist,
+						DLB2_MAX_NUM_EVENTS,
+						set_max_num_events_v2_5,
+						&dlb2_args->max_num_events);
+			}
+
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing max_num_events parameter",
 					     name);
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 52da31ed31..4dd7532519 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -76,8 +76,7 @@
 #define DLB2_MAX_NUM_FLOWS (64 * 1024)
 #define DLB2_MAX_NUM_LDB_CREDITS (8 * 1024)
 #define DLB2_MAX_NUM_DIR_CREDITS(ver)		(ver == DLB2_HW_V2 ? 4096 : 0)
-#define DLB2_MAX_NUM_CREDITS(ver)		(ver == DLB2_HW_V2 ? \
-						 0 : DLB2_MAX_NUM_LDB_CREDITS)
+#define DLB2_MAX_NUM_CREDITS(ver)		(ver == DLB2_HW_V2 ? 0 : 16384)
 #define DLB2_MAX_NUM_LDB_CREDIT_POOLS 64
 #define DLB2_MAX_NUM_DIR_CREDIT_POOLS 64
 #define DLB2_MAX_NUM_HIST_LIST_ENTRIES 2048
@@ -537,6 +536,7 @@ struct __rte_cache_aligned dlb2_eventdev_port {
 	struct rte_event_port_conf conf; /* user-supplied configuration */
 	uint16_t inflight_credits; /* num credits this port has right now */
 	uint16_t credit_update_quanta;
+	uint32_t credit_return_count; /* count till the credit return condition is true */
 	struct dlb2_eventdev *dlb2; /* backlink optimization */
 	alignas(RTE_CACHE_LINE_SIZE) struct dlb2_port_stats stats;
 	struct dlb2_event_queue_link link[DLB2_MAX_NUM_QIDS_PER_LDB_CQ];
diff --git a/drivers/event/dlb2/meson.build b/drivers/event/dlb2/meson.build
index c024edb311..177ae15250 100644
--- a/drivers/event/dlb2/meson.build
+++ b/drivers/event/dlb2/meson.build
@@ -40,3 +40,18 @@ endif
 headers = files('rte_pmd_dlb2.h')
 
 deps += ['mbuf', 'mempool', 'ring', 'pci', 'bus_pci']
+
+dlb_pmd_defines = ['-DDLB2_BYPASS_FENCE_ON_PP', '-DDLB_HW_CREDITS_CHECKS', '-DDLB_SW_CREDITS_CHECKS', '-DDLB_TYPE_CHECK']
+dlb_pmd_default = ['0','1','1','1']
+
+c_args=get_option('c_args')
+index = 0
+foreach opt: dlb_pmd_defines
+    opt_true = opt + '=1'
+    opt_false = opt + '=0'
+    if not (c_args.contains(opt_true) or c_args.contains(opt_false))
+        cflags += opt + '=' + dlb_pmd_default[index]
+    endif
+
+    index += 1
+endforeach
-- 
2.43.5

