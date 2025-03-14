Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80759C28B2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 08:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B314C402D2;
	Fri, 14 Mar 2025 09:40:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3151E4026B
 for <dev@dpdk.org>; Fri, 14 Mar 2025 09:40:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741941624; x=1773477624;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Xhwk2AMJMbI3eaGJoeiNC6oAt0PMOSRLorwPsOSAwOA=;
 b=gW3/UxC5cY6dtUfDfARmu9mmq1Vc43a/TxaQkmodM52jVKT9RjmPZmkU
 us9VPDktdBAj/2v/zPLsaxgRq0NQtAVHkd4o8DrBGZ+WYrFc4YV2pE+mx
 Ku3J3vB6WJRWQpFEIPCgy8QYHnovp9AfGVOf8wBAYqvJUyxZwYH/D2Lsp
 Pjvmxx4NSvKWB+G1ElGgzxP9HlsNfaONv2222Mq7xoSy0aSdl2aRHmP0t
 z0/+w9CIxk2Kk9qOkZLQcF73aiPjUxL82HbRAklJ4FEnOdwDT/AEpDzlh
 WvceS8ZgNGX003SJOIvhsWYDatKeABAkprRvo7gOJELDRI/iqfstebbLH g==;
X-CSE-ConnectionGUID: kfYakyLVRYCCUv1SlGq16Q==
X-CSE-MsgGUID: a6C+NAgxSH6MxQDS0gqlRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53738844"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="53738844"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 01:40:23 -0700
X-CSE-ConnectionGUID: kSOPtaurR1qry94ZqmvdaQ==
X-CSE-MsgGUID: 2ho7n/cNRHaupSiLg8WYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="126243077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Mar 2025 01:40:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 01:40:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 01:40:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 01:40:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDX1aiAI2ah0X/W3W/faQPWspH4mjoSQJM3xvUMxTGh3atvuB7CIUFF7kDcxr1+SqYkG57cOCQwgxBDaJO6y5ULmRg9xwT2Bcwfub7K3zwH++TMRmCWW9UN4baO+BeMdGjoY+G85ihaPGDPEVmQirQo5GZHMxgkwwjOIwQ2dRm79u7FbReM99q/s3fcOsrL2KPpTGjIfCnCNgWy7kzKGksiD24ZJnJQ1NGSC829yp5zq4oS+kkFakHsB2wM346nUqYOUFGYaysEdpsKfd4XRb6ZAPVE2U6/IjSwi1mFn2pNM858O5uUgf1e9WI9u45ZUZEJVZnUerPjPjudlM6R7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8VkliIb0JzyOKxzrl/TD5Fvqdx6Dr8n9JslC7qsnX4=;
 b=nFxfGub6Vz233ZfNAgegKiGSrq/gLung/tC5ll74tzU0SRxOipJWQKz/pgVgluurVt71F0vROboie6wJEegwhQMhfwhjiGqXiM3CUiz6sDIwX+Q4A3ERHDkejbIstufZOkMzt+eQ9nLwEJ4NNFmRAPm7mjB2tadDwQXVnIntb/CCMsSJlPukchUnv3KU8BGMcIhgBP6y2r6NGIqKQpecwrOZG0iMCGtFOivadN/cfLBumEPLuKpUm5grQDTORhHShbkWJUx5sk8c00uBxMVGe0W2YmQvFKx/kz21o2fwp5wg6TS1wjnYXw/Ietb6Cli20QO20M5q6niNFCOeXqx2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8529.namprd11.prod.outlook.com (2603:10b6:408:1b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 08:40:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 08:40:06 +0000
Date: Fri, 14 Mar 2025 08:40:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 3/5] doc/api: add portable version of
 __builtin_add_overflow
Message-ID: <Z9PrYlbVXB_UyBmT@bricha3-mobl1.ger.corp.intel.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741896043-10115-1-git-send-email-andremue@linux.microsoft.com>
 <1741896043-10115-4-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741896043-10115-4-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB9PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa149af-d46e-4be2-c26a-08dd62d3d287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n3eo0kxZ0J3bpuIkbQ2Fc4ti6gz5n+z5CNfI3ltN8XdodlDxAer5VpIm3/0Z?=
 =?us-ascii?Q?r1a9A6fEvYqSaAPaQmNTD6Afk6MXW62QH1XdVwCxa3SHhfFOY7LNt8Fr61a1?=
 =?us-ascii?Q?JQwPq2jlWn0UHMCzF+dHNbrNKkUHUtcgV8p5m//o9KD1uagUgoNlsbwhHeSb?=
 =?us-ascii?Q?Tz1Dakt+aCLJ0HT+ZHi+ts846DdGNWYj33HXwS5W8VtddZ0fjr+bSRJcsWR/?=
 =?us-ascii?Q?AzxT4kIjVwWzC0fBmSbNgvVTI3dKl7LjDgVGQQ0tkhyZu2wr65U5TwbX3BxU?=
 =?us-ascii?Q?8hkWNgXjYydLbWkfejjOLeBe3sW7hIOJrAdO4oUQCatSA1p8TmBrcwN50fA2?=
 =?us-ascii?Q?opkDZ+/Xco5bdpBoiQ1KwqkMuM2+ODXv3/D/WKhgW+Rr3kMRSnoPbScbgLOd?=
 =?us-ascii?Q?P9t/fdKNqfamdwBX0W9jSvqZLs+cbCY5Lx2yRejs5YMc0H0Kplvv7Cpk98+c?=
 =?us-ascii?Q?FmQ83OVd3Y8r8z+kLFspxYm8GCxn3s4F+ZYmaleb/qXHNMwAabALo2BBKqvE?=
 =?us-ascii?Q?QQ65cUIDjtp6AXvfThYKurJT+4duB8xnfBTxoYN/XkQ5K0rYqq7ifVbxAWUx?=
 =?us-ascii?Q?xOm8ptj6epm1UG0VJmnzxb3MMThSw6umLlxu73cnXbhvQMdXVZABhx2yyTqq?=
 =?us-ascii?Q?tnoY49npaHh1T9RCQCgB+crb7nRK71vkdNSbmIpuuf2kexkTOeT5EwvM1+xF?=
 =?us-ascii?Q?NIf9ZrYPKA4I/lH0iRIuM+Bo/5oXxVmSdE3WReyy2mONcsb0ObDf2Ay0nWcT?=
 =?us-ascii?Q?Hijx6jAzrwjQfonIy7bRh4kWg8kBAyqqiIxuiVueZLhgomJJfgz4wON3cqA1?=
 =?us-ascii?Q?AyZ4lq4fQurK0pVGLR9gY9KixNSDqVFVUWOdtQidfAYT3/oGVFh4SBXHTcaX?=
 =?us-ascii?Q?87rwA5S49S1qNWe/7szJpxC62Hf+lKATrnRejd4SCrc77n+HuflTTklba90Z?=
 =?us-ascii?Q?eaZol+lOlWokr3vkSbegpMMOykcQuFK/y8NMmJ8r7HCJ5lgam/N/MnEM3Dov?=
 =?us-ascii?Q?aVdD91W/lZqgx/4dzcNKv2ffijWsuYImu5hyNBksKyem03AGCGWZaBBFEj2S?=
 =?us-ascii?Q?P5xT0FSSbJKifep2C5DM7EJHHBds77ivFFxQZLNpAwqVlj+vZAhsnBCNBqlO?=
 =?us-ascii?Q?mbtBOf/22WU1HhH2ZoTDA4zBrPmKTLNK6s7YQPYDJifbjwTmz/tpposa+ncy?=
 =?us-ascii?Q?oCHeYVnsZ2FWj1wb/p57zkiv1hwzYwp2uXVNp0RqokDrFTmJo0tH1KQEnEj5?=
 =?us-ascii?Q?Ype06PHJpKJUZ/KKbsPGBVrh4tLZO7T24abWpxxQtlPVpCCI/KeqDggnEVTs?=
 =?us-ascii?Q?JDQf3U5iR+/FsMEW7W5CFqs1LP5+46aEOTdNVonu5CFfuP+uN3Qv66VPI8Cw?=
 =?us-ascii?Q?OsI4PpJhFz8G42sn8IW7F1wcVY1P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lpgy/stlmrYeLFASMgpBHGLKolYkjnE9+8nPsVRnY1sUf1xZrZ70ICebI6Mb?=
 =?us-ascii?Q?DQawTSeO066C2KMfDiBSwvRzkNQ8C0D4BpXfcd7RzLRQ0Sa9+Aa0++9ESt1S?=
 =?us-ascii?Q?VTdA++kTuNPGDCe8V2kC7NiTwvmDbJCwfMqUXUqY7FDOmNxM3mjcf3C8DVjE?=
 =?us-ascii?Q?lzBh5jAtdYlHFV+BkczbbEqUIffG3J7eyjXcqize/2m9+ITBBhFnhZiE+XIJ?=
 =?us-ascii?Q?523cVoMQQlfMw/5O66DIzZjyIGd+lGb+bqexdijN0Lyetoqu1Z92zEErKTrW?=
 =?us-ascii?Q?wOg5GK4GRZ++ZZewbSoF9XoNDSMYeiVLOUod8Jz30H+XFJRqj6UbCTT9PDuv?=
 =?us-ascii?Q?rxRT8c1rzerzxIuWI12FxDU+Kl+Nmsq8w1Sf1K32K+W1OBm7n4rqXpFkXW/6?=
 =?us-ascii?Q?yqZF3HMdOVjaRQT5oJH9FNktBYhTTfhXwqxtax7TbdLrvDwsgfTrIlu0apU7?=
 =?us-ascii?Q?4PkousYWG/SM06B+GUr9tNAU8cEw/OR40wHLv6CVjhIllxRc4Ru0lP0J1/WG?=
 =?us-ascii?Q?mn7/J/vfNgPuQ42hzVNEyBJtU1Hci9z/d3fMVMw/iqQnETWb3cxRh4+5dpvx?=
 =?us-ascii?Q?wIp8wcBxitWBJ2A3kHZ4a6EY4aMkAyUxptbUfcbK0pC3TjRQP9CnfNHd2yD5?=
 =?us-ascii?Q?ZVC4knIY8eoquBATSH9UjlMvCQdBNxRCiPM+fGz9+xj+HQAvkm8h+KRHRkFk?=
 =?us-ascii?Q?FhQIxzH7Vp93cGi2TcU5BBkNS6vZxvZhJ6Wan/vFExvNq+rrpEm5MTzO+1kC?=
 =?us-ascii?Q?tcb1el3J4ooJdyCvCYYDBadcHDyT5FOfUUKgN1QYA3OKMDJIdThGoBDd7e0e?=
 =?us-ascii?Q?oRfKlzCSAIxz9kuQuycl6SLhY96/xSAxLaAUWkclk9E+qFcCQFh3HPZprHwT?=
 =?us-ascii?Q?Y6SB3ehYruETMlXaOiODUzvjyzXpjiT2GEygZPMzZZtV1n68AzPBBbbDI8eB?=
 =?us-ascii?Q?DpVDX5+a3CMeduzt1MaKMjhoV/dAhooDXTZWkNFqulyknsGXvOWLlN3LLbow?=
 =?us-ascii?Q?nFd1TMqroXu4X3RPWOiXr+nFuyduwjgIiCkLygmaJXhq1+oP0IQsijhf+s6M?=
 =?us-ascii?Q?aOyKccyK+KAqkeeybolp38ofKAQvit+hTxjJ+4tAE3T/wnTVxRRYjXSfp+UH?=
 =?us-ascii?Q?sTe6Keiox0CVU+IcxcHOYuIjwX95XLOFnSGMt3zeJBYWC0nYnyA/C5TCGRm/?=
 =?us-ascii?Q?CqxEofT5wM5KkvBMjIuXq6VkYxAWAy2KMKt/fydFylwlyMfCA7/HHngZBlk0?=
 =?us-ascii?Q?laxgCWByxvEpjdzEdDT+m2xWESNjxsLkzjDoKrNtbUu6EUPtbOgpmGpFtQYq?=
 =?us-ascii?Q?9VXfqIJ95GVK+pMNVE5xcLOqfgkA41rwvFxxJ4zgzyVvIDV7hJ4f/ioM+Ixt?=
 =?us-ascii?Q?NP1I+mF9yTHYVD1pn+NU4vTnsnDwGjZE2mLck89ikNC9J4Dyf6OgMDGW7wn4?=
 =?us-ascii?Q?Ji6ZOEKws0tdA3pL5vGDAZmaVn3fSrssJYekRGz4UlVeToEaxWvtHwwm6fvb?=
 =?us-ascii?Q?u4Wx00xHa88gqQVHlf4FQCEZD2PT2j94uc/IEZv+6Q4KTepXhJ3MKgIJjc4T?=
 =?us-ascii?Q?TjPxtwxVag8kELudm2mm5XTDP6veVOO1oP2oScgTIDII03r66DNEwbvN3J7i?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa149af-d46e-4be2-c26a-08dd62d3d287
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:40:06.7121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpPkh7l9vUFjzIyfNfxH0kfC/QV5+cPSJiCYgW4k90CWF3klmlGeaaoBqUD2TlqyaQYcZXHxwWNLOIwW90sI3jSjtYxTl7awkwVwjCWqwEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8529
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

On Thu, Mar 13, 2025 at 01:00:41PM -0700, Andre Muezerie wrote:
> __builtin_add_overflow is gcc specific. There's a need for a portable
> version that can also be used with other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  doc/api/doxy-api-index.md | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> index b2fc24b3e4..48922054ed 100644
> --- a/doc/api/doxy-api-index.md
> +++ b/doc/api/doxy-api-index.md
> @@ -227,6 +227,7 @@ The public API headers are grouped by topics:
>    [checksum](@ref rte_cksum.h),
>    [config file](@ref rte_cfgfile.h),
>    [key/value args](@ref rte_kvargs.h),
> +  [math](@ref rte_math.h),
>    [argument parsing](@ref rte_argparse.h),
>    [ptr_compress](@ref rte_ptr_compress.h),
>    [string](@ref rte_string_fns.h),
> -- 
Please squash with patch 2, to add the docs along with the new header.
