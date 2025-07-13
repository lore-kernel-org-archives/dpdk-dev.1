Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06460C83F1D
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Jul 2025 06:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2767402A9;
	Sun, 13 Jul 2025 08:34:37 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by mails.dpdk.org (Postfix) with ESMTP id A8B634028F
 for <dev@dpdk.org>; Sun, 13 Jul 2025 08:34:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXFN153NKvrv5zlHS23KMjKLahR56lrHx1HfWwQdTIA7hFSmHVhbVsjgYhF3s+AFbNmvBPNmx4k4cAzJJsUHx7ILGaHyvIl625Xh4b0+9/v+xy9C7x16iPnioypznZ/2Tlb0kB/e9bzuXpnz9BcmydD8SvQ9XAcpassNw8cwGPnb07HodSfIT13MT7Gy2muJDeInOIbHrT69DT+WNsj3ZaDFWvMV14tfcVTIQ62J5EsbFb6g/YzFmuaZyPTExOMH0QBrwMo9s7v6bUWqsFnVpu3mcYgQZoV4P6a1ROo+whoDalH/XStGKFLqhuflY3RGeJeIVyeoknIFdiFAdlEIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8wzkiaarcdTPDnPJpZUYWmyr4y0EPGDwNX+YZvS3PA=;
 b=IP0hI5LZsqHPNNpa9FTiklCKjnRZ/01t4oTzlDg6Tu9sWz6jvrfUCNvAjTB1xBKddSiWgLwiGUR3ECay1Ui+fjihDceKW0hHPpiUrVdR6Kp5WGGB5jjRewcuRT6fizOXT2QpseeD4tmCaCss308YAKDfXbgPFf7FE+YRGJUuftBj6g9gmp8Qc1iSsE08N2lcGP/Hx/WzPPav29SeMqTITjfPJ6vnecx7IPOrBPwkIxowzEOz7HVUkznzCD42oIPEgxHmUk3C860FnO/7Uk3G+o16OQ/GncNzq12wt+Ntns8ThiGR8B79TV3apY3Y6CnqWxmKXd4Vllo1/5dCqiw9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8wzkiaarcdTPDnPJpZUYWmyr4y0EPGDwNX+YZvS3PA=;
 b=WOvSGISH2fybXp9NkBzj/C3HzJ6e7/6N7ciP0+K784pgseztKRjP83rWcyPHeqDgy9tYNzUvDvWLv6xHb1idV3/y4Kj5d5VnmizgDmi3fTj5SfKZX21LkplbSJMx1uR9DfH5bqFmxByP5NdJRdOkUKxBX4CLRmjRWBvn44eYADDqxwg4x7BlAc6bAyT6+UWw/jpx4guoczRMpXlnIpCwxojlTtpmG64yJBH7Vlmd9oKFGi8UarWTS41I1pDrHf9qOdPi2ZqPsBMO3ojjJfBcuehXTssDduYOIm0d35hfMIaUqmFiVkyT42SGQnMkiGxbBdy+Vms2490dEfmhr9AqWg==
Received: from SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::16)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Sun, 13 Jul
 2025 06:34:33 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::98) by SA1P222CA0188.outlook.office365.com
 (2603:10b6:806:3c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 06:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 06:34:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Jul
 2025 23:34:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 12 Jul
 2025 23:34:23 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sat, 12 Jul 2025 23:34:21 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <thomas@monjalon.net>, Shani Peretz
 <shperetz@nvidia.com>
Subject: [PATCH v9 0/1] fix inconsistent representation of PCI device name
Date: Sun, 13 Jul 2025 09:34:16 +0300
Message-ID: <20250713063417.10998-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708083740.128610-2-shperetz@nvidia.com>
References: <20250708083740.128610-2-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b60e604-2fcb-45e8-ae8f-08ddc1d75432
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cds5LZ5tBrCVUJr4vq8RP1JE0x2aLCkWtejXw5hndr9X+frikeHxuj0yRn9J?=
 =?us-ascii?Q?pCwH1pQF0LN38QQfPIv3Wv9vpKfCPvwEeZxDYXzcW7s4fSKB7PKn+AwtjmvT?=
 =?us-ascii?Q?YaQRfHKQruc0oSjYm/MCPwtC4IvSC7IwoSqyGw0hVUFSk52jjc35XQKi0RqP?=
 =?us-ascii?Q?GfNamiqycWtMYQJrdkmRScAmsF9WyhUsSfgM8cS6iJMqgrlSpZb4Nn0HjElt?=
 =?us-ascii?Q?sKJNfAECx5G2t9hlfF0VmatjfILqgZqxWXuBgc+uRn0n1XogVZliZFBMhtAj?=
 =?us-ascii?Q?8B/DCGLaey3TBPcdd3bWKcCTTjGhWCLn+sgCd/CUhBOjG7xYL1hWCcxOz4qv?=
 =?us-ascii?Q?4FWs9h/Yxg5LcG2yRydb9KDpCFP8ACAKqLI35aE/KHfXM+caI4o9Fg5pVGZ3?=
 =?us-ascii?Q?ZEUYWD0djuXbwe3VkwpakIQcLHvuXAUUNy2dBWrTZnzEqHt9KLnbnV9aWc9a?=
 =?us-ascii?Q?QtO8NqK6vaePJpsyuc6BZwS04MswunbEXHheeJAv1v6U2nwS6+SGLVKmPDJu?=
 =?us-ascii?Q?LKEy6uIAlergm/tdkp3fuX2isH0Ez0tsYmuNdSKQHOk+iCD8wBK6DNnKDuPi?=
 =?us-ascii?Q?nXnQ8mRfX1TEbaXtkiwCEU7cuzPldjmxguO5vQhSEK3Pl18UIaRAXyOANWAa?=
 =?us-ascii?Q?KJqvEEVa0DZJURigQqcgUOlLgoSZq5t2Mw5Nww9ZNVnNxOTeqkWIpx8fghZN?=
 =?us-ascii?Q?1NitOQDD1HherIfxAUiL6+iBxsY43eEKRCg5nqqvXN3EcBbQfKyhr3arsN1M?=
 =?us-ascii?Q?ObIFw32J+hw2CPhj49617tUVmzwEcXUmLzcKbCjU0fsnsV2vra/QnjjvNTb7?=
 =?us-ascii?Q?Y/XX0CQkDS/n6cW61sh/Q7XI/clMinOvzeahziTXKcV4gNS+2AMWI92w3dH1?=
 =?us-ascii?Q?jpgfxwTxGZ94+HoNdv+q0Wjx8XX3YPaHuUUme8zIdjE1KgVBKKawhzHBRxiZ?=
 =?us-ascii?Q?AmHx2mnteGA7U0skU5vEaAMd8Q8JIZvFs+l8nyJyHmtLgqkysnjq9BcHbH70?=
 =?us-ascii?Q?LcOcb5OgPy8fz0hk8VvheCLh1xt01r8nmx9S8zd32+MXxYgofPXOoIYqiwE8?=
 =?us-ascii?Q?/RCjvR2q11ghAOdc3R0O1cdXyKirVHKYvnT1OQ/u4zf7s4uAGIFvC/HFlSzH?=
 =?us-ascii?Q?8/zPvGTsGAvGp8be3hPWMK+EadvWjIdFrJTbxRO7wAaU0r1us5vpNEla9qjR?=
 =?us-ascii?Q?Tw15xx0od0CRC/MlUJrqF8mN3/4b96QrCCxoIyKvlfs95bNGhXkvWvGL8IAy?=
 =?us-ascii?Q?z8jw9aMG2X7MtpmQv4BLwlUg0wDtwRbK1bx7MBGShXcyIGhdYrrTacBl3fmu?=
 =?us-ascii?Q?361lir1sDvGBLZzLFfb4zlH/K3gBl5MyYZKCfyZ/uH5PVZFxUOPQ83F7WxmP?=
 =?us-ascii?Q?DPLCtb0euUu7mqpnXZj6Mzd0X4n/kY/vi3Badx3mjM6+lOkoz6/9FSSarRF+?=
 =?us-ascii?Q?TJn4aLRbd+TJooQTQirO6NKgaXGYF//aevHSYQIOihCWZ2D2zsq4anmYIP2d?=
 =?us-ascii?Q?q2K5Modof8zIFvY/cLk/ffoezfcKjP7bWXNO?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 06:34:32.9743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b60e604-2fcb-45e8-ae8f-08ddc1d75432
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

v9:
added pci dependency to the testpmd meson file
fixed typo in commit message

v8:
Keep cmp_dev_name as string comparison and create a function within testpmd that converts the PCI name to its long format before passing it to the find_device function.

v1-v7:
The fix focuses on improving cmp_dev_name to perform a smarter comparison instead of a direct string match to find the device.

Shani Peretz (1):
  app/testpmd: canonicalize short PCI name format

 app/test-pmd/meson.build |  2 +-
 app/test-pmd/testpmd.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.34.1

