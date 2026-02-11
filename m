Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FBDE9E31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E05B402AB;
	Wed, 11 Feb 2026 16:17:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4627E40297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770823068; x=1802359068;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=GFqGMKZFmC7varxMSJIdyQ/fL7zYHFRHZZfaF32BWgM=;
 b=WrcXmap7ANtE2maDneqZHlwa5mnWoJap9CP7m1MwcSG3QCkV8GaO11+x
 ZolUM58CMVTI8vASf7p/M7GxeirJiQeHvJp/WTacetojnoAbvUMMxhej5
 hzf6IbW6MEsPatgTw+J08YZXQ7ZDlqy0l4oDpyzjQ9nRO35PHclUKi0Ie
 RtgAjkSc8oWra4CLWjvl4SyrG2++FNzCfed0rnK/D0uF3y/s2MpXWNfW+
 X0AP2V8ZwQK71dRu0bgSNdeuuQ3xW4SdOt+ocQW7eEatX4LEhWz26O+Xr
 3TXoolBepAuhiOXK+cCDURdNZEItbHIRyg9TdjnqJgNuqKVuV9FHVlRAj A==;
X-CSE-ConnectionGUID: LCbiM2CXR76oX0s09ffUWA==
X-CSE-MsgGUID: aX1PIW9URPmpAn2kenIepw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="82610617"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82610617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:17:46 -0800
X-CSE-ConnectionGUID: 7hnrv+vPTxqupH70PQSV+Q==
X-CSE-MsgGUID: WbuOt///TAOhH9naZFVeQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211866046"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:17:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:17:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:17:41 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:17:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djtutaxgr0BJ/yAhKr5voJFEdT+k+x0vREIUNJMNwwuR7ZiGs/dwfVLyYN98TLRE6Pk0tArZKOqlhmdgR3dXH+8j5a+o09SXNCn+Zqtf2rKqxTQUH5Y1kxt/wthtwbo3EAX8fwSdlDWnrJyayMkb7Te+pDPHfK15vsiUrfI9M1VmqlKUw2320xqir/ylMM2FdB/alRyUeyv3+RxQjyRbVuYwWPqYB6cTmJ9/fTQHLKnNZC54iCcbFnExtbztDufaCiayvO7iwkHZ2MyrPvMHbd1A6ljlHw5XaBNJLoLC1M9Y5STlXeA1vfFAvL0J2hQoGyYT9bBf36e3dxz1A/ubZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5xvWnKqUl7x2e7E4gLkN6u1RB4CEHdxj+ZOYxyBT7s=;
 b=X6xPv30mPgAjyVmHfMTQArDKpax6OGBKTYUrAdOoXtslVYtC+6Q8fn6M7u7sTzFMxVyspHb28aj2ogNs/sTEPuFIBdOoN/oJmMB+PQGHKQ/8hc+YvUZRO4DuluU96heSt0givpwnOpKC1BlJTgIV1ZTib0UYQpfFtkKNNq5fJ8k9u+h2pwu4sMLuRyzZCN0uqF6Yeo7rgdmONDYjr+UGx+EeVdeJCxKfTe2sg+oEFpXUoAv0QuHbImcfq98xkfPbS9OcCL3SSOV1p2Ke7rxMBr5RrqBFwKqCOtuy+N1StnhXXg7SHJSgPX16jMqByQWtPFUeXnAXIX88sl5567Wwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB7288.namprd11.prod.outlook.com (2603:10b6:8:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:17:38 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:17:38 +0000
Message-ID: <f2f91862-938f-424f-9f4e-6f15026e5111@intel.com>
Date: Wed, 11 Feb 2026 15:17:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] net/ixgbe: add missing E610 MAC type checks
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Piotr
 Kwapulinski" <piotr.kwapulinski@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>
References: <00e9b9a24f3984857d568aad04335a01e6834850.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <00e9b9a24f3984857d568aad04335a01e6834850.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0238.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::33) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a78171-7876-4103-9e3a-08de6980b131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0d0SkYrL1JhVE45UDkxM3JpU3FxS250LzF5YjRabC9nVlVZZ1JBbFBOUjNr?=
 =?utf-8?B?eWw0azFGY0hQUWQyNUJ6Y0JOZlVxZ0R4M3NBUVAzQ3NEQkVzR3dycnNGVUVF?=
 =?utf-8?B?VGVrNGMwSTJHZXMxbnFWaTBuNElIOTkyL0pVdWVJWDdCQTBFNEdaUVlmMS9L?=
 =?utf-8?B?ZG9xVXd0dTI4MTF0di9VSVd4SzVUT3IyL3UzMk44Mjd5VVZyc2ZWblR6ZWcz?=
 =?utf-8?B?Ni9FRFMxNmErNmpJVXpzUE9PVEJ2WmMyZkZ4UlRRSzJPWWEwUFFYTzJpNS9K?=
 =?utf-8?B?bUJ2bGQzaW1McHM2UXA1ZjFDTDd2TGNIajhmZkZhc054bnN6TStkd29ZV09Y?=
 =?utf-8?B?ZWF5SEZVWGlZb25Sc3p5aDNwUnV1dU5qYmkxcGljWkVNZHl4d2JOV29nVmZn?=
 =?utf-8?B?WEV6NzBWK1d5Vld2SDZyZDRCbDlNcEZzeFNSaERmRlk0VENKOG5BSmE1UW1B?=
 =?utf-8?B?bXpOYVphSXMxOGR4WkpHWFpJSEEvMElvekJxTnY4NkdKZXZVSnJIN2toRU9o?=
 =?utf-8?B?TW1UK1hkVkZBVkhBQVl4NmVOVGRrMVJ0Q0JCVXV5UmdIS3BaUjBjRGZCZ0JX?=
 =?utf-8?B?TnpDKzBVdXBrQ2kzaGk1U2ZNS0NNMTErSmtjRW1kNHNPUHlZcStjUG53dktl?=
 =?utf-8?B?Nyt2eXVWd29CV2JoRkhDRVh2WnFpYlBFL3pucEF3d0Z2cm5Na3BZUm5rQVFh?=
 =?utf-8?B?SzBFOS83NTRCdlBaRlorTG1XZnpTcWdNKzE1TEpMU2M4MWlEOWdwc1FSaWsv?=
 =?utf-8?B?NUFBa3JkY3R1cldpWWQ4Y0Q4bVNRbzJGOUlQZU9tdTN3c2s1TURlV2U1UjBt?=
 =?utf-8?B?cVV4bDN1bXZNVk1DYWxTTDVIT0xlQi9nTmdIRXVhemQ1UGljTmw3a3E0TTFI?=
 =?utf-8?B?K2VCUXB6SGlIMlg5WEZqa041amUzVUFTdGhpN1pYNTEwczlJZUZBMVV1aVlL?=
 =?utf-8?B?YVBTY0ZCN2ZxbTV3SG9aMDVHMFdxaEEvS21OWCtYQmdjZWNYdjRKWEltVVBa?=
 =?utf-8?B?eDdVOU1JWGJobnZSZlJqVmxsUno0d215cEZVRFBVZ0loODY3dnYwSDVBM0FM?=
 =?utf-8?B?b0c0ekJ5aHE0bGxhcWxWZW0reC9KZmZnUkszUytFaVpsN0xWVEhCUmVPMFNY?=
 =?utf-8?B?Y1Qyb1FFSlQwMXRsUE5MaTQ5Q3hXUTZLeFZhSmNmdVZBM0xhSFdkVFRmWVVC?=
 =?utf-8?B?eW9ZOVhqZEd3VU5sR3hYV2laNTVrd0QvSEYrWXVxYnE3NWlpS3lHd2U1Qkll?=
 =?utf-8?B?UklxQnV6U1VYS09OUE95ekdPeS9UNzRkVHc3RW1nY2hYVmQvSTdOdnZlZnZY?=
 =?utf-8?B?M3lNZTNhQUNSb1RCb0Z3VSt5YVdrT1A3REZjTXZONU9zanNlUkpaNmFrS0hP?=
 =?utf-8?B?c3l6M2poRURQRUEvOTc2TE5aWm9HMFByWEdHT0VacU1LekFJU1FvTVZJVTNo?=
 =?utf-8?B?ekxCS3BZbjYwV2NmYTM5aDVyOWF6SkUvWXVTTkFrN0N6SytlUkNrd0xJdTZF?=
 =?utf-8?B?bFlkcEpOS3E1NG1hM3FGMHg5QVo5Q2djWldBVWNFNVpuN0FrUnRtdGJGNmJW?=
 =?utf-8?B?eTUrS0wydHN1MGw5SFYxSEwwUXFNOU9qSEpNUlAzUzgvbkhnWVlOWUdHZGpC?=
 =?utf-8?B?VGZOTkNMNlBvUHRrMWNEME8xSnJYZEVyS200VnRYdDQ2NzNzK0NCRTRYVmhr?=
 =?utf-8?B?SUJWd3l3YmJsbFdvcHpLQm1iUXZGVVlrcWVnODl0VVJteEJ0Zm1SUHZkWkVz?=
 =?utf-8?B?ZUU3ODl5NUZzOC9rUkJPek9jZEZGMDV4c25jdDVFNnpicmhId1hkcGZacGc4?=
 =?utf-8?B?OXAzZ3JMckhjVDBiYUttZm0yRUM4Zzh4L3l6MmdjOHJYbEZUNVhHTHIyT2sx?=
 =?utf-8?B?VEdTeDdETGpid2lXUDlRM2NyenNmY0MranJ4WWlhYURqaXlkYytLV2ZRTW9s?=
 =?utf-8?B?ejFRVnhBQXNtU1N5RVRHdzh6Mzd1cWxINGpMY0Y2YjZDTlp5TUh1YlNaVlQ5?=
 =?utf-8?B?eGQreEUwWXVpUFVQZXowU0EyVDFHbzR4c3lTUzh1cks5WE15WW02WmMyWjVr?=
 =?utf-8?B?Q2tIN2o0Njc4NU5QK2VHZlJLWG93bUVKMDkzU1I3U1ZiMmdwMVo0c0xpaFdx?=
 =?utf-8?Q?XF40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUQyRE5nUmhsbWNHakJyZWk2NENBNENvVGd4TzlBaWNmR3p5bTMzeExtZWc5?=
 =?utf-8?B?MFhPR3h2TFloTm9KUFh6ZjVFRSswcE9qZTFLNVhRVTh6TnRsWU5FZ0l0WVZu?=
 =?utf-8?B?VEVOSEZyMW5Zd3FmOHpHbmJhd1VJT3RYMHJKTGVhSDhKcHpzQ2JVRzQ5S0w1?=
 =?utf-8?B?akMzQStsT01wM1NWd1B4cFhZN3RBWksybWx4VU5zTFlBdEpRNTVka2NSL29t?=
 =?utf-8?B?VTkyVDh4dHExalpwT2s2RXdzZzU2OWdnTk1ENjZhZjhnM0NqNFNpeExLbURZ?=
 =?utf-8?B?MzNoOWtsUURkbjJXNi9kemF0NXdZdGpvaFpPYnJCZ3RMeE4xR09CMWhhUUlp?=
 =?utf-8?B?ZjFQQXFhL1JZcWZmZUNKenZUY3ppZlJXMDVKbmp4ZWdacEdqVm5QeHpIT0t3?=
 =?utf-8?B?Tk9JZTE3akZqTkh3bVdUd3JJaDBpaldlbWdlMFdEbGx0TW9XTndvYUNHcjhx?=
 =?utf-8?B?Y0RmeHhlaGg1ZUdsWVo0RXd0dnE5NncrVUkzeUIyNmVMUkhNSXRLcDNTb1Jl?=
 =?utf-8?B?cS9uNDdiQnpjcDkzMEtxK3FCWUw5dmdlVkYwVlNmUytPVlRtN1RjcnVMMGQ0?=
 =?utf-8?B?ZWpxMVg2Q3FtbVZITUI2RHkxSkJOR0t6QjR5Z01UVVc3cmtYeklURjhjS3BK?=
 =?utf-8?B?T3ptWFhWWkRaa3JZeU9Gb0kzbjRHSWF0TDlmdE5vR3l1VTdvNFczc3d2a2NP?=
 =?utf-8?B?MkVJMUhYVTYvaFh1QzhidkxZL201UFFjQmZ5RjBwNjZFKyttWjlDcTNDTHRZ?=
 =?utf-8?B?ZWdOVEI0SEgraUlRaDllTVhiOFVKTVhaL281aWV4dFlnUWlkNmV1enFzNU1Z?=
 =?utf-8?B?dGZZcU42U0M5ckJWVDRybmYyNWJvWk9tQ0tvZldmUlA2bW5RSmliZUpyb3F6?=
 =?utf-8?B?SE5LSEoxcStNTWpZQ2ZuVGE5dVdaMERlbk5mNktDVkJQSldKSTZrZGdtTUpi?=
 =?utf-8?B?Y2N2ckpXNzFHNHZkZTd4aG9GNDI0UzR6QmRjWE82OGpaRGd6aUhWV1ViWkM4?=
 =?utf-8?B?VzU1UGx5SXJibTFIUGVRcVdnSXdORzBOcVZZZTBVeGpqMVRpdkxpZmlJeXdT?=
 =?utf-8?B?dW9tZ0cvZldENDVxZGF1WmN6NHRyNVplMzdyZTAzZ0UrY2xnR0dnWmxCYXNB?=
 =?utf-8?B?SXNrQXFqNXRlUVZ6Rnc1WHdKeEFpVFVLMjJybFo2UjNndkJSUWFvRE5KMXRq?=
 =?utf-8?B?cFArT3hTNEtPa0srL1RMK0dzUkk3cWIxaU92SXg2cUtOUWpVZE0rbnM3dUtG?=
 =?utf-8?B?S1habEtlSjc2Z1FSallzUEFaVVNYZ3pNTjRqV3hscUhuVSt0aGRwOWtwMDI2?=
 =?utf-8?B?V1ZjcnZLYVhxbFhGZHNabjFXSDF5VEFJWldBNWtkZFdwVWV6VlFXUEh4bklL?=
 =?utf-8?B?bW9MRWJOd25ubnNXMEVWYStPY2JGQmFlR2NWTlBDMTJVa010WURJOEx6clZZ?=
 =?utf-8?B?ckJkb3JzS1pNZFdhbE5HUml0TUtjKy9JakIzOUhLcXZ2QWdtNmtvdDdqS2tV?=
 =?utf-8?B?aFFja1g5RitwV0p1V1FocjhWR0NlQ1NUckUwemlKdkpocXlxalBvVDdhQ3I4?=
 =?utf-8?B?aGw0RmFZU0pHdGluRmRmSVYyd1pZcUZFK3BjUnhHVTBrRzduRjAwUzFzbWFG?=
 =?utf-8?B?TTNaV2VBaHZpKzg5Zkcvb2RUQnRXTm5RYW9Mai9GL0lDOXRrWXBXYXdUZGJB?=
 =?utf-8?B?OFc2cTl4cHlLWFQ4QkVTOE5aMEU1dUlIY0FlUXUzOFRUQ2RDK2ZYNm0yOVls?=
 =?utf-8?B?V3gydnNKRFZocU93V3RoblBvRTlqeFg3OUFUUUNJSnVaUnRaMFlCWUZGRUNl?=
 =?utf-8?B?OHlxVzhYV1BPbFp3ck94MlBNVEwvUi9udzYrOTJwOXd1MTNXVmlIQXJRWngv?=
 =?utf-8?B?cndCZ2FqSXQyU1hpWDRZS3h2c2RjZFVMSFVQSFhzbllmSnBNN2dtNHZ4aU1O?=
 =?utf-8?B?ZkdScmNiWjY0b1VBR2lOamhDSXBZMUZod1NGVDNvM0pVYTVIczZQYzZoT2ow?=
 =?utf-8?B?NThxWnJNVkdUOXpHOWhYMkNBVFRHSHJBTVo5aVA5VTdORkxLR0hHZG9DRFdB?=
 =?utf-8?B?WmF2RjkzT3ppKzhJSXVSRDlpajF2SEVQNmd4R1h5MkdiakQ3dFIvWFZ1UlZ1?=
 =?utf-8?B?d1hsSFJNcmd5OHp1KzV0YmJHTXBHbGp5QW42N1g3d1c5WXhOZ01yekV6alFH?=
 =?utf-8?B?ZFBGa3hpeGp0dmlIVFk2Y2NkU05rZ1NaNUpvZW1Ca2FOWGF4NkZvM2F2UzZj?=
 =?utf-8?B?eis1VllWbWN3dEsxeFlZbDZJVEFjenh6RUwyU2JJWWlEWVhJaGFDNnJVWDBp?=
 =?utf-8?B?WWlGUjc0YXR5cklPK0pkdXZxU2h1dUkzSDFHRnhPaFdPTnJwaEtDdkp6aTFD?=
 =?utf-8?Q?LllH4KSE4pVLz9IA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a78171-7876-4103-9e3a-08de6980b131
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:17:38.5189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EfddNHmMLF82laoYJ/BBAZrALFrDYeUciCtrhZ4Ev4aCP8Dx2EcZLCt1grF0rCv6ZoJkesMMe+4dOzaRfoBhjc73ckyGA4r/YBIvpoW+4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7288
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

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> A few E610 MAC type checks were missing (verified using E610 datasheet).
>
> Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_bypass_api.h |  8 +-----
>   drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 29 ++++++++++++++--------
>   drivers/net/intel/ixgbe/ixgbe_fdir.c       |  8 +++---
>   drivers/net/intel/ixgbe/ixgbe_flow.c       |  3 ++-
>   drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 ++--
>   drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++++++----
>   6 files changed, 39 insertions(+), 28 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

