Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862AC7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B4040E4A;
	Thu, 26 Jun 2025 10:00:45 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by mails.dpdk.org (Postfix) with ESMTP id B755340E4A
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:00:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgAgkqjeW8ANjUyuS48qobSzf5sCx+B4n/25T6zA2n1eycpHTOomku0+RaLGc9bISr9XbLPZQ5WyGirknM90cvaUuGvX6mBloLTnrooFposlltXVnwoTovRUDIpX1NE/EZVgEK/bZVDeGZ7OLwpH0T5JCKtD29OHh/Hpsv2seTA7ft/7lRd7wfu8ZA7i3N+sDUg+m74xbNWZejXn+ekamPOr5soaKVeD82kWE77Kryrn84yBTkU5lCzZLcvuIFJABkYnlnP7xeASy7sWvduVKygWEvJmbvya/JXYrLJKoFcGEdE7MCrHYqMqerTbahY6r6iiKz2gaTlO8m3xmMgvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gn/v03AUUW8Ol20dc0Xp+waPLyUTd2SH4WcXLYkMdI=;
 b=UkDyjJB+GHso3/u/g0qxmk5R2fN+JTod8W0oHMXzZOxo3epex793/DFQuJMK+arzUrwRbL8mk2kZVnXwsKiOozQ4mnZyXlUs7jHnlDv6POubdJcUvgpbvC8ebqF41QASe8nYeQ3SCZowDBM6r8wlALFVygushbYbgKxlqTENAB77wksFz69OyKxkZSviTUHHkZdALjFGq/qvh00lX1LBUPdfuODIwdVAiXc37DfkckeA0h2MKm/b07pewL9fRRWNYpa2e9yAwAe+A8WcLUg4AmBAE838Povnxa6dcLYl+JaRShngYFLyKxDGHOHxeDhi+12+iMLqOb7HGSaZF5y9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gn/v03AUUW8Ol20dc0Xp+waPLyUTd2SH4WcXLYkMdI=;
 b=bRaW8hLHmhmShZ63+J7GuTIZagTb8pZ8M82711JYtsYfkGgvY+Q47d7bdqFxSpOLy40LLyqyeiTgSFrWmD1moyuIzcdaC0S0P/sNsvjnR8MzQ4Hkk7cHSseHZ915mF8WEdnduEJRb2CIfMba1UODOPNZSocAk6ADHGDAKeTNuBT3gnX8heKi7eoNbyHWI0vIdgRn6la4nQ5boBa9wf1DemOwkv+olQzQ58I+ew2S1hHo0H8A99lvQJVRv7NdEj26bVjhngyqrhxom5Ll0CGWaFlDx98wvs1pAWCVxSW7WwIwVM4XGkAyMSzotNuiJ7VYQvBUn9+EzRZs3pqYUq/nlg==
Received: from SJ0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:33b::27)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 08:00:40 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ce) by SJ0PR05CA0022.outlook.office365.com
 (2603:10b6:a03:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Thu,
 26 Jun 2025 08:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 08:00:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 01:00:18 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 01:00:09 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 2/4] net/mlx5: add a stand alone function for mirror
 creation
Date: Thu, 26 Jun 2025 10:59:42 +0300
Message-ID: <20250626075945.537256-3-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 219ab9c0-f4b4-44ef-3238-08ddb4878a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5e2YQ9916g8cLBUlXj0XdPFrNAUaGEx3LM9JkK+XNfveGhT9prNYdZAhtK2f?=
 =?us-ascii?Q?8znDu9pB2BTWbljrDoh4w/HSkPkqnnvkz2vPSQfbWmnUzs3MCfAehu/nZu4M?=
 =?us-ascii?Q?Y7+1rf4QRis80Rnonz1C/Hr1+SMwIpzmKQrlfPcuEAYbZyimaBJouFnQ4gQb?=
 =?us-ascii?Q?AfA53nV9BM7sQa31mhe5P53gV1dK4dx3SPh5LT+qaCJRZeZguDPeaZ46TU2s?=
 =?us-ascii?Q?naFrD5JdEAfitKOc9080xoVaAIcLb0UsrvLBCfp1WzLN6Au0oyIuE28w9p1t?=
 =?us-ascii?Q?+7Ut1l7Yt1wzVbAhh5Vdq0Sv/JF4LvTy7e0HUpUJqoSWDMX+qu/SKlOwZt+7?=
 =?us-ascii?Q?TusbxKsVY7fOgGdHvXViTV97JYyLwPOVqQi10pop3mCD0Ctf+AZ9487f7YDm?=
 =?us-ascii?Q?CFC2+wEyBrj9nS2/mcnobZ+hxACLW3mefT28ng1e6dS8rEBn/e2DugVNhS1X?=
 =?us-ascii?Q?AmKzGtzDzHqmsTlIQm++QsWWhIxsxcUjdD4/yS5HX6PyNWWPlyMOWmMDEA8X?=
 =?us-ascii?Q?8OA/13RcH8ntFB32sOhy28i1FxZogMNCUbN95qb/v64C9eTJkg+Krd1SWlW+?=
 =?us-ascii?Q?tAJ26gIgJcQbAG/LUjo6DIeEgoe0AexvcntK1V40ZvLSawQlt6mJA7IJD27h?=
 =?us-ascii?Q?LUv4wcX5Yb0hNB+eE/miBCqz2w+ZFG4Bmt7r0UidPXkcB5wGL4MbSHS/UKyl?=
 =?us-ascii?Q?d5+2t5Qf4wgLrHGbGqlrbyOr9HsA5ovhjPU6YHOmo6xC1GrpSZX4l/DLrFTe?=
 =?us-ascii?Q?soKQP5m7ED4F9Fmea701EuCql+TPKexI+N8E8Nbns0yQDGtXiPL/0rZZMlNq?=
 =?us-ascii?Q?b+KQAccyItjaZzcnk/RAyhthBI9DU0fkljUimZvalXJSzQynDu9XNWc/oNcE?=
 =?us-ascii?Q?CUvJZ2oysiTGlfPk7q9HuCMSu9vpL8XedHXym2EJj0pFSymQe7T5wjVTum74?=
 =?us-ascii?Q?YGH2fFi39zbWDcAQ9gC646dxwgr7ffGIqF6raErJEg9vHCdGv72AC6Eo5FQ5?=
 =?us-ascii?Q?I8IkNg/8BTi724rNxZ4xXBXBjPop6vUL2abVjw+ohcQAjfkTIy5a31PiazMn?=
 =?us-ascii?Q?LZs1XG8BFHFTlhz3l+V0Z4T4h/xclfIfJQqqSKX1k6rbv4puxrIrA2yMZdiE?=
 =?us-ascii?Q?CTWHKdLQeiy6zkM0QF02B2GcMcpAJE4QOX82meSctJqI8YEXNwbrQXrmPfEo?=
 =?us-ascii?Q?3TAjrOy0wq2K12d4IT3nSs9ARMwQCZoATdyprC5QjK9EJIpyieVdhqwEGx2x?=
 =?us-ascii?Q?CCtxlTCC5WtyFCb4/TZdsHWfd6Y3St9/9Ka4m3Dmwhfg8WWjjghB+7b3VfkX?=
 =?us-ascii?Q?bKEYgVJQL0jUbklIpKRvj9suTetnQ69ecV06CkoJvk69qfSU6nX7Ut8KZrjv?=
 =?us-ascii?Q?i8YgBEX5kP8hWRQVmdZ0f/hi+9gAO+Qlqp6L4lT+Dd4NdLmM7jqO8vrlulJ1?=
 =?us-ascii?Q?6Lqz0/hXVXeqrfS+vG6mp0qe79HSP9Op6jT3SMiAHm3UtQU6/gjH7pjcHjF5?=
 =?us-ascii?Q?z7h6vhgBPXkQUmxS5PMwN1RbDPaxK9Niv6hX?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:00:39.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219ab9c0-f4b4-44ef-3238-08ddb4878a83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
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

The new mlx5_hw_create_mirror() function separates existing HWS mirror
functionality into mirror action creation and indirect list
handle creation.

The new mirror creation function will be used in non-template SAMPLE
action implementation.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    | 21 +++++++++++++++++
 drivers/net/mlx5/mlx5_flow_hw.c | 41 ++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 9816ed9238..23c5833290 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -201,6 +201,21 @@ enum mlx5_feature_name {
 	MLX5_SAMPLE_ID,
 };
 
+#define MLX5_MIRROR_MAX_CLONES_NUM 3
+#define MLX5_MIRROR_MAX_SAMPLE_ACTIONS_LEN 4
+
+struct mlx5_mirror_clone {
+	enum rte_flow_action_type type;
+	void *action_ctx;
+};
+
+struct mlx5_mirror {
+	struct mlx5_indirect_list indirect;
+	uint32_t clones_num;
+	struct mlx5dr_action *mirror_action;
+	struct mlx5_mirror_clone clone[MLX5_MIRROR_MAX_CLONES_NUM];
+};
+
 /* Default queue number. */
 #define MLX5_RSSQ_DEFAULT_NUM 16
 
@@ -3722,5 +3737,11 @@ mlx5_flow_nta_update_copy_table(struct rte_eth_dev *dev,
 
 struct mlx5_ecpri_parser_profile *flow_hw_get_ecpri_parser_profile(void *dr_ctx);
 
+struct mlx5_mirror *
+mlx5_hw_create_mirror(struct rte_eth_dev *dev,
+		      const struct mlx5_flow_template_table_cfg *table_cfg,
+		      const struct rte_flow_action *actions,
+		      struct rte_flow_error *error);
+
 #endif
 #endif /* RTE_PMD_MLX5_FLOW_H_ */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index a8a3f3872a..a7162d5859 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -327,18 +327,6 @@ get_mlx5dr_table_type(const struct rte_flow_attr *attr, uint32_t specialize,
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
@@ -14589,11 +14577,11 @@ hw_mirror_format_clone(struct rte_eth_dev *dev,
 	return 0;
 }
 
-static struct rte_flow_action_list_handle *
-mlx5_hw_mirror_handle_create(struct rte_eth_dev *dev,
-			     const struct mlx5_flow_template_table_cfg *table_cfg,
-			     const struct rte_flow_action *actions,
-			     struct rte_flow_error *error)
+struct mlx5_mirror *
+mlx5_hw_create_mirror(struct rte_eth_dev *dev,
+		      const struct mlx5_flow_template_table_cfg *table_cfg,
+		      const struct rte_flow_action *actions,
+		      struct rte_flow_error *error)
 {
 	uint32_t hws_flags;
 	int ret = 0, i, clones_num;
@@ -14656,15 +14644,26 @@ mlx5_hw_mirror_handle_create(struct rte_eth_dev *dev,
 				   actions, "Failed to create HWS mirror action");
 		goto error;
 	}
-
-	mlx5_indirect_list_add_entry(&priv->indirect_list_head, &mirror->indirect);
-	return (struct rte_flow_action_list_handle *)mirror;
-
+	return mirror;
 error:
 	mlx5_hw_mirror_destroy(dev, mirror);
 	return NULL;
 }
 
+static struct rte_flow_action_list_handle *
+mlx5_hw_mirror_handle_create(struct rte_eth_dev *dev,
+			     const struct mlx5_flow_template_table_cfg *table_cfg,
+			     const struct rte_flow_action *actions,
+			     struct rte_flow_error *error)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_mirror *mirror = mlx5_hw_create_mirror(dev, table_cfg, actions, error);
+
+	if (mirror)
+		mlx5_indirect_list_add_entry(&priv->indirect_list_head, &mirror->indirect);
+	return (struct rte_flow_action_list_handle *)mirror;
+}
+
 void
 mlx5_destroy_legacy_indirect(__rte_unused struct rte_eth_dev *dev,
 			     struct mlx5_indirect_list *ptr)
-- 
2.48.1

