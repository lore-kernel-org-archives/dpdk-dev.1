Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCD606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PB2IGPrw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA39340283;
	Tue, 10 Nov 2026 13:00:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 12B564027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794312021; x=1825848021;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gKQtRa+srby8r1Zu1zaSlb3EG4niwOSXe92BDN++ouE=;
 b=PB2IGPrwRfPEKrvXG6Gj+CCfYUzwOrPWoQCNk2pRUxcbo4XB3WpwIdcy
 RkwRL59RUd2QL6xZqYtoKJDuEyHyDHhxfKLyaYoMP+1cYEnjMW0kJEbE5
 VUwr+WSQm42aSbp234P1dzfLvpLsqUytbZjhWn2ORa5pN8s176YmOjE46
 MPUfw834+p1CbaXkh6KKsC7NFzQ7Rgieq8TlNiyy9uSjbT4rjdOoRkJ+R
 /qm2r9dURU+hRRPbbmzIDysocsKzKtx27Mw5/p2AyGV8BH3civf53WjoE
 xk1+y/qOSDOA1nAXrrwkk7PMdeEqpEz3XQG4d2kMTQxp7IYkgooQp1knL A==;
X-CSE-ConnectionGUID: Khs6PaWoTcmLHRFFg1dB3g==
X-CSE-MsgGUID: 73gXtxNpSKS7h0U+5O9F3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2953490"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2953490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:00:19 -0800
X-CSE-ConnectionGUID: ZJ9Fy9oYQkeR5V5LOCfWEw==
X-CSE-MsgGUID: 45a3h72tR0+z86ThZx5pKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8279508"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2026 04:00:17 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v6 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Tue, 10 Nov 2026 12:00:11 +0000
Message-ID: <20261110120015.2937289-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for IPsecMB release 3.0
 - removed all _BITLEN enums, all lengths are in bytes
 - removed feature flag
 - use non const IMB_MGR
 - use IMB API instead of function pointers in the GCM PMD
 - remove ZUC 256 support

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Kai Ji <kai.ji@intel.com>
Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 doc/guides/cryptodevs/aesni_gcm.rst          |   4 +-
 doc/guides/cryptodevs/aesni_mb.rst           |  11 +-
 doc/guides/cryptodevs/features/aesni_mb.ini  |   2 +-
 doc/guides/rel_notes/release_26_11.rst       |   4 +
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++++++++++++----
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +--
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 107 +++++---
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  |  53 +++-
 8 files changed, 356 insertions(+), 123 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index 4683e9dd86..5bcae20886 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -40,8 +40,8 @@ Installation
 To build DPDK with the AESNI_GCM_PMD the user is required to download the multi-buffer
 library from `here <https://github.com/01org/intel-ipsec-mb>`_
 and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded in `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
+The latest version of the library supported by this PMD is v3.0, which
+can be downloaded from `<https://github.com/intel/intel-ipsec-mb/archive/refs/tags/v3.0.0.zip>`_.
 
 For Arm system, ARM64 port of the multi-buffer library can be downloaded from
 https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/.
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index da37d54471..519f965731 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -83,6 +83,13 @@ Protocol offloads:
 
 * RTE_SECURITY_PROTOCOL_DOCSIS
 
+Note
+----
+Version 3.0 of the multi-buffer library removed support for:
+
+* the 256 bit versions of ZUC EEA3 and ZUC EIA3 algorithms.
+* non byte aligned bit length (``RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA`` removed).
+
 Limitations
 -----------
 
@@ -106,8 +113,8 @@ Installation
 To build DPDK with the AESNI_MB_PMD the user is required to download the multi-buffer
 library from `here <https://github.com/01org/intel-ipsec-mb>`_
 and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
+The latest version of the library supported by this PMD is v3.0, which
+can be downloaded from `<https://github.com/intel/intel-ipsec-mb/archive/refs/tags/v3.0.0.zip>`_.
 
 For Arm system, ARM64 port of the multi-buffer library can be downloaded from
 https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/.
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index 18109ffe05..d27b96eb2d 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -19,7 +19,7 @@ OOP LB  In SGL Out     = Y
 OOP LB  In LB  Out     = Y
 CPU crypto             = Y
 Symmetric sessionless  = Y
-Non-Byte aligned data  = Y
+Non-Byte aligned data  = N
 Digest encrypted       = Y
 
 ;
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b24019d34a..58c30ad173 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -24,6 +24,10 @@ DPDK Release 26.11
 New Features
 ------------
 
+* **Updated AESNI_MB crypto driver.**
+
+  * Added support for version 3.0 of IPsec MB Library.
+
 .. This section should contain new features added in this release.
    Sample format:
 
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 2a4bede7dd..18a26147a0 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -6,56 +6,205 @@
 
 #include "pmd_aesni_gcm_priv.h"
 
+/* wrapper functions for library versions < 3.0.0 */
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_pre(const void *key, \
+		struct gcm_key_data *key_data, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_pre(key, key_data); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_init( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, const void *iv, \
+		const void *aad, uint64_t aad_len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_init(key_data, context_data, iv, aad, aad_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *out, \
+		const void *in, uint64_t len, const void *iv, \
+		const void *aad, uint64_t aad_len, void *auth_tag, \
+		uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_enc(key_data, context_data, out, in, len, iv, \
+			aad, aad_len, auth_tag, auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_update( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *out, \
+		const void *in, const uint64_t len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_enc_update(key_data, context_data, out, in, len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_finalize( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *auth_tag, \
+		const uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_enc_finalize(key_data, context_data, auth_tag, \
+			auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *out, \
+		const void *in, uint64_t len, const void *iv, \
+		const void *aad, uint64_t aad_len, void *auth_tag, \
+		uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_dec(key_data, context_data, out, in, len, iv, \
+			aad, aad_len, auth_tag, auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_update( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *out, \
+		const void *in, const uint64_t len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_dec_update(key_data, context_data, out, in, len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_finalize( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *auth_tag, \
+		const uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+	state->gcm##bitlen##_dec_finalize(key_data, context_data, auth_tag, \
+			auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_init( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, const void *iv, \
+		const uint64_t iv_len, IMB_MGR *state) \
+{ \
+	state->gmac##bitlen##_init(key_data, context_data, iv, iv_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_update( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, const void *in, \
+		const uint64_t len, IMB_MGR *state) \
+{ \
+	state->gmac##bitlen##_update(key_data, context_data, in, len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_finalize( \
+		const struct gcm_key_data *key_data, \
+		struct gcm_context_data *context_data, void *auth_tag, \
+		const uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+	state->gmac##bitlen##_finalize(key_data, context_data, auth_tag, \
+			auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#endif
+
 static void
 aesni_gcm_set_ops(struct aesni_gcm_ops *ops, IMB_MGR *mb_mgr)
 {
+	/* Set IMB_MGR pointers. */
+	ops[GCM_KEY_128].mb_mgr = mb_mgr;
+	ops[GCM_KEY_192].mb_mgr = mb_mgr;
+	ops[GCM_KEY_256].mb_mgr = mb_mgr;
+
 	/* Set 128 bit function pointers. */
-	ops[GCM_KEY_128].pre = mb_mgr->gcm128_pre;
-	ops[GCM_KEY_128].init = mb_mgr->gcm128_init;
+	ops[GCM_KEY_128].pre = imb_aes128_gcm_pre;
+	ops[GCM_KEY_128].init = imb_aes128_gcm_init;
 
-	ops[GCM_KEY_128].enc = mb_mgr->gcm128_enc;
-	ops[GCM_KEY_128].update_enc = mb_mgr->gcm128_enc_update;
-	ops[GCM_KEY_128].finalize_enc = mb_mgr->gcm128_enc_finalize;
+	ops[GCM_KEY_128].enc = imb_aes128_gcm_enc;
+	ops[GCM_KEY_128].update_enc = imb_aes128_gcm_enc_update;
+	ops[GCM_KEY_128].finalize_enc = imb_aes128_gcm_enc_finalize;
 
-	ops[GCM_KEY_128].dec = mb_mgr->gcm128_dec;
-	ops[GCM_KEY_128].update_dec = mb_mgr->gcm128_dec_update;
-	ops[GCM_KEY_128].finalize_dec = mb_mgr->gcm128_dec_finalize;
+	ops[GCM_KEY_128].dec = imb_aes128_gcm_dec;
+	ops[GCM_KEY_128].update_dec = imb_aes128_gcm_dec_update;
+	ops[GCM_KEY_128].finalize_dec = imb_aes128_gcm_dec_finalize;
 
-	ops[GCM_KEY_128].gmac_init = mb_mgr->gmac128_init;
-	ops[GCM_KEY_128].gmac_update = mb_mgr->gmac128_update;
-	ops[GCM_KEY_128].gmac_finalize = mb_mgr->gmac128_finalize;
+	ops[GCM_KEY_128].gmac_init = imb_aes128_gmac_init;
+	ops[GCM_KEY_128].gmac_update = imb_aes128_gmac_update;
+	ops[GCM_KEY_128].gmac_finalize = imb_aes128_gmac_finalize;
 
 	/* Set 192 bit function pointers. */
-	ops[GCM_KEY_192].pre = mb_mgr->gcm192_pre;
-	ops[GCM_KEY_192].init = mb_mgr->gcm192_init;
+	ops[GCM_KEY_192].pre = imb_aes192_gcm_pre;
+	ops[GCM_KEY_192].init = imb_aes192_gcm_init;
 
-	ops[GCM_KEY_192].enc = mb_mgr->gcm192_enc;
-	ops[GCM_KEY_192].update_enc = mb_mgr->gcm192_enc_update;
-	ops[GCM_KEY_192].finalize_enc = mb_mgr->gcm192_enc_finalize;
+	ops[GCM_KEY_192].enc = imb_aes192_gcm_enc;
+	ops[GCM_KEY_192].update_enc = imb_aes192_gcm_enc_update;
+	ops[GCM_KEY_192].finalize_enc = imb_aes192_gcm_enc_finalize;
 
-	ops[GCM_KEY_192].dec = mb_mgr->gcm192_dec;
-	ops[GCM_KEY_192].update_dec = mb_mgr->gcm192_dec_update;
-	ops[GCM_KEY_192].finalize_dec = mb_mgr->gcm192_dec_finalize;
+	ops[GCM_KEY_192].dec = imb_aes192_gcm_dec;
+	ops[GCM_KEY_192].update_dec = imb_aes192_gcm_dec_update;
+	ops[GCM_KEY_192].finalize_dec = imb_aes192_gcm_dec_finalize;
 
-	ops[GCM_KEY_192].gmac_init = mb_mgr->gmac192_init;
-	ops[GCM_KEY_192].gmac_update = mb_mgr->gmac192_update;
-	ops[GCM_KEY_192].gmac_finalize = mb_mgr->gmac192_finalize;
+	ops[GCM_KEY_192].gmac_init = imb_aes192_gmac_init;
+	ops[GCM_KEY_192].gmac_update = imb_aes192_gmac_update;
+	ops[GCM_KEY_192].gmac_finalize = imb_aes192_gmac_finalize;
 
 	/* Set 256 bit function pointers. */
-	ops[GCM_KEY_256].pre = mb_mgr->gcm256_pre;
-	ops[GCM_KEY_256].init = mb_mgr->gcm256_init;
+	ops[GCM_KEY_256].pre = imb_aes256_gcm_pre;
+	ops[GCM_KEY_256].init = imb_aes256_gcm_init;
 
-	ops[GCM_KEY_256].enc = mb_mgr->gcm256_enc;
-	ops[GCM_KEY_256].update_enc = mb_mgr->gcm256_enc_update;
-	ops[GCM_KEY_256].finalize_enc = mb_mgr->gcm256_enc_finalize;
+	ops[GCM_KEY_256].enc = imb_aes256_gcm_enc;
+	ops[GCM_KEY_256].update_enc = imb_aes256_gcm_enc_update;
+	ops[GCM_KEY_256].finalize_enc = imb_aes256_gcm_enc_finalize;
 
-	ops[GCM_KEY_256].dec = mb_mgr->gcm256_dec;
-	ops[GCM_KEY_256].update_dec = mb_mgr->gcm256_dec_update;
-	ops[GCM_KEY_256].finalize_dec = mb_mgr->gcm256_dec_finalize;
+	ops[GCM_KEY_256].dec = imb_aes256_gcm_dec;
+	ops[GCM_KEY_256].update_dec = imb_aes256_gcm_dec_update;
+	ops[GCM_KEY_256].finalize_dec = imb_aes256_gcm_dec_finalize;
 
-	ops[GCM_KEY_256].gmac_init = mb_mgr->gmac256_init;
-	ops[GCM_KEY_256].gmac_update = mb_mgr->gmac256_update;
-	ops[GCM_KEY_256].gmac_finalize = mb_mgr->gmac256_finalize;
+	ops[GCM_KEY_256].gmac_init = imb_aes256_gmac_init;
+	ops[GCM_KEY_256].gmac_update = imb_aes256_gmac_update;
+	ops[GCM_KEY_256].gmac_finalize = imb_aes256_gmac_finalize;
 }
 
 static int
@@ -135,15 +284,15 @@ aesni_gcm_session_configure(IMB_MGR *mb_mgr, void *session,
 	switch (key_length) {
 	case 16:
 		sess->key_length = GCM_KEY_128;
-		mb_mgr->gcm128_pre(key, &sess->gdata_key);
+		imb_aes128_gcm_pre(key, &sess->gdata_key, mb_mgr);
 		break;
 	case 24:
 		sess->key_length = GCM_KEY_192;
-		mb_mgr->gcm192_pre(key, &sess->gdata_key);
+		imb_aes192_gcm_pre(key, &sess->gdata_key, mb_mgr);
 		break;
 	case 32:
 		sess->key_length = GCM_KEY_256;
-		mb_mgr->gcm256_pre(key, &sess->gdata_key);
+		imb_aes256_gcm_pre(key, &sess->gdata_key, mb_mgr);
 		break;
 	default:
 		IPSEC_MB_LOG(ERR, "Invalid key length");
@@ -324,10 +473,10 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 	if (session->op == IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT) {
 		ops->init(&session->gdata_key, &qp_data->gcm_ctx_data, iv_ptr,
 				sym_op->aead.aad.data,
-				(uint64_t)session->aad_length);
+				(uint64_t)session->aad_length, ops->mb_mgr);
 
 		ops->update_enc(&session->gdata_key, &qp_data->gcm_ctx_data,
-				dst, src, (uint64_t)part_len);
+				dst, src, (uint64_t)part_len, ops->mb_mgr);
 		total_len = data_length - part_len;
 
 		while (total_len) {
@@ -345,7 +494,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 
 			ops->update_enc(&session->gdata_key,
 					&qp_data->gcm_ctx_data,
-					dst, src, (uint64_t)part_len);
+					dst, src, (uint64_t)part_len, ops->mb_mgr);
 			total_len -= part_len;
 		}
 
@@ -355,14 +504,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 			tag = sym_op->aead.digest.data;
 
 		ops->finalize_enc(&session->gdata_key, &qp_data->gcm_ctx_data,
-				tag, session->gen_digest_length);
+				tag, session->gen_digest_length, ops->mb_mgr);
 	} else if (session->op == IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT) {
 		ops->init(&session->gdata_key, &qp_data->gcm_ctx_data, iv_ptr,
 				sym_op->aead.aad.data,
-				(uint64_t)session->aad_length);
+				(uint64_t)session->aad_length, ops->mb_mgr);
 
 		ops->update_dec(&session->gdata_key, &qp_data->gcm_ctx_data,
-				dst, src, (uint64_t)part_len);
+				dst, src, (uint64_t)part_len, ops->mb_mgr);
 		total_len = data_length - part_len;
 
 		while (total_len) {
@@ -380,19 +529,19 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 
 			ops->update_dec(&session->gdata_key,
 					&qp_data->gcm_ctx_data,
-					dst, src, (uint64_t)part_len);
+					dst, src, (uint64_t)part_len, ops->mb_mgr);
 			total_len -= part_len;
 		}
 
 		tag = qp_data->temp_digest;
 		ops->finalize_dec(&session->gdata_key, &qp_data->gcm_ctx_data,
-				tag, session->gen_digest_length);
+				tag, session->gen_digest_length, ops->mb_mgr);
 	} else if (session->op == IPSEC_MB_OP_HASH_GEN_ONLY) {
 		ops->gmac_init(&session->gdata_key, &qp_data->gcm_ctx_data,
-				iv_ptr, session->iv.length);
+				iv_ptr, session->iv.length, ops->mb_mgr);
 
 		ops->gmac_update(&session->gdata_key, &qp_data->gcm_ctx_data,
-				src, (uint64_t)part_len);
+				src, (uint64_t)part_len, ops->mb_mgr);
 		total_len = data_length - part_len;
 
 		while (total_len) {
@@ -406,7 +555,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 
 			ops->gmac_update(&session->gdata_key,
 					&qp_data->gcm_ctx_data, src,
-					(uint64_t)part_len);
+					(uint64_t)part_len, ops->mb_mgr);
 			total_len -= part_len;
 		}
 
@@ -416,13 +565,13 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 			tag = sym_op->auth.digest.data;
 
 		ops->gmac_finalize(&session->gdata_key, &qp_data->gcm_ctx_data,
-				tag, session->gen_digest_length);
+				tag, session->gen_digest_length, ops->mb_mgr);
 	} else { /* IPSEC_MB_OP_HASH_VERIFY_ONLY */
 		ops->gmac_init(&session->gdata_key, &qp_data->gcm_ctx_data,
-				iv_ptr, session->iv.length);
+				iv_ptr, session->iv.length, ops->mb_mgr);
 
 		ops->gmac_update(&session->gdata_key, &qp_data->gcm_ctx_data,
-				src, (uint64_t)part_len);
+				src, (uint64_t)part_len, ops->mb_mgr);
 		total_len = data_length - part_len;
 
 		while (total_len) {
@@ -436,14 +585,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rte_crypto_op *op,
 
 			ops->gmac_update(&session->gdata_key,
 					&qp_data->gcm_ctx_data, src,
-					(uint64_t)part_len);
+					(uint64_t)part_len, ops->mb_mgr);
 			total_len -= part_len;
 		}
 
 		tag = qp_data->temp_digest;
 
 		ops->gmac_finalize(&session->gdata_key, &qp_data->gcm_ctx_data,
-				tag, session->gen_digest_length);
+				tag, session->gen_digest_length, ops->mb_mgr);
 	}
 	return 0;
 }
@@ -540,11 +689,11 @@ aesni_gcm_sgl_op_finalize_encryption(const struct aesni_gcm_session *s,
 		uint8_t tmpdigest[s->gen_digest_length];
 
 		ops.finalize_enc(&s->gdata_key, gdata_ctx, tmpdigest,
-				s->gen_digest_length);
+				s->gen_digest_length, ops.mb_mgr);
 		memcpy(digest, tmpdigest, s->req_digest_length);
 	} else {
 		ops.finalize_enc(&s->gdata_key, gdata_ctx, digest,
-				s->gen_digest_length);
+				s->gen_digest_length, ops.mb_mgr);
 	}
 
 	return 0;
@@ -558,7 +707,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni_gcm_session *s,
 	uint8_t tmpdigest[s->gen_digest_length];
 
 	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
-			s->gen_digest_length);
+			s->gen_digest_length, ops.mb_mgr);
 
 	return rte_memeq_timingsafe(digest, tmpdigest, s->req_digest_length) ? 0 : EBADMSG;
 }
@@ -573,7 +722,7 @@ aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_session *s,
 
 	/* init crypto operation */
 	ops.init(&s->gdata_key, gdata_ctx, iv, aad,
-		    (uint64_t)s->aad_length);
+		    (uint64_t)s->aad_length, ops.mb_mgr);
 
 	/* update with sgl data */
 	for (i = 0; i < sgl->num; i++) {
@@ -582,11 +731,11 @@ aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_session *s,
 		switch (s->op) {
 		case IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT:
 			ops.update_enc(&s->gdata_key, gdata_ctx,
-			      vec->base, vec->base, vec->len);
+			      vec->base, vec->base, vec->len, ops.mb_mgr);
 			break;
 		case IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT:
 			ops.update_dec(&s->gdata_key, gdata_ctx,
-			      vec->base, vec->base, vec->len);
+			      vec->base, vec->base, vec->len, ops.mb_mgr);
 			break;
 		default:
 			IPSEC_MB_LOG(ERR, "Invalid session op");
@@ -603,7 +752,7 @@ aesni_gcm_process_gmac_sgl_op(const struct aesni_gcm_session *s,
 			      struct aesni_gcm_ops ops)
 {
 	ops.init(&s->gdata_key, gdata_ctx, iv, sgl->vec[0].base,
-		    sgl->vec[0].len);
+		    sgl->vec[0].len, ops.mb_mgr);
 }
 
 static inline uint32_t
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
index 8a5a41fb19..4074430d6e 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
@@ -79,41 +79,41 @@ enum aesni_gcm_key_length {
 
 typedef void (*aesni_gcm_t)(const struct gcm_key_data *gcm_key_data,
 			    struct gcm_context_data *gcm_ctx_data,
-			    uint8_t *out, const uint8_t *in,
-			    uint64_t plaintext_len, const uint8_t *iv,
-			    const uint8_t *aad, uint64_t aad_len,
-			    uint8_t *auth_tag, uint64_t auth_tag_len);
+			    void *out, const void *in,
+			    uint64_t plaintext_len, const void *iv,
+			    const void *aad, uint64_t aad_len,
+			    void *auth_tag, uint64_t auth_tag_len, IMB_MGR *state);
 
 typedef void (*aesni_gcm_pre_t)(const void *key,
-				struct gcm_key_data *gcm_data);
+				struct gcm_key_data *gcm_data, IMB_MGR *state);
 
 typedef void (*aesni_gcm_init_t)(const struct gcm_key_data *gcm_key_data,
 				 struct gcm_context_data *gcm_ctx_data,
-				 const uint8_t *iv, uint8_t const *aad,
-				 uint64_t aad_len);
+				 const void *iv, const void *aad,
+				 uint64_t aad_len, IMB_MGR *state);
 
 typedef void (*aesni_gcm_update_t)(const struct gcm_key_data *gcm_key_data,
 				   struct gcm_context_data *gcm_ctx_data,
-				   uint8_t *out, const uint8_t *in,
-				   uint64_t plaintext_len);
+				   void *out, const void *in,
+				   uint64_t plaintext_len, IMB_MGR *state);
 
 typedef void (*aesni_gcm_finalize_t)(const struct gcm_key_data *gcm_key_data,
 				     struct gcm_context_data *gcm_ctx_data,
-				     uint8_t *auth_tag, uint64_t auth_tag_len);
+				     void *auth_tag, uint64_t auth_tag_len, IMB_MGR *state);
 
 typedef void (*aesni_gmac_init_t)(const struct gcm_key_data *gcm_key_data,
 				  struct gcm_context_data *gcm_ctx_data,
-				  const uint8_t *iv, const uint64_t iv_len);
+				  const void *iv, const uint64_t iv_len, IMB_MGR *state);
 
 typedef void (*aesni_gmac_update_t)(const struct gcm_key_data *gcm_key_data,
 				    struct gcm_context_data *gcm_ctx_data,
-				    const uint8_t *in,
-				    const uint64_t plaintext_len);
+				    const void *in,
+				    const uint64_t plaintext_len, IMB_MGR *state);
 
 typedef void (*aesni_gmac_finalize_t)(const struct gcm_key_data *gcm_key_data,
 				      struct gcm_context_data *gcm_ctx_data,
-				      uint8_t *auth_tag,
-				      const uint64_t auth_tag_len);
+				      void *auth_tag,
+				      const uint64_t auth_tag_len, IMB_MGR *state);
 
 /** GCM operation handlers */
 struct aesni_gcm_ops {
@@ -128,6 +128,7 @@ struct aesni_gcm_ops {
 	aesni_gmac_init_t gmac_init;
 	aesni_gmac_update_t gmac_update;
 	aesni_gmac_finalize_t gmac_finalize;
+	IMB_MGR *mb_mgr;
 };
 
 RTE_DEFINE_PER_LCORE(struct aesni_gcm_ops, gcm_ops[GCM_NUM_KEY_TYPES]);
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 3069887788..f8ae3cd64a 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -163,20 +163,22 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 
 	if (xform->auth.algo == RTE_CRYPTO_AUTH_ZUC_EIA3) {
 		if (xform->auth.key.length == 16) {
-			sess->template_job.hash_alg = IMB_AUTH_ZUC_EIA3_BITLEN;
+			sess->template_job.hash_alg = IMB_AUTH_ZUC_EIA3;
 
 			if (sess->auth.req_digest_len != 4) {
 				IPSEC_MB_LOG(ERR, "Invalid digest size");
 				return -EINVAL;
 			}
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 		} else if (xform->auth.key.length == 32) {
-			sess->template_job.hash_alg = IMB_AUTH_ZUC256_EIA3_BITLEN;
+			sess->template_job.hash_alg = IMB_AUTH_ZUC256_EIA3;
 			if (sess->auth.req_digest_len != 4 &&
 					sess->auth.req_digest_len != 8 &&
 					sess->auth.req_digest_len != 16) {
 				IPSEC_MB_LOG(ERR, "Invalid digest size");
 				return -EINVAL;
 			}
+#endif
 		} else {
 			IPSEC_MB_LOG(ERR, "Invalid authentication key length");
 			return -EINVAL;
@@ -189,10 +191,10 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 		sess->template_job.u.ZUC_EIA3._key = sess->auth.zuc_auth_key;
 		return 0;
 	} else if (xform->auth.algo == RTE_CRYPTO_AUTH_SNOW3G_UIA2) {
-		sess->template_job.hash_alg = IMB_AUTH_SNOW3G_UIA2_BITLEN;
+		sess->template_job.hash_alg = IMB_AUTH_SNOW3G_UIA2;
 		uint16_t snow3g_uia2_digest_len =
 			get_truncated_digest_byte_length(
-						IMB_AUTH_SNOW3G_UIA2_BITLEN);
+						IMB_AUTH_SNOW3G_UIA2);
 		if (sess->auth.req_digest_len != snow3g_uia2_digest_len) {
 			IPSEC_MB_LOG(ERR, "Invalid digest size");
 			return -EINVAL;
@@ -381,7 +383,7 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 
 /** Set session cipher parameters */
 static int
-aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
+aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
 		struct aesni_mb_session *sess,
 		const struct rte_crypto_sym_xform *xform)
 {
@@ -451,11 +453,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 		is_zuc = 1;
 		break;
 	case RTE_CRYPTO_CIPHER_SNOW3G_UEA2:
-		sess->template_job.cipher_mode = IMB_CIPHER_SNOW3G_UEA2_BITLEN;
+		sess->template_job.cipher_mode = IMB_CIPHER_SNOW3G_UEA2;
 		is_snow3g = 1;
 		break;
 	case RTE_CRYPTO_CIPHER_KASUMI_F8:
-		sess->template_job.cipher_mode = IMB_CIPHER_KASUMI_UEA1_BITLEN;
+		sess->template_job.cipher_mode = IMB_CIPHER_KASUMI_UEA1;
 		is_kasumi = 1;
 		break;
 	case RTE_CRYPTO_CIPHER_NULL:
@@ -584,8 +586,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
 		sess->template_job.dec_keys = sess->cipher.exp_3des_keys.ks_ptr;
 		sess->template_job.key_len_in_bytes = 24;
 	} else if (is_zuc) {
-		if (xform->cipher.key.length != 16 &&
-				xform->cipher.key.length != 32) {
+		if (xform->cipher.key.length != 16
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+				&& xform->cipher.key.length != 32
+#endif
+			) {
 			IPSEC_MB_LOG(ERR, "Invalid cipher key length");
 			return -EINVAL;
 		}
@@ -1229,19 +1234,23 @@ sgl_linear_cipher_auth_len(IMB_JOB *job, uint64_t *auth_len)
 {
 	uint64_t cipher_len;
 
-	if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
-			job->cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN)
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+	if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
+			job->cipher_mode == IMB_CIPHER_KASUMI_UEA1)
 		cipher_len = (job->msg_len_to_cipher_in_bits >> 3) +
 				(job->cipher_start_src_offset_in_bits >> 3);
 	else
+#endif
 		cipher_len = job->msg_len_to_cipher_in_bytes +
 				job->cipher_start_src_offset_in_bytes;
 
-	if (job->hash_alg == IMB_AUTH_SNOW3G_UIA2_BITLEN ||
-			job->hash_alg == IMB_AUTH_ZUC_EIA3_BITLEN)
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+	if (job->hash_alg == IMB_AUTH_SNOW3G_UIA2 ||
+			job->hash_alg == IMB_AUTH_ZUC_EIA3)
 		*auth_len = (job->msg_len_to_hash_in_bits >> 3) +
 				job->hash_start_src_offset_in_bytes;
 	else
+#endif
 		*auth_len = job->msg_len_to_hash_in_bytes +
 				job->hash_start_src_offset_in_bytes;
 
@@ -1509,18 +1518,20 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_op *op, IMB_JOB *job,
 		return NULL;
 
 	if (job->cipher_mode == IMB_CIPHER_ZUC_EEA3 ||
-		job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
-		job->cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN) {
+		job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
+		job->cipher_mode == IMB_CIPHER_KASUMI_UEA1) {
 		cipher_size = (op->sym->cipher.data.offset >> 3) +
 			(op->sym->cipher.data.length >> 3);
 	} else {
 		cipher_size = (op->sym->cipher.data.offset) +
 			(op->sym->cipher.data.length);
 	}
-	if (job->hash_alg == IMB_AUTH_ZUC_EIA3_BITLEN ||
-		job->hash_alg == IMB_AUTH_SNOW3G_UIA2_BITLEN ||
-		job->hash_alg == IMB_AUTH_KASUMI_UIA1 ||
-		job->hash_alg == IMB_AUTH_ZUC256_EIA3_BITLEN) {
+	if (job->hash_alg == IMB_AUTH_ZUC_EIA3 ||
+		job->hash_alg == IMB_AUTH_SNOW3G_UIA2 ||
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+		job->hash_alg == IMB_AUTH_ZUC256_EIA3 ||
+#endif
+		job->hash_alg == IMB_AUTH_KASUMI_UIA1) {
 		auth_size = (op->sym->auth.data.offset >> 3) +
 			(op->sym->auth.data.length >> 3);
 	} else {
@@ -1637,12 +1648,14 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->u.GMAC._iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 						session->auth_iv.offset);
 		break;
-	case IMB_AUTH_ZUC_EIA3_BITLEN:
-	case IMB_AUTH_ZUC256_EIA3_BITLEN:
+	case IMB_AUTH_ZUC_EIA3:
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+	case IMB_AUTH_ZUC256_EIA3:
+#endif
 		job->u.ZUC_EIA3._iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 						session->auth_iv.offset);
 		break;
-	case IMB_AUTH_SNOW3G_UIA2_BITLEN:
+	case IMB_AUTH_SNOW3G_UIA2:
 		job->u.SNOW3G_UIA2._iv =
 			rte_crypto_op_ctod_offset(op, uint8_t *,
 						session->auth_iv.offset);
@@ -1670,12 +1683,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 	else
 		m_offset = op->sym->cipher.data.offset;
 
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 	if (cipher_mode == IMB_CIPHER_ZUC_EEA3)
 		m_offset >>= 3;
-	else if (cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN)
+	else if (cipher_mode == IMB_CIPHER_SNOW3G_UEA2)
 		m_offset = 0;
-	else if (cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN)
+	else if (cipher_mode == IMB_CIPHER_KASUMI_UEA1)
 		m_offset = 0;
+#else
+	if (cipher_mode == IMB_CIPHER_ZUC_EEA3 ||
+		cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
+		cipher_mode == IMB_CIPHER_KASUMI_UEA1)
+		m_offset >>= 3;
+#endif
 
 	/* Set digest output location */
 	if (job->hash_alg != IMB_AUTH_NULL &&
@@ -1755,9 +1775,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 				session->iv.offset);
 		break;
 	/* ZUC and SNOW3G require length in bits and offset in bytes */
-	case IMB_AUTH_ZUC_EIA3_BITLEN:
-	case IMB_AUTH_ZUC256_EIA3_BITLEN:
-	case IMB_AUTH_SNOW3G_UIA2_BITLEN:
+	case IMB_AUTH_ZUC_EIA3:
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+	case IMB_AUTH_ZUC256_EIA3:
+#endif
+	case IMB_AUTH_SNOW3G_UIA2:
 		auth_off_in_bytes = op->sym->auth.data.offset >> 3;
 		ciph_off_in_bytes = op->sym->cipher.data.offset >> 3;
 		auth_len_in_bytes = op->sym->auth.data.length >> 3;
@@ -1768,7 +1790,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 				session, oop, auth_off_in_bytes,
 				ciph_off_in_bytes, auth_len_in_bytes,
 				ciph_len_in_bytes, lb_sgl);
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 		job->msg_len_to_hash_in_bits = op->sym->auth.data.length;
+#else
+		job->msg_len_to_hash_in_bytes = op->sym->auth.data.length >> 3;
+#endif
 
 		job->iv = rte_crypto_op_ctod_offset(op, uint8_t *,
 			session->iv.offset);
@@ -1828,12 +1854,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 					op->sym->cipher.data.length >> 3;
 		break;
 	/* ZUC and SNOW3G require length and offset in bits */
-	case IMB_CIPHER_SNOW3G_UEA2_BITLEN:
-	case IMB_CIPHER_KASUMI_UEA1_BITLEN:
+	case IMB_CIPHER_SNOW3G_UEA2:
+	case IMB_CIPHER_KASUMI_UEA1:
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 		job->cipher_start_src_offset_in_bits =
 					op->sym->cipher.data.offset;
 		job->msg_len_to_cipher_in_bits =
 					op->sym->cipher.data.length;
+#else
+		job->cipher_start_src_offset_in_bytes =
+					op->sym->cipher.data.offset >> 3;
+		job->msg_len_to_cipher_in_bytes =
+					op->sym->cipher.data.length >> 3;
+#endif
 		break;
 	case IMB_CIPHER_GCM:
 		job->cipher_start_src_offset_in_bytes =
@@ -2106,8 +2139,8 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *job)
 				aesni_mb_digest_appended_in_src(op, job, oop) != NULL) {
 					unsigned int auth_size, cipher_size;
 					int unencrypted_bytes = 0;
-					if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
-						job->cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN ||
+					if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
+						job->cipher_mode == IMB_CIPHER_KASUMI_UEA1 ||
 						job->cipher_mode == IMB_CIPHER_ZUC_EEA3) {
 						cipher_size = (op->sym->cipher.data.offset >> 3) +
 							(op->sym->cipher.data.length >> 3);
@@ -2115,10 +2148,12 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *job)
 						cipher_size = (op->sym->cipher.data.offset) +
 							(op->sym->cipher.data.length);
 					}
-					if (job->hash_alg == IMB_AUTH_ZUC_EIA3_BITLEN ||
-						job->hash_alg == IMB_AUTH_SNOW3G_UIA2_BITLEN ||
-						job->hash_alg == IMB_AUTH_KASUMI_UIA1 ||
-						job->hash_alg == IMB_AUTH_ZUC256_EIA3_BITLEN) {
+					if (job->hash_alg == IMB_AUTH_ZUC_EIA3 ||
+						job->hash_alg == IMB_AUTH_SNOW3G_UIA2 ||
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+						job->hash_alg == IMB_AUTH_ZUC256_EIA3 ||
+#endif
+						job->hash_alg == IMB_AUTH_KASUMI_UIA1) {
 						auth_size = (op->sym->auth.data.offset >> 3) +
 							(op->sym->auth.data.length >> 3);
 					} else {
@@ -2609,7 +2644,9 @@ RTE_INIT(ipsec_mb_register_aesni_mb)
 			RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING |
 			RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT |
 			RTE_CRYPTODEV_FF_SYM_CPU_CRYPTO |
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 			RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA |
+#endif
 			RTE_CRYPTODEV_FF_SYM_SESSIONLESS |
 			RTE_CRYPTODEV_FF_IN_PLACE_SGL |
 			RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT |
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 74accab99a..6451d91edd 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -19,6 +19,15 @@
 
 #define MAX_NUM_SEGS 16
 
+/* bit len removed in 3.0 */
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+#define IMB_CIPHER_SNOW3G_UEA2 IMB_CIPHER_SNOW3G_UEA2_BITLEN
+#define IMB_CIPHER_KASUMI_UEA1 IMB_CIPHER_KASUMI_UEA1_BITLEN
+#define IMB_AUTH_ZUC_EIA3 IMB_AUTH_ZUC_EIA3_BITLEN
+#define IMB_AUTH_SNOW3G_UIA2 IMB_AUTH_SNOW3G_UIA2_BITLEN
+#define IMB_AUTH_ZUC256_EIA3 IMB_AUTH_ZUC256_EIA3_BITLEN
+#endif
+
 int
 aesni_mb_session_configure(IMB_MGR * m __rte_unused, void *priv_sess,
 		const struct rte_crypto_sym_xform *xform);
@@ -573,18 +582,34 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 				.block_size = 16,
 				.key_size = {
 					.min = 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 					.max = 32,
 					.increment = 16
+#else
+					.max = 16,
+					.increment = 0
+#endif
 				},
 				.digest_size = {
 					.min = 4,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 					.max = 16,
 					.increment = 4
 				},
+#else
+					.max = 4,
+					.increment = 0
+				},
+#endif
 				.iv_size = {
 					.min = 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 					.max = 25,
 					.increment = 9
+#else
+					.max = 16,
+					.increment = 0
+#endif
 				}
 			}, }
 		}, }
@@ -598,13 +623,23 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 				.block_size = 16,
 				.key_size = {
 					.min = 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 					.max = 32,
 					.increment = 16
+#else
+					.max = 16,
+					.increment = 0
+#endif
 				},
 				.iv_size = {
 					.min = 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
 					.max = 25,
 					.increment = 9
+#else
+					.max = 16,
+					.increment = 0
+#endif
 				},
 			}, }
 		}, }
@@ -1104,9 +1139,9 @@ static const unsigned int auth_blocksize[] = {
 		[IMB_AUTH_SHA_256]		= 64,
 		[IMB_AUTH_SHA_384]		= 128,
 		[IMB_AUTH_SHA_512]		= 128,
-		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 16,
-		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 16,
-		[IMB_AUTH_KASUMI_UIA1]		= 16,
+		[IMB_AUTH_ZUC_EIA3]		= 16,
+		[IMB_AUTH_SNOW3G_UIA2]	= 16,
+		[IMB_AUTH_KASUMI_UIA1]	= 16,
 #if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
 		[IMB_AUTH_SHA3_224]		= 144,
 		[IMB_AUTH_SHA3_256]		= 136,
@@ -1150,9 +1185,9 @@ static const unsigned int auth_truncated_digest_byte_lengths[] = {
 		[IMB_AUTH_SHA_256]		= 32,
 		[IMB_AUTH_SHA_384]		= 48,
 		[IMB_AUTH_SHA_512]		= 64,
-		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 4,
-		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 4,
-		[IMB_AUTH_KASUMI_UIA1]		= 4,
+		[IMB_AUTH_ZUC_EIA3]		= 4,
+		[IMB_AUTH_SNOW3G_UIA2]	= 4,
+		[IMB_AUTH_KASUMI_UIA1]	= 4,
 #if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
 		[IMB_AUTH_SHA3_224]		= 28,
 		[IMB_AUTH_SHA3_256]		= 32,
@@ -1197,9 +1232,9 @@ static const unsigned int auth_digest_byte_lengths[] = {
 		[IMB_AUTH_SHA_256]		= 32,
 		[IMB_AUTH_SHA_384]		= 48,
 		[IMB_AUTH_SHA_512]		= 64,
-		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 4,
-		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 4,
-		[IMB_AUTH_KASUMI_UIA1]		= 4,
+		[IMB_AUTH_ZUC_EIA3]		= 4,
+		[IMB_AUTH_SNOW3G_UIA2]	= 4,
+		[IMB_AUTH_KASUMI_UIA1]	= 4,
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 		[IMB_AUTH_SM3]			= 32,
 		[IMB_AUTH_HMAC_SM3]		= 32,
-- 
2.52.0

