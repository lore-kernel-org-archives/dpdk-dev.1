Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B4C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:20:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 889A8402D9;
	Fri, 25 Sep 2026 14:20:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E9B1A40294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 14:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790338810; x=1821874810;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZUKCTpbgoJ/tnd9x6xs5uuPOrxNEYEMyZpvUIbmjqpo=;
 b=DplNTr+NBm4WR+22dl0R6QRlOw1i9NVAXmAxO1JohjMscygpf3zkhlXr
 vHqE9YqdlnGP+/Qccd7hhPCvP8akXrYCf1ZNLpZ951iXtEOxVMSmS/w7X
 WHky+7h9leoPdlfrXPXhj4xKPkWszVKHFFAC9VAkU1Xg4ohQz5TccbhXa
 A2y0btqFsT7dJs8h/GqN+GzhS+6o/5imMTRfpdKzwKHqRmom92U73+eRv
 nIaTBK7zuE2OCmQImuBVmefbE3nLHn1v1JnGn1OidsfmJxcy/9rnZvj02
 dNM+9xvgpMEcYeblT0EQcJbcnb8uMAiiyMswOhI68FWgE4PBVdiljEXKu w==;
X-CSE-ConnectionGUID: mCX4PifwR3q4OSzSb0dnoA==
X-CSE-MsgGUID: MuIpXsgeTOmR2cpVMl62EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93842232"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="93842232"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:20:08 -0700
X-CSE-ConnectionGUID: U3eQYFJUQw6DJY/2K34fnA==
X-CSE-MsgGUID: ZjcKO/nBRee8Jpzygt4EGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272900846"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:20:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:20:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:20:07 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQqRTnIiuPqkSqvK6011TX40fIHlIcD4dk1FOBnWe8OPV5g3O3r3mccXPQ1/3BD+MEyNjoaBL0QHh//qNwZ6LlWYYp4nnvs5ENHciQMZSfZftufpTo6N2sYbaPidAs4lGSYZtmPaaAV6OalTPAv3Mit1NG0yM7Cy4hJaXuFrQCXTjwFPmR3N6gfhcG97btS/j6WcGYCGYMKGn/4g4lt1Gqk5rOLv0MCjT/sd5vhckZoUrLdu4L6Yuh6i6gyQLJnMcr990CqOjtGHGQq7vgdyfd+cvOqmWmZ2UFG6edRxHDgondHjZUSAbCAY991gD2wB+AZ+NUDEi29qFoM5JWzhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlbtADNg5itIS+4jQG/DltGWRNpx6gxv1bQSKQeIKEc=;
 b=pwFVAGQEkJkCQW5L+452/Jky9k/3GyXvAiyuYQwfc922iUhxcrJZ6XHguC7xm6bKikm1al1DYdqGeQ4OY92Tksibmxqf79EKHCsdBX3obCnuDxnU01VUAhVaIdKrXBWitL4j/jtMb21cGGQMZICLdU7haT7w/XqJfhDquyEvNlY+BZxlvfAv6up+aAokX0Zfln8CxAcSgDedVIrrcdyR1qu7S9sl7uRj1uE+OptbyCiCBA7F4p+IHsgihWZ5v/PzY4X46b+Wvr/5SjjuTqrp//x35pSPjF+jcafZjl72VhThP8XbMTFP/38Iqmkcd0quwJYYZmEmIGBx0Ea2DaoRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV2PR11MB727748.namprd11.prod.outlook.com (2603:10b6:408:413::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:20:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:20:05 +0000
Message-ID: <2c9d12fe-9663-48ba-9daa-4c805e4ea184@intel.com>
Date: Fri, 25 Sep 2026 14:19:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice cast rx_flex_ring to proper type
To: Omar Munchaev <omarmunchaev@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20260924175127.375701-1-omarmunchaev@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260924175127.375701-1-omarmunchaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0494.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV2PR11MB727748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d908992-b9dc-4e9f-7513-08df1aff54f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: h9BfURVnqnUjC3sD7NzCEielVapq6mBPHf/zwn8xRI85p0rWV8BghuyeBFzybB4jG2M+sU39whrBrfszqL47EG3LlUZaOlYXeYPyourDSN/Rg4cLTYyAoOxPq5Y1y1jfr7V+AhdaW/4zUrIo/zL/h1efGBtULp02r3+G7hzuez+u6L/WlIbsDfduEclpDfA2BmqmfqZNnlxXBBqkg3Ku0ZoVN/Ql226d+5tmZsPi6Waky11F46jD/1JxZUiRmgb8kLDm0TJqz4ucBRJ5gVUAZgdEpO7KaCAhKtLiJNIMCjy7kAgIGlL+vz/CGxsasqiHlfOaZRiHDobFP8kjKUbLw1BOW+6LGgyFFjNwQ7bFS4uAqoltrVf8JtB2iNDx4sfXrnA3BtJKY7KEf0Gx+L4zvMbDcFqacaEoJqeRxBqQYbWido+f2Rz4/s6QC42YoFpRzddET6xgZ0jRj9gx8reg45wZ3q2khz+uQmnVffxjn9PSLdefjNzjvtJGXYCPLc2SOC5sBmVniORoexmIufb/6BaKtsymCvDgIcvXFAlgItDXw0wnEQhe4O0fIvcjzP2NZknQlUYNsUvehYJAEGMy/eTyetcbuq8QOrjbMLE3yP8gdd3eQscrPBzMTqcaqCy8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERoT29hMys0eWJkUlhTclVEcDBQWVlvbDBpM1ZwTFBMWTUzQXc1ZlZqbVhJ?=
 =?utf-8?B?ZWVVQjJuaUM1dFdxZGVYUXcvS1duUTFxSHQyYzlCSVRXTnNyZ0hvNXBvL1p4?=
 =?utf-8?B?K1V5a2ltQkZqMGRLdXlXeDVwOFIyTTNmZEdCMGlXcVNRcHhMUGw5NTRudDhW?=
 =?utf-8?B?NTdUREY0MEJqMU1ub29qbzRoVHVkc3FjdFY2Zk9JSm9TTTZFbU1SaW1oRDJP?=
 =?utf-8?B?eER3dkZGSXhENFVFRXFGREdDd2Myd3kxdDZUcVoyMXYzTkpVK2lFbWtZdWRr?=
 =?utf-8?B?MzNsVXlNVVhKUHFydi9KUTJyOEZpTFIrNWxLVUhGanI5dEJOTyt6cStrNXRP?=
 =?utf-8?B?ZXhTdk95dTIzbXczZmRYZndKODNOWDdqbDdhZnJYN0k3QXJXUVFlVStLaVdT?=
 =?utf-8?B?czlBcmJESW1xR2hSMlZNaVdUSy91bFB3VmR6TGlKbG1hNHhzQlllazRxYjBC?=
 =?utf-8?B?Ry9ITzhhZ2FFUUNZalVwUHQvaklMSG5pdzdmYWV3SnRPTVRVS0NJcFQ4WlAz?=
 =?utf-8?B?cHViSEJrcERMRld5alBrclY1ZUR3YUFyTUFWUCtKMXF1UmNCYTFzelJ3ZW5a?=
 =?utf-8?B?UmljdDUyYlVlU3lqd3lnYTFJOFdFUGlweFVTbXQvRCtHeTFYSkZHdElqMzFX?=
 =?utf-8?B?MzYwblFLRkFCbUc5MVpMUjltUDZRdmFQWVdkczgxQlN2bVBlR2hNWGhpYmkw?=
 =?utf-8?B?bEQ3RFdJQktEd2hwYTBqM2xtK2VOUUtZMmVwK2JYZHhNbEx0R216cFNudHF1?=
 =?utf-8?B?WjBMaEhyR2J0ekxMeHV4bENkOGl1YXNLR2U0bW5jWDZsV0tNWS9rVlRXQ0hw?=
 =?utf-8?B?ZTNvdVY0UHhFVDQ1UWlaaW9YdEduSHNnYTdmQm9qWjgvTndTYjRBWEtvQU9m?=
 =?utf-8?B?MHZSMkdqdkZRbGVwMDVjbWQzNGRjaUVESzhnZGU1Nmt4bkdkdHF6S240cSs1?=
 =?utf-8?B?OXhNNnlqTTZPeTA2dzJnQ2hycWdDVEdWaWpXdmtFaW5ibUxZaHBqcGwrMmkr?=
 =?utf-8?B?cnh5QzlTZ2wrQi82MU1nTWVnNHJkYk9pc1FVRWZKUXgzWksvMG5HdnJKd2p3?=
 =?utf-8?B?VnRDWUVWamFMOE4wU2UyazlIckRlWk5jMTRjYWovaDhsYkp6RkY5Q3N0aGR1?=
 =?utf-8?B?QWRhbTQzbVlNeGE5aUppdGFsMWd1aytOWW1CVjB6OWRseWxXbjhhSnY1SHpS?=
 =?utf-8?B?QytiZVBtYW85SU1FWUxEakkyL1Z0VjQ4cXFFR0xDbXJDcDZ6WHBseERGS0Rx?=
 =?utf-8?B?K3BLcnFUQVhRTW1sZmNpK3pMcFlIUFRZRDNmRDVNOWh2M2VwNUl5Zms2QlFw?=
 =?utf-8?B?bysxS2oxNXpjaGhlS2VTcDdlMDRFMjFOeG5HbGtaNUtxQ0R5cHMwWXorV3RL?=
 =?utf-8?B?cU9TMXk1UkkzTnJyMS9CTno0TzVuQmQ1N1J5NDV5VnZJQ0RkLzJwdUlQZHdn?=
 =?utf-8?B?WFVmM1RWQzlxZ1VqVXJieHlOQkFXWG42R2pCdUE5RExkbmhwQ3dQejlXOXVn?=
 =?utf-8?B?aEI4U0pNZXZmOWZBVWIwQW5IUmVuTmUvRW16SElqUnRhZE44Uzk4R3pFOEht?=
 =?utf-8?B?YkJnNkhzcGtlenlFWWZLWVdBcUZubkJNMVY4S3lFNktOd3lvT0h4Z3BFYmUy?=
 =?utf-8?B?dWM1ZllWeGorQkphRkFwTUNPeVJlVjJLQmZyS0R4NXVQcWlKSkZDak1keUZS?=
 =?utf-8?B?VzhVZkJVc25oQnZmOXVpelBpOVpPQ2l2WW9SalNmM0haOHdGTlhFakxhTXZJ?=
 =?utf-8?B?bmlCTURUTUFjMi9SVjc5VDhSQmY5VXlORVNnbFgvelhZeHJZOTNndlNPRldB?=
 =?utf-8?B?aFk5d1VBcHBWYy9OcnozRU1GNXdwN2dGZ0gzaUVkZThHcG5iMXE1Z1ZIZk56?=
 =?utf-8?B?Nk9uZVMrVDFKM0tUenZrWlJUd2lJNytCRUIvQUVsaHgrWHBuWFNDYkFlUERM?=
 =?utf-8?B?WElqcjJhZzNQd2tjWEpuQ0pSUHBDbTNYTkpKOFg1UlFzRHA2TFozbk11RUsr?=
 =?utf-8?B?TUlzYzVUT3ZYWjJPaDk5VkJ2SSt0WnVRNE5lUVBGTUVqYkIyY1lSRDNuZTh3?=
 =?utf-8?B?Sy9vNjhxL3RkUkwyTmdhc3EybDF5MkxkVGRiakc2VFRuRFFPSHNyZ0QvVEU2?=
 =?utf-8?B?YjBFM3dQdDNPSDIwSXRvSUxWYzVDK3NtRlBkOFY4TEdNNS83MnlyNFBnZ2ZL?=
 =?utf-8?B?YWxvYVB2QlYrVWE4WVZleWVCdnFKajJLU09jQ2JUVDhkRDNlekRLRU5KbmtL?=
 =?utf-8?B?RU9wcDVOUDNPM1hDTHBVcFRWNUxZUUFFVnhOcUFRZUxEa1NsNjJnUVVFZ3lY?=
 =?utf-8?B?YnBrTlJ6MjRkR0t1MHQzb3ZuT1dYdDZYZUNyQmRJQ2hvRHAySlh2ZzJIbExD?=
 =?utf-8?Q?pch4XnatXDOPvKWQ=3D?=
X-Exchange-RoutingPolicyChecked: UECKKtzkSQyUwmRB5i0Ok24NAiWYHivOOiK3NalP8gYkgzWqBJZTW+bXw66ylCJkYUNFpPseU9IqIchCEP2WdSMkd2uo/t+99lIusRy5y6PuHplrJThn30XfHiE5DHZ27jcxpuaIq3t6Q9m5Q0DUA88N14XUwbnURABw9gvlqJltKDZSLmGXAz6moRAO1hh4PkqQBNZMUvWk8/8Kf+QeqXBe3/3Th0eYj1H6KClC8cXCAqHeUPWmjtD14VlCrJe4ILwoQ4E2eiGhcQsZWe4JgAXgRH0YQRncvtNkH+gcLpM04oFH73oRTbSYf5+0u6SNeeuNzevsXuQDVITLo/F63g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d908992-b9dc-4e9f-7513-08df1aff54f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:20:05.6455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rbaf71aIyuZd1zjZBl6KQRds5FaBmEM4/ZAvrTHoR3emB4Y9Sg3tJSsY68z+wqGWOrGJHG5ZjBg8WbDyHF0x/w0BHAsZyiOAyvpYZdm5C4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB727748
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

On 9/24/2026 7:51 PM, Omar Munchaev wrote:
> its look like, that some parts of fdir code was not updated with new
> generic ci_rx_flex_desc. This patch fixes it
> Also im found out more verbose logs for ice_check_fdir_programming_status
> in linux driver implementation in function ice_vf_verify_rx_desc:
> https://github.com/intel/ethernet-linux-ice/blob/e4a92b1e84e084bc599580d065020986e501b8ad/src/ice_virtchnl_fdir.c#L3513
> 
> Signed-off-by: Omar Munchaev <omarmunchaev@gmail.com>
> ---

Hi Omar,

This looks like two commits jammed together into one. I would split up 
the ci_rx_flex_desc changes from the rest of the fix (the logging 
changes are technically separate but IMO they can go in with the macro 
changes). The flex desc changes in particular would probably also 
require a Fixes: tag and a Cc: stable if the source commit is old enough 
to be in stable releases.

For the macro changes, DPDK is a BSD-3 clause licensed project, so 
technically we cannot use kernel code as it's GPL-licensed. Please do 
not refer to kernel implementation directly.

I do however think it's worth rewriting the Rx status etc code with 
FIELD_GET macros the way you did as that makes the code a lot clearer, 
and better detailed logging is certainly appreciated.

This patch would also benefit from better commit message. Suggested 
rewording:

[patch 1: flex descriptor changes]

net/ice: fix missing type casts for flex descriptors

When ice driver was ported to use the common Rx descriptor format, some 
type casts were missed. Add them.

Fixes: <sha of commit that introduced the issue>
Cc: stable@dpdk.org [possibly - double check if this is needed]

---

[patch 2: macro/logging changes]

net/ice: use macros to get field values

Currently, in ice_check_fdir_programming_status, descriptor fields are 
accessed through direct bit mask manipulation and shifts. The ice driver 
has macros for this, so rewrite the function to use FIELD_GET macros 
instead.

-- 
Thanks,
Anatoly
