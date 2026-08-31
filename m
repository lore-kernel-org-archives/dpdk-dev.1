Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB3C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7326940693;
	Mon, 31 Aug 2026 12:24:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3E9CF40679
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:24:13 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V85doG334305; Mon, 31 Aug 2026 03:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 zhdGwF+PBgqRBpZLkxxDfTyZRjtcuSVWixjWhWjwWs=; b=PLAqvH3VXcVgF9COO
 qSkv/oHll21b132y/ngoVpl8RtiYJk6mOhoMTqG9Fh8Lw4rrUqyATdLSgoWmGnPR
 b5DVh0wQwMBvAjOhF1pZKiHRd/ZA4F5RbyqWbsSBksU2ThmCjp9fmCVraEpWmzDP
 wHdhXgrkNzBlQNCXMDrg5ro3xFN/bz04FJPBf3Om7XCvZvB2BDzU4PiLrtdiLT+T
 yBoC62OuakvZVfEIOh15nwzV0UpxxIkh3TlrxFiJTNZQ7xY39S4cBqBD5wpcsIon
 zrcoplZPfh1xm9C/g/K+HWUsbCEGmT4hPe05bfZKcNyX/pulxwuJhoYS+gOYajM2
 0hszQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gcg68j92c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:24:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:24:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:24:11 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 4201F3F704C;
 Mon, 31 Aug 2026 03:24:08 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 08/10] app/test: add RSA OAEP asymmetric test cases
Date: Mon, 31 Aug 2026 10:23:26 +0000
Message-ID: <20260831102328.2813604-9-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9aev6agamVeGDHr0-8E2YAwcOOBTwGQ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfXyRqeSwssmITA
 0b9Sj6IavUQ/xAiiITWXug0ful2pi2JU/8+6+OLpEnPg2WeYiqj3GmLi2qexkKFd6XBSbyff/7R
 sV0BaJr6Kw/e/m+V3RPX8Woorjji8b7zgq+0a8DOWUaibyHuVdDLnHwOJuXR8av9azUE243CG9+
 UxNRV9PAJ0FgJ64Coo18TBKbrjqF77Q1lZaRXKxcqtN/KLT3ce2y+0szTDVadl4Zs0I9oaTxTeq
 s+jF+nQvww/dUmEjpWCux3kjQCqM43VJLP0q9SkvTF40PcCyfNKr05bXwFuOnfGH9kk9W62Ln0k
 hipd2+5Fu+kMfb5lO77w9DGS1OcI2RI69coJl66Uq09RS4B82Wr0zDbngB2x0PVUsR2HN1HcdjF
 S7Rf+Ihgr9N35RER9SqUR0dN2MyFQYOWPaKM2gO5aZOcvqqEVcL8g3MTxVjdjIb1Zz41MAHPp6i
 E+aam9q/gJS2EoNm9kQ==
X-Authority-Analysis: v=2.4 cv=fZedDUQF c=1 sm=1 tr=0 ts=6a95564c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=wsPdNLSzhbzobFu0o0sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 9aev6agamVeGDHr0-8E2YAwcOOBTwGQ4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX/Gre9tdiMQ34
 Nr+nz3a4+9lP9p3AoNNzTyvtEEJSTyrxzsnyvYPmzw8R6oI5khyfqexIxrTFvv6tICFutTR+JzM
 jog76SHE2CbQh5kVRvQ0LZ1ZzkpQMhU=
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

Add RSA OAEP encrypt/decrypt tests to the asymmetric cryptodev test
suite.

Introduce OAEP test vectors with default and custom OAEP parameters,
including support for custom MGF1 hashes and OAEP labels. The tests
cover both exponent and CRT private key types and execute end-to-end
encrypt/decrypt validation.

Add capability checks to skip the tests on devices that do not support
OAEP padding or the required RSA private key operations. Also extend
capability reporting to display RSA padding and hash capabilities.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 app/test/test_cryptodev_asym.c             | 356 +++++++++++++++++++++
 app/test/test_cryptodev_rsa_test_vectors.h | 154 +++++++++
 2 files changed, 510 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 7b8afe5f92..ceae029a4a 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -273,6 +273,339 @@ queue_ops_rsa_enc_dec(void *sess)
 	return status;
 }
 
+/*
+ * Check that the device supports RSA-OAEP padding, along with the
+ * specific hash and MGF1 hash used by padding. If mgf1hash is left
+ * unconfigured (0), the PMD falls back to using hash for MGF1, which
+ * is already covered by the hash_algos check above, so mgf1_hash_algos
+ * only needs checking when mgf1hash is explicitly set.
+ */
+static int
+rsa_oaep_supported(uint8_t dev_id, const struct rte_crypto_rsa_padding *padding)
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
+			(capa->rsa_capa.pad_types & (1 << RTE_CRYPTO_RSA_PADDING_OAEP)) == 0) {
+		RTE_LOG(INFO, USER1,
+			"RSA OAEP padding not supported by device. Supported pad_types=%#x\n",
+			capa->rsa_capa.pad_types);
+		return 0;
+	}
+
+	if (!rte_cryptodev_asym_xform_capability_check_hash(capa, padding->hash)) {
+		RTE_LOG(INFO, USER1,
+			"RSA OAEP hash %u not supported by device capabilities "
+			"(supported hash_algos=%#"PRIx64")\n",
+			padding->hash, capa->hash_algos);
+		return 0;
+	}
+
+	if (padding->mgf1hash != 0 &&
+			(capa->rsa_capa.mgf1_hash_algos & RTE_BIT64(padding->mgf1hash)) == 0) {
+		RTE_LOG(INFO, USER1,
+			"RSA OAEP MGF1 hash %u not supported by device capabilities "
+			"(supported mgf1_hash_algos=%#"PRIx64")\n",
+			padding->mgf1hash, capa->rsa_capa.mgf1_hash_algos);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+test_rsa_oaep_enc_dec(void)
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
+	if (!rsa_oaep_supported(dev_id, &rsa_oaep_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA OAEP not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags &
+				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support decrypt op with "
+			"exponent key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	memcpy(&xform, &rsa_oaep_xform, sizeof(rsa_oaep_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for OAEP enc_dec\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_enc_dec(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_oaep_enc_dec_crt(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *sess_mpool = ts_params->session_mpool;
+	struct rte_cryptodev_asym_capability_idx idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	void *sess = NULL;
+	struct rte_cryptodev_info dev_info;
+	int ret, status = TEST_SUCCESS;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return -ENOTSUP;
+
+	if (!rsa_oaep_supported(dev_id, &rsa_oaep_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA OAEP not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags & RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_QT)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support decrypt op with "
+			"quintuple key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_oaep_xform,
+			sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"OAEP enc_dec_crt\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_enc_dec(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_oaep_labeled_enc_dec(void)
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
+	if (!rsa_oaep_supported(dev_id, &rsa_oaep_labeled_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA OAEP not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags &
+				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support decrypt op with "
+			"exponent key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	memcpy(&xform, &rsa_oaep_labeled_xform, sizeof(rsa_oaep_labeled_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"OAEP labeled enc_dec\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_enc_dec(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_oaep_labeled_enc_dec_crt(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *sess_mpool = ts_params->session_mpool;
+	struct rte_cryptodev_asym_capability_idx idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	void *sess = NULL;
+	struct rte_cryptodev_info dev_info;
+	int ret, status = TEST_SUCCESS;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return -ENOTSUP;
+
+	if (!rsa_oaep_supported(dev_id, &rsa_oaep_labeled_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA OAEP not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags & RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_QT)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support decrypt op with "
+			"quintuple key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_oaep_labeled_xform,
+			sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"OAEP labeled enc_dec_crt\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_enc_dec(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_oaep_labeled_default_mgf1_enc_dec(void)
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
+	if (!rsa_oaep_supported(dev_id,
+			&rsa_oaep_labeled_default_mgf1_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA OAEP not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags &
+				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support decrypt op with "
+			"exponent key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	memcpy(&xform, &rsa_oaep_labeled_default_mgf1_xform,
+			sizeof(rsa_oaep_labeled_default_mgf1_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"OAEP labeled default MGF1 enc_dec\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_enc_dec(sess);
+
+error_exit:
+	rte_cryptodev_asym_session_free(dev_id, sess);
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
+static int
+test_rsa_oaep_labeled_default_mgf1_enc_dec_crt(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	struct rte_mempool *sess_mpool = ts_params->session_mpool;
+	struct rte_cryptodev_asym_capability_idx idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	void *sess = NULL;
+	struct rte_cryptodev_info dev_info;
+	int ret, status = TEST_SUCCESS;
+
+	idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	if (rte_cryptodev_asym_capability_get(dev_id, &idx) == NULL)
+		return -ENOTSUP;
+
+	if (!rsa_oaep_supported(dev_id,
+			&rsa_oaep_labeled_default_mgf1_xform.rsa.padding)) {
+		RTE_LOG(INFO, USER1, "RSA OAEP not supported. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+	if (!(dev_info.feature_flags & RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_QT)) {
+		RTE_LOG(INFO, USER1, "Device doesn't support decrypt op with "
+			"quintuple key type. Test skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_cryptodev_asym_session_create(dev_id,
+			&rsa_oaep_labeled_default_mgf1_xform, sess_mpool, &sess);
+	if (ret < 0) {
+		RTE_LOG(ERR, USER1, "Session creation failed for "
+			"OAEP labeled default MGF1 enc_dec_crt\n");
+		status = (ret == -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
+		goto error_exit;
+	}
+
+	status = queue_ops_rsa_enc_dec(sess);
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
@@ -677,6 +1010,18 @@ static inline void print_asym_capa(
 	}
 	switch (capa->xform_type) {
 	case RTE_CRYPTO_ASYM_XFORM_RSA:
+		printf(" modlen: min %d max %d increment %d",
+				capa->rsa_capa.modlen.min,
+				capa->rsa_capa.modlen.max,
+				capa->rsa_capa.modlen.increment);
+		if (capa->rsa_capa.pad_types != 0)
+			printf(" pad_types: %#x", capa->rsa_capa.pad_types);
+		if (capa->rsa_capa.mgf1_hash_algos != 0)
+			printf(" mgf1_hash_algos: %#" PRIx64,
+				capa->rsa_capa.mgf1_hash_algos);
+		if (capa->hash_algos != 0)
+			printf(" hash_algos: %#" PRIx64, capa->hash_algos);
+		break;
 	case RTE_CRYPTO_ASYM_XFORM_MODINV:
 	case RTE_CRYPTO_ASYM_XFORM_MODEX:
 	case RTE_CRYPTO_ASYM_XFORM_DH:
@@ -5349,6 +5694,17 @@ static struct unit_test_suite cryptodev_asym_rsa_testsuite = {
 				test_rsa_enc_dec_crt),
 		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
 				test_rsa_sign_verify_crt),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_rsa_oaep_enc_dec),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_oaep_enc_dec_crt),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_oaep_labeled_enc_dec),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_oaep_labeled_enc_dec_crt),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_oaep_labeled_default_mgf1_enc_dec),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_oaep_labeled_default_mgf1_enc_dec_crt),
 		/* RSA EXP */
 		TEST_CASE_NAMED_WITH_DATA(
 			"RSA Encryption (n=128, pt=20, e=3) EXP, Padding: NONE",
diff --git a/app/test/test_cryptodev_rsa_test_vectors.h b/app/test/test_cryptodev_rsa_test_vectors.h
index 9652b0d43a..6835453b6d 100644
--- a/app/test/test_cryptodev_rsa_test_vectors.h
+++ b/app/test/test_cryptodev_rsa_test_vectors.h
@@ -236,6 +236,12 @@ rsa_test_data_2 rsa_vector_128_20_3_none = {
 	.padding = RTE_CRYPTO_RSA_PADDING_NONE,
 };
 
+uint8_t rsa_oaep_label[] = {
+	0x0a, 0x1b, 0x2c, 0x3d, 0x4e, 0x5f, 0x60, 0x71,
+	0x82, 0x93, 0xa4, 0xb5, 0xc6, 0xd7, 0xe8, 0xf9,
+	0x01, 0x12, 0x23, 0x34
+};
+
 struct rsa_test_data rsaplaintext = {
 	.data = {
 		0xf8, 0xba, 0x1a, 0x55, 0xd0, 0x2f, 0x85, 0xae,
@@ -384,4 +390,152 @@ struct rte_crypto_asym_xform rsa_xform = {
 	}
 };
 
+/** rsa OAEP xform (SHA-256, QT private key type by default) */
+struct rte_crypto_asym_xform rsa_oaep_xform = {
+	.next = NULL,
+	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	.rsa = {
+		.padding.type = RTE_CRYPTO_RSA_PADDING_OAEP,
+		.padding.hash = RTE_CRYPTO_AUTH_SHA256,
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
+/** rsa OAEP xform with MGF1-SHA1 and label */
+struct rte_crypto_asym_xform rsa_oaep_labeled_xform = {
+	.next = NULL,
+	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	.rsa = {
+		.padding.type = RTE_CRYPTO_RSA_PADDING_OAEP,
+		.padding.hash = RTE_CRYPTO_AUTH_SHA256,
+		.padding.mgf1hash = RTE_CRYPTO_AUTH_SHA1,
+		.padding.oaep_label = {
+			.data = rsa_oaep_label,
+			.length = sizeof(rsa_oaep_label)
+		},
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
+/**
+ * rsa OAEP xform with label but no explicit MGF1 hash.
+ * mgf1hash is left unset (0) so the PMD falls back to using the
+ * primary hash (SHA-256) for MGF1
+ */
+struct rte_crypto_asym_xform rsa_oaep_labeled_default_mgf1_xform = {
+	.next = NULL,
+	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
+	.rsa = {
+		.padding.type = RTE_CRYPTO_RSA_PADDING_OAEP,
+		.padding.hash = RTE_CRYPTO_AUTH_SHA256,
+		.padding.oaep_label = {
+			.data = rsa_oaep_label,
+			.length = sizeof(rsa_oaep_label)
+		},
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

