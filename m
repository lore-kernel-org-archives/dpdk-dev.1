Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FDCCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0070C40687;
	Tue,  4 Nov 2025 18:48:04 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by mails.dpdk.org (Postfix) with ESMTP id 4F34440684
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:48:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtb0usCDTyJfM4vFEvDKJYAYHYfLyY3CQraEnpFiIQIFMc3SJuockK2ILV33cyUGMTutff6MIFHihaMl1luPZh6Yby92gkpVv5b4+2cFEROHZ4jFqKpvvUez4CVh8cal2Gi4hV4sWs4Xf9tiXULoluPBGhjUoro2KQ7V+cLYQc3SPz8PH3Hu9d/DkaiNV6RtOANvbyL8AosCI6z623ECtUNyg5f2tLFQ7ym5ST2mkJ3t7YvUhDa1npyN0hLgBvSk7o04Jek7y1YOUm+Mb36vAwc+254BWQzBGnQRTZTlTXOj+ChX1ngSMiJjZpAQfh3Ke8VD7wwxL4l1UWsXGCct9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+GhAx4og9Ej+uS9NBvnrl7oAuxV6N+xutN9zQZI0+E=;
 b=QYNHJlSQT5iB8SX0WdMNlHafR4itveD06UZ+wahn6T6iiof3mjatWP57riT2Di/JzLfltA6rOx251nXp43or0G+eNh+AgI9F/P6elDb7FKa4bHfVJ0YndMUgKnPVmnlZhxTFCNJcgR/NTLi3bPCh+jmdrr6l7vQHI2xbhLw8WjsufzXtk37uYHGYEvMvCTVKuZu/Q1cuTJGf5votV2w+npyrZa+cZv5614zde2gczeh+/vjMep1Qdw7mITVC4ujn9kQBqn5CQS8AGhCuvo9vlrC5nmmlBTO/6wGgA6jc8spwfe0R8503OpKVlU37g9SPqwxHcTrN/L28EinaJtVyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+GhAx4og9Ej+uS9NBvnrl7oAuxV6N+xutN9zQZI0+E=;
 b=pA4loxr2x5NGiK9mq1M1MqrT0L+Ynj+J+WC7BXlqmaT4i5beysNZEcuVm/93W7OEWLcal7OyuUl8mLoJM5QMVC1itLyl0JtFetKvf95tYShW19nQB/ahCuDu6vhAleFJlTGo01U93hEv5GvLEzJ+cwfDlm3L7wJVyNg+qZfy7URWXlfUM/oUvs7zvPLUuiReT9CvsL6W5vZwp2HFI3AsgUJ1MJuxxbyqbicYlRyqsSsVDMJ4Bukr2mqvYtqfOpKxcOVd+CeYQW0XoH1TOZ7tEhMzWGj3vt1vv6TASg/+uOCtwTNrDwOiCxQdQwjKnM5PiqgkGblRoPCu3YoLqopxsQ==
Received: from CY8PR02CA0023.namprd02.prod.outlook.com (2603:10b6:930:4d::20)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 17:47:58 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::a7) by CY8PR02CA0023.outlook.office365.com
 (2603:10b6:930:4d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 17:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:38 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:36 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 3/5] net/mlx5: rework root group checks in table create
Date: Tue, 4 Nov 2025 18:46:10 +0100
Message-ID: <20251104174612.1341962-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104174612.1341962-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: d69471b0-9b0e-4c95-0547-08de1bca4aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3GRd9DiuCpRs07P8WjuL8V2K9mRauONTIlKqVfqu9deZ0aUnzVfNfohhAsjx?=
 =?us-ascii?Q?hJ43FRjtRdxdCoLlxQ4L4Ug3dQ862ciiW4yLwC0YvpgyxcS8DKRHt+ooB1D5?=
 =?us-ascii?Q?4HAyFNA7jqlaanoz8XxUs58k5Fx3ctPbE1pp3H8sRcbdgWPDMiko6QTrbVps?=
 =?us-ascii?Q?C7d9F0oxB2J6PP6c8dlX/cqlu2vVJJvILhk2lM0lomBQ8w+ggbElaNDhCKXW?=
 =?us-ascii?Q?ioQre70gzFYY61d722Qg+Cih10KXF2GKpoBLvu1BpCSk4YBDOEt7od9Mpq7C?=
 =?us-ascii?Q?TdSSsKOgnyaIUDiDZ5nAbIeAiHvh8bz6T8wd9Fwr7qoaCYIw2Jk+uTDPM6gV?=
 =?us-ascii?Q?aH75apmci9OsGv1SQ7GmShwLuS85SC4Kh3jywpFL+7VbZ6t/qj6/h6uE2nRG?=
 =?us-ascii?Q?f7qXt8ac50bwNDxLBq6Zr4pnJ5wttbYSrX5T5sdB3nPEw1lxcKzDX0NeZO3v?=
 =?us-ascii?Q?Z91M+YpcAZk4C+7ztkbTBktdG8ZR9igYRRtUCzXvq6sZWbO6lGjfPX5QCcwQ?=
 =?us-ascii?Q?2r4shNVUQjHfHPRlbH/TxrM6oKrp7mS/AXSP66k3J76Lz8Z4H0x+sgsfRBIH?=
 =?us-ascii?Q?tNU1l4AhNFj2sN7WSxT8SgUKWfKbbTXZe6V+07zmJbLAOmIcCMucL0dYp15q?=
 =?us-ascii?Q?OopHriqYUgGJcUfamVpRN19V/A786PP8tuP/waldWABn1yry3oR21Qebkgot?=
 =?us-ascii?Q?6LQ63QuXxSoxB5nryYYGrUpsJLs6tMtOpfhbmZLLp+x7noRHMnZYztAIU/yv?=
 =?us-ascii?Q?mP/tlDUgejDF/96ZuqomNAHtl7UBMGNoJcR1cGzJ/XQ42EuJ90qsNxngftCF?=
 =?us-ascii?Q?EN1WG9ISSiPSnKIOVP1c7rRaeq6Win7CIPJ9TzmEkTlloXx/A70nXia1azKh?=
 =?us-ascii?Q?O60QmDDkQ81+NFbcocXQL1R39yJnUoxOF3H/0PIdfZ+LIY4Ralp0qc+14Ylk?=
 =?us-ascii?Q?ossO7wpblvXchu2DRyCZucKOVhtNF0Pr/8dwjYxlTyHEmefRVHwpRswUlcKk?=
 =?us-ascii?Q?J6fHZsZDqOgeFAAQEZFSPmqYpeegikWEdzmbK//NniY8XV55IHvM+nTr0Pwj?=
 =?us-ascii?Q?hhOfoS5/9a/IObaxby/NZm5WR2WtTRO2iBFkWrPr3HoAspXDFq9+uOZ1kUrL?=
 =?us-ascii?Q?VlmnQUzn1BDYNq/XtJf85epRXfvAq2E3mL7/YXvsKqdS5JaI5C5jRjxXUvAA?=
 =?us-ascii?Q?iNvoQ4hnbXp3WSxLmdbhJs4vYVLqWpIsNjOjzjYUv+1wJEDFaHOAf6sAdsah?=
 =?us-ascii?Q?eYS8BwO1KijB6Vjc+JnKtAfRiDCrczdQZT/aQpk8H6SNecyqPd4yYarFlRKq?=
 =?us-ascii?Q?dmwfGhC7EGD7m11W+fVlQrijPwjPx2cvBWEAtotpWpWRIsofr64tPKOr2hUL?=
 =?us-ascii?Q?ChsrVOGinjvSx2dg8XqD3s9AQ5i1BwKE2oGV+OZqDNFdQ3FtOTzSN9o7CVfs?=
 =?us-ascii?Q?AEZ3Uwyk/f63MolnCzkEedqEFz156MyHHZfVUwDALVda/wZ+znOB+IAtFBvq?=
 =?us-ascii?Q?9ZZlrmHwvYVRwFdSR/27gv/8bR18uUVgYGMmvwnKjavKe01u7vLONzfosb6Z?=
 =?us-ascii?Q?zGtZrHLZmNIl0BgrSJ0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:58.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69471b0-9b0e-4c95-0547-08de1bca4aa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

Before this patch, during flow actions translation done in template
table create, there were a lot of checks for group with index 0.
This group is special, because flow rules in that group are created
through mlx5 kernel driver.
For this reason, this group is referred to as root group or root table.

This patch reworks these group index checks for clarity:

- A dedicated function for checking if group index refers to
  root group is added.
- All direct group index checks in actions translation are replaced
  with a check for result of that function.
- Redundant group translation checks in actions translation is removed.
  Group indexes are already translated at that point.
- Root group check for internal default miss action is removed.
  This action is supported on root group assuming rdma-core supports it.
  If rdma-core core does not support it, then HWS layer will reject
  accordingly.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    | 17 +++++++++++++++++
 drivers/net/mlx5/mlx5_flow_hw.c | 34 ++++++---------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index cfdd47ef50..9b0afa427e 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1658,6 +1658,23 @@ struct mlx5_flow_group {
 	struct mlx5_list *matchers;
 };
 
+/**
+ * Returns true if a group with the given index is a root group.
+ *
+ * @param group_id
+ *   Group index.
+ *   It is assumed that provided index is already translated from user index to PMD index
+ *   (as is for transfer groups for example).
+ *
+ * @returns
+ *   True if group is a root group.
+ *   False otherwise.
+ */
+static inline bool
+mlx5_group_id_is_root(uint32_t group_id)
+{
+	return group_id == 0;
+}
 
 #define MLX5_HW_TBL_MAX_ITEM_TEMPLATE 32
 #define MLX5_HW_TBL_MAX_ACTION_TEMPLATE 32
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index ff68483a40..de004f8c1c 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2507,7 +2507,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	unsigned int of_vlan_offset;
 	uint32_t ct_idx;
 	int ret, err;
-	uint32_t target_grp = 0;
+	bool is_root = mlx5_group_id_is_root(cfg->attr.flow_attr.group);
 	bool unified_fdb = is_unified_fdb(priv);
 
 	flow_hw_modify_field_init(&mhdr, at);
@@ -2519,7 +2519,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 
 		switch ((int)actions->type) {
 		case RTE_FLOW_ACTION_TYPE_INDIRECT_LIST:
-			if (!attr->group) {
+			if (is_root) {
 				DRV_LOG(ERR, "Indirect action is not supported in root table.");
 				goto err;
 			}
@@ -2529,7 +2529,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
-			if (!attr->group) {
+			if (is_root) {
 				DRV_LOG(ERR, "Indirect action is not supported in root table.");
 				goto err;
 			}
@@ -2550,10 +2550,6 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				priv->hw_drop[!!attr->group];
 			break;
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			if (!attr->group) {
-				DRV_LOG(ERR, "Port representor is not supported in root table.");
-				goto err;
-			}
 			acts->rule_acts[dr_pos].action = priv->hw_def_miss;
 			break;
 		case RTE_FLOW_ACTION_TYPE_FLAG:
@@ -2745,11 +2741,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			recom_type = MLX5DR_ACTION_TYP_POP_IPV6_ROUTE_EXT;
 			break;
 		case RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL:
-			ret = flow_hw_translate_group(dev, cfg, attr->group,
-						&target_grp, &sub_error);
-			if (ret)
-				goto err;
-			if (target_grp == 0) {
+			if (is_root) {
 				__flow_hw_action_template_destroy(dev, acts);
 				rte_flow_error_set(&sub_error, ENOTSUP,
 					RTE_FLOW_ERROR_TYPE_ACTION,
@@ -2773,11 +2765,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
-			ret = flow_hw_translate_group(dev, cfg, attr->group,
-						&target_grp, &sub_error);
-			if (ret)
-				goto err;
-			if (target_grp == 0) {
+			if (is_root) {
 				__flow_hw_action_template_destroy(dev, acts);
 				rte_flow_error_set(&sub_error, ENOTSUP,
 					RTE_FLOW_ERROR_TYPE_ACTION,
@@ -2792,11 +2780,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_COUNT:
-			ret = flow_hw_translate_group(dev, cfg, attr->group,
-						&target_grp, &sub_error);
-			if (ret)
-				goto err;
-			if (target_grp == 0) {
+			if (is_root) {
 				__flow_hw_action_template_destroy(dev, acts);
 				rte_flow_error_set(&sub_error, ENOTSUP,
 					RTE_FLOW_ERROR_TYPE_ACTION,
@@ -2855,12 +2839,6 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case MLX5_RTE_FLOW_ACTION_TYPE_DEFAULT_MISS:
-			/* Internal, can be skipped. */
-			if (!!attr->group) {
-				DRV_LOG(ERR, "DEFAULT MISS action is only"
-					" supported in root table.");
-				goto err;
-			}
 			acts->rule_acts[dr_pos].action = priv->hw_def_miss;
 			break;
 		case RTE_FLOW_ACTION_TYPE_NAT64:
-- 
2.39.5

