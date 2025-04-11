Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B2C369A8
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 10:14:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F306A40B9B;
	Fri, 11 Apr 2025 12:14:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7630540B9F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366475; x=1775902475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0t8WG+z/L/g+2k7at9cEiy3rH+grZSjn0EUkRNHajSM=;
 b=fsjwggEVEdeZ+RJSq4HeZVnOgP3o377KREjn5/nHggAelbtyjid8Eo/z
 WPvJocRZx9t2bb/0WBa3T+MmpGoRwWvCuVPedAwD+i04B15P/MXB1fUyQ
 SewAeJkBZT2sW7nZa1zg3FM6V1hcpybztgaby1f2T75bbM2Nzou9YW757
 8Gt4MNIBrjN93PF22ouO+DTDMHKXTtjdtQ283SxoU6o18A4X1TuH/cxoB
 SYnQWHzwIOqETkGth2HYRdVAcTJQ78Nvl0qXa5b2TMltkA5uk9IVfGEWV
 WIaADoI1Us/vMvQe/qkROOA4gJ9WwDeOEGEWpugcp86w/Ix/B2IGvLmjI Q==;
X-CSE-ConnectionGUID: ADzs//MEQjiW19TzCL2afQ==
X-CSE-MsgGUID: 0jIkg73OR9Ks5lw9RXDCNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56896774"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56896774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:14:35 -0700
X-CSE-ConnectionGUID: wBvHIOAxRfWYRjoNK/BMNA==
X-CSE-MsgGUID: Wurb3/WQRE2LB1Q19X4AZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="160130595"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa002.jf.intel.com with ESMTP; 11 Apr 2025 03:14:33 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 3/5] tests: add unit tests and test vectors for SNOW-V
Date: Fri, 11 Apr 2025 11:09:39 +0100
Message-ID: <20250411101425.3041736-4-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411101425.3041736-1-radu.nicolau@intel.com>
References: <20250411101425.3041736-1-radu.nicolau@intel.com>
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

Add unit tests and test vectors for SNOW-V and SNOW-V AEAD.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c                     | 599 ++++++++++++++++++
 app/test/test_cryptodev_aead_test_vectors.h   | 275 ++++++++
 app/test/test_cryptodev_snow_v_test_vectors.h | 213 +++++++
 3 files changed, 1087 insertions(+)
 create mode 100644 app/test/test_cryptodev_snow_v_test_vectors.h

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 31a4905a97..4a95d1fce9 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -43,6 +43,7 @@
 #include "test_cryptodev_kasumi_hash_test_vectors.h"
 #include "test_cryptodev_snow3g_test_vectors.h"
 #include "test_cryptodev_snow3g_hash_test_vectors.h"
+#include "test_cryptodev_snow_v_test_vectors.h"
 #include "test_cryptodev_zuc_test_vectors.h"
 #include "test_cryptodev_aead_test_vectors.h"
 #include "test_cryptodev_hmac_test_vectors.h"
@@ -1205,6 +1206,60 @@ snow3g_testsuite_setup(void)
 	return 0;
 }
 
+static int
+snow_v_testsuite_setup(void)
+{
+	struct crypto_testsuite_params *ts_params = &testsuite_params;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_cryptodev_info dev_info;
+	const enum rte_crypto_cipher_algorithm ciphers[] = {
+		RTE_CRYPTO_CIPHER_SNOW_V,
+	};
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+
+	if (!(dev_info.feature_flags & RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO)) {
+		RTE_LOG(INFO, USER1, "Feature flag requirements for SNOW V "
+				"testsuite not met\n");
+		return TEST_SKIPPED;
+	}
+
+	if (check_cipher_capabilities_supported(ciphers, RTE_DIM(ciphers)) != 0) {
+		RTE_LOG(INFO, USER1, "Capability requirements for SNOW V "
+				"testsuite not met\n");
+		return TEST_SKIPPED;
+	}
+
+	return 0;
+}
+
+static int
+snow_v_aead_testsuite_setup(void)
+{
+	struct crypto_testsuite_params *ts_params = &testsuite_params;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_cryptodev_info dev_info;
+	const enum rte_crypto_aead_algorithm aeads[] = {
+		RTE_CRYPTO_AEAD_SNOW_V,
+	};
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+
+	if (!(dev_info.feature_flags & RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO)) {
+		RTE_LOG(INFO, USER1, "Feature flag requirements for SNOW V AEAD "
+				"testsuite not met\n");
+		return TEST_SKIPPED;
+	}
+
+	if (check_aead_capabilities_supported(aeads, RTE_DIM(aeads)) != 0) {
+		RTE_LOG(INFO, USER1, "Capability requirements for SNOW V AEAD "
+				"testsuite not met\n");
+		return TEST_SKIPPED;
+	}
+
+	return 0;
+}
+
 static int
 zuc_testsuite_setup(void)
 {
@@ -8294,6 +8349,395 @@ test_zuc256_auth_cipher_verify_16b_tag_test_case_1(void)
 		&zuc256_auth_cipher_test_case_4, IN_PLACE, 1);
 }
 
+static int
+test_snow_v_encryption(const struct snow_v_test_data *tdata,
+	uint8_t mode, uint8_t sgl_in, uint8_t sgl_out)
+{
+	struct crypto_testsuite_params *ts_params = &testsuite_params;
+	struct crypto_unittest_params *ut_params = &unittest_params;
+
+	int retval;
+	unsigned int plaintext_pad_len;
+	unsigned int plaintext_len;
+	uint8_t buffer[10000];
+	const uint8_t *ciphertext;
+
+	struct rte_cryptodev_info dev_info;
+
+	/* Verify the capabilities */
+	struct rte_cryptodev_sym_capability_idx cap_idx;
+	cap_idx.type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+	cap_idx.algo.cipher = RTE_CRYPTO_CIPHER_SNOW3G_UEA2;
+	if (rte_cryptodev_sym_capability_get(ts_params->valid_devs[0],
+			&cap_idx) == NULL)
+		return TEST_SKIPPED;
+
+	if (global_api_test_type == CRYPTODEV_RAW_API_TEST)
+		return TEST_SKIPPED;
+
+	if (gbl_action_type == RTE_SECURITY_ACTION_TYPE_CPU_CRYPTO)
+		return TEST_SKIPPED;
+
+	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
+
+	uint64_t feat_flags = dev_info.feature_flags;
+
+	if (((sgl_in && sgl_out) && !(feat_flags & RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT))
+			|| ((!sgl_in && sgl_out) &&
+			!(feat_flags & RTE_CRYPTODEV_FF_OOP_LB_IN_SGL_OUT))
+			|| ((sgl_in && !sgl_out) &&
+			!(feat_flags & RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT))) {
+		printf("Device doesn't support out-of-place scatter gather type. "
+				"Test Skipped.\n");
+		return TEST_SKIPPED;
+	}
+
+	if ((global_api_test_type == CRYPTODEV_RAW_API_TEST) &&
+			(!(feat_flags & RTE_CRYPTODEV_FF_SYM_RAW_DP))) {
+		printf("Device does not support RAW data-path APIs.\n");
+		return -ENOTSUP;
+	}
+
+	/* Create SNOW V session */
+	retval = create_wireless_algo_cipher_session(ts_params->valid_devs[0],
+					RTE_CRYPTO_CIPHER_OP_ENCRYPT,
+					RTE_CRYPTO_CIPHER_SNOW_V,
+					tdata->key.data, tdata->key.len,
+					tdata->cipher_iv.len);
+	if (retval < 0)
+		return retval;
+
+	plaintext_len = ceil_byte_length(tdata->plaintext.len);
+	/* Append data which is padded to a multiple of */
+	/* the algorithms block size */
+	plaintext_pad_len = RTE_ALIGN_CEIL(plaintext_len, 16);
+
+	if (sgl_in)
+		ut_params->ibuf = create_segmented_mbuf(ts_params->mbuf_pool,
+				plaintext_pad_len, 10, 0);
+	else {
+		ut_params->ibuf = rte_pktmbuf_alloc(ts_params->mbuf_pool);
+		rte_pktmbuf_append(ut_params->ibuf, plaintext_pad_len);
+	}
+	TEST_ASSERT_NOT_NULL(ut_params->ibuf,
+		"Failed to allocate input buffer in mempool");
+
+	if (mode == OUT_OF_PLACE) {
+		if (sgl_out)
+			ut_params->obuf = create_segmented_mbuf(ts_params->mbuf_pool,
+					plaintext_pad_len, 3, 0);
+		else {
+			ut_params->obuf = rte_pktmbuf_alloc(ts_params->mbuf_pool);
+			rte_pktmbuf_append(ut_params->obuf, plaintext_pad_len);
+		}
+		TEST_ASSERT_NOT_NULL(ut_params->obuf,
+			"Failed to allocate output buffer in mempool");
+	}
+
+	pktmbuf_write(ut_params->ibuf, 0, plaintext_len, tdata->plaintext.data);
+
+	/* Create SNOW V operation */
+	if (mode == OUT_OF_PLACE) {
+		retval = create_wireless_algo_cipher_operation_oop(tdata->cipher_iv.data,
+						tdata->cipher_iv.len,
+						tdata->ciphertext.len,
+						0);
+		if (retval < 0)
+			return retval;
+	} else {
+		retval = create_wireless_algo_cipher_operation(tdata->cipher_iv.data,
+			tdata->cipher_iv.len,
+			tdata->ciphertext.len,
+			0);
+		if (retval < 0)
+			return retval;
+	}
+
+	if (global_api_test_type == CRYPTODEV_RAW_API_TEST) {
+		retval = process_sym_raw_dp_op(ts_params->valid_devs[0], 0, ut_params->op, 1, 0, 1,
+					       tdata->cipher_iv.len);
+		if (retval != TEST_SUCCESS)
+			return retval;
+	} else
+		ut_params->op = process_crypto_request(ts_params->valid_devs[0],
+						ut_params->op);
+	TEST_ASSERT_NOT_NULL(ut_params->op, "failed to retrieve obuf");
+
+	ut_params->obuf = ut_params->op->sym->m_dst;
+	if (ut_params->obuf)
+		ciphertext = rte_pktmbuf_read(ut_params->obuf, 0,
+				plaintext_len, buffer);
+	else
+		ciphertext = rte_pktmbuf_read(ut_params->ibuf, 0,
+				plaintext_len, buffer);
+
+	debug_hexdump(stdout, "ciphertext:", ciphertext, plaintext_len);
+
+	/* Validate obuf */
+	TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(
+		ciphertext,
+		tdata->ciphertext.data,
+		tdata->ciphertext.len,
+		"SNOW V Ciphertext data not as expected");
+
+	return 0;
+}
+
+static int
+test_snow_v_decryption(const struct snow_v_test_data *tdata,
+	uint8_t mode, uint8_t sgl_in, uint8_t sgl_out)
+{
+	struct crypto_testsuite_params *ts_params = &testsuite_params;
+	struct crypto_unittest_params *ut_params = &unittest_params;
+
+	int retval;
+	unsigned int ciphertext_pad_len;
+	unsigned int ciphertext_len;
+	uint8_t buffer[10000];
+	const uint8_t *plaintext;
+
+	struct rte_cryptodev_info dev_info;
+
+	/* Verify the capabilities */
+	struct rte_cryptodev_sym_capability_idx cap_idx;
+	cap_idx.type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+	cap_idx.algo.cipher = RTE_CRYPTO_CIPHER_SNOW3G_UEA2;
+	if (rte_cryptodev_sym_capability_get(ts_params->valid_devs[0],
+			&cap_idx) == NULL)
+		return TEST_SKIPPED;
+
+	if (global_api_test_type == CRYPTODEV_RAW_API_TEST)
+		return TEST_SKIPPED;
+
+	if (gbl_action_type == RTE_SECURITY_ACTION_TYPE_CPU_CRYPTO)
+		return TEST_SKIPPED;
+
+	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
+
+	uint64_t feat_flags = dev_info.feature_flags;
+
+	if (((sgl_in && sgl_out) && !(feat_flags & RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT))
+			|| ((!sgl_in && sgl_out) &&
+			!(feat_flags & RTE_CRYPTODEV_FF_OOP_LB_IN_SGL_OUT))
+			|| ((sgl_in && !sgl_out) &&
+			!(feat_flags & RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT))) {
+		printf("Device doesn't support out-of-place scatter gather type. "
+				"Test Skipped.\n");
+		return TEST_SKIPPED;
+	}
+
+	if ((global_api_test_type == CRYPTODEV_RAW_API_TEST) &&
+			(!(feat_flags & RTE_CRYPTODEV_FF_SYM_RAW_DP))) {
+		printf("Device does not support RAW data-path APIs.\n");
+		return -ENOTSUP;
+	}
+
+	/* Create SNOW V session */
+	retval = create_wireless_algo_cipher_session(ts_params->valid_devs[0],
+					RTE_CRYPTO_CIPHER_OP_DECRYPT,
+					RTE_CRYPTO_CIPHER_SNOW_V,
+					tdata->key.data, tdata->key.len,
+					tdata->cipher_iv.len);
+	if (retval < 0)
+		return retval;
+
+	ciphertext_len = ceil_byte_length(tdata->ciphertext.len);
+	/* Append data which is padded to a multiple of */
+	/* the algorithms block size */
+	ciphertext_pad_len = RTE_ALIGN_CEIL(ciphertext_len, 16);
+
+	if (sgl_in)
+		ut_params->ibuf = create_segmented_mbuf(ts_params->mbuf_pool,
+				ciphertext_pad_len, 10, 0);
+	else {
+		ut_params->ibuf = rte_pktmbuf_alloc(ts_params->mbuf_pool);
+		rte_pktmbuf_append(ut_params->ibuf, ciphertext_pad_len);
+	}
+	TEST_ASSERT_NOT_NULL(ut_params->ibuf,
+		"Failed to allocate input buffer in mempool");
+
+	if (mode == OUT_OF_PLACE) {
+		if (sgl_out)
+			ut_params->obuf = create_segmented_mbuf(ts_params->mbuf_pool,
+					ciphertext_pad_len, 3, 0);
+		else {
+			ut_params->obuf = rte_pktmbuf_alloc(ts_params->mbuf_pool);
+			rte_pktmbuf_append(ut_params->obuf, ciphertext_pad_len);
+		}
+		TEST_ASSERT_NOT_NULL(ut_params->obuf,
+			"Failed to allocate output buffer in mempool");
+	}
+
+	pktmbuf_write(ut_params->ibuf, 0, ciphertext_len, tdata->ciphertext.data);
+
+	/* Create SNOW V operation */
+	if (mode == OUT_OF_PLACE) {
+		retval = create_wireless_algo_cipher_operation_oop(tdata->cipher_iv.data,
+						tdata->cipher_iv.len,
+						tdata->ciphertext.len,
+						0);
+		if (retval < 0)
+			return retval;
+	} else {
+		retval = create_wireless_algo_cipher_operation(tdata->cipher_iv.data,
+			tdata->cipher_iv.len,
+			tdata->ciphertext.len,
+			0);
+		if (retval < 0)
+			return retval;
+	}
+
+	if (global_api_test_type == CRYPTODEV_RAW_API_TEST) {
+		retval = process_sym_raw_dp_op(ts_params->valid_devs[0], 0, ut_params->op, 1, 0, 1,
+					       tdata->cipher_iv.len);
+		if (retval != TEST_SUCCESS)
+			return retval;
+	} else
+		ut_params->op = process_crypto_request(ts_params->valid_devs[0],
+						ut_params->op);
+	TEST_ASSERT_NOT_NULL(ut_params->op, "failed to retrieve obuf");
+
+	ut_params->obuf = ut_params->op->sym->m_dst;
+	if (ut_params->obuf)
+		plaintext = rte_pktmbuf_read(ut_params->obuf, 0,
+				ciphertext_len, buffer);
+	else
+		plaintext = rte_pktmbuf_read(ut_params->ibuf, 0,
+				ciphertext_len, buffer);
+
+	debug_hexdump(stdout, "plaintext:", plaintext, ciphertext_len);
+
+	/* Validate obuf */
+	TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(
+		plaintext,
+		tdata->plaintext.data,
+		tdata->plaintext.len,
+		"SNOW V Plaintext data not as expected");
+
+	return 0;
+}
+
+static int
+test_snow_v_encryption_test_case_1(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_1, IN_PLACE, 0, 0);
+}
+static int
+test_snow_v_encryption_test_case_1_oop(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_1, OUT_OF_PLACE, 0, 0);
+}
+static int
+test_snow_v_encryption_test_case_1_sgl(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_1, IN_PLACE, 1, 1);
+}
+static int
+test_snow_v_encryption_test_case_1_oop_sgl(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_1, OUT_OF_PLACE, 1, 1);
+}
+static int
+test_snow_v_encryption_test_case_2(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_2, IN_PLACE, 0, 0);
+}
+static int
+test_snow_v_encryption_test_case_2_oop(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_2, OUT_OF_PLACE, 0, 0);
+}
+static int
+test_snow_v_encryption_test_case_2_sgl(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_2, IN_PLACE, 1, 1);
+}
+static int
+test_snow_v_encryption_test_case_2_oop_sgl(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_2, OUT_OF_PLACE, 1, 1);
+}
+static int
+test_snow_v_encryption_test_case_3(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_3, IN_PLACE, 0, 0);
+}
+static int
+test_snow_v_encryption_test_case_3_oop(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_3, OUT_OF_PLACE, 0, 0);
+}
+static int
+test_snow_v_encryption_test_case_3_sgl(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_3, IN_PLACE, 1, 1);
+}
+static int
+test_snow_v_encryption_test_case_3_oop_sgl(void)
+{
+	return test_snow_v_encryption(&snow_v_test_case_3, OUT_OF_PLACE, 1, 1);
+}
+static int
+test_snow_v_decryption_test_case_1(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_1, IN_PLACE, 0, 0);
+}
+static int
+test_snow_v_decryption_test_case_1_oop(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_1, OUT_OF_PLACE, 0, 0);
+}
+static int
+test_snow_v_decryption_test_case_1_sgl(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_1, IN_PLACE, 1, 1);
+}
+static int
+test_snow_v_decryption_test_case_1_oop_sgl(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_1, OUT_OF_PLACE, 1, 1);
+}
+static int
+test_snow_v_decryption_test_case_2(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_2, IN_PLACE, 0, 0);
+}
+static int
+test_snow_v_decryption_test_case_2_oop(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_2, OUT_OF_PLACE, 0, 0);
+}
+static int
+test_snow_v_decryption_test_case_2_sgl(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_2, IN_PLACE, 1, 1);
+}
+static int
+test_snow_v_decryption_test_case_2_oop_sgl(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_2, OUT_OF_PLACE, 1, 1);
+}
+static int
+test_snow_v_decryption_test_case_3(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_3, IN_PLACE, 0, 0);
+}
+static int
+test_snow_v_decryption_test_case_3_oop(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_3, OUT_OF_PLACE, 0, 0);
+}
+static int
+test_snow_v_decryption_test_case_3_sgl(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_3, IN_PLACE, 1, 1);
+}
+static int
+test_snow_v_decryption_test_case_3_oop_sgl(void)
+{
+	return test_snow_v_decryption(&snow_v_test_case_3, OUT_OF_PLACE, 1, 1);
+}
+
 static int
 test_mixed_check_if_unsupported(const struct mixed_cipher_auth_test_data *tdata)
 {
@@ -17652,6 +18096,66 @@ test_SM4_GCM_case_15(void)
 	return test_authenticated_encryption(&sm4_gcm_case_15);
 }
 
+static int
+test_snow_v_aead_enc_test_case_1(void)
+{
+	return test_authenticated_encryption(&snow_v_aead_case_1);
+}
+static int
+test_snow_v_aead_enc_test_case_2(void)
+{
+	return test_authenticated_encryption(&snow_v_aead_case_2);
+}
+static int
+test_snow_v_aead_enc_test_case_3(void)
+{
+	return test_authenticated_encryption(&snow_v_aead_case_3);
+}
+static int
+test_snow_v_aead_enc_test_case_4(void)
+{
+	return test_authenticated_encryption(&snow_v_aead_case_4);
+}
+static int
+test_snow_v_aead_enc_test_case_5(void)
+{
+	return test_authenticated_encryption(&snow_v_aead_case_5);
+}
+static int
+test_snow_v_aead_enc_test_case_6(void)
+{
+	return test_authenticated_encryption(&snow_v_aead_case_6);
+}
+static int
+test_snow_v_aead_dec_test_case_1(void)
+{
+	return test_authenticated_decryption(&snow_v_aead_case_1);
+}
+static int
+test_snow_v_aead_dec_test_case_2(void)
+{
+	return test_authenticated_decryption(&snow_v_aead_case_2);
+}
+static int
+test_snow_v_aead_dec_test_case_3(void)
+{
+	return test_authenticated_decryption(&snow_v_aead_case_3);
+}
+static int
+test_snow_v_aead_dec_test_case_4(void)
+{
+	return test_authenticated_decryption(&snow_v_aead_case_4);
+}
+static int
+test_snow_v_aead_dec_test_case_5(void)
+{
+	return test_authenticated_decryption(&snow_v_aead_case_5);
+}
+static int
+test_snow_v_aead_dec_test_case_6(void)
+{
+	return test_authenticated_decryption(&snow_v_aead_case_6);
+}
 #ifdef RTE_CRYPTO_SCHEDULER
 
 /* global AESNI worker IDs for the scheduler test */
@@ -19300,6 +19804,98 @@ static struct unit_test_suite cryptodev_snow3g_testsuite  = {
 	}
 };
 
+static struct unit_test_suite cryptodev_snow_v_testsuite  = {
+	.suite_name = "SNOW V Test Suite",
+	.setup = snow_v_testsuite_setup,
+	.unit_test_cases = {
+		/** SNOW V encrypt only */
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_1),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_1_oop),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_1_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_1_oop_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_2),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_2_oop),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_2_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_2_oop_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_3_oop),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_3_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_encryption_test_case_3_oop_sgl),
+		/** SNOW V decrypt only */
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_1),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_1_oop),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_1_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_1_oop_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_2),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_2_oop),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_2_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_2_oop_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_3_oop),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_3_sgl),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_decryption_test_case_3_oop_sgl),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite cryptodev_snow_v_aead_testsuite  = {
+	.suite_name = "SNOW V AEAD Test Suite",
+	.setup = snow_v_aead_testsuite_setup,
+	.unit_test_cases = {
+		/** SNOW V AEAD Encryption Tests */
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_enc_test_case_1),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_enc_test_case_2),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_enc_test_case_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_enc_test_case_4),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_enc_test_case_5),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_enc_test_case_6),
+		/** SNOW V AEAD Decryption Tests */
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_dec_test_case_1),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_dec_test_case_2),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_dec_test_case_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_dec_test_case_4),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_dec_test_case_5),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_snow_v_aead_dec_test_case_6),
+		TEST_CASES_END()
+	}
+};
+
 static struct unit_test_suite cryptodev_zuc_testsuite  = {
 	.suite_name = "ZUC Test Suite",
 	.setup = zuc_testsuite_setup,
@@ -19820,6 +20416,8 @@ run_cryptodev_testsuite(const char *pmd_name)
 		&cryptodev_aes_gcm_auth_testsuite,
 		&cryptodev_aes_gmac_auth_testsuite,
 		&cryptodev_snow3g_testsuite,
+		&cryptodev_snow_v_testsuite,
+		&cryptodev_snow_v_aead_testsuite,
 		&cryptodev_chacha20_poly1305_testsuite,
 		&cryptodev_zuc_testsuite,
 		&cryptodev_hmac_md5_auth_testsuite,
@@ -19839,6 +20437,7 @@ run_cryptodev_testsuite(const char *pmd_name)
 		&dtls12_record_proto_testsuite,
 		&tls13_record_proto_testsuite,
 #endif
+
 		&end_testsuite
 	};
 	static struct unit_test_suite ts = {
diff --git a/app/test/test_cryptodev_aead_test_vectors.h b/app/test/test_cryptodev_aead_test_vectors.h
index 73bedaf557..d46f58e78e 100644
--- a/app/test/test_cryptodev_aead_test_vectors.h
+++ b/app/test/test_cryptodev_aead_test_vectors.h
@@ -4828,4 +4828,279 @@ static const struct aead_test_data sm4_gcm_case_15 = {
 	}
 };
 
+
+
+/*
+ * SNOW-V AEAD test vector 1
+ */
+static const struct aead_test_data snow_v_aead_case_1 = {
+	.algo = RTE_CRYPTO_AEAD_SNOW_V,
+	.key = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 32
+	},
+	.iv = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 16
+	},
+	.aad = {
+		.data = 0,
+		.len = 0
+	},
+	.plaintext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.ciphertext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.auth_tag = {
+		.data = {
+			0x02, 0x9a, 0x62, 0x4c, 0xda, 0xa4, 0xd4, 0x6c, 0xb9,
+			0xa0, 0xef, 0x40, 0x46, 0x95, 0x6c, 0x9f
+		},
+		.len = 16
+	}
+};
+
+
+/*
+ * SNOW-V AEAD test vector 2
+ */
+static const struct aead_test_data snow_v_aead_case_2 = {
+	.algo = RTE_CRYPTO_AEAD_SNOW_V,
+	.key = {
+		.data = {
+			0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+			0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+			0x0a, 0x1a, 0x2a, 0x3a, 0x4a, 0x5a, 0x6a, 0x7a,
+			0x8a, 0x9a, 0xaa, 0xba, 0xca, 0xda, 0xea, 0xfa
+		},
+		.len = 32
+	},
+	.iv = {
+		.data = {
+			0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+			0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
+		},
+		.len = 16
+	},
+	.aad = {
+		.data = 0,
+		.len = 0
+	},
+	.plaintext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.ciphertext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.auth_tag = {
+		.data = {
+			0xfc, 0x7c, 0xac, 0x57, 0x4c, 0x49, 0xfe, 0xae,
+			0x61, 0x50, 0x31, 0x5b, 0x96, 0x85, 0x42, 0x4c
+		},
+		.len = 16
+	}
+};
+
+/*
+ * SNOW-V AEAD test vector 3
+ */
+static uint8_t snow_v_aad_3[] = {
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66
+};
+static const struct aead_test_data snow_v_aead_case_3 = {
+	.algo = RTE_CRYPTO_AEAD_SNOW_V,
+	.key = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 32
+	},
+	.iv = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 16
+	},
+	.aad = {
+		.data = snow_v_aad_3,
+		.len = 16
+	},
+	.plaintext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.ciphertext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.auth_tag = {
+		.data = {
+			0x5a, 0x5a, 0xa5, 0xfb, 0xd6, 0x35, 0xef, 0x1a,
+			0xe1, 0x29, 0x61, 0x42, 0x03, 0xe1, 0x03, 0x84
+		},
+		.len = 16
+	}
+};
+
+/*
+ * SNOW-V AEAD test vector 4
+ */
+static uint8_t snow_v_aad_4[] = {
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66
+};
+static const struct aead_test_data snow_v_aead_case_4 = {
+	.algo = RTE_CRYPTO_AEAD_SNOW_V,
+	.key = {
+		.data = {
+			0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+			0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+			0x0a, 0x1a, 0x2a, 0x3a, 0x4a, 0x5a, 0x6a, 0x7a,
+			0x8a, 0x9a, 0xaa, 0xba, 0xca, 0xda, 0xea, 0xfa
+		},
+		.len = 32
+	},
+	.iv = {
+		.data = {
+			0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+			0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
+		},
+		.len = 16
+	},
+	.aad = {
+		.data = snow_v_aad_4,
+		.len = 16
+	},
+	.plaintext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.ciphertext = {
+		.data = { 0 },
+		.len = 0
+	},
+	.auth_tag = {
+		.data = {
+			0x25, 0x0e, 0xc8, 0xd7, 0x7a, 0x02, 0x2c, 0x08,
+			0x7a, 0xdf, 0x08, 0xb6, 0x5a, 0xdc, 0xbb, 0x1a
+		},
+		.len = 16
+	}
+};
+
+/*
+ * SNOW-V AEAD test vector 5
+ */
+static const struct aead_test_data snow_v_aead_case_5 = {
+	.algo = RTE_CRYPTO_AEAD_SNOW_V,
+	.key = {
+		.data = {
+			0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+			0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+			0x0a, 0x1a, 0x2a, 0x3a, 0x4a, 0x5a, 0x6a, 0x7a,
+			0x8a, 0x9a, 0xaa, 0xba, 0xca, 0xda, 0xea, 0xfa
+		},
+		.len = 32
+	},
+	.iv = {
+		.data = {
+			0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+			0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
+		},
+		.len = 16
+	},
+	.aad = {
+		.data = 0,
+		.len = 0
+	},
+	.plaintext = {
+		.data = {
+			0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+			0x38, 0x39
+		},
+		.len = 10
+	},
+	.ciphertext = {
+		.data = {
+			0xdd, 0x7e, 0x01, 0xb2, 0xb4, 0x24, 0xa2, 0xef,
+			0x82, 0x50
+		},
+		.len = 10
+	},
+	.auth_tag = {
+		.data = {
+			0xdd, 0xfe, 0x4e, 0x31, 0xe7, 0xbf, 0xe6, 0x90,
+			0x23, 0x31, 0xec, 0x5c, 0xe3, 0x19, 0xd9, 0x0d
+		},
+		.len = 16
+	}
+};
+
+/*
+ * SNOW-V AEAD test vector 6
+ */
+static const struct aead_test_data snow_v_aead_case_6 = {
+	.algo = RTE_CRYPTO_AEAD_SNOW_V,
+	.key = {
+		.data = {
+			0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+			0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+			0x0a, 0x1a, 0x2a, 0x3a, 0x4a, 0x5a, 0x6a, 0x7a,
+			0x8a, 0x9a, 0xaa, 0xba, 0xca, 0xda, 0xea, 0xfa
+		},
+		.len = 32
+	},
+	.iv = {
+		.data = {
+			0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+			0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
+		},
+		.len = 16
+	},
+	.aad = {
+		.data = 0,
+		.len = 0
+	},
+	.plaintext = {
+		.data = {
+			0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+			0x38, 0x39},
+		.len = 10
+	},
+	.ciphertext = {
+		.data = {
+			0xdd, 0x7e, 0x01, 0xb2, 0xb4, 0x24, 0xa2, 0xef,
+			0x82, 0x50
+		},
+		.len = 10
+	},
+	.auth_tag = {
+		.data = {
+			0xdd, 0xfe, 0x4e, 0x31, 0xe7, 0xbf, 0xe6, 0x90,
+			0x23, 0x31, 0xec, 0x5c, 0xe3, 0x19, 0xd9, 0x0d
+		},
+		.len = 16
+	}
+};
+
+
 #endif /* TEST_CRYPTODEV_AEAD_TEST_VECTORS_H_ */
diff --git a/app/test/test_cryptodev_snow_v_test_vectors.h b/app/test/test_cryptodev_snow_v_test_vectors.h
new file mode 100644
index 0000000000..030cccb989
--- /dev/null
+++ b/app/test/test_cryptodev_snow_v_test_vectors.h
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2025 Intel Corporation
+ */
+
+#ifndef TEST_CRYPTODEV_SNOW_V_TEST_VECTORS_H_
+#define TEST_CRYPTODEV_SNOW_V_TEST_VECTORS_H_
+
+struct snow_v_test_data {
+	struct {
+		uint8_t data[64];
+		unsigned int len;
+	} key;
+
+	struct {
+		alignas(16) uint8_t data[64];
+		unsigned int len;
+	} cipher_iv;
+
+	struct {
+		uint8_t data[1024];
+		unsigned int len; /* length must be in Bits */
+	} plaintext;
+
+	struct {
+		uint8_t data[1024];
+		unsigned int len; /* length must be in Bits */
+	} ciphertext;
+};
+
+struct snow_v_test_data snow_v_test_case_1 = {
+	.key = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 32
+	},
+	.cipher_iv = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 16
+	},
+	.plaintext = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 1024
+	},
+	.ciphertext = {
+		.data = {
+			0x69, 0xca, 0x6d, 0xaf, 0x9a, 0xe3, 0xb7, 0x2d,
+			0xb1, 0x34, 0xa8, 0x5a, 0x83, 0x7e, 0x41, 0x9d,
+			0xec, 0x08, 0xaa, 0xd3, 0x9d, 0x7b, 0x0f, 0x00,
+			0x9b, 0x60, 0xb2, 0x8c, 0x53, 0x43, 0x00, 0xed,
+			0x84, 0xab, 0xf5, 0x94, 0xfb, 0x08, 0xa7, 0xf1,
+			0xf3, 0xa2, 0xdf, 0x18, 0xe6, 0x17, 0x68, 0x3b,
+			0x48, 0x1f, 0xa3, 0x78, 0x07, 0x9d, 0xcf, 0x04,
+			0xdb, 0x53, 0xb5, 0xd6, 0x29, 0xa9, 0xeb, 0x9d,
+			0x03, 0x1c, 0x15, 0x9d, 0xcc, 0xd0, 0xa5, 0x0c,
+			0x4d, 0x5d, 0xbf, 0x51, 0x15, 0xd8, 0x70, 0x39,
+			0xc0, 0xd0, 0x3c, 0xa1, 0x37, 0x0c, 0x19, 0x40,
+			0x03, 0x47, 0xa0, 0xb4, 0xd2, 0xe9, 0xdb, 0xe5,
+			0xcb, 0xca, 0x60, 0x82, 0x14, 0xa2, 0x65, 0x82,
+			0xcf, 0x68, 0x09, 0x16, 0xb3, 0x45, 0x13, 0x21,
+			0x95, 0x4f, 0xdf, 0x30, 0x84, 0xaf, 0x02, 0xf6,
+			0xa8, 0xe2, 0x48, 0x1d, 0xe6, 0xbf, 0x82, 0x79
+		},
+		.len = 1024
+	},
+};
+
+struct snow_v_test_data snow_v_test_case_2 = {
+	.key = {
+		.data = {
+			0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+		},
+		.len = 32
+	},
+	.cipher_iv = {
+		.data = {
+			0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+		},
+		.len = 16
+	},
+	.plaintext = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 1024
+	},
+	.ciphertext = {
+		.data = {
+			0x30, 0x76, 0x09, 0xfb, 0x10, 0x10, 0x12, 0x54,
+			0x4b, 0xc1, 0x75, 0xe3, 0x17, 0xfb, 0x25, 0xff,
+			0x33, 0x0d, 0x0d, 0xe2, 0x5a, 0xf6, 0xaa, 0xd1,
+			0x05, 0x05, 0xb8, 0x9b, 0x1e, 0x09, 0xa8, 0xec,
+			0xdd, 0x46, 0x72, 0xcc, 0xbb, 0x98, 0xc7, 0xf2,
+			0xc4, 0xe2, 0x4a, 0xf5, 0x27, 0x28, 0x36, 0xc8,
+			0x7c, 0xc7, 0x3a, 0x81, 0x76, 0xb3, 0x9c, 0xe9,
+			0x30, 0x3b, 0x3e, 0x76, 0x4e, 0x9b, 0xe3, 0xe7,
+			0x48, 0xf7, 0x65, 0x1a, 0x7c, 0x7e, 0x81, 0x3f,
+			0xd5, 0x24, 0x90, 0x23, 0x1e, 0x56, 0xf7, 0xc1,
+			0x44, 0xe4, 0x38, 0xe7, 0x77, 0x11, 0xa6, 0xb0,
+			0xba, 0xfb, 0x60, 0x45, 0x0c, 0x62, 0xd7, 0xd9,
+			0xb9, 0x24, 0x1d, 0x12, 0x44, 0xfc, 0xb4, 0x9d,
+			0xa1, 0xe5, 0x2b, 0x80, 0x13, 0xde, 0xcd, 0xd4,
+			0x86, 0x04, 0xff, 0xfc, 0x62, 0x67, 0x6e, 0x70,
+			0x3b, 0x3a, 0xb8, 0x49, 0xcb, 0xa6, 0xea, 0x09
+		},
+		.len = 1024
+	},
+};
+
+struct snow_v_test_data snow_v_test_case_3 = {
+	.key = {
+		.data = {
+			0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+			0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+			0x0a, 0x1a, 0x2a, 0x3a, 0x4a, 0x5a, 0x6a, 0x7a,
+			0x8a, 0x9a, 0xaa, 0xba, 0xca, 0xda, 0xea, 0xfa
+		},
+		.len = 32
+	},
+	.cipher_iv = {
+		.data = {
+			0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+			0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
+		},
+		.len = 16
+	},
+	.plaintext = {
+		.data = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		},
+		.len = 1024
+	},
+	.ciphertext = {
+		.data = {
+			0xaa, 0x81, 0xea, 0xfb, 0x8b, 0x86, 0x16, 0xce,
+			0x3e, 0x5c, 0xe2, 0x22, 0x24, 0x61, 0xc5, 0x0a,
+			0x6a, 0xb4, 0x48, 0x77, 0x56, 0xde, 0x4b, 0xd3,
+			0x1c, 0x90, 0x4f, 0x3d, 0x97, 0x8a, 0xfe, 0x56,
+			0x33, 0x4f, 0x10, 0xdd, 0xdf, 0x2b, 0x95, 0x31,
+			0x76, 0x9a, 0x71, 0x05, 0x0b, 0xe4, 0x38, 0x5f,
+			0xc2, 0xb6, 0x19, 0x2c, 0x7a, 0x85, 0x7b, 0xe8,
+			0xb4, 0xfc, 0x28, 0xb7, 0x09, 0xf0, 0x8f, 0x11,
+			0xf2, 0x06, 0x49, 0xe2, 0xee, 0xf2, 0x49, 0x80,
+			0xf8, 0x6c, 0x4c, 0x11, 0x36, 0x41, 0xfe, 0xd2,
+			0xf3, 0xf6, 0xfa, 0x2b, 0x91, 0x95, 0x12, 0x06,
+			0xb8, 0x01, 0xdb, 0x15, 0x46, 0x65, 0x17, 0xa6,
+			0x33, 0x0a, 0xdd, 0xa6, 0xb3, 0x5b, 0x26, 0x5e,
+			0xfd, 0x72, 0x2e, 0x86, 0x77, 0xb4, 0x8b, 0xfc,
+			0x15, 0xb4, 0x41, 0x18, 0xde, 0x52, 0xd0, 0x73,
+			0xb0, 0xad, 0x0f, 0xe7, 0x59, 0x4d, 0x62, 0x91
+		},
+		.len = 1024
+	},
+};
+
+#endif /* TEST_CRYPTODEV_SNOW_V_TEST_VECTORS_H_ */
-- 
2.43.0

