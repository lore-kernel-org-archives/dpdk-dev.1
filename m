Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83516C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 09:23:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ED964028E;
	Tue,  3 Jun 2025 11:23:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 292044025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 11:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748942612; x=1780478612;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=F55dn7uEddkCkYFyc0NYZRKoFLmFBE+g4LqYZRlY8oA=;
 b=ZNWw+E3aMN1jR+0knEFx406N7WDsh8+LCz5xaNkdh31PwBS+NGBMuVTH
 cXzPATeBdbs0N90lI/tD/FnH24LbDo43FWzZfYUD2n5N8O7DKuThVm6xC
 ZuBrhpOISYy9EKGzvDkNpjKhBo9M0AnuRg8YbZ8FSOrTtU8OKj6ILVfWX
 BWH181g5g2ANnS2NVx9LaddRzCSaLgIehEZx3aopB8y5NDiwv+sTl7Er0
 ouFd3izfzDV4Mkm3qDCRFcyAuJ8rONozCQqh3IpEC1KNZ7oAgyJOCD7mf
 6dcQdEcTiKB9NPcBypJEaRxyRAmoZBSi9lelwXqzCz/HRfE9H0E12UqAf w==;
X-CSE-ConnectionGUID: AD6PSxeTSbi6+viadFRh2w==
X-CSE-MsgGUID: 4PHI3GA4QtGW6o7x053LJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51040178"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="51040178"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 02:23:30 -0700
X-CSE-ConnectionGUID: Uwo56PI+R+Ko2/ieNpqVVQ==
X-CSE-MsgGUID: H1a1WxZ1Qt+sVLj3UvhPOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="144835866"
Received: from unknown (HELO silpixa00401749.ger.corp.intel.com)
 ([10.237.222.190])
 by orviesa009.jf.intel.com with ESMTP; 03 Jun 2025 02:23:28 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH] crypto/qat: remove ZUC 256 support
Date: Tue,  3 Jun 2025 09:23:24 +0000
Message-ID: <20250603092324.66743-1-radu.nicolau@intel.com>
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

Remove ZUC 256 support from Gen 3 and 5 hardware

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/rel_notes/release_25_07.rst       |  5 +++
 drivers/common/qat/qat_adf/icp_qat_hw.h      |  2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 40 +-------------------
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 36 ++----------------
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 20 ----------
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    | 33 ----------------
 drivers/crypto/qat/qat_sym_session.c         | 25 ++----------
 drivers/crypto/qat/qat_sym_session.h         |  1 -
 8 files changed, 14 insertions(+), 148 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 11bb6d34f7..07bfa71700 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -87,6 +87,11 @@ New Features
 Removed Items
 -------------
 
+* **Removed ZUC-256 algorithms from Intel QuickAssist Technology (QAT) PMD.**
+
+  Support for ZUC-256 cipher and integrity algorithms was removed from
+  Gen 3 and Gen 5 PMD.
+
 .. This section should contain removed items in this release. Sample format:
 
    * Add a short 1-2 sentence description of the removed item
diff --git a/drivers/common/qat/qat_adf/icp_qat_hw.h b/drivers/common/qat/qat_adf/icp_qat_hw.h
index 1d61a0b833..e929b16df2 100644
--- a/drivers/common/qat/qat_adf/icp_qat_hw.h
+++ b/drivers/common/qat/qat_adf/icp_qat_hw.h
@@ -367,7 +367,7 @@ enum icp_qat_hw_cipher_convert {
 #define ICP_QAT_HW_CHACHAPOLY_ICV_SZ 16
 #define ICP_QAT_HW_CHACHAPOLY_AAD_MAX_LOG 14
 #define ICP_QAT_HW_ZUC_256_KEY_SZ 32
-#define ICP_QAT_HW_ZUC_256_IV_SZ 24
+#define ICP_QAT_HW_ZUC_256_IV_SZ 16
 
 #define ICP_QAT_HW_CIPHER_MAX_KEY_SZ ICP_QAT_HW_AES_256_F8_KEY_SZ
 
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index af664fb9b9..f2ff952482 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -204,7 +204,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_private *internals,
 	uint32_t legacy_size = sizeof(qat_sym_crypto_legacy_caps_gen3);
 	capa_num = size/sizeof(struct rte_cryptodev_capabilities);
 	legacy_capa_num = legacy_size/sizeof(struct rte_cryptodev_capabilities);
-	struct rte_cryptodev_capabilities *cap;
 
 	if (unlikely(internals->qat_dev->options.legacy_alg))
 		size = size + legacy_size;
@@ -258,14 +257,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_private *internals,
 			continue;
 		}
 
-		if (slice_map & ICP_ACCEL_MASK_ZUC_256_SLICE && (
-			check_auth_capa(&capabilities[iter],
-				RTE_CRYPTO_AUTH_ZUC_EIA3) ||
-			check_cipher_capa(&capabilities[iter],
-				RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
-			continue;
-		}
-
 		if (internals->qat_dev->options.has_wireless_slice && (
 			check_auth_capa(&capabilities[iter],
 				RTE_CRYPTO_AUTH_KASUMI_F9) ||
@@ -279,27 +270,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_private *internals,
 
 		memcpy(addr + curr_capa, capabilities + iter,
 			sizeof(struct rte_cryptodev_capabilities));
-
-		if (internals->qat_dev->options.has_wireless_slice && (
-			check_auth_capa(&capabilities[iter],
-				RTE_CRYPTO_AUTH_ZUC_EIA3))) {
-			cap = addr + curr_capa;
-			cap->sym.auth.key_size.max = 32;
-			cap->sym.auth.key_size.increment = 16;
-			cap->sym.auth.iv_size.max = 25;
-			cap->sym.auth.iv_size.increment = 1;
-			cap->sym.auth.digest_size.max = 16;
-			cap->sym.auth.digest_size.increment = 4;
-		}
-		if (internals->qat_dev->options.has_wireless_slice && (
-			check_cipher_capa(&capabilities[iter],
-				RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
-			cap = addr + curr_capa;
-			cap->sym.cipher.key_size.max = 32;
-			cap->sym.cipher.key_size.increment = 16;
-			cap->sym.cipher.iv_size.max = 25;
-			cap->sym.cipher.iv_size.increment = 1;
-		}
 		curr_capa++;
 	}
 	internals->qat_dev_capabilities = internals->capa_mz->addr;
@@ -558,16 +528,8 @@ qat_sym_crypto_set_session_gen3(void *cdev, void *session)
 				(ctx->qat_cipher_alg ==
 				ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_UEA2 ||
 				ctx->qat_cipher_alg ==
-				ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3 ||
-				ctx->qat_cipher_alg == ICP_QAT_HW_CIPHER_ALGO_ZUC_256))) {
+				ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3))) {
 			qat_sym_session_set_ext_hash_flags_gen2(ctx, 0);
-		} else if ((internals->qat_dev->options.has_wireless_slice) &&
-			(ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_32 ||
-				ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_64 ||
-				ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_128) &&
-				ctx->qat_cipher_alg != ICP_QAT_HW_CIPHER_ALGO_ZUC_256) {
-			qat_sym_session_set_ext_hash_flags_gen2(ctx,
-					1 << ICP_QAT_FW_AUTH_HDR_FLAG_ZUC_EIA3_BITPOS);
 		}
 
 		ret = 0;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
index e1302e9b36..db27819f84 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -113,11 +113,11 @@ static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen5[] = {
 		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
 	QAT_SYM_CIPHER_CAP(ZUC_EEA3,
 		CAP_SET(block_size, 16),
-		CAP_RNG(key_size, 16, 32, 16), CAP_RNG(iv_size, 16, 25, 1)),
+		CAP_RNG(key_size, 16, 16, 0), CAP_RNG(iv_size, 16, 16, 0)),
 	QAT_SYM_AUTH_CAP(ZUC_EIA3,
 		CAP_SET(block_size, 16),
-		CAP_RNG(key_size, 16, 32, 16), CAP_RNG(digest_size, 4, 16, 4),
-		CAP_RNG_ZERO(aad_size), CAP_RNG(iv_size, 16, 25, 1)),
+		CAP_RNG(key_size, 16, 16, 0), CAP_RNG(digest_size, 4, 16, 4),
+		CAP_RNG_ZERO(aad_size), CAP_RNG(iv_size, 16, 16, 0)),
 	QAT_SYM_CIPHER_CAP(SNOW3G_UEA2,
 		CAP_SET(block_size, 16),
 		CAP_RNG(key_size, 16, 16, 0), CAP_RNG(iv_size, 16, 16, 0)),
@@ -141,19 +141,6 @@ check_cipher_capa(const struct rte_cryptodev_capabilities *cap,
 	return 1;
 }
 
-static int
-check_auth_capa(const struct rte_cryptodev_capabilities *cap,
-		enum rte_crypto_auth_algorithm algo)
-{
-	if (cap->op != RTE_CRYPTO_OP_TYPE_SYMMETRIC)
-		return 0;
-	if (cap->sym.xform_type != RTE_CRYPTO_SYM_XFORM_AUTH)
-		return 0;
-	if (cap->sym.auth.algo != algo)
-		return 0;
-	return 1;
-}
-
 static int
 qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,
 			const char *capa_memz_name,
@@ -195,14 +182,6 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,
 	capabilities = qat_sym_crypto_caps_gen5;
 
 	for (i = 0; i < capa_num; i++, iter++) {
-		if (slice_map & ICP_ACCEL_MASK_ZUC_256_SLICE && (
-			check_auth_capa(&capabilities[iter],
-				RTE_CRYPTO_AUTH_ZUC_EIA3) ||
-			check_cipher_capa(&capabilities[iter],
-				RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
-			continue;
-		}
-
 		memcpy(addr + curr_capa, capabilities + iter,
 			sizeof(struct rte_cryptodev_capabilities));
 		curr_capa++;
@@ -233,15 +212,8 @@ qat_sym_crypto_set_session_gen5(void *cdev, void *session)
 				(ctx->qat_cipher_alg ==
 				ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_UEA2 ||
 				ctx->qat_cipher_alg ==
-				ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3 ||
-				ctx->qat_cipher_alg == ICP_QAT_HW_CIPHER_ALGO_ZUC_256)) {
+				ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3)) {
 			qat_sym_session_set_ext_hash_flags_gen2(ctx, 0);
-		} else if ((ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_32 ||
-				ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_64 ||
-				ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_128) &&
-				ctx->qat_cipher_alg != ICP_QAT_HW_CIPHER_ALGO_ZUC_256) {
-			qat_sym_session_set_ext_hash_flags_gen2(ctx,
-					1 << ICP_QAT_FW_AUTH_HDR_FLAG_ZUC_EIA3_BITPOS);
 		}
 
 		ret = 0;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 846636f57d..1f19c69f88 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -881,26 +881,6 @@ qat_sym_convert_op_to_vec_aead(struct rte_crypto_op *op,
 	return 0;
 }
 
-static inline void
-zuc256_modify_iv(uint8_t *iv)
-{
-	uint8_t iv_tmp[8];
-
-	iv_tmp[0] = iv[16];
-	/* pack the last 8 bytes of IV to 6 bytes.
-	 * discard the 2 MSB bits of each byte
-	 */
-	iv_tmp[1] = (((iv[17] & 0x3f) << 2) | ((iv[18] >> 4) & 0x3));
-	iv_tmp[2] = (((iv[18] & 0xf) << 4) | ((iv[19] >> 2) & 0xf));
-	iv_tmp[3] = (((iv[19] & 0x3) << 6) | (iv[20] & 0x3f));
-
-	iv_tmp[4] = (((iv[21] & 0x3f) << 2) | ((iv[22] >> 4) & 0x3));
-	iv_tmp[5] = (((iv[22] & 0xf) << 4) | ((iv[23] >> 2) & 0xf));
-	iv_tmp[6] = (((iv[23] & 0x3) << 6) | (iv[24] & 0x3f));
-
-	memcpy(iv + 16, iv_tmp, 8);
-}
-
 static __rte_always_inline void
 qat_set_cipher_iv(struct icp_qat_fw_la_cipher_req_params *cipher_param,
 		struct rte_crypto_va_iova_ptr *iv_ptr, uint32_t iv_len,
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
index 561166203c..8cb85fd8df 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -248,9 +248,6 @@ qat_sym_build_op_cipher_gen1(void *in_op, struct qat_sym_session *ctx,
 		return -EINVAL;
 	}
 
-	if (ctx->is_zuc256)
-		zuc256_modify_iv(cipher_iv.va);
-
 	enqueue_one_cipher_job_gen1(ctx, req, &cipher_iv, ofs, total_len, op_cookie);
 
 	qat_sym_debug_log_dump(req, ctx, in_sgl.vec, in_sgl.num, &cipher_iv,
@@ -303,9 +300,6 @@ qat_sym_build_op_auth_gen1(void *in_op, struct qat_sym_session *ctx,
 		return -EINVAL;
 	}
 
-	if (ctx->is_zuc256)
-		zuc256_modify_iv(auth_iv.va);
-
 	enqueue_one_auth_job_gen1(ctx, req, &digest, &auth_iv, ofs,
 			total_len);
 
@@ -396,11 +390,6 @@ qat_sym_build_op_chain_gen1(void *in_op, struct qat_sym_session *ctx,
 		return -EINVAL;
 	}
 
-	if (ctx->is_zuc256) {
-		zuc256_modify_iv(cipher_iv.va);
-		zuc256_modify_iv(auth_iv.va);
-	}
-
 	enqueue_one_chain_job_gen1(ctx, req, in_sgl.vec, in_sgl.num,
 			out_sgl.vec, out_sgl.num, &cipher_iv, &digest, &auth_iv,
 			ofs, total_len, cookie);
@@ -527,9 +516,6 @@ qat_sym_dp_enqueue_single_cipher_gen1(void *qp_data, uint8_t *drv_ctx,
 	if (unlikely(data_len < 0))
 		return -1;
 
-	if (ctx->is_zuc256)
-		zuc256_modify_iv(iv->va);
-
 	enqueue_one_cipher_job_gen1(ctx, req, iv, ofs, (uint32_t)data_len, cookie);
 
 	qat_sym_debug_log_dump(req, ctx, data, n_data_vecs, iv,
@@ -591,9 +577,6 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 		if (unlikely(data_len < 0 || error))
 			break;
 
-		if (ctx->is_zuc256)
-			zuc256_modify_iv(vec->iv[i].va);
-
 		enqueue_one_cipher_job_gen1(ctx, req, &vec->iv[i], ofs,
 			(uint32_t)data_len, cookie);
 		tail = (tail + tx_queue->msg_size) & tx_queue->modulo_mask;
@@ -644,9 +627,6 @@ qat_sym_dp_enqueue_single_auth_gen1(void *qp_data, uint8_t *drv_ctx,
 	if (unlikely(data_len < 0))
 		return -1;
 
-	if (ctx->is_zuc256)
-		zuc256_modify_iv(auth_iv->va);
-
 	if (ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL) {
 		null_digest.iova = cookie->digest_null_phys_addr;
 		job_digest = &null_digest;
@@ -716,9 +696,6 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 		if (unlikely(data_len < 0 || error))
 			break;
 
-		if (ctx->is_zuc256)
-			zuc256_modify_iv(vec->auth_iv[i].va);
-
 		if (ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL) {
 			null_digest.iova = cookie->digest_null_phys_addr;
 			job_digest = &null_digest;
@@ -774,11 +751,6 @@ qat_sym_dp_enqueue_single_chain_gen1(void *qp_data, uint8_t *drv_ctx,
 	if (unlikely(data_len < 0))
 		return -1;
 
-	if (ctx->is_zuc256) {
-		zuc256_modify_iv(cipher_iv->va);
-		zuc256_modify_iv(auth_iv->va);
-	}
-
 	if (ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL) {
 		null_digest.iova = cookie->digest_null_phys_addr;
 		job_digest = &null_digest;
@@ -849,11 +821,6 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 		if (unlikely(data_len < 0 || error))
 			break;
 
-		if (ctx->is_zuc256) {
-			zuc256_modify_iv(vec->iv[i].va);
-			zuc256_modify_iv(vec->auth_iv[i].va);
-		}
-
 		if (ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL) {
 			null_digest.iova = cookie->digest_null_phys_addr;
 			job_digest = &null_digest;
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 7f370f03fb..8489e26e28 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -541,8 +541,6 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 			goto error_out;
 		}
 		session->qat_mode = ICP_QAT_HW_CIPHER_ECB_MODE;
-		if (cipher_xform->key.length == ICP_QAT_HW_ZUC_256_KEY_SZ)
-			session->is_zuc256 = 1;
 		if (internals->qat_dev->options.has_wireless_slice)
 			is_wireless = 1;
 		break;
@@ -989,25 +987,8 @@ qat_sym_session_configure_auth(struct rte_cryptodev *dev,
 				rte_cryptodev_get_auth_algo_string(auth_xform->algo));
 			return -ENOTSUP;
 		}
-		if (key_length == ICP_QAT_HW_ZUC_3G_EEA3_KEY_SZ)
+		if (key_length == ICP_QAT_HW_ZUC_3G_EEA3_KEY_SZ) {
 			session->qat_hash_alg = ICP_QAT_HW_AUTH_ALGO_ZUC_3G_128_EIA3;
-		else if (key_length == ICP_QAT_HW_ZUC_256_KEY_SZ) {
-			switch (auth_xform->digest_length) {
-			case 4:
-				session->qat_hash_alg = ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_32;
-				break;
-			case 8:
-				session->qat_hash_alg = ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_64;
-				break;
-			case 16:
-				session->qat_hash_alg = ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_128;
-				break;
-			default:
-				QAT_LOG(ERR, "Invalid digest length: %d",
-						auth_xform->digest_length);
-				return -ENOTSUP;
-			}
-			session->is_zuc256 = 1;
 		} else {
 			QAT_LOG(ERR, "Invalid key length: %d", key_length);
 			return -ENOTSUP;
@@ -2238,8 +2219,8 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cdesc,
 		cdesc->qat_proto_flag = QAT_CRYPTO_PROTO_FLAG_ZUC;
 	} else if (cdesc->qat_cipher_alg ==
 			ICP_QAT_HW_CIPHER_ALGO_ZUC_256) {
-		if (cdesc->cipher_iv.length != 23 && cdesc->cipher_iv.length != 25) {
-			QAT_LOG(ERR, "Invalid IV length for ZUC256, must be 23 or 25.");
+		if (cdesc->cipher_iv.length != ICP_QAT_HW_ZUC_256_IV_SZ) {
+			QAT_LOG(ERR, "Invalid IV length for ZUC256");
 			return -EINVAL;
 		}
 		total_key_size = ICP_QAT_HW_ZUC_256_KEY_SZ +
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_sym_session.h
index 2ef2066646..0c7b9cc6cf 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -147,7 +147,6 @@ struct qat_sym_session {
 	uint8_t is_auth;
 	uint8_t is_cnt_zero;
 	/* Some generations need different setup of counter */
-	uint8_t is_zuc256;
 	uint8_t is_wireless;
 	uint32_t slice_types;
 	struct rte_net_crc *crc;
-- 
2.43.0

