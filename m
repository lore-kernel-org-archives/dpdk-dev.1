Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF4C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 11:25:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 530234014F;
	Fri, 18 Jul 2025 13:25:46 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by mails.dpdk.org (Postfix) with ESMTP id DF7D94013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 13:25:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMTDqnciPEZMapRiKUjpbku5enf5Lw5AEnXPouu9jSRjSfJl+8DCTkFvHppoqGo1W94glZ0iggpHKxOes9zlZNj2P3nqVj7qK3/OR3MT0a/iBL2elGwqK0CtF1FH/hDyJYRSjMsT489OMHz0Tqt1hQYYAMiIqRAVA/d0y6GN+/WxPg+h5boiQo0U5zwAxYGFkxKWzzS7D126NCkRaVh3/ElVdlYS9sU3XZXfUq1oJ/O5EX1ttO/5gwZxr5+9K+156wuEqwEGYa/nPwsQgLvUFFvgnXbsHQCwQIUqWfIGuT/JQaK9HXlvRImSVojfhXRGGJr1PtNfL35AKmzpR8gSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq8Upa2DOHcQLQ/eeImkm1XP6ZjsmhmCws0PX4v6yN8=;
 b=ma+2lmn2ksvkftxn+9ptgQhlpG2e1JAF/zCFwxS3Qmyq79ZEXIz2Jc/d0hiJY1PVf8H1CKIVOw7LA9zemDluknsp7uE2ZlxZgoPqXNslhbOBlPcK6hzFD9zkXobfsG8SXfM50GAcnghWQ86yhbEDp22cSO8atJ9Uae/110cifwSuZaARq3wVn+qbyFCtr7e4l434kne19W/sq8qSiKry/mb6ysHlsM6MD027yvoxktkJ3XKwnwxjXYbb1fq69chNKf3RdLOTqFQR17wTY/dCu4EaIW/8pDclXgFoLANJ3dFMr1oD30ZSRIb9Gul4e7KVxrfWHdL5AIRVI5JsY1k/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq8Upa2DOHcQLQ/eeImkm1XP6ZjsmhmCws0PX4v6yN8=;
 b=klldU6hi14e9kGcLLwtNkwNaOiwgf5jVRX7wPb/tBuNE3HTCXsn79lZA2AIcNTP5ATgOTKwvrBKfh1Jw9oZO8CibODCrzfegFI4WGG13DNLfLeHtTb0iODKwtWLBV4kh0qK2KaSlCw4sVPDiXp0pyp8gxsKheW1SyjPTjINv+i8M9VGnBrwmwlfeiaJnXORyxeT8tKkk1X1RmTk70EZBALyYAXWNVoL3jrCr0wT+vAJ3+lOtBmy+BLXwfPOZBKabfBQEdQpl6CP8lPNGpGLS9GO5uXkctqPAylEPlJ4DPkLXcc6NxX23lZg3JJIx5zIW08kZgpnHKY9u1Ka8Y6LmLA==
Received: from CH3P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::11)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 11:25:42 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::d4) by CH3P221CA0001.outlook.office365.com
 (2603:10b6:610:1e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 11:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:25:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 04:25:27 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 04:25:26 -0700
Date: Fri, 18 Jul 2025 13:25:19 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <bingz@nvidia.com>, <dev@dpdk.org>, <matan@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <viacheslavo@nvidia.com>
Subject: Re: [PATCH v2] doc: update parameters to use for mlx5 on Windows
Message-ID: <20250718112519.w7dwpbuztxibdhjw@ds-vm-debian.local>
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
 <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8e514c-be32-42c5-00f9-08ddc5edd4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Egy2wSBlPe6t+6HYaXXFtwCxROOJilGUhHDkQ2NRdpCI+4l2r1wbzdZ+DlQ2?=
 =?us-ascii?Q?N1RPRDHWBdMU/0Y4wWTvlq6EpFM3AgqLBTlivQd4OQi8a+G6FOjfdsOJgR2U?=
 =?us-ascii?Q?x+8R4o8AU5SQKoVVwtRhKUI6pmnzO65xMwyYWpR6/PhtEJF11Wsr5D6C25E+?=
 =?us-ascii?Q?YxViFGJNnyjlx8pXn2oRNIUgdQ/6RAZ6ELnf/uXqwuJYsnU8BWy7dBEJiiC0?=
 =?us-ascii?Q?s71br5p9QnChyxI3L5vECX5GcRNdigzoEFlz0knMzspFmeotMPb7e1AGl4Wk?=
 =?us-ascii?Q?hTyE52YOWSxnzyhmHGBQl2gwVF8QZB5m0Fo4oBpKFJKLNErnWggoINVlNvaN?=
 =?us-ascii?Q?HNNU0iY9izVH2qQEYCH9Twahl80/MC102rE8rHugib9uF4iXihwM+EOn/XcL?=
 =?us-ascii?Q?L7V/yGzZRt/qRXEkNVICeEpElb1dNeysEtiKuk8XidBDIfyYQhRyJTXCvwdG?=
 =?us-ascii?Q?0EFAEohvX/hYpz3ppMRow3uDjTVEXiNI9IrM6s1tpY51YG1LZ9Z8/Q6azknA?=
 =?us-ascii?Q?z21rQmRIOCLknwRxetuGi0qivzn7et/AosHuNEoCz4W+SV6Nb4M+O8FKJ+gO?=
 =?us-ascii?Q?lDFL+6AXfChpO5q+OYGXjkeZBCcjHRw75/6o+x82SLnfOQuVPYLHakvMM19J?=
 =?us-ascii?Q?BLZYPHAkyOaynk6X+YKvAbGPXGz+xCrx8B6nF72DI9mFZb4tRPJRfqAa/HcX?=
 =?us-ascii?Q?oZU2LBlta5y/eW8Eznx0SFXSvqKGWTRydNv3yJ4eMK7bk50MTaFBryhRiKDs?=
 =?us-ascii?Q?l/helV6rTVdhftq7FHDwQJjVW2KOeHIfncavh5YZ79tff7DJanm4YK0NSQFz?=
 =?us-ascii?Q?La/ujlDzlDFAVl6d7K6DFbw8IZM7XDiW8YThBf2byNOJjpgz/3YGygFMaGkQ?=
 =?us-ascii?Q?EhQ5tTs9ec0Sywr2STpOoDNEzDXwDqMXSrEpzIMR2+PM0243VJVSzJXMBgkl?=
 =?us-ascii?Q?QGH8L2mzxfSeU7fDayBBuqbLImUakdNR9+8WpMkWiYHbH6cAR0APzF7OyEep?=
 =?us-ascii?Q?PEffOPEbPiviF9NjGoJqYY3NJT44/1KR89mmiO2Ep2UgcT4xf0YTBJxcNIeD?=
 =?us-ascii?Q?QDKrtUB4QacKFZ+uamuyhI8l5o0cwhL89I9UNz/+SaI2g/BpsY77q/qIJokp?=
 =?us-ascii?Q?woOKBM+hOokdN9aXJn/VMAJ1nmimtI1WRoxdKwkWi5Nb3x2S2F+g2/AqQqo5?=
 =?us-ascii?Q?LOOAaiHG9R3JQDieN1J1AWTklFm4TMT1hH1AQ04xKvRs535zyI6QCfFaz6Rq?=
 =?us-ascii?Q?vvWoV4eMgiW/VeLelyM+2+1ZEqRBShvS3M0YsBRO7Fey3MLq2mYlT67SBnXf?=
 =?us-ascii?Q?1HbiUgDyg7yqXiL2FglG6aVtk9IL3hn6Gpx44BtsBRagWXW4aJgPvSodKHgN?=
 =?us-ascii?Q?IlcughlRiP1EXOR10mFe7vnaObI7w8+T2HcRkmVoATl7d+/ry23xl61XgqOy?=
 =?us-ascii?Q?FuIA3J2rGItnp3x+5V5HBs5XewcMch1AErs5bSZaM2Anr1pOVMu1Ic0xMNXi?=
 =?us-ascii?Q?gYsA9Y4hPvLbeNznuJEf6RHM+2No2cxph1dM?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:25:42.1132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8e514c-be32-42c5-00f9-08ddc5edd4b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
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

On Tue, Jul 15, 2025 at 07:14:49AM -0700, Andre Muezerie wrote:
> The linker parameters to use with MSVC and Clang differ.
> Showing explicitly what to use with each in the documentation.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  doc/guides/platform/mlx5.rst | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
> index ab3107209a..94ed59b170 100644
> --- a/doc/guides/platform/mlx5.rst
> +++ b/doc/guides/platform/mlx5.rst
> @@ -268,14 +268,33 @@ configured by the ``ibverbs_link`` build option:
>  Compilation on Windows
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
> -The DevX SDK location must be set through CFLAGS/LDFLAGS,
> -either::
> +The DevX SDK location must be set through CFLAGS/LDFLAGS.
> +When compiling with MSVC, use either::
>  
> -   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\"" "-Dc_link_args=-L\"%DEVX_LIB_PATH%\"" ...
> +   meson.exe setup ^
> +       "-Dc_args=-I\"%DEVX_INC_PATH%\"" ^
> +       "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
> +       -Denable_stdatomic=true ^
> +       ...
>  
>  or::
>  
> -   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-L"%DEVX_LIB_PATH%" && meson.exe setup ...

I checked the old version of setting LDFLAGS to "-L..." and:

- as you mentioned on previous patch, does not work
  (-LIBPATH is required) - this is with meson 1.5.2
- but works with meson 0.57.2 (used in our local builds)

In both cases, MS linker is detected.
Older meson fixes up the flags before passing them linker.
I'm not sure which meson version changed that behavior.

Regardless of that, "-LIBPATH:..." works on both versions I checked
and seems the truly correct way. Let's add this in the docs.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

> +   set CFLAGS=-I"%DEVX_INC_PATH%"
> +   set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%"
> +   meson.exe setup -Denable_stdatomic=true ...
> +
> +When compiling with Clang, use either::
> +
> +   meson.exe setup ^
> +       "-Dc_args=-I\"%DEVX_INC_PATH%\"" ^
> +       "-Dc_link_args=-Wl,-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
> +       ...
> +
> +or::
> +
> +   set CFLAGS=-I"%DEVX_INC_PATH%"
> +   set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%"
> +   meson.exe setup ...
>  
>  
>  .. _mlx5_common_env:
> -- 
> 2.50.1.vfs.0.0
> 
