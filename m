Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E8C021AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:50:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54514402CF;
	Tue, 18 Feb 2025 17:50:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5C0B140264
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:50:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739897404; x=1771433404;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fE9UYigv159j2DkNhJMQinnoOQPFzZ/XiqcSWXjCGkM=;
 b=WKQvX/iFGsA7sUxo8Z0U9dIusDjTc89pJquwRcLww5DMeYc42C8n9mXk
 Ye3mrlqkskJGczwY0cpQC9lGE8Daz3TdnR4WEZSvtJhHv1WHgVHOJp4iO
 Gt72PQyFEHx7t5BDst0MoriCIaGSL5pFRdG4VHviCgadsbR5+PdTwHO91
 fLjYv6oAIcKwcGl69tNBooh+en9alNTL7Kjhq0/G/SRe60c8oz4pzwRCZ
 c3TKz/2cL4/ShCLnnMrL+is/41lyhmzWB6ywssAYDTR3hvfcK67QvVGe9
 l0fWmaFR5JUk8l4dQ8iDbMPKG1BV0NvbIWad+cqljglZs8ullrJgygoQr w==;
X-CSE-ConnectionGUID: KCRIQ8hFQiiUswHdSMhJYQ==
X-CSE-MsgGUID: PI6NEhPPSwiHUGsQRrDHwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40526444"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="40526444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:50:03 -0800
X-CSE-ConnectionGUID: l0w37DdbSVubT6F5m7V+bw==
X-CSE-MsgGUID: fkGtU1zrSXSPwajRbnuLRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="119540271"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:50:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 08:50:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:50:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:49:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZnBOfC8O/aqyRp6f047qeDDp/VBcKmCBt7bCQexAcDJQVS1Y6veBH+UcvnqgGlYIshlk4P2iQtXCDH3HGCXdgSGiBCLgZMeQKKOiyWFEZn462g208rStTzv1GQOVgtuIyaRUE/JmNWVpci6E0EdJaGw2MriYPwOgtwrg2hjCAe36SLPnQUNeoCORNEz88SnJGj+/gJ1kONgTBFUkufdIAlVIcaiwjZ0xtp+sIke+2thu0B3OOBNfXZttEuy0J9rJKojy83NTbkumGFOGpLc8ADlLpXvs+uh1IQGRKpvamUNNgdjdCRgCSikMw54wVpydM7hdNNLdCAcvFgmyTAPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB1kV7bUVs1LoZU3ySoXJR3LWc9QsvzZUVTkFwSyNKo=;
 b=wBh/an96nCoSlFAjfIJeiFQ6ncAGCwW3j81o0MILTRm4SyFy3t3Jc5v0s2RFgdp3R03QugbePPwg2ZtRAFa1n+HW7TDYCJtC5UBWitLbaNqAq7AZmmJT2bCBE+gYtzDFvCgQrcm3MBDzrBe39nqn7HDqAVFsj9u9s4M4BuOyOKIMgdCkfIHRQ0x29lSMNdNc7JrwDzjVyX7M7HagE8ViFJElFa/7Quc7+lzTaf/gIIBlgQTtSAtcqhC+1nAKlODWm5Xai0zXRhQgchHJPZKKTsRcbZ3bKLioEHrTrSausc1aBCVlfMM4q34qL6qH2GgsRmJXmhEcPPF5ZN0lH9ZyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:49:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:49:57 +0000
Date: Tue, 18 Feb 2025 16:49:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 10/10] app: enable app directory to be compiled with
 MSVC
Message-ID: <Z7S6LyIl6UKn7gF7@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-11-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1739896329-1946-11-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0203.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 340c189d-e48a-45f4-79f9-08dd503c46c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wp/PW0vxzrJHqkzxCa1Z01v4Vl0pDFJXiJaDOB9hp7gBFUv4HdlQAu4yS3YA?=
 =?us-ascii?Q?WqjSu9791PuHnTpCwgah1fAnImLMefaxxXdsV/G5KNzRroE+jPIGo5fdBPRb?=
 =?us-ascii?Q?3ru5Kr/GbTUNK0qLZNo/koe9s7HDU+E89Pv8VcgWLJ4V7br1S7/K6ytSL41n?=
 =?us-ascii?Q?ve3lECCTlLKoShbvZgTpruS1Um28+4M1vVjlMMDJHYPlEcdsFQx1bvcJUFsJ?=
 =?us-ascii?Q?JCiQfnVxQc0f7mNPjODlfHQxcSyKAitzXow29Whojue6AR8+M9870HKBE0nG?=
 =?us-ascii?Q?uaqWY8cq5IokAReJ60IRUPbSJjQID16Fxq6RJsz4p1dvjnMTu8kR/pRH1+Bs?=
 =?us-ascii?Q?MKqaCYCCMk5fjJhBSIXcdmhezjNHbQdQm5sQTowOzn4kQHv3G0nAyXCrQkbp?=
 =?us-ascii?Q?5xgQof8SrNL2OJ402XEuJTaIiYMJK8HhBEY6rlwSaSeiQJkMqBho8z+pbuz/?=
 =?us-ascii?Q?rXYBqOWsWK+Aego1mE6nIqIVXBxu5gcATlYETuAksfMIEBiXTp3M5WuyP7Kd?=
 =?us-ascii?Q?UAXrxgeOfADgNPWCdUvr5wviGakKAz08eFfc8Jyt2IIciZYw2CM6X2BfRPRL?=
 =?us-ascii?Q?EoLq0IcPJf9R7E22G+XD+nLfF5yAtxrW/hweXFm0XACrAvhXyiLCN2m6IwZl?=
 =?us-ascii?Q?nmKbOtKeGLujIsCZanmchhLy2F81pREUXCU9cATQR7d8WOHYvK0fbu61XcbA?=
 =?us-ascii?Q?kaeQJVb+45DOuRR2aY94i+qal33iKxqHYFTJfuNGBXwtp9PiI0TlRfKQsm5k?=
 =?us-ascii?Q?JblKh2qBkvNJ9D46OgKlHUWNDWhc5zZzZoAGozg4YVStSJb/GkXFsVXtGZbv?=
 =?us-ascii?Q?kogI9YNzPU73tBiA3akmvAU0K235ZDtNr/tEZz6Jd7lt04G9rQasXV6LVx/O?=
 =?us-ascii?Q?/61OA256miQaafLpsy/NTFWBPiayROn+9ZIg8d/aaQ+D/qgJ0o3rwVAUj/ub?=
 =?us-ascii?Q?prki1BulY8fw5KNZVCnUzDJps2Xo08eifGBw3+EBH+sbP7hO/WW5z+915I0o?=
 =?us-ascii?Q?TEd454GoRA5ir7tU/Q+ksSETDGjxaE4XKclrxcb6BAxSr/fXtSWuIa+azzOG?=
 =?us-ascii?Q?2Lox1UMTS9lfkqPFW9+g308cUWJ0TA6DB5lKK/3ST0+xHyR0LjfSNQREmiAZ?=
 =?us-ascii?Q?ICupiAmoP7gj1IuLqKROeJHBrS5rxCCTbUFC/XuMUERJGrjRwWe2ikucl3Pw?=
 =?us-ascii?Q?f/p6YllNIpNXAuDcdjrhFGMLtTJxt2EGgwIhliV/NONubqokewh2He1PNFaU?=
 =?us-ascii?Q?ldksnIXyuC9yIYDItw+qheayARmt7DgVuu9pQY/IGC3hMneVu3nzXd4SWXK3?=
 =?us-ascii?Q?2a5qaxk66+CosVznzVeyEeG9Zp+Rl4W2h2qE4qFhHuqLOXKrxaJHSaDqjpci?=
 =?us-ascii?Q?XoayAsC2hrzLCgdHerFI7J7L/KXj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MMzPEkDTUcUwMJn6VYid4mSNnDlswHH7nSknhwQHfXYBLIMMRaKofS/ZGJhv?=
 =?us-ascii?Q?umCg8F/aFEqhGpRiRRNWjnk04EdP3CQCIXqQrJBRM73pRTd1d4ZYZuospUui?=
 =?us-ascii?Q?JElmNBqx86d92Ye6fS6yw9Z/G+V2Ko61ugr41W7NM/Rr0qN1qVn0OX4lPkK0?=
 =?us-ascii?Q?8RsC1xUGvYzLp6pLdlcw/RGdYN2YrfppSv45I72HyLledYaGfFAPs336Lr1m?=
 =?us-ascii?Q?ndyo6/M6BxfzhrygObf6c5MNwULyMJvHVep/LaTcQQ35njK21bGuLhg9oHpc?=
 =?us-ascii?Q?zfSfflmuhK0yA0Piqtwlqx6od3Cfj0jljJULYkBb+rOqq5Lzs4r8iZ3uHEvT?=
 =?us-ascii?Q?OQadCr2ZpIRtlQKIc5z8HO5dvDzeYJ86Kvbu4w2lV8NRuXY5kJu2Q4uz1/Lh?=
 =?us-ascii?Q?IalDOiGJ1gDpcIVkJON0eP5E5muTVIKlDFAoOMKzGB0un7XEB7ib5j9iT5s0?=
 =?us-ascii?Q?4/2nj05DP8pIaAeK5RvAlm1tPDjE+hPfplDwAof3eEPoBsXJuMOoVFiFWuFc?=
 =?us-ascii?Q?XydBKDIoCJlfLwcPq07gKxl8jSb4SzFleUTWGVrOXisTJ3DXX5U5IgXluqAE?=
 =?us-ascii?Q?JaxNdg4wrGWqkFmRLAuuvEqxUTcoQM9GRGGSPhwDzzbKHxYvQIW6n/UanlP+?=
 =?us-ascii?Q?xSwSkKpwAF+xJ0tMLFJ86xDiWBT99oTRy8lcFRobU4jcH2HIe4aEEgo/X1l3?=
 =?us-ascii?Q?OgaBWsMI9Aq4mcSqZqiX+87JDjqf3O2R6lgP18K9+ZGPR+KMMxhRxbZDs+5P?=
 =?us-ascii?Q?xRzt8ed1Mz+KkrS9S9nLAUwX1+cM2eeFRDOnCg3Oqo4E/hx6VcG2UeViI7hG?=
 =?us-ascii?Q?/x5RCrH0wpfXvn1saSK1KWiV9yXdnwnnk239LV4/trRjn+Qdo2muB3v3MRfn?=
 =?us-ascii?Q?6r9tCDw0ksAz3nVrjqUuGMcLox0ntC464DlBa3tMf9BLEdRBcEyTIPGMaSV7?=
 =?us-ascii?Q?RjCS9yMUlFhl7OpyI/Xy9kCSjjnNe/DUWEL2PsS3ljOZ7VAhGIQOWESgTRcm?=
 =?us-ascii?Q?e8bJbCLv//z+sNwTJX1wIqwmz5/T4eG9lCuLdZxCejNLVaIKQLK6+X3G3itK?=
 =?us-ascii?Q?xs1CcMfR57t4qnQFn78zNv3D7Ugybpzgm8C7psvvKKjHDJtGq0UoQDZmMG6c?=
 =?us-ascii?Q?Vw16eGScS49L5GftQ+Rue4nknTYQOiJAYfGnz1Yv7K9IVYpdfhKOTSpjrt05?=
 =?us-ascii?Q?xA6xdq4HmFmBlAygtxhiJLotOaSAqC6dn24X1S19yd9UK9+fGr0aNUE+fDME?=
 =?us-ascii?Q?Zi5zMVOVu6VjrFNOoBDlm6nkST4TBLOCIuNjdAi6cmAa+xut/5z89xpdC2uF?=
 =?us-ascii?Q?6aK4NAs9VVdAp1zCQ6VCdD0zwKv79+mIHLISXrzsM1NDcoLKjA+xzktV2E1G?=
 =?us-ascii?Q?R+GXxD6UP2wiSOC6a47Q9LLm2NjRWVEiLaehnKcUfZIKBy8OVArdxldeo4mw?=
 =?us-ascii?Q?WYI0jepdb0+LhmEPxzDfumiwqScihgtlcRrb6Hm9p25oFZ2e5xNDtvFAb4bk?=
 =?us-ascii?Q?+4XBQLd9d163t1gItbSvHH4/MTpXtnea5C4z6+L+5COAhJLWIe2Yi+gXebvL?=
 =?us-ascii?Q?acr5cjB+IaQyKpzzJAfsCEOhPLr9tUOI76elLncTzYMj0AgB5EqbfwzP5eFs?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 340c189d-e48a-45f4-79f9-08dd503c46c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:49:57.4718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyEfe5lwB/3bJg9w4pK9G9sDW8ys4dLhOskmiPxnA1a8ZvSQTNKaYBG6eW6M+zknoUj2LkkZoYWbC1NsNFkusulDd53F8oiMhSAuINbgtjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
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

On Tue, Feb 18, 2025 at 08:32:09AM -0800, Andre Muezerie wrote:
> Enabled "app" directory to be compiled with MSVC along with all its
> contents.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  app/meson.build          | 4 ----
>  app/test-pmd/meson.build | 4 +++-
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/app/meson.build b/app/meson.build
> index e2db888ae1..1798db3ae4 100644
> --- a/app/meson.build
> +++ b/app/meson.build
> @@ -1,10 +1,6 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2017-2019 Intel Corporation
>  
> -if is_ms_compiler
> -    subdir_done()
> -endif
> -
>  disable_apps = ',' + get_option('disable_apps')
>  disable_apps = run_command(list_dir_globs, disable_apps, check: true).stdout().split()
>  
> diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
> index f1c36529b4..8e8863812a 100644
> --- a/app/test-pmd/meson.build
> +++ b/app/test-pmd/meson.build
> @@ -3,7 +3,9 @@
>  
>  # override default name to drop the hyphen
>  name = 'testpmd'
> -cflags += '-Wno-deprecated-declarations'
> +if cc.has_argument('-Wno-deprecated-declarations')
> +    cflags += '-Wno-deprecated-declarations'
> +endif
>  sources = files(
>          '5tswap.c',
>          'cmdline.c',
> -- 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
