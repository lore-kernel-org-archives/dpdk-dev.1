Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688DBCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 09:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C97E402A8;
	Thu, 14 Aug 2025 11:52:48 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by mails.dpdk.org (Postfix) with ESMTP id AF8414026D;
 Thu, 14 Aug 2025 11:52:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8zQJsYR5FHaqJmOJ765HeqMTggUIwQhdlu7EoJbifzgc67hzXWws5q1eLXrNQH4fmKtpHB25QV0hUqpP/RylvEjCLV5AAK+MB6+QjHzAxCSOGtzdzrw0TfhFL+Z+pN1Bg/nPDZTHkH7KtPAZDUUCebNOOzqZc3YD7630pBlpZLONxzaoCejMWz14Ev0ck7boDJMEvHqVawtgIKX+Ax9zp+X/p6aqVUaVBh9YraVz88NmWKqp0nQf12v7l4j0v692ygrN8uw0meUBvuftlfhT132GPo3A6xbdUutm44FAQIyUZptqHaH5XEHYEfeTUZKKRLs2HfzOlzXxdpto2xStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5izM0u8YYyN/bo9Iwtyjl4rZIPERynNX/OHnuZTe0c=;
 b=xSrSurtu9qZpYm90mTVNl4jARWgUzE1XmqVi/wz8/hIWfz85QufrHJDvM4mX0BlUaMCSa6TGwo5eWUThsTYi9n4Ta2PTfMgb5zUDFK0dibWQyq8NFxb+5ZAmYp3ut9Y0uQdsNNDEg2mRVKo33gJScO6uok7pC8Pset/yd10vMd7nefmnTRsk8Ayw8verR9MFBji3Jqh9QbCN1amH/LnjdWEmJRJ+Q/R+Tce1tb7mgj+BmVbgeYiFgqJ20rDmtHgrin6b2pZA+892HXqJoLENNPj8SMwnnOFuaCKgBHBhmfac48+40mTgOWjm65MlTomPv37RzRciog/wESN4cLwwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5izM0u8YYyN/bo9Iwtyjl4rZIPERynNX/OHnuZTe0c=;
 b=Kdvq0NJJkdEzR1nWGKztdeVLauibmKjBgj9GXRUat33GC5cOJzHiIkTLLf5VLYKTNyzkA6nIH7/2BQUF8AeJwllQlpX3cSYkQMfK7PRt84+bUuDR7Pt2eomlKVz3tFNTqg1DPjs5EC9JQq7puF/BMoMHs5hXBb5uI7Ig96IpOMf4xGEaZ8t0Z9DgrAvK1QEMOHesizWpvlO4Q0neUFTvasA4Ev5XUsEbg7+WdclFixKs0gr28QwYDtbyMioYZYXds+MbK69qqDN6+RvnWinNjo5+jBE/lcQEV4nyUNwCr9ULYHqDApSdsUqFkKzD93cbT9EsuLcl0THSZ4ymqm+7lg==
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 09:52:43 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::8d) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Thu,
 14 Aug 2025 09:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 09:52:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 02:52:24 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 02:52:24 -0700
Date: Thu, 14 Aug 2025 11:50:57 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Tal Shnaiderman <talshn@nvidia.com>
Subject: Re: [PATCH 2/3] net/mlx5: fix build with MinGW 13
Message-ID: <20250814095057.pe3dpojxsmg2l64n@ds-vm-debian.local>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250813152829.457463-3-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813152829.457463-3-thomas@monjalon.net>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail204.nvidia.com (10.129.68.6)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9f66b3-761e-4408-1c40-08dddb185053
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/o7OM7qeCZIH6Kui5h8GceU/zwK2pXPqykGlXHZbgfOAM7NQ/pb8bPleoYhW?=
 =?us-ascii?Q?+fL8ZzBle1HLL3pNbkQdfM5ZN6v8BwaXYRV/SuO9E6J+RdbVDFgS8vlU8Oyl?=
 =?us-ascii?Q?a8jGPktpGNaV7ZwhCJmcBpefeNLfBK4oSM7VB6xD442jxMihd1pgyK7yY4CZ?=
 =?us-ascii?Q?l6UmvcrZ0YYq3mc8BvlRAFS5aPeahD3u8WyVD9Vp78v0Z+AzkSGhlPT2TH4q?=
 =?us-ascii?Q?yzZLLgyD1tkJ5NwWqGLFmMD8c8Fd5k+BU9ry7vzY3g8+U57pwc9wYxmHrWzd?=
 =?us-ascii?Q?oFeUPLqU4XoXdfe277b+WTy9/+nuYDghgV0sQVE4XetNfoHrCrcydrIWkE25?=
 =?us-ascii?Q?kpJuNQgIzXlrJqtwdETEQUWqId7RLk07bfLWMS/7Jo1RTKcBSZY8OIRBaY+C?=
 =?us-ascii?Q?nKe2ZfURTWEuo/gQkCjReaRdeXAE4WmiZ2TAZW0TftdW1aI//r41uAJU4Zpb?=
 =?us-ascii?Q?fuW5jh3YdVATwz1jm1bjVhbjqio87z6wM7lufAhV2azcm/uUD7Yt+oS/sgIm?=
 =?us-ascii?Q?bg5u3nytxjCifIdrIXl+TYa1NSOAehSWxazkr+FWSDuCi+JQZrpfX0THKGEl?=
 =?us-ascii?Q?qZm+/H3kUgaNXsmIdMkkqZZbCxS6dNepjh6cxM+bekPUbYUtGZ0P9Ncb82wi?=
 =?us-ascii?Q?C5LnRFLLMbcLlm/+HjzDV19LVLrqTXtF0AtG4+15Jy1I/82AWZpe7HQ+sn3C?=
 =?us-ascii?Q?RPfUl85xWf78mpjmphlQ0ZyXDM7cOi/HyLZnfK3mJqG2Wl72SnSS5ETlpRuq?=
 =?us-ascii?Q?mDJhM9MqyD2678rJxsTPSSaz9AFPKqAxcO4bcxCghYFYtuVKsJsV6EUoCfho?=
 =?us-ascii?Q?GW66KOG7rdg+ZzhTog9MFxuKsmXAh051PSU9rJ8KL3NnTWhwI19QfC3pgGQa?=
 =?us-ascii?Q?MGhB1L/BFS/9dPH4ZxAQ0XHS08OyHXMstHV8b+OhAbLwyDByesM+shXl5Qzi?=
 =?us-ascii?Q?/cGmVMCoA6KLD/blP58619jMBxVNG9/65HGLmsa9Ep1v63TPfvt7L+cKRho3?=
 =?us-ascii?Q?+bk6o22j2zyhi+suApAWQIXaEtU1g6aFxetBikzRXLMnJFKyuvP7K4Kx8sB1?=
 =?us-ascii?Q?4XKh2zDpoOgmeniYdo3HkGThRaiyJ1rbIFReqGTuBPZXKswqjVApap3ACr0L?=
 =?us-ascii?Q?cKniW0i/p3Zzef8NjU3IhB42bJbUm5qMVM2BNw5GzWxrpegdZPoB9rpWnlUM?=
 =?us-ascii?Q?j05sImNIKIeqJvzmxw+0l9HHvSqztl0XMur4fbcrfNnTkojC5CPWYAmRdwl4?=
 =?us-ascii?Q?KW0xpe8li/1fFXfeWvizA1Evwd0UAAIqObVlSK2KuAGiKi3PXDnd6Z2qSGOt?=
 =?us-ascii?Q?pOe3CU86i5Wry+mnKrJicpauQoWOaXPj97xOGgW+wEdoUaXWaxRzWuCrjvrL?=
 =?us-ascii?Q?/tnC1FBFhkRGJkffvsDHWAKSHCKf04XfsFcX8A+l+85XDo8iyD8TjBo+mdxa?=
 =?us-ascii?Q?JVA6KymXV1XpPj3ZcVAlrxd+M5RkBsyJxs8wXTQb05zRH0CUNBj68Ng++myP?=
 =?us-ascii?Q?m5US+rGEOM9bEMJ73T+VZK80+k7EYNsTWXSg?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:52:42.8443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9f66b3-761e-4408-1c40-08dddb185053
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
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

On Wed, Aug 13, 2025 at 05:25:24PM +0200, Thomas Monjalon wrote:
> After an upgrade to MinGW version 13, compilation breaks:
> 
> drivers/net/mlx5/windows/mlx5_ethdev_os.c:285:69: error:
> 	'dev_link.<U1000>.<Uaf00>.link_autoneg' may be used uninitialized
> 
> This is because link_autoneg is never set in mlx5_link_update().
> It can be set to the previous value (no change).
> Also it does not make sense to check this value to return the update status
> as it does not change.
> 
> Fixes: 6fbd73709ee4 ("net/mlx5: support link update on Windows")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
