Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA6C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 09:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85C4E40661;
	Mon,  9 Jun 2025 11:04:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7DD6A40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 11:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749459890; x=1780995890;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=59l5ZBe3geqQdg2DXJcEkMWNtGizx9qK0wop452icYw=;
 b=E+6MyYLIPKEterp0vM+McInHX1IMteIjQHC7KKoUDh4V331ucT/ppzPe
 c8j8F9nmPsAW11bE2zVgAPuJ/8Wfyt9eGSSkAs29qQYtFYBibAcEesmkG
 VbbGQON1nqJci0CWd1mCOjazucculvikuXznEz1IaJ0Hu5tXF6kxFGFZI
 uxLyFG+q/O7NL6o1ocjWEs1opppNtzBFA5vz6xTBJgGYKNLqxsqP70670
 mvZ9vumxbv2/O1Zw+UJL+oZ/DR0alkduhDTkhIMa6chY74OMEMTPTfNFQ
 F5P4VL1VGR+0KDez99bbAXWNoMXcEq+T1Fx/6PSDtYCSfHpa3a7ukzh93 Q==;
X-CSE-ConnectionGUID: Z+L3660ATK+/ptRKuUEe7A==
X-CSE-MsgGUID: dpTwlhAqTU+LB1k1tgNUog==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62931416"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62931416"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 02:04:49 -0700
X-CSE-ConnectionGUID: 4FHdx9PXRV28KC2uT2pMPA==
X-CSE-MsgGUID: gBotWqvXRKm3N9pJlH3tzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146446630"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 02:04:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 02:04:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 02:04:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 02:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLyyubNk0tPMlTRL+8XdyFgNwSuOlI0jgy+g52fSiCRy6Ui2K+WGiyIKd07nlYOyuW1Wk9lkq458VKjZQIE9tFOhD8O6ae6jP64VfoaTM66eo33+kPYXv7ciDWV0JtBoF+BXe4Z3F9I4ID14zWIj8iEeu00SWpBJq81pZ7LLTq1xtaL1j6mKeXEeGJy6+SqIGw0O/OVVImbjAmIs9MZDPd+TMR70aHuD7oF6Lqu4dZ+azmhsvqK2K93jfayDe7ZIW7ClGGmxzE78DG0kJxrTWGkn/rfEit6VKAWke4OmCtyOlEdbNeZ8xcCx8GfNhlCz8jpS4SO3qzFmWaG8VpAI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1Gw2VUAZ5iqwAQ1VZpYYICDcj8iGt+URcm6MKSpqr0=;
 b=NFITnC4+/tKKQQUZBHAFKlm3ZVbAx1FWt12M5E3qpwd2GhfWtELc+k+XF4GM+Wl/ap/16Ttcz35pnr2vHypykb9NENZi33u4aJ6k+rW7s8UvhH6cSUiBCnyQhqLOARrgPrxjTjpX7Oq2nLMA+x+5U8NsA3aHMCzqYO2NOqdHhFd6yMHyf/Lhqw27P3J2NcZHq4neslovYrv7fEIdL7vuO18hzndT7TuFjmApuo3+yztFq3xBbaloNzX8Tg9Reef6wOnEFOssI6ccUzCnZorM8iOSXr49VasATJ/OVOl0HlG0j6/iGDojrl307IFUIVdSwZxTw5IZgYJ8sWwtvSpZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 09:04:45 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 09:04:45 +0000
Message-ID: <a0493826-41d1-41f0-8b9c-b45c7894bb13@intel.com>
Date: Mon, 9 Jun 2025 11:04:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/34] net/ixgbe: add a desc done function
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <bruce.richardson@intel.com>
References: <75f2d5852f52e7b81b0036cb921e661edca8569b.1749229650.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <75f2d5852f52e7b81b0036cb921e661edca8569b.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0199.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bb22a4-603a-43e3-d181-08dda734adc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHFuSEl4VXZhU0RGYjdyVmtNYmxFenQ1d1YyOENxN1R3OHN2V1ZCWGN2c1gv?=
 =?utf-8?B?U0pmNlRQaWl2aS9uRDlCbjRmNzdGYWVReWtPS0Q0bllOblhCV05TL1hkZFhO?=
 =?utf-8?B?SHhoT25mdDFrZFg5NjdpWFJhb0hzemFBU3U5eGdGMGJJckdBSTE5VGV2ZzdW?=
 =?utf-8?B?bkpQMFNpWmVXOHhvMVNJWGx4UE9SSWxEdXgwVXNEdFRJZWdEeW9vQVJVNVM3?=
 =?utf-8?B?Y2FZQjJQTTBQUHpmUkR3NEZjT0lpSWg5YzRkRE1GQVc5OEo2eFEwWWQ2b3hs?=
 =?utf-8?B?WmlacUc0QVJMSEpsZ05iNU5zUWhYT29rb1VnaUZ6YzZaMmFxNDFyZUVyMUwx?=
 =?utf-8?B?aWRERy9NYmUrU1l3dGF4OHRyNVk0WmViZnZvUUdIdWJCZnVLNnJSRHdubWV6?=
 =?utf-8?B?VWdWV2U3Rms4WUNiRjVTZ3RveVdsYTVaY3pNNWVuZ2NNNDN3cHQwYzI4d0hK?=
 =?utf-8?B?ampidVpmWEdHK3lldXU2QUIzbXZ4T0E2SFUza3pkbXZyYVpsWlNVQ1dnM3hq?=
 =?utf-8?B?cGFmOHVXUkRBYTVVZXF0QUpwdlpqOHlQT2xSUVRqYWVPd0hNWnNaUDVoYld3?=
 =?utf-8?B?ZHozdnBjOWkvQkUvVElvMlBzM3FwaUIrYUJsNnN6aVMvRkVWZERwUmFJbnhj?=
 =?utf-8?B?V2dUMkZqc2xBekVoL0Q2VEVGQXlhaDlnNHhONEVaUUlPSG1wTk8wZ291Z3c0?=
 =?utf-8?B?MFdQdE40RTVjek5QeVlIM21jV3pYZUNLZ0YxTXVONW5sV0N1M3NTaHVBdTN3?=
 =?utf-8?B?MDVMT2czTGZQWXpvc2xJT2ZsaFBIOFF5a0dPOFNsWUdwaVEveUhDRDlrU1BQ?=
 =?utf-8?B?d2FIa3oxVVdYRzJGdWU5N0dPN0RHNklIUStPTTVYeTBsbm1FNTdmL1EyYk5J?=
 =?utf-8?B?WFM2UDV1U1A2UGRIOWd0Y0hrNnRnVXNENllVNU5reHh3Vy9xbU9BYmNBOFZo?=
 =?utf-8?B?Q0V2TGJWSlo1ZTQxeWdKU2ZQL1FkQmdjQ3RCc1BSZldvSEMvUFl4WTFubGp6?=
 =?utf-8?B?U214MFlOQ09KbHBqcllzeW5XT0JKWlNOY2JiV0VDWVh3Y0ZYMDlsWTl0ZHJk?=
 =?utf-8?B?VExVRUR0czA0WHFDV21LTUt5cmoxVmhvMi9DTHZHQ2FhNHJ0cTBTREtnei9Y?=
 =?utf-8?B?cVpIRzNCSWVCTmc4aEVNcy83Ry81clo4WTkxOE9SR1A3QmhOY1hhd1hTdXM1?=
 =?utf-8?B?bmc3RTVtRnQvVzNybXE1QWdLRm1BWmF0SHIyTTJFWDFheTVoOUtiZFQxMG94?=
 =?utf-8?B?aDlsU2p2VFJwUjlvenFqMzNqN09mR3ZtK2hCaTBwNVIvY3NhRC8yNTl2OFc1?=
 =?utf-8?B?TzVkRDJMbk9KZkZWRjNEZWs1NEwyVStld0lzaW0zNTVManorQTFaNDNmbU4v?=
 =?utf-8?B?bStZWHBWTXRDQkRiOWQ2VG1oUVlJVDdsaFZQTmVJSEZrdjNpN1M1djk2dDVJ?=
 =?utf-8?B?UlJ2UXUrcGtja3lrb3RCZ1JOWkVZNG54UVQzdTkrSzhUekNHTDc5eG4xNTVp?=
 =?utf-8?B?VFloRHpCZ1Fwbk9yN2ZBU1JXN1hsY2lnMFNaN2pIZmJ0S1EyNXFpTnR4S3N6?=
 =?utf-8?B?d2RBNEZDSnNsTnlVYzJDd3ViUWVRSXdDd3I1bCtmcXQxZUxxdjJ6Q0hQeXMw?=
 =?utf-8?B?U2s4Z0NFQTVBSWI5MVZIZnhqZnIrWHA1bGhvUGdCeEYyQ2VMNnNxd0hZRkVK?=
 =?utf-8?B?Q2J6N1N1UG1VVTlMT3RzQTJPcDVyallqcWxMck9PbklMVFF6VHpweEw0MGlH?=
 =?utf-8?B?ZDA5QjVobFhJcTd2Z3NWRnExR2JKUkhyOTZMN3dwdnlEaFJBVW9hMjFKSWQx?=
 =?utf-8?B?M2VXbTRkeDZ0SUFHd3dNWm5ZTzM1V3NIakVzNndXdWlDZ1lyc2Ivb3FvVWVU?=
 =?utf-8?B?amRXbWVxeTk5RzNRQ00vVk54NXZxN1BEcG1NaDg0dW9UekE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFSdHpSUS90NWg3WG1EUzllTndoQjQ1Qk5uWnJFSlJPekdBU3lHd0RLdVdq?=
 =?utf-8?B?SmYvUDBnVVJkcS9FUlBXSkFROFoyZXZLU0o2OTIzUldKUlJibUdkVlFaeXBI?=
 =?utf-8?B?aEFrbVJsRGoxdjRyamdWeUNMWWF1UElDdjdWMTEwRUJNRGZ0d0N4SGJYUXdq?=
 =?utf-8?B?d0pvUkRReFVscTNxMFNiRXJIS2hBMGM1aTU5R0xNdjY3MnFRb1lIU2VnOU1x?=
 =?utf-8?B?aEhlTG1CSE9JRkw3RFVTWFZ3QUkwM0dkZUVxWG5iOWtWT2Z5S042L2MxMDR6?=
 =?utf-8?B?ZitSY0Y3azJnL2lkWmcvK1QwYzZycUIzWWlUdUw2b2VmamN2OC9ESUUzNmNY?=
 =?utf-8?B?NFc4aENkU1pTZ2MydStGeVNrdDBMS2V1SDNqZGhHMlk1Ty84NGZDT0tjdUFG?=
 =?utf-8?B?UjJ2UG5YSGIzaDhuSk5vODdDZ01vdnM3THVleVdsZWprUHZCME5GbEF4bDNV?=
 =?utf-8?B?b0RvUFlnMnRMTGtYMXdDUWdzVXVYb3BCMkVlTnhZU3dnMlNzWnJ4eXJFU2Rw?=
 =?utf-8?B?ZzQ5NFZ1T0tpLzlqVWxHeE9xRyt5RjArOHFlaUMvYXBoU285YXU2TU52RDB1?=
 =?utf-8?B?N0M5a1VKMTZxTWV5V2IvbFhuVkphTTlBRmFSU2RWQ2x0bXdtbUdMYzhvbk8x?=
 =?utf-8?B?WElybk9wRjZtR0lYWnBxVHB1dmg5UE1QK01IS2Q4c3NEVzk0SlFrVk9mTFR4?=
 =?utf-8?B?MmdXMWpZL1dPU0I5Y2dOQ20rWDNhd2F1Y2puTWozNlhLaXN4VldKUlhVK1FJ?=
 =?utf-8?B?dG05aVA5VnVpRFhnV0ZVaWtJQ3VOc0JPUnQwME96d1p6KzM5YWtsbGZITG5a?=
 =?utf-8?B?Y0ZrYkxOamd0Z1RJVHl2bGJpdHZtQkV1ODZ6V1RCbWxrTVNUR0dIWDhhd0hC?=
 =?utf-8?B?TkhRU2xBeW9haTVwM0ZaOU9qYjYrQTZLcGlwd0ZKRmJBMXF6NHN0K3RwRisx?=
 =?utf-8?B?RVgxYW1TWGpCMi9aejN2QUdLVXpzSGtYV2Nqa2Z3anJHWi9MdUN6TUVxVW1S?=
 =?utf-8?B?WW96YjNLRVVjSjBlZXhUUm1hcWQyUTRVWllwN05ZZ3hKK1pwUkYxbHljOWZP?=
 =?utf-8?B?Smk4RnpZelhndGUySTVja2hldUNHVVVXU1NHdWtPbDA5V1dQNWNCZEN4WnNK?=
 =?utf-8?B?U0VGclJaQ1Mwd3VMRmxUTndFbTJ2VkxXRTZhaWtPTDFjNHg5VkZZSmgrakNM?=
 =?utf-8?B?SUxlUCtIMi9yZzFRZGdnbGxwaFJGQW1pL1REV2RQK0FvZGhUT25NMXBILzBl?=
 =?utf-8?B?aDU4RkE2SFJmYVN2Z2w0WUdFaU5xS1FMY3Z1Vy82dFQ5enI5WXRZQ0J6RUdz?=
 =?utf-8?B?REdGWHVwZ3NYVDZkU0tmUjVGSWk0TUF2L0lVVmJua2Q5KzhQVkhhRUlSdTQ0?=
 =?utf-8?B?YU83T0dNalFTUUZKNDN0NkJWYTM3VTRtWWJkN3lwbFBFS2lmM2s3Sit2NUo0?=
 =?utf-8?B?NmdyNytVNi9MVmJvbHBzdkpYekxyMXJSbGZmakx2U1pDblYxL2xLdTA5TVVZ?=
 =?utf-8?B?MWw1QVN4YUhybXdTZ2FwQTNLS3c5VS93RTlObjVMV3VzWDc0V0ZyRFN3RGlB?=
 =?utf-8?B?NVBvd0thS2tiYkI1YVlyK2FBMG5JM1ZDWkVTVDJXTE1BU2FmVmlwb0NSYUN0?=
 =?utf-8?B?NWluc3JDekREaTREVUJOeHB5eFpHSnhTY1BTQTgwN1JLcTU5d1cyRExZNW1y?=
 =?utf-8?B?YTlGSXdvK0o3U3NkeGFMckh3cC9TMzVFdWVlRzBTVmk1TE5janIydzg2WHg2?=
 =?utf-8?B?Z3FjYkhNU3VmRHQxdmt3Z0VGaHUvZlYyemRlZjFqdDY3TWJHa2pHKzVaRnBl?=
 =?utf-8?B?WkxDUzhLOHkvWFFqbjRqSFI4RFJ2NDFtd2Y1V1FOLzdVa2p0M1dWVTRROU5i?=
 =?utf-8?B?cjBWWlVxVmlLcHFQRW82SDEydWFBQ3U5dDA1Yy8xSUlFTEtNMWdRT1YvU3or?=
 =?utf-8?B?VnkzZ0dDMGsrM0NzNnBsR29yY3d4NWc1ZVF5UjJNZHEwQ2dNanVJYktrdlFZ?=
 =?utf-8?B?bXVDenFKeXN1bmR1ZnUwUDdxeHNiOXVod3BKUkxRV1pzdUJHSlcxSXNnWXdl?=
 =?utf-8?B?TUtQVlhzQm5yblZZZUpTZlNsbzQyYzRIQkRyYUU1cWlOamJhY1NyUlF4L1Ar?=
 =?utf-8?B?YUsvMG1Fd3YvUWVWOU05QXJZN3J3OUFZVjFGUTc3bmtXckRxZHliMzExTE1S?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bb22a4-603a-43e3-d181-08dda734adc4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 09:04:45.4235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VpnC8n0FBKuWkBtS+DfWc0vVjPkI06tokmERpXz+Q6VTXTCcbIVpV+I4gj9fmhBQoZ4x+HWMcnL4X35NUNeMAQlCTYSsFw/fqo9P9l9M0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
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

On 6/6/2025 7:08 PM, Anatoly Burakov wrote:
> Add a function to check DD bit status, and use it everywhere we do these
> checks.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>      v5:
>      - Add this commit
> 
>   drivers/net/intel/ixgbe/ixgbe_rxtx.c            |  8 ++------
>   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c |  4 +---
>   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h | 12 +++++++++---
>   3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index 5f0aedb4cd..50060ce64e 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -118,13 +118,11 @@ static __rte_always_inline int
>   ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
>   {
>   	struct ci_tx_entry *txep;
> -	uint32_t status;
>   	int i, nb_free = 0;
>   	struct rte_mbuf *m, *free[RTE_IXGBE_TX_MAX_FREE_BUF_SZ];
>   
>   	/* check DD bit on threshold descriptor */
> -	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
> -	if (!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD)))
> +	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
>   		return 0;
>   
>   	/*
> @@ -3412,7 +3410,6 @@ int
>   ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
>   {
>   	struct ci_tx_queue *txq = tx_queue;
> -	volatile uint32_t *status;
>   	uint32_t desc;
>   
>   	if (unlikely(offset >= txq->nb_tx_desc))
> @@ -3428,8 +3425,7 @@ ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
>   			desc -= txq->nb_tx_desc;
>   	}
>   
> -	status = &txq->ixgbe_tx_ring[desc].wb.status;
> -	if (*status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD))
> +	if (ixgbe_tx_desc_done(txq, desc))
>   		return RTE_ETH_TX_DESC_DONE;
>   
>   	return RTE_ETH_TX_DESC_FULL;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> index cf6d3e4914..707dc7f5f9 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> @@ -215,7 +215,6 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
>   	struct ci_tx_entry *txep;
>   	struct rte_mbuf **rxep;
>   	int i, n;
> -	uint32_t status;
>   	uint16_t nb_recycle_mbufs;
>   	uint16_t avail = 0;
>   	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
> @@ -232,8 +231,7 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
>   		return 0;
>   
>   	/* check DD bits on threshold descriptor */
> -	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
> -	if (!(status & IXGBE_ADVTXD_STAT_DD))
> +	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
>   		return 0;
>   
>   	n = txq->tx_rs_thresh;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> index 4678a5dfd9..56e13b4125 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> @@ -25,19 +25,25 @@ void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
>   uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
>   		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
>   
> +static inline int
> +ixgbe_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
> +{
> +	const uint32_t status = txq->ixgbe_tx_ring[idx].wb.status;
> +
> +	return !!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD));
> +}
> +

This causes compilation errors down the line because vec_common isn't 
included by drivers that don't support vector driver, so I'll move this 
to ixgbe_rxtx.h in v6.

(alternatively, we can keep the stubs and not do conditional inclusion 
of vector code headers)

-- 
Thanks,
Anatoly
