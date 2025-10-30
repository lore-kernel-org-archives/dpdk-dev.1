Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B55CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B795E4026F;
	Thu, 30 Oct 2025 18:25:51 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012042.outbound.protection.outlook.com
 [40.93.195.42]) by mails.dpdk.org (Postfix) with ESMTP id 7064240150;
 Thu, 30 Oct 2025 18:25:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkHT2QpvnxZf0JhaKn409kAXkbqJyYZ41pcUm/Ro0yrYu6YucRkSf/cYAgraXwRIrGlTi4fK1ucGC/RQ3Joi+BsG89KsUY893z5/uR17nOtdNF+x1RcuvOvrRdnpi2LNKrlVGyWBKOJSyHYJfJBYGl7thdLIxuC5h297aA+SX4tbEKdn9vgW+aC1HwImBn+FMvsyIE4eVDb9uB2U3sD/l7t41QoT6hooH+uyjS9mvF5xc2VhGHGCoyFUrhnwMwkuxNYhQgS68clorK5rPv1qqJlrfqnx0UwOszcGCTnvUtbthzG99xHpjSNTvEOVb3xCw0ZrLtZNPfm1K9WAsEhKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA7rU8i52FxAgx8T9PqM+G5yMXtcrXkL78JEMydYsD8=;
 b=sV82lxB7aZ7Q098jadZHOjJ95/BKq1JHwZVBTMy+ouK9yycIcJNcgQvzPHoKyOF3dlT0q6a7WHBXp9+PzMEcJwDy16zeIJzszIf4DRuSHrYDgMzNVp7MAz+zYPuIRJiOdeNzij02ViYBAtPmOrcJ8Ft7tafmscYbjH0mlnbJSBBct5yiFet9SE1KZpIgdQPUugaCw7oLn2nbNPO/TgJSg8AbtYb7uZuZsl9xQUb1F5ZrW7q/i7kDkLLUaLPVnx9E4W0p991OMNGQviMG7Bv0uzMYaN+XclQlWnci6QfCnR+H7BWPSvtmvXFje1V1L98DE7wx/hnIh8lZyPb3Bn61nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA7rU8i52FxAgx8T9PqM+G5yMXtcrXkL78JEMydYsD8=;
 b=qz3vN1wEU3uqJEEt9yioWek8DBldGbXRAYL5MpDLl+SZiwzdT40nkTppoZTcME8zDjtNNyQpgHu6/VhZBr+KvJhdXQwWTBRU2N9PQ68asMu9ZAdlBRbFK94kPwI8vLGh+0BPFwLXeloOkJtEFvAOx3k0g9nPf2XBzbXLLUgQYAJxgwXIc+gjnibH0e8zGZEbWV93ZH15LHRIgA7JhUX3TviPPu2bkmZNU91vU33doSFlP26Wsn1vV3USvLn5it6lrEEM+mea2O1/0mGuVm8QMfJ75FK7J0NxZqk1yjJXoTiyhXDI8jQHyK7pywGhtFwwrnlf3cEngDI9q7TrHShLlA==
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 17:25:43 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::3f) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 17:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:25:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 10:25:22 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 10:25:19 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xiaoyu Min
 <jackmin@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix indirect RSS action hash fields calculation
Date: Thu, 30 Oct 2025 18:24:04 +0100
Message-ID: <20251030172404.1100064-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 32268b3f-d716-4398-b693-08de17d95b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?atvtB4ZZPf5J8A8nDJ7ztWSkQMvST0L8byF0KhEmcfZoRbqEK1LLVTRFYpuC?=
 =?us-ascii?Q?I/K8ZbFgeLzXy5W9Bra0q5FIh8E35NaGaYTGPj/tsJ7AosLiB6e5JHk3VXvg?=
 =?us-ascii?Q?/QUExB3TYEhcEAxNxGTZnqmisrGkzsk/qv6kxC4VruNbYuxGVCkQr9BnpHHC?=
 =?us-ascii?Q?9RBpjOycNYy4nbVaOopNGDM885YGF8tPcsbyY9nzjxZnp+7SIceBFzgW5ke+?=
 =?us-ascii?Q?LUpUIYWKiFmvOBiIVr4Dw0PEzT3RWXmxoyNdsmRcCDXhDbj3VrDaj67gEZGG?=
 =?us-ascii?Q?fsD4OH7nEE/QAZWLK8aSnXRXJ/z/NQw07K01CM4+Wls8VkZZ4esZN4Yzfj/z?=
 =?us-ascii?Q?MsCsIkyAZLhGLuHMVbD7+18E+MIGlDMg5JFMRBA90cTTvl2+pfeJa1Yvs84K?=
 =?us-ascii?Q?80E0wSE6CDJOdfQbhEK5Q4qsnzk9fCGScoOEUFVH3uUD3QoBYDA43EeDVTO8?=
 =?us-ascii?Q?DXCd0J0++kCTjSY60wPSSQzzcqCiU4sG/nKsfjIuB4QpzGsL3PM1Q4/r8xHu?=
 =?us-ascii?Q?cAQaWlSTpZokY7AueRC1dQKc5n/ojawDmTH/zCCESJ53kM26/yUsbprpWFmT?=
 =?us-ascii?Q?7i32LtK09pAug28qBpufssAa/5gf47qIsDn2pxU+ypp7d2k19i+Vi8HT2K87?=
 =?us-ascii?Q?X7KG70WzAJyeSt5fLSYsHnSMpEeNLtmHThcOl3l0PRuR0G4shwrBOXqfcKZ1?=
 =?us-ascii?Q?pZLARojedUdeAepRzDPJ+ro5TDSWLRVPy1AEE24dHzIUp/c4ZFfw+XosQEru?=
 =?us-ascii?Q?X5J8wXReyLffzurDZakFz5Goay/siiLqKjhrVdWngg4s/O5BGO7RUDP08QKZ?=
 =?us-ascii?Q?MIu2aWEcVS+ozWqq+SyHcNQTzalUdmTkOn4Ut8TiP53Edqdc4mr8bQGgC5bD?=
 =?us-ascii?Q?qvnm7jXUf76iV3VYubc0degzXV2bIBuafewT7UiZ0iaIx8P2DoXJ304KpxyU?=
 =?us-ascii?Q?iQ+5HePRNBOQDvGEvoErPm6ggXaNETqHbh37xZPRjSy/akAOJ1aEhMynkxXM?=
 =?us-ascii?Q?Vdj5+E99yRm45KNiYF44lj1SKFO+nSsKVoVNws5zaHzgN3AcBHbAIQr0sTf+?=
 =?us-ascii?Q?jCltXqpa/Xe2a0vSqUV3C9RjqPXUfMXRh0yBh3BpacJsANbNMMtiy7l1pBfk?=
 =?us-ascii?Q?OgTmmwX+c11xXcUtgSiubv1n1kBccmlPaUDHbGlWEyUD+O+IuLAo824QpjuA?=
 =?us-ascii?Q?PUrXy4AY+sJj6y3l9utPStH/myFuuQpT2Qk+eqeKJp8GdL3le+PDKhZsfUK3?=
 =?us-ascii?Q?vME6ZNYBTB4mOq2rxZb3pClhneJfEoK213P5Nzg+innJvDUdQTTiqTk5ZqYJ?=
 =?us-ascii?Q?ez6s9NS+djWJ+Aw5ui7XT6Bea+SleveM9MratgvPyLVYaJF/JvzUpLghe1OX?=
 =?us-ascii?Q?+P6wkPaof9BAlmqWoR4WXkHDzq97HBEFc5C1hok6+QrUH5i0Wq1ORiobpDZv?=
 =?us-ascii?Q?8Yo4Z37HJj2AeuadTjOne90zAlLBxf6xkWETPSvChf2uJdHt9HpfHdIkfV84?=
 =?us-ascii?Q?gD1L2DiTmHKVnL9r2dYTgZnTT8ZXWXPTkFyx7pYVYXARGaA+sKIKrunX9pNf?=
 =?us-ascii?Q?mKhMkkcawoULs4pY/6c=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:25:43.5401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32268b3f-d716-4398-b693-08de17d95b1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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

Whenever indirect RSS flow action is created,
mlx5 PMD creates an hrxq object (abstraction over HW object
used to configure RSS hashing),
for all possible and supported protocols combinations.
For each combination, the hrxq configuration is adjusted
based on RSS hash types provided by the user
(e.g. hash on source L3 address is removed if user passed
RTE_ETH_RSS_L3_SRC_ONLY in hash types).

Function used for adjustment, flow_dv_action_rss_l34_hash_adjust(),
had a bug. If user requested, for example, hashing over both UDP ports
and only IPv6 source address, then RSS hashing was configured
to hash both IPv6 addresses. Adjustment for RTE_ETH_RSS_L3_SRC_ONLY
was skipped.

In HW Steering mode, this resulted in failures to use such indirect
RSS flow action in flow rules created through template flow API.
In this mode, only a single hrxq object is selected during flow rule
creation, based on actual configuration of RSS hash types
in flow action.
Since hrxq was created without applying RTE_ETH_RSS_L3_SRC_ONLY
adjustment and RSS hash types contained RTE_ETH_RSS_L3_SRC_ONLY,
then no matching hrxq could be found, resulting in rule creation failure.

This issue is addressed by the following:

- Missing adjustments are added to flow_dv_action_rss_l34_hash_adjust()
  function.
  This function is reworked to check each protocol type separately,
  instead of using switch case over all combinations.
- Code for setting/looking up hrxq objects based on RSS hash types
  is reworked. Separate switch cases for possible combinations in each
  function are replaced with a single one.
  Additional logging and assertions are added to flag any invalid
  or missing combinations.

Beside that, the existing set of protocols combinations set
did not cover RSS hashing only over UDP or TCP ports,
which is a valid configuration.
These combinations are added in this patch
(new elements in mlx5_rss_hash_fields array).

Fixes: 212d17b6a650 ("net/mlx5: fix missing shared RSS hash types")
Cc: jackmin@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.h         |   2 -
 drivers/net/mlx5/mlx5_flow.c    |  15 ++
 drivers/net/mlx5/mlx5_flow.h    |  38 +--
 drivers/net/mlx5/mlx5_flow_dv.c | 410 +++++++++++++++++++-------------
 4 files changed, 287 insertions(+), 178 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 07418b0922..11fc904619 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1845,8 +1845,6 @@ struct mlx5_obj_ops {
 	void (*lb_dummy_queue_release)(struct rte_eth_dev *dev);
 };

-#define MLX5_RSS_HASH_FIELDS_LEN RTE_DIM(mlx5_rss_hash_fields)
-
 enum mlx5_ctrl_flow_type {
 	MLX5_CTRL_FLOW_TYPE_GENERAL,
 	MLX5_CTRL_FLOW_TYPE_SQ_MISS_ROOT,
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 1de398982a..43595836cf 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -34,6 +34,21 @@
 #include "mlx5_common_os.h"
 #include "rte_pmd_mlx5.h"

+const uint64_t mlx5_rss_hash_fields[] = {
+	[MLX5_RSS_HASH_IDX_IPV4]     = MLX5_RSS_HASH_IPV4,
+	[MLX5_RSS_HASH_IDX_IPV4_TCP] = MLX5_RSS_HASH_IPV4_TCP,
+	[MLX5_RSS_HASH_IDX_IPV4_UDP] = MLX5_RSS_HASH_IPV4_UDP,
+	[MLX5_RSS_HASH_IDX_IPV4_ESP] = MLX5_RSS_HASH_IPV4_ESP,
+	[MLX5_RSS_HASH_IDX_IPV6]     = MLX5_RSS_HASH_IPV6,
+	[MLX5_RSS_HASH_IDX_IPV6_TCP] = MLX5_RSS_HASH_IPV6_TCP,
+	[MLX5_RSS_HASH_IDX_IPV6_UDP] = MLX5_RSS_HASH_IPV6_UDP,
+	[MLX5_RSS_HASH_IDX_IPV6_ESP] = MLX5_RSS_HASH_IPV6_ESP,
+	[MLX5_RSS_HASH_IDX_TCP]      = MLX5_TCP_IBV_RX_HASH,
+	[MLX5_RSS_HASH_IDX_UDP]      = MLX5_UDP_IBV_RX_HASH,
+	[MLX5_RSS_HASH_IDX_ESP_SPI]  = MLX5_RSS_HASH_ESP_SPI,
+	[MLX5_RSS_HASH_IDX_NONE]     = MLX5_RSS_HASH_NONE,
+};
+
 /*
  * Shared array for quick translation between port_id and vport mask/values
  * used for HWS rules.
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..29a40bde2d 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1905,19 +1905,29 @@ flow_hw_get_reg_id_from_ctx(void *dr_ctx, enum rte_flow_item_type type,
 	(_prt) = rte_be_to_cpu_16((_prt));                    \
 } while (0)

-/* array of valid combinations of RX Hash fields for RSS */
-static const uint64_t mlx5_rss_hash_fields[] = {
-	MLX5_RSS_HASH_IPV4,
-	MLX5_RSS_HASH_IPV4_TCP,
-	MLX5_RSS_HASH_IPV4_UDP,
-	MLX5_RSS_HASH_IPV4_ESP,
-	MLX5_RSS_HASH_IPV6,
-	MLX5_RSS_HASH_IPV6_TCP,
-	MLX5_RSS_HASH_IPV6_UDP,
-	MLX5_RSS_HASH_IPV6_ESP,
-	MLX5_RSS_HASH_ESP_SPI,
-	MLX5_RSS_HASH_NONE,
-};
+/**
+ * Each enum variant corresponds to a single valid protocols combination for hrxq configuration
+ * Each variant serves as an index into #mlx5_rss_hash_fields array containing default
+ * bitmaps of ibv_rx_hash_fields flags for given protocols combination.
+ */
+enum {
+	MLX5_RSS_HASH_IDX_IPV4,
+	MLX5_RSS_HASH_IDX_IPV4_TCP,
+	MLX5_RSS_HASH_IDX_IPV4_UDP,
+	MLX5_RSS_HASH_IDX_IPV4_ESP,
+	MLX5_RSS_HASH_IDX_IPV6,
+	MLX5_RSS_HASH_IDX_IPV6_TCP,
+	MLX5_RSS_HASH_IDX_IPV6_UDP,
+	MLX5_RSS_HASH_IDX_IPV6_ESP,
+	MLX5_RSS_HASH_IDX_TCP,
+	MLX5_RSS_HASH_IDX_UDP,
+	MLX5_RSS_HASH_IDX_ESP_SPI,
+	MLX5_RSS_HASH_IDX_NONE,
+	MLX5_RSS_HASH_IDX_MAX,
+};
+
+/** Array of valid combinations of RX Hash fields for RSS. */
+extern const uint64_t mlx5_rss_hash_fields[];

 /* Shared RSS action structure */
 struct mlx5_shared_action_rss {
@@ -1927,7 +1937,7 @@ struct mlx5_shared_action_rss {
 	uint8_t key[MLX5_RSS_HASH_KEY_LEN]; /**< RSS hash key. */
 	struct mlx5_ind_table_obj *ind_tbl;
 	/**< Hash RX queues (hrxq, hrxq_tunnel fields) indirection table. */
-	uint32_t hrxq[MLX5_RSS_HASH_FIELDS_LEN];
+	uint32_t hrxq[MLX5_RSS_HASH_IDX_MAX];
 	/**< Hash RX queue indexes mapped to mlx5_rss_hash_fields */
 	rte_spinlock_t action_rss_sl; /**< Shared RSS action spinlock. */
 };
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index bcce1597e2..83391912dd 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -15788,6 +15788,145 @@ flow_dv_translate(struct rte_eth_dev *dev,
 	return 0;
 }

+/*
+ * Protocol selector bitmap
+ * Each flag is used as an indicator that given protocol is specified in given RSS hash fields.
+ */
+#define RX_HASH_SELECTOR_IPV4 RTE_BIT32(0)
+#define RX_HASH_SELECTOR_IPV6 RTE_BIT32(1)
+#define RX_HASH_SELECTOR_UDP RTE_BIT32(2)
+#define RX_HASH_SELECTOR_TCP RTE_BIT32(3)
+#define RX_HASH_SELECTOR_ESP_SPI RTE_BIT32(4)
+#define RX_HASH_SELECTOR_NONE (0)
+
+#define RX_HASH_SELECTOR_IPV4_TCP (RX_HASH_SELECTOR_IPV4 | RX_HASH_SELECTOR_TCP)
+#define RX_HASH_SELECTOR_IPV4_UDP (RX_HASH_SELECTOR_IPV4 | RX_HASH_SELECTOR_UDP)
+#define RX_HASH_SELECTOR_IPV4_ESP (RX_HASH_SELECTOR_IPV4 | RX_HASH_SELECTOR_ESP_SPI)
+
+#define RX_HASH_SELECTOR_IPV6_TCP (RX_HASH_SELECTOR_IPV6 | RX_HASH_SELECTOR_TCP)
+#define RX_HASH_SELECTOR_IPV6_UDP (RX_HASH_SELECTOR_IPV6 | RX_HASH_SELECTOR_UDP)
+#define RX_HASH_SELECTOR_IPV6_ESP (RX_HASH_SELECTOR_IPV6 | RX_HASH_SELECTOR_ESP_SPI)
+
+static bool
+rx_hash_selector_has_valid_l3(const uint32_t selectors)
+{
+	/* In TIR configuration, RSS hashing on both IPv4 and IPv6 is mutually exclusive. */
+	return !((selectors & RX_HASH_SELECTOR_IPV4) && (selectors & RX_HASH_SELECTOR_IPV6));
+}
+
+static bool
+rx_hash_selector_has_valid_l4(const uint32_t selectors)
+{
+	/* In TIR configuration, RSS hashing on both UDP and TCP is mutually exclusive. */
+	return !((selectors & RX_HASH_SELECTOR_UDP) && (selectors & RX_HASH_SELECTOR_TCP));
+}
+
+static bool
+rx_hash_selector_has_valid_esp(const uint32_t selectors)
+{
+	/* In TIR configuration, RSS hashing on ESP and other L4 protocol is mutually exclusive. */
+	if (selectors & RX_HASH_SELECTOR_ESP_SPI)
+		return !((selectors & RX_HASH_SELECTOR_UDP) || (selectors & RX_HASH_SELECTOR_TCP));
+
+	return true;
+}
+
+/**
+ * Calculate protocol combination based on provided RSS hashing fields.
+ *
+ * @param[in] hash_fields
+ *   Requested RSS hashing fields specified as a flags bitmap, based on ibv_rx_hash_fields.
+ * @param[out] selectors_out
+ *   Calculated protocol combination will be written here.
+ *   Result will be a bitmap of RX_HASH_SELECTOR_* flags.
+ *
+ * @return
+ *   0 if conversion is successful and protocol combination written to @p selectors_out.
+ *   (-EINVAL) otherwise.
+ */
+static int
+rx_hash_calc_selector(const uint64_t hash_fields, uint32_t *selectors_out)
+{
+	const uint64_t filtered_hf = hash_fields & ~IBV_RX_HASH_INNER;
+	uint32_t selectors = 0;
+
+	if (filtered_hf & MLX5_RSS_HASH_IPV4)
+		selectors |= RX_HASH_SELECTOR_IPV4;
+	if (filtered_hf & MLX5_RSS_HASH_IPV6)
+		selectors |= RX_HASH_SELECTOR_IPV6;
+	if (!rx_hash_selector_has_valid_l3(selectors)) {
+		DRV_LOG(NOTICE, "hrxq hashing on both IPv4 and IPv6 is invalid: "
+				"selectors=0x%" PRIx32, selectors);
+		return -EINVAL;
+	}
+
+	if (filtered_hf & MLX5_UDP_IBV_RX_HASH)
+		selectors |= RX_HASH_SELECTOR_UDP;
+	if (filtered_hf & MLX5_TCP_IBV_RX_HASH)
+		selectors |= RX_HASH_SELECTOR_TCP;
+	if (!rx_hash_selector_has_valid_l4(selectors)) {
+		DRV_LOG(NOTICE, "hrxq hashing on both UDP and TCP is invalid: "
+				"selectors=0x%" PRIx32, selectors);
+		return -EINVAL;
+	}
+
+	if (filtered_hf & MLX5_RSS_HASH_ESP_SPI)
+		selectors |= RX_HASH_SELECTOR_ESP_SPI;
+	if (!rx_hash_selector_has_valid_esp(selectors)) {
+		DRV_LOG(NOTICE, "hrxq hashing on ESP SPI and UDP or TCP is mutually exclusive: "
+				"selectors=0x%" PRIx32, selectors);
+		return -EINVAL;
+	}
+
+	*selectors_out = selectors;
+	return 0;
+}
+
+/**
+ * Calculate the hrxq object index based on protocol combination.
+ *
+ * @param[in] selectors
+ *   Protocol combination specified as bitmap of RX_HASH_SELECTOR_* flags.
+ *
+ * @return
+ *   Index into hrxq array in #mlx5_shared_action_rss based on ginve protocol combination.
+ *   (-EINVAL) if given protocol combination is not supported or is invalid.
+ */
+static int
+get_rss_hash_idx(const uint32_t selectors)
+{
+	switch (selectors) {
+	case RX_HASH_SELECTOR_IPV4:
+		return MLX5_RSS_HASH_IDX_IPV4;
+	case RX_HASH_SELECTOR_IPV4_TCP:
+		return MLX5_RSS_HASH_IDX_IPV4_TCP;
+	case RX_HASH_SELECTOR_IPV4_UDP:
+		return MLX5_RSS_HASH_IDX_IPV4_UDP;
+	case RX_HASH_SELECTOR_IPV4_ESP:
+		return MLX5_RSS_HASH_IDX_IPV4_ESP;
+	case RX_HASH_SELECTOR_IPV6:
+		return MLX5_RSS_HASH_IDX_IPV6;
+	case RX_HASH_SELECTOR_IPV6_TCP:
+		return MLX5_RSS_HASH_IDX_IPV6_TCP;
+	case RX_HASH_SELECTOR_IPV6_UDP:
+		return MLX5_RSS_HASH_IDX_IPV6_UDP;
+	case RX_HASH_SELECTOR_IPV6_ESP:
+		return MLX5_RSS_HASH_IDX_IPV6_ESP;
+	case RX_HASH_SELECTOR_TCP:
+		return MLX5_RSS_HASH_IDX_TCP;
+	case RX_HASH_SELECTOR_UDP:
+		return MLX5_RSS_HASH_IDX_UDP;
+	case RX_HASH_SELECTOR_ESP_SPI:
+		return MLX5_RSS_HASH_IDX_ESP_SPI;
+	case RX_HASH_SELECTOR_NONE:
+		return MLX5_RSS_HASH_IDX_NONE;
+	default:
+		DRV_LOG(ERR, "invalid hrxq hash fields combination: "
+			     "selectors=0x%" PRIx32, selectors);
+		return -EINVAL;
+	}
+}
+
 /**
  * Set hash RX queue by hash fields (see enum ibv_rx_hash_fields)
  * and tunnel.
@@ -15795,7 +15934,8 @@ flow_dv_translate(struct rte_eth_dev *dev,
  * @param[in, out] action
  *   Shred RSS action holding hash RX queue objects.
  * @param[in] hash_fields
- *   Defines combination of packet fields to participate in RX hash.
+ *   Defines combination of packet fields to participate in RX hash,
+ *   specified as a bitmap of #ibv_rx_hash_fields flags.
  * @param[in] tunnel
  *   Tunnel type
  * @param[in] hrxq_idx
@@ -15810,65 +15950,26 @@ __flow_dv_action_rss_hrxq_set(struct mlx5_shared_action_rss *action,
 			      uint32_t hrxq_idx)
 {
 	uint32_t *hrxqs = action->hrxq;
+	uint32_t selectors = 0;
+	int ret;

-	switch (hash_fields & ~IBV_RX_HASH_INNER) {
-	case MLX5_RSS_HASH_IPV4:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_SRC_ONLY:
-		hrxqs[0] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV4_TCP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_TCP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_TCP_SRC_ONLY:
-		hrxqs[1] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV4_UDP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_UDP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_UDP_SRC_ONLY:
-		hrxqs[2] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV6:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_SRC_ONLY:
-		hrxqs[3] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV6_TCP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_TCP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_TCP_SRC_ONLY:
-		hrxqs[4] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV6_UDP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_UDP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_UDP_SRC_ONLY:
-		hrxqs[5] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_NONE:
-		hrxqs[6] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV4_ESP:
-		hrxqs[7] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_IPV6_ESP:
-		hrxqs[8] = hrxq_idx;
-		return 0;
-	case MLX5_RSS_HASH_ESP_SPI:
-		hrxqs[9] = hrxq_idx;
-		return 0;
-	default:
-		return -1;
-	}
+	ret = rx_hash_calc_selector(hash_fields, &selectors);
+	/*
+	 * Hash fields passed to this function are constructed internally.
+	 * If this fails, then this is a PMD bug.
+	 */
+	MLX5_ASSERT(ret == 0);
+
+	ret = get_rss_hash_idx(selectors);
+	/*
+	 * Based on above assert, selectors should always yield correct index
+	 * in mlx5_rss_hash_fields array.
+	 * If this fails, then this is a PMD bug.
+	 */
+	MLX5_ASSERT(ret >= 0 && ret < MLX5_RSS_HASH_IDX_MAX);
+	hrxqs[ret] = hrxq_idx;
+
+	return 0;
 }

 /**
@@ -15880,7 +15981,8 @@ __flow_dv_action_rss_hrxq_set(struct mlx5_shared_action_rss *action,
  * @param[in] idx
  *   Shared RSS action ID holding hash RX queue objects.
  * @param[in] hash_fields
- *   Defines combination of packet fields to participate in RX hash.
+ *   Defines combination of packet fields to participate in RX hash,
+ *   specified as a bitmap of #ibv_rx_hash_fields flags.
  * @param[in] tunnel
  *   Tunnel type
  *
@@ -15895,56 +15997,26 @@ flow_dv_action_rss_hrxq_lookup(struct rte_eth_dev *dev, uint32_t idx,
 	struct mlx5_shared_action_rss *shared_rss =
 	    mlx5_ipool_get(priv->sh->ipool[MLX5_IPOOL_RSS_SHARED_ACTIONS], idx);
 	const uint32_t *hrxqs = shared_rss->hrxq;
+	uint32_t selectors = 0;
+	int ret;

-	switch (hash_fields & ~IBV_RX_HASH_INNER) {
-	case MLX5_RSS_HASH_IPV4:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_SRC_ONLY:
-		return hrxqs[0];
-	case MLX5_RSS_HASH_IPV4_TCP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_TCP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_TCP_SRC_ONLY:
-		return hrxqs[1];
-	case MLX5_RSS_HASH_IPV4_UDP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_UDP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV4_UDP_SRC_ONLY:
-		return hrxqs[2];
-	case MLX5_RSS_HASH_IPV6:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_SRC_ONLY:
-		return hrxqs[3];
-	case MLX5_RSS_HASH_IPV6_TCP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_TCP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_TCP_SRC_ONLY:
-		return hrxqs[4];
-	case MLX5_RSS_HASH_IPV6_UDP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_UDP_DST_ONLY:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_UDP_SRC_ONLY:
-		return hrxqs[5];
-	case MLX5_RSS_HASH_NONE:
-		return hrxqs[6];
-	case MLX5_RSS_HASH_IPV4_ESP:
-		return hrxqs[7];
-	case MLX5_RSS_HASH_IPV6_ESP:
-		return hrxqs[8];
-	case MLX5_RSS_HASH_ESP_SPI:
-		return hrxqs[9];
-	default:
+	ret = rx_hash_calc_selector(hash_fields, &selectors);
+	if (ret < 0) {
+		DRV_LOG(ERR, "port %u Rx hash selector calculation failed: "
+			     "rss_act_idx=%u hash_fields=0x%" PRIx64 " selectors=0x%" PRIx32,
+			dev->data->port_id, idx, hash_fields, selectors);
 		return 0;
 	}

+	ret = get_rss_hash_idx(selectors);
+	if (ret < 0) {
+		DRV_LOG(ERR, "port %u failed hrxq index lookup: "
+			     "rss_act_idx=%u hash_fields=0x%" PRIx64 " selectors=0x%" PRIx32,
+			dev->data->port_id, idx, hash_fields, selectors);
+		return 0;
+	}
+
+	return hrxqs[ret];
 }

 /**
@@ -16634,7 +16706,7 @@ flow_dv_destroy(struct rte_eth_dev *dev, struct rte_flow *flow)
  */
 static int
 __flow_dv_hrxqs_release(struct rte_eth_dev *dev,
-			uint32_t (*hrxqs)[MLX5_RSS_HASH_FIELDS_LEN])
+			uint32_t (*hrxqs)[MLX5_RSS_HASH_IDX_MAX])
 {
 	size_t i;
 	int remaining = 0;
@@ -16669,6 +16741,62 @@ __flow_dv_action_rss_hrxqs_release(struct rte_eth_dev *dev,
 	return __flow_dv_hrxqs_release(dev, &shared_rss->hrxq);
 }

+static inline void
+filter_ipv4_types(uint64_t rss_types, uint64_t *hash_fields)
+{
+	if (rss_types & MLX5_IPV4_LAYER_TYPES) {
+		*hash_fields &= ~MLX5_RSS_HASH_IPV4;
+		if (rss_types & RTE_ETH_RSS_L3_DST_ONLY)
+			*hash_fields |= IBV_RX_HASH_DST_IPV4;
+		else if (rss_types & RTE_ETH_RSS_L3_SRC_ONLY)
+			*hash_fields |= IBV_RX_HASH_SRC_IPV4;
+		else
+			*hash_fields |= MLX5_RSS_HASH_IPV4;
+	}
+}
+
+static inline void
+filter_ipv6_types(uint64_t rss_types, uint64_t *hash_fields)
+{
+	if (rss_types & MLX5_IPV6_LAYER_TYPES) {
+		*hash_fields &= ~MLX5_RSS_HASH_IPV6;
+		if (rss_types & RTE_ETH_RSS_L3_DST_ONLY)
+			*hash_fields |= IBV_RX_HASH_DST_IPV6;
+		else if (rss_types & RTE_ETH_RSS_L3_SRC_ONLY)
+			*hash_fields |= IBV_RX_HASH_SRC_IPV6;
+		else
+			*hash_fields |= MLX5_RSS_HASH_IPV6;
+	}
+}
+
+static inline void
+filter_udp_types(uint64_t rss_types, uint64_t *hash_fields)
+{
+	if (rss_types & RTE_ETH_RSS_UDP) {
+		*hash_fields &= ~MLX5_UDP_IBV_RX_HASH;
+		if (rss_types & RTE_ETH_RSS_L4_DST_ONLY)
+			*hash_fields |= IBV_RX_HASH_DST_PORT_UDP;
+		else if (rss_types & RTE_ETH_RSS_L4_SRC_ONLY)
+			*hash_fields |= IBV_RX_HASH_SRC_PORT_UDP;
+		else
+			*hash_fields |= MLX5_UDP_IBV_RX_HASH;
+	}
+}
+
+static inline void
+filter_tcp_types(uint64_t rss_types, uint64_t *hash_fields)
+{
+	if (rss_types & RTE_ETH_RSS_TCP) {
+		*hash_fields &= ~MLX5_TCP_IBV_RX_HASH;
+		if (rss_types & RTE_ETH_RSS_L4_DST_ONLY)
+			*hash_fields |= IBV_RX_HASH_DST_PORT_TCP;
+		else if (rss_types & RTE_ETH_RSS_L4_SRC_ONLY)
+			*hash_fields |= IBV_RX_HASH_SRC_PORT_TCP;
+		else
+			*hash_fields |= MLX5_TCP_IBV_RX_HASH;
+	}
+}
+
 /**
  * Adjust L3/L4 hash value of pre-created shared RSS hrxq according to
  * user input.
@@ -16680,9 +16808,9 @@ __flow_dv_action_rss_hrxqs_release(struct rte_eth_dev *dev,
  * same slot in mlx5_rss_hash_fields.
  *
  * @param[in] orig_rss_types
- *   RSS type as provided in shared RSS action.
+ *   RSS type as provided in shared RSS action, specified as a bitmap of RTE_ETH_RSS_* flags.
  * @param[in, out] hash_field
- *   hash_field variable needed to be adjusted.
+ *   hash_field variable needed to be adjusted, specified as a bitmap of #ibv_rx_hash_fields flags.
  *
  * @return
  *   void
@@ -16691,60 +16819,18 @@ void
 flow_dv_action_rss_l34_hash_adjust(uint64_t orig_rss_types,
 				   uint64_t *hash_field)
 {
+	uint64_t hash_field_protos = *hash_field & ~IBV_RX_HASH_INNER;
 	uint64_t rss_types = rte_eth_rss_hf_refine(orig_rss_types);

-	switch (*hash_field & ~IBV_RX_HASH_INNER) {
-	case MLX5_RSS_HASH_IPV4:
-		if (rss_types & MLX5_IPV4_LAYER_TYPES) {
-			*hash_field &= ~MLX5_RSS_HASH_IPV4;
-			if (rss_types & RTE_ETH_RSS_L3_DST_ONLY)
-				*hash_field |= IBV_RX_HASH_DST_IPV4;
-			else if (rss_types & RTE_ETH_RSS_L3_SRC_ONLY)
-				*hash_field |= IBV_RX_HASH_SRC_IPV4;
-			else
-				*hash_field |= MLX5_RSS_HASH_IPV4;
-		}
-		return;
-	case MLX5_RSS_HASH_IPV6:
-		if (rss_types & MLX5_IPV6_LAYER_TYPES) {
-			*hash_field &= ~MLX5_RSS_HASH_IPV6;
-			if (rss_types & RTE_ETH_RSS_L3_DST_ONLY)
-				*hash_field |= IBV_RX_HASH_DST_IPV6;
-			else if (rss_types & RTE_ETH_RSS_L3_SRC_ONLY)
-				*hash_field |= IBV_RX_HASH_SRC_IPV6;
-			else
-				*hash_field |= MLX5_RSS_HASH_IPV6;
-		}
-		return;
-	case MLX5_RSS_HASH_IPV4_UDP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_UDP:
-		if (rss_types & RTE_ETH_RSS_UDP) {
-			*hash_field &= ~MLX5_UDP_IBV_RX_HASH;
-			if (rss_types & RTE_ETH_RSS_L4_DST_ONLY)
-				*hash_field |= IBV_RX_HASH_DST_PORT_UDP;
-			else if (rss_types & RTE_ETH_RSS_L4_SRC_ONLY)
-				*hash_field |= IBV_RX_HASH_SRC_PORT_UDP;
-			else
-				*hash_field |= MLX5_UDP_IBV_RX_HASH;
-		}
-		return;
-	case MLX5_RSS_HASH_IPV4_TCP:
-		/* fall-through. */
-	case MLX5_RSS_HASH_IPV6_TCP:
-		if (rss_types & RTE_ETH_RSS_TCP) {
-			*hash_field &= ~MLX5_TCP_IBV_RX_HASH;
-			if (rss_types & RTE_ETH_RSS_L4_DST_ONLY)
-				*hash_field |= IBV_RX_HASH_DST_PORT_TCP;
-			else if (rss_types & RTE_ETH_RSS_L4_SRC_ONLY)
-				*hash_field |= IBV_RX_HASH_SRC_PORT_TCP;
-			else
-				*hash_field |= MLX5_TCP_IBV_RX_HASH;
-		}
-		return;
-	default:
-		return;
-	}
+	if (hash_field_protos & MLX5_RSS_HASH_IPV4)
+		filter_ipv4_types(rss_types, hash_field);
+	else if (hash_field_protos & MLX5_RSS_HASH_IPV6)
+		filter_ipv6_types(rss_types, hash_field);
+
+	if (hash_field_protos & MLX5_UDP_IBV_RX_HASH)
+		filter_udp_types(rss_types, hash_field);
+	else if (hash_field_protos & MLX5_TCP_IBV_RX_HASH)
+		filter_tcp_types(rss_types, hash_field);
 }

 /**
@@ -16796,7 +16882,7 @@ __flow_dv_action_rss_setup(struct rte_eth_dev *dev,
 	rss_desc.ind_tbl = shared_rss->ind_tbl;
 	if (priv->sh->config.dv_flow_en == 2)
 		rss_desc.hws_flags = MLX5DR_ACTION_FLAG_HWS_RX;
-	for (i = 0; i < MLX5_RSS_HASH_FIELDS_LEN; i++) {
+	for (i = 0; i < MLX5_RSS_HASH_IDX_MAX; i++) {
 		struct mlx5_hrxq *hrxq;
 		uint64_t hash_fields = mlx5_rss_hash_fields[i];
 		int tunnel = 0;
--
2.39.5

