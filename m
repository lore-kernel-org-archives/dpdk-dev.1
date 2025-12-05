Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7518D2F7CC
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 12:53:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B4BF4027D;
	Fri,  5 Dec 2025 13:53:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id AE69B40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 13:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764939219; x=1796475219;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vw7v0eiWfm6EvFZ/Oy0VcUUXhJiwbO6FE+rB+rML5lc=;
 b=HxlBGct3nf64KRm5e58S6VnMh57dbRiPotj5liPyG6I+PckHywB/pv+W
 fZU0PWoIYFj07omwfBTUvIJkappmTb+2/mx+yayJGNOg/+wJTNu/mPYTv
 krGkswzojwWsVDdplSIJWefxzo3UJW9QCM8F/GSJYnFo5uZvtikfIXW9N
 YF+pkXH3E4B67phzn5Q4bIj4HCGg7kJf3gBiCOAwrgkEZ+SF0MxUf1388
 In2XI2j+01VZCT1acyqtkFJ+VjRgUxa3eWhio/8GUNy37dBze5uxG/sMC
 +o1Iog6JNQuSbVrhg2XY9Hxj6+pCHjkdQ1uMLmrk/fhH8LesnWfpgVsLZ g==;
X-CSE-ConnectionGUID: 7PF76bPLQM2Vshlww9SswA==
X-CSE-MsgGUID: dRbdYntbQUmJPKtu87eKrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="70822580"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="70822580"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:53:35 -0800
X-CSE-ConnectionGUID: mlvZ7Xh8TjOAN72bXvKHXA==
X-CSE-MsgGUID: /A5VUzS7SzurqojoggSu4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="226276758"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:53:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 04:53:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 04:53:33 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 04:53:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHy7l+AiMee9FpNSR3UKrVhoRwprNMRNvQEajIjnknPde7JZbwVS6rV1bWS58cXYjYWmjq3jtWtzVFa4kQApGmPWbMpSEhCHm6+yFmVXJ6iNdb1qQb2TE31LO7Dh35wdLpUNLDOCdEDYJ9048kzBm7AyxzohNccxP0khLI6/gwl+9WdRoGwtPybRFvKEX5IOvpGRpJqUplUo7ZKzzFJfmDGkQ+io5YCT8ld7RllO2VgYTieOfJ1MF4K1hwkMA9ZDeBA+PpFowj86zLjMnqGaQRanW+8KqsVOTJ0w6iU9etv0Khg6YrvKfP7SytucHhiCdW65mg+XiW40Hir1rl1czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhnI4VMZEOpI+iutj0MTVgwaRpfgRyClA1Mdl29s9hI=;
 b=GF/jMshj8J32YAZ+0Vo1AOh2SPALzfsm3TuuwvbbEElPrlcIw02WQhtYzNYFyGXCUkY8tPvrLEFqFKlIsgtsq4bUDmzjo4Z7AbXSgaK+KCnXe4qyu0EEf6PV+InQsLyvKHK9kxmdk9hY7o68aArJ/Y3R0/yOt6p/3ZYWuDd7T/aOfTYhPowFfmrVh+TF2qY2AJkmK5RunQFis1TGGfoZP6gRLG0guZZp/AsSQmp816ZxQ98SegGkYWblVmTJ7Ya0AxW6IobI/NS81/m0olRLvCm1K7IReL8o7jaM2avkvMVPhDz0wS4O+AVDMAWdlvnzE34lve/yiBrqlqKO2Ahufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 12:53:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 12:53:30 +0000
Date: Fri, 5 Dec 2025 12:53:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 08/10] app/test: add some unattached tests to
 fast-test suite
Message-ID: <aTLVxOo_f1QcBPs7@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-9-bruce.richardson@intel.com>
 <CAJFAV8yatWvS8OhOJM1yXw1T-RBerjE2psNH0um5KG88T6jnYg@mail.gmail.com>
 <aTLTj4uppv01kT7T@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8x5fScFgdSzH91-L+M6KTdYXP-NaMWPd5CaeG8L08QbSw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8x5fScFgdSzH91-L+M6KTdYXP-NaMWPd5CaeG8L08QbSw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0190.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BN9PR11MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ec0e63-d81c-4fbc-d0f0-08de33fd4a61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZGB4o0O/H8iPGaOmBf4xo6qL+iaTwLSpXRiCI8mHIwj32H1Dat1gdPWkyiFl?=
 =?us-ascii?Q?4Ey8qvrh1GoLTqLR3lqI8RwoK6o6+zldCx9yf9Sbpt4fZqh+9J7FLG0pZfDz?=
 =?us-ascii?Q?OPcKheK0W80RB5r18iNMSK8rhTycgdeP7ec1NOSTLjEekP32o9w1Gepuw1LC?=
 =?us-ascii?Q?yvxwYW2fqPqF14BmQcvEP5JwxTN6XGWJTFjB+QlhH9H6c5vURINQGy154Rf3?=
 =?us-ascii?Q?2TOGA6NJt5jwIOGJ7bR+uwwlydGtAIubB/H2cbUjbQOe6TYVvQI1AkcgnWAt?=
 =?us-ascii?Q?adkieOju20olG5SY3ij+rfduRLyyhLyibhJiM4K973hV9dkhEqEuaNLUokii?=
 =?us-ascii?Q?BcOvK/L9/4VU9vXyKMXrvRecbhOEIOCi3UP2KErH3wcfCK2Y3p7pTDXrDTAE?=
 =?us-ascii?Q?+HQ7homKjL8Nz98yOAPFnuI2460R7YpQ3PLFT3z1W+bSs/aQU7udNwaMQ/m4?=
 =?us-ascii?Q?27nMX31EdAWtIB7dHNvvCVpbHVJfv9cADOles/V7UKkuDRew68jxElSG1LVE?=
 =?us-ascii?Q?1quVjZ3Nstk8v8PFsfLKGAliHvDM1uflyn/tPG00oqZGF6QuL4J4n3zJERSL?=
 =?us-ascii?Q?9d9Kf99DbDNiAbgqoZiAlxsDXsUOinqj/iG8/lix5/J7DhcWnkCvvfrZQIb6?=
 =?us-ascii?Q?K0UvLic37KHbOV9jo+6rkprnasJwUjyGTT/SEMzJ9FIr8BErJiJnomllphkG?=
 =?us-ascii?Q?vafsJXNTKLYKRKsFxPFWsR1SIC3FvtXrbThG9dT6dcmKq5E6f4CmvvNl6FkW?=
 =?us-ascii?Q?EJHVZfLQU0WA8KhhGnfHhTAyB850hIABtKAhzCHygy6z8gMhc1KiLS6jgStt?=
 =?us-ascii?Q?i8gXrKcqOIe9MHdJei4Yqdd6VbSlyAWNWwjMUhLAfJThDRU7gDkV2rg3o3rg?=
 =?us-ascii?Q?Yu5bnvOR3N5mw+1jbHIWGfGtQwKmYRrhOF6Q3eE0gfU4u7aGs8Ak1Y2bvsEC?=
 =?us-ascii?Q?VjpHuIULvfOT++zYUxX3wNM2hFcaSqLeOP/yj5O0kP7wTdDelwfI4u0rfoeO?=
 =?us-ascii?Q?WDFurUTofdrDSiZ8YlFGxUwQqQxNjX2l0ZyTzFEBqR6AuXCWxJ9Y19MAXGko?=
 =?us-ascii?Q?GOZ6md6xewfM3Ru3j1Q+Xe84rvTnn9eDFrkOBK9tOkhz6BeSX5WyMIyEXSmM?=
 =?us-ascii?Q?aXfpjuUWGlX/DRi8yKroDx2Um+xlxFxB5wpV5Wbbj36NFUdbyMNXQqmn3OSa?=
 =?us-ascii?Q?Pc06sYno8u0CxktNRnLAW1WiEHxL99mWHUiufFkkPUFIIZVeXnAl5qbFvlaa?=
 =?us-ascii?Q?U2+N6hw5pY/+Vsc+UFl0li3xfyn2dl/iZI+5dRTi+Eqe1Bwmp7nCvDTMy+Wt?=
 =?us-ascii?Q?JsVENHmNGp/B8Sdgs/hMDnid/OURuEV4513rCCUvjIFp8NeswCgLJWm4PDN9?=
 =?us-ascii?Q?UDU7nw1C6u9GhxaF1DctmHWcHGVkbbqzHyQSxN7nuxJWumcjaZjHbM65KhQY?=
 =?us-ascii?Q?L2yy+3rB4AHUHwzlgZFcfZIKv/Fep9wF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jedHm5tnNkjFJotJAwtk7jvXsvXlVwtvAvBWGPWl4lqn4EHYcG3BA9nOdA/K?=
 =?us-ascii?Q?2EnRFbGMmiPWwo6MNFOn7pzYafvwhIkjBNLtSDX8PJOuc8zwNX3V6TWvVier?=
 =?us-ascii?Q?ywJAJZzJlf+a4w2d64e+ckXm2SzqUuSA06OTONYwE4uJJNFL30WHAqESXMGG?=
 =?us-ascii?Q?pTa5qESko7DlLkMB8KCr9q8bX8dC3QqnI6ezBKdek6VRH2YVZ7gM0eH2EhWS?=
 =?us-ascii?Q?NRoqD3Mn2z2t7Z3gd4yvwwEIcji5LVvs9a6UEfv/vmPogsg3Rj5hjUUd5Kgr?=
 =?us-ascii?Q?9MQxa3ur+eD4En6qR3FYxgHD/fMojItlSOTZp5fGCmetDa7vUiPQlzOCUEob?=
 =?us-ascii?Q?BVxOKr0zTQ3SeCl6z35u4bnFAc8E500Onl6S5p6kx43ZR2xfS25icwduIQUs?=
 =?us-ascii?Q?pKviwkO+BssJkCPI0kEpSKkK3ecrbtPBooahDzAMu2aGSY8lkLdD39CMYaTw?=
 =?us-ascii?Q?jdW8xCj3XijpY2wtOfoAew+1ph+G8xKNCWVVvg2ugeJgpeEP/G94wTJYK70t?=
 =?us-ascii?Q?TQMMyETRXYf0WJV46OsykdgbCDSssXvJM88xfuMc7ufrJ3q2qpK2RQFSQtL4?=
 =?us-ascii?Q?gecRIMZNsWgeKXRhyU2ygfkcEGpskoXAxOZRoxLxd10Zxoye3ipQEVtvWfw8?=
 =?us-ascii?Q?MOL+HSC1gOxWqFJayXbS6Z//e1Ir43M8Az7ICoHQyNxBcnAv+pZblTxHaVTS?=
 =?us-ascii?Q?tnkymvfBUx44byvfLrwHd7b9X17lmhnf/hoFV2ja2e4eL6yz6+bdQomOMtvG?=
 =?us-ascii?Q?E+I999ptgaujvUU3a+N+HPb0vBLY/jtr4CwR8aWR9cmg4BqSnRH8VEYPDZ/y?=
 =?us-ascii?Q?vvN0BrX0YqRuDcwF7JjYakzjBuUFZDr8nR7HLl8ZsBh6qRtYHa77RgRZX5r5?=
 =?us-ascii?Q?PbFjfxZL9NtIc+VUVKq/d3PFpcUT6HxxiwjtMy1AhG0immPM1+UCHyND8dKx?=
 =?us-ascii?Q?N7YmG39S6wxNJCi88k2dMMTFTY3mtKXk//ODvL8WqzO2hG5IAe9ds9uDeYIH?=
 =?us-ascii?Q?rnXT+vMEDJSRG7+vVF42m1tNfZKkFHCw6JrYjsOFX3/mJbY8sc8ld4RZ/oEQ?=
 =?us-ascii?Q?UcR0Ha886z0hqFF0195iMpmdV9tAnFIMf7E0A+WkJ1SnXMyaanw7I9RDdJCG?=
 =?us-ascii?Q?VRRF59jUXW+DrvIIDRQh9tONVZ06huCXZykBszCoL2EdqojK08z1H04VuTt3?=
 =?us-ascii?Q?sYzYHCXQqY1/juORZBTTmtGi4UKH+19Tup4kjjlyGfDYy8u/5XDk/UvD53/c?=
 =?us-ascii?Q?riSv16c5eE1FvTj6/2tI4PkdtbuxbGwI2nEKwMzCKkNTG+Zpurh4gwBoCzyZ?=
 =?us-ascii?Q?6xUibk7weBLNjrxSlHMi8/e3EvKD1AQY+XWhfvCmgwbT/10wK2hoLypGIrHa?=
 =?us-ascii?Q?6NdH5qqZ5pAqnZnNBcYB7u6d1NeR+IxuZH9fWPtRknMeu2S0pL5KaFKJDItd?=
 =?us-ascii?Q?0jEbuuIbNMkd0D6qu5JGjzkSmmrkHC0URkR08LTbiwqnAxu1n7Sv/UkTx+h+?=
 =?us-ascii?Q?vGjO1K3nvvHj2Joq55oJkEh0NqwcfNYXvZWZ6H7vAo76xQyAzJc8KRtnJCCq?=
 =?us-ascii?Q?f5m3AHq8ZEB9moK/zKKm+egTWzsynYtR61ta2cE9Ityp8jGi6qp3lR1moD7R?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ec0e63-d81c-4fbc-d0f0-08de33fd4a61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:53:30.2767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M84UQRH5NPfMEi5XGJTjPg/sryXWSKugvTo+yw1hb30mIDlzo+p1rqAjgDmOJI5PfmiyLCVMFgcAtihFKlf7embQ5K+OGy2QvhRD5ObwCzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
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

On Fri, Dec 05, 2025 at 01:50:03PM +0100, David Marchand wrote:
> On Fri, 5 Dec 2025 at 13:44, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Dec 05, 2025 at 01:37:06PM +0100, David Marchand wrote:
> > > On Thu, 4 Dec 2025 at 19:22, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > > diff --git a/app/test/test_red.c b/app/test/test_red.c
> > > > index 7f38ed1469..4b17173999 100644
> > > > --- a/app/test/test_red.c
> > > > +++ b/app/test/test_red.c
> > > > @@ -1872,6 +1872,6 @@ test_red_all(void)
> > > >
> > > >  #endif /* !RTE_EXEC_ENV_WINDOWS */
> > > >
> > > > -REGISTER_TEST_COMMAND(red_autotest, test_red);
> > > > +REGISTER_FAST_TEST(red_autotest, NOHUGE_OK, ASAN_OK, test_red);
> > > >  REGISTER_PERF_TEST(red_perf, test_red_perf);
> > > >  REGISTER_PERF_TEST(red_all, test_red_all);
> > >
> > > The commit 50823f30f0c8 ("test: build using per-file dependencies")
> > > removed some context on why some tests were not part of a testsuite.
> > > -# Tests known to have issues or which don't belong in other tests lists.
> > > -extra_test_names = [
> > > -        'alarm_autotest', # ee00af60170b ("test: remove strict timing
> > > requirements some tests")
> > > -        'red_autotest', # https://bugs.dpdk.org/show_bug.cgi?id=826
> > > -]
> > >
> > > I would prefer we don't put an unreliable test in fast-tests.
> > >
> > Agreed, but for many cases for developers running these on their systems,
> > it's probably worth having them in. What would you think about having
> > checks in the tests themselves to detect if they are running in github CI
> > and to skip themselves in that case?
> 
> rte_red API has been left without tests for years.
> I would prefer we remove the library completely rather than having to
> work more on it.
> 
> 
> IIRC, the issue was seen at UNH, not in GHA and it was quite random.
> If the goal is just about removing a build warning, let's put this
> test in a "attic" testsuite.
> 

Attic is it so. What about alarm autotest? I still see possibility of value
in having it, but I get the fact that it is timing dependent. Attic also?
