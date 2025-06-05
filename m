Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF11C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 08:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA104028E;
	Thu,  5 Jun 2025 10:33:20 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by mails.dpdk.org (Postfix) with ESMTP id 3611B4026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 10:33:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5kBunOnnidFxfoMSIFxkOQZDlt5tlZIFo7pBu81RhzIgpR6oYw/jbBAMuOZLRSjGicC0xzfq3sV3Zqi7DgxODK9vbqDkZ6nekxmfwYzJxFj0bxaRWiq4j28FYRbAGq/AV956jMRPdY/JfsnmVU8rVYOVFyBM5qfv76Vkue4vxypMxlzS5Ud0b0ipchw/rcQc7bUifToGXAS3JgwkxB44oLiX2Uym8a8xnmvEBLkqRdTRwJjFzbaD08rpU9AKgirN+fkyC89jbM+xaAdYlwFdFqPPfGpRH2tnpsYy9tcSlBQKG+6xdA7RTl7N+dJlN8SrSHD+6gUNlAU0eYcqHnBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5NxccVS70l95FwCMya/16Iah23jvi1bcyeEUFYskDA=;
 b=ugIK9Qu45ZNqknXMe/5gtLRBdx4V08I0lhtJthkxp9EjoRrdwyvwv9ESbNZiuJd3WWgOjmgr0ZByq4EkZuKqUXaMntKaehNtpN733vDp2hpHIbkcL/6grjWpAdOvjJuDpdamSuD0ao2mXsHkeR5Z4pr3/wnT6Y20k2R2D40B1VphBbPtgYDp4r6Tvie0ByUU58c38+s7aFluETKAqPsR/94K9PtEHX74WI/efF7v6lzSI9uWbm2MuSQvNl26uTZjKKdzOTCrUUs1W3QURkeOL58TYLiTnrzMlVKzgbrFd5nR28DbhwuzH2x88FUOmGha8ww4iE7Bb0i2XZeSo6pkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5NxccVS70l95FwCMya/16Iah23jvi1bcyeEUFYskDA=;
 b=XiVm6XXHVLQ2UumxNh0GQHyDK/cBPY9kQwfpbPHZbhftMkiY89RdRa0aAR+wCm9cLenrKeuMtPd5x738V/uSLML/WFiypvaqt9B67ONIZWERDqz5lZ0UcQPu5+8XfJ93iTOwOXXBnmKPfWAfoqDm8NrYRixnTcU9LLdhCfQvKgltK8/l5KbUvitWxuwSZtqZn/V+DrLGcoltxPvaPkTn8rJCFqphFFLJ098PjkaquzzPbZc8xDx2wOJLyVzoN2tFVBm0ZFQR93VUXSQOkMyFToJXGJz7ORzE2Jk+VkejV6tTFizh5NqwZ+sexMJgh/wGK/xUxA7NKK83uALlHjo7kQ==
Received: from SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::27)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 5 Jun
 2025 08:33:14 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::6) by SA1P222CA0113.outlook.office365.com
 (2603:10b6:806:3c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.23 via Frontend Transport; Thu,
 5 Jun 2025 08:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 08:33:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 01:33:01 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 01:33:00 -0700
Date: Thu, 5 Jun 2025 10:32:47 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Patrick Robb <probb@iol.unh.edu>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] common/mlx5: avoid warning about operation mixing
 different enum types
Message-ID: <20250605083247.25l72d36lnfhobx5@ds-vm-debian.local>
References: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
 <20250603164124.u7rrxwgwe2h5py2n@ds-vm-debian.local>
 <20250604074231.fc75n7ooaup75st6@ds-vm-debian.local>
 <20250604151858.GC9366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250604151858.GC9366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: b54ae874-ffe7-4cfd-c8d5-08dda40b9d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eX8+qQpnvZVgkJm00TraZTKDs4eQmsgWYyvCMkNoEsTFbbxoKJ58sqEt4avI?=
 =?us-ascii?Q?AKR5cO46YhHh0rCi2MkQphacLSHEq5c4xoAqT7H9drZ5ghJ312FRv/vqQ50C?=
 =?us-ascii?Q?dvIlY6x6C7biqnFvB/5fISVi59t0ALpQsP2lQEumum5GyT9Nr/sGijmVicwb?=
 =?us-ascii?Q?VxGqnaMUDWLs6QE7aZri+y8AVpdsjnc5DVSbavCYG5Dfo1pwvlK+Enl8AfJR?=
 =?us-ascii?Q?/2sQZlqx0ty7ac4vL0qj4vkCtnNVQZFlDLoOMOQnXJtSo38jhHPSL9RIQfS1?=
 =?us-ascii?Q?+WhfdWWb5afK4hYY6UvhZuWfeVueluhopBU2mgbxVx9j894R30bYc65Rz/62?=
 =?us-ascii?Q?cHpgJafheeF/jfFnVN5U8ugCym3fK2AWnU7vFKIyv3EnePKv1ODO1u1z1f3v?=
 =?us-ascii?Q?yX72WQHbiiAkdLRD2id34vAxO8l1+8uzWbeEuuEQF+4CAh8rRLRyjSIxIyN+?=
 =?us-ascii?Q?CnbBSv6zuvIy5yR+C4kKjEU+oG53iy63henkFRIXUCZlpBhG52f2juE1ttRX?=
 =?us-ascii?Q?iVAcvgR7RLkSOsL8nMH1qKsQzzGKV760AnJx5RI3fu7Tg57ACD8Ei5picWOM?=
 =?us-ascii?Q?cNOsJJpi3wARw33jKvaucnfh4F0HCoXEf0MoXyhd2PMeg3k48dbsPpnZeXPy?=
 =?us-ascii?Q?M2oqWzJZi4aDBtQngUnujAPGNtLiJowRYsBcul5f4cpR0gswHP8/MNzLQwF0?=
 =?us-ascii?Q?j28MrBQPNiY/OlPFzJjNU8vv8QUkoAb+OPrsVuHGCruidDiD+aUhtd+SL0Tg?=
 =?us-ascii?Q?9+RTMC5ZzHGnJncA4k+nOSKXhP+VAN5uNx6+oBvGprQgrdefYmiX42dlAomF?=
 =?us-ascii?Q?HhUrHPUWPjw4m4zoT6AZ8MyC9J4cexw/ZXlvYxhb6bSZBZeDtGIWcHNuym+O?=
 =?us-ascii?Q?SGG5+IW9YsMWCJbPPJ0A5WiviVEb3oWXyY89269fKN3rAsv6+xuR/KiQMq3w?=
 =?us-ascii?Q?A8+KPqR4WLUQNwZj4MvrtsICUCU4XHzwuSk9+hzB/GFd+XzZCbT0fKT/jwky?=
 =?us-ascii?Q?8nETLEETtQEyHGt1rBLWmnXZor9LTva5X4scsPy3rPS46szVBeCZAqh/xtha?=
 =?us-ascii?Q?y0eQZt2pv3D5lmA3QX5ArW/awFRbFpwopEsevGi03/xDpSwYf7IpX97xx6Ud?=
 =?us-ascii?Q?fBPXDcmCOYHAD3HqVxzldZPRM2dSIEoaSWaW06+oozj9fyJTkroP5eCs5F5C?=
 =?us-ascii?Q?iHB0vICHJ4lS6ziaFnwvnqvN7GmC0duDs/AENIbz71yl66alnrFf3wv61sSC?=
 =?us-ascii?Q?BynrmaIOFCVgRmsHtsbmZOZfIZcpsnLdI3lbxmPvWxOhAtyvY1XyLaAP8xOD?=
 =?us-ascii?Q?NMAFKNvIJSCEozpJetIfUZrlMV6/nnbW3herxnszCja2+NCeFBBMJ9aPxnzl?=
 =?us-ascii?Q?RuoMfpZJ07VlgdqpM60pEMxxuRnCw5c2H3FWr9sqJTv9r3fMXVN/B1QkQYWM?=
 =?us-ascii?Q?I9hY/r2u5UungSY0uJNac9pBhH6cymusjPNl0SPe/0wlcFX5gWAOJKCXvfAo?=
 =?us-ascii?Q?jgWRwBfdbSbHHKEfr4ES5I91K2nHrVBNMQXWRrnd7a7wyFFn5cAVC0dKRA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 08:33:14.4165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54ae874-ffe7-4cfd-c8d5-08dda40b9d35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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

On Wed, Jun 04, 2025 at 08:18:58AM -0700, Andre Muezerie wrote:
> On Wed, Jun 04, 2025 at 09:42:31AM +0200, Dariusz Sosnowski wrote:
> > Hi,
> > 
> > On Tue, Jun 03, 2025 at 06:41:24PM +0200, Dariusz Sosnowski wrote:
> > > Hi,
> > > 
> > > On Tue, May 27, 2025 at 04:41:25PM -0700, Andre Muezerie wrote:
> > > > When compiling with MSVC, warnings like the one below pop up:
> > > > 
> > > > ../drivers/common/mlx5/mlx5_devx_cmds.c(554): warning C5287: operands
> > > >     are different enum types
> > > >     '<unnamed-enum-MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE>' and
> > > >     '<unnamed-enum-MLX5_HCA_CAP_OPMOD_GET_MAX>'; use an explicit cast
> > > >     to silence this warning
> > > > 
> > > > The values in both enums indicate that this sort of mixed bit
> > > > manipulation is intentional, so this patch just uses an explicit
> > > > cast to avoid the warning.
> > > > 
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > 
> > > Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > > 
> > > Best regards,
> > > Dariusz Sosnowski
> > 
> > @Patrick Could you please take a look at CI failures for this patch?
> > Here is the test report log: https://mails.dpdk.org/archives/test-report/2025-May/882321.html
> > There is a Fedora 41 compilation failure in "dpdk_compile_spdk".
> > It seems on the related to the patch, because it fails in SPDK code.
> > 
> > @Andre Could you please take a look at CI failure on Windows?
> > There is a unit tests failure on Windows Server 2022.
> > 
> 
> Hi Dariusz,
> 
> I looked at the failed test. It should be unrelated to this patch. I ran
> the same lcores_autotest on my machine compiling with MSVC and Clang
> and it passed (with the changes in the patch).
> 
> For completeness, here is the output from CI:
> 
> 44/92 DPDK:fast-tests / lcore_var_autotest             OK               0.35s
> meson : ERROR: The process "4692" not found.
> At C:\Users\builder\jenkins\workspace\Generic-VM-Unit-Test-DPDK@tmp\durable-3a3a8aa3\powershellScript.ps1:3 char:45
> + ...                      meson test --suite fast-tests -t 60 2>&1 | tee - ...
> +                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     + CategoryInfo          : NotSpecified: (ERROR: The process "4692" not found.:String) [], RemoteException
>     + FullyQualifiedErrorId : NativeCommandError
>  
> 45/92 DPDK:fast-tests / lcores_autotest                TIMEOUT        629.35s
> >>> DPDK_TEST=lcores_autotest MALLOC_PERTURB_=25 C:\Users\builder\jenkins\workspace\Generic-VM-Unit-Test-DPDK\dpdk\build\app\dpdk-test.exe --no-huge -m 2048
> 
> 46/92 DPDK:fast-tests / logs_autotest                  OK               0.16s

Ok, thank you for checking.

Best regards,
Dariusz Sosnowski
