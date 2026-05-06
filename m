Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A437CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 10:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 812C440288;
	Wed,  6 May 2026 12:28:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2D6AA40285
 for <dev@dpdk.org>; Wed,  6 May 2026 12:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778063287; x=1809599287;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vouPGgl/nrIcnfUy23OemoQjMbqPDuMbvivj5m49FRQ=;
 b=Zna4ntWbUsNAudT4FlgxYQDgO39Gdwjx9TXRVS6FwKtRYHuVWHX1yvLT
 LJ+5urV9xcsUZNnjWQSBbjgTXkZKrbB02bxH4qw+ymV9grNHbBSQXIJ5T
 OYv6Ab6+tcsJkiL02ifXFfH5kxU649mlcqAwfEiGJSZHrvNVIs2hwTTLq
 ndnterdHB5NveI10DJ+tGJoz02iaOwzDQTZJpjygVMAtVCsDJP/fvL7LS
 7tSrUloEWRHu/PkaHi9zJloHlWRJ9t2Dqdv2y/eYRRD0/9SqN1BlEKffG
 Dw4s23b/KDd1dWPFmU6Iw2ZvPZPQgSbdBFDTXlm3aWqImxh5AJAFPSmCw A==;
X-CSE-ConnectionGUID: DRc98vQzR1aImOz6tDrgZA==
X-CSE-MsgGUID: 3pq9lAgPQIKodUwLDZ6zKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78918928"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78918928"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:28:06 -0700
X-CSE-ConnectionGUID: eFQmLUR4Tl2djAckGT0Uxw==
X-CSE-MsgGUID: /42z4r/WQCqxq7kSeE0CVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="237916955"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:28:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 03:28:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 03:28:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 03:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDL/Y+t55sSK4UnjfwSp2fidP+a0i6nGy0xstn6QAUfuGLjbqqd4LPMPsCblgFj21Fp+EqKNVlW+LGz6OCO/JxvNHiLbmmaK30Xxqn2YWSOsyiRxn/dyNDCeB4GBxpIrQkTkx06Ysh5w11pujEbQqFnFKhMol3kHKi4GiSpkqyCElBwc6pAomAuziyrVyc4rO0uOxgyjlSyMh4bsxvbOOQDYwDYko0ve7558ef9UtyiptM6hbysD9EDbFpiNI9B5ZZgsQ66CHmPH57PZOIDTxSF9QtcND/zmqKjYZTgGEApTkywdJ/BEd8fQnvyiDdpdoakLNWi14Sbwx2MAsqpqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40MI8IR+hTdPcllS/gkg6Ysgkz38ymWQooX3aecBHfA=;
 b=HF0E3FG2JRKQZDSORo62hMGpuCMljqzt+bhBOxuw61Fsv9Ar8H+x+XDwA/dO0zuOpz4GDXSUdwE76pwKEAkckN7DdlkzTBKT3ZdB1vFluSsRvSumK5apU+OYVaJMIiHQggzUsfgLci2UgBe+t8mVN4FdL6frsPtwUXigSJnoG3bLeC/2AqSrGZJbtZzq5XJPAZAKZ6IiBUTEZAUniZq21/UroLvOLSBzuRV9p1nJoufXFoEfYw8SgGu9XWC6jr+U0xToPwd4C/DuUptcqTvJQ1DrvbvpxArXuPaSdx+Opgr7KANJsY9eYmFpYWXCGbxabtdQGx0cNvW74ceJDPtOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 10:28:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 10:27:59 +0000
Date: Wed, 6 May 2026 11:27:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 00/15] IXGBE fixes and cleanups
Message-ID: <afsXqqXeM4djy3oC@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1777547413.git.anatoly.burakov@intel.com>
 <afsJhAV6DLiLnWWy@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afsJhAV6DLiLnWWy@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0209.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b5acda-126b-4980-a3ac-08deab5a2567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: JF0uFuGx/9RFU1qPA8V0eD/b4vK3g6YNi9b1pXsqLmJYOxzFN+A4+ttVJK0CxabcOO9slPAqxoQh8/IymibHEKsbzdv9slnR2+YbV8eNdpb81PXTbfBLcfeUqfZF3QLLkLivROPdWHwTxs1HyGAx8Lm/8GBxy0rfPhJB2BNzM+sK6mrkCT8K44JJwf1rm84y/Ez9rancI58Gi04FnD0QjiGg6uy9pjxbSLCVRAz596krE3QsNk49/HrRpIP4U28m4AHlDZzv6eQ0SPNu1kGZYNN8UPrLfO5uon1bhBvcOTSF6NWpDwIl+Ir4UUndeL/z/ZTSjyVVxGJVCjXOH6jbZaAjG5GZmLe5a0jYsRnODdbpFKzo8gn4hS/y9Xo2YD4A43T5KTfQ+igGK1sK4wmtafDD2YCYr+K8dAYThTTSQ1fKMXOcOsKw5M4ZFwPsq/StRnIruaRWPOtJEKWCxSnxKyI+ApXWudgehtm11Ty9QHSzIU9n0+vwkSZ71/lzfWns51vtNUF0lbo3kAU7bXiGe4pskR9Fz8uL1EaXxmzxTIA3GB7SUODZtNlIklSlJ0sRVYwn5EwdvTytCecjhcbsWifeXsElB+a+bvSN4NVw4TLROwRW/E9RiHfj5sn1V34qiD5teN/V/8cuYZLjw5GsVrMJoAenCW2XKFIoSZFJQB4S/sY2BNBGf3UOX32tV3Km
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVaiu+ZUfI+JYvtF02YgUUbkI8xFugrgFuXmhbu2Pq0UWHBxVPdTMVqpvTzv?=
 =?us-ascii?Q?ognQhmDXJa0q5riUD9eawpK8BYKqNZcECd4kfIPqvd4t0PIijYVTYU6vsBdR?=
 =?us-ascii?Q?1u1dsvtEEH2Je8yciqbOF00WcyZkkrTcYXgIoz6jVC81e4G6uiNb2gitII4Q?=
 =?us-ascii?Q?9y5m+rJjoZRmlptMpThNx3Hu5yqFuUfqJ7LFm+4Au4kbhTUCgW2on3E07H7m?=
 =?us-ascii?Q?Wfu3be/IExI97xejjBXLPa+tc2C3C+L7uWpseqd3OWhVUMrUEwpm7Frikdum?=
 =?us-ascii?Q?+iGdbo6rbLsGP1zUWpP3jY7F3u3tA2bwo4B8nVZOkLMZS6PljhpMY1nl0RuH?=
 =?us-ascii?Q?EfVze3A+Dwb83l+TzO9Eo+/A4QiTW+7HEnuem2NVP/AX6X0Iobr9yW+84rCZ?=
 =?us-ascii?Q?P5kl+ldOCQ226Coj2fGl/X6z6GlkXrwqYMGDxunY+sv0Rf6CBCFhOowsTvke?=
 =?us-ascii?Q?t3CWrTwwXWupEtPdAypTP/s/qifbPT6QT/qy0stNCVjlJvbiY8AUDT1buiEO?=
 =?us-ascii?Q?8cAOgUJMHDLneb2Cw0jIjUCLf7vj3Y1U72+LS9x9wTHu6TBhVxPSuRVb2iLn?=
 =?us-ascii?Q?f+D9Bvbrb1uvWWS8ED2Vh2FG2xLRJE/M4whwi3LWvR8WRVuE5vSxlWPWIo07?=
 =?us-ascii?Q?RrtnVGK/oIor3iUOpVOTPYMGPdkgb5R4uDgFsmEGKOdpjyylnGWRgCiw4GGU?=
 =?us-ascii?Q?wK67j4E2N97Y13uU+A3BsQW3G9nkifYeqykTVU2/Xs9IRwAsBo7HW06sEHXV?=
 =?us-ascii?Q?nm9HUOCW6bmHc3u1JgPJoo1yVjd1doUPSZ5TzOWB1aFSvc+2gUSAGBcG+ZEt?=
 =?us-ascii?Q?MElohKeRyqjQXIMCDeK5eWi0Dw13g7HL+dKuFcjgymUKw1HJE7VoadGOX772?=
 =?us-ascii?Q?EOpZNY1hDCmB2VQs//CEpK1PUDQquU6xqYKzUCsyH+HiPyWogXfB3gvFjiT2?=
 =?us-ascii?Q?7fsGrquH3R5ezzasWwlZSoes+ovCc0AGz6mQ08gG2EJ6SgrmhQymMUpj59mI?=
 =?us-ascii?Q?CVtmWGt8qLJ+SxlSUg10G6KUgKGJLo1gziPcI2fycDzTdjuPBLG/VMR4HH2g?=
 =?us-ascii?Q?JNioB23TnKvqKe8nhGoHCVn5t9SbmzntPK4lp+F43FMC1qKpp5NPUrl7Bwop?=
 =?us-ascii?Q?qaBoIfF+pw5Ac/P1oKquFqHNDqxrfIi8Vru6YyjwgxZz/g1641o5+0u2ls1Z?=
 =?us-ascii?Q?SXQdL/WuXG9i4F0AApl3HNO2a92nGzY8hyMWTO+9FMP+IgxSTBrLf5Tt8aIC?=
 =?us-ascii?Q?G7rZbUD/dPu6AqwkalMICzMHl+exdwu8ApA3HmCRvHM7yWIWz/RzGtPhE9Ic?=
 =?us-ascii?Q?2wcrYHKncqzFfDWojw+5Vir9BsOWv1tqQ/oSyY8411XxawuQYj/vFPdEMD7S?=
 =?us-ascii?Q?d83PjGpzV9Qi4c+O2c9b5JmlgzpKxlc7pZYyNjRtOWBOZgcpMgDUMubnEq+y?=
 =?us-ascii?Q?bIzNvetYDPAGDN5WjEFaFt+GQqVNoNVc6ZYwDbj0EyDKAPC0veqr/pBSU1kL?=
 =?us-ascii?Q?ez1Qdc9Of+HN7KRXOlCcWUR5cw+ox8zSUN0iLe/Cj55tv1T9khgxEvRcwedE?=
 =?us-ascii?Q?GjXS4bsnNRc8tfF0y8wy56qQxNW3FGpOaR2RPprDpjrSyFAE9cicYCEVYS14?=
 =?us-ascii?Q?S8I8VaxBwt/dsF9C63j+WRetBXaABIzs57VbNhdm5VheHkCadKOgIaFWWQ4E?=
 =?us-ascii?Q?1FQsbvRipNe49V2waiuB1Y3y7QloZtEKFPCalmB9CwhZqWXW/tGx5/e2/ZYq?=
 =?us-ascii?Q?cLOvwywmr+c0GQ3sdhDrtgo7vTissbQ=3D?=
X-Exchange-RoutingPolicyChecked: k+7cpRAiRhNlwPCwdQH9xZGwvm1jVFbVGW25IZ1CAmfvI/ZU1kGcTsoKGeCBH4G75huuc5VSv+4os8pvCkd1uoSrlKUGGXwS/qQV8orvY6G1WuKAJqxLMD8aqNto1xBScHtwX6kupDOhKz93x9VLsFeK1mAgxkmZXqxa2diGp7FegVagHrwLaQHUF0vp8rJpP6VRt09jWfUr/3V3arjJdjJP0+bxTs/yZTDHxxNq/BvUswQlBAwiJDaXX8u4ruCO17BEyDMd1t8tdYkfUElTg90iWIv23PA00rfdh+8ajHXiJmEjhSS57HrSBKVQAQvnFzLWmeiHdiyM1PC+spbA4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b5acda-126b-4980-a3ac-08deab5a2567
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 10:27:59.8478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEBAFosM7PvvDV446C8kkwv3kKLK537oLhle3OacUNXlxE8YyOG8GQxmIfs9TNSi1QQkK4F4fvLi8runnGMT5cZ/dUmYE9uvOJ4+ZfsZHN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
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

On Wed, May 06, 2026 at 10:27:32AM +0100, Bruce Richardson wrote:
> On Thu, Apr 30, 2026 at 12:14:29PM +0100, Anatoly Burakov wrote:
> > This patchset fixes a bunch of very old issues in flow management
> > in IXGBE driver, such as:
> > 
> > - storing process-local pointers in shared memory
> > - incorrect L4 protocol matching for FDIR
> > - wrong handling of SCTP flow items
> > - reading stale FDIR state after flow destroy/flush
> > - storing all flows in global lists
> > 
> > In addition, some cleanup is also performed - refactors, moving
> > things around to avoid accessing process-local state, and
> > writing read-only values at init instead of deep in FDIR.
> > 
> > Finally, FDIR was also rejecting protocol-only matches for TCP
> > and UDP, these are now supported.
> > 
> > Depends on flow dump patchset: https://patches.dpdk.org/project/dpdk/list/?series=38016
> > 
> > Anatoly Burakov (15):
> >   net/ixgbe: fix flows not being scoped to port
> >   net/ixgbe: fix shared PF pointer in representor
> >   net/ixgbe: fix non-shared data in IPsec session
> >   net/ixgbe: fix SCTP protocol-only flow parsing
> >   net/ixgbe: fix L4 protocol mask handling
> >   net/ixgbe: reset flow state on clear paths
> >   net/ixgbe: store max VFs in adapter
> >   net/ixgbe: do not use flow list to count flows
> >   net/ixgbe: remove redundant flow tracking lists
> >   net/ixgbe: reduce FDIR conf macro usage
> >   net/ixgbe: use adapter in flow-related calls
> >   net/ixgbe: support protocol-only TCP and UDP rules
> >   net/ixgbe: write drop queue at init
> >   net/ixgbe: rely less on global flow state
> >   net/ixgbe: refactor flow creation
> > 
> Some good cleanups, thanks.
> 
> Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
