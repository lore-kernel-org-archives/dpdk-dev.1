Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCEDC61CE8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8371C42E7E;
	Fri, 13 Jun 2025 04:12:00 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
 by mails.dpdk.org (Postfix) with ESMTP id EE05942E50
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:11:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9XO2cy3EHfs6sanACOVoAZ6WafgyUwIf7M7WcumUtCdhmW1mG4CLPEH20g8KJDUcRjjCr6Z62X41XE7PSpqPr4QNzKM9VofQRQkPO7HnHIoagLpQgtq8vZKDOm1Pqn/wcTrZ8DxfNsRFMB18e8hcLhBvwKN/QGPdBpU4RTCNxxiZp6bYXpV3lxgLPUuVn6Bi0hV4lET+s7CUsfK/2WMdBYZq9iKtoa97qoVYpxe1hjhb6KjHZzOC99kQlJL7U3J+lHY5UcFFIzEyAQySTa1gXd5r2inmMzS37p305HNJcWS2guFDTpAjdcnZH9lFVgeQXGgvjEWr/RQkh8F8+ncNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOMbUqGrgsT3siBQthP6qCm5TmvxfSrr/+ddPsIZacE=;
 b=BieGLjlZEPlr9agppPgENixUBNhejPx70ts62x1WwWoObbDW60rbfRqzNx7uTR1tiwGElNC4Gy8P2Z/T4oiBJY7LBTKllYKpVhyx1OKbG5hx4YIxwrO9oUqVEfxTFbVSZkopQ9uGfItits4KlzI5ZxmI4H8/quAdlnbHklT2q2FJyL2w6YzjDWSQMwxOdREI10CObTRzDYVY6m6BpPrSu5YM4z1WQCklixFl4fderKxnVgHXHiUK0kVmfEhjQGigqSCcgtqyE7mJ6Z0Dn8dEwAguyEQCFsNTLNDG44MzUdOgWBAdLpJ8ig4wvnbOAC6S5BWYR4h5mmaVCp3rkrmyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOMbUqGrgsT3siBQthP6qCm5TmvxfSrr/+ddPsIZacE=;
 b=LvNmrlbC+y8VVA41TodKfb86jeDSVW56oNfAw4CrcMFWQZTZyiYUe8/0XMXX3azDpFzT65ZjPChC1BZ9h9g3gfEAu14DPO9QcAUGa60E3Ze30ON6xvga/g1OEcqDLfprKHoV3nT/1d6K15SG2YqMVE2FkAZGki0b9GxlWOdsBiVp/V1lDugZKB8VbMsEOsO+mJxMS17M3Qi97yLyj9vVT6Oj7TbLcXDgeXBs25l6arHyVfPyDxliMCCHpDPHwzsTb7SjB/J1eWgdSRnH83nQISq2J3a+ENJ70NsSi2u5gG4RwTB9mVWZcGUyZWYNHT27hXFfoA5OXN359lb4QDYHRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:55 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:55 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v5 06/11] net/dpaa2: support dpmac counters in stats
Date: Fri, 13 Jun 2025 07:41:20 +0530
Message-Id: <20250613021125.790614-7-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9b1ee0d-c24d-48d1-2b3a-08ddaa1fab5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ZF61LhDm/C4HvnOWrfAhse3bUeSH/hvcOrzyjJWg3e0ToKJJh3xZvVcdf3g?=
 =?us-ascii?Q?Qmi07/q9P2kby1jF+FviGjTVj3/n1qVUMPlupXlPZWdfGykaZctMWm6KHRIj?=
 =?us-ascii?Q?TeMnzh47728xieQHG/kOVs4u52Dp7oRrtdFG3KmbVoZARqdnsjj241V8TbyH?=
 =?us-ascii?Q?vlXH/NQUHMFOGydKw50Rm30KlS5FcnBrx/LVgz2K77iChxySY8IQL7bmmtib?=
 =?us-ascii?Q?TB20NvtV1VfcJRXaedblT2wS7kWqOhw37tGhPh8PpygOcfWN6A+o1Pa1WaaY?=
 =?us-ascii?Q?8j2cxqJI0BVVbhVD7Ck2Jvy/UM5FLZw07hzk3kvi0JxoMNI+BMIDBP9QSoxe?=
 =?us-ascii?Q?l0gp/hhWQg5J5ATt+c3yrS2LhiVOfgFEkRHn0bM81QOpLgIFu92TrgISfdHs?=
 =?us-ascii?Q?4lOmwy/gSYjeTcx7vS90yh4eq2twf4ohjaCVdmVlpPk3q8D6/6N+2L8tISs9?=
 =?us-ascii?Q?03yA0Wj2jFP0xw8qgWpa9p++aGZS+pn3Cw1YG97+SBLOiQoYioyAVh2D89eC?=
 =?us-ascii?Q?iFUD/jNQi3hPhXSkbabV1eagkH7kwkqWL2UblCgKQESR3HDAij2JH1M4t8kZ?=
 =?us-ascii?Q?/OValbBx+uF1qKhYw07rgbWUSVb+WLgfsVsWWD6OYiJZXqoojeUL1cBz/OQB?=
 =?us-ascii?Q?geg1/kNMrx72Wr+GEfFTawkQF0PuIOy/AIC7+eKdHBPA7GVIemArqjQo6DPu?=
 =?us-ascii?Q?3SdETTbCT8JrTZgtpNxRbPYvgQDrQ5yL1Ic+zQnVBiNN6r6P/LR/u/gugPvr?=
 =?us-ascii?Q?mo70CFbmpfK6IlG88aXF1HemwhT2sZFzAhZAiG4lj8BGpyLlmgCmHo72dkoz?=
 =?us-ascii?Q?WZrsjfhfPSNRrI5JaRAUEmFU0fe+XGHm4D1fwQJlvhCK9UjBzLvX2xaHW8yC?=
 =?us-ascii?Q?sxiK1wbYJ9/r4xffFSTYrr+Sx6ZMaH+aW1SnTIWTv+/6HjAulGtTZ1utIJvn?=
 =?us-ascii?Q?9ghpG9+i81U0PWC+HhvtjhONp6Z4vB5savXl7ywBf8k0gCK3G0qu6L6JHUPO?=
 =?us-ascii?Q?pFFoBlpsY7ft+aOH/uo0+q9NibZkANv8LxkOq9zcJWUj2Y1EgtT1SpHypDEt?=
 =?us-ascii?Q?Jy43a+4EFhbpVh1r8R3OWyQ1iR8gAXrpHAeMHqPzXQuLHKWIzpTsi31U+OUI?=
 =?us-ascii?Q?btkYMfjq924XZ3CNeAon13iQmn5NeFybYcQlnvoPOlRQ4sn3v6d7lYX69/Hh?=
 =?us-ascii?Q?0XFwcX0nEyzjN0GJdD1220JwnJ71HHmm5r3bFZwGmKeFj9P6wp5NjUUb5uql?=
 =?us-ascii?Q?WbrueHOeaDU0RZsg7yXRNYw+iy5DWCKQuPqv5vjt2K+ueKu8ZfNzT3kIc5v+?=
 =?us-ascii?Q?+IAdJ4d/sPyF++VZTlN+TK12eKPTJfMH7cx01RYk0FhtNKxjqw2G/EWBdeR/?=
 =?us-ascii?Q?09AD0jWTVjfltRZitZgviAFWR+yC2ka9z+KxImaLz/fEXCFY8ZaxfQoq6yPb?=
 =?us-ascii?Q?iK3ODLK5Gvf0mEKX+tHahnVLgLU+YoRveHdTPfZI8zRTJ1NATESg6Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XI4hY34sIZRUXyHXtWA3qhuKSS3V3UUSQRTGOZ4rVwVwVtUWtBOqh6zq7jKY?=
 =?us-ascii?Q?uTeivTDl46dlIBMEOPbEZmGfwvrNXSq8qGlYPQfnb3eufnWCp4TezRw18lBP?=
 =?us-ascii?Q?yqFqPQLrB3U8MtOvDR6lVYcA3A4pK0zYJ97yri5/4obOZ8yUiFerOIFih6Ks?=
 =?us-ascii?Q?Q9AmTWb0gGU8WSOKfwprzIF4QF007vrbqN5+ymzWJKbq4sIoAv6en2SK9Hb2?=
 =?us-ascii?Q?YGn64w6VGLvA3qQOBaaQ3m7xvbmKZ5MLJQpG0XnCExGDp6iB40s8KPXW83qG?=
 =?us-ascii?Q?byB5L2aDZVKfJNqMu9GoceHLKqIg+CGFj0UVzH7bQQsHAjnxtrnl2DKeSqZ1?=
 =?us-ascii?Q?V/vNFcjpU/HDYp8VDgjam7hbgBchLAYP5lyEpLiMl0QT5+mJdnNYBTFb6N+V?=
 =?us-ascii?Q?JXSwXwQCr+Q8akK0zLcrlxCfeTTRcB/n/UefCf9xFXHouii2/iiourO4g4jq?=
 =?us-ascii?Q?sfV9cm1bselwuLLMHtZCTi+hS/0XEomS/9nidP7Bk4+hf17puulkETQmNaGJ?=
 =?us-ascii?Q?HoMEY5p+yQHgV5YhPE2XQsK9XYb2k2hKMowNnYArpfnqbEY8DEgxhdm5LSeJ?=
 =?us-ascii?Q?sNcIxSRPDNxLy4Yn03ka4pLZiozVbJB7lBo10qJIsvfrgAjPOd8EC8dY4ZV/?=
 =?us-ascii?Q?cliW0fW8nsIS03Tp+dRLz/cfou5cXqWCveprNeJMODMxTwGHxejz+UIGAm2P?=
 =?us-ascii?Q?PNQwAIGSh5lgYxvNtA9gz7CLhpDpcS3th8TibsYGYkxd2gO7AyYKp4ppIjtm?=
 =?us-ascii?Q?R6h+hzZGPMtI7NsHeAfrq8E2GschvsYI2D7LAUTNDLXQzHVsolFbhj3Vti7+?=
 =?us-ascii?Q?9c5E4nLqpJX+GnJKUm8QC0QRjxJfwx1pVf2vc/exGkBRrcJ5VXaCDbnP4wqN?=
 =?us-ascii?Q?u3X4hn1XUr8p8lGTOv5iYUsRolPUYUWULJ7Qzc3VTccCTll9VNyjvMmiAWhI?=
 =?us-ascii?Q?+n1Gub1nWU1O7TQUnOJSK2Xjr1diGNQxt73sRFXkKVs14RGWeU/ysAtGyxyG?=
 =?us-ascii?Q?n5Q+C6+KEXkYS1nyvM4dWqPO/arPYbgUocsGmzrYyOILce1211x23Yhx96bw?=
 =?us-ascii?Q?uOBlwdtbGSWiiRjPbiOTtLnpoA+tGeTQscWdmJTfVDpwcaqsVgYKl1HHw01m?=
 =?us-ascii?Q?D3KUG2BMBW2TPEXLsjUuBIRNEwv04CrLZeoEBkB7ybVTDPs5BTqAR5doOZO0?=
 =?us-ascii?Q?ZlpKOrVgRVsSPpC6GhULGMeaUTqjEnSj815wRylDcLQcGG8D0/P7GB6T/SVF?=
 =?us-ascii?Q?yrzYP5M+auWHmuFoufjpnw67ojP0FD8SSUgVKnM2+ApJTACiiHIi1Wa/YW/r?=
 =?us-ascii?Q?NAHr2/A+HhkOl+NqLo6LTyK04xIqONoKjvxVMd+6nVoFqFjjzEY+Ao7vFt0d?=
 =?us-ascii?Q?5rz1C5xN0rYH1lgC9MusQhpwIOvXtXz44CVe59V0AYhBbioHihYhKFeUYyEi?=
 =?us-ascii?Q?aPo39p9o3bjK2kntJV+wq5jkRa9QifBsbX9oSz0CaMZvTDthsjhN+lc+ohwP?=
 =?us-ascii?Q?pQ491Ch1QRUmaWyUCPnoSK6z0BPFjP3NZBVyxZNXvdsw7BdMdVerplH0h89z?=
 =?us-ascii?Q?mJdgMM+lKbv4avJQmJI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b1ee0d-c24d-48d1-2b3a-08ddaa1fab5e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:55.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q79X1puV+bIw/t5HtbGQ+QnP8cdZYqEO2RTr43MI3K5xoGd99VY84z70k9DzA0KE
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
index 4e3e0338aa..ba67fd8b0b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -18,6 +18,7 @@
 
 #include <mc/fsl_dpni.h>
 #include <mc/fsl_mc_sys.h>
+#include <mc/fsl_dpmac.h>
 
 #include "base/dpaa2_hw_dpni_annot.h"
 
@@ -133,6 +134,11 @@
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
@@ -417,6 +423,10 @@ struct dpaa2_dev_priv {
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
+	/* for mac counters */
+	uint32_t *cnt_idx_dma_mem;
+	uint64_t *cnt_values_dma_mem;
+	uint64_t cnt_idx_iova, cnt_values_iova;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
@@ -502,4 +512,6 @@ int dpaa2_dev_recycle_qp_setup(struct rte_dpaa2_device *dpaa2_dev,
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

