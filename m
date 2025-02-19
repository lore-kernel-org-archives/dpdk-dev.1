Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD7C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 11:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E3C40E12;
	Wed, 19 Feb 2025 12:50:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0B7BE40DDC
 for <dev@dpdk.org>; Wed, 19 Feb 2025 12:50:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739965814; x=1771501814;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YVl+p30+2NjFHV4sjYWar2Oj97H4unuwvJ3IDlsRA7c=;
 b=ippKCOnu41wW7Q8dVke8SOMdwORT9mes33YFI2wUkBFxKH8c2C7iXjBb
 Ky1hdDVvjaan/W/bC5SE5QfnEQAKQXVA5e1LK2ToI4eilwv97d1/tdBB6
 JKIS3mGFrcrDua7BfKRaIqMi3ztfI83jo3if/fQuJDtHgqAjb4ZDs+TSP
 7V84aoKYlkg01FEJJDumA1EXnMclR/10e548vUN+ykCALRVdf7FvhGBHY
 yxNHem7vts9PwadhQdvP3eQpcX6ucXHgUTo4ZfYCuYkYyYeYwIdWOXGAO
 5fohkPQcXlNdUgWGcPI/VBcV6BIlD+oGBXZUVie8zhrw+8cnz+2lociSm Q==;
X-CSE-ConnectionGUID: SPZ2QmfhRBypbUHqk8PYNA==
X-CSE-MsgGUID: nFOG2ZShTYiRDOU3cFSRmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40412088"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40412088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 03:50:13 -0800
X-CSE-ConnectionGUID: AIHuIgxCQH6HHJrP5a31MQ==
X-CSE-MsgGUID: 50gSVlrdRqiJu/OudU0ulw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114556883"
Received: from unknown (HELO silpixa00400886.ir.intel.com) ([10.243.22.139])
 by orviesa010.jf.intel.com with ESMTP; 19 Feb 2025 03:50:12 -0800
From: Brian Dooley <brian.dooley@intel.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Brian Dooley <brian.dooley@intel.com>
Subject: [PATCH v4 1/3] crypto/ipsec_mb: add SM4 GCM support
Date: Wed, 19 Feb 2025 11:49:59 +0000
Message-Id: <20250219115001.1047145-1-brian.dooley@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213125850.2714328-1-brian.dooley@intel.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
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

This patch introduces SM4 GCM algorithm support to the AESNI_MB PMD.
SM4 GCM is available in the v2.0 release of Intel IPsec MB.

Signed-off-by: Brian Dooley <brian.dooley@intel.com>
---
v2:
	Added aad to cpu job params
	Added ipsec mb version checks
v3:
	Fix naming for patchwork
v4:
	Remove cryptodev changes to separate patch
---
 doc/guides/cryptodevs/aesni_mb.rst          |  1 +
 doc/guides/cryptodevs/features/aesni_mb.ini |  1 +
 doc/guides/rel_notes/release_25_03.rst      |  4 ++
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 54 ++++++++++++++++++++-
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 30 ++++++++++++
 5 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 16d82147b2..8d7e221e79 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -67,6 +67,7 @@ AEAD algorithms:
 * RTE_CRYPTO_AEAD_AES_CCM
 * RTE_CRYPTO_AEAD_AES_GCM
 * RTE_CRYPTO_AEAD_CHACHA20_POLY1305
+* RTE_CRYPTO_AEAD_SM4_GCM
 
 Protocol offloads:
 
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index ebe00d075d..c648be62fb 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -80,6 +80,7 @@ AES GCM (128)     = Y
 AES GCM (192)     = Y
 AES GCM (256)     = Y
 CHACHA20-POLY1305 = Y
+SM4 GCM           = Y
 ;
 ; Supported Asymmetric algorithms of the 'aesni_mb' crypto driver.
 ;
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 145b018058..3f8c61e8d5 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -133,6 +133,10 @@ New Features
 
   See the :doc:`../compressdevs/zsda` guide for more details on the new driver.
 
+* **Updated IPsec_MB crypto driver.**
+
+   * Added support for the SM4 GCM algorithm.
+
 
 Removed Items
 -------------
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 05dc1a039f..8b54e4a602 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -20,7 +20,11 @@ is_aead_algo(IMB_HASH_ALG hash_alg, IMB_CIPHER_MODE cipher_mode)
 {
 	return (hash_alg == IMB_AUTH_CHACHA20_POLY1305 ||
 		hash_alg == IMB_AUTH_AES_CCM ||
-		cipher_mode == IMB_CIPHER_GCM);
+		cipher_mode == IMB_CIPHER_GCM
+#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+		|| cipher_mode == IMB_CIPHER_SM4_GCM
+#endif
+		);
 }
 
 /** Set session authentication parameters */
@@ -602,7 +606,7 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 }
 
 static int
-aesni_mb_set_session_aead_parameters(const IMB_MGR *mb_mgr,
+aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 		struct aesni_mb_session *sess,
 		const struct rte_crypto_sym_xform *xform)
 {
@@ -720,6 +724,22 @@ aesni_mb_set_session_aead_parameters(const IMB_MGR *mb_mgr,
 			return -EINVAL;
 		}
 		break;
+#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+		case RTE_CRYPTO_AEAD_SM4_GCM:
+		sess->template_job.cipher_mode = IMB_CIPHER_SM4_GCM;
+		sess->template_job.hash_alg = IMB_AUTH_SM4_GCM;
+		sess->template_job.u.GCM.aad_len_in_bytes = xform->aead.aad_length;
+
+		if (xform->aead.key.length != 16) {
+			IPSEC_MB_LOG(ERR, "Invalid key length");
+			return -EINVAL;
+		}
+		sess->template_job.key_len_in_bytes = 16;
+		imb_sm4_gcm_pre(mb_mgr, xform->aead.key.data, &sess->cipher.gcm_key);
+		sess->template_job.enc_keys = &sess->cipher.gcm_key;
+		sess->template_job.dec_keys = &sess->cipher.gcm_key;
+		break;
+#endif
 	default:
 		IPSEC_MB_LOG(ERR, "Unsupported aead mode parameter");
 		return -ENOTSUP;
@@ -1037,6 +1057,13 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 	case IMB_AUTH_CHACHA20_POLY1305:
 		job->u.CHACHA20_POLY1305.aad = aad->va;
 		break;
+
+#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+	case IMB_AUTH_SM4_GCM:
+		job->u.GCM.aad = aad->va;
+		break;
+#endif
+
 	default:
 		job->u.HMAC._hashed_auth_key_xor_ipad =
 				session->auth.pads.inner;
@@ -1559,6 +1586,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 			imb_set_session(mb_mgr, job);
 		}
 		break;
+#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+	case IMB_AUTH_SM4_GCM:
+		job->u.GCM.aad = op->sym->aead.aad.data;
+		break;
+#endif
 	default:
 		break;
 	}
@@ -1687,6 +1719,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 			session->iv.offset);
 		break;
+#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+	case IMB_AUTH_SM4_GCM:
+		job->hash_start_src_offset_in_bytes = 0;
+		/*
+		 * Adding offset here as there is a bug in the ipsec mb library
+		 */
+		job->src += op->sym->aead.data.offset;
+		job->msg_len_to_hash_in_bytes =
+					op->sym->aead.data.length;
+		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
+				session->iv.offset);
+		break;
+#endif
 
 	default:
 		job->hash_start_src_offset_in_bytes = auth_start_offset(op,
@@ -1732,6 +1777,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->msg_len_to_cipher_in_bytes = 0;
 		job->cipher_start_src_offset_in_bytes = 0;
 		break;
+#if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
+	case IMB_CIPHER_SM4_GCM:
+		job->msg_len_to_cipher_in_bytes = op->sym->aead.data.length;
+		break;
+#endif
 	default:
 		job->cipher_start_src_offset_in_bytes =
 					op->sym->cipher.data.offset;
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 468a1f35eb..bdb9ad815b 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -826,6 +826,36 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* SM4 GCM */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
+			{.aead = {
+				.algo = RTE_CRYPTO_AEAD_SM4_GCM,
+				.block_size = 16,
+				.key_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0,
+				},
+				.digest_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0,
+				},
+				.aad_size = {
+					.min = 0,
+					.max = 65535,
+					.increment = 1,
+				},
+				.iv_size = {
+					.min = 12,
+					.max = 12,
+					.increment = 0,
+				}
+			}, }
+		}, }
+	},
 #endif
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
-- 
2.25.1

