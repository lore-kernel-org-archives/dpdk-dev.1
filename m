Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D6BCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACF0342796;
	Mon, 17 Nov 2025 08:39:58 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by mails.dpdk.org (Postfix) with ESMTP id 42C42402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:39:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeObfnbrlMHfOqPDBX1yteHAzbXyE7M9ZaFN6RXrlS/Pglsx6al5nhJpNAd4etzK4TVGHPLKdBO9837x5tMiy6BfGq+O6BU8Mbo3WiHpHVcaF9I8fYpZJC6p5608j2p3ZI4Llr5qM3Moqh21jzDlcMxib15loSsebOPD0yYRk0JMaQXUAEXNZxOOFjxp+kGEF/pre/btIT3E1g1zhIIpyhh63A7TRYx5c/eF5N6OMk/uZTwff6LcZv+PFOrsKi8lIL7BsWqY3y+y0RFrdvdx8o2NUQ590AVmtlLmd/FEyBGuleNFgT0OKa+yTxRxz9K16QgXPZwrS257qe6sq8TgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4BL95yuFaMQ3qVCrVqFy6+f5O2y5ndAC7P7kPT67nI=;
 b=fCjFTQrr6nIotX7KP5vl3vUbIs0p7xPAfyILYfHn+9QrEY8Q6gMZgrUvjsnsqI01LEYAcRaiokJa+YMcWpoqvb2zyUAEl90JeOl4xfvHa7ke1QMLlYU9G5kt+t8JqZYMy2IYL403adNjShSSUAx54HVMJW3ckZZ2jJIaPHSfQzGiNp5dmJyrJk4VJQJUcjZETn/8SLpK46pHLFLoHnR5e63RHDmBAuzHR2PJf45S4oYHJDouY0hH+ZK7gtB/SLaRE5r1DXdL0Mo8TU0AfKVFzyawoH3+QUSJNO2qtIq7A7EXJANJLL6LUx4LOPndRGOqw561Zz1napbYzat9sio9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4BL95yuFaMQ3qVCrVqFy6+f5O2y5ndAC7P7kPT67nI=;
 b=XjWxLiH4VAuNm+PfGrlR4BYL4QDT471Pr5gnWfzdxiYdT7X3X0vDp6hs1sohqLhCmQIFrFnUN5xljvagcG0w7W+pW28pkmvvUsQ/eIutyXXVlsxy6MUnJ05vVQB326mxQYWkwqOR6o5t2AeO8l2DcaK+3O29UE6bH8mW3V6SkGVt267S5iwfIieiPYyu81BcZcvs1MEYWg1tpEXknVIHtyddHcvG5cu3LKkHnI1NVndVmQvQlZ+l14lhTJ4wS1BGlNNpYI97DlfJGaGiNLr9sFmx3763tuT9M69agxI9LFs1u1fRfqXdL0CKPfiB6cuaAtnPHYEpV4Kaceq9h/bk3g==
Received: from MN2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:208:23e::30)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:39:53 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::60) by MN2PR14CA0025.outlook.office365.com
 (2603:10b6:208:23e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:39:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:39:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 23:39:43 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 23:39:40 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH] net/mlx5: update stored Rx queue MTU when port MTU changes
Date: Mon, 17 Nov 2025 09:39:36 +0200
Message-ID: <20251117073937.1514124-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cf27ce-618c-4fc7-4846-08de25ac7f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VniL842hmGx6mKRiBDYozOMkR8hxcpRULU44jKfdUpO+U4zVHCzUSBGX+Gwb?=
 =?us-ascii?Q?uCLiUmXqHmD46PQfk+/+kiUYZAmXJ8Cg2LV1PLgAqAD1SplrYyU/Z2LTSOpq?=
 =?us-ascii?Q?VcQkt3oH7LZyZKpWtpU1I7zSNVsr7DTR1ugsaDU4xry03Yu/27ybuYEue9NR?=
 =?us-ascii?Q?ppi2bBJbT9pyMzrcNlKlBkIVhNbu7qPQ9wZFGCNg+NHFP/ZEDH+OqIaNaUqk?=
 =?us-ascii?Q?TQA4eHj63I4pQmt2vokpGTmN9G9OYPinzXxaDjs+tlS/z/dqmK35HztWU1Cj?=
 =?us-ascii?Q?oWpuInRMSr9X+9ireyXP3+P34F8zKTheUUZtQQ6JGhEnpiWQ34ISPjEEySvF?=
 =?us-ascii?Q?gGTfs2iIiM0rjDMwn2MvTPkfZe102dvTmYu7O3cA9g5YG3TyGGcRSUb/TKDw?=
 =?us-ascii?Q?211FjMoKuynib49Sg817LOZZ83UoxJchXGhWa0C8PoV4T0G63iRJX/UeLz4B?=
 =?us-ascii?Q?VWx2xcunx5Dfrb2wAiSGgDXyyKvEdlRYTdhlJJ9qHgt7JDsLJ68QPeztnWbh?=
 =?us-ascii?Q?i67WI8A+wKD+DBcbDrQBx+Xe1d/KEUD6w8AHeYBwIWSpxfyi6ciktLYU2+A2?=
 =?us-ascii?Q?Nc0dUqp5HKx2St/+BPnAFO32EVsHa0LsgnTVdO5sXWBGGODOp0IeknEXdv4H?=
 =?us-ascii?Q?ckUz8mez5Jg31MdSj0OKDQDVCUH10a285kL3NX1LwpuXQSwp+FQUa+QPni5w?=
 =?us-ascii?Q?Z7aFv61byKkwvUodMDc9/wrVMrLT3HktJ+5rhcd4CsbFGndCqDJRMO44WR8W?=
 =?us-ascii?Q?9aMpV2lsbCfibMlPSAghU6orjM0Z5ih8QZAHPmhiKpKc36ZLP3ZDb/bN3xgm?=
 =?us-ascii?Q?qveajqa03Da6fHPpr22/VPSghHgsGP6wdzHtnD4+QFZd/T+GNa2BxVutu8Ts?=
 =?us-ascii?Q?oL8CIM4e+gv64JKDql3Pr3PtHfARFX7g0Tgd/FvVu8J6bSsxG6mAoVSaaP2t?=
 =?us-ascii?Q?gDm+qcl17mN9EZ5SVlO57LM8wYwgS7X7ksmLaRBGdKr31F/VC3+ILQBwRGjS?=
 =?us-ascii?Q?5GvVe2s9gCavsGn1HPjTC/D5VQBtr/SVcxfbKDfkfczr/DN1ED6n9Mp687C2?=
 =?us-ascii?Q?nP+NiKZWTYxBqzVF2nFt5wFv+UuTPdBssSsniJrDLHfkTjQHvB8SW4sPCRRL?=
 =?us-ascii?Q?QVi+b1dr0NNwXSvdw+yvHCml+EUieMdUx/0FJeGT1lu5EbriYi9j1Uod3NYa?=
 =?us-ascii?Q?pK+MjwHssAGxtviGTbWgswNfNWHymNknFcPMxfzY4TaSP3wE08Pwaldwcdw4?=
 =?us-ascii?Q?XwUMO7yLhzT1i/0Mm6nkI42UHpYClW+G4xLk94npzYwyULX6IZRcoVN9PiyT?=
 =?us-ascii?Q?7HGayNZIrFKMErLGWce4PD55gy/xaDoOL+fW6RlKiOpccMQtcAD+xlVPLin5?=
 =?us-ascii?Q?e4Ai28T2sRokWqYxizMg5NIsXugPd9GW+HHwtDSOfZ68EhMiw9/Hbv3L3ye0?=
 =?us-ascii?Q?A+o1KoGZY9A7gcaIJUnQ03THpEGSw5+CTwG/un5FYQzzlkOJu+ZiIUl+LUAU?=
 =?us-ascii?Q?XArOHvbsqo/ZG6+9JFjXOJPnzb1NBlQP/Yc1Vk5O/oXM75mSsYWz9BFsfc+l?=
 =?us-ascii?Q?gYya53ppRhfhLUEoUA4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:39:52.8705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cf27ce-618c-4fc7-4846-08de25ac7f1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
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

Offending commit added rxq_ctrl->mtu to track MTU at queue
allocation time for validating shared RX queue compatibility.

When MTU changes via rte_eth_dev_set_mtu(), only priv->mtu was
updated, leaving rxq_ctrl->mtu with the old value. This caused
shared RX queue matching to fail with "mtu mismatch" errors when
ports reconfigured (e.g., enabling buffer_split offload), even
when all ports had identical MTU settings.

Update rxq_ctrl->mtu for all queues when port MTU changes to
keep metadata synchronized with actual port MTU.

Fixes: 4414eb800708 ("net/mlx5: store MTU at Rx queue allocation time")

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_ethdev.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 7747b0c869..7bec64c847 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -676,6 +676,7 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	uint16_t kern_mtu = 0;
+	unsigned int i;
 	int ret;
 
 	ret = mlx5_get_mtu(dev, &kern_mtu);
@@ -684,6 +685,17 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 
 	if (kern_mtu == mtu) {
 		priv->mtu = mtu;
+		/*
+		 * Update the MTU stored in RX queue control structures.
+		 * This is necessary for shared RX queues to correctly match
+		 * the MTU when ports try to join the shared group.
+		 */
+		for (i = 0; i < priv->rxqs_n; i++) {
+			struct mlx5_rxq_priv *rxq = mlx5_rxq_get(dev, i);
+
+			if (rxq != NULL && rxq->ctrl != NULL)
+				rxq->ctrl->mtu = mtu;
+		}
 		DRV_LOG(DEBUG, "port %u adapter MTU was already set to %u",
 			dev->data->port_id, mtu);
 		return 0;
@@ -698,6 +710,17 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 		return ret;
 	if (kern_mtu == mtu) {
 		priv->mtu = mtu;
+		/*
+		 * Update the MTU stored in RX queue control structures.
+		 * This is necessary for shared RX queues to correctly match
+		 * the MTU when ports try to join the shared group.
+		 */
+		for (i = 0; i < priv->rxqs_n; i++) {
+			struct mlx5_rxq_priv *rxq = mlx5_rxq_get(dev, i);
+
+			if (rxq != NULL && rxq->ctrl != NULL)
+				rxq->ctrl->mtu = mtu;
+		}
 		DRV_LOG(DEBUG, "port %u adapter MTU set to %u",
 			dev->data->port_id, mtu);
 		return 0;
-- 
2.43.0

