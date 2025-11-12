Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D2CD13DD
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 16:25:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D99040A73;
	Wed, 12 Nov 2025 17:25:25 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by mails.dpdk.org (Postfix) with ESMTP id 3F1D3402AF;
 Wed, 12 Nov 2025 17:25:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+SHjLYg9IOatPOSIS4Zabk1xflIy0H4wRxoWOJRxSYg4c+J9JZ4v4+BZ6csMBmDiUP8HypXV+6vTvG9ub8b8tcCHzf2bw+BN5JmPA+XPhMOObEA703VQQ1zgjrfxIpwr02ayNUzc+Lw3lKBWhisTuEvBhhVZvvTVIIm89f0MdovrBeM4fRO4OyhVundPUS+69PBJyCTDvdwyEEBQ3AlG7zF7v4J+2Zx74XPS/6nFXu7GUejGYBCByAYrx7K5aC8kEFhSVussyN+JLeRIUCoaPqfzzGYnAiYrWvVId4BVO3QhkBcDMRKxoMaHWyasxJ18x84WvBEpKfGqyxh/7lQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RLPq8a3iDlZqNTCKGK/rl4+GkzRTx/zAaJOCxDLTlw=;
 b=CB953iCvwkzYCfgCltjITITdhfjdy49gqJh8yh7hhOxWDTKUdpEcW++DNiUx2Y1KV/3N62WtKzF5V3e9UWUyEXVfM5Q5in0Zp9JZr1Uhx2RJw/CtRyiGsjuXH55rRoMhcnG/CHzx6ROwJPaQQWAQRWSkHqT04dXztKFMuxfxne4Fd8qJP+gPkplQqrGB1vVwLS7lJEulHks4MuNtFey12GW/GNjMTDeEhCHEl2wXPR+eHUJQFsiIlVhL3hE7RxGvCyB0m6e+R7a0u1om4kUc7qmHBnDMJY2JgOuhbi6/RebuC4dNhFkAUcuXus+6+M08Nu4olpisgJqg7VB4u7SKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RLPq8a3iDlZqNTCKGK/rl4+GkzRTx/zAaJOCxDLTlw=;
 b=b+F08JqP8akfIQYTQZK+Y9nf9lu30K6NPH+DWyzVIPYxuh/wcAxeixp1QVFNixfXhZZacKuoMBSFZQjZ47HMsKit58BMHaUsfj2G7S+RST9t1+2VvxHbb82rt2Uq5hXgp0cGNRrs6XOpl33x0BagCq4ZSVEiEs6EytwfDHAwddyXLSS7ksD3ceW/A4m+Huo3bmGDHRNSwnVMT/jvAWggvlJqkjqr0Ye5MNC+N5lfxBDBVoQ+4x6O64WtXU5E9YniSZKSjkxLu9yJ3Y47pS51aAzGjQSVBgMcfBjqIw+9IJbGuay1yCExcJVg1wMtXbt1wd83bR9jbV2m3jQ8Ugp1Rw==
Received: from CYXP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::16)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 16:25:19 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::b9) by CYXP220CA0004.outlook.office365.com
 (2603:10b6:930:ee::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 16:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 16:25:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 08:25:02 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 08:24:58 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Savisko <michaelsav@nvidia.com>
Subject: [PATCH] net/mlx5: fix send to kernel resources release
Date: Wed, 12 Nov 2025 18:24:40 +0200
Message-ID: <20251112162440.425611-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c7ac5c-a419-4ed8-ccd4-08de2208126e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6Z/TWfmt8LUoVC4U9zbHe1dufWiFpR1hbqBSW0HCXbO6YjdAh8O3xlL6FEl?=
 =?us-ascii?Q?kVwkFVPpo4sN/i7EqtlGOLN5jLf08vN7dgl7ZAR5LOIbVMyZf3Hj5ikAw8cT?=
 =?us-ascii?Q?ypIuqtw3QbewEkI4ZEe7vCPegyB3SnGi3XVCANqQ3vB4Y+DZm64eC3WGDDws?=
 =?us-ascii?Q?xSjMh4hpBjYOp/4gg7t8E8rdknaGM2z14XRrQkuuLmRjI7kJv/WBC5pT+2+g?=
 =?us-ascii?Q?np8dbq4nqbWuRhsitSq5i/iqM1zISeSbLhU7iOJKRZBsFIXMQwGlu8g3Haqf?=
 =?us-ascii?Q?oPboXaCC0JLAtQqpr5R3WPMvz5Dm1jHVFDZBfyR9RDIx8bxduOxzSAb+diSe?=
 =?us-ascii?Q?MSNa9bgo8BrOIwc2GW2yOnocmhpq6ANJlz8mJsnP64AmsF4tXoEPvGLAmkq/?=
 =?us-ascii?Q?Dpa0igS3flJfjgjyvM/8bcthHg3IAIApAMNaQR9aPQArlzVFT40i/E/an/Nv?=
 =?us-ascii?Q?D1Q1PFlF5/RETQ41KLW6r2Dv7M2KSEXHSL/UZM0GNEIuc0TGwimh8pe/LL8X?=
 =?us-ascii?Q?nILNQobkzWHoohiR1F7O4twGhrmOwEg9wPCN/R2yJGwkmp+4ewnf4YZosOA5?=
 =?us-ascii?Q?6iMi6A1RGVLPtcsgsV8l5pJDUPGN1hQRyIHOd+W9CuLQB9X6SaYJC7rosVtr?=
 =?us-ascii?Q?kOv4kkfCl/KfosUXBhOGAdp/nx5zqoCZljBT7a5kUMK2vfpx37JChTNBO0Za?=
 =?us-ascii?Q?tI7ts9ttuyTUlSI574YafMbr6fkbgc1tIAPUosXQezrHMYSl0ZY4PXzdqFuB?=
 =?us-ascii?Q?MkWVv4wuAA9tm918NCMZ5hzd/FoEGvB4dikkzX6g86EUowt/Pebjp56tIJ05?=
 =?us-ascii?Q?lyLPKl/TMp0cAsUWHfxvjllMIveYL5fF1DYMQUaal7+tZsXA/c13eRs6TUcx?=
 =?us-ascii?Q?LGntvfU3KD46huejdaUfA9ixj1iOxX0zwWPiV6818IOGH1BZGwItC2R8eRZe?=
 =?us-ascii?Q?cA2qgW3hdRq3B62uOnh7gQd4J1gAWWUiSThEDMTMSzk822XElrqL4l8sYd1E?=
 =?us-ascii?Q?I+S7nCK3mtZtK9qrehnVGge6bKMf3kU8COhvFxG/bz7JEkinhWLVc12tWVZT?=
 =?us-ascii?Q?2qCyDJ2VUU9zcdnZsvpLolVQFi6J5rIhXeFzwp8vYe0oAXw1qg6PH0sKc5Hh?=
 =?us-ascii?Q?omoLS3d9XbIQnDfXt+OvLlkDuPAbucPkxK3KJb7uhg7sUy5o8BsKNGsXNsLV?=
 =?us-ascii?Q?J02OIqX0lNsYkMkgJXbLO87VyouMOCg8vYAt4M0li6jVDMNPWgNqnckiji10?=
 =?us-ascii?Q?jYV4oZlRLOXyk4pMtHXE7PN5c6Shk62k4OKZaud8X7RYKysWJLOjdU0rpcoR?=
 =?us-ascii?Q?mynhcBx6krRaTDjXwW1Bw8AKjrGnS/Azjki8m2P2hjtZKCODK+F2ZuXyyxdZ?=
 =?us-ascii?Q?PzmVfXmswBeQpekFsrBQa2X9RrJacaYFCDw/DVLYli8tZ7GOZ6g10IuJKXVj?=
 =?us-ascii?Q?cLAiTpPkWw/SFQfemiyKjiEAYd4+ZUAIdVAoyawBrmINdjdiaZ4elU/CEXZo?=
 =?us-ascii?Q?S9doryOVjNqCREfCA702ehY0MvFZK2fTYnbnt6VZQvLpMKsPqmaozhO3X+Wz?=
 =?us-ascii?Q?E6pz+wmrHz9Wrm2z0nk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:25:19.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c7ac5c-a419-4ed8-ccd4-08de2208126e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254
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

In the MLX5 PMD hierarchy a flow table is bound to a domain object.
A domain object can be released if it does not reference any flow
tables.

When the PMD creates a send to kernel flow action, it also creates
a dedicated flow table for that action.

The PMD called for Rx, Tx and FDB domain destruction before it
destroyed send to kernel resources - flow action and flow table.
As a result, domain destruction could not be completed.

The patch moves send to kernel actions and tables destruction before
domain destruction.

Fixes: f31a141e6478 ("net/mlx5: add send to kernel action resource holder")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 40 ++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index c742e0f282..099ab65254 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -737,6 +737,30 @@ mlx5_alloc_shared_dr(struct rte_eth_dev *eth_dev)
 	return err;
 }
 
+#ifdef HAVE_MLX5DV_DR
+static void
+mlx5_destroy_send_to_kernel_action(struct mlx5_dev_ctx_shared *sh)
+{
+	int i;
+
+	for (i = 0; i < MLX5DR_TABLE_TYPE_MAX; i++) {
+		if (sh->send_to_kernel_action[i].action) {
+			void *action = sh->send_to_kernel_action[i].action;
+
+			mlx5_glue->destroy_flow_action(action);
+			sh->send_to_kernel_action[i].action = NULL;
+		}
+		if (sh->send_to_kernel_action[i].tbl) {
+			struct mlx5_flow_tbl_resource *tbl =
+					sh->send_to_kernel_action[i].tbl;
+
+			flow_dv_tbl_resource_release(sh, tbl);
+			sh->send_to_kernel_action[i].tbl = NULL;
+		}
+	}
+}
+#endif /* HAVE_MLX5DV_DR */
+
 /**
  * Destroy DR related data within private structure.
  *
@@ -763,6 +787,7 @@ mlx5_os_free_shared_dr(struct mlx5_priv *priv)
 			priv->dev_data->port_id, i);
 	MLX5_ASSERT(LIST_EMPTY(&sh->shared_rxqs));
 #ifdef HAVE_MLX5DV_DR
+	mlx5_destroy_send_to_kernel_action(sh);
 	if (sh->rx_domain) {
 		mlx5_glue->dr_destroy_domain(sh->rx_domain);
 		sh->rx_domain = NULL;
@@ -785,21 +810,6 @@ mlx5_os_free_shared_dr(struct mlx5_priv *priv)
 		mlx5_glue->destroy_flow_action(sh->pop_vlan_action);
 		sh->pop_vlan_action = NULL;
 	}
-	for (i = 0; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if (sh->send_to_kernel_action[i].action) {
-			void *action = sh->send_to_kernel_action[i].action;
-
-			mlx5_glue->destroy_flow_action(action);
-			sh->send_to_kernel_action[i].action = NULL;
-		}
-		if (sh->send_to_kernel_action[i].tbl) {
-			struct mlx5_flow_tbl_resource *tbl =
-					sh->send_to_kernel_action[i].tbl;
-
-			flow_dv_tbl_resource_release(sh, tbl);
-			sh->send_to_kernel_action[i].tbl = NULL;
-		}
-	}
 #endif /* HAVE_MLX5DV_DR */
 	if (sh->default_miss_action)
 		mlx5_glue->destroy_flow_action
-- 
2.51.0

