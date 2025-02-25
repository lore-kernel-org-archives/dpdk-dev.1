Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC674C021BB
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:04:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2908B42DF0;
	Tue, 25 Feb 2025 13:03:54 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by mails.dpdk.org (Postfix) with ESMTP id 0B10D42E52
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:03:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uizpAj0O0Z9ku1uRnR1O4tJgm8WTHKvW0dBznRTgHU6hJx+VQaJRmdAJlxJtwx9USZ1B8LGptkXFTmDc6P/G1gYs7Es4VTDh/9KUZsHQFZI+zc8iYZz8yU2aPyysBwFfmGdBBSq7FvuNZObMc4JBQEwgVTI122eFsvE+aFWNpPJBF+XzlJ5wQkzRHLCoDniKkF2g1cFqt1RmMOoAfaIoi0EW9Mp0PB/UkK0gkrX09Llsdb7QlEXMTlQ3QFwZk8DCmoD2EPQOvXAFNS6UqYqRNRgmLdHKDbHqN7n3Z9tpUQf1sedUuIPdGTNHKUNI8wM/Z3ha4hdlnLXwkonygfEB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvYbeiJA2Ul2d2WFH1sPy5oGUnQooAFONfhIZCEFQ8U=;
 b=KknFrs/TIEqX123oMVgdv0mhgd0q9pgIA+aid8tAt5t+O2q76QGhh+90PsLqe3Zf23fVDTV4kT7ta6NFI4o6lPXGnDf+1y/+mK8f5RP6VLP9vj2bP2G+CaANSLOxpeBIpYsBi53AEjPaoy5OFROVU1zZfwm1guui03SLNvtDXP7+4CtaPa0CGPaZoXBfw6Cyn/d2CGhwa7sk6v54LMDWMcssqfLH1AsEaYdLVDAnQ5sh+zGeU0WRh0ytkjD/8v0mEjxwtNTBESTGiIhY2whiSUrtJpGSTp7aTxv5YC923ciwYKq5vXoC5eeJCDDxma1p5nGAOsPI0wxEe0pkzvnGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvYbeiJA2Ul2d2WFH1sPy5oGUnQooAFONfhIZCEFQ8U=;
 b=E5Qm08pRXyubqhKwclWPykn8yHpWYl7zFKihXBcez6qZTx0+TuOtZGnmzvnNe0pDmAzRlDJE1ASVhCU8cos931Ln1tyzJjdcP/632lCstb+IyWqs8G+afrK3MLDx48qSYEBJzRBPpccyBX1i3LjC4Ja+FE/VVdr/5txEqaBtjAPPmbsniDmwO0ZfZyXPoc7ECMbujzyzJj+ilKJtL2/OU3yG5kvyUg9ElDZIs/UPNtdwmbOoAyDWTOwNnYlSDwLKCRct/GhPtlpHOyZAiKKcrYeQXNN9909QpiXO2cUt+JMSVZapQKaz4KtzMBRQKVI8gErd6EAflz4GZKO3euOfZQ==
Received: from BY3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:254::15)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 12:03:49 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::cf) by BY3PR05CA0010.outlook.office365.com
 (2603:10b6:a03:254::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Tue,
 25 Feb 2025 12:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 12:03:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 04:03:33 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 04:03:31 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH V1 4/4] net/mlx5/hws: allow different types in miss validation
Date: Tue, 25 Feb 2025 14:02:13 +0200
Message-ID: <20250225120213.2968616-4-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225120213.2968616-1-ophirmu@nvidia.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: d05c4d68-bda8-4fe9-7143-08dd5594769b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9WyLhf8KhhwvPXDdS2NNXJH0XEQNOl3L0wKROz7sW6pWzjHIj9IW7JhGSHzj?=
 =?us-ascii?Q?Xx3hEnphyKNK37JKuInMVtuFeka22yc3Fbavr2ifvYA2A7LiX4HXMh8h/bWd?=
 =?us-ascii?Q?VO3knZoZXC3AClOGf81HK/J+C4vZQ4z8X0U95vahxseVtgaJnANyLCWVtM4y?=
 =?us-ascii?Q?uCpnKFsETfAAZr+NFpclQxtVV7cg1RCQkY5nU2epfuDOjbzIuZ08+N3WBk7n?=
 =?us-ascii?Q?pTaqg3e4dmr2rtCCJmVwbTirE6WO8In2HzR9m3IPREMZbXtc0oR83eQv3Oe8?=
 =?us-ascii?Q?DJ2Y+wpEwT+5jrqE4d+gWNjEfDSqVif6AQksxy7aVLHIuzq22oWDZcr7ISXT?=
 =?us-ascii?Q?U08ppSpNW713gm9WkL0MgbHzqkdtrGRI/PZ941o7r9DV/dVoYw+zbq2aD/Zx?=
 =?us-ascii?Q?52RH+FLrj1ZbJMXZMxdaVfbYIWLcDkpOJJaAXCvY209UJ3jVEvuJfxoWxpP4?=
 =?us-ascii?Q?BeK3V41JbLD5hdDar859BKj0aqk4ZSUrJU7s5TBqFV7UlvLWJtK6DIBT3cU4?=
 =?us-ascii?Q?bVb9nEkph219SDHbjRhdbONEC8eTHUIGKCXRIYHqOV302gPw6RQh7cdcRrhP?=
 =?us-ascii?Q?cMQ+Qh576Qjl/VwjXmSE8EBMnhQuze2M6NxgjT1CNOM6qAimWsfxpn9GKs7C?=
 =?us-ascii?Q?7pFUPbzCF/rXGhl79rci6WS+BqO3mvt+RuLMCF4kQJsCBgL9VkRWICPIPf3x?=
 =?us-ascii?Q?xH1V5lF7ukturrGWAod4qEHPW6pcHxcxqTxx2l9XHh4dMKqpGfnbJYYDp3iI?=
 =?us-ascii?Q?Blw3CShGekyiNAREojv1IXaqr/m/1iNkwIm1GzaOoZ0DiFYqUcFDzxINFRJQ?=
 =?us-ascii?Q?bVhYBo66cYesGLuEPYBKmh3Wo0dymOectnq0oCQyijxBUKkD6ISMsRwBwL2w?=
 =?us-ascii?Q?OLLB1Tsq3fqWguyAN0Se4SFJlaEPkP/yx7pTWd1JwDuKiXLW+imSSPahqwFV?=
 =?us-ascii?Q?HQmHV+cD34gPLuDnFzZtAl8hp/bh+l7sR5RZOpZvVNW2Ep8ojtqekdLlc7X4?=
 =?us-ascii?Q?ILOM+DX1gWUUyjc4D8vofprM2u+dBQhr++gcWcVIzjBXBbUHR5tgg3vdeEXs?=
 =?us-ascii?Q?vIaQP+PwmvBK+IVVSmOvSkHlK3xqoieHf4S/tqamRqm5Ic1HePERwT9l46PT?=
 =?us-ascii?Q?H9Ug54lNVc03V8xjNh7aSJVvEBNyjzbHkJngf9n664FLAZQuyn0KeSG9faYf?=
 =?us-ascii?Q?VGQ/Xx1ZQ3bdUPZaN5S8y+h1GFJ7pi1lWj+B8yhn9jHLa82P0VOfM7/1WNd3?=
 =?us-ascii?Q?3fGDPx5k6R83aUy8/vt/lFl779piVYRXaqtJJhw4y0bjyIFUboBphi9d67jl?=
 =?us-ascii?Q?tnieHUBtbokXEL1stnJPK0hBctt3s8G0OlFIJM9lPvqrXwr+axnLrgD85J7F?=
 =?us-ascii?Q?cCDzwp9JPh15xJacWKZ9NAXr87wSLK0Pnwf0ogmOOTs0BCNJcYKAze/poYA5?=
 =?us-ascii?Q?RgH/5IANt08A4Tn9q6+wU19ANoS8YFZVX9vGCiYEF8uVzQJc/SB/1PtCuiiO?=
 =?us-ascii?Q?b7SMemxMJrjsOvI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:03:48.8960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05c4d68-bda8-4fe9-7143-08dd5594769b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

In validating Jump from group A to default miss group B DPDK requests
that both groups types will be identical. In practice jumping from
FDB_UNIFIED to FDB_RX or FDB_TX group types (or vice versa) is allowed.
This commit enables this jumping between the different types.

Fixes: b81f95ca770d ("net/mlx5/hws: support default miss table")

Signed-off-by: Ophir Munk <ophirmu@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_table.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_table.c b/drivers/net/mlx5/hws/mlx5dr_table.c
index b371f42..c1c60b4 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.c
+++ b/drivers/net/mlx5/hws/mlx5dr_table.c
@@ -626,6 +626,19 @@ int mlx5dr_table_connect_to_miss_table(struct mlx5dr_table *src_tbl,
 	return 0;
 }
 
+static bool mlx5dr_table_set_default_miss_valid_types(enum mlx5dr_table_type from,
+						      enum mlx5dr_table_type to)
+{
+	if (from == to ||
+	    ((from == MLX5DR_TABLE_TYPE_FDB_UNIFIED &&
+	     (to == MLX5DR_TABLE_TYPE_FDB_RX || to == MLX5DR_TABLE_TYPE_FDB_TX)) ||
+	     (to == MLX5DR_TABLE_TYPE_FDB_UNIFIED &&
+	     (from == MLX5DR_TABLE_TYPE_FDB_RX || from == MLX5DR_TABLE_TYPE_FDB_TX))))
+		return true;
+
+	return false;
+}
+
 static int mlx5dr_table_set_default_miss_not_valid(struct mlx5dr_table *tbl,
 						   struct mlx5dr_table *miss_tbl)
 {
@@ -637,8 +650,9 @@ static int mlx5dr_table_set_default_miss_not_valid(struct mlx5dr_table *tbl,
 	}
 
 	if (mlx5dr_table_is_root(tbl) ||
-	    (miss_tbl && mlx5dr_table_is_root(miss_tbl)) ||
-	    (miss_tbl && miss_tbl->type != tbl->type)) {
+	    (miss_tbl &&
+	     ((mlx5dr_table_is_root(miss_tbl)) ||
+	     !mlx5dr_table_set_default_miss_valid_types(tbl->type, miss_tbl->type)))) {
 		DR_LOG(ERR, "Invalid arguments");
 		rte_errno = EINVAL;
 		return -rte_errno;
-- 
2.8.4

