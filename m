Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D4C7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4FEE42EC9;
	Fri, 20 Jun 2025 12:42:46 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by mails.dpdk.org (Postfix) with ESMTP id 48F7B42EC5
 for <dev@dpdk.org>; Fri, 20 Jun 2025 12:42:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZVV6fVY8yW2JgkGLHLo97n9mw4nN7NQzxDH0d0DXvRUJGd7AD45D4mtgrMc4585I57G2NaJcJFPzVox+VVwB+QuvJL9AcHCAI9RIgcErBc9yGjedp4zzj8pbs7Tqc5+kM2djaPd4h24UsZW52HLBfF0nEp5MdYo73JZdzL6w92C9AQqVVNe+JxtSzSLgkxiY7QB8M5Jiic8nBUH9hwT3KGrbt4m6sfwh63M8bBRSWvFwPDJe0yIKOb0K3jQHPN6jNq3rM+KS7bM8HUJmiHmt3ilpPP1J0YvU5e+HFt1b4NybGr7moIbng0JbF+JoXr5pPF96H8lWwpxP053dAylFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMMPYwlTwnslylaLGu2B4eFhv9yH/xfBXJpKjWkRq40=;
 b=AUwIzBp2uEnXoF4A3MDvZtPw/YqgB+s1zelPNmO1hyG3C9K3Clo5vQ8R8+/SnVk15ITKY+UZTX8rIajPYc7hfislhyqlv7y9opOrJqo6LEUCxqIi9XsbiASb26AWLzGetqn5Ja4eenzt1GBZlQv1DVsyVoAa1CXOjwsfKjbSUF/mVA2P0mlRL7RwOateJHI/IPeQ31OKP2pNdqsbA4IObt+k4afvNKiHEjIeqlX7G5iANkM2UsgZwj0kePNvvSoVwHKgB9Ky25mPpHZZlmJi19rL552Bh3nvhF28hthL4PhCVSIa/MTEwqi4KsXnTHLvEXvnRE3K8DRSUttWk46k2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMMPYwlTwnslylaLGu2B4eFhv9yH/xfBXJpKjWkRq40=;
 b=c26P685uVSp4st6mjTnumYMT0z1bmJEs6TAwj61wzJcFOVMAmbg6L0oETHbUjo/Mv276z12KeVxqVbGL+50dttisC3kfkC3yFsslXCNy3HWhfJMfNdLOyEqtqx0dFCyt9SGRLBu612vv2chCkeMOTF6kJT8Zsh5itjRB9lSltW/YkqlmKw+0p5Bi9rB1G/jpNzIzyAeTml+x7RA1PuuoaVQNvTcRYYAumQj4kzJuxxNQjVp2zhhs43xG81S8DTeoaRvT97Lnb58QwhAtAIesjhxySbligMuti8pxDJ+GFiMmR1vTqTY5hGJzmaW3Zzabhvhjxv3RNmgojy1oll0S3Q==
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Fri, 20 Jun
 2025 10:42:41 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::10) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.10 via Frontend Transport; Fri,
 20 Jun 2025 10:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 10:42:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Jun
 2025 03:42:32 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 20 Jun
 2025 03:42:30 -0700
From: Junfeng Guo <junfengg@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: support IPIP flow for all combinations
Date: Fri, 20 Jun 2025 13:42:03 +0300
Message-ID: <20250620104203.261435-3-junfengg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7009d2-5a0a-4f68-46fe-08ddafe72e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YZOWVnILRPoANplnrlYIPYpKMAcW0rjXEP50CZj7SdTt2Z20Cd1HH9A539gH?=
 =?us-ascii?Q?aEz2U/RJ3OFIz1t+C0RGA6tyOJVLb3XWXsoEz0BWIYYpJhMoToywysqAELQX?=
 =?us-ascii?Q?omwZiYigPEJeiSjgoenO3FJlByqLmU2e8f92yWv6KVdPD7X/JdFwnUkGMksS?=
 =?us-ascii?Q?0Au+Ug0m7AmCLQkb+vmaEKvI6JVjL3T50QT5MhBty05i0/qaRVHPFCrpgbfz?=
 =?us-ascii?Q?/4jkAmYwNe0mFP9UaBQdar7oBoJILliMyoL6tNIa+XUSPo/WWdKh3mOFMeQK?=
 =?us-ascii?Q?bbMjTliu/ei09qcv/gnWd3tHvEM2ZjVs+EIGgeDhZMOHIlw7rHF2JZyZVP20?=
 =?us-ascii?Q?bZrYFJlvAajy6bbikzKWy7Iy1JUsTJTM1z546oXU42cueSu+v77BhxIeIUmP?=
 =?us-ascii?Q?MZFJYgXDr1AQhrgb6Ae8XdSyNLp6GJbW/bDlRuN6nlXfitjEXdGaDUIGHiw3?=
 =?us-ascii?Q?VKO6VPNmk7z5rTwlGwWPYXV35BgBE+CR1Q2kWsDSjnI7nPDTdfCkvn50C3FO?=
 =?us-ascii?Q?TGPpUyJcVPJoP6odpr7bQNbd7D5kRPsfkQubOQlf1m4n6/pJx9dKATpXusDB?=
 =?us-ascii?Q?UjkX2h1Z9MhbZbCvTUwZpgxch5Jg4QNDI2U7M++vnJajU35iE/Z7AmEZH/ZH?=
 =?us-ascii?Q?Rt6Vq2mOdW2bgVgg1gNxj0I8IAaNfMX1lD0V7AyaslDNiYfjbSPwER1C7Ylf?=
 =?us-ascii?Q?hTlu826ylllOsJH6m7l+U6PVW2P60xHh55vG0aGPUXbViVKGm4UZhkZQgSzk?=
 =?us-ascii?Q?Jll1rU4j/LjhBu65tKDcWEk/16G0ybJDxj7lycqhRzPEst0wbfPkSLF+HeE7?=
 =?us-ascii?Q?zpzlOhLQxrpbW+bQ0APR7LJ6tIICEPmeoDFctwREOnPPVGuhTczfa6S0uBcq?=
 =?us-ascii?Q?PJezX7kr8muOroppX4glyHTLbu3q6iZCVY2FZWYUyhf4ziSN7PIhF+VoMXxl?=
 =?us-ascii?Q?8SJaqr71O7VhtXIk2Xsrm8dPus7D2QajgsZKJSpp8y1c/+4evgf2LUXpQyEg?=
 =?us-ascii?Q?OjvJ2NqvoMXNOmx9cq1GkOuYKPpZIrJLh0eXOayMMELHBBWIizVg0yU9MHD2?=
 =?us-ascii?Q?9oJ1M9VcJ0O2AyDBUfCIdg/dwQpiaMQuXRPphOkyVZ2wwlRdP6nNp5R1feoB?=
 =?us-ascii?Q?rTqPasxr48J3jmsZ8tkltSaoO2xlqtddWkicpKZD3hhpnOgdBx5WlBisZLRS?=
 =?us-ascii?Q?/LRzh0KhskYISy7XSmqVj4d7TMaZqLvRCTmwIURxXs3ZtJGBtvf6edqqKsBl?=
 =?us-ascii?Q?wdRh/DlWLhHB7BhH+CzJ8uLJL9s+BaiM/doWMjlN0IUdU3NKGqtYg60eq6bU?=
 =?us-ascii?Q?WTyz8UAQNSGS/TmYtvOVTIc3qE0rCeHETreCCQ7jQXhsQXtgtwDlpn9CnQPo?=
 =?us-ascii?Q?nD+srmKQAgOUthQXTD8YSUk1yWawVsC2K9mP/8T7bc1IGrpQX1TeW4YLMCy/?=
 =?us-ascii?Q?5/vflzV12Xw/xSwJnjhPk5x83VcTmRd6/5O+BLQWlbopEYxXB0ubSzXlMlTM?=
 =?us-ascii?Q?qUx3al0IhIGtmZYbSyqyRyi7DirwcNFVXWzd?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:42:40.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7009d2-5a0a-4f68-46fe-08ddafe72e66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

IP-in-IP tunnel type includes the following combination:
 - IPv4 over IPv4
 - IPv4 over IPv6
 - IPv6 over IPv4
 - IPv6 over IPv6

It's okay to have MLX5_FLOW_LAYER_IPIP flag when validate IPv6 item.
And it's okay to have outer L3 layer as either IPv4 or IPv6 when
setting the IP-in-IP tunnel item flag.

Signed-off-by: Junfeng Guo <junfengg@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c    | 5 -----
 drivers/net/mlx5/mlx5_flow_hw.c | 3 ++-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 3d49a2d833..8db372123c 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -2973,11 +2973,6 @@ mlx5_flow_validate_item_ipv6(const struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
 					  "IPv6 proto (next header) should "
 					  "not be set as extension header");
-	if (item_flags & MLX5_FLOW_LAYER_IPIP)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ITEM, item,
-					  "wrong tunnel type - IPv4 specified "
-					  "but IPv6 item provided");
 	if (item_flags & l3m)
 		return rte_flow_error_set(error, ENOTSUP,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index af2e7a84a5..0aaa8fe2a6 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -8325,7 +8325,8 @@ mlx5_hw_flow_tunnel_ip_check(uint64_t last_item, uint64_t *item_flags)
 {
 	bool tunnel;
 
-	if (last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV4) {
+	if (last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV4 ||
+	    last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV6) {
 		tunnel = true;
 		*item_flags |= MLX5_FLOW_LAYER_IPIP;
 	} else if (last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV6 ||
-- 
2.45.0

