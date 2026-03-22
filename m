Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E40FC72B9
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 10:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DACD2402EE;
	Sun, 22 Mar 2026 11:25:26 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013030.outbound.protection.outlook.com
 [40.93.196.30]) by mails.dpdk.org (Postfix) with ESMTP id BF5D5402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 11:25:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYzKtBIdZxZ0mIcXQnsevMgP02O+/kK2fwrgZq06ZDAnmGGDJKE4uufnpTsjVdoELO81eJuywZ5FamzG2cHTdoUSfBJtQ28IbQhfDKLbO6mxEYxC2j+h3ESG7tCMulqyt2p5qsPBNZTDx97FAt97RfmWlbtX5lYgydV/mS3Vhtmh9rqd0aC1L2XfXPqWUEItyazifzpW6vIK1XhKgwUUpJSQU+RJF0dLFrnvYyZrzNNwG22GvLkSR0Ticlw8CiLm2AnVDeljALmPDj8GLQdP+QGR7UUa8NtYNZLp7u1/y+gs7xcUohk9q9jcEMpdxyGk2juFGNqOi0Q8ddx3Iz+9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw3YhU+z1pCqOd9cVxyfIUztTfKRjO1Dtn/PGxdjyRQ=;
 b=RRgZIeAS2UlCmUAQcG1vtX9GX4V1+k1k5Yk7kIbzAkB/9sCK0yG1ZtIIz22k8bPLSqVnu3BugLplBcih0qh5YDPIFMXhL4b/uEJFVZFJoWL5Ve6OCJb1gGSqbSHh2K/fCIhL7iGG9weDyXyTlg2z29ln1IPbkdwgKICUoYBwFWoLJDKqc5tGtcej8qlTm2HNpndZrZxDR6ganTJVvE2p54+BD3Bfsow9eVkrTQvuGoTUCM1njRaNmPRFlyj6/EDs/QLP2GF409xfHqbKUy+p0R8XxDARlSluNByvNay2jsEFta7Fbb/OlJe5q+sB8BBcjAayPiTsHP6P4P2QqpymKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw3YhU+z1pCqOd9cVxyfIUztTfKRjO1Dtn/PGxdjyRQ=;
 b=tLKU3sYLa8c/c4RuhfErlKh6F7ylNMpfZb+Q8ZR7dNLUSAEoiUZNupggqkhCAfMbtnmcSKHPoKxPCdP5WsDIJC++CxMtxH8JQFrTIEi0tPvXoV5sddiAzHT2gEWgLtAVoE8izanm1iqKJJe4fU7Te4uoJ870nXFKzoWpqgUvEzrBrdVe+mFZwax6Kybk9I7Mk+CuwQi4bwo9z1JqP5SyJVqHP5gYUyjeLSTkYS/viMIwHrIXdCs25pAWzjQigJ7UJ0XSRjqMe/15CD0yLihYGbuEyRPGJdP0XglYK3f9/LvEFTK2JbUg4R3RPUfYtrNE81yDcxmgibVcT3Nf6WcYVQ==
Received: from PH7P220CA0136.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::8)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 10:25:22 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:327::4) by PH7P220CA0136.outlook.office365.com
 (2603:10b6:510:327::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sun,
 22 Mar 2026 10:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Sun, 22 Mar 2026 10:25:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Mar
 2026 03:25:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Mar
 2026 03:25:03 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Mar 2026 03:25:02 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH 0/2] Fix a doorbell race on Cortex-A78AE
Date: Sun, 22 Mar 2026 12:24:57 +0200
Message-ID: <20260322102459.141958-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de992dd-9f69-4586-1fc2-08de87fd5293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BiBGoe8fzybuUxSqmmtpV56JlP+G/RxvBnuVAE1hLqzu4/CRVnRNFkY9XqbR3HJ1qK6d6ScQYCiGk5uQhuXKHTatEaLHb5aKgksKWU8pu09L1eEQX/QUnB/rWO7GOFdH8oNUyDmKf65F8xDPfqL91cEzl/0C4K3qr4vuXKbuqsKJmXrArd+LHCGU7mhdwRQoL/ZvXE6ka3WcWrbKr6wMj/wg+0zq6D1q8WQeK4pWX0upuRdvzKa30dR9gIrYeHXvaUq3Pl1uyytmHpUgE+H4qeqd1zMz7C8nXR0SQ4s+fuvPxdSTuOwxyqFW8OuXIrH75nSE72Wc5g8GbBDoPdfAZi2K2ReMOyALopxN78eHtzHJKupOS9cRc55PQyMw40oiW8xpB5fwwgO9wAj7v+lwQGTYrCtrkLzVraZtsMSnxnSqk9D6kM3jSVuAjurLD8xys6dU3I9/SAHWH0yta3IGLZRdJ76syEu7dGdejl+nShcIdvsk3bq/4HCOWB2hmez61yX/a29A4a1R38LOOTy+fRph3P8jkybKCG8538mAppYNUhrS61If7VeZ8RlJwfH0Lg4V5G2X/PZ/r4tdV4AA7gfd1OUA6/yf3vYTJvg2eWlhYwKkC9l0F5rnNPEd/P/U/45ZvCCHVPD1t+14JA8ovA9RaXCKSI9ANmO+CxYIUNGhoE13C0H9ey0c3uP273MxISuaC4WLrdY7paaXow0IMVEuGvRoWEvn9W3jQMLXS1rDfPWXA8uik7Y+Q7OOXyz09QEXnZufYiXOdnJeRjf+fQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 32AJBV/j58Lm5J15Isjzw8ICh+G7l8kkzFI3lfRm2LO+ZohQKDj8Dtaj63EJm96mGencCc8Ya5SM9Px5vTxRAGk+jUZLi1QF0HQ0cpIaKMVYQRh7sAPErZd8uDFqbwMBg3UYysH3G9u7W7CDTAfoRRQisfoOsYJtZzD7qz8khBVMz2pfr5XUbEvrOb6jAQRfVQPp5x07KgR1eXRbBgtMxYuF1wu7gavbYJdc3z+RMZKek/ZiJavXq81S9Nb3I2LskPwx69DyAuJsTBOtWMiXzvHPSVvuv/qOsXJSoFAlblIVBuVKR8IhFlmmF2Hz1uR9HNeWz2/wALjTgSHT5yePAG4FsTc8GqlAt4OkjCNHDh/csyeWQqpVj/FKl5ryF/tPN7FRqAi2kBzYElgFPWySgwMQO211OYs6VwBnUwi/o3tWee58dGbuoiJRc2UkMY40
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 10:25:21.4656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de992dd-9f69-4586-1fc2-08de87fd5293
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

Fix a doorbell race on Cortex-A78AE where the compiler reorders a
64-bit WQE load before the 32-bit stores that construct it, causing
stale data to reach the hardware doorbell.
The first patch fixes the root cause by passing a pointer and adding
a compiler barrier;
The second patch reverts the crypto march extension workaround that is
no longer needed and that broke builds without AES support.

Shani Peretz (2):
  common/mlx5: fix doorbell race from compiler reordering
  config/arm: revert forced crypto extension for Cortex-A78AE

 config/arm/meson.build                   |  7 ++-----
 drivers/common/mlx5/mlx5_common.h        | 12 ++++++++----
 drivers/compress/mlx5/mlx5_compress.c    |  2 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c    |  6 +++---
 drivers/crypto/mlx5/mlx5_crypto_xts.c    |  2 +-
 drivers/net/mlx5/mlx5_flow_aso.c         | 12 ++++++------
 drivers/net/mlx5/mlx5_flow_quota.c       |  2 +-
 drivers/net/mlx5/mlx5_rxq.c              |  3 ++-
 drivers/net/mlx5/mlx5_tx.h               |  4 ++--
 drivers/net/mlx5/mlx5_txpp.c             |  4 ++--
 drivers/regex/mlx5/mlx5_regex_fastpath.c |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa_event.c      |  2 +-
 12 files changed, 30 insertions(+), 28 deletions(-)

--
2.34.1

