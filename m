Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C01C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A79B740678;
	Sun, 29 Jun 2025 19:07:47 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by mails.dpdk.org (Postfix) with ESMTP id E7153402EB
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/BNeqXryX3Wm+xycNaIlv+pGci3ODMXh1tZYaYpYLWJWwzILv4SGlovThL2lrvtxKxNaHOWjYCVwR6o7JkgEyoggqOC8M70z1fBfligTKWD296rMymdv2AwoXbGo59kLO/zDp8Xautr+D2FdcTpfBEJzh9g2goVlRTTvQCzNbphJnbBjjbqzM9hnA9EmgCXbpVD7ncafWQeLCaBObpgCgAiScW0kqVABf3NXw8M+p/AABODzlIUM515BDLksJmG8NmB6FQh6iu8jxSqRCMRglE0o8b1Vi0EyYheN0zYxdyJ5r2Y6oLJ9x8LMK9nq1Jr1NtbdYhNVWWynZAnBbuJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN7bzApOi5+bpbLULN3LlCA9BQ9cjDCDw8MhjkA1opw=;
 b=QpZzBv98SVLLaAbpdAHOO+SBBG1N5KpJfZbTaKpJHIacs5h6kUYFPUdH82wELBkKAqRxx2bQU75gNy04B2E3j9w7cELYh/cAouFtKnC4KfiEd1rkFMVVEgtnc5aNuNQvEuXP26hwLu0FmjJc3+hv/NHPN6y59ofU+5NbT07cwnJqtNHWJHScgBnJ5ITkB+fl12LxTlYFrBpOBykJ+kojysQSeU+9DSRMUOkpiIManmXGln8FFyJuauz9+QtWKmgFLL4Z/9nUv6+dbhliRDw5pWOCpVBBWSg+MAUGsvN/687o7POBni5VGS7cl6C4+10Ki2wQdFHdlW1cmgnkJAmMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN7bzApOi5+bpbLULN3LlCA9BQ9cjDCDw8MhjkA1opw=;
 b=IpgV+ldvC0XPYC3S7ObBtbBiWYyChQjtM/SmYQ/ewVw5B0LD2sIN33Tm5JFwFQ5UzwKptGf633UiZKm9taZaXUv69Kta9f2Z6SmIJ8jhZqU2P1VJcJ27ZrlRHQkiinF055aurSNogIBpM3r1NJfCaXcJVDGlFX03S9i8OLneUF0kV8rcs6NXeQS+XbgUkS4H7AWsO/PID7pJfcXKbCY/KtTR5esogE+HzpPv4wNARN477or8ILnYYqIjeGGVOLtZpe7H/TNypl3mtj9aiZT26l21gXkO9nAUk0+ahE1ywMtjXHGevQavFHus07fPTQO/qWbSM05UXruWzlpwx0G6kQ==
Received: from BYAPR07CA0056.namprd07.prod.outlook.com (2603:10b6:a03:60::33)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Sun, 29 Jun
 2025 17:07:40 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::ba) by BYAPR07CA0056.outlook.office365.com
 (2603:10b6:a03:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 17:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:07:26 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:07:24 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v4 0/5] Use consecutive Tx queues' memory
Date: Sun, 29 Jun 2025 20:07:04 +0300
Message-ID: <20250629170709.69960-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627163729.50460-1-bingz@nvidia.com>
References: <20250627163729.50460-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 67853d14-592a-4d64-319e-08ddb72f74a0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zSpRXKgjm1p07u/h3UilZiD9si/ygu9FcPajyDuTxym1sVjK6bIQO2aPqP/b?=
 =?us-ascii?Q?GMM1U9Z7Ig0sfStojX2VHzblwHb5dlzBGMCS6neXivp8ORuFUTP+wiuZc2rI?=
 =?us-ascii?Q?X/mxMqtOdwJFkpVxVJAV9Dc3QPUySmg/VWfLkAr/KJAYsLo75KiJIm7XiA0Z?=
 =?us-ascii?Q?BLnEyTGZFI+272OJ1y4/7f4wCJOob2/e+ZzqQHeADOrDjXVZRPl/7e4AI2j2?=
 =?us-ascii?Q?ZZwnLesFS8SEnnhQA5GxzmgP0VGvhYd4C4fGDHmpihYGWUl9KeV2zfQaf5P5?=
 =?us-ascii?Q?a8cNau2GNZOzz13YF5msVcXrzS1ihUETrbB7tjJbO2puSzLouYpxPlmiV1Ip?=
 =?us-ascii?Q?zfbRMR2wcNb7gNcmIVA0uMaUf94TRjnF6ajtVsZrcyWX1YKt3Arkc6v0uTbn?=
 =?us-ascii?Q?+zDMduJx0e2lgdpCKHd71BDP7VU9WIi9fYTDG1QepdOk3mNiASOVmNEqR3Vm?=
 =?us-ascii?Q?jNPVOMz+72XefGw1VqYkJVvmHPXe9XdMGFDBdDSX2qrpUt6Vb58jyRaDZbVR?=
 =?us-ascii?Q?QaeAGtfhzA4AgE3hwYFVa27C7Dp7Z0RwypPrfqUc7obHehkIJT5hfzwK5SXS?=
 =?us-ascii?Q?tmS7bJg4YCnaJC4czVXdmFJ+Mt6ZiAPQKYUsc9tcUZBKPUyXmPjQBQSnk/2c?=
 =?us-ascii?Q?vMhhXiiRCgOhjy8EddPfAUJbOUETj+VGjSVlt7nr4VKlXNJmIM266kVoEDAj?=
 =?us-ascii?Q?QuVeFIi/gSvUabHWwku+YzHMu6jMP5H8NJjcexgiTcyxnnmEbvTYRfzwcr7U?=
 =?us-ascii?Q?pGKB8WjTLph1c3XVLMoHdWVRbwhlplswzkoTZ5kuYNXkmUl5RMScBzoPHIU5?=
 =?us-ascii?Q?eRRqKz0t23W640SQ7GYfhyvOHs2veo1CoqgYaJOmMNPefa6Gcuya0YdFLjEN?=
 =?us-ascii?Q?ecu4lEvlJO7s+pAjDwC5wiMxqkuXux2IMp1ka9qYxkwmPyGf5gI9qL9GGCQp?=
 =?us-ascii?Q?6zY7k0o1CAVJdyFPlOZYVPjjiz9x4s/o5U+Tys/hsDhQYpTiqmx2+nWLy2X/?=
 =?us-ascii?Q?O92WntesVJwOfs/yhjA8MQU3cwo5W4HjYhbB9DCWk95llfuC0rW1+d6mCPPA?=
 =?us-ascii?Q?4t6a/uZOls6gGYZYnIfyQ0BNqlYnXaRpNSNpXXy15GheoTimpAHsIrL/c2el?=
 =?us-ascii?Q?bQtx79+ec4yaCdwPj7V8xAsGXc8bzkzXt9uwJU5C16xgw54UC02ZiSpydTp+?=
 =?us-ascii?Q?gWdJLx083pE31PqjyTF2XXBSe2MzODDIG5QCsY7wf/Zv+7bn02rFvndy0qM1?=
 =?us-ascii?Q?S5BOjONTxMkBT7PvfglUTNlebKcUWd7DKJWxw7eL3FR0Qp7e7qlLm3Xew1HS?=
 =?us-ascii?Q?w3bXTrp8/I73wd95WW9lAc7ZT/VF37oPkuPLsXHmbxoeoIS0EYDfwZ3Ynj0N?=
 =?us-ascii?Q?8NZHWWFd/ugXOI7uGmtOr1EQYxEJSN3gCc2/D4feMcCU2sQXNb8DxwK7qGfb?=
 =?us-ascii?Q?ylOrZvQ3iCERITWSEUfBnPnHc/4hIoCWx5c3WiEohHw7o0MQovKD6cEYOhur?=
 =?us-ascii?Q?1NY4fdCvll4b9I37EBI1xqqTlr8WHO4mLb8i?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:40.3125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67853d14-592a-4d64-319e-08ddb72f74a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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
v3:
  1. change the devarg and add description.
  2. reorganize the code with different commits order.
v4:
  1. fix building failure on Windows and OSes with different compilers
  2. update the rst
  3. addressing comments and fix bugs
---

Bing Zhao (5):
  net/mlx5: add new devarg for Tx queue consecutive memory
  net/mlx5: calculate the memory length for all Tx queues
  net/mlx5: allocate and release unique resources for Tx queues
  net/mlx5: pass the information in Tx queue start
  net/mlx5: use consecutive memory for Tx queue creation

 doc/guides/nics/mlx5.rst               |  25 ++++
 drivers/common/mlx5/mlx5_common_devx.c | 160 +++++++++++++++--------
 drivers/common/mlx5/mlx5_common_devx.h |   2 +
 drivers/common/mlx5/mlx5_devx_cmds.h   |  10 ++
 drivers/net/mlx5/mlx5.c                |  36 +++++
 drivers/net/mlx5/mlx5.h                |  15 ++-
 drivers/net/mlx5/mlx5_devx.c           |  26 +++-
 drivers/net/mlx5/mlx5_trigger.c        | 173 +++++++++++++++++++------
 drivers/net/mlx5/mlx5_tx.h             |   2 +
 drivers/net/mlx5/mlx5_txq.c            |  67 +++++++++-
 10 files changed, 418 insertions(+), 98 deletions(-)

-- 
2.34.1

