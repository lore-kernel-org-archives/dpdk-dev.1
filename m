Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21320CF319B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D5C740289;
	Wed, 19 Nov 2025 12:06:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9CCF940289
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:06:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550402; x=1795086402;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=DKNOHJppWCmEMItnhv0Mafitry4nQHPgKitMjGp83FY=;
 b=HVpBRTP4zPmFzECQEqTt4wFbcr8Z1KG68swBr2KXDgbLDQ1M55i/LlGo
 Q5Nyfxy+ub6v1FJWvAPuYB5kMFln3gEsKOzLxNgZXHDQEkl8zvK+galG4
 CfKA9ne3+0iCqB+yIFL+Wr2KUFqODw/oU1mBtzUNRCXBkBFCFQsz8By06
 dWA2I9PA645WzGQSPP3Dq095yEXGvBmzgIeNB96fcyHFssKfrMhEuXm7R
 HpL3AB822ieov65C1zCM4KsG26L+ZE5MPBREludclC6Oo6rgPqQowyvam
 wmibatau34RvGj4e5Bhuvr/bB74I3ukP0cJKVvz9bvQbUXw8tVbA9ucXg Q==;
X-CSE-ConnectionGUID: XWi3Aof5QEOi5tOW7JI1kA==
X-CSE-MsgGUID: p0wJZSjFT1GD3aYmaWAE+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76693421"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76693421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:06:41 -0800
X-CSE-ConnectionGUID: AZ09EokRT7mEtCoFevM2KA==
X-CSE-MsgGUID: SKsT1guIS3qO8jvosfnW8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190684254"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:06:40 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 03:06:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 03:06:40 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 03:06:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypaO0IzeJ7sfvrL8yV9bR8j1tmpGXPxONAQYqg5LITQvOVQJiL6vWyvjf5B9aeAWzZw451r37LF7VkKcKMOYXhRzXLbMA/gjlZW1uzXQC5xLez1aKL7askDY5aDNZ1iFKA3gbSHcSC9/0gPCGJ2EopyDqTkqtZsKwinLHZTI47jQ75+1tNn8fkiBCcpr1hU6HC6LdX9z3D3i/CVzNnNr0E8esHoG7THvJ5uszKHdR9c94DEKYdr0INgzX3hxDm2jI/amWoNYFlw7j+OW4duxq7SqbEfJqvIMsEB7VzuQEL/t9cAZg7Yk6/D4G0Bkp06fdnuHGKL9uOv5qEgztyg9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGOyJxZ+SH+QmiXv8nG8Y6wSbg+FKppUUrE8Qe/WcVg=;
 b=OuPZ6yl2s4uyxPd9HN52vtCMvJzfPHHdpgZT4ijU3J65mwmlcHmMIC1Tx1bWuBr9CcF4NW+fWNrzLCf07/CvHHSTEWRZQb/LlCBU9G/Ta2KQnl/zJoMdFaQ/JfPtB5eGmY70cJg6uTMSFWz4wznA4BHfpRcDNRs3E5nGi5+QuJId9U0dyArzr+GWy0IaOhFBbO/zjAAnNGdsHUIUKVxiQqi2bT2EkEpUzI/1224D+eyOKPVz3N62gR+paQv8FltcPWwwyPdIkPlOdTvQp4fCjPOjy11/SLM/Um8Nl+aPfDg9tiOhK+9BvUAKqnRwEZxZNe7cCn3IXBK6yedqpKqxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21)
 by DS4PPF31CEE2CEC.namprd11.prod.outlook.com (2603:10b6:f:fc02::1c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:06:33 +0000
Received: from BL3PR11MB6481.namprd11.prod.outlook.com
 ([fe80::32d9:6a94:59b7:9528]) by BL3PR11MB6481.namprd11.prod.outlook.com
 ([fe80::32d9:6a94:59b7:9528%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 11:06:33 +0000
Message-ID: <aa6df76f-cced-4cfd-8111-66571534fecf@intel.com>
Date: Wed, 19 Nov 2025 12:06:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/17] Support VFIO cdev API in DPDK
To: <dev@dpdk.org>
References: <cover.1761669438.git.anatoly.burakov@intel.com>
 <cover.1763549736.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <cover.1763549736.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0208.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6481:EE_|DS4PPF31CEE2CEC:EE_
X-MS-Office365-Filtering-Correlation-Id: d409d53d-bce0-49cb-7fb3-08de275bb243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHh1SW92M0dMOTh3b3hzR0txdXBsSXlRamRVZGhyYlVDYXJvVTdFS3lydHlX?=
 =?utf-8?B?K0prK2E5cnRjalJMaUI5NnZpc2U5eXFYQmF1dnd3N3RxUlorRTFQQ2Q0RzM1?=
 =?utf-8?B?M3AwdzJteTJNR3ZrZEVKRTVkdmpEMHVveVRnWE9Pc2dib25LN0NocE5OcDhj?=
 =?utf-8?B?dUZuRzR1RWhLN04wbUQxcTNJdmV6MjdRQjBIMVBldS9oYVpybm9WcDF5bXBE?=
 =?utf-8?B?R2REQ0lZdGNBckJoVDlhdnFLUmd0dmNMcG1WY0xHOFY5eE1PQ2VzUkxIcVpr?=
 =?utf-8?B?R0FBN0VDOVgrbGxqa1I2STMyWUtTaUxPdEh1OU9BMUZqWWgxZ3QvRmJzV2Vh?=
 =?utf-8?B?V1cwQnU3OXpWa2VJT1BYdjJMbExOTGVvWDd1Y3E4TndJUXF4VXJvZXZFL2Ns?=
 =?utf-8?B?S1RzNlk4UlFFMzJhVEpBQlFRZlErbG1mRFBoTXhPZlRVdkxqa1JoTUhDekFP?=
 =?utf-8?B?WXMwMFh6UjRpN1hQNUhzUnc4amNpNnkzQVQ1cStzb3ZQSFJTbHVZQnBiWHFk?=
 =?utf-8?B?L1c4WGNpZko1Y09Rams5Z3V3MGRwVEJ3SnByUnpvZ0h5R1B3RVBmODgySmdn?=
 =?utf-8?B?SWxhTDgwTzBRNW45OTVza3dDRmhFekYyckRKZnlWM1dHcFFlcnZNRllwV1Vp?=
 =?utf-8?B?R3dzTjdlbnBUakxPVUdqTld6Y3JwOFRJdXZTZkpHQ1UyRTZPNEVQQk9qd1RK?=
 =?utf-8?B?dTFVc1BibU04ekpjRXBFTEtVSmxhaXd3UHQ3M2l4WDFLcVpVM3JLRU40TDY3?=
 =?utf-8?B?aTJsSFdodkcySlpEZy8zSll6TStsek5aTSsrbUt6OFUybUUrbnlUTC9HVUJl?=
 =?utf-8?B?OWZYeDZXNXUvZitKSzhVR3V0ZENwQWN3ZmNzcDUybndDNlBWcHljamxGdVdw?=
 =?utf-8?B?TUEraVFCRWs4L3JKc2hQQnBkekVVbExjaGhlQndYeit2QzBjOG8zYUgzamJR?=
 =?utf-8?B?eXJMeGYxMGpQS05PclVjVzVUQWxnNTc3RjNtODVUZG5KSlBobFdrZ0ZvV2Nx?=
 =?utf-8?B?N1BtQTBoS3dIZmUyS2JVVmphcU1zd3Z1aUs4d3dOYlFERm5jcVk2aFBGVVVB?=
 =?utf-8?B?d3h0emI0ZkFxSDJpMWVhakNwa3RRRDZZVllBL290NU9xcitVaGxwTTkxOXZx?=
 =?utf-8?B?OVo0akprUGtuUDdTWHl1Ymh1NS83V2pLQVRIN1E5NVMvUklGemVOamd0Ti8y?=
 =?utf-8?B?TTFHTGJBaHh4NG53MElCa3ZkdEhiMENXWDdPVnp2akI2MFhvT3VCZzJnQXd1?=
 =?utf-8?B?ZW8zRXZXQXg4T0I2eFQvVjE1M3lpY0ljRUxIQktGbUR3MGZ0OG9XVTUwa2NX?=
 =?utf-8?B?a1ZGN1pUK2tXRUVYZlAvNVRXYXU1V3pyandVNDZKYW91c0dNNGRqcXpZOEFx?=
 =?utf-8?B?RWY1Z0lwN1ZQOFlNRkgrNDVqaVBpRkdYcDg3b09RR2kwbW1HRHAzVGd0Um1z?=
 =?utf-8?B?Y2lCaFU5OU92ZmVpcG02ZnBsUTBVK2txb2RPb2V2NG0xVlpGUkdUazI4eTVO?=
 =?utf-8?B?MStMemhTMkp6MmN3Tkk4MEZxNGZWaEUvd2R5ZVZuTHh6S2o5VU5yKzhJK0JM?=
 =?utf-8?B?dzg0RkdMdkdzNlJZMVRWVk9WK2s1NnN2Zk94aVRjVEhDOUdpVzg3aGhXVUUx?=
 =?utf-8?B?WllhQjdkWWRRa1NzZFN2L0M1VEpUWFdXVlBRN0N6RjZyeDA0UTUxQUllRkky?=
 =?utf-8?B?OXI2NitDL2E0WFlTeUVSdkphNXdKd1hmak1yckJVbndMbnpGVm9sSnUzT2hh?=
 =?utf-8?B?akswL3h2SEpYT294YVp6bUhaV2lhT3NFUnU1dXU1OEZrazhDTFp3b1BocE9M?=
 =?utf-8?B?ajc2VFV2NWcvSS91UVQyWlQ2cWhHNE1nZVB4TmdId2Vqb1R3KzZYcjdBQ3oy?=
 =?utf-8?B?eDRvelJFZTREZjM3TEo3Y3hXbXV0VTJwWnVNTlcyK2RFd0NOQzZzOUZVZitL?=
 =?utf-8?Q?bdexzi1q4YS7tWQm8pzoTjuEKfSuxwzh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6481.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFV2Qmp4OVh3WGVZc3pZL2E1MklDRC9wbjVObW4xeE96amVUMS9KTW9pcnpk?=
 =?utf-8?B?QVpRV0tQYmRYcm1nQXZHV3Y0RFQrOVFyL3EyL2VVYXhWQXdOWDkxUm9UazY2?=
 =?utf-8?B?S0Qwejd5dmpxM0hFNEc0MjdMazZGS3loRnhoWnl1Nko0U09zcDB5QnBuRTJF?=
 =?utf-8?B?QWE2RC9VdERKakRXdU1mdVc4cWl2UTgwT0VVd3JqSWphTGgzaEh6RjRXbDJS?=
 =?utf-8?B?SW1xUFVjNEhlTU8xL3RwWjFxS1NSaHZDZGE5VHFPZkl0dHFya0tHcERybUJm?=
 =?utf-8?B?RFVhUEc4VE1SQTBuSUt1SVp1SjZxWmlBdjB4UklxTlN1MjVyY0p1MlRWNkFJ?=
 =?utf-8?B?SXl4cklmNGtyaEJJUGpIL3pWWHZLNkF6czdPd3R6SnNPYmsrZE9WaFc3RTNo?=
 =?utf-8?B?U3puby94Qzg2VmZvZEJ4NDIySkRIb0xuck9ycnV5d2k0OWt4ZEFFUENCSkpu?=
 =?utf-8?B?OEIzb0haTERYd2pSV1JQa0dicGdBdXdLMTh0Z0dJR083TWRNRmtFVFFMeW1K?=
 =?utf-8?B?VXJFRW9GdEppVmRSeS9mdytVcUxkYVhOVklxQVNXSEppSkdqWmlwQmI4NjV5?=
 =?utf-8?B?MGIvSmFDaERSY3dsdEJuMGpUM2RWL1pLVTRqbzluR0RKV3NEeDFlZGxlYVBE?=
 =?utf-8?B?T0VPUlpyUXJmY25ucVloeVpMaU1hQlhjbVFxTzFERG1kZnFjbU1MSzVJREVC?=
 =?utf-8?B?YkR4RENySVlDRkwwSkxSTU1VQ0pERVI1a0w1TVdzVjlNcUprNHJRYld6YXEy?=
 =?utf-8?B?NExyVWFTeGFSMldINXBGaHNhdWpETFg5U1VSNzRnVWxmZXdaYUxjVE1ma3Fn?=
 =?utf-8?B?bUdUN1dkZjBFVkJqZFQzYXAvY21FRElOcWJldW5xRkYwQUxCM1JWVi9aZzND?=
 =?utf-8?B?bGhueEN4aThXRFhxczdablM4QWViTmtJcklNMmJHcXBnY0dVcVNpZlBiU0V1?=
 =?utf-8?B?ZHhYMDVxOWpNRTl5ZWxCTC9WZmVGWitnY0k3MVdCT2hMTXptbzdPQlNJaGhW?=
 =?utf-8?B?VnptTFU3ODRzbFZXUmVJOHdqSEh3RjVadXFLZllDUmJRYXNER09lRG1UTVRq?=
 =?utf-8?B?SVpzQ0YzRFpsWEl5c1dORWp0TGMvS2ZBMDUzRm9uNU01TmZQR0c4Y010bldJ?=
 =?utf-8?B?WHB0NDcxMER4VXpuZ0J0bUYxeDlkMnlpWmVtekEyMHdsdnlxZEJ6cUM4djVN?=
 =?utf-8?B?N0xnN1RSbmZ6MEcxOFd3cmtMQVdFWTRDK0toSFZmQ25mdXNvREJOYU5rTG5L?=
 =?utf-8?B?VmRTQUZ2R0s5WEp5bjdHdkpqdFR6YUhhdkZpNHluTVBtZ1BLQmZuTkRmeTBU?=
 =?utf-8?B?ZUk4Q3ZpUmllcU9lWTFGelEvT0todlpoUk1mYkRsWXV4dUEvQnRTZmtEaSt3?=
 =?utf-8?B?WU10S01hVkRERVNQbkhncDZ2YkpoTkFNa1pmaUF1VFY5ZGpJUVRCOFpzVEE0?=
 =?utf-8?B?b0RrdzI0dnJaakhSd0tTSXByeDE5WVJ5TEhVYWZJUWJraGRCejNtSTZOT2dp?=
 =?utf-8?B?Nm9OZWJoc3RCVWxJenMyYytqN2h3NlhQSDAvNHE3Rjd3b0lMdDNMZHFaNkdT?=
 =?utf-8?B?WjZpNlRsYitUU2plYkhoelQ0RHBxMzhRT0FtdmlZVVRaMUN3NWtLWkZpcTFy?=
 =?utf-8?B?YVFGTjhmaUVqT053YXplMWp2dzMwNEl0dmkvMHg1aEtiVEZCVWxtSkhPdXYw?=
 =?utf-8?B?Z1BXWUp5ZjE2ajF4eTFpNlZ2MFpqWEs3STFzdUp0NmtsY2hibk5BQU05NkFO?=
 =?utf-8?B?NlArTUhNS2c4SEMyQXlLNGNNQmZ3SkFxZFpBMFlwTURlZk1hUzRKdlI2Rk9p?=
 =?utf-8?B?bWk3Uk1VZWFHeTRlTUNlTHUrVzlxWHl3Vmw5ZDlJSHlMN2JTR2c3MHJtbmww?=
 =?utf-8?B?V2UvWXNab1hDN3dZSExFYjN2Ti93UjRmMUt4RTgwRGRQZTBBaEZKZkFQVzFB?=
 =?utf-8?B?Mm1BbjVUY3hQZ2o5NzlPZ2hkU1NPM2M5Y0lGSFNpMG5wQlJpQWhnTFJBL3Zl?=
 =?utf-8?B?L0JEc25GL0E5L1MvSFF4NTVCZ0hFQ3ozWUl3QjZ0Nzh5ZXowUmE3RGVuMmI0?=
 =?utf-8?B?a2syRDhFV1EwWTJZZi9FaGtUY2JFdUJ3QnE5S2tvUDB0TFUzQ0JJQStTNEkv?=
 =?utf-8?B?VDBNQ05jYmN5b0NpSlZ2d0dwTWt6QVdhWktkSVhvbzl3d0pMZm5aN2E1dXNG?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d409d53d-bce0-49cb-7fb3-08de275bb243
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:06:33.1480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnEIL9iDN54v8fe61DdycmVo0tEXckDnDqcsTf7ZjcYddwdFoatfUVrlWy/jcPs/z7u1UklVyrZw8eqyGWAF4InwFBUE7b8rAzUlwFfvj7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF31CEE2CEC
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

On 11/19/2025 12:01 PM, Anatoly Burakov wrote:
> This patchset introduces a major refactor of the VFIO subsystem in DPDK to
> support character device (cdev) interface introduced in Linux kernel, as well as
> make the API more streamlined and useful. The goal is to simplify device
> management, improve compatibility, and clarify API responsibilities.
> 

Accidentally left out the patchset with iommufd and vfio uapi headers

-- 
Thanks,
Anatoly
