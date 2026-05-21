Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D6CD4F5E
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 08:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E3040290;
	Thu, 21 May 2026 10:13:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D63EE4028D
 for <dev@dpdk.org>; Thu, 21 May 2026 10:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779351217; x=1810887217;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nEqDe258HvHOGJyMxZ9TPNN7ZnXP11M3e7PMsYsv0mg=;
 b=CPqnYthUid4mqgchf/MU8DNaPdg9mlLNyzH6QDjiSzoud6p/ClP2N0/d
 BDdJBbOG7zCsijdaep/IVlXSOwcGLYwH+nj4gkZsu6Y9ZlpS5oqgSXV4L
 v9ZW5nEB+o39I4OVaR4BTzUv0IXIxWZZwgt08ZwbBWLk0lGWZ/OO4URnv
 4H8rCoc1ToRj8QaF7WNZMGqy6bzeA9012Tb5BlQSQcfvxyHIuzVVFKqDf
 jctdJpanf7QGczhZELixu8e5vjc6VWYIwxcmX9v5y6+lnhQA1RBIT9Phn
 vj32qEz6CQwdL4MBMquLF9gYNYUq4lPuI9z3137noEtcCCdLgmShMAOSW w==;
X-CSE-ConnectionGUID: pSGsH/MzTbuYmlFsAu2vwA==
X-CSE-MsgGUID: xPxqht0iTOaX788PMLIusA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="102940392"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="102940392"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 01:13:35 -0700
X-CSE-ConnectionGUID: cTkXXpsFTgWFl8+Vfy+DXw==
X-CSE-MsgGUID: Ia9pSk2LTq+9fboqc27n9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="245496429"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 01:13:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 01:13:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 01:13:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 01:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad820TX5sETdvtPyuzvx3hICLmZZf/ynak3vgeQc+kviSLbCKq7wkkqV/KQ0KgE5bXkMcwHUsGLl1H/sOeOWLIUrXd2B9tfb2LR7CFj5eCSa1CqGlrVBkRjeuPwa2s8bVAC+4oD5Uaur96+osKvxs83haGnxY4kMSVIoWizj22DEff4on6OVOQ83U5a4BZcRsYoKWgETw2MYj46Myq20ZfLZwqyIVkOgXDwrIZNK8C3fjfBLmhphPHCG2xuw2TyGfdTU6KIzUYW73XluROSfYUSAOPHUBsGcK5Hj5qqw4wnM/PSKey0KIAVcCKsB90g+OguETN1hqRfsg5gTa3tezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEvjmSpEJ8BT1COqZNi9nMBGmNiWo/Y5EBCZaLsPBvM=;
 b=Mb8pJJ2aG+Yqa16bdz/c2ZwDLLpuDvSb6yNTnUNL+zN5ClcOBG9FpfTZDW+rRxpaImzeLWJyUQs/pkR6VTacv5uaf2tLPOJFJcDej9IxcOEulY85ynKrxPR+0QTY02MNUUg8hJ77pg7Mr7S3k7JrGxUbkLpQ1C4KT2Jf4nHSZOpz9T8DIKHubMFmy1F6RHHRYjTOgKMgZZzv/KZNbTYc9wsCT0vyCdYVzMRoPJvTfxAr9QMsleIYir+JFwPWi2gnFgk1P8SoE2HfXa3YSMOE+12ijupBCezTCzjbAMrU3KhTvsqZ73Es7ftyyC0a96A59EIf1Sbzh5w9ohKsHFcQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Thu, 21 May
 2026 08:13:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 08:13:25 +0000
Date: Thu, 21 May 2026 09:13:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: Re: [PATCH v2 00/23] Consolidate bus driver infrastructure
Message-ID: <ag6-oN6WXxV3viTz@bricha3-mobl1.ger.corp.intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU7PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bd949f-ffb6-401a-f8dc-08deb710d4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: sJPvBas1PFsG8SQkVb1zT6ua036rX9ckC3ZclAT+a3kNNW/H2Sg0zAz6XEI4rDOMivZPYFx5eeKAt9oDoPVunNQo5wZaZlhdIqBgRU22iMOI/jhTVJLm0w+qLiIVaJ/BOaRlWPIXNbVkxoXvRjA8oqCmFNsdx1Y9WUJ4WiDIKseC7oPhsX8yEneb2Rr8Gyg6D1OvF8Wg45HtotV2OPb+OBd6rPb0bC6yXTJDFmOj+RPSLPHUmlOr07gel+XrR1kd/GmIVbMHE+2OcxKFDdAOzxfh1lv1eIQRa4+2LXn07sMj0Ceh5KJ0oej2sKniVWnHWUlzjk3G7t+zv9WS/SETNP62VZcg/XtZ8cf7aMv4cVgltWu5kKbpkahvlwwQ/BAooNh+x08fWFhI4yRaS6Ecj6xeFoqkrmuVtigCC7Qh7mRz78qnaZCdAEAhePUx67/u/UlkfbuAufiWbkP0ab4c146bGnrJicZYkoinvXFOW8RkgZoNFVmTDIem9L99/fs+oPVmOXy1gUyyvRv/5IGIaHBPSyi2dne2DbvEFDWnvtH7cZq/wGKIT1w5PZlOULePhNckzi14A31qISSnlT+Gx+x8U1gTJXJG8pN6LMa0W3oMHgn8agrj1FtVOFzGJEChE+ujQ2a8Xukz4rTMt5rSvflAQscqRRurVaCYUODud3yKL0S6gw1pu8oy2pc8l4/K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bgv+EaQsy9V2e3hkEaqaqp0p3GXfAfaMbYwOBU/g0a8B3fYcdTfN3G4LP5hM?=
 =?us-ascii?Q?1e0aydFWbgPx9QTMI/y6TvoCOX6XzLHURgRoWJpYUGN5vwRU96q3t3ne6/Dh?=
 =?us-ascii?Q?19cWnKMaaF1iUNJSKIraPVNX909h1WDaoeaeVxIzUUA9PiA3b6tbjRtrO69L?=
 =?us-ascii?Q?7xzRN/I0JK09RKTLZ72SYeB85y7jAMo8YAI2fcgRzccMznpjeq1c0IwHhpPH?=
 =?us-ascii?Q?iGQjoQcZI3fTVTl1J0s55OUsLK8HJeIeSLQiqHbqBzr1Ff24kMHhgTzKaBnI?=
 =?us-ascii?Q?GV5AkU+x+8cH7hPXEiFyvFx6+ErQeqiVhbxXknPxnX3xdzd1Ur+61ILW37we?=
 =?us-ascii?Q?PeXKItrksPRPqxnvHIei+F5QXnIBiwcF5YDIlIhaBBedON1RA2fyjWBhcW6i?=
 =?us-ascii?Q?lKiawMrgelsNZPbrL11Mek2ZTz2uh06vLe8SblwGO7K5+cgAv1mfDsNtB6VH?=
 =?us-ascii?Q?cmhQ/yWiLU+UeZCMxW5r5OtTLexASxWuOGeddeAK1AT8NYRA4WCafi5fjUbh?=
 =?us-ascii?Q?jvEE36vsFPXmL6NEo4yb40IBUDCnOQmNAaskSjpIZMiVg363nm3PCmrGpssS?=
 =?us-ascii?Q?aGpmbf6KYWy5h6e8iPjr2aMK1o1GdXJl+ktIGEIf2japlczQzrgEgxEaFBV0?=
 =?us-ascii?Q?/o7BV1TVsSxlfIvPq5bAgSsiwZAdVV1uQM04XKgU2kqkwYRKuS9R1EprnZcH?=
 =?us-ascii?Q?cBCPGxNBIrfyMYFPhyQuQvBssRk9a4k1xsmUyRiFDitI7Ko9JkmOyxdALeJw?=
 =?us-ascii?Q?BFwnKIs5X+2i9jPP5YP/Ujjsn9jDIDrALd4++MxrND6hRxn801K4AB9MO6Zc?=
 =?us-ascii?Q?rPNddeCzA/uQaWPt+sTq6Ew1TkB9t/WrXn9eMCgvnx3Sk1RCMas1WS91OVkE?=
 =?us-ascii?Q?xCEyUhgH1xoG+Gb/1XCs8yxyFKpPqtwUUMvr7egOEUys4NlLGxs64WhD9K9S?=
 =?us-ascii?Q?CB6PTxDDLcyPmjR/kTS7A5mEoGM+VvfNHuggpWqhiNcFfxcUGckhzmyVxk1X?=
 =?us-ascii?Q?Hfrft8CGfiTDMYkEGWW8zC9Fg4FmnPkysFIYjCRTB58vBj1n2n8AbIHrmp8P?=
 =?us-ascii?Q?n/psguBG9NYxRNO6NyraJzsXyTfXcgAobni/p3pZ9oN2ardp1v0H+jpVJuhv?=
 =?us-ascii?Q?A7Otb1sJUMcJvVGtUfWSR5wAdyy6CoN8H68FHt/C3W9USoT2su5PhISPX/wI?=
 =?us-ascii?Q?st3GHOLRvaX3gQCmvAEmTlQ6M23OU2AU6w+j8jAqUbTuWgpwiG8RCt2v2fcx?=
 =?us-ascii?Q?di4HOrIGDcYC/M6526WErdqUySzw4wFqgtUdURGpQ4jvPKvwBVNwcoEQr5we?=
 =?us-ascii?Q?7V6HBmfh6dxSq+6Jp/3Q6MyPTFG8LNityDQrDQNA6SRJYeGs7vJ9zt5HGowj?=
 =?us-ascii?Q?sPd8flSo4r29sXVemjRMOqGF5fD90ezJd1T4FM/bmMIuLtGY3ptS98wU7AfR?=
 =?us-ascii?Q?yeFguNjFo8Mu3lNjfFMWPHrzvU7cuQIgb9r76lazSQvwS8Rk8emgKUs+mH0G?=
 =?us-ascii?Q?mVPcj1nBlC/JZxI5vRNJtO8QNkbh9nQcqqRO1piO5CR6L1PfqKxAiesbKSKn?=
 =?us-ascii?Q?CrxBINDSmsWaMTIf3eKKmVlieLN4wosG9eNaQxawabW4f/Khyz+WdoFIPG8o?=
 =?us-ascii?Q?h1FCJC0ylI5xLSa24TDM/3sdIbPjaRcXIwDiznc0TG5gqGVIeFH6eZ9W9MYc?=
 =?us-ascii?Q?xyEw9+zjHdfktcHPPJJAnJKl+q1LZeYYHcueaaA3M7OicijL6BxBWWMyic9T?=
 =?us-ascii?Q?RA1G9XFvsH3Lj1m6NQhMgFcNE71PLnk=3D?=
X-Exchange-RoutingPolicyChecked: qqjlAPDKXmOvL12JBbmx3mksNFDGBxG9XMhAAsqyydWFnrlTtW7rQ7iMrIl5d1DOyPYQHDqzqbG4bZbXzr6o1GvIL7kLVxXRRg9WEa44l8wjvoUUP59ZD/GlA+UdJuMauipGUtc2mHikWEn8hfRqhW7m2PxyFQgmFa3AADC5d66JmNM/gMT0XsV3Hr7/se8NB189O8MoE71YKw7764WoZIIWXbH3mfm7S+7F7I5/IC318pYVHqAr2MeRfJZhxZsy970XtbeXs0znLHWCZdlujgovxlwELeH4aQHLqY6AdiBQahAhfaBXDon1cN+NxY1b3gQfHlO5V9PQpUzFfi+Fyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bd949f-ffb6-401a-f8dc-08deb710d4dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:13:25.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMduMHnTxzLwDg6PNkHwUxkq5ibbaAt18ChWd3g5ywN6XW/QsQWHqj4Z87EolBNtIN6JOz7Xq22gvlQr7Y94QZVjYNCaP4vPa+F0qullTv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
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

On Wed, May 06, 2026 at 05:51:32PM +0200, David Marchand wrote:
> This is a continuation of the work I started on the bus infrastructure,
> but this time, a lot of the changes were done by a AI "friend".
> It is still an unfinished topic as the current series focuses on probing
> only. The detaching/cleanup aspect is postponed to another release/time.
> 
> My AI "friend" really *sucked* at git and at separating unrelated changes,
> so it required quite a lot of massage/polishing afterwards.
> But it seems good enough now for upstream submission.
> 
> I would like to see this series merged in 26.07, so that we have enough
> time to stabilize it before the next LTS.
> And seeing how it affects drivers, it is probably better to merge it
> the sooner possible (so Thomas does not have to solve too many conflicts
> when pulling next-* subtrees after, especially wrt the last patch).
> 
> 
> This series refactors the DPDK bus infrastructure to consolidate common
> operations and reduce code duplication across all bus drivers.
> Currently, each bus implements its own specific device/driver lists,
> probe logic, and lookup functions.
> This series moves these common patterns into the EAL bus layer,
> providing generic helpers that all buses can use.
> 
> The refactoring removes approximately 1,400 lines of duplicated code across
> the codebase while maintaining full functional equivalence.
> 
> Key changes:
> - Factorize device and driver lists into struct rte_bus
> - Implement generic probe, device/driver lookup, and iteration helpers in EAL
> - Introduce conversion macros (RTE_BUS_DEVICE, RTE_BUS_DRIVER, RTE_CLASS_TO_BUS_DEVICE)
>   to safely convert between generic and bus-specific types
> - Remove bus-specific device/driver types from most driver code
> - Move probe logic from individual buses to rte_bus_generic_probe()
> - Separate NXP-specific metadata from generic bus structures
> 
> Benefits:
> - Significant code reduction (~1,400 lines removed)
> - Consistent behavior across all bus types
> - Simplified bus driver implementation
> - Easier maintenance and future enhancements
> 
> The series is structured as a progressive refactoring:
> - Remove redundant checks and helpers (patches 1-5)
> - Add conversion macros and factorize lists (patches 6-8)
> - Consolidate device/driver lookup and iteration (patches 9-11)
> - Refactor probe logic (patches 12-15)
> - Remove bus-specific types from drivers (patches 16-23)
> 
> Note on ABI:
> This series breaks the ABI for drivers (changes to rte_pci_device,
> rte_pci_driver, and similar structures for other buses). However, the DPDK
> ABI policy does not provide guarantees for driver-level interfaces.
> 
> 
> -- 
> David Marchand
> 
> Changes since v1:
> - fix typo in Windows code for net/mlx5,
> 
In general a fan of cleanups in code, and this all seems reasonable.

With a fix added for idxd driver,

Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
