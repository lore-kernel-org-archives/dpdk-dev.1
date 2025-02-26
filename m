Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D87AC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E96140650;
	Wed, 26 Feb 2025 17:05:23 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by mails.dpdk.org (Postfix) with ESMTP id 0CAD640648
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:05:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHWtgNOVtqWDy74Ag5Z0qkMx0NVr0/0kQETEGZjxYA7wUBTdwI4ydPP0NgeiOQqZCD7vL5NIz0IRiEcEdeAEt/l/d5X9jCBsQVoSgob47I2Hg/gkWjjy7vHPq/dDCS0SLqiyDv2KoL0baCXalv6V7vkMasOosyzyrTXeSGr6bJz51x4s0as24sGTEIm1VS8vznEY8e3p/AfdOAEDtiHPON7iFifOZr4vPwBBwdV7lHY8rJR9IUMQ8DuCtT1tH6n+2/4o2b6U5r7sNJstxhuE1Zvc+vX0v/0gjFMPmilj6/DSA454twnK5LBwn+ym4r4FPm9MQ1b/vSJxTWsr5GxsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PRXIjcLmOTAeZrjGqJ0BKtd22aAoaR3VMZ8eg7UwT0=;
 b=ywadVkde3V0B/lIAHEtVvE6plnnJOQQ60naHKJQYDvjmQM3a3MQvMPpXwjV/5LZja3l5yW2Doff03XvBGusC3sOx4IeVy3KRbCGK1s8ZCxZS6xuIxxsTgpirGOJUO/FuA3sX2sLgGR4Co69tS6OSA7ORcTQ4yCVrubbggICyRe10VCrtJRjcAmSxO0U7otJn7aGI193uq6DL5/PDEsyxKg1Pt6btY8ynZfqvGediTjr5eewYvQY7qWENho2+Tambhr14zaqd1ikZ/I0DK+eMZ1ZdEx3zXUaMosyxFRRSknjJvhVMDqY+D5M+sl8bIaR9v82UyqCtR1kGPWFC+FFIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PRXIjcLmOTAeZrjGqJ0BKtd22aAoaR3VMZ8eg7UwT0=;
 b=EBp/i555yOc9J2herSf8RHk1y8/fT4rRJcI3S7ICSxlF88PetpMJjURXiYb7J9SxoVR2v6azaS8HdqdrhLivH2StBwqQxxZOJwL6y4XFXNNNYkxBUjGlqXkEl9ZCbzs32CZE7Ai4QGPO6h/J9mgfBMUhL+tIUwvtxTODjdc4qxNeCiMM46Z/f5sRyL2qtX6zbr7VJN5mBnIcTe42qDgNUbYAWxaFyKIGJtLyO+QnqY0tGjGvnSMX5om6C4lVGJS7+TROFryEvJsm7oOKoo/Y+WOFKMQfG/RczDJn5ONAht5YM7JdxDfP7RUlyXYMgfyoPO4BQLbFOMi601oKlCcdBg==
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 16:05:15 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::82) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 16:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 16:05:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 08:04:54 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 08:04:52 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v3 2/3] net/mlx5: add jump FDB Rx flag
Date: Wed, 26 Feb 2025 17:04:24 +0100
Message-ID: <20250226160425.78147-3-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae35935-2f63-495e-e5af-08dd567f5b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQMIujaylHrozz51Gq9Y36Fa0uwBUTlZhc6JBqqgNkDp4+5Kl9hAvlnQrJmC?=
 =?us-ascii?Q?z89+tP6AMPsTAKh9TmYs19BmeeofFQSzoQBH4YIEnChob+f8G6GFnScSsZRU?=
 =?us-ascii?Q?jH9Dx0u75DVrsRhJm/7FV9Xgxxe2XxWD/QwP9L0YQ500uA3gJK6Sl5oxZNH8?=
 =?us-ascii?Q?SqyH6tj02UPsXEixz0Gk06YryW1SU9dqn4ko7YNAEw2DEFQpZ0SeOlfLlurQ?=
 =?us-ascii?Q?o1OmAqfUJdGpne/kD69vQwlW9cCHuYvShqWEXrZB/iZ7yULhHQwaXf8AypKE?=
 =?us-ascii?Q?CrCU85/Kcb9Pg8zV5Ex7cIge7xO3I3IEIwA2OVGeS+8Ok77aF/P/5mU5d+Fr?=
 =?us-ascii?Q?Tz9xncTYtLJYI5uDbe43VRYucfpTIRQBWdFtQhEkZfp/qnjhX4IWE6gPPplC?=
 =?us-ascii?Q?R96h9ZLXqU19RbB48Z+fBJV2nShcH3/OSlW5FOzEQWM29k8qWQ4qphF7A7X6?=
 =?us-ascii?Q?zvn3595Qb9JyUK7l2xQdv3QWl/5vFYoJVOvGfL6oR2R+iIsP4uhTN/cWctr/?=
 =?us-ascii?Q?HaeDkL/yfk7QW4NodmqW4FMIyCwX7s61oMp8y53MQ8TLyrG4tFFGi3nqtU8/?=
 =?us-ascii?Q?XPOMKSLiJ+fgobEmWV7VN5TueQxKLUVxvvwtoVoA3fEDEW29A/KOQxDi1ePn?=
 =?us-ascii?Q?TbSPyeGr1vcBrWRoTr4TQHpWaWsEd+zcaUHj+QYpN7xgf9ijgBBDtBVKa83S?=
 =?us-ascii?Q?Dv329s0e2XyB2GPs407HrTl5oK5iFl7pZgBjJ2HJlCU/2gAtqmDbvmHttA9C?=
 =?us-ascii?Q?kuEf8qtW9HFt/6H5HI3VUsxSWy3OHRc3rrs1vzkji3hwHsdFxos+wEI+Gjpd?=
 =?us-ascii?Q?5uvFLotR11k4CLQJZHSF+rULM/LHl75MiuBBOOfs/RfM9h/3LKwzt6YKtbuq?=
 =?us-ascii?Q?4J4EM79l9Cd97WzT3BOWhtGF+Y2CALVZdg66lTumlrq5QtwKy0tsENjmp0a2?=
 =?us-ascii?Q?49BNNt++OZQilB4DSQ/rRS7yf9+Or/8kUrXM1t9AUl3rpKL0rfS6LCOJbyi6?=
 =?us-ascii?Q?hCBa/IXOv10NVnZOOdFZb+f2mzbnnRDUAr7n8kkYf2HFHcKeA1Fu+zG6Nfkg?=
 =?us-ascii?Q?8+XyB0Gq7ybi0KlQU6k2nRjodLFMvxC/9mwaq0P28cB5zbUVLuBtNCCH4k54?=
 =?us-ascii?Q?n+N00ncn688UQ3K10CDcm6o1akwFnZFtzSUbkueBefRMUNjStZ6+wWl23Axu?=
 =?us-ascii?Q?ZThmTJ5udEt1A8lSKTVNQERnKzcF2c+sMHtLfJFIHzvDSH05tTS80UttZFfk?=
 =?us-ascii?Q?ygPJET+TibLtxwBqni3rmO3n0p77euwZ3qJH+Ztr+km+BKcNpnXV/lcw6Ful?=
 =?us-ascii?Q?QGq+/2NNs/8xeAGbznQ51Q7LK6BBKoAg+eeELxBdp0UO+i6Uxp383+G4jb9b?=
 =?us-ascii?Q?Xgp7U4J4T3bdha9B5Jdc3mfQOg96DUAFrY7DPP6ZAX6fwMAdS+naFTTgbcBw?=
 =?us-ascii?Q?6e/J+OJgFwzk5hYglCskG4t7dbU58n1ShfCA80MzDjASwQHELWaC799O3Moy?=
 =?us-ascii?Q?63I1c9ayWFM1sUo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:05:15.0285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae35935-2f63-495e-e5af-08dd567f5b7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

When jump FDB Rx is supported, flow will be able to jump
from FDB Tx to FDB Rx, in that case the dest action in FDB
Rx table should support FDB Tx as well.

Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
 drivers/net/mlx5/linux/mlx5_os.c     | 9 +++++++--
 drivers/net/mlx5/mlx5.h              | 1 +
 drivers/net/mlx5/mlx5_flow_hw.c      | 8 +++++++-
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index f504b29f31..440820fd4f 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -924,6 +924,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	uint32_t out[MLX5_ST_SZ_DW(query_hca_cap_out)] = {0};
 	bool hca_cap_2_sup;
 	uint64_t general_obj_types_supported = 0;
+	uint64_t stc_action_type_127_64;
 	void *hcattr;
 	int rc, i;
 
@@ -1352,6 +1353,13 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		attr->fdb_unified_en = MLX5_GET(wqe_based_flow_table_cap,
 						hcattr,
 						fdb_unified_en);
+		stc_action_type_127_64 = MLX5_GET64(wqe_based_flow_table_cap,
+						    hcattr,
+						    stc_action_type_127_64);
+		if (stc_action_type_127_64 &
+		   (1 << (MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX -
+			  MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)))
+			attr->jump_fdb_rx_en = 1;
 	}
 	/* Query HCA attribute for ROCE. */
 	if (attr->roce) {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 8de4210fb2..6c726a0d46 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -326,6 +326,7 @@ struct mlx5_hca_attr {
 	uint32_t lag_rx_port_affinity:1;
 	uint32_t wqe_based_flow_table_sup:1;
 	uint32_t fdb_unified_en:1;
+	uint32_t jump_fdb_rx_en:1;
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7f13cb2c7d..573e846ed2 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1716,8 +1716,13 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		 *   4. all representors in HWS
 		 */
 		priv->unified_fdb_en = !!priv->master && sh->cdev->config.hca_attr.fdb_unified_en;
-		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
-			eth_dev->data->port_id, priv->unified_fdb_en ? "is" : "isn't");
+		/* Jump FDB Rx works only with unified FDB enabled. */
+		if (priv->unified_fdb_en)
+			priv->jump_fdb_rx_en = sh->cdev->config.hca_attr.jump_fdb_rx_en;
+		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled, jump_fdb_rx %s enabled.",
+			eth_dev->data->port_id,
+			priv->unified_fdb_en ? "is" : "isn't",
+			priv->jump_fdb_rx_en ? "is" : "isn't");
 		if (priv->sh->config.dv_esw_en) {
 			uint32_t usable_bits;
 			uint32_t required_bits;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index f73f6e63ff..545ba48b3c 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1987,6 +1987,7 @@ struct mlx5_priv {
 	uint32_t num_lag_ports:4; /* Number of ports can be bonded. */
 	uint32_t tunnel_enabled:1; /* If tunnel offloading is enabled on rxqs. */
 	uint32_t unified_fdb_en:1; /* Unified FDB flag per port. */
+	uint32_t jump_fdb_rx_en:1; /* Jump from FDB Tx to FDB Rx flag per port. */
 	uint16_t domain_id; /* Switch domain identifier. */
 	uint16_t vport_id; /* Associated VF vport index (if any). */
 	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 983af38c96..8909f5b506 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9350,6 +9350,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 	struct mlx5_flow_group *grp_data;
 	struct mlx5dr_table *tbl = NULL;
 	struct mlx5dr_action *jump;
+	uint32_t hws_flags;
 	uint32_t idx = 0;
 	MKSTR(matcher_name, "%s_%s_%u_%u_matcher_list",
 	      attr->transfer ? "FDB" : "NIC", attr->egress ? "egress" : "ingress",
@@ -9370,10 +9371,15 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 		goto error;
 	grp_data->tbl = tbl;
 	if (attr->group) {
+		hws_flags = mlx5_hw_act_dest_table_flag[dr_tbl_attr.type];
+		/* For case of jump from FDB Tx to FDB Rx as it is supported now. */
+		if (priv->jump_fdb_rx_en &&
+		    dr_tbl_attr.type == MLX5DR_TABLE_TYPE_FDB_RX)
+			hws_flags |= MLX5DR_ACTION_FLAG_HWS_FDB_TX;
 		/* Jump action be used by non-root table. */
 		jump = mlx5dr_action_create_dest_table
 			(priv->dr_ctx, tbl,
-			 mlx5_hw_act_dest_table_flag[dr_tbl_attr.type]);
+			 hws_flags);
 		if (!jump)
 			goto error;
 		grp_data->jump.hws_action = jump;
-- 
2.39.5

