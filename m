Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED1FE81A48
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBADD402C5;
	Mon, 16 Feb 2026 17:59:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4B06C40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261153; x=1802797153;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Bd92comyAkgxmbtjR0reK+BsAzsrAnP/ZwrxL7SWMlI=;
 b=Phzit6lMQ/wv0Ls6F/vNzwhGYcZTlMtOmTacxaKeW1lZHo44ZJr2a+kK
 Z1IIfIw18hN3OiARMUfOUXO69hHpoCqeEO5C7Tc+HHVkrIW5/X6VEQcmC
 +FbMKFsNz+KdpQTqq8Zc5SEVUrR1FTyqb5aGA3yD2IxsDo7jfpg2DkOyQ
 wcuUlnMx6p271DtZZDCdymGSkV68Us7z0wzuk8zXpAg/QHPUa97lGs8VR
 v7Vg6jx+2QtdnrYhdZWFuGvoMlhtaHHyAljyerTp6NvMfUVLsR8xgl/K+
 5yb0bOxOt0FZcyCU6dcJeJVMdJJQU2nwxalut1pRbXclGyX3CrFxkdu40 Q==;
X-CSE-ConnectionGUID: 1w/hcDQ/Stqk4jqV23roGw==
X-CSE-MsgGUID: xZ8Bvik4TuWyF7QSbO6Azg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72242771"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72242771"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 08:59:11 -0800
X-CSE-ConnectionGUID: gFtDKVlqQQ+19+4onbOBLQ==
X-CSE-MsgGUID: nctkGVTaRQOGt5344cXbpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212198315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 08:59:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 08:59:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 08:59:10 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 08:59:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHX3jZr2rTDKpX3Q3KlZ8Q7lFjDlqn/MlyefJ/srSEX3kblIY3/Bit7WPek4xdPGvBfv4Pd86avPu0jiifkRpglEQiHt3yVRGUCVsqPvsJV/VLOOqNvWaRIRFW7od8Ra3FL8TWv1dr1ijzLCdJ5FPMMtKr2cKJIYFYCYg1ORWsRG4uXuoDdNkob6qaLIUFpJXEqqKx3vaD8zw9pWu6K4el9P68omVlm3DOXrr3J8zCgJiKK/QiPw9nQDoowDLsMbg4h4nAa9xofAUgM6TVHd4yi9gjC5B7sFym0tw/IRNHyjVajI+GD/L1Vs/zpHRzobIa0gTCl62XelBdr7fpEIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gc9C6krQkno1mBY0ojAp+akoCzkGU0Z3CO1Ubjidpk=;
 b=agroHagzN5mgU9Kxn0IzaidnQAaJOAZr4HKJKElntFcjaxKs+jJ4O1Yk6bv3lT6ski0YOu9jJdNd8S21zq4hhxZYKCcxiH+Yqj+/JrDWks91mNNgD2o8I+Ft1ZnSIRFols19sCO8t0igZs7kntBIVefpWMw33OVaUBqfYOyapfhPO5YtIrIvxcM6uhaS1GbSeRJrFB+z7AyiCrw5rApl79Q2yRzWYqdqusEqt6t1Cwz9APjEydOvlwRgBQMWC8XjZYyJIi+OmQPDAak4/epddX21u24VE/g8HVxfo7QpU2Sx3wWxAFlZUjFHUWleFziu6A8F7Fr069QxjgIBiDf6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7261.namprd11.prod.outlook.com (2603:10b6:8:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:58:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:58:56 +0000
Date: Mon, 16 Feb 2026 16:58:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
Message-ID: <aZNMy_1oOKYn-AZ2@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f5261bc3-7078-4a99-b11e-08de6d7cabe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+M+1zy8+oORRsfmpB9nNxpy8/84LXyklzky3wNZOqoOFWHAsQ5hXxj3CpOy?=
 =?us-ascii?Q?RVznaLdRvFae5TeGIjrxfkCbU/GAAeIGSyu1wdRD39aZQnTKWSkBnBGY8VsP?=
 =?us-ascii?Q?9Ue8iQQhPtxs6W5MaePjazVXGUM3izZclGDcJ8RW9dCt7piyVGsdatVFafWP?=
 =?us-ascii?Q?0SZvYG1jOI3lNphEg5IfMfbZ3PvwyebRVXw0U5GQkAR0tVXgBKlfM1g0CWQv?=
 =?us-ascii?Q?MFcstYKxvXwYFi2CCfOXkakT9p4ea+9mg/LwReE3F9sOheUXxqPOlq2Ep5i+?=
 =?us-ascii?Q?BfcnxFCp8z89doKwysEm7/Qo4d5x+TwTvb10jecR79d0syEVQWm9LPniYOdU?=
 =?us-ascii?Q?Vl0nXTJ5LsSOvDnvpjKpNF4bVEdnvjibY5NwuQ5VgT6MtXy4/O7Fr48NN3BE?=
 =?us-ascii?Q?ZOW6hyc7mlhprlXnzmR06pETZ1VvQOYImQBy9FrH1/UlypiPPZPuy3Hewz+z?=
 =?us-ascii?Q?IP2CZjQd8/SJR6kDHy03n3c7SAw5MUlSGD/ATC2s9uQR1RO6XmDzIIaj9ovQ?=
 =?us-ascii?Q?6xmHsx3loqEUPdbNrAe8apeXqYDnE4uiUT+eNu58JP/P3GZ8HYh7dRDG1Ayg?=
 =?us-ascii?Q?LhtQzb3kOpEMQ42ddSgzXHwX7YApVgf9AqB1NJ2s0oyTNFhX9pL3mceajDkJ?=
 =?us-ascii?Q?3Cl6IQlyiZJat/j/tYNCmhd+TLiJlQquz0ZUZSKdVKlF0ec06MRExJ38+Kd8?=
 =?us-ascii?Q?fKbpeuDKBPyNfOKl+XZ3B4f6IbDAVZdPJs9+sb7nEfPR14Drb/HA/1B507l6?=
 =?us-ascii?Q?KNvABiQs4IS9mGJe1jgaTGABVlIG7sZalfzCF7P6BEJhAPHBD5bbpMWeWMM9?=
 =?us-ascii?Q?EbQoJsfB1RT9Wetxg2WDv05rWtninbaI/7xLZY1OaNR/qbjljXigc4R/Vmkc?=
 =?us-ascii?Q?a4VpczAr0l+Kt23/l8wflzWnncpj2YQ20uNyglKDK6Jg2lFaXECLP7MaCWPT?=
 =?us-ascii?Q?R4+3vd1s2Jh/Bj1x3cCWGFVdDjPzoDldMmUlwgjI6uKe0f8ZExlvY882BXQc?=
 =?us-ascii?Q?1Zp0Ji85C75SkXPX2tuEUPsFTizQDMadT6ZU2hYmkF8RopMPK4+3y2U1tleC?=
 =?us-ascii?Q?owCBfNdU7oMS1IW+s0wp3dy4zTfb6FS1Aiq8YMyIMHE5Bz1c3Lm+CyPKA543?=
 =?us-ascii?Q?W212Yo/r2TniqFMPoAhiHdgrcL/SfZ9oyqYLlrJ0wrES3NZDpZ/Aem2lkOau?=
 =?us-ascii?Q?OU7xAQo+oBtyvFGN57RJvLpEPqzR6jKDmZJBH+2pHjYu1CQU0wJzldhi1aBz?=
 =?us-ascii?Q?27WYdRMHodZdckxYhPdz28ctDDScFJSSVC0mLcWZJB21aBBdq4vlV8yBfSNh?=
 =?us-ascii?Q?yLKP7YK9jNiM1FjmNlaJZ0vGXjuP3fo78H1A1Nj5SoRHz171OUrV6J5mU7Y4?=
 =?us-ascii?Q?dOQ7Nh/PjtOcpazcC4N1vfn2fWw+xTEbfqQvssnBMUzcH4ZWBPNmRP1CwUVi?=
 =?us-ascii?Q?2A09GeeC8MLupCH3KIlis9ha7ee4dPvT9gvW4hVoliuGtkDyjhYiaRqyqA4N?=
 =?us-ascii?Q?X+/+KP3bjXM8tBloCOU42wQBf4y98N+gb09nBFSjqW56NXEhNkh5Hpg6weOt?=
 =?us-ascii?Q?PDNeBamw2iVTym609HM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VaKy1kBqBBf4xqrJ+V9BQJSmdDHtV7CCCaqWeTgUWDPW+kl1fr3qDdo/5YC0?=
 =?us-ascii?Q?7hqFoIfBsybvBLd9qmDLj/BW2g57KaE+Bd+29ApPWZU9e3T0WhsD7SmzxFVP?=
 =?us-ascii?Q?vGDOw/aa+GiFHZ+od4qjhc0AyK4LXKU1PWopj73Lk5uaTM89FnURxoyp8ABl?=
 =?us-ascii?Q?A/ZniWfIVTE0LnNYLSRf6ijtM8M2trJB3J45q05MiEtd+Je69zkk2UJsM2gG?=
 =?us-ascii?Q?Gdx7pJdxqDIaBdtcB7rQ/WEnK6VbnTxgf/sXq4AyvOIzUW01ZOBPLm3uDvNU?=
 =?us-ascii?Q?78ThaNJ7SWAvqbqU3iN3yjiuOjWDyUkaOfUVhyzw6u45FDECLrYF7CvJC+Vg?=
 =?us-ascii?Q?ud2J6DQ4PDfyYaONIWUKCbZ/eLIW63MxZMoYnblYstXU0iXtNNokm/XATT+5?=
 =?us-ascii?Q?daFHD452hM4txZh09WAE4vwd4SS6rbmZcPFHl0wmaGCjKHLx7Bbd7dUk2OA5?=
 =?us-ascii?Q?hNTatsxIfGVrR4uOWd493PLC8xp+WCiW27l2dTNCOlSjLvBlLvoRFBK0o5Vm?=
 =?us-ascii?Q?fXVZwwbB07b0EtVc3sDtaeNTqBzovfWgEQbimpsZ24OX+fTM7fmkLLDwEm/E?=
 =?us-ascii?Q?zAyw7lvF7TS1Ui+l834mZ158ETvSeJmkxEnZ3SQHN+u5Qz6cCLdM0IYzzdsW?=
 =?us-ascii?Q?F3imOJWv8V3D4UfuWag6JQ75SpzXdhT0fvdHXqUjC/9556Cfoxt/PYeO5pMB?=
 =?us-ascii?Q?RuMSm1hXpp5TVqoUkEAtzuezeI8vIg7tjyA7O2VHico3duf1ekcI8auq0SDN?=
 =?us-ascii?Q?ZXYbL9OFgiX3vRNzaqnQRhN3/7deIjawe4Eljr1TVWhiVESrw7UeP7mbK2tg?=
 =?us-ascii?Q?KDKqrHUFmmjqLmz4sryZqfDjO6I1QGGRmPiHRGSHXD6aX6JaMGEX3S7pMlSx?=
 =?us-ascii?Q?ybbmo6SWFmrn6upvj3kdI/Emj67/QvJ1N2Zno4YQugTJgu0eTgS4ZRstG/4f?=
 =?us-ascii?Q?ppF5SPmG6irJ1/B69ydnzFj2oYmVr8hz1REzUEGA+iA4CjyjzikdA2yuk2iy?=
 =?us-ascii?Q?9BmaMvRiYwt50I/J5NNLxLHB/7qPO1AsTB3AIyn5y0aa1Uh6vqDi2+gEkKsU?=
 =?us-ascii?Q?hKSuHmlaIHhuJD7Ld4UzgBM6pv7TgzX1OEZs7OJIiEu8scOqNtraRbrIRBcP?=
 =?us-ascii?Q?S5Czp+uNzU4H2yJ8TJicP4Pv60NiLghZ6Y9LUq5PU4XR6Oe52IDfHh/MrbiZ?=
 =?us-ascii?Q?XvVyRk3fiLmGO+R01HqzH4DrgTEnw+znXAzFveBG+FsYi2+Eoj+/ORTVQXP3?=
 =?us-ascii?Q?z1UkeJ9vuY7+XFXfonVialmLtUYnzl4sgDbKGlbV1HpIvRLI8xP5HvP5V/1g?=
 =?us-ascii?Q?h9DfAfanZ/gZsZRQFOnHLRxVobhelyacm+OfD0254VndvNU6mWwLCc8er7yB?=
 =?us-ascii?Q?Y+6nnGObYCVhCvE1AKV6xR2SIu2vEP6PiV9/ehiZ7LqrVAlCZwUCJFTV4YGi?=
 =?us-ascii?Q?TtIjAQXWxqiLyHmcGwbaVSUD/GdbBAGugiHM/sLwTvSiEDRtRJmm+Rvpfd13?=
 =?us-ascii?Q?ljwz5rQ5NTesP7RLsIHhX22sJn+gGcaevs3F1poNGTL6jZ+b5hSiGKaAMUZy?=
 =?us-ascii?Q?qiktopf0rkA46avgRrBo1B8iGI39Gpb5QPryV4ZJQQalorizeiDWkyXvUtzg?=
 =?us-ascii?Q?Kei/TEdHZJnoU77kDX0weMsP8UlmJ/MLmqe/mQ0x7fadCqvaF4V51SpIa1wa?=
 =?us-ascii?Q?ZyBusWBPePzP5cIZLJu2s/TMkcTfsaWQ3BCSebQAP2qIZqFlKJhfV+97EX+m?=
 =?us-ascii?Q?LOPO8PX18GEm5dydoj06k+xf2t1tN4I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5261bc3-7078-4a99-b11e-08de6d7cabe8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:58:56.2907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixnLPRT4aFMIdYR3FbueEGDTThz8rBRTmLhwGKSuw+IY0gD5W4jwrf8yd0zEf3RSFZIWP0Muj8mo2HKJIEIg+xnV8oBeNRy1JNf5MswpPPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7261
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

On Fri, Feb 13, 2026 at 10:26:12AM +0000, Anatoly Burakov wrote:
> The macros used were not informative and did not add any value beyond code
> golf, so remove them and make MAC type checks explicit.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
>  drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> index 5dbd659941..7dc02a472b 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> @@ -137,18 +137,6 @@
>  #define IXGBE_MAX_FDIR_FILTER_NUM       (1024 * 32)
>  #define IXGBE_MAX_L2_TN_FILTER_NUM      128
>  
> -#define MAC_TYPE_FILTER_SUP_EXT(type)    do {\
> -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540)\
> -		return -ENOTSUP;\
> -} while (0)
> -
> -#define MAC_TYPE_FILTER_SUP(type)    do {\
> -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
> -		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
> -		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
> -		return -ENOTSUP;\
> -} while (0)
> -

Ack for removing the former. For the latter, since the list is longer and
the code is used twice, I'd be tempted to convert to an inline function
taking in struct hw and returning type bool. WDYT?

