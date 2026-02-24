Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2914F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 541D84064A;
	Tue, 24 Feb 2026 16:15:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1514066A
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946097; x=1803482097;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fAtQSHfJaDxmBIR5cr/CCn9Bfkq/DykDdwzl0qyYgJk=;
 b=R2T+ydaU7IRF4c765W7zfohLQROgGPD59Ud0nBw5KmZ6ybuzlFYwX5Mo
 81Xi++Ya/EPUHXFuwBF8RtkKNlN16WJweC4eL0pb60MBb+3eKBub14j4c
 PmwfMVivGCPZj9DwXkppgjCnbRADldzirvu6vzS4FfbjLWHDQCk6rUQ4b
 LJSxoOLfYic9OMKETmVuct6XZVC9c7Xppox4a8y55U1ZS6PcG1fJHotMJ
 Z8x+O2+1dcmKB8JuffYY4Ree2E6LpWWdXeW0iMijhp5UGDenhks90tiX/
 2bjoZsvJliOaO1u9e0HFAlX9AIXo5kujQt4pz5JMFOdEKyib14TUdoinM w==;
X-CSE-ConnectionGUID: zHcYtv6MTGqfUGSaVPhgmg==
X-CSE-MsgGUID: C4sIbE+gTcC88vb9vvLkhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056267"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056267"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:57 -0800
X-CSE-ConnectionGUID: Jd4f6KsqRrChUxsxZeNjew==
X-CSE-MsgGUID: wHPOuGvnRXmdUbO2WVOBVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526203"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v9 18/26] net/iavf: avoid rte malloc in VF mailbox for IPsec
Date: Tue, 24 Feb 2026 15:14:23 +0000
Message-ID: <47891779856cb56646e7aaf8c0cc61f863a8d0d3.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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
so replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 60 ++++++++++------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 82323b9aa9..fe540e76cb 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -467,7 +467,7 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 	request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_cfg);
 
-	request = rte_malloc("iavf-sad-add-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -475,7 +475,7 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_cfg_resp);
-	response = rte_malloc("iavf-sad-add-response", response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -553,8 +553,8 @@ iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
 	else
 		rc = response->ipsec_data.sa_cfg_resp->sa_handle;
 update_cleanup:
-	rte_free(response);
-	rte_free(request);
+	free(response);
+	free(request);
 
 	return rc;
 }
@@ -728,8 +728,7 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sp_cfg);
-	request = rte_malloc("iavf-inbound-security-policy-add-request",
-				request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -770,8 +769,7 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sp_cfg_resp);
-	response = rte_malloc("iavf-inbound-security-policy-add-response",
-				response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -792,8 +790,8 @@ iavf_ipsec_crypto_inbound_security_policy_add(struct iavf_adapter *adapter,
 		rc = response->ipsec_data.sp_cfg_resp->rule_id;
 
 update_cleanup:
-	rte_free(request);
-	rte_free(response);
+	free(request);
+	free(response);
 
 	return rc;
 }
@@ -808,7 +806,7 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_update);
-	request = rte_malloc("iavf-sa-update-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -816,7 +814,7 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_resp);
-	response = rte_malloc("iavf-sa-update-response", response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -846,8 +844,8 @@ iavf_ipsec_crypto_sa_update_esn(struct iavf_adapter *adapter,
 		rc = response->ipsec_data.ipsec_resp->resp;
 
 update_cleanup:
-	rte_free(request);
-	rte_free(response);
+	free(request);
+	free(response);
 
 	return rc;
 }
@@ -905,7 +903,7 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sp_destroy);
-	request = rte_malloc("iavf-sp-del-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -913,7 +911,7 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_resp);
-	response = rte_malloc("iavf-sp-del-response", response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -944,8 +942,8 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 		return response->ipsec_data.ipsec_status->status;
 
 update_cleanup:
-	rte_free(request);
-	rte_free(response);
+	free(request);
+	free(response);
 
 	return rc;
 }
@@ -962,7 +960,7 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	request_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_sa_destroy);
 
-	request = rte_malloc("iavf-sa-del-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -971,7 +969,7 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_resp);
 
-	response = rte_malloc("iavf-sa-del-response", response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1013,8 +1011,8 @@ iavf_ipsec_crypto_sa_del(struct iavf_adapter *adapter,
 		rc = -EFAULT;
 
 update_cleanup:
-	rte_free(response);
-	rte_free(request);
+	free(response);
+	free(request);
 
 	return rc;
 }
@@ -1168,7 +1166,7 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg);
 
-	request = rte_malloc("iavf-device-capability-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1176,8 +1174,7 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_cap);
-	response = rte_malloc("iavf-device-capability-response",
-			response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1203,8 +1200,8 @@ iavf_ipsec_crypto_device_capabilities_get(struct iavf_adapter *adapter,
 	memcpy(capability, response->ipsec_data.ipsec_cap, sizeof(*capability));
 
 update_cleanup:
-	rte_free(response);
-	rte_free(request);
+	free(response);
+	free(request);
 
 	return rc;
 }
@@ -1593,7 +1590,7 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 
 	request_len = sizeof(struct inline_ipsec_msg);
 
-	request = rte_malloc("iavf-device-status-request", request_len, 0);
+	request = calloc(1, request_len);
 	if (request == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1601,8 +1598,7 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 
 	response_len = sizeof(struct inline_ipsec_msg) +
 			sizeof(struct virtchnl_ipsec_status);
-	response = rte_malloc("iavf-device-status-response",
-			response_len, 0);
+	response = calloc(1, response_len);
 	if (response == NULL) {
 		rc = -ENOMEM;
 		goto update_cleanup;
@@ -1628,8 +1624,8 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
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

