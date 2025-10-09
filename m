Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421DBCCA470
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 02:30:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C4F0402AE;
	Thu,  9 Oct 2025 04:30:27 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1]) by mails.dpdk.org (Postfix) with ESMTP id 7348C40277;
 Thu,  9 Oct 2025 04:30:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOx/VgaT3IPl3Kz23Bmh8oC1n3nygNbZCeFLvUOGf0laeYacZZFhLKbkYJndcGAYZyaVcmXVOmKo4U9cmn/6hIJ6VmpaWmYrZ5z4zJpdnH3yT2DOA/YMrrf2XwvYAutb458CGXH3NWphMY+YDRKse2JrrN0MgZ6V802EjePTibTv1o4IRL/4onyF2YKGLPsC51tw0gTxVZJQnuoOOva/G2mrz0ir+9gEbh4tscxOq5BLwKJSZmlUW1Zdi5susbMmfZ5wNScSKi4rBEJfIUDamJAqkmCPYkAyZhyAxEeM3lZxD0iXiAKYTbd5BtnL3IAL8exYhylJXi2tAGV6Pj/epQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqPzwQ8Pg/Dhqob8kXD+Uhknb0447B9FMfKkIUMD2FE=;
 b=vLdsWrNx+8Ulp/u4gq5++pfJ0u/YZmDETd+hyl5PX22qidVVUR0kMbG2Eit3XAnKlxzoZHo2K7neSkciQh65xphfCtgaVLuqdwvk8yoqfqn1i9RMC6B8TeV8mpcY1SBuP0aCqCqQXUsQ2GFRMIkQAJDbQ9uAhruDdIdYet+Dc0Hmnm17ILEpFRDyKVo68gwlRt9Lro8UwM7UiEQoH1dZsSLxrif3EXsRPSTUesWpRdItQ9g+Wqmz3uy8DfutvIzF64N7ut5mg9MVXKFNYjh6qgslGSStBnyojIqhMgffRiTEscnIzN5en6l7aNEI6Qmf/7FEvnNfdNk7f6HiUEo6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqPzwQ8Pg/Dhqob8kXD+Uhknb0447B9FMfKkIUMD2FE=;
 b=R4ARuk+nkIsk8CIKA+a6R5tKhk/Kxlbr1hs3pOmEPx5pbPJvTPsWUtWwxHlrLooE6NNlkm8+xg4QvhTIIauPWMOjm+3Gl9flowU0O3bCMpuGh0TYqB+1Dm6YhwNypIMtiFJPihEqJYlghUVi2e/0QUEjyPuYWWkRDqtv29+33BVGOUcDQHXGkOEJyu3lf5j/nPSRyiNer0MCuY6SziMKzWcOozJrJgfo8mUEexrQpZC6yg6inaX3aDnUwOJkstOdyoCuf1HkzNgmOT+AeWkOI6/wFaG8NejHuXicaDps8CGz0MvbSKESg1SD/fBD1irLYs8nCKPo8zo5DazTvQRrig==
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 02:30:18 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::e8) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 02:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 02:30:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 19:30:05 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 19:30:01 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <michaelba@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix age checking crash
Date: Thu, 9 Oct 2025 05:28:46 +0300
Message-ID: <20251009022847.100823-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5381135d-1572-41d9-199b-08de06dbc983
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FSCyIzdhcuYSx0uBW0QDLVsjfMf+0AD44TlyhHGhtXhL9mi/kl6Fv57leE9N?=
 =?us-ascii?Q?cmxXONVFH5wP4i5vj20I4x8oqMUnaguaXYYOD37M9+XqXHRaS5RX+sHPPFiG?=
 =?us-ascii?Q?+5Uczj0I+LNvSJMEnLzt+Q5QCTcb5stnmztyzJyMRlHx78TjAJdhb51Rpk9F?=
 =?us-ascii?Q?3xhxG9YbRCNEyvoZhQZSfotJFW9E22FoySsBIv9wKPlkyo2ydkOGg4c32XfA?=
 =?us-ascii?Q?KpviycSOMm8nqYSYgwJsNg2vh3ESw0zqR1vSRBc9+iYIkOXnYtLqiAaQmwmT?=
 =?us-ascii?Q?g4oNJCOHXiZ3TQVeay0tF2OP6HJ0APWTFUPY2CTLJrvoVljssofVffQ1GJQ7?=
 =?us-ascii?Q?w6ySivQ523TMw1CqZSLhej6lnKeRVQtcqXIcBksmENxe14l+P3RRYmJ3PB14?=
 =?us-ascii?Q?n9voedPzefz1ATkoVcygJvrlYfrXYfhWpTreCiFrxgn4CzR/OywBqpL+qSpZ?=
 =?us-ascii?Q?NWUONIp5XzLXyPutJ812NW62Wx8yAvAN6ta7qFKTsKbN9kP5f4bzZx8Z7qd1?=
 =?us-ascii?Q?VM3C241LUfdMV26tnOP/4RiBAcKfBkWE1ZfM46oyiPZmoi8C2ZCsd/ul442K?=
 =?us-ascii?Q?/GzO4Y99dy8U42DiYf23xqvLVnBXZjgo3jgqi/iIIf0FSVxDFbCHvtMCLtYb?=
 =?us-ascii?Q?5Y2HUkCFEHRWdn+o2K7lZgxDG/J5iTZjr+DFSdeKelSawrTP2zbR6yvFee9r?=
 =?us-ascii?Q?BwNt3BjWg3LXO5IKuAVCT7GMYEeEek/IOrzegfdleEl51lWD6MDJb92g5e/f?=
 =?us-ascii?Q?IN2mNHtt64PDwjrSZclwma7JOl16GR9qDxLXGvx+nc7dVMDW32ixunnP27P6?=
 =?us-ascii?Q?sNODD2E4RNC8blJfABaETlAZi8hZUcVrJstpHxeyIWKUQCutsOvdEMo9bZbc?=
 =?us-ascii?Q?3VEKzcC7Y3h7JMW+3Hzzdv07mqK4slbyA27L7l+k4/4QnJKfHJ+phjekQsw+?=
 =?us-ascii?Q?u3GrBy5ZxqfD/XxVeSBkZlCJ3QTUWjDhtO/y3VMNBwO4mf2I2YvhTmlSUZ/g?=
 =?us-ascii?Q?YlEHIUz56QiGjpzwVaowW1dBqOGkOxAl0g89XD+XuIeDe7pgxu2AL8yvXhdP?=
 =?us-ascii?Q?3T4qNb8Uzhl5QWgk2GxGEcEuDjNjLVR5YhXzTSEtBu4cInk+INhwmcKulyQp?=
 =?us-ascii?Q?IRsyXybwoWHYlpG+9qmFdQDsJEmiToOv5OaHY6hb3WIKbdZaUzbpJD6Fy/jU?=
 =?us-ascii?Q?NlFrMuPycGnbmzAZmE1r2X7w5j8YwpeO0G39Xr5GWTvO8pOo4Rx1nTmS0kju?=
 =?us-ascii?Q?hx1/BMCds4ZFk0vukYKXIUDm/5qTU4BmJTyK5Naz18vBKvGYciP5/9/GsFJ4?=
 =?us-ascii?Q?YSi53iZvSqJ78TfVUyyc0+yLYJgjl10IwR/KXkTeNK+hfutFXT+fHG3c7eJk?=
 =?us-ascii?Q?UKDhHSWNkAyzw3twyxQzKW/o88JE0wHxZ0l4xZoQy6emGuSR0B57LeXL/XO2?=
 =?us-ascii?Q?xV8Sz60WIBDj6xCWeJ6LrSunAqJ6KY+i5+qu/3mTT2GZaZ6BHnKmSO0WM3gg?=
 =?us-ascii?Q?akR0gxU0wQaUpHqoYfbPHSM98k2WK04TL/H+yoFAAuYEu0uYiQTKBFw/Rm2w?=
 =?us-ascii?Q?RmmnkRmdt8dV2mahoeg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 02:30:18.0513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5381135d-1572-41d9-199b-08de06dbc983
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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
---
 drivers/net/mlx5/mlx5_flow_hw.c |   5 +-
 drivers/net/mlx5/mlx5_hws_cnt.c |   8 +--
 drivers/net/mlx5/mlx5_hws_cnt.h | 122 ++++++++++++++++++++------------
 3 files changed, 82 insertions(+), 53 deletions(-)

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
index 5c738f38ca..fdb44f5a32 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -63,8 +63,8 @@ __mlx5_hws_cnt_svc(struct mlx5_dev_ctx_shared *sh,
 	uint32_t ret __rte_unused;
 
 	reset_cnt_num = rte_ring_count(reset_list);
-	cpool->query_gen++;
 	mlx5_aso_cnt_query(sh, cpool);
+	__atomic_store_n(&cpool->query_gen, cpool->query_gen + 1, __ATOMIC_RELEASE);
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
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
index 38a9c19449..5a5b083328 100644
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
+	uint32_t data;
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
+	uint32_t query_gen_when_free;
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
+	cnt_state.data = __atomic_load_n(&cnt->cnt_state.data, __ATOMIC_ACQUIRE);
+	cnt_state.age_idx = value;
+	__atomic_store_n(&cnt->cnt_state.data, cnt_state.data, __ATOMIC_RELEASE);
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
+	__atomic_store_n(&cnt->cnt_state.data, cnt_state.data, __ATOMIC_RELAXED);
+}
+
+static __rte_always_inline void
+mlx5_hws_cnt_get_all(struct mlx5_hws_cnt *cnt, uint32_t *in_used, uint32_t *share,
+		     uint32_t *age_idx)
+{
+	union mlx5_hws_cnt_state cnt_state;
+
+	cnt_state.data = __atomic_load_n(&cnt->cnt_state.data, __ATOMIC_ACQUIRE);
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
@@ -424,7 +463,7 @@ mlx5_hws_cnt_pool_put(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 
 	hpool = mlx5_hws_cnt_host_pool(cpool);
 	iidx = mlx5_hws_cnt_iidx(hpool, *cnt_id);
-	hpool->pool[iidx].in_used = false;
+	mlx5_hws_cnt_set_all(&hpool->pool[iidx], 0, 0, 0);
 	hpool->pool[iidx].query_gen_when_free =
 		rte_atomic_load_explicit(&hpool->query_gen, rte_memory_order_relaxed);
 	if (likely(queue != NULL) && cpool->cfg.host_cpool == NULL)
@@ -480,7 +519,7 @@ mlx5_hws_cnt_pool_put(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
  */
 static __rte_always_inline int
 mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
-		      cnt_id_t *cnt_id, uint32_t age_idx)
+		      cnt_id_t *cnt_id, uint32_t age_idx, uint32_t shared)
 {
 	unsigned int ret;
 	struct rte_ring_zc_data zcdc = {0};
@@ -508,10 +547,7 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
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
@@ -549,10 +585,7 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
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
 
@@ -611,24 +644,15 @@ mlx5_hws_cnt_shared_get(struct mlx5_hws_cnt_pool *cpool, cnt_id_t *cnt_id,
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
 
@@ -637,8 +661,10 @@ mlx5_hws_cnt_is_shared(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id)
 {
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
+	uint32_t share;
 
-	return hpool->pool[iidx].share ? true : false;
+	mlx5_hws_cnt_get_all(&hpool->pool[iidx], NULL, &share, NULL);
+	return !!share;
 }
 
 static __rte_always_inline void
@@ -648,8 +674,8 @@ mlx5_hws_cnt_age_set(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id,
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
 
-	MLX5_ASSERT(hpool->pool[iidx].share);
-	hpool->pool[iidx].age_idx = age_idx;
+	MLX5_ASSERT(hpool->pool[iidx].cnt_state.share);
+	mlx5_hws_cnt_set_age_idx(&hpool->pool[iidx], age_idx);
 }
 
 static __rte_always_inline uint32_t
@@ -657,9 +683,11 @@ mlx5_hws_cnt_age_get(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id)
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

