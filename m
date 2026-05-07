Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A35CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 10:50:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E2240265;
	Thu,  7 May 2026 12:50:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D819F40261
 for <dev@dpdk.org>; Thu,  7 May 2026 12:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778151023; x=1809687023;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=LNUkAMtwLHuUUZ/EaQ77dZ/elL++51mgs6U1KQ+RpOI=;
 b=PR+QG83GnD/rHAoKtaAkuuIAGuVZICRJqFCnsbQe6vkAAKuj28B6n4IA
 VqWafOHkfXufxFJsHzIotTlUZFACVV12fFoymIv8jFjqekzc6uA0nercy
 UEJKmI98RQDY4rxIKWP4Bckv0PxVpz2w3VZHTNyTEzfQv2srBHoMQWiMn
 yw71LocmoOa33M7OeB/QyL056w8dYpgFH8Fx5LxcEibu0ItsqDCGSVljq
 itRNFRo683MIuxEF0wGziLXi3W+rXz8Gf6kcV66sSm/Djmb8D6/039Tpq
 il4Inty9oGKf5o7Q5dMv0Kg8xEz5iE4ndaRtBcld4d4KfSjiPQd0Jznpr A==;
X-CSE-ConnectionGUID: 42KY2Vl1Ryqe1EoT1iyT+Q==
X-CSE-MsgGUID: lQnKOQODSnC6EqFCD60L0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79282526"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79282526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 03:50:22 -0700
X-CSE-ConnectionGUID: P+6FIS6uRhyqwX0X+KGNLg==
X-CSE-MsgGUID: LsL1OWiGRmaU9MF2LJMx4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="235429893"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 03:50:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 03:50:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 03:50:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 03:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzCfPOsfKlltDhqmdnRHjVa3lFMBvaaqwZbp4+ZYvrSM91th74lxjdfScn1gnC1tcFodfq40Dq4HGfkc74iLVU5KlkXSGqznevCHmfzgy123YHe3tGALurL7EMm+NMDNuN7QmeMoQOvYFFkeUV7ZuV7noBjX+upcUoJ8yO89zs4SlmCBxaMtsGy2XnHNeqPHXcoMP1BFFyxbH+4HPCQ9VnpQo9vwmZgMjCv0qtEITdRtbr5ZX/FqQX1NTDY7uBgVBACkabvs8h4UxDJjZtslpA4T5/FjWBnNz9UKu6qgQ2ZKiUypOjSATwqHIlvPdkf7U3ObPltmbFgZNH1C+PwFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNUkAMtwLHuUUZ/EaQ77dZ/elL++51mgs6U1KQ+RpOI=;
 b=D8SeliFDvE4+Ms/8rywODvAxUAeEuub7ByL4lXN8h5TDQWJRu9ziVjGpmNWuVyi2jdVpUCgstVtnR44ejB2xRQU0VkN7fDcOWg/pWHyHDi9VaCpq+v/soi2GXxSt1hLW1p73VsN+0aw+AlBwMtlqzzSw2e3spc4ZDt44ZYorltj4fJLD1vQMLbwbiG72n/bV7g1N/Fjyh5kcuogoIWzHjrcLdvW3r2g6l4iJBjQl58VFvoPwIYTTXdcXPWn6Ob/iORoqkRiwjsRdmh0ZXsapk7UikmALEIsEoJ/P1wijWOKsU+0sWBq8yL0D3XHvi2Hc4F3O+zdTK3j1f7EchfBuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 DSWPR11MB9557.namprd11.prod.outlook.com (2603:10b6:8:36c::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Thu, 7 May 2026 10:50:14 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 10:50:14 +0000
Message-ID: <8769c3b4-78cb-4426-b164-fbbec683e69c@intel.com>
Date: Thu, 7 May 2026 11:50:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] net/ixgbe: fix non-shared data in IPsec session
Content-Language: en-US
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>
References: <60ae27a2babb44f7a0301109728aaa2742254734.1777547413.git.anatoly.burakov@intel.com>
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <60ae27a2babb44f7a0301109728aaa2742254734.1777547413.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|DSWPR11MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: b96690cb-6a22-493a-b56f-08deac266adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: QwFmULpfhYWpVlm1y0wB7rcO6W2Kexvyue6MWb6JiHRg8tMdu3uTyNg9BFaY/5Wq8kAyUdc13XZFje36QVhWhD3oSNFrW54IutjIOtLELcdP3ck/3EtlRMQi7WLzUc0oT2N5lEUGXLTM0F8jy3xtDUgB64pxjI97btEr0CsZzuJfTZAKkpNDywhb7fHfFuYdPIl3lzb4txuzVSm5ya8ldgyzJ9aniy52P6Lsa/jChWCSKLnNfnJ3spvr+u/wsH1L9v2lnW6TJL9B5gkNaDzeo0a+auDH62d9IVDj+3KcR1Swl0w6L6BcUsMfxIErLDS23WaTuZaTXKamYF/m8OzWjFkPSM/4hlflOnO0K2f3iDFmlbn05r2KPpSOJ+jSGu1krfhlJV9ogtzsEkGBIXeSfY5svLygLyQ6vAwzQYEhYiNHj0zAcw799EAe3li9NWa78vvJ8eHoei4i9ThvwXQy70osA/UI9JQHAHtwBudo3Je8n2hv91Zo8BwEXq8vOTA6/nqEHE5HuEa5SJq4Jh281Uhri/hKD8v6WVLZljikAOgLaJUh7iDlzD19LgMKvu/pd+pOhmWv+MFgQHq5EBChLe+LdEl8WIvMQrw4DMs1RzkjlSgNhUfBvGfJR8ekKIBTDt2vxJZ3oWKwwUoXWu70rB+Club5yT7bI4tl59iCRnf1wJ9cF0vRZF341R8UfzYG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dxamxpR3hMQlg3SzlPdE5jYnlCUjA5R2xMeTBCNGVXVERLa1pmMXo4SWlY?=
 =?utf-8?B?czVQd1NKTitIckkrSWxIMys5L0dET3JoQ2ZnR2YvbGZDZUxhN0NmaUhrR2hH?=
 =?utf-8?B?cUpibTRsamFSRmQ5dXlGS3hPU08vOTJoME9ucnNyam90aVJhS3dCTERsWkFT?=
 =?utf-8?B?Zm1SQkdsMDFHWDZIc1N2L0xJTDRSNlMwQU1RTzBEem4wdnkxbEZzUjV0eCtS?=
 =?utf-8?B?ekx5RFZ3akFxaE9PVXdUUHc0QnNNNDZWRVpKTG5ibXgxMmdWbjl0d2tZUitE?=
 =?utf-8?B?enN2RUMzd21Tc3lLS3pZcFZ5R0J0d3RJR0l5OVhmcndEMnRGUEIveUhiQmxB?=
 =?utf-8?B?b2lFdXJmVXFvR0E0RURpYzNCOEQzUndpcHNtRUIzQWZjK3lCUVdleVMwVmVW?=
 =?utf-8?B?TElUTkhTWmlDL2hib3lYZEV3bGZZSlpWN1RnU1RVcHdtcFFmcVVNclVKR0hN?=
 =?utf-8?B?QVFrbXoxT1V4OFpkMWdFL3pGTDlWMVRsR3hJam1wN1ltRUhWWkhGY2ZrVTF1?=
 =?utf-8?B?REs1WGFaMVFDZzJ2blNOUHczQ0NEKzlCVG9SOHdUdXdGT3QwdE5KdFJsMWZ4?=
 =?utf-8?B?K2hJSUlBcTBtSUtydHBnSXpwUlpJSmhLRTRZZ1RDQlllV2hFYVFsK25pUmlF?=
 =?utf-8?B?UzU3VmZzL1F6eWpvZ0YwWDJZdFJxblVVUUR6Z1dTQkZXOU5hOUVyQkozOHNq?=
 =?utf-8?B?UUMxTlZDYlloR08wMTloakRrOVl1alFSRjZianBjQUNtbjdZZXhxelplNXY4?=
 =?utf-8?B?YVI5cW5RZHpkbXpqZ3EzOGdkVlBSY2V3K2ZCUWpGL1RJcFJIU1VROUZwbDNU?=
 =?utf-8?B?THJKMXBxcEV3bnNmU3lLalh2S0hyL2ppTTRxb2k1S3Jwa1FPekZBVDJWUkph?=
 =?utf-8?B?TGw4aUV3ZFRnaXp5T01qZFJ0WjVhcnUrRG5mRWlWTWZIWmVEK2lnV3F1bmhr?=
 =?utf-8?B?QXRFTTdydEIxaGZmeGpzaFo3Vmo5T0xXS1EyMmZuendHdVFRL1V4SGNUVjZt?=
 =?utf-8?B?RFdOMFVXTUVMWHpkSVV3TVNPRXUyZkkxbUxkL2xPUGxlL21FNU1xL09ZZ0NM?=
 =?utf-8?B?bjIzeHVnMXUxSG1jd1dxSGFlb1F0eWxKeDI1NHBTZlE3STdlRGx6aHM0M2VO?=
 =?utf-8?B?QUdhOGc3OWJBckJndWtHNS9Kb0NROGpDNlFYRGJaaWw5MlY0akNMZ2pZN0F6?=
 =?utf-8?B?R3dtZlI2SGJKbnpVRnAxOGQyT3VFMkxUdUFUb2h4UWlNU3VuTXQ4b3hDOVhU?=
 =?utf-8?B?aTZVbDJyNUJhM3h0RDhXZ2Y4QVMweldwSUtRb2lTWlJhM01hUHNQVm4rL1JG?=
 =?utf-8?B?bHNsTTFGeDdBQk9wdjdsaytrUk02NzNzRzdHRVJZWTlYZ1RhQlFxMHN3cHJa?=
 =?utf-8?B?SVlFWldUaWdPN2Rza0IwempmMTFIYmoxU0pXN3lSMUF3bnBSdnNBQnlZTkVa?=
 =?utf-8?B?aGEwOU1VZ0J4KytoUzJkOElxQTc2S0RoM3FpaXFLbXF1UldHQkV5OTFzbnE5?=
 =?utf-8?B?ZE54VjVlWmVWOWo0dWViK0Y5N2didTZLZ2V3YXE2cjY1T2ppUlNBaTd2WSs1?=
 =?utf-8?B?akVBY211UTIvRU1QTWM0SHJxa09seG1MekJaRktiTE5yeXhpNDlXcmN2ZmdE?=
 =?utf-8?B?Q3NXaUVUVUhuZ241RWNtMHZLb1hsM2hvaURtQTZ6SmQzTndVd3V6c3hVcjA5?=
 =?utf-8?B?bTNLclJqejc4RUx1QW1RdWsweXJzUElJYkhRR3U4aVd2ZmZqc3hoMEkyTlFp?=
 =?utf-8?B?L2Y0OTlTcVlKWFJRUnFzVVpwRTZaNjVwNHFBSzJLbVYzV3A5R2oyYTM1Y3dI?=
 =?utf-8?B?YnFQN3ZtNm91SkpIVHh4WGJYRDU2ZWZhQlRMbU9JaG1QMkZISkE3MUg4WFRt?=
 =?utf-8?B?QnV4eGRydW5TS2NlZnBDVmk4bGFZRzJ5a0VOQlpVVnV0N3d5ZnMzVkdqQjVo?=
 =?utf-8?B?RmU4Zk15NjYrVUNYaDIvcnJKMHpBVHh3ZE5VYWR4b2dkN081MFgrRVNaUXo4?=
 =?utf-8?B?TC8ybmhNMERnOUM4NzNOZmtCelNDTHhCVndwb3ZHdGQ5RjVPcnA2UmZBNWZ2?=
 =?utf-8?B?cGZVcmVDeEJlZmJtWlhsUzZRamx1T1hZL25oMWtmT2tnbnIxSXRpanE1T3N6?=
 =?utf-8?B?VURHTEJyTDRuMmlOc3RGZVUrb1JUYTVqTFA1WGthQ09Fek9ZVFo5V3lhSDJ1?=
 =?utf-8?B?ZUNtNnZWcWJTVkZXMWNsSEFBdGdvaTQ1WXdjTkd0dUwyMit3anFnOE5WbmRn?=
 =?utf-8?B?clF1T2Yrb1l1UDJIMm5zZUJ4dGdIRExOM0UxZ2RtSTExTG1PSktuZm94UkZQ?=
 =?utf-8?B?cWhpU09PYlpvRlNRQUM2cUsxMkZSTjJPc25vU2JuYWVCSThmTVdXUT09?=
X-Exchange-RoutingPolicyChecked: P5EgbcP3OgW2XEpgF3yITK5RyWdqcFiTksP7XEvdNrdJziUpW8pkVteIY734pvO5oRI+I8JIhJsvUAFYxoMQKAeL4qBIMGJFvvhUAeqDOYf5c4rS3iGmUvTI8nW8CxIwFPJGfbKv3gVSP9tgfwlJvglsMo5DdrbfTwUyUE6DyVT1gzLZMFV07MbQJyuPzlpi6sFxIFoVA8vngNqVh664/EfXdrRYq+TmErcqY31cXIvDn1N/g0aosemIDU4oiaJ6wTB0cN+Bm/T3BEtvsn0EZMKsZg3YVtN+l++z7IjyAx8WxfzBBo5NHBEso414M1ubJAHBr+1ZRpYK6fZeLbHRyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b96690cb-6a22-493a-b56f-08deac266adc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:50:13.9444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvPXbrkWyl64dTJ21rIdBP4sTBastx0Xf3U5grYDP79v/6YKYYcUXjoWuopg4bm8UBcb3kyNdZEhN0mZeYE+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9557
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


On 30-Apr-26 12:14 PM, Anatoly Burakov wrote:
> Currently, ixgbe IPsec session private data stores an ethdev pointer.
> That pointer is process local, but the session private data is shared,
> so a secondary process can read an invalid pointer value.
>
> Fix this by storing ethdev data pointer in session private data instead,
> and using it for session/device binding checks and dev_private lookups
> when adding SAs.
>
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
