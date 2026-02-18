Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD9E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 13:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59408402A3;
	Wed, 18 Feb 2026 14:44:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4A90C4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 14:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771422289; x=1802958289;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=N4tQhqommCtDNAxDcPBfF0Cue/UVRA+8xGshFqaoycs=;
 b=QKv4vCJKPJVYcsY/GmWkC/l3/MyVRQCOV8vjhf27Ps2D4FEkCYIHR6Pg
 No90EhCVyLTQjVRxktBkPTZOzvdGY8NpX2gLm0ISfLJueSPjxB9bgPccD
 U0iW+/2ZAsd7n4pJGCR+CygL4S27TsVPi0YlfzG/jNjVyN3GkvX740thV
 WWrx2Qo/a9k0xUS0LuMM7scrR647dUSJAmwssvqLfTJRcU/sC+Y1z8doe
 CmUDgCkC/Zp90d8Vd5YnYMIIEOOZZFxwjOP1ZwlurHMIzMpDr64qHKJQ+
 pjEyL6TfNtjLoON6hBlQ3+3+daqj/jZlodC6nDOAyU3L+Z0xfFDXknPJ2 A==;
X-CSE-ConnectionGUID: k/nq+BAASGa6EEdBPe9l3w==
X-CSE-MsgGUID: oF0zuub6TP++v0tnUjA2pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="71696732"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="71696732"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 05:44:48 -0800
X-CSE-ConnectionGUID: fglVBS41T0q82gKPi8p3RA==
X-CSE-MsgGUID: d25FhFNJQC+wJz9fkhAqRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="219191725"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 05:44:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 05:44:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 05:44:47 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.10)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 05:44:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1jduLQRngR4Gam0rN8mcA0kHmBGO44h5TCPuem0JCao+JeJftXIcwDy75MVIzdjHpwxBeiV+fpPDJVYNg9lXZLR+ASBfFOP3yvprOCMjRMBQbMHgmMgBZltFCumXWB5bgvGBwHMOIymAyL6SXe4k1Bh079oxhiMcLviwKJB06cPDsjHFuawy8d5PgDsUdKr9RT43r4iWIR64gg0Oi+VEFY6Y4uh6adlBI1oPCEcVYv/s5t4uB+pJA2op7J9me2SkmSpVzxb6LE9mVvTKmYDVYydGqRpFEmhH6kncOpr/lXaGXtfZ++IoPi3iMikX5+pcCQm9hAjCsCfj6pXtdDrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW1DtIltWuvn2aOtdZJwbYmIEVIdlL1QQFOQacDHnP4=;
 b=NZ+3V+hR9oKkkMbTZeGNaFO3VIktsgs5XiGqeCvfUNhXiqnmrNKGy9ulVkgKrqgqbTfnx44jVLtZEqk4huYmyuH43VEsiAJCURDnhET20lb9yuijZwwcVWA/H9np0VziQ+CcouT8AG1Ea8PVgZ02HGeqmH/AsfX5alZAvCBs2VxOV8FCTv1iDywDBpuKtSUmk/Okb0HoSj/CrrMlWpVadGYQIbk45su/3uZSciVNMZrz8er0meS74GQDH1F2kmYtNZcYVf00/N6feQD956hweQ+e3YXqd3e5yqv1+MBq3NgH9AE6W5oK86cIv9+dck6gwxyUOGE9lSEK8E/zAQRVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9447.namprd11.prod.outlook.com (2603:10b6:208:571::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 13:44:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 13:44:45 +0000
Date: Wed, 18 Feb 2026 13:44:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/idpf: remove useless function
Message-ID: <aZXCSCnW-3rUkbWm@bricha3-mobl1.ger.corp.intel.com>
References: <20260218120412.1809390-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218120412.1809390-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b418f9-f8f3-4a96-2d5f-08de6ef3e043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BFB73Zm8rIxPGhYxweIBeF8wbSKPWv82LufKo/jleWQd21zwiqjma702ECYI?=
 =?us-ascii?Q?eHx4rdOZ1xICh/sLlOgqS8UwVAlcGpZshbSr8TxjYdagvWTBoAWS9uzqpPfM?=
 =?us-ascii?Q?FTsPNBwvCl20g9yPsK3atrSXPpiaeL910Jn0BUuMvjzF4JziwJO5havJhsCb?=
 =?us-ascii?Q?9+3MvDnckucvJUp06HulTTvtPZOJyaMjAhDYEjJogcXNOM0TrYkyFpD9S7wx?=
 =?us-ascii?Q?09p5Qm1nsQQ69I53hygBe/38hf0urfgHy2GXcEy0xoAhq7ByetRD3iPD81yu?=
 =?us-ascii?Q?64RnGGpz+DtTU2qmVC7zJ/htLtF3YsNbaynGFGKSJDGi61H3g6RrB6fElGJB?=
 =?us-ascii?Q?ivlwnK2MEhDLt0ReEsmkikdbFSIghn0XPvbBYobA98wNV2P03EIyAJ+zh8gs?=
 =?us-ascii?Q?vSzQPdn8MvHMupifhfL1NQ29VPiGpeGsfrT85V6QC9q6GWky5WIU0EEDh2ka?=
 =?us-ascii?Q?D9/HGWAmnBMEnxHDZNZ3xTirFI1ykts7G5x7gSLMh+nITRePnqHTI1ACQfZ3?=
 =?us-ascii?Q?hQSUxI2N3NvQ/en7xY7P3Cv2agP9s/ApGMd+2P4qBoQd8IroYvHvr7ecx39c?=
 =?us-ascii?Q?QOOmkUZRbZ9KYg6/0iACcIu8yGC625eafQpCloC6dotXFBzAlGwht3QC5XFn?=
 =?us-ascii?Q?QAI6jhYa7CYpcYEroaagtqcMBtBLYNT/GNSJfkAhsIr1xu1AGJ0WU0ZCo4Jz?=
 =?us-ascii?Q?IlfpBSQMAOzLyFP4sUBQXGcnYl8sVJAfaqdJdYJYQhNzaQArWdqBimDRzUKj?=
 =?us-ascii?Q?A5U0TFtIdcRN2pjzaVtSQFL4kp4OIgJPe/fFzIQhpCz1nclvwC4eYSLWJK6d?=
 =?us-ascii?Q?9aBPWVFrdFhH+T/4gW+4/kPhh2e2EPFBvpKcPHale+g2TYnnT8YFvXVQuJuW?=
 =?us-ascii?Q?JMgRHF3pFZc9XT1Guy/KDEUvMqUNMqzVxo1y20IByq37qUX8mtCT+91nokZr?=
 =?us-ascii?Q?1sEqM6V0oblpSNarJfaRu0HB/P6S9Y1mBnvqZ7hPxKs1NMJwPLwBqeL2HrqZ?=
 =?us-ascii?Q?kyaDS5hKfe/FUmlWlcMCGk6SL5uFjRptZV5FBhSSbtUU8p0UzZfwIJvhH30+?=
 =?us-ascii?Q?mPhXle460G03m+0Rt3teZY7kw0h1OmDd2q6y3wZzp9CtUs5SKYDaPzwUjGIy?=
 =?us-ascii?Q?xkzPRjTizFHsMsKxUpnf7VSo4PL24SS2alrSkE98qF1jrPbpkigJpZTVmRvU?=
 =?us-ascii?Q?GXlemspChx4ef1xMQUsejAo+6E7Wwk1bRZXl2zSwnnDgAnNo+gny1Uc5KCJR?=
 =?us-ascii?Q?Cp/073BIP9fJUAiGdX8tPniUIlYooEW5N5FrhSr8V1kaCDXtTq2+gh7Aqoyg?=
 =?us-ascii?Q?O2ZnE4Bdqlgp3LPNQX9PEutqp2MNhQ65AM1AKLK183b2Uv9FBSQadE4tX8sy?=
 =?us-ascii?Q?lcjrzmXM+CMGYmu+Lz2oE5AhCwA+2GemN015vZspyy8waLNI4b2u+GXpbBmE?=
 =?us-ascii?Q?PEZ8p2mSxpxnayatfFJq+bHDoc0rF0oIBgrNjRW52Rv1R6zULbCyo3WvUuGY?=
 =?us-ascii?Q?CzS+iuWhWA0l02LMaB+YjQe0SQjpkchlhChKvzWmBS7Rihyqf90f49ozsGee?=
 =?us-ascii?Q?MKecxd61Ut+KwvjP6l4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+hlos1x0cH2aB2T3oGWm9cT9mRtE0rRPZi+9kneILABFLiSkjLtbasqwqw0l?=
 =?us-ascii?Q?WygNWKTp96IscMRloLTRtkbbazN/RD2F2KjeYuplKzkIjwFsM5DIgWQ6Y3Ky?=
 =?us-ascii?Q?tSKQYmOiLMmztovmIfEcECuhvJz/ZsKuzQrtMlE9KjLFlL+aIqYlExTYFNAW?=
 =?us-ascii?Q?/jTFr08bMUBbFhcyRdDW/M/Hi7EaFgAOinVy0CMi0WIa6ZyJGR7a9Zjbc2xi?=
 =?us-ascii?Q?eIO+9caxo87/Rmg5riYoJpivjHZeyH//KPAQXzoQh9xrEYDq2B5/qx+Rv0At?=
 =?us-ascii?Q?KaDJ0BYtGSSDHmPT0NoYroi42OZmiA56QYPpLQunxjgoAc3n2aQBZQ50s81n?=
 =?us-ascii?Q?l1EKNObtFe5zbAg9NDFEj6nArPTgFKVJIKhq8xonJH8ViPj+zUf1t/Pltx16?=
 =?us-ascii?Q?hiyU47MA2Fc2VRPXgMIJLdSYjd75bOzoARYdG+pzIaYTT6m3/vrYOiMPe+nH?=
 =?us-ascii?Q?FB6gWjVxzw+QeDsPSC161tJdUV1kZxmsLvFMPT8DkVFc4gYVYqpTIGSq0+o4?=
 =?us-ascii?Q?La3D8NPXRxWyhzRYPYYISgympKa0GlaTl0FII3qHJoN0dEDsm5UnOl4UIU4/?=
 =?us-ascii?Q?WbYnlm7D6/EcXxEo6xN9JkLYLkhvORdc9qTu1RYcRyACDCd/UAl/hyAKcT7j?=
 =?us-ascii?Q?zBhpN+gQpCPhkJbRdWUNG84/UsBKjsowHFrwofRgAuE3CXlIGHzvcgT8oezI?=
 =?us-ascii?Q?Ylc20U1TRX4IPySmD+kNJ0RcPcYCCsxc6GY23FHM1ZpR5/+NoDU0GrmEXVOA?=
 =?us-ascii?Q?8jKoE/oCx1vc3kSZhz32AauY2igFhOWmsg2eraBzVRPYOXynkHH5scZ0LvBi?=
 =?us-ascii?Q?NHHQ2fW1a1iYohygrPJrtXw336mgKmePJYI7hC43GgZsrM12y1XxdsUuPf4I?=
 =?us-ascii?Q?6YdSN6uAWoA3jthSqUbrj6ffuVIaUqOfKVvhndZZEOf6Aw+bcAofkuwEM8nd?=
 =?us-ascii?Q?Md8EENNDfyTXk8zE6uV6064iQKaJON9WOdT459JhwNi2kXz0eFl2apvPsjL8?=
 =?us-ascii?Q?WuI0TioZMZVCtWTR6m/dIXhAyQSbzgvDRXtjl2Dr48QFQH8gZo44yMqieyp2?=
 =?us-ascii?Q?rXDU5mndYnerRvXFojouWjpdXBmn+9WbLSRNT88F+bXkbnne9D+oouPjrA+K?=
 =?us-ascii?Q?PlUsWDvYTr40QAZI1udtkPpmjxtNkgw3oXfVYvJX1wA/oRvu7xXAYOkri2YM?=
 =?us-ascii?Q?bayu670/eEEdfWIvI0NQ9Eltukt/S9e76zS+K7f05hSyHycmsghUJYRY3PWv?=
 =?us-ascii?Q?iZObp8Pgn678t/15xsPeOYrlyhwpZDhHgn7ijZGPb07mHcE6XMzc6kE3bIeW?=
 =?us-ascii?Q?HSgo0408sf1fDSq8boj2tIY5+76pcj+QhG/HCB8Gbd+j96zY27HmlJoAvz8x?=
 =?us-ascii?Q?6aCQJEgGFM9JLJphVsBdhqtVOj5aWuiKIzhSE8vL+Kgy563blDjHDEY+Oc/b?=
 =?us-ascii?Q?jpZyRshNPrbKOyOpkAt67F71KHBF3sndw9VYkx0ho9PZUNga3B0zL5+PnKxl?=
 =?us-ascii?Q?Zffv+ww0clkLmw9/hiPseP2JjDuOg/kN1wdBCoE5dFLwRBWNlY9sFKyGXZYA?=
 =?us-ascii?Q?TdQYwyE+6b/DrM8yh4YMlhzAJ1RfQYOVLCaAxlNTouBD9YNxyUhhFs02JIzv?=
 =?us-ascii?Q?qRzzaapqWO/wlUz+jboeaeEQgi6Hli7j+3W6tjOtvh6FJ0fhXi53N+tccjLS?=
 =?us-ascii?Q?4AI0PU5HXw+IYnSlvsC5Eg2Ft00gf03xaKXqfSzfb1WmT0AIT/dYCNqXvMtO?=
 =?us-ascii?Q?VEL+o0qt+C/LvweFs3F37iPRrHzRysY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b418f9-f8f3-4a96-2d5f-08de6ef3e043
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 13:44:45.3292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+CcAd5FXSfLownza3yoKtUG9D97yXOkmPX+zVWORvQrnNJnzZvxRETb+r4JYz9Q5cHw4SRG63V8XCgcJYyZLb6SBm6FePXF8Z6K0/DmvAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9447
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

On Wed, Feb 18, 2026 at 12:04:12PM +0000, Ciara Loftus wrote:
> Commit 376faf4aaa16 ("net/idpf: enable simple Tx function") removed the
> one assignment that was performed in the function
> idpf_qc_tx_vec_avx512_setup. Without it, the function is useless and
> results in USELESS_CALL defects reported by Coverity. Fix these by
> removing the function and the logic that calls it in idpf and cpfl.
> 
> Coverity issue: 501500
> Coverity issue: 501501
> 
> Fixes: 376faf4aaa16 ("net/idpf: enable simple Tx function")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/cpfl/cpfl_rxtx.c               | 16 ----------------
>  drivers/net/intel/idpf/idpf_common_rxtx.h        |  4 ----
>  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 10 ----------
>  drivers/net/intel/idpf/idpf_rxtx.c               | 16 ----------------
>  4 files changed, 46 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
