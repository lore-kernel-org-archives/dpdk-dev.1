Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9E606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ftzF9FA8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ED3540E41;
	Tue, 10 Nov 2026 13:00:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id E8E994027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794312022; x=1825848022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s3VxHMDnbleHHd2Ff+Da3KOK0cWnXE1jnuZ93ynwdGM=;
 b=ftzF9FA8N5aKruDRd90BpqYGM7PXyw8Xj2cwY/pRNIBlXfTXEdx7tYID
 oHeupZzJNc8a1syIW52FO8FlqLU2aIGmQtulEMBYNit6CcXYFapnmPp5J
 h+xU/203jJ0DspokvdXs0ExeVjZuRGjzwKtPaOixcTEU3YuEmZ3WJnivP
 omsP6LFSjLGhedihqqootP/9+9RJswAJL95ImxjAHYGgxMOIp/cvP3PSQ
 8cBO9SN3B3DD9+5kJJZWKgji8d2zoTJ+0fhHFHN7FPZDRC3ljE/qq3i/2
 h1M/R+w6yTcBtuOOV8a1+pG+1eAgG/iZPrfwv7i7gefo/n4QOV1YsTMaC A==;
X-CSE-ConnectionGUID: uraFmFruS66IVVff/XrbxA==
X-CSE-MsgGUID: n2/vagnIRXqLvATXyufsPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2953494"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2953494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:00:20 -0800
X-CSE-ConnectionGUID: CrkcXNJ+TEOaNc/cN4BdTQ==
X-CSE-MsgGUID: x9e6dOMNSGCiUw+XVulnEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8279512"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2026 04:00:19 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v6 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Date: Tue, 10 Nov 2026 12:00:12 +0000
Message-ID: <20261110120015.2937289-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261110120015.2937289-1-radu.nicolau@intel.com>
References: <20261110120015.2937289-1-radu.nicolau@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for

NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes
NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes
NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes

IPsec MB library version 3.0 is required for the above algorithms.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Kai Ji <kai.ji@intel.com>
Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |   9 +
 doc/guides/cryptodevs/features/aesni_mb.ini |   9 +
 doc/guides/rel_notes/release_26_11.rst      |   5 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 226 +++++++++++++++++-
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 241 ++++++++++++++++++++
 5 files changed, 486 insertions(+), 4 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 519f965731..d851a0f53a 100644
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
 
@@ -71,6 +74,9 @@ Hash algorithms:
 * RTE_CRYPTO_AUTH_SHA3_512 HMAC
 * RTE_CRYPTO_AUTH_SHAKE_128
 * RTE_CRYPTO_AUTH_SHAKE_256
+* RTE_CRYPTO_AUTH_SNOW5G_NIA4
+* RTE_CRYPTO_AUTH_AES_NIA5
+* RTE_CRYPTO_AUTH_ZUC_NIA6
 
 AEAD algorithms:
 
@@ -78,6 +84,9 @@ AEAD algorithms:
 * RTE_CRYPTO_AEAD_AES_GCM
 * RTE_CRYPTO_AEAD_CHACHA20_POLY1305
 * RTE_CRYPTO_AEAD_SM4_GCM
+* RTE_CRYPTO_AEAD_SNOW5G_NCA4
+* RTE_CRYPTO_AEAD_AES_NCA5
+* RTE_CRYPTO_AEAD_ZUC_NCA6
 
 Protocol offloads:
 
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index d27b96eb2d..ad7f5048d2 100644
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
@@ -79,6 +82,9 @@ SHA3_512     = Y
 SHA3_512 HMAC = Y
 SHAKE_128    = Y
 SHAKE_256    = Y
+SNOW5G NIA4     = Y
+AES NIA5        = Y
+ZUC-256 NIA6    = Y
 
 ;
 ; Supported AEAD algorithms of the 'aesni_mb' crypto driver.
@@ -91,6 +97,9 @@ AES GCM (192)     = Y
 AES GCM (256)     = Y
 CHACHA20-POLY1305 = Y
 SM4 GCM           = Y
+SNOW5G NCA4       = Y
+AES NCA5          = Y
+ZUC-256 NCA6      = Y
 
 ;
 ; Supported Asymmetric algorithms of the 'aesni_mb' crypto driver.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 58c30ad173..d5c9c5b7f0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -27,8 +27,13 @@ New Features
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
index f8ae3cd64a..81d921be83 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -18,11 +18,16 @@ struct aesni_mb_op_buf_data {
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
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		|| cipher_mode == IMB_CIPHER_SNOW5G_NCA4
+		|| cipher_mode == IMB_CIPHER_AES_NCA5
+		|| cipher_mode == IMB_CIPHER_ZUC_NCA6
 #endif
 		);
 }
@@ -223,6 +228,36 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
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
+			sess->cipher.expanded_nia5_keys.encode,
+			sess->cipher.expanded_nia5_keys.decode);
+		sess->template_job.u.NIA._key =
+			(uint8_t *)sess->cipher.expanded_nia5_keys.encode;
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
@@ -396,6 +431,10 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	uint8_t is_sm4 = 0;
 #endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	uint8_t is_nxan = 0;
+	uint8_t is_nxan_exp_key = 0;
+#endif
 
 	if (xform == NULL) {
 		sess->template_job.cipher_mode = IMB_CIPHER_NULL;
@@ -481,6 +520,21 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
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
@@ -627,6 +681,29 @@ aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
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
+					sess->cipher.expanded_nea5_keys.encode,
+					sess->cipher.expanded_nea5_keys.decode);
+			sess->template_job.enc_keys = sess->cipher.expanded_nea5_keys.encode;
+			sess->template_job.dec_keys = sess->cipher.expanded_nea5_keys.decode;
+		} else {
+			memcpy(sess->cipher.nxa_cipher_key, xform->cipher.key.data, 32);
+			sess->template_job.enc_keys = sess->cipher.nxa_cipher_key;
+			sess->template_job.dec_keys = sess->cipher.nxa_cipher_key;
+		}
 #endif
 	} else {
 		if (xform->cipher.key.length != 8) {
@@ -782,6 +859,67 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
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
@@ -1113,6 +1251,18 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
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
@@ -1287,8 +1437,17 @@ handle_sgl_linear(IMB_JOB *job, struct rte_crypto_op *op, uint32_t dst_offset,
 	job->dst = linear_buf + dst_offset;
 	job->user_data2 = linear_buf;
 
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
 	if (job->hash_alg == IMB_AUTH_AES_GMAC)
 		job->u.GCM.aad = linear_buf;
+	else if (job->hash_alg == IMB_AUTH_SNOW5G_NCA4 ||
+			 job->hash_alg == IMB_AUTH_AES_NCA5 ||
+			 job->hash_alg == IMB_AUTH_ZUC_NCA6)
+		job->u.NCA.aad = linear_buf;
+#else
+	if (job->hash_alg == IMB_AUTH_AES_GMAC)
+		job->u.GCM.aad = linear_buf;
+#endif
 
 	if (session->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY)
 		job->auth_tag_output = linear_buf + lb_offset;
@@ -1674,6 +1833,20 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
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
@@ -1693,7 +1866,10 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 #else
 	if (cipher_mode == IMB_CIPHER_ZUC_EEA3 ||
 		cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
-		cipher_mode == IMB_CIPHER_KASUMI_UEA1)
+		cipher_mode == IMB_CIPHER_KASUMI_UEA1 ||
+		cipher_mode == IMB_CIPHER_SNOW5G_NEA4 ||
+		cipher_mode == IMB_CIPHER_AES_NEA5 ||
+		cipher_mode == IMB_CIPHER_ZUC_NEA6)
 		m_offset >>= 3;
 #endif
 
@@ -1831,6 +2007,29 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
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
@@ -1888,6 +2087,25 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
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
index 6451d91edd..f8bf630794 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -1103,6 +1103,233 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
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
@@ -1308,6 +1535,18 @@ struct __rte_cache_aligned aesni_mb_session {
 			/* *< Expanded GCM key */
 			uint8_t zuc_cipher_key[32];
 			/* *< ZUC cipher key */
+			uint8_t nxa_cipher_key[32];
+			/* *< NxA cipher key */
+			struct {
+				alignas(16) uint32_t encode[60];
+				alignas(16) uint32_t decode[60];
+			} expanded_nia5_keys;
+			/* *< expanded NIA5 keys */
+			struct {
+				alignas(16) uint32_t encode[60];
+				alignas(16) uint32_t decode[60];
+			} expanded_nea5_keys;
+			/* *< expanded NEA5 keys */
 			snow3g_key_schedule_t pKeySched_snow3g_cipher;
 			/* *< SNOW3G scheduled cipher key */
 			kasumi_key_sched_t pKeySched_kasumi_cipher;
@@ -1363,6 +1602,8 @@ struct __rte_cache_aligned aesni_mb_session {
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

