Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6985DCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 12:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B05640293;
	Wed, 27 May 2026 14:38:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 20F244026C
 for <dev@dpdk.org>; Wed, 27 May 2026 14:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779885529; x=1811421529;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u0S9bhq2pQ7ClU8Qbts5lgBD17Ji4oVGOc4f7itlKow=;
 b=NDpsHQITO3RGkJVqzvIveEzFu2JJHD+u/ewrdmc0xfuowp0nbrd766uT
 RrGnE88wfZ8/ElBdGAVDc+O2U22CzxWYeIGXHHHz42EQ8on4PtlA8THZ+
 p05BpnZCWANhGC79LqfY1O+1cArCFkYTuKZFy/tnNm5u7ksvW5OnnAEhV
 4/1UkY4NhFtHGsI9vDl0hNSOUNDsSjG9yw144cFL5nw8fD6z/qzSPJfxm
 tjlMR/LA0FS+ph5spG6xza2AJHOMxFWVsot27qECGcw+vSE0yZJJd9J7d
 8rHVciFeIQyhsg29FOvIIOmLSBfu/RXbWxOSS5tKb71Lg++XnBwKguKjc w==;
X-CSE-ConnectionGUID: o2qLk45UQEuuOpwvZhALVg==
X-CSE-MsgGUID: xLL6mtzgRMG27edhnve8yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="68236248"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="68236248"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 05:38:48 -0700
X-CSE-ConnectionGUID: ImculpvJTbaEkGOIr3/Nkg==
X-CSE-MsgGUID: 1JbsfgWWQEOj5BSRhx8Gdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="239224566"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 05:38:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 05:38:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 05:38:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 05:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey7nTJifzglIC7KLHjpT4pS0XOAdDRW//KZt5HBbbL9m4pQ+OYMDJOHdblXhGadhoy0jAQ0Y6ecw8y1B4hsrfhiDMqx7hhrcESWgdlZ5hgUolLv/MEvjEqX/qkeG4fHvGJjFTQriUZX6o/ASAnQL4NmFwaqYwPK1YIagi+vT+Cuf8J5KeX24/QG44soEQR+yZia9dzuWbQEaWNixD+0hWepF/j4Bqm/nEmjiIZgrAiTS0Nh15qxHP08X2xM8LphkwynUncYB4zHfcI7yDOTU3kadNPVVQYU2/l623fJIKCxJ1doDAYqc+MQpI4zhyXZvKUpxxrDL2lTBCELhIDRuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kITvuLYziNxm4F9OnSHjg3N7JS8TS/JQUKn/3iC9oiA=;
 b=h4byKBeEzoBXnW2wvLfMtGrhDPrehg597ywpBTr3FywfjciNZrIqn4QmOZD+C0K75AMG3zzS5hYThx1ieVbnxq8a9urMWOSoM6MS3+s6sy0/SMxnYCbfo49PGmFsxthAHhz2P+rler9X0Oj2z6zB7JSNUgSe9BwlIuvs+D5Ol0VgIlOHz7NZd0UaR0ccm16bbMU+kQF1ibc/ITpDfMZfzSqP8232kJtuZB5hKyHAhXUuCMiuy9leePmPod4oLZxhriUS8Uens30PXHNTH2SKSfbtIX5CGGigwLg4rQgERnxMUjIG5/rEavgD2l2/3XrzNKYqCBVlHPb9BywP99mNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:38:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 12:38:43 +0000
Date: Wed, 27 May 2026 13:38:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 02/27] eal/common: add token concatenation macro
Message-ID: <ahblzseYrHLNZ_VL@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <57ed806b6c47aa9316bd5af3154535439d39cdf6.1779717943.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57ed806b6c47aa9316bd5af3154535439d39cdf6.1779717943.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddd22d7-b39c-497b-b294-08debbece337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zWggoF5vUOptCfs7oUoMuJDWdYRvzPd3IwiJZDKrek83PJgm1yVrGi0p2b4kh0KklIDzg9xjTbTbaOEIScQTkr1OwyS6e4u/1JGEWL0hA5vCsMDuyl/6RltaBJ7yA+wSxVPpiQVObxYIC6VqftPs39RRQwFZnaXEBbmuXtptYg9CTMUSSP2bZW7soW74SYJpY7mWKng2fY3HQD4M+A9J10raIorb4lYAOrl7B/TxvVZ55RdUn2OAPtNA+lgPrcLvY4MPCd9/7/nxMuBewYCQaNjXAGnZa9QKqvWc/QidXgK/XzvgA/OiDaJSjDWRs0qMU2iWFBKuabLUfaMuCEgapRCQbYKCcR6AEA1b9iXrAHJ2AevTa/VPfqjb/+bKELnHusF9yZlQsnheCxGiw5WLwWGvPiGxdUyENBk/Lj95wPItCgcsEoG1EN+scl3tQVj2GdOujTpHsowxUVYi5Gc7Dy6N7y1mYW7n1Go9UnkiwnefI6DKEN/NHMm7i90amaMCFf0tTM2EHgwTWa/o2AhA3xAWOM2QSt41KpDeJO8xqXRQVc1OSvUmOvtXX7ERgDHElGbnleFyYd/P49B8EIjvJny+AkBmkJE3vHdr+Z1GjQXadWMmmfEvSSG2co/JjYyzPzqMv4cL4MYC9DhjRwYMA1MMuYvkDd70sV5/AyrbbhxyI5CSD8E/w+8XVcO2OVK1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5weYsl35Q9lrOZaNl/ugd5lsarNuSOc0daN1ldRSLuBZK1MM+3+soeDsTUkA?=
 =?us-ascii?Q?tddsXezJheiLsu0uuEgHR/sLYlMbC6ZGwuTWtqHpvYU159aLcGQhRxFPgR4v?=
 =?us-ascii?Q?fuDPXRhB7r/SFUOBrXwUoq1M09TJCgZEutPUmiRmFqjXL89tGGci1i7OeNc/?=
 =?us-ascii?Q?dcMtXxKrjGgRLEw2lii8NDdiSeK5YBD7mBg1ZvWCSpkABJFwDNzRzITurIFD?=
 =?us-ascii?Q?XNAqoDj/lD2bsi8B/vwV7DP+yGcafPMCIm/h5mdAU8qFJFgDMBsIdLnYGmDw?=
 =?us-ascii?Q?SRFOfl2LZM8/J2b4naItHLZKiZ6etmpL/jeeu3PITg3tJ67GlTFUOMKFfUcj?=
 =?us-ascii?Q?Uaw/yr8kc3NQzKgflOE7vs+NeJZvMmYNV2CxNFjcDXB++eZT+ZCsEscv6O9R?=
 =?us-ascii?Q?8czmhcEpuErYOBT7QzTLVJfRjSvLPo5XHE2eBRaqSRhPEKD13mazVqnmjFoH?=
 =?us-ascii?Q?u3ncDTrofJRzGlkNHuRVIwlIzycFT1b6ZOpRpse5wDkRzsNJ+9jo0LMQLADY?=
 =?us-ascii?Q?aigw2vqBizHqjLG6rl6y074NpdOo/4oDWxwWeKWLRRV+hYXE2KiGWvff/oIC?=
 =?us-ascii?Q?eX5IlA1jvlbMgZ1szjD/tHV189Lvj1C4+SR2X/ZkYMjj++g2oMJkiJVd1v5i?=
 =?us-ascii?Q?rF8nmXjendjsKHVN7UJDh0rjOFj8tF/99T5WP8ZXc5z9f1Mzl4nFd6Xle0MB?=
 =?us-ascii?Q?vqfWyPTBMneWeQoEsnTP1lK5XqLELoiXDizdGnYHkNe5QJ/YRPAEq7xHDb87?=
 =?us-ascii?Q?1OETBkqVjTLkXSN3T5w39bZfp1IcuhorNHQyYbeWe6HJOrxTkriyqwwx37/X?=
 =?us-ascii?Q?itVL0LCF9fFKbxsgrDUJJ8R00nrHgiXlW8pETqIw7ZYz+HTSTRklDMuFhzv4?=
 =?us-ascii?Q?bFlRA9rEmvU2nqyggLhV7ii8cRIMzNpq1rkxOrI3vMk98NUZ02JqxrlQUrGJ?=
 =?us-ascii?Q?KmgBVKrgPq9qwSnuS13LmYKtDsXwEziRE7qZwl466/fGCbrSsvV+oS8q+IU7?=
 =?us-ascii?Q?et9JrG2yz0AoHlvevmwcL+c52Vjw4lTM76bBWqr1o9qPpImH1NGFWdcNUT9O?=
 =?us-ascii?Q?GszH/2TmjDXTiW+Zz2GvUONiGt4t+PxCZhkSc6hG/CjFc9Cpspcf3kdb02BQ?=
 =?us-ascii?Q?cqr8QWE34y5xqsDAIlFzDMs7cjTqkcX3if31e2gvsKSNP0yHrsAGXWAfFQXM?=
 =?us-ascii?Q?hdehDcqozQ4YzzUvUJ1hIM1iPIIBtVZG4xy7J+oAaCWhDoMQEzfj7KaxyxZs?=
 =?us-ascii?Q?GXUYWVZGD0T7o5Mi3e8yF1gMk5Vjs0TL+Y6U6ULBaf1+z/2rY4uoS0Rd8gIe?=
 =?us-ascii?Q?oaOz1TDP8cWL9cv94CilV9yZrVyL1hoUvpdM59y/sWRtq7XWQdYIawPBUxHZ?=
 =?us-ascii?Q?AkxPsZ/2qI0fnDvp1nAavKvB0KYOqyPrOG+3DMjulm64JiiscHpqMkIZuLED?=
 =?us-ascii?Q?2x6QwYJMz/Wqt2WZ112i9egQ2uMxY2dKs7pmIKtoI9Ac1W3lTrxqyXymK8sK?=
 =?us-ascii?Q?1vFWjJOQZ5FAbvN3BivAhLFp3FalgqzifMzvv4BDD+d370RCQhWYJYaFoJC2?=
 =?us-ascii?Q?FiU9Cg61qFzpmAJTQvdc6JAjelIm6rIlUzVcv5qzTYm8TszikW/NVhOMXjVm?=
 =?us-ascii?Q?3dkdCZtm2T8DrdVqodaHhGzxa1M/WTBuWrQ5I9RKsG5KGYfBan98hVEaE0Dt?=
 =?us-ascii?Q?WAgowY4FgrVenaw12fqbFyRwo/hsOf63aR/b3+XjdG+b9bKv+3PGOxLE/Nzb?=
 =?us-ascii?Q?Gml8Q6Yo5iE7WMROVxiGElLQDDfOikQ=3D?=
X-Exchange-RoutingPolicyChecked: F3okUClFphgb78lvLxb5APowOJvLZ0B8ODP/k7wM2cquTKQNsb56hrvtPMEYA2S9BvadEkfzilqj3580OdPtCbNZrDd7OL3dvFnUeCuCOQxPR/SbTDdxCJHDCScveQCX7M6Q3EvOFtPnqyqhHDHJqofUZupUjQXYGIrdPFHDAtdRZ0Aou4Iyt90tduSH2D2umXMMkSo9PH9fc/6fXRq+XHPu+yXGQD3DbDqR+0bneMrhDavwLsRqGWTJCwb1aDSHzOH6E0ljGiT6VIw18dfGVQjHMI8KkZgkedtjqALUVMBp/iZT9zCot543jOG8GfEroxa3DtXUkniGboeTKYWuFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddd22d7-b39c-497b-b294-08debbece337
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:38:43.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0f0BErG4IC5edCD40VPIEpO8nae4NDsRudAqeZAbTx/GqR1WkjULa2TtgxPYT0pz+dmBOuvCkZotx9kvD3UryTypAYxt6uU7Blu3Y3resA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
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

On Mon, May 25, 2026 at 03:06:21PM +0100, Anatoly Burakov wrote:
> Add `RTE_CONCAT()` macro to enable token concatenation with proper macro
> expansion.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  lib/eal/include/rte_common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 0a356abae2..05e72e500e 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -918,6 +918,10 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
>  /** Take a macro value and get a string version of it */
>  #define RTE_STR(x) _RTE_STR(x)
>  
> +/** Concatenate two tokens after expanding macros in both. */
> +#define _RTE_CONCAT2(a, b) a ## b
> +#define RTE_CONCAT(a, b) _RTE_CONCAT2(a, b)
> +
>  /**
>   * ISO C helpers to modify format strings using variadic macros.
>   * This is a replacement for the ", ## __VA_ARGS__" GNU extension.
> -- 
> 2.47.3
> 
