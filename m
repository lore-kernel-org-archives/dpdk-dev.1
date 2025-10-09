Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523DCCA470
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 09:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7083402A8;
	Thu,  9 Oct 2025 11:19:52 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53]) by mails.dpdk.org (Postfix) with ESMTP id 8BF3040277;
 Thu,  9 Oct 2025 11:19:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDeg4XcvgW5RfGdCOU2ZzV/iRnnuUOOBuWtsz3xGd13a+JFyAOl5dGTGacIN6bLM/Z4I6R+qWuSNzuFv2dYjZmU8zMB8lUID8epLyLbr/wzARDCxlmNPeK/Va7Q4S9EBSbYnxuOsxPnS5P01apf8Paf/eyfS8HzQGw7Z1gE9i7irSlJaiPKtRf2FeDd5V0eEYwWVdE3RBoDP9apikAzgjzxz1Y71zX+oj94jgmdrBOWPkVsJF5zvHKqGYzvMPacMZh3e+Pk6t3mpqa5giO28LVQ2Jeb11KY1GhXIzwXGKPONJWKSFW/1K/BLJb2/Np4BkFrtEdmWBnq3QLROyL4rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he5+W2tSDigFUqaWOnhsVgdQCvYn+3ym6hFGHmh2tYM=;
 b=VuwihL/ofD5KAJM9VsF/5DziKE/VZMcdzvcsHrmVfgmfMyFp6hug4MxRnvoEyIqR3lnfN3ocUXlBKpj4lJZc3dHgOsHCw0ps+Ut7uYoIps6njER612I8OfWaOOCrQk7ALAsO5er2m0E2cHwsHBmkFjI5JjbLcUYQ77Aqi/Dv2wGGnQxjWJcXFEE4nk2Ui1h/g97+jjl7XEIlKctqqEIRn0MKLkyqCiwc53Gs3oGAXAoL0R4Kpwzgr2PlSO9PM6az8omsd94C2nL1TTtMhgGu+nbXo9/+u65tjCDMloPFCsFjOQu+s5yhJ47NgdkplhVtGGXKwz70jP5/D7WuZ7jLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he5+W2tSDigFUqaWOnhsVgdQCvYn+3ym6hFGHmh2tYM=;
 b=arknepmWxHtScnblNZrLHZQF0aKpx2VtlR3v1FEbOswxtKATG0e+wL0kDzIuVnqTPCx1xwK4m5rcszHNCej0ioBVa7rugH5bkS+benzJhaDBW73tUF9YQrXH8MrFGgFpRWCVPb987DyITEucwYSq+YuDKAxH+/Wb/yLO1D5QGhLcTprdWUSFp8w3OHgB0egFtbS7oBrJ9ZnvzoIVqcEA1rFn5N1mqIZkAOaaBS5S9KYUa4lpJU2Els7O6qjdj61MgcrPzVVXKCIyzi+zy8/lVRVBFNxg0VAVk7gVfXglpsa16DLShBmbtjZD3jXpeEk4vzM8op1Ih+PP3XdOERim5A==
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:19:44 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::57) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 09:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 09:19:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 9 Oct
 2025 02:19:31 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Oct
 2025 02:19:27 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <michaelba@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v3] net/mlx5: fix age checking crash
Date: Thu, 9 Oct 2025 12:18:10 +0300
Message-ID: <20251009091810.174004-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20251009062924.138382-1-rongweil@nvidia.com>
References: <20251009062924.138382-1-rongweil@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 0838a495-3aca-4e6e-96bd-08de0714fbd5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?an/iDBrgiEkFMHD2nMUviso1QHvyrpsGTsU/KOMY07dD+k8x/EWWk1ijNfWo?=
 =?us-ascii?Q?BEvhqSJDaCCOJVPB4j6ipAHd0ZQDDYhMGaZ8evUukCtsctjh6l17UKaqDR/y?=
 =?us-ascii?Q?zmC8w98OKynh8CYDpG3dfQ1NDIbU4Iw+uz4IJbjqYnKG/fABhKyhHn8YWo7O?=
 =?us-ascii?Q?MtsOHNWEd1m2TcAK9pTjzZA5aRpiS1m91iU/0Qk1slNkfv3qFIhwDVG18krU?=
 =?us-ascii?Q?/tm+Q5ZC9UgMIBfZz/KUShUHWWrKB+0M4ES4gnGkkgNENjXwrCUDvDadWEhq?=
 =?us-ascii?Q?lq8YTAmLV1vyDvQMhJNByAyij88xS9EOJkJ382qNenVUGGuvCBk/uUIrxrZf?=
 =?us-ascii?Q?nuOYJFtSgHcGS6GJqRv3wGaV7R1PAKiPfvGmKLcPQOtDe6HDwOwsSdMhf8t4?=
 =?us-ascii?Q?Nn9Ka6FC0lvvqw20CuVUpnMlhsfO1f5awUWfhVfuGfN8eKSnyJ3zegyfov0i?=
 =?us-ascii?Q?8vX8gxNV264aaXcXMa2x1z1wEbCGudkTKjy/h3oFaFRkEJ5zipjiSsKwKDsf?=
 =?us-ascii?Q?FkHAYmo8FPEKdN5OSJMyRD8qY6UXEYGUb0KdSixuFyVKdjFdPqbvX8Xru49H?=
 =?us-ascii?Q?pS856IarIy7o9gPuwvJVLjd7oE4B2lbAkR9C4DFVVm7PURWRicLD5La0ScvT?=
 =?us-ascii?Q?wgF9Wobz+/VXUI16gw5Toi4AdR+9LUJNCQbZz0Suz1+vQ0nZ2ZDiJ+NS7+tp?=
 =?us-ascii?Q?50flnbOLvcdxmsYAnWXvtowZ1/LidZSBuanecf5wuBdX/N0uN7Qg9cj+JBPD?=
 =?us-ascii?Q?ggJonx+aproXP05DHWLG+BV/jPfx0xsdakGeaIbCMi6u2/IOe8+jaTGGsrUn?=
 =?us-ascii?Q?CA2Dxkjg491R5Ciu0ICNDiB0E3KZx+J6grjSgQkwCSyarWLCKGH3pazNkh5S?=
 =?us-ascii?Q?0yxpw+ICLcIeF+BbSFwzkd/xusR1OULP979kk3rLFhDX468AKpXDhxEV041L?=
 =?us-ascii?Q?RXMwMhVs3dG/bpYHedKoLRYyU4GZgwHX92w0TFoUM5s7bbEM2PgMv7L7VndZ?=
 =?us-ascii?Q?dGBYVonWjrreC0EtvR/YjKp0dQcfV18EJ6NS6VIoRETd5uc3RxbmTZFewcaf?=
 =?us-ascii?Q?7LcYw6SJawltJkjEsDOCYmT2oUbfGZ50jzjFsEdJDmw3m12KJCnTZVxM65dr?=
 =?us-ascii?Q?IE30JCuWq6/mQWo6q/GZNCdx6tXELqTHeqI2kXEGMvzmeJVslwSifiR+yjAr?=
 =?us-ascii?Q?BsfEj9ekm83U5lrqFFq5xYJfi9yKinu7fFZ3dN9RsURnY/oNKzvn1DjboBQ7?=
 =?us-ascii?Q?DJwUttxzaOKN82URKJFrJtXUGnFvMgXD6EI+7zTJAcA2IGupF9bb8IztJ0YQ?=
 =?us-ascii?Q?xXc3bGjWRkGw8rDk2bLOoISVCTQzZW46b5IUJ6/xf/MSfH4M7TqgOpKt++tp?=
 =?us-ascii?Q?UfNIVsAHwMKBicSv+jcJLIYYpjwQ+CEvcjnJWA/jUOzuMCJJLeoATMzSFDS+?=
 =?us-ascii?Q?bYo8gw9EMlgEwUeqDrMhwhhWMpUu+DGnWJsIR9NyE444z3TP8n+Qfx/NHcwv?=
 =?us-ascii?Q?ky3iP122Z9SXt3zh3wcE369uuwI2Gmk88z6DOsiX5cB/V1zXAfHXqtgWF7hS?=
 =?us-ascii?Q?Dj8X/sMXofy3FZ+qBts=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:19:43.7919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0838a495-3aca-4e6e-96bd-08de0714fbd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397
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

When aging is configured, there is a background thread
which queries all the counters in the pool.

Meantime, per queue flow insertion/deletion/update changes
the counter pool too. It introduces a race condition between
resetting counters's in_used and age_idx fields during flow deletion
and reading them in the background thread.

To resolve it, all key members of counter's struct
are placed in a single uint32_t and they are accessed atomically.

To avoid the occasional timestamp equalization with age_idx,
query_gen_when_free is moved out of the union. The total memory
size is kept the same.

Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
Cc: michaelba@nvidia.com
Cc: stable@dpdk.org
Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

v3: fix windows compilation error.
v2: fix clang compilation error.
---
 drivers/net/mlx5/mlx5_flow_hw.c |   5 +-
 drivers/net/mlx5/mlx5_hws_cnt.c |  10 +--
 drivers/net/mlx5/mlx5_hws_cnt.h | 133 ++++++++++++++++++++------------
 3 files changed, 90 insertions(+), 58 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 9a0aa1827e..491a78a0de 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3232,7 +3232,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 			return -1;
 		if (action_flags & MLX5_FLOW_ACTION_COUNT) {
 			cnt_queue = mlx5_hws_cnt_get_queue(priv, &queue);
-			if (mlx5_hws_cnt_pool_get(priv->hws_cpool, cnt_queue, &age_cnt, idx) < 0)
+			if (mlx5_hws_cnt_pool_get(priv->hws_cpool, cnt_queue, &age_cnt, idx, 0) < 0)
 				return -1;
 			flow->flags |= MLX5_FLOW_HW_FLOW_FLAG_CNT_ID;
 			flow->cnt_id = age_cnt;
@@ -3668,7 +3668,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 			/* Fall-through. */
 		case RTE_FLOW_ACTION_TYPE_COUNT:
 			cnt_queue = mlx5_hws_cnt_get_queue(priv, &queue);
-			ret = mlx5_hws_cnt_pool_get(priv->hws_cpool, cnt_queue, &cnt_id, age_idx);
+			ret = mlx5_hws_cnt_pool_get(priv->hws_cpool, cnt_queue, &cnt_id,
+						    age_idx, 0);
 			if (ret != 0) {
 				rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_ACTION,
 						action, "Failed to allocate flow counter");
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index 5c738f38ca..fb01fce4e5 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -63,8 +63,8 @@ __mlx5_hws_cnt_svc(struct mlx5_dev_ctx_shared *sh,
 	uint32_t ret __rte_unused;
 
 	reset_cnt_num = rte_ring_count(reset_list);
-	cpool->query_gen++;
 	mlx5_aso_cnt_query(sh, cpool);
+	rte_atomic_fetch_add_explicit(&cpool->query_gen, 1, rte_memory_order_release);
 	zcdr.n1 = 0;
 	zcdu.n1 = 0;
 	ret = rte_ring_enqueue_zc_burst_elem_start(reuse_list,
@@ -134,14 +134,14 @@ mlx5_hws_aging_check(struct mlx5_priv *priv, struct mlx5_hws_cnt_pool *cpool)
 	uint32_t nb_alloc_cnts = mlx5_hws_cnt_pool_get_size(cpool);
 	uint16_t expected1 = HWS_AGE_CANDIDATE;
 	uint16_t expected2 = HWS_AGE_CANDIDATE_INSIDE_RING;
-	uint32_t i;
+	uint32_t i, age_idx, in_use;
 
 	cpool->time_of_last_age_check = curr_time;
 	for (i = 0; i < nb_alloc_cnts; ++i) {
-		uint32_t age_idx = cpool->pool[i].age_idx;
 		uint64_t hits;
 
-		if (!cpool->pool[i].in_used || age_idx == 0)
+		mlx5_hws_cnt_get_all(&cpool->pool[i], &in_use, NULL, &age_idx);
+		if (!in_use || age_idx == 0)
 			continue;
 		param = mlx5_ipool_get(age_info->ages_ipool, age_idx);
 		if (unlikely(param == NULL)) {
@@ -767,7 +767,7 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	 * because they already have init value no need
 	 * to wait for query.
 	 */
-	cpool->query_gen = 1;
+	rte_atomic_store_explicit(&cpool->query_gen, 1, rte_memory_order_relaxed);
 	ret = mlx5_hws_cnt_pool_action_create(priv, cpool);
 	if (ret != 0) {
 		rte_flow_error_set(error, -ret,
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
index 38a9c19449..7af7e71ee0 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.h
+++ b/drivers/net/mlx5/mlx5_hws_cnt.h
@@ -42,33 +42,36 @@ struct mlx5_hws_cnt_dcs_mng {
 	struct mlx5_hws_cnt_dcs dcs[MLX5_HWS_CNT_DCS_NUM];
 };
 
-struct mlx5_hws_cnt {
-	struct flow_counter_stats reset;
-	bool in_used; /* Indicator whether this counter in used or in pool. */
-	union {
-		struct {
-			uint32_t share:1;
-			/*
-			 * share will be set to 1 when this counter is used as
-			 * indirect action.
-			 */
-			uint32_t age_idx:24;
-			/*
-			 * When this counter uses for aging, it save the index
-			 * of AGE parameter. For pure counter (without aging)
-			 * this index is zero.
-			 */
-		};
-		/* This struct is only meaningful when user own this counter. */
-		uint32_t query_gen_when_free;
+union mlx5_hws_cnt_state {
+	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t) data;
+	struct {
+		uint32_t in_used:1;
+		/* Indicator whether this counter in used or in pool. */
+		uint32_t share:1;
+		/*
+		 * share will be set to 1 when this counter is used as
+		 * indirect action.
+		 */
+		uint32_t age_idx:24;
 		/*
-		 * When PMD own this counter (user put back counter to PMD
-		 * counter pool, i.e), this field recorded value of counter
-		 * pools query generation at time user release the counter.
+		 * When this counter uses for aging, it stores the index
+		 * of AGE parameter. Otherwise, this index is zero.
 		 */
 	};
 };
 
+struct mlx5_hws_cnt {
+	struct flow_counter_stats reset;
+	union mlx5_hws_cnt_state cnt_state;
+	/* This struct is only meaningful when user own this counter. */
+	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t) query_gen_when_free;
+	/*
+	 * When PMD own this counter (user put back counter to PMD
+	 * counter pool, i.e), this field recorded value of counter
+	 * pools query generation at time user release the counter.
+	 */
+};
+
 struct mlx5_hws_cnt_raw_data_mng {
 	struct flow_counter_stats *raw;
 	struct mlx5_pmd_mr mr;
@@ -197,6 +200,42 @@ mlx5_hws_cnt_id_valid(cnt_id_t cnt_id)
 		MLX5_INDIRECT_ACTION_TYPE_COUNT ? true : false;
 }
 
+static __rte_always_inline void
+mlx5_hws_cnt_set_age_idx(struct mlx5_hws_cnt *cnt, uint32_t value)
+{
+	union mlx5_hws_cnt_state cnt_state;
+
+	cnt_state.data = rte_atomic_load_explicit(&cnt->cnt_state.data, rte_memory_order_acquire);
+	cnt_state.age_idx = value;
+	rte_atomic_store_explicit(&cnt->cnt_state.data, cnt_state.data, rte_memory_order_release);
+}
+
+static __rte_always_inline void
+mlx5_hws_cnt_set_all(struct mlx5_hws_cnt *cnt, uint32_t in_used, uint32_t share, uint32_t age_idx)
+{
+	union mlx5_hws_cnt_state cnt_state;
+
+	cnt_state.in_used = !!in_used;
+	cnt_state.share = !!share;
+	cnt_state.age_idx = age_idx;
+	rte_atomic_store_explicit(&cnt->cnt_state.data, cnt_state.data, rte_memory_order_relaxed);
+}
+
+static __rte_always_inline void
+mlx5_hws_cnt_get_all(struct mlx5_hws_cnt *cnt, uint32_t *in_used, uint32_t *share,
+		     uint32_t *age_idx)
+{
+	union mlx5_hws_cnt_state cnt_state;
+
+	cnt_state.data = rte_atomic_load_explicit(&cnt->cnt_state.data, rte_memory_order_acquire);
+	if (in_used != NULL)
+		*in_used = cnt_state.in_used;
+	if (share != NULL)
+		*share = cnt_state.share;
+	if (age_idx != NULL)
+		*age_idx = cnt_state.age_idx;
+}
+
 /**
  * Generate Counter id from internal index.
  *
@@ -424,9 +463,10 @@ mlx5_hws_cnt_pool_put(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 
 	hpool = mlx5_hws_cnt_host_pool(cpool);
 	iidx = mlx5_hws_cnt_iidx(hpool, *cnt_id);
-	hpool->pool[iidx].in_used = false;
-	hpool->pool[iidx].query_gen_when_free =
-		rte_atomic_load_explicit(&hpool->query_gen, rte_memory_order_relaxed);
+	mlx5_hws_cnt_set_all(&hpool->pool[iidx], 0, 0, 0);
+	rte_atomic_store_explicit(&hpool->pool[iidx].query_gen_when_free,
+		rte_atomic_load_explicit(&hpool->query_gen, rte_memory_order_relaxed),
+		rte_memory_order_relaxed);
 	if (likely(queue != NULL) && cpool->cfg.host_cpool == NULL)
 		qcache = hpool->cache->qcache[*queue];
 	if (unlikely(qcache == NULL)) {
@@ -480,7 +520,7 @@ mlx5_hws_cnt_pool_put(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
  */
 static __rte_always_inline int
 mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
-		      cnt_id_t *cnt_id, uint32_t age_idx)
+		      cnt_id_t *cnt_id, uint32_t age_idx, uint32_t shared)
 {
 	unsigned int ret;
 	struct rte_ring_zc_data zcdc = {0};
@@ -508,10 +548,7 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 		__hws_cnt_query_raw(cpool, *cnt_id,
 				    &cpool->pool[iidx].reset.hits,
 				    &cpool->pool[iidx].reset.bytes);
-		cpool->pool[iidx].share = 0;
-		MLX5_ASSERT(!cpool->pool[iidx].in_used);
-		cpool->pool[iidx].in_used = true;
-		cpool->pool[iidx].age_idx = age_idx;
+		mlx5_hws_cnt_set_all(&cpool->pool[iidx], 1, shared, age_idx);
 		return 0;
 	}
 	ret = rte_ring_dequeue_zc_burst_elem_start(qcache, sizeof(cnt_id_t), 1,
@@ -530,8 +567,10 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 	/* get one from local cache. */
 	*cnt_id = (*(cnt_id_t *)zcdc.ptr1);
 	iidx = mlx5_hws_cnt_iidx(cpool, *cnt_id);
-	query_gen = cpool->pool[iidx].query_gen_when_free;
-	if (cpool->query_gen == query_gen) { /* counter is waiting to reset. */
+	query_gen = rte_atomic_load_explicit(&cpool->pool[iidx].query_gen_when_free,
+			rte_memory_order_relaxed);
+	/* counter is waiting to reset. */
+	if (rte_atomic_load_explicit(&cpool->query_gen, rte_memory_order_relaxed) == query_gen) {
 		rte_ring_dequeue_zc_elem_finish(qcache, 0);
 		/* write-back counter to reset list. */
 		mlx5_hws_cnt_pool_cache_flush(cpool, *queue);
@@ -549,10 +588,7 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 	__hws_cnt_query_raw(cpool, *cnt_id, &cpool->pool[iidx].reset.hits,
 			    &cpool->pool[iidx].reset.bytes);
 	rte_ring_dequeue_zc_elem_finish(qcache, 1);
-	cpool->pool[iidx].share = 0;
-	MLX5_ASSERT(!cpool->pool[iidx].in_used);
-	cpool->pool[iidx].in_used = true;
-	cpool->pool[iidx].age_idx = age_idx;
+	mlx5_hws_cnt_set_all(&cpool->pool[iidx], 1, shared, age_idx);
 	return 0;
 }
 
@@ -611,24 +647,15 @@ mlx5_hws_cnt_shared_get(struct mlx5_hws_cnt_pool *cpool, cnt_id_t *cnt_id,
 			uint32_t age_idx)
 {
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
-	uint32_t iidx;
-	int ret;
 
-	ret = mlx5_hws_cnt_pool_get(hpool, NULL, cnt_id, age_idx);
-	if (ret != 0)
-		return ret;
-	iidx = mlx5_hws_cnt_iidx(hpool, *cnt_id);
-	hpool->pool[iidx].share = 1;
-	return 0;
+	return mlx5_hws_cnt_pool_get(hpool, NULL, cnt_id, age_idx, 1);
 }
 
 static __rte_always_inline void
 mlx5_hws_cnt_shared_put(struct mlx5_hws_cnt_pool *cpool, cnt_id_t *cnt_id)
 {
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
-	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, *cnt_id);
 
-	hpool->pool[iidx].share = 0;
 	mlx5_hws_cnt_pool_put(hpool, NULL, cnt_id);
 }
 
@@ -637,8 +664,10 @@ mlx5_hws_cnt_is_shared(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id)
 {
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
+	uint32_t share;
 
-	return hpool->pool[iidx].share ? true : false;
+	mlx5_hws_cnt_get_all(&hpool->pool[iidx], NULL, &share, NULL);
+	return !!share;
 }
 
 static __rte_always_inline void
@@ -648,8 +677,8 @@ mlx5_hws_cnt_age_set(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id,
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
 
-	MLX5_ASSERT(hpool->pool[iidx].share);
-	hpool->pool[iidx].age_idx = age_idx;
+	MLX5_ASSERT(hpool->pool[iidx].cnt_state.share);
+	mlx5_hws_cnt_set_age_idx(&hpool->pool[iidx], age_idx);
 }
 
 static __rte_always_inline uint32_t
@@ -657,9 +686,11 @@ mlx5_hws_cnt_age_get(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id)
 {
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
+	uint32_t age_idx, share;
 
-	MLX5_ASSERT(hpool->pool[iidx].share);
-	return hpool->pool[iidx].age_idx;
+	mlx5_hws_cnt_get_all(&hpool->pool[iidx], NULL, &share, &age_idx);
+	MLX5_ASSERT(share);
+	return age_idx;
 }
 
 static __rte_always_inline cnt_id_t
-- 
2.27.0

