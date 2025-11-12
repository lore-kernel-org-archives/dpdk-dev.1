Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09DECD1297
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5BBA4069D;
	Wed, 12 Nov 2025 16:47:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B6E4B402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762962461; x=1794498461;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=w2UQUz9WbYrAc4llfGF696R8zJfB2Ed/cFzhuDjOnjs=;
 b=GzdulXhFui3s8ZbegRR/qbRQY+SlsXbxElUeKbRCkkf34TGoW22LoF6E
 FRumdSivomKxDqAmiPd+Uj1h9pY0m5XX5/MQMSPy7W54ymiDskaEcmpVR
 gzHNpl6egPUDn9kUZKXXvv46OZLTbGpBV/eBM1McO9/Q7BWrTJPAwNS9y
 s5Z9swR2Ag1RwhpojODEU8t0pIGpJtSQ0UmrcVviqLyMs8vhwgoa2z7zk
 y2gRla+5UjHTy5YhuY5/IT0/Ne2k6vNcCNRKPBUuP+HnpC9ld0VR1mpWV
 KiMcCOZ0wIjZYDGvrkn7JAlhlCSiRBNAVGwQajexbk6JRPK6DmPYGPM3m Q==;
X-CSE-ConnectionGUID: oan0gnU6QvGkxSDrIoKN1Q==
X-CSE-MsgGUID: 7Kv4Mt0YTlu03m1z67QPag==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65122753"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="65122753"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:47:39 -0800
X-CSE-ConnectionGUID: n9Z/TM0yTsO/NOHx36e1/w==
X-CSE-MsgGUID: +oyCnYocQ3uqDm/cFBWJKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="189986342"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:47:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:47:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 07:47:30 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:47:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyAaPaNTJD63lkO7fcK8wg8a7YbNGAJWmq9hPsdDNXPyw1uwDjH8OeMPpSAp3aiUHM3t3azZhIOtdPD1MrBLt9K1CSlyPKAyMmIlTVfYUpf/COB+PjX9iruAftmRJHa3APBwGCCzdEXoFHCkhLfOFVd7Aler8iO1L/glXsvxjEYcidxzI6Gg6jtz5hrw1Ng5fUZ07pA7YuSxQ16iBuiOUodJuUMG1pf5aHUY3Nx8SIUjGgPFedKWbDBFDmzVyDyO289pBumNm+MoUdWcH3tm/Re/gdI//wnSJf20AfTLEGmC74OtEzbs03pgIP6ByThu0LQMPbP5cw3O93bS7drXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfhlsGlH3TMleWFiTJFEMP8fOIB4eb8OdE/Bir2QWfk=;
 b=Cg4Nh4X4UkWm33hobQkrZzbP8tj27RJX2uH72X0lgZXPslhOgufpAp/6C97r2IkuU3OrMdr3HnvDbQThWs72bZYhDLCL3B4946RgFbPzhb3u3sO5B0L4zASHeBnfX3/eYLVpUKwxMSjx+sw4rs7lBCRxEPiD6xTv2S/CjruxnJ4Sphmv5+wqb4R3Ilh2o0q7WPAxXKuZwEFl0CCI8+3Noo129I9HkOT1HIDZJguFhLB1bUCZf2Bkqoyf9oIgsUtc7v4qQHEyc9F08XJPvCyTibwaYCqj63PJb17zzwOppODS12rXLyJ7H+g5Se0G6rYNg+nw8i18p63rzxFrd3lr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:47:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:47:22 +0000
Date: Wed, 12 Nov 2025 15:47:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: ensure correct Rx path is selected
Message-ID: <aRSsBFlNObpHuJJG@bricha3-mobl1.ger.corp.intel.com>
References: <20251112151123.3757688-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112151123.3757688-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0263.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbb79c1-46e4-4359-3ba1-08de2202c4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iKlnbtiTzONGRJu4fOFSobmpbY5OQ5gA4v6MBypCgleJgT2p90PC7xdRbbiD?=
 =?us-ascii?Q?V/GfGbFEowcz7sZT2g2B/PrJAQunHVmw95p63ZPAtNgwxwmfTcH9NaNhZ+cd?=
 =?us-ascii?Q?3G77ghL0W0qcihUnMd6+QZ6aO/GHVmIysGZ2vRfnqxzROEClxfSHgKSNjr+U?=
 =?us-ascii?Q?BYESitIV84LncKZi1g0CRQQtpYO1tRFkvhSdinSVs/mZvAcittgO6GQMFl+o?=
 =?us-ascii?Q?FiSdb5znu88F+Xx5pCHmKqyegsr3n0ypW+xP2yIWdPe8b6y+JjVc7xxKmy80?=
 =?us-ascii?Q?zjBNLaF1TRUG2AqNhhOkDBbQyizD6AaKeooddRbTRgS5VL+LExM61HaXD1k7?=
 =?us-ascii?Q?eTsmFnfZihNlHIrXR3HLn8wjLGDe7w7EOogXrt9ymtz9YOSqtNhvtfKVOWAX?=
 =?us-ascii?Q?l3HDK5zRbrMtey98HE0/HLh6sOh0dzFLrbWtSBaHzdhbQgRdq8LcidDF2G5i?=
 =?us-ascii?Q?7puwu9DWOmNKwk8cmwN/3fbDvhsgJ5e7CSLzqBxqUcUaTJUPW8x0nhQAEwaJ?=
 =?us-ascii?Q?d0dPKlD4hhDMHUyYFp4ijH5wRBE6p736+QJWkZwnbm25K7DwdIQkz24bKhB1?=
 =?us-ascii?Q?BEF2CqxsSyTN+kdnt9e+dwmVJFbsUMnt7Q/6qAwb5nn7XoJful9MwfL+YTdG?=
 =?us-ascii?Q?L513lgyIRrsIzoZquvJh4UM57tPvg7rztyrqBXfxHdhTQEy4q2jVOboIKC27?=
 =?us-ascii?Q?uz0bQpbfB6/kb14rK5FUGYIQNkkXIiG/1Clln54Eqa+W8llmFucwiVP/h5Yx?=
 =?us-ascii?Q?0/cYLWLVB1Raeogd6y5kE53GYkiw/P7g5jYH/7T2HGrF4qlqV0IFuv+AJTAW?=
 =?us-ascii?Q?px1ohcdXiR4bJr+VLZayVzsyrhqKOuNUqOAeq7xl1uEQdx2YmD54eaOI9x3E?=
 =?us-ascii?Q?bN9M091VUjvjFI4Bs/Rjyo/qFtz0NDG6qmNrcxS2nqGHTo55Iu51TSfwbelA?=
 =?us-ascii?Q?MmOUwCqL7MPG3CSWLD1fZ5zGIoBFTJo+4KWgspyyP5kBfHKAKFeEyUp9I6x3?=
 =?us-ascii?Q?Y25XHzeJb7E3ANiR4qRpefXC2reEU75eD1589iZQIrkHhs2PA5UWQAgJ8K/u?=
 =?us-ascii?Q?q8kGwCgU+OCwfGmiihM7rvEXfxPRNqZgHAOCRcV46gyvpAzI7Gm9c/l204tT?=
 =?us-ascii?Q?FJbLIhtzFgzfnJtleulQmzCLi/MpeGLylAnQ+LY5fOOJoNpO7R8cyvqOMTCQ?=
 =?us-ascii?Q?6iSEO0mowtMfwGXpp4Ko1jCzAaB3bHP/SmLWwyY+lweo9ACfHcEr8D+fuWKe?=
 =?us-ascii?Q?ZTCTLHHl+agJRVZIMwfQBLj0yBJzwvsS9uG0hMMc+4C9ZxWVMSA4TV8iSQji?=
 =?us-ascii?Q?CBxx00JVGWIknVx360m36+MszT3JiEGjkYqh42Ial0QL4q+HO6UQeZAbPa2l?=
 =?us-ascii?Q?0ydxMZ6wMSMrIFEUHO3Ev1nu9uqeSzdJECPPTRmR3ZZiFnh/lQqtJP/SZiqw?=
 =?us-ascii?Q?CSQ1HsvsUutVZjv9fTXL8rsRxerBCaGR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCQzljovyyu+HbiGA1yertEbqkTyO2DbSnL50ogbgn2PfQu+CiyT3BQXyl6S?=
 =?us-ascii?Q?zZdK8MyvafT+IY2OVL4q+lPzTP/cqGNiAungYZwZPhd9ILLtsJ9i3mReZlb5?=
 =?us-ascii?Q?s4yaAa7fOslJ9+HOmiGdLiTVQj9k3gFuVQrNO9MO8jimXh6NgDJ1vzd/s2wr?=
 =?us-ascii?Q?Sj/DfqB05udtO+pDY6aLHpG8Em7lQ2e0ur/OvtA4VOSkjUIJthI5zvARPbFC?=
 =?us-ascii?Q?t2XrVNAnTB5rJjiFTZw0YyW6dk58VlUPUf7OuNZA7eEQHZmCb2OzqGV/ZBIY?=
 =?us-ascii?Q?bzwsIR3E0V99RW/1SamDKtYG/yPtZRBoHSb3Ners60cmP0yte9DBB80gLRDQ?=
 =?us-ascii?Q?rOn8tw8FTV2jBxTRZ01Y6de+L6BTXvLilZEWBzffHArUM/9KPKgP2SYQGpNH?=
 =?us-ascii?Q?TFHim6H3S8rkYzoi2fmcT7Hap371glDmiJ/UJacK8M398f0od8K0A6FxV6Ey?=
 =?us-ascii?Q?WrGILeK8bsTcakL+rcX2lhS4xYIpPnmZBEFp/1pteHlNKMoMgReZ9c8DR+EJ?=
 =?us-ascii?Q?ihZF8HJmTr/rM5phnh1tYjOh6iV5RlZYlUyzZ3psWdg4E7UAG5zwOx0JjxS7?=
 =?us-ascii?Q?dYKKWbiRUcYzkziSwihBuy0uDliyjc8EHBRk0oN4gN2O69kNFYFPo7pmv9Zp?=
 =?us-ascii?Q?mO37fB/yH7FWYwvRBeXEy2qUJnRgcpMhL2pwT1Rzrzsd7g7vdXg0h4wSDzF/?=
 =?us-ascii?Q?d1+yyiAPlQUbD1qIVWUt2MWxISugHA25Xqo89pWbnsAv2zhizhuTGlgmPz7m?=
 =?us-ascii?Q?jyM8Iczaed+7lCMwfdt4/uVy9xG8FmgcnPQEgma7OMCSsTJS56WmkDQaYTwl?=
 =?us-ascii?Q?wUNdVrSNfTnAYQeti7gR26SJW6qHZnr23bCeZO9XIg+UM5ADISsUKfw/s50s?=
 =?us-ascii?Q?+7CsayyHYtUNxsba/LwNKZ6R2a5b5UVoR4dqcMNn5JLf+cX0bCNV0pJVOQq2?=
 =?us-ascii?Q?VXOmW4O6ALFWsIKb+QCHaFWSn6xBHa7x5W9CbLwTxAqfleceMo13ccu8pu1p?=
 =?us-ascii?Q?30p4RTWyv9NBc4JiofErxYUMEqkPChFQusaUFaA3u2i90u3PIa/TuP+4ivHF?=
 =?us-ascii?Q?H2pZ+M0rs9BiOdOlZ80+2ED+dJtufxUGuIiNHF4H8aeoq45SlYEywJ1qusaV?=
 =?us-ascii?Q?bS1AYWk4yuoT5ZHe+PkeFTn7PQ05iAnTXAmhQDGb2dJOiTEvwc40ceJ0k8Z/?=
 =?us-ascii?Q?6PJ/Hge5luVuFfLLyowkaD7PnOBufgDXUT1i5rqPszoWgxNu+KBbYLhjauM0?=
 =?us-ascii?Q?H3CMZw2NEwYFdvdSKKvbqlUlZVa5kb1Slb2LatJt1OkDFnXcAJDtgIR1Y45c?=
 =?us-ascii?Q?fjp7nqnn9z65qr1YmjZDV9N2rKK5zhN2MnksbzxwxzdEhSQI1JwENWq8KqYP?=
 =?us-ascii?Q?Nfw99LB8Ex3qEKswB4DSWdMRyFyB4NbcNHpmjlSyCSXqHTCYLd79Xgx6A5DK?=
 =?us-ascii?Q?13s4azSRIaMvyfBSFaky2hb1gmlWUF0b+2oZSPq2iXv+LacoKxJ+y2d/gnZF?=
 =?us-ascii?Q?r0YoXyN7sR8SAthQdWdHdPDaH27c2LD0tYB+cLXI7Isf+BbuyWzXFzw5FEVk?=
 =?us-ascii?Q?Z2NrG8Apd5PMEiDTRf08nqyYUfvYWgKN7JBpkIXEkPiUgIdX/g0D/tLUGdJC?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbb79c1-46e4-4359-3ba1-08de2202c4c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:47:22.0981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdZfY6SAVAJRFXlpJxNX8VSjEH1RUvL1b3Afdo2/lmdYvko20reAWY8dINnphRn7KUGAkCFwdxTg3g/UyllYbOy4aCUfTvbOtrhq/3oclb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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

On Wed, Nov 12, 2025 at 03:11:23PM +0000, Ciara Loftus wrote:
> The common rx path selection logic iterates through an array of
> candidate paths and selects the best fit for the requested features.
> Currently, in the event that two potential candidates are identified,
> the one with the fewer offloads (and thus less complex path) is
> selected. However this is not correct, because if the path with more
> offloads has a greater SIMD width, that should be chosen. This commit
> reworks the logic so that the number of offloads is only taken into
> consideration when choosing between two paths with the same SIMD width.
> 
> Since the paths arrays are ordered from lowest SIMD width to highest,
> and vector paths tend to have fewer offloads enabled than scalar paths,
> "new" candidate paths with greater SIMDs widths tended to have fewer or
> equal offloads than the "current" candidate paths and thus were
> correctly accepted as the best candidate. For this reason the incorrect
> logic did not cause any incorrect path selections in practise.
> 
> Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path selection")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

But see one comment inline below.

>  drivers/net/intel/common/rx.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 5012e4fced..9fa3cdc64d 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -300,8 +300,11 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
>  			/* Do not select paths with lower SIMD width than the current path. */
>  			if (path_features->simd_width < current_features->simd_width)
>  				continue;
> -			/* Do not select paths with more offloads enabled than the current path. */
> -			if (rte_popcount32(path_features->rx_offloads) >
> +			/* Do not select paths with more offloads enabled than the current path if
> +			 * the SIMD widths are the same.
> +			 */
> +			if (path_features->simd_width == current_features->simd_width &&
> +					rte_popcount32(path_features->rx_offloads) >
>  					rte_popcount32(current_features->rx_offloads))
>  				continue;

The logic is correct, but reviewing this in isolation is a little confusing
because of the naming. Normally "current" implies the item we are currently
checking, so I assumed that path was the currently selected path, but it's
not. The roles are actually reversed, and "path" is the one being checked,
and current is the chosen one.

A simple fix that I think would help readability is to rename "current" to
"chosen_path". We could also rename "path" to "curr_path" in that case, but
I think it's unnecessary, as "chosen_path" and "path" should be relatively
clear.

What do you think?

>  			/* Do not select paths without bulk alloc support if requested and the
> -- 
> 2.34.1
> 
