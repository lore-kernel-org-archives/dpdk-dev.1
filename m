Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8FFCF31AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 12:02:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E9840267;
	Wed, 19 Nov 2025 13:02:55 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022131.outbound.protection.outlook.com [52.101.126.131])
 by mails.dpdk.org (Postfix) with ESMTP id A27AC40265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 13:02:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMmXUN8ZDn7P3DrVDbZ7iGj/0g7C2EIHxtpx2R0bRYRPON2FIZ9AYYilxKWbK5X+/D1v2Wx9ZsNyTpqVhi6RTlubTfH4grqCjBOyELNpyDKkCWy9t2dYVu7zbyjRYp/nCV1HmcmEJ2wJIiEuoSdQZjA1oohjCR6jU87mEvOQy7eUx8PKiBM8XrClg+UtDmnwKC0Ho70rgMa74emYVGuF1sIPvsc3O88zYWl8e1IsdlfnhUWZuXUyXtvWsKWXSn1YAp4hI3pG3Gb+uyomWRFR3XEv0rQGBWi9PPhjpPd6BHB5vUUHViGp+hR36cwkf3Tcfvys1KBpq14IN4u8WCxVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGYJtvxUq+tWzm/Be3CHjMZ3/qonTF61FHiUmbTUvys=;
 b=mrZdA3dX1/9KSTcF5Ukpddi36YiDYyKftaLTUJQr/lt636SZWuQKo40mUOZnxkz5BGJmWvXNzPx8nYQklv+XofZUBFzcrEDSIDnFl/Sf629Q70B74jutJGhE8AwB0hBQ3OFALfPCnPbJovSBKrXbuYziXYVGmZy1QsMMwzdkE2eiPlhAb7OqIBHMSPAVIzaJKHdpfIqg5eSrgQJxrr6NYZ20x6nbFXCHTISYeVBsCwof9QBrwtqXbDF1YO6QMz5gM2zeT0iXBwDiUEh7w6LxPp9ZuBPzt1rxCttQvoybEmvbU2Rt66piSxF92Ko0E/z/kHjpS6JGWHt05OhFKMYQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGYJtvxUq+tWzm/Be3CHjMZ3/qonTF61FHiUmbTUvys=;
 b=nPV5q/URHQWNjVu1f2dbJRdcFsqNZ90lWIjNG5XgEJ7jJDYjae7ga7rNmfUmOhf9OuWjV7mvuk5cEwYma6EOG+DxutFkHsxTrAiP7+WjTyRu1To5CPv0jmcfuvrOPVN4pWzjSeVBilEa6Ug9BRjQjjjYpzolQFWEf1bXP0E2sVex9iOvqHYFUtI7umjSPZCczvQI6Qb0qNsIXyI3eeSo1eBzJNoLwOGyVZSG/HW4LY60Ns6awWF7fcQPAoa/zJ614HaXxCJxyCDwFojaMBo6A/DChgHyqQYyE/lb6pSVlUUQRr4FQWLgLui+He31YtIFR4ETSmyOHMr4sc33c409VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by TYZPR06MB5249.apcprd06.prod.outlook.com (2603:1096:400:1fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:02:49 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:02:49 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, kai.ji@intel.com, Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH v2] crypto/openssl: support AES-XTS operations
Date: Wed, 19 Nov 2025 20:02:30 +0800
Message-ID: <20251119120231.1399-1-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20251117124414.1839-1-felix.zhang@jaguarmicro.com>
References: <20251117124414.1839-1-felix.zhang@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|TYZPR06MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 707d024a-82c1-48ba-af51-08de27638d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v1AywHouaws5E4aTqR8+z77rPrQ5Z7jCuqn/PkEyhoI6miIGRE3JtLB3hs8z?=
 =?us-ascii?Q?a/q7VLS1FPoevWZJSXS2wV+a42mWbQD+HusoeysgNinRdlv0T357JjpfAnvY?=
 =?us-ascii?Q?s+3d5jT8E+sE1BTRWSrlqaXwIJlPGY2NIIsHn9JZh0I2dHG+EHLY9ONCee9A?=
 =?us-ascii?Q?wseQRnIjyJNm8FMzr9cIXtsDRS73VmtUwkorfz/YNk+abhbZ594rWNttwLn4?=
 =?us-ascii?Q?RHMG7AzZmYi4Vc5CiVBsRyEq5qw9xsl8kZjkTv5JkDpybxNPeDzBmmbokSCp?=
 =?us-ascii?Q?1U2HFbwNn2/nb0TAvN8z6nk6be8kp/mJAt/QhWntc8v6+r7pfrtsoMCHo42A?=
 =?us-ascii?Q?gWKnYN4pOfNvXZ3YFN1KsmbfdbvJuGszF/eCRpcZC/oboRXPZuIvNSlLlVU8?=
 =?us-ascii?Q?Kad9cdjC7KD3kWo83cpqxp2n17bBFqqPfvHX2y0Z6JdSwWRFykNA7ag0eTJV?=
 =?us-ascii?Q?RCfU/DhmzyULvtiFrQ1RBnzZ3yD8xWpIoee10r9CsDEHcodFbOhkhHhsY0AX?=
 =?us-ascii?Q?31jK6g2ylR/Jkkpwj0/0WDjkPhokOTPCVZVxyUYMdJ8HA44VmvKYYE4KDSb6?=
 =?us-ascii?Q?u9fCwvGVyzCRNFwPgzUrPIM5dTLtg9aLYsnKEBwvOPbu48pSNkdFockFal0V?=
 =?us-ascii?Q?ntHTwi+aHf8KqBhEEGwL47HbfrpoDAikYxOChsdQ7l4AqkxMRvbRCbblyOuQ?=
 =?us-ascii?Q?oOWeqZ5Mxghoh/rXAENqamKuDNiZCVDp+5X6L8+kvUmk27P4PHujBjl23LMf?=
 =?us-ascii?Q?ej42C1YuMgffkmCw2+ja4SHJ/bZ3njgy0sizVM7bZdMStlx/hXwC8LVDjhYl?=
 =?us-ascii?Q?QQ2FRtXXE8XxhWCmldnXcsU1g3jxKDnxbU5CC3tXcONfYQsrDRWFmqvpMSW7?=
 =?us-ascii?Q?nMMD8VPeUvXd+EGVQSLDSEOLRlvszb2SNWFUn4Z1X7UZHW5FF0OQJGceMD8s?=
 =?us-ascii?Q?147xIFyp6WgkixlRn5zyY3cTMhCp4eV9lB3xbD/NQpgdrCgxk3CJUb+jX9cB?=
 =?us-ascii?Q?li4opkIMd7LTPam3D6A+r69Ad4y6jrWkLwpv4bN1zCbbCy2Ifg63KVenykpl?=
 =?us-ascii?Q?S3vHM8JfU+54Tpk4PbpsnUh6HLbZaCb1dE824OhlU1xDuv9YZw7lIXYMkfyg?=
 =?us-ascii?Q?BKDsH+4wDOTxSF34XzWLivV6KkMrV4g9STaVffAMmZu2li7/udPoKOABvoCv?=
 =?us-ascii?Q?cv28VCY549SfpwEjrE0wZbkQ4tvOmScp7mrhqYtD1ziCr667A3P9yxmq7mZF?=
 =?us-ascii?Q?NJTJw4D/wNkuSXMjI85MDxVCK/LuJfbOXoFYnUu0OgYRsfMqvEU5Pmn2tadS?=
 =?us-ascii?Q?dwP1pMHVa8LIB61mC9sfx2MbNVpCiXtF3OhCwGEoFzxdWLfnL5XHKXWd4Sr0?=
 =?us-ascii?Q?QvnOMwn2Cv4l3lw7DcMWwe9Vo8GX16Lz6fPDkP8y5t7zUjUb8QXw51GlUpp6?=
 =?us-ascii?Q?0XtnislNfrXHKKwadkX7bxWxKu3myUy0YkrAU7kN0GnUez9GKAaMsizXkdXS?=
 =?us-ascii?Q?xLkHtQtZ48JcQgcBAPfPaUTqoUgnvTQ1se92?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LHQUm0YKvh1QWM8bqOocde7/NkBnm78cIeQp/D7C2RS7gXlJRvcqjB1/DwPa?=
 =?us-ascii?Q?KIOPTwQyxMp6eczyMavdpwwyXfs2iUIlafAKO0J8/lOOygtMuvA2nccz0U/C?=
 =?us-ascii?Q?o1qleyTzZk9a97g654UJumMUEYrJfAb/cFWmZFZgm2kMohGRqNarEl07oj3S?=
 =?us-ascii?Q?dllSNQqRUyCY/DFM8X8/vV2j2tZPxu4M5X1w/l/Ev9uZ0S64Oab8SUuDSEyt?=
 =?us-ascii?Q?fKTT3O3ItwcNX5S5KSssOF+hmxh5piion4ugGNM9P0tj6WAS16gvfp6olvWN?=
 =?us-ascii?Q?6TI58K6QwnOWf2pnjs3lUssgPDBnocuIm/Y589yndWbiwIHl5NOgUKB/rKsb?=
 =?us-ascii?Q?zCnojo+FRfoBM8TfwdRZ1xMV66Zz1E+0a5IDoc7BkdnSu1JP2SYMl/Wf+AJ7?=
 =?us-ascii?Q?upQ1NOHtuU7f4mq2Nw9fs31HkckwKw7oYc53RiTgCr3cm4WlIjT7OvDevmn6?=
 =?us-ascii?Q?fy3HwqY6KkU4VIccyglnH/4GW755ujHDp8hBmzbH3065FL8WVQx5YzQNnIv+?=
 =?us-ascii?Q?XMmOJNhbq+wFBIs9uA5tIdoPt+Ln9BIaljW8dwXv22BISjJkIPWs7/qNf2UW?=
 =?us-ascii?Q?eNJtHs/gkiTNB95ivqxHyxJlNqOcnfQpVXBtnI2kz3Z9D/+YDKTuSm4ofRGJ?=
 =?us-ascii?Q?P1Xo/v+iXn0rVwDxgRLJBCHbKFYm7LZ6L3F8y60mfFoHd93jbYdjXA4pqeOR?=
 =?us-ascii?Q?bNAd2tatov+7s1I1G+03xjtv91qxgMA+iLsoRcmscX3vbnsP5quheHeeKRlC?=
 =?us-ascii?Q?zg7AqjxU5r5HYRr0NlIT1GtOInyuCYKuL6AY+mQMksdh7qhGBDLY8FDdNamL?=
 =?us-ascii?Q?dJ7ZykInnYZPfLG8enJ+tVgbYCPadSwGOSfmBWBl19iTtxtofK0WHQ13GErq?=
 =?us-ascii?Q?AiMByh0dHYgnykeectPwLXeJ5//zBV9WY+WneXN0D0FZh+dRwRuMOwZybxr8?=
 =?us-ascii?Q?nZOLwz8MQ/jB26mNKpValH7JqqIwd1ccP2aqNZgdK7FyrPX8jShBr6yFVS6j?=
 =?us-ascii?Q?aFcLJt81I8VeHRF1kuZbGA4S9NxsTp/BDclN10aEBzTbfk0LYTBrnOnmWAJu?=
 =?us-ascii?Q?3JdJnEwMTIFcOISKbQlQvUKNMl/YLmhaXhCwjCtbPxkCrgTgBpW0xJiUmjs5?=
 =?us-ascii?Q?3xe4jZHcH5qSxL91IhQxwxK2IWYcdbzPy5kP0SnCStZ5RBwTDNaq/YJcDvQb?=
 =?us-ascii?Q?bi8kl36YKY4bw94ES9jjo/Vku9xfAH6NJLfFW1kwt0NbQ5lc0DZsWMnpEIHE?=
 =?us-ascii?Q?XYhS0B01yoHOkFhv/Uzi+d6jxg4ez0Qmgme5tNaxQZz3iXc0odf8Pa0mMlBl?=
 =?us-ascii?Q?uduCjilDrEpUcSQZl+hKboNMW9U42lsCy9D9tg8LOy5ROTvO5D4Ruk3xcSgo?=
 =?us-ascii?Q?F9hBOXaYg/52+k4kLocMteiWmSgO0ZMvxo/nm7BgVA69RIeb3TnoQBs6qVUT?=
 =?us-ascii?Q?KWQcmtP4TW0QBPIb2gdhEihDvWXrb/pkrycuFLHnpp5f9MRGHZi9ofSKh89j?=
 =?us-ascii?Q?EoC+oZ4j0jv3TklT6pwdljR1M+ojMspfjtO3JBikEmvhello1ONegxFvLkuF?=
 =?us-ascii?Q?O2BW8f/964Jp3TCrd+emmHV1PtVLVfst4ITLdXmJoVr33yO+radI1UYwErUm?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707d024a-82c1-48ba-af51-08de27638d95
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:02:49.4595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z+f5lDRUGFdXKVW1hp/V5l5GsMvSaLh4mVmQ6d2FzVr2qlNuD91Aon841/C+2gDszaAJhz1QGS4fsyDsyZkMsFTMF0rsSZKrBSi2dUlsIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5249
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

Extend openssl crypto PMD to support AES XTS operations.

Signed-off-by: Shaokai Zhang <felix.zhang@jaguarmicro.com>
Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
---
 doc/guides/cryptodevs/features/openssl.ini   |  2 ++
 doc/guides/cryptodevs/openssl.rst            |  1 +
 drivers/crypto/openssl/openssl_pmd_private.h |  2 +-
 drivers/crypto/openssl/rte_openssl_pmd.c     | 13 +++++++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 20 ++++++++++++++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/doc/guides/cryptodevs/features/openssl.ini b/doc/guides/cryptodevs/features/openssl.ini
index df6e7de316..1ce6efd3a5 100644
--- a/doc/guides/cryptodevs/features/openssl.ini
+++ b/doc/guides/cryptodevs/features/openssl.ini
@@ -24,6 +24,8 @@ AES CBC (256)  = Y
 AES CTR (128)  = Y
 AES CTR (192)  = Y
 AES CTR (256)  = Y
+AES XTS (128)  = Y
+AES XTS (256)  = Y
 3DES CBC       = Y
 3DES CTR       = Y
 DES DOCSIS BPI = Y
diff --git a/doc/guides/cryptodevs/openssl.rst b/doc/guides/cryptodevs/openssl.rst
index d467069cac..e48f425434 100644
--- a/doc/guides/cryptodevs/openssl.rst
+++ b/doc/guides/cryptodevs/openssl.rst
@@ -22,6 +22,7 @@ Supported cipher algorithms:
 * ``RTE_CRYPTO_CIPHER_3DES_CBC``
 * ``RTE_CRYPTO_CIPHER_AES_CBC``
 * ``RTE_CRYPTO_CIPHER_AES_CTR``
+* ``RTE_CRYPTO_CIPHER_AES_XTS``
 * ``RTE_CRYPTO_CIPHER_3DES_CTR``
 * ``RTE_CRYPTO_CIPHER_DES_DOCSISBPI``
 
diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index fe89e522e1..d5a751600a 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -118,7 +118,7 @@ struct __rte_cache_aligned openssl_session {
 		/**< cipher algorithm */
 
 		struct {
-			uint8_t data[32];
+			uint8_t data[64];
 			/**< key data */
 			size_t length;
 			/**< key length in bytes */
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..2d803912d4 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -211,6 +211,18 @@ get_cipher_algo(enum rte_crypto_cipher_algorithm sess_algo, size_t keylen,
 				res = -EINVAL;
 			}
 			break;
+		case RTE_CRYPTO_CIPHER_AES_XTS:
+			switch (keylen) {
+			case 32:
+				*algo = EVP_aes_128_xts();
+				break;
+			case 64:
+				*algo = EVP_aes_256_xts();
+				break;
+			default:
+				res = -EINVAL;
+			}
+			break;
 		case RTE_CRYPTO_CIPHER_AES_CTR:
 			switch (keylen) {
 			case 16:
@@ -493,6 +505,7 @@ openssl_set_session_cipher_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_CIPHER_3DES_CBC:
 	case RTE_CRYPTO_CIPHER_AES_CBC:
 	case RTE_CRYPTO_CIPHER_AES_CTR:
+	case RTE_CRYPTO_CIPHER_AES_XTS:
 		sess->cipher.mode = OPENSSL_CIPHER_LIB;
 		sess->cipher.algo = xform->cipher.algo;
 		sess->cipher.ctx = EVP_CIPHER_CTX_new();
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..df5c12626d 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,26 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* AES XTS */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			{.cipher = {
+				.algo = RTE_CRYPTO_CIPHER_AES_XTS,
+				.block_size = 16,
+				.key_size = {
+					.min = 32,
+					.max = 64,
+					.increment = 32
+				},
+				.iv_size = {
+					.min = 16,
+					.max = 16,
+					.increment = 0
+				}
+			}, }
+		}, }
+	},
 	{	/* AES CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.47.1.windows.2

