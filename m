Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B34C0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18C1E427C7;
	Fri,  7 Feb 2025 09:48:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D5230427C7;
 Fri,  7 Feb 2025 09:48:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738918093; x=1770454093;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y4ysoMwhMmiEVxMqIyT9yZhEQa3VoGPw/YazFqrJuNM=;
 b=lvqME0/NWKDLBtmVbHAW8ExET1a8R6sIx+5GXmoiPICDBUnOYnwm1Jdh
 9RXrnnLCQpLSZc0DQA51IOgmDP30kSGesnyiNV8vh7Fkq66lHYwzeRGrk
 2nnX1hkd//AuA8clKAAKKISGrCI1DIiTxPrbtGhIoLIS+EV+b6LEKQkme
 0wOMJ5vFsl4yeDgfx1LfLRbcVs88SOL9WVitjgiemkGvxew3B+MlggZ/0
 pvo46LFZja1OlAs0YwiC8YP5SND14jd7iJw+vCVDu4l2icjrx5xOkrL+n
 eTTBTGh4+GCwF+JR+CjAdhdku75RPHDFg6iPThq+GpPlA1zYzuc+tNSA/ A==;
X-CSE-ConnectionGUID: yr6xGRdcSYavCYAN73Oq0A==
X-CSE-MsgGUID: MGr/O86ORa6J8hGgif7/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39668398"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39668398"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 00:48:11 -0800
X-CSE-ConnectionGUID: tYgM9VtBQFiE7ykLhbjgVQ==
X-CSE-MsgGUID: UbhHCxECTcmytoxgzcPtXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111314801"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 00:48:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 00:48:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 00:48:10 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 00:48:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXvkEazVfDmfng1NiQ6yx8Hf/sXfQbgLSsRMlGL879S2JeDMvzMzxahY04mBP40YF+fiB07Sk47Wh18FSghJIg7W0s6SlBL3AebXPouhnXhV8k1qlUG9WPgsjWnDgptSS7r7xUXQWsYj7zrgIaoC6pholthXdNOdkodw63MBfGrLfeSYyjRZtI7P1noO0whsjA5DvlylCCoIrUZ1gFaFKLQSXuGZbmVI9Xg3Six6LTyEZGjdKNYswkkZLg2RUhr+obofFx16ROY+SB3V0UC+5fqRqRCOh0pVhmYsQqSDNQdwcNuqR/MWWJajGghvgolOd4uP2hDMpfzBkFfzLYVTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ82A5i/XB3n2lCtFLhCcqsvE8mAy45OWTdkpxDSk5I=;
 b=kR4hPMrVg4nbh/Ed7nsrgS06Qpxm3tW17QfZgKrqiyqJzMet3FXbuL5ZyQ+5TMNG6xhMtTvQRJ+dwlhf+tgz6D2Gt09P6divOjCKioDd5nRk8lv8RKc7nm6W5IvcviRN4MwZYne1d1Mwe4EQOcY2Rw8fnpKrFhmRovCs0xBugcKlwHrAG7F14sO5CwYd7L9IIeaC8KdLGgVjJN50soiJl8y25wTdDdaLNbPAg/AsbwTcChocjifSjaqovtLry9I2Xx0ld3t0hfhmcMI2LG1EEpl1YMmDFWq+GNwD/4YSWz98isXng8yEVeiOLckpPUvjgZM1TAJ1KlnYFlUOLg4KNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 08:48:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 08:48:03 +0000
Date: Fri, 7 Feb 2025 08:47:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3] test: improve resiliency of malloc autotest
Message-ID: <Z6XIvuxbNHvcqRQP@bricha3-mobl1.ger.corp.intel.com>
References: <20250117125912.985475-1-bruce.richardson@intel.com>
 <20250117144112.2544963-1-bruce.richardson@intel.com>
 <0e91d822-ed10-4dae-8f0a-7169e7819517@huawei.com>
 <Z6SflKJyTbxMRD9g@bricha3-mobl1.ger.corp.intel.com>
 <3ab6643a-6bcf-49b8-9ae1-88bc6dd89170@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ab6643a-6bcf-49b8-9ae1-88bc6dd89170@huawei.com>
X-ClientProxiedBy: DU2PR04CA0180.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: a8890620-63d8-4dee-14c9-08dd475421ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hDE2WqGiobfoC1QvHfxmwikMDe89bS+QKxuDsCH4loIpjclJ/qwt6BbdlR/n?=
 =?us-ascii?Q?X51ycnCcUG/W/U2UiUlSGCm0xcU2VH2cARViQc2Ofs0gTxHEdf8S1eTbrPsV?=
 =?us-ascii?Q?yriY9T7K1cD5xDHpPjwTqUGXgJcFRPYSAFB6/Xikz2GOJaYgKehZpITu0Krg?=
 =?us-ascii?Q?/fPwJBiSJ/AzF+i0ItivtKUBLF6Pf9JK427uPvkphAeW11p5ufAYFb2mgotd?=
 =?us-ascii?Q?aQ1izIhGzZt1t+jPaupuF/F2HCCVaXYBg/Jx5uz4vFrhTaPNGKb/XozrDYkP?=
 =?us-ascii?Q?uJxO9C1M/2iNhkIA3CcAr5TqCFixhpA5F0nwYI6tkH+EsAnlEBT9s/+K61Nw?=
 =?us-ascii?Q?A7GzCfl2dGL8s1iNckJJbTqzEwjpXmsWmO6hFm5Y63suVGgTcCw8rgwaAgdU?=
 =?us-ascii?Q?j4Ew0BsSbW0LZN+XWaMt9N9fRLdzRmqMJ1bx8xZZkw37MS11LFtO58uC9tKv?=
 =?us-ascii?Q?S4M8kIyssZLmd5no/V85U/87kHYWQ3riYcM+rCDs6ZSKgHEgqIrpjYoYvI7/?=
 =?us-ascii?Q?einfFv6bTHRg++jeQ/vid7ajkp88RBp+LeKsGlcbqKZhMpJqUoyhP1ox34EQ?=
 =?us-ascii?Q?1klEQCVpkJTzu6r9KAUcOOR9CV/4x5m03XGCGEPD2kks7PbXfoJzm/F4+2Fx?=
 =?us-ascii?Q?hmldRQactpmpVMGZ2sTWIYqOj1tZRMF9sbK0q2cxmPl93LWplK0RABkIRBD8?=
 =?us-ascii?Q?wTJS5tAtef1ktKUMxSQWD5jx8enpymWB3ndGVe8Hb0TqrYBPEhzCAs6SxJss?=
 =?us-ascii?Q?LrttedqUh9GcJBtJtNRNiU/12y0R90+iboUfMoaSG/VR3TB9Y4IoPbIIG33j?=
 =?us-ascii?Q?TCZ83QwXUYjo7QHrZRSvVtatYa81CeY10tF+s4OVqg6cD20+ge3JOifX5NtD?=
 =?us-ascii?Q?YsULFun1Du9XX+TyWllL0Nz+NREJcBsCWhLj+KNs8kRsoUvjLt8GotPJfDe+?=
 =?us-ascii?Q?ohumae+qFPKBbbSxs7b4+E8n0GD79YRt7biCs6ClMbliJ4OaGMoPGks+Nfvz?=
 =?us-ascii?Q?/6c3j0jADxkxGiODDK4MUQDVpo4RoqAzff0tQ/VhhWgZg4MBoIsubNQp7vVz?=
 =?us-ascii?Q?tEE6yuhtZ/T77RcQHO/4EyAB7th4Cid3pEOqzeLtIGEqZoA69q6TYcYyrLaC?=
 =?us-ascii?Q?S1xN7pcdfqzqwu2OxOoXEfrrIoSUZM0t3ohntbYiIpB3e7p+duC+j7fvUOgM?=
 =?us-ascii?Q?udn+o7q20plpn1OLTKpvFF9JKbkVfcTUFtE+2Q3UgENWaiTEwOn6v50X4T+4?=
 =?us-ascii?Q?yhSudOCNH1D9JpSYkHTFt4f7GC17uI4haMk664j//4NlKNyGQksJudYCc3pm?=
 =?us-ascii?Q?9cttUprxFyl1X6iTtCjDNZu05WOOXWm+ns++3Sa4aydX5VVQ8RIxTyVEVpDV?=
 =?us-ascii?Q?NoPjwSDcBj886krGDAPKbaZiKNjp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5o13mctGKJJ2VV5z8Y+y9pgo4TI2mwd8aWd0p0iwvvLxAFHErBmJQZoVdy81?=
 =?us-ascii?Q?x2iPqW+iGbagi02DFearNEN+W/9ID558n6gcXUvXfpetY1VVaCoqAlKisJlE?=
 =?us-ascii?Q?tSyYAHD326OswzamtfkYqr9Opjx3LTx3BV9s59467n7s9SJI09QFLVngrh7b?=
 =?us-ascii?Q?0ud4ZNuTwEavS/6r2KSd8hzB6eyzuo/8oYslsWBvp1iqpWg/uSXYqNEWY4Kh?=
 =?us-ascii?Q?i0L+pcaqmw3ATImt9lX1NVwRzfpSafw2pf66nlVklTA0f01bZ5S2Jk4+g6Wy?=
 =?us-ascii?Q?sMs8BlKe5jZnmn2w89FGibqVkSkRvk3SX5njsao9Z4saF0b3qo+CeaJ869Ts?=
 =?us-ascii?Q?8adfpDTZr3QTqy3u7qMNcwp3g3jGb7L4OJLKb/1n47nSnRLlXzn+ObUlGChT?=
 =?us-ascii?Q?b9qazdVmnNfHM1AcOGUi+DJ75aJp6wBUcZt/ntAR5WH1+BTF/GjYyRZ+J+AY?=
 =?us-ascii?Q?U3HHw/pcHAvR1UPyElMunxcNYcmaJIhOsgOjnbEAI/xdnD0mAigRJigpgjxE?=
 =?us-ascii?Q?LDoYp4ie6RR1y1YaLQRYOoCpuHTcL1PJsTuqRwvJkAo1RhawmfxMYa3z1ZnZ?=
 =?us-ascii?Q?mBjQlsZUiVnvCvolUMJYb863xNDRN2rP71hww980pf9aH2a6ymErdk9ZCd+j?=
 =?us-ascii?Q?yeyVzOspdBvrqg7v1eLA4b2O1gXS9QQldwyBmsQZro0BOK5MagScM/spFC8O?=
 =?us-ascii?Q?g6N6WUemB7JejZ7iD4WofNyKkzAsfj3oabRbQwvdBl+FTzIsZ43wL9s7Dhw9?=
 =?us-ascii?Q?Djx8gcHqVlMJslZs90/RnKY7hXCISsfEeZBpVCOl65R+HBXtpr8A76XwwFkt?=
 =?us-ascii?Q?h5UlD+cq7/T2sbD4IORz61mOjOq/xslCr8GbmWYFA4Jsy6H/aBV61ltPpziY?=
 =?us-ascii?Q?Jlk31UQsK8lWsEzEguout/NCz7RKc9X+HKpxWJvomaDIqt709NPHDxK9eXlL?=
 =?us-ascii?Q?XXRXRYnrxel5CzZf/9oxG+3j4StQh9dB/qVfruo4ptk0HI0Luk+KjBjZU4j8?=
 =?us-ascii?Q?q5gG7glRAU45IBm0NAKCjBBqcCTQ6VKh0poBoQ4wddR4ZwJn0OTP6FDf0EH/?=
 =?us-ascii?Q?VP0GvqeMXPUObDX0BffZtcA5SWa/2dwYovNP8sOMFhDOu8gR6oHRuInOq5yY?=
 =?us-ascii?Q?lYUFjWDnIO7GYoJJ5Fs11RACS/nmC2Xjx8EH1EReRRlv03kwuH/Of+XhCAv4?=
 =?us-ascii?Q?lntuOZfQUUitqMvu6LTQCJ7mE1cgcrkaXQot/9lGjqIq9M8Zw8YJQ2C7uyok?=
 =?us-ascii?Q?ik5Oe0E8iRJjv9U4YTUs8QIYuTMuTWWKI6SB9lSeesM1zNoJm4Mn62pIFCc8?=
 =?us-ascii?Q?gKrazFN93gUCKs+GEHmJduH29Mzy2BHf1C8JoXocmPX1eaev1th8purrxUdM?=
 =?us-ascii?Q?+RaSbFR1qb2ZmZv+V/ixXGpeeAWun09ZP4I/rnKadkb2fXFtweJL5vi8gMEs?=
 =?us-ascii?Q?gqRYmQcXCbytRtZjct51PI6sDTUEimJZF0jHWLSZRDA9+t95VwAL7f1HKe4y?=
 =?us-ascii?Q?W6dpiTbI3Nfi5uXKhcXZC993I7xQ445kFRdV9ryu7k2GKA9wd4aaPWUAhyp/?=
 =?us-ascii?Q?L7s/ttq89jhxKLzzxoKfhfzhy2+1uTTacIWapKHZlGfmFAbH5Wd9TgvpXy/a?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8890620-63d8-4dee-14c9-08dd475421ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:48:03.1819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNJPrga5MfSLtzkOw1rzIHgR/eGKoPK/ZP8mdini/FusCKiZVkauMAHSiAz7z6ILWy34tw/0m70Z10wFGsyI0U0u3K4DFIw6hCk8zTNJg0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
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

On Fri, Feb 07, 2025 at 03:44:56PM +0800, fengchengwen wrote:
> On 2025/2/6 19:40, Bruce Richardson wrote:
> > On Fri, Jan 24, 2025 at 03:18:11PM +0800, fengchengwen wrote:
> >> The new impl don't support re-test, how about add a wrap:
> >> 1. rename test_multi_alloc_statistics with do_test_multi_alloc_statistics, and make it take socket as parameter
> >> 2. create a new function test_multi_alloc_statistics {
> >>     // prepare a new malloc heap
> >>     ret = do_test_multi_alloc_statistics(socket);
> >>     // free the heap
> >>     return ret;
> >> }
> >>
> > 
> > Can you clarify the issues being seen on re-test? I have just run
> > malloc_autotest multiple times within the same dpdk-test instance and not
> > seen any issues.
> 
> If the middle logic fail, for example:
> 
> 	if ((post_stats.heap_totalsz_bytes != pre_stats.heap_totalsz_bytes) ||
> 			(post_stats.heap_freesz_bytes != pre_stats.heap_freesz_bytes) ||
> 			(post_stats.heap_allocsz_bytes != pre_stats.heap_allocsz_bytes) ||
> 			(post_stats.alloc_count != pre_stats.alloc_count) ||
> 			(post_stats.free_count != pre_stats.free_count)) {
> 		printf("Malloc statistics are incorrect - freed alloc\n");
> 		return -1;
> 	}
> 
> If the above if branch taken, then retest, the rte_malloc_heap_create(__func__) will
> failed because already exist the heap.
> 
Ok, retest on failure is broken. Got it. Will rework.
