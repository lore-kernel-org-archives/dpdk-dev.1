Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4799CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99CD342E50;
	Fri,  2 Oct 2026 11:57:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4695241144
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790935019; x=1822471019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FsmOxfrhvAmNBoT8BhU+Z5cd23CdhixnygvPHmyRKtI=;
 b=iBygL6wCfyaOI0PWsloNzOCGV5h5lYb+9KHNitR2xD7WZPI66jxPmFTQ
 7fr/z04igF2xUKJcevLiFclTDPLl5JIDPqEPDC2mkX1HhDNa/p6wkCBIr
 7/OqowRtr6DUnFh09NevHHOQRr7j+1s3+i8PKuulEvA6tKBbkfaIX5Ssu
 Yo1BKaGaeMGiJRLatLjjSwu61mtEqewpSIYY/RVXKtw54C9pa+ytyfQFR
 IxL9Q+CYdXkEAlyPxTnwN1RFn1D06WvJJVq+U34zrwooReSQhBdoRguLf
 p08x4jXOrM52HmmKvdaBEKgOf+ac3t0CDssrFDr5v52X7L0YOL1wrbS1G w==;
X-CSE-ConnectionGUID: 5iKizYYoRv2/3DSzxzyKJg==
X-CSE-MsgGUID: vAA+nAd6RNugMtoE1UaJiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94581561"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94581561"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:56:59 -0700
X-CSE-ConnectionGUID: 7qZJM01fSYCNX8DyykstzA==
X-CSE-MsgGUID: HbnsvY+3SS+JGuLNNQqYDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="274862067"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2026 02:56:58 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
Date: Fri,  2 Oct 2026 09:56:22 +0000
Message-ID: <20261002095652.1540556-3-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261002095652.1540556-1-radu.nicolau@intel.com>
References: <20261002095652.1540556-1-radu.nicolau@intel.com>
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

Add support for

NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes
NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes
NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes

IPsec MB library version 3.0 is required for the above algorithms.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |   9 +
 doc/guides/cryptodevs/features/aesni_mb.ini |   9 +
 doc/guides/rel_notes/release_26_11.rst      |   5 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 216 +++++++++++++++++-
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 229 ++++++++++++++++++++
 5 files changed, 467 insertions(+), 1 deletion(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 4851997fd9..5fb73e31b4 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -39,6 +39,9 @@ Cipher algorithms:
 * RTE_CRYPTO_CIPHER_SM4_CBC
 * RTE_CRYPTO_CIPHER_SM4_ECB
 * RTE_CRYPTO_CIPHER_SM4_CTR
+* RTE_CRYPTO_CIPHER_SNOW5G_NEA4
+* RTE_CRYPTO_CIPHER_AES_NEA5
+* RTE_CRYPTO_CIPHER_ZUC_NEA6
 
 Hash algorithms:
 
@@ -61,6 +64,9 @@ Hash algorithms:
 * RTE_CRYPTO_AUTH_KASUMI_F9
 * RTE_CRYPTO_AUTH_SM3
 * RTE_CRYPTO_AUTH_SM3 HMAC
+* RTE_CRYPTO_AUTH_SNOW5G_NIA4
+* RTE_CRYPTO_AUTH_AES_NIA5
+* RTE_CRYPTO_AUTH_ZUC_NIA6
 
 AEAD algorithms:
 
@@ -68,6 +74,9 @@ AEAD algorithms:
 * RTE_CRYPTO_AEAD_AES_GCM
 * RTE_CRYPTO_AEAD_CHACHA20_POLY1305
 * RTE_CRYPTO_AEAD_SM4_GCM
+* RTE_CRYPTO_AEAD_SNOW5G_NCA4
+* RTE_CRYPTO_AEAD_AES_NCA5
+* RTE_CRYPTO_AEAD_ZUC_NCA6
 
 Protocol offloads:
 
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index ce6b43e48b..e64818bf46 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -45,6 +45,9 @@ KASUMI F8      = Y
 SM4 CBC        = Y
 SM4 ECB        = Y
 SM4 CTR        = Y
+SNOW5G NEA4    = Y
+AES NEA5       = Y
+ZUC-256 NEA6   = Y
 
 ;
 ; Supported authentication algorithms of the 'aesni_mb' crypto driver.
@@ -69,6 +72,9 @@ SNOW3G UIA2  = Y
 KASUMI F9    = Y
 SM3          = Y
 SM3 HMAC     = Y
+SNOW5G NIA4     = Y
+AES NIA5        = Y
+ZUC-256 NIA6    = Y
 
 ;
 ; Supported AEAD algorithms of the 'aesni_mb' crypto driver.
@@ -81,6 +87,9 @@ AES GCM (192)     = Y
 AES GCM (256)     = Y
 CHACHA20-POLY1305 = Y
 SM4 GCM           = Y
+SNOW5G NCA4       = Y
+AES NCA5          = Y
+ZUC-256 NCA6      = Y
 
 ;
 ; Supported Asymmetric algorithms of the 'aesni_mb' crypto driver.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index ea126aa9bb..1ee3cdfba3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -36,8 +36,13 @@ New Features
 * **Updated AESNI_MB crypto driver.**
 
   * Added support for version 3.0 of IPsec MB Library.
+  * Added support for the following wireless algorithms:
+       - NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes.
+       - NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes.
+       - NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes.
 
 .. This section should contain new features added in this release.
+
    Sample format:
 
    * **Add a title in the past tense with a full stop.**
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index e8f6e77d21..a49a82d561 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -22,6 +22,11 @@ is_aead_algo(IMB_HASH_ALG hash_alg, IMB_CIPHER_MODE cipher_mode)
 		hash_alg == IMB_AUTH_AES_CCM ||
 		cipher_mode == IMB_CIPHER_GCM ||
 		cipher_mode == IMB_CIPHER_SM4_GCM
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		|| cipher_mode == IMB_CIPHER_SNOW5G_NCA4
+		|| cipher_mode == IMB_CIPHER_AES_NCA5
+		|| cipher_mode == IMB_CIPHER_ZUC_NCA6
+#endif
 		);
 }
 
@@ -221,6 +226,36 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 		return 0;
 	}
 
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	if (xform->auth.algo == RTE_CRYPTO_AUTH_SNOW5G_NIA4) {
+		sess->template_job.hash_alg = IMB_AUTH_SNOW5G_NIA4;
+		sess->template_job.auth_tag_output_len_in_bytes =
+			sess->auth.req_digest_len;
+		memcpy(sess->auth.snow5g_auth_key, xform->auth.key.data,
+			xform->auth.key.length);
+		sess->template_job.u.NIA._key = sess->auth.snow5g_auth_key;
+		return 0;
+	} else if (xform->auth.algo == RTE_CRYPTO_AUTH_AES_NIA5) {
+		sess->template_job.hash_alg = IMB_AUTH_AES_NIA5;
+		sess->template_job.auth_tag_output_len_in_bytes =
+			sess->auth.req_digest_len;
+		IMB_AES_KEYEXP_256(mb_mgr, xform->auth.key.data,
+			sess->cipher.expanded_aes_keys.encode,
+			sess->cipher.expanded_aes_keys.decode);
+		sess->template_job.u.NIA._key =
+			(uint8_t *)sess->cipher.expanded_aes_keys.encode;
+		return 0;
+	} else if (xform->auth.algo == RTE_CRYPTO_AUTH_ZUC_NIA6) {
+		sess->template_job.hash_alg = IMB_AUTH_ZUC_NIA6;
+		sess->template_job.auth_tag_output_len_in_bytes =
+			sess->auth.req_digest_len;
+		memcpy(sess->auth.zuc_auth_key, xform->auth.key.data,
+			xform->auth.key.length);
+		sess->template_job.u.ZUC_EIA3._key = sess->auth.zuc_auth_key;
+		return 0;
+	}
+#endif
+
 	switch (xform->auth.algo) {
 	case RTE_CRYPTO_AUTH_MD5_HMAC:
 		sess->template_job.hash_alg = IMB_AUTH_MD5;
@@ -352,6 +387,9 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 	uint8_t is_snow3g = 0;
 	uint8_t is_kasumi = 0;
 	uint8_t is_sm4 = 0;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	uint8_t is_nxan = 0;
+#endif
 
 	if (xform == NULL) {
 		sess->template_job.cipher_mode = IMB_CIPHER_NULL;
@@ -434,6 +472,20 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_CNTR;
 		is_sm4 = 1;
 		break;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case RTE_CRYPTO_CIPHER_SNOW5G_NEA4:
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW5G_NEA4;
+		is_nxan = 1;
+		break;
+	case RTE_CRYPTO_CIPHER_AES_NEA5:
+		sess->template_job.cipher_mode = IMB_CIPHER_AES_NEA5;
+		is_nxan = 1;
+		break;
+	case RTE_CRYPTO_CIPHER_ZUC_NEA6:
+		sess->template_job.cipher_mode = IMB_CIPHER_ZUC_NEA6;
+		is_nxan = 1;
+		break;
+#endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported cipher mode parameter");
 		return -ENOTSUP;
@@ -578,6 +630,23 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 				sess->cipher.expanded_sm4_keys.decode);
 		sess->template_job.enc_keys = sess->cipher.expanded_sm4_keys.encode;
 		sess->template_job.dec_keys = sess->cipher.expanded_sm4_keys.decode;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	} else if (is_nxan) {
+		if (xform->cipher.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid cipher key length");
+			return -EINVAL;
+		}
+		if (xform->cipher.iv.length != 16) {
+			IPSEC_MB_LOG(ERR, "Invalid cipher IV length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		IMB_AES_KEYEXP_256(mb_mgr, xform->cipher.key.data,
+				sess->cipher.expanded_aes_keys.encode,
+				sess->cipher.expanded_aes_keys.decode);
+		sess->template_job.enc_keys = sess->cipher.expanded_aes_keys.encode;
+		sess->template_job.dec_keys = sess->cipher.expanded_aes_keys.decode;
+#endif
 	} else {
 		if (xform->cipher.key.length != 8) {
 			IPSEC_MB_LOG(ERR, "Invalid cipher key length");
@@ -731,6 +800,71 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.enc_keys = &sess->cipher.gcm_key;
 		sess->template_job.dec_keys = &sess->cipher.gcm_key;
 		break;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case RTE_CRYPTO_AEAD_SNOW5G_NCA4:
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW5G_NCA4;
+		sess->template_job.hash_alg = IMB_AUTH_SNOW5G_NCA4;
+		sess->template_job.u.GCM.aad_len_in_bytes = xform->aead.aad_length;
+		if (xform->aead.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		IMB_AES_KEYEXP_256(mb_mgr, xform->aead.key.data,
+			sess->cipher.expanded_aes_keys.encode,
+			sess->cipher.expanded_aes_keys.decode);
+		sess->template_job.enc_keys = sess->cipher.expanded_aes_keys.encode;
+		sess->template_job.dec_keys = sess->cipher.expanded_aes_keys.decode;
+		/* digest size must be between 4 and 16 */
+		if (sess->auth.req_digest_len < 4 ||
+				sess->auth.req_digest_len > 16) {
+			IPSEC_MB_LOG(ERR, "Invalid digest size");
+			return -EINVAL;
+		}
+		break;
+	case RTE_CRYPTO_AEAD_AES_NCA5:
+		sess->template_job.cipher_mode = IMB_CIPHER_AES_NCA5;
+		sess->template_job.hash_alg = IMB_AUTH_AES_NCA5;
+		sess->template_job.u.GCM.aad_len_in_bytes = xform->aead.aad_length;
+		if (xform->aead.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		IMB_AES_KEYEXP_256(mb_mgr, xform->aead.key.data,
+			sess->cipher.expanded_aes_keys.encode,
+			sess->cipher.expanded_aes_keys.decode);
+		sess->template_job.enc_keys = sess->cipher.expanded_aes_keys.encode;
+		sess->template_job.dec_keys = sess->cipher.expanded_aes_keys.decode;
+		/* digest size must be between 4 and 16 */
+		if (sess->auth.req_digest_len < 4 ||
+				sess->auth.req_digest_len > 16) {
+			IPSEC_MB_LOG(ERR, "Invalid digest size");
+			return -EINVAL;
+		}
+		break;
+	case RTE_CRYPTO_AEAD_ZUC_NCA6:
+		sess->template_job.cipher_mode = IMB_CIPHER_ZUC_NCA6;
+		sess->template_job.hash_alg = IMB_AUTH_ZUC_NCA6;
+		sess->template_job.u.NCA.aad_len_in_bytes = xform->aead.aad_length;
+		if (xform->aead.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		IMB_AES_KEYEXP_256(mb_mgr, xform->aead.key.data,
+			sess->cipher.expanded_aes_keys.encode,
+			sess->cipher.expanded_aes_keys.decode);
+		sess->template_job.enc_keys = sess->cipher.expanded_aes_keys.encode;
+		sess->template_job.dec_keys = sess->cipher.expanded_aes_keys.decode;
+		/* digest size must be between 4 and 16 */
+		if (sess->auth.req_digest_len < 4 ||
+				sess->auth.req_digest_len > 16) {
+			IPSEC_MB_LOG(ERR, "Invalid digest size");
+			return -EINVAL;
+		}
+		break;
+#endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported aead mode parameter");
 		return -ENOTSUP;
@@ -1060,7 +1194,24 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 	case IMB_AUTH_SM4_GCM:
 		job->u.GCM.aad = aad->va;
 		break;
-
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_AUTH_SNOW5G_NCA4:
+	case IMB_AUTH_AES_NCA5:
+		job->u.GCM.aad = aad->va;
+		break;
+	case IMB_AUTH_ZUC_NCA6:
+		job->u.NCA.aad = aad->va;
+		break;
+	case IMB_AUTH_SNOW5G_NIA4:
+		job->u.NIA._iv = iv->va;
+		break;
+	case IMB_AUTH_AES_NIA5:
+		job->u.NIA._iv = iv->va;
+		break;
+	case IMB_AUTH_ZUC_NIA6:
+		job->u.ZUC_EIA3._iv = iv->va;
+		break;
+#endif
 
 	default:
 		break;
@@ -1235,8 +1386,17 @@ handle_sgl_linear(IMB_JOB *job, struct rte_crypto_op *op, uint32_t dst_offset,
 	job->dst = linear_buf + dst_offset;
 	job->user_data2 = linear_buf;
 
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	if (job->hash_alg == IMB_AUTH_AES_GMAC ||
+		job->hash_alg == IMB_AUTH_SNOW5G_NCA4 ||
+		job->hash_alg == IMB_AUTH_AES_NCA5)
+		job->u.GCM.aad = linear_buf;
+	else if (job->hash_alg == IMB_AUTH_ZUC_NCA6)
+		job->u.NCA.aad = linear_buf;
+#else
 	if (job->hash_alg == IMB_AUTH_AES_GMAC)
 		job->u.GCM.aad = linear_buf;
+#endif
 
 	if (session->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY)
 		job->auth_tag_output = linear_buf + lb_offset;
@@ -1620,6 +1780,28 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 	case IMB_AUTH_SM4_GCM:
 		job->u.GCM.aad = op->sym->aead.aad.data;
 		break;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_AUTH_SNOW5G_NCA4:
+	case IMB_AUTH_AES_NCA5:
+		job->u.GCM.aad = op->sym->aead.aad.data;
+		break;
+	case IMB_AUTH_ZUC_NCA6:
+		job->u.NCA.aad = op->sym->aead.aad.data;
+		break;
+	case IMB_AUTH_SNOW5G_NIA4:
+		job->u.NIA._iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+			session->auth_iv.offset);
+		break;
+	case IMB_AUTH_AES_NIA5:
+		job->u.NIA._iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+			session->auth_iv.offset);
+		break;
+	case IMB_AUTH_ZUC_NIA6:
+		job->u.ZUC_EIA3._iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+			session->auth_iv.offset);
+		break;
+#endif
+
 	default:
 		break;
 	}
@@ -1775,6 +1957,29 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 				session->iv.offset);
 		break;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_AUTH_SNOW5G_NCA4:
+	case IMB_AUTH_AES_NCA5:
+	case IMB_AUTH_ZUC_NCA6:
+		job->hash_start_src_offset_in_bytes =
+				op->sym->aead.data.offset;
+		job->msg_len_to_hash_in_bytes =
+				op->sym->aead.data.length;
+		job->cipher_start_src_offset_in_bytes =
+			op->sym->aead.data.offset;
+		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
+		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+			session->iv.offset);
+		break;
+	case IMB_AUTH_SNOW5G_NIA4:
+	case IMB_AUTH_AES_NIA5:
+	case IMB_AUTH_ZUC_NIA6:
+		job->hash_start_src_offset_in_bytes =
+				op->sym->auth.data.offset >> 3;
+		job->msg_len_to_hash_in_bytes =
+				op->sym->auth.data.length >> 3;
+		break;
+#endif
 
 	default:
 		job->hash_start_src_offset_in_bytes = auth_start_offset(
@@ -1831,6 +2036,15 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 	case IMB_CIPHER_SM4_GCM:
 		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
 		break;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_CIPHER_SNOW5G_NCA4:
+	case IMB_CIPHER_AES_NCA5:
+	case IMB_CIPHER_ZUC_NCA6:
+		job->cipher_start_src_offset_in_bytes =
+			op->sym->aead.data.offset;
+		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
+		break;
+#endif
 	default:
 		job->cipher_start_src_offset_in_bytes =
 					op->sym->cipher.data.offset;
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 6afda45414..9390bad208 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -882,6 +882,233 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	{	/*  256-NEA4 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_SNOW5G_NEA4,
+				.block_size = 8,
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
+	{	/*  256-NEA5 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_AES_NEA5,
+				.block_size = 8,
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
+	{	/*  256-NEA6 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_ZUC_NEA6,
+				.block_size = 8,
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
+	{	/* 256-NIA4 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SNOW5G_NIA4,
+				.block_size = 8,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
+					.increment = 1
+				},
+				.iv_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				}
+			}, }
+		}, }
+	},
+	{	/* 256-NIA5 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_AES_NIA5,
+				.block_size = 8,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
+					.increment = 1
+				},
+				.iv_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				}
+			}, }
+		}, }
+	},
+	{	/* 256-NIA6 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_ZUC_NIA6,
+				.block_size = 8,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
+					.increment = 1
+				},
+				.iv_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				}
+			}, }
+		}, }
+	},
+	{	/* 256-NCA4 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
+			{.aead = {
+				.algo = RTE_CRYPTO_AEAD_SNOW5G_NCA4,
+				.block_size = 8,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
+					.increment = 1
+				},
+				.aad_size = {
+					.min = 0,
+					.max = 65535,
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
+	{	/* 256-NCA5 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
+			{.aead = {
+				.algo = RTE_CRYPTO_AEAD_AES_NCA5,
+				.block_size = 8,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
+					.increment = 1
+				},
+				.aad_size = {
+					.min = 0,
+					.max = 65535,
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
+	{	/* 256-NCA6 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
+			{.aead = {
+				.algo = RTE_CRYPTO_AEAD_ZUC_NCA6,
+				.block_size = 8,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
+					.increment = 1
+				},
+				.aad_size = {
+					.min = 0,
+					.max = 65535,
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
+#endif
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
@@ -1101,6 +1328,8 @@ struct __rte_cache_aligned aesni_mb_session {
 			/* *< Expanded XCBC authentication keys */
 			uint8_t zuc_auth_key[32];
 			/* *< ZUC authentication key */
+			uint8_t snow5g_auth_key[32];
+			/* *< SNOW5G authentication key */
 			snow3g_key_schedule_t pKeySched_snow3g_auth;
 			/* *< SNOW3G scheduled authentication key */
 			kasumi_key_sched_t pKeySched_kasumi_auth;
-- 
2.52.0

