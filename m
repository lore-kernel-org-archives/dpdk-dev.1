Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C2C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:49:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF84340292;
	Mon, 16 Jun 2025 10:49:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1CADE4027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750063750; x=1781599750;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hJn/xnZAif4aR4/5ghf8vp5rTVdqj8v2l+x7SXL7wRE=;
 b=d6Mj1i8yOHSDQSNFeYrB2ZH72kLJa2EweRzqn6FZgt483cA1NiYPLXBx
 uv3f53ZpRUfaCUH1mvMyblXLxWJ37ylrX1SjnPoSEArrtz0zgd476d5VT
 wuYsr4i8wyziBw7PV1uJJwphDftS7JpIva2f8NowmWPqRDNEoibAGV6jo
 zQ3TCr546wXfsh4WUgaL0YSgzT7ayrvHdR6AQCwfUctGhnIb0MhsZu2GP
 4AP4v/GutMUDdDWlcTuSfv9f20Q8LaxCRiZ5bmKvdcWOBoZs4zKzjPe1w
 s4pj003+z8p4Lvx2rgm5e5VQR8IAat+K3S3D/ZlZEgPB/sW1KDmm3fSQp w==;
X-CSE-ConnectionGUID: 3eOXYzfQQ8iuE9BY/GwaHw==
X-CSE-MsgGUID: LukcvwkQSharb+3WpI8LNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="74730682"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="74730682"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:49:09 -0700
X-CSE-ConnectionGUID: 2uAe2rkiS6KHwDO1MGDyyA==
X-CSE-MsgGUID: kGmRHDEaQaOGtHauq5Bk0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="153563216"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:49:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:49:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 01:49:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5PEJV69SMDwzgwSpU5/DcmSx7jBB5klso2u5+EvmhJowCYwdtgUke9Fgq1DKZ2qqEP6wWec3+211VSsQmDxMOohrQuo8udB5srLhKxwILOWIin03y4FxnPYxM/KhvslLhpKkyuZLeT72UB+sPjSvS21EptkCiGDn2O/0R0HKZMRH3R+Y8m6QhAhhOw+GxMKabeoL9U5WLyDPLlxyTCBkDo/752MOog6ZuiAkuCqxByoYs5JrkWflWk87ReIvny2cyq77AEF7jk2og8VLJzd7dKbngrxz0GTapvNEl+faqwY8JB+L8yOmDoKIpjEi6M2S+uGO2hU/KDAwp4d6+Y8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJn/xnZAif4aR4/5ghf8vp5rTVdqj8v2l+x7SXL7wRE=;
 b=Eag7KqZtBwO5i1TQP/J9HYI5p1E1L42/4ZesSbJSPlHT6b5JGkQxWI0whizwSJOCORvSGSjmDzToogXez9qD/z5qFPKR3jwowIn4f4k/Fm8mORHX6C8ydvJxZt3861mc8NXTEzieDu7sxbGeB9Iwj95mUS68Cd2SnyVSf5j5U3sryynxqgSIYQWXVPdIxO3wkQescfCEhXDTS617iAV8HpxbxJIMuJe2E25uq9+sNfGAx9RMLQkksF/Yl/S4cssXGTL+KA/YxWwtyZcxAiuIfqPkxHZ8dx/1JCizi/zFrCdanB1V/HQjVyMXbhWhsJZEf9TrKUd2YVr+I1vIGMdESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 08:48:51 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 08:48:51 +0000
Message-ID: <a1a56cc7-dfb9-4264-80b4-a3ed9fc6f6d2@intel.com>
Date: Mon, 16 Jun 2025 09:48:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dpdk-dev v1] app/test-crypto-perf: remove unsupported test cases
 from perf json
To: Kai Ji <kai.ji@intel.com>, <dev@dpdk.org>
CC: <gakhil@marvell.com>
References: <20250613110001.350767-1-kai.ji@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20250613110001.350767-1-kai.ji@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::13) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SA1PR11MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ee65d2-0a5e-4069-aa1d-08ddacb29e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXF0K0NGalc2SnAvek9lNFM0cG1tNkZabGhndytCMm1wMTNITUIzNUFvd2Vw?=
 =?utf-8?B?RFR6MWc3T0YwaGIvbW1YazF0d0lBOW9WRWdYRWI3TzFLUWJzdDlwSU9GNVZq?=
 =?utf-8?B?TDVQQmQyYkFzd1dkYnRHRE1zVGNiQ2N5bEVKM3l2bFRDd0hnOHQ5cEpuMTNL?=
 =?utf-8?B?a1JJMHhreE92MC9INlpVRjVIT1FtOUQ1VHVwYW9NZW1vWGFYeDFxVFBNQ3ZS?=
 =?utf-8?B?RHNBbnIvODIzampnOWJzc0VIUmkzVnBZRDZsZG45YzArOWpoVGRZTGRoblQr?=
 =?utf-8?B?NzJWVFYrczl2MDV1Z1VtaCs5bVBtUXljall0My9Da2srQTZ6cE4vNGZwLzVG?=
 =?utf-8?B?OVZuNFpwT3JPbEh4RE1mb015dkFlY256K0tVc0h2SHd0RGRITWZVdVl0S1dP?=
 =?utf-8?B?WHVrWk1OcnFoVEdpOFdJSllOQy9HUHh2N3RIVnlGcjRudHVXQlNrMWNmclRQ?=
 =?utf-8?B?UHcrMmxTdGhwa3hIUlZKWDNhdEpGdUNRbjI3THh6TFBlWkNXUWFFcXNrTlU0?=
 =?utf-8?B?N0NTbzdCc2lZVG16UjJORURwbEtCWHRKbkVlR2ZvQktaRDc5R1d1RWdSOGtw?=
 =?utf-8?B?NEt1ZFhKRFlpQ2JMeXhWUHRMWnhCM0g5d1JWbzRyZ3VaRUZpcE9uK3QxMjNI?=
 =?utf-8?B?bkkwSm9mYmtCRVdtdXhpb3YyZk5rNmt2dnlYWGNwNmhSZGkvbjJScHUzcWp0?=
 =?utf-8?B?ZFhUWWNZVHlqTStEZlcvVTc2Y1VWYTVveGQ2NGljKzN0eStkV0c0SjFrTzBL?=
 =?utf-8?B?SDFlVGtWSWh6WXBHd0d4WnBUZ3l6YkU0RVNzeTZqNllmVkFFNlcwRTVxSlc2?=
 =?utf-8?B?WElzTUV5TEdwUzA0akhEUWI5Y2V5bS9RVTduZjhlSm1lQlRTZmhSdE14bHdF?=
 =?utf-8?B?bVVlSTRoL1A5L3hlTzkvQTBwVTRoeXRPSWMrOHZDS0x6alFPYnVOaG1IcDNt?=
 =?utf-8?B?ZXI2cmNzOUsxbDRMWCs3NnBRNWdreG1CSWZ2QjFlcC9NcGxkNUlMQWVNVXpO?=
 =?utf-8?B?V21PYzZHZFhQRXJlSDY0ZGkya1pEYUZYaTZKVUhlaHRzaGN2dms3QlZYVWlq?=
 =?utf-8?B?VmRIbHMrSDRhcnZuUFJHTWkwZlMxcnhXQ1VsSFFWWXpHc0JwbmJTa2JUOHhE?=
 =?utf-8?B?clRMK3Eyb1l5UG82K2FJMktCZ01rRlJCMHUwT0Z5WitSTTduMnF1ZlJCeW1R?=
 =?utf-8?B?eWRNeFJCTFBKYkNxNTJtZG9FQTBSVWlZd1pFR2hkMGFDS2NPMStlKzJGYzEv?=
 =?utf-8?B?Uno3MDFBcndpWU5FdU1iWjJOa2hsRlhmR2xqZFFGTzRYRVc1MXN0MlQ0TDFl?=
 =?utf-8?B?bjUvSXZyY2tvYWdsdGMvUUxuSHUvVUxybzF6bFdERE94VVEzM09kWk8zZWJE?=
 =?utf-8?B?cGdrbjc0VmdycFJlOUZjaElvRmxiQ0psWEk4dFlrSytxdXA0bDZWMVRtZGk1?=
 =?utf-8?B?U25INlhyUDEvOHJQeFFrNzhqZ1h0QVpGY09sRlZWZHRxZ0puRkdEZy82N1Fx?=
 =?utf-8?B?ajVYdWlmNlpxWXk2VjZZNlJwTWZGRXhUYzNhYlhLaVV3RkU5TFlYZXU2QzN5?=
 =?utf-8?B?ZjZBRWN4RDFXd0hpVHJXYTRZdVJNbkJJUVpsWTFBYVJsY2Q0dnBuNkxDUlAw?=
 =?utf-8?B?eHNubjJ5Rld3a29WTm8vRm1wUFdCM05xRzJlWlJZYldTVE80UHhRL0RXQUlh?=
 =?utf-8?B?S3dtVXRZV0Jtc2psVlo3NTdFZHlOMHY0TWxlRmE0M1BNb0dxeUxncHVsT05Z?=
 =?utf-8?B?RE9QQW45UU5pT1J4Y0JRZGdFbTZYQ3ZhblQybk1DSHRpempNYnJEWkt6VkUz?=
 =?utf-8?B?RDhyVXpsU3ZzRHEyVkF4cXVuQTdjZ0FiU2E3MExnVW5hNXJ6eWs5cTRKcUZ2?=
 =?utf-8?B?SUlwUFVtVm4wemhhK1JHeG96dWJoWDBaQjhyMWdpbGdRTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3A2YjRyUkF0QWwyLzlsckRiVExzTmgxeVN2SDcwNGlFUkVNUzBTdnV1dFIy?=
 =?utf-8?B?VmZVL0YzU1pDTGtFRHR2Y1d0cklrNWhOZVFRYk5mRzJETjlpUy9FMnBWS0lv?=
 =?utf-8?B?ZXRwb2J2aXZ4VFEyVGJERzVRQzdnSXZEeWg3bkJDalNULzBIZ1NJTjJVRTJn?=
 =?utf-8?B?T2Y4aTFLcVVxTWVCczRmODNORDdDdlphTGZPRUQxdGtRdDliY2hyUWhqUUtt?=
 =?utf-8?B?QlVDYnpSeFNTK2tKYmVxWFVGbEhGSXVyT1REM0RlMTF6TGgxenlhTTJ0YTEr?=
 =?utf-8?B?MkRQcWFLQnltNlh3S1dnWERwWU5QSmJOa0tZQmFTTGtCL1FqOUd4Yk5ZZ09p?=
 =?utf-8?B?N0o2TWp5Y1creWtnUXViZURLYnlQZFFKZ2crQUdCZmFoQjBYa09kc0d5Q2dk?=
 =?utf-8?B?ZjNoRUVnTVRUMXQ2eEE2dzBZeTlLbnkyRUhqZ2tSQWdkOVlKdXJubUpkYTVk?=
 =?utf-8?B?Y3JwUXNNQTErT0tZUDJvSXNRZ01rTG1vWVRIY3g0UndhV1U5c1Zab2hlR0J1?=
 =?utf-8?B?MEZibGZURllxb0FWN0lwRG8vMHEwVTZZSTZqTkwySVpCQkFuS0ZSWGNIaERG?=
 =?utf-8?B?Wm9oR0h2SCtMTUZUcmQ3Q2twUUVMb2tXKy93aCs5RUdGWkxPTVRpdkpmOWl3?=
 =?utf-8?B?SWFzbjh5Ty9NaU9HekRxWVZwRGc4aW1aVjcrNTJabGxNR25ZYWJaWXRDSGRy?=
 =?utf-8?B?aG1PQlpoMHZxekVIVVEwYmRDRmhxWXh4cURoVjFVWWR5Y1J4TmtKNlVacDha?=
 =?utf-8?B?VTJ5YnVJWTZVTXdUdVBKRFlKUWVET21JWEhRbXpUUmYrKzJiMlg1TUNpUFhM?=
 =?utf-8?B?RWE2cFBqbHRqMVE4cUtaZXBtUlFTOEhDRG5LcGJFWWZ4NTFDT2FYTzdIUHZ0?=
 =?utf-8?B?dkVJY25RU2tRN2tnaWVMc1RoUEhZaVhiQ1E5UmdZNE9GTmx1RHBwblVlc25K?=
 =?utf-8?B?MUREQm1aMkMzUmdvT2VvOFFrRDYxNE1pcjA3dmlBY3pKQUpDMjd6KzdqU1FD?=
 =?utf-8?B?cGZXVmR1bEFsWHlET1M0RTJielRMZU1XOTVjdFVWc2NObmZhVy9vOG45bDJm?=
 =?utf-8?B?UXBBZk5QUkIybkIza0N4VlhjZGVzMjJSV3JJS2tPWTBKN1BXelJ5R0hQMjM3?=
 =?utf-8?B?VndhOUNOSlFsc0ZYa1ljQ3lxTEhFdDRpVGtWVEdXbWVZWGNJTlE0b0NtbmVz?=
 =?utf-8?B?WnRFV3Bwd0NvNnFBUXdkWnZrNExQWGlXdXg0amJUcFl2dDI0Zm9jaWdlM09j?=
 =?utf-8?B?NGR4aU5HNzUxMVkrUGx0M1F3NkNqbUtrMTVROWZ0ZExkT1Z4NEFxWDIzNGlN?=
 =?utf-8?B?VmFqbXNiWVdCUVo4UEtJZHJuMFZLa0NEdnRsUGJXV0ZJMHhXMEMrWkNjd05n?=
 =?utf-8?B?RWdCWWdWYUJPR0FpcXhjVHRYZWZmTUI3RlRoRzdHK3Y0U2dIeStUbktSdWVj?=
 =?utf-8?B?eERSaURpVzVPa2Z0L0ZuYVJlbGtGRVBzL1YyZVpxd1FLcldJUVNDOWR5dDJY?=
 =?utf-8?B?UzJ6UEpyY2p5V0lSb21lRml6TjJscFVhaUh3ZlhiNzU2MXoxbVdIUDBoaVFV?=
 =?utf-8?B?My9DdnZwV3UyU3M5MGVKampIZExhUTROd3JhMXJqdVRTbG4wY1U5UzllNFZp?=
 =?utf-8?B?NjluclkzYkNUN0xvN1dZSThzMUFGVFdmSFlZMWdxMDRXWGd3WHNHQzkxSlhN?=
 =?utf-8?B?Nmk3WGRubWFRTnlYaWQ3ek1mZFF3cFIwQ21SanlsbEZMTkZ6WFJVZWcxRksy?=
 =?utf-8?B?MTNqL3lPRWZnOWlaWGI5dFhNcGpuODNKSkNnMEpKYkp2djVuMzZYVGpZUXFN?=
 =?utf-8?B?TVg5RWIwSTBsYVROQldMQ2I1NTF0aW5lVVNlUW1qRkxUWTVUcGZtcGtjVnRD?=
 =?utf-8?B?cktRK0NHemNadlV6ZG1ST0ExSktzZXlzWEVBUTJ2encvQVNMUk5MaEtZVm01?=
 =?utf-8?B?Tnd3cUtOclUxZDMxQlUyRDg0aFV2NjJLQkFFdzVjek9ZV0I0N0x2dHdkcFFG?=
 =?utf-8?B?ZzNuUjloNUJXVkI1bTlGZm11MDYybU15VjZNSGp1T3RLbytQRC8vR1lFZ2Nn?=
 =?utf-8?B?WERWZWxGT1lzMkMxYWptSEZUdFR0c25PSDZncVp6Kzd0ZXJRY2twUFFkQkF3?=
 =?utf-8?B?eTZsUVEybDJvRlZERk1FeUdXNGJYOCtHV3BKTlZoZnI4aDQ1S2NWMkQ5MU9G?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee65d2-0a5e-4069-aa1d-08ddacb29e20
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:48:51.7936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7BgMPy3IkK04jb6Ekfd5EnyMSeWdeZIqzZBqm9GhkNrnBKgcUsSCvLXLXgjJXuzmFfTGwN0vBlT6Jt4tFi4QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
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


On 13-Jun-25 12:00 PM, Kai Ji wrote:
> Remove all unsupported test cases in json files
>
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
