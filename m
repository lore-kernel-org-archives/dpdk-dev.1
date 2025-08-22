Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BFACA0FE1
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 11:13:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69DDE40A79;
	Fri, 22 Aug 2025 13:13:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id EFC6E40A87
 for <dev@dpdk.org>; Fri, 22 Aug 2025 13:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755861200; x=1787397200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UNK0To8ZFMMTTIOVI5UxV3do1T7pzb+dfDcyiX0VpvE=;
 b=IWCl9g5p/dpbj3ZJ2bmh9nFxkI4tZ49tZ7umzwcUQETIRihE2O+6Fl3a
 xC/rOu0B3bGaMUXIfHR+9i3MH8RY7zMgLddr4KePMV7QSJr2pDDwNy5fc
 7FYoQn7Cbt6XPSnmrbE7SNsNHKSLyAp4Hu96wy2+qAXLNCetHCEyVlQVl
 ch15wI4BZsEb0tj/Btyrl/KnFYHvJXj7r39ur9bATg5b2wXJ5HZnX4gmX
 vyF1bIKhiZbnTL2Jy7C9Z8W6Vc3wSNY8ldA9DiAmmesetas6YyL3HIzWw
 Nu6Pos9LsjUScFNT4X6DFSZvV3su3+VFbaaPaBi9pNCh4CqHAsYVO7lYy g==;
X-CSE-ConnectionGUID: zLxcXfEgRDW5Ve8Tr4D66Q==
X-CSE-MsgGUID: 9TNoGhdxRvas82GCVDFciA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69267770"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="69267770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 04:13:19 -0700
X-CSE-ConnectionGUID: d6x6VuPJTsG72KbMl0oc9g==
X-CSE-MsgGUID: iEWe1ImET2GOQcl2dY3+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168884153"
Received: from silpixa00400465.ir.intel.com (HELO
 silpixa00400465.ger.corp.intel.com) ([10.237.223.221])
 by orviesa008.jf.intel.com with ESMTP; 22 Aug 2025 04:13:18 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [dpdk-dev v9 3/3] app/test: add test sm2 C1/Kp test cases
Date: Fri, 22 Aug 2025 11:13:08 +0000
Message-ID: <20250822111309.2506329-3-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822111309.2506329-1-kai.ji@intel.com>
References: <20241104093610.20426-2-arkadiuszx.kusztal@intel.com>
 <20250822111309.2506329-1-kai.ji@intel.com>
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

This commit adds tests cases to be used when C1 or kP elliptic
curve points need to be computed.

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 app/test/test_cryptodev_asym.c             | 134 +++++++++++++++++++++
 app/test/test_cryptodev_sm2_test_vectors.h | 112 ++++++++++++++++-
 2 files changed, 243 insertions(+), 3 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 20afb5e98b..6014863907 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -3924,6 +3924,132 @@ kat_rsa_decrypt_crt(const void *data)
 	return 0;
 }
 
+static int
+test_sm2_partial_encryption(const void *data)
+{
+	struct rte_crypto_asym_xform xform = { 0 };
+	const uint8_t dev_id = params->valid_devs[0];
+	const struct crypto_testsuite_sm2_params *test_vector = data;
+	uint8_t result_C1_x1[TEST_DATA_SIZE] = { 0 };
+	uint8_t result_C1_y1[TEST_DATA_SIZE] = { 0 };
+	uint8_t result_kP_x1[TEST_DATA_SIZE] = { 0 };
+	uint8_t result_kP_y1[TEST_DATA_SIZE] = { 0 };
+	struct rte_cryptodev_asym_capability_idx idx;
+	const struct rte_cryptodev_asymmetric_xform_capability *capa;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_SM2;
+	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
+	if (capa == NULL)
+		return TEST_SKIPPED;
+	if (!rte_cryptodev_asym_xform_capability_check_opcap(capa,
+			RTE_CRYPTO_ASYM_OP_ENCRYPT, RTE_CRYPTO_SM2_PARTIAL)) {
+		return TEST_SKIPPED;
+	}
+
+	xform.xform_type = RTE_CRYPTO_ASYM_XFORM_SM2;
+	xform.ec.curve_id = RTE_CRYPTO_EC_GROUP_SM2;
+	xform.ec.q = test_vector->pubkey;
+	self->op->asym->sm2.op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
+	self->op->asym->sm2.k = test_vector->k;
+	if (rte_cryptodev_asym_session_create(dev_id, &xform,
+			params->session_mpool, &self->sess) < 0) {
+		RTE_LOG(ERR, USER1, "line %u FAILED: Session creation failed",
+			__LINE__);
+		return TEST_FAILED;
+	}
+	rte_crypto_op_attach_asym_session(self->op, self->sess);
+
+	self->op->asym->sm2.c1.x.data = result_C1_x1;
+	self->op->asym->sm2.c1.y.data = result_C1_y1;
+	self->op->asym->sm2.kp.x.data = result_kP_x1;
+	self->op->asym->sm2.kp.y.data = result_kP_y1;
+	TEST_ASSERT_SUCCESS(send_one(),
+		"Failed to process crypto op");
+
+	debug_hexdump(stdout, "C1[x]", self->op->asym->sm2.c1.x.data,
+		self->op->asym->sm2.c1.x.length);
+	debug_hexdump(stdout, "C1[y]", self->op->asym->sm2.c1.y.data,
+		self->op->asym->sm2.c1.y.length);
+	debug_hexdump(stdout, "kP[x]", self->op->asym->sm2.kp.x.data,
+		self->op->asym->sm2.kp.x.length);
+	debug_hexdump(stdout, "kP[y]", self->op->asym->sm2.kp.y.data,
+		self->op->asym->sm2.kp.y.length);
+
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(test_vector->C1.x.data,
+		self->op->asym->sm2.c1.x.data,
+		test_vector->C1.x.length,
+		"Incorrect value of C1[x]\n");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(test_vector->C1.y.data,
+		self->op->asym->sm2.c1.y.data,
+		test_vector->C1.y.length,
+		"Incorrect value of C1[y]\n");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(test_vector->kP.x.data,
+		self->op->asym->sm2.kp.x.data,
+		test_vector->kP.x.length,
+		"Incorrect value of kP[x]\n");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(test_vector->kP.y.data,
+		self->op->asym->sm2.kp.y.data,
+		test_vector->kP.y.length,
+		"Incorrect value of kP[y]\n");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_sm2_partial_decryption(const void *data)
+{
+	struct rte_crypto_asym_xform xform = {};
+	const uint8_t dev_id = params->valid_devs[0];
+	const struct crypto_testsuite_sm2_params *test_vector = data;
+	uint8_t result_kP_x1[TEST_DATA_SIZE] = { 0 };
+	uint8_t result_kP_y1[TEST_DATA_SIZE] = { 0 };
+	struct rte_cryptodev_asym_capability_idx idx;
+	const struct rte_cryptodev_asymmetric_xform_capability *capa;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_SM2;
+	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
+	if (capa == NULL)
+		return TEST_SKIPPED;
+	if (!rte_cryptodev_asym_xform_capability_check_opcap(capa,
+			RTE_CRYPTO_ASYM_OP_DECRYPT, RTE_CRYPTO_SM2_PARTIAL)) {
+		return TEST_SKIPPED;
+	}
+
+	xform.xform_type = RTE_CRYPTO_ASYM_XFORM_SM2;
+	xform.ec.pkey = test_vector->pkey;
+	self->op->asym->sm2.op_type = RTE_CRYPTO_ASYM_OP_DECRYPT;
+	self->op->asym->sm2.c1 = test_vector->C1;
+
+	if (rte_cryptodev_asym_session_create(dev_id, &xform,
+			params->session_mpool, &self->sess) < 0) {
+		RTE_LOG(ERR, USER1, "line %u FAILED: Session creation failed",
+			__LINE__);
+		return TEST_FAILED;
+	}
+	rte_crypto_op_attach_asym_session(self->op, self->sess);
+
+	self->op->asym->sm2.kp.x.data = result_kP_x1;
+	self->op->asym->sm2.kp.y.data = result_kP_y1;
+	TEST_ASSERT_SUCCESS(send_one(),
+		"Failed to process crypto op");
+
+	debug_hexdump(stdout, "kP[x]", self->op->asym->sm2.kp.x.data,
+		self->op->asym->sm2.c1.x.length);
+	debug_hexdump(stdout, "kP[y]", self->op->asym->sm2.kp.y.data,
+		self->op->asym->sm2.c1.y.length);
+
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(test_vector->kP.x.data,
+		self->op->asym->sm2.kp.x.data,
+		test_vector->kP.x.length,
+		"Incorrect value of kP[x]\n");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(test_vector->kP.y.data,
+		self->op->asym->sm2.kp.y.data,
+		test_vector->kP.y.length,
+		"Incorrect value of kP[y]\n");
+
+	return 0;
+}
+
 static struct unit_test_suite cryptodev_openssl_asym_testsuite  = {
 	.suite_name = "Crypto Device OPENSSL ASYM Unit Test Suite",
 	.setup = testsuite_setup,
@@ -3996,6 +4122,14 @@ static struct unit_test_suite cryptodev_qat_asym_testsuite  = {
 	.setup = testsuite_setup,
 	.teardown = testsuite_teardown,
 	.unit_test_cases = {
+		TEST_CASE_NAMED_WITH_DATA(
+			"SM2 encryption - test case 1",
+			ut_setup_asym, ut_teardown_asym,
+			test_sm2_partial_encryption, &sm2_enc_hw_t1),
+		TEST_CASE_NAMED_WITH_DATA(
+			"SM2 decryption - test case 1",
+			ut_setup_asym, ut_teardown_asym,
+			test_sm2_partial_decryption, &sm2_enc_hw_t1),
 		TEST_CASE_NAMED_WITH_DATA(
 			"Modular Exponentiation (mod=128, base=20, exp=3, res=128)",
 			ut_setup_asym, ut_teardown_asym,
diff --git a/app/test/test_cryptodev_sm2_test_vectors.h b/app/test/test_cryptodev_sm2_test_vectors.h
index 41f5f7074a..92f7e77671 100644
--- a/app/test/test_cryptodev_sm2_test_vectors.h
+++ b/app/test/test_cryptodev_sm2_test_vectors.h
@@ -8,19 +8,125 @@
 #include "rte_crypto_asym.h"
 
 struct crypto_testsuite_sm2_params {
-	rte_crypto_param pubkey_qx;
-	rte_crypto_param pubkey_qy;
+	union {
+		struct {
+			rte_crypto_param pubkey_qx;
+			rte_crypto_param pubkey_qy;
+		};
+		struct rte_crypto_ec_point pubkey;
+	};
 	rte_crypto_param pkey;
 	rte_crypto_param k;
 	rte_crypto_param sign_r;
 	rte_crypto_param sign_s;
 	rte_crypto_param id;
-	rte_crypto_param cipher;
+	union {
+		rte_crypto_param cipher;
+		struct {
+			struct rte_crypto_ec_point C1;
+			struct rte_crypto_ec_point kP;
+		};
+	};
 	rte_crypto_param message;
 	rte_crypto_param digest;
 	int curve;
 };
 
+uint8_t sm2_enc_pub_x_t1[] = {
+	0x26, 0xf1, 0xf3, 0xef, 0x12, 0x27, 0x85, 0xd1,
+	0x7d, 0x38, 0x70, 0xc2, 0x43, 0x46, 0x50, 0x36,
+	0x3f, 0xdf, 0x4b, 0x2f, 0x45, 0x0e, 0x8e, 0xd1,
+	0xb6, 0x0f, 0xdc, 0x1f, 0xc6, 0xf0, 0x19, 0xab
+};
+uint8_t sm2_enc_pub_y_t1[] = {
+	0xd9, 0x19, 0x8b, 0xdb, 0xef, 0xa5, 0x84, 0x76,
+	0xec, 0x82, 0x25, 0x12, 0x5b, 0x8c, 0xe3, 0xe1,
+	0x0a, 0x10, 0x0d, 0xc6, 0x97, 0x6c, 0xc1, 0x89,
+	0xd9, 0x6d, 0xa6, 0x88, 0x9e, 0xbc, 0xd3, 0x7a
+};
+uint8_t sm2_k_t1[] = {
+	0x12, 0x34, 0x56, 0x78, 0xB9, 0x6E, 0x5A, 0xF7,
+	0x0B, 0xD4, 0x80, 0xB4, 0x72, 0x40, 0x9A, 0x9A,
+	0x32, 0x72, 0x57, 0xF1, 0xEB, 0xB7, 0x3F, 0x5B,
+	0x07, 0x33, 0x54, 0xB2, 0x48, 0x66, 0x85, 0x63
+};
+
+uint8_t sm2_C1_x_t1[] = {
+	0x15, 0xf6, 0xb7, 0x49, 0x00, 0x39, 0x73, 0x9d,
+	0x5b, 0xb3, 0xd3, 0xe9, 0x1d, 0xe4, 0xc8, 0xbd,
+	0x08, 0xe3, 0x6a, 0x22, 0xff, 0x1a, 0xbf, 0xdc,
+	0x75, 0x6b, 0x12, 0x85, 0x81, 0xc5, 0x8b, 0xcf
+};
+
+uint8_t sm2_C1_y_t1[] = {
+	0x6a, 0x92, 0xd4, 0xd8, 0x13, 0xec, 0x8f, 0x9a,
+	0x9d, 0xbe, 0x51, 0x47, 0x6f, 0x54, 0xc5, 0x41,
+	0x98, 0xf5, 0x5f, 0x83, 0xce, 0x1c, 0x18, 0x1a,
+	0x48, 0xbd, 0xeb, 0x38, 0x13, 0x67, 0x0d, 0x06
+};
+
+uint8_t sm2_kP_x_t1[] = {
+	0x6b, 0xfb, 0x9a, 0xcb, 0xc6, 0xb6, 0x36, 0x31,
+	0x0f, 0xd1, 0xdd, 0x9c, 0x9f, 0x17, 0x5f, 0x3f,
+	0x68, 0x13, 0x96, 0xd2, 0x54, 0x5b, 0xa6, 0x19,
+	0x78, 0x1f, 0x87, 0x3d, 0x81, 0xc3, 0x21, 0x01
+};
+
+uint8_t sm2_kP_y_t1[] = {
+	0xa4, 0x08, 0xf3, 0x74, 0x35, 0x51, 0x8c, 0x81,
+	0x06, 0x4c, 0x8f, 0x31, 0x49, 0xe3, 0x5b, 0x4d,
+	0xfc, 0x3d, 0x19, 0xac, 0x7d, 0x07, 0xd0, 0x9a,
+	0x99, 0x5a, 0x25, 0x16, 0x66, 0xff, 0x41, 0x3c
+};
+
+uint8_t sm2_kP_d_t1[] = {
+	0x6F, 0xCB, 0xA2, 0xEF, 0x9A, 0xE0, 0xAB, 0x90,
+	0x2B, 0xC3, 0xBD, 0xE3, 0xFF, 0x91, 0x5D, 0x44,
+	0xBA, 0x4C, 0xC7, 0x8F, 0x88, 0xE2, 0xF8, 0xE7,
+	0xF8, 0x99, 0x6D, 0x3B, 0x8C, 0xCE, 0xED, 0xEE
+};
+
+struct crypto_testsuite_sm2_params sm2_enc_hw_t1 = {
+	.k = {
+		.data = sm2_k_t1,
+		.length = sizeof(sm2_k_t1)
+	},
+	.pubkey = {
+		.x = {
+			.data = sm2_enc_pub_x_t1,
+			.length = sizeof(sm2_enc_pub_x_t1)
+		},
+		.y = {
+			.data = sm2_enc_pub_y_t1,
+			.length = sizeof(sm2_enc_pub_y_t1)
+		}
+	},
+	.C1 = {
+		.x = {
+			.data = sm2_C1_x_t1,
+			.length = sizeof(sm2_C1_x_t1)
+		},
+		.y = {
+			.data = sm2_C1_y_t1,
+			.length = sizeof(sm2_C1_y_t1)
+		}
+	},
+	.kP = {
+		.x = {
+			.data = sm2_kP_x_t1,
+			.length = sizeof(sm2_kP_x_t1)
+		},
+		.y = {
+			.data = sm2_kP_y_t1,
+			.length = sizeof(sm2_kP_y_t1)
+		}
+	},
+	.pkey = {
+		.data = sm2_kP_d_t1,
+		.length = sizeof(sm2_kP_d_t1)
+	}
+};
+
 static uint8_t fp256_pkey[] = {
 	0x77, 0x84, 0x35, 0x65, 0x4c, 0x7a, 0x6d, 0xb1,
 	0x1e, 0x63, 0x0b, 0x41, 0x97, 0x36, 0x04, 0xf4,
-- 
2.43.0

