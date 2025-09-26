Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C64CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 07:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C698D40262;
	Fri, 26 Sep 2025 09:56:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 85CF94025D;
 Fri, 26 Sep 2025 09:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758873366; x=1790409366;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RlFWoHA/mnu9re4RCWXxu+SJnK1iV+onoY7+yuPAPjU=;
 b=AD/s/0vVMLYPefh4CAc3VaXdpITRuBc0gzkoaCPm09Z8VERDllvDTRrq
 aKRAmD8Tuk+FcVn+NvXnQu2/XFTA0lF1uJFsyzeIwUVvX92ihl+rns97B
 IrOHVFPt9lkTpvuTLLyN3kqb4MkLQ8aDvPKjm8UyVfrXnfl6xD6VWEc7J
 H8GwfhSEcJSc7edJWIsDcYpOHmE9cE949y0x4i8rL7xz/rUQDQ2UzTjBZ
 szzoBhXUPdYtajbjkBGxeCR5q97l+zDZYPAhN6kxGiY5VRCY48jfomm1n
 IoOgRWwsFy1bf3fxhWBX/Mg+uLwZH7tdqs/c/ScFxPs7JAIUgg0bGDSqt w==;
X-CSE-ConnectionGUID: rT5Z32a7TeaYpBVgkRiAYg==
X-CSE-MsgGUID: 9VxvXPtgThmtodMZ2JdjoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61091487"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="61091487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 00:56:05 -0700
X-CSE-ConnectionGUID: MT5qeyPFSm6QfzOc7AuQDg==
X-CSE-MsgGUID: HctA48bBQAG+AVoQMFEGFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="182826650"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 00:56:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:56:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:56:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTDDjbDS9x5sjMBZbQwJnGQCNYo/0Q3DTO1BqEoaXZPV4EnqbP0sCEwb1graLR4yTXkjklbqJpMdomkNpeOiZzjxCklIUwUg63xEcmorkwFkLAVUmLRuQFZasuzHm9PCZStfjgs9e+idtqioL9MMW8Mq9Xa+8QH9y57C/SK128eqxyOPzVrdqGPz1XBENB6uNRvog3CgAbr42iTNHHzvu5c0wEXK2l6IN0YiVy2Z3jixt+5FhgvN0RCsNdj9rQSIKg8BesgrF32gWkQ1Fcej81E7Y7uGwiJFP61xxZ3Nm5ONKPhSJYPURbehhdjcO8Fe8Xm30qckhpFSvzhMB2Qf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eEx9z/lkW+L6AYazR3H5CpsPB+pQllVhCOBNTYbDV8=;
 b=GNSr1nAnFh21zDy0PFmrlrBXp+BWtRUwGTRmh3/5itXf4GVZjg2xLcvohr81N4NruJFT8KIlXl4nkIPBunJuArValJXENrt98uIp9WQRtiLwuGfHABlFukQ2ogr/i5CDfpwmPwivfhY9Ft8/NdEVGpG/2BYiy9pFG8nHkVfXLz1Y7ZZB/MwIENfrYRuB/LGaoNYZs+N0uEuL7iWTFyJjmFK3Rfua8MLomCwkCfC2RNa2JBTHrqVVpDUVwh6k3M2NAqgI+h5vw648WdUk5jEIfZHm7u04QTeD7CYsybTLuaAtMkqC5ZrowSxLbNcEVj0OY0pRZShEcmr0SN4+5DsiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4583.namprd11.prod.outlook.com (2603:10b6:208:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:56:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 07:55:59 +0000
Date: Fri, 26 Sep 2025 08:55:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>, David Marchand
 <david.marchand@redhat.com>, <stable@dpdk.org>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>, "Akhil
 Goyal" <gakhil@marvell.com>
Subject: Re: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Message-ID: <aNZHCww6m8NJ_BHN@bricha3-mobl1.ger.corp.intel.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <3819475.yaVYbkx8dN@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3819475.yaVYbkx8dN@thomas>
X-ClientProxiedBy: DB6PR0301CA0097.eurprd03.prod.outlook.com
 (2603:10a6:6:30::44) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 29676c17-4c58-4aa8-849e-08ddfcd221c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MoW/2E39MaIOh2tNswpJ6ECCb2jX12MYeTCy0FhzW7WAUbjImPAP4+U+RvGC?=
 =?us-ascii?Q?9qB4/T1IqO2tyzzPcYg6PyeMivGP5RolVCJlaaDaro40J4kGXKnw8z5TKK8J?=
 =?us-ascii?Q?CtQnIVS5uiFjY2MakGVIINV51uutrD+wSvE1Ur08Riw49GhEESMsbmL3oQuO?=
 =?us-ascii?Q?21QNdVkIj9NRETCGJWfVfnX9Eb3iVxruhmKV0NkkfeZrc0nOJpobuqXWCh54?=
 =?us-ascii?Q?0CoC9PYGv4fTVoaEDMZ4VNS6LhQyZSNRYD0KbOqmXDOGN3XMd6gfS7FwITIg?=
 =?us-ascii?Q?x2FxStcJ/3FRKPg2UIFwK1CSXBv/Hb0MSoKe61x8cmc6zTupklLpbjZ6rC8n?=
 =?us-ascii?Q?01vQrg0kCYoqiuKvoAIoIm0U4BcW68Zdzcqxl8UH6v5pBRiL0mXyqJvUV2oo?=
 =?us-ascii?Q?l6Yp2Cj977cEl9bsuHvGsK6RI476Dvh8BvsZe/i0xAwqM1nPwlTdDdFnKOPD?=
 =?us-ascii?Q?R2LilVVQH1kledii32Ia8qciQxoSW7qQj46z8jhu4SSifkrLjsaEYyop2XMy?=
 =?us-ascii?Q?AQULFOQTHkAD0aapFKlccLELz76Ik1bcGJUBufk3gtgnSl8OD0VtKMX+lNn0?=
 =?us-ascii?Q?H3g9m69e7qlQun4a70zzwJIj+rLZFQh7tlThUiWhQ5f8Cb0BvcwUY+LrT6pK?=
 =?us-ascii?Q?g2E+/m4ubLFPiQKKFPPGVPV0w0lrafXLz2456ZvqZA8cL8F8EIx/21DQrQtK?=
 =?us-ascii?Q?2S0WTtC9oByMxGZIntJviBi9FQaiHvcugcnuLKjh8v5hA2Y1wvAJO0i25+k9?=
 =?us-ascii?Q?fP0NsqLSRyrpbpDhy0bvbgh3hDpkiyoIb2uNL3fAdIXPcjSfEW4sljzEXQWm?=
 =?us-ascii?Q?bAFIuDK462Ajwh0N69hNmIRWRVw74FeokOAk8ypw9tmsSEaTv5aBpxTvAV4X?=
 =?us-ascii?Q?kQX60sxR8TKKdO9D5pxyFhgtvktfMoW/T6+WPGx9Y8lSF6bXVW4g4C9ETdhU?=
 =?us-ascii?Q?x8OeoIadt2xEt3ZnCtQW3dlV5F/YPEjlIqtiQ/er3M1MHpIGDINt8dO4Iaos?=
 =?us-ascii?Q?Z2T/xUwB21TLl71/x+tyUA/bvg74VzsbTxL36TnK93PYu5DhpdfBpvvgEEs5?=
 =?us-ascii?Q?E09RP5uwpiHOmFGMvSk+iM/7ZJHoYJ0B08hbcuPiKt8+YbF7Y2Pbv6UJPrSD?=
 =?us-ascii?Q?UqV4spDcbWysakqCMu5CUMxVYoWF/5B60RRLsLfB00H6H4WVsnmiwMAEqzis?=
 =?us-ascii?Q?UjLo2DVq9QWyJEOKmmtJAvDea8ousEVHYjHXmHHzsmnUR3jN+HA+kR0AkHE3?=
 =?us-ascii?Q?+VVoINeiT3MBC8e1spCDG0H7GaTvdrMBi8Heu9BEQYeN6rRtUCSe+wH4Thp1?=
 =?us-ascii?Q?EYnb9BpHuxLnrrS7mTg6Jai0Jh4cOdlKTwhRBcNpbXmGHDblhpGDSfpGnAOv?=
 =?us-ascii?Q?/91ygEHWNjSU+gZep4xNlrKm6E8mVhgCHA8Fg8RGCEJ1mLopVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9sSNn5VjtGNTOt/rxxas9iMzW6SwAJLCi44eogempufutVPc+zkWa3yRBVF?=
 =?us-ascii?Q?K5TyvallgX5yme3S9wVTSBjOBKq84sT26nDmdVs+eqe6t0HIGGmD8eMTFOYg?=
 =?us-ascii?Q?8SCauqtTN/nGPI+XlsQueKpw+YO3cR2PnhCbwz9k5kMPdLwreutH7Vdyn2gL?=
 =?us-ascii?Q?zEhmsRDLgYELxoqQcCsU3tMCYCvBa2uMSwa396AtkLW30wvouTT6teUU+c8p?=
 =?us-ascii?Q?7LihmQv8j3bc111jMSX5xGBbYKmZu3iAZiYp986wL2JkPzFJa/43FJxvzSF5?=
 =?us-ascii?Q?Shf4bVdS1b4Fgh1h2WAC4V83mch/UUjxrDPZ/1wdxasIczl7rdFubFgvjR7e?=
 =?us-ascii?Q?BPr70fKyUgfcawBjq86bpIeKtGgzlpquI/ij88OwAEBUOG94/LRkrZo9K2jJ?=
 =?us-ascii?Q?EeMsmnSS1/3wjLrZtc9qPWpsDlDYFFHEzXA3ZzuatOnjkF6q/5nrWT2QFTt/?=
 =?us-ascii?Q?TeTVyHDufJMwOHrwNRBwAt4LBeYkINjWv1lXUaPbqaKyeEZKQstJqcG+hhGg?=
 =?us-ascii?Q?KHq3h8RQV5ej/ZzCbYPNQ0l8EsENIsZ6KqxLZ2vt1MMvL61d5kFSTQIGJiou?=
 =?us-ascii?Q?obZmxIqE3SNZOIrVLsDmYW6cwmTZXJP6saQH0y68VjB5lODQZtk9QkEBzdWI?=
 =?us-ascii?Q?jZUKv1ZWvvXr8tRuxmvmX8Eq9cpKTMiWDFwVBcjibxsPB+z5Zy0dnlo+sHaW?=
 =?us-ascii?Q?5rs+d+iG89YjL0i3UbLMoem3roJosGkfepGwlnYX8WCSsfK3rl81rmf/1PEg?=
 =?us-ascii?Q?lXd0vODVLtQ80RpwPrM9B2hBetrLhzaK8agS9DAmAZEHfieiSV/yoPZ5i8Zk?=
 =?us-ascii?Q?mQQZCwEF01XyKvDsim+fVGMzNepZUrQX3//ZZmzMpT40zenh9rvoAc0yWxYx?=
 =?us-ascii?Q?02Xp2JuxQah/kVwZhV5mYdJPVF0Fk8DgNlecAp19tURCHRa3PerRRYSIUFeG?=
 =?us-ascii?Q?w+ZzRM0En0MZj8b6pHtkowrULX+MClF65DGWbUaVsWpVo1kBHVgQW+wiILMY?=
 =?us-ascii?Q?6EX+e5PiqUSXPJYfGynKQr+LnT9pmJ0hmMk6j7nsXHH3MafwVsK3LCi+StDp?=
 =?us-ascii?Q?+UISo8AY+Ma2oe5krIIUKOfGyYErLE7DdoL4V0kZrhkgArzItXNukdzp4K+G?=
 =?us-ascii?Q?K7JvW6CBeFqlaBTWMR6xuz8TrQ0yk7MKBjs+SopZvGMaIDDrqu+GjxJo56Pd?=
 =?us-ascii?Q?troEXH1Ds6CXIHBhZqgAXkhcuUC/LwAYhrBKHrY45ZtxsKBIvWimJwvNh6EH?=
 =?us-ascii?Q?nUJotdGsGuNb0pNeLHutnUXmQakjs/Pv4dqnRzE3qZtY5HuiwYajozg/9YNP?=
 =?us-ascii?Q?lQpzM836F0MVrzno6JzpbS1pocKqVhSfKsF2V8qlpB2+U8gatJABJFBkDjWT?=
 =?us-ascii?Q?s/VhRW4MRykx0DPsRn76bqG9wtH2pKPqz0lI7UNXf24B0H4TTG4B/n7T88C4?=
 =?us-ascii?Q?GpRiOl9d11wcHjm39+fmL+iYdHbRDJXbwdKM0VOEpmOCdOGTHKyD+VEYMOnh?=
 =?us-ascii?Q?lzRC9E8ej9BC9qQARD2j4LQ8vcSyusD51PB73n2AmKds8VcGEWfn45oEnkF9?=
 =?us-ascii?Q?mOuZV6AnThGsZVv2FxMvu5cU3U9e6pnucUgiwzgP+0iPN6TBrZuDObTl91WC?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29676c17-4c58-4aa8-849e-08ddfcd221c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:55:59.9029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjDQj4ZgcduhidwPkxDElKwvsH2/skX7n/1izPFtdtKq8qFie8th1LyZydJ8pnbQy0KcxFxrslll2/VM2b4Nrk7oebKy6suicDjW61gQbd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4583
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

On Thu, Sep 25, 2025 at 10:47:42PM +0200, Thomas Monjalon wrote:
> 25/09/2025 12:33, Akhil Goyal:
> > > +/**
> > > + * Constant-time memory comparison for cryptographic use.
> > > + * Returns 0 if the memory regions are equal, nonzero otherwise.
> > > + * Runs in constant time with respect to the length to prevent timing attacks.
> > > + *
> > > + * @param a
> > > + *   Pointer to the first memory region.
> > > + * @param b
> > > + *   Pointer to the second memory region.
> > > + * @param n
> > > + *   Number of bytes to compare.
> > > + * @return
> > > + *   0 if memory regions are equal, nonzero otherwise.
> > > + */
> > > +#define rte_consttime_memcmp(a, b, n) __extension__ ({ \
> > > +	const volatile uint8_t *__pa = (const volatile uint8_t *)(a); \
> > > +	const volatile uint8_t *__pb = (const volatile uint8_t *)(b); \
> > > +	uint8_t __result = 0; \
> > > +	for (size_t __i = 0; __i < (n); __i++) \
> > > +		__result |= __pa[__i] ^ __pb[__i]; \
> > > +	__result; \
> > > +})
> > 
> > I believe this is not the right place to add this define.
> > It should be somewhere in common eal if it is already not there.
> 
> Yes indeed.
> cryptodev is the API for managing crypto devices.
> A new memcmp function would be better hosted in libc,
> and in EAL for compatibility with all supported libc.
> 
> I mean please add it in EAL, and propose it to glibc as well.
> 

Just for reference, there is a good discussion of such functions and
reference code under MIT license at [1]. After reading that, I note that
the proposed macro above it not strictly a memcmp function because it just
returns a zero/non-zero value, rather than a value indicating which array
value is greater. Therefore some feedback on this code:
* Use an inline function returning bool rather than a macro
* A more accurate name might be rte_consttime_memneq, since the code
  returns 0 (false) if equal.

Regars,
/Bruce

[1] https://github.com/chmike/cst_time_memcmp
