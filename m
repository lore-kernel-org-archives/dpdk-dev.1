Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EEDCCD195
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 13:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4EE741153;
	Thu, 16 Oct 2025 15:33:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 38CB140EDF
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760621615; x=1792157615;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ij6zORtGi9JqXE0x73nD0+CqUEjCJOk8UwX4t1tAue4=;
 b=eWYzVLWXXnRH0SvbxhXSfJD2Vz6fRsnGSLDW5sUxozAmLqLEd21Fbyke
 ptDXQShNJEzjemgQEPffXpNObotkz8wYT0lNaSLQJnSplZ2kDYFrpAQPS
 obcT4xfsgElW9hAfcm1EnXxgxWqFPMte+4ThbmIFmvjzII2MlSgi4E5fU
 2mD7k+RHjaOw0dhebo9B4hNSa3+edbch7y11gOCPUeLzNTrMLwvdo2/7Q
 VNyoeix/QbUleFXIXT/jE2N+XqmvT1zP+OzDkux9StCX0T6WfZbXwlLgo
 2FP59fUNoAcSzN9/82wnRTiIMxJ40w+D91OztK/hgmFeyUIBLwFS24kQ4 w==;
X-CSE-ConnectionGUID: pKl4hm38TsOHvddUjsY+bg==
X-CSE-MsgGUID: wD81TgL7SwuNkhpQKLcxLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62962074"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62962074"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 06:33:34 -0700
X-CSE-ConnectionGUID: 8l7MD6n6TTewrHKI+qMwiA==
X-CSE-MsgGUID: eJEpIuU2QkSGwAno6sX8vQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 06:33:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 06:33:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 06:33:32 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 06:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6gomH2Ymu/G3EGOscm0W7TT2OUXiPAoWOfEu1uwwDHpSXljra1GZaKJoeZ4+tLm3+1Z0BxyogE0movq5BjWqOpHUx90NpLt4YT3pxWQapjpMXJvtcrCliOvHeTuWpuVcwKayv5PTwJtWT05K7M82nIvRDgeWr1JhB5Unv35AXsrsnzGg5J2QkevBYoOwznM4kqo+kLzX8b3Zzk3KdHHNrSfAth5bsiQirKrNsV4DGTBDNyl64y7RW4nylCiedhT1Kx6ylU6U2BYgC12tPWbp9fAMJprM/xFtQ6YszJPmlxbCBtOIuraU/6imb1RWFtM9bdoSgHFGC8pBmAKbTwPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylFiRhCTUEDjHH/3grHtvGp0lDaCJa0hM6PRYLIyk+U=;
 b=R3HCTsMXboF3PW/igJE/1flVTjBCMZ2jO6pHNLCv0kQyJzw/4VrLp9trIhw7Yac2y9yZQN+YuB+wxyB5y04hy6MMj1iuD3Xa/NnfADZmdXFj2srChqC6XgdW1yXcftP4Ml9DZbG1YWkMEsPrjLychB1Lt6/3Ad3hVj+PClrGwJCpMZl7juOtwvgdPd9eIyhyXDTrPGgWBQ4N2vO18pRztpBVrWzeGXOtQaYSF6xk4Bymu6T7dNGLiiNDrQm7u/y8bcBANfM3NF8Xu3oVtye3N6jVJL1UXZHDkAj/bJRcvudtUk4ISTZY8HE4Y4WlS3obhWclB7aw66Rj6AO3GNgomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 13:33:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 13:33:24 +0000
Date: Thu, 16 Oct 2025 14:33:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/7] net/intel: fixes and improvements to rx path
 selection
Message-ID: <aPD0IFUm6p67abAz@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251015100723.1603296-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015100723.1603296-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: e43a9865-bb03-43df-ef4b-08de0cb894d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c/T7F4mkjRFL8CePJt6+Cc6EUumKPQ1AZj6+MzLup/hIFcBH9eSNj23KV8i3?=
 =?us-ascii?Q?VtutiJQAXawjeL+v8e6qHlwaozF51wdI+F9zlT5/NQWz4bYJYYZJGse6JH5Z?=
 =?us-ascii?Q?wTdJg4YpOEAdtYE945MBpY3/lFQjR4qVjmtjjKQj1VFKvOI9fGfmYmmJft0R?=
 =?us-ascii?Q?bRumRxGWQ2dcYrk0r12BGeyn0Rp6KUb/aigqg49p/2E2uohEBHOPAJYC6tBy?=
 =?us-ascii?Q?6B45/BKPW1uoXy6cEdn0CCKA+kCHslGDjCR5ZsmXNm17kbTNM3aww0JsdngL?=
 =?us-ascii?Q?80dKI+SBo+ZDtcsvPyK00S/ThS/6wMA4S2XReRu/quzLvlyaz5e4rM5+tb/E?=
 =?us-ascii?Q?g1tPr7HRg3ipnqlV6chzxUykV0DxlrHliroJfS3zfE4DPwRrEPuyf3U3xBzC?=
 =?us-ascii?Q?ILM79Labl5IssaO2aftDYn3v4Pi4w3iOebm3nopxwKjp6G+1/P9d3fEv9Ezx?=
 =?us-ascii?Q?t4lsjEzZ8FE+8COoWHtAv0MV3VbKFb8V4vP6ebeby+bnlOueheT0aG+LXrYL?=
 =?us-ascii?Q?HkMSG4ZNQJhCjmUa+fJaqNNpdxgQwjm6g/cpoWOSMpd/TC3aAkgkAOBWO3/U?=
 =?us-ascii?Q?7dqg9yNXXDMO9aJvKafBMrZqWfKOnn/VBapNohmXx839FUEJnW1ECZG3AQu1?=
 =?us-ascii?Q?lI4xxGblysGaDpFrJUQtK4of6Mv7xWZimxuPIofQF9c79lqjU8kWb7es1xWF?=
 =?us-ascii?Q?rxeByBtgbPPktZvEtjtvMX7an/YS/ZsR6dapjVypakC0N6zygV3o9h5CHlHV?=
 =?us-ascii?Q?3Idw1G+w6cyFL+1vFvzevoN2NQ/Qvx/5mQT8UKIq50655FGoBKSWReAnSJKj?=
 =?us-ascii?Q?TdYPWhMHYaJm3LnY6fr7kWSMtQxj0e+geOuLsqkQKsDa0/MxsQAtGlFn5Kzs?=
 =?us-ascii?Q?bKVzuXkDMTWlNBSz0ibns5N4EOYnuY+X8ITUguyhB+DrM/CA633Ooay5AXUQ?=
 =?us-ascii?Q?YL5JZxldmB9wEhHU1GiTgKg6N065TZWjBYXU36+XPx4+IBzGSNxPnMNTryHK?=
 =?us-ascii?Q?Tazv2MzErIwieuBwqSqkHVZ9tJlVk7TUjeNPy3VycBj+jBIfc6JxLfGZImHf?=
 =?us-ascii?Q?Qzn8jxMUEIwvv6nm4e+s8mMhtoOaJDgFiNvVlJsL0xnnPRutRbOZfWd5x/gW?=
 =?us-ascii?Q?/mqCku7/N62cNlTGP8lC0qhsuELac/BdfJKgB4+7OpKbn3/X8p26aRBmo1fa?=
 =?us-ascii?Q?wUwBomgeX2VUujjLN3UTBiqym50jDtOcIuD5wfefIypVNhl9qvW1EM/BKLkd?=
 =?us-ascii?Q?ADiGzHfe6Ga85A/Xd9grcpraU4cnDuQ+l6tyNhm6jtECHlFcQN86RhH9L0N6?=
 =?us-ascii?Q?+0dMewrBNHWFaJY8YoyGrbT9+rpoHhvmcepjwj86jr5gx1ZmOqEelICe+4t/?=
 =?us-ascii?Q?hB/5vl6DmDEE3/T2dPfJTQEGjscsiBYsoX4NGRxApstct4+OQlSLTUNHYoPC?=
 =?us-ascii?Q?Z7B+cFG92zHJqWQU+7Mioen9YDoSuTAO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R/LW5nOcVSopit40LWumF8myk2mDbYrP6k5rqMdHQPvgZj+jk5QVd0uBY3XJ?=
 =?us-ascii?Q?4k/KzguzqH9Io4d4PhVGxiVQGmd1Mt05VdAqhLG28Ch1+KwX+OyVFlXzA0ZZ?=
 =?us-ascii?Q?Z+oJzoXLxkRie+pxo6FPaFUqU/PWLcaxqw2XElHFGHLBjoXOLa/+SHkUk4Bt?=
 =?us-ascii?Q?qyFf+vUC3zbR3kn44rYU84kTFhrlElQ+eYhooX7w4Rx0i20xfJaZlUHC/1Fs?=
 =?us-ascii?Q?3xq93JpIeMUV921kz5OF3xSFaQ4cH6oC9mXo2Disycuwe/wtVpL5X5BNo0Y1?=
 =?us-ascii?Q?JEzPBt6gpzTBrZ0FJXClgGCMjoGvLXXHnBlpKTX4lqnkn4gpr54kslp7JyMi?=
 =?us-ascii?Q?eiW3i8o2gVcTWjMOW2D4cOZeBNq5E58qzSXS60n+IpQYD+hemKOoiAEX64kK?=
 =?us-ascii?Q?LsQty2ARhThlrAAP2aTRUskowC7j5JcqsRD3pp0i0VzYbY5A6H4TFuMV89I0?=
 =?us-ascii?Q?lcwyD3dYnBFXtoaEnulLgO/I7TTydpEBgvMKTUR3QuJcQ3duohMtD/roYUet?=
 =?us-ascii?Q?50MTYxsAy/RvwtF4Lk+pZHPFAqkHRuhN2TKWi9Ve5g2Mv7GjhkRXkL5yJWo4?=
 =?us-ascii?Q?TQWY9onBx16Xa/xICjbrUXvS4HJOBV62q0eA9qYpGUrfmOhGnS/p4G9Tzbev?=
 =?us-ascii?Q?frAaSqJzGs3fx4elOGHOignWUTVhecOHW6XpXAaPP7aK2PIEFJL1zjTOlwWR?=
 =?us-ascii?Q?dAiG+V3YkESPQ29ltwAcfIoQRF8d/i4/a3N4e/xWET+zmygkAqCZ+r0dG5q5?=
 =?us-ascii?Q?BWaEVi1MlUIPmOec9Wyiu6/cRZPN0e0vNgcCimBIoFN7MZtJH4t1tIE/OWFI?=
 =?us-ascii?Q?RKj1SFMwLruFpHlpAeS7P+fqkvnyp8HX5R0pixUvAxKAeWE/Y9G4wEsX01UH?=
 =?us-ascii?Q?d+F2GxCjDTCB8Mrk2rqTb8sqsZ3W4O0cdmBD91rRbrxbMO1EOTnCIrZ83Vun?=
 =?us-ascii?Q?GxE1+2+HpAKMDRqM1X933pBvKeWmOAqReGMfKl0Q9HUq2c3JxRNU1I3tvqdg?=
 =?us-ascii?Q?UAjOyYdneXJmHMfyPLuRTHsnQQiFBwX1RSEmCugIdVEz2iTuzvBOxAsDFE94?=
 =?us-ascii?Q?awAIjTxeZ2tuVVdniq2UUXgyJqR69ftaNVSVaVLecJ6ZGYXKbeDzXynKm9qi?=
 =?us-ascii?Q?B8vrFhWqWs/9GITeYNHctdH/gGEJEZdFLcrLgInuWu0RuC4/zjUBP4Jhm+Fo?=
 =?us-ascii?Q?7TQGvrcZuk+DWQIakBe/bQp505OnCES0h+jEoYzNt4aPrVlTi5a6WyKhqHdF?=
 =?us-ascii?Q?RAHR5ij+DZOgVf5uXhhc1wTH4PFferEC+cjUXX+52BR74FHeSGEK/9bgFTYW?=
 =?us-ascii?Q?nWq1Q5u/w0hkebMSrzDk5HR9Rn5MU0kNr49XwB0+gfiKpZQ0nqFoCWOHrJOC?=
 =?us-ascii?Q?H0gCj01FjRIIzeghNAA237Cn6/IO/qa77fRhitIOjWVD6GdnV4eH0QQprcX7?=
 =?us-ascii?Q?IA1NmuBwfK4HS4eHWJWhx3137kNU9TMXInmoCkGWs4PMJV+0UOHzFIM4Mk1u?=
 =?us-ascii?Q?QTvG5LUu4yoFtkHq1vwVaCBN98E/qwuqa2gvBIuepU8BRV51FayOWk1+PhKJ?=
 =?us-ascii?Q?9MG19oIsXCo01pufBTHoAE6qRQyH5pvGTVUttU/CJTfCIAX9Z6bS2NKfaaYK?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a9865-bb03-43df-ef4b-08de0cb894d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:33:24.6471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BssJHoQEJddzygzKHzf1FyDJ4YJ3UWQF+MjNoIyPPXCFWHv8o3SftxeYZgKK19zmsTVLqlcYau8h76Q8281iQu94sqUioVDW7TxpkDBbq3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
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

On Wed, Oct 15, 2025 at 10:07:16AM +0000, Ciara Loftus wrote:
> This series contains a number of fixes and improvements to the logic
> concerned with selecting an rx path in the intel drivers.
> 
> Patch 1 fixes incorrect behaviour in the ci_rxq_vec_capable function
> which would disqualify rxqs that have the timestamp offload enabled from
> selecting vector paths. This was incorrect because iavf vector paths
> support timestamp offload.
> 
> Patch 2 removes a reduntant check from the ci_rxq_vec_capable function
> that disqualifies rxqs that have the buffer split offload enabled from
> selecting vector paths. This check is performed during the common rx
> path selection for three of the drivers and during dev_configure for the
> fourth, so the check in ci_rxq_vec_capable is unneeded. Although it is
> similar this patch was kept separate from patch 1 because it is only
> relevant after the three aformention drivers adopted the common rx path
> selection infrastructure, whereas patch 1 is a fix for an issue that
> existed prior to that.
> 
> Patches 3 and 4 make fixes to the iavf rx path definitions, ensuring the
> correct offloads and features are defined for all paths.
> 
> The final three patches reformat the arrays in the i40e iavf and ice
> drivers that hold information for each Rx path that are used in the
> common selection process, in an attempt to improve readability.
> 
> v2:
> * Added a new patch (2) that removes the reduntant check for the buffer
> split offload in the common function.
> * Removed the useless defines IAVF_RX_NO_OFFLOADS and ICE_RX_NO_OFFLOADS
> * Use a newline for closing braces in the rx path infos arrays
> * Let a simd width of zero represent scalar paths instead of 64 which
> lessens the number of fields that need to be initialised for scalar path
> definitions
> 
> Ciara Loftus (7):
>   net/intel: fix Rx vector capability detection
>   net/intel: remove redundant Rx offload check
>   net/iavf: fix Rx paths feature definitions
>   net/iavf: fix Rx path selection for scalar flex bulk alloc
>   net/iavf: reformat the Rx path infos array
>   net/i40e: reformat the Rx path infos array
>   net/ice: reformat the Rx path infos array
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel, but with patches 1 & 2 squashed into one. I
don't think that we need two patches to remove the conditional, it's a
basic enough change to do in one.

Thanks,
/Bruce
