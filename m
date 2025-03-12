Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096FEC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 09:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3C1402CE;
	Wed, 12 Mar 2025 10:51:44 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by mails.dpdk.org (Postfix) with ESMTP id 95D8940265;
 Wed, 12 Mar 2025 10:51:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAFJAAKLm9cI2peshTLpXT03TFgXZend8pigBhbmUahMWY7O0/WYg4pkffwQGBrPo873HtYCAtHsLwOZXvM4NJfDCPSPsrXJZ3dlKZbVQ/1Qu50UQJNQXJJC4S5fDP5OGZQyJPNMXxDjMFqP7RzWb7Qra89nWfg6Sb+0C+DqrUqanQEHLiCAmrJhJVL29xscxM2edyWzv5GOpAGE4sr4lIfb2RmxwnHDwyHTfj742Gfrn/iM7X/I3DsUOQuuCnPlcoac6sYKDUutw+YZu8/5s1A5EYSDdCb7MgYS9g7AEl1vrnZHcLW6V5kJoiUrydN1HqWiJoZWoM/lqGtqWE/0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4AgA84iJVJ/txx2ue7QUoXFbz3A3oM0IxvfyhRnE9w=;
 b=u+TD5TQA2Oc0oKnBQKP0kjHkOvDhmRmIWy4lFAJU9dcAwm1ayCTqnj/fM8VekPHW/48fGou9HdasRiqFs643CS2zpMRORQx850opDJXy239s0OpTmT+O7eC1bRXLUo3zWmZHdBg026j8wPqYMtN2SIhgcRe/F9kj4iB2cox0v623WDJm5b8ZnIuu+GBsdICje6eexjXUXMBlEK0xgMCxhFiAClTj7WSdCSdV+Wz8UU7KK2bHhmwnJRNl7JR4FucgfEz6S5vTSKP27/YuxpcSejPJtdy8DlztFwovZbzuJgruITBIww9FHWmE7pKa0S5/tMf9T1ueS+AL4WXzb/wfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4AgA84iJVJ/txx2ue7QUoXFbz3A3oM0IxvfyhRnE9w=;
 b=a9rg41YwgoeHz+fys5HaxJlQohb1MgHqEd9XgtE8Jnw7yYT5NyFOi+N5T3Wsjc90EKZlaVRnKvGHqQI2tplQplj2kmxhbMFN2xHfvrwfhIfiY4ZEzA5vXLzWwOE/XAzv74l6EDTfO74Drytno/Ra0YaS+KNSPaMRBeru+50rhit9K46qZzaC5NPZKMVT4/0W7uHPkkGG9TD+i6HZVOeG/kMpuuTPPaR2AsmCvhBXnpfq6V7+Ipa7JCQtlnuElQH9zvuhPA9nuVmC+lYqL+0zDf1EoGaZS5K+xTk90G1pRwaiGHkaxW1+fmt7GWM1TDkUMGW0c26DJHTR12yPFH4d/Q==
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:51:37 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ba) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Wed,
 12 Mar 2025 09:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 09:51:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 02:51:22 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 02:51:20 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix NAT64 register selection
Date: Wed, 12 Mar 2025 10:51:08 +0100
Message-ID: <20250312095108.105978-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: b9529ff4-ef7c-484c-03c4-08dd614b7b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ybFNCbkFN5HasGZj7Dzi3bN46G3saNeKdK/1AfqBjCwtNY+FeObuJ7mDsYOK?=
 =?us-ascii?Q?K9uV2k6HaMrthIkmPz6RRkOCztcs48Vw/DvvKYyoWYLeyCkpnLgOB0mfDaw6?=
 =?us-ascii?Q?7CDbBs1b/VTdlnutbFN8Z6P2lk/0jO7WRC20xNb2PQZaYF2s5AqvTnPM1rjL?=
 =?us-ascii?Q?7LzDyjt4B2uvp0ZzwzX9I4tVqmYcEenqa2hePaIP9zNRBi4ALd1kN8xB7o6c?=
 =?us-ascii?Q?ZEXAvJNFeajRyB5WT49g1C0FHIoD75d0hRj4vqUFbIv3uL+Einzz1a4XKX1h?=
 =?us-ascii?Q?rWMh532jTU15tGRFJ+EbDlasQnn3MTpPfaeF12nGMUz/OeW4WW1M9HXKRvhh?=
 =?us-ascii?Q?FuNMiV9IByYARZQLFNHjPTuSv8KeVGp4OhjlTR/sgRjI+Z8VpDXubeqj5Evm?=
 =?us-ascii?Q?9E2L2xokYOPhEF5kyKPMeSm1M13fsvvdqLHaJEy0Wg8VtSlaL5PIhOsF3Bwk?=
 =?us-ascii?Q?HCkHHX9y4GpYzCh5YdURc+DaBuCPhEFUNcFM/b3nTxXMOWpZxp4AqLB1Qy1J?=
 =?us-ascii?Q?GA0I+hbYV4xJba10OEBOAnxb2yjTwi8PV6fiQW5QgfMb7M6Np22oi4iSU9ka?=
 =?us-ascii?Q?vRlzfdvqG9q8J2fVOEXAyGOxDtqFvEOI5j9N1gIkdZoDLrSus3HtmLiJ3ePK?=
 =?us-ascii?Q?au6aCA+VrTz73at166wvX/dRNBf/zQS3n/64CZcE5XW5S4bMNubUEJ88EtJu?=
 =?us-ascii?Q?AyViNUGvHcLK4k9V4+Qu7GEWnowdJLnQSqLfOXNfaRr7/6/CqeSB5kWI01c8?=
 =?us-ascii?Q?TdEQfaSgVeVl2Bvc/JXFT+VLAH1QXPvi73bmtWjE7q4IbEN5Jp74pcJDe66U?=
 =?us-ascii?Q?9uay+A2FEQPux3Qtf60S0JZMTuCLUaQLbb7x9eZO9gdpmcqVBBtjsJYgSz33?=
 =?us-ascii?Q?p4JG5tmIiK1IBOl9eICR6k0CA/8tva5phG+pp8TKjXg/mELz72/Zi8g/sTGW?=
 =?us-ascii?Q?/d5q2D5v/pJCkQvX/57/TxJlgzw2PPfW+CPyUJqkX1pB5bzcmJO1hvl6+QbC?=
 =?us-ascii?Q?aAuR4DoQD6U3gHw29LGdAd89pH0PzOwPJoHr4JvocBcsJWA1QSsQtfzzk1xz?=
 =?us-ascii?Q?jCDeyJvU32a3d/yVL1tqtk6QjsUUCzqsLzCoQoQ7chKsW9CqFiS/iwtUisdg?=
 =?us-ascii?Q?XOD2noKTZpGBaADFE05eU2P75L/sUlCp2lu6T3ZcyT9BYJW/9/iyHmtygEjC?=
 =?us-ascii?Q?rt0xHVNrGF8/Ks1eAEx31NcWZw4drAyQktoFJxYhjLvx0VpwOXX2P+zhnTuz?=
 =?us-ascii?Q?GPc4UXJtPxqh9tyDWHvcVFz0vG7llc49+6D3pQ3Uak2QoL3+E8FgdB8NohDA?=
 =?us-ascii?Q?OzIuycqpZiO2TNEQUIsRG4C5Qkkz57PQRlURCY9dQuwO5PbyyqH+UHk3ixOU?=
 =?us-ascii?Q?dCVpAB00RQlvzfHkmhM4/k7eQqTtSKlB18zRosVRL6bR2bDM9IgajmrxpD1f?=
 =?us-ascii?Q?3YRYv5XCPvDOKpsuxXvxRkwpROI/uA/m4Me0haA+eDzXDSAMsTQX12pV3Y9n?=
 =?us-ascii?Q?mLTpguW2/pA60do=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:51:37.4592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9529ff4-ef7c-484c-03c4-08dd614b7b56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

PMD statically assumed that REG_C_6 is always available for use
with NAT64 HW flow action.
This led to PMD configuration errors on FW versions which do not expose
that specific register.

This patch fixes that by adding a check for REG_C_6 against FW
capabilities, when registers for NAT64 are selected.

Also, if not enough registers are available, PMD will not attempt to
create NAT64 actions.

Fixes: 7a26bfec06a4 ("net/mlx5: fetch available registers for NAT64")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.c         | 16 +++++++++++-----
 drivers/net/mlx5/mlx5_flow_hw.c | 22 ++++++++++++++++++++--
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 0f49cb5e5b..e175f81031 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1624,7 +1624,8 @@ mlx5_init_hws_flow_tags_registers(struct mlx5_dev_ctx_shared *sh)
 {
 	struct mlx5_dev_registers *reg = &sh->registers;
 	uint32_t meta_mode = sh->config.dv_xmeta_en;
-	uint16_t masks = (uint16_t)sh->cdev->config.hca_attr.set_reg_c;
+	uint16_t reg_c_caps = (uint16_t)sh->cdev->config.hca_attr.set_reg_c;
+	uint16_t masks = reg_c_caps;
 	uint16_t unset = 0;
 	uint32_t i, j;

@@ -1648,11 +1649,16 @@ mlx5_init_hws_flow_tags_registers(struct mlx5_dev_ctx_shared *sh)
 	 * Set the registers for NAT64 usage internally. REG_C_6 is always used.
 	 * The other 2 registers will be fetched from right to left, at least 2
 	 * tag registers should be available.
+	 * If not enough registers are available or REG_C_6 is not supported by current FW,
+	 * NAT64 action will not be supported.
 	 */
-	MLX5_ASSERT(j >= (MLX5_FLOW_NAT64_REGS_MAX - 1));
-	reg->nat64_regs[0] = REG_C_6;
-	reg->nat64_regs[1] = reg->hw_avl_tags[j - 2];
-	reg->nat64_regs[2] = reg->hw_avl_tags[j - 1];
+	if ((reg_c_caps & RTE_BIT32(mlx5_regc_index(REG_C_6))) &&
+	    j >= MLX5_FLOW_NAT64_REGS_MAX - 1) {
+		MLX5_ASSERT(j >= (MLX5_FLOW_NAT64_REGS_MAX - 1));
+		reg->nat64_regs[0] = REG_C_6;
+		reg->nat64_regs[1] = reg->hw_avl_tags[j - 2];
+		reg->nat64_regs[2] = reg->hw_avl_tags[j - 1];
+	}
 }

 static void
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6254857301..20d38ce414 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9656,6 +9656,19 @@ flow_hw_destroy_send_to_kernel_action(struct mlx5_priv *priv)
 	}
 }

+static bool
+flow_hw_should_create_nat64_actions(struct mlx5_priv *priv)
+{
+	int i;
+
+	/* Check if all registers are available. */
+	for (i = 0; i < MLX5_FLOW_NAT64_REGS_MAX; ++i)
+		if (priv->sh->registers.nat64_regs[i] == REG_NON)
+			return false;
+
+	return true;
+}
+
 static void
 flow_hw_destroy_nat64_actions(struct mlx5_priv *priv)
 {
@@ -12197,9 +12210,14 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 				   NULL, "Failed to VLAN actions.");
 		goto err;
 	}
-	if (flow_hw_create_nat64_actions(priv, error))
+	if (flow_hw_should_create_nat64_actions(priv)) {
+		if (flow_hw_create_nat64_actions(priv, error))
+			goto err;
+	} else {
 		DRV_LOG(WARNING, "Cannot create NAT64 action on port %u, "
-			"please check the FW version", dev->data->port_id);
+			"please check the FW version. NAT64 will not be supported.",
+			dev->data->port_id);
+	}
 	if (_queue_attr)
 		mlx5_free(_queue_attr);
 	if (port_attr->flags & RTE_FLOW_PORT_FLAG_STRICT_QUEUE)
--
2.39.5

