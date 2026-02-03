Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65421E8B36D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 22:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D4D44029D;
	Tue,  3 Feb 2026 23:29:25 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16]) by mails.dpdk.org (Postfix) with ESMTP id 09A5C40288
 for <dev@dpdk.org>; Tue,  3 Feb 2026 23:29:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhnWvATGV7Rhz6Myjczsr+Cp19dcTyT+dzg8INVH2SJWC2ckm1swZSAKQogGh/THwj7bM5nXxxWY9sQ4BpencbW6pcmZLnqOsHGl5zT3w308Mvuz10wNLVauyPM9deHXl6J8F9VtDeowQtZd4s7upK9YCHU4FpnqMbYieKwRVPbDdRVLLgQpf0QXbms7UdIv0gOctdlS6ZHg2b+GBJFsYsBmIKCIR63Fpxj1dfmvZvLrRfx8ytHo5s7ZLnfhXY7RlawVyI/16sej2V0XmYjIH0R4HwQRNIgQB+zSSW1XSXgnVhWrLhxB5uLnFSlrifVSXhkJZfXB8BWyNhe76i8rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7ukPwoX8N3B4/RvCNwTD8bk5CBteg7x0rHcorSecW8=;
 b=fcMLiTeRhirdOooylVOZhxM6yi3GD+U5wxq3jhhPdEOl3KkNJYrDgbeCU6N+mGhWqXOQIkol8R5/ObUPrVRCmN9O9frHYPiFiieDX4vSfTYJOT3mJ1xapyUZwUEH1fvQiIxVNEzOHy9h3+jNWDRFOzgHLF0I5ZRBWFQeA+qlpAzWbwAozT08Z/th85CQhIVHGupBUSZw5qzpFod4C5dzP1OItx3dQ0ZqDADAIP/ohJZbhrL373LGridZEeo3/5FzAx9v9aXXxvT/zbAOfrUW1O5xqAcsVxO6qtPQKgEVT2Mj5SdwhRqCRQqm+7hoMDjVe7VlTGYY5NrmklS7tE4edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7ukPwoX8N3B4/RvCNwTD8bk5CBteg7x0rHcorSecW8=;
 b=JFCFM8+LZvYwUk/YMCsRrvtXHYUh2oZY5Ktkjs0nNvL3u6jE0bvFKmlG1Yl6sh3NDGSXRWtSfuP+u2d1pD4N18nXErx9aC8eYrNpu72HzdsWyn7sqtap1UCB0VgyKaBChqW52OLEeI9HE1Dl9zn51PLfmPBhuAoZoP4+UL4xgwCYZuDWC7bWhlKxtBXoUWCRo0ITXgzoxF1eDSTHjgsnUKEabsVy++mVwK9FmCYbY6chTriueeeYzQcQsfPYE0CnVnrPFmvj/Kt5sAY/2RxB+sRpmQpNgJOBTMLLB/jOpC67H2F7L9EoJ6grc7uFlwnTCMDi8sVu5AHbyuEy8aog0Q==
Received: from PH8PR02CA0023.namprd02.prod.outlook.com (2603:10b6:510:2d0::15)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 22:29:19 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::e8) by PH8PR02CA0023.outlook.office365.com
 (2603:10b6:510:2d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:28:57 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:28:56 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>
Subject: [PATCH v2 0/2] support dmabuf
Date: Tue, 3 Feb 2026 22:26:39 +0000
Message-ID: <20260203222836.2862414-1-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127174429.1504288-1-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: fa80b402-c872-44be-a165-08de6373abaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q3ca+D3jae1Vj2/LiWQjmCTCQCvHO8ASkRFhzI4oG2fVMLChbI51yOJB2+G9?=
 =?us-ascii?Q?RiIHuDRTwB2H4F0f4Lkz5NpvZqrt63DZqlbgK1FzBD0X6lERz/MF4410gF92?=
 =?us-ascii?Q?kAy/3EIn5D0gYghNAaB6JFaMhpXUcdfsCVelOilf32houPpVbUuSvfv8rLt/?=
 =?us-ascii?Q?8GrjuJV3JC3rJ1tJX1jT7RHvz8Hn9SghwqSCPXyuuExchbEBFpcqtRwPaeP7?=
 =?us-ascii?Q?k65+ykZAiLfb6vfm+U2UyIe7+SijI/AZSjayLKbyineAMEAavD/5mFMErHyU?=
 =?us-ascii?Q?SciVyA+vIQWsuzEusoe0lhopAuyIlffM1hzh050XUFXAo1jfCGNUYUUA+mTE?=
 =?us-ascii?Q?8TXM4jqB8nVLn1hSv7/cuOi0ncFSxzBmxNWVCq9Jw8A5o1v3V+Vh7CtGh33P?=
 =?us-ascii?Q?YggHfzgqxk0Ck2eb5UUY2pvzuLqiKPCQ7bgsv11WlJRL1FAgq3J0k1VZ94W8?=
 =?us-ascii?Q?TNMGWwDX8z1VlK0A76sD3/tJwI8BsYJH90o3m4AlKuCibKm6ZGjObRk8GB/O?=
 =?us-ascii?Q?j3OC8kkf3/AjQi7xJ0dKkarffUtzE8Jh/6fa67+Miptb707B7sqXKjqXzCbt?=
 =?us-ascii?Q?SidapB7ldRljke10+iJ3SgsF94FzIL0LFwXfuxrFKbEkxDmtA7TqWoSxr0N/?=
 =?us-ascii?Q?+nnTXoufWagSlQR6TJOTaNMXd1/KK4UoDMBOr0ZF8C9Xdu8mWKuFVxS9jmJf?=
 =?us-ascii?Q?klUdLMOWXlCP6njL6hV/Vzg0kiePpUApIbE4iCAUTNjm5WtRZvBTNpVRo/Ew?=
 =?us-ascii?Q?njHCorqtD5ErWxVAiFs3FuLg+86swvqbdEFK1s/XpU31obt/YyqLbTlJnvST?=
 =?us-ascii?Q?uKCH6DwQcSWHn9OLjT+G3K+4+r8/ES1nhpHT2BbAsfOYD/fFiy4i01sYx9HM?=
 =?us-ascii?Q?3DWA7N/88Z4yr8/wdEoDoL9Ym67py8oyN2N5bDWli01XeM98w+xuu2RwM3Ad?=
 =?us-ascii?Q?uuRL5gBDljH0CouyKxfgtBuf2GXqBMaiPF29+BPh2kVn4OHMphmH+m5JA3Gp?=
 =?us-ascii?Q?0HhiXtVZPQe+vHArx+uJDnFQZKUJIThw9brsOg2R/RSaSBlqGr3j7aJbz052?=
 =?us-ascii?Q?h/XaLpy7k/IG38008ULK4TQargzttmFaZBB8028oA5cIVEewfDlgK5t4pXwl?=
 =?us-ascii?Q?oHhNrAeXVS7K7f3z2bVbRlOaWxDNWl9xqmjuDk/nG7PlCpRmrA9HII/0l6sO?=
 =?us-ascii?Q?1xRZF8ew3dYv5KDrzSSfhETKAhrgoxgt80etksPhjSJ7rAIn36xukcBVPHlY?=
 =?us-ascii?Q?ElamReCAFl03Vm5ESTzjwLS4+ErFbsq9nZaQlrscxvCwkRv44+ukVWmbVg9L?=
 =?us-ascii?Q?5bmdvrv1hpOYU97qIvpuLG+kUja/q/61gHJMRbP2CpIUdFRbjOkFRzMgeox2?=
 =?us-ascii?Q?UzpTrAVMo7WYGeIh7nscBGQavHh63heQ9n9ZJkgDnHnNZSFyZRX8Wz9AYx0n?=
 =?us-ascii?Q?++wDI1/SYHQyg2iGWEZW+G2A4YdmRgfugYvGR5NxPx0E9SEuV2ODjfzOc6GW?=
 =?us-ascii?Q?8jZ3mZz0F5K4alGvwqINrGDxDYK3wrJnJTSGhtnKOdh8OeTmgBr1ZHtt7BB4?=
 =?us-ascii?Q?8mHF2NnheiVzvTt5ZbGDGEmhCuaDEIF8lztCqlt1H5vb/k3wPa+2hVZYgQ8x?=
 =?us-ascii?Q?Lb5qScj2azzvxpjeHEUawWSw7cc1bryuCGKm228jNenK937dh5iuDcSObD2I?=
 =?us-ascii?Q?NkxuCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SXlfRadEKiP+lJzWfrgf5FCISJPHY+sS36Z+BP7h0UF78bPF0TsI08Zs46uZzHn4jLok2AS7CxAD+WC9wwjCEBN56GiIyiGDmUyPUTMwDMkgSiUImGTYPS7rDLP/f8JYyZhJtX1k6fumIGyHeU5Ma/kVs9WlzEDq3kkj0C+/t7+57kUoCF8NltJ885sYrdNdF5dvsLBKr30E3ZSV6TLceL4Z2ewnDndZDhH9CeOMop4UjxFlvSmr5/lloQ+s9frAlVv0rn9pV5ksOChqwV7TtJTEL/KSu9MnmmPTrHG1p44bgNXEv+bVpqWf8+n08r/jxMct9ABem31nhN9Hyo5tyxFMyFpwDSKe6eX8bmM/9jOM8HAlw4ZzQMf9GH/0cTN/KTY6cuiiKCjByL9LgTi4twFF7cKOoqS2Wub/3KrOvXujBcbI8eQH5sZDcZ6ccaGZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:18.4108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa80b402-c872-44be-a165-08de6373abaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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

Fixed since v1:
* Fixed issue with MSVC compilation
* Fixed style issues from code review

Add support for kernel dmabuf feature and integrate it in the mlx5 driver. 
This feature is needed to support GPUDirect on newer kernels.

Cliff Burdick (2):
  eal: support dmabuf
  common/mlx5: support dmabuf

 .mailmap                                      |   1 +
 doc/guides/rel_notes/release_26_03.rst        |   6 +
 drivers/common/mlx5/linux/meson.build         |   2 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
 drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
 drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
 drivers/common/mlx5/mlx5_common.c             |  42 ++++-
 drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++-
 drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
 lib/eal/common/eal_common_memory.c            | 165 +++++++++++++++++-
 lib/eal/common/eal_memalloc.h                 |  21 +++
 lib/eal/common/malloc_heap.c                  |  27 +++
 lib/eal/common/malloc_heap.h                  |   5 +
 lib/eal/include/rte_memory.h                  | 145 +++++++++++++++
 17 files changed, 612 insertions(+), 14 deletions(-)

-- 
2.52.0

