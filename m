Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A1C8302B
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F699402D2;
	Mon, 30 Jun 2025 17:33:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id B25E1402D2;
 Mon, 30 Jun 2025 17:33:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751297615; x=1782833615;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dzqAo18zoVm1I9upGou3SrsGx7fBIGqTtJwsriR6nEg=;
 b=MmCOySQHxIlzovAAq35ardFuDQb0S3Hs/ZoW+rB1BnMg6o7MfbvaV9XI
 kXcwjJekk0Hvwv0gU3nx0rMGKFKoTrPKXIrnlS1DRZ8yTsrvTb+Nasedx
 fFc6Q0x5P0OyV0JKl0tRTUVi7vaMDFAwFfGtlB6kVICH70U7wuX06v62y
 L69bal7FWKFfGYBtfNItGh2CEAeOE5SVApQow4voiowgmg1ksN6Xs/ieC
 azfZ1ZMgUtOfpbXjcHCU5mg4JLjuhAzU7cULHyV41SZo/u2jB46PbCmt1
 tlcq52iiVuiAZMoeZN0PSEuPlGXZhDKb47HOJ7koxK3l0tL7Ftw2g0b77 A==;
X-CSE-ConnectionGUID: qcSPSkSOQta/cxhpvHaifg==
X-CSE-MsgGUID: +DJVbMAFQLq/KAC6BnZnYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="52757649"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="52757649"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:33:34 -0700
X-CSE-ConnectionGUID: f18fEUB7QYGnCF5WhThvfg==
X-CSE-MsgGUID: KcnNoFHSQw23e8wnaSrxrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="157769137"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:33:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:33:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 08:33:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkToTanl7TVq60MsDzY5egDar+McOldjzEcwm9g4D2zpwTtVLt6kBd80gUDi8KP/61rcUBWiTaKQeMTGKttEU28hUXbcTeY1UN2rX9pBLcJgaSm4SNZzwVJbicyMxDD4wWvDRX7moI8AynzCLthjVEt9tuuRP98uELs9CXZI1jZoyQFAlaNelUYH+Dq0qspT2HKcU8GlUollwcMUF1qysqdo8JF1ln6hBdeg3FOHE/bAo3bp/AcMhXkx4ERy+PEp43OAplfk6rfv0b0ZvX2rWDSGInlEQkNCl+aleCAFfOJu4w5zIZyXgCpkW7BIZOJQF7ynN8VyulsR9SRQIVaHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGHP4idhQNrZEFusqL3ic8CHiKVC0AoiqGm/OMQtMKQ=;
 b=pMoGMPOlhdvvJYHhl07lRbYayz633oQRggj8xy1aHDviBz4gMDDctFQc1us8Uud5XNRTODiZCwlxrU+GOais/HMTaXBzxbx3ot+7pyOZLtyUBYtr4LGgmU6YfR/ITjf/zUTCYuPiDd80BY6R9JqDxSYhR1NQIxPgmn3sexkvzO0vUZhs6yNuNrHBsW144gO/pk6E9qHelnbXY+NErZEO89mX8qZF/kHb1EBKFD5+8egceQ+fWgJWW7mXGVTqxhFsTdXWsqHjGts1isNSY8f+pkLvCQwhd4L5UA0OTucgbjSh/oQDCDtW4nVvHpp//j+Lsp5++9DzSEzmPrST8M4Ovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 30 Jun
 2025 15:33:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:33:30 +0000
Date: Mon, 30 Jun 2025 16:33:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Olivier Matz <olivier.matz@6wind.com>, "Gage
 Eads" <gage.eads@intel.com>
Subject: Re: [PATCH v2 09/10] stack: fix unaligned accesses on 128-bit
Message-ID: <aGKuRTCeQGLXiu6T@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250623135242.461965-10-david.marchand@redhat.com>
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a36067-46ca-48db-76e5-08ddb7eb7731
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wtHpdpt9dEVaUB4j0ICQ0x29GV5DPqS3Yf30IvoAWDU74lRXjoVxSY7hgj6y?=
 =?us-ascii?Q?8vY8JiJrzp2zJD5qCF6ACLXqBILFnsa2q9JFLAiqS3z9lpBXSq6Fmghe9oJ+?=
 =?us-ascii?Q?R5jUNzUKc70N4zzOqf2QfUjVCTTrtDwODLYvwrDsFTgmBvw/yEt/sJtwZKyY?=
 =?us-ascii?Q?SrznZtojBpgvmovNia56J4+Ep9yeD2cosg2wItTik9skmbsP5HvgNnkb5l/p?=
 =?us-ascii?Q?/oToPCsprZJklLn22mzWGBvsQvbrEM91bf/5mdVnd/f5GOHFtlNspCX820uy?=
 =?us-ascii?Q?/bPMtjc9RcfwtQDIo4qBPVwmpWPohyr59axIsHqHhQkp69wVB05tL+gpJKic?=
 =?us-ascii?Q?YBhgKnji37MB5vc5797tAPR9CkC8UJ4smxa+sKf+3KtGJ9DKnmKuwMYOLD6m?=
 =?us-ascii?Q?g6XugmjQs9+Cqdla4xWDTxXjrMkE52ydY6eOXQFfeY92YYfHUYQR6Hyex6bB?=
 =?us-ascii?Q?8SoBQQam6/VcPTO611k/H7LRe9ZB4VT47uzPJ8z8GzawcPKmvrHW+fFB833n?=
 =?us-ascii?Q?BpYzX42ZK2Ekop+Zjj4Fc+pM+qa+1fq4w5XLQZUKKPZZiuk+BXQCp47dk1Ws?=
 =?us-ascii?Q?kejKHDU+W3JevjGz+b+TDrTP3vPNYPGzfGFIYX4MMd4UdQZujZZKDg31/ch1?=
 =?us-ascii?Q?Wb6nwrRrNxcja+TeZQ9UUzEH9WBGbA8spCdccI0lLISLf/9LeGneG65aB4f4?=
 =?us-ascii?Q?/08T7XWoap4fSl7mYTt6ptpL1nVHqLmJNBboHCCMJI04RC6pUQ9wiQrA8FuL?=
 =?us-ascii?Q?+qgzaiWlvWwx49t+fa3Vi7sI2UtwWCgBG3jiQq+22mHJKJ9ZdI99FLcjWgyU?=
 =?us-ascii?Q?DYoauRzuNVr+cp/haTxOEybp3T6OA1AkJyPVHU/3rJn+vgxgnJxTRYRnWJUW?=
 =?us-ascii?Q?H95H+P7dHOrdWUDUcXzOguFr6o2TkogCzNEsjW8gNSKHF3wjaP8an8tbPSV6?=
 =?us-ascii?Q?LFvaf3JlA77mZlc5p6Vu32Z3PP83VDhOdBgNXZmGCvRpl695Jp/CYbIS7wux?=
 =?us-ascii?Q?/WU3o1ZSsnfvzK+MQjMs/fYkAM3W/fp6Et4FotNYNVP7ITQ98I+mAjgq4j3D?=
 =?us-ascii?Q?nUd/JQYmGylA1Tx51T+Sl2h8DuLKN0gIezC2CqHhqmwAfqIndImGfQQ4bu8L?=
 =?us-ascii?Q?JqGvmSi+GDc3RBEj+0pBG+jLfoN2plu7Gs+gHHQVKanFA1K+Q+PcoxOAqubO?=
 =?us-ascii?Q?qoYCUxotSuChvpjjmmGEfpc+kV/dagplA7tno4GpFM4YW6vNtKTAp+UJ82RE?=
 =?us-ascii?Q?qBr91zCvKeYu6fmoxBb+1Xj2SbD8kz6Dkut8ojoQUgLVbXkLIBMu8yji0pcV?=
 =?us-ascii?Q?gl5i8Q3noc3dsdQ6XKzuzjCMmjI4dg6fueSd4/AnM2m9D+2Y2h0j6P6/RzaJ?=
 =?us-ascii?Q?E93h4BBRX4oqkqEiLLDxca1UP6EX3kYkYkz/9tCb+VJeLRe+mkJouyijJfjU?=
 =?us-ascii?Q?tQQVel7tdoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJ82WEuJw1ZQD5wuCPt2W1dWhgbzPuizHiiCBpaQ2sfttQGOLy5XWQyIjEkw?=
 =?us-ascii?Q?ubhtgxZ4Tg91EdTpVrMsZ702Ye78c+tK+/1if0+cFGKWqG7c9RWKMCmOs4rb?=
 =?us-ascii?Q?cMnBHwI8H8heWqsKD8wVv47OjkClz4OkWx1PiJwdcLBSwaCgkv4dPZ0I339c?=
 =?us-ascii?Q?zcJizUKm1oOu268VCmX42bmqOJeH599BX19/I9H0G2CVlrWxJ5xKGbpH9UV2?=
 =?us-ascii?Q?Q1sj9j/gjw4k7ATK2JwSMTei7i8+cuzcK1lcEqICgozCUMh/Bg1xsrhiZYR2?=
 =?us-ascii?Q?7Tz79h+ENw5ffjXIGyKtsYpldZs61VYFOhUUTQK3nKzJhuGw9/rLgpE4n88i?=
 =?us-ascii?Q?UisoXAxCBtcN3AsfEZrCO/GO7tMNP2rpmq2cwjQOllYqKfXFqCQfWp0Etq64?=
 =?us-ascii?Q?TwjUaD+mZb5pnoqP87n1MJBFTkw5EJI1o8zYSMVhZvzIcv5nClRlGhz+eMzd?=
 =?us-ascii?Q?2C7B8K+mxU6jCBjD3gXeySrpniSmu3BpHoG1FvLifLtNCR8GhcgVbKIAzxMb?=
 =?us-ascii?Q?nIahFY/Hd9Tvxb7OO/p5vXr4UKCFFo6pPKJLlNxUR77xpfgrLSjnBDyPAAns?=
 =?us-ascii?Q?GyCJ8fe1QhcPQPHcLjWZW8ruJoG1e+xDS/VQXR38IshAiNS5P05MvnEeZUIq?=
 =?us-ascii?Q?Y02cfTY6MXF3FEEj5sMqFGBVT2rj/HxZN/eTJKm2psuBUQBAyR9h0b2O9e14?=
 =?us-ascii?Q?2ZovQtsfAtfjY9kdiPZoP23+m/1G3nuQ01uYMX4iG6AaO1bKOnWVkIASvSw3?=
 =?us-ascii?Q?QnF6ys39WiEnRjyl+LP+b/ExfIJH/evBNQ5aXcscb7HC+YXyrFvVt+zDTHYW?=
 =?us-ascii?Q?AaKLP5Yuu+4dXqXM5edg/FSQdkJosCtsSFVdfMU2HakxmNeC2Vtpl+XXGpQZ?=
 =?us-ascii?Q?twYZc9OW2sfr+JeSFtfx3OuvdJ5uBVbJAgeCxWYaDvq6Z5oSC4aBeuTKqCTU?=
 =?us-ascii?Q?617vKoo8UcU99VtFvchKynaB6dGpXi47o4FnhUNdT0M0QdO2ZyHlmvXLd1/5?=
 =?us-ascii?Q?3QEte3Ih07fy1a65cJVRcwxNolUmq9pszZ5FLaZZAWHiNLBeM3egTDB1wtSy?=
 =?us-ascii?Q?bw+BYGlxs9++BkRcUEpIfjRX0XPAstYqefMMGcp5HDqMocbFky4/7ukHVhDw?=
 =?us-ascii?Q?6a4NRqDIvwSW17xWUmzv75CVA/Mmj79qlejjLsGA8VaYLtwTBf1T85PkmK1x?=
 =?us-ascii?Q?F5FylfeeuiCi5N2N5WKRQCPH+xdRiX6HeGaeAVk9lamoqn2fZiFei6nRkMWK?=
 =?us-ascii?Q?6kyiNPJRDkw2NCXXooscIKXTs/zVf/sGuV1egXQx5EjsepIpXMJ2/0TW6EuP?=
 =?us-ascii?Q?7s4tn71FaaSuo+z3uI3Yg7JkONMH+S7KTjjpx9ypwor4JE7GTVn3uGvjNJBE?=
 =?us-ascii?Q?NUQ//K2Q4WSidWkWk2JiJazKwhXy0kK3DLFzVyrkOUnY+hZJZa4bFA5OrQBZ?=
 =?us-ascii?Q?46dJNWDgMDM933Un3kaeKFvZQYSynzjdQ9vvXCcKEN7XmtavZSRGADxK74A8?=
 =?us-ascii?Q?d1DGpH0zLC9K3G/hwHSNOXyBNc1A8IxkRK+cXvCAE9qOc1mJK9hg5v2Tl4U7?=
 =?us-ascii?Q?oJipZZJVGerjMn28JCbBl4hdJOZVzRsVzKmBYWXs6kw1OTFE6b8m5FsWsC52?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a36067-46ca-48db-76e5-08ddb7eb7731
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:33:30.4285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGFbDqflT0qzu6eDzu65c7TtK8QJclDFG45UbRP4PaYxvRMNbP0YnOPoTxJVuHBue9nnYxvrYNKKNzhTsclTXQDlgZDTRACK0Y9PcT6f7ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
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

On Mon, Jun 23, 2025 at 03:52:39PM +0200, David Marchand wrote:
> Caught by UBSan:
> 
> ../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
> 	member access within misaligned address 0x7ffd9c67f228 for
> 	type 'const rte_int128_t', which requires 16 byte alignment
> 	0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
> 	member access within misaligned address 0x7ffd9c67f228 for type
> 	'const union rte_int128_t::(anonymous at
> 	../lib/eal/include/generic/rte_atomic.h:1102:2)', which requires
> 	16 byte alignment
> 0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 	../lib/eal/x86/include/rte_atomic_64.h:206:16: runtime error:
> 	load of misaligned address 0x7ffd9c67f228 for type
> 	'const uint64_t' (aka 'const unsigned long'), which requires
> 	16 byte alignment
> 0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 
> Fixes: 3340202f5954 ("stack: add lock-free implementation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
