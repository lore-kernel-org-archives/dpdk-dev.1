Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A6C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 411E3402F1;
	Sun, 29 Jun 2025 19:23:40 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by mails.dpdk.org (Postfix) with ESMTP id 9407E402E7
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:23:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UY0ZYDTl+33bmS++XqJRHFos9Q/ksvq5otTCgWCFGB0GpvTuCRzWBP2c2o3XWdHxM3OSiN3wrDxqBNgQJDSgOYTEM0e0+HpzxYsxayFerEry7fQHPmfYI5Iq1+9O1Pdasc1CfWMHJW1pOetoYUbbups52axVc8iGrTvLoCLbbjFSxt2NaL6Pr2MoyfcVlWkHDeHzZEXgIs5UH8ft0mLJqi5A1ojq1GnCOndT8RWJjJBsy0WGePiAPwB69IcTKkIugl75Xd+JD8m0x/DGQ/PLx6WwtCMbYWej5kYk7e2lCzUBRM1uDbFKB+53JOmgXGY1ZaYZTaRuvmw6/lcUoSlAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAqP9c3WspY3xcc4T3aPWB57tmoZR5ZAHjauE5v14kE=;
 b=zShB8ZgAgUeo0SX0vwyjilAe4lFtRp8u2bwOSE6DbrY1PVgnMrdOYbpliXevvhdYqnLcvNIrU3dhhGMNfYPN0C7xkyxAZvDHw80NzLNmCqa4Vh9U0KaMUqfbndUP0o/sPLiJycxWL81nSuWyAXHvzggxriPUcfL2vB1+PayrpubpXe/ZF4Fd1ZXRcFSjqGGq7+MCgIqceeLwvSYVFUQiGFHNF8L2MqYCYF9ffkGbLVBttXzNlkTXNRDFT7yeqpF/DDlLsQO8l4ho/Rh58Cwb6gCPvvdXBYotkdsIHkkvwCXJ3jmH2G//RCUkATyiWhA1zulZ6CGAwQlVi4MUTvW7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAqP9c3WspY3xcc4T3aPWB57tmoZR5ZAHjauE5v14kE=;
 b=amXMUnAgD7ZLGmXEnfJ7asR6KlmNxcfkUyVyumfJrXfziyGYmpXDpD0L5I7U10ZFaxZueUUCPUZ+BxwcoMb51EdJfs62v+aW1htKDKH+Y6rfxw6yEYWykeHy3v2u5ZIROXwyzsYj+VvOD08Tf7UE3UzQlr2rfEABW8ul5XQiHqTuiSEeVRIL1R+BUQRgfANJJ1KudifQs96gxw21SGPGpTLbW9bPAQPrm72q2B3bKLEIofng36bNqZEtq6jdbe0coQzrfJrQVE3Tj6zFwk3EuKD3a564A7MwR5Y9lq6+4Efxg3wUQkozhnAbE/PmdBMgQIrcdOSBY9FdbdZKdWapiw==
Received: from CH2PR12CA0021.namprd12.prod.outlook.com (2603:10b6:610:57::31)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Sun, 29 Jun
 2025 17:23:33 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::b8) by CH2PR12CA0021.outlook.office365.com
 (2603:10b6:610:57::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Sun,
 29 Jun 2025 17:23:33 +0000
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
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:23:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:23:22 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:23:20 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v5 1/5] net/mlx5: add new devarg for Tx queue consecutive
 memory
Date: Sun, 29 Jun 2025 20:22:59 +0300
Message-ID: <20250629172303.72049-2-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629172303.72049-1-bingz@nvidia.com>
References: <20250629170709.69960-1x-bingz@nvidia.com>
 <20250629172303.72049-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fd10b0-734c-462f-7ddd-08ddb731acd6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LTiRXqJmAdXku84xndh+j7DfXbn0XH9k13DeKR7fyoebHUsHJ05MUqrBUGG5?=
 =?us-ascii?Q?oVd1M2RUfi0+Xkw77yVCfchU4fHXnU9PlOi7ZqXRFyvPvLQUTPAcimphzhPt?=
 =?us-ascii?Q?vvflXEkqOsBU83jvtObF5UZ0sZSgRXjc6VxzUBP1OeibhpBlIEIsJQ2Cyb21?=
 =?us-ascii?Q?L+g5ZmV5koakZFh0oMYGPig+3aONcAIxh5Nt3x5QckuEh7Vcn0bDisK+zo43?=
 =?us-ascii?Q?ICTOW2d1sfSJp43wO9ka61pBvE9n8mxTCP6uBHMofI7FmnvVj+2tRa5luizP?=
 =?us-ascii?Q?FTVXTouyzS8qYs2CqPYHOitfL11TT1MgpxqYoeciyAL/a4Rs/NV10PNxSewL?=
 =?us-ascii?Q?1QBf+uL03vqAzq8xlLz24BWZyiIdz0lGL4LxokaloVYJwz1irQb9dQM6UmxU?=
 =?us-ascii?Q?oPTz9xT+ba/YCpR1KljiurSBz3rmttCElV9wEjU3MB2vxVGNtdXJ1d+0N96U?=
 =?us-ascii?Q?N/K57WtPcPgsG8FiKLNbcHArZ5iwceX2U7tMjnn+PvvBDzN1pv6xm3TfceuT?=
 =?us-ascii?Q?xZ8Aba9CI+qH+gcksKGdQ2zH2vpyB2fKZa+GzeWUUZ48yoObmDYfK33UG/Cs?=
 =?us-ascii?Q?7sTl8FASyOhxjfPkGfhtkfqgugDBL8M6RNtG0HhGYdRKg7DS+S7O2T6sHDrL?=
 =?us-ascii?Q?EO82+KDJ/WHQlFKxPex8LJo2dUw+mfnsiMUGTG/cSCge/6CR/CeqkfBl7GoO?=
 =?us-ascii?Q?1p01xqlK+LgAaRf/Zbrt0UcAM/sd0r7bIPR3yITGZwelo9D4hEYK3JhhkH76?=
 =?us-ascii?Q?JBR2P07rBT3dfvnKjNEL3IIMPPompJk/jnE/T7exurnLb8r77Ou70fmtvqGc?=
 =?us-ascii?Q?oBzqF9K4prLkwURq6QvRU4F+EVXD7qJVYfe757tt9DrHSV1hGUeJ27BighzF?=
 =?us-ascii?Q?+p3dLM3KOcj7ZN/4yX6oEHMeENchGlZcs3LUCPBAAVyMNq1xTXuLg+MnkwCi?=
 =?us-ascii?Q?/4QuBpVlA4lSRG3BnHq+v3gecG5bQFetzAw2I5aIZuOc5UCCI/WTzj5epBb0?=
 =?us-ascii?Q?cLjHhdP2m2K8OZJqFSK6cQipgh+8Y/hvYNW+HfwgbTakVG7nFTiOMK9lP7k9?=
 =?us-ascii?Q?WqEwNVR5rjAbZY9dqgWmY9CM6JrHmlrAZPX0HMJJRDeYsFN7tiUvXVxMpKfj?=
 =?us-ascii?Q?09vR5RwkBSNiewSwDRRxHO07Ytd3pSbbvwg2zefvyxXw3L3hqVXoKXmLdQvp?=
 =?us-ascii?Q?K7su7cvIo9bqup5s2hN1JmsrJ2kxHPWZb4+7Oy1vNlZQh+DCSgJZurKyiO7T?=
 =?us-ascii?Q?xy8ObOCmpIJiym2zMzxQkG8pC9fOeTUSsP0HNFznDhaJQXavEO79AsCnvp44?=
 =?us-ascii?Q?TcKsCQy6iFHA3lRDLtC+7MjpOBSS/fGjS0Nyxfr9r4dK+4+MUyFWkvpChElE?=
 =?us-ascii?Q?X8QE9+XSB7+W4KuWRZ/mLCCiZxflqWDVao0+lcI0V+73TmqWYlUoC0rPJYdh?=
 =?us-ascii?Q?OtkRH9JWvOKqNXn5aM2DNFl7o6TlCg2xxnwQbyKMav7Mv6fu8vwyuiVHRTMh?=
 =?us-ascii?Q?QvOjirhI65LNPn8oHXOLUvftmYQBVLT5iS8I?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:23:33.5961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fd10b0-734c-462f-7ddd-08ddb731acd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

