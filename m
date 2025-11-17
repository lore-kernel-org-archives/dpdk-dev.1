Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B09CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2A684067C;
	Mon, 17 Nov 2025 08:28:31 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by mails.dpdk.org (Postfix) with ESMTP id 848C0402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:28:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKCTiS0gVzp7fsgMblKiRpNdJojulsGO9VYCb7Eg3RXX9WPGh7jPLVBWPwVhRfhuUID3EiicuJHtqy+0j8tIc50LUSzyNbLnc/51cCJ7ho8E/G17Sz/n6zCVq62Lo04CZYxrRsa/dolcioC2b4WcRGshMeqrcYpNJi/6qg94ZxjKQPckWdbkEw+njnvqTT5RGnTTH0+I3Rm0khGCs1YWYizXwkDr5Bcl5PjlMSaWmyoEKJLh1VO9ahjRtQNJGkFX9jipOvGlCRGJjSbx8RphET+Eyd31GdV/djuNP27goly7kLv7C4a1Pibv90umF5wu5tfWt6cAVtavuHM/kP6LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX/ga96MbkvGLxtSbjyMLt0HkilGw9fpWoQujm1MQU8=;
 b=n3oYRLPa/5cBUkrEqlFJwCxEgb/l8OXSKj9VTI9uFfEU+YxSQw7tPefRNyEl+EzrSKnNSR91/n0aQSaBv13lYIbhJUnSxhel7sgRfAFcxXGqt9zFn40YDrGJZ1y8vaxhBTpr0NMLBvubP1yGOhJpRthEWYzmhrsOZFMJfVaFGah2MOx7QhJ1e2f79wjqYbO0NMay09GtbETDf5HfkORtuWP0CbeKYpfPxucZQxjpv6/T0gXpGfScLL2FrQQaRYzgWMRdzxv+kTVqdm4mdb7idp2oJ0XexDP/h99oliTOqlm5858oJVFUg4wScMsHmSeny2iemuifONuFufS5y9Aozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX/ga96MbkvGLxtSbjyMLt0HkilGw9fpWoQujm1MQU8=;
 b=Sa2a4aWBRU/R5Dd/Davz8hzIkKUvcKvm0t8CNGeomuRFDWOOU4TVIxIzJZQrhlwrNM1N7llVrH9V6Aai0w+Rq99xPCW25AdnVkus10NisOrIyKpby1CmJUiOiUfWf70M/zfr9hdbS9/I5YYub260nbJkGUCJZKo9+V5cgskHI3JfkELX1qRGYbr9fV9E+EZHXZne6TPcNkzKrt6YeTpwirEcMZTRFNjSzK1+P/bZqNOEvqJ58HC/HnL+IbtXQgz/+oIm5ZqVSta6XgKvEmKJaZbyOxIQuP3LS7s6+4tX/jxgzlrk8hlwguSQiPybFflf8a5XzOf8sD+Rk3PLjxv1XQ==
Received: from DS7PR03CA0280.namprd03.prod.outlook.com (2603:10b6:5:3ad::15)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 07:28:27 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::8a) by DS7PR03CA0280.outlook.office365.com
 (2603:10b6:5:3ad::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:28:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:28:11 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:28:07 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <mkashani@nvidia.com>
Subject: [PATCH] net/mlx5: move auxiliary data inline
Date: Mon, 17 Nov 2025 09:27:52 +0200
Message-ID: <20251117072752.9290-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 118404da-37bf-4400-fd6b-08de25aae6a4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJMzVQz7/5g0A05NiZCnFsGzC/GG6LhVIn+YZ31aLs+ussS72TIbU9i/vTbx?=
 =?us-ascii?Q?QRBrFTrAHGvXMhAt1tKWvZPBoqYGRpNCpnGZCpYZDo9Ua6M+5+iuBG9AzzgB?=
 =?us-ascii?Q?bYhc4GC2oO6iB2xmc5pNZ67JA0u1HBlSLpKBTJGhgU7Wx9o+JNp+Ml9JANNU?=
 =?us-ascii?Q?n55o8HUxHwhzFEx+tIkbALAIwjsRBfd7tMm6SQZEDD/5ncpUF6XgBd8FEIug?=
 =?us-ascii?Q?JLBQR91ijYMb4pDq1cXLoqYz54S3Z7pM0o01x/7kfcjagsTAad32TcqTjBB5?=
 =?us-ascii?Q?jx8t/O043spiwPXMNpG2lxGqlJisDf52+qnh2cX4t8ttWGjwZ7obf7QTGwbG?=
 =?us-ascii?Q?HHuuSH0+bCaXAlvumqZjyc+O/WJ3i798JfvEtdcFO+Zq23y4KC9MgKVtTxaC?=
 =?us-ascii?Q?Vf6e4zFyuzaafSW0VCQa2IAOkq/1AbzC+IS1lMzsCUP6d9lGtzGPDjhGdyxN?=
 =?us-ascii?Q?TQUasfWxsONPasrKLIFYzXME9zPrTMOLkKdGpcrnS4FzPcheLcWf8tbL0OuD?=
 =?us-ascii?Q?44B6YUSNc3iycigzy6bTh0+YB7EWQBzX6e2JK7Vo4rrnvQg0302SARSJoFab?=
 =?us-ascii?Q?knzmQLw0/9JUwu0hmwhgeBusvrH577gXiFWzCEKH3ZuUhWm/lD93ktN78FoT?=
 =?us-ascii?Q?OFaqKhOl0c4K+cFnKpNCxg0CwijT4LwuOOYTMeo7s7gOIWlRVUNPDnjX4DyQ?=
 =?us-ascii?Q?Pi9kbKJamQrkaibKzBr20R1kvDhMwIE0JLb5kIXR0//8dtJvLcbjZl49ASTP?=
 =?us-ascii?Q?MoVePrD1g+TFzuw7kYRaKa9IMlhIALBK4D87zyDJBSUZk1ZQ+20sKM1YSSdk?=
 =?us-ascii?Q?ybrCiT5nuJ6P9B8NMSN5D0DA5yZwH790Jo3eiqaVgpdA7my4YP/llPrPb0wU?=
 =?us-ascii?Q?iQRnwsWtaz1p/2iLzpPzPIAwGSueCRTlLfj6p6AOiBeULaybmbY75VUA9doF?=
 =?us-ascii?Q?Ce3GZ+9oysazrULG1fC4n3L4dwDx1uWP1dbmAcARNkl4NgtGmHVJkq/jHv9u?=
 =?us-ascii?Q?YIS6KWdXOSLnn6AwVC10k2A3ZvA3pwy3QggYaw0aeH0dx4GVx1XgZRV1Z8Cn?=
 =?us-ascii?Q?Pa7uVRUF7ciBIRksT0b052a65Z978xGJfnBPkLujY3LgCPiaKV7HB7Cy8FJK?=
 =?us-ascii?Q?EmhHyz099IqZnUua0h5bASrvWdZEHZKE8ZYnZIxWkmgObENejJoKmf5wMG29?=
 =?us-ascii?Q?rs9qtonwKn6ZUmSSG9WY9112G37Ept4mFz7muwgUR19ACWY+GuTNMPIQg8X+?=
 =?us-ascii?Q?6SKVBh5LbR/4jhYItuMmq49OpSBinr5pMlyfGAKF+MfXcdLWSXWnbWHgeapQ?=
 =?us-ascii?Q?9ETGb41JxgVYmJdHCarp6hxE4mC4IuOHMyte1YRQZRDV2AeO06BJdV9efNgA?=
 =?us-ascii?Q?JI6d2lP8dZCYwtgGFuIT3sMnue/VZPPSGcUo1X1zorkPusfn/1QZETWcD0ix?=
 =?us-ascii?Q?lmXTuDjMrc7Azf4MmsLIRGQYyAATAo8jbVnH3+fvWwqtXaDdFoult1JktnOf?=
 =?us-ascii?Q?pKE3rnw5p5GvIoTtTa8i6CbyST/fpjdZxOWBf6CS6HhecXBPiIuu/PGUhCuA?=
 =?us-ascii?Q?XPy1BwKwVX4jzGxjnhY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:28:27.5894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118404da-37bf-4400-fd6b-08de25aae6a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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

Since auxiliary structure is associated with per rule, it can be
allocated in the same ipool allocation to save the extra overhead
of the *alloc header and the unneeded CPU cycles.

Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
Cc: mkashani@nvidia.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 7 ++++---
 drivers/net/mlx5/mlx5_flow_hw.c  | 9 ++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 099ab65254..21387346b3 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1643,16 +1643,17 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	/* Read link status in case it is up and there will be no event. */
 	mlx5_link_update(eth_dev, 0);
 	/* Watch LSC interrupts between port probe and port start. */
-	priv->sh->port[priv->dev_port - 1].nl_ih_port_id =
-							eth_dev->data->port_id;
+	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = eth_dev->data->port_id;
 	mlx5_set_link_up(eth_dev);
 	for (i = 0; i < MLX5_FLOW_TYPE_MAXI; i++) {
 		icfg[i].release_mem_en = !!sh->config.reclaim_mode;
 		if (sh->config.reclaim_mode)
 			icfg[i].per_core_cache = 0;
 #ifdef HAVE_MLX5_HWS_SUPPORT
-		if (priv->sh->config.dv_flow_en == 2)
+		if (priv->sh->config.dv_flow_en == 2) {
 			icfg[i].size = sizeof(struct rte_flow_hw) + sizeof(struct rte_flow_nt2hws);
+			icfg[i].size += sizeof(struct rte_flow_hw_aux);
+		}
 #endif
 		priv->flows[i] = mlx5_ipool_create(&icfg[i]);
 		if (!priv->flows[i])
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e0f79932a5..51fa3eafda 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -13582,8 +13582,9 @@ static int flow_hw_prepare(struct rte_eth_dev *dev,
 	(*flow)->nt2hws = (struct rte_flow_nt2hws *)
 				((uintptr_t)(*flow) + sizeof(struct rte_flow_hw));
 	(*flow)->idx = idx;
-	(*flow)->nt2hws->flow_aux = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct rte_flow_hw_aux),
-				    RTE_CACHE_LINE_SIZE, rte_dev_numa_node(dev->device));
+	(*flow)->nt2hws->flow_aux = (struct rte_flow_hw_aux *)
+		((uintptr_t)((*flow)->nt2hws) + sizeof(struct rte_flow_nt2hws));
+
 	if (!(*flow)->nt2hws->flow_aux)
 		return rte_flow_error_set(error, ENOMEM,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
@@ -14234,10 +14235,8 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 	  * Notice matcher destroy will take place when matcher's list is destroyed
 	  * , same as for DV.
 	  */
-	if (flow->nt2hws->flow_aux) {
-		mlx5_free(flow->nt2hws->flow_aux);
+	if (flow->nt2hws->flow_aux)
 		flow->nt2hws->flow_aux = NULL;
-	}
 	if (flow->nt2hws->rix_encap_decap) {
 		flow_encap_decap_resource_release(dev, flow->nt2hws->rix_encap_decap);
 		flow->nt2hws->rix_encap_decap = 0;
-- 
2.34.1

