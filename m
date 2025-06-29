Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1ECC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECEB04066F;
	Sun, 29 Jun 2025 19:07:49 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by mails.dpdk.org (Postfix) with ESMTP id C892F40687
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTMXz3G7Bf1txPYWjxv/Y+JJrYb6mel5snGqJPtfjUdyB4q7KKBbzEV6sx+b6AYvIGPuceb8pLsYPzptAs4BtVx6fNuyR9/ChU2bEHNclq7oIyko7gq/SxSQaddKOSJHMb7ydPLeC4RqeS3cMVEX+5YQYI5TwYQUmD+uFBewD7qJOfbVP8NjK2AGoNi04ZCOuwJbUvMYlCT46Xfqydb6yRYN4ednluU+7KP0fIUIfobqMRRuW0qo0uB0uNY5/sPGZ4u1EH5lZKD3zsY/ceUyEVkJJonhR8alI8OZSaTJu4XrERL650A69FRF9+rOZyLPWzaXp6eBcHv3FN42FVXPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAqP9c3WspY3xcc4T3aPWB57tmoZR5ZAHjauE5v14kE=;
 b=D+ghMqjxHz+6/8jRGJnvZWLQzMhTg960CoNLIt6C7hmwMA6F/3JXXkIMXAY1JrLVZ8bk4NgPKGhOFNNLI35DBSOzsnqnKmpijKrwmTsK2uTh0ziHq28ZkY2foVme1B2cVCcEwwSlPNqcXGWg0yzC2vR0BztTH/Naet2nOH7Ik88FNoZ5io/N9RNTP2TYZaUDE94meW2Yo6GlIdtQC48wWjYCsnEau94tLtr1UW6Vmf9n0zFvxR3R5jIgX+B7kzSpHQHyXBqvJQlihq1M/Dz7UM8HbD+7c9exdabdMWge8q1w5h3GaLgvG2sajwrcJVBFQjGWcVm4ji6nZJrEZiqEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAqP9c3WspY3xcc4T3aPWB57tmoZR5ZAHjauE5v14kE=;
 b=JmZsUDNkZvC9c40pk2Cwf/ZREvU5k4ov1lOB1sNEIk9rGFhJBcahxmiLakZLQBVYnzu8wtK/WglbAfDcjDiv1N4R7DUpsSegi0UDE45i0zpxUztcb0TWeR4kkFTGVg+wRmCnJtFUgdGyhC23kq6z3kdapw/ixqwJp2rjghTNxGpyiubpw6IhOTqVUnaII8sd4P7i0aj2vxcuzeUodET8ArFw/vEI+s42QooB1zcjPe0RfGc4g21qWqExOupU2Z+IwT9HjoByCqb/CJbYZUonZw1dIgS0C8SdmSfG4Jp0UZWrbfWIimUDBTXk25vek/lSGCD4Qky+XIDCQh0B/WCJtQ==
Received: from BYAPR07CA0059.namprd07.prod.outlook.com (2603:10b6:a03:60::36)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Sun, 29 Jun
 2025 17:07:43 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::4c) by BYAPR07CA0059.outlook.office365.com
 (2603:10b6:a03:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 17:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:07:29 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:07:26 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v4 1/5] net/mlx5: add new devarg for Tx queue consecutive
 memory
Date: Sun, 29 Jun 2025 20:07:05 +0300
Message-ID: <20250629170709.69960-2-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629170709.69960-1-bingz@nvidia.com>
References: <20250627163729.50460-1-bingz@nvidia.com>
 <20250629170709.69960-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa15e0c-1892-4701-925d-08ddb72f75e6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VvR2aKWehZEX9gWpbY9rGeXz9PMO4d3/59Yjx2XQGy8mw2ekeKzYu71SSn3K?=
 =?us-ascii?Q?wm6Q0tsthI4PyhOCdUBPo6hJSHsOsOJVQf/NjZOt4VCRa3OdmRGfYzDtsYo0?=
 =?us-ascii?Q?p3hAzb6+h41BDLuWhbv0MCnXZ/zbfTdGPA0OePUEXWMzgR/vLuMDq1nexa7k?=
 =?us-ascii?Q?fNTJEyjyVeYA0v/9aWgMvuz83l5Jtg94YBeAAd7LMRM+J4eyDOvl0LI7v/Wy?=
 =?us-ascii?Q?OshFBhpoCZ4rc5LPX2beQiMj0/CLc4BUHM9isZpqZfEGQUnUFeY1cFTFBysX?=
 =?us-ascii?Q?+VWDyOUE6rq2qlZj4EE1h0/qc9RKI9DB3HGr6tRffT6A0Qy82x8UGeeLNKNB?=
 =?us-ascii?Q?0FyA9wo8/iFQ0kQcv5KHyD1c80mbA5Nx9a+aFBRh6QK/35Q2k4Bz0jCE+yYD?=
 =?us-ascii?Q?PbGqHZBrDn7E+lyW2DBaG97d4gX+n3tTC7oZ0uXZ5+8l7AiYfgSffmmM1hoD?=
 =?us-ascii?Q?eXfI1Hr8zp8rOLjz2QdYtDXfPUvOTJ7W9lb3G6IrmHN4RkAAUzM6tMSndboV?=
 =?us-ascii?Q?YR+p+oEVLIghCVj74MUqJOC8e5M095pXgyJ5vhcqVRSJSxC+3rcv+xn5PLTF?=
 =?us-ascii?Q?dBFmOUGdVFCwS8wdchkBcysz0VKnkz+i3wHpyw2CIWXA5+kD8/qXi48HxBmB?=
 =?us-ascii?Q?e5esc0SrT7k6EneHlY5hlSuOma371f8AiNX9/faPP/72p7uB44YdJdcN5LKi?=
 =?us-ascii?Q?2Ia5IU35VZWXCKau313hGL0zqU94cuQ9BZIq085XEP88DjBfwyPcaMpM1V+0?=
 =?us-ascii?Q?v7vHDenJqgmPUlBU/KwQ86zD6S1jibCCW5OizdrzBZ/tE9NxLipYxmtBmmM3?=
 =?us-ascii?Q?+Y2aKOwxB2bPdVca9ICaQ6LASqW8tE5485M+vk2nlx8h8YcSrVL+BPHWMSwz?=
 =?us-ascii?Q?8gjZZ/cLKk6oFzZGKXZNEGYOlUu3J2mdOS+qhwvsgUjL7S5s8iyzDi7R176Q?=
 =?us-ascii?Q?JP6j61dXJIEzi+raDo1wGe3ovTfD2pdskE/lZCDuHA451vf1N8Tq/MnWEw/I?=
 =?us-ascii?Q?URBLYuGwc3TwBm2QIVKQcfk5CCC+ljgu/dXAShX6lXNzrqlXZj7LlQOGAtXH?=
 =?us-ascii?Q?+5JKP2hrZ1kgsmnlaQ6Rk8KFtw5tY1lCRlA2j9al70LdHdzhlPBw4Y7O+szG?=
 =?us-ascii?Q?batEHXBPxM5ouNN2DVVrgj0vBCPHdbJFWVNqRC9BvdktM1feRxs8g7vW5nUG?=
 =?us-ascii?Q?FaJcEoGmdIiP0qd0I0GVz1YGow7MrK8lKdJOyStsWTlto6Yq9dJd2zpbezDw?=
 =?us-ascii?Q?o2IXRJdjyLW5Vu3cKTPLWWy63o8GCb5RO6x5OfZKxZ8sIWoPGClARr4+PzFf?=
 =?us-ascii?Q?RDzver9ZBloikl6eSBKm8ajbwZW1ByIoH8TnI+v9F63TReh5fvvsxrMmECp8?=
 =?us-ascii?Q?Rh2JK7JVoITuwDa526vB5SXkyQLmMWEiuZnC45U4gSUrXWnz0NS0UuKdLvcF?=
 =?us-ascii?Q?ObwlyO8zpPbrrfuC2Fx0EAvR/ZTkcCN2VhKzAkzF19D3DMMVEBJnyFm7yAAr?=
 =?us-ascii?Q?VCLaCd9ZKKi6v4G9YWTFXlUNX9qNzuJaM3Oa?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:42.4614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa15e0c-1892-4701-925d-08ddb72f75e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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

With this commit, a new device argument is introduced to control
the memory allocation for Tx queues.

By default, without specifying any value. A default alignment with
system page size will be used. All SQ / CQ memory of Tx queues will
be allocated once and a single umem & MR will be used.

When setting to 0, the legacy way of per queue umem allocation will
be selected in the following commit.

If the value is smaller than the system page size, the starting
address alignment will be rounded up to the page size.

The value is a logarithm value based to 2. Refer to the rst file
change for more details.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 25 +++++++++++++++++++++++++
 drivers/net/mlx5/mlx5.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5.h  |  7 ++++---
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c1dcb9ca68..13e46970ab 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1682,6 +1682,31 @@ for an additional list of options shared with other mlx5 drivers.
 
   By default, the PMD will set this value to 1.
 
+- ``txq_mem_algn`` parameter [int]
+
+  A logarithm base 2 value for the memory starting address alignment
+  for Tx queues' WQ and associated CQ.
+
+  Different CPU architectures and generations may have different cache systems.
+  The memory accessing order may impact the cache misses rate on different CPUs.
+  This devarg gives the ability to control the umem alignment for all TxQs without
+  rebuilding the application binary.
+
+  The performance can be tuned by specifying this devarg after benchmark testing
+  on a specific system and hardware.
+
+  By default, ``txq_mem_algn`` is set to log2(4K), or log2(64K) on some specific OS
+  distributions - based on the system page size configuration.
+  All Tx queues will use a unique memory region and umem area. Each TxQ will start at
+  an address right after the previous one except the 1st queue that will be aligned at
+  the given size of address boundary controlled by this devarg.
+
+  If the value is less then the page size, it will be rounded up.
+  If it is bigger than the maximal queue size, a warning message will appear, there will
+  be some waste of memory at the beginning.
+
+  0 indicates legacy per queue memory allocation and separate Memory Regions (MR).
+
 
 Multiport E-Switch
 ------------------
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 1bad8a9e90..a364e9e421 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -185,6 +185,14 @@
 /* Device parameter to control representor matching in ingress/egress flows with HWS. */
 #define MLX5_REPR_MATCHING_EN "repr_matching_en"
 
+/*
+ * Alignment of the Tx queue starting address,
+ * If not set, using separate umem and MR for each TxQ.
+ * If set, using consecutive memory address and single MR for all Tx queues, each TxQ will start at
+ * the alignment specified.
+ */
+#define MLX5_TXQ_MEM_ALGN "txq_mem_algn"
+
 /* Shared memory between primary and secondary processes. */
 struct mlx5_shared_data *mlx5_shared_data;
 
@@ -1447,6 +1455,8 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 		config->cnt_svc.cycle_time = tmp;
 	} else if (strcmp(MLX5_REPR_MATCHING_EN, key) == 0) {
 		config->repr_matching = !!tmp;
+	} else if (strcmp(MLX5_TXQ_MEM_ALGN, key) == 0) {
+		config->txq_mem_algn = (uint32_t)tmp;
 	}
 	return 0;
 }
@@ -1486,9 +1496,17 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		MLX5_HWS_CNT_SERVICE_CORE,
 		MLX5_HWS_CNT_CYCLE_TIME,
 		MLX5_REPR_MATCHING_EN,
+		MLX5_TXQ_MEM_ALGN,
 		NULL,
 	};
 	int ret = 0;
+	size_t alignment = rte_mem_page_size();
+	uint32_t max_queue_umem_size = MLX5_WQE_SIZE * mlx5_dev_get_max_wq_size(sh);
+
+	if (alignment == (size_t)-1) {
+		alignment = (1 << MLX5_LOG_PAGE_SIZE);
+		DRV_LOG(WARNING, "Failed to get page_size, using default %zu size.", alignment);
+	}
 
 	/* Default configuration. */
 	memset(config, 0, sizeof(*config));
@@ -1501,6 +1519,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
 	config->repr_matching = 1;
+	config->txq_mem_algn = log2above(alignment);
 	if (mkvlist != NULL) {
 		/* Process parameters. */
 		ret = mlx5_kvargs_process(mkvlist, params,
@@ -1567,6 +1586,16 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		config->hw_fcs_strip = 0;
 	else
 		config->hw_fcs_strip = sh->dev_cap.hw_fcs_strip;
+	if (config->txq_mem_algn != 0 && config->txq_mem_algn < log2above(alignment)) {
+		DRV_LOG(WARNING,
+			"\"txq_mem_algn\" too small %u, round up to %u.",
+			config->txq_mem_algn, log2above(alignment));
+		config->txq_mem_algn = log2above(alignment);
+	} else if (config->txq_mem_algn > log2above(max_queue_umem_size)) {
+		DRV_LOG(WARNING,
+			"\"txq_mem_algn\" with value %u bigger than %u.",
+			config->txq_mem_algn, log2above(max_queue_umem_size));
+	}
 	DRV_LOG(DEBUG, "FCS stripping configuration is %ssupported",
 		(config->hw_fcs_strip ? "" : "not "));
 	DRV_LOG(DEBUG, "\"tx_pp\" is %d.", config->tx_pp);
@@ -1584,6 +1613,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		config->allow_duplicate_pattern);
 	DRV_LOG(DEBUG, "\"fdb_def_rule_en\" is %u.", config->fdb_def_rule);
 	DRV_LOG(DEBUG, "\"repr_matching_en\" is %u.", config->repr_matching);
+	DRV_LOG(DEBUG, "\"txq_mem_algn\" is %u.", config->txq_mem_algn);
 	return 0;
 }
 
@@ -3151,6 +3181,12 @@ mlx5_probe_again_args_validate(struct mlx5_common_device *cdev,
 			sh->ibdev_name);
 		goto error;
 	}
+	if (sh->config.txq_mem_algn != config->txq_mem_algn) {
+		DRV_LOG(ERR, "\"TxQ memory alignment\" "
+			"configuration mismatch for shared %s context. %u - %u",
+			sh->ibdev_name, sh->config.txq_mem_algn, config->txq_mem_algn);
+		goto error;
+	}
 	mlx5_free(config);
 	return 0;
 error:
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index f085656196..6b8d29a2bf 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -386,13 +386,14 @@ struct mlx5_sh_config {
 	uint32_t hw_fcs_strip:1; /* FCS stripping is supported. */
 	uint32_t allow_duplicate_pattern:1;
 	uint32_t lro_allowed:1; /* Whether LRO is allowed. */
+	/* Allow/Prevent the duplicate rules pattern. */
+	uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
+	uint32_t repr_matching:1; /* Enable implicit vport matching in HWS FDB. */
+	uint32_t txq_mem_algn; /* logarithm value of the TxQ address alignment. */
 	struct {
 		uint16_t service_core;
 		uint32_t cycle_time; /* query cycle time in milli-second. */
 	} cnt_svc; /* configure for HW steering's counter's service. */
-	/* Allow/Prevent the duplicate rules pattern. */
-	uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
-	uint32_t repr_matching:1; /* Enable implicit vport matching in HWS FDB. */
 };
 
 /* Structure for VF VLAN workaround. */
-- 
2.34.1

