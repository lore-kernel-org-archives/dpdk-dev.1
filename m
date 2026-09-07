Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC65C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 09:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D72C4027F;
	Mon,  7 Sep 2026 11:06:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0FD4C40041
 for <dev@dpdk.org>; Mon,  7 Sep 2026 11:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788772000; x=1820308000;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PtjEfEzy3fq5Qj3a8VYVl0yxxbgEcIvLBSkPNdfUdu0=;
 b=M8BPIvTGnOh12x/7O7yjlcNcvWqdDUMHCohB5h9j5ZDBGJQgKmh+MVNg
 /X9KWldjSi4OEvNVEJDJHPNBx7lVFaN8jvcOlDdvvGAqBMQV1cffsAfom
 SLdF2mIAsJCFMU4wQS1vDTo2R/dHj+OTje+mq59Vrd2pZ/Mwtc9OSFdqo
 1ph0L6YC0r3ew8Wow1W8r/l5oNougfYli7l7SbNdDiuW3Q/CMhxOnoBxl
 E1JHh0MOBw+Pvt5Wn9BQ5bYyG9JG/kkLdRQanGv8Q6uEy3tagKgW9Qnpc
 8oraCDyXFAsUhRAPJzMMxzsDFbR4x66eYnzIXlPICPOteWNOwvVmEV4MM w==;
X-CSE-ConnectionGUID: e3jYwwbFT7Oseb63Yv2XcQ==
X-CSE-MsgGUID: jeDmAwiyQWedh+hAFVGMnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="106540681"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="106540681"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 02:06:38 -0700
X-CSE-ConnectionGUID: 8qIW5PemTGGLn2869Fqzgg==
X-CSE-MsgGUID: Hn80hxsCQ3SyjvVL1y+jIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="267410664"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 02:06:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 02:06:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 02:06:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 02:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcT/zW7F8y8dpdfktEvQwCWNDLCr+ObLjvHOPANzqylRrtThwJILQLcU2GGCID+nXs/s5s++pZOZNqRtYyPQ7w4SVouKo+g7tpzftp3e1f4YaGy/f1TSWJHiA7Nc/nyjILRV2LLsWFIu02C57gF82sOGMzPHFeX9qTFKyftTCYSuiFTc8kLVNghWYfft7JNEx5anQfkf3PM7U8NJGk+M07S1nmGcScuoONOxP2k2O+ROw6TtV0uxzuvB5dI5qob7+1IHKlDz95eXg/V/gf0hkpqO2i62QENRCBgSprZtpQ0cUqm5iK6RyTatc4DwBBb0YCZjmBO2+np1hfS0vBYbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoDLqoMtu/gC4uBSmMvtECyFdxhEn5Ihp0KcaBNPXYE=;
 b=o/6ImS2EX5TItE8nUtd5jFZNJsWLd0XUWd2Lln62vkltItQtj//zonm/CHKKxj2Bn/1AZiXbIEWqIJzNjFOLQjtHs9Y4UWgHbau0jYozF6bLYjo3GXcBYtz8vyUInTcmlfc3Cb2wl5cB9QsNtmdaTsfZdlUfs6XWz2v4unhHp3U+BXYs7PkKJ/KfrM7sq6q6WQpuvCo4NJnKCDSomsu8ByfUuh6IspJwef1cIgsn6Jee6Un+g7+U8HLfSiKaYon1eo3E0owT/x6mPj9KADlbsQx+/O7irrWCYQGa39Qu+4qluiOR9Y2fBN9hHMXv0sj/TQ871InKPKqtQy8gC5Jj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS7PR11MB6151.namprd11.prod.outlook.com (2603:10b6:8:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 09:06:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:06:31 +0000
Date: Mon, 7 Sep 2026 10:06:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 00/13] make signal handlers async-signal-safe
Message-ID: <ap5-kVogL7vP-0oI@bricha3-mobl1.ger.corp.intel.com>
References: <20260906232716.496546-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS7PR11MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a98d014-9c73-4733-9757-08df0cbf4ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Igk58jldSDqKxJSwai26feRFjxwY6lImQx2xrrs0BCwEEDJ2fC60OqT8wCySyFN0JsLaLX73nNchxfHeRpAtddMgDnK2kJ3BPw099HaJ2ysJ1JIlPeLIb1HJNkk0j8nbHN40uyBkgY7unapPQJqoJ2Ocq1ULMexwAaxvwfY0zV77enGHrOriTtFzDiXMPUykRG5H/c7KOp6v1V/9UVJ+QKW3dcQCri0LNu/qjzVZoHmFQ6CSYEIdrxIQ9nRQykkFPdXlI5qB7HTx5749BrmSExXaoaLOjHacoIS2cJZvdczeHvUFK0+YEMpIGzm/xT1Pxp8nnTb2tTv2HACJwFgdeIdM2mpR/MVUFHa+sjH+xaYnaNq0Go05pYNC7jDBHRo24KD6qa5A1+qXgGI7T5cA8ikaj1PK9Bih9JBV5AM3xKI9OwnNTB69teZE0vTzH2v5joj/mVZbPJOsmDHC0T/WHc9tmlMb3Cl5VKSxAwYthsHLqoSnwRRgMm7dq6ZTjRYVbyH0JM7Yy26B5D6RAq/3j6AlUZcjvkeaeTtCF5BYpE9+BJSD4QTJGNwJZN9KeVdvIHlYTqun1lwOEScd0nLHefM2OALD+2wfQjrxX6F7KSy/caOqv1ntskad27SHIZdQL8rBY0vAvkj/X2cYcLrMSihLDTOyAyiy5ltAbeT6NX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbAvhu/iTifITzDq6zCP5WS3qDwuhk16T+HYLBSUgZKryIZJdgkSoMQ7hMey?=
 =?us-ascii?Q?aDowxHrEACVztVtWjFhGIYVyVz8S9eEgx+s2JithYeRGkWLTV/Sakumn24jp?=
 =?us-ascii?Q?w0ksGvKjt7h+IgUxRnZCJZUxQXeqhHBJEAjX0Mw/ssDEkNrqpe8AH2Pvg0Yq?=
 =?us-ascii?Q?1BZgH/zsS257w1ScxqMTuKd5bvEEJ5kNTbfoZO365j/+9+lasvNwpeWHCIEM?=
 =?us-ascii?Q?GToBYO+XrdDx/ySeW7dGIrry6rcP9v9vGuMr/0wCHclTnB0+40oye+qYnWbP?=
 =?us-ascii?Q?t0c+7cQtDX/3oPOEotDy8qL27NASuRt4gerNDKBQWCL5ffnv7I348TBE/qLl?=
 =?us-ascii?Q?VUgr4/lhkv1vqbCXapOI4en7a2jR3v6qRicxpGSZSV2O75e9gl2tu9OTEAAy?=
 =?us-ascii?Q?2ByF7B7bBXm6zfvVnlCblcMWEOotZ+eH6r+FFZHWsAyjU7orUijN7a+lgsRF?=
 =?us-ascii?Q?3e32qDwIPbyCZ1WWUErvUbmgBx9ULDZ+qGgCyq7u0rTxxFV2qGw+qlYKfRZc?=
 =?us-ascii?Q?gPAW6xJ6xXqIzeII8oqBx8IVwo2inOiGzs5VxMQ1Rrtwr9nthHFWYCVqGLMV?=
 =?us-ascii?Q?sle6vVQqdEZ2UD4TU9DxBISOufI31lnYWG/WBc48opVPQlxiZm8Z6OZ+pnfx?=
 =?us-ascii?Q?e2Rc+3ICLmi0zLpmeh2TxMK5F85PxFy63r+3PWmqQjecE75ooZUsLeBqNjrL?=
 =?us-ascii?Q?7+bxNx52Jy/6140/vSXoZGbI4sZUemHAT+FJJ3S+pGyLSV3pucMPiGvyEVL1?=
 =?us-ascii?Q?nB8R1e+nzajUrmfUaM5P/7zCN9PoreAakND15sI74uvzSM77Tm2biS4V1pwV?=
 =?us-ascii?Q?BZ6bW9MLkLWQ/yJVpHK6VZ4Vx8sDWK9tsZyx8YMQ2ScRGA7wsOhAVhtcF/Nr?=
 =?us-ascii?Q?arnpHnv5h3t90AWbfOf9dHoz5+zFxJPSzeo5GlCXLd4xu5bgk0EwiOLVJSWr?=
 =?us-ascii?Q?0/blQG8+uEFPD3jBqhMNFkko+BwF8abOfMuH18qUuGSjOWPVeNgVNTg9F5FT?=
 =?us-ascii?Q?rulriUohZeF1xEYM9j38Wx1haZGZpQX5rbvgf61ht/4mYLGDfSpRELs+PuVC?=
 =?us-ascii?Q?BTLFLoj60Lwm0xYom3idzEvzKJ5JXAw7/s50JCxeqyap5aIbKD8bNrkoItby?=
 =?us-ascii?Q?IpgjTqQbVRcbG8gJ6Spv3SH3Mwj3zd+enNcY4ES6Wpmvk2hA/ML8qJcY77xI?=
 =?us-ascii?Q?E/BrYWsdKgCxZM/59+L6MkpzBvqk9mTVfozKyp7q1MDmlzefljQiEHkmQA3k?=
 =?us-ascii?Q?NWE4TQitVcZoMhtlQamBp16dLKgHIalt7BoHDV00Z/8D1nub1X7Wj1Br0lVG?=
 =?us-ascii?Q?wpnu9+2olDpwkLeG2Kk30QzaCuy78K/NY2rw+nGIeXwz7PNveaIp1Csc0h+v?=
 =?us-ascii?Q?NDIj52rVdcYN5fTbrTOMJu1sB4ZtYZQp8xtNLG9gyOf3hG+Ugeae8nk7T220?=
 =?us-ascii?Q?Zdu3PY0gmzzyOBv/htyD8zmLIf5zsIiPYbMch8e2ovtS9seIhgwE1yQxGG6N?=
 =?us-ascii?Q?ysnlVn6p5BpKspqcPyRqkmi+Y779QNVREG0zW7kwAsB9gHZ6DF0TlH2Zh3X5?=
 =?us-ascii?Q?daJoFcMTc3Z+Zuk276bscXTyRHkoTuXFTAp2WK6By/eqcizpaljORB/qv16A?=
 =?us-ascii?Q?WbArC5Mf5KS0LdJzscW2LWcYMjW8PY+U3zed+8z3ky/sc//hqq2xS/aSpzgJ?=
 =?us-ascii?Q?mvHbn4xBiLA2C0YjaAF+R0Pt7unxaN3Tj2v6481yBQvwVzsrcai7vLtSbf+L?=
 =?us-ascii?Q?8mfRfG2P/wNgBDobQi3lDCmov94HU7Y=3D?=
X-Exchange-RoutingPolicyChecked: NX7XjmDyokqT0w/ZsbsC3Fnn5HBNYK0PsPF9eSDHnOn7hB+1vH9IQxVjL1VnzFIFC/Sc5oc0ncdsWO8AyQ1W/OHzMcc5JHGSZcSJbOBuHFngRxH1bcRawSWpN80+ASvbK7aRbKtitomPi+R60HQOi7aCv5WG8lnw5q1oUNOwv7D9OzHNdHC4AkMjUuKLfUR+fxgtJq7MTdRB6P8bvuSeGy7/8FUfq9eqz/SpAyV4qt0A29NeE7vn40if6lUxwe6wPjXMzsV87UUshH4APRgVR12gl5X5JOaOQBtr0OBtAfZjGZN72nKvDHJNl9pE709N6c41lVWKCW3DXJQ+B3byQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a98d014-9c73-4733-9757-08df0cbf4ead
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:06:31.1064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iFZf8dzWI54Cf+EtsqUMQ2WuEL3jbQ+4351eN14iKy62kpqdke1HjD3ibMEfL7+RkK6i6n+bUfC0pnBiIsiYXr6qlPrHbEiYJfVdedaM24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6151
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

On Sun, Sep 06, 2026 at 04:24:35PM -0700, Stephen Hemminger wrote:
> Signal handlers may only call the functions listed in signal-safety(7).
> Many DPDK examples ignored this and did printf() a "preparing to exit"
> message before setting the quit flag. A signal during another printf
> call can deadlock. And some of the programs did even more
> unsafe things.
> 
> GCC 14 -fanalyzer reports these:
> 
>   warning: call to 'printf' from within signal handler [CWE-479]
> 	[-Wanalyzer-unsafe-call-within-signal-handler]
> 
> The fix is the same throughout: the handler only sets the existing
> volatile flag, and any real work moves to the main loop or to main()
> after the lcores are joined. The message is dropped; the user pressed ^C
> and knows a signal was sent.
> 
> Patches 1-2 only delete the printf(). Patches 3-13 also relocate work
> that was being done in the handler.
> 
> Behaviour changes worth review:
> 
> - examples/ntb: SIGINT used to printf(), restore SIG_DFL and re-raise,
>   killing the process without stopping the forwarding lcores or closing
>   the devices. It now sets the per-lcore stopped flag, so SIGINT stops
>   forwarding and returns to the ntb> prompt; quit does the teardown.
> 
> - examples/vdpa: the teardown moved to main() now also closes the vDPA
>   devices when leaving interactive mode, which was missing before.
> 
> - examples/eventdev_pipeline: the second-signal escape hatch becomes
>   _exit() instead of rte_exit(), the --dump-dev exit dump moves to
>   main() (and uses the real dev_id rather than a hardcoded 0), and
>   SIGTSTP now sets cdata.dump_dev_signal, which schedule_devices()
>   already drained but nothing ever set. The SIGTSTP dump therefore
>   requires a scheduler lcore.
> 
> Only examples/ethtool and examples/vmdq_dcb carry a Fixes: tag; the rest
> remove an unsafe call that has not been seen to deadlock in practice and
> are cleanups rather than backport material.
> 
> Applications outside the analyzer's reach likely have the same pattern;
> this covers what GCC flagged, plus eventdev_pipeline found by inspection.
> 
> Build tested with GCC 14 -fanalyzer; the warnings are gone for the files
> touched.
> 
> Stephen Hemminger (13):
>   graph: do not call printf in signal
>   examples: remove printf from signal handler
>   examples/vmdq: do not print from signal handler
>   examples/symmetric_mp: do not print or exit in handler
>   examples/vdpa: make signal handler safe
>   examples/vhost: make signal handler safe
>   examples/vhost_blk: do not tear down from signal handler
>   examples/ntb: do not print and re-raise from signal handler
>   examples/ipsecgw: do not print from signal handler
>   examples/l2fwd-macsec: remove print in signal handler
>   examples/ethtool: fix exit flag and unchecked cmdline
>   examples/vmdq_dcb: allow exit on signal
>   examples/eventdev_pipeline: make signal handler safe
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
