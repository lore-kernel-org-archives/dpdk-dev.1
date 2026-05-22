Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A89CD5BB4
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DEF24029F;
	Fri, 22 May 2026 16:19:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8D94E4003C
 for <dev@dpdk.org>; Fri, 22 May 2026 16:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779459549; x=1810995549;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YBVWqSuftBKGOJsGvYvnu7rSH8fMFhXMhjURhg2uZQE=;
 b=DY1cukdZIBDO7S0yJdB/Q8SEhO7KiBt9hte08tPA3NsjExjrLX1Y9h81
 J/b+GPOqBiQSh4Xws7M/cDTPYe/9otfbjr464IdpGvyC96hFSi/EsFBQK
 tqYb/bUUIqvbttzYMoRAN57Go2SwvZkCFG2pvRaNtYUdIGDqDVUJ2q9zo
 CBx/weK5WdPdR2xJ/I6tKY2JQzL2OLMNjIKhNvIWebV+wGwkBa8mNbI6k
 KU9ynyVVNDE2ZAYpP0MxC6ch+WXljkdkQ8J6PHen5eNrugzPf7F12aW6v
 VDJDMz1XjrVAMixuSynunFquvav/od2tiVsgpWxDIhOlSvx4L2ny5szAZ A==;
X-CSE-ConnectionGUID: OZKHgWs0ROKt3vAoP5e46A==
X-CSE-MsgGUID: XDfaNuSITsaSPEWXhzQs/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97812770"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97812770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:19:08 -0700
X-CSE-ConnectionGUID: 5gnez6WHSW+Hr+h7MmxNjA==
X-CSE-MsgGUID: apk0HeP0TzS/q2VpUPg6Jw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:19:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:19:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 07:19:09 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNTklLgbLKWce9EqZVxIQiKi//XCwhE7XWJETsaoB8QYMrnK9RQbrOMFF98BCqvd5Bb1YuXqcLZ1GJPA++5fdHEetMUYdY7Z87/Tg0DXww1XICHBSI0vab7vPxfJlA58WZjufAqllJ14F+9CKK75RVrwg1rvl1ifJYS7J8sa32w57wdDnHXXdhBbtx/oBzC4rvFAk+uSp/58aLcZ7dg6mwVYufFb9kRkNr+0GVbGHJ3vVNqIWGgW0BFmh3Vf8ceHte68hbULsOfi8J3LROER3Mgoxo/YzwVE0JLWMPzFgA2C64CvSCVJJys+jkRAyPEE8GtMPKit/q9LYnMP4b2dKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBePPvnUMOfMCf5Hc6ThD/75Oy60h5TIX/g2tfZf0UE=;
 b=RpKlxRyKEA/GI8drZCZTEm3QX4eZqZScUxNVGvzDebN83RuK6Au8Gnw1ho3YXkgT0RdD6QdnusCofVFHJN/uPfJRov0xQp08wAfRCtbkKY8gdoq+TjP5XDXPbaqPReNrMsCe8BC/KRfOC7lREPGqBKFOqTKkZVrNzs4TxPoN9x/tv8qNtJHawywe7IddV70QRGf2f+OG2UPfH2Ep2imXsKyJchXLV35DELe+tvSbjzbsBC9TSHsaykX/u8puA4ZTq4rKYD2PLaGPIA6q/EbL5cFl1ZU+UiypmnMLdi9YTiBqIits5cv7fHj+/tYgiVmypZZWljreEwgIGmPbJL0Lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:19:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:19:05 +0000
Date: Fri, 22 May 2026 15:19:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 00/11] prepare deprecation of rte_atomicNN_*() family
Message-ID: <ahBl1GytfB3f17hV@bricha3-mobl1.ger.corp.intel.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfd30a2-5eec-4b18-ce95-08deb80d14b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|6133799003|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qPmdsJtZNZmNsUx2Uj//HE9jD9+X5/TGyM38X1UJeqfLoOgW/mYM9wTXFEhmfXAAzDQQNB4VLcmMK5ooZ7K/ufVCVHHEymUZ9n4rfHGTqGQ5vXXCW3GAztNxnAcm0eHZoV+WFqIygTanmrdyN/+QiRyNDsu4nN1atKnxwPooX7PaqznlIUiUa9NJoGK2dUa6opFFOuSHLqANOfiVt+SHOX456Lcz7jadsKVLJF+zcNMlScQX1b90gLqAq4zGaeWqxN+ZSuN2T7lL2t0ZYAkO+3A7xELDcjqu3XjQDxghJKGPQWO8Fwj+m36xF5TWeWzRM+SsgEhX3PaSEJb9ICTmf4wyRdwuAfazFOvlw+BEqgaom05lpvrkvzaF9T+CNb4lA8TSbgkMfFYWib2R9/nUwIFv14dO3pWl3oaC9YvTbI3cDcC3jSvJVN0x2XB6vBtP54UuUl4xNQ9sLVe0GkDn2Cp3MnUrSpPcajCyWOBreHK27I6RDoVkx7wNeBc0adjA7y79axRa+ry95sh+s/ewYXE4i0HG7aWhhU2y//uhKUI/rEYRXtXybW7KhBUzet52k92cYKPXak2TRksxvPsiC9ln6K4MqEstUQYe1L+tLtKGnx0JnFC8wW/Ev6uIRiqWkIbtlMTVkbOqB+uLc5d3ODzWekw3n0qO+YcRFzwbxAjsdJoOYrqbAYvoct8/mTkY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(6133799003)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHwNwdpJp6NjLXfUL69nJ3ZwKvc6vFmc6kdgGxdQwyghjaQaa1MIKB96JCBn?=
 =?us-ascii?Q?LqdVSxq1/jeYu8q/Kp7pjrOIYjK1/aBOu1Hdj3BlY8qQ5nHpQawPhI11RGGt?=
 =?us-ascii?Q?KI4bf2UrSp7H9xjVXnAU8MisYrteolKSDSC6pd++d6Gz9NViCP/q3yCkHrst?=
 =?us-ascii?Q?zkVPfA/RH29XVCCgi+GRF9ApukaODJ1ZYfTT3u7MWkAGFAj4H3qE+ncllHOP?=
 =?us-ascii?Q?Ey0L0zVppFnIrVNGyETnCMAxfLwJ1ez4f00xMOpesfXmy+d2snfGJ8rw82zP?=
 =?us-ascii?Q?+Cz/xdWhwKGwAg4fzD1FA64alj0c9rd4kfc6zfcURdC6TV8DeukD2DFiRGUK?=
 =?us-ascii?Q?EPQcF+9Z034/QiFOi2RYF2EUugobUoQT4en58z89whDNWKz0GW/8FN01Qyqw?=
 =?us-ascii?Q?N3aUko4Z0VyWIeUWnUM6rQB6s7FWp9vxJr2pZVBqb3DtDJeCMQx4U9TtexDJ?=
 =?us-ascii?Q?7cAagSNQzkJGeyZFKmE1sBSmcut7R5AM4DBJ9G4shrO8lMwIO9LyysibmPjE?=
 =?us-ascii?Q?nQGTwojq0wgL1plyVOtmz1v2vxRsm7vm/HpBYy/j6f5uUl26g/8lMb25EVdZ?=
 =?us-ascii?Q?MFCvTsu43MGrHBcfabw8jgr/Fb3VhxAb6zlb9a69ituq3VKZ/Jts4YxUAO+u?=
 =?us-ascii?Q?zDO7m5VeshPBgZqGczrHeqgczgqJXmQF4HMf7VM+pmD9V0K5spUQmrkFX1SY?=
 =?us-ascii?Q?5lRd0IorckF6NVSsQCGSF0F8Fomq1upSFtzSzYg/+qp805yctxdsk4ozeCNJ?=
 =?us-ascii?Q?Vh44AJZkKBI/dgKEHdZE3oN+NkVXyrMq4e+aizxEW9WhG6bD42yXfZMIEsZZ?=
 =?us-ascii?Q?M1/KYUU/CQGqZv/XLilkDku+/KtYIEMs07tLst2HiR6BMXubr5O+lPh5Tzyi?=
 =?us-ascii?Q?qiDC3rMjw+M83tch48gfhJacrpPfboFZJQkk1uZbyktJKPvvTRllmdnehEeT?=
 =?us-ascii?Q?JVds0tRWvTxzCtqUw+pjjBfNstZcq2l0kJ80N+rlu8Lufbb3TSUbF0EBAcMD?=
 =?us-ascii?Q?mhWooyRemGClRLnCBCcjUe8htqJCGyTmHOlMX0NQqrncKY66V/rFuHj2+bqq?=
 =?us-ascii?Q?RJcmsrLjpfpfip7g1SHHozKM1oOf9by99TVuGok6cP++hV2RGSYsCVtvZE28?=
 =?us-ascii?Q?mluaU82KLg6YMp0836jwFbtXBh8YThlQrQjKH85KapPOs4M88hwQbUQIb/mj?=
 =?us-ascii?Q?tIEzelJXlx4GCVVsxmBtnF3/XzTNFn4nKF/SjQ2HgnOvrkjBTmAuJe+SkEIP?=
 =?us-ascii?Q?cSt2slIOj+SHX1busMWrExZuiWWd0xr1kNS+jGkU2APPO8VHvHSFKic2leLx?=
 =?us-ascii?Q?WxeTzYzKGw0eF5A2/+c5lKz4/4FHkqvNg1K8PNdlMmRTBuqINJ4UiHJt1DPf?=
 =?us-ascii?Q?F4gmmX1FCcAbt9+LYF+GdvBIAOo6BEAeWIcicFvTqofd/ue9N7W1MtHDj3Mr?=
 =?us-ascii?Q?rtoG6KCOh1yZJVBu969l+ydJRg2z2bRCn/f4ypJe+hQYJSgcEL5mXmPa0IYn?=
 =?us-ascii?Q?Bv8PB8nvmXg0J220fWWzry+P4DCoCUaRI61FifpmXU+LcKEZ9LgZLRnxHoB+?=
 =?us-ascii?Q?HjbkJXaG1fuTDMSIid6Rs+3os4+5ltYDIoN9XsxdbLHSSFvr0FF7Y4S4CoEd?=
 =?us-ascii?Q?LCDM1O1VFdb85F78OtwfF1HNC4BnjZMmTk1D2P8MSVgsfP9qenDifNbTSOrl?=
 =?us-ascii?Q?DumPpeTktaq/b05MBLhs1Av0tPRmnf8k3DRMjWw0yNP5lrZCq733Fdy3yVG2?=
 =?us-ascii?Q?1muj4B+ak9ChaXwJyQWlTsSuBF3KNEk=3D?=
X-Exchange-RoutingPolicyChecked: B7ECMPaf+Hp3t//kRQV/ObtEk1mr6lxLbSaq48X79zfBKZwwb0RldJXSU08ZkMYQ0k2bx9XH8GjBwncyO81YpVCkbOpoOS9u8vIDQCobqjXPNAyZ3271TkDopygt2MeOC4+SOrO1emeuDfimDz0mTrrkGUwguX6aQaUqXdE6HWT6X8wSxMxvB+7ekjVfDKt7EUSUdbFuPaVSBwBSODVWhbsBueCIOZkl31+O9LIL6GxN51EZYlAuePU34tFmToWWSsa2blFATDH4wNNvvfjSflh0OzIZZbwFScOYz4d4EXX9JhVNd2GuBk2tm3gJsdYIRCQGj2UUI3tBUFAhC//jAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfd30a2-5eec-4b18-ce95-08deb80d14b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:19:05.7322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/+iHX6UXuT/6a+z+N2pzdU9dOYBMRgb8RR1MYspy5kwp2f0oTWhPl/DVo+Eer/WzHYtDuT/PMY5/NBK9x277hpgOa4WTZD1CZeL31lUZw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
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

On Thu, May 21, 2026 at 11:04:12AM -0700, Stephen Hemminger wrote:
> The goal is to land every deprecation currently listed in the release
> notes by the 26.11 ABI bump. Functions to be removed in 26.11 need to be
> marked __rte_deprecated by 26.07, with all in-tree users converted off
> them first so CI stays clean.
> 
> This is the first step. After this series there are no remaining in-tree
> users of rte_atomic64. Expected follow-ups:
> 
>   - convert remaining rte_atomic32 users (dpaa/fslmc, netvsc, vmbus,
>   sw_evdev, txgbe, ifc, hinic, bnx2x, vhost) - convert remaining
>   rte_atomic16 users (dpaa/fslmc, qman) - mark the rte_atomicNN_*()
>   family __rte_deprecated - remove the legacy test_atomic.c - remove the
>   API itself at 26.11
> 
> Patch 1 deletes the inline-asm atomic fallbacks across arm, ppc,
> loongarch, riscv, and x86 now that RTE_FORCE_INTRINSICS has been the
> default everywhere for years. Largest patch by line count and the one
> most worth review attention.
> 
> Patch 2 retires the rte_smp_*mb deprecation notice (open since 2021) by
> reimplementing those APIs as inline wrappers over
> rte_atomic_thread_fence; the API is preserved for readability.
> 
> Patch 3 is the load-bearing change for lib/: the last caller of
> rte_atomic32_cmpset() is converted, with explicit acquire/release
> orderings matching the existing HTS/RTS ring pattern.
> 
> Driver conversions (patches 4-11) match each rte_atomic64 use to its best
> fit rather than blanket seq_cst: software stats become plain assignment
> (DPDK convention, torn reads accepted); CAS loops setting a flag collapse
> to fetch_or or exchange; open-coded link-status CAS in net/pfe and
> net/sfc moves to the existing rte_eth_linkstatus helpers; genuine
> synchronization stays atomic with explicit ordering.
> 
> v2 - fix clang build - replace rte_atomic64 in more drivers - incorporate
> feedback on rte_smp and ring - drop zxdh change (only caused by
> intrinsics in spinlock)
> 
> Stephen Hemminger (11): eal: use intrinsics for rte_atomic on all
> platforms eal: reimplement rte_smp_*mb with rte_atomic_thread_fence ring:
> use C11 atomic operations for MP/SP head/tail net/bonding: use stdatomic
> net/nbl: remove unused rte_atomic16 field net/ena: replace use of
> rte_atomicNN net/failsafe: convert to stdatomic net/enic: do not use
> deprecated rte_atomic64 net/pfe: use ethdev linkstatus helpers net/sfc:
> replace rte_atomic with stdatomic crypto/ccp: replace use of rte_atomic64
> with stdatomic
> 
I decided to test this patchset with the ring_perf_autotest (using only two
cores on same socket) to see how performance may be affected on x86 with
this change. On an initial once-off test to compare performance
with/without this patchset for MP/MC cases, it looks like smaller enq/deq
burst e.g. 8/32 are slower after this set, while larger bursts e.g. 128/256
are slightly faster.

I then ran two more tests with the patches applied and again without, and
got AI to analyse the set of 6 results to come up with more meaningful
conclusions after a little bit more numeric analysis. Below is some of the
summary.

While not necessarily a deal-breaker, the regressions seen are cause for
pause. We probably want to benchmark on a few other x86 (both Intel and
AMD) systems to see if this is a consistent picture.

/Bruce

---

Section-level picture (stable changes only):

Testing burst enq/deq:
  10 consistent regressions, 0 consistent improvements.
Testing bulk enq/deq:
  10 consistent regressions, 1 consistent improvement.
Testing using two physical cores:
  mixed, but regressions outnumber improvements (5 vs 2).
Zero-copy and compression sections:
  mostly inconclusive due high variance, with one stable regression.
Empty bulk deq and single-element:
  mixed small set, with isolated improvements and regressions.

Largest consistent regressions (examples):

  elem MP/MC burst n=32: -39.19%
  elem MP/MC bulk n=32: -37.84%
  elem MP/MC two-core bulk n=8: -36.58%
  elem MP/MC two-core bulk n=32: -29.46%
  elem MP/MC burst n=8: -29.43%
  legacy MP/MC burst n=8: -19.04%


Largest consistent improvements (examples):

  elem MP/MC two-core bulk n=128: +28.16%
  elem MP/MC two-core bulk n=256: +25.91%
  legacy SP/SC empty bulk deq n=8: +23.41%
  elem SP/SC bulk n=32: +16.05%
  legacy MP/MC single: +4.65%


Bottom line:

There is a real and mostly consistent regression trend in cycle-per-element
performance after replacing rte_atomicNN usage, especially in MP/MC burst
and bulk paths.  A few benchmarks improve, but they are fewer than
regressions.  All-worker total-count throughput appears statistically flat
in this 3-run sample.

