Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1320BCDB46B
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 01:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBFA040265;
	Fri, 14 Nov 2025 02:46:34 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023095.outbound.protection.outlook.com [52.101.127.95])
 by mails.dpdk.org (Postfix) with ESMTP id 6004740151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 02:46:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGKMdWw0ayweYnNK0xb1TH2FCLsK91vI9/B/rA/jZcKW70cFHWpMVu/rLc9r4ilXvVWxQv5nGzyVZ4HSrCIHnaeNKFcvSoIAcX+z9VQk4oUO8r7uZoR2F3m9xOJq4elohmzrdyFYQGLUVbq2xXLWUT+7U5fmS2EhyWWFMATw/OrWMIlbj10rdrGBXQzVLspSufQZaEyEX117wYQAWHT2hJ4X27WRIXsXOvxOaKivmaisy6gwnA1E4AlzUkss/McVrEMejrE+lvquZbHZF+NFqYabQgIwF6eLNw2U/o+YYvdwQn2bDyuVs/SH0Ad6rMjRiVmYVhCECwQ4aXmpRogOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPppaaEojbTyRcIg7BSfWGMH1RTpeNKQzBHx2hUcTuc=;
 b=I18iAAL0+yMRJj/0wybzQNSMK/lsHKWIiHSghWI2TFgBDe04uIliQphxYO42FKBTfNaiXK9QLeZfMLJZWGlzumn3yx30nrfedKbtZkABZr3d26BthvLgww6mmaJPt3ngj6YciGGTRUbfX3FD89NmpVsRPtQ2QudstijBSa3qH9k+oew9Cn4sL4lhdLLlCZZaafHrAlCqJhgOcVlyEk0h8gTS6GUFCEOJXiKDqVgal4INNR1+8/LotWKEkG7jTs4uwp9S1Ipl5D1pYgJvIOT5GwlOT/U9EKCVkaZX/el8BK4WWOsScxFMxaPYtP+gTvbj/6Nol1lby4xfJrDPhSdvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPppaaEojbTyRcIg7BSfWGMH1RTpeNKQzBHx2hUcTuc=;
 b=VnaB5TZkl9hyl1K5q5s/tz0LJ3azRBUvGHiIp1C8gTeoe5WfiongPxK/oPcc62Qo1Q5z0GIeO8ome0gvcY/M2g2ZMAyUrXMXg2wG7DP8x3joRrR7J1QYiqnKPgw0oFy2ofYDg/+sB6TUYT+oeK5ROFUGxIjfw9B5a/NCXdeCtgO73eTgXZzxzp5VrY1KiWtRmJVXsoCBjau+84uuDDFK2SVRqdtYgG0b9byZULmxUHXL/oyyG+35A0C7WKa2U4un69xlC01T4ZfAiACEOVB4jfjq//rrpfZQOASSydQ7ozRlOdOOBLED32l/nRyvOcWSRQgXtbHz6jgyrazOpoQqog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by JH0PR06MB6632.apcprd06.prod.outlook.com
 (2603:1096:990:3f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 01:46:28 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 01:46:28 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com
Subject: [PATCH] examples/ipsec-secgw: add support for SM4-CBC cipher and
 SM3-HMAC auth
Date: Fri, 14 Nov 2025 09:46:16 +0800
Message-Id: <20251114014616.43476-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|JH0PR06MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a20af57-4f7f-4be9-1bfb-08de231fa0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6he/cyMKjgUXDRh5h+PozU2f3bjqcPcXvTfGw0ZmVBxUqLQZ2qrD/FNNmSzL?=
 =?us-ascii?Q?LGJpuVI8lD/r8PYapEyh2PWCatr3pd6qMlYfKAtDCNxvb3W6wim6aPrHLr45?=
 =?us-ascii?Q?Nk7vQ6vvxcaPZaNASQKWask745oZC4HhgpXy1ycT17L9mFC64UUunILWmAuR?=
 =?us-ascii?Q?5DhHMrYrRNLfglWim+AX0z8DczxbBsI1O2qY2wkFQx2nxpdinz8JrXtarBFX?=
 =?us-ascii?Q?boctdMnXUgj6IFweO/e1BrBOCgQlnCeRZ4G37QKg3sWprZZiP58OlfLIJwlk?=
 =?us-ascii?Q?wdxs21aTfMGPI/C0hNH+M0QGJvtWGwqtFrPdLPw5BCQUazxCxbjYOcpQ3Z5z?=
 =?us-ascii?Q?JDyx8JMDzTQz1oKiulvEWZ5RYrHWFdds2E/k4nXnUVBwM2+lQiR7pWGPL0Rx?=
 =?us-ascii?Q?1TBM2m3M4Cryo8xsHYx1ecV+pZ/SulbTz1bYO8PEMo9GUMpAuKKgn9Ro6Mer?=
 =?us-ascii?Q?PpNr9m3/ajCv2LAto3ozPGYmx2mhzSy3apgT1sffy4hDviZ/P30b95oRRNZK?=
 =?us-ascii?Q?cHKIVdfXF6strjmeIf/BdBMV0L4qA8s+QRI7bhyYLf96tGDSEfLYFdnMcXBC?=
 =?us-ascii?Q?FjQR/dvC4ux19qPRSwUQZCSYbaqp06yW+H2VRSl5lQgQz/vx+A1ewQO6Rs+S?=
 =?us-ascii?Q?89hVPnZfS9PdtfPCXpHlrjm0JHng58GWzzmxSelNOYA6pXsYZ1TStmfZWlYC?=
 =?us-ascii?Q?jmaHlOH4Zy3MYcXZqAl/U+qop8NhkpFS8PYMBFVGXCheaNMuP7y0YPiiuQP5?=
 =?us-ascii?Q?3JNDyxzDepdMPE1eXbsTgrBq3Sn6CzeOiL7d+PxEXjwlBy/S9QEHxtIb1Gbs?=
 =?us-ascii?Q?WvkK21sbmxOBIVkroV8AkSxawMa3CevQTiaoUDgpR+3h3ZIZzH9UbkcwdPen?=
 =?us-ascii?Q?0uDu1b8OFSfdgsHdXono6Pi1INJaJzJ52FeAozIFhyM+KHua46umMJIvOl8V?=
 =?us-ascii?Q?iJZxzVPu2XGOXgSbPvQN93QydcxMOR8fjod/wwp03EDNACItyvcz48xqRWWn?=
 =?us-ascii?Q?cZ4+kuwh/plmdLdK9T7r7+m81AXdM9WN8Iv5TnVziqQBAoY2nx1hq5L8qQ6q?=
 =?us-ascii?Q?xmSYfIBlbvxfZnQFt6HecJ9l++dXmLpFa1ABg87mPDMbctRirP2F5dqLz88D?=
 =?us-ascii?Q?h0NuHF5OpPbSUgTWwwE22Qb0JF0Sj0t42LMlYbfOj5rcYOzt0Uoxn7nN0TWY?=
 =?us-ascii?Q?D3mOH7HTWQcDajk8EyMfix2RMYOoi1+Tl6SOaqW9nmazqkscPIgw6gsR937x?=
 =?us-ascii?Q?VNYy9Y1JrNc6T2CT05eTsKQ/kFkWZa/EcHH3AV09U05MtLP3VyfPXRJA10Qd?=
 =?us-ascii?Q?41XfZE29rQlvFSVqUQZIZZgqL4AbgjDgGRn/pRQT+EmeQAnl2BkSiYTG+7Tv?=
 =?us-ascii?Q?sYSKlRAwGWqqFdunUXzHEhu+ZhMxWsARq9vhyWLCbwNwDkf74fPchJdIDsQ0?=
 =?us-ascii?Q?WIHW7Bghh7tYD0Gr4ssPuk4GiRSnc9y4gogBxhtlPXM3qDbt3+dK0W8MpVB7?=
 =?us-ascii?Q?lfmpDNOz5YGdEZVMS7NbJYRvzwfzHQj0WRY9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?506oCLarbcX16MvDBouwmM4/22wex64ASMe2+KHWy31R9tdzqfBqq11TbaBG?=
 =?us-ascii?Q?wEXbMka/Lr05Lrvrvc0F8aH74hkDLghFpFoXwUri5iEgPdKHddekAdZmM+em?=
 =?us-ascii?Q?bOnTs3Y4Iov/W1tfOBWIfxqtaYvCL9U4o1UPJsfdkP4Sf3ocA+ONpJraQeQy?=
 =?us-ascii?Q?GXv1RcDB2T2S2fGE5o9iOwNAIfG7l2LeLtROqd8PG9ySU6vy+0ZAStSPHlr7?=
 =?us-ascii?Q?GGbYxvqgkMa4uHLXDj7vuUOnjXHMY0euOBJ5eIH7tn8bhRtjKE+Nhb3ICHax?=
 =?us-ascii?Q?4iQ9kqB02i9kNHHva0QRof2QtG0yeQc3esvXvxtVjl2k18afg5UWFzaoHlUX?=
 =?us-ascii?Q?2it4GLJthmzRXe6+PqjkIBrFgkiXmrpuBIGB2ej8wG/JpMMkDhEgr0IZNcBH?=
 =?us-ascii?Q?OhjKJLQ38Dzs9tXqVGKXxA5Dh+n1eSDYbyJzNUk+ZB5P8FdQJ3KoPGY4YFBd?=
 =?us-ascii?Q?k3Hp32p6RY+dQcdDyddRCFhJPVojkG6xhXNsTXkbhok0iWCywAqXbVViFxdQ?=
 =?us-ascii?Q?yMQQuVP7qP3yDzktdgC1b2wVkM6jNozS1pAyu3989GTAiUvnx58biGpvsKmb?=
 =?us-ascii?Q?RheA+ruDCzSX1IIlEDscumsEfk2VivKtykbuRh78TNw3gd6A22yCH7eBNU+g?=
 =?us-ascii?Q?wgVVkMAWBR87H0aIqByNgoyU2MIVaIK5hFGZvtqXQALMS0hvZWtBKGkoYUkF?=
 =?us-ascii?Q?Hd9u+nXcv5zEwICu+T6YPSsMMY839P5FGP63eIAC7nIUKZq4kLG3wNfbNa3O?=
 =?us-ascii?Q?ZEVYFECJT1aD1++IneumzAcn6I828URS/1oC9EP53FC0qOeNvw5JUb9aV70F?=
 =?us-ascii?Q?R5+7Bqjp6cxW5mqIA+JicX5/ssV7Kst6H4Lx8OZkaaU3cjCuWZ09Guz4MAOU?=
 =?us-ascii?Q?VgTheJNpbFCCCT3M72HZ8/H/S1OdsgvukFJO0DLnZcuTciCl3Xn7y1XVBzeV?=
 =?us-ascii?Q?734DaDKWM6sBcGzjgpdx48lUS65Acbwu0kUqCcI9yfIdn6mQy89Vsbku7ONB?=
 =?us-ascii?Q?9Tku2Zkx6KisrcTcpif+zLiYf6owE3lBPvSSkqPOdn5EmQalJLjeaBhE4c+Y?=
 =?us-ascii?Q?QTct+P52AunK0w5sLnWMKuY5tK/fkhZOE1K7mXASDHONdDXCW6fNohoth9n9?=
 =?us-ascii?Q?u3VOGsiDjneMawWiRSheG451eqb0T2Tq9h4Gj75IbQTCVFfPaMqosXbk+neP?=
 =?us-ascii?Q?/VM3XPo3NW+4Tqtsnz3PHcyOAW/GrtiYuf3P/EGztFssI0/k7e+9Nku7O2Wh?=
 =?us-ascii?Q?xGCSlwsKYU83ykcBlM0DH33GL4MPmumqR6ARkNGjF+GRISJL1MYvzwEd6pZf?=
 =?us-ascii?Q?FA9CWYHFrQlE0XDGbhLz5/9dHIuOg6Us8sw5+hRTW36up+dJokP2Ui/g4tk0?=
 =?us-ascii?Q?xM0P0GPz92vqBajFS4fdzkEZWNJsUK+X0T21ZQPCSowFGq/78fLFQDPqWgSw?=
 =?us-ascii?Q?ZK2+r18j3nEMkZeTuCjsAeLc79F5o9XGd0Vlli/rzn4B0gKyFEpQCi0XO+w4?=
 =?us-ascii?Q?GBPdMtPacXdDrUzoTNOgJYmtBTurg5WcR83JaVRSheG4w00vDowDcmqmOrjJ?=
 =?us-ascii?Q?dosFBqNoNCwRAT+/qF5tb//0DzwU+qmGF3cKbh2pYqyezxOux/pxF86Dnojt?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a20af57-4f7f-4be9-1bfb-08de231fa0ee
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 01:46:28.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7D7E+7L9AMl/yvigGGoPT7SNdkVk7XJCF8LHTytIMXqv6N6t6SAvIVIJ4JQOmnYD0iioH4vWtvj3lQJJN024fbBb5GjMC+oVJwWFkjjAMsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6632
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

This patch adds support for Chinese cryptographic algorithms in the
IPsec security gateway example application:

1 Add SM4-CBC cipher algorithm support with 16-byte IV and key;
2 Add SM3-HMAC authentication algorithm support with 20-byte key;
3 Update SA configuration parsing to recognize "sm4-cbc" and "sm3-hmac"
keywords;
4 Implement proper IV handling and authentication offset/length
configuration.

These additions enable the IPsec security gateway to use Chinese
national cryptographic standards for secure communications.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 examples/ipsec-secgw/esp.c |  5 +++++
 examples/ipsec-secgw/sa.c  | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/examples/ipsec-secgw/esp.c b/examples/ipsec-secgw/esp.c
index b72a5604c8..46c3ad3ec7 100644
--- a/examples/ipsec-secgw/esp.c
+++ b/examples/ipsec-secgw/esp.c
@@ -103,6 +103,7 @@ esp_inbound(struct rte_mbuf *m, struct ipsec_sa *sa,
 		case RTE_CRYPTO_CIPHER_DES_CBC:
 		case RTE_CRYPTO_CIPHER_3DES_CBC:
 		case RTE_CRYPTO_CIPHER_AES_CBC:
+		case RTE_CRYPTO_CIPHER_SM4_CBC:
 			/* Copy IV at the end of crypto operation */
 			rte_memcpy(iv_ptr, iv, sa->iv_len);
 			break;
@@ -123,6 +124,7 @@ esp_inbound(struct rte_mbuf *m, struct ipsec_sa *sa,
 		case RTE_CRYPTO_AUTH_SHA1_HMAC:
 		case RTE_CRYPTO_AUTH_SHA256_HMAC:
 		case RTE_CRYPTO_AUTH_AES_XCBC_MAC:
+		case RTE_CRYPTO_AUTH_SM3_HMAC:
 			sym_cop->auth.data.offset = ip_hdr_len;
 			sym_cop->auth.data.length = sizeof(struct rte_esp_hdr) +
 				sa->iv_len + payload_len;
@@ -341,6 +343,7 @@ esp_outbound(struct rte_mbuf *m, struct ipsec_sa *sa,
 		case RTE_CRYPTO_CIPHER_DES_CBC:
 		case RTE_CRYPTO_CIPHER_3DES_CBC:
 		case RTE_CRYPTO_CIPHER_AES_CBC:
+		case RTE_CRYPTO_CIPHER_SM4_CBC:
 			memset(iv, 0, sa->iv_len);
 			break;
 		case RTE_CRYPTO_CIPHER_AES_CTR:
@@ -405,6 +408,7 @@ esp_outbound(struct rte_mbuf *m, struct ipsec_sa *sa,
 		case RTE_CRYPTO_CIPHER_DES_CBC:
 		case RTE_CRYPTO_CIPHER_3DES_CBC:
 		case RTE_CRYPTO_CIPHER_AES_CBC:
+		case RTE_CRYPTO_CIPHER_SM4_CBC:
 			sym_cop->cipher.data.offset = ip_hdr_len +
 				sizeof(struct rte_esp_hdr);
 			sym_cop->cipher.data.length = pad_payload_len + sa->iv_len;
@@ -436,6 +440,7 @@ esp_outbound(struct rte_mbuf *m, struct ipsec_sa *sa,
 		case RTE_CRYPTO_AUTH_SHA1_HMAC:
 		case RTE_CRYPTO_AUTH_SHA256_HMAC:
 		case RTE_CRYPTO_AUTH_AES_XCBC_MAC:
+		case RTE_CRYPTO_AUTH_SM3_HMAC:
 			sym_cop->auth.data.offset = ip_hdr_len;
 			sym_cop->auth.data.length = sizeof(struct rte_esp_hdr) +
 				sa->iv_len + pad_payload_len;
diff --git a/examples/ipsec-secgw/sa.c b/examples/ipsec-secgw/sa.c
index 313919b4b5..86aeb25a49 100644
--- a/examples/ipsec-secgw/sa.c
+++ b/examples/ipsec-secgw/sa.c
@@ -128,6 +128,13 @@ const struct supported_cipher_algo cipher_algos[] = {
 		.iv_len = 8,
 		.block_size = 8,
 		.key_len = 8
+	},
+	{
+		.keyword = "sm4-cbc",
+		.algo = RTE_CRYPTO_CIPHER_SM4_CBC,
+		.iv_len = 16,
+		.block_size = 16,
+		.key_len = 16
 	}
 };
 
@@ -175,6 +182,12 @@ const struct supported_auth_algo auth_algos[] = {
 		.algo = RTE_CRYPTO_AUTH_AES_XCBC_MAC,
 		.digest_len = 12,
 		.key_len = 16
+	},
+	{
+		.keyword = "sm3-hmac",
+		.algo = RTE_CRYPTO_AUTH_SM3_HMAC,
+		.digest_len = 12,
+		.key_len = 20
 	}
 };
 
@@ -502,7 +515,8 @@ parse_sa_tokens(char **tokens, uint32_t n_tokens,
 				return;
 
 			if (algo->algo == RTE_CRYPTO_CIPHER_AES_CBC ||
-				algo->algo == RTE_CRYPTO_CIPHER_3DES_CBC)
+				algo->algo == RTE_CRYPTO_CIPHER_3DES_CBC ||
+				algo->algo == RTE_CRYPTO_CIPHER_SM4_CBC)
 				rule->salt = (uint32_t)rte_rand();
 
 			if (algo->algo == RTE_CRYPTO_CIPHER_AES_CTR) {
@@ -1319,6 +1333,7 @@ sa_add_rules(struct sa_ctx *sa_ctx, const struct ipsec_sa entries[],
 			case RTE_CRYPTO_CIPHER_DES_CBC:
 			case RTE_CRYPTO_CIPHER_3DES_CBC:
 			case RTE_CRYPTO_CIPHER_AES_CBC:
+			case RTE_CRYPTO_CIPHER_SM4_CBC:
 				iv_length = sa->iv_len;
 				break;
 			case RTE_CRYPTO_CIPHER_AES_CTR:
-- 
2.19.0.rc0.windows.1

