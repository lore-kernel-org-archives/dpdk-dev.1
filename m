Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233E3CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D164406BC;
	Thu, 15 Oct 2026 16:14:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id AEDAD40A80
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792073676; x=1823609676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F30BiiTp8PZjvws6Cd2/4XEJ3WjKGz3XCXJhnUHoE4E=;
 b=V44c3c4WYWHJ0OxZRFwzLUgeXeyu0FRKfeThH/3wX+l5BBAyPwImX5I/
 XBQCj0Tudl+rRCTaEDvFLLq2oXqWBdm7nYNEt20UPNZxDVl1zHLXP9qKo
 fhAJ4MsZldlwDMLaFexej9WUU0npg3BebcT2NJoEK2IJmkmIrFafMMBCI
 FXagbA708mbr5Hfz/XdQ8g44qnu0ZX3zKBhYJ1+9LxQU/SUzSK2RCrbl6
 dgnVqADvgzdD+VbP6jAQ4fdQM7aIPNGBguflYcHlN+YZpTL5LTkee1aml
 Rj4HMvB4zUch/uSrsffPgsLZ4C9N1RDIiEP0N4fUzQs5tOSASKS8TMK/R g==;
X-CSE-ConnectionGUID: 7UMh3JVuTcu/HQ+Awheh7A==
X-CSE-MsgGUID: 96TN01LxQW+BqwvdtSdbBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="716753"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="716753"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:14:36 -0700
X-CSE-ConnectionGUID: gplnaQgVTFWR0LyxJrm4Gg==
X-CSE-MsgGUID: GGyPdG8uQR+yE7ZBs4wiKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2060558"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 07:14:34 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: marcel.d.cornu@intel.com, Radu Nicolau <radu.nicolau@intel.com>,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v5 3/4] crypto/ipsec_mb: add support for ML-KEM and ML-DSA
Date: Thu, 15 Oct 2026 14:13:57 +0000
Message-ID: <20261015141426.2275568-4-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015141426.2275568-1-radu.nicolau@intel.com>
References: <20261015141426.2275568-1-radu.nicolau@intel.com>
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

Enable basic support for asymmetric crypto operations.
Add support for ML-KEM and ML-DSA algorithms.

IPsecMB release 3.0 and newer required.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Kai Ji <kai.ji@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |   6 +
 doc/guides/cryptodevs/features/aesni_mb.ini |   3 +
 doc/guides/rel_notes/release_26_11.rst      |   3 +
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c      |  49 +++
 drivers/crypto/ipsec_mb/ipsec_mb_private.h  |  20 ++
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      | 372 +++++++++++++++++++-
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h |  86 ++++-
 7 files changed, 523 insertions(+), 16 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index b1facf65ab..6f95927a63 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -78,6 +78,12 @@ AEAD algorithms:
 * RTE_CRYPTO_AEAD_AES_NCA5
 * RTE_CRYPTO_AEAD_ZUC_NCA6
 
+PQC Asymmetric Crypto algorithms
+
+* RTE_CRYPTO_ASYM_XFORM_ML_KEM
+* RTE_CRYPTO_ASYM_XFORM_ML_DSA
+
+
 Protocol offloads:
 
 * RTE_SECURITY_PROTOCOL_DOCSIS
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index b357a5f1bf..6ecc25ef9e 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -21,6 +21,7 @@ CPU crypto             = Y
 Symmetric sessionless  = Y
 Non-Byte aligned data  = N
 Digest encrypted       = Y
+Asymmetric crypto      = Y
 
 ;
 ; Supported crypto algorithms of the 'aesni_mb' crypto driver.
@@ -95,6 +96,8 @@ ZUC-256 NCA6      = Y
 ; Supported Asymmetric algorithms of the 'aesni_mb' crypto driver.
 ;
 [Asymmetric]
+ML-KEM = Y
+ML-DSA = Y
 
 ;
 ; Supported Operating systems of the 'aesni_mb' crypto driver.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9155f1daf2..4c74a15900 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -31,6 +31,9 @@ New Features
        - NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes.
        - NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes.
        - NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes.
+  * Added support for the following PQC asymmetric algorithms:
+       - ML-KEM: Module-Lattice-Based Key-Encapsulation Mechanism.
+       - ML-DSA: Module-Lattice-Based Digital Signature Algorithm.
 
 .. This section should contain new features added in this release.
 
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
index 50ee140ccd..41976b3ac9 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
@@ -453,3 +453,52 @@ void
 ipsec_mb_sym_session_clear(struct rte_cryptodev *dev __rte_unused,
 		struct rte_cryptodev_sym_session *sess __rte_unused)
 {}
+
+/** Configure pmd specific multi-buffer asym session from a crypto xform chain */
+int
+ipsec_mb_asym_session_configure(
+	struct rte_cryptodev *dev, struct rte_crypto_asym_xform *xform,
+	struct rte_cryptodev_asym_session *sess)
+{
+	struct ipsec_mb_dev_private *internals = dev->data->dev_private;
+	struct ipsec_mb_internals *pmd_data =
+		&ipsec_mb_pmds[internals->pmd_type];
+	struct ipsec_mb_qp *qp = dev->data->queue_pairs[0];
+	IMB_MGR *mb_mgr = NULL;
+	int ret = 0;
+
+	if (qp != NULL)
+		mb_mgr = qp->mb_mgr;
+
+	if (!mb_mgr)
+		return -ENOMEM;
+
+	if (unlikely(sess == NULL)) {
+		IPSEC_MB_LOG(ERR, "invalid session struct");
+		if (qp == NULL)
+			free_mb_mgr(mb_mgr);
+		return -EINVAL;
+	}
+
+	ret = (*pmd_data->asym_session_configure)(mb_mgr,
+			CRYPTODEV_GET_ASYM_SESS_PRIV(sess), xform);
+	if (ret != 0) {
+		IPSEC_MB_LOG(ERR, "failed configure asym session parameters");
+		return ret;
+	}
+
+	pmd_data->asym_session_created = true;
+	return 0;
+}
+
+/** Clear the asym session memory */
+void
+ipsec_mb_asym_session_clear(struct rte_cryptodev *dev __rte_unused,
+		struct rte_cryptodev_asym_session *sess)
+{
+	struct ipsec_mb_dev_private *internals = dev->data->dev_private;
+	struct ipsec_mb_internals *pmd_data =
+		&ipsec_mb_pmds[internals->pmd_type];
+
+	(*pmd_data->asym_session_clear)(CRYPTODEV_GET_ASYM_SESS_PRIV(sess));
+}
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.h b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
index fc7d6f5f06..5509dc21f3 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.h
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
@@ -356,6 +356,12 @@ typedef int (*ipsec_mb_session_configure_t)(IMB_MGR *mbr_mgr,
 		void *session_private,
 		const struct rte_crypto_sym_xform *xform);
 
+typedef int (*ipsec_mb_asym_session_configure_t)(IMB_MGR *mbr_mgr,
+		void *session_private,
+		const struct rte_crypto_asym_xform *xform);
+
+typedef void (*ipsec_mb_asym_session_clear_t)(void *session_private);
+
 /** Configure internals PMD type specific data */
 typedef int (*ipsec_mb_dev_configure_t)(struct rte_cryptodev *dev);
 
@@ -366,6 +372,9 @@ struct ipsec_mb_internals {
 	ipsec_mb_dev_configure_t dev_config;
 	ipsec_mb_queue_pair_configure_t queue_pair_configure;
 	ipsec_mb_session_configure_t session_configure;
+	ipsec_mb_asym_session_configure_t asym_session_configure;
+	ipsec_mb_asym_session_clear_t asym_session_clear;
+	bool asym_session_created;
 	const struct rte_cryptodev_capabilities *caps;
 	struct rte_cryptodev_ops *ops;
 	struct rte_security_ops *security_ops;
@@ -423,11 +432,22 @@ int ipsec_mb_sym_session_configure(
 	struct rte_crypto_sym_xform *xform,
 	struct rte_cryptodev_sym_session *sess);
 
+/** Configure an aesni multi-buffer asym session from a crypto xform chain */
+int ipsec_mb_asym_session_configure(
+	struct rte_cryptodev *dev,
+	struct rte_crypto_asym_xform *xform,
+	struct rte_cryptodev_asym_session *sess);
+
 /** Clear the memory of session so it does not leave key material behind */
 void
 ipsec_mb_sym_session_clear(struct rte_cryptodev *dev,
 				struct rte_cryptodev_sym_session *sess);
 
+/** Clear the asym session memory */
+void
+ipsec_mb_asym_session_clear(struct rte_cryptodev *dev,
+				struct rte_cryptodev_asym_session *sess);
+
 /** Get session from op. If sessionless create a session */
 static __rte_always_inline void *
 ipsec_mb_get_session_private(struct ipsec_mb_qp *qp, struct rte_crypto_op *op)
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a3f143d388..9969a24fcc 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -892,7 +892,7 @@ aesni_mb_set_session_aead_parameters(IMB_MGR *mb_mgr,
 }
 
 /** Configure a aesni multi-buffer session from a crypto xform chain */
-int
+static int
 aesni_mb_session_configure(IMB_MGR *mb_mgr,
 		void *priv_sess,
 		const struct rte_crypto_sym_xform *xform)
@@ -983,6 +983,97 @@ aesni_mb_session_configure(IMB_MGR *mb_mgr,
 	return 0;
 }
 
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+/** Configure a aesni multi-buffer asym session from a crypto xform chain */
+static int
+aesni_mb_asym_session_configure(IMB_MGR *mb_mgr,
+		void *priv_sess,
+		const struct rte_crypto_asym_xform *xform)
+{
+	(void)mb_mgr;
+	struct aesni_mb_session *sess = (struct aesni_mb_session *) priv_sess;
+	int ret = 0;
+
+	sess->asym.xform_type = xform->xform_type;
+
+	switch (sess->asym.xform_type) {
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+	{
+		switch (xform->mlkem.type) {
+		case RTE_CRYPTO_ML_KEM_512:
+			sess->asym.ml_kem.alg = IMB_ML_KEM_512;
+			break;
+		case RTE_CRYPTO_ML_KEM_768:
+			sess->asym.ml_kem.alg = IMB_ML_KEM_768;
+			break;
+		case RTE_CRYPTO_ML_KEM_1024:
+			sess->asym.ml_kem.alg = IMB_ML_KEM_1024;
+			break;
+		default:
+			ret = -ENOTSUP;
+			IPSEC_MB_LOG(ERR, "Unsupported type");
+			return ret;
+		}
+		ret = imb_ml_kem_new(mb_mgr, sess->asym.ml_kem.alg, &sess->asym.ml_kem.ctx);
+		if (ret) {
+			IPSEC_MB_LOG(ERR, "Failed to create ML KEM session");
+			return ret;
+		}
+		IMB_ML_KEM_KEYGEN_PARAMS_INIT(&sess->asym.ml_kem.keygen_params);
+		IMB_ML_KEM_ENCAP_PARAMS_INIT(&sess->asym.ml_kem.encap_params);
+	}
+	break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+	{
+		switch (xform->mldsa.type) {
+		case RTE_CRYPTO_ML_DSA_44:
+			sess->asym.ml_dsa.alg = IMB_ML_DSA_44;
+			break;
+		case RTE_CRYPTO_ML_DSA_65:
+			sess->asym.ml_dsa.alg = IMB_ML_DSA_65;
+			break;
+		case RTE_CRYPTO_ML_DSA_87:
+			sess->asym.ml_dsa.alg = IMB_ML_DSA_87;
+			break;
+		default:
+			ret = -ENOTSUP;
+			IPSEC_MB_LOG(ERR, "Unsupported type");
+			return ret;
+		}
+		ret = imb_ml_dsa_new(mb_mgr, sess->asym.ml_dsa.alg, &sess->asym.ml_dsa.ctx);
+		if (ret) {
+			IPSEC_MB_LOG(ERR, "Failed to create ML DSA session");
+			return ret;
+		}
+		IMB_ML_DSA_KEYGEN_PARAMS_INIT(&sess->asym.ml_dsa.keygen_params);
+		IMB_ML_DSA_SIGN_PARAMS_INIT(&sess->asym.ml_dsa.sign_params);
+		IMB_ML_DSA_VERIFY_PARAMS_INIT(&sess->asym.ml_dsa.verify_params);
+	}
+	break;
+	default:
+		ret = -ENOTSUP;
+		IPSEC_MB_LOG(ERR, "Unsupported algorithm");
+		return ret;
+	};
+
+	return ret;
+}
+
+static void
+aesni_mb_asym_session_clear(void *priv_sess)
+{
+	struct aesni_mb_session *sess = (struct aesni_mb_session *) priv_sess;
+	if (sess->asym.xform_type == RTE_CRYPTO_ASYM_XFORM_ML_KEM) {
+		imb_ml_kem_free(sess->asym.ml_kem.ctx);
+		sess->asym.ml_kem.ctx = NULL;
+	} else if (sess->asym.xform_type == RTE_CRYPTO_ASYM_XFORM_ML_DSA) {
+		imb_ml_dsa_free(sess->asym.ml_dsa.ctx);
+		sess->asym.ml_dsa.ctx = NULL;
+	}
+}
+
+#endif
+
 /** Check DOCSIS security session configuration is valid */
 static int
 check_docsis_sec_session(struct rte_security_session_conf *conf)
@@ -2415,7 +2506,237 @@ set_job_null_op(IMB_JOB *job, struct rte_crypto_op *op)
 	return job;
 }
 
-uint16_t
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+static inline size_t aesni_mb_ml_kem_ek_sz(const IMB_ML_KEM_ALG alg)
+{
+		switch (alg) {
+		case IMB_ML_KEM_512:
+				return IMB_ML_KEM_512_PUBKEY_BYTES;
+		case IMB_ML_KEM_768:
+				return IMB_ML_KEM_768_PUBKEY_BYTES;
+		case IMB_ML_KEM_1024:
+				return IMB_ML_KEM_1024_PUBKEY_BYTES;
+		}
+		return 0;
+}
+static inline size_t aesni_mb_ml_kem_dk_sz(const IMB_ML_KEM_ALG alg)
+{
+		switch (alg) {
+		case IMB_ML_KEM_512:
+				return IMB_ML_KEM_512_PRIVKEY_BYTES;
+		case IMB_ML_KEM_768:
+				return IMB_ML_KEM_768_PRIVKEY_BYTES;
+		case IMB_ML_KEM_1024:
+				return IMB_ML_KEM_1024_PRIVKEY_BYTES;
+		}
+		return 0;
+}
+static inline size_t aesni_mb_ml_kem_ct_sz(const IMB_ML_KEM_ALG alg)
+{
+		switch (alg) {
+		case IMB_ML_KEM_512:
+				return IMB_ML_KEM_512_CIPHERTEXT_BYTES;
+		case IMB_ML_KEM_768:
+				return IMB_ML_KEM_768_CIPHERTEXT_BYTES;
+		case IMB_ML_KEM_1024:
+				return IMB_ML_KEM_1024_CIPHERTEXT_BYTES;
+		}
+		return 0;
+}
+static inline size_t aesni_mb_ml_dsa_pk_sz(const IMB_ML_DSA_ALG alg)
+{
+		switch (alg) {
+		case IMB_ML_DSA_44:
+				return IMB_ML_DSA_44_PUBKEY_BYTES;
+		case IMB_ML_DSA_65:
+				return IMB_ML_DSA_65_PUBKEY_BYTES;
+		case IMB_ML_DSA_87:
+				return IMB_ML_DSA_87_PUBKEY_BYTES;
+		}
+		return 0;
+}
+static inline size_t aesni_mb_ml_dsa_sk_sz(const IMB_ML_DSA_ALG alg)
+{
+		switch (alg) {
+		case IMB_ML_DSA_44:
+				return IMB_ML_DSA_44_PRIVKEY_BYTES;
+		case IMB_ML_DSA_65:
+				return IMB_ML_DSA_65_PRIVKEY_BYTES;
+		case IMB_ML_DSA_87:
+				return IMB_ML_DSA_87_PRIVKEY_BYTES;
+		}
+		return 0;
+}
+static inline size_t aesni_mb_ml_dsa_sig_sz(const IMB_ML_DSA_ALG alg)
+{
+		switch (alg) {
+		case IMB_ML_DSA_44:
+				return IMB_ML_DSA_44_SIG_BYTES;
+		case IMB_ML_DSA_65:
+				return IMB_ML_DSA_65_SIG_BYTES;
+		case IMB_ML_DSA_87:
+				return IMB_ML_DSA_87_SIG_BYTES;
+		}
+		return 0;
+}
+
+static void
+aesni_mb_asym_process(struct rte_crypto_op *op)
+{
+	struct rte_crypto_asym_op *aop = op->asym;
+	struct aesni_mb_session *sess =
+		CRYPTODEV_GET_ASYM_SESS_PRIV(aop->session);
+	op->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
+	int rc = 0;
+
+	switch (sess->asym.xform_type) {
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+	{
+		struct rte_crypto_ml_kem_op *mlkem = &aop->mlkem;
+		switch (mlkem->op) {
+		case RTE_CRYPTO_ML_KEM_OP_KEYGEN:
+		{
+			uint8_t seed_d_z[64];
+			struct rte_crypto_ml_kem_keygen_op *keygen = &mlkem->keygen;
+			memcpy(seed_d_z,      keygen->d.data, 32);
+			memcpy(&seed_d_z[32], keygen->z.data, 32);
+			sess->asym.ml_kem.keygen_params.seed_d_z = seed_d_z;
+			sess->asym.ml_kem.keygen_params.seed_d_z_len = 64;
+			keygen->ek.length = aesni_mb_ml_kem_ek_sz(sess->asym.ml_kem.alg);
+			keygen->dk.length = aesni_mb_ml_kem_dk_sz(sess->asym.ml_kem.alg);
+			rc = imb_ml_kem_keypair(sess->asym.ml_kem.ctx,
+				keygen->ek.data, keygen->ek.length,
+				keygen->dk.data, keygen->dk.length,
+				&sess->asym.ml_kem.keygen_params);
+		}
+			break;
+		case RTE_CRYPTO_ML_KEM_OP_ENCAP:
+		{
+			struct rte_crypto_ml_kem_encap_op *encap = &mlkem->encap;
+			sess->asym.ml_kem.encap_params.m_32 = encap->message.data;
+			sess->asym.ml_kem.encap_params.m_len = encap->message.length;
+			encap->ek.length = aesni_mb_ml_kem_ek_sz(sess->asym.ml_kem.alg);
+			encap->cipher.length = aesni_mb_ml_kem_ct_sz(sess->asym.ml_kem.alg);
+			rc = imb_ml_kem_set_pubkey(sess->asym.ml_kem.ctx,
+				encap->ek.data, encap->ek.length);
+			if (rc == 0)
+				rc = imb_ml_kem_encap(sess->asym.ml_kem.ctx,
+					encap->cipher.data, encap->cipher.length,
+					encap->sk.data, encap->sk.length,
+					&sess->asym.ml_kem.encap_params);
+		}
+			break;
+		case RTE_CRYPTO_ML_KEM_OP_DECAP:
+		{
+			struct rte_crypto_ml_kem_decap_op *decap = &mlkem->decap;
+			decap->dk.length = aesni_mb_ml_kem_dk_sz(sess->asym.ml_kem.alg);
+			decap->cipher.length = aesni_mb_ml_kem_ct_sz(sess->asym.ml_kem.alg);
+			rc = imb_ml_kem_set_privkey(sess->asym.ml_kem.ctx,
+				decap->dk.data, decap->dk.length);
+			if (rc == 0)
+				rc = imb_ml_kem_decap(sess->asym.ml_kem.ctx,
+					decap->sk.data, decap->sk.length,
+					decap->cipher.data, decap->cipher.length,
+					NULL);
+		}
+			break;
+		default:
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			break;
+		};
+	}
+	break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+	{
+		struct rte_crypto_ml_dsa_op *mldsa = &aop->mldsa;
+		switch (mldsa->op) {
+		case RTE_CRYPTO_ML_DSA_OP_KEYGEN:
+		{
+			struct rte_crypto_ml_dsa_keygen_op *keygen = &mldsa->keygen;
+			sess->asym.ml_dsa.keygen_params.xi_32 = keygen->seed.data;
+			sess->asym.ml_dsa.keygen_params.xi_len = keygen->seed.length;
+			keygen->pubkey.length =
+				aesni_mb_ml_dsa_pk_sz(sess->asym.ml_dsa.alg);
+			keygen->privkey.length =
+				aesni_mb_ml_dsa_sk_sz(sess->asym.ml_dsa.alg);
+			rc = imb_ml_dsa_keypair(sess->asym.ml_dsa.ctx,
+				keygen->pubkey.data, keygen->pubkey.length,
+				keygen->privkey.data, keygen->privkey.length,
+				&sess->asym.ml_dsa.keygen_params);
+		}
+		break;
+		case RTE_CRYPTO_ML_DSA_OP_SIGN:
+		{
+			struct rte_crypto_ml_dsa_siggen_op *siggen = &mldsa->siggen;
+			void *md;
+			size_t md_len;
+			sess->asym.ml_dsa.sign_params.ctx = siggen->ctx.data;
+			sess->asym.ml_dsa.sign_params.ctx_len = siggen->ctx.length;
+			sess->asym.ml_dsa.sign_params.rnd_32 = siggen->seed.data;
+			sess->asym.ml_dsa.sign_params.rnd_len = siggen->seed.length;
+			if (siggen->mu.length) {
+				md = siggen->mu.data;
+				md_len = siggen->mu.length;
+				sess->asym.ml_dsa.sign_params.msg_is_mu = 1;
+			} else {
+				md = siggen->message.data;
+				md_len = siggen->message.length;
+				sess->asym.ml_dsa.sign_params.msg_is_mu = 0;
+			}
+			rc = imb_ml_dsa_set_privkey(sess->asym.ml_dsa.ctx,
+				siggen->privkey.data, siggen->privkey.length);
+			if (rc == 0)
+				rc = imb_ml_dsa_sign(sess->asym.ml_dsa.ctx,
+					siggen->sign.data, &siggen->sign.length,
+					md, md_len, &sess->asym.ml_dsa.sign_params);
+		}
+		break;
+		case RTE_CRYPTO_ML_DSA_OP_VERIFY:
+		{
+			struct rte_crypto_ml_dsa_sigver_op *sigver = &mldsa->sigver;
+			void *md;
+			size_t md_len;
+			sess->asym.ml_dsa.verify_params.ctx = sigver->ctx.data;
+			sess->asym.ml_dsa.verify_params.ctx_len = sigver->ctx.length;
+			if (sigver->mu.length) {
+				md = sigver->mu.data;
+				md_len = sigver->mu.length;
+				sess->asym.ml_dsa.verify_params.msg_is_mu = 1;
+			} else {
+				md = sigver->message.data;
+				md_len = sigver->message.length;
+				sess->asym.ml_dsa.verify_params.msg_is_mu = 0;
+			}
+			rc = imb_ml_dsa_set_pubkey(sess->asym.ml_dsa.ctx,
+				sigver->pubkey.data, sigver->pubkey.length);
+			if (rc == 0)
+				rc = imb_ml_dsa_verify(sess->asym.ml_dsa.ctx,
+					md, md_len, sigver->sign.data, sigver->sign.length,
+					&sess->asym.ml_dsa.verify_params);
+		}
+		break;
+		default:
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			break;
+		};
+
+	}
+	break;
+	default:
+		op->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		break;
+	}
+	if (op->status == RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
+		op->status = (rc == 0) ? RTE_CRYPTO_OP_STATUS_SUCCESS :
+			RTE_CRYPTO_OP_STATUS_ERROR;
+#ifdef RTE_LIBRTE_PMD_AESNI_MB_DEBUG
+	if (rc)
+		IPSEC_MB_LOG(ERR, "%s", imb_get_strerror(rc));
+#endif
+}
+#endif
+
+static uint16_t
 aesni_mb_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
 		uint16_t nb_ops)
 {
@@ -2480,8 +2801,38 @@ aesni_mb_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
 		 * the IMB_MGR can use that pointer again in next
 		 * get_next calls.
 		 */
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		{
+			struct ipsec_mb_internals *pmd_data =
+				&ipsec_mb_pmds[qp->pmd_type];
+			/* If there is at least one asym session created process
+			 * the asym ops here and copy the sym ops to deqd_ops array
+			 */
+			if (pmd_data->asym_session_created) {
+				struct rte_crypto_op *tmp_dq[IMB_MAX_BURST_SIZE];
+				uint16_t sym_cnt = 0;
+				nb_submit_ops = rte_ring_dequeue_burst(qp->ingress_queue,
+								(void **)tmp_dq, n, NULL);
+				for (i = 0; i < nb_submit_ops; i++) {
+					if (tmp_dq[i]->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+						aesni_mb_asym_process(tmp_dq[i]);
+						ops[processed_jobs++] = tmp_dq[i];
+					} else {
+						deqd_ops[sym_cnt++] = tmp_dq[i];
+					}
+				}
+				/* What remains are only symmetric ops. */
+				nb_submit_ops = sym_cnt;
+			} else {
+				/* No asym session created, all ops are sym*/
+				nb_submit_ops = rte_ring_dequeue_burst(qp->ingress_queue,
+								(void **)deqd_ops, n, NULL);
+			}
+		}
+#else
 		nb_submit_ops = rte_ring_dequeue_burst(qp->ingress_queue,
 						(void **)deqd_ops, n, NULL);
+#endif
 		for (i = 0; i < nb_submit_ops; i++) {
 			job = jobs[i];
 			op = deqd_ops[i];
@@ -2611,7 +2962,7 @@ verify_sync_dgst(struct rte_crypto_sym_vec *vec,
 	return k;
 }
 
-uint32_t
+static uint32_t
 aesni_mb_process_bulk(struct rte_cryptodev *dev __rte_unused,
 	struct rte_cryptodev_sym_session *sess, union rte_crypto_sym_ofs sofs,
 	struct rte_crypto_sym_vec *vec)
@@ -2698,7 +3049,12 @@ struct rte_cryptodev_ops aesni_mb_pmd_ops = {
 
 	.sym_session_get_size = ipsec_mb_sym_session_get_size,
 	.sym_session_configure = ipsec_mb_sym_session_configure,
-	.sym_session_clear = ipsec_mb_sym_session_clear
+	.sym_session_clear = ipsec_mb_sym_session_clear,
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	.asym_session_get_size = ipsec_mb_sym_session_get_size,
+	.asym_session_configure = ipsec_mb_asym_session_configure,
+	.asym_session_clear = ipsec_mb_asym_session_clear,
+#endif
 };
 
 /**
@@ -2824,7 +3180,11 @@ RTE_INIT(ipsec_mb_register_aesni_mb)
 			RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT |
 			RTE_CRYPTODEV_FF_SYM_CPU_CRYPTO |
 #if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+			/* removed in 3.0 */
 			RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA |
+#else
+			/* added in 3.0 */
+			RTE_CRYPTODEV_FF_ASYMMETRIC_CRYPTO |
 #endif
 			RTE_CRYPTODEV_FF_SYM_SESSIONLESS |
 			RTE_CRYPTODEV_FF_IN_PLACE_SGL |
@@ -2841,5 +3201,9 @@ RTE_INIT(ipsec_mb_register_aesni_mb)
 	aesni_mb_data->security_ops = &aesni_mb_pmd_sec_ops;
 	aesni_mb_data->dev_config = aesni_mb_configure_dev;
 	aesni_mb_data->session_configure = aesni_mb_session_configure;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	aesni_mb_data->asym_session_configure = aesni_mb_asym_session_configure;
+	aesni_mb_data->asym_session_clear = aesni_mb_asym_session_clear;
+#endif
 	aesni_mb_data->session_priv_size = sizeof(struct aesni_mb_session);
 }
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index a8fec4a651..f57f2964ed 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -28,18 +28,6 @@
 #define IMB_AUTH_ZUC256_EIA3 IMB_AUTH_ZUC256_EIA3_BITLEN
 #endif
 
-int
-aesni_mb_session_configure(IMB_MGR * m __rte_unused, void *priv_sess,
-		const struct rte_crypto_sym_xform *xform);
-
-uint16_t
-aesni_mb_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
-		uint16_t nb_ops);
-
-uint32_t
-aesni_mb_process_bulk(struct rte_cryptodev *dev __rte_unused,
-	struct rte_cryptodev_sym_session *sess, union rte_crypto_sym_ofs sofs,
-	struct rte_crypto_sym_vec *vec);
 
 static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 	{	/* MD5 HMAC */
@@ -1118,6 +1106,60 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+	{
+		/* ML-KEM */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_KEM,
+				.op_types =
+				((1 << RTE_CRYPTO_ML_KEM_OP_KEYGEN) |
+				 (1 << RTE_CRYPTO_ML_KEM_OP_ENCAP) |
+				 (1 << RTE_CRYPTO_ML_KEM_OP_DECAP)),
+				.mlkem_capa = {
+					[RTE_CRYPTO_ML_KEM_OP_KEYGEN] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024),
+					[RTE_CRYPTO_ML_KEM_OP_ENCAP] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024),
+					[RTE_CRYPTO_ML_KEM_OP_DECAP] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024)
+				}
+			}
+		}
+	},
+	{
+		/* ML-DSA */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA,
+				.op_types =
+				((1 << RTE_CRYPTO_ML_DSA_OP_SIGN) |
+				 (1 << RTE_CRYPTO_ML_DSA_OP_KEYGEN) |
+				 (1 << RTE_CRYPTO_ML_DSA_OP_VERIFY)),
+				.mldsa_capa = {
+					[RTE_CRYPTO_ML_DSA_OP_KEYGEN] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87),
+					[RTE_CRYPTO_ML_DSA_OP_SIGN] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87),
+					[RTE_CRYPTO_ML_DSA_OP_VERIFY] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87)
+				}
+			}
+		}
+	},
 #endif
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
@@ -1365,6 +1407,26 @@ struct __rte_cache_aligned aesni_mb_session {
 		uint16_t req_digest_len;
 
 	} auth;
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	struct {
+		enum rte_crypto_asym_xform_type xform_type;
+		union {
+			struct {
+				IMB_ML_KEM *ctx;
+				IMB_ML_KEM_ALG alg;
+				IMB_ML_KEM_KEYGEN_PARAMS keygen_params;
+				IMB_ML_KEM_ENCAP_PARAMS encap_params;
+			} ml_kem;
+			struct {
+				IMB_ML_DSA *ctx;
+				IMB_ML_DSA_ALG alg;
+				IMB_ML_DSA_KEYGEN_PARAMS keygen_params;
+				IMB_ML_DSA_SIGN_PARAMS sign_params;
+				IMB_ML_DSA_VERIFY_PARAMS verify_params;
+			} ml_dsa;
+		};
+	} asym;
+	#endif
 };
 
 typedef void (*hash_one_block_t)(const void *data, void *digest);
-- 
2.52.0

