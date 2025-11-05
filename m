Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8BCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33E3340A81;
	Wed,  5 Nov 2025 17:54:42 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7]) by mails.dpdk.org (Postfix) with ESMTP id E578F4021F;
 Wed,  5 Nov 2025 17:54:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnsC99NNcg7404A1RRuYn7jr1NSHGfH/9pRTojNfbnpdh8fYYs3gvssCsm1PMkwqa9UCgTrLvsy924JutUoFuibKkx0EFEo58vGCp+Fhd0SXKtyotAOCjCfel65JQpPPoE82z2uG21kjBhp6yQumzD2QTz7r53S4mCuC6ip3ZortdylhpO2qrDv0kCxjOCeaTGD6lTERtbX9W/pJQdy501sG8WslbfIgV6Atr8ET4zO1Jl0jn0q/dX3XgrS84MDJ0jl/KiT8JS6xXXPNTc/jRsotB979R+4u7971kIdsj/XQwOZKe3DYVr5k3pKkPwLJR7tUGT0x/T8XP25uj5WwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCv2HettNR9FDfL5ecvGNTjAbYA8D0QhGJJdP92eWks=;
 b=sMnUJmvovQhHx4QtEqeY0yYsT90F+dkvoh9+i5VKyf0fzUCo7xnGJNQ2KWwMmAdRbA3SbYt55GG4W+cCJESRjBriCKVzMGoPoxxi6lHATCX4D8ba5CySCnjyUbVD8mPG6qq9Kt3twHqNgAFU9/NKKjNZ4JzJ52vLQ6nX6UcQFlSpRgBxS+Q+THHEJkpYURphTVneC3xiu1NAJztIldfmNeJniwaRzyR5ssk9bVuvGOoWF24GUHgtCYbG/R/sYWsavnTnySNKRi/Y8xSHkQgTEsZlMfzrxuadwzvX/4dwxeGKFXiia2d6U9Jmcb7ewSqQZXpvzQmjv3OaIdxlIVgpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCv2HettNR9FDfL5ecvGNTjAbYA8D0QhGJJdP92eWks=;
 b=FgsqhU9uL/1mjvyS0JN4HiAvDv7PMuSirF5j4ZXvdEzPGTqwj0ZDk3gPtJ9EHPI7+4+NR9HxUl8KiS1zkF1IiKXbnh/OD6RJeJERJfDXcEE1DJn9iZJaYqnSGF6y2PU5RqcyvT2Ni27xLQT6EcMihOY/HlBaUOi/tSBhPunkCVhYBBcW2Ezkp2voLCIFp5Lmnevxy9O7XIAqHR5xjmgMEbmNl6H2wL5nJJaIBrSAXuoKcp087gTDRQVDZ0cwLMYa4aG1Gl8R/R4NP/F5JY9COq3K7TWWecDWFfpl16UaZJoW+2VJedD/u1/XCVMeEQHvMQ1Br9iGNxjNMtfMiAxYIw==
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:54:35 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::ce) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 16:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:54:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:13 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:10 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xiaoyu Min
 <jackmin@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2 1/5] net/mlx5: fix error reporting on masked indirect
 actions
Date: Wed, 5 Nov 2025 17:52:54 +0100
Message-ID: <20251105165258.1396352-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4627e4f4-049f-4de6-c9b8-08de1c8bffef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B6NBl0a3MzI4UJEjiPUig3EbxBAqao2TUqxp1W02Zvu/Hs5882IibA/ZEXKk?=
 =?us-ascii?Q?wvAXllU2DxNz6GIWDUVO9Mo2LXVQeRg7kw0jhxYLMRgkyyyvE5mOsQuJRxYW?=
 =?us-ascii?Q?yanB7jt9UCYoG/IytWCrQ3YQxAokpAyfZSWHza/oXQXBQOC179BfRpzkCREO?=
 =?us-ascii?Q?apFXRqvODLO7kn8frMMmBmBZF4RfQLBolK3w3whLvRpmTyyeVIs5NExhELcQ?=
 =?us-ascii?Q?Wx2Tq08jfViIjLweJ2m0Fp1rER5q+J9XaQqPSxKMElVuyb2cZSkQdYV4NSeu?=
 =?us-ascii?Q?MG6JjOmVcId+kmKL9+vyvRmCAUBK857g8S261AI17BBJPfFAZPz8J5uLlnIR?=
 =?us-ascii?Q?nIYvOqIOuQvv2chdBV7DSNRtzeTQEP4w71qQ8OBIyLtPyRtrQm/IgaP41HQG?=
 =?us-ascii?Q?dWIMW+pU0TJkQ2cnvs6n6CL1G06ifAqSwV1NrAsloLk1N8wVNkKs96VuBTtL?=
 =?us-ascii?Q?FYs8MvRpVLzcoYJwFFCcrz3dBy2yTHou/XmemAro1v5/vpFNHCgUia2nGrRz?=
 =?us-ascii?Q?eYIRbfgbnSfTrhKCl5xZGQ/5F+E2c7b5Pf+HbjeuqMT9waXzQNbMB0c+PMAx?=
 =?us-ascii?Q?W+6abE2w/v+cbjwg1Ev3bfUvEDPE55n3wnmFQFr+1efr3HVkXqKUsb3WA4de?=
 =?us-ascii?Q?jiyw8VXesO5kbWDRTDoOLxMjRQ6mPSKszmKbwnBJyHSxEVA+QngN7iR7N/aV?=
 =?us-ascii?Q?gIIODXUUGINw8ZSHgbJdF9m/yzk6qW46p8nMoONZugXAGBwE2PEIuwOKQhFH?=
 =?us-ascii?Q?ykDMILzgaQ4AjkdfYZlI2Qfqvj4wexR72JX/aH55Ip2WPOxRct5/Hf+7cDis?=
 =?us-ascii?Q?fsjgLng7eVgDqfD0lpy6Tr/QbBZ2DVkuJoNR7gif9RFqXbSVhZeNQ2oc8skh?=
 =?us-ascii?Q?jCDHUDBQmklGHPUbxlLyvjU2O+Ot1a8tdWC1ydRqiQkX1VcXznd/iZFYnBfN?=
 =?us-ascii?Q?5qGUkZA7y3zxDul1f0/9QzRlOwpndMWomvRaJ1jQABulI6EW9YyvhjRH2trH?=
 =?us-ascii?Q?S78gavo3gCU/uSjeiHo+IuiyyQ3QTgV3fY+9pwnRNImxJe6e99RYr/biza+y?=
 =?us-ascii?Q?A0foFWGx2rnad13wdwBZCDDkanYM/h20jBwYjjMHfjBfE80zgzftHmdTz1Md?=
 =?us-ascii?Q?YSypO4IZRDoouZD8CbVAMbDRUOPhSZz2FfpboHnxT0hkrGhiHcNtLDuRSwG2?=
 =?us-ascii?Q?uoitinHcmMNw8gD4AnECPn/rV5AyS+PS/yhMzJzly4WvWnJTenpXE5+SVTD5?=
 =?us-ascii?Q?fs3aTYDSodXcwxKogGeHV6RiQWIztaW8UEJipL87YME6K7F0YzhzOPBADOV9?=
 =?us-ascii?Q?/YpXq+RLCTU7dOOJ6/8fkTiAjuEdrSLF+5A3Q3gXobU+KF64EcI60e63g4Ml?=
 =?us-ascii?Q?YtybkBx/+MkB3llOv7YSFdo+js3Wq990gIPM9yHwSlR5VCVHJ4hkQZm9x8Oq?=
 =?us-ascii?Q?VdM9jWImBturrzgWg00w1G6pfGFBr/aIpdcorItCqqDdkWXlAWG+TlQ6Gv/5?=
 =?us-ascii?Q?HJwuvFHhCfQlOUigatQL4VLjyam1h/wEhvTlFl97+IMqQhJma6cr1dUVcfkM?=
 =?us-ascii?Q?Op2puKBrFqFjIMS51Bg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:54:35.1197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4627e4f4-049f-4de6-c9b8-08de1c8bffef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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

Whenever masked indirect actions in actions template were handled
by mlx5 PMD and user passed incorrect action configuration,
the specific errors were not returned through rte_flow_error struct.
Existing logs also used WARNING log level, which made debugging a bit
harder.

This patch fixes error reporting for masked indirect actions,
during flow actions translation done in HWS mode:

- Replace "return -1" with error reporting through rte_flow_error.
- Change log level from WARNING to ERR.
- Add more information to log messages (port index
  and action handle).

Fixes: 7ab3962d2d2b ("net/mlx5: add indirect HW steering action")
Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
Fixes: 463170a7c934 ("net/mlx5: support connection tracking with HWS")
Fixes: 48fbb0e93d06 ("net/mlx5: support flow meter mark indirect action with HWS")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 42 +++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index ff68483a40..19975280c9 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1321,7 +1321,8 @@ flow_hw_shared_action_translate(struct rte_eth_dev *dev,
 				const struct rte_flow_action *action,
 				struct mlx5_hw_actions *acts,
 				uint16_t action_src,
-				uint16_t action_dst)
+				uint16_t action_dst,
+				struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_shared_action_rss *shared_rss;
@@ -1338,8 +1339,10 @@ flow_hw_shared_action_translate(struct rte_eth_dev *dev,
 		    (priv, acts,
 		    (enum rte_flow_action_type)MLX5_RTE_FLOW_ACTION_TYPE_RSS,
 		    action_src, action_dst, idx, shared_rss)) {
-			DRV_LOG(WARNING, "Indirect RSS action index %d translate failed", act_idx);
-			return -1;
+			DRV_LOG(ERR, "port %u Indirect RSS action (handle %p) translate failed",
+				dev->data->port_id, action->conf);
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+						  action, "Indirect RSS action translate failed");
 		}
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_COUNT:
@@ -1347,15 +1350,22 @@ flow_hw_shared_action_translate(struct rte_eth_dev *dev,
 			(enum rte_flow_action_type)
 			MLX5_RTE_FLOW_ACTION_TYPE_COUNT,
 			action_src, action_dst, act_idx)) {
-			DRV_LOG(WARNING, "Indirect count action translate failed");
-			return -1;
+			DRV_LOG(ERR,
+				"port %u Indirect count action (handle %p) "
+				"translate failed",
+				dev->data->port_id, action->conf);
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+						  action,
+						  "Indirect count action translate failed");
 		}
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_CT:
 		if (flow_hw_ct_compile(dev, MLX5_HW_INV_QUEUE,
 				       idx, &acts->rule_acts[action_dst])) {
-			DRV_LOG(WARNING, "Indirect CT action translate failed");
-			return -1;
+			DRV_LOG(ERR, "port %u Indirect CT action (handle %p) translate failed",
+				dev->data->port_id, action->conf);
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+						  action, "Indirect CT action translate failed");
 		}
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_METER_MARK:
@@ -1363,16 +1373,22 @@ flow_hw_shared_action_translate(struct rte_eth_dev *dev,
 			(enum rte_flow_action_type)
 			MLX5_RTE_FLOW_ACTION_TYPE_METER_MARK,
 			action_src, action_dst, idx)) {
-			DRV_LOG(WARNING, "Indirect meter mark action translate failed");
-			return -1;
+			DRV_LOG(ERR,
+				"port %u Indirect meter mark action (handle %p) "
+				"translate failed",
+				dev->data->port_id, action->conf);
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+						  action,
+						  "Indirect meter mark action translate failed");
 		}
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_QUOTA:
 		flow_hw_construct_quota(priv, &acts->rule_acts[action_dst], idx);
 		break;
 	default:
-		DRV_LOG(WARNING, "Unsupported shared action type:%d", type);
-		break;
+		DRV_LOG(ERR, "Unsupported shared action type: %d", type);
+		return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, action,
+					  "Unsupported shared action type");
 	}
 	return 0;
 }
@@ -2534,8 +2550,8 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			}
 			if (actions->conf && masks->conf) {
-				if (flow_hw_shared_action_translate
-				(dev, actions, acts, src_pos, dr_pos))
+				if (flow_hw_shared_action_translate(dev, actions, acts,
+								    src_pos, dr_pos, &sub_error))
 					goto err;
 			} else if (__flow_hw_act_data_indirect_append
 					(priv, acts, RTE_FLOW_ACTION_TYPE_INDIRECT,
-- 
2.39.5

