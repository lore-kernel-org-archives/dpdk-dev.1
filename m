Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686DF01826
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:59:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEAA540E32;
	Fri,  6 Mar 2026 11:58:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8298840B94
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794714; x=1804330714;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6NabVWmPzcUePfmEtZM5eUlJz9KZvIVWtJIpFiKgKjk=;
 b=VHEFs+k+uIu8h1wOf5/L7/g5VWYotFV0hfLDzZ7lSjuWJ36tWHMqv7q7
 B0kco6qRi5LcH7ifiu+WYdXNy7RKeud5D/BPBegzV1hWKyRJBgolFkA84
 PfFdfcb9iho7ImLcLXhyQVk3u/GVD2lgbXm4xFsd0NlB33RILsHg/CXQB
 Hi8XwYQHDJqN38NjXsp3rzaD7ORRuH+ukosI/9uWYLKpxDIHdcEsiqhWx
 JZBuoU/vU9y+WRLNhO1P7VPhXrzb+Vj2UHXciJUjcHudb2zEq7UY1F2kW
 jI7PPSOEoZ5j1IEhV2GyLhfdWRLg9fUbvng4SeB2yqgdH+OBLy9bDSHqH Q==;
X-CSE-ConnectionGUID: 2qe/vZ3lRAKrQqpoV1c/uA==
X-CSE-MsgGUID: kSQFRROMTimPnj4B7Bjc+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984553"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984553"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:33 -0800
X-CSE-ConnectionGUID: SiJRLVADQiO6MBo9G7dd4g==
X-CSE-MsgGUID: 9dJ7Pv0WTrmM5KVe4k14dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678401"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 5/8] net/iavf: refactor sending virtchnl messages
Date: Fri,  6 Mar 2026 10:58:21 +0000
Message-ID: <bade49dcf585835d368baaf2ee85d9a7ae1b19da.1772794442.git.anatoly.burakov@intel.com>
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

Currently, there is a certain amount of duplication and unnecessary
branching in the virtchnl message handling function which makes it
difficult to read and reason about.

Refactor the function to achieve the following:

- clean and explicit distinction between synchronous and asynchronous ops
- common looping and error handling logic
- fewer and clearer special cases

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 151 +++++++++++++---------------
 1 file changed, 70 insertions(+), 81 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index d240745f5c..3f6ce0dd89 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -361,16 +361,66 @@ iavf_get_cmd_resp_count(enum virtchnl_ops op)
 	}
 }
 
+static int
+iavf_op_needs_poll(struct iavf_info *vf)
+{
+	/* Poll if interrupts disabled or we are in interrupt thread */
+	return !vf->aq_intr_enabled || rte_thread_is_intr();
+}
+
+static int
+iavf_wait_for_msg(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
+		bool poll)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	int err = 0;
+	int i = 0;
+
+	if (args->out_buffer == NULL) {
+		PMD_DRV_LOG(ERR, "Invalid buffer for cmd %d response", args->ops);
+		return -EINVAL;
+	}
+
+	/* Wait for command completion */
+	do {
+		if (poll) {
+			enum iavf_aq_result result;
+			result = iavf_read_msg_from_pf(adapter, args->out_size,
+					args->out_buffer);
+			if (result == IAVF_MSG_CMD)
+				break;
+		} else {
+			/* check if interrupt thread has erased pending cmd */
+			if (vf->pend_cmd == VIRTCHNL_OP_UNKNOWN)
+				break;
+		}
+		iavf_msec_delay(ASQ_DELAY_MS);
+	} while (i++ < MAX_TRY_TIMES);
+
+	if (i >= MAX_TRY_TIMES) {
+		PMD_DRV_LOG(ERR, "No response for cmd %d", args->ops);
+		err = -EIO;
+	} else if (vf->cmd_retval == VIRTCHNL_STATUS_ERR_NOT_SUPPORTED) {
+		PMD_DRV_LOG(ERR, "Cmd %d not supported", args->ops);
+		err = -ENOTSUP;
+	} else if (vf->cmd_retval != VIRTCHNL_STATUS_SUCCESS) {
+		PMD_DRV_LOG(ERR, "Return failure %d for cmd %d",
+				vf->cmd_retval, args->ops);
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
 static int
 iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args)
 {
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	enum iavf_aq_result result;
-	enum iavf_status ret;
+	enum iavf_status status;
 	uint32_t resp_count;
-	int err = 0;
-	int i = 0;
+	bool poll = iavf_op_needs_poll(vf);
+	int err;
 
 	if (vf->vf_reset)
 		return -EIO;
@@ -385,89 +435,28 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args)
 	if (iavf_set_pending_cmd(vf, args->ops, RTE_MAX(1U, resp_count)))
 		return -1;
 
-	ret = iavf_aq_send_msg_to_pf(hw, args->ops, IAVF_SUCCESS,
-				    args->in_args, args->in_args_size, NULL);
-	if (ret) {
+	status = iavf_aq_send_msg_to_pf(hw, args->ops, IAVF_SUCCESS,
+			args->in_args, args->in_args_size, NULL);
+	if (status != IAVF_SUCCESS) {
 		PMD_DRV_LOG(ERR, "fail to send cmd %d", args->ops);
-		iavf_clear_pending_cmd(vf);
-		return err;
+		err = (int)status;
+		goto clear_cmd;
+	} else if (resp_count == 0) {
+		/* we're not waiting on responses */
+		err = 0;
+		goto clear_cmd;
 	}
 
-	if (resp_count == 0) {
-		/* reset pending commands, counter will be overwritten on reset */
-		iavf_clear_pending_cmd(vf);
-		return 0;
-	}
-
-	switch (args->ops) {
-	case VIRTCHNL_OP_VERSION:
-	case VIRTCHNL_OP_GET_VF_RESOURCES:
-	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
-	case VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS:
-		/* for init virtchnl ops, need to poll the response */
-		do {
-			result = iavf_read_msg_from_pf(adapter, args->out_size,
-						   args->out_buffer);
-			if (result == IAVF_MSG_CMD)
-				break;
-			iavf_msec_delay(ASQ_DELAY_MS);
-		} while (i++ < MAX_TRY_TIMES);
-		if (i >= MAX_TRY_TIMES ||
-		    vf->cmd_retval != VIRTCHNL_STATUS_SUCCESS) {
-			err = -1;
-			PMD_DRV_LOG(ERR, "No response or return failure (%d)"
-				    " for cmd %d", vf->cmd_retval, args->ops);
-		}
-		iavf_clear_pending_cmd(vf);
-		break;
-	default:
-		if (rte_thread_is_intr()) {
-			/* For virtchnl ops were executed in eal_intr_thread,
-			 * need to poll the response.
-			 */
-			do {
-				result = iavf_read_msg_from_pf(adapter, args->out_size,
-							args->out_buffer);
-				if (result == IAVF_MSG_CMD)
-					break;
-				iavf_msec_delay(ASQ_DELAY_MS);
-			} while (i++ < MAX_TRY_TIMES);
-			if (i >= MAX_TRY_TIMES ||
-				vf->cmd_retval != VIRTCHNL_STATUS_SUCCESS) {
-				err = -1;
-				PMD_DRV_LOG(ERR, "No response or return failure (%d)"
-						" for cmd %d", vf->cmd_retval, args->ops);
-			}
-			iavf_clear_pending_cmd(vf);
-		} else {
-			/* For other virtchnl ops in running time,
-			 * wait for the cmd done flag.
-			 */
-			do {
-				if (vf->pend_cmd == VIRTCHNL_OP_UNKNOWN)
-					break;
-				iavf_msec_delay(ASQ_DELAY_MS);
-				/* If don't read msg or read sys event, continue */
-			} while (i++ < MAX_TRY_TIMES);
+	err = iavf_wait_for_msg(adapter, args, poll);
 
-			if (i >= MAX_TRY_TIMES) {
-				PMD_DRV_LOG(ERR, "No response for cmd %d", args->ops);
-				iavf_clear_pending_cmd(vf);
-				err = -EIO;
-			} else if (vf->cmd_retval ==
-				VIRTCHNL_STATUS_ERR_NOT_SUPPORTED) {
-				PMD_DRV_LOG(ERR, "Cmd %d not supported", args->ops);
-				err = -ENOTSUP;
-			} else if (vf->cmd_retval != VIRTCHNL_STATUS_SUCCESS) {
-				PMD_DRV_LOG(ERR, "Return failure %d for cmd %d",
-						vf->cmd_retval, args->ops);
-				err = -EINVAL;
-			}
-		}
-		break;
-	}
+	/* in interrupt success case, pending cmd is cleared by intr thread */
+	if (err != 0 || poll)
+		goto clear_cmd;
 
 	return err;
+clear_cmd:
+	iavf_clear_pending_cmd(vf);
+	return err;
 }
 
 static int
-- 
2.47.3

