Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619CCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:44:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 766B040296;
	Tue, 19 May 2026 16:44:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 48CFB4025E;
 Tue, 19 May 2026 16:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779201894; x=1810737894;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=P5QVkLPrh5sXcuLyviF20eDF0FlUNKyjAeO33orsr3I=;
 b=HgHbhaieS9kT6sJilu1lVk837TcFUW45TEKjd8hIO/vDlZ/5DrenLlet
 kZbTJvr1XhnFeU63EE3x5Zie04Ee46pgkN+pm67+TaPdmk87EyyM7LuiC
 V3evLGjEsoNn4imFQnYvFKf6AcbB16BrI3aNgwF8T6hv5eF0qbnYlJicr
 SDB3VDtL54cZFnet7QSP4qqn2nPnw6jpq1nPTe+EF7fBFGAth76bgo1Fk
 HiVcMre2nRNOhtrxGaAjbSbfmbNS3MyqI8wVS1VqvSAkGwi9qfSiD+/Ct
 PsPGqGvFS25KS2JvuGs0XH9N5VHYOL1QvmttswXc0lKJq/aN6bYOM7+Tt g==;
X-CSE-ConnectionGUID: LV6pBEdUTzKVz0iHuRabyQ==
X-CSE-MsgGUID: C8QehVqYTLCzrybKcSNScA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80133124"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80133124"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:44:52 -0700
X-CSE-ConnectionGUID: 0cAUgvgvR4+lK5BoiCWUew==
X-CSE-MsgGUID: /lHSK19cSTC1wHNjdf7iIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="243790165"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:44:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 07:44:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 07:44:51 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 07:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6tP+b6OvMw4SI+aChFkFuiYjCylt4JjirKqb3w6EFt7jDdgwnXjT5Zh7BzkoXx+eyhuyQWjPJrT2hWnYOUPkQllJ4H7hKUPJL/POJerXTXwPxG+w1We7tRlimK+xbTEJNRGu488Hb0lPj1DC3t1E3W+3IohcEP1qEqFj8SOeINkm1vak7kWOqHbBhodOzmpp4cW9dz2ZqV+rbtd/OwV1lhulg7fyRnVF5spQDseS+MyifWoJkz19pH7rGtpuS53sn5WFYT5RScj2lAChRArDksi3RqNnilo3ScAIjfB86R/IfPzik613EDhrYJBX+RR4EZF5xa2LfX+5aexO1Xe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0otTYv64Q3ymou4kaTjuy44jly0ztdv9q5s/SK/kH4=;
 b=OVZXqX53X8olIW/KIdCkhRXJV6dYAX6zXmRfiMP+mYGowSbmnWda6Qa2znXjFxbP0hncP0t7OxXfS/bQgcDzLspD/O3ITfGPX91J5KIA5njGbMfdAUjpwaswAHRde3LP3Oh+MH00HmXAtqsPTBmODwmPDPYge8MLR17oNyiLE3ZSt3TPdJ9g9nZu7PFGNbuVTukCGQkvbaGmze8Kov6Uxo0P19CiUxY5vTtIdMh1yhTTA6973aRKGoIyqztMh8C72pQ41BoMB68Wcu5T3ZP6bR0SInWNWTiCATBC0w/UGZf5tNUudIQRYOJUIaedqfSm20Uti9hVLH0CRQuWzYx0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:44:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:44:46 +0000
Date: Tue, 19 May 2026 15:44:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/ixgbe: fix flow control frame byte adjustment
Message-ID: <agx3WX8nLoJT6JbS@bricha3-mobl1.ger.corp.intel.com>
References: <20260504145502.160806-1-dish@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504145502.160806-1-dish@amicon.ru>
X-ClientProxiedBy: DB3PR06CA0010.eurprd06.prod.outlook.com (2603:10a6:8:1::23)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8da30d-7546-40b7-3e35-08deb5b52bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CVXk/z+R2P9yUqOPOI/czV7vbeJ31vMB97Nb9GxCaQMHk86xBG3BbxW1yqhh1sQIHgrvQHipADC0aaOiYK0g/V9PqYqc/8mBLQV0wHVr/G7SwQws0xM8uP5qgwnSPoyVdQu2GPRLiMqJyL2PlO3Nr5+RqDV9uJozTNWC12qGwX70s+/Eyp8TlSO37Hjbs8jf7MkJIp2rZlR8YbFo8SRkXywpnWqDkz3Gt107932oZR+8jqjbOddpD35Pg8rRr+/HxyCt0MUp2idvzlhkjH0/phdYwBAzvuxwy1ePC7hDj1LjaJlkjJJ53J+AbGCQ7yrQSRQCK+6ot9Ty342vGZf03WQ6ECuZNRuuyGCzWVcS0w9YzCmKRNUyZSsi7zHvj1odOTFsry/dYmld6qrrr2Ga+6Qu+CLDUjlekPVdkc363QoI59vuEEZsOKzhizywXGWDLzoFFJMUMEFSTLe9bPgGhUcgrjYbeFJ2iqfSIghKf14H3E3KXxCR5b/TqJdEF9pIrvQR1WLcbxwORDvuA2ZAjai8GvU87jCJlJcPTxMDAu218mnXxYEDaq1Vvarebd98GGC9wlUMwvF5nPtzDce/W3NkliJPPG9PvqIejp66lir+DZuG14p42wtfKBBrE0H9/iyWSJ7tOvrGWwzLrXkauYWXuUgtgzH5YqxjhypoMvmOUkNSRbNwDoCaYzLU4rk7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvTs6p6v7YN7zr3IzdL+qxHMJacRLhn7jhNGQbO9myVKlrLQ4pENnRtbb+4o?=
 =?us-ascii?Q?rx66B66MCMGwxOF0HL/esKHufwrNN2wO7fiUjD92f6Rc6ASsFcO1SWF1OaeB?=
 =?us-ascii?Q?zS5aXQLUV0N+RtQqAWzRas59RRwyuz2PVwbDoAKz6syzRTBkptXZgffXDriV?=
 =?us-ascii?Q?qumHcdivwFZxg1nI5H3/Wmm0FBEJSHO+Z2aW6U7C1Lb6WJM4/x+670hQ8eVi?=
 =?us-ascii?Q?EKpAAj0Ckc5E3jM9w/WtgbyVDDQahU1mQx20J6auDn0nkUMv/CR/3d3He12H?=
 =?us-ascii?Q?WEZOex0Tq5qgKJ/be/4+pg27rVEvw89ecq2xScSZX0VfXKbIsVVqhIWqby4+?=
 =?us-ascii?Q?aA80Xd7fgMesdHQdSR8JDtKBY3zCn2k9thrygtSL1W9ulx2rou0omCBerXwm?=
 =?us-ascii?Q?7E+fAsIAXloNASpvSmjmRxXU6NlAt/02Y1MwWkd2Qv2OhJTxdhf4nRaLk4Fx?=
 =?us-ascii?Q?mTcTbyVCIWgJPZb+P6zXSOe7jcx3bsICNxV4OzRPBY1EQ4Gl+NNiHgN27cGs?=
 =?us-ascii?Q?7aQyaxehpVGTuKnA5rM8uqlkc89rEm5njpfaO1O2n7Dbx1wtuqm74lh56+uQ?=
 =?us-ascii?Q?YQyAkJZKLmRsWKUbPfsxYuyQ7fXdWPbuqdbkdX0ydDal5CVFQJxQdYHGbcSD?=
 =?us-ascii?Q?QSVEEnbMOMJvTuI7h+fZbfbm+U3P0Xv8ak8cKJzvCtgnrZse605KFxnwKqka?=
 =?us-ascii?Q?gQVNxZiwuTAvpE7YZteerwHX0xugXOWGqX0E75xkUxnN8FvQz9OD3Jq6Nsfe?=
 =?us-ascii?Q?wr0loOuXUwvv4edup015jFZG4dJP1j57B0m1/apWmOXFMVQBJejRfeC4nEbL?=
 =?us-ascii?Q?+Ic1ea9clmx79MovaEIxXyedv20beHAIn6I25+sC+DvHNhAOM7Ei3h5oRxfU?=
 =?us-ascii?Q?Z/yiJkEJKxyRSjj159m3kq5/iSUjpLazqOh/f9El0qONmBb5lvsOCnYu6gJ2?=
 =?us-ascii?Q?GFApHDd/SCr8NSOIyCXPwCTxu6Yom5LpzCTAj5rW/WkwOfu54f5M1HgpHAX0?=
 =?us-ascii?Q?XiEfU2i4as4OuOTNcX0Tbsi9UvhSuhlyL3ng+6xok0I6cR4877VM1oH6eJnI?=
 =?us-ascii?Q?Ch3Wx/KAxAmuQNTr9O15Zd8xde/8dKj2fjSaa0c5QezhEQw3aKnkKbIPKNjF?=
 =?us-ascii?Q?ryye76Nozrw89Vpw+ZAT56ub4IFxGNlNk0+G3o5y14MB8cWWArmkbcO7PFtt?=
 =?us-ascii?Q?7lly/IVRLZmCbOzA5yy380txoT1p0uxazy4Vcsr16JRMnpQyKJLCCvmCxLbB?=
 =?us-ascii?Q?z57cRkwaDD9b50HehPrz7LKYVFRSflH7zyx1D4BAAzyxcSTySS1SkPb3TLQZ?=
 =?us-ascii?Q?pImI39pxnZ4e6DmDD+l9aR3WAQvFCbgiuOos403HsCr0Xb5WVxeBOJZEMCV2?=
 =?us-ascii?Q?3KBNfmlEILYmtSttlJKdKdEkgdOndsxoMNFdKziofZiBKAyrIxDAFB/IW8Bw?=
 =?us-ascii?Q?huOgiPgtbhekEsxXSg594V80ntIuti/PW+Y+sBiVnkK7Au0Z9dbaXxxRUkhL?=
 =?us-ascii?Q?OHUWvwgTufSoYEh+tRUlgYoYDptIZvo9yv1gQAuqVgKOOoZc64f4bcC2sWM6?=
 =?us-ascii?Q?S/PUWes/g9+VFfgPY97bd7YErvPYFVX220JmYfZF7K+640l/KgSGCUJFdff5?=
 =?us-ascii?Q?pcrABVlREzRWLf0yURANdJ+X9VfBPaP1bjfO5HLumGh+/JRO8aaR1QAxkb7R?=
 =?us-ascii?Q?WnZcLYugl0uuO6cpbWL0d0Lg5LaQNlvjobZwg1VU4gTpqvJPTZxYmZDepeK9?=
 =?us-ascii?Q?79V7mAkqNFYkkM60PqNW322IyTGtNUM=3D?=
X-Exchange-RoutingPolicyChecked: kfrG+OxkNopwZ9w/Lj+po+0i7HLX1lLIv+1uREkf4onnpEFG5cPtq+ARfSMEsG7NzUqcSlCPG3Hyn9sGcQJbsJSaz10MlPu+roRKQ+DFfi2nQ1L7j03ccBw3FGPnuyyT5c+qexQFa0R+92N8RHax8/zqAVJdJxVClzyzfQc+mI6SfqV07ZqxysxPn3Zk4taNwV5ElmT9Ak0EVwaFroHRzi8obRTX4vhvFl1KFtQAV04x/vgoBf1DHR8iR7snQXfj00ahY/2sC5Zh+fgp91+LK50W5FUzmqAaRNhjGE8meTeE+yxs2wVZ4mw8kYpdj1A3FrVcAt64prJs+fqWyttIBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8da30d-7546-40b7-3e35-08deb5b52bbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:44:46.2509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS7Cdc/b3kJ76Uxvdau6fvDo65C3+Cdx3v8WK8WzIEn/nYrIon89ook4FIqznZF70QailgVkRsdVHg0TPkRo4WrkByIRGkeF4JZ010xA0SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
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

On Mon, May 04, 2026 at 05:55:02PM +0300, Daniil Iskhakov wrote:
> LXONTXC and LXOFFTXC are 32-bit counters for transmitted XON and
> XOFF packets. ixgbe_read_stats_registers() sums their deltas and uses
> the result to adjust the transmitted byte counters by the minimum
> Ethernet frame length.
> 
> The sum is currently computed as:
> 
> 	total = lxon + lxoff
> 
> Since both operands are 32-bit, the addition is performed in 32 bits
> and may wrap before the result is stored in total. The wrapped value is
> then used in the byte adjustment, which may make the software byte
> counters incorrect.
> 
> Make total 64-bit and cast lxon before the addition so the XON/XOFF
> packet sum and the following byte adjustment are computed without
> 32-bit overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

