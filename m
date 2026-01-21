Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B182CD262B2
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 08:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FCF84278D;
	Wed, 21 Jan 2026 09:15:18 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by mails.dpdk.org (Postfix) with ESMTP id C073B400D7;
 Wed, 21 Jan 2026 09:15:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcDbfXQ4KqQbsIhgfUX7W71lhsO609UUZZxefPh33uVEA4uzdkbgS/OuJM/8doaVBb3Lkb1SAMQHeFTnUiMCGswE15qiYNat0Io4J66RLcWI36aSQJDC6VWK/r4rtR9tZEJDnZTrj489Gc54afHBMR7HQlOrzc6T49nJbBdaJC3en5WFFpvh4JyGjptgQqRXXtoIYDGBmYdmcKFUDbllurglDnCOHokrrYmWnSnbxX0K6KvALyvdM+iMvQtt6FgzKf5z7kbnLzCiIawm4sfiZUAh7+KPRN++T7TZspwNW0mtsZ5hG/CsR46b9vTYf7CUxVviZb+HcXVleSE1Gg9bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzeyH2k0Ge2THPFEx0dg4+RH7EoRQcf7DBPd+rwn3vg=;
 b=uC7f51E4wZAv4Y79X/lhey67CuXvf55KL44SWEGghjPum0kpaBas3/TvMGWkE10SI6mJTS6G0xBHmD5X1J6VH6rFbVCRk/0P35LWvrBQXQeshwG1LLKqmiOn856Rl26lubcLgrv4ASAcsWR8hN7eUc9vPOPRJ0W+bspp88DPdeWj0DCHKsWbkhAUpXf8/Q6msbeM+Bh2Dg7aRtmsoVf/2yXJ82gMTGDrd9tEBSqfaWVgdFjzzr7JaOcZwIjdeOPHLbFk++5vi2K3qRuZyi63t70tUahzGQ/L4D3aDT+MHvPy3pPfUIgfpS8mBI1EKASKCGFtMWHSqRTP1sx1ElGaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzeyH2k0Ge2THPFEx0dg4+RH7EoRQcf7DBPd+rwn3vg=;
 b=tIRsOO/vjqWodb5bUOMq29V74oqQTq+tM8+h2JNtGrIOBRpkZZlL2+RSepEChc1keXVvfuO+LDSEvTaa9CVkTLHJMGe8iWmPYxJfNDFL+jeshQNL185Mggv/nzkIyvuqm1GMJUfNbyjwdz1DpuuaSgW8hnAy5WKAvfJY7HSFS4Hev0bMQIDyPHgkpoFbc1gUWwWyCmd9aaJCx58p8li8ITgWOcaH+xEy1bm4sL0tsW1cfnmcejA6YhrvFybSFA/jeZjQyypJpyTocDZVwJXiYVxdg5MSfOIAzWUadHYVjW5b55SKH9OlLCKBJyqZCQKHM03W2vVgGyWTEy3KTZKCuQ==
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 21 Jan
 2026 08:15:12 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::c) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 08:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 08:15:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:14:54 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:14:53 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 00:14:50 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alex Vesker <valex@nvidia.com>, Erez Shitrit
 <erezsh@nvidia.com>
Subject: [PATCH] net/mlx5: fix stack alignment for ASan compatibility
Date: Wed, 21 Jan 2026 10:14:47 +0200
Message-ID: <20260121081447.224127-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b88852d-67e4-47e8-3ce8-08de58c532b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CqWRmV9JLn4vLgNGDTcdksUTu7Ti+3jPO/5gzN804Z3OLz5H5yXxiVPIOZJp?=
 =?us-ascii?Q?lQGKPOwnSvFdM7Nx512oAkxapPh+WhnpBaR37e39nKSOp4iDWR4usM2pa78s?=
 =?us-ascii?Q?wxBrmlGFuHOgiBnVKTxmhwg8PLk74BdTIUq5zZupza3h1+pLhk7l7gXk0tIn?=
 =?us-ascii?Q?POuXFazdlxBcrpCX+AbkATjvh4BDGmAeX+mTruOZjRQ4tWODY/g8F2d5bwIR?=
 =?us-ascii?Q?L92Jxvck8D+DL3Dh8Qwb67jwzWU9VBiiTSeDx2ClnJ7GCHl1Dl8b5D6ooZn/?=
 =?us-ascii?Q?zddDbCiHzwdP0zV9CtjOGx6VgmS1j06ifQSvBpxX98U/f29bDma/kFon+poI?=
 =?us-ascii?Q?Lyk5ArcI4ExpRoS4SlG8kbuzLbeSwhLq9R9hDTyj/3nSBc+DZnNXonPN0Q4v?=
 =?us-ascii?Q?Rd25kGOpNDjo/eYYHmzEk7Mhc44YoEABA2QqFJnpEBFMD8WczGiLNmaUMVy6?=
 =?us-ascii?Q?F45oO4DG2sOXk5vaN8pf4qLSppzFV1gWA3v7xx1FvstmrmpJ/JyYLZ4/K09r?=
 =?us-ascii?Q?FozlWaBfdpd+iOwwh9AxwOEs2L7/a3yEoPTvWjNCgvDTM15jK/7B+OrUFu1G?=
 =?us-ascii?Q?VD0e6U4RMTMni1L7nlz5mk0LrEf2cwacivVFoZsyDeUmqdr//CzRtwW5MhHN?=
 =?us-ascii?Q?m5FBFTUxnff8EHcuBnPf51HVtpLZ9Z8IIzSNGwi41gvAEb0TnXrEvwbLP0L2?=
 =?us-ascii?Q?6sVNBkegkqv6lNvhY3Fu5ZBHghBqR3E5re7IfgOJvpyvtfq5w7HMc30p7WwX?=
 =?us-ascii?Q?Z89CbKgRANcwna6VNBMnVsy7ulXxrCUC0V0ryiE8f6YC0zNnLhMtPbWV8fKk?=
 =?us-ascii?Q?OzvgU5TPx0BUgmCcHNsjQHNM31Fbs/K5zHF4naotY4+pn32RmsgpRLpEnPuB?=
 =?us-ascii?Q?yzXwTPcATJbq4gH9uMRGcbZV8q/vjuYMVYlhGqAKGFTrwa8voVO+gBnfr5C+?=
 =?us-ascii?Q?peO9NjpIUwHgE+Y3GxoxkAU15NVXD/S2hhHGJr9kluNR7SWlkRr1toBVGaOp?=
 =?us-ascii?Q?k+syw2wRFXUNFlnAWInDREiauNjuTNw4UkS2oRoHKm9n2uS8l7GqUxtA0Bus?=
 =?us-ascii?Q?xUmMgX8KdZPBecJy/XV88I5dQATP1i8VVRG5BEHv218ZAz6HRdnMPc0TQwDQ?=
 =?us-ascii?Q?wN2pnY+V1MKFA0DYekDTFkvKP1m2Jtsftt+T+dLjd4qI2gHYD7km7SnYwVKw?=
 =?us-ascii?Q?9W9nDmSStVu7Cqz/5dx1EkNkXLqbcA48eBk5MwX74sKSL+zlLRvjkeaA5h4X?=
 =?us-ascii?Q?u2T5Wr//oizYysbOIZ6gj5qOv496Zxq9XpNw+jpg465Cp0FfiIEzTfZ19cUQ?=
 =?us-ascii?Q?VmILf7o1gjUDpe8T6aAnw4oXSxdJC/lYsTP+tUHevn4+5b23vwRNZZkZlAoa?=
 =?us-ascii?Q?VhSYRU8nD5giLTu0BfN607QKqHmgeQ5tAozTQv2RRHqfoF3NifSqyMsh5M0g?=
 =?us-ascii?Q?DM3zYj3/fVciBPhphrE5Gd5I70UoM6arRMpbfROJOoY6wuL7SBW+8HG9MkW3?=
 =?us-ascii?Q?yp7X3oU2KiaOqO3PPs/+N4sSEnMvffaChSrQ+ABMTFyhYyiOSi6TeFeYh3iv?=
 =?us-ascii?Q?/is3yBUJhAHSzMsJhVWOo0FkFs8Ml4/JT+LOHibwvuR4FXEwCLnzfwCYpOBB?=
 =?us-ascii?Q?wtjAaT6bOYTrIdQRI9PV2bl/P+Z7kuSkDVZO0gpEeg8QF0oUGcrH86aRdYro?=
 =?us-ascii?Q?tatpvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:15:11.3880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b88852d-67e4-47e8-3ce8-08de58c532b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
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

When compiling with optimizations, the compiler uses AVX-512
instructions (vmovdqa64) to efficiently zero large structures.
This instruction requires 64-byte aligned memory addresses.

When compiling with ASAN, the stack layout is modified for
instrumentation, which can break the 64-byte alignment of
local structures. This causes a segfault when the misaligned
vmovdqa64 instruction executes.

Fix by adding MLX5DR_ASAN_ALIGN macro to ensure 64-byte alignment
when building with ASan.

Fixes: 338aaf911665 ("net/mlx5/hws: add send FW match STE using gen WQE")
Fixes: 12802ab2c8e2 ("net/mlx5/hws: support GTA WQE write using FW command")
Fixes: 405242c52dd5 ("net/mlx5/hws: add rule object")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_cmd.c      | 4 ++--
 drivers/net/mlx5/hws/mlx5dr_internal.h | 6 ++++++
 drivers/net/mlx5/hws/mlx5dr_rule.c     | 2 +-
 drivers/net/mlx5/hws/mlx5dr_send.c     | 4 ++--
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c b/drivers/net/mlx5/hws/mlx5dr_cmd.c
index d6bf015d57..47e6a1fd49 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -1013,8 +1013,8 @@ int mlx5dr_cmd_generate_wqe(struct ibv_context *ctx,
 			    struct mlx5dr_cmd_generate_wqe_attr *attr,
 			    struct mlx5_cqe64 *ret_cqe)
 {
-	uint32_t out[MLX5_ST_SZ_DW(generate_wqe_out)] = {0};
-	uint32_t in[MLX5_ST_SZ_DW(generate_wqe_in)] = {0};
+	MLX5DR_ASAN_ALIGN uint32_t out[MLX5_ST_SZ_DW(generate_wqe_out)] = {0};
+	MLX5DR_ASAN_ALIGN uint32_t in[MLX5_ST_SZ_DW(generate_wqe_in)] = {0};
 	uint8_t status;
 	void *ptr;
 	int ret;
diff --git a/drivers/net/mlx5/hws/mlx5dr_internal.h b/drivers/net/mlx5/hws/mlx5dr_internal.h
index 2abc516b5e..6a4aafbe88 100644
--- a/drivers/net/mlx5/hws/mlx5dr_internal.h
+++ b/drivers/net/mlx5/hws/mlx5dr_internal.h
@@ -53,6 +53,12 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
+#ifdef RTE_MALLOC_ASAN
+#define MLX5DR_ASAN_ALIGN alignas(64)
+#else
+#define MLX5DR_ASAN_ALIGN
+#endif
+
 #ifdef RTE_LIBRTE_MLX5_DEBUG
 /* Prevent double function name print when debug is set */
 #define DR_LOG DRV_LOG
diff --git a/drivers/net/mlx5/hws/mlx5dr_rule.c b/drivers/net/mlx5/hws/mlx5dr_rule.c
index 895ac858ec..eb06996c90 100644
--- a/drivers/net/mlx5/hws/mlx5dr_rule.c
+++ b/drivers/net/mlx5/hws/mlx5dr_rule.c
@@ -483,7 +483,7 @@ static int mlx5dr_rule_create_hws(struct mlx5dr_rule *rule,
 	bool is_jumbo = mlx5dr_matcher_mt_is_jumbo(mt);
 	struct mlx5dr_matcher *matcher = rule->matcher;
 	struct mlx5dr_context *ctx = matcher->tbl->ctx;
-	struct mlx5dr_send_ste_attr ste_attr = {0};
+	MLX5DR_ASAN_ALIGN struct mlx5dr_send_ste_attr ste_attr = {0};
 	struct mlx5dr_send_ring_dep_wqe *dep_wqe;
 	struct mlx5dr_actions_wqe_setter *setter;
 	struct mlx5dr_actions_apply_data apply;
diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c b/drivers/net/mlx5/hws/mlx5dr_send.c
index d01fc7ef2c..85f613ed39 100644
--- a/drivers/net/mlx5/hws/mlx5dr_send.c
+++ b/drivers/net/mlx5/hws/mlx5dr_send.c
@@ -250,8 +250,8 @@ int mlx5dr_send_wqe_fw(struct ibv_context *ibv_ctx,
 {
 	bool has_range = send_wqe_range_data || send_wqe_range_tag;
 	bool has_match = send_wqe_match_data || send_wqe_match_tag;
-	struct mlx5dr_wqe_gta_data_seg_ste gta_wqe_data0 = {0};
-	struct mlx5dr_wqe_gta_data_seg_ste gta_wqe_data1 = {0};
+	MLX5DR_ASAN_ALIGN struct mlx5dr_wqe_gta_data_seg_ste gta_wqe_data0 = {0};
+	MLX5DR_ASAN_ALIGN struct mlx5dr_wqe_gta_data_seg_ste gta_wqe_data1 = {0};
 	struct mlx5dr_wqe_gta_ctrl_seg gta_wqe_ctrl = {0};
 	struct mlx5dr_cmd_generate_wqe_attr attr = {0};
 	struct mlx5dr_wqe_ctrl_seg wqe_ctrl = {0};
-- 
2.43.0

