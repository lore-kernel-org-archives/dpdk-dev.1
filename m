Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A7BC77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA3CC40E49;
	Thu, 26 Jun 2025 10:00:49 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by mails.dpdk.org (Postfix) with ESMTP id 1775240E43
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:00:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtVowmwS3TmOz3ryLf6eGSgcVXTRtujUAE2Zm62yVygIJ435g66hqCRThHfAA7xpzSEnlBoXwkj1xG6kB1Tym6z2Xwspk6cf4y1aTkz7iGrakRFcIru9MkZqzSWCX/Gsv3BgbEPQrtNOooenhl1pWiGLwYj9OFz9BlLxrlTJ83GgSXHsaFKnc6ZV84/zdZ3tfWBy0aRgq6HkFFieLVXsm+5+12HlqC0nvy0DkBb1sHJGLkCijN31lWVcsB51CFtHLYbdqwpWoW2KSiMsrHskROCjsXe937wkKPP0cgR7BCHIfZZjQZnSogNnEvzrsDJs3x3ijqjc28tmJTYAmey7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g58d0anC5PQseYNF5aTcZajcOv0+MieO53EB8r/uG0M=;
 b=Mhb9wsgzC/615OP/pZMhwuMK13OBadNlFIx+nyi2hKOUVaTgd7zQpp2urpgABtQUxLhBG3gYt/w0KyLPPcfxHuUQ4xIRwduNzGT3sawHQBgIuM4XRItHr9IWaf3wrOq0xQBKEH7o/JY0rUiGUH3kRu+jh9h0qd8T3op7UwW6fgmBmsowAHlQnoEsqvf+VZ/9FZaOhYxwcW6pXnuqfi8mPmr2ev097XXAptypOZWdM7mrRxTeFY5turtElHIktc/Sf26tRFbQ8teM3TqcVId3aR4Idb03w7lcbjryGtUxuZ8bj/paJ8Y8vDfu+ssNB25tJ8FT+IzWhczXKdyHDpTtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g58d0anC5PQseYNF5aTcZajcOv0+MieO53EB8r/uG0M=;
 b=KzezCsf4et0x9Ct+hD0hNp+jFKfoejFuVSnZCjxpR/7tlQ58z/DYK+wWfeybxcIXRBEVFVJYfvUumAvVqtWNA3wJyiqzZmzlQ0WVZrdYWeu9wjVDiyAsBXIErDip27KUuK+qcTlVMwo5HhtUj3L3N4LprE+m548dYLZc+TFtmuDYQOvMpCu0D2ZF7aTFZDNTJGZxIPIlZ8bYNMq4LAU9mcBAXMzgWDWrqpEsMGS5s4ojdGVAwncKj9Y7/6C0C08p7KLNLryWjJs7Gc8PUNRhnr8Kzr3gyWh073GLAMLd/zfH2E7QT5p4L74/E2MMasgrMk1IHapzj/qLALwuWvpeMg==
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Thu, 26 Jun 2025 08:00:37 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::6a) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 08:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 08:00:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 01:00:23 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 01:00:14 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 3/4] net/mlx5: add functions for non template sample action
Date: Thu, 26 Jun 2025 10:59:43 +0300
Message-ID: <20250626075945.537256-4-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626075945.537256-1-getelson@nvidia.com>
References: <20250617133933.313443-1-getelson@nvidia.com>
 <20250626075945.537256-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a4d038-ab88-42b2-562c-08ddb487891d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zjkLLdz/2D9owfk5lVTY5jgOK0Wzrtr2M7D7o0Yw0LD4HOoxur6PB0GMTNwe?=
 =?us-ascii?Q?dYa5LPTwbISTSnJ4E2ZtgUitbr7W4P8NusRZeDazfqu5CMyz3tTW7zvy/hK/?=
 =?us-ascii?Q?3BZM6Jn1eJx066dnJwtnEhwhwOmre3BivOH8V+SzHdH4KW/dw8dvrspjD26a?=
 =?us-ascii?Q?491a9WvULIiAFrPiNgvt95ewuzXuzinUOgVj4+ssNxuG3cWAftyCWjmFa9fO?=
 =?us-ascii?Q?ZbqyfkD67QrT/ICinvUTNGpWEsWmZtwUhDTP305e//8AngANZE44ML790Jpg?=
 =?us-ascii?Q?gggqf/H5w3nP6DHi+gQ9YWNSf2rsEBMa/8l5BWND+Nc2SfISrjZG/A2wopHt?=
 =?us-ascii?Q?SQklb1j03THsQMnzqNkXQWnH9oeWRmM4oVTzJi/gH0BvemEibTpmV8a92vzI?=
 =?us-ascii?Q?hslonxfq7SXxP5ERbhVvraD84pnxuDYXSYQSzeJlbllOOQgv6ce0JMjLEnxc?=
 =?us-ascii?Q?9aW/CB30qF7BkZ5HJQ06rCmOOGyLuyHYgL+eNvw9WQpIa3AlC24yQt7tgp/A?=
 =?us-ascii?Q?4X199AAA35o6UmmNooqdBn4ltaVUGN47IETs0U2rODNywztoBfJHx+uO4R8h?=
 =?us-ascii?Q?iJQ+jym64hKPqlKoT0OXo+mdQJlMhiXHRXAJhChBSz1N0101dFcsa1lJ7Skq?=
 =?us-ascii?Q?7IVEapxKHI35SETRbzL1XmlOV+jie4uX/byWeLrBEqTqpyvdDtdUnHcVJ42U?=
 =?us-ascii?Q?KTnd6vZGbli91Kj6QUi7ct3mqj6gupneljisi5fMvjxFCxkSl4XbU23L1MkC?=
 =?us-ascii?Q?4izAImye5y4ZfTE6yqO7GqG2hbGhmL9GbRIIJgNC7Sbw8t9eyM426pvRa+ud?=
 =?us-ascii?Q?aqOOCTFxiDaU4Tt0vz7yIsGK1XR+pE9WipMPbYx1w5URaKNVeFQXa3z+Z2F/?=
 =?us-ascii?Q?o5cYsSV3TnlZ6kfKdLjmRpRvAYfyFqJ1OMm9CCNWVsVBA+AhUjXzaWCYG1AA?=
 =?us-ascii?Q?tyC7m+q5OkO0wYdQEjuDSS7EuBQDoRZAkg4TFqEJrSbd3VEBNxVb3u7iHuGO?=
 =?us-ascii?Q?p6hcWzPJ80/1fDwp3k57EhywYOt3faDfaGD2fdy7vLL/dpt3xHc/fcNFIyeW?=
 =?us-ascii?Q?pKMzM9mkUcMeF3NaHAK7uFxiAKYIQVc2WMdgMkGHhJmv80XYzS3ZbTB7hnrc?=
 =?us-ascii?Q?R9HMyflwKnNxiPDpmnRUuL+kdNC/YAwt4u+bilHWN8Jn87zO1xxsgi+HpOOE?=
 =?us-ascii?Q?jZkP690dWwf4mK5ug18NHuElWU4vKMXfEj1sXHEIZ8Nc3cYN1hQcraxdfYTc?=
 =?us-ascii?Q?m61yR7YeLlq2EiH9ei2hPPQtzta3gIj1Jn51H+M9ncKwiDeRR23CcLaKEtp0?=
 =?us-ascii?Q?CoYeGv4epo1Oqj26u6+OWL69iTWGTjgOn+2r9aEaIhF0g5/7+REga2hC3aCV?=
 =?us-ascii?Q?G5E/8hHNbmxp8MhCqLiaMbzn4V1Qg8HiLXFv2fUZHAQjlRkSEHJRRCXRqV1E?=
 =?us-ascii?Q?UMss2JYS9sAqDj4QJU/4LS+ZmkqPWYBjmih04luH/26YikfIDvzGTutc28+E?=
 =?us-ascii?Q?qaEjJkmukMjDJ7kkHaUV0jQq7A72RS75fCi+?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:00:36.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a4d038-ab88-42b2-562c-08ddb487891d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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
adds private functions to support the sample flow action.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/meson.build       |   1 +
 drivers/net/mlx5/mlx5.h            |   7 +
 drivers/net/mlx5/mlx5_flow.h       |   2 +
 drivers/net/mlx5/mlx5_nta_sample.c | 470 +++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_nta_sample.h |  22 ++
 5 files changed, 502 insertions(+)
 create mode 100644 drivers/net/mlx5/mlx5_nta_sample.c
 create mode 100644 drivers/net/mlx5/mlx5_nta_sample.h

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
index 23c5833290..561bb05dfa 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3743,5 +3743,7 @@ mlx5_hw_create_mirror(struct rte_eth_dev *dev,
 		      const struct rte_flow_action *actions,
 		      struct rte_flow_error *error);
 
+#include "mlx5_nta_sample.h"
+
 #endif
 #endif /* RTE_PMD_MLX5_FLOW_H_ */
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
new file mode 100644
index 0000000000..aae864eb00
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -0,0 +1,470 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 NVIDIA Corporation & Affiliates
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
+	struct mlx5_list *mirror_groups; /* cache groups for sample and suffix actions */
+};
+
+static void
+release_cached_group(struct rte_eth_dev *dev, uint32_t group)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+
+	mlx5_ipool_free(ctx->group_ids, group - MLX5_FLOW_TABLE_SAMPLE_BASE);
+}
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
+void
+mlx5_nta_sample_context_free(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+
+	if (ctx == NULL)
+		return;
+	if (ctx->mirror_groups != NULL)
+		mlx5_list_destroy(ctx->mirror_groups);
+	if (ctx->group_ids != NULL)
+		mlx5_ipool_destroy(ctx->group_ids);
+	if (ctx->mirror_actions != NULL)
+		mlx5_list_destroy(ctx->mirror_actions);
+	mlx5_free(ctx);
+	priv->nta_sample_ctx = NULL;
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
+struct mlx5_nta_sample_cached_mirror {
+	struct mlx5_flow_template_table_cfg table_cfg;
+	struct mlx5_list_entry *sample;
+	struct mlx5_list_entry *suffix;
+	struct mlx5_mirror *mirror;
+	struct mlx5_list_entry entry;
+};
+
+struct mlx5_nta_sample_cached_mirror_ctx {
+	struct mlx5_flow_template_table_cfg *table_cfg;
+	struct mlx5_list_entry *sample;
+	struct mlx5_list_entry *suffix;
+};
+
+static struct mlx5_list_entry *
+mlx5_nta_sample_cached_mirror_create(void *cache_ctx, void *cb_ctx)
+{
+	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_nta_sample_cached_mirror_ctx *ctx = cb_ctx;
+	struct rte_flow_action_jump sample_jump_conf = {
+		.group = container_of(ctx->sample,
+				      struct mlx5_nta_sample_cached_group, entry)->group
+	};
+	struct rte_flow_action_jump suffix_jump_conf = {
+		.group = container_of(ctx->suffix,
+				      struct mlx5_nta_sample_cached_group, entry)->group
+	};
+	struct rte_flow_action mirror_sample_actions[2] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &sample_jump_conf,
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
+	obj->sample = ctx->sample;
+	obj->suffix = ctx->suffix;
+	obj->table_cfg = *ctx->table_cfg;
+	return &obj->entry;
+}
+
+static struct mlx5_list_entry *
+mlx5_nta_sample_cached_mirror_clone(void *tool_ctx __rte_unused,
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
+mlx5_nta_sample_cached_mirror_match(void *cache_ctx __rte_unused,
+				    struct mlx5_list_entry *entry, void *cb_ctx)
+{
+	bool match;
+	struct mlx5_nta_sample_cached_mirror_ctx *ctx = cb_ctx;
+	struct mlx5_nta_sample_cached_mirror *obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+
+	match = obj->sample == ctx->sample &&
+		obj->suffix == ctx->suffix &&
+		memcmp(&obj->table_cfg, ctx->table_cfg, sizeof(obj->table_cfg)) == 0;
+
+	return match ? 0 : ~0;
+}
+
+static void
+mlx5_nta_sample_cached_mirror_remove(void *cache_ctx, struct mlx5_list_entry *entry)
+{
+	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_nta_sample_cached_mirror *obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+	mlx5_hw_mirror_destroy(dev, obj->mirror);
+	mlx5_free(obj);
+}
+
+static void
+mlx5_nta_sample_cached_mirror_free_cloned(void *cache_ctx __rte_unused,
+					  struct mlx5_list_entry *entry)
+{
+	struct mlx5_nta_sample_cached_mirror *cloned_obj =
+		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
+
+	mlx5_free(cloned_obj);
+}
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
+mlx5_nta_sample_cached_group_create(void *cache_ctx, void *cb_ctx)
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
+mlx5_nta_sample_cached_group_match(void *cache_ctx __rte_unused,
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
+mlx5_nta_sample_cached_group_remove(void *cache_ctx, struct mlx5_list_entry *entry)
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
+mlx5_nta_sample_cached_group_clone(void *tool_ctx __rte_unused,
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
+mlx5_nta_sample_cached_group_free_cloned(void *cache_ctx __rte_unused,
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
+	ctx->mirror_groups = mlx5_list_create("nta sample groups", dev, true,
+					      mlx5_nta_sample_cached_group_create,
+					      mlx5_nta_sample_cached_group_match,
+					      mlx5_nta_sample_cached_group_remove,
+					      mlx5_nta_sample_cached_group_clone,
+					      mlx5_nta_sample_cached_group_free_cloned);
+	if (ctx->mirror_groups == NULL)
+		goto error;
+	ctx->mirror_actions = mlx5_list_create("nta sample mirror actions", dev, true,
+					       mlx5_nta_sample_cached_mirror_create,
+					       mlx5_nta_sample_cached_mirror_match,
+					       mlx5_nta_sample_cached_mirror_remove,
+					       mlx5_nta_sample_cached_mirror_clone,
+					       mlx5_nta_sample_cached_mirror_free_cloned);
+	if (ctx->mirror_actions == NULL)
+		goto error;
+	return 0;
+
+error:
+	mlx5_nta_sample_context_free(dev);
+	return -ENOMEM;
+}
+
+static struct mlx5_list_entry *
+register_mirror(struct mlx5_flow_template_table_cfg *table_cfg,
+		struct mlx5_list *cache,
+		struct mlx5_list_entry *sample,
+		struct mlx5_list_entry *suffix)
+{
+	struct mlx5_nta_sample_cached_mirror_ctx ctx = {
+		.table_cfg = table_cfg,
+		.sample = sample,
+		.suffix = suffix
+	};
+
+	return mlx5_list_register(cache, &ctx);
+}
+
+static struct mlx5_list_entry *
+register_mirror_actions(struct rte_flow_action *actions, struct mlx5_list *cache)
+{
+	struct mlx5_nta_sample_cached_group_ctx ctx = {
+		.actions = actions
+	};
+	return mlx5_list_register(cache, &ctx);
+}
+
+static struct mlx5_list_entry *
+mlx5_create_nta_mirror(struct rte_eth_dev *dev,
+		       const struct rte_flow_attr *attr,
+		       struct rte_flow_action *sample_actions,
+		       struct rte_flow_action *suffix_actions,
+		       struct rte_flow_error *error)
+{
+	struct mlx5_list_entry *entry;
+	struct mlx5_list_entry *mirror_sample = NULL, *mirror_suffix = NULL;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+	struct mlx5_flow_template_table_cfg table_cfg = {
+		.external = true,
+		.attr = {
+			.flow_attr = *attr
+		}
+	};
+
+	mirror_sample = register_mirror_actions(sample_actions, ctx->mirror_groups);
+	if (mirror_sample == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					   NULL, "Failed to register sample group");
+		goto error;
+	}
+	mirror_suffix = register_mirror_actions(suffix_actions, ctx->mirror_groups);
+	if (mirror_suffix == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					   NULL, "Failed to register suffix group");
+		goto error;
+	}
+	entry = register_mirror(&table_cfg, ctx->mirror_actions, mirror_sample, mirror_suffix);
+	if (entry == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+			NULL, "Failed to register HWS mirror action");
+		goto error;
+	}
+
+	return entry;
+
+error:
+	if (mirror_sample)
+		mlx5_list_unregister(ctx->mirror_groups, mirror_sample);
+	if (mirror_suffix)
+		mlx5_list_unregister(ctx->mirror_groups, mirror_suffix);
+	return NULL;
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
+mlx5_nta_sample_flow_list_create(struct rte_eth_dev *dev,
+				 enum mlx5_flow_type type __rte_unused,
+				 const struct rte_flow_attr *attr,
+				 const struct rte_flow_item pattern[] __rte_unused,
+				 const struct rte_flow_action actions[],
+				 uint64_t item_flags __rte_unused,
+				 uint64_t action_flags __rte_unused,
+				 struct rte_flow_error *error)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_mirror *mirror __rte_unused;
+	struct mlx5_list_entry *entry;
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
+	entry = mlx5_create_nta_mirror(dev, attr, sample_actions,
+					suffix_actions, error);
+	if (entry == NULL)
+		goto error;
+	mirror = container_of(entry, struct mlx5_nta_sample_cached_mirror, entry)->mirror;
+error:
+	return NULL;
+}
diff --git a/drivers/net/mlx5/mlx5_nta_sample.h b/drivers/net/mlx5/mlx5_nta_sample.h
new file mode 100644
index 0000000000..07b7589a75
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_nta_sample.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef RTE_PMD_MLX5_NTA_SAMPLE_H_
+#define RTE_PMD_MLX5_NTA_SAMPLE_H_
+
+#include <stdint.h>
+
+struct rte_flow_hw *
+mlx5_nta_sample_flow_list_create(struct rte_eth_dev *dev,
+				 enum mlx5_flow_type type,
+				 const struct rte_flow_attr *attr,
+				 const struct rte_flow_item pattern[],
+				 const struct rte_flow_action actions[],
+				 uint64_t item_flags, uint64_t action_flags,
+				 struct rte_flow_error *error);
+
+void
+mlx5_nta_sample_context_free(struct rte_eth_dev *dev);
+
+#endif /* RTE_PMD_MLX5_NTA_SAMPLE_H_ */
-- 
2.48.1

