Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE9C77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 07:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CEBB40E1F;
	Thu, 26 Jun 2025 09:42:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 64B8840A84
 for <dev@dpdk.org>; Thu, 26 Jun 2025 09:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750923777; x=1782459777;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2r7tlTdR/M3OSlqoHnOYAGCqW6QqT7JIFEWxWRJqM14=;
 b=h09LDQS1q+Dp7BoLRYVlA25e8xN+qyyznV40nHvypClinpmEojBf0/M4
 88yKl5vTXR4EEEJ+ovumoMPOJfVJgNlGckvnAsMzy9eTlq6xXiu6ciKxU
 qlVmB88vGC3XAcBiziotnnhCEwz2hTuZzoXwlWBLTf6AtQxFxRSBxgje1
 g36GFT6VcaTCy3o/TMNnJVF+e56pVVNUc6M7JElJqz6cHHqnqzRh9etpU
 hyT1820RxBNAkoMrXppdF3XWZVknMvBk0xsOmZer1iSTGfPorwr7L93Bn
 Y5/ciXml5LVbWAJeNhhUKsCWEzXNcP5R65eM6LfJsU/GEN+JVSwo6pVUg g==;
X-CSE-ConnectionGUID: ARGQErU5T+yOSxnOH2nwXA==
X-CSE-MsgGUID: aIpnJzeaSd+boVPiJAXGvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53305890"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="53305890"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 00:42:56 -0700
X-CSE-ConnectionGUID: yLQDoY/fSuiN4Wg6BCKt7g==
X-CSE-MsgGUID: CgRFG/TtR1mJ0gsGAAomgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152943078"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 00:42:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 00:42:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 00:42:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 00:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgwVBZCSEIbJ6vLRf69zMVmQCf6Qf5IAaA3Y0Cv5AQjBQMwCA8aoIHGk4/nPR1TfJQv8gzeSIDVa724P6R7/LLIhuod6l2PHpG+VJsjb8lX9JdhTmyu7h8GQ2kS4Y0l0aHz6Y+T2sDV1DNAeTB4gQoVaE4YkaOhkEOPK6ttKMV92u8aZEVDxqNEs+3cTWqXZiYACaYvtvIF1put3OSdisqce1VVS3unxrQelo0RW2qXZDo2dlNxMnPc1MbyVPzFWs04jczmSmE44kRgzatENyKNfM32FauBuKrISADKAIaGKcf3tqeL0HMU8pFZAl2nomgd3FC5ZK0E+TsTixGSl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfxXFTKV743Yd13X5kJ3Jhvx0BeZwcFtsGgDSIiRhuA=;
 b=movmW+qDNjRGcVkgYsaRvOH2fV/RXGtqNQMsr5Ajvrbel2QgTSpAiTadNgCGpH6WwI4l4cWbdGFKtvC7ig1EGJ56gTUAzSttcL3wFvb9PmqVEN0KJ+95W4fdehFD9TdvUC731Y5SkMVen1SHIcSHB0R1vMPA63u06Vr71qKZEOlQclj9aVulPHmnbpBP4Cd8LyHBoBDtunJcquFk0NQ9Euy5yqyKcSL5+0tw6TKTTrJQuGsclsRYiFwigqjpz/KmFfBv+ESXurt1VjT/fr4mEGcCWkq9P4nvDzuePexZwnqN3FF93AkF7xCvGSIkWh0Vm7WJ3GC/1+qslbm6cily2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6402.namprd11.prod.outlook.com (2603:10b6:510:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 07:42:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 07:42:23 +0000
Date: Thu, 26 Jun 2025 08:42:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jasper Tran O'Leary <jtranoleary@google.com>
CC: <joshwash@google.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/gve: support gve driver on FreeBSD
Message-ID: <aFz52yBo2BUQf8pl@bricha3-mobl1.ger.corp.intel.com>
References: <20250625182751.1936925-1-jtranoleary@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250625182751.1936925-1-jtranoleary@google.com>
X-ClientProxiedBy: DUZPR01CA0325.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bf3417-82f8-43d2-b65a-08ddb484fd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FUVmjNV/BAw84y5C/x1l4gbqWWypdLOeHpjRt5HS6vtAMhwNiu/l9taVkQYv?=
 =?us-ascii?Q?5VLKCvwrwLVzCSnDazuQc5HObYSDCSRFD6d2XzVudc5WUSJD5WddQmW26VKJ?=
 =?us-ascii?Q?ZqHCrAycwHfZ0+J87Nv024UcKkGsHcueXX794KibGkuq7WhnjOs5XvBNhXDA?=
 =?us-ascii?Q?xikrSKMxOeMy6uV0wGcn9l32lBNfrulg3+xiYIqEbNeFAz9vdnNhYzNFpblT?=
 =?us-ascii?Q?twmq/+NopQQan40mkslCXdqHmfHICmzZ7kciS3qfB5N6Nkl2sfe91VeqvPAv?=
 =?us-ascii?Q?YoabETPoSnOu77cYRZ7vqpp0pqpWTh4wK3bbmswOTW9ceyOgfHiKJ+uDziMg?=
 =?us-ascii?Q?frUO2rlqEsi7wWZhKOthpjjtu0t4pfbKxCgjPLdNvUSu7XylcHYBJ9bx4oNe?=
 =?us-ascii?Q?Ips9OtGqPma2ezx1lS3Ai/OnjzRsHjymNI/59TaK4Izrsbk1kiksx+Cy3V1a?=
 =?us-ascii?Q?quLM/9o7pTvI8Bvvr8P1n5GQvryaqEfLp74C0BCLy1B6uxx+5NV5F/91oeWl?=
 =?us-ascii?Q?GEXNQBZ7PlsDahBisKyOfG1ipM+vkEVPv2UAkRz3dtSUfUmhimj4zzXCao94?=
 =?us-ascii?Q?smxHII60rufn36Y8NHhKwLX8BMXWY3AL6TkbHH+7CFiwm6z1vyqCTZtWQSHb?=
 =?us-ascii?Q?cx2tOUp261WTP4YHfNSQlbiB6oNZXsbiOZEew+JlBSx6yf6xAWlSPrrQ+rrT?=
 =?us-ascii?Q?d9l1pvyE+EhNH1qxaYb1YDfzgFMAduQG7RGc5xhS+oOkGCDD58kkgP5n7S49?=
 =?us-ascii?Q?LWvxhwzbEDIo0x/StzwYrC4abLqLPsYeL3mG2I+p9GR4BYuAAo9MDGeYxWgb?=
 =?us-ascii?Q?IvC1tk+HlfoXF/2/eiLEYyRx8TAsjBO+ka8TJJ/B1sN9mLexFppqmNbScuh/?=
 =?us-ascii?Q?0Wr9rKVBa12NggF6/bC8b1UvIJzh68x59ZKxpvvUokz1MVVpzS43POjb7tM3?=
 =?us-ascii?Q?Mu3/r2g/MhEEZNYFGTFQRzs5cVso0A6jQY59zw8++2HqWL+UlpAJ1GSyrVDc?=
 =?us-ascii?Q?t1DM9wSkliSbUzqKv+KpY3/evHn032B3DSnUnpw0wkivud8aYG3iWgfboTsX?=
 =?us-ascii?Q?8UB9ANOc9gzfba2fD1MOs5PMbuz+CRj6idF9nKt9e+GM6vCeSJP8amCEAkQm?=
 =?us-ascii?Q?5DmTaaVkvoOA2uoB+1GWoDm57CgoicYDfa+7fhX9FepPYTGvNlZmVartMO/B?=
 =?us-ascii?Q?4Rmbs8r1hEhzoeO9ePe++ftTmu54vh/PNIGhav6+nmfTS2Rg9qPV4gCdCMG1?=
 =?us-ascii?Q?2Bg8ntNp8BrZgspxyuVIsQkUdg5QVMWQkeLoo1UPJ4/dtnulfUzZ3+WF48Ga?=
 =?us-ascii?Q?EX6PXcjZbEkXsaTQGJ5/0deyJGo4UwixB3sRy88DIJy0ab2jqE/1WE9akHQD?=
 =?us-ascii?Q?NigdE+WdCwLcNuwCZ56Alo+pZf9ykhHXiOQOLZ76EsYiFrzcErAEudvzoLCs?=
 =?us-ascii?Q?BvyY+HffUz4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLkFUnMCnliy3ZR5be8svHA7ecLjcwsJ097aPSKfEJyxy7cZF7LpK48xgHBQ?=
 =?us-ascii?Q?6DOOY+KiHkWBykJgAssOtLfEZX8qs8WWuvgrxt4kIdUNTafj6WakOHrH/9XR?=
 =?us-ascii?Q?ieuZ9OJGDPtU9tCFEnqZEQehREzJ39ZfFNRZ7LZqgbzHXN8lHWhkfPs+GJS5?=
 =?us-ascii?Q?VsZxk7vKK2JqY5/YvZqPpf4mZAE9XkwyuD/kZtSVQVuIgpupiwqsIQ1IoVXy?=
 =?us-ascii?Q?kOmbAKb5PMs7Fp/h1KKRKsqyHxS9VZhWr9BQK1HKJkSPhtmtmWde8yy1lSXD?=
 =?us-ascii?Q?p7fkRy+EvcZNOXAiXz4N+e9a+fZIAQ1vNbRDY7S3x8WJ+Bkv2mq3yEajKBGy?=
 =?us-ascii?Q?NuB80U488CDFLbrAv2QkKSbrQ8Byq3zCaueZ9dHPPRXXy9DvA3Rp69eEyY6C?=
 =?us-ascii?Q?LQz24tJUEAQj30lyeK/9IB+bEW6b1KvmKpGUuENNvvOrxrbDPkOwes1Yq405?=
 =?us-ascii?Q?OPm1G3IY8ja2xwUiTEnoCiMCe97QqdtDYnQq2RZEh3310Tn4twqbImYr9F/e?=
 =?us-ascii?Q?kFdtJDxXjew7+FyRm1VwXQ802extX88w2RNe0jfh3J/O4EMRRDaoA5romNX3?=
 =?us-ascii?Q?9lopDIdvLm3M5s5oawK7r3lyQkkvLzm4WtEuxU3DZMRnD2WabT6qiRlUiw/k?=
 =?us-ascii?Q?9oSNIX6o1r3Mtn0st7PitnsbM1S8yxJDGFiNpLne7qQH0BpnWz9yMR0EdctO?=
 =?us-ascii?Q?Uau2klcAb4XTu9YWBYKXKeL4ozlGUrogwmm3GX3coBSSGrGXvRfPcl4h+Ben?=
 =?us-ascii?Q?APZzId8PC7w/TZzKathdLhhslqBjoRNlrKeh92sKVigoRxYlO9xo7ILX2jGZ?=
 =?us-ascii?Q?RTKcsLbQJ3W9TaWP7mLKNtSJgMLyfkqLhcScYfGFQiJ3x6MAGcEO6Hi6NhBz?=
 =?us-ascii?Q?HUKLCHaRDiPMcVek/06MDS3cYQslTNXqqXCUvqpEs2N1vDUWEYZydiy/u8UI?=
 =?us-ascii?Q?/sJm9hEtJGNq3KIiyuTvaqrd/LbxGJb4S9cHyj7avOeylHYphlZIHKg6oKQe?=
 =?us-ascii?Q?azlnnaBZL/tUTmSF3QEJEGn1kMOUlT+fG2Ur7RnnHs5ueQ8BXKS6X7BViInE?=
 =?us-ascii?Q?XMx4g/lVGg3+z+n9no7mQxHQBMbb0Uiqmj61WTfLDMEOv451ajCLnOvKxJBR?=
 =?us-ascii?Q?TpITql6mtS8mGnOg5651p5sB/VJ+e73mAwiKn3Q4WW72eJUEE0/8/xR2tR/m?=
 =?us-ascii?Q?LUH6y70L3hgmdjSayRRFkrIH/c6NxXwDqFfe0O3gtUQefw6LZOlTPDfUZSBF?=
 =?us-ascii?Q?/pHdZfc8egNP5HP4pZH7J5e46Pb/csH6He3ia0hvkoe4fAB3AOX8rjjeA67D?=
 =?us-ascii?Q?mDsK+J4/5N+rQhlpewqJYtlDfKL4r3N9tOqIiIdR4zA/+qagnvOODcDjhJau?=
 =?us-ascii?Q?5X5OpF9KciDDYtoQmVcnpwsjIUcVmhsGgdJIutdGO2jC04S+4fE9b9WstO+u?=
 =?us-ascii?Q?+8nA3gaSIUr0eqPM+9WP1X4zOJaPmmi1+03nT1ho834AJ/QNWCHiPkCteF/m?=
 =?us-ascii?Q?KAXFmSsz4NUSSU6n44byKAF+Ov0JjLMov8PNJsD7ZsA4CyGrzs9IaAwV2oUn?=
 =?us-ascii?Q?xH6IB8B5RFaZc3xcr0ENMV4es8irw0AlM+5HAHv9n+YD5F3g6cvQBPD2Ys93?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bf3417-82f8-43d2-b65a-08ddb484fd40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:42:23.6492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aja0N2POsHT9IEh9/BHiwUhyjwQGatpoeHEwbBXtkMEm2eB2+aoUb17bRUpIGzSdpZVlzmktmtD1tPkqTwsh3HvS8K1s2QF5XgKrv1l7q3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6402
X-OriginatorOrg: intel.com
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

On Wed, Jun 25, 2025 at 06:27:51PM +0000, Jasper Tran O'Leary wrote:
> This commit adds small changes so that the gve driver can build when
> FreeBSD is the host operating system.
> 
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> ---
>  .mailmap                         | 1 +
>  drivers/net/gve/base/gve_osdep.h | 2 +-
>  drivers/net/gve/gve_ethdev.c     | 2 +-
>  drivers/net/gve/meson.build      | 4 ++--
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
Two very minor comments inline below.

/Bruce

> diff --git a/.mailmap b/.mailmap
> index 8483d96ec5..4ce891b223 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -650,6 +650,7 @@ Jaroslaw Gawin <jaroslawx.gawin@intel.com>
>  Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
>  Jason He <jason.he@broadcom.com>
>  Jason Wang <jasowang@redhat.com>
> +Jasper Tran O'Leary <jtranoleary@google.com>
>  Jasvinder Singh <jasvinder.singh@intel.com>
>  Jay Ding <jay.ding@broadcom.com>
>  Jay Jayatheerthan <jay.jayatheerthan@intel.com>
> diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
> index 5eb33930cd..365d44fdba 100644
> --- a/drivers/net/gve/base/gve_osdep.h
> +++ b/drivers/net/gve/base/gve_osdep.h
> @@ -25,7 +25,7 @@
> 
>  #include "../gve_logs.h"
> 
> -#ifdef RTE_EXEC_ENV_LINUX
> +#if defined(RTE_EXEC_ENV_LINUX) || defined(RTE_EXEC_ENV_FREEBSD)
>  #include <sys/utsname.h>
>  #endif
> 

Is this ifdef necessary if you only build on linux and freebsd (as per
meson.build below)?

> diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
> index e471a34e61..bdb7f1d075 100644
> --- a/drivers/net/gve/gve_ethdev.c
> +++ b/drivers/net/gve/gve_ethdev.c
> @@ -1366,5 +1366,5 @@ static struct rte_pci_driver rte_gve_pmd = {
> 
>  RTE_PMD_REGISTER_PCI(net_gve, rte_gve_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_gve, pci_id_gve_map);
> -RTE_PMD_REGISTER_KMOD_DEP(net_gve, "* igb_uio | vfio-pci");
> +RTE_PMD_REGISTER_KMOD_DEP(net_gve, "* igb_uio | vfio-pci | nic_uio");
>  RTE_LOG_REGISTER_SUFFIX(gve_logtype_driver, driver, NOTICE);
> diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
> index ed5ef0a1fc..14a17db4bf 100644
> --- a/drivers/net/gve/meson.build
> +++ b/drivers/net/gve/meson.build
> @@ -1,9 +1,9 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(C) 2022 Intel Corporation
> 
> -if not is_linux
> +if not is_linux and not is_freebsd
>      build = false
> -    reason = 'only supported on Linux'
> +    reason = 'only supported on Linux and FreeBSD'
>      subdir_done()
>  endif
> 

Minor nit: generally DPDK drivers tend to report just "not supported on
Windows" rather than support for BSD and Linux.

> --
> 2.49.0
> 
