Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF396C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D80040678;
	Mon,  2 Jun 2025 12:41:15 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
 by mails.dpdk.org (Postfix) with ESMTP id D9A3A40612
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE2MeMCZWBrh/0fcfmbPo2qxZamNcWrU6ygH69TatiILy9aGBZ0cfKk1APH4k3UB1kpZHQgewGnVBph8dstNkyFHuM70gkZGaRKPp6E0ZbvWmRTxLRgltJo1zzrckOqkwa6IRMTPJtBdkZ09tCYg2o+HJcSdOXTPd7OLfT+3Tn+8jFCDoIvWyz89UAQZFoioP1GbZEz9Omyq5aXQJBBVAVn6vIBwwI5qTGwMkOijUdfqacABUU1wuYzdhSf0Lp5wsoRsogeP6LEFtjRoRoYpMSBAdF6OIGATWXlwW2hG4TgGVC1pIi2Jmi6BFR7La7IfsnPtaLBYCmMbjXXgLTrnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXumNXMJCIn9NCXTm6/Sh3sO2xeLxR0+mc81dbMzC7w=;
 b=LT/lGPSqmUmFrcbJekvyOP9WUGe5hpgdf4CPLbUGDAiVwCEHGJjZQED2C4TQgn5fGnJNv75sw70OTf74p+DL6zz9MS1g2u3UNuzNKNUKJV0ADyeHI+mCVyE+PTk5oWWQ5/8ATn+YGT5CJC+yUDoRtX+xgIQ+yTuce2pGsroDyVB8lUtAC9uXU5BJumCLxIv2NrhF1GlFP1y3I30AByNayu+KOORAyrKqZW6Q+w4Hm6+TPu4X0ASrkXBBzeSXFEiSf4ZZ16GDAe98FSAYMHbi5E1Ei30jFZyscSviLJtIYeWOLx1RoDCp/FYAPR4muph4UIyVaXkej6Bv8Xu1t5JnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXumNXMJCIn9NCXTm6/Sh3sO2xeLxR0+mc81dbMzC7w=;
 b=UFxkCryL+HdT5XaQQOnOPEafxarimd1dDRe1E0r0+uAyLPdxgTujjSxzQc5ShN+LqnOtA4XOYwXaswc0e7b2t32En6GQYuAbWgqgFZntJvBX/JHwNSKSN809+p2HdNX9HDkE9sYEAVBZuqrsayg2vESlQoET07anBcsPnaeIbezRkbR6ZKGYGLk+XUvzaiO8iM8HybuulzOIIug8nrsCamt02fEF7k/mnNJbcSJKWPPe2DctzSOz2uYGswTeZwdi0KvR8qh7tuFvw1VuS1H59I21PkRlA2nNT+rMoziq0wfP+4VXjzMw8O/vBGpKQ6GKF0NHObLy+iEilnroIlfrBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:12 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:12 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 06/11] net/dpaa2: support dpmac counters in stats
Date: Mon,  2 Jun 2025 16:10:36 +0530
Message-Id: <20250602104041.3322164-7-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f5d8eb7-a189-477e-220f-08dda1c1fe46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cbsSrHibmCvSnPK2+HrUAJOWkxQIqftXZKryYL3GsLqh/DjA/EOze0bQDZOp?=
 =?us-ascii?Q?gMJBQp4bhM/Bpw0BXaJMLupjWMtOa88wwlJN89K9bXWGXUp+dnI2T9S6Vbzb?=
 =?us-ascii?Q?bN+PpuuBuoWyQ/p2ZP/hxbak5I+hflmfViZ7HD8qa/FkJ7CiPCA5shrRB4eZ?=
 =?us-ascii?Q?8bt9+FmfXymuj/JggQBav3i37aPqMnVLa51IIzB48Af2bYsalfsJN9nRmELF?=
 =?us-ascii?Q?d886tWAWmCEqQpcvURUh7cE7DOSargGTAoOEYVxs+VQ9q4ME/nv0T0m7WWbH?=
 =?us-ascii?Q?y1AmEa5k0EnbZfrmjapodemSOdUsb/SemchN6nAoKmqgPXlS4D8qP753Mwgd?=
 =?us-ascii?Q?YYudB8MLyDQUXVVA8EAVhxEmlVOvZZirOge/zVW6yUVW0Y3nSObTRyMrsoW6?=
 =?us-ascii?Q?jjb4vu+VBBq+e40oYAhAnPDKJG3EC6Zs/QHY4b8FjNqzfm9hnOfpSHKSLGVH?=
 =?us-ascii?Q?ekRcs/gxxfmCvj965VcVFWTnaxNP6Bs/R1kHlyQLi96SRAw6zy1UAK5efYZ7?=
 =?us-ascii?Q?09Q1CpPehWVUsOpqc1KlT058h2jtB4lsKQKXQN1HN973l/Yp34Av5lqghCrp?=
 =?us-ascii?Q?RhaKEHo/hH6rkczWI1CB3uyVkogqFq9vQ9u7k5ifZDkbcHmicx+waNIrJKza?=
 =?us-ascii?Q?K9n4Ug8lV/hLaHTlEHWUcAuUJunXKNyUBiRUVfiMUSRqx6pXPwK7tlzXFpna?=
 =?us-ascii?Q?/YqKXR6g0ibZd+6i++anrP0QuagPg6oNfiJVDfHRZac0VxoIacEH1S2f6FUO?=
 =?us-ascii?Q?8T5NiAr+3xxt8RHa0zu9y5YzHJ6I7B5aszw3hQjNb2gJYXiBXt9n+1KtpPgD?=
 =?us-ascii?Q?SNIr+a0btJ+aXnMazKnQkfCS4eo32PWDpEUbw1Xx2JSlnSpwHFKf7UDqqNS5?=
 =?us-ascii?Q?9MCU5kNDL1H+vQKHte2IyI8bH6Dkimtk/EjBXg7bis9FxhYxTC9IW91C8Bqe?=
 =?us-ascii?Q?77jVP2RJcNgpYyItk8IdhSfZ4+5bYg8O8/Zb8J2f4yy428CO5QzN2ljuWgOO?=
 =?us-ascii?Q?kie5OAHzfjwWLyJrmG3IQxI8FvtrFzsJwfsDgN7+i143RzTslIwDcDEAd9D+?=
 =?us-ascii?Q?Qlb1KmRlBKbBnERjElzJF2mgvVsvZ/H1ydgyY1qIJSHu/X2a3JGDIuL6idPM?=
 =?us-ascii?Q?tKMDd6cgqoG9h3TmuBy0wXZgXLQKNmGwpH4Ea9i8R8zq+J/PLnHXQL3qC2xi?=
 =?us-ascii?Q?jFVsjWB+clI1rBykHVj7TNddcccenSt/1Ww+a/RazJRHLLiGVFQs7+UPHRex?=
 =?us-ascii?Q?pzttBo1IBBB/uhOU96IWnnr5yYeqUm7+FaPuu7GxjUwC4ZgIpqeHypVXobBI?=
 =?us-ascii?Q?t9qsKwW9vyCXzeuKLZV5m7Y24H4aHZlyJqXZY3NkiZGpjILjJsqyaa6N6hjv?=
 =?us-ascii?Q?kIIZeCUUgInn16nYt5Iiel6uDnyW6gwjizy/tFwLqfSsF/gECPdTm/cfEdj0?=
 =?us-ascii?Q?qVAvxF4HKMsj8x1vr9dv8y1i8E7bio9eocP7XLxHoYkhLtS8E0Fv0g6KVZrz?=
 =?us-ascii?Q?U3qRuu7jX66ZQms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xm8QjY8IxZtE3sgPOwHLeB2N8T+0J0US4cqAHtrz9co2LKmSLWWz2K3Lk0Dl?=
 =?us-ascii?Q?5OJQoAD3+hgcGHXaKfbMu/9JG7dPXQ/rhwUe4XRSyZmXmBvW+dvCTIEi3WAD?=
 =?us-ascii?Q?cDF1ZNJtxv3U3o2a7zYRmwQ5AcDJcwJ38NUZt12XS42/l6EimuWeKD0tkl1j?=
 =?us-ascii?Q?dnJNSPJuJWypoIhJ3nNEIIzTsJvOTmd1OlotKBSKdGo1+YTriC3cUQaROrH3?=
 =?us-ascii?Q?VdklkqYVJLolVAQKQZGybxP1Ro6f6p0YjN7m3SKecLwqmC2eR+rROFmaIrXK?=
 =?us-ascii?Q?48z2MOulz71akTYkVh0Y8FjXIDGqsWSPHXJ238CQbFCol/qMB7B4qR9acFXp?=
 =?us-ascii?Q?0Hp6X90KgTPfXZ+8YkLyrFwuJi6XEeUevgzdCxrDJ6O0oCsGhwSO5JKwYtFZ?=
 =?us-ascii?Q?nTDOlE1UlD/tPgsvWQdeImn/GVjWe43zkMB/AUSdG1HZEiY9aqs71GBeo5IS?=
 =?us-ascii?Q?1p2DHC06sKrUDFuRC4adczQ/TS52olthmGJ3eD1+1zDBnqGwq9sPB3znsgVJ?=
 =?us-ascii?Q?pPUNdyEjcMHFzoO7iJBbv8UTozZEnWQD8Ufo5dyDyj5nU/WUMGtTf4dlRoAN?=
 =?us-ascii?Q?XhFDmbNbBEHiEdAyuaeGz/ZXkXGgSrWEdSey6zdid7DUEWkarvANZqweBkSJ?=
 =?us-ascii?Q?1J7eWldba9RKgxgnsLJR4WBKT43nLkC177CowiUGZqbIoLkiXLG1HHnw/W8X?=
 =?us-ascii?Q?6wJC8RIfAY9YHbD/nclsNDRgIdyUmNS+z9WBNr0h1bLJlpnPKW85/s2wGGGg?=
 =?us-ascii?Q?RdpGp3X7wNvyX2OtdHWFKaNM4N9+UiDvQeQL8kZCaLHTex51GDeFwy0UVdwZ?=
 =?us-ascii?Q?w5h++dYtQAicbuUkKcXiQ2Wk6TSx/aSQ8ilZiviuFGycgFY7QdRH3o4+ZM18?=
 =?us-ascii?Q?2F85ZxgkgAJR+sQ1f6464vSVAIqd3vAVc2P8hbAz3CVXuvrizqRej7chbY6k?=
 =?us-ascii?Q?TJcbJ/unJHwGaNNzOAnP5c7CnE1cPAibxAiAjo64XgHburN15mBUbOkzFiVc?=
 =?us-ascii?Q?XYL4tpe5RvMSmY+z/8Nqb/xbgDbcZZ19o76EB+fJzY/PSkEXU4ZxNhIdnhim?=
 =?us-ascii?Q?zCS3FILh/LWJsmlsCMBlBye1AQBH0vbsznBvBLK1cOKaBPFpxP+aCF4b/1h7?=
 =?us-ascii?Q?CZmcedIR4hoFpZ+NdQxOIm1TYELBPKmmpHomVlq82aHANEhdOuJzXJqchGLS?=
 =?us-ascii?Q?/hAqiJbS+yFwLton8rf4nqslsRZjzS3nB/rNO46Fm81CC7iNMVRp/4YYExL2?=
 =?us-ascii?Q?xtRQUL8n9l6xznynoAGoDnp0ybCj9UjRw8/Vb2hnsMupTMSZhVXlldw4XNHz?=
 =?us-ascii?Q?MqvuczTEQ7pSY0MVbWqKjh9HHHD02xBMmnFX6W34pKQEpgGVEDqGC1I8wcN1?=
 =?us-ascii?Q?7q3vNxbTEmcx1r+tfbb49RIC9JQhSi/TFv9wtxGP7yn44NC9f4kZ0Ysoh0jy?=
 =?us-ascii?Q?oMmy7Ak6LtkuN5gwatUyCsKMhy4PeDiGKGiOnTHmI/SiFv/20hA58SpZ3R40?=
 =?us-ascii?Q?40PQtewlz9ROkeL8rKcEQKtnprW/+TfqKKJb3O9MqbjlSyGHLQIa3ooeUZIX?=
 =?us-ascii?Q?akxFd+g1wl2vuACJBSs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5d8eb7-a189-477e-220f-08dda1c1fe46
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:12.6587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdI16L4KyIYPJTuEiHnUGyxPPaGqeNbo3erp8sAiyS+sP13Z/QUMvwBgxKdOjSM5
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

