Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D56E6817D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2199402AC;
	Tue, 17 Feb 2026 13:50:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 676E4400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771332651; x=1802868651;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DY8Iwd1Uxmioa2mEKvOzCZlXBZH1uO7c40AYdVxMYJA=;
 b=in2dg29pOUBzLkEx8ocygz7KhFkM0kq8ScX/jucT3XUX/DvoN50qLsZc
 fL+RsPW/t9tYXi52TfW9calnRUl9+5sUWRNpeyAkU5lJ2zsGCabCxibjQ
 yKOl3l0IhA4vZiLiw2nyUCX0NDrxoBvPz7uGwF/aU0EEuB4m+ynO9PWkf
 Np3t5SxxR4J81yJeQ5jIX0wPx0MAjjKYYBfAW2Lv+C5QHHENMVUNO6fbn
 c3o5TW0hl9ANtZFKJ0HVxJvHcFuPpB83KJmfBm3MrSXtDV+43G5bbpd9b
 AiCeImF2Ns73arZD65Fwd3NBrq2o6K0x480l5q7NPjDsQjijY/emcLooS A==;
X-CSE-ConnectionGUID: uzvWemm3R6mqnJf6ybYKmg==
X-CSE-MsgGUID: jSATD9JwQvKVid3hev3rFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72306040"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72306040"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:50:49 -0800
X-CSE-ConnectionGUID: 2fdhqVmnTxqukq6lkhgGZQ==
X-CSE-MsgGUID: 3b7Ynfs4SO2eEeMvpOMfJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="244471508"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:50:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:50:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 04:50:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSVMP55hp5VcNLaD1CBBK/djjeLFyb5REykc8T5drTJFZMse/yAPvTKh8/wZe7GPKh7ooNPbvcdxjayGVOslpD1W+o2LjMOQuu9MO8doAuL6I0g6OAeHKcTOXg+Bp9ahPYsR1bqMteKeT4ikfgmKH6BpdOkI7AdPBmf3nioXirYZEmLPz3zOR57D5QkLkAP02m16kdxDUb+5tU5PuTm3smIP/vC8JBpkUSi9z181/pN14DPbtzCnEyORmuvSyDZDeNJlFRq9OAxHtW15DRMdB3X1XdWQQwhsHifisa2j1K9imCADFGMEp0MkiUhxLtGvSB6E4WxUG2yCCUdTi+3nCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFaEIHXgVTjpLSLj+ZtKLis0QKnxZQsUWGxz/5rmyBY=;
 b=ii3hz8QhUXhEqkluH67UJyc1T2sOh2qBBOoDPRv+45kg3S/Tlw8FMVkhLNvX8+e+qbsVAfh5GuAx9k36+lPHtlsPvt1XVzX5SW8e0z7MS3A/OG0mDVqfGRtl+90XNod2Q6WI+AMugEoo+NCAxtfvK5zYdwkJyNwLazdJGCIWjgwxadBUkWVMR15TxHOtI+UysvVjgh8REa4IC1AbwYE4wnZJV1Vdh4vro7aHH5+L5El80Vu9AKQgls+Tf/nrMlbtaW/cgSqhefl4THQA98JxYPT2iwMUgbq6ChShGU+eIlBfF3BFMseXeS4r+/VNyfee5pVrnVu+dE1aDsFfxyO+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Tue, 17 Feb 2026 12:50:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 12:50:41 +0000
Message-ID: <d4d45144-01ec-4c6f-86d1-1ce65930e06d@intel.com>
Date: Tue, 17 Feb 2026 13:50:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
 <aZNMy_1oOKYn-AZ2@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNMy_1oOKYn-AZ2@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::25) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e936421-e82b-41d8-44d4-08de6e232868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWRDa0hUNEdhbWFQOFI2QjFGdVJaa0R6ZWtSVG9hWExyUTRPS0F3d2MzSkR6?=
 =?utf-8?B?RGl4MEdQR3N5NE5IMUJWcjBnK1J4M0lycXQ4R0tLci9VVER0YWluZWJneUtm?=
 =?utf-8?B?Qi9tUFFEcnRpZVhFU1dnUGd2aElhQW9BbnViQklMN2NZR3ZvOW1pTVdKdkhI?=
 =?utf-8?B?ZUVMZUJXYU9vQlYwK09nczBtTEhSY1Q2UjVFYkdQdHlzZ1F3cU1XZ24wWnkv?=
 =?utf-8?B?Rk9XK0E0N2JyR0ZmdFMzRmY0a2dobHhXSVpUL2U0cGJ5bnVWM0xSNjB5dWMz?=
 =?utf-8?B?V1ZXbGNGQnlOamFjd2txaFNSUFdMaE9HTWxNVWNSTjJrS255L3RCdVIzS3pJ?=
 =?utf-8?B?K1plbEx2Y2dIVXM4Y25oekNoWm1Gbnh0Zm01Ty9JVVpOYU1xemJ4SHY0NENG?=
 =?utf-8?B?TzRIQ2Zwa0dqZnZ6RmpiRG0zUmt1Vm1oWUZoTjZML1M2dlZKamszZnVZTTlB?=
 =?utf-8?B?Wk1lTXREcEpoYWtsY3JScnk1NGcrZ01DdDFpbXVycEd6WU94eGQyM09VS05l?=
 =?utf-8?B?NHdVWGlIVTJGcXhkTjFBWHhQOTJLNUhCTmY0UkdSOCsxYWg3NEJJMjhaa2pw?=
 =?utf-8?B?ZlRvYk15TlNiaDkxd0ZjejArbjNDMC85c0g4RUVPR0pKMi9SRXJDRnFOalNr?=
 =?utf-8?B?Ti9jOXpiMjhoMlM0ajRIOEU3elh6RzlVYjFEUUxSb2Y1WXh4UGZCN1ZtTTJv?=
 =?utf-8?B?REt6TnJtMzVEaFQ3WlEvYXRDUzB6UjdRdUxDeUQ2V1NSRXRqSkdwZ1gwaWNx?=
 =?utf-8?B?L3BvV3BHaUlHV2tlaVY0RkFkbEFCdUVmQWZrcWpDSUQrRnNvMTk1SzJqV3hK?=
 =?utf-8?B?TFN3VXB6c0NZRWdyeFZ5dXhvK0VmSW9Id3ZlTlBPcEpQbEFIUzRrSm9wVG5J?=
 =?utf-8?B?OW1ybE9DVDVweHhzSW1UNWI4OHFrK214cjVkRFZOb1U2QTl6US9NS0FOemVm?=
 =?utf-8?B?TTNvRHlOdHIrRUdjUlZyb2hnaE9wbUloeExCWCtsam1TVitRWWdxaEhrVFht?=
 =?utf-8?B?aGJPbEhiaDJIUzlLMkdHQUhSSzJHU05kRkxQUk5tOVZXWHVQSDA5RWRIVVhR?=
 =?utf-8?B?OE1DT2VJUklwZkdaZWZJYnNnV2RIQkxjd2xPYjZQYW5PY0tFb3hQNjIvVXdR?=
 =?utf-8?B?bDFITnZudHpKVk5UeVBRV21WSzYvY0ZpdzFrVTFCdG1NTTYvR0s2TEtMWHNE?=
 =?utf-8?B?Z1dGUnhMbzhRNnd4Q200V2xmQ3ZGeG1aTDl3QVJXTGI0QTM3WmZINTkvMjZJ?=
 =?utf-8?B?bkxJRFA1dTVVT3pKVnNNNnpjdktoSno2MWlxQStJWHEvTXJlREt4NWxPRUY5?=
 =?utf-8?B?QWwyUi9zRlFDVU1Eb295QXhoWWV2Rk9zODBOVnJiTmQxdDdaWnJId2t3WCti?=
 =?utf-8?B?aWtESW1ieVM2di8xN0ZZUzJyOUdsejVXWmJNdmtCN2tjQi9SK0xiaFltUW5Y?=
 =?utf-8?B?WEQwR2hCVm9scDlodVZkdzZDM2t4V2Z2aHBJVFJyZjdqTVhvYWkxQWZGN3lS?=
 =?utf-8?B?bXU5NGVWZG13TEMrZHdyeXUxZ3JROG9jNjNDY0lWS25XM2FYV2FYdEFCUEQv?=
 =?utf-8?B?OEJhejd4TXVMUGZLRGxhQzkwdFVHVHlHSXduY2lpK2p6Q3dzdWxWRTlaeFQ3?=
 =?utf-8?B?VzIydjlJbjhpR0Yzc0xtdVBDcVM0NUFYNGphMks2RE9GKzh5cU8zV2ZZblNj?=
 =?utf-8?B?UjYwTU9TWWV3WUN4NlhXdDd1OVp5N2trelVTbUhBL0VXdkNlM2o4Qk5vTDRM?=
 =?utf-8?B?ZHk2dC9wQVhMNmYyODZZV2FSVUZmWEdaNldMRVNneGEyS3JHczJhRkFKS1Vs?=
 =?utf-8?B?cWdxYzZiaFp6UGlITGFlQ2MvTTNKZUY2elN2VnkzeHFNUHZNemwvTGlJZ3ZY?=
 =?utf-8?B?TWZOU2pvQTB5ZVRmMENFdXFmSkRDZmRObHhyaXZ0aTN0alBZdjcwU3VnOVl5?=
 =?utf-8?B?MFM2SjNOWFBVZWczYy9RQWxSaExnOWR1TlBZeC9YK0lQNTlQeE5oSnFFam54?=
 =?utf-8?B?V01GanhxTXdIMHhoNSt1K2JSNi9mWnBzT01MallJUkxzekpoNXNBbmtyTUdU?=
 =?utf-8?B?VzRKeVJNN0t6Z3Z1a25pbEdpL3BOL0NRYk9ueXRlV1lYUEdRV2Fud1MzQW1o?=
 =?utf-8?Q?GPRo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUYzY29XOWFsN2ExMWtmRmpFVTVDcFM4WXBSUU9VOWRwWGVmNVBoMjNsY1Er?=
 =?utf-8?B?aUp1WEVOUUVkc0ozbi8vaWhRcG1oR1hKcjNXNEFiTXZlOXcySlIzbTRwOFNC?=
 =?utf-8?B?alF1V0lIUmNHcFZOcCtxRHpVRGNBeGhKb2hBRHdWTkRCT2hqdDNMT0thMnkv?=
 =?utf-8?B?YzhQa1NiaVJnRW1WWUJObWFJRExVTTJwbWVnUFR5cHpSMXU1RnNOYTB0ZUJE?=
 =?utf-8?B?WVpEbGdxdTRNenMyZjNodjc5T29pbDF0T3VOTjVpTy9MRFF1T21qc21KYWdm?=
 =?utf-8?B?bjZUUVNnQkZLSW1VckdKKzNLU2RyY0JtMlFMcmZzaUZrUDYyUDNOY1FnVXRj?=
 =?utf-8?B?MHRSZ3A4UVJQV1Y1SlZWRkJtZGxnVWdNbHZ6VklrNzdWcFRWMXNRbnVINGpL?=
 =?utf-8?B?bUZyL2lKV0NCbTZZRUptbHRFOFdmRlkvMlBqWW1uZEdLRDIxNk42NmltNnVZ?=
 =?utf-8?B?SWdUZC90V0VOYnNPQUdtRlB1Y2VPelBsdk1ReUJYdVpyZDVseUZFQVJ1RGwr?=
 =?utf-8?B?YmpJZ0dQWWVVcnhxeGVFeEtOaHRESnZxb3lLSVdvTmE4bSs0WVBsOWhZMGt1?=
 =?utf-8?B?bkRMSXQ0UTJIUTZLUWRNMFhKRXptZ2swREdndms1ME9SQUhjTXk3emJkZ2E3?=
 =?utf-8?B?TU1sS2drd0R2WGpjSXIzeVNyeWpTSmdXYlNTQUd4QmYrbkxpY0txUHVKK3d6?=
 =?utf-8?B?Vlg4TUZJZ04rWjRrd25aZis1ZnMwZmx1WTcxZ09Cb1lvRlUrUlc5djRKR3NV?=
 =?utf-8?B?Y05YaDQ3ckY3dFVVOTVrM1Rtd3NZOVA5dzJTSHpnL2sxOFVmTWR5S1Fyd1Bj?=
 =?utf-8?B?NzdkYjFoUkdyTU5CMnJSVU5vTks0ZUJYZHZLLy81NVMxaWovbHBJaDNodEhy?=
 =?utf-8?B?YitNeDNDSjhkNVIyQ2Z0eVpiS1cxRTRCVVpJZnFiSlgrNWNRTGtGbWpoNitu?=
 =?utf-8?B?ZlNDOVRKUXJHK2hNMHFXYWxCSG03cnV5ZGJDaFgrUXBwcDdISE0rSDlCSURD?=
 =?utf-8?B?U05LS3JOOE9QbE16Z3VxVmtoVU5MeGlrOVRianpLSnJodDVuNlhHcjI2bEt2?=
 =?utf-8?B?bTZ0Z25XaUVVYU9jTVhITUxWT2czQlRSREZZNjJKN0ZOekk1UTAwSU9BdlpH?=
 =?utf-8?B?bzNOYnBHQ0JMOVoraEkvb2xlaTdSbTZZUmlvc2VONGZpVUFtcE9xWVpRdy95?=
 =?utf-8?B?OTliQXFtdmUyMTNicyt1aEZCWk9KKzYrNkt2TDRpNTNTUW9CNHlZclJSdkF1?=
 =?utf-8?B?MUY0VnNxdXZxeXZjZ3NvRHp6OTQybXRGQzlhTGZPRmk4MnM5RTkxcHFFcXBE?=
 =?utf-8?B?TXlWeDh5enhxNDFHcCtUOWtQbzRHOUd3WTh5RjNjMHVjZ0g4VGZXcVVEdUF3?=
 =?utf-8?B?cHducVliK05SMFVWdzBiY0dLS1dVT0xxc1kvZFFnOXJhUnFoSStSVUhWaEcr?=
 =?utf-8?B?TUdPczRpRFlndWxmUFVUWnJaTEFGSlVNVTZ3T3NtTGpMdnc0aHhjbmlLb3Qw?=
 =?utf-8?B?OVc0MVpBWUxBMnVKdlRuOERyKzNSQ2tTdSs2ZU54TWRBdEk4TTVNand1OUtH?=
 =?utf-8?B?ZG1IYUhGWXpmQUVPU3ZIbzVHZGxMYXVtQklER2ZyRVhOWHV4Ry9SQWtDc1VR?=
 =?utf-8?B?VGQ4dUxoTk0zRTg5SGF1Q0lUVHp1TlRMUW1NdjR6eUpiUGx3WTh1K1dvcGpz?=
 =?utf-8?B?WlprV3h5cjkyMlpneGR5U1lwWUxsQVZyVUFGWG5yQmFaN1ZzZnFneHpFT1Vy?=
 =?utf-8?B?TFV4S1orYWVVb2UxejNSUHJoVjFpNUZpMXFBQmZNSEdSTHhDZlhZRis3Sk02?=
 =?utf-8?B?TkpoMVpCMWR0b2lES3dSWFFaNmJ4dDVOM21vcEdTb3RHa2R5V1huUGwrNmVx?=
 =?utf-8?B?ZVc1V09ZRi83RUMzUUV4MWU4L0dsUDlxR2dhZjBnWC9JQk03UFV4YmYvTHpp?=
 =?utf-8?B?V1UzYzZwcXZVNk51ZHVyTEFWdjgwZW83cTRIY3JKeXhwY3QvODRKdVdzNXFE?=
 =?utf-8?B?M3B2anhUTXpWdEpRYlgxZHArNmU3VDBoTWJWWnVVL2hCdWx1bEN5WS85U2RR?=
 =?utf-8?B?SnJmY2d5QThTQzEyWkJWMGlaYlpKMVAzSHEvUVBoaEVaRnQzcDlydFVQY1ZB?=
 =?utf-8?B?aHVuSGFoYnRNbGFtY2xLdkFGZzRiZGFDcUUyU1VHSDVjTFVwRTZvMWhad25C?=
 =?utf-8?B?bU0zUk1qVXJ5WTY4N1VYMFNucFFuanlCWElnV1ZHSnBEZHZoVi9hRTVQVnAr?=
 =?utf-8?B?eVlWZHU3ODVrcStrMFV4RXRYWkxJSGlyZDNEdFdZSk9zZStHL09JK1VycmpX?=
 =?utf-8?B?Vk5BQUtGZzY1NDlRYlV1ODNkNHBIM2hJTGZ4SitlTmNDYnM0SkVFeVRHdERK?=
 =?utf-8?Q?e580b9G/v+6gHf3c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e936421-e82b-41d8-44d4-08de6e232868
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 12:50:41.5664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8SlfbiBYiQK1jITLWj36JzfYLC2gznwA2sCdDVZDL6qn0pGuzuNO3lpt4klAKBgGagUE0A20U/u8AGXzopFehnrgQ/7j+pUnvDiqGuSDQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
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

On 2/16/2026 5:58 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:12AM +0000, Anatoly Burakov wrote:
>> The macros used were not informative and did not add any value beyond code
>> golf, so remove them and make MAC type checks explicit.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
>>   drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
>>   2 files changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
>> index 5dbd659941..7dc02a472b 100644
>> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
>> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
>> @@ -137,18 +137,6 @@
>>   #define IXGBE_MAX_FDIR_FILTER_NUM       (1024 * 32)
>>   #define IXGBE_MAX_L2_TN_FILTER_NUM      128
>>   
>> -#define MAC_TYPE_FILTER_SUP_EXT(type)    do {\
>> -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540)\
>> -		return -ENOTSUP;\
>> -} while (0)
>> -
>> -#define MAC_TYPE_FILTER_SUP(type)    do {\
>> -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
>> -		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
>> -		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
>> -		return -ENOTSUP;\
>> -} while (0)
>> -
> 
> Ack for removing the former. For the latter, since the list is longer and
> the code is used twice, I'd be tempted to convert to an inline function
> taking in struct hw and returning type bool. WDYT?
> 

I don't want to use a macro/inline function just to save on code, it has 
to have some semantic meaning. Do you have any suggestions on what it is 
that we'd be checking in these cases?

-- 
Thanks,
Anatoly
