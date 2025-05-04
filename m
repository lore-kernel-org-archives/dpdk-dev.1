Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E62BC369DC
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 May 2025 05:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B03704025D;
	Sun,  4 May 2025 07:24:32 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by mails.dpdk.org (Postfix) with ESMTP id 57E5840156
 for <dev@dpdk.org>; Sun,  4 May 2025 07:24:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJUtdr6m6VnIQOu0uplnwlC7GSDTkrb4E00Ty+SYmYHyMbBHHvpiDhZCrbEnpc2NwhFOmexHfCwgVpaT/WI83/kWfzNpUy+otruEpMSLO4YdoYbaOpkgiQftN2WPqPUbgy4lrfIb91pJFg/rn8+GEtdUb1PK7YNm/UEJDezXABrnJsoTcpuywq1zrG33VDm8STNcDpZuZpuGa+ZWixPMmxBAynBiWyDyE1fLxpRrcVBCrVacSW1MF8dIEFA+wVmexj/sAqw0kYh5XquXiSGeRLXzLhvWRit1hkhUN4+teiDSKvYSi0y5W9rRApyY8Zj/XSWmHlB8dUwTEOUvpQFcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlN3HtX0tbPKmyCyAXt4Sk4kGcGuTaSGt8OxRhL8Big=;
 b=D+n2Pn+nSqXzEcfAKosYemfMfUjIdid3rgC16eeJCeT5xWWelTxl4hWmDRUwnZZWQPGC3z0gb/IuoFTcg4Nl4wTOfj1TvfMkiuksh+I6zapIw8FHniY/VTJv06nM7Sp6M1kGzXoLQXNhOQu56fy/WfPn96srD9N7pxmh7ksFiYsbhZ7AmjZcu9fRIkFSXDWX+skI1DF7FF+urIButtM6Z8XDxabVSgyEO62JsFfrjntGHkBWSRC/tvhediuVyLxgUBSWzq8N4WixcQz174glAg6AgH/43q5A2yz0wLsg7Qy5U8GvIxzvF/ID2YBUxoBWhEgtHIClWsO4zSQj3YxG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlN3HtX0tbPKmyCyAXt4Sk4kGcGuTaSGt8OxRhL8Big=;
 b=UEqm/UxZhRtqqmQtwywxzoQk2Shm7xg4c6eoWMTMh/LOFk6NQldJ7UONOkcKtYs2gSMIYjn/PVC5YJEUE8OEovIXcKiw0z/vdp/iJS4j1pK2lpPK9dOo4Lwy40sVj2gFvEgpwenBNfNaqkbUuoH53+ugqX4kMiTVZiapRVykR5Fr3U6W11FZLDlXgSriU0um9yNjBa37MaaJLZnbiMmE+MKV5a5Fin9YSXInZfnn2rznSuTebup1ToTJWAEJrTIVCyqj3lEaVaEIplpDkl1VBZglOrHtqG3SB20Gcp+dHIq0aaH+2eKSf70wCWy0duAvjcqGVaCTsa60UPfj2izvpA==
Received: from SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::10)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Sun, 4 May
 2025 05:24:21 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::b1) by SA1P222CA0035.outlook.office365.com
 (2603:10b6:806:2d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Sun,
 4 May 2025 05:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Sun, 4 May 2025 05:24:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 3 May 2025
 22:24:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 3 May
 2025 22:24:10 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 3 May
 2025 22:24:05 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [PATCH] net/mlx5: fix support for meter flow action in HWS
Date: Sun, 4 May 2025 08:23:50 +0300
Message-ID: <20250504052350.91160-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0fd54f-0468-4959-481b-08dd8acbeccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TgwanHBzLOrYMrC3pDFsodkeNlFXuT5FKr9uXslmo45f62z9enoeJSNjhNWd?=
 =?us-ascii?Q?BfJeW7gZqLUHwdM9vc1q1MLMm6N1smizShm+FHSjrBrgLMjwRLQQ2Go5DKtc?=
 =?us-ascii?Q?IOSGjKxucZlgAq0Bd8RTbZPrz5lIBUYaWcr+rHmBlzgJFsugGcpVCppjkHGx?=
 =?us-ascii?Q?caA6+IZMvP2bKHdELmtY8LoADG39mEE9/nlWKnk1bI/Ldoy/OFn22+pyHgVn?=
 =?us-ascii?Q?Eo3DZ2uvs2dBc0f8oI3e4JzLtd727sPBP3R92uQh674o4aKZbdc36D8ecXa+?=
 =?us-ascii?Q?+jJxiEAApTgFuU1RJMBtG4OLTlRQTnAe1KPcva1MpXBBHDSthbTftIaSA8d2?=
 =?us-ascii?Q?+zVJ+cOBzA9xIvc+dURZMvJUNqG1FGdyVmpZj4/fU8g4kCTtuNCW89/4PiqK?=
 =?us-ascii?Q?X+dkNOG54RnNf2CrvRpvnF2DtBww8qM1U9+XKWEoTLxl91xfFYr4X49mpOAM?=
 =?us-ascii?Q?mJGRKo5ZJJot9zGYFhsFcTfEKsUgepdXUhxJslr/F3mf494VoE3CiorOX2Sc?=
 =?us-ascii?Q?VjoboTAxcMTnWC8syOvT55jYln9m2i95xETZyyDcrSRHFZzdncn7/ueqYSm0?=
 =?us-ascii?Q?TD5UTrf0Z78pXSC1GtjgXhFHBXGOslgrlLCaHvs5j9MCv/No2zi7xalg1ctR?=
 =?us-ascii?Q?6CTaRc+/raycix5hP7EQhLhwrkBt4tDJHzbm6xzJ0oxmS3RSn4HE2ee0H6Rj?=
 =?us-ascii?Q?rFZmleru/gMX4VPSPFytKJIInXHJN98f0rWDv0XtLqXdDXL5XLG+GLP9202H?=
 =?us-ascii?Q?7CTdY4GpD5eyayCildZ6C1h6PehO9wQywWAs+NMZjHyWJJPxN3QR+O0p6lvH?=
 =?us-ascii?Q?7V4pkt6NIvTru/P7Sk2/p4APKYu7cTj60fQA9m5TfzRCWDv/Udd02HiOP3Wl?=
 =?us-ascii?Q?RAXGGqsbU7tu4BBZHrwvq9vvuI1QeNMqIBKXE4l6+hwQlpPyeSLNOlu42gdb?=
 =?us-ascii?Q?7yB8lhD+R20Gx9fFQUFFdpfMMuDl0B2CLBScCsfKPQteV8JX0NOBeNPA/uNN?=
 =?us-ascii?Q?jVTqyuKx3NqP8rVLdjlEusnHshZlLo24FRtAK9pWux0AuRUdJmJ3RJtcAtqp?=
 =?us-ascii?Q?k888yZjzLBv/GuIsgkqxqMpxttCzRHWvXXEw1CHA6XTjBHhdShA87NFWmvNc?=
 =?us-ascii?Q?kh8544m7e7HodTINk0LJjTLyl+/dAF5AvdnPfNbcWGyM+a4lXg+CeU6tlUlc?=
 =?us-ascii?Q?896zoray8A+fVgOwIWSjFaMGpsQ/G/VwWv0btTHsll8qrt6RrNx/BUSMujiV?=
 =?us-ascii?Q?Bx1oTLrS0Jz4omCgJNH1/Y4vlubKTc9PkQ6FvSnWNNavVNeR2ZCGQ6SXEsBL?=
 =?us-ascii?Q?GpOnan1YVnIeti2g9FemEBoK9g2bYnF6gXsXVqE6JNdG/EwkQ1uHgDFLJyBw?=
 =?us-ascii?Q?A4yk4Fv0RN+yiH/C8fI63t3gwMjQlNeqM84v9jU2rtU1YHqKcS0wtInYvI+B?=
 =?us-ascii?Q?usBzbj2XA9xwunBlM4gR+8lkn28FLgjtWUq4eBXqR4Hat+0vGEgKZah7q0Td?=
 =?us-ascii?Q?5/VfyD3aijEjYA/JgtEM+Kr+GQ3b8it/ooBL?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 05:24:21.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0fd54f-0468-4959-481b-08dd8acbeccf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

METER flow action is not supported in MLX5 HWS mode.
Application must use METER_MARK flow action.

The patch removes METER action from HWS code.

Fixes: 48fbb0e93d06 ("net/mlx5: support flow meter mark indirect action with HWS")
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c    |  85 -----
 drivers/net/mlx5/mlx5_flow_meter.c | 552 -----------------------------
 2 files changed, 637 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce414..1f192c1937 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1784,35 +1784,6 @@ flow_hw_represented_port_compile(struct rte_eth_dev *dev,
 	return 0;
 }
 
-static __rte_always_inline int
-flow_hw_meter_compile(struct rte_eth_dev *dev,
-		      const struct mlx5_flow_template_table_cfg *cfg,
-		      uint16_t aso_mtr_pos,
-		      uint16_t jump_pos,
-		      const struct rte_flow_action *action,
-		      struct mlx5_hw_actions *acts,
-		      struct rte_flow_error *error)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_aso_mtr *aso_mtr;
-	const struct rte_flow_action_meter *meter = action->conf;
-	uint32_t group = cfg->attr.flow_attr.group;
-
-	aso_mtr = mlx5_aso_meter_by_idx(priv, meter->mtr_id);
-	acts->rule_acts[aso_mtr_pos].action = priv->mtr_bulk.action;
-	acts->rule_acts[aso_mtr_pos].aso_meter.offset = aso_mtr->offset;
-	acts->jump = flow_hw_jump_action_register
-		(dev, cfg, aso_mtr->fm.group, error);
-	if (!acts->jump)
-		return -ENOMEM;
-	acts->rule_acts[jump_pos].action = (!!group) ?
-				    acts->jump->hws_action :
-				    acts->jump->root_action;
-	if (mlx5_aso_mtr_wait(priv, aso_mtr, true))
-		return -ENOMEM;
-	return 0;
-}
-
 static __rte_always_inline int
 flow_hw_cnt_compile(struct rte_eth_dev *dev, uint32_t  start_pos,
 		      struct mlx5_hw_actions *acts)
@@ -2534,7 +2505,6 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	bool reformat_used = false;
 	bool recom_used = false;
 	unsigned int of_vlan_offset;
-	uint16_t jump_pos;
 	uint32_t ct_idx;
 	int ret, err;
 	uint32_t target_grp = 0;
@@ -2802,27 +2772,6 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 					 masks, acts, src_pos, dr_pos, &sub_error))
 				goto err;
 			break;
-		case RTE_FLOW_ACTION_TYPE_METER:
-			/*
-			 * METER action is compiled to 2 DR actions - ASO_METER and FT.
-			 * Calculated DR offset is stored only for ASO_METER and FT
-			 * is assumed to be the next action.
-			 */
-			jump_pos = dr_pos + 1;
-			if (actions->conf && masks->conf &&
-			    ((const struct rte_flow_action_meter *)
-			     masks->conf)->mtr_id) {
-				err = flow_hw_meter_compile(dev, cfg,
-							    dr_pos, jump_pos, actions, acts,
-							    &sub_error);
-				if (err)
-					goto err;
-			} else if (__flow_hw_act_data_general_append(priv, acts,
-								     actions->type,
-								     src_pos,
-								     dr_pos))
-				goto err;
-			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
 			ret = flow_hw_translate_group(dev, cfg, attr->group,
 						&target_grp, &sub_error);
@@ -3510,7 +3459,6 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 	const struct rte_flow_action_ipv6_ext_push *ipv6_push;
 	const struct rte_flow_item *enc_item = NULL;
 	const struct rte_flow_action_ethdev *port_action = NULL;
-	const struct rte_flow_action_meter *meter = NULL;
 	const struct rte_flow_action_age *age = NULL;
 	const struct rte_flow_action_nat64 *nat64_c = NULL;
 	struct rte_flow_attr attr = {
@@ -3683,28 +3631,6 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 						rule_acts + act_data->action_dst,
 						act_data->shared_meter.id);
 			break;
-		case RTE_FLOW_ACTION_TYPE_METER:
-			meter = action->conf;
-			mtr_id = meter->mtr_id;
-			aso_mtr = mlx5_aso_meter_by_idx(priv, mtr_id);
-			rule_acts[act_data->action_dst].action =
-				priv->mtr_bulk.action;
-			rule_acts[act_data->action_dst].aso_meter.offset =
-								aso_mtr->offset;
-			jump = flow_hw_jump_action_register
-				(dev, &table->cfg, aso_mtr->fm.group, NULL);
-			if (!jump)
-				goto error;
-			MLX5_ASSERT
-				(!rule_acts[act_data->action_dst + 1].action);
-			rule_acts[act_data->action_dst + 1].action =
-					(!!attr.group) ? jump->hws_action :
-							 jump->root_action;
-			flow->jump = jump;
-			flow->flags |= MLX5_FLOW_HW_FLOW_FLAG_FATE_JUMP;
-			if (mlx5_aso_mtr_wait(priv, aso_mtr, true))
-				goto error;
-			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
 			aux = mlx5_flow_hw_aux(dev->data->port_id, flow);
 			age = action->conf;
@@ -7334,10 +7260,6 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 			}
 			action_flags |= MLX5_FLOW_ACTION_IPV6_ROUTING_REMOVE;
 			break;
-		case RTE_FLOW_ACTION_TYPE_METER:
-			/* TODO: Validation logic */
-			action_flags |= MLX5_FLOW_ACTION_METER;
-			break;
 		case RTE_FLOW_ACTION_TYPE_METER_MARK:
 			ret = flow_hw_validate_action_meter_mark(dev, action, false, error);
 			if (ret < 0)
@@ -7665,13 +7587,6 @@ flow_hw_parse_flow_actions_to_dr_actions(struct rte_eth_dev *dev,
 				action_types[mhdr_off] = type;
 			}
 			break;
-		case RTE_FLOW_ACTION_TYPE_METER:
-			at->dr_off[i] = curr_off;
-			action_types[curr_off++] = MLX5DR_ACTION_TYP_ASO_METER;
-			if (curr_off >= MLX5_HW_MAX_ACTS)
-				goto err_actions_num;
-			action_types[curr_off++] = MLX5DR_ACTION_TYP_TBL;
-			break;
 		case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
 			type = mlx5_hw_dr_action_types[at->actions[i].type];
 			at->dr_off[i] = curr_off;
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index dab3c4bf77..cd6a804593 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -1166,49 +1166,6 @@ mlx5_flow_meter_policy_validate(struct rte_eth_dev *dev,
 	return 0;
 }
 
-#if defined(HAVE_MLX5_HWS_SUPPORT)
-/**
- * Callback to check MTR policy action validate for HWS
- *
- * @param[in] dev
- *   Pointer to Ethernet device.
- * @param[in] actions
- *   Pointer to meter policy action detail.
- * @param[out] error
- *   Pointer to the error structure.
- *
- * @return
- *   0 on success, a negative errno value otherwise and rte_errno is set.
- */
-static int
-mlx5_flow_meter_policy_hws_validate(struct rte_eth_dev *dev,
-	struct rte_mtr_meter_policy_params *policy,
-	struct rte_mtr_error *error)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	const struct rte_flow_actions_template_attr attr = {
-		.transfer = priv->sh->config.dv_esw_en ? 1 : 0 };
-	int ret;
-	int i;
-
-	if (mlx5_hws_active(dev) && !mlx5_hw_ctx_validate(dev, NULL))
-		return -rte_mtr_error_set(error, EINVAL,
-					  RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
-					  "non-template flow engine was not configured");
-	if (!priv->mtr_en || !priv->sh->meter_aso_en)
-		return -rte_mtr_error_set(error, ENOTSUP,
-				RTE_MTR_ERROR_TYPE_METER_POLICY,
-				NULL, "meter policy unsupported.");
-	for (i = 0; i < RTE_COLORS; i++) {
-		ret = mlx5_flow_actions_validate(dev, &attr, policy->actions[i],
-						 policy->actions[i], NULL);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-#endif
-
 static int
 __mlx5_flow_meter_policy_delete(struct rte_eth_dev *dev,
 			uint32_t policy_id,
@@ -1540,334 +1497,6 @@ mlx5_flow_meter_policy_get(struct rte_eth_dev *dev,
 							      &policy_idx);
 }
 
-#if defined(HAVE_MLX5_HWS_SUPPORT)
-/**
- * Callback to delete MTR policy for HWS.
- *
- * @param[in] dev
- *   Pointer to Ethernet device.
- * @param[in] policy_id
- *   Meter policy id.
- * @param[out] error
- *   Pointer to the error structure.
- *
- * @return
- *   0 on success, a negative errno value otherwise and rte_errno is set.
- */
-static int
-mlx5_flow_meter_policy_hws_delete(struct rte_eth_dev *dev,
-			  uint32_t policy_id,
-			  struct rte_mtr_error *error)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_flow_meter_policy *mtr_policy;
-	uint32_t i, j;
-	uint32_t nb_flows = 0;
-	int ret;
-	struct rte_flow_op_attr op_attr = { .postpone = 1 };
-	struct rte_flow_op_result result[RTE_COLORS * MLX5_MTR_DOMAIN_MAX];
-
-	if (!priv->mtr_policy_arr)
-		return mlx5_flow_meter_policy_delete(dev, policy_id, error);
-	/* Meter policy must exist. */
-	mtr_policy = mlx5_flow_meter_policy_find(dev, policy_id, NULL);
-	if (!mtr_policy->initialized)
-		return -rte_mtr_error_set(error, ENOENT,
-			RTE_MTR_ERROR_TYPE_METER_POLICY_ID, NULL,
-			"Meter policy does not exists.");
-	/* Check policy is unused. */
-	if (mtr_policy->ref_cnt)
-		return -rte_mtr_error_set(error, EBUSY,
-					  RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
-					  NULL, "Meter policy is in use.");
-	rte_spinlock_lock(&priv->hw_ctrl_lock);
-	for (i = 0; i < MLX5_MTR_DOMAIN_MAX; i++) {
-		for (j = 0; j < RTE_COLORS; j++) {
-			if (mtr_policy->hws_flow_rule[i][j]) {
-				ret = rte_flow_async_destroy(dev->data->port_id,
-					CTRL_QUEUE_ID(priv), &op_attr,
-					mtr_policy->hws_flow_rule[i][j],
-					NULL, NULL);
-				if (ret < 0)
-					continue;
-				nb_flows++;
-			}
-		}
-	}
-	ret = rte_flow_push(dev->data->port_id, CTRL_QUEUE_ID(priv), NULL);
-	while (nb_flows && (ret >= 0)) {
-		ret = rte_flow_pull(dev->data->port_id,
-					CTRL_QUEUE_ID(priv), result,
-					nb_flows, NULL);
-		nb_flows -= ret;
-	}
-	for (i = 0; i < MLX5_MTR_DOMAIN_MAX; i++) {
-		if (mtr_policy->hws_flow_table[i])
-			rte_flow_template_table_destroy(dev->data->port_id,
-				 mtr_policy->hws_flow_table[i], NULL);
-	}
-	for (i = 0; i < RTE_COLORS; i++) {
-		if (mtr_policy->hws_act_templ[i])
-			rte_flow_actions_template_destroy(dev->data->port_id,
-				 mtr_policy->hws_act_templ[i], NULL);
-	}
-	if (mtr_policy->hws_item_templ)
-		rte_flow_pattern_template_destroy(dev->data->port_id,
-				mtr_policy->hws_item_templ, NULL);
-	rte_spinlock_unlock(&priv->hw_ctrl_lock);
-	memset(mtr_policy, 0, sizeof(struct mlx5_flow_meter_policy));
-	return 0;
-}
-
-/**
- * Callback to add MTR policy for HWS.
- *
- * @param[in] dev
- *   Pointer to Ethernet device.
- * @param[out] policy_id
- *   Pointer to policy id
- * @param[in] actions
- *   Pointer to meter policy action detail.
- * @param[out] error
- *   Pointer to the error structure.
- *
- * @return
- *   0 on success, a negative errno value otherwise and rte_errno is set.
- */
-static int
-mlx5_flow_meter_policy_hws_add(struct rte_eth_dev *dev,
-			uint32_t policy_id,
-			struct rte_mtr_meter_policy_params *policy,
-			struct rte_mtr_error *error)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_flow_meter_policy *mtr_policy = NULL;
-	const struct rte_flow_action *act;
-	const struct rte_flow_action_meter *mtr;
-	struct mlx5_flow_meter_info *fm;
-	struct mlx5_flow_meter_policy *plc;
-	uint8_t domain_color = MLX5_MTR_ALL_DOMAIN_BIT;
-	bool is_rss = false;
-	bool is_hierarchy = false;
-	int i, j;
-	uint32_t nb_colors = 0;
-	uint32_t nb_flows = 0;
-	int color;
-	int ret;
-	struct rte_flow_pattern_template_attr pta = {0};
-	struct rte_flow_actions_template_attr ata = {0};
-	struct rte_flow_template_table_attr ta = { {0}, 0 };
-	struct rte_flow_op_attr op_attr = { .postpone = 1 };
-	struct rte_flow_op_result result[RTE_COLORS * MLX5_MTR_DOMAIN_MAX];
-	const uint32_t color_mask = (UINT32_C(1) << MLX5_MTR_COLOR_BITS) - 1;
-	int color_reg_c_idx = mlx5_flow_get_reg_id(dev, MLX5_MTR_COLOR,
-						   0, NULL);
-	struct rte_flow_item_tag tag_spec = {
-		.data = 0,
-		.index = color_reg_c_idx
-	};
-	struct rte_flow_item_tag tag_mask = {
-		.data = color_mask,
-		.index = 0xff};
-	struct rte_flow_item pattern[] = {
-		[0] = {
-			.type = (enum rte_flow_item_type)
-				MLX5_RTE_FLOW_ITEM_TYPE_TAG,
-			.spec = &tag_spec,
-			.mask = &tag_mask,
-		},
-		[1] = { .type = RTE_FLOW_ITEM_TYPE_END }
-	};
-
-	if (mlx5_hws_active(dev) && !mlx5_hw_ctx_validate(dev, NULL))
-		return -rte_mtr_error_set(error, EINVAL,
-					  RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
-					  "non-template flow engine was not configured");
-	if (!priv->mtr_policy_arr)
-		return mlx5_flow_meter_policy_add(dev, policy_id, policy, error);
-	mtr_policy = mlx5_flow_meter_policy_find(dev, policy_id, NULL);
-	if (mtr_policy->initialized)
-		return -rte_mtr_error_set(error, EEXIST,
-			RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
-			NULL, "Meter policy already exists.");
-	if (!policy ||
-	    (!policy->actions[RTE_COLOR_RED] &&
-	    !policy->actions[RTE_COLOR_YELLOW] &&
-	    !policy->actions[RTE_COLOR_GREEN]))
-		return -rte_mtr_error_set(error, EINVAL,
-					  RTE_MTR_ERROR_TYPE_METER_POLICY,
-					  NULL, "Meter policy actions are not valid.");
-	if (policy->actions[RTE_COLOR_RED] == RTE_FLOW_ACTION_TYPE_END)
-		mtr_policy->skip_r = 1;
-	if (policy->actions[RTE_COLOR_YELLOW] == RTE_FLOW_ACTION_TYPE_END)
-		mtr_policy->skip_y = 1;
-	if (policy->actions[RTE_COLOR_GREEN] == RTE_FLOW_ACTION_TYPE_END)
-		mtr_policy->skip_g = 1;
-	if (mtr_policy->skip_r && mtr_policy->skip_y && mtr_policy->skip_g)
-		return -rte_mtr_error_set(error, ENOTSUP,
-					  RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
-					  NULL, "Meter policy actions are empty.");
-	for (i = 0; i < RTE_COLORS; i++) {
-		act = policy->actions[i];
-		while (act && act->type != RTE_FLOW_ACTION_TYPE_END) {
-			switch (act->type) {
-			case RTE_FLOW_ACTION_TYPE_PORT_ID:
-				/* fall-through. */
-			case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-				domain_color &= ~(MLX5_MTR_DOMAIN_INGRESS_BIT |
-						  MLX5_MTR_DOMAIN_EGRESS_BIT);
-				break;
-			case RTE_FLOW_ACTION_TYPE_RSS:
-				is_rss = true;
-				/* fall-through. */
-			case RTE_FLOW_ACTION_TYPE_QUEUE:
-				domain_color &= ~(MLX5_MTR_DOMAIN_EGRESS_BIT |
-						  MLX5_MTR_DOMAIN_TRANSFER_BIT);
-				break;
-			case RTE_FLOW_ACTION_TYPE_METER:
-				is_hierarchy = true;
-				mtr = act->conf;
-				fm = mlx5_flow_meter_find(priv,
-							  mtr->mtr_id, NULL);
-				if (!fm)
-					return -rte_mtr_error_set(error, EINVAL,
-						RTE_MTR_ERROR_TYPE_MTR_ID, NULL,
-						"Meter not found in meter hierarchy.");
-				plc = mlx5_flow_meter_policy_find(dev,
-								  fm->policy_id,
-								  NULL);
-				MLX5_ASSERT(plc);
-				domain_color &= MLX5_MTR_ALL_DOMAIN_BIT &
-					(plc->ingress <<
-					 MLX5_MTR_DOMAIN_INGRESS);
-				domain_color &= MLX5_MTR_ALL_DOMAIN_BIT &
-					(plc->egress <<
-					 MLX5_MTR_DOMAIN_EGRESS);
-				domain_color &= MLX5_MTR_ALL_DOMAIN_BIT &
-					(plc->transfer <<
-					 MLX5_MTR_DOMAIN_TRANSFER);
-				break;
-			default:
-				break;
-			}
-			act++;
-		}
-	}
-	if (priv->sh->config.dv_esw_en)
-		domain_color &= ~(MLX5_MTR_DOMAIN_EGRESS_BIT |
-				  MLX5_MTR_DOMAIN_TRANSFER_BIT);
-	else
-		domain_color &= ~MLX5_MTR_DOMAIN_TRANSFER_BIT;
-	if (!domain_color)
-		return -rte_mtr_error_set(error, ENOTSUP,
-					  RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
-					  NULL, "Meter policy domains are conflicting.");
-	mtr_policy->is_rss = is_rss;
-	mtr_policy->ingress = !!(domain_color & MLX5_MTR_DOMAIN_INGRESS_BIT);
-	pta.ingress = mtr_policy->ingress;
-	mtr_policy->egress = !!(domain_color & MLX5_MTR_DOMAIN_EGRESS_BIT);
-	pta.egress = mtr_policy->egress;
-	mtr_policy->transfer = !!(domain_color & MLX5_MTR_DOMAIN_TRANSFER_BIT);
-	pta.transfer = mtr_policy->transfer;
-	mtr_policy->group = MLX5_FLOW_TABLE_HWS_POLICY - policy_id;
-	mtr_policy->is_hierarchy = is_hierarchy;
-	mtr_policy->initialized = 1;
-	rte_spinlock_lock(&priv->hw_ctrl_lock);
-	mtr_policy->hws_item_templ =
-		rte_flow_pattern_template_create(dev->data->port_id,
-						 &pta, pattern, NULL);
-	if (!mtr_policy->hws_item_templ)
-		goto policy_add_err;
-	for (i = 0; i < RTE_COLORS; i++) {
-		if (mtr_policy->skip_g && i == RTE_COLOR_GREEN)
-			continue;
-		if (mtr_policy->skip_y && i == RTE_COLOR_YELLOW)
-			continue;
-		if (mtr_policy->skip_r && i == RTE_COLOR_RED)
-			continue;
-		mtr_policy->hws_act_templ[nb_colors] =
-			rte_flow_actions_template_create(dev->data->port_id,
-						&ata, policy->actions[i],
-						policy->actions[i], NULL);
-		if (!mtr_policy->hws_act_templ[nb_colors])
-			goto policy_add_err;
-		nb_colors++;
-	}
-	for (i = 0; i < MLX5_MTR_DOMAIN_MAX; i++) {
-		memset(&ta, 0, sizeof(ta));
-		ta.nb_flows = RTE_COLORS;
-		ta.flow_attr.group = mtr_policy->group;
-		if (i == MLX5_MTR_DOMAIN_INGRESS) {
-			if (!mtr_policy->ingress)
-				continue;
-			ta.flow_attr.ingress = 1;
-		} else if (i == MLX5_MTR_DOMAIN_EGRESS) {
-			if (!mtr_policy->egress)
-				continue;
-			ta.flow_attr.egress = 1;
-		} else if (i == MLX5_MTR_DOMAIN_TRANSFER) {
-			if (!mtr_policy->transfer)
-				continue;
-			ta.flow_attr.transfer = 1;
-		}
-		mtr_policy->hws_flow_table[i] =
-			rte_flow_template_table_create(dev->data->port_id,
-					&ta, &mtr_policy->hws_item_templ, 1,
-					mtr_policy->hws_act_templ, nb_colors,
-					NULL);
-		if (!mtr_policy->hws_flow_table[i])
-			goto policy_add_err;
-		nb_colors = 0;
-		for (j = 0; j < RTE_COLORS; j++) {
-			if (mtr_policy->skip_g && j == RTE_COLOR_GREEN)
-				continue;
-			if (mtr_policy->skip_y && j == RTE_COLOR_YELLOW)
-				continue;
-			if (mtr_policy->skip_r && j == RTE_COLOR_RED)
-				continue;
-			color = rte_col_2_mlx5_col((enum rte_color)j);
-			tag_spec.data = color;
-			mtr_policy->hws_flow_rule[i][j] =
-				rte_flow_async_create(dev->data->port_id,
-					CTRL_QUEUE_ID(priv), &op_attr,
-					mtr_policy->hws_flow_table[i],
-					pattern, 0, policy->actions[j],
-					nb_colors, NULL, NULL);
-			if (!mtr_policy->hws_flow_rule[i][j])
-				goto policy_add_err;
-			nb_colors++;
-			nb_flows++;
-		}
-		ret = rte_flow_push(dev->data->port_id,
-				    CTRL_QUEUE_ID(priv), NULL);
-		if (ret < 0)
-			goto policy_add_err;
-		while (nb_flows) {
-			ret = rte_flow_pull(dev->data->port_id,
-					    CTRL_QUEUE_ID(priv), result,
-					    nb_flows, NULL);
-			if (ret < 0)
-				goto policy_add_err;
-			for (j = 0; j < ret; j++) {
-				if (result[j].status == RTE_FLOW_OP_ERROR)
-					goto policy_add_err;
-			}
-			nb_flows -= ret;
-		}
-	}
-	rte_spinlock_unlock(&priv->hw_ctrl_lock);
-	return 0;
-policy_add_err:
-	rte_spinlock_unlock(&priv->hw_ctrl_lock);
-	ret = mlx5_flow_meter_policy_hws_delete(dev, policy_id, error);
-	memset(mtr_policy, 0, sizeof(struct mlx5_flow_meter_policy));
-	if (ret)
-		return ret;
-	return -rte_mtr_error_set(error, ENOTSUP,
-				  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
-				  NULL, "Failed to create meter policy.");
-}
-#endif
 /**
  * Check meter validation.
  *
@@ -2239,105 +1868,6 @@ mlx5_flow_meter_create(struct rte_eth_dev *dev, uint32_t meter_id,
 		NULL, "Failed to create devx meter.");
 }
 
-#if defined(HAVE_MLX5_HWS_SUPPORT)
-/**
- * Create meter rules.
- *
- * @param[in] dev
- *   Pointer to Ethernet device.
- * @param[in] meter_id
- *   Meter id.
- * @param[in] params
- *   Pointer to rte meter parameters.
- * @param[in] shared
- *   Meter shared with other flow or not.
- * @param[out] error
- *   Pointer to rte meter error structure.
- *
- * @return
- *   0 on success, a negative errno value otherwise and rte_errno is set.
- */
-static int
-mlx5_flow_meter_hws_create(struct rte_eth_dev *dev, uint32_t meter_id,
-		       struct rte_mtr_params *params, int shared,
-		       struct rte_mtr_error *error)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_flow_meter_profile *profile;
-	struct mlx5_flow_meter_info *fm;
-	struct mlx5_flow_meter_policy *policy = NULL;
-	struct mlx5_aso_mtr *aso_mtr;
-	struct mlx5_hw_q_job *job;
-	int ret;
-
-	if (mlx5_hws_active(dev) && !mlx5_hw_ctx_validate(dev, NULL))
-		return -rte_mtr_error_set(error, EINVAL,
-					  RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
-					  "non-template flow engine was not configured");
-	if (!priv->mtr_profile_arr ||
-	    !priv->mtr_policy_arr ||
-	    !priv->mtr_bulk.aso)
-		return -rte_mtr_error_set(error, ENOTSUP,
-			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
-			"Meter bulk array is not allocated.");
-	/* Meter profile must exist. */
-	profile = mlx5_flow_meter_profile_find(priv, params->meter_profile_id);
-	if (!profile->initialized)
-		return -rte_mtr_error_set(error, ENOENT,
-			RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
-			NULL, "Meter profile id not valid.");
-	/* Meter policy must exist. */
-	policy = mlx5_flow_meter_policy_find(dev,
-			params->meter_policy_id, NULL);
-	if (!policy->initialized)
-		return -rte_mtr_error_set(error, ENOENT,
-			RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
-			NULL, "Meter policy id not valid.");
-	/* Meter ID must be valid. */
-	if (meter_id >= priv->mtr_config.nb_meters)
-		return -rte_mtr_error_set(error, EINVAL,
-			RTE_MTR_ERROR_TYPE_MTR_ID,
-			NULL, "Meter id not valid.");
-	/* Find ASO object. */
-	aso_mtr = mlx5_aso_meter_by_idx(priv, meter_id);
-	fm = &aso_mtr->fm;
-	if (fm->initialized)
-		return -rte_mtr_error_set(error, ENOENT,
-					  RTE_MTR_ERROR_TYPE_MTR_ID,
-					  NULL, "Meter object already exists.");
-	/* Fill the flow meter parameters. */
-	fm->meter_id = meter_id;
-	fm->policy_id = params->meter_policy_id;
-	fm->profile = profile;
-	fm->meter_offset = meter_id;
-	fm->group = policy->group;
-	/* Add to the flow meter list. */
-	fm->active_state = 1; /* Config meter starts as active. */
-	fm->is_enable = params->meter_enable;
-	fm->shared = !!shared;
-	fm->initialized = 1;
-	/* Update ASO flow meter by wqe. */
-	job = mlx5_flow_action_job_init(priv, MLX5_HW_INV_QUEUE, NULL, NULL,
-					NULL, MLX5_HW_Q_JOB_TYPE_CREATE, NULL);
-	if (!job)
-		return -rte_mtr_error_set(error, ENOMEM,
-					  RTE_MTR_ERROR_TYPE_MTR_ID,
-					  NULL, "No job context.");
-	ret = mlx5_aso_meter_update_by_wqe(priv, MLX5_HW_INV_QUEUE, aso_mtr,
-					   &priv->mtr_bulk, job, true);
-	if (ret) {
-		flow_hw_job_put(priv, job, CTRL_QUEUE_ID(priv));
-		return -rte_mtr_error_set(error, ENOTSUP,
-					  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
-					  NULL, "Failed to create devx meter.");
-	}
-	fm->active_state = params->meter_enable;
-	rte_atomic_fetch_add_explicit(&fm->profile->ref_cnt, 1, rte_memory_order_relaxed);
-	rte_atomic_fetch_add_explicit(&policy->ref_cnt, 1, rte_memory_order_relaxed);
-	return 0;
-}
-#endif
-
 static int
 mlx5_flow_meter_params_flush(struct rte_eth_dev *dev,
 			struct mlx5_flow_meter_info *fm,
@@ -2444,58 +1974,6 @@ mlx5_flow_meter_destroy(struct rte_eth_dev *dev, uint32_t meter_id,
 	return 0;
 }
 
-/**
- * Destroy meter rules.
- *
- * @param[in] dev
- *   Pointer to Ethernet device.
- * @param[in] meter_id
- *   Meter id.
- * @param[out] error
- *   Pointer to rte meter error structure.
- *
- * @return
- *   0 on success, a negative errno value otherwise and rte_errno is set.
- */
-static int
-mlx5_flow_meter_hws_destroy(struct rte_eth_dev *dev, uint32_t meter_id,
-			struct rte_mtr_error *error)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_aso_mtr *aso_mtr;
-	struct mlx5_flow_meter_info *fm;
-	struct mlx5_flow_meter_policy *policy;
-
-	if (!priv->mtr_profile_arr ||
-	    !priv->mtr_policy_arr ||
-	    !priv->mtr_bulk.aso)
-		return -rte_mtr_error_set(error, ENOTSUP,
-			RTE_MTR_ERROR_TYPE_METER_POLICY, NULL,
-			"Meter bulk array is not allocated.");
-	/* Find ASO object. */
-	aso_mtr = mlx5_aso_meter_by_idx(priv, meter_id);
-	fm = &aso_mtr->fm;
-	if (!fm->initialized)
-		return -rte_mtr_error_set(error, ENOENT,
-					  RTE_MTR_ERROR_TYPE_MTR_ID,
-					  NULL, "Meter object id not valid.");
-	/* Meter object must not have any owner. */
-	if (fm->ref_cnt > 0)
-		return -rte_mtr_error_set(error, EBUSY,
-					  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
-					  NULL, "Meter object is being used.");
-	/* Destroy the meter profile. */
-	rte_atomic_fetch_sub_explicit(&fm->profile->ref_cnt,
-						1, rte_memory_order_relaxed);
-	/* Destroy the meter policy. */
-	policy = mlx5_flow_meter_policy_find(dev,
-			fm->policy_id, NULL);
-	rte_atomic_fetch_sub_explicit(&policy->ref_cnt,
-						1, rte_memory_order_relaxed);
-	memset(fm, 0, sizeof(struct mlx5_flow_meter_info));
-	return 0;
-}
-
 /**
  * Modify meter state.
  *
@@ -2835,14 +2313,6 @@ static const struct rte_mtr_ops mlx5_flow_mtr_hws_ops = {
 	.meter_profile_add = mlx5_flow_meter_profile_hws_add,
 	.meter_profile_delete = mlx5_flow_meter_profile_hws_delete,
 	.meter_profile_get = mlx5_flow_meter_profile_get,
-	.meter_policy_validate = mlx5_flow_meter_policy_hws_validate,
-	.meter_policy_add = mlx5_flow_meter_policy_hws_add,
-	.meter_policy_delete = mlx5_flow_meter_policy_hws_delete,
-	.meter_policy_get = mlx5_flow_meter_policy_get,
-	.create = mlx5_flow_meter_hws_create,
-	.destroy = mlx5_flow_meter_hws_destroy,
-	.meter_enable = mlx5_flow_meter_enable,
-	.meter_disable = mlx5_flow_meter_disable,
 	.meter_profile_update = mlx5_flow_meter_profile_update,
 	.meter_dscp_table_update = NULL,
 	.stats_update = NULL,
@@ -3286,14 +2756,6 @@ mlx5_flow_meter_flush(struct rte_eth_dev *dev, struct rte_mtr_error *error)
 				NULL, "MTR object meter profile invalid.");
 		}
 	}
-	if (priv->mtr_bulk.aso) {
-		for (i = 0; i < priv->mtr_config.nb_meters; i++) {
-			aso_mtr = mlx5_aso_meter_by_idx(priv, i);
-			fm = &aso_mtr->fm;
-			if (fm->initialized)
-				mlx5_flow_meter_hws_destroy(dev, i, error);
-		}
-	}
 	if (priv->policy_idx_tbl) {
 		MLX5_L3T_FOREACH(priv->policy_idx_tbl, i, entry) {
 			policy_idx = *(uint32_t *)entry;
@@ -3319,20 +2781,6 @@ mlx5_flow_meter_flush(struct rte_eth_dev *dev, struct rte_mtr_error *error)
 		mlx5_l3t_destroy(priv->policy_idx_tbl);
 		priv->policy_idx_tbl = NULL;
 	}
-#if defined(HAVE_MLX5_HWS_SUPPORT)
-	if (priv->mtr_policy_arr) {
-		struct mlx5_flow_meter_policy *policy;
-
-		for (i = 0; i < priv->mtr_config.nb_meter_policies; i++) {
-			policy = mlx5_flow_meter_policy_find(dev, i,
-							     &policy_idx);
-			if (policy->initialized) {
-				mlx5_flow_meter_policy_hws_delete(dev, i,
-								  error);
-			}
-		}
-	}
-#endif
 	if (priv->mtr_profile_tbl) {
 		MLX5_L3T_FOREACH(priv->mtr_profile_tbl, i, entry) {
 			fmp = entry;
-- 
2.48.1

