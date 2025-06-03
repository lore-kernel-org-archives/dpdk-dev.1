Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:59:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AC3140E3B;
	Tue,  3 Jun 2025 17:59:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1BABC40E39
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:59:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966367; x=1780502367;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Nef2I14Ahp/Ha+NkomWfI1JGLYmcT7Fcw3Ijov7jdSE=;
 b=dO0TaIDaJ6GAuGSdAdYd0Q2dX+2GfoIQp9ANhDP6TrnozjUhvxez42NX
 OqwJKupEaf9kWjtYp/2hjEtXMYXIshMP3rfA71M/3Dr6XoRYH7fAhisTu
 QscwPsGh05e7ud3ltBzyckbCrhbcqV0RfyUodpoC4qWwHMnnlwOALnDyW
 l48vk6EZyHPAh6GiEB24ho0Z/VN2DVgfqoD6kFUHyOdSPJ+L345ofD18D
 OGCna4vcdwu9c2GgvO1JFkflnq9S/j6RRw2DnSW6j6ximjreqYahkEO5Y
 9k+3nKf0h+UfgSSpTSP+5f4OU2jEf/lcSF6TB2Xz6v5qOCm26QExNupBW g==;
X-CSE-ConnectionGUID: HxgEtZQLS2eT2pSoJUJOsA==
X-CSE-MsgGUID: UcjwtOBiQVCyCA5Lg+IiLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50254550"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="50254550"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:59:24 -0700
X-CSE-ConnectionGUID: o3IRoUpdSjius+qb+rDYQw==
X-CSE-MsgGUID: 17SVgXRCR1GkLvaMqa+Ixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="148748315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:59:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:59:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 08:59:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 08:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMJiBbdpQebeu2muwf8po4Uhq7gF/S5tt0rubHku3BUGD7k+DN6Eng2na3ZWPrgENbuAEo9lwk9k0CjPZDb+ej+CKlT521xMDITc07X8AHurTyTKJrwZec5v5eEtO6jSeBHkw5OLhsaEb66VYtlwgBDJMhaQTpwI6MV3LkAWnGC8COUV2iPlnD8iqDiA+xutRK/ZM5QmNcCrEL5Xi0H9PkR7LqTyLM+icMRdCqoGgrdUY/38nlJLe33BsMyvU5GVX+RDFfsMdSUTWCPvObewPSqyAJBPQkz5AMPhpntsk/VAH9nIxopzEpPrBiJMwiMSnz4e0GiwUdqbLYxbKK0meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWZJYM6wHoL+FrRmVwf0QkAV4sk+e7nw8kimbtUNDSo=;
 b=FsqOGd1Ew+zM6Mi4gX99scE2eAmCd5z2UlmAo3OjCUFf4keNNNH1vMuH+RO2Hod9kO7xusED168k6HSNV//mvR1PU1CRptRJtVgUsSq8Z+kQxBk6QmehplisvXY12AhFy/cNvxLDkoJGlY6eIofTnHPVRKsIkXpeMurmpmSo2ehoB7DxiAQPq3kifKoiHYhP1JYDeDGubCxGnoHJPkh1ekDM+rFA03kNOWLAnrQVRDMPhcIjogtjIELw7APTVjKkLykSZ5+34MKQqrnCZqfe9NphyOmWKcr1xtdseQsLMlkuCM34pXaTwIpj/jglyxIdiVkvUp98edqf00cJ09boWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 15:58:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:58:41 +0000
Date: Tue, 3 Jun 2025 16:58:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, Ian Stokes
 <ian.stokes@intel.com>
Subject: Re: [PATCH v4 06/25] net/i40e: rename 16-byte descriptor define
Message-ID: <aD8bq9UCEloXHZ1M@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <11ec44cf91f6075b65ebe908b57a7dd3c175c252.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11ec44cf91f6075b65ebe908b57a7dd3c175c252.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: BN9PR03CA0861.namprd03.prod.outlook.com
 (2603:10b6:408:13d::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed50f12-4913-4df7-62ca-08dda2b7823c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mSP1nQ5BZ6NixLppn4BPm8a87GWs8wdemuz0ckl4NffnDmEItHKBIGYBkZuL?=
 =?us-ascii?Q?Ym5srGbmuqox7LQn+Ht0ATMssP7rXp/6peSkKokrgwCHANqb/ltoqADD4fJJ?=
 =?us-ascii?Q?u2Vjnh5WtJSbpWkLuaWsm/BC5yI1+iE0m/w/eRWrl5j23T4OVQTA4Yr6dw7h?=
 =?us-ascii?Q?l3xR1Ov2Wz1KdrhfdwHtv7LTnnJLnTo92SaOFwKzqE9v/nQ1z6Aqr98Mp8S7?=
 =?us-ascii?Q?Y4BML7PZTsZHCh+XQThXmgAlENPw9z9WZBGQId4e9B8zHKzxWhQPSxUlVwCq?=
 =?us-ascii?Q?cBZu/jMCgtF3VxaKLQ0Wz/LVlZQ5CcpgNjhwB4w9YNNwO/uk0ud0LoHdgu8x?=
 =?us-ascii?Q?qQmi33byTls8TEnMooelwrwoSmdTjqx9aJemNKIg50ml+PQSDMKeiSLCpWyu?=
 =?us-ascii?Q?1qePemmrIOz4Nkl1/z0xqlVYGysk4Br7TL01W35166UdvE2zcxwjzuLmforU?=
 =?us-ascii?Q?sFGYtFT+Bu3JvuVqUcvvA6ATeXoqKsXE4HEC2uN6CP00canJVT3TQAXKi2u3?=
 =?us-ascii?Q?kL0cETwM7Z15Ppo2pxwjW+M+ID+GorYY9kXzaIp043o/9ejZlVKwWxONora3?=
 =?us-ascii?Q?6vTBreD4vKd6ALff6W/7h4qUcoecz7draVlIefmMfiUZNqd8e0EesXNHJeiZ?=
 =?us-ascii?Q?Z5OH9C/C4OX3uYxvnJxFZEwaKpRdTRa+YHiJmZNab3NVCCg8YcCdXCYGNNcE?=
 =?us-ascii?Q?F2olgGZm3YFqPwcWgvlH7+4nelp4r7lWgou6jqs7KUJYFuz3F36ymHh+ZPnZ?=
 =?us-ascii?Q?sc2BUlGtx/fKa8rrwnG1Qud4xg9VWidO13Xlf4eYGzV6jaNCcUIdebaA3PBJ?=
 =?us-ascii?Q?5oxeLfpOlKZnxSFvHUzqK+BxshxkfWbi5OqAX4Eoimm3O7vY6axLfIfQcWRr?=
 =?us-ascii?Q?YfLgujeC+Ce1eWxp9PB1sMAWzDNWk1n5rxHZPfG41nQeQwYkkLSSTTHQvew1?=
 =?us-ascii?Q?aDudjzRB8wqsvSQ8WVcyu/2f3+TOfUWKHw6+STWURsEZfd+CaGhv2jyhMbN9?=
 =?us-ascii?Q?GuO4shL+rbCbK/BpC0qRlrdzb55fHPscBazX2HxwY1BaqNgSIvwpwDKTN5L4?=
 =?us-ascii?Q?3PZWs/ZDq1lgDyWZPDigavp1ETB21pt5V700cPrhPv/r/TbYtwgBBDO6prXL?=
 =?us-ascii?Q?Ugt8dc/zBZuwHnAL4yibaJDjsvTQZog2pRev6Kb4Am/uBX0FBRYS9Sf/F9Ns?=
 =?us-ascii?Q?EKlPcDuuxkjXCZsgQj/Ea5nDUr24q/EUt+pIPSGRNR67UON4Vr7TXz4Il+GU?=
 =?us-ascii?Q?RZUQGKhvLTon8jGi5XD/5oJA0RWhT9T/coYzjseqgCFlvjsHCLi34Rbac3Dz?=
 =?us-ascii?Q?SBMyeuQxm3NRRGGPLuAv4cYXDYloXBylWo/WsJwcONMBdlTxM9h+LWaO6gLG?=
 =?us-ascii?Q?Hmwgi3KYPU7k1C5s0UnLnlkIdrcmaLxkguIEJeIdOflaWN73Tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uJ2ChqimNw1a9iZ45RwXyroTuZlur0djDjUZqg9VGJeuB6ZB/p7YlMy/LAyh?=
 =?us-ascii?Q?YZ+6casdn2fp6nK1JJ3nQA+aQb3MY5PcQCpkXWznvy4Ype4PDpoTvjM2Erz4?=
 =?us-ascii?Q?ddIOR2VIU1z8RyKG0qVzCTyBoEbLgkxj5Vu+JYlQGPspQu1qkKDDWOPHMQ0q?=
 =?us-ascii?Q?3p6ibMFSP4tWZ9OEHzuApNxFgYuknvF+kGbvNfp7Pqrca1Xed/BIH2ZSpD06?=
 =?us-ascii?Q?C5fQMCsbi9d/eC4nva64J1v07nXOS/0sEl6Ib5nWEDINx4ST1au9iP+zdrX8?=
 =?us-ascii?Q?5XhRY0UR/9kb7TRdmaXEX6CcOAJmut++M0XKld8k4+liWHGP3wcuJIU5ffHP?=
 =?us-ascii?Q?/l3EQSIfYJDeejXRsQdAv8xatlE6gOzGW7LwGJhcGL65gk6mAQiJEtkFDhj6?=
 =?us-ascii?Q?a5be+9bo5CrxSq0fxAFdKtrai7d7jGLra7ZA/LixaCtG0EA5mUzfj2vfKELR?=
 =?us-ascii?Q?dRZFNXOkgRrkaXgSq4/kUembxsDPzwSob88ZukTRkRVLb8HsOyZx9qplE6Kb?=
 =?us-ascii?Q?e53oHh3UYiZu3ek/+b7eOqCzuabFiGnvoeFs2GiwG7IMnKbRodj/ALvJMfbM?=
 =?us-ascii?Q?MvbAprjHhkGH3uFIJAbHO8znNYkR+MTMVepdaCX9PI38KHq25EmNnRKGp7e2?=
 =?us-ascii?Q?kEDpaVWyYuAzqJ7/wAefx76pnQJJc8KamnOuOyJDvLhNjgFnw7zVfktm+5Np?=
 =?us-ascii?Q?UfnYAO+Lnv60uu3YZRuVCSxjkrI6VzpexZ3Tg1Ki7mtHRsODFQ1D8acRqDQG?=
 =?us-ascii?Q?ta3EE+lovlP2rfFIcnJgQh7ZVfRqjczR90rm2hWAci12oY+70f+hNpyHJCZo?=
 =?us-ascii?Q?HhN8s530Eo0rx81s4g2qC6kMxR6JyDFXhSCiaoGhVfpqbvfjLPLyxKnXtO2z?=
 =?us-ascii?Q?PrpLrb9qklOCiD5k++NYbs7AsXJNvIuZtb5JVECxEW+P1/rhTz1vD42wxpTB?=
 =?us-ascii?Q?M2pE75Iqh3FU3kNukW70z2hlPSAcI71x+kNa8rkvwInycJbzE9RXuVhdly5j?=
 =?us-ascii?Q?i5u41c1dJOLqn4TWhJD8t91VJQhvWjHDg8If8vaW3uuEQ5pDFsW8tdpKTg26?=
 =?us-ascii?Q?sFxbkVPXFu0WdtXEIPayxs+NaL8yS7JiC1Z/pUlttO3yUyL6UJTAR34z3vNA?=
 =?us-ascii?Q?wFweQs6FU+xfXdQXSZLvBWLID5EddTs1mcamTueECQjlIVymEt1HAw9krmq7?=
 =?us-ascii?Q?K7wzuxqSOifnB7Zw+HCoZpoDnLs4g7Uhc+ildyqO8slu4tr/vJ55AF7tV4rU?=
 =?us-ascii?Q?YBQ1cD0PTcSeFpu9OtwJ3ELpuVRXKoGDVFJrzQ+x0gNuLjvvr2HX7NFhY3xe?=
 =?us-ascii?Q?Yn4fLR7I+voMtop6TATOR9hzjQoAnwSlY2VQ675I6I2vlhCG0l3HA58XaoZW?=
 =?us-ascii?Q?MqTz4vumDn9ylLPwB5UhU0CK4yVCKoDdD+SItVvZk6cKZ1pwjEgikjEGfbez?=
 =?us-ascii?Q?EypjQiqkwyKE7MAWNuvA6/YZA+vWqpHc/w1B2mRgv7pmhjTCwQ6dDxI2y0WD?=
 =?us-ascii?Q?V3wktRVaXCROhRr/YIemPC19CpR8ek4TL8NfhkVLZT/OhEQ+K2mGDUJzC5jZ?=
 =?us-ascii?Q?7VZPVDgvN4f5C5hEkI64901tVYY4O/WIZ4T+Y6zUHBm9rmmHVfO8cwkiGDOv?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed50f12-4913-4df7-62ca-08dda2b7823c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:58:40.9812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23hbv0EqwOS5MNibEdbGpROp6aImTH8rHC03arjt2CnzhM/o7tkAYIweZ8BUP2BsPDX38bXKi0LIiC8kOAPLbx2vFY+VMCZYprQ3ACYQJ/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
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

On Fri, May 30, 2025 at 02:57:02PM +0100, Anatoly Burakov wrote:
> In preparation for having a common definition for 16-byte and 32-byte Rx
> descriptors, rename `RTE_LIBRTE_I40E_16BYTE_RX_DESC` to
> `RTE_NET_INTEL_USE_16BYTE_DESC``.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
