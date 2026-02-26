Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B7FD8FD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF2DB402E6;
	Thu, 26 Feb 2026 17:32:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C60EC402E4
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772123527; x=1803659527;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ckAFslpoy3BFHIFWEILsxcUrr3VxgSkmtPvR1B1p6fs=;
 b=FkWYoVc4QTuLH+xRKbig/QbMDVdDpdcBccsC79I3kUY80pJl1lhqjrKZ
 XH0T3s826q8nUPr2fSXWV84EHqibXq7JMdjsKUV7EbdkoCV7/h79oPuNa
 3of4QZeejzG4zgZZVUq6TsDpgDaOwd7wcQGXYZxSh4oXQigWEm/WEgSQR
 ZGFbexl0KchOFvfdHrCxqFUZrj3a48Y8Ttx8mFPFQ23ruk2KeRTsMEeBe
 l8OicC40wWrKSrZPd2h2XhHIcEajoun+pfeIBHxdxz8bPKhbJuQaIJ/50
 yP19FM/L6LvsUAafySCwwtaFdwD40EDEgDy71KwPk+vdjosHrY6y30w3p Q==;
X-CSE-ConnectionGUID: pqyIzPP1RbCh8apgShlwqw==
X-CSE-MsgGUID: dLuJKFiVQROHec1OnXYt0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84649333"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84649333"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:32:04 -0800
X-CSE-ConnectionGUID: 8vtITOF2SwuPfCanUb2sMw==
X-CSE-MsgGUID: GBNrjkY/R9agbOOVyIBDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="214855605"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:32:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:31:59 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 08:31:59 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:31:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH/Ae8uhKb3DClOsLm/El4GrDK5ultEZ+KK4xOXqiUT06T0w30rcx9L1CDoNe8y7Qd0rtw8GyzAn4G4P3ykY3QoBeePX3VUGUthASMxbahtxuXnWFREEg5MPc/zqxxqO6xHCMnPsD1sulpMG8qRF29zWyPGYoZTzSJUupncAGqMu6BwJY+jcrW8UOZ8zXxX2jBc6U5zJFAEpb4DSpD55Dw175cAQrlLvZ0siSFD4uBhXLcZ/s3YiRhuLU8Pp1pzTtDdokd+cdOY2H0hLGCwbVoIOULmLYXJPHLfAP1v9K2xvogSfUQB/oxWLZJdWNiWE+KF+BBctKuEQy5Mdrg7mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gGZrLHPM1OenPK6aY2knXVbImJ3ooO5bnTcDTbTqmI=;
 b=gedH3PSGXnjkUbIgCysg3kF4Gicwb98hxfL9kzYgAx9zARl9QShuYPoGKjp1W31ddgqPk8fOqOmLeDrjdPZxzrpFqcAl46gRJ/SOYBU9iKkMW69lHOCz2s2jfAgPeCWRXUk2QnUugMuBKWpDI43BoreW8YsCR+BDR40WPMr7pyAciphHhCQWBk8Y2F3nxzaYUJ4nx/IUjlrVwEONbpOvaRJlT/ZnzrT0HebxFjFBOW7y7Cnfz9rD0LDze8Yghxmn549UG/Kc59tiI9pmq5m9A/KB1E9hREVf6m7nbx+dODCzDXwRzGG5Db0N8u6I2AkowX7zLaPt1zX22E+lWSeVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:31:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:31:57 +0000
Date: Thu, 26 Feb 2026 16:31:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
Subject: Re: [RFC v2 4/5] bus: factorize device selection
Message-ID: <aaB1dz2s2adE8ZCO@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226162057.207202-5-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 84564c52-1c5b-44f2-d777-08de75548ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: OlSeNCKyv3XE+MyLD7whrgrs/soWRzNzO7kkzsdZe2AkuNTImCLH3IpqhiVEiurHrubpGDh53uqUOGju04MVRRPe4htaJ5zmo5M0eB5k7nWZcgrpUGW1rVDuSlDEO8xUkcUPmDr7Yj5lp6aMNxeus/qMUdintyHOMVlOZ9BVU2N+tKLxFgIgtn5oFGoimFTOYKcxQhroMVHPB0gWVvDVj7lFr8tcfNk9T5lu89SGMxetcQrppLmN3ycdYpQuQpzXzydFLs/YowqfYZwag0D09pkLIJ0G9X3zdl9Lz9uvyovlZGbSKVClJoK8qdvWaIuGcDX/ZjeCBfB0nJ7RHKe4Xz3f1QG7AF4O6FWmTCuoZUBpmrUjYNYw4JMRGlyY/dGYqFfc0rP5RM1oUErnGilu1KpPPE9LwLZ38tz6/pK3JwrCja67JbVh47Z5nUWpR7T4R8SmesDe05K7naSKD4xHuxAzXZ62M5f67SNiTtAfHFWzHxtLXH4fdpqy/4Ul+okCEI1MqFnH3KNlXoQH95DY+hH8ogjW8LmOCjh803DolXA2qMaKe4KS472sZ9HS0/EcfQ9QGLaiyuCJP0F4wFwpvVqlrsb6DCc/4j1P9Ttwi07kAo3eFeYivM+wocxmQGxDzeu57NrkcOgrSF+ntTHIjRfS5nGQKl6GB3qR86qCy6Ii8Sq8veoAv3T8CAw9OBdGvkXky3vtaIxQOe/L1I1T2c/VpfUXUuFrPOZNJtLvNuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wt5HuzrBFmXl9NbhrxaNKFJQ0TP9hHoE9nXv6HiYrJHszGyx8Hn/f9wKnQjS?=
 =?us-ascii?Q?B5utI5W6yLSCTZnCXcCcTUZtDCFHlj+YV9/AFv4Sz6iDRcBp/ginlvFLgn99?=
 =?us-ascii?Q?YuP39gLf55X/xkoRHlczkAF4Fyjs08fjEGRu1SOnmf/BnKVwd16vbkh6vt4Q?=
 =?us-ascii?Q?41jXLtc+34bSB5uFZcjfjPczYU4VOSbnLNlDBfdnTDJ6tBUto7UNKwTd9/6a?=
 =?us-ascii?Q?hV8r//61ek2yoYKhSOTV5nCSF0x8VCGDIItUWWWo18fw/4NcIoK0u5lDROB5?=
 =?us-ascii?Q?JhSTwExuenIJ0mPjHtLJbMVfwrnwacU8yJWwz9gox/mCrBKN3xS3RUfpar0b?=
 =?us-ascii?Q?EemCb3HBdZHuIwW1+HzzjWjaYlF7Rm6CYuU3LkmQ5g3y7Pwon2W61pMJJosK?=
 =?us-ascii?Q?aKiOEZoXE+RTgG8LqvDCpVyXptKcss7wPdth9VGRhPpZCQwnfVW7/RX2ZPg3?=
 =?us-ascii?Q?8JG6f8cfY2L7Rm6X5LntHO60H/Dx4MzhR9/f3UVnhTtHBmxN9qTFZoxEu8WW?=
 =?us-ascii?Q?6Vg9dfiKxfZ45dCwflQ9aeUZi79HnwEgvadihZOpKquZR5PmVOYoZCowal88?=
 =?us-ascii?Q?YZsTK43yeFXwFRUiAGjM32CFW7Bcc1VS6QFXZZ0TKKLYwslLyGDFniQfTDAp?=
 =?us-ascii?Q?hcxvsa1zCF0vuxpF6sCtG6CPXXYgUF63VPH0UYHVU2ouxfexP/lKQngoskY0?=
 =?us-ascii?Q?C4UKCy4gMqsI6AHT4GPG6/yIQG74CZNshG2ECFQ7QHS7Vf5brGfwyHCFjD4Q?=
 =?us-ascii?Q?YdPhxTs+QCId4jWxqx2tyntZwsP1S1GD24NmXfCgItGg0pN1uV7i9K86Qh1H?=
 =?us-ascii?Q?wZLFlm8svmSlxzdGW77MMCd8e28l975EPaoJjaFIdGesxF0kzRruaTlSEh6s?=
 =?us-ascii?Q?6nGX8+ZPg6VmEFasmop2ygvc9FtSLu35BE3pBnsl+Z31xQVFfF62or9kSAzB?=
 =?us-ascii?Q?AZibsVZ2bCbrwFTrKbn0DybzwzjuwVN374m3QL1DAd2kzeaqtS/2a7+pKRNS?=
 =?us-ascii?Q?3EHCIPVZVlCeKc9ongU5FmlhlQTA+xPDG6B9Mjo6/Us5j1vDHaLVY/iNQS/d?=
 =?us-ascii?Q?1Hv6wIjYbkl+8M+uzcXJMJW8rEY2+H9TkAqoHNfF81D9wLbMrF/fJYYGQ8Rl?=
 =?us-ascii?Q?p4h0RQz1Vk4ATKbNDfvtKULvSJyX/1pmmTy6fyI7YbHoqF7kgTKXzcMmf0kQ?=
 =?us-ascii?Q?44MWjWcNg2G2YzdEHIiHbMhv3x/Tsq8NHwFFOAjO90YVjfFuc4a5YCFRAfoB?=
 =?us-ascii?Q?rZKPwwBz1zZq4S+vsyWc0+5NSbu2O5ACk8jkV5uybUQOhkgBjeZ8+JpR/oP5?=
 =?us-ascii?Q?6I+bS8gZ3a2nz54eN6yfmwiJh+edtzSBgxTVjQnIloNbcukz6v0Y6C35KzI4?=
 =?us-ascii?Q?l3ZU+PIkz7+sk7x+jwkjMn2TELcN4TLLsn/gbrBec02KTFL5oXwCOid+/pgK?=
 =?us-ascii?Q?nPeOhgYxOXRDxDivWoc7KuLk0yzWoP7r6mj/iESKsGC/fXZPna9QWNWrl7t0?=
 =?us-ascii?Q?v3mU43ll0cVbzS2ceNLfw8VIw40lUe+U8cY8ZUHWkgLR1/dEwC9nuZQ0cwHw?=
 =?us-ascii?Q?7SPFKMY6kGpvff7/HGTYAKckKilQLv+N0sbx/T1qR8yDSleyG5uFhFKeG/iy?=
 =?us-ascii?Q?keMVFOxYa5MHAzT1bBPsZHJ28reRCnltw2Az8w9lwKraG79miapoH2O9eYni?=
 =?us-ascii?Q?elmm8ZbAYY+Qtd733TfTU+DkyLhH7z1CLDa3waFqvRwXA3s7iMfXBGwi3gHe?=
 =?us-ascii?Q?C3Wl2ORau9mFTXeQVcaCqa22XrXVPHs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84564c52-1c5b-44f2-d777-08de75548ef8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:31:57.2168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKcXjjoJqYB+cM+sJViSTbWHiiLbhb0A0/5LxqzO1iPOVdtOjB0BiOp/+WeZ8PakHhzryJco6D+Phy+mToGIf2efeGFvZyuo6IzRfn8AEXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
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

On Thu, Feb 26, 2026 at 05:20:55PM +0100, David Marchand wrote:
> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/auxiliary/auxiliary_common.c | 15 +----------
>  drivers/bus/cdx/cdx.c                    | 21 +---------------
>  drivers/bus/dpaa/dpaa_bus.c              | 24 ++++++------------
>  drivers/bus/fslmc/fslmc_bus.c            | 22 ++++++----------
>  drivers/bus/pci/pci_common.c             | 15 +----------
>  drivers/bus/platform/platform.c          | 28 ++-------------------
>  drivers/bus/uacce/uacce.c                | 22 +---------------
>  drivers/bus/vmbus/vmbus_common.c         | 21 +---------------
>  drivers/dma/idxd/idxd_bus.c              | 32 +++++++++---------------
>  lib/eal/common/eal_common_bus.c          | 18 +++++++++++++
>  lib/eal/include/bus_driver.h             |  7 ++++++
>  11 files changed, 58 insertions(+), 167 deletions(-)
> 

<snip>

> diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
> index 0a2311a342..fbe20cfe35 100644
> --- a/lib/eal/common/eal_common_bus.c
> +++ b/lib/eal/common/eal_common_bus.c
> @@ -8,6 +8,7 @@
>  
>  #include <bus_driver.h>
>  #include <rte_debug.h>
> +#include <rte_devargs.h>
>  #include <rte_string_fns.h>
>  #include <rte_errno.h>
>  
> @@ -226,6 +227,23 @@ rte_bus_find_by_device_name(const char *str)
>  	return rte_bus_find(NULL, bus_can_parse, name);
>  }
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
> +bool
> +rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs)
> +{
> +	switch (bus->conf.scan_mode) {
> +	case RTE_BUS_SCAN_ALLOWLIST:
> +		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
> +			return false;
> +		break;
> +	case RTE_BUS_SCAN_UNDEFINED:
> +	case RTE_BUS_SCAN_BLOCKLIST:
> +		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
> +			return false;
> +		break;
> +	}
> +	return true;
> +}

I think this could do with more comments. Am I right in thinking that
devargs is NULL on input if the device in question is not referenced by any
devargs passed to the app? This seems a little obscure form of input
parameter, so I definitely think it needs documenting.

Is there any way the search for the device name that returns the devargs
null/non-null pointer can be similarly generalized?

>  
>  /*
>   * Get iommu class of devices on the bus.
> diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
> index 60527b75b6..1ec1ff57bb 100644
> --- a/lib/eal/include/bus_driver.h
> +++ b/lib/eal/include/bus_driver.h
> @@ -302,6 +302,13 @@ RTE_INIT_PRIO(businitfn_ ##nm, BUS) \
>  __rte_internal
>  void rte_bus_unregister(struct rte_bus *bus);
>  
> +/**
> + * Indicate if a device referenced by some devargs should be skipped during
> + * probing of a bus.
> + */
> +__rte_internal
> +bool rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> -- 
> 2.53.0
> 
