Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7414C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26EB441060;
	Tue, 17 Jun 2025 15:40:36 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by mails.dpdk.org (Postfix) with ESMTP id 22BE640E3E
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:40:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDGsvysBrncrB/Z/alQXich4epynNVh4ny3L6REnmo9giU6qrdMus1zpEWBQ/L2m4fyRgg2KF8ilPGU4n5Ex+wG0W9hXuyfPONShYRvhcXV3GgXSl7bhpIBkPJAlmeCJB3rmgXEWZCxIuyfFVTOw8tmttwuD+/JiSm93dyjDCkrSJs7Tc70ZINrd7c3yMaU3HEaDKg0MROsvJSYOQOp39EFj3RNBOirKrj7XcRXwYYQ3LYLSR8JPmXGJDTn2TmP/oEXrnCf6Pa1oATZQbkDLNeWQr+YpIJDTNX+4m6ru28Z/qjuxOl57EQE9Wx6tDYQ0ZOH9dPbjDqN1D6zq4aR9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jduglxc9glwjpR4zSjUUWuBs5tSx1hjN3FQuVxkzbxQ=;
 b=YBYZ7/kb1Z/R7v+bF/N1dMaKbTwpRxg1HSf03HX0UlB0Z61WdAEqe8+je361K7Ia3A9qXUWicYWoC9xegDAfbldTTf6LR3UDywhaL3AfVOcjwUKBn9rTMARCZMV0bmq3Qg6bN1c8S90UiUnBxzqm2cdEKbeSNBqfbtNH7HcU1eb8OjTZxAc5PHro32ysccBzzscGmc9ZH+PiqBpJYTGkgtyERirb4SeKBWdOR97vQH+RgZMl8h1XU+NrP7OdJv/9a1cwE51QKTvU4PDMuCXcmZ+KC+fhLmbdBj6v2CdRVFtDq2I0W1lLctLYzLAwTm4OJcQRHCKMyoAgrbnq0qJwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jduglxc9glwjpR4zSjUUWuBs5tSx1hjN3FQuVxkzbxQ=;
 b=fWFegpyAG52nANrXo5xdfCSGZQQO2W9N9X4W02CX4SZpN3ECQuhPZ4t1AEkLrelSb5GPbx/No5vsDcJwLz30FCVDKGhrpjziNfXcnlAWkW3Y3JBLh8WN0dhHBaKivt4x8D1XqlHB7Prsr+R4AcBjMTt9G/H/3WdyH1cYoEcblo6tnCQKHRrE/6iooq5vCQvInO+HK8HRGQr2X8MuXWFIserdNvgVMwh0iyQMUirgWvq4GZiiCgQbGgZGA5CojX3BEiQiMqVYqoHu+Zz7ZLZpX9+F1BRejQoLL3iMa4HbJEaC4749lku+NT4w+LQRUNDU0i5tnkZVNthx8CyvyOoZ8g==
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 13:40:28 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1d) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 13:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 13:40:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 06:40:10 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 06:40:04 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 3/5] net/mlx5: create utility functions for non-template
 sample action
Date: Tue, 17 Jun 2025 16:39:31 +0300
Message-ID: <20250617133933.313443-3-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617133933.313443-1-getelson@nvidia.com>
References: <20250617133933.313443-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5933b383-7369-4dd1-467a-08ddada48582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C1EzAIPGF0P24tgJM/UDLmbTp1rI2RPI0wHKaxYtxs3X55aSkvskw4JuVQkW?=
 =?us-ascii?Q?HgdFcRKQUXNnyatvOX2yLeA8vKtvAHd6yTIPDsDDxGY4xjaJuthnxeXkBszr?=
 =?us-ascii?Q?OUyzbIP+cxSqrd5k/q72TpmXZRmz1PJD+rPRJor7hG9q9Pz4+WunJLNuiOu/?=
 =?us-ascii?Q?ijQTptGr2Ibo5Jd6G6aux50rsu8My43r9Eo5HY1sNukUdxKqqescrakfH/BU?=
 =?us-ascii?Q?38Bq7o2cSXrD0rdyHWqNYA7yLr6D2DnW7adHCfSoYZod4lE0JiyuP2PdvkT2?=
 =?us-ascii?Q?tWwcXc7BI2fPVpm/VKwXvzEOQge3Og0e69WjJUpqop3FaB+/G1ayAaln0NKp?=
 =?us-ascii?Q?T/BtmeHfU+vMy4tZ3ZbWvMdS7NbP9w7aMUb5nxhLJZgAQ1PyS5m4DfaER/9A?=
 =?us-ascii?Q?CYH/DU5QeJ9N4hxhZ+4bIOApolzLbfVU8nCjIn8bNQc6tkKXPp99Rzbn20Us?=
 =?us-ascii?Q?2nSex1l/Z2LupW+6RsUNXPp3ApUGRMfEeIel+7hvQa6hj2JEJesCQ6dXn4fO?=
 =?us-ascii?Q?u0UqjyetU+NTInTqgchOfhsRM2J0zvLGubDG+BWu+ah7ROG+DldbBIREPwro?=
 =?us-ascii?Q?1qpPFWXSElo7eKfZbW4ntmE+qu6NaW/Nra2dtK1kvbbjosJIQ3Pr280GtzuC?=
 =?us-ascii?Q?qYP+LhhOGEKRMd4H/P3vMMSLUEHknaNsdTcnTwVzlkIKBKBK70+DUEQKUcdH?=
 =?us-ascii?Q?WnIsb9C9o4lwNCU+wBSs1QUTYQVIcWUozdW9W6Mh6SjLH0NQY5rFA+z6R5QO?=
 =?us-ascii?Q?ffjISKM5KZx+nVvzVWX2QYNawMe7qli9egJIBAcKiscZupM1wQqDMznsSQ83?=
 =?us-ascii?Q?8JK3wx2XsXAmr9DXE8TcI04A3ikx0H5yBw6n2pCczD5GM02J4RxAMp6R4L+5?=
 =?us-ascii?Q?Hs7YhXBYa40E5nRtKq6cwiuo1xvjogb5UiOSo8n3ooDOuytyP3Qd0YDjK2dE?=
 =?us-ascii?Q?N0/L7hp8oQZHC1sgYHxnRHZwbiJZZoP2gsn5kPxvGfgyaCqTnJN7tkVlUEGO?=
 =?us-ascii?Q?GtNNUWPzFn74Kc1UfrKHXC9/zAGdxiZdtihENqnwSipm4x9n79Yh8Q3l2pzC?=
 =?us-ascii?Q?uIxbMRazUz9dyddKsT6ZvvN0oEMScHGOluug3ar2UUGraWEJAtcD925C0kme?=
 =?us-ascii?Q?19x33RXoWZHavYJze7NmnVDayv24RMrh41TVhsYzS5M58GPA9JCtnwT2FJVD?=
 =?us-ascii?Q?69Lmu3IHDqXCy+H7FpOhZTPZ582aDNZT8j54uJRxiGBlr458XPpETOC6FUBd?=
 =?us-ascii?Q?mgvQ4OPuakCZoeORgxseAavTzqTjpqSFcatvnZKX7drJPz7OC015R+5MhW/U?=
 =?us-ascii?Q?cNBKxnn99NFDxV6A4yTOmbNSDxmvSalZvHma8VOOOUwofP9yIkP6Nq0ZFhh9?=
 =?us-ascii?Q?lMYa+kBxiX1xp5satq5Qw2HUkQmpOw6T+AfKO4HdCLsyXXxmCr6p0L7aBtO+?=
 =?us-ascii?Q?G8gDmC9uRCw23nYxncTBcdrLv7tOhIiAOUw0EEl+bv0xiCPvstS49IUvID8t?=
 =?us-ascii?Q?CUbkFKafYqUBxcNMNypbQ6eDXd0fS8UOGyYB?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:40:28.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5933b383-7369-4dd1-467a-08ddada48582
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

The patch initiates non-template sample action environment and
adds function to create hws mirror object.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/meson.build       |   1 +
 drivers/net/mlx5/mlx5.h            |   7 +
 drivers/net/mlx5/mlx5_flow.h       |   7 +
 drivers/net/mlx5/mlx5_flow_hw.c    |  22 +-
 drivers/net/mlx5/mlx5_nta_sample.c | 462 +++++++++++++++++++++++++++++
 5 files changed, 483 insertions(+), 16 deletions(-)
 create mode 100644 drivers/net/mlx5/mlx5_nta_sample.c

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 6a91692759..f16fe18193 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -53,6 +53,7 @@ if is_linux
             'mlx5_flow_verbs.c',
             'mlx5_hws_cnt.c',
             'mlx5_nta_split.c',
+            'mlx5_nta_sample.c',
     )
 endif
 
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 5695d0f54a..f085656196 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1255,6 +1255,11 @@ struct mlx5_flow_tbl_resource {
 #define MLX5_FLOW_TABLE_PTYPE_RSS_LAST (MLX5_MAX_TABLES - 11)
 #define MLX5_FLOW_TABLE_PTYPE_RSS_BASE \
 (1 + MLX5_FLOW_TABLE_PTYPE_RSS_LAST - MLX5_FLOW_TABLE_PTYPE_RSS_NUM)
+#define MLX5_FLOW_TABLE_SAMPLE_NUM 1024
+#define MLX5_FLOW_TABLE_SAMPLE_LAST (MLX5_FLOW_TABLE_PTYPE_RSS_BASE - 1)
+#define MLX5_FLOW_TABLE_SAMPLE_BASE \
+(1 + MLX5_FLOW_TABLE_SAMPLE_LAST - MLX5_FLOW_TABLE_SAMPLE_NUM)
+
 #define MLX5_FLOW_TABLE_FACTOR 10
 
 /* ID generation structure. */
@@ -1962,6 +1967,7 @@ struct mlx5_quota_ctx {
 	struct mlx5_indexed_pool *quota_ipool; /* Manage quota objects */
 };
 
+struct mlx5_nta_sample_ctx;
 struct mlx5_priv {
 	struct rte_eth_dev_data *dev_data;  /* Pointer to device data. */
 	struct mlx5_dev_ctx_shared *sh; /* Shared device context. */
@@ -2128,6 +2134,7 @@ struct mlx5_priv {
 	 */
 	struct mlx5dr_action *action_nat64[MLX5DR_TABLE_TYPE_MAX][2];
 	struct mlx5_indexed_pool *ptype_rss_groups;
+	struct mlx5_nta_sample_ctx *nta_sample_ctx;
 #endif
 	struct rte_eth_dev *shared_host; /* Host device for HW steering. */
 	RTE_ATOMIC(uint16_t) shared_refcnt; /* HW steering host reference counter. */
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 23c5833290..4bce136e1f 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3743,5 +3743,12 @@ mlx5_hw_create_mirror(struct rte_eth_dev *dev,
 		      const struct rte_flow_action *actions,
 		      struct rte_flow_error *error);
 
+struct rte_flow_hw *
+mlx5_flow_nta_handle_sample(struct rte_eth_dev *dev,
+			    const struct rte_flow_attr *attr,
+			    const struct rte_flow_item pattern[],
+			    const struct rte_flow_action actions[],
+			    struct rte_flow_error *error);
+
 #endif
 #endif /* RTE_PMD_MLX5_FLOW_H_ */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 9b3e56938a..f1b90d6e56 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -62,9 +62,6 @@ static struct rte_flow_fp_ops mlx5_flow_hw_fp_ops;
 #define MLX5_HW_VLAN_PUSH_VID_IDX 1
 #define MLX5_HW_VLAN_PUSH_PCP_IDX 2
 
-#define MLX5_MIRROR_MAX_CLONES_NUM 3
-#define MLX5_MIRROR_MAX_SAMPLE_ACTIONS_LEN 4
-
 #define MLX5_HW_PORT_IS_PROXY(priv) \
 	(!!((priv)->sh->esw_mode && (priv)->master))
 
@@ -327,18 +324,6 @@ get_mlx5dr_table_type(const struct rte_flow_attr *attr, uint32_t specialize,
 /* Non template default queue size used for inner ctrl queue. */
 #define MLX5_NT_DEFAULT_QUEUE_SIZE 32
 
-struct mlx5_mirror_clone {
-	enum rte_flow_action_type type;
-	void *action_ctx;
-};
-
-struct mlx5_mirror {
-	struct mlx5_indirect_list indirect;
-	uint32_t clones_num;
-	struct mlx5dr_action *mirror_action;
-	struct mlx5_mirror_clone clone[MLX5_MIRROR_MAX_CLONES_NUM];
-};
-
 static int flow_hw_flush_all_ctrl_flows(struct rte_eth_dev *dev);
 static int flow_hw_translate_group(struct rte_eth_dev *dev,
 				   const struct mlx5_flow_template_table_cfg *cfg,
@@ -707,6 +692,9 @@ flow_hw_action_flags_get(const struct rte_flow_action actions[],
 		case RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX:
 			action_flags |= MLX5_FLOW_ACTION_JUMP_TO_TABLE_INDEX;
 			break;
+		case RTE_FLOW_ACTION_TYPE_SAMPLE:
+			action_flags |= MLX5_FLOW_ACTION_SAMPLE;
+			break;
 		case RTE_FLOW_ACTION_TYPE_VOID:
 		case RTE_FLOW_ACTION_TYPE_END:
 			break;
@@ -14231,7 +14219,9 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		if (ret)
 			goto free;
 	}
-
+	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
+		mlx5_flow_nta_handle_sample(dev, attr, items, actions, error);
+	}
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
 		const struct rte_flow_action_rss
 			*rss_conf = flow_nta_locate_rss(dev, actions, error);
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
new file mode 100644
index 0000000000..d6ffbd8e33
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -0,0 +1,462 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2024 NVIDIA Corporation & Affiliates
+ */
+
+#include <rte_flow.h>
+#include "mlx5_malloc.h"
+#include "mlx5.h"
+#include "mlx5_defs.h"
+#include "mlx5_flow.h"
+#include "mlx5_rx.h"
+
+struct mlx5_nta_sample_ctx {
+	uint32_t groups_num;
+	struct mlx5_indexed_pool *group_ids;
+	struct mlx5_list *mirror_actions; /* cache FW mirror actions */
+	struct mlx5_list *sample_groups; /* cache groups for sample actions */
+	struct mlx5_list *suffix_groups; /* cache groups for suffix actions */
+};
+
+static uint32_t
+alloc_cached_group(struct rte_eth_dev *dev)
+{
+	void *obj;
+	uint32_t idx = 0;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+
+	obj = mlx5_ipool_malloc(ctx->group_ids, &idx);
+	if (obj == NULL)
+		return 0;
+	return idx + MLX5_FLOW_TABLE_SAMPLE_BASE;
+}
+
+static void
+release_cached_group(struct rte_eth_dev *dev, uint32_t group)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *sample_ctx = priv->nta_sample_ctx;
+
+	mlx5_ipool_free(sample_ctx->group_ids, group - MLX5_FLOW_TABLE_SAMPLE_BASE);
+}
+
+static void
+mlx5_free_sample_context(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+
+	if (ctx == NULL)
+		return;
+	if (ctx->sample_groups != NULL)
+		mlx5_list_destroy(ctx->sample_groups);
+	if (ctx->suffix_groups != NULL)
+		mlx5_list_destroy(ctx->suffix_groups);
+	if (ctx->group_ids != NULL)
+		mlx5_ipool_destroy(ctx->group_ids);
+	if (ctx->mirror_actions != NULL)
+		mlx5_list_destroy(ctx->mirror_actions);
+	mlx5_free(ctx);
+	priv->nta_sample_ctx = NULL;
+}
+
+struct mlx5_nta_sample_cached_mirror {
+	struct mlx5_flow_template_table_cfg table_cfg;
+	uint32_t sample_group;
+	uint32_t suffix_group;
+	struct mlx5_mirror *mirror;
+	struct mlx5_list_entry entry;
+};
+
+struct mlx5_nta_sample_cached_mirror_ctx {
+	struct mlx5_flow_template_table_cfg *table_cfg;
+	uint32_t sample_group;
+	uint32_t suffix_group;
+};
+
+static struct mlx5_list_entry *
+mlx5_nta_sample_create_cached_mirror(void *cache_ctx, void *cb_ctx)
+{
+	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_nta_sample_cached_mirror_ctx *ctx = cb_ctx;
+	struct rte_flow_action_jump mirror_jump_conf = { .group = ctx->sample_group };
+	struct rte_flow_action_jump suffix_jump_conf = { .group = ctx->suffix_group };
+	struct rte_flow_action mirror_sample_actions[2] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &mirror_jump_conf,
+		},
+		[1] = {
+			.type = RTE_FLOW_ACTION_TYPE_END
+		}
+	};
+	struct rte_flow_action_sample mirror_conf = {
+		.ratio = 1,
+		.actions = mirror_sample_actions,
+	};
+	struct rte_flow_action mirror_actions[3] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_SAMPLE,
+			.conf = &mirror_conf,
+		},
+		[1] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &suffix_jump_conf,
+		},
+		[2] = {
+			.type = RTE_FLOW_ACTION_TYPE_END
+		}
+	};
+	struct mlx5_nta_sample_cached_mirror *obj = mlx5_malloc(MLX5_MEM_ANY,
+								sizeof(*obj), 0,
+								SOCKET_ID_ANY);
+	if (obj == NULL)
+		return NULL;
+	obj->mirror = mlx5_hw_create_mirror(dev, ctx->table_cfg, mirror_actions, NULL);
+	if (obj->mirror == NULL) {
+		mlx5_free(obj);
+		return NULL;
+	}
+	obj->sample_group = ctx->sample_group;
+	obj->suffix_group = ctx->suffix_group;
+	obj->table_cfg = *ctx->table_cfg;
+	return &obj->entry;
+}
+
+static struct mlx5_list_entry *
+mlx5_nta_sample_clone_cached_mirror(void *tool_ctx __rte_unused,
+				    struct mlx5_list_entry *entry,
+				    void *cb_ctx __rte_unused)
+{
+	struct mlx5_nta_sample_cached_mirror *cached_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+	struct mlx5_nta_sample_cached_mirror *new_obj = mlx5_malloc(MLX5_MEM_ANY,
+								    sizeof(*new_obj), 0,
+								    SOCKET_ID_ANY);
+
+	if (new_obj == NULL)
+		return NULL;
+	memcpy(new_obj, cached_obj, sizeof(*new_obj));
+	return &new_obj->entry;
+}
+
+static int
+mlx5_nta_sample_match_cached_mirror(void *cache_ctx __rte_unused,
+				    struct mlx5_list_entry *entry, void *cb_ctx)
+{
+	bool match;
+	struct mlx5_nta_sample_cached_mirror_ctx *ctx = cb_ctx;
+	struct mlx5_nta_sample_cached_mirror *obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+
+	match = obj->sample_group == ctx->sample_group &&
+		obj->suffix_group == ctx->suffix_group &&
+		memcmp(&obj->table_cfg, ctx->table_cfg, sizeof(obj->table_cfg)) == 0;
+
+	return match ? 0 : ~0;
+}
+
+static void
+mlx5_nta_sample_remove_cached_mirror(void *cache_ctx, struct mlx5_list_entry *entry)
+{
+	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_nta_sample_cached_mirror *obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+	mlx5_hw_mirror_destroy(dev, obj->mirror);
+	mlx5_free(obj);
+}
+
+static void
+mlx5_nta_sample_clone_free_cached_mirror(void *cache_ctx __rte_unused,
+					 struct mlx5_list_entry *entry)
+{
+	struct mlx5_nta_sample_cached_mirror *cloned_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+
+	mlx5_free(cloned_obj);
+}
+
+struct mlx5_nta_sample_cached_group {
+	const struct rte_flow_action *actions;
+	size_t actions_size;
+	uint32_t group;
+	struct mlx5_list_entry entry;
+};
+
+struct mlx5_nta_sample_cached_group_ctx {
+	struct rte_flow_action *actions;
+	size_t actions_size;
+};
+
+static int
+serialize_actions(struct mlx5_nta_sample_cached_group_ctx *obj_ctx)
+{
+	if (obj_ctx->actions_size == 0) {
+		uint8_t *tgt_buffer;
+		int size = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, NULL, 0, obj_ctx->actions, NULL);
+		if (size < 0)
+			return size;
+		tgt_buffer = mlx5_malloc(MLX5_MEM_ANY, size, 0, SOCKET_ID_ANY);
+		if (tgt_buffer == NULL)
+			return -ENOMEM;
+		obj_ctx->actions_size = size;
+		size = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, tgt_buffer, size,
+				     obj_ctx->actions, NULL);
+		if (size < 0) {
+			mlx5_free(tgt_buffer);
+			return size;
+		}
+		obj_ctx->actions = (struct rte_flow_action *)tgt_buffer;
+	}
+	return obj_ctx->actions_size;
+}
+
+static struct mlx5_list_entry *
+mlx5_nta_sample_create_cached_group(void *cache_ctx, void *cb_ctx)
+{
+	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_nta_sample_cached_group_ctx *obj_ctx = cb_ctx;
+	struct mlx5_nta_sample_cached_group *obj;
+	int actions_size = serialize_actions(obj_ctx);
+
+	if (actions_size < 0)
+		return NULL;
+	obj = mlx5_malloc(MLX5_MEM_ANY, sizeof(*obj), 0, SOCKET_ID_ANY);
+	if (obj == NULL)
+		return NULL;
+	obj->group = alloc_cached_group(dev);
+	if (obj->group == 0) {
+		mlx5_free(obj);
+		return NULL;
+	}
+	obj->actions = obj_ctx->actions;
+	obj->actions_size = obj_ctx->actions_size;
+	return &obj->entry;
+}
+
+static int
+mlx5_nta_sample_match_cached_group(void *cache_ctx __rte_unused,
+				   struct mlx5_list_entry *entry, void *cb_ctx)
+{
+	struct mlx5_nta_sample_cached_group_ctx *obj_ctx = cb_ctx;
+	int actions_size = serialize_actions(obj_ctx);
+	struct mlx5_nta_sample_cached_group *cached_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_group, entry);
+	if (actions_size < 0)
+		return ~0;
+	return memcmp(cached_obj->actions, obj_ctx->actions, actions_size);
+}
+
+static void
+mlx5_nta_sample_remove_cached_group(void *cache_ctx, struct mlx5_list_entry *entry)
+{
+	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_nta_sample_cached_group *cached_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_group, entry);
+
+	release_cached_group(dev, cached_obj->group);
+	mlx5_free((void *)(uintptr_t)cached_obj->actions);
+	mlx5_free(cached_obj);
+}
+
+static struct mlx5_list_entry *
+mlx5_nta_sample_clone_cached_group(void *tool_ctx __rte_unused,
+				   struct mlx5_list_entry *entry,
+				   void *cb_ctx __rte_unused)
+{
+	struct mlx5_nta_sample_cached_group *cached_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_group, entry);
+	struct mlx5_nta_sample_cached_group *new_obj;
+
+	new_obj = mlx5_malloc(MLX5_MEM_ANY, sizeof(*new_obj), 0, SOCKET_ID_ANY);
+	if (new_obj == NULL)
+		return NULL;
+	memcpy(new_obj, cached_obj, sizeof(*new_obj));
+	return &new_obj->entry;
+}
+
+static void
+mlx5_nta_sample_free_cloned_cached_group(void *cache_ctx __rte_unused,
+					 struct mlx5_list_entry *entry)
+{
+	struct mlx5_nta_sample_cached_group *cloned_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_group, entry);
+
+	mlx5_free(cloned_obj);
+}
+
+static int
+mlx5_init_nta_sample_context(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_indexed_pool_config ipool_cfg = {
+		.size = 0,
+		.trunk_size = 32,
+		.grow_trunk = 5,
+		.grow_shift = 1,
+		.need_lock = 1,
+		.release_mem_en = !!priv->sh->config.reclaim_mode,
+		.max_idx = MLX5_FLOW_TABLE_SAMPLE_NUM,
+		.type = "mlx5_nta_sample"
+	};
+	struct mlx5_nta_sample_ctx *ctx = mlx5_malloc(MLX5_MEM_ZERO,
+						      sizeof(*ctx), 0, SOCKET_ID_ANY);
+
+	if (ctx == NULL)
+		return -ENOMEM;
+	priv->nta_sample_ctx = ctx;
+	ctx->group_ids = mlx5_ipool_create(&ipool_cfg);
+	if (ctx->group_ids == NULL)
+		goto error;
+	ctx->sample_groups = mlx5_list_create("nta sample groups", dev, true,
+					      mlx5_nta_sample_create_cached_group,
+					      mlx5_nta_sample_match_cached_group,
+					      mlx5_nta_sample_remove_cached_group,
+					      mlx5_nta_sample_clone_cached_group,
+					      mlx5_nta_sample_free_cloned_cached_group);
+	if (ctx->sample_groups == NULL)
+		goto error;
+	ctx->suffix_groups = mlx5_list_create("nta sample suffix groups", dev, true,
+					      mlx5_nta_sample_create_cached_group,
+					      mlx5_nta_sample_match_cached_group,
+					      mlx5_nta_sample_remove_cached_group,
+					      mlx5_nta_sample_clone_cached_group,
+					      mlx5_nta_sample_free_cloned_cached_group);
+	if (ctx->suffix_groups == NULL)
+		goto error;
+	ctx->mirror_actions = mlx5_list_create("nta sample mirror actions", dev, true,
+					       mlx5_nta_sample_create_cached_mirror,
+					       mlx5_nta_sample_match_cached_mirror,
+					       mlx5_nta_sample_remove_cached_mirror,
+					       mlx5_nta_sample_clone_cached_mirror,
+					       mlx5_nta_sample_clone_free_cached_mirror);
+	if (ctx->mirror_actions == NULL)
+		goto error;
+	return 0;
+
+error:
+	mlx5_free_sample_context(dev);
+	return -ENOMEM;
+}
+
+static struct mlx5_mirror *
+get_registered_mirror(struct mlx5_flow_template_table_cfg *table_cfg,
+		      struct mlx5_list *cache,
+		      uint32_t sample_group,
+		      uint32_t suffix_group)
+{
+	struct mlx5_nta_sample_cached_mirror_ctx ctx = {
+		.table_cfg = table_cfg,
+		.sample_group = sample_group,
+		.suffix_group = suffix_group
+	};
+	struct mlx5_list_entry *ent = mlx5_list_register(cache, &ctx);
+	return ent ? container_of(ent, struct mlx5_nta_sample_cached_mirror, entry)->mirror : NULL;
+}
+
+static uint32_t
+get_registered_group(struct rte_flow_action *actions, struct mlx5_list *cache)
+{
+	struct mlx5_nta_sample_cached_group_ctx ctx = {
+		.actions = actions
+	};
+	struct mlx5_list_entry *ent = mlx5_list_register(cache, &ctx);
+	return ent ? container_of(ent, struct mlx5_nta_sample_cached_group, entry)->group : 0;
+}
+
+static struct mlx5_mirror *
+mlx5_create_nta_mirror(struct rte_eth_dev *dev,
+		       const struct rte_flow_attr *attr,
+		       struct rte_flow_action *sample_actions,
+		       struct rte_flow_action *suffix_actions,
+		       struct rte_flow_error *error)
+{
+	struct mlx5_mirror *mirror;
+	uint32_t sample_group, suffix_group;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+	struct mlx5_flow_template_table_cfg table_cfg = {
+		.external = true,
+		.attr = {
+			.flow_attr = {
+				.ingress = attr->ingress,
+				.egress = attr->egress,
+				.transfer = attr->transfer
+			}
+		}
+	};
+
+	sample_group = get_registered_group(sample_actions, ctx->sample_groups);
+	if (sample_group == 0) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					   NULL, "Failed to register sample group");
+		return NULL;
+	}
+	suffix_group = get_registered_group(suffix_actions, ctx->suffix_groups);
+	if (suffix_group == 0) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					   NULL, "Failed to register suffix group");
+		return NULL;
+	}
+	mirror = get_registered_mirror(&table_cfg, ctx->mirror_actions, sample_group, suffix_group);
+	return mirror;
+}
+
+static void
+mlx5_nta_parse_sample_actions(const struct rte_flow_action *action,
+			      const struct rte_flow_action **sample_action,
+			      struct rte_flow_action *prefix_actions,
+			      struct rte_flow_action *suffix_actions)
+{
+	struct rte_flow_action *pa = prefix_actions;
+	struct rte_flow_action *sa = suffix_actions;
+
+	*sample_action = NULL;
+	do {
+		if (action->type == RTE_FLOW_ACTION_TYPE_SAMPLE) {
+			*sample_action = action;
+		} else if (*sample_action == NULL) {
+			if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
+				continue;
+			*(pa++) = *action;
+		} else {
+			if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
+				continue;
+			*(sa++) = *action;
+		}
+	} while ((action++)->type != RTE_FLOW_ACTION_TYPE_END);
+}
+
+struct rte_flow_hw *
+mlx5_flow_nta_handle_sample(struct rte_eth_dev *dev,
+			    const struct rte_flow_attr *attr,
+			    const struct rte_flow_item pattern[] __rte_unused,
+			    const struct rte_flow_action actions[] __rte_unused,
+			    struct rte_flow_error *error)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_mirror *mirror;
+	const struct rte_flow_action *sample;
+	struct rte_flow_action *sample_actions;
+	const struct rte_flow_action_sample *sample_conf;
+	struct rte_flow_action prefix_actions[MLX5_HW_MAX_ACTS] = { 0 };
+	struct rte_flow_action suffix_actions[MLX5_HW_MAX_ACTS] = { 0 };
+
+	if (priv->nta_sample_ctx == NULL) {
+		int rc = mlx5_init_nta_sample_context(dev);
+		if (rc != 0) {
+			rte_flow_error_set(error, -rc, RTE_FLOW_ERROR_TYPE_ACTION,
+					   NULL, "Failed to allocate sample context");
+			return NULL;
+		}
+	}
+	mlx5_nta_parse_sample_actions(actions, &sample, prefix_actions, suffix_actions);
+	sample_conf = (const struct rte_flow_action_sample *)sample->conf;
+	sample_actions = (struct rte_flow_action *)(uintptr_t)sample_conf->actions;
+	mirror = mlx5_create_nta_mirror(dev, attr, sample_actions,
+					suffix_actions, error);
+	if (mirror == NULL)
+		goto error;
+error:
+	return NULL;
+}
-- 
2.48.1

