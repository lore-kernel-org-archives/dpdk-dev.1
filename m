Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22FDC531FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3632540DCE;
	Fri, 20 Feb 2026 11:15:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 381FE40609
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582511; x=1803118511;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5B2DDICKHDV6MBd/Mx34hq3yxiEV0ZibMsIvmhsRkq0=;
 b=IRyPvyXxZ4qHwb9cJQfoeprRnGtMSY9uogp9BRNmKSNfiPiLD+u51xGT
 uMwMpV3CO+RAVaEvGkth8YWhbEg+Zi7mlMu9LvbBKJ6y13qbTKiHfOSOE
 MT6LvZ0nCXtsjcxvjSjN9dy0NUDZtU5RgnFuJvbQqEm6qYPi7Jig6THbB
 X1SXQDfCHes95COjOS3ngJ/rInMgrl1Xi5Wuuj8iQKloNzr8CkeWWS3jg
 tX9l1ZqehgEgk2gOVpB9sCHlkqL1yVpdSApkFgizi1sLA4cnvS3pAGcvN
 9LsDAjT5555j2Bn4CsjUjScdxpaV5bCt7CxnDUQnMMMTJUq7vyyt2E2e4 Q==;
X-CSE-ConnectionGUID: 61B68BC1SkuQU8tcgCQu1g==
X-CSE-MsgGUID: iAnzkImXQXC9NTQzqsgUsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283365"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283365"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:11 -0800
X-CSE-ConnectionGUID: h19BnKueRJ2UhMSf3o3zcQ==
X-CSE-MsgGUID: rwFgh8wWQ3WvNX/S0VeMRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038542"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 18/27] net/iavf: avoid rte malloc in VF mailbox for IPsec
Date: Fri, 20 Feb 2026 10:14:25 +0000
Message-ID: <b4d37cad7f2dce532104a97129d3a1e250603da1.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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

Currently, when calling down into the VF mailbox, IPsec code will use
rte_malloc to allocate VF message structures. This memory does not need
to be stored in hugepage memory and the allocation size is pretty small,
so replace it with stack allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 181 +++++++++------------
 1 file changed, 78 insertions(+), 103 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 82323b9aa9..29609e4447 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -458,36 +458,31 @@ static uint32_t
 iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 	struct rte_security_session_conf *conf)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	struct virtchnl_ipsec_sa_cfg *sa_cfg;
-	size_t request_len, response_len;
-
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_cfg sa_cfg;
+	} sa_req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_cfg_resp sa_cfg_resp;
+	} sa_resp;
+	struct inline_ipsec_msg *request = &sa_req.msg;
+	struct inline_ipsec_msg *response = &sa_resp.msg;
+	struct virtchnl_ipsec_sa_cfg *sa_cfg = &sa_req.sa_cfg;
 	int rc;
 
-	request_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sa_cfg);
-
-	request = rte_malloc("iavf-sad-add-request", request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sa_cfg_resp);
-	response = rte_malloc("iavf-sad-add-response", response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * members so we have to memset them instead.
+	 */
+	memset(&sa_req, 0, sizeof(sa_req));
+	memset(&sa_resp, 0, sizeof(sa_resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_CREATE;
 	request->req_id = (uint16_t)0xDEADBEEF;
 
 	/* set SA configuration params */
-	sa_cfg = (struct virtchnl_ipsec_sa_cfg *)(request + 1);
-
 	sa_cfg->spi = conf->ipsec.spi;
 	sa_cfg->virtchnl_protocol_type = VIRTCHNL_PROTO_ESP;
 	sa_cfg->virtchnl_direction =
@@ -541,10 +536,10 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(sa_req),
+			(uint8_t *)response, sizeof(sa_resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response id */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
@@ -552,9 +547,6 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 		rc = -EFAULT;
 	else
 		rc = response->ipsec_data.sa_cfg_resp->sa_handle;
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
 
 	return rc;
 }
@@ -722,18 +714,24 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 	bool is_udp,
 	uint16_t udp_port)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sp_cfg sp_cfg;
+	} sp_req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sp_cfg_resp sp_cfg_resp;
+	} sp_resp;
+	struct inline_ipsec_msg *request = &sp_req.msg;
+	struct inline_ipsec_msg *response = &sp_resp.msg;
 	int rc = 0;
 
-	request_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sp_cfg);
-	request = rte_malloc("iavf-inbound-security-policy-add-request",
-				request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * members so we have to memset them instead.
+	 */
+	memset(&sp_req, 0, sizeof(sp_req));
+	memset(&sp_resp, 0, sizeof(sp_resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SP_CREATE;
@@ -768,21 +766,12 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 	request->ipsec_data.sp_cfg->is_udp = is_udp;
 	request->ipsec_data.sp_cfg->udp_port = htons(udp_port);
 
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sp_cfg_resp);
-	response = rte_malloc("iavf-inbound-security-policy-add-response",
-				response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(sp_req),
+			(uint8_t *)response, sizeof(sp_resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
@@ -791,10 +780,6 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 	else
 		rc = response->ipsec_data.sp_cfg_resp->rule_id;
 
-update_cleanup:
-	rte_free(request);
-	rte_free(response);
-
 	return rc;
 }
 
@@ -802,25 +787,24 @@ static uint32_t
 iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 	struct iavf_security_session *sess)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_update sa_update;
+	} sp_req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_resp ipsec_resp;
+	} sp_resp;
+	struct inline_ipsec_msg *request = &sp_req.msg;
+	struct inline_ipsec_msg *response = &sp_resp.msg;
 	int rc = 0;
 
-	request_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sa_update);
-	request = rte_malloc("iavf-sa-update-request", request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_resp);
-	response = rte_malloc("iavf-sa-update-response", response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * members so we have to memset them instead.
+	 */
+	memset(&sp_req, 0, sizeof(sp_req));
+	memset(&sp_resp, 0, sizeof(sp_resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_UPDATE;
@@ -833,10 +817,10 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(sp_req),
+			(uint8_t *)response, sizeof(sp_resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
@@ -845,10 +829,6 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 	else
 		rc = response->ipsec_data.ipsec_resp->resp;
 
-update_cleanup:
-	rte_free(request);
-	rte_free(response);
-
 	return rc;
 }
 
@@ -899,25 +879,24 @@ int
 iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 	uint8_t is_v4, uint32_t flow_id)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sp_destroy sp_destroy;
+	} sp_req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_resp resp;
+	} sp_resp;
+	struct inline_ipsec_msg *request = &sp_req.msg;
+	struct inline_ipsec_msg *response = &sp_resp.msg;
 	int rc = 0;
 
-	request_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sp_destroy);
-	request = rte_malloc("iavf-sp-del-request", request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_resp);
-	response = rte_malloc("iavf-sp-del-response", response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * members so we have to memset them instead.
+	 */
+	memset(&sp_req, 0, sizeof(sp_req));
+	memset(&sp_resp, 0, sizeof(sp_resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SP_DESTROY;
@@ -931,21 +910,17 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(sp_req),
+			(uint8_t *)response, sizeof(sp_resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id)
 		rc = -EFAULT;
 	else
-		return response->ipsec_data.ipsec_status->status;
-
-update_cleanup:
-	rte_free(request);
-	rte_free(response);
+		rc = response->ipsec_data.ipsec_status->status;
 
 	return rc;
 }
-- 
2.47.3

