Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDC5CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 12:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 149104064A;
	Fri, 15 May 2026 14:38:03 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by mails.dpdk.org (Postfix) with ESMTP id 0452E40269;
 Fri, 15 May 2026 14:38:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItvuiRhbwLUlhK7HTKgaoBsRXA/kv9R4YYw99ndELgywMaH27+CtzRZmOtj/79tGHnDdeLtOTaAo5lZ8R8kHWhygPNAL/4RnjvbD4fovjGWmiJlzCiYCynsJQDUAAi8tsZKiBYEdcHTdT1w6gzy/xUV2RozbOUI+W4dcr2smc8o+J1FXvyDKzm4au8gc7Uc0DKfzyfVWgsm6Q/DUR9vdGgaOmG34YCbap7CwE8fVj0PmA6SMJ88mKwDEEOtze+kHV7zEks/x760fWJUOQsdRMwLGKrNoJMmrQWYhnDwDouao17gOznsyn3UxG3NDBYOEpl9BaFJvL0Lr6AMCs+/7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXZ0L+ri6EGqhR2eOLNHR6PhGbojYPGBfNNyXB8SlJs=;
 b=bXax4lHoXHYXcOOGtEj2GvZ4exUdtL2TeR3ZRx/i74P2iu18rFRfARK6l0Yk9gaZ+yb2BgtgaKi7sNr+LTHiXqvjYAvufh2gWmwWi50LSoHvBhdcxJ+pYpl2yp184CFlvBUhqeRHPUw+20dHGnRFY3n5jiY45+uZoGaMydYm7BVfZFWdOHdkpWCvGS/U220V6NvG2hSHfKcA5gkaDMOD7DGataQTBKp6/jJ7ayXQY7eg5jVMM8x0ULlaVxU/S7R3mRTjtjtq5xlSxx39TwcXhDLt5gM5+C2q+/OGaQmkD6PuxxAE40WG3MGScG+mhDtuel2r66AsEwLJ/Wa/o1XC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXZ0L+ri6EGqhR2eOLNHR6PhGbojYPGBfNNyXB8SlJs=;
 b=g+nx/1Pb1TpV2MorqeB1RIqgBZblfi/eAScM98Rd6xVSdTIQAogQO1o8eM+WonfRFrV8/L9X4jgUwQsvwfgJ/u/JhGJs0crkwTMcQNJh72+wMDVfLn5TBCRE6ei52TYGT5Qw4kGdDoxrl7MEH/Bz1SNb+KPZYiwpXz45mpXZoKZxc7rNRfA0O8hT5mslICkI/uj41k4brY+lL4fz7Wz2qrFWHZEU4vJX1THlM5lJv914LfAflLPQy3VEwt8ean9ez/OwPLotl3yF2d/9yTlzgsYqldUM9V2RSkBx+II9UmP9QssELLwgWRY5B9+4zTcA/KKSytXKLVfLjlU1lRMS0w==
Received: from CH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::9) by
 DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.19; Fri, 15 May 2026 12:37:50 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::c6) by CH0P220CA0013.outlook.office365.com
 (2603:10b6:610:ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Fri,
 15 May 2026 12:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 12:37:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:37:24 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:37:22 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: redirect LACP traffic for legacy E-Switch
Date: Fri, 15 May 2026 14:37:00 +0200
Message-ID: <20260515123700.354341-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 834c1e22-291c-4345-d6e1-08deb27ec67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: s/OO+VyMzVX3Dsk4ebU8JeSPxFCPJ4iy0osIEN9tn75aNtYHkHGFXMD9obP45q38gFWjN8y10IOza7EUknH0gAD5LlLxmv6UX5zIyx/c/snWD2QO/aHtZ3hXHOAvbWtQVTeRoXgpJaXaz7tm26qnV7HAfaW67FEQV9os/lQ/E3Rn0w7KG0ikB0BZF4I7fkQWVWfV3Kg4vkGtjhQ3m4vbj3axSgCEMou3KUwndjuFex8fxx7m+kgRTQi80hwYOmgumTY+/3RGHFBLeMyAWGrL8dnS7upN/24A5a8Cyl09U/gfMKKt507ZovcdqrxlEWt3VJNBmk8WmNILpQCP8csrJ+ICiuLhiI3PRBUhDD/xIfmod8iTl4+O3BU5hvo6UtSRUrtSO0CRGATvVVMMzu0xYJ2TUesssyen0l8/RKIlNXu7FSoiRGzk8N+BQg7LkkCh8Q416C6ood1xW5o+xuGkg2Tf3kzBKZVcVA0Sf/A3YwR5yujnUdcNQwcfwcZDwT6EqiV1sDTLVYMtDjZQNSFwoxd/sHjkvgXOia//gYxrGaMa6l0Od4QwoNJn2a3l2r5McYnG3XYGU3ETafbcJs4Oy6sOfSa2rXt6Bs9oZGE4duCDagokomas/U46ubbCPsrxSv/mYZeUeTdkB8RMdAvGkmj9CFXLx7ONgCSOtn4cuqi/mRf+1SVVEMHOuAviuLB9mxMDpbIi1m+bvmf8Ebrfx/zHqejQAh4pS3BEHaOBUAM=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cJPsqpq9HOMtpGhgRywshAsEHqB5lb/LC7rRgCZYfB6B6ts8ywV1bKrx2AccyB53js8Q5MHtfyEb0NfIFWvMD1NEbrqZYGioNAQinTJk414xCj5BTjLCTdI76VzkCda5A6n9ng7LZSx7H0Z2MM4s14wun6WVeey6W9sK/Q7gPfcp5CT5EDyyTCZNmOT3z+D1q35OKanLvFtaZRvtPwyxMdCStjPd8V7RFyRcz4xp0B0oOSSmpOOdjZieEv+0UOkAIeti56R0xj8i2Xl47MLlW9LOjVHV/L6hJdc2Ve2UXGALEaWF841T3ToIuARxU3SP4n6jhI2hXeAh/Ru8FpZPgS8W9fzJQ+kCMVyIdMsGs1NosX6oo5bAQwBYMGvxeawxJHKwvGJUES39UYiDKWqnyDogo8boBzxIUjnLtE3mjPda0xdFlG079iNENuFG2KEz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:37:49.7261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834c1e22-291c-4345-d6e1-08deb27ec67b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

Offending patch fixed the LACP miss rule logic for NICs where
switchdev is enabled. In this case, LACP miss rules should be inserted
if and only if started port is a main port on the embedded switch.
Side effect of that change was that LACP miss rules are not inserted
when switchdev is disabled and legacy SR-IOV switch mode is used.

This patch addresses that:

- Fix the LACP rule insertion condition.
- Move HWS table for LACP rule creation out of FDB rules,
  so they can be created separately.

Fixes: 87e4384d2662 ("net/mlx5: fix condition of LACP miss flow")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5.h         |   1 +
 drivers/net/mlx5/mlx5_flow.h    |  40 ++++++++-
 drivers/net/mlx5/mlx5_flow_hw.c | 140 ++++++++++++++++++++++++--------
 drivers/net/mlx5/mlx5_trigger.c |   7 +-
 4 files changed, 145 insertions(+), 43 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 49a0c03544..ab5c76bfc4 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2040,6 +2040,7 @@ struct mlx5_priv {
 	rte_spinlock_t hw_ctrl_lock;
 	LIST_HEAD(hw_ctrl_flow, mlx5_ctrl_flow_entry) hw_ctrl_flows;
 	LIST_HEAD(hw_ext_ctrl_flow, mlx5_ctrl_flow_entry) hw_ext_ctrl_flows;
+	struct mlx5_flow_hw_lacp_miss *hw_lacp_miss; /* HWS LACP miss flow tables */
 	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb; /* FDB control flow context */
 	struct mlx5_flow_hw_ctrl_nic *hw_ctrl_nic; /* NIC control flow context */
 	struct rte_flow_pattern_template *hw_tx_repr_tagging_pt;
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index c9e72a33d6..3f5ba55bf9 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3031,6 +3031,13 @@ struct mlx5_flow_hw_ctrl_rx {
 						[MLX5_FLOW_HW_CTRL_RX_EXPANDED_RSS_MAX];
 };
 
+/* Contains all templates and table required for redirecting LACP traffic with HWS. */
+struct mlx5_flow_hw_lacp_miss {
+	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
+	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
+	struct rte_flow_template_table *hw_lacp_rx_tbl;
+};
+
 /* Contains all templates required for control flow rules in FDB with HWS. */
 struct mlx5_flow_hw_ctrl_fdb {
 	struct rte_flow_pattern_template *esw_mgr_items_tmpl;
@@ -3042,9 +3049,6 @@ struct mlx5_flow_hw_ctrl_fdb {
 	struct rte_flow_pattern_template *port_items_tmpl;
 	struct rte_flow_actions_template *jump_one_actions_tmpl;
 	struct rte_flow_template_table *hw_esw_zero_tbl;
-	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
-	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
-	struct rte_flow_template_table *hw_lacp_rx_tbl;
 };
 
 struct mlx5_flow_hw_ctrl_nic {
@@ -3735,6 +3739,36 @@ mlx5_indirect_list_handles_release(struct rte_eth_dev *dev);
 
 bool mlx5_flow_is_steering_disabled(void);
 
+/**
+ * Returns true if Rx control rule for LACP traffic is needed.
+ *
+ * mlx5 PMD needs to create a rule matching LACP traffic and forwarding it back to kernel if:
+ *
+ * - Underlying device is a bond interface.
+ * - User did not request to handle LACP traffic in user space.
+ *
+ * Creation of this rule is also controlled by the E-Switch mode:
+ *
+ * - It must be created in legacy mode.
+ * - It must be created only on proxy port in switchdev mode.
+ *
+ * @param[in] priv
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   True if LACP rules must be created.
+ *   False otherwise.
+ */
+static inline bool
+mlx5_flow_lacp_miss_needed(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	return !priv->sh->config.lacp_by_user &&
+	    priv->pf_bond >= 0 &&
+	    (!priv->sh->esw_mode || (priv->sh->esw_mode && priv->master));
+}
+
 #ifdef HAVE_MLX5_HWS_SUPPORT
 
 #define MLX5_REPR_STC_MEMORY_LOG 11
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index b6bb9f12a6..c133230cb7 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -10820,15 +10820,6 @@ flow_hw_cleanup_ctrl_fdb_tables(struct rte_eth_dev *dev)
 	if (!priv->hw_ctrl_fdb)
 		return;
 	hw_ctrl_fdb = priv->hw_ctrl_fdb;
-	/* Clean up templates used for LACP default miss table. */
-	if (hw_ctrl_fdb->hw_lacp_rx_tbl)
-		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb->hw_lacp_rx_tbl, NULL));
-	if (hw_ctrl_fdb->lacp_rx_actions_tmpl)
-		claim_zero(flow_hw_actions_template_destroy(dev, hw_ctrl_fdb->lacp_rx_actions_tmpl,
-			   NULL));
-	if (hw_ctrl_fdb->lacp_rx_items_tmpl)
-		claim_zero(flow_hw_pattern_template_destroy(dev, hw_ctrl_fdb->lacp_rx_items_tmpl,
-			   NULL));
 	/* Clean up templates used for default FDB jump rule. */
 	if (hw_ctrl_fdb->hw_esw_zero_tbl)
 		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb->hw_esw_zero_tbl, NULL));
@@ -10898,6 +10889,99 @@ flow_hw_create_lacp_rx_table(struct rte_eth_dev *dev,
 	return flow_hw_table_create(dev, &cfg, &it, 1, &at, 1, error);
 }
 
+/*
+ * Clean up templates and table used for redirecting LACP traffic to kernel.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ */
+static void
+flow_hw_cleanup_lacp_miss_tables(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_flow_hw_lacp_miss *hw_lacp_miss;
+
+	if (priv->hw_lacp_miss == NULL)
+		return;
+
+	hw_lacp_miss = priv->hw_lacp_miss;
+
+	if (hw_lacp_miss->hw_lacp_rx_tbl)
+		claim_zero(flow_hw_table_destroy(dev, hw_lacp_miss->hw_lacp_rx_tbl, NULL));
+	if (hw_lacp_miss->lacp_rx_actions_tmpl)
+		claim_zero(flow_hw_actions_template_destroy(dev,
+							    hw_lacp_miss->lacp_rx_actions_tmpl,
+							    NULL));
+	if (hw_lacp_miss->lacp_rx_items_tmpl)
+		claim_zero(flow_hw_pattern_template_destroy(dev,
+							    hw_lacp_miss->lacp_rx_items_tmpl,
+							    NULL));
+
+	mlx5_free(hw_lacp_miss);
+	priv->hw_lacp_miss = NULL;
+}
+
+/*
+ * Create templates and table for redirecting LACP traffic to kernel.
+ *
+ * LACP traffic redirection is needed whenever LACP bond is managed by the kernel.
+ * Required rule has a following structure:
+ *
+ * - ingress rule on root table
+ * - match EtherType 0x8809
+ * - action DEFAULT_MISS
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ *
+ * @return
+ *   0 on success. Negative errno otherwise.
+ */
+static int
+flow_hw_create_lacp_miss_tables(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_flow_hw_lacp_miss *hw_lacp_miss;
+
+	if (mlx5_flow_is_steering_disabled())
+		return 0;
+
+	hw_lacp_miss = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hw_lacp_miss), 0, SOCKET_ID_ANY);
+	if (!hw_lacp_miss) {
+		DRV_LOG(ERR, "port %u Failed to allocate memory for LACP miss tables",
+			dev->data->port_id);
+		return -ENOMEM;
+	}
+	priv->hw_lacp_miss = hw_lacp_miss;
+
+	hw_lacp_miss->lacp_rx_items_tmpl = flow_hw_create_lacp_rx_pattern_template(dev, NULL);
+	if (!hw_lacp_miss->lacp_rx_items_tmpl) {
+		DRV_LOG(ERR, "port %u Failed to create pattern template for LACP Rx traffic",
+			dev->data->port_id);
+		goto error;
+	}
+	hw_lacp_miss->lacp_rx_actions_tmpl = flow_hw_create_lacp_rx_actions_template(dev, NULL);
+	if (!hw_lacp_miss->lacp_rx_actions_tmpl) {
+		DRV_LOG(ERR, "port %u Failed to create actions template for LACP Rx traffic",
+			dev->data->port_id);
+		goto error;
+	}
+	hw_lacp_miss->hw_lacp_rx_tbl =
+		flow_hw_create_lacp_rx_table(dev, hw_lacp_miss->lacp_rx_items_tmpl,
+					     hw_lacp_miss->lacp_rx_actions_tmpl, NULL);
+	if (!hw_lacp_miss->hw_lacp_rx_tbl) {
+		DRV_LOG(ERR, "port %u Failed to create template table for LACP Rx traffic",
+			dev->data->port_id);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	flow_hw_cleanup_lacp_miss_tables(dev);
+	return -EINVAL;
+}
+
 /**
  * Creates a set of flow tables used to create control flows used
  * when E-Switch is engaged.
@@ -11000,31 +11084,6 @@ flow_hw_create_fdb_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *e
 			goto err;
 		}
 	}
-	/* Create LACP default miss table. */
-	if (!priv->sh->config.lacp_by_user && priv->pf_bond >= 0 && priv->master) {
-		hw_ctrl_fdb->lacp_rx_items_tmpl =
-				flow_hw_create_lacp_rx_pattern_template(dev, error);
-		if (!hw_ctrl_fdb->lacp_rx_items_tmpl) {
-			DRV_LOG(ERR, "port %u failed to create pattern template"
-				" for LACP Rx traffic", dev->data->port_id);
-			goto err;
-		}
-		hw_ctrl_fdb->lacp_rx_actions_tmpl =
-				flow_hw_create_lacp_rx_actions_template(dev, error);
-		if (!hw_ctrl_fdb->lacp_rx_actions_tmpl) {
-			DRV_LOG(ERR, "port %u failed to create actions template"
-				" for LACP Rx traffic", dev->data->port_id);
-			goto err;
-		}
-		hw_ctrl_fdb->hw_lacp_rx_tbl = flow_hw_create_lacp_rx_table
-				(dev, hw_ctrl_fdb->lacp_rx_items_tmpl,
-				 hw_ctrl_fdb->lacp_rx_actions_tmpl, error);
-		if (!hw_ctrl_fdb->hw_lacp_rx_tbl) {
-			DRV_LOG(ERR, "port %u failed to create template table for"
-				" for LACP Rx traffic", dev->data->port_id);
-			goto err;
-		}
-	}
 	return 0;
 
 err:
@@ -11754,6 +11813,7 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 
 	mlx5_flow_hw_rxq_flag_set(dev, false);
 	flow_hw_flush_all_ctrl_flows(dev);
+	flow_hw_cleanup_lacp_miss_tables(dev);
 	flow_hw_cleanup_ctrl_fdb_tables(dev);
 	flow_hw_cleanup_ctrl_nic_tables(dev);
 	flow_hw_cleanup_tx_repr_tagging(dev);
@@ -12160,6 +12220,14 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		if (ret)
 			goto err;
 	}
+	if (mlx5_flow_lacp_miss_needed(dev)) {
+		ret = flow_hw_create_lacp_miss_tables(dev);
+		if (ret) {
+			rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "Unable to create LACP miss flow tables");
+			goto err;
+		}
+	}
 	if (is_proxy) {
 		ret = flow_hw_create_vport_actions(priv);
 		if (ret) {
@@ -16234,10 +16302,10 @@ mlx5_flow_hw_lacp_rx_flow(struct rte_eth_dev *dev)
 		.type = MLX5_CTRL_FLOW_TYPE_LACP_RX,
 	};
 
-	if (!priv->dr_ctx || !priv->hw_ctrl_fdb || !priv->hw_ctrl_fdb->hw_lacp_rx_tbl)
+	if (!priv->dr_ctx || !priv->hw_lacp_miss || !priv->hw_lacp_miss->hw_lacp_rx_tbl)
 		return 0;
 	return flow_hw_create_ctrl_flow(dev, dev,
-					priv->hw_ctrl_fdb->hw_lacp_rx_tbl,
+					priv->hw_lacp_miss->hw_lacp_rx_tbl,
 					eth_lacp, 0, miss_action, 0, &flow_info, false);
 }
 
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index a070aaecfd..32cd18717d 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1672,9 +1672,8 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 	} else {
 		DRV_LOG(INFO, "port %u FDB default rule is disabled", dev->data->port_id);
 	}
-	if (!priv->sh->config.lacp_by_user && priv->pf_bond >= 0 && priv->master)
-		if (mlx5_flow_hw_lacp_rx_flow(dev))
-			goto error;
+	if (mlx5_flow_lacp_miss_needed(dev) && mlx5_flow_hw_lacp_rx_flow(dev) != 0)
+		goto error;
 	if (priv->isolated)
 		return 0;
 	ret = mlx5_flow_hw_create_ctrl_rx_tables(dev);
@@ -1796,7 +1795,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 		DRV_LOG(INFO, "port %u FDB default rule is disabled",
 			dev->data->port_id);
 	}
-	if (!priv->sh->config.lacp_by_user && priv->pf_bond >= 0 && priv->master) {
+	if (mlx5_flow_lacp_miss_needed(dev)) {
 		ret = mlx5_flow_lacp_miss(dev);
 		if (ret)
 			DRV_LOG(INFO, "port %u LACP rule cannot be created - "
-- 
2.47.3

