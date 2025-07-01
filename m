Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E3C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF2140673;
	Tue,  1 Jul 2025 06:29:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
 by mails.dpdk.org (Postfix) with ESMTP id E6908402AE;
 Tue,  1 Jul 2025 06:29:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhO8eosczxx8lVqaZfCOhdEqCvxG4KsFAU1I44HUq20wVL4DtU4XA4w53/dQyzyb1gRoksC5vakMBUzXu56YiEv9ots9r1zab96xsF55qlqnAp0HANCMrX9NmAUDapxhWq/BSuSPGUm532QiWCreGNuuMCigCEjagCKwPVe4PZq5aHznADh5307kmqjmUFEPxSuntGRHpokEVIi2TJFyPYrI6Cg8+/lZ17OcN+uoo+gLYidyV6ET3vLQT1WxHnrgI1EWTuIOyiX4WG9R1f+2GHNXEf8wdLSVVZS6MkwjrB/esFE5rXfdbtnk53Def+pVsMwQoQ5fN80jkc6s8TZFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=PW6GDFRX5phC3zCq4/PG7eznM/+ks/H2C1RWQWV7AU57gFGlHC7bpg9ghDPHT444ULIzWjJIwxM5N3IPFTqVmLurEIaxYUF299s+tmR+TGspIKeuwkCP/S594w28dvtC1KHzOAniiCISLAmJsb7gEDaOFWSJNTJrOyAuT7vQxXVP2+cch4T9o8VIqODn2OTC3x9LyBzrbHSrY9yiGbwY0oHyoh5snnvnfIvDdOmMYHYttlLtks7SnrHcOf7Hi0+uedWZ05k93+8mS0PAJcVd0+j15ZXwSl4SrMsMo8qoqAblRzxq326GLvH0jHngDWB8cOk1DCFHj0zgxFkbywP1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=grklJtV6hzJ41iOmRWg6SbuReCD/k4+IpYwNT0oHAj9Vrev6OVnJ+UKJmbsCIwmVu6abnnZFpMqLMOdRGrrZOP7UQqbx6qq7nRdc0AgIqXgKTH3lxjXTWzkSmrNOd+/oXIm3lSwk2SP234KTrD2v05FHFrRLXcuODTbdvAAt+FOibFEujRqE71/J2YUfA2vHchvk/h0FHkwZB4QlQN4I/vXF/IBGYV+vyVziTHtT6Z/EXiEeUBB5OOzqlXgmxlXS6G/blLXrSzitUNGK+8Bh+YyUF69P38CNtXRI0JvEd+q3xtliCPJDwmdCor1uXg4kXQss11YP13s0MFB7oT04pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:34 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:34 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v7 2/6] net/dpaa2: fix shaper rate
Date: Tue,  1 Jul 2025 09:59:13 +0530
Message-Id: <20250701042917.3000355-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f258f3-1798-405e-c102-08ddb857e147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6xg+TMGBsy+SVT6E2BcAoGAP+Eco6HYZqqTwe4gUWukzZgb0wjXYksTKnw6t?=
 =?us-ascii?Q?T8Fsljxf8tQjArkpP/xNKm7iO/ga2MQDgLfXwRgq4yiDY4WTPJyFdg8thCL1?=
 =?us-ascii?Q?rNfrH75FdZaVimuH/m7gkfVw8MjDNIOceoRXF7FD0HFJHcsUBvzj4AJJcx1O?=
 =?us-ascii?Q?M+Jlghu5ta1cy9PGexNNP4NVIGV8IBHusYTJn+7sK6cEs3KcCJmkavk0Oob2?=
 =?us-ascii?Q?5ZW2YZS1V3RWXN8hUmSa/fQDYXg7tadJxqyHTCxX/pqgYuDambtNZi6UcbKW?=
 =?us-ascii?Q?7cLhoTVYWj7k7O4Ijfwdkg9z5XMhHXiUmeO53XQQsXxqBUsTl46kWnHYUrbP?=
 =?us-ascii?Q?ffdNC2uA4j0GL+e30hbPhyPBykQ9Cf6Q+rDeYCCwIqdl4NeCb5XfZt9nS374?=
 =?us-ascii?Q?xE5SIsQ0qm2A4AM8XthOmyTCuDVdhb7zNcOQshhdSHlHeT8WVOOuli+iKt7e?=
 =?us-ascii?Q?t0qxBzDuhc5n6eGPFZ746nIR6qAZvvgW5ObrbSbncmwYJw7hIic3LGd+2Cx0?=
 =?us-ascii?Q?V9HObAbH4+o79AxZKw9JbZ6xOo3+9/1ns7X1BzdNLP2tBCtkvCnF3zbvGBb3?=
 =?us-ascii?Q?nwO0H3A/rHY9khTAXD3dKUzTzfatvLtQuuHqtyDOMdeUlG6KnjSVdowGKjHs?=
 =?us-ascii?Q?4KRzuGBgST8Cif7InsSnebh2PXNN8ZuBYsA6KB/ck2Jq6EU/29LSzFH7MXZL?=
 =?us-ascii?Q?01cewMy5nPYQhsJnogHPgykyMYyjc55je4HrMKYZm88aMTPIsygCTQfGnn2f?=
 =?us-ascii?Q?uLeEhRbIehPONfXCboNgIRU9ILsdal+F2k23CiZw7NCvMPVh2WWgv6hU7Nyh?=
 =?us-ascii?Q?X0A3umjvPV+udLCddTOj/7e94oHfH9/u/09uD1fnC9LcHb7edg+bU/niJkA5?=
 =?us-ascii?Q?P4LjL9zXEw58d8YbDKrAvMx2bwAWVQ7jJsNCNN9lUEOWtvmOCaFxsX/5UFV0?=
 =?us-ascii?Q?gvvpXJtZQ23YMymZHYhJMwHg9chLhC6kfDjekBbVvSR8DNtRfVP5nKZGmNIB?=
 =?us-ascii?Q?q9F/CdGNRUHpAMoeEHb2gy63daJjUTLDD6PsPSC+SygfavIYC1GcZz57AX3h?=
 =?us-ascii?Q?iO3DEzhchMujKM/umQzFtOsNGgioshKSHcORIQ+oqFwHNIsbu5mmrsWokqfw?=
 =?us-ascii?Q?As0CiLzecRRmJRpFr9G8vldEqri154Sc55N0FSMx2RWCAJCJg12aIpU8ZS9C?=
 =?us-ascii?Q?LnxmM4S/w1OLUTS7MlL6HmE6y5+joUwQ+nUlNa9xdm6uRof6oX1dU1fdUKYE?=
 =?us-ascii?Q?tNZdqrux6KNM2rjk5N20VCeWOWtxj5BYn/hZNzjrP0yDMIMaGpZQ4F9tjEwb?=
 =?us-ascii?Q?IEXyAe7d/erFJ3LoYb5Dy60rm657JrrYxwltaQLBLo5OyVY1c0mkxQfTtQiP?=
 =?us-ascii?Q?n3r+Tel/6kaNPrhSDL1J/2ZZdGLXcMfpUwMkb9/2ruh2y0cB/PC8uLOVaPcC?=
 =?us-ascii?Q?sGhQBtvmyOTWqCVqeHaYEgicDnnZPDxUeeoP3b8CmThwGSfTAikeJr3mvwZi?=
 =?us-ascii?Q?wMrswYZHTfStTGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9eiaZLg8GxvdayEAvHuQ9H0+Kdu2h+3Du2yrGRWqip47DRdDCV38K7nHbTu?=
 =?us-ascii?Q?8RvCbA5WxYWxyF0mots3KC+PLYKlVmgyuR3yKwkkRe1CaNEgLTfMEUkBBG3x?=
 =?us-ascii?Q?GMfK+Dl0w+VudgtlTQjrnQJcmLwc0nlkmWVrp5g31Y+u2TFrDTeNXEqjvh+r?=
 =?us-ascii?Q?GH2w+tMw1xYxVqP+NK2dZ1dJO/gP01klGtKxTkAr7SRa/ggRgRHOQGqBNtr3?=
 =?us-ascii?Q?uVun0c9Jeua2d0jNNX0cuH3uLJH0iOL6ltsdytFqtKorwH10UQ4b/4S4faZL?=
 =?us-ascii?Q?kY/+BUMEZObzXOAxY16wzdixRmeVb9CpZELA1si587HNQcVZ6rl5hNe8PPVP?=
 =?us-ascii?Q?Q0AoABeu3WM2M2ctw19/+4K2TKrtERMpMmfal6RXpy6OmtERv2nSSc+DIrmJ?=
 =?us-ascii?Q?H1BvxpV2P+0T/QU6P3pWH+Bv4hpFhZo8vKQpbhJlvfVOd+Akdmm7xlTJeXKk?=
 =?us-ascii?Q?S+PZ5evSa3yYFNHIPX74s2pBniQMEPyeK0d5KHVwCFE0cNLOgpMIHTNT277z?=
 =?us-ascii?Q?45ZMHBPOYBKLvOxXvEAO9NMrT4Bx9ZhTV/YbRUjL8jhPjFRLBZ2c7AdfsFxt?=
 =?us-ascii?Q?uiSbNh/h9TXJgVyL7MkLFJAN8Iej4u/KZV35OwfQAaw3Z6ULZvxXWjHqJfib?=
 =?us-ascii?Q?9ZqHJ7xlk+UrOe0avSTtPUYM0FBcZgqIsJxkIO2zR8czQskEU3lRJ4hl0LVB?=
 =?us-ascii?Q?llFEF3Wy/ZDfuDkEtRsYVCnhWBMD1ba7FkeOBtcvrEXqM2WUxgPmm8Uedoh2?=
 =?us-ascii?Q?09vEdt03Fx2zhGc+uLgzhiGpAhhGYDXAdnkF0wo2vuAoGLKgKsPbvH/x/5Wn?=
 =?us-ascii?Q?4RxTD5cxBQlv9eIOVMDsHK+H6WMxFpUcl45VqDjtm+ww+Q+ARfuflmwGxByp?=
 =?us-ascii?Q?XBEgVY8AraUjolOPPTSfug07/T836GjNQ5W97Vikc0FQvpABLgHcdJ7LkSzI?=
 =?us-ascii?Q?9EO4NIzvpSCgW7aFIXRidif42PESrtpGEvhGJ/Q4lct4KouTJ/LekU8Detbt?=
 =?us-ascii?Q?91W0HuBK9Lvljgu8yDm4j9h0J4NEW91Y0E7qAAS8EreaWdtSTayVZJlLogZf?=
 =?us-ascii?Q?P1AJNrvx0jSQ5Ecp4rttiqEzwBcEgQFYZ9rI+srS5WhnvGFg/CHqSUm8yn1R?=
 =?us-ascii?Q?OrlDO/WHZEL5YKItHdybSLTAnTbsbxHkW1j5Sy5UCpIWZiVetedB7nkE0YY9?=
 =?us-ascii?Q?Gr8eqKmPx0kkmFs/m8C+ggx7XDzQNRFSSbwRh3+4aXyzbiLCOMZiKQMwid5+?=
 =?us-ascii?Q?oGtO5nEZuRlTTAvfOQFTSNwaFysabOPSlBQa/uLVexhCyUAQk4IgZauDbhgT?=
 =?us-ascii?Q?sasjkzyl0EzD+lZdLkr7vcOb9eAgwNyd+7m61UkUN1nrV9uPabTOBMOS1+w7?=
 =?us-ascii?Q?9VdC1Pu93Q1HPXv69W2gGdWOheHAnypGBwEL2zKrEfLyBA6KIqorVin45my4?=
 =?us-ascii?Q?t2eYeZMMEOpBvQrD7Qt42DjQNK9Zou6dZlkPAafkdUx9Bwhl3QZiickGlFT5?=
 =?us-ascii?Q?EoIsmzCkW1XQyYnuXMgBhmRKsY9fr1Hk7cCCaYDVwI4scBYQ+tlSAPReNHuE?=
 =?us-ascii?Q?BqBDL+QxIO1+32FAXG8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f258f3-1798-405e-c102-08ddb857e147
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:34.1064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2ZvFh9WI6AQpAeWQec4/PHHO+bCWmPckmQm8e8Kh5/6zK3oH6x4Oa1sj371LbSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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

