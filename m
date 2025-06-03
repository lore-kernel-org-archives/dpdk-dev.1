Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E6C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08654402C8;
	Tue,  3 Jun 2025 16:58:05 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by mails.dpdk.org (Postfix) with ESMTP id 808FC4028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:58:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzsuR+QlPO9bb2WbXsnAxraDlP2O/E0luBAJ8pxQzz6AdUOwVDFAmRkYlj9nIukrrWoRx+YSkYA06RSSbkb53OTQJ0cogpHIJ2rUL3+GOwqf0kyXmt45EpqTyrf/pL1oyxf8kn7aEkey31Jk6e6TBYICBmE3yxT/R9qdvaC5mcmk1WnmEQnr5zd8sP56geJfjydHDNWBZS4W0AxE+nNESOlIQPTpuAxiC0/i6VMHG4is8FQJNxKQUqIu3Sl5fdASzOW9zv83XI2jVqyMrnHy8jX+Zt8eXt5KEepwA+ZJlNFqcpsHNjdAXb0UK6s+WalpAGSbCoP9xtCWciGcZwjpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ZyR72+UfYelL2nEYVyQNkNkGzwvRdtvA8Y0X8TfBI=;
 b=xcTPR6iHkuz6A2NKF880ouigtu3un1CGhhN0y6yPZQL1OJgWzsXle9UgKOPh/bh4IuyVBrRGcCaPoF5J97Jf323+yERhZx4RFrHjfej3Cz2FLxpwebJNN8sACbjGI3QZ7cOrn/kZJaLhZo53Dh9JRMpUHcE4LGt/0kpTFyCSoYiM7CdUa2QesJRSymGeZbWM9kLbBNXPLI6X5M0SxvxwE1Bqq/9ZQ/xfdtkoXq3dtWMFgKYC1miMlYsvnnqHT21boS0AMuebrSqn4xWZ9PHIzbQ5oZOJj6UY4TCzAgBVxcbR9+MfJ7CkgC/hjr5227cSUTqBBG2eFTgjDI29rTg0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ZyR72+UfYelL2nEYVyQNkNkGzwvRdtvA8Y0X8TfBI=;
 b=p3oza+3Le6Pd34sG4S2kcfOBhuEc8wbwVfyyeFMWBMAlwxXUS1nBGSDZHokZ61V/v3WgAttuTjj7uOmvaJ+vzyD9ViRqo+kQWnzgzWE+8bqQHJpHZr/F+UZu8HMPjoLXw0ttXZDvtkE88UNSfFVcuhYK7oe7iRvzStE0g7W8Mrfgbsxj6Ohl5+Bif0GJUgmMLZ2LezZ9YW2ZXAO5OGSwMbMS5NxeTVAGrHtQzYIO9mAFn1Ssm6LScyW7jpBgZiQ3izUZmDIOz5wpkQpIl4x+iqQpdJno4vIe7gqWAXJhXpBB7et514XfKHX4rqB39fXGXfBG4cr8HSkq7tpIcW2tRw==
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 3 Jun
 2025 14:58:00 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::17) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 14:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 14:58:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 07:57:35 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 07:57:34 -0700
Date: Tue, 3 Jun 2025 16:57:09 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/1] net/mlx5: unresolved symbol
 mlx5_geneve_tlv_parser_create
Message-ID: <20250603145709.wtlv3stxqbblduoa@ds-vm-debian.local>
References: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
 <1746456337-6278-2-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1746456337-6278-2-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: fb21dcdd-0862-43b5-e78f-08dda2af08d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iu+4bg47TllBmnohmH5DzjdhgC+yrrV+xutNk9QORN1vdMMxlisQ7RKZxbA6?=
 =?us-ascii?Q?S4D05iojGrItqRA7SMR/UhyZrHRa1BidY0LO87bXU3AGsgxoNGAtr/2Kkc/p?=
 =?us-ascii?Q?2YKTcrhCJnof7FbtDHjxYZPgYx5zB8sbHI8eHkqQzIciGq/13Ffjc2N5tuvX?=
 =?us-ascii?Q?ReGrB603GyFH94OCEsb2dwr2iAv02vtHzGeSQDyfHhlrtjzlBOr6TuxmV1I3?=
 =?us-ascii?Q?wgRRVfuXeOCmwOXias8HyFHc9aXnKk7DmyMGT1IZjxcTC5owSJoPKoE0+kbb?=
 =?us-ascii?Q?sIR+a/i/jXJZqoP542Sn8HJWB4eQQSl0Nda+7fPAaYtn+DKz7SQmxkQDhPGr?=
 =?us-ascii?Q?TxgLa+tVElOdzsrHz08LLSmxnALgAm9AkJahoQelLwIUtERaO1DFA3FFTR+q?=
 =?us-ascii?Q?etcJKndaWqluRRZg9XcBGWAjmI8ih6g+liDgIrlhy/LXqAxpgM5Cd44wkpzY?=
 =?us-ascii?Q?up2apxBAUrcDDuZ3pcNUt9kJYqjONly/+Hvk1plmA5wYdoIww/WYBrZnk27v?=
 =?us-ascii?Q?m2Yhg8DXVG2o4EOg/7YMc8V4NjETKaAaupG9YKPVk1QJMlaquflTzADm3rXI?=
 =?us-ascii?Q?lJa3I4PWizk8BFWV3HDD2yPe56OOTmCsCxd1p+WxFKqOLgI9ZGgJk6tfa/ge?=
 =?us-ascii?Q?aF5P8SdCQch4eAkYeWl7sKCYUu8OU6MUqG3nzGilWu8kyr3vWLSLkmPPWORS?=
 =?us-ascii?Q?523ZaQ7xWyAY7SRL1k7GxLxKcMsdcEvqZrUo6OujKjEkH8SV9rVAXue2J7kd?=
 =?us-ascii?Q?lDlT48fTuCelR61V5mhA/jSwLrtWY1gu4iVpP7TtQyf99xu+eQIthCMAqAqL?=
 =?us-ascii?Q?fmgIqFCTMlOVJ0zbKbodSFlxmNHh5UUVob/fhegMIP/jf329AtKF6TDnNd3n?=
 =?us-ascii?Q?hfGxIJX47M/xuSdTZi0nU2Mo5urqckfryaCuXjcp3U2ItrCZA0cK2HcUPYCD?=
 =?us-ascii?Q?R43s4FXEv8Pm9Dt3oPCtW1m8dKZU3BcrJpg4Szc4cKjq9E50grGJGgOMUYne?=
 =?us-ascii?Q?AxblE8nx1uw70LsIgIwojI5+sKnbQZlmHq8sc3fydECeyLIXp5P9ypiC2YKw?=
 =?us-ascii?Q?4NePnWjllhyLxS9x/Dv5MSzUI7/ljVMaBGrcXn9LFiU3/0y0mKWAno+xGYZy?=
 =?us-ascii?Q?jtAUYEYH9se5nehknU4PVfoLesR321ht0/Zn55En9KtwAFYdO/052DBIVQ1H?=
 =?us-ascii?Q?gHoG7BWtJ9Knfh0NhUrTt4qIJLpD1mMgz1F7rAIIWch82Wxj/iRFXNsx2FKU?=
 =?us-ascii?Q?IcwGQEzEplKtN8hxcWxyDod79/fpZZxSHuM+3VoCyKTUsb7lYlbvbHDirfj0?=
 =?us-ascii?Q?DgIwf7QFtEIv46ygkixp1WUcetH0t8LxfLQyiXK8oXmFfwP+N9ejdVD14G43?=
 =?us-ascii?Q?xaOHhCwyzAsbO0afnxYzbic2T9Qg8NMcVE7lpho8sSAc8HDrwzxY9poJo89q?=
 =?us-ascii?Q?VK0B89A4VhnQPUOuzeiDpno9tu5no77Vv+hwnjjFUZECQ8p96i9pWKKkGxK9?=
 =?us-ascii?Q?XuSQrTmAxEwHierpWjwNKkuZ4I0JWVKPWfe1?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:58:00.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb21dcdd-0862-43b5-e78f-08dda2af08d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
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

Hi,

On Mon, May 05, 2025 at 07:45:37AM -0700, Andre Muezerie wrote:
> When compiling DPDK with mlx5 using clang on Windows with
> "debug" buildtype the error below is hit:
> 
> net_mlx5_mlx5_flow_dv.c.obj : error LNK2019: unresolved external symbol
>     mlx5_geneve_tlv_parser_create referenced in function
>     flow_dv_discover_priorities
> drivers\rte_net_mlx5-25.dll : fatal error LNK1120: 1 unresolved externals
> 
> With a "release" buildtype the error is not seen, which explains why this
> issue was not reported earlier.
> 
> The same problem will show up with MSVC, but patches which are still under
> review are needed for this to be hit with MSVC.
> 
> The cause of this problem seems to be that mlx5_flow_geneve.c is only
> compiled on Linux. This patch fixes the issue by compiling the file on all
> operating systems. It also sorts the file names in meson.build in
> alphabetical order.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
