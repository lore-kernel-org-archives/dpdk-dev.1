Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A750C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 16:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC4BF4114B;
	Thu, 13 Mar 2025 17:54:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8336E41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 17:54:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741884852; x=1773420852;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pANpAGicMdInvNfM3191Y+XgZpY7AdGcd8W5aMMZ6fk=;
 b=TcSZyq5r1b0rNq8tO1WRm473bRRbycJJ84drxk0gjFegzk3EvSZGqqqS
 t2nMw9FvIED7xt5JLRJrdgnEKEvmNUYF5uNTzzFbbWS4xSPdohNA/oVqe
 OG9r6P9pybe1veYvzKn08ajTs4HWKLFt+tK0KdiE5KtlG0tn0uN8w5hpP
 9pB8aADni2O2LcLVpz5g9Z6V679HuebCf+KiiKApS/OTXXzgUUmsOV5Do
 EQynjZp1d8g0/kzN6m6MyKOUDzKlHT0T89vXcmmSp0Yn7bYDiEk8ugo5S
 eL7AImlyhhdHsipiq2VpkAWgd1zb2MqlUlo2WgqvMioMqQcmaFpQeRb4J A==;
X-CSE-ConnectionGUID: FlBhMxOsReuNad855UQfAA==
X-CSE-MsgGUID: NwtYv9+8QIqI3Cdj5VUFDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42266950"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="42266950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 09:54:09 -0700
X-CSE-ConnectionGUID: xT1g6nCSSOSfLKvU19m6Fg==
X-CSE-MsgGUID: nopw6xQ/SVeT0iNDa7PzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="121062839"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 09:54:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 09:54:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 09:54:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8cTKMmlihAXEau/d8qErEhQ16KjT7nAOWzOWD6tV2QS/5psUns7yCtO5cPbg4VooWjr1u0ex7+aF15rR3NWZ7Yp1FsDyj1kgT+Drq/tnpArGABepQj6ku0r7o9agUGweQNcnRk5XYhEOMQAWOEffuY0BdkumIV6WM3s3eUr7P7QxAFKx8y5QC04QamQOHj6fnXTmKo/I1B79JKc/ffFyAJCUJtY5DCvzOcJOrxWGcoWUTAWFmmvAKHT3yAwox5seZQhjN/3qys91N8Leu1r4w7b8zjBbhIPXTY9zz7N9883MCGJfHosVioEUgPRWiuZDJKJlnKg0O4lkAF58baZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmslpUNBNpkWEwPKpwHB8T4agfr+5HXHLwB9bquCCt8=;
 b=ZwQoNaCHyTEaNESRU6gja65i5Dtv9bRZ1l0eXFMZsFIKEuMBCXUvLWrXxsuyvKXFmyGOgcsZEqpn/Q6SHz1i5CXcTaqWIF4Qa+XSEOH7/GYlZk1/xs1rcKdMsPuHel5i1Ghj6HerUUS//nucxCokhbhID0/cWk2/dPep6ffegI5btrROpzo2JK6yh3Lzn7xaYK9P2vQnGRcmplz1KmiF8jIKK9M0j9lqw6/vkP/QtPgOJU90K6qEl53UhYwCfZFOo7rS38MAU9IG0bjCyOt98kTn05khx1KEKE30citIueo4GDe3+E3twSYD2k+IdEFnxlWERYABBlgV2cvpLpZq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:53:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:53:35 +0000
Date: Thu, 13 Mar 2025 16:53:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <andremue@linux.microsoft.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jasvinder Singh
 <jasvinder.singh@intel.com>
Subject: Re: [RFC v3 3/8] eal: rework function versioning macros
Message-ID: <Z9MNiiyVYXrRBpJx@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311095609.194523-4-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 209f2249-8cb4-40b7-539c-08dd624f9866
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vX8EZ2zyR84wwnBPSNtfM9hUPAw+CcXj2FhgMqz6snHzp/5nFp32LxM43QJx?=
 =?us-ascii?Q?FHigig8/W/a0+38U/OsZdfS55RyeCKmex+V4PU6MT8u0ZPODLUXAt9qluNvT?=
 =?us-ascii?Q?ygUPsCuDD9AxvD4YMl7MAt+8vr3rOAwMPomEKKNASPNuafAQugBSDM4WPMIK?=
 =?us-ascii?Q?qqWkv1g1JC7Df7q6oSPQCQtnuzzAxADxMj4EhOrF1AYCbrMYIbNTQNiBFPvc?=
 =?us-ascii?Q?hotuNqz6tLZmWLwhjyvDWvA9nzj5M41e/IjO6KcWyxvn+Am4h3+rUQ4X/WcQ?=
 =?us-ascii?Q?FTKMADez3V04/ylDY1eBJpAiQfYVzpSZsO5xOqaYiLI0cJ8VWBwXJsLseb6a?=
 =?us-ascii?Q?owbjau6AAi2hOSmEkmoEYAPxAUPpfKqdPq4iHXFsqoTnRomqijvVeV/aV8U4?=
 =?us-ascii?Q?iW/Lo/9nNT3/NmedvEBq7L+ndzPRl+8GMAY8YrjBDPgt9ek62eszgqsJ/N1J?=
 =?us-ascii?Q?UHoay6/I8e6Kk+BYqSRfjezfxbvJtrQ+I7vgWulCdS3N9QaZRDm7T5KX/uge?=
 =?us-ascii?Q?QpTMTF7xkK4InwbJnQ8UPKMGsbqK2x6TnEJ28cPM5uN5/IkuEUdDraX4Ar2/?=
 =?us-ascii?Q?+enIyP4RRaPPmo3CzG88O1I3KFyIhHjP/yjAXDv33DqqdvLcM/wQ8lPAUeTw?=
 =?us-ascii?Q?sqyFIafrSb9jPJmxPoYBXrcE199BdIR3IN/ocJmMCWYE9r+YFM0gEXUcRtac?=
 =?us-ascii?Q?esuCVR+kOnFAtfYruBsLy0EhgOkblDQ5bEbR4JwDywq619BqBzZnQNwfJ+Ts?=
 =?us-ascii?Q?w4FqFujJIrFOf+yeq/02IOl4V5tYcDIgKiUX6p/Nfd5GVUoaK/YmIQUTGdtu?=
 =?us-ascii?Q?o1pvQRCMu6bxDDSvMosEf1ULssMeJB94Ov6Cvk0xHv4MhjFjtohB4uz/V65x?=
 =?us-ascii?Q?u1/eHAUJmO3PxhYp76mckU55b9QOJu2uCGSmDEru5sbRN8GFyE7KJqvvTFis?=
 =?us-ascii?Q?1ukuQkVPvEt8fikasWTc+H0GgxKztwgH7fL80QPVwnIGwqBt0VWrTkSy4P+B?=
 =?us-ascii?Q?+1boFHUcFh9AdK2h6K5LOe+TJPdTPwb2HCn88TKnpsvEIEmFhth8LHYd6kKG?=
 =?us-ascii?Q?RaO+m4JybSsp1GhTvhwLfe6tJ+A9SrVw0/+Dl3BJoCHoRyXo9eUrsn5JdW8U?=
 =?us-ascii?Q?dXISx2R+u+i5bIFhhq3FYBKaEkl/OYDSE0sON2CNyLNY3DxA22YPRbRE4wpb?=
 =?us-ascii?Q?2MZc/UBolEcaxy7tGCZJ3TPY7bmVvY7lGE/me/RfXTQcgrTGDJv0RLMXa9Gv?=
 =?us-ascii?Q?zBpxswX7OYvd6cDHuHxmTHpTX+DizH/eQCBlLVQqzZJxKFSTqJZ10MbzOl+j?=
 =?us-ascii?Q?OyfpQvkUzcJHWFbwv5tAASbIGmBQ9xIbKf7JJYMUfgh1NXkOaBvdKlUxjQt7?=
 =?us-ascii?Q?m5x58jie1lLp7QKSgz7R44p6FTuO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awtiLlOLr3N8zYFG+m1UwFdCFs8NJaHENK1jTFB6lz6cV5rO/a54d1ay0XUf?=
 =?us-ascii?Q?iC2zvaYhJ4CM90ahSUeYx/zVptsCQLRdxOaYfRLYQUEG5aRRQxzDhuVuAFVy?=
 =?us-ascii?Q?WceX+64h2ht/BacufvEmC4B4MLtc2XY+wmP8ljSW4zGTsclnbQRjNJI+1DbB?=
 =?us-ascii?Q?XbqoJKXRz3IEui63It+x9in5RsFJY0H5XHEvB2bTJTQQKFsfQouE3aFgvnJY?=
 =?us-ascii?Q?XYUckiQJqBnnyca3mpyk23F1ge8rGWWsjN6tAH86r6WEuc1bwxYQNVLT4Irm?=
 =?us-ascii?Q?X9HGmps27z/J7uKjjejqTq77sr0rCjof4E+R7KMboRmaNgyV0cyh6W89LuBp?=
 =?us-ascii?Q?ZWKA7qUNT2WD0djBnXmVyvEoHJ64taekwJ7cZH2MbX70XS3WtKXH8Y52ovS9?=
 =?us-ascii?Q?AGu7fIyUqK8OcK54tBuov3aAXMibstx3k/A1BEGDycOTDjNugiLY+azjuEny?=
 =?us-ascii?Q?0JKX1QnKUJZ8SJFhAUcX0dhEWAwv2PjUqFhA5AF/XzgoIDF9CQ5QN6G8G+FG?=
 =?us-ascii?Q?xGdsAPRux7WAC3VKkr9Ss+IPI549Jx9AWSgHeTgLkx6BcWLkwF91l2Dmq3uN?=
 =?us-ascii?Q?Ufh2XEdRJeaGqwEcjLl8K5YKiEOKqeNysamXGSR6hRfpX29W1OLQEe70OZwd?=
 =?us-ascii?Q?4npNaCkCmSzqYxRUrOif/WviRdA3Ac7I0/qbrocS1r3YKo3XDegC04E4dUgK?=
 =?us-ascii?Q?jcfxVjoaf4tcXcZSxdUgYf45j0NiWJZT5RY03OzvpHJ9aU02bulBoM39IpIk?=
 =?us-ascii?Q?2tDmPv+q6YcIAZDLTTA2uM2jCgxraPf7ZQZEVfggGbAhRt60V2n0og7xE7kx?=
 =?us-ascii?Q?dTQrF3nRsTXLIDY/7w4wbIWo9EisIkwaCYNmWns38Ci+yFlVJ4vn3vDVqI/v?=
 =?us-ascii?Q?dBcOm1eieZ+7DAfg72JhKsdXlVI10x5Dg1h7JFDub7PSqEKXe/iYAYfooSAU?=
 =?us-ascii?Q?jGHirtshN5h/1DwTLa2JRo0hE/iIwoICxFtTbdcChqQA8T58wmEHTV/pw5w8?=
 =?us-ascii?Q?z9iJxxrU/YpyE/AST4BiS83x1hy0iAbFzMLIUe68PSPT9+rgkSfYaJVfP8Wq?=
 =?us-ascii?Q?hN56DE3zMSFaiIWfKJI1ocYXSKtuN2GX6YueODpbqjDWc9xq96bhEwWsFtIy?=
 =?us-ascii?Q?p/xC3yk2BMxlNuC7QYiVvddDfpZnSnVx11M9S1NhjIpHBehEY6dA5EC+N607?=
 =?us-ascii?Q?npEP8MQrHQy1qeH2IMJADJAt+kL/1PzoI8MsNSPK+kgH6MAVCwkZeTF4dxV/?=
 =?us-ascii?Q?IAs8K3S8b0fIvwW5sW2atIvzL2FGYUbDoz6OCqZ09jsG3LlRF8SXvmxgHbEj?=
 =?us-ascii?Q?Ha/Dv9Tn0QcC3pxhchn6DAdYIoNrsC8mT7+S9xvstEnGyxq84themNxTvJIp?=
 =?us-ascii?Q?kE8/h56wUqIejOl1WYCbHcOOpxkQ+IWrAMf38XCM1dIkv+ugG7pDmR2XOjZz?=
 =?us-ascii?Q?fU+nElZ+jFpmlhegYgzL1aWiF8Ym1jzP7FVCRLS+SITm7w7+VwT71sCjIruL?=
 =?us-ascii?Q?4Np5rnkfH7nI8+O5NPkExgH7NEraTzl3EJeu5lEv5wZWvoVVZUK+L54C9mW2?=
 =?us-ascii?Q?sQWMYJfaDUDGVVsi5+iFP+IASGBMGuHvAYUu/sgxIXEElanJCDBYGn78glPY?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 209f2249-8cb4-40b7-539c-08dd624f9866
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:53:35.7783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bni4dyt4o7YjUkKo86zjRlWpka6LtjYSTfCj6AUVww9NAcoH+30jKKqwj7Yh5OTs6e0ogQCaVxINkFAxzy8xUxfGTJJwMYvwdKXuouKqjcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5827
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

On Tue, Mar 11, 2025 at 10:56:01AM +0100, David Marchand wrote:
> For versioning symbols:
> - MSVC uses pragmas on the symbol,
> - GNU linker uses special asm directives,
> 
> To accommodate both GNU linker and MSVC linker, introduce new macros for
> exporting and versioning symbols that will surround the whole function.
> 
> This has the advantage of hiding all the ugly details in the macros.
> Now versioning a symbol is just a call to a single macro:
> - RTE_VERSION_SYMBOL (resp. RTE_VERSION_EXPERIMENTAL_SYMBOL), for
>   keeping an old implementation code under a versioned function (resp.
>   experimental function),
> - RTE_DEFAULT_SYMBOL, for declaring the new default versioned function,
>   and handling the static link special case, instead of
>   BIND_DEFAULT_SYMBOL + MAP_STATIC_SYMBOL,
> 
> Update lib/net accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

A few review comments on the docs inline below. See nothing wrong from
initial review of code changes.

/Bruce

> Changes since RFC v2:
> 
> Changes since RFC v1:
> - renamed and prefixed macros,
> - reindented in prevision of second patch,
> 
> ---
>  doc/guides/contributing/abi_versioning.rst | 165 +++++----------------
>  lib/eal/include/rte_function_versioning.h  |  96 +++++-------
>  lib/net/net_crc.h                          |  15 --
>  lib/net/rte_net_crc.c                      |  28 +---
>  4 files changed, 77 insertions(+), 227 deletions(-)
> 
> diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
> index 7afd1c1886..88dd776b4c 100644
> --- a/doc/guides/contributing/abi_versioning.rst
> +++ b/doc/guides/contributing/abi_versioning.rst
> @@ -138,27 +138,20 @@ macros are used in conjunction with the ``version.map`` file for
>  a given library to allow multiple versions of a symbol to exist in a shared
>  library so that older binaries need not be immediately recompiled.
>  
> -The macros exported are:
> +The macros are:
>  
> -* ``VERSION_SYMBOL(b, e, n)``: Creates a symbol version table entry binding
> -  versioned symbol ``b@DPDK_n`` to the internal function ``be``.
> +* ``RTE_VERSION_SYMBOL(ver, type, name, args``: Creates a symbol version table

Missing closing brace .........................^ here

> +  entry binding symbol ``<name>@DPDK_<ver>`` to the internal function name
> +  ``<name>_v<ver>``.
>  
> -* ``BIND_DEFAULT_SYMBOL(b, e, n)``: Creates a symbol version entry instructing
> -  the linker to bind references to symbol ``b`` to the internal symbol
> -  ``be``.
> +* ``RTE_DEFAULT_SYMBO(ver, type, name, args)``: Creates a symbol version entry

s/SYMBO/SYMBOL/

> +  instructing the linker to bind references to symbol ``<name>`` to the internal
> +  symbol ``<name>_v<ver>``.
>  
> -* ``MAP_STATIC_SYMBOL(f, p)``: Declare the prototype ``f``, and map it to the
> -  fully qualified function ``p``, so that if a symbol becomes versioned, it
> -  can still be mapped back to the public symbol name.
> -
> -* ``__vsym``:  Annotation to be used in a declaration of the internal symbol
> -  ``be`` to signal that it is being used as an implementation of a particular
> -  version of symbol ``b``.
> -
> -* ``VERSION_SYMBOL_EXPERIMENTAL(b, e)``: Creates a symbol version table entry
> -  binding versioned symbol ``b@EXPERIMENTAL`` to the internal function ``be``.
> -  The macro is used when a symbol matures to become part of the stable ABI, to
> -  provide an alias to experimental until the next major ABI version.
> +* ``RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args)``:  Similar to RTE_VERSION_SYMBOL
> +  but for experimental API symbols. The macro is used when a symbol matures
> +  to become part of the stable ABI, to provide an alias to experimental
> +  until the next major ABI version.

Just to clarify - this is where we create two names/aliases for the one
function, so it can be found either as an experimental version or a stable
one, right? In that way it's actually quite different from
RTE_VERSION_SYMBOL which is used to define a *NEW" version of an existing
function, i.e. two functions rather than one function with two names.

>  
>  .. _example_abi_macro_usage:
>  
> @@ -277,49 +270,36 @@ list of exported symbols when DPDK is compiled as a shared library.
>  
>  Next, we need to specify in the code which function maps to the rte_acl_create
>  symbol at which versions.  First, at the site of the initial symbol definition,
> -we need to update the function so that it is uniquely named, and not in conflict
> -with the public symbol name
> +we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current ABI version,
> +the function return type, and the function name and its arguments.
>  
>  .. code-block:: c
>  
>   -struct rte_acl_ctx *
>   -rte_acl_create(const struct rte_acl_param *param)
> - +struct rte_acl_ctx * __vsym
> - +rte_acl_create_v21(const struct rte_acl_param *param)
> + +RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param))
>   {
>          size_t sz;
>          struct rte_acl_ctx *ctx;
>          ...
> -
> -Note that the base name of the symbol was kept intact, as this is conducive to
> -the macros used for versioning symbols and we have annotated the function as
> -``__vsym``, an implementation of a versioned symbol . That is our next step,
> -mapping this new symbol name to the initial symbol name at version node 21.
> -Immediately after the function, we add the VERSION_SYMBOL macro.
> -
> -.. code-block:: c
> -
> -   #include <rte_function_versioning.h>
> -
> -   ...
> -   VERSION_SYMBOL(rte_acl_create, _v21, 21);
> + }
>  
>  Remembering to also add the rte_function_versioning.h header to the requisite c
>  file where these changes are being made. The macro instructs the linker to
>  create a new symbol ``rte_acl_create@DPDK_21``, which matches the symbol created
> -in older builds, but now points to the above newly named function. We have now
> -mapped the original rte_acl_create symbol to the original function (but with a
> -new name).
> +in older builds, but now points to the above newly named function ``rte_acl_create_v21``.
> +We have now mapped the original rte_acl_create symbol to the original function
> +(but with a new name).
>  
>  Please see the section :ref:`Enabling versioning macros
>  <enabling_versioning_macros>` to enable this macro in the meson/ninja build.
> -Next, we need to create the new ``v22`` version of the symbol. We create a new
> -function name, with the ``v22`` suffix, and implement it appropriately.
> +Next, we need to create the new version of the symbol. We create a new
> +function name and implement it appropriately, then wrap it in a call to ``RTE_DEFAULT_SYMBOL``.
>  
>  .. code-block:: c
>  
> -   struct rte_acl_ctx * __vsym
> -   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
> +   RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param,
> +        int debug))

Not directly relevant to the changes in this patch, but since this is
documentation which doesn't actually need to be based on a real-life
example, we should maybe come up with example functions which are short and
don't need line wrapping. This example would be just as
effective/instructive with a return value of "int" and parameter type
without a "const" qualifier. :-)

>     {
>          struct rte_acl_ctx *ctx = rte_acl_create_v21(param);
>  
> @@ -328,35 +308,9 @@ function name, with the ``v22`` suffix, and implement it appropriately.
>          return ctx;
>     }
>  
> -This code serves as our new API call. Its the same as our old call, but adds the
> -new parameter in place. Next we need to map this function to the new default
> -symbol ``rte_acl_create@DPDK_22``. To do this, immediately after the function,
> -we add the BIND_DEFAULT_SYMBOL macro.
> -
> -.. code-block:: c
> -
> -   #include <rte_function_versioning.h>
> -
> -   ...
> -   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
> -
>  The macro instructs the linker to create the new default symbol
> -``rte_acl_create@DPDK_22``, which points to the above newly named function.
> -
> -We finally modify the prototype of the call in the public header file,
> -such that it contains both versions of the symbol and the public API.
> -
> -.. code-block:: c
> -
> -   struct rte_acl_ctx *
> -   rte_acl_create(const struct rte_acl_param *param);
> -
> -   struct rte_acl_ctx * __vsym
> -   rte_acl_create_v21(const struct rte_acl_param *param);
> -
> -   struct rte_acl_ctx * __vsym
> -   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
> -
> +``rte_acl_create@DPDK_22``, which points to the function named ``rte_acl_create_v22``
> +(declared by the macro).
>  
>  And that's it, on the next shared library rebuild, there will be two versions of
>  rte_acl_create, an old DPDK_21 version, used by previously built applications,
> @@ -365,43 +319,10 @@ and a new DPDK_22 version, used by future built applications.
>  .. note::
>  
>     **Before you leave**, please take care reviewing the sections on
> -   :ref:`mapping static symbols <mapping_static_symbols>`,
>     :ref:`enabling versioning macros <enabling_versioning_macros>`,
>     and :ref:`ABI deprecation <abi_deprecation>`.
>  
>  
> -.. _mapping_static_symbols:
> -
> -Mapping static symbols
> -______________________
> -
> -Now we've taken what was a public symbol, and duplicated it into two uniquely
> -and differently named symbols. We've then mapped each of those back to the
> -public symbol ``rte_acl_create`` with different version tags. This only applies
> -to dynamic linking, as static linking has no notion of versioning. That leaves
> -this code in a position of no longer having a symbol simply named
> -``rte_acl_create`` and a static build will fail on that missing symbol.
> -
> -To correct this, we can simply map a function of our choosing back to the public
> -symbol in the static build with the ``MAP_STATIC_SYMBOL`` macro.  Generally the
> -assumption is that the most recent version of the symbol is the one you want to
> -map.  So, back in the C file where, immediately after ``rte_acl_create_v22`` is
> -defined, we add this
> -
> -
> -.. code-block:: c
> -
> -   struct rte_acl_ctx * __vsym
> -   rte_acl_create_v22(const struct rte_acl_param *param, int debug)
> -   {
> -        ...
> -   }
> -   MAP_STATIC_SYMBOL(struct rte_acl_ctx *rte_acl_create(const struct rte_acl_param *param, int debug), rte_acl_create_v22);
> -
> -That tells the compiler that, when building a static library, any calls to the
> -symbol ``rte_acl_create`` should be linked to ``rte_acl_create_v22``
> -
> -
>  .. _enabling_versioning_macros:
>  
>  Enabling versioning macros
> @@ -519,26 +440,17 @@ and ``DPDK_22`` version nodes.
>      * Create an acl context object for apps to
>      * manipulate
>      */
> -   struct rte_acl_ctx *
> -   rte_acl_create(const struct rte_acl_param *param)
> +   RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create,
> +        (const struct rte_acl_param *param))
>     {
>     ...
>     }
>  
> -   __rte_experimental
> -   struct rte_acl_ctx *
> -   rte_acl_create_e(const struct rte_acl_param *param)
> -   {
> -      return rte_acl_create(param);
> -   }
> -   VERSION_SYMBOL_EXPERIMENTAL(rte_acl_create, _e);
> -
> -   struct rte_acl_ctx *
> -   rte_acl_create_v22(const struct rte_acl_param *param)
> +   RTE_VERSION_EXPERIMENTAL_SYMBOL(struct rte_acl_ctx *, rte_acl_create,
> +        (const struct rte_acl_param *param))
>     {
>        return rte_acl_create(param);
>     }
> -   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
>  
>  In the map file, we map the symbol to both the ``EXPERIMENTAL``
>  and ``DPDK_22`` version nodes.
> @@ -564,13 +476,6 @@ and ``DPDK_22`` version nodes.
>          rte_acl_create;
>     };
>  
> -.. note::
> -
> -   Please note, similar to :ref:`symbol versioning <example_abi_macro_usage>`,
> -   when aliasing to experimental you will also need to take care of
> -   :ref:`mapping static symbols <mapping_static_symbols>`.
> -
> -
>  .. _abi_deprecation:
>  
>  Deprecating part of a public API
> @@ -616,10 +521,10 @@ Next remove the corresponding versioned export.
>  
>  .. code-block:: c
>  
> - -VERSION_SYMBOL(rte_acl_create, _v21, 21);
> + -RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param))
>  
>  
> -Note that the internal function definition could also be removed, but its used
> +Note that the internal function definition must also be removed, but its used

its -> it's (or "it is" if you want the longer version).

>  in our example by the newer version ``v22``, so we leave it in place and declare
>  it as static. This is a coding style choice.
>  
> @@ -663,16 +568,18 @@ In the case of our map above, it would transform to look as follows
>          local: *;
>   };
>  
> -Then any uses of BIND_DEFAULT_SYMBOL that pointed to the old node should be
> +Then any uses of RTE_DEFAULT_SYMBOL that pointed to the old node should be
>  updated to point to the new version node in any header files for all affected
>  symbols.
>  
>  .. code-block:: c
>  
> - -BIND_DEFAULT_SYMBOL(rte_acl_create, _v21, 21);
> - +BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
> + -RTE_DEFAULT_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param,
> +        int debug))
> + -RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param,
> +        int debug))
>  
> -Lastly, any VERSION_SYMBOL macros that point to the old version nodes
> +Lastly, any RTE_VERSION_SYMBOL macros that point to the old version nodes
>  should be removed, taking care to preserve any code that is shared
>  with the new version node.
>  
> diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/include/rte_function_versioning.h
> index eb6dd2bc17..0020ce4885 100644
> --- a/lib/eal/include/rte_function_versioning.h
> +++ b/lib/eal/include/rte_function_versioning.h
> @@ -11,8 +11,6 @@
>  #error Use of function versioning disabled, is "use_function_versioning=true" in meson.build?
>  #endif
>  
> -#ifdef RTE_BUILD_SHARED_LIB
> -
>  /*
>   * Provides backwards compatibility when updating exported functions.
>   * When a symbol is exported from a library to provide an API, it also provides a
> @@ -20,80 +18,54 @@
>   * arguments, etc.  On occasion that function may need to change to accommodate
>   * new functionality, behavior, etc.  When that occurs, it is desirable to
>   * allow for backwards compatibility for a time with older binaries that are
> - * dynamically linked to the dpdk.  To support that, the __vsym and
> - * VERSION_SYMBOL macros are created.  They, in conjunction with the
> - * version.map file for a given library allow for multiple versions of
> - * a symbol to exist in a shared library so that older binaries need not be
> - * immediately recompiled.
> - *
> - * Refer to the guidelines document in the docs subdirectory for details on the
> - * use of these macros
> + * dynamically linked to the dpdk.
>   */
>  
> -/*
> - * Macro Parameters:
> - * b - function base name
> - * e - function version extension, to be concatenated with base name
> - * n - function symbol version string to be applied
> - * f - function prototype
> - * p - full function symbol name
> - */
> +#ifdef RTE_BUILD_SHARED_LIB
>  
>  /*
> - * VERSION_SYMBOL
> - * Creates a symbol version table entry binding symbol <b>@DPDK_<n> to the internal
> - * function name <b><e>
> + * RTE_VERSION_SYMBOL
> + * Creates a symbol version table entry binding symbol <name>@DPDK_<ver> to the internal
> + * function name <name>_v<ver>.
>   */
> -#define VERSION_SYMBOL(b, e, n) __asm__(".symver " RTE_STR(b) RTE_STR(e) ", " RTE_STR(b) "@DPDK_" RTE_STR(n))
> +#define RTE_VERSION_SYMBOL(ver, type, name, args) \
> +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@DPDK_" RTE_STR(ver)); \
> +__rte_used type name ## _v ## ver args; \
> +type name ## _v ## ver args
>  
>  /*
> - * VERSION_SYMBOL_EXPERIMENTAL
> - * Creates a symbol version table entry binding the symbol <b>@EXPERIMENTAL to the internal
> - * function name <b><e>. The macro is used when a symbol matures to become part of the stable ABI,
> - * to provide an alias to experimental for some time.
> + * RTE_VERSION_EXPERIMENTAL_SYMBOL
> + * Similar to RTE_VERSION_SYMBOL but for experimental API symbols.
> + * This is mainly used for keeping compatibility for symbols that get promoted to stable ABI.
>   */
> -#define VERSION_SYMBOL_EXPERIMENTAL(b, e) __asm__(".symver " RTE_STR(b) RTE_STR(e) ", " RTE_STR(b) "@EXPERIMENTAL")
> +#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) \
> +__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
> +__rte_used type name ## _exp args; \
> +type name ## _exp args
>  
>  /*
> - * BIND_DEFAULT_SYMBOL
> + * RTE_DEFAULT_SYMBOL
>   * Creates a symbol version entry instructing the linker to bind references to
> - * symbol <b> to the internal symbol <b><e>
> + * symbol <name> to the internal symbol <name>_v<ver>.
>   */
> -#define BIND_DEFAULT_SYMBOL(b, e, n) __asm__(".symver " RTE_STR(b) RTE_STR(e) ", " RTE_STR(b) "@@DPDK_" RTE_STR(n))
> +#define RTE_DEFAULT_SYMBOL(ver, type, name, args) \
> +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_" RTE_STR(ver)); \
> +__rte_used type name ## _v ## ver args; \
> +type name ## _v ## ver args
>  
> -/*
> - * __vsym
> - * Annotation to be used in declaration of the internal symbol <b><e> to signal
> - * that it is being used as an implementation of a particular version of symbol
> - * <b>.
> - */
> -#define __vsym __rte_used
> +#else /* !RTE_BUILD_SHARED_LIB */
>  
> -/*
> - * MAP_STATIC_SYMBOL
> - * If a function has been bifurcated into multiple versions, none of which
> - * are defined as the exported symbol name in the map file, this macro can be
> - * used to alias a specific version of the symbol to its exported name.  For
> - * example, if you have 2 versions of a function foo_v1 and foo_v2, where the
> - * former is mapped to foo@DPDK_1 and the latter is mapped to foo@DPDK_2 when
> - * building a shared library, this macro can be used to map either foo_v1 or
> - * foo_v2 to the symbol foo when building a static library, e.g.:
> - * MAP_STATIC_SYMBOL(void foo(), foo_v2);
> - */
> -#define MAP_STATIC_SYMBOL(f, p)
> +#define RTE_VERSION_SYMBOL(ver, type, name, args) \
> +type name ## _v ## ver args; \
> +type name ## _v ## ver args
>  
> -#else
> -/*
> - * No symbol versioning in use
> - */
> -#define VERSION_SYMBOL(b, e, n)
> -#define VERSION_SYMBOL_EXPERIMENTAL(b, e)
> -#define __vsym
> -#define BIND_DEFAULT_SYMBOL(b, e, n)
> -#define MAP_STATIC_SYMBOL(f, p) f __attribute__((alias(RTE_STR(p))))
> -/*
> - * RTE_BUILD_SHARED_LIB=n
> - */
> -#endif
> +#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) \
> +type name ## _exp args; \
> +type name ## _exp args
> +
> +#define RTE_DEFAULT_SYMBOL(ver, type, name, args) \
> +type name args
> +
> +#endif /* RTE_BUILD_SHARED_LIB */
>  
>  #endif /* _RTE_FUNCTION_VERSIONING_H_ */

Changes to this file look ok to me.

<snip>
