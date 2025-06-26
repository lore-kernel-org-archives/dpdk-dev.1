Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB28C77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F32540ED1;
	Thu, 26 Jun 2025 10:00:52 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by mails.dpdk.org (Postfix) with ESMTP id BCBB740E68
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:00:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etmloorNzWw5JD8OLQIaV2MKnmko34spgQ8vdDM8BDJSxTO6YTi4aonG1CFd2h/u1ORxlDuHJ5E65gQHvManAyodGb5P5xsyYCOa6plvwk8S4BNK9x08yiMPZjOXS6m91WE1iUbwHVVVwlmyG16gWPRENKuH1+PTQKGXJltCf7BHwKidWHgO00B8cN/SmwvepwMtBWF3FNOrzkJ1/gJLqJSPyrBI7b6L/V40aK0p61j+f5gH74dAOxw9tNGk2IIZJPGlmwQEoU18W1YgKByUCATxlJxOFG3yNigXFEOZxaYVbkAKhXc5ACiTNdNstbI1llzYlltOvEQAswff7rPZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywhYesiQoBWeXoijJZLQkApXwgMb6tGsCVo54EGLalM=;
 b=MKkLWwzHMPyae7xhuYI/P+xMwffCXc4N5kD7VleCdrAvJ8ibwOWXgEajER2Ygp1wVpEg4+dCyZFJoRDGhlVtnxDy6Gt0YhOc1XtWXZFVse2I5AwpdriVg+VxfDLcjunQpyaRBwnQ0v4LGlQyQyDRC7eCjJjFQD27w+YGE+3f4mOW06/xCzbvKZpAQ48iwyUw4PFBOpYYMCpRJpys6vkrDNKlsXRCTgOmrGvpc5vqrS1JSKUDvlc0MHEDzJxShu/RsSxA5UvIgtLzvOdV3t/bDA2kB1JlJK7EWw+jgYps1XMxfjVvCSI1GLn+Ze5MuoUuvI2Ar+Bbzl8b9dh3e1d7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywhYesiQoBWeXoijJZLQkApXwgMb6tGsCVo54EGLalM=;
 b=qrGJ+Jg/Blv+wqqymDXLilSXC94v8ur3aOa1zj+CvbZmsL8+9gGwgCRdaDcY/s+qM1BrUvqQbPozQYnOVhdBNl20A79a+9BAZkO54qA8YkcNMxgnKHKzrw45v2vIN092k+iHr8dE3W8ItVowmj6n0aR5TzuyBDoXp2NHB24w/k3FvGxZw5T6hKNvjfdGxuET8X4/pYWOuWJpcyn7Eq3k5WYmFaBjg3qZWEREBs3lJfUqzYJsDYzUbhuwszTNYFuXNLoi5ZjBsW2ATqCMRjohwVsfTxU8oIfm3X7sYaZBIbUqyjA1YJ8DWtVkp77acoxNUOyZblw9Z9fTCKf5Cw9Xgw==
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 08:00:41 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::8f) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Thu,
 26 Jun 2025 08:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 08:00:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 01:00:26 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 01:00:20 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 4/4] net/mlx5: support non-template SAMPLE flow action
Date: Thu, 26 Jun 2025 10:59:44 +0300
Message-ID: <20250626075945.537256-5-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6483bef2-17a4-4852-85f6-08ddb4878b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BtGqspeEnNrwSNccvucojSsUxWBOgvhJCNqcWGwDlUiGg6CjrLy9Ri4f6+Sg?=
 =?us-ascii?Q?3pE6Kh/3MoWzkpJE/GM8Lk8b3zE0yGMWVuOCfe1ENYMt80hg+yhu7/vMuqSd?=
 =?us-ascii?Q?IAHf3sY7Qt05kmeCqrrgcQL8hskJYv6V6ToyHljOMEGulffT6M3BhRevyvr9?=
 =?us-ascii?Q?P2uZhT+X1BgFqNCRph+g5lzSG7pzLjFj99/oLpLighxTKftS5WJdEUIr7Ds3?=
 =?us-ascii?Q?kmeHcnZ9dynBWBCoX8Q+5M9BzUcwjcv7vXBg6ZPj9vS69aKKs4QPu7fkJoJv?=
 =?us-ascii?Q?JGRhkUtQERWYdZ+5qsef9JaZ3V+zlIhRvS0/Hrd9A9XF3uCxQEyojPfnQ/Rk?=
 =?us-ascii?Q?sVaji2n72Egi9Ppgb4E3t+Dv+3Z4iWkPYzU+KaEP0ZHCjstq83TQh7QwyZvb?=
 =?us-ascii?Q?zZBMur8cl5i3qM+MDjzmqVr01SZFZ9ePL+BXcnk3qWTM+C4uy9OU8zCbFFHj?=
 =?us-ascii?Q?6hJNcZ8W/IVNToD+ymgTcifv0FzY482qpO4cUqlCI3NlHpYJ8kEqiadOCxAU?=
 =?us-ascii?Q?7jRnPP48ySrV5m+wBl2TLd2EySK7lvmAWaQ6O6gZiN0aN4fjwcrGU4hGGWc9?=
 =?us-ascii?Q?NZ3JKiJ6ORmBkCHmnteXBaRoYjpsg6kCQXKC+3pqljbIydf+wBY3bjNNOARa?=
 =?us-ascii?Q?8kk8pUydIjjXIHGbtbGLE72hmAlIJ0kPqSfJW5giyx4mDb8I1w4vCFLN3Lq5?=
 =?us-ascii?Q?x1UNn1GBS8/i0EAIMj7HQ9svn3GALIXwOa3rgNFSTII4RS+TrQJ82Ewn19iA?=
 =?us-ascii?Q?Z+vysFbCW4bwpBQRsHWgSjCWd8mKWO0rrV7e2ywEHUmRpRoR51VFxSUKUTbr?=
 =?us-ascii?Q?UXKCQZgGChOkNea5Unzp981+RS+BF8hp7OabaK+uHHi1mgtM12sL3cW6caDM?=
 =?us-ascii?Q?QyZYomTjIQjHjs+MP4pb/ikkWWE1ar1Jptieae86mM/KEVX01BWdZRbyqMRu?=
 =?us-ascii?Q?QlFyj23AKTXZQYB9/EYogdo1t1Bzzn0ZBmFRSPQ8orWG7QKkdOTt6tKbf+Xd?=
 =?us-ascii?Q?Sdonz1NJDTQSZnM18cCJOLDszPIGRCeDqj/Gf13LWeXlrppvkDU+6MViY7aK?=
 =?us-ascii?Q?EGGs5BmFR5+p2JPTBMFslWNqcZUCFLYza2dphaE5H4iOwJ3tdzQrJvIz1+tO?=
 =?us-ascii?Q?frfyAvu495nsW8soUwGyEOHfwX4hBuO42cVVwuYgApsy/eBeRrldpvIxiZ9m?=
 =?us-ascii?Q?EmEyia93pqnTHecG9hJRZzxKddoTp5zkRfHUx3MhLWYGb2Y0fspFM6sWtpCS?=
 =?us-ascii?Q?BxsC2NICMxbUqOo9aaJe3Ve/2kIKk1MX8D6jYQrz61zR/rAcYEHrFb3EcRkf?=
 =?us-ascii?Q?PVaUR6KEeJc2ehj2UXMpsFCAne52Bg4usmmTvcOpmUZ4lFkb3jj3H+Io9XKG?=
 =?us-ascii?Q?XzwOhnnvor+U6HK1b+b8hrkssqQJ3xwIS+VY5NEuo9gMeWtEOl7EcM2stzv+?=
 =?us-ascii?Q?t0JJApxJrkkVZxWZRS8GR5TnTNPty2+0TCAZ59JGP5P3iWSqdjD0QAEKXV69?=
 =?us-ascii?Q?051BjOW7m7atitKHidUUyoxre9aa6F0GF9gt?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:00:40.5327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6483bef2-17a4-4852-85f6-08ddb4878b41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5.c            |   1 +
 drivers/net/mlx5/mlx5_flow.h       |  23 ++
 drivers/net/mlx5/mlx5_flow_hw.c    |  48 +++-
 drivers/net/mlx5/mlx5_nta_sample.c | 411 ++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_nta_sample.h |   3 +
 5 files changed, 464 insertions(+), 22 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae2..09cefd5b36 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2368,6 +2368,7 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	mlx5_flex_item_port_cleanup(dev);
 	mlx5_indirect_list_handles_release(dev);
 #ifdef HAVE_MLX5_HWS_SUPPORT
+	mlx5_nta_sample_context_free(dev);
 	flow_hw_destroy_vport_action(dev);
 	/* dr context will be closed after mlx5_os_free_shared_dr. */
 	flow_hw_resource_release(dev);
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 561bb05dfa..e890e732c3 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -49,6 +49,7 @@ enum mlx5_rte_flow_action_type {
 	MLX5_RTE_FLOW_ACTION_TYPE_JUMP,
 	MLX5_RTE_FLOW_ACTION_TYPE_RSS,
 	MLX5_RTE_FLOW_ACTION_TYPE_METER_MARK,
+	MLX5_RTE_FLOW_ACTION_TYPE_MIRROR,
 };
 
 /* Private (internal) Field IDs for MODIFY_FIELD action. */
@@ -1341,6 +1342,11 @@ enum {
 
 SLIST_HEAD(mlx5_nta_rss_flow_head, rte_flow_hw);
 
+struct mlx5_sample_release_ctx {
+	struct mlx5_list_entry *mirror_entry;
+	uint32_t sample_group;
+};
+
 /** HWS non template flow data. */
 struct rte_flow_nt2hws {
 	/** BWC rule pointer. */
@@ -1351,6 +1357,8 @@ struct rte_flow_nt2hws {
 	struct rte_flow_hw_aux *flow_aux;
 	/** Modify header pointer. */
 	struct mlx5_flow_dv_modify_hdr_resource *modify_hdr;
+	/** SAMPLE resources */
+	struct mlx5_sample_release_ctx *sample_release_ctx;
 	/** Chain NTA flows. */
 	SLIST_ENTRY(rte_flow_hw) next;
 	/** Encap/decap index. */
@@ -3743,6 +3751,21 @@ mlx5_hw_create_mirror(struct rte_eth_dev *dev,
 		      const struct rte_flow_action *actions,
 		      struct rte_flow_error *error);
 
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
 #include "mlx5_nta_sample.h"
 
 #endif
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index a7162d5859..1a20f26d80 100644
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
 
@@ -577,8 +574,8 @@ flow_hw_hashfields_set(struct mlx5_flow_rss_desc *rss_desc,
 	*hash_fields |= fields;
 }
 
-static uint64_t
-flow_hw_action_flags_get(const struct rte_flow_action actions[],
+uint64_t
+mlx5_flow_hw_action_flags_get(const struct rte_flow_action actions[],
 			 const struct rte_flow_action **qrss,
 			 const struct rte_flow_action **mark,
 			 int *encap_idx,
@@ -695,6 +692,9 @@ flow_hw_action_flags_get(const struct rte_flow_action actions[],
 		case RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX:
 			action_flags |= MLX5_FLOW_ACTION_JUMP_TO_TABLE_INDEX;
 			break;
+		case RTE_FLOW_ACTION_TYPE_SAMPLE:
+			action_flags |= MLX5_FLOW_ACTION_SAMPLE;
+			break;
 		case RTE_FLOW_ACTION_TYPE_VOID:
 		case RTE_FLOW_ACTION_TYPE_END:
 			break;
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
+			const struct mlx5_mirror *mirror = action->conf;
+
+			rule_acts[act_data->action_dst].action = mirror->mirror_action;
+			break;
+		}
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
@@ -14107,6 +14125,10 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 	}
 	if (flow->nt2hws->matcher)
 		flow_hw_unregister_matcher(dev, flow->nt2hws->matcher);
+	if (flow->nt2hws->sample_release_ctx != NULL) {
+		mlx5_nta_sample_mirror_entry_release(dev, flow->nt2hws->sample_release_ctx);
+		flow->nt2hws->sample_release_ctx = NULL;
+	}
 }
 
 #ifdef HAVE_MLX5_HWS_SUPPORT
@@ -14180,7 +14202,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	const struct rte_flow_action *qrss = NULL;
 	const struct rte_flow_action *mark = NULL;
 	uint64_t item_flags = 0;
-	uint64_t action_flags = flow_hw_action_flags_get(actions, &qrss, &mark,
+	uint64_t action_flags = mlx5_flow_hw_action_flags_get(actions, &qrss, &mark,
 							 &encap_idx, &actions_n, error);
 	struct mlx5_flow_hw_split_resource resource = {
 		.suffix = {
@@ -14219,7 +14241,13 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		if (ret)
 			goto free;
 	}
-
+	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
+		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, items, actions,
+							item_flags, action_flags, error);
+		if (flow != NULL)
+			return (uintptr_t)flow;
+		goto free;
+	}
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
 		const struct rte_flow_action_rss
 			*rss_conf = flow_nta_locate_rss(dev, actions, error);
@@ -15376,7 +15404,7 @@ const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.template_table_create = flow_hw_template_table_create,
 	.template_table_destroy = flow_hw_table_destroy,
 	.table_resize = flow_hw_table_resize,
-	.group_set_miss_actions = flow_hw_group_set_miss_actions,
+	.group_set_miss_actions = mlx5_flow_hw_group_set_miss_actions,
 	.async_flow_create = flow_hw_async_flow_create,
 	.async_flow_create_by_index = flow_hw_async_flow_create_by_index,
 	.async_flow_update = flow_hw_async_flow_update,
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
index aae864eb00..b8351be0d9 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.c
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -9,6 +9,8 @@
 #include "mlx5_flow.h"
 #include "mlx5_rx.h"
 
+SLIST_HEAD(mlx5_flow_head, rte_flow_hw);
+
 struct mlx5_nta_sample_ctx {
 	uint32_t groups_num;
 	struct mlx5_indexed_pool *group_ids;
@@ -16,6 +18,18 @@ struct mlx5_nta_sample_ctx {
 	struct mlx5_list *mirror_groups; /* cache groups for sample and suffix actions */
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
 static void
 release_cached_group(struct rte_eth_dev *dev, uint32_t group)
 {
@@ -83,6 +97,32 @@ struct mlx5_nta_sample_cached_mirror_ctx {
 	struct mlx5_list_entry *suffix;
 };
 
+static struct mlx5_mirror *
+mirror_entry_to_mirror_action(struct mlx5_list_entry *entry)
+{
+	return container_of(entry, struct mlx5_nta_sample_cached_mirror, entry)->mirror;
+}
+
+static uint32_t
+mirror_entry_to_mirror_sample_group(struct mlx5_list_entry *entry)
+{
+	struct mlx5_list_entry *sample = container_of(entry,
+						      struct mlx5_nta_sample_cached_mirror,
+						      entry)->sample;
+
+	return container_of(sample, struct mlx5_nta_sample_cached_group, entry)->group;
+}
+
+static uint32_t
+mirror_entry_to_mirror_suffix_group(struct mlx5_list_entry *entry)
+{
+	struct mlx5_list_entry *suffix = container_of(entry,
+						      struct mlx5_nta_sample_cached_mirror,
+						      entry)->suffix;
+
+	return container_of(suffix, struct mlx5_nta_sample_cached_group, entry)->group;
+}
+
 static struct mlx5_list_entry *
 mlx5_nta_sample_cached_mirror_create(void *cache_ctx, void *cb_ctx)
 {
@@ -175,9 +215,15 @@ static void
 mlx5_nta_sample_cached_mirror_remove(void *cache_ctx, struct mlx5_list_entry *entry)
 {
 	struct rte_eth_dev *dev = cache_ctx;
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+
 	struct mlx5_nta_sample_cached_mirror *obj =
 		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
 	mlx5_hw_mirror_destroy(dev, obj->mirror);
+
+	mlx5_list_unregister(ctx->mirror_groups, obj->sample);
+	mlx5_list_unregister(ctx->mirror_groups, obj->suffix);
 	mlx5_free(obj);
 }
 
@@ -358,6 +404,18 @@ register_mirror_actions(struct rte_flow_action *actions, struct mlx5_list *cache
 	return mlx5_list_register(cache, &ctx);
 }
 
+void
+mlx5_nta_sample_mirror_entry_release(struct rte_eth_dev *dev,
+				     struct mlx5_sample_release_ctx *release)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_nta_sample_ctx *ctx = priv->nta_sample_ctx;
+
+	mlx5_list_unregister(ctx->mirror_actions, release->mirror_entry);
+	release_cached_group(dev, release->sample_group);
+	mlx5_free(release);
+}
+
 static struct mlx5_list_entry *
 mlx5_create_nta_mirror(struct rte_eth_dev *dev,
 		       const struct rte_flow_attr *attr,
@@ -405,6 +463,33 @@ mlx5_create_nta_mirror(struct rte_eth_dev *dev,
 	return NULL;
 }
 
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
+	}
+
+	/*
+	 * Find the last power of 2 with ratio larger then the goal.
+	 */
+	for (i = 2; i < UINT32_WIDTH; i++) {
+		double res = 1.0 / RTE_BIT32(i);
+
+		if (res < goal)
+			return RTE_BIT32(i - 1) - 1;
+	}
+
+	return UINT32_MAX;
+}
+
 static void
 mlx5_nta_parse_sample_actions(const struct rte_flow_action *action,
 			      const struct rte_flow_action **sample_action,
@@ -430,24 +515,309 @@ mlx5_nta_parse_sample_actions(const struct rte_flow_action *action,
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
+			struct mlx5_list_entry *mirror_entry,
+			struct mlx5_flow_head *flow_head,
+			struct rte_flow_error *error)
+{
+	const struct rte_flow_attr suffix_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+		.group = mirror_entry_to_mirror_suffix_group(mirror_entry),
+	};
+	const struct rte_flow_attr sample_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+		.group = mirror_entry_to_mirror_sample_group(mirror_entry),
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
+	ret = flow_hw_create_flow(dev, type, &sample_attr,
+				  secondary_pattern, sample_actions,
+				  MLX5_FLOW_LAYER_OUTER_L2, sample_action_flags,
+				  true, &sample_flow, error);
+	if (ret != 0) {
+		flow_hw_destroy(dev, suffix_flow);
+		return ret;
+	}
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
+		   struct mlx5_list_entry *mirror_entry,
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
+			.conf = mirror_entry_to_mirror_action(mirror_entry)
+		},
+		[1] = { .type = RTE_FLOW_ACTION_TYPE_END }
+	};
+
+	if (random_mask > UINT16_MAX)
+		return NULL;
+	flow_hw_create_flow(dev, type, &sample_attr, sample_pattern, sample_actions,
+			    0, 0, true, &sample_flow, error);
+	return sample_flow;
+}
+
+static int
+create_random_miss_actions(struct rte_eth_dev *dev,
+			   const struct rte_flow_attr *attr,
+			   uint32_t sample_group,
+			   struct mlx5_list_entry *mirror_entry,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_group_attr sample_group_attr = {
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+	};
+	const struct rte_flow_action sample_miss_actions[2] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &(struct rte_flow_action_jump) {
+				.group = mirror_entry_to_mirror_suffix_group(mirror_entry)
+			}
+		},
+		[1] = { .type = RTE_FLOW_ACTION_TYPE_END }
+	};
+
+	return mlx5_flow_hw_group_set_miss_actions(dev, sample_group, &sample_group_attr,
+						   sample_miss_actions, error);
+}
+
+static void
+save_sample_release_cxt(struct mlx5_sample_release_ctx *release,
+			struct mlx5_flow_head *flow_head,
+			struct mlx5_list_entry *mirror_entry,
+			uint32_t sample_group)
+{
+	struct rte_flow_hw *var;
+
+	release->mirror_entry = mirror_entry;
+	release->sample_group = sample_group;
+
+	SLIST_FOREACH(var, flow_head, nt2hws->next) {
+		if (SLIST_NEXT(var, nt2hws->next) == NULL)
+			var->nt2hws->sample_release_ctx = release;
+	}
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
+			     struct mlx5_list_entry *mirror_entry,
+			     struct mlx5_flow_head *flow_head,
+			     struct rte_flow_error *error)
+{
+	int ret;
+	uint32_t sample_group = alloc_cached_group(dev);
+	struct rte_flow_hw *base_flow = NULL, *sample_flow = NULL;
+	struct mlx5_sample_release_ctx *release = NULL;
+
+	if (sample_group == 0)
+		return NULL;
+	release = mlx5_malloc(MLX5_MEM_ANY, sizeof(*release), 0, SOCKET_ID_ANY);
+	if (release == NULL) {
+		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ACTION,
+				   NULL, "Failed to allocate release context");
+		goto error;
+	}
+	ret = create_mirror_aux_flows(dev, type, attr,
+				      suffix_actions, sample_actions,
+				      mirror_entry, flow_head, error);
+	if (ret != 0)
+		goto error;
+	ret = create_random_miss_actions(dev, attr, sample_group,
+					       mirror_entry, error);
+	if (ret != 0)
+		goto error;
+	sample_flow = create_sample_flow(dev, type, attr, sample_ratio, sample_group,
+					 mirror_entry, error);
+	if (sample_flow == NULL)
+		goto error;
+	sample_flow->nt2hws->chaned_flow = 1;
+	SLIST_INSERT_HEAD(flow_head, sample_flow, nt2hws->next);
+	action_append(prefix_actions,
+		&(struct rte_flow_action) {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &(struct rte_flow_action_jump) { .group = sample_group }
+		});
+	ret = flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
+				  item_flags, action_flags, true, &base_flow, error);
+	if (ret != 0)
+		goto error;
+	SLIST_INSERT_HEAD(flow_head, base_flow, nt2hws->next);
+	save_sample_release_cxt(release, flow_head, mirror_entry, sample_group);
+	return base_flow;
+
+error:
+	if (!SLIST_EMPTY(flow_head))
+		release_chained_flows(dev, flow_head, type);
+	if (release)
+		mlx5_free(release);
+	if (sample_flow)
+		release_cached_group(dev, sample_group);
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
+			     struct mlx5_list_entry *mirror_entry,
+			     struct mlx5_flow_head *flow_head,
+			     struct rte_flow_error *error)
+{
+	int ret;
+	struct rte_flow_hw *base_flow = NULL;
+	struct mlx5_sample_release_ctx *release = mlx5_malloc(MLX5_MEM_ANY, sizeof(*release),
+							      0, SOCKET_ID_ANY);
+
+	if (release == NULL) {
+		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ACTION,
+				   NULL, "Failed to allocate release context");
+		return NULL;
+	}
+	ret = create_mirror_aux_flows(dev, type, attr,
+				      suffix_actions, sample_actions,
+				      mirror_entry, flow_head, error);
+	if (ret != 0)
+		goto error;
+	action_append(prefix_actions,
+		&(struct rte_flow_action) {
+			.type = (enum rte_flow_action_type)MLX5_RTE_FLOW_ACTION_TYPE_MIRROR,
+			.conf = mirror_entry_to_mirror_action(mirror_entry)
+		});
+	ret = flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
+				  item_flags, action_flags,
+				  true, &base_flow, error);
+	if (ret != 0)
+		goto error;
+	SLIST_INSERT_HEAD(flow_head, base_flow, nt2hws->next);
+	save_sample_release_cxt(release, flow_head, mirror_entry, 0);
+	return base_flow;
+
+error:
+	if (!SLIST_EMPTY(flow_head))
+		release_chained_flows(dev, flow_head, type);
+	if (release)
+		mlx5_free(release);
+	return NULL;
+}
+
 struct rte_flow_hw *
 mlx5_nta_sample_flow_list_create(struct rte_eth_dev *dev,
-				 enum mlx5_flow_type type __rte_unused,
+				 enum mlx5_flow_type type,
 				 const struct rte_flow_attr *attr,
-				 const struct rte_flow_item pattern[] __rte_unused,
+				 const struct rte_flow_item pattern[],
 				 const struct rte_flow_action actions[],
-				 uint64_t item_flags __rte_unused,
-				 uint64_t action_flags __rte_unused,
+				 uint64_t item_flags, uint64_t action_flags,
 				 struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_mirror *mirror __rte_unused;
-	struct mlx5_list_entry *entry;
+	struct mlx5_list_entry *mirror_entry;
+	struct rte_flow_hw *flow = NULL;
 	const struct rte_flow_action *sample;
 	struct rte_flow_action *sample_actions;
 	const struct rte_flow_action_sample *sample_conf;
 	struct rte_flow_action prefix_actions[MLX5_HW_MAX_ACTS] = { 0 };
 	struct rte_flow_action suffix_actions[MLX5_HW_MAX_ACTS] = { 0 };
+	struct mlx5_flow_head flow_head = SLIST_HEAD_INITIALIZER(NULL);
 
 	if (priv->nta_sample_ctx == NULL) {
 		int rc = mlx5_init_nta_sample_context(dev);
@@ -458,13 +828,30 @@ mlx5_nta_sample_flow_list_create(struct rte_eth_dev *dev,
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
-	entry = mlx5_create_nta_mirror(dev, attr, sample_actions,
+	mirror_entry = mlx5_create_nta_mirror(dev, attr, sample_actions,
 					suffix_actions, error);
-	if (entry == NULL)
-		goto error;
-	mirror = container_of(entry, struct mlx5_nta_sample_cached_mirror, entry)->mirror;
-error:
-	return NULL;
+	if (mirror_entry == NULL)
+		return NULL;
+	if (sample_conf->ratio == 1) {
+		flow = mlx5_nta_create_mirror_flow(dev, type, attr, item_flags, action_flags,
+						   pattern, prefix_actions, suffix_actions,
+						   sample_actions, mirror_entry,
+						   &flow_head, error);
+	} else {
+		flow = mlx5_nta_create_sample_flow(dev, type, attr, sample_conf->ratio,
+						   item_flags, action_flags, pattern,
+						   prefix_actions, suffix_actions,
+						   sample_actions, mirror_entry,
+						   &flow_head, error);
+	}
+	if (flow == NULL)
+		mlx5_list_unregister(priv->nta_sample_ctx->mirror_actions, mirror_entry);
+	return flow;
 }
diff --git a/drivers/net/mlx5/mlx5_nta_sample.h b/drivers/net/mlx5/mlx5_nta_sample.h
index 07b7589a75..44d5b3b01a 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.h
+++ b/drivers/net/mlx5/mlx5_nta_sample.h
@@ -19,4 +19,7 @@ mlx5_nta_sample_flow_list_create(struct rte_eth_dev *dev,
 void
 mlx5_nta_sample_context_free(struct rte_eth_dev *dev);
 
+void
+mlx5_nta_sample_mirror_entry_release(struct rte_eth_dev *dev,
+				     struct mlx5_sample_release_ctx *release);
 #endif /* RTE_PMD_MLX5_NTA_SAMPLE_H_ */
-- 
2.48.1

