Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057FDC2A06C
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Jan 2026 13:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C59BA402BA;
	Sun,  4 Jan 2026 14:13:59 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by mails.dpdk.org (Postfix) with ESMTP id 6805740273
 for <dev@dpdk.org>; Sun,  4 Jan 2026 14:13:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ4vcpB46wDC6xUbhfpvK9N0FqiKdcT+Lx3oXzsIGvBYrwM4/esbpsdR+AmA3qxCsFMp6h/wBjCLUKem+nzQ8JPYNf2VzV14X6HCeDBlcJGrxnxrhGTY4Z1XqE3JgD3rHNCKOHrFeapFgEKzCN+kAG7znasOODtHMCajAxSdwPkZ5VvB5bPO/WBAoPJO4657A7GOdfMM5OtogncmEM425S3B67mRSxlDlOFgcnUIfQFYIcbv22y4H73ehMidnhdqhfY/5mBCIEVwAZf0Fxd0ZIhocaz5iE609PmG1h9p4c0u5Wxgt9utuzfqKekZhFjq0Yn7kpNK01z9II93WUzjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWn8ggi59Hu1qazAiv90wvKz2NMEZPLqF6PoM6sRHAw=;
 b=QS0nIqqG/LGR209HTFIwgn7B5yA2o7jZeZrL5HtMp96hNMM8dvsU7Vj5a19KM3PIZSXAJWj3inlsFbYBNZwoFNJR8IBPvsEWkFCBvtYyECl92T04u6xuIwPVahUlzMnDe0OEN+0oYRS9+Cxur80BjZTaQuzUqLuGrb4VFjQp0aLryT3pZWxiruDxHysaQh+YTDn/cFntdzENnF7WgWoCy/zkTl+evJ+Ip01hYx9xmSjijulM6b1Xr/CuOtqqWkKyQ1Xi9ce/xJT4zgIsgGhkTO0iJ+i1a8XLlx0wB9lr859wycQrk4mp88zKf3qtvUEnshYED5hzjCGkJRq0Me9jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWn8ggi59Hu1qazAiv90wvKz2NMEZPLqF6PoM6sRHAw=;
 b=kWZ/FIlk8BevipCSappdL/exGVsUH+zQjqeG7uwY0APMwu3xLPEA21zuelAkQCUTnSY9qj0J3szEBMNyyxwrBu8SEe8hW5JmJ15nNLD5XBMCGkz5EcYx6O92nFCkdVOCnmeg6rBRJH7Rk87afKpS38xEwB1R7fswCd45DgFwR+QE++dwGQZQA7058FTVGJlZ2XDOfZfSN8qUsuTnpXTESuBCBUwWk83CMM2C1t2jK+IK8s/yc1YwbnVpxduU4Q0qOOySi3ZkDAzDzfLSGogFDljw0SLU7Hcx4mOg3Zr6wE80iF0lRbCi564zj21pZee8aFusgJJzcP6kJUKfBWmajw==
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 13:13:34 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::11) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sun, 4
 Jan 2026 13:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Sun, 4 Jan 2026 13:13:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 05:13:23 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 05:13:21 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <viacheslavo@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC PATCH] ethdev: support Rx data discard
Date: Sun, 4 Jan 2026 15:13:01 +0200
Message-ID: <20260104131301.196350-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: e4204b10-bbfa-4996-4237-08de4b9310a9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSXE/ca6MoUFxAZwebZwZBMqCF5ttIdRHOm9AbmUvx5Xn1oH9NiPehtDU68z?=
 =?us-ascii?Q?Bgde3/H58Sg96QWBpli0/UqQoopShHEbBl3XBpjBrEapYMurSh54i/AmOu21?=
 =?us-ascii?Q?xV3E3riS4lmfYhOvXdxFNRs35N8BnbuQoVD+0FJnymMl/xWsTNuYihJKH1TF?=
 =?us-ascii?Q?+i96BoAXiw12FUEPSa5pm6/yA6ZvnDToEY25hVPv/NtQl5m0AVzN6UjKry9k?=
 =?us-ascii?Q?34VUm1+M2njMTHn+808dXwjzMkZVulnjJgwj9KN6FYJc3MVwkiuYPY+8ligT?=
 =?us-ascii?Q?DzO56+uauxFk0nnxEUVZhnwbmy1fQpg/JhKpk3VEc91F62AFXSX97r/tiyy6?=
 =?us-ascii?Q?k+5PUtbkfWRVgB3ta1tMXJaRjj8VpSXG4Krz96LZOMp3ymUFSDqonu14aVMk?=
 =?us-ascii?Q?v04ErbF6SPSiikImnQCVIt8h6OS3sGNjjH25OE4lQ2JVU/bvxpq47SHRW7OI?=
 =?us-ascii?Q?A1pw1Iqv1L++42u4D5t9A2ZzobOD1zpTa8maZ3g3VYLQ0VTkcD7692YwfEGM?=
 =?us-ascii?Q?CeqqHrFuQvQJne4duvGf2YDG7/8a0W1vuHqvwXumx0oltVelnVP+5h/OZLQE?=
 =?us-ascii?Q?PeJvo00EuX4wpwF0v+OFzJfAQCW7wcUd3cMI+fYseycLTRkMLgj3R1Rk304Y?=
 =?us-ascii?Q?ZKuRZa7DORkXfuBRyWy1t97MXCTWSr6Pr8t25kqt6foYeL/ezpw4n2ZXCkML?=
 =?us-ascii?Q?tWtdpgIqpIjGrVHjnTJeph4+S9ERuA6a2nkGk0nIzAWtK4/m8stLANHkAyyQ?=
 =?us-ascii?Q?bY+0eQck8q1+1Qg09qkm00UFGe5VRmmotghrxes5Q8xeBAkrr5DoKBDsZCOO?=
 =?us-ascii?Q?m7lvlqI6Eo7mrOZH4GD9NChfZRH4GP3d8Hsf+acspRH+iHuBauSNHMeL2jLp?=
 =?us-ascii?Q?FFAiG2mgFt0ss02s7GMi/mX2zDePr9qmVCngi9uKNHJmh7XGm/GL6E6YhLEC?=
 =?us-ascii?Q?vORlASttNwLWIA8QOmIHiTMgGiTS1EyEtH/LmW+bj3vOjb7Kk/ATOS2sCgGE?=
 =?us-ascii?Q?SUsVRg1pFUQp+QG5RWdpRIqY986N7IKjbfA7sVjhnBD8V6USJB/nciavR2dH?=
 =?us-ascii?Q?0s7kSivPzzqi2RJzn9y/nHQ0jssAwezEM2wUQW423e+EaRKREEzGZEHYUCkA?=
 =?us-ascii?Q?21upG88fLxr8FbnMWtU/mDr5k1CqOsIyOHAoxaKPFje2zrOk1Ycds6OeneBw?=
 =?us-ascii?Q?Mftnn4xjc5bpBTRlq6qMB+pDJowVLGt4h35DQgxQ4CZG2jAlr1EmcAxGQL8C?=
 =?us-ascii?Q?PefrAvkscoE9W9uB9tWsFLomUwTJl0N5Uq/nf9u52QUtWan5r+BentO+qAX8?=
 =?us-ascii?Q?qn+AyaZMr2/pxlx9B+FCSRXTRSlYZg54bNMeQDgv1zV6YLEi5V9221g0bc1Z?=
 =?us-ascii?Q?oVBHRKlaJgwJhCHrvbpWxiQKxabrE+iqk/lmezmFwxMi0Ze5iTzy/XgxqM7n?=
 =?us-ascii?Q?jrTcgmcvXIvDZDVlzNNJkUpLZqDDJqRKTAqq5bCN8NTH8pAiU6BSzZRvallA?=
 =?us-ascii?Q?PDS/DGwf9RVQiNkdvpZKkCJVyQTqfhdkqKEJ8dZA5nwhFx04SlsIVkdMCz/t?=
 =?us-ascii?Q?wPkHma2acs7tEHVofw4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 13:13:34.3146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4204b10-bbfa-4996-4237-08de4b9310a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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

In some cases application does not need to receive entire packet
from port hardware.
If application could fetch required data only and safely discard the
rest of Rx packet data, that could improve port performance by
reducing PCI bandwidth.

The RTE_ETH_DEV_DISCARD_RX_DATA device capability flag notifies that
a port hardware supports Rx data discard.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 lib/ethdev/rte_ethdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..10938ddad3 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -2170,6 +2170,8 @@ struct rte_eth_dev_owner {
  * PMDs filling the queue xstats themselves should not set this flag
  */
 #define RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS RTE_BIT32(6)
+/** Device supports Rx data discard */
+#define RTE_ETH_DEV_DISCARD_RX_DATA RTE_BIT32(7)
 /**@}*/
 
 /**
-- 
2.51.0

