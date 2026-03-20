Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD201098782
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5EAE402D1;
	Fri, 20 Mar 2026 15:18:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 95573402B2;
 Fri, 20 Mar 2026 15:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774016298; x=1805552298;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9R4FVVqEmrTBjuAZQqGiEwoIretsrX4O0eNUwtdwcU8=;
 b=aB62ym/k8NuNkEkH9VgWDCNUkjUjcfZ2UOfPf20zCzshO9wdGUWitMK7
 5kQGDssHf9V2SnOdjBJG19KSn5CgFpRncuubhZ3UxBeeXBbzE6JwODU++
 16Z39ImYTLNiqLXEyzA7FS7q1wRmtgddKGZnbLDWyISO3N5VFhPNsg5us
 0VoP1mhERBtDrIcGEHAnbqQwgerrPKz6JIEYxvMFsEfh2doN+WCRx3sOF
 8yTofbix9htFyZy9zkeIgLt3mHSZWi2ckA65sLYxieWUhmnkcM9L4i/S8
 ZDYEgyimlo4SAoFNfQmuBNRM5hi+R/izC/jMnWe6136fI/vePYPU52BXB w==;
X-CSE-ConnectionGUID: xlal6ZrrSJy2/CntNM9r9g==
X-CSE-MsgGUID: QlOTJCLFQ6CFgoyVcWw64A==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74993296"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74993296"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:18:17 -0700
X-CSE-ConnectionGUID: htNwwT9cRdGEGRYv+ebKgw==
X-CSE-MsgGUID: 0ZzjVLo+ReOnuJIqq4+8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227784576"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:18:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:18:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:18:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGjRiP5NeEDP2TDFGEIBGO8QH17W3yICSPBSEZd9sp0QFSTJETgk6LOVY9Uoo7LBkEagLusfMiqKdiO5QoWk8QZo3zkW8bzCKApjKqT2DfEI7MIAbPsgJFPFjWPID2K5z91Bl1klC1Uf2shybPJ56tpErqeE+yEg8OAWRC6slLNPLzu3h8ZJ8o9lQvtvni+hlMPUymzYeQVqQIpy3ReStopV3BFR27G0vZdP81ab8VWzYGbouqTKpRhnZwkk2OxeNXphu0MC7M+nv1HENfToD7stAzHEU2SqxTFACRoZVwELFiICJNLVF2KLu+uCRstkukV4A1xXWRtoDhcm5hk0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIHo+ppQMvmo67HJ9E7HN4FI9XSQcCJF6wTCAo/vjeM=;
 b=iz+5TrooxOgCIDDpoaVSDnmSceGgxanl+mF40YF0uybaWXwPK9azgk3Vs/F2zkmBECgpo8HubPcXbG+wt4TSKq0oDFjW+p8sAqwGRTqyNES2xFcEKSAhHKjbwr2YCiOXa6XZTxhxE1BxgaaQwNKTC1IavHIORqYuvUjmy4VDUHMcg6mE6ptr4RhD5AMJNDjfn7t6rZEoTMITIxzlLvCNw/inmk+j0RJ1gL85TNCKQiN20bJ3VkWNAoO73FuK0VzW/sme8Izn3HSyq/ola7r6E0IwpHmgL4ygQydLcm17Rew+LyAI+vmHDcKAiKqR4+5CYaUdunmsGqWJf0aZTUtojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH0PR11MB7167.namprd11.prod.outlook.com (2603:10b6:510:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 14:18:10 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:18:10 +0000
Date: Fri, 20 Mar 2026 14:18:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>,
 <stable@dpdk.org>
Subject: Re: [PATCH 7/7] test/debug: fix unit test on FreeBSD
Message-ID: <ab1XG_ehiP4NTUkV@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-8-bruce.richardson@intel.com>
 <CAJFAV8ztqM2i3QTWQV7E_fo=N3DRJpvxUBvT3ykJtXyRwQ+bEA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8ztqM2i3QTWQV7E_fo=N3DRJpvxUBvT3ykJtXyRwQ+bEA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0328.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::33) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH0PR11MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0b7421-eddb-4d79-bf75-08de868b8333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: e72LHeC37HuDHf1KV7zA7sTWucya6axEivpD30OsB6X/UiTiPIbU80WFcMoOKp+BJwqjQqdE7aKFXVpfsSnT71jxgkj/xHTJ21s3/XsIeyxk+hhZtE83e6/pV0gJbJSXMyF1qWlISXKsGa9m2Yj9Pg1NRoU6OVQcU08+jpYgSVbLC67JLHJeDbtr/fllTl3hcUKbgVr+ApE/dzgdG9mFuJC+BJw1bH5qHQs20koKUklFhzOkeCr99Nd/8XIuYw24ApJ6l8RAOnz6DToEWCwF2ikb7+YykVMxcChg0Is4RaETpjBKF+fRCnLLFCCSIpYcxx0ZJFaCbb6ffGF+wPqJVHp123Y4V2WJL0zXRe+wEKq1AlxynRO3sjzyVFCjO3ATF+6Xuhr9uKW3EfedCkWaj2Us4G37vjSc9X0bFAlSyrn//4K7HtnpYjHyfLUkcfJJAToKcKuRwtZhWMvmBso2vLbBcRfVyH+sAgAhdhHTpxazyRmB5Ni8+GVVvZyvpLiqpKfvn28JfQl2wv8RKm71p7Xy3Encoy4qh+rk6JcPEPgBFyZ8WKsXo3mgz6vh3RbfmUb6KK83zdilZVs9LOF5xJ3IGM3hC6MDdHeNMlSpk4Bw79zv/sOCrPGXO1Og/eTWgbDMqI2vqYc3ie5i5Q7l3cIJdTqDX5BILjkP+571oLx0/tmr0E6PuL9Xl1o8ah4R8WdmTsebGBVeJ6+a5QJ15QGTf2Nk3Ax9vNidwL2Sbps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6OhuWWVmHgQIbN0fuW6fnYRUH7ThdXpVOrEaBJGkLoIlyw7i64maTI3y2R38?=
 =?us-ascii?Q?D9DmJwQkTF6Mhl3JMbpyzU421N6BsatSnjfcEfi3DoAER0qjMHWPB6fRMrDG?=
 =?us-ascii?Q?U1jXQTSGNMkN+dfNZ6sozlQBN8Hvkkc7lLP3Gnhs2FgAzoeUYWzrXvQzfs3q?=
 =?us-ascii?Q?4qN3esumalFMQ1Q1FbafmIwWgejECGJg2FIIsfiuWJx2oW1cnVBspJg19Wjh?=
 =?us-ascii?Q?hp+JBaiV5vp8I7c6qrhPUT9QTsGbeicDwEN3bEuUnf6GiIdo1POOgtnmSge+?=
 =?us-ascii?Q?HJGgCvShz1FXWI6sVZCQE4Cxth9yuJw9xwLFe0V8OYVB0+e9lxD1fiK1sZT/?=
 =?us-ascii?Q?4PB4oY8E81aFwH3KdgsnMGzSAlcactzkl4Yi2R4DucG5YDii8fuvfPGevDfm?=
 =?us-ascii?Q?OyLKCOZEMNuj0QgQHn5O+we0BHjb6MO7VWvF5VZf0ZJKC4Iy4g3ARLEMX5fh?=
 =?us-ascii?Q?VUyql5bUPOm755qFlUwcMXRPVxD9PWYsb3DFMSMjBBDj6+7gh6WPYbSQN87Q?=
 =?us-ascii?Q?dOIMhhTTfdmf+Gq7wQuWorgOsbcvXxhVcu6eDWmiFz7wDLIDPsCb5QbG+igO?=
 =?us-ascii?Q?T+MwJ2KFr5B0Azkh056i7VJYVCmybqVSP/wVdj66zpQLrxZjXeYHaNZUklC9?=
 =?us-ascii?Q?+SDtoj037GCXC3urAr1+YgMshpaTG60fLDFmpSUmY46m+CYFActUX4fvVyXN?=
 =?us-ascii?Q?CPN1zrxsvZSVK+9FdW1UFQSRAMNrcsX0LOR1v0kweRST4TJ+aAq5xDy6SI6Q?=
 =?us-ascii?Q?zkOK56MzLe34jHawyDk3RovvdTp8qOAfYtK9L53wwgdlkP/50Zz4T0B77YR2?=
 =?us-ascii?Q?+WeC56VNs8wjZ7rL6stfMfXYtV3vj5IFCqdn9V3mZT1HwUtzn1oTYH2UnF+M?=
 =?us-ascii?Q?AvUvs2e5ysbqzKwULL1GfTXfgDCSQgNKgkvTqi794nnLsQCb71kGmq2tejSd?=
 =?us-ascii?Q?1x7Omiub0ZKZ4MX2FyZQcrvUBizVd+XRNByXCWKnmFMj7b9T5KKhOst/vV7j?=
 =?us-ascii?Q?6A+bnTS+XbIA26PFcSriFOMkSjXAoF9bxqv2i6rn9D/GycderPB22Eh2fXyo?=
 =?us-ascii?Q?Mzc8jwKDZRi2sxhhrEuvSiVk+vZtYQu2wzLWO92jdqUOkrwhnfhuYzJgAc9g?=
 =?us-ascii?Q?P7lWVUIQqJcY+mJqomaeSawva8QZDczClRq8YfIqI5M8qi4x0PRcxxqA9wcM?=
 =?us-ascii?Q?M+1U2z/7ptrHwUdrbbOsfdPCOeZ2pljTj6HV/lMhunDT7AcqOdShpG5PKEOQ?=
 =?us-ascii?Q?ZTatOfty5KhaiWYJ3WQxyOTtS4vcTbEFrna95F0OnxYzKwQRRNjgH0ZOkmdX?=
 =?us-ascii?Q?hCTkGQSRR1fu5lzMroz4gb5YNsMMktP2Xi1PXXxOfb80oXS9dG/MdY8qHojQ?=
 =?us-ascii?Q?XhM4O9T883PgDVk9OMhSp2HQJcXvgk+LWbv1fEbwnjWeiGZ0FQujFT+BjI0t?=
 =?us-ascii?Q?WQ9WO5gHJj+n8R/UWVmvAe9fyszfvROk3GjUUEl7TGh3Lci2YLGEVHIPwTvW?=
 =?us-ascii?Q?gFnmOAwVWCbeT8Xekm0iaYrV0f+Z+MVNc+8s3KZ33MI1Kro8r+SzbtwM6juY?=
 =?us-ascii?Q?0vxKNqipANommL8+2oDvaoceAA1kEcTMSR0HJsnQ7J11Fj/cwxsEVaQqw2Ka?=
 =?us-ascii?Q?tEvJCVlK6e4ZX8+op//szVXDmGWgdWLoy52YOzyqeEn+LySDC5yv0f28TyLj?=
 =?us-ascii?Q?01UCjVkx4LTzn7OQ1KAln+wVsD31PXy4cYiibnzfqomEEgwlveyJFXQrdTEY?=
 =?us-ascii?Q?RiXiSdoXS4iSX0pYhcm5xhuolmXPW0A=3D?=
X-Exchange-RoutingPolicyChecked: Rbjt+rQTYQGhvSxlZ25QDP3VhUPiIABl9uxmzU7hrhwMEAzRoo8+146KeNW1xyx00A4bgr36ZWArp+1bMCdxJgXOQH1toukdXBuXtzfGATD4Yt27HXqGg6T2N3Dl3N7TnXv25wDXP+lni8QSITJAWNyFtIHC4GlBHQfOhe0wy0Z52TArh/EzJfFF0jLclVTRn0siiIM7tbcVrhMUvzJdh2wh9a5omriZBt4B2fRYIcjVF3jIlpKcDunv3rUtZKq7sGFXxsGQKymBsaipLBya461RCLBV3wH4F6RbFsr2F1+3g1vp/gZBmf8AaTMfuIKFr377dr6OEZaeb0aRGrzIIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0b7421-eddb-4d79-bf75-08de868b8333
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:18:09.8878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9nqH9f1vgJPEFWvtgzjQt2Lth4vcGP0xMj6BbjJCmLD9adQFpgyJDpTBc9JZwoBJJWsM1LIzRmRL/Clp60QdWQ1mnlsA8AP3hDjVnUDr+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7167
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

On Fri, Mar 20, 2026 at 03:02:54PM +0100, David Marchand wrote:
> On Thu, 19 Mar 2026 at 18:14, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Fix the test_debug unit test on FreeBSD by:
> > * passing no-telemetry to the additional process calls
> > * ensuring that we always use the no-huge and no-shconf params
> > * removing the dependency on procfs to get the exe and using argv[0]
> >   instead
> >
> > Bugzilla ID: 761 (partial fix)
> > Fixes: 764bf26873b9 ("add FreeBSD support")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  app/test/process.h    | 11 ++++++++---
> >  app/test/test_debug.c |  6 +++---
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/app/test/process.h b/app/test/process.h
> > index df43966a2a..46b69ce330 100644
> > --- a/app/test/process.h
> > +++ b/app/test/process.h
> > @@ -96,7 +96,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
> >         int driver_path_num;
> >         int argv_num;
> >         int i, status;
> > -       char path[32];
> > +       char *path;
> >  #ifdef RTE_LIB_PDUMP
> >  #ifdef RTE_NET_RING
> >         rte_thread_t thread;
> > @@ -188,8 +188,13 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
> >                 /* set the environment variable */
> >                 if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
> >                         rte_panic("Cannot export environment variable\n");
> > -
> > -               strlcpy(path, "/proc/" self "/" exe, sizeof(path));
> > +#ifdef RTE_EXEC_ENV_LINUX
> > +               char path_buf[32];
> > +               strlcpy(path_buf, "/proc/" self "/" exe, sizeof(path_buf));
> > +               path = path_buf;
> > +#else
> > +               path = argv_cpy[0];
> > +#endif
> 
> You can remove the self and exe macros that makes no sense anymore
> (the only left users are Linux only).
> 
> 
> >                 if (execv(path, argv_cpy) < 0) {
> 
> IIRC, all callers pass an array with args[0] == prgname == original
> argv[0] from main.
> 
> To convince myself, I ran unit tests in GHA with a dumb change:
> diff --git a/app/test/process.h b/app/test/process.h
> index df43966a2a..c9205992d2 100644
> --- a/app/test/process.h
> +++ b/app/test/process.h
> @@ -104,6 +104,9 @@ process_dup(const char *const argv[], int numargs,
> const char *env_value)
>  #endif
>  #endif
> 
> +       if (argv[0] != prgname)
> +               return -1;
> +
>         pid_t pid = fork();
>         if (pid < 0)
>                 return -1;
> 
> So it seems that we can remove this whole exe path discovery and just
> pass argv_cpy[0].
> 
> 
> >                         if (errno == ENOENT) {
> >                                 printf("Could not find '%s', is procfs mounted?\n",
> 
> Mention of procfs makes no sense for FreeBSD.
> 
> 
> > diff --git a/app/test/test_debug.c b/app/test/test_debug.c
> > index bfda4d1aa3..eda9c3e0e1 100644
> > --- a/app/test/test_debug.c
> > +++ b/app/test/test_debug.c
> > @@ -154,15 +154,15 @@ test_debug(void)
> >         test_args[2] = "-l";
> >         test_args[3] = core;
> >
> > -       if (rte_eal_has_hugepages()) {
> > +       if (rte_eal_has_hugepages() && RTE_EXEC_ENV_IS_LINUX) {
> 
> I miss the reason.
> Why can't we run with hugepages on FreeBSD?
> 
Because only one process can use them right now, so spawning a second will
fail. It's a major limitation we need to fix...
