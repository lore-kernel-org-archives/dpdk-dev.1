Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739AC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 10:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEDA340B8F;
	Fri, 11 Apr 2025 12:14:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 306A4406B6
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366471; x=1775902471;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QLfW10HHf+GjWxOglCnNwKKoKwh4FXWGh2zf8uYYK44=;
 b=W4n4gh/KRtmXKREKpE/z5AuxPgrsd/drhbfPL6b8ebFrP/hCtq9HZ5gj
 3hU1mbD0luVatUrK/CMLVn4g2ZGiL55hSUvkTBpDigsqpr+kI3fJR4AUn
 lq9MqZbR0g71htMvOmR9iohAlFhXaDE3P+Z9kodZiMvpb3rJE5xt+daAU
 NG9Ag1YBEUcFlOnBWlj0SHRSffgD42UoEkTdR6ul7IgC5tehlfneQwl9w
 PZp6EnSh90tFhjJqJlx96npJv+GIb1uCqEPLNWCB7HrPHlK2WQCc6Nqn+
 eScVY96RpWSZPmIatxffmNEoNs1590r4mFRPVIts4U7JOvxi/4hTQlAIW Q==;
X-CSE-ConnectionGUID: SOz0kv0IT7e49yKnX7/qsw==
X-CSE-MsgGUID: IdzPX70YR6OsmD61+yvr4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56896767"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56896767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:14:31 -0700
X-CSE-ConnectionGUID: sdJ66L2lR7KwG0O4bd/DZg==
X-CSE-MsgGUID: luwzH/FAQDSN4jI/nBbptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="160130576"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa002.jf.intel.com with ESMTP; 11 Apr 2025 03:14:30 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 1/5] crypto/ipsec_mb: add support for SNOW-V
Date: Fri, 11 Apr 2025 11:09:37 +0100
Message-ID: <20250411101425.3041736-2-radu.nicolau@intel.com>
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

Add support for SNOW-V and SNOW-V AEAD algorithms to
crypto/ipsec_mb PMD.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |  2 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 70 +++++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 52 +++++++++++++++
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 8d7e221e79..383c4a55ce 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -39,6 +39,7 @@ Cipher algorithms:
 * RTE_CRYPTO_CIPHER_SM4_CBC
 * RTE_CRYPTO_CIPHER_SM4_ECB
 * RTE_CRYPTO_CIPHER_SM4_CTR
+* RTE_CRYPTO_CIPHER_SNOW_V
 
 Hash algorithms:
 
@@ -68,6 +69,7 @@ AEAD algorithms:
 * RTE_CRYPTO_AEAD_AES_GCM
 * RTE_CRYPTO_AEAD_CHACHA20_POLY1305
 * RTE_CRYPTO_AEAD_SM4_GCM
+* RTE_CRYPTO_AEAD_SNOW_V
 
 Protocol offloads:
 
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..60896d74fc 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -20,7 +20,8 @@ is_aead_algo(IMB_HASH_ALG hash_alg, IMB_CIPHER_MODE cipher_mode)
 {
 	return (hash_alg == IMB_AUTH_CHACHA20_POLY1305 ||
 		hash_alg == IMB_AUTH_AES_CCM ||
-		cipher_mode == IMB_CIPHER_GCM
+		cipher_mode == IMB_CIPHER_GCM ||
+		cipher_mode == IMB_CIPHER_SNOW_V_AEAD
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 		|| cipher_mode == IMB_CIPHER_SM4_GCM
 #endif
@@ -353,6 +354,7 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 	uint8_t is_zuc = 0;
 	uint8_t is_snow3g = 0;
 	uint8_t is_kasumi = 0;
+	uint8_t is_snow_v = 0;
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	uint8_t is_sm4 = 0;
 #endif
@@ -416,6 +418,10 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 		sess->template_job.cipher_mode = IMB_CIPHER_SNOW3G_UEA2_BITLEN;
 		is_snow3g = 1;
 		break;
+	case RTE_CRYPTO_CIPHER_SNOW_V:
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW_V;
+		is_snow_v = 1;
+		break;
 	case RTE_CRYPTO_CIPHER_KASUMI_F8:
 		sess->template_job.cipher_mode = IMB_CIPHER_KASUMI_UEA1_BITLEN;
 		is_kasumi = 1;
@@ -576,6 +582,17 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 					&sess->cipher.pKeySched_kasumi_cipher);
 		sess->template_job.enc_keys = &sess->cipher.pKeySched_kasumi_cipher;
 		sess->template_job.dec_keys = &sess->cipher.pKeySched_kasumi_cipher;
+	} else if (is_snow_v) {
+		if (xform->cipher.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid cipher key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		sess->template_job.iv_len_in_bytes = 16;
+		memcpy(sess->cipher.snow_v_cipher_key, xform->cipher.key.data,
+			xform->cipher.key.length);
+		sess->template_job.enc_keys = sess->cipher.snow_v_cipher_key;
+		sess->template_job.dec_keys = sess->cipher.snow_v_cipher_key;
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	} else if (is_sm4) {
 		sess->template_job.key_len_in_bytes = IMB_KEY_128_BYTES;
@@ -724,6 +741,26 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 			return -EINVAL;
 		}
 		break;
+	case RTE_CRYPTO_AEAD_SNOW_V:
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW_V_AEAD;
+		sess->template_job.hash_alg = IMB_AUTH_SNOW_V_AEAD;
+		sess->template_job.u.SNOW_V_AEAD.aad_len_in_bytes =
+			xform->aead.aad_length;
+
+		if (xform->aead.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		memcpy(sess->cipher.snow_v_cipher_key, xform->cipher.key.data,
+			xform->cipher.key.length);
+		sess->template_job.enc_keys = sess->cipher.snow_v_cipher_key;
+		sess->template_job.dec_keys = sess->cipher.snow_v_cipher_key;
+		if (sess->auth.req_digest_len != 16) {
+			IPSEC_MB_LOG(ERR, "Invalid digest size");
+			return -EINVAL;
+		}
+		break;
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case RTE_CRYPTO_AEAD_SM4_GCM:
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_GCM;
@@ -1058,6 +1095,10 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 		job->u.CHACHA20_POLY1305.aad = aad->va;
 		break;
 
+	case IMB_AUTH_SNOW_V_AEAD:
+		job->u.SNOW_V_AEAD.aad = aad->va;
+		break;
+
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_AUTH_SM4_GCM:
 		job->u.GCM.aad = aad->va;
@@ -1440,7 +1481,8 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_op *op, IMB_JOB *job,
 
 	if (job->cipher_mode == IMB_CIPHER_ZUC_EEA3 ||
 		job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
-		job->cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN) {
+		job->cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN ||
+		job->cipher_mode == IMB_CIPHER_SNOW_V) {
 		cipher_size = (op->sym->cipher.data.offset >> 3) +
 			(op->sym->cipher.data.length >> 3);
 	} else {
@@ -1586,6 +1628,9 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 			imb_set_session(mb_mgr, job);
 		}
 		break;
+	case IMB_AUTH_SNOW_V_AEAD:
+		job->u.SNOW_V_AEAD.aad = op->sym->aead.aad.data;
+		break;
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_AUTH_SM4_GCM:
 		job->u.GCM.aad = op->sym->aead.aad.data;
@@ -1606,6 +1651,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		m_offset = 0;
 	else if (cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN)
 		m_offset = 0;
+	else if (cipher_mode == IMB_CIPHER_SNOW_V)
+		m_offset >>= 3;
 
 	/* Set digest output location */
 	if (job->hash_alg != IMB_AUTH_NULL &&
@@ -1719,6 +1766,14 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 			session->iv.offset);
 		break;
+	case IMB_AUTH_SNOW_V_AEAD:
+		job->hash_start_src_offset_in_bytes =
+				op->sym->aead.data.offset;
+		job->msg_len_to_hash_in_bytes =
+				op->sym->aead.data.length;
+		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+				session->iv.offset);
+		break;
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_AUTH_SM4_GCM:
 		job->hash_start_src_offset_in_bytes = 0;
@@ -1747,8 +1802,9 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 	}
 
 	switch (job->cipher_mode) {
-	/* ZUC requires length and offset in bytes */
+	/* ZUC and SNOW V requires length and offset in bytes */
 	case IMB_CIPHER_ZUC_EEA3:
+	case IMB_CIPHER_SNOW_V:
 		job->cipher_start_src_offset_in_bytes =
 					op->sym->cipher.data.offset >> 3;
 		job->msg_len_to_cipher_in_bytes =
@@ -1778,6 +1834,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->msg_len_to_cipher_in_bytes = 0;
 		job->cipher_start_src_offset_in_bytes = 0;
 		break;
+	case IMB_CIPHER_SNOW_V_AEAD:
+		job->cipher_start_src_offset_in_bytes =
+			op->sym->aead.data.offset;
+		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
+		break;
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_CIPHER_SM4_GCM:
 		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
@@ -2034,7 +2095,8 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *job)
 					int unencrypted_bytes = 0;
 					if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
 						job->cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN ||
-						job->cipher_mode == IMB_CIPHER_ZUC_EEA3) {
+						job->cipher_mode == IMB_CIPHER_ZUC_EEA3 ||
+						job->cipher_mode == IMB_CIPHER_SNOW_V) {
 						cipher_size = (op->sym->cipher.data.offset >> 3) +
 							(op->sym->cipher.data.length >> 3);
 					} else {
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 66e8e732ff..6f2eb27ba3 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -725,6 +725,56 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* SNOW V */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_SNOW_V,
+				.block_size = 16,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.iv_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				}
+			}, }
+		}, }
+	},
+	{	/* SNOW V AEAD */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
+			{.aead = {
+				.algo = RTE_CRYPTO_AEAD_SNOW_V,
+				.block_size = 64,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				},
+				.aad_size = {
+					.min = 0,
+					.max = 1024,
+					.increment = 1
+				},
+				.iv_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				},
+			}, }
+		}, }
+	},
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	{	/* SM3 */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
@@ -1028,6 +1078,8 @@ struct __rte_cache_aligned aesni_mb_session {
 			/* *< Expanded GCM key */
 			uint8_t zuc_cipher_key[32];
 			/* *< ZUC cipher key */
+			uint8_t snow_v_cipher_key[32];
+			/* *< SNOW V cipher key */
 			snow3g_key_schedule_t pKeySched_snow3g_cipher;
 			/* *< SNOW3G scheduled cipher key */
 			kasumi_key_sched_t pKeySched_kasumi_cipher;
-- 
2.43.0

