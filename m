Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF6C531FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6356C40DFD;
	Fri, 20 Feb 2026 11:15:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id BD5A140A79
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582515; x=1803118515;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jsIBbY0DMvkrL5i7wpyB+KpT9mrAfjBjLZwmwk5xnJE=;
 b=P1caUKTt/MAc92/c9OmIx6UUHxKW0R55mNQ6wMrXOWAPQB4fms23LMCL
 P2golYcHRuGpdnBAGHnUyhrjO/gsf/qB8wP9Swx1hJfdUr/bT+sRS3DcD
 4j5Z7YAL8NZiwtlA1WAwJC2cgAO+9e6duua5GQuAe6HB9gGTwCErhlibF
 8gE09SDxcb6FTFhMfhopXakyKviwDWFD8RJBlpd0p1yAL2u2YVaqp6XxB
 wghN8y82GFpV7e0a6yQX/3y0OIO585H15tnUwnGyENcDp5bh9b5VN37TX
 17ki8PQDJWfjmi9Q1xjmDgyHvkztiGJo9uxKXAW8vuAfOFnSV+dWNnr1b Q==;
X-CSE-ConnectionGUID: VYFbimjxSqiY6vaTTDTKsQ==
X-CSE-MsgGUID: Rq6cX8dCQFumneH2LUm7GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283370"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:14 -0800
X-CSE-ConnectionGUID: fk0ZHZv+TnC9mMLP8vxOhg==
X-CSE-MsgGUID: odzdISmoQ+iBEdhyoO6rhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038558"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:14 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 21/27] net/iavf: avoid rte malloc in IPsec operations
Date: Fri, 20 Feb 2026 10:14:28 +0000
Message-ID: <bdbc97e08902d61bf578a47655f99098ae35a42e.1771582363.git.anatoly.burakov@intel.com>
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

Currently, when performing IPsec security association operations and
retrieving device capabilities, we are using rte_malloc followed by
immediate rte_free. This memory does not need to be stored in hugepage
memory and the allocation size can be pretty small, so replace with stack
allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 138 +++++++++------------
 1 file changed, 56 insertions(+), 82 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 29609e4447..650f805f0a 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdalign.h>
+#include <stdlib.h>
 
 #include <rte_cryptodev.h>
 #include <rte_ethdev.h>
@@ -929,28 +930,23 @@ static uint32_t
 iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	struct iavf_security_session *sess)
 {
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
-
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
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * membersm so we have to memset them instead.
+	 */
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_SA_DESTROY;
@@ -969,10 +965,10 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 
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
@@ -987,10 +983,6 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 			response->ipsec_data.ipsec_status->status)
 		rc = -EFAULT;
 
-update_cleanup:
-	rte_free(response);
-	rte_free(request);
-
 	return rc;
 }
 
@@ -1136,27 +1128,23 @@ static int
 iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 		struct virtchnl_ipsec_cap *capability)
 {
+	struct {
+		struct inline_ipsec_msg msg;
+	} req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_cap cap;
+	} resp;
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
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * membersm so we have to memset them instead.
+	 */
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_GET_CAP;
@@ -1164,23 +1152,18 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 
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
 
@@ -1562,26 +1545,22 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 		struct virtchnl_ipsec_status *status)
 {
 	/* Perform pf-vf comms */
-	struct inline_ipsec_msg *request = NULL, *response = NULL;
-	size_t request_len, response_len;
+	struct {
+		struct inline_ipsec_msg msg;
+	} req;
+	struct {
+		struct inline_ipsec_msg msg;
+		struct virtchnl_ipsec_status status;
+	} resp;
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
-			sizeof(struct virtchnl_ipsec_status);
-	response = rte_malloc("iavf-device-status-response",
-			response_len, 0);
-	if (response == NULL) {
-		rc = -ENOMEM;
-		goto update_cleanup;
-	}
+	/*
+	 * MSVC doesn't allow inline initialization of structs with zero-sized
+	 * membersm so we have to memset them instead.
+	 */
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
 
 	/* set msg header params */
 	request->ipsec_opcode = INLINE_IPSEC_OP_GET_STATUS;
@@ -1589,23 +1568,18 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 
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

