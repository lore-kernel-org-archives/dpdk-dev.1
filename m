Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E39FC369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C72140267;
	Tue,  8 Apr 2025 18:17:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 036E740264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744129040; x=1775665040;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=r2ieUPeR02ePIrmrbQj/85qN8gHpTJNBM3nk4ignH0M=;
 b=WlbBMIpmnAqIRiYNpnMmVHMBVtM+BdEJuL6NoW70oS1wKP9FfHpuK4/Y
 9mACamysQGbFU33yuw11tlC4OPWMqVAcn+QeG6BpJN9n5Y7AZJkRO4QUG
 5evuV/ia/RAbMM/PJqdvjBynj3EXHx/XTmmDYiW9lcHRlZHtJsKoav4Ty
 bDyJpPI/z0U7dCi/fyA/eE7FxCdJCaOl+2Sbnpo7sY35qquUj3109b7Qr
 Yi8uXEPWmdjXE5pz9lFUggxPfHirXBGgRmtuXQehdYebRVgp0MCDugSGR
 Aw+dAijiT0lZGwxvIe+BsA9TzS3QbxvMdQe42eC916oeMt5nMDNmR9B5L Q==;
X-CSE-ConnectionGUID: dq7RROCuTnab5hVAaDWWlg==
X-CSE-MsgGUID: cOIF5iu4TyGu3isoxjj/PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45461650"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="45461650"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:17:19 -0700
X-CSE-ConnectionGUID: tHq0bgT6QvSTPcgMpTr9zQ==
X-CSE-MsgGUID: 3BzCacL4TweIGPMTFqKZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="133460976"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:17:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 09:17:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:17:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe13C90poEmmHHN1ymzXhB66LlRYYLfEmG0/YCk664Wb7ONOQlmW8gW6H4u5kOUkN/yEeDVRzrs10L3yR8hs547YDKT1y2JliYfVmTyk1XR1cmSYdyGArhBvMVibZL76cgyCMMfFXcPTW0sGmkrJVemZ6zz/80mFMlZsFzaGG1XOAwFRvszsDZsT7nfdn8YhH65Z26JIqYV35UEWg/zJScyNfLmVTuHagl88yUa1srt1RTdIentHss7cF2Shm8mm+/4x+35UN4h+CkNM12RDtMn+iX902mKlzmOW1oFbxKLBd3bKf6qvcPE63G/jK62saXUW3j2TvDKvGPvJhmQGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fjWpW46T9LEWYVGaNu7jGV4L/1rjB4gDkX8fy9uNAE=;
 b=FkRa9RhJDbxXFs1ENRYQx2v33lGfK0H90a5cBtzdjVM8vZ1Wr8sl2BLTacKvZqJPDdLkumP9I/0R/1ESG83iTvGRi8BD1LJwxBu1RxGywUF1GWeeYcFqBSGQpeliI9nFiDhyD6AtfIsEsv0CrRlyujvmuVdvqSNQZMC+rMWVHxhBxeLOoqVAmyf2vubDN9sIeq9+LaluPano/2DlLaGV1mnv+BeTOwNBiIJ8ZXaUt9bX5/b5/JSlRUmDRHundzHz9ayg/dM3le8lfKH2B8kgE7BzaD+cR59n8sryol6SC1vdAtPg5IW16lKshcI2DzsceBpoJTLBQTsdih/WI+/1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:17:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:17:15 +0000
Date: Tue, 8 Apr 2025 17:17:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/cpfl: enable AVX2 for singleq Rx/Tx
Message-ID: <Z_VMBvEEkvrtoXut@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155242.409854-1-shaiq.wani@intel.com>
 <Z_VLy_b-7Ld4yidR@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_VLy_b-7Ld4yidR@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB8PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:10:be::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: dd75a5cc-d949-47f2-2085-08dd76b8d3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJF06GYln2edezmMtbsKLYKljIM2wxOsSmvlgkKnJf5PNNMBjpBC9FBeh5ma?=
 =?us-ascii?Q?ExLpcmEXKNYNSzkMQDMfR/jWD4BMeanr/ffaAyxFhXRWZmJyWok7yHKiPI5B?=
 =?us-ascii?Q?0RGU9+za/YVKF+o66HfBlLLyBt8uL3IZR+lDiCVhy1wyZKzzJMZaK4Yi3beQ?=
 =?us-ascii?Q?8sG8xgB9FobGKhMtQ2jHwa1mXhlUeOmRrWU+x6xPTgjkSzu5sG0xPqHPMM3k?=
 =?us-ascii?Q?fep/yBBQeqhe4Y2EN3rIa9MW7HYMf7efQbXUq1cED9aoAZ6b1XESjVxZvIFC?=
 =?us-ascii?Q?KCBT/x8KrVk5dt5UmGAaeS9gKoOZOb5cYIDyCSYW/ls6L44t4Ekjw9rrVrF+?=
 =?us-ascii?Q?1V9YtgtQmC1csoogAOGqYJcPPY3wgjFQYNecjX0TbqEVdVSIjyEBpekYi+xY?=
 =?us-ascii?Q?vY8jYgQGVk84Uo9BFpmRr9GEHP8rT2v8vi6P8F00eDKmUKqRYCpbNVLiu/gD?=
 =?us-ascii?Q?W0Tzp/RsUmWAnPKivEI1zjg2TvjfV1NAIRtVuzVtJxbGR/cf4IgK2ZgyciBh?=
 =?us-ascii?Q?y0xeLTy2rLoRedxoYzZhiOGqFgn/V9fBvy5g2uuDmduXa+PQqwV++1RPqkjL?=
 =?us-ascii?Q?da8utMctSOsM0bww+qKZEPC2jF2rHfWXLkZJC/80z0/TqGv3IJnORV29RAgl?=
 =?us-ascii?Q?pUV7zBAclzHL0sAuHj5MZxC0gDEEgzohoWwVvvSpL6CTRGmZXIqmHGeESIIC?=
 =?us-ascii?Q?YCIYz5sPoJ9B0DluL0iDhtyeHoeRi3UGCGBu3uTMShrqZLJYKseuhgS7nSmX?=
 =?us-ascii?Q?En0YiH2gBKzE2KWDBI7laOy7XuCmDEQv3qMWnUSflY2Nrdj2xAXEDgtesSzR?=
 =?us-ascii?Q?Yz3sWJQ4IrE3IKVhWOcLb/32tmmvSShj2aEwi8lf3C3g3ZkiMLnswX/cBVw2?=
 =?us-ascii?Q?kbVjdupYBWM9+xsa7NX/gWTRGN9VyJwzFfAjNPJr4mZi+LBc1j9OuekH9pOP?=
 =?us-ascii?Q?oyDACrGrGw8oxze3uFwuMCsQGmgV6Dt51Rtxwby4eFNkGRRVT5tZ2xGWHueU?=
 =?us-ascii?Q?h77o7YiJW+gU+c96a5P7eKwIjXFBOM1RnTjlUGpzoQdTlpEfNvjkNF7AAeHo?=
 =?us-ascii?Q?wewj8+b0NSIGZUxWJM4SJwGbfPKqrmSlPwxo3qDjRNLqwbl1RvpZABLEnutZ?=
 =?us-ascii?Q?hC84gkElKeXPycU637CZx47IgqcMxESqQcA/bqER127Nt6MAbvjB68etS12c?=
 =?us-ascii?Q?wa++COYEaQsbUeN9/uKyVXXJp2XXLTNsE9WGsyZq6ZGq+HxUIJVMHz5yMy66?=
 =?us-ascii?Q?AWDJuQKu7NM3T3wW+v3LSoUQcZ7FlWMmp1wuJ10BHluRAe/GPj8TrlQ/0Mhx?=
 =?us-ascii?Q?F3ZrppEpaydhSRAxlfr3cgFejcZjpo+/rgkx18w746jdA8q81wjc910U7eoW?=
 =?us-ascii?Q?+UmhiO8baDqpVGiJ/xoNFkqvY4A0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6uNQDco48+2vsdOpobqj2vu6E3rwHWSXB/oaqXOFW4kN843CIQwer//Fqut?=
 =?us-ascii?Q?qwchdBJcC9+NNjBGWb+TNs6hHBrd9gtadPJwQI7hlwAz4T3vc1xK+liwUgO7?=
 =?us-ascii?Q?ezR9KxiTW7LejQt60KGSsI0LQlj1GboxVgOMtnySF9hQtbHlY78o63jNV73v?=
 =?us-ascii?Q?TCbCUM+0dDg32jJnWhX7MPH46QTVvERLk95aRZbg+yz1USXvE904JsGnyveR?=
 =?us-ascii?Q?3P92n0RUzngFO/gMpTdzAcU0WOUJU0ednU60uVU37aQdTIS9T5NTSNmMJr1t?=
 =?us-ascii?Q?8w5oVKixoPziUaN783bvMeHht7U1VfManfRET7T10qSs3rSNWx2mE3dC1bB8?=
 =?us-ascii?Q?+3afQLLrWOidTg86ph+asSWCgCKeUG1rf0G8r1/rCWXsJV8DFvmksNUn4Jn/?=
 =?us-ascii?Q?qCH5BLr/KbNJJCXo0kZ/tK5/4QHX50BzMCByzocwONo/+koGOZS9U8r54XKv?=
 =?us-ascii?Q?CfovV4Zcq2Wxkc1/Hloszx49AUgM8JBNT+yl6UlbNEhwMlkGduqCrHUhFXnO?=
 =?us-ascii?Q?yFhmLzURs5yKEDY+9gomNE9wA7Fe6SnAiX1Pknut2mm2Xin1SpEZ6rJ7pqvx?=
 =?us-ascii?Q?4pie7J+5nPGkdlXNwU+jGh14eibV7naSStuQmKWVjHuugXquXw3v+lxRUjQF?=
 =?us-ascii?Q?FHY/brJX6SvlzvXZApmydlmyH33nkpC02xS9Gm3qyFI10JPr/mmk9jSOJk8J?=
 =?us-ascii?Q?jxUjFSpXptHUaJkA1m8iu33Vn6pASraJgsamd5U+EULPwAOlqagiaGV7hyu1?=
 =?us-ascii?Q?JUP5KN38f6rpecy68vr67e6uGkwlg/52LbX2bAVqpcydwkUiSBZSqylAijaF?=
 =?us-ascii?Q?7qeoq40TB8b+pgxKdvQwcgcnwR6Lpze6yW/6xWbXNxPe8mRCc4hff8r587ix?=
 =?us-ascii?Q?QpGZYSw4L5RGFESyg9opTRH88wmQa4rMDDA3Rny2kRZTrdAiomkZ2PuoiTd4?=
 =?us-ascii?Q?HwXCVeWZA11YWzmLv7DaJEBnYtsRWHejzczlLGwmnduPrlx5gC0MzyCVk8RY?=
 =?us-ascii?Q?LrhVF/u7UGojRKpcd2qDdc3A0Hlmkiog5tGdOCgEjwdD1uYrPDEotZC6LYp8?=
 =?us-ascii?Q?S+ES09J7pmrbylXC3kcrgUVu3+qRwE0fViW4ERbpNA6WyAhdqjhDw9DvPUuF?=
 =?us-ascii?Q?TPVr6kXcOGjDn3JGjYv86ppFiSOs8dE925s0sGE+9HS2uu9y4dyQAa2BpyLq?=
 =?us-ascii?Q?lVyx647CmKDmaYbrz1AiLpTHIAIRRkXbVrdzdVUADkimFpGTkFBwkkIile0S?=
 =?us-ascii?Q?KdxYBHbLTyh2yXLINvU7PNQLBjRtfdO8B1JoD7j19gJrUmVkrqinheL/3Ka4?=
 =?us-ascii?Q?5GqoKBqvKnVF0yovXfzFZ4dkQvv8j+0XkzlVs0Nh17GxJv5Djq/h1SKp4MBp?=
 =?us-ascii?Q?KbGg2W3nEgKzS/Gy5jc+fGckUShoR5CecEwpwVfKm/oQtenkolQ8bMP41Utv?=
 =?us-ascii?Q?EneVI13IePIVar8WLl5o7CpUCcmCge/dtAQro5zuVlF0FtTWlcX8StZhUdQY?=
 =?us-ascii?Q?KqrqWQ4ls4N6/0UBaky0cY7CYfRJrltMDUZuVo/hEshe1y8Ogn/NKOqMmGzb?=
 =?us-ascii?Q?PBADSpl+wJqV+PAJYXyfzqDgKMtzSJonON5VBgrbYV6h2SV6bqu2BykkJxXD?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd75a5cc-d949-47f2-2085-08dd76b8d3a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:17:15.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GQbpg1OcuY91ZTQlbQGm7Em5vib8CCAy+tmpkn/kAM6PujVZ4/XjUBK+yvMnh52uINp5zdgsZz1qSlwym61QgZX2Q3Yjbze/dYfRA1+rwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
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

On Tue, Apr 08, 2025 at 05:16:11PM +0100, Bruce Richardson wrote:
> On Wed, Mar 12, 2025 at 09:22:42PM +0530, Shaiq Wani wrote:
> > In case some CPUs don't support AVX512. Enable AVX2 for them to
> > get better per-core performance.
> > 
> > The single queue model processes all packets in order while
> > the split queue model separates packet data and metadata into
> > different queues for parallel processing and improved performance.
> > 
> > Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> > ---
> >  doc/guides/nics/cpfl.rst           |  3 ++-
> >  drivers/net/intel/cpfl/cpfl_rxtx.c | 24 ++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
> > index 154201e745..5d267ef667 100644
> > --- a/doc/guides/nics/cpfl.rst
> > +++ b/doc/guides/nics/cpfl.rst
> > @@ -177,7 +177,8 @@ The paths are chosen based on 2 conditions:
> >  
> >    On the x86 platform, the driver checks if the CPU supports AVX512.
> >    If the CPU supports AVX512 and EAL argument ``--force-max-simd-bitwidth``
> > -  is set to 512, AVX512 paths will be chosen.
> > +  is set to 512, AVX512 paths will be chosen. Otherwise, if --force-max-simd-bitwidth is set to 256,AVX2 paths will be chosen.
> > +  (Note that 256 is the default bitwidth if no specific value is provided.)
> >  
> 
> The word wrapping and spacing here looks wrong. Will fix on apply.
> 
> Otherwise
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel,

Thanks,
/Bruce
