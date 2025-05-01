Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DAC369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 15:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AE0E402DE;
	Thu,  1 May 2025 17:54:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4A3E4402D3
 for <dev@dpdk.org>; Thu,  1 May 2025 17:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746114858; x=1777650858;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AK+vWs0ZWDbhAP6HcRC7hktvgL0uIAPqa4z5WzwQNqQ=;
 b=ZGfLssaYK4KbQ83A/TZXhaAy9dCYQTes9lUHP3/2oprfhsBuz3ncdZmz
 YHrUZKku+fe92wcPxqlHh2Ll/QpKc0sIEIAzgUdKFf+AFdqKlMRQK17J8
 ghh9c+k1QLRwqRd7DRj78ju0dMrsapZJWX5Flhg2n0J64mLgNkyyoCrxX
 B+SdAFNL4n0h4zT4z2ldsYt6vulfYtVArXQdWhRE2zVqEzYiDscxK4Ue/
 h154a7d/fcPD1IMCQ0zRhhGEyehWS3TeKcxuOY4RTMtsXPhp++5H4GoiX
 LNNtkGhrWO3zC8eMw3owJudYbCbMugXCBZCtpKgEmPloJp5EBsgY7yOp4 w==;
X-CSE-ConnectionGUID: JQWRdxNoR8mS1DBBCtE3YQ==
X-CSE-MsgGUID: v7dVcON+RHafoLDTWzRPKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47671355"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="47671355"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 08:54:15 -0700
X-CSE-ConnectionGUID: qELUUcMiQGCa3S7fsT02aw==
X-CSE-MsgGUID: k8s7eyubQuy7yIdxSCWOBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="157639828"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 08:54:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 08:54:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 08:54:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 08:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RApik9pPEecUz5PoTVtcqHjqQ3vu4ktJS7HiG9ODMbrT0rdWxQmfgU3t8ce5wRGbgiSwqqlXLidzUtNY+N6XVInlT1XSJoYl4U3eySwUjxaD9gLP6dzzOvaTa25YMIqWuWmWrNka3AzeztI0C2VAUedXfvH1ubJAPhBDSpcq4mEr5ZaqkqmO4UdWG767Ca9SS2KUmJQNKeNl77Y8ViyhG9+ktMcz2W1ZtDKwXZAj7SJC83x/ya1vw29zr3YCN0VPPNxzVsMdvHK6g6j54i60mQQpIgk7e8VVgOZ5a2Xa1QbljXKPZFgqMbvhkSt30wXKHYYDLbyEz9jXiGm9PIsXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVq5fywihCBmPzpCjt/XbkAGiQPh62svP8zspng73Ao=;
 b=A+/xTxE8Ll7ZrdzCtlTRz5UdX3L+fcNhj2eIPhCRVuwvSBJpC+7RUPaXyrIc23HFfQLadFLwMZrWW8AAtlla4y0r06TZA6uVga5ju8FiIUl6ZDDnAZYGt5OY/YeWd9QnQnp4OlwVJtlBDT0a4xzNovxRUgA15coG+hNfCg0KcDKiFLZQc+mDgEebYR2ODqF5axiHfV6MnjJ1Tkv1GyddCnM7uBFKgl/HwCKvB2nh1qymURs4+66JxMFBnxfhCxTptPESU9RuY1LN2KsyQAlg4VOy708+RZ/DebXygTrVgsR/EIgLzJxLozqeOpu+hoibSEV7fdx2iRoS6cwG2indOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 1 May
 2025 15:54:05 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%6]) with mapi id 15.20.8678.025; Thu, 1 May 2025
 15:54:05 +0000
Message-ID: <07f2b368-2402-48a1-8cdb-6ed1feb7c695@intel.com>
Date: Thu, 1 May 2025 16:54:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc/nics: improve structure of Intel VF section
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
 <20250224152611.1012935-2-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250224152611.1012935-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fd5186-0e4f-4d6a-78ba-08dd88c8667f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHFFbk9TeThaTXdhSVJOWGhwK1F0NS9JM2dadEdFRm44Tk5xY3EwR1IzdmJX?=
 =?utf-8?B?aFhxTXJLdGJialJRQnIyR1EwVEpLVGZaQWRKa3g4UTFRR3hhZERrdHFaV3hl?=
 =?utf-8?B?M3RGWFJWY1ZhYmxYam00d3pQMXRpOGdBcm9uR3U3Tkd2cU5FVUljSExhMTBt?=
 =?utf-8?B?SXhKbHhwWDNsOTRrRmo4M0dJbDBmbmpOeS82UmpnQmdSL0paZjdIUkU4NGNv?=
 =?utf-8?B?eWhqVysxYmtpNVhlcWJCV2VXc2VmelVsWlc0QnVqVlRQYzYwZHY4dU1nMFRx?=
 =?utf-8?B?NU5TeldxRXlkRUErTnVQQ3NHYU5pUG0wZnNmSnpzSTUzQzc2TVFUL0VLdnRj?=
 =?utf-8?B?czd4ZFlldFpwQVRxeDlNaEhJemZBcTlodGpRQUJxSWdIZC95WHZWTVpOT1M0?=
 =?utf-8?B?NzFJUkQ4QVhrc21rZERnR0xLdDh0a1lnZnl6Q1RKeUxlTUtqd3AvVmMxV2Vz?=
 =?utf-8?B?VHJhUEN0RDFLWWs2V0hJeXlubmNVcEZjcm5KMk5xNzM3STZTa1VUUkREQ2pQ?=
 =?utf-8?B?anRRa1ptQnVlVEZRQ21ZMVI4UjZWUTNsQ2VmZmQzak1Ua3IyWHNRTGlIQXFS?=
 =?utf-8?B?VHdXWFFaUGk4VG9FQUxqbWk3VTRzNlhlNmh1bGVEdDlDQmpSWGJENS9UVDYr?=
 =?utf-8?B?dk1aRldUUFNVQzFIT2xGZTNVUSt1MkVnQVBqVGljU3FzWDUwZ0hXbUNoando?=
 =?utf-8?B?SEFHeGs1ZEF2VWNFMHc4Vzl6N2FJZnpQMFVaVnY0SEgyOHhDdUpxcFdSeHE0?=
 =?utf-8?B?UUp4bGZBNUc4VUhwRXZBeWI1Um9FUmFweWR5VTE5eG1wNTd5N2lNV3FaanFt?=
 =?utf-8?B?YlR5TlRsT3dQNldzd0hTcjdnWHM4b0xpTm10czd0UEZHcmhDdE04c0d3T0ZL?=
 =?utf-8?B?VDJvbkF6YzVPdTlSY2dzb2JnRTNHd0lyTEo0d1Raem4zRnA5NXpxeXQzb2dY?=
 =?utf-8?B?U2lYb3hSYmV1UUUwVWxnZW1tRW1OWnF1dUhPeC82Y2tvKzZpNGkyTkJKK3BZ?=
 =?utf-8?B?UVYvNnB1SXVZR0pZZlhMR3JJTkNWTm81ZlE0dDZKZ05aUm42WlZPd053NVFU?=
 =?utf-8?B?UTBPQURXUzV1M1puVFArdWdObm1UNHpLVGk2K1crbUtieElmanhqUUFoWitW?=
 =?utf-8?B?OWlCVWN5TTdoSHRDQ21aY1lCbjJOeUJkRHdCRnphWXcrbGR3dzVHYlpGYXQ4?=
 =?utf-8?B?c3VveGdURHBVOVhvOXo5TDFFTmtIZldEbnpKVlo0K3lpTVhGSTRWZnFsNTI4?=
 =?utf-8?B?MFQzdXl3NXNDQ3dWeCtTSFFOOGtBTCtUZldGTWl4N3Yvd3JCS3F6Y2s4NGtL?=
 =?utf-8?B?SVluK2w1K0FPaXEyNncwVWlRaU1pUHorVnpqenlvanN5Ym5HdWhjSUpCcUpq?=
 =?utf-8?B?YTR0N2w1S1lCUUNjZk1xWFpEZWQzanFSYmtEb001T01Sbm5JQSt4eUZLMnA3?=
 =?utf-8?B?a09GSVhEdkFsSC9Wa3RxYnFtcS9VZEJid29veFBYekx3SHJEclBzV2hIdzlP?=
 =?utf-8?B?eWp6UVpaZWJjRCtudVFjY3B3UHdZcVZTMWxVa2tYODhwRUswc3hFV21zMkQ5?=
 =?utf-8?B?Q0V0ZDdZWjRsaW5GRTc0eURCMEI3UGN5M3JwMEJxUVRBWWh3Mnk3ODRjdTFX?=
 =?utf-8?B?bjQ0em15cTNKMWpQRTZIUzg0UUdTSzJhV1pYSzFncktCQ0dzNjB2K2ZQbk1Q?=
 =?utf-8?B?UlEzNUdRM2grOVhsb0c1UVVpK1B5MjNlb00xdnJ1UGlYQXd1TW5HSnFjSmFv?=
 =?utf-8?B?V0s0TlI0WHZYa2RDbThhcW5mWWcwUjZTYkZwVDRSVXlLNHFRR0JKOHlKcUFU?=
 =?utf-8?B?YU9CdGRURm4xbEFiU0ZBWFcvTjI1OHZpNFlHUk1Pcjh6bEZMbk5YeSt2bU1v?=
 =?utf-8?B?REhlVWFSSkg3VFVNcXF3NDd4ekFxZzlESm1TMEtEK3VUd1VDWDNLenovOW9C?=
 =?utf-8?Q?wGZVcrRG20A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdoMmErUHdYL0ZCSmxwU0Q3bDRtZE53UHZaUVdLVkpuVy9RTmw1Z0hVaWEx?=
 =?utf-8?B?a1lDYm9LcDVxTXRONnVRa05DMmlYRkJqT0xIeUZQSXo2NG1SVXJZNEdQZUYz?=
 =?utf-8?B?WlZDUnpaVDRTclJUUnVUNXpjcURoYTFzMWwvTDlpVlF6dDc4bmpyK2g5VWlk?=
 =?utf-8?B?OGVpOXZmemI3aXRuVlFXcG5nazhOcnczczQyMG9nM1JKSUlZV2VaaG9xQWhk?=
 =?utf-8?B?SkEzYkxmdFdRUnRzbkEwK3d6aXZsL2E1U1Nod2gwSEYwbzBMcTcvMGJtOS9N?=
 =?utf-8?B?dks5THg5WUhuVVY1MzBPanFlVkY1NUNlNlN6WjJHWk00Sk5OSzhkdTZoNFFY?=
 =?utf-8?B?dUE2a1RWVThzQnNDMktiSE12YlkyeVlYbURuYkJBK21nN2doM216MUoxd1Q4?=
 =?utf-8?B?SHlSeHdjUGlFZTFnVloybzRsTkhMQUliVXBrY3hOeUROMkNNSklwWW1xM21a?=
 =?utf-8?B?aldxUis5VldIQWRPd2VYMFd0ZTRkQ29kSFl4WFMrVER3dXExZEkwZkdPMGxE?=
 =?utf-8?B?Z0UzcHBzMmtsa3M3QlAyd25JdGhhcy8rcXhuaWRQcG5rK2QvRy90SHJFME5l?=
 =?utf-8?B?d282cTNSRTdnWXdRUTR4anF3ZUJxaWFJY0R5VHB5NzFCYkFlMHJnOGNOeFda?=
 =?utf-8?B?S0lFcnk4RFhJdjArdmc0T0VCQityMlRKT0JUQW5NbGlUY1kxcGF4VXNmcStw?=
 =?utf-8?B?Wm5Wdzc5ZE5LSktaamE0Nkp0aEpkaExBZngwOWNwWXpYNTY1Rk5vZ2hEVkdU?=
 =?utf-8?B?RU94ZEV6NUlvM3RFWnB1QmpieTJkVzFGdDdwU3pjRGNFTWdreEF1Si9neHNn?=
 =?utf-8?B?dFlRM2JzVnVPU0twaGhBM29uazRETzJnTU40Q3o0ci9laU5BZzV1VjJFaDdn?=
 =?utf-8?B?YnkvZ0lNRm9ZMldVY2RVKzg0UzJaNk9zMkVOTUlxQy8vUGVMMnUyUXhmcXYr?=
 =?utf-8?B?OEpyRTFvM0tzMkluK1dMM2NwbXJZTXVZMklyUXkrVitJcTg3MmVyWVgwOXlL?=
 =?utf-8?B?NGc0UjBWeXYzT2h3VjdSRTFUcGk2eTVRZ2hRd2k3RURoY3IvaG1FUmdwS1A0?=
 =?utf-8?B?OWhUbUhuRU5vUnIyQmdDYjhyT3JuM1hKY3hTMW9JTmR2Q1VOTlhJQ3Q3aG9T?=
 =?utf-8?B?VXNyTDRqaGdQT1J5eEpYTnZDTFJyaDBLNkpLT2ZaMHlBTTRFY1NUSTVjamZ3?=
 =?utf-8?B?MDcxVkJOdVYyQ3BHYzBoNWVyTlpsa0NHemxiV2QvZXZBWlhmbHNXWVhJc1h0?=
 =?utf-8?B?Y3NSUzI2VWVTTlRBd3dqS3BxaUdDQmlsVWpZaWd5aVRnTlB4bmFBU2Nobno1?=
 =?utf-8?B?REczdCtFMUJscnRRUkJ1SnNaYkJaQWxsL2hGY2llbmovWEl5dDB2cURoWmJ2?=
 =?utf-8?B?Q1VmbjBuWHNaY1RhMDU4SEZ5a1RHRmFDVU5sRFVubnIyWXpDakxJQXFRZ0ZG?=
 =?utf-8?B?NGdKYVErOExYZTlNUFkrQXBXMkZIQmxrVklZTy9OcDVrUTk5QVROMDNHbXhI?=
 =?utf-8?B?eU5GL05BMUJudGtsUGhobE15SU5oT3Z5VTAySi9pTUVMYnppeWN0TVlNUFBX?=
 =?utf-8?B?NURTbmF0c0xTZ0NpMHplOGhBRlFIZ3lTYlgvNHJWRDFnUkpwQ2c4dHpWb3Vq?=
 =?utf-8?B?MHFrRzRna25OMW1TblBPRTFEamN1Z3QyMjYvOFV5QnJJNyt0bnpMTkt0eEFh?=
 =?utf-8?B?VGZxT0RVbG5aNFJudjBzNHB3bS8yb2h1TlgxWkxnR0hlMHVvVjExc2djamNN?=
 =?utf-8?B?cUI4VFhxZ0cvbU94KzhFMk1BWlNyTW8yTWpRbEJyQWJpMmlSK01wOUhhd3VK?=
 =?utf-8?B?Wlh1UWloMkhKRklRNldDbFI0d1FyTGh3MXZSRDlPZURNVzlKK2lRQmFsWUdW?=
 =?utf-8?B?NUI0a1JCa215VGtXK3B6SWV4U0ZjTHJlNms1dGc4TTMrQm4xckE2WnlmVVEy?=
 =?utf-8?B?SUdpZzkwMzk3TU5vcFVLNTRPSnlDUEJTenpxOThQLzNQZ28yaGQyM2I2YWRQ?=
 =?utf-8?B?STl0WHJKWG9ISzdsZlNGN1dwRDViby9iajh5YUs0WmVwMk9qamNkUzFxZ0NP?=
 =?utf-8?B?K284NVBIUjlnWGc0aXpEa2lWN3kzd3A2ajB5ZGtCemxCSFlXUTBKTTBoYVMz?=
 =?utf-8?B?WmRKN294S25BaWtsNWFwQ1hnYjhmaGF4VFg2RlozL25DK0RJclhFSFltYzNP?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fd5186-0e4f-4d6a-78ba-08dd88c8667f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 15:54:05.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfqBW58rlxN34O4gjWhrNo//JtCNMmOZff25IIwjazhGyEg74/5TwPkg1mjewIhFPRgEAGAuFfyEwnvE6qOI/Hip8p4RlinpXswM7ySYLcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
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

On 24/02/2025 15:26, Bruce Richardson wrote:
> The Intel VF section in the NIC guide document had descriptions of the
> various drivers at a very deep level of the document hierarchy. Improve
> the structure of the doc by giving those per-driver subsections their
> own top-level section. Also create a new top-level section for details
> of hypervisor use of VFs.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   doc/guides/nics/intel_vf.rst | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index 4780ee7add..2b0eebcafe 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -68,8 +68,12 @@ and the Physical Function operates on the global resources on behalf of the Virt
>   For this out-of-band communication, an SR-IOV enabled NIC provides a memory buffer for each Virtual Function,
>   which is called a "Mailbox".
>   
> +Intel SR-IOV drivers
> +--------------------
> +
> +
>   Intel® Ethernet Adaptive Virtual Function
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   Adaptive Virtual Function (IAVF) is a SR-IOV Virtual Function with the same device id (8086:1889) on different Intel Ethernet Controller.
>   IAVF Driver is VF driver which supports for all future Intel devices without requiring a VM update. And since this happens to be an adaptive VF driver,
>   every new drop of the VF driver would add more and more advanced features that can be turned on in the VM if the underlying HW device supports those
> @@ -126,7 +130,7 @@ For more detail on SR-IOV, please refer to the following documents:
>       * ``offload``: Check for use of an unsupported offload flag.
>   
>   The PCIE host-interface of Intel Ethernet Switch FM10000 Series VF infrastructure
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   In a virtualized environment, the programmer can enable a maximum of *64 Virtual Functions (VF)*
>   globally per PCIE host-interface of the Intel Ethernet Switch FM10000 Series device.
> @@ -157,7 +161,7 @@ However:
>       The above is an important consideration to take into account when targeting specific packets to a selected port.
>   
>   Intel® X710/XL710 Gigabit Ethernet Controller VF Infrastructure
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   In a virtualized environment, the programmer can enable a maximum of *128 Virtual Functions (VF)*
>   globally per Intel® X710/XL710 Gigabit Ethernet Controller NIC device.
> @@ -196,7 +200,7 @@ However:
>       one transmit queue. The default number of queue pairs per VF is 4, and can be 16 in maximum.
>   
>   Intel® 82599 10 Gigabit Ethernet Controller VF Infrastructure
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   The programmer can enable a maximum of *63 Virtual Functions* and there must be *one Physical Function* per Intel® 82599
>   10 Gigabit Ethernet Controller NIC port.
> @@ -271,7 +275,7 @@ However:
>       The above is an important consideration to take into account when targeting specific packets to a selected port.
>   
>   Intel® 82576 Gigabit Ethernet Controller and Intel® Ethernet Controller I350 Family VF Infrastructure
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   In a virtualized environment, an Intel® 82576 Gigabit Ethernet Controller serves up to eight virtual machines (VMs).
>   The controller has 16 TX and 16 RX queues.
> @@ -316,6 +320,10 @@ However:
>   
>       The above is an important consideration to take into account when targeting specific packets to a selected port.
>   
> +
> +Hypervisor Use of VFs
> +---------------------
> +
>   Validated Hypervisors
>   ~~~~~~~~~~~~~~~~~~~~~
>   
> @@ -341,7 +349,7 @@ For supported kernel versions, refer to the *DPDK Release Notes*.
>   .. _intel_vf_kvm:
>   
>   Setting Up a KVM Virtual Machine Monitor
> -----------------------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   The following describes a target environment:
>   

-- 
Regards,
Vladimir

