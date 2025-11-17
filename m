Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFCDCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 09:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7287E41148;
	Mon, 17 Nov 2025 10:09:15 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022117.outbound.protection.outlook.com [52.101.126.117])
 by mails.dpdk.org (Postfix) with ESMTP id D08E14026F
 for <dev@dpdk.org>; Mon, 17 Nov 2025 10:09:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThfJxWW1qkQleHdAsrDKvjcWG+dQVMrb6epP/u/7CXWZfGvbekD04pUk+OAEGDQ4LtGdgdUgnhNWdph99sHHlgMFzSb1mzNzCHt7vFQSg6pY7Fr13edPA7aK3Yg/vFJyXpGq1vHIhaTRASOYM6imisuohbsri3y8VfnyrZNykzA/DWW4/OEqi8Dw43MhNPcTVoOfFK638z5HL0oPIEog2JXRxMXaF2V1re/BJnUW4SAtlghONiCrDhprLwvQHa5ReiIaIIIyWILF0a10Z2IB/axab8Y80uoa8GBB979y17txmtD72Fi+0i7b+wJKvUUQRkIvj7nFW4PfsAe+htpLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOCo3bJn1zLWvuaanLaeh9gbXBI6yzvbVAgUbzc4gI8=;
 b=Eo0tbJjKVZkT0ISDknIPefJDG7FL7RHlN9mdlhu+1BzsXOR5haHquADAUGcxxtageaiiHKX9ef57SnmLhXslFkXlxUb4It3tPxqA5iWnN31qM9QmIN7CeAvQ6QZ5hWTAI/2EBvbssdljeqA9pP3+38tWe3UKmjch4HROktvNZ4GQ7saiVhd/3O1v9Ic1udJ1UsJqrLCj3JrFHr9HecEvoDtWQvn7dTrAucqTiIiMhevBD9udbfErWFcvLhzQA6GtyisvPk1HllD6INZvunoO9HoOWy+p6ixD51ydm7AqDqvvnaxyj6SV+PY9pSMag2RLqBB9/h1WCbzACTDaYbleSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOCo3bJn1zLWvuaanLaeh9gbXBI6yzvbVAgUbzc4gI8=;
 b=rZNei5eYQi9OvYnPQz5jaVAaiTA8SvQrt8U52ikkNf6K/hY85YHokiRWBHO3Syx4+C3/wdryUDzJDBYWkkpfacflZ5V6F7OwYyHcsEOEOQgX+N/iWH9+eyOgZ68MgxYPw1gv+Cpcc3wsnqYcUjTeHONabvq12MpbIoBG2CFoIRIsbvPMWWNRkYYAfvVNKOkg6YxdWyD328+/PJEyFH2ZZ0ybU/lLX42scvvaBcDcoOaCe7+547DtwVrH8C4Ko5HQlwiXgbXAoM595IFlfL17wdTQaEGm0iQuuMq0IamqeJvEMOLNn4zAI6mXnsX58pRq9Ze6Kmgv9z6nJRWCHtXGBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEYPR06MB6333.apcprd06.prod.outlook.com
 (2603:1096:101:145::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 09:09:08 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 09:09:08 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com
Subject: [PATCH v2] examples/ipsec-secgw: add support for SM4-CBC cipher and
 SM3-HMAC auth
Date: Mon, 17 Nov 2025 17:08:51 +0800
Message-Id: <20251117090851.54748-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
In-Reply-To: <20251114014616.43476-1-sunyang.wu@jaguarmicro.com>
References: <20251114014616.43476-1-sunyang.wu@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|SEYPR06MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: e41a2478-4460-45ee-14be-08de25b8f6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gWHoxTOTX4oWCMOogdmrzU4C5mgthB+Nt8Mxk20aZZ5H9piaTTESb+SD5Wz4?=
 =?us-ascii?Q?leuxHAWd5v8++/q/xsxIqzlTKySlvKUTalx6S6mmewDDOVltqsO87roMLAm5?=
 =?us-ascii?Q?+lrsJg5Gx4R+w3dk0ZQ0QWUGuPiQOC3NI+XT1882tj0lajqcpVjhT9lzQVWp?=
 =?us-ascii?Q?dlzLr5mJuQ4p/b1OgI4ZqbXRQDMgARYhg75PTDYdJmE5LMOBGT8ypHz4uSSK?=
 =?us-ascii?Q?vT8TKUUGxPDz1cjUgM3QkV6XDfo1Pp2+hr4rvVC73L4TEesXXOZmn8B9oDkv?=
 =?us-ascii?Q?5VPX1LNIpArE6ZpjCRFclMs0QGGPHWlL4CG3uycnKxjYGjbuuk3KD+/ZzjI0?=
 =?us-ascii?Q?jbGVrCmNlOaYJ9YebOa83elN8bE7Y+BqGVAj39GdtgzivJwGdSeM7zSxMIAO?=
 =?us-ascii?Q?/fR1kZdku0vo27HrVhziwtlJVTGmkqFsnwXIbMflbqjxMUOIYQmgPTTkLaA5?=
 =?us-ascii?Q?C3SJe5o903v25XQYQniYS0ZNdAgAN7j8NRH/yJhsSDH6rl9GDuChg3b1T7tW?=
 =?us-ascii?Q?6KrM8Ordh7JmIM8wXD6BmcMMn/luj2GYmPe4PJD7P58fsCR1CgjhdQQ7AJ/w?=
 =?us-ascii?Q?7xzcMXVPdNP2eVCqaOQDkxRdzC84/zxqa50wYabwHEmv04NwkH3T9celCrGS?=
 =?us-ascii?Q?udGD8GJ6ozppI2+Xk54LqtXPSeyEk0B44HEGdexxmI4PdIQLYTttxDhGHcpl?=
 =?us-ascii?Q?BZahT9YR9GvkW8YMTD/pwMRgku5nUHquIe0FKts+8fE/TPl4GC8G3rOg3YXe?=
 =?us-ascii?Q?eveBvy39D/Gb9PV6wE+VjBLRdHAjqzrE/EEw97RmYzhyeA7VZqBiY+ZiLwoB?=
 =?us-ascii?Q?4TK47p6q8U78EuuFjkclrpgg+eg61v9N9gqcIaTVcZSCll/FI4OzF3jJ1vjQ?=
 =?us-ascii?Q?N9oFFZ1vnYf0CWKhX5eGesUDFvjmIlag2iOC5dNNrjFvQYqMRcvA0QEqA3Lf?=
 =?us-ascii?Q?6shLjCgOWZbeWqmg4AfsyH/v6Wq3KExQIovVxK0mJuS+R4mZFnUPefkrH7a+?=
 =?us-ascii?Q?GNc6HdVbZuvTVUcoyouV+dWA9KRdltBgqB6yRuiixScOj2RBX2kLwU3eGzVI?=
 =?us-ascii?Q?HbKyFNOBsmzlWCifEijzTe3T1RSoMwxXXTVlmMZf7yBZKgAqZb9oe0q+bGoq?=
 =?us-ascii?Q?P0PTsVBIejFG1SK7tFr6JxGPS7xqTFm+ZYoVzSL4ajYGAQmkGrAsG/blV3uy?=
 =?us-ascii?Q?jIlteXD+Jx7ztCx07QGwfduIaAyzS/K1J0eyoI4UGLJJVv0KvBcJSudoSndV?=
 =?us-ascii?Q?h1ybWp6W888HT5WLLZyknX4a4Nl929QngeyYtmhXxyNpEMGI/idFNm5xNs37?=
 =?us-ascii?Q?mGMaH5bP3KGbopfAgb9vl57HsqCk9sh1sbmIqM48xadZ70JFaU/aAy6BL9XC?=
 =?us-ascii?Q?FrnbLl2oga7YPCrL8937wL5UfZpKvHUkQv7GUXT6/Xm6aqx6alNTDtpdvkln?=
 =?us-ascii?Q?RQtNPxgFFvHtiIiEky//1XFvACs0VXvtGEUN1nkislcwryo/qFWj33eRxrRS?=
 =?us-ascii?Q?eQjWl/Pec8/GK/CbeJ+fY3oZx3z0nyFY1GIJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCYoBsRk7DNMleVK3AqEC4YG+JOHWvApm1uSAmwKlvQ8D6m6nT+ePt8j+VMc?=
 =?us-ascii?Q?OQ2fSNT9qGU4CODiWoGt5DLUq4lBe7lT6FYa1W2vfqRXdhOt9zSv1KIdS2uB?=
 =?us-ascii?Q?mEWdP0F+R6nzscFdjjuF/ZBQpkksi53fUPTmAEz9rLUDwymvsQ/tYp+A+WWn?=
 =?us-ascii?Q?bIzDHn02C9pea8cDPUvVg/zclqPZdiUKht/XB52Phb6k/LmzlmZ5wu4ZraBM?=
 =?us-ascii?Q?WN1uUaWbFp3+eOc1X2KC0Ly4/YUAJJnKRfl6+R64sSMYOYMHz2JaICv77wSf?=
 =?us-ascii?Q?WPV7z9kfpSIVU2k0L81FjLgK93uWtQf1pDJEGSApBsIGfmn8qyDnwhgzLxVd?=
 =?us-ascii?Q?7tKr3vZwlxvQuVXX1gSE16t2w5P2G+JXVSjgwjiRQ6wJk9OccmhkMCNr3led?=
 =?us-ascii?Q?9kkEX0bRWFctOwA311EzWx63yoNZIUAzw9rjrHObKM0LHdENtn36aM1RqAoZ?=
 =?us-ascii?Q?kLmdYMAEsDxy80gch0jETxt7aVwLpjbzTlsl2OB+KeDHQ6Q2lG7scckuHWAc?=
 =?us-ascii?Q?Ula8xaNd9sl6ry+OCwf2onTtVSCn4ckjWSMfimKheLj5LAV2KhmF3+WH05gC?=
 =?us-ascii?Q?/rrk1ERVjezv1/onFcnLpAg3Dq1cU0/ae9AKd2wH6dIyF3F9A/RDAhjKUwio?=
 =?us-ascii?Q?JHY2B3cSSaHS3NNFOmsbGZZD++kBJwvyxjK1B1h3zKW1cd51HuidEr7Lcjg5?=
 =?us-ascii?Q?2v2IeEIrfkBcAVPZh9LoIm+XztjSBsv1zJeyaFVD+WR4wAAaZ0kKFvKprDOs?=
 =?us-ascii?Q?YZnc95Mc41SKO6qU5DVGbJFBGPCNnI/+mBavkud9OzTQ0AvLYwUYYd8uqyBb?=
 =?us-ascii?Q?mbBAQDbWDR87OA/aduuakceWQmN6FzEO+BRnAhGSxDE714ybHF8NkjN/1/+9?=
 =?us-ascii?Q?Zo65rxNjKf3e7XYnz9v40cp9VbxCVq9DhVg/aGLV84n9nExUGwTdRSEuYqay?=
 =?us-ascii?Q?KvdZt63Kj/aRM2/fgEleYH5/NCk344Y3GCwOz/R0Bdt/BomiC0bgFfUg41e/?=
 =?us-ascii?Q?O/+lABbBO0Ls/a9hG6mEZgzjSWboA4hIsEvx4SdVOvZBUalv6ROm+N42snLU?=
 =?us-ascii?Q?ijGsU1O4FiAhU9DqYx1HikC00Buph4lLlrchXbxpqrQi6wTgT90nTaJWVqKp?=
 =?us-ascii?Q?wGOtCLtAxWXE/M6PpzM7EK1DJIDE0dA2dZhpZOmvBzT0udGqChXmRwh1ywhk?=
 =?us-ascii?Q?wwAap3aOI2Oac865dRke/WSdtJRBhTlIBIMP4EsFqP6FwqS9KAHpU1n8IGE/?=
 =?us-ascii?Q?N0Stvznz3FzO1YuDkCeuUVqSPfxpqrzd1F5DCGREayMsq5McglnHkcV56Jw6?=
 =?us-ascii?Q?puXx/StVSuFC1co6pSZdlVopADbEXd7Z2wdGm0UHQVEhn1dIuqK+EVLBbeT5?=
 =?us-ascii?Q?wxXph2oZoJLphI8nubuvhQOti6xATIapPL5+pt3R0WKffFmfsTMT7fDq5wN2?=
 =?us-ascii?Q?cyuRqqmpNlCuGZZKobO6OQjIlRM+KpPOuAS0TLyVG5eoW5e9h0Ll11qL6jXM?=
 =?us-ascii?Q?v78nM989Y1nxCvFXpVGKoteMjlOsH+P9a21WdO7By77lld0Sn+H1IbBoVnGF?=
 =?us-ascii?Q?Grpj/ISjYJrT+II+7XiVq17A9s13jbax2VH8NpWJHLtWwjQCxvwPqyFNV8Fm?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41a2478-4460-45ee-14be-08de25b8f6f3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:09:08.2672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juky6RXHlu6CdiZSsyMrjEn9Hx0PuD1/qT5hwCowE+nzRdfarCV7VKwTAFJ+Pd7FXFH7iL4uu/8QGhUxB2F4dWTJZZKxeC323QBLrZ+T8fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6333
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
 doc/guides/sample_app_ug/ipsec_secgw.rst |  9 +++++++++
 examples/ipsec-secgw/esp.c               |  5 +++++
 examples/ipsec-secgw/sa.c                | 17 ++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 7319505fe9..7c31c96b7c 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -576,6 +576,7 @@ where each options means:
    * *aes-128-ctr*: AES-CTR 128-bit algorithm
    * *3des-cbc*: 3DES-CBC 192-bit algorithm
    * *des-cbc*: DES-CBC 64-bit algorithm
+   * *sm4-cbc*: SM4-CBC 128-bit algorithm
 
  * Syntax: *cipher_algo <your algorithm>*
 
@@ -605,6 +606,7 @@ where each options means:
     * *sha1-hmac*: HMAC SHA1 algorithm
     * *sha256-hmac*: HMAC SHA256 algorithm
     * *aes-xcbc-mac*: AES XCBC MAC algorithm
+    * *sm3-hmac*: HMAC SM3 algorithm
 
 ``<auth_key>``
 
@@ -820,6 +822,13 @@ Example SA rules:
     src 1111:1111:1111:1111:1111:1111:1111:5555 \
     dst 2222:2222:2222:2222:2222:2222:2222:5555
 
+    sa out 30 cipher_algo sm4-cbc \
+    cipher_key 01:23:45:67:89:ab:cd:ef:fe:dc:ba:98:76:54:32:10 \
+    auth_algo sm3-hmac \
+    auth_key 01:23:45:67:89:ab:cd:ef:fe:dc:ba:98:76:54:32:10:11:22:33:44 \
+    mode ipv4-tunnel \
+    src 172.16.1.5 dst 172.16.2.5
+
     sa in 105 aead_algo aes-128-gcm \
     aead_key de:ad:be:ef:de:ad:be:ef:de:ad:be:ef:de:ad:be:ef:de:ad:be:ef \
     mode ipv4-tunnel src 172.16.2.5 dst 172.16.1.5
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

