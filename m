Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D33CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 17:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45825427D1;
	Thu,  4 Sep 2025 19:18:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2D8C640275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 19:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757006302; x=1788542302;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TdDDIMtQkgz/XfEqZEvZsdraEy7Engh3XUmROIrDD7g=;
 b=neX++O3Q4eNIFrFhVrHWMA3ZxZ0Vbx4Jf1kY4IY6CWHbzmCBvHqlr3TL
 /fmEwqN3DbVP3hxpVIGbh/erCJYKf6WhhAnuAS6RXQZQX5vsJoqsRIt96
 bvR0KvH9WT589QYl8/hCajbQDQhByuE5DR++Gi2TResU2X6x0yQD9BZs1
 6kCzi2L2pPBPme5BsK+ois2v2A1pNrzVU8Z+nKJPE/bsW6VBZBdBETGqo
 ZjFmN7s0RvYZdKARnP7e0rHI1VjRNpC/7E0EFLm4xtI+L7BsdyGhcC4xZ
 pHD1m959P6EDD8Z+KtL86PguUhVqQcHLC1iI6KHTAYU1xx8lGALVCFACO w==;
X-CSE-ConnectionGUID: 5T4JyWiMSUCgS/n+qO//6Q==
X-CSE-MsgGUID: qr/nDxrsQNec79rdesp/Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63185689"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63185689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 10:18:21 -0700
X-CSE-ConnectionGUID: MEobrXLOQJO82EXeAgre5g==
X-CSE-MsgGUID: /2b4hmMYQsWZ9QuqGBBkig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="172388890"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 10:18:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:18:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 10:18:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5kIpxIXg5GhJMz+uwDIJ3Hoy5SfEHd/J3gyRU2xL4qWQ6a+38Fz2m2v6rL486dmN8XR6cIaRpgCRi6oVD/LuKFXk6WNqpRh0iWwqwyFZbjqF7++Jj11uBZQZIa+6Kchw4nPBUTh+jx1prRrqxpSIhmZhmMI4OIgvx/JReEhHt5rcMmNba6IZtdF+RQlUwN0u8lfa4d05PotauXReHSmsieN39NRRhRKu1Utu7ZAGNEKTtDr+ecQVVH7A4GKZ5agout5zds77OB/FldR91BZjDgPJAKpPsRu6JV+FJTkzqMIEUH9XsN46MFZY9y71LHb6PFyjDwR8VX+zJbKYDPEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+zOcYkUWHh/vLnb3yfFqCofqDfj90yNXHosdxHpd48=;
 b=NNwVSVR8hiCs2BbrgKxycDeFh3BZ5FWJDbJKP/aIsfYu/kLHwmSBPKhldRKRpm1Rlv6v1VqWa57x08wP/DXH8CFpAyxFvaZ2Ts0Jo2o35ZW83KcQVCOWq9SC1Y/PEWqa1GFTBZKSRjxt2nUtMYtdi5s8gU3GUee/Q+zkXgGYTu4dXXqI159ckYnTkBdOm2fjeTXus5cn0pqt8DH0u/LpqLrgvZTTuRPY46PjR9u0EioUdQVqjVfaO+1QN16ZX9uXNSkGRf51FS303r6XcJ5ppVrAGQCFqKFhq3ZS4XsY8xCfFXCpGmbb5+4lpfxi9TelzTOok5+0vehxKriBTRw9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFD25B21260.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::856) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 17:18:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:18:17 +0000
Date: Thu, 4 Sep 2025 18:18:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] Fixes for iavf Tx path selection
Message-ID: <aLnJ1M4jt8OM8HhV@bricha3-mobl1.ger.corp.intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904104440.2167205-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0240.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFD25B21260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b51bd57-d6a5-4417-1a5f-08ddebd709d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1bC/Mr2nShLDvS6WPwIOuEOWtGBX8h0klxh56eDG2R0WGq492jKAODpd7iSb?=
 =?us-ascii?Q?N4ukH3JSy2cavpXnl1PIRxu1j2vUOp2FTt55opbgeI7RhWV+AlmTgrW5T7Kl?=
 =?us-ascii?Q?guYNPxP5j5vXjnle4VlVycUQm/6AI/MOA9zXU8LvucJHztTlFFXyvc8oe1Pv?=
 =?us-ascii?Q?lhyVs4QkMQlq0UVw6FXMWIoJa0Npc6fJTsjQ+lSeX2rLogrZ8vFDaQ9ilLLI?=
 =?us-ascii?Q?Iy6U5vmP8xjhU3F4i4L/mh/ibInRLr8FI8kiBkxQqsRKru0BTWQoItls3TXJ?=
 =?us-ascii?Q?JW9zVqzM/A52NIfHwx2bUMXHbOGaNs2QT9TcX3XHjc2bqyFC1/+e5oGT1Vvl?=
 =?us-ascii?Q?P6L1Rr5WLan0O4YTcGTFLlf8JdFchLziw3o7srjQbdTrdyQytMz2ka6LLiLB?=
 =?us-ascii?Q?lbjxDEf36jiXQxZRrcqdErRorCesSBZ1zPZJ02PmIvo3U1+hRxRL8fqXPACW?=
 =?us-ascii?Q?AdH5PrIhKrf4GYtQrNkb3djbLcXtOPUNc5bLrQ1Iy4pawksI3p83YiJ7RsuY?=
 =?us-ascii?Q?j9keKFRIGdy3BF0AIZ1dAknjXAdhTk2d2uWF64nM0re1j0Hn5uYQiR703NnE?=
 =?us-ascii?Q?ls4BXgB/cbYjIsur/kg496AU9zxGmrYcwtSveoWEQImD+LmPb0MJgfD6aSgl?=
 =?us-ascii?Q?Oq0nERBRAFoNtE59BLZmiF5c8PG2oBX2EhXRmMsYDP6N/BU32IxEjLOU4Bbe?=
 =?us-ascii?Q?1giUZJRLyFgYicr5DjReut8HSmhHzNxYi5Q/VdAq8YE4kORK/wBBMx9H5jzn?=
 =?us-ascii?Q?VCqZmb+tGwPwsiF3BX972MpZn/Hfbgqc2hPEKQzhNR2Oxpejg8RjLfQA6ZcX?=
 =?us-ascii?Q?+Jc3rU4covZWGfD9l+fno9QRoK9HxG3C8TB/JxBxgTvsHfI9KBvjF9cnRYjG?=
 =?us-ascii?Q?oziLOsAdL5NJXIcipaHkPXIbhbLNLHD60tKNuexO8JfoQhJIS3+w8mkCnMFD?=
 =?us-ascii?Q?NzKq33EQwpz93RLakmoqnQfr+dOJbZ5HWeaUnflR0x0MXbzrM83tv8c07rA3?=
 =?us-ascii?Q?LhiEYhQbaCkVj6BQBksHWM+wuPD7XEnKJz388/rFZQ4beltlNYcYxruGkb8t?=
 =?us-ascii?Q?bPtzTYjBEMq9vjOMBzx20qW2i+Ivm2ztT9LIvTjLpCwbabSYN4S0Yyr2RAqC?=
 =?us-ascii?Q?s+DkS1jN8PRw8AG2Fic9bfabinlZzuNzfINimyCs69psOAjVvOk7XlVAtaDK?=
 =?us-ascii?Q?tpzi2FhtGZEOxeg0LouihxyuekTQ3m5zhH5M4QhTbPnPO29F7GMHP5XwhXI+?=
 =?us-ascii?Q?mlteTnIvr6YCd22BKZCTD8gJctofLDggfG03O/6EMxK3SJ2O/UKHzMaCtWGS?=
 =?us-ascii?Q?Jc3r9H8IM932R9pSVjdabDeQQYVvLJM8P+V7ltWacyqcnewSNhsSN966XvBS?=
 =?us-ascii?Q?MERxabciAPRJNn64hy+YMjXKkpVG8VJhVXPGcmBl/zHlyWrIvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?58hqXstr8N2aSHpovwzdTsO/FfAokeLd7LQgwTHVqaqm1qwpcuN1zjXWa/TP?=
 =?us-ascii?Q?grg+hHjQ7RyYAfqT9WHt213jlg18pazEXTW/yH2a35oz8+daaGRXI4ZJr+Zl?=
 =?us-ascii?Q?eHNrLJlDkXpWFX1kFZ+WURFB2butmSgZdvsaIdUoaYNwkAsKXqJOWmR+eIMY?=
 =?us-ascii?Q?ITyrXaonL1CEm3lmB2hn1de/BvRfnkXCCoN0s68UCvMHWZiUZdWJC6rYfCRx?=
 =?us-ascii?Q?5FefyihUBfiv+LNeK7u5ScVXiqd/WO0wsCKQm8soCr+ndUgZIv/XQqsFlh29?=
 =?us-ascii?Q?WXXw5LR7GIN8rKpvq3EqAEuQyXFeTaRBNDN9lntIbxa+oHCpmTv6FU13VhMe?=
 =?us-ascii?Q?+T9DVcfWV1Jh9dU8D0GCvpyICzjOMrKFnANK9xm25Ho1SMC0o9bg40xiI29/?=
 =?us-ascii?Q?SiHbFAIxez7s77W2vGYwc+wy622DbTDDg42IZbFYFdoVtRPZTsjdW2GxyFfQ?=
 =?us-ascii?Q?pUofWYwVJAeqPr8Qk85wzJWDH+elKG+J5f1zJ+/QQOadQAYsGK1S8FICEhXS?=
 =?us-ascii?Q?w2l2CVo8CF2+CPEITwEsNdUEWnzRai9NttCjaiyszJ1fgCb51OiSCSPgDxN7?=
 =?us-ascii?Q?f07UjKslg/8v4k4yeMhRlfAlb7mH2jdn/LfYeg+tmHUGeB3/f/eAnZOIKZBx?=
 =?us-ascii?Q?QKxVMhzvD5sLT+sOd102ws3zWsZmvl2Ut9zAHGPBUHfyN9Ke6tzNc389/ERy?=
 =?us-ascii?Q?KOsu4zusuHmzLHfHTSYBKwolMH5beaWhO69UyDi8bOzqiHQQIe3s2bw8Cvle?=
 =?us-ascii?Q?pM2Ctl9AWwTQpeu+R6l69Rn3f7heHRXV7r1pybjYMJQ0yjWAleojqzeLG5QD?=
 =?us-ascii?Q?P2kbRAPn2X/gf83IblBlOeQsa2hA5PMXfWEWtDdRtzsGn4lUKEI5ok1uE93i?=
 =?us-ascii?Q?0na0ChGkEab8uINbEKAnWr6wKswUxOpzBCLDVG+5mulaEO4Ys5zMPYns7l5u?=
 =?us-ascii?Q?k/miFg3k9zPKhxxyAzdDFzvufQnvD7hdsRH9vr6Bu+RBbl2OyCWp5mxDDJUI?=
 =?us-ascii?Q?CvyRBJ8JxtK931CsLK4dO56zFcoaPDGnTkHDZiIw+flQ4JkmBtd0GWp8Z2WA?=
 =?us-ascii?Q?J7NkTFFMMIifjGhyOZfN1XWAz1wYuA7L+WOB0+NE59xZq8bn8ZwSVxlil5NX?=
 =?us-ascii?Q?4mL46OrNWD9YtIRND86KwOcgCXdvHF2sj5b3CV3Dp/rR2aXkhRQEtwpW3wEI?=
 =?us-ascii?Q?4qCItN2WDTb4Yr9Zv3wg+qsoLYOnfZPI+eyvVoxlaBwsNfHuacyaTVANezxA?=
 =?us-ascii?Q?kEjYEP5Y+JUEsOIGycrIXJ1lSWkf8qarXiOfN4OFpBqlIY/y06KdqTFqCXFB?=
 =?us-ascii?Q?sQo94DWPf+34McG7yk6Jgg4q0QfzSJ3FY3ceIz32OPvuKreq6aAv0GpkIka7?=
 =?us-ascii?Q?AmX5oNNaKDCND/HABh6EtTfYfhVZmFFJng6j8wa2Ro/GSDFeZDOn7yNLhWUz?=
 =?us-ascii?Q?aEi765f84JiKjFi9TnQQ9BJixlDMaFLHKlG+1iY94iaRJt9Q+qYqszP4tGQN?=
 =?us-ascii?Q?rlD0jNFkZ9PMgxL3ZxqvZLfV1HvNiNc1ChAra/BfsQMg70PgTX2CvllGHYUn?=
 =?us-ascii?Q?A4rm0NeZzZF1kSmQofnGsJyBBOvfe/FXsK/wloXFPy4nsA6CjrTKCtB6b0NR?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b51bd57-d6a5-4417-1a5f-08ddebd709d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:18:17.3344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1jLbLKbiAR7qLpJFc8KYhGeeeN+Fww/taH2gtui9SZ9/o4G5kg/39fWddskLIPBbTZ+UhHaBaqUiU+QdWklP8bVmfoy5HdkqmhpYSWIJuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD25B21260
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

On Thu, Sep 04, 2025 at 10:44:37AM +0000, Ciara Loftus wrote:
> This is a series of fixes for the iavf driver concerning Tx path
> selection. The first patch fixes the logic for selecting the Tx
> vector path, which was recently fixed but broken again by another
> commit. The second patch updates a log and the third ensures the
> fastest path is selected for VLAN offload regardless of VLAN tag
> location (L2TAG1 or L2TAG2).
> 
> Ciara Loftus (3):
>   net/iavf: fix Tx vector path selection logic again
>   net/iavf: fix a log during Tx path selection
>   net/iavf: fix Tx path selection for VLAN offload
> 
>  drivers/net/intel/iavf/iavf_rxtx.c            |  4 ++--
>  drivers/net/intel/iavf/iavf_rxtx.h            |  1 -
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 23 +++++++++++--------
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> --

Series applied and squashed into next-net-intel

/Bruce
