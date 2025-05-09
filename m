Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D616C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 04:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A12824064C;
	Fri,  9 May 2025 06:24:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9A9D0402F0
 for <dev@dpdk.org>; Fri,  9 May 2025 06:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746764653; x=1778300653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ONSg17yvzWiB0O+lDwmDv3UDELsXaYHeahIPH+ok8tQ=;
 b=HvFd3txs3hf43kkilVUhdOHb8ITCloj++KkkkkiyRFJ7bMMRub2Clk3D
 pBka6ebTxIRYUxk1wzBZDY/VkdmdtqY8Yv2ENmdh3hFaT2B1sFZx58Zvm
 7XzCATva9CPPUK7QI4MhYoN5rrFmOFZDaqUvXuZmxrscqus/337P/o1Mv
 2UEcUyr7qzOmkNnAZXCKfbrK2PvT1CPL1XmmcCOJxoT2edUEfPESfy4AN
 uTTIA17JiMLQGhKi3F9czYZtcQZye8fMjOpL1v5qn7RFfRDV0dupNg93P
 0O1+J1oe4rGyWAW2EpXhqzrASF+eFFHU4J3bZ5ZJHbYLWPYWAlY80U2EV A==;
X-CSE-ConnectionGUID: VdYscnxFTkGmZDD6/RwWew==
X-CSE-MsgGUID: HdYO5Ps5S5Giid8LfKp44Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48692436"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48692436"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 21:24:11 -0700
X-CSE-ConnectionGUID: Ngbr4XCOSfG6vvK68+Sqtg==
X-CSE-MsgGUID: 9fUyMjxUQpuZRuympddO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136388846"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa010.jf.intel.com with ESMTP; 08 May 2025 21:24:11 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1 4/7] event/dlb2: support managing history list resource
Date: Thu,  8 May 2025 23:23:58 -0500
Message-Id: <20250509042401.2634765-5-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509042401.2634765-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
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

Add support for setting application specified port history
Set HL equal to CQ depth when inflight control is enabled
Added command line parameters 'use_default_hl' (default: 1)
   and 'alloc_hl_entries'
 - When 'use_default_hl = 1'
   * Per port HL is set to DLB2_FIXED_CQ_HL_SIZE (32)
   * Recommended CQ depth by dlb2_eventdev_port_default_conf_get()
     is DLB2_FIXED_CQ_HL_SIZE/2
   * command line parameter alloc_hl_entries is ignored
 - When 'use_default_hl = 0'
   * Per LDB port HL = 2 * CQ depth
   * Recommended CQ depth by dlb2_eventdev_port_default_conf_get()
     is DLB2_FIXED_CQ_HL_SIZE
   * User should calculate needed HL entries based on CQ depths the
     application will use and specify it as command line parameter
     'alloc_hl_entries'.  This will be used to allocate HL entries.
      alloc_hl_entries = (Sum of all LDB ports CQ depths * 2)
   * If alloc_hl_entries is not specified, then
     Total HL entries for the eventdev  = num_ldb_ports * 64

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/event/dlb2/dlb2.c                  | 220 +++++++++++++++++----
 drivers/event/dlb2/dlb2_iface.c            |   5 +-
 drivers/event/dlb2/dlb2_iface.h            |   4 +-
 drivers/event/dlb2/dlb2_priv.h             |  19 +-
 drivers/event/dlb2/dlb2_user.h             |  24 +++
 drivers/event/dlb2/pf/base/dlb2_regs.h     |   9 +
 drivers/event/dlb2/pf/base/dlb2_resource.c |  74 +++++++
 drivers/event/dlb2/pf/base/dlb2_resource.h |  18 ++
 drivers/event/dlb2/pf/dlb2_pf.c            |  29 ++-
 drivers/event/dlb2/rte_pmd_dlb2.c          |  23 +++
 drivers/event/dlb2/rte_pmd_dlb2.h          |  40 ++++
 drivers/event/dlb2/version.map             |   1 +
 12 files changed, 422 insertions(+), 44 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 24c56a7968..cd843bb9d0 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -727,6 +727,50 @@ set_enable_cq_weight(const char *key __rte_unused,
 	return 0;
 }
 
+static int set_hl_override(const char *key __rte_unused, const char *value,
+			   void *opaque)
+{
+	bool *default_hl = opaque;
+
+	if (value == NULL || opaque == NULL) {
+		DLB2_LOG_ERR("NULL pointer");
+		return -EINVAL;
+	}
+
+	if ((*value == 'n') || (*value == 'N') || (*value == '0'))
+		*default_hl = false;
+	else
+		*default_hl = true;
+
+	return 0;
+}
+
+static int set_hl_entries(const char *key __rte_unused, const char *value,
+			  void *opaque)
+{
+	int hl_entries = 0;
+	int ret;
+
+	if (value == NULL || opaque == NULL) {
+		DLB2_LOG_ERR("NULL pointer");
+		return -EINVAL;
+	}
+
+	ret = dlb2_string_to_int(&hl_entries, value);
+	if (ret < 0)
+		return ret;
+
+	if (!hl_entries || (uint32_t)hl_entries > DLB2_MAX_HL_ENTRIES) {
+		DLB2_LOG_ERR(
+		    "alloc_hl_entries %u out of range, must be in [1 - %d]",
+		    hl_entries, DLB2_MAX_HL_ENTRIES);
+		return -EINVAL;
+	}
+	*(uint32_t *)opaque = hl_entries;
+
+	return 0;
+}
+
 static int
 set_qid_depth_thresh(const char *key __rte_unused,
 		     const char *value,
@@ -932,8 +976,16 @@ dlb2_hw_create_sched_domain(struct dlb2_eventdev *dlb2,
 		DLB2_NUM_ATOMIC_INFLIGHTS_PER_QUEUE *
 		cfg->num_ldb_queues;
 
-	cfg->num_hist_list_entries = resources_asked->num_ldb_ports *
-		evdev_dlb2_default_info.max_event_port_dequeue_depth;
+	/* If hl_entries is non-zero then user specified command line option.
+	 * Else compute using default_port_hl that has been set earlier based
+	 * on use_default_hl option
+	 */
+	if (dlb2->hl_entries) {
+		cfg->num_hist_list_entries = dlb2->hl_entries;
+	} else {
+		cfg->num_hist_list_entries =
+			resources_asked->num_ldb_ports * dlb2->default_port_hl;
+	}
 
 	if (device_version == DLB2_HW_V2_5) {
 		DLB2_LOG_LINE_DBG("sched domain create - ldb_qs=%d, ldb_ports=%d, dir_ports=%d, atomic_inflights=%d, hist_list_entries=%d, credits=%d",
@@ -1154,8 +1206,8 @@ dlb2_eventdev_port_default_conf_get(struct rte_eventdev *dev,
 	struct dlb2_eventdev *dlb2 = dlb2_pmd_priv(dev);
 
 	port_conf->new_event_threshold = dlb2->new_event_limit;
-	port_conf->dequeue_depth = 32;
-	port_conf->enqueue_depth = DLB2_MAX_ENQUEUE_DEPTH;
+	port_conf->dequeue_depth = dlb2->default_port_hl / 2;
+	port_conf->enqueue_depth = evdev_dlb2_default_info.max_event_port_enqueue_depth;
 	port_conf->event_port_cfg = 0;
 }
 
@@ -1647,16 +1699,14 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 {
 	struct dlb2_hw_dev *handle = &dlb2->qm_instance;
 	struct dlb2_create_ldb_port_args cfg = { {0} };
-	int ret;
-	struct dlb2_port *qm_port = NULL;
+	struct dlb2_port *qm_port = &ev_port->qm_port;
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	uint32_t qm_port_id;
-	uint16_t ldb_credit_high_watermark = 0;
-	uint16_t dir_credit_high_watermark = 0;
-	uint16_t credit_high_watermark = 0;
+	int ret;
 
 	if (handle == NULL)
 		return -EINVAL;
+	(void) enqueue_depth;
 
 	if (dequeue_depth < DLB2_MIN_CQ_DEPTH) {
 		DLB2_LOG_ERR("dlb2: invalid cq depth, must be at least %d",
@@ -1670,27 +1720,23 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 	cfg.cq_depth = rte_align32pow2(dequeue_depth);
 	cfg.cq_depth_threshold = 1;
 
-	cfg.cq_history_list_size = cfg.cq_depth;
+	if (dlb2->version == DLB2_HW_V2_5 && qm_port->enable_inflight_ctrl) {
+		cfg.enable_inflight_ctrl = 1;
+		cfg.inflight_threshold = qm_port->inflight_threshold;
+	}
+
+	if (qm_port->hist_list)
+		cfg.cq_history_list_size = qm_port->hist_list;
+	else if (cfg.enable_inflight_ctrl)
+		cfg.cq_history_list_size = RTE_MIN(cfg.cq_depth, dlb2->default_port_hl);
+	else if (dlb2->default_port_hl == DLB2_FIXED_CQ_HL_SIZE)
+		cfg.cq_history_list_size = DLB2_FIXED_CQ_HL_SIZE;
+	else
+		cfg.cq_history_list_size = cfg.cq_depth * 2;
 
 	cfg.cos_id = ev_port->cos_id;
 	cfg.cos_strict = 0;/* best effots */
 
-	/* User controls the LDB high watermark via enqueue depth. The DIR high
-	 * watermark is equal, unless the directed credit pool is too small.
-	 */
-	if (dlb2->version == DLB2_HW_V2) {
-		ldb_credit_high_watermark = enqueue_depth;
-		/* If there are no directed ports, the kernel driver will
-		 * ignore this port's directed credit settings. Don't use
-		 * enqueue_depth if it would require more directed credits
-		 * than are available.
-		 */
-		dir_credit_high_watermark =
-			RTE_MIN(enqueue_depth,
-				handle->cfg.num_dir_credits / dlb2->num_ports);
-	} else
-		credit_high_watermark = enqueue_depth;
-
 	/* Per QM values */
 
 	ret = dlb2_iface_ldb_port_create(handle, &cfg,  dlb2->poll_mode);
@@ -1793,24 +1839,18 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 	qm_port->config_state = DLB2_CONFIGURED;
 
 	if (dlb2->version == DLB2_HW_V2) {
-		qm_port->dir_credits = dir_credit_high_watermark;
-		qm_port->ldb_credits = ldb_credit_high_watermark;
 		qm_port->credit_pool[DLB2_DIR_QUEUE] = &dlb2->dir_credit_pool;
 		qm_port->credit_pool[DLB2_LDB_QUEUE] = &dlb2->ldb_credit_pool;
 
-		DLB2_LOG_LINE_DBG("dlb2: created ldb port %d, depth = %d, ldb credits=%d, dir credits=%d",
+		DLB2_LOG_LINE_DBG("dlb2: created ldb port %d, depth = %d",
 			     qm_port_id,
-			     dequeue_depth,
-			     qm_port->ldb_credits,
-			     qm_port->dir_credits);
+			     dequeue_depth);
 	} else {
-		qm_port->credits = credit_high_watermark;
 		qm_port->credit_pool[DLB2_COMBINED_POOL] = &dlb2->credit_pool;
 
-		DLB2_LOG_LINE_DBG("dlb2: created ldb port %d, depth = %d, credits=%d",
+		DLB2_LOG_LINE_DBG("dlb2: created ldb port %d, depth = %d",
 			     qm_port_id,
-			     dequeue_depth,
-			     qm_port->credits);
+			     dequeue_depth);
 	}
 
 	qm_port->use_scalar = false;
@@ -1830,8 +1870,7 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 
 error_exit:
 
-	if (qm_port)
-		dlb2_free_qe_mem(qm_port);
+	dlb2_free_qe_mem(qm_port);
 
 	rte_spinlock_unlock(&handle->resource_lock);
 
@@ -4648,6 +4687,67 @@ dlb2_get_queue_depth(struct dlb2_eventdev *dlb2,
 		return dlb2_get_ldb_queue_depth(dlb2, queue);
 }
 
+#define PARAM_ERR(param, ret, err_str)\
+	do { \
+		if (!ret) \
+			ret = -EINVAL; \
+		DLB2_LOG_ERR("dlb2: dlb2_set_port_param error, param=%lx ret=%d %s",\
+			param, ret, err_str); \
+	} while (0)
+
+int
+dlb2_set_port_param(struct dlb2_eventdev *dlb2,
+		    int port_id,
+		    uint64_t param_flags,
+		    void *param_val)
+{
+	struct dlb2_port_param *port_param = (struct dlb2_port_param *)param_val;
+	struct dlb2_port *port = &dlb2->ev_ports[port_id].qm_port;
+	struct dlb2_hw_dev *handle = &dlb2->qm_instance;
+	int ret = 0, bit = 0;
+
+	while (param_flags) {
+		uint64_t param = rte_bit_relaxed_test_and_clear64(bit++, &param_flags);
+
+		if (!param)
+			continue;
+		switch (param) {
+		case DLB2_FLOW_MIGRATION_THRESHOLD:
+			if (dlb2->version == DLB2_HW_V2_5) {
+				struct dlb2_cq_inflight_ctrl_args args = {0};
+
+				args.enable = true;
+				args.port_id = port->id;
+				args.threshold = port_param->inflight_threshold;
+				if (dlb2->ev_ports[port_id].setup_done)
+					ret = dlb2_iface_set_cq_inflight_ctrl(handle, &args);
+				if (ret) {
+					PARAM_ERR(param, ret, "Failed to set inflight threshold");
+					return ret;
+				}
+				port->enable_inflight_ctrl = true;
+				port->inflight_threshold = args.threshold;
+			} else {
+				PARAM_ERR(param, ret, "FLOW_MIGRATION_THRESHOLD is only supported for 2.5 HW");
+				return ret;
+			}
+			break;
+		case DLB2_SET_PORT_HL:
+			if (dlb2->ev_ports[port_id].setup_done) {
+				PARAM_ERR(param, ret, "DLB2_SET_PORT_HL must be called before setting up port");
+				return ret;
+			}
+			port->hist_list = port_param->port_hl;
+			break;
+		default:
+			PARAM_ERR(param, ret, "Unsupported flag");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static bool
 dlb2_queue_is_empty(struct dlb2_eventdev *dlb2,
 		    struct dlb2_eventdev_queue *queue)
@@ -4953,6 +5053,28 @@ dlb2_primary_eventdev_probe(struct rte_eventdev *dev,
 		return err;
 	}
 
+	if (dlb2_args->use_default_hl) {
+		dlb2->default_port_hl = DLB2_FIXED_CQ_HL_SIZE;
+		if (dlb2_args->alloc_hl_entries)
+			DLB2_LOG_ERR(": Ignoring 'alloc_hl_entries' and using "
+				     "default history list sizes for eventdev:"
+				     " %s", dev->data->name);
+		dlb2->hl_entries = 0;
+	} else {
+		dlb2->default_port_hl = 2 * DLB2_FIXED_CQ_HL_SIZE;
+
+		if (dlb2_args->alloc_hl_entries >
+		    dlb2->hw_rsrc_query_results.num_hist_list_entries) {
+			DLB2_LOG_ERR(": Insufficient HL entries asked=%d "
+				     "available=%d for eventdev: %s",
+				     dlb2->hl_entries,
+				     dlb2->hw_rsrc_query_results.num_hist_list_entries,
+				     dev->data->name);
+			return -EINVAL;
+		}
+		dlb2->hl_entries = dlb2_args->alloc_hl_entries;
+	}
+
 	dlb2_iface_hardware_init(&dlb2->qm_instance);
 
 	/* configure class of service */
@@ -5060,6 +5182,8 @@ dlb2_parse_params(const char *params,
 					     DLB2_PRODUCER_COREMASK,
 					     DLB2_DEFAULT_LDB_PORT_ALLOCATION_ARG,
 					     DLB2_ENABLE_CQ_WEIGHT_ARG,
+					     DLB2_USE_DEFAULT_HL,
+					     DLB2_ALLOC_HL_ENTRIES,
 					     NULL };
 
 	if (params != NULL && params[0] != '\0') {
@@ -5274,6 +5398,26 @@ dlb2_parse_params(const char *params,
 			if (version == DLB2_HW_V2 && dlb2_args->enable_cq_weight)
 				DLB2_LOG_INFO("Ignoring 'enable_cq_weight=y'. Only supported for 2.5 HW onwards");
 
+			ret = rte_kvargs_process(kvlist, DLB2_USE_DEFAULT_HL,
+						 set_hl_override,
+						 &dlb2_args->use_default_hl);
+			if (ret != 0) {
+				DLB2_LOG_ERR("%s: Error parsing hl_override arg",
+					     name);
+				rte_kvargs_free(kvlist);
+				return ret;
+			}
+
+			ret = rte_kvargs_process(kvlist, DLB2_ALLOC_HL_ENTRIES,
+						 set_hl_entries,
+						 &dlb2_args->alloc_hl_entries);
+			if (ret != 0) {
+				DLB2_LOG_ERR("%s: Error parsing hl_override arg",
+					     name);
+				rte_kvargs_free(kvlist);
+				return ret;
+			}
+
 			rte_kvargs_free(kvlist);
 		}
 	}
diff --git a/drivers/event/dlb2/dlb2_iface.c b/drivers/event/dlb2/dlb2_iface.c
index 100db434d0..8521576ff8 100644
--- a/drivers/event/dlb2/dlb2_iface.c
+++ b/drivers/event/dlb2/dlb2_iface.c
@@ -73,9 +73,12 @@ int (*dlb2_iface_get_ldb_queue_depth)(struct dlb2_hw_dev *handle,
 int (*dlb2_iface_get_dir_queue_depth)(struct dlb2_hw_dev *handle,
 				struct dlb2_get_dir_queue_depth_args *args);
 
-
 int (*dlb2_iface_enable_cq_weight)(struct dlb2_hw_dev *handle,
 				   struct dlb2_enable_cq_weight_args *args);
 
+int (*dlb2_iface_set_cq_inflight_ctrl)(struct dlb2_hw_dev *handle,
+					struct dlb2_cq_inflight_ctrl_args *args);
+
 int (*dlb2_iface_set_cos_bw)(struct dlb2_hw_dev *handle,
 			     struct dlb2_set_cos_bw_args *args);
+
diff --git a/drivers/event/dlb2/dlb2_iface.h b/drivers/event/dlb2/dlb2_iface.h
index dc0c446ce8..cced364792 100644
--- a/drivers/event/dlb2/dlb2_iface.h
+++ b/drivers/event/dlb2/dlb2_iface.h
@@ -72,10 +72,12 @@ extern int (*dlb2_iface_get_ldb_queue_depth)(struct dlb2_hw_dev *handle,
 extern int (*dlb2_iface_get_dir_queue_depth)(struct dlb2_hw_dev *handle,
 				struct dlb2_get_dir_queue_depth_args *args);
 
-
 extern int (*dlb2_iface_enable_cq_weight)(struct dlb2_hw_dev *handle,
 					  struct dlb2_enable_cq_weight_args *args);
 
+extern int (*dlb2_iface_set_cq_inflight_ctrl)(struct dlb2_hw_dev *handle,
+				struct dlb2_cq_inflight_ctrl_args *args);
+
 extern int (*dlb2_iface_set_cos_bw)(struct dlb2_hw_dev *handle,
 				    struct dlb2_set_cos_bw_args *args);
 
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 285d427397..9ee3dff530 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -53,6 +53,8 @@
 #define DLB2_PRODUCER_COREMASK "producer_coremask"
 #define DLB2_DEFAULT_LDB_PORT_ALLOCATION_ARG "default_port_allocation"
 #define DLB2_ENABLE_CQ_WEIGHT_ARG "enable_cq_weight"
+#define DLB2_USE_DEFAULT_HL "use_default_hl"
+#define DLB2_ALLOC_HL_ENTRIES "alloc_hl_entries"
 
 /* Begin HW related defines and structs */
 
@@ -101,7 +103,8 @@
  */
 #define DLB2_MAX_HL_ENTRIES 2048
 #define DLB2_MIN_CQ_DEPTH 1
-#define DLB2_DEFAULT_CQ_DEPTH 32
+#define DLB2_DEFAULT_CQ_DEPTH 128 /* Override using max_cq_depth parameter */
+#define DLB2_FIXED_CQ_HL_SIZE 32  /* Used when ENABLE_FIXED_HL_SIZE is true */
 #define DLB2_MIN_HARDWARE_CQ_DEPTH 8
 #define DLB2_NUM_HIST_LIST_ENTRIES_PER_LDB_PORT \
 	DLB2_DEFAULT_CQ_DEPTH
@@ -123,7 +126,7 @@
 
 #define DLB2_NUM_QES_PER_CACHE_LINE 4
 
-#define DLB2_MAX_ENQUEUE_DEPTH 32
+#define DLB2_MAX_ENQUEUE_DEPTH 128
 #define DLB2_MIN_ENQUEUE_DEPTH 4
 
 #define DLB2_NAME_SIZE 64
@@ -385,10 +388,13 @@ struct dlb2_port {
 	struct dlb2_eventdev *dlb2; /* back ptr */
 	struct dlb2_eventdev_port *ev_port; /* back ptr */
 	bool use_scalar; /* force usage of scalar code */
+	uint8_t reorder_id; /* id used for reordering events coming back into the scheduler */
 	uint16_t hw_credit_quanta;
 	bool use_avx512;
+	bool enable_inflight_ctrl; /*DLB2.5 enable HW inflight control */
 	bool is_producer; /* True if port is of type producer */
-	uint8_t reorder_id; /* id used for reordering events coming back into the scheduler */
+	uint16_t inflight_threshold; /* DLB2.5 HW inflight threshold */
+	uint16_t hist_list; /* Port history list */
 	bool reorder_en;
 	struct dlb2_reorder *order; /* For ordering enqueues */
 };
@@ -650,6 +656,8 @@ struct dlb2_eventdev {
 	uint32_t cos_ports[DLB2_COS_NUM_VALS]; /* total ldb ports in each class */
 	uint32_t cos_bw[DLB2_COS_NUM_VALS]; /* bandwidth per cos domain */
 	bool enable_cq_weight;
+	uint16_t hl_entries; /* Num HL entries to allocate for the domain */
+	int default_port_hl;  /* Fixed or dynamic (2*CQ Depth) HL assignment */
 };
 
 /* used for collecting and passing around the dev args */
@@ -683,6 +691,8 @@ struct dlb2_devargs {
 	const char *producer_coremask;
 	bool default_ldb_port_allocation;
 	bool enable_cq_weight;
+	bool use_default_hl;
+	uint32_t alloc_hl_entries;
 };
 
 /* End Eventdev related defines and structs */
@@ -725,6 +735,9 @@ int dlb2_secondary_eventdev_probe(struct rte_eventdev *dev,
 uint32_t dlb2_get_queue_depth(struct dlb2_eventdev *dlb2,
 			      struct dlb2_eventdev_queue *queue);
 
+int dlb2_set_port_param(struct dlb2_eventdev *dlb2, int port_id,
+		uint64_t flags, void *val);
+
 int dlb2_parse_params(const char *params,
 		      const char *name,
 		      struct dlb2_devargs *dlb2_args,
diff --git a/drivers/event/dlb2/dlb2_user.h b/drivers/event/dlb2/dlb2_user.h
index 8739e2a5ac..4410da8db0 100644
--- a/drivers/event/dlb2/dlb2_user.h
+++ b/drivers/event/dlb2/dlb2_user.h
@@ -472,6 +472,8 @@ struct dlb2_create_ldb_port_args {
 	__u16 cq_history_list_size;
 	__u8 cos_id;
 	__u8 cos_strict;
+	__u8 enable_inflight_ctrl;
+	__u16 inflight_threshold;
 };
 
 /*
@@ -717,6 +719,28 @@ struct dlb2_enable_cq_weight_args {
 	__u32 limit;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_SET_CQ_INFLIGHT_CTRL: Set Per-CQ inflight control for
+ *  {ATM,UNO,ORD} QEs.
+ *
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - enable: True if inflight control is enabled. False otherwise
+ * - threshold: Per CQ inflight threshold.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_cq_inflight_ctrl_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u16 enable;
+	__u16 threshold;
+};
+
 /*
  * Mapping sizes for memory mapping the consumer queue (CQ) memory space, and
  * producer port (PP) MMIO space.
diff --git a/drivers/event/dlb2/pf/base/dlb2_regs.h b/drivers/event/dlb2/pf/base/dlb2_regs.h
index 7167f3d2ff..193c19bfbd 100644
--- a/drivers/event/dlb2/pf/base/dlb2_regs.h
+++ b/drivers/event/dlb2/pf/base/dlb2_regs.h
@@ -3238,6 +3238,15 @@
 #define DLB2_LSP_CQ_LDB_INFL_LIM_LIMIT_LOC	0
 #define DLB2_LSP_CQ_LDB_INFL_LIM_RSVD0_LOC	12
 
+#define DLB2_LSP_CQ_LDB_INFL_THRESH(x) \
+	(0x90580000 + (x) * 0x1000)
+#define DLB2_LSP_CQ_LDB_INFL_THRESH_RST 0x0
+
+#define DLB2_LSP_CQ_LDB_INFL_THRESH_THRESH  0x00000FFF
+#define DLB2_LSP_CQ_LDB_INFL_THRESH_RSVD0 0xFFFFF000
+#define DLB2_LSP_CQ_LDB_INFL_THRESH_THRESH_LOC  0
+#define DLB2_LSP_CQ_LDB_INFL_THRESH_RSVD0_LOC 12
+
 #define DLB2_V2LSP_CQ_LDB_TKN_CNT(x) \
 	(0xa0580000 + (x) * 0x1000)
 #define DLB2_V2_5LSP_CQ_LDB_TKN_CNT(x) \
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 3004902118..98f2f5ef92 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -5464,6 +5464,35 @@ dlb2_get_domain_used_ldb_port(u32 id,
 	return NULL;
 }
 
+static struct dlb2_ldb_port *
+dlb2_get_domain_ldb_port(u32 id,
+			 bool vdev_req,
+			 struct dlb2_hw_domain *domain)
+{
+	struct dlb2_list_entry *iter;
+	struct dlb2_ldb_port *port;
+	int i;
+
+	if (id >= DLB2_MAX_NUM_LDB_PORTS)
+		return NULL;
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port, iter) {
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+		}
+
+		DLB2_DOM_LIST_FOR(domain->avail_ldb_ports[i], port, iter) {
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+		}
+	}
+
+	return NULL;
+}
+
 static void dlb2_ldb_port_change_qid_priority(struct dlb2_hw *hw,
 					      struct dlb2_ldb_port *port,
 					      int slot,
@@ -6751,6 +6780,51 @@ int dlb2_hw_enable_cq_weight(struct dlb2_hw *hw,
 	return 0;
 }
 
+int dlb2_hw_set_cq_inflight_ctrl(struct dlb2_hw *hw, u32 domain_id,
+			struct dlb2_cq_inflight_ctrl_args *args,
+			struct dlb2_cmd_response *resp, bool vdev_req,
+			unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	u32 reg = 0;
+	int id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+	if (!domain) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: domain not found",
+			    __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_ldb_port(id, vdev_req, domain);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s():%d] Internal error: port not found",
+			    __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	DLB2_BITS_SET(reg, args->enable,
+		      DLB2_LSP_CFG_CTRL_GENERAL_0_ENAB_IF_THRESH_V2_5);
+	DLB2_CSR_WR(hw, DLB2_V2_5LSP_CFG_CTRL_GENERAL_0, reg);
+
+	if (args->enable) {
+		reg = 0;
+		DLB2_BITS_SET(reg, args->threshold,
+			      DLB2_LSP_CQ_LDB_INFL_THRESH_THRESH);
+		DLB2_CSR_WR(hw, DLB2_LSP_CQ_LDB_INFL_THRESH(port->id.phys_id),
+			    reg);
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
 static void dlb2_log_set_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id, u8 bw)
 {
 	DLB2_HW_DBG(hw, "DLB2 set port CoS bandwidth:\n");
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.h b/drivers/event/dlb2/pf/base/dlb2_resource.h
index 71bd6148f1..ee3402deff 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.h
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.h
@@ -1956,4 +1956,22 @@ int dlb2_hw_enable_cq_weight(struct dlb2_hw *hw,
 			     bool vdev_request,
 			     unsigned int vdev_id);
 
+/**
+ * This function configures the inflight control threshold for a cq.
+ *
+ * This must be called after creating the port.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error. If successful, resp->id
+ * contains the queue ID.
+ *
+ * Errors:
+ * EINVAL - The domain or port is not configured.
+ */
+int dlb2_hw_set_cq_inflight_ctrl(struct dlb2_hw *hw, u32 domain_id,
+			struct dlb2_cq_inflight_ctrl_args *args,
+			struct dlb2_cmd_response *resp,
+			bool vdev_request, unsigned int vdev_id);
+
 #endif /* __DLB2_RESOURCE_H */
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index 31b5487d85..a3f3e7f803 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -347,6 +347,7 @@ dlb2_pf_ldb_port_create(struct dlb2_hw_dev *handle,
 				      cfg,
 				      cq_base,
 				      &response);
+	cfg->response = response;
 	if (ret)
 		goto create_port_err;
 
@@ -422,6 +423,9 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 				      cfg,
 				      cq_base,
 				      &response);
+
+	cfg->response = response;
+
 	if (ret)
 		goto create_port_err;
 
@@ -646,6 +650,26 @@ dlb2_pf_enable_cq_weight(struct dlb2_hw_dev *handle,
 	return ret;
 }
 
+static int
+dlb2_pf_set_cq_inflight_ctrl(struct dlb2_hw_dev *handle,
+			     struct dlb2_cq_inflight_ctrl_args *args)
+{
+	struct dlb2_dev *dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+	struct dlb2_cmd_response response = {0};
+	int ret = 0;
+
+	DLB2_INFO(dev->dlb2_device, "Entering %s()\n", __func__);
+
+	ret = dlb2_hw_set_cq_inflight_ctrl(&dlb2_dev->hw, handle->domain_id,
+					   args, &response, false, 0);
+	args->response = response;
+
+	DLB2_INFO(dev->dlb2_device, "Exiting %s() with ret=%d",
+		  __func__, ret);
+
+	return ret;
+}
+
 static int
 dlb2_pf_set_cos_bandwidth(struct dlb2_hw_dev *handle,
 			  struct dlb2_set_cos_bw_args *args)
@@ -691,6 +715,7 @@ dlb2_pf_iface_fn_ptrs_init(void)
 	dlb2_iface_get_sn_occupancy = dlb2_pf_get_sn_occupancy;
 	dlb2_iface_enable_cq_weight = dlb2_pf_enable_cq_weight;
 	dlb2_iface_set_cos_bw = dlb2_pf_set_cos_bandwidth;
+	dlb2_iface_set_cq_inflight_ctrl = dlb2_pf_set_cq_inflight_ctrl;
 }
 
 /* PCI DEV HOOKS */
@@ -710,7 +735,9 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 		.hw_credit_quanta = DLB2_SW_CREDIT_BATCH_SZ,
 		.default_depth_thresh = DLB2_DEPTH_THRESH_DEFAULT,
 		.max_cq_depth = DLB2_DEFAULT_CQ_DEPTH,
-		.max_enq_depth = DLB2_MAX_ENQUEUE_DEPTH
+		.max_enq_depth = DLB2_MAX_ENQUEUE_DEPTH,
+		.use_default_hl = true,
+		.alloc_hl_entries = 0
 	};
 	struct dlb2_eventdev *dlb2;
 	int q;
diff --git a/drivers/event/dlb2/rte_pmd_dlb2.c b/drivers/event/dlb2/rte_pmd_dlb2.c
index 43990e46ac..8dfc8723ef 100644
--- a/drivers/event/dlb2/rte_pmd_dlb2.c
+++ b/drivers/event/dlb2/rte_pmd_dlb2.c
@@ -37,3 +37,26 @@ rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 
 	return 0;
 }
+
+int
+rte_pmd_dlb2_set_port_param(uint8_t dev_id,
+			    uint8_t port_id,
+			    uint64_t flags,
+			    void *val)
+{
+	struct dlb2_eventdev *dlb2;
+	struct rte_eventdev *dev;
+
+	if (val == NULL)
+		return -EINVAL;
+
+	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
+	dev = &rte_eventdevs[dev_id];
+
+	dlb2 = dlb2_pmd_priv(dev);
+
+	if (port_id >= dlb2->num_ports)
+		return -EINVAL;
+
+	return dlb2_set_port_param(dlb2, port_id, flags, val);
+}
diff --git a/drivers/event/dlb2/rte_pmd_dlb2.h b/drivers/event/dlb2/rte_pmd_dlb2.h
index 207ce6a3fd..3f529860ba 100644
--- a/drivers/event/dlb2/rte_pmd_dlb2.h
+++ b/drivers/event/dlb2/rte_pmd_dlb2.h
@@ -91,6 +91,46 @@ rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 				uint8_t port_id,
 				enum dlb2_token_pop_mode mode);
 
+/** Set inflight threshold for flow migration */
+#define DLB2_FLOW_MIGRATION_THRESHOLD RTE_BIT64(0)
+
+/** Set port history list */
+#define DLB2_SET_PORT_HL RTE_BIT64(1)
+
+struct dlb2_port_param {
+	uint16_t inflight_threshold : 12;
+	uint16_t port_hl;
+};
+
+/*!
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Configure various port parameters.
+ * AUTO_POP. This function must be called before calling rte_event_port_setup()
+ * for the port, but after calling rte_event_dev_configure().
+ *
+ * @param dev_id
+ *    The identifier of the event device.
+ * @param port_id
+ *    The identifier of the event port.
+ * @param flags
+ *    Bitmask of the parameters being set.
+ * @param val
+ *    Structure coantaining the values of parameters being set.
+ *
+ * @return
+ * - 0: Success
+ * - EINVAL: Invalid dev_id, port_id, or mode
+ * - EINVAL: The DLB2 is not configured, is already running, or the port is
+ *   already setup
+ */
+__rte_experimental
+int
+rte_pmd_dlb2_set_port_param(uint8_t dev_id,
+			    uint8_t port_id,
+			    uint64_t flags,
+			    void *val);
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/event/dlb2/version.map b/drivers/event/dlb2/version.map
index c37d2302cd..be5a8f6f2b 100644
--- a/drivers/event/dlb2/version.map
+++ b/drivers/event/dlb2/version.map
@@ -7,4 +7,5 @@ EXPERIMENTAL {
 
 	# added in 20.11
 	rte_pmd_dlb2_set_token_pop_mode;
+	rte_pmd_dlb2_set_port_param;
 };
-- 
2.25.1
