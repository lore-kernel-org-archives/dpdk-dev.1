Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7CECAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CBB840612;
	Thu, 18 Sep 2025 09:48:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7A3C14027A;
 Thu, 18 Sep 2025 09:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758181693; x=1789717693;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vpf3SlGVJyFIGpBduHdQrJI9dP/mfiel+uKwL4JnYFY=;
 b=ft7HQB7Gf6lWm4UxrTva/bueYrJ9SRSqb53mzWPqtf+FCLlUKOyLpv/S
 KtmEda1RvpDzpUcNgN8fQiVDyXJDNRKF/3urHtn7OqtRAIzWGDOSixJHz
 fuMe2RMc8JxzGMZXR+jwJcFx2NYleHKCbJf5JcYGi8PVBnXh/ZXjp6EuL
 Y2Ejv15/3MCbnR1Hz4WoE13nyTWNYMppnBkYBma590bK6nQEs3BfzKYXR
 pV99FfVom5wOD+3U1uAg2p7l4vZ07CTWGobtVUCj+JcwrqnZUDTt1dMVV
 9iiTXHMy5F0oKVwekZMpWXqFn9fodlFZTf62oEHv2+FdQYGyB+Y6WN0xD Q==;
X-CSE-ConnectionGUID: dqHx2j4GQ+OOaLRkhoOFRg==
X-CSE-MsgGUID: 4mlVS6wNTl2i5se/O+Y6Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="59721345"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="59721345"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 00:48:10 -0700
X-CSE-ConnectionGUID: tR6V4jctSiSNkq2hNllhOA==
X-CSE-MsgGUID: /HCM2hS4S4q3QUiYDWKuEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175387596"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 00:48:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:48:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 00:48:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs8U56M/yIr9WL7a47rug2VPqR2RTuV12KcVaLXe+r9ObzcIwniwWnWosnUuK9qkp8tyJcweFf5r0LX2hmO+IcU+Y0jX7UxvrjVHJXEghfl0GEfnYYABs+NtEK5FJiHglUT+kQbKERcyhq20lvn+EzLkOOTWEirCDo0TveM7KdnOIiy6zq9khXzAy8GYBJ9S8Gd56nEV2+lFeXiEb5es7+QI5fcDD0Sd7CAAOst6wSvUsQ8ZvfjSnC7WhqPc/6F+C7pPFcoZbDmB/gBeO8FTAK9DpxGOqXLckEzuuysW/UpoNMe5GIBOSZVpqg7+nlLGlGIgY4ScsxuqMK7ZFmRKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Z9vxYjoCX5jPuBguUriLWGCmPOXZ+g9Z8e4zgzG6U=;
 b=OoojeC0+g8xQWeyHuvHCgMc0By/zrIlBMDH/qMZObBaIS7S25xm1TYSK4aUEtGJqxAM2V3JbKyGx2q4dn6yidgbdc4npGtUCXELY+3LfyIWRe53FBgSdXrnwHjgNj5kJcmbK2SZmuu2d9bRFD2M+zlKHsgoCloTCq6PjM6+AlHwd7udEY4uYMksRiqZ3LDWNwVIX7TUuwoexyPIdTcIRAP4vgo7n1jpAKlL6T7osD/0BTASPKkBTqT4LItdMgEuNnpAHYgh9f07jolrbYlAjlZBDpuq4Po3LQkYL5bvUcv6X8/DYyC+taTc4JNPz542AzdTdT1oRQWrMnt3/5TFbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:48:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 07:48:05 +0000
Date: Thu, 18 Sep 2025 08:48:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Byron Marohn <byron.marohn@intel.com>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Keith Wiles <keith.wiles@intel.com>, 
 Luca Boccassi <luca.boccassi@microsoft.com>, Harry van Haaren
 <harry.van.haaren@intel.com>, Sean Morrissey <sean.morrissey@intel.com>
Subject: Re: [PATCH 1/3] efd: fix AVX2 support
Message-ID: <aMu5MKGFjrrffCnv@bricha3-mobl1.ger.corp.intel.com>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918073135.1273767-2-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918073135.1273767-2-thomas@monjalon.net>
X-ClientProxiedBy: DUZP191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e91e685-5348-4d40-0ecb-08ddf687b3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EzKGWN+fOqQLlAIJXVUSbEcvs4WLxGq1/dBGNQYZJ9MlXcGS04Vch8sn+3Kv?=
 =?us-ascii?Q?XcXTu+jGUgmCsO2amTWSwEkxM25c1Z9P6ZQnJutsXyU4+3Am2eQaYSfLPIez?=
 =?us-ascii?Q?PPfcDzM8Cx/5/0djsRqaDESvrM7eXwEjBmZUbrQyGxMphOpcP8lCYeHtw8UW?=
 =?us-ascii?Q?FULBAehAPqA49MeANkZBV5oQswrWB4eevcCvZVdAyKWuAkrX6ZwKscnhGjEJ?=
 =?us-ascii?Q?/VizJKkhJwqH6QLOztq/bce5qNNHoAeDIfxrnpYFmRAtJgOKh6fsBLQETtoR?=
 =?us-ascii?Q?WihezQblJk9Gps1di4/vp1xruj/ugTuz5OtL2nBww3gEw53IPifTfVwxehb4?=
 =?us-ascii?Q?B3HsEbFloEcuj0c/fDtiuFxm/bKolkXpsQBgcTaH2nhp3oTEbfUdmNCfeCKE?=
 =?us-ascii?Q?BsjJTZ1Ys9bs6knu8wSuHgZfsRai6SQ+4pfdrOOeiXupRo6eDhPTWuSAYVau?=
 =?us-ascii?Q?QJvdT6Jgr1c1yghi8C6zeLUygkOCp+pj5979n+r9kIoxCajfdSlO702c6Izu?=
 =?us-ascii?Q?9Y4p2P/qOfknInrgWKWniSRHshC+8PP8QMuroF0y1rSUMWIQDhOtke9MOrth?=
 =?us-ascii?Q?unf6Y2c735jauXlBqwf1jxcPKesSDF3wH/uz47P+E6QTP81Qn8VUT+ns5WqA?=
 =?us-ascii?Q?coXXu/e2Ls9xuKAiEA5VEzI5fhwy0YgB0lhZS8AVRM+3vQew7SnQQzE2wTMC?=
 =?us-ascii?Q?lCn0vMBjQJ/cYotv7ZjPjoOgaFFNuntH723xZYiPes2vWTqqC+rxAsSvfYYu?=
 =?us-ascii?Q?7Wg6zuz0nGwIdcAD54IJgKBVDYhBROiuaM9FP34DZLEn2FPhVqBwOolV3R1W?=
 =?us-ascii?Q?uhUw3GmMzUofEIrK7u7Lvnll7d12HNsLWabpjS2p3N6W+37uKVKxeuWaoSLx?=
 =?us-ascii?Q?Ew83inhjY06wvFJEwZSloiJ3wIavC0hzYMQKWQ6Sb6/BaB7IQh5fTlE4cAVp?=
 =?us-ascii?Q?QZropz2mVezvZwWSsrcMqiALR5KTjaXHfDCvo5qxDHAa6/lGLauiszrUr52M?=
 =?us-ascii?Q?GINe7j+Uzt5gVrWHMTv4eBK198Y0fXGArQnaeL0JjBkwaW3Kt/cAKTKNhmJk?=
 =?us-ascii?Q?q0cDY4uAEH16pRYAG/64QH1r8Iyy5FQOyUZTy+F2nahXClTtIFLQvilfTroE?=
 =?us-ascii?Q?wvnxsQ14xw7v1KBpANIfPd8F2vyuplMWXqK3dgonLqT0ThD9MhjZc5CzfA6P?=
 =?us-ascii?Q?lgHvSDKuMCFlkOI3B6E7bMNOsJQHwiUj5amA+mD0fdrn0BTNoJBzVRKeWfno?=
 =?us-ascii?Q?7DzuFEqR5Z3iaUaDr2S0jRAgU43YsubXVGONxm3rhwIJVvXhThIbMhh3ccU1?=
 =?us-ascii?Q?l11j4/c9uFX5Gq5dLfGhAZONPJl8QuR+tBSUMgCrYzwEd/7H2YSFLOijJ0d+?=
 =?us-ascii?Q?QB/ygw0l1XvWwaB5hdMPeHhfAj8TmwxYU0Kj6kNwVY4R9ySe+ZMyYjUPca+0?=
 =?us-ascii?Q?9MzPB9TMdzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdM4jSGKzWLrvhgyl1zHFbAW2Vct1l/CFIHK5jP43Lh2RRMiROLKeq5ek5vz?=
 =?us-ascii?Q?qEwBFpgA4IPaFk4tSynbEBMPomTOVsSMfu275QKZCRC3sLiLipi36K2JOi8L?=
 =?us-ascii?Q?pqNi1Y1sJQb4hgPLeFlzTo6Dk18hypZ4QqN7gQY//XbKkt6qAuwP4PE2dVlJ?=
 =?us-ascii?Q?qRfdlFsyh+cMkZyybLoy5vGE2Gb+2aHpt9yOwr4PXBohjpujYYPXMRxPrC88?=
 =?us-ascii?Q?swze636iAIzI8VNk6mJHfU7PaSzaxKB5THGny5eItf1yi6sNAnHY5CdJMC3S?=
 =?us-ascii?Q?8KNxr1fORVaEfhiH+BZhK0GNOEa73wWTSQVdtkgmZhYdiSHTot1sw+fzzqXT?=
 =?us-ascii?Q?dxU9togLwO7qM6o7MWh5ezKefmZtwF5d417nSYfev5MBrnX5uLYjsCtIjyRb?=
 =?us-ascii?Q?I5u8M8l62yABbGnOBs8LShI5CHEGwz+cdxdAz2Ez9ShuWpxTLN/ZSAk0wrAA?=
 =?us-ascii?Q?S8MxWBsw5YLKJ42/lljPjA4JlAKFoyHcqeVpwT5l4IxBMnhIiwWAGMLTK7LJ?=
 =?us-ascii?Q?houElYd10bCIP+nNLTV3hEbUs1+thCz2sdwngFeO/+PdipXEWGfVLNb4uT4C?=
 =?us-ascii?Q?shILjUt6Rm2rLEbsElxbZ6wKV/szgGPgEg6cRSlcynE/UDK4F81pv2rrDan0?=
 =?us-ascii?Q?GxwshDuZGY9q1QGv1ixKcZM8Ang2znJvR/u4RnzJBkgLtoCajg2OMkB+qwMW?=
 =?us-ascii?Q?3KsXg/ZdyLumFyj9VPNpIm+tFVvmNVTwA13zOx1GJ/tOebEj5qslwXmDPAeb?=
 =?us-ascii?Q?PZ+ZXWgkrZ3lRoSwOlKE9BrnvHK2tunVNp5Go1CzlCqDRx5GOkE0sfwxAEza?=
 =?us-ascii?Q?z0nlIviDmzDVhhdFITwwKx/FstDXGNjFUZH9hOyAKd692zX5W77siREXgxKD?=
 =?us-ascii?Q?BbQK3tc2BvXCOcjPiXVTRrt/0ivbG7X+P2CaNC2ziFXW2A1SpifO+4tB0rPX?=
 =?us-ascii?Q?VdeUl+fwru1bHfpqGCuyB4EUgp8nUnjv4GDx0kAYYlhIeHWcpGsRWK3BFq+v?=
 =?us-ascii?Q?gC0xOedITdEMVNDyP5Onshq9/UKeTNNUzFJTFb99e7lip+vJH7F2ZvopqIws?=
 =?us-ascii?Q?phlgVg/427KU5poNptlI7b/ZoaDoNN7hStzAle/dmJes5HOr11whT8TxAid+?=
 =?us-ascii?Q?nrlwp99YsoDm+O7/IG/7jbhtPysjEaqy63sIJVSoJCBzgXPPw/nbGtiykpGs?=
 =?us-ascii?Q?QvKV61zKRR2LVdM7WCVMPD05uLb3DJrPVcDTq4WgYpxmBVwEAsm+GrlKMUJY?=
 =?us-ascii?Q?4P66mt6Wl8tD+x6HH8FRxVa4HKjSNOUrmTekA9jrhFoGeBkp1XN2kb1lytq2?=
 =?us-ascii?Q?PnmKn8NinNqysZbK2LFNEZw5D6hwArTseHho0qHJLUotcCsVDhGdLaaeD1by?=
 =?us-ascii?Q?1znR/3au9DKjzcPNTMoBXR5TwH3b4uWD6QSlpxVP3YnMgD1jCqW2tNFPnji3?=
 =?us-ascii?Q?Gw3xnXKmLZxBkISSSDM9ufJ08Z/1JmXrasm2e2396SVWO+bh1hml7aYwcX8v?=
 =?us-ascii?Q?7w1qBMz9ADMYOdLy1FeLomM/m+yVWu/cEU8RHM5iqrsbfhm6njtBTJmQWmAW?=
 =?us-ascii?Q?b9JVYN1C3efHCmNerDyuS7rRN+dHV7Rg7Q4LwbWKPGY9Svo5u8bYuuMTziNK?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e91e685-5348-4d40-0ecb-08ddf687b3dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:48:05.7567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp/7xQbhYSpM15vTroRqVMd+lXfFt2tVJYRCaWDPvWNXdfWmBih6/FnGd3yEh4aJsjikCY9OJ2DLMw5LOn0q0R1AkN8ycHGmThOyOptbcaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
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

On Thu, Sep 18, 2025 at 09:28:03AM +0200, Thomas Monjalon wrote:
> When switching to Meson build, the compilation check on CC_SUPPORT_AVX2
> became obsolete, thus the case EFD_LOOKUP_AVX2 became dead.
> The function efd_lookup_internal_avx2() was never called,
> and its header include rte_efd_x86.h has been removed later.
> 
> AVX2 is assumed to be always supported on x86 with supported compilers,
> so the checks for AVX2 are simply removed, and the include is added back.
> 
> Fixes: 5b9656b157d3 ("lib: build with meson")
> Fixes: 30a1de105a5f ("lib: remove unneeded header includes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Some comments inline below. Not sure all these removals are entirely
correct - though it may be that the original code has issues itself, rather
than just this patch.

/Bruce

> ---
>  lib/efd/rte_efd.c     |  3 ++-
>  lib/efd/rte_efd_x86.h | 10 ----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
> index b0e44e5c51..ebf1e0655f 100644
> --- a/lib/efd/rte_efd.c
> +++ b/lib/efd/rte_efd.c
> @@ -26,6 +26,7 @@
>  
>  #include "rte_efd.h"
>  #if defined(RTE_ARCH_X86)
> +#include "rte_efd_x86.h"
>  #elif defined(RTE_ARCH_ARM64)
>  #include "rte_efd_arm64.h"
>  #endif
> @@ -1279,7 +1280,7 @@ efd_lookup_internal(const struct efd_online_group_entry * const group,
>  
>  	switch (lookup_fn) {
>  
> -#if defined(RTE_ARCH_X86) && defined(CC_SUPPORT_AVX2)
> +#if defined(RTE_ARCH_X86)

Ok to remove this, because indeed all supported compilers have AVX2.

However, given that the efd meson.build file doesn't check for compiler
support and optionally build some extra files with the AVX2 flags, I wonder
if this define should actually be changed to an __AVX2__ one, to detect if
the build has AVX2 support rather than just the compiler.

>  	case EFD_LOOKUP_AVX2:
>  		return efd_lookup_internal_avx2(group->hash_idx,
>  					group->lookup_table,
> diff --git a/lib/efd/rte_efd_x86.h b/lib/efd/rte_efd_x86.h
> index e2f9dcca88..f7776db8a5 100644
> --- a/lib/efd/rte_efd_x86.h
> +++ b/lib/efd/rte_efd_x86.h
> @@ -19,7 +19,6 @@ efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
>  		const efd_lookuptbl_t *group_lookup_table,
>  		const uint32_t hash_val_a, const uint32_t hash_val_b)
>  {
> -#ifdef __AVX2__

This may not be safe to remove though, because AVX2 support may not
actually be present in the build. For example, when doing a default build
with -march=corei7, __AVX2__ will not be defined, because the target CPU
doesn't support it, even though the compiler does.

>  	efd_value_t value = 0;
>  	uint32_t i = 0;
>  	__m256i vhash_val_a = _mm256_set1_epi32(hash_val_a);
> @@ -45,13 +44,4 @@ efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
>  	}
>  
>  	return value;
> -#else
> -	RTE_SET_USED(group_hash_idx);
> -	RTE_SET_USED(group_lookup_table);
> -	RTE_SET_USED(hash_val_a);
> -	RTE_SET_USED(hash_val_b);
> -	/* Return dummy value, only to avoid compilation breakage */
> -	return 0;
> -#endif
> -
>  }
> -- 
> 2.51.0
> 
