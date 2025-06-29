Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C2C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19A07402D2;
	Sun, 29 Jun 2025 19:23:35 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by mails.dpdk.org (Postfix) with ESMTP id B2B5C40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:23:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjG5I9qIxvtA3dj0x2j7tHD9OY5DrksPshOGw0Q5JGl6lKNpku6Pm1WpvEEfZht9+p0PRA5Vr71tKM2fdo1xw7sJD4yZqqtgkYXaNwadSyWcvaxk+xCeXxEAJWVizbjNYdCLSLL4sm7K4AeUlcjBmUacZgtgR9WcbzzS8kHLahMKcQ2m4WWFcIeyMGrvqaAY640A0GV502dA/B7lOpG+KOj7rvSXNZ1TGhxwKn7tabDsuUDELljUYVDW8UD1AqTcnpt9//Nk8rjsc4BzOSuMYJ9LnrRdMA2XNGepwSWD6HYGHz0fRYGfPIELMIZi8vY97Lvq1gmPPvNZKv1ZGGft+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT3EEmvnnX0cChc3Z/c1Xp5+NlPr+PY/SL6wogWkLFI=;
 b=VHGpBjyKbM+Y6dUcgfhqa9SME8Upv/U47LArUg+EEy8wA+kwV5PxFWwHa3njZhAPAvxGDslTGg3POSCWzdLDpwWxDpwLN4xMFViOQ5ZzEDBhGgmcF/4V1rcMZfFJ/TV8XgNaLy627lT4XCUDa4+1GU5vqeV/5simtFR8ZvJ3YWsEo3rDKfqknTpuodKBsdjc1CNgRTZ9RpESLaMmGQRUF1rSZNyREO2rjSj2FANzidnrifGwHmv3AeCP78O/bgVut+mYsz0xzZuM7PrDs1//uluru5BlgZCLHv4H1HsK0LGtaREbFqt22vlk47hF7mEN/r0ACmUkHHkoGs/lGrkG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT3EEmvnnX0cChc3Z/c1Xp5+NlPr+PY/SL6wogWkLFI=;
 b=E7QCh5d0N/9MOWsfwrKzu1A7Gu4l7SiyCATdb46hlC0zMKOhiQPiwveIJyr+cr478JGgNqcHEKMN9kLG7zLjuwFIJHQKXAugGlrVyIyFPV+7uxoZyUnk4xHbQf7tZrNbVAfBDzJUZTrIRYd1HTPQvtEkzIWuxKI22sAxtI+k4RdQdyclg3GDTg/5g6mM7nAhDn3lgKySaO3cvrwoy+6+bx15X3ge9ygt3LYrVw9FOhml3FlnRnLMeoL5TIoLkR5SBFgtt0nMctv9LaQDoTWEhZ7DugZisptttnoox5+mos9sNYWR3wADtsOWnuPtbBXo5xQiglqD97LCbgYn7GNcVQ==
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Sun, 29 Jun
 2025 17:23:30 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::1d) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Sun,
 29 Jun 2025 17:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:23:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:23:20 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:23:18 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v5 0/5] Use consecutive Tx queues' memory
Date: Sun, 29 Jun 2025 20:22:58 +0300
Message-ID: <20250629172303.72049-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629170709.69960-1x-bingz@nvidia.com>
References: <20250629170709.69960-1x-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4e1852-3773-410b-2686-08ddb731aae5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9x5dTp0oKx61PalNHUtzoCqp83TFQz1ldNH9r2PvYmZlQ0UDs64UtOZMq3XT?=
 =?us-ascii?Q?nV30a655vuEP4URvdNdsy4ERFkCDHKTVj4XHhS1P8AEtYU9j86ReX9cnUytD?=
 =?us-ascii?Q?6qYrX+G8eIwAEOMkiFig5La6rT1Uak8uaWSVBSRAFcOt3OlGXxn2mtcRtlL0?=
 =?us-ascii?Q?CUmkIx5UxS9DrtOKMc0kRJaZfZUJ17JREPfrF+3k2xTjKFg1rvQC/lTb9OIR?=
 =?us-ascii?Q?qyKoO82HxJx4XTxA6zpaV/Gbg3mZwy7nB/Bzhpx57MAVVUlDgVLg9JvS26oo?=
 =?us-ascii?Q?AtR9/nmBruQWJAhK177TO7PeVKpTcLXZgW3huM/4MLoYNSg6bmdujBIc6pIw?=
 =?us-ascii?Q?yGSFP3qy07Q30hJAIPzJpUA/i8g24zKSWQrqEAdeucYlebdNB+xYDsbUSFhp?=
 =?us-ascii?Q?aSMHWjfyvOnMWoFc/gmXXdKdpbQWiaMOWumlAyJLF9dPs8FEuPcStir//n62?=
 =?us-ascii?Q?0UnhW+nZu+XWOTEt3iTOvjzTsJMNhDAm81W3s9WgLYqCsdiIuaq0REgtw9vX?=
 =?us-ascii?Q?HkXf02ACmVlke/xvEBaMwFplaEbi1C7EcSwhajyRE8ujrvvHLYPbrYkbuSIW?=
 =?us-ascii?Q?i5qmMRA4vLRxAHYNsKK7OWQ2dd7szsOXFZUjE9UI9AUJBrnMu7+VXwDfPiB0?=
 =?us-ascii?Q?sq3e025bnTVdr76/1Bq28D6pAgKTm058quokIhaDOepuzk5pNdpbsGkHfASQ?=
 =?us-ascii?Q?YU8Jn1nWkvHRh/vzabXZbJwPsrGZy8rPJqV0i3MQHBNgC425AAcvc8w7lS9b?=
 =?us-ascii?Q?k1EXXYmmVA8B8QbhFk4/xrXkyuabfGClgd1ivUCE8ojYr1gyZCDPT9Dj5Nly?=
 =?us-ascii?Q?kgkfi2Y2ggjqvzAh85EFf255O3ShqnFvhXT1pHzLH3SIJn/b6xRARJR0g7tx?=
 =?us-ascii?Q?c1bpGh8O+XbShkTdgwyX0EKBb+V9fPKaveNJHYDpASSFK58vXqyCV16avcqp?=
 =?us-ascii?Q?wOHn8tugTarpVkqRdXUpNv9pD2jxA/6FRssq3LYPoSsA+5Kn6FL+M6Bb/YLu?=
 =?us-ascii?Q?YbeoF2UjwqKK1/cKJmsamLvG04gGRWgUARqcPSbye1Ge0NnTmeSTplcD36B3?=
 =?us-ascii?Q?9NAlDrPZozN7zQxWzzHXorTQs4Nr8UibkbjvnkCZpE6GBG2FFf8iQRcYKTO4?=
 =?us-ascii?Q?BrRFM5coO8YHarGJllyn8psGPxef5u+gDhck9BYAEErIdn1JQHs3N9jHlenL?=
 =?us-ascii?Q?KyIvx8LrX6Cqw+yF0nLgfgOOgNCrSxs9finT+Yeu1XiVMDkR5W1YkC5dj7Wl?=
 =?us-ascii?Q?qq4nviJHo7Tk1Qbleh86yTNlhvAjklmevCkzGzf1jhLrUnrhDbBm/ocZYGL6?=
 =?us-ascii?Q?EyeMgZfenEvtwkgX5i+d34Dc2O34xiv7baMhrGDWDW6/3KLA4ZNS7qMy2rIk?=
 =?us-ascii?Q?YAKOxhfizgTkdlv7iUIs+SEJfyMT/IVKnGK1/T0iR5/z85Gz7MrBxZoXe+UD?=
 =?us-ascii?Q?CxAzswtwvFZVUI7r7HpIsXpWDiDFrAiRBDh1uFizzXtj2v6oT9DAUgrfsMht?=
 =?us-ascii?Q?lkVV5dctT+iTjUm4M/4neZy4CejcnEXr7cly?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:23:30.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4e1852-3773-410b-2686-08ddb731aae5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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
v5:
  1. solve one size_t coverity warning
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

