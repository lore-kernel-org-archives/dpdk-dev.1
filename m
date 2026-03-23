Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41745F4613B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3425140655;
	Mon, 23 Mar 2026 16:09:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0BB044064E
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774278546; x=1805814546;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eomCON4IXcQzIFisUvZlURGYrpUuHCWULMKyYoWSZqM=;
 b=PXIEcxFhWSwegbouTCobV5si8Mf/vML8l9B2J922Uba6hfzibpXsfG78
 jywpJccgF0Hma36yIhbGr5bq389RZ96oC+YD2yOrR0hHrAdbWiaU0yvlS
 VRe9RBPTlsftLsCVSIEeOKJ47jGDL/wjGeBu3kSrEV1kaWiBPvPeN2MmS
 s2ya+ChhCjTp2MPhMRjlZGzzo17hCPaE2txinS+RAi+dVACDgUdVIW2s2
 TXDkdt3K/GU7+ZifNl/VcpynxVR+hX7xDe4iI5P+oe6ftcwbSvl5ouIz7
 qSNu17KM2ld7um6qic5DpyliKE8YEWBqFqeT6+2T016oT9aJchHhJ1ALJ w==;
X-CSE-ConnectionGUID: vDDzgeMVSZ63YsNYOFpdVg==
X-CSE-MsgGUID: J8RNntSHTYaFeqjEAtumdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75188110"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75188110"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 08:09:05 -0700
X-CSE-ConnectionGUID: YflcKTiFTb+nyPYX0G5sBw==
X-CSE-MsgGUID: vQLS+pKWR1Wqx9CcOVSn9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="224013263"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 08:09:03 -0700
From: Emma Finn <emma.finn@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>, Rupesh Chiluka <rchiluka@marvell.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH 1/2] crypto/qat: fix asym session validation and gen4 EC caps
Date: Mon, 23 Mar 2026 15:08:53 +0000
Message-ID: <20260323150854.2394000-1-emma.finn@intel.com>
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

Fix asym tests to return TEST_SKIPPED when session
creation returns -ENOTSUP. Add missing ECDH, ECDSA and ECPM
capabilities to GEN4 asym caps table. Reject unsupported RSA
padding and EC curves at session configure time with -ENOTSUP.

Bugzilla ID: 1903
Fixes: 064ef1b098d1 ("test/crypto: remove PMD-specific asym test suites")

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test/test_cryptodev_asym.c               | 38 ++++++++++++++++----
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c | 13 +++++++
 drivers/crypto/qat/qat_asym.c                | 10 ++++++
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 793cc5dce6..1515372a35 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -318,6 +318,9 @@ test_rsa_sign_verify(void)
 error_exit:
 	rte_cryptodev_asym_session_free(dev_id, sess);
 
+	if (status == TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, "Test failed");
 
 	return status;
@@ -368,6 +371,9 @@ test_rsa_enc_dec(void)
 
 	rte_cryptodev_asym_session_free(dev_id, sess);
 
+	if (status == TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, "Test failed");
 
 	return status;
@@ -414,6 +420,9 @@ test_rsa_sign_verify_crt(void)
 
 	rte_cryptodev_asym_session_free(dev_id, sess);
 
+	if (status == TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, "Test failed");
 
 	return status;
@@ -460,6 +469,9 @@ test_rsa_enc_dec_crt(void)
 
 	rte_cryptodev_asym_session_free(dev_id, sess);
 
+	if (status == TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, "Test failed");
 
 	return status;
@@ -1712,6 +1724,8 @@ test_ecdsa_sign_verify_all_curve(void)
 		status = test_ecdsa_sign_verify(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
@@ -1901,6 +1915,8 @@ test_ecpm_all_curve(void)
 		status = test_ecpm(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
@@ -1956,10 +1972,10 @@ test_ecdh_priv_key_generate(enum curve curve_id)
 	idx.type = RTE_CRYPTO_ASYM_XFORM_ECDH;
 	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
 	if (capa == NULL)
-		return -ENOTSUP;
+		return TEST_SKIPPED;
 
 	if (!(capa->op_types & (1 <<  RTE_CRYPTO_ASYM_KE_PRIV_KEY_GENERATE)))
-		return -ENOTSUP;
+		return TEST_SKIPPED;
 
 	switch (curve_id) {
 	case SECP192R1:
@@ -2269,10 +2285,10 @@ test_ecdh_pub_key_verify(enum curve curve_id)
 	idx.type = RTE_CRYPTO_ASYM_XFORM_ECDH;
 	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
 	if (capa == NULL)
-		return -ENOTSUP;
+		return TEST_SKIPPED;
 
 	if (!(capa->op_types & (1 <<  RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)))
-		return -ENOTSUP;
+		return TEST_SKIPPED;
 
 	switch (curve_id) {
 	case SECP192R1:
@@ -2408,10 +2424,10 @@ test_ecdh_shared_secret(enum curve curve_id)
 	idx.type = RTE_CRYPTO_ASYM_XFORM_ECDH;
 	capa = rte_cryptodev_asym_capability_get(dev_id, &idx);
 	if (capa == NULL)
-		return -ENOTSUP;
+		return TEST_SKIPPED;
 
 	if (!(capa->op_types & (1 <<  RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE)))
-		return -ENOTSUP;
+		return TEST_SKIPPED;
 
 	switch (curve_id) {
 	case SECP192R1:
@@ -2668,6 +2684,8 @@ test_ecdh_all_curve(void)
 		status = test_ecdh_priv_key_generate(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
@@ -2700,6 +2718,8 @@ test_ecdh_all_curve(void)
 		status = test_ecdh_pub_key_verify(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
@@ -2715,6 +2735,8 @@ test_ecdh_all_curve(void)
 		status = test_ecdh_shared_secret(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
@@ -2752,6 +2774,8 @@ test_ecdh_qat_curves(void)
 		status = test_ecdh_pub_key_verify(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
@@ -2764,6 +2788,8 @@ test_ecdh_qat_curves(void)
 		status = test_ecdh_shared_secret(curve_id);
 		if (status == TEST_SUCCESS) {
 			msg = "succeeded";
+		} else if (status == TEST_SKIPPED) {
+			msg = "skipped";
 		} else {
 			msg = "failed";
 			overall_status = status;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 82c5a40501..52577f6907 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -144,6 +144,19 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] = {
 		}
 		}
 	},
+	QAT_ASYM_CAP(ECDH,
+			((1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
+			(1 << RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
+			(1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)),
+			64, 512, 64),
+	QAT_ASYM_CAP(ECDSA,
+			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+			64, 512, 64),
+	QAT_ASYM_CAP(ECPM,
+			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+			64, 512, 64),
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index 06f037cc14..beb5a27805 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -1483,6 +1483,12 @@ static int
 session_set_ec(struct qat_asym_session *qat_session,
 			struct rte_crypto_asym_xform *xform)
 {
+	/* Validate curve for EC operations using pick_curve (not SM2) */
+	if (xform->xform_type != RTE_CRYPTO_ASYM_XFORM_SM2) {
+		if (pick_curve(xform) < 0)
+			return -ENOTSUP;
+	}
+
 	uint8_t *pkey = xform->ec.pkey.data;
 	uint8_t *q_x = xform->ec.q.x.data;
 	uint8_t *q_y = xform->ec.q.y.data;
@@ -1545,6 +1551,10 @@ qat_asym_session_configure(struct rte_cryptodev *dev __rte_unused,
 		ret = session_set_modinv(qat_session, xform);
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_RSA: {
+		if (xform->rsa.padding.type != RTE_CRYPTO_RSA_PADDING_NONE) {
+			ret = -ENOTSUP;
+			return ret;
+		}
 		if (unlikely((xform->rsa.n.length < RSA_MODULUS_2048_BITS)
 				&& (crypto_qat->qat_dev->options.legacy_alg == 0))) {
 			ret = -ENOTSUP;
-- 
2.43.0

