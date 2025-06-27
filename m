Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C8C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D722840A67;
	Fri, 27 Jun 2025 18:38:18 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by mails.dpdk.org (Postfix) with ESMTP id 533F1400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTiC/UsmWJDXhGOo6vaRfsnjFvt0ECLuoiBMAfnC+ZHlZULzTd/+ytVmlPS+K60mJ21eVuASCSlNkBIbnJQBGOTdvJjSmecGE2zpuhz7EnyO7MCFlS5w6Ou480z6QgTpF9XACD9FXzseK7Hhv609N7N3PpGQWgoJ4ei0Mejc5GasXXwJhkpoWMuuYzuel5tUtzulsSgYyQSa9fz/odlQtCq34SaSKGyzjpurqYDEbybKpqINIpmgGxG9aeVRi2pDQzepk+Robd+Ha7cczPfft0a+Oc5LiBwb3SrRDFHyZe6CqMXztL6smcvphHovWDpQtQueMseXeym/OfSSUBal/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtwTYDsilBa5yDaqegMAt3nDEzWFUMtETywDW1WeFgg=;
 b=GcAa1s38bEjWU5Q3XOG2t6/UUOsafXKVKwIYxsxGN1yyCtyNT4SRqdcRqdtnYDvWtURloI/K8ZeD1RgO6VnPZo6gRlk56yA6UwswyORZxvjMYpQXcqMOdWQYY1kkdGFOXd9aWlwD76/c/08PiQKfNuLKm+RuVwrk3phJvOxZNCheOM7qiY3ndMdB8HN9MWZljkyTCRzGpTTeQYcR5NeQ2kUc3c4HHPvstfUauqBrT6mGwm+K6M7JuoCGeAVeZfFW2wrvkymcBZVcZgv5T0/HXlqTrsWjMKb2xidiLsAAC/FXMAdMQnYyZSKdtgoRGUe6C32ce5o4GmtO0z3p4XuhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtwTYDsilBa5yDaqegMAt3nDEzWFUMtETywDW1WeFgg=;
 b=raPuUYKdIwL0evBva+jwtz1N9yA8vXD3i/iUhhWH48ZD1cylGuY8VyR/2lAHkl1HuWdSL5cv0qnYrTnNCcq1pnGbgCZXHwxyJYx8Z5+wAOlSA+l5QRv7quVB5nFsK81YIf8y7lboZpOKxUkZYWvenv2WML615DzTIQGQuyw7rBHL2u1nlZSg46mP+FHtnXU0BVbQiQ+odtazbzToVymrrnERBKpTUxEe6jGF4wIWjEAgP8M6iqF0m2/CHR7Mwyq6T9PeCIzv/ftpMwGl/3/JCav+N00FRQ9BZZFK/Rd0+gQDuTyRp46fbEcGhj6mBXy/cfPSnsPX5kPgYu/nPadZtA==
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 16:38:12 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::f4) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 16:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:38:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 09:37:56 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 09:37:53 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v3 1/5] net/mlx5: add new devarg for Tx queue consecutive
 memory
Date: Fri, 27 Jun 2025 19:37:25 +0300
Message-ID: <20250627163729.50460-2-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627163729.50460-1-bingz@nvidia.com>
References: <20250623183456.130666-1-bingz@nvidia.com>
 <20250627163729.50460-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab913a0-e34a-41bc-17dc-08ddb5990174
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fB1P3DuiGVrlCCuONhPvWK4Z7T4Kk6LvkXxUuvqXwBAegz/U5JWTVxeNK9MP?=
 =?us-ascii?Q?Qi7hWR9+Sv+rdys9ly/HBGg0RMLZ4seITLSC7fGBrNrdCo+2vcMgqJsHut3g?=
 =?us-ascii?Q?6ZwL1h+0Li3Ga3D80U8a5WEm7mnfBTLeI8+UCaZB16IlrPka26mqbVZQdPXK?=
 =?us-ascii?Q?9822xs7valsUEOKCTJS6JbZghX1Ez/+qLf6vA8EWQ+onzPbvw/lbDZCa6G0W?=
 =?us-ascii?Q?DPYooG3MBS/sMECTO7wHaBcg/TL4RZN7Ao5A8yVywpYhlL8Au1yyUckw0DQ3?=
 =?us-ascii?Q?JDPe06HOTBiVVfDD0GIq8SPS5uiVHVVWNClKPLonQhpSKIDWt3G61ElQHuAS?=
 =?us-ascii?Q?0jnzFeQEESpxdU6yspJLDtXrVpw46gsOylearpTtCoFnvN5jry24a6D5By7x?=
 =?us-ascii?Q?+E22JokYgx3Xe3noUVh+LrfHIyoBFEIXhdfdo09nzbj4NsVSJAdvUJBLVRK0?=
 =?us-ascii?Q?bQNMpkVL5EUS6Yr4o5I7TanAZ/t10xARMLI/F3lcnFfKG8KBIkLLdjStAkRk?=
 =?us-ascii?Q?PWjwqk5QIjrpxzPmuuGGUWS+Htgkm0mXjNyL+YdXlgstLtjxJQ0ycVg2Azjj?=
 =?us-ascii?Q?aIy5qVbzD1BS/9dZi19G2Ic5uf8IBOOmTtJVG7/yfkweytaIIR+bH05m/J/R?=
 =?us-ascii?Q?ZeeirwuHirzctRfvyN5jYRjwLcFNc4FppQiWYWebJHOut6pN76kIj0ajBl0K?=
 =?us-ascii?Q?XDiV3ttgUFfN91mwD/mPQXTbdHUHSr0QeCMlFj1YOEty29EAvrfUnscxEIFj?=
 =?us-ascii?Q?uP54eAGvR9pLkhKK+ETPmi3932qAqJpGxNJlx4yvTrbFaA0cFxeE49ty7j9k?=
 =?us-ascii?Q?PWJyS7/dn39VqH2qYQiqGHKRwQOAeP8nFbVLBE99tuo87Ak728q8F97UhkFB?=
 =?us-ascii?Q?wy+mQdg+zsPX6xlJp/h1TPcOtA3AYRZ7OpBCM6Kv4DPfZX0Z6UsTQdwQG2lr?=
 =?us-ascii?Q?Zz+eBl5rpNasz7Bbanrxtq6PwbVIO7k6fSpDyCH9D8yADLoOqJH7pKx866FE?=
 =?us-ascii?Q?9kgkir7wJjUGTaduCPiHriZpz0W2KOoR6ZDpl9bPJRezpfnKo7gGeJjVM35w?=
 =?us-ascii?Q?KMNtxN6P+T+ByOTDzSraczDvn3A011IA/70fJLKYO+7EufvgOgWChejSfvdH?=
 =?us-ascii?Q?6CfAY9mvWBvRgqt5DpTjFpZyOdBwCf0xgzms/49VMeTblbe8O/dl3dLIGpBC?=
 =?us-ascii?Q?v3bXFflo0KxYL+aEG5dIYp4oPp9zREsdEPsbyav28gyV2NORIx5OwobhSZbE?=
 =?us-ascii?Q?C4FjPtHFYPS4mlEtvpcOhC0vl6aDCAGtpHM3VyQ13z+JsW3f6yScuo2woQq/?=
 =?us-ascii?Q?J7CkDuzLyFSGVGTnUboD1qhhwSh8dUGJ4PNDMaBbkTsce28QER1vKKAe8zL7?=
 =?us-ascii?Q?MGz8b7zWgMWChD9KJ7Yn0GYdJw5gsp2K6LF3ygG/9mets2KRu9YrIuzcQFAW?=
 =?us-ascii?Q?YfzF8vqTm7QkjIGNcUUWpkmq14AlWx9hqjDNvfQfLpfQxAJoSF4r4k7rdiJ9?=
 =?us-ascii?Q?li0m6xPkQJED7NIYKNgpae2lSxjL2l1uXp7v?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:11.4211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab913a0-e34a-41bc-17dc-08ddb5990174
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

The value is a logarithm value based to 2.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 18 ++++++++++++++++++
 drivers/net/mlx5/mlx5.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5.h  |  7 ++++---
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c1dcb9ca68..82cb06909d 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1682,6 +1682,24 @@ for an additional list of options shared with other mlx5 drivers.
 
   By default, the PMD will set this value to 1.
 
+- ``txq_mem_algn`` parameter [int]
+
+  A The logarithm value to the base 2 for the memory starting
+  address alignment for Tx queues' WQ and associated CQ. Different CPU
+  architectures and generations may have different cache systems. The memory
+  accessing order may impact the cache misses rate on different CPUs. This devarg
+  gives the ability to control the alignment and gaps between TxQs without
+  rebuilding the application binary. User can tune the SW performance by specifying
+  this devarg after benchmark testing on their servers and systems.
+
+  By default, the PMD will set it to log(4096), or log(64*1024) on some specific OS
+  distributions - based on the system page size configuration.
+  All TxQs will use unique memory region and umem area, each TxQs will starting at an
+  address with 4K/64K (default system page size) alignment. If the user's input value is
+  less then the page size, it will be rounded up. If bigger than the maximal queue size,
+  a warning message will be shown, there will be some waste of the memory space. 0 indicates
+  that the legacy per queue memory allocation and separate MRs will be used as before.
+
 
 Multiport E-Switch
 ------------------
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 1bad8a9e90..a167d75aeb 100644
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
+		DRV_LOG(WARNING, "Failed to get page_size, using default 4K size.");
+		alignment = 4 * 1024;
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

