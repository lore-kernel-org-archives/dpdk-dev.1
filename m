Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC49D6D22A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 14:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F34E40275;
	Thu, 18 Dec 2025 15:09:39 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0678B4026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 15:09:36 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI6cxVm1673236; Thu, 18 Dec 2025 06:09:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=LmHccCRMM1n+Cykw3j95MBA
 qs+yxhHJnrpIW2zEn9h8=; b=DdwX0ORZRhoqZEAmx/UuAtHouBN+htzKJwUjYJw
 0mDSsQ0jRJNfQu66S3HwcLu5/TdhxQdLkzWNmWJXc2JlXR+I1cczaAfIDOnfav6o
 xs4rab9FNm4HexbIPh0TVyZ05ulPMNp9XIEAXTNNZwiYspOb/iGrob83uOlPFvbT
 6rarOdGci1rx1QzAAX5UlIyOvNKDgN5CDqdT1myVJC5lOusjw881nUM0nMY117qm
 otIytuQfmVJCwYvTsYTHFpSwIOgsLcbYXP17eqMdGzOQriqrUxwJPrD2I5oGp1MS
 hJkIcanrjxa2rLDtLZKI3I2v20YUBDfZRvF1/fqJAw7vexw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b3w2htvhe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 06:09:36 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Dec 2025 06:09:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Dec 2025 06:09:48 -0800
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id DED055B6949;
 Thu, 18 Dec 2025 06:09:32 -0800 (PST)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <dev@dpdk.org>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <kai.ji@intel.com>, Rupesh Chiluka <rchiluka@marvell.com>
Subject: [PATCH] test/crypto: remove PMD specific asym testsuites
Date: Thu, 18 Dec 2025 19:39:09 +0530
Message-ID: <20251218140909.1816595-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=EMkLElZC c=1 sm=1 tr=0 ts=69440b20 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=j-M2EO107KMftwdfWSsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QmegkkCj7e7gVmMq-7MXUrJDrtqZOiFE
X-Proofpoint-ORIG-GUID: QmegkkCj7e7gVmMq-7MXUrJDrtqZOiFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDExNyBTYWx0ZWRfXzfOYVkHZy5hK
 ZPGGM7bgko1KynYjCRha58VBx+tbnTxdXEGuvcSMqFERqGE0tFYBo1l/KVmMsA6jkUGwCdqFk1k
 S4LOaAtFb68/5WUsvC3YXHQgQ4hixrcE1ex9wZNHDn7fYgmtakXsKBNLRJA2PkYyPhsZUa4xXgW
 +1OskIvg/ctcmGQQHoSUHBQVIpftgcpY2xpP4ynf9LafjIgm40iiiU1d0cAr5Tm7QCY76923pE/
 C0Gg2NnuZE5sSva85709GTHCETn1YcG4ljg/3/UNGbuSSynQuUOIW+sxvkvms9iBaXqKajnmhJ5
 o9Lpo7Koad+qMz6JczqTheBLeQxeDN2zro0b5BjqU1Ok54L4FfwSUbXTPuaKqUEYBzZ3woxzAy7
 cOOes7/HTt0JXM8oDe9vVWf3xlYGZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
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

Change PMD specific asymmetric testsuites to
capabilities based testsuites

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 app/test/test_cryptodev_asym.c | 540 ++++++++++++++++++++++-----------
 1 file changed, 364 insertions(+), 176 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 111f675c94..cc4590a500 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -39,6 +39,10 @@
 #define TEST_VECTOR_SIZE 256
 #define DEQ_TIMEOUT 10000
 
+#define ADD_ASYM_TESTSUITE(index, parent_ts, child_ts, num_child_ts)	\
+	for (j = 0; j < num_child_ts; index++, j++)			\
+		parent_ts.unit_test_suites[index] = child_ts[j]
+
 static int gbl_driver_id;
 static struct crypto_testsuite_params_asym {
 	struct rte_mempool *op_mpool;
@@ -3113,6 +3117,9 @@ test_sm2_enc(void)
 	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
 	if (capa == NULL)
 		return -ENOTSUP;
+	if (!rte_cryptodev_asym_xform_capability_check_opcap(capa,
+			RTE_CRYPTO_ASYM_OP_ENCRYPT, 0))
+		return TEST_SKIPPED;
 
 	/* Setup crypto op data structure */
 	op = rte_crypto_op_alloc(op_mpool, RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
@@ -3297,6 +3304,9 @@ test_sm2_dec(void)
 	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
 	if (capa == NULL)
 		return -ENOTSUP;
+	if (!rte_cryptodev_asym_xform_capability_check_opcap(capa,
+			RTE_CRYPTO_ASYM_OP_DECRYPT, 0))
+		return TEST_SKIPPED;
 
 	/* Setup crypto op data structure */
 	op = rte_crypto_op_alloc(op_mpool, RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
@@ -4995,27 +5005,254 @@ test_sm2_partial_decryption(const void *data)
 	return 0;
 }
 
-static struct unit_test_suite cryptodev_openssl_asym_testsuite  = {
-	.suite_name = "Crypto Device OPENSSL ASYM Unit Test Suite",
-	.setup = testsuite_setup,
-	.teardown = testsuite_teardown,
+static int
+check_asym_capabilities_supported(const enum rte_crypto_asym_xform_type xform_type)
+{
+	uint8_t dev_id = testsuite_params.valid_devs[0];
+	struct rte_cryptodev_asym_capability_idx idx = {xform_type};
+
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return TEST_SKIPPED;
+	return 0;
+}
+
+static int
+crypto_asym_dh_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_DH;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_dsa_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_DSA;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_ecdh_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_ECDH;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_ecdsa_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_ecpm_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_ECPM;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_eddsa_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_EDDSA;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_mod_ex_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_MODEX;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_mod_inv_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_MODINV;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_rsa_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_RSA;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_sm2_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_SM2;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_ml_kem_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_ML_KEM;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static int
+crypto_asym_ml_dsa_testsuite_setup(void)
+{
+	const enum rte_crypto_asym_xform_type xform_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA;
+
+	if (check_asym_capabilities_supported(xform_type) != 0) {
+		RTE_LOG(INFO, USER1,
+			"Device doesn't support required ASYM capabilities. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+	return 0;
+}
+
+static struct unit_test_suite cryptodev_asym_gen_testsuite = {
+	.suite_name = "Cryptodev ASYM General Unit Test Suite",
 	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_capability),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_dh_testsuite = {
+	.suite_name = "Cryptodev ASYM DH Unit Test Suite",
+	.setup = crypto_asym_dh_testsuite_setup,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_dh_key_generation),
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_dsa_testsuite = {
+	.suite_name = "Cryptodev ASYM DSA Unit Test Suite",
+	.setup = crypto_asym_dsa_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_dsa),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_ecdh_testsuite = {
+	.suite_name = "Cryptodev ASYM ECDH Unit Test Suite",
+	.setup = crypto_asym_ecdh_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_dh_key_generation),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_sign),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_verify),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_enc),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_dec),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_rsa_enc_dec),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_sign_verify),
+				test_ecdh_all_curve),
+		TEST_CASE_NAMED_ST(
+			"ECDH Elliptic Curve tests",
+			ut_setup_asym, ut_teardown_asym,
+			test_ecdh_qat_curves),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_ecdsa_testsuite = {
+	.suite_name = "Cryptodev ASYM ECDSA Unit Test Suite",
+	.setup = crypto_asym_ecdsa_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_enc_dec_crt),
+			     test_ecdsa_sign_verify_all_curve),
+		TEST_CASE_NAMED_ST(
+			"ECDSA Elliptic Curve tests",
+			ut_setup_asym, ut_teardown_asym,
+			test_ecdsa_sign_verify_qat_curves),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_ecpm_testsuite = {
+	.suite_name = "Cryptodev ASYM ECPM Unit Test Suite",
+	.setup = crypto_asym_ecpm_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_sign_verify_crt),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mod_inv),
+				test_ecpm_all_curve),
+		TEST_CASE_NAMED_ST(
+			"ECPM Elliptic Curve tests",
+			ut_setup_asym, ut_teardown_asym,
+			test_ecpm_qat_curves),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_eddsa_testsuite = {
+	.suite_name = "Cryptodev ASYM EdDSA Unit Test Suite",
+	.setup = crypto_asym_eddsa_testsuite_setup,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_eddsa_sign_verify_all_curve),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_mod_ex_testsuite = {
+	.suite_name = "Cryptodev ASYM MOD Ex Unit Test Suite",
+	.setup = crypto_asym_mod_ex_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mod_exp),
 		TEST_CASE_NAMED_WITH_DATA(
 			"Modex test for zero padding",
@@ -5057,34 +5294,39 @@ static struct unit_test_suite cryptodev_openssl_asym_testsuite  = {
 			"Modex Group 24 subgroup test",
 			ut_setup_asym, ut_teardown_asym,
 			modular_exponentiation, &modex_group_test_cases[7]),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_eddsa_sign_verify_all_curve),
-
-		TEST_CASES_END() /**< NULL terminate unit test array */
-	}
-};
-
-static struct unit_test_suite cryptodev_qat_asym_testsuite  = {
-	.suite_name = "Crypto Device QAT ASYM Unit Test Suite",
-	.setup = testsuite_setup,
-	.teardown = testsuite_teardown,
-	.unit_test_cases = {
-		TEST_CASE_NAMED_WITH_DATA(
-			"SM2 encryption - test case 1",
-			ut_setup_asym, ut_teardown_asym,
-			test_sm2_partial_encryption, &sm2_enc_hw_t1),
-		TEST_CASE_NAMED_WITH_DATA(
-			"SM2 decryption - test case 1",
-			ut_setup_asym, ut_teardown_asym,
-			test_sm2_partial_decryption, &sm2_enc_hw_t1),
 		TEST_CASE_NAMED_WITH_DATA(
 			"Modular Exponentiation (mod=128, base=20, exp=3, res=128)",
 			ut_setup_asym, ut_teardown_asym,
 			modular_exponentiation, &modex_test_case_m128_b20_e3),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_mod_inv_testsuite = {
+	.suite_name = "Cryptodev ASYM MOD Inv Unit Test Suite",
+	.setup = crypto_asym_mod_inv_testsuite_setup,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mod_inv),
 		/* Modular Multiplicative Inverse */
 		TEST_CASE_NAMED_WITH_DATA(
 			"Modular Inverse (mod=128, base=20, exp=3, inv=128)",
 			ut_setup_asym, ut_teardown_asym,
 			modular_multiplicative_inverse, &modinv_test_case),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_rsa_testsuite = {
+	.suite_name = "Cryptodev ASYM RSA Unit Test Suite",
+	.setup = crypto_asym_rsa_testsuite_setup,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_rsa_enc_dec),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_sign_verify),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_enc_dec_crt),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_sign_verify_crt),
 		/* RSA EXP */
 		TEST_CASE_NAMED_WITH_DATA(
 			"RSA Encryption (n=128, pt=20, e=3) EXP, Padding: NONE",
@@ -5103,203 +5345,149 @@ static struct unit_test_suite cryptodev_qat_asym_testsuite  = {
 			"RSA Decryption (n=128, pt=20, e=3) CRT, Padding: NONE",
 			ut_setup_asym, ut_teardown_asym,
 			kat_rsa_decrypt_crt, &rsa_vector_128_20_3_none),
-		TEST_CASE_NAMED_ST(
-			"ECDH Elliptic Curve tests",
-			ut_setup_asym, ut_teardown_asym,
-			test_ecdh_qat_curves),
-		TEST_CASE_NAMED_ST(
-			"ECPM Elliptic Curve tests",
-			ut_setup_asym, ut_teardown_asym,
-			test_ecpm_qat_curves),
-		TEST_CASE_NAMED_ST(
-			"ECDSA Elliptic Curve tests",
-			ut_setup_asym, ut_teardown_asym,
-			test_ecdsa_sign_verify_qat_curves),
-
-		TEST_CASES_END() /**< NULL terminate unit test array */
+		TEST_CASES_END()
 	}
 };
 
-static struct unit_test_suite cryptodev_octeontx_asym_testsuite  = {
-	.suite_name = "Crypto Device OCTEONTX ASYM Unit Test Suite",
-	.setup = testsuite_setup,
-	.teardown = testsuite_teardown,
+static struct unit_test_suite cryptodev_asym_sm2_testsuite = {
+	.suite_name = "Cryptodev ASYM SM2 Unit Test Suite",
+	.setup = crypto_asym_sm2_testsuite_setup,
 	.unit_test_cases = {
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_capability),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_enc_dec_crt),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_sign_verify_crt),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_rsa_enc_dec),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_sign_verify),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mod_exp),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex test for zero padding",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_test_cases[0]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex test for zero padding (2)",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_test_cases[1]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 5 test",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[0]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 14 test",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[1]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 15 test",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[2]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 16 test",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[3]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 17 test",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[4]),
-		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 18 test",
-			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[5]),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_sign),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_verify),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_enc),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_dec),
 		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 24 test",
+			"SM2 encryption - test case 1",
 			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[6]),
+			test_sm2_partial_encryption, &sm2_enc_hw_t1),
 		TEST_CASE_NAMED_WITH_DATA(
-			"Modex Group 24 subgroup test",
+			"SM2 decryption - test case 1",
 			ut_setup_asym, ut_teardown_asym,
-			modular_exponentiation, &modex_group_test_cases[7]),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-			     test_ecdsa_sign_verify_all_curve),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_sign),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_sm2_verify),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_ecdh_all_curve),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_ecpm_all_curve),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_eddsa_sign_verify_all_curve),
+			test_sm2_partial_decryption, &sm2_enc_hw_t1),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_ml_kem_testsuite = {
+	.suite_name = "Cryptodev ASYM ML KEM Unit Test Suite",
+	.setup = crypto_asym_ml_kem_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mlkem_keygen),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mlkem_encap),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mlkem_decap),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_asym_ml_dsa_testsuite = {
+	.suite_name = "Cryptodev ASYM ML DSA Unit Test Suite",
+	.setup = crypto_asym_ml_dsa_testsuite_setup,
+	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mldsa_keygen),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mldsa_sign),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mldsa_verify),
-		TEST_CASES_END() /**< NULL terminate unit test array */
+		TEST_CASES_END()
 	}
 };
 
-static struct unit_test_suite cryptodev_virtio_asym_testsuite  = {
-	.suite_name = "Crypto Device VIRTIO ASYM Unit Test Suite",
-	.setup = testsuite_setup,
-	.teardown = testsuite_teardown,
-	.unit_test_cases = {
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_capability),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
-				test_rsa_sign_verify_crt),
-		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_rsa_enc_dec_crt),
-		TEST_CASES_END() /**< NULL terminate unit test array */
-	}
+static struct unit_test_suite end_testsuite = {
+	.suite_name = NULL,
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_suites = NULL
 };
 
 static int
-test_cryptodev_openssl_asym(void)
+run_cryptodev_asym_testsuite(const char *pmd_name)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_OPENSSL_PMD));
-
+	uint8_t ret, j, i = 0;
+
+	struct unit_test_suite *asym_suites[] = {
+		&cryptodev_asym_gen_testsuite,
+		&cryptodev_asym_dh_testsuite,
+		&cryptodev_asym_dsa_testsuite,
+		&cryptodev_asym_ecdh_testsuite,
+		&cryptodev_asym_ecdsa_testsuite,
+		&cryptodev_asym_ecpm_testsuite,
+		&cryptodev_asym_eddsa_testsuite,
+		&cryptodev_asym_mod_ex_testsuite,
+		&cryptodev_asym_mod_inv_testsuite,
+		&cryptodev_asym_rsa_testsuite,
+		&cryptodev_asym_sm2_testsuite,
+		&cryptodev_asym_ml_kem_testsuite,
+		&cryptodev_asym_ml_dsa_testsuite,
+		&end_testsuite
+	};
+
+	static struct unit_test_suite asym_ts = {
+		.suite_name = "Cryptodev ASYM Unit Test Suite",
+		.setup = testsuite_setup,
+		.teardown = testsuite_teardown,
+		.unit_test_cases = {TEST_CASES_END()}
+	};
+
+	gbl_driver_id = rte_cryptodev_driver_id_get(pmd_name);
 	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "OPENSSL PMD must be loaded.\n");
+		RTE_LOG(ERR, USER1, "%s PMD must be loaded.\n", pmd_name);
 		return TEST_SKIPPED;
 	}
 
-	return unit_test_suite_runner(&cryptodev_openssl_asym_testsuite);
+	asym_ts.unit_test_suites = malloc(sizeof(struct unit_test_suite *) * RTE_DIM(asym_suites));
+	if (asym_ts.unit_test_suites == NULL) {
+		RTE_LOG(ERR, USER1,
+			"Failed to allocate memory for unit test suites\n");
+		return TEST_FAILED;
+	}
+
+	ADD_ASYM_TESTSUITE(i, asym_ts, asym_suites, RTE_DIM(asym_suites));
+	ret = unit_test_suite_runner(&asym_ts);
+
+	free(asym_ts.unit_test_suites);
+
+	return ret;
 }
 
 static int
-test_cryptodev_qat_asym(void)
+test_cryptodev_openssl_asym(void)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_QAT_ASYM_PMD));
-
-	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "QAT PMD must be loaded.\n");
-		return TEST_SKIPPED;
-	}
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_OPENSSL_PMD));
+}
 
-	return unit_test_suite_runner(&cryptodev_qat_asym_testsuite);
+static int
+test_cryptodev_qat_asym(void)
+{
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_QAT_ASYM_PMD));
 }
 
 static int
 test_cryptodev_octeontx_asym(void)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_OCTEONTX_SYM_PMD));
-	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "OCTEONTX PMD must be loaded.\n");
-		return TEST_SKIPPED;
-	}
-	return unit_test_suite_runner(&cryptodev_octeontx_asym_testsuite);
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_OCTEONTX_SYM_PMD));
 }
 
 static int
 test_cryptodev_cn9k_asym(void)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_CN9K_PMD));
-	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "CN9K PMD must be loaded.\n");
-		return TEST_SKIPPED;
-	}
-
-	/* Use test suite registered for crypto_octeontx PMD */
-	return unit_test_suite_runner(&cryptodev_octeontx_asym_testsuite);
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_CN9K_PMD));
 }
 
 static int
 test_cryptodev_cn10k_asym(void)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_CN10K_PMD));
-	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "CN10K PMD must be loaded.\n");
-		return TEST_SKIPPED;
-	}
-
-	/* Use test suite registered for crypto_octeontx PMD */
-	return unit_test_suite_runner(&cryptodev_octeontx_asym_testsuite);
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_CN10K_PMD));
 }
 
 static int
 test_cryptodev_virtio_asym(void)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_VIRTIO_PMD));
-	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "virtio PMD must be loaded.\n");
-		return TEST_SKIPPED;
-	}
-
-	/* Use test suite registered for crypto_virtio PMD */
-	return unit_test_suite_runner(&cryptodev_virtio_asym_testsuite);
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_VIRTIO_PMD));
 }
 
 static int
 test_cryptodev_virtio_user_asym(void)
 {
-	gbl_driver_id = rte_cryptodev_driver_id_get(
-			RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
-	if (gbl_driver_id == -1) {
-		RTE_LOG(ERR, USER1, "virtio user PMD must be loaded.\n");
-		return TEST_SKIPPED;
-	}
-
-	/* Use test suite registered for crypto_virtio_user PMD */
-	return unit_test_suite_runner(&cryptodev_virtio_asym_testsuite);
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
 }
 
 REGISTER_DRIVER_TEST(cryptodev_openssl_asym_autotest, test_cryptodev_openssl_asym);
-- 
2.48.1

