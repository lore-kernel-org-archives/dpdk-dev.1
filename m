Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC280CF45C0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 18:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9195840281;
	Mon, 12 Jan 2026 19:02:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id C27F540041;
 Mon, 12 Jan 2026 19:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768240921; x=1799776921;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2FFTbtVGhx5FUL/dG7JaKC0onM6L1JM0DBiclz/wTIU=;
 b=Fl/ih1BsWd58wc9euGa+OPMxfL4eAbOXOQjqHmuAnH6g5RVOrpNpfLz5
 8Ahr3cQV2n1v/GVEz9+QjuL1XgkOnqK25rKoKz/QNop8QOnSyTIHWpW/O
 aBI2OfoQXjTAlLP18Xu2pXLbN6L0m3Qv6oKqj5/y/EMN/S117tVCKqLJp
 ah0dC8JscJzNLICu45r7W0VqYQivTVRlI5fxIea5JZNmJu9kcbpJFp0z1
 KVDeOkQL3stJDF6go9xDVGUcD3y+F8ogGqmouO2ofPhQEJ7245l9s1cC6
 5NK7eKwMDMN3ggekQ1oVch7miVozRx+UefgnYmVVP5j9XmWdovAmB1N2A g==;
X-CSE-ConnectionGUID: zHUVXx/5TLuWG94LO9SfKA==
X-CSE-MsgGUID: SdIX/BGuSoymY7KC9oj7PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="68525490"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; d="scan'208";a="68525490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 10:02:00 -0800
X-CSE-ConnectionGUID: L/Bc/5EkSwqgJ0Wrl4rBOA==
X-CSE-MsgGUID: RtbTHeJwRkKofseaDgOJ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; d="scan'208";a="227398281"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 10:02:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 10:01:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 10:01:59 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 10:01:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsMwF0lLONoVRCCEo/rHDxDDVs03gCoy1kcP36CAav5XPhOP8qQpsVehT+cUK41xmILnivcCPUO+FMFUG3Z/RR27EBnF0nJ3t+AzrXNP1RE+9p9MjotyyS9K4U0P5B4AJlH8j1dEPfdAHKMXyxPzOp5IqrMbVcBvmYv8JhB2tC9MWNEaiyGmxRE2wX/374iUBpYXq0IWUoz5r0As52YbMmatmDeY8CdDKwbjW/feZtfmRXEMsvLVtcd3qlUdphNYS7IxgvjXEwjlfFmbPbheL/mFpxeG5oSBvY0dBmb0y6KM2XYAibzZMI1mA9swI+9qmiiikwBE9UFTX/yGIGELmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgawFn+EHRSrZAMdgcXOBiM9Fo3vjboQIOxbPCwzl/A=;
 b=S9zdJKPLop74Nr+DXPXyp470fnyi8JP8HMiRXdsOT98bMAfB8WR7BTXavY1szG8PRB0lfOnhZEOd3c7nuDY4x2u00TBJW81LxNh4r4AImuo7vPi8qpkXhEo/zcFA5776cDGiCUEzFFOHDdKQpHTlVGF0x5idbLM2sTZCCBPrM2IZUS3e/RDj59Ue7g9u2nFY1tVQPeNqRyc9NsrXrX0DY/GuTDdR0W48cLrcYhw5yO9E/0pG2wSyMhlVElFyo6A31cFxtYLPQqz0LTuqFjcda0I6urJsAfPZlLt1/B0Fo3M+cA8ExR3VocWHu3QtbQjZ3Sn5hJgH93rPYTwEqg7dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:01:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 18:01:55 +0000
Date: Mon, 12 Jan 2026 18:01:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix QinQ stripping
Message-ID: <aWU3DhthaqHOuIHZ@bricha3-mobl1.ger.corp.intel.com>
References: <20251206184312.69020-1-anurag.mandal@intel.com>
 <aTrYFe7rmsCyUfFp@bricha3-mobl1.ger.corp.intel.com>
 <CY5PR11MB6116996E086E2822124322AEE4A1A@CY5PR11MB6116.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6116996E086E2822124322AEE4A1A@CY5PR11MB6116.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0208.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bdb678-cab4-4034-1dc5-08de5204abbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oi2UoNJagVKWdEcB6F7piCREVSbga1KGdtinDXOyCfYhCAkjIOyTPJxDbl2/?=
 =?us-ascii?Q?OeS76v8TMmCv7RByM+m0SjGUMeCi3ABiTNEXAF6xmLzoyoo2dT/6Fxm8hfR7?=
 =?us-ascii?Q?Ay6iKxTlKEWZGEGq7O0nJrXO5l4JoFK/RpnnVyn5uZzw4wq1bhhGIcHuuSr+?=
 =?us-ascii?Q?44Qk8oMNTKear6jiI7CfsUEJN43TWpHTer4nx6U/c22PH8th3CzKS0qbSVr/?=
 =?us-ascii?Q?fkT2fWwhuXqatL1597/ytpiFp8FI/DU/QeuAcMshPuTagXQeDzXff3XEqnP0?=
 =?us-ascii?Q?ORdiaY8mBk9QZW0s+38QMfecw/fzKac7+dWEZ3NUeidGY8s6PIvK3SYnaYsp?=
 =?us-ascii?Q?3HdKMMBVKkqZo5lWBGlG5cpRoVmlMRoZ3gyPXCE55dlFHNFL+6dasM5eU0QW?=
 =?us-ascii?Q?L7yu8BvpN5YJIT81ohWFqfkkF6CqwYL0sGn+Jhvh6DBUUByHftJpaVCCuxgb?=
 =?us-ascii?Q?zNjWG++Y6pbyXMPJQ1cH1hMLycBuR9651hnP5DFxEhcjLNhmMmgKdmqF+KU7?=
 =?us-ascii?Q?vHcbjxaOe7cBZRdZJ7SD4uHsguYxyC8kebW2FmCgXh6SVgm4IGDAWiSdsJO+?=
 =?us-ascii?Q?bEzRIzhpu2dG/7EWtrWnHmY4RjRuB05vNpCoBYEEKbVD37d/owniUkqVL2rS?=
 =?us-ascii?Q?DeHMD8RO9SvKgMPqFN+EtJ00jLAnduOwqdO1Doe64TlZ18errR4C0ofuVvrS?=
 =?us-ascii?Q?JCZXjO4dC9ip6uZ61MDQy5YEefISsVTAY8Jqm8Vss88KbgtRrdeahto49XWC?=
 =?us-ascii?Q?R+3BN5X8rpVwFwz/BqC2/3B59KtmzeElnhxh7/iqvBgz+DRdsFyGnFZGwH93?=
 =?us-ascii?Q?cqi5STg/nAkNegs0VK49YW5NuuC3OWAKudRfJXDLNiA0Hv06kxq3bd+iOwKH?=
 =?us-ascii?Q?h/37gbl6xQhpH2q0Z2mHSSF11YA7Qwx7W3QaADH7WlV5wCj++yO+zQ3Tvxvs?=
 =?us-ascii?Q?N2OZiJgf4wNvNFljAxCXVQ/1Sy09yNqiLwtiCGZJ2sqIjKs84P0CBAlEPDSx?=
 =?us-ascii?Q?MvsZVQOGjemvRMJcH/p3i8xTa3UV7RboDUbZlLrCK5qAvGvfLYdGjOY2/xbi?=
 =?us-ascii?Q?XC12la8XUimjqb53ASWs3L+HsgB1ewFhBhOZB2jxq+bvGGIU+t+antNCf3ml?=
 =?us-ascii?Q?Afq79ldf3QXbVWbn9IcMyZFo9h6MSvBJPNI2EBAL2pKbv9yYAYq/ko5p/4wv?=
 =?us-ascii?Q?Mm07Fn6TSbU1/3tENjT/jwWT2EuvSmqIyd6VxLfGxLr/j/qycQj7NZC08mlt?=
 =?us-ascii?Q?9mVHIq7sazCpCzqpVVyXc/jEvwy6Dfskg5Z+nNEn1br5tdqZlfMlZUugae6H?=
 =?us-ascii?Q?ItoYHj+EKBeBAuX+DdVfaPpLJawyEMLs0tVb73PZUyZVrbOf6fGP7UdLCgsV?=
 =?us-ascii?Q?mHQNyYF9DlvUbI5Xqrfc9NA+HPjRp8quwRo+8h0v/ZWSZ07FBxW3u8WeDA6H?=
 =?us-ascii?Q?0Y/zKV3qQJJzRFLLlUWhNTG4jbWZ+UYp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VfLsoTIhTYg4N0Z8dswafERQuad6+LNDkl00mft2qdyMmiK0qfzBlMOnR37O?=
 =?us-ascii?Q?8Z7DkJADj/pOFUuw31v67bQFCQ/9xYR9nRHZGiRnNqnRdQKZxLl5HgKWVCi2?=
 =?us-ascii?Q?5CEYNTikOObt8Gnp6skhUIFriiEd3CthN/87W485q/sP4pTV0jAijq4XgeYH?=
 =?us-ascii?Q?c42+Rvbql9IzyW/jcZmFlLNHYLkr5SSpo5iysQ68YcTTjyz3rAUUprInanKd?=
 =?us-ascii?Q?bR6WuIqNYn5bwPg4bicScx3xDcjCSRp1GVURCNhzKz+1QDHJzrJt/hm68ZuH?=
 =?us-ascii?Q?8KIy9Z/YCGS19ompVdAueBAddy2St7pWeQr79DgTJCe7RUPR7izfqMkZnJr2?=
 =?us-ascii?Q?5icV/eY2P7mULAyESSIimePG7ZmHj/TvXSoRJ5HyO0fIDXdVnvVQ5CBCVd+r?=
 =?us-ascii?Q?TbfCnulsb614Gr50mePfa8UMYXvx02zglSubA2JbpyiBHAYO+At4NoARL/vP?=
 =?us-ascii?Q?+sP7TUr/DX13yX0mzQ6zc+OEme7ibD6aCQ5CZuPqLKxA3PuwOkC4lBhlj1BI?=
 =?us-ascii?Q?V3VdzlpxnWM3AjyK+KhCTUMuVm9Z5B4Tuqf9wtLIXehR7qWMCBiMhLyhVR0K?=
 =?us-ascii?Q?YJCB5c33C5hNscpOipGC/fBuOlagsDFguN81JJa1MjQ3dazjKyq/K3WMgdxV?=
 =?us-ascii?Q?myR813fgbMuO4S+gOYSrrP8ARHk0l2nZY1UHg27wAETN92VgMd8FXdc9o38A?=
 =?us-ascii?Q?slZyLHXdfeTydsf3Dz0DrxSQxY/PeENcJgRqcZunnFN5QwJAgFHeEkXHnd+B?=
 =?us-ascii?Q?r0i4q4Ziuf223uAYCggVHVZTxPKCplJKE8zeSutZU1OgtPzYbjUUgmoZeRnS?=
 =?us-ascii?Q?S43zKmyJOf6W3yNZUJVCFnXKfEUVNCBw227fvTjN/y6tPpt/1dwm8sr2/nBM?=
 =?us-ascii?Q?T5vs58pcgs5BZk7j0U4HUAaV1oT0F1+q326DpxUIGQePFc2v4aV1XAzsyqhg?=
 =?us-ascii?Q?R5QtPBoiA4rckayeFgDUD1G1fboMRFTziilzdf3omCD7EfWromw+Ief12Sgt?=
 =?us-ascii?Q?8zarWN/cYtqrlAWoC3d4aLYcMNGx0S8EJvHeHm0hKEgoIOktr4MpAVkAWBQj?=
 =?us-ascii?Q?iFOFsTC/XQ7GhV4GQ/yX4K0dZxifF2LpBmbydL2iOnTMoAcQ1Xjzm4WRyzQg?=
 =?us-ascii?Q?GC11ubL23NNW0hzlUKylE9/EolajGVqSvN3C2uMxlwjEBvsPyiA3HWyOQnTW?=
 =?us-ascii?Q?nVyOAQiIht5XcQJKEV+MQSo0B8oVzd4E+QN1bpIzrEqr7IyRcFv/SXaNNwIJ?=
 =?us-ascii?Q?lfaabepN2nIuJGoy8i6a9I3kjhfD4Jlu8bX1Rd1fjGq3odtkRcULbBozNflR?=
 =?us-ascii?Q?FcYSvVvKHnmohSwRtamC2mmQc91RAGStbTkfmF0kQSiRiusoaPX6neDNQmSX?=
 =?us-ascii?Q?S+aEbjdCp2IfD/m9v01MlKpaB9yd0Ecp5phVSmuahjidgy3L2n5bGOayvsi2?=
 =?us-ascii?Q?YrPZVyoEDsYfO558u35v0C8hN8xbTuSMrugKJD+tHgm8GJZc7QmR/IMLMHuW?=
 =?us-ascii?Q?rr+8U7av/vlolKaneKMnZ79yrXpuGosUYhTD+mCIZddU6VDD3Q5YIWKsXQaB?=
 =?us-ascii?Q?Hc7qVdQ+yvybwNzgvdtjrTwsjlMPpWivATNexUN353w07U3nA/rtjRR2bpEH?=
 =?us-ascii?Q?I1yPICl+sKoMKQlgd98ToyoiN+K2HdaxLIqpcrhwb2+uxJKa5FEJX0vVVjCZ?=
 =?us-ascii?Q?tDY3sRtx0Qyz/WDNeRUeuM1T6swtHuA6wD73D7XyeGA3U6Iav4VDzPuKpR2h?=
 =?us-ascii?Q?/cy+b8usTeRh76Ke2qjMK0IJhGNZuoY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bdb678-cab4-4034-1dc5-08de5204abbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:01:55.0559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YL2lfvRAWjrCVXInGwdJ7d4htu7N35F6/2KbrM1VRa4CezTxcLI2G/yQEdOfzJZ3AHWCjT+yBr5KMY118TRuigxW8iLmJ/wTZpwfFA/NwXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
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

On Thu, Dec 11, 2025 at 03:58:15PM +0000, Mandal, Anurag wrote:
>    -----Original Message-----
> 
>    From: Richardson, Bruce <[1]bruce.richardson@intel.com>
> 
>    Sent: 11 December 2025 20:11
> 
>    To: Mandal, Anurag <[2]anurag.mandal@intel.com>
> 
>    Cc: [3]dev@dpdk.org; [4]stable@dpdk.org
> 
>    Subject: Re: [PATCH] net/i40e: fix QinQ stripping
> 
> 
>    On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag Mandal wrote:
> 
>    > Outer VLAN strip gets disabled when inner VLAN stripping is
> 
>    > enabled/disabled after enabling outer VLAN stripping.
> 
>    > This happens because the respective register is overridden by the vsi
> 
>    > params update of inner VLAN stripping.
> 
>    >
> 
>    > This patch fixes the issue by re-enabling outer VLAN stripping after
> 
>    > modification of inner VLAN stripping.
> 
>    >
> 
>    > Fixes: c52ff36686a4 ("net/i40e: enable QinQ stripping")
> 
>    > Cc: [5]stable@dpdk.org
> 
>    >
> 
>    > Signed-off-by: Anurag Mandal <[6]anurag.mandal@intel.com>
> 
>    > ---
> 
>    >  drivers/net/intel/i40e/i40e_ethdev.c | 10 ++++++++++
> 
>    >  1 file changed, 10 insertions(+)
> 
>    >
> 
>    > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
> 
>    > b/drivers/net/intel/i40e/i40e_ethdev.c
> 
>    > index b8ce79061b..c8153f3351 100644
> 
>    > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> 
>    > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> 
>    > @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev,
>    int mask)
> 
>    >
>    i40e_vsi_config_vlan_stripping(vsi, TRUE);
> 
>    >                           else
> 
>    >
>    i40e_vsi_config_vlan_stripping(vsi, FALSE);
> 
>    > +
> 
>    > +                       /* When VLAN strip is enabled/disabled
> 
>    > +                       * after enabling outer VLAN stripping,
> 
>    > +                       * outer VLAN stripping gets disabled
> 
>    > +                       * as the register gets overridden by
> 
>    > +                       * VLAN's strip vsi param update.
> 
>    > +                       * Hence, re-enable outer VLAN stripping.
> 
>    > +                       */
> 
>    > +                       if (rxmode->offloads &
>    RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> 
>    > +
>    i40e_vsi_config_outer_vlan_stripping(vsi, TRUE);
> 
>    >            }
> 
>    >
> 
>    >Hi,
> 
> 
>    >to help me test this patch, can you provide a set of instructions as
>    to how to demonstrate the issue with
> 
>    >i40e and how to verify the fix?
> 
>    Hi Bruce,
> 
> 
>    Thank you for your queries. PFB my response.
>    Traffic: To observe the issue, one needs QinQ traffic with outer VLAN
>    802.1ad (0x88A8)/802.1Q(0x8100) and inner VLAN 802.1Q(0x8100).
> 
> 
>    Instructions :Assuming outer VLAN id as 201, inner vlan can be any
>    other.
>    a. set promisc 0 off
> 
>    b. vlan set extend on 0
> 
>    c. vlan set filter on 0
> 
>    d. vlan set outer tpid 0x88a8 0
> 
>    e. vlan set inner tpid 0x8100 0
> 
>    f.  vlan set qinq_strip on 0
>    g. vlan set strip on 0
> 
>    h.rx_vlan add 201 0
> 
>    i. set fwd macswap
> 
>    j. set verbose 8
> 
>    k. start
> 
> 
>    Objective: To get both outer and inner VLANs stripped from the incoming
>    double tagged traffic.
> 
>    Issue:
> 
>    When outer VLAN strip (qinq_strip) is enabled first[point f) and
>    afterwards, inner vlan strip is enabled[point g], QinQ stripping fails.
>    In verbose o/p we can see incoming packets will still have either
>    type=0x88a8 or 0x8100 VLAN tag present which is the outer VLAN tag.
> 
> 
>    Verifying Fix:
>    No change in instruction order. Verbose o/p will show type=0x0800 in
>    incoming order indicating both VLAN tags are removed.
>    P.S: If traffic type is 0x8100+0x8100, then points d and e are Not
>    needed as when we set VLAN extend, both outer & inner VLAN TPIDs are
>    set to 802.1Q(0x8100) by default.
> 
>    Also, if inner VLAN strip is enabled first and then outer VLAN strip is
>    set, QinQ stripping happens smoothly and incoming traffic shows
>    type=0x0800.
> 
> 
>    Thank you.
> 
> 
>    Regards,
> 
>    Anurag M
> 
> 
Thanks for the instructions. I've finally got around to testing things and
indeed I see the behaviour you described - sending packet with two 0x8100
tags I don't see them stripped unless I reverse the qinq_strip and vlan
strip commands. This patch makes it work with both orderings.

Tested-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

