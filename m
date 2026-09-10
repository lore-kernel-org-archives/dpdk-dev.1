Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C619FC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0CE3427E0;
	Thu, 10 Sep 2026 15:52:10 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0F0A7427C3
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:07 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF5A2200441;
 Thu, 10 Sep 2026 15:52:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B36DA200023;
 Thu, 10 Sep 2026 15:52:06 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 87391180006C;
 Thu, 10 Sep 2026 21:52:05 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Akhil Goyal <gakhil@marvell.com>,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 03/47] crypto/dpaa2_sec: support AES-GMAC
Date: Thu, 10 Sep 2026 19:21:14 +0530
Message-ID: <20260910135158.2181141-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Add AES-GMAC as a supported AEAD algorithm for IPsec protocol
offload. AES-GMAC provides NULL encryption with GMAC authentication
and maps to OP_PCL_IPSEC_AES_NULL_WITH_GMAC in the SEC protocol
control word.

When AES_GMAC is specified as an AUTH (non-AEAD) algorithm, return
-ENOTSUP with an informative message directing the user to the AEAD
path.

Add RTE_CRYPTO_AEAD_AES_GMAC to the AEAD algorithm enum and expose
the capability in dpaa2_sec_capabilities.

Signed-off-by: Akhil Goyal <gakhil@marvell.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst      |  6 ++++
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 14 ++++++++-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   | 33 ++++++++++++++++++++-
 lib/cryptodev/rte_crypto_sym.h              |  2 ++
 lib/cryptodev/rte_cryptodev.c               |  1 +
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..2eb5c4fe56 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added AES-GMAC AEAD algorithm.**
+
+  Added ``RTE_CRYPTO_AEAD_AES_GMAC`` to the AEAD algorithm enumeration, for
+  NULL encryption with GMAC authentication. The NXP dpaa2_sec PMD supports it
+  for IPsec protocol offload.
+
 
 Removed Items
 -------------
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index e710b4fbd3..16af02e758 100644
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
 
@@ -2978,6 +2978,13 @@ dpaa2_sec_ipsec_aead_init(struct rte_crypto_aead_xform *aead_xform,
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
@@ -3049,6 +3056,9 @@ dpaa2_sec_ipsec_proto_init(struct rte_crypto_cipher_xform *cipher_xform,
 		authdata->algtype = OP_PCL_IPSEC_HMAC_MD5_96;
 		authdata->algmode = OP_ALG_AAI_HMAC;
 		break;
+	case RTE_CRYPTO_AUTH_AES_GMAC:
+		DPAA2_SEC_ERR("AES_GMAC is supported as AEAD algo for IPSEC proto only");
+		return -ENOTSUP;
 	case RTE_CRYPTO_AUTH_SHA224_HMAC:
 		authdata->algmode = OP_ALG_AAI_HMAC;
 		if (session->digest_length == 6)
@@ -3220,6 +3230,7 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 		case OP_PCL_IPSEC_AES_GCM8:
 		case OP_PCL_IPSEC_AES_GCM12:
 		case OP_PCL_IPSEC_AES_GCM16:
+		case OP_PCL_IPSEC_AES_NULL_WITH_GMAC:
 			memcpy(encap_pdb.gcm.salt,
 				(uint8_t *)&(ipsec_xform->salt), 4);
 			break;
@@ -3360,6 +3371,7 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
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
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 829a5d0846..fa78cd1f1f 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -186,6 +186,7 @@ crypto_aead_algorithm_strings[] = {
 	[RTE_CRYPTO_AEAD_SNOW5G_NCA4] = "snow5g-nca4",
 	[RTE_CRYPTO_AEAD_AES_NCA5]    = "aes-nca5",
 	[RTE_CRYPTO_AEAD_ZUC_NCA6]    = "zuc-nca6",
+	[RTE_CRYPTO_AEAD_AES_GMAC]    = "aes-gmac",
 };
 
 
-- 
2.43.0

