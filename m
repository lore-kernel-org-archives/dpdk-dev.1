Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2ADD2505C
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 09:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95E140288;
	Mon, 12 Jan 2026 10:25:05 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by mails.dpdk.org (Postfix) with ESMTP id B87A94013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 10:25:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4UUWV46ZUGF184lXMCU8p4QDWcXuUPsfVAI4t5UZoHEkkeZLGMZt+rfa0Lz1gXPFA4bZtaDMWIUyZaooFlzRAE/X0k7QGu/4+sV2LQDeLvZbz4Y3QMumuH+Xbbv3fRqfhnUhJU/Aq8/CRW4dLXiq+W0Gm4HqE7CnUuMlC0lzVgRqY6XwvxpKqoc9fcM/lfht/KdO8U/Ve0y6X9zxcw76YTL2SdIljO/bYbHYKI5fihbx/oVSyaS2aU3kzRdDA7FPAGglzo3d9UgbEr5nH91r25dYRoITco2rxpcbffETxYi83PZZcbB+Jm6y1aOW1iU78KyY151XEz+hOsJnokkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw3cA2vysdw9NW+7px5a6HEsyoaGb5D1lHw35ULweqw=;
 b=PMMlXXnI+hSHab/Km7W0iEcl0/c+OeWT9UPsRfAVZj+cMGMXzHvOvYCgZDCqI9fyoPmNDwsI58rrtRcHnjs7L2wMMEIuX1HSOIIo2Z+kFYi7G4PhQqpfZwakokEk4JtdJuhjtf5eKLOmWr2/624Ldbl28szSwEdqZOFqfNkJbH7o3bh2z1Trb9S4wExQk+aSNrlgzjZTCfNoSpwxyXb6bJxzn1P1u5xbykdQuDi31WI25DLcAmF6a7qr/7o6byS+2nHPTNXfEYUCacrF6fWszmcKqnhgJMgpughqKwEPKOLO98npZ4CyuBhbpPIzClWhPxKMySkoA2tWjSyot5u5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw3cA2vysdw9NW+7px5a6HEsyoaGb5D1lHw35ULweqw=;
 b=P9PTrOKxuvYUl2EzqxGhZjwKPaLZuQZyjVzRnOB0KRvU+mkGw5g+VcPqPBlXXIFLlj4gG0Sh8zo/77maytKBzkxXYCdFZD6238DxyvguNRGNnfQITcxL96cVaXFY85qavXSz19anHVjmeJuEYxcTwrV/fZPKIE8MmnTlFn/mf+TA+boznCUCcHAD7lqu4mwPGY1CVxFcR9JUhlqOP5QCJO7RjmivkVlywZsBnTKQaNeuQ14iMIzKGWKJrFhvrLSuhXuKIYAtkpX0MsI151YOfOflRZHVB4RVl4w0JTkdl1wdGlR4kkjEu5tQZFfFA4KrWGgcdJ3cZQ3uhI0GTkHdOg==
Received: from DM6PR04CA0021.namprd04.prod.outlook.com (2603:10b6:5:334::26)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:25:01 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::f1) by DM6PR04CA0021.outlook.office365.com
 (2603:10b6:5:334::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:25:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:24:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 01:24:44 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 01:24:43 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH 0/4] net/mlx5: future HW devargs defaults and fixes
Date: Mon, 12 Jan 2026 11:24:34 +0200
Message-ID: <20260112092439.14843-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3c8c7f-a427-410d-8bc0-08de51bc75f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KlFaYzXCUUM6QSUxxR8xafmFGFWP3ZJJyUMF4qGk0byENVLDwW23lOywrovP?=
 =?us-ascii?Q?zsAZgmhAObpouaSgzNGRhcb06fwr6f8fgf5hds89N+BQhUE/Tx8azx8cZ9jU?=
 =?us-ascii?Q?Yk6rdKdrWoXGbkrokjCWuEeRcVZS2lSI5lnXWcQ17Z1qqYMyEUj17uZfuKJA?=
 =?us-ascii?Q?pC+RTRd6fQt/E30Gx3kuNeyhSANQhWvK4LgP9jXIRVaGbMECU0U5GwvOJTNf?=
 =?us-ascii?Q?ir9YudSYjzgfZMuq/7uolb6Pe+6575Q2qWZMnCCF73VPL+vrl7VdB+/6XAyv?=
 =?us-ascii?Q?8SkzlzWzs34mKd6EEpjT3jCwvtlDIY+Utwimrn5QDkEUawMhMriAcVk1wY5y?=
 =?us-ascii?Q?GN/D82PnMt9qfUBEnn3utHLSEWrdoUWNqA1ZyJx7XInvywhC8tdrXT47bQCi?=
 =?us-ascii?Q?thuSaW3IXmyFwnoUFOmZgMHMyVYx6nce0ltykhXPYqZZrVjbFNMN+409lfwq?=
 =?us-ascii?Q?EprarPTraYBnrYLd+0c38LEn9+PVh3hIBC9foixqczOZt9p4jjsAu1Qj+YYN?=
 =?us-ascii?Q?LBqheRI3t4g6Ir8bvVA620HukAbZ1TK3fwNxKMt1h0ZdFE7SUNO76dw5PZR2?=
 =?us-ascii?Q?97umY39GduilHtiegTx+Z747W9DaBbeMKe/KTXnJ5mLj8C+ImvpI/jIPK+pD?=
 =?us-ascii?Q?hRFbk8EYsbdkteO3UpT4WRKEndPjzXQ31AoMfQpbotiupJpaLGWczR0TLKYW?=
 =?us-ascii?Q?OX/VEmhGcBXVU/zuyfTO7zTtDY+IiTvikwBRR2A2+Eb9Dc9y2iXA0+WZM8Nn?=
 =?us-ascii?Q?rR1fvkj3gtDuk1mltFgNh281DeK0mWbPJ+aaX43vwgKaqOcBtr+cLyudRDUN?=
 =?us-ascii?Q?FWiskOylI65IIKNi7iUhFAGaElgxLjLUS08veKpMKXoJhtXPhCpXBYeY/6Iw?=
 =?us-ascii?Q?SagTRS+LY4xCapZ+KH/pBLEpTr2EfuxH+Hitq19D6H32DuQYWPVf2MDxhe0p?=
 =?us-ascii?Q?OV4F2EnzHaIl5TJGhud60oTIYHLq3XoqhmyM7wG8OLTQwArdGb20+6Gdjtcf?=
 =?us-ascii?Q?J3A1LVMwQJ131gCQToPZW/U779T8DbyfbW4w2wc9WoS498r2jG+QOSrfUzOZ?=
 =?us-ascii?Q?c12rclsW4f9VWqxZxY1myUCH4317eCNZ68ZruSPMB1Er8S85+5wPDbYllb1+?=
 =?us-ascii?Q?PwBwkZDi2gGuMFU3qSu68oVOnqQBhwWcRlyj9Qz5Lj8j/pTTXAIVF5xFj74s?=
 =?us-ascii?Q?zcee9hKWhaOVR83i+lKNqTGUuo7yhiqdwIgDoiP34ZXNiY/cVE0QZs5ri500?=
 =?us-ascii?Q?l8KaRg7OoHK2TV/UA+IptvfDsBa/+K4CY9SEWrGQouTNE5kK8z+qVjJiESw/?=
 =?us-ascii?Q?u7qmntc/Qz6fctraNhvzQNVCqr0GLXXH/Fis1IeXRBkHrRG+P0tBcsVtfqyI?=
 =?us-ascii?Q?Yypazg2vZwfUyNWCzCIIjh1J3kj5YIOYpcd13ZhcVvxroPGdDaW9/FUHd1aT?=
 =?us-ascii?Q?pmibamypSqfmCypNGaSkRcsCeNHoioWm6SljcOl/BHuEiofOThv3JRFH4sDu?=
 =?us-ascii?Q?nTEi2DxfFjndZuTy419FLATdfGyqN+MQs0vAm20NvboksRHC6CFzWNE+H0vq?=
 =?us-ascii?Q?doYs6yUEuhTEPjSmeEs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:25:00.4965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3c8c7f-a427-410d-8bc0-08de51bc75f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
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

This patch series contains bug fixes for the mlx5 PMD, primarily
addressing issues with Hardware Steering (HWS) and flow devarg handling.

Summary of changes:

1. drivers: fix flow devarg handling for future HW
   Addresses SWS (Software Steering) deprecation on future hardware
   generations (e.g., ConnectX-9). Updates default behavior for
   dv_flow_en and allow_duplicate_pattern devargs based on device
   capabilities, with proper error handling and user feedback.

2. net/mlx5: fix default memzone requirements in HWS
   Fixes memzone exhaustion when probing setups with ~1K SFs. The
   default HWS sync flow API configuration was allocating unnecessary
   rings (flow_transfer_pending/completed) that are only used with
   async flow API. This patch removes the unnecessary allocations to
   stay within memzone limits.

3. net/mlx5: fix internal HWS pattern template creation
   Improves PMD initialization time by separating pattern templates
   into internal and external categories. Internal templates (created
   by PMD) skip expensive validations, while application-provided
   templates remain fully validated.

4. net/mlx5: fix redundant control rules in promiscuous mode
   Removes redundant DMAC and multicast/broadcast control flow rules
   when promiscuous mode is enabled, as the device already receives
   all traffic in this mode.

All patches are targeted for stable backport.

Dariusz Sosnowski (1):
  net/mlx5: fix default memzone requirements in HWS

Maayan Kashani (3):
  drivers: fix flow devarg handling for future HW
  net/mlx5: fix internal HWS pattern template creation
  net/mlx5: fix redundant control rules in promiscuous mode

 doc/guides/nics/mlx5.rst             |  11 ++-
 drivers/common/mlx5/mlx5_devx_cmds.c |  18 ++++
 drivers/common/mlx5/mlx5_devx_cmds.h |   6 ++
 drivers/common/mlx5/mlx5_prm.h       |  14 +++-
 drivers/net/mlx5/mlx5.c              |  71 +++++++++++++++-
 drivers/net/mlx5/mlx5_flow_hw.c      | 121 ++++++++++++++++++++-------
 drivers/net/mlx5/mlx5_trigger.c      |  16 ++--
 7 files changed, 214 insertions(+), 43 deletions(-)

-- 
2.21.0

