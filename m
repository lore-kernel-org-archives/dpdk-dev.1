Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF008CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 05:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED4CA40665;
	Tue,  7 Oct 2025 07:00:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
 by mails.dpdk.org (Postfix) with ESMTP id 49D2440665
 for <dev@dpdk.org>; Tue,  7 Oct 2025 07:00:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOCi9G9Rv/KasKvFk6C8HLYWDwAVWFps/ATw5vXIm04/NYrof/bx75Z9mfZH/OM0GdeaZWF36DxbREDiNsmsCPDC/lKPeRSy8S/rRiO2rhxN1QtR2/7t3g7Brd90Be56YMTsGYxSGi3Jj/ybttjnO5rB1cAMBFucJ+utjlWxnFgbCzcVeu/UYJC+ZKaxkiII9P9G0BK6i12oNO9/hn8qpjXFVufDgevsF5cVgSwp4CScztnWYsV8vZL0/ltUZy0oLlO2ucLh/j10pRnLjAElPUJ107XbvbPsAI7pvLSj8KaEHNbUNqmrYHMhppb8LLtUKDam3UOZzab1eNI9vd9bGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rax8LOokXK2PZ6BGrxhpvDDdcYSpXSlU7SgMzyKlynw=;
 b=SURFPkAA7Q1DNtH0jFxrHs+9a8WPIpG51Vms+344Tzte6CW3w0FZ3KpNdg9KJJoH0RmthuPQ4SpY9GWbshxUlvRdzOVzHKf5xiWb2prGmmJjt9ZtCdkVzqfBuIDOKj2411PAeeQcG/Z69wQg2rVsrTfx6niFZSZ/wL28fMpZD7m38J3OuBClecpKXIIysxr8cUvqzzq/ZxE9e7GCLd9LLvWo95vzNAmjYAyTalvYwEUltz+yIm8A8akMGfz1NZ5FJK9/BW0m2dS6ad+cPCJlNyJaKOpfuaTwaetAd+srI8FVRI0ClpN4Xv534JIkMr7QGnje3SuIpVrZ6G8p7qILFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rax8LOokXK2PZ6BGrxhpvDDdcYSpXSlU7SgMzyKlynw=;
 b=NZ6/hUa3yW7XrTQynC2Sb4Dflij2sWpfbSXz/m4Ji1eyrAq5WgMkeuPi8/fDl+u03ZxaRPQAqjEq5jlB8BLk8B86Xj+Qsr4NYwhuklxJ5TlxEYNlZblU3mwRUfRWx4FoipaGOb02nOD+sKJb4e14lvTptT1u7VD38KZ1uycYgQbjHYK1Js16XUeavA5G1vhF4dgpKzTaWagf3TGItIGKwHzmkEyt1qvHoHzjccqkQAp8H0HE9v73i+XBBKpYvAiLRP2pw9rjFlxvVXF/sSZUmiPmGx5aJKhnPraIWfmC38Io6VLjxR3dhsLckMTwcEWIaga2oT1tpaWlxASCtw9Lkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 05:00:36 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 05:00:36 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 3/5] bus/dpaa: Disable qman Invalid Enqueue State interrupt
Date: Tue,  7 Oct 2025 10:30:10 +0530
Message-Id: <20251007050012.2432449-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251007050012.2432449-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc50b45-ff05-4d9e-ce62-08de055e73e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rwswr1C9SThcvyDubLb2Ka2K2j/VQh6Pv4VN7f3IdeuQ0smmVAGbxL+raezZ?=
 =?us-ascii?Q?JxoRmpD9z/E4Krgsd+mBlsGquS/KlOwBLK0/kRRq6OI74TL8hE7ihs3jVPKs?=
 =?us-ascii?Q?r86o6D7c+tXrinB9xZLCEtsnWywTDRkHdn+oF2z6PeFCsD79YR9O390g3YUm?=
 =?us-ascii?Q?3t8z+8CKQOfWLbIGBrNCRWdeHMg7fWbkDjiEKkr6kBM+bNQixXag33Z4Em1I?=
 =?us-ascii?Q?8H8aCI4UeeeTtNWNANexGR16ubAlacUjUGJZNScCBdsY8cjTu9Dyv4tMIncS?=
 =?us-ascii?Q?xuYfFlkm19uUPR6RYj0v+tgQkoRwa/l1gCHzc094C4MniyehvEvkuUFiE54Z?=
 =?us-ascii?Q?s4FxpT3s0QY/eJffmr+zOIIeg2b7twPemsY0e83T5mwTvFT44sRY5SKszomw?=
 =?us-ascii?Q?5EEk0uBoQgptZgmaPPCewHdV6XVjCXdet5yziZ2y+ctTDpt1E5Keapog6qFm?=
 =?us-ascii?Q?f6UAsJ05JOZRzWzce9Nl6+LHrnQh55ulHyqmYcOISB1vpRRvGmaQk5bjXk4K?=
 =?us-ascii?Q?wa+hVIuMN+Q3nHRG8v24tVqpK+tbNFkrZeSstv2mB1DqKhglKvBtyYeVIFnZ?=
 =?us-ascii?Q?VQAzvZKdly7UAGcBACKdfe2kZRx4Ry35QAICnItD4imfnEurk5DH09ez7j1z?=
 =?us-ascii?Q?VJaI98qvoQoCWkgkIpBGfHn6JDegzQESQykkOpuZkTnveRaL5ZPuuBhMGFtc?=
 =?us-ascii?Q?S3yk/d9VqYSbOLYBuyQskLs8eHdPCwvGaaeE0xd2vWPC9m/n3n6pKYoUrx4U?=
 =?us-ascii?Q?jdA2wB5bYhoBUAJPZ6xk8pCZvw3fi/KvX/xv7/NVbuqi9oMS8sp5sIem2V5i?=
 =?us-ascii?Q?HqsMQnthZ+eZclNv/xnzuu0lYIjxjubgdjGCmImwuFpcpyhwQIBIVYOvS8Ww?=
 =?us-ascii?Q?F5FXhdtu9a/S0GJk4uEr3TwndxKwu3zB09SzOS7lm6pu/GkU79PNMFzTimOv?=
 =?us-ascii?Q?/8nfNuNukSYpOHhJSQ063xBSNeqdNPfwr1LpAZFShwzM6Z2HGsLUeYSijFvJ?=
 =?us-ascii?Q?HIkxaGyDIYKiAgKYKNwgYvjFHDzv+lHPWMSySnUWsWkP1A7wQO0hARdp/2rB?=
 =?us-ascii?Q?hjPREl0iAvexgFC3EzmI8EL+d/WMD9rkOF5K+JmXqgyTz6DulypV7/MGfoTc?=
 =?us-ascii?Q?KraENHj9bNJ4wEWnO5D9cRXGy0V5m4l1e3VJdjehO6OGYnAwDGtW03Mg55rU?=
 =?us-ascii?Q?lEdn2G6Bdu0OPz8nBCzTl9NkqeUn7zMc4XYYneK8SDrcjRemXpAE4VdkRiD3?=
 =?us-ascii?Q?8qLm03gmvTvnxMeBDQqgX1x5bJI9S3iXWFRrBs7IEs9niqUO7bEumkhtRRgs?=
 =?us-ascii?Q?EJImBN4n/dIHIVaJPHe9jgYbrVG3PxgxyGtmkfuLeBk5UF61ZmA8788WUd2G?=
 =?us-ascii?Q?48+ynYui496WTjbehvIY7w4Ka4DGsmgkOeGMB7PfUAIOEvfWsWDxn0HUXD9e?=
 =?us-ascii?Q?c4y7pmVVpO2O2WgqAywNaStNPJgPAmT25Lr/1uC+kH1QZ4+CuEEODPQmC8rA?=
 =?us-ascii?Q?SN42FQJvgiGsAFvumg6ZMhxTIoZuTTrGICMA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+esRQhxYmYxYAK/s2nk4ooScxIVHUncFpHlX8wrE0Px9rQkECTxNNWmPPpmF?=
 =?us-ascii?Q?JqcVzL+0GlJ2VZWiZhVFL/048+GMtFHEaCWlsJFE4dqGdxQXcUJWJ76LD8Fu?=
 =?us-ascii?Q?3jcG5ASFD5SVumlChqylvegxrqxLx4j4PpXEUhODc4rgdFeSbYEj5f3l8YPO?=
 =?us-ascii?Q?3mVBtbKOXWIc1TcePcX89t3bIk9QK9M+NPaRO/zqRLY//Igy5Bobl1+eaDfy?=
 =?us-ascii?Q?HDocJ+rFtDC8UJdDiqldp14Okv4TijxNJRG86ke1ddfQRycje9rid6KHlcxn?=
 =?us-ascii?Q?wNa+2BkZ2dGqDWY7XQSKg6w1Lbvf465KK2AnOW3pocukx47qNdCecCK12K+A?=
 =?us-ascii?Q?4jRzuCTbP+A2X8YioRYTCMHw7d2/sVQdUK9tuCNq+4JggzPVQLUJ/h9cSmmP?=
 =?us-ascii?Q?eqZG/3GWTnza6Bsezmj/LZjEXchqkyeb5AHomzSFSHP3df4yRhdbbwn7G8T4?=
 =?us-ascii?Q?C+Fp/HXWAgNHQGE1XfHsOJFn27ps3TXvoyf6SO1wMrM0wRU2x3eu3Jvvba/t?=
 =?us-ascii?Q?61xmFJaZa3xLZ+9X86zecdmEHC2OtWIZdLbHXevYmMV6cw+hSMASA+9lveXX?=
 =?us-ascii?Q?Q+1H2N22HSCiN0pyvS9+BGPq8w5XL+g2lOC2kDPzqhuVUzxrz9FblT1PlNxx?=
 =?us-ascii?Q?Jhzm9dmPbxN0aOdzRr+sgcqf1nm9mUy9VynaEbwmLnSttJsZm3bGrPqKO4AI?=
 =?us-ascii?Q?W4dvNP1l6+MXQOhclzDHf6LIfiwZx+VaSoKGcOJmj5XKA8ttVFabbHyVUwDo?=
 =?us-ascii?Q?Pjp3ElzL76AsK/pXjv01I1AuECiKYycGGdBdqwStdGBkMj6sXPHe/A8snNni?=
 =?us-ascii?Q?eCEKcPgATGtkb3v3fZ7ACwPJxT2/VSiGgr5V766qHbdMRlCUmGjLFig5GXWa?=
 =?us-ascii?Q?hb1kx99Mxy512EdKEokNSV1HDeO6xuUaIuSKOUDZKAPdCmGPil8BT7OMQh9s?=
 =?us-ascii?Q?g9NPotq/72cN+1CzHpaUEC6F69uFPurZoX6LtFWsAHioV9YqAVk4lbJUUWv9?=
 =?us-ascii?Q?urdjOYCzNvdBTVANq7djkAOfBAOsD2Ww2fjDK3nmlNUSY+uJRoY97cbNC7y0?=
 =?us-ascii?Q?chqjwlbMq2hPTnj5xZKkywYF5o5rFUUbWsLnLbs4VQJw0VSXCmZG6KQJrQkq?=
 =?us-ascii?Q?POXPHBzfXhtih2NxY2a+7TKQsLWH6gNeMzXmpoL3BkA2R13jTEMUqZR15Dr5?=
 =?us-ascii?Q?GuJR+xP4P83AXly65NEGjNJh/g8cabY9tHEGjQAWPOyOz5JDPkoOo+vORhPT?=
 =?us-ascii?Q?p3XLm9pvZSVkhQFzs+5XuFFXYsF9G/ZkGTnWaF1yyoeznk5E3CKszhPK1SXW?=
 =?us-ascii?Q?X44i3xP48LkzplDrOT7FMI0KEKEDFrUy79cFa0qz0qpL+xVcPUIIVJFDqd42?=
 =?us-ascii?Q?mcJg6tfLhVj5iRHuShKTFy+mpWoMeS0yAfeTyb7teU0Qe5J1IfhAv+O1XbUE?=
 =?us-ascii?Q?yY5jAeW4ZvItkwpYK2OzQgTzBiqwf95fqiRKplo8hF/CG09StLkybe2nMUIo?=
 =?us-ascii?Q?8BbqdsrkHP+NFHsP0UU222HMXpsyn3AP/2KoK+EksIjLg0qtvpenatrpgyAZ?=
 =?us-ascii?Q?0zxx5bwIx+AwKeNzG04=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc50b45-ff05-4d9e-ce62-08de055e73e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 05:00:36.4282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8xmUcHK5dqVb2yxIWhDg2sGsIJxxRoHvKuSje845rcfzwnR/iHnklj91HWmZEeN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178
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

From: Jun Yang <jun.yang@nxp.com>

ShareMAC port is still alive after dpdk process quits but RXQ setup
in dpdk process is in invalid state. If high loading ingress traffic
hits the FMan PCD then it's en-queued to the RXQ to generate frequent
interrupts. This causes system stuck.
User can disable this kind of interrupt by env to avoid this issue:
export DPAA_QMAN_IESR_ISR_DISABLE=1

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman_driver.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index cdce6b777b..3a202c6b77 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2022 NXP
+ * Copyright 2017-2022, 2025 NXP
  *
  */
 
@@ -32,6 +32,29 @@ static __thread struct dpaa_ioctl_portal_map map = {
 	.type = dpaa_portal_qman
 };
 
+#define REG_ERR_IER 0x0e04
+#define QM_EIRQ_IESI 0x00000004
+
+static void dpaa_qm_iesr_irq_control(void)
+{
+	char *env = getenv("DPAA_QMAN_IESR_ISR_DISABLE");
+	uint32_t val;
+
+	if (!qman_ccsr_map) {
+		pr_err("qman CCSR not mapped!\n");
+		return;
+	}
+
+	val = in_be32((void *)((u64)qman_ccsr_map + REG_ERR_IER));
+
+	if (!env || atoi(env) == 0)
+		val = val | QM_EIRQ_IESI;
+	else
+		val = val & (~((uint32_t)QM_EIRQ_IESI));
+
+	out_be32((void *)((u64)qman_ccsr_map + REG_ERR_IER), val);
+}
+
 u16 dpaa_get_qm_channel_caam(void)
 {
 	return qm_channel_caam;
@@ -343,6 +366,8 @@ int qman_global_init(void)
 		return -EINVAL;
 	}
 
+	dpaa_qm_iesr_irq_control();
+
 	clk = of_get_property(dt_node, "clock-frequency", NULL);
 	if (!clk)
 		pr_warn("Can't find Qman clock frequency\n");
-- 
2.25.1

