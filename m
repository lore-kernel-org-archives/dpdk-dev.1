Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201DAC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23E72402A5;
	Mon, 30 Jun 2025 17:33:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7CD2940291;
 Mon, 30 Jun 2025 17:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751297599; x=1782833599;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gd4He2Or9IjSI+SRebdLTeXuC0K/mOlYJOCJuFbXK5Y=;
 b=hOSwuELcK55zY6SJXvoALUmCCFgDcz4P54s0pymyZkqqGPS6rRFqyOHb
 GWr+BmwHIUtU21KN4a9IEFVo7jc3ZQUcmHBqqpfdfkEkDDHfM1Zscb/sY
 jtDsJ8va6C0ZyjB+ag0YwnayBmRrK267El0U4RmJrjH4cnVSMkQvDEh8/
 TV7cDij2f8kZPigc0/Q4O9D3tUeRH9+hTW5QgqRsYFLZbh4cnIFSqKVI9
 GI5CnKs0yM+UTEIsh6yz5Ja23GCiRRQvgmtsmNThsTF8qurHNVBGf9FHl
 4i4CR2ulJMr9lBqq5kDgQSRxXMBsylmQD798iKoMFEQB557yqJyGuRXJk g==;
X-CSE-ConnectionGUID: CaZI9w0MTg2WquilPFso7w==
X-CSE-MsgGUID: SGmH7I7CQief5qjoYczGLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53619282"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="53619282"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:33:14 -0700
X-CSE-ConnectionGUID: HozQ0RMqSFK/5rNw/RgzjQ==
X-CSE-MsgGUID: TQOYREcqQAOBLOusmuS/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="157528658"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:33:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:33:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 08:33:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT50Vr2HM6VpShByr6r3WIPKvE2d+6q/tLwvYILJz9hAJ57Lg6Hc/KdVUaigsQzQRAWXJTO1zTZ7i/QekeikeqeF2PNNVtNsuXvF/JlZ/labPq1KJuaSuZFHMFYGejirKaHLXYATmYRk+cPrEC2ljWJ8P3yZ8D/xkLU2oSvBP6HvPuETNejeUa2U/44QZJV4SHzSkNrPk5IeJjHqtF2PbzGExvD5Jv+g4TlQQrjfYiR5kvBUHF0njWDCanzwkG/8lv+/gA0Qo3B21rwa6uS7IIgSwRcG9rKnldVd9eswW5bUBHMja/znBawbsydYt+sxrdL5Socn+70eLaw0g3n3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj1mI77K+w+9R/REfCWmwvvOfymYBiwgCRBEyIgvEBk=;
 b=gDx0re+Quix+ZgSE+Oi1w//yP5mteu0I+LHnr1lNH/HYhsaKJ6HjEI2Al34JGZ7BYbmky9EDwmrGOkY7qxsnM1jRmIGE91YpjuWZNBMF1AoHYbEvlDcqfaqyFvpYTSVv76KJ7WL9u0aCxphTlDfKugM9eNtodqhsISNa0mNo0C5pdyyLU0+AcS0XAFsid3ifT/eWgHdsmMPOte0hAnQKQMHqG9VOQDHMHzXlnWVrMYnFwJL2dWpeoiUOiJGn2WGynaFosxIpmgMo+mMLBazb4Liot+fwQg75I9pm+nMKV/2iQ+WXtbzCDGYWOMhELeVn/Rp5bBvy4iHNdl9z+K35kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 30 Jun
 2025 15:32:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:32:37 +0000
Date: Mon, 30 Jun 2025 16:32:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, John McNamara <john.mcnamara@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Message-ID: <aGKuD9EFpP-Yj_mt@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250623135242.461965-9-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d826eb3-19a5-4d69-ea26-08ddb7eb575d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q8YW9SzOamHpBYiXBIMj8DyXQ63G0mgdE5oCPpF2gGYs2wPl/n+DsxE56HWj?=
 =?us-ascii?Q?svHJZjDiKtoMrse/k+YnmEXLQHY8EQVmmDFY0Ld391KTiIfPp40QeEzMRg+U?=
 =?us-ascii?Q?Y1Uvug87EQ2qKuK4XT1NavtUMgbFTzoRPVRv8HN8wPMXZvmZiIGdDr3DO3AP?=
 =?us-ascii?Q?icnz/CLat9EZUC8s3fKE4UBYo3okQql/IMR4iUuFPZheg8piExVszTU43oPY?=
 =?us-ascii?Q?0GHsuPkZRJ2UpYqLps05JVk4cg1oMXv3G1ZIqMfN3jkYv5dM2qguyRQo/nGD?=
 =?us-ascii?Q?1z+wZo7Q1ZGZBMH5QXPCruv9bQW/Ghw6hbJSrkLnHctSIBV4H1zFuHcjIcdy?=
 =?us-ascii?Q?MiJhsiYXD/Z972ojNLEbd7kUJg/NdLLfZGeOMuX6me4GSWPSBpo7HLc/dymg?=
 =?us-ascii?Q?gNdgx8/jPL1Im6eUD2OjcqBT/UPdjGtn/oFkRB8TBwpQ+yK1taqtnzAdnm0B?=
 =?us-ascii?Q?ML249UIpifoDsQ20mx8S9tLrXhXgr14v9sK/kgSYa7qWbpk+JR8PRvyn36Oq?=
 =?us-ascii?Q?7ekQ5ufX2B8rozLPQNNVOsKHjc9RiWd9bdCaj7L2ApN9oUPo5H3cQxCE0ncU?=
 =?us-ascii?Q?W0RDCTXYWOErz4sYEForcNtaNW+lOjMoCkv9KX5whGI+cLYBASHck5DptEiW?=
 =?us-ascii?Q?ep0ilzyv+nkeVJOTWciXGcInQg3JWnv/rMVGqQszgUrv/NK1PBwVvP8QhYQU?=
 =?us-ascii?Q?KAlh/lE5gELw0YOkt05mQp6GuoyWq4XlA0L1H6eLn3V3eNJKke32fkP2gcou?=
 =?us-ascii?Q?jJt/VjvUf9R8NeKblNQwbV0LH6PvYwuaM70/QfswpF43o5aAaNMpwk9o0g1w?=
 =?us-ascii?Q?QvD94JDvHyXieCagjt6NjQcl0UH0U0xk9UHs+hEXEfXTWux+4e2ts0TjcDeS?=
 =?us-ascii?Q?w3WtvWb3juuGXKKdiRdyMfJHsaSPEr/m0CpWRYVcPyaePC4Y74mS/igUa7Xm?=
 =?us-ascii?Q?ecmnQc3DvQp8eY0UMTca8JUVBbjdVyg8msa0NkKt5w9rUSYDUKPCYTHYPO4j?=
 =?us-ascii?Q?2uKE6g7Cr/KF16UU7N23sbQEFkBUcD6Dr6I7ZhUqTin46KbJ2SLts112ba35?=
 =?us-ascii?Q?EaJEBRhqQ6yDyvSEmJdauuc+9UVOq6gJBARrSbGvHfd7SoeqmXVp2UzjBPog?=
 =?us-ascii?Q?jx8isJ6EuZpTXcrk9myTq/zxjxJ+CKa7QJjrub+bfeaLBvwm+FEu/sLnRP43?=
 =?us-ascii?Q?J/9qfDkSgb/jQERE2Hm7lNVcnuWpWkk+hujURT37hRJGL/KtmDkuFWRsJva6?=
 =?us-ascii?Q?AxABjEFdA8wHu2P/ZRh6G9PxqcWvg2I4oAXTxoAmOBXPXv1qSHk1w+PEnBX5?=
 =?us-ascii?Q?jMBUMoUr8IZMGLzlkAOR741sL+beslag8/tLwZYoX9snHsPlbPSvBo1nojpE?=
 =?us-ascii?Q?Eyjcksg5FFaR5OL43lp/QLT+/+H6xEQML0qs85gWq8DkyjIMSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?POfgyn8JHL4kJTa+i3+dztU87VyBGUx4V0v/nQr5gcn9jIr+NQLstuefDV8g?=
 =?us-ascii?Q?LSZEF3E1Kzosfb9h90oAhj1ohdbb5U75VZz3o/E8Ulh48RqyB0MBaKm+iMEy?=
 =?us-ascii?Q?4lGh7oB72p3jgcGj65JW7Zhr3BKZKzNy7nCLeg8u5pnm+lTAiCMIVticfjSi?=
 =?us-ascii?Q?qiVhIQ+OrL+koTtc928qk2nYDBgTfSRR7ALSQtibF7q51rJLj2vTqaHvFEom?=
 =?us-ascii?Q?P7Ip1A1RFo+2+khstSOIdDkjpWXbmw14/c0Q7hIs6jJOd+PTqblGVvS+1Xfv?=
 =?us-ascii?Q?UhluYwyPuUdnco9TQpl7qW4+b8SVR7sW8MyM2uwdcfjZYEINtYG51a6LPRJa?=
 =?us-ascii?Q?sHWqw8dhK+XbrrxZ7pU7aa7gvxXW741ukbFAXy4+aKV7FplveXFRTSjWO2Q0?=
 =?us-ascii?Q?+r4b2vyuEWqJvSqqdKGS76pWiH9k8uuHJOcDJWagezrunUCgixFi38ZpliGF?=
 =?us-ascii?Q?CvYtwR7TTn4PNIdlLbOerC70HuvZzZfXrbD5rsAYqRfk+K3VFQsJbaRxRUeb?=
 =?us-ascii?Q?ilWTE9k4UfUdOzbFJDNa2/Viy0JHUS+Dmp0usRxOrget4BPfv0C+5s2qAFrq?=
 =?us-ascii?Q?jGwvkDDHACU7WEQy8aH11cynHhMTy0o2VJ8docByV/1CKfTPaBxOjlxmD8iP?=
 =?us-ascii?Q?gIihjs2r+lsLGTddGf0ueFXU523njFvtygf84uEPcUjGSHAAhpa+KLvmC8xb?=
 =?us-ascii?Q?nwp2fsVPxEPgT0Hld2Ufu5wx7ihKChfHHxIQe8eYw7WgmdWa2q+KE03415T4?=
 =?us-ascii?Q?PyoTesp8o43LujEcdZmg1/1thppeCeTdAxowrNOCMI/9rQIYFXSDbuRfx7ON?=
 =?us-ascii?Q?NcbHlEdXQwNHFbX2TeSDA2BXG5yGBu2zeBAuVHg/bpdgmLzWD4Mb+ASWmZ6G?=
 =?us-ascii?Q?mJ6YSbQCstDq42PmiZwdBnurF49x5j/dqtLfa1qOThYrbXedEHm7NCkCBTSU?=
 =?us-ascii?Q?7+M1N5GhdGGMF3NhsKGV0VFQGNVFgryEbjzGBdxJnau7E8IIoiwuMbECqTID?=
 =?us-ascii?Q?bs82wH/dK8D03d6y6kODJFBujMQuCXMuAExbUJhXiM3QWlMf29Qqf2UD+72r?=
 =?us-ascii?Q?hGq1g3jG+DeKBmp+dvkyUjDu9l/XB4CESNE5YrJxU9N0uYt2yOZhH3XoaPsy?=
 =?us-ascii?Q?0fD5ZBPerJ29P/mq5I15koV5yXaocwPEUb+4kWswskDiAr9oet2BCcfN6nE5?=
 =?us-ascii?Q?y2uJqcX22aaqLUai+QMUlwpoBxDvZvII/Uljxxy1hcEnmwlQHCnrQawtxFnb?=
 =?us-ascii?Q?2+LCE3+9GwuEkndNQXgmKeiKbDl7Paa3z2H7tFD2gTzJtdcFQ5JaIwRTof+G?=
 =?us-ascii?Q?MWXddOdHAAlmmzicioRCzyDAfV1Ko9F7Muzy94JyDLgK7+2CFkecJ4bXsrDN?=
 =?us-ascii?Q?8xavPXzpNDYniUjKrO8XzFzQAGRssV+kI+jiLDL2yxBLC5AyMZqN8qeSPMiu?=
 =?us-ascii?Q?lyn23Y6VByHczlBMuPhW06GOT2Wi1+dsZYCMXGHc+xKHXDbRHsH7Roy7NAGC?=
 =?us-ascii?Q?HsPE03SkDh8gE/6wkyk534HQcewQRwgMhtwFTxsxF0yB6fCW8kt8CFjy401J?=
 =?us-ascii?Q?cVKpW1tqo0ionYindxJW7cDm3xIhXXJYZEf3AZlalsWUxXvFLbkW6TINqA46?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d826eb3-19a5-4d69-ea26-08ddb7eb575d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:32:37.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yGRhBaJQsYOjj4YmJvV6QjB/8nC7D7wBY1/Ck3vGF81at/VJYVJzZjrOyp4THVagz8e9yz7dNvcyKv9FHdf8LMOKXOggqNY92Oayi+o4Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
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

On Mon, Jun 23, 2025 at 03:52:38PM +0200, David Marchand wrote:
> Caught by UBSan:
> 
> ../lib/hash/rte_thash.c:421:8: runtime error: load of misaligned address
> 	0x0001816c2da3 for type 'uint32_t' (aka 'unsigned int'),
> 	which requires 4 byte alignment
> 
> Fixes: 28ebff11c2dc ("hash: add predictable RSS")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/hash/rte_thash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
> index 6c662bf14f..6d4dbea6d7 100644
> --- a/lib/hash/rte_thash.c
> +++ b/lib/hash/rte_thash.c
> @@ -415,10 +415,10 @@ generate_subkey(struct rte_thash_ctx *ctx, struct thash_lfsr *lfsr,
>  static inline uint32_t
>  get_subvalue(struct rte_thash_ctx *ctx, uint32_t offset)
>  {
> -	uint32_t *tmp, val;
> +	uint32_t tmp, val;
>  
> -	tmp = (uint32_t *)(&ctx->hash_key[offset >> 3]);
> -	val = rte_be_to_cpu_32(*tmp);
> +	memcpy(&tmp, &ctx->hash_key[offset >> 3], sizeof(tmp));
> +	val = rte_be_to_cpu_32(tmp);
>  	val >>= (TOEPLITZ_HASH_LEN - ((offset & (CHAR_BIT - 1)) +
>  		ctx->reta_sz_log));
>  
> -- 
> 2.49.0
> 
