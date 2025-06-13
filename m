Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F4C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E1542EA2;
	Fri, 13 Jun 2025 04:12:02 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8ADB742E92
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:12:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdpUEgJpuKlw8EimJQwO5n6s+y3jWMRSbucS5cA/LdVuXghW3TA+c3MQ1Fo9SYwa/D61cyrKcv7MFEa8//n8odXXRlyNXtLLyRK8dTCTXqDe+5GL58p4bP7h1YvhEJYFT8aMaZTML09T3iRSNHrTYx/skGTknBLlmyRlqeUGkNxqNziFxDgWEm3cEpa76LVyBpevm7Fjnc6PKHLLAtVBhdDigBhI2eFzNxduuOpaiWEllw9JXvNkHcpRIwtO3hxyAoN9aHcwIQOWChWZLipVLgGgazES/+FD8NBvsxnxBHKbJCBZ7L730nY10lkPpoK/P1DtWSl8C6ryLhY6+S4TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yac5PaaEPIe+R4sKlaJZKfog5jsSGnOVnDmlw2YtfU0=;
 b=Yc8R527aky246qmU6Uijiw/nsA2WoosiXRD1DJlTG8wNRSoPZNmvzm0AeMqhYuFFQUCOG+y/dXEIaA5TAG8VEOWb6P/oRwvAFYOYrr/0/aWfSlLhvIeWDo2ZNQ0hdL3RgOXb3JWTidnDACcc0705yfgMiuYLwEVgeyuEqrCqM9MLTtQ6/oHhzSvRwjf1yzDH7xTiVhRQWtpa7VShFdH0iLMgwlpNCNSxjCP1GaoJb08IJW9Lq+oPIr1Y33bk2UZ6j7n13ABjpvF02pV6iFb6ZjDJSKDaceUFQSwcb/QLfzQo4JRbXhhJ87DORH7ppZiCyrWDwzAMeAI4iLGFDUvEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yac5PaaEPIe+R4sKlaJZKfog5jsSGnOVnDmlw2YtfU0=;
 b=DFI5zD1709jJnvco7Lm6JGu5JwS5VA8CRNOQCuBerQdRj5ZdZIYFmmhylvqzKf3gX+2s63pFDE27npFpNsP3cGMEIwqbWAvLte6wsCvDPLuioKwAEXCnHl+h+h+U4C2LcBojZlO6twL1OOG4FZGO/8UoPuxz4is5/WlYXWyCXjH5aJ2vD6SuVriLyEeg50PZdUisfSnntiZzfbTF0yo/7bEAEWl623pnb+C7jjOcAwAl07FtYeJ1B7pggpmsJKlm/gDB4wcCJ+CWOi8KoWB/8YVQK1vmKcJALtfyO5lQDgoAQcnuVybkqWqBEhTV4TufYnzDwRo/+wQ85V3LXdPPMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:12:00 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:12:00 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v5 08/11] net/dpaa2: support dpmac Tx stats in xstats
Date: Fri, 13 Jun 2025 07:41:22 +0530
Message-Id: <20250613021125.790614-9-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70b1f88f-e12c-4c17-dbf9-08ddaa1fae62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YVsET3d84ynCjUerFvy7xUin/+IScA3nhsvd4xKFRcl5eiTD8CWUPF4/3TcH?=
 =?us-ascii?Q?B++P70ELxwOx2W61jqehyhgPSwOfFV16duVJFZ4WyYg9eCEzdpTt+5tv62LY?=
 =?us-ascii?Q?A3nrAVMKWrinQe+9doGzSHccTsd4H0381YUUhdGbQB7htJTXPCEYLMjuDY2s?=
 =?us-ascii?Q?xV0BriP5RKdSuaLeghTD6Xk4IKM3NYluYdV6ViPPTDVuAA9T5lhVyaYtbi4h?=
 =?us-ascii?Q?kfrIaQ/01aW1rA4omwf7nKagpg5p/HNF3O6kYzHO6umpRGyBWUrI1QqYELBq?=
 =?us-ascii?Q?5l8FmasjZ8fLlMhQ7XaAcwQq9aldC0TZkpDcAnnTgbXwyxuRRKDKrCKyr3N8?=
 =?us-ascii?Q?M2ZhNmlxqvI8BuNqfFsOLR8sTSKKE13IMeC8YLrsfAlmN36vlAQQOBUrf/aP?=
 =?us-ascii?Q?f1GlrJu7epUw11T0K2pj/6qqsS4OPgwiMUA9udthQA6xW7rpBcgHStumzNv3?=
 =?us-ascii?Q?rWYWTukPLsMyO4WAJZmVY5rhtNtn20sl9PVVjGOrpdAYEK5KoDvTptDNiQdz?=
 =?us-ascii?Q?vOlMZ054RTFKG6dsmv08c9iB7WkSK8sBHChXNc4hNtkJO0pdnLurUv5M86Yv?=
 =?us-ascii?Q?1n6+D3Gnr9vpZotmDAnFYqsCnmOEQceCkw2pM4IYoWHffBhgM1gMaB+RmeHD?=
 =?us-ascii?Q?ueNHjjg9BqZia0XXqPK+9xiz3oH4obra/zy+hMrp6DRA6kpWQRcuTte4gxtB?=
 =?us-ascii?Q?KtemkYaqB87hcbOlBa3hiNlZfLXL420uQqqyzgM4AYjrF7iL/Ng/mc5Vs9U2?=
 =?us-ascii?Q?OR0lRYurkoDGIFmAbpHyH9v96e55ps/oOZDhAydbChO5pyDOBp/vFlgY78nB?=
 =?us-ascii?Q?fenbX9s7zOvB3IL7ZRLQV5EG5/aepn0wX75dUm8y5dqxLtixRRjCgKWQR41b?=
 =?us-ascii?Q?702Up7+qOUsLy6S7N24WbpHjnZRVPHVNcw4dw51JqhBQ5zeM/CsvJh1x4Jlp?=
 =?us-ascii?Q?tehudMt3JOlZuoieE7bAtXSgvyQUD8vT+P5obSxraOgKvaRsIdZ5OHCq/Y2D?=
 =?us-ascii?Q?G5zSc2ELyD6FVbA5//yCOA1n3OT8wy0CIeHJhok+aWdiFxXvG7PWNyZjPK+d?=
 =?us-ascii?Q?ZJyFGkFYBZU4+Fh+JMsQ33K2uN/NZL0GyNASWCelapn4T0UQvihFEsyjkZvG?=
 =?us-ascii?Q?0ha248XJtFEPbLtc5dBbu6ptrl1EQONsAXqlMb97V4IOPMnx9kT+G6cce1ai?=
 =?us-ascii?Q?bZpooBTz1dkrZStrvz5E3hA6tp0wEw2eMKYoxdza6G8SVtR41ASYEhtBMv07?=
 =?us-ascii?Q?Ayj7QZPEuNAAPm+DK9gXnVuX3GogfFAcjJmPVLxQVJ5wGMYs+zEOeHidnwcJ?=
 =?us-ascii?Q?enzjFnLM2azGDMKwalv4nb25kFB829m3N/dbIvhNmL//7ZvjQ+RdHxILYZkx?=
 =?us-ascii?Q?o9VeAqORpEzMe+wr/zCsA6s4n0k0C3PJWoeHUrqgHuqh9UdBuhEhmePe9qEw?=
 =?us-ascii?Q?j4RjkID3eZ2v0DErkCrv8r8Fk2x2u5yozjLRo8FWYiwqeM8azuVt6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOFzn9BwgHT037EQhtgS+Z54ZifbgIhLUuzlIHXWbDDDoyzrIj6GkHIlS9Z3?=
 =?us-ascii?Q?sypnjiSVjItJLeHhUIMQ88i10TUWoYWzO4LtRhJqk48bPM9ivq6gK6gt4OFh?=
 =?us-ascii?Q?lrJTlf6j6Z6BhybN0tBv/uHoe4CO0GCoPYfcwM50NfU08BLTuFL2x3d0waX6?=
 =?us-ascii?Q?xm1kwNaLfoq+mgRkag37gB7f18UmVdMfyP/oBNe5/P4l4RuPA6W+gCuQsq1f?=
 =?us-ascii?Q?vv1A1us7r/bUPY/zUxSXzinFGBlvw/uSOJ29OBN0dYW3mZpZ9xu15ehcaQn3?=
 =?us-ascii?Q?4k4X11M39OXTsmfrTLBChd+Nv7VVXbedxbsathHlDVXytchOPOyb8GuWU1Hd?=
 =?us-ascii?Q?2Rv0eccnFCO5LQBlwt5hG7/tJvbtvUEMr9QXuJ/4TtH7+fhhGklD+JN8vQcM?=
 =?us-ascii?Q?GZQWvZWkQuO+Edq5iNsOn5BRV9XyEiIkO3cv7+iTpaH5h/W4RRbA3KGvOLzT?=
 =?us-ascii?Q?pgrVd0QvVDlPR7LR981qrUszpYOHEAQT1ULm2NtkuvAo/yxkCg7YmjWiN0qy?=
 =?us-ascii?Q?eF+wAjm9Ahs+SEwm381haoHEAVN0iKVIrUUlZjQiuTOtjS8ZkkMHeoiEhhBm?=
 =?us-ascii?Q?vg+B8Znu1U/3424hb+uIUin415hJU+LuFPHN37qBWWX1f5RZj9Jvcw5eyR2X?=
 =?us-ascii?Q?C1n6iVDh0iIZkOGtuxBTfgnvnBnpb/OdeY23gdAbuXR6haIVgoh5g9LpSkPy?=
 =?us-ascii?Q?ULFuMWx6j8nyw0PGfcgl0K7P0pt/ZuIFPPE7BSirM5xT2WGa1OVPxzNRdHQb?=
 =?us-ascii?Q?qzV07oW34udZcMQFxZm/MVpw2kTo+b1OJgVZ2fFsYH9j0WQqIvnCVf/YVN9A?=
 =?us-ascii?Q?ZLkRkKnDzC3HPA11oLVBbIdSnWtK9W5oK0Fe1Xwcw/oMt1tOLlLiNvzPcvJP?=
 =?us-ascii?Q?se9kbTCf8fWtecmuUpY0v+/e0pglz5+OhGmlNYoqffjhJ6dzf7TKMO1uRJR1?=
 =?us-ascii?Q?Z6/1PthMZ9/s3s5kyfHi2vY38GvIdBLxhpAX9UNehBVGKsEgGsM4gN0L2BOW?=
 =?us-ascii?Q?TKkAkCqo9ARcuDWxlSKkdITre8sboMwKCs23mqqW7nCRP4LDra67Y6r97MHT?=
 =?us-ascii?Q?dcb2e4lW5Nu5wJu+lM8XCPYnpzyJfIAPSQ9IMa4te+SLIA+A5NJiep+8mJUQ?=
 =?us-ascii?Q?pvC8QQ4W4kEfi4uisUF35eZn4/f5tu2HWIhodUAeWrxH5Ne0rO324fHLO+yx?=
 =?us-ascii?Q?RG9yYmUEVNuSO8aQiNuLEN6QiFl4XZiQZ6RrnEdemERoqbPA+8QBNYAnB0pQ?=
 =?us-ascii?Q?T8Bk4hJIwh5B9+pThzr0ZiuprUnygyMzzpoANkkhWmxBXeSpbYdR4wRGDaDU?=
 =?us-ascii?Q?l0mf3+eV9sViSYdQeUFYuLoHYkLQ0y00cOt99/NsdSx588JpdXlz73szv3bS?=
 =?us-ascii?Q?M7YYb49OAvisbQ/Nm0LSHtauM4PPaEAoM+EWhILdviso7wgEk4EYbzr574nj?=
 =?us-ascii?Q?1Ve1+TWgVhYPJA2LPW63pzvMMFY4LwXRsVOCHpZOmiiVRexNhR8+6a0pqMY0?=
 =?us-ascii?Q?NK72WrtFPaIURYVpCZSKt5i8R7VhjdV7TBHDhAFCofIAG6myXulc6e+s2hsC?=
 =?us-ascii?Q?y6mJ/U8JTxGhEA5mDiE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b1f88f-e12c-4c17-dbf9-08ddaa1fae62
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:12:00.5584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWMaFwXkOkeAnwHYm/89iypEv9PaVvIfSbTlmGeFhwWSfLIdgraOs9SyL0+srOy8
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

