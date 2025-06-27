Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F4C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82D0B402AE;
	Fri, 27 Jun 2025 18:38:12 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by mails.dpdk.org (Postfix) with ESMTP id 88109400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJk5KNji+q9jagrbZ5Q46y5+XA5nZjUZFrkmJS888ETPQIedF9hZSkIDsltQSroPn0/tHrD3ioO97quYQkLpcCOTcd/bc0RxsbhT50JifgIFzjHDm7+DqWNlwFLZl2ZOidk6Wj0Bf8sfNJfiuVoIOcY3uaWAuNFgw/jRA7BmWMUR5k8zklSb9R+ANRMFT0xsHMqAmav6AH39t/2Dy0RuYiXnuVQyYHjXnXveJNOFkcBuz6GfYHuQQaoHGW+N61/zjn5IQdqCxfPQqfzMiLwTyOsdA2jUxMELXrNtIj1EKhytw4Nhs8zZSfWL9VxkuSC/pDNzG84djI7eWrSzvDtP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syxWaHBSj53bYxGDBHDjIzrDdvHDhVOP8fHxdMB2mNw=;
 b=iH9m9B/BQmUvAFeuBCSF/TLYLp0R8lsMiPMD9LkVssudadzJbx99dpq5lMqLBUqxmXuxYePgXNrraibVBRWxGUMjWH14nCFwBLIZweVmt8GtXMx9ROz8bPVVWBDztwh/3rFbdC3k8m+opfJI6+tS/m2Of3+/+FrUXbBevMBsd1txLCv9+0F6s1JPQnc0T4b2+RYiTl3ceDs7dNVsX/ZpA6k9Hry9mvfvi2lc5HrhNxRncRoMj+AqntpRtfRwewRXh3OibfubDhCbeHwpOemRLnNfRQhw35CTC5oI4C4ngr0E4wDoi9Embx74LpIMG9R4uEPjh9JKGkDfnE3AfST8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syxWaHBSj53bYxGDBHDjIzrDdvHDhVOP8fHxdMB2mNw=;
 b=Hx36eZsgJicjypWUjspn1443T7HpWykFeXhsS4Dk1dsacb5wSmRaEeRIdsZKLJRmMBS0uwXRNqbT7bIAxy5rNbmLirM0zE8nWOIe8X1f1JmFMVYlzDl51BH7y/4svuBKFCpGP0CqkhiKO5dSmRXzYKrRQtMDP0yeJX2GNDhgYKZStLKdoBD0ixKQG7MO11x2YESWaiLsCks8VBA3K79QoWEG4yfxbnKiim1IO/VfF+ONdxOSQvn1XIZwO/lYxdO2twsP7FyR6qAu6jX6yJRma2OERgKCJxL8RSpcQ+rLVSvR2c9fIi9qvHz8i7JxG4XFEotQM6oGb5YpB0cNMhqz7w==
Received: from BN0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:408:142::12)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Fri, 27 Jun
 2025 16:38:07 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::70) by BN0PR08CA0019.outlook.office365.com
 (2603:10b6:408:142::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 16:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:38:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 09:37:53 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 09:37:51 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v3 0/5] Use consecutive Tx queues' memory
Date: Fri, 27 Jun 2025 19:37:24 +0300
Message-ID: <20250627163729.50460-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623183456.130666-1-bingz@nvidia.com>
References: <20250623183456.130666-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b727144-aacb-4f47-c6ff-08ddb598ff19
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oLnb2ijb5m7kv74uYC/Aqv0ti6CvaDk32FKKDu7WdRM072h5wXz1IDqbmrX5?=
 =?us-ascii?Q?ciXONXSXxCuP0Gzp64TzlXEpu9lC0R5dgsnbrq79yGO5dgn50h0+uNSaKQLc?=
 =?us-ascii?Q?nCDSITVjwy7+ERZNlV2nh0zFnDdFm7+6aFQTajVNCoAxbt62xrNX809SAcn9?=
 =?us-ascii?Q?CcVLWSule2pBwFaEfZRnjFGe1I9sODw5EaXfJgMH0Gnux8VNKciLZ5wkeATV?=
 =?us-ascii?Q?XK1DiL+TDJmxYHwDuZ9TeyHvFuvkB0eVpMgvyehT3hTHzoiLIpVklfnRWx2G?=
 =?us-ascii?Q?IwV09rhov5vgd7BtfA9PPCJsHMT8ARLuVYzqx8xiHwh/iMnDo+uRxq+WyigB?=
 =?us-ascii?Q?DDN1r51WoMSGNWsM4h0sxzLsaHEed1X7XEcf4ysUm8u3rqiGgh7JXthBpF1m?=
 =?us-ascii?Q?W8dPylnRDls0PeFrMMOTA/yCc389dYVQYcPXKbtVyorYbCvtXQ7CdHGJhuKZ?=
 =?us-ascii?Q?4GgdGLURGzJLrUSI20L8oM504XLXm7Nk2snG3WQNy84AhkEzR4RXNo3hTle9?=
 =?us-ascii?Q?qybcAFoXv9+D/zDFP8vKBfZ6jOEeka4XEAHXE0TyKMF9Asi2Gk+6XyAgwNwU?=
 =?us-ascii?Q?YJFu8PqS7fX9bq+yVF85LQlutr2lzrWJkd9mObj19NqBcOSP1Eus9mht+jPG?=
 =?us-ascii?Q?CkHSb9V7yQ7bSQLMaiydMCQiUFOo/Vj0CCzkcE8LUxg9rXAvdrfA8JGhGJdC?=
 =?us-ascii?Q?8X2o0e2lSmN5RcnrmYXxxk9VwOlyDyCJEkjoC/8T1AZKULDZr30lMo+v4CRF?=
 =?us-ascii?Q?LjRvORWaWDtLvw3lpbfd7Fqm5T3fi4CRAx/OigPWGPOtShzdRCokC7B35I4C?=
 =?us-ascii?Q?tPySHIEjWCkGvi9HnaRGaVsdEsKFnqlhUV6EukBDdBa13IEfk+VEcEZ8YdLv?=
 =?us-ascii?Q?livjzxuJIuWvs3Suv3TrcYtNkBCKF7w1PljXp/HNgJU0eyALxOzn9KYdEfSF?=
 =?us-ascii?Q?QrdJmY0tA6JRzFi6bj89vcsqd7/Bd2hnTJAxvfSSq+LmNuGgv2Ggdh6fG+zX?=
 =?us-ascii?Q?xDPos7My/4scuX6CY0d8gbH3LILimuoLl87rgzd7n9tBSzKDYvkzF/Niiltv?=
 =?us-ascii?Q?pYa8Kb+vJQktEt4Xma1wvZC7uz/CMY7zhRIHFiRokEDwEMjuKa6vaDpWiEkY?=
 =?us-ascii?Q?mELBcN+jLJPsyNeeyjNCoW9QFTSOxHE5WYJCSe2dqY21e9PSIOi6I6aiCMNY?=
 =?us-ascii?Q?rg2tbW14FtwcgqEo+HpKmWZnEsFEuKkDTQMLlB8GLU0lxAIEAXkpj9Wwsl0c?=
 =?us-ascii?Q?k+G3u+xHq41JF+MkYxx501XUA/aw50MurwjiUZDJ93jojk/HCoA+g/p9syQ5?=
 =?us-ascii?Q?/8FVlAaSPb9A4HQ/2YYfP6mpK+VYTAiH8jBdai94X6SyEom2LrzgCpUwY16V?=
 =?us-ascii?Q?n3lz0mEdodsILbFC2RDHJSRH6IOtSMaacc7eXxNRdcx8ACkCiz1+MD2EegyG?=
 =?us-ascii?Q?ZIHzomxPkkyMbnorCqoJjgKTyrFGv7+KReuRL4yIO2ZDJuz2fvBIj/FE2OHs?=
 =?us-ascii?Q?RqeR0nx2dxXa0zlTTyCT2RWRX4pWC+DON+q/?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:07.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b727144-aacb-4f47-c6ff-08ddb598ff19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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
---

Bing Zhao (5):
  net/mlx5: add new devarg for Tx queue consecutive memory
  net/mlx5: calculate the memory length for all Tx queues
  net/mlx5: allocate and release unique resources for Tx queues
  net/mlx5: pass the information in Tx queue start
  net/mlx5: use consecutive memory for Tx queue creation

 doc/guides/nics/mlx5.rst               |  18 +++
 drivers/common/mlx5/mlx5_common_devx.c | 160 ++++++++++++++++--------
 drivers/common/mlx5/mlx5_common_devx.h |   2 +
 drivers/common/mlx5/mlx5_devx_cmds.h   |  10 ++
 drivers/net/mlx5/mlx5.c                |  36 ++++++
 drivers/net/mlx5/mlx5.h                |  15 ++-
 drivers/net/mlx5/mlx5_devx.c           |  32 ++++-
 drivers/net/mlx5/mlx5_trigger.c        | 166 +++++++++++++++++++------
 drivers/net/mlx5/mlx5_tx.h             |   2 +
 drivers/net/mlx5/mlx5_txq.c            |  69 +++++++++-
 10 files changed, 412 insertions(+), 98 deletions(-)

-- 
2.34.1

