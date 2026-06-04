Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08BCD6E68
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:53:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65F51402B6;
	Thu,  4 Jun 2026 05:53:08 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9C0FC40270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:53:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDStXTQpBAfHSlnxmpeTkb/I95mm1qWeDpwqK/ut3PS6YRsagehP/D4fdRIQ7DOoA9d0epChqyCZlU0xTTAlvhnLi16j8/3iq0pp+6x/oIEyWySbYPrJK571OFGuYiaS2dIWKsvVT9gI8BmfN7WOdP5BVtSmLvd+PvwmFTuRmls/7r2pbVIQ5uepaQ16/F55pdnsf+mDdDJ8ddS4gETsYlWXEosM5V9NA551GqDp2CYbGBePQMWdivspDFsqUbAQfr0CVq2abuq5RtKt0K21aPHbOuMhfhirs5Y4ItB+r/oQ8ABILXuDA35/oIuQZNQJTi8WD1Vz8xXQCTbX7AbxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1J5sJoHaEoLogM3EmcjrqSuIiGrOKP1xpXRQho3d4Y=;
 b=Bezw15wZ4vCdjM0JZO6nHGJ+tupFm29QDwplzZlMAZVikGPOQfw5vRRlSVZDvCw9hZRUxv1mU13LZN0oQmEeOnG1tJWt3362FbbZaTmhuj13Kdv2Sb7zVj2Cf86bkCNJfRYCsHcgWj4W7M/vR8wDhUPsNxN4stGzTjdJhAcmIpna/gxkLHe4+Lbf6pYu7csiaxVLj62SlkVJFlU0qdfujQk3NAdEtp1znad+gRVF8cKc2FRM0FlqD7RUVTwcg+bT9OPONpRsbH2oWdgFXZdfcmlXQ3SqXjl+UdyZUx4nJBevhJyuAmzS2N5qpRtSZp4OkZ/X1y/2vHhnPjX3BoZo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1J5sJoHaEoLogM3EmcjrqSuIiGrOKP1xpXRQho3d4Y=;
 b=nR1mWeUGBNuydzOHsPmpAEvFoUz327pP57G1Ab9TeuKVQXSMNBcLEQEJLr4A4hrlcuCvV6GAZ26XE1TXM4QoITHvND+Vhk66UKhNt5b6tGHFy2/av6xszhxInmZ+c4AWhdrRBYcSepdp/Obo1ofi1KJgTjuXfA+ZfRYOjbh9wJu2Gsn+Mve84q4KRC5yxzAaxqCDC5HThTJSKnPDF1gXHwlGHzaHOlui03z+fH5Z1/fpOStX+DHw7Skt+ixx35ulqiecFWQMbDYovQNbB8dzike6ZsrnAXBOukiHMnE9gg0tNsu0VvW3ELUhLASdFqCJqnqFcHMfzkGtzIYi9fvQ2Q==
Received: from CH0PR03CA0321.namprd03.prod.outlook.com (2603:10b6:610:118::17)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 4 Jun 2026
 03:52:58 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::11) by CH0PR03CA0321.outlook.office365.com
 (2603:10b6:610:118::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 03:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 03:52:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 20:52:45 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 20:52:42 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH] net/mlx5: fix the eCPRI match on HWS root table
Date: Thu, 4 Jun 2026 06:52:22 +0300
Message-ID: <20260604035222.3415-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bfb65b-b70e-462c-a7bb-08dec1ecc47b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099006|11063799006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info: rtajGHqV5Sm+mM5uuJtttvu5gfD+tht7MSBUNIZMUb3O3C5VYyAXKo81zSdVudeKrmvgb55tyoHmqP/nEODF1GC55dBO9f+MUBqvMP/IteEvQVP6oA6KvEemycgUIZd1RHCvbnSTykh89eZzqXMvqXD80lJy7Py/LW8pqycMM0rjOcvpzkk52mgWo2AaywLk0IS+CGfxGUcRQ93XMy3jBVW7wHIOTt6XMXZSRUDJQjezuSaSp3W25Q+W60+J0PugIhlUi7rvhBdmvQKHAxn5zHxhlmCTLsRD5fbNqPe7JY5ZwkFUqFEPtPrjwMj8EXCrhSW2X0bbH51NtjMTDQVCjYgw2lkYj+adXhOObBQEQ6OWCyga/cAtL8eS/Yq+YFVDgs4Bsu0b6vCzvzBXrWc72IB6owBU+rWiZf/nly1JvzYozU84g5YGS4vgpRKEM66H+g/1X23uFHU31KWH4QOytYjiDIY8i/hfK+encY2gZv6uGpY15cyO8p7mbGqnxlq78TTC0mgdAaSi/dTEge4l1VR6AJasnMCmj/jNKPrlwc/y1bpQuiaK+hN8k2+AjuWueP4+RWbeW5A309hX+Rjuab8aku88EWSD27Y3VJ57JMcIkj3z7RVrpg6oxuXJOWWnvtc/42CNtgO6ADqpIgPTwlcvPRCTfv+mVC7zCT7dSL6qKbvYgMjh1C3N2fLLCorYR5JGfgkOUPQB8Vgtp/Iq3JTq3UzUud5On+xKe1ABn3E=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099006)(11063799006)(5023799004)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rsx51xf00/T22X8sKX6YHR1e/kFZpkAd6Tgef2X9U3pafJx508kBodotnELar2kPEubDoDL+VZV+Q38X8CJEhUeSIYkk8MmEpnYxkM7qzAGlTfsMCzu9VJxa3RG15tpNCpDBkBi8J7XPD2TfXaziEdds0KPnEP1uPTLH3ij1B88nJQiS9Z4P2SogKtu6pFG2eRv0sgdPAjykUyZcdmKzGB6YR1A3xsSzqBMhvreZNciZVV1pEfrVprUqBtzn5OxDebFxea4ArAI3BbzmcfKbV3jP1EfNxaZ+PV8H7YZ9cnoQMGvPZFptuu00Ylrqx9KO4H+nZTJ4EozBmvs7xcjL30wqcTwHLLaYAb/Mc3eprY75eOJWCxEUM8mB7gDlbLa+yOhlHnT4HPd5boGOfDjdxzY5u3dwFd0Fj8FuQXZr2zupTXEkJHPYYUJwGT+E4sxb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 03:52:58.4474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bfb65b-b70e-462c-a7bb-08dec1ecc47b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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

When inserting a rule on the root table in HWS mode, the DV
interfaces are still being used for the matcher and value
translation.

For item eCPRI in HWS mode, the DWs of message header and body may be
0 for a valid rule. So we need to use some flags on root table to
decide if the sample ID and matching value should be set for the
rule. Since the table and rule may be created in turn for
asynchronous flow API, the flags should be per table to avoid
over-written. In SWS mode, nothing would be done separately for the
matcher itself.

On the non-root table in HWS, the callbacks to fill the WQE will
handle such case automatically.

Fixes: 93c7d4c22628 ("net/mlx5: support eCPRI with HWS")

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_matcher.c |  1 +
 drivers/net/mlx5/hws/mlx5dr_matcher.h |  1 +
 drivers/net/mlx5/hws/mlx5dr_rule.c    |  1 +
 drivers/net/mlx5/mlx5_flow.h          |  7 +++
 drivers/net/mlx5/mlx5_flow_dv.c       | 77 +++++++++++++++++++++------
 5 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_matcher.c b/drivers/net/mlx5/hws/mlx5dr_matcher.c
index 8c07ea8882..511f394448 100644
--- a/drivers/net/mlx5/hws/mlx5dr_matcher.c
+++ b/drivers/net/mlx5/hws/mlx5dr_matcher.c
@@ -1381,6 +1381,7 @@ static int mlx5dr_matcher_init_root(struct mlx5dr_matcher *matcher)
 	LIST_INSERT_HEAD(&matcher->tbl->head, matcher, next);
 	pthread_spin_unlock(&ctx->ctrl_lock);
 
+	matcher->hws_root_match_flags = flow_attr.hws_root_match_flags;
 	return 0;
 
 free_mask:
diff --git a/drivers/net/mlx5/hws/mlx5dr_matcher.h b/drivers/net/mlx5/hws/mlx5dr_matcher.h
index ef42b7de6b..fbcf9fe09e 100644
--- a/drivers/net/mlx5/hws/mlx5dr_matcher.h
+++ b/drivers/net/mlx5/hws/mlx5dr_matcher.h
@@ -82,6 +82,7 @@ struct mlx5dr_matcher {
 	uint8_t num_of_at;
 	/* enum mlx5dr_matcher_flags */
 	uint8_t flags;
+	uint32_t hws_root_match_flags;
 	struct mlx5dr_devx_obj *end_ft;
 	struct mlx5dr_matcher *col_matcher;
 	struct mlx5dr_matcher *resize_dst;
diff --git a/drivers/net/mlx5/hws/mlx5dr_rule.c b/drivers/net/mlx5/hws/mlx5dr_rule.c
index 0fda0a2d71..fe69721c92 100644
--- a/drivers/net/mlx5/hws/mlx5dr_rule.c
+++ b/drivers/net/mlx5/hws/mlx5dr_rule.c
@@ -741,6 +741,7 @@ int mlx5dr_rule_create_root_no_comp(struct mlx5dr_rule *rule,
 	}
 
 	flow_attr.tbl_type = rule->matcher->tbl->type;
+	flow_attr.hws_root_match_flags = rule->matcher->hws_root_match_flags;
 
 	ret = mlx5_flow_dv_translate_items_hws(items, &flow_attr, value->match_buf,
 					       MLX5_SET_MATCHER_HS_V, NULL,
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index c9e72a33d6..39c85eb9a4 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -117,6 +117,9 @@ enum mlx5_indirect_type {
 	((struct rte_flow_action_handle *)(uintptr_t) \
 	 ((MLX5_INDIRECT_ACTION_TYPE_CT << MLX5_INDIRECT_ACTION_TYPE_OFFSET) | (index)))
 
+#define MLX5_EMPTY_ECPRI_TYPE_MASK RTE_BIT32(0)
+#define MLX5_EMPTY_ECPRI_BODY_MASK RTE_BIT32(1)
+
 enum mlx5_indirect_list_type {
 	MLX5_INDIRECT_ACTION_LIST_TYPE_ERR = 0,
 	MLX5_INDIRECT_ACTION_LIST_TYPE_LEGACY = 1,
@@ -1264,6 +1267,7 @@ struct mlx5_flow_attr {
 	/* Action flags, used by priority adjustment. */
 	uint32_t act_flags;
 	uint32_t tbl_type; /* Flow table type. */
+	uint32_t hws_root_match_flags;
 };
 
 /* Flow structure. */
@@ -1985,6 +1989,8 @@ struct mlx5_flow_workspace {
 	uint32_t skip_matcher_reg:1;
 	/* Indicates if need to skip matcher register in translate. */
 	uint32_t mark:1; /* Indicates if flow contains mark action. */
+	uint32_t empty_ecpri_type_mask:1; /* Indicates if eCPRI type was not masked. */
+	uint32_t empty_ecpri_body_mask:1; /* Indicates if 1st DW of eCPRI payload was not masked. */
 	uint32_t vport_meta_tag; /* Used for vport index match. */
 };
 
@@ -2018,6 +2024,7 @@ struct mlx5_dv_matcher_workspace {
 	const struct rte_flow_item *tunnel_item; /* Flow tunnel item. */
 	const struct rte_flow_item *gre_item; /* Flow GRE item. */
 	const struct rte_flow_item *integrity_items[2];
+	uint32_t *p_root_flags;
 };
 
 struct mlx5_flow_split_info {
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index c2a2874913..307354c886 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -7798,7 +7798,7 @@ mlx5_flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 				.u32 =
 				RTE_BE32(((const struct rte_ecpri_common_hdr) {
 					.type = 0xFF,
-					}).u32),
+				}).u32),
 			},
 			.dummy[0] = 0xffffffff,
 		},
@@ -11401,6 +11401,20 @@ flow_dv_translate_item_gtp_psc(void *key, const struct rte_flow_item *item,
 	return 0;
 }
 
+
+static inline void
+flow_dv_set_ecpri_sample1(void *misc4_v,
+			  const struct rte_flow_item_ecpri *ecpri_m,
+			  const struct rte_flow_item_ecpri *ecpri_v,
+			  uint32_t sample1)
+{
+	void *dw_v;
+	dw_v = MLX5_ADDR_OF(fte_match_set_misc4, misc4_v, prog_sample_field_value_1);
+	*(uint32_t *)dw_v = ecpri_v->hdr.dummy[0] & ecpri_m->hdr.dummy[0];
+	/* Sample#1, to match message body, offset 4. */
+	MLX5_SET(fte_match_set_misc4, misc4_v, prog_sample_field_id_1, sample1);
+}
+
 /**
  * Add eCPRI item to matcher and to the value.
  *
@@ -11418,6 +11432,7 @@ flow_dv_translate_item_gtp_psc(void *key, const struct rte_flow_item *item,
 static void
 flow_dv_translate_item_ecpri(struct rte_eth_dev *dev, void *key,
 			     const struct rte_flow_item *item,
+			     struct mlx5_dv_matcher_workspace *wks,
 			     uint64_t last_item, uint32_t key_type)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -11446,18 +11461,32 @@ flow_dv_translate_item_ecpri(struct rte_eth_dev *dev, void *key,
 					RTE_BE16(RTE_ETHER_TYPE_ECPRI);
 		}
 	}
+	/* HWS matcher does need a non-empty mask. */
 	if (MLX5_ITEM_VALID(item, key_type))
 		return;
-	MLX5_ITEM_UPDATE(item, key_type, ecpri_v, ecpri_m,
-		&rte_flow_item_ecpri_mask);
+	MLX5_ITEM_UPDATE(item, key_type, ecpri_v, ecpri_m, &rte_flow_item_ecpri_mask);
 	/*
 	 * Maximal four DW samples are supported in a single matching now.
 	 * Two are used now for a eCPRI matching:
 	 * 1. Type: one byte, mask should be 0x00ff0000 in network order
 	 * 2. ID of a message: one or two bytes, mask 0xffff0000 or 0xff000000
 	 *    if any.
+	 * Translation also handles the following cases.
+	 * 1. HWS mode may face a case with NULL mask and value all zeros.
+	 * 2. Matching all eCPRI packets will be done in ETH / VLAN item.
+	 * 3. If type is not masked, then message body will not be masked either, forcefully.
 	 */
-	if (!ecpri_m->hdr.common.u32)
+	if (key_type == MLX5_SET_MATCHER_HS_M) {
+		if (!ecpri_m->hdr.common.u32) {
+			*wks->p_root_flags |= MLX5_EMPTY_ECPRI_TYPE_MASK;
+			return;
+		}
+		/* Initialized with 0, this should not hit. */
+		*wks->p_root_flags &= ~MLX5_EMPTY_ECPRI_TYPE_MASK;
+	}
+	if (key_type == MLX5_SET_MATCHER_HS_V && (*wks->p_root_flags & MLX5_EMPTY_ECPRI_TYPE_MASK))
+		return;
+	if ((key_type & MLX5_SET_MATCHER_SW) && !ecpri_m->hdr.common.u32)
 		return;
 	samples = priv->sh->ecpri_parser.ids;
 	/* Need to take the whole DW as the mask to fill the entry. */
@@ -11473,27 +11502,40 @@ flow_dv_translate_item_ecpri(struct rte_eth_dev *dev, void *key,
 	 * Checking if message body part needs to be matched.
 	 * Some wildcard rules only matching type field should be supported.
 	 */
-	if (ecpri_m->hdr.dummy[0]) {
-		if (key_type == MLX5_SET_MATCHER_SW_M)
-			common.u32 = rte_be_to_cpu_32(ecpri_vv->hdr.common.u32);
-		else
-			common.u32 = rte_be_to_cpu_32(ecpri_v->hdr.common.u32);
+	if (key_type == MLX5_SET_MATCHER_HS_M) {
+		if (!ecpri_m->hdr.dummy[0]) {
+			*wks->p_root_flags |= MLX5_EMPTY_ECPRI_BODY_MASK;
+			return;
+		}
+		*wks->p_root_flags &= ~MLX5_EMPTY_ECPRI_BODY_MASK;
+	}
+	if (key_type == MLX5_SET_MATCHER_HS_V && (*wks->p_root_flags & MLX5_EMPTY_ECPRI_BODY_MASK))
+		return;
+	if (key_type & MLX5_SET_MATCHER_SW) {
+		if (!ecpri_m->hdr.dummy[0])
+			return;
+		common.u32 = rte_be_to_cpu_32(ecpri_vv->hdr.common.u32);
+	} else if (key_type == MLX5_SET_MATCHER_HS_V) {
+		common.u32 = rte_be_to_cpu_32(ecpri_v->hdr.common.u32);
+	}
+	if (key_type != MLX5_SET_MATCHER_HS_M) {
 		switch (common.type) {
 		case RTE_ECPRI_MSG_TYPE_IQ_DATA:
 		case RTE_ECPRI_MSG_TYPE_RTC_CTRL:
 		case RTE_ECPRI_MSG_TYPE_DLY_MSR:
-			dw_v = MLX5_ADDR_OF(fte_match_set_misc4, misc4_v,
-					    prog_sample_field_value_1);
-			*(uint32_t *)dw_v = ecpri_v->hdr.dummy[0] &
-					    ecpri_m->hdr.dummy[0];
-			/* Sample#1, to match message body, offset 4. */
-			MLX5_SET(fte_match_set_misc4, misc4_v,
-				 prog_sample_field_id_1, samples[1]);
+			flow_dv_set_ecpri_sample1(misc4_v, ecpri_v, ecpri_m, samples[1]);
 			break;
 		default:
 			/* Others, do not match any sample ID. */
 			break;
 		}
+	} else {
+		/* When MLX5_SET_MATCHER_HS_M on root table (default value),
+		 * the sample ID and mask should be set, or else prog_sample_field_id_1 will
+		 * be zero and a mismatch with the HWS rule.
+		 * Empty body mask for a matcher returns directly in the previous lines.
+		 */
+		flow_dv_set_ecpri_sample1(misc4_v, ecpri_v, ecpri_m, samples[1]);
 	}
 }
 
@@ -14501,7 +14543,7 @@ flow_dv_translate_items(struct rte_eth_dev *dev,
 					"cannot create eCPRI parser");
 		}
 		flow_dv_translate_item_ecpri
-				(dev, key, items, last_item, key_type);
+				(dev, key, items, wks, last_item, key_type);
 		/* No other protocol should follow eCPRI layer. */
 		last_item = MLX5_FLOW_LAYER_ECPRI;
 		break;
@@ -14698,6 +14740,7 @@ mlx5_flow_dv_translate_items_hws_impl(const struct rte_flow_item *items,
 		.attr = &rattr,
 		.rss_desc = &rss_desc,
 		.group = attr->group,
+		.p_root_flags = &attr->hws_root_match_flags,
 	};
 	int ret = 0;
 
-- 
2.21.0

