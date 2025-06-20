Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E9C7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4779542ED4;
	Fri, 20 Jun 2025 12:42:48 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by mails.dpdk.org (Postfix) with ESMTP id 9796242EC6
 for <dev@dpdk.org>; Fri, 20 Jun 2025 12:42:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg0N8p9HZP2E9TFJ5tc+GRLZjiauyhrVNae1sDFFPl5xrDhRj49fPu7rg39BtAuhs7qu2hWEYYPkcQ8eWLyerrMM/RHtYtG/PSy56I71iNGpZl/NlRrijQbxecLI9njAcm5gTOxVijoB7tO/ecB7fPZUXa9N3C7y+ZqrQ1Nt0W1xqQ8XLEJQBemSS5It5uqLQV4F+rLCIZW3iOkgcx2lWBgu4UxWn51rxtZWqHtB5Z/C6MQB85yngVVb61JwLdE+GSAPtFOQzEmxQlsI06rnTpjNd1GRcLpFfbZPiat9oTadQFKBds+AzqqO8boHYIZ9Hnudw5q4k6tnEPaqVlgUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L66l3zVGIpSO/9oPpeAjX73s4rdOTA0/OVVwMESEoSw=;
 b=VzU7aqpTRpUEaP3QSye0cb0QbBGS5n8GsaaPc6sCvBWtRafO5U3cLhoGtBZm4jfVEkSPAqG3jcUCQsSTmQ3n/Sps7l4IqPPCELAaJny5ZXw8QXaD18QZqxvY3kQKHP1W3sIEZKqZYwqiqC3CM/LFCnXCVG7G5KHR+OUnwntNIYBsrCiKtteTpf+rFAf+adSpcysEtWX743XLYHYVLBu7Xg75FRy6r8pD/coJe3vh8iHUMpc98+9xjPvuLjOBIQEWcLIdt21Pt8jv4+Gns71Oclz+U7/fzPGAayJaKKPRS29t2pmXnzNsy6kt359Kdjgyqp/UJ2g3z2gWYMHgNf+XwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L66l3zVGIpSO/9oPpeAjX73s4rdOTA0/OVVwMESEoSw=;
 b=H06frghiNuydzQ38VvpE9ET433aWlMR/A6gMIHWO9tBIqy2TvtCX22qc/g4uFg2K12Vt3XcPI+KKDU/LGJwQeQiZNFNroLQz16WMuoP/kLlWO0MBW7qaHv5UJC95Dlnh9QwAt0mnWknT6TkZD3Y/TG4yc9iDhWVyM5eoIXT19O34EYwFZGyk5H/bA2VWb7dxyPFQkrFEdfojgeUHRbTCdjmEJH7rV/b+DCnXn/rmCTVRcFcJYHBpOphJRssndgSkNayyRMxJxDNBF6lDo5IAXrhw1xF00afHdyNF22n7NUxz613IFlIrtTtHz3eqnN1s0bam5CoXcSU3/PT+gZgDbg==
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 20 Jun
 2025 10:42:42 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::2c) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.26 via Frontend Transport; Fri,
 20 Jun 2025 10:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 10:42:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Jun
 2025 03:42:29 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 20 Jun
 2025 03:42:27 -0700
From: Junfeng Guo <junfengg@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: [PATCH 1/2] net/mlx5/hws: recognize IPIP in definer layer
Date: Fri, 20 Jun 2025 13:42:02 +0300
Message-ID: <20250620104203.261435-2-junfengg@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250620104203.261435-1-junfengg@nvidia.com>
References: <20250620104203.261435-1-junfengg@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e77215a-68f7-4a3b-3397-08ddafe72eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLDf49LUvNyv/28mVLPap1rTSQmavxPNRvnQ38b6iFIe6D1KKrDKWpQLor+I?=
 =?us-ascii?Q?dDC3X8/5qTYOHdEONC2ljj7bzWt0viP8q7SFCS5mouEDt8MMEwZbX3YBLVln?=
 =?us-ascii?Q?iQZhEV6SYkieSDtvrPcUE6+X/vKR4SY51O8Zq65mCTLWZuLm6BrcXhSZxOLK?=
 =?us-ascii?Q?EVMFAPEnrWhNOH4/eO6VS4uNkuLgRcgLWN/hCgJcDuUJ3OfcuK5V3WQ2jwGA?=
 =?us-ascii?Q?c77SUR6QBkbrjONoVjsHQAVVw6rETX4DaDkYdrdUg+xYHHfXCES06Cv5hae9?=
 =?us-ascii?Q?c+oZKiwdWNc9YxNgYG1OBuDal2ZO8jkkI/snrpJFBlXPEeV4b2VHwyhV3fbH?=
 =?us-ascii?Q?1ZdI9/a6/Zabsp12Q88N6pE9fmPmqWc05/0i6qXXFYtgorCcvRpgCabCLW1v?=
 =?us-ascii?Q?BU3bhvRAelo3YfnpHKtYhB59yQrfLK40TZMvf3C2XyIWOFkONruASQ+gA7cU?=
 =?us-ascii?Q?HxHVeLKBW2DnEPkyGQPvVpTRd1vgyUIVlt2FlBOV8/goVcAzgYQsF+sRScUp?=
 =?us-ascii?Q?6bZhHYnmKqLGwPoKxJfbvENa+0sMi6Pq+cp1bTxyouhtxa7rnX95hsPhhxpL?=
 =?us-ascii?Q?PtM8DTVk0PqGQChxeIOq+JuhuJnKM1ocNrn4+7o99X48XYCSYRtlfmicqejJ?=
 =?us-ascii?Q?qGkFfw6PpdTMqn6jlI0ioWuVwyfxvb9ym1XH1OmWpLdk3OwgOfQDW97VLLDI?=
 =?us-ascii?Q?AI0c6iy9JDKqa6GXVav9PJdSqdTBiiotBzWlSI31caBRfDo9ARArKrxJxf76?=
 =?us-ascii?Q?zvBSpcFCQyktg6mW6TqbhmuU8y6SpKs0Qy4dNLG16ex4q9N0A95wBzFj1dxA?=
 =?us-ascii?Q?aAiuyPxALg7VYj/A4Gbkf1cjegQ98xcMHnrARpHRqgLdQuPPPiDDt+AgjG/P?=
 =?us-ascii?Q?25KglPcHaRX5nXVLOz4DgZ64IrTckZXOVavHlq7iPDfVbl5op3oc55AyGCWG?=
 =?us-ascii?Q?X9lknr6pxtz5KF0beueewRFYOEeC5VSu7EGLAdUKhjmpt0fpSnIZy5lr4Ug1?=
 =?us-ascii?Q?i82pAmtonF5N9LglclcIGamthYtoCu/Qc8LlzjLI7BCm+/m79ota6/Z82BZQ?=
 =?us-ascii?Q?Z0srytDguNZavMpmbfn1zEtdv5Q3wSD6eBBjC5PssHsZJDB7IJC5bs0vNebu?=
 =?us-ascii?Q?1VCL7zAi7aELpYcvwDsgFwLcJfo5JeRpgoysqnukuHqQufxzf9kjBgpUowmR?=
 =?us-ascii?Q?H1iYdKPr8iowM0heoBPO0S+8NkmVbBEsUA6EO+f4MivHHUAuOVZndkNv8Wvy?=
 =?us-ascii?Q?B/kb6H6jaajZqOzY5lR85lTWpuk3FhbeChI1rYshLrwThC4DC967s1y6aXRk?=
 =?us-ascii?Q?2J6foc8TzTrO/9UwOLcFSFvaQ4B59gOcY9Zhawq+4mLXyRiuuMTHoKnpRyPV?=
 =?us-ascii?Q?/GLGDoVymUPlNJSFogdFTgIsjZ4ugtUz6jjGRBHeCc68ky0US04lJfZ3HC0+?=
 =?us-ascii?Q?t89FgWV5q1XNdsH6YJpipmoMFOgE0S555cNf4I8YwPidgD4FRs1MsFQlJb9g?=
 =?us-ascii?Q?cpNuQ6WDo+gUo7/e+rqVQACXkbxupk+nKZQI?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:42:41.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77215a-68f7-4a3b-3397-08ddafe72eff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
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

Definers are HW objects that are used for matching, rte items are
translated to definers, each definer holds the fields and bit-masks
used for HW flow matching.

This patch recognize IP-in-IP tunnel type in definer layer, including
the following combinations:
 - IPv4 over IPv4
 - IPv4 over IPv6
 - IPv6 over IPv4
 - IPv6 over IPv6

Signed-off-by: Junfeng Guo <junfengg@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 9c11d6c2cb..7464d95373 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -3322,11 +3322,21 @@ mlx5dr_definer_conv_items_to_hl(struct mlx5dr_context *ctx,
 				(MLX5_FLOW_LAYER_OUTER_VLAN | MLX5_FLOW_LAYER_OUTER_L2);
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV4:
+			if (cd.last_item == RTE_FLOW_ITEM_TYPE_IPV4 ||
+			    cd.last_item == RTE_FLOW_ITEM_TYPE_IPV6) {
+				cd.tunnel = true;
+				item_flags |= MLX5_FLOW_LAYER_IPIP;
+			}
 			ret = mlx5dr_definer_conv_item_ipv4(&cd, items, i);
 			item_flags |= cd.tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV4 :
 						  MLX5_FLOW_LAYER_OUTER_L3_IPV4;
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
+			if (cd.last_item == RTE_FLOW_ITEM_TYPE_IPV4 ||
+			    cd.last_item == RTE_FLOW_ITEM_TYPE_IPV6) {
+				cd.tunnel = true;
+				item_flags |= MLX5_FLOW_LAYER_IPIP;
+			}
 			ret = mlx5dr_definer_conv_item_ipv6(&cd, items, i);
 			item_flags |= cd.tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV6 :
 						  MLX5_FLOW_LAYER_OUTER_L3_IPV6;
-- 
2.45.0

