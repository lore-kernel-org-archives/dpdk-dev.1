Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B1C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 17:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C63A402A0;
	Tue, 27 May 2025 19:06:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 745614028D
 for <dev@dpdk.org>; Tue, 27 May 2025 19:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748365605; x=1779901605;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hpFMvByOXgnRCWxPmA6z47cdInjfo0hBivhhbukvMI4=;
 b=XR8/2moIj5i18bMxju17gIZyjwNjAwygxchCz+/9etWqKBpxk8J+WwVJ
 eNnKMANK8A6u5glDzogg7YheK5KUHIfkErgUjeBkNRRtybWOKoXF47qo4
 vYdxtP1cVdzOFHEC4hu4b/ohYRLLOsMvguNJJO8dtgq0Oz3vp5XWMCwvq
 NnbYhD8qGvWF9zXkb9Bkv1iPhEK9ft+b+yR8mD3Uiqfq5Z7WYuLsr1erj
 SX58UaBfqEkImNTJ4/SJLgcAtZVSDUyHORYFwO6qKjVc7NfJe2hgp9e3t
 9qgw0s2/mwvlg35dZma4NYQyecG2posk0AAT2tokGxdrLBU7b7W5L53XA g==;
X-CSE-ConnectionGUID: xZDqJ3cPTiepqLhN93NVag==
X-CSE-MsgGUID: QgRq398OQZmq1nTCQkTqVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50251218"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50251218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 10:06:43 -0700
X-CSE-ConnectionGUID: g0Dymo2qRSuaIo1UrlZQRg==
X-CSE-MsgGUID: ajA0feILQWSgNshpoXagmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="142733746"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 10:06:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 10:06:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 10:06:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 10:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBXudsa8mwibSbEV96YDGydbY9Lq6UQhRYcQWXij8W6NR6wOryufhFJKGV8XDzY6Tued5BgybQxxf686VWCjfusNcfNguPOFi4+TheJ6lurchH+eiltpUMtIMVHlWmp3oGw0osIwo5WftJg1DaA0Zpl4Ag4VGAQxzGgOoLxjOnAR4KwB7YoJr3yoGQ3zoEmfW849KRl3ktJCZ2i94+8m5Okays5piUr7ahze5imTflb5xyPd4NP5owKRTgH5bDk/7LTfNpU7nDmkl/6iyUZSE1SaWh43VcQYcl2FxAzb88j8jGA1K+LG9mgiYba+VeU+HqErjwEkx+ggoZa57olJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ2jex8+wj2GJunDf/dmEoMK5rEcwbpf8OaE9T/8x9M=;
 b=TogKsBf4W2NZEVc3AANpy7V2LfoP6+vkFE9o1CAx32ygSw+mNLtXvpeIILSLrv0cR0YSSCp/7QhJ8RLEZiu3i6+yrJPKtsMfr/U8y5MC9A4DC2iI269c+ywHFqh06oSeBML7b+02mqPFu6njdLimvpDXSjExHdYaifIVDGtGK1rQpMr+oUMJa+PIOzXeqdLju5AD87Itvow9LGI5nDHlPkKqUmXcHUETV2pb5KWY1edA+6bw0plT8RxJkQAWmTBwyfggcnBMxUkD7SQ3k8Lho+1bZsW0XQFVI+SwiJD6Y2nzFpdHyvrnf0ym41dwEYtiFYeNkwb1VInFjZpPBMikzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 17:06:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 17:06:39 +0000
Date: Tue, 27 May 2025 18:06:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 03/10] net/ice/base: fix integer overflow issue
Message-ID: <aDXxGtdAfB5GrHx3@bricha3-mobl1.ger.corp.intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-4-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527131741.7606-4-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DUZPR01CA0202.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdb0bde-3593-45dd-84fd-08dd9d40d846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6OPUnSyU5TZCLnl0a7r2OY2rh4XKkh0m0aoyTqxtwAv5g3OWaXONK1tlkWSh?=
 =?us-ascii?Q?Gx0jzh46y11nJ0XH+xcmiAKs/OAoM+Zr82ILRDcagMX2Z5RE2/j9rAkUKSW0?=
 =?us-ascii?Q?5S53ffHluiW/ig88dUWsEg0x/AZVdy8VSBuJ/n+G2JYNbQJuTGpBsJnP7uLI?=
 =?us-ascii?Q?y93AFxD/2/NvyIFO+Me+sHV2cJSx2kH3HPB67RN/bodovpN3yQ9edws+dosw?=
 =?us-ascii?Q?lXEMcLd7bV6SWQYXk440a5zoqB5mrIvoSnpDV1cirTfwaeDjHWAIBaQRrTha?=
 =?us-ascii?Q?AFrYpdSulkui4Tg2w1ghABAA59tubUyI4QQaUf2KQ6jBTOthdmGyzEzA25qi?=
 =?us-ascii?Q?J8VgYSn1Fe6bHVYx4As8FYt+dEbg3+5E/7nwk8NrZkeKGFi/IINTcQ/boSUy?=
 =?us-ascii?Q?RWI8Ymjmf+qtog2kVFaAC6FInldL9+a8AlyjUKM7RqI9MuC0fLcqqh338dfE?=
 =?us-ascii?Q?ZzTbjoHb/1/XF+OcUSx2jtYdukYSXxyqh0XsCWugA629sCoc29hcfCdfKEmO?=
 =?us-ascii?Q?E838ETD2VcE6M8BI9C0iJuZFYTN5D102G6dVzu47TqLS8CUMvAoU1xLqJzT8?=
 =?us-ascii?Q?xCDNhxJyY7hnW6PaYYXmIt6N41PTglzYVHZQwZkLdPxgHvPfy3YCShe+1tFi?=
 =?us-ascii?Q?o9aGmddiPNdAsZie/4iZSOXW92XwNCMWhrZ7CC4+dD3/CwOkEeqkFu6qSHaE?=
 =?us-ascii?Q?tKqSTpa05JPh0NZ3qMeRYWJSjKmWEKiivE74uvjglEwh/gJGUcBsiOgL2tRI?=
 =?us-ascii?Q?C6sNiBeWX7I3UVKpQsmY4r3fx9e7cAMT93ZkK66TPewDQc552wCxWM5LA/Pc?=
 =?us-ascii?Q?/UlqNB4sa/v+8oi0zQpaK8KFBg22Gplqgre0I5L0y2i7vbnh6UG6Ea+kZP6p?=
 =?us-ascii?Q?HYkmeFQDdENYjbj7woNErd4dt5Vn6dMfLMBKTjF4JTwZVeMsrpWo7WoaXRzc?=
 =?us-ascii?Q?7YlmvZ92p0jILX/BY6in50Ii7PTtAIcgkKma+XcpkqcDt/HTZcR4Jxh+e9GN?=
 =?us-ascii?Q?Y3JTkvC2oM/Wi333R34Nvr4c/dp1Zf6/Aisa/kCX+6aKab3nXKMlOlojOt6W?=
 =?us-ascii?Q?oASRtwlOj4g2270s9MjWoYGl8ytJ3vrGrPFa21lUqg9rkz1TOauHJI9S8Buh?=
 =?us-ascii?Q?HZaOX7U8nxovYgJz2SPjEin1DB4PsL0a8AlCLQzCWLwCQ1ACqdr2R/97GIUW?=
 =?us-ascii?Q?csAE/ULQeFsBJaHn/8Vs5VqrYxFY4UiweX9i2vq7ogPu9qwkMU0HlpNShfjB?=
 =?us-ascii?Q?/iQguom82KrLLyBMFCUrt6a9xq4aqNCtXdJcMv0JYVbyKG5MTanGtoODZxHF?=
 =?us-ascii?Q?+LMIg36zgaVXdK8ae+d11+xqQFUfQY+OGtmbe38LQAvRnhTVsGVUFtpmIaTh?=
 =?us-ascii?Q?llE00nIK01a7paWpARj4UeqoxNUPlCP+IdnpY3LMDKmyYA+vSDgp3l12W01x?=
 =?us-ascii?Q?+O+Io9elHA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qz1Lm6oEk4FlDAhDTnWXWma/Mxwg+2LFCcegVqspjF8/ftOf/ez7YoQUmkfu?=
 =?us-ascii?Q?YlJXJvJUhtU+6m53FUIMj0UYRw2+UiMdKa5JsKOoYtT+gyJaGXd7KOzrD8Tl?=
 =?us-ascii?Q?xGFzYIZdNan2+PcyJ/hrjR/4Idk7hoe3iKdYkjHvkvU19FEdmRl8K+43y1VT?=
 =?us-ascii?Q?0ps8gA6tJAOczZIwY9ebHz5BDzOo8PpSe7QsacuJf68bmiQUIklbL9Ixz6Ry?=
 =?us-ascii?Q?vinsDYVRMBAa8y/513IEGQ+9PTPnyimsFqx79qvNMDIEnXOFcyJQgWqyjvCY?=
 =?us-ascii?Q?Wu7ioDZa2D+3R9XcgZiIfGRl6geOHxu+WA4EvocgmxubsOar2XjbjkB7qjAd?=
 =?us-ascii?Q?4hD6rX7B0nqW06x8p3w6ZYua/3SGQv1WYVZrhRBcCEGh6TzzlsNDPTn+7vwj?=
 =?us-ascii?Q?rJLcBS7fy+J19BssyP5IR5/DLaFwYY4TOhzO6ZMySEHHgPbU2IFugdj5Pnhn?=
 =?us-ascii?Q?Pv7ePtzKHibsWDOpn5V+NKZCxn/E9iZZtzu8oW8bVHGwVuZ7+NBQTNp3BaNm?=
 =?us-ascii?Q?+BdVnUXyXVDX4YCzEPp7vCftlggxO5PnNMfSrYGVNzFhhNc7GS4LSHcUraL3?=
 =?us-ascii?Q?g0zkGiVzEhl+ZLxjgsskMADEuyLheXE6FT8Ftue+ULzrcbNB2GhQC6HqHJqA?=
 =?us-ascii?Q?VK81rebB7vgI/QRjVDwf+WgVOMcfjQpYSh44i986KH3RQag0y9ypbnn2pIfy?=
 =?us-ascii?Q?hSSEaUa+2r9PZ0XkWUW5UxMT6h6xLtA8uxEz1rI62bU3nmEtQeKfUtTlrXjL?=
 =?us-ascii?Q?CKhrdDPVnkEXFtg1GhDCI/OXQp3dhLgk56SQbXuG3rHtG2ZBLgQHJscK/yjd?=
 =?us-ascii?Q?4b/umbZ1UDFHunzdT3fvhGpP8yIPh5kxff2NZPiZHDnIp1mI13z5TtW+aATG?=
 =?us-ascii?Q?BbzAFixz+FtrlN1RNbWCYNW3zKln3xuMf44yfemhkHCatQZ8o4NWX4XqRtuN?=
 =?us-ascii?Q?2d/TPru6PoZa+RTyUrwcFM8AesP3oPSKuPdSxVlOCDcKPonvX7UgfWem3d+B?=
 =?us-ascii?Q?k8hzOtol6u2eXeWyLYeGoBUB05ZabLrBJkwFxZ7IJ5OoT5WLq4k5uj0t023M?=
 =?us-ascii?Q?45fevF9ljKKpVBWl1d1CmmaQ55XSqHhml5eZ2grlw/OM6LAK7kORsktzz3mb?=
 =?us-ascii?Q?w2T4q+ldf12BM9BYd496RQ7n/6JIYFB7mrSkMJPJY2efGvbfdL/bT8KmZrfg?=
 =?us-ascii?Q?qvU1mzEQxweR4Zcu6reXGN8sbQAhIMQhThZE/Tn8vtYWtfQgZCS73HwIB1Ox?=
 =?us-ascii?Q?f5ESWLdY5fVwmaUmuwfbc+2eQ0fx1V/3ua4SYASGoa0LMdDd8KaS5hwFEXSP?=
 =?us-ascii?Q?EAQY8dauguj4Tb12xiUzdZQZhT7rNuRJuDVXZM5JNyplWjt0WKEpVIlI4zbJ?=
 =?us-ascii?Q?B0ci1PWK6WGkXDIxdwv8CQVlEuNIAhTFT/hmiaKu0pQim1YRQDiU+hFM6E2P?=
 =?us-ascii?Q?8nsTyd/SWnbgwIGHNOm2br8H6xLNo94U/rnvDqqTzg2Q3kCCyxiALYTtncse?=
 =?us-ascii?Q?eAVPYcpGG6zWkXorg6wsr99GljR8ODva+dPAvkqxOLw4VLMPPEpyRByviNRX?=
 =?us-ascii?Q?3J1OEN57HEb4KvScqWJOyhvHcurOEVX2CbvL8xLH+pjBDvoWYFEeckjevWOg?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdb0bde-3593-45dd-84fd-08dd9d40d846
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 17:06:39.0732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgn4s9qOnwG5CeD+Z3pVevGOVqxM+oXe0GV9mqdPVCiEH3gQOcEcbW8EW66d2YDFAS5N/8FWXmYt16kdM1GJ6NqlfLbXm1DN2blTMsmqFBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
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

On Tue, May 27, 2025 at 01:17:22PM +0000, Dhanya Pillai wrote:
> From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> 
> Fix issue related to INTEGER_OVERFLOW.
> 
> Fixes: f636f2888cec ("net/ice/base: move and add some help function and macros")

Minor nit, that commit just moves the function about, but does not
introduce the code being fixed here. Instead it's older commit we need to
reference:

Fixes: aa1cd410fa64 ("net/ice/base: add flow module")


> Cc: stable@dpdk.org
> Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
> index 297a5ea890..ae3b944d6e 100644
> --- a/drivers/net/intel/ice/base/ice_type.h
> +++ b/drivers/net/intel/ice/base/ice_type.h
> @@ -25,7 +25,7 @@
>   */
>  static inline bool ice_is_pow2(u64 val)
>  {
> -	return (val && !(val & (val - 1)));
> +	return val != 0 && (val & (val - 1)) == 0;
>  }
>  
>  /**
> -- 
> 2.43.0
> 
