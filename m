Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DFC28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 08:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B681D40263;
	Tue, 11 Mar 2025 09:32:39 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by mails.dpdk.org (Postfix) with ESMTP id E976F40261
 for <dev@dpdk.org>; Tue, 11 Mar 2025 09:32:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NINbKAZ09dm7WjObcBhow2QtU+AQAWQfru1n7HbTLo672i5IeRAxSEZqrftTSS6JA2uLkRuxPbCYfTG3TBfP+c+2dUeuA8Nra9PdG5lpkTeIufhtaAjMrA87/1iE+RAzxcpJfFVmIMQc0OmAqfb2ZnwRgBTKY9/m/ZE54r8EJ1ZknMTjtztjxqizD+wTfwWo9w84q0T2lRTejUoOIFFNeLs0lbX0SlzC3Zn3MhWsNvtrypyqD3+NZsjwrhA3vsIdGo8KSzV3EhkjFZSJ/xFWAtO/Ks4ab8nRBNY2Lwex6bhrOCFLFIdJz+to6L5ZST0vGdCPEZd3Y9IPs8/biek7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTidGte04XzBHIECAPD/EfQno0jUb1c2ROwGVSB8lVo=;
 b=pJuhbduEjoH0T3ix5DxfeMgp3B6MB08C/q+YX1LUVsEV7/pyDP3wbNcuIQaNVSxsuclrvvpDx7KWwqkBz1sQYV6grOodCBINMlEVBeniIqIbl1RAMvKnyZLlq47LGc+nt/TpH2KC+Gbd7JqVeiZC2IOvvZzwyigSscBAeo6wJcqMm167f833LUCZ1nkHCTaxKCMUqnRWuRJwurznFCIFxKhntkTWr51ZWeFoo068QddiLNsI9pM1AVCP2RF9jGEanpaivoGX9GbiW+/5yyq06g54xCaX0ILBdvBDM6D9GDQVo2Fo3uxneCSF58VPTRGxUOzO+DbMy42EC2CzjdoOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTidGte04XzBHIECAPD/EfQno0jUb1c2ROwGVSB8lVo=;
 b=bkChdXnN0jwPk65aepm4UAl8MLhZu2NtvXhR5xgfuO9Z+QelfoZsBjKjcWP17WGiwQ96G1ct/Op4rUiRuOG+Z8RGGTZMZ/e/ZKaetU1O3Zh2r/XBdC0bzaASGHexqnxxkBskjwmB8vczrmkMJ7ZYKk7HJ/U10421/HDt2Z/r8kg+91MAnFEunkeXxOTj/1Kx5Sb++64PhZu6XwWZ9XuqlCUg6u+xYcY6KLpMmB/Q9+wfHHdhLOZoIUe5FjW2SF8tG1ZeJciDiK8ks/8B7+ZHHo4WQHU+TQ0FjTxrRed3bJPcsphGcfhzR8IyqGKTa1mMounGSn2nudr3trsb87zxtQ==
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 08:32:32 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9c) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 08:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 08:32:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 01:32:19 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Mar
 2025 01:32:17 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: support multi-host lag probe
Date: Tue, 11 Mar 2025 10:31:54 +0200
Message-ID: <20250311083154.1623908-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f83143f-f79a-4fe8-ce6c-08dd607744b4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CZgeXPCEhC6AMJSLPgo3JPgEmnqYiBUfTjg/lb0psEovJoA8YL+xCU2RfZR7?=
 =?us-ascii?Q?VO5QkA7ZGNlTpXkMj1fUWo1gE3An30p3Fmsn7f8Eu75Sqm0A2Qo9x8Y/ohsw?=
 =?us-ascii?Q?G8cUW1dgnWelTHEdlVk88CsrAUn3hm/RMlgC/5Gk3RrigwkEvgAEwVqIRrLq?=
 =?us-ascii?Q?UDyyjVqal/CycA6Q611VFVZT7GIGI/Gh+wrAstBgkM5a1ixX66Rhb3UY2Tep?=
 =?us-ascii?Q?vGzZs0Xzo0kbN87rR7hHti19l34hXCKgshHNQHjZ7RUYjPC7KyZVcsyZTWnt?=
 =?us-ascii?Q?23f+ORolFAPG/Bqw2UuEQ9abI7E+CyTndgHVoBbRt77oAy94JYUtHUQwZbxR?=
 =?us-ascii?Q?ELDsarERQx1Nu6xuW4Ez7dofzxL6Ai26mixosK+rp93KgrW0x4dF9xvSz8gR?=
 =?us-ascii?Q?DBz9rtDe356Emfavn1T6Q5FSzSYEbBShqWdAFBE2JxwO1UqyNCsnDYMllb+x?=
 =?us-ascii?Q?bkVMhVAwl7mxhEfuyGVX0AMoFt0KJCZX9pUUPNZUlM15r3o9YRnoBGs30fu9?=
 =?us-ascii?Q?rkwn2oYGtfMXZig0rDao6ARdUV3BjNLP6absO1dR0LYb7yyaU3se88QZHEWB?=
 =?us-ascii?Q?DyBw4emBwmMut4HPx7T7oTgT2r2FeEVOoYgAnvtIoCFDPmdyozVVPOG6kLKk?=
 =?us-ascii?Q?Ls274R6yntUWb+gbxfTPqMejtPQKqv2jRjBTFtoNYHkEG5pqNu1ASHXCEVj8?=
 =?us-ascii?Q?Bt5X4NKFh8ABBcsjklteZcQbFPZSZNC/YEyLgG+Iu1aT13nd3CHofYPOnjka?=
 =?us-ascii?Q?I4W2DwXuhYf/eHgSXoU2jcxcNzdLBgNRh1J2+ahVH3DZjZaUv23XrAjCmwNQ?=
 =?us-ascii?Q?XbCJaVkgShW6HOVRBuhBfBjUXcyPDkfsQDosCc4+dOHEhnexXpESYrKmohVZ?=
 =?us-ascii?Q?2p6mLLb+x1dIUkgweneIuCaaGn/24hG5VeJHLdaePypcEJMNYqoIt8WOP4lQ?=
 =?us-ascii?Q?lUFpuWVpTuLY69Yfaejl+wCRVldNng5qRBZs173i5Oy8mURinjVV1L/ARQUb?=
 =?us-ascii?Q?TTjZzeX3YcXR9c/YSccIa3XkiGlW8+ZxzoXeKmStOtQvhYtQJCIWA3kdhr8V?=
 =?us-ascii?Q?w2vKrW+frAH+w7vEacbigaMf9VOSUNxVr9YBsM/6D9Nspcx9yDBJgIkhU3R3?=
 =?us-ascii?Q?tECUcgNkn4En+9y5/9czNUGNahUoimaS5ltJkVKKe3ry8m6pwNUMuFd/5h48?=
 =?us-ascii?Q?2v1HHXKVWtmnxfCVfd5FfzXDto0xM7M6sWNy1ODcy2ayr+DfgJ1BigBwx+eQ?=
 =?us-ascii?Q?eo5VROL57QvtLS1Zt3sssooFvFtyPhk8vFkW+g07/rPw1xYuXZ8etVYoCAL1?=
 =?us-ascii?Q?lQf6A9DhB9vSOXMvKulpuDoBhnIx0fgienVcuJo7WCqS3SEkpdpiN7EQmY82?=
 =?us-ascii?Q?SZB755tU90gRM6fpctMDcv+TIVuGSGB67hxhyviffZRsgPi/JidJdn0F9m1u?=
 =?us-ascii?Q?XCWu/bc0Vx4ae707tfa76BtTrk9sdpZkxSszmHQBJz6ehjkizPbiAJ7Tx1Ec?=
 =?us-ascii?Q?QiMBf/wbfJgxGsc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:32:32.5927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f83143f-f79a-4fe8-ce6c-08dd607744b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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

Under multi-host environments, the NIC exports total 4 ports,
and each host get 2 ports. The 2 ports' identifier is uncontinous
now. It causes the lag port array access violation.

Increase the lag port array and allow the hole in middle.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 60 +++++++++++++++----------
 drivers/net/mlx5/mlx5.h                 |  2 +-
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index e192f698d8..9daeda5435 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -644,9 +644,9 @@ mlx5_dev_nl_ifindex_verify(uint32_t if_index, struct mlx5_priv *priv)
 
 	if (if_index == bond->ifindex)
 		return true;
-	for (i = 0; i < bond->n_port; i++) {
-		if (i >= MLX5_BOND_MAX_PORTS)
-			return false;
+	for (i = 0; i < MLX5_BOND_MAX_PORTS; i++) {
+		if (!strlen(priv->sh->bond.ports[i].ifname))
+			continue;
 		if (if_index == bond->ports[i].ifindex)
 			return true;
 	}
@@ -1399,7 +1399,9 @@ mlx5_os_read_dev_counters(struct rte_eth_dev *dev, bool bond_master, uint64_t *s
 	/* Read ifreq counters. */
 	if (bond_master) {
 		/* Sum xstats from bonding device member ports. */
-		for (i = 0; i < priv->sh->bond.n_port; i++) {
+		for (i = 0; i < MLX5_BOND_MAX_PORTS; i++) {
+			if (!strlen(priv->sh->bond.ports[i].ifname))
+				continue;
 			ret = _mlx5_os_read_dev_counters(dev, i, stats);
 			if (ret)
 				return ret;
@@ -1449,28 +1451,26 @@ mlx5_os_get_stats_n(struct rte_eth_dev *dev, bool bond_master,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct ethtool_drvinfo drvinfo;
 	struct ifreq ifr;
-	int ret;
+	int ret, i, j;
+	uint16_t *target;
 
 	drvinfo.cmd = ETHTOOL_GDRVINFO;
 	ifr.ifr_data = (caddr_t)&drvinfo;
 	/* Bonding PFs. */
 	if (bond_master) {
-		ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[0].ifname,
-					   SIOCETHTOOL, &ifr);
-		if (ret) {
-			DRV_LOG(WARNING, "bonding port %u unable to query number of"
-				" statistics for the 1st slave, %d", PORT_ID(priv), ret);
-			return ret;
-		}
-		*n_stats = drvinfo.n_stats;
-		ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[1].ifname,
-					   SIOCETHTOOL, &ifr);
-		if (ret) {
-			DRV_LOG(WARNING, "bonding port %u unable to query number of"
-				" statistics for the 2nd slave, %d", PORT_ID(priv), ret);
-			return ret;
+		for (i = 0, j = 0; i < MLX5_BOND_MAX_PORTS; i++) {
+			if (!strlen(priv->sh->bond.ports[i].ifname))
+				continue;
+			ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[i].ifname,
+						   SIOCETHTOOL, &ifr);
+			if (ret) {
+				DRV_LOG(WARNING, "bonding port %u unable to query number of statistics for the %d lag member, %d",
+						PORT_ID(priv), j, ret);
+				return ret;
+			}
+			target = !j++ ? n_stats : n_stats_sec;
+			*target = drvinfo.n_stats;
 		}
-		*n_stats_sec = drvinfo.n_stats;
 	} else {
 		ret = mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
 		if (ret) {
@@ -1726,7 +1726,7 @@ mlx5_os_get_stats_strings(struct rte_eth_dev *dev, bool bond_master,
 	struct mlx5_xstats_ctrl *xstats_ctrl = &priv->xstats_ctrl;
 	struct ifreq ifr;
 	int ret;
-	uint32_t i, j, idx;
+	uint32_t dev_idx, i, j, idx;
 
 	/* Ensure no out of bounds access before. */
 	MLX5_ASSERT(xstats_n <= MLX5_MAX_XSTATS);
@@ -1734,8 +1734,15 @@ mlx5_os_get_stats_strings(struct rte_eth_dev *dev, bool bond_master,
 	strings->string_set = ETH_SS_STATS;
 	strings->len = stats_n;
 	ifr.ifr_data = (caddr_t)strings;
+	for (dev_idx = 0; dev_idx < MLX5_BOND_MAX_PORTS; dev_idx++)
+		if (strlen(priv->sh->bond.ports[dev_idx].ifname))
+			break;
+	if (bond_master && dev_idx >= MLX5_BOND_MAX_PORTS) {
+		DRV_LOG(WARNING, "port %u unable to get the primary lag member", PORT_ID(priv));
+		return -ENODEV;
+	}
 	if (bond_master)
-		ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[0].ifname,
+		ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[dev_idx].ifname,
 					   SIOCETHTOOL, &ifr);
 	else
 		ret = mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
@@ -1772,8 +1779,15 @@ mlx5_os_get_stats_strings(struct rte_eth_dev *dev, bool bond_master,
 		return 0;
 	}
 
+	for (++dev_idx; dev_idx < MLX5_BOND_MAX_PORTS; dev_idx++)
+		if (strlen(priv->sh->bond.ports[dev_idx].ifname))
+			break;
+	if (dev_idx >= MLX5_BOND_MAX_PORTS) {
+		DRV_LOG(WARNING, "port %u unable to get the secondary lag member", PORT_ID(priv));
+		return -ENODEV;
+	}
 	strings->len = stats_n_2nd;
-	ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[1].ifname,
+	ret = mlx5_ifreq_by_ifname(priv->sh->bond.ports[dev_idx].ifname,
 				   SIOCETHTOOL, &ifr);
 	if (ret) {
 		DRV_LOG(WARNING, "port %u unable to get statistic names for 2nd slave with %d",
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 545ba48b3c..6264595d8c 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1322,7 +1322,7 @@ struct mlx5_ecpri_parser_profile {
 };
 
 /* Max member ports per bonding device. */
-#define MLX5_BOND_MAX_PORTS 2
+#define MLX5_BOND_MAX_PORTS 4
 
 /* Bonding device information. */
 struct mlx5_bond_info {
-- 
2.27.0

