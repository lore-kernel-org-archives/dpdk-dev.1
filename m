Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980BC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 17:16:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1546B406BB;
	Thu, 27 Mar 2025 18:16:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2D9C740654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 18:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743095767; x=1774631767;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=BhLRko8HnOH/P0V9eY7Mt+mrsJEJzz69tqaEtV3mVXY=;
 b=AZ2fSzlHuxSCG6sf16ni1YKtHUg0Uht+E6QQnsq2ac18u4dvU82S+3zo
 qDGN2zolVEaRkNS2foRVGzMrVgj7U3qTidlHux8p3sLLY+O4tOpKWJAQh
 Qq07mbGBJbjFQrwefiU3Ldly/8uo0vjTOujZNrnX2OkHck2ZI3s3jdtDM
 aBbbty5Q397OYoc5qnLWRGpK8AzIXg77l1HzObucwykmTeQMrj8mUScfz
 VsjlJy7EoJs1iCd53rprv1Snf4hCkneZjSiIYPpN+FfrakTOWgUkBTTkw
 7Nwo6VgTxOU/1IXCs9KRZvZ6cdn2Dmuf6SSht1d2d7M9bnhDf4nRjR3AY A==;
X-CSE-ConnectionGUID: 6fjXBQzXSR2eULdTHcdfEQ==
X-CSE-MsgGUID: jB6rGzIxTv2mXzPyTudA8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43598817"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="43598817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 10:16:05 -0700
X-CSE-ConnectionGUID: 6XDR5cSFSSOIVOpi/+2WHQ==
X-CSE-MsgGUID: 8ox1LTEHRJevdx1p6DHP7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="162439615"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 10:16:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 10:16:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 10:16:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 10:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO03YWn95OnG+CrQt8va39aKezRLXXgmfRk3iFC8vGs9Ytjbr6pRSq8sm8YkpdCp+Kz0xDQlCBuQgFLX+oZ8AbpeCOspJ8oapRduJBCElH/RhmxiL8Wd0pvI6unN0kzoA+IC/x2NFkN11FEQshDVbQaA/Sbt4n0z9dihOm9fsDUDBHRJb4huLm9M2e0HiA8kVUslFSqLybSagdxat9PgCeXy+TbNhDxU/6bb5YqsEm+L668rcFSX62tus0Pa+vzAm6I3OAsZuSa7HHXNWd9C9+e1G3pRa3DxxcnhrSxlNAAXhr6vVIkLdtdpPR9r735LsD8afzPPNAmTcd67DFLt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gGlvEd4CYdiBP3pBiQGBOO4+S7JvTjO+7MBQcZu4Yw=;
 b=F8EQS62ydoWCyKnehv23vBl+bS0l8zHupqQ/ERtmeBA1FLQCcVJooXiD41J3I4UvYaBYqi74WjkSukyumQwgMZXZRN98x0PWJG5cWf0Qepc4TmQhdLmRLjduh8jIkKUR4Yx8ZmjHdIC9atDwu/4H8v6z5t27fjh1/92aZu8QRDxVtliYLU5H0nD/KZPb7BOGyp9m4ROwh4+4yxwIkRIMqcgnf5cwYl0P/5sPPGFT4X8P+ImXDQ9UkKJp29ubHnBBTWvrBHKDn+LuSuU4SLMNIAHZ1NtHx19u5egcgbkEhsY15XFR+NM+4Wz26SPW+rA83hffGzBTX5I70Is7kjN3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:16:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:16:02 +0000
Date: Thu, 27 Mar 2025 17:15:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] mempool: micro optimizations
Message-ID: <Z-WHzgriLwWC_3Mu@bricha3-mobl1.ger.corp.intel.com>
References: <20250226155923.128859-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226155923.128859-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0286.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1fa3f2-6705-4e21-e4c4-08dd6d530d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zUcYIAyp97+7lc727ZcB5/6Fg/nzlZqFBiFjsUagUcZAchyFJ/m4Idy5a+?=
 =?iso-8859-1?Q?1QnNiv29UQrSEcD/9LtyGMRmPoEFI8clcfSYeHRfW8KBt/0ZduC0x3BLGP?=
 =?iso-8859-1?Q?H1JscMFb7CqAdj/ZVTWBH6kMhvzL6JUSNa3078ok57cwgKUwL0fWPoWPzW?=
 =?iso-8859-1?Q?j97+NL1wsLlmHXJofK+PV76MuasdMURa8NNqNPJSZqUFleHGCcEyxP1m7y?=
 =?iso-8859-1?Q?7zTeU/0hEKWxU2AcTMYCRdcHG8H0WrwnJjH2eStyJoGrQyqT+TiZnwurLy?=
 =?iso-8859-1?Q?WQY75qO51QrIoVdLPkLD3LEN4lsXzOEtSDMT2fSMlyQxonv5gRza7/3+mu?=
 =?iso-8859-1?Q?a2LaG6T3XfGLq5r5Fgh0ZqOKvpAGDplU3gQMnwIvgBW9O8i6WL1tFHtSvb?=
 =?iso-8859-1?Q?j5ZwHLpNTlz/ibcm0mAhxGdd7ae3oCH6mzFKQ82dwJFnDQf+I0f+Q6V9GO?=
 =?iso-8859-1?Q?ZUtr9gBUFhSYE3/pkkeP+8gBRUaTBTC5lOXUvusrvQpe4+WFMqHDm5d38g?=
 =?iso-8859-1?Q?iLmp98Z9rGlTn78Hf6c2GmVPvdJcxSJUtFybfL+ye6x91GfrDeRM53/a67?=
 =?iso-8859-1?Q?na9tZFjRgPteNvksqaStUPl+UvFgp4BEEDbF/Pw2OYEyQNhK2a776lRKiX?=
 =?iso-8859-1?Q?h8VVvw+bs4V0dmhuRl7ZelZa6e+GffZgDfw2/tUSv3KWpmJER6kWUd3z3p?=
 =?iso-8859-1?Q?MSL9lTzVScxSPTwQdrqmLhsppDp0JqjZvN2JjCCyz35yX9QK1jIE1zURtK?=
 =?iso-8859-1?Q?zPIBhIFJH8ksn6zoZ8NaAvr8EmBUnmeKlDgxsBrZg4NLTYbnYknAJML4bQ?=
 =?iso-8859-1?Q?imGvUa7PAJeTQ+j73xmKyi71CU9Gow0fWmPdBdIn4JcBBRI3xNBWjfQ6sz?=
 =?iso-8859-1?Q?tdcf5EvxpqUCiwWbyleOTuuMfz5GjQeRBlL/kYNLJmEUsQpdFIkyqcUkwh?=
 =?iso-8859-1?Q?+kr3kEdfV4tRTwHOHWJLUvODOcCQDK5t5euVzOz1M44GDH77V9sQjXVJO1?=
 =?iso-8859-1?Q?4lnXWfSHHT72TAcPxOsC/fbw1BRPut0Bh5edLT8VFOTBGpQgD1pN9YgVeq?=
 =?iso-8859-1?Q?MkFKGMp9GX80ay8gHb3s/VGbrmU10zNoN0DCzOcjuoaKl84jKe8eDf/EfA?=
 =?iso-8859-1?Q?b1NUv3xPJDpApXndVpuzUOJTrGuiLjXop+E4uStqMas9bb+5MB2lERbhLi?=
 =?iso-8859-1?Q?GuwKRnQx9yicwYMfsrLaIlhdRflvkDxCxG3kTUiCrawFwvFrbv7aDNAI6W?=
 =?iso-8859-1?Q?n7dng0qz02uGNv5rzPEVFscl8n8s5XxMdroj0+CuIVZiJPOPLM6WOmqKrM?=
 =?iso-8859-1?Q?mUlaPvnyp1eWIBlZ6WK7NMTkqa1N7pKn/jeTD/3cRK8rlf1qOLwopONFuV?=
 =?iso-8859-1?Q?L24rUiupV6YnT5xJAOggAG9zIK6geXg/ioL+iWkmQyDSIff3psuwKcfKoV?=
 =?iso-8859-1?Q?Cb5PwQ2nzj8kmgsqtQo1pnqYL9jMKH2pAhv4NMTnAT/GKFSS3ulMhi2SHE?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M83GhMsWLHUxj4JhOzoC3kEm4VAfeA+U1nIBRqKMiM59JVjbFJODV2pb4Y?=
 =?iso-8859-1?Q?OaVMU8NYAewRngVQ3HnEgSTqR4fGetzlQNDBTeQOCN+RttANoRKlRJfNSw?=
 =?iso-8859-1?Q?RDGBvbbui3l22RcfenHlDaYyAVkz4pXXDOYlLqxFetf4dVF36sW+GaCCnL?=
 =?iso-8859-1?Q?jo2ZLgw0oHQBrmZqBO/TS4HC2RUYh4WbQm36sKSMfHYRjlOTggrFGUyETU?=
 =?iso-8859-1?Q?Sfs03Ov1p1GI+akz5ZS04XUkH2U+KwZeOQrpVXjQ4V3dX67jbFqYJw+sq7?=
 =?iso-8859-1?Q?k+GWOsboqHNw3poOnZvEqgsTv8onMUHIKf3J8FyRZ01lZfm7lS6zog7B5j?=
 =?iso-8859-1?Q?qwVXttshU6pNtemdT7Jye8HGA8LP3f/G2JnubUtTC0GhFZV2cCSi54rHv3?=
 =?iso-8859-1?Q?EW6eb9Lr/bOnokbo6KxU3aGZp4c9Ybizb9dk1nC0b1LWaA2dSnW7vo0h/M?=
 =?iso-8859-1?Q?ZqFTLwtfXjxyn+groqElyjzGd6/pQ+BeiclaTKvRI+IFvI3Ok4DlqO7iww?=
 =?iso-8859-1?Q?ZykwvTrX17MuDmefCsslB+LecObW5mYfrCPjC7uNI5te8iMljDHYLUGsYA?=
 =?iso-8859-1?Q?OCUBIDj0YqVNP29c8bjCVugpN4QU9yzWFijbyXO5cJPwRXzNFEQz96NUW8?=
 =?iso-8859-1?Q?7T6IwoWLVQDW/cIKxj778s7Sx2Eu3j0UoZ0xBOfz9uSAQvt8dJdl7/39xd?=
 =?iso-8859-1?Q?/zr9Feg1v5GEk828XnInwo/VerwksUcaUqzPoUoqVilv/XgPpMnMfLlDzi?=
 =?iso-8859-1?Q?zfFtkYViI6uH26QlZKBGAuff+8ceT4Ic/T7mGznoO+yq0QnFo7Bg9A0dOR?=
 =?iso-8859-1?Q?QZINV07gGUdpuN06qXlirL9kXxCKWQTWtprIaI89bbNtYgmEMOL2xqXVVf?=
 =?iso-8859-1?Q?d4fAfZrBmYRJN2Mscb52gnlIPg5b9HTgKPUHv5E5QhOI/D6m+VLc8+PWp4?=
 =?iso-8859-1?Q?/eCWFLQivosn6r4xeFbCIxhIm3d+hQRo7lHW1bHvYZhGeaapWyKhmf0jJU?=
 =?iso-8859-1?Q?4/bIJLASAOB40faMxLl0aBv21y9GHPHM/xmUixDQHY/C2k80WBawPqrTZV?=
 =?iso-8859-1?Q?9s2ZmUi4c0CowBPCQrazNPpi6myOcojeVdWPguzHWc+SNq4JHVWOEHbqJ/?=
 =?iso-8859-1?Q?HyhpIyL5L225ajETpkq0OQT8pZRfWfIObMQRvvu30wve9BH65eeA49bue+?=
 =?iso-8859-1?Q?R28PZiIkK3qkEvzKrIe+GdaND/zZOhkGKGGIhkFRpYdlMCA+4EaPWOgb6i?=
 =?iso-8859-1?Q?T7NnuOWJwmHRIu7TkK2dVyU/M1BTfn7xIWt+tGhdai2qAkr3bldT+gHsuZ?=
 =?iso-8859-1?Q?LFS/H/rpAk+MDXH5mDLGWuT1R7BvUteugiD3c5puy/t1TzdQPCeIFG00ph?=
 =?iso-8859-1?Q?v97WsOaYv0yL0eNsp1RgsLrkxmBMzXlUc5K4ptqbKDr8gYPuUOZX9ESo4B?=
 =?iso-8859-1?Q?fGScWUI0ujA3qiiSDwA0MAIL8oPeF9S7Pa7lG3zC1pu/UWJXR8tGiUCwQh?=
 =?iso-8859-1?Q?LlC/fi41vcoYVLyfukJHvKG93Qqd3+Yo+pSMpeDXjhG/2a2B43wuURJgqh?=
 =?iso-8859-1?Q?IP+xhPvvGE3mG8gW9f5GTDtGETS9qzMZyOuRAXPtrRZKSnz7lPOuACGZkj?=
 =?iso-8859-1?Q?UA1ne+pmy20Ldq8T/BoQT8fyuTYWOhPIm4hMRa+nT9J1BXqL27iE9IkQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1fa3f2-6705-4e21-e4c4-08dd6d530d16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:16:02.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8a41l2ouJ75ZcJXcGadGVo1ueEDCjMgIGBI6LY7xvgewYOPOt+bceyvULZpVaOulBiHKZAGRbjseULAKSAF4nNqzL6KxIOeBk2TWzEa3uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
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

On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Brørup wrote:
> The comparisons lcore_id < RTE_MAX_LCORE and lcore_id != LCORE_ID_ANY are
> equivalent, but the latter compiles to fewer bytes of code space.
> Similarly for lcore_id >= RTE_MAX_LCORE and lcore_id == LCORE_ID_ANY.
> 
> The rte_mempool_get_ops() function is also used in the fast path, so
> RTE_VERIFY() was replaced by RTE_ASSERT().
> 
> Compilers implicitly consider comparisons of variable == 0 likely, so
> unlikely() was added to the check for no mempool cache (mp->cache_size ==
> 0) in the rte_mempool_default_cache() function.
> 
> The rte_mempool_do_generic_put() function for adding objects to a mempool
> was refactored as follows:
> - The comparison for the request itself being too big, which is considered
>   unlikely, was moved down and out of the code path where the cache has
>   sufficient room for the added objects, which is considered the most
>   likely code path.
> - Added __rte_assume() about the cache length, size and threshold, for
>   compiler optimization when "n" is compile time constant.
> - Added __rte_assume() about "ret" being zero, so other functions using
>   the value returned by this function can be potentially optimized by the
>   compiler; especially when it merges multiple sequential code paths of
>   inlined code depending on the return value being either zero or
>   negative.
> - The refactored source code (with comments) made the separate comment
>   describing the cache flush/add algorithm superfluous, so it was removed.
> 
> A few more likely()/unlikely() were added.

In general not a big fan of using likely/unlikely, but if they give a perf
benefit, we should probably take them.

Few more comments inline below.

> A few comments were improved for readability.
> 
> Some assertions, RTE_ASSERT(), were added. Most importantly to assert that
> the return values of the mempool drivers' enqueue and dequeue operations
> are API compliant, i.e. 0 (for success) or negative (for failure), and
> never positive.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  lib/mempool/rte_mempool.h | 67 ++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index c495cc012f..aedc100964 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -334,7 +334,7 @@ struct __rte_cache_aligned rte_mempool {
>  #ifdef RTE_LIBRTE_MEMPOOL_STATS
>  #define RTE_MEMPOOL_STAT_ADD(mp, name, n) do {                                  \
>  		unsigned int __lcore_id = rte_lcore_id();                       \
> -		if (likely(__lcore_id < RTE_MAX_LCORE))                         \
> +		if (likely(__lcore_id != LCORE_ID_ANY))                         \

Is this not opening up the possibility of runtime crashes, if __lcore_id is
invalid? I see from the commit log, you say the change in comparison
results in smaller code gen, but it does leave undefined behaviour when
__lcore_id == 500, for example.

>  			(mp)->stats[__lcore_id].name += (n);                    \
>  		else                                                            \
>  			rte_atomic_fetch_add_explicit(&((mp)->stats[RTE_MAX_LCORE].name),  \
> @@ -751,7 +751,7 @@ extern struct rte_mempool_ops_table rte_mempool_ops_table;
>  static inline struct rte_mempool_ops *
>  rte_mempool_get_ops(int ops_index)
>  {
> -	RTE_VERIFY((ops_index >= 0) && (ops_index < RTE_MEMPOOL_MAX_OPS_IDX));
> +	RTE_ASSERT((ops_index >= 0) && (ops_index < RTE_MEMPOOL_MAX_OPS_IDX));
>  
>  	return &rte_mempool_ops_table.ops[ops_index];
>  }
> @@ -791,7 +791,8 @@ rte_mempool_ops_dequeue_bulk(struct rte_mempool *mp,
>  	rte_mempool_trace_ops_dequeue_bulk(mp, obj_table, n);
>  	ops = rte_mempool_get_ops(mp->ops_index);
>  	ret = ops->dequeue(mp, obj_table, n);
> -	if (ret == 0) {
> +	RTE_ASSERT(ret <= 0);
> +	if (likely(ret == 0)) {
>  		RTE_MEMPOOL_STAT_ADD(mp, get_common_pool_bulk, 1);
>  		RTE_MEMPOOL_STAT_ADD(mp, get_common_pool_objs, n);
>  	}
> @@ -816,11 +817,14 @@ rte_mempool_ops_dequeue_contig_blocks(struct rte_mempool *mp,
>  		void **first_obj_table, unsigned int n)
>  {
>  	struct rte_mempool_ops *ops;
> +	int ret;
>  
>  	ops = rte_mempool_get_ops(mp->ops_index);
>  	RTE_ASSERT(ops->dequeue_contig_blocks != NULL);
>  	rte_mempool_trace_ops_dequeue_contig_blocks(mp, first_obj_table, n);
> -	return ops->dequeue_contig_blocks(mp, first_obj_table, n);
> +	ret = ops->dequeue_contig_blocks(mp, first_obj_table, n);
> +	RTE_ASSERT(ret <= 0);
> +	return ret;
>  }
>  
>  /**
> @@ -848,6 +852,7 @@ rte_mempool_ops_enqueue_bulk(struct rte_mempool *mp, void * const *obj_table,
>  	rte_mempool_trace_ops_enqueue_bulk(mp, obj_table, n);
>  	ops = rte_mempool_get_ops(mp->ops_index);
>  	ret = ops->enqueue(mp, obj_table, n);
> +	RTE_ASSERT(ret <= 0);
>  #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
>  	if (unlikely(ret < 0))
>  		RTE_MEMPOOL_LOG(CRIT, "cannot enqueue %u objects to mempool %s",
> @@ -1333,10 +1338,10 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
>  static __rte_always_inline struct rte_mempool_cache *
>  rte_mempool_default_cache(struct rte_mempool *mp, unsigned lcore_id)
>  {
> -	if (mp->cache_size == 0)
> +	if (unlikely(mp->cache_size == 0))
>  		return NULL;
>  
> -	if (lcore_id >= RTE_MAX_LCORE)
> +	if (unlikely(lcore_id == LCORE_ID_ANY))
>  		return NULL;
>  

Again, I'd be concerned about the resiliency of this. But I suppose having
an invalid lcore id is just asking for problems and crashes later.

>  	rte_mempool_trace_default_cache(mp, lcore_id,
> @@ -1383,32 +1388,33 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
>  {
