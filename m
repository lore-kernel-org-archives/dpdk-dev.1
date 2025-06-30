Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15647C83013
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 02:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A627840264;
	Mon, 30 Jun 2025 04:25:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id AC3AE4025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 04:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751250326; x=1782786326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIPnIBFDLW2NQUIvoXOOPVQHaKYjOmwAZDLfXcl5BEE=;
 b=h/1Bi7IafqeFFxtgwfGYEz+TWeHXWJ6fu9FYt1JO8qNx3MhRCa/F4kwQ
 4LehWh2AnkEPP3CSty18S18nlK+DD9XVUYVrjrbzw2mGzJzQFjuOqobWT
 wU21qqdexuUvh/6iqFdYTHpU51v0nBypZQBfHQEpDEQIRdsAfssdqNqSB
 GQlIL9uHmXlW4T4EJ81bEHqCOgQRa9I9h0nKKrJ/OOQShGqYIzESiATXA
 h/VaI3wLhy7ZRNZxowT14ejADEdIYSxOnXeBI0ogKcQG708HEuorOHqXE
 pZjgVJD8x8uAcd2E6W9cKMVnJWJPNdoKx4w5kThYvNs/KVtPKFSe4nhsL A==;
X-CSE-ConnectionGUID: bDgwQfdyS2aREswycbp6nQ==
X-CSE-MsgGUID: HX0OMh/UTP6Y3K7rN260fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="71035256"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; d="scan'208";a="71035256"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2025 19:25:24 -0700
X-CSE-ConnectionGUID: UvjgyHP2Tl+uyKVbA8aImg==
X-CSE-MsgGUID: Rz2DeA0SQOy8y48Ig1tVXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; d="scan'208";a="154035153"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa010.fm.intel.com with ESMTP; 29 Jun 2025 19:25:23 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v2] event/dlb2: add dequeue interrupt mode support
Date: Sun, 29 Jun 2025 21:25:20 -0500
Message-Id: <20250630022520.718016-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250628045112.655999-1-pravin.pathak@intel.com>
References: <20250628045112.655999-1-pravin.pathak@intel.com>
MIME-Version: 1.0
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

DLB2 port interrupt is implemented using DPDK interrupt
framework. This allows eventdev dequeue API to sleep when
the port queue is empty and gets wakeup when event arrives
at the port. Port dequeue mode is configured using devargs
argument port_dequeue_wait. Supported modes are polling and
interrupt. Default mode is polling.
This commit also adds code to handle device error interrupts
and print alarm details.

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 doc/guides/eventdevs/dlb2.rst              |  20 +
 drivers/event/dlb2/dlb2.c                  | 236 +++++-
 drivers/event/dlb2/dlb2_iface.c            |   7 +
 drivers/event/dlb2/dlb2_iface.h            |   8 +
 drivers/event/dlb2/dlb2_priv.h             |  18 +
 drivers/event/dlb2/dlb2_user.h             | 112 +++
 drivers/event/dlb2/pf/base/dlb2_hw_types.h |  70 ++
 drivers/event/dlb2/pf/base/dlb2_osdep.h    |  46 ++
 drivers/event/dlb2/pf/base/dlb2_regs.h     | 149 +++-
 drivers/event/dlb2/pf/base/dlb2_resource.c | 825 +++++++++++++++++++++
 drivers/event/dlb2/pf/base/dlb2_resource.h |   6 +
 drivers/event/dlb2/pf/dlb2_pf.c            | 223 ++++++
 12 files changed, 1711 insertions(+), 9 deletions(-)

diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index 8ec7168f20..a4ba857351 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -477,6 +477,26 @@ Example command to use as meson option for credit handling:
 
        meson configure -Dc_args='-DDLB_SW_CREDITS_CHECKS=0 -DDLB_HW_CREDITS_CHECKS=1'
 
+Interrupt Mode Support
+~~~~~~~~~~~~~~~~~~~~~~
+DLB dequeue supports interrupt mode for the API rte_event_dequeue_burst().
+The default port dequeue mode is polling. Dequeue wait mode can be configured
+on per eventdev port basis using devargs argument 'port_dequeue_wait'. In
+interrupt mode, if the port queue is empty, the application thread will block
+on the interrupt until a new event arrives. It enters blocking mode only after
+any specified timeout. During the timeout, it will poll the port queue for
+events as usual. Interrupt mode uses the DPDK interrupt support framework.
+
+    .. code-block:: console
+
+       --allow ea:00.0,port_dequeue_wait=all:interrupt
+
+        port = all/<port-id>/<port-id>-<port-id>
+        mode = interrupt/polling
+
+Eventdev port interrupt and polling wait modes for dequeue can be set for all
+the ports, a single port, or a range of ports using this parameter.
+
 Running Eventdev Applications with DLB Device
 ---------------------------------------------
 
diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 084875f1c8..c3e40bd707 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -185,6 +185,22 @@ dlb2_init_queue_depth_thresholds(struct dlb2_eventdev *dlb2,
 	}
 }
 
+/* override defaults with value(s) provided on command line */
+static int
+dlb2_init_port_dequeue_wait(struct dlb2_eventdev *dlb2,
+					enum dlb2_port_dequeue_wait_types
+					*port_dequeue_wait_modes)
+{
+	int p;
+
+	for (p = 0; p < DLB2_MAX_NUM_PORTS(dlb2->version); p++) {
+		if (port_dequeue_wait_modes[p] != 0)
+			dlb2->ev_ports[p].qm_port.dequeue_wait =
+				port_dequeue_wait_modes[p];
+	}
+	return 0;
+}
+
 /* override defaults with value(s) provided on command line */
 static void
 dlb2_init_port_cos(struct dlb2_eventdev *dlb2, int *port_cos)
@@ -867,6 +883,111 @@ set_qid_depth_thresh_v2_5(const char *key __rte_unused,
 	return 0;
 }
 
+static int
+set_port_dequeue_wait_ver(const char *key __rte_unused,
+			  const char *value,
+			  void *opaque,
+			  int version)
+{
+	struct dlb2_port_dequeue_wait *dequeue_wait = opaque;
+	int first, last;
+	enum dlb2_port_dequeue_wait_types wait;
+	const char *valp = value;
+	bool port_list[DLB2_MAX_NUM_PORTS_ALL] = {false};
+	int lmax = DLB2_MAX_NUM_PORTS(version);
+	int len;
+	int lc;
+
+	if (value == NULL || opaque == NULL) {
+		DLB2_LOG_ERR("NULL pointer");
+		return -EINVAL;
+	}
+
+	/* command line override may take a combination of the following forms:
+	 * port_dequeue_wait=all:<wait_mode> ... all ports
+	 * port_dequeue_wait=portA-portB:<wait_mode> ... a range of ports
+	 * port_dequeue_wait=portA:<wait_mode> ... just one port
+	 */
+
+	do {
+		do {
+			if (strncmp(valp, "all", 3) == 0) {
+				for (lc = 0; lc < lmax; lc++)
+					port_list[lc] = true;
+				valp += 3;
+			} else if (sscanf(valp, "%d-%d%n",
+					  &first,
+					  &last,
+					  &len) == 2) {
+				if ((first < 0) ||
+				    (last >= lmax) ||
+				    (first > last)) {
+					DLB2_LOG_ERR("Invalid portId");
+					return -EINVAL;
+				}
+				for (lc = first; lc <= last; lc++)
+					port_list[lc] = true;
+				valp += len;
+			} else if (sscanf(valp, "%d%n",
+					  &first,
+					  &len) == 1) {
+				if ((first < 0) ||
+				    (first >= lmax)) {
+					DLB2_LOG_ERR("Invalid portId");
+					return -EINVAL;
+				}
+				port_list[first] = true;
+				valp += len;
+			}
+		} while (strncmp(valp, "+", 1) == 0);
+
+		if (strncmp(valp++, ":", 1) == 0) {
+			if (strncmp(valp, "interrupt", 9) == 0) {
+				wait = DLB2_PORT_DEQUEUE_WAIT_INTERRUPT;
+				len = 9;
+			} else if (strncmp(valp, "polling", 7) == 0) {
+				wait = DLB2_PORT_DEQUEUE_WAIT_POLLING;
+				len = 7;
+			} else if (strncmp(valp, "umwait", 6) == 0) {
+				wait = DLB2_PORT_DEQUEUE_WAIT_UMWAIT;
+				len = 6;
+			} else {
+				DLB2_LOG_ERR("Error parsing port wait mode devarg, invalid mode");
+				return -EINVAL;
+			}
+
+			valp += len;
+
+			for (lc = 0; lc < lmax; lc++)
+				if (port_list[lc]) {
+					dequeue_wait->val[lc] = wait;
+					port_list[lc] = false;
+				}
+		} else {
+			DLB2_LOG_ERR("Error parsing port wait mode devarg. Should be all:val, portId-portId:val, or portId:val");
+			return -EINVAL;
+		}
+	} while (strncmp(valp++, "_", 1) == 0);
+
+	return 0;
+}
+
+static int
+set_port_dequeue_wait(const char *key __rte_unused,
+		      const char *value,
+		      void *opaque)
+{
+	return set_port_dequeue_wait_ver(key, value, opaque, DLB2_HW_V2);
+}
+
+static int
+set_port_dequeue_wait_v2_5(const char *key __rte_unused,
+		      const char *value,
+		      void *opaque)
+{
+	return set_port_dequeue_wait_ver(key, value, opaque, DLB2_HW_V2_5);
+}
+
 static void
 dlb2_eventdev_info_get(struct rte_eventdev *dev,
 		       struct rte_event_dev_info *dev_info)
@@ -3694,6 +3815,60 @@ dlb2_port_credits_inc(struct dlb2_port *qm_port, int num)
 	}
 }
 
+static inline void
+dlb2_issue_int_arm_hcw(struct dlb2_port *qm_port)
+{
+	struct process_local_port_data *port_data;
+	struct dlb2_enqueue_qe *qe;
+
+	RTE_ASSERT(qm_port->config_state == DLB2_CONFIGURED);
+
+	qe = qm_port->int_arm_qe;
+
+	/* No store fence needed since no pointer is being sent */
+
+	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
+
+	dlb2_pp_write(port_data, qe);
+
+	DLB2_LOG_LINE_DBG("dlb2: issued interrupt_arm QE");
+
+	qm_port->int_armed = true;
+}
+
+static inline int
+dlb2_block_on_cq_interrupt(struct dlb2_hw_dev *handle,
+			   struct dlb2_port *qm_port,
+			   struct dlb2_eventdev_port *ev_port)
+{
+	struct process_local_port_data *port_data;
+	int ret;
+
+	if (!qm_port->int_armed)
+		dlb2_issue_int_arm_hcw(qm_port);
+
+	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
+
+	/* Note: it's safe to access the per-process cq_base address here,
+	 * since the PMD won't block on the CQ until after attempting at least
+	 * one CQ dequeue.
+	 */
+	ret = dlb2_iface_block_on_cq_interrupt(handle,
+					qm_port->id,
+					!ev_port->qm_port.is_directed,
+					&port_data->cq_base[qm_port->cq_idx],
+					qm_port->gen_bit,
+					false);
+
+	if (ret == EPERM)
+		DLB2_LOG_LINE_DBG("dlb2: Not enough interrupts available (for VF)");
+
+	/* If the CQ int ioctl was unsuccessful, the interrupt remains armed */
+	qm_port->int_armed = (ret != 0);
+
+	return ret;
+}
+
 #define CLB_MASK_IDX 0
 #define CLB_VAL_IDX 1
 static int
@@ -3711,8 +3886,10 @@ dlb2_dequeue_wait(struct dlb2_eventdev *dlb2,
 		  uint64_t timeout,
 		  uint64_t start_ticks)
 {
+	struct dlb2_hw_dev *handle = &dlb2->qm_instance;
 	struct process_local_port_data *port_data;
 	uint64_t elapsed_ticks;
+	int ret;
 
 	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
 
@@ -3720,15 +3897,30 @@ dlb2_dequeue_wait(struct dlb2_eventdev *dlb2,
 
 	/* Wait/poll time expired */
 	if (elapsed_ticks >= timeout) {
-		/* Return all credits before blocking if remaining credits in
-		 * system is less than quanta.
-		 */
-		uint32_t sw_inflights = rte_atomic_load_explicit(&dlb2->inflights,
-			rte_memory_order_seq_cst);
-		uint32_t quanta = ev_port->credit_update_quanta;
+		if (dlb2->run_state == DLB2_RUN_STATE_STARTED &&
+			qm_port->dequeue_wait == DLB2_PORT_DEQUEUE_WAIT_INTERRUPT) {
+			/* Return all credits before blocking if remaining credits in
+			 * system is less than quanta.
+			 */
+			uint32_t sw_inflights = rte_atomic_load_explicit(&dlb2->inflights,
+				rte_memory_order_seq_cst);
+			uint32_t quanta = ev_port->credit_update_quanta;
+
+			if (dlb2->new_event_limit - sw_inflights < quanta)
+				dlb2_check_and_return_credits(ev_port, true, 0);
+
+			/* Block on CQ interrupt. */
+			ret = dlb2_block_on_cq_interrupt(handle, qm_port,
+					ev_port);
+			if (ret != 0) {
+				DLB2_LOG_LINE_DBG("dlb2: wait for interrupt ret=%d", ret);
+				rte_errno = ret;
+				return 1;
+			}
 
-		if (dlb2->new_event_limit - sw_inflights < quanta)
-			dlb2_check_and_return_credits(ev_port, true, 0);
+			DLB2_INC_STAT(ev_port->stats.traffic.rx_interrupt_wait, 1);
+			return 0;
+		}
 		return 1;
 	} else if (dlb2->umwait_allowed) {
 		struct rte_power_monitor_cond pmc;
@@ -5054,6 +5246,13 @@ dlb2_primary_eventdev_probe(struct rte_eventdev *dev,
 	dlb2_init_queue_depth_thresholds(dlb2,
 					 dlb2_args->qid_depth_thresholds.val);
 
+	err = dlb2_init_port_dequeue_wait(dlb2,
+				dlb2_args->port_dequeue_wait.val);
+	if (err) {
+		DLB2_LOG_ERR("dlb2: failed to init port_dequeue_wait, err=%d", err);
+		return err;
+	}
+
 	dlb2_init_port_cos(dlb2,
 			   dlb2_args->port_cos.cos_id);
 
@@ -5199,6 +5398,7 @@ dlb2_parse_params(const char *params,
 					     DLB2_NUM_DIR_CREDITS,
 					     DEV_ID_ARG,
 					     DLB2_QID_DEPTH_THRESH_ARG,
+							 DLB2_PORT_DEQUEUE_WAIT_ARG,
 					     DLB2_POLL_INTERVAL_ARG,
 					     DLB2_SW_CREDIT_QUANTA_ARG,
 					     DLB2_HW_CREDIT_QUANTA_ARG,
@@ -5293,6 +5493,26 @@ dlb2_parse_params(const char *params,
 				return ret;
 			}
 
+			if (version == DLB2_HW_V2) {
+				ret = rte_kvargs_process(
+					kvlist,
+					DLB2_PORT_DEQUEUE_WAIT_ARG,
+					set_port_dequeue_wait,
+					&dlb2_args->port_dequeue_wait);
+			} else {
+				ret = rte_kvargs_process(
+					kvlist,
+					DLB2_PORT_DEQUEUE_WAIT_ARG,
+					set_port_dequeue_wait_v2_5,
+					&dlb2_args->port_dequeue_wait);
+			}
+			if (ret != 0) {
+				DLB2_LOG_ERR("%s: Error parsing port_dequeue_wait parameter",
+					     name);
+				rte_kvargs_free(kvlist);
+				return ret;
+			}
+
 			ret = rte_kvargs_process(kvlist, DLB2_POLL_INTERVAL_ARG,
 						 set_poll_interval,
 						 &dlb2_args->poll_interval);
diff --git a/drivers/event/dlb2/dlb2_iface.c b/drivers/event/dlb2/dlb2_iface.c
index 3caa827d31..ddfebbe16b 100644
--- a/drivers/event/dlb2/dlb2_iface.c
+++ b/drivers/event/dlb2/dlb2_iface.c
@@ -61,6 +61,11 @@ int (*dlb2_iface_map_qid)(struct dlb2_hw_dev *handle,
 int (*dlb2_iface_unmap_qid)(struct dlb2_hw_dev *handle,
 			    struct dlb2_unmap_qid_args *cfg);
 
+int (*dlb2_iface_block_on_cq_interrupt)(struct dlb2_hw_dev *handle,
+					int port_id, bool is_ldb,
+					volatile void *cq_va, uint8_t cq_gen,
+					bool arm);
+
 int (*dlb2_iface_pending_port_unmaps)(struct dlb2_hw_dev *handle,
 				struct dlb2_pending_port_unmaps_args *args);
 
@@ -82,3 +87,5 @@ int (*dlb2_iface_set_cq_inflight_ctrl)(struct dlb2_hw_dev *handle,
 int (*dlb2_iface_set_cos_bw)(struct dlb2_hw_dev *handle,
 			     struct dlb2_set_cos_bw_args *args);
 
+int (*dlb2_iface_port_ctrl)(struct dlb2_port *qm_port, bool enable);
+
diff --git a/drivers/event/dlb2/dlb2_iface.h b/drivers/event/dlb2/dlb2_iface.h
index c78a8ffb7c..1a2ad33fa5 100644
--- a/drivers/event/dlb2/dlb2_iface.h
+++ b/drivers/event/dlb2/dlb2_iface.h
@@ -60,6 +60,12 @@ extern int (*dlb2_iface_map_qid)(struct dlb2_hw_dev *handle,
 extern int (*dlb2_iface_unmap_qid)(struct dlb2_hw_dev *handle,
 				   struct dlb2_unmap_qid_args *cfg);
 
+extern int (*dlb2_iface_block_on_cq_interrupt)(struct dlb2_hw_dev *handle,
+				int port_id, bool is_ldb,
+				volatile void *cq_va,
+				uint8_t cq_gen,
+				bool arm);
+
 extern int (*dlb2_iface_pending_port_unmaps)(struct dlb2_hw_dev *handle,
 				struct dlb2_pending_port_unmaps_args *args);
 
@@ -81,4 +87,6 @@ extern int (*dlb2_iface_set_cq_inflight_ctrl)(struct dlb2_hw_dev *handle,
 extern int (*dlb2_iface_set_cos_bw)(struct dlb2_hw_dev *handle,
 				    struct dlb2_set_cos_bw_args *args);
 
+extern int (*dlb2_iface_port_ctrl)(struct dlb2_port *qm_port, bool enable);
+
 #endif /* _DLB2_IFACE_H_ */
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 7a5cbcca1e..db41a0f259 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -41,6 +41,7 @@
 #define DLB2_NUM_DIR_CREDITS "num_dir_credits"
 #define DEV_ID_ARG "dev_id"
 #define DLB2_QID_DEPTH_THRESH_ARG "qid_depth_thresh"
+#define DLB2_PORT_DEQUEUE_WAIT_ARG "port_dequeue_wait"
 #define DLB2_POLL_INTERVAL_ARG "poll_interval"
 #define DLB2_SW_CREDIT_QUANTA_ARG "sw_credit_quanta"
 #define DLB2_HW_CREDIT_QUANTA_ARG "hw_credit_quanta"
@@ -95,6 +96,14 @@
 #define DLB2_MAX_LDB_SN_ALLOC 1024
 #define DLB2_MAX_QUEUE_DEPTH_THRESHOLD 8191
 #define DLB2_MAX_NUM_LDB_PORTS_PER_COS (DLB2_MAX_NUM_LDB_PORTS/DLB2_COS_NUM_VALS)
+#define DLB2_COREMASK_LEN 36
+
+enum dlb2_port_dequeue_wait_types {
+	DLB2_PORT_DEQUEUE_WAIT_POLLING,
+	DLB2_PORT_DEQUEUE_WAIT_INTERRUPT,
+	DLB2_PORT_DEQUEUE_WAIT_UMWAIT,
+	DLB2_NUM_PORT_DEQUEUE_WAIT_TYPES /* Must be last */
+};
 
 /* 2048 total hist list entries and 64 total ldb ports, which
  * makes for 2048/64 == 32 hist list entries per port. However, CQ
@@ -387,8 +396,10 @@ struct dlb2_port {
 	struct dlb2_cq_pop_qe *consume_qe;
 	struct dlb2_eventdev *dlb2; /* back ptr */
 	struct dlb2_eventdev_port *ev_port; /* back ptr */
+	enum dlb2_port_dequeue_wait_types dequeue_wait;
 	bool use_scalar; /* force usage of scalar code */
 	uint8_t reorder_id; /* id used for reordering events coming back into the scheduler */
+	uint8_t evdev_id; /* index into process-local multidev mapping array */
 	uint16_t hw_credit_quanta;
 	bool use_avx512;
 	bool enable_inflight_ctrl; /*DLB2.5 enable HW inflight control */
@@ -665,6 +676,12 @@ struct dlb2_qid_depth_thresholds {
 	int val[DLB2_MAX_NUM_QUEUES_ALL];
 };
 
+/* used for collecting and passing around the dev args */
+struct dlb2_port_dequeue_wait {
+	enum dlb2_port_dequeue_wait_types val[DLB2_MAX_NUM_PORTS_ALL];
+};
+
+
 struct dlb2_port_cos {
 	int cos_id[DLB2_MAX_NUM_PORTS_ALL];
 };
@@ -679,6 +696,7 @@ struct dlb2_devargs {
 	int num_dir_credits_override;
 	int dev_id;
 	struct dlb2_qid_depth_thresholds qid_depth_thresholds;
+	struct dlb2_port_dequeue_wait port_dequeue_wait;
 	int poll_interval;
 	int sw_credit_quanta;
 	int hw_credit_quanta;
diff --git a/drivers/event/dlb2/dlb2_user.h b/drivers/event/dlb2/dlb2_user.h
index 4410da8db0..ec0e5c78cd 100644
--- a/drivers/event/dlb2/dlb2_user.h
+++ b/drivers/event/dlb2/dlb2_user.h
@@ -365,6 +365,118 @@ struct dlb2_query_cq_poll_mode_args {
 	struct dlb2_cmd_response response;
 };
 
+
+/*******************************/
+/* 'domain' device file alerts */
+/*******************************/
+
+/*
+ * Scheduling domain device files can be read to receive domain-specific
+ * notifications, for alerts such as hardware errors or device reset.
+ *
+ * Each alert is encoded in a 16B message. The first 8B contains the alert ID,
+ * and the second 8B is optional and contains additional information.
+ * Applications should cast read data to a struct dlb2_domain_alert, and
+ * interpret the struct's alert_id according to dlb2_domain_alert_id. The read
+ * length must be 16B, or the function will return -EINVAL.
+ *
+ * Reads are destructive, and in the case of multiple file descriptors for the
+ * same domain device file, an alert will be read by only one of the file
+ * descriptors.
+ *
+ * The driver stores alerts in a fixed-size alert ring until they are read. If
+ * the alert ring fills completely, subsequent alerts will be dropped. It is
+ * recommended that DLB2 applications dedicate a thread to perform blocking
+ * reads on the device file.
+ */
+enum dlb2_domain_alert_id {
+	/*
+	 * Software issued an illegal enqueue for a port in this domain. An
+	 * illegal enqueue could be:
+	 * - Illegal (excess) completion
+	 * - Illegal fragment
+	 * - Insufficient credits
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ,
+	/*
+	 * Software issued excess CQ token pops for a port in this domain.
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS,
+	/*
+	 * A enqueue contained either an invalid command encoding or a REL,
+	 * REL_T, RLS, FWD, FWD_T, FRAG, or FRAG_T from a directed port.
+	 *
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_ILLEGAL_HCW,
+	/*
+	 * The QID must be valid and less than 128.
+	 *
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_ILLEGAL_QID,
+	/*
+	 * An enqueue went to a disabled QID.
+	 *
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_DISABLED_QID,
+	/*
+	 * The device containing this domain was reset. All applications using
+	 * the device need to exit for the driver to complete the reset
+	 * procedure.
+	 *
+	 * aux_alert_data doesn't contain any information for this alert.
+	 */
+	DLB2_DOMAIN_ALERT_DEVICE_RESET,
+	/*
+	 * User-space has enqueued an alert.
+	 *
+	 * aux_alert_data contains user-provided data.
+	 */
+	DLB2_DOMAIN_ALERT_USER,
+	/*
+	 * The watchdog timer fired for the specified port. This occurs if its
+	 * CQ was not serviced for a large amount of time, likely indicating a
+	 * hung thread.
+	 * aux_alert_data[7:0] contains the port ID, and aux_alert_data[15:8]
+	 * contains a flag indicating whether the port is load-balanced (1) or
+	 * directed (0).
+	 */
+	DLB2_DOMAIN_ALERT_CQ_WATCHDOG_TIMEOUT,
+
+	/* Number of DLB2 domain alerts */
+	NUM_DLB2_DOMAIN_ALERTS
+};
+
+static const char dlb2_domain_alert_strings[][128] = {
+	"DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ",
+	"DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS",
+	"DLB2_DOMAIN_ALERT_ILLEGAL_HCW",
+	"DLB2_DOMAIN_ALERT_ILLEGAL_QID",
+	"DLB2_DOMAIN_ALERT_DISABLED_QID",
+	"DLB2_DOMAIN_ALERT_DEVICE_RESET",
+	"DLB2_DOMAIN_ALERT_USER",
+	"DLB2_DOMAIN_ALERT_CQ_WATCHDOG_TIMEOUT",
+};
+
+struct dlb2_domain_alert {
+	__u64 alert_id;
+	__u64 aux_alert_data;
+};
+
 /********************************/
 /* 'scheduling domain' commands */
 /********************************/
diff --git a/drivers/event/dlb2/pf/base/dlb2_hw_types.h b/drivers/event/dlb2/pf/base/dlb2_hw_types.h
index 6a935f0bcd..9eeeeac750 100644
--- a/drivers/event/dlb2/pf/base/dlb2_hw_types.h
+++ b/drivers/event/dlb2/pf/base/dlb2_hw_types.h
@@ -18,6 +18,11 @@
 #define DLB2_BIT_SET(x, mask)	((x) |= (mask))
 #define DLB2_BITS_GET(x, mask)	(((x) & (mask)) >> (mask##_LOC))
 
+#define DLB2_SYND2(y)        DLB2_BITS_GET(synd2, DLB2_SYS_ALARM_PF_SYND2_##y)
+#define DLB2_SYND1(y)        DLB2_BITS_GET(synd1, DLB2_SYS_ALARM_PF_SYND1_##y)
+#define DLB2_SYND0(y)        DLB2_BITS_GET(synd0, DLB2_SYS_ALARM_PF_SYND0_##y)
+#define DLB2_SYND(y)         DLB2_BITS_GET(synd, DLB2_SYS_ALARM_HW_SYND_##y)
+
 #define DLB2_MAX_NUM_VDEVS			16
 #define DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS	2
 #define DLB2_NUM_ARB_WEIGHTS			8
@@ -38,6 +43,22 @@
 #define PCI_DEVICE_ID_INTEL_DLB2_5_PF 0x2714
 #define PCI_DEVICE_ID_INTEL_DLB2_5_VF 0x2715
 
+/* Interrupt related macros */
+#define DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS 1
+#define DLB2_PF_NUM_CQ_INTERRUPT_VECTORS     64
+#define DLB2_PF_TOTAL_NUM_INTERRUPT_VECTORS \
+	(DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS + \
+	DLB2_PF_NUM_CQ_INTERRUPT_VECTORS)
+#define DLB2_PF_NUM_COMPRESSED_MODE_VECTORS \
+	(DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS + 1)
+#define DLB2_PF_NUM_PACKED_MODE_VECTORS \
+	DLB2_PF_TOTAL_NUM_INTERRUPT_VECTORS
+#define DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID \
+	DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS
+
+/* DLB non-CQ interrupts (alarm, mailbox, WDT) */
+#define DLB2_INT_NON_CQ 0
+
 #define DLB2_ALARM_HW_SOURCE_SYS 0
 #define DLB2_ALARM_HW_SOURCE_DLB 1
 
@@ -334,6 +355,49 @@ struct dlb2_sw_mbox {
 	void *pf_to_vdev_inject_arg;
 };
 
+enum dlb2_wake_reason {
+	WAKE_CQ_INTR,
+	WAKE_PORT_DISABLED,
+	WAKE_DEV_RESET
+};
+
+struct dlb2_cq_intr {
+	/*
+	 * The CQ interrupt mutex guarantees one thread is blocking on a CQ's
+	 * interrupt at a time.
+	 */
+	pthread_mutex_t mutex;
+	int efd;
+	u8 configured;
+	u8 reason;
+	/*
+	 * disabled is true if the port is disabled. In that
+	 * case, the driver doesn't allow applications to block on the
+	 * port's interrupt.
+	 */
+	u8 disabled;
+};
+
+struct dlb2_intr {
+	struct dlb2_cq_intr ldb_cq_intr[DLB2_MAX_NUM_LDB_PORTS];
+	struct dlb2_cq_intr dir_cq_intr[DLB2_MAX_NUM_DIR_PORTS_V2_5];
+};
+
+/*
+ * ISR overload is defined as more than DLB2_ISR_OVERLOAD_THRESH interrupts
+ * (of a particular type) occurring in a 1s period. If overload is detected,
+ * the driver blocks that interrupt (exact mechanism depending on the
+ * interrupt) from overloading the PF driver.
+ */
+#define DLB2_ISR_OVERLOAD_THRESH   1000
+#define DLB2_ISR_OVERLOAD_PERIOD_S 1
+
+struct dlb2_alarm {
+	struct timespec ts;
+	unsigned int enabled;
+	u32 count;
+};
+
 struct dlb2_hw {
 	uint8_t ver;
 
@@ -359,6 +423,12 @@ struct dlb2_hw {
 	int virt_mode;
 	struct dlb2_sw_mbox mbox[DLB2_MAX_NUM_VDEVS];
 	unsigned int pasid[DLB2_MAX_NUM_VDEVS];
+
+	/* Interrupts */
+	struct dlb2_intr intr;
+
+	/* Alarms*/
+	struct dlb2_alarm ingress_err;
 };
 
 #endif /* __DLB2_HW_TYPES_NEW_H */
diff --git a/drivers/event/dlb2/pf/base/dlb2_osdep.h b/drivers/event/dlb2/pf/base/dlb2_osdep.h
index 382a49090a..2690f584f1 100644
--- a/drivers/event/dlb2/pf/base/dlb2_osdep.h
+++ b/drivers/event/dlb2/pf/base/dlb2_osdep.h
@@ -8,6 +8,8 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
+#include <sys/eventfd.h>
+#include <pthread.h>
 
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
@@ -129,6 +131,50 @@ static inline void os_fence_hcw(struct dlb2_hw *hw, u64 *pp_addr)
 	*(volatile u64 *)pp_addr;
 }
 
+/**
+ * os_enqueue_four_hcws() - enqueue four HCWs to DLB
+ * @hw: dlb2_hw handle for a particular device.
+ * @hcw: pointer to the 64B-aligned contiguous HCW memory
+ * @addr: producer port address
+ */
+static inline void os_enqueue_four_hcws(struct dlb2_hw *hw,
+					struct dlb2_hcw *hcw,
+					void *addr)
+{
+	struct dlb2_dev *dlb2_dev;
+	dlb2_dev = container_of(hw, struct dlb2_dev, hw);
+
+	dlb2_dev->enqueue_four(addr, hcw);
+}
+
+/**
+ * os_notify_user_space() - notify user space
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: ID of domain to notify.
+ * @alert_id: alert ID.
+ * @aux_alert_data: additional alert data.
+ *
+ * This function notifies user space of an alert (such as a hardware alarm).
+ *
+ * Return:
+ * Returns 0 upon success, <0 otherwise.
+ */
+static inline int os_notify_user_space(struct dlb2_hw *hw,
+				       u32 domain_id,
+				       u64 alert_id,
+				       u64 aux_alert_data)
+{
+	RTE_SET_USED(hw);
+
+	const char *port_type = (aux_alert_data >> 8) ? "LDB" : "DIR";
+	int port_id = aux_alert_data & 0xFF;
+
+	DLB2_ERR(hw, " Domain:%d alert:%"PRIu64" %s port:%d\n",
+		domain_id, alert_id, port_type, port_id);
+
+	return 0;
+}
+
 /**
  * DLB2_HW_ERR() - log an error message
  * @dlb2: dlb2_hw handle for a particular device.
diff --git a/drivers/event/dlb2/pf/base/dlb2_regs.h b/drivers/event/dlb2/pf/base/dlb2_regs.h
index 193c19bfbd..24b27fbd2c 100644
--- a/drivers/event/dlb2/pf/base/dlb2_regs.h
+++ b/drivers/event/dlb2/pf/base/dlb2_regs.h
@@ -223,6 +223,68 @@
 #define DLB2_SYS_TOTAL_DIR_CRDS_TOTAL_DIR_CREDITS	0xFFFFFFFF
 #define DLB2_SYS_TOTAL_DIR_CRDS_TOTAL_DIR_CREDITS_LOC	0
 
+#define DLB2_SYS_ALARM_PF_SYND2 0x10000508
+#define DLB2_SYS_ALARM_PF_SYND2_RST 0x0
+
+#define DLB2_SYS_ALARM_PF_SYND2_LOCK_ID	0x0000FFFF
+#define DLB2_SYS_ALARM_PF_SYND2_MEAS		0x00010000
+#define DLB2_SYS_ALARM_PF_SYND2_DEBUG	0x00FE0000
+#define DLB2_SYS_ALARM_PF_SYND2_CQ_POP	0x01000000
+#define DLB2_SYS_ALARM_PF_SYND2_QE_UHL	0x02000000
+#define DLB2_SYS_ALARM_PF_SYND2_QE_ORSP	0x04000000
+#define DLB2_SYS_ALARM_PF_SYND2_QE_VALID	0x08000000
+#define DLB2_SYS_ALARM_PF_SYND2_CQ_INT_REARM	0x10000000
+#define DLB2_SYS_ALARM_PF_SYND2_DSI_ERROR	0x20000000
+#define DLB2_SYS_ALARM_PF_SYND2_RSVD0	0xC0000000
+#define DLB2_SYS_ALARM_PF_SYND2_LOCK_ID_LOC		0
+#define DLB2_SYS_ALARM_PF_SYND2_MEAS_LOC		16
+#define DLB2_SYS_ALARM_PF_SYND2_DEBUG_LOC		17
+#define DLB2_SYS_ALARM_PF_SYND2_CQ_POP_LOC		24
+#define DLB2_SYS_ALARM_PF_SYND2_QE_UHL_LOC		25
+#define DLB2_SYS_ALARM_PF_SYND2_QE_ORSP_LOC		26
+#define DLB2_SYS_ALARM_PF_SYND2_QE_VALID_LOC		27
+#define DLB2_SYS_ALARM_PF_SYND2_CQ_INT_REARM_LOC	28
+#define DLB2_SYS_ALARM_PF_SYND2_DSI_ERROR_LOC	29
+#define DLB2_SYS_ALARM_PF_SYND2_RSVD0_LOC		30
+
+#define DLB2_SYS_ALARM_PF_SYND1 0x10000504
+#define DLB2_SYS_ALARM_PF_SYND1_RST 0x0
+
+#define DLB2_SYS_ALARM_PF_SYND1_DSI		0x0000FFFF
+#define DLB2_SYS_ALARM_PF_SYND1_QID		0x00FF0000
+#define DLB2_SYS_ALARM_PF_SYND1_QTYPE	0x03000000
+#define DLB2_SYS_ALARM_PF_SYND1_QPRI		0x1C000000
+#define DLB2_SYS_ALARM_PF_SYND1_MSG_TYPE	0xE0000000
+#define DLB2_SYS_ALARM_PF_SYND1_DSI_LOC	0
+#define DLB2_SYS_ALARM_PF_SYND1_QID_LOC	16
+#define DLB2_SYS_ALARM_PF_SYND1_QTYPE_LOC	24
+#define DLB2_SYS_ALARM_PF_SYND1_QPRI_LOC	26
+#define DLB2_SYS_ALARM_PF_SYND1_MSG_TYPE_LOC	29
+
+#define DLB2_SYS_ALARM_PF_SYND0 0x10000500
+#define DLB2_SYS_ALARM_PF_SYND0_RST 0x0
+
+#define DLB2_SYS_ALARM_PF_SYND0_SYNDROME	0x000000FF
+#define DLB2_SYS_ALARM_PF_SYND0_RTYPE	0x00000300
+#define DLB2_SYS_ALARM_PF_SYND0_RSVD0	0x00001C00
+#define DLB2_SYS_ALARM_PF_SYND0_IS_LDB	0x00002000
+#define DLB2_SYS_ALARM_PF_SYND0_CLS		0x0000C000
+#define DLB2_SYS_ALARM_PF_SYND0_AID		0x003F0000
+#define DLB2_SYS_ALARM_PF_SYND0_UNIT		0x03C00000
+#define DLB2_SYS_ALARM_PF_SYND0_SOURCE	0x3C000000
+#define DLB2_SYS_ALARM_PF_SYND0_MORE		0x40000000
+#define DLB2_SYS_ALARM_PF_SYND0_VALID	0x80000000
+#define DLB2_SYS_ALARM_PF_SYND0_SYNDROME_LOC	0
+#define DLB2_SYS_ALARM_PF_SYND0_RTYPE_LOC	8
+#define DLB2_SYS_ALARM_PF_SYND0_RSVD0_LOC	10
+#define DLB2_SYS_ALARM_PF_SYND0_IS_LDB_LOC	13
+#define DLB2_SYS_ALARM_PF_SYND0_CLS_LOC	14
+#define DLB2_SYS_ALARM_PF_SYND0_AID_LOC	16
+#define DLB2_SYS_ALARM_PF_SYND0_UNIT_LOC	22
+#define DLB2_SYS_ALARM_PF_SYND0_SOURCE_LOC	26
+#define DLB2_SYS_ALARM_PF_SYND0_MORE_LOC	30
+#define DLB2_SYS_ALARM_PF_SYND0_VALID_LOC	31
+
 #define DLB2_SYS_TOTAL_LDB_CRDS 0x10000104
 #define DLB2_SYS_TOTAL_LDB_CRDS_RST 0x2000
 
@@ -1156,6 +1218,74 @@
 #define DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS_CQ_62_OCC_INT_LOC	30
 #define DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS_CQ_63_OCC_INT_LOC	31
 
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS 0x10000448
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_RST 0x0
+
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_64_OCC_INT	0x00000001
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_65_OCC_INT	0x00000002
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_66_OCC_INT	0x00000004
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_67_OCC_INT	0x00000008
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_68_OCC_INT	0x00000010
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_69_OCC_INT	0x00000020
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_70_OCC_INT	0x00000040
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_71_OCC_INT	0x00000080
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_72_OCC_INT	0x00000100
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_73_OCC_INT	0x00000200
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_74_OCC_INT	0x00000400
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_75_OCC_INT	0x00000800
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_76_OCC_INT	0x00001000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_77_OCC_INT	0x00002000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_78_OCC_INT	0x00004000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_79_OCC_INT	0x00008000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_80_OCC_INT	0x00010000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_81_OCC_INT	0x00020000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_82_OCC_INT	0x00040000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_83_OCC_INT	0x00080000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_84_OCC_INT	0x00100000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_85_OCC_INT	0x00200000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_86_OCC_INT	0x00400000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_87_OCC_INT	0x00800000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_88_OCC_INT	0x01000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_89_OCC_INT	0x02000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_90_OCC_INT	0x04000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_91_OCC_INT	0x08000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_92_OCC_INT	0x10000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_93_OCC_INT	0x20000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_94_OCC_INT	0x40000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_95_OCC_INT	0x80000000
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_64_OCC_INT_LOC	0
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_65_OCC_INT_LOC	1
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_66_OCC_INT_LOC	2
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_67_OCC_INT_LOC	3
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_68_OCC_INT_LOC	4
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_69_OCC_INT_LOC	5
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_70_OCC_INT_LOC	6
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_71_OCC_INT_LOC	7
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_72_OCC_INT_LOC	8
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_73_OCC_INT_LOC	9
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_74_OCC_INT_LOC	10
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_75_OCC_INT_LOC	11
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_76_OCC_INT_LOC	12
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_77_OCC_INT_LOC	13
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_78_OCC_INT_LOC	14
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_79_OCC_INT_LOC	15
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_80_OCC_INT_LOC	16
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_81_OCC_INT_LOC	17
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_82_OCC_INT_LOC	18
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_83_OCC_INT_LOC	19
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_84_OCC_INT_LOC	20
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_85_OCC_INT_LOC	21
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_86_OCC_INT_LOC	22
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_87_OCC_INT_LOC	23
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_88_OCC_INT_LOC	24
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_89_OCC_INT_LOC	25
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_90_OCC_INT_LOC	26
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_91_OCC_INT_LOC	27
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_92_OCC_INT_LOC	28
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_93_OCC_INT_LOC	29
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_94_OCC_INT_LOC	30
+#define DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS_CQ_95_OCC_INT_LOC	31
+
 #define DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS 0x10000460
 #define DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS_RST 0x0
 
@@ -2007,7 +2137,18 @@
 #define DLB2_CHP_CFG_CHP_CSR_CTRL_PAD_WRITE_DIR_LOC			20
 #define DLB2_CHP_CFG_CHP_CSR_CTRL_PAD_FIRST_WRITE_LDB_LOC		21
 #define DLB2_CHP_CFG_CHP_CSR_CTRL_PAD_FIRST_WRITE_DIR_LOC		22
-#define DLB2_CHP_CFG_CHP_CSR_CTRL_RSVZ0_LOC				23
+
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_L 0x4400000c
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_L_RST 0x0
+
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_L_COUNT       0xFFFFFFFF
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_L_COUNT_LOC   0
+
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_H 0x44000010
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_H_RST 0x0
+
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_H_COUNT       0xFFFFFFFF
+#define DLB2_CHP_CFG_CNTR_CHP_ERR_DROP_H_COUNT_LOC   0
 
 #define DLB2_V2CHP_DIR_CQ_INTR_ARMED0 0x4400005c
 #define DLB2_V2_5CHP_DIR_CQ_INTR_ARMED0 0x4400004c
@@ -2031,6 +2172,12 @@
 #define DLB2_CHP_DIR_CQ_INTR_ARMED1_ARMED	0xFFFFFFFF
 #define DLB2_CHP_DIR_CQ_INTR_ARMED1_ARMED_LOC	0
 
+#define DLB2_CHP_DIR_CQ_INTR_ARMED2 0x44000054
+#define DLB2_CHP_DIR_CQ_INTR_ARMED2_RST 0x0
+
+#define DLB2_CHP_DIR_CQ_INTR_ARMED2_ARMED      0xFFFFFFFF
+#define DLB2_CHP_DIR_CQ_INTR_ARMED2_ARMED_LOC  0
+
 #define DLB2_V2CHP_CFG_DIR_CQ_TIMER_CTL 0x44000084
 #define DLB2_V2_5CHP_CFG_DIR_CQ_TIMER_CTL 0x44000088
 #define DLB2_CHP_CFG_DIR_CQ_TIMER_CTL(ver) \
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 98f2f5ef92..0690258b1c 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -2757,6 +2757,7 @@ dlb2_domain_disable_ldb_port_interrupts(struct dlb2_hw *hw,
 {
 	struct dlb2_list_entry *iter;
 	struct dlb2_ldb_port *port;
+	struct dlb2_cq_intr *intr;
 	u32 int_en = 0;
 	u32 wd_en = 0;
 	int i;
@@ -2773,6 +2774,10 @@ dlb2_domain_disable_ldb_port_interrupts(struct dlb2_hw *hw,
 				    DLB2_CHP_LDB_CQ_WD_ENB(hw->ver,
 						      port->id.phys_id),
 				    wd_en);
+			intr = &hw->intr.ldb_cq_intr[port->id.phys_id];
+
+			if (intr->configured)
+				close(intr->efd);
 		}
 	}
 }
@@ -2783,6 +2788,7 @@ dlb2_domain_disable_dir_port_interrupts(struct dlb2_hw *hw,
 {
 	struct dlb2_list_entry *iter;
 	struct dlb2_dir_pq_pair *port;
+	struct dlb2_cq_intr *intr;
 	u32 int_en = 0;
 	u32 wd_en = 0;
 	RTE_SET_USED(iter);
@@ -2795,6 +2801,10 @@ dlb2_domain_disable_dir_port_interrupts(struct dlb2_hw *hw,
 		DLB2_CSR_WR(hw,
 			    DLB2_CHP_DIR_CQ_WD_ENB(hw->ver, port->id.phys_id),
 			    wd_en);
+		intr = &hw->intr.ldb_cq_intr[port->id.phys_id];
+
+		if (intr->configured)
+			close(intr->efd);
 	}
 }
 
@@ -6890,3 +6900,818 @@ int dlb2_hw_set_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id, u8 bandwidth)
 
 	return 0;
 }
+
+/**
+ * dlb2_cq_empty() - determine whether a CQ is empty
+ * @cq_va: User VA pointing to next CQ entry.
+ * @cq_gen: Current CQ generation bit.
+ *
+ * Return:
+ * Returns 1 if empty, 0 if non-empty, or < 0 if an error occurs.
+ */
+static int dlb2_cq_empty(volatile void *cq_va, u8 cq_gen)
+{
+	struct dlb2_dequeue_qe qe = *(volatile struct dlb2_dequeue_qe *)cq_va;
+
+	return qe.cq_gen != cq_gen;
+}
+
+int dlb2_block_on_cq_interrupt(struct dlb2_hw *dlb2,
+			       int port_id,
+			       bool is_ldb,
+			       volatile void *cq_va,
+			       u8 cq_gen,
+			       bool arm)
+{
+	struct dlb2_cq_intr *intr;
+	bool poll = false;
+	eventfd_t val;
+	int ret;
+
+	if (is_ldb && (unsigned int)port_id >= DLB2_MAX_NUM_LDB_PORTS)
+		return -EINVAL;
+	if (!is_ldb && (unsigned int)port_id >= DLB2_MAX_NUM_DIR_PORTS(dlb2->ver))
+		return -EINVAL;
+
+	if (is_ldb)
+		intr = &dlb2->intr.ldb_cq_intr[port_id];
+	else
+		intr = &dlb2->intr.dir_cq_intr[port_id];
+
+	if (!intr->configured)
+		return -EPERM;
+
+	/*
+	 * This function requires that only one thread process the CQ at a time.
+	 * Otherwise, the wake condition could become false in the time between
+	 * the ISR calling wake_up_interruptible() and the thread checking its
+	 * wake condition.
+	 */
+	pthread_mutex_lock(&intr->mutex);
+
+	/* Return early if the port's interrupt is disabled */
+	if (intr->disabled) {
+		pthread_mutex_unlock(&intr->mutex);
+		return -EACCES;
+	}
+
+	DLB2_HW_DBG(dlb2, "Thread is blocking on %s port %d's interrupt\n",
+		    (is_ldb) ? "LDB" : "DIR", port_id);
+
+	/* Don't block if the CQ is non-empty */
+	ret = dlb2_cq_empty(cq_va, cq_gen);
+	if (ret != 1)
+		goto error;
+
+	do {
+		if (arm) {
+			ret =  dlb2_arm_cq_interrupt(dlb2, port_id, is_ldb, 0, 0);
+			if (ret)
+				goto error;
+		}
+		if (poll) {
+			struct timespec start, curr;
+			u64 diff = 0;
+
+			clock_gettime(CLOCK_MONOTONIC, &start);
+
+			while (dlb2_cq_empty(cq_va, cq_gen) && diff < 1000) {
+				clock_gettime(CLOCK_MONOTONIC, &curr);
+				diff = (curr.tv_sec - start.tv_sec) * 1e+9 +
+					curr.tv_nsec - start.tv_nsec;
+			}
+		} else {
+			ret = eventfd_read(intr->efd, &val);
+		}
+		if (ret >= 0) {
+			if (intr->reason == WAKE_DEV_RESET)
+				ret = -EINTR;
+			else if (intr->reason == WAKE_PORT_DISABLED)
+				ret = -EACCES;
+		}
+
+		/* Need to handle cases where cq is empty even after interrupt.
+		 * This can happen either if there is a spurious interrupt or
+		 * data is still in transit. The code always first assumes it is
+		 * the latter case and polls for 1us to check if cq has data.
+		 * If not, it goes back to wait till next interrupt.
+		 */
+		poll ^= true;
+		arm = !poll;
+	} while (ret >= 0 && dlb2_cq_empty(cq_va, cq_gen));
+
+	DLB2_HW_DBG(dlb2, "Thread is unblocked from %s port %d's interrupt\n",
+		    (is_ldb) ? "LDB" : "DIR", port_id);
+
+error:
+	pthread_mutex_unlock(&intr->mutex);
+
+	return ret;
+}
+
+static struct dlb2_ldb_port *dlb2_get_ldb_port_from_id(struct dlb2_hw *hw,
+						u32 id,
+						bool vdev_req,
+						unsigned int vdev_id)
+{
+	RTE_SET_USED(vdev_req);
+	RTE_SET_USED(vdev_id);
+
+	if (id >= DLB2_MAX_NUM_LDB_PORTS)
+		return NULL;
+
+	return &hw->rsrcs.ldb_ports[id];
+}
+
+
+static struct dlb2_dir_pq_pair *dlb2_get_dir_pq_from_id(struct dlb2_hw *hw,
+						u32 id,
+						bool vdev_req,
+						unsigned int vdev_id)
+{
+	RTE_SET_USED(vdev_req);
+	RTE_SET_USED(vdev_id);
+
+	if (id >= DLB2_MAX_NUM_DIR_PORTS(hw->ver))
+		return NULL;
+
+	return &hw->rsrcs.dir_pq_pairs[id];
+}
+
+/**
+ * dlb2_arm_cq_interrupt() - arm a CQ's interrupt
+ * @hw: dlb2_hw handle for a particular device.
+ * @port_id: port ID
+ * @is_ldb: true for load-balanced port, false for a directed port
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function arms the CQ's interrupt. The CQ must be configured prior to
+ * calling this function.
+ *
+ * The function does no parameter validation; that is the caller's
+ * responsibility.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return: returns 0 upon success, <0 otherwise.
+ *
+ * EINVAL - Invalid port ID.
+ */
+int dlb2_arm_cq_interrupt(struct dlb2_hw *hw,
+			int port_id,
+			bool is_ldb,
+			bool vdev_req,
+			unsigned int vdev_id)
+{
+	u32 val;
+	u32 reg;
+	RTE_SET_USED(vdev_req);
+	RTE_SET_USED(vdev_id);
+
+	val = 1 << (port_id % 32);
+
+	if (is_ldb && port_id < 32)
+		reg = DLB2_CHP_LDB_CQ_INTR_ARMED0(hw->ver);
+	else if (is_ldb && port_id < 64)
+		reg = DLB2_CHP_LDB_CQ_INTR_ARMED1(hw->ver);
+	else if (!is_ldb && port_id < 32)
+		reg = DLB2_CHP_DIR_CQ_INTR_ARMED0(hw->ver);
+	else if (!is_ldb && port_id < 64)
+		reg = DLB2_CHP_DIR_CQ_INTR_ARMED1(hw->ver);
+	else
+		reg = DLB2_CHP_DIR_CQ_INTR_ARMED2;
+
+	DLB2_CSR_WR(hw, reg, val);
+
+	dlb2_flush_csr(hw);
+
+	return 0;
+}
+
+/**
+ * dlb2_configure_ldb_cq_interrupt() - configure load-balanced CQ for
+ *					interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @port_id: load-balanced port ID.
+ * @vector: interrupt vector ID. Should be 0 for MSI or compressed MSI-X mode,
+ *	    else a value up to 64.
+ * @mode: interrupt type (DLB2_CQ_ISR_MODE_MSI or DLB2_CQ_ISR_MODE_MSIX)
+ * @vf: If the port is VF-owned, the VF's ID. This is used for translating the
+ *	virtual port ID to a physical port ID. Ignored if mode is not MSI.
+ * @owner_vf: the VF to route the interrupt to. Ignore if mode is not MSI.
+ * @threshold: the minimum CQ depth at which the interrupt can fire. Must be
+ *	greater than 0.
+ *
+ * This function configures the DLB registers for load-balanced CQ's
+ * interrupts. This doesn't enable the CQ's interrupt; that can be done with
+ * dlb2_arm_cq_interrupt() or through an interrupt arm QE.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid.
+ */
+int dlb2_configure_ldb_cq_interrupt(struct dlb2_hw *hw,
+				    int port_id,
+				    int vector,
+				    int mode,
+				    unsigned int vf,
+				    unsigned int owner_vf,
+				    u16 threshold)
+{
+	struct dlb2_ldb_port *port;
+	bool vdev_req;
+	u32 reg = 0;
+
+	vdev_req = (mode == DLB2_CQ_ISR_MODE_MSI ||
+		    mode == DLB2_CQ_ISR_MODE_ADI);
+
+	port = dlb2_get_ldb_port_from_id(hw, port_id, vdev_req, vf);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s()]: Internal error: failed to enable LDB CQ int\n\tport_id: %u, vdev_req: %u, vdev: %u\n",
+			    __func__, port_id, vdev_req, vf);
+		return -EINVAL;
+	}
+
+	/* Trigger the interrupt when threshold or more QEs arrive in the CQ */
+	DLB2_BITS_SET(reg, threshold - 1,
+		 DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH_DEPTH_THRESHOLD);
+	DLB2_CSR_WR(hw, DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH(hw->ver,
+						   port->id.phys_id), reg);
+
+	reg = 0;
+	DLB2_BIT_SET(reg, DLB2_CHP_LDB_CQ_INT_ENB_EN_DEPTH);
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_INT_ENB(hw->ver, port->id.phys_id), reg);
+
+	reg = 0;
+	DLB2_BITS_SET(reg, vector, DLB2_SYS_LDB_CQ_ISR_VECTOR);
+	DLB2_BITS_SET(reg, owner_vf, DLB2_SYS_LDB_CQ_ISR_VF);
+	DLB2_BITS_SET(reg, mode, DLB2_SYS_LDB_CQ_ISR_EN_CODE);
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_CQ_ISR(port->id.phys_id), reg);
+
+	return 0;
+}
+/**
+ * dlb2_configure_dir_cq_interrupt() - configure directed CQ for interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @port_id: load-balanced port ID.
+ * @vector: interrupt vector ID. Should be 0 for MSI or compressed MSI-X mode,
+ *	    else a value up to 64.
+ * @mode: interrupt type (DLB2_CQ_ISR_MODE_MSI or DLB2_CQ_ISR_MODE_MSIX)
+ * @vf: If the port is VF-owned, the VF's ID. This is used for translating the
+ *	virtual port ID to a physical port ID. Ignored if mode is not MSI.
+ * @owner_vf: the VF to route the interrupt to. Ignore if mode is not MSI.
+ * @threshold: the minimum CQ depth at which the interrupt can fire. Must be
+ *	greater than 0.
+ *
+ * This function configures the DLB registers for directed CQ's interrupts.
+ * This doesn't enable the CQ's interrupt; that can be done with
+ * dlb2_arm_cq_interrupt() or through an interrupt arm QE.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid.
+ */
+int dlb2_configure_dir_cq_interrupt(struct dlb2_hw *hw,
+				    int port_id,
+				    int vector,
+				    int mode,
+				    unsigned int vf,
+				    unsigned int owner_vf,
+				    u16 threshold)
+{
+	struct dlb2_dir_pq_pair *port;
+	bool vdev_req;
+	u32 reg = 0;
+
+	vdev_req = (mode == DLB2_CQ_ISR_MODE_MSI ||
+		    mode == DLB2_CQ_ISR_MODE_ADI);
+
+	port = dlb2_get_dir_pq_from_id(hw, port_id, vdev_req, vf);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s()]: Internal error: failed to enable DIR CQ int\n\tport_id: %u, vdev_req: %u, vdev: %u\n",
+			    __func__, port_id, vdev_req, vf);
+		return -EINVAL;
+	}
+
+	/* Trigger the interrupt when threshold or more QEs arrive in the CQ */
+	DLB2_BITS_SET(reg, threshold - 1,
+		 DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH_DEPTH_THRESHOLD);
+	DLB2_CSR_WR(hw, DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH(hw->ver,
+						   port->id.phys_id), reg);
+
+	reg = 0;
+	DLB2_BIT_SET(reg, DLB2_CHP_DIR_CQ_INT_ENB_EN_DEPTH);
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_INT_ENB(hw->ver, port->id.phys_id), reg);
+
+	reg = 0;
+	DLB2_BITS_SET(reg, vector, DLB2_SYS_DIR_CQ_ISR_VECTOR);
+	DLB2_BITS_SET(reg, owner_vf, DLB2_SYS_DIR_CQ_ISR_VF);
+	DLB2_BITS_SET(reg, mode, DLB2_SYS_DIR_CQ_ISR_EN_CODE);
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_ISR(port->id.phys_id), reg);
+
+	return 0;
+}
+
+/**
+ * dlb2_read_compressed_cq_intr_status() - read compressed CQ interrupt status
+ * @hw: dlb2_hw handle for a particular device.
+ * @ldb_interrupts: 2-entry array of u32 bitmaps
+ * @dir_interrupts: 4-entry array of u32 bitmaps
+ *
+ * This function can be called from a compressed CQ interrupt handler to
+ * determine which CQ interrupts have fired. The caller should take appropriate
+ * (such as waking threads blocked on a CQ's interrupt) then ack the interrupts
+ * with dlb2_ack_compressed_cq_intr().
+ */
+void dlb2_read_compressed_cq_intr_status(struct dlb2_hw *hw,
+					 u32 *ldb_interrupts,
+					 u32 *dir_interrupts)
+{
+	/* Read every CQ's interrupt status */
+
+	ldb_interrupts[0] = DLB2_CSR_RD(hw, DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS);
+	ldb_interrupts[1] = DLB2_CSR_RD(hw, DLB2_SYS_LDB_CQ_63_32_OCC_INT_STS);
+
+	dir_interrupts[0] = DLB2_CSR_RD(hw, DLB2_SYS_DIR_CQ_31_0_OCC_INT_STS);
+	dir_interrupts[1] = DLB2_CSR_RD(hw, DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS);
+	if (hw->ver == DLB2_HW_V2_5)
+		dir_interrupts[2] = DLB2_CSR_RD(hw, DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS);
+}
+
+/**
+ * dlb2_ack_msix_interrupt() - Ack an MSI-X interrupt
+ * @hw: dlb2_hw handle for a particular device.
+ * @vector: interrupt vector.
+ *
+ * Note: Only needed for PF service interrupts (vector 0). CQ interrupts are
+ * acked in dlb2_ack_compressed_cq_intr().
+ */
+void dlb2_ack_msix_interrupt(struct dlb2_hw *hw, int vector)
+{
+	u32 ack = 0;
+
+	switch (vector) {
+	case 0:
+		DLB2_BIT_SET(ack, DLB2_SYS_MSIX_ACK_MSIX_0_ACK);
+		break;
+	case 1:
+		DLB2_BIT_SET(ack, DLB2_SYS_MSIX_ACK_MSIX_1_ACK);
+		/*
+		 * CSSY-1650
+		 * workaround h/w bug for lost MSI-X interrupts
+		 *
+		 * The recommended workaround for acknowledging
+		 * vector 1 interrupts is :
+		 *   1: set   MSI-X mask
+		 *   2: set   MSIX_PASSTHROUGH
+		 *   3: clear MSIX_ACK
+		 *   4: clear MSIX_PASSTHROUGH
+		 *   5: clear MSI-X mask
+		 *
+		 * The MSIX-ACK (step 3) is cleared for all vectors
+		 * below. We handle steps 1 & 2 for vector 1 here.
+		 *
+		 * The bitfields for MSIX_ACK and MSIX_PASSTHRU are
+		 * defined the same, so we just use the MSIX_ACK
+		 * value when writing to PASSTHRU.
+		 */
+
+		/* set MSI-X mask and passthrough for vector 1 */
+		DLB2_FUNC_WR(hw, DLB2_MSIX_VECTOR_CTRL(1), 1);
+		DLB2_CSR_WR(hw, DLB2_SYS_MSIX_PASSTHRU, ack);
+		break;
+	}
+
+	/* clear MSIX_ACK (write one to clear) */
+	DLB2_CSR_WR(hw, DLB2_SYS_MSIX_ACK, ack);
+
+	if (vector == 1) {
+		/*
+		 * finish up steps 4 & 5 of the workaround -
+		 * clear pasthrough and mask
+		 */
+		DLB2_CSR_WR(hw, DLB2_SYS_MSIX_PASSTHRU, 0);
+		DLB2_FUNC_WR(hw, DLB2_MSIX_VECTOR_CTRL(1), 0);
+	}
+
+	dlb2_flush_csr(hw);
+}
+
+/**
+ * dlb2_ack_compressed_cq_intr() - ack compressed CQ interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @ldb_interrupts: 2-entry array of u32 bitmaps
+ * @dir_interrupts: 4-entry array of u32 bitmaps
+ *
+ * This function ACKs compressed CQ interrupts. Its arguments should be the
+ * same ones passed to dlb2_read_compressed_cq_intr_status().
+ */
+void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
+				 u32 *ldb_interrupts,
+				 u32 *dir_interrupts)
+{
+	/* Write back the status regs to ack the interrupts */
+	if (ldb_interrupts[0])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS,
+			    ldb_interrupts[0]);
+	if (ldb_interrupts[1])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_CQ_63_32_OCC_INT_STS,
+			    ldb_interrupts[1]);
+
+	if (dir_interrupts[0])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_CQ_31_0_OCC_INT_STS,
+			    dir_interrupts[0]);
+	if (dir_interrupts[1])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS,
+			    dir_interrupts[1]);
+
+	if (hw->ver == DLB2_HW_V2_5 && dir_interrupts[2])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_CQ_95_64_OCC_INT_STS,
+			    dir_interrupts[2]);
+	dlb2_ack_msix_interrupt(hw, DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID);
+}
+
+/**
+ * dlb2_enable_ingress_error_alarms() - enable ingress error alarm interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ */
+void dlb2_enable_ingress_error_alarms(struct dlb2_hw *hw)
+{
+	u32 en;
+
+	en = DLB2_CSR_RD(hw, DLB2_SYS_INGRESS_ALARM_ENBL);
+
+	DLB2_BIT_SET(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_HCW);
+	DLB2_BIT_SET(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_PP);
+	DLB2_BIT_SET(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_PASID);
+	DLB2_BIT_SET(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_QID);
+	DLB2_BIT_SET(en, DLB2_SYS_INGRESS_ALARM_ENBL_DISABLED_QID);
+	DLB2_BIT_SET(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_LDB_QID_CFG);
+
+	DLB2_CSR_WR(hw, DLB2_SYS_INGRESS_ALARM_ENBL, en);
+}
+
+/**
+ * dlb2_disable_ingress_error_alarms() - disable ingress error alarm interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ */
+void dlb2_disable_ingress_error_alarms(struct dlb2_hw *hw)
+{
+	u32 en;
+
+	en = DLB2_CSR_RD(hw, DLB2_SYS_INGRESS_ALARM_ENBL);
+
+	DLB2_BITS_CLR(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_HCW);
+	DLB2_BITS_CLR(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_PP);
+	DLB2_BITS_CLR(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_PASID);
+	DLB2_BITS_CLR(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_QID);
+	DLB2_BITS_CLR(en, DLB2_SYS_INGRESS_ALARM_ENBL_DISABLED_QID);
+	DLB2_BITS_CLR(en, DLB2_SYS_INGRESS_ALARM_ENBL_ILLEGAL_LDB_QID_CFG);
+
+	DLB2_CSR_WR(hw, DLB2_SYS_INGRESS_ALARM_ENBL, en);
+}
+
+static void dlb2_log_alarm_syndrome(struct dlb2_hw *hw,
+				    const char *str,
+				    u32 synd)
+{
+	DLB2_HW_ERR(hw, "%s:\n", str);
+	DLB2_HW_ERR(hw, "\tsyndrome: 0x%x\n", DLB2_SYND(SYNDROME));
+	DLB2_HW_ERR(hw, "\trtype:    0x%x\n", DLB2_SYND(RTYPE));
+	DLB2_HW_ERR(hw, "\talarm:    0x%x\n", DLB2_SYND(ALARM));
+	DLB2_HW_ERR(hw, "\tcwd:      0x%x\n", DLB2_SYND(CWD));
+	DLB2_HW_ERR(hw, "\tvf_pf_mb: 0x%x\n", DLB2_SYND(VF_PF_MB));
+	DLB2_HW_ERR(hw, "\tcls:      0x%x\n", DLB2_SYND(CLS));
+	DLB2_HW_ERR(hw, "\taid:      0x%x\n", DLB2_SYND(AID));
+	DLB2_HW_ERR(hw, "\tunit:     0x%x\n", DLB2_SYND(UNIT));
+	DLB2_HW_ERR(hw, "\tsource:   0x%x\n", DLB2_SYND(SOURCE));
+	DLB2_HW_ERR(hw, "\tmore:     0x%x\n", DLB2_SYND(MORE));
+	DLB2_HW_ERR(hw, "\tvalid:    0x%x\n", DLB2_SYND(VALID));
+}
+
+/* Note: this array's contents must match dlb2_alert_id() */
+static const char dlb2_alert_strings[NUM_DLB2_DOMAIN_ALERTS][128] = {
+	[DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ] = "Illegal enqueue",
+	[DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS] = "Excess token pops",
+	[DLB2_DOMAIN_ALERT_ILLEGAL_HCW] = "Illegal HCW",
+	[DLB2_DOMAIN_ALERT_ILLEGAL_QID] = "Illegal QID",
+	[DLB2_DOMAIN_ALERT_DISABLED_QID] = "Disabled QID",
+};
+
+static void dlb2_log_pf_vf_syndrome(struct dlb2_hw *hw,
+				    const char *str,
+				    u32 synd0,
+				    u32 synd1,
+				    u32 synd2,
+				    u32 alert_id)
+{
+	DLB2_HW_ERR(hw, " %s:", str);
+	if (alert_id < NUM_DLB2_DOMAIN_ALERTS)
+		DLB2_HW_ERR(hw, " Alert: %s", dlb2_alert_strings[alert_id]);
+	DLB2_HW_ERR(hw, "\tsyndrome:     0x%x", DLB2_SYND0(SYNDROME));
+	DLB2_HW_ERR(hw, "\trtype:        0x%x", DLB2_SYND0(RTYPE));
+	DLB2_HW_ERR(hw, "\tis_ldb:       0x%x", DLB2_SYND0(IS_LDB));
+	DLB2_HW_ERR(hw, "\tcls:          0x%x", DLB2_SYND0(CLS));
+	DLB2_HW_ERR(hw, "\taid:          0x%x", DLB2_SYND0(AID));
+	DLB2_HW_ERR(hw, "\tunit:         0x%x", DLB2_SYND0(UNIT));
+	DLB2_HW_ERR(hw, "\tsource:       0x%x", DLB2_SYND0(SOURCE));
+	DLB2_HW_ERR(hw, "\tmore:         0x%x", DLB2_SYND0(MORE));
+	DLB2_HW_ERR(hw, "\tvalid:        0x%x", DLB2_SYND0(VALID));
+	DLB2_HW_ERR(hw, "\tdsi:          0x%x", DLB2_SYND1(DSI));
+	DLB2_HW_ERR(hw, "\tqid:          0x%x", DLB2_SYND1(QID));
+	DLB2_HW_ERR(hw, "\tqtype:        0x%x", DLB2_SYND1(QTYPE));
+	DLB2_HW_ERR(hw, "\tqpri:         0x%x", DLB2_SYND1(QPRI));
+	DLB2_HW_ERR(hw, "\tmsg_type:     0x%x", DLB2_SYND1(MSG_TYPE));
+	DLB2_HW_ERR(hw, "\tlock_id:      0x%x", DLB2_SYND2(LOCK_ID));
+	DLB2_HW_ERR(hw, "\tmeas:         0x%x", DLB2_SYND2(MEAS));
+	DLB2_HW_ERR(hw, "\tdebug:        0x%x", DLB2_SYND2(DEBUG));
+	DLB2_HW_ERR(hw, "\tcq_pop:       0x%x", DLB2_SYND2(CQ_POP));
+	DLB2_HW_ERR(hw, "\tqe_uhl:       0x%x", DLB2_SYND2(QE_UHL));
+	DLB2_HW_ERR(hw, "\tqe_orsp:      0x%x", DLB2_SYND2(QE_ORSP));
+	DLB2_HW_ERR(hw, "\tqe_valid:     0x%x", DLB2_SYND2(QE_VALID));
+	DLB2_HW_ERR(hw, "\tcq_int_rearm: 0x%x", DLB2_SYND2(CQ_INT_REARM));
+	DLB2_HW_ERR(hw, "\tdsi_error:    0x%x", DLB2_SYND2(DSI_ERROR));
+}
+
+static void dlb2_clear_syndrome_register(struct dlb2_hw *hw, u32 offset)
+{
+	u32 synd = 0;
+
+	DLB2_BIT_SET(synd, DLB2_SYS_ALARM_HW_SYND_VALID);
+	DLB2_BIT_SET(synd, DLB2_SYS_ALARM_HW_SYND_MORE);
+
+	DLB2_CSR_WR(hw, offset, synd);
+}
+
+/**
+ * dlb2_process_alarm_interrupt() - process an alarm interrupt
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function reads and logs the alarm syndrome, then acks the interrupt.
+ * This function should be called from the alarm interrupt handler when
+ * interrupt vector DLB2_INT_ALARM fires.
+ */
+void dlb2_process_alarm_interrupt(struct dlb2_hw *hw)
+{
+	u32 synd;
+
+	DLB2_HW_DBG(hw, "Processing alarm interrupt\n");
+
+	synd = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_HW_SYND);
+
+	dlb2_log_alarm_syndrome(hw, "HW alarm syndrome", synd);
+
+	dlb2_clear_syndrome_register(hw, DLB2_SYS_ALARM_HW_SYND);
+}
+
+/**
+ * dlb2_process_wdt_interrupt() - process watchdog timer interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function reads the watchdog timer interrupt cause registers to
+ * determine which port(s) had a watchdog timeout, and notifies the
+ * application(s) that own the port(s).
+ */
+void dlb2_process_wdt_interrupt(struct dlb2_hw *hw)
+{
+	u32 alert_id = DLB2_DOMAIN_ALERT_CQ_WATCHDOG_TIMEOUT;
+	u32 dwdto_0, dwdto_1;
+	u32 lwdto_0, lwdto_1;
+	int i, ret;
+
+	dwdto_0 = DLB2_CSR_RD(hw, DLB2_CHP_CFG_DIR_WDTO_0(hw->ver));
+	dwdto_1 = DLB2_CSR_RD(hw, DLB2_CHP_CFG_DIR_WDTO_1(hw->ver));
+	lwdto_0 = DLB2_CSR_RD(hw, DLB2_CHP_CFG_LDB_WDTO_0(hw->ver));
+	lwdto_1 = DLB2_CSR_RD(hw, DLB2_CHP_CFG_LDB_WDTO_1(hw->ver));
+
+	if (dwdto_0 == 0xFFFFFFFF &&
+	    dwdto_1 == 0xFFFFFFFF &&
+	    lwdto_0 == 0xFFFFFFFF &&
+	    lwdto_1 == 0xFFFFFFFF)
+		return;
+
+	/* Alert applications for affected directed ports */
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS(hw->ver); i++) {
+		struct dlb2_dir_pq_pair *port;
+		int idx = i % 32;
+
+		if (i < 32 && !(dwdto_0 & (1 << idx)))
+			continue;
+		if (i >= 32 && !(dwdto_1 & (1 << idx)))
+			continue;
+
+		port = dlb2_get_dir_pq_from_id(hw, i, false, 0);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()]: Internal error: unable to find DIR port %u\n",
+				    __func__, i);
+			return;
+		}
+
+		ret = os_notify_user_space(hw,
+						   port->domain_id.phys_id,
+						   alert_id,
+						   i);
+		if (ret)
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: failed to notify\n",
+				    __func__);
+	}
+
+	/* Alert applications for affected load-balanced ports */
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		struct dlb2_ldb_port *port;
+		int idx = i % 32;
+
+		if (i < 32 && !(lwdto_0 & (1 << idx)))
+			continue;
+		if (i >= 32 && !(lwdto_1 & (1 << idx)))
+			continue;
+
+		port = dlb2_get_ldb_port_from_id(hw, i, false, 0);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()]: Internal error: unable to find LDB port %u\n",
+				    __func__, i);
+			return;
+		}
+
+		/* aux_alert_data[8] is 1 to indicate a load-balanced port */
+		ret = os_notify_user_space(hw,
+						   port->domain_id.phys_id,
+						   alert_id,
+						   (1 << 8) | i);
+		if (ret)
+			DLB2_HW_ERR(hw,
+				    "[%s()] Internal error: failed to notify\n",
+				    __func__);
+	}
+
+	/* Clear watchdog timeout flag(s) (W1CLR) */
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_DIR_WDTO_0(hw->ver), dwdto_0);
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_DIR_WDTO_1(hw->ver), dwdto_1);
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_LDB_WDTO_0(hw->ver), lwdto_0);
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_LDB_WDTO_1(hw->ver), lwdto_1);
+
+	dlb2_flush_csr(hw);
+
+	/* Re-enable watchdog timeout(s) (W1CLR) */
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_DIR_WD_DISABLE0(hw->ver), dwdto_0);
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_DIR_WD_DISABLE1(hw->ver), dwdto_1);
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_LDB_WD_DISABLE0(hw->ver), lwdto_0);
+	DLB2_CSR_WR(hw, DLB2_CHP_CFG_LDB_WD_DISABLE1(hw->ver), lwdto_1);
+}
+
+static void dlb2_process_ingress_error(struct dlb2_hw *hw,
+				       u32 synd0,
+				       u32 alert_id,
+				       bool vf_error,
+				       unsigned int vf_id)
+{
+	struct dlb2_hw_domain *domain;
+	bool is_ldb;
+	u8 port_id;
+	int ret;
+
+	port_id = DLB2_SYND0(SYNDROME) & 0x7F;
+	if (DLB2_SYND0(SOURCE) == DLB2_ALARM_HW_SOURCE_SYS)
+		is_ldb = DLB2_SYND0(IS_LDB);
+	else
+		is_ldb = (DLB2_SYND0(SYNDROME) & 0x80) != 0;
+
+	/* Get the domain ID and, if it's a VF domain, the virtual port ID */
+	if (is_ldb) {
+		struct dlb2_ldb_port *port;
+
+		port = dlb2_get_ldb_port_from_id(hw, port_id, vf_error, vf_id);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()]: Internal error: unable to find LDB port\n\tport: %u, vf_error: %u, vf_id: %u\n",
+				    __func__, port_id, vf_error, vf_id);
+			return;
+		}
+
+		domain = &hw->domains[port->domain_id.phys_id];
+	} else {
+		struct dlb2_dir_pq_pair *port;
+
+		port = dlb2_get_dir_pq_from_id(hw, port_id, vf_error, vf_id);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()]: Internal error: unable to find DIR port\n\tport: %u, vf_error: %u, vf_id: %u\n",
+				    __func__, port_id, vf_error, vf_id);
+			return;
+		}
+
+		domain = &hw->domains[port->domain_id.phys_id];
+	}
+
+	ret = os_notify_user_space(hw,
+					   domain->id.phys_id,
+					   alert_id,
+					   (is_ldb << 8) | port_id);
+	if (ret)
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: failed to notify\n",
+			    __func__);
+}
+
+static u32 dlb2_alert_id(u32 synd0)
+{
+	if (DLB2_SYND0(UNIT) == DLB2_ALARM_HW_UNIT_CHP &&
+	    DLB2_SYND0(AID) == DLB2_ALARM_HW_CHP_AID_ILLEGAL_ENQ)
+		return DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ;
+	else if (DLB2_SYND0(UNIT) == DLB2_ALARM_HW_UNIT_CHP &&
+		 DLB2_SYND0(AID) == DLB2_ALARM_HW_CHP_AID_EXCESS_TOKEN_POPS)
+		return DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS;
+	else if (DLB2_SYND0(SOURCE) == DLB2_ALARM_HW_SOURCE_SYS &&
+		 DLB2_SYND0(AID) == DLB2_ALARM_SYS_AID_ILLEGAL_HCW)
+		return DLB2_DOMAIN_ALERT_ILLEGAL_HCW;
+	else if (DLB2_SYND0(SOURCE) == DLB2_ALARM_HW_SOURCE_SYS &&
+		 DLB2_SYND0(AID) == DLB2_ALARM_SYS_AID_ILLEGAL_QID)
+		return DLB2_DOMAIN_ALERT_ILLEGAL_QID;
+	else if (DLB2_SYND0(SOURCE) == DLB2_ALARM_HW_SOURCE_SYS &&
+		 DLB2_SYND0(AID) == DLB2_ALARM_SYS_AID_DISABLED_QID)
+		return DLB2_DOMAIN_ALERT_DISABLED_QID;
+	else
+		return NUM_DLB2_DOMAIN_ALERTS;
+}
+
+/**
+ * dlb2_process_ingress_error_interrupt() - process ingress error interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function reads the alarm syndrome, logs it, notifies user-space, and
+ * acks the interrupt. This function should be called from the alarm interrupt
+ * handler when interrupt vector DLB2_INT_INGRESS_ERROR fires.
+ *
+ * Return:
+ * Returns true if an ingress error interrupt occurred, false otherwise
+ */
+bool dlb2_process_ingress_error_interrupt(struct dlb2_hw *hw)
+{
+	u32 synd0, synd1, synd2;
+	u32 alert_id;
+	bool valid;
+	int i;
+
+	synd0 = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_PF_SYND0);
+
+	valid = DLB2_SYND0(VALID);
+
+	if (valid) {
+		synd1 = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_PF_SYND1);
+		synd2 = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_PF_SYND2);
+
+		alert_id = dlb2_alert_id(synd0);
+
+		dlb2_log_pf_vf_syndrome(hw,
+					"PF Ingress error alarm",
+					synd0, synd1, synd2, alert_id);
+
+		dlb2_clear_syndrome_register(hw, DLB2_SYS_ALARM_PF_SYND0);
+
+		dlb2_process_ingress_error(hw, synd0, alert_id, false, 0);
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_VDEVS; i++) {
+		synd0 = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_VF_SYND0(i));
+
+		valid |= DLB2_SYND0(VALID);
+
+		if (!DLB2_SYND0(VALID))
+			continue;
+
+		synd1 = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_VF_SYND1(i));
+		synd2 = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_VF_SYND2(i));
+
+		alert_id = dlb2_alert_id(synd0);
+
+		dlb2_log_pf_vf_syndrome(hw,
+					"VF Ingress error alarm",
+					synd0, synd1, synd2, alert_id);
+
+		dlb2_clear_syndrome_register(hw, DLB2_SYS_ALARM_VF_SYND0(i));
+
+		dlb2_process_ingress_error(hw, synd0, alert_id, true, i);
+	}
+
+	return valid;
+}
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.h b/drivers/event/dlb2/pf/base/dlb2_resource.h
index ee3402deff..00a7d283f2 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.h
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.h
@@ -1974,4 +1974,10 @@ int dlb2_hw_set_cq_inflight_ctrl(struct dlb2_hw *hw, u32 domain_id,
 			struct dlb2_cmd_response *resp,
 			bool vdev_request, unsigned int vdev_id);
 
+int dlb2_block_on_cq_interrupt(struct dlb2_hw *dlb2,
+			int port_id,
+			bool is_ldb,
+			volatile void *cq_va,
+			u8 cq_gen,
+			bool arm);
 #endif /* __DLB2_RESOURCE_H */
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index edcdfb319f..881785350b 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -317,6 +317,206 @@ dlb2_alloc_coherent_aligned(const struct rte_memzone **mz, uintptr_t *phys,
 	return (*mz)->addr;
 }
 
+static int
+dlb2_pf_enable_ldb_cq_interrupts(struct dlb2_hw *hw,
+				 int id,
+				 u16 thresh)
+{
+	int mode = DLB2_CQ_ISR_MODE_MSIX, vec = 0, efd;
+
+	efd = eventfd(0, 0);
+	if (efd < 0) {
+		DLB2_LOG_ERR("[%s()] failed to create eventfd for port %d", __func__, id);
+		return -1;
+	}
+
+	hw->intr.ldb_cq_intr[id].disabled = false;
+	hw->intr.ldb_cq_intr[id].configured = true;
+	hw->intr.ldb_cq_intr[id].efd = efd;
+
+	return  dlb2_configure_ldb_cq_interrupt(hw, id, vec, mode, 0, 0, thresh);
+}
+
+static int
+dlb2_pf_enable_dir_cq_interrupts(struct dlb2_hw *hw,
+				 int id,
+				 u16 thresh)
+{
+	int mode = DLB2_CQ_ISR_MODE_MSIX, vec = 0, efd;
+
+	efd = eventfd(0, 0);
+	if (efd < 0) {
+		DLB2_LOG_ERR("[%s()] failed to create eventfd for port %d", __func__, id);
+		return -1;
+	}
+
+	hw->intr.dir_cq_intr[id].disabled = false;
+	hw->intr.dir_cq_intr[id].configured = true;
+	hw->intr.dir_cq_intr[id].efd = efd;
+
+	return  dlb2_configure_dir_cq_interrupt(hw, id, vec, mode, 0, 0, thresh);
+}
+
+static void
+dlb2_wake_thread(struct dlb2_cq_intr *intr, enum dlb2_wake_reason reason)
+{
+	intr->reason = reason;
+	eventfd_write(intr->efd, 1);
+}
+
+static void
+dlb2_cq_interrupt_handler(void *intr_param)
+{
+	u32 dir_cq_interrupts[DLB2_MAX_NUM_DIR_PORTS_V2_5 / 32];
+	u32 ldb_cq_interrupts[DLB2_MAX_NUM_LDB_PORTS / 32];
+	struct dlb2_dev *dlb2_dev = intr_param;
+	struct dlb2_hw *hw = &dlb2_dev->hw;
+
+	dlb2_read_compressed_cq_intr_status(hw, ldb_cq_interrupts, dir_cq_interrupts);
+	dlb2_ack_compressed_cq_intr(hw, ldb_cq_interrupts, dir_cq_interrupts);
+
+	for (int i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		u32 mask = 1 << (i % 32);
+		int idx = i / 32;
+
+		if (!(ldb_cq_interrupts[idx] & mask))
+			continue;
+
+		dlb2_wake_thread(&hw->intr.ldb_cq_intr[i], WAKE_CQ_INTR);
+	}
+
+	for (int i = 0; i < DLB2_MAX_NUM_DIR_PORTS(hw->ver); i++) {
+		u32 mask = 1 << (i % 32);
+		int idx = i / 32;
+
+		if (!(dir_cq_interrupts[idx] & mask))
+			continue;
+
+		dlb2_wake_thread(&hw->intr.dir_cq_intr[i], WAKE_CQ_INTR);
+	}
+}
+
+static void
+dlb2_detect_ingress_err_overload(struct dlb2_hw *dlb2)
+{
+	struct timespec ts;
+	u64 delta_us;
+
+	if (dlb2->ingress_err.count == 0)
+		clock_gettime(CLOCK_REALTIME, &dlb2->ingress_err.ts);
+
+	dlb2->ingress_err.count++;
+
+	/* Don't check for overload until OVERLOAD_THRESH ISRs have run */
+	if (dlb2->ingress_err.count < DLB2_ISR_OVERLOAD_THRESH)
+		return;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	delta_us = (ts.tv_sec - dlb2->ingress_err.ts.tv_sec) * 1000000LL +
+		   (ts.tv_nsec - dlb2->ingress_err.ts.tv_nsec) / 1000;
+
+	/* Reset stats for next measurement period */
+	dlb2->ingress_err.count = 0;
+	clock_gettime(CLOCK_REALTIME, &dlb2->ingress_err.ts);
+
+	/* Check for overload during this measurement period */
+	if (delta_us > DLB2_ISR_OVERLOAD_PERIOD_S * 1000000)
+		return;
+
+	/*
+	 * Alarm interrupt overload: disable software-generated alarms,
+	 * so only hardware problems (e.g. ECC errors) interrupt the PF.
+	 */
+	dlb2_disable_ingress_error_alarms(dlb2);
+
+	dlb2->ingress_err.enabled = false;
+
+	DLB2_HW_DBG(dlb2, "[%s()] Overloaded detected: disabling ingress error interrupts",
+		    __func__);
+}
+
+static void
+dlb2_service_intr_handler(void *intr_param)
+{
+	struct dlb2_dev *dlb2_dev = intr_param;
+	u32 synd;
+
+	rte_spinlock_lock(&dlb2_dev->resource_mutex);
+
+	synd = DLB2_CSR_RD(&dlb2_dev->hw, DLB2_SYS_ALARM_HW_SYND);
+
+	/*
+	 * Clear the MSI-X ack bit before processing the watchdog timer
+	 * interrupts. This order is necessary so that if an interrupt event
+	 * arrives after reading the corresponding bit vector, the event won't
+	 * be lost.
+	 */
+	dlb2_ack_msix_interrupt(&dlb2_dev->hw, DLB2_INT_NON_CQ);
+
+	if (DLB2_SYND(ALARM) & DLB2_SYND(VALID))
+		dlb2_process_alarm_interrupt(&dlb2_dev->hw);
+
+	if (dlb2_process_ingress_error_interrupt(&dlb2_dev->hw))
+		dlb2_detect_ingress_err_overload(&dlb2_dev->hw);
+
+	if (DLB2_SYND(CWD) & DLB2_SYND(VALID))
+		dlb2_process_wdt_interrupt(&dlb2_dev->hw);
+
+	rte_spinlock_unlock(&dlb2_dev->resource_mutex);
+}
+
+static int
+dlb2_intr_setup(struct rte_eventdev *eventdev)
+{
+	struct rte_intr_handle *dlb2_intr = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(eventdev->dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	struct dlb2_eventdev *dlb2 = dlb2_pmd_priv(eventdev);
+	struct dlb2_dev *dlb2_dev = dlb2->qm_instance.pf_dev;
+	struct dlb2_hw *hw = &dlb2_dev->hw;
+	uint32_t intr_vector = 1;
+
+	/* Setup eventfd for VFIO-MSIX interrupts */
+	if (rte_intr_cap_multiple(intr_handle) && rte_intr_efd_enable(intr_handle, intr_vector))
+		return -1;
+
+	rte_intr_enable(intr_handle);
+
+	/* Set the dlb2 interrupt type and fd to eventfd of the VFIO-MSIX and register
+	 * the interrupt handler
+	 */
+	rte_intr_type_set(dlb2_intr, RTE_INTR_HANDLE_VFIO_MSIX);
+	rte_intr_fd_set(dlb2_intr, rte_intr_efds_index_get(intr_handle, 0));
+	rte_intr_callback_register(dlb2_intr, dlb2_cq_interrupt_handler, dlb2_dev);
+
+	/* Enable alarms and register interrupt handler*/
+	hw->ingress_err.count = 0;
+	hw->ingress_err.enabled = true;
+	dlb2_enable_ingress_error_alarms(hw);
+	rte_intr_callback_register(intr_handle, dlb2_service_intr_handler, dlb2_dev);
+
+	/* Initilaize the interrupt structures */
+	for (int i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		if (pthread_mutex_init(&hw->intr.ldb_cq_intr[i].mutex, NULL) != 0) {
+			perror("Mutex initialization failed");
+			return EXIT_FAILURE;
+		}
+		hw->intr.ldb_cq_intr[i].configured = false;
+		hw->intr.ldb_cq_intr[i].disabled = true;
+	}
+
+	for (int i = 0; i < DLB2_MAX_NUM_DIR_PORTS(hw->ver); i++) {
+		if (pthread_mutex_init(&hw->intr.dir_cq_intr[i].mutex, NULL) != 0) {
+			perror("Mutex initialization failed");
+			return EXIT_FAILURE;
+		}
+		hw->intr.dir_cq_intr[i].configured = false;
+		hw->intr.dir_cq_intr[i].disabled = true;
+	}
+
+	return 0;
+}
+
 static int
 dlb2_pf_ldb_port_create(struct dlb2_hw_dev *handle,
 			struct dlb2_create_ldb_port_args *cfg,
@@ -371,6 +571,10 @@ dlb2_pf_ldb_port_create(struct dlb2_hw_dev *handle,
 	if (ret)
 		goto create_port_err;
 
+	ret = dlb2_pf_enable_ldb_cq_interrupts(&dlb2_dev->hw, response.id, cfg->cq_depth_threshold);
+	if (ret)
+		goto create_port_err;
+
 	pp_base = (uintptr_t)dlb2_dev->hw.func_kva + PP_BASE(is_dir);
 	dlb2_port[response.id][DLB2_LDB_PORT].pp_addr =
 		(void *)(pp_base + (rte_mem_page_size() * response.id));
@@ -453,6 +657,10 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 
 	cfg->response = response;
 
+	if (ret)
+		goto create_port_err;
+
+	ret = dlb2_pf_enable_dir_cq_interrupts(&dlb2_dev->hw, response.id, cfg->cq_depth_threshold);
 	if (ret)
 		goto create_port_err;
 
@@ -722,6 +930,19 @@ dlb2_pf_set_cos_bandwidth(struct dlb2_hw_dev *handle,
 	return ret;
 }
 
+static int
+dlb2_pf_block_on_cq_interrupt(struct dlb2_hw_dev *handle,
+			      int port_id,
+			      bool is_ldb,
+			      volatile void *cq_va,
+			      u8 cq_gen,
+			      bool arm)
+{
+	struct dlb2_dev *dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+
+	return dlb2_block_on_cq_interrupt(&dlb2_dev->hw, port_id, is_ldb, cq_va, cq_gen, arm);
+}
+
 static void
 dlb2_pf_iface_fn_ptrs_init(void)
 {
@@ -749,6 +970,7 @@ dlb2_pf_iface_fn_ptrs_init(void)
 	dlb2_iface_enable_cq_weight = dlb2_pf_enable_cq_weight;
 	dlb2_iface_set_cos_bw = dlb2_pf_set_cos_bandwidth;
 	dlb2_iface_set_cq_inflight_ctrl = dlb2_pf_set_cq_inflight_ctrl;
+	dlb2_iface_block_on_cq_interrupt = dlb2_pf_block_on_cq_interrupt;
 }
 
 /* PCI DEV HOOKS */
@@ -819,6 +1041,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 		ret = dlb2_primary_eventdev_probe(eventdev,
 						  event_dlb2_pf_name,
 						  &dlb2_args);
+		ret = ret ?: dlb2_intr_setup(eventdev);
 	} else {
 		dlb2 = dlb2_pmd_priv(eventdev);
 		dlb2->version = DLB2_HW_DEVICE_FROM_PCI_ID(pci_dev);
-- 
2.39.1

