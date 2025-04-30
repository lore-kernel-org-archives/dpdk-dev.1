Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FCC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 11:04:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EACC640B8C;
	Wed, 30 Apr 2025 13:04:09 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by mails.dpdk.org (Postfix) with ESMTP id B4976402A7;
 Wed, 30 Apr 2025 13:04:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvmgy3or/KDdRoZCq0/712D2OB1K3/wjSJ0p4ap6o7pVkzT/L75Kh+Q33tSKJksg1qbH1KQGhjAv0axywJJJgK5Zw9T3un9c1G6UIqpyC/xykkkT+C4wAHg8GlnDxHOrAROSE4U6aOQZMuSgPNcjk1csdf6R6ChZPF8fIS3+vPNVGHIy5DWLC0dLfKoLMCm/n4Q7cbo/SANZeLyoadMkU/Q05Zl+VebL3f60jiV6ExXWcQlsIkJ1Uaero3naN3dlbCAF/QnmGer6t91DbIpJrZhG6IJSQGBQu9A61RXdeXJ1CBtI1CE1eF/jbsRPy2yxMHyjS47nb2Ym5ZFf51+lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euH1sQKq9OtU2zskiPORE80dVQc4ph1JcRXxaka6XOE=;
 b=xLeCZHLYTFGSR+5w709lTnosNxYRE5M/0mYDhKjFYeCuSEi7NAbM9mwfeVWi8/yL4cZ8rE7KS9MpieB3aSaAmnpWs7fM7JHJLeEud/5U1J5qFnRetcjiuWQkvm/MLAs/5ssRVMoWHvg/aOoYPjiccgOtGdXPlW3EUX37aLwMlQbASDB3otB5x6NYRcLicWFOkR1lOkufsAUGy9lMG0lHA6UhjzPxIj8gkUp3LS8W3uvVYFE5qozk8iUHzVOWJZ66bjvJ067SDhPG4Fon3HaIEtkZ9+dLMjZZ3qTnO4LtTH/CwjWkeyh9Kcc3hsxxWG5vvuEjVSa0hodEHGrC/zyMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euH1sQKq9OtU2zskiPORE80dVQc4ph1JcRXxaka6XOE=;
 b=iB8wQgWN2oGd1T9N4jxdebWxIqRi9lSHdbVt2ZcUGqcQwRAEST/zBmD6XSht+WLRQYo3Mo612D1bvsaFBNxR9AaIBRycSUg/gvSRIJX3gKHwYcNRQcBfdvo9g5v8beBMcpQXDoV9SYy77Ql8nFpqqIxnjrGmnI3lCpSmaO655mj2A8jFI73MNzE2UofcVj9owQmbJqu/IQgfl2omI9aj6jF38YhQuH37gs+/0t7wRalJYLh0w4ApIZkBw7Nc2vdwelZHb2VPQVXO7cNayEnZDrEOmVpsEfmYvT7QhIG7QhgsPKwdLLY+QgIjj/J8liclJwjiOR4W1oTpbg9gP52zFA==
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 11:04:04 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::a9) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 11:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 11:04:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Apr
 2025 04:03:45 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Apr
 2025 04:03:43 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix flex tunnel validation
Date: Wed, 30 Apr 2025 13:03:31 +0200
Message-ID: <20250430110332.75903-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 558e61e7-2029-47db-617b-08dd87d6b7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xfl4TJzjWoWWbzJsj9OkFKfvtCyli8SmAnDgkkTgFq7UPy9Begicdgkw9j0i?=
 =?us-ascii?Q?/3+y4zydXDj46f7q3tR1fY9BFKCXIBntZEziKL9qnTHxLT5BYikfINF/yJWX?=
 =?us-ascii?Q?tY46YRnjJIz1lsvJ10e4UneNp86JLq2ewX8irKU9bhijordVuNU0RMefK0mT?=
 =?us-ascii?Q?wXM7DIY0MbZ9XE+0rX+zUGVmgFk2prnVd9rHcjivrnSJ4fmoCk7r4Om977b6?=
 =?us-ascii?Q?heSscwvI8n/T9H1y6Tg9O78YmaTqpskC2wENP8G2upV28z5WzU1w8xeIwzc1?=
 =?us-ascii?Q?aeN+p6f7NETULOmOxkSjEmsr6qSht34m5QZWieyyMWw4BeMSLbQ8lFKjhncx?=
 =?us-ascii?Q?0nkEWrUEgAeWuyIi8cv9oqiPMR31JHAAUqYPB7Lm0orKyhdqwW5aYcmJeNci?=
 =?us-ascii?Q?aDvUGko4YfCn0jOUIwCdnTvw6vpL6lDVNAdXveqFdWEeiAnK2Coy3NLpn+M3?=
 =?us-ascii?Q?naC05jCEBwuH5cC9WSY3xV+aycrKoXVMTsvM99HeTiMkcieWGv4TdYb6F6qy?=
 =?us-ascii?Q?t6qf9kHoAMkGM35IzybgJzqPQTKhjHMzwvkNXl5MOhJEEHTFMmzbJY7i4SxM?=
 =?us-ascii?Q?RfCpA/iEK4OXRjK75Twu883sekUKq5H3imQP7fL3e0uhvTWkKG6kREPL8lRa?=
 =?us-ascii?Q?HkeA/WF8uWTwI3iCT+LD2qyDcgjEJM4gUN7xBXA6L+Cwp/7sKadIqoZZFaun?=
 =?us-ascii?Q?OCRTZ8+hZ4U4dghdaXSZ36ud1uakg1XRhxnsO5ydWFNboSN79+ag2nxk+DNd?=
 =?us-ascii?Q?J2Zns5Ct2V4rlWbnwySAK9/qudeLQl7mzK5dxswRZBxF8SInyYwvOFdz074O?=
 =?us-ascii?Q?LqErusX73oe9um+s2CR6G643Rk5FpI/DrlnxMovYc1keFCgKbkyuzaQB/xm5?=
 =?us-ascii?Q?t8En0pebm3grrE4sqciQievRl2LFpR3kpm0ChJpgJJwu2TeszHcjyWj2P3PN?=
 =?us-ascii?Q?Io0tj7xRzLE4UOwUXKTO+GavF0qKbFzYq1bIpOrDz2+MQ5qAxyaP/kHKrmGq?=
 =?us-ascii?Q?R7h03Fo8unjpwZZeC8EDyQtwlLQj3yTNz8lKrOIVx60fV2XA70wzLvybOtVW?=
 =?us-ascii?Q?fVl/Sj67Pi78VhY8YKUONVMsMZrFtoZBmwI5tkvrIyHlo/BV+xaR5ALYroD5?=
 =?us-ascii?Q?KPoNp/PUSATZo1sn0bc1nLYzBnOWEzRZGR5+Kb0mQTf1voQt4Gzj9Ld28I5H?=
 =?us-ascii?Q?bM+iJY9L+HgjO9FSb7kF2mZTMKHxCY4lOYm+W0k6c3GTBoY1IUZfyF/0abUl?=
 =?us-ascii?Q?jMUizOGEb8Q0uKavlxkSEas6rkbJyAuJvGB5A3EQyyCyE+Hbxznw0+zb9FuB?=
 =?us-ascii?Q?ZnLk+l0kXyqx9Nt4o1y23QAZ+KbEOpxEaRIj2gSZ+fx+MqzptshrasBMvc1b?=
 =?us-ascii?Q?e3UPcXRQNhO20sTGcE69D1vFfc8Vf0iwav1rPvavbIZKu2Yz3PkRMtfB7BVP?=
 =?us-ascii?Q?iQ9R9K+OBIMd3KF1RlW9K0gVFnj2hyz1xjH44WE4d94dq3EjBMcPfOIO3kkp?=
 =?us-ascii?Q?DISgwtYjQriTYXuVrNKzEB3D5BjMlelWITug?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:04:03.2731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558e61e7-2029-47db-617b-08dd87d6b7e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
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

Pattern template validation did not take into account
the configured tunnel mode of the flex item.
This caused validation failures for templates with
flex item registered as tunnel headers.
Specifically, any item after such flex item was still considered
as outer header, not an inner.

This patch fixes the flex item validation,
by correctly updating recognized items bitmask depending
on flex item mode.

Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
Cc: getelson@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce414..723652a6ec 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -8867,12 +8867,21 @@ flow_hw_pattern_validate(struct rte_eth_dev *dev,
 				    MLX5_FLOW_ITEM_INNER_IPV6_ROUTING_EXT :
 				    MLX5_FLOW_ITEM_OUTER_IPV6_ROUTING_EXT;
 			break;
-		case RTE_FLOW_ITEM_TYPE_FLEX:
-			/* match mlx5dr_definer_conv_items_to_hl() */
-			last_item = tunnel ?
-				    MLX5_FLOW_ITEM_INNER_FLEX :
-				    MLX5_FLOW_ITEM_OUTER_FLEX;
+		case RTE_FLOW_ITEM_TYPE_FLEX: {
+			enum rte_flow_item_flex_tunnel_mode tunnel_mode = FLEX_TUNNEL_MODE_SINGLE;
+
+			ret = mlx5_flex_get_tunnel_mode(item, &tunnel_mode);
+			if (ret < 0)
+				return rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_ITEM,
+							  item, "Unable to get flex item mode");
+			if (tunnel_mode == FLEX_TUNNEL_MODE_TUNNEL)
+				last_item = MLX5_FLOW_ITEM_FLEX_TUNNEL;
+			else
+				last_item = tunnel ?
+					    MLX5_FLOW_ITEM_INNER_FLEX :
+					    MLX5_FLOW_ITEM_OUTER_FLEX;
 			break;
+		}
 		case RTE_FLOW_ITEM_TYPE_RANDOM:
 			last_item = MLX5_FLOW_ITEM_RANDOM;
 			break;
-- 
2.39.5

