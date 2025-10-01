Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A7ACCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 10:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE7B640A70;
	Wed,  1 Oct 2025 12:16:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5FEF7406B6
 for <dev@dpdk.org>; Wed,  1 Oct 2025 12:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759313766; x=1790849766;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8TB3LABXHbj1lOsfQsRCR/RbnNanrx/5mT7Tc8kkv+0=;
 b=JZ5TMwoLxycDzuB96AJCXBC60KSYSKKtiztjU7Y/5UNneMKZ+PI+y7j+
 C0V5ioL4SmuNHcouchyns0FiFI2eDZU5Cz77ir86URKNoGE7Bcv1lccw/
 fI49zPCp5GvL/ANgy/aEllUDpqZlXj8t66XhfLvoo8mn7toLXNWY5aAdq
 jmlQ5h2HGFTm9LHOoDjMiOZ7X+7FtSVT40cEJzcG+B0tmxdgsYhZBG+7w
 W/CY0IHqHytTkN2uGQlbLF8zfHv40Haq4LaQgNzLNia5awWpEiPUlJunP
 UxGoqG+LuMjnpoSFkFiOOyYY2fASMx8jpZJ/pqdbpthjDxBWaO8tSldsA w==;
X-CSE-ConnectionGUID: F1tj64/yQ2uUd33xXnkb1g==
X-CSE-MsgGUID: q5jqcStzQ7O9KeHEppudRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="84203641"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="84203641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 03:16:04 -0700
X-CSE-ConnectionGUID: yruE1b2PSAO8ZAgbCTQZbA==
X-CSE-MsgGUID: pCtEI4FbQzWbVqkr+cYh7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="178700243"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 03:16:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 03:15:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 03:15:59 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 03:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgFR9lBy0GW2go4Fhv5bM2ugioI8WXtjPzZ2Fj8VyMofhxGB6qrXPgOcTlzgCu85vJDmTDK5WE0GDmkQlOLRwpS5I0VSTWF0Xb/Hw4JmA1DrlUUvhXgSOR1/p9wV2z3TM3Gbz64a9K4L+UkjVqqO4i6k1VDON5EFi0p6fOUtetojWG5xTmgwV9xeWdpvR+JtQx6fWKT5IJPH4DAA3cxzMjBicjnEJRSP+Egg/VcusZuIFTbrnoF5UMmKInK6HymMjuIgLtNLTTLAtAShhOx7Sx9/BkCdOGt4VnVrwvHoQvs+NLk8bGcd4lCFZu2lpfaElLxKbdFblPIsEB4VQx2jvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+J6k+5u94afqn15yuOBSzwJG0a5rwZl7cmcmutj2cs=;
 b=E1egt+WVETMNu0mJox3v1nozfjwYIEE56depF8Enx3HNqyHEUrUfGb0cy8TwNT/aFrVz+9TCN6XdK1EhJglB326Y2eYgzvwunxj+k0rgvxksnJZg+WgjqaqZ32xiviZEcaAerYwuqN+STdZDiByQ1+m1YWnVcM4q5zl90eY2gpEkmrJi6crTPY2cQvEcLW0AaMDnvcWp1XwCVb90QXnkoeM7LH0OIDHQFSB3sLdIOpuVBh4BAkOxiJgFuBkaBI8vlzpMQ6apSRCjrJUf8C8eANb7xDGTgXmfFlOBrD3SaETFQeHbRiiL3ZeSeFyFj3lazTveiedWyP6r8xc5HF2zqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6018.namprd11.prod.outlook.com (2603:10b6:8:5e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 10:15:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 10:15:56 +0000
Date: Wed, 1 Oct 2025 11:15:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
Message-ID: <aNz_WNBCdzcvBSFY@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
 <CAJFAV8yroWbRDO2CYBwvKCRkYotBEvA18aQ0HGa7HMJx5-nSig@mail.gmail.com>
 <aNvzcRQjOwRkydn0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8w936Lb3rHWpfacVPBy=vchSyK6kWHRndC5Ytf6U-2gcA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8w936Lb3rHWpfacVPBy=vchSyK6kWHRndC5Ytf6U-2gcA@mail.gmail.com>
X-ClientProxiedBy: DB8PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:110::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 426c27a1-0880-48c1-bfb6-08de00d3827f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LuAPPMXNSMwk+u9cjxziJMKRcXzIqU16InHdcpkxhF6hUFxSUPsYMUQCRMCG?=
 =?us-ascii?Q?uTEnWCh9+cdSYU2QHF4QHf1AJTOPSqiN2Z8NQ860uZWvwIdLZ1DvHfG0gRy1?=
 =?us-ascii?Q?Yr6AerfHHGEviLQivM73PkJQ3oJ8vtwp2xtGXi4rXgDX3iGbgxKZfJ9fhoNN?=
 =?us-ascii?Q?QBhVHPCqfg10BCd+ZDU7gjS1g2YQWwuiW5Zc/s6G56X/XFexpScSwVaYWNQF?=
 =?us-ascii?Q?JlzxD8u98f7Md6+r38Y/C+efg1+uG0ZDmhwabcFuv9vCLEI4z80+zLhNGqP7?=
 =?us-ascii?Q?i3mjxKYsG4z41j8kmh6fzw/2e3Sb9nRdGwK+1abpOUzCT1RMOvBCmliMMAkr?=
 =?us-ascii?Q?loBErMazXaVg6FxyHOXqv20hfVuI7xf4Sg7Yal6YTlse2Lwfd2VXYX8sCp42?=
 =?us-ascii?Q?6j7tayeinwl81bR0TTToPPTM1+k8FDxMZg9LyHU/4O3X0vrm7P9aqPma+CFs?=
 =?us-ascii?Q?IX/25FsIOsnKXepWaU6+3I8pkJgy6LNASwGtFbmYUG9nrg6NXxBJ7SFMXRY9?=
 =?us-ascii?Q?qhpLTKDfxRzu7LpbZfsQzfNboCfI7NMEZAbWMkqhXGmn+PLhF/Mg7wD29/wg?=
 =?us-ascii?Q?qsH6TDbfDR4Pyf3gOW91IpZWBtcsw/dYw7gWZQtHVZhkIGsWxvobhLuy6P1i?=
 =?us-ascii?Q?W5OPsVOcxmc1XXkhWgonliC15DsogY4WRBFjhG87InXScQ2h+I7SXJ+HVGHZ?=
 =?us-ascii?Q?DOoi09mqbs0IpvZRv9fzuDHkkYUxbJpEw3EEUVNqYAj9evbOCzAaJDfceQ1e?=
 =?us-ascii?Q?Cc+CuDbiEGL8FUu07gtInnSdLHBwIirsyfIegLlZK6sD9AFIsxpxHDHWTX6w?=
 =?us-ascii?Q?AE2SMx3M9l0GGbM4YbzZoSGlZddIPXqRAM0sFuqkX3xb2Ff4iRqagA/Phmk4?=
 =?us-ascii?Q?o/sAhuY1XVe7wIDU5xEZdZ0DAUNp2/CcGyVbNMtG/G0Dini2tfk9EzkPHuHk?=
 =?us-ascii?Q?+J09E6Lsc7Hr+RJr41KnwPO6J7Fog2rDT73vay3KJw9r060kdksu7SX19pT9?=
 =?us-ascii?Q?5/tqHigQAdWo598R6mMqhF04EPz6/oRK2+UP0+IUBCuNOlF15LZYikgCMyou?=
 =?us-ascii?Q?3tB8l3CZbr/254US9iM7fA1WNt7Rq6JvBdEZMuH28qIbjsv6Ib7816lbRRWu?=
 =?us-ascii?Q?4R1708iH+jNLs99nEittentPs357R0bmAcwBvYlz7KUBtWJIcOHw83an7dOJ?=
 =?us-ascii?Q?5IdxBsEwc7NUN7AAt8s1jzBm7atqhZ144KMCyfJRki6/QT0hn5fiEZdIy5h4?=
 =?us-ascii?Q?urYsiycqhC/RHll0cNh2zkq1BAB0oEBBiW4GQsPn2fWFp9zteWj6Wc94+ngd?=
 =?us-ascii?Q?t6+Fsi6Wxk1achgK40tnxllJsLliVfPEXEdcUJW7VKjSe7WcGxxbTuLOixar?=
 =?us-ascii?Q?NKP9Mn5m9udRi3HqJtrEZFv4sQNQJ+NXsD5LvMvMsV4XSbvqyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qm7Y7+8JmI9MsulMpEe9xU7zsb8l0o03fduvfdLzI3Oob0GReKftJSJvt+oq?=
 =?us-ascii?Q?GivqlLAwxomYQ9FoGH8JY+oEoe1S+T0tjgHsHW+1g1lCgEO0LyZLeE5DIG34?=
 =?us-ascii?Q?Kj79ugu/H9CuBVRi2twvcaBr2jImcWXQOIJNOXgij8CKA6x/9qxmLraz2XgB?=
 =?us-ascii?Q?RQgdA4Z0ba4UK82RLqaTdOrpsLPPEUMbDBesgyDHbTKANlndKDBNLYzE2cM/?=
 =?us-ascii?Q?3iTgTzUqxQyFi8iqtXPmv3ZIiHcdBvWHEnsyA24lN19JEFVer+oFIC9VJuER?=
 =?us-ascii?Q?vzgc7STithvotDS2QRri8k6XS0HXtkwE9eMEmYwrijZ6E9aPLvB9YfraiJXJ?=
 =?us-ascii?Q?ek7nSeZUkbjP/o//93EeazH3GlLGf1JkKDWBwdlidyDzi6wUdR/N9H0cnNvu?=
 =?us-ascii?Q?jXVRjyZ2/589N3ynmPtjJUykduUsIFHgG0vP3JlR3nSG0EDjvos0wpAw0d3K?=
 =?us-ascii?Q?z2s9fUgO8xjpPJpDWe53ITPCwpB3G3YxMkOcjoY3Q6XnOPsNyob2hD5KG4ac?=
 =?us-ascii?Q?jl3QPnTUvs4iZNSywvjQFE6ExuOVfyTumU+SqitTvCXf772StTICeKeXLLzS?=
 =?us-ascii?Q?SjjLZ0zzutE48Y4fwpzXFs2MjGg3z5TPwBYF9jvjJELTfxT7X4X3AOdUFUPc?=
 =?us-ascii?Q?tlD4fUbuLDsJ7TWDMP6lX4HIZyleiMfBRtpQ1FTlhg2KKRIp5QHfqiJlsqX6?=
 =?us-ascii?Q?6MoYtDmWhsNC7rbXfio+Q4lUSdKw1FvefsBZDggh+wSl41HEGiG61jSqcmj2?=
 =?us-ascii?Q?zEiGl7EKYQNt2PoecnjqLW4JRzTVPexCD6NjTyN4ckZadq3Hj9nmd7h4IMzd?=
 =?us-ascii?Q?Iyiqq/mo077wj8jDtedYEUo/3j4wWtEkPhGR6TeXJ0nZ8qGw5JSIYdWR0T+D?=
 =?us-ascii?Q?2kM1fJ5RLzjeA86Aebg/uaFGMEzXyVNGwOdLL7PAHsTCXghhsBCbZUkwb/mu?=
 =?us-ascii?Q?JFbY1Rp5lc9RiqNIzJpTdgpQObG3Y5/B5yFZXefCR1Z6lljhiCS5PhuRSIL/?=
 =?us-ascii?Q?BC95qiLLcAotev4kEtRanBQ1BRgwKR0xnMREDFvGDyS3c58zzfYkZJKD3YCg?=
 =?us-ascii?Q?O2j00m1AaMY0setv6oYUX92p8gWlF1bbLVQ6UG3v2n4E7JVGgb7mEPB+zMHX?=
 =?us-ascii?Q?tJQVMlr+d6FeXT99GSUOE7YkuYRjWplh7zHWV6h9vVZ7Mlqs5pXCUK/sGc6U?=
 =?us-ascii?Q?jtvmAMfLtODA/WMIe+kvP9cBIs3ceF2M6cZmqZ241i2C4OgfEuyyXSw8o8G7?=
 =?us-ascii?Q?dy2Q0bky0z6y87Wtt7A/mmbbGvj+zKjyBRRslzesOwi6VTMsyWyUlvuMsPQz?=
 =?us-ascii?Q?4S1vfMKOqCTjKJgiLBNXZ0ZmQjwly14t5FS4CCuHfCA0JpQTw4bzLWtAQvDB?=
 =?us-ascii?Q?tBOXEtrfTgbn/g+sBmnLefcCUePxRUD67X18taGHl90vDcAULIyK2xWCRitj?=
 =?us-ascii?Q?qOgIyi2155Z4eqR+gb7Mpot1PEbCvwOD2BTleWKasrR/mFjGiGECUm9RwXJ9?=
 =?us-ascii?Q?LQXl3cC+4XT7kF6J/XdqXOIhRFsr/ZXT+0Y4NMchpTeqvizn8i1NjUmZ/ZFL?=
 =?us-ascii?Q?k36MbobT4RXZnZhsYfnWK/gmCPkG0mZHyxGExNINldWDcbU/8xM01U5kYbm+?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 426c27a1-0880-48c1-bfb6-08de00d3827f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 10:15:56.2811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqgZZ7pSI7uhlkGDXy2RoVV+ZdXMwWUnz779W/iYMNLxs2DjioHJocHgHfEzJClJEcwV7RkjDe99ySKe3o23EERPaE2PGi3aJvKk5/ZgVFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6018
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

On Wed, Oct 01, 2025 at 10:46:22AM +0200, David Marchand wrote:
> On Tue, 30 Sept 2025 at 17:13, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > It seems this comment got lost.
> > >
> > > Options don't change that often, but I would prefer we point at the
> > > right release doc, rather than origin/main.
> > > What do you think of:
> > >
> > > @@ -164,11 +164,17 @@ eal_usage(const struct rte_argparse *obj)
> > >  },
> > >  #define STR_ALIAS STR_ARG
> > >
> > > +#if RTE_VER_RELEASE == 99
> > > +#define DOC_SUFFIX "-" RTE_STR(RTE_VER_MAJOR)
> > > +#else
> > > +#define DOC_SUFFIX
> > > +#endif
> > > +
> > >  struct rte_argparse eal_argparse  = {
> > >         .prog_name = "",
> > >         .usage = "<DPDK EAL options> -- <App options>",
> > >         .epilog = "For more information on EAL options, see the DPDK
> > > documentation at: \n"
> > > -                       "\thttps://doc.dpdk.org/guides/"
> > > RTE_EXEC_ENV_NAME "_gsg/",
> > > +                       "\thttps://doc.dpdk.org/guides" DOC_SUFFIX "/"
> > > RTE_EXEC_ENV_NAME "_gsg/",
> > >
> > Yes, that can work, though RTE_VER_MAJOR doesn't exist that I can see. Will
> > rework it a bit.
> 
> Ah sorry, it was in my previous comment:
> https://inbox.dpdk.org/dev/CAJFAV8y5_O3T6hLbZov0LqhXyAu2s_n0P3C3Y+WSGVUjd8gbtg@mail.gmail.com/
> 
Ah, ok, sorry I missed the comment the first time. I've implemented this
without RTE_MAJOR for now anyway.

/Bruce
