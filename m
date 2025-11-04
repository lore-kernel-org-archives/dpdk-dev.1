Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6325ACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7ADD4065F;
	Tue,  4 Nov 2025 18:47:55 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by mails.dpdk.org (Postfix) with ESMTP id C5F7E4060B
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:47:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn895Dr6fMipi9pmjdUrROp+vu7O8OcFYjrdvpGmaYbGfC9ndnBp8ExkyBV46X952AZp6D73iZjZVSQUpocB2THli5M9OxvT8+1LtJA6uvIhX/lKKrES9UqwB2yKFIlpZq9e4XnXGbFFpbuT/w8kMeYnybeMa6IISEKH049qMNrwFphZVrNH6/tvJBcvO2+f2JOvLtvpavHkIaDuRrQFh7VeOl59VlGznx0g7V1LTkg3di7Hdp/WYH+jDFU4fDahhwLOx/zu/iul+jDMMXwUnH5W74NAwOJ5PrhFsK2Mg6aaaRgtvXk0T5rvQG8eRwepXU47E3Sv223IB0HhB4fMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVTRX/1lJOX3oLuZB7hnktcnR2vpzHr7XLKs9IClSA8=;
 b=uHRKYdo03q5wQwok00fy61LyNkBE58HznNy+MPlyMTuliYGYfJm0TgUWOqYV8CHXHFFgyhRIrHkcVFNqCOSxDoS3WKu6ak60tlWshSviVwfAH2kJN54+gEKMigI/FiJitLKYtcoC92cK4/pYps/FjDkKfGGV+v+NyIAx6fGmx7TATJqhQ0q6RuujrAflLeak5c/dq3Bclqqz38JiTEYuAmlDkx3Cmq6ArbgbFESdAD42qmhBlYtiqB2xMDnFsMl7S7as62nL7sSl7hIbAjTpsgvKi1Jg68dGKnJDQsDD/9PvzmPRRyib91XaLz8RrUuWK421NE2pPtVSxQtWMABq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVTRX/1lJOX3oLuZB7hnktcnR2vpzHr7XLKs9IClSA8=;
 b=U/rRpcpSXBJRVePGViszRgeXEU/jvxxyHxcRDBXfFbjfWCGG4xPpmJpQA3MxzfEyhYe008roqZTp73unGQBL0NQUSG26hC3RzwmD+1ZDSIxxrS2JfccPS8iJWsWvWB1fbXtNdNe4TjSRQl7hX9TxhDmpYo5YOWr4Tvsw0NTDRx020pIby2BzBtXYAOWpFdqxE71YbQATCC0KCt0CdMleEx0M4RaEuVRUQ8MxrPEhzsM9raBMz9yrOFsm4CPArjdvdbyEiUPZ5SIe82SmaFKjUYyXkMwOm9m23BoAG6NaQ1hxCMba67mZT+C2gF8A1508f4YAAIfWiAnha5CKIf5zTA==
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:47:48 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::f1) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:31 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:28 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 0/5] net/mlx5: support count and age actions on root group
Date: Tue, 4 Nov 2025 18:46:07 +0100
Message-ID: <20251104174612.1341962-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: a01a3c7e-8c66-4d72-368e-08de1bca44e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ITMKNvHkXYjKxqp23Gt5ARk2BZF/nqeDadoCrjHBPYlKXHfN8DKhjeU51Pe?=
 =?us-ascii?Q?VaXSS4SwluayfeCZ/IKd/6jxKnO3tcjFSE+VP9pdKfdsn5DfX8uTLr18ptlr?=
 =?us-ascii?Q?0i4Qh1JVs0jQqqWqwYdA9H/ZNC0Mv2sHAOOJ9JwdSGCiRAMfJwZ4//E711C7?=
 =?us-ascii?Q?Ru+EmmrUeML4w8py3uSv8l2M3pRHSDX77s82fjeXOeaUqRe+YEbKj5qHOZ/j?=
 =?us-ascii?Q?L1M91ZkMNuoEm5QBCl4u7WWEu2KOpsZDJqupXinTF2fc3ILkj9m+YWYOHaVA?=
 =?us-ascii?Q?XDmYBzD4/vpue2V1a4T59y8jI1OcCWKzf4u/44dgEnn6ID4Fbgf2QjzeVXke?=
 =?us-ascii?Q?ZgAnBdtCpLC4pn5O/nUdYTSr5HAEohdG2Cac/dN8J1U663Mzyxq9+h3+DGl9?=
 =?us-ascii?Q?Df29D0ncnEaA6AjlxuMvfZUsIVLirAsLGRO0UWQOYOEDsiikD5rruRkQFd8n?=
 =?us-ascii?Q?13dRaJBolGe8Rg+iZiwJbH9Z0tpYY+ZooENa4axrlXjpPkCllb1f5QH9I81Q?=
 =?us-ascii?Q?itLJf96RyXX+iRsYsd+BB7ZCdrI3heB1vKATIaSt7oRQ/8ZBqYQULjuOScma?=
 =?us-ascii?Q?BQjpyE4eFyFIQh2TWLKFRcTI7r8c6JiXpyvslEq6R3w7ua+ACFn00/atQ1G3?=
 =?us-ascii?Q?sUio2uFN41DI4+m/dZYCBXZ7pyWAayFRTa+ecSYEuxl/uKlix0/ovfUfF2hZ?=
 =?us-ascii?Q?aJs8kXiwFkxARBobGBBFBSZVC4MoXpdKh45bZOnoZogGEhMDEjhxPT4cO6Kl?=
 =?us-ascii?Q?Ibal02N/l0IBHmOBVOAv6RiWpwj0aNrJOrQ+18LJAKWFSl1/vwHcPswTdjB4?=
 =?us-ascii?Q?6g7d+y0JWn07I7LfNkmVRtDIyNGLOc5C1z2wBqciqffPN3dBUoQuvq0nVDRA?=
 =?us-ascii?Q?L/7Yk42+PrUx3kH8/JC/WMd8T1yNYlBJYTlapbQN2R07FzzSohv6BsA4b6K5?=
 =?us-ascii?Q?PUGUEl3BJsLNRl2KWhX/Ta+iI/4fD2sohBn5pYlyHcoki2XSKJcMZ9EpJkhF?=
 =?us-ascii?Q?KDpwIjKABhyPIB18ClGm7J02QQS+r+gHw5I/LdRJy/dG8MxxIPSaXgL53mBg?=
 =?us-ascii?Q?X3JzEGcVMb/EZAnW9ZHcizkm6IMxcJtX8WNbPWZTbewQzFsBJXYldfSNjS+n?=
 =?us-ascii?Q?UcLrJR6EYh9Mbw4TTtOVFIa4rmw1/4W0Lvf/lFCx7Jmr8v/yIxV19S4qY/Pp?=
 =?us-ascii?Q?fs/uDg2PZTNyJ/Mxe5rMwOUymgUHovS6p+/3AFgMZv76a1hKOR3E2VT8HOOV?=
 =?us-ascii?Q?EWoQXj2UrHzWX55quPKqxAO7Ez95M2U6fOwXSWcli470KKt1G8I/bw68FMpg?=
 =?us-ascii?Q?jSDpxTXBK+nqEJEzx9QMw2hSVXCkYBahivcNM/DeUXq1kDJMyKlQcSWJTHtN?=
 =?us-ascii?Q?4Lyyt2fITifFdpY6BUownRXWQFX2zedBYarGU/6xupy9LY3q3Y1HRUOeSloB?=
 =?us-ascii?Q?cIHh7iyTMgcIN+orbNzvDy+FR0BGGigZbqKYfKQ5KqCTrT9h918/U3Grcm3a?=
 =?us-ascii?Q?ZJti2bBUeiQz0sz6lXi/9u+lCjYrK0sbBx4ECHUnwfLjf1cdQ+VhE1entL9+?=
 =?us-ascii?Q?yLe5oDzAnNGS0HgB2K4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:48.4858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01a3c7e-8c66-4d72-368e-08de1bca44e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

- Patch 1 - Adds detection of MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET in rdma-core at build time.
- Patch 2 - Adds support for counter action in HWS layer whenever MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET is available.
- Patch 3-4 - Small reworks and fixes which allow cleaner implementation of count/age support.
- Patch 5 - Enables support of count and age flow action in group 0, in flow API implementation with HWS.

Dariusz Sosnowski (5):
  common/mlx5: detect DevX counters support in rdma-core
  net/mlx5/hws: support counter from DevX bulk on root
  net/mlx5: rework root group checks in table create
  net/mlx5: improve error reporting on masked indirect actions
  net/mlx5: support count and age on root group

 doc/guides/nics/mlx5.rst               |  34 +++++--
 doc/guides/rel_notes/release_25_11.rst |   4 +
 drivers/common/mlx5/linux/meson.build  |   2 +
 drivers/net/mlx5/hws/mlx5dr.h          |  14 +++
 drivers/net/mlx5/hws/mlx5dr_action.c   |  19 ++--
 drivers/net/mlx5/mlx5_flow.h           |  17 ++++
 drivers/net/mlx5/mlx5_flow_hw.c        | 136 ++++++++++++++-----------
 drivers/net/mlx5/mlx5_hws_cnt.c        |  43 ++++++--
 drivers/net/mlx5/mlx5_hws_cnt.h        |  17 +++-
 9 files changed, 196 insertions(+), 90 deletions(-)

--
2.39.5

