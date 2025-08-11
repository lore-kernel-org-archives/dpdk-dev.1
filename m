Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAEFC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D4540649;
	Mon, 11 Aug 2025 12:47:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8B245400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754909232; x=1786445232;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tsm9X8+D9e0Rgwt06t2nh+ILO8WDJEeh+TzoyJ2HaAE=;
 b=TOEY22dhDU4zplIPPWbRdrNkbnfCp69iw/q4efEphsoQhuOeGdotjcu3
 RJ2kqnLoGQtMrK8AsW2r8wkL82JWMeZPUSbTnHkLgSmacKgnNMKQLQlD2
 dJ/0+PE9/G7VQIGxeGBiVgvSYWTwH0MlfdLX59oFO/WsiAuUxMNhg7/yd
 SHNIUFZRpB5DfP6xLiBSRCslhYF8EXDzxbB26qMrb3BYV98nAkcRqWASs
 AVH5gJgFkBPj0IIcDQBJtqGVijGPjIGz6Pn+NfPe+MTCNATOA+CVDArtQ
 jB/POpXSgTDJxpZ6Me/jwJUmQ6g462maKw8Ft+ZpeqronZUXKii0cEw9a A==;
X-CSE-ConnectionGUID: iIQumvp6QFuDG4iffMRpVg==
X-CSE-MsgGUID: CroA0PqITdmolQkgiZZHLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57079094"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57079094"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:47:10 -0700
X-CSE-ConnectionGUID: 8eRuqorOQnCimaA/GonrfQ==
X-CSE-MsgGUID: hINMGwDiS1CvaXbqEChXPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="165376179"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:47:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:47:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 03:47:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8/rxnhUQMbYTub4E/99KM3D6mIpk4LeYVYzESMbpozUTd34rDnkZp9Dnh5gFU358TvKosaa3H7JZOH0VafAG9VQF1kUqkZq70a5AADVuvqslPLgV+W4V9nr1u0miLpPk1tRRzIvOUhhAKBnm5D92qMG3spJXWpYj/AwpgOz2AmUcaJzdU/qoW6rrwfgkrXGAiaiWDjetzmOnxHknvwJAMLlZYKln4GJKSaTVu+5D5vwK6K+YOgOfhRvW5BxSe+uzTACTYliRuMC7bZ4bJ1PXNOg7WqH4NS0xFEGBfwNxh+BV6DVHpwWEJV6SOx8W/4y16glPoK34dj8pto3BGiVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzlU5TEoqwOgBBnCB+BON027eC+zLO8pH2GlEAkaTTE=;
 b=JITb+lIaQsAvcLX4e40NOPvEERySbpAbxklLITLEyZVTqslavaswbbB3Je+kQVD6MZuLH313ix7lihFngFe52b2l2uKWzR7eIbr48q7cn9fputbSzFW91TZzk/i2nv7N3EhRlVMdsZQSerSbok3HV2X4P4nRTycpr7tF6y/9wBomtqhPoi4IdmKkT5yxnIsmhAidq6jzRxhRC0SNdp7hvoOFAAHBIF7aCvYi1vnoEMwCjdB8ZEzTXp/IQwEId/fFF3sjs2rHlBT7sXgXrIjJId9OI+WlrKiaPnDF8/kplzv4v1nk/loPMfxIjyfxfEvDI9McNBVi3G1WOUoSe2emUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:47:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:47:05 +0000
Date: Mon, 11 Aug 2025 11:47:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 06/15] net/ice: use the new common vector capability
 function
Message-ID: <aJnKJf1NZ9ih43Fk@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807123949.4063416-7-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0305.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f228dc5-4a29-473a-d358-08ddd8c469b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ooil1uthC0WcAa5sHoQ6AXRBDrr+wYljb1qshEgP5DkhOFgRak32ZxCjIcZK?=
 =?us-ascii?Q?k+YX7UqTqF7cNnZdyqXzrmL5mNrEIluLo8RjNYqXnz21HTsXzxFynfaHpAf1?=
 =?us-ascii?Q?e0s8ZX0I5dGqYRvN3I7RVAYzHp8//Ds3js35EpjeOxjqFoXwJfrQ2CHoGa98?=
 =?us-ascii?Q?YUPZDtcUXR2rylITy6R+ADF7UvGuh2Wt5nh2ov4pZsdpnuoMINMbneqcM5Ez?=
 =?us-ascii?Q?+4NS8fYBtQI24qWRWxBIus2Yg5VEKEhIs9MMnC8NlKanBnKAtQuMTJwHx9+O?=
 =?us-ascii?Q?tahBuGFr3kh5TSpCZ2qZhRi0TIjkVY46aiKig74UtW/3P9AfQ2AFZYlywkL2?=
 =?us-ascii?Q?pLUAV1iw5g5h36PGvMwI+g/ii4xeAPCTjjTuhPQ7pl0ztqwazmpxgyuwjS9N?=
 =?us-ascii?Q?4aXsU9GJy62Y81E46/fx7GECUroXcey1NUJZ8ClQDqaA1Xx8Y1UePpByfZ29?=
 =?us-ascii?Q?wQOo9MR7QYoLoaG7Q12P8X3RjmzAslX5wcMkqUfuqxGfy5qe6JSnfmBs7niR?=
 =?us-ascii?Q?AOMQNu8HSDBrPOBRyHs8wKor9z9wyF3y+8nZ0EkGGtIAk2BkG6WrjnTeNLJv?=
 =?us-ascii?Q?RCJwVstwDz9Y38jc741v4Sgg4jobXfz5XjyfkPtU/wvi5b1Q7XMhidY9h6Tt?=
 =?us-ascii?Q?FgcNLlCNLXdBsQ+pCD3Q9weLOrD8iH3UBBs6bsBylU1SQZbbKKR09erHI2uq?=
 =?us-ascii?Q?y9wfY+Ko7IqF4APHFdh79BLuKVFbLRJjpen0zTaX1ZwpJB6WqcbyUZbM6Nfd?=
 =?us-ascii?Q?KBKi3SUpe8IAzd1Uc1/ecbUsHjTsEgXBEiUHQfkpX6T19iJv5JCIh+wB7Urt?=
 =?us-ascii?Q?ggEZl2oApDlszXk54WIBzHdnHYxhCyzC4ELvDEdK6x5FU4sPL0yedwIeNBNz?=
 =?us-ascii?Q?BHw48m5clAuj3Jr8OYyPLaIqNcAQKMk4ghIK2+NfRMesp3FX8AzUM7A+3mnI?=
 =?us-ascii?Q?COl1jgVr0GqOuGuualJ+GvcHQkmPEEily96kotNMbpe5MP2Wg+wXiSgTYMTV?=
 =?us-ascii?Q?B24oESlCSwF6IP+SgyZx7TIuCUatLHFYLk7+rtBhJmYpR1u4liru2OC3KEuO?=
 =?us-ascii?Q?RWLl01pa1jNEPKzylLoHQCFZKjfzdFcfD2otAjNJtgFtmv1gTKXJrP1ECU+d?=
 =?us-ascii?Q?FNBNIYjVPmbWoWTLw0YMmkfCttg2TzLBF2su2s2jVt+/xI9fwpMM436nHQxL?=
 =?us-ascii?Q?XqqTqnbOt2DKdWj71vSKWCuftGfRvgRuLkqpaq4Z6O3iqjTv0rjxiQMGJBIW?=
 =?us-ascii?Q?7b1DPIjcth39whd47MTqqSYcKt3vL1iUtAoclZRE6HvNWpHHWGKf8vlgT+38?=
 =?us-ascii?Q?xlw9HDJ3DZIYYMbdvQmv1JEPZTOBQKuzjpvXZAFKn3XHWVQreA8qjxc9Y5n0?=
 =?us-ascii?Q?oXxs0otXy9RCHf5A80PU9NB5ZtWGhtg0A1E3DodNK6zMbnTNoFfrOg7digUg?=
 =?us-ascii?Q?ZAYdhjweCfY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANQqP+ps7RcZ+lyo+OFka31/1lo8cUgIvlw7Q1zRCJOObmaHc276Yi1WbpS0?=
 =?us-ascii?Q?bCi6vEgv1TibpRxqEaNh7IZbVU74wpX35mZGjrrz83336Rue+XR3VRxV6qPB?=
 =?us-ascii?Q?EwNz8DB5btZySc8gNYb/6nIffqImJLP0zpYoYs117egy/rJnuvpU+LC5TaBb?=
 =?us-ascii?Q?9llH78HoTDE/ubNZlLkY/50LYceUS3Q3ZDRZbzdLAvQ36pwdjZ3Qvdspi+J5?=
 =?us-ascii?Q?FMXZHqoATn9Gr5mVPewXYB4PD3d6x4ZvoU5O3ZYIUXUW9vPKWIx1LVfkDSc3?=
 =?us-ascii?Q?tCJaPMNVKhz6oNnoOYlpq1KoH5bbf2penhInMH6Ala3dnbpHAH8uuAM3yHqW?=
 =?us-ascii?Q?EYTUg3LYDcJFRjKeiGa+Ka7K3f8DwRiDR5Bs9tkg2bsINFVW01lxddKQ9hQn?=
 =?us-ascii?Q?HqnYEF7a016NbK1BOU69OMoRwMieITTQY/cPQRpq+JHDbWlyq+u/WApbdjHy?=
 =?us-ascii?Q?3ngemgTAj6FBmOGSIQoEerYkYdIVB5ntcrQLzpSjUoZj+OfIkTY4HGy90mlE?=
 =?us-ascii?Q?/RHZkuvQtI0qx9RDibtUUNMAmXKqaMOEntKcG20YLCD826wjBuxQR/wFS9WP?=
 =?us-ascii?Q?wikfPw2/s0PpibjPKR+TZBbOTh+MkUejAY2kNfbbzWvyd16NwV60zkhcnutj?=
 =?us-ascii?Q?+JSnfz/D9grROd/F5/Z4v6CaeqFQJ94sdLkOjLlRiuVOzV9BwT0aSYEoe3e4?=
 =?us-ascii?Q?/X4OSOia8iYeIZfZJB2d2K8D2HyEpFYty2ujO3DaS+m5Lh0lKYkCs28Q4UZ6?=
 =?us-ascii?Q?cbzbiGg+Kx+BvTASst1Upbq12/53et/Ij6tdq1S1CeXRzlczRcaVnsrb6iG9?=
 =?us-ascii?Q?V8ugRNoE3Ku+ET5BavFaieSmZt9Jl6aAtzmVxAHNptATrfyxEg/ntj7OYJK7?=
 =?us-ascii?Q?5DSHcZsyth4JvdwD4sUHYoqrdyOyh1D4JFH8Ha5ZewAjpJTviJEXCwUxad8j?=
 =?us-ascii?Q?sJgqLnPUyQV1tg+Q59XFYtWNEgxqNgl0Ljy1x8ivDouxM+Gc5euAM1C7/mYP?=
 =?us-ascii?Q?xo9XvaF/XReJ37QpJNRVlfKCJ3Lauda2GU93NDUiCYJB/brAniKX1TQgzPrI?=
 =?us-ascii?Q?m7YI2D14BKn8atkp9DtWJhrHQNpD9EA+2dFpyvTPYYmhch+VV5RtzJdD5vWT?=
 =?us-ascii?Q?k7vm2skJ9zeU7hlIetcZivZuL5kJTEutc+tUGA5+VtbbTDV4MqJiELmouVG8?=
 =?us-ascii?Q?5DNcBMbOH1KINkMdYbb3niwqfR/s03dlxIATO0n0diinRmahvHtuqUnw9SEa?=
 =?us-ascii?Q?FLivHzpndP2JiGxYHGzn7kI70h3VhpkXAXIZi7sQ/nqjkM20eG3woWA0TK49?=
 =?us-ascii?Q?ir+BD/oclbPb5/VDM65MU3ndzkycMomWj/4ACn4bu4tYKDcLUWr29aDHPycw?=
 =?us-ascii?Q?ZrAqEoQFK0YzRdEPKAMSLDTVdXFVSXBAVBhD3vtS7PlmTAwSy3hEfZek6fkR?=
 =?us-ascii?Q?kGH2tuum8TgGnKXg0oU2NT/U+cdOygKCUqM4pOEIrobwCg/JNBqcZSu/Dfei?=
 =?us-ascii?Q?ZVXjQA+RcqmXEcMUir65fk3YE4p9ZmajdH1dxwHRlUuwk/KyPm3EmRByp3ab?=
 =?us-ascii?Q?l6QTkVw2tG75SbfYZ8ct49Sl9hxkYcxHq+q5R6RUV4FkmQC8+jFwgpAPdp43?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f228dc5-4a29-473a-d358-08ddd8c469b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:47:05.7037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK2uPPY/uixcobLJPEJKcYES7JNQ9x2N5Du6pAWO4GCUF7XDt7qFi+r4viE42ydN49iQXpX31YJAXy/Knuw4VFOIJHOb8Fnk7WLACdSSYYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
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

On Thu, Aug 07, 2025 at 12:39:40PM +0000, Ciara Loftus wrote:
> Use the new function for determining the maximum simd bitwidth in
> the ice driver.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Couple more comments inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/ice/ice_ethdev.h       |  5 +--
>  drivers/net/intel/ice/ice_rxtx.c         | 52 ++++++------------------
>  drivers/net/intel/ice/ice_rxtx.h         |  1 +
>  drivers/net/intel/ice/ice_rxtx_vec_sse.c |  6 +++
>  4 files changed, 21 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 4505644f87..8d975c23de 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -11,6 +11,7 @@
>  
>  #include <ethdev_driver.h>
>  #include <rte_tm_driver.h>
> +#include <rte_vect.h>
>  
>  #include "base/ice_common.h"
>  #include "base/ice_adminq_cmd.h"
> @@ -674,9 +675,7 @@ struct ice_adapter {
>  	/* Set bit if the engine is disabled */
>  	unsigned long disabled_engine_mask;
>  	struct ice_parser *psr;
> -	/* used only on X86, zero on other Archs */
> -	bool tx_use_avx2;
> -	bool tx_use_avx512;
> +	enum rte_vect_max_simd tx_simd_width;
>  	bool rx_vec_offload_support;
>  };
>  
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 428e136bfe..8c197eefa9 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3703,7 +3703,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  	struct ci_rx_queue *rxq;
>  	int i;
>  	int rx_check_ret = -1;
> -	bool rx_use_avx512 = false, rx_use_avx2 = false;
> +	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
>  
>  	rx_check_ret = ice_rx_vec_dev_check(dev);
>  	if (ad->ptp_ena)
> @@ -3720,35 +3720,22 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  				break;
>  			}
>  		}
> +		rx_simd_width = ice_get_max_simd_bitwidth();
>  
> -		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> -#ifdef CC_AVX512_SUPPORT
> -			rx_use_avx512 = true;
> -#else
> -		PMD_DRV_LOG(NOTICE,
> -			"AVX512 is not supported in build env");
> -#endif
> -		if (!rx_use_avx512 &&
> -				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
> -				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> -			rx_use_avx2 = true;
>  	} else {
>  		ad->rx_vec_allowed = false;
>  	}
>  
>  	if (ad->rx_vec_allowed) {
>  		if (dev->data->scattered_rx) {
> -			if (rx_use_avx512) {
> +			if (rx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
>  				else
>  					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
>  #endif

Since without AVX512_SUPPORT, the ice_get_max_simd_bitwidth function will
not return RTE_VECT_SIMD_512, I think these ifdef guards are unnecessary.

> -			} else if (rx_use_avx2) {
> +			} else if (rx_simd_width == RTE_VECT_SIMD_256) {

Minor nit: since we are using "else if" here, rather than another "if" I
wonder if it might be better in general across all these to use ">=" rather
than "==". If we did need to ifdef out AVX512 support block, that would
then allow the 256-bitwidth block to catch those AVX512 return values.

>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
>  				else
> @@ -3757,14 +3744,14 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
>  			}
>  		} else {
> -			if (rx_use_avx512) {
> +			if (rx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
>  				else
>  					ad->rx_func_type = ICE_RX_AVX512;
>  #endif

Same here, as far as I can see.

> -			} else if (rx_use_avx2) {
> +			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
>  				else
> @@ -4032,29 +4019,14 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  	int tx_check_ret = -1;
>  
>  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> -		ad->tx_use_avx2 = false;
> -		ad->tx_use_avx512 = false;
> +		ad->tx_simd_width = RTE_VECT_SIMD_DISABLED;
>  		tx_check_ret = ice_tx_vec_dev_check(dev);
> +		ad->tx_simd_width = ice_get_max_simd_bitwidth();
>  		if (tx_check_ret >= 0 &&
>  		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
>  			ad->tx_vec_allowed = true;
>  
> -			if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> -#ifdef CC_AVX512_SUPPORT
> -				ad->tx_use_avx512 = true;
> -#else
> -			PMD_DRV_LOG(NOTICE,
> -				"AVX512 is not supported in build env");
> -#endif
> -			if (!ad->tx_use_avx512 &&
> -				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
> -				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> -				ad->tx_use_avx2 = true;
> -
> -			if (!ad->tx_use_avx2 && !ad->tx_use_avx512 &&
> +			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
>  				tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
>  				ad->tx_vec_allowed = false;
>  
> @@ -4074,7 +4046,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  
>  	if (ad->tx_vec_allowed) {
>  		dev->tx_pkt_prepare = NULL;
> -		if (ad->tx_use_avx512) {
> +		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
>  				PMD_DRV_LOG(NOTICE,
> @@ -4100,9 +4072,9 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  				dev->tx_pkt_prepare = ice_prep_pkts;
>  			} else {
>  				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
> -					    ad->tx_use_avx2 ? "avx2 " : "",
> +					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
>  					    dev->data->port_id);
> -				dev->tx_pkt_burst = ad->tx_use_avx2 ?
> +				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
>  						    ice_xmit_pkts_vec_avx2 :
>  						    ice_xmit_pkts_vec;
>  			}
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 0301d05888..8c3d6c413a 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -261,6 +261,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
>  int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
>  int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
>  int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
> +enum rte_vect_max_simd ice_get_max_simd_bitwidth(void);
>  
>  #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
>  	int i; \
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> index d818b3b728..1545bc3b6e 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> @@ -735,3 +735,9 @@ ice_tx_vec_dev_check(struct rte_eth_dev *dev)
>  {
>  	return ice_tx_vec_dev_check_default(dev);
>  }
> +
> +enum rte_vect_max_simd
> +ice_get_max_simd_bitwidth(void)
> +{
> +	return ci_get_x86_max_simd_bitwidth();
> +}
> -- 
> 2.34.1
> 
