Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92259C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F188040666;
	Mon,  9 Jun 2025 04:55:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
 by mails.dpdk.org (Postfix) with ESMTP id A1324402BB;
 Mon,  9 Jun 2025 04:55:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNzI6i5QT7LWdo11n+DLBtFxg5mqSKaEiljymsdrLM2MIaahfxBnwEIX1bEHuQxGUVB78oI5hPaSnjG3brfKXaD+8HSlb4xp1DeTgLl+C0L6ESyHl3ZTGL7dUzCuqIKpskPkudzRk5H868D8g0HNx0Nlc4AewRV0tOfszuSn2fPg/yN3tMkqzu5O0HwmMc30Ityuqts1+L8kCmcbqzZAkEGyzeolL49ZgIXQ+FGbVsMFtKQwbP32YRkv24MvAkIKmO697Iyw8EYn68JD3pcxvQBfhkvDlIVs1KuQdyrhr4zNcNT/DX3Yz3Q+R4ismVB21Ju9pTtvRhmM1HIHrdzzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRJfhCnhPtAy/78KTQslBD/e+dE4if5EjNdc2JcvvMs=;
 b=eeiCnJ+PeyJeBFrSOEbL75XFCIS3bdeDtWHm5uHGi5S43ZctM2OKYGhUSyHLPSczGm8BPrxxoW/DfZ6dtTYrCWqSjoNNKniTRwNnjVh9+AwukqWztC6rOoZwuYD3xxPYzEndoilFrRfl1O2pqTR3W81lwRndqeGgo8I4GE80ALSaRFZ6EWXnXzTjaKoQeFZVoGluBuUmFj4b/Ds0+jobnhvLl5NCrRYJYIsgvrO6lJkl/tFwfsCDKSiC8+XYbRECW1IKUbIPqGWIqVcpEPaTe/4wTqsqCUrPjFq+S01iv92SQCjLI4pUE+6T+2lsNdGv8R2WQFMYsYIFb10HZZGCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRJfhCnhPtAy/78KTQslBD/e+dE4if5EjNdc2JcvvMs=;
 b=KVhQgaR+i8SiDb3KeRzauvnkC6hagkPnnyH6VPh4l8HDOqr7hB9+g8X4m61O4UGQMLd2SdMZPU19Su+lDTeNhOPQfdfPI0tXKm3VMb60wVtUbYn6fz8a+2i7zpc12z90vUXt2ArM7EKVXAY4NuRNJjXmfoTZZwHj/1d2Rvrix7C4Jln2OU3Vdvfy7jiY8BhwO05/pCXZAPI2ALIzsmVXcQc1sbDP5lv8ERXTKQrUN9d+hSL/p/iIZj5vF4sFqzhGfQeHGTSVnixPBbF5++6kdHsQSnx9BVif+2ijb6Y98Or2L6kErQzXfq1A/RCYcouTrAiRJs6KN/D2L4FxlgFJ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:09 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:09 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v3 01/11] net/dpaa2: fix issue of extract buffer preparation
Date: Mon,  9 Jun 2025 08:24:40 +0530
Message-Id: <20250609025450.3997062-2-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1dd2563b-0633-419a-8861-08dda7010c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G4CaFbeAcyWv1WI5jTU2L61W6c5KnQeq5YrmGu4BQPkZKULXpz1isPoIAVlR?=
 =?us-ascii?Q?b5HYM7xgi+yZtBuscDwICC7L5eMwvMB3aNo4XsDFA5TzWQsunNT8eTUUZQzK?=
 =?us-ascii?Q?gtMfGMpu9AgLzq/23i+XlK2FobDyqBietPbT8fwv0HegldGfYE1FU35cp0/W?=
 =?us-ascii?Q?GM70vLWWai+VU0ZUcw0aQtw10bsbr6Mb6triUIqOc8lQkIayUkdfAq6EmBSy?=
 =?us-ascii?Q?TshvA8N2U4YesIrphhH6mtjYSo53/rrDcZXFSTxf8cUfb7YdZqq7CSnytJSN?=
 =?us-ascii?Q?bnu2WnqLiDvbkiqIB64zCIH3PrmHyBWAYcBnymM7hVKCFmqMeISJq/wOp2sK?=
 =?us-ascii?Q?2ALbtim7Y7YMafLvFaCDrEhC0DLwuJwy5sy7o6W7uO1IO/CrJ8RPLXGsX7vr?=
 =?us-ascii?Q?+TphcQ1kp5CwgLxlgNwhkJadLgtPbwM6sZUOchVoHDczD0lrLSEt/8eovmYa?=
 =?us-ascii?Q?eOmTUPLol5AQRBpqPBrKJimI+3n/FAZN61w+mgBwFWg2XjLMw7qpBxXW2Lu7?=
 =?us-ascii?Q?4TzQwn9EgTavCnQb3zw95uKpfC2z+6SxC86/D5b4OMtyJUgk6F5o/RgK8rT3?=
 =?us-ascii?Q?RqJY5IwMyvPruTe+HatZEWs5W7F5dK5kI5Gml4+2f8bl92ypNZLX5dfLWgpg?=
 =?us-ascii?Q?wS8kjHupjx3O7Y/opqLFqfWl1+QpMyyAEsOP0180kNPo5IiTkDqE8wo3zlZ2?=
 =?us-ascii?Q?LwEX4FnM46tIlviqgKmfbi0Qhz7cb4llwGLHZuKTvA9kIEXFzSc0fPecoS5N?=
 =?us-ascii?Q?0iHEULDNm068ZrVhWqXSNjJuRrW3D+ii39FwhYwkVZeO0nqGL21SLd0kqpic?=
 =?us-ascii?Q?8XryhEuPtwgwC4bzM49YtQMT9mILpEIWEx7LCyrugjuOZFyqkQXY37RjV1Bk?=
 =?us-ascii?Q?mTUPnpKK5yOxCVfp368/QOB2/G/UyKNGfVnlZFZUIGQVr3TfFRWICdblEomH?=
 =?us-ascii?Q?7gi1+Bz/Y5balwp138bIi1FnXVfTATV23bkZ1Y4WmejVujGyXsrGDyaDs7yO?=
 =?us-ascii?Q?4xoB0DotKouf5+xuHM+w1mSpKaofp+fR9dAwnFVoc928QpNBASt1XvoDy3QG?=
 =?us-ascii?Q?1Nj70mL+ok9ugJCbe0U6qXcvStWt5KyyI4vLNEu6xCpugUUWB8r0b3NeIl3B?=
 =?us-ascii?Q?kq1YcLtRqMrXdVrRYFi+7jiGIB+w13WW1CTEFxNzvEwsjAQLUmW3rLc9HieY?=
 =?us-ascii?Q?u8ns7L4/u/bT/ogPwJB4S29u6UqsENIxL9WTP0mh8BkW9d24HBxfXJdjay/O?=
 =?us-ascii?Q?e0L1wBw3gg6+pX4OZXva2YuXq1rlIKlt0lLl7GSP9MwTsaZW7W2Z6DCkZGTO?=
 =?us-ascii?Q?CYHgjXeG9XiVrZndGj4lkfs2QY+PZ4+4Cea399IFICW4NLk/TQ1j4iSY7tu2?=
 =?us-ascii?Q?WAY1884qWiCSLwV/tbtZZ0vv2ITP+oEW8Zxu/b1GtaCq/CDINBggLJebC/MF?=
 =?us-ascii?Q?fGRgkwA6K4gipBicXKmAJXtSjVtf/vcg14ghi3WUOynbtN/wW4+WyLfAFERR?=
 =?us-ascii?Q?I0McQwa7Wm90bNE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvr2PtCvPg3rjoJUmso4p0TU7dOtfBX3k017iyToLEIyTEC42iMw+8E2Nqde?=
 =?us-ascii?Q?XXTSpm0F3SdsBUvisB2//qvkifw7mTiwsalPArNAxYQqpkKvUyuFnMx3mMD+?=
 =?us-ascii?Q?pf6W8m0wKs+WGgpa0GQFZ1HgIAyMIlH9y3h/7H3Yms+iPlGch3QSylP+MIRu?=
 =?us-ascii?Q?gMRWVvMPvKa+4bGttNTHst9/Ila2mvBamCESxMapCZAsiZo+BkqvgnCsnGd8?=
 =?us-ascii?Q?re720jFAPVtWhflfs2n6T5wVcrLk54aInHvYwv/5uWEeyXVhOuubqTrQBavX?=
 =?us-ascii?Q?8IAoW/9GIvJVG0jZBl3G8s+8QW3lLRrhPzUn0V8VxquIDfOkyKJqhrZXUQm+?=
 =?us-ascii?Q?fLaawA7tnRvyw3Fml29AS60Hbv7/2cfNghR2txgiAAWvA+BinrZ1sb3PNh/X?=
 =?us-ascii?Q?jFxRL5BAYgJpCys0mYJOhjEn8Yb4syKjRrfUFmFrXWo1KjFAjPQ1ZCEikqe+?=
 =?us-ascii?Q?/M36rT+MfVpGuDQ7wHhfNSFZ1NwhVmuMdfsZiMWZWzZxfcdhmZBgiPDUn4Ot?=
 =?us-ascii?Q?SmZN5/9dhS1QyffHRy6exckoy0/f3P3vc5XCrbIR/bH+4JznE/R3GmWr74p5?=
 =?us-ascii?Q?bX9Npfv86tmk3EZrvWq/e8TOd3yxtQEBwPjEFvWAL86RjR4Sera0RKgAOc+f?=
 =?us-ascii?Q?gvoMkBoY7I4Co/GgnzEBtEzd8mUV35oFnfrJd55+gXO2ayrPyjGuWTimaUaW?=
 =?us-ascii?Q?lboMTjU0mRaO26JUFbUylfA14GKok/rdU/LPeX7lj8Mg07jvXiTD83Y0uP8L?=
 =?us-ascii?Q?NlouyCd5kXR0LaXstD551mCi+soiCnDz1bHznOK/yRpA+AahXcGxWHQsvnkW?=
 =?us-ascii?Q?n4370roNxFvmhgMqOI8ZjikSHOzwv4150C1+lAW+98aMTfoHc2FdzJkYV97L?=
 =?us-ascii?Q?JT4tUDjwYZkA751WoiJq81h8bBTJG29pzEAJedT7fwcTfPnQQnLSjjq8JJSX?=
 =?us-ascii?Q?D8LKxrkHCesAuYI47+yQlqeS28vgrSb4aWwO81+5ZpuWBLJv0IHLpSPWVIWw?=
 =?us-ascii?Q?J9UfWQ+oFa49F46Qp2uP+X+6VkCrz4Vav8eR6QyMqGH1SW01GaLpsToCYHLM?=
 =?us-ascii?Q?dEnhnQt+NRwBu+NLFEg1zQ82uJ3DtQW4ilyRgeY1qsNJk9WNQ+VDMSEROSp/?=
 =?us-ascii?Q?vYNL1Ge925kumH4BinEIOcT4ZfKPCjjx3LRbPZFQPALUt3quobiUV9KzZ03f?=
 =?us-ascii?Q?T58mzBPqcDTvvmDA7VVMX3KMS5tBtnK6D1KxNgStsgRoVq1ujyulDeL3zFyR?=
 =?us-ascii?Q?faGo4+5KAQbfzRPJ6iQnStU1cztonuzu3PWipP7m2RrXZ3Gs93E+T5RFYhA9?=
 =?us-ascii?Q?ruxFeyBcggXKwz/BIxyCNsehy9yyhWHGzwk63ZEd/o5JYdZmjjLu+NlyGzJx?=
 =?us-ascii?Q?PnTWBKj58dIVxT7XqoIgKjh3HfXsqdU0qm5aTidAimkuS2po9jHdXgJmI+i/?=
 =?us-ascii?Q?rud9Z+jGPEIyhEkmAWvSHXqdZXzPgHTBC1totiqmh5eAtGDzcy4k1ViI/3lH?=
 =?us-ascii?Q?ZNiU6N/6NrwHkWT3KvAL1HU/QPg4HIg+JT+pkGj2us4WcG+aKAw/g5TOa9o3?=
 =?us-ascii?Q?2dEe+mo55RUrkXBu0ig=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd2563b-0633-419a-8861-08dda7010c10
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:09.7622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WHopiRCp9UxU56BQsBFIwHsqAYcOdhfDyLvbR1JH7XDCKFrBcnGI1CL5blKZgVN
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

From: Jun Yang <jun.yang@nxp.com>

1) The max size of extract buffer should be size of
   "struct dpni_ext_set_rx_tc_dist"(488), which is greater than 256.
2) dpkg_prepare_key_cfg is responsible to clear
   extract buffer before preparing.

Fixes: 25d0ae624245 ("net/dpaa2: check IOVA before sending MC command")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 drivers/net/dpaa2/dpaa2_ethdev.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c53c2d0549..c154a574ce 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2788,7 +2788,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	/* Init fields w.r.t. classification */
 	memset(&priv->extract.qos_key_extract, 0,
 		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_malloc(NULL,
+	priv->extract.qos_extract_param = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_PARAM_MAX_SIZE,
 		RTE_CACHE_LINE_SIZE);
 	if (!priv->extract.qos_extract_param) {
@@ -2799,7 +2799,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < MAX_TCS; i++) {
 		memset(&priv->extract.tc_key_extract[i], 0,
 			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_malloc(NULL,
+		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
 		if (!priv->extract.tc_extract_param[i]) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index fd3119247a..f32c31c763 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -31,7 +31,9 @@
 #define MAX_DPNI		8
 #define DPAA2_MAX_CHANNELS	16
 
-#define DPAA2_EXTRACT_PARAM_MAX_SIZE 256
+#define DPAA2_EXTRACT_PARAM_MAX_SIZE \
+	RTE_ALIGN(sizeof(struct dpni_ext_set_rx_tc_dist), 256)
+
 #define DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE 256
 
 #define DPAA2_RX_DEFAULT_NBDESC 512
@@ -60,7 +62,7 @@
 #define CONG_RX_OAL	128
 
 /* Size of the input SMMU mapped memory required by MC */
-#define DIST_PARAM_IOVA_SIZE 256
+#define DIST_PARAM_IOVA_SIZE DPAA2_EXTRACT_PARAM_MAX_SIZE
 
 /* Enable TX Congestion control support
  * default is disable
-- 
2.25.1

