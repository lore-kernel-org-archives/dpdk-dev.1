Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D3EC01AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 09:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60A4440268;
	Mon, 23 Mar 2026 10:07:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6C8BF4025F;
 Mon, 23 Mar 2026 10:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774256875; x=1805792875;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RJ545TxEfRzfOWexGQ2aOePhyDrWf91NQjmATmXI59Y=;
 b=QWnhTAcBgUIiVSwOllXS7pbKTbpYMV90vRvzEF5CbpkhOZTxGmJ6mtr1
 uv9fY/0j+hBkv3LvH+n9Aaw+zzAuCKeUOLmSPQV8krxxUm339QClLKO/C
 HtNLbTqxdBq3VciRfrpDmSxKvbLz0w/zuqXvo1/AkOnWpfOENheRe+jpi
 0uW4WpgSFtUdgD7ioqCUmhiDZ/QSS18cH93FgNATFGpTkrJ9zd2+bVgUj
 Wcv5eWQykLtUbL7gqTsOiNam8BsBNUiZETM/6VxftY1LuFxQwUTgmkP8e
 /dKEbkROFjzKiZlZnFwnqig91ekazq8bjS7X7sSHcFNUVwMaJsXQF8Gr1 w==;
X-CSE-ConnectionGUID: SQUOFq+gSKSGm0zxvbptiA==
X-CSE-MsgGUID: U0I8zN6TS42wyLATetTlyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75274947"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75274947"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 02:07:53 -0700
X-CSE-ConnectionGUID: bckNRVtDQ0qpMQAdAYs2hg==
X-CSE-MsgGUID: v8PgEZNzQWieQNILfBuB8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="254442610"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 02:07:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 02:07:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 02:07:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 02:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awSqfIo3OsLvnvvHCzNS1HqL10HKds+68Fqsqlvh6ga8t56b4LIKlPDoLwPQAX8O7vmCzOOS2kfqHGxPdKm37RSg7XdaBV9/6I/mQaUkXgXeqhsTtxuLKCFUg8ayvnoAiFoXfHdujhg8/gs1OzA2aINxWBUCi3FloE04aw4jFzTHSS3QDLuDrKvpUb1ygG+acwXRm7Hdq7TVvX8sKvc56xTTL1mlL+C+F+fvoa9IQwQyK9TjJpEpowNyWk+5BKnCl3fxwUy0gFssg5Glx3cw575gFsl8EQII7PMOkv/8ZyX0Ae+8SND2fydB1mRM3h3EcPChgaJNXidLoXHC/lsRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmi1y+KBfS7SkIcSDnAeizicAm2dJYs7df+/BaDjvOw=;
 b=hPVRHwdpB/9DGlySaORk1UbNUM8sj77yYar28+pcNvCfWoy3leTcnRjgXOVT8k54kYWbluB5TATNuk3TQs2iirdtKFZl4jgeM9aKC2HtC4wVRbYNpNuscKuogdgwg7M41lkBWLXCWNmBJ8uT5cTfIGDmekQ/cVHUzz5XXQ58nDQOizRGA+DpHU/GUhCovLyE7mn10p/xgukR9OVrovRXfdk4Mzpas5OhNQSwmn7vxL0nWCo2D2EzP1T8sOJr+/u1i/UKQQ97CAvTNi6s2aYDEqJ1XaKAP2EJzOlQ1kHi/llrKsjSkQAIc1uRrCts7tgakfth3cpel9qxnnAULZgXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 09:07:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:07:49 +0000
Date: Mon, 23 Mar 2026 09:07:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <probb@iol.unh.edu>, <david.marchand@redhat.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH 3/7] test/pdump: skip test on FreeBSD
Message-ID: <acEC4BtNmU379-27@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-4-bruce.richardson@intel.com>
 <abwva7QN2pBRD4Jz@bricha3-mobl1.ger.corp.intel.com>
 <20260321091418.74534cc6@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260321091418.74534cc6@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: bee5e0a1-017b-4ec9-0e79-08de88bba7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: crv3mCgfP2/7bt8t3NC9k8oh8P9liHt/5WfCTmsDpyyA09M8bMMRg6apJ8XIVDGRKtRXaFRJSut0/X3TDEZEs8XoCgD9D/xPAcoPHWUQlQ1eBlVZv3Om1GroCdAzhqvVhRsrULqH3X4MKVfNAzv0DBoc+OJJvRxdMIEugLCqPRZaqihTZHf4mRuU0UsWyTQntciXHat7lWJ9MX+eFd8qi/LP+VUAN0/DPOPAhQILQe4FxcblO69D6YMny99GaXTS2m0gHSKFyGYJzqLWhk9fRrCuSq3kMVf29K6zHG9UBWRuPa6SnzncSDP/2+nyXd87h959BFJH6qlKVEALpHuH4NyFYHrP+G0wm3Fc0bEayAOKNYM2hZu2NhfTzgF1zYX8GGRymcTKO05H6jw0YLXR2R9vM7GX1SHcOtpViSbUIxVCaSWdktNRqes0Jagalrr4mxqzl9yJzkCInGFOpgzau2CD4dPWgn/5my481N1vzpRcVAQpQOQvhSNO2GMK3c9YZ18YzXa+D6sNGltWn1d1eUnoltdqMzU7NFXFOPzrCKFz7vimANHXeseoKo46HYOlcvypjkg+hnsPiZQ5VXInS0xnRmE/XvShqNrnmg2Tnfk45giwL9ia5YrNU4QNCLlKKKjYjS7vlneuvmK2gfK4vChgtwg05mAyxXy3fAPq7L8Kf7zNTNxHMviM5dLu1kqXlQyb/RiIMh3T7u7hw8wU696GUTnasm/OhT5r5zz6uT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPLvz04p8GxgRfrLpTzkJLbRS20g8lFnLbnUPWCpIgJsh7d4vhHkYRLFKBWe?=
 =?us-ascii?Q?pIANfEE0brtIqCZ0OTkU9u2aZKug6nCCon3/aPUHyf4dSPuKlfRGgqDxMVTd?=
 =?us-ascii?Q?A3BI64+EHIr2nnfuAeqKRi5a/gdPmpleDQiWK2rmFOkBU0Pxdj3uImYRpjwU?=
 =?us-ascii?Q?pn9OeUkLxdxX0+2XIIcW900F60sKBmUA8yYPTOj/Irt+UfuUYd69d1cHSs0G?=
 =?us-ascii?Q?lJrlIaDmdIpF+LI4g7AiIkt0zIL0QK6CehR7n/O4jZZ8M2kL3HFvBO/msCr7?=
 =?us-ascii?Q?0DwF7iDffRjgilKFf6MN9LoW42p3xkE2nVsV/nsBYupGS7iVvnLtzkbig7xA?=
 =?us-ascii?Q?LJF3FsJ4O0X1HIIy2MdD0RGLD5Kn0psXWb4M6rvLpXm+JhUPPygY4Vb4Bu1i?=
 =?us-ascii?Q?hHkp+1TWrtStUPCI24HqFFqRmCRsckQBBmAn0+d5+d224TU36olItWuD0FIN?=
 =?us-ascii?Q?9xHiSd9mIqRYmLjpTe7i25qji8HuB1ZfKbt3Z7F0wZ2Hq1fYENgZGxneknvx?=
 =?us-ascii?Q?gSD1EIjOJvVY5KExY5wPdtWyO8l/3oO7QqZpMTTYaL7IQaVvacqrUePuGFi6?=
 =?us-ascii?Q?7hRUhQJcVhxHYFtNio2BNj63WjoCMVbiACVPyxdHNIdGIx+hDyEHE8piXH2v?=
 =?us-ascii?Q?9TIEEyzclugR1kefJnfy9K7Svt497NqosbPJHoogp3H4DUFvU9pOKjOm5qQW?=
 =?us-ascii?Q?51GdJj0HF7zzb5ZTIZK3Qo0YfdLAoBfph2vj/L1ID5xqY5nGCQtVdTSkW9Np?=
 =?us-ascii?Q?RYS9T30IyJp0gLlk5mzUTj3I2ilA7I2Zrvml5KYTsZ9DwCE2tKVssfG+wpDG?=
 =?us-ascii?Q?hLg0Wq1OEcj8Cb8KaEJC1yT58nqUIty6Tfv+pF4SGhh+VgprGr011Gi6rHYn?=
 =?us-ascii?Q?D/w0ROwN8/5IZIu2wKpU8GmR1JNXjcrDlY82e6RQ5hpkz8RKwsPYMN9zVbG/?=
 =?us-ascii?Q?bwfbiHcIp9OxoIsRua7M2XwCI1i6t21iqN/tlzfF/u3XErBRHldX/Iku3rdX?=
 =?us-ascii?Q?Z3uNvNcA4AmGvwoc1aCaR1aEQFtSzHRyno0NElgufZVQDurilAXtSr6Q/f6J?=
 =?us-ascii?Q?5kTuUCCq9KVgV98c7NVHXAiXMfs9JLDqkQ6Rtr509XBijnQ8kDTIcqpxma5d?=
 =?us-ascii?Q?eQ2eBP8uwx1h+i0ojrE61KrHYikK/g/zu8H4v2Yc18oP0n/Cvxe5Z2jgoWC6?=
 =?us-ascii?Q?V/hFpD4Y5cBk2kikHaRj+QrlC/XWNCNHmZZ94ttw/hzyIHmlwLZrtauDtSen?=
 =?us-ascii?Q?wFZF1LoBepayiq+ubdGNR7Nilk2tobRbWOTGRjQuA4ddElqDmMKvbET7TOMy?=
 =?us-ascii?Q?jDkbtaOqn7KHLHWQVdq3KcGICnwIHutNy2sJ/4o7Q9qG69D/yQ9Z7EY5RQQp?=
 =?us-ascii?Q?mN/E/Kxym8++tZZlH83oraYM3zkzfKQbkvaJG5Qm/HTWCdCEgtbl298127FU?=
 =?us-ascii?Q?qsV5yPoAuQNhvi/VhKdCcZkoAV0oVm8ede8Gsc4t5kTdSNJaJcZuCHMyoVg8?=
 =?us-ascii?Q?1kcqlXFGMseRz8vEWuDMik3s/r8CGkGUNMpkivZYuOr4bkeKB9z1y4HlXIQ7?=
 =?us-ascii?Q?z6ibTtSwH1kMo5kdSht7eaRBlGW+z2GeH4tb83/YXvH5g4omrY/jktRjFu3o?=
 =?us-ascii?Q?PD7mz3H5ZhNrts5w5mN0eJkpCIzSTskwFM1phMBREGghPFR1UWoq+ApICE3C?=
 =?us-ascii?Q?OkppSUCbsrMFD+auLFdw4hmAkyKZCs9AmVKvBVNVH8PqjHukJqAzKY/JOKXY?=
 =?us-ascii?Q?ctSqZkFtyG2CcLaQy6Tgp3AkqLIijtw=3D?=
X-Exchange-RoutingPolicyChecked: svPofX5xXJ3bBisvm3tC6OPpiWedg7Qy2c33kmGCgyN6Dy5uDqAVu/TOcsyeJDFUuPioTMizPUh49GBeYRebLUab79n3qPJ28XDqlkr/LFLjRwLYDqm2EE4m/Z6JWHe8/3ac6o3Hg0o1J66VozvaYX7HEL6sRWnrZ/DYwqMhI+rtyjSvYRk2KA+5E2AmWY466hzBHTmYaXrpw+WtMU/gJIxj9+KqLoqJ2UYs1dMVA26EeX2qVhYqSeSfdbMS6VGymjQR3IXpXS2MZlglDKkWOPGODB6dgfVbdNh3IWSESZQmYzWlTy+i1PMAObRktZs4No2AMAR4HAf5IQYApgsLuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bee5e0a1-017b-4ec9-0e79-08de88bba7ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:07:49.1039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntxSutWN8SEuJrx8G0vGSekiw4MKMYQNOpbgiXb3Q5jxE8/oAwuOYVSW7PuPMVO1i3TrvrlXfAWnQriJaDcg2CiMnmkyzI8NRnvFfUFVogI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
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

On Sat, Mar 21, 2026 at 09:14:18AM -0700, Stephen Hemminger wrote:
> On Thu, 19 Mar 2026 17:16:27 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Thu, Mar 19, 2026 at 05:11:37PM +0000, Bruce Richardson wrote:
> > > FreeBSD doesn't support multiprocess so skip the pdump unit test which
> > > requires multi-process support.
> > > 
> > > Bugzilla ID: 761 (partial fix)
> > > Fixes: 086eb64db39e ("test/pdump: add unit test for pdump library")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  app/test/test_pdump.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
> > > index 824caef2d4..9d1175b4b0 100644
> > > --- a/app/test/test_pdump.c
> > > +++ b/app/test/test_pdump.c
> > > @@ -5,6 +5,7 @@
> > >  #include <unistd.h>
> > >  #include <stdint.h>
> > >  #include <limits.h>
> > > +#include <sys/utsname.h>
> > >  
> > >  #include <ethdev_driver.h>
> > >  #include <rte_pdump.h>
> > > @@ -197,7 +198,12 @@ run_pdump_server_tests(void)
> > >  int
> > >  test_pdump(void)
> > >  {
> > > +	struct utsname name;
> > >  	int ret = 0;
> > > +
> > > +	if (uname(&name) < 0 || strcmp(name.sysname, "FreeBSD") == 0)
> > > +		return TEST_SKIPPED;
> > > +  
> > 
> > Self-NAK, I forgot to update this patch to just use
> > "RTE_EXEC_ENV_IS_FREEBSD" instead of calling "uname". Will fix in V2.
> > 
> > >  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> > >  		printf("IN PRIMARY PROCESS\n");
> > >  		ret = run_pdump_server_tests();
> > > -- 
> > > 2.51.0
> > >   
> 
> Couldn't there be a common dependency in meson.build
> would rather not build tests for platforms that are missing the
> secondary_process support.

We probably could engineer something like that, but I actually prefer to
keep them as skipped for two reasons:

1. it makes us aware of what tests are not supported rather than having
   them just silently dropped.
2. for cases like this where we do a runtime check, we at least guarantee
   that the tests build for the platform

