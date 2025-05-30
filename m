Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C37C54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D334040648;
	Fri, 30 May 2025 09:14:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 51EC7402EA
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+48GhjLVvpnZ/vGd3rpu5UaH1av0phcSC5l0RBMwKJb5/735yTGgct7aW8cPlxkf596hgwanblwv/Z8iOdfrJg/zL70GnU8vgyfdoZL9RrYaG6HUvnMbGbv0ToaOzCyeqHJUU+Wm3xfXzD3IoG7K2HgTvGJ8wnUzbTzyGSYLhWL6ByseUefCh5WmWy8smVey7gNNR3/ovrf4PtQ/+G4epSwhSJPKjiz3rFPJXp6f27BhTPJY5BDfwjZ7TY8F0FTj8XFPC2krrPyouAAS05auB5fRXIT7C2I22UoQgUJHoR3jhgVUuAEUX3/QxYWfYBzJ+w8YsfKth3JuNa5plQr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXumNXMJCIn9NCXTm6/Sh3sO2xeLxR0+mc81dbMzC7w=;
 b=hOe81eGCwqa5+bsg6yPDTHUpM/inFEinLXtb7Jl1LnqtWidreeWecYNtK8bhWGVKgXmvYryYGAoN2SgOLe9BQ/Bc49yqQw/6Ga9DFxaQfP946kaDmJbPWlOs038WAfW/OAO+xwz3/oMLjndfT6e88iQplhsgD2HFOAZO9+bnH2OO3c3byweWObHQ59MDGtIfb5Zt66ffG4QoGjTiXSz2Tm6E4NbMAI/pgBSvJYdlyd8pkymWNnAB+rMRfsVwVCKMFavtEgt5U+LGP5mjnJBNXGUA3RqbLP7ry3TCszj/fiOOUtZqFB3lxwfrFG3pxEKyjKzbPvcxvEpEXOMl5jC0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXumNXMJCIn9NCXTm6/Sh3sO2xeLxR0+mc81dbMzC7w=;
 b=avK+lTDcRSSSjyEBOVSPberXs9W9sxSEE76HTcTKdQ5fuYuMo4sTfUs7b/WXF1Mq12642jRw5cnMY5JGB2agoBgDOOunTwHHGCNyaPsRsfkAvkr+VJVmBbW/3+j8DUvQ0gSodkwYzzR9VuHDKckIS8A3epjlKCDMTw+teEci04wOXn0ovqr6aYgWzXU+z6ghtncQ9yYu9r7GUsFd2XoIGexegcGHZDq5co517t4mh9Oe7x0fsJ43eI22H1VRqtAP5ZHuoph/kG76/Zj288fQ3EmwEgzE8qF/Rs5u5A/Hor0q/BZI4rqYHXNo61PDLI9MlcifY1GCuhL9dCMAurTXnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 07:14:19 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:18 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 06/11] net/dpaa2: support dpmac counters in stats
Date: Fri, 30 May 2025 12:43:39 +0530
Message-Id: <20250530071344.2939434-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2f04d1-2c58-4d46-b383-08dd9f49979d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dti3brUCiZg4vICysm0XOnl2TnNvO+6aj0kOMKaDEnchhKCdiTI0hLrLtgbW?=
 =?us-ascii?Q?IUsKOX+cNeahfGLD1Wmbj2S2jBVNTIXujk+viKSvyLox4co2yiuy4081TmI+?=
 =?us-ascii?Q?I6DyBfJw842aL+Z669JOPbyEPqdyKJGzMoHHShjgEv15ZnyPVDgDCiGIooTf?=
 =?us-ascii?Q?Pam1KrghTLakpy4Purz1bMZqx/zIZ6PUxIQOJRF78gguwIaUe6+roJ68VbHJ?=
 =?us-ascii?Q?aMSpHxaiLZ3dxiJT0aWA+KlMoC1HMZfSW3IhPFc3RHY49sEFDa0YFVq25jIM?=
 =?us-ascii?Q?yDUqaaLHvPCPI5zApOxBgIWZaOj7nyTQg5vYiChDmgvH93FYJv8FWrAYwwfW?=
 =?us-ascii?Q?+AnTE9YARUOMIqkI44b13bFf36nsvC+5EisD7zo21eo4S7NSVjzMbwNBBg3H?=
 =?us-ascii?Q?qzXR/80h6Qj0aQgMT6aKy9vzDbsPLce3Ucsujor7CdBiB6wcBDGRVBMQUKTi?=
 =?us-ascii?Q?SJCbTdilUox9yyngYPOzIXHblAxNjNgDUpZzWzzNymVxwRSOXmS5jWIp09LT?=
 =?us-ascii?Q?b2DNL9eTq5472bp27qGYXGEg0Wi4bRWAIr9MRo5iUFc9xoR40pfDbYBi3tPK?=
 =?us-ascii?Q?0zQaqvjjQVIxfqNy+5Xe2OtwBtqYUQBOihWNQGIL2KV2mlDzlUw9EBjHgybq?=
 =?us-ascii?Q?aGw513oY0renhhStgprDR+lW0LkQm4C6wf8fpY8fAhV5MSaLaselP/nYqL8I?=
 =?us-ascii?Q?m61+/z35dQzb+ckSiPXqGLQxkmg1beLgpR/y2zBlW0dm2NWHh57vbGjLBJN9?=
 =?us-ascii?Q?V3R9Ecl93pwY1LWRIhnmWzRNVp3weUX6zPcNqhpANpNI2bptchRHZkVihf38?=
 =?us-ascii?Q?FizVVR3SESLxfMSG5aT+dAqXkcf+Ij5uYM5fLwJ2y+/7yTVSASO3rRprLLwU?=
 =?us-ascii?Q?TMKEsyYxYN3NPg472mcNbjdWtkQx9EzI9sTuXBX+tfvgpu3A1X+0a5gZNN74?=
 =?us-ascii?Q?bVslm5gR8JBFqTSe56x3JN3TKJnkLAQNMfejUO0btMvaJgcVrex9vgHQLHhx?=
 =?us-ascii?Q?cfoiknZM07VHBFGS4Yxpqd7l5AoIUFWJCPo57DZdhktggxqPTAgMhMlS45J7?=
 =?us-ascii?Q?1z3vCQUHinQJE0fjr+Srif0fsDeZqfGLgCo7MvCt/5vQ9MGCu0GoWxhM5vl7?=
 =?us-ascii?Q?G6tTEgBfxvcvbyBkxpmQkDJWOTaQ69KTv9I0LG0KZ4dDstncCdGGyAk5zyUP?=
 =?us-ascii?Q?sYyVMluZunARF7z5jYm8cpWmrMP4LujltmE4G5pdHhDZGUZTjKla3448h4HD?=
 =?us-ascii?Q?X0HP5exdOuMybe7C5ETz7ZPqqIHGQ+yYSQIOsg9sDZf+u5QF1m0OkT6w6ZRn?=
 =?us-ascii?Q?BrlrEM9yIIP6PXiCIg1AtIWU+WYjtxOBz/TgSkECcQkdcZ9QlYw0x4eKBNC5?=
 =?us-ascii?Q?4R/kUKh09rPZFo0UstV3bo63DWYN2vQLYFff6yPyXkW7YkCjr6Iw//ZkiAvm?=
 =?us-ascii?Q?/bBaaCrSGnzC4LCexxDLxAwG1/z2B20CKfHJsO2joUsUa9DcFOoueMPgsgGI?=
 =?us-ascii?Q?tjG84HWn8NF2txM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kB23nSBMclUKoThU4tAbhmtrZ3TiK4Sf9979ZYQjTS4WlK1XAJbLQFkkxrCY?=
 =?us-ascii?Q?370h1CJjFyA6BeHick1mJ9yZqncxTM/E3ZG70It31aJYxbL/Y6pZS01ETlC4?=
 =?us-ascii?Q?WMHsgHUlkwaerWtrFOmQlzfDR+ITiIcHO8/Ki+sa49jHkpl/1hUyS2NxfSkN?=
 =?us-ascii?Q?OMWoPFaUyIpZ8aC2Kmp32CzaiX8GKU+3/nWdfl/r8fkh3Ka5F4+9bur+L9a7?=
 =?us-ascii?Q?9aLSn8kIQ9LG9c1rJjscl74DQVqGma3FkEekZ7XEQ8wBpu9Lw1lo3GJ1hCi+?=
 =?us-ascii?Q?+Wys5azTVu66lzmK7Jx9Mm4NCc4Rx+zQuji1TogCh8+zkOR706J44/SNZ5WC?=
 =?us-ascii?Q?ox1dyPeXZnH1OOXCQV2Q0uNZMpQYy1FzwXv1tArSDyD+ElSdXsIvMvSS/bXN?=
 =?us-ascii?Q?mU+mVRLTzrRfCYb0hP39xn4K7sAa/pNE89F2e75QSmBhtbDOjj/S/pJu2uR6?=
 =?us-ascii?Q?mcc14F5RKCYACo4aprkTASZjVjl92PUfKtOLM5oWaW1KrNwmMuuu3FY657JO?=
 =?us-ascii?Q?EgPZ3U7/3kagFNowsvZ0MuHLPHLBKD+XAIi8WU+kKoUJEdrcSKtIwk+8WXgK?=
 =?us-ascii?Q?8v7OQXRWeUt3KITE8T1wOn1hotzS1kQtHuUxb9dRFr/2eKBy06uudFmdAljR?=
 =?us-ascii?Q?6Ow1VMkMhwgNzfXw2j4O9mfJ9OlDzBhHbyniU+xvwNNNz3Xqjk4vIS+2Dd3a?=
 =?us-ascii?Q?/+6lJgZUn7I8BUY7Xe9uB+7s/+Ls/1tj/6XjtrcP7nTJlxBtNh4qinIHiJ/h?=
 =?us-ascii?Q?hIlGydsyxdKZpD58jzybmp8SoR70pEnkunB0L8AxBj231sNz73w2KTpfkUkq?=
 =?us-ascii?Q?Vy0e39O62kci6fV0mIhu4YgaMQN/Ri2j7KdECXzDkcAI6McfgL8XHflIZprv?=
 =?us-ascii?Q?qVaAoDZmQmLEx7S41iI9O2TVQTUgoNWHRROyV1Bplk97admMKhXJJzWv5AKZ?=
 =?us-ascii?Q?JmAOiU70xIach67f+S2RQltWIfuEhyRCZTCoJSoJm0kMv5i3goDMiaALzbQA?=
 =?us-ascii?Q?tOepZnBdjWOC4LeBxbaJ6M2h5yds4MdMDT+pQdnJvRHF7ws5eeoeTSZ78o75?=
 =?us-ascii?Q?dZxjhM4xDVSV4utkF96Re1NhcBjOM0GJSdDF9ioAeRLEaggnSCIctKvkeJnh?=
 =?us-ascii?Q?SmJYuBCjE97MWEbgie4OTZ1omx2TvUBDjabqa9pKSDMLnvlYKspyvR4bev/D?=
 =?us-ascii?Q?L5RWGPx/Q0coTF2Yrgggfvm7iOxvCLsyBl4GgDVuNv6Cm2iMTzyyxk5IZuyE?=
 =?us-ascii?Q?UEq3VlNLLN6xuDL9ZCcyBSJYn61iRqdFXlhLaVj/UOq4HSOn8LwJnPTL9FFx?=
 =?us-ascii?Q?gFD6NCUtBX911mEAa6vknI/ym9NxnS5QUMQCeTjrL2tAF3kaGWJrl+Hwbap3?=
 =?us-ascii?Q?Jk0k7yZXkCdSvrGKkjb7mD8jRbb/Iicp+zdLnT7reSxeL4+Nh58MJBpkoZbf?=
 =?us-ascii?Q?jrhVClULHbzUyM31B5torWICYwGFg8PBB38UIuQk0LvWCiT7vW8F+ytpC/IH?=
 =?us-ascii?Q?5SR53h8O3FQ6dAA21Z5bAkjaZqqlRNW20o9oRVdRaz7wtJfOsVw7cmYS8cFl?=
 =?us-ascii?Q?VdBhLBAydh7wG4++laA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2f04d1-2c58-4d46-b383-08dd9f49979d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:18.6969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA4hcSROJa6q9RLPQnMByRhkLBUKeP9JVVvf+GtFvngKohMBzs1DUIjz93imGfI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378
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

