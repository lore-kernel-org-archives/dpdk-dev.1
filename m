Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED36C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 12:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A0F4028C;
	Tue, 15 Jul 2025 14:53:19 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by mails.dpdk.org (Postfix) with ESMTP id 9792A4021E;
 Tue, 15 Jul 2025 14:53:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAWulziJEJfRy8LyQNuVjOnRQcnqXPjAaLeSZIqhcbdKLpJg2UEPNWZ2N3ZXHbMj6GVRqqwlSiQ35QFn+OOlfDcKS9iIKYlBz7qQdeyixQ1Lx7hl9QAzkOO+vGI9I1BZD5ySYZakyJhHFXbJVkcM705XSBfiMtVLoKGbd3xJMRxyVsKi6WPSS03MuMhVaXuYr4hboP4HoLw1OhBrT4J0rrJYeoipxhHTy2YuBF6aTzdfmPQlSEkHByGIG4UnZk+zcF5dszMPojyWfWzcl0MuRVs3VyFOektmP4r6rBY7ZDm1HFQujnTCYh/ExVlcqkwoO2UR/59IOB2vtGkhgfmqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj2/8itsfCpv7im8E8OQKx9C4ANEWQ9GGAvWfM8uV9s=;
 b=kg28O1l29UwUToKDl7XdQg4SBAPYYtXG5KUlsNr0ba+VgWwu/a5IHsXBlpmT/16LUEbFV5HrYHesLTwrH9bZm+igl51Rae9KmXMOjvf+zXWRNJJx821GX93XfKv3W/vCT4fELkrBouXJbq2et6J8BDmX8S6IBQZBDOessPvbLjK0mzuWnnb884N7n2o0HIxKxUE9Mtr4tG0GWI6yQf62p+4plPd5fRhEIfmF2Fyzd3YdjQNz/aQkHeFEwtq6IRtk/XWrMLGTKEqsuQZbWIQtdE+ykJooTBj/nL/DWVQXQRjce+gtNJKIjWhy16FFup67tZPa4AqpFCPs8t8xZuiKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj2/8itsfCpv7im8E8OQKx9C4ANEWQ9GGAvWfM8uV9s=;
 b=hgPDMBp5ka56OnWXj04hXbAeG7jntIMJUF3/DvlSPLr/oS9VVEpxnjLPv9qI1HDzM+KZlsJNXqrFCsTwUujU4bBJZK7f/eSdhxW2/AcoHaidQHzG5P+Kg8OyB0bNl+EoNB8a9zMkojOLtsf+7Znf1lIiwa6cg8escMb7Ww5R1r2Fz/IBYEWzK5cipkSwiX05uSk6SwJhfc2gnuywYMXe6En+GEF2C1nXXURef4XvCWkkOAeSacxNP2gOkWsthPsequYFyLcITEpSYGRW0dH9q1zjQlgBwHyLTKmxLYgibNphP1iXI7M0A6x5duBccuOUVAJpEr3ssPTSlfNksdxg4A==
Received: from BLAPR03CA0158.namprd03.prod.outlook.com (2603:10b6:208:32f::24)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 12:53:15 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::28) by BLAPR03CA0158.outlook.office365.com
 (2603:10b6:208:32f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 12:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Tue, 15 Jul 2025 12:53:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 05:52:54 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 05:52:53 -0700
Date: Tue, 15 Jul 2025 14:52:49 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, Khadem Ullah
 <khadem@dreambigsemi.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] doc/mlx5: document firmware requirement for flex item
Message-ID: <20250715125249.hwrzd4aasfjhhyxa@ds-vm-debian.local>
References: <20250708114921.1031027-1-khadem@dreambigsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708114921.1031027-1-khadem@dreambigsemi.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca02bc8-5af1-4d88-ca28-08ddc39e9061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9CMOO78FNukmKC6RJR1z5vS7+vEd2i59/JESYcnB0JQF+b9TBDA3h6TUDdtS?=
 =?us-ascii?Q?mQxn7WOkEWI736MI0XJNRKN8eDNLQFVTfk75NFK+qKVayZYS8CMYXp1axXgh?=
 =?us-ascii?Q?RftpNrx1AwPMhZan5wYNOG6vd3UysOc/S4ZDx+0y3gttUtIIj45C6nzAdQqp?=
 =?us-ascii?Q?mrThDPxUafA7XQmMfb/rWHZXcctqI0VIdp/veLExMR72Nlr+jfKqfLHRzY98?=
 =?us-ascii?Q?shyRhgVlkk2aQ44Pv8o2/kAjyLTlUUgd7TQDzYx+//JiERq6n0+KARtHMS7S?=
 =?us-ascii?Q?jxcqxEQb5WmiB8ifgXS9HnAxnrBodzqGZmnMLbcwGZcF/2BrCKN8SlAtx9qU?=
 =?us-ascii?Q?rvsh8FiwwalbNI2bA+/aLKZmB+4m6X8GmF+2eryBdm9OZpCEVoxlTRt39RAW?=
 =?us-ascii?Q?rEYIIF2AzWrd74PtW+p7XbIKLIvA28PeGMbkI1dfMSAwlT3KXlXg7xcQUCma?=
 =?us-ascii?Q?MKBQNOz6D8MhTwoO8LbBFNk/HrnJ+SNeugmspc0PLp5OwKngu7bQ0/IJtIvP?=
 =?us-ascii?Q?leZllYEh0Go+IJLVsql1bYF8MJtoS2NwBK1poutrTvG9QqGjyw8gGmnTigtH?=
 =?us-ascii?Q?Cm/6ere9u4Hd4rTZnTALc8+bcMQgG7xBS5EGvc/m7TFPouKj6P3+QNa5zJ4G?=
 =?us-ascii?Q?90InidH7Xch5hGXdtwD72m2r998C+QE62eeTKnagndgFB2uSZ51x+wZL/3Jt?=
 =?us-ascii?Q?N/QwBz+ZZYAy0vAQqW/3cZ98XbpOnSGKjNfaQS0wSYtxmQUVWKmEtc73yhgL?=
 =?us-ascii?Q?UqGwgwCa1ynm0REad+mo1S4n8V/kY6wruXjnuD3Jq9ghSGfvMHiuHn0F3b5X?=
 =?us-ascii?Q?bDYnpwF8qbDukJHSWqvFyryH0GW0NC8AaLKE3wwvG4XbeAMqg8+QMUcgFd/F?=
 =?us-ascii?Q?5Tl1iZFv8nijx66ZOqo5f8PmRI31xTl6F6Y3P+rBkhS0lvfvkeNWTt9Y//a7?=
 =?us-ascii?Q?wCZqm0EQQTSoDrcY+IBhq3Y8b4xOC8UHp8fsOeTfaVRZ+8bhIPiyQzc6Jmqf?=
 =?us-ascii?Q?gU8PLO4302ieQtqXnSFCp6XvgDOsCEjYlwLZWkmVz4ilkX+e2gw4+0+uCWaA?=
 =?us-ascii?Q?CY3bEz1444Ia8wV/piTvPXcDHUQlswC4g0enoyEmH/ICLQF/L+O+Q5SvekhX?=
 =?us-ascii?Q?hY4QX8VQbG+HsTM/CBDdlUJbZn+bCGoV0SQu+mnR0XebqxybOds3wcLLhjri?=
 =?us-ascii?Q?1HeA/5RLUpd1KZ3KbCXa0WvwHK6jg1wvGyDgrv/agMmNJP0Fez3pnRg85XIU?=
 =?us-ascii?Q?77KnAtLs+7NED7geAAhOsYSSBL0QFq+toak39wWdXOXAHoqqBgo/1glgEmQC?=
 =?us-ascii?Q?dFfsis/QzsSM99EnmVuc4EJPhDBMs+PFB3Zb8hWAjBHUnGQZJ6xfp+qcRkWB?=
 =?us-ascii?Q?uWMkKWiqycKASkyGCl04gSZv3PHHaZyKBl7T+iGyDlrOv4sUgnlBiA+3RUZW?=
 =?us-ascii?Q?5iCG2VVVWAMDczDhmZyFpAxDQleFwkiJDCbjMQlhMUgQOkaRVK1GHDz07kB9?=
 =?us-ascii?Q?3w4VorKL471/6/Y=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:53:14.9129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca02bc8-5af1-4d88-ca28-08ddc39e9061
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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

+ mlx5 maintainers

On Tue, Jul 08, 2025 at 07:49:21AM -0400, Khadem Ullah wrote:
> Some BlueField firmware versions (e.g. 24.30.1004) do not support flex item
> definitions using FIELD_MODE_FIXED with size set to 0, such as in 'next_header'.
> Attempting to use this configuration may result in the following error:
> 
>   'unsupported header length field mode (FIXED)'
> 
> This is resolved starting from firmware version 24.38.1002.

Could you please share the DPDK version you used and
a code sample with flex item configuration?

I checked internally and I see no change which would trigger
a change in behavior regarding 'unsupported header length field mode (FIXED)' error message.

> 
> The patch adds a note to the mlx5 guide explaining the firmware requirement
> for such flex item configurations.
> 
> Fixes: 16508bfd0816 ('net/mlx5: doc: add flex item specifications in mlx5 guide')
> Cc: stable@dpdk.org
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  doc/guides/nics/mlx5.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
> index c3a350d24e..1b0e3efc41 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -476,6 +476,10 @@ Limitations
>    - In flex item configuration, ``next_header.field_base`` value
>      must be byte aligned (multiple of 8).
>    - Modify field with flex item, the offset must be byte aligned (multiple of 8).
> +    .. note::
> +     Some firmware versions (e.g. 24.30.1004) do not support
> +     ``next_header`` with ``field_mode = FIELD_MODE_FIXED`` and zero size.
> +     A newer firmware (e.g. >= 24.38.1002) is required to support this configuration.
>  
>  - Match on random value:
>  
> -- 
> 2.43.0
> 

Best regards,
Dariusz Sosnowski
