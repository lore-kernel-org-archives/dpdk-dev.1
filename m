Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A85C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D13F40670;
	Mon,  2 Jun 2025 12:41:20 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
 by mails.dpdk.org (Postfix) with ESMTP id E93464066D
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmweH1oU6w9NBKiSBBXFNBWASLLC9++CoJU9Vo3fj3UMeRjZOcWnAAuWNYnom1O67s3v9yZMK5EWN0AAG+UQXjQjPhREoX2T29R4+vJd6VLqZnXaIc5ZgKiSQiLer8PBtBDLffd5HkBmhzwAj3mu3kjmZyqxv8IGqWZfP88J4KsDSjWWurovazpuLIF3AYa0t7iQ6BLoDzf2KM4X8xYxq72+kPgs4KegpWatj8Kx93sNOxegINoAPkefc62dpaHjLGgHo79HT6VnvI+fVpBI1g3bO+C6E2b3sFjjhshnkIrKh7AC+kIHABwDXnXtFnUJobLxsCPBqcbk8z9VqA2FvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93MdefBw0jA0A5+WRy0g+aG3ddRyCdD8Xq2wUWWv9ZI=;
 b=Io22A92/m8UpBn8s4L3PtW55BDDL1FP3FcDeHcia4H85aTFO1qUeV/nNl0g84Q/52PyIfbkqXGuIVXWSzFni7+Zgp1k9VN/m8nAhDlbr3YtCyCW89rq0/xFYY8epZgYHliuxKoGDJATDpcNovap8w8rX6ykAXAIaDxE/TC9rV/zyobGqqZhaC3dtyqFsnHlCsjDOWgXN5l3tOLvcXxnq2Xqi5MXix9He/FS1VxnxtwZsox9ZirNvNNVMmsK/ZC1rdsrctrJeUQNx8ZTDgrIfIUHvyy9n8SCb3/s3IkPAZQ4xfSKAH3SRmUMxNNSdwRWr0yv1PFhD8zyAubvhypzqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93MdefBw0jA0A5+WRy0g+aG3ddRyCdD8Xq2wUWWv9ZI=;
 b=J/92jwR4L0y36NHJu6FP3KwFI6++kPDXpLl0f0Ts+WqryRNQSgAEgKnJ5D+ByBBRiVY/hIiBQq/nUSm7kFVl09lHpKAzVOnxudPXjOb8pevy3+4tC2YX2U95nyxA1EwIDWxyXzhTYhJoT9+Jk75qXbPKQh+hX19gHay8dO6rEBcqZx3fOhVG1XEn4lX2BQ5kFBr+OQfOpoTrJf/5M/9uFwjuFw8oqEgOdUZbI0mIgqne9Pkj1o/hFU4BBudUcBtXETukkrtu+LoZcuuwhcJqKieMdbnvJJJ8xj1XMwsWkg6NawMdwFQyX9BzwfBB23ip+oGXNyHV7l9M7dEX3yuQJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:17 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:17 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 08/11] net/dpaa2: support dpmac Tx stats in xstats
Date: Mon,  2 Jun 2025 16:10:38 +0530
Message-Id: <20250602104041.3322164-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 463119ce-3bfb-43ce-57bd-08dda1c2013e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PGQ73FNTcmBGhFaMEac1s6sE/tevOZrKFI0vki2aZZvcoHOeZ1PFvfj4HYQE?=
 =?us-ascii?Q?jGa49+m+K0hM2x6vD3/KdY4/1vN/MGzUTkMIcLa4jBONPuFnDdLxvSFoK2c6?=
 =?us-ascii?Q?xbs8uNHH8eN/Rx9LOzOEYs0bdi5Hk/fo7ompWJxNL72VWb5uBw45TXkGhSxV?=
 =?us-ascii?Q?brgiEktI+mWsPv5hh9XBH9eapRQ2UlmJ/Gau7QUrQ1Zzj4oSe2fh3oviOYgW?=
 =?us-ascii?Q?t6OMX5fclY5g9g74ddgd+ABmp0o+q++8IqSMbHafStGUbww2uo+tLUotaH+e?=
 =?us-ascii?Q?0m+vnJkabpCY8mNrzFlLrdl3S6FCLF1XLx06cHZD7R5fNQM8DZVpPSvnreJS?=
 =?us-ascii?Q?ZsRoPJBUMR2Uxw4+fgCq3nCvZmQwY7xO4tQE9pH9Yw26nQ5vsuOwjxRm8Dkt?=
 =?us-ascii?Q?oYdO5XHLNYLROTvgwRJ0dF720QUkovLOYEOk9pi6FKnqO2UGiXDWGvhAid2M?=
 =?us-ascii?Q?QFn2n+m52vJzA1aHItchGtJeRIRz7QGBLpulyRACIdS1r3TQOsQpJiStBq0z?=
 =?us-ascii?Q?5G5Z8OwjWV6jc0qgnm4oyAZxaZXoXqI6ZJFVFVbKU9zLsXYlTwzZrtmBcQ8g?=
 =?us-ascii?Q?C0fMmfjM5o1hvU5QwRO1VeT/pojdp/gf4P66N8BEU/1NBgkyQWYm/g+dWlAD?=
 =?us-ascii?Q?A4auyyloz9XBeXkKJ78rEmlg4sLxN5v0TkyZEhW/G+0HFe79G673mxFwhhXS?=
 =?us-ascii?Q?CtMYzXTg7VxsiznNXp5PuwnsG1Z27UQpoNKLJvUrOCmc585vSLRfLLkQZKrE?=
 =?us-ascii?Q?f+NfQ/3ihQ3Zo/dwadUURrIdlH00/393X9LnPoipkYknZj6OxScMmCqHtc5e?=
 =?us-ascii?Q?Uo50AQrU4fNn3v2eHuEGlDMn37WCmMl2TbDE9LzCQ5mHT0D+uT1o5fM8JvAn?=
 =?us-ascii?Q?195YNh4zM5lZyMlU0+DCugsaekeaQARUauLLNKQODezdSgFqjz7sVmKERETb?=
 =?us-ascii?Q?K0d/Yrb1I54qYsZBxVT8RrWsGyqFnr9PqmUpUPTffM9HOp1Z0Av782lQzqtS?=
 =?us-ascii?Q?nM970yD+rn2ovgXtxXXMW4cEE/YQmfmlBzOxO9xHinZRLhxnRALuDB6NNtaM?=
 =?us-ascii?Q?zwGLomIrz8tXII1usvYDGZ2ZmyZIVGhRzvq1K2M3D4y3JVfh43w3kVSl4fuL?=
 =?us-ascii?Q?jfvOaJwHm/IoMtMI5Gi45QW7jUk3PjUeQ62C42rpPIWtgQ8366VyO2JfsQVW?=
 =?us-ascii?Q?2QHB4PlXumzsI7JJyl+Mwq9wX0oBzYXcbbzjeUI4i4oxdUt+OCk3H9INx27h?=
 =?us-ascii?Q?cjfCEbTcHr9CljhWLwiC8HyDz4gNIEYEn1FW7jHFKq1dQuYLt5M75CCFTX2K?=
 =?us-ascii?Q?xkyU1vAc7LElh0FR6wX+wFdgZLZzXfhB/31oJ7OIqqc4LJe2QXN/PoRIFgNn?=
 =?us-ascii?Q?+e1My1TO9bZArs+z65kO28q+XInY0BOi7smHsc7qZ/LGzXB+sSS9IkPgXTXR?=
 =?us-ascii?Q?RLwn9otYFdUVOFhdcqPp5XJMx4vwmetznBYoYyXxYk9lGPBX2/UWdIl9y8s5?=
 =?us-ascii?Q?6HbLfU03UKYrfek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plHXVFHuZPbRYj6P0zq9FaqppSdfqM4SFf5eBBR0S283o6k6ohObmXVW7Il7?=
 =?us-ascii?Q?zmf7jwkhTYuVsOMmiUQHWLg7HnAgkxx+hmbKSkhrdmVGeM6hFo48btAGImqn?=
 =?us-ascii?Q?tp+h2iaPqose2xxZ4YzFWpvtcrBPq/TPGr8mvzD6d09XHAQmiv8CoC1+/9Jp?=
 =?us-ascii?Q?R5HEeBwoCZ3Sv6vxwm3g+W+QWM+IAs99EkcLDPeNh+oWrX5YoZe+l9oj2+8M?=
 =?us-ascii?Q?KUgAQ8q3iieF1agmLhPbhMKna1mACElo4VtpM4efdCSlt61tzJER3K5NBP2F?=
 =?us-ascii?Q?34EcvWkcxx1e3q2rnO8MvXpqelTIskum/CaEJ8XajfeBVgWFVF8qpESE/cUH?=
 =?us-ascii?Q?C+2kWeqdUsM5ACBETx7QfqwaWSZyxbcVN46Cbea2jO2BvmvrA4swNhBzj3ME?=
 =?us-ascii?Q?QJ8N6pAVtBFESsZA6NMpmN2ndkocrcxngGHKINieYIRwFpxmfljNZVDwLIgN?=
 =?us-ascii?Q?aG1Xb87U+Ig/zyCupHGxTuzLNS4X87VogN6XslovZPhHelYG6vJspWAm6OgJ?=
 =?us-ascii?Q?PEQv3LJ4KheV4Vbig5WLo/yi6ZwiU/L97zD4o80Qf/sm2n0J1rU8NbeHh3Ov?=
 =?us-ascii?Q?vSxJRmUi2BGjw2EpGzzbEfGETD7bHJGlieDIhGEieJTWkxNsVliAqzKGztgI?=
 =?us-ascii?Q?vcPsUvF1c9UBGbmhRiQt7+k2gkA3wGOcsBfuQZoT5tSONMGkqgQj6BXq+8+L?=
 =?us-ascii?Q?NfOrczIUmHhrs1Fiu7ObsNMDNe4QmBAvH6Xp1NoMXmAi//o/3Q1d+o0Y9R5V?=
 =?us-ascii?Q?MZbWu25AIicuKuYlFfxCTUxNF7NSviO8kAByAT7+7z9MRhrmj4VoroUMAK0t?=
 =?us-ascii?Q?lWAoV8dYPd+bCNh7D76lPG1kMxRaU+ttQWCe/YooEJK44mrf0aeE82bXQKCl?=
 =?us-ascii?Q?Z+dDnU+AqkEBqf3q3Mi65RDEAkUIGLFyFnVHGHVgsSs7Gphn0+c7CSVXTu+p?=
 =?us-ascii?Q?TlrJvaS5SHJdhXw1GVwFkiSv6PZ4o+Iq7DkSx7SsjOWCmA2ihsX4JvEzo2Y3?=
 =?us-ascii?Q?E2v4wzh1ZqZd8OgEQoetK9js8M+wCHY5biH9TRdvLMY7rphV+hT60Wzlb8gS?=
 =?us-ascii?Q?mJ/Na49WaTvvRlP1iSity2hVcCwS1pbExODNSSQPV7nLpHw2qZ6HXq4ue9y0?=
 =?us-ascii?Q?o42dufuI2CP78GdhY8WOTHRzun7avgH+EqjNuRsWzQ6FLoEX+AGRdRA4PgSQ?=
 =?us-ascii?Q?TPbRnFzfEee2KiKwlbKWAaLNiJwUjyDvuy7XG6RNQX/mLjSdpcFQnYawyWM5?=
 =?us-ascii?Q?CqXOQH7wt8WiPDcM6crQ/mr7W9ZvQ5ZlAK/BN6b7EXQtNUTOvZqcM2PqZ0Pa?=
 =?us-ascii?Q?NTcKLNHm/fJIc2ow7rn0B8DDjFNjvw/AITlxN6jm/rjUEGoTFvE5tatfV89p?=
 =?us-ascii?Q?Zgu+JR7IoaOlRUaOTMtF4IT0lF9ufHlHUQXI4IDSgMuhA/Xyi7ZKVvfazd9h?=
 =?us-ascii?Q?OnkR2Z+I9yDfWZvwjUcFmAH4Uvifn/xYv/wbuRinHcICuwca06w4uf9C3nMw?=
 =?us-ascii?Q?oQlLm6UaMlbGf2oRXwmXKWBDfXbukS2daBe/7NeohIKsiq3iGy4kNOrdNVhm?=
 =?us-ascii?Q?nr9oEPm+Bt0rfDbMZJg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463119ce-3bfb-43ce-57bd-08dda1c2013e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:17.5246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdj2/vg7LtuF0JtT1erbwED0VxwpJ+v6upGR/L4HC5ZCXyBGwKXxhH3ZXdvFD1dU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Added all mac counters including Tx stats buckets for
packet sizes in xstats.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 20 +++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h |  4 ++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index bbf4df69d4..298fded65e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1,7 +1,7 @@
 /* * SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2024 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -134,6 +134,24 @@ static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
 	{"mac_tx_frame errors", 0, 0},
 	{"mac_rx_frames ok", 0, 0},
 	{"mac_tx_frames ok", 0, 0},
+	{"mac_tx_64 bytes", 0, 0},
+	{"mac_tx_65-127 bytes", 0, 0},
+	{"mac_tx_128-255 bytes", 0, 0},
+	{"mac_tx_256-511 bytes", 0, 0},
+	{"mac_tx_512-1023 bytes", 0, 0},
+	{"mac_tx_1024-1518 bytes", 0, 0},
+	{"mac_tx_1519-max bytes", 0, 0},
+	{"mac_rx_all_bytes", 0, 0},
+	{"mac_rx_fcs_err", 0, 0},
+	{"mac_rx_vlan_frame", 0, 0},
+	{"mac_rx_undersized", 0, 0},
+	{"mac_rx_control_frame", 0, 0},
+	{"mac_rx_frame_discard_not_trunc", 0, 0},
+	{"mac_tx_all_bytes", 0, 0},
+	{"mac_tx_fcs_err", 0, 0},
+	{"mac_tx_vlan_frame", 0, 0},
+	{"mac_tx_all_frame", 0, 0},
+	{"mac_tx_control_frame", 0, 0},
 };
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 532c257203..570b1608a0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2022 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -131,7 +131,7 @@
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
 /* mac counters */
-#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_GOOD_FRAME + 1)
+#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
 #define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
 
-- 
2.25.1

