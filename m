Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90BC7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 18:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAA6540613;
	Mon, 23 Jun 2025 20:35:32 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by mails.dpdk.org (Postfix) with ESMTP id 476AF40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 20:35:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0hV/poNFYM+gJTTevAO8RRVsX4GPTIb9iQRt6wvBviAmJrANYlJaiCX47xnRiPZLM8YhBetb9b7jAEBF/zTH9GK94LNJTXIiIm+eNCNEJpDhUeqaZy/ZnduZRQ84xYfvY6WCEgiGviRy3FESo+B48bhWte9Xgd9bMSQm+ei8fX3EPcCBNSEb6YXVMPuHJmlQ0Jjm5QY1LG7WVioEJNvtrjUcF/Q4qLQPLg/+CHjD0fxOlufB8j7c1ac3wgW6t9xpjdFpXMq00l20tcb1G3u0DxigQnMonZtHuHjW/AbQIzwe2ThmpNY+/ABMLVz1ySTDQCba9REjBEmXydywrVr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex50KQBXlmnnc2kzEodJLaIDW/QdptHd6sF5wxkZZYo=;
 b=I7oC3OIfA+tRWM52Y5hG9KeV3HgtagoKXgVXss2J+NOv1kJIw5E8oJvpcAKbXZWBTTH24F51T7bu5WbhbPpUnNGTYq2CXU2wslxndSLdSYIGpSEFsa/FPvweQe/LtfP79cQjeq0XYX+Q8CRVuTJpb1mD9F5dxXwkAv6+B75/nc3A/rVzJV26pvh1sVRRDMZ5uDyGyXrGMSrcQa1HgQ2TN8mq8zfldI9ucxF3yl1DqXjLDoDoxQTjMwF8gSVg2qrlEn0xsnvaIlx++THCaVvW/kyROqkBBl/EiOHFfkfxOZ44nVkL+1wVt64ySX8TCrNS4aHOiTVfHprYR/QdjCX1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex50KQBXlmnnc2kzEodJLaIDW/QdptHd6sF5wxkZZYo=;
 b=cN6QfHA2h577N/X1VDR+FRLsmc9cw/7bBI9h/dlEtxfzdnUMGpfmklncrhsGoroxY7ohotePMc5ywkcAwDaubFILHEi83h5JShPr1OAyCTr2l8qja6B3PZJntSLG8PMHCguOiPuxJt3J5z27WQozheMrSdSjvRPHGskRHdoePsn6Acls2HRi/bPdQzl9kE/hb+G3cLVhQ6LADaCPhUDWmK4dE/oKhh/WbPQUIE6DbWSV+sbcoyZ5OnfjrJW7SSWE81a5IuEvNywASnhpKmnR1D3Ff7ToIlaF1JdEyLiHJCvjRojRguAK1TgXb5QT+S5WQKkiWxwJADx+cgpMT12uyQ==
Received: from CH0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:76::34)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 18:35:26 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::74) by CH0PR04CA0029.outlook.office365.com
 (2603:10b6:610:76::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 18:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 18:35:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 11:35:12 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 11:35:10 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v2 0/3] Use consecutive Tx queues' memory
Date: Mon, 23 Jun 2025 21:34:53 +0300
Message-ID: <20250623183456.130666-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623173524.128125-1:x-bingz@nvidia.com>
References: <20250623173524.128125-1:x-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b268d76-3eee-40cb-c631-08ddb284b8a9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUhojEkakvdXyteXsCk7/K+ZVNziqlQ4Ucvs8hv/gWAybV2Rb38wtRssMjYQ?=
 =?us-ascii?Q?BE7VidcKmKZjSWE5mAZw+xXIFuKU2w9hRQlTin9k1a57iSSNuLiIg7rMJGe5?=
 =?us-ascii?Q?5XlGaW5Ozqp2dzvg9hl04TXu35IhCAHIsp/t10Hd2jiWTwpL0QPt+Ne5L1vj?=
 =?us-ascii?Q?VD6wEr+l2/Nec/X0hHc/lhuTkIzbZLlm3aOe5Z76X+Bb90SqG4kKyMSd1w6W?=
 =?us-ascii?Q?+XGMvdJATv/Wh0L03aJ2DeWRu0f2nfLEYqwplMT81jG0ztRwt4/vs1HIHsHc?=
 =?us-ascii?Q?eIPQwWcsKIQi9sd/EfwvQqSzE+FsZMsf9YI7vFVMoZGssifoVG28BCnVNNLf?=
 =?us-ascii?Q?MF02PYN10dpErgOTtSOWkkX0a7ra/KSb0sY+VfogzlMgQQNEJ3Ev1X/X5mlD?=
 =?us-ascii?Q?krTpz842PKlDazaQFJIlllCV+cRIamb7mTbqqfkJvfu9Ht2tHN/7WOv7RA85?=
 =?us-ascii?Q?rBBraHWZvjdaODjm0Bbfd5BaGYnQ+/+mPhqPqZl+8r967TRI6bgI4Y4dmqYm?=
 =?us-ascii?Q?stJqNASD5X6/HjkwrQHfM7Zt3xLe4X5zFfp/IfJGdxIktOKQYgS4X32Ln8yZ?=
 =?us-ascii?Q?CxCc82nQtF7BCnsjCeoXj79ddgYKxY7XvYPksg9wZSJ2wo9LUEp+qlDxIAD9?=
 =?us-ascii?Q?r0rqsfCxmDfxrvhTPoqRbO1Ta71GXQ00wEBPLKFo36ncsKffGlKCtZV3834g?=
 =?us-ascii?Q?11LmyWCmVwMOE7x7gMK85FRjJ/WkboDJ/+x6+XNUKNIwnVygTZI1+bdj1DEW?=
 =?us-ascii?Q?xcsZivChDlnAxFQDgXF5h/s5AHgkN1x77XbJiV+y21U2oeuIkloDlhg2IHYP?=
 =?us-ascii?Q?sj1xyT+WsT4O+iPOQPKnAIyAp1rRt1rDnQFphwuB0Tqra0AClU/2YSccInTr?=
 =?us-ascii?Q?zS3I88sBurMO6np127+bFwHmgXwY7qFodfRbo8fLPqIuqrOrHwrPtxKVk9Df?=
 =?us-ascii?Q?kjlFaMjfueKda4XNJxWnlaAVMEddRtPcnJ+u6nzDA2cGB5Y1hFRiKQ1EMhIm?=
 =?us-ascii?Q?xUh5mBOSGK9pTbIqqkIq+cUoU8QoLq7gnQtD6bxummeR8SgmY2TwWd7fnIMI?=
 =?us-ascii?Q?/2rkjCttpCXX5iTtYFzr8Aqih9jmZJQwZXGNz79m09XfpKpyAhwRbSzR8x2T?=
 =?us-ascii?Q?PEUHbWEBAsrQAItzaZYgNpNLHWWPfi2rlJ1xY2s6NBayTlZW9fmFHMkb+U4T?=
 =?us-ascii?Q?yvzHhHNkT7XZOo02mkvq+RCXzgGDiwzRT9rkLqY5uoIUZDDDmTipbPUqdtog?=
 =?us-ascii?Q?M/fL7kRFoInuL5VGx1fMrFUVi90tFEea7p6NN5nI4+eaw7N0DOgEjraMx+OH?=
 =?us-ascii?Q?JcVJoHkgAUaJb9H+axzC9httlSkEz3qlJj1p4gj8pfi5UZ1UpSpwV3pmrt7T?=
 =?us-ascii?Q?igJs6NJK3fukl76fHbxaQBD6hTclryEXb7WhxbJLpYLwj0QpFZkeDpOzcbV8?=
 =?us-ascii?Q?35qq9lFn+dB/VU+YUGNwAEBWdAV5ST5ReFuhY7lBQWGlHTupBFMT8IbT3bsi?=
 =?us-ascii?Q?ViiroBCHMBFUUxmXmsL8z2iL/EAlzE4tiDTA?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:35:25.8721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b268d76-3eee-40cb-c631-08ddb284b8a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

This patchset will move all the mlx5 Tx queues memory to a
consecutive memory area. All the WQEBBs will be allocated based
on the offset of this memory area.

---
v2:
 1. add a new fix for legacy code of WQE calculation
 2. fix the style
---


Bing Zhao (3):
  net/mlx5: fix the WQE size calculation for Tx queue
  net/mlx5: add new devarg for Tx queue consecutive memory
  net/mlx5: use consecutive memory for all Tx queues

 drivers/common/mlx5/mlx5_common.h      |  2 +
 drivers/common/mlx5/mlx5_common_devx.c | 77 +++++++++++++++++---------
 drivers/common/mlx5/mlx5_common_devx.h |  2 +-
 drivers/common/mlx5/mlx5_devx_cmds.h   |  5 ++
 drivers/net/mlx5/hws/mlx5dr_internal.h |  1 -
 drivers/net/mlx5/mlx5.c                | 14 +++++
 drivers/net/mlx5/mlx5.h                |  7 +++
 drivers/net/mlx5/mlx5_devx.c           | 34 ++++++++++--
 drivers/net/mlx5/mlx5_flow_aso.c       |  2 +-
 drivers/net/mlx5/mlx5_trigger.c        | 56 +++++++++++++++++++
 drivers/net/mlx5/mlx5_tx.h             |  2 +
 drivers/net/mlx5/mlx5_txpp.c           |  2 +-
 drivers/net/mlx5/mlx5_txq.c            | 30 ++++++++--
 13 files changed, 194 insertions(+), 40 deletions(-)

-- 
2.34.1

