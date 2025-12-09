Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8674D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 08:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB3E940270;
	Tue,  9 Dec 2025 09:42:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 20E8B4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 09:42:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765269740; x=1796805740;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yzO3DvLgOmdSfZcubbz6XPWQeBrzDLTvmH0K9xmc9xg=;
 b=MOB0CFl4CwP5y7M1b+RsjYS3PEea9sb9+kSk+DTKHvJPcnOJKmWVkRDd
 VtAfLUQXA5l5oHpkriZiv3iLVobQyHp8SS7tfYa/KM4sgyBxzL3GMsDUL
 hmK+l1R1mWrdUc2/KlhwC+QiqohJPPUn8URuJFiUDihREu6iAfFUVNiCF
 8+bInQbln/KRdyMZbdCi49SwV5Exj6f2kKgLaVFz45tPXcAsE9j1RxpGj
 B8fm/VkgWld119qoOKOYJIoQP+qM/qoy6fHdHUn0pGHrRHcAP1HXbMibZ
 FsPpOL0w2O0R4xIkMujkRVqudKsAg95g5BC1YiCm5NoxzUXfUFE4vXmyo Q==;
X-CSE-ConnectionGUID: yOH7lUIFSYOpA6IOjJp8nw==
X-CSE-MsgGUID: kxdRF4RUSti7P1lTOHD9Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="84827849"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; d="scan'208";a="84827849"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 00:42:16 -0800
X-CSE-ConnectionGUID: YnSfnA6OTRyt9uc60en8cg==
X-CSE-MsgGUID: kh5ZbHPjT1i8PD/LwGI0vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; d="scan'208";a="219517847"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 00:42:15 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 00:42:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 00:42:14 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 00:42:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fnts7jdEkn07nqpoA4xSHhrSo7t36tPrm4QXQ+e12CLSZQQa1n4g2mCoUhqaz37EtrgwVlGMURbYqUtKCCgmnxfs3OkHkXHfRruOignyZ0oW45QTUCFtTUwYBl8Tu7w8KriqNvAGJxgzmYg1Ct15jyFNt1diKsEcM9V0pZr2MRVq74lbflJX4vtPYjzwnHPuF7W06aZI15JYMYnwUOVefcnP8pM3veXImKZIc3Jramk1iLMbKjACWY6MpZb+EVNrjinPmgaCQ7bowOkri/gKeXUa+uGov52t6kinT7i6w5onGqpi76YD9D/9ytKcA2FYKDfYu9hvIE24Euh66GwgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV2AWRS0cSf3/UC+mMhm9ZPpYDKD5QryBHHXYUxErWg=;
 b=lrIjwk3KtN1VqyV10uwIYCKq2l2baIlnNWO1oxQZwL9xocUp43DEXJ4q2vEnPGkgpQ4NAu4EC98MVk9Llw3chYWthDG+bYmsI4n0tyFDD1INd0MgSGTp552B74sPZC3wQcD/cnDY+s/2b8uTIwA1/gkUUZxMvZREvERzn4jrjPpwdJ0GNFRe7aq9MoQHj/IUUQhw2iKGJYoj4WxPg0eAD8A4p2z4T/m7DZ59ViQU8Ast1uqFQYQVKcNxFn6c9B508V1G9EAl5FxsYGpkSFANFtB2Dna8ARpZgZMNf/DdIgBCiPUWmHgJ7rI7Ula6r4ks1J7Nfn5gM29KpXiyuhNXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Tue, 9 Dec 2025 08:42:12 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 08:42:10 +0000
Date: Tue, 9 Dec 2025 08:41:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 05/11] eal: add internal APIs to query loaded driver
 paths
Message-ID: <aTfgwAu1Md6MQaiP@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
 <20251208115245.3809624-6-bruce.richardson@intel.com>
 <20251208110922.3a442388@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251208110922.3a442388@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0241.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 836e8aff-6378-4967-5e8c-08de36fecaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mWS8X+zFdQldPZTfoWIuOKkmk+Ru55PiHq9MLsFMTdrqyh2vqsEbDjOxdmMV?=
 =?us-ascii?Q?dUVCpqAgxtOt/wkFHZFEJVnMpqIT8hTIsFcBsv+ls3zUepMytJdGVPLpUFfT?=
 =?us-ascii?Q?KgfpOGAJStJnL4lHdpYHcZeAFTo6SF1LaiaC5U3twsx77Xi7bYdmHIBmB4OY?=
 =?us-ascii?Q?E+eLbBVTjo+7Gjhtn3kXO0A+rcGsD0+e4WkmBTmj5sdlImtPDgZ55wD/maiT?=
 =?us-ascii?Q?a4o4BgflYQ1/WUsH6FagDz3C5zZh+c5kv5M2aD4USIIjY1+D6En/RNS5qU9o?=
 =?us-ascii?Q?KmWnASuAUeYdPaUubuxcPL+UA3iH8p5Afsl2E9IDVTRtE2Jyaabw1+X68PU7?=
 =?us-ascii?Q?za2nCtOrwf7t82fMz4dZHvtbFjHm81X0YXuTVvgXyNy16R6xdByxiemOVqqH?=
 =?us-ascii?Q?C4QKBKPGeqG8KznUXlpiDcoX+XblHwDBLIiiaSIMnD8tk340XrPe+Zoh6wJz?=
 =?us-ascii?Q?YDQ2nmDbBNFG7TwxyifMARVEU95PtUwwxZ8nrOv28dEb9V9UNJoYvrazI9xC?=
 =?us-ascii?Q?zAn6pFWhvYsv8HTXKZ7SIjWiCFF7Jim4h1Ohpg6zN5LQZfHIoEMUKurQfmNY?=
 =?us-ascii?Q?J66uo8sw+hKQ20+EcmjCWUBETZEEJ2RS566485QXRoZVOZQXn/okKfJA2QRS?=
 =?us-ascii?Q?VXpOOQ+HfY12lrk2HYFt+Z4b6m9xh4zxTMY11lTrU5h4ZfvFZ99+804UWia5?=
 =?us-ascii?Q?JgbkmPSHAvMgmveETeJAr0kEym0JERjd1lIAmx+XeSJQXYTQHBHkmj1WDyZy?=
 =?us-ascii?Q?GZ/955fFTkwIrHjZLdwMb+q3pOKbCIOj6aJ5QRtM3+p38hJWGLlVeMbBBPQa?=
 =?us-ascii?Q?TRNHqzseNtFs5AiloqkquC455M+DPzPzjmRheSNCYLa5J0lu0aJC7VXYGeJI?=
 =?us-ascii?Q?9cvmerHdXBA3EoYTmmaj9Ei/LngArLC0caH61K6rJOYkB3Q2g+pdrTXYdxbQ?=
 =?us-ascii?Q?/S3DviYXcWtmABLnZxwQ86cbk+kqVXX+IkZSGfs8c/nULAY7y5iCcjoa5o+S?=
 =?us-ascii?Q?MRQROcdXqB8QbA0YU8acg44f8/G9hJfwkF7icQ/E2nDHo/WYxLpJGnqGzbF/?=
 =?us-ascii?Q?Vc3jjvjzUkimkb9H3sA4yQxde/cQATfhMxnBM75bdKzbQUzoCbts5qvyeiVe?=
 =?us-ascii?Q?/QDYNohgoQfirlFHoyRZQgksizWVUtrIlPn+H1xVaQwug/o0wA3241xeqqWV?=
 =?us-ascii?Q?OE1nbvpDyBNhOlstZ13avvbFLsdYAwpPx6rIbCWEr/uBUB6cOC+KE6Khu/nW?=
 =?us-ascii?Q?ke5qJgsdD0mmVwcSR4BYRi22bis0gzWalYKWZVdhG4wGNva0KtQPY301W4Qm?=
 =?us-ascii?Q?da7+fP4aNmz5PKG0WI+bpgdjkEwN6nWwCgc4L7j3qMx9PmWqLvOXevzeZ/SD?=
 =?us-ascii?Q?VRPrisNZxbceYnIIypitChpiud6mP1HNtxo5b5gU06cRQeocKEu+l/fyY3eR?=
 =?us-ascii?Q?O6p/V7gpU13N2vPOqxgLBfcc/KuxWuW4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7UZLOq4vSz0679isONW9/0zIyDjeCReC/+kqMMfivP8IgymEYgAoYFQ1eVO5?=
 =?us-ascii?Q?Sh33m7+mLke/6MWUyaGybBrBd3XziXpfz4iI7AQRet1YbpPWvNLbEkk/SPLI?=
 =?us-ascii?Q?Af+/cIQ6ZyOrZhiRDdf41d3uBSh+CwbxXrKSzZ9dE4ZMeSGxdzDspdN4VmEi?=
 =?us-ascii?Q?4E/RQZc5R+OpO0SfgpWM1OOC0Sp03SZePi97CJC2cayxogYreG2YkKL6zXy8?=
 =?us-ascii?Q?fYvRdUwslnctX+p8JwhNbnwyZnerLce/NNWpXxs+RCWlgfzxDHGKCJ4DvEKM?=
 =?us-ascii?Q?UgXQ46LOKT7IpTuaxHOY+LgLA+sGgbcU4hk5Yq8Bu909UO6Zu8bKbyKGJuex?=
 =?us-ascii?Q?e9feQQtMf++1fmTWUyF3AD7c8HYJHv5633Th7IBW1+fmKKxBjLcF87WAKzHD?=
 =?us-ascii?Q?r0LZvLQC9zkYhepwpEAGqq6OxPWYJrVdh/8tdS3VS4sqTfB9oNHdSQBryChH?=
 =?us-ascii?Q?BMOf4l8GUPkyKRVqh4f0RSVQC0kCTWUoyJY7a+JMIo96VKa+g83rKTXShLvR?=
 =?us-ascii?Q?TTUMQpD7NwVGIIlDdM1uxW5bNeGlLAgU6wGA88bgBpb7zXjGAtBPF23IKZac?=
 =?us-ascii?Q?44zA+R/Uc0IoBs4RyaFbKTGn5pRhfIS7NsgVkdHV4NIYyDS2JWOkJqAA5SRl?=
 =?us-ascii?Q?63UuwtVjgHNHiTRlUWfTgDtkWSw8q3jzAQAGwEVEXOZPN7A1aO96TX88eTw/?=
 =?us-ascii?Q?DhxwEObFM//Om/olp53IfC06hOiAgcauRWlHl3a1vBw45geMDiWKD+CmA+6J?=
 =?us-ascii?Q?COqFExG5ETooFVgmDdA6j5s/nbQmDHwcQg7baCxh6pDfebgJ6u7w1IPfw8xl?=
 =?us-ascii?Q?uO480kHOA6CtezvVP2+3lt2wJjS08foxrqXtVIhNiNgrPTXIAimD+R9Bkgrc?=
 =?us-ascii?Q?+013vk+SGbyAkKZDxSOrM4pgxdJ5OYgNgBxlF8ZLqtfIB0gihsqUhD14WfDL?=
 =?us-ascii?Q?d1USkMK393jmatzjBPzvsNi5xVrwpedrebhwBXBZ52V3CUTSluJyIAgdYW9O?=
 =?us-ascii?Q?8xGUvXQXmvB+Pf3dlkf0grosgnTAPZY78pOedNBMAT4uEj/2KaUhaclaMNzk?=
 =?us-ascii?Q?XsO1rF3R0rvIigWekl3ji056k9H+DoTSlWdXCFiROXdE6kWmGtOtekvjq4lL?=
 =?us-ascii?Q?u6Z8wvUaq1yrL79vBwSXslMQH2SZ3QxP2JS4zkZTUdEpKGYGrkvizRl+t3HQ?=
 =?us-ascii?Q?ur1GraSTRy4mKgB1Us6fPDw9X+nxSEuBqa0NrHxWSrIV+H+XX/gbBT2xt6NU?=
 =?us-ascii?Q?EH47CTOEPMtl4FvvuC0dCF2AU+zG+l0OxuZoQD1JBumR/IvIugE9qA3TevIj?=
 =?us-ascii?Q?8L3o5iLQIso39Cld/2jXruXJMnPU/QBdEoUb+dedyhcnzP5R75InVaUCqWsW?=
 =?us-ascii?Q?22ZQMskhLOvO6tkPGF6U6Yc8XTUJ/K+crBhVPW+TvDywUL7UJwbdNn5ceQXr?=
 =?us-ascii?Q?Sy38JU/mDKrC1TJ0M/b3M0OLnIcwVJR8fbLVk9lNRakQdj+U5IdyU6q4n/RQ?=
 =?us-ascii?Q?6RQFJhIsTJsoLCU4qdcVknwoXQ073sV2e7JlGh52NxI1h3TTtSZJjWeI4x8d?=
 =?us-ascii?Q?x8WD3MOLIU41TuuKoAYImBwitd51wgN4FDWlD0bHmEqe97p3BqasMQm7ESP9?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 836e8aff-6378-4967-5e8c-08de36fecaea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:42:10.1358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCU9Z0Zn7m7wFL7iIvGV8DS+085BffOOKWDRhhCAlbhRo6EY2S4TtxB7tbcbHfJj+CbHBHKDc3BYz2ExmNvEjMBOSwqRZQ+DlndF90aycgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
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

On Mon, Dec 08, 2025 at 11:09:22AM -0800, Stephen Hemminger wrote:
> On Mon,  8 Dec 2025 11:52:39 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> >  
> > +RTE_EXPORT_SYMBOL(rte_eal_driver_path_next)
> > +const char *
> > +rte_eal_driver_path_next(const char *start, bool cmdline_only)
> > +{
> > +
> 
> Shouldn't this be RTE_EXPORT_INTERNAL_SYMBOL

Yes, will fix.
