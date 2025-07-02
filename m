Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB759C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:52:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E1540B9D;
	Wed,  2 Jul 2025 11:52:04 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
 by mails.dpdk.org (Postfix) with ESMTP id A546E40B8C;
 Wed,  2 Jul 2025 11:52:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYK3Et33Gp0VJpBWrVcgJ5kkdK/k5rcMmCTfbceyMQfnyndnJTwS1iGZyJjT5YuxLCBPDXsSE7kSEZ/dpyi2uyhnotrg869lFcwJiR5Na9GXTEv6dc8vNVQiVc1FbWqpgP0Uk6HLiZktJMcpiogzQz3g2lQWHBMW9kz1SXq64TTws0aBDJ9/+IXmmCY+08TVWqzoQlLsm7YruQERx7OIStjcm4c7kHn84nqL1Ur2hMkkF/Fh1zDiwsHMrS5LPQxLl06J+/4M/Yup2YisW8ma2yt99SH5gTTn2RzRl2YB4BMPtxoeeAMklxUUdtd6zrOzUAoI/C0XWYyM9KKGC7uUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtQUNJ8PfhYMvOCwDdPT3bDS0CU1K8XnCL1rRAk01QU=;
 b=rLNQkKugVnnXJjZmttoFUti86LaGSDv2gVB0fqX7layH9eojUQ6OCRcoc5e2aHb61c7ldt58s0R75St8Sr5aVIgvj/TvfrBk1DbGQedBlHQ93C1/8XEP2nZVy9ttgrhHsJnOfRhgzJuJNFQWtqFxXR4Ie5oZ6xlWN59CGF2hvB7MKlIIK51xVxEwIgkSXKDYX5yMirykmqT3G3IsWjwzbKIq+7VrITbM2isAQZFiuTy+bQTJz3UqpUvg0iJuegSGtNxiAfzBAV2piZk+529B2qRiIL0prAdfwTJW6xkRWxtJQUnB+E3nZdLlsO9gtr/iso/Rv4QmfYbE0AIhziWRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtQUNJ8PfhYMvOCwDdPT3bDS0CU1K8XnCL1rRAk01QU=;
 b=kHOibnFZfxrsUoNqXH777p4m1FIj+sstcphjNZ9zK6PW4AZjXS34APtaUTOorNGxUaybca2d6gjszccRO5BQ+6mv5JvuCavAodkmqKX1gB0MMdnyUo3ZHPyqmWFG4fPwsAd+PUEO7mwuxmsXhW7aU5yuHNzur76x6hrhH+CZ94YD6ovOTDNe3MTCtZlgm/8WDibsteY4GsHd/4kENNvYrzxrykaNFnaqtcRY3TGLwTXqZ9SodKfM+UsiLh84PspKTxBIPYQa//3hlaqT8pjOJnHRxrYM4j3+24g0pIvANSzmNDBt1ldkIlDRWYk6mo5FTC7iDx2cZuKpytzBYK0u+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8473.eurprd04.prod.outlook.com (2603:10a6:102:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:52:00 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:52:00 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v8 1/5] net/dpaa2: fix issue of extract buffer preparation
Date: Wed,  2 Jul 2025 15:21:40 +0530
Message-Id: <20250702095144.3087250-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702095144.3087250-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
 <20250702095144.3087250-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b251ba3-c8a0-48e8-ecb2-08ddb94e1717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R4jIyu+nfpXC6gElohyJaxGxVgTTdN8354ZnyyeMprZDVzH5S2F71Rf/4mvp?=
 =?us-ascii?Q?k3wDIqBsm14LcEpsfM2YLLJeCZyijOEOs6FFHHjBQHvYNPA1jCIwfqS4hMZP?=
 =?us-ascii?Q?EKKDyq2u9YxLu9laKiXsqlH1ptCI9/eJt55dgwMWzuqcU8tlUfv4XJ8EiwC8?=
 =?us-ascii?Q?MYFStEnUY6g+K79k13skwroOXKLJcURsuuAf3nqRwaQQA4rh19V7I4+o5G8K?=
 =?us-ascii?Q?D7QJvZk3qTFP0GM/Vv4bNz89vp+RT8B8TqTi3v5Bi+9vsxkPhhmwPCpIwQ1r?=
 =?us-ascii?Q?FlyzdRYjEXsZyfLF74sXAQcw7o91S3H9uRW8c8IGSR+y+/4LEs5YQHJ68XO3?=
 =?us-ascii?Q?/yR9ISVxWXeoFgq2oCFrGEV+fg5ytsXaYPyxR5ZDVDmP6LMZQjO5AHqYJlF8?=
 =?us-ascii?Q?ZIOjz7OnGFJaEuo2qKXW8UOAi+FvjoI+biZrTlSzVNRcUwGu58jYLGiP8/xO?=
 =?us-ascii?Q?LJRUMRigGqm/KRfXc1HprQhWvZfbizcka2NIBdJhrP9GsUvNz03EP43ky7rC?=
 =?us-ascii?Q?mE3kBy3sGi2dGkUt5cd3dOjjskbhsTcqKX3Yw6GHlOIyg8Bg+pg5dJPiKaD1?=
 =?us-ascii?Q?aYfquQ3wxOmAkJ8KdMw8jg3BsPTqYjetz9alxqcu+A+9ipLik9gRQjFhe2g8?=
 =?us-ascii?Q?0DFLESsoKkvuK9JgXUwbQz4XfZB/LfLFcNtNX30ZnzG6ZqFobCPRpPiuh1o6?=
 =?us-ascii?Q?geS0DshtaTwotkP/3Sqal09Wi+tGsE544w0ydCU1/mj6Tvzrvw9aF9GvNcib?=
 =?us-ascii?Q?5cfmf36X0zBjmlMqSZjDwyMg1NsWzOSC6ro7/0MPkvC259jAWo6B5SdU+j+/?=
 =?us-ascii?Q?rMlnL1xRu0rpotKJ6My0pThQJN3YVKPEpU+nbz8Ck/KaYu2yM5qvib6BhCxn?=
 =?us-ascii?Q?q/vmQMz06/xMCMnp11YR8gu2esYNx8XA+2zJC3zfEFzA6LhAWi5kNCYQ6O4c?=
 =?us-ascii?Q?7aLnLdA0+O/b3CuUHXothWXteTnnIILdqN5Crh+d5S3kf+nuyfQrgTSUS+ss?=
 =?us-ascii?Q?veuGXZokMfnUujXiyy+XNHHaNTaviYmwnfep/JnWWoZd+1fEZFnJnjY7pxWE?=
 =?us-ascii?Q?AxIqxRNTCdOEd4NCVDAWrkFwFjasUioP3WBKL17p6GGpSA2RzFkG8xrYgXKm?=
 =?us-ascii?Q?rlyNfVzlvb3g2AIZcWINmpT0I9ygFINogPNRd6zyzEK/lq4lw4OTHMWlL/Ri?=
 =?us-ascii?Q?pqg5oqGc5g0MYANSiu1W+qHCqt+8MtTLqPCmXTsh2JnKi1Nt/Kuu9z1Z7OmR?=
 =?us-ascii?Q?0Bxj1d5e3p74bjLC/+iS7fVwUhw1PqSAvKzhOkf4p8H2BCiCnE4B4X0czPAI?=
 =?us-ascii?Q?trn1kca6hVYpf0rzEj7FDgbXBTqSYl6OQQ8HaWKw+guu1m9bUGUnFdFFBn9m?=
 =?us-ascii?Q?osQP5cgWIliSCqmCwUdj0hmYVMVGrPuLcya3KcNACsdmXC1n2NA7PyZYe2Yc?=
 =?us-ascii?Q?ZbVQn4hW4cafcZaljlu4l1Bisb3ptG2J8zsU+6ZTDhoEgJSQUuXIlBdRooLQ?=
 =?us-ascii?Q?ax3Sq1D6jQBEars=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6wY6kE13wb/d9bj7pIqMuU2t0tHsvWaXg7NlqipGTh1TJktEf6qwWy9DFVm?=
 =?us-ascii?Q?UWMyN1sjMqMpiSGCCMLkpg/LeclynteLq+7ZYRAkBW9sOn9pszAxmNbdSp6X?=
 =?us-ascii?Q?CmbVF1KTR32pam6AKJdd8O8Ciny9yshHhAy0Q7zdS4KPLFoZhiRCHAUXu/LA?=
 =?us-ascii?Q?5yNB8yTGDd11cfJHqW5r9m7s4KjjNvyJ43rC+RRmlzOfebUlH05LXgGM7sK/?=
 =?us-ascii?Q?UT/c1Ij/Cv10rP3eihIbwJV+DKR4cZDaq2ZaFm8MhlKGb9X2OVBMOGjZKt7N?=
 =?us-ascii?Q?jht3YsrCcJ8UH+jRIqxh0UqmLm2FOeaqGAjt/QX+KlrJWuxv0y+rI9NsdCbQ?=
 =?us-ascii?Q?82h8n7Mpv481T0++9VvD5E5+PJehSNR/lOX0l/czZ3OZlDB/Wc8GGqfv/4p/?=
 =?us-ascii?Q?rwvF+kLg5H8GVSRBWyWlRMR4oGGVwMiT1IseyPO3GgqXdO9+lua9/54d44Xi?=
 =?us-ascii?Q?zoi4Op41fe3b/QLqtcIoiny3ANPVsFMjKMQqD8Aa8kWXMk0Ttee/xEU00IHh?=
 =?us-ascii?Q?bHtVEDhhBcF9fnDrRo8AiV9KbBv4ymoYfLxGpuk7S2onghoI897cL78PpHOA?=
 =?us-ascii?Q?UgTsLbkXeHD+auZahmfkJhQTqWLfYKhoiEYqjJvG+VP7Ov6OX2KFBC3GtCL8?=
 =?us-ascii?Q?ZshpW2sn/uFNSRYDWn7sARuwdCgxvTR5JHdOLfCaAsGePp7TC76lkzcmpUyw?=
 =?us-ascii?Q?KCMgFbdLy2Jk2T+yTbH0UIpV0e7xVzquQhpNfdMwukUTFDs2SXoknTowdjHt?=
 =?us-ascii?Q?8GKjX7TGXYyk7v1zmRYdBmIIFdp6o5NYwwYAfKBoCH+vHjQSCAkQ0pRmI+kW?=
 =?us-ascii?Q?Ei87LI+CKRnUSLvllmVEF02Y2sII0xaklAC2PCbV4v3FMy3xN+fnvIAJT7n5?=
 =?us-ascii?Q?KkZ+NcUNPgm55pbNVTB4lEgl4V1VbOAkGufH8Fxt/A4OONNx59k7+9+qE43o?=
 =?us-ascii?Q?Bg2PAcIhNPoppslpM97GzopL9pkmHH3H8w/md3OzJNXcdFTt4Pcp3b0M/0FG?=
 =?us-ascii?Q?QTsFSleVMYxOmqAuksimSGFtXBISbhNaTOx2VeANf7jaE+zYo+3jInxHrzh7?=
 =?us-ascii?Q?Pj3+hAygzpw6N8qbISbXRS6FRQQTvihy78ycJebAwH+IBP/rqW0Tl7bIAUwV?=
 =?us-ascii?Q?DkIat5gr7ZtITsKd1FkvWNPboNwTYy6DXQRQj8lLDxmujORvHuyp4cnqx0hG?=
 =?us-ascii?Q?vxo5zmbj9wzbIsGSMhEVMmp+NK5SV2dquQFBWIoJE5wAigal5XRaCX69/QyM?=
 =?us-ascii?Q?/px7SICMJA3XDbzTQ7NdjBcsuQ9VfN8mfsayE/yQAmMX7VbuihIJpIt+Zz5r?=
 =?us-ascii?Q?LS0rruk1O6Ly9R+wwyVOxEkLIm+YCSIgVRA8DTPDGsi8hToYFgJ6KEXunD2N?=
 =?us-ascii?Q?ooM727Z9+TYsceaBnsytqCCe9Vr1sWWDfY/GpPU4+Z1YUdaN76YdE3ed/48I?=
 =?us-ascii?Q?KJ/bsgfrHqy/wRvvMPVlnyo49QoDcOhNqNeZM4vobhRsgrtj5w2lHEWYH1k8?=
 =?us-ascii?Q?bp51KKRhPjSH+BKLTbleAaShxmvXh9daisi01rAjgQhNUZk6Gh41qXcyYmte?=
 =?us-ascii?Q?W05l5SmhCAUNGUW4/lc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b251ba3-c8a0-48e8-ecb2-08ddb94e1717
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:52:00.4368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+Iqu7jtEI9lRJybimSSnRIr7SA3/kwQR9ErKHrpLwFq8iI44pl2OR1tGrAFq7Bh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8473
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
index 998d1e7c53..1d11847d76 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2787,7 +2787,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	/* Init fields w.r.t. classification */
 	memset(&priv->extract.qos_key_extract, 0,
 		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_malloc(NULL,
+	priv->extract.qos_extract_param = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_PARAM_MAX_SIZE,
 		RTE_CACHE_LINE_SIZE);
 	if (!priv->extract.qos_extract_param) {
@@ -2798,7 +2798,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < MAX_TCS; i++) {
 		memset(&priv->extract.tc_key_extract[i], 0,
 			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_malloc(NULL,
+		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
 		if (!priv->extract.tc_extract_param[i]) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b9dd9b22fd..b501fc091a 100644
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

