Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE1CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16ABA40A81;
	Mon,  6 Oct 2025 10:04:54 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011032.outbound.protection.outlook.com
 [40.107.130.32]) by mails.dpdk.org (Postfix) with ESMTP id 31AA040A6B
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:04:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK4OQikS83GvFjUcuzlGEv4PBC9H/EPc6D768xImvcaTB9DArGXhxWmU5K8Qc8utPzORwipuOkYalxx63GfIt1aJ/WY2JYpTiO+JzYVAmIxVzY1YrlxMB0Qu7h3DrH8ZGwy2DmTJ38NTWo8VqhYf2XO+dC24W+7EFNPG4oCEKsVDjrGwWYChMgCdks6hGAmIQ79RZb6wy4GFbLY5S9yuQna0C93HQHwjSZ8d7gmWrBAG44+hdLUBZOXIWZq5KeyrOHsQGgFyuMH7cB3frWvOw/qhiolCYWoQGJA1h5vcZtLJwlXm/nZemEBuuisukuZ0jseEjwQiwvkPX8GkvSfroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0cGPT1qtUgY8KB0IV6wETbyVOv7nx3ZBosJGyJuv6A=;
 b=c4qLJ3LnRrX+hD/Pv5qr0EQJJetNjj2rfHlPYuopuiVvo8WvvogLzyVWUpKzT0bDWTHbabnEirER1ybQphGD2TtinaEJSmntU/qINJXxa/EQBi7QluVPun+1vMJNq/x521NHWwE3tMJ8SZGJnSRp99sNeJ0adGS5zCu2SoY/4oiMMsioBWJHR+CmcnyfwKXXd+IWtDYwd8lfS8lQ+mePo0O5mYm0eZKgggEiG5hEsxjk8WizoBNwRdRfyKDHDqoWLNlmvSdy9EYuCwL76r55oUjyENkpqyyE4k6V5AYsldVIMWZr3QxFBh/K35/kh2YAoe1HhruSr312mp6Us0sKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0cGPT1qtUgY8KB0IV6wETbyVOv7nx3ZBosJGyJuv6A=;
 b=QYhE4rq4KGLEZnHvrXBByNODB1pQwXuZYoNF/9Abm0sFp0ObdT/QnumMVuxwvnxpwTY+XP6PAD/6jIVcRD852Re9aDa7JtZWyd2J1DYRK0JvUUCvswAmjE7hP1EN1EalVgYeNT3e+dvZCfPuIE8QsQunrydlPRBGL64RlPJU/cd+1NQhIS+fcjUByhhDF6n3A0CVcCUoZ7C6ZYkAdsJJVLp/8kiPwxhdvQbFDtPWzhO96GjvETSZbjFq4LDb9O3B+99XI/sYVsxUnaOe2BtCwLyDttPEzGvgsmodL6nV7HIymxBLWEEIYrISTPNt/7Z3UbXSt6P8xl2XNNHk/xoE3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:46 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:46 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Subject: [PATCH 09/11] net/enetfec: handle cache for forwarded packets
Date: Mon,  6 Oct 2025 13:34:08 +0530
Message-Id: <20251006080410.1433284-10-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dd0dcf-a556-461e-98f5-08de04af0375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?md63ChLQwrBYRWTZ0it9VZZtSiCQJ9UZnne2s3SouvLTvR3BigQVNzr1dvXR?=
 =?us-ascii?Q?MTTgUoMBvVbrr8k03Br48Ubl5BVKHAG5HcV6LR04XibU8+cjU6BU4vpkVYJ/?=
 =?us-ascii?Q?pxYXTDBTo4upsVWLPLXRfWTZg196oiff2JZgwkkhVmcC4pVM8W/3WE3YNaWE?=
 =?us-ascii?Q?83gkSl/Rb54cQyoeUQs/2/swQ+LeLEMIuwB4DXYFsp0RsH+y4gtPQP86TCT5?=
 =?us-ascii?Q?YzhdWlrKOFWvuD7GQZuME8E208b9audvUCtMDmWGTBcCJGzZWWUSmIGGQJfe?=
 =?us-ascii?Q?knX5jLQpp71SsdTJCfV32Zx8EQvzYl93liwwj2XnwraStUErdHETE3QkcYyD?=
 =?us-ascii?Q?uA9J2Rd32pxcKmLSUP4wBmzCgUjPs0APJSg/7kgMWDVgAnHpx1VpZY2VEg3J?=
 =?us-ascii?Q?ykCh7QFA5ZOdGCUBDpESNyFo33rNXeUENgxPDJ98RE4rdoSbi61XQbwwR3SC?=
 =?us-ascii?Q?xcydniHh5Ptt0k9oPQGlQv/MHKvEMr2plld9fL3x8tBxfEcE3jt0m8Xc6O1I?=
 =?us-ascii?Q?8vOJ1DNE5inVvrVzaXkC3Y9EYQFUGKBkwJXIj4HA8GbkKz/Azfa3yEmmgw19?=
 =?us-ascii?Q?uObffkKRpjR+kGp0ytgl74KaA8f8QZCyOJggzs9x5ogDVWVZOaSExoRNqUaS?=
 =?us-ascii?Q?Dtv1lSMQ58QwcCVdEU3FDzyOohpF1bcWpKbkMY7ObVjLtcwYJeigIDcUs1hV?=
 =?us-ascii?Q?XbgO8IwQZlBaj3A9I+NYz9SCGcaUtOR4PMX+DBi0EFk+qfzSg+A27ua1iUW7?=
 =?us-ascii?Q?4ZyiBKojCI0+o5pRkH7z7wBxPCqDruxVjlxFgWxwuNmCuJkJCG/3axsFfNW8?=
 =?us-ascii?Q?8UvYGS2GGVioUR9JyccaYnSTt8XOiwXFxC1xYnJCpD+BeEmwCdnCorYM99gH?=
 =?us-ascii?Q?33wRJk4/t8Rsyn6MfKnF2hfgeJSMlnwAOCkuLpIwD5xU4UFY5wz5DD7ozqSO?=
 =?us-ascii?Q?w+kvjOdHg8om01kRx41+G9fF0zVZyd9cfEAt2UFHyWCcHITxo7eaic6Fo0Cz?=
 =?us-ascii?Q?F5DOdKmLun1fWRb58DbU0U1l1+SMui8ILp0Y7dulQ2o4F0h/tRxiF1wJ9zlD?=
 =?us-ascii?Q?rv/+S6roHBelxA3RDm8WGx8CqEsZq4MfzRjo/jGQi1sLyMwGmMWQlV6fDvaA?=
 =?us-ascii?Q?zT6ADob5mXOokmSCK3d4spqKiKLvrQ4fIk3StQ8iSQyM3iIMxLPRdhcWpn7G?=
 =?us-ascii?Q?K3Y27Xq+VHqXVIxIvK/p52M+nxQFVRV7drwOc5O8CbZrbO2iHda8LrL+Ofv0?=
 =?us-ascii?Q?RH5KXGXJomuCkM6XR3WTU+cek1GryRlui1Ma92GR5Gug42DoXwwqHQEPfhx0?=
 =?us-ascii?Q?uRp2/vPKWg0JCf2zGZ2d6WkCsOxWAFBTh+82JYa5+bzGJW/VTPpFPFmk0ZTL?=
 =?us-ascii?Q?iejQdPk9pAChvkcBSUqmWLy4qk4ipQ0seHgn/wfwZKPHklBgW9j69VvGVlt9?=
 =?us-ascii?Q?KNa24c9FBepKqkAUUwUPHV0Lwq4v9B4/M0c5h6za186ue2W8M4DsVq+y7GSH?=
 =?us-ascii?Q?nPTG/HUbjB1nFBaRde4aaSd+z1HDtu5mg7pP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vhhRIWgAGbesUxQ9KWmZ6bAYn7Nn+Ib35X2MhVMmvAwWWRYcNT/3R4KPa8m6?=
 =?us-ascii?Q?EoXY7/4Dqzzt2m3bsLYuG0IsgtDqHsseMDhnxB9RuixMuW4W0MQWm5T0/Mrh?=
 =?us-ascii?Q?ke8Hj0rQklfZtop02jNyLHgpZINocYzgjjOgW7yYb3eeHEIPKEiCpnKbbjF4?=
 =?us-ascii?Q?Q6i81Mvfiq/0Zn0IpE+042PvcqluK51x4pR7HSlGKU7iA+uol0RcjAcOaSSf?=
 =?us-ascii?Q?0E82v4dAQUpVQ5tq8/fSgrMBEYqJBX0zH+jNfreEoK/0pWWiCJFrVMpi8uWx?=
 =?us-ascii?Q?ltulGWpvb6M+RGBB6x46x036nVYdWnvrgnrqDs5vdiJKgbLOB/B5BGuUSdUD?=
 =?us-ascii?Q?vwUGl1W+o5w+aZL1p78iEm8KaHfEaiQu4yGKUsnIwOcdf9CrQ0oWHIcblx11?=
 =?us-ascii?Q?YlegtImO3bRUTuf+4QQWbCYHXBklf5qQF860GZIAEmLBFyeRJaPvmlfd949S?=
 =?us-ascii?Q?xYUVcs4U0/bf0X2KjegAkIcOPwMpKgwiG9dejq2mfGR+mIz1T6QVd6PLOkqG?=
 =?us-ascii?Q?aTWwCR2ETnfR1cv1BV8Yn6ByOQN9tObbr+MpdciuI5LNH2u/rkpde9E87TrC?=
 =?us-ascii?Q?vh3Sbe7jL55WMOocltxmaGnFR+LUDsMXq5HiMUddsNkTkK1SR3B8MxAIbJVz?=
 =?us-ascii?Q?z5FL4K0k5KVpaxD7EoWzZTJIWLX2kfWLlt8GhvI7zc4YtJ8qgMiv4Ro3o1Bl?=
 =?us-ascii?Q?LFkmuFLDbUlUC5Kpxqv+2Fo8Mb4oFmRNOIm34Bg2OXcBA2nFHXA5sAnVWr2H?=
 =?us-ascii?Q?xoQEG8kdauYxc49Xenvqgh7VUIChHQJ62A/wYC/3L/sIXdjSmvNb2VbxfrTX?=
 =?us-ascii?Q?6IH19aY2CaAKm4rbEiuEPKXTcwHlGizSwz5N/+W0hWXKeJnpB7INMmit1P23?=
 =?us-ascii?Q?mHZy3R54QJ3tOgBZxwzMIgaGGpqfVkQeseuYZoRUXe8rij2I/l2AkQnskHZc?=
 =?us-ascii?Q?XUkXmJH8HShykazhwmo82JFvrdO27Q0SNR5MH1O7tbHwoKxqgzTu519IFXu/?=
 =?us-ascii?Q?awCwbuzj0gcL/2FEsBg9CLFKXFqQ0zzIzDSiML8WYli5oMIGSJg7Vr5bMjGm?=
 =?us-ascii?Q?LUaGftSGNIELr1qqIKqH0voJ4uIQ4WyTFuPac55oMoKBdizBQuCqd+6CNCKU?=
 =?us-ascii?Q?Dok6F8ekJzuhHH+Wr1vl0xWCwhf5E6ibpEUZWX9QvLfLGX0glaIl+KIIkysc?=
 =?us-ascii?Q?sXZQg5Al7NCEH4uV80/dzlCjzChMWBATgUs2pUxqBXEXzNXh3IK+UClXYror?=
 =?us-ascii?Q?hJ31wyQMPIoQfP4XNWQalhQUqXAysn2Vqk4nDu7h2U/why3Rhwc/yeJw5E1P?=
 =?us-ascii?Q?IP4x7iTWkCXRZJMGPr5FfaJl3K5PvAPXFJnyjBH714OaWx1ERRmdhhS6E0oU?=
 =?us-ascii?Q?KZJx/pKRItN9j08CTujd1nBHiP1HsYsgEIbIHONxoXURoVYct216diWvoaw3?=
 =?us-ascii?Q?xF1k1I0FoF7g41JKptOr+gr/J4tE2/eZE/TCKt6bjmr4dtOtT92rn/rHfpmZ?=
 =?us-ascii?Q?AfBy+H1mqdEkc0fMWR8vTFnwbh4D1a2rnh5LZlV58yy99/qCXG5YLhVY6NsJ?=
 =?us-ascii?Q?MV+mLg92iGxeBL12RvyqxsoAS29N1IXM3DuFEQ0L/PpLfcseG+ITg/wgxOHa?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dd0dcf-a556-461e-98f5-08de04af0375
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:45.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZLkq2Gv5BACsshvcWlFJ99/Q+MWebUyrXzkIHR1zKKevj5rgDXEs5ZOh5fMOySc/C6/nVPOattRMfFhm8beTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

Previously, only cache flush (`dc cvac`) was used for packet buffers,
which could result in stale data being read when buffers were reused.
This patch replaces it with flush and invalidate (`dc civac`) to ensure
data consistency for forwarded packets.

Termination packets are excluded from this change as they are not freed
by the driver and do not require cache invalidation.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.h | 29 ++++++++++++++++++++++-------
 drivers/net/enetfec/enet_rxtx.c   |  4 ++--
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/enetfec/enet_ethdev.h b/drivers/net/enetfec/enet_ethdev.h
index 4e196b8552..ee5c244c91 100644
--- a/drivers/net/enetfec/enet_ethdev.h
+++ b/drivers/net/enetfec/enet_ethdev.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2021 NXP
+ * Copyright 2020-2024 NXP
  */
 
 #ifndef __ENETFEC_ETHDEV_H__
@@ -23,17 +23,32 @@
 #define __iomem
 #if defined(RTE_ARCH_ARM)
 #if defined(RTE_ARCH_64)
-#define dcbf(p) { asm volatile("dc cvac, %0" : : "r"(p) : "memory"); }
-#define dcbf_64(p) dcbf(p)
+/* Flush */
+#define dccvac(p) { asm volatile("dc cvac, %0" : : "r"(p) : "memory"); }
+#define dccvac_64(p) dccvac(p)
+/* Invalidate(Not working on A35 core) */
+#define dcivac(p) { asm volatile("dc ivac, %0" : : "r"(p) : "memory"); }
+#define dcivac_64(p) dcivac(p)
+/* Flush and Invalidate */
+#define dccivac(p) { asm volatile("dc civac, %0" : : "r"(p) : "memory"); }
+#define dccivac_64(p) dccivac(p)
 
 #else /* RTE_ARCH_32 */
-#define dcbf(p) RTE_SET_USED(p)
-#define dcbf_64(p) dcbf(p)
+#define dccvac(p) RTE_SET_USED(p)
+#define dccvac_64(p) dccvac(p)
+#define dcivac(p) RTE_SET_USED(p)
+#define dcivac_64(p) dcivac(p)
+#define dccivac(p) RTE_SET_USED(p)
+#define dccivac_64(p) dccivac(p)
 #endif
 
 #else
-#define dcbf(p) RTE_SET_USED(p)
-#define dcbf_64(p) dcbf(p)
+#define dccvac(p) RTE_SET_USED(p)
+#define dccvac_64(p) dccvac(p)
+#define dcivac(p) RTE_SET_USED(p)
+#define dcivac_64(p) dcivac(p)
+#define dccivac(p) RTE_SET_USED(p)
+#define dccivac_64(p) dccivac(p)
 #endif
 
 /*
diff --git a/drivers/net/enetfec/enet_rxtx.c b/drivers/net/enetfec/enet_rxtx.c
index ea2c28a26b..95767b561e 100644
--- a/drivers/net/enetfec/enet_rxtx.c
+++ b/drivers/net/enetfec/enet_rxtx.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2021 NXP
+ * Copyright 2021-2024 NXP
  */
 
 #include <rte_mbuf.h>
@@ -230,7 +230,7 @@ enetfec_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		status |= (TX_BD_LAST);
 		data = rte_pktmbuf_mtod(mbuf, void *);
 		for (i = 0; i <= buflen; i += RTE_CACHE_LINE_SIZE)
-			dcbf(data + i);
+			dccivac(data + i);
 
 		rte_write32(rte_cpu_to_le_32(rte_pktmbuf_iova(mbuf)),
 			    &bdp->bd_bufaddr);
-- 
2.25.1

