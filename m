Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2161ECA6C92
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 08:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F9F540665;
	Tue, 27 Jan 2026 09:52:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE07400D6
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769503950; x=1801039950;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CQhfEhMGLgdQJrZ70bcTZJXvBte1OmunLSHEWD7f1AU=;
 b=T4DCGC12zTSRJJayMPOQyNnL3e/WP/VWRwmJk2nmFOVA+sYQk+dWdgdK
 qeOLRT4Rd22F3V3DJjI5/4PR+2RI4x1fhh9i6AkQVfLi8ouCv7qnxoeqA
 RwiP8rMW6fV3hQYNmqaB6xpgyEglY5YqEB41J6PiYfjszo7F+4Og2oC/G
 8IsDnygICYHMiu9/1rW5uPpbYau/AZzYIWNdjRDYPc8aAGjpcIYB253bU
 C/+ViSQN2Ur0rpFjF8q8oRwh2Aao9eMGgkJczR4uH4Hn4K2EBrOPbdpgX
 Am/LRvQTkL5KRgmPEiLmYSuC+sP81pNbCB/F2/uMyKvdTuUIJ3IlU47F+ Q==;
X-CSE-ConnectionGUID: MqtIusTJSzOUtAXvaybaGA==
X-CSE-MsgGUID: jnFUyPmrTvmjGAYm6tjnfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74556550"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="74556550"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 00:52:29 -0800
X-CSE-ConnectionGUID: WZTIEBM6QzOoFx+PlTCanA==
X-CSE-MsgGUID: JiwjD1tSRK2P+/Lku5+aUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="208287382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 00:52:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 00:52:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 00:52:28 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 00:52:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndVr7WsrPJPNxCXbsVrU+JkkZgVcSZQ9uID95qxm8NabslGxs+v2QrndYwNegkZ+i6e4viVCcdhnO4SNFucCBXJlcAdLYyprFxBo2mh81HOsQGyYMzjk5RilOh1XwoVY93kzh5LzkRA2pXFbc1M/7ATIo+D+kFqhItmbwsIIqyg6gxd1cOzwg1Ns6iFzcfIpuQR7Z23RJV5fY1c7NRawG8btsc4VeeEbWA7d0xAiAcNWDb+PP5NBDlx0aDEl+CuCG0ix8Z4kk9qeA6Y9qN/jbkSrWeiT7wK3qRK9wOZC1k0WKW7ekf883O/B6+sEDPTPbz1a8VRKdcbg8S0t+WjIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg93+502QsuKsUGZLW6QOXJfkAtwRQQfMeGVNBgcSf4=;
 b=E+kR1QfK2YoKyhMFb2m5JvbGifCv1d7GZxPNBRAGMnOugTQv43tBBLXRspahR8j3gMPXtaxnjHapRwrPKV5bJoHyEGGX2zwq7ZlCQgDM67vlwnMJAZvwlaZ7f7qtXmeu6efPo8tiauDlkvWsm82xwIYLpnT1MGdtS961zxsPaUHGQa8aGUk5l3U6JuZ587eWRx2jXYnhks8ka9RiOCrerNO7AeCJk53MGesklG0OqYRmvXhvxkwVymFWxB/V24/y/0kNhdSDeVQNaNmnUs73zkRrIreqflYNDfRxVDBG6Xis/8buS6T58fOYkneS+WNAGLV9nStg8CaG/vWoiYcI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9448.namprd11.prod.outlook.com (2603:10b6:208:572::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:52:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 08:52:24 +0000
Date: Tue, 27 Jan 2026 08:52:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v12 04/17] latencystats: add check for string overflow
Message-ID: <aXh8xPD_w4GwVcHY@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
 <20260126232428.276534-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260126232428.276534-5-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e566339-ffd3-4dfe-8b8a-08de5d816437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NOZLVuz5n0EssQnyM/uOZOUDudS8lgHQQMLfSUI0Wx2L2nN67scfHdlKQmQV?=
 =?us-ascii?Q?MkaJoXX9FpPEnsACCt6LCPwjSAqV8t7tcEgsPwqZE3fYs5QwxOrV+bNimR1i?=
 =?us-ascii?Q?wvcjUtcIDs7dyr/3Oc4OESUZCc3abtigRcDaLaw47gjT8kxq5kn/AxDbWkMU?=
 =?us-ascii?Q?rUOzzGtcDJfpThC7gxzX64OE9NEwVGqv0pGuHwCwgy0jRmdDuJ4aBoC9yLDh?=
 =?us-ascii?Q?YWsQr35pkL4pKYjyGM/KflO1o7oONRPnfP2bF+3zomVK1JQsoFg45hMKi1+8?=
 =?us-ascii?Q?t7aFRrpNuE2Vt4Jw/vpTzAXEZ061AQVSMMFOw2cvPN+r8GQ7uo33kqb0Kqu+?=
 =?us-ascii?Q?RS0wHrktaC8jrjI8n7FnrnjkisX/TviY+YNRTL4tElq62LQ4/Ky6GF2JCMup?=
 =?us-ascii?Q?H2Qo5e/PL5/SC4z//vFLuW45hUbdkKkYCa+AEfKIt5kqt3RMvMXQQLId7OXe?=
 =?us-ascii?Q?8Om9ry7cUmA1DLl/q/Lo2VaTfoZ/pfiSPU4J6nwHfkCsHi/tIkcxrfNvVInu?=
 =?us-ascii?Q?yaoAWwP3mfIMKa/Up6sc/DXY2a2izFz5+v6uVZmMUUR0eM9rUSDIHoTGQtKK?=
 =?us-ascii?Q?9+QBeFZw6SANBl0dfcVId8DYsFvDT2QK7znKEvUDinTpFZR9wKYV7QgHtKD4?=
 =?us-ascii?Q?wjGlrs3Elrac+uPS4RFKEvjdRw1UwlTmuTyCUTFr0uyR4Pt+oMJcWVPsfpAt?=
 =?us-ascii?Q?bUhfmRQ+bT3f5rW4+AMxW+SjJq3jIX7xhhNvtiMPWqD0R4El677VvZJso0W2?=
 =?us-ascii?Q?tBCFSFbnFXlA4cgnL8l+EPbhKfbwBkUaGZYh2EyT2puyNTW6eszuNK7DsCv3?=
 =?us-ascii?Q?hFfth3xgQSdDDNecT8hflIMUVxhzUCvZFdYCmBFWBmF7TuJer1qNJoX/assV?=
 =?us-ascii?Q?8Yzb0rh40fdgwuj+ISSHEWkVHkZgc1phqvv7Z53eU4wfmLCgMNF9IySWUvRz?=
 =?us-ascii?Q?0llz7GgyW6nJbEBjSTuBwfUbkPuCcgZVcxuCXffZchE3V6yJ9vfXeBVnZRBK?=
 =?us-ascii?Q?/xYz6O2cyPA3VgX8RUvkZ84VBFNZzoO/YmeZoH5v4WQ07ROhcVf7PEN/LfI3?=
 =?us-ascii?Q?xPL2v+OXEgHnOcs6IYUUkYa1Os+IPXV7HIShWtT8GIXCJAwzYcKjbnGg1caj?=
 =?us-ascii?Q?edb3a4LWE2fL8ijniHY63QgbIMYac1761apJHAamdCWfg4XuIZoXbMvUcQJ7?=
 =?us-ascii?Q?kb9u4w7Nt0qqMrowKxcdGCqF/3fzjYQ4BDL+jIyQQMd9ocAN1IDRKW7BUpAJ?=
 =?us-ascii?Q?nciEBcUhuDIiBljzFsMxe2W4eFbA4ldTUShTKdquQ9TTCS6wGkQ5pi652cxA?=
 =?us-ascii?Q?mnFOAP630lTJNP6YIm36d6MlTd1688RKRBaRji2220Gu0ufGg9VPcixfq2Yp?=
 =?us-ascii?Q?IgWfZmZJX6vZDJ2WJiKr8j7IsNaJoDsu5cBpdIk9epzdJ1aKEgLGIUZe6sfG?=
 =?us-ascii?Q?SyT5Nbvo6yazo+ojJ+v45DO4QS9C99k7jDssX9Rr9xS0KpOPaIFKlL0nKnLu?=
 =?us-ascii?Q?/ZzuRI2UdLeSRKgR94uF7WvYIVtFKwYOaVrkqGr9OyURIQSyOK3SNItBmWcM?=
 =?us-ascii?Q?XmXzs1FdDNyg2NQmsvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uS/Sr+qHEAo5PM+YttjEFErk/FyVoycRmD8QvpZH1vX0kuSW9mre6iHZHEv4?=
 =?us-ascii?Q?4gAD0OQFyD3sfFcTXmrsTW5m2pdKVPx3lOKDOxuM03ztYYY64vKzGxE7QV3L?=
 =?us-ascii?Q?Ls9FscI2J6HOTJypP3i6tnCAOgeV1Vk04KF5diG22put9hLQsqsWScm6C3ab?=
 =?us-ascii?Q?Un2vZl/0km7Xciu2bsudLop1LbyrsUU31njgDAzSIY6DCMNZfEGIXWuW0SDw?=
 =?us-ascii?Q?83A3MGUU8odrGrxTQSNORR593aTKKgj22gAAx6QX8L8m0uqQ+m0pM0EiVNDe?=
 =?us-ascii?Q?JnkTnCGJD1cfBO3WamJfZGXWkI/3bsoW0PP0EhzwZsmi87r2Ug4cSOYjLWsV?=
 =?us-ascii?Q?rB/kFguevlVgtYr788o8rss/76tX/Qhr1EWoHqyW5RALDznGsMy7TpKFN7IY?=
 =?us-ascii?Q?FkxFveh+cHqAgUHrxmrXJF3zcqGk+/tu8kAuGk0ooFrgCqMya9JArAXrz/I3?=
 =?us-ascii?Q?0WUvL59KvTFqK/AbmqupyCtRJoGkGy5XKeBP1IPPIAB03hdNoKu5YTM5j/a+?=
 =?us-ascii?Q?/pN6kmG6Ir2OTNajnGt/FRY/lHfz2QFNzaYAozEcfxfIm2Jl1DYjtw2Q5yXi?=
 =?us-ascii?Q?mW08hmDv6KbZWe20o17z96k2r+LOPVh803nIBBbspcRUY7joaMFNc6bTlfEB?=
 =?us-ascii?Q?T9WNJ/DhruZ/fGTYfeUlKgx6rLlc1XZAmp0dVa+t0weghilXDGlw0W8AzeRz?=
 =?us-ascii?Q?gHxqk2p2liyEJMkTryVhcHXpht+RmTCwVr9A69e8z3/NTB7+C7/iYnPUOaXX?=
 =?us-ascii?Q?Yy4idkZB08wqLW3pCOSKQeYDFCE9ikiweIUSTUEyJNj6mG06yW1VuWSKOW73?=
 =?us-ascii?Q?UpT6tN+3dGejGZA5brqbVi3y9CdABJh2PkGSK6meNgdfY2vBBx+RC4czjjAi?=
 =?us-ascii?Q?DVws+WC/Ye1AICt5OVL7kfWYXsvXU3W9RD5IRSsKrUJWt1Q9C0QxmHzncndW?=
 =?us-ascii?Q?oqrCx/Jwqg1H7suWkQK6mHSkHAdxXpLrtbKAgEnv6ip7PlmEHy7TMKORSUt8?=
 =?us-ascii?Q?1SOGwuUjtrCJZF9NnZIGZXG+5sbYSURfcCj+tG3fAeL58upoXlbmsYaf8vKn?=
 =?us-ascii?Q?LoNJ7jlboZGW3Ht7YRJLAtrLSFw3zKXZgNbXXo5LQl/CULGCWfRg2Ic8dnaJ?=
 =?us-ascii?Q?sE6RtIEB5EKGinI3BIvJt84RzufgjNUBc2lqqDIUsQWmCE9CS3vNbroy6GSW?=
 =?us-ascii?Q?CiHII1DE0BVShjB8LRE4Xs35xemRq9Un9S4GFEco8gk6N2Rj51mXMSflMJb0?=
 =?us-ascii?Q?6JZ5rVNABP6UiITPPlwmdlIusWK6NgoctPIajomaBBVsoZ2GvdZdytt1tr3y?=
 =?us-ascii?Q?dnW8LpNkZmDL5n2Dos9NteOIjA42e6f0Ba+8X/Xzfik9eFSNdFiZpQZST7uM?=
 =?us-ascii?Q?TMRQ2Fo1oVsn9jOmAIA4bV7ECTR1NLNUDmQQYGa3Q2CrSX1HHCHIaJ74qCjF?=
 =?us-ascii?Q?RIKKoQahyTgowSyBAn3ZWlmKXeFlOZ8WaYZDPFAV4L/pvfgSD3Pv9XjXkGfV?=
 =?us-ascii?Q?9cJi1sM6svGG8FIm7iReZHZth2IMQi3xvl2HOYuUug4PbDmf+KoPbxR/15WG?=
 =?us-ascii?Q?gXXrYU38TXzoMKrtn680cvIxsAXLfeut+Z6E2LWK3eOyMwUQYlE6TJYcrRBA?=
 =?us-ascii?Q?kVIdAQxEN9hQEGW5/D8T6OYOYQSfkitlhubtiNsZGwVeaDPmj6/wkREF3jrC?=
 =?us-ascii?Q?Bl006edpJkEK7mF2J+3z/xEwNYG4vgik57fMiS5RqTiKVNNmyq2lNlV/tFj2?=
 =?us-ascii?Q?JglwhdhLudle54xi6JZqXfwpQL3E2vw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e566339-ffd3-4dfe-8b8a-08de5d816437
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:52:24.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53PZ52QxKLTzmH2ENKyXsTRbZGN521YRbb2xfjvvmDVOhSpDOBl76oM8zNoH2k15VU4jP1CidoQpllTLget1swY8QPQJyQRd3fLLKhXvTz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9448
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

On Mon, Jan 26, 2026 at 03:22:12PM -0800, Stephen Hemminger wrote:
> The copy of latency stat names could get truncated if in the
> future a new value is added. Add warning if that happens.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  lib/latencystats/rte_latencystats.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
> index f61d5a273f..0861d00c6b 100644
> --- a/lib/latencystats/rte_latencystats.c
> +++ b/lib/latencystats/rte_latencystats.c
> @@ -405,9 +405,12 @@ rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
>  	if (names == NULL || size < NUM_LATENCY_STATS)
>  		return NUM_LATENCY_STATS;
>  
> -	for (i = 0; i < NUM_LATENCY_STATS; i++)
> -		strlcpy(names[i].name, lat_stats_strings[i].name,
> -			sizeof(names[i].name));
> +	for (i = 0; i < NUM_LATENCY_STATS; i++) {
> +		if (strlcpy(names[i].name, lat_stats_strings[i].name, sizeof(names[0].name))
> +		    >= sizeof(names[0].name))
> +			LATENCY_STATS_LOG(NOTICE, "Latency metric '%s' too long",
> +					  lat_stats_strings[i].name);
> +	}
>  
>  	return NUM_LATENCY_STATS;
>  }
> -- 
> 2.51.0
> 
