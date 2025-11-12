Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F881CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 13:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97D774065C;
	Wed, 12 Nov 2025 14:43:16 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by mails.dpdk.org (Postfix) with ESMTP id DC48C402D1;
 Wed, 12 Nov 2025 14:43:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgxKJDQv/khqkmYbp+D4pjbI/pWJKCQiP8y3VWhKHk3V0POBFUxcO04U7ST4SIQx4VKvmHMllHKyNPj65tvDh0jW+voFYGnpf4G3Jl7wo41p2sEq5i7FnjE1814qtiNqZwwC/CpNXqcbojJcDpX3/h38B0pIeenoILRNDOOP5Ot/YFHyvyUcg2/s6EYCObI0ArcI86PwpQDz+iTbGFsQHeER0I0q7x6jYEqeCCXBiQmeEhIYlHyYHJI6hRsT1lJTBRhMljzXggg4gDeZRh9/URt3rW2Zgw3gCEtxNLFwsTqFTw1H91OL7dTeH7EB6SgHI5JKp8BbHfdh1FldoCYqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZhJPnP990NkmmU+MkeVyGHQBd+29vNxnk2QmySrvug=;
 b=GJmdb6C+OOyyEhTKDFDyDkWqcwJh0lKvRnmupqTy3x0mSZeKzvq67vCZNCbjLV2PddJHrX5ITFz4PCVy4FDBmE+mvgSwvKbZW4jt6vCFfGFvw3Q5c27XpmF9+Bsib95EikCeXXwC4ymuN/1xGOOunqVJ5XWVQeiFCDtJphs9PEoEkzTTDD/flHeoEhQnNcyGwPap4MfL2/ccUQmehXc5VUBvjn6sNtmxB6AzEErojP3ZW1IQK/4Mp+2HII7Ys4gCjEtOd27WPev4sX5CDR+lP9xmu3rTIneyHfMZHNqlaTcHevXDGUbRAPxI1F3VcG6PAUaOtmJWC38pZgaQ+aSjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZhJPnP990NkmmU+MkeVyGHQBd+29vNxnk2QmySrvug=;
 b=fecfZuXxY1uinMCOIaQct9U6pc6PyOJYRnO9Dn5WPsvcMMesR7IvP3fnE44ZxtBwTzzudr62lc3l8YJE7XksHOY68eipWC1B7nMHubAqORkXPOV8g3M5bH0eGnlddOe/13hQymcHzFGdl5zSpNUuemIwgT9jX640Txg3ozlLdAAqd6gAQ3RK2jUdMFHIbZrm5sZt5UndR6CIjhKvQhA3cQagFFcb+eU4sv86iMCixsHqKOc5qNWSP9IslAXRFjw/RYr8fM5TOYC0YQe+eWpzLvcWMmRDGl/S6/eyJxn3miU+bqMftqTxRWaquVc8PHVgPUIp+tNKjnQ1+rmlLUQDxg==
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 13:43:09 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d8) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Wed,
 12 Nov 2025 13:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 13:43:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:42:56 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:42:52 -0800
From: Gavin Li <gavinl@nvidia.com>
To: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
CC: <jiaweiw@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>
Subject: [PATCH V3] net/mlx5: fix IPv6 DSCP offset in HWS sync API
Date: Wed, 12 Nov 2025 15:42:36 +0200
Message-ID: <20251112134236.195614-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112130139.194450-1-gavinl@nvidia.com>
References: <20251112130139.194450-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: d2006441-ea44-4538-efe5-08de21f16a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ub34jHl9bS5qo3He1qoTwM3PKH69Te4MjJ7QXliQOefGpmMxcEbvZL85WqMZ?=
 =?us-ascii?Q?E1DIFwYyFTSJzDLSr9MmszRM6GSTMBnzCzQWPH+9ZeHaCh0ZuIILxv+47H60?=
 =?us-ascii?Q?FyWPsD59CW2WJ+1yc3szuFTbxz7malPqtOIrEcrAP71x3Am4xcEw/7VKl9c2?=
 =?us-ascii?Q?hM0QDRJgMFr3sSRCBZwX+b0wYknSjNWaGaIT6jdSKALI+wQw04T7UzN5sPAS?=
 =?us-ascii?Q?7+LftO8GJltCui/Ue+eGZZ9Ab8TCxgKowT76JtQP+H9if0eUMlhU1JwRjNsG?=
 =?us-ascii?Q?VTyPZZQ+6vhiuLiXRFglVgwoCJA8sM9HpUaTO0zOgWPHNPJAGUoXI0t4WYxk?=
 =?us-ascii?Q?JKe+Z1srrIWLXqFpCHYWufBXy8UwzxMmZOnB3mPyPwE1LAD5v52j/jhGhZpL?=
 =?us-ascii?Q?qdTWnbKz4+04XSvYCTD5h0089zLP2LXch41/jSMTUV4bTN+Bp7WLK1EjlffZ?=
 =?us-ascii?Q?RpTDuirhClmp/9HguJERL5OpBuRvE3uWzvzvwGkMZ7P/jFbPE4ma0Umwg3zb?=
 =?us-ascii?Q?1j7HqbMoBNLYaHnOPErI5Bc2YKIgLKj0hf6DhMW0HcN0PYVLR/ajvGXxp20g?=
 =?us-ascii?Q?lL+gQ96Ip4ELss1v7yYz0y1BqDVhzj7wUyJJHvrQ/7rnQ2eNQxyQ3+wpRcQU?=
 =?us-ascii?Q?MRvmpO+/WHE/uVTJpIrC9RchtWvIqiiBeXdJBQuFsHS+8N4NL36m80SVGtcP?=
 =?us-ascii?Q?qPxt0DFOU8Jk/eGu2SQXxW3gfZRaYmu5pkWu7JCkJZj9s7SGvOcUJY6gcb8/?=
 =?us-ascii?Q?1x5L3BD8wb2xaFHMLuHS025k1JXQFrmT7H+tNj5bMTxkxnGgp2sv1hT2FMqF?=
 =?us-ascii?Q?oIAruobslHuYyFtqsUekobu82jd+zsBysOaYeliA6EFD6GV2Giu9LiJMr1MN?=
 =?us-ascii?Q?BoID4sgx/9wWK1QcgTAJQoEPbQc8djKxe34rxt7F+07dAaYSccZ3H63eyj1s?=
 =?us-ascii?Q?mX6qV1/YXBCI9smtc4QvTH9OLMEMwFMKsVgcBjWcSBuN8DoVzg50m6eI7jsq?=
 =?us-ascii?Q?fb6NYBWT8RJe7ezT0uehcXKNNAxGnhtHGx+UFVSQxrMybwJMq/ys8eknZ6Au?=
 =?us-ascii?Q?McmmIsyuU9g4ekkieGSbL3qkwj9lpZ56l+u4HRDqWyQ/6wMd7W8FTf65HwYS?=
 =?us-ascii?Q?faMbnSjz/D2VOkJxrts5UCQ6tkna04S74AkkF1nvjlmmvinzx1RMWn1FsGE9?=
 =?us-ascii?Q?E1QfBZH4SGdvBQt9vRdpzNXKuxpSxoQcnRZ9VT5K7/n6hec4+ZkhPw/r7A8d?=
 =?us-ascii?Q?iSI2EXnJ/PDvovj1e6dIdaZvacfBJ4Lac/17qdoW0PdRfjNLA0ltcTSfA7om?=
 =?us-ascii?Q?buah0RMWY522nziUdyy6BVS9qZCoww+HJ2qjnDChgyk29fuIOfVpU1+GMbQi?=
 =?us-ascii?Q?nerWjC4q6d6A4yc/3wlZpuGvmvufk8lHwFO5C1nFzi0aAduE0iYiqfaNdHo0?=
 =?us-ascii?Q?EwrsfUxxWm1Bd8/92q5ohTckVtooTzUK49/Rrk17VBvGOgH2YREZiNF/OiV+?=
 =?us-ascii?Q?hQlMony1Axy4huFSinMcgXk2/NBfKVR0EyAkRqX9OV8m7RbOjFGoTvDksRqn?=
 =?us-ascii?Q?CURircF4RVIfVQqTBLA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 13:43:08.8896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2006441-ea44-4538-efe5-08de21f16a66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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

The processing of field IPv6 DSCP via the synchronous flow API is
different between software and hardware steering engines(HWS). The bit
shift handling for IPv6 DSCP was not handled in HWS, resulting in
incorrect data in the field.

To resolve this, bit shift handling should be added to HWS.

Fixes: ec1e7a5ceb69 ("net/mlx5: update IPv6 traffic class modification")
Cc: stable@dpdk.org
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    | 7 +++++++
 drivers/net/mlx5/mlx5_flow_dv.c | 6 ------
 drivers/net/mlx5/mlx5_flow_hw.c | 5 +++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e8b298dd1d..2bf74b47b9 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3711,6 +3711,13 @@ flow_hw_get_ipv6_route_ext_mod_id_from_ctx(void *dr_ctx, uint8_t idx)
 #endif
 	return 0;
 }
+
+static inline bool
+mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
+{
+	return priv->sh->phdev->config.ipv6_tc_fallback == MLX5_IPV6_TC_OK;
+}
+
 void
 mlx5_indirect_list_handles_release(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 95ca57e8c4..83046418c4 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -1638,12 +1638,6 @@ mlx5_modify_flex_item(const struct rte_eth_dev *dev,
 	}
 }
 
-static inline bool
-mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
-{
-	return priv->sh->phdev->config.ipv6_tc_fallback == MLX5_IPV6_TC_OK;
-}
-
 void
 mlx5_flow_field_id_to_modify_info
 		(const struct rte_flow_field_data *data,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 208f50fbfd..d3d2272338 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1629,6 +1629,11 @@ flow_hw_modify_field_compile(struct rte_eth_dev *dev,
 			value = *(const uint8_t *)item.spec << 24;
 			value = rte_cpu_to_be_32(value);
 			item.spec = &value;
+		} else if (conf->dst.field == RTE_FLOW_FIELD_IPV6_DSCP &&
+			   !(mask[0] & MLX5_IPV6_HDR_ECN_MASK) &&
+			   mlx5_dv_modify_ipv6_traffic_class_supported(dev->data->dev_private)) {
+			value = *(const unaligned_uint32_t *)item.spec << MLX5_IPV6_HDR_DSCP_SHIFT;
+			item.spec = &value;
 		}
 	} else {
 		type = conf->operation == RTE_FLOW_MODIFY_SET ?
-- 
2.34.1

