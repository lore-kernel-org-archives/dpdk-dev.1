Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE72C369D1
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 11:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDABA40263;
	Sun, 27 Apr 2025 13:19:46 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by mails.dpdk.org (Postfix) with ESMTP id EDBFE4021F
 for <dev@dpdk.org>; Sun, 27 Apr 2025 13:19:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZBer7LEDef68fcWiZi2do1IExC90hEKy8OoAuvOYwZSmJG7qjVU7pZpNRfSaoL0OaG6VDkIdqw4XrPt10oO6wLvQSxvyF5PMI7z8Fh0CAyJjwrvH0jBAIy+kz4HPhw0z5FW2+SpNU3PbMDdYF3BvT6NpG6XLtweHG+rw9Sx7yBfcReTSAaRw3NLxsSdjl6YAdH7symBq+GBSVcSaDBhvCkenEa7wzYJcla2b9VqjadsQYUnDiOQkyY9Ug0rLRZ2gsJYTWGRSNVJMjvhwlmvibk08X4tcJO00gRRX8eoU5BrnFvsJFM7dKL/TaWnlqL3xgbM2ADJ+9pvsal6wzaqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI/ccmrUHLlYpQdMHjvxQq6uuqzFg2Jy5myOY14zY3k=;
 b=iJs2Uj288IPYykv4NmZwwXB4rwO93zs8OA0IaEJ8Kd1Pvj6KyizLHszai2oOmZED8ZDMfq8hpx/v15dfuwbyAhhzuaC/3Dq5lr2wYzvISV1bMB6NozWmY7P9Df4B9KA/v1F+JhyyeHtTM7SWmVJcUn1Jl1qGwdWnER2bg01PyomPlVfIbjA2Rw47mmESF+bwtNkbOrsT41NWJfmc4An249ug7tWVhi1aojjaYnFSy78ubCbq/J9u0mZqEUy4xFTaa44QCnc6950e/LJrHFJVWb8nk3N2WxYtQvmHIyXNb+5aqu6RJlHT7+SuEr3soAQQsrjWIdJgP45ZcbT+OvDx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI/ccmrUHLlYpQdMHjvxQq6uuqzFg2Jy5myOY14zY3k=;
 b=XGTtL0/tUMJ9gbsLpeSNGadVSGu/E91Tr3jGZPj1pbYBTF0fIMZce51DIamirDoN7waFRMfmPvv00QeYWD5pztmmh92J3bChVAp2zd59zrN7bkj5M95jn6kdKLoHpOtdGAbgENSwHtAo7CPjaJCbK6l+TwXuhOSN63oykV0Ocyq/K0V+YMpdGlLejOCF6UtPKC2xqh/eUeBu0RnTQ7PcNxSmFrEBb7KTczjWyCToQGD1Ci0d3jWz6O2ACObMiMuszZ8q7rIuckc3EB4Cyws866aEtDgUfBunRBzNpzs2VGsOZgByojzamdUh+fUUzrcJHDIGSW1bfRlx/8bh1W72Xw==
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 11:19:41 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::bb) by CH0PR13CA0017.outlook.office365.com
 (2603:10b6:610:b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.16 via Frontend Transport; Sun,
 27 Apr 2025 11:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 11:19:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Apr
 2025 04:19:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 04:19:34 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 27 Apr 2025 04:19:31 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 1/2] common/mlx5: read SWS capability bits
Date: Sun, 27 Apr 2025 14:19:14 +0300
Message-ID: <20250427111916.108276-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 907bd8c5-e564-4b31-faa3-08dd857d67d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uh4L/YtSLiIAFTdtFkqR4a7ctP23aZxE3BYFBdgqOpmDlM5wUcPZEiSWqKLQ?=
 =?us-ascii?Q?exZC2FA/C/aSKwMzkr9yL489bByvnYvyRN3aCK7dBNtwK5soazx+F3geG93F?=
 =?us-ascii?Q?zJk/MEe5TmMesu4XOgTqw3MlbvhqSPXelGUu7ckkfuqBGMMijJB+bQbZi5eF?=
 =?us-ascii?Q?oINfOorGXeSZA1rhESLbnkGHl5at9lZBmS0Q36nmVOxjIMJEt2IuWP4i9GY/?=
 =?us-ascii?Q?+0fkIk3aO344jvT1p/WGIYUq9iCImQdgSHIpZjXYpstojZNLxqjQWjJtJv77?=
 =?us-ascii?Q?EOjiTrTSxSTSPqwIDjyjwWKeYy2aegC8q0SX45B+fIASaNR5g5R4GtYPwomP?=
 =?us-ascii?Q?p8FlgygoLwzYnXoDYMDWB068RCmM/dflA7uryQ2lgqp9Pa3rGZV3nubq3VtW?=
 =?us-ascii?Q?oFsLbSMVYWh2s/NH5apGl5xbzX51fmoiUXrHsBRUbKPMHZgAOllBeHLtCA9p?=
 =?us-ascii?Q?i9mBa09NgmhJ16SmgZRE7aC7t3uNzWB1UF3kgR+xOHYVFi5hYBYG4CGwtV4V?=
 =?us-ascii?Q?TnoS4JnhDtwY7Je5tJNfpP0hIqZMtbmwMluYE3nnAer5NJ6jHMciduLLvgty?=
 =?us-ascii?Q?s/TsZTaAPOJ8c4WgXx9mR1N3lbaeoOsVS+JQTLzEVAZ92DNSPTF8W07Knu/g?=
 =?us-ascii?Q?KDw9n523MnZ5niAjC4S3MyQg2Fy6BwbvBS6/a8y8xU7wWPxBvRqTFxyzTcwY?=
 =?us-ascii?Q?HgfekCTCJSPXhg+NZi97ojFXxLBfyTj1xhi48005pVR2d4Tzgmm4+/liGyug?=
 =?us-ascii?Q?sOJ+vJUdM5/oKRJdBBNlVqfUbnfmYd6qytqLPNSWlJ6cJc7/JJ8+9WQYfk9E?=
 =?us-ascii?Q?Y8F3JY6ztHzyiR7BU6XK93mhIpsbhmbLB9YFpZOexjsEbFDWqI3O0veP9Ako?=
 =?us-ascii?Q?8I3xkiucahwdpZKsKHK/pDMGrvhqq/ugvuBdsjTVyVOwmCLJOJ1i868VzLJ/?=
 =?us-ascii?Q?gevX2xzOWy2OktH3I027hPWw6VL/iT8FTcBTn5GrB54pnfY/iOu9Apy45Hjs?=
 =?us-ascii?Q?vXmUqhVmCIffIqmQWHUkecXo4IKojZyIn/kqtGKGAzHheegh1EY6pEKGoijo?=
 =?us-ascii?Q?ljR3Ed8U4ueSKbNu1orAgoRqmV50Dtyhqrit7/U436W/g2rldCW/PRfWekMV?=
 =?us-ascii?Q?tMCvZKLkerkGSSNBb+guH4QX20smtit5IzS89Vm0/qcO3Hy6dNrnCpVo8WUO?=
 =?us-ascii?Q?4Mg0K7KV65OLfTPKR4EExeoK82g0z3zWUdqTARRM5DITsoHNZzA23NOy3IVp?=
 =?us-ascii?Q?3EKyJ8SxqbQ02DjJuObZOFRMsn2M1B6oooVw70dX6pV0x/BANHs7rELkJTTI?=
 =?us-ascii?Q?zNY/Tx47gdzSVeAzwbOv6FFZtvPJ7sdftB5rFXT0ZuOc0bl+0L4fTqd9iDuj?=
 =?us-ascii?Q?RgJEDA8cFsb7gGx8LqFw9fZSyFvd5f8uCqayH1iE+fWKa8pf8HxqZdANTP9o?=
 =?us-ascii?Q?fl5UWb42GAg5ysLR5BYcSdvsHDLWLl9DAtjXJWAppqMpDuxgA00gHeJ3toXy?=
 =?us-ascii?Q?XBsUMz7GnOQncftOfLnmhQMTS2l7vmWHl4cU?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 11:19:41.4383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 907bd8c5-e564-4b31-faa3-08dd857d67d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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

SWS will be disabled in future HW generation.
Checking SWS capability bits and returning relevant error.
if user configuration is not supported,
will be added in the follow up commit.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c |  2 ++
 drivers/common/mlx5/mlx5_devx_cmds.h |  2 ++
 drivers/common/mlx5/mlx5_prm.h       | 10 +++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 440820fd4ff..e1302a472aa 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1406,6 +1406,8 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 				      ft_field_support_2_esw_fdb.metadata_reg_c_8_15);
 		attr->set_reg_c &= ((0xff & reg_c_8_15) << 8) | esw_reg;
 	}
+	attr->sw_owner = MLX5_GET(flow_table_prop_layout, hcattr, sw_owner);
+	attr->sw_owner_v2 = MLX5_GET(flow_table_prop_layout, hcattr, sw_owner_v2);
 	return 0;
 error:
 	rc = (rc > 0) ? -rc : rc;
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 6c726a0d465..4a7879742ba 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -330,6 +330,8 @@ struct mlx5_hca_attr {
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
+	uint8_t sw_owner:1;
+	uint8_t sw_owner_v2:1;
 };
 
 /* LAG Context. */
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 742c274a856..86b09b6d0b1 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1591,9 +1591,13 @@ enum {
 #define MLX5_HCA_FLEX_GTPU_DW_0_ENABLED (1UL << 18)
 #define MLX5_HCA_FLEX_GTPU_TEID_ENABLED (1UL << 19)
 
-/* The device steering logic format. */
-#define MLX5_STEERING_LOGIC_FORMAT_CONNECTX_5 0x0
-#define MLX5_STEERING_LOGIC_FORMAT_CONNECTX_6DX 0x1
+/* The device steering logic format version. */
+enum {
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_5 = 0,
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_6DX = 1,
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_7 = 2,
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_8 = 3,
+};
 
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8 access_other_hca_roce[0x1];
-- 
2.21.0

