Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD07D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 17:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9AD34021F;
	Mon,  1 Dec 2025 18:37:16 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2]) by mails.dpdk.org (Postfix) with ESMTP id 2FD6E4013F;
 Mon,  1 Dec 2025 18:37:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuNy6N/vedHM+AaRQnE4Q3j6Z7Ld3gPJ/kz2E6i3AtUTgp5HH2ZHatn68W02FwDmAd7NpwVmrmgdxYqy0rQB+aTJa4xqQZXG190UVnWb+7bz5uS0NJqgfMq9umaPsH0h9iAGJAWu/qyzTG//Y7jXyyoYBUWJG4//A6dPkA8Fgd1yiuE7pmfgwj3Af6+r1S5eSbVdZUIHP/gqmuuBRVB7BEQ48QdlMwxcQFbvfHmOYFeLxYBwEwoC8urCGHR4wjtUK4a6Cg8KFiopJNv3Wf+iueNQqdNFaJuRRDeMMTqxXk8m0s+8EOY1Ij9QfgiDb3VcdKjcPY5ehWqriK82BRZsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW9lAaWfaq959lI/HhkMGiGjt699CWcxxDEeZXx0E+s=;
 b=IpANS7+ZbiDGOjs5ck97CekhLfvFBzabMOMEsIRlit8lSANGCGQl+mw9X0493fRKtBDV7Nw4M9FQIg2C2VKs9AmKXP2m1gLXpDhquXwtYWxWZaTepXIhphRZTJsEdvY/M725PNpLDF7s8iGDbnuFNuE4wLQJc/bTlgwLf4c5RXu7EP8S/w5VqaAN96jHG9tXySIrfo9xSAVmKtpu8ywidWiTjWFfmh9reB/B0WYsu/xBNVlezDBaj5OAeZpQTSJifn4WIq68IT6MZ+j+PuLbeD8GQ7851vG1DMBr6icwNA2tI0wWU7AjuC/IhiQ6WhbUznADaFrHE6ViG18oxfrhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW9lAaWfaq959lI/HhkMGiGjt699CWcxxDEeZXx0E+s=;
 b=XH4NYWoxLfB735iXw+FzK7sasEMKHS4gWCY0b+XOr6q7uvS5x9D+vQplHbhGYDhFhowQanD7FM/XpMtoKO5zjtCNG7sWBTfhRQ/AnkqdJbjUF2duKiiVv4WH/0QsMWzKqKjln7MWpzGzBXoiSCA4eSwLtJWxqiMk46FFGjNAc6DaShC/7XP22CNVEAnr1jLbXo+Y5dNAS9mdNdMC3xu7VcM3Ze6kTUe0TTJMdiLhqqAOxbcUCJfJuuApehcAdJoJtKs2GjlBzgbVi+virMUEEQR4XVV4EH4SyIE+3ZpYLb+gHsNY1pFv9UrHnJJUSKcRocHqkn4TPX4FLP/NhfLgmA==
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:37:12 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::88) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 17:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 17:37:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 09:36:46 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 09:36:42 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix register selection for metadata between
 E-Switch and VM
Date: Mon, 1 Dec 2025 19:36:27 +0200
Message-ID: <20251201173628.266032-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: edb8bad1-f846-435b-8a3c-08de310042bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n5XZKzbNY1cvNYPnvjm0IUfqk8Da12dENp52B9LV5G+XojfEfWvGVLaOfP+/?=
 =?us-ascii?Q?fBcifKhN/CqRBneFiWbLk7BKNxWEKOyOU8QYnqcSs+QFL8NGBbRaMdxOkXpp?=
 =?us-ascii?Q?OWBaD4k5mhOWFwYyBdS9HU1KICPbE+YgdsnGxa3b439J+Qs/3Yboy+a93v/U?=
 =?us-ascii?Q?iJfGlyWfIeP61LEN0j3ldy7b2rzZ2YSePTG+AR/mUimQy67jLdlgXjaKMyXj?=
 =?us-ascii?Q?Y/UmX8rPXYladS9YdE6FJK/CR1DX5yNLPvEjAhfFjiwIz8n0PTd587ukUwy3?=
 =?us-ascii?Q?WHTfJFWHfkRXca2fTtnu4lKQRQtyCRWIJ8SEkFIYsis1M0gx6bT7XrcPic3O?=
 =?us-ascii?Q?+nCIBw11XdLSg3NyWE/px3U2SV39HRhSOhdMYj6qrN46DMoeu4M5GJ+RTdvn?=
 =?us-ascii?Q?EIh84oE9vbL8V827w089nrDW64N2ey045qp+AUj35NL5ss7rn1DfefViFB3h?=
 =?us-ascii?Q?wTKNcP3tfjVOYUfjPXi5utSecdI+PdZXvVWE0cJ536q5BBvZIhU+BdabHZ7y?=
 =?us-ascii?Q?hltQyD92JCMq2k06p5uOe26fdHcmMlw/abdEqxrnhZIpRDUixLUACTirbOx4?=
 =?us-ascii?Q?H1AAwpG5uUgvcAO3JzjKcVR6031QVWyIRtl+NfiXb0azUYhRPsZQcUdMi9T0?=
 =?us-ascii?Q?ZESUocqwVCQVVyG/LtfqvwG0TA0IKYt2CalURsOXUwMLrkhQRseCJYlU2qig?=
 =?us-ascii?Q?vpfQjxS5Fr7g5La9vJuW096uXq8IJw9aHmxzEp5nn9wLCYrCagX14G7qdOcf?=
 =?us-ascii?Q?i2DL/E4ziKNw7YmFKq9yUzw6MIN6ESVayUjuewh5kllfkLwZzmzTxMK2X2PG?=
 =?us-ascii?Q?1cHscSi6resUuyaAtNiX2/CmNV9KcWff37wFf6c+YdNstjVznr8L5lYrI3i0?=
 =?us-ascii?Q?HO6/CHjvqxXu9q+qajWz7y6c2Op0p6F0QBl2PXf0N85Af1QqLbP9YLP/uFij?=
 =?us-ascii?Q?Wh9NaSAkFm0VwwN23k7S4/rbIQjQDMyY5rE4kVG3+Ah5EZmn1ADHFeKK1IHw?=
 =?us-ascii?Q?QpcvMAPprfnebWxi8pIGyApL+KbPMlj3F2114cdyDEhrPXVFLYRloOMLb9Z8?=
 =?us-ascii?Q?0QnJA1c94FPyxjpOtE+rkFZeo5IIPv8RrVmi0vrKRm8bBVu4d/1+wmlu25Pe?=
 =?us-ascii?Q?fM//QvLqDTTUx6uHjhpt0pDL1/TqIBrJpI2kkU0+AympzHA87E8trOe8/EwZ?=
 =?us-ascii?Q?K4yL1N7n9rX3LBiBefGdXYIlVeVx+MgBCiY6fxhD0rjrJBPmd1mdv5Qo+6o7?=
 =?us-ascii?Q?6GVtowy1gcNBtFikzCy3TBcswx+TTlkRmvX6JtYW9Xofx1dzOICSWngl3oGY?=
 =?us-ascii?Q?EY5iowTLzX5jbSENz4N0NKiuErsdLdfnmgo1mJD3IBa0pwKSkBSbB12IqYck?=
 =?us-ascii?Q?w6+g6+Nzt4kTq7ueFSxRzuuAcrhe5VZ16SwU5H8Fa5yQvlLBYe0QF/W65c1e?=
 =?us-ascii?Q?V/vhEF03GytC2EgqI8LyApdm4arnw6qOh9AuDzkcyiltMzop2HnXPGWEuKO0?=
 =?us-ascii?Q?Wvma0Qvc+VSAcgHTZ1OMYgBoVsSLl+YdggoAvX9/ueuPctQysKFFyCjUC6k/?=
 =?us-ascii?Q?gNwovPVQ/UUeFNxk5Ek=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 17:37:12.0622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb8bad1-f846-435b-8a3c-08de310042bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

The PMD relied on a flow domain type in register selection for
modify header action that assigned metadata value.

In the HWS code, the PMD uses the MLX5DR_TABLE_TYPE_MAX instead of
the exact domain type for flows in group 0.
As a result, the register selection was wrong.

This patch fixes the register selection logic when flow metadata
sharing between E-Switch and VM is enabled.
In this case REG_C_1 will always be used.

Fixes: a78425ba3793 ("net/mlx5: support flow metadata between E-Switch and VM")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 218b55d536..09084d311e 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1794,6 +1794,13 @@ mlx5_multi_pattern_segment_find(struct rte_flow_template_table *table,
 	return NULL;
 }
 
+static inline bool
+mlx5_esw_hws_xmeta_mode_meta32_enabled(const struct mlx5_dev_ctx_shared *sh)
+{
+	return sh->config.dv_esw_en &&
+		(sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS);
+}
+
 /*
  * Convert metadata or tag to the actual register.
  * META: Fixed C_1 for FDB mode, REG_A for NIC TX and REG_B for NIC RX.
@@ -1809,15 +1816,10 @@ flow_hw_get_reg_id_by_domain(struct rte_eth_dev *dev,
 
 	switch (type) {
 	case RTE_FLOW_ITEM_TYPE_META:
-		if (sh->config.dv_esw_en &&
-		    (sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS ||
-		     mlx5_esw_metadata_passing_enabled(sh))) {
-			return REG_C_1;
-		}
-		if ((mlx5_vport_rx_metadata_passing_enabled(sh) &&
-		     domain_type == MLX5DR_TABLE_TYPE_NIC_RX) ||
-		    (mlx5_vport_tx_metadata_passing_enabled(sh) &&
-		     domain_type == MLX5DR_TABLE_TYPE_NIC_TX))
+		if (mlx5_esw_hws_xmeta_mode_meta32_enabled(sh) ||
+		    mlx5_esw_metadata_passing_enabled(sh)      ||
+		    mlx5_vport_rx_metadata_passing_enabled(sh) ||
+		    mlx5_vport_tx_metadata_passing_enabled(sh))
 			return REG_C_1;
 		/*
 		 * On root table - PMD allows only egress META matching, thus
-- 
2.51.0

