Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC8ACCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:31:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 747634028E;
	Wed, 29 Oct 2025 14:31:14 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by mails.dpdk.org (Postfix) with ESMTP id 983E840288;
 Wed, 29 Oct 2025 14:31:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qChbrGjSgl1SjSThvsiYAzYCezKk1nQM/pJr0xPEms+QgOEGLX+3O9Pj/9IJ8APnO5FtYJ8UG5/JvtpawuW/cVH1Zzm2bKpLoYKcYUEMqbg6wPrTAgVhg2hgOknZQJqdJRYVMByqDrU4lcO/LJUimxRwBUMqGXPXw0FCG3UCOGUeYf/3T4MJ8ieQ+45wux4H7XD8RzdgdHFoWL/GNT0lLXA5ZsOtYvEGqsWwSGJl2iC4zdVEbhTW4EoSLKh/CxCg72Z7lWa/fhOqcfxfJ/HlDXQeHAOuijfZGqiMpZKCayFtYhv6yWwOztAJ2AUErKuYBoqMeLYpRxywrKQ/5ibdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSzdcxJTGKZIHJeMS0JDn9rYDywUccmVB0rSPoJsF84=;
 b=OF2yEuGUXN7xIOwGhcpGFYsJ2zl5UITqzVnDG9jHQOIzvMaKpKrzs5eJYbFw/OtD3/2JKL6muwWLCiVMSHIub/L23ar+xqxeQMFQmkntZumEzDAtvqhTCOh/6JtC+chrfOSedvWk97vLPJ6wHWxv7D7iXDaiN3GFyk/oqk4yPP3zU59ZzVpfc4B8h5UhuH0ic4xc8hlUON5AQthyicsiqAX17bP02K+Xs+b5RfPpAS5OsaFD/DYWqBjMyfh8/W5BZugq2ZTVAu6TPopKvvL66Fk0x5G6skR/Kqm2XSLK42TyWPaMZm0TfnmspZ8m/5vYyt12kFchQkLC7HVjuqLUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSzdcxJTGKZIHJeMS0JDn9rYDywUccmVB0rSPoJsF84=;
 b=t6/XcMsW+jJ+QHC5gIZaDLizDf7U/IURxgYrb5ohx8pZ7Mz1Fye8YTG9Pm1/B6uh+i4kH7ugyWDdRVqiW5NKoMkbrpVWBzvyafMFbODjhBU6sHSeZ8kRXrN5VOeTKWG9IZq63ps+TjNFx5ZWGWvGZTgsQ6SWXNU08wbumREOHtOQBFVGXly+nz2g0r+lxPU6mED/Ey/F1+4XhecPasduxIFC9y/DUIVMOtMZSHPBIcb/7T+7S/78FTI8gyr2j8YYJILfu3YdGGTJRb7pTMHpCEgIvRi+mfAnCI+BK5nfZ2M45EQ7/rSYCWiG3sLxyAxb6xuxCJWaGy8cxMVBfnQliQ==
Received: from PH7P220CA0093.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::16)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 13:31:06 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::3c) by PH7P220CA0093.outlook.office365.com
 (2603:10b6:510:32d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 13:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 13:31:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 06:30:46 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 06:30:45 -0700
Date: Wed, 29 Oct 2025 14:29:32 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Rongwei Liu
 <rongweil@nvidia.com>, Michael Baum <michaelba@nvidia.com>, Li Zhang
 <lizh@nvidia.com>
Subject: Re: [PATCH 2/2] net/mlx5: fix unnecessary comma compilation warnings
Message-ID: <20251029132709.qokhickdax5uh27a@ds-vm-debian.local>
References: <20251029095505.100582-1-getelson@nvidia.com>
 <20251029095505.100582-2-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029095505.100582-2-getelson@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: d053ec12-e756-412f-e1f1-08de16ef698a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tgnou7nywWxwc7KZWYVEUD4oAf2DJenDLtj4wgir8RwHbHvsBsmX+KgNm/5G?=
 =?us-ascii?Q?4OrJRUQxFVtKU7pHcf02o/+DIbzbT4u72c+H7i8r0PRJzCJLIAW0uvTaI6Y2?=
 =?us-ascii?Q?aWemWYGUeIjdvpPE1r4NJcRBxjl8ophVa7+5lhdChQIQAO8dvk9nL1rJbM1v?=
 =?us-ascii?Q?4FMPK92CyDWvjYFjtMfT1vDGZ0Pv/VEHQURM6WH0u9tO5/aKh6Iyj5OIOtL3?=
 =?us-ascii?Q?sxhGRVJLowDrtt6V+lX1oZ+lKKemE6npiAtRVR8IRz8R3C6FStRjExL6amcy?=
 =?us-ascii?Q?L/rlZ7AONfmKhr4I5HujLh8hHQ5sHzb7Vb5RL7OX+em3MrC1XgX4uV6ycQ5m?=
 =?us-ascii?Q?PTDT1Yt5vRgeoJEBkU837t48GCBmVUupG8hasqvrzPJahgeeeBsckdzWkFSx?=
 =?us-ascii?Q?8bkGPm1z4NlURmrdWqAiq1xXAiX1QcE8/lsk3rcC0gV27lNYaA+D5ZrMIwWh?=
 =?us-ascii?Q?q/FTOUAWWx7xMNaITT5f80mOK8Fvvysd2UW8/1tJgxVa4/PqlqAvpWVL+6em?=
 =?us-ascii?Q?XDfvGHAL+NrZI1+vkmQ5kxu2YigsAvAYvpPu0geJD1Tv98ZrB4PuODS6k4v0?=
 =?us-ascii?Q?6W9C2CXIebmSHN704xFKAZ2tpm+hHLVEDZcPiq28YoZ1ExhV+LNu4Zc8Rs6Q?=
 =?us-ascii?Q?rEc69ZpcdW+lBW7bVnyEDpwgUJXnPPdyLNEonRc1yc5NaKUcRgply9DNhI5D?=
 =?us-ascii?Q?evTTaPUSTmkSCi2ifiDHNID7hYARtqdsDpwuja6oyXEv+U+RZEAxEHnA21QG?=
 =?us-ascii?Q?tiECxi3yGnE1dfnX5hgZPAPl7f5wvG70Yqayv+Jyd/j3/wnaAjosa3dcBWyF?=
 =?us-ascii?Q?PVtKvXqLHXSCtIpApqMAMU/AEJHDyE7ead6YneaD37kt7/FMlryBh03qLrlH?=
 =?us-ascii?Q?Tux1OAN/S9hlLgr2gwrFLAfvV/M6ILmCs8O+K1vfeDf1JNHEPdH7vWgWUQCA?=
 =?us-ascii?Q?Sn5xmu/Q7ZRN9o3WNMiM5TIXRkErlheUaRtaDG4RG+KAPKqmkOh9M4OYk0HV?=
 =?us-ascii?Q?zGaez53zrDA2+dbwnIm/oMCkGu5cdZJJv2s4kNBIW3sKjOManInjeb5SKe2b?=
 =?us-ascii?Q?MaHqhlNlnmBBvJlviB2gBsYkcaA8fGlK9AUIcln0fjH/bz2wJqfvd457r01i?=
 =?us-ascii?Q?vsXKqfryHpqMmXLr5Qy/BtWF7VUlp4CM/Ah7a/5f2Ofp+DutNK3Wd7JQ2I2w?=
 =?us-ascii?Q?bcKaLUhfmo7e4RmEl9JIUZKtZMb3/y0nVfy1nwIRDtfGdRwdfjnDVRWnfpB0?=
 =?us-ascii?Q?iFf/jE+crIfJY+/FHDzME2P+lkDMFaR2S/p/mIExV+IupLVVE/5yf7sqckFe?=
 =?us-ascii?Q?Y1x/SWBbOqalqSJ/yuuxeOl4tN9xcMjOCifkiPhb6Rf24XPXNZMIXWKPb0Zs?=
 =?us-ascii?Q?tZ6PA/z1bXEgbPe0DU7RB3KxH2ZmvTLEseDmNioHa/Rw6D3KaDVXIFfFmCNT?=
 =?us-ascii?Q?+tmJqV9FpvIiLYVrZRREhTKA8dH+paXEKFoJ5q714wmZKOtNaZlw+RpkcvRp?=
 =?us-ascii?Q?oovsZS87BHXJ9u+cF/q4a0EYf6FqdQsgvs2UoNMINm32yl/ZH5n2tD6EFaYD?=
 =?us-ascii?Q?CGEG8Y9EtA5SdpOWIFI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:31:05.5781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d053ec12-e756-412f-e1f1-08de16ef698a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

On Wed, Oct 29, 2025 at 11:55:04AM +0200, Gregory Etelson wrote:
> The patch fixes compilation warnings produced by clang -Wcomma option.
> 
> Bugzilla ID: 1810
> Fixes: 630a587bfb37 ("net/mlx5: support matching on VXLAN reserved field")
> Fixes: 86d259cec852 ("net/mlx5: separate Tx queue object creations")
> Fixes: bc1d90a3cf6f ("net/mlx5: fix build with Direct Verbs disabled")
> Fixes: 444320186393 ("net/mlx5: support meter creation with policy")
> Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
