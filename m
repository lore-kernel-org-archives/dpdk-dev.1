Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC0C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 16:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12AA54025D;
	Tue, 13 May 2025 18:21:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C00D340041
 for <dev@dpdk.org>; Tue, 13 May 2025 18:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747153287; x=1778689287;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2gQvOlIjR8YoBPz/H8obKUkJ6yn1x3GPGPHZ3bBfhXs=;
 b=g9tx/KP8csnx2WeqK45D6NgD+4ALEWBKcIOLxIudXYPomuwRzIap74LS
 PDza3XtB218nw/ONxmFbHFLlBQSrLDsaNKMNLL/E719yzdg0x1Yyonqz/
 QE6cSxydb+k65ppXvnSSmM65IVAq7CTQ1cJqXH/OcX8FWyqbE6ryBouik
 4EkE1cc9sWZUYry0xDgb9Vgk+Ryue/KIB5Ea5UPFsn2nHiWiPHqE6Xsah
 RYuVsjrS71fPmdaGrOy9P5R5Dj7cUoqraBqBR9B9FVevvV4SKVmugqXtk
 humcIzafvaW1K74mcSH55+B1bvAyvi23cQQwPL8W1n/mhj12lNPgKotIs g==;
X-CSE-ConnectionGUID: 9D2RNMzhTEuvwQwJG6jXvg==
X-CSE-MsgGUID: I+s9jKSXST2fviqjpQqnYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66419761"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="66419761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 09:21:26 -0700
X-CSE-ConnectionGUID: krbCKAM9RXiWqB/wfI5M2w==
X-CSE-MsgGUID: pdBVlT99RLS1Zo4c/yS9gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="138172442"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 09:21:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 09:21:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 09:21:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 09:21:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAnTqL/V29T6Gkq+yMSremiUD34KdWHPukje+WhY5x2f0C4ulKEUDXww7xICoQU9k17R6J3t7drnH71R9cFC9iL556zuHgm/tt4OaCopZ5hYD7bxqYnb3qwr4vJLrCq9fmjXpzgomvHLa/4bOiaxEdPQs3ncQ0Tj+se7coO+gKUj2HucGJKFsW2Qrd30O5O2mgw+lTe01vkNIgWnrYbrhiLc+Dn8bBjAdFJ11luDLsBOUhDxO40gcRdU5VjW27BA3vcQndwf2hCwiCxw6JbGJl9QNPXfNysuF+akqHlkRMzYCqJJEI7D/XxI82H8fTTdJVI0l8hPHvoglMkqQlvYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvNI2yXdLymQdYqa2EYklR+os5QXcG1wNQqxMxF9KNI=;
 b=sxuWtUEnO5D12hxIcVdVv9tOe0oZzExBAdvIRgHHN2JbjHr6hWJPifr/eF5LC7lHyehHqHwocxe7PREylpYEjoiFMQi54v9xFB0YZI6qnnjhty59ZMc45Kxqr8ZtyvGB0FngtVYcvEXJHlHUoVs0HPhB0Odp0byGiZQ6KNbtoLJPvKjw61CnEcMGnUFxy1vQYbCmYgVZSUCq8JX+1dapGz98+BLZxyuUvXzrzs/ExgtLfZvHk0hgYmmoSf3q/Xlkcbqjd7IxsD0iZOZ3v6e8ADQu9Kqu0YOYtOZ2D75uLlss9D/vpMrsc3Se6QAICgsBaaWa9RHEuBI5g357zy7i4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:21:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 16:21:14 +0000
Date: Tue, 13 May 2025 17:21:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH v3 4/4] eal: add option for auto-mapping cpu ids to low
 lcore ids
Message-ID: <aCNxdZUM25AjmRIw@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
 <20250502151134.536799-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502151134.536799-5-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b3c09c-df34-4fe3-6923-08dd923a2e8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A5mPAFQjAX/H0Pk++ZwgQU0VoYAB08RZROIqur3sBwch9nrI/oz44oEyd+Py?=
 =?us-ascii?Q?vDAzf3cdBNLHPZK167Sd3fDFdy69SFpKCAaiRI6Q5zS7gVDvJKtfwkO1n3Fp?=
 =?us-ascii?Q?xYSWb6kZ1cs5k6cUUmSEGQH4v0R/rMNJu7EGi0r7Ga2lcVdrcXqhyytgO2gX?=
 =?us-ascii?Q?EFny+os9lkb0/Rah9uG1t0zss4TQ8xdj34EJMgo4Fa07Sjt8dWGkM1YHNAxt?=
 =?us-ascii?Q?EyxK6qHuDSVdFlyLUZwFqW2J2T/VB1bZdcUz4zakbdymYFjLe5IQ5vbMAF3K?=
 =?us-ascii?Q?rVWWlu9mH6znwxYReJ6G2QQXPUye2lOT9wBXT9HBcF8xQLWmcP9OUg2q87aT?=
 =?us-ascii?Q?IUBmTAy7iA+Hoo6GAXGX/JQ2WXhQ5v3D4ZsG6rwpQc+gqc2Nwn0o8Z1XbBRg?=
 =?us-ascii?Q?IhOJri6MoyZ/A1PZkeJZNiK/a0BShqvRhNkkKnuPhuRJ5WyeETOpFS3kDgBX?=
 =?us-ascii?Q?cERMmyW60NQStU9MFWXUN8MspYCqxYU8tRFjsUj64n53ChrVCZfTGP5QkMGU?=
 =?us-ascii?Q?dyCj+3l6mJ3ZtIwqQ4rZaqdj4bVZIrTSHc8wXt+BfDnLFirsBpv8nIXhQNpo?=
 =?us-ascii?Q?MJCbxhPI0V+CzKLfcSG76gcjzJKXAeuIAjyBco9HQ9a3USygrFgPyqcJyKho?=
 =?us-ascii?Q?GIC2gn5pXGUK4Nrb1ckBTdg6bRaDnkMQwFIIy9LXTxoHMYj1QRgiyDMEl0A3?=
 =?us-ascii?Q?lh4nxbxK1qT37ImQsPgyr0c4X5DEJh+efUF3dX833G8f5UGezp8HIvM8e9B0?=
 =?us-ascii?Q?QIypdbG6wD59DbcOxYi9joiEdHeu/tMaKMwh6wf1fD9bc7fw9rD6Dw44rmh1?=
 =?us-ascii?Q?24/YnbG1pWhwK+iss77XOkSqGkZc1EmYY5ErHye4qK3n5uerqpIIsiZ8uaHT?=
 =?us-ascii?Q?nNoGNcoCxPfXuVEFqoWKodcuusTW/h9ITqvTEUy0BeE0M629R20eOxLZy9H6?=
 =?us-ascii?Q?wOWYjNKbr6AG4QZuum9RxyOqKrUDqKcOLiOwenuZhr3RjNGllIaR7PvNLN0D?=
 =?us-ascii?Q?mOoYg3yp9nh5MEQ4Cc5ugSGXUjXy0bs+LvQPmpEmDxTNNWd2vddozXXFm41Z?=
 =?us-ascii?Q?tGnShOC5eOHME1mIpRB9JOBdwR2d8HSIzFYVvab1HS6DI3nU6zhx7b2iU3y4?=
 =?us-ascii?Q?wLUJaBO0vf4desVBlunLGx9V+XK7GVubWdKlScuwUeDMFROvNTcYuif/2g6y?=
 =?us-ascii?Q?b/7wVuoH8J6galb2Vzbv/ZXr/fKihyb/uexwK6cwRZlKC3YLruH01Lgx5C/C?=
 =?us-ascii?Q?2NUPmOliNm+AC0wbt9D+teaCuj84uoandHdk07xdbDZ3lhM+lhgBPjI9s3gh?=
 =?us-ascii?Q?kBgSSsRrD/7eIF4rq81vqd6c3wj3XhWtKie4mHlA7IFgdPEYtgVTyk6yWuKo?=
 =?us-ascii?Q?yjDKAcvmDv1HMoNNBAKnEyaVFopBoPZUvLti66rWsJM+pOAr1hGnp/R+3Znz?=
 =?us-ascii?Q?oEpecHaSasM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bM75bdUDmo1sgj7kNKUSkes7r4SpTMOrWw59t7ZZ4VyFEWaWl8l/XDXHINn?=
 =?us-ascii?Q?3ujNUzS8bsHMdBc9YccsvD+1sr7dhT3aEI6vlge5iMEWVaU2FB4Tt4++79Yj?=
 =?us-ascii?Q?225Wdjdvs6R0nwwzuCb6/ti//gu0f18x1OGcJsFUPd2N+Fhe/CRV2D4x9Cf9?=
 =?us-ascii?Q?pHqyYAtgLWbkXqxXC/8ftILqB2qeNwq95fbcfCZQP0oEtEksuKw9ZEsd7jMh?=
 =?us-ascii?Q?MmM2Tra9qten/KPmujQB5fJdSUQJ2XXHMhwzvJqzd7cCX2sEX7tJATsQIHuJ?=
 =?us-ascii?Q?48Ent4+tf2YqAqTywpQGOx+pb0jcX9vrGIRNnheZYGC8OMHA+Bfj5GQAwTdt?=
 =?us-ascii?Q?Oq3fzOd0LzUO2LvDKFF6u6/RI9ABCPUsq6Oh7AqnXNJPsUgSoZeG+gDjLivm?=
 =?us-ascii?Q?kEf2muXCaNdGLz/79qnoXFACxUpqTpXCJoTMEEH7l/4F+5RGx6F4CKA6M9yR?=
 =?us-ascii?Q?kl5hxW2mg1d86SluvsPYiNmx/qSqLB0ktahoH6lfvfLdlKH1jgVIBo2uMfy9?=
 =?us-ascii?Q?WhtdtV5rhbHexzK9zBPWr3YrlNH5vwzMpEHGgO/bDqA2mQals8/R1WClY2Q3?=
 =?us-ascii?Q?4N9BdA9Yrc0ovsbdWc4FoPs5PFiz2XffIPsenbYxgnmd3AU3WeRL/FBTOILc?=
 =?us-ascii?Q?BaInqWrdMEDchOVHcHljVgXU4pvFRYwNN3ewLo9AyF9M+LZRQChcYzjfj9C7?=
 =?us-ascii?Q?nTl2FCu6Arim2Bwsn3mTlDsurNoCEnxLTFjU98ccsFJEGOBmChPYi1ME4BmB?=
 =?us-ascii?Q?TWvmSajrl3KXqHnXcPYRnAapuSvkADJ8j8bc9rJdLr6+zPCyq1lke+nmjH7L?=
 =?us-ascii?Q?mhZXnBOkv6Uxk/qi6UMidfF5indsEMGeC53S1XMY0xoxIePsyQRPqWoa5Jom?=
 =?us-ascii?Q?+8lEstRE4xYib2EGgAeVdPvOiTPnurwynvYNo+81/Z/Zd9hnWvpgYVWqt6wW?=
 =?us-ascii?Q?wBdeHhxKw3duLx6sBec0jv+JpFq8h6TnR5hdUGH4kjGaMHCmXA9/V+1NqtTs?=
 =?us-ascii?Q?CmNNys/mFFZhlM8/96KenmMqXcejXlk03qHQjfr1IhRq8A9z8ZtngMyN8kfr?=
 =?us-ascii?Q?BcFdsDvB6CSDhZr2Ii+YrFcWnnzkTFNUuaBf+fm4B+jAJn09L7XerWQeJCYh?=
 =?us-ascii?Q?s7tNhNzSijNkOzTAhEYmxq3jFOcVtsND8tZa837AJRFwKMpJsDcznXdlRoca?=
 =?us-ascii?Q?p8gMXtOhzA/20gPX+xUjQQXKVLlVKqYc0iMMycl38/SQjG4aa5GdK3vOUPd3?=
 =?us-ascii?Q?ImrWeNO8AvwW9QwJ7ENsHNA3HqQlm4DNQlxDr0CkAgxpl8jCks/T72HeAR9m?=
 =?us-ascii?Q?TJID42ecJXZUmRZ9X5W/EFPo23ydBXsx8UKcIHioAsvwCBt1gUqw6HtqvqPq?=
 =?us-ascii?Q?mViRktoLB59N245Wt1wX9SjA72Spj2TzoKrvWwFH4rCocUlqRfQ9BwsmQIsi?=
 =?us-ascii?Q?HqywIuiYMwjwzHHb9i9u7v5EoXHTXsQsNRiLvvOj29GOkDSDolq27pU1rtG9?=
 =?us-ascii?Q?UPAVJaXmefRU6Wv3/rOO6Me9rG61e9OPna1asFWBkdF365NvD16yYPRvrmrF?=
 =?us-ascii?Q?EF5NkQFM+Jy9mX9dznwG9bpbH+SOMIEJ3b+TPEytXQMh+MFKfRX294kVGvwS?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b3c09c-df34-4fe3-6923-08dd923a2e8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:21:14.6850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRyIxeQDNSvn2wlboKsNQb7imyB268P8DJmbX2PurRgziMAF7y5VC/Oby6rmmyhxKkqenr5pDJFRN3Tk6p0l/qf5VTGiKcPi73kapkFoT7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
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

On Fri, May 02, 2025 at 04:11:34PM +0100, Bruce Richardson wrote:
> When attempting to run DPDK with cpu ids > RTE_MAX_LCORE, it can be
> awkward to build up a command-line parameter specifying the cpu to lcore
> mappings core-by-core. To simplify things for the common case, add in
> the -L, --lcores-automap option, to take a list of cpu ids, which may or
> may not be >= RTE_MAX_LCORE, and map them to lcore ids starting at zero.
> 
> For example, running lcores_autotest with dpdk-test on cores 140-143
> with a build where RTE_MAX_LCORE is 128, is now as simple as:
> 
>   $ ./dpdk-test -L 140-143 -- lcores_autotest
>   ...
>   EAL threads count: 4, RTE_MAX_LCORE=128
>   lcore 0, socket 1, role RTE, cpuset 140
>   lcore 1, socket 1, role RTE, cpuset 141
>   lcore 2, socket 1, role RTE, cpuset 142
>   lcore 3, socket 1, role RTE, cpuset 143
>   ...
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/linux_gsg/eal_args.include.rst | 16 +++++-
>  lib/eal/common/eal_common_options.c       | 69 +++++++++++++++++++++--
>  lib/eal/common/eal_options.h              |  2 +
>  lib/eal/windows/include/sched.h           |  1 +
>  4 files changed, 81 insertions(+), 7 deletions(-)
> 
There is (I think) the skeleton of a good solution in this patcht, but
there are more conditions to be considered and thought of yet. Specifically
the needs of multi-process, where a secondary cannot re-use lcore ids in
the primary, needs to be taken into account.

Another scenario not accounted for here, is the one where the user runs the
app using "taskset" rather than specifying an lcore id. Using taskset with
cores >RTE_MAX_LCORE currently doesn't work, and this patch doesn't fix it.

Therefore, for simplicity, I'm dropping this (patch 4) from v4 of this set,
while investigating how we can improve things a bit further. I will start a
new series with any futher work I get done in this release.

/Bruce
