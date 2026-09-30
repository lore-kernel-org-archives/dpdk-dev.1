Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02ECA5FBB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 07:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A24442D7D;
	Wed, 30 Sep 2026 09:08:21 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id CB0AC40DD6
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:08:15 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A97FE1A01D8;
 Wed, 30 Sep 2026 09:08:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 735E91A01D5;
 Wed, 30 Sep 2026 09:08:15 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EAA2D18000BF;
 Wed, 30 Sep 2026 15:08:14 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 6/6] crypto/dpaa2_sec: support AES-GMAC
Date: Wed, 30 Sep 2026 12:38:09 +0530
Message-Id: <20260930070809.1929564-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930070809.1929564-1-g.singh@nxp.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
 <20260930070809.1929564-1-g.singh@nxp.com>
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

Add AES-GMAC (RTE_CRYPTO_AUTH_AES_GMAC) support to the dpaa2_sec driver
for both symmetric auth-only and IPsec lookaside protocol paths.

For the auth-only path, AES-GMAC uses the GCM shared descriptor
(cnstr_shdsc_gcm_encap/decap) with per-packet IV and data supplied
via sym_op->auth.{iv,data,digest}.

For the IPsec lookaside protocol path, AES-GMAC maps to
OP_PCL_IPSEC_AES_NULL_WITH_GMAC.  The SEC hardware protocol word
treats this as a cipher type, so the GMAC key and algtype are placed
in cipherdata rather than authdata.  This is handled in
dpaa2_sec_ipsec_proto_init() by overriding cipherdata with the auth
key and setting authdata algtype to HMAC_NULL.

Also add AES-GMAC to dpaa2_sec_capabilities[] as an AUTH xform.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/cryptodevs/dpaa2_sec.rst          |  1 +
 doc/guides/cryptodevs/features/dpaa2_sec.ini |  3 ++
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c  | 43 +++++++++++++++++++-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    | 28 ++++++++++++-
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst b/doc/guides/cryptodevs/dpaa2_sec.rst
index 925d3371bf..d9a661c272 100644
--- a/doc/guides/cryptodevs/dpaa2_sec.rst
+++ b/doc/guides/cryptodevs/dpaa2_sec.rst
@@ -125,6 +125,7 @@ Hash algorithms:
 * ``RTE_CRYPTO_AUTH_MD5_HMAC``
 * ``RTE_CRYPTO_AUTH_AES_XCBC_MAC``
 * ``RTE_CRYPTO_AUTH_AES_CMAC``
+* ``RTE_CRYPTO_AUTH_AES_GMAC``
 
 AEAD algorithms:
 
diff --git a/doc/guides/cryptodevs/features/dpaa2_sec.ini b/doc/guides/cryptodevs/features/dpaa2_sec.ini
index a280c7b51b..49434739f0 100644
--- a/doc/guides/cryptodevs/features/dpaa2_sec.ini
+++ b/doc/guides/cryptodevs/features/dpaa2_sec.ini
@@ -48,6 +48,9 @@ SHA384 HMAC  = Y
 SHA512       = Y
 SHA512 HMAC  = Y
 SNOW3G UIA2  = Y
+AES GMAC (128) = Y
+AES GMAC (192) = Y
+AES GMAC (256) = Y
 AES XCBC MAC = Y
 ZUC EIA3     = Y
 AES CMAC (128) = Y
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 0ff54fb644..8e271a3b50 100644
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
 
@@ -2483,6 +2483,30 @@ dpaa2_sec_auth_init(struct rte_crypto_sym_xform *xform,
 					   !session->dir,
 					   session->digest_length);
 		break;
+	case RTE_CRYPTO_AUTH_AES_GMAC:
+		/* AES-GMAC is an authentication-only operation using the
+		 * GCM algorithm with a zero-length payload.  The IV is
+		 * passed per-packet via the auth xform iv field, and the
+		 * data to authenticate is in sym_op->auth.data.
+		 */
+		session->iv.offset = xform->auth.iv.offset;
+		session->iv.length = xform->auth.iv.length;
+		session->auth_alg = RTE_CRYPTO_AUTH_AES_GMAC;
+		authdata.algtype = OP_ALG_ALGSEL_AES;
+		authdata.algmode = OP_ALG_AAI_GCM;
+		if (session->dir == DIR_ENC)
+			bufsize = cnstr_shdsc_gcm_encap(
+					priv->flc_desc[DESC_INITFINAL].desc,
+					1, 0, SHR_NEVER, &authdata,
+					session->iv.length,
+					session->digest_length);
+		else
+			bufsize = cnstr_shdsc_gcm_decap(
+					priv->flc_desc[DESC_INITFINAL].desc,
+					1, 0, SHR_NEVER, &authdata,
+					session->iv.length,
+					session->digest_length);
+		break;
 	default:
 		DPAA2_SEC_ERR("Crypto: Unsupported Auth alg %s (%u)",
 			rte_cryptodev_get_auth_algo_string(xform->auth.algo),
@@ -3046,6 +3070,18 @@ dpaa2_sec_ipsec_proto_init(struct rte_crypto_cipher_xform *cipher_xform,
 		authdata->algtype = OP_PCL_IPSEC_HMAC_MD5_96;
 		authdata->algmode = OP_ALG_AAI_HMAC;
 		break;
+	case RTE_CRYPTO_AUTH_AES_GMAC:
+		/* AES-GMAC uses OP_PCL_IPSEC_AES_NULL_WITH_GMAC which is
+		 * treated as a cipher type in the SEC protocol word.
+		 * Place the GMAC key in cipherdata and set authdata to NULL.
+		 */
+		cipherdata->key = (size_t)session->auth_key.data;
+		cipherdata->keylen = session->auth_key.length;
+		cipherdata->key_enc_flags = 0;
+		cipherdata->key_type = RTA_DATA_IMM;
+		cipherdata->algtype = OP_PCL_IPSEC_AES_NULL_WITH_GMAC;
+		authdata->algtype = OP_PCL_IPSEC_HMAC_NULL;
+		return 0;
 	case RTE_CRYPTO_AUTH_SHA224_HMAC:
 		authdata->algmode = OP_ALG_AAI_HMAC;
 		if (session->digest_length == 6)
@@ -3142,6 +3178,9 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 
 	PMD_INIT_FUNC_TRACE();
 
+	memset(&authdata, 0, sizeof(authdata));
+	memset(&cipherdata, 0, sizeof(cipherdata));
+
 	RTE_SET_USED(dev);
 
 	/** Make FLC address to align with stashing, low 6 bits are used
@@ -3217,6 +3256,7 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 		case OP_PCL_IPSEC_AES_GCM8:
 		case OP_PCL_IPSEC_AES_GCM12:
 		case OP_PCL_IPSEC_AES_GCM16:
+		case OP_PCL_IPSEC_AES_NULL_WITH_GMAC:
 			memcpy(encap_pdb.gcm.salt,
 				(uint8_t *)&(ipsec_xform->salt), 4);
 			break;
@@ -3357,6 +3397,7 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 		case OP_PCL_IPSEC_AES_GCM8:
 		case OP_PCL_IPSEC_AES_GCM12:
 		case OP_PCL_IPSEC_AES_GCM16:
+		case OP_PCL_IPSEC_AES_NULL_WITH_GMAC:
 			memcpy(decap_pdb.gcm.salt,
 				(uint8_t *)&(ipsec_xform->salt), 4);
 			break;
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index 94ba321c72..913c91ebc2 100644
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
 
@@ -528,6 +528,32 @@ static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* AES GMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_AES_GMAC,
+				.block_size = 16,
+				.key_size = {
+					.min = 16,
+					.max = 32,
+					.increment = 8
+				},
+				.digest_size = {
+					.min = 8,
+					.max = 16,
+					.increment = 4
+				},
+				.aad_size = { 0 },
+				.iv_size = {
+					.min = 12,
+					.max = 12,
+					.increment = 0
+				},
+			}, }
+		}, }
+	},
 	{	/* AES XCBC HMAC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.25.1

