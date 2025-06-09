Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AFEC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:55:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D3B84069F;
	Mon,  9 Jun 2025 04:55:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
 by mails.dpdk.org (Postfix) with ESMTP id 570D54066C
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLKltCTySddAZhU8H8sCusbk+rkPatKaqIa4WpdjdVCViuTSrv81V7+UJVpcGGRYiQQHw1ak7+NaTbvrJstjwNgElKhRbDNpreAFjwh1aF3y5L1RVXqyDJN7Z3XkYaOblMdiXkvS7T6rPvm7mweAOaki30dxwK+a0K2+81y4h/6M8M2HkZRI5fUAdSgM6SUgCIeGd/6O2a2Q630cnSjNcEKnW7GeQS4GjFz/SwM2Rfj4QF9cUkNC0S3eP3Nk4aadZhczCEVjZ8eUyWbpa4Fmz2ps/aRXz1v9tzB5ho0TPo/hqXTfbUzwPgnO7yxnIRcot+fpN8ZDbDnNgNXPzS+xQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXumNXMJCIn9NCXTm6/Sh3sO2xeLxR0+mc81dbMzC7w=;
 b=oQKKwAOBWldE1W+YzCT5i+E5rlyxaZ0wTdEHS6+drOk//WnZ2T3Iqb7IESUstyFXLRmIFQYcG2LoiVAhnxHMmh62YQqw9nWH58jg55g1UIvAwbnMk8VW/wCcJAua27gpwB8GE6ZVsb8UclEA1ZWI5oHKnouhNIzwR355JiKc96EAeMFCmpGAJ10yJlFKvoYLp1Xhnbul/2JidYD1GmHKmwoa1cQAk5Zzt4PuPNAo0F/MLUfM5FdVK5+myjiw9JdW4jmddPk/4z85bXQ6zTsUeqlVjN4ErU5UUlL4Xd+lDV3t5WAuGNcUGaSDpTVEaOi/iQ37Y2L2OOgJdKkyUzQbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXumNXMJCIn9NCXTm6/Sh3sO2xeLxR0+mc81dbMzC7w=;
 b=gsudMghQq5hy9B2SctqlXqVzEyNbF1cUMonynCCIo5Q1i+1BmzYfJ9O4PXBiS2lR8+YomQafMUb0vAMo4XnNP/zNjtUXEj7rpTgs6K+rLSdBGhDxyfYBu8JifrF67QRl4Dz2ts50A5aPDt9x1xYO8OwVVmBqU+yOlgtFqBe3RpRZ6ikkG4Esb6My359h0S/XIhusBL2ixcKpiSlp4FuI9Upb7T2tZfmqbKqCj+15rhduqiFb49p///KmliQsTs0dQYMXYyr/MgXQKz4q7AigAmafFeKeYam5lEJOM6uEQMOWPtNwHi/C2YvGqrY8tOeUYYRhpHH8lGK6rvfcaq5hjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:21 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:21 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 06/11] net/dpaa2: support dpmac counters in stats
Date: Mon,  9 Jun 2025 08:24:45 +0530
Message-Id: <20250609025450.3997062-7-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: da1c67bf-2b9f-483b-fc0d-08dda70112ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?haioQo5gUHJrLyVLjX/9eOM5jwg3vOmKZEfjpXziOQcitlUlfF7LHxMmFeW2?=
 =?us-ascii?Q?uld7vuFMW4vFeZzVEfXCtsbsE4i2YizEcGqWMD5334gdSrErZx4Wlqu3WBVg?=
 =?us-ascii?Q?I5ywp3OGSKmsiQosMEYogBiLh3lV6OscAjssoH/4vlgqz1RjsFchAnqgz89N?=
 =?us-ascii?Q?0Viu1GWaRTXhjxRud/90ikLSFNgcYDAGvqcPjvZ8MDoR9+upygLQ9RIff0/A?=
 =?us-ascii?Q?Wre+KI8CRwJStqdJtzDt/wpyXdFWL1kn7Wq87h2g0zuUZyKABCbGqCy7ehsA?=
 =?us-ascii?Q?C5BI7gGrPYZ8DzEUJOMiDZ/4fWazdtvuQxNHOKlv5xo/FE1oCMqxBiKwOLkR?=
 =?us-ascii?Q?KkI7uQk4hey6OusyF/4eJK/nYYZwy9z9ZN8+RYCDQpdCyFhqWtqk1L1/mQFd?=
 =?us-ascii?Q?4pJ01ltgt32TZIuzUIpR86sT7KW/PwLmSJwwWB4UrWvvgj21p1A03xYrdxCG?=
 =?us-ascii?Q?dPWvgVa0XqR5s1xYsPvtJok+r1S4ADlFJdlZNN38X0HkbDCbvqXhrwHUJr/x?=
 =?us-ascii?Q?hYd/s9OaeNy4kr3nMMf4FmCj5ZMjyWU10KODmV0+fYsa3NNmzngUiKqnhX3f?=
 =?us-ascii?Q?RJnx1nAprwaB4mSIw5VSt/ckW8K0Au5QRNfZAEu4gGSo0qXylbH/WlQeJB5l?=
 =?us-ascii?Q?Tz2PPXbeCUMsKSTr+5sux3d55yfZnNTJuLfgMpyasvYoMOwZJ702aiIGeUDu?=
 =?us-ascii?Q?azZ4cQybxNo5P92OU01IDhtfoVkWjl+9+W55r8mBxZq7RQCyPiNlnxM4tDxo?=
 =?us-ascii?Q?BavZYsXkiLrttij/TtN3ekp3F0+Us5ryVpRSvsmQltrm1PbNW/ee/+4qcDA4?=
 =?us-ascii?Q?Cc1uYJEn1E40oR/+LQP1jfSBoNGoIr+7XQAAM33N2r2K4k8UDNlCgV2j5rTn?=
 =?us-ascii?Q?Iv2U+Zi/vrNSDHA7wmIHZZwsWnHxipSROTifjp8l8w9/dPCu90E6EufH7wFl?=
 =?us-ascii?Q?uQfutDNCEl6D1ZgHMcTwu66dygEGHUC/sgKUjKLyXQiJ51kvGs6AAzohdpNM?=
 =?us-ascii?Q?BCF9Qkp5uGeXcJh+CZ6RjCwX7+3Wb0Fp58rFLx5lNDmeKrtX3ycd71i4dGve?=
 =?us-ascii?Q?/pqXy84npoov/ZXrDSonJkambZZEH20LYwp8bWljyBjzs+R9/uDhBvBdwapl?=
 =?us-ascii?Q?e2MkB9R2RL+mJJB1NEDAPOzw1lg1D0Lhlrsz2U3Lt1BBy9q7R+hPW00lEbuB?=
 =?us-ascii?Q?nZDdJWPmKPV6L8X5leto+Amw7u0RLoaeWH14oz0AQpwk4ksXDbphXTNLSBGU?=
 =?us-ascii?Q?WKg21nN23J/JU0yWkwe3N+dDpjvIMjUE/p/MmXs1SxXXvewwET97AE2mPBIi?=
 =?us-ascii?Q?LPqIpCKNCgyv2BP77JEbVh5LNLXctYv6pFSEDiyHoiqS3BN4hmyKWTEbSgrx?=
 =?us-ascii?Q?qVFX5WaUm72yT8ZmWgtCsF1VKCFgObmEtKWr4PQl7hlC7SHRg/ZHRwKAWKfq?=
 =?us-ascii?Q?mfe+ymiL5Uwq+16PFzR+j0vTbRlptmYYp0PQPSToaJvLC7jQh+OQya2pEHFr?=
 =?us-ascii?Q?Oo06EaYgaCLSq8s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0SVg66IR+GKUdD6xhIrjOpptZVVR2EbAtGjn3nCPUEy5znU0SnI6I840vnUt?=
 =?us-ascii?Q?wrmZtpvVq+RuO0esLgCMsa10Q6xf5wUkTalPYdkoHKKAtPjZuDVC6daQLcBb?=
 =?us-ascii?Q?ls44YO8fAgdRThYzK0dGwFrT5c2tw/mHvtOp9GIBHSg/gYVDvfijzVNTqJok?=
 =?us-ascii?Q?YW+k/8087YZTAgWUEbFG7rh+E3rzIKv3WuX8/n+V1saJQbQEuBIpIZFwTbIR?=
 =?us-ascii?Q?/HUtvjx3uqWWg+chdDJGqtB+5zD1mSJy5ZL2OZlRasNd/PVN+lVmLHhUp//t?=
 =?us-ascii?Q?cymkT7uorEaEAGwSOb6gVwSDV+pKqDeFPHKyGVJ5rjjx1vEbynI/FULO6R4M?=
 =?us-ascii?Q?OUT4KRUIOpIq3+0aWWKM24nzgtkblYURkmFlWTK7/Qok/bcUBb2Ee/38Fa0Y?=
 =?us-ascii?Q?4ZHPKHvFiJhfgXTFAir6t+f7cZERNJC2WpEoEjC0NyBkWFXzoiF0oyAFMfa5?=
 =?us-ascii?Q?fIZXBkNp/lXE96wKAJScdYOo9Ud2YbSArsISjy75Oq75+EZyF3/07q1IgMhl?=
 =?us-ascii?Q?iWcKWv8O2qrwdQDxWTVRZxaPwtWYrJUO/YpI86LO5l10VPOPfDo9Gr0YCyVy?=
 =?us-ascii?Q?MQUu7hd/+uelMfS6zgEIWrWXij3XWaYfFC+wGqUkYZvOCDyzUI7Pc+eKHMaf?=
 =?us-ascii?Q?2ZmJVPn2Hw3hI/aEgzSLtHbFNT5SGRVcRCm/LKqVQjJ2xnadDmH8NwMgHbkB?=
 =?us-ascii?Q?i3foUKHWT6kOJY8r63HCUcfQRFFnow6N2xpmNAPNR+jOVqpPU6k8J5sAR9AI?=
 =?us-ascii?Q?xyWMsL/b0uJI+z2jMGgJrTIQWVDPSZdz7VvSIeYBw9yAAB/BoXcxUx5wAzl7?=
 =?us-ascii?Q?7kofR5Q9/tkvoqXdLV6Dyu3H6LIAT7cbGZ3kANVIJ2jRUpD8YD4ntrbkE+cH?=
 =?us-ascii?Q?31dkQL/4yMv7p8An4cyxyooG/RIVaNxksAihtXGGtZDR3qWIbB0q9oAFUnTH?=
 =?us-ascii?Q?U7JXzSMC4brqzdo9e2L+Bf9x8scDFj1xfFeG6naUxvdRoXkhf6UiG8h8lmTv?=
 =?us-ascii?Q?3QTR8RFfcz3jIeFm//5lHRgZ6msqoFYRcGUNoxxYk1tUdEySmiUOlY9g9OY0?=
 =?us-ascii?Q?Cgae34vhXE26mFBTP3S9pjZfOIEbAJW9GwJL/3bjaXAi541jfUco2zcemDb+?=
 =?us-ascii?Q?3+LmTXrZAxOQrhPghRA9a1vWJxPJtNury7XMOMVzJpBiUa4Qr+gPcH/PHG1Z?=
 =?us-ascii?Q?AboBTQJTWF9C2Z4b4pGoboY3Gk+4y+BhSkczpZj9I8ZcvenkvSJX7q2hKFkS?=
 =?us-ascii?Q?JSy9oG+GoBpjC+gZEYHTra1VOJyqCL/RIwFz2JeRYQB5s0ATj5rhX3Vvv6gk?=
 =?us-ascii?Q?XMOAoUtLedCNjRGdlgmwy5K5KsFjafISxjYYhkOygKQdk8o8V2UanLA43Pfx?=
 =?us-ascii?Q?/p9WpN8fzl+JTAIxCazmIxy9qJt8fk/Rv1e+jjTMJkR2IuJTKKnZh0DXTCq4?=
 =?us-ascii?Q?iOt/7KrSye60C8RCn+TCgiiI46rNlGlAZGPXMe2ubN+U6UDM4q4NS70UT3ks?=
 =?us-ascii?Q?vVIGutOjftsdXHXcuD08MuJkKPeeiDadrIZgfVvvTEk7axIy6BEeR4qPygaq?=
 =?us-ascii?Q?tUXv3MEOEd0oIdEAULg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1c67bf-2b9f-483b-fc0d-08dda70112ed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:21.4808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wCaLtTeIfIOJR15AQkGRnQ5lDhpk2yFVmrvWMXWsFNoxSjCrfSEkNInYP0LRJBi
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

Add support of dpmac counters in xstats.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c    | 118 ++++++++++++++++++++++++++--
 drivers/net/dpaa2/dpaa2_ethdev.h    |  12 +++
 drivers/net/dpaa2/mc/dpni.c         |  29 ++++++-
 drivers/net/dpaa2/mc/fsl_dpni.h     |   3 +
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  11 ++-
 5 files changed, 163 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index d17785a6ee..bbf4df69d4 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -106,6 +106,34 @@ static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
 	{"egress_confirmed_frames", 2, 4},
 	{"cgr_reject_frames", 4, 0},
 	{"cgr_reject_bytes", 4, 1},
+	{"mac_rx_64 bytes", 0, 0},
+	{"mac_rx_65-127 bytes", 0, 0},
+	{"mac_rx_128-255 bytes", 0, 0},
+	{"mac_rx_256-511 bytes", 0, 0},
+	{"mac_rx_512-1023 bytes", 0, 0},
+	{"mac_rx_1024-1518 bytes", 0, 0},
+	{"mac_rx_1519-max bytes", 0, 0},
+	{"mac_rx_frags", 0, 0},
+	{"mac_rx_jabber", 0, 0},
+	{"mac_rx_frame discards", 0, 0},
+	{"mac_rx_align errors", 0, 0},
+	{"mac_tx_undersized", 0, 0},
+	{"mac_rx_oversized", 0, 0},
+	{"mac_rx_pause", 0, 0},
+	{"mac_tx_b-pause", 0, 0},
+	{"mac_rx_bytes", 0, 0},
+	{"mac_rx_m-cast", 0, 0},
+	{"mac_rx_b-cast", 0, 0},
+	{"mac_rx_all frames", 0, 0},
+	{"mac_rx_u-cast", 0, 0},
+	{"mac_rx_frame errors", 0, 0},
+	{"mac_tx_bytes", 0, 0},
+	{"mac_tx_m-cast", 0, 0},
+	{"mac_tx_b-cast", 0, 0},
+	{"mac_tx_u-cast", 0, 0},
+	{"mac_tx_frame errors", 0, 0},
+	{"mac_rx_frames ok", 0, 0},
+	{"mac_tx_frames ok", 0, 0},
 };
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
@@ -1713,16 +1741,67 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	return retcode;
 };
 
+void
+dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint32_t *cnt_idx;
+	int i;
+
+	priv->cnt_idx_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_INDEX_DMA_SIZE,
+					   RTE_CACHE_LINE_SIZE);
+	if (!priv->cnt_idx_dma_mem) {
+		DPAA2_PMD_ERR("Failure to allocate memory for mac index");
+		goto out;
+	}
+
+	priv->cnt_values_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_VALUE_DMA_SIZE,
+					      RTE_CACHE_LINE_SIZE);
+	if (!priv->cnt_values_dma_mem) {
+		DPAA2_PMD_ERR("Failure to allocate memory for mac values");
+		goto err_alloc_values;
+	}
+
+	cnt_idx = priv->cnt_idx_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
+		*cnt_idx++ = rte_cpu_to_le_32((uint32_t)i);
+
+	priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
+	if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
+			__func__, priv->cnt_idx_dma_mem);
+		goto err_dma_map;
+	}
+
+	priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
+	if (priv->cnt_values_iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
+			__func__, priv->cnt_values_dma_mem);
+		goto err_dma_map;
+	}
+
+	return;
+
+err_dma_map:
+	rte_free(priv->cnt_values_dma_mem);
+err_alloc_values:
+	rte_free(priv->cnt_idx_dma_mem);
+out:
+	priv->cnt_idx_dma_mem = NULL;
+	priv->cnt_values_dma_mem = NULL;
+}
+
 static int
 dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	struct rte_eth_xstat *xstats, unsigned int n)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
-	int32_t retcode;
+	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	union dpni_statistics value[5] = {};
-	unsigned int i = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	uint8_t page_id, stats_id;
+	uint64_t *cnt_values;
+	int32_t retcode;
 
 	if (n < num)
 		return num;
@@ -1748,8 +1827,8 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	if (retcode)
 		goto err;
 
-	for (i = 0; i < priv->max_cgs; i++) {
-		if (!priv->cgid_in_use[i]) {
+	for (j = 0; j < priv->max_cgs; j++) {
+		if (!priv->cgid_in_use[j]) {
 			/* Get Counters from page_4*/
 			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
 						      priv->token,
@@ -1759,13 +1838,38 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 			break;
 		}
 	}
-
-	for (i = 0; i < num; i++) {
+	while (i < (num - DPAA2_MAC_NUM_STATS)) {
 		xstats[i].id = i;
 		page_id = dpaa2_xstats_strings[i].page_id;
 		stats_id = dpaa2_xstats_strings[i].stats_id;
 		xstats[i].value = value[page_id].raw.counter[stats_id];
+		i++;
+	}
+
+	dpaa2_dev_mac_setup_stats(dev);
+	retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
+					  priv->cnt_idx_iova, priv->cnt_values_iova,
+					  DPAA2_MAC_NUM_STATS);
+	if (retcode) {
+		DPAA2_PMD_WARN("MAC (mac_*) counters are not supported!!");
+		rte_free(priv->cnt_values_dma_mem);
+		rte_free(priv->cnt_idx_dma_mem);
+		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+			xstats[i].id = i;
+			xstats[i].value = 0;
+			i++;
+		}
 	}
+	if (!retcode) {
+		cnt_values = priv->cnt_values_dma_mem;
+		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+			/* mac counters value */
+			xstats[i].id = i;
+			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
+			i++;
+		}
+	}
+
 	return i;
 err:
 	DPAA2_PMD_ERR("Error in obtaining extended stats (%d)", retcode);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 103fa2ca67..532c257203 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -18,6 +18,7 @@
 
 #include <mc/fsl_dpni.h>
 #include <mc/fsl_mc_sys.h>
+#include <mc/fsl_dpmac.h>
 
 #include "base/dpaa2_hw_dpni_annot.h"
 
@@ -129,6 +130,11 @@
 #define DPAA2_PKT_TYPE_VLAN_1		0x0160
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
+/* mac counters */
+#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_GOOD_FRAME + 1)
+#define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
+#define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
+
 /* Global pool used by driver for SG list TX */
 extern struct rte_mempool *dpaa2_tx_sg_pool;
 /* Maximum SG segments */
@@ -413,6 +419,10 @@ struct dpaa2_dev_priv {
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
+	/* for mac counters */
+	uint32_t *cnt_idx_dma_mem;
+	uint64_t *cnt_values_dma_mem;
+	uint64_t cnt_idx_iova, cnt_values_iova;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
@@ -498,4 +508,6 @@ int dpaa2_dev_recycle_qp_setup(struct rte_dpaa2_device *dpaa2_dev,
 	struct dpaa2_queue **txq,
 	struct dpaa2_queue **rxq);
 
+void
+dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index 558f08dc69..f651f29b02 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -3493,3 +3493,30 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 	/* send command to MC */
 	return mc_send_command(mc_io, &cmd);
 }
+/**
+ * dpni_get_mac_statistics() - Get statistics on the connected DPMAC objects
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt)
+{
+	struct dpni_cmd_get_mac_statistics *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_MAC_STATISTICS, cmd_flags, token);
+	cmd_params = (struct dpni_cmd_get_mac_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 3a5fcfa8a5..2f8125314c 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -2014,4 +2014,7 @@ int dpni_set_sp_profile(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t to
 int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 		uint8_t type, uint8_t en);
 
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index 1152182e34..f653f2c0e4 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #ifndef _FSL_DPNI_CMD_H
@@ -9,7 +9,7 @@
 
 /* DPNI Version */
 #define DPNI_VER_MAJOR				8
-#define DPNI_VER_MINOR				4
+#define DPNI_VER_MINOR				6
 
 #define DPNI_CMD_BASE_VERSION			1
 #define DPNI_CMD_VERSION_2			2
@@ -131,6 +131,7 @@
 #define DPNI_CMDID_SP_ENABLE		    DPNI_CMD(0x280)
 #define DPNI_CMDID_SET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x281)
 #define DPNI_CMDID_GET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x282)
+#define DPNI_CMDID_GET_MAC_STATISTICS			DPNI_CMD(0x283)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPNI_MASK(field)	\
@@ -1024,5 +1025,11 @@ struct dpni_cmd_sp_enable {
 	uint8_t en;
 };
 
+struct dpni_cmd_get_mac_statistics {
+	uint64_t iova_cnt;
+	uint64_t iova_values;
+	uint32_t num_cnt;
+};
+
 #pragma pack(pop)
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.25.1

