Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27814C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:58:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA6E0410FC;
	Wed, 21 May 2025 08:57:34 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
 by mails.dpdk.org (Postfix) with ESMTP id 368CE40EE2
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhxtdR9ckeEr0Y8YFapagWMh//SS7VvNah1Xv/e6n8L+fY3LTTk94hyIlYwXZYsml6XstoY0qoO+mNRsCfTb8LBBBESSfuAqc8w6bGBcQYndb9LA+OvgCvXjWL9NDy9SXbhh0YXt5PJYsHfAqHjIIgYl/6IOY2oriB5i5QFZcWtdihgccNj4uiJyZ7YNAfaaw6Lgxs9xF9Ce6Map6tZEh0U+lLo6trH53AYB3RijmVvNZtPqfBmI7i55qzu5LK1Y/cRrV0ioLTTEw5stT6ggEQB4SBYY66YS/HqjfpUUAql8aPAUA2lpIiBGLFOYiZz9UCwc3UDzyw9MEy8AfDdoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRfuBhJSPPZ+PiHFqL2A6QrdiujPl1WlW1gPo2qgSdk=;
 b=kJ89E/ciEcoMgVFwgD+Pqq2LzfXkrYEyNpkp1Rku1RinweUes77hYaAPmmR+Fm0YdaCl+DSvukI1xVITQE4Z7NdLhKL7lpyOQecdmhj/yD7+nTwFoV6h5eEaPB1hT5eFBjkNuJOPiqvDijtFce6Ul+KR647OoUk0O9YuUtyskJ8sBMW55FM4tEjpPSg+tyBQ6WkMWEXxpnXV60Tk//ekIW6N8JLBpOo8Cn6IJbLrnNX9fMgrt+0lz5lrG7GlIuttD+B08OqAJjSPcotvOZJX8DP6TJdfLt3WgGnBZK3p9A/IWlcFbk5olBgLV7vWTrwM/aZWySPp2ZjFxToensRVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRfuBhJSPPZ+PiHFqL2A6QrdiujPl1WlW1gPo2qgSdk=;
 b=PurFaXul5/pJISTEx8SXiZ10Zm1E2fDFcdl/G9gcmvHl7t8JJDB2NVsaN1JpF7VSYFVFNDna96wG6BH14swMt0bj6iG10koQbWlyyfz2PFt5q82qtERG1oe5IbnjboMa/GoPtOVodsiHj17dgfjFX0FoGHS1CRUNFtdkAGw1bI+ZOyBisFiqsjMWV2LmLj+fL3T4GP1PNeWlO6t0gKTIecx/7UeyMlzsnd2jHdCR3m+m23XgQq5Z2PgLPfTV0vRaHVDwrZUJpxbYrTk07RNtLPRDeFyf6QZwPmzyI3wh+dNtnNVqn6jy+UBRMOqVy3gDneDGgYRMFXrz0zkJJYiyIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:29 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:29 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 6/9] crypto/dpaa2_sec: add null algo capability
Date: Wed, 21 May 2025 12:26:55 +0530
Message-Id: <20250521065658.857707-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c65c308-870f-45ad-522f-08dd9834c072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6BzLVDxXpdx9NcrUZcOUG9XYaiH9BTry/bJfCzqLSn5waLHlCkVJCdXKqU8p?=
 =?us-ascii?Q?LKsYNTYmoGcHZZyfiOD7xHAxG3+OVkI/tTzJ8Fzd4hwsFiW1T85nKeiz3aya?=
 =?us-ascii?Q?Qn26sgZe1vavqngHs4WJQRvQm+JPHnF8DkZc5+dUr5WniyftKEGKG9HoWSAD?=
 =?us-ascii?Q?otoC9CZSruBLADCVV5aEmhyVNUAIP2w5YrcJIqColaGg8N5oxpNKOfzMtA1L?=
 =?us-ascii?Q?O4FopFTuklqfRy6fbdO7cl5OiOYmPp0MtUHIydh8+TSI2xyQFSbDwu6Beryv?=
 =?us-ascii?Q?HDPEE4SLsVxB1qP61lHpLFRnAYs2oJHr2ZaKLTdIF7MYtpClnSskjHeaybOB?=
 =?us-ascii?Q?DaE6E+pYy1Fh4dxbmlb8PcqZiKwelWoRT54MItEHaBhaENF14oOhiLOTqGVv?=
 =?us-ascii?Q?kH9uoiX8jUCY3/gAS0irkf1p1IMaUzRiEzWIwI2sb9X7zmpuKdL8wfTHlcoT?=
 =?us-ascii?Q?KoOeHyqg3f+7dP1W2+9sgr0lxQAeBzT6AfAetbhiCKx/SQ/uPtoroRbFFJZa?=
 =?us-ascii?Q?OoRGm0sO7acj530Eb2ymukxil92G/5vBJ8lPhM5QRXAkfEt5UFC7zdL8uttm?=
 =?us-ascii?Q?1gZwnqzybudqzNTp4jcg8saN3SSj1AWOnMQ+ZlzFmGtYJA/FcHVruikJkO1W?=
 =?us-ascii?Q?3ZpudrbgQBdXaDxx20e+pjgNA5IwEo6B/A5S+ZsRe/dIUIv8iSA7HCGIboYh?=
 =?us-ascii?Q?UZnQn1vU7LcBVRN8Xp9TRksf0e8oaK+BjuPsTvu1qOgI5mCZdj8FC5okinnk?=
 =?us-ascii?Q?GfJvtZIENEly/ourrTxGcNw4PtSXIIl803WMhnNlQZ81+KPOnnkUz8np6xTD?=
 =?us-ascii?Q?Y7KPpytOPgBGlr7iogM1EY/lN+UDKRllZL1fy5icZoW21EdQPR7nr3DtbGJU?=
 =?us-ascii?Q?8LhWsNY2tIck/082v4i4VHjQcfdSMhqZ8wGhNMbhmp8c0WMhZzFEBPKQmm2L?=
 =?us-ascii?Q?p5tvPk47C2ttM0uaUgxHu+1aSrhJ9GG02OphTM9l37q9VuXnfLU5xtWVhFK6?=
 =?us-ascii?Q?YuFBNmxLV1lcqkRUHOzsKFiyTfYvxH5Qh6FwgJzSp71YkkP9hXnmf0UQZreD?=
 =?us-ascii?Q?yjM/GStG42Khdciu25jyL/FpJeEyaph2me9KNKV+4qVOSKwX97bclpWEziWY?=
 =?us-ascii?Q?NhN7xIp+W601sbjgOidtgsb0Erh6eBMXuSWP7DWBhRZPa6a/uyO2CvOjCC6N?=
 =?us-ascii?Q?TGusPrcioZ7QMscRc/UaN+RNC8DfiLif/sRYwUMarnp8gsrC7mrPvmtRUxg6?=
 =?us-ascii?Q?rwhjciuojECmq6Ifv1kX9U3U+XNuj2ThqI5GFmEeAH3ZQXzT14lQyvk/U3nd?=
 =?us-ascii?Q?esihQdCV7VxpKEyAIi3PbVqoDcFI/QGL0FJxTgzB6NNL/oShj31Ho67Gn8pB?=
 =?us-ascii?Q?WnE4RUkHcS8jaVls53FoVm21KqkzKbQbgXYoXSxK6WYhBB0CdlqF20cwo6qU?=
 =?us-ascii?Q?Egfn7xsFM51h4cRBGuCxNIX2ZHudy/JzuUX6sdueydzZ8BP7uRJ8MA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqjGeqnLDlKS+lA6l69iVhsA7Tio4KAO3+FC1gFrdPFWta26nFoWrFlOAOut?=
 =?us-ascii?Q?4XDgdej5pelxHwlk91X5VauHtu39afPNhBFRKpc9dr1yN2udbm3shknW20dz?=
 =?us-ascii?Q?aoAPaRUuXfv4WW+hzau+M+uyb4pArcHIhagAKqgcO1gX25L8fuzBj5yP9lnM?=
 =?us-ascii?Q?lhGHbmsjOsO+vRJdfJsUuxIkoUCLZp9nTKwrpzdQPS6f7ODqPyhbNJACNBGn?=
 =?us-ascii?Q?Qz+1PbL9bozJunSAtx1ZKPD9ybn8TpWBJAWdYoSVSnSekpgAJVTnFQ8KNVjj?=
 =?us-ascii?Q?1vLF23oSxXhD1+yODm4w2Ouac6ZflS+Vi5V3l0LPc83EyYiKfZ2htehNMjbU?=
 =?us-ascii?Q?88k0rgU6mMU64MKLGlnSetOdSxqfvb+yCYrHTyhAuGz3Ny13ZyNW4VOdGp2G?=
 =?us-ascii?Q?D0Ecn13uv5meBx3mQO7TGqPydgtJl/RXxt3291KtoQ5R4mhsxf2TZ+9X6Zm7?=
 =?us-ascii?Q?Z7vbLK0rrg2dl0BLpoTzkrJXEKlOIloYP3GrMnxPJ7aJ/b8uNfjORcRNNM9a?=
 =?us-ascii?Q?hqMy2ATOQsPrjAGi2BeZQLtAT7ktn+6lH3ny2oh79/PvkCkFBRbLjYFgzcdc?=
 =?us-ascii?Q?p9OsDmnUNbS0Uwd1OZKnd7aURdE3w3fy6y7XtICDRaktUsCdxMr41kbzF/uN?=
 =?us-ascii?Q?y1rk0TYEjX8eBmEzhvSjjZNBfGTg1KK+ffNLRnjDiHYu2xFf7jaVvEuls3QT?=
 =?us-ascii?Q?svwiIctidwDOMfc77EC0Z7v8ZN7jMDk3+5hCF13kx69lS4yHvp9tgErbPtgo?=
 =?us-ascii?Q?unP/Hsu3x7SLtlT/qnslIJqOQ3AOuZkvTLdyb6wKWqf92HBfkM2m3SrOj+uD?=
 =?us-ascii?Q?pzCZne4g011m5aES7Z6ixi0ajMGdAqdqi9dgH/oq88C2g9v5I6QZqFQPrSq7?=
 =?us-ascii?Q?/btD3Kaif6NouBsiqr9fE0X5vF7d2O3a3m+PVOrh30rQ6bZ0kBG/KJL774jc?=
 =?us-ascii?Q?nGRWGvJY88Vfo8796rEQmFebtzYCaoBRRKWBieWckd5O6t5R0lzNaRf8N3Zi?=
 =?us-ascii?Q?GkHsK4+3xmPwqhMVhDBm8BOY44zTh72LbeL6urDE0/RaC0Sl2JDfKzJ8QcGh?=
 =?us-ascii?Q?CD4b+xwPIMSSVVEtEvTD8kJ6OsqXHQ/gr7NZLs88ilY+k0C+6Gbp7XLENhiI?=
 =?us-ascii?Q?O0eTtkZE/ds+sUo4uDoWQHqGYkPGKhqHkTTyPngJBv8GXWCzc6+abERF7Yql?=
 =?us-ascii?Q?OP48HgltvOkOelppEL9pZpSzRHId8jf5MOjkb5GqjzJONrEYz/MfbnKXNW+U?=
 =?us-ascii?Q?2LavoZI6C5QFAXdmDGF6BOU/l+ZLA142RNX2p66yQzDMfIBycDA/eE54WQs9?=
 =?us-ascii?Q?QOINrOT1QbmisN59/mHEQuWDsHHP9ScMkK8RXVnojjBY7nx+jU/QqnTW+Uam?=
 =?us-ascii?Q?YBm9YjsMwepLfLais6pb5kHk7fBvj0YqCdvQM48faAX+eAzf56bb7CgExwqt?=
 =?us-ascii?Q?fvjZMA0agXEpv6N1il88bbzu3QjvIIRyz+i7g8HkT8ot/1BuNsH1LO/hj+Nz?=
 =?us-ascii?Q?CZ73mjnqnbkyTAgO7FctXOpmcXvhMoOYLXXE8AJUFq4LHsrA+Nm0HlNDDqQo?=
 =?us-ascii?Q?Ly8tVnvjcJvnCfNz4So=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c65c308-870f-45ad-522f-08dd9834c072
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:29.3134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/fz6RxBHpFPdJ+x1pBiAmnzrNVgth6lwF8anQTgcLtKeDv5H2iR9fgrhEOU8uV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

This patch adds NULL algo capabilities.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/cryptodevs/dpaa2_sec.rst          |  2 +
 doc/guides/cryptodevs/features/dpaa2_sec.ini |  2 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    | 41 ++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst b/doc/guides/cryptodevs/dpaa2_sec.rst
index 1a590309a0..6b1357d78a 100644
--- a/doc/guides/cryptodevs/dpaa2_sec.rst
+++ b/doc/guides/cryptodevs/dpaa2_sec.rst
@@ -105,6 +105,7 @@ The DPAA2_SEC PMD has support for:
 
 Cipher algorithms:
 
+* ``RTE_CRYPTO_CIPHER_NULL``
 * ``RTE_CRYPTO_CIPHER_3DES_CBC``
 * ``RTE_CRYPTO_CIPHER_AES128_CBC``
 * ``RTE_CRYPTO_CIPHER_AES192_CBC``
@@ -115,6 +116,7 @@ Cipher algorithms:
 
 Hash algorithms:
 
+* ``RTE_CRYPTO_AUTH_NULL``
 * ``RTE_CRYPTO_AUTH_SHA1_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA224_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA256_HMAC``
diff --git a/doc/guides/cryptodevs/features/dpaa2_sec.ini b/doc/guides/cryptodevs/features/dpaa2_sec.ini
index 3d6e449ca1..a280c7b51b 100644
--- a/doc/guides/cryptodevs/features/dpaa2_sec.ini
+++ b/doc/guides/cryptodevs/features/dpaa2_sec.ini
@@ -18,6 +18,7 @@ OOP LB  In LB  Out     = Y
 ; Supported crypto algorithms of the 'dpaa2_sec' crypto driver.
 ;
 [Cipher]
+NULL          = Y
 AES CBC (128) = Y
 AES CBC (192) = Y
 AES CBC (256) = Y
@@ -33,6 +34,7 @@ ZUC EEA3      = Y
 ; Supported authentication algorithms of the 'dpaa2_sec' crypto driver.
 ;
 [Auth]
+NULL         = Y
 MD5          = Y
 MD5 HMAC     = Y
 SHA1         = Y
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index 1c0bc3d6de..e9b601c035 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -227,6 +227,27 @@ typedef struct dpaa2_sec_session_entry {
 
 static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
 	/* Symmetric capabilities */
+	{	/* NULL (AUTH) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_NULL,
+				.block_size = 1,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, },
+		}, },
+	},
 	{	/* MD5 */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
@@ -553,6 +574,26 @@ static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* NULL (CIPHER) */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_NULL,
+				.block_size = 1,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.iv_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				}
+			}, },
+		}, }
+	},
 	{	/* AES CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.25.1

