Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DAC7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:00:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60FED40E2F;
	Thu, 26 Jun 2025 10:00:24 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by mails.dpdk.org (Postfix) with ESMTP id 273E140A84
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:00:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0A6Ww+q9XUH6Hld7zd1mDvpBUpOXg7MVoyZ4E+/mJfTS8PLFAEzYCTp5hiuW2TkDCBY1qTc2CnRHL6Eljq7WFMxhDtsxaCwu057ah6iFLgHHU77Kfo+ZuApLLwkAN4O4uG/s7+ZQALKxjYCfuqYJzMrtB6DiYdTPxbTs31A1b3LdZK8c77XC+OqiNeXB+dbFXzoLqAJZhKLXn9jWh/CgLK0b2rfMpi25CBAlGHeZXdrsuWvlUz1gv6/0V2Fb6DX9cZvXFOdp9VV8UYHiwT1Kh4Xh2O6zKOANgQMihevzjfAq9BEOv0xv38mGrN4aVnVsRM6l2U/fFxLU+8VQvoNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YUZoDhH5TmJnbbHKbOnG+2FiXy4DdMLdJpWO+Grpy0=;
 b=CRPxwRoAoCzLwOrFlWSQ0fD9RxjEkBkzAbZecGWC0GWQjH7FoNcv+pMaj7Jye7gxuuC+UVw2m4d5fxws9t9jHdnNO7gXHRN3G7YVI04DgTzVxPTPkFQ8/EF4kvKkT/yaLr+cql1n2DOf1MNyBbIA650fCQ9S9HYg8FQiCiIlSX0qMD+I7/BCcJ7/+eHrMyt2HNoY1CeUo3GRmzmUkvQlVqhvgbuqoVPsbfD0ol01wj281Nt99jP/sLfKYJi3KnDq4b4LpUfcM9d4n00BczoPTytIY56oLCldaNIuHkNvgUuIOko7SQ/aYogzUheuzwuosOFDjUNCBQsbAr6hlv/TYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YUZoDhH5TmJnbbHKbOnG+2FiXy4DdMLdJpWO+Grpy0=;
 b=UFQrLyO+lkeQEMX1oPaV4vf4cY/lC1v7cAbQ/sL5FfYxckMdKPVVGW8oUkl8Q6QFpj6eosaTVVbJkrK59LY9hwH1x5n5AgnJDumykbleJI3vctmjkzo3UF2KKvuaBgUNOusKc/miFwaRey362bOkiEuojp8Jy43hVCMImdw0mXdkW++ha8K1kCgbRwb9OnwdjWuMJT7cOWtsEbAnR4pLHhZWcaPgs9svrKJ+oJDCRAqGoB1bevmYUjOKBSeP63IhFCXI2R8hrBwWIfyhfsPB7zoHlnPXAfbY/ESaSzmQUIGDkQBRGCS9ogLvpsYBOWVzyt0ip/+YFTxksmLr8hI6mQ==
Received: from MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 08:00:17 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::6c) by MN2PR05CA0057.outlook.office365.com
 (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Thu,
 26 Jun 2025 08:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 08:00:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 01:00:04 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 01:00:00 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: [PATCH v2 0/4] net/mlx5: support non template SAMPLE flow action
Date: Thu, 26 Jun 2025 10:59:40 +0300
Message-ID: <20250626075945.537256-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617133933.313443-1-getelson@nvidia.com>
References: <20250617133933.313443-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: ef472361-3542-4e51-3659-08ddb4877c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6gCxhGxFDFDWLgYKTGCzvQlc7e3PFoX6CQaO8b6TdwSDxAhGXdWOmIe7WSSR?=
 =?us-ascii?Q?quEhAg7h40PMU9ECMHokpsjFtmp6IBuKgodGNm710pqZg+/WmNvm42Iry6Ez?=
 =?us-ascii?Q?ffjIL6yZTUP4HTI5Kq4+zqLKw3Wgnqs/12aw4pDRLhmo9kE6z4J26ghRSspT?=
 =?us-ascii?Q?mnWHBj7YjsN5raA+askWtCLPu85sqvfPYJQ+K6APmgQcJ8QhLQm4uU5WH/uq?=
 =?us-ascii?Q?dLQUj+kV08jCiDF0uwkeQ00xjHGlYvMTOQu3bPA1G/AphN2wsevE8Inirg6M?=
 =?us-ascii?Q?MiauAh2+AkJ171BEAX1hxlGxR58K+Iu5pwQfKhKlXp6gmgMIa3/DpNZTJWFs?=
 =?us-ascii?Q?c9wld5WoSM3QihjJqBV90vsIJkOvjmkzd3iZ6VpZmzqWyLNKylbdFeBztOZM?=
 =?us-ascii?Q?aLOistPPztMfgCGlTwUHgbTLQMZaBFTenlTrilba2B0dd8ooSxKRn8+Z9ya8?=
 =?us-ascii?Q?PA7UgM2gQbAlVbtDqXhcipqSWoZDMvCZygqXuraaeWr/m2nf81435TxXYl4I?=
 =?us-ascii?Q?UQPiTcIqLcVa3GkpLhb2+QEG2ziFiVVTNWtImtdQb+FVWH6hFTCHCdLYDd/h?=
 =?us-ascii?Q?nJJJP9GeYJlK/1WSGpP9DDwuJ7+YL1037weFEinrk5+vsCcg4DZaREcXgG2d?=
 =?us-ascii?Q?OxffVTsQ6v/VYGtDDKw4t/ZySTWoygt9wE1LfzjD73YeFd4JEx/+vcLFISlz?=
 =?us-ascii?Q?vpRdhZJMW0/CLVCDP4lBxNFSFHuNk7RdY13+iWmVJ8WY8t0kdQ8n7Em4Xyj4?=
 =?us-ascii?Q?lUGNz3/YmBgO4dwOu/TRslJ216tuz5gJBhj6QRCvm79gThaki/e+9doCubwv?=
 =?us-ascii?Q?aCyGMnwzrf1XXxa857H0mgFXgvgoYd3AKMo/SYPIThWU+5Mrizv4Qoh9kWS2?=
 =?us-ascii?Q?iQgyJs93V7pvL3wXeeAhJB+yQh8/X5pCiUXEUzenXNAdDRxOl2yoPQJwwWpA?=
 =?us-ascii?Q?B//KpPt3/2IDbCPB5R2Q4EKGxfSZMDzhHJRRfE+yqLJokc2ePqPAaPIqc62V?=
 =?us-ascii?Q?XI5kNNbqx2KeIn3ppECcHotxT/2DVM/SWmkQEG0R2JzU89bezfzslF5SKZtO?=
 =?us-ascii?Q?laUQul0SH383McNZ7aTim1VGSWoV67EOfaeP6PbvuJneM7F4HAuS0Yd/KCqp?=
 =?us-ascii?Q?wUum0T0tnfPMPqBbN4EHqgYSPO6LaSIj47m3ulKIgfDkJAX6K6R1KOSjWN4t?=
 =?us-ascii?Q?9iaNBxGMWz1Xg+r1dHFEAbyr3xuKsniOjKwDtfXtHLXzX9Xqx/GeQkRVgoAs?=
 =?us-ascii?Q?l7sRXuOC0ZlNhauv0dIlivwC6t/CL7WxMVt9klM4kRhtNK5jwONGudFH7IGS?=
 =?us-ascii?Q?3j4P288S9AtGybYXJZOokjzImjPv+0QCCtuZHe+zCyIHz4Kauh08J9wnn8lF?=
 =?us-ascii?Q?+elMEr0j2ZVNAOd9jHpSIQ6ngaOMlUclsII2f7abz6JjsAcZzEdPAcipTCGJ?=
 =?us-ascii?Q?e0ePLOv434vsNdaEiR+ytitwniS80iHOWTl8E2OwbcSjopG56QgZoj0zyQx9?=
 =?us-ascii?Q?CzDJcZvkS9r2pRU3YU3/L1zh+QUE9+WQWeuv?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:00:15.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef472361-3542-4e51-3659-08ddb4877c99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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

Support SAMPLE flow action in the non-template API. 

Bing Zhao (1):
  net/mlx5: fix the table flags of mirror action

Gregory Etelson (3):
  net/mlx5: add a stand alone function for mirror creation
  net/mlx5: add functions for non template sample action
  net/mlx5: support non-template SAMPLE flow action

 drivers/net/mlx5/meson.build       |   1 +
 drivers/net/mlx5/mlx5.c            |   1 +
 drivers/net/mlx5/mlx5.h            |   7 +
 drivers/net/mlx5/mlx5_flow.h       |  46 ++
 drivers/net/mlx5/mlx5_flow_hw.c    |  96 ++--
 drivers/net/mlx5/mlx5_nta_sample.c | 857 +++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_nta_sample.h |  25 +
 7 files changed, 1001 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/mlx5/mlx5_nta_sample.c
 create mode 100644 drivers/net/mlx5/mlx5_nta_sample.h

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
--
v2: Fix the action destruction.
-- 
2.48.1

