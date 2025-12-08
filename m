Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C7D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 10:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 857D340609;
	Mon,  8 Dec 2025 11:12:39 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by mails.dpdk.org (Postfix) with ESMTP id 43C4E4003C;
 Mon,  8 Dec 2025 11:12:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDBNr+4F16yrKzCajffzVaNb65la/AcKQ1RRbWvL0BJP9wu3VyzoKWKpvAH4B1QDabn3tFgU3rUbrAfIFK7L5vBMYguG4sldGCkh7y2RCCYcE4sBhGHOr1XJ/C8wId6vDw5cOsdgnhuMLxs4GUXkIAgNgOtmsPcoUmliOSWhBk7RB1rO2l0tybyno3AzSBdxLnKLCBD/EPrSBTvsxrS/u2HpxjHdJt2WU5jt9gYsPiFcSiOGr79v7HwsMVa8jTIg1mTVmA4eHYn1jetC/yzY5ZMQCzG5t8SjNPbvZkYZvEfUMICWhIp0BO6IvRCuOo4UMMbSCnaAlMMSRsgPQln2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSwZO5dSRKnYLeK5PybqctUmqp3kwLbNdUKIt5AI7Sk=;
 b=DZpmdLMLtsIynFZkTt0/g0DM0R+PmdRMwoIASwQiHgmWC7K6yF4BmSdPMO6hsqw09B0YS/jS4ypfrU+ngLjReytk8V0vWDIcms59pJeYJdD8m/LB6d4LglNXdNLJNL/Kk/Cf8wq8NlWpiffubcMxCtPbsj6tj8cMNDATLwdVkByuOXOfNRROcn8H7THJz6Ctcp7wzWyWlkU5Yo3d3ZX1HbDAK6zfttMe1VK20Ou1YyLPh2W+DG9MEc8iZRZ4L42sy8KR85o4UJPYJ3HbrivQGeUCu1ENFLYPTYVggQFW7ssOCGCUc6dEcSI+m2KzubqVFvg1ijEAUk1KQZZY9Zm+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSwZO5dSRKnYLeK5PybqctUmqp3kwLbNdUKIt5AI7Sk=;
 b=E5X4PxaB4uwXyNwiUB7h2O9+Pi9Dtx1mModi/s/ufaREe1N2w1hpD4Mv3d6W12thUoDBncUUp4xBL52JMBvVjbXyLUmIq3GCv+JKZ+Vu+NydMJmx3tkKzOLa7bl5tzTIlCXlTjqmBKpKVs2FmtZKomlqsbrz20vnVfnUFGqiUVPMDjzwLM1dtMPMKUxsDbe/cpChC4/mvoN3crSJDz/i+HNYo9nVStENCg1JHNM3okD2WF4vgv5d5CHuYd7Th7K8Ta/dymsk+FkfH12qO3LW5236yQo5kZN2+wbPRNptV5dmfOX0LwvzQA+khtaAmnIP0bXISWeZoPICmt5z42MUfw==
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 8 Dec
 2025 10:12:33 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::f7) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 10:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 10:12:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 02:12:20 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 02:12:17 -0800
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <getelson@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix job leak on indirect meter creation failure
Date: Mon, 8 Dec 2025 12:12:03 +0200
Message-ID: <20251208101203.315647-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 104ba7c8-9699-4bd1-232a-08de36424d71
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Q03Zmr4HgE4ISGjdzeYmqVcUBhxq5H/R70DVOy7DKBcubZw7f/b3MjrkCzl?=
 =?us-ascii?Q?FYR6lvdAK0EBQZkhcohdnf2x0bXpvyfIxr7A4uM4D3uBwcI+dk6YfhQLh2ak?=
 =?us-ascii?Q?QsJ8kMWOW7PobeyYhkd5Wsmbg2cCWXDx9lmq320W2+QUXNUXkSglKju6HACw?=
 =?us-ascii?Q?vRgYZkFAfQTs8uVF5i9sg2BMESDdUl0fpCPwDYIInK5NoJ/s3TsMDL5K7aqp?=
 =?us-ascii?Q?2/hjfHk9C/m21kQ6qwEiCCEGpa7snbAXvJgfmQonvxLDhIkoJzJbkxayED4K?=
 =?us-ascii?Q?vPErV1TvvsEUyyti2MjgIuMQvSuLT+HttoFQmCoGydad8qr5MK9UUwBDhjCL?=
 =?us-ascii?Q?C8yfk5H/LeKSha/Jl+fhfYr9NzgKjqeshcLl626O6ImrX23R1qVSg1y8JhcV?=
 =?us-ascii?Q?ojXsNIjEAVFvrXvc+3ZPTmb/ENgNcEEbUOQCa2lUdyegCVwB84/ZZ1abkQGn?=
 =?us-ascii?Q?LtEM9PWIgrDkxgFmkVLiY1rlHNFtho05nHvEKQJExd5BbZPTK0+AqaaCXSAu?=
 =?us-ascii?Q?Gu3sfOs+j6IYStcqisWUKtmQI/EEbE4jp7s0RvVIaznd1XCwOptjo0hiR5D2?=
 =?us-ascii?Q?KQnyGi+zcHLvSOVZa0tcZIUH5pHc+0wL+ZPx3QP9Qub8IpHcQUUpCSyne6C6?=
 =?us-ascii?Q?3Wd5ABSQooyV4Kee/0Ze6J2zFnxqsrocqjEx98wjO7rU61qt0KT3cuQ6on8s?=
 =?us-ascii?Q?Yd9RhaXn5NvdZCVWKjfq3U+YGK2gl+NkPQPVf1v/hJAmj0yCt1/BlNJVDO2q?=
 =?us-ascii?Q?Vkwjnzw855PLaKZADshc3QcIg/VZ26aMEnVtWcnbQT0Q0kuRNu7P4ZbHGDO5?=
 =?us-ascii?Q?0R2AwJT+YgW77lBX+LBm3LW1Hjj+f+ymZAOpPMevi3irI7ahDtRNjae6fZyr?=
 =?us-ascii?Q?ngbvXlRDgiGzCWuXYMNRks2Bp9dvMw7Cx9qtEKB1Nkn4RPXl8uQ4B9AVyxre?=
 =?us-ascii?Q?d/Fim0Vnjl2uwZ2r4TVlbfZ1TMThrfT2dNsbDvt2S9VDMlr/DZxjpS6MzWsz?=
 =?us-ascii?Q?GXKPP6WlTUFDY7ETFCsTTotOOtQyhV44jgpmN8xQfQFCjIqw8RR/ltQyeuQj?=
 =?us-ascii?Q?AVOtrieb7A1NE4vWzvcjRk98VA52rXOy/QoYVHFV/mYz3gzEn1qh8Uc7WeD0?=
 =?us-ascii?Q?bQaYQgrSFSa9Ghe559Iu9cQ6soRQPZN0uLWZ1sZJb5eYOwXhL38BlBiilCl6?=
 =?us-ascii?Q?vRhiUlbESJ2vTpoWxSNRO1nS2t98Z5IpsO9deAlwDtkxre20agps70kLWU9p?=
 =?us-ascii?Q?LwppMBuXpY7Y4FaXrLXnBgoG48yABOZzXP500rBqsJwjudWkw6WciC61Gken?=
 =?us-ascii?Q?vOPTNLVdXtf6+jFGri34uaVLcKIejyQIGlB4xpFIW4XYwSGs5Xl6bp/uB9wO?=
 =?us-ascii?Q?BHtp+oLC0s0SWzMMSJNF4jM/Zw5vW00TS8rtAxVHGDZN+gTAcr+XaOigEVv1?=
 =?us-ascii?Q?z4xVr6qdIXkt7Uh3QsfffjyGqae/XMSlV9aYqP4fc3QQR0Aa3V4goryC5pfk?=
 =?us-ascii?Q?Smb6Lst6rYCgkan1F1WtiuQSW/hfSTaXNhr7KIiWT+yrnDr//a/JhGLuTa3P?=
 =?us-ascii?Q?TuNo2dChLM0epDr0GXo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:12:32.6726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104ba7c8-9699-4bd1-232a-08de36424d71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
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

Indirect meter_mark action needs to allocate a job to track
asynchronous HW operation to create the meter object.

When meter_mark creation failed, the job may have been leaked
because there was no job cleanup code for sync API.

Add necessary code to check if meter_mark creation failed before or
after HW operation is enqueued and call job_put accordingly.

Fixes: 4359d9d1f76b ("net/mlx5: fix sync meter processing in HWS")
Cc: getelson@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 86 +++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c41b99746f..e1121e74dc 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1870,64 +1870,67 @@ static rte_be32_t vlan_hdr_to_be32(const struct rte_flow_action *actions)
 #endif
 }
 
-static __rte_always_inline struct mlx5_aso_mtr *
+static __rte_always_inline int
 flow_hw_meter_mark_alloc(struct rte_eth_dev *dev, uint32_t queue,
 			 const struct rte_flow_action *action,
 			 struct mlx5_hw_q_job *job, bool push,
+			 struct mlx5_aso_mtr **aso_mtr,
 			 struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_aso_mtr_pool *pool = priv->hws_mpool;
 	const struct rte_flow_action_meter_mark *meter_mark = action->conf;
-	struct mlx5_aso_mtr *aso_mtr;
 	struct mlx5_flow_meter_info *fm;
 	uint32_t mtr_id = 0;
 	uintptr_t handle = (uintptr_t)MLX5_INDIRECT_ACTION_TYPE_METER_MARK <<
 					MLX5_INDIRECT_ACTION_TYPE_OFFSET;
 
-	if (priv->shared_host) {
-		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-				   "Meter mark actions can only be created on the host port");
-		return NULL;
-	}
+	if (priv->shared_host)
+		return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "Meter mark actions can only be created on the host port");
+	MLX5_ASSERT(aso_mtr);
 	if (meter_mark->profile == NULL)
-		return NULL;
-	aso_mtr = mlx5_ipool_malloc(pool->idx_pool, &mtr_id);
-	if (!aso_mtr) {
-		rte_flow_error_set(error, ENOMEM,
-				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				   NULL,
-				   "failed to allocate aso meter entry");
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "No Meter mark profile");
+
+	*aso_mtr = mlx5_ipool_malloc(pool->idx_pool, &mtr_id);
+	if (!*aso_mtr) {
 		if (mtr_id)
 			mlx5_ipool_free(pool->idx_pool, mtr_id);
-		return NULL;
+		return rte_flow_error_set(error, ENOMEM,
+					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					  NULL,
+					  "failed to allocate aso meter entry");
 	}
 	/* Fill the flow meter parameters. */
-	aso_mtr->type = ASO_METER_INDIRECT;
-	fm = &aso_mtr->fm;
+	(*aso_mtr)->type = ASO_METER_INDIRECT;
+	fm = &(*aso_mtr)->fm;
 	fm->meter_id = mtr_id;
 	fm->profile = (struct mlx5_flow_meter_profile *)(meter_mark->profile);
 	fm->is_enable = meter_mark->state;
 	fm->color_aware = meter_mark->color_mode;
-	aso_mtr->pool = pool;
-	aso_mtr->state = (queue == MLX5_HW_INV_QUEUE) ?
+	(*aso_mtr)->pool = pool;
+	(*aso_mtr)->state = (queue == MLX5_HW_INV_QUEUE) ?
 			  ASO_METER_WAIT : ASO_METER_WAIT_ASYNC;
-	aso_mtr->offset = mtr_id - 1;
-	aso_mtr->init_color = fm->color_aware ? RTE_COLORS : RTE_COLOR_GREEN;
+	(*aso_mtr)->offset = mtr_id - 1;
+	(*aso_mtr)->init_color = fm->color_aware ? RTE_COLORS : RTE_COLOR_GREEN;
 	job->action = (void *)(handle | mtr_id);
 	/* Update ASO flow meter by wqe. */
-	if (mlx5_aso_meter_update_by_wqe(priv, queue, aso_mtr,
+	if (mlx5_aso_meter_update_by_wqe(priv, queue, *aso_mtr,
 					 &priv->mtr_bulk, job, push)) {
 		mlx5_ipool_free(pool->idx_pool, mtr_id);
-		return NULL;
+		return rte_flow_error_set(error, EBUSY,
+					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					  NULL,
+					  "Failed to enqueue ASO meter update");
 	}
 	/* Wait for ASO object completion. */
 	if (queue == MLX5_HW_INV_QUEUE &&
-	    mlx5_aso_mtr_wait(priv, aso_mtr, true)) {
+	    mlx5_aso_mtr_wait(priv, *aso_mtr, true)) {
 		mlx5_ipool_free(pool->idx_pool, mtr_id);
-		return NULL;
+		return -EIO;
 	}
-	return aso_mtr;
+	return 0;
 }
 
 static __rte_always_inline int
@@ -1941,20 +1944,22 @@ flow_hw_meter_mark_compile(struct rte_eth_dev *dev,
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_aso_mtr_pool *pool = priv->hws_mpool;
-	struct mlx5_aso_mtr *aso_mtr;
+	struct mlx5_aso_mtr *aso_mtr = NULL;
 	struct mlx5_hw_q_job *job =
 		flow_hw_action_job_init(priv, queue, NULL, NULL, NULL,
 					MLX5_HW_Q_JOB_TYPE_CREATE,
 					MLX5_HW_INDIRECT_TYPE_LEGACY, NULL);
+	int ret;
 
 	if (!job)
 		return -1;
-	aso_mtr = flow_hw_meter_mark_alloc(dev, queue, action, job,
-					   true, error);
-	if (!aso_mtr) {
-		if (queue == MLX5_HW_INV_QUEUE)
-			queue = CTRL_QUEUE_ID(priv);
-		flow_hw_job_put(priv, job, queue);
+	ret = flow_hw_meter_mark_alloc(dev, queue, action, job, true, &aso_mtr, error);
+	if (ret) {
+		if (ret != -EIO) {
+			if (queue == MLX5_HW_INV_QUEUE)
+				queue = CTRL_QUEUE_ID(priv);
+			flow_hw_job_put(priv, job, queue);
+		}
 		return -1;
 	}
 
@@ -12649,12 +12654,13 @@ flow_hw_action_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 	struct mlx5_hw_q_job *job = NULL;
 	struct mlx5_priv *priv = dev->data->dev_private;
 	const struct rte_flow_action_age *age;
-	struct mlx5_aso_mtr *aso_mtr;
+	struct mlx5_aso_mtr *aso_mtr = NULL;
 	cnt_id_t cnt_id;
 	uint32_t age_idx;
 	bool push = flow_hw_action_push(attr);
 	bool aso = false;
 	bool force_job = action->type == RTE_FLOW_ACTION_TYPE_METER_MARK;
+	int ret;
 
 	if (!mlx5_hw_ctx_validate(dev, error))
 		return NULL;
@@ -12710,9 +12716,15 @@ flow_hw_action_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 		break;
 	case RTE_FLOW_ACTION_TYPE_METER_MARK:
 		aso = true;
-		aso_mtr = flow_hw_meter_mark_alloc(dev, queue, action, job, push, error);
-		if (!aso_mtr)
+		ret = flow_hw_meter_mark_alloc(dev, queue, action, job, push, &aso_mtr, error);
+		if (ret) {
+			if (ret != -EIO) {
+				if (queue == MLX5_HW_INV_QUEUE)
+					queue = CTRL_QUEUE_ID(priv);
+				flow_hw_job_put(priv, job, queue);
+			}
 			break;
+		}
 		handle = (void *)(uintptr_t)job->action;
 		break;
 	case RTE_FLOW_ACTION_TYPE_RSS:
@@ -12728,7 +12740,7 @@ flow_hw_action_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 				   NULL, "action type not supported");
 		break;
 	}
-	if (job && !force_job) {
+	if (job && (!force_job || handle)) {
 		job->action = handle;
 		flow_hw_action_finalize(dev, queue, job, push, aso,
 					handle != NULL);
-- 
2.27.0

