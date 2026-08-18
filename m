Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C394C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D935C40611;
	Tue, 18 Aug 2026 15:42:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4058540294
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060519; x=1818596519;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=77Z9V5vL1JAD+2oDJ86yzbN926oTni2oSK/JkdUhlkY=;
 b=VyRpDHlJ0YvOJJUmz8QYodjNc1WOfn0o5duMpMYFDUoqPChMsX2+TIz4
 +iIms1fJWSo3/Z+XYBOoJ45cS3j9vVMysOOMs7XhPtuYZy3sjZj32ebhj
 +OXE0ukYGGtJNZYkseCELgSvCvR1tKJVxbPOWuVqkQ9Ir30YD9WaMTbe0
 I+pG9Z8s7ksAwcniQF12KTxIg6zXl5Fexr06J5uFDGz6aKLu/xCiWpJcN
 JKWBxhfopoJKa7uHpl080jpbIyinW5RKV8ZtkWYT6PFXs4doRl41oqcDl
 fL0yxpdp3/dwimNmxRtx8qJQrXAGDvd+iONXstAZgDwUVU+3PBK67w9dS A==;
X-CSE-ConnectionGUID: fwyBhHQ6TM6C1H07T0woOQ==
X-CSE-MsgGUID: EmC99TcwTXKKGuTGlGCEpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98219776"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="98219776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:41:58 -0700
X-CSE-ConnectionGUID: WYyZg8ZUQumc1Ra8BxaphA==
X-CSE-MsgGUID: mvd2G8AhR5aPRDZvEML/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288738949"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:41:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 06:41:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 06:41:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 06:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pan6bnTSAL30JqULK86zkln2M/kFtY7RRHcMbM07nnMwDZHlqnSafTG+STRjKOGLIrlHR8WwRKLXLPwSj1IFvuoXvv8vUSSgxN/SUlTzUqIdrixdjGBKb2pSH6NkNIw+CyfRBuDe7k/BaWFPPzZ/xppm1xfBUoxziwbehbF+jIRUgkUxiiLg1nXHzJH6G9kA84oWqUhIAlzMirvr8rgz9o7CZiOxBDAC0C2K3tK3gvhlTHAXsCmcF6LzhauS3CwrbP634p1KfQd9A0E4A1qTd+/UgRo7U8Vrt+Yi56Y9Enq2wjZ5vXEp55Rc4N/bf8gADEXaGDqTngkS+++uPLDZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maEuN/8VTFjXWZgRxHxR5pOLqsl8SvpMQXvAI0KyoL0=;
 b=q2jRIf1nbZuOPwKM/+M6YRzx8FZP6GHMoEgkI91PKPZBzLJqEEoGbfox6dQjV9C98+gCFOq1IWvbJ4r/tA/QgT0x8LRh6jOU6KdltxQLd+BYisyosZ71+JZMkm1BEOQGaRXza/RCHp/t8Y9OB9kDOcWSlUkxu9sY0cuKsDQhP83zphZRGx4Hl0ZXMV/KJ9w3oIlqRBlMZ9TgC/1BzcO2Gbd4zqWQpXRNehb5Uop8hLpTYKI7L6dn4cm2GmODspTviRywxN8DxhjYxpxQwoxJ0r84OryTKxHHJy87b1L3++4VQiPdOrWTyGfO7uOBUfNtrxkBgYoktWqdWtYNw4gurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB7724.namprd11.prod.outlook.com (2603:10b6:610:123::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 13:41:51 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 13:41:51 +0000
Date: Tue, 18 Aug 2026 14:41:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 00/39] Rework EAL configuration
Message-ID: <aoRhGpGFxh1-22IN@bricha3-mobl1.ger.corp.intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20260727163007.60e4a2dc@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727163007.60e4a2dc@phoenix.local>
X-ClientProxiedBy: DB8PR06CA0062.eurprd06.prod.outlook.com
 (2603:10a6:10:120::36) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 0824e7da-55b3-4475-0546-08defd2e7525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OR24nO72XXrVaxjcIsN/DEfW58757/SULrAPW2fj5tpfHAb+CbXJUP6sV08EopnbfVfEh2rk/hbxgK5JUiiMaQHEy/gGJi0HgsmtcS7vMF9t7ayptydfIS5cMyGGlaHlvq+74xnU9J0qyYXV3/ysUvZotJi9gxIBCIkwA2BWAQQwRLolhGlJm9KW5JGnNoYIU9ufuCZ/Ho+2eWXlOCwPfCi4Usq5bGGkZIjcHIru0A1SSF2PBK5krlHjcXlfqlcV3cfV/F55bFsQcb/JN0H0hBpP98qqRXHtEWeTC6Lnmg9GHxwdsuwNl2lgUlxW+RZOg/zwA5K001tqPFuFslRsCuRL321h8Tz/wmc8UHHF60sC74IrSeymxZUTyftnfGB2yg9j8EZB4/grO7825RsXBBdDoTwfUUIXOB+PgJM2CvStTpKC1DOpa3t8oQY6gTHwO3DJ/yME8VcCGRbSCR4sBxQ/ACv7TostaFutxY3TjxjqWsD7M0c+M2+acArVABjeDE69ZS+vMAgVLUTQd+3rLDr2K+0Scw+HRxKqhZPQ+GhGBUZgvxqvvK0Od2XTWf0D2edyb2yffmfoGncpkW3Y6RTrgtaDh/4LxHGr1DLz7ewjYuUGev48EJPmutMSB18w7tnYvR/QOh3ZVcXnwY+S/3+08mElWaUnmYoyuVpHyBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ymvbx3w4HsRntuA2mT6yIg/xB3sSlhPpMdHu5L1CRyMhQMXeSwG6oOA0x1cM?=
 =?us-ascii?Q?MNOUjOeQEQHnq4RGnpxuB3e0h8FQxnnNgcr4O+/b58vSOlcytpuuTOAiwHm8?=
 =?us-ascii?Q?LkLNrZk4qqdiD5plFbschLG6VZKy5BHKoGkSbmBYfjak6wp+Z4hFqBXjM6jz?=
 =?us-ascii?Q?6iihXkJofGRMkZE/ZRlIGI2ZTBAYWrrzX5WYCu3UndA2P7dmp5QLGQWsfj7N?=
 =?us-ascii?Q?8eUT2Pauf1wbf+VQYxA7Qe3oQZaEmgMYcXTtah75Yz3B36R/Lk44AJE6tV9b?=
 =?us-ascii?Q?g6sTuEgHVKLJ9BStZSIUmPUOPtO4h34739ZEUaBF7oyWDOxBN9uqUv/8Q4r0?=
 =?us-ascii?Q?+THr9LR7oKKxd0JkV9md/sYifX3xkhL1wkgWR2DOK+u4QegaOvEfCtJPEwAJ?=
 =?us-ascii?Q?ePMGChtSvn187kzDCF4UDTx3fgBObBR4V1TLaGYcb8HvOxb5LaKgjiQJh2bk?=
 =?us-ascii?Q?/2X+ZIk7oIsMZ06rZlUxpkdIALD3J9/RmSvNyKvRQ8Anleu3AVujUsFYvxc3?=
 =?us-ascii?Q?qk7ioLXWGxqfo2gVTkuzG4QbVh1pWG+7tuBzGPAu5W6OnPwM6GaobPkD+cQp?=
 =?us-ascii?Q?xgfdjCM2xi19+YL77jZyM/5IYwmM6Mt+B+Dv+j6dNC6mKaImxsg6n4HavwQY?=
 =?us-ascii?Q?j981L8AGtnAGC1Fm4/c2MlvOHeSdQWPqexE4oEdw6PjRmhh5TasEd3GNOHO8?=
 =?us-ascii?Q?3rc8YdfrBdpiMdnZvT3ppXGRl9DCnA11mdjpGyOYK/qzfWzrrCZXuO+q1r6P?=
 =?us-ascii?Q?Kzp+pcS9a2s1SfUKLNRrTSd7Gn4lBy/4p3h5uz7nT7ssdXYfM/4sYdqtk+NW?=
 =?us-ascii?Q?gYk4uOwNScrF7fvKJNb4ADNYY3QCyU4TQsj+F2P5spVsxDx21HCNeK3EmZLI?=
 =?us-ascii?Q?4UzW24YLrYRT7l1LqitW+kP6Zgymujw5bjTVCHEN13o/1lH1qh8RGVtdJgxf?=
 =?us-ascii?Q?cnyJ98safMe6VqKR962Y6iXVYigoNKPTUe44ZOMkvs1ejsq6HIsCFgugtcfJ?=
 =?us-ascii?Q?y4cDoF2D+RmXZJfJkZSWYEUlgkMPbXQGj/t6v6F1LLv/HwqZRCNiPiQ0tnsc?=
 =?us-ascii?Q?pw/TdzaWrf0l/vzvPrO581XHWIbFlp+NpkfeUL3T7WHGdG4qcxvxDrT8x1QT?=
 =?us-ascii?Q?//2QN67cj9VQFZdIjPk1TatbYtxdZphv3qdjoOXpw50hWIFNPocj2x9OBHxH?=
 =?us-ascii?Q?7KF2TgJ8v6jN98xbBGmMDlTJLYO/8kzreyNOtyugBg2GCzf88wqBuVRgnh7m?=
 =?us-ascii?Q?4xrIiL017gXZmJOYrZmiiA8mUxqcTNTc67AaXG/VCbAxVgPiOwd2b9Y4Pdv4?=
 =?us-ascii?Q?mMKAeWqjNUAw7G01LCnUyDlTzj+I0uF+7mLv7pkSczByt6u4nC6OeX6j/hMK?=
 =?us-ascii?Q?AUW5fT1Fcuk5AkgM18gfsD2RA48tAIpfZOd/aQfV187kRxchUcw5XuxLjwm1?=
 =?us-ascii?Q?JJD92mhmEvfiVYAZFG4cge/AwivXcc4PzZI82KCSrD7JklQ2OUfCJwsUOxMY?=
 =?us-ascii?Q?jey7AXIq/Mrk8jG7boCKFUAv8h1Tc3g47/3MIOJJFiazfbEkBiiNkq6X3YbW?=
 =?us-ascii?Q?IuzbNNmNV1vadhlwmVvbVpNpM0PrsO/PMd2ss5j8dT4glJLN7vu6I9cwl7ks?=
 =?us-ascii?Q?P6+XjjPFSP+95HtgAoN4MPF8SBVLCAj+FvlLRSMDK6RkfcSsXDojt1Anho2u?=
 =?us-ascii?Q?Tzz+G6uoBIZ1GCfY8XtKsXfQFYYEXN03g9cCfkvxACtKis8sCF8qmMnjOmku?=
 =?us-ascii?Q?IxbhJoNOSen4r7MpCBvtPPix56DGMzI=3D?=
X-Exchange-RoutingPolicyChecked: BYU6lokf7X8u0b9u4kLW1dzO6YDxxWgCtUxVbU5GEsk0bFkwUXE9gQ/BQyjfwkSzfD3MPiq+kdV5UEGFGIFwEIulRFT0rSw37N8OzesjZhcqM9EEVsSBE5grS8ttalv5aLdAPwlSPJSPd9yxSG1wglZh2e+pngaV+VqZGXR7podQN0WG2SzFj08fsHsFW2a8Ldn6IX6JRl6rdJlwZZYigmxLJSxjpJqpXLK9NcmV4McdPawWB0+Nh93ozlhBrXvb68Ey8NMBTbzNcUDGBwftUnHId50dgSUtZMeT4IJ12tlZeR0yMEIwCRt/yjzWUfpauXt3GDjQG4s3EqKUKCjUUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0824e7da-55b3-4475-0546-08defd2e7525
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:41:51.0765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWsrOTcW1WEuAC0Ba5IR7I7WELAfmxfWVYy91OGf0Q62Rr1Zn6GR42OqyNJhUBlhKvcFZ4SSaB2mmJHFicZ0SZoeILJDrlrtm44kRwkZz+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7724
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

On Mon, Jul 27, 2026 at 04:30:07PM -0700, Stephen Hemminger wrote:
> On Tue, 21 Jul 2026 10:45:08 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > This patchset reworks how configuration is stored and managed in EAL.
> > The existing "internal_config", "rte_config", "lcore_config" structures,
> > which sometimes have arbitrary separation between them (especially the
> > first two) are replaced by three new structures with clearly defined
> > roles:
> > 
> > - eal_platform_info - contains the raw HW info for the system, details
> >   of CPUs and hugepage mounts. This is initialized on first use - even
> >   before EAL init is called - and is then immutable, since our HW should
> >   not change much underneath us. Its early availability means that it
> >   can be used to sanity check the contents of the other structs as they
> >   are being built up.
> > 
> > - eal_user_cfg - contains the config settings passed in by the user. For
> >   existing rte_eal_init, this is built up in the arg parse stage, and
> >   it's contents verified against the platform info, e.g. to check core
> >   masks are valid etc. Once argument parsing is completed, is also
> >   immutable.
> > 
> > - runtime_cfg - basically all the runtime settings that need to be there
> >   for DPDK to run, or which change over time. Largely combined content
> >   of the old rte_config, internal_config and lcore_config structs. This
> >   is initialized from the other two structs by eal initialization and
> >   can be modified by EAL at any time.
> > 
> > Once that is done, we have a clean separation between user provided
> > configuration and the rest of EAL, we can split EAL init into two parts,
> > the first of which parses cmdline arguments and then calls the second
> > which takes the eal_user_cfg struct result of that parse and does the
> > actual initialization. The longer-term objective is to have other
> > first-stage functions that prepare the user_cfg struct for
> > initialization, so that we can move away from argc/argv as the only
> > method of configuring DPDK initialization.

<snip>

> > --
> > 2.53.0
> > 
> 
> Ran deeper AI review on this and it found a couple small things:
> 
> Review of "eal: rework EAL initialization" (39 patches)
> 
> Series applies cleanly to main (9231dc7). All 39 commits build individually
> with -Dwerror=true, so bisect is safe. Findings verified against the merged
> tree rather than the diffs alone.
> 
> 
> Patch 02/39 - argparse: check for range overflow in CPU lists
> 
> Warning: missing Fixes: and Cc: stable.
> 
> This is an out-of-bounds write, not a cleanup - CPU_SET(min, cpuset) with
> min >= CPU_SETSIZE writes past the end of rte_cpuset_t. The introducing
> commit is in v25.11, so it needs backporting:
> 
>   Fixes: d78103fb9488 ("argparse: support core lists")
>   Cc: stable@dpdk.org
> 
> The fix itself is correct and complete: all three branches assign max before
> the new check, min >= 0 is guaranteed by the isdigit() gate, and min <= max
> holds in every branch, so the CPU_SET loop is fully bounded.
> 

Added in v2

> 
> Patch 33/39 - eal: remove internal config reset function
> 
> Error: removing eal_reset_internal_config() drops the lock_descriptor = -1
> preset, which can lead to close(0) on stdin. Linux only.
> 
> The deleted function did:
> 
>     for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
>         memset(&internal_cfg->hugepage_info[i], 0, ...);
>         internal_cfg->hugepage_info[i].lock_descriptor = -1;
>     }
> 
> That -1 was the invariant eal_hugedirs_unlock() relied on. hugepage_info[]
> now lives in eal_runtime_state, which is a static initialised only with
> .mem_config, so every lock_descriptor starts at 0 - a valid fd.
> 
> This patch compensates by widening the guard:
> 
>     if (hugepage_info[i].hugepage_sz == 0 ||
>             hugepage_info[i].lock_descriptor < 0)
>         continue;
> 
> but hugepage_sz == 0 is not a sufficient proxy. In hugepage_info_init()
> (lib/eal/linux/eal_hugepage_info.c) hpi->hugepage_sz is assigned *before*
> the mountpoint check, and the no-mountpoint path continues without ever
> assigning lock_descriptor:
> 
>     hpi = &rs->hugepage_info[num_sizes];
>     hpi->hugepage_sz = hps->size;          /* set first */
> 
>     if (get_hugepage_dir(...) < 0) {
>         if (user_cfg->in_memory) {
>             calc_num_pages(hpi, hps, 0);
>             num_sizes++;                   /* entry accepted */
>         }
>         continue;                          /* lock_descriptor never set */
>     }
> 
>     hpi->lock_descriptor = open(hpi->hugedir, O_RDONLY);
> 
> Two reachable cases:
> 
>   (a) --in-memory with a reserved-but-unmounted size (e.g. 1G reserved,
>       only 2M mounted). The entry is accepted with hugepage_sz != 0 and
>       lock_descriptor == 0.
> 
>   (b) Default mode where the *last* size has no mountpoint. num_sizes is
>       not incremented, so slot [num_sizes] keeps a nonzero hugepage_sz with
>       lock_descriptor == 0. eal_hugedirs_unlock() iterates to
>       MAX_HUGEPAGE_SIZES, not num_hugepage_sizes, so it still visits it.
> 
> In both, the guard passes and the code runs flock(0, LOCK_UN) followed by
> close(0) on the normal init path (lib/eal/linux/eal.c:831, unconditional
> after rte_eal_memory_init()). Confirmed with a standalone harness
> reproducing the two functions' control flow.
> 
> FreeBSD is unaffected (single entry, fd assigned unconditionally, no
> unlock loop); Windows sets -1 explicitly in eal_hugepages.c.
> 
> Simplest fix is to restore the invariant rather than widen the guard - set
> lock_descriptor = -1 for all MAX_HUGEPAGE_SIZES entries when runtime state
> is set up, or initialise the entry immediately after hugepage_sz is
> assigned in hugepage_info_init(). Bounding the unlock loop by
> num_hugepage_sizes would fix (b) but not (a).
> 
> The other non-zero defaults from the deleted function are all preserved
> correctly: hugepage_file.unlink_existing, no_hpet, and
> max_simd_bitwidth.bitwidth are in EAL_USER_CFG_INITIALIZER, and
> RTE_IOVA_DC / RTE_INTR_MODE_NONE / RTE_PROC_PRIMARY are all genuinely 0.
> lock_descriptor is the only one lost.
> 

Yes, this is a valid issue. Reworked a couple of patches to fix it for v2.

> 
> Patch 29/39 - eal: move trace config into user config struct
> 
> Warning: --trace-dir accumulate semantics changed, plus a leak on repeat.
> 
> The old path went through trace_dir_update(), which concatenated onto any
> existing value:
> 
>     asprintf(&dir, "%s%s", trace->dir != NULL ? trace->dir : "", str);
> 
> The new code does a plain asprintf into user_cfg->trace_dir. Passing
> --trace-dir more than once now replaces rather than appends, and the
> earlier allocation leaks since trace_dir is overwritten without a free.
> If the replace behaviour is intended, worth saying so in the commit
> message; otherwise free the previous value first.
> 

This I believe to be a false positive. The trace-dir EAL flag can only be
specified once on the command line, enforced by the argparse library, so
the fact that the later functions don't handle multiple values is not a
problem. The concatenation here is actually for appending a filename to an
existing trace dir.

> 
> Patch 39/39 - eal: provide hooks for init with externally supplied config
> 
> Error: rte_eal_runtime_init() returns -1 without setting rte_errno on the
> platform-info path. Identical in all three platform copies:
> 
>     if (rte_eal_get_platform_info() == NULL) {
>         rte_eal_init_alert("Platform information is not available.");
>         return -1;              /* rte_errno not set */
>     }
> 
> The other two error paths in the same function set EINVAL and EALREADY,
> and the equivalent path in rte_eal_init() sets ENOTSUP. A caller checking
> rte_errno gets a stale value. Suggest rte_errno = ENOTSUP to match.
> 

Fixed in v2. Explicitly set rte_errno = 0 at the start of function and set
it explicitly only when it's not already set by a subfunction of
get_platform_info.

> Warning: the stated purpose is not reachable as posted.
> 
> The commit message says the hooks let "other libraries init EAL by passing
> in that structure pre-configured", but struct eal_user_cfg and both new
> prototypes live in lib/eal/common/eal_internal_cfg.h. lib/meson.build:143
> only adds eal/common to the include path when RTE_LIB_EAL is not yet set,
> i.e. for EAL's own sub-build; afterwards dependent libraries get
> deps += ['eal'], which exposes only EAL's public include dirs. No in-tree
> library can declare the type or call the function without the explicit
> include_directories() hack used by drivers/common/mlx5/linux/meson.build.
> Either make the header reachable or note that a follow-up is required.
> 

Expected. In RFC I included an example of use, but dropped from this v1
series as it's already long enough.

> Warning: both new __rte_internal symbols have no in-tree consumer and no
> test, so the deep-copy path in eal_user_cfg_copy() is never exercised by
> anything. A test driving rte_eal_runtime_init() with a hand-populated
> config would be worth adding alongside.
> 

As above, will hopefully be added later if this makes it in.

> Info: eal_internal_cfg.h uses #include "rte_compat.h" while every other
> public RTE header in the same file uses angle brackets.
> 
> 
> Checked and found correct
>
<snip> 
