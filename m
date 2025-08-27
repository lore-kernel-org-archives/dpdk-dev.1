Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E376C8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31F7140611;
	Wed, 27 Aug 2025 11:24:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id EFC0D4028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 11:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756286646; x=1787822646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mRp+sd9Bg7IxdFUNh62mnIPuhOXIVIy45nJwDQ/dz78=;
 b=BTsn/02rkAgRP+cRDPY8oGtUCTlLIxFbdjukdrfVpPt+O+IKlRQoVWUC
 vMw/92+RLLO9xexWB3s3v2gkXW1Jrb19Ca9Z61QN1/pJ+PZ3zGRCYUAOh
 fRUGwq/ogt9riWuf88SX+eAjIJlit9ObVOxd7yopheRttri5KiXJJXE3s
 S9Imk95Z/qTo8zSwvMWAQYDDA4KjA5B5TGd2SSPgzzh4Ks6ZjflPgS9J5
 kkSLK+V/KJCp1BX+NsueFu6ySvamPJZXR+4iMW1h11TOq87/5PpvoLPVE
 OvRzDURYQLv+PYpqPDeqDbDbzZy9YOaVFpMq01G10gE3+Hkr9gpQc2VWB w==;
X-CSE-ConnectionGUID: zb2I8BowTGqJQQSMXN2TGA==
X-CSE-MsgGUID: Hgqo4AZCTR6M09FeAuU5Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58468879"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58468879"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 02:24:05 -0700
X-CSE-ConnectionGUID: cWjBqS9wT0CQz3UWSKBW5A==
X-CSE-MsgGUID: slqGpb0dQoqkJDZd8p5uRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169400206"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 02:24:03 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 2/3] test/crypto: add QAT EC tests
Date: Wed, 27 Aug 2025 09:23:57 +0000
Message-ID: <20250827092358.765222-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827092358.765222-1-radu.nicolau@intel.com>
References: <20250827092358.765222-1-radu.nicolau@intel.com>
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

Add ECDH, ECPM and ECDSA tests for QAT

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev_asym.c | 109 +++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 20afb5e98b..c62329edff 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -1715,6 +1715,29 @@ test_ecdsa_sign_verify_all_curve(void)
 	return overall_status;
 }
 
+static int
+test_ecdsa_sign_verify_qat_curves(void)
+{
+	int status, overall_status = TEST_SUCCESS;
+	enum curve curve_id;
+	int test_index = 0;
+	const char *msg;
+
+	for (curve_id = SECP256R1; curve_id <= SECP521R1; curve_id++) {
+
+		status = test_ecdsa_sign_verify(curve_id);
+		if (status == TEST_SUCCESS) {
+			msg = "succeeded";
+		} else {
+			msg = "failed";
+			overall_status = status;
+		}
+		printf("  %u) TestCase Sign/Veriy Curve %s  %s\n",
+		       test_index ++, curve[curve_id], msg);
+	}
+	return overall_status;
+}
+
 static int
 test_ecpm(enum curve curve_id)
 {
@@ -1881,6 +1904,28 @@ test_ecpm_all_curve(void)
 	return overall_status;
 }
 
+static int
+test_ecpm_qat_curves(void)
+{
+	int status, overall_status = TEST_SUCCESS;
+	enum curve curve_id;
+	int test_index = 0;
+	const char *msg;
+
+	for (curve_id = SECP256R1; curve_id <= SECP521R1; curve_id++) {
+		status = test_ecpm(curve_id);
+		if (status == TEST_SUCCESS) {
+			msg = "succeeded";
+		} else {
+			msg = "failed";
+			overall_status = status;
+		}
+		printf("  %u) TestCase EC Point Mul Curve %s  %s\n",
+		       test_index ++, curve[curve_id], msg);
+	}
+	return overall_status;
+}
+
 static int
 test_ecdh_priv_key_generate(enum curve curve_id)
 {
@@ -2674,6 +2719,56 @@ test_ecdh_all_curve(void)
 	return overall_status;
 }
 
+static int
+test_ecdh_qat_curves(void)
+{
+	int status, overall_status = TEST_SUCCESS;
+	enum curve curve_id;
+	int test_index = 0;
+	const char *msg;
+
+	for (curve_id = SECP256R1; curve_id <= SECP521R1; curve_id++) {
+		status = test_ecdh_pub_key_generate(curve_id);
+		if (status == TEST_SUCCESS) {
+			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
+		} else {
+			msg = "failed";
+			overall_status = status;
+		}
+		printf("  %u) TestCase ECDH public key generation for Curve %s %s\n",
+		       test_index ++, curve[curve_id], msg);
+	}
+
+	for (curve_id = SECP256R1; curve_id <= SECP521R1; curve_id++) {
+		status = test_ecdh_pub_key_verify(curve_id);
+		if (status == TEST_SUCCESS) {
+			msg = "succeeded";
+		} else {
+			msg = "failed";
+			overall_status = status;
+		}
+		printf("  %u) TestCase ECDH public key verification for Curve %s %s\n",
+		       test_index ++, curve[curve_id], msg);
+	}
+
+	for (curve_id = SECP256R1; curve_id <= SECP521R1; curve_id++) {
+		status = test_ecdh_shared_secret(curve_id);
+		if (status == TEST_SUCCESS) {
+			msg = "succeeded";
+		} else {
+			msg = "failed";
+			overall_status = status;
+		}
+		printf("  %u) TestCase ECDH shared secret compute for Curve %s %s\n",
+		       test_index ++, curve[curve_id], msg);
+	}
+
+	return overall_status;
+}
+
+
 static int
 test_sm2_sign(void)
 {
@@ -3987,6 +4082,7 @@ static struct unit_test_suite cryptodev_openssl_asym_testsuite  = {
 			ut_setup_asym, ut_teardown_asym,
 			modular_exponentiation, &modex_group_test_cases[7]),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_eddsa_sign_verify_all_curve),
+
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
@@ -4023,6 +4119,19 @@ static struct unit_test_suite cryptodev_qat_asym_testsuite  = {
 			"RSA Decryption (n=128, pt=20, e=3) CRT, Padding: NONE",
 			ut_setup_asym, ut_teardown_asym,
 			kat_rsa_decrypt_crt, &rsa_vector_128_20_3_none),
+		TEST_CASE_NAMED_ST(
+			"ECDH Eliptic Curve tests",
+			ut_setup_asym, ut_teardown_asym,
+			test_ecdh_qat_curves),
+		TEST_CASE_NAMED_ST(
+			"ECPM Eliptic Curve tests",
+			ut_setup_asym, ut_teardown_asym,
+			test_ecpm_qat_curves),
+		TEST_CASE_NAMED_ST(
+			"ECDSA Eliptic Curve tests",
+			ut_setup_asym, ut_teardown_asym,
+			test_ecdsa_sign_verify_qat_curves),
+
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
-- 
2.50.1

