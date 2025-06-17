Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC832C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 034D140EE6;
	Tue, 17 Jun 2025 15:40:17 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by mails.dpdk.org (Postfix) with ESMTP id D049740EE1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:40:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvkrjk0qY/Qe5hEk8QTdb89NzjK0FmvxLc2PrIymbfUij9ZIyVbhpdvmrZqPE5w2EZ5iLfQl3YDkhkqNa5qgTtFjlVhkAEUEjs7NXgLlv5CqclZRel44mly+cdn5S2/1Bv4gcz8dh38BYszm1UILKE0KxGz4OFx6bnSxArHX9ds4/yMn7mQLWm7UfB+8iuCLrJ0ELhogfkzdRmfRJMNGP+WuyCGndumhupAw8ab2TARxh641zfibm192TjJXsNnXiD2JpHVgPj1XIgnVn6JGdY9x15Mv+3NKNBVnxcWXFqzkrDVJiff1dC4LYQJsVF5B19y08/Sqgp7LQweekQhatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5jULNycoEqu7v7s5qISDitnkZE47jIDhRaLZMaVwoo=;
 b=y1CTyC7+wctEek+YUpUEwmrSxkP7Bqh5vWlgcv/T23DScs9AX1tIbg7BilgJfEPhQqFSnZccCmORbPMI1RgOomWdVgxCjGfcd1xwJsHsrRLO4HLoyqGX6Mid1GdtPzCrDfLQgLeZDMgxtYjHtwJJMaZiFX2lcpEvBYNcXRoQ2um3iU1943t7BitG8SpMPKhC0tlKj6KojzDQUV79HPZEtvRtrLp1nuoLPocKOgga5GdcwnOF6KthvTyhBzuRWeS4Y6OJv2dxJfU5sJCJZ8kU8++VvOOeaNUG5tRkSYFgX8U0Mnah59DvcdTlQkmsBrkti5vyZnQFv4ggSOyCpyhjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5jULNycoEqu7v7s5qISDitnkZE47jIDhRaLZMaVwoo=;
 b=lCcZdAYKltNcWRZtmpLuZr9xNdHCFPvUPCI+u/JNl7jL6SoYF+nR3pFDN814oI8mYvAIz2CMsK2WJtJdPPFTyG8+UNda0xheXu+nnlU71XzRGtnuC/ZP4oZTcor0srGhqWi/BpMA7hmB8wUcH/B9cYpDaE8a8K7EgQsN/xjPBBMZbg5s+/J9IpzPKdRxYwVsJZ0zOhn4jh1ksZ/ZduQSgbhwUFYHnlXyP0rEAfq7OVw+7Vh5aHuuq0Dxkl757tnZ1hl1DZMnFwQ/YTQsL6WraFLB1UcRUeIHWiFd0XQMPluLxC6kOowbxxWdV7cWVFi+LVoAut3nQInnNqdS3sAzDw==
Received: from CH2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:610:4f::11)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 13:40:10 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::fe) by CH2PR18CA0001.outlook.office365.com
 (2603:10b6:610:4f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Tue,
 17 Jun 2025 13:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 13:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 06:39:58 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 06:39:52 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Bing Zhao <bingz@nvidia.com>, <ophirmu@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/5] net/mlx5: fix the table flags of mirror action
Date: Tue, 17 Jun 2025 16:39:29 +0300
Message-ID: <20250617133933.313443-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: c529453a-4e79-4114-d7c5-08ddada47af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9zmFrYJdi3nZIllX0MnPSoyus4YIAR26OFbJxmHXq0+Rti2x1jczcxXOeBAA?=
 =?us-ascii?Q?I9EoCZ+SaxT+cTNjFwOyeUtMQRft45NiyaajaLkoNFHNsUqanl/7zdmQvTqE?=
 =?us-ascii?Q?mDsf0EvF4R7gJttHTrqruzRsB0719V+eErImIMp+OUvb0pe2IS0BmFS4ydyZ?=
 =?us-ascii?Q?Y7dlP0+D5yxDkepet+fjbVfXRlkNaP5SqMR1biyGaZmHbMwu55l0tff7t31F?=
 =?us-ascii?Q?BZfWzurjkP081RPOdovK73xcX1k9OwdZy/XblA9NQTJ33JGKqaLG0aRWlFLt?=
 =?us-ascii?Q?zAnO2jR3IFlKsCVHYOn0QO71W43xyIanaU3qd3Bp6u9VsKU0XusNZcc2oHI9?=
 =?us-ascii?Q?wfa2D1bf/rKqqhyjwQkSSPe0GqRnCkUCHoJ01820Zgq64U579lyKliIFZxjZ?=
 =?us-ascii?Q?F+ApzKtNg3X1Ip2yCSr9Cc9qSjEcW0IJP0sDKSIszK9ny7+4uJEZUKRcGwAB?=
 =?us-ascii?Q?zHzRC+DLxIcY7NJmsFW3+pEowhM6o/P/SnBgQajuha0uF3jWtiqk7n4y3ujQ?=
 =?us-ascii?Q?Ty0RpcN0Jcz7hQZKheQis/6wCgpS+3tm+obqocXD1Y3XGUv3c4NK2DcV41rM?=
 =?us-ascii?Q?9JXBadxp2ZPJq8M7GECVFra+btc5hMNEPB4WmP9Akm6SLwW69dnRHv0FTlmr?=
 =?us-ascii?Q?GtZJBinFqzS27M01iOaUbP4GyBKr8ajjICb6KV8ETF3QmQiFALY0wFFyrbSJ?=
 =?us-ascii?Q?fl3aB6u7t52KCnmwCNEUnDm8Qcl4V5M0oDxf1K+cuAOQkcKTBRsAAOrGP8mu?=
 =?us-ascii?Q?EawWA5qxRoW0F9pC4CUyic91vVl7OU2T47c0ImtqeeBKkd+GpsrQBZlGkhTp?=
 =?us-ascii?Q?TTAeC1o8GTvignN8/N9EH1tWElFW75HCCX1NOOXSjLhL/GcrO6ryJdBjRb/6?=
 =?us-ascii?Q?0lm75aUZgXunbf64kFWX9MNI4izwueqceu4GqtX2gmmxu8dXlidsRrc3QXIM?=
 =?us-ascii?Q?BViu3PMdUg+qMyFoEzNJ/3pY0IEQDVyklQKftTJnM9crpfxtfMA7gS8msQID?=
 =?us-ascii?Q?52uFCkbI3X2IeBMMWwCOG24ft9lhFgTjBto74N5IExNNd/xjpxTYywRM7RJ9?=
 =?us-ascii?Q?cOAN2QYQEi0CKmKD6/g7FOzx7a0j9PyDPoEcu4zXhWty3BYAheE7WIf4eF76?=
 =?us-ascii?Q?+0Pqqa41A3juMGrZZoIstpom0ufuuowwbshj0mS4hTmBqHWgf0WEYnCpKErz?=
 =?us-ascii?Q?kOCBI21Xts7EZu/gDUhycqCabkMVLySNS/olM4NZfeKzZHl2ltc0qkrpCvUk?=
 =?us-ascii?Q?890MGhJXfTbs3tw4sIMMknSLD/JJRqENU4c+VW7c0xrAINWEtZYmO0ehQ3Mm?=
 =?us-ascii?Q?tKyWsP0SlsYYot6+A5NOsxBuVP68U7XzL2KTH0+4HhRtArtvAuzdwBTOYOu5?=
 =?us-ascii?Q?G5Fmj2ggHQ3hmaVia+MGBDjyCnLD21KQhV3dnUJa9VX0e/+tb2tRt57hrF8K?=
 =?us-ascii?Q?qupkXu/wuNKF5Ez5bXbRiFQj7g02KeAkrQSI0CoJIkzYjzcWlqxJqhgrlPm0?=
 =?us-ascii?Q?ShHPYHCio963xpOB8Iy5CUdq5IP208+n00HV?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:40:10.4176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c529453a-4e79-4114-d7c5-08ddada47af6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681
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

From: Bing Zhao <bingz@nvidia.com>

The HWS mirror action is created with STCs based on the flags. In the
past, there was a single type of FDB domain. After introducing the
unified FDB feature, there are 4 types of tables in FDB domain,
including FDB, FDB_RX, FDB_TX and FDB_UNIFIED. More STCs will be
allocated when the new FDB flags are set.

Without specifying the group ID, the default 0 would be used to
determine the table type. Since only the old FDB type was supported
on the root table. The flag was set wrongly and the STCs for other
FDB sub-types were not allocated.

When using this mirror action to create a flow in the unified FDB,
there are some errors:

  1. If there is no other action STC allocated before, the offsets
     of old FDB and unified FDB will be the same. But the value of
     the mirror is zero. The mirror action is not really applied even
     if no error is observed when pulling the result.
  2. If there is some other action STC allocated before, the offset
     0 will reflact that action but not the mirror itself. An error
     will be observed for the rule insertion.

Since the mirror is only supported in HWS non-root tables, setting
the group to some non-zero value will make STCs be allocated and
used properly.

Fixes: 8daf5794077f ("net/mlx5: support FDB unified domain")
Cc: ophirmu@nvidia.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index af2e7a84a5..a8a3f3872a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14803,7 +14803,7 @@ flow_hw_async_action_list_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 	enum mlx5_indirect_list_type list_type;
 	struct rte_flow_action_list_handle *handle;
 	struct mlx5_priv *priv = dev->data->dev_private;
-	const struct mlx5_flow_template_table_cfg table_cfg = {
+	struct mlx5_flow_template_table_cfg table_cfg = {
 		.external = true,
 		.attr = {
 			.flow_attr = {
@@ -14840,6 +14840,11 @@ flow_hw_async_action_list_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 	}
 	switch (list_type) {
 	case MLX5_INDIRECT_ACTION_LIST_TYPE_MIRROR:
+		/*
+		 * Mirror action is only supported in HWS group. Setting group to
+		 * non-zero will ensure that the action resources are allocated correctly.
+		 */
+		table_cfg.attr.flow_attr.group = 1;
 		handle = mlx5_hw_mirror_handle_create(dev, &table_cfg,
 						      actions, error);
 		break;
-- 
2.48.1

