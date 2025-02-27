Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E7FC19F2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 09:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFD5F40671;
	Thu, 27 Feb 2025 10:17:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D5E8F40290
 for <dev@dpdk.org>; Thu, 27 Feb 2025 10:17:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740647840; x=1772183840;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nbswtp34RErdEfHcKXneP9PUYW5oyBhJYsReuEG0r48=;
 b=OqG+YGKprZwcrX8Wawb1jp5RtAQa2dW59C17oQbrEy0mP+pIpfCYumfo
 Ubk1G3APy4vKuvg96rAmUaEhJYZJO0Up0V5yR6TsHyuwJbs99w2UvhR/w
 XzAXfxC/Aw2puDyG8SkEBqdOCi2A4dUeKkyhvsSqU7vOWGLQTbjgLT4bD
 g4IbmqsqRIRXb+SixHSCJ1mM3ToCUnJSXdP+jRTDO0ZLqqs8lOS/oVeW/
 Tqq5cXLX/vJMIrdFoftjFyuJVqCtisKuQPBn8piSeYZ1l7h2qmp1MEvdE
 gJLdRY6nsr1epSALBwTufzMwRN0EOZfNzi3eyvYATrKdTRDKzAUygl8JJ g==;
X-CSE-ConnectionGUID: cUTdx5y5TomW9z67/kqmQA==
X-CSE-MsgGUID: zdnQqfdVTIO4mg7YIhwGUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51734695"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="51734695"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 01:17:19 -0800
X-CSE-ConnectionGUID: V5UxebPST8OOn82L59qFgA==
X-CSE-MsgGUID: xM3jvV5JQKi1tggDHJyhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121093331"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Feb 2025 01:17:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 01:17:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 01:17:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 01:17:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnxTe35Qh8zVHNMWri56s788d4hUPI/vgguNI/UxtEvB545+u6mzalMeLfML3gXcSVUUhcnTYSvFuAkYNoeD9rmofSK5nAmh29zKE2ZlwFBefgS593HPoFx44DqWZWRcCbGbutl3j6eJczHSIYG3m8hsQwkGRdnzkyG82XYG6WjfYBWO3saq2LgANbzgE/oXXfm443biOHXz/j39B6dBp58uSf7+UbN8KDoEn3YzIzfBaod740tLV1G5JHr+yxR3Ic94RlDU1+y/c4tZUd3oTBmtAhZOvvobsBrTxdVxMTp46gZRPgNfidcAyCW20GOZ217EhzEQ6tqKP0dl9QOyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qRfdUIBADRjQ5zZCawb90f7/OOMXBhY68kC8mvC8Xc=;
 b=qHCnkoPtOQ+Ww5t1IWyqDQ6JIGGz/Ne4DNMHDd5Xu5P/tf+YncwBUEPsi0S0onh+FEEFofAXoAauXt/hXWdvTD5WxsZtcGoiB3nFZQHNYtxRiwGTfoE+g6ctakOas6dfGfcB3GccSu8wGRl8KvDFn+UvW6o6cU3XWKbesC1/T7u3FUa3VhSTPepXYa8CJu8Nqck761Hn3rR4iVG5MNcwlGebS2A459uQkE61W8wwFGz9VAxw+PV06+l6eY/vslJccgxKOQ730t3QTya/NaSPjvwv1JO93R5s9wUELZ/vGZg8OjgqtdhdWi2Fc2Dhq2DbBP8j2mqBEhHmSzq1L8tFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 09:17:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 09:17:15 +0000
Date: Thu, 27 Feb 2025 09:17:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] mempool: micro optimizations
Message-ID: <Z8Atll7rmVM1p4Ee@bricha3-mobl1.ger.corp.intel.com>
References: <20250226155923.128859-1-mb@smartsharesystems.com>
 <Z79G8hI3Yc6kcT2O@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA86@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA86@smartserver.smartshare.dk>
X-ClientProxiedBy: DB8PR04CA0024.eurprd04.prod.outlook.com
 (2603:10a6:10:110::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 4672c525-bc6a-4b47-55d5-08dd570f8669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gkWVLEMDstMHusSOYsE3YEXkV8JTNzGhkrgaYPJ0ES2M/jL4pIC+8YZIxH?=
 =?iso-8859-1?Q?Miwjr/BTTMIL3KGRpdjFBKCWgsV1I4HZTX+6hrAVVGnuv1DgduXkyODp99?=
 =?iso-8859-1?Q?jL7ZsNt61iDPXZ7Uc8iKzLb9n/qyLXeG/kVQ4kvUKAipv0pmLAzS8cakoQ?=
 =?iso-8859-1?Q?Aj3F+6MvSDnnN60ajpwCvWRl4LvUBneGOXcpXIcAjJx0h7Xv9d6EgBJvEC?=
 =?iso-8859-1?Q?DQrN7j3TGQVwrMnRwzi7dEpp+Q7BAy6YtrdUIOXs6WL0ubDMT4/KfY8hOT?=
 =?iso-8859-1?Q?+p2oAoPbwfzTtJMxLGbYIPYADSrfrsBiIMwE3sAyql/1hOze/DveLYg5Yp?=
 =?iso-8859-1?Q?I97twhBOtnWMAKBoSbkh3xT7mnpOVLgi6zfO+ctxOuLmNuSokDWOntO4nX?=
 =?iso-8859-1?Q?R//2xf6Z2wppI49FofWz1tW46TUhu06+511Br1eAOMT50MGA5bX3G2+o6r?=
 =?iso-8859-1?Q?uzHv5RP5KPkAzwXmEiE8tj3gXk+ruqGBtMdRFhhztwYhA/eiZpwHaZ9GWu?=
 =?iso-8859-1?Q?r3vJ6EIjyczhRpAU6mtlkrkd1IFd33DswZFNwJavRwYzRdDc5WETzPXLgH?=
 =?iso-8859-1?Q?cOIsoc09HHV8oVJK3yFlHbIn9sHJa8Aogo984eyE3dHwnYNLRM33ibf4Cf?=
 =?iso-8859-1?Q?FM3PU06Ca+Yl97PI2PZhOaT/wlKicnVPdqMf9SHWluZGfMuwTF+Ks6/LJf?=
 =?iso-8859-1?Q?oV6WsPwQpW4DRABj6cOGLPmwDgI8Oqq2g79V1nSNPP6ARVC8EMJhR9cH/4?=
 =?iso-8859-1?Q?LFaHlp7TCEYoaVuCYzwjXfTeIAFklu4lH+IA9st/J6t45kD1uF1wlJ446/?=
 =?iso-8859-1?Q?kX1w/m4TBMskuUJ/p+aDM9uye/nR0ZWScPjlmACt4k0gpbRfwJxh+e/UQ1?=
 =?iso-8859-1?Q?v/AGoin394Muq83VsaS8o9BA4EFYJGv0W8Q5wBYbLumMtPRcSG59IU3Xxx?=
 =?iso-8859-1?Q?NWQzki54to7SOykh3R4AarxYeAXA7sLjmXv1MRd3NTv6e7Hc2/76WpcRdb?=
 =?iso-8859-1?Q?Fpcr4tcOzLL3CRVaiZIIRzo1WKV3WCxuQc/r901E/4LOlBcSTCzeAlsO0T?=
 =?iso-8859-1?Q?FqSDrBD9qmsFQT3xYCsULKIPW6xz2WXXpP7KpHvzBZfERyJrvcwIx0NJI+?=
 =?iso-8859-1?Q?R4ZGN0K3TgD7DgS9hlhmFnc28ecSiF9mbvh69etmd5APal2DMBRmTJRVKz?=
 =?iso-8859-1?Q?3fRX2EZUIynbq80319tNKQCFj8Ry4sldNRCG/wabku+yJOVZ6wT+gctOQY?=
 =?iso-8859-1?Q?JZ2vDi8c5xGiqy3miDsJ+KENRwdnMDM29GjyBHq6YTffzO+i6ibgoDfr+P?=
 =?iso-8859-1?Q?GDngjrUAxbhm2iE/hlIT8LnfpiATIE7cqfkg1ru1sQPSXpJdYJSsizqhPA?=
 =?iso-8859-1?Q?1r2RcjLPU8bcSl4ufYIzljy9lHnRrQflZyIyNp0KICJYHESWjpxSZK8vEV?=
 =?iso-8859-1?Q?/AXpFp22RsGLEpWP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NRk6HHvs6tTqE6uBPVzn8+t2dozscrXoTYj5kcIoKrgWDnlvgkRyPNMovw?=
 =?iso-8859-1?Q?4bqa7xHFjKZh/GJOa0REbC5y/SXGNOq9Ha5Y41/mm6TVb7496finx8K4sk?=
 =?iso-8859-1?Q?r88x+PMXChMw2aw7KIEmIo1+NIQA8Q9NidNsWWVhi6s+U9ktE/wBl8tAbz?=
 =?iso-8859-1?Q?0+JEk4cXDfyz70jxwJdkgVXu/6gwVd7sHuNltiD9v5NTkndV0pgR8aeIRT?=
 =?iso-8859-1?Q?1eccceXAtGooml/V8cl92dzQtSHgOaPb1jtZhBaB/KTX99TByTYu2C+0q5?=
 =?iso-8859-1?Q?M7f2+V7309sU8u3pAit/cOISVmQVN2wVFk4H/b/uxMePEpop16lIMXBJ68?=
 =?iso-8859-1?Q?TSEiXE01/FrH055Vsd3FmTjCLU4fCjWFq68s5r91gdWmMUI7ylZKT84/82?=
 =?iso-8859-1?Q?xSg94CYQm03tRdAFWJlwKZEWK041HWwPyka3qgq8UyhACIqrOJC8xRy2ec?=
 =?iso-8859-1?Q?7YcR94dJtsODjjeDPndd+KY+k3ITC4vl4A4p5B3qjOlSxvHDml4KofzNa2?=
 =?iso-8859-1?Q?7M7Kp9TEZtjlKMMqOaPBXPNzGaX6j8saB7MUnFHihn6CypE+2OcNrAG6PQ?=
 =?iso-8859-1?Q?9lLggROE6hjQ3HldbUXbw0UKYx3zZ727enV1w7fd26xwez7oYeJ6PYJ+3h?=
 =?iso-8859-1?Q?ZQqLj00KBq1CleRK6fF2P9ii9MCjqQj6P6LNyF15z5Swc/vtn+BnaeISP4?=
 =?iso-8859-1?Q?iwojBBA+Eknp5mi1RVS0bGWlxnVAQVQghZPnhpxTzIAh5KLD7tjCHxhevv?=
 =?iso-8859-1?Q?069geYmQeXHcAFW++uk0mhXCDeMYQTBJmTllRyh5AdWIKa3IurxuwUSekB?=
 =?iso-8859-1?Q?QHwF6/LxLk5lRI+GatFy+p5LKnGkqXHNsTVEOj3UPs8V84bKfDoByF5M9V?=
 =?iso-8859-1?Q?759a49I/BK9xfQWkkxqagi7rqhDXBQ39MKgAl66vZfkpGylcHl3H8TmJPD?=
 =?iso-8859-1?Q?lttJcBg7C2zXBQPoaof5URvVbAGKLOPS+WkFTeeDHuJ6EbpYCbqGRbTWE1?=
 =?iso-8859-1?Q?vGJJzFrgs7pJ1G09a+LgRs81serNVNINaPVLXhvhafUkc9tnHQ/MggZLiP?=
 =?iso-8859-1?Q?emweD6SY1b5wGME9YhP45tqu12Wl8cTeFj4Cgp1qlBgufOWOFE3gKZ/d8o?=
 =?iso-8859-1?Q?hrJI49MMKi20hRpp+l5cq3LDytxjYAm7Fbmyl52JrR4H18YEdoa1jCiZMq?=
 =?iso-8859-1?Q?ubfW+y4S7GKYNcA7vzng/PEefDgd4cBtCE0b71RWjehwnstO79xG3+aS/Q?=
 =?iso-8859-1?Q?03R/lkC7ZsEc4IZq08OiATmV28j4AD58RgfTdGqOlagTntYeR6efja//KR?=
 =?iso-8859-1?Q?sRbxGKzDXU+Ji4G2udVokR/THq1PUF9E8jHVwi3+As9R3vSjYQzgN8PD5c?=
 =?iso-8859-1?Q?uzkH4TZuk/Z9hnqICKk5LzK4uAOBt/VELngRAtaLWpGqUsSNoP3KoJql+S?=
 =?iso-8859-1?Q?mPoEOy/rKqnDwaDfwXh3/QvE3uxQYu1ZwL4BrIWkTOmW3z+LyQngFAT9sg?=
 =?iso-8859-1?Q?M83PTVjY+tKFeYjGto+qFtEwYHXPGjrS2jjkbeTQi7QOdXGdckwpPcb77Y?=
 =?iso-8859-1?Q?Ad8bg92Is83gWeUP3EqOx/Uz7SeWa7km/staexyeWeG1dGHObFNuWgfOxy?=
 =?iso-8859-1?Q?cZApNshLBVkhm9DeTSgS+8kqr+wY9rqRevGCuYOScnCJPp1akon6wkqw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4672c525-bc6a-4b47-55d5-08dd570f8669
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:17:14.9845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7AlSx2HDAcIGwIRmI5jjhMyACGa21+tvLrHqQJaVAh3T2IIS/PmAFoi8dYYyV4PEN1txM1c8i6BfWppQeuIemQITpR6VY9nXhL0fr/CXL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
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

On Thu, Feb 27, 2025 at 10:14:27AM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 26 February 2025 17.53
> > 
> > On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Brørup wrote:
> > > The comparisons lcore_id < RTE_MAX_LCORE and lcore_id != LCORE_ID_ANY
> > are
> > > equivalent, but the latter compiles to fewer bytes of code space.
> > > Similarly for lcore_id >= RTE_MAX_LCORE and lcore_id == LCORE_ID_ANY.
> > >
> > > The rte_mempool_get_ops() function is also used in the fast path, so
> > > RTE_VERIFY() was replaced by RTE_ASSERT().
> > >
> > > Compilers implicitly consider comparisons of variable == 0 likely, so
> > > unlikely() was added to the check for no mempool cache (mp-
> > >cache_size ==
> > > 0) in the rte_mempool_default_cache() function.
> > >
> > > The rte_mempool_do_generic_put() function for adding objects to a
> > mempool
> > > was refactored as follows:
> > > - The comparison for the request itself being too big, which is
> > considered
> > >   unlikely, was moved down and out of the code path where the cache
> > has
> > >   sufficient room for the added objects, which is considered the most
> > >   likely code path.
> > > - Added __rte_assume() about the cache length, size and threshold,
> > for
> > >   compiler optimization when "n" is compile time constant.
> > > - Added __rte_assume() about "ret" being zero, so other functions
> > using
> > >   the value returned by this function can be potentially optimized by
> > the
> > >   compiler; especially when it merges multiple sequential code paths
> > of
> > >   inlined code depending on the return value being either zero or
> > >   negative.
> > > - The refactored source code (with comments) made the separate
> > comment
> > >   describing the cache flush/add algorithm superfluous, so it was
> > removed.
> > >
> > > A few more likely()/unlikely() were added.
> > >
> > > A few comments were improved for readability.
> > >
> > > Some assertions, RTE_ASSERT(), were added. Most importantly to assert
> > that
> > > the return values of the mempool drivers' enqueue and dequeue
> > operations
> > > are API compliant, i.e. 0 (for success) or negative (for failure),
> > and
> > > never positive.
> > >
> > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > ---
> > >  lib/mempool/rte_mempool.h | 67 ++++++++++++++++++++++---------------
> > --
> > >  1 file changed, 38 insertions(+), 29 deletions(-)
> > >
> > Is there any measurable performance change with these modifications?
> 
> It varies.
> Here are some of the good ones, tested on a VM under VMware:
> 
> mempool_autotest cache=512 cores=1
> n_get_bulk=64 n_put_bulk=64 n_keep=128 constant_n=0
> rate_persec=1309408130 -> 1417067889 : +8.2 %
> 
> mempool_autotest cache=512 cores=1
> n_get_bulk=64 n_put_bulk=64 n_keep=128 constant_n=1
> rate_persec=1479812844 -> 1573307159 : +6.3 %
> 
> mempool_autotest cache=512 cores=1
> n_max_bulk=32 n_keep=128 constant_n=0
> rate_persec=825183959 -> 868013386 : +5.2 %
> 
> The last result is from a new type of test where the size of every get/put varies between 1 and n_max_bulk, so the CPU's dynamic branch predictor cannot predict the request size.
> I'll probably provide a separate patch for test_mempool_perf.c with this new test type, when I have finished it.
>

Thanks, those results look worthwhile so.

/Bruce 
