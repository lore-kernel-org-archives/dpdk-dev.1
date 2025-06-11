Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8EC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1871B40A82;
	Wed, 11 Jun 2025 12:52:29 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
 by mails.dpdk.org (Postfix) with ESMTP id 505BD40677
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk4265cnRSr6pjf3FRIRcasgfzx3SuY7XaROLP6TdFEuM5NZgW+gZjTrFZEaJfOTiPPv8PEBVuuTcKOZKe5PEsRDa6QyyP/X1iidx+Wr4uy+c8RXsP2q8RLFLGOdF4r+7E54FCSFtYi3JZCbgW6IyS2yiBh9F6HnuJ0JEhtwvW0VoHZ8KmQJOQgK05GIWxBZtqo190XxZ5qZ1ZlqZxM1/YDWSO0TxQRdO3APDpRIlnHwUz2d1/Ehm/hmldI6Enh4fwoJleYxdRZyx3rMZ0G4ogSzCI0pgFJ+E8fcrgcfSJqliP8/AR535AZEd4BV+2oeXm4T4yQoh6m3CZHRqD1nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yac5PaaEPIe+R4sKlaJZKfog5jsSGnOVnDmlw2YtfU0=;
 b=uBGIyiFbmHtJWexBte2lrt6wKUKHgKmWvQNjVkLO132thcULjHqf4l2PXvdFeruWtzV4sbynLm9h6qPNbI7Efl7W2cRV6Ye8Q2SL68kGSxg5f6I56G/CALS0Nlg5wb4CyDIFKCeQoFkFSpxtOXu6kch4tl7VCJ6tm2bg+sXIUi3oee9zovtVRVXQh22xTrBe8yQCPG8cOnBU7Q87VsXTiUH7rALI76vs6CIXCUZz62UY26kFr2xcSdQQYAxiG+2Lupd0tanhkMD4kA2r0pqOeR3mQlxioOQjhuTaycmIhH1iFfcJTu2Nb19X4e/2WwJ3uPE25R8jjBkVrWxyuwcmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yac5PaaEPIe+R4sKlaJZKfog5jsSGnOVnDmlw2YtfU0=;
 b=KbRMbgliKJt05WAUOzNCqNUHz/7Ns94kMtTxyiBn4hoK18w0L5kgcx4nVR7yfGWM8p/n3jX8IX8tTaYD2UQJeXXTA3uExaM41yBumfVlMfmRFgC9ebVdFf7i/YuAT0rm1SLd6zFutiZff5k5HnhMkV9eOt3cmh6lZ1Z24f6delYpuBgAM2APupVURKyahcaNuk8ooh1ouymMLPjA57cg4ymkend/yiu2eYx3Ue8uxHLk2cg01yKhjGxT97L9nEvWLRwTZfnKDQr/L9T8qHEgI5BCJP+Q/G+GKh+UPcTKp+/DLbzQrcdtDWeCFpX2oZzelz7L11m8d9uVWm6/Bo5WPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:27 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:27 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v4 08/11] net/dpaa2: support dpmac Tx stats in xstats
Date: Wed, 11 Jun 2025 16:21:46 +0530
Message-Id: <20250611105149.655144-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f237046-6f86-4c20-bb4f-08dda8d60deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lwCzfQKcZRDFsYvNBwYVahM0yJQfOHBRxtI7xbigiLNQQHRnA48T8Yk8g3Ii?=
 =?us-ascii?Q?M5gNNvz+hjtuNjRtmvcNQHUHxmg5OsSRAFTMH/OdTcBA7QvqCzc3mRdYVq/N?=
 =?us-ascii?Q?WlPhgqAevdLbOeXtDbKRwaFgTI2HvRqYE/GQ5LPdYjIsYkpnSC1W2Q6XRV0/?=
 =?us-ascii?Q?hhTqNoUenO7q5BqTWI1xVa6PmBGym+wmqPZOpo6PxfQoqVKDAn6iyEksB1KN?=
 =?us-ascii?Q?aGgBT90yrnD9kg2KEm/XLBs3M637sUeP5EElAs6F3BdOT0dSULkbH3FB7dG0?=
 =?us-ascii?Q?c8Z3ry9t0i1wWDsDTuxABZyEI5CfB+B1Va4oSv+/iUY8Lyy6AKHPSRPrgHSf?=
 =?us-ascii?Q?lA6VsEJOLC444ypkptGfHX4OiWnnvWEsKecM28L+gNGJMvqLU0PWExt36IMm?=
 =?us-ascii?Q?GRy+DJtTf9DOb114mg7BlNJ6uABqOoFxwEI1hXZj2Y21+a41YzntgZGxiXzg?=
 =?us-ascii?Q?Y5aijlVsYyOFpc9aOmqZoTt3Koj17khyhJTCpMh02B8rlc0erJQs60DKnnDA?=
 =?us-ascii?Q?PT7QiMMMBtFX7IbgukiWaPHc6z7Y4HdwB4FrOJgfN+0Kao8oBbqRV6WxYxWy?=
 =?us-ascii?Q?LD4vp5CCN3nezM23sVINkcB9rf4qbpgOE9VbwPqMI8nFE6SFqQPpUSR/fD31?=
 =?us-ascii?Q?KS7j2t7r9ZI8uUrIikwadWLThEZSxgavKLOd5SRq2uH4zH2abCddXnr9OhT8?=
 =?us-ascii?Q?SwPpSVFllUUZqTo75X2ET+85I6KxV8B7L1nMjBmb0GShpGda97SSf43cTvu8?=
 =?us-ascii?Q?gZG+jusxfecrKyGL+oY9YJWBRVTdJSn5YtdMoGONwTBcSdpVK18wvFF45iTe?=
 =?us-ascii?Q?Vqeu2aEOcGYdmdPNZOfUCM/UhMBElmEgA/iApfVP4pk5Tf2L26oa/qFykYf4?=
 =?us-ascii?Q?IN1UbUfWvDr0AX085pdkT9TMvmR0Fl7Zh3ut/RuUw+nBRBQHJ3pTSfdoeV7H?=
 =?us-ascii?Q?4fDpwNJobronVF7cdlRLCjaK6uo9/FimYRb0AHF3MCSuXmNuVsw86IOpEQsB?=
 =?us-ascii?Q?vgv0IcXydp+ENHdOW1ukDlxLndNvvtS4PkBJVOUy0mALPesN/qGz5nqv+ZpP?=
 =?us-ascii?Q?Ev0D3YfyQX0/J7VpgHIJkZqoqduim/lXeafJxQH7V2yWIjpCoDaQ+kBAm3xR?=
 =?us-ascii?Q?McHQSNEJmuW8xMt/nuAJCb30a76whIK5Zb9a5yEyx4mr+lNsXJdqrXeWfD7+?=
 =?us-ascii?Q?mYaL0aM5+U0o2BypKbE1eR8A7olYMyknWT2dQJFVgV3osjMbi+nipkyP6Jz1?=
 =?us-ascii?Q?aHThUfAJbVeemfdfHxZb2r1pPfFrLkBhlgzczJR/Im9hOhoa5JsyFib3INHV?=
 =?us-ascii?Q?cEgTp/iJ6kWFNPe7lyEpsYYJ9nS9Mvc6EOQITsql2OflV5GFQoMW74v3I7jR?=
 =?us-ascii?Q?m+tAky9znAV9v/asKeRqUPwDIMgGJlrupeHOzerXbZsGWOmRL5dSlYITRWPj?=
 =?us-ascii?Q?ao62ZyLdc550kYvSZ72MWqw1ljxZ79Ly892TmpLTfGeRc7o/xZVrqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2tenJwP7mrcCIaWHGk4XNPzabazkOs3E7SriOWfMCqVGFVEBnwhVUAyPqjRc?=
 =?us-ascii?Q?11TW5MyItQvEejO5LhlHHWfETI7uQ5NRCQOYLZMaF32Zolo7ISbhDryWdlzi?=
 =?us-ascii?Q?rSCB69Kz4WvoQGDWdfyltVcD1H6D6Evi4kAxgNOaUHbh3xf1jsuif50/8Oku?=
 =?us-ascii?Q?c++Ho19qA7Cvkl6isK04Aqdmt56aBgiylbiQNO+t6jtU8zLj47BrvE2m5vL8?=
 =?us-ascii?Q?N/K17W/0wywrriateKdhJO06KBpB/RJ9M27tFXLFdGyyCkJCOLHmufywwt9i?=
 =?us-ascii?Q?c91Pm90W7NTak9bJKwqHbiN4wr9rVl2p3KQynCInpjjekO27yYlAx+y04kCP?=
 =?us-ascii?Q?7uDOgTdH7wfS1JwQd0ENcByeWmUXVKavv4b/lWdI8NeCYfZwjLx0W6WTbPfU?=
 =?us-ascii?Q?9J2GcHNYIqLuvY4j79udpaZjUS/viCMmnr/gPVC/069XDG+VoIurQnqyqGXT?=
 =?us-ascii?Q?rrG217i1WDaTtYIJqEJ6VjK6J/DHJEivoUOsPnY+XAnqORZnP8b3wFX6KRpU?=
 =?us-ascii?Q?1ePISSbsojyWAwfWSOnVcPESPxEZfis8AdBgEt9W61FuqFH9091M3fajhO9i?=
 =?us-ascii?Q?MwzKrRnnZTQxqWNwxS139sluSM1gZDDFg2LCk8dWwRreUSmdDXFpeepIgThs?=
 =?us-ascii?Q?3cQXQwMNTkABGolO/LeRNbsxqXdSP/ZCR0++ha9hYwdoDZRLgwrDyousifaO?=
 =?us-ascii?Q?HLCG60pxSeB59DMVmxHCK0jMUaC0QFU7m1VjB9OOsq5OlCZYZb/F+Doi6PLf?=
 =?us-ascii?Q?ht3SNjlY8WZmbuoQp59Xddr4rnwnglcMGX/LtFQRriy/39ijyTdMkT2GS4C0?=
 =?us-ascii?Q?BHGwwK26p/4Xxwcz6vDtvIUZpXNJRwasAPKmgj+499Oz3bInzC6VjOs9g8sI?=
 =?us-ascii?Q?1ww6msLveU/ydNFmpuq1VyoZ1m0hRQoFl24MoNquCMHgQgjWU9lOWEUjFs4L?=
 =?us-ascii?Q?6cFD3CTFrLgYfHCopkugaAgXiZigGbadDH4yGgdc+48AP/5rUwo6ctUYzZRM?=
 =?us-ascii?Q?WimfH06AxzyxGCdBY+3mkPEngb31hF17Hl6T6jOtZM9rTrNhgI9wFsg3dAEV?=
 =?us-ascii?Q?Xd/HC72wuP3RL8m+E1cRFtDDgniMgltmXUheWeUtTSmJfTuKGrBqUeQFd0Ad?=
 =?us-ascii?Q?I6fcIcQpB8qW27LYb8cosaxoamLOxtV5/c86YxCIPyzsrGztiXZp6GCTAPg6?=
 =?us-ascii?Q?H/xOtTrOqY0drpkqPVNLHM+QCbye53XWi74xVHFjF8Hv27Q7AI2S2ROHsLiq?=
 =?us-ascii?Q?gulCsagR2CHdXxS4dK+GT9nuaioCKCiraSCjQb4tO7YWZfkv+NUrngtep5WZ?=
 =?us-ascii?Q?xuGU2YX2Tkv/6lLaTp227nAznQmLeqw2GMnMTYvwN1GWFud9ZkVNX+3boLKv?=
 =?us-ascii?Q?13sSoov6kKKOVgCDfQpV3cPwETIQSV/YyF/B5Fiw9Nh8HdzO+yXh6/6FtP1M?=
 =?us-ascii?Q?LFAAzjX/By2LbTkI2xt0M1NFtFZmy9+V3mKavRRrG7NEr9ARDQLoIVnj8FDI?=
 =?us-ascii?Q?fwI1Mk2g6J2OrOvWAZnDv9iqaOlRCZyWYLwWw63/hcyBk/U5NIR+GvlTM9ka?=
 =?us-ascii?Q?28k7eNbiXlyKf5oM5WI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f237046-6f86-4c20-bb4f-08dda8d60deb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:27.1253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgWp0s2j/GsgHcenPr2GhMekSoCgSask2ukk+wZ3NCmjvpgS5aY4M8Nm0nyvz3nu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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
index ba67fd8b0b..94de1024f8 100644
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
 
@@ -135,7 +135,7 @@
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
 /* mac counters */
-#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_GOOD_FRAME + 1)
+#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
 #define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
 
-- 
2.25.1

