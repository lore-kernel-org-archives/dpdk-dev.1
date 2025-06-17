Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB985C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:40:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BCE340FB5;
	Tue, 17 Jun 2025 15:40:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by mails.dpdk.org (Postfix) with ESMTP id 6401840FB5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:40:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB0X4+Ti/EDJ0pDT1zt2HngpjJUgsU6qZFqJ+r6s5SPBSmNmO8HwCOdrMrkD52kjnp3JohsM2quV4U+7kA6MNqR4w73ZLr5yWCvNaGo0WjIcN4FM5vFhDtNX77b9bVDdlkgOjzbOARkYvAKbcmYYkly9x8MZUCr6kJ/XiFxkHXcQFJH7FohXB4d2/+yJgeN2hPnohnicF3Wb8ViBHdpJzvVRmO1r1cKjDaOw90TqnYVIVbk6Aa00Gw66Tf2l+rGqdM+g4L7FVklqRZbhQs3+bBDLTwGgHTV4sVcC03R9hIa3uFTMzBzHtsArP2SkWj8yVRw92OnI+sHxmkh1Q2lB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euKFrVQ61YWqk8/T5GXGC1mAoy+ajsAQLRQ+bqawHGE=;
 b=ezqaClcEaus0FfQD1mZMkujP8vcn0oOZzVNV1eRELmkNNs91dRk65hInBlsFGN7UFvW1po6pZwxuie2zrNj+5SnDc9nCCCTKwBXLNNlImt4DyDz4ohKGkD7InQDhy7YAbaBCx2k7GinMyZJphH/A35mlp63D9PGUsTfzNqBx1flaYjU/0OCImX2InuRsoAZf0ERuPwQQ0uQw/3uEFZVhmb1LpUn0U9EbR0v1VLzQKqbWV4HHuQpGvIJNBPcfilAKdw/U8nvBUhByVVVwgyDqUWmwkzSdjMmC/nppQEwVbmur3hhA/uElalFWkRbXEEjnNQ5NBd31h0hdTnNPBeNzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euKFrVQ61YWqk8/T5GXGC1mAoy+ajsAQLRQ+bqawHGE=;
 b=kr6OQ+nGtdmbKPPJZNTdvM/lFPsdTRWv3G8k13vo7IsGWHa2mYyfDjpIgueKCDVQtktMhTqztEVmzKCyRWdWAUWXZIXSh+W1bdJtS08KLWZmj1LUKJ4Uk2a3ma5bSQ6Ql2zNNonXyEaHnTj2jHwwMnRJ4eWWG5/HL8H7pFxtcIkl26Cb9z7KDx7KyiK/1jkZrbg+oDaWo6NcD3kipQ0B9qdkpgqZAyLKMDYI+j+C2saa3uUGY+gvLtvm90F9GzUJxmLUpkFUprdIV7qma/Cxc0KzAMQ/2/B7I29h+H8DqX3KVONkq822GJPrqXA2XeOfkmT584GG8xmMwfulBH0HFg==
Received: from DS7P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::13) by
 PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 13:40:16 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::bb) by DS7P220CA0049.outlook.office365.com
 (2603:10b6:8:224::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Tue,
 17 Jun 2025 13:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 13:40:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 06:40:04 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 06:39:59 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/5] net/mlx5: add mlx5_hw_create_mirror function.
Date: Tue, 17 Jun 2025 16:39:30 +0300
Message-ID: <20250617133933.313443-2-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 940565c3-40e2-4e29-b11d-08ddada47e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5DQnN3BfUbqfLyJSZgw4al1veLwAUJ6F52NHF6LSEdYjFWvJWUBppDGUWL3s?=
 =?us-ascii?Q?q3gN2mdd1J8QvAxwz4dHrrAoupig6k10xiNDgstmIE9Vt68iY+57Qah4/aGH?=
 =?us-ascii?Q?ztB4RTJx2iwXtZk0q0nOCE2Ge3xOaWzWyvYpCp9BKLYgW7DnkVLVMZAI32sJ?=
 =?us-ascii?Q?vjmrSojBvRKx5hYvTC5jWhFLhStG23H5w5IAYjbK5rWM4GuaxaUX3Y0jBQjQ?=
 =?us-ascii?Q?16PjgeJiv4ixXw6NNXQ55ezvTGILQyO4TVxmQ/pu2QgPBlqPIDrX9LQtRdzy?=
 =?us-ascii?Q?AmZpL2p55u504Qdtn+dG1AoFPBHY0d+0TpjQjJCP1TjNE47uaE+azEt4Wi6B?=
 =?us-ascii?Q?6P49TY8kKJhhgr21T41bFY2BqjrzeKxbgGMAL5/fvANYPCtalYLafFseMunn?=
 =?us-ascii?Q?Jdsyn9Lz0ZDR99lBv3jzvEtPYLWUa/m4K0Htc4GX36vNHGitCX/2Uu6grBWO?=
 =?us-ascii?Q?dPW2EqR0ibN4H+JPUJqiReNHCCy7nb0RDHr72YsR6/CflKGSgO5ezqPCik9c?=
 =?us-ascii?Q?GWT0m4j9tCTzQXq9cFylcAT5qtU1nYv1UP/oWrJ2PeNthvGMOew/ptQsIIbU?=
 =?us-ascii?Q?UWeMmO2JLIY2kAG0wOTqc0raxP7HOVr7GKdGuHNZZCzm4hhzGDGC6kSzUwof?=
 =?us-ascii?Q?No9xZnkU5D3O59InwXkaI9kG48tD3tbAirwnOTaKW68Fw6G8NUccrL9C2zIu?=
 =?us-ascii?Q?gztNwj9nwm+vuH96DVpcBGFJNp1GGZjqr28VE6h9XI1Y6WfOwo4d2qDOZBb9?=
 =?us-ascii?Q?MvV8Q2ByKasnh19cU5w35c9ARzxF6BRch+ahXr1LoXcU14WXJLitxdjRLkdI?=
 =?us-ascii?Q?zAWZuwhGQxnbh8aF9RVpkNOJRh/5r6MU8eyA2mvQjdB5EFbU8/qKOri3yKuk?=
 =?us-ascii?Q?oYeVeC5tjIqMa+9r9ZhpiAgKzmKRqHtzagmg9vuGCWNkrLfQXGsX7NyThl8x?=
 =?us-ascii?Q?ZEZqSYtegDzzp7LRAxDh272lPX2bTJK5Paw46VOIouSnlzRVHjwQHlFb7TWW?=
 =?us-ascii?Q?kKN9FQVxpXVoN6uz5jnPcAGxPEkuLkUhwjk1Vu7zYqkleH5erwJlPReli0SX?=
 =?us-ascii?Q?nZatoypo23wCxKZKUrTzX6z7AHOdk4paxfm6nFasFPtFTQlIf3tJ35GdQ3pI?=
 =?us-ascii?Q?6dtO6rFRcWPxOjbOz4gzpQ4ZyS7encqpaMjbOSbbsp3fOaizJWexbjmeN52c?=
 =?us-ascii?Q?A6I1qlfSpDNbla0+j8UfP/Lecuh8tIwqXEhKU4kjaXY5F1cOwQIZIrrMBBey?=
 =?us-ascii?Q?e3+NXQCEqW7VX7hDLCVtCvGi4pyES0jPh17S5LknOmVwUE/qg/3/GvK4xDK6?=
 =?us-ascii?Q?Ppghu1iPwiia8JpMA0O0a/CTaDsngGL4nu6zheHsS58QTHGpd4s1aMoTpUrc?=
 =?us-ascii?Q?ZENIrzTlAhaemk+3+VnIWFNwJLUJPGWSFXfN01MB7QyJEQHm6+eNmDP3RUv8?=
 =?us-ascii?Q?UuS1ma/4dL5mCuODLaGEz6PDphFEI0R2CAMhj/YllwuazxMKPZ1NxppcCtyv?=
 =?us-ascii?Q?28wNIyJeuCx5446ljaDiZMdYT0wPs+Cnad3y?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:40:16.4175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940565c3-40e2-4e29-b11d-08ddada47e85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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
---
 drivers/net/mlx5/mlx5_flow.h    | 21 +++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow_hw.c | 29 ++++++++++++++++++++---------
 2 files changed, 41 insertions(+), 9 deletions(-)

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
index a8a3f3872a..9b3e56938a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14589,11 +14589,11 @@ hw_mirror_format_clone(struct rte_eth_dev *dev,
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
@@ -14656,15 +14656,26 @@ mlx5_hw_mirror_handle_create(struct rte_eth_dev *dev,
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

