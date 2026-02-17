Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC468E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5FCC40DD5;
	Tue, 17 Feb 2026 13:15:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3037F4064C
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330503; x=1802866503;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Lu17kTznVvSla47hyYsZtSqVK8XlyGSc+GQ5MRExn6A=;
 b=cRKBwmf8RqfMe7Nx45u6G+aDT3w8Tg++Uh7ZagOa5DzgFMHlIcqGfjOB
 fkBrcrRMptGLfVhK8Hd5K/bC5iheDRCAQnvz39p8CjyrGPOSXn++EMbIe
 zzrUNzvI7H+Flv9+WXq/Uld6Lc3OpkWAwHRuNNMNF7XNucEoDvkI4OqQ6
 hFLXKNYhGtFtf4dkm1VbETT+Ln75QAOsyRm6zMPg8DDWi8nL+2lqzjusT
 c+B/AGgq4CGRY1wBsN3fuCR44pQBQObgyFOWgFmaqEK9apqTyabDO5Ooa
 TYkWXXHxq71rSH1fMtqsqhr+VsDkf35PSH41YzgiaCE2k20zlfFkDsaj3 g==;
X-CSE-ConnectionGUID: 1hMs1JDXQeijAEW6ljPVCQ==
X-CSE-MsgGUID: +sll3tA5Si+V/C9oX99fnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996054"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996054"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:03 -0800
X-CSE-ConnectionGUID: Id1ue9MiRVGXfMgembiOqg==
X-CSE-MsgGUID: 3MgiTnQQQde5tBwJ4DGOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396838"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 21/27] net/iavf: avoid rte malloc in IPsec operations
Date: Tue, 17 Feb 2026 12:14:10 +0000
Message-ID: <a16904932edfac53c0dc1acf8f4edc7e1194ed42.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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
index cd85d91850..3274ce503c 100644
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

