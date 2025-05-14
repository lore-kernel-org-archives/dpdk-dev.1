Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC51C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 16:57:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F374402DC;
	Wed, 14 May 2025 18:57:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id B858B406BA
 for <dev@dpdk.org>; Wed, 14 May 2025 18:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747241846; x=1778777846;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MTx1UKgqAmXgDUKggrJwiIXbTwtehCxjTWJM2d9gfPs=;
 b=BWThb7earBaODoxQOHCKBEJHRPrwBtoSirxaBmgXQOis4dJXh1/ytjq9
 jZvvWLdLR8Ms97W1Ia834eXwgCnBAyIydpqs4vUN3MtT6S0F+AP7BFf5M
 Tze1qtYxuxJti32SDJD6qc5iVYUmWPQuKAsrfOnMTVEdnqynRAfg56IHk
 QYIDcKGtSQNv81nbFDU/n+wpHWvJeU9o4jeo9qatXpbVjf7sW157O6q1J
 RjivdRbRyqY1vFjnRLBlqoQ7+W5IQkKOBbj52UL93k8DSun0vhBtGEt30
 tGxdLwh1BkUh3lRIPupKiBNyEiOjT7h8S6Y5tgf+VrGeEga9oYkA7rnTf w==;
X-CSE-ConnectionGUID: xApggg1rS02n8J3seF/Fjg==
X-CSE-MsgGUID: 1HPzXHUUQeibF5NcuoCaWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48403039"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="48403039"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:57:25 -0700
X-CSE-ConnectionGUID: x4brjVhpRkuqPV2I1xiYCA==
X-CSE-MsgGUID: Fn5UuajhTu69OEMFo0GW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="137974342"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:57:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 09:57:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 09:57:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 09:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhKNYwe2OOcs0bX6rEN5/GDnbpwrcTZ6HannucoF2EIVbnd+ZKvHn+NvBRe/T8cFzkw/gzs8Olua17GwDmqh2vczl2H+pjSwj/aJkSToaUSjtkGewr8rEE/rY5ge9jEHQsHgQAwIobfAzLTwo33ZCXTsLzP3K3eKuQeCZ9C/GRXdK70VIa9DsiKcSvwNZXzjCyV0y2D/4PJBDHH5xf1aeitX1FFvb8HlGtDeUXfeogzF87fBshrYSRCt2kqBpnLnUArlIntYcHdTD/1F70+EeA0j5VKXfAwD4aLBPzwQ7gcM+wr6qU1629fH3SJl1/5EGs2Q8BzksZ2xvYp7jWd1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cChwJ0JZ4ax1ocP/UB2ve1hSjVCP1FQsPIAi7dmPqUw=;
 b=BmE+zienIqufyMAeE70mxrAgfPLGX3HWDWj84wix4PYd0PruEKm+WuGwTfBis0DynrcxIjhKx7ST8ChKmeYL9DfwakJgXO1MSTs+gprWR6Sy+VsrOctUpbdhGSEgEYDtqGgY8n5UcXtJGcrCEZgTreWnDrh6qj5JWruH9YP29iv3KTcGLHIAc+T50QwQtWY7QPp9STF0471300amAClAzetdYd83oVvSYc/OC1dEvg0rhzlugwXeBhFRB9+MXfygiW1+0Ve2/9QCHXPa3XN/Wx5oG7B7PGKs8jCB8IXVd7tLXL0tf4P/VsCZltcfXENc9UQKIYeR9eO8PbLylnBNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DS0PR11MB7406.namprd11.prod.outlook.com (2603:10b6:8:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 16:57:04 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:57:04 +0000
Date: Wed, 14 May 2025 17:56:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 05/13] net/ice: use the common Rx queue structure
Message-ID: <aCTLW9HoAXOPd6Sg@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <aed76e2a2c5c8be3ef968291db2720fc07eba633.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aed76e2a2c5c8be3ef968291db2720fc07eba633.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0231.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::12) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DS0PR11MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: e850f587-7c75-430d-b0d3-08dd93085a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bTIrDhdhPvssdijXcHdZa5sCeC/W8biDh0V4Hv1ROYDV6mO1JYRfgDN7E13m?=
 =?us-ascii?Q?Mb8nMm2/lnXdd0NaVrrGUJufo+d04Ebb2P/DmLKXPLNtce6DNMC5i85Cs79r?=
 =?us-ascii?Q?9g5VkoxnX7RiSgMRX3mZauuyiw+G4NfDnEvidLJz/GQqTWOzqek7HZi8mGZP?=
 =?us-ascii?Q?udxKBC+OBI/sb7csb955zRf8xqgIIyjyyj2tW2PyNuGBlH2G4vJ51R8/oD1P?=
 =?us-ascii?Q?JtoZONnQMV2MgXF5Tewu07V23HycIfFA/v1SylALsCL6D8hmCNGz4YB39rj5?=
 =?us-ascii?Q?Xm55vi76CtTbvojN3z7qBoA32PhBwmvYKBriqH+Oy35dbSjbKIiGzRt3pMK1?=
 =?us-ascii?Q?aJQR+LDoiLTbVz+2QZm5u0slNPoK9cQ/E+swSDLrxTVRA4JqujLAsm6peXkH?=
 =?us-ascii?Q?B/RjtLc7V0gVlKDNiSBDrWOmOevveLJK+l6z9woKzSt/1zjlzuGW9rODEbHv?=
 =?us-ascii?Q?FLrkZeaRsfSnuMjFHwBagj0hhFI6g0aRqLllaHzC3zkdT/Z7Wm6IxfP7KoFG?=
 =?us-ascii?Q?ufAAX3YHRFq2EpKQo29tm6xtR5+GhQMOhdUyavuE++5IgIwf7BT+gecH6+nY?=
 =?us-ascii?Q?pEeLCTkmCg2fZM4+MDG74VAGlHcsx82KdDaZ8WgGLSRcSMLwUX3o2Rk8Fpr6?=
 =?us-ascii?Q?k5vlvaZrxZ3NPzMDy2XJR27O6nCbLVCwUKXKFJfBExGFiPPxongmTEnTInSe?=
 =?us-ascii?Q?qLEKBf8R1NTqKXQAli7kdm15WZQhutDPFjxr5khESBa6ZvUA80Kr/sg9+e0f?=
 =?us-ascii?Q?lncm63tQvbLXHBqfn5tzjWz51Oog6or2CW8ZEox4aPMqoGJWlZuxcVONyGLq?=
 =?us-ascii?Q?nFWjn0PQF2gnyj85kbZY1H6twEM1gGQOgPKxGZd2E1dl3FizUhgDs/0tYoR3?=
 =?us-ascii?Q?l8G1qLWV0pQuAy9hywq0hWnLrEWP8w28QxOF49lwL3XXdLRUErbQC8pr/7EC?=
 =?us-ascii?Q?a2kDVWf82sfknFzU9fzeH2eNtBcLkESvIVMKujWCB/Fnun3iRV0wEx2d0LjB?=
 =?us-ascii?Q?P9+erEzNCgWxsdkfX3lJ/1tvOLBZG9bPs4c37ysug9RUHCdw8bnwHiznxG8R?=
 =?us-ascii?Q?gOnxjnopgU7wcy1DUnkIGkgKdDL00sfDxaZJOst3IZj1pPPS+VHVqoBtiTN/?=
 =?us-ascii?Q?7bkLx3DaXn2FmvOuAuTynnofgVOgb5IYUJ53GMPCQh/VQoEu9h1UqlN1vp9b?=
 =?us-ascii?Q?llQdQAUTsjhJ6rKuGFffI96DKuq9SLGz3nlNPhBxiLNRcMfaotBKO+ZD28CF?=
 =?us-ascii?Q?zakCWUSiI87GTi2msjHeyzH7TgA+PBpwBGswbvE31yGIH4yNno/+lBclVi2O?=
 =?us-ascii?Q?3L/pPLrCfHwtaNSwKceiFzotfs7fxQw6VoNZf0urFWHTAhxPFIhbW420mZao?=
 =?us-ascii?Q?RYMIlcoxCVdYfFKwSaFD1096rE8896zDQPWD5dzcCBMi0dPHj088aTmPKPGm?=
 =?us-ascii?Q?G/jNOyKUzSM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htIdJicUTfiLWyW0faC03KB1H3x4NghvEp91vdnARhnIZ6uEhi5hW+3iXdj+?=
 =?us-ascii?Q?rsoLs5tm/yZF0Js5CPyg0Vw8ewAfMMblqbiN3urOfgeGXe9nx5LakOeiXhBV?=
 =?us-ascii?Q?CoMPzWp4FDwa8p3tEsCXOTmJPHV6dEUBN/ixHcCPsrgfZhRQx43qdX//7gx2?=
 =?us-ascii?Q?Nipio9ZeZUjZGCEsbUslQVxt9jDGB5dZHJGq0DheOOYWa2+WuHzocduL6MAA?=
 =?us-ascii?Q?ahPCxKlZV7DdzJv3Qmh1tCUJO08ixo3bUhWRW2ueHNmqtgP3CFIQ35TkQ9Sy?=
 =?us-ascii?Q?JEz5V1NwMQKcI/lKOaaZwYWD0wUkHGxzMibkMvqz0087vVaLSQMZTZONVH7g?=
 =?us-ascii?Q?rMytHWdhiXTemctKKFO/e8tK2gNTLtEORlOHvTUEm33RmH5VP2GfkbDcznfO?=
 =?us-ascii?Q?IUvmb4HvxdIN2QJhFB0ETIyBKdZDBt5mwfOjKU4ncIaP9fES5kbNQ6u5IOUM?=
 =?us-ascii?Q?7dQSF1rlZCvdJ8bXJpnV75s+XxdUybfYYIKkIvo9J/OpBHM6PigHDZioUl3G?=
 =?us-ascii?Q?FuUXHtfPNd1N42t80ZKGjeb0h1j08OeD2NSDqVB24uaMEObTuYgVxxpWC1gH?=
 =?us-ascii?Q?hjJnUpCfja7HIl3+eOGqm9I4gEfWGzQcgLgC7ZTI8neBrQwT5d9HlZrVbTSp?=
 =?us-ascii?Q?DeUVKs1Zfuib7Sy22uDzRi6oe3XDdPkZ8H9+uBO2Zv5QG+w8Yid4v2lpgcnW?=
 =?us-ascii?Q?YRxPdQAYty0unKADOutUAPUoqfzepVAyKUAM1UYvG3pjuTfPsPyMoopiikfj?=
 =?us-ascii?Q?TNqmWIe/JfmQKQETflNWwW/49rfn0NpgkgX9p/Z8E58/Bd2TAzXEw26LqhkJ?=
 =?us-ascii?Q?3sQZLzzOQIhjEtwZ7pRAhV7VL6DSP3LsruYXR2ItMzNMG0/VlGBGGJrj2D/u?=
 =?us-ascii?Q?3eool3yiB/hiFEynPi6UHwCqcItgk2lWJvwmbkAMHdMKBR4bLePEqQiBDLQ7?=
 =?us-ascii?Q?8lcVMLOX9DVwqXhi2HdVp/tUqKHoOde5l/oUpK0+SlQzTFlZpiPZlIOnVdoo?=
 =?us-ascii?Q?6oXauupoj5QHG+HopYnqfS9FbPPszfF9oy/bP/vq+sVBqV3znI5VhcjjRPd9?=
 =?us-ascii?Q?jjhe6dflvQQmeo452acRcxiQhR5wufPfUJAXfat/FLcG9MwOprSRKQ4bqNTs?=
 =?us-ascii?Q?SIA4EXYDXWtLblCU1jehwfTSpGfGfBzRaax2lDsFD2Wr70RvPEJaUGqatL9y?=
 =?us-ascii?Q?eSgU88tO7nQ3hIZocIYyUv/cpElm2OwkNoH2glfsFCnNeAtCtF2+VqTkpHu+?=
 =?us-ascii?Q?w9y3RKF8hYF+JC7cRj+U5BDaByT/EqTTkAcn95KCRkjTKfzOsnSSspepWH+4?=
 =?us-ascii?Q?5jC3fL55UhCYPOk6I2AaB5Spz0qh0C8cPyqHltyUebiio3muX0NOB7HHjhsE?=
 =?us-ascii?Q?B/4fdNkpmM4SgxKJkVmkTLQOfZRIjosLTDtp1+wHCVTxEIalImGoBaROrBLc?=
 =?us-ascii?Q?sSZZFWXhTKY0LKATtxl5I7cYg1ecTzbb3ahntxNwL2AgXQziyA9U1zhZjtpy?=
 =?us-ascii?Q?GUehH6Nb3x2rOQaEOGA/nXpAgeu2L4DAg6YT13dt47WBszcaFPJpoARe8dc3?=
 =?us-ascii?Q?Qa0W5YFeG74ycE0ze/lP1jJnSyronWTbhoA4ChlEiiLetWwGMhb4NPjn3Zlc?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e850f587-7c75-430d-b0d3-08dd93085a54
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:57:04.3838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQsnHargVGHDZDCq03ZcbMCq2iww3dUw/Ita5nGtk2HeUncZM2Iz512Hb84quOxd9G5/vq5TKI4W7tMnoq3nvM9Udsf9FIllH+rh+/Appwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7406
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

On Mon, May 12, 2025 at 01:54:31PM +0100, Anatoly Burakov wrote:
> Make the ice driver use the new common Rx queue structure.
> 
> Because the ice driver supports both 16-byte and 32-byte descriptor
> formats (controlled by RTE_LIBRTE_ICE_16BYTE_RX_DESC define), the common
> queue structure has to take that into account, so the ring queue
> structure will have both, while the actual descriptor format is picked by
> ice at compile time using the above macro. Direct usage of Rx queue
> structure is now meant to be replaced with a macro access that takes
> descriptor size into account.

I'd have the same comment as on the previous patch. I think it would be
better to not have to use a macro at each reference, but have the struct
type aliased as is done now.

> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v2:
>     - Make xtr_field_offs of type ptrdiff_t instead of off_t to fix 32-bit compile
>       issues
> 
>  drivers/net/intel/common/rx.h               |  23 +++
>  drivers/net/intel/ice/ice_dcf.c             |   6 +-
>  drivers/net/intel/ice/ice_dcf_ethdev.c      |  22 +--
>  drivers/net/intel/ice/ice_ethdev.c          |   2 +-
>  drivers/net/intel/ice/ice_ethdev.h          |   5 +-
>  drivers/net/intel/ice/ice_rxtx.c            | 158 ++++++++++----------
>  drivers/net/intel/ice/ice_rxtx.h            |  78 ++--------
>  drivers/net/intel/ice/ice_rxtx_common_avx.h |   6 +-
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |  14 +-
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c |  16 +-
>  drivers/net/intel/ice/ice_rxtx_vec_common.h |   6 +-
>  drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  22 +--
>  12 files changed, 164 insertions(+), 194 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index db49db57d0..9a691971bc 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -5,6 +5,7 @@
>  #ifndef _COMMON_INTEL_RX_H_
>  #define _COMMON_INTEL_RX_H_
>  
> +#include <stddef.h>
>  #include <stdint.h>
>  #include <unistd.h>
>  #include <rte_mbuf.h>
> @@ -12,6 +13,7 @@
>  
>  #define CI_RX_BURST 32
>  #define CI_RX_MAX_BURST 32
> +#define CI_RX_MAX_NSEG 2
>  
>  struct ci_rx_queue;
>  
> @@ -23,6 +25,8 @@ struct ci_rx_entry_sc {
>  	struct rte_mbuf *fbuf; /* First segment of the fragmented packet.*/
>  };
>  
> +typedef void (*ci_rx_release_mbufs_t)(struct ci_rx_queue *rxq);
> +
>  /**
>   * Structure associated with each RX queue.
>   */
> @@ -32,6 +36,8 @@ struct ci_rx_queue {
>  		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
>  		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
>  		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
> +		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
> +		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
>  	};
>  	volatile uint8_t *qrx_tail;   /**< register address of tail */
>  	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
> @@ -64,10 +70,16 @@ struct ci_rx_queue {
>  	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
>  	uint64_t mbuf_initializer; /**< value to init mbufs */
>  	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
> +	uint32_t rxdid; /**< RX descriptor format ID. */
> +	uint32_t proto_xtr; /* protocol extraction type */
> +	uint64_t xtr_ol_flag; /* flexible descriptor metadata extraction offload flag */
> +	ptrdiff_t xtr_field_offs; /* Protocol extraction matedata offset*/
> +	uint64_t hw_time_update; /**< Last time HW timestamp was updated */

Just to confirm - these are not in the ice-specific section because they
are also used by iavf?

>  	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
>  	struct rte_mbuf fake_mbuf;
>  	union { /* the VSI this queue belongs to */
>  		struct i40e_vsi *i40e_vsi;
> +		struct ice_vsi *ice_vsi;
>  	};

<snip>
