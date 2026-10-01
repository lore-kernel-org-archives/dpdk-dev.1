Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B939CA5FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2354324F;
	Thu,  1 Oct 2026 13:25:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 095BA42F65
 for <dev@dpdk.org>; Thu,  1 Oct 2026 13:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790853897; x=1822389897;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0IXMkymn9QHJvVuqNPzRU3XQLb4oKIUeIDW9o16Hvz8=;
 b=ihPSjPEDs/v/3l5LcgDDtC55eWar2EavbXtL5cOOLp4oH75jBTI7QGvg
 FZzxtl8VsYBVANleF86E4fkOtcjAu22NRsYg0a5t5aRtYZl/+0efVkAT1
 JNBoS7MwcwrlRPURYmy1ht/CUktHO0ErgUDt08YKPdyAXwGkinhtp0YO6
 oUqpCj70axav0dXsEoNJ7MZkAH+DSQIyTPiaG16edKgb0nSe3b0d3EEWm
 A0c81opMk7svWxNcajZHXNEhpf4miFsSHcdxcaUAkZfGDeKv4EHoo+0K0
 vI6kC6f2PBiLsREr9sDPlGXWOUT7tKKght5GTmRv1vaeFwc1BDCSA2OS4 A==;
X-CSE-ConnectionGUID: HOdWUnd8T8KHm+52bXtSHw==
X-CSE-MsgGUID: 6SUHZle9S2KxcwpJ8YKZqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="109089616"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="109089616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:24:56 -0700
X-CSE-ConnectionGUID: PtDNRaoqTo6Y+6/NnUdG6w==
X-CSE-MsgGUID: 5dmkYacuT6qbYmV0HYX72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="276094431"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:24:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:24:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 04:24:55 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSzAO55i8b3pt+076TuAmpYRLCVYXatsCBRfIQm1ssIjWAg8vnTKZoKWptSNaixVH9ZR7PEsqr7/s1lAjmDKzM+DdPywd7cMcNBJhUokUXGl1mwtGvobcLkvAGk6R5OgWdaCtCVWI1Vkuly6DxV85BR3N9ypcywEtRojtj6NZsRZaiuDX9j+Qys2wzf2YxGvZTgDD6X9oX/KFOLs8iE8rHQ3RRRYNyGIYK95dezbtdMfU0umjftcv5P9lw6oD5J3xQHxA3BwK2in49kCDURg8b4WlcHAIieAQWIcAfAV7AgWvI6iIYMhfxovqcZheZJejOsGzqsaxkuXExbj749d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYQ2V7SUSnl1Bd4EInt5Zw5zJB5lxoXloLs1UJJAgSs=;
 b=NaCP+2fz554g2vJeafMDiYD9iFl4WiD3o84ehphfIlNB+0nYnjBrSzyBHJ9PMUkVTi5GY5VAHgNj18UTrGJkQmIRfwxuO8XN8kv4hTT+8zzuLzJk+Aj3iKkn3ob9nwzY+Vlo21lmxLzuz2Nl9IvGT/1myMQ8Hq2NJK0C81sIbI4KA0ngR47pXldIbP9BIJElV1oA9Vf7DJsgBx88Q8XFEkYKuNO0kZX70ZtRfb5/p6EPDZbh7YWWLEp2ap+7qxYlTw2Nupq8T/gh2XWtRvTJN0G7SddAXuLvs8SBLMisSNvj41/HagKOeQPfRmwF5I6/d8oOYeLU1aPdJ0LFyKrtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 11:24:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 11:24:53 +0000
Date: Thu, 1 Oct 2026 12:24:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/1] buildtools: remove absolute paths from pc file
Message-ID: <ar5DAESh3L7DzokJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260609043220.930405-1-syalavarthi@marvell.com>
 <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0280.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 59795681-c25b-40ce-7d5d-08df1fae9cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|4143699003|3023799007|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zFYkcUDGCT9tf1X46NVeLwfFK4RuT0TYYNcPM27yXus6xmgx4GQjYBNrY8fopc8tgvtoUTHrnzqL/cZzIpdPtWdllMFdCej27xMJWOk7dELUTkAX+ZrSbezhCvGvEZLBRXn7M4FDLwrem4c3SvHjZCgPPa5v7UTViQe2/B6rFVqp24ihiowLeYEx60KxHAgtiwgr6fyX8sOmojF3Om9Wq0H3L3vRaxiQgUug6BJ5J1HHLAvqnfFGQyQTE0TmxMgFXFVboRYIwgy4Pyxas7xJNVImC0kCzNkZIphE7iV/rAWfr2hzUFrGPRo1rMsQ359A/VlDiHLrCXRR7Ecb3SI+pDD1T7CT3TbAgaXJ4ygGzbHvprFztZBsuZ9qCTePU2IL5wSXpqZwJblB4UCPlonN24v3PzD+XAefWB6BNIqHdblXGYfHwUJnO6OkXbNSScLnC0Cs5MS4icEIiPVZLCTiFLPigfLhcpoCNSCcxF8Ed6UJ5LlXcCcobuXVKlzxpSOEeX6HMrdz9fnpe68crHOxloilM0blFPCa6Csq4O2wO8FSwk0GMsSImUJxvUjLwbZnkOdHuu3uTSMnOmLZQHBStYSktbSOeat29iSREqtYm40qhnvrs27hRPVROVWQWSAPJXO+B5OZ6zJ+PXRjP4owEtMhC2Y3l+tCismST0GTM2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(4143699003)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lsCKvKx15Fby4AlZ7XoQ4OZTqIjdTrMcS/TDa+PjRoC9ikrRAOdeM3Y3QZct?=
 =?us-ascii?Q?rnPeoKjqO/gX1jIXPmyx0SC/DPx8JL+nFi/Ngl+W1fRbQaGhnSgV5jMW1FkI?=
 =?us-ascii?Q?bd5pyy6tIf8CkKoISt2dbtUG+bVrRbyuQbwKIQLsculbXPbmuYSZV0+6z8ef?=
 =?us-ascii?Q?dEghcJldRxgeRomn1ZhMtNkND9c3UwbRp2zhKkuCvTCKDIrbjIz4nQ/9T2NT?=
 =?us-ascii?Q?WXM/3nDwWRWukCAiW7N0mMyM33UqToRvlhTXqiFbtd1Dc/kujgymtRlBmZlE?=
 =?us-ascii?Q?vzXvVol6f5HJm/CObQzgWXpsTzEhmPfk7yg+PgEAR1Wt9OKd98fOa0t2C8II?=
 =?us-ascii?Q?soZ6WIMjRegshAFwKR7MeX6Ba285m51yZbnGZ3/soGpkc164pQ3IXuBjNrrf?=
 =?us-ascii?Q?H4iRfA54ERvGaOBGnbmVOj13KjLoklI5Q/MNnSOJsLHhyoipye0r8LcBKKch?=
 =?us-ascii?Q?eXgJ8f2toO8361HDDZWNrNLZKTVbBM1Yv39o9Jk7IIViehiIByZ4+kcaD30F?=
 =?us-ascii?Q?TSoqOH2HYM4N3A82VjOX/TQabBLvwaw47WO0tFYWJ78N5nlNw3ieKThxtC/a?=
 =?us-ascii?Q?u0WI+wOE9g5ZsDx3xHKjcWqEtBaB7JNMrcaeGOJjg1LdFKSE+FaD4EViirXU?=
 =?us-ascii?Q?leDeFaHEQ98reyIi3VxUsPbUA42nmlwSdM4xnV9urK2LeWFm3RVQllmA7ITw?=
 =?us-ascii?Q?MqfzRCw/oCmDuHiDcTnICsJfI3DTLqilLxAOD6MMfbu4muoyWe+Yf8Ks74U6?=
 =?us-ascii?Q?C79EfJDaX9KCUjmZVl9skZAyKx6/aXvgTHJnOpFKZmXAnfKxuj6diSbya5xl?=
 =?us-ascii?Q?9Jc2ShVgSLYnqeRuCGgdUrN//g+YSDEskmkZZqO8/WG95hDc+sVZyV6VUq7x?=
 =?us-ascii?Q?PJCshXoyQ8CiniXJ/UFg4mxZ/IQOkzpkQ8qoqvC722+3J99FywfqdalyMYKj?=
 =?us-ascii?Q?Hb22c3/+kPWSlDyMeJeuhQ+imdLuzGZFJTSfcJQOlYVoj89Qrm28I+nqLEJ2?=
 =?us-ascii?Q?H0Xq/ukDt7Pp2/faxzveBXVanTxkvWY4IukgdweQ+z/4f893R4bHIuYAyugq?=
 =?us-ascii?Q?pWlvxrKYiiUW0p2V9moCsdwVAfhIavqaEYa7EiuN8a+0QYKqrHDISmbHy2na?=
 =?us-ascii?Q?js2i198w4X7LylAixyo8oHNK0wDnAg+XPz47XA9Do27m8k1qULcsDiQbWgVp?=
 =?us-ascii?Q?e6sQRGMivG7v5y5o0sPp0EAuI3NdWNaLRZuJ2ULbuG91z2gZLm3XBhRMQEWL?=
 =?us-ascii?Q?KmQqLNW6mGwswaMNrqsKfaEM39b8tT8shBgAsWvH4jT5DZTsMEHc2siXRCoa?=
 =?us-ascii?Q?TwasW8ggYlmgmULSF6EFpR3BEoM1sTyITy6iicrzG5uXvDhcoK0YKjJRIirc?=
 =?us-ascii?Q?l+6NcQvRF41BnkKqftsjAzb40ghtL7i7taUUG3222Qnm5ScyD+l+pEVWaxW2?=
 =?us-ascii?Q?pkMlpsonNHwTXDnXCaDyjZi813YSv1p5T248bVIf6wvlmAXgwEmhYCq0k0Om?=
 =?us-ascii?Q?fJPikflVdZ7GZT32kTATi0BBm5wsMKOnKPPQ+yzyr61fm6zb/32JX2KE2r4V?=
 =?us-ascii?Q?9mAtixykclT0Bz7VQnVQjoq1d7c9u4NrCWeFmXJZXFRYNN0cu2VQfKvTA74C?=
 =?us-ascii?Q?GZdt8r0/Ldevoo5yGadXZvPdXcQyn2t0cyjqfAygBvxEXibVgtiFIeesFzTD?=
 =?us-ascii?Q?el7kLDtogYDipTHF8Raj1gU6hPJIYZv+seHYoSxAh0TgWT/HHk/G6J5AFfM0?=
 =?us-ascii?Q?1zxNDYhAvJKLqzoJGy7H+ZlPmGWKtGg=3D?=
X-Exchange-RoutingPolicyChecked: lfa5FfEQ8guODwnSlRhLk29gZZQaL+ColppZ7tEVdzlOGYSwuNaW389ibvkr711coW0wmWAvC2TYb0h57bhZOJGF2Kc0yjEudStc7H5sI8X5ONDUgWCRymo6J26njRDeO9UNXbjbiDBlOZgcvcRJOoBZH89CGe6j8KiC4AunKMkdq2J2HCn3jIU9sfoaRbGkYIyIhfOSkr+qqbDRcfNIALx7hWlM7yg6KoqkuaU1tCH9sQVOGoRJy8nY23DKD05mkqw6+B0Dxsp5utMHu/Z1Z3bhRgWs2Oz2XO5PZJYROj8rBYHGKpAtoI8fi/hvLrjTKa97UmDHtgX2HM01Am+OVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59795681-c25b-40ce-7d5d-08df1fae9cf6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 11:24:53.1251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDWpsa11PcVQGcDfv2TEeIe+86KVC9G25lyulZUvhAUVBvLCqvYbcT0KmSq7v72TlO6BAFkx31ygYl0m3pBt/K8l4hS6LxxCeSXLRxdKCDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
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

On Tue, Jun 09, 2026 at 08:47:33AM +0100, Bruce Richardson wrote:
> On Tue, Jun 09, 2026 at 10:02:20AM +0530, Srikanth Yalavarthi wrote:
> > When linking with non-versioned libraries, absolute paths
> > of the libraries are added to libdpdk.pc. This patch replaces
> > the absolute path with correct linker flags, -l<libname>.
> > 
> 
> Do we need to check if we need a "-L" flag for some of these paths that are
> stripped?
> 
> > https://github.com/mesonbuild/meson/issues/7766
> > 
> > Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
> > ---
> >  buildtools/pkg-config/set-static-linker-flags.py | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/buildtools/pkg-config/set-static-linker-flags.py b/buildtools/pkg-config/set-static-linker-flags.py
> > index 2745db34c29..bd217b07fc8 100644
> > --- a/buildtools/pkg-config/set-static-linker-flags.py
> > +++ b/buildtools/pkg-config/set-static-linker-flags.py
> > @@ -6,9 +6,16 @@
> >  # Should be called from meson build itself
> >  import os
> >  import sys
> > +import re
> >  
> >  
> >  def fix_ldflag(f):
> > +    if f.startswith('/'):
> > +        libfile = os.path.basename(f)
> > +        m = re.match(r'^lib(.+?)\.(a|so(?:\..*)?)$', libfile)
> > +        if m:
> > +            return '-l' + m.group(1)
> > +
> >      if not f.startswith('-lrte_'):
> >          return f
> >      return '-l:lib' + f[2:] + '.a'
> > -- 
> > 2.34.1
> > 

I don't have any massive objections to this. I'm just a little concerned
about possible side-effects, i.e. if there are occasions where we may need
or want the full paths in the pkg-config output. However, I suppose we will
never discover that unless we actually put something like this in.

In terms of the two specific libraries that are causing the problems in
your case. Is there no chance of getting whoever develops those to add
proper SONAMES to the libraries to avoid this issue completely?

/Bruce
