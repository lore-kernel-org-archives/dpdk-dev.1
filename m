Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95929C0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 08:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2A4F42EB1;
	Thu, 13 Feb 2025 09:33:19 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by mails.dpdk.org (Postfix) with ESMTP id C81994028C;
 Thu, 13 Feb 2025 09:33:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xa91JPFtFbuN+l0EArnrYALuWE+okorbSAVjZR5Z/rcogzwNGHkHvoQwminPBN0pPgDA37iikGlB6IDUPmMJY4uOCfsGDoGsUrBYBgBmZlw9tqDaNFnrgES57czNKQo3yYjI0wB9QpG+T4+U39yfvOsDujcxuaALYS5vVhI0ojx0g0t6BitW+9yLr4dhmL3bo9blF9AJOREkoZdJu/0wG8wPJgYCcf+7B/T6dsBj15GjJ1XAaLJhQGKWJUrVdmhE9S/SsivKoZ7yq8JnfBbwcMpA+s4BMOJva+KmyVVABIgLc/GUA/3twE4rkfwRt1Vano5gye7c2AUTBKAgwc+PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5Go2/PZzIJxaz0zLTCMZB/3+nlVG1Tp+9rwDsD2KwM=;
 b=Go5Zow1M55yN99a41X9YpEd+XuoAP1cn2GrnNw0y66KyFrOsiZoMmyU3/PFozr4FUz/DwO9b4RmOSzEJfrWXKVH9IfvOwAb1Dz3bE7zcVlDAift8RSWcQaivYtyWXk2x0iO502na2WMiTP6WPCigwF0A6QnF4tYxpyVnC2xVLP89tf5hiwjQXJ/VWYyVpERX28I/szcUvjHLxA50Nsoj5GYCSURa+gdFEbKRvnZjadx/5C6ywa3/urIlXIU8sTTEsEfSm6F/Sabn9J5SkMuYmvu9HobbN5IlZkx6FnpaFULxJo6iQSaLgdFw0elXRyz6tGC+aweJd7nRu3umFbofrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Go2/PZzIJxaz0zLTCMZB/3+nlVG1Tp+9rwDsD2KwM=;
 b=M2hesnv5ej6MyzihlGQBPQL008lJnliLnkysmDvSQCIQKTHk0mWN6nrSHXN50FKbB7YTCD8/9k5/oxodDV6bKsvAN/pl95WdhqoZ4t62iRbD8sT/32a/9vkvvsN0u8buzmryzyfu8xyVovpgfRT+xC3s2Y0S+Xd1JD/rVWwuAcRrRb0eO9F0PY7D+iraSWYaFS9lkPo1wAx87jTWCj9VRqCasn74TuNHgKXbxEo7PhSzx/THlv0B8fvUneEqKpZlfJBJDj42RS5t8SJQ3xlPESysBqM3dNLQXUxFs1+7Pxf9DVCYwk2hlqgS9PvC1IO6cZlKvXnMvf07QVONOBeo8g==
Received: from SA1P222CA0186.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::18)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 08:33:15 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::88) by SA1P222CA0186.outlook.office365.com
 (2603:10b6:806:3c4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 08:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 08:33:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 00:32:56 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 00:32:54 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Tamar Mashiah <tmashiah@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone actions
Date: Thu, 13 Feb 2025 10:32:38 +0200
Message-ID: <20250213083239.94360-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: e51c9e5a-41bd-4026-cc9e-08dd4c090f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lUdIin4TP6xi3ZaI8Bl7/WG/SUsdNp6iSbT627bPs2WxIb0gIiwzRYLQYnlM?=
 =?us-ascii?Q?jEqYNiUxG2bakKBNoHPGdQkB59v8SXNFIvmqb906+2aOfz9defIP5Z1U7iI2?=
 =?us-ascii?Q?gqVkDaNEYVm36WzOlL9OkaorM6l16ZIIBKBtQD5E9ntcDjSIuEEdlWmNVmc6?=
 =?us-ascii?Q?D27QCk3sgkKsA8JkGCM86zHyarCjjHTSvkmFkUQe1IolQygaBplkbtTXdC8O?=
 =?us-ascii?Q?6hWQLt1adtALQfIjTNObjMWvi3/okEIvEDYZE+lEzEqis5xO7iIPHA417EZq?=
 =?us-ascii?Q?MfOGsZSM/KfPxVqLXO7cosNtfEljpLwyOxuL4uKBT2b7LvCRKS0GrAT1NlYt?=
 =?us-ascii?Q?p0oa971HOUUSg9FZKcXFJtJcLV+dIxG1Q/mNDIFUgmnn3yoriBk4mi3e1Rox?=
 =?us-ascii?Q?GTl8ib8+1Rplcv5E015mTvoKJXn3wqlb3bzBu1+tet8WKeMqZavgPrLq7FfX?=
 =?us-ascii?Q?ggjFtFoy20zzIeSAtPvZbil52OC7+Qafq4g1XObV5nRYJGNZ287kSFdzh5ot?=
 =?us-ascii?Q?njNgRGra3fW17Q3Q8nsqFz/rFv3LIljuHioiHqEooAjmr5AkhRkhLdzMDOuq?=
 =?us-ascii?Q?7l1fI4KdfZt1HE/+rSjj5Gzdr+0bWZkuAPNaiQ5WTAcAz6MGApp7cyKd5VG4?=
 =?us-ascii?Q?Vuex1m9X/jYb5GY+6uPkBc7i+fI96AEfcIphZjSUJk0mlrmCP9EExARhBTGl?=
 =?us-ascii?Q?76fkxlfTUrqimPnf7OfbjcOfANvq4xm4Sd3o1LkxJvfqaLaUjN4HCn6pLHFc?=
 =?us-ascii?Q?Z/ZdfasrXFx8EYS599S98U22GpRDYh+a/D8tRl5InNMExHwZ+hIqFL5hvd+V?=
 =?us-ascii?Q?DOd4pTBQkZjTyN9k0YGepmYrXcevPOvBz5HeVWiB+eTV0eeakJW48081ob+w?=
 =?us-ascii?Q?Aoul7cBFIdqemQcEyBGGzh6oq0WyTB0oaS8COEr+GSb47vaeo35ukTERDQFP?=
 =?us-ascii?Q?kpoz6hKhuxsTbgZkhRDR7TKgBfXvk1SH1TJRPXvInNwA//F2OwnE1W6YjaIu?=
 =?us-ascii?Q?9tSuylfjDknSfTeKWFlneZNt6jQDxajMjTQS19d2GTyOd5nveiWigQBvn+Rw?=
 =?us-ascii?Q?FUcR50CRjNeoQ+VddisAS7HVnMdW8Ao1uITrwTU5o2bSUwkSx8JNg5kMGiJt?=
 =?us-ascii?Q?b/FfiD9B1zqg3dh1wHOvqTxGCRob8atYojEFPKwyYiIeBVTN06hLwM6uolVm?=
 =?us-ascii?Q?VLSguOzEv3EQe6KzR8u0dNJMbEeThcrHLDQnMuoXJ7W4ovy2NjLGRMaer8W2?=
 =?us-ascii?Q?xY92HUN1m73SUBOhix8xIxWvlvKW/c71dO9mJcRdFFuVJ7ZBP+dSyvbct0pG?=
 =?us-ascii?Q?CyojyqUwEGZCbnMRM9BuyPjqHOPls9C0DRI/Zx20MsAcQfvTuhmaWbFvKL8r?=
 =?us-ascii?Q?/mfsiBidpJAwYhcJJFC+i2sT0Qfm6F0hQ7XraVciTMhnVo5rS0cC5ZCIYhRc?=
 =?us-ascii?Q?GTMEYRbPplPhWIRR9ZQCJA3ICqYEkCPLfxrC7yzBBZ6JcfVzvtdH6E07LVkH?=
 =?us-ascii?Q?pTwJhvaF0zVVpok=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:33:14.8451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51c9e5a-41bd-4026-cc9e-08dd4c090f34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
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

From: Tamar Mashiah <tmashiah@nvidia.com>

Add DROP destination to mirror clone actions.

cc: stable@dpdk.org

Signed-off-by: Tamar Mashiah <tmashiah@nvidia.com>
---
 .mailmap                        | 1 +
 drivers/common/mlx5/mlx5_prm.h  | 1 +
 drivers/net/mlx5/mlx5_flow_hw.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/.mailmap b/.mailmap
index a03d3cfb59..8e6e2d58a6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1517,6 +1517,7 @@ Takeshi Yoshimura <tyos@jp.ibm.com> <t.yoshimura8869@gmail.com>
 Takuya Asada <syuu@cloudius-systems.com>
 Tal Avraham <talavr@annapurnalabs.com>
 Tal Shnaiderman <talshn@nvidia.com> <talshn@mellanox.com>
+Tamar Mashiah <tmashiah@nvidia.com>
 Tao Y Yang <tao.y.yang@intel.com>
 Tao Zhu <taox.zhu@intel.com>
 Taripin Samuel <samuel.taripin@intel.com>
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index d0cb0131f6..4e630254f8 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -5221,6 +5221,7 @@ enum mlx5_flow_destination_type {
 	MLX5_FLOW_DESTINATION_TYPE_VPORT = 0x0,
 	MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE = 0x1,
 	MLX5_FLOW_DESTINATION_TYPE_TIR = 0x2,
+	MLX5_FLOW_DESTINATION_TYPE_NOP = 0xb,
 };
 
 enum mlx5_flow_context_action {
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 501bf33f94..39da3543b4 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14144,6 +14144,7 @@ mlx5_mirror_terminal_action(const struct rte_flow_action *action)
 	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
 	case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
 	case RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX:
+	case RTE_FLOW_ACTION_TYPE_DROP:
 		return true;
 	default:
 		break;
@@ -14187,6 +14188,8 @@ mlx5_mirror_validate_sample_action(struct rte_eth_dev *dev,
 			return false;
 		break;
 	case RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX:
+	case RTE_FLOW_ACTION_TYPE_JUMP:
+	case RTE_FLOW_ACTION_TYPE_DROP:
 		break;
 	default:
 		return false;
@@ -14382,6 +14385,8 @@ hw_mirror_format_clone(struct rte_eth_dev *dev,
 							  &actions[i],
 							  "failed to create reformat action");
 			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			break;
 		default:
 			return rte_flow_error_set(error, EINVAL,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
-- 
2.45.2

