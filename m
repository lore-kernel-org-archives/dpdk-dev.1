Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A6C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC2044026C;
	Thu,  8 May 2025 13:28:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C24094026B
 for <dev@dpdk.org>; Thu,  8 May 2025 13:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746703736; x=1778239736;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=P22F1M6SLu+0OyLx0eALnbqjZBkAqBWqy4a39nq1zGY=;
 b=jTDPipRzbKlRvhEoEFfJ1MR38o3vJmQN9XdcFYbClncty5nlnDkvVRQw
 b10lHdmRT+KR0IvDuEEa5FWIgYVRbf1hqCDhw7grymeKp8J46O1WR32P3
 ZKB9tNJXA4E1Oi6WrpDLNFR3vuaAq3fVpE8YfSkaFE/zK/hXji3JDK3LT
 /rkL0WD7uZ93FyDqmg+TEusDvyjZX5IZghIA92CLfUjSsVmSyL79Se8Z+
 se+bGQVB5HhuWEjgPrbWMF1850iCFC45ZDQINjuf25ZDxbMJaJ+lMC3Pp
 ag5zYw0uqCHy3HeSa9hnMka1g383TMN5OALykyxIF+z5b2aukIl+P4/Dj w==;
X-CSE-ConnectionGUID: iv7udn1vRv2NHImDN5ndfg==
X-CSE-MsgGUID: OXJKTUmuSOKaSRW89YAEsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48628899"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48628899"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:28:54 -0700
X-CSE-ConnectionGUID: bt7oeRYKTCmKFDkL41AJNg==
X-CSE-MsgGUID: ZMyJhGRzR0u/U24FbVG1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="135971556"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:28:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:28:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:28:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMq6UUK2dJapwdmjNKt45jXBiRfxlx7rEChpndhUq5NY3QoK+nKJAZTzBkbEC709kCCbm8ESqNsphGCXVZSpZmjSUX4a/X1HwA5XDLILzMEHuhrEd22KPLcbFmylK5bhLPVrxcibUGQZsZ59JCY0nL3OOQm8Jd9iYt1oXURq0BROCo3agxg/aWo6iMOBtE3BQxd73ZCGQhW/Rm5OKASxv1y9ETLD2dzxK4lY0n29Tfn+FtIaNJQWbP9ddk+X1nI6hb4KaYE6WeqzTgQF9JU3NAzq8pZwuQiufcDzDDOctYTfaWlKKjet1P1JawsRSU3lbNxlOqdAvAJ83XROtkdZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K11ElPrBKhy7KQokaxQzPaX9s44GbA/cZbRwGnECr8=;
 b=oEUB3YiEwQsdqo2oNakjMVIg41PF2bcW3keyDVEuDneOTobkLD5e3BjIjpI0UbdqoAYMK+EzpOKfNb7KDYbcF0Gm6YuACgH2/9eAa1udEhM69ZXjR5XjRfwD5mho9LGeVjNDqZK2F3SouKYDTYS+++BthvbnxvpOyB8C8s3uYWoejV/4BkX8mcRkAFZzzmyFP7guFMvs66VJheij09JSNDuXro7s9HHUGhWJpE/Um83RhHXD7zupXqIWJ8LHlD9dqlWtWkfWIYByBN1T0QW9hQXw/ZT8hpt4oMc5TpHLeteVjEDWVvpeVTlcJO9PZtBd2AZDrdabkLlaayrl2KRf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 11:28:19 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:28:19 +0000
Message-ID: <f64241a3-eede-49f1-956f-62f5e3204c12@intel.com>
Date: Thu, 8 May 2025 13:28:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] bus/pci/bsd: Eliminate potential overflow
To: Jake Freeland <jfree@FreeBSD.org>, Chenbo Xia <chenbox@nvidia.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-4-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506174046.1136711-4-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR03CA0103.eurprd03.prod.outlook.com
 (2603:10a6:10:72::44) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 871839e4-bae2-42d9-7ef7-08dd8e236eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjJETG9UQVVrQ0dPenB1eWZzdm5ZSnkzMmZHcUlobklSN3pFL0FxL0lpS2dj?=
 =?utf-8?B?YkFtTmVoQTQwdEdlTnVYeU9wM2x6c2JmTUlzODVOZjM4a2lNQWNoVC8rM2ha?=
 =?utf-8?B?SGViSk1hdEdLRzBmeW5Kdm82aTkvMTQ0YlRYMEJRL3V4MXplcTllT0o2K2JB?=
 =?utf-8?B?WVl2ck9HVmNvbTZqdS93NUh2NURPaTJldmVaMTVrdmdTRlovVjVYOXR1SXFB?=
 =?utf-8?B?Z2tia0JMdGxsa015ZUlaLzNiOHQrTTZXQXFHVVB3enBnM3QzSko3U1hoWm1T?=
 =?utf-8?B?b0oxSzZ2d1haTWNwaGRRTTZkZWt0eGFqaTJlRlRCbzV3OGRkSGFnVDlrSnVS?=
 =?utf-8?B?SXZuTE1KaEhPb3B0cEpNU0NOejluU2h3NjNXSy9JVGxZMnEvNEcyMkZZQW9Y?=
 =?utf-8?B?MGdBcGpWOTQzSy94ZnZ1NXJWME9FNnF6OUtuZDlrdTREUnN6NUtKbzlUemZW?=
 =?utf-8?B?WFhRekQrOFUxUXBCMkdidmZuNWdvb2l1MmtGV05WM3RENndBeGd3c2hmV1Z4?=
 =?utf-8?B?YlB3NUF4d05aaS9rZVR6N0VkcUkybVkyZnNIREVLbjIxWmVKbkRTckYyYVFY?=
 =?utf-8?B?TXNQdDF6dzM1Wlk5SVNTblNjNXc0THBER1F4V1UySDdZQjNsVldCaU04ZmNw?=
 =?utf-8?B?ZXZRMXBPTW5ZTjUxakFUSUFKUUhKMzdGSFBmMVdqWWxUWVIvOHBQTFRqWlJw?=
 =?utf-8?B?elA0dSsyZ0I5eVBqSHdjK2ZUekN2dUtOTUMrVDNFRXpCYzl6RG1zMVZYUUJJ?=
 =?utf-8?B?SGs0ZzJsU3lldktJWFRielhndFRkbUhWZXpIYW1Bek13T1lRSTVzSk5RUzRB?=
 =?utf-8?B?ei9CSHZjQzBCVHo5VTNWVU1ybmtxd2cybm9oSXlGaFJFU1ovWUpiUVBqd3hB?=
 =?utf-8?B?bjJDdnRtZ3NKczNFWWZFYitKT3lqNitFY1FpY0dSMVo2OXZHNGhjRFYzVGFa?=
 =?utf-8?B?c01aVU1JdGhHdE1wUVRrWjlWeWZtWjdYbzR2cVZla0FNZ0RUcTRNSUFWVWQ0?=
 =?utf-8?B?NFRYQlVzQ0dnSFdwWDExSGdhcnJlbkJPVFJGb1lyaVRFYzZEN3AxcU1VeU9i?=
 =?utf-8?B?Y3M3dXZvb1Y0UkwwbWZCM0tDWWlEUThpWjJYeStNRWlGbFdZVnJiYVdMZGl4?=
 =?utf-8?B?aHRrK0Rqb0dldFd1TDQraEp1cGhjY1h4RExTYzlvQ0Rsa3JCejBqTSsxRmxZ?=
 =?utf-8?B?eExSVFRhV2FnVUFPVnR0ZXY3VGJmVFc1NGQvR1dzaHBjRXFTTGtVNi8zV1Ar?=
 =?utf-8?B?aHFVYUM2M3NzenFDR2RwR3ZraStaME00Mk1pS29lZVovWXFkUEN1NCt0R2xD?=
 =?utf-8?B?SDBHK0s1UlUyVlVLWFRUcHRUMDd6SERhRjFyWDVwTjJGMWtxTVZiRURuZ1ZC?=
 =?utf-8?B?WEYyckxTckYwWWk2dW1Ia3dtbUJGaDhidE41ZHNpb2UxMm1sSmhQbTV6bk01?=
 =?utf-8?B?N2p2WXZLMDRXN2tNWjBmTWYzYXZsU1QyNWgvWTlUdkRpT25mbXJpUXpRVElY?=
 =?utf-8?B?Z0kyZE1VZCsvcU93ZWZEdzNNajFUeTg0NnA3OFFkeGVXRXU0NmFCdjc5cnlD?=
 =?utf-8?B?K0plUmtHVzNIeVB2S0tKOFZRU292N01mRnVCK3NncHVWdjViaEhnZEoyQ0JK?=
 =?utf-8?B?OHBwd3lNdzFVK0FvdEc2VnB2MTdZUDl0TEliMGhMb0h2T2xUYmJFOUlFdWVY?=
 =?utf-8?B?dEYvaVlzWllsZFhza2h0ajRDRXJxQmhqd3oyUlUxdGdYMkFNR2tuUHg5WUlO?=
 =?utf-8?B?VVhNWFYyWllQSk5zbWdPbHRPMnpWdEgyS1hyN1VJcndZeWZuUWw5ZlV2MUtF?=
 =?utf-8?B?a2JCdWgwMnBXSG1TWmljeVc4aDN2VnRFaVFsOUQxYnBaVmlMRnp1SGxEN3ZF?=
 =?utf-8?B?T0d5M2JIb0w4VTN1dFdPM3gvOW9FMkNudnNtdys1SDVZMXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEVvbDc3emNXYXl6aVRtamNka0ZzUlhuYzN2dlJkOFFWWTYrTlU5NDNDdFJE?=
 =?utf-8?B?OU9hckZoVVJQRkloVmM3dSs0ZEFSaTRiS3VrR1Y5NjM0U3dUcDMrK1gyeWs4?=
 =?utf-8?B?SlgyazdVVk5vaUdXTVdoeC8zUC8yZlBCb3ZVcE1tQkhycTFJYThOVzUzZWVK?=
 =?utf-8?B?ek1udmM4WnFNelRRQWFYL0I2OU43VkQ2WG9JSGdRb25vZXZKbERVSEdDLzl4?=
 =?utf-8?B?ZXJDL0dmRzBObXY4RkRJQkUzVktOWFArVlJCWGl1RWVvdHJ1ZjlacG9yVHlY?=
 =?utf-8?B?WnAzR3lWeTV3dmtSd3lYZTBra3Qyb0Jpend0YmJSdEQ2RllBOEF3c3o5R3Uz?=
 =?utf-8?B?TklEaTZFQlh5MStwMWVRazRBWkczSXFUZ2FOVld3NG13TStMMDBBd0lSemJC?=
 =?utf-8?B?R3E0YlJKOGMxbytqK3o0Ky9XSE0vcGplWVllWkYrRnY1YUxQNnRpQWw4Vkwv?=
 =?utf-8?B?bjBoS2RNVVVtVi8vRjZvMjVCOWk3a05zeGl2MVpXZ28zV09TeFcxb1dQOWJW?=
 =?utf-8?B?WU1leVRBQ1E2NjB3YlVJeW1wRFgvaEVZNThsY01HSWU0UDl1NEdyQmM4U2NE?=
 =?utf-8?B?T2owZGpnaCswQzZrd1N0dTRVSW9Ibndxa2RPdEtpVmNhWWdJL0dHSWhqNE4r?=
 =?utf-8?B?Y1g4U2U3WDdtM3Jzd3BXTzU0U1VKRFcvUTh0VlVMSDRmK2lvWUhxSGVHbEo0?=
 =?utf-8?B?OTN0RHIxSUI2aXI2bEdqYy91NEdEbXYraEFhM05MQkdxckpQTFBkWU5aeG15?=
 =?utf-8?B?VXIyWUFsTVVuOUdib0ZoWmdzejk2ZUtLK2RPV1plWFZlR3NVTU1nU29ZbDZC?=
 =?utf-8?B?Z0g0T2I5RlU5bDVUd0JkWDZQVEJrcDU3RE9ReHJReFBVZGQzWU55MXJ6M0F3?=
 =?utf-8?B?Ukt5Tmk2bWRRS0ZOSUN0cTQ4emlodkNLd3RoeGFwTFdBM3h5R0JKY2dFZ00r?=
 =?utf-8?B?YzRRMEhES1BkSFBLcEY1S21ZdmMyLzdoVnJxcHhvbCtFM2tQWjRDdkJWZjRI?=
 =?utf-8?B?blZabERoc1hxMDdkdUZCOSszUjZaL084VXZ1cUNZd0VPN3J1QzY0bnNvMjll?=
 =?utf-8?B?VGhjSUd6WTZNdXpURmN5M0ExMGdDOXpoRUlxMHlQeGx6eVpZY1k1dVphS0VO?=
 =?utf-8?B?UzhUamxUTGlEOGRzWFRWOElnMm91Z0RoaGFjS3pzeWZ1T1IzRjFCZHZIMmRK?=
 =?utf-8?B?RmwzRFphQkdGVUZPRDFNTDJkZ0psSXJFQzgrTGk5SjI3WEJ3SzJhdG12YVVl?=
 =?utf-8?B?VCtOZERjNWNOZVkzbktBOUk2ZUNOc3h1TnpRTVVzZlo2ZFVVeW5mck94eU04?=
 =?utf-8?B?L0xXbnl6UEhUQStXd21HcjFVM09TdzBvRHdmOVRGdnpXNUNEd0dDQk1oaklI?=
 =?utf-8?B?M2NnOTA5eEIxYTJZbDNCZTdYZlBvb01uYjhweXQyV0s0U3lxY0VjdTNFTUNW?=
 =?utf-8?B?ZnFKRU9Mb2poa3U2MExSWjE2SlpBQTNDYXNSLzJKVmRTVnZ5VTFPZEFhM0Y5?=
 =?utf-8?B?VjJISmZxNGdiYXcvM3FMcjF2ZXMxeDJ2blhnNTlyb3JnWUhzNU1MRVpiN2tE?=
 =?utf-8?B?Um12em5WakU1UWlTNGxSOC9UMWZlc2l4YjN4TitnNWMvQ3FpRHFZVkFtZW1r?=
 =?utf-8?B?UUVJQktrTXBpdklDbTdneldTNDBOalZYN3ZNZmFBTmgzd05VYy9tOHM5SVN4?=
 =?utf-8?B?Z1g1N3IvVnNUcUFKR0tTSWZ2WnJVWFM1R1pYUVpuU2ZTenF2RnpGWmJNL2Jj?=
 =?utf-8?B?VnVyWjcydkxTenA0MkU0MDl1SS9WVUJLd3RheGc5UWRzckRtTVNCang4UzlT?=
 =?utf-8?B?T0VBS012MGgrZHhHd1JodFpSd25jTjBvcUtJZzBsaE41cTQ1dlpwUTEzdFVK?=
 =?utf-8?B?NkI5RDdKcjdiQkZlUFZnV2Yyekp6SjJrRjlraER0NTYxdndtYzJDcXlsTVAr?=
 =?utf-8?B?cWNiOWM1WnF2d1hBTElvV2NhUTd0UDFrbDA0Umgra0pEa25LNFBVU3l5c0Vq?=
 =?utf-8?B?RnBrbGUvNHJoL3dKQi85YzJhZHB1a1RjSG9sazdWZS9QSGtPL2JtQnVPTTFB?=
 =?utf-8?B?UGh3WldjUElyOGQxSFJyRkNxdnVTYUFrOGIvQ3pEWFJSNk83dFVWYnNwQTRq?=
 =?utf-8?B?VytrcFpPRUpzM0RKcndkcnV2anArWkZ2SjAzcWJmRmVWcXYrTjNJTFlpMXJG?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 871839e4-bae2-42d9-7ef7-08dd8e236eba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:28:19.0326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrM4IpiU/LpRM3Mwk0iHwF3DT8XA5yvSJUgLbVW77NFoayMLzpxxERHeN57xVA9Vlai29ZTg9HXMGMdONCrayVNZ3MyqZIIB9Uu1Paun3Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
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

On 5/6/2025 7:40 PM, Jake Freeland wrote:
> When calling rte_pci_write_config(), use memcpy(3) to copy @len bytes
> of @buf into local memory instead of casting it to a uint32_t pointer
> and dereferencing it. This prevents us from reading data outside of
> @buf in the case that @buf has a length less than 32 bits.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
