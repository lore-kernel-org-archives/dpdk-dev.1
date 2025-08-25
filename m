Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B199DCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 14:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B512A4021E;
	Mon, 25 Aug 2025 16:15:01 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by mails.dpdk.org (Postfix) with ESMTP id C299840156
 for <dev@dpdk.org>; Mon, 25 Aug 2025 16:14:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1FlW/e4kDIj4JRhS4nj2hQNxTP82tpXS1Zr9r8ma+Qj6nC2qjA8blqJy+jLMgYrNx3MImm4EE5Dvm3E+x+EKQGpU4dMw4GYK8Jxm1g+VA51/HVUpymMcy44SHvzvDEiaUQDd7G7R6Gb8veg80VX6vaFCUcxnYk57YPTum1RSVnwmpP2gmCJUhhN/JbzBAS2H6Kh/7m+rRhASzmIea+IrGVZXeJwrCjCPyyAYy80jiB/BL9d2mSthxDpvKCoxwq6XcwgtCfDyqc5BH24boBuivQ9lklBcwZzoCCCnPrpF12NS0bpXVWARGOWcay0tU9Raqn/aKQBI1J+FkH0zXzZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sSUci1YaVqPdNOeNRNkpYX/vVxh33sSo1NTdiC9bZ4=;
 b=RajJSyuaM8R1+HfY2odMr6s5OCjHqZ/6dwsEdBdcyGiA4ZnvwxRb7DK2QPraq7FkDTocdeY5TplTjwQL46/s6DSM+rkluiEpnW85hCi4m34k2UMqxd7mNH0w6JBb5fk9Rs9k/8CLVzkbHcPa+6FSmW/5Wkmv9hN41BgP3eoseVvKDgbR9vxe/Jp8eN6BOO2/uWN7NLiKQAYgyDzijY+xhUWj8ES2/7weAfmaOsW5Mm8PtHl6KEgd+HMqyNopf+M1Db71nWUlKMgLAWJQL5acqX1UUp5O0iChYtc9NmW5kbdpurnyHXCIkeaEnzNl8yZowvS/fdCq/3ifSPrFvMIvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sSUci1YaVqPdNOeNRNkpYX/vVxh33sSo1NTdiC9bZ4=;
 b=iXyvatnxhUibcoVnQt6RrSu6ytsRmziCj0v3rPXt+y2LwFK76Rktyuvny+Euy2jbBnyqBzUoxQEs8RUOJO8h7cNJnZwgs3cENCgJvCxuXl6MOMEM39Jbl672vEeNz4uyatLkV2Y7nl3/9VCnHWQ/BNeByAM7q0cYresIzk1UiWkF8bAa6Pic78VZ2I3rs5ZkGNpKevbnSgtNxqMGpCtlm2HziLf3FPk70miDNN3FaWUdXTc5/GSUhwr28vYAwXAmxdnZ80KvFOdJ+P4iZIAdJ1kWkkNyaSbdfvoQ0oTvOyEog/Epy9dJqmAgUbdG0Pe2hNKFvRAz8bBtZm2oAeD3Uw==
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 14:14:56 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::b1) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Mon,
 25 Aug 2025 14:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:14:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:14:39 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:14:37 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH V3 0/2] resolve flow creation issue for multicast MAC addresses
Date: Mon, 25 Aug 2025 17:13:20 +0300
Message-ID: <20250825141322.974335-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: d49ffffa-affd-4c3e-83f8-08dde3e1c4e7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YsQlPdHF9XGpCmvwEp/q2CO+rNHbNvQwLV5KPm/y6agG2bWUelaY3xBWldwc?=
 =?us-ascii?Q?6l8Sb1NK25kQuSWkNFtE7ohFLubsERa1H3sE+52MFIXwTWEXIK4blki+2XGI?=
 =?us-ascii?Q?qzEqvbsJZ/+3Icx1MCNM9Z34ybzRHApprqrykVDxwkr8ZREorxptLJGSLumw?=
 =?us-ascii?Q?WFC3xxGmhtJyUAvWRPiN8xD3FAUB0aQTbLCcvuqIjOdyRV0L3qIhNR5swVJ5?=
 =?us-ascii?Q?XXx/eFGaNucuxuNqV+xLNEcXdlSC5HenUo5USA2mBa5dM2vH+d/Kk3pthhSQ?=
 =?us-ascii?Q?9myiCYVLTLto/RhvCMiea9TKGd7+oX7rYN86AJXAegDJCHUmkMUxw+PwnO5G?=
 =?us-ascii?Q?JhiqLajHldJwxGmex46CLJrldhgy9ewJ4Fs/a3PnUqI6onYMkphgf065l9uQ?=
 =?us-ascii?Q?IzDWiFjZqr6/uT3tEkhHvgF9o63TSpb0aWYEwcgtW+dFSIyjAyMjrVfCTM8k?=
 =?us-ascii?Q?0TBNCwSoQqIco+VhrjA4fXSM6swYIJYOYKbImaZMTqA56Wajcy25S3l5oJbP?=
 =?us-ascii?Q?h+P7LyJowBXB6s6k0kEZwr8iZkcOKleNEktyB2DmE/Y4WrQ0y0DUkq+x2in4?=
 =?us-ascii?Q?5+t4sT5+5kbmtAFFfNQBefqwz5bd9fRR1tTb1V7ArT+rUC4cTW9VheOa2B+2?=
 =?us-ascii?Q?cy7P8nLFm6flhoETkaOFim+xN0Ec42q37ppidvSYXvSIL/DpNVmJv2rUuwX9?=
 =?us-ascii?Q?UxeIeKcwg2UCriNDi6EjdKoWTsfC9pwRivn6ioKS5ocGs1kyh+SMXf+c4BKi?=
 =?us-ascii?Q?4uwaBA/R+lICA0V08DLHXC8c7/2cQeS7833o2iPP9rwVGRm0fABH6oeFKNx5?=
 =?us-ascii?Q?gADINvK6LYnhPaoFue9WhgKaK0GuH5vm5dhT2o96c/1opXde9ePNaW3SkjDk?=
 =?us-ascii?Q?vdXVFzoTSZOCEH+TV1e7YNvZepNzNWm0m0LPlVCcCMhVXYdYFyrILMjukpZl?=
 =?us-ascii?Q?cc+FiEYFjCCJOg6xz9HFT33zCROTL/RAkZJgsZBqIcqHK3ysV3ujnKA5CZm6?=
 =?us-ascii?Q?R+52hT0FTg4gfJMcwkmIcgnuOSn/AuvCyyg/5WpzFnZOihLV8Mh41x9cFspK?=
 =?us-ascii?Q?cErJ7FyeGjMPfPW3R+SIf1i3Z9jJmKHaKnVssNGP9QAGFqTB3VtpxuTKP241?=
 =?us-ascii?Q?AisA8rMLg2Xn3ChJ9y9NVwO2m53nJy7dTB9IGjiBHxh+X9NjbDX3DfBqkKff?=
 =?us-ascii?Q?khjiMLUPcceKziHsHxHmKe4Dn37Xwhdniul6MM8HhDBvbG3XcyXInUII/417?=
 =?us-ascii?Q?NXrzH3Hih99av8dynjUSrM/gdrveWj41YvJumjCffnaFee/ncJZ9WcOx5UAW?=
 =?us-ascii?Q?2TPicTls52NSxctEp68QHqN0ritJ6v7FOH+eQqhiliYSoheSjK+TpSVlYmse?=
 =?us-ascii?Q?BRbApp6aqtUvJwWHAUJvIrQSFsEq6FNuS7kiWU8BnytmyoUe5TvrickvUzlq?=
 =?us-ascii?Q?IE/M7XSJpkGoKHYh+GX5FJu5J6v+jXfrowSiNEWnSpr4j9YN3ZctM5omwOE7?=
 =?us-ascii?Q?M3Eac1M2RLM+qK9oegxv+EbfMx+Pn+fvqOT8?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:14:56.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49ffffa-affd-4c3e-83f8-08dde3e1c4e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

A bug was introduced by commit 2d0665a7f771 ("net/mlx5: align PF and
VF/SF MAC address handling"). Flows for multicast MAC addresses would
not be created anymore.

This patch series are to fix the issue.

Minggang Li (Gavin) (2):
  net/mlx5: update how MAC address bit-fields are used
  net/mlx5: add support for flows targeting multicast MAC addresses

 drivers/common/mlx5/linux/mlx5_nl.c | 26 ++++++++++++--------------
 drivers/common/mlx5/linux/mlx5_nl.h |  8 ++++----
 drivers/net/mlx5/linux/mlx5_os.c    | 12 +++++++++---
 drivers/net/mlx5/mlx5_trigger.c     |  5 ++++-
 4 files changed, 29 insertions(+), 22 deletions(-)

-- 
2.34.1

