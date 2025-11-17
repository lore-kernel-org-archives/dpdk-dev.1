Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AACEBF91
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 12:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08AA940262;
	Mon, 17 Nov 2025 13:45:06 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023098.outbound.protection.outlook.com [52.101.127.98])
 by mails.dpdk.org (Postfix) with ESMTP id D0F024025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 13:45:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqzasqlwAhZuim8pWKOl/6a8fFLUc0JxJml6f+oo8ISpiNZ62B0pdFMSynHB0lgFiC7B47TVSFjC2NAVmK0gfXmqsmofQIAvjftFCy9wRzAHlaY9LogWqksRbPJr0S3Ju/CxOqDmmtS2q57jaFKHGpqJRdIEHkpVt+tfEcEfcFnCjHM9ObLM5ZBIuT6At5RIceItHxgHVu5BUZb+S5NGhioyeW+SxEwzxAVfdYLGPNwjZ9XZQKlDtG1plEUfLitVdGoeWWIpHv6HiI+IaM3T3EE2sAW907D1cbn0StQy7EI+tRWN+kddUllduynLQjq4oN0vWMXYvuUXjtE3sbObHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM2SegBAnKPhd6ZCiScrganevZXsgyUCYgwKgsb5TMA=;
 b=PwMf+tVM0YaSq2WH7GLsiti+iGrW6alevrC6eKgQHJl6Cw1gaCHYzQD9Zdp2JNVhTPJsHXgR5SoF17L3gMb74KRw2QLTAO+c4snQtBamh63FrBM9yJNGsL7XmfpAq9eVTFZpMJAavvkVnwnfO3q9Y2KgixWaDu3+Vajpn96Of+ohuP0Nlnex0YGjpysCpx63kbihBNFJZyGOKbqNrUKMYvTcMi8whD/KwG6pC1hCo6JdP1vhCjJoh3rmjmdSH5sPUPmsTQ63QbdP64DYwNn4vI/V/dp2/mpKShsFtSD0mRDKQCzu90FuyZF2HsQV/lnuDsBCxMeTqsDSV/qu8CQ9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM2SegBAnKPhd6ZCiScrganevZXsgyUCYgwKgsb5TMA=;
 b=MmL39N6i4WBA/JlOYh1YFw6jJJCGzWzK9Iy9GjpmSi9z48b6bF5jyUh/BGg+XBDbSf1rpbWRdfZLgWg9dJ3XcPmh/0JJwKpnHbvD8fxYsvSzO6BF8tz7Dv/qCGtj4kGgbyWrPD8zbcWWqvFcAEppkimqqX5mcCbCyBfZSjMm1umid7mgbFafCvFBgov5NWxID/CgmDGM34eWZsbAwXwu7xWy4/ukE+R0hYzrh9ztTUlua+SrB88OhKPKi0Cmn1BfngPvMCf0hWIaMR8pJqvnC7WxNGEVt1bqRhybD3XYvXBpNMiHkHEuQ8xa87xYqZLFv/PE7WiHtZwGGv9CvkOUwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by KL1PR06MB5895.apcprd06.prod.outlook.com (2603:1096:820:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 12:44:59 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 12:44:59 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: kai.ji@intel.com,
	Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH] crypto/openssl: support AES-XTS operations
Date: Mon, 17 Nov 2025 20:44:14 +0800
Message-ID: <20251117124414.1839-1-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|KL1PR06MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9f4dd3-e3e6-4437-80aa-08de25d71e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SuyJScOhzqNb+Ex9DkjraeI6E+Pi+dk90xAPyguRDToBmZTUcWWP/vx3VZip?=
 =?us-ascii?Q?kn6qC4qrPbcNqQ4KpR99dqtAWy5xtYQZ3drwSCbv8bTFkB5qEOf0RDNLBUxO?=
 =?us-ascii?Q?OFHO9tFzI65hVUn/+WmWFYalg9GFGpGGA0GguGVaZQIdUyZpItPEpU7lPLkf?=
 =?us-ascii?Q?FIgBAiuWNisDp+4qd9NhhGTiHfVkU1mtuj3EIRZG1J3Tdi+I0D2ZPPuFPgi4?=
 =?us-ascii?Q?rImiqRZylJhuLyY76Y3lqUtZv/DwXcN4DaOGNr5TWylWUbf3/juvDC6Y69ao?=
 =?us-ascii?Q?wdKlZolULPE0GEwwUl3Ip0/cw+VU9V+kJcSHB2KnYPzsQ02z7e7v/bu8OjKl?=
 =?us-ascii?Q?HD1y2/tSOsh1tBAiyj9ZN0Mv5f8D98cI0dJHbjVABLbyp5wQWq6pFfJ0RZ6b?=
 =?us-ascii?Q?7YeTD9wXpTU0fLdMYEyPDA9zRrOt4l+vxC6gOrBpShR54koCxtkDp2onepWR?=
 =?us-ascii?Q?/dgwggKqrynOORbMF7Qt1RFPytESsgKnS2jtn5zdTozvGecxLFiPIbt6JoDP?=
 =?us-ascii?Q?1r5hnd5izlB7pC7tbLdjuITv5HBOSZGO3nH7tiSZdbQcI4tMurxDnbzt/sj8?=
 =?us-ascii?Q?0yXW4Lkm+Bq6WW1LlYhxKljZ31GLPqjVZguzbXZMZ9nLtds9mzpapzpm8Rhr?=
 =?us-ascii?Q?/zaHC2gs62h7zDR+UXbzxD9Hs3/af3rpol0H4PUCERVxLxbAW25Bd0tsY0tL?=
 =?us-ascii?Q?P0lneexSFNbcHNOwiOhry4JAnT4LlcuL7iizkyCfX943crg+nM7ywDh9AurV?=
 =?us-ascii?Q?jxH7i9w0NC7iQu7swP6zemuSrskl3XlbZKu1fEflvpbI2XkJUX1J1c8jwGpD?=
 =?us-ascii?Q?/t12ryAIe86RtA9KI1WAfyTHunEHG+Aze85DlBmUrPACoxNdJ+0X4uxA8TF0?=
 =?us-ascii?Q?4inK27tbOO7XNds37lictnD6cWNAmA2c0lQ02yjiJg4ycD0UA2Hzf4v+WIYU?=
 =?us-ascii?Q?K17mgAnoNP2Ya/SA1iRl8VjEKWiL5KOoTXM/vfNdHCkPQtKd7ZlOnCV2yiKT?=
 =?us-ascii?Q?utWlolqGPlCcsBbgE11UJfaiLSoqbXW/YT21bKfliCKAzZ3i9sKUdU8haAFc?=
 =?us-ascii?Q?EPW59v/eDJ2qur8wTY/BUBZhEJI+G9y+cnt6alWgugnTHP2YT20v9xyFo+8x?=
 =?us-ascii?Q?SksXTjQWTxbe65PVu6siE6sYRxkZSSoyULSjfUttKwpcpzfTK+f4Uk4+uYrR?=
 =?us-ascii?Q?8DfwiEmboO0mgC3ao6EeB74N2N6h5N8IFDH4WLCo3/MMjTosQzMRlBR6MRHO?=
 =?us-ascii?Q?vhVpHNDxDgL2mCbLtIJeE1mYvTmeErH6eKU2tPYkd5vCFs6i/Oa4NcomhUKz?=
 =?us-ascii?Q?LNsFeGPCyzSuAx1qB1ctretOEuNWMmyi+KnDpffor11xBC9T+4hyOwKP9eDd?=
 =?us-ascii?Q?ZCNwGntbM9lP+JCEoD0xkRkZICZwlY43/ZmLrd7GGdKaEDeQZn4+SiSE75I0?=
 =?us-ascii?Q?Vpsg3Lk+MGDd1ni+DQAopAY9TEmDiDEOGw2t9jzpeqiM0BATFMNxUdIE3zet?=
 =?us-ascii?Q?sYt37B4VKWR75gZWWK8MeZ+pxpfH4jyCmj+U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3RsEeKPGDkuQ8Le32SiAqONypEVVyn8LT7E5qfOV6Nymn+RUC9f5fuPPBzbM?=
 =?us-ascii?Q?WNAzRkrJfWFuuRN2WVJto+MIGsj9svIo5PEv8ti/AKy54DXCfV2zD7D8DzgW?=
 =?us-ascii?Q?y6I4uz82WGHwB8xnu8em9Q8eUP9EY8Zwv7RHdk2MyWNN0KHfcNvEFX3PkhqW?=
 =?us-ascii?Q?EoQPWvwWbAZvwuUChTN2XqIb4R2Ss0d5zyv60A9sxfxpW85RM/y8irXKa0Kj?=
 =?us-ascii?Q?sttk7itfnBz0ot5V7yvgYqp2en8iZOaEWxfFiZCgpBwyk96BJ69jRsqDOR31?=
 =?us-ascii?Q?6Q1oNGWv0WimKq3VhtSM1VbcgQRh/tmoZjqjDwHnnsZiegDr98Rx/hR84ul/?=
 =?us-ascii?Q?7K6y6Emu/BEEOtdcTxMDif9rbdWQLI/wL3LRxzbhX4CXA8RXPemV0egfrs/b?=
 =?us-ascii?Q?vGmZ6ZVTJEnFNDH15jbEFcKo8J5OEXIj5qunG8uktWARmTaETUDRLLuNJG7A?=
 =?us-ascii?Q?iCgV6pWsD0TJ7T3W55QHPOKNJLoN8eRzixvjtDwyibVOSp+7PAzUPKfnfR4f?=
 =?us-ascii?Q?cpmiO5jAJe3KYLHCSZnEU6h+rmkp/R5JoRY6b1hJPYjFNtqGE8IEtOG+mkRP?=
 =?us-ascii?Q?GBZbSZhuynS4WyaoTCByPDwWBsK3VbJSPzjf9Ak9YzKwTkz2Ro0H0Nw3XAEk?=
 =?us-ascii?Q?oj0nohe/i4unL6HSoRp59XlPSsGVBdVOc1a9eIwbO/7ZuGnJuRBzp8pBanDY?=
 =?us-ascii?Q?ycqEPf/jhB+7MBHuM3TOREK2YfybuyeV4CqYtENf5EEBYAo6gcO5oY2TdvKX?=
 =?us-ascii?Q?hmWhM1j4GT3GQP07nXgIcUd2F82tpzcvvoizC2iWTKix04RHDzbMkxzJ1zzA?=
 =?us-ascii?Q?A5xr4C3pA2FO49tsv+i2alebUbRK0Q3u+bX543aSbJC3mJkCBfZdr9XYkSp0?=
 =?us-ascii?Q?CG9+yIUFQHWrXHlj5z7O35N++UlPVv7B5zlJSABqzLURPGr+LFzteobu9ZsU?=
 =?us-ascii?Q?BETC8lqeTVtb/csGDKNhGnT9IG3+p2hsA10oa6ss9UE8UDDcIAuddSV4ILja?=
 =?us-ascii?Q?JSnA7FOKIAdHsjbrDsyk/unAl03sTqk0VB58pnhRuQX84mqLi7X60rm8Mcs7?=
 =?us-ascii?Q?Jb/UZYX+EHoXnotlAobQNOEuGUAjHXbQRstaDl/xywdm81ZJKbOZMDrt58yY?=
 =?us-ascii?Q?J1bpEg57PQ9EwKLuag3KLzooK4B3fVmaVKZfQo3hK981HdYQoL+1rePdAqLK?=
 =?us-ascii?Q?HgL1tyYiUVcWI4vJo69oe/o/vUyzTqTfdILnQNLM2oH0z/iLRWhvlzKrFKvt?=
 =?us-ascii?Q?75+JdllK1nkBMmVXFcQb6cEosbNXqmDbUMEUBY/hvbLaRXPUMouQhTpzOSe3?=
 =?us-ascii?Q?BZ4lZqifiaTteJcWNs7NrBuQBBcW+IDjZLllHWUZVWcJuYuh5g3KvNby7QoD?=
 =?us-ascii?Q?nD8k8ltN4AoaXED2s4qDWblDmVFJwIwXWhcFroAjwZRYLBch+2uYDm8RzgS/?=
 =?us-ascii?Q?cuWjXYjcVO3PzltbZi1p32AYP+/fr1rST/BmA+puzIWFQjHfh9yuyi+SZ7fj?=
 =?us-ascii?Q?DVrJ7wZYcuvg29dI2AhH1wE7GogZYYVJgeG1dmIgyyEO8N34fHubP91BWcgi?=
 =?us-ascii?Q?wFxsxtzGPHLtuYqry1h1hHqr66U7u+dMt7CRrOqOJ8S7TZnpEDa96992aNj5?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9f4dd3-e3e6-4437-80aa-08de25d71e89
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:44:59.7429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGAeUiaUM2A/bNmC3OkmvHmshlzMworwpD5AoOX3/LuBbYM6sbVqJyxelDnzGXYf0ZaMqKWQVKGd6l6c4XvlcCqzM2nkz2b1SoQvs8/QuA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5895
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
 drivers/crypto/openssl/openssl_pmd_private.h |  2 +-
 drivers/crypto/openssl/rte_openssl_pmd.c     | 13 +++++++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

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

