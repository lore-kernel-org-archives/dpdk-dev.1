Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D4DC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD1B040E64;
	Tue,  3 Jun 2025 18:16:56 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by mails.dpdk.org (Postfix) with ESMTP id 05FC640E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:16:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZA54m4BegkLEaqmhZYvnZ91JjFOaMNJz2ubIsZYxAxVA5kj4FfIOF9oklr7PepYufiZ9WVabiEs1AibLPMYjQbtjIaFOlX28qHqKTWhVrg0SOibTPsD7+MsCxm+4AQdQC2vhOyDg/Yh5rqBsr7wwhxtj1GzEpHoS2wXuBaH94ZYyhC5KX4e3N1/oAjX6DhSc0JgONpKv9sVgLAls+OFeV0vnfpOPx+UNOSVHYNpDT477008vSYf5LITLM/PQYPlcYT0WjHcZ9D/w0/GwougXpcicWn1iwX/4iAl97eSAScbnJjp23r9Im4qa6/gCnpXxHeCTObIoNAYzZ0Lmreh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDxCMiRD0QN0Ix95HETzHYjhAIR3v4xaYB9ti91g23w=;
 b=gNNv/et1tw2bpNsXL9xh01qkGIEayyxALXYbntmDVg1SsDqoNSESLMAYk3spMUDlKM+k7T43zvddHCLsojkYmNzKpjBBxMneVCZb11O0pOjqffQbrRQ51PxTz9BYFzfMptjAAn5EjGs0hWxE3Q0S0uHVbiK4wVWlPHje3xNuSzKslYZ3J/b+F1u2xOVikRb7E6zeqeSOa+6JWm6js3/H9Or215+V2RmusuAk9CZfpuuHzSqxz7YZRUIOCJSJuoxp9kE+d2i7VGRe6tQ7Tu7pqPPJClZnL4hzwAvHVpXe6hPSYdkw/fShQlVMv4OneUkhQrR+lrLclCPae9t6WtgU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDxCMiRD0QN0Ix95HETzHYjhAIR3v4xaYB9ti91g23w=;
 b=N3Ti5vIP8QfgmJuSbPZInNbjnhrHiw/pPIurSpoiirP6G07jlVYKpYHldRiUwZI6iILF0JfhDkHz17hvObEsDlrJbkvp7w9NqwSI1VG+jyEcUCFv/T4W9ET1gzJe007dq2ryC4xntKOt2b0RnDhsuc3IezN1/EyZ5LhHgIuT7Kq/hKrUgKB+O4dutL1UCjGgd1TobJiKz71kcyUz7JBatgEVuVnYrH5WQRy9d43d0DqAREIVHVqAhhGaJ6kzi6upp3l3NkbI9Lnex3z7ASqARNc7JHWXWI54togio+SONI4vccW44sXvG7OQkS3jW8ix74xkV/9YTfIjTpt5SHHMdw==
Received: from BY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:a03:1b8::46)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 3 Jun
 2025 16:16:52 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::f7) by BY5PR17CA0033.outlook.office365.com
 (2603:10b6:a03:1b8::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 3 Jun 2025 16:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 16:16:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 09:16:35 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 09:16:34 -0700
Date: Tue, 3 Jun 2025 18:16:13 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: avoid implicit conversion to 64 bits
Message-ID: <20250603161613.yf5p3hnp52h2fvol@ds-vm-debian.local>
References: <1746458202-12356-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1746458202-12356-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b917eb-62ad-4f3d-bfeb-08dda2ba0d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zw5Py0k0VcxovnGrXHr4CemgsL8pM1TPATZSpXXDsENsldJXYCxYF3aHJJLo?=
 =?us-ascii?Q?NzgCoJUenmZCzSFpcNMMU4EmtAzj3l5BUP6D0emPbtAktk5jmtHmrCQEpNFi?=
 =?us-ascii?Q?6CjriOiHLqYVETcx7CEsQPTOLEnUiI68emR3SD/4O45WL5jDtGiTYkU4DOok?=
 =?us-ascii?Q?MLhOVjipk/w+i2r7ceqoZs+/zlxlSv6XmsV7XiQLqa1JmiY/Xdj5zvjFkAUP?=
 =?us-ascii?Q?d3PoBg3FIA+Foo+N7sAMHVjPAJXZLCtzcB8Q872B3rDGvC5Q7dkq3WSi2bbR?=
 =?us-ascii?Q?jyNUfjdqcFMCP1KzWbX8JLpKO0f1WaR0BeqkWL3Ppby/0nUfxPBD4XJn7u//?=
 =?us-ascii?Q?oYtfBZ/Gf8rQYGxtsSsHuWoKqj0o01W1MClarUK4srrnE5T8JkclebCuhafD?=
 =?us-ascii?Q?QKgQcuV921hUeto+cB6YJmM7Ew7tgbLppIEvWpIUnKAq49GVVGAJ+hmvjgny?=
 =?us-ascii?Q?CdIAodGi+R0mK4rCY818PHxBoyNBONPFiQHMpkgDfRZ63rwz/K3fGrI4/0AJ?=
 =?us-ascii?Q?xYfKWRperQbTI78H2oek5prmxS1JUDIy18+0xRx9B5MXCDcszeC4jDJyyD3m?=
 =?us-ascii?Q?VOCziTrBqLG50S7gH7vjEhkQZyhvZXSaepPPCqTknyDFNohRMlGWKZwntw8/?=
 =?us-ascii?Q?FSHvKWMOU8e+9dvUnCTQh/E+ZuYVn7vAA3She/60hABVrYJLC1evJ7VZqu5V?=
 =?us-ascii?Q?7Fc2a97bUMd4V4QmoBcJZgshQhAqYOuhwFpPN/Rgzk1SgFCWQivLKvTZWB3o?=
 =?us-ascii?Q?3o+mhTVs06fL7bXhkA+vITMRfXzWocysY1/aT4glFBSkW3i1DEQm+qDSmG/8?=
 =?us-ascii?Q?jzpxYn0NdSsXVC9Cr8wNKORViy6RxuzVBhWR6HyuUkNmnpqQNaccGyZjmZVS?=
 =?us-ascii?Q?ZKOEhKFjKWv8AS6x6Hud8fwPPPYIMvk/5dsD1oTAzYEvoPPSIa+Lf9TkyQxx?=
 =?us-ascii?Q?/0BBiQ5MesBW1+73TGYKT+ChPbWNfKnkUnYnahSuSZ1LralZ/RkCT93oehDg?=
 =?us-ascii?Q?Ytel/taCgJNHswzxH4tOEDlKNZA+fcC6q6S3CSxrc0r9aXnDpQOaVm9n9cPB?=
 =?us-ascii?Q?dXWtx7w3r/Z6UBTRjJcZVZ9hyOCC+vS1jgtslJ6lR8bH/T9PVPeKMUgAR1EY?=
 =?us-ascii?Q?9n2CPYqS909xNKBQC4QGY/rMbitwPohpHkGXTqLyGsDs3qcqB5Yfo5NVlvit?=
 =?us-ascii?Q?1It9CtipE8B7fp+SpgG8Hi4/ZxupVtTU5DiTFh2O2pgmv0MqjDJKypn25sYO?=
 =?us-ascii?Q?W1hf+BWfhayyASh+KSodfyJZ1KfTH0HzecJLLFX4Q3z0smkQBTkp3oDt54JK?=
 =?us-ascii?Q?T3NO2mgXlT1HX/1feagWRolyiFARAVR7yvg/qVFum6mAfHzHnruAiuJ8i1vp?=
 =?us-ascii?Q?0JePrBwciDSKti3EPgLUvINEB4ZlBqQw36q+DmU9l7NXNuUJOf+avlderUxU?=
 =?us-ascii?Q?8i4UPnesCISd7el7z26NkQxweeAzu1sWBzNXcqKEM3Rvb/qaK3wNo2QIO66j?=
 =?us-ascii?Q?PEwccBnLI9PYAZHOspoHIiFMHFkOF4vDCxka?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:16:52.3136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b917eb-62ad-4f3d-bfeb-08dda2ba0d12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

Hi,

On Mon, May 05, 2025 at 08:16:42AM -0700, Andre Muezerie wrote:
> When compiling with MSVC, errors like the one below pop up:
> 
> ../drivers/crypto/mlx5/mlx5_crypto_xts.c(488): warning C4334:
>     '<<': result of 32-bit shift implicitly converted to 64 bits
>     (was 64-bit shift intended?)
> 
> Depending on the situation, the fix is to do a 64-bit shift, or
> be explicit about the type conversion by adding a cast.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
