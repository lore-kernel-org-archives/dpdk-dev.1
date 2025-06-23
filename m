Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325DC7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 17:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B037402A8;
	Mon, 23 Jun 2025 19:36:01 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by mails.dpdk.org (Postfix) with ESMTP id 8962440151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 19:35:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACcm7rOv0Izt7Cq1crBweFfGZMlgPKM2o1d8Qrmj7IxDOEjzkStKJYjAwasdGnC0kTsh/2IfSBCAWGc/MKs7/+GnRfJUMPQIYI1x92hq0fj03kKiqi7YoTwOs4/psSQw1CS+hlSj5I6BWBca0s74vuahnHRti31nw+82jbqnUvj26MZZOtjF1rgJnsGagljEpSiYIMriZje0tdkApcSM8YFoh+wLNPRRsO0ELQ4zPw7isX6sCpHQGWWN5Rvtf12zN35cze07XoUESEWE0JBp2VVQbjcc5/VE8v3aTkBFsRe1+6j717zXLD3D8twLZ5uwOdD7cr7uZKhJh5lUyDfSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E060YfOSg+B+j2GhczfkfDyHVVtJnR377OKG2YECts8=;
 b=aPyDa+8DjyvMasYN0KmlSAUG6raHfk/eT+vWPhSN08Hgw0LXqF8jDFuA+4hIlC7EnHKTFJkc1dIMhXrvMy9zW+xMN/bmhz/aR6aLGZ0uPNQgVYAOTq5LiGN7TN2q2yC0yQ79T2ElfYgEcPcfhRsLBVWSzbzspT+zIhq+uzjTJYhYG+tAiclU5XWipiw5/+jei4UiT9ZObS9csN2bZ23k8fLwQ+lCy+d6cTszrF3ZX04Ch5pmae5LTyGsByAETseFPCVBzawbAohvQ6z9r2bHwqMrymNUF+DXctKzb47ioC+yrMqZ0hbjQK1EyVclkLQgpwU6waYGJ/YFe2PSZkpE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E060YfOSg+B+j2GhczfkfDyHVVtJnR377OKG2YECts8=;
 b=k0lcc6Ih/X2usO9Dm2e+VwLQwA01x7YspLuIlCWdStOTM6FQZxYqu1mnrZnr2H0mB7dd9uF1DVty2VoJcFRYha0Kzjd5ENq6j4rEy3nUqcKyQyefwOPq/e/ny85FB4iQWw5IwGx7YmOTNqlnbO45yf+oPHfl+9ZgssxZVGzCmAyud6WYonWGmUGxX0+fIEgN0zgLoTZclNpjoR6nlWZpDfwR0sZg5hOYtLCLR7VGXV7Fz0WaSJp2CC4Ka1xdeUlQEl8pdQlx4tVpKkXDTBQ6d8olSZGmF6EBPb7NHfGsZDOD6dn2pywPZWUK7b+hIe65sUKrMXrP44x9WKV9mvyYuA==
Received: from CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22) by
 IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 17:35:56 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::9b) by CH2PR05CA0009.outlook.office365.com
 (2603:10b6:610::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Mon,
 23 Jun 2025 17:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 17:35:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 10:35:40 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 10:35:38 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH 0/2] Use consecutive Tx queues' memory
Date: Mon, 23 Jun 2025 20:35:22 +0300
Message-ID: <20250623173524.128125-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa73cda-ccb1-4a0f-abfe-08ddb27c68ec
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NcdVMXqEuWxuz0rgFceNzvB0KOxNPPU+n+i+aOjJ8FQ0DezUTKxFPjs3LmPw?=
 =?us-ascii?Q?hssbKmQIE6I5LIoYuzDmHLFvzxdprTrwLNiet2kcowNRMg/jRMC069XTEmor?=
 =?us-ascii?Q?fH1F9h5F9aCjZnNwrVjpy+khvOnFUe1K3/GnoZig20K39KbVVpp8RvSBbxMQ?=
 =?us-ascii?Q?pVqbMHi/UURBt+CGgRAMItTt0rK0Pq1rwutS8QiDUiH5k4CWZrQFD3Sx61y+?=
 =?us-ascii?Q?N3ynkpxiT1Imm5kPBF+LLcy0R0YJTh17ZeH34pRwQ+XYARZSol0BBWtX/AlP?=
 =?us-ascii?Q?qrSrM3F9j2x4Xjs0rDybUCQ0uIQ4FbEcKZS9FiU3O7tG4LmMnpgOIDw+x+1h?=
 =?us-ascii?Q?iXR8V3wI/tXq/ePBnO06rwnWZpz0hIhs9zt9wGzHiFdFtXrUf018AWBxi6io?=
 =?us-ascii?Q?gKAJbDz/H8+wrZ265DBmuzDL7LcVG+zyQwlKk0XyYiZPd05AWElcwjcGr8Py?=
 =?us-ascii?Q?BJp00v+0TU7322DOu9TVdJvCjxAegQjvB2Dt81DmAVcYkJfDzUL5EcmuyWGY?=
 =?us-ascii?Q?hQ6BL3PMiUAzc8Obc5gW0spX9KqBDidEUCWMGHUu50QG5Gy5UDf5Op2atDm4?=
 =?us-ascii?Q?9sxWeWwPWuT2zUhJiCQG7uTEtsaCVXDrY8vjuPwPTGikXHlfsyHGb1Si2Jog?=
 =?us-ascii?Q?N8O5UJSs2Cjq4DHpDleIJ7OZtvDx6O4vZAMG+pOlP9XTTZpMaANdfKTGy/RE?=
 =?us-ascii?Q?1t/QFZVsL7Fpafu6MxeZGUvmA1r7ggSIDhrhiQPzQgcmSm4JPcuaSDRdbLQk?=
 =?us-ascii?Q?2lfKaHjZBcEBBEgZ75EXDOVfrZk/v5C0u+kNHrV/qSuhdlEiNyi3L4INaQpm?=
 =?us-ascii?Q?IIEO+jZYMHM3BKtk0eQHmGe+tALYW5zxDFbLt9ZyLgNgo0wwBEgVLGU4gm6d?=
 =?us-ascii?Q?NFVSeIEhxqnL0KcA5K91lLfBp9i2M7xXkHynur71Zcp8o6NwRbPxFmZQ9tlA?=
 =?us-ascii?Q?IZUZWd663diXiQR6DKIfJY1HbMOR4cckHrhkqBztIKTz8Jkw7Zu18bFmMR3y?=
 =?us-ascii?Q?gpXI+DZcUY+Wy9QxuzGvuyr+Vm4AhMOrewoiukaMyaT7CT5ebwTFE4e2xRJr?=
 =?us-ascii?Q?0NlqJ5DP8uRnuSipRoLdgokjIJFoYzEoYfoRSgol8apsP8iE4bbCHJXU21io?=
 =?us-ascii?Q?OsAESkkMIsK0Z1tbylbomYQc2e6rv2AG4qQAR00FGuiOi2Ffb8rnxgiEWloB?=
 =?us-ascii?Q?VPcrZfHHiA27fi6SxMj8LDG2qCbrUqHZ6kl3i/VSxjBJi9RfZFjOE6Y7wZj3?=
 =?us-ascii?Q?N6zE0HxVTqQ+6a79Buj2ZZrrjQHZoppzBGvmlcDG1z/7YU8hsITZzOI8Vb+V?=
 =?us-ascii?Q?uREaj1bN7VJCqfQUVYncVUYpTbeEosLoK+pJ37qpgj6F3Wd2zVtkp74AFoVD?=
 =?us-ascii?Q?9GJD71Usp0YgBfGWHrcssYJnB5tuMBr59qpch32M7YUJUpqYsqW6N0qD++Yz?=
 =?us-ascii?Q?CXLEGZL0EBd8ojPpz0dmWgWewn/Io4GhXVJkGvQK2YNzvAAEASb7+qvMdzGU?=
 =?us-ascii?Q?qzNwyNzd4RRwTJ6S5plnKF5FWaVpUG3/7tkP?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 17:35:56.0801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa73cda-ccb1-4a0f-abfe-08ddb27c68ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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

Bing Zhao (2):
  net/mlx5: add new devarg for Tx queue consecutive memory
  net/mlx5: use consecutive memory for all Tx queues

 drivers/common/mlx5/mlx5_common.h      |  2 +
 drivers/common/mlx5/mlx5_common_devx.c | 77 +++++++++++++++++---------
 drivers/common/mlx5/mlx5_common_devx.h |  2 +-
 drivers/common/mlx5/mlx5_devx_cmds.h   |  5 ++
 drivers/net/mlx5/hws/mlx5dr_internal.h |  1 -
 drivers/net/mlx5/mlx5.c                | 14 +++++
 drivers/net/mlx5/mlx5.h                |  7 +++
 drivers/net/mlx5/mlx5_devx.c           | 35 ++++++++++--
 drivers/net/mlx5/mlx5_flow_aso.c       |  2 +-
 drivers/net/mlx5/mlx5_trigger.c        | 56 +++++++++++++++++++
 drivers/net/mlx5/mlx5_tx.h             |  2 +
 drivers/net/mlx5/mlx5_txpp.c           |  2 +-
 drivers/net/mlx5/mlx5_txq.c            | 18 +++++-
 13 files changed, 186 insertions(+), 37 deletions(-)

-- 
2.34.1

