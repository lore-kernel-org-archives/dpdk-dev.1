Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8382606A322
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JyC+YDBm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40BBF402B5;
	Mon, 16 Nov 2026 17:09:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id A8D4E40299
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845382; x=1826381382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gpA5DhQKhJW09KBMThDXvIc0vhK4aAtMNCki2eE+eSo=;
 b=JyC+YDBmfP8Bd+2md1ljLy31xDhBOCOwRnbDwuGcYWu+DDgOzDf6GBCe
 P4P/YEpocZpvNwfAvDGp/xBgLqyMx4jITyjr+1h4g/ujc3qck2aFaVjzV
 zVY7bAuZh3Ygew5V4sgts4Rk0tUwrIlQmK5IEOddneXUIIFIQYsW9jLzj
 /FZxoFs+ASA3QKV1z9zqIusryZM4WhV+WIKBHHwNdIsIA6lvd78DQ1yK2
 dgn3eLpgc5bRF0M6+Nf+KT/A8K6j48QkY3pg1g+vir8bfDbX9rw/VlSua
 4oHm/+ibrcAxMWxO/Ci/qRGJMyl77uc91fCXg1T5720eEmQuv/YaiuT/j g==;
X-CSE-ConnectionGUID: Wu9Uz5CYTUSwzXaoqSPpEQ==
X-CSE-MsgGUID: DLuz6na8R2mMe0Z+Ev7wzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481860"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481860"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:40 -0800
X-CSE-ConnectionGUID: PW7jt8njSoSWHFBdsonU9Q==
X-CSE-MsgGUID: 5sAtBmkJRq2avZpkZIrbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9926981"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:39 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 2/6] net/iavf: use stack storage for virtchnl messages
Date: Mon, 16 Nov 2026 16:09:28 +0000
Message-ID: <20261116160932.1006354-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116160932.1006354-1-bruce.richardson@intel.com>
References: <20261116160932.1006354-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than using malloc and free for the request and response buffers
of IPsec and traffic management virtchnl messages, define them on the
stack using RTE_DEFINE_FLEX. This removes the allocation failure and
cleanup paths, avoiding potential leaks on error.

For the traffic management messages, add checks that the number of TCs
and queue pairs do not exceed the maximum sizes of the buffers.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 270 ++++++---------------
 drivers/net/intel/iavf/iavf_tm.c           |  26 +-
 2 files changed, 79 insertions(+), 217 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index be0a0d0df6..d5a6a48092 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -460,28 +460,14 @@ static uint32_t
 iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 	struct rte_security_session_conf *conf)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	struct virtchnl_ipsec_sa_cfg *sa_cfg;
-	size_t request_len, response_len;
-
-	int rc;
-
-	request_len = sizeof(struct inline_ipsec_msg) +
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, request, ipsec_data.sa_cfg, 1);
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.sa_cfg_resp, 1);
+	const size_t request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_cfg);
-
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_cfg_resp);
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	struct virtchnl_ipsec_sa_cfg *sa_cfg;
+	int rc;
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_CREATE;
@@ -546,19 +532,14 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 			(uint8_t *)request, request_len,
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response id */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id)
-		rc = -EFAULT;
-	else
-		rc = response->ipsec_data.sa_cfg_resp->sa_handle;
-update_cleanup:
-	free(response);
-	free(request);
+		return -EFAULT;
 
-	return rc;
+	return response->ipsec_data.sa_cfg_resp->sa_handle;
 }
 
 static void
@@ -722,17 +703,13 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 	bool is_udp,
 	uint16_t udp_port)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-	int rc = 0;
-
-	request_len = sizeof(struct inline_ipsec_msg) +
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, request, ipsec_data.sp_cfg, 1);
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.sp_cfg_resp, 1);
+	const size_t request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sp_cfg);
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
+			sizeof(struct virtchnl_ipsec_sp_cfg_resp);
+	int rc = 0;
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SP_CREATE;
@@ -767,58 +744,32 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 	request->ipsec_data.sp_cfg->is_udp = is_udp;
 	request->ipsec_data.sp_cfg->udp_port = htons(udp_port);
 
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sp_cfg_resp);
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
 			(uint8_t *)request, request_len,
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id)
-		rc = -EFAULT;
-	else
-		rc = response->ipsec_data.sp_cfg_resp->rule_id;
-
-update_cleanup:
-	free(request);
-	free(response);
+		return -EFAULT;
 
-	return rc;
+	return response->ipsec_data.sp_cfg_resp->rule_id;
 }
 
 static uint32_t
 iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 	struct iavf_security_session *sess)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-	int rc = 0;
-
-	request_len = sizeof(struct inline_ipsec_msg) +
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, request, ipsec_data.sa_update, 1);
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.ipsec_resp, 1);
+	const size_t request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_update);
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_resp);
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	int rc = 0;
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_UPDATE;
@@ -834,20 +785,14 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 			(uint8_t *)request, request_len,
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id)
-		rc = -EFAULT;
-	else
-		rc = response->ipsec_data.ipsec_resp->resp;
-
-update_cleanup:
-	free(request);
-	free(response);
+		return -EFAULT;
 
-	return rc;
+	return response->ipsec_data.ipsec_resp->resp;
 }
 
 static int
@@ -897,25 +842,13 @@ int
 iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 	uint8_t is_v4, uint32_t flow_id)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-	int rc = 0;
-
-	request_len = sizeof(struct inline_ipsec_msg) +
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, request, ipsec_data.sp_destroy, 1);
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.ipsec_resp, 1);
+	const size_t request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sp_destroy);
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_resp);
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	int rc = 0;
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SP_DESTROY;
@@ -932,48 +865,27 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 			(uint8_t *)request, request_len,
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id)
-		rc = -EFAULT;
-	else
-		rc = response->ipsec_data.ipsec_status->status;
-
-update_cleanup:
-	free(request);
-	free(response);
+		return -EFAULT;
 
-	return rc;
+	return response->ipsec_data.ipsec_status->status;
 }
 
 static uint32_t
 iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	struct iavf_security_session *sess)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-
-	int rc = 0;
-
-	request_len = sizeof(struct inline_ipsec_msg) +
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, request, ipsec_data.sa_destroy, 1);
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.ipsec_resp, 1);
+	const size_t request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_destroy);
-
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_resp);
-
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	int rc = 0;
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_DESTROY;
@@ -995,12 +907,12 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 			(uint8_t *)request, request_len,
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id)
-		rc = -EFAULT;
+		return -EFAULT;
 
 	/**
 	 * Delete status will be the same bitmask as sa_destroy request flag if
@@ -1008,13 +920,9 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	 */
 	if (request->ipsec_data.sa_destroy->flag !=
 			response->ipsec_data.ipsec_status->status)
-		rc = -EFAULT;
-
-update_cleanup:
-	free(response);
-	free(request);
+		return -EFAULT;
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -1160,50 +1068,30 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 		struct virtchnl_ipsec_cap *capability)
 {
 	/* Perform pf-vf comms */
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-	int rc;
-
-	request_len = sizeof(struct inline_ipsec_msg);
-
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
+	struct inline_ipsec_msg request = {0};
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.ipsec_cap, 1);
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_cap);
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	int rc;
 
 	/* set msg header params */
-	request->ipsec_opcode = INLINE_IPSEC_OP_GET_CAP;
-	request->req_id = (uint16_t)0xDEADBEEF;
+	request.ipsec_opcode = INLINE_IPSEC_OP_GET_CAP;
+	request.req_id = (uint16_t)0xDEADBEEF;
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
+			(uint8_t *)&request, sizeof(request),
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response id */
-	if (response->ipsec_opcode != request->ipsec_opcode ||
-		response->req_id != request->req_id){
-		rc = -EFAULT;
-		goto update_cleanup;
-	}
-	memcpy(capability, response->ipsec_data.ipsec_cap, sizeof(*capability));
-
-update_cleanup:
-	free(response);
-	free(request);
+	if (response->ipsec_opcode != request.ipsec_opcode ||
+		response->req_id != request.req_id)
+		return -EFAULT;
 
-	return rc;
+	memcpy(capability, response->ipsec_data.ipsec_cap, sizeof(*capability));
+	return 0;
 }
 
 enum rte_crypto_auth_algorithm auth_maptbl[] = {
@@ -1588,50 +1476,30 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 		struct virtchnl_ipsec_status *status)
 {
 	/* Perform pf-vf comms */
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-	int rc;
-
-	request_len = sizeof(struct inline_ipsec_msg);
-
-	request = calloc(1, request_len);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
+	struct inline_ipsec_msg request = {0};
+	RTE_DEFINE_FLEX(struct inline_ipsec_msg, response, ipsec_data.ipsec_status, 1);
+	const size_t response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_status);
-	response = calloc(1, response_len);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	int rc;
 
 	/* set msg header params */
-	request->ipsec_opcode = INLINE_IPSEC_OP_GET_STATUS;
-	request->req_id = (uint16_t)0xDEADBEEF;
+	request.ipsec_opcode = INLINE_IPSEC_OP_GET_STATUS;
+	request.req_id = (uint16_t)0xDEADBEEF;
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
+			(uint8_t *)&request, sizeof(request),
 			(uint8_t *)response, response_len);
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response id */
-	if (response->ipsec_opcode != request->ipsec_opcode ||
-		response->req_id != request->req_id){
-		rc = -EFAULT;
-		goto update_cleanup;
-	}
-	memcpy(status, response->ipsec_data.ipsec_status, sizeof(*status));
-
-update_cleanup:
-	free(response);
-	free(request);
+	if (response->ipsec_opcode != request.ipsec_opcode ||
+		response->req_id != request.req_id)
+		return -EFAULT;
 
-	return rc;
+	memcpy(status, response->ipsec_data.ipsec_status, sizeof(*status));
+	return 0;
 }
 
 
diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 07ba58f6f5..c7b904e9d7 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -833,8 +833,9 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct virtchnl_queue_tc_mapping *q_tc_mapping = NULL;
-	struct virtchnl_queues_bw_cfg *q_bw = NULL;
+	RTE_DEFINE_FLEX(struct virtchnl_queue_tc_mapping, q_tc_mapping, tc,
+			IAVF_MAX_TRAFFIC_CLASS - 1);
+	RTE_DEFINE_FLEX(struct virtchnl_queues_bw_cfg, q_bw, cfg, IAVF_MAX_NUM_QUEUES_LV - 1);
 	struct iavf_tm_node_list *queue_list = &vf->tm_conf.queue_list;
 	struct iavf_tm_node *tm_node;
 	struct iavf_qtc_map *qtc_map = NULL;
@@ -869,21 +870,18 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 	}
 
-	size = sizeof(*q_tc_mapping) + sizeof(q_tc_mapping->tc[0]) *
-		(vf->qos_cap->num_elem - 1);
-	q_tc_mapping = calloc(1, size);
-	if (!q_tc_mapping) {
-		ret_val = IAVF_ERR_NO_MEMORY;
+	if (vf->qos_cap->num_elem > IAVF_MAX_TRAFFIC_CLASS ||
+			vf->num_queue_pairs > IAVF_MAX_NUM_QUEUES_LV) {
+		PMD_DRV_LOG(ERR, "Too many TCs (%u) or queues (%u) for TM configuration",
+			vf->qos_cap->num_elem, vf->num_queue_pairs);
+		ret_val = IAVF_ERR_PARAM;
 		goto fail_clear;
 	}
 
+	size = sizeof(*q_tc_mapping) + sizeof(q_tc_mapping->tc[0]) *
+		(vf->qos_cap->num_elem - 1);
 	size_q = sizeof(*q_bw) + sizeof(q_bw->cfg[0]) *
 		(vf->num_queue_pairs - 1);
-	q_bw = calloc(1, size_q);
-	if (!q_bw) {
-		ret_val = IAVF_ERR_NO_MEMORY;
-		goto fail_clear;
-	}
 
 	q_tc_mapping->vsi_id = vf->vsi.vsi_id;
 	q_tc_mapping->num_tc = vf->qos_cap->num_elem;
@@ -950,8 +948,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	free(old_qtc_map);
 	if (adapter->stopped == 1)
 		vf->tm_conf.committed = true;
-	free(q_bw);
-	free(q_tc_mapping);
 	return ret_val;
 
 fail_clear:
@@ -961,8 +957,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		iavf_tm_conf_init(dev);
 	}
 err:
-	free(q_bw);
-	free(q_tc_mapping);
 	free(qtc_map);
 	return ret_val;
 }
-- 
2.55.0

