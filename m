Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE29CCAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 13:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF95E402CE;
	Fri, 19 Sep 2025 15:15:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 26753402C5
 for <dev@dpdk.org>; Fri, 19 Sep 2025 15:15:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758287732; x=1789823732;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/qDijNkbqTOXRqmu51sG49UMsBZYTsFSOhQ/MHa1sXA=;
 b=KQ1WlubsH6mTuYOZGNE6AEUE0JtpvILzhy/+zmvURxZ/zVMaXHuJmyws
 j+aE90wgkeQm0jiFFwmRCHtJgU8teQa1PtsVU2Xbr68TgA0fwXHxdOrUJ
 z6SKzYgGfG0AOIrzvoEIoM0RsWv06Zz+mlL/TloNYvdTDsXYdaAamcBex
 c/sJQpalYrPFe2ALF65iCLhVOSmVtJQ66DbNzQR06F1DSWn7swX7MHV6j
 mjXWAesPR/4XUURftBQNAOIJ0VCsX7YydaEUHB7DEQfa1h/OdBXPSkNBf
 F5aNo7kfFfBiex8xkRvycXkOGWnxABaTKClZjCXppDo8y4UpfGr8LtBX5 w==;
X-CSE-ConnectionGUID: 2ITeMygKRK6670jnY5ljWw==
X-CSE-MsgGUID: df1uPlNoT6u166FDHqWPsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71261642"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; d="scan'208";a="71261642"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 06:15:31 -0700
X-CSE-ConnectionGUID: aypAhn+JSmKE5KFj7tdr0A==
X-CSE-MsgGUID: baghZK8yT1uf8S6NFO/ivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; d="scan'208";a="176229249"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 06:15:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:15:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 06:15:29 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2N50RUHjT3nZW/SeH73E1NJlNivSHQDySK7BloC+HZhWuLlAZY6mjavIRuxnJRpm4w6AtCaG7CLykwXwyvCAy/wn/EVJS4ovzz+dKTqKcBMts2sPefMhUPxVJow1lZ1fQ+EP29AsIww0McehXuv/TiYEd8mwb3cWI3TIviNJuqiTNFkaPCzQIDQUa6GSX0m1EfXzO7GbkDrq0+kOT3tQLfC46yoIUwuOCAPonSvZIfT3kukx/unTFFni2Un5K34gxgLoY/6NZZgGNbWFmVL3C0GV+s0ASgpjmY942P+sO53vAcWSfJjw+MUFu1wILuUmDajHCJwtH/3azO2/QyNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIjVabv1OCY4ksqTa+P++5wfRvp+lx8M9yNtR+cdCRc=;
 b=PdsbIOP6eI4oHGpAjfEduGS7SoVBkKGR0zW9JWlC14kr/onLoB7WiIV8bH4XjRcS5F0ptj5ZCHPQjFPuPG4C+ZPJ+3NL+sgv4imPJAxsb0C5U8RYnV4QaJE0rMdtoycbhL7whDawYDOwIX10z2JVlvh1UQoq5txifWvhLtTbEpJUsLZN0nXqDZcGtLRAJK4VvgD8Qhy6iNCjn530CQMzR0z8RdFaI75zxmoU4ZYIyJGDNcEopw3q7vjKqhsp2Th+qyYrogHqyIACALCmbDU1JeTdlkHI7AkclxfYj/lFlXalDx4b3dkBac68U6MTjSz6+5MZPW3fMziQRkLbBp6eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Fri, 19 Sep 2025 13:15:21 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 13:15:20 +0000
Message-ID: <4e64ec18-215d-41b3-aa22-42e560cb8c6c@intel.com>
Date: Fri, 19 Sep 2025 15:15:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 6/9] eal/linux: remove internal VFIO wrappers for old
 Linux
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-7-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 48424689-6f2a-450a-af91-08ddf77e95c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yml2QXhzc1Y5SnJDVDFyRWFEZDloamtpK1E2c2FVRS8rejhrbXBqK0p3Rlo3?=
 =?utf-8?B?RURHZjVpL2hzRVJhRUJIZ3Mvc3EyZUROcDVJT0pTQmc2Sk05bHA1UmdVdFEy?=
 =?utf-8?B?VzJYcDJIRzVpdEFUM2dGMzdiRE5GSkF2TlVjU0tKSFd6YTNoODlFa3lxNm8v?=
 =?utf-8?B?VU9ZTTRZNmZSOTBtRE1CeS9sLzB3VjBHOVF0eGhFeFQxa25VZWZUdEU5clFV?=
 =?utf-8?B?aXg0OUNzL05ZelpLNS9vVjZRTXJrSUZzUjRaVGJUQ2pIYlg1OUtzVXVmSFBy?=
 =?utf-8?B?dEdkckZSM2w0bmNIVDVoQXNyTE0wQm1CUHE5L2NEZkJ1YnNQcXpUaldwc0Jr?=
 =?utf-8?B?VXhjQ0hWcEp6eldhYUZHTUVHQU9SQXRRU0l4ZTFEVmlaSE1yK3crckxTQU16?=
 =?utf-8?B?cWxSclhMZ0FwbEkwTEJ1ekJOYmM1eFpGUUt5Mjl1VHVCYkY0V2M4dDU1N2FW?=
 =?utf-8?B?K2JxcGhyWXJDR1RoazZiM1NoVDIwUTF4K095TnVuV2JBRkZ4SFREcHpLMm54?=
 =?utf-8?B?UHRSOHRMVTZ0YTNCWnZOUVFCMDhRRkpzS2VKckxzTGdNVFFQcS9lcHZEc2Uz?=
 =?utf-8?B?ZWVBOGRmYkg1L2o1aU1aa3ljclhIZnVWcEtFYkxVZWFUeWpDVG1vRGhFVE9N?=
 =?utf-8?B?VEVVQ3NiN3ZWN3VsUGM5OVB2eUpUdURHaWZkR2F2QVUwSDJvUDkrbjk2MHVv?=
 =?utf-8?B?UkRJczFJZi9GQndTUE1zM1dBZUVoblNUM1p6dFhJZENnRTltaTVsdHZSZG1N?=
 =?utf-8?B?MzZScHd5UHN1RlV1WW1NQzZydWNYOEFDc0tNVDhHdFltZjRVL0JkTFVTOGFk?=
 =?utf-8?B?MEtFUlBNM093SFJMT29xL3FGV0o0bkFTSWpKSTY0Q0dLM0xka1o0bmdNS2po?=
 =?utf-8?B?RlJKNkV3VlB1WmlSeDNqUlI1OGdtaUpZM1RFSGJmMlhIdThkZkhsUXpmcVJW?=
 =?utf-8?B?aVIzQ0NpZ2p5VFZWR1I4cjFZcEYxd3NJQWZJUXAyKytOb1pBTDhYeW1VcEN3?=
 =?utf-8?B?bEU0OXNXMnA0Tkc2UE1VbjhVWXRQQmxaN2d3c2d1MzhLQzVlbEoxL0lJdCt1?=
 =?utf-8?B?c2RySGFLUzM0TW1vY2JSaFBUWWZnTW01WmhNNUF4bENXenFHalJOTWZvNDA2?=
 =?utf-8?B?bjAxWnkxTTg1OTVBSCtQeENjaDVGazNIM25mOW1mT1EweFVCc3AxSWZYMkVQ?=
 =?utf-8?B?QWdEWHRCVDc2a2Fwampsd2I1ejZQdGhwQmw4L3B3YkxKdy9qWCt3Z3k3VTJj?=
 =?utf-8?B?cXcxTEQzQnR5YWRndHFrS01WZHRZRGtiL0hROVIyOXFrSk5ueFMzNWFnanh6?=
 =?utf-8?B?VGpCL2sxMEZXMDRWdFBNVnVVUDBVOWNQYjhYUWkwcGNTQ3hsTG9aNkJVRWY5?=
 =?utf-8?B?QnlhL08yUXROTDJHc0Z6UGFYaUZrRzQrZUlXeWU2em9kT20wVDdBMjk2OWZn?=
 =?utf-8?B?ZXcwbTNlM1pqcUlrNkpQekljYjJqQ3VPczVLdTk1Q2w5NnZjVU16OTFJUzFG?=
 =?utf-8?B?TEVJeG1GTFg0ODYvZE1NWHphdXFCTk8yT2YvTVZPbEFlQ3EvNllGV3gxTnpV?=
 =?utf-8?B?VlUrSWFBeE53end2bDdlTFFBT1lyT21Xa3hEUUZWSjNyTk5vK2t4aW91b1Ft?=
 =?utf-8?B?Z29maks4NG9YVit2blgvclVKU2szQzZSZ0hyMWFjaGZNNHk4Ti9oVWI4ZGNw?=
 =?utf-8?B?V0tRaFZHUWpKYzBLVTVhRXFJVW1GSkNjWVJqKytDNzZmOGlIV2l5LzhWdUo1?=
 =?utf-8?B?d3k3UTVTNmd1VE5DWC9qZU9CNnQxakc5ZjR5WVl3U29JZ3NZT3AwaU12Zzk2?=
 =?utf-8?B?S1F3OUVSaWVUOUhJLzI5dXh1c3FpNkFEVm1JbkdvcXVmWmdIczREcEVLM1Bl?=
 =?utf-8?B?enR0MVBNYkdvMUs2VjVYczhEa1BnWEpwV3hVOFNkVXM3OUZ2RHFZMVVEaGVN?=
 =?utf-8?Q?f9LvXR11+Ao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRuTUFzeTgxLzVxNG9MaHVVYnVnQzlZWndxQ203SWl0d2hWU3pvbU10TklP?=
 =?utf-8?B?dzNNSW9OUzJ3RVhPbVlONkR6ZDZiV0liUFQ5UlhzWTBJcFBqMUI2Rnh2MlN4?=
 =?utf-8?B?SFlEMkRMV2ZDdnZsNEtmNmFDdVRJM1MrSnRER3g5Z01MZE1tcnk0UEFWd3k4?=
 =?utf-8?B?VzF6V211VktIWUgzQ3MxbGJIQVpXelI3VXNYVjJNMWpETUFJSEY3cjAxZXV1?=
 =?utf-8?B?TytBZDBQZWxRT0tLcUV0V1Z1L3lDeWN5Y1NqbzBnWStwTUo1MW5ZaU5TUi96?=
 =?utf-8?B?L3J0aFZlOFhHeFZEaHJXai92bVY0MFVBQmJKQWVaa3lHWGRvUmZwSk9VRlhv?=
 =?utf-8?B?RGk2TGdUNUt0ekl3Z1lLVzRTTS9WQkdnbVJicitmOWdJYjdTczhhQXFOUmJk?=
 =?utf-8?B?UGJveWJWVWYvZUdvZXNWamdzQ1NZZlRDV29COUc5RWZVODZXR1IyNXRHWXZk?=
 =?utf-8?B?dnNtMnU0aUtqYUZrV3lMcUhIR0IyaVZBOWh5S2k5ajcxMEtBd1RkTWtud2dT?=
 =?utf-8?B?OTl3ZWpQbW9xQ0x1VXhnWHhaTWNUc2xtTjF2Vm4zWlRJNE80eDgyUXE1RmJI?=
 =?utf-8?B?cXRlV3NzY1ZLNGtPT2FvSFYvUlk2U1ByMmdETjkxRG5MOSt3UGI1L2pkbytk?=
 =?utf-8?B?S3VoVUdtSXVCZ3kwV1EySTFKQVQ2L0JUcWtyK2xTckdzKzUybVJkQ25PYzJQ?=
 =?utf-8?B?dVd3ajNhMzlLeGlBcEl2LzhhZmFXYzBYOE1UVmprSVB0dGVpV2M5MlVtOW41?=
 =?utf-8?B?SlFOMS9tamhmY2hhYnVmbmM5VkI4cGhCZVVMeWFIenJpSnFnTmNSUXorNlpo?=
 =?utf-8?B?anptVk9BWndWYXc1WEpFMmM3MXkrZExEQndIam9VelM5S0ovV05ZazZKcUtC?=
 =?utf-8?B?RkhOLy85NDFMRXNqU2tiMHltdWdER2NPTjFHMWRnSUlTN0lESDFoUU9nT1dW?=
 =?utf-8?B?S3hZcEJPOVZhc1NxZ3ppMmgrQ2dOTXhmY2t6dTQ3SkxUTXZwYTRCWVN3UDFs?=
 =?utf-8?B?VVdPNU1LeGRvYjE2Y2hveFE2OTY3OHB6ajk0ZnJORGdqUjM1UGFHb2RaZWFM?=
 =?utf-8?B?L2xSbkloejNSWUNLNWtCSmNVRDNPVGNsWjJnb1hSZGZDamNXNWlWNGhkL0g4?=
 =?utf-8?B?c3JCYnJPQTdDTTNsWnRxakg1U25YQUozajdiOE4zdUdMMXZweHNvOXJDZGxn?=
 =?utf-8?B?ZmVhTHJTSnpIWkdOYWlFOGVWVzBNUWtzdThpSWNQNDBpbUdUTU1qN1dHNXRE?=
 =?utf-8?B?VGQ0WnZqRTdrMFI4Y1hxdE5sMEpHSTJQK2hTeGpDMDhZL0ZEMVA1UjN4OUlr?=
 =?utf-8?B?VWxmVUlXRnlMVW1aMHdvV0RQUko4NUNOSlFmQzBZM2Ftc0p4bVRoZHdnU2gr?=
 =?utf-8?B?YTE3RnpYd0dINGNLMm00RTl5Nm9EZi95Y1c3Q1I1ay9udE5McnRyVlorOStG?=
 =?utf-8?B?YllYM09vRlBpV2dBVUhreUNLRklNOWtLZCtUSjZUMFNNN01uQkFrL0xUcVJa?=
 =?utf-8?B?MnhrYUEzZzlUdW1RQU9CU1Z3VDFJKzhVLy96WTh4TjRCa2szK3ZnRHNKN2ps?=
 =?utf-8?B?M25HaU55Y3ExZ2xwOGwwd0l1bmtkcDFUV3Q0d1VJaFdkYmVmNGQ2YkdmVklm?=
 =?utf-8?B?M2V1dExGV2o4SytQSHBhU1AzYkpvQnJHbU01Zis1a1ZENlpFWnNVb2dtVUhL?=
 =?utf-8?B?MTNsanVudXRlY0VadzBPSTZqWENER3JKdjNyTXZBRUxsS2RtSzR4WlVUTjg0?=
 =?utf-8?B?dlB2V042VTZrMy9rOS9GdUJFbWRNaFZKNm5QOWYzcTVxQlAxY2x4L05xeDdq?=
 =?utf-8?B?VVNyMk5vaWVIQkJLYU1BSFFiMlNlMC9vRzZNNE1rc1poS2RnN3FHQzNzTEVs?=
 =?utf-8?B?cGs1N2JkU2VIV3N1Mjg2TkhWd01nUERtbUpQQXQ1NFdsa3NMT25DWHdrcnFZ?=
 =?utf-8?B?dE83K05ueUhsdzROUVhCWG12bElhdmFoU29uOEFrcm5VcVhxMFJzdkk3QW1o?=
 =?utf-8?B?bk5tQjIyWFpkTTlqRndqSjNzcHpTU1drL3NNUkpXWDE5RUN1SEtTWlBrTDIw?=
 =?utf-8?B?bkdhc1RsME9SQjI4NWRreURETWhTT0VQTC8vZkRZdXZ0TGdQRzUvTHdIM0dj?=
 =?utf-8?B?NW1aUnBiL1JmUG43bVh6UEJ4UkJIMjBzSFdaRW5FODBuVjRlckJVZTJwbUZR?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48424689-6f2a-450a-af91-08ddf77e95c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:15:20.9274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGKZUmD5g/VABeN3e6d6Ae2IzIDEYY04HMN8dLQJTygGCNglmRdNpCRXahU7LbRKmfO1yvMr1hzXOgTpBcNHF3EjXNMIwc/IJyyok78pwWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> DPDK now requires Linux v5.4 at least.
> 
> VFIO_SPAPR_TCE_IOMMU is present in Linux since v3.11.
> VFIO_SPAPR_TCE_v2_IOMMU is present in Linux since v4.2.
> 
> Remove wrappers accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
