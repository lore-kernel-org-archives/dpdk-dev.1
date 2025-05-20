Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9CAC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6476C40A67;
	Tue, 20 May 2025 07:52:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011047.outbound.protection.outlook.com
 [40.107.130.47]) by mails.dpdk.org (Postfix) with ESMTP id 0D54C40687
 for <dev@dpdk.org>; Tue, 20 May 2025 07:52:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcAbrOfBxnwU0qgazOdWYFBSJdkzkb9H8pwhDTKvITDHu2N9j/CfW63qwVY1zKo5h4zAVka/IRH1v+cwDcQZERHIWSXkJ/VeiBvNI1pFeAMUiyEbx2la61IiiT6S9hq8AtVzYbihkcJ3KPN9doQWopmo0WAxx18uIpsFRgAIMk+DStdOEkFEVGkll6k0t88zmKRypcTCphlorVZrC2kRLGcVHyZ14XGIZuHi2+gJc/09lSCoweeVDoTfbySakkbMFBpZDiUqF9QKYm+/L+usIKmYjJZbP9ZjVtEZ5jKEH8EaKJivEgEuOarRDg2NFqFmoJcxCAng9V1Mpforo02dGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVXMvFMTPLLxWuj2H1OP4DjC1eHimeQ75tb3YhFuKlI=;
 b=Sc/92Z1hDOGunzS7hJX+EbGep5RIb50Ew8UaDYtmXASdgSUDpHsXD37i5mbDEm9zYAvGcYh6m344beH/XDNbFdqM2dXm8YZ55maACn8mjKTq5X+XNB6sJnS2BzCj2akMIGwmqg/S7T+/GJ8lGAoZXBoHwoF17EQPGDEBDV2QpfPCKuRvokGLRTn+1XIwnxS4GMRqySKj8GmSgAbpYiKeKdTVAXq9Zzw/cmBsKoZpTz/HmIhkk3RQ5RFc/j7jCRx+Xvrf1vVB05qb+Hph7e34KI+CqVK4uB8CkZykFZoLAcXJUPTdOPpmcR+n/yAwtp9SYFBF6WXOr8jguK1L4GeyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVXMvFMTPLLxWuj2H1OP4DjC1eHimeQ75tb3YhFuKlI=;
 b=C/7kZuDzFtcDH627mrpQ+J1Fj1uNeDGAFyhUXelpjM3EghH9hDWY0wm3u/aJmMFzQCanL0t1YY+BxFy9v2I3GtsOY8GcSofL8k+6sbVGAlujxwRNDXCqDF2AuKxJQmWdc9w/t353Fn6cQNFFIJrmxWPIiRgDM72azPvfn6l8BZHpbO0ueoe684/lXBphml6YwZImnqIfLUNDysiCMfZv7l8CwLm7Vo8+BPj14Gf+xZz+6x2qQzsSeh97wuTE0wTqhkDUFv94QWjefME0Bp5Q4IaPYncnTiMVVSn1AyrPWM3TWe4CvKe6gJ4Lvp2Xt2NfD4UhVtoNo2RLOaUbfElXWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 05:52:10 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:10 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 6/9] crypto/dpaa2_sec: add null algo capability
Date: Tue, 20 May 2025 11:21:30 +0530
Message-Id: <20250520055133.506071-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b309fc0-2358-4e0e-e36b-08dd9762760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xDbHbcNcbP5+SpkWa7fCS1E5zyKV5C9n79f//M/ACkcaJD5JQIipEoZZrcf1?=
 =?us-ascii?Q?L3YT6Rkhtn67U/oFSO2UFMzCnNCbAl5k0pmNGmKJkjRX/i2GUYIa48m/TlDQ?=
 =?us-ascii?Q?Z4dxlKaBSR6DhVcnF1fUOSqkJR3AYTFLLEjC7+efiUGmiAtmjcYC3A8UxoKq?=
 =?us-ascii?Q?19fNWOB5hdiD01d8ICJV64IgGUMki5dxwUh6emvKnWA+d20eEPLuo2CQexgZ?=
 =?us-ascii?Q?578zEBrbspWxPgBfODrSZCDZCnwneY4vxqK4bMiLD5G/HJ6P5dZezs+s5lr/?=
 =?us-ascii?Q?PumFPEsFkHBozHVqD/vKre/OiGSjlVLsblAylJu1wN9yg9CDo5xuytBQUz8s?=
 =?us-ascii?Q?TCYxSCdGyZFEL3tMBX6zQiuGvxpo3c5IDYisXArfsEgDx4v2Y2TvsPzWduCp?=
 =?us-ascii?Q?HyeDylKhNZqGtaX9IE2p8G781RSd52mvzqMGr4wGSwWpqxFcziPW9RkgmoTv?=
 =?us-ascii?Q?YWO4UL3g1t55VtcuIQ2mlka3A53hYtHJN578vIkP/3ap+RTutWQDWKHT2+3F?=
 =?us-ascii?Q?sHUHsyKidrHFMH6rJeZqMP+bUBbeaTdiEwHftxGomAYP8pEeZ8PBJWVxXCiw?=
 =?us-ascii?Q?1LECg4Zi+AbpXwx/vA1341FwMNVdDFgna98V/ntVKAXHtpc7q8gXGHjIsQYj?=
 =?us-ascii?Q?yyeN5LS1S2VEERtNjwT7fuBl7yjv9GK5HAQ1P3qkgldc3vcIY6Fzk6GSKno+?=
 =?us-ascii?Q?XKNoT8SE6yVAOoyM8cpOMBX/QuXIdllq66Nj9WN6u0F+9XZPCGGdlkvZ2rgJ?=
 =?us-ascii?Q?xy8UMYQZjIcsIXFIEzxvA9KmRUWo4NoK1jAaBHKjfVluGPuRO8/iLxrwPXNq?=
 =?us-ascii?Q?UUkPaH+rdaPszEP7W1CwnAXMLcEPjcHR1umQL6zVRuWNxJMzvncJD3uQPOzD?=
 =?us-ascii?Q?zvvJjH6y9raxgHEbQVeIYZYrQfN5owXkczIU9+mRcz5SGKe37Fzy/Tjq+R0w?=
 =?us-ascii?Q?KtXbdUbNUdYLOpJ8OCTyBx6J+YUidpuRkoS57qwAjuOqE/7ETJYuUjysfoJg?=
 =?us-ascii?Q?DBgiTDSAoiOjWtDScoE4sgjZ26ZZaJEwZdgaEmLmcVaaLB+cappLZiumy8Ho?=
 =?us-ascii?Q?YlAyW/kiPjqRRFNg1EES4P979fTwfthqBHX6okoDUxjZcmkhdANn6Dd0VABs?=
 =?us-ascii?Q?Lia0bs8QPDDRN9iD3Bf9iROEzuDFY6rOaDMqO0lmRRpp9HlgGmPNF010pMJp?=
 =?us-ascii?Q?UyqBLJvqTGr3koDHKy8BRqv7hbncy1MJq8WVnUQquEDx8P8YhXYOEQN70fC+?=
 =?us-ascii?Q?G1H98fF127v4XEU/1pEASucbriWR843rng7i1TivPC1WGXRBbbYC+H1qe0rw?=
 =?us-ascii?Q?XmvEN5BNROjp4dg6ACunJr6m5SooYvwtPfcg/MhfB9UvHF58hpuTF7oPbNzb?=
 =?us-ascii?Q?i9YSB/NhiG9ed6b2T/DIV0nRdX5wkaVL02NSg1ylrPhPP0SQdcgRbKfnNHd+?=
 =?us-ascii?Q?bipov405w8+L9VSx+IeQySTCbgefiHzOIAx76HvFGo0TcjMn35Ia9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIv8gnS1Ff5xdP957NpaH9C1zp4rCbkaZnx1erXGiyNS/9zUEaZsdFq1VfEj?=
 =?us-ascii?Q?Q/BgWCJXiJigee8a1HQlGbKUMksNH87R1cz3gkp1jFPiecAAEu2Ja9B/dHT0?=
 =?us-ascii?Q?3qVKxCn2+yYqIXMK7FEfmxNwuXFUbPYLP8DU8TMOTyXk8IdxLNtb4l6y6UxB?=
 =?us-ascii?Q?WqpeIyCdq9FNsDCfvMoPHTjhHmqIg3rNzFLgiT+WaqaSd3aViMtZaoxoosb4?=
 =?us-ascii?Q?lzsU4mEYSZcJVMqPkuhn87TVzLQ5gPAq4t83s+x4KmcS7qGTJKpXaO+bhRvZ?=
 =?us-ascii?Q?LcJ5chg6LV+5Kx2b+xety+VZFrnzFnVmE7/Gvyk+PG+4Rayla1KkVHIMxbII?=
 =?us-ascii?Q?DebuBlHw0uAvS3mlgXZR8dY6zDgNNrm4uvseFEIL7DQHR7E857/6AL8elyg5?=
 =?us-ascii?Q?iWVC6so6kfTt1kh4DzqpeV4PBJcx2i38vylwxs4nsiRy9cmltw7gNqrfxdGW?=
 =?us-ascii?Q?34ObPw4M2WWS3v0oTXclDv6d4q8cg2UlwBelIQhEdhcnh55TLX7JCJdX9Xf2?=
 =?us-ascii?Q?5FfBwOY330Us8Lpi+mY5U7D0PpQr8PeB6Fp5Yp9Xnyeyny2C8JNnx1EHFGJR?=
 =?us-ascii?Q?o4xogW3YmMyyO/C4O11NnVQ/w36nyCYZS1baa1y5NyDVjI0E449UdMihMIho?=
 =?us-ascii?Q?u4/+mIVndaLLn0IWdxvwS/CoTYtkmA79Ml0IhDU1/kyVMAAe0K9Mmr9hJPXb?=
 =?us-ascii?Q?dnhZdps+RsWbRtqSDBjMG76q1Ulr4h2VA6tlpyYbijy8EKHQzkqCJIUyykmu?=
 =?us-ascii?Q?cT4AUt8v3X+MeP31R8KUvqMiKU5xBz6z43I8Luq2QbgyczqZ+5YtyMU3qUX0?=
 =?us-ascii?Q?eDpICqb2ECdIa+wsU+ju88O/HiwZbdKXDJxDfzd500p31/zmyPnfUoFygTwd?=
 =?us-ascii?Q?1egW8YHZ/ghL78/1s8t5Uc5ROM1Vm16Sj6OLQlocug1juDlqbk76dKcMYwpC?=
 =?us-ascii?Q?TwfVgHOm4P2LkkULEA1nnKyKxgEZMedP62dmzvBkgMYqROZBzTPhBZMHaWbJ?=
 =?us-ascii?Q?Cqf3MAoHj5X/ad+su9EYeiIXQ+q78w+ZAdpqO6Crq7Q19adA/IwX2jbzkT9U?=
 =?us-ascii?Q?mpEI5pLW594dNuAjuDLGKqgVQnEnN3ctmkCGnkUXyZl95MlbOoquQFE1NR0Q?=
 =?us-ascii?Q?nDWbPo8tFgAbLc3lkT9vV6r1tKHdtHUlrxxriw17r0gu3mzJlBHTJdbyq/20?=
 =?us-ascii?Q?J5HtAuUC/FJ/S6QgQSAG6JrsYmR+N+fw0jXymJKSd1ssUViw9vxqm7hYnIRs?=
 =?us-ascii?Q?gSz7ml9Ry7KwOHAEFplNR90KvwnIOyjANawFvDkWr1bb2NwKBTBImJpszkV8?=
 =?us-ascii?Q?U/xIISlr5j4UxV6+LPVp1hBwo4VDw27igCmc911Zszc0X5As31gGlzjRzLnO?=
 =?us-ascii?Q?ZLaNlknhg9wsHL3HOv0jjf8cwggL1QcCJ3PwmEpLA0F/4jDup4gvJjNfDOHY?=
 =?us-ascii?Q?/e6Mg/gXAC0f77RDpTlLkKD7Wy3dKqwrC2wo/1sd2Qm086nxvDfKyTZYCpz9?=
 =?us-ascii?Q?qfaA9Iw6OHKV97tv9/odTRCfPTIj7MsbAZCiFMUNgMVkNTbUPXRhQddby3+k?=
 =?us-ascii?Q?qI+QrUMRBNC4Op6J4wM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b309fc0-2358-4e0e-e36b-08dd9762760f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:10.2779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfa6JpLA979yZRIJkhbtndzd0yZD3gYMIGOKapFyFYzA3ss6oVOLpN0E2UOxu/vP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617
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
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

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

