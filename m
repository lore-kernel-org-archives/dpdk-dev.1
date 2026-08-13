Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B5AC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 11:56:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE9B240E20;
	Thu, 13 Aug 2026 13:56:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CA45D40B9C
 for <dev@dpdk.org>; Thu, 13 Aug 2026 13:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786622200; x=1818158200;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GkF+AytRpcC0gWoAJjty1RP+jGmG58m2UkELNXXJKto=;
 b=ffmaSHxtqNUCxr5cESPyOmlZtaNDnZDPBsRmSv4jiVgt084zd9JhKroi
 8tZC69bI0qPc0MGOT682zvuKaPYlR8kwGBC715Gl+vlkqDx2nLEmSdvaG
 fFXaXvCZb18pg+gpv09I+Mfyd8PpybyDhGqXAfnJ3Yjs6SCOSkchjQ5cv
 ZDQgLXplrWmcOPffVA/nPdsyu+Kdz3WmBmYBwlJtBbUaipq6PhDpBQeA4
 AeVV7Cp12vrVwNXjvgH1ZruEr3bPeWJVpBV/Pmq9OH03H3zoyC+OhGdzJ
 CUyQkJkoSlj3vJPbuPsyzg0CqW+fGI/c+g3umw8R0sQnGh8QdPg1QtLlH w==;
X-CSE-ConnectionGUID: T3mzAZy5QEy8RegCFrPN7A==
X-CSE-MsgGUID: yZImI43OT5GELia3b3S2rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89713641"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89713641"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:56:34 -0700
X-CSE-ConnectionGUID: Ki6jrWylQ4mBgo996Nha6Q==
X-CSE-MsgGUID: wRQ6OjvMTyG70fFxD0iWgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="269114145"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:56:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 04:56:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 04:56:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 04:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXgEK+TwblY+uVwPtq7qvvVVKnTvWnvxCIM67wjYRz4FAWWOOKjhMwi7MMt9FSOps+yhpA3RA28BkNMdo0BA49NB1TaD5Pq3qS1dkedbO0gQ9sP/SEKoYaobxjt+ocTBcSmRCfS0zMFV/jaiuhoNEvzJwfRmctzpUie8n4+PoBe+YSf+hLezcDFI5/gX7V3hn2hS8iHrM8RokgLgCx4nj51ursoDNlpZ8KeFWkNnqKmiQX/M6BfDkgd8zFJA6/axBdIVVZtEa+rSoeH5h2CP8FMDFsZRN7+22umcfrO9MH3h8lL7ONlOz6D6qtsKEZ8sOkz/9vRAk1ygxQvEwnOSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbg6gYIoPmQFozR04NELqppReTruNpmRuswBBo4ISUQ=;
 b=UV1MaUeLp6P4qy6s0linDl7sBB7whlwh1diblRpfCmSEddTXIH/cbntix9yhcSaG7zj3UTJpW3YTRFWm1pQtnMh+R+2pG3srSAMOfVbKM5U2a8zeBjAPLHN56hZUy6T//Dgn39e6JP8Wcr1lCEWDQxbcurp0ts7AYo8eOaJuq/mL8CtbN0eyU8K3gkD/z9vDYYOKlAUrPITFINt8fql3nuCTHCmUAZcrugBkNVMkIajFqzzsAE84N6EXNq9md/UfERFNJqDdgfQk+ZzUKASGMpt7PirBnmb/60GUg8fJojqQdPJi7Ebjr1M1thfZRY9zil2jJCZH36brUpXuHs5jyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB689426.namprd11.prod.outlook.com (2603:10b6:806:58b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 11:56:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 11:56:31 +0000
Date: Thu, 13 Aug 2026 12:56:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC PATCH v2] mempool: optimizations
Message-ID: <an2w6xvcssfVEjTB@bricha3-mobl1.ger.corp.intel.com>
References: <20260812090723.1771628-1-mb@smartsharesystems.com>
 <20260812120626.1772120-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812120626.1772120-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB689426:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dbaf42-697f-4a32-43e2-08def931ea5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BRMA09Nx/2FzKscQRC0sKdTM4fsy4EXvH8AhR1K3zNRTpmBmCQWX4ey6W8b5QWV7btc/cW0CCAAZCdCnjk01iEB/22AmRXWROjqBiwSgaIIoeZPDJMGpV3GO5Zua20i0bXOQROZh5+NdDeSQmsgyiEi7ZNfuodq8dZQtDshFuSXemJ06tekBADPQdmpkZ9Vk33Bgpyv/72VXo/VxCrIQnTxdIHYyaBtgM8l2VcerLTNITHcTBOefc0oTZT7to5CCmnH8OXXn6vyl68oz9MtWuLP3C/BYrAONXTLsmMMNwLs+DnlcpP691BUOGVRbocMza/diwDdlVEGTelgHJpTe1o0tI6Mb8uI2W8wLZOA8+E6YOCN+hLpCvUvDDp3gngl06kAI00lGx69qZwQElAI5S96whcHwI4XN9G5J3QIR6gf+B0MqSV2a4urmW/r2/crY/F9a5REpFGcnchYB8g2a/YsdM4tzYj1E6xrdzVZHCKGvW/GF0KgGN3G40WFVHMj+HrW9FABfMPLPxPdJ1Y00l+/7TLTtAmNxJISwifRSfCvCvIUf5vxVSPZfUTSRUF4ErezlVFUyG0r++2aXCn10lJsfkvcj8lRRSx6A6rJMVWNNUu+9KIoOVSx8CUhwd1eoKMrcniG2vimdHsiyjx3XhI2tyBc83tMHKn4S5Yo6KkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/rCPQjhLBPQWPq9F+pon/ya3ANnQaDfsIAdYHvHBctnOCSQsxZYeY4qgAE?=
 =?iso-8859-1?Q?xEQEIjnauVjVNvVDrefDRcLjGyHV4TrFMiX6XWbtXr94pPpzPxskSi6/Om?=
 =?iso-8859-1?Q?NpUrvA+T9LaIGJLU05hI4uHaGeGiXtuSWihW/WXqjd3WHFWQw6cksDLpJQ?=
 =?iso-8859-1?Q?n3rDhPEajNzdE5Kx+lgNwaIXYn+2MMnI3qffeETMUBjaIvYxltDx3WkSJP?=
 =?iso-8859-1?Q?AvEkJb8fRoybfdlE0tbOOj6R64JYSrIHJ/jzrsTZG7fukOJrPCVzSHXD2M?=
 =?iso-8859-1?Q?lRv8K+4ZVH6d8cIpLXiQBLzdld82U2AAj8JLNPcH8ZF5igWMjMgwIyUW80?=
 =?iso-8859-1?Q?OkcwCjw9l1gEmU0yKbAS8VZYc7J3Se6ySjO1Wu/L6i5RPmYAS56rvwBxtC?=
 =?iso-8859-1?Q?G+CzZyB68JepfBKOWYj7RaM1H1J7UDZvbexrReB2C1tHHdWYTdc5Uxtq5I?=
 =?iso-8859-1?Q?TnYfSLkOVVS8M9j9iMtE4wkS7VC5B/bf302RalW63Ig3YcHeIhvh7UzB5y?=
 =?iso-8859-1?Q?YD833EWtDYZAmviMx6VzPfcqriTWotrDybY17SGvstfLLxaw+xV+b3IBgY?=
 =?iso-8859-1?Q?G2D4Nap4DmEsOyLGrrWsXcLKhHNFWQ3Gds2Cio7cYUkrLD0iOC9W8RidAa?=
 =?iso-8859-1?Q?Y+2QwHZLADe3ZuTkv3GYGqkaACIKwnbCqZN6C7cuxbz0L5PfB2CEB93+jV?=
 =?iso-8859-1?Q?7yhcvdb3domieLglsJlgotVSBFdj1hdxeGoWKpjLtyt//GWOn/9LDEU702?=
 =?iso-8859-1?Q?jSUjaxDUTpP+iX/uIdNG2aFNImYIaArdKGUbgiNqTXVID4xp8ZrPKoA+RP?=
 =?iso-8859-1?Q?45oJFYpBDmRy9bavqffugB6C/G8ErttotLSPTIjgUMeAZ+TJQhCqaadJ9/?=
 =?iso-8859-1?Q?2BrzSIAKoFFwf5Pp2jWUXac7WimYdRx5kI8O/Lahcdaz0UC2mJcAGJZw68?=
 =?iso-8859-1?Q?0V8L/uP7JaDdP22fgQCizBeTBwowhM1nrQZOycA3SNjT06jCZLLtmOyrqn?=
 =?iso-8859-1?Q?umLZwPe5TdXqRPIgTojdNR0Hu1gD88VVArAMv6bHoTF9TglniEvR/C1DoA?=
 =?iso-8859-1?Q?9EN31h6lKYSBN7ab1h1rwvSUZCLTbhivpqOoi+UJMLtSX6a0lxMRmFs345?=
 =?iso-8859-1?Q?QaOts3jMDjqMYSrPGwBtSaY+PvkvPVtf6G9w566QLQ8GGnNAa1VrK8IX6V?=
 =?iso-8859-1?Q?w850rl8c5ApwrgEPCf6oJHsVTHyqNylVf1Ci/lwdamSfoEftAvTj/JAM/f?=
 =?iso-8859-1?Q?Q3f1Xj3KNPgTdbjltD3gFuzMzsdtRi2jd8elkbVX4tfhT6YfslD7o8OPUW?=
 =?iso-8859-1?Q?btoXlIFq2GuX6oZYGBwV2Tll3NZJAYIL5Cc0jUxkyfnEvd7bjgySpU2U3O?=
 =?iso-8859-1?Q?5xiKvm42rPYNPfK2bjnm1P+b+2IaWwEfCQl9sua7WMRHjIquCg1hwc8z/E?=
 =?iso-8859-1?Q?Eib4NC0EcYI2KnfbmWsrEwYwUlClXkU25UGMSlxMDlh4JOs1qpv/HjZAnm?=
 =?iso-8859-1?Q?KdhazXGY5EM0pYGFhLnjrPU+RSbI/tC638Psm7fY5kaV/1XO97BmSvA5gN?=
 =?iso-8859-1?Q?SxDnLFNWW1G92T0e17vKcrGifDgcWh6oyinWxOLaSKtj07CNUtm1147vfq?=
 =?iso-8859-1?Q?fcY8EjWjoAA9bJ7rYrzOgfm1N/MInH1hVgsBc1/yvRksbO+LSgBcBYZBf6?=
 =?iso-8859-1?Q?0tmRhvQ9HbDJy0qUVfYhMeGfa8E5VPX7ByFFfb+iE0T2sQm/0YzoQtfMNp?=
 =?iso-8859-1?Q?5Tt5V1AifxjZVwBdpv+/awOpbTn4wUUmVb0sjPIreaPiJibCjDX+QEbHLy?=
 =?iso-8859-1?Q?Beo6yKuLKa/76JE5Gj60tm1Zyv8WxdA=3D?=
X-Exchange-RoutingPolicyChecked: bQ4pBOO6QKgnkOr8SuW0Hl0n6gCXfwwP5O4sEqgK6LoCoZZBuRc3GQwZ2sHHxmUhwqPX6eHvZLGDrTU4tT1j0YapgOd93+EsAiT3Hh9IcMEp7zN4RVuZKJ31pdrd3dHDrRjA4Vgw5KpVy9jjUQXizxrVKT0JWXlFRL7gOM8lTbhAh17nckc6PBvzUkg/iVynRgorsFc040o4rWV7tVqQKXrvdNLMR2uH8iHF1fVIHRob2lM/hdBk2T0xKzEH7yPrS6VLhJB4Cx+JdPMi10yFRSRwT+fF3MqgS9eABneUJZP1S/q7k60jkQQLeOf3VBux3ayQ1ns+1AIV2rOqhq+wMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dbaf42-697f-4a32-43e2-08def931ea5e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 11:56:31.6159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNPnBQQ3SiBHibnpiswIjqt1DGcIEMrSKoXAZaJPnxiUmPp1IWHqignTKnGH/3Cihk5anEifnLmHOEdvl3eouc2WiB6unD2oSTFKwWHO8Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB689426
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

On Wed, Aug 12, 2026 at 12:06:26PM +0000, Morten Brørup wrote:
> This patch introduces some mempool optimizations, which might be
> controversial.
> 
> 1. Access local cache without first accessing the mempool header struct.
> 
> When getting/putting objects in a mempool cache, it required accessing
> the "size" field and "local_cache" pointer in the mempool structure, to
> determine if the local cache was present.
> 
> The mempool structure was changed, so the local cache array is now an
> integral part of the mempool structure.  This means that local cache can
> be accessed directly, without first checking the "size" and "local_cache"
> fields in the mempool header structure.  This avoids a couple of load
> operations with a potential CPU cache miss when the mempool header itself
> is not hot in the CPU cache.  The "local_cache" field was changed from
> being a pointer to the local cache array, and instead became the local
> cache array itself.
> 
> This change similarly speeds up rte_mempool_get_priv(), because it no
> longer needs to access the mempool header structure (specifically, the
> "cache_size" field) to determine the address of the mempool's private
> data.
> 
> Disadvantage: Memory for local cache is also consumed by mempools
> configured without cache.
> 
> Related changes: - The mempool cache audit function was improved.  - The
> mempool autotest accessed the internal RTE_MEMPOOL_HEADER_SIZE macro, and
> was updated accordingly.
> 
> 2. Move objects in mempool cache as 32-byte chunks at CPU cache line
> aligned addresses.
> 
> Improved memory copy performance by ensuring that objects in mempool
> cache can be moved as 32-byte chunks at CPU cache line aligned addresses.
> 
> This introduces a new requirement: The mempool cache size must be
> divisible by 32.  The new requirement may be beneficial for future
> purposes.
> 
> Disadvantage: Mempool cache size must be divisible by 32.  For
> compatibility purposes, a requested cache size not divisible by 32 is
> handled by a graceful fallback at mempool cache creation and mempool
> creation.
> 
> Related changes: - The TAP driver used a mempool cache size of 4 mbufs
> for GSO, and was updated to a cache size of 32 mbufs.
> 
> Other changes: - The description of the RTE_MEMPOOL_NAMESIZE macro was
> expanded to explain how the value is derived.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com> --- v2: * Removed
> patch dependency, and included dependent patch instead.  Trying to fix
> apply patch failure.  v2 resend: * Improved patch description.  ---
> app/test/test_mempool.c                 |  3 +-
> doc/guides/rel_notes/release_26_11.rst  |  6 ++
> drivers/net/sxe2/sxe2_txrx_vec_avx512.c |  2 +-
> drivers/net/tap/rte_eth_tap.c           |  2 +-
> lib/eal/include/rte_common.h            | 12 +++
> lib/mempool/mempool_trace.h             |  1 - lib/mempool/rte_mempool.c
> | 76 +++++++++++++------ lib/mempool/rte_mempool.h               | 97
> ++++++++++++++----------- 8 files changed, 131 insertions(+), 68
> deletions(-)
> 
> diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c index
> e54249ce61..76d45cea2a 100644 --- a/app/test/test_mempool.c +++
> b/app/test/test_mempool.c @@ -112,8 +112,7 @@ test_mempool_basic(struct
> rte_mempool *mp, int use_external_cache) GOTO_ERR(ret, out);
>  
>  	printf("get private data\n"); -	if (rte_mempool_get_priv(mp) !=
>  	(char *)mp + -			RTE_MEMPOOL_HEADER_SIZE(mp,
>  	mp->cache_size)) +	if (rte_mempool_get_priv(mp) != (char *)mp
>  	+ sizeof(struct rte_mempool)) GOTO_ERR(ret, out);
>  
>  #ifndef RTE_EXEC_ENV_FREEBSD /* rte_mem_virt2iova() not supported on bsd
>  */ diff --git a/doc/guides/rel_notes/release_26_11.rst
>  b/doc/guides/rel_notes/release_26_11.rst index c8cc86295d..e31325585a
>  100644 --- a/doc/guides/rel_notes/release_26_11.rst +++
>  b/doc/guides/rel_notes/release_26_11.rst @@ -68,6 +68,8 @@ Removed Items
>  Also, make sure to start the actual text at the margin.
>  =======================================================
>  
> +* mempool: The obsolete ``flushthresh`` field was removed from the
> ``rte_mempool_cache`` structure.  + * Removed deprecated symbols:
>  
I'm not convinced about removing this field at this point. Based on
previous discussions around run-to-completion vs pipeline apps, and the
reported performance degradations due to recent cache changes, I could
see a scenario where it's useful to track a separate flushthreshold or
cache-keep threshold for a mempool.

/Bruce
