Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5633F532CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 03:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D91440662;
	Tue, 24 Mar 2026 04:48:29 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2FADC4064E
 for <dev@dpdk.org>; Tue, 24 Mar 2026 04:48:28 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHXi8g2902868 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 ygI863/2KYuYRkPfQPmCE921MKLl1ttwM//+dWYqf0=; b=he2xDZ93gXRIgkMwq
 ldZDR+HSlRn9jQJs9dpYNQiXn7TsWKZ3TTuPZ493PkGVc7R8a7bXYyNTOzw5meqG
 0mjQejdgluvoA2y0a1A8eM47ML8Xr0NFrB2qRFo6n5ryJ757oNIK78RHdhzUsAay
 Qx1TauNsJR0bS6X/Nl3NYki5TFt3hqAohrsu++YHFDO3hjE9DD5+C1mFi+MWaUGh
 GbRYWiWnu3DYOD/MdPjgPB6TPYCUSO7AfHRG7F+UGKrTnPyOUYE8b+ESUgrIm9oF
 FqZXLIRMXDRUR1QOXvr5NNdDLfsrttu+89F/QwZqBRsiLo+wU+5kII3YURTZnupp
 kCDVw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d1tugn9en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:48:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Mar 2026 20:48:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Mar 2026 20:48:26 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.42])
 by maili.marvell.com (Postfix) with ESMTP id E0FCD5B6922;
 Mon, 23 Mar 2026 20:48:24 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>
Subject: [PATCH 2/2] crypto/cnxk: add SNOW5G and ZUC256 support
Date: Tue, 24 Mar 2026 09:18:19 +0530
Message-ID: <20260324034819.1010198-3-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324034819.1010198-1-nkaithakadan@marvell.com>
References: <20260324034819.1010198-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SM56OsyxWBYAiMTLgBNTk0OJ1fsA1weC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAyOSBTYWx0ZWRfXz4O/0xuC/8Rm
 QgE7WHbHydFSFRAKAqvF2LAlw80HNRovLoUEmVOnLOz6N3sfsIZkLB2VBC5xAw76NsYslHzyrHx
 /S2JrZYWR34y1oqwrn0oCvNfW0Cu3WbUv2/pNg58KnHWBCZzaBDQ3FoiXQqw1iv6KrlB9NM8dzm
 kTqLQrL+k5QjUzT7VAlKA6+J450xIcMRC3w0DZcvW3pEOruPto2+0Yg57TbhvbQXMsMe8E4H7Bc
 Foa2sShTy1gQDa7EUiN1VZRbGGCwXKKgfZNVXSTU/1Zii4COyjvAppqbcQxZlBpGhLwAbZrqKlK
 afYz+1b+BC+1iAzUy4jOYtaT+S4W6d5m6z5qIXqoLQEfaRNQNtN3nEJJ72XWLoRHnxw+m1C9TPi
 tAGroVlGE4OGPAnmGVIQbSA0yPHO5IlVhdyPYhFrmIF2xXyWOdLOTEUZjplVedHTVFF0sNOV4+g
 UUCvLGJaww9eOcUCu9Q==
X-Proofpoint-GUID: SM56OsyxWBYAiMTLgBNTk0OJ1fsA1weC
X-Authority-Analysis: v=2.4 cv=Pu6ergM3 c=1 sm=1 tr=0 ts=69c2098b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=yywjvD7a1IDtdU3aD58A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
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

As part of this patch:
- Implemented driver support in cnxk for SNOW5G NEA4/NIA4
  and ZUC NEA6/NIA6 algorithms.
- Added capability structures for ZUC256/SNOW5G algorithms.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/hw/cpt.h                  |   4 +-
 drivers/common/cnxk/roc_se.c                  |  40 ++++++-
 drivers/common/cnxk/roc_se.h                  |  16 ++-
 drivers/crypto/cnxk/cnxk_cryptodev.h          |   2 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c | 103 +++++++++++++++++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |   3 +
 drivers/crypto/cnxk/cnxk_se.h                 |  25 ++++-
 7 files changed, 177 insertions(+), 16 deletions(-)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index 6e577b6277..eb795f61ac 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -81,7 +81,9 @@ union cpt_eng_caps {
 		uint64_t __io reserved_15_20 : 6;
 		uint64_t __io sm3 : 1;
 		uint64_t __io sm4 : 1;
-		uint64_t __io reserved_23_34 : 12;
+		uint64_t __io reserved_23_24 : 2;
+		uint64_t __io zuc256_snow5g : 1;
+		uint64_t __io reserved_26_34 : 9;
 		uint64_t __io sg_ver2 : 1;
 		uint64_t __io sm2 : 1;
 		uint64_t __io pdcp_chain_zuc256 : 1;
diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
index bdb42567c7..d841a926a4 100644
--- a/drivers/common/cnxk/roc_se.c
+++ b/drivers/common/cnxk/roc_se.c
@@ -91,6 +91,7 @@ cpt_ciph_type_set(roc_se_cipher_type type, struct roc_se_ctx *ctx, uint16_t key_
 		fc_type = ROC_SE_FC_GEN;
 		break;
 	case ROC_SE_ZUC_EEA3:
+	case ROC_SE_ZUC_NEA6:
 		if (unlikely(key_len != 16)) {
 			/*
 			 * ZUC 256 is not supported with older microcode
@@ -115,6 +116,11 @@ cpt_ciph_type_set(roc_se_cipher_type type, struct roc_se_ctx *ctx, uint16_t key_
 		else
 			fc_type = ROC_SE_PDCP;
 		break;
+	case ROC_SE_SNOW5G_NEA4:
+		if (unlikely(key_len != 32))
+			return -1;
+		fc_type = ROC_SE_PDCP;
+		break;
 	case ROC_SE_AES_CTR_EEA2:
 		if (chained_op)
 			fc_type = ROC_SE_PDCP_CHAIN;
@@ -287,7 +293,7 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 
 	chained_op = se_ctx->ciph_then_auth || se_ctx->auth_then_ciph;
 
-	if ((type >= ROC_SE_ZUC_EIA3) && (type <= ROC_SE_KASUMI_F9_ECB)) {
+	if ((type >= ROC_SE_ZUC_EIA3) && (type <= ROC_SE_ZUC_NIA6)) {
 		uint32_t keyx[4];
 		int key_type;
 
@@ -316,7 +322,20 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 			se_ctx->zsk_flags = 0x1;
 			opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
 			break;
+		case ROC_SE_SNOW5G_NIA4:
+			pctx->w0.s.state_conf = ROC_SE_PDCP_CHAIN_CTX_KEY_IV;
+			pctx->w0.s.auth_type = ROC_SE_PDCP_CHAIN_ALG_TYPE_SNOW5G;
+			pctx->w0.s.mac_len = mac_len;
+			pctx->w0.s.auth_key_len = 3;
+			memcpy(pctx->st.auth_key, key, key_len);
+
+			se_ctx->fc_type = ROC_SE_PDCP;
+			se_ctx->pdcp_auth_alg = ROC_SE_PDCP_ALG_TYPE_SNOW5G;
+			se_ctx->zsk_flags = 0x1;
+			opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
+			break;
 		case ROC_SE_ZUC_EIA3:
+		case ROC_SE_ZUC_NIA6:
 			if (unlikely(key_len != 16)) {
 				/*
 				 * ZUC 256 is not supported with older microcode
@@ -336,13 +355,16 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 			pctx->w0.s.auth_type = ROC_SE_PDCP_CHAIN_ALG_TYPE_ZUC;
 			pctx->w0.s.mac_len = mac_len;
 			memcpy(pctx->st.auth_key, key, key_len);
-			if (key_len == 32)
+
+			if (!roc_model_is_cn20k() && key_len == 32)
 				roc_se_zuc_bytes_swap(pctx->st.auth_key, key_len);
+
 			cpt_zuc_const_update(pctx->st.auth_zuc_const, key_len, mac_len);
 			se_ctx->fc_type = ROC_SE_PDCP_CHAIN;
 
 			if (!chained_op)
 				se_ctx->fc_type = ROC_SE_PDCP;
+
 			se_ctx->pdcp_auth_alg = ROC_SE_PDCP_ALG_TYPE_ZUC;
 			se_ctx->zsk_flags = 0x1;
 			opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
@@ -547,7 +569,16 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 		se_ctx->pdcp_ci_alg = ROC_SE_PDCP_ALG_TYPE_SNOW3G;
 		se_ctx->zsk_flags = 0;
 		goto success;
+	case ROC_SE_SNOW5G_NEA4:
+		pctx->w0.s.state_conf = ROC_SE_PDCP_CHAIN_CTX_KEY_IV;
+		pctx->w0.s.cipher_type = ROC_SE_PDCP_CHAIN_ALG_TYPE_SNOW5G;
+		pctx->w0.s.ci_key_len = 3;
+		memcpy(pctx->st.ci_key, key, key_len);
+		se_ctx->pdcp_ci_alg = ROC_SE_PDCP_ALG_TYPE_SNOW5G;
+		se_ctx->zsk_flags = 0;
+		goto success;
 	case ROC_SE_ZUC_EEA3:
+	case ROC_SE_ZUC_NEA6:
 		key_type = cpt_pdcp_chain_key_type_get(key_len);
 		if (key_type < 0)
 			return key_type;
@@ -556,11 +587,12 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 		pctx->w0.s.cipher_type = ROC_SE_PDCP_CHAIN_ALG_TYPE_ZUC;
 		memcpy(pctx->st.ci_key, key, key_len);
 		if (key_len == 32) {
-			roc_se_zuc_bytes_swap(pctx->st.ci_key, key_len);
 			if (roc_model_is_cn20k())
 				memcpy(pctx->st.ci_zuc_const, zuc_key256_v2, 16);
-			else
+			else {
 				memcpy(pctx->st.ci_zuc_const, zuc_key256, 16);
+				roc_se_zuc_bytes_swap(pctx->st.ci_key, key_len);
+			}
 		} else
 			memcpy(pctx->st.ci_zuc_const, zuc_key128, 32);
 		se_ctx->pdcp_ci_alg = ROC_SE_PDCP_ALG_TYPE_ZUC;
diff --git a/drivers/common/cnxk/roc_se.h b/drivers/common/cnxk/roc_se.h
index 03a6eabfd3..499e71ce85 100644
--- a/drivers/common/cnxk/roc_se.h
+++ b/drivers/common/cnxk/roc_se.h
@@ -101,6 +101,8 @@ typedef enum {
 	ROC_SE_AES_CMAC_EIA2 = 0x92,
 	ROC_SE_KASUMI_F9_CBC = 0x93,
 	ROC_SE_KASUMI_F9_ECB = 0x94,
+	ROC_SE_SNOW5G_NIA4 = 0x95,
+	ROC_SE_ZUC_NIA6 = 0x96,
 } roc_se_auth_type;
 
 typedef enum {
@@ -129,6 +131,8 @@ typedef enum {
 	ROC_SE_KASUMI_F8_ECB = 0x94,
 	ROC_SE_AES_DOCSISBPI = 0x95,
 	ROC_SE_DES_DOCSISBPI = 0x96,
+	ROC_SE_SNOW5G_NEA4 = 0x97,
+	ROC_SE_ZUC_NEA6 = 0x98,
 } roc_se_cipher_type;
 
 typedef enum {
@@ -257,10 +261,8 @@ struct roc_se_pdcp_ctx {
 	union {
 		uint64_t u64;
 		struct {
-			uint64_t cipher_type : 2;
-			uint64_t rsvd58_59 : 2;
-			uint64_t auth_type : 2;
-			uint64_t rsvd62_63 : 2;
+			uint64_t cipher_type : 4;
+			uint64_t auth_type : 4;
 			uint64_t mac_len : 4;
 			uint64_t ci_key_len : 2;
 			uint64_t auth_key_len : 2;
@@ -307,8 +309,10 @@ struct roc_se_iov_ptr {
 #define ROC_SE_PDCP_ALG_TYPE_SNOW3G	  1
 #define ROC_SE_PDCP_ALG_TYPE_AES_CTR	  2
 #define ROC_SE_PDCP_ALG_TYPE_AES_CMAC	  3
+#define ROC_SE_PDCP_ALG_TYPE_SNOW5G	  4
 #define ROC_SE_PDCP_CHAIN_ALG_TYPE_SNOW3G 1
 #define ROC_SE_PDCP_CHAIN_ALG_TYPE_ZUC	  3
+#define ROC_SE_PDCP_CHAIN_ALG_TYPE_SNOW5G 5
 
 #define ROC_SE_PDCP_CHAIN_CTX_LFSR   0
 #define ROC_SE_PDCP_CHAIN_CTX_KEY_IV 1
@@ -348,8 +352,8 @@ struct roc_se_ctx {
 	uint64_t hmac : 1;
 	uint64_t zsk_flags : 3;
 	uint64_t k_ecb : 1;
-	uint64_t pdcp_ci_alg : 2;
-	uint64_t pdcp_auth_alg : 2;
+	uint64_t pdcp_ci_alg : 3;
+	uint64_t pdcp_auth_alg : 3;
 	uint64_t ciph_then_auth : 1;
 	uint64_t auth_then_ciph : 1;
 	uint64_t eia2 : 1;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.h b/drivers/crypto/cnxk/cnxk_cryptodev.h
index 088149badb..f88162ad3c 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.h
@@ -11,7 +11,7 @@
 #include "roc_ae.h"
 #include "roc_cpt.h"
 
-#define CNXK_CPT_MAX_CAPS		 56
+#define CNXK_CPT_MAX_CAPS		 60
 #define CNXK_SEC_IPSEC_CRYPTO_MAX_CAPS	 16
 #define CNXK_SEC_TLS_1_3_CRYPTO_MAX_CAPS 3
 #define CNXK_SEC_TLS_1_2_CRYPTO_MAX_CAPS 7
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index 5c1542909e..be6d383717 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -724,6 +724,99 @@ static const struct rte_cryptodev_capabilities caps_zuc_snow3g[] = {
 	},
 };
 
+static const struct rte_cryptodev_capabilities caps_zuc256_snow5g[] = {
+	{	/* SNOW 5G (NEA4) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_SNOW5G_NEA4,
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
+	{	/* SNOW 5G (NIA4) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SNOW5G_NIA4,
+				.block_size = 16,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
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
+	{	/* ZUC 256 (NEA6) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_ZUC_NEA6,
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
+	{	/* ZUC 256 (NIA6) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_ZUC_NIA6,
+				.block_size = 16,
+				.key_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 4,
+					.max = 16,
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
+};
+
 static const struct rte_cryptodev_capabilities caps_aes[] = {
 	{	/* AES GMAC (AUTH) */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
@@ -1917,7 +2010,8 @@ cn10k_20k_crypto_caps_update(struct rte_cryptodev_capabilities cnxk_caps[])
 	while ((caps = &cnxk_caps[i++])->op != RTE_CRYPTO_OP_TYPE_UNDEFINED) {
 		if ((caps->op == RTE_CRYPTO_OP_TYPE_SYMMETRIC) &&
 		    (caps->sym.xform_type == RTE_CRYPTO_SYM_XFORM_CIPHER) &&
-		    (caps->sym.cipher.algo == RTE_CRYPTO_CIPHER_ZUC_EEA3)) {
+		    ((caps->sym.cipher.algo == RTE_CRYPTO_CIPHER_ZUC_EEA3) ||
+		     (caps->sym.cipher.algo == RTE_CRYPTO_CIPHER_ZUC_NEA6))) {
 
 			caps->sym.cipher.key_size.max = 32;
 			caps->sym.cipher.key_size.increment = 16;
@@ -1930,8 +2024,8 @@ cn10k_20k_crypto_caps_update(struct rte_cryptodev_capabilities cnxk_caps[])
 
 		if ((caps->op == RTE_CRYPTO_OP_TYPE_SYMMETRIC) &&
 		    (caps->sym.xform_type == RTE_CRYPTO_SYM_XFORM_AUTH) &&
-		    (caps->sym.auth.algo == RTE_CRYPTO_AUTH_ZUC_EIA3)) {
-
+		    ((caps->sym.auth.algo == RTE_CRYPTO_AUTH_ZUC_EIA3) ||
+		     (caps->sym.auth.algo == RTE_CRYPTO_AUTH_ZUC_NIA6))) {
 			caps->sym.auth.key_size.max = 32;
 			caps->sym.auth.key_size.increment = 16;
 			caps->sym.auth.digest_size.max = 16;
@@ -1985,6 +2079,9 @@ crypto_caps_populate(struct rte_cryptodev_capabilities cnxk_caps[],
 	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		cn10k_20k_crypto_caps_add(cnxk_caps, hw_caps, &cur_pos);
 
+	if (roc_model_is_cn20k())
+		CPT_CAPS_ADD(cnxk_caps, &cur_pos, hw_caps, zuc256_snow5g);
+
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_null, RTE_DIM(caps_null));
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_end, RTE_DIM(caps_end));
 
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index b431b78005..2f9eb322dc 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -611,6 +611,7 @@ is_valid_pdcp_cipher_alg(struct rte_crypto_sym_xform *c_xfrm,
 {
 	switch (c_xfrm->cipher.algo) {
 	case RTE_CRYPTO_CIPHER_SNOW3G_UEA2:
+	case RTE_CRYPTO_CIPHER_SNOW5G_NEA4:
 	case RTE_CRYPTO_CIPHER_ZUC_EEA3:
 		break;
 	case RTE_CRYPTO_CIPHER_AES_CTR:
@@ -736,6 +737,7 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 				}
 				break;
 			case RTE_CRYPTO_AUTH_SNOW3G_UIA2:
+			case RTE_CRYPTO_AUTH_SNOW5G_NIA4:
 			case RTE_CRYPTO_AUTH_ZUC_EIA3:
 			case RTE_CRYPTO_AUTH_AES_CMAC:
 				if (!is_valid_pdcp_cipher_alg(c_xfrm, sess))
@@ -771,6 +773,7 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 			}
 			break;
 		case RTE_CRYPTO_AUTH_SNOW3G_UIA2:
+		case RTE_CRYPTO_AUTH_SNOW5G_NIA4:
 		case RTE_CRYPTO_AUTH_ZUC_EIA3:
 		case RTE_CRYPTO_AUTH_AES_CMAC:
 			if (!is_valid_pdcp_cipher_alg(c_xfrm, sess))
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index db25fd90d8..8dbf3e73c7 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -131,7 +131,8 @@ pdcp_iv_copy(uint8_t *iv_d, const uint8_t *iv_s, const uint8_t pdcp_alg_type, co
 			iv_temp[j] = iv_s_temp[3 - j];
 		memcpy(iv_d, iv_temp, 16);
 	} else if ((pdcp_alg_type == ROC_SE_PDCP_ALG_TYPE_ZUC) ||
-		   pdcp_alg_type == ROC_SE_PDCP_ALG_TYPE_AES_CTR) {
+		   (pdcp_alg_type == ROC_SE_PDCP_ALG_TYPE_AES_CTR) ||
+		   (pdcp_alg_type == ROC_SE_PDCP_ALG_TYPE_SNOW5G)) {
 		memcpy(iv_d, iv_s, 16);
 		if (pack_iv) {
 			uint8_t iv_d23, iv_d24;
@@ -2243,12 +2244,24 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		zsk_flag = ROC_SE_ZS_EA;
 		zs_cipher = ROC_SE_ZS_EA;
 		break;
+	case RTE_CRYPTO_CIPHER_SNOW5G_NEA4:
+		enc_type = ROC_SE_SNOW5G_NEA4;
+		cipher_key_len = 32;
+		zsk_flag = ROC_SE_ZS_EA;
+		zs_cipher = ROC_SE_ZS_EA;
+		break;
 	case RTE_CRYPTO_CIPHER_ZUC_EEA3:
 		enc_type = ROC_SE_ZUC_EEA3;
 		cipher_key_len = c_form->key.length;
 		zsk_flag = ROC_SE_ZS_EA;
 		zs_cipher = ROC_SE_ZS_EA;
 		break;
+	case RTE_CRYPTO_CIPHER_ZUC_NEA6:
+		enc_type = ROC_SE_ZUC_NEA6;
+		cipher_key_len = 32;
+		zsk_flag = ROC_SE_ZS_EA;
+		zs_cipher = ROC_SE_ZS_EA;
+		break;
 	case RTE_CRYPTO_CIPHER_AES_XTS:
 		enc_type = ROC_SE_AES_XTS;
 		cipher_key_len = 16;
@@ -2437,11 +2450,21 @@ fill_sess_auth(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		zsk_flag = ROC_SE_ZS_IA;
 		zs_auth = ROC_SE_ZS_IA;
 		break;
+	case RTE_CRYPTO_AUTH_SNOW5G_NIA4:
+		auth_type = ROC_SE_SNOW5G_NIA4;
+		zsk_flag = ROC_SE_ZS_IA;
+		zs_auth = ROC_SE_ZS_IA;
+		break;
 	case RTE_CRYPTO_AUTH_ZUC_EIA3:
 		auth_type = ROC_SE_ZUC_EIA3;
 		zsk_flag = ROC_SE_ZS_IA;
 		zs_auth = ROC_SE_ZS_IA;
 		break;
+	case RTE_CRYPTO_AUTH_ZUC_NIA6:
+		auth_type = ROC_SE_ZUC_NIA6;
+		zsk_flag = ROC_SE_ZS_IA;
+		zs_auth = ROC_SE_ZS_IA;
+		break;
 	case RTE_CRYPTO_AUTH_NULL:
 		auth_type = 0;
 		is_null = 1;
-- 
2.34.1

