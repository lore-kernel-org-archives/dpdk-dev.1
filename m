Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1999EA3F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD7940E41;
	Tue, 10 Feb 2026 17:14:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 470F740E1C
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740069; x=1802276069;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ISTDYjojApHl6KKlGcy2ymF/pPmvfbpJHfaAsP2+QVU=;
 b=TwLB+BxYPKF8vpLMY80oKueAy5oH+8feneRCUYdK/unRBff8IlE/Oxo9
 m+PcqpNUFf/1trd45IjL2q04NCPVftmLz4v55/n3n6gv3id07CTQI4Xbh
 k8KGsfWTthl4FNpfd5TKnUnQzOM7gvosCTdQGMQmiv+hxDPhjhOHXs/av
 s5Pk/rShmdVpKr3sWfa2L5IWgyFfR7cmSvkzoHNm9ScpAdewLqAuMaPlV
 RdhXviB+OLmEtGjwmm6p1XzsdkRdVQI/kEg40DbpBRWQUX2WjjKmiiZyx
 v4+VDoXtw5wHluSjFPubki+9pLBa2N3aANQWddl7ihwZrQ0Twa4sVQoqH g==;
X-CSE-ConnectionGUID: 1/A/wx16Ste7dUQyMSH1Gg==
X-CSE-MsgGUID: ZquUDwkoQ5iSwvEe31VIiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286260"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:28 -0800
X-CSE-ConnectionGUID: 27GIam3mSvO3HFSpwGkyDw==
X-CSE-MsgGUID: WCToxk4xRsecXRviv2vbRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127820"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 21/26] net/iavf: avoid rte malloc in IPsec operations
Date: Tue, 10 Feb 2026 16:13:50 +0000
Message-ID: <23f14d050a45e1bee5354b5696fff78f8a3f3d69.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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
immediate rte_free. This is not needed as these structures are only
used temporarily, so replace it with stack-allocated structures for
small fixed-size messages and regular malloc/free for variable-sized
buffers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 58 ++++++++--------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index cb437d3212..1a3004b0fc 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdalign.h>
+#include <stdlib.h>
 
 #include <rte_cryptodev.h>
 #include <rte_ethdev.h>
@@ -899,29 +900,18 @@ static uint32_t
 iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	struct iavf_security_session *sess)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_sa_destroy sa_destroy;
+	} req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_resp resp;
+	} resp;
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
@@ -939,10 +929,10 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 
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
@@ -957,10 +947,6 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 			response->ipsec_data.ipsec_status->status)
 		rc = -EFAULT;
 
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
-
 	return rc;
 }
 
@@ -1113,7 +1099,7 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg);
 
-	request = rte_malloc("iavf-device-capability-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1121,8 +1107,7 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_cap);
-	response = rte_malloc("iavf-device-capability-response",
-			response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1148,8 +1133,8 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 	memcpy(capability, response->ipsec_data.ipsec_cap, sizeof(*capability));
 
 update_cleanup:
-	rte_free(response);
-	rte_free(request);
+	free(response);
+	free(request);
 
 	return rc;
 }
@@ -1538,7 +1523,7 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg);
 
-	request = rte_malloc("iavf-device-status-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1546,8 +1531,7 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_cap);
-	response = rte_malloc("iavf-device-status-response",
-			response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1573,8 +1557,8 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 	memcpy(status, response->ipsec_data.ipsec_status, sizeof(*status));
 
 update_cleanup:
-	rte_free(response);
-	rte_free(request);
+	free(response);
+	free(request);
 
 	return rc;
 }
-- 
2.47.3

