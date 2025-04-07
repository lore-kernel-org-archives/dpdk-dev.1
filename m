Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A168C369A2
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 13:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCFEB40156;
	Mon,  7 Apr 2025 15:27:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id AEECA40041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 15:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744032470; x=1775568470;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=21vgiCLtYRi6shdiE0rmc4VPahY0kTzQl/ZRQztVyCo=;
 b=EBxC7MEpDhB0RXFJ2mQU6sR1rDrK42rXwvDIaY7fkfFp66CSEgYPxslL
 QIZPGojAQldZaGtRYcxU7OYN/cTlattQuNDa9/7pwwrPBp5EzAcw+pu4b
 VIN21/Sarv3ulH/1iRuNtZbVuYxs3W3tJ2B8x8Bet27z31NT3ZH1A17VN
 lyWLPQjOrs6NtrHWN2IgzqRC62R/ZrKbDCGS9CRfQnfyHOK5/Og+09ZLV
 Jm1Xm9X/+GosAQdJCIu7cqjatCVXOWLdaYE8vFo81SjSJOlmcCGvEZVc6
 jN0ERwdAsAMtM0/FaBV/82G+TI/jK07iCf03JhuRytgg8g6YyNNWnoaQM A==;
X-CSE-ConnectionGUID: EvbmVqH9SoGvwsrLwuRlUw==
X-CSE-MsgGUID: 8erx6WWdSdmMBRED/SZFKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45321085"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="45321085"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 06:27:49 -0700
X-CSE-ConnectionGUID: PpaomTb7Q7SMdch4oHKtMQ==
X-CSE-MsgGUID: tkz0RQMoQ6K8W8clZ5tM9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132690184"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 06:27:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:27:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 06:27:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 06:27:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojekFevzunKqWeE/UEPpTGSu0y3aG5IiC7jV0FoAacGf+n4jQcQ6obHXmmaoCo4sUZ0Nr5VzevG+g3PzPyurq5orc/3nODV1u/72y3jDNVy0ff10Iix4W9fk1esZUfamwNUvrkT7G2gt9zl/7jbP68AtbTYY+O5jWkVElHW24jdortUAZNDw1m23xnbMaN9uV8cDuHkJNK/tvl2YnCk7v89YM18RLelXyFn6LJu+8xn7zo9ORNYnUBJzOlf3ak5hRtZP0V8NWSZ1MoTC1zd+FrOCB7G0YeZt6yVQhkhMYng5VTfN9X6KwiKnLdFMvWCs7wUghoN7tqG4yEaNFunM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx+Q/obMLTSuufDjnkQPLAgLv2nmWxLfof9d4kwB4EE=;
 b=gs7jIoef0OpRpTA3hGTLnnT5D3smvRps8YOk9sAOcThPfpJfiBMG08zABZfktbxxpGK/zeMBmC+aI8wJDwdFzOQk4gefKz4a3gK3g26MF0rLCf75Py2KgzpoTEfcbY9kI8CU4tT5GyoCiS1vQp8tznHkraEWP5QCQ9Xhzm3rdE9BSzKhJVvzupY6s3aT1cxXFCvc0Mx4T449BpZRnbAMibsQDroMkutfWVnW8NqUqlIV7dngvZweco6zoiEVA8X1z0NOMBvZMSbzyOP01Ys50xLmbnP8J6qUqAlt1IKjslcSsfYJYfDbwsjFBXNOcG8u0mmlvGQfdZWi6UOuZXIV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Mon, 7 Apr
 2025 13:27:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:27:16 +0000
Date: Mon, 7 Apr 2025 14:27:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>
Subject: Re: [PATCH] doc: provide examples of using lcores EAL parameter
Message-ID: <Z_PSr9xjcoOeINX7@bricha3-mobl1.ger.corp.intel.com>
References: <20250407132451.1101691-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407132451.1101691-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:10:234::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebb1d3c-3bdb-4683-9de1-08dd75d7e9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JFWYmvEgZeVgeYzzMCaEqOVTMZSDpUoqD2BpCGuRX2cRRFubMm5NsOtRippD?=
 =?us-ascii?Q?n1R35cyd5M1QPJWM9qc0v+rj1I7WLJBIJSsg46j0PVnmnvjl6ycdBTy15PRt?=
 =?us-ascii?Q?8P91Uw6CqrpD1Y8/4A+gN06KMKCanL48xwGLHKu6BGAHlEAFAZfwSNplfedX?=
 =?us-ascii?Q?qhHgD2yo8sPb0aEkJvbUMTDlpSYUD33KJCQ7NvhjSDzbUgfhjtj8Fzj2u/3+?=
 =?us-ascii?Q?dThJPhK6+MIE2A8oNYiInrtuDnTlUyeme6Hb0OgK7WmxkbWIulK1y/OTbCEf?=
 =?us-ascii?Q?fnrf66b14hgQ1VGZSTNzhaEVQ+N2hq/KXAG39fKzXA+nqWKSbgMXvv6iT8gr?=
 =?us-ascii?Q?wvfhvn0dAPgWbFQyqoWuzQ5YVgpRAswKmh8ypVAoq3w3+Vu2wxR88YfUD4HU?=
 =?us-ascii?Q?/3KSIjf5xFhmL80gBjCHNrwdoAiXNzeekY0IHqQjMqlquFhlfkKZczVgy/7D?=
 =?us-ascii?Q?0rJXjQfN4aMmexgiyG7CH12+utppfWeMwol9rtuzDlwkhbjlvtx8CUpFP4NB?=
 =?us-ascii?Q?mBZnvrvzKhNnizgQUUndwhqtM7CoZ4YsCC6PN06D9szAx5KQNWPzQx71XALS?=
 =?us-ascii?Q?Mtg1RA6VKABAFr43tBt0jWdkXJuM7+Pwtmwwc/XyRNjaZTpGPkFBMK84kcNH?=
 =?us-ascii?Q?ecBz4wO5J26sEfMX0sxCr0yQGsdbgbXuj50cSZ/rDQgKQdlsYRF0Yl5cyPt5?=
 =?us-ascii?Q?vKGs0VIWR1XQkPVUMhG4uxiiwOpcQGZB227KTy+oraObwegPzXlSJHgzHzti?=
 =?us-ascii?Q?aF4Q8Oz7Yi2zg5S8kBTFAf8dMOBn2hcUiHazHrQ0XVeRb2JgWRiOEEMPSyUF?=
 =?us-ascii?Q?GjSY26PFAfni4OH86J9kCDECGrOjD09Ok9P/TXeNEcs2bi6sm+/Fw/SdYcMY?=
 =?us-ascii?Q?jM4qXMRcqioaXxnDBaAoA5T/i+0VLNzZ7/kySU9z5dR7oySbXk18xpJGThCO?=
 =?us-ascii?Q?lb/xj4RUB7irOpQKYO2OjVv8yp4SySNbiP8gojIYwXLiLo/xRuUP4PRJ2FLN?=
 =?us-ascii?Q?mfgqG+LD/bexJ3gJmtDrudxQMEiS2404oaCCHBGDY+XxZWjV2TwLx9gmst3h?=
 =?us-ascii?Q?3L3ZntQMsS3o8ylJsp6uN55ltala3TeXeP4dPWro1WBP+224LMdj+pfvNwxh?=
 =?us-ascii?Q?niAlEkAQ1QXnNvHeg3gfe0bgm0VasrIG1ILxItTf9/7HYgVYsajfEwYK/3bl?=
 =?us-ascii?Q?W7EUFbypwF5+NxMydpfrEgO8itPrNsF5MX+xqJXxTSmLcRDqdsuMNHKGKyK5?=
 =?us-ascii?Q?9fEou7EyEhacxuOtwqtdsGlW2Csxzjos+fS5A59l0gEsBEdSSsxnG+EB3A1h?=
 =?us-ascii?Q?3NE94UKC+HXmDV+B74+Pzv3+RtEhGdTxXWmmOUuMsHOjecFpV2YmNQl+Ls1B?=
 =?us-ascii?Q?E9Aastj3ggmzVZO7wsoahmiqZykq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vAEvyJ0GZV2o83hVdjJnNC7bBxY863yBgCSvj5TAoZqU7hlwxLlWGpZEfUIT?=
 =?us-ascii?Q?V6J0/rZyz5cFIVI/cf03bHGpT/ee2sqVAyna1zJRmXl3f0TdwRd+lhoo7GYD?=
 =?us-ascii?Q?WCBsiDKBUsUJa2mOmAXMFdGdnC1GJ6HuUmNupsdfeepsE8Ru2OFBoCPhsXJY?=
 =?us-ascii?Q?8Bmi9m1kIHr05bCFvPW+QzbPDgYKX71ljvHNwdsTT34YfntEr4CBTWqfXkwN?=
 =?us-ascii?Q?T3IoUVhQvwbkKkoGkUM/uOuOsCvooU/ZMb2ReWEX3mJyPP0JxKGqV34bphBI?=
 =?us-ascii?Q?W7/6hex+qQJio6FUS+EZULdUg+qeKPL1RiEKuS5vm9oHiiSl6olkO0dz4Dv/?=
 =?us-ascii?Q?An33gzcjc0s1OutMb0HWadcwuJdmbmFVJ30VoJtZrmBzcXFI9v/ezBj4TV3X?=
 =?us-ascii?Q?s6+hGhUr670HEtV2GsbXBnpfprTy0X7cFA/4SBlDbtbGV1H4r+RGYkEkSVDP?=
 =?us-ascii?Q?6fn+rlyMZwJt4x8Bzvoj+78rgpaQSCfEJ53HuZqOXB3b8mWUA2LFrtG8lIwH?=
 =?us-ascii?Q?s/xmu3JeuIjm2wdbfD2Ob8qNUYaVbBtJPM7ZihrD2BgI/34+JU2Slnf/DWTU?=
 =?us-ascii?Q?yzSN6Kin0pfUk+zPttvejbQaPQBEVcPSQ0jYUi0jm4iYmUKVOLYvVkQlILnF?=
 =?us-ascii?Q?5ioSZrJHUagyQFaay8mzfwIwPi282B3m+y7DtjEkYQdyOuj9wmqe7E8VWUrM?=
 =?us-ascii?Q?oyHjp9/oJpoy7HyzzHYG6yopDSnaV7f8ZpzL0pc2VG/HPdbPiyV7V/t4kXDv?=
 =?us-ascii?Q?7loOvw2Pn3ZVTsWPbmsrX6qfC5iuKUsTmg2mwnTsCXeZ2r1nba7OqRPH/hu5?=
 =?us-ascii?Q?2FSOAT+ZOpJPode01nzKIQtHq5PUWvOby/Sod8RmbjOwp7fQP8k3H0edBHuH?=
 =?us-ascii?Q?SffHqHCxYZZ9/4j5IleivW2dkIwVYLpRz/n0+xNT11SAhqkRf6NLts/vSC33?=
 =?us-ascii?Q?oLSrrzNf4qA4/JHu2m8jhB+nPcm/VgWXeAYyFzXzq1KExgNHrhTPj1uP16Xv?=
 =?us-ascii?Q?4EZiVN8DRVSA3G9zaJm7rPKIoAWo+7Ssl1X/1wDv6QBhpuoOoM0em3I1c6wC?=
 =?us-ascii?Q?GiiPBT+BLXJ7JAX7CzTZBunLFH0JeM6cADtELqzf72a9gqioVd6/Ta9CkiJH?=
 =?us-ascii?Q?Q2vcW3oH9PrMnCRXHRo8SeYG4g4rd+dX8gXKixlrvotGlFgqy1i5TFhu5Zt7?=
 =?us-ascii?Q?UBazLbXJvYzBxTPSeDrMW0lv0K8PL7VR8R2MGF7kG7JcFH6XVialcaEXepvu?=
 =?us-ascii?Q?kSxoLl2sJYwK6PiqTVIGCPy9O0ia0uJQouKL2/UDTg6xR1OQKe+led1GSXyj?=
 =?us-ascii?Q?ssgT+5s5tdq8fWmxOJjBk6mPaxAkWl6hUtB+wb0ZT1cQaooYVbZoE0S0dK6i?=
 =?us-ascii?Q?gnhXtClE4iSGROy86d46npTnoYPZmAIgQsHobdSOi87SVD4ySp4IqLVVn4Ti?=
 =?us-ascii?Q?55cojeYsckn8QoZMz6SSDBu7HYRd86uCUfXkdwL4h7kdESjTCh94cIJS4MN+?=
 =?us-ascii?Q?t/Qewj5I0rCnIheOGS0wC+sbHKu2Yi3DN8JJcYiQfGgKuKuCo5VInP8u2FRi?=
 =?us-ascii?Q?vcuqttzhGzHoWQn12l/4dE6tNaM1p0GaOE6XiZtO2/kHJYhmPBoF3hNecuTZ?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebb1d3c-3bdb-4683-9de1-08dd75d7e9d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:27:16.0720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlEViaVeFI+kf1pcJfvMkin+WkaXJaz8UWXjqTyMUqstdZ2JKZBaWmLcGzVA8gWPubfTL3K7ELZf5nGjNe/6pZA2CZDqyY8BdvwuGmzfhbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
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

On Mon, Apr 07, 2025 at 02:24:51PM +0100, Bruce Richardson wrote:
> The "--lcores" EAL parameter has a very powerful syntax that can be used
> to provide precise control over lcore mappings. The docs however, only
> provided a minimal description of what it can do. Augment the docs by
> providing some examples of use of the option, and what the resulting
> core mappings would be.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/linux_gsg/eal_args.include.rst | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
> index 9cfbf7de84..081f09d353 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -29,6 +29,31 @@ Lcore-related options
>      The grouping ``()`` can be omitted for single element group.
>      The ``@`` can be omitted if cpus and lcores have the same value.
>  
> +    Examples:
> +
> +    ``--lcores=1-3``: Run threads on physical CPUs 1, 2 and 3,
> +    with each thread having the same lcore id as the physical CPU id.
> +
> +    ``--lcores=1@(1,2)``: Run a single thread with lcore id 1,
> +    but with that thread bound to both physical CPUs 1 and 2,
> +    so it can run on either, as determined by the operating system.
> +
> +    ``--lcores='1@31,2@32,3@33'``: Run threads having internal lcore ids of 1, 2 and 3,
> +    but with the threads being bound to physical CPUs 31, 32 and 33.
> +
> +    ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1, 2 and 3.
> +    Unlike the previous example above,
> +    each of these threads is not bound to one specific lcore,
> +    but rather, all three threads are instead bound to the three physical cores 31, 32 and 33.
> +
> +    ``--lcores=(1-3)@20``: Run three threads, with lcore ids 1, 2 and 3,
> +    where all three threads are bound to (can only run on) physical CPU 20.
> +
> +.. Note::
> +    Binding multiple DPDK lcores can cause problems with poor performance or deadlock when using

I seem to have missed some words here. :-(
V2 will be done soon. However, I will wait before sending it in case there
is other feedback.

/Bruce

> +    DPDK rings or memory pools or spinlocks.
> +    Such a configuration should only be used with care.
> +
>  .. Note::
>      At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
>      be used.
> -- 
> 2.45.2
> 
