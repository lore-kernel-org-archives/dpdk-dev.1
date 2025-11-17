Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B99ACE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 05:06:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E8E940ED9;
	Mon, 17 Nov 2025 06:06:47 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by mails.dpdk.org (Postfix) with ESMTP id EE17B41157
 for <dev@dpdk.org>; Mon, 17 Nov 2025 06:06:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs7mRzNRGDFuHChEnHFFhpQNHeiXaFhYTohk8/5tN5eCbwacMQPxa9NocIR4FwTYMo9p0cx2R+K7q5l36ZM0/2iqKj9oVaRbFSrs0o4JWsIWddKCTmoGFe7b+MarbcqZu8NgsUWtixfVJrX+ztE+HN+095+zQx5bFKHVwAwDERmBd93TE50jNb1bYctnrzgVrHODf692cLqYNBVcQ6MPv8C/I9oPro2lYyb1IDskgJX5K9Mza15eMCbO7jvHoJ7cg9FwnJNfl6ASrENv3a4SovesnwoXH2SGfP+3ZYQLEgxsUZduzNkQJEdaP9YUBLtcEX5BT2PsMS4/OT3ey3vRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMUJ2E54Ll0YVn9Gl7PFhILOtwsKtD/Df/iVakWjFLY=;
 b=OSVH5c8mccQ1TV8J+0/vvBx4yUTdHY7zoZzJuEqMNg6TnaoOKWRJqDcHXtq0r69tJdOJo9P4prURMWl1aPW3SI9pzUfALG1K0H6ROGEQg2x1GR3LZmO1rIB3aufsu15xBqLYg5LLN8YboZMOeqiNKySkD9esCzosCfWdIVczgHVgMbey9KDQz9RV59KQn2ZQRHQWuPnBLbY2C4sLa1SIqWqrZFtLVBTb7sZ6vJJIFd4+5YyYd8QvbMqo+KVp2rChX8JqXDMDTxWKnMg9IDNQkaodKEI4gw0PsRa44h+Cb26+R24Ifht/Z1dOEohMOPgBVN/FvTsQYlTf397QRQWbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMUJ2E54Ll0YVn9Gl7PFhILOtwsKtD/Df/iVakWjFLY=;
 b=ZEasvbSKi5lY+uYUcxlPRRXGMRM1ABHX/yvw2qmVIEO/+aDXp1GVi8cPxHutYS4YFgRsRwyCgMIIbdEBI5LoB19q2cTBhaUVwB7Ne9/apPdTnUf+TghXSikeuwcyXnhytHMEo/75Rks5OEWSKvYl5FBxBzohKFrudThRCLyeM/K2+IhOJSOnYsvL5D+LmqQ1xRjCLYefOAgzzmGp4Amz9MwVuck2+AjX4PQRrcYvcRUlhZJ7jQMa08xEJpDLdV4XzOQzlr4GfyeEHX0In5pM+D8GJv/ohXdyEDFZ80HKEitYY/VNQeBeDdfgIXMeabPlAoKHNxDSF2Ingqs8dVFBJQ==
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 05:06:40 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::e7) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Mon,
 17 Nov 2025 05:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 05:06:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 21:06:15 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 21:06:11 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, Nupur Uttarwar
 <nuttarwar@nvidia.com>
Subject: [PATCH] net/mlx5: skip Rx control flow tables in isolated mode
Date: Mon, 17 Nov 2025 07:05:57 +0200
Message-ID: <20251117050557.8481-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 060c0cc1-8c7c-4eb2-8cf2-08de25971802
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1v5RJs/u//QYE3jTDqsKYGDZMhVLwla/vPJwZP9JeDtBN80PBiB/+AKWXk8R?=
 =?us-ascii?Q?e0kxVKAp1QNJ0saWaMMU4y006H8uT/nK/H4ittirUA9HxfESqa9aW9+njCdS?=
 =?us-ascii?Q?hPDP1bWqoKRDTWifYSrq10d9epamBUZw55hMjBMcjb9m7MLuV7K6VOUhiuXk?=
 =?us-ascii?Q?axIiYYaH7Bx1orE+ghWxLdclSyD8RjS/hBxS+wEZatnEdj2q6ifZ1rwZ0Zk3?=
 =?us-ascii?Q?cmiuwcW3gxjxVKsJN1pV1282K6Xp1AlG9hz5OEva3Bv3BFbj8ijRQCwBiOfy?=
 =?us-ascii?Q?OX/dU08tWA65TDR2pTMZE3uOMDB30fZhevYuBR2Q+owt8dXYwVOCBYvAdw4j?=
 =?us-ascii?Q?CxvFB7xQtMGjnwkphsBK1AqrBnDqle8UIYSamlv8xxByBHYiDiFx2R5gnI4l?=
 =?us-ascii?Q?iEgQtO6d2ISubtHbe0q7jmfztoqnz00MGt+AgObGPv1xRVY4gwGDDFf+Ppkl?=
 =?us-ascii?Q?8pZ8eePrSo8V6llw5N2Co185V3ZpS9FciErOGLyjpRKdIWyKLUKUU814xk0U?=
 =?us-ascii?Q?DsLXwWcN2ibMSkGJXQiyUvNsru6oQAAPJBnugENUJa2FdDxLwBBHZG16fDzO?=
 =?us-ascii?Q?KgiZuhh1owLBj0LZ7JgdiHay0t9dSRYBM5IhaRMOs2LLFDTLH0zFsJI3lWLc?=
 =?us-ascii?Q?jtkayXuqoqpZMHQ5d2HdgAcKZJjSJnqn7b8U5L8ay0ILLlsP6wI8aDyd00/v?=
 =?us-ascii?Q?HzFXC/zRoRMEFo77e4Ms0Sj+k+XOSw/C2YGPBimQSsFlrqWoy+/0jh5I2gcO?=
 =?us-ascii?Q?f7XBQG9FGAtcfJCXUXaii7/sF7KrL7yrwpOPplvTKbsFzX5q8q6TX7wRsP6M?=
 =?us-ascii?Q?JV9z0ENnuuQbNPmFoswkA/qTJAX9RbWd0J/wt0LAPAGtoB3vNKD3bOFhkjiw?=
 =?us-ascii?Q?vq5vNG24ynMeTJ0HLRnG/afftLtEVXWNxo9nbKH3FW1r+7d9LX7oMHBEcAzi?=
 =?us-ascii?Q?/zkf+Pf8MgQUc/wYYZSEHmxtmiP/3/4QVcJ2fNNPkV7/hllQdWiGUQWgkMTW?=
 =?us-ascii?Q?rsENz++yw/p/3Cw8F1M6j9WCsUF77mEdtFD/gKgClcw/fp/QFxNBQr1+wglX?=
 =?us-ascii?Q?Lo9pMUIHqMVmNu+mNOMiI0qCcDNqIz2tgQejovx4KBmIz+HN8Wl8mDS96Qdi?=
 =?us-ascii?Q?IBOhlzodRk5dfSrax5Hg40BiXqKqWz0sp+aydqiFZo3eylRmwE+HA0SX9Xrx?=
 =?us-ascii?Q?oOj7DazQR+Q6HIW/s1dCxzCe35SJ9sPODumKcC02iksBGgcuipLP/lW57ICW?=
 =?us-ascii?Q?4HtkkLw4JPPy9oMvNfhrjUg4Zj3GjMv1OQOiBRF3KZtp+d83nODGdxNgxcw8?=
 =?us-ascii?Q?67ZJahotiMPP5Jn8ti2g/bAxO66O0eWgH9xflOGGRPUOM/t4M2GbdEtri0jD?=
 =?us-ascii?Q?1UWDd1eZzAF5Mbgb1Z4s7Gsb6tnN+cfDupnCvQRIZ63mvJxjMlh+PEzu64Zj?=
 =?us-ascii?Q?IIigYli2OsDz3/yDXuLC0UL+N7LuLG+lfpKnrN4Lr4abduI1D1NW8l4yminz?=
 =?us-ascii?Q?GyU84WMUH4LpL9ap794hyDmpd64gKUK/qzqqzwEIJ3tCaIZ0cbXkoe7H7uPB?=
 =?us-ascii?Q?Wua/PdL6LylFLn0ghRg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 05:06:40.4288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060c0cc1-8c7c-4eb2-8cf2-08de25971802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

From: Nupur Uttarwar <nuttarwar@nvidia.com>

If flow isolation is enabled, then skip flow_hw_create_ctrl_rx_tables
because these are not used with flow isolation. This is used to save
the unneeded resource allocation and also speed up the device startup
time.

Add Nupur Uttarwar user to mailmap in the meanwhile.

Fixes: 9fa7c1cddb85 ("net/mlx5: create control flow rules with HWS")
Cc: dsosnowski@nvidia.com

Signed-off-by: Nupur Uttarwar <nuttarwar@nvidia.com>
Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 .mailmap                        |  1 +
 drivers/net/mlx5/mlx5_flow.h    |  2 ++
 drivers/net/mlx5/mlx5_flow_hw.c | 17 ++++-------------
 drivers/net/mlx5/mlx5_trigger.c | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/.mailmap b/.mailmap
index 50a59a596a..c4cfa2ccc5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1179,6 +1179,7 @@ Noa Ezra <noae@mellanox.com>
 Nobuhiro Miki <nmiki@yahoo-corp.jp>
 Norbert Ciosek <norbertx.ciosek@intel.com>
 Norbert Zulinski <norbertx.zulinski@intel.com>
+Nupur Uttarwar <nuttarwar@nvidia.com>
 Odi Assli <odia@nvidia.com>
 Ofer Dagan <ofer.d@claroty.com>
 Ognjen Joldzic <ognjen.joldzic@gmail.com>
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 83a4adc971..a33a119b99 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3056,6 +3056,8 @@ struct mlx5_flow_hw_ctrl_nic {
 #define MLX5_CTRL_VLAN_FILTER    (RTE_BIT32(6))
 
 int mlx5_flow_hw_ctrl_flows(struct rte_eth_dev *dev, uint32_t flags);
+int mlx5_flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev);
+void mlx5_flow_hw_cleanup_ctrl_rx_tables(struct rte_eth_dev *dev);
 
 /** Create a control flow rule for matching unicast DMAC with VLAN (Verbs and DV). */
 int mlx5_legacy_dmac_flow_create(struct rte_eth_dev *dev, const struct rte_ether_addr *addr);
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e0f79932a5..e34659abe7 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -11257,8 +11257,8 @@ flow_hw_create_vlan(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static void
-flow_hw_cleanup_ctrl_rx_tables(struct rte_eth_dev *dev)
+void
+mlx5_flow_hw_cleanup_ctrl_rx_tables(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int i;
@@ -11543,8 +11543,8 @@ flow_hw_create_ctrl_rx_pattern_template
 	return flow_hw_pattern_template_create(dev, &attr, items, NULL);
 }
 
-static int
-flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
+int
+mlx5_flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int i;
@@ -11580,8 +11580,6 @@ flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
 	return 0;
 err:
 	ret = rte_errno;
-	flow_hw_cleanup_ctrl_rx_tables(dev);
-	rte_errno = ret;
 	return -ret;
 }
 
@@ -11780,7 +11778,6 @@ __flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 	flow_hw_cleanup_ctrl_fdb_tables(dev);
 	flow_hw_cleanup_ctrl_nic_tables(dev);
 	flow_hw_cleanup_tx_repr_tagging(dev);
-	flow_hw_cleanup_ctrl_rx_tables(dev);
 	flow_hw_action_template_drop_release(dev);
 	grp = LIST_FIRST(&priv->flow_hw_grp);
 	while (grp) {
@@ -12138,12 +12135,6 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	ret = flow_hw_action_template_drop_init(dev, error);
 	if (ret)
 		goto err;
-	ret = flow_hw_create_ctrl_rx_tables(dev);
-	if (ret) {
-		rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-				   "Failed to set up Rx control flow templates");
-		goto err;
-	}
 	/* Initialize quotas */
 	if (port_attr->nb_quotas || (host_priv && host_priv->quota_ctx.devx_obj)) {
 		ret = mlx5_flow_quota_init(dev, port_attr->nb_quotas);
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 996c1eb6ac..23b093ca77 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1660,6 +1660,12 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 			goto error;
 	if (priv->isolated)
 		return 0;
+	ret = mlx5_flow_hw_create_ctrl_rx_tables(dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to set up Rx control flow templates for port %u, %d",
+			dev->data->port_id, -ret);
+		goto error;
+	}
 	if (dev->data->promiscuous)
 		flags |= MLX5_CTRL_PROMISCUOUS;
 	if (dev->data->all_multicast)
@@ -1673,6 +1679,7 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 error:
 	ret = rte_errno;
 	mlx5_flow_hw_flush_ctrl_flows(dev);
+	mlx5_flow_hw_cleanup_ctrl_rx_tables(dev);
 	rte_errno = ret;
 	return -rte_errno;
 }
@@ -1913,8 +1920,13 @@ mlx5_traffic_disable(struct rte_eth_dev *dev)
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	if (priv->sh->config.dv_flow_en == 2)
+	if (priv->sh->config.dv_flow_en == 2) {
+		/* Device started flag was cleared before, this is used to derefer the Rx queues. */
+		priv->hws_rule_flushing = true;
 		mlx5_flow_hw_flush_ctrl_flows(dev);
+		mlx5_flow_hw_cleanup_ctrl_rx_tables(dev);
+		priv->hws_rule_flushing = false;
+	}
 	else
 #endif
 		mlx5_traffic_disable_legacy(dev);
-- 
2.34.1

