Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B62CF45BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 18:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94A6D4060C;
	Mon, 12 Jan 2026 19:19:32 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by mails.dpdk.org (Postfix) with ESMTP id 9B5D240041;
 Mon, 12 Jan 2026 19:19:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvlfh75APx1WHtPyQjvLK4V+ECjN0tx4IduaQGcRxoN40R3og8kSYAYPxRLS592/u9mt5QbrPKpVxUzo2fmNlIv4Mea+vJZIJONa0DGOFT0ykj3i6SegxRVXEIHt31PzqSN0R/qC8PAYZ4TCgFVjWUe90RLHaXNPqGWWZg5dxzSQUAer2W3TBLDIultM4AQA98Qw1biPZ0TqrdGZGSifIwuJTyYpHp8xnDK38ctOrJlh372AvHC8doeZosfgfpR1MzCPr2FmQduNIbFDSym+wmi6/XVFGchouvs2vMyMHhZEgjOQaPyjC9UIBD82l5+/kD1ZuqtLLA+IYYrahLgUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDQ9Rr7zpP9R+wzACvz4KqJJsk2OZO4LVtgK/Q2dbtI=;
 b=NRSzoWdfYySYH5iP/E6oIioXK7pQmsc08NkO/eroXvwhtMgiSRo3Rat02QFzyr6kV3BHB97VnMzXBH31ko0sN10xDLok2cfyRvHP0K2amje2I/OlhrFgx1yu/H30zd0uYgQmlIbmqAH6tIwTw8uRyGDLBWq1lpCYU2vg9DGosRAjI5MMm09SS//GgvpkmDQ33OzH1Rt0fs7oPMc1uqMKBgC8pKvwASX9nnJm2ZaeAdTQMGDBq3n5NNz2ij6/dF/mhvtLejmSuIbgcU5JjrceOu7SMN0kdh40rww9kU3DMfm6PvPJrv/A7HpRD3wy5LLnaq8E+REyfcx2wCt9ezUXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDQ9Rr7zpP9R+wzACvz4KqJJsk2OZO4LVtgK/Q2dbtI=;
 b=CPER4TIZVhRtVBkjbhveOb/kfcDj6+0AEywvMN/LP1e56QBrJK/zuP1rp0hvOusc0kNRqdG7stlT33FlA8WgaRcan5IZLSp3tu+PJHs55+r0EFoPXOXAY0Dig+216OiQDGTv5x0xc///+nDAJOagaQaEYJOyDoaysmTtEVqrNarEGTB0EJISZw9V2xfxKo6DerGsEy4tSo3tS4xhptEoLRX6pPHVg2ePg6UBZFxN2HtkTrlFFtAdYg5h2UAxVcUXQNnBaLlcdFGpJ+oe11KQNdI8Y8qkcGR2tJU6dexHvpz06lEbWrT42305s3ACxUcb1ALnWal18wSlCRkB73NyBQ==
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:19:27 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::6a) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 18:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Mon, 12 Jan 2026 18:19:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:19:11 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:19:10 -0800
Date: Mon, 12 Jan 2026 19:19:07 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH 4/4] net/mlx5: fix redundant control rules in promiscuous
 mode
Message-ID: <zage7m4l4er7becgh2jslnsrnh6s2mevppg4lbuz26xajexwrj@jxn3zc5fw74l>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-5-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112092439.14843-5-mkashani@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 423001ce-9786-4b57-ff5a-08de52071f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aJ+WSphUCIMpdfGJ7yqIliiAeEcis70j3yxY5S4DmKS5lOpKvov4ZkIDeGEU?=
 =?us-ascii?Q?3LfpRFhipLJxSAKvqvyTwbREarkM9sfAvjJdrIlvWlwfKpNmcln8v3dMkr4/?=
 =?us-ascii?Q?nZP5ZwlWjF5kCVKXdGwximU+o9CPk3Kuf/b22oAgGt+7/PfZIGq+aSFtF+0r?=
 =?us-ascii?Q?MCpV5A8xsNg8sJN4VgWUFw3Ix7qMOTamllKAwEUjHObmGeF7KCWpxcb2HfiA?=
 =?us-ascii?Q?T1iPuzWkarg2t611TxGjLlrk+PfRmtWZlUmU0TWxqOLQ9dzhos+dbjK38A1S?=
 =?us-ascii?Q?xm8eqXW90L0j+kFAyMba8h0yaSWKxrhwp4A9D/McVpN+iNM7oBsy218hEi0x?=
 =?us-ascii?Q?M/FVKIDfJ68SK00wO2ug43TApCrvSgP7UWwLTYJBY2Jx+MVHuN1lR8v3ataO?=
 =?us-ascii?Q?nJHixw0EwSXZAkjLSdeZjtbySE/cRbaHbyex/m1I2qjxhIGpyHmexXinMkSd?=
 =?us-ascii?Q?LVpKoV2+X3AQ2yTNXyskz3VxAcusiC01YE4DMrWL6ic7/NPzAQUSkd3QszP+?=
 =?us-ascii?Q?gcmEzo2RxlPcBtpgnmd9EZFA6BiFnADTquruec1yrBom/QVEqVhtcbUUH1gY?=
 =?us-ascii?Q?EREDp4x8u/moZf2qRBZ0shjRVjjj0JSBEufBi/HxL1aLNprqFQIzwbWUwnoM?=
 =?us-ascii?Q?YeM/TNouQka/KkHnzI1/PSPiy//FfbGaBssDyB0PWmkuw6BFVBXOYL8EUzlo?=
 =?us-ascii?Q?auDhHhHebOKk/zr4m8uR25y3wdrr5EIPO/kMa8xQb773X+ZGp+IdOkfj/HCD?=
 =?us-ascii?Q?dL6V9bTl0zUQD3V4t2TnDDgppFt6LGuW4+IoySt76NvH+Bh69ePQXzv7bsy0?=
 =?us-ascii?Q?uWdidu4hqoPiD/MvRGmnjZdw5Hz/VhoLiMu2ULQfX5tuD+5JH7XWFbA92W34?=
 =?us-ascii?Q?QeCxpTbKiOo55vvOrIEbowkuuGkGUjk1mbVU0bDXGll5gewNLIJS3fUItjnv?=
 =?us-ascii?Q?t3gEhYisconsihbTFM3aUpbaNlZcrzkgu0nSnC9x0xdOz0edKkdEzhegXtka?=
 =?us-ascii?Q?nJnm2PFdgOAtQMR5ybi3ZecVF0K7K6S2jCAlhhAlD6uT2Rxt/p6yUxH0N2PQ?=
 =?us-ascii?Q?1R4zJlceqW//emBt8H0z4W8YM/VJsgypvjppCD5mctsdh4Z4VbgtK0quDEwG?=
 =?us-ascii?Q?IIEuNfgiR33fJ1pOoeDVRA8d1uBH6cqqnyV7nwKp8IuXnF3ithROGiDqY7YH?=
 =?us-ascii?Q?sTwcGX9UvrqJpMfE7hKTEdpe59ewG8LJFvVv/VXt1H1+gGYsOl7Tkqlc2tJN?=
 =?us-ascii?Q?KwY/c2HkqxNIb8XDrd8XXZ7bn1ZPKv1MKChBFoU7pISuzHaLTKmynVQ9J0r6?=
 =?us-ascii?Q?yeUcVdw9MzhVOGa62PJo5TJ6Ws98ugoN+xCxw5CXMvot92M4yAfS9qrIhXTJ?=
 =?us-ascii?Q?pkS461GlHjITW46l05FiEaD0w6ldBeR72enXrsOjLOqEJ2uQx3Esj9dlwdlD?=
 =?us-ascii?Q?oYhF9RrFJuEIMFh1mFMJe8ua3yXbooj/sSabHq6l+T7IQZo9uGYWMa+7mzU3?=
 =?us-ascii?Q?oQL4IyYw77VbgOdYl2zcRdput8Jf9p2fiiY+8hNoUPmjn/I/8uZ4cn5KJl7s?=
 =?us-ascii?Q?KQ2zuvHIQcyvNyggomE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:19:27.3213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423001ce-9786-4b57-ff5a-08de52071f37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

On Mon, Jan 12, 2026 at 11:24:38AM +0200, Maayan Kashani wrote:
> When promiscuous mode is enabled, the device receives all traffic
> regardless of destination MAC address. Previously, the code was
> setting both the promiscuous flag AND the DMAC/multicast control
> flow rules, which is redundant.
> 
> This patch makes the DMAC and multicast/broadcast control flow
> rules conditional on NOT being in promiscuous mode. When promiscuous
> mode is enabled, only the MLX5_CTRL_PROMISCUOUS flag is set.
> 
> Fixes: 9fa7c1cddb85 ("net/mlx5: create control flow rules with HWS")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
