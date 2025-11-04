Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE3CCFA0C
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA80F40658;
	Tue,  4 Nov 2025 15:52:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 052CF40269;
 Tue,  4 Nov 2025 15:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762267965; x=1793803965;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qAuaiNxAdslIF1/GtkqBRUrHoSbFgf4npbZ2DfWYvrs=;
 b=aAkzSJfbdrckQgtlzwV4reP+s0t0jGEVBGVxfiIxvrWcO9BHRTYV48u9
 sUjYb+Mn+PwYjwLh3ZIDb0Yff5UEnE6wQE0kxzwQR8C4NVzL6UE1EYXQ/
 Nd8AICr/lrMocEofLfGJTMWM9zo8i+q275U5iMcKlI8ZMS6N9Mfgothi3
 39wzNvH79dMvbIxVAzJHZ778HASarYqOspZP0ByAZkQhdPhdmAHS48WAE
 O8A+MVWOP0QWRn1I3YqPhA/xhvDrpqQjruOgcRLSnr6TmtkPhj286HXlG
 SVZOWm143GSprTh/KVqyKXQAbg3ek/KDgNuQGdwvMurnmVApNPAKWfEIa A==;
X-CSE-ConnectionGUID: LetYNFetT4yvNEej1UnBEw==
X-CSE-MsgGUID: XjBuHBgKR1qAbQJsNl5d5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75042878"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="75042878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:52:43 -0800
X-CSE-ConnectionGUID: 7sUENoWqSrO2blnpd3IuyA==
X-CSE-MsgGUID: 8K0zSfDSR0uXMsybQxnMLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187127366"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:52:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:52:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 06:52:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:52:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCBbRbW7wjqu8A2IYjeHAgTJeJ71KGzK0cz5WAx87Gg9GDv1oiJhsV5rKxJop/yplsm6KJayUEkMDrRcjT29P3u1z3eg28vI41BnERbJMucHrfjP8j5/AiO3l3Ig2mMm64Fg+ldrgi1o+3QMY8yxNjZT7WN6u+8aexBpHUXHQzh4Mxip1HqYjFFLwwJRQujXQzfoAp0RNXoA0fiW3zlyaxiL1YdO4Rt+dNLN/mrl3sFY2Ye/g4wKcwJ4jijbFAf7D8a88rCthgDvtDEvyMF5YWDh4pZ4yebhvJeeBy540BujaSwfzlQnUL68JKwfGBbOjWUZ1nSzaGXWlYvFMNKdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55HMT0FicSrcBhnRERSTivE7DMmasrZu2ort83pGyf4=;
 b=cEH4WPV39uBM33kmbZc+ng1iL0jCOEmUKNeoJd7nLhVfUo+kITYINXob8WYWIWfx/QdIlLU6UXyY2sFBP1s0BszH0mlM8/T1Fi7vBpEOYQvcbxYUncD+qlG4Dw3VYfdjulkNxeK/A5gLjxTMBej/+vtEWTkgjRvfaZfNt9P7APajc2mQI9MEIUZwZYQg4n4e1bNM5k2aF+5LxwOB5wKmkhJux2MKLb4sXLq5rplKnJYooelvCXhjZUR09wXXsOWKIq8J7zlkDyZA/0+jHDEOsk/d2L83uIPaNIuzSkUDyxVMRCWRGsPJfq+X1Su+q7NBnp9RHlFsTkXICR9dCo6Njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by MW3PR11MB4571.namprd11.prod.outlook.com (2603:10b6:303:59::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:52:40 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:52:40 +0000
Message-ID: <26e240e0-9d0f-47dd-a94e-c13599f0368c@intel.com>
Date: Tue, 4 Nov 2025 14:52:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/fm10k: fix build with GCC 16
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, <stephen@networkplumber.org>
References: <bug-1822-3@http.bugs.dpdk.org/>
 <20251104111515.1728873-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251104111515.1728873-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::18) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|MW3PR11MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: 0632770a-de85-4b5a-442f-08de1bb1cd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW9MdU9HNkhsZDlGcmxOSGlua3FYcUhvYXFqSmh5YzFLSUsreUxLRTViNVBw?=
 =?utf-8?B?MW1UM3crNkZDY0VaV2JCc1dDRTNsUzNhNkpTU0dsWU03SHJlUjllMUJtOXVM?=
 =?utf-8?B?OGpQRXJaVVhIbjRRemFIblNlVXJpZjlKcDFSVmxtekk1aXdHemVnSEQ4bVdp?=
 =?utf-8?B?THBXSG55QllZajJ2VjhlcDdzVXdnOEVheU52TXdYWDBDWHRxOGU1b1R1ek94?=
 =?utf-8?B?NVppVnpiRDZITmdWRUkvY2I2Um82ZzlFdG13VUpqMWExMCs5Y0E0aGZqaDNP?=
 =?utf-8?B?dzhOSG5mQ3lZZDduOGtjSkcrMTBiVFhvSWVVTkFDT2I0bHllZVR3OU5oYytr?=
 =?utf-8?B?T281Y3RRSjlqUFFuZjZpTTZzakRtckVMeTR6K3FqNnhkbWhPOGVTNzUvV2pK?=
 =?utf-8?B?OTZEUDlDSXZ6YUtZK0RwdURTKzkreTREczhKT25yczJxLzdrUGY0Sk5DenFJ?=
 =?utf-8?B?VENkOXZyZStUd2dzQ0hqU1R2WDVLUDlBVVJkNXRFanZlWkhqSW1RN1VnZzR1?=
 =?utf-8?B?SlkwcmszQ0lEOGFTRkFEcmkwZ1lMK2p6MzZZMzdQM0dCcHNpVXNldmVvNG9a?=
 =?utf-8?B?NFE2c1pzT09PYVpQUFlyQnVxVkRKRG0zZzQwYmFYc25qK0phTThQOXdCZUlV?=
 =?utf-8?B?RXZhMDJzV01PaWQwZFJSQUlqeldUeHNidU4rbm50Smh1VFhBSzFzdktHSlhG?=
 =?utf-8?B?eXFvUGF2bWJUR1lPbnhIcU5XWkJLRHpJSC96RmdwWndnQjd4OEVSb3lIVk5D?=
 =?utf-8?B?MmxIbHlNMXZFZy9adDFxeEY0VUlRNUpUbUxmMVhBb1Q4WGhqUzgwMHpZMjg3?=
 =?utf-8?B?Zk96M0Nta3hYRDRRNXlCNi9MOUJnNWxRWlBBd0hxUytLM1I1RVdaS3QrVktr?=
 =?utf-8?B?S3FHSzBiRld3Nm5Rdzd5U0tSSUtQMHhjVFhTbW1vbnFOSFdubklHbyswbXlC?=
 =?utf-8?B?R2lYNlVXR1NxblhPdnVCQ2xiWFBUOXFkUFlvRDZHOENwUS96WGVaQUc1OGEw?=
 =?utf-8?B?WXVFYUw5TkVpMUFKRW9wVm81WmxzWEZTcW95YkhXUGpEcUR0dytJczhXM1Zp?=
 =?utf-8?B?aDJ6WFlOc1duVVVkSkxpNU9JUmlEVGluQ2YzcmtlOGlKMU1ESHNJWTFqc01J?=
 =?utf-8?B?QmNBa05hUEVHdjAyVUZzcUNCcGttcjZQMENkdzFxaExlaGlJRVVSMVBOSW9T?=
 =?utf-8?B?TUkwOUZYYkM5WW5zbkpFeDFVdG02OFJKQ21lclQ4RjVCTnhhTy85MUl3WWhX?=
 =?utf-8?B?UVo4aXBKVVNLNkVLVjFHSm1maEt5OFhlMTBUbFIwV0I5Um9mQ3BrOUlFKzhP?=
 =?utf-8?B?b0pPMkNmenhLM2gyTlFnVUd6b2hpbit3UWQ5REFZOXY5UHBiby9EbnB6bVdw?=
 =?utf-8?B?cjUyU1FqQlBQMlY0Nk1rd05obnNxZTFiQkh4TlpPRTMyNEpYS1VxbE5rWGhm?=
 =?utf-8?B?bnoyZ1BlTHBENldqQXFTd3pEWU9HZ1J2bUxjZThLUnRpMFlpaFkxRnYxRDlE?=
 =?utf-8?B?bXJ1OTR2RDB2VzJkMmZkMTI4SlE5WDhZSkcraENMT09PZGlaU0pxODZETzhU?=
 =?utf-8?B?d1ZkSDRxcTliVytPREhyeHNaSDhoVjB4NDBUVFdidHhTbWlqQUJzZWFsSFpy?=
 =?utf-8?B?bTk5bmFsWFduZ3JWKzIrTTU0c0VIZWNoMGZtSldyd0ZsalU2bjdaMU00ajhH?=
 =?utf-8?B?UDZwYmFqRmp3YStkNDNtOEZER1VvaWV1UUlKSUJFU3dMZ0lhbWp4K1lpb1pJ?=
 =?utf-8?B?dmN3a0tTbStCaFp6eSthdWNCK1I3aTc2d240SnQxc3dzYXB1Tk53d3hvTWNh?=
 =?utf-8?B?UzBnUDltZjVYbXhRRFVBVy9FT1orQ0tpV1czOG83azEwK2VRaWdsS1FWY1U0?=
 =?utf-8?B?bG9laXEvVDFKNmFYbzRmT0kyeTNjVFI3V1lVaWlQVkl1bVJaY3NtakVKaFoz?=
 =?utf-8?Q?71bKKynheooJSZDR5R3tZITnHY/2cNio?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjAwYW5CcmY4TnFQVjdQNDhVWmVtZktYZ1M5TDRQaGVrNzQ2ak1NZ1RQbEdB?=
 =?utf-8?B?R0dSRnhxRXNCUnNYbCtwRHN5bUEwc2tGdndQTCtlWGNBQThZTFQzSWFsMC9U?=
 =?utf-8?B?TkdCclp4RUZoK0laUExvcGMzVHB6WTA4TS93Qy9ZRk1UWEkyWkdndGkyNlI2?=
 =?utf-8?B?TVUvU2YrNW91bnVZOFhqMndhSzVuLzZ1TTFTcVBJYmwra21sVHN2Y2FqZUMx?=
 =?utf-8?B?WHJLdWRJMEtvVjE5QkoyK1M0SHUxZ3RFRWpLcFFtY01RWXl3b2RFM1FTQXBj?=
 =?utf-8?B?MElXUnRKOTJWb0lLT0ZvdzJDOEFXQzg2RVpuNGh0aVc4VTlWbW03bGhBaElp?=
 =?utf-8?B?d2RPdGk4RkdGdkdyRzN3bUxyUDVPREcxS3BkUHAydnRROHhBWmJMZXM5SzJl?=
 =?utf-8?B?ZGs4UFNQczRyOGhMNTRNdG83V3J0cTE5QjM2TGd0MlQwYU9JNk5UTmRNZTVj?=
 =?utf-8?B?b3dwOU1pZ0dUeUo3ampoMUpOenN4RFNndVYzc05tamF4bnN4eU9qUlQyTCtw?=
 =?utf-8?B?OVlzN25Qd0Zlc2FWU2NmNHBjQiszUFc2Rm8yVmJhZW5GakVOYm96QlRkSzNp?=
 =?utf-8?B?UDErQWp4OUVJbmdzOStUb2VQNC9jTEpORjVFTFNacnk4OTI4cGNCNkFFQzdH?=
 =?utf-8?B?MEdRNVMxOVY4bkVJSjZJM1VzRXVkM2k3M1M3YTYvTmFHRkVOZXVJbVFDTzNJ?=
 =?utf-8?B?MmNWU2t0a2NBQk1XVjRKZ3BBalAwdm1zd0RaS2ZqdE9Mcnk4UGk0VWRoSkgz?=
 =?utf-8?B?QmVxbGs2UDlIZ2E1U2pzN21UTTdpUUNrWG5LT2FscHgwdUU5T0tsck5saHpl?=
 =?utf-8?B?VVdUbnJkRXFiV2cydHY3MFlLSUtMcmRadXVXTnpuekJISkp3U1FmcFlwUjJH?=
 =?utf-8?B?R040MTMzcGRFQklaZHIzT0l1OGZwVUJlWEMwb2ZmUnhHVG8rdmowL2lOV0Vu?=
 =?utf-8?B?ZXB3QW4zOHdMc2FOeklwMENwODdiSmpOUjhXYm0xWDF2SWdJVEdWbWxlS213?=
 =?utf-8?B?R1UyQUoydnBjQlE3SWVzY3FzQ28zbTVXSkFUdHF1WllncW9nOHhFWllyNG5C?=
 =?utf-8?B?ME5TODN5d0UvMTJkSE9EQzVkcU9PdTIydFY1RTZUcnEwaTZEUjUyV2xyV2JJ?=
 =?utf-8?B?SlN0bXYzSmFxMDNaNUxXbDg3MldZQUdWa0FUMGE4UHRPUm0ySjZJVXBTZDdk?=
 =?utf-8?B?UUVxMlE1WnlJSmdubU1qMEYwZGx0eWRCMkM1RWc3QzVsVDRpc2pmNmQ5MzdE?=
 =?utf-8?B?dVdMTEdRakoyeDk2QmVVaTlCUTF1ZUpvckltV0NCR210WG05QWY0YTB6dU9u?=
 =?utf-8?B?R1ZXU3VhbUM2MEF2MjEweDl6WTZXTk1Lc3lFQWJjUXN1b2RFenpOb0ROOUZM?=
 =?utf-8?B?S1F4TWVObDFLQUNYUTVNN1N0K0RJVzZWMTZ2TkNCZXpzZ3NBWFp4a0d4RTVP?=
 =?utf-8?B?V0dpL0lDaGhPWURjY3JTZXdlaStpWldnUTd6QThIMFRtL01HekpkaFU4NS9Z?=
 =?utf-8?B?L1A1NG5peUJnYTZROExNaFFjZWRkRHJqVG9zVmlrTk1oTkZueFlmKzNrdmNT?=
 =?utf-8?B?aXVDejBwb2doUlpjc05HWEZoL2tadXRaTVM5cUxtOXRwaTIwNmpyY1BGUDZI?=
 =?utf-8?B?ekx0YkxkQzR0NzFvTHVDamZPVzcwOGF0blpQb0pQZzk0MEx3aWh4KzYwQU56?=
 =?utf-8?B?Z2g1RUZYT3pVT2ZVWDJJdDNuYzBnNEZsSGlBZVVUbmpDTzhnWmxoQ1k3VDRM?=
 =?utf-8?B?SGtSMmRkQlNOT2U2MmtjdDBRczZOY1cvKy8ycDhtblF1MFJjdDRwNlZnVnpr?=
 =?utf-8?B?d0MyZG5odGtMc0pVdE5JejVyQk1ZQU8zWjZ1YzBUQ0t5T0FVejh1OElVbmNt?=
 =?utf-8?B?RTkreTNTeGZpbmJtV1BicitlWEgxUjk4ZW1URUh6bnhrVjFxa3loZE1FY0JJ?=
 =?utf-8?B?LzVWV3N6RVdRekMxNGhvTld4bVZ4NzZJVXZDQktLdVpVRmFPQWdaaWhYMDQz?=
 =?utf-8?B?aXhOTGxpTStKRC9aQzVRSEVqVTRlakpEOGR3RWtKZTBrNXNUWE5QM2kvY3VH?=
 =?utf-8?B?cU5mcmlUSzZhNjV1Yy9MS2F6SkhEcGlKVkpPSmk0c1c5U1VEWnBka0RpUHpW?=
 =?utf-8?B?YWtXaGxSYmxmZndpdGRRYmY5MDk5V0JKemZYMzd1bXhoS3YyZjhNNnRPR1Zm?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0632770a-de85-4b5a-442f-08de1bb1cd0a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:52:39.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/qGDAI19xV8OjAB2yqr+5zkodizuO3+HK53gX+gIw9byMVxLLMj9Znq+GoSAFimPnQdqFNraau+jh89ziW/MwLuH2HkbBSrWA/P7YMZTyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4571
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 11/4/2025 11:15 AM, Bruce Richardson wrote:
> Build error reported with GCC 16, due to a set but unused variable. Fix
> the issue by removing the setting of the var and marking it as unused.
>
> ../drivers/net/intel/fm10k/base/fm10k_common.c: In function 'fm10k_unbind_hw_stats_q':
> ../drivers/net/intel/fm10k/base/fm10k_common.c:480:62: warning:
> parameter 'idx' set but not used [-Wunused-but-set-parameter=]
>    480 | void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
>
> Bugzilla ID: 1822
> Fixes: 7223d200c227 ("fm10k: add base driver")
> Cc: stable@dpdk.org
> Cc: stephen@networkplumber.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/fm10k/base/fm10k_common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/intel/fm10k/base/fm10k_common.c b/drivers/net/intel/fm10k/base/fm10k_common.c
> index b78d4b575b..677ef87608 100644
> --- a/drivers/net/intel/fm10k/base/fm10k_common.c
> +++ b/drivers/net/intel/fm10k/base/fm10k_common.c
> @@ -477,11 +477,11 @@ void fm10k_update_hw_stats_q(struct fm10k_hw *hw, struct fm10k_hw_stats_q *q,
>    *  Function invalidates the index values for the queues so any updates that
>    *  may have happened are ignored and the base for the queue stats is reset.
>    **/
> -void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
> +void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx __rte_unused, u32 count)
>   {
>   	u32 i;
>   
> -	for (i = 0; i < count; i++, idx++, q++) {
> +	for (i = 0; i < count; i++, q++) {
>   		q->rx_stats_idx = 0;
>   		q->tx_stats_idx = 0;
>   	}

-- 
Regards,
Vladimir

