Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1250DF3D334
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:06:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5509B402CC;
	Thu,  5 Mar 2026 18:06:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id E528D4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772730386; x=1804266386;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=14B6D5We5i1ZNyJj5Z2aPfw83oNinoHahYT0/OtID0I=;
 b=XsRb53xhQdI2hBR4Np1ndvGR1e5ovFyHZT7YymTVGVMaTSHUUrIaBUlN
 veObCn6U74qoWZro3TuixoghNDRW6YF3UzqoFV7VNmkBJs7Iywco9n6fm
 xfN28TX6qLJ/mt0EgvLRLUFd1jSNKlxGQRy8Js2UwUqo+MwuKWragBd58
 A5h31JGoJT9XsLdWUSelJElI2enjNj8BM1R0iNv9jMK39ZbNzy1jw1CD8
 KFx2LrSWC6H5tDm3GsylHvdBorsJrEEVF/IbKNaIdgJYuILkfwrPVjxfv
 1ehZUkZA2OYPNwQV5pGSSWpJd3Mdw3MLXUBr6REWq7c0roT95exPFKF51 Q==;
X-CSE-ConnectionGUID: jtt6Yui9SxWcE7Q7SdzY8w==
X-CSE-MsgGUID: InCYZs0TS7W2VrgjUacNXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84538992"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="84538992"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 09:06:25 -0800
X-CSE-ConnectionGUID: 6V8BIlUSR92MY8G/vPAvYQ==
X-CSE-MsgGUID: 0z7CfklIS6SdEpAADd1pIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="241763904"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 09:06:23 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 09:06:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 09:06:21 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 09:06:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBfkLn5EIgLtCuYUJ5oxAIXCTxWqebo826hPd4Ir/Kab8V1CE8QilRtqGfMt6Gmal/EhExQpHrjH4tr4OmjPJkhPcVG11NmYAbhr1CH5RICEjc29A5hGmVnpH2/SuWYwxZy5YZHKXzyaKRhrguLF8wOQErvhMWzQhNIfqlIQBsuXisRUuqLycQGLgyP3260+ZIYypjuGKuPU1yOTM1navCNASqbrxvF0y/hnB4oPZ8UhYQiN7pSxZgPq/iu+CQ10D56XvtYP+iNXZ71/C0dFe17d4zxW4cm/c1iLijKPDFxZAugEjBcH8XKQDMBxLwkdhUtSJPe/8U57sPwKsnTo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+4ClD4p9UXVaGlyVV/6gTR7rL4O4Rp/gc0VEGCagkY=;
 b=TOi36bcsAGQ1bCIrHJeZ8NVw7okjvMDKlKRONQf3TgRlyoni8M5TANv0X9HuK5m+uCgyirEwr3hOwb/PuCHIAoWRmavqdaIb7/wknzLqU7qkAYOJn/Ak89Qw+9yBRMVUsphH8V3utXCEr0ZcrNIhQpJ+b3qcSwPKqLHIEX6+q4owXJBPLn4IjRIHLg95cRoVT5LkGpYPOjil0B/4f9/wEfJYTjXhB4Cx4Kr5R9OHJYDyGMwO6rgjUy0YeF6mx2ZafxiJhiIAZzg0ZwHw1qQfxjHU+7RpjAYYdxwdytXUoxLARIkmUbMHHjORr/qQifC/i4zwPEWTRNgONV98G9jwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 17:06:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 17:06:17 +0000
Date: Thu, 5 Mar 2026 17:06:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
Subject: Re: [RFC v3 5/7] bus: factorize devargs lookup
Message-ID: <aam4A98jJsuhgTYG@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305164550.2067453-6-david.marchand@redhat.com>
X-ClientProxiedBy: DU2P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF632600ADB:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f347e4-54e5-4659-f7f5-08de7ad983f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: gHu4Jjh8mOCa9CMJUOWBE/BmKE+000QR27z3fXvI+5UqkoCm1rKZlqgzBDnQyTPRtlxczPTIM79xhAuSrko5G8EzO8clEb027dUpbUtTEKtg8fXE+KxJloJ0//LRCPkyQlHJ4IMhZA9sCXghgAMXOJHAk5DLlYHe8uZw6o8ZnPw650QSl+h+hIyo2pddOevJxVh6qvGhJ/olM/5JI8/MjhQLbpw94qk9+XMHmcvpgZYRj+bL42e02G3ora7qy/x6oCLjnJeUPsBmUHksvpi6rvyfVapGuRnUvm0cB+sXml1ybGvEQI6XP3Bn2MLcxITI3T+lkMCz3tYMQttsCadio9L2HJd+BSJAIdHf+Y3INbQEXryXL0xJQ67VSQ+4TdABa9obMBt8j9jvGTEK0I2KF9OAFEShOAt738QMltvQ+iuK77V2T2ynzuTCS3lL4Vwd9+90wYS4Tfm6zKCt30j26oH9OBePKk2ys++Ibbb4t4yoHgg/PDyu8CAesbWpoUl7johlUfRpb7wUdXVJDbD+8t9YpVnduS+puYO12sRa438pesJh1fckaOr2ADEDGcYtMPNy5oIfXKLa7T+D6IoITEFxVEnMLEXgI14ATTqJrC7SzVy4f43BUAsWW3EF0dwkkasNj3rQne0jqbsHXtR9/dVleQ1mGwuVkpbZ9sOQMdYcX3V4Hl1BGr+wuy1fg7V12YIWmsQ16b5coowqlJWVrWvQx1uRUUA5An7J5OmvwCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPyRgVFt51qIS/n8lDI9VzAG/sKUdRtrW8hTzNl48gpt356dLwC8GJqBWQ8T?=
 =?us-ascii?Q?KUUkjdJkUE0DCgVMv69aWsV8EvTpBXQXiqKQ8Zna4+IMKWpIcwSqSVhW7vZI?=
 =?us-ascii?Q?86EzxoqjTf821rF1O1aH2mQrAB0VKQBohYP2U1XFxcpUqKZXc6SpWUOhTeFe?=
 =?us-ascii?Q?yrnZOyD7SCPykenjAkzqo1XmI5ZQ2qjf9T6eUVTCDndDZ61k3CE1l2+k+vBN?=
 =?us-ascii?Q?gOv+hQ8eGQi8X+lRMbyV6SuZySQ8MD/k8TP1WhgNfP8PWLgOJLDJp3GS8DK4?=
 =?us-ascii?Q?86rn9vebs0qyyz2G4DypSAPjQ1k8sYlvPWdHx+WnQXBsI2tE9FgMrr6Lv7iT?=
 =?us-ascii?Q?JEKVRAz+G0E+BMLbLOtSEOxveoc1yGJzpAqdOseTnL6AJaK9RZq40hM9WszT?=
 =?us-ascii?Q?vOlMgYqwAh/ypzhLTm/5cbvDRq/iXUU4VEMl/YhsnnEyAWQj5L8isjn0icoG?=
 =?us-ascii?Q?H/I7OIOhs7i5c7OJlVq7sn6T4DNNft88HyCT04C0t5Fzwej1wG+Jh8uQ/rJ5?=
 =?us-ascii?Q?YBLvR6CCOuJyK1XTXUP2GcJdyXfx5Ak3MG4xIPnIdR5quG7HwWypilT8Hnr+?=
 =?us-ascii?Q?B0sDN3+QDCppLtaqf/aUMCYnH447zvPOFnB/MfmOXexQeCsNHrb6Qz2IStpR?=
 =?us-ascii?Q?Zj9xCeqguLNXRvx0vTPn0yTzXV01OodNlNIAjQ0kAAPCc5k20NH8pewWwDW8?=
 =?us-ascii?Q?ppaQmY89IoccEz7xdrNLJSVPsRrkgscJMzDs3BmNiqdq6YpOceJ1uiao2tpg?=
 =?us-ascii?Q?dWx8ZZsLS/a269/AlixJWxgaAaEzvnviH4WS1GNu6njeqs0kwR27OCl8wPOX?=
 =?us-ascii?Q?Dh0D50QWr6A7BeooDWS//aNe5c0l2kjDezuEoIUL7icVBkdeelVNgwrUkEh3?=
 =?us-ascii?Q?uG5qADlG/dQyidy3/4LA6yOgRShrbBfHV0JzfJmYF4Ku29f5koXtdoyw8YZM?=
 =?us-ascii?Q?qQ2bp0uuRFpaKjUbVPTr3Fnj7yxK0/59eklwXl2ut4YQiAL1A2BgvJ4poW7A?=
 =?us-ascii?Q?dIYwYz0Wphz+j20FXmVsqOIy98HMzXyUfBnwbw10A56ocfUvfw8pCjNZe7dp?=
 =?us-ascii?Q?rEQCiAzwRmKNmk2E6jdsxZf/x191J9JIdIu6FudL7Oe+q83K4KqHQDH2uTOg?=
 =?us-ascii?Q?kRpBW1XiBHIBKiCbuJyyVP9ngSE5X/gNdzgOhuN6B4LuOacnUSU2ddJrbqrG?=
 =?us-ascii?Q?6pLNq4YyAIG7f1j4fB+vGKz9yFz72byx0GzqbVDpAm6pg3zLbY6zztN2fkPV?=
 =?us-ascii?Q?oiNbM6AzFc6gOEEh5JNI0fAMXN40qOt6UqT+n8MgNEh4Xldvw9nrkIynqmC2?=
 =?us-ascii?Q?t2u3v70fXMMIgxhrTOCMMm2K21ir/krtG8ydjX5D8gdSZBfRi6aXSthfrle7?=
 =?us-ascii?Q?NUi3qXflONSmL6+nsrDHz/eyRXqbaeSXg3CcuvuHnibB74YHZa/PX/bP01lK?=
 =?us-ascii?Q?IsAKKj08qRRZcDWlj9/MNQUyRgY0mZcvUhOAkEQynWNv60uEdcZwCSIcqS/R?=
 =?us-ascii?Q?/qP4A63kfhEaMwPgV95BbX6w8QEDYnUjHft4rSLekZIEfEqECjCtVRAVoqx/?=
 =?us-ascii?Q?qFqbPblTnTe/cp/4wGijsOMohHOnR3IZ3sF6hV4kXNuJZZyxINJP1yuX1Zdp?=
 =?us-ascii?Q?jOJnGI2RSfU2ZP+1wLrHn2i4puQje2WYZPmSxSwGN5RHFYB/7lfHjduJPK0w?=
 =?us-ascii?Q?3KSRvORDgdwldV4hH62YDphWiqT0dkQlkuXxToYLl98k6JWsrFmO2595eGFw?=
 =?us-ascii?Q?RMQFDWudX5x9vphNsXZZHwRgeJsvnXE=3D?=
X-Exchange-RoutingPolicyChecked: MCGBPMx2+1B0rYd1SypR/Cm7ZOW1kG1r0bB0dpEXWNKsa4a61rbMHI6flWWKFUQP/lBLeD5hcXiUSXoDk3GPOzSPuzI2T2sLS0au+gDN5jgWh+zLk+0yceZ8HjeK/5MhcTNDzmQn6sE54VHEUuzHIptuT6Wb7WB1SkaFPQmcsIj2ul3Bcqbez/03d+oS91BSBLg0339TFcSo2e6yB3SOHnZhSOYzaaLoC519DMG8+fxfK7hXzopNZbjC49LJ+lq3tMvXSiOAkYYiATevVTqMCp6G7lYnAcnxVJC33LpTG7OCS9wWGzjGSyVB04caoUvJef5zF55d6VYSWPSuPIfevg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f347e4-54e5-4659-f7f5-08de7ad983f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:06:17.6797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYRQ3zcVfdWOOWm2uM2eTSdNpJj1uDXyU0F87CiDgMFqyJx/Sw5sCf9iudadJLjUnuNXPH0is/QNhfHE/PwDLW8CevNHxlGTMALb/eLA4Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
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

On Thu, Mar 05, 2026 at 05:45:47PM +0100, David Marchand wrote:
> Each bus reimplements some similar devargs lookup code.
> 
> The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> device names. We can't use the .parse existing handler from outside the
> bus code itself, as the size of the bus specific device location address
> is unknown.
> Introduce a bus specific helper to compare two device names and
> hide this ugly detail.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Looks generally good. Couple of minor naming suggestions inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/bus/auxiliary/auxiliary_common.c | 16 ++-------
>  drivers/bus/cdx/cdx.c                    | 14 +-------
>  drivers/bus/dpaa/dpaa_bus.c              | 41 +++++++++++++-----------
>  drivers/bus/fslmc/fslmc_bus.c            | 34 ++++++++++----------
>  drivers/bus/pci/pci_common.c             | 38 +++++++++++-----------
>  drivers/bus/platform/platform.c          | 17 ++--------
>  drivers/bus/uacce/uacce.c                | 19 ++---------
>  drivers/bus/vmbus/linux/vmbus_bus.c      |  2 +-
>  drivers/bus/vmbus/private.h              |  3 --
>  drivers/bus/vmbus/vmbus_common.c         | 30 ++++++++---------
>  drivers/dma/idxd/idxd_bus.c              | 14 ++------
>  lib/eal/common/eal_common_bus.c          | 20 ++++++++++++
>  lib/eal/include/bus_driver.h             | 31 ++++++++++++++++++
>  13 files changed, 132 insertions(+), 147 deletions(-)
> 

<snip>

> diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
> index 0a2311a342..863c7418bb 100644
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
> @@ -205,6 +206,25 @@ rte_bus_find_by_name(const char *busname)
>  	return rte_bus_find(NULL, cmp_bus_name, (const void *)busname);
>  }
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_find_devargs)
> +struct rte_devargs *
> +rte_bus_find_devargs(const struct rte_bus *bus, const char *name)
> +{
> +	rte_bus_devname_compare_t cmp = bus->devname_compare;
> +	struct rte_devargs *devargs;
> +
> +	if (cmp == NULL)
> +		cmp = strcmp;
> +
> +	RTE_EAL_DEVARGS_FOREACH(rte_bus_name(bus), devargs) {
> +		if (cmp(name, devargs->name) != 0)
> +			continue;
> +		return devargs;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int
>  bus_can_parse(const struct rte_bus *bus, const void *_name)
>  {
> diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
> index 60527b75b6..430906772d 100644
> --- a/lib/eal/include/bus_driver.h
> +++ b/lib/eal/include/bus_driver.h
> @@ -118,6 +118,21 @@ typedef int (*rte_bus_unplug_t)(struct rte_device *dev);
>   */
>  typedef int (*rte_bus_parse_t)(const char *name, void *addr);
>  
> +/**
> + * Bus specific device name comparison function.
> + * Bus can normalize the names of devices using an internal representation.
> + * This helper makes it possible to check whether two names refer to the same device.
> + *
> + * @param[in] name1
> + *	device information location address,
> + * @param[in] name2
> + *	device information location address,
> + *
> + * @return
> + *      true or false
> + */
> +typedef int (*rte_bus_devname_compare_t)(const char *name1, const char *name2);
> +

This is a good addition.

>  /**
>   * Parse bus part of the device arguments.
>   *
> @@ -258,6 +273,7 @@ struct rte_bus {
>  	rte_bus_plug_t plug;         /**< Probe single device for drivers */
>  	rte_bus_unplug_t unplug;     /**< Remove single device from driver */
>  	rte_bus_parse_t parse;       /**< Parse a device name */
> +	rte_bus_devname_compare_t devname_compare; /**< Compare two device names */
>  	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
>  	rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
>  	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
> @@ -281,6 +297,21 @@ struct rte_bus {
>  __rte_internal
>  void rte_bus_register(struct rte_bus *bus);
>  
> +/**
> + * Find the devargs associated to a device.
> + *
> + * @param bus
> + *   A pointer to a rte_bus structure describing the bus
> + *   to be unregistered.
> + * @param dev_name
> + *   A device name.
> + *
> + * @return
> + *   Pointer to the devargs, or NULL if none found.
> + */
> +__rte_internal
> +struct rte_devargs *rte_bus_find_devargs(const struct rte_bus *bus, const char *name);
> +

The doxygen says the parameter is dev_name, while the prototype only uses
name. I'd prefer this to be "dev_name". [I nearly one if the function
itself should have an extra "_" and be "find_dev_args", as it's finding
the args for a particular device, rather than finding the "devargs" for the
bus itself.]

>  /**
>   * Helper for Bus registration.
>   * The constructor has higher priority than PMD constructors.
> -- 
> 2.53.0
> 
