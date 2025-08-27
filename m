Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972BCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 06:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53BB940298;
	Wed, 27 Aug 2025 08:29:21 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by mails.dpdk.org (Postfix) with ESMTP id B00204028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 08:29:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfKbkF6pgVbn4TxJd8IhNmHJEA3JjKPDliWjAsKZD6Oams6VBW/lDvBg9q1Xw4DLUZGEWlAzrR6NpE2WNUwI1mCb76NpdL8Vj2vCT7zD/HLAEBxx3aM2CMxk9le8nMP9sT/I+CBv1QtUrACke996hR4566BET5hFmWFyj9/5cWcZ59JRqTPE0c/Nwo5qGFeWuhfgIaOnRRWjhGQPQ0lKv4qR5zHvk+yk1Z10dUUklV5wXDtKwt/1J5b3qYwuJS7CjaTgP/v7DV0bpTW5CHAK+fwQN8KttqkZZXX5fjK+pup4O5SiHk9q+a0tBYaplcyxIlzPYGcgfR2of0TG4Hfn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lggoeDwaHWE8yuinaGyFjhkpfJqmnH2Cqom+Lxsw2lY=;
 b=LvBTv3ITNE8o1p5b0UW/r1WYmVxv55xxVnsM643x31Jafty8Q6T05fcaWbe1mVyFzAcp/5bf3gk06NjB/jQ15fsbwaWz7oi7AQJCLJ19ik6JN5ElCM7SMVZbQBSxt+j49kaAZN5nxrmlxl52YBmmjbXiHd5elt125715tHsDXZu7giS0ljoq2duI3tJq9x9nAicVz4cHpkR2f5n6qlgUjwQf6+77ucfrUpMwI5Qxm9Bv+UR7XN+gRxpAZZEm9R41/ZjatpQneSnlxsN6K1iLXi4MoiRfu2gFZJ39jKBJdGyYXbZNUPTq22H3omD1wHXxP99Fs29S7VoqECsbe57mAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lggoeDwaHWE8yuinaGyFjhkpfJqmnH2Cqom+Lxsw2lY=;
 b=jtF/s7TV613KA11AHgXwjw5U08+anYMD186L+f2gLPnTtGoLYVB636QYausBdY2UKteBip9e50uAVOhpzTgtTV0mUff4L2qbbBT9loxKoim2TxpI3KAzsznSbqPnzATh6xzHXxR5AP0QNTGE21cDqzolpTVFS7W2bKaD0q4VHOWr1NZQeeLOWT2dInkEbGKgKmXH9bDW7Dsr3MphSNjdcxNLJ9NpMODJFur1Wq8mAeN7t+K8FB3CJ6DGmzP5hYcgYxf7NyMKY1EJPg8A0IIJJ2Uu7t4ev97T0V8yueDytZ2WJidtKD2kB+NkWNdtehVwcY9R7A9ucKckDTO3yNtI3Q==
Received: from BYAPR11CA0056.namprd11.prod.outlook.com (2603:10b6:a03:80::33)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 06:29:15 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::7c) by BYAPR11CA0056.outlook.office365.com
 (2603:10b6:a03:80::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 06:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 06:29:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 23:29:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 23:29:04 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 23:29:03 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH 0/4] [25.11] net/mlx5: add driver event and steering toggle
 APIs
Date: Wed, 27 Aug 2025 09:28:52 +0300
Message-ID: <20250827062859.55086-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0772c4-cbd8-4d8a-974c-08dde5330b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ODUYHSkAnzcV7pHTcfM9xybDurj/EsShY+jmknQPKdqWcC2kPMIOgP3bL9Oz?=
 =?us-ascii?Q?f8tklcYKs4BY5Tbnj5SHhLt+0NFQnWUAFMC12CWWR3yQPr3wHo1zvzD4G8qE?=
 =?us-ascii?Q?bOU1KiLC29fh9aYH8idTdrWEPqqTVwxkpaT3hsIFiOy2/jGh4h/oySnW7WXm?=
 =?us-ascii?Q?aD9QUvQFgTFD1jpkr0i/PLq4YpxKPdV1QtnF4NYTG8QWqDUXErp54dbHiioe?=
 =?us-ascii?Q?+gazMbnLccewnrkGrW6uBE9g68/Jndmi+MjZorSdhyPMaJoSIMSQAK+NUh4u?=
 =?us-ascii?Q?dvksS/kiihTAuMMLrv3sQqCRl0FbekT9OwgLbEBM4ltZgNnFhSNEjDyyR/Tt?=
 =?us-ascii?Q?y64mZm6X8U2Lcd7fgAimRh4IsidzX692zQTGYFxUjDk/UJQhh9gHij1B0h5g?=
 =?us-ascii?Q?Tm2WYT62oZYP4RZW2j975+eCvDeRo1mbapCM6Sx3uuUQuf9XzfTwJFFiCG5a?=
 =?us-ascii?Q?kYd/n+wAjyEiZwxrE3xq6a+XAgt0tz7aqkXWdZfedeqJTp9MPj+Rp6kT7Qg9?=
 =?us-ascii?Q?f1HZl1O8WcYVutMeNOavc48HB//gEVRttfSrn1hha41gzG2iOv4fMANpBbb5?=
 =?us-ascii?Q?QgycXIuL/QnvNNDd5odjPCzYXFxU9C0PsCisQ9C53ltWmyGEDAaeUMrl4KPR?=
 =?us-ascii?Q?ClaNYpnQuTUcZ3f2NZS6XPNyn7jXGZ6j6v3Ga+XfKXv9+Dc46U3F9ufU+0vk?=
 =?us-ascii?Q?C7tXhIvff7H5F1bmYFJWwyDZQib4flAt+3tLV+fbcQFvRrBufgCY7bqyYmCA?=
 =?us-ascii?Q?Nvp2f2Zfd2ajK77bMy70TCfIdnF4cATtufGu8jun3PN5eegHr53hNipiVlYk?=
 =?us-ascii?Q?Wh8tbjYFy7X20WQs+4MzG3GYm726m3gn/Sx+z30s20+93DqKAp2N/9b/6hbB?=
 =?us-ascii?Q?7KMGlZ6ZIwOIiL2zTgV1ayqSaYwDkEU7C2dSq+kpveC8BlFnnFBwpdMkRdFF?=
 =?us-ascii?Q?J5dYhr8m67C50ZUza+aFH285rg7Ez4+bAZ3g5e6JMwnYJ6ByGd2pKdpMKqN8?=
 =?us-ascii?Q?Ano2rLyaywEqvxQvdzIStNbQMxSVC8Bpn68lR8/qEiq86JbI/Hi/xulor3XJ?=
 =?us-ascii?Q?+w6nnpv5pS1UU3PhggjERQVP9NWBVDBr/CFWgLJ3EDQZiFd9N/IPEPvMGSmN?=
 =?us-ascii?Q?Zm8sZwVWJnA+Rg3i6J9Gr5hkXw0ULHu+iuQcNrdIH2tE0qC418HHaZ8cCJHm?=
 =?us-ascii?Q?LRMJ5PvmDyaLsROmO1Nh42vYZG6AySceU1WXKe8b5GYiE5AYpFSbsuelZQmm?=
 =?us-ascii?Q?gcvt7NyrF+xxc8WuEMuaq34ybPS9MFSHNekrP+3TZZvZobYxWfTmaJEUaW5/?=
 =?us-ascii?Q?0i3pSCCaNcXB/zMW40hN2yhPvW4O1E0RcTWkid4eRdPhjxi9GmfmbGnA4nLJ?=
 =?us-ascii?Q?yty8XMyLYIpjoCFewxMg8MO0EUOR+bm5GysNk+KGen5Ornxco+IHdEUGMPZ1?=
 =?us-ascii?Q?JlbgnBbIZ9V1bFuZtV2RcoeyMJNSs9uohHI9ohiqOPKxCywtoAFdIrnL4q3H?=
 =?us-ascii?Q?7ycqvaLQHKDJZrK6aM4Di5TlcMevUcTl2ZaS?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:29:14.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0772c4-cbd8-4d8a-974c-08dde5330b00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

