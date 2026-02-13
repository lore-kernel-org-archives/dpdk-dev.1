Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA1EDF150
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39C8140B98;
	Fri, 13 Feb 2026 11:27:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 06306406BB
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978432; x=1802514432;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zzyDaBMflUrQofK6rFwAZE8RmOrfeqwOfHWeIalG+5c=;
 b=IOFk1ZAYMeydOvXN8ZbhAdH2xAqYpdR/js1LlgPQjkx3rHcTI6dfReR/
 GTWJ4LFf7s2Tgd8n9wk3eCvKNFWzsFTYlowP8BW15/KR7jf1gG2GamwfF
 N9WAcT3mr7YTyLBubYHEHlQKkBfP7Zr9Gv1fPo/eN/i5MCaWs7Mc2ABbf
 tSzJ6WOCwm1aYzzp6lkBVd4CEbqRxcFzJYoDwoMNJ4gLqF4brv5aiKlHd
 BcAxqYLO/GDenaW/0PTLX3Ar7hrx/BYpAGZNjE22zpuiAo9IOEX8ecb1Q
 YlrEgW0mEZDvDbR+3vDIoTP4JI28ZxaYVJ/rcUTMucUge7dTFv2uOqMUb g==;
X-CSE-ConnectionGUID: XjDhMWBnTO+moEz4YfN0rA==
X-CSE-MsgGUID: FPH3C+JNRy2gx8/LckrbnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603106"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603106"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:11 -0800
X-CSE-ConnectionGUID: vYVEeio5SVaL1Vx/qqzaNw==
X-CSE-MsgGUID: Jln0SDkdR/S37lQB/vac/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028115"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 17/27] net/iavf: avoid rte malloc in VF mailbox for IPsec
Date: Fri, 13 Feb 2026 10:26:28 +0000
Message-ID: <67e3dfc60d3d5709563cd93810dcc6390090c28b.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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
dynamic memory allocation (rte_malloc one at that!) to allocate VF message
structures which are ~40 bytes in size, and then immediately frees them.
This is wasteful and unnecessary, so use stack allocation instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 157 +++++++--------------
 1 file changed, 51 insertions(+), 106 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 66eaea8715..cb437d3212 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -458,36 +458,24 @@ static uint32_t
 iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 	struct rte_security_session_conf *conf)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	struct virtchnl_ipsec_sa_cfg *sa_cfg;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_cfg sa_cfg;
+	} sa_req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_cfg_resp sa_cfg_resp;
+	} sa_resp;
+	struct inline_ipsec_msg *request = &sa_req.msg, *response = &sa_resp.msg;
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
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_CREATE;
 	request->req_id = (uint16_t)0xDEADBEEF;
 
 	/* set SA configuration params */
-	sa_cfg = (struct virtchnl_ipsec_sa_cfg *)(request + 1);
-
 	sa_cfg->spi = conf->ipsec.spi;
 	sa_cfg->virtchnl_protocol_type = VIRTCHNL_PROTO_ESP;
 	sa_cfg->virtchnl_direction =
@@ -541,10 +529,10 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 
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
@@ -552,9 +540,6 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 		rc = -EFAULT;
 	else
 		rc = response->ipsec_data.sa_cfg_resp->sa_handle;
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
 
 	return rc;
 }
@@ -722,19 +707,18 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
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
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SP_CREATE;
 	request->req_id = (uint16_t)0xDEADBEEF;
@@ -768,21 +752,12 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
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
@@ -791,10 +766,6 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 	else
 		rc = response->ipsec_data.sp_cfg_resp->rule_id;
 
-update_cleanup:
-	rte_free(request);
-	rte_free(response);
-
 	return rc;
 }
 
@@ -802,26 +773,17 @@ static uint32_t
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
+	struct inline_ipsec_msg *request = &sp_req.msg, *response = &sp_resp.msg;
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
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_UPDATE;
 	request->req_id = (uint16_t)0xDEADBEEF;
@@ -833,10 +795,10 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 
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
@@ -845,10 +807,6 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 	else
 		rc = response->ipsec_data.ipsec_resp->resp;
 
-update_cleanup:
-	rte_free(request);
-	rte_free(response);
-
 	return rc;
 }
 
@@ -899,26 +857,17 @@ int
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
+	struct inline_ipsec_msg *request = &sp_req.msg, *response = &sp_resp.msg;
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
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SP_DESTROY;
 	request->req_id = (uint16_t)0xDEADBEEF;
@@ -931,21 +880,17 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 
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

