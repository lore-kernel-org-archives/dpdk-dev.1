Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E7C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B01844067B;
	Mon, 31 Aug 2026 12:24:22 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4DEA34067B
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:24:21 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V85i7F203991; Mon, 31 Aug 2026 03:24:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 wxUb9HEFE/GdeepuHwS5QenxEy+AmSQEu4MfFSjPSQ=; b=f3m0PFGcTNeRsaMuw
 XzcLJcmOmrMFKmNhy7lQo9sMHecbgYBMtdEBahMk9uG7dNJMhiv+FOj7UHiOjLQ5
 d+6hulEJY+Z0R0N01MmhxYizwlBpyRVJ9NH/NuznD73MSTHMyJ5TfaqdJReuMywS
 Xfnn6CQmZqgVlv72eneUNg2FnkBBJbguXxVrsy/b+aor7DJPaGfzmI2WISjgY41J
 BNgTUoQvUzyr8DXQGIGJqXI9bhLSNKRSNQMdtM8pfF2yEPWBOgjTIOmp8cJUAV9M
 vK/VH70B20WRbHuAJOs8Zq2NyN+Ou2wPr/gXENW1RNbCtpzxROJPmA83fRZpc1dx
 6ggOg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8j3fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:24:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:24:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:24:18 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id A4BA33F704C;
 Mon, 31 Aug 2026 03:24:15 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 10/10] app/test: add RSA-PSS sign and verify test cases
Date: Mon, 31 Aug 2026 10:23:28 +0000
Message-ID: <20260831102328.2813604-11-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX+0MOdgDjdl7g
 oVKDfzQ2HQeI34wSmgpRkzqdlzv3+H1gY9D/VTy+YDWuEV7Io0kAKnuEeHLfm5vJlg5k+iYv2i2
 M8XUbTKe2vBqRWgbb3HF8s0iksl/TWIWUwwQjUnroARqZevNpPx/EE0VeTX+izwlbKLVM88ca4k
 GRLFfOiLmho/9kLSIkxOvzDxmbQ15oRJRkgBBnJIeM5zvryaTTMTU01HOzw14g3Wni4d8Ik7phR
 m7bBql3zR6MtZZIIx+XcVCJBiIqIYRHkhEoQAD/b/MVAp2oy0FbT7g9/yDPQOk5ZwhLhdaVQYP2
 DPaR1PBRX+D8pCImxQViYRj1kToICZNvkP4CP6YsRPz6nhOU+C38mcMWUqQ6h4fHZDBsPZoNJ+L
 49AvI2mg/l4g0S/0UpupKl+fNZp34BtKTK9Ua/a0ndiO7EY3V3rAjENZCrRDmHRkA7WQ2sFMcg0
 QfyNNmu1bjHtFBpldGg==
X-Proofpoint-GUID: wWiyVYYaUOVGcUTifJ1RdyUYDFulg7xq
X-Proofpoint-ORIG-GUID: wWiyVYYaUOVGcUTifJ1RdyUYDFulg7xq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX1TDoJbuEgc/l
 xK9FthmkeAbAIAk/8hjo1xXNmTapToGSW9cl4W9w8MQpc3PuJ3NimEs7ON3bEkmaSZb5XO9SR9C
 Q85341PHm9EYaTDUvHHFLs1uT+AmVg4=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a955654 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=7nnckYv93_VVNdunjAAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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

Add OpenSSL asymmetric tests for RSA-PSS sign and verify
operations using SHA-256 with different salt length settings.

Introduce test vectors covering digest-length salt, maximum
supported salt length, and zero-length salt. Update the
OpenSSL asym test suite to validate RSA-PSS functionality
when supported by the device capabilities.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 app/test/test_cryptodev_asym.c             | 307 +++++++++++++++++++++
 app/test/test_cryptodev_rsa_test_vectors.h | 163 +++++++++++
 2 files changed, 470 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index ceae029a4a..718b06aefa 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -606,6 +606,307 @@ test_rsa_oaep_labeled_default_mgf1_enc_dec_crt(void)
 	return status;
 }
 
+/*
+ * Check that the device supports RSA-PSS padding, the hash used for
+ * the signature digest, and, if explicitly set, the MGF1 hash (this
+ * PMD defaults MGF1 to the same hash as the digest when unset).
+ */
+static int
+rsa_pss_supported(uint8_t dev_id, const struct rte_crypto_rsa_padding *padding)
+{
+	struct rte_cryptodev_asym_capability_idx idx = {
+		.type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	};
+	const struct rte_cryptodev_asymmetric_xform_capability *capa;
+
+	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
+	if (capa == NULL) {
+		RTE_LOG(INFO, USER1, "RSA capability not reported by device\n");
+		return 0;
+	}
+
+	if (capa->rsa_capa.pad_types != 0 &&
+			(capa->rsa_capa.pad_types & (1 << RTE_CRYPTO_RSA_PADDING_PSS)) == 0) {
+		RTE_LOG(INFO, USER1,
+			"RSA PSS padding not supported by device. Supported pad_types=%#x\n",
+			capa->rsa_capa.pad_types);
+		return 0;
+	}
+
+	if (!rte_cryptodev_asym_xform_capability_check_hash(capa, padding->hash)) {
+		RTE_LOG(INFO, USER1,
+			"RSA PSS hash %u not supported by device capabilities "
+			"(supported hash_algos=%#"PRIx64")\n",
+			padding->hash, capa->hash_algos);
+		return 0;
+	}
+
+	if (padding->mgf1hash != 0 &&
+			(capa->rsa_capa.mgf1_hash_algos & RTE_BIT64(padding->mgf1hash)) == 0) {
+		RTE_LOG(INFO, USER1,
+			"RSA PSS MGF1 hash %u not supported by device capabilities "
+			"(supported mgf1_hash_algos=%#"PRIx64")\n",
+			padding->mgf1hash, capa->rsa_capa.mgf1_hash_algos);
+		return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * Sign then verify the freshly-generated signature. Unlike
+ * queue_ops_rsa_sign_verify(), this does not include a
+ * corrupted-signature negative test: RSA-PSS verification does not
+ * support verify-recover, and mismatches are reported via op->status.
+ */
+static int
+queue_ops_rsa_pss_sign_verify(void *sess)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *op_mpool = ts_params->op_mpool;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_op *op, *result_op;
+	struct rte_crypto_asym_op *asym_op;
+	uint8_t output_buf[TEST_DATA_SIZE];
+	int status;
+
+	/* Set up crypto op data structure */
+	op = rte_crypto_op_alloc(op_mpool, RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
+	if (!op) {
+		RTE_LOG(ERR, USER1, "Failed to allocate asymmetric crypto "
+			"operation struct\n");
+		return TEST_FAILED;
+	}
+
+	asym_op = op->asym;
+
+	/* Compute sign on the test vector */
+	asym_op->rsa.op_type = RTE_CRYPTO_ASYM_OP_SIGN;
+
+	/*
+	 * RTE_CRYPTO_RSA_PADDING_PSS expects message to already be a
+	 * digest hashed with the algorithm configured in the session's
+	 * padding.hash (SHA-256 here), not the raw plaintext.
+	 */
+	asym_op->rsa.message.data = rsa_pss_digest_sha256.data;
+	asym_op->rsa.message.length = rsa_pss_digest_sha256.len;
+	asym_op->rsa.sign.length = RTE_DIM(rsa_n);
+	asym_op->rsa.sign.data = output_buf;
+
+	debug_hexdump(stdout, "digest", asym_op->rsa.message.data,
+		      asym_op->rsa.message.length);
+
+	/* Attach asymmetric crypto session to crypto operations */
+	rte_crypto_op_attach_asym_session(op, sess);
+
+	RTE_LOG(DEBUG, USER1, "Process ASYM operation\n");
+
+	/* Process crypto operation */
+	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
+		RTE_LOG(ERR, USER1, "Error sending packet for sign\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	while (rte_cryptodev_dequeue_burst(dev_id, 0, &result_op, 1) == 0)
+		rte_pause();
+
+	if (result_op == NULL) {
+		RTE_LOG(ERR, USER1, "Failed to process sign op\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	if (result_op->status != RTE_CRYPTO_OP_STATUS_SUCCESS) {
+		RTE_LOG(ERR, USER1, "Failed to process PSS sign op\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	debug_hexdump(stdout, "signed message", asym_op->rsa.sign.data,
+		      asym_op->rsa.sign.length);
+	asym_op = result_op->asym;
+
+	/* Verify sign */
+	asym_op->rsa.op_type = RTE_CRYPTO_ASYM_OP_VERIFY;
+
+	/* Process crypto operation */
+	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
+		RTE_LOG(ERR, USER1, "Error sending packet for verify\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	while (rte_cryptodev_dequeue_burst(dev_id, 0, &result_op, 1) == 0)
+		rte_pause();
+
+	if (result_op == NULL) {
+		RTE_LOG(ERR, USER1, "Failed to process verify op\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	if (result_op->status != RTE_CRYPTO_OP_STATUS_SUCCESS) {
+		RTE_LOG(ERR, USER1, "Failed to process PSS sign-verify op\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = TEST_SUCCESS;
+error_exit:
+
+	rte_crypto_op_free(op);
+
+	return status;
+}
+
+static int
+test_rsa_pss_sign_verify_digest_saltlen(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *sess_mpool = ts_params->session_mpool;
+	struct rte_cryptodev_asym_capability_idx idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_asym_xform xform;
+	void *sess = NULL;
+	struct rte_cryptodev_info dev_info;
+	int ret, status = TEST_SUCCESS;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return -ENOTSUP;
+
+	if (!rsa_pss_supported(dev_id, &rsa_pss_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA PSS not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags &
+				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support sign op with "
+			"exponent key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	memcpy(&xform, &rsa_pss_xform, sizeof(rsa_pss_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"PSS sign_verify (saltlen = digest length)\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_pss_sign_verify(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_pss_sign_verify_max_saltlen(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *sess_mpool = ts_params->session_mpool;
+	struct rte_cryptodev_asym_capability_idx idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_asym_xform xform;
+	void *sess = NULL;
+	struct rte_cryptodev_info dev_info;
+	int ret, status = TEST_SUCCESS;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return -ENOTSUP;
+
+	if (!rsa_pss_supported(dev_id, &rsa_pss_max_salt_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA PSS not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags &
+				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support sign op with "
+			"exponent key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	memcpy(&xform, &rsa_pss_max_salt_xform, sizeof(rsa_pss_max_salt_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"PSS sign_verify (max saltlen)\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_pss_sign_verify(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_pss_sign_verify_zero_saltlen(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *sess_mpool = ts_params->session_mpool;
+	struct rte_cryptodev_asym_capability_idx idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_asym_xform xform;
+	void *sess = NULL;
+	struct rte_cryptodev_info dev_info;
+	int ret, status = TEST_SUCCESS;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return -ENOTSUP;
+
+	if (!rsa_pss_supported(dev_id, &rsa_pss_zero_salt_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA PSS not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags &
+				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support sign op with "
+			"exponent key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	memcpy(&xform, &rsa_pss_zero_salt_xform, sizeof(rsa_pss_zero_salt_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"PSS sign_verify (zero saltlen)\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_pss_sign_verify(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
 static int
 test_rsa_sign_verify(void)
 {
@@ -5705,6 +6006,12 @@ static struct unit_test_suite cryptodev_asym_rsa_testsuite = {
 				test_rsa_oaep_labeled_default_mgf1_enc_dec),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
 				test_rsa_oaep_labeled_default_mgf1_enc_dec_crt),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_pss_sign_verify_digest_saltlen),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_pss_sign_verify_max_saltlen),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_pss_sign_verify_zero_saltlen),
 		/* RSA EXP */
 		TEST_CASE_NAMED_WITH_DATA(
 			"RSA Encryption (n=128, pt=20, e=3) EXP, Padding: NONE",
diff --git a/app/test/test_cryptodev_rsa_test_vectors.h b/app/test/test_cryptodev_rsa_test_vectors.h
index 6835453b6d..f35a83c016 100644
--- a/app/test/test_cryptodev_rsa_test_vectors.h
+++ b/app/test/test_cryptodev_rsa_test_vectors.h
@@ -251,6 +251,23 @@ struct rsa_test_data rsaplaintext = {
 	.len = 20
 };
 
+/*
+ * SHA-256 digest of rsaplaintext.data. RTE_CRYPTO_RSA_PADDING_PSS
+ * expects rte_crypto_rsa_op_param::message to already be a digest
+ * hashed with the algorithm configured in rte_crypto_rsa_padding::hash
+ * (SHA-256 for the PSS xforms below), not the raw message, so PSS
+ * sign/verify tests use this instead of rsaplaintext directly.
+ */
+struct rsa_test_data rsa_pss_digest_sha256 = {
+	.data = {
+		0x45, 0x24, 0x54, 0x32, 0x9d, 0x91, 0xda, 0x1b,
+		0xb8, 0x76, 0x0d, 0x9b, 0xdd, 0xea, 0xe5, 0x21,
+		0x30, 0x91, 0x72, 0xb0, 0x9c, 0x23, 0x12, 0x3f,
+		0xb3, 0x43, 0x09, 0x5d, 0xa3, 0x10, 0x78, 0x7c
+	},
+	.len = 32
+};
+
 uint8_t rsa_n[] = {
 	0xb3, 0xa1, 0xaf, 0xb7, 0x13, 0x08, 0x00,
 	0x0a, 0x35, 0xdc, 0x2b, 0x20, 0x8d, 0xa1, 0xb5,
@@ -538,4 +555,150 @@ struct rte_crypto_asym_xform rsa_oaep_labeled_default_mgf1_xform = {
 	}
 };
 
+/*
+ * RSA-PSS xforms below all use the same 1024-bit test key (rsa_n, 128
+ * bytes) and SHA-256 (hLen = 32 bytes). For this key/hash combination:
+ *   emBits = modBits - 1 = 1023, emLen = ceil(emBits / 8) = 128
+ *   maxSaltLen = emLen - hLen - 2 = 128 - 32 - 2 = 94
+ * (see RFC 8017 EMSA-PSS-ENCODE, section 9.1.1)
+ */
+
+/** rsa PSS xform (SHA-256, salt length = digest length, QT private key type by default) */
+struct rte_crypto_asym_xform rsa_pss_xform = {
+	.next = NULL,
+	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	.rsa = {
+		.padding.type = RTE_CRYPTO_RSA_PADDING_PSS,
+		.padding.hash = RTE_CRYPTO_AUTH_SHA256,
+		.padding.pss_saltlen = 32,
+		.n = {
+			.data = rsa_n,
+			.length = sizeof(rsa_n)
+		},
+		.e = {
+			.data = rsa_e,
+			.length = sizeof(rsa_e)
+		},
+		.qt = {
+			.p = {
+				.data = rsa_p,
+				.length = sizeof(rsa_p)
+			},
+			.q = {
+				.data = rsa_q,
+				.length = sizeof(rsa_q)
+			},
+			.dP = {
+				.data = rsa_dP,
+				.length = sizeof(rsa_dP)
+			},
+			.dQ = {
+				.data = rsa_dQ,
+				.length = sizeof(rsa_dQ)
+			},
+			.qInv = {
+				.data = rsa_qInv,
+				.length = sizeof(rsa_qInv)
+			},
+		},
+		.d = {
+			.data = rsa_d,
+			.length = sizeof(rsa_d)
+		},
+		.key_type = RTE_RSA_KEY_TYPE_QT
+	}
+};
+
+/** rsa PSS xform with the maximum permissible salt length (94 bytes) */
+struct rte_crypto_asym_xform rsa_pss_max_salt_xform = {
+	.next = NULL,
+	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	.rsa = {
+		.padding.type = RTE_CRYPTO_RSA_PADDING_PSS,
+		.padding.hash = RTE_CRYPTO_AUTH_SHA256,
+		.padding.pss_saltlen = 94,
+		.n = {
+			.data = rsa_n,
+			.length = sizeof(rsa_n)
+		},
+		.e = {
+			.data = rsa_e,
+			.length = sizeof(rsa_e)
+		},
+		.qt = {
+			.p = {
+				.data = rsa_p,
+				.length = sizeof(rsa_p)
+			},
+			.q = {
+				.data = rsa_q,
+				.length = sizeof(rsa_q)
+			},
+			.dP = {
+				.data = rsa_dP,
+				.length = sizeof(rsa_dP)
+			},
+			.dQ = {
+				.data = rsa_dQ,
+				.length = sizeof(rsa_dQ)
+			},
+			.qInv = {
+				.data = rsa_qInv,
+				.length = sizeof(rsa_qInv)
+			},
+		},
+		.d = {
+			.data = rsa_d,
+			.length = sizeof(rsa_d)
+		},
+		.key_type = RTE_RSA_KEY_TYPE_QT
+	}
+};
+
+/** rsa PSS xform with zero-length salt (deterministic PSS, no randomization) */
+struct rte_crypto_asym_xform rsa_pss_zero_salt_xform = {
+	.next = NULL,
+	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	.rsa = {
+		.padding.type = RTE_CRYPTO_RSA_PADDING_PSS,
+		.padding.hash = RTE_CRYPTO_AUTH_SHA256,
+		.padding.pss_saltlen = 0, /* no salt bytes */
+		.n = {
+			.data = rsa_n,
+			.length = sizeof(rsa_n)
+		},
+		.e = {
+			.data = rsa_e,
+			.length = sizeof(rsa_e)
+		},
+		.qt = {
+			.p = {
+				.data = rsa_p,
+				.length = sizeof(rsa_p)
+			},
+			.q = {
+				.data = rsa_q,
+				.length = sizeof(rsa_q)
+			},
+			.dP = {
+				.data = rsa_dP,
+				.length = sizeof(rsa_dP)
+			},
+			.dQ = {
+				.data = rsa_dQ,
+				.length = sizeof(rsa_dQ)
+			},
+			.qInv = {
+				.data = rsa_qInv,
+				.length = sizeof(rsa_qInv)
+			},
+		},
+		.d = {
+			.data = rsa_d,
+			.length = sizeof(rsa_d)
+		},
+		.key_type = RTE_RSA_KEY_TYPE_QT
+	}
+};
+
 #endif /* TEST_CRYPTODEV_RSA_TEST_VECTORS_H__ */
-- 
2.54.0

