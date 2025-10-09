Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F6CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 16:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AB4A402A0;
	Thu,  9 Oct 2025 18:41:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7F0B340267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 18:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760028109; x=1791564109;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rLck2KIgMcZy0mu1gl+TpwBcAJ0v3hLPzKTt/71gato=;
 b=bKYoAZp7IRYeNymFDn5S4uNIU//QEbe9JSRHQ56W9l9CBHyV16+fPw+J
 a8KRmlhA3ZFEm05EUHNb4dSmZbgfKgqlgQyU+yqrR/WSahMs0c2mBXq9O
 Z68F3Ves5roG1oDcyw7Yuz/mX1Y9F81/MZAyZB5Ii5N3BUJy8O0z9KRYg
 0GXhvuxYYrIrKXZKVWv7+OPLaymP5cZ93P7STzGa3045662G7d02oJE0D
 Kc9S3NnhgTrfCzMu8hO5jG4/y59CDITDCIL0dXrLKDTs32VRaSx/I83Vp
 adibhBD5p3DoIOen1mha0GwVnEC8CTWn+MwRONElmfSs7r4XDQSco+88H Q==;
X-CSE-ConnectionGUID: oCxNXkP7RNKFJ+IgUCKl7g==
X-CSE-MsgGUID: ls2h7ZnaR6uibxxXw2nX6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73673401"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="73673401"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:41:48 -0700
X-CSE-ConnectionGUID: 1AA0E+PBSkuE8ImUI/oBCA==
X-CSE-MsgGUID: jojeJ80FQsWO7Y0WrXqkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="181183602"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:41:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:41:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 09:41:47 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMYW9+og3LbQPCEoy0Tf/N2NRMTfyjIax1GDY7IVEeUG0x9IZYjHYnEVyS05eG2QahlAVe0chAo2pWgjhSoI07/Q0aqmeJOvjqrJODe/hE7D985hPn1gO/3Zs/3MIlwms/0we9sSsUAKpzBKjEabvDQrLpfeXEfgR/GpVGJQagh68Cya8I1Oo0MFQUAOpy6PA6kMa5V44GEW+8lDk45AtCXz9ej2Wvm4EuIUnilrQWbX0y0rX3DxfVJzTkzqzVGIm94mP1/zCU9nY+qKoAR8McBo9PCw9KWXE2FeadRsP4MESjQU4Hc0MiX8gTMK+qFoKi1rEmFnVK16kidCOeAk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsZJBodYmXs9kcuixS0prxwlsDj8AiCmTjqK/+jZZ/k=;
 b=pmarD05hLHC38LVVzyoS3kKi6kf3LnLCDXz5hcbAJbM12i9lJnwno0HVX7tZi1/rkbFqqK/pJPkSqMlTS2hL0pFRKlk3w8Jzys3/1+1wHa+JKn0iwy98c/E78YzQSpEjmkD4Hpb52zpgdzE1BWhQbIyUkwc3hZe8ut7fcrP/hG3tPq6ab+9PGw8+tjtio6sYVg+1//HPD6jKXI89dEtyuztFKf8yAEcqU8oO39Ybzw0/35iQw6qY8eZ4ykLa0S/WRQ2/OHmgGdHvmUq+kJYXzmq3XaX2thpnoIhPL2DNBOOPjld2VyHQvftaQ4KmhLT0bIMOnJUTZPp5z3vziW3Twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 16:41:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 16:41:40 +0000
Date: Thu, 9 Oct 2025 17:41:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Jasvinder Singh
 <jasvinder.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Message-ID: <aOflvyl1Ow9N7Mve@bricha3-mobl1.ger.corp.intel.com>
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716103439.831760-1-16567adigashreesh@gmail.com>
X-ClientProxiedBy: DB3PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:8:1::49)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1792cf81-6fbc-4242-5e11-08de0752b87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YFe45p4boNyzHn3c/c33SVoQ7Iu7rCP5Uvvvutu0lIs1sDrdK9GYTRD5oiQL?=
 =?us-ascii?Q?nx0GqYKXWNQRaSyDUEJWkRC5lUjNklOzyjCMXU67nOEn+WHG6Pq+DRyuu50h?=
 =?us-ascii?Q?3EFGVryzWgCwomqjcA9vCre8FRXrtPAREy1cIQbDc9CGWxgME9mf/KKS+d6z?=
 =?us-ascii?Q?v8wB0RCc1hzQ7nRkKyRsJsFzWi4SFWtCu+2QE3FLnKBjcWyj5HHUeJQ1fxtw?=
 =?us-ascii?Q?H3gKRh5y0Sw5sHIUyIJpKBqMDrX2vfIXndpp9uLjQwPgla1aPal5Tx5RbAwx?=
 =?us-ascii?Q?UhZ/PRsnas0nnLPEQ8C9c0Mg4Zli68sQFfh/iHZkBYQ/WbsfTuC4bJnxkZ5M?=
 =?us-ascii?Q?V0XP0tf+p8V6G/XP+4gPiLInPKeIzRofUOwQ3sYDObbmkN/QffopPEGCj9PV?=
 =?us-ascii?Q?jZtGHr6l3xinZxQQ9IRWbxZYP6yrAf+m/cMjyHwzNAXLGF7M5/x0Zq0rJ4Y+?=
 =?us-ascii?Q?+8ic/uXVFQYW2pSIBhmh2OqZaKdswCaIHP5UxWEOE2IBiCDpj6GCVB3mVPol?=
 =?us-ascii?Q?wpbMrbzJXgJu5k69hDxmqQgTHpVXD+/PAo5ryrQiF+L5hTwHexzZmx6Atamt?=
 =?us-ascii?Q?zyqfs/6URxpjdAfPrv23AyFz03Qw+PKeBH82lLxbOKmi2w1WK03HwBOe4X15?=
 =?us-ascii?Q?rrM5GsX2gyz6iPSC3MmVFSgZZ5SELygh/AxLHDGrCj4iBsrW95v5VpWyOB/b?=
 =?us-ascii?Q?n8yqF/5NBO5Jw17Tar1pQzK0HsLSCenmdtz/9UUCHZgQPlL0zG/Diikg6ebb?=
 =?us-ascii?Q?wiJ1LX6/zVfG4uzqFIBZJLusdH0Nx6G2h4gxO8g3LLvAHRhfp0a24lSQVuHL?=
 =?us-ascii?Q?oe/rn9UjdMTZUdJqdojtpQSz3BiOwiROCL4gko72UXPG4SsMOwibNLxVwTaU?=
 =?us-ascii?Q?YPGKNHhIZ2f+hW/VZazpxxLeORqseNFxKeD4kj1wMwMdcmy3oEDh/CAuC/o+?=
 =?us-ascii?Q?qJBkbigDsJ0QPjaw7WHE4nr1+CBM4JE44EL3YFkGMenQiCE/f0S3SD7/P8dq?=
 =?us-ascii?Q?mIJUAHzgev7M8yTMwAGPq5QJtN0r9Bm4D5QENCaO74aUJ98cbBXWuNBdeIcs?=
 =?us-ascii?Q?tpNu2NI6YDsHprQbA8XfJH3m1CQyip1lR7VxBrmaQsrw+2AVwbF+qstIA8G1?=
 =?us-ascii?Q?3tn5eFwm6d1J3M1pSHDLewzIqfWAN4rgMcYLWsFh0lTxHRn2KY9xB3+6rmXv?=
 =?us-ascii?Q?4QbKVrMZR1h5/dZIa4KOuiMaHJXQscoAnMm4uxqLt27D25SSKY4sAH2Z+tpF?=
 =?us-ascii?Q?dm5FHeVp3vO5OwknTqXVJhEsk0rxwPdbLVkq23Iu89ysrEj3Lu3I4VuOIN0d?=
 =?us-ascii?Q?xRVns1Ufk3GRG4wR75xnZVOaThwNlVFetX0kLdsY2iph2Xqrj1KDTwnyJJb9?=
 =?us-ascii?Q?o+UOpF557wiPO3mNhz/GlW14yCRNStik9sD7ryhf6xVg6/vAnPk6fHEUNM15?=
 =?us-ascii?Q?asN5VJId/9K2TCN2aYDm4QvyfhAwIpX0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYsnt1jdsreo28POkfZBxUK86FB6QWgDUix8NYkJuLXTQE08xDciLVTVc9t/?=
 =?us-ascii?Q?rDeVquWbWYWmb2mMztdDYo5Rctocbfu6gy8olxzdzv2In8dvnf8hP1FunMz/?=
 =?us-ascii?Q?Gw4QfybWcb5m3ZJvgqD9soPwCRSDbfCYY4mck4Usa5/YR0PxjuLHPgYsUBL/?=
 =?us-ascii?Q?d3WxSJgZst28LPrP8zoSoOp1QaT52GX0b0QF6ZjLJBvjthGGJz8tZJqqne5I?=
 =?us-ascii?Q?pvtBNz7WNVHOR0OV8OsRAgIVW7k5dE/OWE2LIK9hIbzY7eKGWQZi+wIAL5M2?=
 =?us-ascii?Q?oDx97Nx4eKU+k7atWf2knt78B+rYazIV7luvq9mt8xgsEhKEfxOBSLyhbRKu?=
 =?us-ascii?Q?0yGdyqFqYgFqZj/KnDDJ8Nz9ud8XDjNUzzCi/LQaKwU8zK6P3/hyD3SWeYJZ?=
 =?us-ascii?Q?nF2NL0/Hz1ax7m56trPToWJLv8U/xkd03X/KtdqcGQnlvpFM6hb+lmOOifag?=
 =?us-ascii?Q?C4hQSxH7IsAToBvIyT1DrAc4BU21tAijtLfGY+S/u0YUcE59TDwK9QbbzmoJ?=
 =?us-ascii?Q?76V7jjYmTK0soMrbXFE4yNQElmZNAxiv96hwq/2kPvwCS1Lsmkc930lTw2dK?=
 =?us-ascii?Q?8xuBiGqvr1jMbWOHToO5+uiKV3PwAn//EKoK/P59jvP2Ns/iqlPwb7cU3ycA?=
 =?us-ascii?Q?yj1PvoBwvhyjkxegp4uQGtmax6znVqOTMG1pE3uUyK0fIwhMUzZYNHqbHA5X?=
 =?us-ascii?Q?U7Beg13PoaBKuXbtsRGjmRTaDugIQ8etC1PMEiJ+N74W37lpt8XSvj2AaclB?=
 =?us-ascii?Q?89wfMemlWp+n2Bd4FyRzS9oAIWntex/3L7ebbyggxUm9kTILpc5y7YYTxmrZ?=
 =?us-ascii?Q?U/oj/0Nch2BjegR3rfy8xtZbAKPhVt8QqzndpWCbeUhMHMhcYqmB5msLCJAS?=
 =?us-ascii?Q?1PLM+mvLrvHOJ2EwPqs3D6OOjDUE0k7UNbhd04dzYNJKTxOFcA0G/Fm4M1iu?=
 =?us-ascii?Q?ywBhe2kPcrbpqxoMW9Uroh818AitHzDpcon6qDI/+D0yCrDhd4aEzSuvp50E?=
 =?us-ascii?Q?M3xD/auzIHu4MZazw43/7BRzNGhSoPFxa71iTvOa9LXX3KoNxAUHKGWOVTXO?=
 =?us-ascii?Q?NMbbP+TtRUuZKVHrzmupcwBydWkpmtexdzH2ROvIvnlW/PqVWPhEZDFQOXmt?=
 =?us-ascii?Q?Ua058pspusbkgkRmvfxb4EfWZk63XSBANAN5ORZeqWbDX2wDdg5NaeygksfK?=
 =?us-ascii?Q?Fq8JkTRpbSNXNcVDrVS8KtixcVhlFIlTjmw3UOHG3JAfhFY6f4EOmbyul88s?=
 =?us-ascii?Q?pz5AhUxUHVWDWaK8zfd0pi19wxMYJqu3BiNUncWXlbDOoiepy62Nqxkp87bn?=
 =?us-ascii?Q?g1W8Ia4P5eSw4NFPfELoLwJ4XkU8+GUt9VjZCbhQjbEuR2C3I1kW9v+q6N5U?=
 =?us-ascii?Q?ggva9k+bPGzNucm+10szIhqxcaQIHdh53SFqeaEkxDnVYyQPN9X75E/wsDZT?=
 =?us-ascii?Q?dF4a0pls6vfGx+bm5riBQhG1QPOcCjVhczz7CeDHDNH8VTW4IDtByl6YANuh?=
 =?us-ascii?Q?pMcDW6/v91RBvDPk4gc2w8HoiQpvraM7OGEP9uD/6MA+Vn/ygKDmZgkBUgdo?=
 =?us-ascii?Q?+gUJJyvj4VD7NshSP46wvm2W7aBbSkeZN8lGvUJyy5YAXWyie3F+7bayvvu3?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1792cf81-6fbc-4242-5e11-08de0752b87f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:41:40.0645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SchXupZr27v4IN7iH1hyoFXRvB/mdPywZRr5SZvjhPryiz3F44fM8G6p2Ed0QF2T+1+XxyFWuvqgyeb6jz0uaDky3m6wfhNL8ubjzrRNPvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
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

On Wed, Jul 16, 2025 at 04:04:39PM +0530, Shreesh Adiga wrote:
> Replace the clearing of lower 32 bits of XMM register with blend of
> zero register.
> Replace the clearing of upper 64 bits of XMM register with _mm_move_epi64.
> Clang is able to optimize away the AND + memory operand with the
> above sequence, however GCC is still emitting the code for AND with
> memory operands which is being explicitly eliminated here.
> 
> Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> shf_table which is 32 bytes, achieving the same functionality.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---
>  lib/net/net_crc_sse.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 

See inline below. Changes to the reduce_64_to_32 look ok, I don't know
enough to understand fully the other changes you made. Maybe split the
patch into two patches for review and merge separately?

/Bruce

> diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
> index 112dc94ac1..eec854e587 100644
> --- a/lib/net/net_crc_sse.c
> +++ b/lib/net/net_crc_sse.c
> @@ -96,20 +96,13 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i precomp)
>  static __rte_always_inline uint32_t
>  crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
>  {
> -	static const alignas(16) uint32_t mask1[4] = {
> -		0xffffffff, 0xffffffff, 0x00000000, 0x00000000
> -	};
> -
> -	static const alignas(16) uint32_t mask2[4] = {
> -		0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
> -	};
>  	__m128i tmp0, tmp1, tmp2;
>  
> -	tmp0 = _mm_and_si128(data64, _mm_load_si128((const __m128i *)mask2));
> +	tmp0 = _mm_blend_epi16(_mm_setzero_si128(), data64, 252);

Minor nit: 252 would be better in hex to make it clearer that it's the
lower two bits are unset. Even better, how about switching the operands so
that the constant is just "3", which is clearer again.

>  
>  	tmp1 = _mm_clmulepi64_si128(tmp0, precomp, 0x00);
>  	tmp1 = _mm_xor_si128(tmp1, tmp0);
> -	tmp1 = _mm_and_si128(tmp1, _mm_load_si128((const __m128i *)mask1));
> +	tmp1 = _mm_move_epi64(tmp1);
>  

This change LGTM.

>  	tmp2 = _mm_clmulepi64_si128(tmp1, precomp, 0x10);
>  	tmp2 = _mm_xor_si128(tmp2, tmp1);
> @@ -118,13 +111,11 @@ crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
>  	return _mm_extract_epi32(tmp2, 2);
>  }
>  
> -static const alignas(16) uint8_t crc_xmm_shift_tab[48] = {
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +static const alignas(16) uint8_t crc_xmm_shift_tab[32] = {
> +	0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> +	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
>  	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> -	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
>  };
>  

Can you perhaps explain how changing this table doesn't break existing uses
of the table as it now is in the code? Specifically, does xmm_shift_left
function not now have different behaviour?

>  /**
> @@ -216,19 +207,12 @@ crc32_eth_calc_pclmulqdq(
>  			0x80808080, 0x80808080, 0x80808080, 0x80808080
>  		};
>  
> -		const alignas(16) uint8_t shf_table[32] = {
> -			0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> -			0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
> -			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> -			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
> -		};
> -
>  		__m128i last16, a, b;
>  
>  		last16 = _mm_loadu_si128((const __m128i *)&data[data_len - 16]);
>  
>  		temp = _mm_loadu_si128((const __m128i *)
> -			&shf_table[data_len & 15]);
> +			&crc_xmm_shift_tab[data_len & 15]);
>  		a = _mm_shuffle_epi8(fold, temp);
>  
>  		temp = _mm_xor_si128(temp,
> -- 
> 2.49.1
> 
