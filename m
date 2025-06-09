Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502CC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 14:52:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36D1B40EE7;
	Mon,  9 Jun 2025 16:52:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id BB54640EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 16:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749480764; x=1781016764;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vgW398k4sMx9aC/R3DYK8jPP4R85EGF4mcXQk962BwA=;
 b=J3CBMt+9ayyqhVkT4rJeJiuu641OtW2vx55E0r9KUVSrdL0J830v53t+
 2u23YCB2IgUpOv6LJYpJpQGNmpWergaHgFyNmq5ntl00w3+I7zZNG7jea
 0i6ZZ7bFW8//IQ4x3DuQMqba2khrKVuK4c2ADFmUn6v71DBaNl2Sw4oZB
 ZfkSS8Avl/vCsAUjKS3a4EPdbVPlh8bOPf/8GwUQSPLrKtahdGSuH5rO0
 whiim5BG93fA3/rhUjt+UuLdJ9kb3x3qf6mFZaNBEJQAbeQQwlff5UQKg
 DI7lk6fiBxPqF+s4RMh9zBwFPR/UAZ7aY+eUtuyzR6pw8ATF3mWBWDMvC Q==;
X-CSE-ConnectionGUID: lUFfAW7VRqyVhJxYhoSR2g==
X-CSE-MsgGUID: hEF1tA0QQz6IirA66sUwtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51700894"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51700894"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 07:52:42 -0700
X-CSE-ConnectionGUID: Wz8TaY3EQDe9tEgqw0ntzw==
X-CSE-MsgGUID: fJV/QuJ+SOKSG4K83LS2rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146531291"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 07:52:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 07:52:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 07:52:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.89)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 07:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wedgtc4LY9izmadHkhyz1/iXVfxeT51vOWtoRBljXuB2GtdRfOvycT71yWCBd9P7uBVWiQcXQEXAfV3gSicchDskWvlbpbc+9hDRsfmvlgu0PdIsbKj6Aw/yQeJ5KImKou8YuXMBjE9a7eTGleBmZSQGAP2pdJv8UEKqjlA2SNjn/rcgbua1vBbHnhgcmfyVq+RjfgEet8ly6kEu+5x/O4PFb7Nw23+Jx4itqhOz9vHevmyqr32IhUbpd8HBC3IYbJnytQA/VKjlrdAToVV66dgCuivtaLkbjSz7oJ2+qXnXZaIx22j0Yj/ZNtglduH0TLGKcz8cHQDwXd5dZb5uNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj/QNTo9k5d7ZKhLtYJZMAwe9CMgbKQmUF/KF2j7p14=;
 b=UFXhLO+geuWfyOvMSP/FZh0+hltqlVLsp9LuKlVbOV10SFKPY+gG+oeGPbd0BmQbEkfES14CTOrvsrwNFUbg2TM0ExygDrLey/Hf6bvEGhWgHiAccH/8GHaI7ZckmX1ZDEgwxVwDzewJQT0NheX/2WwfZZO6afeWUr8IWHzYgvAhMH+ARteFvyMQaT8wx1Fi7/Lpi4yLDb4mrLJAfXunGDL7hYmVClYmUh3zMz6tbZAYnEqgnXeiBjI5TTX4VycDpmMtZBQ/l3/UvG90KIHtG8gRS8MGMAQF7jmGzU5jrwLRxa8vamCWecyJsKdH2KomY3QhveqnLoFSGlMG82DNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB8990.namprd11.prod.outlook.com (2603:10b6:208:56b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 9 Jun
 2025 14:52:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 14:52:39 +0000
Message-ID: <91b51ef1-d1fe-43a4-9ef8-bb623f35dcc8@intel.com>
Date: Mon, 9 Jun 2025 16:52:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/34] net/intel: support wider x86 vectors for Rx rearm
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <50d03ad98dbed61ffbfec689337b20f41849c11c.1749229651.git.anatoly.burakov@intel.com>
 <aEbLcjsxW2K9GCmy@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aEbLcjsxW2K9GCmy@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 652eeb75-8067-463e-4d26-08dda76547e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHVLZlFUZGIyd0hlK2YrWGFBZWtXeXdCcm5nZnRmOERHZlJKaUhKUk9hQmcz?=
 =?utf-8?B?Z1BPZUgyVEZoMkpWeXZjU1ZVM3lGWlBsNnlwaHNXdmx3ejl6VDRueG85c1FU?=
 =?utf-8?B?VlIrN0hhVVcrZ0NlYW5Dc2R1NmJMUHp3NllUMG0zcnc3VTdvOWhmUXRsejZ1?=
 =?utf-8?B?VHllRkhCSmRSNTVxV2JNdDlrK0dkcFN1RjNrbFlMOFpZRVI0eHRpY25CbnQy?=
 =?utf-8?B?YlAyWUNMOFF2YU5jNnR5VUpyQ2xEYnNwSjF6azN4QnBZKy9DSnhHQVZod1Rn?=
 =?utf-8?B?aHFhQnpONVN2bHdDZ0J6UFVTSlBteHdJRlY0a295V1V3Q01zS1c5TU5PS2VU?=
 =?utf-8?B?Z2RtTFZ6c2xSYWt2SlNDRXJYUEZuZ2lMbnB2L3ZYZGlYeWFIcWtmUXZSTG5n?=
 =?utf-8?B?YXhVcDB5SnRhVTZDNG9FNnNGb2VlbmRGclBSK1ptN01vLzIrakFvM3hmdGFK?=
 =?utf-8?B?MFpsaHNrZ0IrMUE1K1h2S1hBTnc3K0J3SUNaZ1k0MllhOW5iYnQyV0RIM3pH?=
 =?utf-8?B?K0o4U0ptS0ZmckZpZmNIYW1xMjdTVUI0ZWRDczNBK3IzcytBYVdJYiswaVJa?=
 =?utf-8?B?NUtpYTBXckdoUDBkZENqNk1VaUoxYSt0SU94cVI1NlF5TXJIaEdoL20waXcw?=
 =?utf-8?B?a0ZDbGZyM2dBK3d6YUUyYmNlcWIyZ1VYOHBycWxxOEt1cUkwdWlWM0c5Q1pj?=
 =?utf-8?B?c1FMUmRvMDZSZWQ1ck1SWDhPeDAycnVBcmdvS1AxMGE0aTBRZGdvZXBGWlJn?=
 =?utf-8?B?QVZla2JJRTB1RTAwRlZKS0pxMGpVSGdyQU0rK0xWMzY1ZGVQc0ovTlRJV3hk?=
 =?utf-8?B?ZnFSRVpDRTVrNjUxOW1YMzdCZS9aWmpTWWd4RzN1MFVVM0lMK05FaWFzenpN?=
 =?utf-8?B?TVhIZGU4UjBnZ1ltMTFqSkNBd05EZ0V1akZlenRCTk1LRStrSXRlQWJkOFRG?=
 =?utf-8?B?bi9rV29CT2pVd2dsWlAxUWdObTQwVExXcXZWRVdjR2RYT1dIejhTTnl1NWJD?=
 =?utf-8?B?T3JycDZ1dzhmMit2L3hZdVRzdXYxUUpJV2JwNEtHMExIanMrbmZydS8zNWVX?=
 =?utf-8?B?eWpBWWhDMzVnRWJ6YVpLeVl5Ulo2ZWlraVFYbDc4YTYxeithUldIKy9Ub0RD?=
 =?utf-8?B?b3BQNm83d21EeHlscVBia0pvQlIwRDFIS21jOVBaWGszb2gyVmRCeFpKR0U3?=
 =?utf-8?B?aHVXbDdIU291S01yV1hQNnRtVi9ERnZWY242UUtsaFJnTXRjeGtpdEtHQTRx?=
 =?utf-8?B?VUR1bDVMSE1UVW56MHhMWEM0MkE4M3pHYUZ5RHl1UDl3TzZjMmlINDVXMjdo?=
 =?utf-8?B?TVlmWjFWcWl4YXAwUHV6N2lLaVg0UWJ6Wk9UTElUdithRHlkQzlBTnowWm16?=
 =?utf-8?B?Y0RuNjZCQXZCNkk2VHRDV1ZuT2oxT0FON1Q1ZFBMTWd5OEFFVHQvb3pscEw1?=
 =?utf-8?B?ZGZ4Si9hS0t1azI1eGdKbjhWdmp0bkgvT3Iyek9zUjM2UVdBSERJSWxpSGhH?=
 =?utf-8?B?THRGUU00Y2VFWXNEbUx4ejJoanNCTWVNSnJHVGRCZUxJWkVTZEs2NTRBeW96?=
 =?utf-8?B?VUYwOXRBSVcvWEJDdGc5S3d3c0U1RC9SRStJWmVwdmtOTlN5VkdESnV6YVFO?=
 =?utf-8?B?SXdReFlaOUJFZU0wTmU4UDNoL1FseHAxenZzK3BnN0Y4ak9rRzFpMm9SbTd6?=
 =?utf-8?B?VWNlOUJkYk5zTzlUTEM2WTc5ay9LTVhvRCtJbjVkUEplbHBIc0U1UTE5djhG?=
 =?utf-8?B?dzlhUHMyd2plU2NHQ0UwMThxUmJsbnhWbW1hNEpYRHdTaitQU1d2NGJDQ213?=
 =?utf-8?B?dFJVQzF5UUk1dGQ5SDRnaHMxaGpnOWlCVW1jYnY4NWFWL1IrTkxMREtsY0x4?=
 =?utf-8?B?TE0wckVZcUZ6NW9XOGkvcEdIdDl1Vm5SQjJkQXdra0pTZ3FTdk9wYWEvdEdE?=
 =?utf-8?Q?aSwUw0N1Z9U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxMQzAyUE81T2tBZXRxQzVPWEh1Nnk5c0U4dVV5YTU1MXpMbHFMaWY4MVN4?=
 =?utf-8?B?c2NnVk5UMW5tcEZyVlREdjdhTWt4b2ppMWR0YTY5Z0hxbUM4RE5GbEdXZktB?=
 =?utf-8?B?QndzZWlCYVA4dXNNTCt2dERyWXZueGRqVnM3L0tHeWRrUW1vMnFpQkNJS0hU?=
 =?utf-8?B?ZjZZcEFhRUlQOHE0QUh6MEY2NEEyczQ0OW8yMVNiM3dkdUFZbm1OM3UvMnVk?=
 =?utf-8?B?ZzdoNmlMSmF6aFBnYVBpaHcza1ZnaGU0TE9wdnhRK21wVGkxS2JHOTkxMS9w?=
 =?utf-8?B?bWY1MEdiRmZSTU04bVJBcTNTS2dEUzJOcS9uZ0JYZ0ZsbmVua0M5MmY4T2RJ?=
 =?utf-8?B?QXlKS3NYcXVaV3VETWRVVEJZZjYrWDc4aEh2TkJndlZEc2ZHZitvZWp0NnhJ?=
 =?utf-8?B?cEd0b0c5NlNTQURFenRlaFg4ZlZmdVR0VlQyUnU1SGMyZVVNL2g1eExDcERX?=
 =?utf-8?B?RDRaQk82alFZa2NEc3FDaGtFWGpPTGZrRmRvNng2M0JXbkhuTDV1cDNIWFZU?=
 =?utf-8?B?V1l2YWE2TkExa1h4RUc1YjBKci9FRFlzSGhWUkVaNm9zWCtSKzYyUlhkZEpu?=
 =?utf-8?B?cHQrMm9FZ2lxc2kzUzlYTVBPdnRoY2NzWk5QNzBkZHlrZUswNnF4MFp0eVZh?=
 =?utf-8?B?eG4vWXJlT1h1bWV5V3Qxc2xuTE9oOWJzMFpLY0tQSzZlNWcrSm1mMFVMZnlD?=
 =?utf-8?B?b1FLL1JuK1o3KzA0bStGVWlhcGx2eis0MmdOaFlobWxaNDhtK2xMR3Bxa3FO?=
 =?utf-8?B?dXBCVjlTeVlhNHNsZGFOVFpZWUNHVWFmeDhqVCtDcHFHRDZBZ2RXWHZaNnE4?=
 =?utf-8?B?UEdYa2cyTWpmRk1FaFovRVcwNzFzdTZCNmF5QUpOTDkyaURkNEU2R3ZwRWM3?=
 =?utf-8?B?R1dDVnZURmV3QXh5SVovb2xpUVkzS3YyQm83c25LK3VsTXhWZnVBYlB3blVQ?=
 =?utf-8?B?SUNWVE02SDFYN1pHNUZwY1FGdDYvYnlCczhQQTBsRGZMb3dscWhHK1U2YS9R?=
 =?utf-8?B?dy9zVFNsbkpQSWdaZDVQZ3hObnlnMkdiL21pY2dQZGQxVEFpdFhmcVEvNHQ1?=
 =?utf-8?B?SzAvbFd5Um8wNnZac3hnTVl6VHNaanljUmIxZzZxQkZNUW9KUzFWNitzUFRw?=
 =?utf-8?B?NE1PM0RKVlF5SStFeEx2WjFYYXNwRXBIZlJSR0RLbXdwNjBGWFQyZWh0ZkVo?=
 =?utf-8?B?cVBKYkNPd1lvWTNQQTRQeUZNLzlxckRuZzVVWTF6dzErdWpyUHZJL3Raa21x?=
 =?utf-8?B?NE9wL2NkNmFjaDJRZkhxa0ZPVFFTUkJ1bEVXUnRvOStyQldNbGRQRys2bHpM?=
 =?utf-8?B?bm1GMi9DZ3NOSVJnUW9ySnZMWlVIK0NSNG5IYmg4M2xpUGMxTkJRbHVYRldS?=
 =?utf-8?B?WmE4M2xsNlhHeTdwVzdBN0s5Uy9jMFlJeEdGMWpVcUg0QjFOeGxGT1JEbWhy?=
 =?utf-8?B?Y1lJb1Nyd2hhY3hZYzFwR25BdHoyMExvcDJweWhxd0xmT0RIdXIyaE1UVk0y?=
 =?utf-8?B?djlmQ0UrTUpELzlwSlUyY3hHNmNKZFVqRHdSSjYzQ0VZQnBPdDVLTkNTR2FM?=
 =?utf-8?B?T0VPOXBDRDdtdVFQT3pRRTU2WDRqZDhhbkszdnkvVXBLTUdDL0VnREZpRmlp?=
 =?utf-8?B?dVJWWFZjWDdIT0xEYkl4OHdhdzJTckhjREJzeEY0TTNBeWowc0thaWtvWVNM?=
 =?utf-8?B?YXY4dEtnOXRPbkJxcWpEUmJjaCtZUFFrVnBKRWc0UXBjMHRVTElMdDVXcTJR?=
 =?utf-8?B?ZmozTVpHUXR1bDVrQnJxTVl1MDM3UXVCRGpnd0JMQzlmcVZXN0huSGVVUis3?=
 =?utf-8?B?VFZFZjh6REtIUFI4QUJKcXZBZ2lxOHFPaUVmWGtvQTZzYWNrWkNsdEE1U2hD?=
 =?utf-8?B?RVJFV0xvcXArVldIMCtCUUlMYXhlWis5b1NsSWZSeHk2Zy9keURLR0ZpeTNN?=
 =?utf-8?B?ZHFlQzJFNS81MVhqSWNhQlVhTm9rRW54ZG9RK3RWZzU4RndjR21vZkxwTjd4?=
 =?utf-8?B?Ty93a0JWazdlNE5yYS9oaWwvWUVLeVJwUDhwTEZDNnZKV202YXZ4cmZoT004?=
 =?utf-8?B?MUszNmwvenJ0SHVMcHVEZGJCa2VWZUhzaWQ5ODd0cUVISGVYeDNhYS9ac29k?=
 =?utf-8?B?a0UwMWt4UjlBdmtCeDdqSmpPSGRhM2xwQnZaaDRFTENkVENzQ1Vxek9oR2dO?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 652eeb75-8067-463e-4d26-08dda76547e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:52:39.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNBMvNefHuX+xP8//KIp6g2Qk/i6WMYDEYZD8eBE4xKEGpJgL8tDEW6Zw6rb8GoINTVfw7Puu6QXksBJ5hr7p8HIW67y4cEaIoJUJTJpBBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8990
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

On 6/9/2025 1:54 PM, Bruce Richardson wrote:
> On Fri, Jun 06, 2025 at 06:17:07PM +0100, Anatoly Burakov wrote:
>> Currently, for 32-byte descriptor format, only SSE instruction set is
>> supported. Add implementation for AVX2 and AVX512 instruction sets. Since
>> we are using Rx descriptor definitions from common code, we can just use
>> the generic descriptor definition, as we only ever write the first 16 bytes
>> of it, and the layout is always the same for that part.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Two small comments inline below.
> 

<snip>

>> -#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
>>   #ifdef __AVX2__
>> -/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
>> -static __rte_always_inline void
>> -_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
>> +/**
>> + * Reformat data from mbuf to descriptor for one RX descriptor, using AVX2 instruction set.
>> + *
>> + * Note that for 32-byte descriptors, the second parameter must be zeroed out.
> 
> Don't need this note any more, since this function is not used for 32-byte
> descriptors.

Well, technically the note is still true - if you want to use this 
function with 32-byte descriptors, you will have to do what the note 
says. We don't *do* it, but that bears no effect on the properties of 
the function itself.

-- 
Thanks,
Anatoly
