Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA71F4613B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:09:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17A684065D;
	Mon, 23 Mar 2026 16:09:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D9F614064E
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774278547; x=1805814547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/J/Ggtk/3rezi8XOW4TWvoWBUN5xJp2gNKdv7fttIPo=;
 b=l55oXPxSnq+J7Bd0fybBEJQmkFMpWopH7iCtk0SbgRhl9T3KHxNysz41
 uMWjoP3XlOkK/qfdLrNYS0dmjb+nLYqkGf+IqsGEXjIJNRyxkeBxzSNrr
 gFuzh5zMxfToXsszUHtuYfppQ6VaiGUwekwbRv5gBYf5WFMfvGRipHAd6
 cnRGJE09ed1eT3UCnsyRmR/iQ+6romdzczzvLtFvO5HADH4dz8RbuT1YA
 3bcVIqKwCLX5vnN4WP1gSYYD6TxtRW65Fl5GR1fMjgBf1gwxymsamH9YY
 NTk8z0fBeS1nUXLipxV+DSott4ZfnlITw4dx+3updpt2yc57BmPpk361N Q==;
X-CSE-ConnectionGUID: 8MpEqBptTbyw8+VKGhFucQ==
X-CSE-MsgGUID: qQhaAoQaTxafX6hDygmpnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75188113"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75188113"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 08:09:07 -0700
X-CSE-ConnectionGUID: sg264y8XR7S79L/4ZxgEOg==
X-CSE-MsgGUID: tBwyV6f2Se29JCadtiY6CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="224013276"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 08:09:06 -0700
From: Emma Finn <emma.finn@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>, Rupesh Chiluka <rchiluka@marvell.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH 2/2] crypto/qat: fix modexp and modinv result length and
 comparison
Date: Mon, 23 Mar 2026 15:08:54 +0000
Message-ID: <20260323150854.2394000-2-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323150854.2394000-1-emma.finn@intel.com>
References: <20260323150854.2394000-1-emma.finn@intel.com>
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

QAT HW rounds the output buffer size up to the next supported size,
but result.length was set to alg_bytesize instead of n.length, causing
result comparisons to read past the end of the expected value.

Additionally, when a modulus has a leading zero padding byte, QAT HW
strips it from the result but we never strip it from the expected result,
so the compare fails. Fix verify_modexp() and verify_modinv() to skip
leading zero bytes in the result before comparison.

Fixes: 064ef1b098d1 ("test/crypto: remove PMD-specific asym test suites")

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test/test_cryptodev_asym.c      |  8 ++++++++
 app/test/test_cryptodev_asym_util.h | 20 ++++++++++++++++----
 drivers/crypto/qat/qat_asym.c       |  7 +++----
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 1515372a35..07e5eb5842 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -3826,6 +3826,14 @@ modular_exponentiation(const void *test_data)
 	uint8_t result[TEST_DATA_SIZE] = { 0 };
 	struct rte_crypto_asym_xform xform = { };
 	const uint8_t dev_id = params->valid_devs[0];
+	const struct rte_cryptodev_asymmetric_xform_capability *cap;
+	struct rte_cryptodev_asym_capability_idx cap_idx;
+
+	cap_idx.type = RTE_CRYPTO_ASYM_XFORM_MODEX;
+	cap = rte_cryptodev_asym_capability_get(dev_id, &cap_idx);
+	if (cap == NULL || rte_cryptodev_asym_xform_capability_check_modlen(
+			cap, vector->modulus.len))
+		return TEST_SKIPPED;
 
 	memcpy(input, vector->base.data, vector->base.len);
 	memcpy(exponent, vector->exponent.data, vector->exponent.len);
diff --git a/app/test/test_cryptodev_asym_util.h b/app/test/test_cryptodev_asym_util.h
index 07e6e831e8..16e4c0da6c 100644
--- a/app/test/test_cryptodev_asym_util.h
+++ b/app/test/test_cryptodev_asym_util.h
@@ -20,8 +20,14 @@ static inline int rsa_verify(struct rsa_test_data *rsa_param,
 static inline int verify_modinv(uint8_t *mod_inv,
 		struct rte_crypto_op *result_op)
 {
-	if (memcmp(mod_inv, result_op->asym->modinv.result.data,
-				result_op->asym->modinv.result.length))
+	const uint8_t *b = result_op->asym->modinv.result.data;
+	size_t b_len = result_op->asym->modinv.result.length;
+
+	while (b_len > 1 && b[0] == 0) {
+		b++;
+		b_len--;
+	}
+	if (memcmp(mod_inv, b, b_len))
 		return -1;
 	return 0;
 }
@@ -29,8 +35,14 @@ static inline int verify_modinv(uint8_t *mod_inv,
 static inline int verify_modexp(uint8_t *mod_exp,
 		struct rte_crypto_op *result_op)
 {
-	if (memcmp(mod_exp, result_op->asym->modex.result.data,
-				result_op->asym->modex.result.length))
+	const uint8_t *b = result_op->asym->modex.result.data;
+	size_t b_len = result_op->asym->modex.result.length;
+
+	while (b_len > 1 && b[0] == 0) {
+		b++;
+		b_len--;
+	}
+	if (memcmp(mod_exp, b, b_len))
 		return -1;
 	return 0;
 }
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index beb5a27805..7a296cad6c 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -274,7 +274,7 @@ modexp_collect(struct rte_crypto_asym_op *asym_op,
 	rte_memcpy(modexp_result,
 		cookie->output_array[0] + alg_bytesize
 		- n.length, n.length);
-	asym_op->modex.result.length = alg_bytesize;
+	asym_op->modex.result.length = n.length;
 	HEXDUMP("ModExp result", cookie->output_array[0],
 			alg_bytesize);
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
@@ -332,11 +332,10 @@ modinv_collect(struct rte_crypto_asym_op *asym_op,
 		QAT_LOG(ERR, "Incorrect length of modinv modulus");
 		return RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 	}
-	rte_memcpy(modinv_result + (asym_op->modinv.result.length
-		- n.length),
+	rte_memcpy(modinv_result,
 		cookie->output_array[0] + alg_bytesize
 		- n.length, n.length);
-	asym_op->modinv.result.length = alg_bytesize;
+	asym_op->modinv.result.length = n.length;
 	HEXDUMP("ModInv result", cookie->output_array[0],
 			alg_bytesize);
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
-- 
2.43.0

