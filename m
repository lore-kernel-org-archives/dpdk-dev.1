Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D3606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CLZNOyPi;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OKh8+m+D
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48B4940262;
	Mon, 23 Nov 2026 09:52:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id F1124400D5
 for <dev@dpdk.org>; Mon, 23 Nov 2026 09:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795423949; x=1826959949;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=liHSinpMgaLwgFpKg1jyIAN4kBDRdDcCQDayWYBdxRI=;
 b=CLZNOyPiexINGPWCtnntt9XGFgwsJhieNJyRpXjP/OPnO536zHq0tJkr
 a2xAlZNBVb7LCdAiUFOJ1DBqciwbl4EmsYRNjnqnE/XKGAEw+nW1WXz4S
 ph/DQIUHKhEyrx0s5wGihsyUPpbGz7md5vN5JIsDJquHr4X1hDOjN/hG/
 WG+acGuzcG4bsRChamReA6NvSxcdzEJxSW2nQmtbi6xV1kb+uTm3pft7H
 VMdw4+8kTUm/YPNAJ5EzqZycRuQE1Gq6vx3tsURsPFhz+tCxv2PlkPeRQ
 oBmethjCuSL2X6X/yuCyYlhalCkFd491u0weION7mgTxmJr/7/Bhq5NT+ Q==;
X-CSE-ConnectionGUID: lp0p81nVTbyMW7dvmhIlNg==
X-CSE-MsgGUID: NFXntk4KSwqnsEOXPVpbeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4094394"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4094394"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:52:26 -0800
X-CSE-ConnectionGUID: AnGD4u3lToexP99xCw6vcQ==
X-CSE-MsgGUID: vmCOYsfeSPmZnIDxXyYuDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11018909"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:52:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 00:52:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 00:52:26 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 00:52:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URrfeZvgbe3K6LmJZF9H84zFe3PKzRdXf+Hjf7KRDMwCWUpddAVr0DE6XEu54Kllc0sE0yWwRAM3iyNuxcVZuQFzZygi/bMmS00Kl7WU7bKrU/OMD8StgHjnzylWOX8idatBc9PG95hVajFZNZA1c5zT+Nr0EGnZv9m2SCRLkZi/oXaYI7aDVftIHuMX0+DpgFTgiPX/lsCzbCyn7yhPT9stpzsH0EgfO4TGR6CpMMVpqA2RfuYshdteX/JC20clP2CUQOmzweL3CbYqrN57weDoKldWq9q9/MYcnFhZ7Z4OVwEfpioofzCV1wSHfm5zHIreyAZ84lW7jkl8AGH1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv9BvmfqXo5egRfFvbHvxEH7vL4fliM3+ewQn0x2XOU=;
 b=dRjyOowCzlGzB65wHQEDJzEXeaiOUDMUU5vTxouf5Fkk7BHXO9t5vb89scP7Catu6tYGiif5Ufu6+E9Y3ktuFYAosns06mHgzRn5l3SlGg9FK/U27u/5uHiPiStD+Io4cvB2GuoaltoCie1WYXOe8TubivPyqwL9BnwNNaewjlpwlpTUFtBJPsnwChhLwHLQ6nT1ZDynWYe7XL0eCrUDQk2MueDMZzd8+V/dSFnr4HLYfrPsOWOku+FGNMz13gxr25/7x0y67xAnaNTiobBYxlPnQYCHpeabeB3iA0/e3PspYnUlWk+FKxl4JuEiwRrVALKgfR3EPi54bOJtzcJdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv9BvmfqXo5egRfFvbHvxEH7vL4fliM3+ewQn0x2XOU=;
 b=OKh8+m+DMvWy/e/vGNQ9MtmkOlfrlc389QXxUhmyc/MDtHxWQT3vI7DBwVmmFVUDeyqUmYEb0Wq2nMyzXSg36Obr14RwhNfA23B4ZbCY9Wy9xZrho7iyD6XcsiVZh+7NT2fk9ckf17nxhiX4nX9rxPWrHlRn4g5FtFqvO0IjLuU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB7273.namprd11.prod.outlook.com (2603:10b6:610:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 08:52:21 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:52:21 +0000
Date: Mon, 23 Nov 2026 08:52:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>
Subject: Re: [PATCH v2] examples/multi_process: check return value from get
 name
Message-ID: <awP-v58K-uyZdhYD@bricha3-mobl1.ger.corp.intel.com>
References: <20261120191326.4052618-1-stephen@networkplumber.org>
 <20261122173556.105738-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122173556.105738-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:10:232::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 703d0052-5e8f-41b0-67fe-08df493f15e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|4143699003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5xhHldESdLkcFQc+uqCiismPQGaNwaxQJ58VDA6ROiPzVtSjBlw23QidqxAk0ziejif6VmEhuSp1QTBQai8nmKBSNb0DMDjfGS8+snqA5L27y10c1o9Xyqi6e63rfJ6ubUNvjrQcMOpq7bOn0cA5CT7K3P0nhe+/hRPwtml99mc7cd7LoTmGFR0hGDgJE7i9rLpwnzT7LaGNCXaBdbFLGLhQEJLQRxm92/SP3uZCHi/HTa8dOWyBhLbIKpP0BjvUhn7AY6bCcL5cJiAuwf7DIZSsXnXu3YjZmkQoEKslyOl7y04l4shF3mK9oGa8lJYGgN0kmzfZNjYrpCkqWkf12ZR4t5rt0xWelqFO9YvPLajtwwc7HIBYy5j8qwLHyReDAu8q6pNqM5gvNRRUUsSM7xOTV+QNmGvNPnAB5eQKo8pEm5bPLfLMsv42pYGgOW1abRpf4DEXKDnyqoWIldQIM1TToYIqTC72tcSe1ozxL4flloAmw43bcOIidVoAja6BHdd6av/klKE2o9PQP3cgnVWzwObvNLdhYWTVhV/CJabhgXYac6TejILD2RFjf/NQ7xlEUZYaMzpH2NUHyUC+47zl+vNI7uDTwCdqXEHXbQAPqHBVXKSFI2xOX2x0UGNzvHXJI+bsxfOGLvKoDYOE61snQE6N/aicV01tkHpfFk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/avKnmxcstOeA+DSTBZ4zWqVDR56xcEAywnDn1/duxAQUi4SEQiu/1phmSaG?=
 =?us-ascii?Q?b7SgdX/cIrDYKchRvlC8dfhAFuIw7YKrHUm2GqY4g6dIkA6ptMfRv5aQYOFp?=
 =?us-ascii?Q?61cB62ELo1onHVOVBhoKsmyrxpYe7ieAEE1XH68pcB+vfIhzCmwviRY/vEE7?=
 =?us-ascii?Q?BfFBRHU2ReFdgsikNA2ShJ5vO9Z3gtKRpvuP7Sxu6KgUUQwSmjP0IYCCbcTn?=
 =?us-ascii?Q?VnQDaSDo4XWrE7q62qdmXJ7XFT8BSV1JasKNeMh95afVS3hlJ3CwM6qTpWsr?=
 =?us-ascii?Q?GGHRlJdO0fWKuO+iXNJnTwNIzn70WQUEEaSMMh88nLf81uD7gPYtG/iiYvul?=
 =?us-ascii?Q?Dh9pqERunNBUgQCUm5DxdDIbpU+Gx8fSYeWJLzjlAhKnZ0vT9PusOrHeKlr9?=
 =?us-ascii?Q?BiavWhYqRr/hwyVjdTO3F+Tk3Gib5YLy1x6olhUiW5H3qygbFe+ejFjTqR5c?=
 =?us-ascii?Q?//x3t1hstbJORxlXHZl0Io2ss4rAgF540tI88OcYSsIWHiEmzDHR63nV3rNG?=
 =?us-ascii?Q?QvtCwWV4IYJxKdCTdvoVPaHHJmceKsm0LVDIRnK4AS/th+7/x720gHP0XK/Y?=
 =?us-ascii?Q?HNnL1vdx6kw4GODp597OPMCodSQttbhCONxojyEBGAfWZBuNgLaOYzj7HJAa?=
 =?us-ascii?Q?w+Qjc+6/YvTV70kVzc4wRgWmKcmPhe98kk0Zu2KZACs+74PuoIQEuUHKQr14?=
 =?us-ascii?Q?f7abX192ngipQrsV8JS2slb8jE/9UK4qMtfefxLgv32j795iBDcnu3piu/j7?=
 =?us-ascii?Q?IoYkAPibfgAZ5QmFVlfhwxIZ5hQAqywFziP5pYEPLHAiQrvOrgWHCRXEr9+f?=
 =?us-ascii?Q?4edy9/AxFD+jM4laycwJdH8DkA6EnOOOqxJsm35dv6Vzug2CuNamiQ34MQ+q?=
 =?us-ascii?Q?rtjP+IFO0z1/Kz6X6kEMvRP2gDx4upavSeNJGM0DB2oHZGWbuIaTzh1W0uJz?=
 =?us-ascii?Q?wtqYcXcRXwbLkxaSH9YyX4JmkNUj4TN0fGltYIcbKF8TnuQ5y17cVWRuKAva?=
 =?us-ascii?Q?fZqfuqoauhVuxtLlIWhrNDc9L9vq2fZ2WWFSiLJUlkgGkIZoNDG0GebIAOSd?=
 =?us-ascii?Q?LbfZytSMlB+Zm+Wdn4qRV5ltxthn574fn6UGFuI05hO+e9DDgkj0qwHyL5jq?=
 =?us-ascii?Q?fA6BveX+LHQ8aPOfK+AD4KI1uBOZ5MX4iFt5Gxa8HT4Kk9Dvsq2OzG4F1pHD?=
 =?us-ascii?Q?Qh0pfb+tlXK8v1DTrUFs7m/OITXBEOrYzGvnvF7ZtF1jH+bgYW3kE1VBptoy?=
 =?us-ascii?Q?6LleOFQVysip7v7DCOMm7Mg/fqSoe18ioDGuB46jcR2JezLsXLHOZxXbPBw2?=
 =?us-ascii?Q?ADVTxoL+a3qP1umb0i4j9tF8FmTtUQT/c7temcEIze4zc3+N7ci/SIGiZGW/?=
 =?us-ascii?Q?V5UgXxA22IUHUXi7aM+4VKZiwcZBcYREt0PEOOEMaTb9h1yZdRu1tEgNS7FU?=
 =?us-ascii?Q?LPPKqj4hXB5QunbIxDzFPkrVrdMK9OLY5GZ6iI2bTeskxOSHeiymtzc/rXho?=
 =?us-ascii?Q?PhPi8dexHRX0W8aNNDoXS92AdhcDThHgB6wkNHkqa72ehcnY1Y/L/YgRP2mS?=
 =?us-ascii?Q?B2UCgFjfL+iznOBkzgTlaytYG1WTMOjgXF9fNoW7FvFaW8YZHSPz5WG2MqFh?=
 =?us-ascii?Q?Dw2d/TSMwMPdfvM1JIi+SBAy1CFUay+rCcPwYN0Vpowv2B1/RFBhAcpIPPag?=
 =?us-ascii?Q?tl5wicmZRixqEmWk4LJ/+QsDNYz91oVGQZdjSogxuV4cSzwlmxp0lB9uFkM2?=
 =?us-ascii?Q?uQUdg6QbbV3XRCwoOf+UGY6btezRUWU=3D?=
X-Exchange-RoutingPolicyChecked: B8P/nkpf583sjX0wGRjbJOeUvtVHvoqdvx9BQ8wV0ofRFioTM/+8Yc07IML/fCH3rL4CxYeDeCot31hS+JhL7t8n4WhWfDWzGG3tDZuaJHgKHXVqjhGZTP5howya6LjwD+B1ZWRxg3qOPm/mgRnLU2ELCNAnuExVSROqA9hkN1mrA8zUbC6xlYa3PucMvGQZnAvVykVa2ko54xoz1qioU5bjB1ac6XSsX6e8Be62Y4nrHb1ykwavRCx1svNBMsyDVqYcfv8aAbfgbsljnI/dcsw6nYBaRjdR7Vu9Y8ntLKL23sJTskPBhN6Wnhpj6VeHmCQi35i+B3Z7fzLj/wugEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 703d0052-5e8f-41b0-67fe-08df493f15e6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:52:21.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxNwMTE7/Alr+fCGTBYUbBRzuL0805AZQpxjMDt6m/Qrt9l2EArkPEyVosXxcMB2HddyAJlb5+C4mo1uPSiX+d1leI8rHAVdw9hFWQ2Dfqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7273
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 09:35:20AM -0800, Stephen Hemminger wrote:
> Better to use the return value of rte_eth_dev_get_name_by_port()
> rather than depending on side effect of name being set or not.
> 
> Coverity issue: 511674
> Fixes: 05f1d6842fc3 ("examples/multi_process: add hotplug sample")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> v2 - fix printf format typo, and commit message
> 
>  examples/multi_process/hotplug_mp/commands.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Don't think this needs to go in 26.11, but LGTM for 27.03 merge.

/Bruce

