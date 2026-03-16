Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E98F506D2
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C7F34025E;
	Mon, 16 Mar 2026 15:34:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 59FBA400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:34:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773671651; x=1805207651;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d/Me9X/sJ8JHlxh3+nn4is6f/KcLQt1ITNbCDmw2x5I=;
 b=N/uSluwBQL0S6tSvKQF/CLVvSUak5nYN9SXy0+MVa96VYNS1s8Kz5400
 bs+YWOQCJFLOQB8hJ1xpIwZ747x27CJ2u6G5MKfMlVMDfZ45TA6ibgMjd
 dwULI7kXBuq0VwwWO5ZYkJ//wEJs4HPw8n54B19Q068sSG4dLcHnyiuTY
 293XOQkT0w5BOROOfhZ5IOdwS2cTaeNmTxM+vcRj7nNGw0byNzkHgiIjd
 5fxceNbt7kZQY8UPNiPW6CaqAv1Sc64Ojl7uHw/LI95aPy95T0FFD5isf
 uifeD29I2awZoF8ikc4gs0uO997uuthO97vmE4kKozxke4ktoe696HrQq A==;
X-CSE-ConnectionGUID: FEN+d8KWT0uJLlzbx9zULQ==
X-CSE-MsgGUID: F349LjtwRdyPlZcqV+cr/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73870639"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="73870639"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:34:10 -0700
X-CSE-ConnectionGUID: UeDB3p7UT3W1euCVqKe+zQ==
X-CSE-MsgGUID: fSc1DTHsTv6moniIatjWVw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:34:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:34:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:34:09 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn2Nzke4Tw7/3/bY63o/khdoC4lnBpJJks3Mi04pA+fdvPtNYgW2ucaWT3c2YNyPK2Opj940kvAqaFXthQi0eNJWLu3ApjiaU1ew94Sui+rpGblIyKx+MrCnGGbCRwgJoCb0YiWqpnvN5RRiJUd/hCko9BCMLh3UZWnATkNcm5KQ9DBvTYpG8Bg/m1XdIQG83szl0VXEuslJ1yq7S2jrZu9oiDR8bQbAhPaxaHDKUAevnszmzthHzsQhSTWQVsWGEl8SpFJlvMuiIbRUIvNYP4mPTRj8jLXiwedNsRIBMy1ubIlQ4EhN8xeTFmafhnQOGrBs/NymlOcSXtbtgaqFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFi+xpEDmNq9qn/mIhW153YuXSTgM0pVE2Fp4X6wdDU=;
 b=XCA/3UiAT9zmcqcpS2jCJodSb/BOpZdB1lgRJkBFpUtF8VndMU8p9FiPgjahm/90Makf7VaCQc2jejVqdyuv+q6xNFeccG9uqClN23YHWzB3tHtKM1Tl39/AT/q0m6FWJxfLPFUHHVWmE3CT66JK1fXY2mPCRwdfzlu9Tufa/DZAjKsAdEOX1U4fYlOKwEeli+ykYTAeKpedtHni0NUeBV44pDiy//LR0bhkDw4/QclRGqCPdXxIryk/8f1lKtftqd3/K9WpvC71ue9BeyTy3Fg41frOadkdWv2JGRLIm6LTeuqP1JLMLfDigdvsh4J6qrKqd1XAD6gjVBv5UOpfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA7PR11MB9544.namprd11.prod.outlook.com (2603:10b6:806:4cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:34:08 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:34:07 +0000
Date: Mon, 16 Mar 2026 14:34:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v20 19/25] eal/windows: add wrapper for access function
Message-ID: <abgU26_cyB5Kugwp@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-20-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-20-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::29) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA7PR11MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfd7f57-b973-463e-ad15-08de836914cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3DSPhKETwAvvLjmwmk7Ebl69SaVVA97qWUfAGw3nn0hnr3VE+vW7AVFw4n2EOpt4lwtfbOZ3dieccSc/JRD0qBpYx9F6btNjvIb7WKmsSFWLL0wzpqjEw6fvSOcbeeJhQ8DInz3FSuyJBX8PpIEhFb7kaBR9FKUtuBKwl9u3Mh+bPzGPiY4DYGZ8Z5NzcvF83KUe7racQmnD0S9F3HgoptuQGDj4ZGSm9P/Ol9qwUBzdjRFF0Pi3aPT1nBVsqmmvNG6z1tpaKpQvOqzrjioz/1awtGrQ/3RY0Ncm7wVTnRujj54sr/EMEdqpTNiszJ+UrW/2DcapQ+NdEN4ojW572AcHTgLzk0zKrOtbCfAoDMfsDwhb6EV6LV1Fp8R1lROd+27RHx/IzaNXGNKIpYKZf2BfyoRtsB3MVHEKOWVHPlPNACEJIR+TyXGEdrXJw1gdTrIR4Sf18vPUoe0+OfAh9TqSAMPZRc0QFmZJWOzimvge4j1y+GbFPuMZxdhSOINLkF7pfqtL4A2c1VNaX8k7HkTwzAN1W8qniU4qXMlrtl1EKpWxTtZROEe39VPujmSLRUqDZHQQUGn0qVc1Zn+7nYwdAMhSexFfjonfvpYT+JqltiuZ/gjE38QeIpzYVNYdDRtR+xRiPRoYjVUXIksH+gwxgz0xuOlksVYkzVZQITSTH4ljDzluF0fnIqdrvXCOYjDQPt6bII6d3YMIdGDRVykU7raPs8X+rIk4IsDzVGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NPDalVfGGnVFT6EsV54hS0XyTgFsQU5E/heNyHQjEEUEm47hFGg84PFf6t5W?=
 =?us-ascii?Q?z9EQ42vVy2pUnfR2CUXX6qY78dGMcyJXfQn8BnJTurE+RgrK3Fh+aOKG0muq?=
 =?us-ascii?Q?21F0sB7xL02RzJSY9vK9U3aL+CjxZ25pt1oBwbsKyKy5fMvn2CLnE97QG/Qr?=
 =?us-ascii?Q?kEh2y9I0k/AJpjJmST3jf/WKX5V/9w0hvoZwEqAXrd8euv88Z0NxlanHxtPk?=
 =?us-ascii?Q?fAEnTwrS5S4TJnJXMLyBUinHUpt2Re7bv9KtVg/ZozjjhYyrxNj58HTjEgWD?=
 =?us-ascii?Q?w2S+c++11KgLfPtmMK6z5qzu/HXV6SzdPM6UymyT9JhyB7DDPnm5cXqU8FOt?=
 =?us-ascii?Q?1A/tnmBLeAILRimahIQs21Hitn38lqVHQcYxHMRgi3eLOHzxDEbzHTxa02t1?=
 =?us-ascii?Q?ZPqEbWMjdY6d39Y49jte20elqiKPyOC1xyFapeT77iwa2CYh9anKRgntiMdL?=
 =?us-ascii?Q?sE5VOPYJSOX+xsc68WGWbYLjLcl6EJg98VW1xfGcIu0ng9xmLWTEu/44qP0w?=
 =?us-ascii?Q?2m5wekgvq6fxRYkPAh16ArJtxac7QxLHpTeRdv6f6NPQuyFmYqaQ0KIaXznP?=
 =?us-ascii?Q?i5VBpu5Z/tltW3hWwh+6+wfVM3ZPtIrzQH1kOFoY3j2P4awXYJjfPPPxR35j?=
 =?us-ascii?Q?25JD6e3dNw8nWWC+Fp6RbWip7QE1yuDjcb9vvN1TVt8DQn/FJ8ddoXv0vyZZ?=
 =?us-ascii?Q?tiEEw4GM72JI2iQNmk508w0RNt7cZV4KDPsVgAzjU/PNe+CdUKA3k9ZKn3g9?=
 =?us-ascii?Q?TWah2gfUwuBtPBHKspA7zgVDLOGKVRaCSkorn3ddDNccvEa0T8uYk578oycC?=
 =?us-ascii?Q?7Q4pmNMHDNDYBk6i86tzmTPeLgcW2G4QBYRTXCbWDYGTBsA9I1RxYdNdJh26?=
 =?us-ascii?Q?1OI8xycyfycDJia0NrJ0x5aRAH/LwXpdi4fmTR7rV7Jb7ujmBN4LkbtSzo5G?=
 =?us-ascii?Q?npHdj/q9JnNYbna/ctHyDYAhsd0sQF9xlgb2EFcNqblWbbf3E8DztTEjF5lH?=
 =?us-ascii?Q?rm9/8ECP4IT19x3Whf/5iMbximuXJqrwzBuCVtvZlj8JDv9Lpf/tYEOLzm2H?=
 =?us-ascii?Q?6EXuUffkq3F1Hf5Evsj2ZAmdHIP2FsY5LpVE6eBcdWoHlGZZ0epszaEmLDd8?=
 =?us-ascii?Q?lQWYDl2NRWQyLHZPE2k4LrWvPgfIhyJpTysC+ps8wIIiGxHaVAmcRKj3xK2z?=
 =?us-ascii?Q?RIInQLd86eNSQek+4woVtQkRBJQZPsOlgtbSkIQMjBX67QcJjAAZ5ymeeBNg?=
 =?us-ascii?Q?14lC7iRuk5IncebdX8OxK+zLBd9ReakeLtP7Fw++0k6eMPvowkTwmU4HjC01?=
 =?us-ascii?Q?TCMVFc0eaYnzQwbagm+MAoGtcoZrt9AmPR12KHval6Xit8TG5+YYH/zEx3B5?=
 =?us-ascii?Q?ThHoUYaypX8j6kCVosFs0S/j/TQzYzj/Fk4Eb7dQWoAqIYM5P+/ZkKIdL6ml?=
 =?us-ascii?Q?3iTfYeGwoevlbw+yb2b16cpoQU5CGkn0w2+fUdUYpBCAXTUglDKkaQ7GlYNw?=
 =?us-ascii?Q?OE6wbnnhacpHJc9un9ZiYeksGQa713HrbuskBC0SJNyC20Ffk+9JQ6N/n31Z?=
 =?us-ascii?Q?rwzEDc/tW5K39xAgiNrfTBHEE/diGJxpZu4lF5jH8vmFrUqTaIcG+FF3WMrh?=
 =?us-ascii?Q?gjCY+0livmwvdujG8qW7efwSuB9TBHxYzWt3/GgFxF9MtNSdYF4FGdngfVnQ?=
 =?us-ascii?Q?W8Hz+Sw4/ynEwcAKy6JKbtpdC1wi669n5jzcXVhLLCcHp6w78GdWLgJWh2OH?=
 =?us-ascii?Q?To6hlyY0RC693oK1gTxg+b4Q+yT3Fz8=3D?=
X-Exchange-RoutingPolicyChecked: QdpaN0ksh3FzXo0dRqDqhwq3aCKoeF+eDVE0ojufCxlrxxIbhaC4MKyvwkLuYEAIQ8NNEP1RgIpE9M9BSs5M+KKOvJzGt7h00QX+eMgioD4alJrz+sjQ21f/Eswz0MJ1MGe0CYF2yVY0BtzSiZrG1pT5l9jPMe2xHT0GDcKmfWxFV7YYdQlYSUYDVIxKVXAIhlHo2YuxHyCSdxdG/tHZxXkiujsA5xyp2ZXS23nBARHoC7ozs0WuaB+ZxNT6pKvpm8IdXcNxF1WpDyzJLFbZb3y4ADvt4nX5PdXpsZOWHepE+C0F15RGpoSOPCvueU/gSwCeCEvT2sOC4E4F4x2SQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfd7f57-b973-463e-ad15-08de836914cc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:34:07.8372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0ZwOw1mOdsGmln3gcl2+msKpDH8Spdb4bMQIk2JCtamO64YOOw/1q0tb8RkiZ4x1wFLynzlW9qFyl/3NzEKhrRlJjx3ZyImFYnwp7YUl78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9544
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

On Tue, Mar 10, 2026 at 09:09:57AM -0700, Stephen Hemminger wrote:
> Like other Posix functions in unistd.h add wrapper
> using the Windows equivalent.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/windows/include/rte_os_shim.h | 1 +
>  lib/eal/windows/include/unistd.h      | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

