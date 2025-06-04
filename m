Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623B6C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 07:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E664042E;
	Wed,  4 Jun 2025 09:43:07 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by mails.dpdk.org (Postfix) with ESMTP id 7465B4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 09:43:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQWyWKcAdsJ8dAnayJMvj0Adn/eOXChiLoeQYMHC5U0YR3BtNck9AOqlvHL3qvehGKo8o1ptwO9FwQzSXqTt/K0EWGBMmLljgJgs/xf9u6qEmMOirJcn7JMwiz2EzVnSKZVZSeBeABI59RA63/948ovYtfjcaayZPMuUJOWy9JeOglwV81mKHLRRY1iGsk4ew+R6Q9HNQMwSdKf4NdixOajNDidF/i0Jd7qscxEEV5RDlgeBaeyUs5nq5/Jr0GewXHrj15ZGeVJ+p+cWdUYewXVSnW4Zh3jajG+InxcMio1ocEObJLHM7AJIpuyhwiPI80S4syORi7ErHcb46CzExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JFQtbuP+8VngJqubmWxZbgoOvsZpZBstyUEpHiF+jA=;
 b=fMdk78Hea72PmARi+6KkCNcu1DZiv2RuKpfIZaMFVv6yPQmCUnzccGntv8BwlPjc1Fu9lWl8mqHfFWPzAUT75AJXMeCkTh6OdpdVUdejqzHRFYRhQgNinT3m3HV6EdZhiG8a17OKtfAQeLUd4k9UxSZUCk7x2IpkN4rYG5OxYAiZ04GGOg5Gws5F3TwlXXw3EJaQ97US1drD0ELVIebnAz3TRhLgzMDIDRMa2f0WfRw7+Itq+NQEUNNR1obRs6S44u7gTyTe2+7iNAAFCPXXPsitvK2MRloDu1VEwYafs/MxPUDiNHT+37MJ+OGIiybWuTjaa+BCppyA1PjwLWTv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JFQtbuP+8VngJqubmWxZbgoOvsZpZBstyUEpHiF+jA=;
 b=lkHoA6/C26mxLwmSo+yA3fcUN+wH+nUI0iTR0cRLQnK0MB3lgLXVBc2PgYxl9v2SdB7MBbIZYC6IdpAtpmfYE0KnrFji8aKd3UxtW5sm1ae0KG3nz5UCN4Hwkdgipd19KDC65il4bEGsJbozdRi/mnxohaE2Xvyy8z2K3EXhJ1D4TfaAt4yX4UprQg8zZ87flehvj+np/HTzCE//M8GuearaxFaKq2Y6mnAsxeTYcXbKFuAVjy4HDWQFYaxjpE1+wEjPDgIJbx9zqG1rgYqHbVEqMv2dPB2+qz21Z3Bz3mz2c+b9RNQm++HcEQHSftp9KG5xxzQEFqfppOTDD1hgag==
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 07:43:02 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::bd) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 4 Jun 2025 07:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 07:43:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 00:42:47 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 00:42:46 -0700
Date: Wed, 4 Jun 2025 09:42:31 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, Patrick Robb
 <probb@iol.unh.edu>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] common/mlx5: avoid warning about operation mixing
 different enum types
Message-ID: <20250604074231.fc75n7ooaup75st6@ds-vm-debian.local>
References: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
 <20250603164124.u7rrxwgwe2h5py2n@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603164124.u7rrxwgwe2h5py2n@ds-vm-debian.local>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4658e8ee-3151-458c-45bd-08dda33b6f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x3Lh4n6/6j2gjREiIuGpjcsRWRDiJa5GcxLNEQkD2q8lNryMz/EyTo2CeUrd?=
 =?us-ascii?Q?vbk+lyk+B6puIfoPs0eupUvuQoALWG8SGewDcDQaWcdXnNhkNDfl3mYQubMK?=
 =?us-ascii?Q?MVDkPZLyHhaDFBSe7HGkVOI57ZUdnYjqxy10OihcULB3SiktxWTP5cpVluL1?=
 =?us-ascii?Q?BI6a3sx/s1M2EighFfdWwr8o9DI6QmCYcvETCXAD0Dl/EFAelj3uD6QTCfdG?=
 =?us-ascii?Q?VlPAmVr8UzfAqPaP34iXRUIPAfGfNBMeC0iF3yTg5URpuUDol8VCiOXPJ6dX?=
 =?us-ascii?Q?HdRardJrsxWsZ1OOrMqk+02ACjHVWhJKkxXtxfnwHMTjgLxLEhs55S0hbwbx?=
 =?us-ascii?Q?o34doL+8zGJoFdGsONFhXApd+3h3WZbdUeT77ZjWvtagiEyXtwGQ8blW1o6G?=
 =?us-ascii?Q?3eHUjj4N9XocusvylpPyd7F1kFTW4Y/AjF04l7NF6XqiYnctDcAbMO/C3ts6?=
 =?us-ascii?Q?eu7DsGPbbU6sE8C24goLsArkcO0JqIMUBVS1mMOYq9mHdmQAPBml7pxb6b1u?=
 =?us-ascii?Q?3O0VLHrlpKscSxaR4H+RPibn+1l0p3vtRPUbbhyq/pviuDGBRWvd6T10oiDQ?=
 =?us-ascii?Q?RfYEVe/yyR0zCKXIOJzRSqQ12lQP8ncdcE9XKzXZo93mJsizbYNImkDk2hD6?=
 =?us-ascii?Q?JCnPlDMnUuEyBuZb/mnDhmXReZIBC0YU7NCj+tb9X5QZqoZK2FpZdL5XlOsT?=
 =?us-ascii?Q?EjkllERatciKA3k5B7oG/QQVbrmGH7prBIE0bOnfGaRFGpIjkKE/6see59ne?=
 =?us-ascii?Q?aK6xt3SzqGvfXHq8JKLM7p++P6wwm+xSloa2Br9gQl8KSPxFl0lK4Mof9Jc7?=
 =?us-ascii?Q?iz2PtreS4xN51ET/MuHsGSaEWWeOvbL7F3V58TTGJvEt0ls3qutBmEgX8HZe?=
 =?us-ascii?Q?BI0gFBHNXcZ+gMtMMBEyzBkUU+XRNY1hlthlHTh4gAZ4dsqfpMwTNQt0xstB?=
 =?us-ascii?Q?3BIgZtigePfKTqmlROOR0+DNKUAhl3tfuWmoxRplJDY5930PGI//ev17z1PS?=
 =?us-ascii?Q?0I2CF0RxXUErLiQYWJAtW3cBOHVBZ+vr+zpAZayeHWzGj+WTTJKBtYhgX9N+?=
 =?us-ascii?Q?I3oy04tIg7v3Lj3iWHLR2L4dC1tKkhm+vFwpjGK9JWTmovIjx+hhwY5xq/Vw?=
 =?us-ascii?Q?uhz5C+A5mWbakmCSxwU7gFuA55IY/qRYfMOmOlRP9WG+BifDTWBLf9ZnoGhc?=
 =?us-ascii?Q?yRHdtKl0mgRSfo+5jOGUzcvXzn/bKVu8i38TcyjNd/fam+0LumAizsjL0fl/?=
 =?us-ascii?Q?WozKsb8wL4iADDWJGBqwAcdTISr7YbQVhMl0JqepMc9fbiDKwwSH29LQ9ElK?=
 =?us-ascii?Q?pehLt2QSwqhi5ew/qgutCqS0ki5GCvWP/6ted9FRKaOWc0ZgtFVGg6bwZ0mM?=
 =?us-ascii?Q?vPGLeYoYkBR6PJ5k5gi8w2gQHtJD6UtBqwdGN/+dULkAp8PX72xtvgfSXvCs?=
 =?us-ascii?Q?6VPFYXuYF7SDjkUDv9XVzx7KlIaksTmzdtP6m5Bu+aODCdAjbp6mBPMnYYYB?=
 =?us-ascii?Q?/CYGXuKaegc1c9r/56gT0qOjXPOqq1n2RZDkLfzpZOZnsYjOBAAW5dM+jw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:43:02.3264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4658e8ee-3151-458c-45bd-08dda33b6f7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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

On Tue, Jun 03, 2025 at 06:41:24PM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Tue, May 27, 2025 at 04:41:25PM -0700, Andre Muezerie wrote:
> > When compiling with MSVC, warnings like the one below pop up:
> > 
> > ../drivers/common/mlx5/mlx5_devx_cmds.c(554): warning C5287: operands
> >     are different enum types
> >     '<unnamed-enum-MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE>' and
> >     '<unnamed-enum-MLX5_HCA_CAP_OPMOD_GET_MAX>'; use an explicit cast
> >     to silence this warning
> > 
> > The values in both enums indicate that this sort of mixed bit
> > manipulation is intentional, so this patch just uses an explicit
> > cast to avoid the warning.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> Best regards,
> Dariusz Sosnowski

@Patrick Could you please take a look at CI failures for this patch?
Here is the test report log: https://mails.dpdk.org/archives/test-report/2025-May/882321.html
There is a Fedora 41 compilation failure in "dpdk_compile_spdk".
It seems on the related to the patch, because it fails in SPDK code.

@Andre Could you please take a look at CI failure on Windows?
There is a unit tests failure on Windows Server 2022.

Best regards,
Dariusz Sosnowski
