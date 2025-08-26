Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C72CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 11:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD1584021E;
	Tue, 26 Aug 2025 13:46:38 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by mails.dpdk.org (Postfix) with ESMTP id 4C39E40156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:46:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXq1xZzySIHmH5i2kOlECgd0Q+C+XxLEyAvhViglyGvsfIvAup6+YUihtHWyhuXLnEgPcohZ1JawhyuWrk1kT/vup+yn2XKjBBhQb00jyyvsJlxGfkGo6rHawn05dGXlRm999DJuv4cnVJ5RzM5EHzUm1t3a/IThou9XbXg5PDkDDEiekgQIrGk5h9EIQYKTVWSsUUoZyi/U1VJqgXALr6PsLnAhOUF7joXdgap183e2FDTNgEz8jHSMRvKdaWeQa18JkcR+DNhaHH2npG0WM0mJIA6KnZxFiwtoJ7cFPkAmEMPsNOQDwRYkKiwQGBrdkA0PTouWvdGKkVd24XLqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lggoeDwaHWE8yuinaGyFjhkpfJqmnH2Cqom+Lxsw2lY=;
 b=ETxvcUj+xxJ/JicbwpRuXN8xzQZVAFoJ86/jYzN/F8/Gv6FQxqPwd4WRjnaou9TD9GXU03bp1cryzNpA2fRQzcjIvAkynXTZ3lQuzMOpt/aDrQ6ntR1COaNXyLYwK9zw7Hd3eHBe+nFStJ4NpTZxP8aGNGRsczR7Ad0ZvhVLG5t/ogjxXdBUBYrT9U1ekzPah8D0C+XhGHQfDDqR9QHh2SPnzA55qikNIpWWB+R8MWDNog1buLz27sp5+YTrVC8P4qBf3EI+d9thGkCcrPnJPN5HS3tuF95d8cZb9DGHNg6yPR55IhDA01APihi8D3HNEwN4IHP1MCwjG2yqzX9iCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lggoeDwaHWE8yuinaGyFjhkpfJqmnH2Cqom+Lxsw2lY=;
 b=b+63mpzYD4JrZUUK9M+l8wm4JefBh3Td0D5Ds/1HGV1zMCDQFahbAv/Go4AOVPlLOI8omae8HIjgijabACobGcb4HOUmV1QQkBzi5TKEDtPMVYgbaD5aTFseyByA8k8p2ImDqlrPhFW1dAQcc9jBVLIolhQxgkIEREhdj9lm0BlmSA5GADv/3rXniD5JHCyIZiBQLiOx/YO3sNeEeE97op/FqQWH2rTq/1NKaLaWnMxdH5+GhwYHCWYDraJXNQLQH6ge+9lYmVlU30tEvkOs3PpTObdggxOOPFFPKtDQq3rU0HCKRS/19hiK6RxuADrbsUVwnHMBYIWJC11YaWt77Q==
Received: from PH7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:510:339::6)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 11:46:33 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::87) by PH7PR03CA0022.outlook.office365.com
 (2603:10b6:510:339::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 11:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Tue, 26 Aug 2025 11:46:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 04:46:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 04:46:18 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 04:46:17 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH 0/4] [25.11] net/mlx5: add driver event and steering toggle
 APIs
Date: Tue, 26 Aug 2025 14:45:51 +0300
Message-ID: <20250826114556.10068-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0e590d-800a-4714-d917-08dde4963405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7usCvb6du2FmXztmX7PwShT0JzvUuDsY69C0UwsXFF0BocMvZgB+r0JHuOkI?=
 =?us-ascii?Q?a+WjCSLL9JwTgGb9XsmAdx+7vmyyUqzx5lrphRXeEHiDrdhCSbxhFFJd0wg4?=
 =?us-ascii?Q?ja3Kg3YMPr5O1ePcyBIEMxj7l48JVpZfDMVVqvnbov8y9CJrLCjy1tCDO6JX?=
 =?us-ascii?Q?ic44HSoz9w7WAL2wLuS5NPjL958HcQyVDosF30BQ0+0Yp+GUEUMD4gQX263a?=
 =?us-ascii?Q?kylzrLVHycV8ty86QowVXRedovTAt9Nvim9BG8axaZVXBs0y2nPNKcITuJNP?=
 =?us-ascii?Q?7tmUeOOp3gMDPxRXVEZrgTHoS0IQRYkd4hBg8Pf/rFWNDubeMSQ18QHPp9oL?=
 =?us-ascii?Q?uY+/pEGQ+YjYhPI3nwEPnCGbXXMv9mquayZd0INpyaz02/VgJcqps7oR6yjV?=
 =?us-ascii?Q?QxFp2m6b1dYma8xCUNBbwLeJG3zzplggpUXWsmBElueE6YOwZouPF2ybE0nY?=
 =?us-ascii?Q?8UyWnLciIR579GRduK0BKxrmrBE8I9hD35Gtv50+mDSGLo83xUr+7GZVGrMY?=
 =?us-ascii?Q?6Pk6XRyBAKeSGfdYvfsGS5tmdQ4L1x9y4jg+tLCiZeOgRw/Ziv9MNpPrK29I?=
 =?us-ascii?Q?/45uDUYQC10RGdVFuvxDGsJfURlPxLadJpYEiyvN/mR9/xlvskk3JaiCYGfH?=
 =?us-ascii?Q?KRdqpwgA5401nI9aG5u2dSoUrlF01UNjSSPiGXTj9DsXI6kU87xyI1h+2nHj?=
 =?us-ascii?Q?acZ9eFlXb7H4entIsgq/GTUhE2+s8IjK5x/Szylkh2d6ExwJPT27K0p4wRS1?=
 =?us-ascii?Q?JlStbLEcFr367e4aQiQSeIePwoSVhOyt5oiSmb4Pyj7X80Ytgbb3S+z8Suu3?=
 =?us-ascii?Q?vsfVKWFlaPJ8iy+sNm5bq9AJR49lcOULYkotv+2tEmxxTCDmgsFioKl4LRk0?=
 =?us-ascii?Q?2sHX68N10pPprobqxx6rvyLL8z+nNHSJlcvc5sfHZ/+FKLWm5+v/RGXEnUf/?=
 =?us-ascii?Q?QKvpOUMf9fCPD50wd02cinrt50Rv6Cqlhc1Gi7xPb2fC6Pd0ny6TnSZFNIZZ?=
 =?us-ascii?Q?NmnKWvakjf3oDTUA4IBAuzxnRqeisiOL/xDWPCmgOasAct1wFDLdkVX7DHOx?=
 =?us-ascii?Q?ws83WBgB1d5kFX/IF54znkZvusYgtxiUqxXUNRXkqNu7PRMDafhHdP6ajuO7?=
 =?us-ascii?Q?tFuHLRHq6REr++tG9XVDmVs15Bn8qYGO2nXy6ycL9ayBkZCjunNiZqgtfJp2?=
 =?us-ascii?Q?aiPq8D5QKggE6gWjPAjgejFWFGNv0cp0yDnzLMfNBFTRt0yc3tmQ/on+FGrf?=
 =?us-ascii?Q?w6tv4VvrJpH6nIfSDgqO3DjpjIjpdujxQyyS0AgdSttQyY7SNxY3dSecKFwC?=
 =?us-ascii?Q?MZmMMs1ZH3mPMhJqPc9p4jA/P5ZGj/GuoF8QEIIm+t15MtKbGU6Dn7w+a24w?=
 =?us-ascii?Q?/hmlSqfV69t2QfF34Wv9yGdCu8wB+QY0N8Ki7QHF1yJHFU86bj1sMXCV7Ojq?=
 =?us-ascii?Q?yPHkZiRFGjvrFthFbzJDmHyYxQoQJVeHXu0TTChbaXqsJ1f1BTGgfXZm59hu?=
 =?us-ascii?Q?+s0c6DwIsR72PAqwipGH3ocbNHfrDFT73GOy?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:46:32.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0e590d-800a-4714-d917-08dde4963405
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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

mlx5 PMD is a bifurcated driver, which means that instead of communicating with HW directly
using UIO or VFIO, the driver uses existing kernel and userspace APIs for that purpose.
mlx5 PMD requires that `mlx5_core`, `mlx5_ib` and `ib_uverbs` kernel modules are loaded,
and that NIC is bound to `mlx5_core` driver.

Kernel bypass is achieved through rdma-core library
which exposes required functionalities e.g.,
mapping memory to the device, FW access for setting up Rx and Tx queues
(through mlx5dv_devx_* interfaces) and flow rule offloading.

One benefit of such architecture is that it allows libraries and applications
to build additional features on top of DPDK, utilizing rdma-core directly.
For example it is possible to implement additional flow rule offloads.
This can be achieved by creating an IBV (IB Verbs) context and PD (protection domain)
through rdma-core and sharing it with mlx5 PMD through `cmd_fd` and `pd_handle` device arguments
provided during probing [1].
mlx5 PMD will then create all necessary resources for DPDK using imported context and PD.

What is missing for that approach to work, is that
external libraries and applications are not aware of HW identifiers of Rx and Tx queues
(returned from mlx5dv_devx_* APIs) created by DPDK through imported context and PD.
Knowledge of these identifiers is crucial for correct flow rule offload.

This patchset proposes the introduction of the following private PMD APIs
to address the above use case:

1. mlx5 PMD driver events
2. mlx5 PMD steering toggle

mlx5 PMD driver events, exposed through `rte_pmd_mlx5_driver_event_cb_register/unregister()` functions,
allow libraries and applications to register a custom callback.
This callback will be called whenever mlx5 PMD creates or destroys an Rx/Tx queue.
All necessary HW identifiers along with corresponding DPDK port and queue
indexes will be passed as parameters.

mlx5 PMD steering toggle, exposed through `rte_pmd_mlx5_driver_disable/enable_steering()` functions,
allow libraries and applications to disable/enable flow rule offloading provided by mlx5 PMD.
This is added to support use cases where library/application needs full control of flow rule offloading.
Library/application will use data provided through driver events API to configure flow rules by itself.
When flow rule offloading is disabled, DPDK flow API will return ENOSYS for mlx5 PMD.

Patches:

- Patch 1 - Add mlx5 PMD driver events private API
- Patches 2-3 - Minor clean ups in mlx5 PMD which make introduction of
  steering toggle private API easier.
- Patch 4 - Add mlx5 PMD steering toggle private API

[1]: https://doc.dpdk.org/guides/platform/mlx5.html#device-arguments

Dariusz Sosnowski (4):
  net/mlx5: add driver event callbacks
  net/mlx5: move eCPRI release function to flex
  net/mlx5: rework Rx queue mark flag functions
  net/mlx5: add steering toggle API

 drivers/net/mlx5/meson.build         |   1 +
 drivers/net/mlx5/mlx5.c              |  18 --
 drivers/net/mlx5/mlx5.h              |   1 +
 drivers/net/mlx5/mlx5_devx.c         |  17 ++
 drivers/net/mlx5/mlx5_driver_event.c | 300 +++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_driver_event.h |  18 ++
 drivers/net/mlx5/mlx5_flow.c         | 199 +++++++++++++++++-
 drivers/net/mlx5/mlx5_flow.h         |   7 +-
 drivers/net/mlx5/mlx5_flow_flex.c    |  18 ++
 drivers/net/mlx5/mlx5_trigger.c      |  30 +++
 drivers/net/mlx5/rte_pmd_mlx5.h      | 192 +++++++++++++++++
 11 files changed, 772 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/mlx5/mlx5_driver_event.c
 create mode 100644 drivers/net/mlx5/mlx5_driver_event.h

-- 
2.21.0

