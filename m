Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1016C021A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 07:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCDD4400D5;
	Mon, 17 Feb 2025 08:13:53 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by mails.dpdk.org (Postfix) with ESMTP id E39EA40041
 for <dev@dpdk.org>; Mon, 17 Feb 2025 08:13:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcSiaV0YtqeMN2gYutSiacvPRKke2Uxo+sELCENua6PdJVEObfPbE/uP5VWjfX7+/2s2pwyeYe/jBhwqMLXBSbgF0N57lxA/Qlij1IIfT+J5LS7w3jqDccbZxN6UJV7Hu6aDMj3CnXUZyPCfdXkpT20Owlcq/3hggiaqsf9iuSPS+bYdOZKE71K0ssaWzXDxQPFISmV8nsewBnBrqHbtCzJADFU6u98I8E28ZCv5sfD4gKuLGPrIagFrvOEekMJOjkQEv0LNdRb0i75y/eEul8s4swprZ2Nix6hEMiMTGSRrO7RU4Ls23T0o//0PdkCVODWMJkFbMvLiHkOm2+gUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2p3lYgG9dY8B5h1iYRU8fm5BG1BrY5Ar0SeS5Le6+M=;
 b=u5uS+KVlLVF+awrYJPldNgOWLWFuMBsbyW5VuZTmmvU+8Qj1ItXzToDQvj9T/YNumflEQ64BeHf4Ws5CDcOeZ1Q2oPP/FLsUtVFJhx94Y4U3VOj7b8or1TCPVyU4t6mPLVBm4XcBphMqJ0iuPDivneTRHtVNOUd8Y8mWwIgUdvHJSHwlbstA4wIkGM549AcxJD4O9M4ZU1VA0BCEBxXTEVRnzQSzu03eAiZ8iqIZ5+kdmheYe3Rv6MPMmk0IXlfHCA4XM8elb8VLC3BJusd2iOGUHjB5zym6d8xQ+nKdABNq3dPehhq7v37X6r1QUVlJsCKxPwStwqku8LHTP0mgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2p3lYgG9dY8B5h1iYRU8fm5BG1BrY5Ar0SeS5Le6+M=;
 b=M4W3mHUho1gP99vc4V7oX/r0UcoFlRT3qQxICd/n+A79NKFVICvJ0VHUvX8BCzUsVCAHhgtjX9ALGzUpaKthKsCMICkE0ftDt5Az1jpZCpgBFXlHNYmTLwDBoka3l4D3EofuHITp9EWdfci7Y2hvFQKqURb0xkNGwGHHEVbIUJUDvxXUpcUYEa5XYXNah3WKRFkrl5jmzm4yXYOwRukWSZO6Qko1es5oJeJOgK2LuIOVEPei6W2wCV0wDbnLwnnDRP788Tbhy9v2hUdEkqxyn4/ObCDrg+X48H5N0a0du7OFypwynuEN380p/7hd6W7/z/HNqOqiPkRhPTzrT3M6Bw==
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 07:13:48 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::13) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Mon,
 17 Feb 2025 07:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 07:13:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 23:13:32 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 23:13:30 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: support ESP in non-template RSS expansion
Date: Mon, 17 Feb 2025 09:13:16 +0200
Message-ID: <20250217071316.37195-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bd259d-b934-4ab6-0765-08dd4f229fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ib9uQ8e0uqCZfk/1pydsVakz6lUuu0z7TcpPggd9QCW9h/vXZIK/W2xawXic?=
 =?us-ascii?Q?V4glxI/4sflMtEDWY4SpoX2D9JFYZhxVlpdNGmYK+RiyaWDi/jkMT7YKr7IQ?=
 =?us-ascii?Q?MoZfEqiPdVIIUVHw/dYUVZ1kvoqIGbFs633l643ooDsE4Ot/sx9n1LBgGMu3?=
 =?us-ascii?Q?sIyf77M+wCknELbfIh0vv+RVO1HjT1jnC/OxPFVKBNMm35KhSJVjRzA5xWHH?=
 =?us-ascii?Q?j2D/rhEEyNln1VZBQlimeOl1SDUOeLgDwUfEl1YTpSxvGobzqHRkcsMPqmE/?=
 =?us-ascii?Q?WwTuHTfHoMaLyRGXxbElH4TN2G/1MedAkgX0t7xrCpobChUyUNyDtI3uh1wH?=
 =?us-ascii?Q?Zdq4+nW8+lIy1fmRi2TTdXN18tWKRjz/9PBS08MrR95tgUCPeAvT5A7196jG?=
 =?us-ascii?Q?dH9Ynd6YmxQWy+euX9vXpxpn6pUGzY5qpWdnfgZqpxWQK3iuwdyK7tiDfC7s?=
 =?us-ascii?Q?AzF9hEAt2FfTJnhhobkOi4caBFF5GXTjK03mJUgRMxtA4TDN+j5xKGO+iN/Z?=
 =?us-ascii?Q?1JPW2L8JDdBTlulQmiw6u5HJtIYmn7tx6LdixYtwXnpjcMyyLUYSmmcgiE2Q?=
 =?us-ascii?Q?GrmBQ5S3Bpn2GluEe1v7pSDBMLgaRurhwOe0zPth6gy5frcW+gkihpscn/JO?=
 =?us-ascii?Q?OvrHGnlyB2ZJXzEStWLw5h2XDaDF5hKLaEyXO11IVUJeVyIVRL+ENIVuXCbb?=
 =?us-ascii?Q?s+tBWbwk3uT559rzygIMp96Xbj89v+2TcNO1miloBcLFTELWILxEbAxSxAs4?=
 =?us-ascii?Q?3W54tPzGIi5P6lSQZ1BmWd/mAuKjglUFSZN8YbPtnd3vla8qHYpYdSXbQfpx?=
 =?us-ascii?Q?YTvNE58XDSDO6JSkqo7ks6gNwgo+tbXj5y7IsiZQOkuUBt9C1nbFgzlCXLnv?=
 =?us-ascii?Q?mm8YyotzTPdarNtliQeN5FJACXhDalxu2aNLy5jQr+8L0ET66RU6uH1G4Xvj?=
 =?us-ascii?Q?vXeXjUGLrqCJnyir9pWwzUg2TEqdcR2oZyGzUU7iv0EuMOXMHCwhl9iBrsIJ?=
 =?us-ascii?Q?G6fXLKDrXNUR28cjqLOhYVhEMHBgeNlTiZ4CUQZLpNJMG0qLHnKMEIc5b7xX?=
 =?us-ascii?Q?jz5WyFkgZbHuCzWAGRTQsz4L6dhFtt+OagJC8d21mLpnYmTziO6bD46IeA/W?=
 =?us-ascii?Q?dPX+i0berS/gA2g3eLUgf91xtYuag/HjZtor4DiX0dL1r90A5rM3TmOF24VK?=
 =?us-ascii?Q?UnvEzBp0LvAiY0nHz6RrL7o2YsVCA22U+WUFKm3AWVhni0yu6DZ1JaEa4s6W?=
 =?us-ascii?Q?FLB8DjMcBj5XRZRqfY+0MuNPybWCBDgW0YFgl8IMIMGtnQRYwKbK5kYqOwr/?=
 =?us-ascii?Q?THfQQ0QLqeXR+lE/SV9S0urChNMkdbmMYYZod4wjqAm+QLXggWm59foTFugU?=
 =?us-ascii?Q?JxUpRvuSL8DxBTqsiKwUvM5ieEd7URvjndeavCqBgeTYywp6TGFn7TTE8mUq?=
 =?us-ascii?Q?+DKeyU6HMqaK7VTXLbOlZufL1j2mBvMrmCAno8pP/c6iS2KCGnRWB9j9KZJA?=
 =?us-ascii?Q?So5beimJZwcTVCY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:13:48.2126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bd259d-b934-4ab6-0765-08dd4f229fb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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

Add support for the ESP protocol in non-template RSS expansion.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/mlx5_nta_rss.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_nta_rss.c b/drivers/net/mlx5/mlx5_nta_rss.c
index 602df301ac..8f00510445 100644
--- a/drivers/net/mlx5/mlx5_nta_rss.c
+++ b/drivers/net/mlx5/mlx5_nta_rss.c
@@ -123,7 +123,7 @@ mlx5_nta_rss_expand_l3_l4(struct mlx5_nta_rss_ctx *rss_ctx,
 			  uint64_t rss_types, uint64_t rss_l3_types)
 {
 	int ret;
-	int ptype_l3, ptype_l4_udp, ptype_l4_tcp, ptype_l4_esp = 0;
+	int ptype_l3, ptype_l4_esp, ptype_l4_udp, ptype_l4_tcp;
 	uint64_t rss = rss_types &
 		 ~(rss_l3_types == MLX5_IPV4_LAYER_TYPES ?
 		  MLX5_IPV6_LAYER_TYPES : MLX5_IPV4_LAYER_TYPES);
@@ -132,12 +132,13 @@ mlx5_nta_rss_expand_l3_l4(struct mlx5_nta_rss_ctx *rss_ctx,
 	if (rss_ctx->rss_conf->level < 2) {
 		ptype_l3 = rss_l3_types == MLX5_IPV4_LAYER_TYPES ?
 			   RTE_PTYPE_L3_IPV4 : RTE_PTYPE_L3_IPV6;
-		ptype_l4_esp = RTE_PTYPE_TUNNEL_ESP;
+		ptype_l4_esp = RTE_PTYPE_L4_ESP;
 		ptype_l4_udp = RTE_PTYPE_L4_UDP;
 		ptype_l4_tcp = RTE_PTYPE_L4_TCP;
 	} else {
 		ptype_l3 = rss_l3_types == MLX5_IPV4_LAYER_TYPES ?
 			   RTE_PTYPE_INNER_L3_IPV4 : RTE_PTYPE_INNER_L3_IPV6;
+		ptype_l4_esp = RTE_PTYPE_INNER_L4_ESP;
 		ptype_l4_udp = RTE_PTYPE_INNER_L4_UDP;
 		ptype_l4_tcp = RTE_PTYPE_INNER_L4_TCP;
 	}
@@ -469,7 +470,7 @@ flow_nta_create_single(struct rte_eth_dev *dev,
  */
 #define MLX5_PTYPE_RSS_OUTER_MASK (RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L3_IPV6 | \
 				  RTE_PTYPE_L4_UDP | RTE_PTYPE_L4_TCP | \
-				  RTE_PTYPE_TUNNEL_ESP)
+				  RTE_PTYPE_L4_ESP)
 #define MLX5_PTYPE_RSS_INNER_MASK (RTE_PTYPE_INNER_L3_IPV4 | RTE_PTYPE_INNER_L3_IPV6 | \
 				  RTE_PTYPE_INNER_L4_TCP | RTE_PTYPE_INNER_L4_UDP)
 
@@ -630,4 +631,3 @@ flow_nta_handle_rss(struct rte_eth_dev *dev,
 }
 
 #endif
-
-- 
2.45.2

