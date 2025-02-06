Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E4C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 00:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FE1F402A0;
	Thu,  6 Feb 2025 01:09:06 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by mails.dpdk.org (Postfix) with ESMTP id 2ABB64029E
 for <dev@dpdk.org>; Thu,  6 Feb 2025 01:09:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Jx6VvKgQrQ7nvhqFjkUwMFkdCVdBzxBcS0/THfeS+GITy7FCrpPr1zJFDBnAEJTjIGMjB7fmr9nYJVfek1QWTjvdWsZm8IWZL5DUtibNv3xOYT4qlNMbHq7XpA9BNu+1tRVfD1zn/zJ0r/HjNqfHy3oFwGZo7cV1url8gbxWgZiiDEIwdxV5NgenMF9++teCnhX8DSieiTT4n7OUisgILwFPzJoXQN9g7ufuSRPA/9hco4J5OGIjpxWnDhmfgURK7NoVDlM9wzlM9KmN3jAgdnVph1sEPps66j/HcUImi3HH5Fs9ovU88DmhWA6kr5oVAfuv/T6gHciWUBqCgm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QopYwMF1UbxbfCpH73646vWD98kTnbMqY7PW5ASf+Q4=;
 b=mUrzVhfl7/tOGpn/FimwtjxeQwGuBmVN6GyXSWpYt1GIs+K4A89Y1MMU98W9JaugGx/beijnBU9Ct+BLoEYcVAFiL72fzZH9uOTZH/IPZ7TzM6mMC8Oqv3DieOBWiFF7fklaQjh23j4JbKdBVqOQNcp2Ay8Td90UG3nJh0NcG+IdRP4W1uuGOcZKbC+mf7VLXkQsaE/YOPSzWFqwA9I9wv5M2rVcKvG7vb8UGJQAPSoLU+UBlrpcAHzE+36tpwV8LVYurXl/8TAaDDyz9cla0H73Whqm57dZXWggsjRSzn3CoZyUExZIrOWzRc6cl+BzPvuwHFKSzDdlpgZMChsrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QopYwMF1UbxbfCpH73646vWD98kTnbMqY7PW5ASf+Q4=;
 b=dGiVV2R9nPV9Ww7Jy7H+Xr5P1XXUWbRswcJqPHbHik5v6swUUpn5ZeTenhuaE6xtR+697yDINnNehcVgnRk0KknAqKjr4ILW7u59pjVG5vZtOhqLfVFGTD8ly7TZzivQ8AASVIjAOwMzs5tHvfyWMeLsLgZk/oSBswW28dXyexDJL9be99OQTHdPYj06Y8jrc//tL3Y1/eeML+fheP5+WMiR6V2xnmPjppEyA9hkW3y2l28zYkpqaZ62uHSWuxcFtDhVToEpoX0xj5/d86O5X2Fp+tBgymHP7+Kkb1usdl5Qh/vPxrV5hLkRRM7BHe5zb+5l0xr9BGeKpzzYST9Tgg==
Received: from SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::16)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 00:09:01 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::81) by SA1P222CA0173.outlook.office365.com
 (2603:10b6:806:3c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 00:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 00:09:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 16:08:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 16:08:45 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Feb 2025 16:08:44 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH v5 0/4] fix comparison between devices
Date: Thu, 6 Feb 2025 02:08:34 +0200
Message-ID: <20250206000838.23428-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129085416.226718-1-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 4618b4ef-1ae7-4cc5-899a-08dd46427550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rWVQ0F6unA2Unzs9ggkq13QbCwHNqifuL6VK9kBiU2CKGegmQrMVL15+M1Cz?=
 =?us-ascii?Q?DmqiWYuGbpL1wwKime91E8tUqw1BXiEesJ3Md336lq+uNfqbiUNGN4rbyKmI?=
 =?us-ascii?Q?WXzzGmaOOjEy92vsSLBfU5nLHrgLtn/etpAo/bo8FzhAFyNCmGUlAQWgVcfk?=
 =?us-ascii?Q?qHxr2aeuhSyJ+cKVqb//KfnFVyJz4hnAqqxfY/lzmbnWZhySUszvjZAzY1uF?=
 =?us-ascii?Q?f1hwYUEHlEMHcI+Oji+W3ZAehTsXTE9qm8tLrqX0eT90dRiWf9HoMlKfKeZa?=
 =?us-ascii?Q?4G5Jm4Ahkco7CU9NOGU6GuSL8lJFycNpQFWWgO//DPvOt161Kx0wqz+/RgAo?=
 =?us-ascii?Q?Oq5Ej5OvUqKbLds41AFRAztN/OGgfh7v2hE5NHVWBhZXVagCuTPP1vWC5Ol8?=
 =?us-ascii?Q?JAlPWn/Hl8CpDT1CwmWrHF7+bQdHIAz1tUT7ouj03z+yvB1VkeIwrR2mYqTz?=
 =?us-ascii?Q?gIR3JT29IqbkR4/av13OKpKHHGfCLvU14F0+GsPQDlXlHi9QHcqlZRbxFicY?=
 =?us-ascii?Q?xjxYO41jUYmCPvZEh3MXw40yhkdFNL1dJ0PG48D2FCTwC2FwKajjmxs92ZTo?=
 =?us-ascii?Q?DbZF4FIgELxIB1jncN0arH6DxpMvBvnX6Wa6XaTbi3S0rYiIT8+SGpNTxMHe?=
 =?us-ascii?Q?SliQt95VmdRGuPxrdc0GKquDq9r6I3WNNCNwI8GMYXG7wdcFyX6PqayAYMdr?=
 =?us-ascii?Q?VkeysYpJ3jOzrx5h9eUocqvNbEzfEocCpQ9uUCUQHf8/lMjQOuIjH9qUAFgd?=
 =?us-ascii?Q?/A9KA69fclmMzIX/ChOqKDhJXwS0FSAi6ZCesLAascS61COT6cMMPtPJO7gJ?=
 =?us-ascii?Q?7K+VMK80FIjCn5IroUQflFYYO99Hvj9jhjdfIUVqN/FzlsVFSFv1kaACgA3f?=
 =?us-ascii?Q?kQfi78Yf1DM9BcsjBU0XNfpPdennssZJNTUpoUIvWXKmIVD2TR5XGDI5j3DN?=
 =?us-ascii?Q?+p3GXjYiKhbbfCCanW+BMrKSG3ASy7iEj2yxv9+VYpAsNzpPpRvCQQucwl2y?=
 =?us-ascii?Q?+g1AA2I5fFV2DlqAqWTczSShzYJyCkUrhq0mIvebvBcllPzYBMPpUXuidbqe?=
 =?us-ascii?Q?lFh+QWPkWx/z0c31+NZoPbdvuQn+pcGGmdADmVA0i4xtFYCpuGj5i6qUePqa?=
 =?us-ascii?Q?Hs9/R5E/EiagbzgT2ASD1FktxvLxPO/RR0eXJKjkjVWdD69JH1N/IQU2FeTH?=
 =?us-ascii?Q?Y4TnI35PQP/ZEJNT+LsYy7kV7EG+1sr8rkwtgZ4+gCDqbCcdtZ7/5h3Y8byy?=
 =?us-ascii?Q?PN3GPyjPa2enIdjTwDqHajBTdqUYBJX2MlFThfY0Ph9AqksbpCHzzv23/DuZ?=
 =?us-ascii?Q?66vo0J/UtkOGQuqR6GyVrdgbotUjEddKD/ABAeKk8QZFsOWI4fExXrNwwCVP?=
 =?us-ascii?Q?5q6ObtcY0BquOsXWnDNqDDFgAhQSEXThpjPLMbRB3Mpq2+1JeCV4+xX/wuEQ?=
 =?us-ascii?Q?LoEeA7s0xqlt0bVnrJnYKk59udGxeLblgc4LW028sE1DVmhwNsJ9KkfXHets?=
 =?us-ascii?Q?YgDLs6GEzUFoB6w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:09:00.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4618b4ef-1ae7-4cc5-899a-08dd46427550
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

This series fixes two issues:
1. saving PCI name as the parsed one instead of user-provided string when registering a new device 
2. fixes rte_cmp_dev_name function that currently compares the names by compering 2 strings

Also added test to check the functionality of rte_cmp_dev_name.


Shani Peretz (4):
  bus/pci: fix registration of PCI device
  lib: fix comparison between devices
  app/test: add tests to find devices
  lib: change find device and cmp dev name functions

 app/test/test_devargs.c                  | 140 ++++++++++++++++++++++-
 app/test/test_vdev.c                     |  29 +++--
 drivers/bus/auxiliary/auxiliary_common.c |  19 ++-
 drivers/bus/auxiliary/auxiliary_params.c |  10 +-
 drivers/bus/cdx/cdx.c                    |  25 ++--
 drivers/bus/dpaa/dpaa_bus.c              |   9 +-
 drivers/bus/fslmc/fslmc_bus.c            |  11 +-
 drivers/bus/ifpga/ifpga_bus.c            |  16 ++-
 drivers/bus/pci/pci_common.c             |  23 ++--
 drivers/bus/pci/pci_params.c             |  10 +-
 drivers/bus/platform/platform.c          |  18 ++-
 drivers/bus/platform/platform_params.c   |  10 +-
 drivers/bus/uacce/uacce.c                |  27 +++--
 drivers/bus/vdev/vdev.c                  |  25 +++-
 drivers/bus/vdev/vdev_params.c           |  10 +-
 drivers/bus/vdev/vdev_private.h          |   2 +-
 drivers/bus/vmbus/vmbus_common.c         |  11 +-
 drivers/dma/idxd/idxd_bus.c              |  13 ++-
 drivers/net/bonding/rte_eth_bond_args.c  |  15 +--
 drivers/net/vdev_netvsc/vdev_netvsc.c    |   8 +-
 drivers/raw/ifpga/ifpga_rawdev.c         |  12 +-
 lib/eal/common/eal_common_bus.c          |  12 +-
 lib/eal/common/eal_common_dev.c          |  49 +++++++-
 lib/eal/common/hotplug_mp.c              |  19 +--
 lib/eal/include/bus_driver.h             |  26 ++++-
 lib/eal/include/rte_dev.h                |  22 +++-
 lib/eal/linux/eal_dev.c                  |  16 +--
 lib/eal/version.map                      |   1 +
 28 files changed, 444 insertions(+), 144 deletions(-)

-- 
2.34.1

