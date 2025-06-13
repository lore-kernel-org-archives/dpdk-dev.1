Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D7C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E62242E5F;
	Fri, 13 Jun 2025 04:11:50 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
 by mails.dpdk.org (Postfix) with ESMTP id 8BC7C402C1;
 Fri, 13 Jun 2025 04:11:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt2CZfqZiZNCUaWttYJ3ZYcAdX1t8waFXyUP6KGL+4mtjGY+m3cIqEDGMdKZdPkdfMWYNSnqw9/w527NC1MhimNA7jDQIIFDWDEdD18T+YlNqDFs+Kt/LW3BxrUxIBX6g77aiCf4Pu0AUaIrCuTZLA7bRfRsku5dl+60LqC1VHUkPwIDtcAUxM12PgFbaZKAYBPm6GVBxkEfyH/NtOgs8JATTQh3FbVtopMOvTimtrg3CW75k7cnwDpFjeUPoACVxKfenNrdJybLbh/c/zgIwhGJlQHCnj49KzMFAl8HADeSyrN1JzX0+Dertnm7cucPp6xlwqXhu7t3hmnCyJ9bmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=Qpx42zXuwHNDCGZK77TBegkP4rvU2kuYJtCnS3jrQUIKo5kchJTyo0kVSePg19S0OptUNdNeucyVw86M/QWxwdT8mtrA8D/4p2mfIOBD554jGWvr31F/L17ulqIQ6lGg7E5w+0AHTJB3lvCx6+HCEYO44rFgbda6Xf7lj91irZ7G9aPZ6/KTZZ10Ph3z/oagvlrHdxDifWaK8ADJvCWJlAbiqCtAzQyu6Z1euiYqipFtyiVUpKhtYjtaG8Pq51oJgK3Rmy7+KK+HtIB5KWHmWi1B05Rn25VqklG9DoSmelkddZxsU0UbDGKHk830OWcC5klPE5haIAN/glCFAjkGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=dcPQFplgLzDb69ewR2r7AFATexMiFlr8JcenkSrwgDbZzs7o3spOACce3KjUkoNyXBo6V8O1cTu2hWQU6sTVJOLD+W8BCsGSAdw9c8+TNyaq+pu/0KDGdCRM75+XSovsK15KtVOfr8/U+4odWRTkr4BBLgun5X51BHedtlCL6NZuupmwoNdzFfUQzkTBHEqJZ932AKvl0EMV9rYINS/3YuIlovK3+yYYYK8X00m5Ix5PvHDAn1+UFsmjxN+T1M3U1en8fINx9/Lu9Zm3TiZ7M8qbLAHViBjqhn024DiQ8mvZqPjNWHQ1YhnFrVcRF/tdyyA5JEH7HtM3NcI513XI0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:45 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:45 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v5 02/11] net/dpaa2: fix shaper rate
Date: Fri, 13 Jun 2025 07:41:16 +0530
Message-Id: <20250613021125.790614-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: cda1994d-23e2-4afb-15dd-08ddaa1fa58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4kVELI7KTlPQZlUoSba0Yaj/xVBXoCPGO+9SlHiaH0k14vl2jxbbEmOsRuDQ?=
 =?us-ascii?Q?SYtSzMe2SZnzaSnK+/EWh+dECnnW1DfaVaJ5t3Q3PZWb4JH8ShaeU90Wp+qs?=
 =?us-ascii?Q?eJwoQVnk/7aSq/840hvIRMHM52lErry6FDa75jqtbsNtSrlc+ueQzkTSzQNB?=
 =?us-ascii?Q?yn01B4JpmJfCOpNu4k0HBXD32rzDOOZZJe7kHkmuXd3/P6ly6vy04keVOJpk?=
 =?us-ascii?Q?BioEr3Sc8n/bHtjnyx6gNP16MVJRUkfeqCgeOJiZZJSRVRSMyMJF0j6d7N6j?=
 =?us-ascii?Q?A4iMl5ed4S14P+DdySwzVrL9OsxJ2TARVbAbJpZw/gocevUOaFxA+Bh3bVIj?=
 =?us-ascii?Q?csv+bHrMwKNXn6N/JEhYySL5DKXAOwe9V+RFiIsZUA/fc+2lTZew9NQ5U0S6?=
 =?us-ascii?Q?wB+7T/JcUsaWZ5gtVWxCV7KfWux0rOtiGLziTn5ClCCwddVAOIsqdrOX7PnS?=
 =?us-ascii?Q?i+czsPoxRyjrhTGy9xFhpmAfMFFGl69f9O6GARMxkMv7LByli4DrC5f1DJ9X?=
 =?us-ascii?Q?/sHzD+r4ER77kKvnuoJTJNAHA5i29zJKs0Kw5D4ZWHFIwv04vfSjhNwANUhv?=
 =?us-ascii?Q?Sj2fKdLaQ6Gn5S4cC43AidSclHsdNh+URJg5cP6wbWm8KDlPOynB4W9l830Q?=
 =?us-ascii?Q?xfqVTFxhSS4LkSHerHXc+MbvOAujTlNTS2dSQpdltY7/SmZTBNlrdrSFGMLs?=
 =?us-ascii?Q?pyJ+PXlTsPhMFgGT9QDo+D4BNfjr0H3WTHiuSmoUqMRGrgNlk+6AjYnvRbeq?=
 =?us-ascii?Q?bP/PYpXtESZQHy/VfjVP0WfcHfLP36vhlRLpl3SDDUxnBk1lbdTe2lyztE+A?=
 =?us-ascii?Q?/b/EVoiNY6WUzasK6t+ecFWv2qHrpra7KdHU+A+XXJ+xPIz1CDoYDS8ysT5z?=
 =?us-ascii?Q?nnjhDgS4s2OnSJgRLs3RaHZEd1xIBWY42VbxZ2FJCV5tHTpxgJxMIgmbwAcu?=
 =?us-ascii?Q?GslVwi4Pfj61O6hvnI61meytSTV1h/R3VAgX/RRfNFPxcPTi48Ryq3ESPE9k?=
 =?us-ascii?Q?XoULC+bO6onBj2OCKNbWgdjWL1LeAq8H2ow6rHitm3FZI+uXKkwkwQBbmOzz?=
 =?us-ascii?Q?lRAKRbeeOR2ejpakHOs27TDD2FsDMpoIZiBk8FjIzgb1NnwTHhKhIqQZQwmA?=
 =?us-ascii?Q?MOkmnoWvGklmP8Mq0j0vLuN5spt3qTjqnh8oM0q5HjmiVNChH5bLMmfrshzw?=
 =?us-ascii?Q?cbLxTfJfMPBT5YN/eKsmiDLvAq6oXqZk10hherQUPWX0xOcLuoKyRgbhH/35?=
 =?us-ascii?Q?nZhAYhk7H4tQ/NS1emUUs5odplTYBOaiHEgR7o6qxkPojJ7dS+RHCxSA5GRc?=
 =?us-ascii?Q?8TigA1kkTbVEXEfhrhhzxW+MLCq/Q/HkcPDkO/IkwzqcBQph5bfAoWGS0ejd?=
 =?us-ascii?Q?na3f2A4GrQ40URA4Ik5JiWFjzrcKjSKyKXtPHAppMd+5oVZJ+uyH5eq9OF1j?=
 =?us-ascii?Q?JXWHgYscmENZBlL4Y/wrbiRkN8nHLW4OrEuQelKjUoZBUS8/z1Uc+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FHfVpE4voR2E2XVtbXOYM8ZA52N7SfD1H6zIegW8w14O3Osfa1qZZuSmA8jZ?=
 =?us-ascii?Q?y13OsfVuaCUqumJhw3VCH1eIxm8ZoNK+CTZ1I/LeFbzMmG+GLy9emIzfcfJV?=
 =?us-ascii?Q?ZzwwHFPsgyhPUqExPS150V4rQuJQHJ/KKqFgISXHyYzsSIiLnJ28bQHh8Nfw?=
 =?us-ascii?Q?WkkBUeNkQtv3XG7Mi85QWk6qj8TpWjdlFlCzUQWu6igliZwgE0ceRHYCrb3K?=
 =?us-ascii?Q?3taerfYcEckfAiSnGStKX6M24H1/2xBEzVqS/4PGAbK8oR2BDrVGY6IPxjXo?=
 =?us-ascii?Q?IAmsztWWN8MhpiIeFNQGrfvcMNa8kf2xWv5f+Qr4B4PQazcS7NBdON8O8Rqo?=
 =?us-ascii?Q?Im5N4RZQ4bsaoRfN8SmYDHgWsvrbryaTGir7R9JH47vZyTGIni/DDKu7czRg?=
 =?us-ascii?Q?rzxZOxhJhVqkLdJDBLsmTJqjGoADap3dP/xfosJkRpWU5ynrzY/gU0hwErg1?=
 =?us-ascii?Q?Io6y4LNoBcR1yxm1i5zCev3hBkzaAemN7tpxQk+Ypk/9B2GnMjissmVqSGwx?=
 =?us-ascii?Q?EXAxU9eBuNqOvppsK9+uBENR46NDtd5wbhiu5gzYhD7AD1eIh5y+cLJPNyOM?=
 =?us-ascii?Q?tNVV2azlogBzNHroku2mgSOAzciB4V7vnOCR1K88rmGn70XGT5z9lW0N+8E+?=
 =?us-ascii?Q?208qUUaN1Hy2I4cXMS1Vu3myh3rzj2nivO/kZhIxZ4YD85b+gTp6iJWSK39b?=
 =?us-ascii?Q?UgxWP2I2Io3f8z3E62vX90pRYfbwYIIvQUQv+hcMuwKE9WBWozYUrYii61u1?=
 =?us-ascii?Q?ZuPqkkc49s19eOuIQuVqlnRnJjBejL4pSsEuiZBGedegaEhEqIbWHhEn3qmb?=
 =?us-ascii?Q?YpLdOP725qKmDciDicocUaq/J9KtWH2Gxf5Jl++57X7i4n+w4xZrtlKapSAB?=
 =?us-ascii?Q?8kxnQ0bPoF12DAhdHfZEJ5Y5HlLyEQXrcZ76Ivi4DVAk2lT8Eq9n9+T/tv6S?=
 =?us-ascii?Q?/4HH1bA51+WmnX69suQPjoxd73gsKylVf3Jo8aiEMa9OOQ7/JLCK5YvXkqeb?=
 =?us-ascii?Q?xBfmuE/RSkwu7lnMk7OK4lJuJ7w5a+0GdJfzcqrMusTCkvxe9JT9NbxfpiaK?=
 =?us-ascii?Q?HsxR8y53ux8o21Y5ypKC8NKm3w6JPVXW4XUfg512S7ItOfmSZ2bhb0Q9TEy3?=
 =?us-ascii?Q?rZh1otbtfbonLARjhMwFshrAh/gSX1/0z8UFvhkGs6+mHsQbkfpaIdjM/IgS?=
 =?us-ascii?Q?wtd1nlmZUeF6qSXOaDrTawlJCWowN0/rHXTRXsuRjRO4trIbgmamTtAr+zhF?=
 =?us-ascii?Q?N/zXIohzZ1BlZh7pkVCB82IZCAKLPZKFBUdo9HgpGDCl7UKCrEPberrDLd9w?=
 =?us-ascii?Q?aJcE/YKEaNB4ZbEJuD1QDMXU28ekbmbVs3Hi+0le//H1iwfyIFZf/DpKluQE?=
 =?us-ascii?Q?pp6mnTnGhomKgX4epQK0fAomNGNva3xU8VRb4bUHk/4/Z7GEdDh8NBruVg2e?=
 =?us-ascii?Q?B1CP3lEQuxSF4dHDky7PSkTZTvBwReNgYuRJY3u5ywo+2B1i+PAWOaOTuYdx?=
 =?us-ascii?Q?5oigvNEVE2zbJ5MudbVECYJUD1LqAmLykqRZRNo2lAOJb2oSQE0y/90xGRIC?=
 =?us-ascii?Q?xn7oPnsgB2COaawo5Es=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda1994d-23e2-4afb-15dd-08ddaa1fa58d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:45.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOhWk6i5dF2Bp0LaEC2zteXjF2oCEbeWBrNNbh2Nf+BBGyPGIZdZl2GCe6vwg1xr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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

This patch fixes the shaper rate by configuring the
user given rate in bytes. Earlier driver was considering
the user given rate value in bits.

Fixes: ac624068ee25 ("net/dpaa2: support traffic management")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_tm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index f91392b092..dbf66c756e 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2023 NXP
+ * Copyright 2020-2024 NXP
  */
 
 #include <rte_ethdev.h>
@@ -733,12 +733,12 @@ dpaa2_hierarchy_commit(struct rte_eth_dev *dev, int clear_on_fail,
 			tx_cr_shaper.max_burst_size =
 				node->profile->params.committed.size;
 			tx_cr_shaper.rate_limit =
-				node->profile->params.committed.rate /
-				(1024 * 1024);
+				(node->profile->params.committed.rate /
+				(1024 * 1024)) * 8;
 			tx_er_shaper.max_burst_size =
 				node->profile->params.peak.size;
 			tx_er_shaper.rate_limit =
-				node->profile->params.peak.rate / (1024 * 1024);
+				(node->profile->params.peak.rate / (1024 * 1024)) * 8;
 			/* root node */
 			if (node->parent == NULL) {
 				DPAA2_PMD_DEBUG("LNI S.rate = %u, burst =%u",
-- 
2.25.1

