Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD04DCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 13:04:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF4384021F;
	Thu,  6 Nov 2025 14:04:12 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55]) by mails.dpdk.org (Postfix) with ESMTP id 3D17C4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 14:04:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0rKAsdcFsWNcKi01caNr0HZ2Osq+Ps9o2biVwAZ+LvCr0TWsnXfY/gG+desKY6jJkoBdIwDvs5nVjWD3SMzS5XbHl2li7BGfXYmG2RhMh5kLVooj46FqxzZCjfb/yrwauGn17XA+UBhvVdB8z7iJ9mHh4i5cHSWi3kIWQv3RwBttk5ytebmW0d1CNd1ZIJtG1SgXfrth0Z4i5SNJYOhoLrvrTW+P58U6763A8eefvQ6T7dNN+gI2M5GdAicBkfAtesX5truB2nWYAy3Z/afgVRKx6R+oQL0A9GzaGIGGouaCXhW4Qb5dbIftzn9/kzYQOKHS7PkTQW2gfpU1tAXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEkqc7MwsfUKcLgBijZyogCmWFH5icPp+PjIonWftek=;
 b=u1+xln50/tT576qlZUtLxaBQgMfmmd0UBjTS6VxpoFPlNvaqTXCKSCXzgB2hpvniUA4eZgOrE1Zkpx+A/6x+xjx2PKf8I5h91o8fdM1UbqU/2vP40huDQE5tcNGe9cqv5va43XBJEKrN0tlfEI6/QVLqxmjqjbypLI/K0x8YWFxgC8GMoHjmUjx4Mj8obJYVUhOaN2M8fMVVK3XqbVqdbcHCPdbVLR8Yl1T91kiTatylT2LdgmrytlTAIh8TYssKI9Qh6f+cV+bNyRweMsUihkP71BeZytjscXg9R5/19TFz+WrstNuZXqHyJIibGrY7Mxkn+GG3eUJJV8WRIicxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEkqc7MwsfUKcLgBijZyogCmWFH5icPp+PjIonWftek=;
 b=tqbqcqlsOJakZSg+Jh8L/fwlvbvINII+vOfSLnMfdKhHCnVjZ659b329QwqgSM9ufCK7b27JY/oWxo4FFFRPCg7Osm5scSGRi9WM/qMBoffEZHrSi562Sngu8sT5NCY4BvkyE1FmSVkRLGo2Vijj0v/0z6w+NZc4uVMqem35QObC0xubzX21tTHLj11WKHCf0RmPmthrIHk6zuEvioySSMzxCQifwO83QlEe+TI3bfCXMFjkb/BoaeF0iFCdUYm8AXlxqZRO/MbYvEEWwyfTgnPWfcrbRB5UdUhHgH/10a8vh2hRMHdlScQRw1P4yu/+E0UXOKXES/MfOsCCfIIIvw==
Received: from BY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:a03:1b8::47)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 13:04:09 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::1) by BY5PR17CA0034.outlook.office365.com
 (2603:10b6:a03:1b8::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 13:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 13:04:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 05:03:47 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 05:03:43 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix non-template sample action validation
Date: Thu, 6 Nov 2025 15:02:28 +0200
Message-ID: <20251106130228.491915-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: da492267-52b3-4ad9-9ad4-08de1d34f994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MOANKpFR9jnrqj2t9zoHOcIhEPDomIGCXP8q3ibXAIW15B/nXYKCXIS8eOD4?=
 =?us-ascii?Q?c539KWGcXdz31C5uv9JufcVjOJyVBX0JvNB2EnTAyAm2Zs7wl9qToJi7SB77?=
 =?us-ascii?Q?n9/1wCX+LU4VIQF5vnXDEAgw1bdF2mpfUrYTrjwgMj9QaNZbys6ayf7Fk4lw?=
 =?us-ascii?Q?O0CBiSGm0OugG9u/K73p34u+zri5hmoXbWCCNoATh5MwJVxdR5tx8BPTSIZ/?=
 =?us-ascii?Q?bzmD8NmAMs19mw9SWCiy1WX0ONfxygLxV62z1pRsfVsncpwRIrcQrimuY2EC?=
 =?us-ascii?Q?VqlD/0TpYYKjCzdJbyJERplrINQFFc8MtqxmPtJ22P0hFbwqM7ZlDmRqcFVc?=
 =?us-ascii?Q?1DoqfapJrTm92sXdibLCxjvQpyLkcUPmiSL/szGlF+XXixYazyk+ApXWnqKS?=
 =?us-ascii?Q?3cRJyy+dDEKvcMOJ+GgHw/hqfnLnujhN1e5lOsnscfpf03dH9CcbtzNC+nSw?=
 =?us-ascii?Q?3yagqjTYV7jw4569SL0xOxDdPqw/Ls0x3yhEgTe5KcXhVHXwJhEnKDxRn7/w?=
 =?us-ascii?Q?CWgkTnf9ibe/ZbmsWz8SEOhqLeAM0dz8kRel8Cy8FWW/v9ASSW26QBO/u7/m?=
 =?us-ascii?Q?4/DcgmbsuABUE8t9zYRXCQO1tmfTM2+efHp5axQIEyKM5YCUq+P1c5HjMJ36?=
 =?us-ascii?Q?L/tLymc8qTllHlzO0ff1da3zqbjaMVKVx9Y3J1lnRjOzGMCQp1FIYfH/IfRP?=
 =?us-ascii?Q?N0mR51FAw6biXtuxES5S3utipGktI+yDNIDO70OpIUeEobmaziv4/e5S32kL?=
 =?us-ascii?Q?XdmuiUFqFopVp+ZoCoIUilQwrUBzO7qNajMqWWckZdSUDUFy1oCk2bI+OYsl?=
 =?us-ascii?Q?8FlBfluwysCcmprjfDXX+W/sTZDEztdINdfu/Hg14NL4dXj0HUiHJ7OAIBpS?=
 =?us-ascii?Q?n1xPMnSTOJ4jnUXLX8MTXUgZQXGmXwaCCMssqpJavkFL+ju7lmttD4HDwrsP?=
 =?us-ascii?Q?VNPV4YQWnjnTiJox7rsFEHAhThwcHWw6nU/ObKKa7LpVskzDatd5Y8A2dCFV?=
 =?us-ascii?Q?8nheh8x9o3sq6nT5zJXNV0nq7n7LLCuBR5VEGNWuYwIJr+0Q13jNzVTot8qQ?=
 =?us-ascii?Q?SF034BTzjlWcEcX9JrKeQlEfVl3NDivyi0eLy9MhK3fP7uUXIOnnxdMqAvbg?=
 =?us-ascii?Q?9db1IY1iPsQb4YAaYCWxnbfyTKWxrJZHdHwSbrM6KoFLTUJ9WZcZE7POoFN+?=
 =?us-ascii?Q?NkhLtV8k7gPq/8WQzlNMuuVwIlRSVHWg/YvsgnopghtruQFbD99+325pNkl3?=
 =?us-ascii?Q?ohW68sjn17lxhQEbAiFHCw4Zd1VlEZ2dOfDNC7YhZhPiu974I8V3Gcjd4yYz?=
 =?us-ascii?Q?6XhjggVKCcuSn/PbEjY2HgREg8gj4eP5LfEv/euDiEBw1GP2TaJdMF//PW2B?=
 =?us-ascii?Q?UDri+WjP2JOE5qTcRkdJKvBGewuqS2qEBLfFX2hgJGtoYaKkwimZoy/q7nE9?=
 =?us-ascii?Q?rLtuQsxoVcbmqBqDSQ9wdXCz5eCV/0hqbSlPNAGJKSWR7kIlnLeerZDb1Hcq?=
 =?us-ascii?Q?993rYIo2JZ1KGvUserlQg50uWXI4235HZmCRgvcAfgS3iF9/Z4p89cMcWKbK?=
 =?us-ascii?Q?brcwukqFnTbT56hVKOQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:04:09.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da492267-52b3-4ad9-9ad4-08de1d34f994
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
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

The patch validates that sample actions include terminal action

Fixes: d986f04d6529 ("net/mlx5: add functions for non-template flow sample")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h       |  3 +++
 drivers/net/mlx5/mlx5_flow_hw.c    |  4 ---
 drivers/net/mlx5/mlx5_nta_sample.c | 43 +++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 146d547f72..d4f4d5a8ef 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -21,6 +21,9 @@
 #include "hws/mlx5dr.h"
 #include "mlx5_tx.h"
 
+#define MLX5_HW_PORT_IS_PROXY(priv) \
+	(!!((priv)->sh->esw_mode && (priv)->master))
+
 /* E-Switch Manager port, used for rte_flow_item_port_id. */
 #define MLX5_PORT_ESW_MGR UINT32_MAX
 
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index ff68483a40..2d80c99c18 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -62,10 +62,6 @@ static struct rte_flow_fp_ops mlx5_flow_hw_fp_ops;
 #define MLX5_HW_VLAN_PUSH_VID_IDX 1
 #define MLX5_HW_VLAN_PUSH_PCP_IDX 2
 
-#define MLX5_HW_PORT_IS_PROXY(priv) \
-	(!!((priv)->sh->esw_mode && (priv)->master))
-
-
 struct mlx5_indlst_legacy {
 	struct mlx5_indirect_list indirect;
 	struct rte_flow_action_handle *handle;
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
index 938108cf4c..0b7b3d0c8e 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.c
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -525,6 +525,42 @@ validate_prefix_actions(const struct rte_flow_action *actions)
 	return i < MLX5_HW_MAX_ACTS - 1;
 }
 
+static bool
+validate_sample_terminal_actions(const struct rte_eth_dev *dev,
+				 const struct rte_flow_attr *flow_attr,
+				 const struct rte_flow_action *actions)
+{
+	uint32_t i;
+	const struct mlx5_priv *priv = dev->data->dev_private;
+	const struct rte_flow_action_ethdev *port = NULL;
+	bool is_proxy = MLX5_HW_PORT_IS_PROXY(priv);
+	const struct rte_flow_action *a = NULL;
+
+	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
+		if (actions[i].type != RTE_FLOW_ACTION_TYPE_VOID)
+			a = &actions[i];
+	}
+	if (a == NULL)
+		return false;
+	switch (a->type) {
+	case RTE_FLOW_ACTION_TYPE_JUMP:
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+	case RTE_FLOW_ACTION_TYPE_DROP:
+	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+		return true;
+	case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+		if (!is_proxy || !flow_attr->transfer)
+			return false;
+		port = a->conf;
+		if (!port || port->port_id != MLX5_REPRESENTED_PORT_ESW_MGR)
+			return false;
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
 static void
 action_append(struct rte_flow_action *actions, const struct rte_flow_action *last)
 {
@@ -829,10 +865,15 @@ mlx5_nta_sample_flow_list_create(struct rte_eth_dev *dev,
 	}
 	mlx5_nta_parse_sample_actions(actions, &sample, prefix_actions, suffix_actions);
 	if (!validate_prefix_actions(prefix_actions)) {
-		rte_flow_error_set(error, -EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
 				   NULL, "Too many actions");
 		return NULL;
 	}
+	if (!validate_sample_terminal_actions(dev, attr, sample)) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				   NULL, "Invalid sample actions");
+		return NULL;
+	}
 	sample_conf = (const struct rte_flow_action_sample *)sample->conf;
 	sample_actions = (struct rte_flow_action *)(uintptr_t)sample_conf->actions;
 	mirror_entry = mlx5_create_nta_mirror(dev, attr, sample_actions,
-- 
2.51.0

