Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C98F01821
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04E5640DDD;
	Fri,  6 Mar 2026 11:58:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9147C40B94
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794713; x=1804330713;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XsaTyANc07kZ1Te9zcireXLNQ+kRpc3vu0gQId3Kf64=;
 b=meLrMnhLYZUSmaAqTa2PmqGqYaZjzjh4lznqcwDxjFzGKt1mkOS42Oz7
 Ovo+0f5Amlf+M2ABgdyeDvKlxmVE8FbxFRHsp9HuSsv8EWJru6nmDjFkB
 fdKpe3Br/qIV/TwPbji5oCm8r3G9NAE019bohBAKkXAK35iZKq/2aN1wt
 3EStcJSw+eVtH6L6XuK3oK3kAOqghOTFSETfIAiG/BwBiVg0ghSx/QJWw
 i7UZTAR6g8j4knVezzsUSXo3kzPnOunJRxbLGw7XyJeWMmvSwq4T8kDK7
 kWK/lr7HVHh60jw9g3s2z0Y2vkikdj5q2mFOnM0nNZedG75DhaP6Q4Ehr Q==;
X-CSE-ConnectionGUID: Lp43zw7aRyi39xUxnGrSVg==
X-CSE-MsgGUID: d6x4QD5sTaizJSqP9cnSqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984549"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:32 -0800
X-CSE-ConnectionGUID: IHzyfPNxRK6Vwr0raHMuEg==
X-CSE-MsgGUID: DshX3jr1RHSDNusQcgN6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678394"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 4/8] net/iavf: rework "async" virtchnl requests
Date: Fri,  6 Mar 2026 10:58:20 +0000
Message-ID: <d5193c7e8c1cf6ba351409943a59a546f4dcaa7c.1772794442.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
References: 
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

Currently, IPsec crypto requests are called with `async` parameter set to 1
on account of these requests generating two virtchnl responses instead of
having just one, like all other requests.

However, this terminology is misleading, because in actuality *almost all*
virtchnl requests are asynchronously implemented; that is, almost all of
them will send a request into virtchnl command queue, and then expect to
receive a virtchnl response in an interrupt thread, which will update the
global "pending command" status and write into the global response buffer,
while the pending request will simply check pending command status on a
timer. So, for almost all requests, the command status is updated
asynchronously. The only times this *doesn't* happen is 1) when the
request is sent from an interrupt thread context, or 2) when the requests
are sent at init time and the interrupt thread isn't active yet. In both
of those cases we directly poll the virtchnl queue for responses.

To make things a little less confusing, remove the usage of "asynchronous"
terminology across all callsites, and instead make it explicit that what
we're actually interested in is the number of responses we are waiting for,
and whether the thread is meant to directly poll the message queue or wait
for interrupt thread to update command status, not whether the requests
are "asynchronous". We also make it an implementation detail, not part of
the API for executing VF commands.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h       |  53 --------
 drivers/net/intel/iavf/iavf_vchnl.c | 187 ++++++++++++++++++----------
 2 files changed, 121 insertions(+), 119 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index cf98d12247..440376c4ca 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -432,59 +432,6 @@ struct iavf_cmd_info {
 	uint32_t out_size;      /* buffer size for response */
 };
 
-/* notify current command done. Only call in case execute
- * _atomic_set_cmd successfully.
- */
-static inline void
-_notify_cmd(struct iavf_info *vf, int msg_ret)
-{
-	vf->cmd_retval = msg_ret;
-	rte_wmb();
-	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
-}
-
-/* clear current command. Only call in case execute
- * _atomic_set_cmd successfully.
- */
-static inline void
-_clear_cmd(struct iavf_info *vf)
-{
-	rte_wmb();
-	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
-	vf->cmd_retval = VIRTCHNL_STATUS_SUCCESS;
-}
-
-/* Check there is pending cmd in execution. If none, set new command. */
-static inline int
-_atomic_set_cmd(struct iavf_info *vf, enum virtchnl_ops ops)
-{
-	enum virtchnl_ops op_unk = VIRTCHNL_OP_UNKNOWN;
-	int ret = rte_atomic_compare_exchange_strong_explicit(&vf->pend_cmd, &op_unk, ops,
-			rte_memory_order_acquire, rte_memory_order_acquire);
-
-	if (!ret)
-		PMD_DRV_LOG(ERR, "There is incomplete cmd %d", vf->pend_cmd);
-
-	rte_atomic_store_explicit(&vf->pend_cmd_count, 1, rte_memory_order_relaxed);
-
-	return !ret;
-}
-
-/* Check there is pending cmd in execution. If none, set new command. */
-static inline int
-_atomic_set_async_response_cmd(struct iavf_info *vf, enum virtchnl_ops ops)
-{
-	enum virtchnl_ops op_unk = VIRTCHNL_OP_UNKNOWN;
-	int ret = rte_atomic_compare_exchange_strong_explicit(&vf->pend_cmd, &op_unk, ops,
-			rte_memory_order_acquire, rte_memory_order_acquire);
-
-	if (!ret)
-		PMD_DRV_LOG(ERR, "There is incomplete cmd %d", vf->pend_cmd);
-
-	rte_atomic_store_explicit(&vf->pend_cmd_count, 2, rte_memory_order_relaxed);
-
-	return !ret;
-}
 int iavf_check_api_version(struct iavf_adapter *adapter);
 int iavf_get_vf_resource(struct iavf_adapter *adapter);
 void iavf_dev_event_post(struct rte_eth_dev *dev,
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index d97bdf0dc1..d240745f5c 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -309,42 +309,97 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 }
 
 static int
-iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
-	int async)
+iavf_set_pending_cmd(struct iavf_info *vf, enum virtchnl_ops ops,
+		    uint32_t resp_count)
+{
+	enum virtchnl_ops op_unk = VIRTCHNL_OP_UNKNOWN;
+	int ret = rte_atomic_compare_exchange_strong_explicit(&vf->pend_cmd,
+			&op_unk, ops, rte_memory_order_acquire,
+			rte_memory_order_acquire);
+
+	if (ret == 0) {
+		PMD_DRV_LOG(ERR, "There is incomplete cmd %d", vf->pend_cmd);
+		return -1;
+	}
+
+	rte_atomic_store_explicit(&vf->pend_cmd_count, resp_count,
+			rte_memory_order_relaxed);
+
+	return 0;
+}
+
+static inline void
+iavf_clear_pending_cmd(struct iavf_info *vf)
+{
+	rte_wmb();
+	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
+	vf->cmd_retval = VIRTCHNL_STATUS_SUCCESS;
+}
+
+static inline void
+iavf_notify_pending_cmd(struct iavf_info *vf, int msg_ret)
+{
+	vf->cmd_retval = msg_ret;
+	rte_wmb();
+	vf->pend_cmd = VIRTCHNL_OP_UNKNOWN;
+}
+
+static int
+iavf_get_cmd_resp_count(enum virtchnl_ops op)
+{
+	switch (op) {
+	case VIRTCHNL_OP_RESET_VF:
+	case VIRTCHNL_OP_REQUEST_QUEUES:
+		/* These commands trigger reset and are not waited for */
+		return 0;
+	case VIRTCHNL_OP_INLINE_IPSEC_CRYPTO:
+		/* IPsec crypto commands generate two responses */
+		return 2;
+	default:
+		/* All other commands generate one response */
+		return 1;
+	}
+}
+
+static int
+iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args)
 {
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	enum iavf_aq_result result;
 	enum iavf_status ret;
+	uint32_t resp_count;
 	int err = 0;
 	int i = 0;
 
 	if (vf->vf_reset)
 		return -EIO;
 
+	resp_count = iavf_get_cmd_resp_count(args->ops);
 
-	if (async) {
-		if (_atomic_set_async_response_cmd(vf, args->ops))
-			return -1;
-	} else {
-		if (_atomic_set_cmd(vf, args->ops))
-			return -1;
-	}
+	/*
+	 * For some commands, we are not waiting for responses because they
+	 * produce a reset event. However, we still need to set pending command
+	 * to avoid sending commands while another one is already in progress.
+	 */
+	if (iavf_set_pending_cmd(vf, args->ops, RTE_MAX(1U, resp_count)))
+		return -1;
 
 	ret = iavf_aq_send_msg_to_pf(hw, args->ops, IAVF_SUCCESS,
 				    args->in_args, args->in_args_size, NULL);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "fail to send cmd %d", args->ops);
-		_clear_cmd(vf);
+		iavf_clear_pending_cmd(vf);
 		return err;
 	}
 
+	if (resp_count == 0) {
+		/* reset pending commands, counter will be overwritten on reset */
+		iavf_clear_pending_cmd(vf);
+		return 0;
+	}
+
 	switch (args->ops) {
-	case VIRTCHNL_OP_RESET_VF:
-	case VIRTCHNL_OP_REQUEST_QUEUES:
-		/*no need to wait for response */
-		_clear_cmd(vf);
-		break;
 	case VIRTCHNL_OP_VERSION:
 	case VIRTCHNL_OP_GET_VF_RESOURCES:
 	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
@@ -363,7 +418,7 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
 			PMD_DRV_LOG(ERR, "No response or return failure (%d)"
 				    " for cmd %d", vf->cmd_retval, args->ops);
 		}
-		_clear_cmd(vf);
+		iavf_clear_pending_cmd(vf);
 		break;
 	default:
 		if (rte_thread_is_intr()) {
@@ -383,7 +438,7 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
 				PMD_DRV_LOG(ERR, "No response or return failure (%d)"
 						" for cmd %d", vf->cmd_retval, args->ops);
 			}
-			_clear_cmd(vf);
+			iavf_clear_pending_cmd(vf);
 		} else {
 			/* For other virtchnl ops in running time,
 			 * wait for the cmd done flag.
@@ -397,7 +452,7 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
 
 			if (i >= MAX_TRY_TIMES) {
 				PMD_DRV_LOG(ERR, "No response for cmd %d", args->ops);
-				_clear_cmd(vf);
+				iavf_clear_pending_cmd(vf);
 				err = -EIO;
 			} else if (vf->cmd_retval ==
 				VIRTCHNL_STATUS_ERR_NOT_SUPPORTED) {
@@ -417,7 +472,7 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
 
 static int
 iavf_execute_vf_cmd_safe(struct iavf_adapter *adapter,
-	struct iavf_cmd_info *args, int async)
+	struct iavf_cmd_info *args)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	int ret;
@@ -429,7 +484,7 @@ iavf_execute_vf_cmd_safe(struct iavf_adapter *adapter,
 	} else {
 		rte_spinlock_lock(&vf->aq_lock);
 	}
-	ret = iavf_execute_vf_cmd(adapter, args, async);
+	ret = iavf_execute_vf_cmd(adapter, args);
 	rte_spinlock_unlock(&vf->aq_lock);
 
 	return ret;
@@ -577,7 +632,7 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 					rte_atomic_fetch_sub_explicit(&vf->pend_cmd_count,
 							1, rte_memory_order_relaxed) - 1;
 					if (cmd_count == 0)
-						_notify_cmd(vf, msg_ret);
+						iavf_notify_pending_cmd(vf, msg_ret);
 				} else {
 					PMD_DRV_LOG(ERR,
 					"command mismatch, expect %u, get %u",
@@ -609,7 +664,7 @@ iavf_enable_vlan_strip(struct iavf_adapter *adapter)
 	args.in_args_size = 0;
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
 			    " OP_ENABLE_VLAN_STRIPPING");
@@ -630,7 +685,7 @@ iavf_disable_vlan_strip(struct iavf_adapter *adapter)
 	args.in_args_size = 0;
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
 			    " OP_DISABLE_VLAN_STRIPPING");
@@ -659,7 +714,7 @@ iavf_check_api_version(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_INIT_LOG(ERR, "Fail to execute command of OP_VERSION");
 		return err;
@@ -721,7 +776,7 @@ iavf_get_vf_resource(struct iavf_adapter *adapter)
 	args.in_args = (uint8_t *)&caps;
 	args.in_args_size = sizeof(caps);
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 
 	if (err) {
 		PMD_DRV_LOG(ERR,
@@ -766,7 +821,7 @@ iavf_get_supported_rxdid(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_GET_SUPPORTED_RXDIDS");
@@ -810,7 +865,7 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	args.in_args_size = sizeof(vlan_strip);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    enable ? "VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2" :
@@ -850,7 +905,7 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 	args.in_args_size = sizeof(vlan_insert);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    enable ? "VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2" :
@@ -893,7 +948,7 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	args.in_args_size = sizeof(vlan_filter);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_VLAN_V2" :  "OP_DEL_VLAN_V2");
@@ -914,7 +969,7 @@ iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS");
@@ -945,7 +1000,7 @@ iavf_enable_queues(struct iavf_adapter *adapter)
 	args.in_args_size = sizeof(queue_select);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_ENABLE_QUEUES");
@@ -973,7 +1028,7 @@ iavf_disable_queues(struct iavf_adapter *adapter)
 	args.in_args_size = sizeof(queue_select);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_DISABLE_QUEUES");
@@ -1009,7 +1064,7 @@ iavf_switch_queue(struct iavf_adapter *adapter, uint16_t qid,
 	args.in_args_size = sizeof(queue_select);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
 			    on ? "OP_ENABLE_QUEUES" : "OP_DISABLE_QUEUES");
@@ -1047,7 +1102,7 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_ENABLE_QUEUES_V2");
@@ -1086,7 +1141,7 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_DISABLE_QUEUES_V2");
@@ -1128,7 +1183,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
 			    on ? "OP_ENABLE_QUEUES_V2" : "OP_DISABLE_QUEUES_V2");
@@ -1159,7 +1214,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_CONFIG_RSS_LUT");
@@ -1191,7 +1246,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_CONFIG_RSS_KEY");
@@ -1287,7 +1342,7 @@ iavf_configure_queue_chunk(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command VIRTCHNL_OP_CONFIG_VSI_QUEUES");
 	return err;
@@ -1370,7 +1425,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	args.in_args_size = buf_len;
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_CONFIG_IRQ_MAP");
 
@@ -1416,7 +1471,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	return iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	return iavf_execute_vf_cmd_safe(adapter, &args);
 }
 
 int
@@ -1475,7 +1530,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	args.in_args_size = buf_len;
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 				add ? "OP_ADD_ETHER_ADDRESS" : "OP_DEL_ETHER_ADDRESS");
@@ -1501,7 +1556,7 @@ iavf_query_stats(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to execute command OP_GET_STATS");
 		return err;
@@ -1538,7 +1593,7 @@ iavf_config_promisc(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 
 	if (err) {
 		PMD_DRV_LOG(ERR,
@@ -1581,7 +1636,7 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 	args.in_args_size = sizeof(cmd_buffer);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_ETH_ADDR" :  "OP_DEL_ETH_ADDR");
@@ -1608,7 +1663,7 @@ iavf_add_del_vlan(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	args.in_args_size = sizeof(cmd_buffer);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_VLAN" :  "OP_DEL_VLAN");
@@ -1635,7 +1690,7 @@ iavf_fdir_add(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to execute command OP_ADD_FDIR_FILTER");
 		return err;
@@ -1695,7 +1750,7 @@ iavf_fdir_del(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to execute command OP_DEL_FDIR_FILTER");
 		return err;
@@ -1742,7 +1797,7 @@ iavf_fdir_check(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to check flow director rule");
 		return err;
@@ -1785,7 +1840,7 @@ iavf_flow_sub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to execute command of "
 				 "OP_FLOW_SUBSCRIBE");
@@ -1836,7 +1891,7 @@ iavf_flow_unsub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to execute command of "
 				 "OP_FLOW_UNSUBSCRIBE");
@@ -1879,7 +1934,7 @@ iavf_flow_sub_check(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to check flow subscription rule");
 		return err;
@@ -1919,7 +1974,7 @@ iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of %s",
@@ -1943,7 +1998,7 @@ iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_GET_RSS_HENA_CAPS");
@@ -1970,7 +2025,7 @@ iavf_set_hena(struct iavf_adapter *adapter, uint64_t hena)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_SET_RSS_HENA");
@@ -1991,7 +2046,7 @@ iavf_get_qos_cap(struct iavf_adapter *adapter)
 	args.in_args_size = 0;
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 
 	if (err) {
 		PMD_DRV_LOG(ERR,
@@ -2024,7 +2079,7 @@ int iavf_set_q_tc_map(struct rte_eth_dev *dev,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
 			    " VIRTCHNL_OP_CONFIG_TC_MAP");
@@ -2047,7 +2102,7 @@ int iavf_set_q_bw(struct rte_eth_dev *dev,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
 			    " VIRTCHNL_OP_CONFIG_QUEUE_BW");
@@ -2092,7 +2147,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 		i * sizeof(struct virtchnl_ether_addr);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -2134,10 +2189,10 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
-		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+		err = iavf_execute_vf_cmd_safe(adapter, &args);
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
-		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+		err = iavf_execute_vf_cmd_safe(adapter, &args);
 		rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 				  iavf_dev_alarm_handler, dev);
 	}
@@ -2183,7 +2238,7 @@ iavf_get_max_rss_queue_region(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to execute command of VIRTCHNL_OP_GET_MAX_RSS_QREGION");
 		return err;
@@ -2214,7 +2269,7 @@ iavf_ipsec_crypto_request(struct iavf_adapter *adapter,
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 1);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 				"OP_INLINE_IPSEC_CRYPTO");
@@ -2248,7 +2303,7 @@ iavf_set_vf_quanta_size(struct iavf_adapter *adapter, u16 start_queue_id, u16 nu
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to execute command VIRTCHNL_OP_CONFIG_QUANTA");
 		return err;
@@ -2274,7 +2329,7 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_1588_PTP_GET_CAPS");
@@ -2302,7 +2357,7 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	rte_spinlock_lock(&vf->phc_time_aq_lock);
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of VIRTCHNL_OP_1588_PTP_GET_TIME");
-- 
2.47.3

