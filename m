Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD20CA600E
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:04:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D944040274;
	Thu,  8 Oct 2026 12:04:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EE10F4026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 12:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453858; x=1822989858;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VK6uk46rTbPJQuYvD+LLRuKc/1XqytCgj+lxhmuAWss=;
 b=UQMeOn6mfg5h/O6rSbXCehIvbkJ1VgRqHk++wEe2FnCG1j7ba5GH2f+z
 iHpvOYgW+xKQthIDZJlhvDi3HBTCvqVn2+erZ+Ef3HOEmhdZWPNiNw9Ds
 VLc9taSC1BAm5/sLDKUZEhAQ3CTJde3vqUc6OwPOuV1wuVRm2j3k/WWGV
 duo+BA+hFgwRsR8Pz0GMJWHfnVOL8o6Dl/msiiXJPmPJVzz+O/JSZxJX/
 u+45gYwCS+Rw3KLyqqovh4KyMt3+IePLk6wLRbdtezllYX8VfhyrlLvT3
 4FHESTTVUBaql0AnTPhYT8fTRQT1SaRqqCXMKyJlJbyT8cB6GuYFkKH5S Q==;
X-CSE-ConnectionGUID: hQt01qRhRSah9m7BPrlr+w==
X-CSE-MsgGUID: O7rXI3EMRkyUWvlrfDoPVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="239065"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="239065"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:04:16 -0700
X-CSE-ConnectionGUID: Gx8oIxv9QgSe3w2TVFggCg==
X-CSE-MsgGUID: b7MOWL6VSrSIk4JilHKGhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="109255"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:04:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:04:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 03:04:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3HQ1kgj3E1k7bhQPGEStBFfCeyg5HwJ792p9Y5QvY6AS+2uJHEyUEbN850hq1bga5N2WnWDKMT3u+Kyrt1BiX0gRVHp2wcOXkr/qAxgZeK69x5ViAxhcnUszJutnXSUaYwuupHUvux7Wb/3hEFX8qvisemfxFC2T8XQdOs5tR9tgH2O9/xhXydijXh2iNnq/jP9YGTyVd6h8jiapqgywws6FhNzLASMKeVN2nI2Z/H/400rv+VP8eH9gcLQ9kXCLTWX5HvgcPW5wF/vTmjIo/YueoishrEqXd+RxKQGbe4gcseAEjv8+t2Op7MSomDkYWjTP8uZRZw9gXA/Y7T86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u9MgIW5I6cn6Aiyx+sjePpGTKe09UU6XRUoWevnWNs=;
 b=eViKbj8S2Ipi/S+J3FJ2WwfIPxIqAKwZzgQJ5az/1WWjhSrOCl2m/DRgnbf6CHx6ot3zjSDxwRcZqt/law8t9tEUITcfjztO3ddo7mwffcrwUdZR5PMk9tamiP2yyiuu8aNr0xTsneZprHzIZAQ/JUxxJrisQXeUsCrOxa3I03v90MNIuxvs1CfwVKFK5JDuIF995tWlmmZeBNQtCU8ZkO8HQBwQFgxvAQ9AUQi+ClEX9T5YQQo5803tPLVUSr/JUZDky6wiaPbgt7tvAjQQf2ytZ/XybsXnD+c+dOp7HnbcZNm8MsJ3qYsVRGgTqoL5w0KQeXaH5OxufyPPHRIpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 10:04:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:04:13 +0000
Date: Thu, 8 Oct 2026 11:04:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Mattias =?iso-8859-1?Q?R=F6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH 05/20] eal: promote lcore variables API to stable
Message-ID: <asdqmG7cN3lpgJu3@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-6-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:10:232::28) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 42503678-ede3-4352-9fde-08df25238127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|6133799003|4143699003|9063799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GCpdfoO1eWw+2IPVpb7F3Vl14BVgfB7oAz2n+BzvJCXZGwzwjtebRMfwF16fonlttuVdVpgSSOqYRjiyo+dtyHs31NLHGk2UGYp52Z/NgwsiUcCft9bHvE/ABosRpk3F5oKJ+7wmKyBxoCeu6H2clJdaMJYjwi6iD0Fc0mkcUH/1i3xwgPzCz588d1eGo9X73K0TAYbv1g0rufD65ZB0o4YeTM/RlpaAjpbryxUKgiSEBY3UwIwxo398V1xGX9RxuhHPDkU6rW7iVLojemdgUEFxtjKXlvknHxNHdLAwu86FcPCbdQnfI/0KFvozgzlI3iorHGi7TKZyTrFR9wu4KnD8hqP80TfUsTECsui/oyCRsENm0jzXPOYxRFeDD2BDpjqRzmdsZEsp4ApAN9RCrjeynyjXXDCL/2FOj8CWxmMOUqOIv3qhKs2wZ1mMEbYIVCFSlYrd5yWkySriKrXKdnGJnp5gWaqa0FCqc3FbWj7mau7IuTz6QTRC5s5yDPlxRtoDqmu2afLSMxLzzPPfhMyVAEeLskxlFaTZiTBW0nGnX0rtJpv1ku0TXOBnbp/3SuBcZiuRCs9OPebaFfsy+NHD6l+xIogzx6Y5Jd8+/8IRoTlzpyY3TCaI/EAfhY2hVg+jb3IBaFBQ/KnEcxcE2xbqN7noNtO8eZ7wulGElvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(4143699003)(9063799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DjMrLGL3eUK7MlLd5YMQlCnDy/33N4XA9Eh4/6MiKhP5dxUdxpu42I19xlD?=
 =?us-ascii?Q?zlHUVUA8UK+EmUQ5g4JLyST1duOPIXtiYIlXRcScs88EijRNug48FYtkLOm9?=
 =?us-ascii?Q?kz1QNYZmqn+av4xaK7KY+tmXFl5XPQpayOCfEi9WeRcgvOU0LTv4XLzSfVFQ?=
 =?us-ascii?Q?19gwWUn1Az30HKG0+AXOfec4sJ1Pv6bGR2sqGDGooNQvfL5AEmGQlXzk45eu?=
 =?us-ascii?Q?7k0pCfBOwpnPJRo8jaMI7n/r3I0ceUogKNF41oWeHS0ksxFwUdaphCIjBJn8?=
 =?us-ascii?Q?2kcaAnPENcuQmV4rUnDk5erccFdq3DNZGwvzNZalOoRhWkMQKQwHJ2z3VCWX?=
 =?us-ascii?Q?QNhA0YpWVlQ2u0jeu9mYz8IMcaeuERWRkjVMEVtKm2Pu/DsBYo2MSTy+MpkO?=
 =?us-ascii?Q?BSeFxsqEysodpX7Tnyd+tZYY/D7nMBoGLH2kSP84e5njgSUqgDiL13PAs1ua?=
 =?us-ascii?Q?zxCHBEyDGWKRvzzzOsajmYyCIo2D8jGwC/+Sx0+STc/gN8GDWZJTBOku6AmA?=
 =?us-ascii?Q?0+GhKl3nZtaUTIxsD6Z63rk8l8jA7j/BsH3wpmTkvzg1m/bZRqcNin5fBp4F?=
 =?us-ascii?Q?PtaNe9tqa8ZQnmXR9K01DU2wnaQuLCabge/7Znq7mQQ85l9KrD4sk+ApvOmJ?=
 =?us-ascii?Q?1Cq53S7ansLy7dUv2h4qJzKnHPvsMRU2rUl4ivrhHdHF/C/eCbOdp2sKH0yF?=
 =?us-ascii?Q?Lwxvh7doLuKJjNM5Iim/2iTBe1LohAPUqvzk2JC5Sloxyzvw5LtfIp7vZ9Vc?=
 =?us-ascii?Q?UjYpbhE9JayrCGYmt7Ki45cWq/M0NhJOzSJjIVi16EOqJcgM13Qu4bJfkoZc?=
 =?us-ascii?Q?EvLNp/XXzelyIva3WlBrExMO4+9Idm3XmMK2y8+5YdzWQ7+rRpnHuhn28BNG?=
 =?us-ascii?Q?Baal8CIn1HedhWkjBr1ys8V/5XwpH2V1cV+b3zLSNuz5BBGxuTxRVHMN+1sQ?=
 =?us-ascii?Q?PWQiswndWX8zhoW86IJhnEHRgctQEDl+ZcMRzs7OcgiZyHb3w89OuUPOKqo8?=
 =?us-ascii?Q?Qmh2GjRT3vDdmYosH4B0ybCTkmpNyIuIkAdBCv2nGrJGW5mvKW0tffOP9BKJ?=
 =?us-ascii?Q?BQut1UWctW3eadAd7XTvpXYJOXjILGeKGLKrpH8hdrLWHkV1ZE2rGcdLOIW8?=
 =?us-ascii?Q?UG7OQVE5ETZp4v5ZmH4nXDZjEm4dHSjnkyGQytQoj7cHKyzx+Yi5EJwoXjlP?=
 =?us-ascii?Q?99+KAA3/nA39zFIxEvLq2yjix3dVLmRQYa7vWviSUt6yXg/T63bWiCrs0GmV?=
 =?us-ascii?Q?B5PPGAFCUAu7lZS9fBed2t7j22tNvehPmOndIDsF9KFJOHs75GF7hqdlZ7PX?=
 =?us-ascii?Q?ffgb7mwCfbgTMWjQkLXnpj2mXM2JBsnPhFPkMUmpD8J36GwrWZYh5FIew9mW?=
 =?us-ascii?Q?VXm3C59nQtCKdSXwGEZ+bWFhiSVgD8tbrhDujFq5ooXyzPoxxrlTsvLCQDJo?=
 =?us-ascii?Q?9yjLqIq7vH+035pqT3XZY0XAzsfZPcEEeqU8+Xguyar91XbJfhUnAyox+XQb?=
 =?us-ascii?Q?xmFsstKVE/ow0LgX5YjLcW+25CtaTEK5IeE6tPZQM/r1e3/pGB8MAfijcMh4?=
 =?us-ascii?Q?1nwgMhMp+h1ON+mE174TcGJPZ19vuE9P51G0dcOMSHys8MuoinEXY8c7NjmU?=
 =?us-ascii?Q?QXDB6RDnBMndW6d9coIc7/GYg3MlvfVk6h6ozwiX/Pjv4IAYbl7GLWNDZXUu?=
 =?us-ascii?Q?G6IXaIpawgcVKtgS0Z6JISM7hv88ZvKJEzG3I7/bGV3NZPT6saj1kMO+S9Kd?=
 =?us-ascii?Q?JH8d+ddA/ygbdVIHZOoVEfxdfjcnJNY=3D?=
X-Exchange-RoutingPolicyChecked: oYWCk02q29dYyQZqrXMdhbyUDo+PlnbKj2h8zY1gKgcF0IhvJHi0RQ63PiCP4LZT1AkGfX43iNZxV5FQ1zupiX5sfqWT00kIwOw0zHnjJ/t2GfJoNMpuuyU9H6bCWzPN6JWmpntlKcbKi4D/sxGaVKAqXQ5KwLXGdGI73geOM7J7mpvsJy1UKrtXXjbCG4IoDXwmJ9IeGiZ4FG0PIBb3N0mNGWwZIjCSh+RgkRM56pj8QLFYW60qR51wCkeB9uN/aNpfnLlMHNjONAQyZHElRH6D2SAXqIxgt5IeV9XCxM5A9/4K6l+MPEzm0NTny/aDwt2X8CdVLhkt/j8+uHtxgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42503678-ede3-4352-9fde-08df25238127
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:04:13.3222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rb+OfJvBJeVzaJAS0vleq+5YYwJ3M2NBL11+mxjhkmiPhB009oXXmGQC3q7i8LhmoYnt44A6yiMePDX3V/27kKC0zEZl7lG58VLCDQX6Nvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
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

On Wed, Oct 07, 2026 at 02:39:35PM -0700, Stephen Hemminger wrote:
> rte_lcore_var_alloc() was added in 24.11 and has not changed. The
> RTE_LCORE_VAR_* macros that form the public interface were never marked
> experimental, so the header carried a file level warning while the
> macros applications actually use looked stable.
> 
> The API is used by rte_random, rte_service, the x86 power intrinsics and
> the power PMD management code. Promote the allocator and drop the file
> level warning.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

See comment inline below though.

>  doc/guides/rel_notes/release_26_11.rst | 4 ++++
>  lib/eal/common/eal_common_lcore_var.c  | 2 +-
>  lib/eal/include/rte_lcore_var.h        | 3 ---
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 934efaaf93..62e7df5728 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -240,6 +240,10 @@ API Changes
>    are now declared with an alignment of 1 on all architectures.
>    The compiler may generate narrower loads and stores than before.
>  
> +* eal: Promoted ``rte_memzero_explicit``, ``rte_free_sensitive``,
> +  ``rte_basename``, ``rte_size_to_str`` and the lcore variables API
> +  from experimental to stable.
> +
>  * ethdev: Updated VMDq related API.
>  

This would be better done as a bulleted list so it can be easily added to
by patches. Patch 2 of this set should start by adding to release note:

* Promoted the following APIs to stable:
  - ``rte_basename`` in EAL

with the later patches adding a new bullet each time.

>    * At port configuration time, the number of VMDq pools advertised by a driver
> diff --git a/lib/eal/common/eal_common_lcore_var.c b/lib/eal/common/eal_common_lcore_var.c
> index 8a7920ed0f..a2af0e19d8 100644
> --- a/lib/eal/common/eal_common_lcore_var.c
> +++ b/lib/eal/common/eal_common_lcore_var.c
> @@ -76,7 +76,7 @@ lcore_var_alloc(size_t size, size_t align)
>  	return handle;
>  }
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_var_alloc, 24.11)
> +RTE_EXPORT_SYMBOL(rte_lcore_var_alloc)
>  void *
>  rte_lcore_var_alloc(size_t size, size_t align)
>  {
> diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
> index 48b022e84e..2737ae947b 100644
> --- a/lib/eal/include/rte_lcore_var.h
> +++ b/lib/eal/include/rte_lcore_var.h
> @@ -15,8 +15,6 @@
>   *
>   * Please refer to the lcore variables' programmer's guide
>   * for an overview of this API and its implementation.
> - *
> - * EXPERIMENTAL: this API may change, or be removed, without prior notice.
>   */
>  
>  #include <stddef.h>
> @@ -199,7 +197,6 @@ rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
>   *   The variable's handle, stored in a void pointer value.
>   *   The value is always non-NULL.
>   */
> -__rte_experimental
>  void *
>  rte_lcore_var_alloc(size_t size, size_t align)
>  	__rte_alloc_align(2);
> -- 
> 2.53.0
> 
