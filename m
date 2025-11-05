Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F8CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5E1D40A7F;
	Wed,  5 Nov 2025 17:54:45 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by mails.dpdk.org (Postfix) with ESMTP id CDD6040A6F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:54:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/TWNTLkyO04C+jytMKfexDPomYMEmoxNiiVtuBworV/xjA/ouO6FmGG1AsIpXwy20a/WKehQN2xtzGinWQS7vPCp8AsCcX+/IiJn/pr3yQ3ClLHewuieonJOjs7IjE0EXAl/fKMkJQhLbalkbqzTQVvVHJcoNSs5wiE/45wc8INURNiUxSL8m3OB6ZvEW+M5+zSMB69nYdVNyo1ESNgkt3K93J91ay9hxKgIO/5xnN2a68ISkzJtpOklC8gP2VsbY68GkiA59UlKAA/Na0cZCWTM56KgNYu3epRmDsUKINiAEZOsBIahbpVCsZgbjXrbqVWCu41nZO3a7gQpcpW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUC4vRt+/097glqxoRUmLk76eYWZoedKRUu2HrgelFc=;
 b=V6RpcLS0VpnW51Emwallmsb1xjqlvNe03ZMPGKFMf3tscLyhWBYSQwD4qbxRqCUYUpv4hCvaw9e8gOXExIXWEamXzTzUUooiuOJOCICv7vRRRIIotNSWiFaeDN2DNUt7YHmfQUhHDuqnMOS4j6dyxedNMheRcGaMLbTQoNVw4xi3yM4KYTWBnI2lhVJmYb5NvsVEWtVOkm6DNEf0AhxmxnSiwE3H+AKGNej4b5Ic4C5szdG1vLR1Sa4pS7+i6c1kSzhVmx+o4uw3edDaIhwd3w0G5nwChdl8BqRmLZkmoyPUst8VM/Y3+x79rbQ0jkDVtExDr8AR+9r/C1F4m2G8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUC4vRt+/097glqxoRUmLk76eYWZoedKRUu2HrgelFc=;
 b=mZln0fzqPLVhFcRnIRrbqPftyQQztDChOpQv8Qd6mpm1m+TRy4xP7FmkiUopkZquIrydLjEZqqVp1ME4TjnVsX7GGtE02SNuAGVcqFeOVmgsQaXS5C1X6Lmiqc7/Uqp3VyePBm1Nmbl83iocfOrH+lMY+E3/q1WXu6CHQJkHshwjdzkABK+4AuO4XPcM7SQwAWw3AyB5n/86coCDuWz+dgxnsJg/a1I2iUgX1dqF7HPoChP3TRgFPU2Vie7EExWRfhjdn6zLYrStXQDDJZRlCjmj3+CpnF29XRZcvRQ/LRlLN9ovrogKHpmoQI0jDgc1iJaTogKG/xnwcuRohcSjxw==
Received: from BN9PR03CA0459.namprd03.prod.outlook.com (2603:10b6:408:139::14)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 16:54:42 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::f2) by BN9PR03CA0459.outlook.office365.com
 (2603:10b6:408:139::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 16:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:54:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:19 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:17 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2 4/5] net/mlx5: rework root group checks in table create
Date: Wed, 5 Nov 2025 17:52:57 +0100
Message-ID: <20251105165258.1396352-5-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105165258.1396352-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
 <20251105165258.1396352-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeff696-8d0e-426c-8541-08de1c8c0407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VyRFyUcSxEI61+kgqzlp4ZT+1PfDjKapmbNmGwNVLNGZ7ouUwyd72hUFJXd6?=
 =?us-ascii?Q?Yat+7b4Fu/rzrzgL4il37hjUKf719930I3d5qkIWSg2jiHWePR7xfeaJICGm?=
 =?us-ascii?Q?sB1rwM6yxXw22HuTKzUtJqSceElJDOO2AfTWF2Yt4ZqXu/kE331aSjgnRur8?=
 =?us-ascii?Q?/fJOGaAhF5ZB68PFZAGBSfUQ5PRumpTt04+yd/22Snl1F9KowkIqiogjCPzL?=
 =?us-ascii?Q?GdcKuwia8CnsJcbVI1HaMoIomEZkpXuwa2XG1ZzPcmB6zDgklgwsQyw2Gmjx?=
 =?us-ascii?Q?zCyZV0v/Xe6GAghT1NFwWTEFkK8J9rbUri80wZCphUgn8Wo2DeJPARHyuZV4?=
 =?us-ascii?Q?gLIqQ/IxPGBppBc0I+lUTkeyT7FpTRwPsisWqk/RG9+EW26jega+UVF3Z2wW?=
 =?us-ascii?Q?530LCbWEcuqJ6+vCCgoYWOBBiqzjODpWeTQoW1DEWoNsNmvuyQ5RCmsVvvCz?=
 =?us-ascii?Q?OlU7ELgK1XV4LjDLLoYSo2TWHMoeAqUxl0ELY1gp+iaUVy/rGjUlH11dhpYQ?=
 =?us-ascii?Q?Wz0eNAuyw1bWhh7gjaKdzKFNUQFkaxg9pkkzt7mtt5Hdy/nKV3P1b/VwHSTO?=
 =?us-ascii?Q?Ir77mFWuG5Yd5T+M0/mDalgLXTeOJ0/6HIem/Sx15oN96AhPnjeNCRa63/bG?=
 =?us-ascii?Q?9RHpr2Zs4guxJXxe/kvf7uwOesjLSYcD3rxc7nwDWkL739NOpky09E7KNCG5?=
 =?us-ascii?Q?eQbU9jULGvaOqdooFdeRvsYUU35qJbpX70TdBV/H43Udq2z01axRpX+P8jv1?=
 =?us-ascii?Q?NWGFCjhDoAd6ZfE9KO9zWNC4Px/GJLRVC7bDkpxEVjNx/FLJweKHI0hEQhVc?=
 =?us-ascii?Q?gkG+XFPBL6Qa7nCmg8KuF1Llv84c4Z+VyChTBg7mTRI7tyIY0waB7JizOP11?=
 =?us-ascii?Q?u3me88wz+Lsv2TOtHmQAVPqqy6iO1AmIzteZ6r57xQDeNQzqwZKqlv+Q7rZT?=
 =?us-ascii?Q?D2aOYeMnrsRFNYjLiUtJKAIUeOl4wStYNM87WB4c1vEEiax8g8ElAFGKFqS+?=
 =?us-ascii?Q?A8/RpbGrZrXnkIS9QaUUOeKbkfBU5ka2xwREvOnMaSDMVy+4e0LqRQ4q7cAK?=
 =?us-ascii?Q?iFkOvKgTTv73c+ALeCHMYs4tgxnpsk8CfjcekRq+IMWoT3lmdTyDh1SSZ/rw?=
 =?us-ascii?Q?Xons9AGqli7ZhyTkG5WUmD2UTbzMfyUOD3Gaoacq5CI8BmSJh9R28i3b7yjr?=
 =?us-ascii?Q?AUmmumgITCGFSGLPKzJQmT29wfrpZ0loTF/ZNVtsfSPfJo36rROb2eoM+ewi?=
 =?us-ascii?Q?SFF46DL3NFUgPAjZHeOatGbpHzYGOdnQjySGO4DQDGvm8O5RkNWr6hLJqRDG?=
 =?us-ascii?Q?z92sw/ngNnCYgv4fOKP4CvqHmdGIBVE8P1n/VMO8rEiCwHrpS8iYFUXsRLaV?=
 =?us-ascii?Q?S5UZzHyM5NH47V/+QCKKAFCpDSXpfpkIakgjeN72/hTpg0looASbZJU9vUBo?=
 =?us-ascii?Q?ZVVoL8qnQBgcOfBD3gnLCbT657GqG+NjIvltzozhqYqDQzqyoVKpgSbKiHmG?=
 =?us-ascii?Q?1jGpmqjyl6oxGtQrK2nr+dpSHpc3Qb1vDLUlHFIn7dBTrRXxlBuxVzIfW6P4?=
 =?us-ascii?Q?AOZmnKXKWAsZUo4ZJEY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:54:41.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeff696-8d0e-426c-8541-08de1c8c0407
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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
 drivers/net/mlx5/mlx5_flow_hw.c | 32 +++++++-------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

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
index 19975280c9..bab081e775 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2523,7 +2523,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	unsigned int of_vlan_offset;
 	uint32_t ct_idx;
 	int ret, err;
-	uint32_t target_grp = 0;
+	bool is_root = mlx5_group_id_is_root(cfg->attr.flow_attr.group);
 	bool unified_fdb = is_unified_fdb(priv);
 
 	flow_hw_modify_field_init(&mhdr, at);
@@ -2535,7 +2535,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 
 		switch ((int)actions->type) {
 		case RTE_FLOW_ACTION_TYPE_INDIRECT_LIST:
-			if (!attr->group) {
+			if (is_root) {
 				DRV_LOG(ERR, "Indirect action is not supported in root table.");
 				goto err;
 			}
@@ -2545,7 +2545,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
-			if (!attr->group) {
+			if (is_root) {
 				DRV_LOG(ERR, "Indirect action is not supported in root table.");
 				goto err;
 			}
@@ -2566,7 +2566,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				priv->hw_drop[!!attr->group];
 			break;
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			if (!attr->group) {
+			if (is_root) {
 				DRV_LOG(ERR, "Port representor is not supported in root table.");
 				goto err;
 			}
@@ -2761,11 +2761,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
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
@@ -2789,11 +2785,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
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
@@ -2808,11 +2800,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
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
@@ -2871,12 +2859,6 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
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

