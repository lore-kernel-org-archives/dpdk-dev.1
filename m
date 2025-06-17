Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8011EC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0494240E3E;
	Tue, 17 Jun 2025 15:40:47 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by mails.dpdk.org (Postfix) with ESMTP id 56E20410E6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:40:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIjsJ2n0k3/FyRwBM9MsXO4Z1YndzWhUL+YPmy3kno4UM7HnpZzFqwOxp+O9voH3EUBT7JTka4NDXkmAbS6uTbIC/ZU166RdcV3EEjs5iF3giJ73JGBGdS0srEZYXXD9nPd+Q5z1SeLpfGnvwX9ldTfyZC7F+RDFHRg7o/g0Xr98bbp7xKAWiujIqB/FQLAqq9egvm6Gfk/wnXDjUrZL3+JDUwUwX9TW/qsbv6dEDaiOW6bL+mloIAZJWV8P1xXmszj1s/+Fxpi0OmjJnD9EE2FlgE7NoeIrEoRK2rp02sJoPT7KwBbbdQaHmxl69klrFMsvrigyg9fY7XUc05fGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+giIMefMFp7Q0NvO7J537UJW8r3Zsh55tHu60dhduk=;
 b=Sd9MpMFXXlppAb51FHUWJPfFn2AyFFvqQRTT7xq8l3CwZndOk+4APDwCYi0X4unTOqqEqcX1hcbtYNiNZqu4ZeZboTtjA0+KDFo/8NdXBnsdqOq+w1QaLhC++fqSVYnNXCD9VLUQAXQfcCfhNQmzvY8+gSyV3i8g1qMZDevh4CHbPRh8qsw2xDTLYIWXteS8h+l2W1GJuc+oJ0AIO5AsWTZ9az3wAcwyyK5ahL6+6QZd4eJw2cm2zeWMHs1IXt58UAwKCgzDvibh9mz9WgsG6JrOEtbfyL3X2+3gCGSd3DwvzIPyh+hvduxH/u1c4/5CBO1Ey9uwOXkT43Gr7AUdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+giIMefMFp7Q0NvO7J537UJW8r3Zsh55tHu60dhduk=;
 b=dfNFXpRNbl1P9b4t33DtWkLko1sOt7Oyee/J4uJ7WYSZpK8xXQXka4id97o7dqNPQJU/AExbyfonf4r9FR+sr4neahHC6hOG8apTF9mPc6+OVvbo4JUieEuUfmGU5d18+r2z0ZaMIc1OZfuKjzhUsNJ3jBpudFvFuvkYl0XFJQCZtseFMIIIxtRlXqjB1C1IqT519fLZq9b7/9U77V5EJZwxBxXf3HAHBJQiOc0JIRH7FKOPdnu9XdX1frag/lCPm+RRE7b0mUt0LHN7HQ63jDIuE4AO6OOgKu92W8KDDgioB48PM7b38iiw4NJ0if6RrDSNkwbk4VdhHxAVhOWRCw==
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 13:40:38 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::76) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 17 Jun 2025 13:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 13:40:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 06:40:21 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 06:40:16 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 5/5] net/mlx5: support non-template SAMPLE flow action
Date: Tue, 17 Jun 2025 16:39:33 +0300
Message-ID: <20250617133933.313443-5-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: fffd6e42-c189-4c36-cf41-08ddada48b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lvZ+FVVEs0koASwth89ySAGsLsUIMAUMMEe/psEiKrQRDxdl4P8BzswpSKFS?=
 =?us-ascii?Q?TQguGMENTHAe4OhyJybSN1UxIGj3slPpiwjUt+nA1q0uD1cAETXbyaCqAEES?=
 =?us-ascii?Q?peeHhDDYwqJ4WrhLwOYn3CmE+KvNV+9Y71+27Nwu4PCa/mcyLOrDUEW44YO9?=
 =?us-ascii?Q?wjcrBNPWJDxUldL9p3vo4+BVzx8WoLk9KrQ8vHtJwYCtvroeMl7bOYCow9KW?=
 =?us-ascii?Q?woKqBMdcg53piug0yN3O3NGZqhNYLCwDuLdjK9Hh7+RTS5azSNCj4AqD3wsU?=
 =?us-ascii?Q?yN7Yd2FhUzD3UQW/9HcJZ0XrhzQ2ya/Hn4hHBLv3oSNK5wymupqXxixPsRZf?=
 =?us-ascii?Q?ZzrzjOWQXk7mvtaWFN3kZpIodkCWX8K7ZntPGAhtma6ynVSUUIcWA2zkv4qO?=
 =?us-ascii?Q?IAmUMGh02tXMSrJz7B6cHtkUm6WIviO113W4QqrmptbkAuxmzG2kDOVPxll6?=
 =?us-ascii?Q?F4TAWT+o99wDjW22Psf7BUEworhJAfcdP1UBto1xMyTBaIXevU3eycw2wllY?=
 =?us-ascii?Q?8G/x8xFiL/pCwhjp19dUwdd19mOMtALnS8JE7rBNP7fRiwrYDAU9yNzu/S3b?=
 =?us-ascii?Q?TtkddHCmVkR2yAbEVdQ4ix6Xh2IY74P77bDxFMuNDtMaTsUw7MRL0XgDfsOH?=
 =?us-ascii?Q?6l+PiAQoPP4VSfLjlOromQb8qbXdkesfZBiOgI93ceCbiEvbZn0QkhMG2uZ0?=
 =?us-ascii?Q?PJU6X4VkWAvOR2iklzzt8gLqVjAnX0B/DgEqXYK42qc4Efi2Mj1id6c44c9w?=
 =?us-ascii?Q?6aJjKXZNKfsELdzFOUlN6fNpnPvcJRCZFC/+SAbEtdjwWnLpZo1C7tNqWHhi?=
 =?us-ascii?Q?ylK6KEopMR1KbgmYYMb7s7tN1CLvEYgDY48ysLuL5iGaslJe7ghPTlHSp7rN?=
 =?us-ascii?Q?xuEV6dUTm+TXVikUAbR0mS9AE5lqwxwuo4+fhiSVPWbcIxdt+cpgfpGsit4s?=
 =?us-ascii?Q?p/reP+4Ss9WubxaHDIBvfvoM0uVN2ZrYz/PdmGF4e7ERvUKKahpq7n7OQ8iA?=
 =?us-ascii?Q?vkc+hWPFFF3PZtkLQ4YbUYkcJK5mM73v0kjpoCZr+XN/AqlahJMRjKYmNm0W?=
 =?us-ascii?Q?aHEk+tH1MYk4kY+cEu6HVj84rZtJgkY4E7I6OSOoCbA6G3+d8X8aWyth4XlM?=
 =?us-ascii?Q?Q3Qo65qeexcHeccJ6FoCDVzWsoiwATisoXHRq2ANC4I5vcH12zQPScKqtD+w?=
 =?us-ascii?Q?DwO0lGylPyn1wUi13pN58F3sTjtW+DWlRv58ivojsoxTzVzMsvLQ5oxcN2Qn?=
 =?us-ascii?Q?0ah31ZFgYCrCKiA5yCwdjInr9EBYCDn2u1QnXeboOD2kPgL+2ehB/gLdUHBP?=
 =?us-ascii?Q?5be0OUoT49B6M2IINSnCvb5mxpE2IeJOEjT13uueQoX+gJ9LbjBraswUz0ly?=
 =?us-ascii?Q?jGYzzsh+rOZ3R4Bgd3W3cezYVgCBe+yCyhOT1iTOP1egwWNG1VieA79r9kWz?=
 =?us-ascii?Q?fFA9n8o4r/K51Mz1Qc7+CfrHY2dZE2y+8/sFP0gOjHObAMVSID4wYz4IAXtW?=
 =?us-ascii?Q?0DUDtkik7AXhNIKnaYOcJqWFYApUdLeA7Mcg?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:40:38.1324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd6e42-c189-4c36-cf41-08ddada48b7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

MLX5 HWS flow engine does not support the SAMPLE flow action.

The patch adds the SAMPLE action support to the non-template API.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/mlx5.c            |   1 +
 drivers/net/mlx5/mlx5_flow.h       |  26 +-
 drivers/net/mlx5/mlx5_flow_hw.c    |  40 ++-
 drivers/net/mlx5/mlx5_nta_sample.c | 401 ++++++++++++++++++++++++++---
 drivers/net/mlx5/mlx5_nta_sample.h |  25 ++
 5 files changed, 444 insertions(+), 49 deletions(-)
 create mode 100644 drivers/net/mlx5/mlx5_nta_sample.h

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae2..224f70994d 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2368,6 +2368,7 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	mlx5_flex_item_port_cleanup(dev);
 	mlx5_indirect_list_handles_release(dev);
 #ifdef HAVE_MLX5_HWS_SUPPORT
+	mlx5_free_sample_context(dev);
 	flow_hw_destroy_vport_action(dev);
 	/* dr context will be closed after mlx5_os_free_shared_dr. */
 	flow_hw_resource_release(dev);
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 8186b85ae1..e9a981707d 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -54,6 +54,8 @@ enum mlx5_rte_flow_action_type {
 
 struct mlx5_rte_flow_action_mirror {
 	struct mlx5_mirror *mirror;
+	uint32_t sample_group;
+	uint32_t suffix_group;
 };
 
 /* Private (internal) Field IDs for MODIFY_FIELD action. */
@@ -1356,6 +1358,8 @@ struct rte_flow_nt2hws {
 	struct rte_flow_hw_aux *flow_aux;
 	/** Modify header pointer. */
 	struct mlx5_flow_dv_modify_hdr_resource *modify_hdr;
+	/** Group Id used in SAMPLE flow action */
+	uint32_t sample_group;
 	/** Chain NTA flows. */
 	SLIST_ENTRY(rte_flow_hw) next;
 	/** Encap/decap index. */
@@ -3748,12 +3752,22 @@ mlx5_hw_create_mirror(struct rte_eth_dev *dev,
 		      const struct rte_flow_action *actions,
 		      struct rte_flow_error *error);
 
-struct rte_flow_hw *
-mlx5_flow_nta_handle_sample(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action actions[],
-			    struct rte_flow_error *error);
+int
+mlx5_flow_hw_group_set_miss_actions(struct rte_eth_dev *dev,
+				    uint32_t group_id,
+				    const struct rte_flow_group_attr *attr,
+				    const struct rte_flow_action actions[],
+				    struct rte_flow_error *error);
+
+uint64_t
+mlx5_flow_hw_action_flags_get(const struct rte_flow_action actions[],
+			      const struct rte_flow_action **qrss,
+			      const struct rte_flow_action **mark,
+			      int *encap_idx,
+			      int *act_cnt,
+			      struct rte_flow_error *error);
+
+#include "mlx5_nta_sample.h"
 
 #endif
 #endif /* RTE_PMD_MLX5_FLOW_H_ */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index f1b90d6e56..db162e5a4f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -574,8 +574,8 @@ flow_hw_hashfields_set(struct mlx5_flow_rss_desc *rss_desc,
 	*hash_fields |= fields;
 }
 
-static uint64_t
-flow_hw_action_flags_get(const struct rte_flow_action actions[],
+uint64_t
+mlx5_flow_hw_action_flags_get(const struct rte_flow_action actions[],
 			 const struct rte_flow_action **qrss,
 			 const struct rte_flow_action **mark,
 			 int *encap_idx,
@@ -1987,6 +1987,7 @@ hws_table_tmpl_translate_indirect_mirror(struct rte_eth_dev *dev,
 			 action_src, action_dst,
 			 flow_hw_translate_indirect_mirror);
 	}
+
 	return ret;
 }
 
@@ -2903,6 +2904,12 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			}
 			break;
+		case MLX5_RTE_FLOW_ACTION_TYPE_MIRROR:
+			if (__flow_hw_act_data_general_append(priv, acts,
+							      actions->type,
+							      src_pos, dr_pos))
+				goto err;
+			break;
 		case RTE_FLOW_ACTION_TYPE_END:
 			actions_end = true;
 			break;
@@ -3743,6 +3750,12 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 				((const struct rte_flow_action_jump_to_table_index *)
 				action->conf)->index;
 			break;
+		case MLX5_RTE_FLOW_ACTION_TYPE_MIRROR: {
+			const struct mlx5_rte_flow_action_mirror *mirror_conf = action->conf;
+
+			rule_acts[act_data->action_dst].action = mirror_conf->mirror->mirror_action;
+		}
+			break;
 		default:
 			break;
 		}
@@ -3995,6 +4008,7 @@ flow_hw_async_flow_create_generic(struct rte_eth_dev *dev,
 		aux->matcher_selector = selector;
 		flow->flags |= MLX5_FLOW_HW_FLOW_FLAG_MATCHER_SELECTOR;
 	}
+
 	if (likely(!ret)) {
 		flow_hw_q_inc_flow_ops(priv, queue);
 		return (struct rte_flow *)flow;
@@ -5694,8 +5708,8 @@ flow_hw_group_unset_miss_group(struct rte_eth_dev *dev,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 
-static int
-flow_hw_group_set_miss_actions(struct rte_eth_dev *dev,
+int
+mlx5_flow_hw_group_set_miss_actions(struct rte_eth_dev *dev,
 			       uint32_t group_id,
 			       const struct rte_flow_group_attr *attr,
 			       const struct rte_flow_action actions[],
@@ -7623,6 +7637,10 @@ flow_hw_parse_flow_actions_to_dr_actions(struct rte_eth_dev *dev,
 			at->dr_off[i] = curr_off;
 			action_types[curr_off++] = MLX5DR_ACTION_TYP_JUMP_TO_MATCHER;
 			break;
+		case MLX5_RTE_FLOW_ACTION_TYPE_MIRROR:
+			at->dr_off[i] = curr_off;
+			action_types[curr_off++] = MLX5DR_ACTION_TYP_DEST_ARRAY;
+				break;
 		default:
 			type = mlx5_hw_dr_action_types[at->actions[i].type];
 			at->dr_off[i] = curr_off;
@@ -14107,6 +14125,8 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 	}
 	if (flow->nt2hws->matcher)
 		flow_hw_unregister_matcher(dev, flow->nt2hws->matcher);
+	if (flow->nt2hws->sample_group != 0)
+		mlx5_nta_release_sample_group(dev, flow->nt2hws->sample_group);
 }
 
 #ifdef HAVE_MLX5_HWS_SUPPORT
@@ -14180,7 +14200,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	const struct rte_flow_action *qrss = NULL;
 	const struct rte_flow_action *mark = NULL;
 	uint64_t item_flags = 0;
-	uint64_t action_flags = flow_hw_action_flags_get(actions, &qrss, &mark,
+	uint64_t action_flags = mlx5_flow_hw_action_flags_get(actions, &qrss, &mark,
 							 &encap_idx, &actions_n, error);
 	struct mlx5_flow_hw_split_resource resource = {
 		.suffix = {
@@ -14220,7 +14240,13 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 			goto free;
 	}
 	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
-		mlx5_flow_nta_handle_sample(dev, attr, items, actions, error);
+		flow = mlx5_flow_nta_handle_sample(dev, type, attr, items,
+						   actions,
+						   item_flags, action_flags,
+						   error);
+		if (flow != NULL)
+			return (uintptr_t)flow;
+		goto free;
 	}
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
 		const struct rte_flow_action_rss
@@ -15378,7 +15404,7 @@ const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.template_table_create = flow_hw_template_table_create,
 	.template_table_destroy = flow_hw_table_destroy,
 	.table_resize = flow_hw_table_resize,
-	.group_set_miss_actions = flow_hw_group_set_miss_actions,
+	.group_set_miss_actions = mlx5_flow_hw_group_set_miss_actions,
 	.async_flow_create = flow_hw_async_flow_create,
 	.async_flow_create_by_index = flow_hw_async_flow_create_by_index,
 	.async_flow_update = flow_hw_async_flow_update,
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
index d6ffbd8e33..c6012ca5c9 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.c
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2024 NVIDIA Corporation & Affiliates
+ * Copyright (c) 2025 NVIDIA Corporation & Affiliates
  */
 
 #include <rte_flow.h>
@@ -9,6 +9,8 @@
 #include "mlx5_flow.h"
 #include "mlx5_rx.h"
 
+SLIST_HEAD(mlx5_flow_head, rte_flow_hw);
+
 struct mlx5_nta_sample_ctx {
 	uint32_t groups_num;
 	struct mlx5_indexed_pool *group_ids;
@@ -17,6 +19,18 @@ struct mlx5_nta_sample_ctx {
 	struct mlx5_list *suffix_groups; /* cache groups for suffix actions */
 };
 
+static void
+release_chained_flows(struct rte_eth_dev *dev, struct mlx5_flow_head *flow_head,
+		      enum mlx5_flow_type type)
+{
+	struct rte_flow_hw *flow = SLIST_FIRST(flow_head);
+
+	if (flow) {
+		flow->nt2hws->chaned_flow = 0;
+		flow_hw_list_destroy(dev, type, (uintptr_t)flow);
+	}
+}
+
 static uint32_t
 alloc_cached_group(struct rte_eth_dev *dev)
 {
@@ -40,7 +54,13 @@ release_cached_group(struct rte_eth_dev *dev, uint32_t group)
 	mlx5_ipool_free(sample_ctx->group_ids, group - MLX5_FLOW_TABLE_SAMPLE_BASE);
 }
 
-static void
+void
+mlx5_nta_release_sample_group(struct rte_eth_dev *dev, uint32_t group)
+{
+	release_cached_group(dev, group);
+}
+
+void
 mlx5_free_sample_context(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -364,42 +384,68 @@ get_registered_group(struct rte_flow_action *actions, struct mlx5_list *cache)
 	return ent ? container_of(ent, struct mlx5_nta_sample_cached_group, entry)->group : 0;
 }
 
-static struct mlx5_mirror *
-mlx5_create_nta_mirror(struct rte_eth_dev *dev,
-		       const struct rte_flow_attr *attr,
-		       struct rte_flow_action *sample_actions,
-		       struct rte_flow_action *suffix_actions,
-		       struct rte_flow_error *error)
+static int
+mlx5_nta_create_mirror_action(struct rte_eth_dev *dev,
+			      const struct rte_flow_attr *attr,
+			      struct rte_flow_action *sample_actions,
+			      struct rte_flow_action *suffix_actions,
+			      struct mlx5_rte_flow_action_mirror *mirror_conf,
+			      struct rte_flow_error *error)
 {
-	struct mlx5_mirror *mirror;
-	uint32_t sample_group, suffix_group;
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
 	struct mlx5_flow_template_table_cfg table_cfg = {
 		.external = true,
 		.attr = {
-			.flow_attr = {
-				.ingress = attr->ingress,
-				.egress = attr->egress,
-				.transfer = attr->transfer
-			}
+			.flow_attr = *attr
 		}
 	};
 
-	sample_group = get_registered_group(sample_actions, ctx->sample_groups);
-	if (sample_group == 0) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					   NULL, "Failed to register sample group");
-		return NULL;
+	mirror_conf->sample_group = get_registered_group(sample_actions, ctx->sample_groups);
+	if (mirror_conf->sample_group == 0)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  NULL, "Failed to register sample group");
+	mirror_conf->suffix_group = get_registered_group(suffix_actions, ctx->suffix_groups);
+	if (mirror_conf->suffix_group == 0)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  NULL, "Failed to register suffix group");
+	mirror_conf->mirror = get_registered_mirror(&table_cfg, ctx->mirror_actions,
+						    mirror_conf->sample_group,
+						    mirror_conf->suffix_group);
+	return 0;
+}
+
+static void
+save_sample_group(struct rte_flow_hw *flow, uint32_t group)
+{
+	flow->nt2hws->sample_group = group;
+}
+
+static uint32_t
+generate_random_mask(uint32_t ratio)
+{
+	uint32_t i;
+	double goal = 1.0 / ratio;
+
+	/* Check if the ratio value is power of 2 */
+	if (rte_popcount32(ratio) == 1) {
+		for (i = 2; i < UINT32_WIDTH; i++) {
+			if (RTE_BIT32(i) == ratio)
+				return RTE_BIT32(i) - 1;
+		}
 	}
-	suffix_group = get_registered_group(suffix_actions, ctx->suffix_groups);
-	if (suffix_group == 0) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					   NULL, "Failed to register suffix group");
-		return NULL;
+
+	/*
+	 * Find the last power of 2 with ratio larger then the goal.
+	 */
+	for (i = 2; i < UINT32_WIDTH; i++) {
+		double res = 1.0 / RTE_BIT32(i);
+
+		if (res < goal)
+			return RTE_BIT32(i - 1) - 1;
 	}
-	mirror = get_registered_mirror(&table_cfg, ctx->mirror_actions, sample_group, suffix_group);
-	return mirror;
+
+	return UINT32_MAX;
 }
 
 static void
@@ -427,18 +473,287 @@ mlx5_nta_parse_sample_actions(const struct rte_flow_action *action,
 	} while ((action++)->type != RTE_FLOW_ACTION_TYPE_END);
 }
 
+static bool
+validate_prefix_actions(const struct rte_flow_action *actions)
+{
+	uint32_t i = 0;
+
+	while (actions[i].type != RTE_FLOW_ACTION_TYPE_END)
+		i++;
+	return i < MLX5_HW_MAX_ACTS - 1;
+}
+
+static void
+action_append(struct rte_flow_action *actions, const struct rte_flow_action *last)
+{
+	uint32_t i = 0;
+
+	while (actions[i].type != RTE_FLOW_ACTION_TYPE_END)
+		i++;
+	actions[i] = *last;
+}
+
+static int
+create_mirror_aux_flows(struct rte_eth_dev *dev,
+			enum mlx5_flow_type type,
+			const struct rte_flow_attr *attr,
+			struct rte_flow_action *suffix_actions,
+			struct rte_flow_action *sample_actions,
+			struct mlx5_rte_flow_action_mirror *mirror_conf,
+			struct mlx5_flow_head *flow_head,
+			struct rte_flow_error *error)
+{
+	const struct rte_flow_attr suffix_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+		.group = mirror_conf->suffix_group,
+	};
+	const struct rte_flow_attr sample_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+		.group = mirror_conf->sample_group,
+	};
+	const struct rte_flow_item secondary_pattern[1] = {
+		[0] = { .type = RTE_FLOW_ITEM_TYPE_END }
+	};
+	int ret, encap_idx, actions_num;
+	uint64_t suffix_action_flags, sample_action_flags;
+	const struct rte_flow_action *qrss_action = NULL, *mark_action = NULL;
+	struct rte_flow_hw *suffix_flow = NULL, *sample_flow = NULL;
+
+	suffix_action_flags = mlx5_flow_hw_action_flags_get(suffix_actions,
+						       &qrss_action, &mark_action,
+						       &encap_idx, &actions_num, error);
+	if (qrss_action != NULL && qrss_action->type == RTE_FLOW_ACTION_TYPE_RSS)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"RSS action is not supported in suffix sample action");
+	sample_action_flags = mlx5_flow_hw_action_flags_get(sample_actions,
+						       &qrss_action, &mark_action,
+						       &encap_idx, &actions_num, error);
+	if (qrss_action != NULL && qrss_action->type == RTE_FLOW_ACTION_TYPE_RSS)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"RSS action is not supported in sample action");
+	ret = flow_hw_create_flow(dev, type, &suffix_attr,
+				  secondary_pattern, suffix_actions,
+				  MLX5_FLOW_LAYER_OUTER_L2, suffix_action_flags,
+				  true, &suffix_flow, error);
+	if (ret != 0)
+		return ret;
+	save_sample_group(suffix_flow, mirror_conf->suffix_group);
+	ret = flow_hw_create_flow(dev, type, &sample_attr,
+				  secondary_pattern, sample_actions,
+				  MLX5_FLOW_LAYER_OUTER_L2, sample_action_flags,
+				  true, &sample_flow, error);
+	if (ret != 0) {
+		flow_hw_destroy(dev, suffix_flow);
+		return ret;
+	}
+	save_sample_group(sample_flow, mirror_conf->sample_group);
+	suffix_flow->nt2hws->chaned_flow = 1;
+	SLIST_INSERT_HEAD(flow_head, suffix_flow, nt2hws->next);
+	sample_flow->nt2hws->chaned_flow = 1;
+	SLIST_INSERT_HEAD(flow_head, sample_flow, nt2hws->next);
+	return 0;
+}
+
+static struct rte_flow_hw *
+create_sample_flow(struct rte_eth_dev *dev,
+		   enum mlx5_flow_type type,
+		   const struct rte_flow_attr *attr,
+		   uint32_t ratio,
+		   uint32_t sample_group,
+		   struct mlx5_rte_flow_action_mirror *mirror_conf,
+		   struct rte_flow_error *error)
+{
+	struct rte_flow_hw *sample_flow = NULL;
+	uint32_t random_mask = generate_random_mask(ratio);
+	const struct rte_flow_attr sample_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+		.group = sample_group,
+	};
+	const struct rte_flow_item sample_pattern[2] = {
+		[0] = {
+			.type = RTE_FLOW_ITEM_TYPE_RANDOM,
+			.mask = &(struct rte_flow_item_random) {
+				.value = random_mask
+			},
+			.spec = &(struct rte_flow_item_random) {
+				.value = 1
+			},
+		},
+		[1] = { .type = RTE_FLOW_ITEM_TYPE_END }
+	};
+	const struct rte_flow_action sample_actions[2] = {
+		[0] = {
+			.type = (enum rte_flow_action_type)MLX5_RTE_FLOW_ACTION_TYPE_MIRROR,
+			.conf = mirror_conf
+		},
+		[1] = { .type = RTE_FLOW_ACTION_TYPE_END }
+	};
+
+	if (random_mask > UINT16_MAX)
+		return NULL;
+	flow_hw_create_flow(dev, type, &sample_attr, sample_pattern, sample_actions,
+			    0, 0, true, &sample_flow, error);
+	save_sample_group(sample_flow, sample_group);
+	return sample_flow;
+}
+
+static struct rte_flow_hw *
+create_sample_miss_flow(struct rte_eth_dev *dev,
+			enum mlx5_flow_type type,
+			const struct rte_flow_attr *attr,
+			uint32_t sample_group, uint32_t suffix_group,
+			const struct rte_flow_action *miss_actions,
+			struct rte_flow_error *error)
+{
+	int ret;
+	struct rte_flow_hw *miss_flow = NULL;
+	const struct rte_flow_attr miss_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+		.group = suffix_group,
+	};
+	const struct rte_flow_item miss_pattern[1] = {
+		[0] = { .type = RTE_FLOW_ITEM_TYPE_END }
+	};
+	const struct rte_flow_group_attr sample_group_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+	};
+	const struct rte_flow_action sample_miss_actions[2] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &(struct rte_flow_action_jump) { .group = suffix_group }
+		},
+		[1] = { .type = RTE_FLOW_ACTION_TYPE_END }
+	};
+
+	ret = mlx5_flow_hw_group_set_miss_actions(dev, sample_group, &sample_group_attr,
+					     sample_miss_actions, error);
+	if (ret != 0)
+		return NULL;
+	flow_hw_create_flow(dev, type, &miss_attr, miss_pattern, miss_actions,
+			    0, 0, true, &miss_flow, error);
+	return miss_flow;
+}
+
+static struct rte_flow_hw *
+mlx5_nta_create_sample_flow(struct rte_eth_dev *dev,
+			     enum mlx5_flow_type type,
+			     const struct rte_flow_attr *attr,
+			     uint32_t sample_ratio,
+			     uint64_t item_flags, uint64_t action_flags,
+			     const struct rte_flow_item *pattern,
+			     struct rte_flow_action *prefix_actions,
+			     struct rte_flow_action *suffix_actions,
+			     struct rte_flow_action *sample_actions,
+			     struct mlx5_rte_flow_action_mirror *mirror_conf,
+			     struct rte_flow_error *error)
+{
+	int ret;
+	uint32_t sample_group = alloc_cached_group(dev);
+	struct mlx5_flow_head flow_head = SLIST_HEAD_INITIALIZER(NULL);
+	struct rte_flow_hw *base_flow = NULL, *sample_flow, *miss_flow = NULL;
+
+	if (sample_group == 0)
+		goto error;
+	ret = create_mirror_aux_flows(dev, type, attr,
+				      suffix_actions, sample_actions,
+				      mirror_conf, &flow_head, error);
+	if (ret != 0)
+		return NULL;
+	miss_flow = create_sample_miss_flow(dev, type, attr,
+					    sample_group, mirror_conf->suffix_group,
+					    suffix_actions, error);
+	if (miss_flow == NULL)
+		goto error;
+	miss_flow->nt2hws->chaned_flow = 1;
+	SLIST_INSERT_HEAD(&flow_head, miss_flow, nt2hws->next);
+	sample_flow = create_sample_flow(dev, type, attr, sample_ratio, sample_group,
+					 mirror_conf, error);
+	if (sample_flow == NULL)
+		goto error;
+	sample_flow->nt2hws->chaned_flow = 1;
+	SLIST_INSERT_HEAD(&flow_head, sample_flow, nt2hws->next);
+	action_append(prefix_actions,
+		&(struct rte_flow_action) {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &(struct rte_flow_action_jump) { .group = sample_group }
+		});
+	ret = flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
+				  item_flags, action_flags, true, &base_flow, error);
+	if (ret != 0)
+		goto error;
+	SLIST_INSERT_HEAD(&flow_head, base_flow, nt2hws->next);
+	return base_flow;
+
+error:
+	release_chained_flows(dev, &flow_head, type);
+	return NULL;
+}
+
+static struct rte_flow_hw *
+mlx5_nta_create_mirror_flow(struct rte_eth_dev *dev,
+			     enum mlx5_flow_type type,
+			     const struct rte_flow_attr *attr,
+			     uint64_t item_flags, uint64_t action_flags,
+			     const struct rte_flow_item *pattern,
+			     struct rte_flow_action *prefix_actions,
+			     struct rte_flow_action *suffix_actions,
+			     struct rte_flow_action *sample_actions,
+			     struct mlx5_rte_flow_action_mirror *mirror_conf,
+			     struct rte_flow_error *error)
+{
+	int ret;
+	struct rte_flow_hw *base_flow = NULL;
+	struct mlx5_flow_head flow_head = SLIST_HEAD_INITIALIZER(NULL);
+
+	ret = create_mirror_aux_flows(dev, type, attr,
+				      suffix_actions, sample_actions,
+				      mirror_conf, &flow_head, error);
+	if (ret != 0)
+		return NULL;
+	action_append(prefix_actions,
+		&(struct rte_flow_action) {
+			.type = (enum rte_flow_action_type)MLX5_RTE_FLOW_ACTION_TYPE_MIRROR,
+			.conf = mirror_conf
+		});
+	ret = flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
+				  item_flags, action_flags,
+				  true, &base_flow, error);
+	if (ret != 0)
+		goto error;
+	SLIST_INSERT_HEAD(&flow_head, base_flow, nt2hws->next);
+	return base_flow;
+
+error:
+	release_chained_flows(dev, &flow_head, type);
+	return NULL;
+}
+
 struct rte_flow_hw *
 mlx5_flow_nta_handle_sample(struct rte_eth_dev *dev,
+			    enum mlx5_flow_type type,
 			    const struct rte_flow_attr *attr,
-			    const struct rte_flow_item pattern[] __rte_unused,
-			    const struct rte_flow_action actions[] __rte_unused,
+			    const struct rte_flow_item pattern[],
+			    const struct rte_flow_action actions[],
+			    uint64_t item_flags, uint64_t action_flags,
 			    struct rte_flow_error *error)
 {
+	int ret;
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_mirror *mirror;
+	struct rte_flow_hw *flow = NULL;
 	const struct rte_flow_action *sample;
 	struct rte_flow_action *sample_actions;
 	const struct rte_flow_action_sample *sample_conf;
+	struct mlx5_rte_flow_action_mirror mirror_conf = { NULL };
 	struct rte_flow_action prefix_actions[MLX5_HW_MAX_ACTS] = { 0 };
 	struct rte_flow_action suffix_actions[MLX5_HW_MAX_ACTS] = { 0 };
 
@@ -451,12 +766,26 @@ mlx5_flow_nta_handle_sample(struct rte_eth_dev *dev,
 		}
 	}
 	mlx5_nta_parse_sample_actions(actions, &sample, prefix_actions, suffix_actions);
+	if (!validate_prefix_actions(prefix_actions)) {
+		rte_flow_error_set(error, -EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				   NULL, "Too many actions");
+		return NULL;
+	}
 	sample_conf = (const struct rte_flow_action_sample *)sample->conf;
 	sample_actions = (struct rte_flow_action *)(uintptr_t)sample_conf->actions;
-	mirror = mlx5_create_nta_mirror(dev, attr, sample_actions,
-					suffix_actions, error);
-	if (mirror == NULL)
-		goto error;
-error:
-	return NULL;
+	ret = mlx5_nta_create_mirror_action(dev, attr, sample_actions,
+					    suffix_actions, &mirror_conf, error);
+	if (ret != 0)
+		return NULL;
+	if (sample_conf->ratio == 1) {
+		flow = mlx5_nta_create_mirror_flow(dev, type, attr, item_flags, action_flags,
+						   pattern, prefix_actions, suffix_actions,
+						   sample_actions, &mirror_conf, error);
+	} else {
+		flow = mlx5_nta_create_sample_flow(dev, type, attr, sample_conf->ratio,
+						   item_flags, action_flags, pattern,
+						   prefix_actions, suffix_actions,
+						   sample_actions, &mirror_conf, error);
+	}
+	return flow;
 }
diff --git a/drivers/net/mlx5/mlx5_nta_sample.h b/drivers/net/mlx5/mlx5_nta_sample.h
new file mode 100644
index 0000000000..129d534b33
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_nta_sample.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef MLX5_NTA_SAMPLE_H
+#define MLX5_NTA_SAMPLE_H
+
+#include <stdint.h>
+
+struct rte_flow_hw *
+mlx5_flow_nta_handle_sample(struct rte_eth_dev *dev,
+			    enum mlx5_flow_type type,
+			    const struct rte_flow_attr *attr,
+			    const struct rte_flow_item pattern[],
+			    const struct rte_flow_action actions[],
+			    uint64_t item_flags, uint64_t action_flags,
+			    struct rte_flow_error *error);
+
+void
+mlx5_nta_release_sample_group(struct rte_eth_dev *dev, uint32_t group);
+
+void
+mlx5_free_sample_context(struct rte_eth_dev *dev);
+
+#endif /* MLX5_NTA_SAMPLE_H */
-- 
2.48.1

