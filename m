Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB4CDC19A
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 13:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74EE3402DC;
	Tue,  6 Jan 2026 14:09:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B5ABB400EF
 for <dev@dpdk.org>; Tue,  6 Jan 2026 14:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767704973; x=1799240973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=leFo8PUK6J0twX68DvtddVMQD4O9H88rdAc3n16E0eQ=;
 b=jLZIoDA49svRW4+Dk53yvsbvnutgsusT6z9Z+lR90w61HuWOUhILXU9M
 AUStCjNetqGB6/POHHDAUGGE1VUGnuNnZfsxGQUB1+1gDuuSO8PlV9HF5
 /3+cMKkgQKhuoCdkL6HU0uRel0jiu/MVwMfs4TicuUkpq/7bQQUaXeLvr
 iOn8q0xbB8IS2QsEXnMWI5vm/lQc6JYsI+DJ7SgptlsKpYRBie+vDTebI
 eoDoOvIsvtFVPW0VULCh4q5jhwygqdrDfHDRgYSBVf864y8DWX/Fc4wzS
 PJtFxmVKdyqKW5Gss8aM2705S2viAqqP27TEm+wafetCOEYvPQNUi0AcH g==;
X-CSE-ConnectionGUID: 0bINHwnvSj2X/glXWDsSMA==
X-CSE-MsgGUID: AO+FCkOlRoypbtlTzHvrpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79702591"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79702591"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 05:09:32 -0800
X-CSE-ConnectionGUID: Qt4m6PyrRJu4jMLwtM2BJQ==
X-CSE-MsgGUID: TybiDil5T0CAGjZbuHWYrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="240146356"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa001.jf.intel.com with ESMTP; 06 Jan 2026 05:09:31 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH] crypto/openssl: Add support for SHA3 algorithms
Date: Tue,  6 Jan 2026 13:09:26 +0000
Message-ID: <20260106130926.2267677-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
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

openssl 3.X supports SHA3. Hence adding SHA3-224, SHA3-256,
SHA3-384 and SHA3-512 support to the PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 drivers/crypto/openssl/rte_openssl_pmd.c     |  36 ++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 168 +++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..8817d7893c 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -92,6 +92,14 @@ digest_name_get(enum rte_crypto_auth_algorithm algo)
 		return OSSL_DIGEST_NAME_SHA2_384;
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
 		return OSSL_DIGEST_NAME_SHA2_512;
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_224;
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_256;
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_384;
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_512;
 	default:
 		return NULL;
 	}
@@ -270,6 +278,22 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
 		case RTE_CRYPTO_AUTH_SHA512_HMAC:
 			*algo = EVP_sha512();
 			break;
+		case RTE_CRYPTO_AUTH_SHA3_224:
+		case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+			*algo = EVP_sha3_224();
+			break;
+		case RTE_CRYPTO_AUTH_SHA3_256:
+		case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+			*algo = EVP_sha3_256();
+			break;
+		case RTE_CRYPTO_AUTH_SHA3_384:
+		case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+			*algo = EVP_sha3_384();
+			break;
+		case RTE_CRYPTO_AUTH_SHA3_512:
+		case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+			*algo = EVP_sha3_512();
+			break;
 		default:
 			res = -EINVAL;
 			break;
@@ -659,6 +683,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA512:
+	case RTE_CRYPTO_AUTH_SHA3_224:
+	case RTE_CRYPTO_AUTH_SHA3_256:
+	case RTE_CRYPTO_AUTH_SHA3_384:
+	case RTE_CRYPTO_AUTH_SHA3_512:
 		sess->auth.mode = OPENSSL_AUTH_AS_AUTH;
 		if (get_auth_algo(xform->auth.algo,
 				&sess->auth.auth.evp_algo) != 0)
@@ -714,6 +742,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 		sess->auth.mode = OPENSSL_AUTH_AS_HMAC;
 
 		algo = digest_name_get(xform->auth.algo);
@@ -744,6 +776,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 		sess->auth.mode = OPENSSL_AUTH_AS_HMAC;
 		sess->auth.hmac.ctx = HMAC_CTX_new();
 		if (get_auth_algo(xform->auth.algo,
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..8d6ae346a8 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,174 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* SHA3_224 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_224_HMAC,
+				.block_size = 144,
+				.key_size = {
+					.min = 1,
+					.max = 144,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 28,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_224 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_224,
+				.block_size = 144,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 28,
+					.max = 28,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_256 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_256_HMAC,
+				.block_size = 136,
+				.key_size = {
+					.min = 1,
+					.max = 136,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 32,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_256 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_256,
+				.block_size = 136,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_384 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_384_HMAC,
+				.block_size = 104,
+				.key_size = {
+					.min = 1,
+					.max = 104,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 48,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_384 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_384,
+				.block_size = 104,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 48,
+					.max = 48,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_512 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_512_HMAC,
+				.block_size = 72,
+				.key_size = {
+					.min = 1,
+					.max = 72,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 64,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_512 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_512,
+				.block_size = 72,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 64,
+					.max = 64,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
 	{	/* AES CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.43.0

