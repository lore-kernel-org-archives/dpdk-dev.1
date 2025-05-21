Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B51C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 12:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31E24427CC;
	Wed, 21 May 2025 14:18:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CA3FF427BC
 for <dev@dpdk.org>; Wed, 21 May 2025 14:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747829898; x=1779365898;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cuWPaouGaI+RMjj7cZssBFzOyr7sPmpSaC+XYHolbaM=;
 b=SkaatrNTuelsqg5+aNYDHzIpZlJPsDaVbId4gDyn1V01sSmommBmMgki
 pbxCwbmIr0DogilI5dcHxdgJaP3oIYQ+hzJU70aoOBuzUC7/HwefZAFvQ
 mB299se+bv2iWpsVQ7ZMHBCHMpF8ZQCg/e8S2sPSUsN1xzCTjWr3xJa1/
 OcnuKxmpTS8NFFLcKakpF2nmEJ8YhBldANYsnO3EY8tsdxLWBeyq5TefD
 fpNCon4FhGEvbwi4lPxPLl+BkMOqheXgPoaOmHx3v0hv+Ue4aSSK3zUu8
 mSqX6eqaTE1wLLR15g5ItE8LUlkE1CEcV8FQPH0O1jefTkTwQXJw1dyUt g==;
X-CSE-ConnectionGUID: URs92ZbIT0WYkJav1hsouQ==
X-CSE-MsgGUID: l354kYJuSv2lYvr+ARRogg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60444718"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="60444718"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 05:18:16 -0700
X-CSE-ConnectionGUID: v1Q9gUc5RUWAA2Tk2E8cwA==
X-CSE-MsgGUID: Qa7QXS0pTyClcwrhtF36jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="140462567"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 05:18:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 05:18:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 05:18:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 05:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3BnTaYDQNkcGQ8r6/5fUcHcKoQJt2zyYVtNr1VHq/RNePdhGH7+1tTTQVisFcv0wrsNvXniPjb7rRzAe1cc6pwppnSD3KBMoWTkVpkl4XFo97FftBdOkiLfjyZxvyTF3Cj7daobofARKtn4652HKqlLB46wAzy3+1SVlRNiPz8zFpo+JIWc7Z5mhNLZlwLZFmpxkF5DRr6I5gvHYTt8iCkCZEhYRsvQHbRoxqbmFYbbZKOwt9ksDJQprSRcrUQmRBfMuTJRtu9tCA7dT8q3/JoHEnimEBUfXn2dT7kQ0YZEE0ts8fR1hiCmhUW2aeEsuVo09lPBiga1cP3JFDhCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo23PsXyz6jzufgPv5F5OpBJBuEP9pXXM+nytazqPKY=;
 b=xzvTXWhGtInU3954OTM56K7zvnYGYQgGnw5cppnucWJ1SW7rXCWoj2kq9cR30SFwY9rCYr1ankNOzl44yq1/AjBniPZ9T/UXtSZD51qKqo3t5TJbDufqO7AkR09K4Ghsr5Lvl7RYalSnTrpOcH+993mrfC0cHXbbLiUykQTVPOf3qnEt5UsEv+n3Wc5Hl1et9p8y3jhymbGhu7G35ZJA/Prp0Q5yeu7wTkD39fK+QHylqyIZ/IU1eHiBwmZXQ/OSIet/wcTKXuHlwGLgUnYfr1uwy/SezDEemaxAH2lyIUHG04uADPlteUG3oQDynHjQGUnLOGUemmpNVekv+6gGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7939.namprd11.prod.outlook.com (2603:10b6:610:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 12:17:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 12:17:58 +0000
Message-ID: <cf28d241-0b1e-4f36-ba78-30ba9c31d58c@intel.com>
Date: Wed, 21 May 2025 14:17:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cmdline: add floating point support
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
 <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
 <20250520091917.6d17ad14@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250520091917.6d17ad14@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5afe5a-41a1-4560-8b94-08dd9861858b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3c2ak4rMVo4eXFMQVN1ajFGbk5YMTh5WVhhaE9FT0RkUmlVRUp3VWlTV09q?=
 =?utf-8?B?SnNMb3BrWERHSy8xYzVEdStWaDVJUWZOZGtHdmtiaDBSV093ZzhLZXMvVm9T?=
 =?utf-8?B?QUg4Y3NPSzVmY1ZjdHpQUWJrQlBLaCtwaHJaQ0xvQVRlQ21IM3hxeXZxK0VO?=
 =?utf-8?B?V1Y0aTVRWWVTNmRncm9OeUs3OWllV3BDbXR4NmJ6YmtDREJOUGF0VFhiM2I1?=
 =?utf-8?B?NWRsWXpDZG4yd3p4UEZPZ0hDdWUxRVlUOW1kbi9keW85SDRNZGpuSW9PRjhv?=
 =?utf-8?B?K1oxRm5RSENKODhid3RFM29KMVVQcTNiNkdOMndvYmVLNGpTS1NENk50QUE0?=
 =?utf-8?B?VUJRaU9CUlFWNHN0WE1vOEJyak92dUVmaW5UYVMwanY5SFNpUVpIZFUxczlp?=
 =?utf-8?B?VGI1eGFuS0JkVGVqYitUZ1VqN2Z4SVZRdWF4RENzSjZKNXVsSS9YS2ZOVjVL?=
 =?utf-8?B?azhWU05GNmZNQzBuM1NzTXFra2FXV05FSzIweDU4TDNZNEtEYUk1dlhUakRz?=
 =?utf-8?B?VUV5SDJ3VzJXTEZxUlI1NnVpVXpnZTZ6Z2dPbXp6RG9UQzRuVWJPdFc4Nmlr?=
 =?utf-8?B?R3RmRVpQM1Q2QkxNU2F6eXN0alJWRVRDVGl6NlpLa3ltYWNtVGRKYnJYa3Nr?=
 =?utf-8?B?Rkk5ajZOWjIyUDNiVU1MdlFxWHAvOForR0ZaYm5SWU5CTGIveU1tTGcwSFdI?=
 =?utf-8?B?SXI0TGhJbitLODFsdVZZOW0zZWJURGhzci95bGdtNXp6SFpmZ0xRVjBCdnFG?=
 =?utf-8?B?M0FlVVAxNXBQbTNPMU1GcTZ6OHZVQW5naUdUNnZtc2V1d3dKdDFnZlNYZktP?=
 =?utf-8?B?YUZMUFB0YzJqcEJLNHFTUFljaHZxQjQ3NmkwUEhoZUFRTEVHeUcwaTYza1hZ?=
 =?utf-8?B?dDRnNGtkcktybFo4Tm12VFd6SW9EaWpFMkxBS2tqRS8ydWVyY3d0RllJZDR6?=
 =?utf-8?B?SVNNcGV3U0RtcUpxSVBLR1N0RUw0RTQzL3ZaUnVMcU52MFJXSVdOa1haZFBF?=
 =?utf-8?B?d0pVU3ZtUmx6cmRvaE14L1lYMzNXeHRvOGVyRDEwTDJBem01d3dENW1qTEtK?=
 =?utf-8?B?MEpBVUlQTkpqUFVqSFd0bjlHdi9TRk1XNHFuOHNSZ0p5cHdza0JZUU1CMk5J?=
 =?utf-8?B?Q2lKRDVPNmlwcStzZ2llUi9wMW4vMHNoc3pjWUlnUWdyTW50dE93QWQwK0RY?=
 =?utf-8?B?ZHJScEtqZVNFNld6VlYxVmFTTVRvY1dMOHV0S2U2SFhFdUVzSkVhT1h3d1Zn?=
 =?utf-8?B?VW5ITklOQTVGSkd0NDVNcEd4OWZwcEtuZXREOG5FMTdHOTJtTjlnVVVQd05w?=
 =?utf-8?B?OStMR2RsQ0pobVZWVmxQR1JQUnZmOS9NU0NBMStvK1lQU3NYQUhvaFN2cCtG?=
 =?utf-8?B?UkhCNndiOE1xVmNUZUFQT3h1TCtYVXk4SDhiMGhpTHFyWTNUdVNYdjlKTXA1?=
 =?utf-8?B?SmhuZXJqNDFOZ1Q3K1J3ZjZralNLcEE3bnhpVTVmbENSYmVoNHRnRFA3bzBZ?=
 =?utf-8?B?RmRzeE5YR2JjUzRzeFRaWG9VQU9YUHdXdmJHY3RuTUt4ZTZIV2gzNEVSeG1x?=
 =?utf-8?B?RkhLMGE1RzdERGZ3UW9HZjVwN1Nxd2trTzh4dG4vd1paQWloOUU5RDdJYklL?=
 =?utf-8?B?Y0h6SGsrSU1yWnRMQ2hTWUFvVDNFV0F6VXNIZ3l4NXQ4UHcvdXpsWS95ZnBB?=
 =?utf-8?B?QTNPaXF2Yy9ubDJSV0x1ZHhKNi9tWDVqd0J6dTNlWHQ1dEhuOWJKZnZPODdB?=
 =?utf-8?B?bURSUEFrckJqcXE3K245TE5lcE0vSEt5TVdDa3FHV09RSlQwUUkwQmF1SFI5?=
 =?utf-8?B?TDZDSDdzTDdUZGxkSkFIdTJoZjc0eHlNaDRmc3MySS9jc3pCait6Z0xnRng0?=
 =?utf-8?B?NjBHSGNmVHV1bDRlM2pMMnFjK0FVcElIWjI1SHdIaVJJSzhlUndiWWpZWmMx?=
 =?utf-8?Q?kP4mdYNLjcM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RuNkNyZnZLbnBkOXhQRkJYbXhjQitXTzZOemxqNlJBUGR1RzRJQU9GK3A5?=
 =?utf-8?B?YVhramM2ZmkwSW1XQTFMaTBleGd5TVQ5bC9jajRJU1BtZmxJbHR4SUFvcWkw?=
 =?utf-8?B?aXc4Wml3Z2JTUmdzOHBDa3ZUT3JVU29HdVNwUHYzRXhLM1lDYmpUK0g0VVFs?=
 =?utf-8?B?cDM3dWtBWmdBaUhPajhHRHJGc1BleDBlN2xsUWNhWEsvb0ZaNG1OanJwd1Zm?=
 =?utf-8?B?UG1TRzNxaGpXanpuZll1MU9DalhrWUJVTXoxdU96NmxBSEkzZVhBeWsvV2xy?=
 =?utf-8?B?aldFRDVsMXNHY0Ivc1dQaDI2d243TmJrdGpHdGZETU0xV29ZWnYyd3RLdlp5?=
 =?utf-8?B?cUM0MmkyTkhEUC9RZ28yWGx1WFZMckpDM1luSnZXei8xbWRRWFdHNnNWK0hj?=
 =?utf-8?B?SC8yS2hzVnREeE1ibnIydkZQQ2E4ZFo5TXV2VkVQQ0xDbUQ4VXJIeGYzUFF1?=
 =?utf-8?B?cU1VVmFUZmQ3enN0ZGpCeE1KVjE2dFNYL2xHZzJMN0llVkhlOVFEbXFTN3Vv?=
 =?utf-8?B?M1kyazh6SEZMZWYzdmUvbzI3Ly93eE9FV1lDV3Y5cmlXZGY4Wjk0RHlIVWRF?=
 =?utf-8?B?MWhRZjNiTnY1eHpvRFlpT1UvVnQ5Q1FtcVRMWEZCNE5Na1lGWjRDbmV6THNU?=
 =?utf-8?B?VVdhVlhBYXpaUjRSK1Zhb1VBVDVOU1dZMzQycmJmdjlrZEpOZFJjeGpzQ0do?=
 =?utf-8?B?QmJWb01QVEp6L2VhQlRKM0drY0w0TjVhaEVOZTA2eGc4NUl3eTNmQlEwbTJS?=
 =?utf-8?B?Ui9nVVB2UUYrdjB1ZGtvNFUzb29IemQxcWdZcU1NZTJHUTcxdW5SUW5VaHRC?=
 =?utf-8?B?MWpyYUZmUHlwTHVlcnNJVjk0bHFIYzJEdTREUTVpWGVncnZIMENTL2pBTXQ1?=
 =?utf-8?B?eC9XWTI5L3UvS2l4b3V0NkRtb2JscFFCcFV2MmhGWExFRFJ4bE5yNlhUSFhy?=
 =?utf-8?B?d29VWWZUK1BQOTlTcE15R2F0VE9yckc5bUFjZ1RiQkhKSTlzZDVZQmVUN1Vs?=
 =?utf-8?B?TUFRemRzYm5KNktiT1NMVWVFMysvRStFQlRtbFBVVVc2WVhFZkppWkY3UXAx?=
 =?utf-8?B?ajVIeFM3cHp2UVpHRU9Gd3JUMGtKNU5sQ2NhS3NLNXVjZGtIckFoNVhSZkRt?=
 =?utf-8?B?QWl0dG5GaEtvRExqZ1QzZFJrYVVsK0xESlBCRUdHVXdZN2QzSlJiT1RkSmlz?=
 =?utf-8?B?djVBTUJBT25pU1ErSnoyUTl6dmxCWnJkZlJCL1BFYytnNkRtVzNhNjdacUcw?=
 =?utf-8?B?YWVzNmlId0NpTFA3ZzNhWEw5cjZZZVJDRC9YbDNZRlBMUWJpUTlvbm5ld2VV?=
 =?utf-8?B?aGN2MUpmOUYvNm1OR3ZVWmxkVjJpajFkWEJCREwzQXpiYU8xN0oxdzN1RXha?=
 =?utf-8?B?aUF4WmxZK3djVkRoRnBxYlpEMDR1TGdiNEFxSFhDMDZHMVM4Q0ZsTGx4cml6?=
 =?utf-8?B?UjF2REdxM1FKZWw3ZDRJWVBwSmFTTE9vd0pZc2hwTThvcXoyZ1dCbUhYSWc5?=
 =?utf-8?B?WUlKd0V1bDZnRzJVZWQ0dU4zOWtNYnIydDFlYkhvVnZJb0dVM2c0eGwvck1K?=
 =?utf-8?B?RVZPT1hhZWNXbklZcGpHTURFNEd2U1FsV1Z5M3dVNmsyaE1KNVBDL28yYVJu?=
 =?utf-8?B?V3pCbkZKd0dlOTFEdHRZeUxPNTA1QU4vbFAraWY1dmF2WmxJRUdCeC9ML3lT?=
 =?utf-8?B?RVFUT2hkRmJBbzd2U0tRTkdHRFNkR24xUDl6NjVpZzgraHRGL3lZQ0t1UldX?=
 =?utf-8?B?dmpQQjM2VHBMcm5uSFBRVzVQdGxZUFBhM2lxQnlQMEhidksvZ3VZUXJIcllU?=
 =?utf-8?B?ZVpEWFljWnExU1ZTeEg4UjNjTm5VOUtzOVdDYlN1VnhEWnFkcUdXMjVDd0tt?=
 =?utf-8?B?RWJjVzAzZ25wZEVWZHVHcGlCd1lVNEFxWlU0RjJZcytPTFdQWTdVT3QrNUwx?=
 =?utf-8?B?RFRWd0JvcXVPN0dWakZFem11QWI1SWw1SG1OZkJqWVIrQW1OaUZkWUZ5N0FD?=
 =?utf-8?B?cC94NmZVU3JMY2lZdkRYWW55SnR5UWRINFZ3MC8wYTdFeXJiamljcUxpMzhX?=
 =?utf-8?B?a1VPNmc4OWZwZ0puYlBpNlJYTDJjejJxTE9JMktZdVFGZlArb2dVTEEwOWRN?=
 =?utf-8?B?WGRMeTlONUxYY29KZ3RmWDNYK1U3c3pqR1BzMUlSdHh3RUw3eXErWmpxbnVW?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5afe5a-41a1-4560-8b94-08dd9861858b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:17:58.1134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elFpiPRGVnpc3yB7+ZY/1O0LdpfYUjKsT+a31whwSde0tdF69GAHBEYQ/PbKZ6T+hPnpuXvo7W3Lo7KnDL+woPjeGBv/qaWb+RdLt6dWrXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7939
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

On 5/20/2025 6:19 PM, Stephen Hemminger wrote:
> On Wed,  7 May 2025 16:22:11 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> Add support for parsing floating point numbers in cmdline library, as well
>> as unit tests for the new functionality. Use C library for parsing.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> This looks good, please resolve the checkpatch warnings.
> Not that all code has to checkpatch clean but lets try and make new
> code be cleaner.

The idea was to keep consistent styling and the number of changes to a 
minimum, but sure, I can do that.

-- 
Thanks,
Anatoly
