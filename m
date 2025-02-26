Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0301C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 14:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 754C740665;
	Wed, 26 Feb 2025 15:02:06 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by mails.dpdk.org (Postfix) with ESMTP id 6B9194026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 15:02:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb1yI/FnNmDphtscNAON7LAjuliqBsGa62vBPBZpiG8xm+dS5LjDkBsr0pPKw95FumgVAONzLY0L0zUEkbRl7RtuU3DdGk+9TXDNi6yqOBs1k0ZDsyTHSIwx+3ploQeWu26LkC6MMdwoefZNqkjzru2Uw84wo57aTeyPrF3AjukZzBU6tOVFlmFKWV5HJh5SmP6kftoXiZVkYBtcjF+jtaGUk525kc5h8eau9frQMB3zvQ0DqWONXvd/hga3vIqTS7fUKYrUX5hA1Kir8NJcZMLsNQ8e/46hfxe5IyBhgzAxBVLEqw1LCUY1MZMhSLEycvYRjClwSHhpNsilc4RvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrD6rA+80745Z9j+j8qQwABwseqsU3ZJfT9inZ06lfM=;
 b=dgVbvGZX2fAmzruBlswJSEeMtN84LwGTQP5T15J7AjxOifwUBhrbkq69g7VuAOVqI7eVErXnanvecAWtti/h+L6aCRZURwRGxSpCcGihlQZemCxxQCqAgdSTWnS2CEzJrEFgTQuo0p5y/JZsai71ditZMXtmttHzrKrk1kYzM1ayoyVt468ObFwnNqPOkrL7nT6ayRFHnOHVaqH7s7DyWvDYaCYAtIgl0xijTBkVuFZTSzwTtNAJzB/QPjfc7AT+tsbuJ3Qejyid134e9R/bf6rNtHTor6ghLkxzJcpm2a4jtgOUXO6Gy//CgeyLQqBP98MhDm7gVlFHhV7juvWUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrD6rA+80745Z9j+j8qQwABwseqsU3ZJfT9inZ06lfM=;
 b=X/wukzbe7c5afIb/0GG9w9GYjkB/SHN3FVo0r2jjlsiSXloEl3fV/EIsH8ChYyeGUrFLk18Nom9nKowaCA/RLWo9YuiNSvq40WLewIlAYtDZ229UvTo5dESIvGELod/0UYqtwEWqUXNXnmBhlpY9oswOuW+I28jethF7jOl3LPYLvzQYknIvx7zfJmv4xhr0C1pKhnumSqv87rPTIj+/qmQOlQY9pXGcodUle33SdETFZY1eSq8BYrvEbMuswUi+QT86KZHMSxKFvSyH4/D8fcICHtovTq1cNtAZ/OBNJo7GL3QFzXRHe7ALJmFvMGwi+3zRosZaTI5a1g9YF/1Xkg==
Received: from DM6PR14CA0047.namprd14.prod.outlook.com (2603:10b6:5:18f::24)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 14:01:58 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::12) by DM6PR14CA0047.outlook.office365.com
 (2603:10b6:5:18f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 14:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 14:01:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 06:01:34 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 06:01:33 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: 
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH v2 0/3] net/mlx5: support jump FDB Rx
Date: Wed, 26 Feb 2025 22:01:16 +0800
Message-ID: <20250226140119.2142352-1-suanmingm@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225004527.2066812-1-suanmingm@nvidia.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: c169f5ac-d380-4f71-1bce-08dd566e224d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8DtVjsRJUdCr5HqDwQWvA2985kj3e2Mq8LcuGDYiZD1nl/XOPtzLkBJrA4P?=
 =?us-ascii?Q?x1FPAbCZn2a14JHvlZS4/QzHbguOamLe6Zhr+88Oz4RbbxRBZd4g7NcU+JB2?=
 =?us-ascii?Q?HsTQ0Ex4WB5/BQny/I7+CBxHq5a9OB1Si/S1XdosJUWm2tNOHlClvHZhnFbC?=
 =?us-ascii?Q?jcAo6WqpiPaQ9aDnifX/ipx6pJmG08qUYPUbBC1UTwibCG7zYmgfLRPDUgXX?=
 =?us-ascii?Q?b4dm+FXvHy38cQILs+Nqv3x4Tr643J0DQBHKjXKR2HyYAbzKonpIVG8gHe7+?=
 =?us-ascii?Q?cJUeGCmepiChUf2LXiJfoQtZv06cQVeUUa7bzEVJpEAevb/Wqig0HganTNW7?=
 =?us-ascii?Q?ftQMaCEvF+dtm9T/3jcQGB21RIYJvTm8BICkUjJ2gnSgofrws/eiqir0O/nH?=
 =?us-ascii?Q?6VZrWvECnZXQTThr1m5ChDiFF7fgYH9F4+TPGU8wR58kk14KYIC/n+fH7M85?=
 =?us-ascii?Q?oiG288bXIiPLKnd0O1vopVu8HImO02PLkcsyUbfhreLZHST1tHW2RZXiZVjS?=
 =?us-ascii?Q?MlRp8NBYd5nZuoBvAN0Bchcql2KScJew58JsBJsSEX7t+F+vYSbN9nOzD73D?=
 =?us-ascii?Q?n3FmP8kmQEI/Wicz4NU8s9MxVPs6+qrR0IH5imboo2O4N/YOscIY3DjSH3JJ?=
 =?us-ascii?Q?yg+zIj+Ku2zRjnYqJySX4hvpXtQb9ymRk2HLPIB+eF4E62sW0eMaDYU1sQlt?=
 =?us-ascii?Q?GynlclddA+LlF5Ixcykmxot3IT0zrCjw0yonqzW5cfsJkQ8oZI5ex7E4t7Qo?=
 =?us-ascii?Q?GbnNGIxQb8Gu7iDYpvUYdzNpm71tdTOAqP8bqWLC9rXpbXgB0q/YLqtG9dWd?=
 =?us-ascii?Q?unbd1syl8k9zFJGPQ2sYhWlbhg17O1YqJ7cnxhQup93qR7HPvHyJB6caiQd/?=
 =?us-ascii?Q?YS77NmyrZ4dGMnQdfWX785o6Uq+f0D70oUj23yghcyUtScYt2WzDe/GEYGKL?=
 =?us-ascii?Q?5czVWpH+V/ddMz0rCHUEXmEHfaafzpqKacMYbUN8nt9UMyfHtiPjOvkD/8K9?=
 =?us-ascii?Q?XTfBiUvicnyegEX5GF0V7kRXqMyGi5s7+YmMgk72TOXqa9YoZJK3n/xPYhCW?=
 =?us-ascii?Q?D8YepSKz+JTGYxj9TVawTtIU6dmC9M/uY3Ju2K+sSHXFrIIJPv4Fp54JkuCR?=
 =?us-ascii?Q?Xx8dA0NZjlC4KYgx9nt7/XUFvbYrfTbw/5Bp9sfcmSKnmUEtNvHowGSGuVy0?=
 =?us-ascii?Q?YO4XhkL+NvzdVPWROyfEc0pj1W4Y+HHQ1OdmGhhyLBhc3/01IJE8Nj3VIB2Q?=
 =?us-ascii?Q?lFOiVrVQNLKC8FZMcn7ouuqM9SQp2hsmM56xhfJIJ3J8ovIX0A4wCrFtOoHi?=
 =?us-ascii?Q?gLUqyzZtF+dYdhYhCyA0sKNBJ/QLEqDs3EQeZ5ayQGHQmifPfWZJ/xsvx/dK?=
 =?us-ascii?Q?tF8vh9oAXDZpIsSrpQn1RGlTloazyZzuylfk06ZpDGL+L6pBUv1ZAW58DvkO?=
 =?us-ascii?Q?N4cDDRn3UY7nyYc9xxS7EuPwIMZb1O1DSwgWiOexktmNGOfk1b3sE/UNkItY?=
 =?us-ascii?Q?3pNpofa4FBihBG8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:01:57.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c169f5ac-d380-4f71-1bce-08dd566e224d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

Before FW introduced the JUMP_FDB_RX action feature, jump from
FDB Tx to Rx is not allowed. JUMP_FDB_RX feature introduces
the internal loopback for Tx case and allow the REG C0 C1 B be
preserved as well.

This series adds the jump from FDB Tx to FDB Rx support and allows
RSS action in FDB domain rule when jump FDB Rx is supported.


Suanming Mou (3):
  net/mlx5/hws: support jump FDB Rx
  net/mlx5: add jump FDB Rx flag
  net/mlx5: allow FDB RSS

 doc/guides/nics/mlx5.rst              |  4 ++++
 drivers/common/mlx5/mlx5_devx_cmds.c  |  8 +++++++
 drivers/common/mlx5/mlx5_devx_cmds.h  |  1 +
 drivers/common/mlx5/mlx5_prm.h        |  9 +++++++-
 drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++-----
 drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
 drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 ++++++++
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
 drivers/net/mlx5/hws/mlx5dr_context.c | 17 ++++++++++++++
 drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
 drivers/net/mlx5/linux/mlx5_os.c      |  9 ++++++--
 drivers/net/mlx5/mlx5.h               |  1 +
 drivers/net/mlx5/mlx5_flow.c          |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c       | 32 ++++++++++++++-------------
 drivers/net/mlx5/mlx5_flow_hw.c       | 28 ++++++++++++++++++-----
 15 files changed, 125 insertions(+), 31 deletions(-)

-- 
2.34.1

