Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11CCAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E51440288;
	Thu, 18 Sep 2025 09:50:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D8DC34027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758181848; x=1789717848;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8yFEYXIT+0H0UiSEiTUZ7dU7LxS9BfkIrpelRC3ai/4=;
 b=jRObl/FvMl1ii4usDyQ/hcv3UMdr6/4mooa8Tbn/d8xodTqSuixnofRW
 oy5ZU/F1lhCxLlgtU9bhvTi6p2T0Enw8JjcrEQLIRbsvQkHvcowRezagn
 TlsZKgU8qibBmar/dPuUoQsO32PJIqZwgSGyJ+VveoxE1+DrAXRv4EpMM
 PBdN4iBrGlggzl7NUae4ktovVayysHP6tozE8dNYJwZkbVHXGUofMDFlB
 8r6y12zUMmsYw4ODQxSy0RC0d6UJFeQPjpvuUbs9OpuTxaimGS8qNG5hd
 rmT7WoRrFvwpYirwPXvosCrwECqSTD1RdttHlAeIUp5UVn506bdUQc53l A==;
X-CSE-ConnectionGUID: iOadIPHXTJujtGbRXpv+kw==
X-CSE-MsgGUID: EnIjasAfQV6v2NI+q7yOZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="59721643"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="59721643"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 00:50:47 -0700
X-CSE-ConnectionGUID: t6z/90DfRKq1SAQJrkfjwg==
X-CSE-MsgGUID: gwCMr29bTrCxK8qJPy5foA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175387840"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 00:50:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:50:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 00:50:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIPAFCYcN++TnF33IxzjU9FkKgoVtD+4gAYyWBpveWiqtrilpRajIp02SZzyu/6uqgVsIhe2DCTwDq1e2OG1ha4jL6zO2G8ZAI/F+Crh/Fbdzxtw8s7SmZ3HWkdjNUIbR6NVU3Fv/96UV/+kNbI1OIlV+Bhd45kFGAsmrI5B87XIF/+6bHW+Ihmgb2vnYl6sfA8YsXPK07XIVepZMn9YB5oEIZTJlbQDPshAS7vdyPznzBioEEuxINOn9mQjdInThNlJtennz1TEDy3hAPXCMlyjPvUtzC3Us+8uUvY33lMj6WGMtjFzJojglccmkDufY9Tb1c/P+n40gzAeR++XCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fOBP7zFlk5FhRiqkQh76hYZxlDu9goxoFSkxUpebEc=;
 b=LwTXBmWRxIRYaTLvLCA5+OldpXCWAAeQ0ai9d0vi2idyrx3yKusgGlkIchB2JJh0ielqUZQvVKV/TT7E7bVQNN3EKx3hd0GqsijkoLijoxKfgsPP6zdhGDqRmcYNUxMjp9nRwN7vHdOBlrgqCT2u4+T9jn0wH/PDBaEJfeWlOOjGExmzJX7agX2b7ghkbcKTah22gydF4kY5WBUgHujflXDmufN5ZXTi5h+ZTOfTLaQ/6lsbK0uw8r6ZpdYcMCTSs9XbiVZN/lOgxqYcsLAn07BKGp2aCIOf1RpxxlP3MhpWcO+C/mleK9rtx/2KHQD8iWnmH9oSZcziIu+lyo2ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:50:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 07:50:42 +0000
Date: Thu, 18 Sep 2025 08:50:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>
Subject: Re: [PATCH 3/3] member: hide internal macro
Message-ID: <aMu5zX0ZyVItH1IC@bricha3-mobl1.ger.corp.intel.com>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918073135.1273767-4-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918073135.1273767-4-thomas@monjalon.net>
X-ClientProxiedBy: DU7PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f06590-5813-4be7-4958-08ddf6881147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7JV/4G9nCkZ6y3NP44YWQd1gQUaLG6aXhebCt1hKSPiXr4/K+NUIEolPqtEf?=
 =?us-ascii?Q?vm1OFvpmRwe+/Z3kEoP+OyRwRsAKUuaqGefAAoGsWfrP0bBv20ax0+cnEboY?=
 =?us-ascii?Q?ijpS3KdOqjeyapfGk4NF8dWjWBy6adGDgC3sTgG2sdIfJhbf3h85BHIObGfz?=
 =?us-ascii?Q?DuORYwIhndI0XycXM/bb8xLmBl8BPspXt04BHcmhdl4yTOizGRzMcnmF5u6A?=
 =?us-ascii?Q?EWP0Fe9LXqCJbo4PtlCzv3s2qUWjinjeglyUg9Z8GrdQ4cAmf5GGqVa2UFVe?=
 =?us-ascii?Q?AZrVKdBB6zIa1PTmhBPAGHWYZlthFO8PafAH317EVirbgNNNxGyZKB3IN8sj?=
 =?us-ascii?Q?GF7R8A0yIfZ7dfw3xliOcqHXsc8enkibmytq+5+SdjhV1S0la28BmHjR6FfR?=
 =?us-ascii?Q?tl/Xga7VlQWomqsIMLjSJeqGj8fwzDLomxyMzYAhAdcqGarVdkpInOb0ntdF?=
 =?us-ascii?Q?N+Zxv/stq7NqggqrLM57AL519tEaDyWS/8prm3u6+pM87bdPG+Nyj3ksUE65?=
 =?us-ascii?Q?crygiFKD5GG8ywMDfp0Me0yEU+eAHleoNksoAWrIpIAu7GR1a9OIJGJWoEwn?=
 =?us-ascii?Q?vLW4djtZ6hXFDLJq0Oex5hXSYg7GsgGFPs7HC/85JE8O2FIrbNvszxswad7h?=
 =?us-ascii?Q?LvNfYd4vZ0Wml8BKQNsSkGG8Pet0f8nsLIC/yOR9Q28jkZn+FJBuxXrmmIMf?=
 =?us-ascii?Q?590fPAjuN23VG7Bx0Ml3u7qo82h/G2VwNBS/amTbbZHqlG5cb7wdv+MMCiAC?=
 =?us-ascii?Q?ZLyNBmAZSpHS93D77g4V2maOYOHXCWf6RjFiLMDdd9EloJaFSAjcAz/NNCId?=
 =?us-ascii?Q?f2DAe+PKPlD6sIiGfZ/HVSkFUCOrzzu4BHP4gMAfPuuqI80x0EjsnOpBSveD?=
 =?us-ascii?Q?W8inirLaEFgN/jsA1aU3qAX8eJayEbH6cjxtmGW81ynK+KeCF1s1Lztisass?=
 =?us-ascii?Q?pr7wtX2uNBfmBLfMZYJYIB2S73YPhUKZL15m8222rfyS8bgk6P9oIX+LdZfA?=
 =?us-ascii?Q?mV+rQuQThIT7o2BNfErz+NYVHZLTWERehpNP1Kb0d+fgLyhaMRG3QVSeZf7d?=
 =?us-ascii?Q?EWRt9CW7XpsUIsedV91flvfDgR+kv76za3WqXulVFgPdAUAvfl1jG0jvDF5O?=
 =?us-ascii?Q?0/6LZiAu1QRCfRgDbTWiyJ6vwf4WQzb+PgEJQJFQtAx/7q5Mr65pS+0e+BUL?=
 =?us-ascii?Q?jjXofne5L+i1T6Tn5+ibgps6xC3yWciALmVJdYOMuS08Is/LxWCOwyTuvctv?=
 =?us-ascii?Q?MqCRbOFF/Dca8u39ewZXIbuyse2Po4apVfoZaEeX0A7f9dqvkWQGjd7yBOUi?=
 =?us-ascii?Q?PL/6fXXe1d21M9AIz/OwMazmwSuXFO29Neg6mK+XTo3HfaREdig1GpT3fq1S?=
 =?us-ascii?Q?ObXpxH9YBzxcP7cq7ym/zu8e+KnV/waAgHVZgyX30oiXqBrWUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVj4bI+HLofpATa9zKycTBST4bhdIoDg+jFLLywsfZuq3aHBid8e93l1hr1C?=
 =?us-ascii?Q?m6DzUl0D8DiCIy+kMqiyqleiyhWh1I+fMakm57CcQhuYT/qbhuHYU9LI5L+A?=
 =?us-ascii?Q?97dkAHMHwNTTwcMFp3IwMbvQjF32c9SnMlX4fM+j9YjjjVQRiJM3JJOuA5Hg?=
 =?us-ascii?Q?yPIV6aYKCKOXj4aUPGbSvK1afwE63wvzYgvqEbZ3hqVaQ8/bI2whifVu+ebG?=
 =?us-ascii?Q?3W56Z0YybfD+swgLNPIHdgFLCispHNnXOGiBjlcc0DN/emgQj1nKOxMymIUk?=
 =?us-ascii?Q?i7bx7vpX4xXGUrYPx1jQlNoK6mGho2XAhpedcFQBxyRn7RKLYBAGEHGHhxNC?=
 =?us-ascii?Q?rFi5ZdJzBSQMVsaPm1bUaNCS2V+c+BqX2ToMkVvf6c2R8UpmkoPJRX9FO9ZJ?=
 =?us-ascii?Q?DYCi0PJv1cUcyWMAGqE03XOWIXYKiv7ey2r3BbSjAPNa/ziy9D1I49+foJUK?=
 =?us-ascii?Q?++QX/netVb854l3U2fPLxsnTYLBmWjaf/kfiZrhOyv0iNj4mE+fVzoYG4k60?=
 =?us-ascii?Q?XvabJzO1NdREZA/e1HHfsKpyP0eWFIgv7qEGYSCNQV76e57SlE0BcixeVwc3?=
 =?us-ascii?Q?Uwv77n6t8R1xflXMz4AeCHkoIO3xARyh4qZl8EjlKAz6+2NZ6CEwSX/AEcok?=
 =?us-ascii?Q?yktZ6Nhw8nQoV3RLASnqGcQcQszWgu1a8gKHZirq67MctKaNXoE/BayGL3Np?=
 =?us-ascii?Q?0pIXrl4vtiw8EuB2B5Jx1FfzGhhcSE9199YJANUzmIq1uO68ZrNnMDzwxP7z?=
 =?us-ascii?Q?3RV0H3S3IPe+dTE2x2x4AnNg7+ehpBhBcF2TzBHm4R56DT0CVUHs6tWpQGAf?=
 =?us-ascii?Q?lcgb8jh6wNOhlYju85vvYer0zR9hwfMTgxg+wSUSQKZlJKE7M3ixU+g1Fj4P?=
 =?us-ascii?Q?MWMyn5QOSppksYzBRGZEllIc91YTMQf+w76V8FYmeRKRx1NirIuJGjZeub2x?=
 =?us-ascii?Q?tk+XorJ3IvmW9+qLDj6xAjYDBpkeyHU87HslklHvIVQYMDTd/U+76MgHMNKp?=
 =?us-ascii?Q?JpWcEgBrmbAr4Y+DnxMzbdqg0IKs+pOYcLfFjAsLbnCo+R+Wn6iD0aAonmUV?=
 =?us-ascii?Q?QmWd6SHI+yOqPTAAaVYno62Ei2yDwfZ6YKXCBtD12ugBZSewM1yVuS7dVY54?=
 =?us-ascii?Q?JK9fHquoiVnCkxW+QRRp7w+qt8T1U27ycCF2qRM9xF8OKopeD7YEKuDLP1Yo?=
 =?us-ascii?Q?WWA/6V6MjmJlK/VPf8B7JtYqcEiZweVUrrdnHlqgZrmR2WsUEvYMPnao72+f?=
 =?us-ascii?Q?h3DPux56/Cycc6sTtv2rsek/fG8CW10gZRB6uZqz4+KAgqZWzHt6Q2MuXn0X?=
 =?us-ascii?Q?KT7YF2A5XTrlCa+dAvASkdqXPvXmeT+9YeyDZoQurOIE+PKaigIygpWF0e30?=
 =?us-ascii?Q?oG6UfwHT5+SJkfCZH4TB6OpzTdPTEl58AUOCW6YCUW9FMenlmORzhZiDQ55y?=
 =?us-ascii?Q?im0ytwhdqi/dJBJo4VPX3Q7/N2Po7qcGq/oeO+L47zJLFsgbkuavNOQzAfa1?=
 =?us-ascii?Q?MXiX4Ule1DQQLRiYszd/OupCqs9ZW1iRqiSmBtz5InptP9W1ob1U32UdNkpt?=
 =?us-ascii?Q?+NONjMx8dKTCWcQ3xrMjTMxJFAEb0B1hgzljY8bh9tV75iL+yjZmOCWz2/56?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f06590-5813-4be7-4958-08ddf6881147
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:50:42.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCs84jNzssAfowdjFBV1Hx+eLTEiA8jv80ltiGSM2f+5LU453DgyAOfvihs5SJI+JdtFKZujqgviiRtoS+u9R9Qvn9909jcwmsBTb3BJnoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
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

On Thu, Sep 18, 2025 at 09:28:05AM +0200, Thomas Monjalon wrote:
> The hash function used by the library is not supposed
> to be exposed and be part of the API.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

