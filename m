Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635EAC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 07:17:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 208C740668;
	Wed, 30 Jul 2025 09:17:38 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by mails.dpdk.org (Postfix) with ESMTP id A8FB04025E;
 Wed, 30 Jul 2025 09:17:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/3D/D33KmiBIg36SNHCmbW8aaFcZa8xnarfpKWPP9bOpA8QO4o0/GlCNiffuwNL5TgXgTNOatA+UE0N3p7kOGunLeUpqzplxtW54O8fD6d3ManYPPt/YfFJ5WJOi1ZpTxVvcybpeer8ISsnGct5QPbPArq+1IUV9+urK/X/K5iY7He8J3BFxXyZckSJwjVkfaN/974VDPC0TV4jIBiPUSMRK1daaCgI+Plq6eZPoBLZXHTn+51o2qY9RNJGf8yadpIGWgv51LLdjT3A+JQd/0M2mrhLdyHe+CppJ9OLFxqoaycfeJSLgjhFtq0cmy6i0ZfCu4EEgyONENnpQB+IYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YD40xsi6VFTIi/63R4rjR/m218eTcUwI2etv+UxdG8=;
 b=dvlrZe6N0A+3WvjFe/qsOr40pH6tMqun+wjoynknJx/BgjeqO/OLh9Z7QMNz5n9E4MGJ/27tr+2yixbuWgn7Bgjt5jtUIo12X4N95mdQ4IC61b3EB2fqqMWXHT2/2lpRkxvPtq5hvdErEdI5bOkv9X9TSm78R0oIqIHBZqB5SGXQ2kArJb8+JlKTOOsQ7Hn0uwADPkiW44KSfIw67anWt7C+hLc09poXzQcXhuf10JU10IG2rAb9n7cmvobCPUjQE0XDCZqi03BEF1Xn3j5PjcP+yAa2OMkuHnv+Zz5zFUqCBYvW/SJKGPqQeJM7eRyQPGUnHZ/eXUeDlCllAiIkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YD40xsi6VFTIi/63R4rjR/m218eTcUwI2etv+UxdG8=;
 b=WT+PADf9jlhcU6yE7/izTtuHtHP2KCSCd/fG1+6Pi+ghIz3TXWaaipjtQQZ+VqbaHNcg3zC8GB/z41hRZbqW8Owm4XGtmEjeQLE4NniIpq9ypoXWSF2tLZImchUrK05mz4KL1CuvAtNc2caHDSy3/3k+Xk5F2xtXsVnOVZmTWIkICHchVOkuWlCXHEujHvtsU/mrdzN58Sk3uLwjOAARkrsr6cr+yWenp5G4p6h7+3x1NZJXzCi4T1UCcG6A4LIBg1KpLvnuu3xelkrlMvUxoMwSTqjdo12tdyznUoudUS9CH6B44oN8Gf3PDCK4bnHQ27S+Rrc9rGipUwi9GnN6zw==
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 07:17:31 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::bf) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 07:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 07:17:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 00:17:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 00:17:06 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 30 Jul 2025 00:17:03 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [PATCH] net/mlx5: fix stack-buffer-overflow in indexed based rules
Date: Wed, 30 Jul 2025 10:16:59 +0300
Message-ID: <20250730071700.187675-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a5f213-2e6e-499d-9143-08ddcf39258d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mZLe7xvvmF9vLkWRXx/1jQ9YfGP8Fn7XkI8Ba8oif+VAlbSvwZuvDp0mIj7L?=
 =?us-ascii?Q?cASC2bMbG7ud/xgJvwJcn+WbuF0Cd6YLYvAiAwn6t6C1AEOq539sVttjrsML?=
 =?us-ascii?Q?E9uI1Z9Mfj2sWKHw/20bSuvK+P74857TXIqoSUJsXCBiqnrXdiReSS5ZjLx3?=
 =?us-ascii?Q?ndHES5RmIlKv2ahHUzR8C1CnnRXMzj/5TfBnFRZLlceS+lCR8zUT+rbwyLJ0?=
 =?us-ascii?Q?+nj8j+U6EHAK0HOyJGzRnjf1vjX3M12txMUSFPI0Uot8RgAxpBLMI/HuzG2A?=
 =?us-ascii?Q?2eQyX407V6f492IK3m+aeabP2MuorfdlpQdqQqJfsGvlyrLjnwuIUzTwFLZu?=
 =?us-ascii?Q?3HRu33QFVqOcQBVegTCmbW5v5NSrQbF2wPY6DO3iAggsBygzh2UuKn9IIYG8?=
 =?us-ascii?Q?yPBaIzU70T2pkBMxO/i4epMklg98AbI5RMPIKuYr1WRKCvEFeURk+3GKljh2?=
 =?us-ascii?Q?42BTvhqJcGcg4copN50pdyYMSg2w2Qj80hd6P/H4do/vzagC3viD+IX4cbEo?=
 =?us-ascii?Q?eDGZp+e+qA7s9Bg1qpqYf5M6duLzqF9Bc9bqJ14tTkov0DtzlD6lm4/ygBUi?=
 =?us-ascii?Q?hIw6eLNS0B0pPbwYM2kJKW7r4CLi8Xp7aQS/pH3ykm8iu5dCqFMFZ7rlMMrS?=
 =?us-ascii?Q?S+ZlAyiiIjLoE0UCfrR5qgvw4MKtEzUeEmlz4EbrIlzLLur1DKMKBJKB4mCZ?=
 =?us-ascii?Q?ZfEVnQfDzajyqrZ9btL1/M3YCKafG2eTY2DJRoUS0yP+DoMSbGa65YSHIsRh?=
 =?us-ascii?Q?XspFj6WID46zv/PZ0/wM2vBr9+mstPcvd1GfMHRvrh8b+oF3uUzeCYyJ5ZCC?=
 =?us-ascii?Q?Z521GKwmKtxdGh8ORXDloyMba1IGNsFYOhFOiNFm9ks1SnexFYCR1mMxB64a?=
 =?us-ascii?Q?+xFSjNCnSl2DDs+mHs2nFQdGUPrsGoqa6+SetXLh0StTwbS5EsunWLnjFWiX?=
 =?us-ascii?Q?gGRHUen8nIQpEm/QsNKGzCDLybFy8GIbe5WLpvUKreDuQpHX/fi1QCkmXpB/?=
 =?us-ascii?Q?8aRcf/hzJsI50R8t4o+QkJ/HVB5YMjxDMsqson+pUahfSR4EnvS7cnj2enev?=
 =?us-ascii?Q?Di4SgXYp0Vbt+pbysTQ2MJfxt6NGCIo6BM4s7cevCges3wldy3F/f6qC9Ov4?=
 =?us-ascii?Q?nbsgg+HBW7PSvQqk8Jal1Xfy9EWeuxZ5L2M8ZZhMJ2iIq3pF9wKN8QPIGn5+?=
 =?us-ascii?Q?d+0CtEzxfUJbQV/h3EDyCjNybwoOriNe67wxugN/j6+b6X4xS9oPcUPXF7rA?=
 =?us-ascii?Q?tcNVS+hSBVsC/uTMdKYwUBcWkU4sQWmoGZPu6fJZ9VSMENf32oofwqNtcuAK?=
 =?us-ascii?Q?q8hbUYUt9EyYJjtxw9/6EYt0DOpNEZOv9KRWLj1VWg7h27xX32Dxj6LRd0Zp?=
 =?us-ascii?Q?YCzeBDSnKMpqRARskWXeDEbaUD87lCdlEsIHAbCfkWFO6OG4NN8SFOgxSFQs?=
 =?us-ascii?Q?f2wa1QVfUoB3Z5IjhBjAZAUAskeTH5Gjz3KENoFV9IPQP4VOhTbtkyz/QvLv?=
 =?us-ascii?Q?qZZ697ea8nR2xjpO8gIceeA6yi/QvvH2B9uJ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 07:17:30.4377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a5f213-2e6e-499d-9143-08ddcf39258d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

During asynchronous flow creation by index,
the items array was initialized with only one element,
but the table metadata did not update the item count accordingly.
This mismatch led to an out-of-bounds memcpy operation,
as the code attempted to copy more elements than were actually allocated.

To resolve this, since item matching is disregarded when inserting a
rule by index (the rule is triggered when a packet reaches the
specified index),
the fix is to skip preparing the items array in this case.
Instead, the items array should only contain a single element,
RTE_FLOW_ITEM_TYPE_END, which indicates no match pattern is needed.
This prevents unsafe memory operations and aligns the array size
with its intended usage.

Fixes: 36c379c82e82 ("net/mlx5: add flow rule insertion by index with pattern")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d32..016370f68bf 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3982,10 +3982,14 @@ flow_hw_async_flow_create_generic(struct rte_eth_dev *dev,
 				      flow->table, actions,
 				      rule_acts, queue, &sub_error))
 		goto error;
-	rule_items = flow_hw_get_rule_items(dev, table, items,
-					    pattern_template_index, &priv->hw_q[queue].pp);
-	if (!rule_items)
-		goto error;
+	if (insertion_type == RTE_FLOW_TABLE_INSERTION_TYPE_INDEX) {
+		rule_items = items;
+	} else {
+		rule_items = flow_hw_get_rule_items(dev, table, items,
+						    pattern_template_index, &priv->hw_q[queue].pp);
+		if (!rule_items)
+			goto error;
+	}
 	if (likely(!rte_flow_template_table_resizable(dev->data->port_id, &table->cfg.attr))) {
 		ret = mlx5dr_rule_create(table->matcher_info[0].matcher,
 					 pattern_template_index, rule_items,
-- 
2.21.0

