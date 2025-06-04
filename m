Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F154C5B555
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 17:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4755742E46;
	Wed,  4 Jun 2025 19:04:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 50BC44025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 19:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749056659; x=1780592659;
 h=message-id:date:subject:to:references:from:in-reply-to:
 mime-version; bh=yci0mMwQbOQpPLA8eJ0RaW+CAfUieUkdAe2FA8Lrav8=;
 b=gEnWA8WDSeijL8HjpG8QQk/X8WCHOAjG7EvkWyuBOMGoDG4w5W+4m75g
 C41cyu2jxiEDo2MnCfBFP6Y29UeXgoDp+XmdZX0U9YH8aMmwItY5HcHD8
 KTOMQdF/qcvFE0kNpQx6DXKu3aCGIzixaQo/J7o+a4gWsjDqPaoakIWRh
 gRLsKxVYDzZ0RMsPObys586XKWXAu9IDs9Vw4SlU9s67P+ig5DfPlfg+o
 aot655z077tLR6lQLHg9UM6QSALPVjGfpYRAetWj/we/VyBgxBAm3Gcda
 dxv8zftLuBbWHNfe763a1097EEhLB+TTIy19+7ZYXuulY1N/xgUcoCuEg A==;
X-CSE-ConnectionGUID: KUMkbI37QkS0hG5fVEm3PQ==
X-CSE-MsgGUID: Td/Wg5HRT1y0GrzxHJ3idQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62542216"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208,217";a="62542216"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 10:04:17 -0700
X-CSE-ConnectionGUID: DZO8liWZTDqhj/72WJBhnw==
X-CSE-MsgGUID: b4b/Fjb2SWKnhpPbcYZ6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
 d="scan'208,217";a="145122315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 10:04:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 10:04:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 10:04:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 10:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzOBfzAg3BlrjJhV2A+glbN4tzOoJ0phVq99Jd12SbyjpjLA4DIqnFoVcTaNB7jh5lnDGw8Rs5ZA5NJ24PAUKlRgOcW64fgW3UEw/LfNVDvTq6KfLVd9GCneSIV/iAkKFAIJqNLpDYQRtWs8l2fn81DC+5re9nMf0NK8awrS1w+Ky7tPxoZqutf+akWF78ZF3Oo4K4aC1z5mZfBlfu087fzn5KlIh6w6s5KwYfxbi/2Y82bl9Izy6VURfMy62vux2kvnEsdk/yaIuFrCmALmnQ9KdDD7QYlUcep9chQ0TD7wYrYbG/dzSGmGquQbb2x2x/zzoUIBWAnXCCf00uSV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH9DsXex9lYlcmWYGdo0U25LgcEDo/iE8ApXDM1yCi4=;
 b=gQd9lalxeQaFaVHFnl2GExtseiJiBe516hyvD+aqTEqBMx/qsFgSjkEHqACTKk0bZ777lf068UTROL47nGgNSW2dZ8pq2ZyNhW7/VKRl/f7Iqt6SuPDpy4HofumWFhcUJDd1HrR825/ltA0nEr/zkSQgMt9T2XBUmmP2IkAkXGuYIBQIi0FqYcGhfJ7Gu1KLq2X/ZKbqIcRs1gs1XhRnaLHXOaab0/OY5yqCvxyGqS4RQ2ATvnQ02eEAGhnI1RWLuUeIX/oL1i7MVEjRVhetMYP41FSo/bYXSp0M6mOkAP+GkRh/SxBCiQhHXhl9r/3mJrPhf1Cu7FXoSYPxdubQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH0PR11MB4823.namprd11.prod.outlook.com (2603:10b6:510:43::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Wed, 4 Jun
 2025 17:03:32 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%6]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 17:03:32 +0000
Content-Type: multipart/alternative;
 boundary="------------8vqTxjRxI0ZChfDr7wEtTWs0"
Message-ID: <68226243-3bf6-4c83-8426-d6280497b950@intel.com>
Date: Wed, 4 Jun 2025 18:03:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lib/lpm: R-V V rte_lpm_lookupx4
To: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>, <dev@dpdk.org>
References: <tencent_A2BD85C9F3B0AA4658640DA91443CDF5630A@qq.com>
 <6aa7f332-c9fa-43e4-95f4-66c34f2c63bc@intel.com>
 <26aab158.28484.1973abd6624.Coremail.sunyuechi@iscas.ac.cn>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <26aab158.28484.1973abd6624.Coremail.sunyuechi@iscas.ac.cn>
X-ClientProxiedBy: DU7P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::26) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH0PR11MB4823:EE_
X-MS-Office365-Filtering-Correlation-Id: c84c8a1c-ab48-405e-ab80-08dda389bc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEt3RDFTeHVlbFpobVJsZTRYR1IxdXYrWXlOdERsVEtNZmdpREkxRnUzd2xW?=
 =?utf-8?B?Mng3bEltb3VHRzJjMjZPY04wVUtSN00yZSs3eSs4K0UzMUtvc0k4T043SE1C?=
 =?utf-8?B?WHVpeXlDUk9hTmZyMzN6ZjRBdHc3cWhSd3ZkNGtqZ2pobEM1dExMNFl6Slpz?=
 =?utf-8?B?SkxhcWF4WU5ma3lqZjZnZTh5MGJSelZZWnhJMlBXQ0M0UERQa200QnAwaXE0?=
 =?utf-8?B?SUJtajBXRHpBdWFOa01USGVoSmRpQk5RckRwRi9pQ0lURkhrL1g0U3o5bHV3?=
 =?utf-8?B?a0ZQY2xGSkt4L1h0eFRGK2dCaU9FWVB6UEtlY3hsaUVsZk5FZlJ0TW9OOU9h?=
 =?utf-8?B?ZlkxWmgyS0VmcUM3NHQzQi8zZ3NuU3pPOXdJZW42dkVKb25YWDdyMzUvMk0z?=
 =?utf-8?B?V2l5V1Y1WXNhdTJUZjVjT3hoc2lBZW9TNUU2cWs1dHhTa2hBM0tNWDZldG8x?=
 =?utf-8?B?bUZ0NHdlS3pUMnNkRTRhYkVuK2tVckZCcXluWDh1K0pvYVoyd1llUVJKdFFt?=
 =?utf-8?B?UEdZQkladFdNRE51WEo2RWV4Qlg5SnJZOUpCNitMVXBZaXgrYUZuaXJqa2Z1?=
 =?utf-8?B?NzZMeVFFNGtWZ2EzeFl6ejQ1NU9zOGlCa05WSUhjRFpLVGYxemIyajFQOFdW?=
 =?utf-8?B?UlRha01oUFU3MlJQM01KenJWOUFra2FSY0NSblRwRE1uV2sxamFwV1VVUVo0?=
 =?utf-8?B?R2N2VmcwZ2tIbHFlNC9BVHZWcEhCL04rYVlkOWNDZTNMWmZuR3FyL0F2bmFX?=
 =?utf-8?B?V3pTSnRqeStkQzRJcHZtNWxQWVgyL3UvZWJ4Z1R0eC9YQlRjS3BQV1hMKy81?=
 =?utf-8?B?d0pES3AwWERlVGIrT3piSmU0OEZ2SjJFa09neE8rdWN0VlhZbmJBbGptRkxJ?=
 =?utf-8?B?eTcxMmQyV2V2Y0hVUW0xSmYrQmRvQ1l5aHAyUk1pRDY5TklWQTBVSGFjemRQ?=
 =?utf-8?B?UUdDNHpCYVBtWEpDQzV4eUtycm5PeCtQQ3Bqc2NXU3lzZmdNS25VN2dMVmJG?=
 =?utf-8?B?QWViYkplbThMamd0ajNxb2llUGgwdDl6MVNMV3pUQWt2d1cyTDdSNlQySSt0?=
 =?utf-8?B?WWtZNmZNUVpRMWVFUjk2QnJXdnlIb0lqLzY4VnlCY2IwVTM0V0xTNERveFhK?=
 =?utf-8?B?RkdGQmdSZ2JuNXozK1RYZ2l4alJDWURMTUNlSTUwVHczSitXWnhYZ2lZdytJ?=
 =?utf-8?B?Z29ZS0drc0I0K3pYUjdkOTV6T3Y4U29oU2VVcG92bWE3ZDN4NEVjL2NuODJJ?=
 =?utf-8?B?WDVKWVMyRGJaL2RRSG9CaHM1UGVTNUJhbzlHcWVXb296S0Qvc0l4K015bFlH?=
 =?utf-8?B?bENMeEl6YjBqRVFjQ3FOVTVRZ3U3dWNCRFlxTFNCbjV5N2EvaVUwdEtSdkU5?=
 =?utf-8?B?NFkzeTZFUi96WFo1bEJFb1Rvd2d1cVBiZ2E4MlVwOGFiNi9Nb3hQbUtOa3NT?=
 =?utf-8?B?bVdBQkNaRm14UWl4c0ZXV2JLNVdDWUkxNHlWbGtQc25PY2s1THJYMFFOUzA1?=
 =?utf-8?B?VGZPdVpqbXZvVXEzeG9EdVRxai9wN3ducDBkTmNVdSt6UTd5ZEt0WHNrcUZT?=
 =?utf-8?B?MmN2NjQxRTdtZXoydlVmaTJHaS94cVlmNFd4NG1rMHRpeUZhZHJIcE9VM3py?=
 =?utf-8?B?MitIVWExVkZWMGUzZTlTMDBiRkwxQmhDNlV1NHNxaUk5MnB2YVJidmxZM1ZT?=
 =?utf-8?B?dU01KzYwa05SaG9QaUFCWTliK1p4a0N2V2wxMCtlUkN2YTRSRDkwRXVOeCto?=
 =?utf-8?B?Wk1ndCtPQWhrQnhBNlo4RXB5S0NGa2VPK0daQTEzWXFLU0kwUEZGT2k5cHRr?=
 =?utf-8?B?dUdyRWlqdFJ3YU1BdlNHSmI0K2hMVmpxSGwvOU1sQytyN0RXTWw2dlFIdUpy?=
 =?utf-8?B?WksrbDNKZzI5ZkFSYXVJaHd6ci9lMUNFSXJRcWlVQU5TQ0EwenVPbFpnYnFI?=
 =?utf-8?Q?xHGvl+9iKxQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxEYW5RaFd4dkt3U1lGU1FKTFJhV3FuQUdvYVB5M2Z6a2ZkM2lCb2t5c0xY?=
 =?utf-8?B?U2NCUUVKZFFNMm9XUmo3WmNaMTVpb3BhRzZCYXh5eVdZV0dLcWJFaDF0QU9U?=
 =?utf-8?B?ZkhXWG9IRlkvcDF3SVhkcTZKRHMwQ2ZBbkc2c1ExRFhPajBhUVRKZTJIbkY5?=
 =?utf-8?B?VlEvWWNjcFpsQWtiSHR6SFJURVVsVW5nMnd0bWpuVEMyVkpuL3dwcTl2UWRs?=
 =?utf-8?B?SURIN1h0OXRYSC93RWtyQVlKaWs5Uzh2Qm1sWVp0LzhBTkRUWmZMSmJJc3Z2?=
 =?utf-8?B?Rk1lNkZjeHFyOFFSZHBtZEYyc0pjWnppbGsrTGhTZWRTcWdvVVQxQjA5dEhY?=
 =?utf-8?B?cGsrMzc2RkxlemFaMzYrZkN4cENFV21naEVsSXVvQjFiV1YwNnd0ekNGbUJj?=
 =?utf-8?B?dkpxdzQ1NUVKb3RnNkVhSk9NK1pVaDhrUXYwM0d1ZU82dDE1Y1VoTVFBUk1k?=
 =?utf-8?B?WGF4NlVVREMxT0E0WXR0b0RFVklOVWIrOGZrT2N2UUJXWUFoRDlFNjMvTVpn?=
 =?utf-8?B?WmkxVm5wNU9qWjVDU2lUdWVKRnhKQ2pHOG5odXptQ2xKNXlLa1ptbWozUnRL?=
 =?utf-8?B?MWo5Zktoa2dNOHhPV01qcW8wUjFLdklOcEh3aTVKd1ZXQVovY1ZmRFpWUlZU?=
 =?utf-8?B?TFF1OWJKMXlEbXhWQWVqRklic0ZEMkNCZ3Zvc1lVMTBkNDN2QkVvNThIcUJB?=
 =?utf-8?B?QTFZYS91YnUyQjR1OGZwMTY0bWkxUGJUN0cvT3ZRL3AyTTl6OVdNMnJzT1Fu?=
 =?utf-8?B?czRDb3NGeW5VTDBSUG81UGFqdEhMVy83SzJ4QWlSWWl4Snd2VkhrVktKRzY4?=
 =?utf-8?B?Sjg5MjVuT0RiazBjWER5OHFxR01ScFpXTUtreEVEdmRuMXBjejBpVXRiVDlw?=
 =?utf-8?B?emM0MlpHNXZMUGUzQUJkVlhZM3BNRVU4QjFEeUZ5Ums1Y0ZldmVRRVR1eUxv?=
 =?utf-8?B?cXNpZVRMeGdCSjBZREJ5bDVkYXhlVE1zbGd5cHZiU0dsZTMza0l4Qi9wOVhj?=
 =?utf-8?B?b2MvdkV4dmRXOWNweGowZFp5Y0NGRGxoZnQ1dnQ2dHp6KzFaVHNSSlNmYnN6?=
 =?utf-8?B?U1pHRHJPZFhrTnZEZkU5VWhzMnp1ZTJvVWNFSkRTS0RkU2lXT0ljUGRwTExB?=
 =?utf-8?B?K1FHQ3NCd2JFeStIZHk0TnQ4T0VtWnQ3OVBBZS9zd1BmRWpFd0IvKzR0ekgw?=
 =?utf-8?B?bGQ4dlRNcmJnK2gxM3FLSng2cFF1RlJqZEYrV3RacWxxaEhkbW93VGRBQXUz?=
 =?utf-8?B?ZEdMQU85c2lzLzdkU2lYdGFKUStoUldaZTZUSW1VdWZuQnluQk5ZeDNzMm03?=
 =?utf-8?B?VFBoMHVQM0s1bVd1TlpzVWRHMUhZa2hjQmE4OUFkb1BjRHZMWkRQVXd4elAx?=
 =?utf-8?B?OHpIZDk0bTJTM3hxVGdXQkhWUEdDOGQzQW5DQVdEVnhxSU9uLzZIeXFLZHdI?=
 =?utf-8?B?c21qdkVEOUtONk5zTXhnT1QxUUdEVnhxeTljT2RPZUN0b05LLzhlSkl5RnBB?=
 =?utf-8?B?VUZIb2dJZUIrbHhFUkFzOURyT0NHVEpPRkNEYXJ5MHVHRnI3aTRRRVlBOGgx?=
 =?utf-8?B?VzZuOVhVZ21uRWcyZ0prRFo4dkF3emIxT09LZUFXRW40c3lnVmt0YWg2Szkw?=
 =?utf-8?B?WUhqOU4wRW5YMGVPQjJwdloyWHVWTXJsZWQ2RXlKNldGUzZLR1B3cmlRT1Yw?=
 =?utf-8?B?eEpDRytxYnB1VkFweU5pemdGZlJrYjgxVmZnc2UzUlNIT3h0RGZDZGNYdzYx?=
 =?utf-8?B?M0dGSzVRQW03RnpqaEZlNDdnOFNlNEtEVWt6azRFOGxVMURweGZsbUVjbTlz?=
 =?utf-8?B?cVFoUW0xYnE0Z2d1MUJpVkhQWHY2RC94V0FhOCs0SnFZM3RXalIzeWZmaWU1?=
 =?utf-8?B?NFdFYVkyNW9VRzhGenBXaFM4aDdMbzZ2ZE9GaU5oSmx5eGl1ZVdZREdzUHdi?=
 =?utf-8?B?TGtyeWpRakcya3MwVWREeUpDWEFJTUJJZGlja1ErdWx6QTlFSUZwV3V3bTZF?=
 =?utf-8?B?akVSVGNEQXowQ2RZdUs3NlUzYnJhL2llSGQvTFJWYXZ6NTJ3Sk55NS9OTXZH?=
 =?utf-8?B?UFdsSklFb29pamVKcW5aSmQ5cUk4bDBQOUQ3Sjgzd3QreHY5NnBIZmpvRWhw?=
 =?utf-8?B?OW5ldkVCTHpmMjE5dGJhSjhkZGFkSWZkWjEvZi9BdkRHTElpdGNHTEVJQ3FW?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c84c8a1c-ab48-405e-ab80-08dda389bc34
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 17:03:32.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E47qr+1c/0Fq12jRVgkozHa+Qq0VX+rLdBGd/nmzMLMcTPgCO9Ia7zuF0ZC1sbJHjLOuc8pW6mjWPLo0FwOBYwjgwioPJFVTwSjGN33yVNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
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

--------------8vqTxjRxI0ZChfDr7wEtTWs0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sunyuechi,


On 04/06/2025 12:39, 孙越池 wrote:
> > why is it done in a scalar way instead of using 
> `__riscv_vsrl_vx_u32m1()?` I assume you're relying on the compiler here?
>
> I don't know the exact reason, but based on experience, using indexed 
> loads tends to be slower for small-scale and low-computation cases. So 
> I've tried both methods.
> In this case, if using `vsrl`, it would require 
> `__riscv_vluxei32_v_u32m1`, which is much slower.
>
> ```
> vuint32m1_t vip_shifted = 
> __riscv_vsll_vx_u32m1(__riscv_vsrl_vx_u32m1(__riscv_vle32_v_u32m1((const 
> uint32_t *)&ip, vl), 8, vl), 2, vl);
> vuint32m1_t vtbl_entry = __riscv_vluxei32_v_u32m1(
>     (const uint32_t *)(lpm->tbl24), vip_shifted, vl);
> ```
>
> > have you redefined the xmm_t type for proper index addressing?
>
> It is in `eal/riscv/include/rte_vect.h:`
>
> ```
> typedef int32_t xmm_t __attribute__((vector_size(16)));
> ```
>
> > I'd recommend that you use FIB to select an implementation at 
> runtime. All the rest LPM vector x4 implementations are done this way, 
> and their code is inlined.
> > Also, please consider writing a slightly more informative and 
> explanatory commit message.

The commit message still looks uninformative to me:

 >lpm_perf_autotest on BPI-F3

we have no idea what's that

 > scalar: 5.7 cycles

I'm not sure we want to have this information in commit message as well, 
because it is useless. Cycles depends on so much variable parts - what 
freq of the CPU was, what speed of memory, size of caches, and so on. 
This information is irrelevant and become obsolete pretty fast.

 From the latest commit:

 >The best way ... However, ... Therefore, ... this commit does not modify

 >Unifying the code style between lpm and fib may be worth considering 
in the future.

I don't think this is a good idea to put into the commit message 
information about what was NOT done.

You should put all this information (platform you were running, 
performance, implementation considerations and thoughts) into the patch 
notes.

>
> I agree that the FIB approach is clearly better here, but adopting 
> this method would require changing the function initialization logic 
> for all architectures in LPM, as well as updating the relevant structures.
>
> I'm not sure it's worth doing right now, since this commit is intended 
> to be just a small change for RISC-V. I'm more inclined to follow the 
> existing structure and avoid touching other architectures' code.
> Would it be acceptable to leave this kind of refactoring for the future?
>
> If you're certain it should be done now, I'll make the changes. For 
> now, I've only updated the commit message to include this idea (v2).
>
>
I'm not talking about adopting the FIB approach to the LPM. Instead, I 
suggested keeping LPM code consistent and leaving your implementation as 
a static inline function. And if you want to have runtime CPU flags 
check - you're welcome to do so in the FIB.

>
>
>     -----原始邮件-----
>     *发件人:*"Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
>     *发送时间:*2025-05-30 21:13:57 (星期五)
>     *收件人:* uk7b@foxmail.com, dev@dpdk.org
>     *抄送:* sunyuechi <sunyuechi@iscas.ac.cn>, "Thomas Monjalon"
>     <thomas@monjalon.net>, "Bruce Richardson"
>     <bruce.richardson@intel.com>, "Stanislaw Kardach"
>     <stanislaw.kardach@gmail.com>
>     *主题:* Re: [PATCH 2/3] lib/lpm: R-V V rte_lpm_lookupx4
>
>     Hi c,
>
>
>     On 28/05/2025 18:00, uk7b@foxmail.com wrote:
>>     From: sunyuechi<sunyuechi@iscas.ac.cn> bpi-f3:
>>          scalar: 5.7 cycles
>>          rvv:    2.4 cycles
>>
>>     Maybe runtime detection in LPM should be added for all architectures,
>>     but this commit is only about the RVV part.
>
>     Iwouldadviseyouto lookintothe FIBlibrary,ithasexactlywhatyouare
>     lookingfor.
>
>     Also,pleaseconsiderwritinga
>     slightlymoreinformativeandexplanatorycommit message.
>
>>     Signed-off-by: sunyuechi<sunyuechi@iscas.ac.cn> ---
>>       MAINTAINERS           |  2 +
>>       lib/lpm/meson.build   |  1 +
>>       lib/lpm/rte_lpm.h     |  2 +
>>       lib/lpm/rte_lpm_rvv.h | 91 +++++++++++++++++++++++++++++++++++++++++++
>>       4 files changed, 96 insertions(+)
>>       create mode 100644 lib/lpm/rte_lpm_rvv.h
>>
>     <snip>
>>     +static inline void rte_lpm_lookupx4_rvv(
>>     +	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
>>     +{
>>     +	size_t vl = 4;
>>     +
>>     +	const uint32_t *tbl24_p = (const uint32_t *)lpm->tbl24;
>>     +	uint32_t tbl_entries[4] = {
>>     +		tbl24_p[((uint32_t)ip[0]) >> 8],
>>     +		tbl24_p[((uint32_t)ip[1]) >> 8],
>>     +		tbl24_p[((uint32_t)ip[2]) >> 8],
>>     +		tbl24_p[((uint32_t)ip[3]) >> 8],
>>     +	};
>
>     I'm notan expertinRISC-V,butwhyis itdonein a
>     scalarwayinsteadofusing__riscv_vsrl_vx_u32m1()? Iassumeyou're
>     relyingonthe compilerhere?
>
>     Also,have youredefinedthe xmm_t typeforproperindexaddressing?
>
>>     +	vuint32m1_t vtbl_entry = __riscv_vle32_v_u32m1(tbl_entries, vl);
>>     +
>>     +	vbool32_t mask = __riscv_vmseq_vx_u32m1_b32(
>>     +	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
>>     +	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
>     <snip>
>>     +
>>     +static inline void rte_lpm_lookupx4(
>>     +	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
>>     +{
>>     +	lpm_lookupx4_impl(lpm, ip, hop, defv);
>>     +}
>>     +
>>     +RTE_INIT(rte_lpm_init_alg)
>>     +{
>>     +	lpm_lookupx4_impl = rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V)
>>     +	    ? rte_lpm_lookupx4_rvv
>>     +	    : rte_lpm_lookupx4_scalar;
>>     +}
>     AsImentionedearlier,I'd recommendthat youuseFIBtoselectan
>     implementationatruntime. All the rest LPM vector x4
>     implementations are done this way, and their code is inlined.
>>     +
>>     +#ifdef __cplusplus
>>     +}
>>     +#endif
>>     +
>>     +#endif /* _RTE_LPM_RVV_H_ */
>
>     -- 
>     Regards,
>     Vladimir
>
-- 
Regards,
Vladimir

--------------8vqTxjRxI0ZChfDr7wEtTWs0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p>Hi Sunyuechi,</p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 04/06/2025 12:39, =E5=AD=99=E8=B6=8A=
=E6=B1=A0 wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:26aab158.28484.1973abd6624.Corema=
il.sunyuechi@iscas.ac.cn">
     =20
      &gt; why is it done in a scalar way instead of using
      `__riscv_vsrl_vx_u32m1()?` I assume you're relying on the compiler
      here?<br>
      <br>
      I don't know the exact reason, but based on experience, using
      indexed loads tends to be slower for small-scale and
      low-computation cases. So I've tried both methods.<br>
      In this case, if using `vsrl`, it would require
      `__riscv_vluxei32_v_u32m1`, which is much slower.<br>
      <br>
      ```<br>
      vuint32m1_t vip_shifted =3D
      __riscv_vsll_vx_u32m1(__riscv_vsrl_vx_u32m1(__riscv_vle32_v_u32m1((co=
nst
      uint32_t *)&amp;ip, vl), 8, vl), 2, vl);<br>
      vuint32m1_t vtbl_entry =3D __riscv_vluxei32_v_u32m1(<br>
      &nbsp; &nbsp; (const uint32_t *)(lpm-&gt;tbl24), vip_shifted, vl);<br=
>
      ```<br>
      <br>
      &gt; have you redefined the xmm_t type for proper index
      addressing?<br>
      <br>
      It is in `eal/riscv/include/rte_vect.h:`<br>
      <br>
      ```<br>
      typedef int32_t xmm_t __attribute__((vector_size(16)));<br>
      ```<br>
      <br>
      &gt; I'd recommend that you use FIB to select an implementation at
      runtime. All the rest LPM vector x4 implementations are done this
      way, and their code is inlined.<br>
      &gt; Also, please consider writing a slightly more informative and
      explanatory commit message.<br>
    </blockquote>
    <p>The commit message still looks uninformative to me:</p>
    <p>&gt;lpm_perf_autotest on BPI-F3</p>
    <p>we have no idea what's that</p>
    <p>&gt; scalar: 5.7 cycles</p>
    <p>I'm not sure we want to have this information in commit message
      as well, because it is useless. Cycles depends on so much variable
      parts - what freq of the CPU was, what speed of memory, size of
      caches, and so on. This information is irrelevant and become
      obsolete pretty fast.</p>
    <p>From the latest commit:</p>
    <p>&gt;The best way ... However, ... Therefore, ... this commit does
      not modify</p>
    <p>&gt;Unifying the code style between lpm and fib may be worth
      considering in the future.</p>
    <p>I don't think this is a good idea to put into the commit message
      information about what was NOT done.</p>
    <p>You should put all this information (platform you were running,
      performance, implementation considerations and thoughts) into the
      patch notes.</p>
    <blockquote type=3D"cite" cite=3D"mid:26aab158.28484.1973abd6624.Corema=
il.sunyuechi@iscas.ac.cn">
      <br>
      I agree that the FIB approach is clearly better here, but adopting
      this method would require changing the function initialization
      logic for all architectures in LPM, as well as updating the
      relevant structures.<br>
      <br>
      I'm not sure it's worth doing right now, since this commit is
      intended to be just a small change for RISC-V. I'm more inclined
      to follow the existing structure and avoid touching other
      architectures' code.<br>
      Would it be acceptable to leave this kind of refactoring for the
      future?<br>
      <br>
      If you're certain it should be done now, I'll make the changes.
      For now, I've only updated the commit message to include this idea
      (v2).<br>
      <div style=3D"white-space:nowrap;"> <br>
      </div>
      <br>
    </blockquote>
    <p>I'm not talking about adopting the FIB approach to the LPM.
      Instead, I suggested keeping LPM code consistent and leaving your
      implementation as a static inline function. And if you want to
      have runtime CPU flags check - you're welcome to do so in the FIB.</p=
>
    <blockquote type=3D"cite" cite=3D"mid:26aab158.28484.1973abd6624.Corema=
il.sunyuechi@iscas.ac.cn">
      <br>
      <br>
      <blockquote name=3D"replyContent" class=3D"ReferenceQuote" style=3D"f=
ont-family:SimSun;padding-left:5px;margin-left:5px;border-left:2px solid #B=
6B6B6;margin-right:0px;">
        -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----<br>
        <b>=E5=8F=91=E4=BB=B6=E4=BA=BA:</b><span id=3D"rc_from">&quot;Medve=
dkin, Vladimir&quot;
          <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:vladimir.medved=
kin@intel.com">&lt;vladimir.medvedkin@intel.com&gt;</a></span><br>
        <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b><span id=3D"rc_senttime=
">2025-05-30 21:13:57 (=E6=98=9F=E6=9C=9F=E4=BA=94)</span><br>
        <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> <a class=3D"moz-txt-link-abbrev=
iated" href=3D"mailto:uk7b@foxmail.com">uk7b@foxmail.com</a>, <a class=3D"m=
oz-txt-link-abbreviated" href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a><br>
        <b>=E6=8A=84=E9=80=81:</b> sunyuechi <a class=3D"moz-txt-link-rfc23=
96E" href=3D"mailto:sunyuechi@iscas.ac.cn">&lt;sunyuechi@iscas.ac.cn&gt;</a=
>, &quot;Thomas
        Monjalon&quot; <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:th=
omas@monjalon.net">&lt;thomas@monjalon.net&gt;</a>, &quot;Bruce Richardson&=
quot;
        <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:bruce.richardson@=
intel.com">&lt;bruce.richardson@intel.com&gt;</a>, &quot;Stanislaw Kardach&=
quot;
        <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:stanislaw.kardach=
@gmail.com">&lt;stanislaw.kardach@gmail.com&gt;</a><br>
        <b>=E4=B8=BB=E9=A2=98:</b> Re: [PATCH 2/3] lib/lpm: R-V V rte_lpm_l=
ookupx4<br>
        <br>
        <p> Hi c, </p>
        <p> <br>
        </p>
        <div class=3D"moz-cite-prefix"> On 28/05/2025 18:00, <a class=3D"mo=
z-txt-link-abbreviated moz-txt-link-freetext" href=3D"mailto:uk7b@foxmail.c=
om" moz-do-not-send=3D"true">uk7b@foxmail.com</a>
          wrote:<br>
        </div>
        <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640=
DA91443CDF5630A@qq.com">
          <pre wrap=3D"" class=3D"moz-quote-pre">From: sunyuechi <a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:sunyuechi@iscas.ac.cn" moz-do-not=
-send=3D"true">&lt;sunyuechi@iscas.ac.cn&gt;</a> bpi-f3:
    scalar: 5.7 cycles
    rvv:    2.4 cycles

Maybe runtime detection in LPM should be added for all architectures,
but this commit is only about the RVV part.
</pre>
        </blockquote>
        <p> <span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:1" sty=
le=3D"white-space:pre-wrap;">I</span><span style=3D"white-space:pre-wrap;">=
 </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"2:2" style=
=3D"white-space:pre-wrap;">would</span><span style=3D"white-space:pre-wrap;=
"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"5:11" styl=
e=3D"white-space:pre-wrap;">advise</span><span style=3D"white-space:pre-wra=
p;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"17:3" st=
yle=3D"white-space:pre-wrap;">you</span><span style=3D"white-space:pre-wrap=
;"> to </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"21:9" =
style=3D"white-space:pre-wrap;">look</span><span style=3D"white-space:pre-w=
rap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"31:1" =
style=3D"white-space:pre-wrap;">into</span><span style=3D"white-space:pre-w=
rap;"> the </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"44=
:3" style=3D"white-space:pre-wrap;">FIB</span><span style=3D"white-space:pr=
e-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"33:=
10" style=3D"white-space:pre-wrap;">library</span><span class=3D"aNeGP0gI0B=
9AV8JaHPyH" data-src-align=3D"47:1" style=3D"white-space:pre-wrap;">,</span=
><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"49:3" style=3D"white-space:pre-wrap;">it</span><=
span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8J=
aHPyH" data-src-align=3D"53:4" style=3D"white-space:pre-wrap;">has</span><s=
pan style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8Ja=
HPyH" data-src-align=3D"58:6" style=3D"white-space:pre-wrap;">exactly</span=
><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"69:3" style=3D"white-space:pre-wrap;">what</span=
><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"73:2" style=3D"white-space:pre-wrap;">you</span>=
<span style=3D"white-space:pre-wrap;"> are </span><span class=3D"aNeGP0gI0B=
9AV8JaHPyH" data-src-align=3D"76:5" style=3D"white-space:pre-wrap;">looking=
</span><span style=3D"white-space:pre-wrap;"> for</span><span class=3D"aNeG=
P0gI0B9AV8JaHPyH" data-src-align=3D"81:1" style=3D"white-space:pre-wrap;">.=
</span> </p>
        <p> <span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:5" sty=
le=3D"white-space:pre-wrap;">Also</span><span class=3D"aNeGP0gI0B9AV8JaHPyH=
" data-src-align=3D"5:1" style=3D"white-space:pre-wrap;">,</span><span styl=
e=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" da=
ta-src-align=3D"7:10" style=3D"white-space:pre-wrap;">please</span><span st=
yle=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" =
data-src-align=3D"19:9" style=3D"white-space:pre-wrap;">consider</span><spa=
n style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHP=
yH" data-src-align=3D"42:8" style=3D"white-space:pre-wrap;">writing</span><=
span style=3D"white-space:pre-wrap;"> a </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"51:7" style=3D"white-space:pre-wrap;">slightly</=
span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0=
B9AV8JaHPyH" data-src-align=3D"59:5" style=3D"white-space:pre-wrap;">more</=
span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0=
B9AV8JaHPyH" data-src-align=3D"65:14" style=3D"white-space:pre-wrap;">infor=
mative</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"80:1" style=3D"white-space:pre-wrap;=
">and</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aN=
eGP0gI0B9AV8JaHPyH" data-src-align=3D"82:10" style=3D"white-space:pre-wrap;=
">explanatory</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"=
81:1" style=3D"white-space:pre-wrap;"> commit message.</span> </p>
        <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640=
DA91443CDF5630A@qq.com">
          <pre wrap=3D"" class=3D"moz-quote-pre">Signed-off-by: sunyuechi <=
a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:sunyuechi@iscas.ac.cn" moz=
-do-not-send=3D"true">&lt;sunyuechi@iscas.ac.cn&gt;</a> ---
 MAINTAINERS           |  2 +
 lib/lpm/meson.build   |  1 +
 lib/lpm/rte_lpm.h     |  2 +
 lib/lpm/rte_lpm_rvv.h | 91 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

</pre>
        </blockquote>
        &lt;snip&gt;
        <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640=
DA91443CDF5630A@qq.com">
          <pre wrap=3D"" class=3D"moz-quote-pre">+static inline void rte_lp=
m_lookupx4_rvv(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	size_t vl =3D 4;
+
+	const uint32_t *tbl24_p =3D (const uint32_t *)lpm-&gt;tbl24;
+	uint32_t tbl_entries[4] =3D {
+		tbl24_p[((uint32_t)ip[0]) &gt;&gt; 8],
+		tbl24_p[((uint32_t)ip[1]) &gt;&gt; 8],
+		tbl24_p[((uint32_t)ip[2]) &gt;&gt; 8],
+		tbl24_p[((uint32_t)ip[3]) &gt;&gt; 8],
+	};</pre>
        </blockquote>
        <p> <span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:1" sty=
le=3D"white-space:pre-wrap;">I</span><span style=3D"white-space:pre-wrap;">=
'm </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"2:2" style=
=3D"white-space:pre-wrap;">not</span><span style=3D"white-space:pre-wrap;">=
 an </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"5:7" styl=
e=3D"white-space:pre-wrap;">expert</span><span style=3D"white-space:pre-wra=
p;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"13:1" st=
yle=3D"white-space:pre-wrap;">in</span><span style=3D"white-space:pre-wrap;=
"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"15:4" styl=
e=3D"white-space:pre-wrap;">RISC</span><span class=3D"aNeGP0gI0B9AV8JaHPyH"=
 data-src-align=3D"19:1" style=3D"white-space:pre-wrap;">-</span><span clas=
s=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"20:1" style=3D"white-space:pre=
-wrap;">V</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"21:1=
" style=3D"white-space:pre-wrap;">,</span><span style=3D"white-space:pre-wr=
ap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"23:2" s=
tyle=3D"white-space:pre-wrap;">but</span><span style=3D"white-space:pre-wra=
p;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"26:6" st=
yle=3D"white-space:pre-wrap;">why</span><span style=3D"white-space:pre-wrap=
;"> is </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"33:3" =
style=3D"white-space:pre-wrap;">it</span><span style=3D"white-space:pre-wra=
p;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"37:8" st=
yle=3D"white-space:pre-wrap;">done</span><span style=3D"white-space:pre-wra=
p;"> in a </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"46:=
9" style=3D"white-space:pre-wrap;">scalar</span><span style=3D"white-space:=
pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"5=
6:8" style=3D"white-space:pre-wrap;">way</span><span style=3D"white-space:p=
re-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"66=
:1" style=3D"white-space:pre-wrap;">instead</span><span style=3D"white-spac=
e:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D=
"71:1" style=3D"white-space:pre-wrap;">of</span><span style=3D"white-space:=
pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"7=
3:7" style=3D"white-space:pre-wrap;">using</span><span style=3D"white-space=
:pre-wrap;"> __riscv_vsrl_vx_u32m1</span><span class=3D"aNeGP0gI0B9AV8JaHPy=
H" data-src-align=3D"102:1" style=3D"white-space:pre-wrap;">(</span><span c=
lass=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"103:1" style=3D"white-space=
:pre-wrap;">)</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"=
104:1" style=3D"white-space:pre-wrap;">? </span><span class=3D"aNeGP0gI0B9A=
V8JaHPyH" data-src-align=3D"0:1" style=3D"white-space:pre-wrap;">I</span><s=
pan style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8Ja=
HPyH" data-src-align=3D"2:7" style=3D"white-space:pre-wrap;">assume</span><=
span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8J=
aHPyH" data-src-align=3D"11:2" style=3D"white-space:pre-wrap;">you</span><s=
pan style=3D"white-space:pre-wrap;">'re </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"14:11" style=3D"white-space:pre-wrap;">relying</=
span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0=
B9AV8JaHPyH" data-src-align=3D"32:2" style=3D"white-space:pre-wrap;">on</sp=
an><span style=3D"white-space:pre-wrap;"> the </span><span class=3D"aNeGP0g=
I0B9AV8JaHPyH" data-src-align=3D"35:10" style=3D"white-space:pre-wrap;">com=
piler</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aN=
eGP0gI0B9AV8JaHPyH" data-src-align=3D"26:5" style=3D"white-space:pre-wrap;"=
>here</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"45:1" st=
yle=3D"white-space:pre-wrap;">?</span> </p>
        <p> <span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:5" sty=
le=3D"white-space:pre-wrap;">Also</span><span class=3D"aNeGP0gI0B9AV8JaHPyH=
" data-src-align=3D"10:1" style=3D"white-space:pre-wrap;">,</span><span sty=
le=3D"white-space:pre-wrap;"> have </span><span class=3D"aNeGP0gI0B9AV8JaHP=
yH" data-src-align=3D"12:2" style=3D"white-space:pre-wrap;">you</span><span=
 style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPy=
H" data-src-align=3D"15:14" style=3D"white-space:pre-wrap;">redefined</span=
><span style=3D"white-space:pre-wrap;"> the xmm_t </span><span class=3D"aNe=
GP0gI0B9AV8JaHPyH" data-src-align=3D"30:3" style=3D"white-space:pre-wrap;">=
type</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNe=
GP0gI0B9AV8JaHPyH" data-src-align=3D"40:3" style=3D"white-space:pre-wrap;">=
for</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeG=
P0gI0B9AV8JaHPyH" data-src-align=3D"44:10" style=3D"white-space:pre-wrap;">=
proper</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"a=
NeGP0gI0B9AV8JaHPyH" data-src-align=3D"55:9" style=3D"white-space:pre-wrap;=
">index</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"=
aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"65:9" style=3D"white-space:pre-wrap=
;">addressing</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"=
74:1" style=3D"white-space:pre-wrap;">?</span> </p>
        <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640=
DA91443CDF5630A@qq.com">
          <pre wrap=3D"" class=3D"moz-quote-pre">+	vuint32m1_t vtbl_entry =
=3D __riscv_vle32_v_u32m1(tbl_entries, vl);
+
+	vbool32_t mask =3D __riscv_vmseq_vx_u32m1_b32(
+	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl=
),
+	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
</pre>
        </blockquote>
        &lt;snip&gt;
        <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640=
DA91443CDF5630A@qq.com">
          <pre wrap=3D"" class=3D"moz-quote-pre">+
+static inline void rte_lpm_lookupx4(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	lpm_lookupx4_impl(lpm, ip, hop, defv);
+}
+
+RTE_INIT(rte_lpm_init_alg)
+{
+	lpm_lookupx4_impl =3D rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V)
+	    ? rte_lpm_lookupx4_rvv
+	    : rte_lpm_lookupx4_scalar;
+}</pre>
        </blockquote>
        <span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:3" style=
=3D"white-space:pre-wrap;">As</span><span style=3D"white-space:pre-wrap;"> =
</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"4:1" style=3D=
"white-space:pre-wrap;">I</span><span style=3D"white-space:pre-wrap;"> </sp=
an><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"6:8" style=3D"whi=
te-space:pre-wrap;">mentioned</span><span style=3D"white-space:pre-wrap;"> =
</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"15:5" style=
=3D"white-space:pre-wrap;">earlier</span><span class=3D"aNeGP0gI0B9AV8JaHPy=
H" data-src-align=3D"20:1" style=3D"white-space:pre-wrap;">,</span><span st=
yle=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" =
data-src-align=3D"22:1" style=3D"white-space:pre-wrap;">I</span><span style=
=3D"white-space:pre-wrap;">'d </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" d=
ata-src-align=3D"24:10" style=3D"white-space:pre-wrap;">recommend</span><sp=
an style=3D"white-space:pre-wrap;"> that </span><span class=3D"aNeGP0gI0B9A=
V8JaHPyH" data-src-align=3D"35:3" style=3D"white-space:pre-wrap;">you</span=
><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"39:12" style=3D"white-space:pre-wrap;">use</span=
><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"52:3" style=3D"white-space:pre-wrap;">FIB</span>=
<span style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8=
JaHPyH" data-src-align=3D"56:3" style=3D"white-space:pre-wrap;">to</span><s=
pan style=3D"white-space:pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8Ja=
HPyH" data-src-align=3D"60:6" style=3D"white-space:pre-wrap;">select</span>=
<span style=3D"white-space:pre-wrap;"> an </span><span class=3D"aNeGP0gI0B9=
AV8JaHPyH" data-src-align=3D"67:10" style=3D"white-space:pre-wrap;">impleme=
ntation</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"=
aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"78:2" style=3D"white-space:pre-wrap=
;">at</span><span style=3D"white-space:pre-wrap;"> </span><span class=3D"aN=
eGP0gI0B9AV8JaHPyH" data-src-align=3D"81:16" style=3D"white-space:pre-wrap;=
">runtime</span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"97:1=
" style=3D"white-space:pre-wrap;">. All the rest LPM vector x4 implementati=
ons are done this way, and their code is inlined.</span>
        <blockquote type=3D"cite" cite=3D"mid:tencent_A2BD85C9F3B0AA4658640=
DA91443CDF5630A@qq.com">
          <pre wrap=3D"" class=3D"moz-quote-pre">+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_LPM_RVV_H_ */
</pre>
        </blockquote>
        <pre class=3D"moz-signature" cols=3D"72">--=20
Regards,
Vladimir</pre>
      </blockquote>
    </blockquote>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Regards,
Vladimir</pre>
  </body>
</html>

--------------8vqTxjRxI0ZChfDr7wEtTWs0--
