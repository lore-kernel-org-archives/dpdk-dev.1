Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A0CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 447E1402C9;
	Mon, 17 Nov 2025 08:16:08 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by mails.dpdk.org (Postfix) with ESMTP id A8099402A1;
 Mon, 17 Nov 2025 08:16:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efTe0QSQEdC05WPV0JCHQ2PaCFixNQwta9LX7f/ZyTDR5M6KrEwfEkcf42sCxarKVAqXuf+iF2nvoeue0QRF7M7l9IhmIx4w1XqP6vFkjcfYFoOj9h+XvFhIBV7YyRrpffe2qfH+IPX7pH1UK+GLmHKMcaBdBwgOFfe7WNwcUqX592aX2h9VG6RH/2sg9Zhcp905DLXaAIkB4WJQRsyqefjo7+an6KMZRqeuV2ic8iEouk/AHspj9Qs+4c/49WuhBwvxvmWeiVxqQNEGDz6vsV1aIwadoxicz6UKF53hZUmu3CiYdc0e4T5Rw9l1znywst1BGz5pDXqpzSj7KA4WSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG/9kwzB8jWRXzuRqDUFNJZMCUJ/+61GB7miR4lX4rQ=;
 b=pFEkNNpYi7jB+HKIK8RCC0+hUo/1+0WEigik1cL50NxMAgYc3Ijv2cYC0DgttnlguxcfJ+8uTNqBDS4zbiaZrBLs1jbO/NJMlBZ6Qkf+jk8xv3yGCZ/hhmQFb71naE64NvQZ54V4vMiNtduRr6R7Z0AROHuq3I+o07tnPFXqEiI78PrtybMJtpD6mNwQcW6NT0fF5WGXr+ull7VU14unMrvrcoJntPeGJxKnfQvhtvno3/ydAUDkSAd9Y1SKwYpWttCo8P8L11cqqBx0TbvM35vZzA+I4/D+XVIdNUyjrnpExt2Wg1pBpNn8PyeWGmxevOSCsnzWf6WTdglnhxBERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG/9kwzB8jWRXzuRqDUFNJZMCUJ/+61GB7miR4lX4rQ=;
 b=FggWawsOeR3rPT9Gq7UerMIptkXXSh664P9HAGSM8wP6QM8TLCiKlgzr1MyrCYUVBXv2mSzoMgkCM5m0QyNI8iL5iwn5Ouv/9e7OJ7ztqiI8Ig7LszoqrRNp0uaYibTA7C92VA041F3Q7OVs4biaT9SnZY9geIQBb3jtTxTte3C3UlId1llPoHwlYfYi0T6Kq1tBNXduOTL9g0nH8u+s30v0rJ11QMltEa/0v62FXQFaCcIslVum00/0XU7aaBEGxi5zq0NCEeXVsiL2NnjCbLodTP8WZXGGt49+CBoE4sOsRBY2jXyogBWjGo6rxQvy8fpK5PNPSHU4gAlA1ntgsw==
Received: from PH8P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::26)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:16:01 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::e4) by PH8P220CA0016.outlook.office365.com
 (2603:10b6:510:345::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 07:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:16:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:15:43 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:15:42 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 23:15:39 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix segmentation fault in flow destruction path
Date: Mon, 17 Nov 2025 09:15:36 +0200
Message-ID: <20251117071536.205328-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 75763b1d-73d5-491f-1ccd-08de25a9297f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckZWdEM3ZStBWDV4Z3JIdk5oRUErQ2p2YnlzVWxwR28wMm11aXhESkQvY21p?=
 =?utf-8?B?Q1hjZExFYTd0Snh1Ky9SekJjbHE5UWg0U0luZG1lSU1HdVhoZVJMR0FlNEJM?=
 =?utf-8?B?OXJKcUpQdnJKcVRsV0NZOGo0MDA4RHlTUTVzcVlFUDF0MGIyb3BLUTFRdGRx?=
 =?utf-8?B?NE1oc1ZWNkdidURPMm4rTGJzSklnQ2JSQzBMK1N0c3AvOS9Eb0dHVXIrclp1?=
 =?utf-8?B?Y3hsaGU1Tk8rdG8vSjlxQWJJditicUtqMG95ZGJRblZiQkZ4TnhzZ1pLdGl6?=
 =?utf-8?B?NDFuU1JLUjNmY0V2QmVIYndXdGRzU1Z2Nk5qamxwOFR3MEl3ZjNjdk5rSGlD?=
 =?utf-8?B?c1E4YldFT2JnckhuUnhqZ2xianJwRjQwMXgzRU9hSUk2T1N1SzJibVQ3UmpB?=
 =?utf-8?B?MGdjTkxtY1VnVFNOZ3NReW1lOTBHTFhIUUJ1YUpMZzdES096eENNWlVocVFN?=
 =?utf-8?B?UGwyaDBqcllDN2tlTHlIcnFBMFVzWE16TWR4QnhWSHVVSzhYM2ljay9MODBZ?=
 =?utf-8?B?b2UwdkFJdW1DR29BelMzbzJxdU1XZjVjY3ZuZlp4ZEgzQ09TMkRQcnZZcFhW?=
 =?utf-8?B?My9uclpqSGpBM1BBMzFSUGx6dDRTdzdRRlJBVTEyVTlyR1N2TllTTXJhVml1?=
 =?utf-8?B?V2ZmbVd0T1dRVEVEQ25MOTdWNTBZcDdIakJTcVAyTkp6bFNBS2hsVTlrdTdv?=
 =?utf-8?B?TFV1N3N5NVB3WXFjSDRWZmJKWXVkRGk2VTdKTnFQK2NtUnpEWEpLbjA1WXZR?=
 =?utf-8?B?cFVrTGE1SkJQeXoyc2xZOEg2eUN5NUpZVmNMYVAveGk4bW82ZzNJZUdsZ0V2?=
 =?utf-8?B?SGoxY3MyRE9hTm1iR1daZkZ4WEF4SitNbFNuOWxpbGw3NjRDVXNHNEZaNXZR?=
 =?utf-8?B?OWpCcFhuUzRXTlo4eTdXWHNnQTZ0L09CV0lkMmUwV01BT2NVMk9nQzlKbDdG?=
 =?utf-8?B?NTRmM0cyK0xmVktpSEV6OUVmc0c1ZGJ4S2FZclNaTklmVkFSa2FtT2VTd0wr?=
 =?utf-8?B?UExYdVpGcGN3Ym5CNGtXN3NCNGY1K2lqL0l5UWwvaUhhb0U1SExQa3J5eWQ3?=
 =?utf-8?B?aCtTL3oyWGFLUjFoQ2NvL3Z4dUFUc1E0cXZZZUVKNnZqbFB3OWRGc3NGaVRs?=
 =?utf-8?B?OFB1cHB3dlA4Y3lwa0o0aVcwWHBiZmgwQitCT0dBeE4raHZGVE9rTGNHN2pK?=
 =?utf-8?B?N09UeWtGR3FmZnRBVWo0UGpYN3Vza2NJY040UWRXRWFPNE4wbnpaQUM3akh5?=
 =?utf-8?B?aDRpRGxaU3ZTRUFMY2tZTUtCNjZWZ0EyQlp4VitzMUJwa3k4VzRydHRUcWVU?=
 =?utf-8?B?OEd6UzRYQkhGWmkvQWpMT3VkaUROWEp4UldPVWg0MXFhRzFFU3lPYzhXLzVC?=
 =?utf-8?B?VWszQ2JLZ3VJLzg4Uk9uQVJHZ2RXQzYyMi9zdS91L2ZNV1N5NXdyNmtPOHov?=
 =?utf-8?B?ZG95S1VZa0FOTmZ3dThkN3dINjU3R25RMDdBNkhVd3FjTk5wVURITzJiUmVx?=
 =?utf-8?B?MHBINDJqT2VNNHpCNUhrNERmcVJSSzAvNnd4a2xFVUNxbU9QeHpJS2lrZVhh?=
 =?utf-8?B?UE5pQzlOdnF1VE8rSlFlSThaSC9sR3VCSEdQek9uc0hxOXJBTmVGcldUZThN?=
 =?utf-8?B?VU9xc3hlTVI0V1RiZ1l6UENCeTRHTUlvelhXblR3YWpaam9ZRXdPRHk1cko4?=
 =?utf-8?B?YTRSVDNrVUVNMVdWN1QrUlZ5dHJ6djR0VTdSd1FlRG16MmpjZ2c1QXZnR1Bj?=
 =?utf-8?B?ZUk5V0pYRmRSVEJYSnhoRFhmMU1BcE80YjQvcDlkT3lsMW5TcXg3eThqdTcr?=
 =?utf-8?B?eTByTGp1ZkVGTW9OQnZkalZBUjM2azlPZTIzeGpCZ1NlSzlDQkdiMzk0NCtE?=
 =?utf-8?B?SWx2OTh2d3ZmcnRGWm5tWjBDdHBpMjhhMm5vemNJaVdmYTZCa1pTc0hGdTdz?=
 =?utf-8?B?N0dsMjBXVDRDajB0SHhNbU1HSWljZjZBWWluOTVmWGJRV3dneHY4S3Azc2JQ?=
 =?utf-8?B?dDB5b0RwOUFsNmkrUWNMd1QrRmxtRXV4Q2lad3k0YURoeEFqMEFXVHFBY3lv?=
 =?utf-8?B?VS9iK2p6dXMwL01xVXlWd3JIZ0RiWS9idnpKSXdiRnEyNGt1ekFDbjdaaEJ3?=
 =?utf-8?Q?VEfQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:16:00.7976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75763b1d-73d5-491f-1ccd-08de25a9297f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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

The mlx5_ipool_free() function was called with a NULL pool pointer
during HW flow destruction, causing a segmentation fault. This occurred
when flow creation failed and the cleanup path attempted to free
resources from an uninitialized flow pool.

The crash happened in the following scenario:
1. During device start, a default NTA copy action flow is created
2. If the flow creation fails, mlx5_flow_hw_list_destroy() is called
3. In hw_cmpl_flow_update_or_destroy(), table->flow pool could be NULL
4. mlx5_ipool_free(table->flow, flow->idx) was called without checking
   if table->flow is NULL
5. Inside mlx5_ipool_free(), accessing pool->cfg.per_core_cache caused
   a segmentation fault due to NULL pointer dereference

The fix adds two layers of protection,
1. Add NULL check for table->flow before calling mlx5_ipool_free() in
   hw_cmpl_flow_update_or_destroy(), consistent with the existing check
   for table->resource on the previous line
2. Add NULL check for pool parameter in mlx5_ipool_free() as a defensive
   measure to prevent similar crashes in other code paths

The fix also renames the ‘flow’ field in rte_flow_template_table
to ‘flow_pool’ for better code readability.

Stack trace of the fault:
  mlx5_ipool_free (pool=0x0) at mlx5_utils.c:753
  hw_cmpl_flow_update_or_destroy at mlx5_flow_hw.c:4481
  mlx5_flow_hw_destroy at mlx5_flow_hw.c:14219
  mlx5_flow_hw_list_destroy at mlx5_flow_hw.c:14279
  flow_hw_list_create at mlx5_flow_hw.c:14415
  mlx5_flow_start_default at mlx5_flow.c:8263
  mlx5_dev_start at mlx5_trigger.c:1420

Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c | 25 +++++++++++++------------
 drivers/net/mlx5/mlx5_utils.c   |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 83a4adc971f..71e7c1f6bb9 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1744,7 +1744,7 @@ struct rte_flow_template_table {
 	struct rte_flow_pattern_template *its[MLX5_HW_TBL_MAX_ITEM_TEMPLATE];
 	/* Action templates bind to the table. */
 	struct mlx5_hw_action_template ats[MLX5_HW_TBL_MAX_ACTION_TEMPLATE];
-	struct mlx5_indexed_pool *flow; /* The table's flow ipool. */
+	struct mlx5_indexed_pool *flow_pool; /* The table's flow ipool. */
 	struct rte_flow_hw_aux *flow_aux; /**< Auxiliary data stored per flow. */
 	struct mlx5_indexed_pool *resource; /* The table's resource ipool. */
 	struct mlx5_flow_template_table_cfg cfg;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e0f79932a56..52e42422ce7 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3952,7 +3952,7 @@ flow_hw_async_flow_create_generic(struct rte_eth_dev *dev,
 			items, pattern_template_index, actions, action_template_index, error))
 			return NULL;
 	}
-	flow = mlx5_ipool_malloc(table->flow, &flow_idx);
+	flow = mlx5_ipool_malloc(table->flow_pool, &flow_idx);
 	if (!flow) {
 		rte_errno = ENOMEM;
 		goto error;
@@ -4042,7 +4042,7 @@ flow_hw_async_flow_create_generic(struct rte_eth_dev *dev,
 	if (table->resource && res_idx)
 		mlx5_ipool_free(table->resource, res_idx);
 	if (flow_idx)
-		mlx5_ipool_free(table->flow, flow_idx);
+		mlx5_ipool_free(table->flow_pool, flow_idx);
 	if (sub_error.cause != RTE_FLOW_ERROR_TYPE_NONE && error != NULL)
 		*error = sub_error;
 	else
@@ -4492,7 +4492,8 @@ hw_cmpl_flow_update_or_destroy(struct rte_eth_dev *dev,
 		if (!flow->nt_rule) {
 			if (table->resource)
 				mlx5_ipool_free(table->resource, res_idx);
-			mlx5_ipool_free(table->flow, flow->idx);
+			if (table->flow_pool)
+				mlx5_ipool_free(table->flow_pool, flow->idx);
 		}
 	}
 }
@@ -4780,7 +4781,7 @@ flow_hw_q_flow_flush(struct rte_eth_dev *dev,
 	LIST_FOREACH(tbl, &priv->flow_hw_tbl, next) {
 		if (!tbl->cfg.external)
 			continue;
-		MLX5_IPOOL_FOREACH(tbl->flow, fidx, flow) {
+		MLX5_IPOOL_FOREACH(tbl->flow_pool, fidx, flow) {
 			if (flow_hw_async_flow_destroy(dev,
 						MLX5_DEFAULT_FLUSH_QUEUE,
 						&attr,
@@ -5102,8 +5103,8 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 		goto error;
 	tbl->cfg = *table_cfg;
 	/* Allocate flow indexed pool. */
-	tbl->flow = mlx5_ipool_create(&cfg);
-	if (!tbl->flow)
+	tbl->flow_pool = mlx5_ipool_create(&cfg);
+	if (!tbl->flow_pool)
 		goto error;
 	/* Allocate table of auxiliary flow rule structs. */
 	tbl->flow_aux = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct rte_flow_hw_aux) * nb_flows,
@@ -5258,8 +5259,8 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 					      &tbl->grp->entry);
 		if (tbl->flow_aux)
 			mlx5_free(tbl->flow_aux);
-		if (tbl->flow)
-			mlx5_ipool_destroy(tbl->flow);
+		if (tbl->flow_pool)
+			mlx5_ipool_destroy(tbl->flow_pool);
 		mlx5_free(tbl);
 	}
 	if (error != NULL) {
@@ -5489,10 +5490,10 @@ flow_hw_table_destroy(struct rte_eth_dev *dev,
 	/* Build ipool allocated object bitmap. */
 	if (table->resource)
 		mlx5_ipool_flush_cache(table->resource);
-	mlx5_ipool_flush_cache(table->flow);
+	mlx5_ipool_flush_cache(table->flow_pool);
 	/* Check if ipool has allocated objects. */
 	if (table->refcnt ||
-	    mlx5_ipool_get_next(table->flow, &fidx) ||
+	    mlx5_ipool_get_next(table->flow_pool, &fidx) ||
 	    (table->resource && mlx5_ipool_get_next(table->resource, &ridx))) {
 		DRV_LOG(WARNING, "Table %p is still in use.", (void *)table);
 		return rte_flow_error_set(error, EBUSY,
@@ -5522,7 +5523,7 @@ flow_hw_table_destroy(struct rte_eth_dev *dev,
 	if (table->resource)
 		mlx5_ipool_destroy(table->resource);
 	mlx5_free(table->flow_aux);
-	mlx5_ipool_destroy(table->flow);
+	mlx5_ipool_destroy(table->flow_pool);
 	mlx5_free(table);
 	return 0;
 }
@@ -15310,7 +15311,7 @@ flow_hw_table_resize(struct rte_eth_dev *dev,
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 					  table, "shrinking table is not supported");
-	ret = mlx5_ipool_resize(table->flow, nb_flows, error);
+	ret = mlx5_ipool_resize(table->flow_pool, nb_flows, error);
 	if (ret)
 		return ret;
 	/*
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index cba8cc3f490..defcf80dd7d 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -748,7 +748,7 @@ mlx5_ipool_free(struct mlx5_indexed_pool *pool, uint32_t idx)
 	uint32_t trunk_idx;
 	uint32_t entry_idx;
 
-	if (!idx)
+	if (!pool || !idx)
 		return;
 	if (pool->cfg.per_core_cache) {
 		mlx5_ipool_free_cache(pool, idx);
-- 
2.21.0

