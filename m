Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73444CE8D76
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 19:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 412D040E09;
	Fri, 14 Nov 2025 20:28:06 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32]) by mails.dpdk.org (Postfix) with ESMTP id 2452440151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 20:28:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfYkcNb28Gwjpd1SUcB4WqSNBeb1Ngzuu+ZMtf4NYNMaGGLt80wV9bLlPrs16YrkBiHklu5hVKVLHtr9M8Z/nGqLr0DQ09wvfXjJsyW9Vf4lHeFmS3mdswzUBE48jy95o9zO9z1PNtZhwslyq56YLOGlA+oskRA37P0dpFDDtb7ZjaSeFwvC+bJNF/Ee4F3FQ2yC1VnR448vHNBj7oCQMEPFiWZ7C0MChWN4o7+CS+H05sZwpa59GeZ7aRrGmLCkUwIR3+uGTsfwgqUESFKjI7Mj/JsIqOIbm6NGd4HMkR7XB3+A2VIz+Y0JHt+TeZFTupAiBMt7O3c0YqLYX8BTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECrMBzSzji1zs1q/gA1gwhC+6nRRkW7MEiWpL8x8ECo=;
 b=Q4X4L8GbrDwjV/F0jV2d7Du87Q7/bQ/QIWGOwXQ+rYZif9fvH0wa9H4oRHoMEYKnSMJJnSc/arVViYPGgVXOIFhppZJiyEC3MxrrXmTEsCk5Rg5EL8hbDgQ83f+OuEaYykQxXIFcMztR+1lTOuDXDjBEyoFNJ093x7pBB2oFP5qt0D+U06s4gqdeu1SR+1r7EWkLBW8hur0GdL1Yf3I0hZU2vCdBasV01ZZPqUS4cLHA/iy8ANhfAlOb4lD4llAvdSp2HaEmGKqiCdraUEaKrK/ctpAhEO6OnUBy6/MC+WU4B4qm0MiG0eDncAN5tF7ywiYd350EjdzDC2xJv1XCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECrMBzSzji1zs1q/gA1gwhC+6nRRkW7MEiWpL8x8ECo=;
 b=Din1nvzX9P03SfeqENgkqUjgCgOMFjqWkRM5NehjPLl79VwmU5UnYu80M8cr9QkGmM6KoPYRH147cRCuFDeprcrXaLzblkpRmMP3BSdnoJteotrERdIEsKqoOwr6aunsoWHjtNcTyK41hDvIzu/BKGiws4ZrhkDktw8mH85Jokhe/J978e0Mn0efP0/cGTAKPJLW7HAT6KjNjtzAipcS72yYRlV1L8Zbra9YEHQ4Yyn6A0hJ3R4STwjutcO3+qhK9II+X8TTwfuZ6Cxkmt23Y+UMk03yBciF+CXNNqUEoxOQLNvKCbe2NAoIOi5j0FZh1s7d6gOnJx3iJua4+eb7uA==
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 19:28:00 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::14) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 19:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 19:27:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 11:27:37 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 11:27:35 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: improve error on completing table resize
Date: Fri, 14 Nov 2025 20:27:12 +0100
Message-ID: <20251114192712.1637369-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c93acd-2813-4b9a-e062-08de23b3ebc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EmPhuOyadHldM0ie5Qt7QpHAkxvfea4TclrLZQunNmVP8hvea5yFHVGEalvC?=
 =?us-ascii?Q?tb/U4chsZTZYj+DUtzGetikR4+zMoHJpuBQDpkJ69Nvgg6Dk1K1BAZGzSOxj?=
 =?us-ascii?Q?KI2aeeAvB8XGhUD1lsKyddw/NLuQYXzvDUXzsf1UskMCStuZ8EGjSbsBkZFr?=
 =?us-ascii?Q?wPjwYtgDDjKgHd8GzSXZBSTw2oOT55O44O0MhYRE8jpGQIPBbNAmYWwCZ3eS?=
 =?us-ascii?Q?Cl4pZ5COLHdLC3TtwsgxM8dT+NjplCf1fD0W4gfF8VziX4NBvqcULTYunOYy?=
 =?us-ascii?Q?ni64+SMu9dv+V73snob+PTv3ftECUA8lPU50G+XFRz4j5LwqLbr6U3VivL0i?=
 =?us-ascii?Q?IAvh7CZxeU7CE/ZAHeBDcxTR0WzYmzNtzrhFLIla3FI7NcM+YmTnX0ir3qpJ?=
 =?us-ascii?Q?iv5kQ1XlxBz4vGppcTLkqw9wViXlUflJhH5qxRNqGNsz1VHdbOgspq97wloA?=
 =?us-ascii?Q?kdufpSijl0/HpwDdJpcxPDHYzK48YHLRmqPCxPmmDB8n8NyZfRimvFkPEuGG?=
 =?us-ascii?Q?tZlybv6mDlKA/cNcEQZkhYESd3Q2a6Z5D3t+UM7RReOdlXKb+GVUiG+YzGUG?=
 =?us-ascii?Q?t5UNlqEpTtc0+QTaDAGG/JSLZGFA4wNpn3LVeH6NdvgOm8tsMaRYj79SgbAz?=
 =?us-ascii?Q?H3UILUYHTjlTmEvi/LXY8yVjqc7+B+bbBiqRhK8bkW1jjZTIGFB8CTZle1mw?=
 =?us-ascii?Q?qKIqXIuXZjkM86BhIfP07kp6B6JrXUQW5qrhtV0Vlp7aO6+Hr8UNFv+sXUQz?=
 =?us-ascii?Q?EgmWauFlluK+QtRmmJOYhPsSmScdPdvzh/anyTD/OwzXHrfEINRLFL/0OTjG?=
 =?us-ascii?Q?P5YOeRoT5ynE1u9gg7n1EPNUqvdrBOt26aUyq1kWpWIQ7JKhyWJT2OzIUvgD?=
 =?us-ascii?Q?HqCWLXvhibDyNGVziKBSBRyHzd2v1RDFcepwpHTzPP0mnzQmhXxqA3o2yBog?=
 =?us-ascii?Q?gZ2F3xEKa7injBeZdIvHpYWEh4TBJp0bMfPaZpumaVV793ajRCoCR8GZmv4H?=
 =?us-ascii?Q?UvnOxN0qRne8kQX8NKg4guH6CHFms1TP4vAP3PA5DIv8iTQDCULIJ6hzd6xx?=
 =?us-ascii?Q?qsFhCFWFM32HJJ07ia4ZQ3USI2BWclBGecS5RBCNLteM4RsOtDBTNr/CHCvz?=
 =?us-ascii?Q?eYHDwM5UqE/oUQh0LX6gKoG5gzjWU8PpoczZ4vZ3c/n88HJUx8an4+lg6q32?=
 =?us-ascii?Q?Dmkr+YXH4uf/kX0fmpm8trW9s7jN+gF3vQk10wL6MSpV1cwGVYaJdoN/q+oJ?=
 =?us-ascii?Q?wkp+2+466/LW8PTsKQlDxOBldEyy3QPEWhbepcqItj1FZFDqXJrKq4EZytrF?=
 =?us-ascii?Q?nnuZE5ckSuMRdobrjP19Qbzcm2eIxPzME676CJUnBZM0NonuxbgkdwHHIJdb?=
 =?us-ascii?Q?2kilXdQH1heYOSXK4wZZmHqmVDhj3X7jTaz+aGMHZBaQcxzWtum+UgE60ARB?=
 =?us-ascii?Q?LgXa0ZLnLNZoYAeo5e+CmfDqGZm9RmFbPHl1Uqda2oE+Se04Y8VhQDiKaaO+?=
 =?us-ascii?Q?2DPHgqX+0Z8NeoZUfbVrFKJokH6R0IpSVJDzFJhcrNvWZeCbUhaSl/Y4qZA/?=
 =?us-ascii?Q?pafrzD7ylkWzQ/yycSw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 19:27:59.3899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c93acd-2813-4b9a-e062-08de23b3ebc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

If flow template table was created with resizable attribute,
then completing table resize could fail for 2 user-related reasons:

- not all flow rules were yet updated to use the resized table,
- resize was not started.

Both of these were reported with the same error message
i.e., "cannot complete table resize".

Since PMD can distinguish these 2 cases, this patch improves the error
reporting to report these 2 errors separately.

Also, this patch removes redundant __rte_unused on device parameter.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 208f50fbfd..8f3c84dec5 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -15384,7 +15384,7 @@ flow_hw_table_resize(struct rte_eth_dev *dev,
 }

 static int
-flow_hw_table_resize_complete(__rte_unused struct rte_eth_dev *dev,
+flow_hw_table_resize_complete(struct rte_eth_dev *dev,
 			      struct rte_flow_template_table *table,
 			      struct rte_flow_error *error)
 {
@@ -15398,12 +15398,16 @@ flow_hw_table_resize_complete(__rte_unused struct rte_eth_dev *dev,
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 					  table, "no resizable attribute");
+	if (matcher_info->matcher == NULL)
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					  table, "table resize was not started");
 	matcher_refcnt = rte_atomic_load_explicit(&matcher_info->refcnt,
 						  rte_memory_order_relaxed);
-	if (!matcher_info->matcher || matcher_refcnt)
+	if (matcher_refcnt > 0)
 		return rte_flow_error_set(error, EBUSY,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-					  table, "cannot complete table resize");
+					  table, "all rules not yet updated");
 	if (matcher_info->jump)
 		mlx5dr_action_destroy(matcher_info->jump);
 	ret = mlx5dr_matcher_destroy(matcher_info->matcher);
--
2.39.5

