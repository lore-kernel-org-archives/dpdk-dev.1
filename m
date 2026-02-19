Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E7E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:25:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3328F40A8A;
	Thu, 19 Feb 2026 17:23:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8636B40685
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518221; x=1803054221;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=q2soMFwotkJRVdtjvswcDjomE6B+mQTCCPvuzLeEekw=;
 b=DMf+503fApodlLgUKKx3xOyATAFB1j043DCWUYkP4uU+lz945dTf0ETG
 lyZ6t+3pfl9wJ96aJsPJfrcoGRTTEuwQIDKljRsXzZnroDJCARYmVUPhN
 FsCctjws1e/SFNvgERRkRk8d5vpsv++Taz0jN6of5Hhcc8K4l36oXDLLZ
 d5qs57DPDVG/rRsH7Xpd3dKHa7oE5N03pX7n+unFyhaW3+v6PmBK7QP4B
 Q3MfgH6oOenpoviSKCId3l4EtR3XE5ICVMGHpg1x9mxMOSZ1WPBH1jw91
 Ao1Q0pYjRrRXBKqet2dlksUlu0tLz52cdeKZG4KwMWLIdvZOoomuZGVmZ Q==;
X-CSE-ConnectionGUID: Oh2frMGfSxKGTE/0SJYa7A==
X-CSE-MsgGUID: K/84GWAySDaY4IPXEhoHuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231462"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231462"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:40 -0800
X-CSE-ConnectionGUID: YyMOFAhZTsmWYh1YTzxTmA==
X-CSE-MsgGUID: WXW8zoJCSkanIGaFKK+pSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699972"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 21/27] net/iavf: avoid rte malloc in IPsec operations
Date: Thu, 19 Feb 2026 16:23:04 +0000
Message-ID: <5cace9bf0fec58b0a4a74deb852f9e24a06a717f.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

Currently, when performing IPsec security association operations and
retrieving device capabilities, we are using rte_malloc followed by
immediate rte_free. This memory does not need to be stored in hugepage
memory and the allocation size can be pretty small, so replace with stack
allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 122 +++++++--------------
 1 file changed, 38 insertions(+), 84 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index aa4cf1d96d..98aa8b115b 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdalign.h>
+#include <stdlib.h>
 
 #include <rte_cryptodev.h>
 #include <rte_ethdev.h>
@@ -902,29 +903,18 @@ static uint32_t
 iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	struct iavf_security_session *sess)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_destroy sa_destroy;
+	} req = {0};
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_resp resp;
+	} resp = {0};
+	struct inline_ipsec_msg *request = &req.msg, *response = &resp.msg;
 
 	int rc = 0;
 
-	request_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_sa_destroy);
-
-	request = rte_malloc("iavf-sa-del-request", request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_resp);
-
-	response = rte_malloc("iavf-sa-del-response", response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_DESTROY;
 	request->req_id = (uint16_t)0xDEADBEEF;
@@ -942,10 +932,10 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(req),
+			(uint8_t *)response, sizeof(resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
@@ -960,10 +950,6 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 			response->ipsec_data.ipsec_status->status)
 		rc = -EFAULT;
 
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
-
 	return rc;
 }
 
@@ -1109,51 +1095,35 @@ static int
 iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 		struct virtchnl_ipsec_cap *capability)
 {
+	struct {
+		struct inline_ipsec_msg msg;
+	} req = {0};
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_cap cap;
+	} resp = {0};
 	/* Perform pf-vf comms */
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct inline_ipsec_msg *request = &req.msg, *response = &resp.msg;
 	int rc;
 
-	request_len = sizeof(struct inline_ipsec_msg);
-
-	request = rte_malloc("iavf-device-capability-request", request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_cap);
-	response = rte_malloc("iavf-device-capability-response",
-			response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_GET_CAP;
 	request->req_id = (uint16_t)0xDEADBEEF;
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(req),
+			(uint8_t *)response, sizeof(resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response id */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
 		response->req_id != request->req_id){
-		rc = -EFAULT;
-		goto update_cleanup;
+		return -EFAULT;
 	}
 	memcpy(capability, response->ipsec_data.ipsec_cap, sizeof(*capability));
 
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
-
 	return rc;
 }
 
@@ -1535,50 +1505,34 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 		struct virtchnl_ipsec_status *status)
 {
 	/* Perform pf-vf comms */
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+	} req = {0};
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_cap cap;
+	} resp = {0};
+	struct inline_ipsec_msg *request = &req.msg, *response = &resp.msg;
 	int rc;
 
-	request_len = sizeof(struct inline_ipsec_msg);
-
-	request = rte_malloc("iavf-device-status-request", request_len, 0);
-	if (request == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
-	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_cap);
-	response = rte_malloc("iavf-device-status-response",
-			response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
-
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_GET_STATUS;
 	request->req_id = (uint16_t)0xDEADBEEF;
 
 	/* send virtual channel request to add SA to hardware database */
 	rc = iavf_ipsec_crypto_request(adapter,
-			(uint8_t *)request, request_len,
-			(uint8_t *)response, response_len);
+			(uint8_t *)request, sizeof(req),
+			(uint8_t *)response, sizeof(resp));
 	if (rc)
-		goto update_cleanup;
+		return rc;
 
 	/* verify response id */
 	if (response->ipsec_opcode != request->ipsec_opcode ||
-		response->req_id != request->req_id){
-		rc = -EFAULT;
-		goto update_cleanup;
+			response->req_id != request->req_id){
+		return -EFAULT;
 	}
 	memcpy(status, response->ipsec_data.ipsec_status, sizeof(*status));
 
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
-
 	return rc;
 }
 
-- 
2.47.3

