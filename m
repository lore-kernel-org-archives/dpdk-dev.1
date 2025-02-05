Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13306C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0DE540270;
	Wed,  5 Feb 2025 18:46:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6912740261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738777618; x=1770313618;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=MWpQLsYr4TMGOAVNtjJ/EpFlgECucHV3r/b+SRqYQts=;
 b=jvTLHfR8h0LZSywbAi3n5VggRjZY/gOwkVzonN98xDwo8giQyym6z/DT
 UoCXOdzfr8nBEyyf2YRBmYT/Bhobd1EpilFuVtMkyLCoUiP/REPYCKPU+
 vH971d3r0g0fuElv1mfLRuRnNt8NQlwcBh6ZorlasTsqWFqZ6ax5T2jVL
 lqLBAeVTBcRAOglkVaJHSALnEQDXDFiI+AxGiEB7Xjw3xiRxLt0obDTg1
 /0HQgZoON82uuls3HIy2NdC4dFFjrWYN9+hiekjiSaVyEbHh9rcxv6fh2
 OGDbrjtXQpB3rNtqZp1u0saz2RHPjpe1WTa99QTgIhLM9lDLCIQlhXscd Q==;
X-CSE-ConnectionGUID: xeyzz1dVT3eTXk4z+tY2lg==
X-CSE-MsgGUID: Gf461+71QqeHq2h44gd/YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39470951"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39470951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 09:46:57 -0800
X-CSE-ConnectionGUID: Qgi88DMrRPe/ldszC/bgog==
X-CSE-MsgGUID: nGhiEuD3QgmqEzXDfSiDXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115045256"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 09:46:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 09:46:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 09:46:55 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 09:46:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWsvr2UFF7QppMYuBmf431fRcj/PlcPQmodF8fXyZ/J2PpWgV6/qV9GWcIVxHoOCJfP+B4lA46SvgJVJr+uGgDKvCV4TbBWDQOJkCieWWEK2oN/ZTx3nEoRUzSm+7mws8uFpO0HIrcu0Md+zVQcvQuuU3Q+XjFfuvDz/XUrbS60327XmKsygUF11RZCdTM/hPOs04K/mK6G99zpox1B/czXOoYtHXJ6bZBd+JpNlGgB9OYJlg3TsvtKDOnxL+BXntJ7LIitiycmNO77U4JKckhqKo0qEvov6Std9oDtf/BRTDaqsp/K1xyq+2VAbbhdITU9L/D1YhdsgLdkZOV2m3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDx4U8sY6RZzup/lB84Hfi4r5DJ+83HPtymBN8qtvXI=;
 b=XTLMsJTxlMStZ3BK72iW6FvUNsOq4Zfzb9f39SJtl6G1pGIey9HQAYCzM5ZOQiobuDLJZSugPXagdz4cr2Ua+bQF8j9Pd2cvdWSM9avW9PDmYmKoNs+B0t+NxEQRBEsajiZ7D/LYhqFxj+FCDLpI2uUZUJPlg4MS68U5tKK+hwAQt7mWnkWgCx6KMhSy84D/hUbRrLw1RmzlKFwXZ3N3cJ2BK67SlP22JupeOkwSp1gsamgEBk0m/molzFcnau1cWaY61CDcj1XsP5I3v6jJuqnMT8jwLQXST0oBE5kdvcgtdxG4D3q/hG/hbuonBFUakgUBkVWDtZIVdfugm5MOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 17:46:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:46:33 +0000
Date: Wed, 5 Feb 2025 17:46:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <ian.stokes@intel.com>,
 <john.mcnamara@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Shai
 Brandes" <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, "Ron
 Beider" <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>, "Wajeeh
 Atrash" <atrwajee@amazon.com>
Subject: Re: [PATCH] build: remove support for icc compiler
Message-ID: <Z6Oj8k4rXFMcRLZE@bricha3-mobl1.ger.corp.intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <CAJFAV8w1ROF3rGGyrpDWokpxZT+tiG1vWXbfwFemqSYzt3vPBw@mail.gmail.com>
 <Z6Ogm56u595MFQem@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6Ogm56u595MFQem@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c00768-74cf-4cf1-7ce1-08dd460d07bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clhOWHNad2MxT3NlVzZzalJBNERqR21TcHJncmVPanhxcEJBMERrQ25pbkY5?=
 =?utf-8?B?UVZKYmttS2xIbmJQM2trT2MweFZzM2EvVENwSTdScFZ5d2xua2ZZZHYwVExu?=
 =?utf-8?B?MVFINFhCY2ZjV0dJYXlIaStYTHRmTmRrOWdEQzJoYkNhLzk2U2tpb3Y4bFF6?=
 =?utf-8?B?M243SUluVkZsZ2ZYbFRGdFR4aVpSQWpJMXp5WDNZM25KSEhxdEdQdk5RUEs4?=
 =?utf-8?B?NTVHZXBWd00zOUpRczBscEpXUWZRYW1JZW0xaWxMOXpDd3VCTU1WV2tTMm9U?=
 =?utf-8?B?VHZXTVB2V2JPNTlwRzB0T0tMeXV2aC85dU8zSnJBSlVURkVoenhnRTBHSEF5?=
 =?utf-8?B?dmRwZXBzUUl4Sk1Xd3Ntc3NuNEVWQ0lkRmtLZWVkdmRzcWNEOW9SdUV2Mjhn?=
 =?utf-8?B?R1JQODlxbHJVa0FIbWYwL1M2dURETVI1T1ZNRnIxeHVxMkJWTFp4Mlh0NCtF?=
 =?utf-8?B?Smd2RHF2cXhVRjVrdndiN0NuQkZsRElSN1RoeW1BRHF3K1NGdU11ekZnSFVT?=
 =?utf-8?B?S3hrMTR3RWZYaDg3Q21MOUc5L20yWnB3UkUwSTI0Sm55b0crZkhEMG50d25O?=
 =?utf-8?B?WlVXZjNmTWJ3MTJDNHdpTkJMejM2dFl1bFNKNjZ2azREUXBjdkc4WVpHK2F5?=
 =?utf-8?B?VWRkK2JJNjFVN1E5S0gwbHRBS0lmU3c4RWdrWko3dkhNYzhGc0h4SHRwM2pL?=
 =?utf-8?B?eUFYS1BBdUhWYUE3blE1QnZ5ejB5cjdxN2NVa0o4MHdkTmw0dVRHOENvMEV0?=
 =?utf-8?B?Q0oxbVlVanhMNUppL1JZQTNhV0Z3MnlWOGNpOTBvOVA4TmdaQUY3M1d1bGNl?=
 =?utf-8?B?ZjNnbDAzYVFjdHprbEwxTzBTYkpmMjFEQmtuTkZlMlRDSTJJMGpybm05SWJE?=
 =?utf-8?B?UDNIbEgzbjR2blNrdXFqa0FiTUZaSmNVN2R4MUhXYUhtS2doWmppVkt6S0JX?=
 =?utf-8?B?RXJGa2dycEpNYUNSZG04VmNpRFRtQTllaEJ3QXAzMVhVZGh6TnIzV0txVTQ0?=
 =?utf-8?B?VWRpZWdPZ0hQajhtcEFNODRJaEE0dWsvZUh4NWxHeVJxZnZ2SDRJV0x3Nzcy?=
 =?utf-8?B?eVJrby9OZEtFeFRSSS9kVTFna1RLREl4bDB0VmFsd2VoUTNGQ2ZTRUdWNTJQ?=
 =?utf-8?B?RjlZTGRqQ21WM1kxM0kyTGVuajdmUzJjVFJrUk1pWE5Md2szcGE4NFlmMXJR?=
 =?utf-8?B?WElsQVVoNUpmSWlOWEUzUkZUaDN1Zmk5RS9rdzYza3VXY1dDZ3VMRXFmMFhn?=
 =?utf-8?B?L28xejlBc01FemZHbXpTc1JDbVA3bDVESnBDN2ZJVm1CNjlRbk8rSmFlZlA2?=
 =?utf-8?B?cHRVRXFqMGhZZGZMRUpPd2drTU4xU1ZFbFd4WmRydWZJVW5zbkw2c2dQQ0hP?=
 =?utf-8?B?OWU1bHNTK2tBclBkWHZpSnljL0owcEVRY3kyK2VvNEozZHJTalJUZ2pRWGJ1?=
 =?utf-8?B?VkZDZHZuQXJaOUZXYUl0eWNvYkk4TWRtQloxdGIxdmhBYWpEZndrVzZ0Ym1t?=
 =?utf-8?B?SGhRbHpmV0c5ejN5ZFphYlB6S25DSXpEN0hZdmxybkJTQjNTWWo1eGdqZndB?=
 =?utf-8?B?WHcyZ1ZsangwVlVwcGVUOGErZFFqOExPRjFNRXNlYzRDWjBFL2tiOFBmODZR?=
 =?utf-8?B?cmhET28yb1k2VW8yN0w5ZWUvdllHQWt2aVVvL2lLbmFMR1FmWVdGZWhIQ0dm?=
 =?utf-8?B?d3VnYSt2RWFxakJSMm4xSlAyMzJkSlVzc0s0KzlrWUxIekFUSW5xU3Mxekoz?=
 =?utf-8?B?RDJrUjRMZWluUHlHa2s4Y2h3U0Vpa1QwTkxnWVZSUGxsOUxhcGlOMUtyRStF?=
 =?utf-8?B?QVVoOHRiYWtWMHprMkhGU3ZRemp5dUs2eFpXSHovcitlSG0yNGtXK0F3Zi8r?=
 =?utf-8?Q?rw6yO2iemTAy8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVycjh6eDVwcDdpQThUdkw1Wk1tMWduMy9Hb3c4R0JZOWkyZFRVSXo2SWVm?=
 =?utf-8?B?RFZMNUs3VDl0cTFkM2tmQWVPOHg3WWFucEYvOVNmK1hpVFdtVzFQMDU1WFRk?=
 =?utf-8?B?ZmNIZkt1elMwYW10TTlCcVRHd0xLaXJPbk9NYXRCekcwb1IrR2l4WFc3RVFu?=
 =?utf-8?B?cTUzbWV2WEIycGo2Rlc3RHpTdUJVWUtnMWxVVXNTSHZYTjUxOXNOUENYaHpx?=
 =?utf-8?B?NVUwTXVOd0FsWFdmUHIzck5Sb2ZZUlBkQldvSHdzNHRiUDN4VHlyTnQ5WFBY?=
 =?utf-8?B?NnJyWFZSRTRpd3NsV3BuZkk1RWtaQXB0U0YwV3RkMkN5S3NRelZHYWdHWkhr?=
 =?utf-8?B?UE9OanhoZHpQSi9SOUFTUDEyUlNqRnFmRHh4WWdWVE1ucEMzSGVOSk14cEhj?=
 =?utf-8?B?REg3NW9Md2dNckZyY2czYlFXOEh0UUJ1V25sUlNLOW1odzEyQzBTT29ObE85?=
 =?utf-8?B?MmcxeWtEbjlJb1ZwNGRSK2hyS1JlQ0JtNzg3MC95eEVRcUdQM2RVRUc0Y3gv?=
 =?utf-8?B?Rm1DZFQ1RGltb0RVUyt5WElkWU5Gd0xzczVnL1lxSDBaTVVvY3ZWblBrdW5p?=
 =?utf-8?B?UnRaQm03Y1kvWWNySG8zU2YzaGFFUTU5SVVWemwzaHRxaU1RN3p1UmJvVHN6?=
 =?utf-8?B?Q21MeXhscytuckNHNnFWaDBGR0hJT3pycmlNUWMyWFVMVEpGa3ZncVkySDR6?=
 =?utf-8?B?TUVkTmZZRnZvS1VJdThjaXJzR20veHcxZkx0TUxQZWluNnBEVTIvMG1HMFl4?=
 =?utf-8?B?cjlScjU5bytQeTZTYkN2OUViSC83YzVnOWs5dThWeFB0NU5vRXpzVk9wRjIz?=
 =?utf-8?B?amRPRUdvejZXZEJzRTJidkVnYTlLQWE0RmY0VjRtdkFpemx0WmdLQ3BGMVAr?=
 =?utf-8?B?K2I5VDNPWUkvajg3SmFaWlJ1ZG1Gd2lFdlpSQmw0RTUrOEVPVVA5Y0RVMHpa?=
 =?utf-8?B?UnM4cmdFRmt5R2hsazNYZU15bDE0cFlXMEdWMExWejN6eWo1alFPUTBjd0Ra?=
 =?utf-8?B?bzhZMDJpaXk4MlJOSWwrN1NiV0drTDdaUk9vU1RRdlYyeVdaN3lhZ3psTTF0?=
 =?utf-8?B?YjBHOE02d3VKVFFVa0RydlpteXJZZXJreFpQUkF6d0IzY3R5T3U4NnAzbUs4?=
 =?utf-8?B?ZW5TM09iS0FkdmJVeEdMV0lLZ09CTU5GRW9nVEE0RXJkOWZYR045NlNmdUhR?=
 =?utf-8?B?S3JEZWdlSlRUK29qTkdYT1RxcjBNWDJYS1BqVFhwZHdGWUdldkdkTnNOTk1p?=
 =?utf-8?B?TFlwMWZyb3FUWUI4blJMUHVxaXB2VFplSVBVWGxzK3ZMVTMwVGM5WUp1czR3?=
 =?utf-8?B?OUY3M0JwUGxESFdhbWdjclNFZVF4ZTE3amxpTHpoOW9kVWl6TEJHejlyZThD?=
 =?utf-8?B?bXZJM2c5MEQ3Qi9jUGFyK2JWQkpJSy9pS1piZVNqbUFvaXZXeTlwOHp4S1lv?=
 =?utf-8?B?MStGSjBnSGYydlFuU2FHSXlmdEl3cTBZSitNQ0dYbjk5U25QZFJVeWZSZVFZ?=
 =?utf-8?B?OE8rNVVpUmFISXdLMDRUTWRxWUVCWXByYTlVSjQrRVluQ3A0bklyODFXRHA3?=
 =?utf-8?B?MDZ1RUZqQ0EvN00vZkQwZjFMVVN2RUFwdkIxc05wUCtTK0RoNThsWStIQlF4?=
 =?utf-8?B?SDRKNmhSbGdsbjlGYVB4SXlSaVBmWFcvMGxGK0tqcGxnSTFQNGU3VDUvTzdN?=
 =?utf-8?B?U1hGV0tOYW5DcEZZM1JVVUVyRkt1QVo3TWxyUkZHNURGVVVkTThUWHVvb3gr?=
 =?utf-8?B?Y2JyeDg4enl1REhUK2Fyemc1cFVTeUJpWUJnZkVDRVA2UGhQcTh0bXhqQldh?=
 =?utf-8?B?SjdiM1VWQjVMTG5TS3EzM1pPV1ZIcS9oMzhFbEI0R0I1Vk5nbitabmlJRGE1?=
 =?utf-8?B?emR0NzNIaWV6SmxHQkpXenBlRzRGcnBFMjdDSERnMmpvMVZkaVM5UXNSbkkv?=
 =?utf-8?B?TXVVUnpTVzhCcVdhRG53YTV1RjM0L1c1bFFsOFhHTzVDaVdaTWhaNzFSak4x?=
 =?utf-8?B?dkFFVlM3aGU1SVBqU1MxNVgrOHBUYXBiZmkrTUVuNVZJdEhFeTZxVFB5eFFs?=
 =?utf-8?B?d0pxRDdTZ1h4eUNmbE9EbUpaUi8zUnZ4cGRPTDU0ODFCclF5OUYzQWRydEdQ?=
 =?utf-8?B?eHdvZnAvSXdmK09meEdZVEIyQW1YSXBsdzN5SVlXd3pIdUY5WkoxdkxxVmky?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c00768-74cf-4cf1-7ce1-08dd460d07bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:46:33.6695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQbw0DN7gAX/kl+1LARiLxs08g3dQncW2XrgIUKgttJZrvU3rn+wbBTUXMC2+/Xm79y2Cimvj0P1sdmnwLycIZnzViPRCRsNmxmAXMa7X2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
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

On Wed, Feb 05, 2025 at 05:32:11PM +0000, Bruce Richardson wrote:
> On Wed, Feb 05, 2025 at 06:03:16PM +0100, David Marchand wrote:
> > On Wed, Feb 5, 2025 at 5:19 PM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > The Intel-produced compiler "icc" has been replaced by the newer
> > > clang-based "icx" compiler. DPDK compilation has also not been tested
> > > recently with the icc compiler, so let's remove doc and code references
> > > to icc, and any special macros or build support that was added for it.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > I noticed remaining references, from which some can be cleaned up too:
> > 
> > app/test-pmd/testpmd.h: * Work-around of a compilation error with ICC
> > on invocations of the
> > 
> 
> Yes, I spotted this and a few of the others too - but forgot to reference
> them in the commit log ntoes.
> 
> The trouble is that for a number of these cases I've no idea what specific
> part of the code the workaround is, or what it should look like without the
> workaround. 
> 
> For this specific instance, the ifdefs in the testpmd.h file just refer to
> GCC and non-GCC (presumably including clang), so it doesn't seem that there
> is code that is ICC specific. Shall I just remove the comment?
> 
> > lib/eal/common/eal_common_dynmem.c:                     /* to prevent
> > icc errors */
> 
> Same here. It's not clear to me what way the code should be reworked if not
> supporting ICC. Again, I can just remove the comment and be done with it.
> 
> > lib/eal/x86/include/rte_vect.h:#if defined(__ICC) || defined(_WIN64)
> > 
> 
> This seems as miss on my part. Will fix in a v2.
> 
> > buildtools/check-symbols.sh:# Filter out symbols suffixed with a . for icc
> > buildtools/check-symbols.sh:# Filter out symbols suffixed with a . for icc
> > 
> 
> This you may be able to advise me on. I assume that the icc-specific bit is
> just he "&& !($NF ~ /\.$/)" bit, and not the whole block the comment is put
> on?
> 

There is also a reference in ena driver, again, not sure what the correct
code replacement is - setting the struct initializer to {0} perhaps? Adding
some ena maintainers on CC so they can comment on this.

	struct ena_com_create_io_ctx ctx =
		/* policy set to _HOST just to satisfy icc compiler */
		{ ENA_ADMIN_PLACEMENT_POLICY_HOST,
		  0, 0, 0, 0, 0 };

Ena maintainers - any suggestions on what the code should look like if we
no longer have to support the icc compiler?

/Bruce
