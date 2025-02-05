Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56824C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 801D0402E3;
	Wed,  5 Feb 2025 16:47:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id CF68D402E3
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738770474; x=1770306474;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y7icGJfuRcscIgZ7KOrAbAVm5/2gMYoy0waNY/dys4o=;
 b=ZAdz+Sw8mHlhlt2mJIHWpVfkFPuQBgdas4sN1+gI7RBaAClgK9MTJPdx
 WQ8E0h/g1P2PMSw343Va+pKo2FbYEqAOxteO2IMg8smwxaBwfDhXQdiKb
 iO9xxve6pMf0OrcGCK83lcI4Pb0BPRzzXVfNOkO/pb3PPFjH9HeVrLaRp
 mZoEqdWHcRBAUP+A92SVg+Q8+jynLXv2zgx/SedvojI85YkzgZrmZiPAX
 /fzzg5JiLQn3C336sU10iHUm2DaQ3NZoRRLKyEC+Y25/wEMkRBoEVpEdc
 cAMzmRbYgtYg/7xyzHJkiVelaSn7gLtinSW7/kvrsZomEfZZjZztBlOB0 A==;
X-CSE-ConnectionGUID: onwMVSj4Re+hoKqxhOQkIw==
X-CSE-MsgGUID: PzmSYa+vTnCJtiy42CT4BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39237822"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="39237822"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 07:47:53 -0800
X-CSE-ConnectionGUID: S0/ftBBtQ9maJKEYvmvEyQ==
X-CSE-MsgGUID: 56j8Fy0VTmmuohB0vjBVnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="115982753"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 07:47:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 07:47:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 07:47:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 07:47:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYKacEUs7twxkPMd1TmtAIzJODjREyYl1SHlT3yv8xL4QNgiYxDPryfmiSI0YQA/lYMRb7Ha+0foPFzSr3WW6PKuJXFAAEUuuN62Expk3odlSVGTfVgFadEQJXkVQYkBAP0CAWpSbOiE++RknIDyJpJz0DKVBsg1rMGWUMRAIB5lA8zbG6B4L00u/eKW7G67K5knV0LgJoFZWiAtubDyyhpz2A1cvXy3HDIkTgwy6xLX2Q2OcCF73unvRr0Ya3OHCum3Xcf4Bv5uPYd7Fvhrv3xOP1P6tPo5Rk5ZolMr9WTtKvXmXrPwc3cbqubr8cQMmJJKrp8TOzZ5cN9lkCdDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88ybgOGrdi6wjRS5ptdL64ckJfb8YcnBQrZF17Clvmw=;
 b=DrPR/X2Tdp06uWJkhKsMQ8hYQHR6gteIJzBGe1z5aLRN59d5z4uxfOpDqmmHKHoxXHR8SqolmeEzCShT3Mmd8uR5YQSwq+YSoaB8vlfOkuefcit1JOqcbGQugHcwq9yQFgcvibmhmarJ+SzT8Rb+w79fgZAMiHhO1y+YNF96Y0s4x6t/iSCIW2ZRQsTvqMYvOxmo2rNijQgIcJTqne+kVgWspgqrIm8tUtbGcwWS/KhjN6SiSVSIZwHj98BSalacEmg87DdTxbERaX5p3m4qf+sJWSWN8it5Tfx+vDoEzdaP4mCz4ioag5jZTUI6R1sYMkLogNF7i7eCN9gXHi9XKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:47:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 15:47:44 +0000
Date: Wed, 5 Feb 2025 15:47:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH v4 0/7] eliminate dependency on non-portable
 __SIZEOF_LONG__
Message-ID: <Z6OIGtUHFJOTkB95@bricha3-mobl1.ger.corp.intel.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
 <Z6MsP35NONKe7wSb@bricha3-mobl1.ger.corp.intel.com>
 <20250205153721.GA9429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205153721.GA9429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU7P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7821b6-462d-448e-36a1-08dd45fc6e8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g2FGVP0FsuKYnF/oeEGDsMFWYHqLDpnzLcHJSf11sKGSXi3LfCnQ0NFUwQIJ?=
 =?us-ascii?Q?6JMPM3sJIfE8hO7ulW0d04AGTXvbQn/pN/jJkF7hhYfv0NiJP706SuKPlUmK?=
 =?us-ascii?Q?7okB2HVSD9hjplDt+uZ3o0ni20Nq3YFTJKkASA0OGXhEPLfySHLLAw3Z78WG?=
 =?us-ascii?Q?CgOEZ5vM9EmS1I3rHgugydwG/9T0KwKPIeXYRT3LDIakOtxvtw1jcY1ya/M5?=
 =?us-ascii?Q?S8sYpS+sH64zZYV5igPvWHn3x95XLVz4bGsBfckaBHZaZowora+SbgeT/DyH?=
 =?us-ascii?Q?DiW93tA4mlEoraoENxlUXeGwyH1R4oXJvbaSTK08u+CXwxpIVfshuUw1WWQw?=
 =?us-ascii?Q?QUz8P9iN/WveLd2V5Ws5P3oWfRXhoHmrCHWi6dqfpEZi3iG1LLFY/BBz+sHx?=
 =?us-ascii?Q?/ZmnddQk898UMgmDwEMAA2VLu7efPiLGHvBQtnfBxurWtUU60mGvUnQeJxYa?=
 =?us-ascii?Q?GqYlasUUTLrPGJIYkKpzAvHV2Uj9Zwoe9mfbOwlJrI0JuOtxKhGIOuhLOduD?=
 =?us-ascii?Q?FN+nQfyDzz/Ph68tUwHuJVySD3TboaVdCFtTwwQpPsbhn+DPGHEryOINTTGr?=
 =?us-ascii?Q?hIgepdH6YTfRfVGsEmd0VRP+i0lBYfUdIXQrn1dcMalfLERhp5q8jmya6dx5?=
 =?us-ascii?Q?mTMcV4Krnoiw0B2L0pOC+ugQK/Qs2X1/buG7/7YMx9TN9Z4y7NYF9Vfy+kMr?=
 =?us-ascii?Q?E55X1OGtmwEWUZkV7r3S5RfyXTO1ol+tAIN5A8Wr51NfyfifTi0IGKIJfHcV?=
 =?us-ascii?Q?WgnTMU4WQ7Kl+EFb9/etqNTQEXfquhTgGCnNXoUacpKwuKsUTf//PKCSu085?=
 =?us-ascii?Q?1HfERRE6L29wAW45tdIrj6cD/QKlD/4TvhipUvg00eGcmpk2QiCxar1BFhoY?=
 =?us-ascii?Q?/yWm0mgmpRIM7gaPvbEmKouzomIKjdd8+E9RuB2jtHkRhxoy/UbBeQGJQOUn?=
 =?us-ascii?Q?0HNDbwzTtXyKaIxgjSAGMBdwT5fZPPPYiO5PEAkMkBQb2Xy5UtWA541h0l88?=
 =?us-ascii?Q?8SPcnu6DxkqZuOSwJXtZIpd29KB/qWJDOP7KLErc3/M4br8nexNiWI8x4K45?=
 =?us-ascii?Q?Hzf6e6V52TL/6s3+75yOKyZq4IKu61b4MMflXactTHmCH8TytHOCCumhWEju?=
 =?us-ascii?Q?j/BreZA7V2GuSEypT1JkzIdZd0IDhyAhSDn/ETOncv/KhAlh1+lMoPcHgK3L?=
 =?us-ascii?Q?pyUAkNYfWGdIHRKCl0cEC5SDsHk95Vj28ZPXq7v6XJmTnKv0GMwpKPR67Qzr?=
 =?us-ascii?Q?MaK4cWpokVdt2uOEY+b76/4ul3vfAxh2/l19EsDlCvS8UfHd1hVHbG1pmKyD?=
 =?us-ascii?Q?US5x8wVtv0Et1FlFgN7HcpgMht+VPQU2FIG+VP0liSHjXWbqio8UHvUG6Slj?=
 =?us-ascii?Q?9LBOLjuLFyq1tGx/ZtLKzKKJMQS8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7h17SEasIcf93p+rXn+muOJQND4kpF8l1FbV42EnEncGiNSkYmMeA+bCoCY?=
 =?us-ascii?Q?/QwHRXBTk8pG4BceW3/MM5FbH5oa1G4Jz3l8ZNEmG5+GINYmiQrixMlaBwRf?=
 =?us-ascii?Q?hSRdYnAtHzjfjNkv+5+S2iX0JJDesU3YYhVkuFyxhc+MLAwrep9Az51hTE3h?=
 =?us-ascii?Q?IUFNyIEopQ2YFBcbU7Ahxo9XwmfBrlBddGWA8DJihbkIy066kWVFhTp/4rMr?=
 =?us-ascii?Q?7mpGf5B4j1AF30/ykuq3DCzAPCHILbe/WmBuQxT++o7cIzz7ga7aSTCg/P4K?=
 =?us-ascii?Q?Gjl18h+qSfyGNjnh97SrN+3zIeM3reHk4GAgDeAj3rSkBmtVntW0qXb1X1Z/?=
 =?us-ascii?Q?9xkqxDqpQYpDgO1pj2Pl6aoWOF9trZbttlS19k7WFaiEb1luSura+csmAbqT?=
 =?us-ascii?Q?XhgoGxSSXnAgxWrTFb77aQ5Iqc+73XCPW+t/d4DICmHEj33tL/gITWY2j2aY?=
 =?us-ascii?Q?jQdYOaP9DEAY2hCgzSnM6DTfZg2DecSLi2h3REr+mR2CPUs9Ax5X/s6bMaoT?=
 =?us-ascii?Q?r/r4fXVe2/jXpqhRTogteeWUq0wty1l0DZ6juuVflz4u/uXuoZk+K57JVKgl?=
 =?us-ascii?Q?SsfAtfIBEIvD75VDT21/v3QvKIJSmKXV0SkPN/KgO4gLJkzWsr1DDgKq5Ch2?=
 =?us-ascii?Q?YDWKSxsycdnr/fkG8djfkVEhxJg+LMfhZ7MH16X2tcPVIeLXMs1780iCX41L?=
 =?us-ascii?Q?bw4FjnnsuHsHhgakqb0g+qmHF73Wd8ZV6Y+bfLXrN1DLlfZjKe5y0g4p+TJ0?=
 =?us-ascii?Q?ari8AvUFc/3EIrsdYzZ3gKdD9rHTIJokqGlmARYQLX7SHruGuprUMIM2CZ+R?=
 =?us-ascii?Q?JyZtFCUgrGZZRP86IghAVlB9MKWSFqgvYbKOfCT+GHDcagIiz0RRzy/8xupV?=
 =?us-ascii?Q?llnFZaZxoosvXtu4BxME7JeZkg4ItR5JQz7B6b8u5sG+x+u00C5rFw9MvCXq?=
 =?us-ascii?Q?/gLNf6A0N7OVT8D82Z2t6hVIJla4YHGomQJUXc/044SHsUoyZemVXfMF+IVe?=
 =?us-ascii?Q?sDCowokt/bUEfS09qT56PUQG4IMy4JUB/MkYQotkSA6Hi3BF/9sZXf+s3//H?=
 =?us-ascii?Q?32GqCOgKIhszSmeZiigXTAeA6ooULoGqaL2UbamFajqvM4Wqb3ErYXHJrYXO?=
 =?us-ascii?Q?fWK4sXei7Q0kr+Uwn7UkwWloFx0ENHuCRSDgYAZBhF3/yDB10yT4L2iNAAvc?=
 =?us-ascii?Q?75btMTUW8GGhP84ArLTZimGvSFCGSdZhrqjL24d1PYpnfLgigmajlVqRcGl9?=
 =?us-ascii?Q?abRYVODfctOWN3ymy19JKMSnvfjFLUIawcvIFFY3MoJ1SYSCXL+R4+Pk0QK8?=
 =?us-ascii?Q?BsP2V5Lc81kyRUma1kTXldp9lyvV4xGO1IhJUrL0JFukQz6Ce3Fu71ZRoS1S?=
 =?us-ascii?Q?uKM7FT2VkCkHlhcfhO70MkGb+DTGxETMfuOcUuXYjSOkSsNtGI0AiRnTipu2?=
 =?us-ascii?Q?lSbGLYFtYP8YOieyBUJlp39dhW8H46NwLZWBaASqT3r0dRJlm14briyApZYR?=
 =?us-ascii?Q?nbaaPLykoBnVyUonW45DBBKbvyl7+PbYH0I5nOvqYRmWWGpjCjb52djlbPqC?=
 =?us-ascii?Q?aE5qoYKJJOPyOIU7yUogpuDHT0rVItisinRUaaSnFWxwY0sjyH2W+RirDAQS?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7821b6-462d-448e-36a1-08dd45fc6e8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:47:44.6918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFHCN8DYulFyOGP6kjoMnMLZqh6foNzmgBck42JRkg3Umu+psU7hI/zqaRmTlG81GvqrItrIL/Dh5mYQLPOYcaYQpMlUdf9opbKuBne4nVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
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

On Wed, Feb 05, 2025 at 07:37:21AM -0800, Andre Muezerie wrote:
> On Wed, Feb 05, 2025 at 09:15:43AM +0000, Bruce Richardson wrote:
> > On Tue, Feb 04, 2025 at 10:54:24AM -0800, Andre Muezerie wrote:
> > > Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> > > Therefore the errors below are seen with MSVC:
> > > 
> > > ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
> > >     '__SIZEOF_LONG__': undeclared identifier
> > > ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
> > >     case expression not constant
> > > 
> > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
> > >     '__SIZEOF_LONG__': undeclared identifier
> > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
> > >     case expression not constant
> > > 
> > > Turns out that the places where __SIZEOF_LONG__ is currently
> > > being used can equally well use sizeof(long) instead.
> > > 
> > > v4:
> > >  * rebased on latest main as previous patch was not applying cleanly
> > >    anymore.
> > > 
> > > v3:
> > >  * added prefix RTE_ to BITS_PER_LONG* and moved them to rte_common.h
> > >  * defined PLT_BITS_PER_LONG* in drivers/common/cnxk/roc_platform.h to
> > >    avoid warnings from checkpatches.sh like:
> > > 
> > >    Warning in drivers/common/cnxk/roc_bits.h:
> > >    Warning in drivers/common/cnxk/roc_ie_ot.h:
> > >    Warning in drivers/common/cnxk/roc_ie_ot_tls.h:
> > >    Use plt_ symbols instead of rte_ API in cnxk base driver
> > > 
> > >    It can be seen that the same was done in the past for similar
> > >    macros like PLT_CACHE_LINE_SIZE
> > > 
> > > v2:
> > >  * fixed typo in commit message
> > > 
> > > Andre Muezerie (7):
> > >   eal: eliminate dependency on non-portable __SIZEOF_LONG__
> > >   drivers/bus: eliminate dependency on non-portable __SIZEOF_LONG__
> > >   drivers/common: eliminate dependency on non-portable __SIZEOF_LONG__
> > >   drivers/dma: eliminate dependency on non-portable __SIZEOF_LONG__
> > >   drivers/net: eliminate dependency on non-portable __SIZEOF_LONG__
> > >   drivers/raw: eliminate dependency on non-portable __SIZEOF_LONG__
> > >   mldev: eliminate dependency on non-portable __SIZEOF_LONG__
> > > 
> > Just out of interest, is there are reason why the simple solution of just
> > putting "#define __SIZEOF_LONG__ (sizeof(long))" in a header file for MSVC
> > is not done? Should be a couple of lines in a single patch, rather than a
> > 7-patch series, no?
> > 
> > After all, just because something is non-standard, doesn't mean that we
> > can't use it if its widely available.
> > 
> > /Bruce
> 
> Yes, that can be done instead. I'll send out a new series with that approach.
> 
Maybe wait in case there is input from others before spending time on a
patch? I think the simpler solution is better, but others may feel that
removing the macro completely is the better approach.

/Bruce
