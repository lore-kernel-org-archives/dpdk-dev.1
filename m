Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13323C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 067A540288;
	Tue, 11 Aug 2026 13:27:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6E3AE4027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786447618; x=1817983618;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wPvzMiNQ6PIdKEuUMN1FiMegjw/wPZHOApi9UlJxo/g=;
 b=dssmq8RqwxiN1hla/HLeLmtscw9RoefB7M03Z7+swfCAt+c6YWB5DGKK
 0IUuuWT25Gyrmyj0vqTpySK8YfHEm3ZvAEwFx6VHjdUgXOvQFhYQMD6FG
 Jmk0aShyETn1Wj0fkYBpF5E25U4ML3w+6HGRxmaAWdYEjQdSmnfs5ZFgp
 r8cuU+c1ZXYfjZUS768HZ+V8S7u3hHvRNgm3F9Yg9BUAQJ8sODWMlDBEh
 sxse5lreZ+Mg7JgwNV9N1Wk3PTUidLrJmFJqP2c0zwZSB/ZHLJ8isH5ct
 D+f/506t/4q1+SCDPi7SLOP1pdw/YNx9OxqBOti7PvIQG18MHde6hZYtx Q==;
X-CSE-ConnectionGUID: KVuuGJrsQpewGH8Pz7iubg==
X-CSE-MsgGUID: NatG6jmYS964DDAw2CAiIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89502169"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="89502169"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 04:26:56 -0700
X-CSE-ConnectionGUID: tAHWmBhYR2urzd7kHbJbvg==
X-CSE-MsgGUID: Qr/bVWy1R8ishbPTQmMr8A==
X-ExtLoop1: 1
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa003.fm.intel.com with ESMTP; 11 Aug 2026 04:26:54 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH] crypto/ipsec_mb: require minimum version 2.0 for IPsec MB
Date: Tue, 11 Aug 2026 11:26:35 +0000
Message-ID: <20260811112636.4106950-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

Increase the minimum required IPsec MB library version to 2.0
As a consequence, clean up the aesni_mb PMD code.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/aesni_gcm.rst         |  7 +++---
 doc/guides/cryptodevs/aesni_mb.rst          |  7 +++---
 doc/guides/cryptodevs/qat.rst               |  2 +-
 doc/guides/cryptodevs/snow3g.rst            |  3 ++-
 doc/guides/cryptodevs/zuc.rst               |  3 ++-
 doc/guides/rel_notes/release_26_11.rst      |  4 +++
 drivers/common/qat/meson.build              |  4 +--
 drivers/crypto/ipsec_mb/meson.build         |  2 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 28 +++------------------
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h |  8 ------
 10 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index 4683e9dd86..aefc1cedcb 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -40,8 +40,8 @@ Installation
 To build DPDK with the AESNI_GCM_PMD the user is required to download the multi-buffer
 library from `here <https://github.com/01org/intel-ipsec-mb>`_
 and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded in `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
+The latest version of the library supported by this PMD is v2.0, which
+can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v2.0.zip>`_.
 
 For Arm system, ARM64 port of the multi-buffer library can be downloaded from
 https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/.
@@ -77,7 +77,8 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.11 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4+
+   24.11 - 26.07  Multi-buffer library 1.4  - 2.0
+   26.11+         Multi-buffer library 2.0+
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index ab7a6138a8..add3c03b74 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -96,8 +96,8 @@ Installation
 To build DPDK with the AESNI_MB_PMD the user is required to download the multi-buffer
 library from `here <https://github.com/01org/intel-ipsec-mb>`_
 and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
+The latest version of the library supported by this PMD is v2.0, which
+can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v2.0.zip>`_.
 
 For Arm system, ARM64 port of the multi-buffer library can be downloaded from
 https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/.
@@ -132,7 +132,8 @@ and the Multi-Buffer library version supported by them:
    ==============  ============================
    20.11 - 21.08   0.53 - 1.3
    21.11 - 24.07   1.0  - 1.5
-   24.11+          1.4+
+   24.11 - 26.07   1.4  - 2.0
+   26.11+          2.0+
    ==============  ============================
 
 Initialization
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 6c96c5f88d..1738152435 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -360,7 +360,7 @@ that were previously used for HMAC precomputes.
 
 **On x86 platforms:**
 
-* Intel IPsec MB library (v1.4.0+) is required for HMAC precomputes.
+* Intel IPsec MB library (v2.0+) is required for HMAC precomputes.
 * OpenSSL (3.0+) is optional for DOCSIS BPI cipher fallback.
 
 **On ARM platforms:**
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index e1db5d39ad..e3a47263e1 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -82,7 +82,8 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.02 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4+
+   24.11 - 26.07  Multi-buffer library 1.4  - 2.0
+   26.11+         Multi-buffer library 2.0+
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 91b7267362..22b70bc750 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -81,7 +81,8 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.02 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4+
+   24.11 - 26.07  Multi-buffer library 1.4  - 2.0
+   26.11+         Multi-buffer library 2.0+
    =============  ================================
 
 Initialization
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..7fc97ca4c9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -59,6 +59,10 @@ New Features
 Removed Items
 -------------
 
+* **Updated AESNI_MB crypto driver.**
+
+  * Remove support for versions older than 2.0 of IPsec MB Library.
+
 .. This section should contain removed items in this release. Sample format:
 
    * Add a short 1-2 sentence description of the removed item
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index b946354a42..17526d3940 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -38,7 +38,7 @@ endif
 
 # IPsec MB is REQUIRED for HMAC precomputes (no OpenSSL 3.0 alternative)
 # OpenSSL is OPTIONAL for DOCSIS BPI cipher fallback
-IMB_required_ver = '1.4.0'
+IMB_required_ver = '2.0.0'
 
 # Only check IPsec MB if qat_crypto wasn't already disabled
 if qat_crypto
@@ -47,8 +47,6 @@ if qat_crypto
     else
         IMB_header = '#include<intel-ipsec-mb.h>'
     endif
-
-    # Check for IPsec MB library (required)
     libipsecmb = cc.find_library('IPSec_MB', required: false)
     if libipsecmb.found() and cc.links(
             'int main(void) {return 0;}', dependencies: libipsecmb)
diff --git a/drivers/crypto/ipsec_mb/meson.build b/drivers/crypto/ipsec_mb/meson.build
index eb2085725b..41362c2f4f 100644
--- a/drivers/crypto/ipsec_mb/meson.build
+++ b/drivers/crypto/ipsec_mb/meson.build
@@ -9,7 +9,7 @@ endif
 
 cflags += no_wvla_cflag
 
-IMB_required_ver = '1.4.0'
+IMB_required_ver = '2.0.0'
 IMB_header = '#include<intel-ipsec-mb.h>'
 if arch_subdir == 'arm'
     IMB_header = '#include<ipsec-mb.h>'
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 4c5b6e70b5..02bacd020b 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -20,10 +20,8 @@ is_aead_algo(IMB_HASH_ALG hash_alg, IMB_CIPHER_MODE cipher_mode)
 {
 	return (hash_alg == IMB_AUTH_CHACHA20_POLY1305 ||
 		hash_alg == IMB_AUTH_AES_CCM ||
-		cipher_mode == IMB_CIPHER_GCM
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
-		|| cipher_mode == IMB_CIPHER_SM4_GCM
-#endif
+		cipher_mode == IMB_CIPHER_GCM ||
+		cipher_mode == IMB_CIPHER_SM4_GCM
 		);
 }
 
@@ -295,14 +293,12 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.hash_alg = IMB_AUTH_SHA_512;
 		auth_precompute = 0;
 		break;
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	case RTE_CRYPTO_AUTH_SM3:
 		sess->template_job.hash_alg = IMB_AUTH_SM3;
 		break;
 	case RTE_CRYPTO_AUTH_SM3_HMAC:
 		sess->template_job.hash_alg = IMB_AUTH_HMAC_SM3;
 		break;
-#endif
 	default:
 		IPSEC_MB_LOG(ERR,
 			"Unsupported authentication algorithm selection");
@@ -353,9 +349,7 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 	uint8_t is_zuc = 0;
 	uint8_t is_snow3g = 0;
 	uint8_t is_kasumi = 0;
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	uint8_t is_sm4 = 0;
-#endif
 
 	if (xform == NULL) {
 		sess->template_job.cipher_mode = IMB_CIPHER_NULL;
@@ -426,7 +420,6 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 		sess->iv.offset = xform->cipher.iv.offset;
 		sess->template_job.iv_len_in_bytes = xform->cipher.iv.length;
 		return 0;
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	case RTE_CRYPTO_CIPHER_SM4_CBC:
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_CBC;
 		is_sm4 = 1;
@@ -435,13 +428,10 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_ECB;
 		is_sm4 = 1;
 		break;
-#endif
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case RTE_CRYPTO_CIPHER_SM4_CTR:
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_CNTR;
 		is_sm4 = 1;
 		break;
-#endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported cipher mode parameter");
 		return -ENOTSUP;
@@ -576,7 +566,6 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 					&sess->cipher.pKeySched_kasumi_cipher);
 		sess->template_job.enc_keys = &sess->cipher.pKeySched_kasumi_cipher;
 		sess->template_job.dec_keys = &sess->cipher.pKeySched_kasumi_cipher;
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	} else if (is_sm4) {
 		sess->template_job.key_len_in_bytes = IMB_KEY_128_BYTES;
 		IMB_SM4_KEYEXP(mb_mgr, xform->cipher.key.data,
@@ -584,7 +573,6 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 				sess->cipher.expanded_sm4_keys.decode);
 		sess->template_job.enc_keys = sess->cipher.expanded_sm4_keys.encode;
 		sess->template_job.dec_keys = sess->cipher.expanded_sm4_keys.decode;
-#endif
 	} else {
 		if (xform->cipher.key.length != 8) {
 			IPSEC_MB_LOG(ERR, "Invalid cipher key length");
@@ -724,7 +712,6 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 			return -EINVAL;
 		}
 		break;
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case RTE_CRYPTO_AEAD_SM4_GCM:
 		sess->template_job.cipher_mode = IMB_CIPHER_SM4_GCM;
 		sess->template_job.hash_alg = IMB_AUTH_SM4_GCM;
@@ -739,7 +726,6 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.enc_keys = &sess->cipher.gcm_key;
 		sess->template_job.dec_keys = &sess->cipher.gcm_key;
 		break;
-#endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported aead mode parameter");
 		return -ENOTSUP;
@@ -1065,11 +1051,11 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 		job->u.CHACHA20_POLY1305.aad = aad->va;
 		break;
 
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+
 	case IMB_AUTH_SM4_GCM:
 		job->u.GCM.aad = aad->va;
 		break;
-#endif
+
 
 	default:
 		break;
@@ -1618,11 +1604,9 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 			imb_set_session(mb_mgr, job);
 		}
 		break;
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_AUTH_SM4_GCM:
 		job->u.GCM.aad = op->sym->aead.aad.data;
 		break;
-#endif
 	default:
 		break;
 	}
@@ -1753,7 +1737,6 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 			session->iv.offset);
 		break;
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_AUTH_SM4_GCM:
 		job->hash_start_src_offset_in_bytes = 0;
 		/*
@@ -1766,7 +1749,6 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 				session->iv.offset);
 		break;
-#endif
 
 	default:
 		job->hash_start_src_offset_in_bytes = auth_start_offset(
@@ -1813,11 +1795,9 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->msg_len_to_cipher_in_bytes = 0;
 		job->cipher_start_src_offset_in_bytes = 0;
 		break;
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	case IMB_CIPHER_SM4_GCM:
 		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
 		break;
-#endif
 	default:
 		job->cipher_start_src_offset_in_bytes =
 					op->sym->cipher.data.offset;
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 6dc90a9849..ad38a1e28a 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -725,7 +725,6 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 	{	/* SM3 */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
@@ -804,8 +803,6 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
-#endif
-#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
 	{	/* SM4 CTR */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
@@ -856,7 +853,6 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
-#endif
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
@@ -964,10 +960,8 @@ static const unsigned int auth_digest_byte_lengths[] = {
 		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 4,
 		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 4,
 		[IMB_AUTH_KASUMI_UIA1]		= 4,
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 		[IMB_AUTH_SM3]			= 32,
 		[IMB_AUTH_HMAC_SM3]		= 32,
-#endif
 	/**< Vector mode dependent pointer table of the multi-buffer APIs */
 
 };
@@ -1029,7 +1023,6 @@ struct __rte_cache_aligned aesni_mb_session {
 			/* *< SNOW3G scheduled cipher key */
 			kasumi_key_sched_t pKeySched_kasumi_cipher;
 			/* *< KASUMI scheduled cipher key */
-#if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 			struct {
 				alignas(16) uint32_t encode[IMB_SM4_KEY_SCHEDULE_ROUNDS];
 				/* *< encode key */
@@ -1039,7 +1032,6 @@ struct __rte_cache_aligned aesni_mb_session {
 			/* *< Expanded SM4 keys - Original 128 bit key is
 			 * expanded into 32 round keys, each 32 bits.
 			 */
-#endif
 		};
 	} cipher;
 
-- 
2.52.0

