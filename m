Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF028C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B6204066F;
	Fri, 28 Mar 2025 14:08:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9AAE64065D;
 Fri, 28 Mar 2025 14:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743167301; x=1774703301;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SFDJncuXrN38lZlvOTG8W8hhwIJleAaYIVUJZNnvgVQ=;
 b=eNA06GWb3jknbo9mi44etOd7STZ/7IjvSuqx99dFEJJR754BHwIkS+a/
 v6lsvRscPDyUKhDuLhB2NsnD7KJ0FEZX09YVZWdBY+rrN8lLGvJeWN8EX
 I4+BRvpGlPTpy18s/G2vQa4fcXFqDIObvnK02+ERN9Zgi3dfeLJsmA5Fu
 gtE5d1xBSsazNAQ3VZ1Lu9pjvZSGth/77GnKbnMFXGU5yokJJY4u/fSgC
 uxqGOwnWsT8Ep6J+UeUKtUQmqvGo7mT8YyzzF9OZ9cVSdCQTow/MoeGFN
 lHleVU04n6YzW1UADotXKzYPDX7OjL2bsK70YFVFeMT58oRjSjpDelrvx w==;
X-CSE-ConnectionGUID: bbZ07EPyQzCwWYeOFh8N8Q==
X-CSE-MsgGUID: y1Fd0ZMDSB+X4O1kxAOGUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55174298"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="55174298"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:08:20 -0700
X-CSE-ConnectionGUID: ivV8JZZ9Rca4oHNIyHDXMw==
X-CSE-MsgGUID: gdluCtWtSgi0saedGswvEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130147506"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:08:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Mar 2025 06:08:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Mar 2025 06:08:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO5TDhaWurWaiIyhsf3H/TGvdriXOcnld/4MhQqVPh+cm3Y8tXMmoIVKKO745YupPpA29gNoiM2YvIyAYD3eqzXqdYok2vzwuE6uAsE3YVauotk/SuMpBoUSm7DNuQRof/BkXMjYmyiBw9LFF6YlN7t/Liu1mOdHR4QNKn0i1cnMmjJVoxFIZ731syFudnaOSWwZxqGCylT85mm7nUACfPPY7gPGPVTlNHhanXnn95tSJIOQHAlqo024BrFiGnNjc7RtIKgX0jqi8PqJpXoXOsWCfUjmI3kKLw8k8NA5/+wOye+1B5sqGOW3az9N/Y/bH2KOC5vx3jTaq4uAVtwxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEQzgRH6ms5ix6Auyz0DdFLI+NUQOMmxfc8v/wbE+zM=;
 b=XI8h7QVRUNYkKKnyzgwREvmgPuWB+KFTjDW18f0CWpyjcmB0VewctJNbBBbBH0+oXhJqrExr16xmYAmj8alWNHl/zmrWz/GtBDXIWZF7Ky/t6DeaYFWEcvXMe8lJbZiGApkGGTz40751hpTHHSzSfOqcI6iglpPIhPyVDv+qwqW/iWa1eyu3w8Eqrhzz0iIg8JbnKBlX1+B7Lgpmw3RshNFVeKLc9r3Ak+sYYEUm91rMho5h0Cr+kXG9oZRBddKAdBnRg51xyWS+kk2+w6Z7bjFYU9s8eDm0y8C7d2KyrHIparjcsxOj0ZCDPh+ETY8elZBopDnzwRbgS2pQC4tbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 13:08:16 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:08:16 +0000
Message-ID: <910c55bb-562d-4da9-9b4c-32036cf54aaf@intel.com>
Date: Fri, 28 Mar 2025 14:08:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] net/i40e/base: fix compiler warnings
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-8-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-8-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 080660f3-a502-438f-6ae5-08dd6df99a3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGx5MzVjaENOdkErTnRnVFk3T1BhR0xjU3NGNGFJNG10V050cVNwZ1UvZVVu?=
 =?utf-8?B?R1A1QVcrSG9Mb1ZybHF1dGsvVklQTnVCOFd3WjBxc2JUbzgxVTJ3UnZ0N2ll?=
 =?utf-8?B?aldYWTdURzY2S084ZVJZT2p0N3U5NFg4YVZYN2V3NEpPMFdJT296Q2tEN0NF?=
 =?utf-8?B?dEpjQUtNcHlNbHQ0eERUWEV4S1FaSTJTbU5yTXIxMzlORUFYYlQzRGtGRUNR?=
 =?utf-8?B?cWUxZUgrY0pieVJaL3p0MzNqUzdST0Q5dk9LTGVMRm43L1RMeGUrSmhJbGE1?=
 =?utf-8?B?TWhtR2NUb0MwaEd4dXlMMXJ6TkhUd3NwUklXQ2loMTBoazRnU0E2QVRiUjY2?=
 =?utf-8?B?djhFUFFScFVyZlhXOWZuenFWUEYrQ3R3QktaN0VTbExpMW9XR3MwQThDNUh6?=
 =?utf-8?B?TEEzQ0JISXBmYnVsZGloUXRDVDhjWDZIV08zQlpLeUw0ZW5Mcm1tOEVTVDhz?=
 =?utf-8?B?bmhHdkZJd0FZRUkvT21XNXoySHBYMnR6ZldLTE8wVWtTb2E0TEtZbXV2aFJ2?=
 =?utf-8?B?cjRrcGpTR3g0OVgvbkxoTFlnM3AxT1hhbkIvT1RlTFRXK0RCbVRtZ2RPNXA5?=
 =?utf-8?B?ZFZaS1l6REkrTFNTMm1XK3J0NTQxOWk2WGptS084cng3UER6WDhaTjB5Nkp4?=
 =?utf-8?B?dFZRTW53WnczRXhhSkNxSFZETXVLcE1xcEwybzI3cFpCQkcwMklQd3lyaTlV?=
 =?utf-8?B?TTNpZnFocnNpWE1RZ3k0Z2pxdzF1U2FOMWN5bHVoNWlINDJtYzBsdVdXOFJW?=
 =?utf-8?B?bUl6TXN2Vm4rQWV2RTV0NHJBMjV1TkFmYzFkWnBYZ1J0WnUyR0RxQi9XRTlL?=
 =?utf-8?B?N1hsNS8yQmJvcXpuNjFKV3BZblF5TU9zQ0prYXZwLzNUcDV5NzdvdUNnZWJo?=
 =?utf-8?B?Y0RGV0cyWUJoUFNNaVQrZXZvNldhOVZRZkVCZnc0Uk5Wc1JyYzF6SGw5Q3Bk?=
 =?utf-8?B?YlBaUUdFTTdteFRLNENaUE93dHYwUmpuK0cyZWFRajlzVlI2YXR5Z2U4bmNw?=
 =?utf-8?B?Y1NpVTl4VDZoZmM5SDFzVlREaFhnYWVmcjBqZVRoOWRtYWQyaG05U2xMeDZU?=
 =?utf-8?B?K3JtMjdyaWswNFpkcFk4U29MdXZlRUtvZGpyWGE3TGIxRlhtOHZiNVBnS1Jm?=
 =?utf-8?B?WHhUQWlGaVR5eTUzaEs0c0E1dVZaOE51Zzg5cG9rV1JrbmNxbVZXT01MRUdS?=
 =?utf-8?B?dkx1ZTBCRzRDbS93WDNiTU81aXpFMnV0eFVNOTZLNUR2RElZOUZGTXBCeURW?=
 =?utf-8?B?QUtSVHV3bjM5QnIxN1FFeHJQSkVIVHRTTWZNZ0tIblV6cVhSS0IwUHE0TkZL?=
 =?utf-8?B?QXRrNHRNaE5pVnR3aWhiT1NlUnc3c3JpYi9aRWErcFdmQ1dxaHdJRzFESFh1?=
 =?utf-8?B?VkJVUTNnVlVnR3FiSEYxcjRxeFpYSmRIczlYZEZpbmNEaFdnT2JEUzlWbmNY?=
 =?utf-8?B?eENpN2ZwcnZOU1l2NW9pdGZNOEhoRjhDaUI4OG8zTFJTVUpLc3UyM1JUQjFB?=
 =?utf-8?B?ZHhSd01LQzR6dUVudUFJMm5JOFRQOVZ0V2NvaE9UQ1dYL2t4dzZWQnlQWkZp?=
 =?utf-8?B?UnhLdVZpNVRKY1daSXhiaXlNVFdOWWd5WmppQklGUmZpQmdIb3oyZjI1MkVU?=
 =?utf-8?B?Ulp6dEVuaUZZbGZ6aVNPUll1ZEJLZUZrRDNXZFpody80Wkx1RnNzMnhFSll6?=
 =?utf-8?B?WVExdytzb0FwcUJCNEJBb3A3c25Vc29YbXZSVmp4Y2xwcEEzU1ZzbUJYRjE1?=
 =?utf-8?B?aWpFT3hKOVB4aEhVZVlSd1diYUdwNDR1elV0R2lzTk5tMnVmcCsrMktmNHl0?=
 =?utf-8?B?RmpSaGI5QmlDNkRCckI2NGdxZFdjWWUrRGFsVm1Wd1ZseFArQTVXNXJ3WjZj?=
 =?utf-8?Q?B4bqbuv4FC0qd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFTQ1FEOEFHSWUrQlFmY3IzVjZiRytGc1BMUDBZUnR4SGUwdWErNld6d1R1?=
 =?utf-8?B?OFhudkdidlR2UzRtZVVQaFBTNklLUWgycUd4Tzd0YkRrWnpMVzMxT01wUFgz?=
 =?utf-8?B?T3E3ZXpGNTcrM3E1Q21DclB1ZXpxOEYrUHZEbkk1TzlhVXVrakJNc2FrSWdE?=
 =?utf-8?B?amVaYTBrS0NSbHFNcks4MVZnc0pKWnl0OWpTRi9jUHlpaFdrQmJpS01YbmxU?=
 =?utf-8?B?K1MyN1JiSkQxRFU2MDA4YmxKREE5K2s1Ukd4VU5oa2F3UnpLTXA5NkNhejNz?=
 =?utf-8?B?c3BIdlh5NEY0L3NkR1lDZkVGdGIvNzBTcVBuV055cWMzR3lZYnJmajFxUUY2?=
 =?utf-8?B?MVRFTE04cEdLTk5LTXJoTGYyeUcvYWI1Njd0WWtLb1JJNktkN01IakFRY0Nl?=
 =?utf-8?B?T0FNdFh0dUwvSVZ0QU1TVERWUjFxQ1hDRWJQMGZSRWxCNEwwbWFuTGhhY1p4?=
 =?utf-8?B?bSthMThxWHJ6ejl6NXhNVU9JcElHbW5WK011dVg3UjNNUlhqVnh6VEQ4T2o4?=
 =?utf-8?B?NURlTVF1WHcwaHlLQXllbGNMY1pLR2JRMWVZTmR6SE16Mkt4TEVDRUxNeDUw?=
 =?utf-8?B?Y21CWStkaHFsbnhMNGN6VEZ2REFMWXdHbWRGaTk4dFNFcjFUejRzSXBRbXVp?=
 =?utf-8?B?Q3VBYzZ6aWRMeU5RNHdoeVhlSW5mM1F5aU9LT1VPcVBiRnphY2pZQ09Oc05z?=
 =?utf-8?B?elArLzFxcm04R1RYaUpscm5aNGNHV25Gc1hTT1RmMnpSQ2xpRmtRTGNOaWpo?=
 =?utf-8?B?NGFMOWdKMlRFMFBYUlFEY3JKTkJmWE1BeXFpeXBlZmFzZG44cThUVnA2ZG84?=
 =?utf-8?B?ekg3OW9NdlB2ek1lUWx5UVNpSkZlbG9iVVFJLzV0ZlFqKzR6eDhETzh2R1k0?=
 =?utf-8?B?SmN1KytIdFdSNkxyNjV5cVQzazBMY2F5OHpTN0xScjNtZWRmQVpJVmdGZXF2?=
 =?utf-8?B?UEhuOTRoMXFyaWtlNXZHTjhlWEJ1VkkvMXZ1VDM4ZjUxK0dqRkdhNWg2MVBO?=
 =?utf-8?B?c1RqQnplSStlellJVTcrS1ZiaXRSWWM2VXcrenNmTXc3N20wRjJGVUFPMzlu?=
 =?utf-8?B?YUpocENuODM0MG1yRnFzTmZTNGF5czJXRDYxM2hzeG45YU5BL05OTlJ0YS9Q?=
 =?utf-8?B?RHNqeGF5SG5vNjZ0V3FQRkJuRE8vVW1kQjJSOHo1TldwS0NnRGJmbkVxSXND?=
 =?utf-8?B?RzJBRnJkM3c5aklLeWMxakloVWdXQWI0YnVJNER5RDNNZHpUZWpQT2xjR0tM?=
 =?utf-8?B?VHVzUVhOMWo2SXNMSTJ2alBWUXBzak5lYjVaY2pJckFidWFkcng1Nm9vTHVN?=
 =?utf-8?B?UHBNdE8vVzc3ZWUxdnc2TmlwSFpDT052Z3dUNVV6cEN6SjBnOGJYQm80OERy?=
 =?utf-8?B?dHhqVjFYMy9yMHZJZ0J2bU5jUmQxWGJNM3doYVlPWDd6QWtvdlNyNVZDQ3Nr?=
 =?utf-8?B?cEZiTG84b3dDZno3Vm10b3duSTU3R3V4REhKTWc2Z0JsUnAweG91UFFGbWpV?=
 =?utf-8?B?aFFEL3RnUVAxeVBFUXNIUy94Qm9zdndRdmpwcktndElvTjk2aHNJRERXVFN2?=
 =?utf-8?B?Tk04S2Yybm1yWkxaMm5xUUZhU0l0cThNSmcvaUsrQnZXVTJ1dmZnckcxYjNV?=
 =?utf-8?B?bkYvenJkWE1HMFFBWFVxNkVjM0pCa2ZxMG1kY1pLek1VOGVEelFjNUJZT2sy?=
 =?utf-8?B?NWV2VlhDdFprM0xzc0h2UVF1MTFNY0tLSEwwU3VicUVMOFlYNXpDUGlLdk93?=
 =?utf-8?B?TE1WdDl3WVpEZmdBc3VxMkREdU1vZ0d5dWtCSkhualhEbDYrZHRZMlVnbmZ5?=
 =?utf-8?B?Skg3U3Erbk9WSlZHbXhyK29aSnRwRzdBNlpVWW9XeVUxZ0pqZFc5YlppMTMr?=
 =?utf-8?B?OGZSRGFZbEV2azRtSGZ2ZmdlWVBSMmVQUVZOZ2IzaXBpWFlrU0tTcUtkUzhR?=
 =?utf-8?B?NVR5ZWJGY3F4Mzl5WFVCblUwRWFCc0pheWVFb1d4RE1kSFlrNFVhS2ZUN2Rm?=
 =?utf-8?B?WUFnRytqSXRnMEJZaXk2ZnN4WDFFczhucGZHN0hmZWFXakhBK1ZzanljSHYx?=
 =?utf-8?B?NzE5WVh2eHlyNmpUNkJtN1VWK0M4T09POW5Canl3dk5XWllSQXJ0L3FUT0Q5?=
 =?utf-8?B?VTBwb0ZjZm9veFlOcVRISkd0YWRFTHNGZ1lUVzUydHlNTWY3K1EwZCtQR09H?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 080660f3-a502-438f-6ae5-08dd6df99a3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:08:15.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C12rBBsyzSh3CZk32M1iZrgXl6Yb1BkkqE/j/aDTnKMF7OxaY0uTHsOhH1sbvWE+k9rfCRzg/Jt3pC65tMUIh/UZmbWG91nsoGTfWvH4uz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> Add a single-line fix to the base code, and then the remaining two
> compiler warning disable flags can be removed from the driver base code
> build file.
> 
> Fixes: 8db9e2a1b232 ("i40e: base driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
