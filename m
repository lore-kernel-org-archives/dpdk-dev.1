Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD09C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BD1402C3;
	Mon,  6 Jul 2026 13:27:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 59BA54027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783337254; x=1814873254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C29Zu9VJUSiEL8Ih3RB1LXVgPkky2zV/I5Bb3UALgC0=;
 b=ldKUmBUJa1PLOrgCvG9JvokaSivqIKrzbDE8WN5E5MSoT15QNm5wN3SQ
 G/GW/N7vk2+I/xq2ucFYeVY3A0m/U262TdI0migrNBPxhBbKmEG61iIey
 7Ort9f5/+KGI6YopD2QhliUeRRy8a2IoT7a0yS67HLQeKPyiRGMq9oSXV
 HPC1qCJdRdBr0SUqzrieITot8uyRW4DV2DDeXDiJ17WfkuBQXGedTBQVZ
 chv45VjZuHfnMbzpxc3ekbwMKixkmLNX6l4zoMLHeRCOpD0+Z9TD4O/R7
 jwjDZNKSdNtDUDM4L3tkMSM1OVWDB6zHcnpXp2NyxusDFdv9A+5W+7ETy w==;
X-CSE-ConnectionGUID: gMNVtyIoS/iOZWPkodmWBg==
X-CSE-MsgGUID: Gy53C9iNTL2zVIllIXxlVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95123784"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="95123784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 04:27:33 -0700
X-CSE-ConnectionGUID: DW/31oHpRxOp5p1g8qQAGA==
X-CSE-MsgGUID: kOJVHYkDSyK8/M63D+6BLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="251011197"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa008.fm.intel.com with ESMTP; 06 Jul 2026 04:27:32 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>,
	Emma Finn <emma.finn@intel.com>
Cc: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [v2] crypto/qat: fix IPsec MB header include for ARM
Date: Mon,  6 Jul 2026 11:27:27 +0000
Message-ID: <20260706112727.2746447-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630100105.2330637-1-emma.finn@intel.com>
References: <20260630100105.2330637-1-emma.finn@intel.com>
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

Update the header file to always include the platform-specific
IPsec MB header. Additionally, guard DOCSIS BPI-related fields
that depend on IPsec MB so they are not included for ARM build.

Fixes: 03c475d609eb ("crypto/qat: require IPsec MB for HMAC precomputes")

Reported-by: Thomas Monjalon <thomas@monjalon.net>
Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* Add guards around DOCSIS BPI
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 2 ++
 drivers/crypto/qat/qat_sym.h                 | 6 +++++-
 drivers/crypto/qat/qat_sym_session.c         | 8 +++++++-
 drivers/crypto/qat/qat_sym_session.h         | 6 +++---
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 22ee0fe4fe..40d5594453 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -99,9 +99,11 @@ qat_bpicipher_preprocess(struct qat_sym_session *ctx,
 		op_bpi_cipher_decrypt(last_block, dst, iv, block_len,
 				last_block_len, ctx->bpi_ctx);
 #else
+#ifndef RTE_ARCH_ARM
 		bpi_cipher_ipsec(last_block, dst, iv, last_block_len, ctx->expkey,
 			ctx->mb_mgr, ctx->docsis_key_len);
 #endif
+#endif
 #if RTE_LOG_DP_LEVEL >= RTE_LOG_DEBUG
 		QAT_DP_HEXDUMP_LOG(DEBUG, "BPI: src after pre-process:",
 			last_block, last_block_len);
diff --git a/drivers/crypto/qat/qat_sym.h b/drivers/crypto/qat/qat_sym.h
index 849e047615..c4e9d16828 100644
--- a/drivers/crypto/qat/qat_sym.h
+++ b/drivers/crypto/qat/qat_sym.h
@@ -175,6 +175,7 @@ bpi_cipher_encrypt(uint8_t *src, uint8_t *dst,
 	return -EINVAL;
 }
 #else
+#ifndef RTE_ARCH_ARM
 static __rte_always_inline void
 bpi_cipher_ipsec(uint8_t *src, uint8_t *dst, uint8_t *iv, int srclen,
 		uint64_t *expkey, IMB_MGR *m, uint8_t docsis_key_len)
@@ -186,7 +187,8 @@ bpi_cipher_ipsec(uint8_t *src, uint8_t *dst, uint8_t *iv, int srclen,
 	else if (docsis_key_len == ICP_QAT_HW_DES_KEY_SZ)
 		des_cfb_one(dst, src, (uint64_t *)iv, expkey, srclen);
 }
-#endif
+#endif /* RTE_ARCH_ARM */
+#endif /* RTE_QAT_OPENSSL */
 
 static inline uint32_t
 qat_bpicipher_postprocess(struct qat_sym_session *ctx,
@@ -237,9 +239,11 @@ qat_bpicipher_postprocess(struct qat_sym_session *ctx,
 		bpi_cipher_encrypt(last_block, dst, iv, block_len,
 				last_block_len, ctx->bpi_ctx);
 #else
+#ifndef RTE_ARCH_ARM
 		bpi_cipher_ipsec(last_block, dst, iv, last_block_len, ctx->expkey,
 			ctx->mb_mgr, ctx->docsis_key_len);
 #endif
+#endif
 #if RTE_LOG_DP_LEVEL >= RTE_LOG_DEBUG
 		QAT_DP_HEXDUMP_LOG(DEBUG, "BPI: src after post-process:",
 				last_block, last_block_len);
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 486eb5b54a..6dce9ca786 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -204,6 +204,7 @@ bpi_cipher_ctx_init(enum rte_crypto_cipher_algorithm cryptodev_algo,
 #endif
 
 #ifndef RTE_QAT_OPENSSL
+#ifndef RTE_ARCH_ARM
 /** Creates a context in either AES or DES in ECB mode
  */
 static int
@@ -245,7 +246,8 @@ ipsec_mb_ctx_init(const uint8_t *key, uint16_t key_length,
 	}
 	return ret;
 }
-#endif
+#endif /* RTE_ARCH_ARM */
+#endif /* RTE_QAT_OPENSSL */
 
 static int
 qat_is_cipher_alg_supported(enum rte_crypto_cipher_algorithm algo,
@@ -477,6 +479,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 					cipher_xform->key.length,
 					&session->bpi_ctx);
 #else
+#ifndef RTE_ARCH_ARM
 		session->docsis_key_len = cipher_xform->key.length;
 		ret = ipsec_mb_ctx_init(
 					cipher_xform->key.data,
@@ -485,6 +488,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 					session->expkey,
 					session->dust,
 					&session->mb_mgr);
+#endif
 #endif
 		if (ret != 0) {
 			QAT_LOG(ERR, "failed to create DES BPI ctx");
@@ -507,6 +511,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 					cipher_xform->key.length,
 					&session->bpi_ctx);
 #else
+#ifndef RTE_ARCH_ARM
 		session->docsis_key_len = cipher_xform->key.length;
 		ret = ipsec_mb_ctx_init(
 					cipher_xform->key.data,
@@ -515,6 +520,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 					session->expkey,
 					session->dust,
 					&session->mb_mgr);
+#endif
 #endif
 		if (ret != 0) {
 			QAT_LOG(ERR, "failed to create AES BPI ctx");
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_sym_session.h
index 0c7b9cc6cf..b18673a1f7 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -14,11 +14,11 @@
 #include "icp_qat_fw.h"
 #include "icp_qat_fw_la.h"
 
-#ifndef RTE_QAT_OPENSSL
-#ifndef RTE_ARCH_ARM
+#ifdef RTE_ARCH_ARM
+#include <ipsec-mb.h>
+#else
 #include <intel-ipsec-mb.h>
 #endif
-#endif
 
 /*
  * Key Modifier (KM) value used in KASUMI algorithm in F9 mode to XOR
-- 
2.43.0

