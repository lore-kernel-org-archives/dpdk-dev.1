Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36205C83030
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Jul 2025 18:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01BB24028B;
	Sat,  5 Jul 2025 20:42:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D27684025F
 for <dev@dpdk.org>; Sat,  5 Jul 2025 20:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751740934; x=1783276934;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bIkyGcv9BcQbqxkYIIrtjEmfm7jJMyJ+kntY4MY4i1M=;
 b=FO4Qrzs5u/qyHcT+l6XZ/yUyTDNtbqldruxGVAOHjYh0JXbdzEgyJgzy
 bLSS/+rYlMk1EdIJmpwGTbdR7y8QXTeALgq1cf5BGAWv08Lz79fN90LWu
 Wur5D1wYyAO1+SyXZahLatvE2uc+19JK89WYJiiq/nKcXjqWgyjuOFfS0
 HhuW9WDWDJS/w/w0iAhDNhGdTrcr6tSXLjkVxh45TI+CX0324NStsLHoe
 nDQAGCdY80m5/Rkfq3Dt+0xUnakItIqoRwsQfkUYa91Y4gMWzO/o/OFN2
 HUkSVGwlw+srJ8vjbZKPQUtcqmJdf9PHFPjLGxIUrt+S4JMwUpRLiRH1W g==;
X-CSE-ConnectionGUID: 9WH4dbV4R52dfpFTaX33Fg==
X-CSE-MsgGUID: DpDWBARvRgCBSMEZw1rpnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="76567129"
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; d="scan'208";a="76567129"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2025 11:42:13 -0700
X-CSE-ConnectionGUID: V+5H26LlR/WP1JqxyLjpyw==
X-CSE-MsgGUID: hPy1QjZxQ1Cpg4JJBUcKOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; d="scan'208";a="154603355"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa009.jf.intel.com with ESMTP; 05 Jul 2025 11:42:12 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1] event/dlb2: add support for stop and restart dlb device
Date: Sat,  5 Jul 2025 13:42:09 -0500
Message-Id: <20250705184209.924922-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
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

This feature enables restarting a stopped eventdev with a call
to rte_event_dev_start(). For this, the DLB scheduling domain needs
to be stopped, all DLB ports disabled during eventdev stop and
re-enabled during start. Port configuration is preserved.

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/event/dlb2/dlb2.c                  |  72 ++-
 drivers/event/dlb2/dlb2_iface.c            |   6 +-
 drivers/event/dlb2/dlb2_iface.h            |   7 +-
 drivers/event/dlb2/dlb2_user.h             |  16 +
 drivers/event/dlb2/pf/base/dlb2_resource.c | 583 +++++++++++++++++++--
 drivers/event/dlb2/pf/base/dlb2_resource.h | 150 ++++++
 drivers/event/dlb2/pf/dlb2_main.c          |  10 +
 drivers/event/dlb2/pf/dlb2_main.h          |   4 +
 drivers/event/dlb2/pf/dlb2_pf.c            |  69 ++-
 9 files changed, 857 insertions(+), 60 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 084875f1c8..7827d697cf 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -1025,18 +1025,28 @@ dlb2_hw_create_sched_domain(struct dlb2_eventdev *dlb2,
 	return ret;
 }
 
-static void
+static int
 dlb2_hw_reset_sched_domain(const struct rte_eventdev *dev, bool reconfig)
 {
 	struct dlb2_eventdev *dlb2 = dlb2_pmd_priv(dev);
 	enum dlb2_configuration_state config_state;
-	int i, j;
+	int i, j, ret;
 
-	dlb2_iface_domain_reset(dlb2);
+	ret = dlb2_iface_domain_reset(dlb2);
+	if (ret) {
+		DLB2_LOG_ERR("dlb2_hw_reset_domain err %d", ret);
+		return ret;
+	}
 
 	/* Free all dynamically allocated port memory */
-	for (i = 0; i < dlb2->num_ports; i++)
+	for (i = 0; i < dlb2->num_ports; i++) {
 		dlb2_free_qe_mem(&dlb2->ev_ports[i].qm_port);
+		if (!reconfig) {
+			dlb2->ev_ports[i].qm_port.enable_inflight_ctrl = 0;
+			dlb2->ev_ports[i].qm_port.token_pop_mode = 0;
+			dlb2->ev_ports[i].qm_port.hist_list = 0;
+		}
+	}
 
 	/* If reconfiguring, mark the device's queues and ports as "previously
 	 * configured." If the user doesn't reconfigure them, the PMD will
@@ -1075,6 +1085,8 @@ dlb2_hw_reset_sched_domain(const struct rte_eventdev *dev, bool reconfig)
 		dlb2->max_dir_credits = 0;
 	}
 	dlb2->configured = false;
+
+	return 0;
 }
 
 /* Note: 1 QM instance per QM device, QM instance/device == event device */
@@ -1092,7 +1104,9 @@ dlb2_eventdev_configure(const struct rte_eventdev *dev)
 	 * scheduling domain before attempting to configure a new one.
 	 */
 	if (dlb2->configured) {
-		dlb2_hw_reset_sched_domain(dev, true);
+		ret = dlb2_hw_reset_sched_domain(dev, true);
+		if (ret)
+			return ret;
 		ret = dlb2_hw_query_resources(dlb2);
 		if (ret) {
 			DLB2_LOG_ERR("get resources err=%d, devid=%d",
@@ -2818,6 +2832,27 @@ dlb2_eventdev_apply_port_links(struct rte_eventdev *dev)
 	return 0;
 }
 
+static int
+dlb2_set_port_ctrl(struct dlb2_eventdev_port *ev_port, bool enable)
+{
+	const char *err_str = enable ? "enabled" : "disabled";
+
+	if (!ev_port->setup_done)
+		return 0;
+
+	if (!(ev_port->enq_configured ^ enable)) {
+		DLB2_LOG_INFO("dlb2: ev_port %d already %s", ev_port->id, err_str);
+		return 0;
+	}
+	if (dlb2_iface_port_ctrl(&ev_port->qm_port, enable)) {
+		DLB2_LOG_ERR("dlb2: ev_port %d could not be %s", ev_port->id, err_str);
+		return -EFAULT;
+	}
+	ev_port->enq_configured = enable;
+
+	return 0;
+}
+
 static int
 dlb2_eventdev_start(struct rte_eventdev *dev)
 {
@@ -2849,10 +2884,14 @@ dlb2_eventdev_start(struct rte_eventdev *dev)
 		return ret;
 
 	for (i = 0; i < dlb2->num_ports; i++) {
-		if (!dlb2->ev_ports[i].setup_done) {
+		struct dlb2_eventdev_port *ev_port = &dlb2->ev_ports[i];
+
+		if (!ev_port->setup_done && ev_port->qm_port.config_state != DLB2_NOT_CONFIGURED) {
 			DLB2_LOG_ERR("dlb2: port %d not setup", i);
 			return -ESTALE;
 		}
+		if (dlb2_set_port_ctrl(ev_port, true))
+			return -EFAULT;
 	}
 
 	for (i = 0; i < dlb2->num_queues; i++) {
@@ -4816,9 +4855,11 @@ static void
 dlb2_drain(struct rte_eventdev *dev)
 {
 	struct dlb2_eventdev *dlb2 = dlb2_pmd_priv(dev);
+	struct dlb2_hw_dev *handle = &dlb2->qm_instance;
 	struct dlb2_eventdev_port *ev_port = NULL;
+	struct dlb2_stop_domain_args cfg;
 	uint8_t dev_id;
-	int i;
+	int i, ret;
 
 	dev_id = dev->data->dev_id;
 
@@ -4836,7 +4877,7 @@ dlb2_drain(struct rte_eventdev *dev)
 
 	/* If the domain's queues are empty, we're done. */
 	if (dlb2_queues_empty(dlb2))
-		return;
+		goto domain_cleanup;
 
 	/* Else, there must be at least one unlinked load-balanced queue.
 	 * Select a load-balanced port with which to drain the unlinked
@@ -4896,6 +4937,17 @@ dlb2_drain(struct rte_eventdev *dev)
 			return;
 		}
 	}
+
+domain_cleanup:
+	for (i = 0; i < dlb2->num_ports; i++)
+		dlb2_set_port_ctrl(&dlb2->ev_ports[i], false);
+
+	ret = dlb2_iface_sched_domain_stop(handle, &cfg);
+	if (ret < 0) {
+		DLB2_LOG_ERR("dlb2: sched_domain_stop ret=%d (driver status: %s)",
+			     ret, dlb2_error_strings[cfg.response.status]);
+		return;
+	}
 }
 
 static void
@@ -4928,9 +4980,7 @@ dlb2_eventdev_stop(struct rte_eventdev *dev)
 static int
 dlb2_eventdev_close(struct rte_eventdev *dev)
 {
-	dlb2_hw_reset_sched_domain(dev, false);
-
-	return 0;
+	return dlb2_hw_reset_sched_domain(dev, false);
 }
 
 static void
diff --git a/drivers/event/dlb2/dlb2_iface.c b/drivers/event/dlb2/dlb2_iface.c
index 3caa827d31..3cb5993ed8 100644
--- a/drivers/event/dlb2/dlb2_iface.c
+++ b/drivers/event/dlb2/dlb2_iface.c
@@ -30,7 +30,7 @@ int (*dlb2_iface_get_num_resources)(struct dlb2_hw_dev *handle,
 int (*dlb2_iface_sched_domain_create)(struct dlb2_hw_dev *handle,
 				struct dlb2_create_sched_domain_args *args);
 
-void (*dlb2_iface_domain_reset)(struct dlb2_eventdev *dlb2);
+int (*dlb2_iface_domain_reset)(struct dlb2_eventdev *dlb2);
 
 int (*dlb2_iface_ldb_queue_create)(struct dlb2_hw_dev *handle,
 				   struct dlb2_create_ldb_queue_args *cfg);
@@ -67,6 +67,9 @@ int (*dlb2_iface_pending_port_unmaps)(struct dlb2_hw_dev *handle,
 int (*dlb2_iface_sched_domain_start)(struct dlb2_hw_dev *handle,
 				     struct dlb2_start_domain_args *cfg);
 
+int (*dlb2_iface_sched_domain_stop)(struct dlb2_hw_dev *handle,
+				     struct dlb2_stop_domain_args *cfg);
+
 int (*dlb2_iface_get_ldb_queue_depth)(struct dlb2_hw_dev *handle,
 				struct dlb2_get_ldb_queue_depth_args *args);
 
@@ -82,3 +85,4 @@ int (*dlb2_iface_set_cq_inflight_ctrl)(struct dlb2_hw_dev *handle,
 int (*dlb2_iface_set_cos_bw)(struct dlb2_hw_dev *handle,
 			     struct dlb2_set_cos_bw_args *args);
 
+int (*dlb2_iface_port_ctrl)(struct dlb2_port *qm_port, bool enable);
diff --git a/drivers/event/dlb2/dlb2_iface.h b/drivers/event/dlb2/dlb2_iface.h
index c78a8ffb7c..8be6be536e 100644
--- a/drivers/event/dlb2/dlb2_iface.h
+++ b/drivers/event/dlb2/dlb2_iface.h
@@ -29,7 +29,7 @@ extern int (*dlb2_iface_get_num_resources)(struct dlb2_hw_dev *handle,
 extern int (*dlb2_iface_sched_domain_create)(struct dlb2_hw_dev *handle,
 				 struct dlb2_create_sched_domain_args *args);
 
-extern void (*dlb2_iface_domain_reset)(struct dlb2_eventdev *dlb2);
+extern int (*dlb2_iface_domain_reset)(struct dlb2_eventdev *dlb2);
 
 extern int (*dlb2_iface_ldb_queue_create)(struct dlb2_hw_dev *handle,
 				  struct dlb2_create_ldb_queue_args *cfg);
@@ -66,6 +66,9 @@ extern int (*dlb2_iface_pending_port_unmaps)(struct dlb2_hw_dev *handle,
 extern int (*dlb2_iface_sched_domain_start)(struct dlb2_hw_dev *handle,
 				struct dlb2_start_domain_args *cfg);
 
+extern int (*dlb2_iface_sched_domain_stop)(struct dlb2_hw_dev *handle,
+				struct dlb2_stop_domain_args *cfg);
+
 extern int (*dlb2_iface_get_ldb_queue_depth)(struct dlb2_hw_dev *handle,
 				struct dlb2_get_ldb_queue_depth_args *args);
 
@@ -81,4 +84,6 @@ extern int (*dlb2_iface_set_cq_inflight_ctrl)(struct dlb2_hw_dev *handle,
 extern int (*dlb2_iface_set_cos_bw)(struct dlb2_hw_dev *handle,
 				    struct dlb2_set_cos_bw_args *args);
 
+extern int (*dlb2_iface_port_ctrl)(struct dlb2_port *qm_port, bool enable);
+
 #endif /* _DLB2_IFACE_H_ */
diff --git a/drivers/event/dlb2/dlb2_user.h b/drivers/event/dlb2/dlb2_user.h
index 4410da8db0..7d63056e6d 100644
--- a/drivers/event/dlb2/dlb2_user.h
+++ b/drivers/event/dlb2/dlb2_user.h
@@ -520,6 +520,22 @@ struct dlb2_start_domain_args {
 	struct dlb2_cmd_response response;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_STOP_DOMAIN: Stop scheduling of a domain. Scheduling can be
+ *	resumed by calling DLB2_DOMAIN_CMD_START_DOMAIN. Sending QEs into the
+ *	device after calling this ioctl will result in undefined behavior.
+ * Input parameters:
+ * - (None)
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_stop_domain_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+};
+
 /*
  * DLB2_DOMAIN_CMD_MAP_QID: Map a load-balanced queue to a load-balanced port.
  * Input parameters:
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 98f2f5ef92..87a15416bb 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -6102,12 +6102,14 @@ int dlb2_hw_pending_port_unmaps(struct dlb2_hw *hw,
 	return 0;
 }
 
-static int dlb2_verify_start_domain_args(struct dlb2_hw *hw,
-					 u32 domain_id,
-					 struct dlb2_cmd_response *resp,
-					 bool vdev_req,
-					 unsigned int vdev_id,
-					 struct dlb2_hw_domain **out_domain)
+
+static int dlb2_verify_start_stop_domain_args(struct dlb2_hw *hw,
+					      u32 domain_id,
+					      bool start_domain,
+					      struct dlb2_cmd_response *resp,
+					      bool vdev_req,
+					      unsigned int vdev_id,
+					      struct dlb2_hw_domain **out_domain)
 {
 	struct dlb2_hw_domain *domain;
 
@@ -6123,8 +6125,8 @@ static int dlb2_verify_start_domain_args(struct dlb2_hw *hw,
 		return -EINVAL;
 	}
 
-	if (domain->started) {
-		resp->status = DLB2_ST_DOMAIN_STARTED;
+	if (!(domain->started ^ start_domain)) {
+		resp->status = start_domain ? DLB2_ST_DOMAIN_STARTED : DLB2_ST_DOMAIN_NOT_STARTED;
 		return -EINVAL;
 	}
 
@@ -6144,53 +6146,29 @@ static void dlb2_log_start_domain(struct dlb2_hw *hw,
 	DLB2_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
 }
 
-/**
- * dlb2_hw_start_domain() - start a scheduling domain
- * @hw: dlb2_hw handle for a particular device.
- * @domain_id: domain ID.
- * @arg: start domain arguments.
- * @resp: response structure.
- * @vdev_req: indicates whether this request came from a vdev.
- * @vdev_id: If vdev_req is true, this contains the vdev's ID.
- *
- * This function starts a scheduling domain, which allows applications to send
- * traffic through it. Once a domain is started, its resources can no longer be
- * configured (besides QID remapping and port enable/disable).
- *
- * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
- * device.
- *
- * Return:
- * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
- * assigned a detailed error code from enum dlb2_error.
- *
- * Errors:
- * EINVAL - the domain is not configured, or the domain is already started.
- */
-int
-dlb2_hw_start_domain(struct dlb2_hw *hw,
+static int
+dlb2_hw_start_stop_domain(struct dlb2_hw *hw,
 		     u32 domain_id,
-		     struct dlb2_start_domain_args *args,
+		     bool start_domain,
 		     struct dlb2_cmd_response *resp,
 		     bool vdev_req,
 		     unsigned int vdev_id)
 {
-	struct dlb2_list_entry *iter;
+	struct dlb2_list_entry *iter __rte_unused;
 	struct dlb2_dir_pq_pair *dir_queue;
 	struct dlb2_ldb_queue *ldb_queue;
 	struct dlb2_hw_domain *domain;
 	int ret;
-	RTE_SET_USED(args);
-	RTE_SET_USED(iter);
 
 	dlb2_log_start_domain(hw, domain_id, vdev_req, vdev_id);
 
-	ret = dlb2_verify_start_domain_args(hw,
-					    domain_id,
-					    resp,
-					    vdev_req,
-					    vdev_id,
-					    &domain);
+	ret = dlb2_verify_start_stop_domain_args(hw,
+						 domain_id,
+						 start_domain,
+						 resp,
+						 vdev_req,
+						 vdev_id,
+						 &domain);
 	if (ret)
 		return ret;
 
@@ -6203,7 +6181,8 @@ dlb2_hw_start_domain(struct dlb2_hw *hw,
 		u32 vasqid_v = 0;
 		unsigned int offs;
 
-		DLB2_BIT_SET(vasqid_v, DLB2_SYS_LDB_VASQID_V_VASQID_V);
+		if (start_domain)
+			DLB2_BIT_SET(vasqid_v, DLB2_SYS_LDB_VASQID_V_VASQID_V);
 
 		offs = domain->id.phys_id * DLB2_MAX_NUM_LDB_QUEUES +
 			ldb_queue->id.phys_id;
@@ -6215,7 +6194,8 @@ dlb2_hw_start_domain(struct dlb2_hw *hw,
 		u32 vasqid_v = 0;
 		unsigned int offs;
 
-		DLB2_BIT_SET(vasqid_v, DLB2_SYS_DIR_VASQID_V_VASQID_V);
+		if (start_domain)
+			DLB2_BIT_SET(vasqid_v, DLB2_SYS_DIR_VASQID_V_VASQID_V);
 
 		offs = domain->id.phys_id * DLB2_MAX_NUM_DIR_PORTS(hw->ver) +
 			dir_queue->id.phys_id;
@@ -6225,13 +6205,86 @@ dlb2_hw_start_domain(struct dlb2_hw *hw,
 
 	dlb2_flush_csr(hw);
 
-	domain->started = true;
+	/* Return any pending tokens before stopping the domain. */
+	if (!start_domain) {
+		dlb2_domain_drain_ldb_cqs(hw, domain, false);
+		dlb2_domain_drain_dir_cqs(hw, domain, false);
+	}
+	domain->started = start_domain;
 
 	resp->status = 0;
 
 	return 0;
 }
 
+/**
+ * dlb2_hw_start_domain() - start a scheduling domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @arg: start domain arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function starts a scheduling domain, which allows applications to send
+ * traffic through it. Once a domain is started, its resources can no longer be
+ * configured (besides QID remapping and port enable/disable).
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - the domain is not configured, or the domain is already started.
+ */
+int
+dlb2_hw_start_domain(struct dlb2_hw *hw,
+		     u32 domain_id,
+		     __attribute((unused)) struct dlb2_start_domain_args *args,
+		     struct dlb2_cmd_response *resp,
+		     bool vdev_req,
+		     unsigned int vdev_id)
+{
+	return dlb2_hw_start_stop_domain(hw, domain_id, true, resp, vdev_req, vdev_id);
+}
+
+/**
+ * dlb2_hw_stop_domain() - stop a scheduling domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @arg: stop domain arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function stops a scheduling domain, which allows applications to send
+ * traffic through it. Once a domain is stoped, its resources can no longer be
+ * configured (besides QID remapping and port enable/disable).
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - the domain is not configured, or the domain is already stoped.
+ */
+int
+dlb2_hw_stop_domain(struct dlb2_hw *hw,
+		     u32 domain_id,
+		     __attribute((unused)) struct dlb2_stop_domain_args *args,
+		     struct dlb2_cmd_response *resp,
+		     bool vdev_req,
+		     unsigned int vdev_id)
+{
+	return dlb2_hw_start_stop_domain(hw, domain_id, false, resp, vdev_req, vdev_id);
+}
+
 static void dlb2_log_get_dir_queue_depth(struct dlb2_hw *hw,
 					 u32 domain_id,
 					 u32 queue_id,
@@ -6890,3 +6943,441 @@ int dlb2_hw_set_cos_bandwidth(struct dlb2_hw *hw, u32 cos_id, u8 bandwidth)
 
 	return 0;
 }
+
+static int
+dlb2_verify_enable_ldb_port_args(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 struct dlb2_enable_ldb_port_args *args,
+				 struct dlb2_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id,
+				 struct dlb2_hw_domain **out_domain,
+				 struct dlb2_ldb_port **out_port)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB2_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	if (!port || !port->configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = port;
+
+	return 0;
+}
+
+static int
+dlb2_verify_enable_dir_port_args(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 struct dlb2_enable_dir_port_args *args,
+				 struct dlb2_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id,
+				 struct dlb2_hw_domain **out_domain,
+				 struct dlb2_dir_pq_pair **out_port)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_dir_pq_pair *port;
+	int id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB2_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_dir_pq(hw, id, vdev_req, domain);
+
+	if (!port || !port->port_configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = port;
+
+	return 0;
+}
+
+static int
+dlb2_verify_disable_ldb_port_args(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  struct dlb2_disable_ldb_port_args *args,
+				  struct dlb2_cmd_response *resp,
+				  bool vdev_req,
+				  unsigned int vdev_id,
+				  struct dlb2_hw_domain **out_domain,
+				  struct dlb2_ldb_port **out_port)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB2_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	if (!port || !port->configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = port;
+
+	return 0;
+}
+
+static int
+dlb2_verify_disable_dir_port_args(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  struct dlb2_disable_dir_port_args *args,
+				  struct dlb2_cmd_response *resp,
+				  bool vdev_req,
+				  unsigned int vdev_id,
+				  struct dlb2_hw_domain **out_domain,
+				  struct dlb2_dir_pq_pair **out_port)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_dir_pq_pair *port;
+	int id;
+
+	domain = dlb2_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB2_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB2_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	id = args->port_id;
+
+	port = dlb2_get_domain_used_dir_pq(hw, id, vdev_req, domain);
+
+	if (!port || !port->port_configured) {
+		resp->status = DLB2_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = port;
+
+	return 0;
+}
+
+static void dlb2_log_enable_port(struct dlb2_hw *hw,
+				 u32 domain_id,
+				 u32 port_id,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 enable port arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n",
+		    port_id);
+}
+
+/**
+ * dlb2_hw_enable_ldb_port() - enable a load-balanced port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port enable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs to a load-balanced port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_enable_ldb_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_ldb_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int ret;
+
+	dlb2_log_enable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_enable_ldb_port_args(hw,
+					       domain_id,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id,
+					       &domain,
+					       &port);
+	if (ret)
+		return ret;
+
+	if (!port->enabled) {
+		dlb2_ldb_port_cq_enable(hw, port);
+		port->enabled = true;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
+static void dlb2_log_disable_port(struct dlb2_hw *hw,
+				  u32 domain_id,
+				  u32 port_id,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	DLB2_HW_DBG(hw, "DLB2 disable port arguments:\n");
+	if (vdev_req)
+		DLB2_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB2_HW_DBG(hw, "\tDomain ID: %d\n",
+		    domain_id);
+	DLB2_HW_DBG(hw, "\tPort ID:   %d\n",
+		    port_id);
+}
+
+/**
+ * dlb2_hw_disable_ldb_port() - disable a load-balanced port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port disable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs to a load-balanced
+ * port. Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_disable_ldb_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_ldb_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int ret;
+
+	dlb2_log_disable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_disable_ldb_port_args(hw,
+						domain_id,
+						args,
+						resp,
+						vdev_req,
+						vdev_id,
+						&domain,
+						&port);
+	if (ret)
+		return ret;
+
+	if (port->enabled) {
+		dlb2_ldb_port_cq_disable(hw, port);
+		port->enabled = false;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
+/**
+ * dlb2_hw_enable_dir_port() - enable a directed port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port enable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs to a directed port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_enable_dir_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_dir_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	dlb2_log_enable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_enable_dir_port_args(hw,
+					       domain_id,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id,
+					       &domain,
+					       &port);
+	if (ret)
+		return ret;
+
+	if (!port->enabled) {
+		dlb2_dir_port_cq_enable(hw, port);
+		port->enabled = true;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
+
+/**
+ * dlb2_hw_disable_dir_port() - disable a directed port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port disable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs to a directed port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_disable_dir_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_dir_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+	int ret;
+
+	dlb2_log_disable_port(hw, domain_id, args->port_id, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb2_verify_disable_dir_port_args(hw,
+						domain_id,
+						args,
+						resp,
+						vdev_req,
+						vdev_id,
+						&domain,
+						&port);
+	if (ret)
+		return ret;
+
+	if (port->enabled) {
+		dlb2_dir_port_cq_disable(hw, port);
+		port->enabled = false;
+	}
+
+	resp->status = 0;
+
+	return 0;
+}
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.h b/drivers/event/dlb2/pf/base/dlb2_resource.h
index ee3402deff..c0fe390160 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.h
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.h
@@ -268,6 +268,35 @@ int dlb2_hw_start_domain(struct dlb2_hw *hw,
 			 bool vdev_request,
 			 unsigned int vdev_id);
 
+/**
+ * dlb2_hw_stop_domain() - stop a scheduling domain
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: stop domain arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function stops a scheduling domain. When stopped applications can no
+ * longer send traffic through it.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - the domain is not configured, or the domain is already stopped.
+ */
+int dlb2_hw_stop_domain(struct dlb2_hw *hw,
+			 u32 domain_id,
+			 struct dlb2_stop_domain_args *args,
+			 struct dlb2_cmd_response *resp,
+			 bool vdev_req,
+			 unsigned int vdev_id);
+
 /**
  * dlb2_hw_map_qid() - map a load-balanced queue to a load-balanced port
  * @hw: dlb2_hw handle for a particular device.
@@ -1974,4 +2003,125 @@ int dlb2_hw_set_cq_inflight_ctrl(struct dlb2_hw *hw, u32 domain_id,
 			struct dlb2_cmd_response *resp,
 			bool vdev_request, unsigned int vdev_id);
 
+/**
+ * dlb2_hw_enable_ldb_port() - enable a load-balanced port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port enable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs to a load-balanced port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_enable_ldb_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_ldb_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id);
+
+/**
+ * dlb2_hw_disable_ldb_port() - disable a load-balanced port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port disable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs to a load-balanced
+ * port. Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_disable_ldb_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_ldb_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id);
+
+/**
+ * dlb2_hw_enable_dir_port() - enable a directed port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port enable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs to a directed port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_enable_dir_port(struct dlb2_hw *hw,
+			    u32 domain_id,
+			    struct dlb2_enable_dir_port_args *args,
+			    struct dlb2_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id);
+
+/**
+ * dlb2_hw_disable_dir_port() - disable a directed port for scheduling
+ * @hw: dlb2_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port disable arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs to a directed port.
+ * Ports are enabled by default.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb2_error.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid or the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb2_hw_disable_dir_port(struct dlb2_hw *hw,
+			     u32 domain_id,
+			     struct dlb2_disable_dir_port_args *args,
+			     struct dlb2_cmd_response *resp,
+			     bool vdev_req,
+			     unsigned int vdev_id);
+
+
 #endif /* __DLB2_RESOURCE_H */
diff --git a/drivers/event/dlb2/pf/dlb2_main.c b/drivers/event/dlb2/pf/dlb2_main.c
index 89eabc2a93..cc5c3a9087 100644
--- a/drivers/event/dlb2/pf/dlb2_main.c
+++ b/drivers/event/dlb2/pf/dlb2_main.c
@@ -600,3 +600,13 @@ dlb2_pf_start_domain(struct dlb2_hw *hw,
 	return dlb2_hw_start_domain(hw, id, args, resp, NOT_VF_REQ,
 				    PF_ID_ZERO);
 }
+
+int
+dlb2_pf_stop_domain(struct dlb2_hw *hw,
+		     u32 id,
+		     struct dlb2_stop_domain_args *args,
+		     struct dlb2_cmd_response *resp)
+{
+	return dlb2_hw_stop_domain(hw, id, args, resp, NOT_VF_REQ,
+				    PF_ID_ZERO);
+}
diff --git a/drivers/event/dlb2/pf/dlb2_main.h b/drivers/event/dlb2/pf/dlb2_main.h
index 12912a2dec..abf0fcf35c 100644
--- a/drivers/event/dlb2/pf/dlb2_main.h
+++ b/drivers/event/dlb2/pf/dlb2_main.h
@@ -85,6 +85,10 @@ int dlb2_pf_start_domain(struct dlb2_hw *hw,
 			 u32 domain_id,
 			 struct dlb2_start_domain_args *args,
 			 struct dlb2_cmd_response *resp);
+int dlb2_pf_stop_domain(struct dlb2_hw *hw,
+			 u32 domain_id,
+			 struct dlb2_stop_domain_args *args,
+			 struct dlb2_cmd_response *resp);
 int dlb2_pf_enable_ldb_port(struct dlb2_hw *hw,
 			    u32 domain_id,
 			    struct dlb2_enable_ldb_port_args *args,
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index edcdfb319f..e1b90394d1 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -202,7 +202,7 @@ dlb2_pf_sched_domain_create(struct dlb2_hw_dev *handle,
 	return ret;
 }
 
-static void
+static int
 dlb2_pf_domain_reset(struct dlb2_eventdev *dlb2)
 {
 	struct dlb2_dev *dlb2_dev;
@@ -212,6 +212,7 @@ dlb2_pf_domain_reset(struct dlb2_eventdev *dlb2)
 	ret = dlb2_pf_reset_domain(&dlb2_dev->hw, dlb2->qm_instance.domain_id);
 	if (ret)
 		DLB2_LOG_ERR("dlb2_pf_reset_domain err %d", ret);
+	return ret;
 }
 
 static int
@@ -609,6 +610,29 @@ dlb2_pf_sched_domain_start(struct dlb2_hw_dev *handle,
 	return ret;
 }
 
+static int
+dlb2_pf_sched_domain_stop(struct dlb2_hw_dev *handle,
+			   struct dlb2_stop_domain_args *cfg)
+{
+	struct dlb2_dev *dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+	struct dlb2_cmd_response response = {0};
+	int ret;
+
+	DLB2_INFO(dev->dlb2_device, "Entering %s()\n", __func__);
+
+	ret = dlb2_pf_stop_domain(&dlb2_dev->hw,
+				   handle->domain_id,
+				   cfg,
+				   &response);
+
+	cfg->response = response;
+
+	DLB2_INFO(dev->dlb2_device, "Exiting %s() with ret=%d\n",
+		  __func__, ret);
+
+	return ret;
+}
+
 static int
 dlb2_pf_get_ldb_queue_depth(struct dlb2_hw_dev *handle,
 			    struct dlb2_get_ldb_queue_depth_args *args)
@@ -722,6 +746,47 @@ dlb2_pf_set_cos_bandwidth(struct dlb2_hw_dev *handle,
 	return ret;
 }
 
+static int dlb2_pf_port_ctrl(struct dlb2_port *qm_port, bool enable)
+{
+	struct dlb2_hw_dev *handle = &qm_port->dlb2->qm_instance;
+	struct dlb2_cmd_response response = {0};
+	struct dlb2_dev *dlb2_dev;
+	int ret = 0;
+
+	dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+
+	if (PORT_TYPE(qm_port) == DLB2_LDB_PORT) {
+		if (enable) {
+			struct dlb2_enable_ldb_port_args args = {.port_id = qm_port->id};
+
+			ret = dlb2_hw_enable_ldb_port(&dlb2_dev->hw, handle->domain_id,
+						      &args, &response, false, 0);
+		} else {
+			struct dlb2_disable_ldb_port_args args = {.port_id = qm_port->id};
+
+			ret = dlb2_hw_disable_ldb_port(&dlb2_dev->hw, handle->domain_id,
+						      &args, &response, false, 0);
+		}
+	} else {
+		if (enable) {
+			struct dlb2_enable_dir_port_args args = {.port_id = qm_port->id};
+
+			ret = dlb2_hw_enable_dir_port(&dlb2_dev->hw, handle->domain_id,
+						      &args, &response, false, 0);
+		} else {
+			struct dlb2_disable_dir_port_args args = {.port_id = qm_port->id};
+
+			ret = dlb2_hw_disable_dir_port(&dlb2_dev->hw, handle->domain_id,
+						      &args, &response, false, 0);
+		}
+	}
+
+	DLB2_INFO(dev->dlb2_device, "Exiting %s() with ret=%d\n",
+		  __func__, ret);
+
+	return ret;
+}
+
 static void
 dlb2_pf_iface_fn_ptrs_init(void)
 {
@@ -742,6 +807,7 @@ dlb2_pf_iface_fn_ptrs_init(void)
 	dlb2_iface_get_ldb_queue_depth = dlb2_pf_get_ldb_queue_depth;
 	dlb2_iface_get_dir_queue_depth = dlb2_pf_get_dir_queue_depth;
 	dlb2_iface_sched_domain_start = dlb2_pf_sched_domain_start;
+	dlb2_iface_sched_domain_stop = dlb2_pf_sched_domain_stop;
 	dlb2_iface_pending_port_unmaps = dlb2_pf_pending_port_unmaps;
 	dlb2_iface_get_sn_allocation = dlb2_pf_get_sn_allocation;
 	dlb2_iface_set_sn_allocation = dlb2_pf_set_sn_allocation;
@@ -749,6 +815,7 @@ dlb2_pf_iface_fn_ptrs_init(void)
 	dlb2_iface_enable_cq_weight = dlb2_pf_enable_cq_weight;
 	dlb2_iface_set_cos_bw = dlb2_pf_set_cos_bandwidth;
 	dlb2_iface_set_cq_inflight_ctrl = dlb2_pf_set_cq_inflight_ctrl;
+	dlb2_iface_port_ctrl = dlb2_pf_port_ctrl;
 }
 
 /* PCI DEV HOOKS */
-- 
2.25.1

