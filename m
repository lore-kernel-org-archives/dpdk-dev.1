Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236AC8302B
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FFBF402A5;
	Mon, 30 Jun 2025 17:21:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AF8A840291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 17:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751296865; x=1782832865;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EriU9s1iHnDNXpoOPn+bH7h03U5HCwO9clMvSFhUR4g=;
 b=iEFd2KgkYejhvvU4H0cISVmdqNO0Go8YhZV/HxQptRL+Yq+Wh2HfNJpx
 rKndPSD1X49K/6rDOsQ9N7+b6m33JiJrvc4NFJ8NlUhwQmLbDyPFeNUS3
 G38/1tx225sVosslqVnKSzA43CrK4MHCgFT6YTr85X1UG/Qv1vegw1wmL
 j2CMTc0jjXbkbuMFZ3kczfseN4LuhhghEwhqDBneDvm0bOthGtUl4AyNJ
 1TwlezqNoz8BcMIdx2vCXm7HntOEYbqdvh0uwSRRdlPiX07bgXghsNnIJ
 uNbum0z7kVY8VTcTg8QKucJWIQKA+qZjbVq2oajRqniKUIWL05qtn+ugA Q==;
X-CSE-ConnectionGUID: KaiSjOyMQDGHWCfUxL5zCA==
X-CSE-MsgGUID: 8f6W0OOJTrKem2SOIfzF1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53464882"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="53464882"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:21:03 -0700
X-CSE-ConnectionGUID: BWElL+/jQbSe+ae2SrrfDg==
X-CSE-MsgGUID: PgpB0PjVSPSzvVmDVSeOKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="157522870"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:21:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:21:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 08:21:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUO6Tys6LmP4UiSO2zj9QKq9mTRTHhFq5eZDqU1YdDtEPzC0nOEp+4f8An+I4JtN6Jv4KstdjOeZEnDCR+zc1QEj4pFAN05X4NmbidUQcRJaSpMe92uf3/aBvzxB/5Xn/eqVqZSl5vyRbwxf+hZqLmPLNdcd8VuT8hyjJEJ6OGByK8YkloF0Ag8dEhKIdcoBtryLPGrCsulNHwlZVOoSngK2ABZXMnZdC/5w/SLEfMlefwjY3TYDwboQDW3G8zMn1c2kkZNiGANhMCpVK7HygqMqmNxp6Hu2WXRB2tY2nrT8Pw2mRgjosqvPJF8c29JiDDQXygPb5WcaTAjcZ2SO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rb3BVLqceVmDB0gnJk+zeiBT8oA3CfrlQW9bVNTs0k=;
 b=NfiUiSRHu8FJq/rHbn/9q75R4utFp2ZL8XGnINv1YZrafELKyOO9qfkb0DbWaph/zK9kj/EeJR6hy/BWrI41xQi/oXmqJv0gAqiBBvqMNKECdfdBSuIFKg2xxgVwfjVdYembCCSB7Zh4I75CzUzM1hmSUYZ/0VHRuDFVU8sJv3kZtYVJ1EXOse41tcdzDWCeFVyjH7FIiTEC9ip/VD4hRqv/z+MAhpv3rV+uG87kBHzQATK0xh2LftTY9saRJIet0M9a+C/jA9TNE7+JPx0U9zg+Yl7qPVPB//nnHT3QMiVz+4Nvbi6LYFQKT16l9P/Lu3GikEVC7bG79OdPVoj1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 30 Jun
 2025 15:20:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:20:31 +0000
Date: Mon, 30 Jun 2025 16:20:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v2] test/argparse: change initialization to workaround LTO
Message-ID: <aGKrNT8h5FGVrBjH@bricha3-mobl1.ger.corp.intel.com>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <20250630145934.56969-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630145934.56969-1-stephen@networkplumber.org>
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 751cf127-1c20-4f24-4f8b-08ddb7e9a69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDlrQ2cvVnVnOWtmU3M2ZHlLTnJ0cEpJZzFzZlN6ak1xa0ZCdVc4R0JkSXJB?=
 =?utf-8?B?cHdJK0o5bjRKNTZlR3RBODdkMXVpb3dJdlR3NGdrL095K1Jyem5iWFNkUHA5?=
 =?utf-8?B?VkNxSjR5VEIwZ3BPa0tmVy85RzNqdmh6WThoU1VBZE5mOXZ2aVV4ckhtOW5I?=
 =?utf-8?B?NnVRbXh4Yi96MVV6SzBCVkxvNkdvZWVxWEkzc0xoZEhpeFhoTURSb052TmUr?=
 =?utf-8?B?UWZjZ0VvWlduWTFGUGNUdVYyRmtwelhldWJpaDh2ZktiZjdiazlrWUlTa29L?=
 =?utf-8?B?dGFHMjlTOUlURlNVRk9CS1A3bFRlWFpNa3pUaWhpUDFmVzJ1QUxFMHNRbXd3?=
 =?utf-8?B?OEovd3dsY0RDWit2VExMM29OMElhcHd1R1VuWW90NWdtenBFcU1TS25QK0ZD?=
 =?utf-8?B?R1hjSXRwTFExSVFFU2FYbHpBZzNObCtrN3JYRXNydFZ0T1Y3UG1Jc2RhOVVK?=
 =?utf-8?B?N1MwN21QVUhNQ3BIZnhITlRqT21zRitYK0hCelBnOTE4dllyMk9MVnc0a09Y?=
 =?utf-8?B?MFBUTlpsOGhBakpFVSt5dUl0QUpWSzRZdkVVWGw5RlFCMFBhRU9rUjhKdGc1?=
 =?utf-8?B?TEk1dDkzMHdpUDN6Z1p4WVJndklMNmdXNkl2SjBTM25kNmprdlorelNaMlhD?=
 =?utf-8?B?TkUxS0hveHc4WjlVdjAwVGhNZHA3WTRyeFgvTGxGV0dxSytUTUhxWmIxUkFK?=
 =?utf-8?B?Q0czcGNGOW5NVWVYeGtMWm1UWlhEMCs5dXJlK1BhZXhpWGVvbkpaaTdYaFk0?=
 =?utf-8?B?aEl1OEdEQThSNllDMjJXOW5GL1VyV2lxR2RjSWk4QTNxWEhFK1MyVkRUdU1q?=
 =?utf-8?B?a1JJZ20rQ3h3M3dJSDVwWW81TDRVdUgzZEhyK3JyajdxMEtwYXRjMmdxdklY?=
 =?utf-8?B?OEZ4a3pDMy9QdkpRbEFVMmxzQ2Z6YVFURXI1cUVONGl2RVBucXhaNEdsbHBQ?=
 =?utf-8?B?SndvbmFVcm9kdHZ0aktrWlcxY2F2VXM4aUg0S0U5S0lQZ1Z5RFZHaDI1UjJB?=
 =?utf-8?B?MnVldlFIOUd6dTlVUnpPTitsYVpjSktOd2F1bXM4cUs3Q1kwY3RQWXNRYzky?=
 =?utf-8?B?cVFJMC9FZHB5ZEExSlZ6a2ZLOXQ3L1p4djgydTRYYTZHc0pQdmFDMHM1Rnc0?=
 =?utf-8?B?eXhpVldHaktUSGZXV29SV0NrZlVOa1d0VmsyREsxK3VtUkJUUG0rUVpvS0Z5?=
 =?utf-8?B?aUJIclR6T2NuT2FSeFJFQVVZV2NtQjR2VWxjOElsQ1JOeEhpZjNmVy9zTGpF?=
 =?utf-8?B?bjZSM0tkUktoQnZxNkllWUdWbWtidnlkYnJYQ2ZiNFJOZmtVTGpGWHMwVXhi?=
 =?utf-8?B?MUtERlV5VEpZeWVQN3p4Q1ErSE03czZvV1lHQ05rZmZqcktrRnhNeEhNZ3F2?=
 =?utf-8?B?VzJvSkpPNjJuWlA1Q3U4ZFdPSGZxRE9TU3Z3akUvd2xaZjgwMmU1K2V6RWty?=
 =?utf-8?B?RDRUNWVPUDZpMmc0QzEwbUhBV2xnbGlQSFNmbEN0QWhwMGdrQjA0ZmVzSTlU?=
 =?utf-8?B?MW44eVA0TTJBdzI0TWZqME1zYXZxOU1rTU5VNmtSYU9BODdFcUxNRW9GTGlT?=
 =?utf-8?B?ZXAzMDkxby8wakM5ekwvT2pZQ3R0VlN6WjA0QXRuZUVwdlREY0FUcENKTnlI?=
 =?utf-8?B?YkU0Zlh1bmI1Vnc0MllNc1B2V0RyeWVOaVdtRzdtQ0U4WEYvZEJiZlNHNUcv?=
 =?utf-8?B?Z29Wc2JLRHl1VDZNbDJUWGJ3ekw3QVBacFl3WDBqKzFIcmxoQ3lHaEFERGFH?=
 =?utf-8?B?M1pSSE5BNXhUMWw2bElQY3pkdDZYR1VscjdXYnpwNUZLc3RwQ3luUzlDRERk?=
 =?utf-8?B?S0NucEZneEhmRHBNZ0x4cTVwK2RGeUtUWTZZNUcwWXJnb1g2dU1leXJidVJq?=
 =?utf-8?B?QlBDcTI0c1BPVFgvVDhRVGhZNXlFbzQzYWN6WUtUV0pyZ3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VCTkJ6TlltL3RLczd1eEd0VkxvbG9SdG1vZlpXVGdBcUZPS1huVnFtT1JN?=
 =?utf-8?B?d2t2OEc2NUR3dENFWkNmRDVmM1JpZmVUbFVQcDNPcEpoQU92L3VodXZ3bHJL?=
 =?utf-8?B?M2N6RU9Cai8rYTRoeWZoWmttL0JLWldPc01YM2xNcUJmaERtRmRwWHBQaUxE?=
 =?utf-8?B?SCtVTGF2VUV1VTdENHJLQ2FLY1J5OTFZYTBKZVp0WGpoZDBhQ0lWOExTd0pl?=
 =?utf-8?B?Y1BnRnVkWE1BSDhsVHFWUVhBd3BNVDl3ODNxMDBzbUdFZ21RYnBrZ1Z3SU1y?=
 =?utf-8?B?U3g3aC9lekZIMWlXeGRISFlVclRuNmYzb2FIUU5oWE9OZnhaSSt1cjhPVFY0?=
 =?utf-8?B?QW1RT2ZFRG1zMHk2SVhVaVpVYzY1OFgwS1hBL1QwN2VVZ01IZUlRbDdhQkVO?=
 =?utf-8?B?MjBZUUJERnBnditGSlEyNHNhOUV1TEh0NXFkWXZqd0picTVrdzBOcXMwbHI3?=
 =?utf-8?B?Rzkydnc0ZW5tcmZRdTZZT1NFVHR4U3NsY3RBUXN4ZU1jZi9tR1BCcmZ5MzdT?=
 =?utf-8?B?amhmQWs4RFdJTFQ1WmM0WWp2bTdINVkraDBiVHZwWERZZmFHeVhDak13R2RF?=
 =?utf-8?B?ZklNbmFSZGpXNkhPeithOXFvakdVRGtIRW9TQXZ5eEJjaEFtV3dWTUozQkh0?=
 =?utf-8?B?c0N0NFVWa2ZsR0dHSkR4WVZ6eUhwdXowSzJVS0xYa3dNd0J3MkpvVG14b0Fi?=
 =?utf-8?B?TGY1b0tEb3BkaUFGUE50SzJZRkp0dkE0bkt0V0hLS0laOU8xNzkwL1owMVlX?=
 =?utf-8?B?R3RNSjZIcElUOGIyV1NwSnFFV3hQcWpvSEtLSlJUKzNJVzdLVVpwS2dTOHlM?=
 =?utf-8?B?aEpvcVA2K1paUjU5MjRXVWZ6YXUvc3JhTEdiRmo1SkY4bWY1dW5tc3lzUVFW?=
 =?utf-8?B?dWJ2TkRlNWFQSUVZZTJFVkNzWXRKRkVIQlltOWF3NFFYc1RKbTBZUE1vRXht?=
 =?utf-8?B?WWFVSmNWUTQvUDlZK0pQNnFwbjhQT3E0SjBVcHVaZlFKZm9oR0I2T1I4RTd1?=
 =?utf-8?B?ems3Z0duVWxKdTlZUjZSeWlhSmNVMnA1TjVaZkJLOElwcGo3bWUxNkw5OTVk?=
 =?utf-8?B?WFU2UHh3ai9PaHdvWkxBaDVQTUkvemVXRTlmV1Vjek0rNXhRcERkcHhpZTdG?=
 =?utf-8?B?dEl0ZWFvUW5OMTVPNzZkTXY0TjZ6WlExNmVpdks0MXRDVWczZ3dJbTNxOXJ3?=
 =?utf-8?B?TXZHMU1MMUZab1lHbFZxa1o4am43ZDcxYVBEUlB2WnBVQlZ0NG1jMGxFbVhs?=
 =?utf-8?B?WGp6ZTMvcG1xYjBTMFdFclN3UzBDblJMRmRsRFM3L254NW1qMkppdGU1anRQ?=
 =?utf-8?B?cE1keHBnZCtQL3YyOXNMRDZEMlZTWkw2b2J0MSs3UndyQjk0REFoVFl1NFpH?=
 =?utf-8?B?aVVGWjF2MHJJSzdsY2VvSDUycUZ1cFR3TWxWMDJsQmFaaW1xa3J3UHlxa01y?=
 =?utf-8?B?bEx3bXQ0Zmw2cmVvd09NekkrTHAyQUdoYXBubGxWZzhmS3hPVUpYY3RVT1NE?=
 =?utf-8?B?TlVHVWpVSVlWbjZZQmk5OUFOY0M4NHlWaHVTV0QvNG9kQU9IbzIrNTFuVGRw?=
 =?utf-8?B?TUFqRkpYcWhBYmR6QXNXRmJ1eDBYT2M4ekVWRUJpWHNnbWQ0NytCZU5DOG8r?=
 =?utf-8?B?eXpQdkF0aWQ4S0xyZWNCUTZucTB4Y3lmZ0UwR3ZNb2t3VVJDQkw4UWFiVVN2?=
 =?utf-8?B?TXdHc0ltTDdWN0wrd1A1c2hQZ3JvQjEwTTllckY0OTVCeW1uVHVUVi9waE9D?=
 =?utf-8?B?RzhoU2VJRDdZVXprRHdsMDB1TjNtNkhhV2pEZ2JxRDRlQVR0NFBWYXZXeXJQ?=
 =?utf-8?B?ZzNXeWxldUNNMHFOaXNaNlZKR1hDMVZPRXV2ak9ueWc4YmU1SUsxWHBWY05F?=
 =?utf-8?B?djlLT1A4dXJxL3dVcGhTM0paaXhyNGpZaC9ZVUZvNVdtYVZhM3hRSlFNakdR?=
 =?utf-8?B?eVhDTGNMU1krekEvMUtqaGVBNVBwbzFpUmh1Lzd3N1RYNWN3K3FUNXlOc1B5?=
 =?utf-8?B?ZjdXbXNKWXVJUVFlMUtTN3BWV0E1SEJlR3F0d1dOZTE2V1BMVUhtVjNRcWow?=
 =?utf-8?B?WVdCRHN4Qk8yRTU3d0FLRVJRelg5WlRkeDJwU3dQRk9vcVNJS0tKd1ZDMzM1?=
 =?utf-8?B?cDhHTmlBRlhYNmJZS08yMUp6QlNVNTRnYmNncUZVaUNmMEFmTmVvWWhRcDhl?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 751cf127-1c20-4f24-4f8b-08ddb7e9a69d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:20:30.9334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqaDpSddzkBumo2ql+moarFcXmiExNeNhJyUjAjpW7d0RrblQuVOOKhvLidMOzM+d8GoHZ00U4LZwq1KhMbKmFZbo5jEpJhH5OpUCLBtm4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116
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

On Mon, Jun 30, 2025 at 07:58:49AM -0700, Stephen Hemminger wrote:
> When compiled with Link Time Optimization, the existing code
> generated an error, because the compiler was unable to intuit
> that there was space in the flexible array.
> 
> In function ‘test_argparse_copy’,
>     inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
>     inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
> ../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
>    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> 
> Initialiizing a structure with flexible array is special case
> and compiler expands the structure to fit. But inside the copy
> function it no longer knew that.
> 
> The workaround is to put the copy inside the same function
> and use structure assignment. Also macro should be uppper case.
> 
> Fixes: 6c5c6571601c ("argparse: verify argument config")
> Cc: fengchengwen@huawei.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> v2 - simpler fix is to just inline the copy
> 
>  app/test/test_argparse.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

LGTM. One suggestion inline, in case you feel like adjusting things
further.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
> index 0a229752fa..d5b777e321 100644
> --- a/app/test/test_argparse.c
> +++ b/app/test/test_argparse.c
> @@ -71,7 +71,7 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
>  }
>  
>  /* valid templater, must contain at least two args. */
> -#define argparse_templater() { \
> +#define ARGPARSE_TEMPLATE { \
>  	.prog_name = "test_argparse", \
>  	.usage = "-a xx -b yy", \
>  	.descriptor = NULL, \
> @@ -87,25 +87,24 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
>  	}, \
>  }
>  
> -static void
> -test_argparse_copy(struct rte_argparse *dst, struct rte_argparse *src)
> -{
> -	uint32_t i;
> -	memcpy(dst, src, sizeof(*src));
> -	for (i = 0; /* NULL */; i++) {
> -		memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> -		if (src->args[i].name_long == NULL)
> -			break;
> -	}
> -}
>  
>  static struct rte_argparse *
>  test_argparse_init_obj(void)
>  {
> -	static struct rte_argparse backup = argparse_templater();
> -	static struct rte_argparse obj = argparse_templater();
> -	/* Because obj may be overwritten, do a deep copy. */
> -	test_argparse_copy(&obj, &backup);
> +	/* Note: initialization of structure with flexible arrary
> +	 * increases the size of the variable to match.
> +	 */
> +	static const struct rte_argparse backup = ARGPARSE_TEMPLATE;
> +	static struct rte_argparse obj = ARGPARSE_TEMPLATE;
> +	unsigned int i;
> +
> +	obj = backup;
> +	for (i = 0; ; i++) {
> +		obj.args[i] = backup.args[i];
> +		if (backup.args[i].name_long == NULL)
> +			break;
> +	}

We should consider either making this a "do { } while" loop or adding the
termination condition to the "for" loop statement as normal. For example:

	unsigned int i = 0;

	obj = backup;
	do {
		obj.args[i] = backup.args[i];
	} while (backup.args[++i].name_long != NULL);

or else:

	obj = backup;
	for (i = 0; backup.args[i].name_long != NULL; i++)
		obj.args[i] = backup.args[i];
	obj.args[i] = ARGPARSE_ARG_END();

I'd tend toward the second, myself, but what is in your patch above is fine
as-is too.

> +
>  	return &obj;
>  }
>  
> -- 
> 2.47.2
> 
