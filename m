Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D9D5E146
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 12:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EF8E402AC;
	Tue, 16 Dec 2025 13:28:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 605854026D
 for <dev@dpdk.org>; Tue, 16 Dec 2025 13:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765888106; x=1797424106;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GWCbhro7FZVVcJer+okOiS4o+KIuTdvDh8tvpAlqaLM=;
 b=XfyOcjfsP9QFiVz5MQlNyp0ZefPQ9Fte6nc/mMY8m2PZM5blJZRSOr2w
 9V3uz0Bv+UAMMHtV0IiCS8AefbtM8mOWyUpfEUpMEKYZSXsu5xWalIuy+
 NXjKrDgY8mEV4boWNGP/H1asCjo1vSHnB478HgWYqPRtKlnsyuMToP5DO
 x0Qia1G241YO0hc78/rW1kzWg21E63DPsVNX9AiDU9oRsaK9BJmH2umSZ
 SzQkep7jfov2kNCki/v/aKUZ4dAn6h+dMiQxYvYn16z1y5uzmIDnCtDH/
 hIBgVEzxXqNqjyP3p+rD97BLz7kjA8vpcuc8exfXdR2dVRkW01/YU+Gvv g==;
X-CSE-ConnectionGUID: V565hgr1RQ6cIKXQO0Yv/A==
X-CSE-MsgGUID: CbGqf2FuTomkZdN393wwWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78439827"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="78439827"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:28:24 -0800
X-CSE-ConnectionGUID: 4+bQugpQT0KZ1sKkaxTtbw==
X-CSE-MsgGUID: b8nw08HySOmjVaTlxJ/R9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="221395555"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:28:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:28:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 04:28:23 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:28:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMFn+sGebPz40DamwKiGr/8hLWN/U7TkRve2OnmHhr8q1/n/7r5uSeuNkO1EnqTOh1A1uSMtg4y/piLFKVs7kfP86yCbDqWsZyAuX5GxSUdM7bQNibsicYT3+2GbRz1Rq/0cIhFv73taVC2/19muRZKcwvu5+kAqjK/zEcDQUyZUUf9o6JIOmyGba/AtWH9tg1E+LSpZJLOozMOZKanP6wVbzVviNRRWy8MC/qkOz3aL7N7jHYBIWogPBP8ej67Ixug2DaAK7qIqXUgwKJJ6mn73BZOW8voayWIKTMcnJpXakODKOkeKuelQRr8VDr+PfFf/dk6PumpJ3biJOeZvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/HS5K7kkUbOsLoRpy7AyYX7k/9HZwMcP68pJUs539E=;
 b=xunskOStd+ukOgztJ0qFeJhfgFE3v2LlPRaub+/qICfxPbfR+9FqVT8MPi4hS/BfHejOD/H47HzvtNJockfg3OgfJFseOWhX3HG0wpfeYyL8TfsIXc+r+Frr7HxeKA0HSSOYZfqXVf/wwl02fmRjl1X4HVCv7XTqaJDw01n+3y4/PPfVIPevyrs4waCs60nWG4ZWws7ky+63+YlxRUvwZs34Rr6KE8RoE/V+f5vdwwXkf+/H+YEPO14w+7VjbEqxx7hQB6YWY8pwINtGwS1/q+nZ0DLuXRxS1UO/6CmeKSlQnwh/Vc+N22JOcGCJHQnFiSnsVwv88gslGNaH3R7Bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9417.namprd11.prod.outlook.com (2603:10b6:208:569::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:28:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:28:21 +0000
Date: Tue, 16 Dec 2025 12:28:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] Fixes for Intel common rx/tx path selection
Message-ID: <aUFQYFTXAxMMoYkY@bricha3-mobl1.ger.corp.intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251216103504.2624535-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c45cd1c-8168-4ee6-cd67-08de3c9e9986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fJeWRAB/MHeU5jCBQ+NZGRHEkXPZF3RVFiGHFsJ0uXfIiwYhfcaqzXSsD+hE?=
 =?us-ascii?Q?fYC3ubOE4hX6359GDCkSJaK0Idw+/OMJdXPNws6QtqfHM5vSk7P7mJnxCMMp?=
 =?us-ascii?Q?XNouxuUFkseBmDvXp+Tap5GCM8kswVdkFPiHfG++JqAgyx6Q7G+SHe4Hv+yH?=
 =?us-ascii?Q?VWnjjZkZVZKbRtZKo0JcXt3BZ35GPP/DlSoI7sdcB1dNZJmeZCom+iVkznGV?=
 =?us-ascii?Q?NzTkfeQwQyyBKeWXmWmrbKdor38gLuTwaGulSnnyqIbPm1ZnM4RA23+eEZ+i?=
 =?us-ascii?Q?u76xlTvyDXTEbZhgkywsuTm2pmHdBnd8ipNLNvQ71WDfEGsmyDhiaqEhkuB+?=
 =?us-ascii?Q?cZwa69OmtCTAP/qU5DCRvJX6KyCUKrghYDJFRqJKn03vVATBGtuB3cWJQrU0?=
 =?us-ascii?Q?88aa4iB3/XXIzIa3l5x7ES1G6WJCwvKisqmbO0VAXWKKSRZxovIysE1hd33I?=
 =?us-ascii?Q?tXAqc8hVxU7ATeEFmtiOZ1v6jNbwO9RPy52xX2s6RXSdEB43mzqSF4mGBxQt?=
 =?us-ascii?Q?3Kfm55RuVb5zy11wBDULv+v+Uw6QPScbQERqkqK2AAxinDrZsHT3WX0hKq4U?=
 =?us-ascii?Q?0YptXAY00g+QjwedELfGPenj4ubUzGN419z4E3N7uoT7myJOLl/S48R5VjUV?=
 =?us-ascii?Q?fPw4LKoZKlyRbgAJx3Bj6cguaPWJMeSyF1ByGsdq/O4q5fDQFleCec8Rsc7o?=
 =?us-ascii?Q?e5jlWMQwk4GQGcR55Zos8JRvBbG7zTf3NPYSftB1dUAYRVJqbDvn0iIMMzyR?=
 =?us-ascii?Q?Xp8f0lx/UE/w4EY4h55kHFh9AA9r7QQwG37z553xtIbRX8G43T7vtJBGXd3f?=
 =?us-ascii?Q?kxtOM+PnppnrI8UekWfPK0cf89n5AhMkpk7yoXQs1WP+zCiOpFVGm1VsGpqk?=
 =?us-ascii?Q?Hewtq1kxZsqfjDu2tgc9av+ELtkSln/zZsJXeL6z1W+4nrCSRTTvt5E2M0+n?=
 =?us-ascii?Q?HydvU7X87BCFUR3s2DL7YvOhjiTJu3Lj5C2rfkYm9Q43e1vIDqQQb9/Zstm+?=
 =?us-ascii?Q?CUH23LI/ORnwEFLlSBNBTjUqUD59PuG9RNFg1b0iUJrj9zWjw68z6YYX71cZ?=
 =?us-ascii?Q?R9Wj/4cqBrm6yFAUbFMRUfH6WrQKcEYd1k5a6us0qBUaPIuZLeRN0pSTZPSW?=
 =?us-ascii?Q?7fXnt7HKcRxMbkV/sZF5/r4T0fZGA416HN2QeaB9VynX456WOWzz6F9tyj6Z?=
 =?us-ascii?Q?5shy0dqP3yVrOGW4tqTd9c92Q0UCossXlSgbIkvK1QaMrGCjnUJaTuwvTUni?=
 =?us-ascii?Q?c0dlTbvwspU0BzD/wYLUZIOpAud5K7fScHV46gLliIPQBS7goAFhn7ipA7kz?=
 =?us-ascii?Q?EI66vWomk/fXGlA/nuv+eHIxAgf1yQ7HIiwsq6xcwGyRQJZnyOFZSNIY3jJM?=
 =?us-ascii?Q?oITsRBe5eC5T9Ju91WuVS5lqEi/45v0juwx0jTq25UX+W03T+U5FTVKMg7oS?=
 =?us-ascii?Q?O3AabgQSPkHcKB4INZhWQMxOeHgDFi9M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EEI75/OmtnjL32wNyo8yGPk3niyF+YSjWYLxEjaiYePBfhYpzXfYhqBIs5R+?=
 =?us-ascii?Q?H9Q6wRsCMFQtbhd+5p2U7+jwapiXeUygTcpg/MMXMF0YSTBvc4eya8dysUBq?=
 =?us-ascii?Q?CfiREVy6+hi93kWDT23c1xMtZp9RAuoy8gB831LYQ+h0p/BVSrHoT3PeS43h?=
 =?us-ascii?Q?PLrd56kyO0OYBsb8hdj5hAnAgYgbEDZAeCW7peDQK5aEwJJkrvsEsw6mbdub?=
 =?us-ascii?Q?P496368ihKzbswPR12qlLQvesTfeEqujgpirWBEOEofSLJ3DaOIyTeXqgORh?=
 =?us-ascii?Q?g1D2KiYACKLsx1p24+EdZawUqN5gGi49ZCGK6OxMbDqddMGKLKN91jG9IUif?=
 =?us-ascii?Q?MiIWjQx5eRrL/k34JalXIQs0bBHky4FUws19us5wjOLzBDdQeHlhDkszodGZ?=
 =?us-ascii?Q?z2LG43EdN/yZVJ0M+jbrHAaAM+5seTzPz+qsXitMFZeGSH4lgRkvdNx7hylr?=
 =?us-ascii?Q?CUg1Uo8kLFvbR04GWsXWqauBTGrcRdfSZotcg0eay2Kk+jOAaMq2ASVMoJ8a?=
 =?us-ascii?Q?AvwdcY09u1Xoungb/PNKd0U9LH6dUT9nOHI0kNjggGNhIj8fxgVQaYFXYC/P?=
 =?us-ascii?Q?kzkWN+a6J1uL7zJHx9BhYSf7gYhEXOhNfyTqDMc7H80hlA8p8hTgSYFLCXPH?=
 =?us-ascii?Q?k/9dHRKEAwo9t7UjHBUXVvmO4QZyVzc3LteWxrWAcQQC6E/jtPeO31C0zUJO?=
 =?us-ascii?Q?L8uqV3CIT8aRNDAALsQnxtgH5EDfwugdGgvowppJzUOolbglCUXIaLx9w09H?=
 =?us-ascii?Q?0pQC89rCsRtkHJoQCUw7TItFboIq5UFJ0hcmYABPGL2jKZU2wUAGCUmCrWJw?=
 =?us-ascii?Q?yFYNki4FDqFRaAUBm6AHPzzDyldfJDGpnDicfHMeCnkq2Q85ABHOmpNQe+eA?=
 =?us-ascii?Q?0f1uyeUczokOx4WxeGV8d3mpKUxPOn2oNZcmDXm+xcNuPjSnEDFg6XO2ZJTw?=
 =?us-ascii?Q?lhaTtkBQFsdrkVQGkaPDXnGN9eB00CuBIDWH2oGMzwg7nz5O9hyLa/s7Hevo?=
 =?us-ascii?Q?lirSA0sijhc/xoVh31jgeIS50xIC+z2XVov8lIwrSi8woo3Dh88vbuhrUxnI?=
 =?us-ascii?Q?XhTVhuStzFU9nLB4lroGQbE1WDoKKlkP8JHL7dne2+96qA+B383Jgf04oFVv?=
 =?us-ascii?Q?E55trYX0ULj5JAB5QZl8r+Y5G/yuAqX6xHXvaOiCZEbX3wzA7jQVYeOLi8r4?=
 =?us-ascii?Q?zBWI3toqHKVa8X/v8gved2ltV5LJ+P3atCEcBK1nYZExYtk1d5vylIkYXDZj?=
 =?us-ascii?Q?NvKFoSbNtmPQfmvVx1XKwaWS0eqQIkflWMOiTGiVHiwUae1HtqYqT0igj882?=
 =?us-ascii?Q?JRg4JEO4+Vt1rI2FSarZvhGQQFQrhMxqdekyX71LIb++C1Wscie1HnsKZfSJ?=
 =?us-ascii?Q?VzPiFhBCzGafoDyQWHG5KhdS8Tst/Fy5Acm7Q4JFDa/sTE6mme0YGN4gb2bN?=
 =?us-ascii?Q?1WML3nvNplt3Y5VFwG2nW7cnJIRP/HU+HkpkKYmskMdCnlwnFT/+2TLC4UnR?=
 =?us-ascii?Q?/nVCQvujfXzwOd4gqNJg7YJdmmX6xd177otOVXW7fbai7xGTUoSTTyPvMDIh?=
 =?us-ascii?Q?OisvVdpo/UltM9dLl9Jrt7u0BPuW9iAgZohNL9JLSfZLhi7Nu3VqYdSVdKEt?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c45cd1c-8168-4ee6-cd67-08de3c9e9986
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:28:21.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbTEuOF5vu3Lay2uKz0q9LcYHabLSC71OFianOUUj4kYhRxGCGrgh+tX/UbZhJT7Swd2DhxwmYCPHYb/y9A9kZxrcchZQXnrg+qkOYslIc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9417
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

On Tue, Dec 16, 2025 at 10:35:01AM +0000, Ciara Loftus wrote:
> Depending on the underlying architecture and CPU flags available, a
> different set of Rx/Tx paths may be defined by a driver using the common
> path selection infrastructure. However the path selection function
> iterates through the entire array of potential paths, regardless of
> whether they are available for selection by that platform. This could
> result in a null burst function being selected. Fix this by discarding
> paths with a null burst function from selection.
> 
> The fix for the Tx paths can be squashed into the next-net-intel tree
> as the commit that it targets has not yet made it into the main branch.
> 
> I added a third commit which addresses some minor inconsistencies in the
> Rx path selection code and brings it in line with the Tx path selection
> code. Functionally it remains the same.
> 
> Ciara Loftus (3):
>   net/intel: prevent selection of a null Tx burst function
>   net/intel: prevent selection of a null Rx burst function
>   net/intel: bring common Rx path selection in line with Tx
> 
Patch 1 squashed into original commit in net-net-intel. Other two applied
as new commits in that tree.

Thanks,
/Bruce
