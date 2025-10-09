Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB97CCA471
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 06:31:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B0F9402A3;
	Thu,  9 Oct 2025 08:31:08 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34]) by mails.dpdk.org (Postfix) with ESMTP id 2DFC240277;
 Thu,  9 Oct 2025 08:31:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTbyfhMZAm6yuIa5LeY12KXlrQSAwosR/FA8gPjMVXXFvnAOaAX/Cp+nngEjbqx5SGvA3XqAYlvY/x6FPVGtNmv+XMjsUwVpFz7lTpehFBqHpHK2ZBRvC8j4F3WcAQihA+bvTdDuya5fcpMjrJsLmJnndLa04tXPKoPxbVhyKxnNcgJ965xYrFajrySp0J274sDsNJxAcXCx61U0rUFy1dMutYNCP8mg9XYGBqE6AE1qbd7Vu50p1z3RyFlFHKqoWJ96LDmKAmAqR5EFZ8y5gMYtMB8FPruF/k6t6lGT39M9LvgbZytylJk/91vxz0AkudVpgGXzkrDq8aJV50kNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65rYhvG3lV33z6/UZkP85/vOr14Bc+nY+P5et/erIP0=;
 b=UVj322o27/FtETj/YYAtAUsgvbCjeCM/3uar7RpsnCHE67dD6TMeqtIS3wuK/0Ng5tce8InTVsWGWvnapJlNtVMp560i8GVHMKStYLCsv4GEUS06T7Uio8NjbQ/HOYOCJWCbxansxzrufPHOYSF6JOY+0q2TQvnjvL01HFrSQ/X4Obde81QZt2dq9nRscPkfcnYdFNF7iMwTVc+az2Ogg9rDD2+Pm1uMNMAcjjL1Z0fMady/4sYnLQ60HmZ9HBqF49tpjwF1do8QETiqJpcdk3CJTQZrlZ/SME106lOsbFDD9k1068oi05T//suusKsk2KHZudgyr3rj8zY9g35EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65rYhvG3lV33z6/UZkP85/vOr14Bc+nY+P5et/erIP0=;
 b=ALvJegNBQAicnfzk4eEhJ+fN1/q9z3BhGDPXMkvt2au1JieaIalaCF9bfo2sxlIhJXbFOsXhkI2LFD47lJEJL8MeirvPa4hdaR0cOaRMM5thM+HO4AUnu1dukKHHh41C3tQ/MfdzZkeZSSkbgHifiQYEsNNKaimU+C4tLN4kjvteXbDtSCdDu0e1nG8w9h8ct1Gc1VxRAvfy07sDHXHf7Pos4teaWJGfahteMrcAr4Hn9DbsiZk0KJOO76czc9r7cRoVPWl6vvv3q3PMKj0bPDpw3OFJ9JZHIdkm4EiLDjSW11e0/K0Q14Auo6NEd5hka8P1uS9tMTiujAn6hW9h4g==
Received: from CH2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:5a::11)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 06:31:00 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::8) by CH2PR08CA0001.outlook.office365.com
 (2603:10b6:610:5a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 06:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 06:30:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 23:30:41 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 23:30:38 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <michaelba@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix age checking crash
Date: Thu, 9 Oct 2025 09:29:24 +0300
Message-ID: <20251009062924.138382-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 324cbc5a-1837-4ecb-3aca-08de06fd696d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bicdr7r9fwLhcaYAqKqwLoxTqhyZOa0BXfQ+UsgwIYHfZq7m/Z2gfQg2ppSz?=
 =?us-ascii?Q?X9CwivnAeiFVDw5eHLAaTgsebOu2CRu9l9TrkJ4V/54MNZxgGLKesKpErKDI?=
 =?us-ascii?Q?zyTuTQ2dhjiJkWJcNnz2S/soDqvW53vjUeuXtkD0lpHizRbWYLX1w/B4Ohk4?=
 =?us-ascii?Q?KhqaZwdiYP8R2576iIWYnbY5qo4h+33CRLgkJPre7JMv5re/boadedgGDH9o?=
 =?us-ascii?Q?Dj+AJwTp4vJDwtKAFDzU/WbojjEe0cOMTVCcvS6VQBhKLYN/2JnnL7Co87Fp?=
 =?us-ascii?Q?SM1Y3GkYoO9ddHr7MEuzlitUUeLeD6yHbtfXvc2SDwOq4Yh0tFOdN3wb5XOD?=
 =?us-ascii?Q?BlzkJb4rq7G1nh4pcMQTgPArkG72I0dknIyayvjMf25nriAweUbSw+/JFM3w?=
 =?us-ascii?Q?hKJjmmNTa0rsaci4Pf2sva9OsH/6zcRfM7zSqmoppQoLCId1vIcgmkK+NClt?=
 =?us-ascii?Q?J2Qhz2/nBI1r/5kp5XXR90kBkX90vJEntF/r5SUPxhPWdO3u6TcV3tFlL03B?=
 =?us-ascii?Q?SufRUAWTRfqzzZllIku15kfSPXel+yqJCDOrteJes7jaDDu9F02I8tFmbJ6O?=
 =?us-ascii?Q?gdz1XwU3NxUS7EIsQONaXmp/qBkJprjNBRTBoXst4bqVx2HaUbqyOQbLr5Oc?=
 =?us-ascii?Q?zm6uR8wZWAeEWgXwC8KML5K9hwgZZ7NnY1aiACoUyc1bajb0uAxIuWY8bW1/?=
 =?us-ascii?Q?nBl1t5u3Y7jcqCdBufVcsHCwoyYXBRVsl85yjCC0TzBQv0vk1yCOr/C0B3f8?=
 =?us-ascii?Q?MGAVJgjZ6aWLhbzh1L7DKHD7iVZfURveTuAWROhrvyHGCV6rhAevrtu8dM6Q?=
 =?us-ascii?Q?OPi9n46BVeuPpu9+TIJogBm3OpHzFh6lqmLe5CJf3fTSwHbFzFCMT99S0M+K?=
 =?us-ascii?Q?7iyeIv/ocwHWU0KMj8Xoiqit1CHY8IKxTRhro0iaR22w2UZZ8yaXXmN3UG4w?=
 =?us-ascii?Q?ZI/h71qsgOvkRvC2D4COATuBWOwX4tDaI7bx4U5UosxJw2g9/SsN2oMJogC2?=
 =?us-ascii?Q?0QWK2jpBsnuVXPe0v52MwItDlDpmFFOhscHFoOYniXImizwIYpIkOwC/Uysd?=
 =?us-ascii?Q?vb4RQckmUA13Fyv3a4BcpTz3m59FhpBLdDO+F7xXNYH7qKK2lMVZiHVGXZ4t?=
 =?us-ascii?Q?CJ7g2ZPYVdiPcSqw+jbAsJIzV/fItdaxikQmNQUECfDGJFCCFIXlO5KdEHlZ?=
 =?us-ascii?Q?0yLy2jiXQtUiO+EynADHLLNqp412Qow3Q/+y4P9jDrsY/3SDRX2AbQU++MOZ?=
 =?us-ascii?Q?HiC9CjdtCioWnXn6eEcKrcvMKoICLLMVA46ZmGt9eJoZgWNaV7Z7lfzX6ou/?=
 =?us-ascii?Q?q+CcIuSBLdjAaMNXcW4KDnqvmGHlcRQtwjnnh/0gqEvmh0SIY32AXqDif1Ud?=
 =?us-ascii?Q?vbCytfJNmvTCkzWQhAwW/Rzj4f8qx2aYdHa2rZ8rr7cHb8deGUDTn6cRs2D5?=
 =?us-ascii?Q?2AVT9Q2M1MQrwA/uicFgYGTQ5Jwu3pvXTLtWnh7//MjSf7EXNKSch6KcriIl?=
 =?us-ascii?Q?3LDTUQBiZpsJkb8xjY//l1hoBhXKDNcQ9pHa0TIseT94COLpW3GojiyoTCb9?=
 =?us-ascii?Q?qckhfIXAloNNdTJ1v7A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:30:59.6745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324cbc5a-1837-4ecb-3aca-08de06fd696d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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

v2: fix clang compilation error
---
 drivers/net/mlx5/mlx5_flow_hw.c |   5 +-
 drivers/net/mlx5/mlx5_hws_cnt.c |   8 +-
 drivers/net/mlx5/mlx5_hws_cnt.h | 127 ++++++++++++++++++++------------
 3 files changed, 85 insertions(+), 55 deletions(-)

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
index 38a9c19449..6db92a2cb7 100644
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
@@ -424,9 +463,9 @@ mlx5_hws_cnt_pool_put(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 
 	hpool = mlx5_hws_cnt_host_pool(cpool);
 	iidx = mlx5_hws_cnt_iidx(hpool, *cnt_id);
-	hpool->pool[iidx].in_used = false;
+	mlx5_hws_cnt_set_all(&hpool->pool[iidx], 0, 0, 0);
 	hpool->pool[iidx].query_gen_when_free =
-		rte_atomic_load_explicit(&hpool->query_gen, rte_memory_order_relaxed);
+		__atomic_load_n(&hpool->query_gen, __ATOMIC_RELAXED);
 	if (likely(queue != NULL) && cpool->cfg.host_cpool == NULL)
 		qcache = hpool->cache->qcache[*queue];
 	if (unlikely(qcache == NULL)) {
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
@@ -531,7 +567,8 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
 	*cnt_id = (*(cnt_id_t *)zcdc.ptr1);
 	iidx = mlx5_hws_cnt_iidx(cpool, *cnt_id);
 	query_gen = cpool->pool[iidx].query_gen_when_free;
-	if (cpool->query_gen == query_gen) { /* counter is waiting to reset. */
+	/* counter is waiting to reset. */
+	if (__atomic_load_n(&cpool->query_gen, __ATOMIC_RELAXED) == query_gen) {
 		rte_ring_dequeue_zc_elem_finish(qcache, 0);
 		/* write-back counter to reset list. */
 		mlx5_hws_cnt_pool_cache_flush(cpool, *queue);
@@ -549,10 +586,7 @@ mlx5_hws_cnt_pool_get(struct mlx5_hws_cnt_pool *cpool, uint32_t *queue,
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
 
@@ -611,24 +645,15 @@ mlx5_hws_cnt_shared_get(struct mlx5_hws_cnt_pool *cpool, cnt_id_t *cnt_id,
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
 
@@ -637,8 +662,10 @@ mlx5_hws_cnt_is_shared(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id)
 {
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
+	uint32_t share;
 
-	return hpool->pool[iidx].share ? true : false;
+	mlx5_hws_cnt_get_all(&hpool->pool[iidx], NULL, &share, NULL);
+	return !!share;
 }
 
 static __rte_always_inline void
@@ -648,8 +675,8 @@ mlx5_hws_cnt_age_set(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id,
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t iidx = mlx5_hws_cnt_iidx(hpool, cnt_id);
 
-	MLX5_ASSERT(hpool->pool[iidx].share);
-	hpool->pool[iidx].age_idx = age_idx;
+	MLX5_ASSERT(hpool->pool[iidx].cnt_state.share);
+	mlx5_hws_cnt_set_age_idx(&hpool->pool[iidx], age_idx);
 }
 
 static __rte_always_inline uint32_t
@@ -657,9 +684,11 @@ mlx5_hws_cnt_age_get(struct mlx5_hws_cnt_pool *cpool, cnt_id_t cnt_id)
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

