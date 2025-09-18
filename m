Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB6CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 05:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84301402B7;
	Thu, 18 Sep 2025 07:43:52 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by mails.dpdk.org (Postfix) with ESMTP id 724684027A;
 Thu, 18 Sep 2025 07:43:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je/Hs82GPnbboclUIzr1KgEJPybEiadviJJ9N0RKO9KTfJTdECxef4xtcG4Y47rBoOrPEV2KZAXNuDwbV01H9ve0mIrYAaghtVfNWIYHn3psIRSZ3H725xFeo4/CdV6OmsC77OkgE3BFR4vCYE5XGS4ZbDd6i3PW95CQXR9DmtzBcM4BXhj5EEIOuk5ay9xRiIWbYUSXNIq7PVrXFIHiMoqZc710PWdcsU3PvvTx/er/0Yz1VyFdz5dSxxk8rZU3IUmJp0nH1ptdvZF/sTnCYYWh6XiDrUkxCGkDsTNDTF1Akc9POCrIWvHvvFlYI9EUyjZNMclTKdSi9vPtCTp3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTZmxxaEqgnszYz7Tcy2+UJSo6tu/PZQIkj916cicJY=;
 b=e8dkO8x/YJWf+4EZYh1WfslQ3tZ8eKd4obMNsJf+zXqmRR7NGCmulCI5mZOoyvV66/QwxtJrDu/x/A/D8Bg0HSLT6wzNrQw4jNRJqUA2UY6cPnYngbf1xkftGUpdO/LxhRmVy0MlQjJFcGov0LTfIRe1e3v2M4lp4l17i0+FqPlDPDl2AABExswrbAFNtpfMufJClR3SC7977XJXN/yXZD99RwAIxH/lum0ZaXm39FbKGVjecq2764SsqfklKy+nYNWSPCmFViy6IAkn1R6j1ULeKQoxE1298dbV4EsmF2JwPuVDMzQRhO1DK23O2GTBur0xae7jhTzaGu2MjDF+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTZmxxaEqgnszYz7Tcy2+UJSo6tu/PZQIkj916cicJY=;
 b=kmmvTkhkxo/QXm5EJScudfc6Mc3/hr5mCMPtWIeYlJPyzlcv6wDsE5m3+G8Y+eQwi+miLA/fMOnoxExaw8AWO61AA1SiH1pfBBBLuDObXT8wWN4MzSB1pb+PAu9K9SLzK7Qgyhyh+qEzH/xH6QTNPVOoApmji+TKF3yBToMuRiidtN3lo7GzxPGfRkZaNA/dL5iDpQX9ll9MUQwdSo2SPVrJV1OS/RZCYBPRD+o82a88VVuut+yNM5JaNmUNwzXQfxJ/c4hiRVJjA9hOqOkk65izibakm8oV4QQTj5boIi0IwxllgD+/v/sjvU5Xr4lQXknx91yrnoF6EXDDR/grbA==
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 05:43:47 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::85) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 05:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 05:43:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 17 Sep
 2025 22:43:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 22:43:33 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 22:43:30 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
Subject: [PATCH] net/mlx5: fix MTU initialization in device spawn
Date: Thu, 18 Sep 2025 08:43:25 +0300
Message-ID: <20250918054325.777881-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f938649-6051-4cbd-5431-08ddf6765666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DoEVCad5hXOPi8MVNDyJYOQV2EFRjazCRGA9kwqk7j7Kt0LPNM5Ye24l1Pbo?=
 =?us-ascii?Q?y8412RnCi9IPfaX8dcE+yXY2/bqsgjGNqQ0XKu23EBqx1mlF24C81SrN9/9A?=
 =?us-ascii?Q?dr/Q2LVUPtpvEG/Tg3WLTTnOe5QJ2W58rcQWgLt53RyzqhEG89OyLcxunHvR?=
 =?us-ascii?Q?UVP6wHc6bSyn4wDJYeQt8KusbElu+F8sJbmgp62lW8nKbvJibW774W6dmGEb?=
 =?us-ascii?Q?ScYWCnWSW6k7MIKEiah1mgdT7XPnJqBHQ5GeVPCNW4PstdEfN9x7xCSOzgT3?=
 =?us-ascii?Q?jcXoW2Qz+RIrIGM7Tfma/FsJp3yJsEqy0qlEKfaU9RhYFYN+Zx+MJDBqhspc?=
 =?us-ascii?Q?ElvV9sx0D0lKrRNW22UvCjsfbNlg0O0TUyxljrJRG9/qCSDVxdG8F0/ZzWWt?=
 =?us-ascii?Q?i2XEIhbyTtrmtLqL3pd+B5BMHZ91uTIrS4TMrbtzZ+db+dtVG4nC9m6JgD0+?=
 =?us-ascii?Q?7f0PdoqKWjDlab8o88strTYMTGRiqlBB/2/ylVTgAWS/OCmGBrKuhUbwfoa7?=
 =?us-ascii?Q?Iopa0HlXrwAT/8v9ptLG92YLG22T99kCDl0h3cUcw8gBm3bk5lRUlBEtJdw5?=
 =?us-ascii?Q?DyVFdWi8ht01LHHCGipc+sqNcThm5m5ZnZSPrAi0LEO39Rbimsjkd0u9Azg+?=
 =?us-ascii?Q?fEpbse1nwUIBmidG8UcnSKMfngG73WxHwnSpaVTK41SRREM9Z0y+B90o2cy+?=
 =?us-ascii?Q?iEgcmv6bsD+KaoT69sCDRWAJe3HYYGlZO8hKZS3L9QTpmC+hJe8BWoXKXCjd?=
 =?us-ascii?Q?g2yRXQx5ogcG4dWosLk6nHTM5ZS84QJjgMYMkefOaA/8iHrJcFUOm5Grxmyi?=
 =?us-ascii?Q?1CVsAmTaGjxp4LpQiWMaRC8CNKM2NS0T3CutKKppt1G+CfL9nTPckIRsNkf3?=
 =?us-ascii?Q?G8sMaVFX302wStWuN4uk/+WYKYNISL1QPqdFNxLQIftRGHjxVGdW9yJvjcGu?=
 =?us-ascii?Q?Yn/jfCZNa9JHkcs4hCXO3TG1KY477pfmGKD1AoJM07nHh1nR4ycmFRf0FHgN?=
 =?us-ascii?Q?DP1IONwxnf5ZS+hjI6MG0JAlj5cgWDRkUongivzoEQB3dk3wqjpG5u+H05wb?=
 =?us-ascii?Q?BB3mW7nxoJedplU/YXsuW0VoOiinD8kuPLhYgnNvUTLdqOntLHH1xBIhR6c/?=
 =?us-ascii?Q?W1JhGRGrp+N/TeaZbRipOmcrC3QHgMPHCzoPjz8Uwuf7yCbqzTJTMG3yZ7r5?=
 =?us-ascii?Q?DrellsFE2Huh2dcO3Kz6c5UBTwexKXZ49TcNMOTKrSWbl94XdmxFYA6fAvdd?=
 =?us-ascii?Q?GjQDKfJ36vNh6DFY+n+r/OSUfgdyk94RhN6Rm/kvqYgc2uHRrpg3M1FDVxgC?=
 =?us-ascii?Q?7xPKkVwNNQvrWuok4tuXY5sv4JkEDVMkV2PO5xRwM+neIRPC7/wSor4pGdTI?=
 =?us-ascii?Q?M/0SChbzvYI3XsaS6+qDZQjkRkVsNAAeuLq7z6yEQprTvJjw1HY0DRYSOAC6?=
 =?us-ascii?Q?Dx3usmqCbrDpjqMtxNwgeWY5TDYIYR7xNDb6Il4nSWTvzs1jCfo/XjPXjone?=
 =?us-ascii?Q?QT1j7LlcZarWAGMIZJgwayQG5kQOBl8IX+Cq?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:43:47.1223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f938649-6051-4cbd-5431-08ddf6765666
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

Currently with mlx5 PMD, rte_eth_dev_get_mtu() doesn't return
the MTU the device was set with, but the default one.
It happens because mlx5_dev_spawn() is not setting the eth_dev->data->mtu
field after getting the actual MTU from the driver,
so the default value is kept.
This patch fixes the issue by retrieving setting the value of priv->mtu
to eth_dev->data->mtu.

Bugzilla ID: 1768
Fixes: 2eb4d0107acc ("net/mlx5: refactor PCI probing on Linux")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c   | 1 +
 drivers/net/mlx5/windows/mlx5_os.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 8c37c047bb..8d11b1ac3a 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1601,6 +1601,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		err = rte_errno;
 		goto error;
 	}
+	eth_dev->data->mtu = priv->mtu;
 	DRV_LOG(DEBUG, "port %u MTU is %u", eth_dev->data->port_id,
 		priv->mtu);
 	/* Initialize burst functions to prevent crashes before link-up. */
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index c4e3430bdc..4eadc872a5 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -509,6 +509,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		err = rte_errno;
 		goto error;
 	}
+	eth_dev->data->mtu = priv->mtu;
 	DRV_LOG(DEBUG, "port %u MTU is %u.", eth_dev->data->port_id,
 		priv->mtu);
 	/* Initialize burst functions to prevent crashes before link-up. */
-- 
2.34.1

