Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7700FCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 10:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F4D04027D;
	Mon, 17 Nov 2025 11:08:09 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by mails.dpdk.org (Postfix) with ESMTP id CA4C84026A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 11:08:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tep7wTyIf7qe6nKi+yJXBwi9I4PSJcanagux6MlqtBfu53R6dxh0wfPiUnlD1qKDSZpxbgpxQDmYNGK874HXyvtn+i+BoKXLOsnpA3ajn3TkUP/ZYsnbDh6TENBocN3b3wDlfsgJbvmPhjsrxBevDHtt1TaNfuWpMT69xi6XYgGXBrlhD+LPi8STy1p1mnF8/8UDcXmsVj3IQERqfgoBFfvzmf2saLD6VRRH+J8AYwWP7DqweIBu4pFsBxpds3oTcOdQgxjuDwGTT6G7oSCAVA0KwX3nwSogY/42vT70j51uxYaTELalhV1HA+KzNgG5ZbX4O40CULnZuAhA6IZqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j9MSwas9GBGQujtIqWbgLu92SQLI9WSCmuEnxk2bOU=;
 b=MnvCI9ni6MZkPg8X4Fsodi6GH/JELjqBwLYbBo9JvfvyJ/GWu7BSBa4B94gJ9zZmqzlqOBDnk96aXoNfw9s+yg89FemMP59PPFd4stpsXoaiD0VSgJwoitB9ApJ7EZL1Hik0ttPR614ydT/d+9ajM2zdZabMDdnpTQetAv1y67WEVvjE3JIdpu6cOoDG9GoEOarRQHzKt6ELROkfOrhVdesgemlgxXChaOjV1Yb1b4lz5lM3ZY9dU7Y7t48ryxlKylYi9mMe2VNufFh2e9MN2TVOQ2M1hi6FFH7QTUp3fxd3GUcaNsgpvTBHDyLFDHLxJPR2aYbsve1zfbeXJ0KUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j9MSwas9GBGQujtIqWbgLu92SQLI9WSCmuEnxk2bOU=;
 b=Vfnymt4C3m0+G8idH9uKUnJt23RwpEafKwovTzN7XycT5zvOEeqhJB8jfkpKFgEdn7DTytKfQAaMlAK1bj0CcgMRrinVHwobXjYLoGrXu9VPCL6zZYEuVZerNOcPJi/OwkV+mpoSunIyEQgc+P0t4b/ioqy/SeB6MxfKePu10pCVkvcFvCRp9ouuDsAAtrVn7UtpOC29qx5DOeaY7NlxXGPb3/wDkD8uZ6of1UDAX1N++yKVy/T+3ZFbgEE/S1i3H7/YAFxzlkH400i2QAKr/OhXmdJB67OcG/mxq5xcicBZKqn56nB3SXGwzrcjKbD3ukWsnTuWIGgr0AcR8C+9Dw==
Received: from SJ0PR05CA0135.namprd05.prod.outlook.com (2603:10b6:a03:33d::20)
 by IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 10:08:03 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::45) by SJ0PR05CA0135.outlook.office365.com
 (2603:10b6:a03:33d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 10:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 10:08:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 02:07:53 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 02:07:52 -0800
Date: Mon, 17 Nov 2025 11:07:49 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <thomas@monjalon.net>, <mkashani@nvidia.com>
Subject: Re: [PATCH] net/mlx5: move auxiliary data inline
Message-ID: <20251117100749.sti5c7gkuzhsrnlb@ds-vm-debian.local>
References: <20251117072752.9290-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251117072752.9290-1-bingz@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 863e1759-f092-4e67-15c2-08de25c1319a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N2I2IgFJ8+Jr3X23QAUDvyGwB10tLK0WVuTJDCVOPYw7yEQn3FHNlNFxgIv7?=
 =?us-ascii?Q?QllUKowlFvkO6d1ZpJfCQQpu9C8qh6FpRPKvHTn/o3/wPKuZG+CVWL2sdLSu?=
 =?us-ascii?Q?y5OPzE+cHmLp2KMrslwDfD36/BVp5jZal5s8H5ojdKonU9Lm3yfI3RbpcW9V?=
 =?us-ascii?Q?kBL5IR52WPBJM7GHxPvj3yBslClG6PE6KmpqBGMYEkXYJKyNc1MSCXS+pw60?=
 =?us-ascii?Q?fL+ODUQeB6klMzXP2FePy1dOcxEluog1XMHtxD4lQu64cIRJarqIk4zo/L/E?=
 =?us-ascii?Q?Ej03gnUoKm6Z7GZr5JPPb4lhqcI7EOf7Na+hirA/FNlaQnnFmBudFHQEvHuj?=
 =?us-ascii?Q?+mov62RgSqCAcpkhBDaES05IuxFGgzj2Y/EgzUziIQhjemealW+ING6BZNMs?=
 =?us-ascii?Q?bjsM1o3x643f4rGCarn5V2vAgke1IMQl+JFEU/WZtryU/7cSOUJj0JezuqQg?=
 =?us-ascii?Q?odEDnplWhVMkBQvb38tO8dNXMf8FdCZwDJ/Rvd4UlRQQ34FOl66iBGRppuIB?=
 =?us-ascii?Q?aXL8etsch8mGvZ4r/gb1zxEFF65Orr9H4AkmnrT9oVtD6e1q45vri9gEvoi7?=
 =?us-ascii?Q?eYTwyNEKlQG4OiUHyyvIw+8B0oKxUGcIGjoadm7uvvPE4KuEdPrcstZzWzOp?=
 =?us-ascii?Q?jVE4o2NmXdh55WSvEmvqIqNB+S9JzUQklg3Dr5fezVIWgs0ex2HJz6VHhJQa?=
 =?us-ascii?Q?QgzM1b24yPkuB8PpWOxaBKOHaDfQDABMufRmt9HLvRg01fkJiiwFzjZl/uI4?=
 =?us-ascii?Q?/EkBtBZ2mZ2neGsF7W+F8ZLWGB8Y3pIn+P5Ag+jRLkOvc83Qwadxvu9+aZrO?=
 =?us-ascii?Q?/jk6jE0Lx0zDgZIpMFKIE+Orx07+U1OYgvV3r4Sx0prEJVB7O2NeoqXEfpBj?=
 =?us-ascii?Q?fpF5mYD0jS88KmVs6c1g+rM9NsZis2nif226ec2147N1chb60r1sgmS4ax1u?=
 =?us-ascii?Q?EWMW39HfudTt+XMXYF+787KSpcpP/NTq2mfWzMJ/nPTM9b/LfZgGeQfPPAJh?=
 =?us-ascii?Q?v+VHCHojS6mjTGgZIEBBUm0j+HwomErhXJw7CDQXA2D5FWmaCNE4ZRIFb6ox?=
 =?us-ascii?Q?rxamCpH4takA1Qh7mHi5Bx31TVRj9D0DAjQK4sb562LeSvtHinZAgMRtDw6e?=
 =?us-ascii?Q?02bHINssyhYo96FE+77A8Gn0fHU8AQEjuq0YjVrpmcogggTu6hAFGitdrDDS?=
 =?us-ascii?Q?HOo+sRRwL8Yc+dDEJf/ArPNtvhcCXIduXFfcqih+rqfFV7P6vWJHMax8uDxQ?=
 =?us-ascii?Q?PBINlJyEUVEmyPdb8u6OGnOOtKUyt5c0L4gvzD/YxTu+9ZF2o/5pWuYa/eBp?=
 =?us-ascii?Q?hGIJYSGJPuHl3QyPtlztKxuG7kqRftRkpSghS1qcNcndTxMOB+/TTluSdTUw?=
 =?us-ascii?Q?PRyxgY+K36UD9FncBUhAiO+Ql8OnOjvVD5F0TCuKWWFWElNdFEPMoeCc8C5+?=
 =?us-ascii?Q?aV3uN5TIRjUzx8keySPekl7NzdPAX9cwApBQCWcxkqwDIo2dRdkeQfZ6rwm6?=
 =?us-ascii?Q?B80nrybdDVGmDfriDt/olkK2tfVLR0/SxfQCPqPD0vQM3SgzTiFZlxVANO/2?=
 =?us-ascii?Q?KkLHvfhVyPCaydcZrds=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:08:02.3711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e1759-f092-4e67-15c2-08de25c1319a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468
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

On Mon, Nov 17, 2025 at 09:27:52AM +0200, Bing Zhao wrote:
> Since auxiliary structure is associated with per rule, it can be
> allocated in the same ipool allocation to save the extra overhead
> of the *alloc header and the unneeded CPU cycles.
> 
> Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
> Cc: mkashani@nvidia.com
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
