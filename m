Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CCFD2E038
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5EC640156;
	Fri,  5 Dec 2025 09:23:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 22C7F40144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 09:23:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764923022; x=1796459022;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ghb7r0+WuSzoNp1W9nZBo2uuqWUwHo4oELwg8hPUEHI=;
 b=iqUHQfU6Es08LYTd5IRfscsvOFsEVAOb3kV9n6GqGNlCvcByy7JsMvnY
 1e/zz7BdjpJDG81vTXxyKpG+dOFf9NVqBSnA4GDf78197RCp9Hm/J9mo5
 440ta/bAS/oeCZkhkF6ACXPhsZLQHRCI2c67h+n8ggDEzGTXvV8zILHnR
 Mj92IouhcmVs18JbFhbk0j1Tna1I4pf29pu2jVFklN0xX+2CVJrD7HlyM
 T4fC8djuOMadx02d9pnLK5MgikjRFLcLcacGpJovKqMjOYxKDkHIss8Hx
 Y9V3vVal9mwZZjsNgZZtTA7UZNIMNKO7BgJuugiu3D/78FFPmGVjU5+Sw g==;
X-CSE-ConnectionGUID: JNugJ8a6SwOe64faILh5zQ==
X-CSE-MsgGUID: RYKvx68PRDa/mSDzPBzHOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="89604954"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="89604954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:23:41 -0800
X-CSE-ConnectionGUID: SSDtOgSuRQOvTGg+efofCg==
X-CSE-MsgGUID: CdpSJj75Rt28oVyzeEKGRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="199673948"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:23:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:23:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 00:23:39 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:23:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUe3y5BbEb9yNyir6Am2/bbKkPSUBam4QM0m5gD+e4oW9V0xeX8c801QQjM7WYOXiSZNdL5iL4yITGh70ERN48PJcpZLhUdkHrX/omRbIGZDsKcI+xObE/Exl8zTi1h+I7QXEEtVRNm/MCRCGX6ZpihvXQOiTsF8O3gmh8u6dAHOwa2PHsUGL0Rb3MMalSOtzXdxVtgw1skNB8XJWvF4LVz8sN3TqxLo36R8yyRjGAho2RxNrqw7BJWtNktK7TsDd2VGvGDeKtfZr8QYC5BjCSfj+s6Et0F0I5/7PaWLldtCx7F6eSW4TtVJ36CQW0XR4JQDEC2pPKCeJPvAEFCZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJzogQNJgJ6siapqEwWMISDFsPcTWNAYdntpzCqPihQ=;
 b=QMfIpKQzKUL7W2TWnh9avn6BrytFJseWl85HpDSBuH34HXBCLvDfjen2fhQB3D4aYwWtrtfdT7OjIpSAcLGR25HB41B4vb/1BCDZDg19FrURCRglHB/3tXHeqj5UqrzCy2/HxtvMrubyf5NfmoxpmmQE8AJCiksbOqL80O5JsnQI3eZ8ru4Aq3FcTdBIExHOINe5MZSzn69z9pLbmF5zaEQymi+GM/LxJIun0Q9/JrRNQmPxifamJPxuv32Ma+chgay88doOwRR5W7ZBYz3lyfztm6MkaVuLckOM/a5Or3/3Kgg1ic1UCH5/HpgvDNd/MuvcucOLwVI8MCJkAk9SYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9232.namprd11.prod.outlook.com (2603:10b6:208:56e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 08:23:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:23:30 +0000
Date: Fri, 5 Dec 2025 08:23:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: luyan <973788536@qq.com>
CC: <maxime.coquelin@redhat.com>, <chenbox@nvidia.com>, <dev@dpdk.org>, luyan
 <luyan@cmss.chinamobile.com>
Subject: Re: [PATCH] eal/arm: include rte_config.h upfront to fix ARM arch
 header selection
Message-ID: <aTKWfGo9O639Y542@bricha3-mobl1.ger.corp.intel.com>
References: <tencent_0AAA93B91277A304E5303277E262EB7FC408@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_0AAA93B91277A304E5303277E262EB7FC408@qq.com>
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f375de-12fc-48c2-d619-08de33d79296
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rLgzbKZB74QbBJQFustSz2CnErkqTr5jOxIZ67bVQUpZHO+AeLCMZDcBfpcO?=
 =?us-ascii?Q?CR/hCAuRrqLAcA2FvbBPc5tDi+geBuFGwZxiy0CvvVvB/7r/AfPHOZnsWxmV?=
 =?us-ascii?Q?veInwa0yuOpHmxbRuAb5aXqW1vfgbJaK36l5hUgblpxTTeuW+9C+WNV/aln0?=
 =?us-ascii?Q?lQbezEhwNCrunocq76gxqtP7NYUXiietxu3Zf+Hf2FCaXg3w4iqeEdZigMn1?=
 =?us-ascii?Q?OBlIGyagC9ncBiK72AqH9yMcR3A9Ix+DaduVQeVoRGuh93v3ijbENUbtrZmW?=
 =?us-ascii?Q?bezJX/RVw9m0Z1KNUurcM5Xa4rFK5VZLAxKTeI4p8bemfNMy1LVgi8VqJIRM?=
 =?us-ascii?Q?gBka5IOdhHJrBG53bZIaO67vZb3guXFoEuLMWfgH9ubd6qJ5rab7il9e0yMI?=
 =?us-ascii?Q?NrjrlMQkKAltZRXBemoBmD5lmjdSTUNi/xCrQk7bXuTPeTJZGDtHokINx7cI?=
 =?us-ascii?Q?9EJs28BHD0wLHaBajm/CoeIkAkXX/hkcEB9Ll8weewTv0qK03QkA5O7NPuYZ?=
 =?us-ascii?Q?zBqeRCLEvEmz5StQGhq2PxXyqtaaBtVsqQQjV0xNbFm5C/5gRrJRDEeuxwiF?=
 =?us-ascii?Q?1g1UgXs0h2c6TcfsK62j2nSZoooRsk6FlWtD9uOepCI0U0YCnlRJsW7yWX+5?=
 =?us-ascii?Q?/Kgs0miG5GQfF+Flgqyt+PwcyFKF4HnI1oxG9Ea+y8uGL6sX7yxdtQ/gmeQj?=
 =?us-ascii?Q?xI33T6hU+fCEMwwXOV3B+bw0mq7SLKL2mGGCPCOeuoHd3+7Rrqhnv9/B2xFp?=
 =?us-ascii?Q?Ywzx7o8DgTpUncxIygUlOknPsDuf5x5zL/QF4yM8bHCbVIIXm8ZoGDYV1Wjo?=
 =?us-ascii?Q?sbVXd0NaPi6FPVoWU+TolyHICEMfN+FHKAukSdZHZC9/dAyHMaENylOHnSsq?=
 =?us-ascii?Q?IkIuoeAR0WLBAlAeUrERq9n6NEwQArYjTMkRVQJI7/qyAFZzRQJQZ0hYEUp3?=
 =?us-ascii?Q?qzspFgYXWKPBmaZMS5JKNjJEWW471Fkeys6HQK8rLUA90bBXa2IHoQAesooC?=
 =?us-ascii?Q?MfvTUCUZuqXNo0CpKh1W5FcYzaGPtkbpV+aIGeA8/pk/k0B6PNiw83N81t6M?=
 =?us-ascii?Q?+cLvvW3f+5tbe07NLR6DW6h4kMHLIB+lGIEV4UlsUy85nBAJ3D1qpThU++gI?=
 =?us-ascii?Q?ujRHpNzN2qcddHF2Xz7+n/psngQDPASq1SHF2fNtJWL+VfxsLpGqZi02Ah+q?=
 =?us-ascii?Q?mXKOpACxSCxywlLBZSlqoOSHepo7MEOVIuc/aU0edJbv6+yBJgZF7SM0UEPi?=
 =?us-ascii?Q?xjuB3CdioOhou3rhOjWg4DEx7i7rsQrTQKQPUw+aHppUX2jpPOoOvmYMRSfU?=
 =?us-ascii?Q?Mc1So/lNvYq08yXboAIcZuHEncxywIKcNEGzCnGVGH4ysyJDs6NEQ65dJ7r/?=
 =?us-ascii?Q?n0NUmH3qVcgEPj6udjj8kT09r6Abm68DOU6EYjhDvZLSOT6M0g9xtHU5TqGN?=
 =?us-ascii?Q?VrG+PloT0qfnzvP7PLyHFJpbftLGC6H6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bB7yQYn3NShUSlmICTSHa78N/W8qXXSU8r0c5jvjRbxDfuexHanjp3Fc93uZ?=
 =?us-ascii?Q?Djm7J95KT5ZfGjjOx274yYsv0DzTOJJM4ruPHm24Ouh4D/jOeTxlsCCdbtIO?=
 =?us-ascii?Q?mYBfyEjeOdUZLPOBmmyhzTYpRXTRufO7wZCltvriGc1qd1LEemZW+e13iv56?=
 =?us-ascii?Q?fOEfefR+ZBOi7I8YOQy6Jdm3uxb0koYVqzlI8OR2ZlzN1JD6CFaZnSa5SWUm?=
 =?us-ascii?Q?EMY0Yr0EegeN4o3meoAmg91cd/qy0mVeXFofvNzv6kjikOZ1ZIMaWc/5y75n?=
 =?us-ascii?Q?Ef1t5XUZ7FgKLZztvR9SNIOHCI5UXxdAVA0KaQP/77Igb+pgVSZxy/quE2Zn?=
 =?us-ascii?Q?7zqULtzXW5il6qPWDodOzPJR+anY+BrwyPgpuczPWJtGZ0/Hrn4J700gmvbG?=
 =?us-ascii?Q?aADJqw5+szzf14wYxXfmWCjsLfDz3WjYecz9DgpTOe62FmG3ONZO6l1z6Wqd?=
 =?us-ascii?Q?zbiTzTRHpXhO2+4gbnZnzZpYf39PYEPQ3Gf1/FhlAQ1z4JBmlbmhfvCyCCfD?=
 =?us-ascii?Q?D2kBccJMPn+ccXzl8Vb3VoFB6jBmJ2JvX9WAVxIbywUEBlpKNbFSYQi2KhUH?=
 =?us-ascii?Q?I3m1CKske5r1KzPFBdJ/BMmPj6foaG7JlcxODNRxp0MUkAxIdA3r7TvN4C7w?=
 =?us-ascii?Q?c1kZve8JjmBfhdo+GWm+Yq1Ke8VwGycjtShSASY0QN+mGfoN0PFSFFE7WoUg?=
 =?us-ascii?Q?36VInPCfHyw0nc9yoDb15ozFyDQl9oMx6x06Ks1Z15oGnHwPw8HUoRgup6M5?=
 =?us-ascii?Q?rPN190zwdjPQGnTbEv3McWPMUdD4LCR6cqpc4jbJudfGeTRCxTZ9PY0sUqbN?=
 =?us-ascii?Q?/W5BbkkVaPunUVHmHkmcZcao6wvSqgafq9TR9cXdS+X62FJPffCTxlGKogWQ?=
 =?us-ascii?Q?Qq+XAddfhfwoptEG+QxS5k4r1jEDursN2TOy0J+0lsg2KpSkvdbcQMJQBzjj?=
 =?us-ascii?Q?6gYJp9GihoJAKE8+UNXzbszOChKIHM4kgaoeW0ooe1mSbgRNBMJRl0bYTfWk?=
 =?us-ascii?Q?wVFNBF7kqj6vXCHchG0md3ze7/qAs4jN6jTsLAyLWB3HHY4IS2BG/7/EH6TE?=
 =?us-ascii?Q?RnTIXNCINpaZlF4G8RVwQ7E2vmENOERXmizk+dd8HuI3Ex5cQlPp5upu3RJM?=
 =?us-ascii?Q?EG2CVsn5ASl+2Nq/ZazXo5cbwxwRy+RPwMzrwbjwTh/O4TEejTZTqwn3BnDW?=
 =?us-ascii?Q?IxjBMQGwWqPPB48gPw6hg+1hKBaFsdUB29ZWRMnpSwyxa6D1Ern7BNl5OdwM?=
 =?us-ascii?Q?gd8FlhyxyS/K9GmEZEvXnuf3WWPZcD3xiU/scufeI6HoHrv6drcPOOkCp95h?=
 =?us-ascii?Q?0hr7Vz5zKxquxRmjZcB2BeaC4/U+fgGrhXBAaJt7wR6Rh8hzXHSq4U4lV/ba?=
 =?us-ascii?Q?aiTDmSKeQJdPdxbFFSvpQkzffi7Fpn/U7y3BpBmnaFeUAWFBpVF8jyAfrQjE?=
 =?us-ascii?Q?+xz5KBRiOLQwXdd7i/hoNagn2FvqWzesSTtZp/gEctRTqpzjHXjoU+iuHvAm?=
 =?us-ascii?Q?9o5hOQmGg79mrgb6WXnAFgXrsn7mdM8IIjjXTmLJRzlKDJ6BUfwPGZl/lo6M?=
 =?us-ascii?Q?pju0YBqRKt9UKlbKPfbZwGag8Zwp78tCNv0fTSCj4OxH5Sa+IZ/yzxeyd8N2?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f375de-12fc-48c2-d619-08de33d79296
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:23:30.5485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6aqs6klj3WOUfXROCD8AS34y0PISUa59QjqmVWPoW/TLw5x2Xrm/JMiGpUwFQRwpdX8hYh0WJHwUigFJrR+CilxTH96/WGN5nzAgx6BSmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9232
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

On Tue, Dec 02, 2025 at 04:08:49PM +0800, luyan wrote:
> From: luyan <luyan@cmss.chinamobile.com>
> 
> Fix incorrect arch header inclusion on ARM by adding rte_config.h before
> architecture judgment.
> 
> Signed-off-by: Yan Lu <luyan@cmss.chinamobile.com>
> ---
>  lib/eal/arm/include/rte_atomic.h   | 2 ++
>  lib/eal/arm/include/rte_cpuflags.h | 2 ++
>  lib/eal/arm/include/rte_cycles.h   | 2 ++
>  lib/eal/arm/include/rte_io.h       | 2 ++
>  lib/eal/arm/include/rte_memcpy.h   | 2 ++
>  lib/eal/arm/include/rte_pause.h    | 2 ++
>  lib/eal/arm/include/rte_prefetch.h | 2 ++
>  7 files changed, 14 insertions(+)
> 
> diff --git a/lib/eal/arm/include/rte_atomic.h b/lib/eal/arm/include/rte_atomic.h
> index 40e14e56f7..c329b18761 100644
> --- a/lib/eal/arm/include/rte_atomic.h
> +++ b/lib/eal/arm/include/rte_atomic.h
> @@ -5,6 +5,8 @@
>  #ifndef _RTE_ATOMIC_ARM_H_
>  #define _RTE_ATOMIC_ARM_H_
>  
> +#include <rte_config.h>
> +
>  #ifdef RTE_ARCH_64
>  #include <rte_atomic_64.h>
>  #else

When building DPDK or building DPDK apps, rte_config.h should already be
included by this point anyway. We pass "-include rte_config.h" as a flag to
the C compiler, meaning it is included first as a header for building each
file. This flag is also included in the pkg-config output, so apps building
against DPDK should get the same behaviour.

/Bruce
