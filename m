Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD3C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A37D406B6;
	Mon,  9 Jun 2025 04:55:39 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013031.outbound.protection.outlook.com
 [40.107.162.31]) by mails.dpdk.org (Postfix) with ESMTP id EE1594066E
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdwIJRApTmHlM9Tn36lI0gRkzwtyktZhxh0D/AaFq5OgDBMckwPEn+BCDPY4hGWEIfzZ2ZxAxFqiw+r2Y97pMmWRQ4NVW91nui6fXFpURy8dw11nX5d/Tuzc9UT2+Tybnptf9ih5tjPOZDN7rAM0lUAIAla6U/fBi1RTUmUnZ6QVPoYyCZxqIdWsDr+P1PeAfbZ5yqrpjP4GVcnD7OaRwdweG9JjA0+MHiGXf/DGlGE1H6Mypqkj1hIPONj0xh+mgS9neePplrjKvGdTTlkrBbGMWSe0lTt/q9ieS97Q0s5+Kw+DmXvXV0MI7xv3E/IbtWC3Xb0m/tEN6CWOhUQkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93MdefBw0jA0A5+WRy0g+aG3ddRyCdD8Xq2wUWWv9ZI=;
 b=R/1eTRHSp7i3lqsLprUF2R0DbjQcYjtuySDLaFRrfx0mDlGTHYOd4opzyOLM3geiCuU+3Zj4At1Gu1YK4Cafv+PKK4Oyei8O53QQsnM3/5dyaqe6h419qP/1qHF5bG1UWRp01XIizNGV/mjkZviO3r6qpb6FNIHctAxdvEIkvsQa3w2Q7gRdnoXW47TV/xQYd9pEUgz9Bvsmh5bfFUq2n7OvuLY0l74Ju3L0AlwZRPTlq5s09B/6UwZmEoQUgQVsHh1tHWWCkfe5X6ZJPuxlL5FNAG4y1d5iAFIQ1nVuU9OowrwezPt1ctjLIzvbza3KhhhfbPiIeJM1UEzJutp45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93MdefBw0jA0A5+WRy0g+aG3ddRyCdD8Xq2wUWWv9ZI=;
 b=EZKCMQPo8ivQGVy8kNrg9z6NJSwvjnOmYrhdBCscOrlRgM61PpJAPSzOdT2CEY/S8iZGhEHYbIVqOBZ2kq5lnaoNAIkpDVLJNLR3XW9PbxXE6O0Ny5Pq+Knk4i5TXAaRsY95nRUvzjiOtX3mP3jUTieQywMZIk6vXD3t0hRFz+b3aLr6wMZbVAA2NmoYt8qkyrQiRu7AMRIgQHHCJgybZ4INRRWiYANaY2m2TT7XODb+I4G5cJn/69KK3Lm4Ab1FNuV294tSngCt0ZOyLe/cHCTtwc/t96RuY8WYL8piHtcnaB1tH9Zw43n7MUUqdX07EzSokEQhPTxsSQIOYs3TTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:26 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:26 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 08/11] net/dpaa2: support dpmac Tx stats in xstats
Date: Mon,  9 Jun 2025 08:24:47 +0530
Message-Id: <20250609025450.3997062-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6771ac5f-c8c5-456c-bb1a-08dda70115c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wumle7D86IMpoAlezXRRMYDN4/Ed/wk/eaX0ikGIIRKgiKz6M+fZnCVERtBy?=
 =?us-ascii?Q?FyYA6XEH8T7luEvdcBBpktV8T6wEXqc9Y9800h2DwhF6oZ6BJY02+8CTuU75?=
 =?us-ascii?Q?O9p1tgIKujxJRy848QeHY6ozhUgFbiXk7cdRKBZTt5bI/EUHPFg5h4vykl1d?=
 =?us-ascii?Q?kuFvHvUYhErIjssD1mUpBrGLelERbXIMMrAGALcfrP1F6Y7pDn0avZ8o9vmk?=
 =?us-ascii?Q?Y0TNVzTgh5KKqNQczMtavdY7Rx2TrHt//Jrgm2cLT/CHPkPTHESuem6J9YBW?=
 =?us-ascii?Q?SBK/rrCgFPFDfdcD8W9Jz6RbM17UZq8BcAxdrEdxxVb/rF11ptgFS1D1mgIT?=
 =?us-ascii?Q?vZqGd0gAHyzvDKZ5nVeRIy+AwU8BhOIy2xdCNGetsZHDdl0+dAmidb/mPpHD?=
 =?us-ascii?Q?bOIxtChsSxUAzICExOqfjgu04Mb3kvl5luYJtoHp35bp34ElpSENwOxbAMoc?=
 =?us-ascii?Q?uPfvCqtotGDps91KhfBFwlLV7KbGWf3uji8re7w76XzkwFW1fmnfyzUKIcGD?=
 =?us-ascii?Q?RZqtQ2T6cxYuJxCFGxxLh4mLc6mgQjfqgAoL/s0zyLYeoL8YBTDWhX3+O+T2?=
 =?us-ascii?Q?RdBFr97TcOjOcYd+lmSRJrWuryH+CIIXclPebL1ErpdqZZ5A6m43PsfkoYbA?=
 =?us-ascii?Q?cyNRZuwbF45DT3u1ASxpANdU4dwsMPUBWwD6+E6BI42AmjQqVSiXJ3plb7n7?=
 =?us-ascii?Q?R5cPu8qpyvL8ZJOeGstOav4XVS4D01ebiwF5R0SfiwUpvgWkA9OttNOb871S?=
 =?us-ascii?Q?mbOWHivUxcG9Gwv0HUvErjHpk7i0S9708yUEzHgX9Wkp/XA9CbaY6XPTTf2K?=
 =?us-ascii?Q?O54XtvXaCUQadLBvOKSrQqHxHSie7fPuA5YTiubBOibDxD3+M0g2689HPYXJ?=
 =?us-ascii?Q?PqS5l307Rh1qIe+S9V3JY4dMfC16w/zLsshNUPdl1DaXSFiiauwmZJUii919?=
 =?us-ascii?Q?fdBKB4Q86m1d5t8LcunZbMlunABXekb6qEy4TaAI5axsaEWeB7TgvsoIUcTt?=
 =?us-ascii?Q?oFyDUW0pzlMwB1ndQjDUwUn49Kk5VyAGJsf8JE2LOFlU7nh0ZxaLayEu7hui?=
 =?us-ascii?Q?wKVkAzTQVyg2ryGmGGCfWsDfC6E38Va87xkrm+s3YstjWJl53CJDoRu1Rw6y?=
 =?us-ascii?Q?x1WGk+xjofajSO0vz+m4Ysp855D1W2eynlG0ivHN5tuCt/5aW2k+m/xlS2J7?=
 =?us-ascii?Q?yGd4V83317euvo67yQlZItJJrA+13iM1fut/zxAbeltmP1GfOPQzb2rPOmSi?=
 =?us-ascii?Q?yuM7KNX47bEn1YKtby7yQ23/Q1sOFZT7ELlBlhEHlBV+eVOOsPhh+l55D7MD?=
 =?us-ascii?Q?bsMhlw3KfrG7GBEcmyI5UeE1LeJupQlhCKLmFfQ1zlczreY43uk4zhGelh0K?=
 =?us-ascii?Q?ECPDBEj5d33kOrGZ/718FFk8wLcvsPfXgDRQ3I+dQvWhfmmWfekPIGnrgAFM?=
 =?us-ascii?Q?IejQS8MOzV53O2gEdiYi05yZx0xu7MLazy6J6lRbHePwuN/40myppMoOhy3K?=
 =?us-ascii?Q?UV7X59Xx6m6SPV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEQuDTqZP436LGfDFGIlZkhbgzUqMo9EvISZ2FtwrNkhUkycedX0Sw4Llihu?=
 =?us-ascii?Q?HDuzVruwtUgDAmR+xMsxqXLvZFrbBIFt/mn7pj7Y4CenGCVaby079hwePITv?=
 =?us-ascii?Q?cCjIBVL4SaSNmSkq37m3FZ0lfZAAdHXI3FQVFuBdbs9mHAO7fTyeEQD52KeQ?=
 =?us-ascii?Q?C7TWwoU8SrIac9wb79RjdlbGz4r05bzzH2OkuXeQs5sUyxon1Y31wgYN5HWb?=
 =?us-ascii?Q?7vi72UEW+o6oWGxMbplY7qEgr97/fdbmBTlQq6o+Ntg159YtNWi5RQd+65wx?=
 =?us-ascii?Q?CEy8NjXI1OnMGZOWSmgXbHUkusXdeuZ6OO648ITQKTuSYp7VO5W4sBmksum2?=
 =?us-ascii?Q?GVzaEZefRosGPAKGz1H3P6fEnAszRuerti30+QPG1rJD5wNsXjD+cN6EchXg?=
 =?us-ascii?Q?VQIHkLhFZnA3L4K4yPOOuSCV885oFd1kEGqKrf79SdhxyfD3jKySgSQlnnk/?=
 =?us-ascii?Q?kZB03ktjTmAjRMNc90O6oVFWABNAZ+bk0uU1G60ubMSGYgqBW2SHtGCGP4Mh?=
 =?us-ascii?Q?UoYSnldGay+FclG19EzPUQxOgKNU1pWDaeEFCPND63Yj4TgnESbxZOk8/E1W?=
 =?us-ascii?Q?f+Qw/kHbO4QX9+pMhEY3XjPnGrFETRKzSw29jOPQXZ1vWFey1fc/EKZDE4Y8?=
 =?us-ascii?Q?5nVku/6XaVmUQ5oOyTUr7OM3XVvkIGEAS53NivSL4J8NXTsWasLCzGQiXA8D?=
 =?us-ascii?Q?A6uHGOIALfOMnCVi3wqW9KdV8Zevj0GaDomesZfptv7S96HY1pUx0pRj91CS?=
 =?us-ascii?Q?/klfbKsIfRAUOLbhtoNTsJ7W9nCbsLNHIOiXRxl1O5SPRmAA6hyD/7nIQbJe?=
 =?us-ascii?Q?q/nFiH/ZWY7il59hNLvfG/oanlGyea1RnIj+ixDVuefvYtL4M6+6KgwHwpBS?=
 =?us-ascii?Q?Siyby35vxjR9iSAF85AVCcQFMBptehDaMYoN9fXK8NqRxnH9Uf5UcpPH+r50?=
 =?us-ascii?Q?CWFIz7qPu36iVR2pg0VCnJC6PpjCQTM9V0zaB/Cvgw8UTtby65NWin5p4T+8?=
 =?us-ascii?Q?QADVK7gophL5wUbvPnD5G3DoXvklBiJxnxzlFhM7leBSrvmqF4H1125xMphB?=
 =?us-ascii?Q?IV5pMo7JPsJgn/L/0ou6hEAzglwdVvXvlNN6EndhnQq9t+iJgpqpxP/wknkw?=
 =?us-ascii?Q?BlrB/S+3MaTcWdvzdHX2w0GTEXtFe8u4cGCaDlI4ZkF2Sf/7LAz6E/yLHV+G?=
 =?us-ascii?Q?KaaxTA2u/gytaJu6Q21grrCWUHpwaJBo6aN6iLJsLtwZRj16MQuWnvQjX9Zw?=
 =?us-ascii?Q?WhSPn64TLNezUhs/QmIN79PtYEbDcePbG9FmKJ2pNrR8kKLZ0VNrHQczsVUb?=
 =?us-ascii?Q?H8ut0ThwwrljZ1g3Xugd2dn82hu1FXiBm8woW8lyQ33wEwrmzQV8lhUqATOA?=
 =?us-ascii?Q?G9ieBBwulUfXptaLl93pdvAc+6S/Z70AnBW74A+GhBKMFkYbuVaGFXvFVNLf?=
 =?us-ascii?Q?3BwzaDqs+fXysiZqStLQcAnril5uU+be79SapxVOtoK5MLNiCk0HQF0qKBFG?=
 =?us-ascii?Q?0gtILXY11EDPKcOkNateeoSaAwomLDSv+N7/RBSbkTdKUxtSueYR1iSUV/9n?=
 =?us-ascii?Q?J906Q7Xz0Ce5ReS0Bes=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6771ac5f-c8c5-456c-bb1a-08dda70115c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:26.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XhIfdyZS9wxJUUNuvTfM/W/NkMQNXEcofiXk7lPQ3UKgJn5bKtypJT1ZkS16gvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

