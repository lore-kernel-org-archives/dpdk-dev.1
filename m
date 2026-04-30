Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425AACD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 08:00:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CB8240395;
	Thu, 30 Apr 2026 10:00:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 45D9940280;
 Thu, 30 Apr 2026 10:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777536055; x=1809072055;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TZsBE8INHCv2Cwkq3ZWwwUYpw22iiOd1gVufme9lsBQ=;
 b=FrNPDOILXwmXNpVpUy7/5pVzLnTnBQqX/vP65efIheLlvJo8h84dDhDO
 cy2wMwruS7Uq7I1OjevzvknDjTV8FoLPV0YwylX2xkF6EpRZ+P5FHAYee
 /HDj8oJA4mC1W4m/04u7smku9vDo9wNT+70NfUUQPXiPlVwhkkRW3bhLF
 sdUrQSeLTcW5UEMtITA0+U74vyOTGlt5RBueBuj2QPjOa89oWwj9wo3P3
 Ln541EuRf7EzKzJnclllm9DM+e8T+z/UXuN1wjnKBW9rXoN7lBTdtvtpP
 H/5GHu9swEoAhBThZXzFv5STuibIuRd8jCXKA/wx5hZLvlV18NBj4NvZO A==;
X-CSE-ConnectionGUID: 9wvD2A2VSNaEBiFHCOirDg==
X-CSE-MsgGUID: uaoL4FgcQYqCsG8eYZIQWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="96044156"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="96044156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:00:54 -0700
X-CSE-ConnectionGUID: qKkbm1x+RIapmZK2Nllqfw==
X-CSE-MsgGUID: blUnGWq9S8eDoLiZ3LdKTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="228007120"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:00:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 01:00:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 01:00:52 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 01:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8+JaruhvDA66iGYLguXojt4QgTr4OdSI74FfTr6n3+kchbMHZZ6XEzihbALkKg2nRen3FjOVUhYhJMaih5AvgohmRGOWnHNioAji+qDc7vEPszyj8ylHLvFW9UxHClg824RjnQhmjaUyuyPlDFpe3OB4nerGgcJr78PcoPs0vIiZE4fME7Ol7fyYG56PXKTva6rDNAlDTSXSba+pbWEIUZZ40+5TGzDYD8s5Rr+ujmTa8vCci/usfPyC8s6iQnqYKrVoUfXdYwV9CNbtRplYx9KY9bWFHqawhYcTj/u1Yqzr7F36BLJOgKiohhlG695jtrtMJ3fnzrA6A+b5qCMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijy7NtBm2ZBeI024ux/TslC0PPpRXs2RHqAFK+iQMss=;
 b=J5gS+qFIvmuZ+U0m9OGlrMf/WEig98N3uXj5t3f6WXMkSOEY5FBpbHGbXzb2jhxePB9WpAV1tt5xr3vQTlkVnw0RskUWCAWwCw3sai7a3mOPd3GokbN/wFuzYohlIMBEKgSdP6PhmOUDo+90XEAeDLzaUKIej7uzWdW+/LVekD1jaWYN/aCeec45Eg5QJpAxHB2FyWFkZD5D+ZyYnAG6FmvOo7Sfb7OlMYv0kK5iRyfxr9Cw6IjERMN1g/pfqY0gNvnlPvmFCWnkdPrnjIxorf/RtGQ7YW2bF5AUHXWxAdyeh5qltjbN7KBqe4Vi1PPMfWcG99CThXjOuNjaa6bcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 30 Apr
 2026 08:00:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:00:50 +0000
Date: Thu, 30 Apr 2026 09:00:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: [RFC PATCH 00/44] Allow intitializing EAL without argc/argv
Message-ID: <afMMLYhUUyg9h_b3@bricha3-mobl1.ger.corp.intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260429150449.797b6855@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429150449.797b6855@phoenix.local>
X-ClientProxiedBy: DU6P191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: db9fc868-b2a0-4624-487c-08dea68e980c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: s9MFMwBzHBfYLcWXL4hh1sBeXioKnoI770DoTy08veW+VF7hu1iiK9+vG8c9PXkhUxch2TgBaKRqKUQ46Qb90vVfVCqFzKo/GGXTQgbG4c3ZrIWkI/4Myz6PEyuxnuwnDUOJt7eJgaST4V0nRvYhgMngh4pqyc39gAKsfutxOfB74Rf7vVj2EQr8n3BdlpUsRjd1HFZjrFqoo/SS7LvscUSzyj/QaR3KTYqQykTUStjpQ7XmUVeRWep+khebQah+UTOPjg4oucHAR8nn/WFnYrY4pcCN7ZG0YdpSiqrXkXaeZfyz5oifkOINvGYRoLkc3wKoo74uaAaxN/WUAlWqmVpjv9D2UTot6wKlvv+Z+F21O8GQ4CE4kaHUpqhF4LP2jUpq/XqUQI9H0f2Gs3BkWNR0YLEx3rk4+B/i/etHGNOIjFSCWmnTQ/qSdLeizNluOhcznM3psEZp8b4QR0bzvPf6LEoLaaT4gG7mMl1g0viTtt1MPB7zvcHDO5io+4cTGHPuffYeaNCXagdolkMMnezn9utRI3zvYxpPgxs96ZawBfF32UBP6jmsoX5Y4j4xZJsd0FoPNYqOSwMhg/Z3Gc4W4CWzWkitwY92RdVN2XuqiG0WNAZ98w4Yw4tI86kN/bWnvRtAVUT5agY9EkqSNHHauGakahp7OZrh6zGcfoo2n7xQ8mPrivlbukIE1pbt63gBxNoopSIo0lDGRe/uKnZHslFQTXxknYuR5gABKIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFeCRUnHf8IEZgbB8AflIluK4U5cBybyPKBCsXWK9NM3NR1UsOVk5LqU2BWo?=
 =?us-ascii?Q?JddRF28h7mbwlHVZiGg61XXL1M43HDHfKtj8Bnnfz5ZQnfTRFZleKP4DBfc8?=
 =?us-ascii?Q?YEzwRmYCoR0AgmtPR+wHRd1VNg9ei/lOiWNjrEjhv/vKhtp7LyYSxv5p16WB?=
 =?us-ascii?Q?TlAQplvljXkycLPXcY9OQMb3zDQbResyGf6TOj8tJqBMV2EWzNCQWTXzkTg7?=
 =?us-ascii?Q?N6Yc+Yr5Q3YMSgd11IVO8AD96l+2paBLpjAY+25rYxbhjerLSAmJjNZh+1Yz?=
 =?us-ascii?Q?VONZIjzqClpvAXcz4sJSMtP4HmegpKKvSpJG7RdK956hG+/tf52dwAKCdWGS?=
 =?us-ascii?Q?hNoBrjsjOarkNsqjXEBNDe6+UZc8pT7jx3dutjOzZkDvudUWjOy98TrCtS4F?=
 =?us-ascii?Q?+PsmTiUu+QOTMloSTHMofVMH8qZxuaWmbUJbAqjcntSKv31R58hauToTbzUK?=
 =?us-ascii?Q?THMYRt0QuJJfyxH9s0A0weyXcWJ56rGhgiRgfj+66ch5zPOQ9tgnQZFVUgyC?=
 =?us-ascii?Q?MuY8xnAC/FtxJ+q6r4sZnIXcixdpqliH614oZrgMA74GIRtnoOSbhm7+Y2/8?=
 =?us-ascii?Q?v1COl2Grse/YgQ5WTDUQH2U3wZ/fm/nD1JC96bolMFcZJJktzp0jEcAAYzbU?=
 =?us-ascii?Q?pJG/Gq8TD8ZbQ1PWW9e/io5pb3MzA6PWPeQawK9TWf+5pLhsFqOPGULQ6T0r?=
 =?us-ascii?Q?vNsp4jrRwVEpY3ri3HM53fte4G0lBRMrTcLUhIQv3pMZ4xhRwCySo1xv0dz3?=
 =?us-ascii?Q?Jx7xjDV9eok6DJWMB0Fh46Wd2AUIwv3iDxCkyvO1DE2BcTK5yYocLz5M1/dc?=
 =?us-ascii?Q?ubLOBKBTOMV/HEj1d3VIsO4BBmtdicbckzW8TadA7eX44umd+hvXwUm6qX9Y?=
 =?us-ascii?Q?wlVdU9VwQ1OBbfVyLfLKd1dAx0sJNOt6JYCaEyU3bpnl8/qMRSPXxQl3Hmi5?=
 =?us-ascii?Q?NC7nyMdUtNUZ5gsXehac4dX2r391bXq3MCkRaEaoGnlgg2mhK+17FHBaCPh8?=
 =?us-ascii?Q?DEIQmRoKUK1rDWtJP/hAUTIjQ5sISkzTpH7MyKwIaz8guEUAv9CQiziAeZ5Q?=
 =?us-ascii?Q?G682m3kOOdHAxpGAIrQOF3sTugCIlOzFjzpC6FAQuCGDtqVvnbgCk27aZxvn?=
 =?us-ascii?Q?XCnWgu7wgVqOgmYZFbpmwlniESyynjdDaFqOOgljtpFKybFBmnHbenb8ybkf?=
 =?us-ascii?Q?kmG0AFapYLg7zH5Wt9/AvsGvuJtJYmn+76XdqRTw7PYA5uZUkTv7fhSMV/6P?=
 =?us-ascii?Q?bcbb/GAgV5PAgu2f5A6p+tIDsD2eyBaBVnOIaTXwkkay4IXoI0kgIRykXbO+?=
 =?us-ascii?Q?QzWDxGO1XywTj0jeLNt/9vFfzZGu7uGq60ZtpGIOBtPSy3rergOri3qKIsyg?=
 =?us-ascii?Q?b2wkMj5whdnPOVI47kADshwYHYH513XLB3sy6OI6GTxPlZ/hpqBURwax2S20?=
 =?us-ascii?Q?+QC0sknrbHu4r1yxqwIrKhVdBzuaCLFm/W2VmhIJoIlnuGywk1fTzFh9VC2r?=
 =?us-ascii?Q?uAaz/fRJNrQK1wEW21nf7cc9i3i7NnQE7IxvUH6T2L5Dh+jhNunMaZL98X7U?=
 =?us-ascii?Q?w27zagXK50AcSrxpB22H2Rdj7G5R37/MpbR9ZrVVhXrKRggEc/7T6EIWAU0I?=
 =?us-ascii?Q?1WfUqummWwOUbHFliPoB5XXIvb7YS4bWBYGwF7fn5rNPA91sWCVealWm/7gD?=
 =?us-ascii?Q?D9KgiyuEfMTLGqMkZdgN0iskYYWt1+PZEOlxvczfT5h3/PnVIUv9tDgIQOsk?=
 =?us-ascii?Q?wsxzXC8hFTCF6NdTKjhZc4MJGgw21qA=3D?=
X-Exchange-RoutingPolicyChecked: IHwABUFbtWiosFSjr6C42Sx+YWl9+bHunfZpR4KLV8/3P4lK374DodIUaf3tlcqtRl6zxK04Um77f44RWvJ0BjQodSI91SdH0v+0J5d+YpJu8f11B5QUnnGXQZf5/TxuFIBgAZQtWxtFozivD6yknY7cOuj7Sla5kshx9Qk39jP4XE41W/57LMyJb5XqnPMSXGksN8KFOHY289zsOoTfHAWKTdBhntrSCEMqWcFAEO3ElrcHvH8/clfqxrUsWNRuIDFGlTIRoCIwEUGMFeizWNFX4Qd3+o0LJKigGQQih/awrso0d7GtYAKdtAWx82jhYTwamebXWMJC+q9Lo4M/jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: db9fc868-b2a0-4624-487c-08dea68e980c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:00:50.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eDFFOMv1iwS0TsdbOXMuuDVdT/hE8OXK3PODot6udS4HWxba4GhtagqPyDDSBvgCVPeas23x6mi8/0Gl6loaOqcIEo1RQEWAefZKoghDT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
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

On Wed, Apr 29, 2026 at 03:04:49PM -0700, Stephen Hemminger wrote:
> On Wed, 29 Apr 2026 17:57:52 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > The ultimate end goal of this RFC is, as stated in the title, to move
> > away from argc/argv as the sole means of configuring EAL on init. This
> > set therefore looks to:
> > * rework EAL so that we have a generic EAL init function taking a
> >   struct-based configuration
> > * provide a rough *example* of how that might be used to create a new
> >   set of C APIs to be used by apps to initialize EAL without having to
> >   create dummy argc/argv pairs. [A side benefit of this is that it
> >   makes it a lot easier to initialize EAL from other languages like Rust
> >   or Python too, because arrays of C strings are not the most
> >   user-friendly for a foreign interface]
> > 
> > Therefore this set can be considered in 3 parts:
> > 
> > Part 1: Struct rework.
> > 
> > Largely for legacy reasons, we have a number of different structs and
> > arrays holding eal configuration, without having clear guides as to why
> > certain fields are stored where. The first ~30 patches rework the
> > existing structs - rte_config, internal_config, lcore_config etc.
> > into three defined-purpose structs:
> > 
> > - eal_platform_info - contains the raw HW info for the system, details
> >   of CPUs and hugepage mounts. This is initialized on first use - even
> >   before EAL init is called - and is then immutable, since our HW should
> >   not change much underneath us. Its early availability means that it
> >   can be used to sanity check the contents of the other structs as they
> >   are being built up.
> > 
> > - eal_user_cfg - contains the config settings passed in by the user. For
> >   existing rte_eal_init, this is built up in the arg parse stage, and
> >   it's contents verified against the platform info, e.g. to check core
> >   masks are valid etc. Once argument parsing is completed, is also
> >   immutable.
> > 
> > - runtime_cfg - basically all the runtime settings that need to be there
> >   for DPDK to run, or which change over time. Largely combined content
> >   of the old rte_config, internal_config and lcore_config structs. This
> >   is initialized from the other two structs by eal initialization and
> >   can be modified by EAL at any time.
> > 
> > Part 2: Cleanup and Split EAL init
> > 
> > With the 3 structs clearly separated by purpose, we can then do some
> > cleanup of the code, before - in patches 35 & 36 - splitting EAL into
> > two and providing an *internal* struct-based alternative API for
> > initializing DPDK. The old rte_eal_init function still exists, just the
> > contents of it after the argument parsing are put into a new, static
> > eal_runtime_init() function, which take the argparse output (user_cfg
> > struct). Patch 36, adds a thin internal-API wrapper around this static,
> > which is necessary to take care of things like the run-once flag.  [This
> > wrapper should never be the public API, since the struct will change and
> > therefore be an ABI break. It's designed to be used by other wrapper
> > libs which provide a stable ABI for config]
> > 
> > Part 3: Prototype of an eal_cfg library
> > 
> > Once we have the internal C API to init eal using a struct
> > rte_eal_user_cfg, we can create new libraries which provide alternate
> > ways to build up the user_cfg and initialize DPDK. Patches 37-44 have a
> > rough example of such a library.
> > 
> > - The lib allows a user to create an opaque rte_eal_user_cfg struct,
> >   which can then be modified by APIs to get/set various parameters
> >   before calling rte_cfg_eal_init().
> > - An alternative way to do things (not prototyped), may be to have a
> >   library that creates an eal_user_cfg struct based on the contents of
> >   an ini file using the configfile library.
> > [Both these options could be used in parallel. Note too that both have
> > no ABI implications for adding new flags, or making old ones no-ops!]
> > 
> > Bruce Richardson (44):
> >   eal: define new functionally distinct config structs
> >   eal: move memory request fields to user config
> >   eal: move NUMA request fields to user config
> >   eal: move hugepage policy fields to user config
> >   eal: move process policy fields to user config
> >   eal: move advanced user config options to user cfg struct
> >   eal: move hugepage size info to platform info struct
> >   telemetry: make cpuset init parameter const
> >   eal: move runtime state to appropriate structure
> >   eal: record details of all cpus in platform info
> >   eal: use platform info for lcore lookups
> >   eal: add RTE_CPU_FFS macro
> >   eal: store lcore configuration in runtime data
> >   eal: cleanup CPU init function
> >   eal: move numa node information to platform info struct
> >   eal: move lcore role and count to runtime state
> >   eal: make lcore role a field in lcore config struct
> >   eal: move main lcore setting to runtime config struct
> >   eal: move iova mode and process type to runtime cfg
> >   eal: move memory config pointer to runtime state struct
> >   eal: remove rte_config structure
> >   eal: separate runtime state update from arg parsing
> >   eal: move devopt_list staging list into user_cfg
> >   eal: separate plugin paths from loaded plugin objects
> >   eal: simplify internal driver path iteration APIs
> >   eal: move trace config into user config struct
> >   eal: record service cores in user config struct
> >   eal: store user-provided lcore info in user config struct
> >   eal: clarify docs on params taking lcore IDs
> >   eal: remove internal config reset function
> >   eal: move functions setting runtime state
> >   eal: initialize platform info on first use
> >   eal: remove duplicated scan of sysfs for hugepage details
> >   eal: add utilities for working with user config struct
> >   eal: split EAL init into two stages
> >   eal: provide hooks for init with externally supplied config
> >   eal_cfg: add new library to programmatically init DPDK
> >   eal_cfg: configure defaults for easier testing and use
> >   app/test: enable testing init using EAL config lib
> >   eal_cfg: add basic setters and getters
> >   eal_cfg: add hugepage memory configuration
> >   eal_cfg: support configuring lcores
> >   eal_cfg: support device and driver lists
> >   eal_cfg: add APIs for configuring remaining init settings
> > 
> >  app/test/meson.build                      |    1 +
> >  app/test/process.h                        |    4 +-
> >  app/test/test.c                           |   14 +-
> >  app/test/test.h                           |    1 +
> >  app/test/test_eal_cfg.c                   | 1323 +++++++++++++++++++++
> >  doc/api/doxy-api-index.md                 |    1 +
> >  doc/api/doxy-api.conf.in                  |    1 +
> >  doc/guides/linux_gsg/eal_args.include.rst |   38 +-
> >  doc/guides/prog_guide/eal_cfg_lib.rst     |   23 +
> >  doc/guides/prog_guide/index.rst           |    1 +
> >  lib/eal/common/eal_common_bus.c           |    4 +-
> >  lib/eal/common/eal_common_config.c        |  221 +++-
> >  lib/eal/common/eal_common_dynmem.c        |   66 +-
> >  lib/eal/common/eal_common_fbarray.c       |   10 +-
> >  lib/eal/common/eal_common_launch.c        |   25 +-
> >  lib/eal/common/eal_common_lcore.c         |  230 ++--
> >  lib/eal/common/eal_common_mcfg.c          |   44 +-
> >  lib/eal/common/eal_common_memalloc.c      |    5 +-
> >  lib/eal/common/eal_common_memory.c        |  104 +-
> >  lib/eal/common/eal_common_memzone.c       |   24 +-
> >  lib/eal/common/eal_common_options.c       |  823 +++++--------
> >  lib/eal/common/eal_common_proc.c          |   43 +-
> >  lib/eal/common/eal_common_tailqs.c        |    6 +-
> >  lib/eal/common/eal_common_thread.c        |   81 +-
> >  lib/eal/common/eal_common_timer.c         |    2 +-
> >  lib/eal/common/eal_common_trace.c         |   30 +-
> >  lib/eal/common/eal_common_trace_utils.c   |  104 --
> >  lib/eal/common/eal_hugepages.h            |    8 +
> >  lib/eal/common/eal_internal_cfg.h         |  376 +++++-
> >  lib/eal/common/eal_memcfg.h               |    3 +
> >  lib/eal/common/eal_option_list.h          |    6 +-
> >  lib/eal/common/eal_options.h              |    7 +-
> >  lib/eal/common/eal_private.h              |  108 +-
> >  lib/eal/common/eal_trace.h                |   11 -
> >  lib/eal/common/malloc_elem.c              |   15 +-
> >  lib/eal/common/malloc_heap.c              |   41 +-
> >  lib/eal/common/malloc_mp.c                |    2 +-
> >  lib/eal/common/rte_malloc.c               |   14 +-
> >  lib/eal/common/rte_service.c              |   17 +-
> >  lib/eal/freebsd/eal.c                     |  271 +++--
> >  lib/eal/freebsd/eal_hugepage_info.c       |   71 +-
> >  lib/eal/freebsd/eal_lcore.c               |   16 +-
> >  lib/eal/freebsd/eal_memory.c              |   46 +-
> >  lib/eal/freebsd/include/rte_os.h          |    2 +
> >  lib/eal/include/rte_eal.h                 |   35 +-
> >  lib/eal/include/rte_memzone.h             |   10 +-
> >  lib/eal/include/rte_tailq.h               |    2 +-
> >  lib/eal/linux/eal.c                       |  280 +++--
> >  lib/eal/linux/eal_hugepage_info.c         |  219 ++--
> >  lib/eal/linux/eal_lcore.c                 |   13 +
> >  lib/eal/linux/eal_memalloc.c              |  168 ++-
> >  lib/eal/linux/eal_memory.c                |  153 ++-
> >  lib/eal/linux/eal_timer_hpet.c            |   21 +-
> >  lib/eal/linux/eal_vfio.c                  |   11 +-
> >  lib/eal/linux/include/rte_os.h            |   10 +
> >  lib/eal/unix/eal_unix_thread.c            |   11 +-
> >  lib/eal/windows/eal.c                     |  177 ++-
> >  lib/eal/windows/eal_hugepages.c           |   60 +-
> >  lib/eal/windows/eal_lcore.c               |    6 +
> >  lib/eal/windows/eal_memalloc.c            |   37 +-
> >  lib/eal/windows/eal_memory.c              |   14 +-
> >  lib/eal/windows/eal_thread.c              |   11 +-
> >  lib/eal/windows/eal_windows.h             |    8 -
> >  lib/eal/windows/include/rte_os.h          |    1 +
> >  lib/eal/windows/include/sched.h           |   10 +
> >  lib/eal_cfg/eal_cfg.c                     |  918 ++++++++++++++
> >  lib/eal_cfg/meson.build                   |    6 +
> >  lib/eal_cfg/rte_eal_cfg.h                 |  903 ++++++++++++++
> >  lib/meson.build                           |    1 +
> >  lib/telemetry/telemetry.c                 |    4 +-
> >  lib/telemetry/telemetry_internal.h        |    2 +-
> >  71 files changed, 5450 insertions(+), 1884 deletions(-)
> >  create mode 100644 app/test/test_eal_cfg.c
> >  create mode 100644 doc/guides/prog_guide/eal_cfg_lib.rst
> >  create mode 100644 lib/eal_cfg/eal_cfg.c
> >  create mode 100644 lib/eal_cfg/meson.build
> >  create mode 100644 lib/eal_cfg/rte_eal_cfg.h
> > 
> > --
> > 2.51.0
> > 
> 
> Lots of AI feedback below.

Thanks. This is still RFC quality in places. If folks feel this rework is
worth doing, some further cleanup will likely be done beyond even what AI
called out.

If I do progress this to a V1, I likely will focus only on the patches
reworking EAL. The example "eal_cfg" library are included more as an
example of what's possible, rather than for real consideration. It also
makes the patchset smaller too, thankfully, because it is rather large, I
realise.
