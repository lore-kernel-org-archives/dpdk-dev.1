Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FBC282D1
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 13:35:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 964A8402DF;
	Mon,  3 Mar 2025 14:35:30 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by mails.dpdk.org (Postfix) with ESMTP id 7C985402D6;
 Mon,  3 Mar 2025 14:35:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHyU6fTl2BeLyUbkG5rjd2je/UAPJw8i7hKDz7SerJi3GAUdkOM0PSdN3QWBqp9bQOqaueNMzHDnIlGDLW4VkdJyT+GhZUt+gW1/koFBqQYTj69X69s2aBXHupxLzggMA9tKgat/gTjSXyT2DtpDDwKWgcZl7UJRFJYj8P0yC2yXZLL2OluqDyPf7fbtza9kEHCwzupuHxkWP/N3A4XO28U/++iUxYJgmtMLp3r4SCr8wfcUtbkPKOmhulL+LyZaIl2LzkNLk8MACrFg138JaYQjx3WHf4lvyHWXkOl5d8DZ1JgTXYGJzE5UMTBlqtLf0N+X72N3P6rRtoXqtzjOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xODNc3JD9dicTq95BhyVLnsobkZscgZPpIyWZi35uLU=;
 b=ken4mPRYRFH7HB27IsL2LnkkNfPKljERth7L8ksqSJUNdadmbgad0zugeVWxXDiSOjQJomjH8n/+D8U+3BN9TrvuaGxcYoCe7/DeqYe5w53kywoT/tBmTWv1z23u8zouIjUGq0S37bQN5E4xQZV0H8rNUFOnc+CGBvQt6MnoT8m4PaVK1ASCibHxyJy014Md/PmC6R0YqO+oIAXtvIO6gYHjBskCyPAae75YMp4iNVOeJ1pkuzKoG60K8VjA1BFllvEsnkSCSfHO72B3FTRUZ31ORX/fuuWnL83gyOfM+OkHziC6+UsTQY7pqLV+LkpTJepP37Ry00nABrdiFt2vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xODNc3JD9dicTq95BhyVLnsobkZscgZPpIyWZi35uLU=;
 b=Il4WHiZI7wNDLjuLBEhoGGAhOJANDmrk411DIQZx8qyWgC2mPK9C5mEL7MXfXlZ4l7zQBso/u5w69qQmsmqE5FyW9vWuZEAHMwv2FCe2IGaEXBykXbqj4H/pjsuXzY53TK9vE0tDDcpYOlOwzEXSVElL5i3+VHAGyZ6zh1YDKMUXBDYG+BhHXNz/ydmvw1SrEztRkIL9JzLw08PgDN6cK+pXRc3IcWZtz7uLeZnfoWQ1DpxLeBEqJqCk3vXX0XQ/hSC5Q7Z0EBbKAJt+m8XUnE7HJFh1ZbLRoV1IvQkeuQMlXIP0B7WBWVyml4X/d7Ni1RckQYik5Nj9vFyMng6lqQ==
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 13:35:23 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::64) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 13:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 13:35:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 05:35:08 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 05:35:08 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 05:35:05 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: fix non template flow validation on create
Date: Mon, 3 Mar 2025 15:34:49 +0200
Message-ID: <20250303133450.71626-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250303133450.71626-1-mkashani@nvidia.com>
References: <20250303133450.71626-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: fa95e775-2815-4960-889b-08dd5a583f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4sw6EuCTx6+H66DKiNsZBWqI4Y/j0OfTEspvtz55jW9kBdxR28HGJMeqEb9k?=
 =?us-ascii?Q?85Bwgs4+D7unUp7aIjiBoh1eq7TKe3XCJWdvXz3uFhFOVYjUTR9XP7omUlkO?=
 =?us-ascii?Q?fyg+xacEJvYN39l0Buwx8vZuqkNa2SH/tcqUQkCcTlrVcIEo1pSc8rQHkNgm?=
 =?us-ascii?Q?WARUoLRBfJRfQd6r0CaaW91eerf2EUOIwCOyb5Zi7do4zzADtGExftx3HD1W?=
 =?us-ascii?Q?hNTWBLY3pNS7ige3uSmhtGOhKtHdJJb6Ejz2r2VKwxAtK5LVnsT12uhfRB9A?=
 =?us-ascii?Q?NjYKvJyif2QxGoLmxcVgWOOByLA7sUIpcIdd244Gg3JZyRru25GKmPNlA7Tu?=
 =?us-ascii?Q?sz+HZQZPhgDBLSVnDfYLQdP4tdOC7tWjp6JndV/1wAawSaXsqgcG6/lOVmgr?=
 =?us-ascii?Q?vweHmxtMuYbUsY9m/0w6Iuj1CHq3fmPvHSJJPjXmbFIp9ZYX6UUDS2bKV65G?=
 =?us-ascii?Q?tXZ//BrSKsU8Jn5kH10MIYc+vdL6Tbogl2qB/YRn8nYueYj51MKZsyuxWbLG?=
 =?us-ascii?Q?RRYDmCW1znzdzgF3Y7h7+nGTT7WQdpbKRRtB/viG0t7vBPAj369uu59fDc4f?=
 =?us-ascii?Q?QElZfbJOrDxG63Inn0Y6odpLgQzEkKeYfoO1EEUEb5qO6zz4KGcYP9rmAKtj?=
 =?us-ascii?Q?/ZotAl4WCXUMjAa9gtJsAOfrJF6xqiR3Beuo8XpcgV8ManoZvWYpXQJ3jkKG?=
 =?us-ascii?Q?Hfqxi9HOSKex04UZ6Vej0M5PMLDAUy/KaWNRmrQRAKyqeb9RL7mAyFqwJoJ7?=
 =?us-ascii?Q?FuJVJxSYhPmAE31co96aq91BFOfoVNcyPJk4rAnYOhPUSGqlw1b+oYpx6VNa?=
 =?us-ascii?Q?db6Qo4PpGMXbghxMXHpBY7FL3uch2tzRIJZ3OvriZnF/gqlw/VrQc1Puqe20?=
 =?us-ascii?Q?hEx2L2Et5+V5YdTBwfToc1OU+uBcMmhJkc/Ro9i59Yccj2VUqToXtPSjR5nC?=
 =?us-ascii?Q?P8uq83C3j8WUV0s2swThRE2vOAFVnzMamj9CrIjaYL981+Rp9sE4iRY6nN64?=
 =?us-ascii?Q?7OHe5QJpPPtSB2f9yr+iWDxOLtnnsxGj1sMY0itnmg0E4R71uOpd05F1XKns?=
 =?us-ascii?Q?R32SsaXJmXIkPTYKZl64nWK95fROT5LKiyucRXudjB33NyeBKYpAbMYkBWBc?=
 =?us-ascii?Q?WeKU1KRyx43FPJa/shT7+UjYnUWFGvr3aZQ8pPk2scZaQQnEKED0tYL2xsRa?=
 =?us-ascii?Q?Exhb+d7qmo+avi0po06eVCHcSxLeet9uxFRFLq25FABMbj3a1LA64ZY2eFe1?=
 =?us-ascii?Q?9B3LUkHf9my8KnAaW+mBCBktecJv3Ddwf80XzyabarQ8AylqcqkhxEyZQQj2?=
 =?us-ascii?Q?2Bv22wP14kgT6POj2GrIjBsmamRcW4z8t4z2pPXclNCbvmlf9wtyzxqzB02y?=
 =?us-ascii?Q?U6vbv0/lL/dRYKzRS0CKnVjeHnyHTZyxhskA/hmHwNk+cDBmPq/6bgwJB8IK?=
 =?us-ascii?Q?rWEsWmMcnJ3/kgn4cmaAs6HorHNq2V803cvRst/vYtcF43jNsQXeyXXko6pi?=
 =?us-ascii?Q?8iztHHIn+gVouew=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:35:22.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa95e775-2815-4960-889b-08dd5a583f74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

Currently, a non template rule on top of HWS can
be created successfully although validation fails.

Added in flow creation, the rule validation,
And deduce the items flags from the validation items loop.

Fixes: 0989f6808401 ("net/mlx5: update NTA rule pattern and actions flags")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 98 ++++-----------------------------
 1 file changed, 12 insertions(+), 86 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 9efe41b1127..b05f7135ead 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -589,87 +589,6 @@ flow_hw_hashfields_set(struct mlx5_flow_rss_desc *rss_desc,
 	*hash_fields |= fields;
 }
 
-/**
- * Generate the matching pattern item flags.
- *
- * @param[in] items
- *   Pointer to the list of items.
- *
- * @return
- *   Matching item flags. RSS hash field function
- *   silently ignores the flags which are unsupported.
- */
-static uint64_t
-flow_hw_matching_item_flags_get(const struct rte_flow_item items[])
-{
-	uint64_t item_flags = 0;
-	uint64_t last_item = 0;
-
-	for (; items->type != RTE_FLOW_ITEM_TYPE_END; items++) {
-		enum rte_flow_item_flex_tunnel_mode tunnel_mode = FLEX_TUNNEL_MODE_SINGLE;
-		int tunnel = !!(item_flags & MLX5_FLOW_LAYER_TUNNEL);
-		int item_type = items->type;
-
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			last_item = tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV4 :
-					     MLX5_FLOW_LAYER_OUTER_L3_IPV4;
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			last_item = tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV6 :
-					     MLX5_FLOW_LAYER_OUTER_L3_IPV6;
-			break;
-		case RTE_FLOW_ITEM_TYPE_TCP:
-			last_item = tunnel ? MLX5_FLOW_LAYER_INNER_L4_TCP :
-					     MLX5_FLOW_LAYER_OUTER_L4_TCP;
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			last_item = tunnel ? MLX5_FLOW_LAYER_INNER_L4_UDP :
-					     MLX5_FLOW_LAYER_OUTER_L4_UDP;
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6_ROUTING_EXT:
-			last_item = tunnel ? MLX5_FLOW_ITEM_INNER_IPV6_ROUTING_EXT :
-					     MLX5_FLOW_ITEM_OUTER_IPV6_ROUTING_EXT;
-			break;
-		case RTE_FLOW_ITEM_TYPE_GRE:
-			last_item = MLX5_FLOW_LAYER_GRE;
-			break;
-		case RTE_FLOW_ITEM_TYPE_NVGRE:
-			last_item = MLX5_FLOW_LAYER_GRE;
-			break;
-		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			last_item = MLX5_FLOW_LAYER_VXLAN;
-			break;
-		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
-			last_item = MLX5_FLOW_LAYER_VXLAN_GPE;
-			break;
-		case RTE_FLOW_ITEM_TYPE_GENEVE:
-			last_item = MLX5_FLOW_LAYER_GENEVE;
-			break;
-		case RTE_FLOW_ITEM_TYPE_MPLS:
-			last_item = MLX5_FLOW_LAYER_MPLS;
-			break;
-		case RTE_FLOW_ITEM_TYPE_GTP:
-			last_item = MLX5_FLOW_LAYER_GTP;
-			break;
-		case RTE_FLOW_ITEM_TYPE_COMPARE:
-			last_item = MLX5_FLOW_ITEM_COMPARE;
-			break;
-		case RTE_FLOW_ITEM_TYPE_FLEX:
-			mlx5_flex_get_tunnel_mode(items, &tunnel_mode);
-			last_item = tunnel_mode == FLEX_TUNNEL_MODE_TUNNEL ?
-					MLX5_FLOW_ITEM_FLEX_TUNNEL :
-					tunnel ? MLX5_FLOW_ITEM_INNER_FLEX :
-						MLX5_FLOW_ITEM_OUTER_FLEX;
-			break;
-		default:
-			break;
-		}
-		item_flags |= last_item;
-	}
-	return item_flags;
-}
-
 static uint64_t
 flow_hw_action_flags_get(const struct rte_flow_action actions[],
 			 const struct rte_flow_action **qrss,
@@ -14283,7 +14202,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	struct rte_flow_hw *prfx_flow = NULL;
 	const struct rte_flow_action *qrss = NULL;
 	const struct rte_flow_action *mark = NULL;
-	uint64_t item_flags = flow_hw_matching_item_flags_get(items);
+	uint64_t item_flags = 0;
 	uint64_t action_flags = flow_hw_action_flags_get(actions, &qrss, &mark,
 							 &encap_idx, &actions_n, error);
 	struct mlx5_flow_hw_split_resource resource = {
@@ -14294,11 +14213,18 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		},
 	};
 	struct rte_flow_error shadow_error = {0, };
+	const struct rte_flow_pattern_template_attr pattern_template_attr = {
+		.relaxed_matching = 0,
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+	};
 
-	/*
-	 * TODO: add a call to flow_hw_validate function once it exist.
-	 * and update mlx5_flow_hw_drv_ops accordingly.
-	 */
+	/* Validate application items only */
+	ret = flow_hw_pattern_validate(dev, &pattern_template_attr, items,
+						&item_flags, error);
+	if (ret < 0)
+		return 0;
 
 	RTE_SET_USED(encap_idx);
 	if (!error)
-- 
2.21.0

