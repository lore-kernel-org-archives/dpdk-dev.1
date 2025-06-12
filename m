Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F2BC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 10:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0946D40DFB;
	Thu, 12 Jun 2025 12:14:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id E22ED4003C;
 Thu, 12 Jun 2025 12:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749723260; x=1781259260;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lqm3UgSR2S6rg9w80Bvij8ap1JgWxURkPxLedG0mfcY=;
 b=d1G6cciGivRSZfguBj0u2TPJetvcRg3PC4SM3mTb1tE7JWYSfvC2WSg9
 9KT9oSztxHlVr8MgTt4PVr8tC41gYXujCKgiNY/yYLRAzlUKGQP00+o+n
 AnySDGemtquW9QyhlXtzpPMAIsCLPeLbCH3lI/HZ6HfTRueYjOfWPL/0z
 bTe3mikpwenvRqFi8L8Z6fA0OSadQ15riwsL3qHGU0EvaFxZDveE5s0nn
 eOK+u02HHfiVb1y7f9kXEpvPZWr1ptH6O+0Vm+8XQJ9iXnn8kDFzoleRU
 Y2gEGbsYi823358TCKQ3YYaqi9yRChuiCO6x1N8mCgnolxWzI74Bhuaxx Q==;
X-CSE-ConnectionGUID: twBYJS39Qkapv2HcGBpOFA==
X-CSE-MsgGUID: Xat5rkAxS7uTtdEfLPEwbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55696892"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="55696892"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 03:14:19 -0700
X-CSE-ConnectionGUID: mM7XefjqRrq6shk+YDhRaw==
X-CSE-MsgGUID: h5dfZup3TVKKXExQuXy99w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147316304"
Received: from unknown (HELO silpixa00401749.ger.corp.intel.com)
 ([10.237.222.190])
 by fmviesa006.fm.intel.com with ESMTP; 12 Jun 2025 03:14:18 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Kai Ji <kai.ji@intel.com>, Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>,
	stable@dpdk.org
Subject: [PATCH] crypto/qat: fix out-of-place chain/cipher/auth headers
Date: Thu, 12 Jun 2025 10:14:14 +0000
Message-ID: <20250612101414.240641-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
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

Extend the original fix to gen3 and gen4 code.

Fixes: 317d05f3721c ("crypto/qat: fix out-of-place chain/cipher/auth headers")
Cc: arkadiuszx.kusztal@intel.com
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 13 ++++++++-----
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index 478e766b97..428430882d 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -643,16 +643,19 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_t *drv_ctx,
 	for (i = 0; i < n; i++) {
 		struct qat_sym_op_cookie *cookie =
 			qp->op_cookies[tail >> tx_queue->trailz];
+		int error = 0;
 
 		req  = (struct icp_qat_fw_la_bulk_req *)(
 			(uint8_t *)tx_queue->base_addr + tail);
 		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 
 		if (vec->dest_sgl) {
-			data_len = qat_sym_build_req_set_data(req,
-				user_data[i], cookie,
-				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+			data_len = qat_reqs_mid_set(&error, req, cookie, user_data[i],
+					&vec->src_sgl[i], &vec->dest_sgl[i], ofs);
+			/* In oop there is no offset, src/dst addresses are moved
+			 * to avoid overwriting the dst header
+			 */
+			ofs.ofs.cipher.head = 0;
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
@@ -660,7 +663,7 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_t *drv_ctx,
 				vec->src_sgl[i].num, NULL, 0);
 		}
 
-		if (unlikely(data_len < 0))
+		if (unlikely(data_len < 0) || error)
 			break;
 
 		enqueue_one_aead_job_gen3(ctx, req, &vec->iv[i],
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 6a5d6e78b9..638da1a173 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -418,16 +418,19 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_t *drv_ctx,
 	for (i = 0; i < n; i++) {
 		struct qat_sym_op_cookie *cookie =
 			qp->op_cookies[tail >> tx_queue->trailz];
+		int error = 0;
 
 		req  = (struct icp_qat_fw_la_bulk_req *)(
 			(uint8_t *)tx_queue->base_addr + tail);
 		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 
 		if (vec->dest_sgl) {
-			data_len = qat_sym_build_req_set_data(req,
-				user_data[i], cookie,
-				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+			data_len = qat_reqs_mid_set(&error, req, cookie, user_data[i],
+					&vec->src_sgl[i], &vec->dest_sgl[i], ofs);
+			/* In oop there is no offset, src/dst addresses are moved
+			 * to avoid overwriting the dst header
+			 */
+			ofs.ofs.cipher.head = 0;
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
@@ -435,7 +438,7 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_t *drv_ctx,
 				vec->src_sgl[i].num, NULL, 0);
 		}
 
-		if (unlikely(data_len < 0))
+		if (unlikely(data_len < 0) || error)
 			break;
 
 		enqueue_one_aead_job_gen4(ctx, req, &vec->iv[i],
-- 
2.43.0

