Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4BDCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A38C40693;
	Tue,  4 Nov 2025 18:48:06 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by mails.dpdk.org (Postfix) with ESMTP id CA90D4067D
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:48:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5l0ayNENxVDRq/yMaAE5idAClOCrHhKwP/HqhoRkK5nOizkG+Jht9YTYmhw7BIiinPtQPMMKn3PyyjV//MaelENvuY0wE1milzM8iixRVl3Gs+dgGB5Qec79xTW/UYol1XqPYSCc+TNrReaKLY12LKDsvaMZuQae8KdEBv7UQLnLlLPzn105yPCrMhJRqxsAa2ykW2CrbTIgNT/M7GV85Xi0uiuAmQymJMjisYcaCy1FIP3RxdQJXFqwvjshCEqVsnukBiiMeRFUXjH7cWkoj0ltjVdo/81+M+z7mTxFUs26wEzukqv7NOYQyEbnG7pOd2VBtZyeUk9fSLQWAyeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEgYuELojE7bsMshhTDeR2kw54u/6bEpCEhOB3U61kw=;
 b=BfLXuXH2hkyeemeV4YanqaYd34i5WPSW1XJjywnIhBSpu0UleIs+qsnRhkHjTkVVTlulwRYZ2WBtlUSun77vGu0yhDtBrAseuwakzmim6KanN8e+o/RlV8ULYgBjIPqEbjrermBIUW/5UcuSHPh1gJJvW3AodNNoXOuAOPUSy0Ssz5kmATAgUKT4jBw/uCtQakXYBkwV2A1Dnc8UccNX6jlowPHvNHLX60Y1ZYg0MqLysWZO3JzSFKnQiXBD5/UT/Kdks9Lr9ZZgGxmCSJtQWKPx7m4xCmVH+U7BysFTupX/znSCpOZ67+X5VLyrw3Ndj+E/wsTbHsY9aYMR2ZHBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEgYuELojE7bsMshhTDeR2kw54u/6bEpCEhOB3U61kw=;
 b=Ma9mq72G+5CoFNjEmEAG+eefW8QX/2vtUK3DhW4jneDi65WudPIrCyY70FYkW7HwuCJw2tLFeHpX0WeKXHvC4sGHSRi628F8Qsx04pL6SiwmAd8xmoy2DZlBJmgHuEz+0AQ/kKnq0Ux1XeSnbbmzt2VlnOlrY2U9mIrX35uTqkmZo7xHT1ewGVEjAK3XlrbYtLI+PnwcslwTAOHUOL/aUdEbKYbF/DV/UJoYDUySASHwLmEpPIQ5j6gMJmpK+r1Txgm9B31J57pxkcjpvic02INbbvjomJ7g5Bh4Zr/neMQXoKajv7cKNR68B+e71jBMrRJEi42yWGOSep0b0dGh9w==
Received: from PH7PR13CA0001.namprd13.prod.outlook.com (2603:10b6:510:174::7)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:48:00 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::e5) by PH7PR13CA0001.outlook.office365.com
 (2603:10b6:510:174::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:40 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:38 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 4/5] net/mlx5: improve error reporting on masked indirect
 actions
Date: Tue, 4 Nov 2025 18:46:11 +0100
Message-ID: <20251104174612.1341962-5-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: b17f0cc0-123a-4354-bc8a-08de1bca4b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TauShzzTaRQhtmQmA1vmtPOXY/hnINsMbzQeVwt6/49nE0BeQ94I0n4x14Jm?=
 =?us-ascii?Q?1yF2mN5W/vfJt0uxqOeXKP0orW21LVM1qdYtg2XJosdI4R4vRa1nyuFOGVZ1?=
 =?us-ascii?Q?QgEEEU/QwtKbw4ICZZoBzb2/SnBNWojUp+cgYr7U/1uTNtry9wY5f3xriLQJ?=
 =?us-ascii?Q?BYXd1AS/JpZYyC/quRCaHLUmHKNidf+CRhTQAghSuK+0BtkchSJRWqIce/KW?=
 =?us-ascii?Q?puao4b01CdTkDPoSQ6Ea0yFnrrvOmh1KX8b/MX12Uk5/YZ7CuPlukVSmi7Jt?=
 =?us-ascii?Q?xrrT/KbW+g49cBB/zPEb939eBbx0Z6P0OsmgoGN+ZcPA3Wek8WqYKi1Paokp?=
 =?us-ascii?Q?3DsY4WimcEKzQwjiH8jk+wv6vqTxBCVZEOELK1xfwtLSSfzC92UEbZ4nesju?=
 =?us-ascii?Q?P7uvJtO+lD4vujJPlmdFKCuWzgbdgFDaZk6MbSHFfw3vEyKI9geq5lvHOOcW?=
 =?us-ascii?Q?IOxX58cQPRlLXzpneNkX0zcryCp8B/Xm8K0eP6B+Qfmu+9xIm2wLnon2cdlT?=
 =?us-ascii?Q?rEFEdXmf0mcRs6Y0mt+4YySrKXVvSPUBgi60csgZtueSq9RuJ6VNwCAodC6w?=
 =?us-ascii?Q?BwcCRb5SBadSIKZuYihrR8J593k/V4m/4NcPNpPz5oreuAbiJDMExWD2bB7f?=
 =?us-ascii?Q?kAMlpUfuX543npwuj+TODoXQVlpAzEbZeyrVBiwK6VBrIaljXxOlri6NtkVH?=
 =?us-ascii?Q?bIQiZE06iNyNBCwYRoIOrFoOxbEG5Sh39vsgNDHITrqJ7rAsz5xk2f5CmhcK?=
 =?us-ascii?Q?jxilpEj/ONo9wwTOSYSp/R0j+AIJDY6PrevL8uUh0Sn2YwOz4QVA5UlbQFdB?=
 =?us-ascii?Q?j7NYVwgiBbz10Xqj7fj0sYC7skpvFYqiowupYPK+pR3AhLRflluM+7c0qx37?=
 =?us-ascii?Q?L8LKLpiWDWgew+Q7236jAWV9o80nXALyWSIuFg3yAOpk+yMDccIO/B9UmHpk?=
 =?us-ascii?Q?Hk3yZg0FRAS9mAY9MjkhAG4WJzs9vjLxN3J5eGOCnn3vt8hc/uZKPMYYkNAl?=
 =?us-ascii?Q?88pyegzLsazxHLtznulfqaaeq9xtkveCVzhvN8MMY7yLELKyN70ydR/VhYqb?=
 =?us-ascii?Q?aHIs2nbTy9zEbQsdAnruuz/V0psuzP4yNzz2ZsEnQ01QVSXTR8hTRokq8GMo?=
 =?us-ascii?Q?80zqvFe8hw5pr18lpZ4LjUdvTT63Zfj01e/Fvy08MxW/2g0johz2VfmxUZX4?=
 =?us-ascii?Q?YwlH+bNAqNPzAPpUjrcukmc8YTfxhU/9uSWWbe7ppUDSFsYGo0yGAWdmet+1?=
 =?us-ascii?Q?XcfjQXLDf67aYrWny2bWQVH64iGobVecpJ+2Q2KnT4+RdtImGF4Tr/J4zLCw?=
 =?us-ascii?Q?aL7t5tFJx/prmrO1FRJsoZWrZaEdRyKdSHROdw5+CAvGqYU9QhAwQ/utFVqE?=
 =?us-ascii?Q?yrfNuC2uj4Uhu9Rh1HNGTOAlWCaBMfA8zK1CNHs2C44HLDVrfdwydVo2UCOP?=
 =?us-ascii?Q?FRGxcbYlLMLvBXGTCu9cXdXDfe2/qKESuoj8SfMpzC6TL+1G+KAjd5vKWzW9?=
 =?us-ascii?Q?VE8g5p3WErmC9c+vzQQuw1sLyNW1G3IY7ZNk9b26IcMUHed34JevQXzIIvKM?=
 =?us-ascii?Q?NQkuaGWQT2Zk5zcgYVc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:59.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17f0cc0-123a-4354-bc8a-08de1bca4b8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

This patch improves error reporting for masked indirect actions,
during flow actions translation done in HWS mode:

- Replace "return -1" with error reporting through rte_flow_error.
- Change log level from WARNING to ERR.
- Add more information to log messages (port index
  and action handle).

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 42 +++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index de004f8c1c..4aa0a01b5e 100644
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

