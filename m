Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62949CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 10:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81EAE4014F;
	Tue, 12 Aug 2025 12:09:04 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by mails.dpdk.org (Postfix) with ESMTP id 779AA4013F;
 Tue, 12 Aug 2025 12:09:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KADazRJWwtWlR8qv7SKlEZJwXS+KEvSLF9rmKI7vNYlik1w/jJ70+Z1+mm91GukvrDNVHjUthWpg5Qj6Fk2B52ppis5uB9ySDjUpR4QgEBFLmEEIOTkzfhwjULwBW//l3y+ofEfdkwQ186h0VI8qiLIcru2xSipOYeyLiWhv9rkwLqfpnYZK3xQ3rR3GqHtJLzahKUHIDPwxF9bhPtoqyi2lV4VxkfeL24ccwZFlYAtjD3GUnbM8bxJuOMjOqTJF1jyrx8ugommU4RqoEX31X0Z1+L8oXCSk97waQG/8LURxb2dKiwCytc94k7p4gg0PSB7CFdsac+fMfOyq3FfENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3y1sBBGgh9kCYbABEegdmdM50rxtkBIdI6HME+k5kc=;
 b=kOIQJ6R3J78+HY15p+Jl7HJ153C3mlWZ46JGcO6p0XiW8KKT3eAAV59RRVP/TdgXxBPvBADXmJMLAVe36BTo19XBbwoBpZYy+l2u8jwmSWYZVKS6SAiAlWRkdmthfEhQxqknDy23cgml8cyoD8BeSbV2suIeyu8ZCVv7SQFi2jaR2T9F41nJtPYKUiYq0JUeE9dxhgaP2/DQIMHsTNq0670YBuQnb+1PJjHn6p/YONqchBn28rg268BrbrCwvPFRzIF1L4hgqnZLt8fawts6WpUkbFq+mH7ynXTFOJrrLRngzrD2MltE/xcS347MXJyuNdlUuTH5wyRnx/rO3tz2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3y1sBBGgh9kCYbABEegdmdM50rxtkBIdI6HME+k5kc=;
 b=iRkz6gf1q+h4RKDKp/yZNzp1UkpkSk2XlfFwDTlh0D9P84hhtFdTAO1aUW8gJWyRbfFKyED44lt/UWQ5rHRdJDkZhoAcHAqindcKaLv+OulkEK3PwZ5nBQdnYtcrd2SfkD/xoZ2xYgZ0FucxBMGv8AfMEiwmxV7a2+ixH8UfLqZagmDX6oLEyPnsR2KpFEto092IeE4rOaiWMosLHSMyH9oVgU3S8KP2NCMrUyIrCs1TuvA1jUM+chGnItvabQEKeuLKTYf0QzllFYaS7IWCrsf2J9KGsa7s/b2nMpYaBMISHJOPqDAIuQZPNW4oFJ2HLZ7zvSw2b6178J2h0J+mug==
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 12 Aug
 2025 10:09:00 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7a) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 10:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 10:08:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 03:08:41 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 03:08:37 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix non-template RSS expansion
Date: Tue, 12 Aug 2025 13:07:16 +0300
Message-ID: <20250812100717.134263-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edfa672-07ad-41ab-668f-08ddd9884185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2aiGXrahHLIt5HgAkyaGVjPIR2sNwN7m6kdCd9UTkl7Id3av16WlEhO/3xh8?=
 =?us-ascii?Q?K4AWgTzFvYLCG9cRMp9Y2TVqlZ0XDleFPDY1Hfny/bU/BUkfZJ7iCA6QMBAC?=
 =?us-ascii?Q?y/NsLVg4/BQK8iRW4CNPv6wQ96vGpiCNowyE5o/TJnP26HVhDiNRQAfAoH36?=
 =?us-ascii?Q?VI4yjiMdYFpgW8v/nrNC+LTAU61rGU4hM03yPusPTTGJwHxgPoxD013R+1Rs?=
 =?us-ascii?Q?oFHkA93h8yyf/2u6A72at87XyVsvKtOakSmjCt33PM8XqR5MMLn46GCvkD7n?=
 =?us-ascii?Q?8MnhVBelaFec98zfvM4rO+rG1R7GYAjhMRAdUHRxSPJkREXTB253KDyKJdHv?=
 =?us-ascii?Q?4Q4zY7Q8K4vXx2LRX22Mm00vxmdF9GpHs2cJJ6+9po5FOesC5i+HlRwFON1t?=
 =?us-ascii?Q?/8AquQIEWB35M4xg201iISG/O0qKEE4Ogq2PU4/d/pu2uRBTiqV4Z0w5JCQB?=
 =?us-ascii?Q?uv8neeB01774MtxpJT4wNRTX5pxTWWLFOM41OqbR5F4HWpETJLKqCkdGAm2T?=
 =?us-ascii?Q?vcrj4X50BrDDGdyF4meUVIJTHR24hPmka30aFib6yzLkU0md3Qsrn0KSV2DW?=
 =?us-ascii?Q?NxK1zLYqcFS5pu4qNeg3dmTHiNZmK3+c1r3SDCwZAM5qBYJQytkMZULS7wrS?=
 =?us-ascii?Q?hJDjn4ZpEuk/MmF6VSXH14MbZIPDAAWqb8iZzLwgOCBnhVpOaVf/Ph2HqThj?=
 =?us-ascii?Q?TzbMuHVi29oiFt1KOhJHk1Dgwn3ZYli/Gpbtt+7WGlJD2Ov/ofVofjOPqM7q?=
 =?us-ascii?Q?W6YI3Q53edQQAjwvgH1BCz62ppeEIR5SyPjRoVXxGwOme/sAYxCjAkkFC0iA?=
 =?us-ascii?Q?n8QA35/Qqnm47uLzmiFF2deEdzhZHaZ3uDS+c3JIxlPFAL578jhltntTZLmJ?=
 =?us-ascii?Q?wP0WETqV0wmrHfx/ubZl1eqH/w1CZzTmsvGYxGCM8fMV3va69bM/hf1DeLC7?=
 =?us-ascii?Q?4EFFIeURWaX7pNurhe28XnpcbRo3gdt00AItAa8W8Yw3ADp4NUFtzh4GoXx3?=
 =?us-ascii?Q?yGhvzrgGWep0h8dupuFfT2xa/IbSUVOlhnHNIr3UazWx1YpWj3bYBNDQZiSu?=
 =?us-ascii?Q?jPZlXl1BJzkT4+YdRFQQOXwpesAHtsqTTwrC/Dehju4qKqaYGlaaLuJtVZo0?=
 =?us-ascii?Q?cg/kfG5G6OE6aVCYF0RDTDz7WAXh3/Lxog7slDIaKpzdHp2HC+CIxCUrt/nM?=
 =?us-ascii?Q?PvhQUBwTdHNdOLKhK8NOQZq9Dfb/Z0fsxeKZwiKVMDFKkPPFck/2hvupOR2B?=
 =?us-ascii?Q?m11mK2jghU8QU5mgpTrkhskwLTZjbhzTb/l2kXU8aR4LShbhUas5EfHV5aiK?=
 =?us-ascii?Q?rjwChv9GYtKGeWs1rO/YibodwQp2x1BxbMwSnZlglOVHz59pzmyRdQosKM6Z?=
 =?us-ascii?Q?4hpIOKtit0xfrxrZALy7mS8rEK0y6YsxaLyivyXRTfixMpOzw7Ke3qfRblPi?=
 =?us-ascii?Q?9jEsMrH4FQ5TZdYvir5qUD7k9sEiYI3dPxRLKJyH1yTWCxnmRSWf+gJZFvvJ?=
 =?us-ascii?Q?aj1GftT3I5Xy3v2SxNRdutTLqtDx9Zwtgbgm?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:59.2044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edfa672-07ad-41ab-668f-08ddd9884185
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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

The PMD checked flow pointer for NULL value after a call to
flow_hw_create_flow(). The function API does not define flow pointer
value if the function call has failed.

The patch fixes error verification after flow_hw_create_flow()
returned - a calling function must check flow_hw_create_flow() return
value.

Fixes: f74914c9956e ("net/mlx5: fix non-template IPv6 flow RSS hash")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_nta_rss.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_nta_rss.c b/drivers/net/mlx5/mlx5_nta_rss.c
index 8f00510445..b7738f910d 100644
--- a/drivers/net/mlx5/mlx5_nta_rss.c
+++ b/drivers/net/mlx5/mlx5_nta_rss.c
@@ -67,7 +67,7 @@ mlx5_nta_ptype_rss_flow_create(struct mlx5_nta_rss_ctx *ctx,
 				  ctx->pattern, ctx->actions,
 				  MLX5_FLOW_ITEM_PTYPE, MLX5_FLOW_ACTION_RSS,
 				  ctx->external, &flow, ctx->error);
-	if (flow) {
+	if (ret == 0) {
 		SLIST_INSERT_HEAD(ctx->head, flow, nt2hws->next);
 		if (dbg_log) {
 			DRV_LOG(NOTICE,
@@ -276,6 +276,7 @@ mlx5_hw_rss_ptype_create_miss_flow(struct rte_eth_dev *dev,
 				   uint32_t ptype_group, bool external,
 				   struct rte_flow_error *error)
 {
+	int ret;
 	struct rte_flow_hw *flow = NULL;
 	const struct rte_flow_attr miss_attr = {
 		.ingress = 1,
@@ -300,10 +301,10 @@ mlx5_hw_rss_ptype_create_miss_flow(struct rte_eth_dev *dev,
 		[MLX5_RSS_PTYPE_ACTION_INDEX + 1] = { .type = RTE_FLOW_ACTION_TYPE_END }
 	};
 
-	flow_hw_create_flow(dev, MLX5_FLOW_TYPE_GEN, &miss_attr,
-			    miss_pattern, miss_actions, 0, MLX5_FLOW_ACTION_RSS,
-			    external, &flow, error);
-	return flow;
+	ret = flow_hw_create_flow(dev, MLX5_FLOW_TYPE_GEN, &miss_attr,
+				  miss_pattern, miss_actions, 0,
+				  MLX5_FLOW_ACTION_RSS, external, &flow, error);
+	return ret == 0 ? flow : NULL;
 }
 
 static struct rte_flow_hw *
@@ -316,7 +317,7 @@ mlx5_hw_rss_ptype_create_base_flow(struct rte_eth_dev *dev,
 				   enum mlx5_flow_type flow_type,
 				   struct rte_flow_error *error)
 {
-	int i = 0;
+	int ret, i = 0;
 	struct rte_flow_hw *flow = NULL;
 	struct rte_flow_action actions[MLX5_HW_MAX_ACTS];
 	enum mlx5_indirect_type indirect_type;
@@ -345,9 +346,9 @@ mlx5_hw_rss_ptype_create_base_flow(struct rte_eth_dev *dev,
 	} while (actions[i++].type != RTE_FLOW_ACTION_TYPE_END);
 	action_flags &= ~MLX5_FLOW_ACTION_RSS;
 	action_flags |= MLX5_FLOW_ACTION_JUMP;
-	flow_hw_create_flow(dev, flow_type, attr, pattern, actions,
-			    item_flags, action_flags, external, &flow, error);
-	return flow;
+	ret = flow_hw_create_flow(dev, flow_type, attr, pattern, actions,
+				  item_flags, action_flags, external, &flow, error);
+	return ret == 0 ? flow : NULL;
 }
 
 const struct rte_flow_action_rss *
@@ -425,6 +426,7 @@ flow_nta_create_single(struct rte_eth_dev *dev,
 		       enum mlx5_flow_type flow_type,
 		       struct rte_flow_error *error)
 {
+	int ret;
 	struct rte_flow_hw *flow = NULL;
 	struct rte_flow_action copy[MLX5_HW_MAX_ACTS];
 	const struct rte_flow_action *_actions;
@@ -456,10 +458,9 @@ flow_nta_create_single(struct rte_eth_dev *dev,
 		_actions = actions;
 	}
 end:
-	flow_hw_create_flow(dev, flow_type, attr, items,
-			    _actions, item_flags, action_flags,
-			    external, &flow, error);
-	return flow;
+	ret = flow_hw_create_flow(dev, flow_type, attr, items, _actions,
+				  item_flags, action_flags, external, &flow, error);
+	return ret == 0 ? flow : NULL;
 }
 
 /*
-- 
2.48.1

