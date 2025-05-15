Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A43C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA840402DC;
	Thu, 15 May 2025 13:11:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E72B040289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747307473; x=1778843473;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YQsR5+Nn6xYdART6MS2snhe5C3IiM7J4PTlH1V7M/4g=;
 b=ALI2UvpF/K/Y1ZAW18z55+WN+GB1p04ZsKCWhUskNgvB7dMVWpPjvPq7
 LWRKyJvUzoILg9vqYx/X9oA7Gu+yTBC+WuTUyWbE9Fc3l+DnLHaF2xr1G
 NmhyM9mHnrYbGCIiJiRllRO3fYUHPngdVvoJStbah3XzFpPjuabuA48Xh
 e6ws+ViZE1vUv+4XKk4gttUyhtVig5rM564i5a+bvRC8ah8IhKNqDwuH0
 iFlQ/ziYRIkF4GjZhCOqe44MqHzVIMDezx5bsifJmf7Pq4IeWgCUvwxQh
 lqYpszHbI0jIw/BrtDbpNLjNqCmfqRSQ1RMUqPqFY7uyjhBlZDKR70Ckq A==;
X-CSE-ConnectionGUID: oronuyBIQPe0ZIpESbgTLQ==
X-CSE-MsgGUID: iHQdOLS3QgGlv8/3Icrg6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59869887"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="59869887"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:11:12 -0700
X-CSE-ConnectionGUID: qFhUDGCiRFa/Wvca82j9Ag==
X-CSE-MsgGUID: pZoF+5xgRVCCHefV3rV9SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="139332078"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:11:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 04:11:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 04:11:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 04:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0dm9tgSvSNyhVSdJ0ro707A2Mqf0ZaqzHDY0v0Vw2wXi3i+fNDA3fIc0nJQAaVxnlDvKdDaytqMVpmU1jWhfRyu0g8rAPY+5dF/FB/izmBsxpz+hVv1rbP/i+aznn4Qg8u2NsvAyzLGv0h4z6uCxT1eyEmEyTByBo12+Ew60i6X4n7km1WWpcB7aQK00+rGe9hYqE60krJBxwAsX16rewz42ssHP+4z3zq6IhLfGrNy4o79StVEB2ZGbSN1EdS+h7VZ1Otn5v2fJkRTGx10+ROcPlCoFnZcORRj50EOb3TPsBmXZY/smEHC6u6hGeF3+nqyTf30QHI5HdmSLec8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YYyzYuDDL3V4wdKZVCZOujwcJZct3OnymeUb+sx2C8=;
 b=OXDfflW7Nlh215F8OF2T8/R1TZuUEe60gxpoSqSMr9bEuosJMNDCAyn60YYEALeEX5Z1umcjr/I1ppYciyeHrIY/7VDpp1vnQzCnSpPt2IKG576h/ESAv//+oDasvIVSsFawFEVpV0eHFAs0cwKzLdGLQUYb/8GQqJWrkULZIJP/RaZXA9A6OaakuCwtEPImmtQHvxMN7YLwer8hEBC4/GcMXvBwbRlBdOuFuxpEO+FVsHSjn/qZFIFbq8pbyHUHUmDtzy301h/KTB/LmnPLq1VH/3NIAhhSVuAWxF66j+aKJ087WrL2VKxyXjVrbjq9YNjack21OTcCEIAZkqwfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Thu, 15 May 2025 11:11:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 15 May 2025
 11:11:09 +0000
Message-ID: <6cfc5dfa-a693-4c69-b048-3da1d0169645@intel.com>
Date: Thu, 15 May 2025 13:11:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] net/iavf: use the common Rx queue structure
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Ian
 Stokes" <ian.stokes@intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <85efadfaf90568018e15c47e810c56b693d4a4cb.1747054471.git.anatoly.burakov@intel.com>
 <aCXJIo34sEid9hC2@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aCXJIo34sEid9hC2@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:10:234::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: c510ce51-ed2b-4f34-e7fc-08dd93a131a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWRKRWlTbWdYaGJzdzhtczRUNE1sd1lWd2VyMHB6eE5LZ2VSQVhmTUxXd1hs?=
 =?utf-8?B?RnNlc3VYZFV4MGNLSXVVZ1lLVnNpUXRnUkxFc1VHd3VBY0dNWkhWWFhmRmRK?=
 =?utf-8?B?TDhVV1YxOE1aQU1TdXFjcFhUNnV1TXRxNFl6a2k3WmlYeEFRTU9ISDRXbER1?=
 =?utf-8?B?KzVSY0JkVUN2L3QwSXZXeE03RllMMVdLR3BiMjR6SmExRDRnT3g3cjZCeFU1?=
 =?utf-8?B?T3NKckV3V0RzSFdxa2h6RDFXb2tvcFYxVWZDN3JUcjc3bXY4cEpoRGo1M0ww?=
 =?utf-8?B?QUVFVUhLN2trMS9kK1NISmY1dTNWNzVRQmNKNjN0WVJ2eHJDcHhQbkhvbFpw?=
 =?utf-8?B?eEpzQXQ5bDJ3TVdZdWJpcDFyVS91Sk9zWHd5KzRpZUNjT0F0MzBtQjd0VC9n?=
 =?utf-8?B?ejhySmhQOGRrWGQwVzZXN1IvQkRYZStOSWh0eStFUUQvZEtVQXBkZHZyeml0?=
 =?utf-8?B?Qk5FeDVpN0pyb0FjaWM0eWVyc2I0dGVSVlNwK28wN1dpVFBaeExmaiszTW5l?=
 =?utf-8?B?Q3YvK2dIMjhHSVB4WUtUejlyWDlOWjZnSTZibUxDaXBqaUd2eXlHekRqaDh5?=
 =?utf-8?B?d2VsR0c3b1k4QVBURlBnQndRYUk5eFlSbXZTR3Mwa3VDT0xzWUU5RG1COFor?=
 =?utf-8?B?R1gwbmRrWmMzTGZnQVhYRzlZR25ROHp3Y2hNYVd3Y1pGV2ZmSTdWV242SXpP?=
 =?utf-8?B?ZFF0blBZWEdveEdHak5HaG5BeHZnN3l6YzVDYURpSnhFWFVlVHNqd3laUVJE?=
 =?utf-8?B?UU5Qc1loSWJySEV2TXhCK284TFg3bGwzTlVmbjkvTDFBVkU0cm1OQzJFUVNq?=
 =?utf-8?B?b080Q2Z2WE9TNE05ajlYZUUrUnRuNURpVkFwUWVBV1M3ditLQmZic0dnQ3ZB?=
 =?utf-8?B?QlRvclFiZ2RaSndraUJjc01OV1A2V0VDdVJaSHZsU0x5OXhtU2E4OG1xYUlY?=
 =?utf-8?B?a2h1QnhCdjZHK0RqSVJDdmpyeU1Udkp6RlUrL3REWVI4M0V1VVlKM1Ziclcv?=
 =?utf-8?B?aEY1aURpcE5jOXBuVi81amNmZ0tmeHBCV0hOWXh1cUxRcnI3b2tHNGpmTWZo?=
 =?utf-8?B?clpkQmpvTXNlSzgva2xZNW0vZXdZLzg1enRRRElvdTNEWlJBdmN2QlJjYjkw?=
 =?utf-8?B?RHYvMk52M2ppRktwcFNkK0dmWnR5ZnNOZ2tRTWladWdwbnFxYVZsekk1RFMy?=
 =?utf-8?B?VUJlNnJxVjFtWE9QVHhLdGJYWUxpZENEWnNnbnNieDU0MGk4Y3Z2and4T2tx?=
 =?utf-8?B?S1pZU1ZIOVYrcytHVFFhRXJSUXIycVp2ZHN5Z1l0TVczbWt2Z0dzajlxTlNO?=
 =?utf-8?B?bURIUDRTRFdaQWtQVS9WeFdaa0w4N0c2M2NiYytQcVo1cDJEODZnYjJhRmVZ?=
 =?utf-8?B?c0hzOFNPY2JxR25ZTkNnQUk0dy9yMzNYWHB1dmUzUGFKbzQrNkl6NFcrN1Vr?=
 =?utf-8?B?VU4yNXU1ei9pU1JYK3kyQTUzdHg0K3M3dXJuMG9JVEN2ZVc4WlJodHVpWVdK?=
 =?utf-8?B?TXBVdVVRdUZqQVgvZ3dNZ0tKeWQybmx6SjEwVnBOOStORHhoMWN6Q3ZjK2lE?=
 =?utf-8?B?RzhRVXgxbHZGUE5kZUlGaGJNekpsa3I5NFcwRGZUbE9ocnZiYjJhdm0xRzh6?=
 =?utf-8?B?QmRiZTdkTGFrTEwzZ0sxdVdnN1VuYVNoMUYzWWMyL1NkOXZmVVpseVFHNTAr?=
 =?utf-8?B?Znh0aXplMCtTcWplNFlISExuODViZmtEMkR2bW50QlVaZDByUXd4N1ZjV1F5?=
 =?utf-8?B?SWg1aFJRbmdHVHRPWk1kMFo5MVZHMUMwTDRFQUlTS3doT1BWOXp6S0Q0QVFT?=
 =?utf-8?B?bTBNbWJiSzg4UWgrRGNGdG9Fb2hRSThmNDFNRVlWQk01ZS9pRXlHTXBWcFly?=
 =?utf-8?B?dExYZVQwZTY1SzdNM2xKbE5sMWgxN005ZmdmOEdFV3BadjFUdmdOaG9ZVzdn?=
 =?utf-8?Q?CtN735iuA+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlN0YTF0aklpcUxnMFFiTFpJMDBjaWNSVlVQdm9aR2pYRUZ0bUI4cUEzYTY1?=
 =?utf-8?B?bFpCdW9MREptYmJIYk9VamF1TVc2UC9zbFR4M21XKzRGQ1U2Y0dldk5Qd2hD?=
 =?utf-8?B?b0dkVnBPbUVuY2RTUGNreUN3TXpybmJKQmw0aFV4aWRYbmpWOWFyV3lrb0ho?=
 =?utf-8?B?cklqZjNtaU5Cc2tqcFNVYnVQR21EdUhwL1A0TUF0S3RQR0RZeUtYSGpKQ1pN?=
 =?utf-8?B?cUxnWDFLbE5sOHRhV09aNEdQTVUxWDczNktqTkFNYTFsT01VQWxhTUY1c2ZS?=
 =?utf-8?B?MTg0L24wZUdWT1BSeG15QnFGNUdrTXhBTEVFL3dvMnNUZTdleXRLbEk2S1FZ?=
 =?utf-8?B?RXJPMnNRdHY3MUlLaXFLbmJJWEx0QTJxNlE3a2V2K2dJQVhaUGpVMDk4dDFh?=
 =?utf-8?B?ZmhSSnprK1hmVng4ZVZ5RldUcTROMHJVVFgzZmNwMUhFUEhuUEFhdlpxNCs3?=
 =?utf-8?B?YlhuVkYyMnJ2aDM1bjhXOUVKNTMvalFab1ZmajV6YjJJa29MUm9IdWhYY3I2?=
 =?utf-8?B?bEM5T0NyV2svUEdrZnQzWUNqR3ltWktzcitwcjhyN1VtcUd5TkxmdFBsandz?=
 =?utf-8?B?L2tnM3JidXpZRk9xckhrNm1MbnlYSEJQa1hQdWQveXhOZVE3b0NNdnVGbWx0?=
 =?utf-8?B?MnVabkhKc1dpNVRLanJaK2d5OE5HMVdRemdHZmpYY1ltNkpqRWFkcm5PQlIx?=
 =?utf-8?B?U3BpUDZCaGlrVG9hZmFvWDcrdFdnQjAxWUFUeW9OV2t4TzdiU0N5WWF1cERX?=
 =?utf-8?B?QzFXYjlmdHJ5d0pSMnZzbWR5elpuSlhaMnpXZERrakExcmVabDV5UkNwUURJ?=
 =?utf-8?B?Wm45ckpWQ0xNMWdVZGNwM1JQQkVPblpnQ3ZnVWxrSG5hemMveUkvYkdEVHBu?=
 =?utf-8?B?M0xieFRKRXdka1BFQUlOdk5WdEY3YUluWFJRdTFTZ0pid0l0aVIybi9IaHhV?=
 =?utf-8?B?Ym5jU3NycmViN1ZNR05TMllxS1lXeXNmdWNpbGI0OWNnRG5mMjViYVBYOWJK?=
 =?utf-8?B?TkVOZGNqOGdtQmhBcjVLdmxHMEtlcjNLbUNPMUQ0NnU5UXhKbGlWZ0dTRysx?=
 =?utf-8?B?aGRXY3lQSFlueFVtQWVhMTAvTmh5ZHZINmUxdzlLSTJRRTQxK0lEL1BGU0w0?=
 =?utf-8?B?dFA4K2wxNjJyTlpiYzlrVkFSSXNZdFVHdFgzRU0zQUhKV2Q1b2cxYS84aFlH?=
 =?utf-8?B?Kzc5dTBRVVI3QjN1WSs1ZWtMZXNURDE1ZUFYQVlTczNCNXM3bm4yb3dWeENq?=
 =?utf-8?B?bVQvMXNTRUVrSDNUcmVwdmVXbjU5V1JvS2hSRFlOWlhCaitoQXBaUXFySTBi?=
 =?utf-8?B?anJqNXpLL2lIVFlSaW8xTG80cnRJa3V4Sk5Za3hGSHlMWVZRaWo4OHhYdkVC?=
 =?utf-8?B?UGFGM3dkV1orVWwyY3BnTGIvbWpqWHNKNWtPOTBacit6MEp2Q09RRktRTW4y?=
 =?utf-8?B?Z3JyeG9BRnBWQmpNdnVuK1hXUkFwZHlwbFpEbXdKRWVqSVFXWjZkMjNPOGQ4?=
 =?utf-8?B?QmFXZVRkNFR6Y1Rnd2RTQmIyNTVYQ29IdWlxZTIzU2dnNjVyZTdGSUNuT0dZ?=
 =?utf-8?B?TCtlQ0tIMERMZFB6eVRyMit6QzNpazNBTVpxcWlnejcxR2RyNFU0YXlUczlW?=
 =?utf-8?B?bCtwUlZSWStreCs4N1VqUDBud1NzdUJ0UG9Na3VTY2NhS05HZW5qOTM2eGQy?=
 =?utf-8?B?YklnY3djZ0VVMk5OanQzczAwa3F4ZDRXeGxGeFJlVWlCZnBNKzZ0S1E4c2hO?=
 =?utf-8?B?eW5JWHpJUE9nWTVPVlE2bWoyU3V5T0NSUlhHaWZ6dkphU3VTWnprUEJONXpx?=
 =?utf-8?B?S3I3UU8xenRHa3dPaVZYUXdMVmh0M0Q4S2xzd2xDU3BSZllCcGk1VUhXUUlC?=
 =?utf-8?B?Skl1N0I4aXA0a1ZLMjcxY3Jhc3lEbkk3ODJzOUU3MWIrOElrZGhrWXlHemts?=
 =?utf-8?B?UkhmenBieGtyR0I1WGo5dW81cnkwQTdjaTZVUEpGelNUaStPb1FvVm1taElq?=
 =?utf-8?B?RUxTUldhSWJuQlNPeXl1eTVJQUhxM0JCdmU3b0ZSdHJYZUtDM2pPY2ZOYm1D?=
 =?utf-8?B?K3pIZXhPRVk2aURxR2dBd1FpUVRzN3dzSDhoZFMvSm0wWERhMlB0NnFBa3I3?=
 =?utf-8?B?UWx5RUJoajhGU29URG9OeWp1cUpvT0ZBYWF2STg0Sjl5MGlHdUZLMk5NbERn?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c510ce51-ed2b-4f34-e7fc-08dd93a131a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:11:09.0520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuEqIdspkI+NBRcqbn2MUYhMjK3yrbRFenQ/3KIpkZrzzq0lVJorWe3efNJFdTwPyTQ56T/FkInooS0mPuOqExjXKrhM9B3L2nJT/QbbHng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
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

On 5/15/2025 12:59 PM, Bruce Richardson wrote:
> On Mon, May 12, 2025 at 01:54:32PM +0100, Anatoly Burakov wrote:
>> Make the iavf driver use the new common Rx queue structure.
>>
>> Because the iavf driver supports both 16-byte and 32-byte descriptor
>> formats (controlled by RTE_LIBRTE_IAVF_16BYTE_RX_DESC define), the common
>> queue structure has to take that into account, so the ring queue structure
>> will have both, while the actual descriptor format is picked by iavf at
>> compile time using the above macro. Direct usage of Rx queue structure is
>> now meant to be replaced with a macro access that takes descriptor size
>> into account.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
>> Notes:
>>      v2:
>>      - Fix compile issues for Arm
>>
>>   drivers/net/intel/common/rx.h                 |  12 ++
>>   drivers/net/intel/iavf/iavf.h                 |   4 +-
>>   drivers/net/intel/iavf/iavf_ethdev.c          |  12 +-
>>   drivers/net/intel/iavf/iavf_rxtx.c            | 192 +++++++++---------
>>   drivers/net/intel/iavf/iavf_rxtx.h            |  76 ++-----
>>   drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  24 +--
>>   drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  22 +-
>>   drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  27 ++-
>>   drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  30 +--
>>   drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  46 ++---
>>   drivers/net/intel/iavf/iavf_vchnl.c           |   6 +-
>>   11 files changed, 207 insertions(+), 244 deletions(-)
>>
>> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
>> index 9a691971bc..2d9328ae89 100644
>> --- a/drivers/net/intel/common/rx.h
>> +++ b/drivers/net/intel/common/rx.h
>> @@ -38,6 +38,8 @@ struct ci_rx_queue {
>>   		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
>>   		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
>>   		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
>> +		volatile union iavf_16byte_rx_desc *iavf_rx_16b_ring;
>> +		volatile union iavf_32byte_rx_desc *iavf_rx_32b_ring;
>>   	};
> 
> Aren't the descriptors used by iavf the same as those used by i40e, and the
> flex descriptors used by it the same as those used by ice? If so, we should
> look to merge their definitions.
> 

They're coming from base code. We can do that, but I'm not sure how that 
would play with the rest of the driver and compatibility between ethdev 
parts and calling into base code.

> /Bruce
> 


-- 
Thanks,
Anatoly
