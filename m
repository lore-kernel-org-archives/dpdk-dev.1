Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CCCFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 09:33:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9158C4065E;
	Mon, 24 Nov 2025 10:32:56 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by mails.dpdk.org (Postfix) with ESMTP id 52A98400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 10:32:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1cfmCAlE0CswO1On/aTQ5+DJ+hBOcVWTRrBGNROwHY+JO72Khi8+mnMudMZaR5haTnxOdht7b9OCuWyu4aFPB9Ro7R4S+HT9GTZ/7UFPV48ioWF71YS6cYEkvKg+hRG+gacKQZez7UVRWu4oqwDRz75vycMsA20GxTQm6TM4METtVxTrYgs+hzdNJv0bCKLokZkXQprf5HWc8JnHa/jdPJWVTl+UIs8sEQocOoMesci56MYaTPc2adv165UGT3ktvqv7qIdNgdPMx4gC14e9PsQHqHWYOx08mTnStWwPP+euFKkGffLQcD/VyP2lAap5k2RCFlcWAY64Xxc8DbXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkipGS6Seq/IPfbPzTEbjGQ3Nof/eDhBHJGSUv+Qq4U=;
 b=qZdngYP5lDn1Fi/GI5EzMVCSK+NOWsMhqDo5M/FNV1bCaXevsXE/kKceJlTOhnOsakQe3LJMU/An5C64FdZsGATkhgzTU0onT3PAXXzLOfW4atPRm4bMZPVz9q0Ws9wz+2ge6NAm9J/Bvde/9+1PVVIFUIDY6pffYUTgKzMn/TJN8gVui5lKKQn1ZklEXfJiGmcVFBTwR3fmHowilhZKvacuNZJavF8jrCxLfAz3CY84fkz0k2SK/Bmja4YVCIGyrbwTRBC3voxRLnmPQOjHYyTyEXL1XHzklpejMQBT4YA4VGGanhwkmbPELbmHZ1eFJjYbKMJqe2VruIFROBP7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkipGS6Seq/IPfbPzTEbjGQ3Nof/eDhBHJGSUv+Qq4U=;
 b=P0riJNHR8GoRGt8Z6sD4TXlb1p6ekzUxGBVeXKIB6l9TDuN7kOAdMCjnli+BqK61MZO8/rrTdupmSmguX8yWC1oOyJXbaODKpjCzd/vNIz7D+3Lh8La0pROBJ7hhrKN1VlS6RqLQimxcMEdvZFdKKRUZJtr1ZZe+hcRXMD5DLuRo6dRxxGkpqoQ097kgCrdtjA9Kf4PNT2BcBdzRLTem3wZQYsu/txfVJJnC1c0XISJx+jEiiL0PmarDowO8XcfFL2admu8c75ArS4IrGXP30IFUWluOznWY/RCCjQrI5p0JlVmlV/lFM0LsygKJEMt8MBW0lH9YrMQF424Oxy9vEQ==
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:32:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.8 via Frontend Transport; Mon,
 24 Nov 2025 09:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 09:32:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 01:32:32 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 01:32:29 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: [PATCH] net/mlx5: update count flow action docs
Date: Mon, 24 Nov 2025 10:32:13 +0100
Message-ID: <20251124093214.2080415-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: f395b0e1-d064-4314-1d08-08de2b3c6ec6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3lyxfjZ8UOwbyHuJjnlElKGoxBKPiGbXvwA6Ym9MsT/tVbtc8GNIgsKkipwD?=
 =?us-ascii?Q?mt+NK3XboBles+N0+Vt1IAKCyj/9t2MyD2k+jnsFzLb6zZnsAAADUH7WSygF?=
 =?us-ascii?Q?Y319ZDaA1QczfoW7+sZeujhwe3QN5V2LyvK0MkQ0Of+lFSxUd0fzs3y9RKKM?=
 =?us-ascii?Q?kzZ54aNt8wmoDLONJsMh4QD043+KCKo/6hmpPMXL2zwvyJkZqaFiJVkBtQaY?=
 =?us-ascii?Q?wmI/iOPoOHJY2H/oaO+W5DnjSlE55UTPZqo+9TGHcTGGWlYOXb+hBlhLs+97?=
 =?us-ascii?Q?pe2xML9Tv8EhHCSAS22nyObReY/0fpM7QRawr5dEwP7kPeK4vxYNHhnW+QnR?=
 =?us-ascii?Q?C5mIkcG6eKYHQJLGA+CW09OA23ymhd2mKgstTCYS3OOyMjVNhE68O/qqLSuP?=
 =?us-ascii?Q?HkuuX7t1dVDPkiXsX4sk/lP2uu/KQj0UMnKWDRcW7FCpjpOZwW5cpLd6p+7G?=
 =?us-ascii?Q?Q9zxJa7f1TRA7eGsDW9bF4QGwXm3nNV3CJVMJC+k6tvOmkABW/Wg5D7peZPf?=
 =?us-ascii?Q?K/KJ3K1ErCQJq4sMLIYbdQoqckNvFuOQs4d1p/iu4Zmg11Dyc0TT8DJNxbvS?=
 =?us-ascii?Q?BzefvhvHeCdW9Va6rciZeI2+LwOzm0ZNEAsc9mxrlXZCwBNONBqu0MyZ7gJw?=
 =?us-ascii?Q?xI6l08ypxYIF/nNOYlbhPcX+Y5jQTVEN7+yZRUGhBYrEktYXq3p24kpnUpW7?=
 =?us-ascii?Q?H/28jxb8ivEkGJkgmp1F5CPj5Th+CNwK4gkp2s9DNd0DmbfHpGOOOFG/6FkC?=
 =?us-ascii?Q?/yyfh2cPyojFaDC9v+IInB/zQZl/Xm81tPv+9fWhs2OtcoyQ9BgJuhgy8YUl?=
 =?us-ascii?Q?E8X5R28q7TRTOZSE8nVFXTvQHnJ9P9YYs8JCyn7pC5pR14mRwPk4AKxzUwf3?=
 =?us-ascii?Q?9bkslZuHqEnV6sM+bwoXRMlcE5bHVigFz7dWucRXL3sdqEf5mXovfjeWPwuV?=
 =?us-ascii?Q?4SLLKc3nkO0QElj1dQC3fa6wuXToUX5K2LEKGP0PE/X11LlYB9rzZRg6HnMz?=
 =?us-ascii?Q?G+4qhlealVvZWejUIs8i2IE5AN2Aj2zRqOfiwA42dISocD/Wp0neZ20KNfCI?=
 =?us-ascii?Q?wbWNiD3ZAajMj2i/OT4vJB3a/rW8Lecx+iXPkOxtZLTQaWC8oM7VNuc1RKLk?=
 =?us-ascii?Q?lyMpKNHVTxEhkHQh5uVigTHGt1g2D1itQG86jPdVrwnHi+sJE+f2hTvFxZba?=
 =?us-ascii?Q?6w1MD1zquRWZHu60MSI8jA2JDreS+hiO5NzRn7xAf7qLxYrEqeJgQSDrruDC?=
 =?us-ascii?Q?e3/r6bXrPy+vBUx75jT8YhHdKF7nOVw07CLkZFa/VAMxbXK2zdKapJ2faaZj?=
 =?us-ascii?Q?5ueNrVaPJ97EKL+51iHIm1OOD8Lsco3yzI/IfGhCMj0j0ymW2nPJpQc1CFJW?=
 =?us-ascii?Q?q/sQVTh8+gt1yRCig3Oyga60b0Mvcq+ejs3dMaj1jzduOlqDYjaRgN1Tcfy1?=
 =?us-ascii?Q?6zbjK/hfabH3i9tKBqTu/b+l1d1wmLQsLoT5XqfFWUDfNxTXq5A5tVvCC12T?=
 =?us-ascii?Q?z+gLoTJlkDREMBP53Td4krYm14sfzqhL1HlOHcOdLxxy7zDhVnIQEBVnPw8k?=
 =?us-ascii?Q?R4pi/77puBNx2SXZ/2M=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 09:32:48.8362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f395b0e1-d064-4314-1d08-08de2b3c6ec6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
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

Count flow action is supported on root table with HW Steering
flow engine with upstream drivers/libraries and
drivers/libraries packaged with recently released DOCA.
This patch updates relevant docs with minimum DOCA version.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index b393aa5f0e..46d95b4e71 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2763,8 +2763,8 @@ With :ref:`HW steering <mlx5_hws>`:

 #. Using count action on root tables requires:

-   - Linux kernel >= 6.4
-   - rdma-core >= 60.0
+   - Linux kernel >= 6.4 and rdma-core >= 60.0 for upstream drivers/libraries or,
+   - DOCA >= 3.2.0 for drivers/libraries provided by NVIDIA.


 .. _mlx5_age:
--
2.39.5

