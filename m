Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCC1CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:11:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B05054067D;
	Fri,  7 Nov 2025 17:11:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 61BF14021F;
 Fri,  7 Nov 2025 17:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762531862; x=1794067862;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=52moyNsg/5dbnFptK1hVyodJe+aLWW4lKj4DznpKZiU=;
 b=XrjhBIEUUpZGcQTJxbQ9AI9L3Ia3TX3oGoMWAiSJ4PN1R8W1DPSs3os+
 Yub1072988Q75bH17UX4SOjUwH0w1EEcgkg5bEeoOGlDKxQOcR3eDIHqn
 30PUwulB3pTOkp5X0hIrFGiaYtLNOhDGzqTgl53/kG/RP6MH9owIgMaVv
 ULF6LwdLAbblNFTUe2udDl40xnUTsEIIUM7JvcjVp6jpZ8X+JkD05TNI/
 4FZWKbfyiLE/AqaLntwwCq5rsWF/cGpfBUziabCV+itPiZsA2SaJIVbsC
 LB0IGCZCxUKjMCZUf/7rLW4iYQVOPRKmZtc60ZGTfSYZftXpR3kZSl74b w==;
X-CSE-ConnectionGUID: QrkmizfNTse8IA5isl1zTg==
X-CSE-MsgGUID: HbDUtQ8MTUWXyYowTlCeqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64777886"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="64777886"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:11:01 -0800
X-CSE-ConnectionGUID: ko7UslBDSn+3lAw5xZ8+5Q==
X-CSE-MsgGUID: hTz+n9bdQ4KbwwQDvwHZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="193246111"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:11:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 08:10:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 08:10:59 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 08:10:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz1Cts4px8IxjBpc8z9Z4UVzZaiEuWtIgFWSduo4B+9PfONEhLn+oZBIw81X0Fcg96vcvOgn2So9vOEh0WI275w9xrgt6WODoR1Wz7cn0RiXUdiV2Qljz44gy5JUZEs57iicSHogg2C3SlQicjZyBdlHXHt1YHTVu0cF2a6NOEMP2CUXB1v4DmPmi8OVEgIwAt0PZpZo3Mbj91ysRx8wNravbkMTmb48UY1M/j/AiHZf6EUOyIY1osivFGGcefYB8of9+CassJbSy+YOT0IUbea1niLWDIgHrnY1Oam5cvTxdBkBeStWNhTzs3/jBrMdSulpHX//vzlYQ8gD7kvc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W1lrDH47fq11IKcfrKCz0bQRKlE+kKGt/Wfb313dvE=;
 b=cOHJYFQ9mpUT+dOXw+w+GOSEVXkWj6T+nef1ZJX2JPYnShlK2ftTtdItTetwtXfYVn+cbdrvOPV4D/m80/h1zU90m19+Ccw879HPK1jcp3nxzHzcjlRRrM/SrNZ/9GcCX+mzNWUKUZ1r0CvYPefsZA3ubSKMY+NomDL9tHNPpmJpvta42L7jxckURkrACkSBt9Sc3eLGsON9FSuDbjehHdRawmgQ53YW9MwqMkTC06SDky8iSmTE+EdmRx3IJUKZmqukPYch7ovcpXXhaCVqior5MqhxtW9ScjSL8lk8LAgFquabJlbENK4DVBxN6E0FTmBabFfSQkM5LN9EBNaM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:10:57 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 16:10:57 +0000
Message-ID: <72033313-c9f6-4b7a-8298-c32265ae8489@intel.com>
Date: Fri, 7 Nov 2025 17:10:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] app/pdump: remove hard-coded memory channels EAL arg
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20251017110638.1094371-1-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251017110638.1094371-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::26) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1650aaae-693a-4e7f-d6c9-08de1e183c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V25HWFlhckY5aTU3MDZuZ3NOTDQ2Z2RtVWJJMWZBekIrOTZtVkwyTm13SnRy?=
 =?utf-8?B?Ulh2V2Y3M1ZBc0YxZW1IRTVsYVd3RUMvTDFHMyttVmpCOVRhZVdjbG5KWkpF?=
 =?utf-8?B?anl2c1dVcXNBeGFQR1ZaYXcxMGQrRG1mcE1tQWNFa0ZHMUROWGZ0b0NXOVgy?=
 =?utf-8?B?TTNyNGJ2eDRZWEkrLzhDbE43dnlyWTM3aHdhSmoxNXRRVUxBc2FWNG5LRTVu?=
 =?utf-8?B?OXRkVC9sbVdDVHhCYXN2NFJxWndobHpJRU9XNTVvVXhQMlJGc1pVcGNBcHIz?=
 =?utf-8?B?cDJjMmpkOFZEWndiY2RXMm91MmgvRXQ2dm5ydWVHa0ViOHY4N2VocVB0MFp6?=
 =?utf-8?B?Vzh5RjZEcnIzcUludlJIbnNPWDZSRjNzdVhmTWFOVzlaNDVzVktXdW1tcnlY?=
 =?utf-8?B?ZG53b2h3b0JyOG5DakR5TWlmenF3ZVhMZTd5V1NxOXlxcWd5ZGl2UnIzc3kv?=
 =?utf-8?B?cEpXWnBlQ3NNMlg0YzU1Z21lVm1CWXpjUUZOMmdWVzhGbzQzWWtYcjYxWThh?=
 =?utf-8?B?a1FhQU91NUlJdFdsZ3o5YWdpTWcyUWkxa3NjaWVPa1dFOG1GdFliTGR6TE9o?=
 =?utf-8?B?ZmNjb25VNmxHcTlOK08wd1ZOTW5ZczEremJ6cWpwRlR5Q3VvNklOd3ZIRGpC?=
 =?utf-8?B?cjhuUWhqemorVGxRWjBrbzQ4Yldsd2tzVGIyU3EwTWY3dHdwYVpCSTRCY0NC?=
 =?utf-8?B?YmdDVE96QmlQRi9YdGhqZGZ3V01GWEw0NStBUXd3ek16LzBYN2dDZ2JXOURU?=
 =?utf-8?B?aFNaT05BeXpwc20zeWdDci9TVisyYTlIMWhPcElnUm1FallTeDhadkJERG5k?=
 =?utf-8?B?ZGIvbk81TUlvWWQ1OFRuQXFxOWxyUklib3pOYUZtbXFlWkNseTQ2cDN2R3Np?=
 =?utf-8?B?c2hZWmgrRGN3OUlYTjhtd0tPczV3U0lINTdVeExaNk50Y0EyVU9DQ2dqVURR?=
 =?utf-8?B?RzZpQ2hYRDVRR3QxNXJjVmUyY21qUGlGTTR2Tnk1SzJmY2MzK3h4TVNoZUN3?=
 =?utf-8?B?cHJoY3lSUDAyK3lJTk9Vc3JpOTMxZVE2OGl1REJ2MTlGWkR2cDRDZExrczEy?=
 =?utf-8?B?VExRYTVodHpWcUZYUVkxYVRIS0hVa1huZWVvN3VRb1hiRE1rTFYyYURXRjFU?=
 =?utf-8?B?Wm1MYWF0NlJrYW9rd3FtMElxMjV5TEh1cmJCdEpIdGx3cWRaNmM1L1VqM2Na?=
 =?utf-8?B?bmdCbUVBRkRJdEtvRUh4OHlGL1NqaHlSMzl2d056Qk1NczlZODRFejBXRFR3?=
 =?utf-8?B?dXNCVTZjS1hqZzYvVnJxYms4YW1MQ2NPNHVxcjQ0bnA4Y2hFVEZSQUtNdTBO?=
 =?utf-8?B?L0pqRWp3MzBQbnFNaTlpb1VFazhIN2Ztc3M1QWNRbERXNEYwcGREdjc2T2w4?=
 =?utf-8?B?UklYUGc1UG83SU42TzVhVVpFQzE3bWw3akVCVmxKMjNiTGxqYUt2RnRUYkln?=
 =?utf-8?B?RStyUlFkSTF2T1U3WDBuUnpCdVJtMHlod1JEWFhGZVNQcUxmL0NPRURuU29U?=
 =?utf-8?B?YmJNanAyWHd1NjFnNlpJMDV2Nkk0V3lyT2lqd094REFpZEpuUGRvYU5sMW9t?=
 =?utf-8?B?NDQyYyt5RnE3VUVVckozMlEycmp2RHBEY2puUEpoYy9RNHdFRmtlY3hsVmpY?=
 =?utf-8?B?NnVsalhxSmZvTWR3ZXpOUmRlTUdhR1VUMkFkUkJFVHFWNWY3OVlQMzlYQmNs?=
 =?utf-8?B?V3h5UUtrUzZDSGFueEJLYm11dlV6SUpQTURtSThPVFMwbWEvVHdLWlVnbXRF?=
 =?utf-8?B?emVaUTJLelpNeWdNYnk2cjBEZnJ4SEJtN204YStScFZxSzJhMkVHd2o0cHhR?=
 =?utf-8?B?bFcwd0JkcG05MkRuenIraWNHOE9Bc1JLS21jMGhQUnFNd3hWZlR3VzFPaE4y?=
 =?utf-8?B?YzNqaFFVV0JxY2JYaGpGUktwemRVS2xkM2hBcHdoS2oraFBRc0RiMFdXY3g2?=
 =?utf-8?Q?aXEeRHGZFwWgz3QKzF97xlgFizh+LtpW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dFZzh2UW1IZklQRmhwVW8wbVoyWmZVR3JNc2FWSFRBNTNMSzV4YWM5UjJh?=
 =?utf-8?B?b2J1ZW9GMytnSTcrejc0NEoyeFBsaUhnK1ZXNjg5ZUU5dldaU01Cc2F0Q0RZ?=
 =?utf-8?B?ZlFxV2srNWF3d2tjVCtTa3lpWTdnVFZtOG9pMnBMR1RIeFpzV0VpQ2Iyd0U3?=
 =?utf-8?B?S0tOUzd2TllLWVZKN1hIY24wcjRVY2tJYmhXdzA5bXlRNndadUJBN21wL1Yx?=
 =?utf-8?B?OGZvQklTMjd6MGhkV05yam41VWtaN2F3ZDFRU3R2blhBNlZCSCtVNjhYdFA2?=
 =?utf-8?B?d1cxSnlnZzZqWHRyOGlpNGlFRE1KYkV0d3kvaVdpYlVLaFJYRUREbmY1UnpO?=
 =?utf-8?B?REIyTDFyamUwQXM4OEY4aWhhMDNQT3p3b3NCSytsK1pLcjB4blU3S1A2c2ta?=
 =?utf-8?B?THFhODUrdmFXOTE4T1JGekpZUUhRMUpqWEV1ZVdOWTh0OVo5OHlsUHFwcHlt?=
 =?utf-8?B?S3AvdFozWnczQXc0RkQ1QmdBRVZmYVB4Y0VqL1pBQUlGTnRTQUttZzhWSDJV?=
 =?utf-8?B?NjlXaFVEOUZFK0QrbHFxcFkwdW56TisxQWVCNmpETXd3SFhaM3U2WjhIREFn?=
 =?utf-8?B?aE55ZmhSU3pUbW1jNHVDek1qNTgwem1UVU5aTHhFS1FIQzJycmtpdjFDeHRp?=
 =?utf-8?B?eGpTT1REdHV5MWNsUWZ2MStNeXZJbnh1b0UybGw1RjlUQXE4RlNlT1hrUm1H?=
 =?utf-8?B?c0c3TUR3NXpXY3JYeWtIaFhYNVJKNGJhUUZ5WmhYL1g3ckl6ek9SNTd1Rk1V?=
 =?utf-8?B?OTFSY3NqSDV2U1VpOVFBaFdDWmhnenlHZFE1aGtOK28zMjU3UTZpSlVvUVM4?=
 =?utf-8?B?dzR3STdITm55ZUY0MHFDdmlGK0hCRFhKYnRRQzI4YTNnZi9oczN4WDdNVVJO?=
 =?utf-8?B?YTd2OC9UaEpwLy9IMzVkczRDVHdUUWxid2prMzY1aGh5YnN4UjBWKzcxUHlD?=
 =?utf-8?B?WG9PdXYxY3k3U3lrU1FDNGtHQ3c2RzROeE5hM1QvQlBtcXo3VFQ3NjR0U1kv?=
 =?utf-8?B?NFJPQ2w5bW1rTDRCMzNVeDJ6VmFaZWNXbDFxQU5GN3NWOTNtdjZjMUczZ0FV?=
 =?utf-8?B?SVozdnVYdFhrb1VJZmhjcjYydzMwdC9QSjNYRG56U3VJRktrT3kxVDFyYjRH?=
 =?utf-8?B?YzdFOGtHamp1TFRIZVV2WTJiUUt2SEE5a2tGQXpBQnhQTFVDT2tCZ3plKzlo?=
 =?utf-8?B?STNCUGlEWG5BODc0NGZ3S1dmNWJaNXVuZ2g2T1FXcFEvNTEzWEhQeXF2d3M4?=
 =?utf-8?B?Z0hQQnlINkgyc1FCZkFBeUxBZTE2cjE0bHdKRHJiNTV1bjdabFlPTk5vSDE3?=
 =?utf-8?B?bnRGTVFjYzNBeWR6dCsvU2lkQzBsQXNSbDM5elRqcjRPWTM4bjVyZUtpVUVh?=
 =?utf-8?B?ZEtGL2JDTm9xSFhmRlhWS2tydk5HSUM0R08zM09OdGpBcEo1UTdGTnBncmJ6?=
 =?utf-8?B?c3lCdHJkVEY0SWVtcTQ4c2UrYUUxZjUydFpGajFocTdjQkd4dnVBdmcyZGdY?=
 =?utf-8?B?K2grdGt6S3I4QzZmWXVYdWwvUHdaUVE2bTlJMmRwTkgwdEhMRFVIdG02YXJ4?=
 =?utf-8?B?blhvRStzK2p6cmMrbTRITDQxV3BZTDVBOE91RDFDTThDSTFxU3hlRzNEVDdt?=
 =?utf-8?B?Y2RwMURhL3h4WDNWRjlaT2JKNHVWZDgzenNObWVGenpxZUlWcGY0T2JiQnpu?=
 =?utf-8?B?bE1aYTNlZ3RLV2tXRWtSRklCZEJPMG5qQTBib1R5UUYvMkZSb1hGdDBseVA3?=
 =?utf-8?B?YVRZZDl2Snh5OTcrdGl2c005d0RIekdpYVNHV2piR0FpeWxaV3VWN3liS2Jv?=
 =?utf-8?B?enFCd05RSzBEbUFDRzZxL2NYaGJvT0EvN2ZWMk1qWGV4VkI5YVZqVkxhb2Nm?=
 =?utf-8?B?YjU5aVlXOTF6VkhLTzVPWlZLZzVTNGdmYlIrQ2pPV3ZZSXNDNENieERHMjBu?=
 =?utf-8?B?YldHckRWMnk0UTE3b3Z1N3dwY2QrWlRPeEUwemUwaUplQkg0dTZXeVlETmg3?=
 =?utf-8?B?SFl5NVRHam1xOFM0eGU1WFBwdEhYZG9oN0NkWFZWbFlvOW1MTGN0UDBqWGRn?=
 =?utf-8?B?dlBOVFFEaEpmL3FKUTQvU0xOWU40cVdRd1UvRnhIRzluL2hZalc3RkZPdlQr?=
 =?utf-8?B?OUtlUlRMejZ4NU9kdm9GaDVJSWxHQ1VMaVN0bElzaDRmbXpsY2IyV05PaW9T?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1650aaae-693a-4e7f-d6c9-08de1e183c4d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:10:57.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBslQeCtPPtOGCSdZKx1czyhYQBFpLFfMIFgwS0yr75ty6PRS5gmKwyAvm1RqhTUfgK79bgKBKn4XCutS4kBH+VkFei0rRugMMMjMntrHkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
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

On 10/17/2025 1:06 PM, Bruce Richardson wrote:
> The pdump main function modifies argc/argv before calling EAL init
> function. It needs to do so in order to add the proc-type=secondary
> flag, but also adds in "-n4" as parameter. This parameter is unnecessary
> and also causes duplicate parameter errors if the user also passes in -n
> flag on the commandline. Just remove this flag.
> 
> Fixes: caa7028276b8 ("app/pdump: add tool for packet capturing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
