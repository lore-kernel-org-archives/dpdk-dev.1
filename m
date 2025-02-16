Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EACC021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 373EE40DD8;
	Sun, 16 Feb 2025 12:05:23 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by mails.dpdk.org (Postfix) with ESMTP id BD76D40DDA
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMM+6d+5iqDRoO1KgebKLeblWX3yhJg9yjeNzK7xz68Dz2071tIeFeSvNtiEzxhwim0EgjHC8Kw3tyBiYG1avLOnigoXbsq4ofPdsy/5MOV0goDwrhb/qgapi3hsXIhiM81QnKcevI6egQDBbTgqQxmDbUrAo/uJYxvQHDatPbdMSwOkEBQU/wsqJKkEMMrikQTg0XQwX9cEzvyrPUBSK85fDSk7pbJN1kPy/RXeLWdijfppqd6rRHf0TuF+NKLucUCXjPzZKX4T6yyRrxnaBkM/1f7GxwDAnnRA6RmZ/zOR2X6TCtkUAeWk2rjTcsVJjlzYfMq74StVtmJoItUDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMOdStj+TZpYcHg3EL8EelOj5NRajvUKR4IcyhFdAMA=;
 b=B5gpxsUB0SJMPrE6AdEaUKhMGjl/2yIIMZqZqsntLpTq0Ke5wvHL4JGJvW2ntcim9P5kRIIlzoSMdOX4Rbk0GgWANxZPjZ9hW4TZ5hV1Uvz0Wwpr0erZx4ru/mP+8sEwHfxgcg0SV3c+5AMXa+iHPwFv8/Uz2IF1DE45LR3geD+OWRq4f7hpqIs3f3fOJ0ecVw9N88IdRrGDOCgaGmaUmR0SLWUHgXxxOStKlAoEn+neunMT+13HL4lEeEPdkSvAxWvFoXFKidOA2VgFHT0/RsTkg8Xy1RKRFi0DqOloW4HTHrbj8DI6mWcdorc8ua0cQCEJhUmU7vvdhC1RrQlXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMOdStj+TZpYcHg3EL8EelOj5NRajvUKR4IcyhFdAMA=;
 b=UuFvLq/s0lkrv0FBRk/uclSkD37/42bKM+pO6AG/04TID4t46EjYrQqugXlZChO+I4V6TYjtj/dR3hKqkjz/cI0FjMUZ84vo5WRZfHgG6O2Go8bnSPlHmIcyKuMz7O+m7ZyrcU06dyYn4P8PpjPRVTM8EfNapmqQyKPOaCqjSHgN98E/EDxGGdfyLRBxSg3iGmSXWU6ODyhPd7Y9uSYPxpkf2iHF4NI44IzUnUEZAp9Zd8aWi3j3rAH0HrMbrgJ7vN7rr0In0hxxAjXSOewOW2LHKUVWeUlBJD+AIzA54vrYIs/tuyXfmiFdA4xQMiL5pib5jxXCf21ED6xZmelhEA==
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 11:05:16 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::b4) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.9 via Frontend Transport; Sun,
 16 Feb 2025 11:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:05:03 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:05:00 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 5/8] net/mlx5/hws: matcher changes to support unified domain
Date: Sun, 16 Feb 2025 13:04:11 +0200
Message-ID: <20250216110414.10926-5-hamdani@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250216110414.10926-1-hamdani@nvidia.com>
References: <20250216110414.10926-1-hamdani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 612468e9-13d6-4fa4-68cd-08dd4e79cb58
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?127lXTKGhoBVxcgJ63YuaJY7QGKu2vtDC3/iwifUP7yEYSeIlXmslubdmD1A?=
 =?us-ascii?Q?zhioAmAKXNMUQiTUDQRcl2WRtx1hjjk83wsfK8gTx2x7Cw7ElyL6BsIjZAl8?=
 =?us-ascii?Q?OE5EjKJWklxiMdf6P3hZ0RyvyAdKpAfZzjAqa5HMCWvzEY/y/g2n0Fb6CdrH?=
 =?us-ascii?Q?+PBrAXu2n3iE4QyjM1iJJxettgAcN6xZnXb8ZuM36OmqpJL5c9HLP6WgbdYU?=
 =?us-ascii?Q?1bkx8Oq2lrFv01fKBZZpFbFZt4hxbPS6VluwuoSNLQutVcXpvTMx2fuuzMcA?=
 =?us-ascii?Q?4cOnY/XHl4M7Kjvs8upinwqntB3el65TNd/cXRU0jIrElCu9tfWOuLPFN3SR?=
 =?us-ascii?Q?DsHGixWL85vmmslfW5rm7Em83BHqemsamyaLJrZ7YhVIzviJgmGjzHlvK3vu?=
 =?us-ascii?Q?bWjZHOqqdugjSJu/nAbMmlAIMNY4eP7uUxVzcC3fqju0TEB/IMPvnVtkBRAf?=
 =?us-ascii?Q?ZIPXRsV1Wp4mG4E9bBuvODxTFqDn3hYDr9BEKYbM2GE+OsUrgtYP9zY51sJL?=
 =?us-ascii?Q?NX88slB5RHHQi9Gswc5kdPr0iPAn5CunhhhG3/Lyjo/qYhn4uGgKwBmkiwJx?=
 =?us-ascii?Q?nZp73rMbSivv4/H95XgHwpdCNi0hy5zW/h9wwaUAWvBNC07en/ydIWpFjJG0?=
 =?us-ascii?Q?F0/PjzP0c4NJ4GxP6O9cL8vFNAh6Jh2g2JtEUHfkTLGvIoc8sCjsGfCDkr7j?=
 =?us-ascii?Q?yCn36gR9FVREsBkwIHD0xCBjdLZvZNPqzpyFpWF6ykSE13kNsylmYM6f70TS?=
 =?us-ascii?Q?2GHv1d9D60Q2GF4wd7Cy9Xki3BWk70etQLKJ5pn3JuqV6QCpgtJtyfuNcunz?=
 =?us-ascii?Q?wNecHaxFFWy4TvwGkjQTPqCkomJ7yM23psoXszVyEzTe2vgvXOMG92Mm4Hki?=
 =?us-ascii?Q?wnApu1iJP6iIJEyEvJ3IacXHLZXnXTY/SPsNVSzj6sFqokRYVpz5qLTTozZE?=
 =?us-ascii?Q?HrxWGHOytFpfTAiaomybuLG/+mP6Fnx/EP+lX4PusDaJeoqzyT2i53mmRN+6?=
 =?us-ascii?Q?ZJsiO+C5nvf8q2lW8p+NyKfaHa7tJtHkEooLc3c6Ge5PShDqm453IrxAyYNy?=
 =?us-ascii?Q?Eh0qq+rz3aufn9Nxlgb9/OvB8aIkyRoYybgsmZd78E2c86IW/PvKmVefUxpA?=
 =?us-ascii?Q?9XT2IIvg4pNIXmLe/ll+DasSOhzA0Xt2y9kygj+z+V7P3P2RgwPZ3bCbYj25?=
 =?us-ascii?Q?NvFKorAFcyHBlo/ZYqGTnfnGpERBjQoabBCM9MZ2fcenAkGq/slHlKGmvRMr?=
 =?us-ascii?Q?wLWLem3VxF5SzZ+rXWiXQfuy3HOwl/vmW9GSQ9fs2wgsGzouVKU/UbmNUXKO?=
 =?us-ascii?Q?AOHH2seQO3leZkchTNtthaKVBiOXkT/rtoVfcK+k1uTSz8i1umQqxz3ZCXup?=
 =?us-ascii?Q?cP4ur9OP0DSuYHexvJ7vPgyXx0unBWAl5Bxx1OAVhBrSAmswFFC+ZpyrJhCj?=
 =?us-ascii?Q?NRoE1E9Bfg7ctdPOBAzpENX5CjwPIv4bo1BWM1XDsaVJaS5ST3ffxX0JZqJF?=
 =?us-ascii?Q?gvnLo3b6roJ4FuM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:16.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612468e9-13d6-4fa4-68cd-08dd4e79cb58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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

From: Erez Shitrit <erezsh@nvidia.com>

Matcher for one of the new FDB sub-domains contains specific
details according to the type of that sub-domain.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_matcher.c | 39 ++++++++++++++++++++++++---
 drivers/net/mlx5/hws/mlx5dr_pool.c    |  4 +--
 drivers/net/mlx5/hws/mlx5dr_table.h   |  9 +++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_matcher.c b/drivers/net/mlx5/hws/mlx5dr_matcher.c
index 54460cc82b..3c84a677d7 100644
--- a/drivers/net/mlx5/hws/mlx5dr_matcher.c
+++ b/drivers/net/mlx5/hws/mlx5dr_matcher.c
@@ -50,7 +50,7 @@ int mlx5dr_matcher_free_rtc_pointing(struct mlx5dr_context *ctx,
 {
 	int ret;
 
-	if (type != MLX5DR_TABLE_TYPE_FDB && !mlx5dr_context_shared_gvmi_used(ctx))
+	if (!mlx5dr_table_is_fdb_any(type) && !mlx5dr_context_shared_gvmi_used(ctx))
 		return 0;
 
 	ret = mlx5dr_table_ft_set_next_rtc(devx_obj, fw_ft_type, NULL, NULL);
@@ -407,6 +407,25 @@ static bool mlx5dr_matcher_supp_fw_wqe(struct mlx5dr_matcher *matcher)
 	return true;
 }
 
+static void mlx5dr_matcher_fixup_rtc_sizes_by_tbl(enum mlx5dr_table_type tbl_type,
+						  bool is_mirror,
+						  struct mlx5dr_cmd_rtc_create_attr *rtc_attr)
+{
+	if (!is_mirror) {
+		if (tbl_type == MLX5DR_TABLE_TYPE_FDB_TX) {
+			/* rtc_0 for TX flow is minimal */
+			rtc_attr->log_size = 0;
+			rtc_attr->log_depth = 0;
+		}
+	} else {
+		if (tbl_type == MLX5DR_TABLE_TYPE_FDB_RX) {
+			/* rtc_1 for RX flow is minimal */
+			rtc_attr->log_size = 0;
+			rtc_attr->log_depth = 0;
+		}
+	}
+}
+
 static void mlx5dr_matcher_set_rtc_attr_sz(struct mlx5dr_matcher *matcher,
 					   struct mlx5dr_cmd_rtc_create_attr *rtc_attr,
 					   enum mlx5dr_matcher_rtc_type rtc_type,
@@ -426,6 +445,11 @@ static void mlx5dr_matcher_set_rtc_attr_sz(struct mlx5dr_matcher *matcher,
 		rtc_attr->log_size = is_match_rtc ? matcher->attr.table.sz_row_log : ste->order;
 		rtc_attr->log_depth = is_match_rtc ? matcher->attr.table.sz_col_log : 0;
 	}
+
+	/* set values according to tbl->type */
+	mlx5dr_matcher_fixup_rtc_sizes_by_tbl(matcher->tbl->type,
+					      is_mirror,
+					      rtc_attr);
 }
 
 int mlx5dr_matcher_create_aliased_obj(struct mlx5dr_context *ctx,
@@ -604,7 +628,7 @@ static int mlx5dr_matcher_create_rtc(struct mlx5dr_matcher *matcher,
 		goto free_ste;
 	}
 
-	if (tbl->type == MLX5DR_TABLE_TYPE_FDB) {
+	if (mlx5dr_table_fdb_no_unified(tbl->type)) {
 		devx_obj = mlx5dr_pool_chunk_get_base_devx_obj_mirror(ste_pool, ste);
 		rtc_attr.ste_base = devx_obj->id;
 		rtc_attr.table_type = mlx5dr_table_get_res_fw_ft_type(tbl->type, true);
@@ -619,6 +643,9 @@ static int mlx5dr_matcher_create_rtc(struct mlx5dr_matcher *matcher,
 			       mlx5dr_matcher_rtc_type_to_str(rtc_type));
 			goto destroy_rtc_0;
 		}
+	} else if (tbl->type == MLX5DR_TABLE_TYPE_FDB_UNIFIED) {
+		/* Unified domain has 2 identical RTC's, allow connecting from other domains */
+		*rtc_1 = *rtc_0;
 	}
 
 	return 0;
@@ -656,7 +683,7 @@ static void mlx5dr_matcher_destroy_rtc(struct mlx5dr_matcher *matcher,
 		return;
 	}
 
-	if (tbl->type == MLX5DR_TABLE_TYPE_FDB)
+	if (mlx5dr_table_fdb_no_unified(tbl->type))
 		mlx5dr_cmd_destroy_obj(rtc_1);
 
 	mlx5dr_cmd_destroy_obj(rtc_0);
@@ -703,6 +730,10 @@ static void mlx5dr_matcher_set_pool_attr(struct mlx5dr_pool_attr *attr,
 	default:
 		break;
 	}
+
+	/* Now set attr according to the table type */
+	if (attr->opt_type == MLX5DR_POOL_OPTIMIZE_NONE)
+		mlx5dr_context_set_pool_tbl_attr(attr, matcher->tbl->type);
 }
 
 static int mlx5dr_matcher_check_and_process_at(struct mlx5dr_matcher *matcher,
@@ -1073,7 +1104,7 @@ mlx5dr_matcher_process_attr(struct mlx5dr_cmd_query_caps *caps,
 		return 0;
 	}
 
-	if (matcher->tbl->type != MLX5DR_TABLE_TYPE_FDB  && attr->optimize_flow_src) {
+	if (!mlx5dr_table_is_fdb_any(matcher->tbl->type) && attr->optimize_flow_src) {
 		DR_LOG(ERR, "NIC domain doesn't support flow_src");
 		goto not_supported;
 	}
diff --git a/drivers/net/mlx5/hws/mlx5dr_pool.c b/drivers/net/mlx5/hws/mlx5dr_pool.c
index b7b532c7cf..8e3718ac42 100644
--- a/drivers/net/mlx5/hws/mlx5dr_pool.c
+++ b/drivers/net/mlx5/hws/mlx5dr_pool.c
@@ -20,7 +20,7 @@ static void mlx5dr_pool_resource_free(struct mlx5dr_pool *pool,
 	mlx5dr_pool_free_one_resource(pool->resource[resource_idx]);
 	pool->resource[resource_idx] = NULL;
 
-	if (pool->tbl_type == MLX5DR_TABLE_TYPE_FDB) {
+	if (mlx5dr_table_fdb_no_unified(pool->tbl_type)) {
 		mlx5dr_pool_free_one_resource(pool->mirror_resource[resource_idx]);
 		pool->mirror_resource[resource_idx] = NULL;
 	}
@@ -89,7 +89,7 @@ mlx5dr_pool_resource_alloc(struct mlx5dr_pool *pool, uint32_t log_range, int idx
 	}
 	pool->resource[idx] = resource;
 
-	if (pool->tbl_type == MLX5DR_TABLE_TYPE_FDB) {
+	if (mlx5dr_table_fdb_no_unified(pool->tbl_type)) {
 		struct mlx5dr_pool_resource *mir_resource;
 
 		fw_ft_type = mlx5dr_table_get_res_fw_ft_type(pool->tbl_type, true);
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.h b/drivers/net/mlx5/hws/mlx5dr_table.h
index 6996a90d9b..a7cdef5d78 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.h
+++ b/drivers/net/mlx5/hws/mlx5dr_table.h
@@ -48,6 +48,15 @@ static inline bool mlx5dr_table_is_fdb_any(enum mlx5dr_table_type tbl_type)
 	return false;
 }
 
+static inline bool mlx5dr_table_fdb_no_unified(enum mlx5dr_table_type tbl_type)
+{
+	if (mlx5dr_table_is_fdb_any(tbl_type) &&
+	    tbl_type != MLX5DR_TABLE_TYPE_FDB_UNIFIED)
+		return true;
+
+	return false;
+}
+
 static inline
 uint32_t mlx5dr_table_get_res_fw_ft_type(enum mlx5dr_table_type tbl_type,
 					 bool is_mirror)
-- 
2.21.0

