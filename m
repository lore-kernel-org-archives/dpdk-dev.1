Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F87C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 15:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3525940E3E;
	Thu, 15 May 2025 17:12:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1E4B4402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 17:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747321932; x=1778857932;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=C3sElGT/GLasdU4iyri0XufxBpefLV0+KjbJ1o5VGmQ=;
 b=SYwEqF2qk1ZahzceGqCF4o35KgOJHECWfy7X0+pENrYzjFG0K5likvI3
 fP/0Ei9hRaxWlvq7hYUHLKE+Rgm5jc0+rmKPL10EVD3EcIyHg6xKYtRLU
 d/vluP3Ze5gqOXuK5lcJpV72T5VoVbUoMd9cjPaJeMKwI66tdNKpXmxVG
 wg3Py6zHRO/3uvH9gY8qsqDf0C5wdSXqHfu7rDeK7xpbxI1Pt3OomueeX
 nHrEsSx6pi1qLyYmScu/FcgkgyTzjM/uZ4qgpmdxYUDOJlfkb2HU0QbPU
 FO9Y6l9CVE3aVHt0BVNXjAzHUDmrckLOAUoJ1SocRFj64Vk8h7uySiG9F A==;
X-CSE-ConnectionGUID: Pwjhz2j4SiyFCbN1GH6Z7g==
X-CSE-MsgGUID: LcHpc6qKQMyi3NkO4IGR0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53078027"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="53078027"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 08:11:57 -0700
X-CSE-ConnectionGUID: 5R2v+bIhTOurp8XSgqTfWA==
X-CSE-MsgGUID: qh+VGqIUTuyywf8rFvsxXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138904462"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 08:11:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 08:11:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 08:11:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 08:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcfG6tPNvcNB9vl5rae8i+c5i8j5MkInKynfxXNP/WI1YFcRIMOg/gGShQLDcJACV1ARCgjNT3lK/H1+2/wN4L+db6KRjC4/uUR4aFYmXqIzkbhih2C1s5hiVlH+i1uo/e6ro5T400NBIrzZxRYN9t4FMQtBaKd+3jJNU0qAMPjWQHbEyFsKLQS9TWSXDxIYd4g8oUw0rulJPmfLydrWVMQS6Yg7Oo7kmbW/uCE+Eit4HEPefj9LwOp2gsjP/ZKMuWTZXK00JwGbhRKmCCAiP2nyHY/4xOmcGKU/8x74tHRKdJnnWMgiFNz2nKdfCphkn4PaD4G3+BEm0+wNp8KjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7dFsQdh6ewhQGczBW4LZrvD5RwZ3WIE16gHmWXlZJA=;
 b=IPzaFmaK3auMiHCqQde+DNLtUhd0Vfj7cJ5L/YlOnYXlZ7pUC4/ugSK/HAMkPH7i4w+IUVqKNh1YSlDWENBcaNJNmb0YHPlGNAbH4gbhK4Y9WM+RYMizhKX9W5ZePoA3sCzg6ASCauy3wuD6TkF49hf2fTOkPKg3LYFznrAgJZD3bNtC+cP/+5e285q0G0V67B8Vlra2/1AwtcNHUFFbnHSGZ7vzyMV6lNs5EiP6HV3HkhO3h9+Lcfd7iIywOO0Zuvy9TPxV5gbMfnfRJIgIb+Fh8yychF9uTc33R3y4RlScpx7qnYYXRceayCIIQGIt7atbJMFW1KyqG5VG6djQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8529.namprd11.prod.outlook.com (2603:10b6:408:1b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 15:11:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:11:52 +0000
Date: Thu, 15 May 2025 16:11:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: Re: [PATCH v4 0/3] lcore options cleanup
Message-ID: <aCYEMt-ztyvQoFNT@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250513161710.410000-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250513161710.410000-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 9235d687-98d4-48b0-e032-08dd93c2d24d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fq+cvQ3ucP0gwMxGAmCNjWSgdCyUYEmnivasg4wKXEqFePX3IkQ1STjYCnEm?=
 =?us-ascii?Q?Gt/Bvg8ocerYdpNWzdW2+9oJoFJddP2SJJn66Y4j0iAZp3c90fFmbt/PyT3i?=
 =?us-ascii?Q?fMmpmwuzw00fbg3BMz8GvUwgKWrNc0AHXgYyyQOw1ETo6RBueHf5w1waluif?=
 =?us-ascii?Q?6ykqYo07hV3pG4b+wsH8Wr6E09RtFmuNttTQHwN7D7YMcgqDj6Je3NLqGeSx?=
 =?us-ascii?Q?cIjhQoN2AKzCOgxuugGGrOq2iLWJOTM8Tco+5UmDgmMDvibHyCLOVpvRlG9o?=
 =?us-ascii?Q?uPOPJuJH8fxEEPSVhp8r2np2mzbjsP0GXciiS8abemRj3lxxld5sUGibTDn9?=
 =?us-ascii?Q?P4Os7y08jFC6tsn3pj8bJN8VRq5Nd87L3i7BJse+gAiF/cQb1bDpmi5c5f+C?=
 =?us-ascii?Q?adNpzYg7H7t+wyX/zFv8fgsnWQw4CD2QgrzZGXkXkOGgdLDzCKz0+XND6Cr3?=
 =?us-ascii?Q?o4/LuRmnBxfn2Wd+v52SNAVV4+NAE41LFLhzHi8bagHqkH1wlIXZCiV71L3A?=
 =?us-ascii?Q?Kt/x94jc7oT9BD93HMrPH0TBsFL/Jtm7RX1JjrBzyjkzA4Xj/aebO2eWrY+F?=
 =?us-ascii?Q?PnbLK39ejRu2f73+7GOF+M/mNZIHhcitFyH7rWnQW9hLqUPEWVGJQ1V1zNtA?=
 =?us-ascii?Q?2Z0JFaFE+PFnsoWYUV41rS2/2PkhA2z4HE9KhBAisoIwDJmcpn8sR2qcJ69M?=
 =?us-ascii?Q?Xak2MgF4RXPxBvl9xj1BoDRhU91rbu94HUauyDTmpwOHvhg62Gv8uuumWMsy?=
 =?us-ascii?Q?SRWRu6jwD4nqQ7s/oOLab4l0uVfFqroEOurE8usGlIO0biE7aY97ntJWt9lc?=
 =?us-ascii?Q?Js3cYRyPEg74MXATd1R68VFfKGcfxnewu+oWIkIKMpIO6LDvpDl4Y9nb/r/g?=
 =?us-ascii?Q?bxnsP85Hsj6D/FH3qv9E78LwkyfaTA7YMCyIYiBVyoOQy/cOdjXIuTUu6DHS?=
 =?us-ascii?Q?7Jr5UnFkGlYJhNSRETqMRbYt2U5yMFd/nNDhFxstSFsLARbdMWODG9K7JEby?=
 =?us-ascii?Q?fNak36URVaIWvLKJqy+gW6nse81CSKm2U2dD0f7XhcOkd3+lBIjdYO2dl/dq?=
 =?us-ascii?Q?GCUqVGX5GonUtdWq9KNUDsVbkOFoY7MClN+HOJm/pzzYxPoR69+H5VoaZ1Jh?=
 =?us-ascii?Q?kVAIWRIGyM6qfoPMBs9Cb4+Jpj6e8g8mXbc4yk5ii7c+Kvt4dnz0f4OeW4Un?=
 =?us-ascii?Q?XnvryPKduPfPUbw5pde9mSw7DOyrj8AfBe6ccgNn/DGGL7Ie2RLYj/Ge7pR3?=
 =?us-ascii?Q?wBzN49N7YuY1404TKIshHPX5VeETve7skJlJLa/EDhTfWDDVqpE/Wpha2lwX?=
 =?us-ascii?Q?Hej0u1GoXgqH6Aior/z+oB8sHiWYF31W5ZwJumBD7jPL7ngd6dFvSNoP7lxV?=
 =?us-ascii?Q?25IatkdH9gwvvr4gwVD+fxKBlgyfzAoNp4lQC7WrfpagjZw75Mmn1QFK9QkU?=
 =?us-ascii?Q?yv+OeyiL6Dc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krvzJsIx0zVyp6XIlxCe7mCOP+BEKIxM8CVEmg8IjTlYn3XcSbwa1VaTX0OU?=
 =?us-ascii?Q?Dv61KGMReHpKRuduHhYgJe3BBATFQF5tp5W1k4W9Dm8ZLek37Gh4rPe5VYFr?=
 =?us-ascii?Q?57LNtKw/dyG3eZNQoSaNVVKiIH/ED5iWZw8nIXm+Jg4lJovdQBKyyrmUGxAY?=
 =?us-ascii?Q?PcUtwntJBAuDMFRpxpG/NR05f+Yb09GKIw3xoEwTx41+48QFs6xxl1O01jaA?=
 =?us-ascii?Q?KGcG6UvNwiMgT+dQNIGTcNtzdDkW7UL/dGZD2QMHCGukNYrMIEf+ByW2qYnp?=
 =?us-ascii?Q?MrznFicCjuzg6ZKbWt6tC5chU9qh4Ftu3CtVQ7QpjCFsWv8XNjNrPIP0FEQR?=
 =?us-ascii?Q?wGc6DI98ZIfhB2/5q1g3xzuRi2auAoiZgzWyvPYw04w+V1c/aacyjSRy22UT?=
 =?us-ascii?Q?nbbJEioTPsFN4ME+90+nlIzduso1N5iH9BvLGVe7gt36nBsc6lCxcVQKty9j?=
 =?us-ascii?Q?lkL1jpizqlTWlvpGltOWeu2aiANVsbEftg72szDC+Kd9BDmWdkzLVIw2zyDu?=
 =?us-ascii?Q?Pmu6SQTf/cAByn+Vhq/qn7oMUvgkVd89yqWEa0pgq4EOz8mUm8xTJ0kcHzGx?=
 =?us-ascii?Q?nAhNi5v9FDLWOPZNCCvCe7fHLsYmeFxefKvFuAmV6Ws5ejjCGO6ro47Oxk0a?=
 =?us-ascii?Q?8/H4xZOwe386N8WrugTVyuJFFgaMtULJT5IFCNohKid9L91CM4XTiYE5pa8C?=
 =?us-ascii?Q?vnRjqYlZdDzjaD2uYSBJc77JPL1/G81oqLfcBtscb6IaOfV0VIyeHzPaL3Q9?=
 =?us-ascii?Q?HUAOWsWkLS/3Kwkp6bt8Wd4/BFxGTqUisEwJJGADLO5u8+BUBW3dDSx0hiMK?=
 =?us-ascii?Q?tfR4zbtmEXAyTWs1uV3OidwPZUAUO9VqNShcolOUYYa6ThegLmCP3Z5YykoD?=
 =?us-ascii?Q?bQMpfl3mbRGPA68iCu+Uv/dy6QBaufO8bg6wDpGhNSvpMjvc8j/PsSQ1RcG9?=
 =?us-ascii?Q?HIKBG7D0LnLcwj8f9GF5U5rfF2Ru43ZreGtyTeOGYRZ8J+Vn/bpthQZHvIs3?=
 =?us-ascii?Q?w3gqV3yi6eWb4TgtCh0UBK4TEl5Dl6KvabojPCKLW6nkcJWGnKDkcTzO07hz?=
 =?us-ascii?Q?zoE7U6QX0PU8p7ACnUIIIfeoGiexZH0X/g991mDaPHWEmJ9qm7rfoItFCEM3?=
 =?us-ascii?Q?jwxxzL0D4bQjIG2h0q7+dJl94kl5u5a+d1E3/dqN4yOxmhDalt3UvE2xn8c2?=
 =?us-ascii?Q?qtOAhMFS5u9KogaUOJhX4odyCBgKfSIEARw+Sney8Qi8Uy9N15lPJQZShY6E?=
 =?us-ascii?Q?pKkUHVPjvHVz+xtjJPObCJ+P1LVA/Q9fDWSIPGoA2T5atYXs6LXAsnXH4Wuf?=
 =?us-ascii?Q?hrSHAwddeXxhowX4jpj5qt7q2kJyDSf/h547Kxe4luT8KtzqssqEsZkw6IPB?=
 =?us-ascii?Q?ukLIH457EeAqVwNbQbhKeqxjafFSKDBpXtJPf7jRjfd7hMavJ22FlKm0x6Q6?=
 =?us-ascii?Q?OeSmqAJuLiGXfYOj9Stw4DwATc4rUJs4H05h7zZHiEohO9XjZ+nIF8Zu4AUq?=
 =?us-ascii?Q?PMsnsn0UgDUysTVCj+YiUwrVD5pB4xhHjzxhMiY6NQF4yjLGJrn/31xCy7cW?=
 =?us-ascii?Q?tHa15jJtD6lGBIN9YfFnNE9ZEaziCWvfXfpwW636lNioTM1AWeJHZQeFAKjl?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9235d687-98d4-48b0-e032-08dd93c2d24d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:11:52.0854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3ZLEQTnWMcowdTsWWKocP9qw0Xe/XuWtodlfvproXbIWXPifQfk4Ys1mH4J5ejEBIXRKI/tWzMyKzMX5zfuq5iXdpQ0tlqij1kRvBAuHFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8529
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

On Tue, May 13, 2025 at 05:17:07PM +0100, Bruce Richardson wrote:
> This v4 scales back some of the work done in the previous versions, since
> more options need to be looked at for the core handling. For now, then
> this patchset is reduced to some basic cleanup before any more serious work
> is done.
> 
> * marks the old coremask parameter (-c) and service core mask (-s) as
>   deprecated, so they can be dropped in future. Everything should now be
>   done using core lists where possible.
> * consolidates the, previously separate but similar, "-l" and "--lcores"
>   flags into just short and long versions of the same thing. This does
>   not affect the "--lcores" flag at all, but expands the scope of what
>   was possible with "-l".
> * Adds documentation of examples of use of the -l/--lcores parameter
> 
> Bruce Richardson (3):
>   eal: deprecate old coremask-based EAL parameters
>   eal: merge corelist and core mapping options
>   doc: provide examples of using lcores EAL parameter
> 
>  doc/guides/eventdevs/dlb2.rst                 |   6 +-
>  doc/guides/faq/faq.rst                        |   8 +-
>  doc/guides/linux_gsg/build_sample_apps.rst    |   7 +-
>  doc/guides/linux_gsg/eal_args.include.rst     |  45 ++++--
>  .../prog_guide/env_abstraction_layer.rst      |   3 +-
>  doc/guides/prog_guide/meson_ut.rst            |   2 +-
>  doc/guides/prog_guide/multi_proc_support.rst  |   2 +-
>  doc/guides/prog_guide/service_cores.rst       |   8 +-
>  doc/guides/rel_notes/deprecation.rst          |  10 ++
>  doc/guides/sample_app_ug/ip_frag.rst          |   7 +-
>  doc/guides/sample_app_ug/ip_reassembly.rst    |   7 +-
>  doc/guides/sample_app_ug/multi_process.rst    |  14 +-
>  doc/guides/sample_app_ug/qos_scheduler.rst    |   2 +-
>  doc/guides/sample_app_ug/test_pipeline.rst    |   2 +-
>  doc/guides/tools/testbbdev.rst                |   2 +-
>  lib/eal/common/eal_common_options.c           | 141 +++---------------
>  lib/eal/common/eal_options.h                  |   4 +-
>  17 files changed, 91 insertions(+), 179 deletions(-)
> 
Recheck-request: iol-unit-amd64-testing
