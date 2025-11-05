Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B64CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 258AC40A71;
	Wed,  5 Nov 2025 17:54:40 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
 by mails.dpdk.org (Postfix) with ESMTP id 382DD4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:54:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVLGBC+GsIK4u0snHXRGB3MTHYBmaZb3OQlBg5g0m9Qmx06MP7a8no/3mLTNPhB6QH2lN7U4swfn0rExDsRZTEvy/0Zujj3VB4dNaT52HhHYnhAylhG65QRRWzVDCXR0nLvwdgqLRNYtHsv1E00WHl+BjbaSclPMWt5xFV/eB6VjjoDraZIwHy64FAha2Ivx0YpTQmwCwyCUte/Z7HO0K5SmlsxkYFwBMUKMgoL+qZ8TLqZX4LBeh6CUxS/+Lb9wN/DBVPhlMfoy1MYn11nnU3dEFplUYrCGyDPN5sU1ObCGcj+JIIx7A/MoGoo+yKIJITW51VqDqWBUpZVwnoGudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPq5vc4N1gnq0xuGHw1ndENw0D0SPAVk5Hj5qzQrXKY=;
 b=rEjIoO/ley/O3JOW0N/jW3A/q+4OzyZh20Rk3hRdOpuGGWqVNuyurZtnIUxWOvbwHu9kO6fRZ8x6913UKV0D1VfZ7gEZ2+GS4OfoveXYN7mlbGoFfg3BtdLFwvG3QdVfdvVnVd5pQHjS532IREnQyDw5EZYLAEORUed3s3pEJy3ClPkbgjgl2xPRYFxR+/Rbijgi6b1PRpJeiA0h8Qo8YZXJxX4pEuaN3KiR7jli+8oz0UnVrIlMGX53ujythO1GOFlq3ueYoJHwjmKv+xj4AYcTaX2sI1qmAlJ7HxBrA0J3jJ91zzivbGoTmDV2imTmDvE90dR+MFs6E/FPIk54Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPq5vc4N1gnq0xuGHw1ndENw0D0SPAVk5Hj5qzQrXKY=;
 b=bYgfZhrjW75FFRFjgluBz/Is+U5bl4FsyH1ujRIdAvnZB2ztfki/+nWWYyxWSi5L4K7ArXizdSjt691CCzT28t4wFed3JnlEgNbyP3kvp0MOxPStHF1n2ptCyG/N3HQSmM35AsctzvvdyALxPnyPJMF6LQKOTm0GuKC0lBmHIP3Hp0OaDumV+xTdfSLqEie4o7nz13xZKPy9+33YvDYdOEOU1HuikZpoGaD8QMOPfKjK1pSodCOW33CK2Gi5FNVsIhh1mlTEUlX1reZLB8VveantD7yKfN7e0XVxENNF5tGsJVKH6QQoqyjy4GXLJ9E5bWnJKC2LPlvpWdjJNvMH2w==
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 5 Nov
 2025 16:54:35 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::cc) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Wed, 5
 Nov 2025 16:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:54:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:10 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:07 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2 0/5] net/mlx5: support count and age actions on root group
Date: Wed, 5 Nov 2025 17:52:53 +0100
Message-ID: <20251105165258.1396352-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104174612.1341962-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe1f776-68c5-48a2-ecf3-08de1c8bffde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4oXOwvYJ/59Cj6KMtiuMTGMjyV5sXitgw/LD7IhzIkWutoxJn0SH8/aU2NlJ?=
 =?us-ascii?Q?KRX5umX6ibRwofgLs7IEW+8hhTNwhgaFm2cotsK0wfTrRB4+TkDMAA5rffvs?=
 =?us-ascii?Q?aZY5rGPJ0fDzBnnvhfC/yKFU395OzyCSNwZ/64ClDI2a3UWMM2OMoZE6myPN?=
 =?us-ascii?Q?1V89UbJhsShXLQh0W4J1N1rmBYrLldPplRgQUWMA/JqFJ62oQAYwjLuonDTl?=
 =?us-ascii?Q?66JWWq2e+Bv50lzv4oTLJcaBIaXRifJP81akVUkMJguiKJLD8BLicokHhsnl?=
 =?us-ascii?Q?yzY2j24qMxfes061bgVz79uq1VwgwUQQMK5m3nfncCFb5JaFO7L8+Cl0Ko/O?=
 =?us-ascii?Q?NY9+jhQ5yVL0zlfzzw+BuOm3rK9Glh+qH72qDaNBQdEsLicQV5EW+xG2ED4N?=
 =?us-ascii?Q?X43tJWzzkPgynO8bcrq7r/1kholBi/EC3yMFcFHvKZkOUaP8vGvEa+SyWk10?=
 =?us-ascii?Q?REk2ME/2rmumKeNO5mWOewXEuYOrQTG+2EcqlJUoQyLZu2Jk8eoSIOAB3JS1?=
 =?us-ascii?Q?zgHwTygCW3ndPCRblAezn/nLUcy1T05QSFiRUAva0lJuUDZtGhTWpS7ARd5K?=
 =?us-ascii?Q?XdZqtBaqmoZFAXl3LZ38hKuHc+6MZqaWU5inBw/GkSQ+x3UUKdP0DVrPkTJS?=
 =?us-ascii?Q?tYpeOi8yn/FkDEI3C9Q+juHa0L0/xsSVFLWBxsUlsEHDDVlkNEt31FTdgy42?=
 =?us-ascii?Q?mjlZRsMgnNpBY0/+T7VLsUq/DjJErWDvXapAY+HxxPXKBd9yWkdpWn9hF2CT?=
 =?us-ascii?Q?tU1J0Ro8HKuQjfpJnIb0E+Pjn+ruKfT31TK73qHNE15k8U6/fM47OKQkEITw?=
 =?us-ascii?Q?Z0+lj+AKfGkRUd9RjlL2j2/DdAuHsdijjKeo/fvyqh76cG6RD2fgoO8eXBjQ?=
 =?us-ascii?Q?G5ZwWsxEbgk4aYQJWs0/UfKsdn5AqKkr77fHQrVJVeoKeVVFjC1TuRiHtuZQ?=
 =?us-ascii?Q?hO5boPia5xn7v3IFOFFhs8hh+tI1dmQiUXZynLz5OqCXfRiKbzJrjMi+rrmc?=
 =?us-ascii?Q?UEbt1+fMVkTQLrcE/6vxZoa8rQ6G54Pt/rRAsVKePVDE1bbg2sZgzDAuRoD7?=
 =?us-ascii?Q?fSpnAOcT2v8LCJgd9WThMLhgTJ2MsQlXSB4UIzLseX1VXGMnyOgJFjTMIomS?=
 =?us-ascii?Q?RVb7Xw/fTMiKmi7x5VJNB5/qyuVPpJ30dCpCcL6ZUwxJOQBidspeDNVDRYtA?=
 =?us-ascii?Q?iKQK+Hl7J+R0BQH6umbLRLGrFx3ajm/R7BHX1bzUWY3S/uVLS05gmKGxk7rb?=
 =?us-ascii?Q?bch/b7gEyx37oVviJoJ8WqW5SnnczaVBT/CWLCxqEmeLkFdqE7prtjagY2Ip?=
 =?us-ascii?Q?BwFCzl6IvrOAXKdAV6/DfEdIhQgLZgjwRLEBXkPvqbukN8WwMD69WQVP70oo?=
 =?us-ascii?Q?KAynB/7Si3CthoIv8+ASFLvk8hEz2LQXBjYtBQX4UuCVsoO9geJt1Fi608St?=
 =?us-ascii?Q?Sqlt2ZhvQP+Z+/S+6byHcFiDhrHkCYieQem9DNSFf1HQzIkyclrHx3dA3DVC?=
 =?us-ascii?Q?DvcFNP1y3epAzxHk+Ko2i6FIJdCg6hWfreQaJKassLEsbxXqD93Dwsm3QVLF?=
 =?us-ascii?Q?LKkNpuosEZum7lSGi8A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:54:35.0646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe1f776-68c5-48a2-ecf3-08de1c8bffde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

When working with HW Steering flow engine (HWS, dv_flow_en=2),
mlx5 PMD does not support using count and age flow actions
on flow group 0 i.e., root table.
Flow rules on root table are special in a sense that
they are created through mlx5 kernel driver using rdma-core mlx5dv_create_flow() API.
This API however does not support using counters from FW-allocated counter bulks
which contain more than 1 counter (extensively used with HWS to optimize allocations).
This affects age flow action as well, because it's implementation in mlx5 PMD
relies on counters.

rdma-core version v60.0 added a new flow action type to mlx5dv_create_flow() API -
MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET - which allows the use of counters
from bigger FW-allocated counter bulks. This in turn allows mlx5 PMD to extend
count and age flow action support to group 0.

This patchset implements that support. Patchset contains:

- Patch 1 - Fixes for indirect flow action error reporting.
- Patch 2 - Adds detection of MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET in rdma-core at build time.
- Patch 3 - Adds support for counter action in HWS layer whenever MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET is available.
- Patch 4 - Reworks for group 0/root table checks to allow easier implementaiton
- Patch 5 - Enables support of count and age flow action in group 0, in flow API implementation with HWS.

v2:
- Added logging in mlx5dr action creation whenever count is not supported on root.
- Removed redundant is_root_supported field from mlx5_hws_cnt_pool struct
  and replaced it with compile time checks, since feature depends on version of
  rdma-core available at compilation.
- Unify error messages for unsupported count/age action, so all refer to root table.
- Added Fixes tags to patch 4 from v1 and moved it as patch no. 1.

Dariusz Sosnowski (5):
  net/mlx5: fix error reporting on masked indirect actions
  common/mlx5: detect DevX counters support in rdma-core
  net/mlx5/hws: support counter from DevX bulk on root
  net/mlx5: rework root group checks in table create
  net/mlx5: support count and age on root group

 doc/guides/nics/mlx5.rst               |  34 ++++---
 doc/guides/rel_notes/release_25_11.rst |   4 +
 drivers/common/mlx5/linux/meson.build  |   2 +
 drivers/net/mlx5/hws/mlx5dr.h          |  14 +++
 drivers/net/mlx5/hws/mlx5dr_action.c   |  20 ++--
 drivers/net/mlx5/mlx5_flow.h           |  17 ++++
 drivers/net/mlx5/mlx5_flow_hw.c        | 123 ++++++++++++++-----------
 drivers/net/mlx5/mlx5_hws_cnt.c        |  42 +++++++--
 drivers/net/mlx5/mlx5_hws_cnt.h        |  16 +++-
 9 files changed, 185 insertions(+), 87 deletions(-)

--
2.39.5

