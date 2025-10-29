Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49318CCF9F1
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 659C04025E;
	Wed, 29 Oct 2025 16:59:05 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by mails.dpdk.org (Postfix) with ESMTP id ED97040150
 for <dev@dpdk.org>; Wed, 29 Oct 2025 16:59:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB2eNAX16aHepeeRDWbPN7HXcxN8U9K4cu49VTUXDR8xcSg5sjpp5GF5OGBExMtA4gvCiKYJfLidza2oBkO7iLWRLy+M9mQpbbsJZwQ+Kau9OCuwnj67dE/Gu1uBLbJW6mLZUOuUNc0SFAeQ4rtFcnyrPgtogoGjSdaUUQbaqe3Woi3eZZyu5HXirW+71THlbNpRe1XoAdoEUt1+9nommRRec7z3SLhUIaV9QROv5o1QBUO6LIcB2WZxFoPSxwLgVjkO/Z2EXHg+ODMe4LVBfFV2PV9vwxsUOUCZRYAElLy9fyMy0lpXLPfNJNx4qwu0SlE3vC/SJJvMq3rqwECYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXKMG6wN0lq0t8EeRJ8I2T4Ugz6HWukTX9SKjrfjL5U=;
 b=gqqLjGLuHpGeD6Xv2pgzPlXUDVP0MMfEepqUstMKzTCmReykg9gZq6C58mtKeNzJ53KBeEAIuH7KdVTiCHhiQc7cpcux3r1jvFj/D56HCS5tfLXT4TL8I4QAWfZYv2SpfoaH/+bd7zvM6BujoZD91JYElpUfbWzbryeOnR/0xx4PiB2EPYSSkAksg2uraajhhM/83ARdbmBqJHYvhZdXlFxrfztVLP3fmv4Ed+ke6gdmvmeKPg+p0d+WrXcESYLLF0mflUVWaWCfQlTsWy+kbb+V0Ye353z3HrBGE6mRTnY9Bh+fsa9H61omhaBHg5a1rhr/B5PtwB5H4AI3RZ5tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXKMG6wN0lq0t8EeRJ8I2T4Ugz6HWukTX9SKjrfjL5U=;
 b=cxDijf3chLrxwg6AyFXXq6cgD50bePk7J297HpHaYc0D62+3oYy3SrDP6uFdi1TaMpm1vahMDtnIF95mNWX0R6yHVQoaaiFdKwylEoJUUGfbo/Z8ohovMhzKiT2JXhx8GhbddipToq4bvve2fb4X2oiIX0BL2toA4m6PrQEQ8CTgdleWUcVr/rz5f4plaBu0bgMp24JjGeEUu0AF8lR0Lb8VWENPBpKhi9vHlAYVWlctm2o0eGaZ+Eki8XCrT4SlSRKdL9tH2EoS3/jGNFJyI1Av3TE1k5b9cbR/+wj+K9ywSDb0MfrnoLX8z4f3Oacq3K5WCJiemaq6hnSzZYs1BA==
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:58:47 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::64) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Wed,
 29 Oct 2025 15:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:58:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:58:30 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:58:26 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 Michael Baum <michaelba@nvidia.com>, <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 1/3] net/mlx5: fix multi process Tx default rules
Date: Wed, 29 Oct 2025 17:57:08 +0200
Message-ID: <20251029155711.169580-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1758fc-9805-40cc-8415-08de17040b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2fFU1hoznYaHPk18wIPxD/Ki3y8gPng+IExRNglvPrDqeZE+ZqsD51o7ksmc?=
 =?us-ascii?Q?Yx8zSY3Dxm+XMh2rB0Om8+pTgiU4i4zi6JeG10WlH7qgAETii65/ygfHTwNt?=
 =?us-ascii?Q?SWqLvE+gfoMFy00F4haxke9/8BhLrtHjv1+uHUihjIqKogxYoNWt8EPVYCKa?=
 =?us-ascii?Q?DCwPAk1JSxF9tCiQVU4UeBCOwOc3CWucA8ZMc4+Ah8DkaQ3YN0cPzn7bnmx2?=
 =?us-ascii?Q?+FyB2V8lbd1OMTTsxeJpRpuxQFuq8IdcsENPv6Y1j0/c9h2tDSlI5HL9NclS?=
 =?us-ascii?Q?AU5js0oIcVLVpnR62lf82ZuNfFNE7IdCuCsAJ/qNsnfKjIGK7uEACvEugZUe?=
 =?us-ascii?Q?XW6OdPIHJeVf8Tvag2EGP6T9pgVzgns6wWGwf0Jp+eTiVqv9LTDmqEUjRQ8M?=
 =?us-ascii?Q?lxHyi+ozMJTTLFW2WUCZiCqaFc1o4TeRzkwFanjgmTvNfQ3dhBt0qDPp9Eb1?=
 =?us-ascii?Q?4YGnyRPNuatgs/CSpgtiQ/UnPPvKigmWITbJW5nmi1W9jmaXoxpPmdJyJ4hF?=
 =?us-ascii?Q?B4FeNXGpuEl4FhUIBtb3Bh9FRMXTGU7dS4AC8iB+q9LK6O5k06NY5xMIlod9?=
 =?us-ascii?Q?N45PQn07hLGGVmiWz7vdthNn517y4DjQOM+xdy2dRd603fGeWEMa3o4IEbcr?=
 =?us-ascii?Q?EMc7wL85BP0plvbi0KUQ6psEKl1jv8B3Br/vA4GbOQq7ZtZ3ajSk6aEeyzfz?=
 =?us-ascii?Q?hHImF2bQyZ9OQNjDYieqj9FybUY2p12hQRxJDYZ+wsqo2+Z0krjrD8F0JIGx?=
 =?us-ascii?Q?DiGn81TtDKO1Kk0nNI5izdMEpJ2vzgtUiYeRkzT7FDrXm1RuztL1jw0YEuEv?=
 =?us-ascii?Q?9cFfPbItC0z7tSpfagDKTm8bJxyDYRIbTba0LB5h5wB9unt/5j3UM657San8?=
 =?us-ascii?Q?G14doAa2pNX1sL7onguT7qmNiR9nrTKENjOQZY9xndGIq1pq3EmvFNWh/Wzk?=
 =?us-ascii?Q?sT29my1v3/b6czomWBLJk4kdnbva6EQjC4Q5J3cqFl+g1Yn32BaETRl0keeD?=
 =?us-ascii?Q?Aassg/gxA0bd2Wfl93+beAEldUXFeIN0efuuxO/bgGlgj1Znc29ESK0wSpTC?=
 =?us-ascii?Q?Q5kh9frwosAeMaeTe3d2N/qzQj1YggU4NLqLlNSICTbtvr7PLhcsleyOtEIx?=
 =?us-ascii?Q?pbVOTt1s2X8KU7ICmkpI2lMEdnJjOyFKNWBWHmkAcGb0NFXLKdSenyVCc614?=
 =?us-ascii?Q?UmNVjYH+N4fVfI7X9qPVpi8guqg7HsEwH2h8qawot/UiYrM0bOyLXHO1sM/k?=
 =?us-ascii?Q?YfeeBt7+3pqKkqVWWgmD6nHd7jdWJJ1I77YbYS/kAytY45jDb1Jwx7wYFYte?=
 =?us-ascii?Q?egdMAIsrySiUKzwyeih62uca9GLIerGD03cKN531gtZFT00ftEPBxpg/qgVP?=
 =?us-ascii?Q?6FqNWvX4Eb2JLg22Ml6UUJU+egmnJdCQkaziDOLJk34Is/W6jlc/OjCqezaY?=
 =?us-ascii?Q?pKM3feILGx7D+eb7xpNBfA0l0dE/sqpgVlD1D15uA2e8Zp2B7LViYc/l84YK?=
 =?us-ascii?Q?+/sQtFceWMIrIkzyLAZwtcNo2zPTuHilcKBAnXpAY5Sp5+7xe7DEpCErxOYw?=
 =?us-ascii?Q?a+F6W6oJ9x8/ca9gh/g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:58:46.9698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1758fc-9805-40cc-8415-08de17040b61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

From: Michael Baum <michaelba@nvidia.com>

When representor matching is disabled, an egress default rule is
inserted which matches all and copies REG_A to REG_C_1 (when dv_xmeta_en
== 4) and jump to group 1. All user rules started from group 1.

When 2 processes are working together, the first one creates this flow
rule and the second one is failed with errno EEXIST. This renders all
user egress rules in 2nd process to be invalid.

This patch changes this default rule match on SQs.

Fixes: 483181f7b6dd ("net/mlx5: support device control of representor matching")
Cc: dsosnowski@nvidia.com

Signed-off-by: Michael Baum <michaelba@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

# Conflicts:
#	drivers/net/mlx5/mlx5_flow_hw.c
---
 drivers/net/mlx5/mlx5_flow.h    |  4 +++-
 drivers/net/mlx5/mlx5_flow_hw.c | 24 +++++++++++-------------
 drivers/net/mlx5/mlx5_trigger.c | 25 +++++++++++++------------
 drivers/net/mlx5/mlx5_txq.c     |  8 ++++++++
 4 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..07d2f4185c 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3582,7 +3582,9 @@ int mlx5_flow_hw_esw_create_sq_miss_flow(struct rte_eth_dev *dev,
 int mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev,
 					  uint32_t sqn);
 int mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev);
-int mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev);
+int mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
+						  uint32_t sqn,
+						  bool external);
 int mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external);
 int mlx5_flow_hw_lacp_rx_flow(struct rte_eth_dev *dev);
 int mlx5_flow_actions_validate(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 491a78a0de..d945c88eb0 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -10643,7 +10643,7 @@ flow_hw_create_tx_default_mreg_copy_table(struct rte_eth_dev *dev,
 			.priority = MLX5_HW_LOWEST_PRIO_ROOT,
 			.egress = 1,
 		},
-		.nb_flows = 1, /* One default flow rule for all. */
+		.nb_flows = MLX5_HW_CTRL_FLOW_NB_RULES,
 	};
 	struct mlx5_flow_template_table_cfg tx_tbl_cfg = {
 		.attr = tx_tbl_attr,
@@ -16004,21 +16004,18 @@ mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev)
 }
 
 int
-mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev)
+mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct rte_flow_item_eth promisc = {
-		.hdr.dst_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-		.hdr.src_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-		.hdr.ether_type = 0,
+	struct mlx5_rte_flow_item_sq sq_spec = {
+		.queue = sqn,
 	};
-	struct rte_flow_item eth_all[] = {
-		[0] = {
-			.type = RTE_FLOW_ITEM_TYPE_ETH,
-			.spec = &promisc,
-			.mask = &promisc,
+	struct rte_flow_item items[] = {
+		{
+			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_SQ,
+			.spec = &sq_spec,
 		},
-		[1] = {
+		{
 			.type = RTE_FLOW_ITEM_TYPE_END,
 		},
 	};
@@ -16048,6 +16045,7 @@ mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev)
 	};
 	struct mlx5_ctrl_flow_info flow_info = {
 		.type = MLX5_CTRL_FLOW_TYPE_TX_META_COPY,
+		.tx_repr_sq = sqn,
 	};
 
 	MLX5_ASSERT(priv->master);
@@ -16057,7 +16055,7 @@ mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev)
 		return 0;
 	return flow_hw_create_ctrl_flow(dev, dev,
 					priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl,
-					eth_all, 0, copy_reg_action, 0, &flow_info, false);
+					items, 0, copy_reg_action, 0, &flow_info, external);
 }
 
 int
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 916ac03c16..e6acb56d4d 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1606,18 +1606,6 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 	unsigned int i;
 	int ret;
 
-	/*
-	 * With extended metadata enabled, the Tx metadata copy is handled by default
-	 * Tx tagging flow rules, so default Tx flow rule is not needed. It is only
-	 * required when representor matching is disabled.
-	 */
-	if (config->dv_esw_en &&
-	    !config->repr_matching &&
-	    config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-	    priv->master) {
-		if (mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev))
-			goto error;
-	}
 	for (i = 0; i < priv->txqs_n; ++i) {
 		struct mlx5_txq_ctrl *txq = mlx5_txq_get(dev, i);
 		uint32_t queue;
@@ -1639,6 +1627,19 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 				goto error;
 			}
 		}
+		/*
+		 * With extended metadata enabled, the Tx metadata copy is handled by default
+		 * Tx tagging flow rules, so default Tx flow rule is not needed. It is only
+		 * required when representor matching is disabled.
+		 */
+		if (config->dv_esw_en && !config->repr_matching &&
+		    config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
+		    (priv->master || priv->representor)) {
+			if (mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev, queue, false)) {
+				mlx5_txq_release(dev, i);
+				goto error;
+			}
+		}
 		mlx5_txq_release(dev, i);
 	}
 	if (config->fdb_def_rule) {
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index b090d8274d..834ca541d5 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1459,6 +1459,14 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num);
 			return -rte_errno;
 		}
+
+		if (!priv->sh->config.repr_matching &&
+		    priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
+		    mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev, sq_num, true)) {
+			if (sq_miss_created)
+				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num);
+			return -rte_errno;
+		}
 		return 0;
 	}
 #endif
-- 
2.51.0

