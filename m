Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23EC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:07:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D721402AE;
	Thu, 26 Jun 2025 15:07:47 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by mails.dpdk.org (Postfix) with ESMTP id B1FBA402A3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:07:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk7orxZL0SSPfV4QtAw9sRptm0cblwRRPMfeEIpxYFn/3NwespGgoKl2n3D5csr0V12RNQAl2K6aaGGUq3db6GKaZQ1FDxlKnQYalGyBAQaf82vcxL8WnE37cAyROGiEysyiD89AtwSpeIrWOy8go1rNbmddy7j4/zr1zq3cX09VT1W/77AmCX7uoVaNAVpN1UeHlUakUUoa64IzaGgRcP5DU3vqzFu/fBQ2Kp4gIH2sl2fJScRPxwQJP+G+Kkroblqoi35UmBDqBvfwW0qU3vClv29WiEg0uylLOnoTrSeyWcK0taV5kUtFATlfah0V4HtkHMCLP2v2QIrc6In4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtdVXrQlfzGeC76eciG0yqjB6Iff6hOMEVv4/k4NaRU=;
 b=hijsjSMru7J4Pqf+/RmEZj8qinVV7HOkj5Ea5UHoqHOXtyTlvy68YEyJJButYxH2RzJhGIptCHjGiX3Ztibbng2pP8IxKHadYMX4HM8ykCvSOYfVSBb4TNRRZN8Vt5oOn0Cl9E4S69/EWLs/CQ917In2WeOG8GemUi7bYdVmc/H8WomYb2UfgWAJvSToLHz0M2FpBh2AJ+1GW8/buMRErS9WkTjnb4Hzub0h5id+BeW15GtaKk/BvJ+WF8SHVmAHjTMRl5mVOfqkKKUECmrgqGrFuvFvZiCBxcx5XEKieJ5MdZSTdAqYo8ITpWvm1aZNY7OxqiHCvZP4zMXJxmD8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nokia-sbell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtdVXrQlfzGeC76eciG0yqjB6Iff6hOMEVv4/k4NaRU=;
 b=AcHwEYNpAKGjLNsGHPrbH0OBHb01neZbFZpA0QFiqQYXEn+JaDqkFDFxDtGPai8DF9QxX5sqsMcjaNIIhdQhB/IzygFWlGKM+romSUQFoG6pn1TjwI85v65qLw5tcMgMwVHqsQRJYPvWUH+djTOl5gGgM0Rm0rgYEw83eZHSyXWL44gHElf6kMY0VhS2wgV/hTeqne1bskDEqt3j3ZJron1L+/nc9mAh6yuG9nbhducK2h5gDxOhFkne8nnnIGpNLzH8tE3dUPsAmH7Iy083HvUd7lQTrI183E6ZyXYd8FhLueD5/kT7W5jUC7l/a6BZfe3aHPsBrWV+FYfuXtFQUQ==
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 13:07:42 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::45) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 13:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 13:07:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 06:07:16 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 06:07:15 -0700
Date: Thu, 26 Jun 2025 15:06:48 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
CC: Moses Young <mosesyyoung@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>, "Bing
 Zhao" <bingz@nvidia.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "julien.meunier@nokia.com"
 <julien.meunier@nokia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: Re: [PATCH v2 2/2] net/mlx5: enhance log file path
Message-ID: <20250626130637.c4a5jtfoglb3ssha@ds-vm-debian.local>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
 <59bb400d-5e49-4ecb-941e-2513894d6930@nokia-sbell.com>
 <0a6576b7-5981-4a7d-b33f-aae011b86a00@gmail.com>
 <PH7PR12MB701812C6D5EBD32CCB17D1D0B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB701812C6D5EBD32CCB17D1D0B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f31670-7e78-4a87-f000-08ddb4b26e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R+OuNRqX46Kvxt3LXrzXJ3fSMlBucRpfPJRaHeevuW5+2bLqBrdjK3I8z14e?=
 =?us-ascii?Q?cY+z5IRYQMRfn0gV4V6D6oSWHuvoSJzqeMPLmnVgsBVDc/GFTR3S2lM1ysJq?=
 =?us-ascii?Q?2MJitTORwKushjmnJl8MOA737qHOubbpAdetCUnd6GjAv5RBT62e9X3OjGqk?=
 =?us-ascii?Q?a5WpRLH5yi+IvbYf2mntQjVWII59C5sRkMfTvEo9XMWZuaC0Q0Scf0hTp3ia?=
 =?us-ascii?Q?KvnhX8wwTLs+7mFRthQQHJMlv314a+nNka1h2izTVk0LvA7TvsrCKmS1W33W?=
 =?us-ascii?Q?OJD7nFJs8uRDuRCpy1fpb4IDjDCg7+qte12BP54sB+eJh49jdGbyJpzvrqR2?=
 =?us-ascii?Q?zr/m3Hm+RI5U6RC0/G0re5GXtYMRhIyr+tLtKLNZEcaSDAmc39xqkH71AXbT?=
 =?us-ascii?Q?mWuMgyK9g+1Ai1TnepxhADrxyBCrNhncJ6Uuj8Xs6Oy2XagtuvLOhF31LyRL?=
 =?us-ascii?Q?RlrDU84dM7LlIf7Bfr9pw7HEbCKUKg9xtJvHp09bLm0d0z3j77ovjhPZln+5?=
 =?us-ascii?Q?3ktO6PtrPxZsOodA65kKPuzrVrUO9FPRwav8TTYKCRst7HNjUY1SfBCRpFq3?=
 =?us-ascii?Q?SdlR0FO8Mu9DWlpiuF744/usJfTywi591KJxKkkB0Dh4Z1Hvp6/qxe9EwS4n?=
 =?us-ascii?Q?ER9tYzOgdVARE+0b1XDYs0mPIshio1pPe6/ypUrgpDJS4lvNIxz7QSTuY0CV?=
 =?us-ascii?Q?l3VL9cNH9mx9hN2oZjZXNE2wK18dJxDKDoxEX8DrSqTiIewA1UZCMoBf14or?=
 =?us-ascii?Q?5PF2XYrA6xSUg1UuqgI8gxWn8aXAk8Q0DtCtBhSHXZMW5HrdmefFHjkJVKup?=
 =?us-ascii?Q?cv5EDfBB73OG/j1vXvjLy4LMGbCBNONh/rUZ9t3Nay0K0z0fynV+OZG07RiL?=
 =?us-ascii?Q?MY7/phvCTZgAOmtF8xdmReJfEDHCx8+IhdaW5xBtr8/4+AwrCygE7wBFNitF?=
 =?us-ascii?Q?nlOAhmd7BsAxjIk5U7Ttq4uVMH/nir3JTAjM1hbTNT8gW0nRYaHn8STZC01z?=
 =?us-ascii?Q?1oeYJpnUfHZ7oo/oc5bAMS+waJlivvKb4pdgSuRmgC6R0RMlM6sOLs/piTIK?=
 =?us-ascii?Q?v/7ugbxulZEEHy5qDXEXzBdPNFuOCDrIOR59lj8Rn+iE14Qv4uIa6HEu4bgD?=
 =?us-ascii?Q?pe9GvD9Qx9nfSwLFwf1WVTB10Rhe8B+heQhR73kjaxIZn772Ln2VKX21d02w?=
 =?us-ascii?Q?9HNs79xTlJmBSsIuRFiaAdKR/Z9ZBnRUQ9FbEYn4cgwJbhbnC7Yut5NKDGdZ?=
 =?us-ascii?Q?qbgDtP7Ipt3vYx92vFeJhP88q0cXTgkj+SRNFtH05mJ8DdllPZfENlwehici?=
 =?us-ascii?Q?GCY2S6pEdYYHSeytVJMYn99C7I2J8YQ9DOooNkAW5PebI+FkmlbumOWXkzAT?=
 =?us-ascii?Q?NXIDiVFDb4L1In+2KR7pL0NLEtLkmrRcPVXXbon7HphDCxOfVPXn9OSoAu44?=
 =?us-ascii?Q?sMyFHvIrhlm+Xy8lT7styBLLDrTDK+nHx4e/VU/nUK9geSKs1v9d8A6U/J0W?=
 =?us-ascii?Q?xsZdR1e5lcbkXQL6EyJILesVZP19cL4NvBw6tvT4rGrdoa80ifdb5qpMrg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:07:40.6325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f31670-7e78-4a87-f000-08ddb4b26e88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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

Hi Yang,

This patch breaks compilation on Windows:
https://lab.dpdk.org/results/dashboard/testruns/logs/1600918/

The problem is that mlx5_rxtx.c is used on both Linux and Windows.

Would you be able to fix the patch?
I suggest to do the following:

- Declare a function mlx5_os_debug_dump_file_open() in mlx5.h.
- Define it in drivers/net/mlx5/linux/mlx5_os.c.
  Here the existing logic from the patch can be used to open the file.
- Define it in drivers/net/mlx5/windows/mlx5_os.c.
  Here we can rely on rte_eal_get_runtime_dir() only,
  since MLX5_SYSTEM_LOG_DIR is not defined correctly to work
  on Windows as well.
  (see https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/access-waccess?view=msvc-170)
- Replace the opening of the file in mlx5_dump_debug_information()
  with mlx5_os_debug_dump_file_open().

Best regards,
Dariusz Sosnowski

On Wed, Jun 04, 2025 at 06:54:05AM +0000, Maayan Kashani wrote:
> Hi, Yang,
> Thanks for contributing,
> There are some failing CI tests.
> Can you fix it?
>  https://patches.dpdk.org/project/dpdk/patch/20250321132750.4237-2-ming.1.yang@nokia-sbell.com/
> 
> Regards,
> Maayan Kashani
> 
> > -----Original Message-----
> > From: Moses Young <mosesyyoung@gmail.com>
> > Sent: Monday, 12 May 2025 13:13
> > To: Yang Ming <ming.1.yang@nokia-sbell.com>; dev@dpdk.org
> > Cc: Bing Zhao <bingz@nvidia.com>; Dariusz Sosnowski
> > <dsosnowski@nvidia.com>; stephen@networkplumber.org;
> > julien.meunier@nokia.com
> > Subject: Re: [PATCH v2 2/2] net/mlx5: enhance log file path
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > > Hi Experts,
> > >
> > > is there any chance to review and accept this patch?
> > >
> > > Brs,
> > >
> > > Yang Ming
> > >
