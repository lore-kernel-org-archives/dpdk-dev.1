Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603EED2505C
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 09:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76BE040A80;
	Mon, 12 Jan 2026 10:25:39 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9484B4013F;
 Mon, 12 Jan 2026 10:25:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdV072RZlN+1EaY5P5VrH+LGYy62MVkVYEhWt9xo7DQnZh50CLagAORD0bf1tBCkElRPbidnuxBzXACe6+L9uQ4zxPxImbKZwiDoK41c4k1XL9tRLqhfJUvE7bGFq8kMLJAVWDtrmLhiH5JS2WIgQqewetiwIDk0fAyP5/HMPY6vemOBYfm203kVHU9hHwbGA1wMv15fX4M2Xc/SSMtCUnRwXa0Nhdmj80g5X9dW8NYMI/UAEwPh/I3z+JpRO0eN+4WFmmBfh4OjThM1MVDZximzK7+sWWP/aP71No5Yw12CFp8QQeqVZ8sCb2gMCJZpSxWSVOu6XTV8LY/hSOFTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tye12+h3Zg4ZgEC8Eg4OUnWiSqQVNKilmosB3NFT318=;
 b=a5kH94HYY5w4JPJjJkUF5Ex10H6lRtcIpdpjk9pe8S8aEdJqax+sRA0TrvP/w9wlOKyurUJb/svBRXSZPpQhgOFM3gawThuv7TVLvF+q/GZXtjebmpSyB+QZc2YzpQ3vCu0Bg2xo0dd6MYA3Q6BcZ1nOqV27l86uBW4MFTc3bYPwCoYdqssYFswrMNvfMZbdQGqhaKkgvtxV5O8xyREi9w7rtXDwOGYn0ao8mGqoaG1iLbHy0oVL7cHU5E0185NX1ZefzdFh+YRE6keE6M6WQ569T0mIR7Sq6v4NEkegkmEUaI5Fux6+eVbJhtGueQTPBRheOu4UMVG0tocnzVBDJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tye12+h3Zg4ZgEC8Eg4OUnWiSqQVNKilmosB3NFT318=;
 b=J00V38PeBLmG3Zw5Qe0ESqGOsb0eVXpGJKILaLuQxsGAbxmSvMK/439FUShBoRuOgv2ESjdqiWFJzIN/hk2vECJYz2yGd1cNnmKO+L18oXl9zxNHZRx73COAMxPEundtoGjg+Er5uiXQtyoN65Hg8D6eof5Y3uOzDTh0ayAIYl1SfFW3cnF7m1BCLulvouQsfsn600bycSIUI2soHvGr0YiqWQ725BW5/gubKV0/aMcNhbITT7EbjLf0bsZZamgHUrqS7iV/cdA7E+iM/UeRT+MImIVHjj8rsIPULltIC8iJ/AioFGtMms3a4Ko4vAB+/x5OSvggqTBlPz+MP0GIXQ==
Received: from CH2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:610:4f::11)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 09:25:31 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::a6) by CH2PR18CA0001.outlook.office365.com
 (2603:10b6:610:4f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:25:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:25:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 01:25:02 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 01:24:59 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 4/4] net/mlx5: fix redundant control rules in promiscuous mode
Date: Mon, 12 Jan 2026 11:24:38 +0200
Message-ID: <20260112092439.14843-5-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260112092439.14843-1-mkashani@nvidia.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: f4628c7d-f7f6-4a4c-8eb6-08de51bc8831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+bmNtP2HECJhSLCfW15dgbPtgqqeitttLlXtqawBpQHevlyfNgWYSVYXlDZp?=
 =?us-ascii?Q?NmkvC64GNkoMhFzLkdCK0KxAGloom0fbuXwx4sbrJ507Axv5LI/9UmbkZuG+?=
 =?us-ascii?Q?ahY31ASP3YvReheUtZA9piXYmFQaWSHqtG8Fo624QAwJOslsqyKTdCbOrQsd?=
 =?us-ascii?Q?iIxH7RIQZCDhOj10mEc3HV/Wb2TCdZfsVvKGJcCeD61VGWEF58G0p+p/sRqX?=
 =?us-ascii?Q?9JIF/e3k/eY5+DBCvFp4aRL6RdKwYB5kHuDcowQ4rNNSYkHEobHU4g8hLHGy?=
 =?us-ascii?Q?FTY9qTcSQonNn+gjyV2BA+tf5jJdvxxIM+rxRMZ5rGfd5/Oy/Kq0QVPhRoV2?=
 =?us-ascii?Q?2X532aqFae3Zf23aezvj9/ubwumeWo/rrCPS7QHzYQ1YOEYEgnhNCZQ6rT0X?=
 =?us-ascii?Q?M8/zCVri7z/yFZs2heb91RYHmvItZqk9w5WpG9ymAnM0bj5O9LiBWyyPcEpl?=
 =?us-ascii?Q?bwib0p7jACCaH6v6gVtcZuR78BLggb4ihy6voVJFi/p/QiJBVV4HLpwXbAnF?=
 =?us-ascii?Q?vJuyhZ8uujk8f3j2/ER6TcDayAyDUOCSwNtgWQpnn9QcSF+0n45vvb8rR8+r?=
 =?us-ascii?Q?VVib92X1EAHHjASSqQjKjm1DsVTlsaLMB9VfxrnOTyaTWvwdABSxXfwD99AS?=
 =?us-ascii?Q?nqArdgbrcVTjc+zsINJsy4wodIsc9Uh9waigXzcAsJ0aHVzaGB6YvwmlzwBi?=
 =?us-ascii?Q?V1UuRbijCM11Myy1BYPkS0HMBEIccbF324OaTMW+BdDz/ehi+K3a7co9t2XJ?=
 =?us-ascii?Q?R7iQUfMbAWVpxgxbOpbOvYDZedxa3nbE4n4lv3jE+NQdbKTlkhF6BCFfBKhi?=
 =?us-ascii?Q?4DHLmwleHCtoX5J81DCANdQT5qhIjfZWHIeO9ejGLUXj8ICZ2Z+tZlGAV0uR?=
 =?us-ascii?Q?4vhRo8Fj5+xdL4fRuGNdeZTUyBiRz+/xaPDBgzyqzwS0V5hnXaeIcof7GqdU?=
 =?us-ascii?Q?TBbMkvy8Ht10Z/syxNoPS+RGczyZcaxButssNuhy3aPwaUaxW0InePQfADLO?=
 =?us-ascii?Q?3dqSCMfXpGmu9OSsBucae2Y81ZiDyaxO9i2bsFusUBcin9ExaREZHZ3TtYDW?=
 =?us-ascii?Q?cgk/1n3RDXgKOt6+CVaQbSAkrBS1IORzz5Aj9i+ViKhaRbwgwAnTHisL147S?=
 =?us-ascii?Q?SeKCYeifkmbqwUB3v/0CIi5Bb30doQ1wapA79aU0oVj2xhfOzEMoKCJmZQ/j?=
 =?us-ascii?Q?CCbcpc5lAjpiALvoVFXG7pxioBCyWsggemdf8OMujkq6z8mNyDHeTyO6AZxU?=
 =?us-ascii?Q?yFlm36reVVDFiGYzzor51WeTPMzFbXmMggKhfaZlEZbIP+wRNm2Co88jZBxK?=
 =?us-ascii?Q?vbzmB2zXl5owVP1NfYcu3Rho54/DQLT8zFXziINB6rXj+dsLC+HaDr3sBeKM?=
 =?us-ascii?Q?+mTMUbQhmFw8kfGtJ5Qu7I0znY3EwNudtXIQzGycuQES0T42Hj37HiwLEowG?=
 =?us-ascii?Q?v9Z84kwMMNPtrlfE706vV5CacaZxS/abYrDqGIOgO6QDj43POZqCk320GMDO?=
 =?us-ascii?Q?ljXVYxtOMYpSIcliHcJiN0F7/GZB8TeVrSqGVRFQz4BTGE4vnw37xUREGdBL?=
 =?us-ascii?Q?3JcARVGqKLqqIsQnedI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:25:31.2421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4628c7d-f7f6-4a4c-8eb6-08de51bc8831
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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

When promiscuous mode is enabled, the device receives all traffic
regardless of destination MAC address. Previously, the code was
setting both the promiscuous flag AND the DMAC/multicast control
flow rules, which is redundant.

This patch makes the DMAC and multicast/broadcast control flow
rules conditional on NOT being in promiscuous mode. When promiscuous
mode is enabled, only the MLX5_CTRL_PROMISCUOUS flag is set.

Fixes: 9fa7c1cddb85 ("net/mlx5: create control flow rules with HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 028844e45d6..b38ba9022ea 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1682,13 +1682,17 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 			dev->data->port_id, -ret);
 		goto error;
 	}
-	if (dev->data->promiscuous)
+	if (dev->data->promiscuous) {
 		flags |= MLX5_CTRL_PROMISCUOUS;
-	if (dev->data->all_multicast)
-		flags |= MLX5_CTRL_ALL_MULTICAST;
-	else
-		flags |= MLX5_CTRL_BROADCAST | MLX5_CTRL_IPV4_MULTICAST | MLX5_CTRL_IPV6_MULTICAST;
-	flags |= MLX5_CTRL_DMAC;
+	} else {
+		if (dev->data->all_multicast)
+			flags |= MLX5_CTRL_ALL_MULTICAST;
+		else
+			flags |= (MLX5_CTRL_BROADCAST |
+				  MLX5_CTRL_IPV4_MULTICAST |
+				  MLX5_CTRL_IPV6_MULTICAST);
+		flags |= MLX5_CTRL_DMAC;
+	}
 	if (priv->vlan_filter_n)
 		flags |= MLX5_CTRL_VLAN_FILTER;
 	return mlx5_flow_hw_ctrl_flows(dev, flags);
-- 
2.21.0

