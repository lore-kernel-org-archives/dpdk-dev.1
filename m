Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01178CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 13:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D32524027B;
	Wed,  7 Oct 2026 15:03:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2A89440268;
 Wed,  7 Oct 2026 15:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791378238; x=1822914238;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kJKqeun4woXNEXer/ADXAiimZJ7Lt7Mgv5eCcuyt7Z4=;
 b=dmj+wUxmnpynCXiZ+jO0yyAgZuCT3lMJpssZkWKCc8e511ivG38nYhRE
 ec6vnki2nRAaqwgjRR92EJZSagGdvRMwwe9BiNuv8ZlDSrzj2jokkBZ0D
 ILPbpy0WqVuA2EZPivIf8OZtelpgauUp+xGZTv/valCk7hjoVbZj5Mjpg
 E6/zv2PDfxWwqH+gyKz8TZVN/XtqaMXKDgsRAzr7y3iRpYzOln8H77cMl
 MdSjR64bvQVDDXZaVH823DIL1a7c3ojha8p9t4zAIT0fhuoBoDI7zoMSR
 fcwoPm6k3tymTXskWL+mTZi8Tw36x83CAAZMGZrSK8JIUljcZDzQoEDoi A==;
X-CSE-ConnectionGUID: rp8ulESNSbyPacohEUNDVg==
X-CSE-MsgGUID: DRArB6IeR6q2CPByxj9amw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="22158"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="22158"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 06:03:56 -0700
X-CSE-ConnectionGUID: m41lOYdySzC9qd43tF3UOw==
X-CSE-MsgGUID: mYKNfrUjTP2jpL5LrtDIIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="60325"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 06:03:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:03:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 06:03:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weK0oJQURh4beoj52dn+SXMfDU603l0W7Lxa2kDwr9MIdOWzn2If1ltDeY2ZFNfR+XtrhLRSC2UApWvmAYpEhXWvlB2D3zPNN9cDTiGsfLVFnFpR6HFAvrgB/9KFZlzqF1hczrQW/nPIt+d7c5CtQuz/G5PpH2YHEMAFOupjaE4tmDzL3F6AIc8iantnKYABRMHsWu+FDgS+6guhMpwwiAdYgycGMQUKLSpAMUdFQh+7YRhF8WaGqIh9Terpc9dStzTEQCUezL/cdDLrxhegoWkdFa3T0zART1cCYLf1zvg7tI3gKNKBZ83ju5dDD+kE9CMoCIgL8b+1sp5FT0JYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqEGSEccl1EyhxzvjxDCXZcSKpzLVS3kvJV4kP19R9k=;
 b=tvcqU0HlsVgt8N7rCOY2kLUa83dyUh1HzYvl/wMZxG6abEs0ZPQ6Ty2UtG91vSKGqybX7sUJ3Jgd+qjiV7NxhDVWP75dDRmbCj/34MPsT8Tp6tnjc3W8jPJroyaxAXjaPxLWtMoWZxWh1UEzLA1MA+nCygg0wmQv3yPxuGJFJJTRd99s9TMR52pl4K5hdQe1W6XavfF5NdbgzbqBDSNsyd1S9rbEiN/ElDGXrugGt5DvU2jircSgWvdAgeWouQEnRl/bjLRHnWtQxaYYJfzh2/8ga22xh+cSWUbUvppmjKANfei3yTkIYKbvDVUYWs6JNujVAhWrp0t0CcbaW4cZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 13:03:48 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 13:03:48 +0000
Date: Wed, 7 Oct 2026 14:03:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dragos Tarcatu <dragos.tarcatu@keysight.com>
CC: <dev@dpdk.org>, <konstantin.v.ananyev@yandex.ru>, <stable@dpdk.org>
Subject: Re: [PATCH] eal/x86: check OS support for AVX and AVX512 state
Message-ID: <asZDL6DtsaQO2yB8@bricha3-mobl1.ger.corp.intel.com>
References: <20261006082056.46426-1-dragos.tarcatu@keysight.com>
 <asZCmYlJ2KmItl7J@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asZCmYlJ2KmItl7J@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0313.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fc50b6-1507-4a65-4460-08df24736d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|4143699003|56012099006|6133799003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: d5QOO9Hr7RVsFnKxfA7XMjvg9MC8l6YoTXcW1N5Y4yBQHGrc29IDTJO2qNOfipmX+Tj9BJMdbsy7v4unFSqzqQmsRx45y9IICJGWvHXNyo/6qcZVtdmxZNGDD0eWS9dUTHaQxvtuBE1VTwyiv2wFvaY5zUj0BJnBi0DZqF536CpJhoKgYw9GGXHpqmk37K5UrgQiqOOgBBZAc9Qg0x+39FUjjQ5TE0SI5chiz7H2gQCo+44aNzWlycACpWQqsvj1y8YomrMmK962bOlMhBi+WPQxtPs0jddxjzgFK5mEJnIMXFK7/dVC7WQ9ypXLNlsZQ3+KGTRM5X62DDenReKxrC00SghkxTDP95B+Lfclxe9vfDf05+fwbTiXt3KzmQlZW8PE7P4WCh9j9Xj+ealjaamye+NocfpuLQv5NkaBdQ2KsfgGCBiE62dkDUeayAdzzu8t099cGSjyXtEYLV+KxQ+xPix7fhdFB2Crotk3rPbFq148BVgrweW7EyOVPO5iOQ9iABPQIN70MMPABKRB1e2oFNrs2ENX0gSzUbVaTTRZRv+jKdwMXmy4e7om4seM9FTK+iHEDbSXXPuB5j2enI99kAMEorly36+nrk6yqL3GRQ5vVRj+Z7EmsCKc1KpdO+Fa0caX/GsCSp9zSimqNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(6133799003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MgA3rje9mQ5ocXfYwkssk94M7ibG+aMi7KaLHMAjL5QMFJEjeRZPrtys0h2X?=
 =?us-ascii?Q?p+K+u2BjQeiqsWVz6sCsrEAhT96g5tfTjxlxGILl0EjAYONP67b0B8xlwKCe?=
 =?us-ascii?Q?i/tDXvnyHY0YLT2E6U4ggUSmQMwcoLwJqu+ZCo/A+tfct3Byi+3w/sEi3bFA?=
 =?us-ascii?Q?Umc+d/0c4LnjiwkVnS7lGZwhQwLomGSN7DLKgOoa0uIweMFmTppR8AV6E4qF?=
 =?us-ascii?Q?7ZRxeYIxfv7TLYpVuKU7A6XBzVDpVdNUfBQoWBLE2aY9qUWekG6JoRrhq27F?=
 =?us-ascii?Q?vNRmESJTFnxk7a05Ga9wtFHp/J95lslV2UbrmNV6Z10djHyn22p2GXGan2Nm?=
 =?us-ascii?Q?GqAC75q6+Yt9QvPhacz9dYrLnu7Xr7hyvsp7mX2ElJqDxb799Jt6FBYmxKwx?=
 =?us-ascii?Q?h8/K1r+crQPjnUDblnn7p3ABxXH4zYaBijn9iTI4PiruRv8O3cyatHgDAXCt?=
 =?us-ascii?Q?oBil+pB9Wp1ztXw+Wx/sfLloAH/YqqjWzWyYLOeVc3RQb5+xlL/MO/ddY08i?=
 =?us-ascii?Q?GR4YEjTnRSORBEQOXdhPdh4COTtmv1srsCRHbcVv158s9edV+3pJ7Z+7A38j?=
 =?us-ascii?Q?Tbp2Ot9SZbHiRHGQd5r77o8WRDh9sfszfpE/7+g2clcTbLQH7KIdZVJcPsAN?=
 =?us-ascii?Q?SGmLjybs3pmnurTv8rkp3bKWZIIY/IvgpVR/DAKZUVqsd7umXVO1ZvP1T4Gw?=
 =?us-ascii?Q?kQQ7NAuxDqQf3OWYdHR2Xiqd9FyDys2vSlGAUNsPI332mCOIgZ8JOhUAwo+V?=
 =?us-ascii?Q?490hFBed8TptKNeSrG47xgIftk72yJAnPw+WviEOAI4kPV2qOA9+eumos/uH?=
 =?us-ascii?Q?zFa7Yzz9/U+P35QZenTnJ2PpswHUNLet4/C6dct3NMLx/0I0Hfm99tiVJs76?=
 =?us-ascii?Q?cX7DGYZr9Uiyy9PQ7L5Vo8X59IIp9PlTJSZNzxLxSNnK1y8fZP5GezgzXkpy?=
 =?us-ascii?Q?LZRU5Pt6yAABKVavjNng57YSm+OxqdPa7OM2FLhwAVER2lJ9sGVSDszpM59e?=
 =?us-ascii?Q?AviJo9sTh5RtZr7VTIq4/2HRrc9DiSsF0RotdFylI6x3DdkhPS8N+Oxk9fD6?=
 =?us-ascii?Q?U5aPEX9xoaSNNhlNERfOhsg1teFDcrjPttE8fCsoSeIHDY7/Xew259PfRyd+?=
 =?us-ascii?Q?pqAVKEuymgqmWvAeMHtY7nO4i0qBkQ0tGRrLhTz5TrE47lXczxwkHvDPBqX9?=
 =?us-ascii?Q?QtoEFva+KZq5ceudARhdZprakWDSxnfcy4FdXzBZxkktXUodzbCsVcUo4JGn?=
 =?us-ascii?Q?BC+TVUenuVj8zfxZ/u+MUo14QmAOqfybjuwKuBErmR+mmn54Njl5WpYYD+Mu?=
 =?us-ascii?Q?tRn2UERgEmMCtkTzv45Iq3a5AU2LlW2mIaPUED+pegYLmTCJXuEuX3JhGffg?=
 =?us-ascii?Q?L3d7w99umu3AcnxDK7+C0eR/JBSLOVqaYcxudOZt84YnT0UK1DTcM52JuPFb?=
 =?us-ascii?Q?JV/B5OJ6RIL/9TAPF6Nhy0SX/wTG38AXOunwj+8uXtiVFH6MAybjXhBjr65E?=
 =?us-ascii?Q?bwlF/p9cny6XRC6dukhWW6aDT6hhod7bT+35Lj9oxA7sua1EeosamYKrazqY?=
 =?us-ascii?Q?A3D83IrHL1Tlm8T36/EdcefK9dNw+TxLMOV3jP+hE4w4b5fabOAvXdelWPzG?=
 =?us-ascii?Q?UzlS138/nAkNNKaFshByJhdD4R7+JGbZ9KdaQILGGp9mvW2DnpqZaBDrdviH?=
 =?us-ascii?Q?D0BLbssxWQYnP1LL9yzWzYTIc4879Nsva5eHQPwkKUu+PqS/0Ey3M3yYXs78?=
 =?us-ascii?Q?4BG5Cd5jeRNyuIzLV0F8sxu7SpzfvMU=3D?=
X-Exchange-RoutingPolicyChecked: PperE3XqsW80IOGDx6hoIgZ6BWxIzW30LnZccKxxe3xUVfbml7iZ8j7MGiDNKhLTht/1NxCKBQoVGdIg9UVkQ5a+YkyGCz2NtMBlEQCqWKKdT/cgA/WguGAksOx/cbwxmFs/djFa1ZruMemjuNDjOf/j/azmsS86U38i1V+v1rzmsLeAJHkkwR65pN0ARO296Cf6j5ABOz39dt3xy/GR88054Fq9tjxONL+iGLsCoW11Dfb0HnxKLXZMr+FQT3qPaeW1m13M2zSHygwIJPeVgwwy7B5w+6fwIMfNXVdzk2o9fGtmFZM85vBwJlbBZDB2ici8AA8qjkOnF/LzRFBCmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc50b6-1507-4a65-4460-08df24736d1b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:03:48.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMW21NUukwIUPB4K4txW8KJpD2RV3nlcoehB16HmvhY1E84hZcIRiKWGoIdAqGwxqICW7ufrWzL3OTZkzJhy9O+G894WJbPmGfM/UgStO3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
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

On Wed, Oct 07, 2026 at 02:01:13PM +0100, Bruce Richardson wrote:
> On Tue, Oct 06, 2026 at 08:20:56AM +0000, Dragos Tarcatu wrote:
> > rte_cpu_get_flag_enabled() reads only the CPUID feature bits.  CPUID
> > tells what the CPU implements, not what the OS enables.  If the OS does
> > not enable the related state components in XCR0, the first AVX or AVX512
> > instruction raises #UD.
> > 
> > CPUID can report AVX512 while XCR0 has no AVX512 state. Old kernels
> > without AVX512 state support leave XCR0 at 0x7. A kernel booted with
> > clearcpuid=avx512f removes the AVX512 state from XCR0, but CPUID still
> > reports AVX512F. Similarly, gather_data_sampling=force removes the AVX
> > state.
> > 
> > On such a system, the rte_net_crc constructor selects the AVX512 code
> > from CPUID alone. The dynamic loader runs this constructor before main(),
> > so the application gets SIGILL before EAL can parse any argument.
> > 
> > For the AVX-class and AVX512-class flags, also read XCR0 with XGETBV.
> > Report the flag only when the OS has enabled the related state.  Use
> > XGETBV only when CPUID reports OSXSAVE, because the instruction faults
> > otherwise.
> > 
> > This change also affects rte_cpu_is_supported(). If DPDK is built for
> > AVX512 and the OS does not enable AVX512 state, EAL can now stop with an
> > error that names the missing flag. This is possible only if no AVX512
> > instruction executes before rte_eal_init(), for example in a constructor.
> > 
> > Fixes: 3934bb741354 ("eal/x86: identify AVX512 CPU flag") Cc:
> > stable@dpdk.org
> > 
> > Signed-off-by: Dragos Tarcatu <dragos.tarcatu@keysight.com> ---
> > lib/eal/include/generic/rte_cpuflags.h |   3 + lib/eal/x86/rte_cpuflags.c
> > | 102 ++++++++++++++++++++----- 2 files changed, 86 insertions(+), 19
> > deletions(-)
> > 
> Tested this using two "x86-generic" builds from test-meson-builds.sh, one
> with this patch and one without. The test app from the one without the
> patch gives illegal instruction on an initializer for avx512 crc, while the
> one with runs successfully.

Just for clarification, the test was run on a system where I'd passed
clearcpuid=avx512f to the kernel (as described above in the commit log message).

> 
> Code looks correct to me also.
> 
> Tested-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
