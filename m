Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1ACCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D86A42D80;
	Fri, 17 Oct 2025 06:49:19 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
 by mails.dpdk.org (Postfix) with ESMTP id B4D5C427AD;
 Fri, 17 Oct 2025 06:49:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMv1mXovbVS+VRLoQZVy3Hunpr1MaRGz5TDJfAoyQxy4bmnnk5er7Aj/zLtHE+A47B1IxvjC7Ths4RpcGy/FUjWbyKNf9D5A1mjF4Ynw8ftDDMArNGuUq2aJTcr786MbIMe9A5x8CcJRVoe2VHh0VJjckqv9/F5+Kyh1znSPZvGpKWCrLXj1b95XsK20t2XKBjyI+PGEjKM+mjVbQPan/TNcgOOA0E7CYae+7UEYF6dHpwHKsnOgZBAYdY8A4c7fW0Jg4rqKr98cHxevFuiDqG7pFl8MkgmZkMwVQPRlMa7sWLyeuliztxayrir8lKRsZ4LC1Nd2e1dlY2Yk8foDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2LdG3dDSIDoHYuThSae42cKcTQzeIcXSb30wxISp5A=;
 b=pEHIcdKwNhrxZZAnhrlZwwf8h45XJ2kpbPCV9q4RbFq/kpsASpO6udJ8VUX+dKGPawFwemDCSAACTFy6QwoQeLW3SX3edrlGgkIKuK6X467m2iGqnugDX1mC6cyM2QULBNW7uJEo7PfjOtlgV8L25ektqNwQP1SHsvYMVHbU8QnUGBK3oMFs+KJL1ZLR+MLXV3oe1QitpT30EyGrPm62sMHTj5yu5fa5ghOBIcUMOb4NfqOPTiRJEOpwCb4Ddoeh++lxLOhvtfpVOq1ySB/iDC4WdRlo2/K0rSAlYGNpgDXjGRIMsX/hivUP8O7RipV6gsB7YIxfCtz36rDyCuWQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2LdG3dDSIDoHYuThSae42cKcTQzeIcXSb30wxISp5A=;
 b=L+hH613KFnL5fAyEyi2MWXXM1wOTXOJQlyk5frkHxihSRSsW9r2oD1NmE6f/OH3CTzWCj8JtrkO42yIORzAT5FCHNLj6ucZ4fuxaTMjtumPDglxAO7Dsy82KPunar/lxJmxEjVSOAZQm+AIOPlXBWQTkK9xaHies9OVKzyuQB7uCfnyU0sWcn4FiZgssIh/kCw4uDHKQK694e2RpXZcOl7GQtPIaLwsxT6qUpl0rHUguKvMwwBLEIGaDlknhZ1ODAv9cVH0mY2HCnqW20BGcUmmJamxSwfM0O3npcPDcb+Ax5IvcPqQ32rpkbIL8xQRURVMqqPlfvPeVPV8cYUbt0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 04:49:16 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:49:16 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>,
	stable@dpdk.org
Subject: [PATCH v5 6/6] net/dpaa: fix resource leak coverity issue
Date: Fri, 17 Oct 2025 10:18:48 +0530
Message-Id: <20251017044848.3269627-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044848.3269627-1-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|VI1PR04MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 84102a11-7fcc-4cb9-9c17-08de0d38869c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MT39VM/45k8eBOaM7QGqWPkWopA6tFYYQloW/prLxloVWcLO/+Gww2P+nXai?=
 =?us-ascii?Q?SxouYYB3jzB1md8VA+/hiVJoaiN261rHfdpCr9puPeDMlAXI4TaSC0KGHyOS?=
 =?us-ascii?Q?MGSN+UDuajhnaNzS/g6U+V1l29pDuebsX+dXiTROrcaN6W5h5ltL7vV1lNhk?=
 =?us-ascii?Q?2rcLbQjiRCyk1eh0UFI5eRFao4GWx/h2WwNfeMX+7P0Jj9VFZz9pVWMsGd/Y?=
 =?us-ascii?Q?9wAaUiIoUSsREtJuX+Ucck8nHgBHxLTma3+GIRgp6d2CdF860NKaKC2ab2yi?=
 =?us-ascii?Q?A5r4gIwdDQJS6xjy8RVhEA5pDCGn8FxdfW1iQ45szibxB8VGtl5QiqyL1cAs?=
 =?us-ascii?Q?0fhWzVhKDwpqFlqETFz9TGWWs8SpkDY4A9qg9ceQzSHI1wHwQtATH3yx9II8?=
 =?us-ascii?Q?wdZI/uco8XtWitDget26J6JidH2Xdp29laGiCqZaM+rbqPutSMG0KnESAzp/?=
 =?us-ascii?Q?qjH+J2SDq3YpEVSWFpqH2Wcm/fRINepzkPQeku5ik2yaSBgdfWtsu93IBq2/?=
 =?us-ascii?Q?b8W+eMIvT7cg9/pCpyKlIZ7LSrrs0AoAAdhzcc8WXmTDGlK3nnS2l91tuZxT?=
 =?us-ascii?Q?/cEVe6p0y41y6ZxeSm9fnbGhZFjTKeKNrBS/RGAJZ8oTydo9Bbd+KVnxB0Se?=
 =?us-ascii?Q?7AXg/BClwjQTtmRnh3jz5IaaRV2LHpu+UvR/a5CDer9R+mtvIiq6Jjj3ZBgT?=
 =?us-ascii?Q?bfZWrEQaAYjkVzHOQEuHCHyWqbmF14R/NG8nhr+pnxbLpN6tNUzVWjr++YB/?=
 =?us-ascii?Q?AvF3dyNttWoli0S4kax8gb2p9O/XYr+dimr1uJvrG6cwZi0z+87I8sHeasia?=
 =?us-ascii?Q?vMU9k177l2DVGCTqGenhHNFTlYUAfx7ygp0IZsBbBT4HNy8+xmAqpPxLif5J?=
 =?us-ascii?Q?qGkE9SJqHmtxGdvo/9VaG+MS5fDkAtrGsGVMHyugw98+Hyi/LlQB86+esKmH?=
 =?us-ascii?Q?n2m2RRI3h/EavsFyN1c1aZGfNslQTfmdlrp9TxOwJe4iDLvlsmcDGA1FWi4+?=
 =?us-ascii?Q?IGkKURmBt5b20+aNShQpuKF+ldBJn8gthLsZjZejM6akTJfJAhgKZkS+jkKe?=
 =?us-ascii?Q?7VmaXkS1fyqpPAWEyNSwSjT+7Dfsn5bsu1dOell7eMgip3tyR+9i6NuRJ7Re?=
 =?us-ascii?Q?TrgdcQM515OfE/WF6ocMc3BUgdW5hc8pDpQGpKzecbtEQwsmhgxTNa/96SA4?=
 =?us-ascii?Q?BY+BfjGI0qYD2loznXh3xDxaMv6I4oxdIsvwhNjVbLE9z4cpPbZLYnlBAFQV?=
 =?us-ascii?Q?85qQFJ8mrOzytAgP/wyQgUM5CuXiiH4L6x/Hp1x5AzsyIa5OemAnL4pAyWvO?=
 =?us-ascii?Q?uN84p5J2Nvwrur6M2jIYv6E0j+zopXjVibVPlLGUxiyXVuHH1dBKvtlbRAxG?=
 =?us-ascii?Q?lkXJ/3ouQ8sP9B5axNCoB5MTBPijKf5sAPmuULcS0XVSRyp+LnPphSSIGKXx?=
 =?us-ascii?Q?X5bm8/QrjiqNIiEpJn2aolJ+kBKESbX4DhW/VQYDV2zSY7zvPFFW7d43Bwjt?=
 =?us-ascii?Q?fhZdOnnCgRFkkzA7mnmmQfH0r49QQXWueCbX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjLP+nxfGkdOOtnYXmRnFXBFFzfcSNm/Xfv4T/feLqNHrqnx9HQsg0CUuxcE?=
 =?us-ascii?Q?6h4esJqwIS79tcdkivMYZPFzUVJWjcGKybEfYKNXgrvajibwbZVlK9dLODMG?=
 =?us-ascii?Q?A/+r6HXBJVNTiDmsPS3+qu0O7TjojtH024Ia/KPxiWjRq031epIWk1TsWom2?=
 =?us-ascii?Q?pbcaOZ0ndqcgxWZxK4ikP2HNyPG0j1T7nZlpbqaqP+vGVBsMwwyTwadv58+V?=
 =?us-ascii?Q?cBv83I+PhyNL6anBqq7O25BfISh8EyaxI8+iC2HFcnqjDDTV/fcamXhsigwl?=
 =?us-ascii?Q?ZWF5eP13XaonXcjdoMliqoPZ7mD3jyfCyS4ag+2tWz/tMpHFWJ01rkFLqNWY?=
 =?us-ascii?Q?3bAKuInrA3JJeOTbRdQekpivCIZ2GlQuBv6JlU2VA61NPHlG7SvQPTOl6+/g?=
 =?us-ascii?Q?7W2lnCFPHKmGBG4+WOEYXj3qTvZ/ZhcXVQXrCpCnhYO5ch1/sOaQCAKGSECr?=
 =?us-ascii?Q?9xV4O4FXit1hYiZtTMaFOAq/inqbpAuZ4KJW2Ge9hivmeoLZmB/e29UWRP5Y?=
 =?us-ascii?Q?Jl+amx6jjk704wkuj5qtMz4njpEq2uqCIUtpX/nmA/2hAd38MqhkGu2Fydx+?=
 =?us-ascii?Q?ZR7AeH9EECJYRTegMXstRjfz8Ob0kCyZWavelrbOumnAz27k64x1SM7R0mCf?=
 =?us-ascii?Q?CvWpwiLp7yDgfJK7qptUlxNA5wf08pVPUbipAF8wg/DAf/ih5jYSLCuRZIoR?=
 =?us-ascii?Q?qSdfuSDonD/mPW2vUXF7kXiDRJwIgKNPozsxESbm07cKTcCkEyICtlNCdftV?=
 =?us-ascii?Q?HBIyHxRdtjyOogm8BOa4gFbonaYeSV0gtUdfVFe/oiW3/Dc1GzTHOzzkEKKG?=
 =?us-ascii?Q?OP7EjreuOkDG/h3glI5McpagsT3I8MlHbyeNSXWgnsNfegWnZuiTloIyARKG?=
 =?us-ascii?Q?ccOEi0pPmPN9IsmXe/TvzGMPB33q9vgMTUANglOXuGCFgi/naCdlJzDsfok3?=
 =?us-ascii?Q?XoTo+d8j/rY3Qlv1RoocSuUe0aftIAOT/IEhn87EY8lv4e3k1i4o7ID8g0bv?=
 =?us-ascii?Q?5gIxWvq8Os+DBb3AOCqOZC/0g6cASfylQAeBDhCmwjRceEIo8oXUft7X6/ko?=
 =?us-ascii?Q?xgGn2psXyvoUMC0+Zd3ESJ977TRfWFNuuAIm3/ZpKavAEPyTPL4SVh0kS2rh?=
 =?us-ascii?Q?IEVp2EP6AiC6My98yrv2XJLEMsZTvquOxEc+cQy3BNm/iJy2O1fjoWB6xhMs?=
 =?us-ascii?Q?R8ZkkW73zeeP6xVIUECH6NERugaAFapGRtSdZ6NxGCqj2loL4QsNJV8bxFgJ?=
 =?us-ascii?Q?TG7h8pALRUMbTfLxPMS8PrVnuTN/twN4NusHsYbmdV7efNvBPSWrH4lF3Tzh?=
 =?us-ascii?Q?XKs55ZwTVi73qV4fUujWnaj80bsklUAlmK4OdtOpgy9UpH8WkMT5f2YRwHZL?=
 =?us-ascii?Q?Qhl9qKvc79nLfjmlPr18a3OwNWPZRFzxXX1sY9miW++X8F9GX5rlBbVL/sVa?=
 =?us-ascii?Q?TXIwjmoAwCdb38aqDSvwepd+lybhs/ZHT+JAzVSuCUwe4aF5IcZd0Js0Gm7C?=
 =?us-ascii?Q?r2qRHIRw4C3XuhsoRLkE1aio7kuDYX8hzKWDLCqyd7PNR6LYQaHTynZwSFvK?=
 =?us-ascii?Q?lJXjQhVwy50gwJ58wNPbTBwh8RkwKkmZvgPx4mlK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84102a11-7fcc-4cb9-9c17-08de0d38869c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:49:16.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYlV00p46qJSggUuIzRJV1bJV6zJv5NYtgRHlLt+DSBxxXQGUPFadUndMh3GaiDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Fix CID:362787 issue. This patch correct the cleanup
order of PCD and FMan handles to prevent resource leaks.

Fixes: 4defbc8cbb6d ("net/dpaa: support FMCless mode")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 2a22b23c8f..417b9b6fbb 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2024 NXP
+ * Copyright 2017-2019,2021-2025 NXP
  */
 
 /* System headers */
@@ -889,9 +889,9 @@ int dpaa_fm_init(void)
 	/* FM PCD Enable */
 	ret = fm_pcd_enable(pcd_handle);
 	if (ret) {
-		fm_close(fman_handle);
-		fm_pcd_close(pcd_handle);
 		DPAA_PMD_ERR("fm_pcd_enable: Failed");
+		fm_pcd_close(pcd_handle);
+		fm_close(fman_handle);
 		return -1;
 	}
 
-- 
2.25.1

