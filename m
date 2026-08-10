Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB0BC5AC82
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:30:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C0CB40E50;
	Mon, 10 Aug 2026 13:29:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6DE4140DD6
 for <dev@dpdk.org>; Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BEBD1A001B;
 Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14DA71A0027;
 Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BEBC1800088;
 Mon, 10 Aug 2026 19:29:53 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 3/6] crypto/dpaa2_sec: support AES-GMAC
Date: Mon, 10 Aug 2026 16:59:48 +0530
Message-Id: <20260810112951.2879825-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260810112951.2879825-1-g.singh@nxp.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add AES-GMAC as a supported AEAD algorithm for IPsec protocol
offload. AES-GMAC provides NULL encryption with GMAC authentication
and maps to OP_PCL_IPSEC_AES_NULL_WITH_GMAC in the SEC protocol
control word.

When AES_GMAC is specified as an AUTH (non-AEAD) algorithm, return
-ENOTSUP with an informative message directing the user to the AEAD
path.

Add RTE_CRYPTO_AEAD_AES_GMAC to the AEAD algorithm enum and expose
the capability in dpaa2_sec_capabilities.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 15 +++++++++-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   | 33 ++++++++++++++++++++-
 lib/cryptodev/rte_crypto_sym.h              |  2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 15152cc5a1..0e4e67aa07 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2025 NXP
+ *   Copyright 2016-2026 NXP
  *
  */
 
@@ -2975,6 +2975,13 @@ dpaa2_sec_ipsec_aead_init(struct rte_crypto_aead_xform *aead_xform,
 		aeaddata->algmode = OP_ALG_AAI_CCM;
 		session->aead_alg = RTE_CRYPTO_AEAD_AES_CCM;
 		break;
+	case RTE_CRYPTO_AEAD_AES_GMAC:
+		/**
+		 * AES-GMAC is an AEAD algo with NULL encryption and GMAC
+		 * authentication.
+		 */
+		aeaddata->algtype = OP_PCL_IPSEC_AES_NULL_WITH_GMAC;
+		break;
 	default:
 		DPAA2_SEC_ERR("Crypto: Undefined AEAD specified %u",
 			      aead_xform->algo);
@@ -3046,6 +3053,10 @@ dpaa2_sec_ipsec_proto_init(struct rte_crypto_cipher_xform *cipher_xform,
 		authdata->algtype = OP_PCL_IPSEC_HMAC_MD5_96;
 		authdata->algmode = OP_ALG_AAI_HMAC;
 		break;
+	case RTE_CRYPTO_AUTH_AES_GMAC:
+		DPAA2_SEC_ERR(
+			"AES_GMAC is supported as AEAD algo for IPSEC proto only");
+		return -ENOTSUP;
 	case RTE_CRYPTO_AUTH_SHA224_HMAC:
 		authdata->algmode = OP_ALG_AAI_HMAC;
 		if (session->digest_length == 6)
@@ -3217,6 +3228,7 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 		case OP_PCL_IPSEC_AES_GCM8:
 		case OP_PCL_IPSEC_AES_GCM12:
 		case OP_PCL_IPSEC_AES_GCM16:
+		case OP_PCL_IPSEC_AES_NULL_WITH_GMAC:
 			memcpy(encap_pdb.gcm.salt,
 				(uint8_t *)&(ipsec_xform->salt), 4);
 			break;
@@ -3357,6 +3369,7 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 		case OP_PCL_IPSEC_AES_GCM8:
 		case OP_PCL_IPSEC_AES_GCM12:
 		case OP_PCL_IPSEC_AES_GCM16:
+		case OP_PCL_IPSEC_AES_NULL_WITH_GMAC:
 			memcpy(decap_pdb.gcm.salt,
 				(uint8_t *)&(ipsec_xform->salt), 4);
 			break;
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index ff32f3d860..1824cc4a60 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2020-2024 NXP
+ *   Copyright 2016,2020-2026 NXP
  *
  */
 
@@ -762,6 +762,37 @@ static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* AES GMAC (AEAD) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
+			{.aead = {
+				.algo = RTE_CRYPTO_AEAD_AES_GMAC,
+				.block_size = 16,
+				.key_size = {
+					.min = 16,
+					.max = 32,
+					.increment = 8
+				},
+				.digest_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				},
+				.aad_size = {
+					.min = 0,
+					.max = 65535,
+					.increment = 1
+				},
+				.iv_size = {
+					.min = 12,
+					.max = 16,
+					.increment = 4
+				}
+			}, }
+		}, }
+	},
+
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.h
index 630fd153bd..f65db616a0 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -508,6 +508,8 @@ enum rte_crypto_aead_algorithm {
 	/**< AES algorithm in NCA5 mode */
 	RTE_CRYPTO_AEAD_ZUC_NCA6,
 	/**< ZUC-256 algorithm in NCA6 mode */
+	RTE_CRYPTO_AEAD_AES_GMAC,
+	/**< AES algorithm in GMAC mode. */
 };
 
 /** Symmetric AEAD Operations */
-- 
2.25.1

