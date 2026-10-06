Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888FBCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62003402B0;
	Tue,  6 Oct 2026 12:54:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 98864402A2
 for <dev@dpdk.org>; Tue,  6 Oct 2026 12:54:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791284078; x=1822820078;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pQhqj11Dn+9pa4qWDd1Fw5tWxfjZ3PnxnULaD5poyyA=;
 b=UQOBpxvyYlZiTzDT+cF/k/jSgNPR97QXaeM21t8z+6aXrrIOdbr7pjSW
 jsCW90aD5F4QkTbvVAyxIYSvVHzHRL44ODOZ+FfS05Z8j2oLYS3wLm5gk
 qIGJZ6X1bGVZfL8xL1jZzFEImv755+gx7dhWVnOEjnpXXbgG+E6HJjPI5
 k4X3Ues3jw/TWSy6ltRJr+VpV2G1X5PfnivdOuEoD5hkVb65JciqFx2Pn
 WT+gteh1XiFIjqA4uQxhu7ubvl3SGkcWVEKTOmscGDSJBXrKm+CSlyE59
 rC9kPeobZbHlUi5h9XWpVnzRFr2Bg/64v8UAJ7XikmKdDlNvR00KYA/65 A==;
X-CSE-ConnectionGUID: Z6GzsY/fRZ2ZWmU/vvsgdQ==
X-CSE-MsgGUID: I3q6RgCoQ329vuzS18Hqaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="26430"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="26430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:54:36 -0700
X-CSE-ConnectionGUID: 2Q2cYiqYRi2e5W2JIOtEzA==
X-CSE-MsgGUID: F+9sd6K0QWORqA66BoarKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285224601"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa005.fm.intel.com with ESMTP; 06 Oct 2026 03:54:35 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases
Date: Tue,  6 Oct 2026 10:54:23 +0000
Message-ID: <20261006105424.1630315-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

Extend the blockchiper test suite with
NULL cipher and NULL auth OOP SGL test cases.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev_aes_test_vectors.h | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/app/test/test_cryptodev_aes_test_vectors.h b/app/test/test_cryptodev_aes_test_vectors.h
index 505e603b7e..60a270a3ce 100644
--- a/app/test/test_cryptodev_aes_test_vectors.h
+++ b/app/test/test_cryptodev_aes_test_vectors.h
@@ -4598,6 +4598,24 @@ static const struct blockcipher_test_case aes_chain_test_cases[] = {
 		.op_mask = BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
 		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP,
 	},
+	{
+		.test_descr = "NULL-CIPHER-NULL-AUTH encrypt & gen x8byte - OOP SGL",
+		.test_data = &null_test_data_chain_x8_multiple,
+		.op_mask = BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,
+		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP |
+				BLOCKCIPHER_TEST_FEATURE_SG,
+		.sgl_flag = RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+		.sgl_segs = 3,
+	},
+	{
+		.test_descr = "NULL-AUTH-NULL-CIPHER verify & decrypt x8byte - OOP SGL",
+		.test_data = &null_test_data_chain_x8_multiple,
+		.op_mask = BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
+		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP |
+				BLOCKCIPHER_TEST_FEATURE_SG,
+		.sgl_flag = RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+		.sgl_segs = 3,
+	},
 	{
 		.test_descr = "NULL-CIPHER-NULL-AUTH encrypt & gen x4byte",
 		.test_data = &null_test_data_chain_x4_multiple,
@@ -4620,6 +4638,24 @@ static const struct blockcipher_test_case aes_chain_test_cases[] = {
 		.op_mask = BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
 		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP,
 	},
+	{
+		.test_descr = "NULL-CIPHER-NULL-AUTH encrypt & gen x4byte - OOP SGL",
+		.test_data = &null_test_data_chain_x4_multiple,
+		.op_mask = BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,
+		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP |
+				BLOCKCIPHER_TEST_FEATURE_SG,
+		.sgl_flag = RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+		.sgl_segs = 3,
+	},
+	{
+		.test_descr = "NULL-AUTH-NULL-CIPHER verify & decrypt x4byte - OOP SGL",
+		.test_data = &null_test_data_chain_x4_multiple,
+		.op_mask = BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
+		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP |
+				BLOCKCIPHER_TEST_FEATURE_SG,
+		.sgl_flag = RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+		.sgl_segs = 3,
+	},
 	{
 		.test_descr = "NULL-CIPHER-NULL-AUTH encrypt & gen x1byte",
 		.test_data = &null_test_data_chain_x1_multiple,
@@ -4642,6 +4678,25 @@ static const struct blockcipher_test_case aes_chain_test_cases[] = {
 		.op_mask = BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
 		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP,
 	},
+	{
+		.test_descr = "NULL-CIPHER-NULL-AUTH encrypt & gen x1byte - OOP SGL",
+		.test_data = &null_test_data_chain_x1_multiple,
+		.op_mask = BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,
+		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP |
+				BLOCKCIPHER_TEST_FEATURE_SG,
+		.sgl_flag = RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+		.sgl_segs = 3,
+	},
+	{
+		.test_descr = "NULL-AUTH-NULL-CIPHER verify & decrypt x1byte - OOP SGL",
+		.test_data = &null_test_data_chain_x1_multiple,
+		.op_mask = BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
+		.feature_mask = BLOCKCIPHER_TEST_FEATURE_OOP |
+				BLOCKCIPHER_TEST_FEATURE_SG,
+		.sgl_flag = RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+		.sgl_segs = 3,
+
+	},
 };
 
 static const struct blockcipher_test_case aes_cipheronly_test_cases[] = {
-- 
2.52.0

