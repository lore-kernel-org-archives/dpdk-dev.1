Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E084BC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 13:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9819B40269;
	Mon, 17 Aug 2026 15:10:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5D7864021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 15:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786972238; x=1818508238;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vj13DG1Sz3ZGO6z5oKxtFTqGJmHpzw2G37I0FGZrDxs=;
 b=ABoaxghXpleoAAyPo24WMEeAjK0CIjrsHmYvV6vzJzAOQdLqzK+EbyKL
 r/pHVderMCu3EK3vjfrQzo4Gjqq6namlWtrtwKswlaSpGnVG7bRq+Js31
 qSgV/GtqSwCuYQqYlCwbUlQrzgKhxqUkIfYs8j5hE/AZ/U1i3mHBqacca
 rHqDLXem54brb3CcLJaWWPEcjcUD3G5m8L3TP6TnKIA5NROkWKr/NjdHw
 9mCrenfDaBMYfmlfEItiuFNypRvjrW67UAX5m2ycmzJACSzScLN18si/F
 5XV6/iQIq2CbBigYvQpTfsh/dw4QrlZmZfLrhKpohKKzyozgLE6VavqSp Q==;
X-CSE-ConnectionGUID: xCiK294qRHSwcQqmBx584A==
X-CSE-MsgGUID: bUD0cLC5RniL/heuycMgWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="74977649"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="74977649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 06:10:37 -0700
X-CSE-ConnectionGUID: k1fxCSFGSKylWddmypGt7Q==
X-CSE-MsgGUID: 5ELbStlOTEGRq/tCafJ8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="303150346"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 06:10:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 06:10:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 06:10:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 06:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQyqkVJ3WRFg4QBAQbJpT+ZXgyXPPTLTxz3FscyGfIcQcqWI1rZkl4JheawngAV/OMtoDCPqfKj7c3TUs+30JBgaFqSPnHSXvSkyNCkdBjxW9w3SbdUh4mmKJHZ4rIXSKGu8k6orV9lJE7EzCVfcLCBBM71jjpp3xpZ36bNyyRfufKR0nkDRh5TtPT4UrsEobsLW+ghBTyFNOepHlpAW9/0YO7u7wvAS2+0FSi/1w1zive12jInWaQZh1DSoBRAmm1QbC6a8DdiIYGmxOhShzRYOTATEze+BMhwCqoULxIT8VV52aNxL5UYtXfYCU3poreAaIXeeI7I9eZhcgHOrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uGeQ2QFVbXF5LvmjXRn3EPJnp1yIOxxhMn1c/ko80w=;
 b=UWLOkPu2/SIcNtS29nQi45O6hH1pDtW65ZWtCylntve3P7ISxSdkb1wfOeAsmR2p0AzWyarCKWb9w+ZqG4y5ZDpjoSBst3sXNmCzNVPkPc/462+0vw3wO7bEG9x2rMPaU9+KT6Vg4YUS6kAgfDm9iiyxRQww3mMPGYc0fHkKR2SZyqJeickSZTh9LuCg9bJT5tEB//zn2Sw9Int5Vm95QGcr9zBNVVFlKhXneW9AK3VgXXPIAGPiQZKvx6By1IM0vjgQwFT7kGeCHDA8aPm6lOcSmBpfQwjLpLk4/SPbm1M/ZK6B7VVjPZiTshaaLzPlypCfJLIE8TcGbYjMFd3Brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 13:10:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 13:10:31 +0000
Date: Mon, 17 Aug 2026 14:10:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] stack: introduce pile
Message-ID: <aoMIQo7y_DyafUDg@bricha3-mobl1.ger.corp.intel.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812134756.1829613-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DB9PR06CA0027.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::32) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ae4a98-716c-4c33-1f0e-08defc60ea2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p6EXGowsYnPZbMUH+ouoz0Edv3NYbr08auRG9iMZ8/nz0ZEvw6WRSS0InZYqTeyLrip/8NGjX8OTdN7F2vIGXBoUxQxISXd3EnfRwcfvElmNqOGffu11vG0kVq6Ij/9yj8VakOmDUfhm6ZhOSjfG6UhUuiDS756sIATyUPbiALO6OBXo1l+brKLmUazK4oMzI5PGBhW9AcOUS5C082PT5MYx6EhwumMA4dq5UXxWYK9IhuUAUyp0E2kca2URYRgY7TOyaRtB0RkgZzyohOGpFjnLPwpBSJ53lHQqoBCWj1AeMiEX9qY46wlaUBDkEWabuI8wwNxsJ7tYtXyfiMhyl9PWFSErwv6/wW2QQU4T1UFIgxlBhfHsy55stc8utlApTvxQ54iScRVtJr4cRV06kt0FkX8nhcu5iRMu2nI/k+87QX2s8VLdBh+tYmPqik2VZunM1ukPoTDcG0+cqZ5vrG0q2bUhCp7TogmLIW3Hq5pSjKEFPZ3CWGw7UPCM/x2QHJet/27G3sllxHeM57RZ89poNI4wsZmCm3lhYtw05DleKWI7jTIHWNoaRbacWnceMIIaE/oK5snshpGnhMvDYxQGgdsjIU7Qe239tANwVUSz2VxPqdelPZb7TCZDBpBV1tEor3cQ5uLwJws1zrfhxPNp9UoSHOKHEcGjW7Tj9C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pt+6bk4w90j0noCz3XN8lAC8tMscObvFRvVCLWEWwmhE6GLMg42MQ6dYW4?=
 =?iso-8859-1?Q?cLou+6Vae1zKs4V3X1vBdPnPA4yLQ+UZ9LV7SiRzbuUSKgINA+lJkbsfA+?=
 =?iso-8859-1?Q?guZ90aLSpKvmUve4L1yYdrlHmjYgNjCUYvuFQtZ9eH2IvH63NvzocJ7+s3?=
 =?iso-8859-1?Q?DLqC2qzaASPDQJB3T/+oFbeJw4fy+A3nrHZN58u3xoqq+KkbuxfNtEhJJA?=
 =?iso-8859-1?Q?M5ttObuPZ/vvPAEoA0+OuX38FhOjWdbkRCNutw0WWE+zZ747SJTNCMHQU5?=
 =?iso-8859-1?Q?kpyre4cWWVFeOLTjhBDKCzJ2VbeyRnwQNQhW3w6pFjD5yZXTHbAYMrjLVZ?=
 =?iso-8859-1?Q?UI2EzS2OGg/y2BvFr+/mor2+aDVS379UOANSOtmVAq87hWoKDY3+G+H4IR?=
 =?iso-8859-1?Q?Uk+lB154dzKpvHCIzAocRgRhbm14DY4HqbVERJWe/noQlQ4yVJye2rpVxC?=
 =?iso-8859-1?Q?muL4aIZbnRAkthh36hK3nhsZ+TLxVcvYQmzUQHolRgt52CFm74m/J4voO0?=
 =?iso-8859-1?Q?j3m9btFzDCvp68FTRIB3bdQOi9CfEUNal7EGXKsKfScgJFINTw2jQpX/H2?=
 =?iso-8859-1?Q?0oq5tMeTlzAkaLcGvmf3gU/mWMc2O/aVk9yB7uN4vofrFiXpnb6WXYbueD?=
 =?iso-8859-1?Q?rX0Roin/3ID1AS+FxXLWy+qSwqH4RgD3314q7KmKDxw/26i4db+1iX/Iuj?=
 =?iso-8859-1?Q?s6gkRrGsz8O2Z4nvVpSjKVuY6vGGBRfu9JaSWiyJ5+zmpnhjxdO4eE2hCz?=
 =?iso-8859-1?Q?s7I1CvY98190FeiluPGWrOwzKL1C08eSwEZlbfmB5Zk1XYeXPfYeg7edl3?=
 =?iso-8859-1?Q?zn8MDvu/agFEzaHz2mvxl+9i6+dbcNwIF+6b6hXRkWUe/NunQTkS5fxLPE?=
 =?iso-8859-1?Q?P3N39fuHLMl/MaXg2XVwsmXaBefuO+OlfIIQTYSI88JpT6Bmwk5li7TyL4?=
 =?iso-8859-1?Q?AFkoheglvyPUV852AlEdYJnxnTSwN76VdhqAvKVlSx5FZESaULUilekfyP?=
 =?iso-8859-1?Q?tCTxd9Zraa+ORn1yF9LpXJdiLLxdjETCTyr6w2bfHS5h7cYXV5mg9udWGj?=
 =?iso-8859-1?Q?HpbKvHL8rkhldzQ7kSAdCICFD/qhCq2ssrMkPe0jb3sF7UyQyH5Hmn7psH?=
 =?iso-8859-1?Q?xgMt/l4f1tzJ97g71/rG/vASO9eLEvvtVIw5PtlxhfoYv/uzRznCpUdw1K?=
 =?iso-8859-1?Q?XiopHKWnUAeZbCRWTxdvae/XIxcP++d2oD9/jcT0l0jLRF40p2mBbc4oWB?=
 =?iso-8859-1?Q?mwevzGftsAS346dOFwNCLnB13vdRh9M2jMvSigmqFIpyg7FFm3ZOmEZ4h1?=
 =?iso-8859-1?Q?16Pbv3kZGGQ9wB0pv8qNmeDtsAvsaoFMzqFPJ2BC1Ojn1iMVtrR4/jJGe0?=
 =?iso-8859-1?Q?gnG4z3DsL92dik5pUTjXTcl4XOQYG8OYyoKBbTxuHhtgGtEmDlYlLN2ZMQ?=
 =?iso-8859-1?Q?VvnVhb2QTCHXHqa46gQsHXY18tucf8KW7pQOFKKEyKg8wh5JUruE9NPj55?=
 =?iso-8859-1?Q?iDkjTKvFeqkJtSf6+NaoZ8Ts0tjyDX64/nm14PAXWZb404JGNd1cXUyaFW?=
 =?iso-8859-1?Q?PFAabfAGckwimahtMGrSFnOkRd8euzBcRJnIyqPKuhJKubcaKzz0yJd4gA?=
 =?iso-8859-1?Q?G4ccmcV2cNmDH2xW/XeQNM9gaVRP1t58Ih+GRZB4dRMi5ix8aTmXpdFUzd?=
 =?iso-8859-1?Q?n06zHEhLGdkbDuZwjUkSsR0q07W31KhJMO6zu9h8QEETp6Yc1clHuFvXuQ?=
 =?iso-8859-1?Q?7eHH2p3lQfCObWMe0+7ru9kF9aBaOHU4diAPvaUAWUdgmkaTUBIC2OU/AU?=
 =?iso-8859-1?Q?vLd1RhzZTJe0VMRhgFejJU9xZtKPphU=3D?=
X-Exchange-RoutingPolicyChecked: QLGOTOI3gU20fYb0p7ABXMulYIUQhWft5ujKpo6UqB3H+AReH+k5kfrrYGvoxF86t2UNd6h0nyH3ztAp+8fhN4yTpwLqqsHkEUJbXm4XfDERw4hfcrhbHrB+r/5d9ddAiKOWCswTYICVy4gWG7ffUr9hhUc8EAsjO6kLCQjtD6LAssfSNpAgQ7FoU/tx4JPChePW4Yjo65ZzXYQc9OVEaVSeklYzclDDp1Y3HLGNqzt8ZPnJwpb5yWaEWfE/B3HxAEGS0RzZhNRe5uV/yWedT5shQFrXD+PmUS30LpBKhE8XxScwDk3xINIuAwL+nnOt32bRmHSdRRTQ/DfbPjZvxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae4a98-716c-4c33-1f0e-08defc60ea2f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 13:10:31.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXxtmN3IpG1Pdsex7TgRDnS56ZuuZLada4+mVbatgd9vhOvDZ2MXqhmwMfqrIKAJizpjyXV6e6rpElW1/XN8yGuTyXLamUxbKPjAO244fSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
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

On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Brørup wrote:
> Added a new high-performance lock-free "pile", using the Stack API.
> The pile behaves roughly like a stack, but is not strictly LIFO.
> 
> The pile is optimized for pushing/popping bulks of objects, which
> it does significantly faster than the lock-free stack.
> 
> Pushing/popping a number of objects not divisible by the compile time
> configurable bulk size is handled gracefully, but not as fast as
> complete bulks.
> 
> Performance examples, stack_pile_perf_autotest vs. stack_lf_autotest:
> 
> On a single core, pushing/popping 1 or 8 objects is similar speed.
> On a single core, pushing/popping 32 objects is 2x faster.
> On a single core, pushing/popping 512 objects is 10x faster.
> 
> On four cores, pushing/popping 1, 8 or 32 objects is slightly faster.
> On four cores, pushing/popping 512 objects is 4x faster.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  app/test/test_stack.c               |  71 +++++-
>  app/test/test_stack_perf.c          |  15 +-
>  config/rte_config.h                 |   3 +
>  doc/guides/prog_guide/stack_lib.rst |  67 +++++-
>  lib/mempool/rte_mempool.h           |   2 +-
>  lib/stack/meson.build               |   3 +-
>  lib/stack/rte_stack.c               |  18 +-
>  lib/stack/rte_stack.h               |  79 +++++++
>  lib/stack/rte_stack_lf.h            |   1 +
>  lib/stack/rte_stack_pile.c          |  35 +++
>  lib/stack/rte_stack_pile.h          | 334 ++++++++++++++++++++++++++++
>  11 files changed, 609 insertions(+), 19 deletions(-)
>  create mode 100644 lib/stack/rte_stack_pile.c
>  create mode 100644 lib/stack/rte_stack_pile.h
> 
Looking at this a little closer, and thinking some more, here are some of
my further thoughts/ideas on this:

* For most cases using a mempool, I can't see having non-strict LIFO
  behaviour being an issue, and there is nothing in the mempool API that
  makes any ordering guarantees about what buffers get given by get/put,
  and in fact we can't make any guarantees because of the fact of multiple
  cores doing allocs and frees. Therefore, for the mempool driver, I
  believe one pre-emptible implementation is enough, so therefore the pile
  mempool driver should just replace the current LF one.
* For apps which may want to use the stack structs directly, not through a
  mempool, I can see that having defined ordering behaviour may be
  beneficial. However, if multiple cores are involved, then we can never
  guarantee ordering, I believe, so I'm not sure its worth trying to
  enforce strict LIFO for such cases. [If you need the same elements back
  in the correct order from a core, then use a regular stack without sharing
  it].
* IF we decide that we really, really want LIFO ordering across multiple
  cores - despite the likely random ordering of allocs/frees between those
  cores, I still think that this implementation should replace the LF
  stack. If we reverse the order of elements on enqueue (or dequeue) then
  we should be closer to correct LIFO ordering - and fully lifo if allocs
  and frees are based on multiples of the burst size.

I suppose for me the main question to be resolved is - do we have scenarios
where we a) have multi-core operation on the stacks and b) absolutely must
have strict LIFO ordering? In the absense of that, I'd very much be in
favour of replacing the existing LF implementation completely with this
one.

/Bruce
