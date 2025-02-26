Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3549C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B6640649;
	Wed, 26 Feb 2025 17:05:22 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by mails.dpdk.org (Postfix) with ESMTP id 4F82240648
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:05:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4P0ubqzdb9VUo1mKLJ3WHTRJ9MrWufievhk1xJygXP2jll21RlnTv5xvPJ3EK4O8jAdCEFKADWQOhXkP3NO3LR0mX7vf2ib8Hl4bavxRtOGBM2phmAs6w1d+oCYWy7XGCMtExzDEf9zC/O47oubfvNAu3/9l46MOxzuzj9hv4Dsoc9KveUsgvwLwWwQPQQFsUnATYa6KIZNHJS1Ecn8hxbiZv3S03POvLz8yVQIezuZM2lilGW0Y0QHYDKjUOtEdFeMRpQ1V4NJXRgsZc3jOO11GmPRe6znqrm0zywklR+YOrU7YUcYE1yV9zeDJ5bGxqQrTzkGrOZl385zvTwnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAZ9r/UKh3S384eb/q/TOkcvYCwWXvNFtzKjCRG9+f4=;
 b=eiNi6g4r2rGKr5DzYtkC7War0JObQayPwSRTJ528X8XpXT5yZKLD91sJ7CgZV+Y+SAByqmfGOyQTFS3w5bT7R1EQscKw/SAwSAF4FWtPjbXhDzLED+Nci/QNguT2yvf7zeUELNajrPTllZ1UjN2gqBdz7W6u/ybfZ2+m3W+feL+1u8ptmHyy41Lcs6G+p4quM9dJIXEzMfKMIVPORUc4U9oAXEnzAXf6Vqk+W2qXBkqq7YSJic/sWwk8reNSVokD6GOi9o5oR6YQ3EkKUOTwgbxjmmZEyY+P8RGgNgCpr53PvpN6Ny6hR93bs0VarqHtnxYO0O2Sf1Z1gTHiysSJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAZ9r/UKh3S384eb/q/TOkcvYCwWXvNFtzKjCRG9+f4=;
 b=rm4NNGdj3QC6o2pH8h+71Ry6eo7qAGfXQ1DaIZF0kQGO3yE5fKiuoyptVeV0HbNfqqaZBjtY4OX8Ug1my7osyw3wLKoNq+8+KGlwPef56FHJnjhbHqdieLx6C5RgtwcJq/Bj8vvxam772BuT7C7hyqkLNRAjSTPxZZTIbNbGxMa9sgEIxl3Q9x+l9Y3YK4n2Q1E9fdf27U2OTOCdXk4jHGjyIDj0AsnxfDL131ggCQBoA4ZZw3VmkI0IZnWpvLQIKNOw1zQVl7DhTqptoCUmTlADPGX6DkpiI+qoRr5bI/vs7N8nZUh8jljriL3IEeZVZZ/S1WGeFjK+52BT7fq1Xg==
Received: from BL1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:256::25)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 16:05:16 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::da) by BL1PR13CA0020.outlook.office365.com
 (2603:10b6:208:256::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Wed,
 26 Feb 2025 16:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 16:05:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 08:04:56 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 08:04:54 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v3 3/3] net/mlx5: allow FDB RSS
Date: Wed, 26 Feb 2025 17:04:25 +0100
Message-ID: <20250226160425.78147-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226160425.78147-1-dsosnowski@nvidia.com>
References: <20250226140119.2142352-1-suanmingm@nvidia.com>
 <20250226160425.78147-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: da1e3e2f-c484-421a-fe2d-08dd567f5c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?siFAZ8730oxO7CFT3zh1QxRzJ5+zEvpe89gjSwca/jCduDYZZkxrsGmITJwY?=
 =?us-ascii?Q?kWUUy1nibZsZechvdMApAlvf7pMXIX2zEuBoq61INPxwIGw/VJjCHO0e/Zgk?=
 =?us-ascii?Q?2FZjDEeyaOPByDZeAyFlljYXrof8dn1oeE1LDAKWSodN6Qj8GCqE8VgEA8j/?=
 =?us-ascii?Q?tTDBRQHdXnT1h+t31BQgMKTME6eHA6kG/BADMDdds//axcwWo+1d5irToOZN?=
 =?us-ascii?Q?lXAZ3QGWqiRmLalC5RAJz57pO1wwkm4PBxY6ZbzDixo6mGjyGaq+pp6fiHTR?=
 =?us-ascii?Q?+UsuLomwyxe3CAYJYJTu8/TvFKpkLq6e6rny/L7djhpIT/e64Y82zbu8Vqpm?=
 =?us-ascii?Q?2SjY62eXv1aNo2mxFD8AdcsWI6NW2I6nGr5jNvvduEsSSler0obkcwBnflpw?=
 =?us-ascii?Q?gzOj01VgaDHQi/wAizogOK3k6jpwQlVvsNlvV66nPvK5zG5qHr3HSNqUuaHw?=
 =?us-ascii?Q?l/QGBOqsPvpt9ou3/VdhdbP+vNUkdj//0xvej3kuTQw5CgDV/741CXfwk1bz?=
 =?us-ascii?Q?KurfYmMkIBT4kR8vpcj5/VibHLqMpwQWBcbPzxoVugo8qYu/odnd1qod1x6W?=
 =?us-ascii?Q?VEMGxIePHLij2vDsgwJJIRpC9M0UbwvGuSduS0CxxoWuIYTNBKFXlKAgQSs9?=
 =?us-ascii?Q?YKSySwfAqB215ZaL7aWLyLorHtwwIFmFKo80xUu0T1916fCGlv2AkmlcZNKN?=
 =?us-ascii?Q?kbM6nJ7RgeAYxjcYxfaycSMUcN0WaDDjjrIOS07jS2r9D1taAoJRMSfmgIkO?=
 =?us-ascii?Q?7RuWY1x9AL2qaG54CsaZJkz973dQqNODaYPndvW2QZY/3znf2qonDT1GMFUF?=
 =?us-ascii?Q?K8nAOaFMni6HkDlbHIf3PHsyJH3Wjl0zkYs8RNxi+uSJ7hiJ78wITtf89lUs?=
 =?us-ascii?Q?LHqNXHTc1Xp9omjTSC+kadQ+Dd16lGZ4FE8PmYsEjeHvc14XpI4eiIVkHQcU?=
 =?us-ascii?Q?L1uqUv45tmlOsOyMQq2UwyodCF0u2sOYl8p0T0IFrWGtIJCNpulBRWatjiye?=
 =?us-ascii?Q?XfdhSHE35LwtiyCCd2Jq+W9ScUA9c39QS6dZUWCpDiSzLdl7rcXRcC7ZuGBr?=
 =?us-ascii?Q?UPqKoONWWtJlXTLsxWwv1nen7fc+bSmitqK6lDCKpf81C5skEosuTzfUiZbX?=
 =?us-ascii?Q?5no3Zgzx8cX3ixQb4Q46jefv5xhrFCC4YNJHhFP35P6z9c7l/AX0H9rHZ28s?=
 =?us-ascii?Q?y1xM6c4EumfFFeaoY8Rozs0LBhKO/KZXl2fFD4HFVNMLobTZYisxT55GkP4c?=
 =?us-ascii?Q?1J7tG7M5NbD2e3/InWfldce4CVO5Toe66fKgtHaTAh1gDTacL39a1xdPu95o?=
 =?us-ascii?Q?b4xpzL8Fg+IuyWWMMLautnzYGoAOFODgMIIItrN/Kvi0rvh6P+SLHQ6yu7Wk?=
 =?us-ascii?Q?1FvfHxRmQnnolLLibLhg/hHiXw+mhyMO6efDwKhONUpgX7I7mLBGyn50MGTp?=
 =?us-ascii?Q?+tZcsRNcVNUQuqPcxVR5nXiWn4vrwAtf2eA2DHxh3ZUZg2tZvCqGnXBptIcn?=
 =?us-ascii?Q?+RcxbcDRRtRRFY0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:05:16.1825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e3e2f-c484-421a-fe2d-08dd567f5c2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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

From: Suanming Mou <suanmingm@nvidia.com>

RSS can be used in FDB Rx rules when JUMP_FDB_RX action to allow
jump from FDB Tx to FDB Rx table.

Different with NIC RSS, FDB RSS will not do the internal implicit
metadata copy.

This commit enables the FDB RSS if JUMP_FDB_RX is supported.

Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst        |  4 ++++
 drivers/net/mlx5/mlx5_flow.c    |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c | 32 +++++++++++++++++---------------
 drivers/net/mlx5/mlx5_flow_hw.c | 20 +++++++++++++++-----
 4 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index def40fc20a..190c58b54d 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -970,6 +970,10 @@ Limitations
   The flow engine of a process cannot move from active to standby mode
   if preceding active application rules are still present and vice versa.
 
+- Since only when unified FDB is enabled, there will be FDB Rx/Tx, jump FDB Rx
+  is valid only when unfied is enabled. And in unified FDB mode, the tag and RSS
+  actions are only allowed in FDB Rx domain.
+
 
 Statistics
 ----------
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 69d7621d0b..f8b3e504b3 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1977,9 +1977,9 @@ mlx5_flow_validate_action_mark(struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
 					  "mark action not supported for "
 					  "egress");
-	if (attr->transfer && mlx5_hws_active(dev))
+	if (attr->transfer && !mlx5_hws_active(dev))
 		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
+					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, NULL,
 					  "non-template mark action not supported for transfer");
 	return 0;
 }
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 633c41e358..61d3101ce8 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -8939,21 +8939,23 @@ flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
 						  NULL,
 						  "unsupported action MARK");
-		if (action_flags & MLX5_FLOW_ACTION_QUEUE)
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  NULL,
-						  "unsupported action QUEUE");
-		if (action_flags & MLX5_FLOW_ACTION_RSS)
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  NULL,
-						  "unsupported action RSS");
-		if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
-			return rte_flow_error_set(error, EINVAL,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  actions,
-						  "no fate action is found");
+		if (!priv->jump_fdb_rx_en) {
+			if (action_flags & MLX5_FLOW_ACTION_QUEUE)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  NULL,
+							  "unsupported action QUEUE");
+			if (action_flags & MLX5_FLOW_ACTION_RSS)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  NULL,
+							  "unsupported action RSS");
+			if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  actions,
+							  "no fate action is found");
+		}
 	} else {
 		if (!(action_flags & MLX5_FLOW_FATE_ACTIONS) && attr->ingress)
 			return rte_flow_error_set(error, EINVAL,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 8909f5b506..3bfb2f35c1 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -7036,6 +7036,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev *dev,
 			      uint64_t action_flags,
 			      struct rte_flow_error *error)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	const struct rte_flow_action_queue *queue_mask = template_mask->conf;
 	const struct rte_flow_attr attr = {
 		.ingress = template_attr->ingress,
@@ -7044,7 +7045,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev *dev,
 	};
 	bool masked = queue_mask != NULL && queue_mask->index;
 
-	if (template_attr->egress || template_attr->transfer)
+	if (template_attr->egress || (template_attr->transfer && !priv->jump_fdb_rx_en))
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
 					  "QUEUE action supported for ingress only");
@@ -7063,9 +7064,10 @@ mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
 			      __rte_unused uint64_t action_flags,
 			      struct rte_flow_error *error)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	const struct rte_flow_action_rss *mask = template_mask->conf;
 
-	if (template_attr->egress || template_attr->transfer)
+	if (template_attr->egress || (template_attr->transfer && !priv->jump_fdb_rx_en))
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
 					  "RSS action supported for ingress only");
@@ -8114,6 +8116,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 	}
 	if (priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 	    priv->sh->config.dv_esw_en &&
+	    !attr->transfer &&
 	    (action_flags & (MLX5_FLOW_ACTION_QUEUE | MLX5_FLOW_ACTION_RSS))) {
 		/* Insert META copy */
 		mf_actions[expand_mf_num] = rx_meta_copy_action;
@@ -12140,23 +12143,30 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	/* Add global actions. */
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
 		uint32_t act_flags = 0;
+		uint32_t tag_flags = mlx5_hw_act_flag[i][0];
 
 		act_flags = mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
 			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
 		if (is_proxy) {
-			if (unified_fdb)
+			/* Tag action is valid only in FDB_Rx domain. */
+			if (unified_fdb) {
 				act_flags |=
 					(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
 					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
 					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
-			else
+				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT)
+					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
+			} else {
 				act_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
+				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT)
+					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
+			}
 		}
 		priv->hw_drop[i] = mlx5dr_action_create_dest_drop(priv->dr_ctx, act_flags);
 		if (!priv->hw_drop[i])
 			goto err;
 		priv->hw_tag[i] = mlx5dr_action_create_tag
-			(priv->dr_ctx, mlx5_hw_act_flag[i][0]);
+			(priv->dr_ctx, tag_flags);
 		if (!priv->hw_tag[i])
 			goto err;
 	}
-- 
2.39.5

