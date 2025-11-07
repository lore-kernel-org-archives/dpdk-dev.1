Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D3ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 934B7402D6;
	Fri,  7 Nov 2025 17:43:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4CE444021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762533818; x=1794069818;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T+76SwYShREQXIl+6EJXLBHoXLpVu3eVXeBdQvknZio=;
 b=HMF7u5haRPEZu5XSRT1wcbgAmV9tS9YCYis3M6QTK/dffuyKsd+SwvpB
 xn8M/SCtbzmkk1KQE35r8bYpQVOnYhF1P0Dp0RkPLL3fJev8Tv2JqWGbH
 z1hhIWfIssz3iS5HjY/UmJJ8qQp0vYYMShYaN3dceczFyR7SBb9pMOk73
 yKDs6bK3tUF6jGJiZTIEmIlAKRdwzh9Vm+6g5O0EVu7C0qZwM1eY6pZGo
 jZaalovQUFTzvVvwtdud3pqbErpPYWP0wlqfseDn4YqhlfuYW6W+rrVe0
 q6scd6e7rLtBCqqmeLmu567sYo/gEwg4PEcP9ekAkj3OqRkX8VgBZgzD5 g==;
X-CSE-ConnectionGUID: IO1YVJb6Q+ys1eFHrO1EsA==
X-CSE-MsgGUID: kSb+WGRpSBCqb+lhJN3f2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="76135105"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="76135105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:43:37 -0800
X-CSE-ConnectionGUID: V81SA8QtT4iADvbo/9XeNA==
X-CSE-MsgGUID: hqDePNoUQ6uUcPmmZxHvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="188340546"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa008.fm.intel.com with ESMTP; 07 Nov 2025 08:43:35 -0800
From: Emma Finn <emma.finn@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>, Fiona Trahe <fiona.trahe@intel.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH] crypto/qat: fix CCM request descriptor hash_state_sz field
Date: Fri,  7 Nov 2025 16:43:29 +0000
Message-Id: <20251107164329.2154794-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107162308.2150642-1-emma.finn@intel.com>
References: <20251107162308.2150642-1-emma.finn@intel.com>
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

The hash_state_sz field in the QAT request descriptor for AES-CCM
operations was incorrectly set to the digest length. According to
the QAT firmware specification, this field should contain the
length of AAD in quadwords for CCM operations.

This incorrect field value caused QAT firmware to return
INVALID_PARAMS errors for certain AAD buffer sizes. A new unit
test is also added to cover this case.

Fixes: ab56c4d9ed9a ("crypto/qat: support AES-CCM")

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test/test_cryptodev.c                   | 16 +++++++
 app/test/test_cryptodev_aead_test_vectors.h | 53 +++++++++++++++++++++
 drivers/crypto/qat/qat_sym_session.c        |  3 +-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 6e5f308e55..9bdd357727 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -14271,6 +14271,12 @@ test_AES_CCM_authenticated_encryption_test_case_128_3(void)
 	return test_authenticated_encryption(&ccm_test_case_128_3);
 }
 
+static int
+test_AES_CCM_authenticated_encryption_test_case_128_4(void)
+{
+	return test_authenticated_encryption(&ccm_test_case_128_4);
+}
+
 static int
 test_AES_CCM_authenticated_decryption_test_case_128_1(void)
 {
@@ -14289,6 +14295,12 @@ test_AES_CCM_authenticated_decryption_test_case_128_3(void)
 	return test_authenticated_decryption(&ccm_test_case_128_3);
 }
 
+static int
+test_AES_CCM_authenticated_decryption_test_case_128_4(void)
+{
+	return test_authenticated_decryption(&ccm_test_case_128_4);
+}
+
 static int
 test_AES_CCM_authenticated_encryption_test_case_192_1(void)
 {
@@ -18975,6 +18987,8 @@ static struct unit_test_suite cryptodev_aes_ccm_auth_testsuite  = {
 			test_AES_CCM_authenticated_encryption_test_case_128_2),
 		TEST_CASE_ST(ut_setup, ut_teardown,
 			test_AES_CCM_authenticated_encryption_test_case_128_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_AES_CCM_authenticated_encryption_test_case_128_4),
 
 		/** AES CCM Authenticated Decryption 128 bits key*/
 		TEST_CASE_ST(ut_setup, ut_teardown,
@@ -18983,6 +18997,8 @@ static struct unit_test_suite cryptodev_aes_ccm_auth_testsuite  = {
 			test_AES_CCM_authenticated_decryption_test_case_128_2),
 		TEST_CASE_ST(ut_setup, ut_teardown,
 			test_AES_CCM_authenticated_decryption_test_case_128_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_AES_CCM_authenticated_decryption_test_case_128_4),
 
 		/** AES CCM Authenticated Encryption 192 bits key */
 		TEST_CASE_ST(ut_setup, ut_teardown,
diff --git a/app/test/test_cryptodev_aead_test_vectors.h b/app/test/test_cryptodev_aead_test_vectors.h
index 73bedaf557..6b9642e339 100644
--- a/app/test/test_cryptodev_aead_test_vectors.h
+++ b/app/test/test_cryptodev_aead_test_vectors.h
@@ -50,6 +50,13 @@ static uint8_t ccm_aad_test_2[22] = {
 		0xA5, 0xB8, 0xFC, 0xBA, 0x00, 0x00
 };
 
+static uint8_t ccm_aad_test_4[32] = {
+		0xD2, 0x3D, 0xBD, 0xF2, 0x13, 0xAA, 0xD5, 0x03,
+		0xDB, 0xA5, 0x3E, 0x44, 0xBB, 0x1E, 0xD7, 0x19,
+		0x65, 0x2F, 0x37, 0xA0, 0x97, 0xD6, 0x5F, 0x59,
+		0x0B, 0xD1, 0xE6, 0xA4, 0xCC, 0x50, 0xEB, 0x62
+};
+
 static uint8_t sm4_gcm_aad_test_2[] = {
 		0x3f, 0x89, 0x42, 0x20
 };
@@ -3714,6 +3721,52 @@ static const struct aead_test_data ccm_test_case_128_3 = {
 	}
 };
 
+static const struct aead_test_data ccm_test_case_128_4 = {
+	.algo = RTE_CRYPTO_AEAD_AES_CCM,
+	.key = {
+		.data = {
+			0x2F, 0x55, 0xF2, 0xF8, 0x4E, 0x66, 0x5E, 0x4B,
+			0x1D, 0x56, 0x91, 0x62, 0x6C, 0xE7, 0xD4, 0xB8
+		},
+		.len = 16
+	},
+	.iv = {
+		.data = {
+			0x2C, 0x39, 0xBE, 0x24, 0xAF, 0xF4, 0xC1, 0x0E,
+			0x20, 0x26, 0x11, 0x49, 0x49
+		},
+		.len = 13
+	},
+	.aad = {
+		.data = ccm_aad_test_4,
+		.len = 32
+	},
+	.plaintext = {
+		.data = {
+			0xF5, 0x2A, 0xEC, 0xEF, 0x88, 0x73, 0x10, 0x11,
+			0xD0, 0x68, 0xCB, 0x8E, 0x82, 0xBE, 0xED, 0x68,
+			0xC1, 0xC6, 0xF2, 0xA5, 0x9E, 0x99, 0xF6, 0x3D,
+			0xDA, 0xEA, 0xA0, 0x49, 0xD0, 0xF4, 0x18, 0xC0
+		},
+		.len = 32
+	},
+	.ciphertext = {
+		.data = {
+			0x0F, 0x7B, 0x8A, 0x0D, 0x79, 0xB6, 0x1C, 0x93,
+			0x00, 0x26, 0x57, 0x52, 0xC8, 0x68, 0x30, 0xF6,
+			0x92, 0xA4, 0x9C, 0x86, 0x5E, 0x77, 0x51, 0x9C,
+			0x79, 0x15, 0x7C, 0xF3, 0x87, 0x27, 0x2A, 0x77
+		},
+		.len = 32
+	},
+	.auth_tag = {
+		.data = {
+			0x64, 0x2F, 0x58, 0x61
+		},
+		.len = 4
+	}
+};
+
 /** AES-CCM-192 Test Vectors */
 static const struct aead_test_data ccm_test_case_192_1 = {
 	.algo = RTE_CRYPTO_AEAD_AES_CCM,
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 98ab82ffb3..c58ecb7f54 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2774,7 +2774,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		hash->auth_counter.counter = 0;
 
 		hash_cd_ctrl->outer_prefix_sz = digestsize;
-		auth_param->hash_state_sz = digestsize;
+		auth_param->hash_state_sz = (RTE_ALIGN_CEIL(auth_param->u2.aad_sz, 8)
+										>> 3);
 
 		memcpy(cdesc->cd_cur_ptr + state1_size, authkey, authkeylen);
 		break;
-- 
2.34.1

