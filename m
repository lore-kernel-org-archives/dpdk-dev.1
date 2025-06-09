Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE40C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:58:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B178740658;
	Mon,  9 Jun 2025 09:58:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7E982402E3
 for <dev@dpdk.org>; Mon,  9 Jun 2025 09:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749455891; x=1780991891;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VBW89Fd669Q9iXRb576dQtn27It1MuKNsD9AaNKdRUU=;
 b=LxakTjarrbb9TXZ13CaglV7qegz053qXc1Ejk7IPNaiJoefn11RbjeJe
 802TT7xcHBO/o97AjIbJKN+qgGdzoiGYvW87wzpfnn5XF9B1R9LcdBQnt
 E//vRBEymo9Wf+pkxRppigmn4xqG1W464TDXiZMO+kYWffJl3SdXyqLHU
 ThsKVzGgZlm6szkPfnaMZum8P6/VtVL7OqpqPa2EPefjzIsGdPIzV4ROQ
 l++eEcpmUG7vi1DU5T93EQFi3ViynzNrxZgKoDdvkFpsx01s9VQbNHy5N
 ItayNJ4xyCURshXf7c2ZqkFPwEpLYVjkm9ZQVQsYJZiWg2rCA2jfN0nGd Q==;
X-CSE-ConnectionGUID: n0ZBCe9uSjuwTcdsyBqj6w==
X-CSE-MsgGUID: DB6jqATZRuGoPQ+e2pukQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51401998"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51401998"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 00:58:09 -0700
X-CSE-ConnectionGUID: /UuXCd4wSpKkIGqBy4j3rA==
X-CSE-MsgGUID: RKXEYp5nSPiO8P3whf3xbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146325761"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 00:58:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 00:58:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 00:58:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.88)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 00:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypKmohcB/TD2RXEUEDzfLh1e3spllLYukfd5GaFSVaIzng1AOFDV4NqfVsobH1MmQLRiJz8iD4QwCmzliNgwcpVluP7t9hL7WEehnH3NwOFbUmlIaffBcYH8R3AV4u2k2mRhRC88TS+kA5uxtCcenRUpO0g8PGfDUrpKZkB5/i0I75mo8ycRCC0dG4Lf7/KactgJREMRiRmNwP05ScT8zX0wM9wwYJc9L2qtO2IdFL9QrEWZJ3opKVrwDSJrGI7ZS7/9bGgypzoS1BLQguRRK3HWAnpuQrs6vNEBmj2CRsBw4Ql7VJ6uGtRu1OGIcH2zmqBlB3xrC9fkaz9AHvTxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ayylufpkeiz4voVsr/5G23ySnVqZZTNlqM7ix8I0JZY=;
 b=EegH8GAT8bmdrIpN4G16oYIp81oBVlJx8a/TG/bapDQtsF1jF9JmuQx05X+wrbe/3vc6JHYj8uYf3M/YksnzjvA38zInie+myjximfFlbJPcdr/IVtjMx4pGebMB9gnxSCRER2FFZ6pjKOCcfhea/Xd67Xc47f5Dv0gSgcqgtG1dWx8aXmXzlCGuXLJk89AoeGiOokmcN47b+/7jY85ZfF/egPDtVHaIES3jDE9wGmtLtKjwFQuJEUj+x77ppvMSLfTcTYIqRPLDLEbPsTo0uOki8Eta5SIxNgcwIPczrGG/dROzYDFYyiB433wZDVsmPjHIibrutOyv+cSEFfNdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:58:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 07:58:00 +0000
Date: Mon, 9 Jun 2025 08:57:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
Message-ID: <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DU6P191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: a4331359-4b1a-40ca-c6a7-08dda72b5a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n2GgjGM/6e850vzFvbYhVUe2yyzFRDCiuEPiBOV+8O8W66cKwCzPuwKkr6RU?=
 =?us-ascii?Q?CNQcYg9OQYzmNmmNDbOichHINpNcOF3pAZNpRm64xotTWauR+qjonR+p7n3B?=
 =?us-ascii?Q?1Rj+0oLTiMsxr4XYk2stY9acfVjOxlG/9QsyH4T2HmSSfvzO1wjp3xj2byI8?=
 =?us-ascii?Q?c2KeoHble/DhgMMSG/IJxRbq7Hd617D0qRduqJGh1z6QUeq4/VWdmMW0rw+p?=
 =?us-ascii?Q?i1ifRVUF5uZau+xDI947u5dFgOOfdx//K3XGw0xvpAzHCKhKJAznUF0P+bea?=
 =?us-ascii?Q?3IKO1iAATha7C1YaZpctH15ockXoESvaNDthrLmsALNO3DoOEse7WTBhQzRN?=
 =?us-ascii?Q?Vuo7C7bIM684UswEKFPW8nd7H9pnxZRZ4syLZPJbmjZY7j6qeXddbcEg9kI+?=
 =?us-ascii?Q?dwohxGXesHk+ArzxCErv699cB9xLrTLLlR66okhyQHWs01NnbEy1KVDaxW1O?=
 =?us-ascii?Q?EL1ddisi15nTlaXl1/BrIYmaA4jKUtabkXgH7IHHfyIFuNLSxwms2GWlzl1t?=
 =?us-ascii?Q?HuiIcuVGgvCJCJSXL7NbyyVQK4oxUQ9cWYiDCgPzrfnUWv9BzjVXWzf4EDaz?=
 =?us-ascii?Q?FawTT1od5zeo9N9uaDHikY9nwe6rOIX4Sb03UWn+uRtoHouEikptsbyrDrv6?=
 =?us-ascii?Q?iLv/kZle0uVoFF6u2bs+k+FPPJIzj25fhLGahm2hm352PCf/vhM6LsnxEc+e?=
 =?us-ascii?Q?kdBc7sCRgjlen0Bu3Q5F1fcVZ/j9m1uDFlNIgWo+sYkT4+QnnBPgBUNUeGdw?=
 =?us-ascii?Q?fgUjZlvCqhaRNdoZHiU8H40ZzZnCZM97QbI+2HYo4+/5EWhvb9r3JWut0uLy?=
 =?us-ascii?Q?Igh1Q03wcrPbv6v6eH005XDBTlKebC3mIjifiwSD3lZO7u9bXx1Ic4CacLFF?=
 =?us-ascii?Q?EMU9qLx3ZHjL5KLsS3TNeeH0Py+UEXfk2YTC+UK5QBLdoZoOYKeN6IIpLlc5?=
 =?us-ascii?Q?CR/nrK6XaX5xhRlVRjDVwUFXD5toeUHxSv3blHEj2qagxH57p+c8XPJ5qG01?=
 =?us-ascii?Q?cUsA+AkgP9+Enzdy5Rd9vwzpiJwN0wQS/x0QsEdITxiAX10tiRb0lAQtAIuh?=
 =?us-ascii?Q?7VneGStT8WWOjX4kzUTDr8iuxCk4O/kgsx9CgMjXQszQaD6ss+sO7thcC8Ez?=
 =?us-ascii?Q?uoSKe/a+D2C86mp+TVRQk5sv5263yehav793A66K8VzrwgeW+o8M8/EtRDf6?=
 =?us-ascii?Q?ZlR2FCJ8FgHvyHBw0B77D6Fj13+86YMdTzK62YtS/vmesRw67A1nebMBD8Yz?=
 =?us-ascii?Q?8Yn2yoXiF++VAB1L2SgHY4RzjNWNa92/D33BcSRTuYqxmogYRB55hs/tkuO8?=
 =?us-ascii?Q?HF5ohailQTR6SdbSqGW/fRnaFS1QgQ7j3pZJOWUQelPGVtmPFJB3ZN6NuvLs?=
 =?us-ascii?Q?JcfH6SqrkHh6bRAWF3yQ1pZO1UPy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hjquGWpjSdTYQOTcJgeUdMonK93xJ/oUYsQWjHl2OrAQ/0iM7/CDtUtRNUCU?=
 =?us-ascii?Q?wKcnjxJFsZr6zdSN2tJNYILptCerXmlKMG8FULdSxQ3KM4mAfluJ4ToF+/6q?=
 =?us-ascii?Q?akESUYJn56XjNBb9XQVuqLyq5fU+dTpRZNrz3kSkveaqfN7HBUzFxw8KoZNg?=
 =?us-ascii?Q?dBwc/6x+/vSgOwLN273nIs0PrIEsc//evq2lUXKdFRu7/tHc/4R+9EWt/ceG?=
 =?us-ascii?Q?+X3fQ6WoI8YBtU7VBF59MbsUjy6r74I/3lZ3H7ymuVv2drGmTIWCBCxGWCQr?=
 =?us-ascii?Q?Yg9KUhOBLFgch80ISqfmr5P2G0LqTNrQw8arZ1RcNL8lgZOdbhu0+uY25qbj?=
 =?us-ascii?Q?Oz35ACAl/G9rKvzZoIukCWMAKjhR9UUa0qQgd01+tP3KLr4nKj8j9dGygmWY?=
 =?us-ascii?Q?s0V+90TaXn9WqsiquIjGRuBuvs2wWNDqaP9DtIOD4F5fYzH9rtrSqu3DTSWE?=
 =?us-ascii?Q?E0DU4vVq573ITIYbuyzukrQak+cPghsKvZOwmIy/yEh7IehfXaPy82A9syqW?=
 =?us-ascii?Q?tdZjV10/PRtTGMGUYUUATmBtJUyUtDIxEl/X6jIFgAr1akVbJJxuE9KWLrMo?=
 =?us-ascii?Q?aWTSx/BHSstl/kw5Qc197XNwzX+Sm8iZQiJgj6UB77Ng0i/I5ZQWSP6eBZFF?=
 =?us-ascii?Q?HggHRZgQjke0yi5+KzNOn1gjlR8O/Kb/OUxqyAo0tHG110fnDV+EY4S9dl7o?=
 =?us-ascii?Q?HFWw4bTz3Cf94vnodQcBgGdlngi5UrgTKf+eQA2aSfLb+vcPHo8arvdksNPU?=
 =?us-ascii?Q?+TmTHlGAPmpdLI/RRtLiNZ6d44HXD7JvIZ/ClHzekIDoqCpUDdIDootQ8zkx?=
 =?us-ascii?Q?VL3W1Iccd8FqPoMlB8s5rLy9WxzyMGtrKSn0c0u3mWsAU/x4LJyGF7L/vur0?=
 =?us-ascii?Q?KPeGz4icpnEyaUtFXB+1iCKYdBXNUZaLc+hBBrOsQqB8ykRKSSzHHRyLeJ6j?=
 =?us-ascii?Q?VJwg2QHqmSQ5tBafzg0gLBtSkvzB0jkJjGngibjRy0JzuJ82Puz7Ho6zaA9w?=
 =?us-ascii?Q?C1A2PEentYlh9tSAEqSyhbEJfvIQc0QniE34EM2ZOmrnhzjiLSpFkq5w1hQp?=
 =?us-ascii?Q?TPgK6+TcE7uXWtH7c8LFrgGqjO0VdupxGEIa6Dftw5tRt380ubk/qE4WaOdb?=
 =?us-ascii?Q?KxFY8WpWjuIhB5SeIAZW20BSj6dEmdFqKezWMGz6NMtDGSRSLgupZ5Qnmsw1?=
 =?us-ascii?Q?w7ULxkBIjZbcHuwsY+URRAMvvoBOZPcFlwmDSknk51tKdQ0ua+3uNflUgDIO?=
 =?us-ascii?Q?rkZZiZK0EweXKYE7CW3q9NScvoGjX+acAnpQu0XeyWjZIGctAf0wFGuHh4pw?=
 =?us-ascii?Q?OySus1NrsfFHd+PW+MghbZn+8ZYIF7VUbXwUxWbpdEM9W+vJTPMTAsSemXdZ?=
 =?us-ascii?Q?Rr6hj+tHy/RSwSsr7LIh13FWRxo7JDjAo9KcSm0+ersRp8ji6PTfLLH8GgJz?=
 =?us-ascii?Q?cheHlocLttxL0IwfkQmPsQtbjWDT49DhKXhIMvKDCWSoyAZnoTry+O9ZmH7w?=
 =?us-ascii?Q?mzqGrnYJNkpbWq+KKHQg+c0tljDhHuxca5aCl543xk2cDnMqM8AvULoAODz0?=
 =?us-ascii?Q?Dfvw6khh8e8UAqzcH9HCHzEJm4uzz3lSOCSICF8ETBjUUINAhRJws6ferkz5?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4331359-4b1a-40ca-c6a7-08dda72b5a8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:58:00.2370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAKAQxtKNJSlxh5DdRDlqv+3YthpufIaZ5kfJj671rU2HzYi+3CpnZn1ZEjTJiuew900XJ/zgWZaJcOdBvNOl+MwtSTTqcksgZ9t1XL1Qb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
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

On Mon, Jun 09, 2025 at 06:02:02AM +0000, Varghese, Vipin wrote:
> [Public]
> 
> Snipped
> 
> >
> >
> > When doing a build for a target that already has the instruction sets for
> > AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> > skylake-avx512 '-march' flags, as they are unnecessary. Instead, when the default
> > flags produce the desired output, just use them unmodified, and don't bother adding
> > in extra enabling flags for AVX2 or AVX-512.
> >
> > Depends-on: series-35006 ("doc/linux_gsg: update recommended compiler
> > versions")
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >
> > V4: Fix error flagged by CI with clang builds without AVX512 - change
> >     "cc_avx512_args" to correct "cc_avx512_flags"
> >
> > V3: put in version check to work around an issues with some meson
> >     versions, (hopefully) allowing builds to pass in all CIs. The
> >     printout of the extra flags now only happens with meson >= 0.60.2
> >
> > V2: dropped the doc update for the minimum compiler version.  Based on
> >     discussion, that version bump is larger than proposed in RFC and is
> >     now a separate patch/series [series 35006 referenced above]
> >
> > ---
> >  config/x86/meson.build | 31 ++++++++++++++++++++-----------
> >  drivers/meson.build    |  9 +--------
> >  lib/meson.build        |  9 +--------
> >  3 files changed, 22 insertions(+), 27 deletions(-)
> >
> > diff --git a/config/x86/meson.build b/config/x86/meson.build index
> > c3564b0011..e6612dbd80 100644
> > --- a/config/x86/meson.build
> > +++ b/config/x86/meson.build
> > @@ -4,11 +4,13 @@
> >  if is_ms_compiler
> >      cc_avx2_flags = ['/arch:AVX2']
> >  else
> > -    cc_avx2_flags = ['-mavx2']
> > +    cc_avx2_flags = []
> > +    if cc.get_define('__AVX2__', args: machine_args) == ''
> > +        cc_avx2_flags = ['-mavx2']
> > +    endif
> >  endif
> >
> >  cc_has_avx512 = false
> > -target_has_avx512 = false
> >
> >  dpdk_conf.set('RTE_ARCH_X86', 1)
> >  if dpdk_conf.get('RTE_ARCH_64')
> > @@ -65,26 +67,33 @@ if is_linux or cc.get_id() == 'gcc'
> >      endif
> >  endif
> >
> > -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-
> > mavx512cd'] -if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> > +avx512_march_flag = '-march=skylake-avx512'
> > +cc_avx512_flags = []
> > +if (binutils_ok and cc.has_argument(avx512_march_flag)
> >          and '-mno-avx512f' not in get_option('c_args'))
> >      # check if compiler is working with _mm512_extracti64x4_epi64
> >      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82887
> >      code = '''#include <immintrin.h>
> >      void test(__m512i zmm){
> >          __m256i ymm = _mm512_extracti64x4_epi64(zmm, 0);}'''
> > -    result = cc.compiles(code, args : cc_avx512_flags, name : 'AVX512 checking')
> > +    result = cc.compiles(code, args : [avx512_march_flag], name :
> > + 'AVX512 checking')
> >      if result == false
> >          machine_args += '-mno-avx512f'
> >          warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 support')
> >      else
> >          cc_has_avx512 = true
> > -        target_has_avx512 = (
> > -                cc.get_define('__AVX512F__', args: machine_args) != '' and
> > -                cc.get_define('__AVX512BW__', args: machine_args) != '' and
> > -                cc.get_define('__AVX512DQ__', args: machine_args) != '' and
> > -                cc.get_define('__AVX512VL__', args: machine_args) != ''
> > -            )
> > +        if cc.get_define('__AVX512F__', args: machine_args) == ''
> > +            cc_avx512_flags = [avx512_march_flag]
> 
> Hi Bruce, we have reviewed this internally and tested the same. We would like your thought for the following.
> 
> - Before patch: we were directly setting AVX512 falgs for F, BW, DQ, VL
> - new patch: we are setting the flags for `skylake-server` as bare minimal.
> - AMD supports AVX512 from `znver4 and higher`.
> 
> As per GCC `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, the extra ISA supported between skylake-server (super set) and znver4 and znver5 are `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
> Currently for DPDK microbenchmarks and examples runs safe as it is not using the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX` instructions.
> 
> Question: should we check if target is `AMD EPYC` then apply bare minimum as `-march=znver4`, thus avoid possible unsupported instruction generation when non `c_args for march` is passed?
> 

Can you clarify why you mean by the "target" here? Is there a specific
value you are thinking of for the "cpu_instruction_set" option?

/Bruce
