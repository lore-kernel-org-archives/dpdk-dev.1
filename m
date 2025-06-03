Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B34C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62D50402C8;
	Tue,  3 Jun 2025 16:52:46 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by mails.dpdk.org (Postfix) with ESMTP id 3C6164028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:52:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHNBGirGRzUgd16z9lpliEz6mAvf52ZRnTyAsnPNzrtcwZmxpXwkhXxngxY1AS06D0iMj1p9CWQ4zfBM0n2OgLVoAdgEyrjP8M3beY/UltnaNYDwUtyZYzxTuX7qew2GLWB+NDIoeYzyUnVpIfFwGLbNgVBcgManaZgTypCSkw6D/P3/FVOnafX6+7aHBXeUl1Q2D7snZACIRP50QhVEJSeckSX5knVSRZsmqg2uaaz7UUGF2nyuMeRH6YH4tHdGMrXcI4waK7qxoI7ZQRwomckgUi3LxbrCY41TbfmrDf0xZCM0FlXOi9ftXvk2RIc1jf7StGEIsZUQolO1d85ocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+PQfoas1bD5oZG/aWDVq6ncQqggSnZOUluCjwFRUiI=;
 b=Id/aj+LOFsJAlgNE90Sa9tOyP6A1XHedN/KGH/Fd0lBeknc0ryLrz6EXrdxNmBoOI64R2jQWBgYkDP7ONz5jDkP//J1Y7Nq4fq6rp+4B4UZzUCXr9QjXtHZafyKcod56rBLvEc+sgdmhfnADFN0WpvrB2E//THGr7HXM3RPIN7grHfEH7SbfdQ+OMhBj/qVdFqsOmIbyJreO0k+qGhIYXKVV7nrRiTNrJr1EfTsxHtpTqV7g2SWhtK+AeeCb8U5nBzzM6j2OSJUmu1ZzCq52iTPar2HcoCeqg7YTvjg2xaUHFS7YCapLZVj8vQrzaQYz9oGW2v2NHT52vH0o3r1Z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+PQfoas1bD5oZG/aWDVq6ncQqggSnZOUluCjwFRUiI=;
 b=R+owrCPy8gJOL0igwOuSn3d77TDQV1h0+KCrz57uN1zU8oOeoEaGnji+1ThGG2BM3FldZlNis/gCdckL2DjS6yROTlaBcsJdKiloW55GEruCqa3IM4t8rEVBO6nbPdZOEi9foU8MTZpmgi5C/WznqNEOv1MKWbMGSO7SP+rFRZe9zI2uVhHHD6r1LPjPCarDZZyNHmDHS7vNsQxkH3InaCTst0ZYczGS7B4xW4K2n9KNX6hre+YTDy6cJ4ytJdQfQvSPQt4+ekAZBdX8yltBTAWTppx5WOkVEcAJfMTQL48tdZIn/xRYKW4v1h0nkYXiBF+icjBz/tv1BXroujxk1w==
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 14:52:41 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::59) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.34 via Frontend Transport; Tue,
 3 Jun 2025 14:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 14:52:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 07:52:20 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 07:52:20 -0700
Date: Tue, 3 Jun 2025 16:51:59 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Alexander Kozyrev <akozyrev@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <suanmingm@nvidia.com>
Subject: Re: [PATCH] net/mlx5: optimize counters ID greneration logic
Message-ID: <20250603145159.fepgjp4z6dj5slkw@ds-vm-debian.local>
References: <20250425155515.2635090-1-akozyrev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250425155515.2635090-1-akozyrev@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dc1605-0886-42d9-3fdd-08dda2ae4941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I1WVCDN70CipBuDg85n2Ln93hb0wbeRnOb6zFjCTwPC23S2z3ey/eP2AjBjh?=
 =?us-ascii?Q?xLveTWJaO9GI8nvQj965f3y8De7yCcvH9BMV9zmpk4cZTFhDIo7hIzOeG/0Y?=
 =?us-ascii?Q?iriCSFX2KYHbAAzBob1EHdC6QER9AOaOokScfjf7d0h1qcCiCjkVeReZBPKa?=
 =?us-ascii?Q?pMG2j4+PrxnZNDxveDE5nJczRzqK8FGKvqCGnW9AnyY0BsfbdSawJatiy4FO?=
 =?us-ascii?Q?LXNv3wSK8omK4wygUGDxrZeibptV9dxRvrAEyeWRr+gRSzjo6MD1Eq3VLHXT?=
 =?us-ascii?Q?fd47wI4NtI1J+1Hpu/GCuy/TyPO8KJuZE4solIBnalhJAWLBO3s9PTI8cy/3?=
 =?us-ascii?Q?S8Jxa3r11HVFqxRFgFQZ16k7PzZSFUR0TcG0mKxqAVa7Q7gilJuT9f4U6VNr?=
 =?us-ascii?Q?auBhqYNuJcFZ9tmjDdFpDeTT31tRVSgwFDJmszkwd9dQa9k+2yoDMsfWvCSw?=
 =?us-ascii?Q?AHSHE+IHQXftEyvjBWzsQv4+HSFhY6JNKvxksupS0uN2UwxLz1C6HpTWjOe+?=
 =?us-ascii?Q?Fbn4DoJaOaqXkkdyzaql893GT2ZCBcoMKAgBb4AJiGzz0PRPOGbxqhQ0lEL2?=
 =?us-ascii?Q?EV52pguajwkaOlHjwDehqhcaWX/42WJXIdb0aHHuvX+xb4hDSv5t5W61k4fk?=
 =?us-ascii?Q?luaihoSBONbLw6G7uSPJ93KhEUl4eMkJEzJipzQPPdBgXkWhBlMGkIoj78eJ?=
 =?us-ascii?Q?HpiCC16XyfkBqWrx5a3KcwVQprUNpXxtCJovcFIeF3HJxfpMjBLXObxsbN6k?=
 =?us-ascii?Q?D3T7oyLKUBSk4IXUVk58ITkLUieb22qpMxBMYcp7PZ7hcnBmlwc84jmMryMX?=
 =?us-ascii?Q?y61ysgiH8xhVVzWEQBdzYlFuuxBne7NKFjopTKQqQGTmwYzXZxoBZl80KsDC?=
 =?us-ascii?Q?LFJprSjikX8/e755AW7ylMfzswkSJ4GYPjGhgI/UfF55zteGhJLiE5+s32CX?=
 =?us-ascii?Q?Drqnf53LvWLF0oX94Prk/VdOFqct13bQFZAocGEG26imUp32tsPn8c8nFuFL?=
 =?us-ascii?Q?PEk+uFSvF0pEnpqZohKjTMywSZqGdYiJRdm9rCs5gu12if/AWpM/NdM3KTL6?=
 =?us-ascii?Q?H5a+UlqlyxHdd8mPheBxvIlqwQ+WssicThNYF8tacOWxGbiLL289mVk8hYYQ?=
 =?us-ascii?Q?tdywe4r36WAEzXHg7KhSv2s4Mi59ney5IH3xyXnFzLjFSenIFjksCpdrddMh?=
 =?us-ascii?Q?fLajLZVCpD0vCng9iZBkYxvJZ8+Ju6mU5zxSKgVzt1OKV1y3GtGymPnRUcns?=
 =?us-ascii?Q?syDdPFOnh2SNVDwHWLWPHszO+cE6pUiDJshK0VDp/WBwGwQ4fsnRKmvWaq45?=
 =?us-ascii?Q?GdtjNiBkRaOPKjVyZvA+2YYR8BR0qKp2qux6BE4glbg2VkWUn90pHE7bhE7P?=
 =?us-ascii?Q?9oD4vKkqjAvxQgyd29c6T8wZmbk7FvfmqFPqEl2YKiLuxUpIvNkOEZUa3t/v?=
 =?us-ascii?Q?YrwN8q3yWg33RlbUqk/H8D0zhT33lGgABP8FtnXzUHw/G9bjxwYpFta0Xnxt?=
 =?us-ascii?Q?EeWXK/pNXc6ZxSmIMRiC9v58PQZPaeGklzgN?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:52:39.2334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dc1605-0886-42d9-3fdd-08dda2ae4941
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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


On Fri, Apr 25, 2025 at 06:55:12PM +0300, Alexander Kozyrev wrote:
> Enqueue generated counter IDs on a ring in bulk.
> Generate them and store in an array before putting them
> on a ring all at once. That bring better cache access
> and speeds up the mlx5_hws_cnt_pool_create() function.
> 
> Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
