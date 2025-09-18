Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8237BCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB93A40288;
	Thu, 18 Sep 2025 09:50:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AA79C4027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758181804; x=1789717804;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2ljsQ9dnsQaPd8xE3j9gBx23lwIfxRfHhI3kI9Lx6LM=;
 b=ZPvMX1RKNAyEIas4XkliKdPLZoeftLR8jFrOlldZ2TjDV0MSiH7IDwF+
 TKUDlGt0OwybqSn2JRAy6z/V+psXSiUOdDGDKf0zLURycGZn8iQdQthQW
 Ald3leDUd9jtfhndplWS/3qxfNsUD5wTfBNQEMy45M3DPh1o7VwtQkSOS
 n9bDx0ShbLJaO7ec8mChWb8CzSNkDaQuhgyR2Gd68Z/UqnLsjErQSZ8Cy
 vqNtafsritCf6HOUfkETsSANok2ehRmhsmpUo1VP8CnDsrile6Wm8D8q7
 yO2ddPjnTbpH3NskJCgB7NBoW2fi0sPKVeL2T0vFhIQOvf7s+guC4vcG5 g==;
X-CSE-ConnectionGUID: Goxiin3/SiGFtospaE172w==
X-CSE-MsgGUID: 61Yg2WvyRPSX1r3nJKdBsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60615119"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="60615119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 00:50:03 -0700
X-CSE-ConnectionGUID: mmzhqKv9R4SZJHxr4OswWA==
X-CSE-MsgGUID: IfhxzW9VTcapkHjGhAPnUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="180590332"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 00:50:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:50:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 00:50:02 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlaGQ5DUxSJolpK0viIzlY1UDoNiKDQa+/Gxk3Vcw0zkHMUK0qZvanzdkqO10WnAuQWmz6errFkE8AOLhJfxhE6xWNpR2Zurhj4m0UIqB+ifeiJdqsoo2fA8jX7pnnoo3eQj6hUYn4sAqAaw8sBKZvx7EsUKEUBt1Br+8TdemHx/xm6oHGTJeBj4bBUlT0DjxUsb79PEUFmbfWQ6WhoTdss+qDMUs0Djlbuj8gmBEZVfV9WCBgIG+tCzONIkHgJTlJ1+9pPC8TLfGWkgdVCjqXrMfE07rL31ucQljiUs7d/dxQGq/lNcF1k/o9BMBOoigkSU8gODtBKzU7kIjdT0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1MS6scmy17eL4ztH4lMVrsitD5x3PF62GaG/sr5qr4=;
 b=A+uYtLm8/wCKfX7UUY+seRlN+3Dmddmj4dWxu1dvt4gB1qJWcPdm595yr3OC0SE3zglsKihw1O+Bc+4zD/1Ll0R9/8hewRwZ9nqKI+72PuVRMhLE0BkfcTCL49xXbnDapdHuLlAjNUltl2Hx/ygZpYSVwJhNBhs3UiEoqTdptyy6SwgOkB9yiGa9dsaSjig7mIPZsjjQk8uStNUAg+1sEsO0foKt1a+am8kKyhNQrptJz+VNUBCZSTTTY7a3wBHzhxzGC21rzRE31b/n6185MV1shhhIGVH9kaGFYtd62LZvnXFbmM2Zw3Sonj9JNdZPtmUDPxRrmFXj4bOTmUkdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:49:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 07:49:54 +0000
Date: Thu, 18 Sep 2025 08:49:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>
Subject: Re: [PATCH 2/3] member: remove AVX2 build-time checks
Message-ID: <aMu5neYBpToDBvAp@bricha3-mobl1.ger.corp.intel.com>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918073135.1273767-3-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918073135.1273767-3-thomas@monjalon.net>
X-ClientProxiedBy: LO2P265CA0485.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fd35ab-f973-4cf1-4775-08ddf687f4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+LjDBv5n11QGzq00wzc6R4YkYd8CrmsuhJ76CI8jN6vI5LqVzl8So/GXmbV?=
 =?us-ascii?Q?IGL+X1qC2elpD7XNR/cx1d1zb647L76ESd8og8Nl9mnAI8XrlsMVeSZEd62U?=
 =?us-ascii?Q?ahCZUFeyOivLWxBJo8C4gneq+JIInstQtDR03keg6DF5d0s4PU9+wwt5k9Sc?=
 =?us-ascii?Q?9eZzPEfa5MXS1Qg+Jl6f3Mu234yvVq5QvQNGZX0GPpDzgIwzjIJ/VNpq8OCV?=
 =?us-ascii?Q?Klb61NiHAG7GNPz7RlkoaQs562JOhuBrue3ISHN5NpylmmvDdAZSDwMOsoFn?=
 =?us-ascii?Q?OT5DAbg5JcO3C7Hk3291SW9eR5eimBNjWoL8xHvXDyxrhY1Gu4ucVu9vhAiB?=
 =?us-ascii?Q?WJv/doR43nQXRHpL9ylI54uhrh8ylmzTN3Cq+ni1FiYu6fAz5zdgg4BbRI4o?=
 =?us-ascii?Q?NiGQAVVI+lDPSfkqU4NeT5Qsxmh1KuBTscmylWyR/g/fBHOl5xw60pI6aC0b?=
 =?us-ascii?Q?t9pG6mNkTKRSD6r1HeIcspqIzeAeAPERirgRWZ9HB4kY2Tz85SpkFjEMxTbU?=
 =?us-ascii?Q?kapOgoBnr1quzPpPE+8PHu9Apobc1nL7sKDgEqY2sx1VZoF0oxzD+AKo51yi?=
 =?us-ascii?Q?D3I/Di3Xdumas5JuTowrcQibjxItCYbT8VwilpxrXnEbKWTt6CLpTEN+Ig7w?=
 =?us-ascii?Q?8UTjQacjGR+3Oz6+b+tcpl5B2QFIZAlfkYvmQcu3zV6Zg2S/SnSdVsAU+6Y7?=
 =?us-ascii?Q?iFhfnQu0CG5VDkzkpzIIliPnrpszPPwJZSy7pvU4jLaQMNyNis6I+xz/sl/t?=
 =?us-ascii?Q?F8JB4snCl/Wk/sglmahsN8vK5YbISOGc/ImkJLx18H/RnFIlnUCs5rPbw0TO?=
 =?us-ascii?Q?nNiWARlh2LWr96LMTStEA2mX+alAbiOxViie7C3WMYSCg1VWEf2/45Z5qz0H?=
 =?us-ascii?Q?72gHzVOyslAtnB3ghfGMXVPudm5fV5xcYeFXG4VwKD4tmhCzwdNc37o6c3d/?=
 =?us-ascii?Q?N6LLi6xVlTpVMK1wOqyY8IhVF2iS3lDOX9qQzWDU2jxZqUgln+4Exs91H7YQ?=
 =?us-ascii?Q?xEwG7t4Dt9CqH2vy5xjHtOOORKrFxYR7uFoUEubNNcRRAAyKb91tMAP7QxII?=
 =?us-ascii?Q?NwkaSRVdQfQmLj0MXcZ2rdcajBTiUXdnkwHRLfAZKwKdOREU7xy/G7PxtjRb?=
 =?us-ascii?Q?gBpOWeI6XKwcD6RPHsrJZJWRDxnta3+AYxKVfoznOFkgLSQ0vb4eygMi7rU5?=
 =?us-ascii?Q?Q5HDZe6aUh+qJpyd9d0mJGYi/BleuCZsoU/EfeUOfDa52PKkpfM4b0IliZmu?=
 =?us-ascii?Q?91qFU/ITXdmSjYXAmLPr7r9ODo5D8U+m5E5LTl06sEd2GhoAMIYaL9Lsbq6L?=
 =?us-ascii?Q?2bfnK45X7M3TXRDRTMnEuHLMJKGCBID622YsX8K2NSN2voYfL2ez3E1Yu8TE?=
 =?us-ascii?Q?JMjBGGUUEx6DadJKBZhNX4FaGRnG7GFXQhYUmX0Lb0WUPhIxcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zsiXx+oHnC6KVSMiN7x1fsLlQ1UAqyB6vMdzbiUtBQ9yy0M4snVqOc5VN/r?=
 =?us-ascii?Q?6I74o6uVgXXxLACpK1WZ0DNjSu7ZUlJpeS4m77Bbr7niUBlVEsA2yQs7mgPg?=
 =?us-ascii?Q?+wGKi7GV0FMlo/+5rLNVGgqYuXtNkJKnRqvlDVc5BnVvqz+y9CXHUrMsA3Vt?=
 =?us-ascii?Q?ttX/l4ah61EVkMyRfM0maW73Y/PjMEs5VBOTj8+o9xJo9iaOoeAOuCnA2km0?=
 =?us-ascii?Q?sRsBeqfLBI1cqzC5ZY4do1CiOGSssdSM3oHM241b4Ew/ftP0byPz/R+U1+hg?=
 =?us-ascii?Q?cmJy0mktTqEZe5GJERojlWaBbLclq+cEWjMCrHVQ68xz0iFWBuTR/xEs5FPF?=
 =?us-ascii?Q?BqHEZgMWTV3swDJ880ZhDs/oVFmuzmujVPo8/faYT5SMHZqUuWKl6COR5u2b?=
 =?us-ascii?Q?cpNtMG7UvMTilpsxpxUAM0X2dbD/Cls4H7sR3ToHDfwLp7kBcCzgj9v7VvsU?=
 =?us-ascii?Q?aaynQOvw+xjCtuYLkvpCR/45VCUKDW1WL+7pMwAoyiEQ9E3sjafouZ0CV/6v?=
 =?us-ascii?Q?0DIHx3ZFGEhndwWXyGDG9Bbq2k0S37Jgxtj14issvBnTHaYhODjGIJFP95lD?=
 =?us-ascii?Q?yEHYTZTyHswkcCvulBDZ2ETjyxUMROesVIjMvDQg1PEIqw8doehIk7lb3BFP?=
 =?us-ascii?Q?S0kIm9upmLCgbM/EMj01pea2YH+U2ndM1QhXzO4ou2vsQknL1SWtmHuCKUkF?=
 =?us-ascii?Q?iAyMzJaVls0lsOC8crmnSexobcNfyYuaLbkcugc9/KU4Q4u7SFjMeXNDi5Tn?=
 =?us-ascii?Q?VCszCacSiw9ln8cekbDFMMezUagpcR8qd/44Dat+8W+xN9Vc7z/xSIRbP6xB?=
 =?us-ascii?Q?7eqZEUwFukS3Mcc78XAChcrfiZsS964DB7eTnHRzLRAr1sPE6wKZifLVdiDX?=
 =?us-ascii?Q?DshSgnHNqbeiegSx3Y2Hp6yTYcCI5FtJa300FrDQGcYS3C+Zk63tAAcPvk59?=
 =?us-ascii?Q?pVp+hOWKdX/9g8EetMt/xQez1NXVKzGuQuOO27izm+18YM2JiQmSU/S9L/9J?=
 =?us-ascii?Q?AsA7iRkR5ip3/AjXW0wqkwVbpbendJs15hS7LTaR4Npn3gYOlo7Fw1zwEecA?=
 =?us-ascii?Q?oOBt5CmgY+me2zSXyuwIKcgSCOBw3zm6tPrMG6jZ6tslSS87KXPqssaxAjON?=
 =?us-ascii?Q?Dv803OjBIMISLAv+/0yyOInGrHzHHrrcmcxztqK6u8MBwPWEhCb0aMNWV0Sf?=
 =?us-ascii?Q?TLSRKUHzQqsd6CaNuWCIVYbXAj8wF430nn9UBFQPU57kuL1oU+NmKR25obos?=
 =?us-ascii?Q?dA6JXFTEfeVWslWghIH09YCa44I1H2DJ+2tUgjdsSv6Cwskc3AGHy7TncsqT?=
 =?us-ascii?Q?yKxX463jXdYxkVOXB3DKbyDsI24kxdtWatBF4cAOhaCi3AuUtACenZni8kcA?=
 =?us-ascii?Q?2U7r7eoh8kbhf4r5efBHfbSr42AJ5y+YoiwyqsweawB6A0vQK+R+4QXgdVVC?=
 =?us-ascii?Q?jJRhUUQAsRrcwQcBpRJI+p6umYx8xm5LtWmONTcXGvTRZqNs2xOsbY0vOZqB?=
 =?us-ascii?Q?ZPC/fwycJ4FVnS7DTnOHA0uHx5w09dqhG7pnLV1bEnkcld02HZ/FiXvLo0QC?=
 =?us-ascii?Q?BzQZJCRYBbGP76mixxZXuy2zk6lGJ6AI8D9FtqTpUMcTVHawHLar+fSa1tCt?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd35ab-f973-4cf1-4775-08ddf687f4bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:49:54.5238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdSFhJSA2N91z8iFbw0H8P7CQwzrFCK9uyIgYM3T39UEz3mWQ9DPoS6VeByvh71DayJgrXiV9Pu/hwi3ODgxaeXRL6u/emmB+filuDGxkjY=
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

On Thu, Sep 18, 2025 at 09:28:04AM +0200, Thomas Monjalon wrote:
> Since all supported compilers can generate AVX2 code,
> no need to check for AVX2 support when x86 arch is already checked.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  lib/member/rte_member_ht.c  | 14 +++++++-------
>  lib/member/rte_member_x86.h |  3 ---
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/lib/member/rte_member_ht.c b/lib/member/rte_member_ht.c
> index 738471b378..0a5b206778 100644
> --- a/lib/member/rte_member_ht.c
> +++ b/lib/member/rte_member_ht.c
> @@ -13,7 +13,7 @@
>  #include "rte_member.h"
>  #include "rte_member_ht.h"
>  
> -#if defined(RTE_ARCH_X86)
> +#ifdef RTE_ARCH_X86
>  #include "rte_member_x86.h"
>  #endif
>  
> @@ -113,7 +113,7 @@ rte_member_create_ht(struct rte_member_setsum *ss,
>  		for (j = 0; j < RTE_MEMBER_BUCKET_ENTRIES; j++)
>  			buckets[i].sets[j] = RTE_MEMBER_NO_MATCH;
>  	}
> -#if defined(RTE_ARCH_X86)
> +#ifdef RTE_ARCH_X86
>  	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) &&
>  			RTE_MEMBER_BUCKET_ENTRIES == 16 &&
>  			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> @@ -179,7 +179,7 @@ rte_member_lookup_ht(const struct rte_member_setsum *ss,
>  	get_buckets_index(ss, key, &prim_bucket, &sec_bucket, &tmp_sig);
>  
>  	switch (ss->sig_cmp_fn) {
> -#if defined(RTE_ARCH_X86) && defined(__AVX2__)
> +#ifdef RTE_ARCH_X86
>  	case RTE_MEMBER_COMPARE_AVX2:
>  		if (search_bucket_single_avx(prim_bucket, tmp_sig, buckets,
>  				set_id) ||
> @@ -219,7 +219,7 @@ rte_member_lookup_bulk_ht(const struct rte_member_setsum *ss,
>  
>  	for (i = 0; i < num_keys; i++) {
>  		switch (ss->sig_cmp_fn) {
> -#if defined(RTE_ARCH_X86) && defined(__AVX2__)
> +#ifdef RTE_ARCH_X86

As with previous patch, the AVX2 flag cannot be removed here. Compiler
support does not mean build support.

/Bruce

