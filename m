Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA6CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Oct 2025 07:24:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16261402D1;
	Sun,  5 Oct 2025 09:24:08 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by mails.dpdk.org (Postfix) with ESMTP id F1806402B9;
 Sun,  5 Oct 2025 09:24:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rnlew3MZw+8Q5eLRWdYLg11BSp53kD3r9CY9cDJxPs131ubyNPAd8hcHcs5QHW9sE6totBNOpNTRF6mVtz/6PI4E7DzaUNcOmFGHsnwZG515bMHeldQktffbIXU/tAhraY9VQkc+/81dVGkmakXlJit0JfCFuX0RKQcva+zEqIdtQ+u5623LMUVKnLBza8AfqhlPIHmR6ARmGb/LJqaBdXC3cPbJSHFxebdzwgMB4jt1T+xItrJW7jLAXY8SFVAdj97RJ8dlRbtDqeOQjeUr5eiVqruqU1y1m2ZIkwnGH6J4rqf6UDVw8xF+Z0B6bVMzOijosE19AyXOMWrBUA754A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjmku4dhxR15odlYH3sWxAuj7GqRv/kdOfhz/sJFWuM=;
 b=cJFTjD6HuK0EWvofsuE2pU5Uglbl+idIcBHTVzcddlgYZcf50okl4j//7KOPWGUUNvRvlGZYGLUjyRijTEfoAqUZjSrEgYldUvg3o+gl33WT4qRYxekT26wzR6dfaLeKWpLWuRR036JKlpwiOw35LIChCLdRboj4D7e1VjPCokUN4/cUOw/e58p+YIRvd0k3tbUlSxzP0W/7nUWFaAtafLB/+Ek1/oMeY+B0Nj9v2azO180d0fnX4UEFoizQaZ9HW03MByB2b70WvsjQ+/1etSTB6E7NfCt8pVD7UKGjqgILZgp110g4Gz5SPbrApAgUZ80JSS7XMVptHbixz0Amdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjmku4dhxR15odlYH3sWxAuj7GqRv/kdOfhz/sJFWuM=;
 b=JoNgV3a+HLU76rc9F7f8rN+I4zQUqCT3pBrnQjRSAUuYNaywXRKyiTgfn+mAVc/Ts8lVBLLaQXOnrpiz6YDZxOTmY4H9UmIsDHupyw4ehWBIgrOqLXvCzb+vUVftjMdzo3ZW7xUTGdeviqxHEOvWu2sFT+rNqp7lspvvvIgM/hZNijjXqOwjgmw7z7lTcE40a1fp9QQ30dzooJhynahGd0YWaht+5wUWm9vqUpSPZPu0u0yayNrZtMHeOqmwDTK+V29cnoPci2o6n2ZMS88F5KGACrL9q0P3lomF/lAV7/4XmWEVJlJsMWdMO0EaNQI+S9Sq2Xczw3CQbFttihgznA==
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sun, 5 Oct
 2025 07:23:58 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::68) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Sun,
 5 Oct 2025 07:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Sun, 5 Oct 2025 07:23:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 5 Oct
 2025 00:23:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 5 Oct 2025 00:23:53 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 5 Oct 2025 00:23:50 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Roi Dayan <roid@nvidia.com>, 
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: release allocated indexed pools
Date: Sun, 5 Oct 2025 10:23:45 +0300
Message-ID: <20251005072346.66007-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5def0f-018f-4825-3a58-08de03e0261c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uG7Ikls9mOZ3seUhLh9Ft02kqN+y1Uzod9sWbjzS+SnboY+XtMiDTSIgjehU?=
 =?us-ascii?Q?Qoql+hHurVGV/vpTwh7KQZbYkEZYcPq8IIkQW21FmjynrCnsNmsFbqbgqFet?=
 =?us-ascii?Q?l90WR/rhdUplJ1jvyGEKbI6lfzo1884DVM+nO6+HDsHyEgoKuP6p16eU02P4?=
 =?us-ascii?Q?mOlE+8yWcvmyGiYVKNSCeWywWpH4J5/nDl5qmPZt+Fy8JrUbRk0F4tN6jVHW?=
 =?us-ascii?Q?h4zAUv/MJj2eTZa3A6Wbs0yZB/FPA4zD2rJsmqQU6WGm2KnGppg1mA6QM7V3?=
 =?us-ascii?Q?uCGNpyXFbKCa7jSyaV3d729t2vgIylilm0BUDuzZwOFO9i/Xgz5KiqaElETF?=
 =?us-ascii?Q?yQ2aAHbQXdyW57fDWMbFrbQOnG+WJ8r8cbq/LDN7+lcfx9MJuAYAETrFl4ou?=
 =?us-ascii?Q?uOWugqgF/7bHZQ4rpwlDcuFPcbxFIWbbv0NRYgtIvhJ2mw6Hoi8s7ZrQ8ZiN?=
 =?us-ascii?Q?pHwkc56RQfEKKOWkGRniaSPiFx9VjQ6GAkT5Jw2TCw5ibjz/yDz1f/XzzLRm?=
 =?us-ascii?Q?Kzff+tbKKKFmwkF7rW/Gu7LbxSvQd71Q6qoLe2r5yA7Jbqr+F/jmyQslfLLq?=
 =?us-ascii?Q?9sRNB+1RCgVlvMPgzZ8tGsdIhpjttQVNCuoTDLGO7jO4ZlnkH49tq039VF9T?=
 =?us-ascii?Q?nJC+OTgIf2uI/ygkgE5C/4R1OcB0E6kPiA8fGgVpgKjzzGIPOrGJem58EvdY?=
 =?us-ascii?Q?xO/Z3J2Bt7VuwyTy541K923BOswQjMWdTDK0FZJOlBKVsgbbtcqDKMRI3JSV?=
 =?us-ascii?Q?2z/pXxvwKpzV9meHhtvioR4FUOJMmU9fc+nsB71PP0IdFVMDghUehHgydXrp?=
 =?us-ascii?Q?EEWLM5JT8Zyg+L2wtu360KaJzqax2m4GYaLOvAA+4BIiY/Gy5+4k68zn1ttd?=
 =?us-ascii?Q?LnOOgvf2VOrPnRjdsNYTl59mVKRdhlDaUG6F05CVpwxRJrM2VE9K30aVnwOk?=
 =?us-ascii?Q?dMUmZZyeqnKPR+GomoEEOS6y0rtv2KfckLr2CjFnTqtI2tdAiHFh2WuAXVWN?=
 =?us-ascii?Q?duHWH+qLq9q82Kg8pzzP61YJ5QKDPMGxCC8xtTP823VlzanYsK41qaUO8pz0?=
 =?us-ascii?Q?0BrZz+80XPrc99PfhIHjqBaprI2pwnCmjGi3iwC721ibmAkzwrU6HX1MoxBK?=
 =?us-ascii?Q?8YRbaEmNlx7p9HNJVbbbw6rQ7+RYTrmLidVC+KgCeSe0CQsv+HW5q/Gr2Iwq?=
 =?us-ascii?Q?+y16mloMC+LmvWuyY0PS0Qd4XNWPyHY+Od4H4iJC3HcOI9KlsDnHZQqaxPkt?=
 =?us-ascii?Q?RcpGz3+R0C3trzshmz8imdiEoTvF+9CxIDIEtd9T55Kqr0RyWBU3uOgs4djt?=
 =?us-ascii?Q?hQxOo2iKdySRq1sX60cDWi8JgnD63s51Np1gJMkN13TZgdTqSRxQd4SezJQx?=
 =?us-ascii?Q?vVf26Su9TaIfJlzyZuvUEDXCmq/HCw3f7PTrBDmVZFYDFKbLjQXXaeijBULD?=
 =?us-ascii?Q?IOVtALBCZYXYTAefVn9RuzRQWVHqEtKsrlyGy2//RAOPHc3IPWJBEE2B0RUj?=
 =?us-ascii?Q?XxHn6cWrADOwN0YD5/H0izjJpCyt7hpDX8HCEQFuM9ppQXHweWxyBxd0gXJt?=
 =?us-ascii?Q?ADbmELJRR9O4ZTRtxH8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 07:23:57.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5def0f-018f-4825-3a58-08de03e0261c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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

From: Roi Dayan <roid@nvidia.com>

The cited commit allocated indexped pools but those pools
were never released. Fix it.

Fixes: b4edeaf3efd5 ("net/mlx5: replace flow list with indexed pool")
Cc: stable@dpdk.org

Signed-off-by: Roi Dayan <roid@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index ece29fb2164..b018a4f0e2c 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2318,6 +2318,18 @@ mlx5_proc_priv_uninit(struct rte_eth_dev *dev)
 	dev->process_private = NULL;
 }
 
+static void
+mlx5_flow_pools_destroy(struct mlx5_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < MLX5_FLOW_TYPE_MAXI; i++) {
+		if (!priv->flows[i])
+			continue;
+		mlx5_ipool_destroy(priv->flows[i]);
+	}
+}
+
 /**
  * DPDK callback to close the device.
  *
@@ -2507,6 +2519,7 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 		if (!c)
 			claim_zero(rte_eth_switch_domain_free(priv->domain_id));
 	}
+	mlx5_flow_pools_destroy(priv);
 	memset(priv, 0, sizeof(*priv));
 	priv->domain_id = RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID;
 	/*
-- 
2.21.0

