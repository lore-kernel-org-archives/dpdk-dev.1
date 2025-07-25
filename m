Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96395C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3AC340616;
	Fri, 25 Jul 2025 15:45:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3749940144
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753451157; x=1784987157;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VslqMQJ0614vn8MPUrflj/RIo3u9Gig75PDbFMAZu7A=;
 b=lNLUYw60ZQbOWum2UrHJCM3wppRhDJf6P/ODrmLJSKwQGyDt3kmbr3Pf
 p/HtWUGbwIrR2vB2dSupCGAbstNNWiJYGPJVpTWmP5rCcs4e2lqmaBwG8
 egeL9Moz+wJ9orgTLXtnml6fpfo6u8jmi6ji83N2CpW9ChJEiJlMByTtN
 QqVQ4CT6bRh3Wl+Kw7+W5pgC5NcZG90WRvqg8fQvBUmH1XUc6oPYI5OW0
 gaVSJpVuhlqb4DBfJhrOMaqEJFmJ7W1r7oBGkgg6ZrqSEJuflOHiEWk5n
 UWnwjewYRy6wG+HhBN4Q0oOUlVAmljOfo1mcad8Y5U7zF85c4NXV3Vtl7 g==;
X-CSE-ConnectionGUID: li9P/PgQRPi5ikaenV65hA==
X-CSE-MsgGUID: Ux2YW21uSRS0oemzm3buEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59440063"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59440063"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:45:56 -0700
X-CSE-ConnectionGUID: UHU2cymfQUmNGzXIKMXpqQ==
X-CSE-MsgGUID: VzrD9iNPQAmErsXbZMaYSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="160261713"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:45:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:45:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 06:45:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6tnnICvwSoJ0Fr3VhiDJfkcLazrvYsPkGVUQJz+f4tRKQeBNOWSUAIeXvJGLy8iZ8j2SC55GlxmyyMIH4DH4ybLPDHPvno/ebj8zSlDgiaeMJ+MLBnRhhGLn8oXxh+5QZd9u3+Y1svHJoxcEq6SoUBPjudbR3GMc6Ye8VE+Pd1QPLV1bnX1LFTEDRM8/u0Azna4LwimuZar9H6MM1eM2H5tW8ol13AFJeXo7YS8uQXV5crUlh/FDs/Hf3Qrx8iqtJYrUjyw4//Jh4B4r6ZFQveLWlBOauhc/RZF5SOv0BDAlMwYQ71GX92dJEP3Pr68l2NowdjWvk2A9SBS8qMrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ++A5x/ykAwb1XnponcnIC3DWmGuw98LM1UVqphEAQ=;
 b=ONtlmBA26+hEmOpF1hcFPvK9LBFyH1RhGNKYlUN0+xiXgOKAC3tZFUzPzhHlh2X3/+2EwDOmmQxXz/cW+faE9VPflxEttpl8Jvr0+DmMpTxUK/2QNzBrbAkhyx0Sjeq0Hfu/i0ccV8rDziVfa2FsQHM7hJ1/sp7pQUS8j1caG/gPOYnD/FSpIUKiqiKFqu4hXI+NJCd9/5gTctTMx2zO+nnAQ0OYYsXmc38jceEU5TmM1gJtgYpygTkb8bYpwsnWHyWIkTN0iDvJC7bl8rwXgY0/oqmljpZTOzIjPBYGy4cLVmMbZx0BMxM9Fhro361W9RWTiM8Gd0BmwaCe4quenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 13:45:40 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:45:40 +0000
Date: Fri, 25 Jul 2025 14:45:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 05/14] net/intel: introduce common vector capability
 function
Message-ID: <aIOKgBVNzju4AsI3@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0036.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::28) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e683cfe-03c2-4458-5df7-08ddcb818b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tAvsSUkzcEOuUNgBQ26WdWmOZnPrdy50v2kb6abFLDfilzGcr6uxp5QmSrMO?=
 =?us-ascii?Q?rcpC6hooA8qVH5qq6o61qS27xU7FMyhAWsFpZyuIUVzJJOorZ0+J9EnQGMGA?=
 =?us-ascii?Q?Sj4e3UAoJc4NeSV1DCliDUtMCED9DAFPl+PSPO/lt7dUDRzR0G8q/qHPPLgm?=
 =?us-ascii?Q?cpTXWJSUV9nerP0cS5z5di5FZc1UjTNa2zSYAmKgs3ov8UnhRd8Vbw7eT3oU?=
 =?us-ascii?Q?pIPqo5FTNv9oI4GhQUiwEAnmGLqt15pJ9ja8c7S0a05RdddKhDthxVsaPJWx?=
 =?us-ascii?Q?rF2EXGqd+7+sGI421lQFCOOFpOwnJw9xCc9MitjrS0M8aGrESNew/DIM29L/?=
 =?us-ascii?Q?lYfwlXZ15gqYz0q2r+6F+p5lmVqDWZuuvFzuEWbnq9RjOEv0Sk07KOVGlLO+?=
 =?us-ascii?Q?1B8d/41D8NxtnL0a3Pq6Ck1SlHQ7YxAtC+Rz52pGrFGa+77hkE6/QCDsxyOU?=
 =?us-ascii?Q?+DwdICsYo6wbGBSyltoZqCyZnwl9LjSpT/0/Reo1U5DX/GGTIrXIxt+iJYJ4?=
 =?us-ascii?Q?kIa9yPRvzzf+9wGmW45T+m7VWKupDz7pBBF+dX0jTF3dooHUoa68U4uL/hxd?=
 =?us-ascii?Q?TL/PgCF+Gci+u75XXtztr0JEwkNKCrGPGmVL5m5ahrrIIBbZKM8bxKla23Z/?=
 =?us-ascii?Q?kkI+6b6Fq4TGRqCTAnvbLvoT00rkJmkagwo0x43O4m2XHy/JqrGvEeBgOTCU?=
 =?us-ascii?Q?50Uady7VJbPlsx4YTQWRiryhlGeeivfvMEhhATAyWsRIfcBBnIF4Hf2TzoFP?=
 =?us-ascii?Q?h6UR4V3qm6N6H9uqZraLpGGsi/j8ymMLR7YnOXxGjdP3BQeM4f93QPbBYnYh?=
 =?us-ascii?Q?175qPOCTgyQJP4cQpEw7qPPE9DvwC3bfSM21L4sSxGgF9tUHnKm5ugnSWLmu?=
 =?us-ascii?Q?+mHZxGh4udy0JuP6kgK7kJk2MNlvw1vsxPy1JfW4IvQVV0qjIbN8fZ1kSd+H?=
 =?us-ascii?Q?OQVAfD14/w7I1Qbl+ZV2KpHgGVaZtz9IKff/J/6bw1TKKlDic06ByeSrz7U9?=
 =?us-ascii?Q?l27WOMwQDA/1R4YRq56/JJENs+zqb0sD+0Y8cQ/ZX5PQs8VhFA8lnazaNTGQ?=
 =?us-ascii?Q?xqxrZnQnY0jmUQMt+nKmjAImsyzNzn90+ZS3gUBXDMakT74FStjXgTkBUcdw?=
 =?us-ascii?Q?1cLpCNbT/4JlsmW4MEb0x050fbpuIvRzWea4E4MqrwoWPUQ4SeqwA38P2XS9?=
 =?us-ascii?Q?5Mpj9KrchofXc9u2+BNJzi/k3SrP+IA9GHH+fNuepQcfxjIROG4xQBIwd1I1?=
 =?us-ascii?Q?xquUr77cM689Xs87gERlVHqTYxnsfLJg31y1cczTMWYkqGR3/sQ4UApj4pk5?=
 =?us-ascii?Q?ev36QgEQF3oP3a6c7Omcj8IfW76UqYQp1QRb86wvvtve4nMUlU6uSrzuv39l?=
 =?us-ascii?Q?4JIhwlUg7/JisiS/dUtxOYyzqZQEghCUja3vZhRinJvGA+UIUcBxftakGt36?=
 =?us-ascii?Q?8jEJozxPVn4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JRCF5xT1SlFQYsGr3VqvHoBNpQBrgAQWSjrehFt2YLxe5A3+Dzbn/sRj6P4n?=
 =?us-ascii?Q?VnepBHNw6Q+bxbHLQASSCk8pqdT2ryv6egOWNBp0Z3R0obJ+bPH6tlEZGHq3?=
 =?us-ascii?Q?Av7auKymow6eb8Hb8g5kC3KAY4P6U7HogsO0rEXtKhb6B6S0Lzl9wM2pTdf4?=
 =?us-ascii?Q?kb/Q0EFnea3droUSlzF6wZn3sH/ADBNGAIxleJqxDspOoVgvJ4ACnEUCAX3i?=
 =?us-ascii?Q?BrzTdc0cmSbTrDovsiZKfM/MsALPjMR1DMUvZSFwjkp1xygnk7QTKpTuLMe6?=
 =?us-ascii?Q?OMAqQWrxSPYjCO99nEl2ofTw/fHJCnIYNMJ5ZlWDinPTAcqpr0xVgdlONcxj?=
 =?us-ascii?Q?QuQA/UgWJmwpTYO67fPptJG+2lN6sfTlAtPBYLvQHojCuQ2bz2n4gIb1mpj7?=
 =?us-ascii?Q?qWFAyWn/6/jbAHjKIvvGfXMzauqQf7Lez2U7G+F5sB16DyDlMR9XluB51OYO?=
 =?us-ascii?Q?y4yP9gjcZxbOLTaxhUxo5BwXMcVaj+JrKXKOwdbkQRWj1MTELbJrvpmUoUxW?=
 =?us-ascii?Q?An/zIZq8uG577l5N6gyaXyLPfQzgBn2gKrqGtH3GurKjJrl5vK/QQ+CFbTbq?=
 =?us-ascii?Q?RpK51xwbPcWFpRF0Ckd7ln/V1wzhuXDp6oaAEOqNCs2xPyGTQ/cpBWxLFgu+?=
 =?us-ascii?Q?WEoNrQNoJh9gPrZaeeTf67Bq+IAdTe8VlQYZRgJbo85RtjDvqxcRP8UmlbPn?=
 =?us-ascii?Q?5s2ilYDcs3TnXK80WgcV6p3CClxJMVQsrPGdzFzvNk/CeIGFReU+gkgt42nq?=
 =?us-ascii?Q?9o2eMt2KVjhXgvolThGoJEcAjuvlZOsXn26cEEoFIIr85IbOhRFTltq6FXpo?=
 =?us-ascii?Q?b3rhFeHk8U3s8fHextc/8pMpeZBViaPQgB75of3Au9qhtAOdtTH17fFGm9ue?=
 =?us-ascii?Q?mDa5tVKcOU7bHS0oT4tEjjYVstTuCBZOvxqjcdvpP22aR7cWBGGAtP4LSD5o?=
 =?us-ascii?Q?Qy41Yet9R96SMsRiJB2rb6V/El9o3wPLXnDZ6bmd9KimeTjqeZWwnfPm2dWw?=
 =?us-ascii?Q?XKQVR+nJrkATM4W5flP4v707DXxxE8xkpMBONtmLTwhcIGIGPJv9bODBxiip?=
 =?us-ascii?Q?E5pF2ISR6jQTWecgwJjkhda5snv+IzENXtakyRCLFbckQ4a4WGyvDPh/l6/g?=
 =?us-ascii?Q?+skAodh0ft2axYTJByOMHKSfMAHiGRLeFu2lCqTVLUFz4Hlzi8XVugK030eT?=
 =?us-ascii?Q?SK8X1s+7QzY3ULxCrYabxGGiyJotZJ84F2HHyXcJgMb/BHl/u1oMYpyw/8do?=
 =?us-ascii?Q?K6iSzI2QeEVHNIxhItsL2mVaDjSF07tJMQwOUKQ+DVo4ZZs25+HdivoZv14J?=
 =?us-ascii?Q?7GMQgeK2AOQCI38PiNOEOoGgJYNfQOP7Mp5joc2LC2ECPUdNBu34kSabwVZl?=
 =?us-ascii?Q?+M/kosFYJG+UpQIloAK7/1uPtpMSxds/tAEV2BL/rjEs8piedRu1c7haJc1g?=
 =?us-ascii?Q?J2T38zJX1Yn/LPJ3YGP1Zb7p5tqdz+YwW5nXA2R4EpgYITlVPwGVep/FAQmo?=
 =?us-ascii?Q?EQzgITs8HFEIQi5kzq8R2W78UdQKcWJmuNilEeQKf0Wq3HvMwMXaZSHY2/hs?=
 =?us-ascii?Q?bX6dTCJyt+XgTMk2mRyB6Sk6G3nviV/XC6KfeB/2AD2FpCJxbdDajDw/KTMA?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e683cfe-03c2-4458-5df7-08ddcb818b54
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:45:40.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APWyoBCtiCE/uMmJCcOdQs937EQoHHc8X2rxlf+AwQ8XNcDuyuNlQWtG6gKxkDp28jwr+y7me5GxzmdEEUW+AvGaBCAqwVEI2vuSMLc47nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
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

On Fri, Jul 25, 2025 at 12:49:10PM +0000, Ciara Loftus wrote:
> From: Bruce Richardson <bruce.richardson@intel.com>
> 
> A common need within the drivers is to select between SSE, AVX2 and
> AVX-512 code paths. Provide a common function which helps with this
> decision making, that returns the max simd bandwidth based on any
> user configured maximums and available CPU flags.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/common/rx_vec_x86.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
> index 3d7343b1ff..314fa24b41 100644
> --- a/drivers/net/intel/common/rx_vec_x86.h
> +++ b/drivers/net/intel/common/rx_vec_x86.h
> @@ -346,4 +346,27 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
>  	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
>  }
>  
> +#ifdef CC_AVX512_SUPPORT
> +#define X86_MAX_SIMD_BITWIDTH (rte_vect_get_max_simd_bitwidth())
> +#else
> +#define X86_MAX_SIMD_BITWIDTH RTE_MIN(256, rte_vect_get_max_simd_bitwidth())
> +#endif /* CC_AVX512_SUPPORT */
> +
> +static inline enum rte_vect_max_simd
> +ci_get_x86_max_simd_bitwidth(void)
> +{
> +	int ret = RTE_VECT_SIMD_DISABLED;
> +	int simd = X86_MAX_SIMD_BITWIDTH;
> +
> +	if (simd >= 512 && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> +			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> +		ret = RTE_VECT_SIMD_512;
> +	else if (simd >= 256 && (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> +			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1))

Don't need to check the AVX512 flag here.

> +		ret = RTE_VECT_SIMD_256;
> +	else if (simd >= 128)
> +		ret = RTE_VECT_SIMD_128;
> +	return ret;
> +}
> +
>  #endif /* _COMMON_INTEL_RX_VEC_X86_H_ */
> -- 
> 2.34.1
> 
