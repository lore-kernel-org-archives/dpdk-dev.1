Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650FBCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 14:22:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65ABA40612;
	Wed, 14 Oct 2026 16:22:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 137A3402EA
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791987745; x=1823523745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rjdaOnv2qkZkHlpAjIXn3Ib0BUHqwLeQ4EMZj82Zdw0=;
 b=C/cB+KutWxE0kAfZGlOg8DT9x69gsUSVobCoZaBtEMJLodkV4HbbAHku
 aCd681VueEQe6zul0Du1dYIXHKRFMBVHTjWY/ufBPEHruDOZ8Fe9tuqDq
 QHy4Kd24i8IPgAeiJxPJPdCPllQlU1pvZOxvsn55LvjzQOYpHpsNnvXhb
 jNKUYAJn3tSgdzSjIRYZ8rOG3nPjit2cmUwJBT140mo2+TuAcHgwt11fR
 Kmk/mH7MyTzI3skCo0BffC4C3h2diMxXOCLfh70VfCm45H2+aVz2qVVVk
 CqryLiP5ohpyzP5bZRRzr499+SPIfLS+FGLVose90+H5/Vl0Nnh5EUC4p w==;
X-CSE-ConnectionGUID: HOIWMsp+SlKlZBiGU7Plag==
X-CSE-MsgGUID: oZMsVGqSSiqsynZKUj8SjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="766330"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="766330"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:22:24 -0700
X-CSE-ConnectionGUID: EpIJ54hjS2K/EEyUTv5W6g==
X-CSE-MsgGUID: Irqpmx+oQq2IqPSjx6x3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1403577"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa001.jf.intel.com with ESMTP; 14 Oct 2026 07:22:22 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v4 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Date: Wed, 14 Oct 2026 14:21:35 +0000
Message-ID: <20261014142217.2117229-3-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261014142217.2117229-1-radu.nicolau@intel.com>
References: <20261014142217.2117229-1-radu.nicolau@intel.com>
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
Acked-by: Kai Ji <kai.ji@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |   9 +
 doc/guides/cryptodevs/features/aesni_mb.ini |   9 +
 doc/guides/rel_notes/release_26_11.rst      |   5 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 223 +++++++++++++++++-
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 236 ++++++++++++++++++++
 5 files changed, 479 insertions(+), 3 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 5af130364b..b1facf65ab 100644
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
index b2e1422f12..ac3c643f87 100644
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
index a2f7f9abf8..dc07d96aad 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -18,11 +18,18 @@ struct aesni_mb_op_buf_data {
 static inline int
 is_aead_algo(IMB_HASH_ALG hash_alg, IMB_CIPHER_MODE cipher_mode)
 {
-	return (hash_alg == IMB_AUTH_CHACHA20_POLY1305 ||
-		hash_alg == IMB_AUTH_AES_CCM ||
-		cipher_mode == IMB_CIPHER_GCM
+	return (hash_alg == IMB_AUTH_CHACHA20_POLY1305
+		|| hash_alg == IMB_AUTH_AES_CCM
+		|| cipher_mode == IMB_CIPHER_GCM
 #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 		|| cipher_mode == IMB_CIPHER_SM4_GCM
+		|| cipher_mode == IMB_CIPHER_GCM
+		|| cipher_mode == IMB_CIPHER_SM4_GCM
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		|| cipher_mode == IMB_CIPHER_SNOW5G_NCA4
+		|| cipher_mode == IMB_CIPHER_AES_NCA5
+		|| cipher_mode == IMB_CIPHER_ZUC_NCA6
 #endif
 		);
 }
@@ -223,6 +230,36 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
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
+			sess->cipher.expanded_nxa5_keys.encode,
+			sess->cipher.expanded_nxa5_keys.decode);
+		sess->template_job.u.NIA._key =
+			(uint8_t *)sess->cipher.expanded_nxa5_keys.encode;
+		return 0;
+	} else if (xform->auth.algo == RTE_CRYPTO_AUTH_ZUC_NIA6) {
+		sess->template_job.hash_alg = IMB_AUTH_ZUC_NIA6;
+		sess->template_job.auth_tag_output_len_in_bytes =
+			sess->auth.req_digest_len;
+		memcpy(sess->auth.zuc_auth_key, xform->auth.key.data,
+			xform->auth.key.length);
+		sess->template_job.u.NIA._key = sess->auth.zuc_auth_key;
+		return 0;
+	}
+#endif
+
 	switch (xform->auth.algo) {
 	case RTE_CRYPTO_AUTH_MD5_HMAC:
 		sess->template_job.hash_alg = IMB_AUTH_MD5;
@@ -358,6 +395,10 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	uint8_t is_sm4 = 0;
 #endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	uint8_t is_nxan = 0;
+	uint8_t is_nxan_exp_key = 0;
+#endif
 
 	if (xform == NULL) {
 		sess->template_job.cipher_mode = IMB_CIPHER_NULL;
@@ -443,6 +484,21 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_CNTR;
 		is_sm4 = 1;
 		break;
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case RTE_CRYPTO_CIPHER_SNOW5G_NEA4:
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW5G_NEA4;
+		is_nxan = 1;
+		break;
+	case RTE_CRYPTO_CIPHER_AES_NEA5:
+		sess->template_job.cipher_mode = IMB_CIPHER_AES_NEA5;
+		is_nxan = 1;
+		is_nxan_exp_key = 1;
+		break;
+	case RTE_CRYPTO_CIPHER_ZUC_NEA6:
+		sess->template_job.cipher_mode = IMB_CIPHER_ZUC_NEA6;
+		is_nxan = 1;
+		break;
 #endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported cipher mode parameter");
@@ -589,6 +645,29 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 				sess->cipher.expanded_sm4_keys.decode);
 		sess->template_job.enc_keys = sess->cipher.expanded_sm4_keys.encode;
 		sess->template_job.dec_keys = sess->cipher.expanded_sm4_keys.decode;
+#endif
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
+		if (is_nxan_exp_key) {
+			IMB_AES_KEYEXP_256(mb_mgr, xform->cipher.key.data,
+					sess->cipher.expanded_nxa5_keys.encode,
+					sess->cipher.expanded_nxa5_keys.decode);
+			sess->template_job.enc_keys = sess->cipher.expanded_nxa5_keys.encode;
+			sess->template_job.dec_keys = sess->cipher.expanded_nxa5_keys.decode;
+		} else {
+			memcpy(sess->cipher.nxa_cipher_key, xform->cipher.key.data, 32);
+			sess->template_job.enc_keys = sess->cipher.nxa_cipher_key;
+			sess->template_job.dec_keys = sess->cipher.nxa_cipher_key;
+		}
 #endif
 	} else {
 		if (xform->cipher.key.length != 8) {
@@ -744,6 +823,67 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.enc_keys = &sess->cipher.gcm_key;
 		sess->template_job.dec_keys = &sess->cipher.gcm_key;
 		break;
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case RTE_CRYPTO_AEAD_SNOW5G_NCA4:
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW5G_NCA4;
+		sess->template_job.hash_alg = IMB_AUTH_SNOW5G_NCA4;
+		sess->template_job.u.NCA.aad_len_in_bytes = xform->aead.aad_length;
+		if (xform->aead.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		memcpy(sess->cipher.nxa_cipher_key, xform->aead.key.data, 32);
+		sess->template_job.enc_keys = sess->cipher.nxa_cipher_key;
+		sess->template_job.dec_keys = sess->cipher.nxa_cipher_key;
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
+	case RTE_CRYPTO_AEAD_ZUC_NCA6:
+		sess->template_job.cipher_mode = IMB_CIPHER_ZUC_NCA6;
+		sess->template_job.hash_alg = IMB_AUTH_ZUC_NCA6;
+		sess->template_job.u.NCA.aad_len_in_bytes = xform->aead.aad_length;
+		if (xform->aead.key.length != 32) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 32;
+		memcpy(sess->cipher.nxa_cipher_key, xform->aead.key.data, 32);
+		sess->template_job.enc_keys = sess->cipher.nxa_cipher_key;
+		sess->template_job.dec_keys = sess->cipher.nxa_cipher_key;
+		/* digest size must be between 4 and 16 */
+		if (sess->auth.req_digest_len < 4 ||
+				sess->auth.req_digest_len > 16) {
+			IPSEC_MB_LOG(ERR, "Invalid digest size");
+			return -EINVAL;
+		}
+		break;
 #endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported aead mode parameter");
@@ -1075,6 +1215,18 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 		job->u.GCM.aad = aad->va;
 		break;
 #endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_AUTH_SNOW5G_NCA4:
+	case IMB_AUTH_AES_NCA5:
+	case IMB_AUTH_ZUC_NCA6:
+		job->u.NCA.aad = aad->va;
+		break;
+	case IMB_AUTH_SNOW5G_NIA4:
+	case IMB_AUTH_AES_NIA5:
+	case IMB_AUTH_ZUC_NIA6:
+		job->u.NIA._iv = iv->va;
+		break;
+#endif
 
 	default:
 		break;
@@ -1249,8 +1401,17 @@ handle_sgl_linear(IMB_JOB *job, struct rte_crypto_op *op, uint32_t dst_offset,
 	job->dst = linear_buf + dst_offset;
 	job->user_data2 = linear_buf;
 
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	if (job->hash_alg == IMB_AUTH_AES_GMAC)
+		job->u.GCM.aad = linear_buf;
+	else if (job->hash_alg == IMB_AUTH_SNOW5G_NCA4 ||
+			 job->hash_alg == IMB_AUTH_AES_NCA5 ||
+			 job->hash_alg == IMB_AUTH_ZUC_NCA6)
+		job->u.NCA.aad = linear_buf;
+#else
 	if (job->hash_alg == IMB_AUTH_AES_GMAC)
 		job->u.GCM.aad = linear_buf;
+#endif
 
 	if (session->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY)
 		job->auth_tag_output = linear_buf + lb_offset;
@@ -1636,6 +1797,20 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->u.GCM.aad = op->sym->aead.aad.data;
 		break;
 #endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_AUTH_SNOW5G_NCA4:
+	case IMB_AUTH_AES_NCA5:
+	case IMB_AUTH_ZUC_NCA6:
+		job->u.NCA.aad = op->sym->aead.aad.data;
+		break;
+	case IMB_AUTH_SNOW5G_NIA4:
+	case IMB_AUTH_AES_NIA5:
+	case IMB_AUTH_ZUC_NIA6:
+		job->u.NIA._iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+			session->auth_iv.offset);
+		break;
+#endif
+
 	default:
 		break;
 	}
@@ -1793,6 +1968,29 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 				session->iv.offset);
 		break;
 #endif
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
@@ -1850,6 +2048,25 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 	case IMB_CIPHER_SM4_GCM:
 		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
 		break;
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case IMB_CIPHER_SNOW5G_NEA4:
+	case IMB_CIPHER_AES_NEA5:
+	case IMB_CIPHER_ZUC_NEA6:
+		job->cipher_start_src_offset_in_bytes =
+					op->sym->cipher.data.offset >> 3;
+		job->msg_len_to_cipher_in_bytes =
+					op->sym->cipher.data.length >> 3;
+		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+			session->iv.offset);
+		break;
+	case IMB_CIPHER_SNOW5G_NCA4:
+	case IMB_CIPHER_AES_NCA5:
+	case IMB_CIPHER_ZUC_NCA6:
+		job->cipher_start_src_offset_in_bytes =
+			op->sym->aead.data.offset;
+		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
+		break;
 #endif
 	default:
 		job->cipher_start_src_offset_in_bytes =
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 9eee5bbdeb..61538ca8dd 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -891,6 +891,233 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+#endif
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
 #endif
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
@@ -1058,6 +1285,13 @@ struct __rte_cache_aligned aesni_mb_session {
 			/* *< Expanded GCM key */
 			uint8_t zuc_cipher_key[32];
 			/* *< ZUC cipher key */
+			uint8_t nxa_cipher_key[32];
+			/* *< NxA cipher key */
+			struct {
+				alignas(16) uint32_t encode[60];
+				alignas(16) uint32_t decode[60];
+			} expanded_nxa5_keys;
+			/* *< expanded NxA5 keys */
 			snow3g_key_schedule_t pKeySched_snow3g_cipher;
 			/* *< SNOW3G scheduled cipher key */
 			kasumi_key_sched_t pKeySched_kasumi_cipher;
@@ -1113,6 +1347,8 @@ struct __rte_cache_aligned aesni_mb_session {
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

