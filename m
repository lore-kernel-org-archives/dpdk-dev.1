Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A21D72372
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 10:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A39D84026F;
	Fri, 23 Jan 2026 11:45:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 350DE40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 11:45:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769165111; x=1800701111;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MfIt23UwMvOkewuPq3ZXrNB5OKgtsmVE9+p1P1/kHVI=;
 b=IOUp+Y67jsRdCxLYrnUK0OJGOQjdiAP7KfcnJlCyEoDwonsFfClRt+l8
 TClOvPOlNc8eocl9NzsfRoMkx2z6xLFJf1sZ8MDyRMf+T6fKOL9KbEas6
 8QEPvbi7hVxPbsgCtjIsz0f7ZPa/388a/aal6NV2Rt9UDGz3pR364XoxT
 6YAPr2RN87JRyfoglhNJTJH3ie0ss6Xm1KyIS7Wk5TOZXAoYkSnAJVzqr
 Jk55TRYt4l2okoE/l3pVFb9VGOygXCP7wjBtr1WsJZhQq4aDUfE+kcAii
 AFvZbG97zbudNpa1mx8vS5qj2ClW+qRv1sk6e7SEDmQHPt+Rd9aX2hKRn g==;
X-CSE-ConnectionGUID: J1bRZ64PSq+iZFYx0vLAuw==
X-CSE-MsgGUID: tZOvyTSCT+WQbcRTqnMJ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70582212"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70582212"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 02:45:09 -0800
X-CSE-ConnectionGUID: gG0UcnjOTEyGqVr3E3IxVw==
X-CSE-MsgGUID: vobXedN3SMeV0rIVeNwpsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="211497682"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 02:45:08 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 02:45:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 02:45:07 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 02:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J138AgbNVjhs+tgP9IimY46Y/w7FuP89mXejAlbhJvS21PAI1Zyg5FqS+Oik2tKcs867DM5IMF42KkPWUaptyEFVPQoqk/xadB9nAqFEaSpVrDCw8OyyOyNtKYbck7HnSCM6nFmIYz8NcslPCyEaSqIWh2A6K/hMo6ZnYDZ29hF0fwz4nkHmM7wp1cPMDoh3SfwlFGnGPCk4nuuan2LtWo10QqbsQy4Z1qWbYuHTeP+BXRRAQP9Pb0AgHvui8FXLsEmv+DDDPTvLwboGLnl1oCalhgJywAA6ljthe2gQGSkBeWupJRCsDt3cT4rjwahGNQ+/xsTdLFAv8syXXf1L6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocVaHSLWnxMCv5fYdO49ectdAr5SZ1a8vzyY3KxZpsU=;
 b=MiS6udoxma0/18aUe79misU0UljexOkrWToPCaKhrQEOZzx8q1EpP/j2Rm9eQ5IsntG6k5Y39b3rqprfCgIrKISLoMPnF8JgaPOCks/+lERyLNvZAvdYgM7LFvvNS3JZmI4NwgeG6o+CAvV7OGTogtlwkK57/FE2ssBt+KELA25pzXmv/FvvzsBiVGxvXea0Hm4LaFENdg3/GqtE4SbyV5lqHWsKXRsLGwfziQOhf+uyzJm8EZ7LtTQm4gA7e/RxEjA2v6DUHx2sZ01ecDKD1arJANUCVkMS16tMP2ZZqq1oYDK7cufrzGlZpPwkJ5076+kazigN/tqml8fZa/AVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Fri, 23 Jan 2026 10:45:01 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:45:01 +0000
Message-ID: <8cb11577-9401-4b76-8f56-e19144376159@intel.com>
Date: Fri, 23 Jan 2026 10:44:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] cryptodev: add support for 256-NxA4/5/6 algorithms
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <nkaithakadan@marvell.com>, <kai.ji@intel.com>,
 <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260122102606.2531599-1-radu.nicolau@intel.com>
 <20260122162310.5a1e1320@phoenix.local>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260122162310.5a1e1320@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0044.eurprd06.prod.outlook.com
 (2603:10a6:10:120::18) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: b45e1be2-3326-4f9f-4589-08de5a6c758e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGY4VU1GbzRuSjhNR21lMDloRXdjMzEyRlJpQWwvWTc0VEx1d3ViMEJWUFJk?=
 =?utf-8?B?ejV5QUErQlpXZ2Y3VEYvaHlwazVjSkRsSHNSYkNkS0w5NnduTnFKRHBQQ212?=
 =?utf-8?B?ZmFTSnk5ZkMyWTQ5NnN2UDFuclJaVHozcVBpT3hzUzdvU2d1NVkrSWNSUVNT?=
 =?utf-8?B?WUhVQUcvL2xIKzRwSEFXY1UyYW91Wk9sa1lUNlhNQUNxbGUrbVlsZmtqK2cz?=
 =?utf-8?B?TThhZUUrQ0J2dVMxeGRPY3d1WU5Ld0xEVHBDQ0h1RTM2blY1OGJzSG1vdC9u?=
 =?utf-8?B?eDJwdWJWWWFyQWx4SFBpbHZVeWZCVXVjT3FDWlZwTXFPSVBtdjd4aDROSmxX?=
 =?utf-8?B?Z21jZGlQaHhGa09kOXBGcUlPbEtrMTQxWW9Ib0E4MXVUZzUvN1d5dUhPd2Ju?=
 =?utf-8?B?bkVsOE0rNThESWFRN2RxWlRYM0wwZjZ0RTZ4UXpkc0NsSXFGaU1OK2VUbytP?=
 =?utf-8?B?cmJLYXlNVzJJL2psSmp4ZlB0Zmc3T1cydWtKSkswaStjVVhhalhQdTNSVGhZ?=
 =?utf-8?B?R1ZUTTFDOTBQdVFPSGFEYzExanZUTFRIWWtqa212dzZ0UVNQMUhJcDJ2bTUw?=
 =?utf-8?B?eFVrVWVCNU9qMG12bWFQTG5ESHRvN25rZm5ycTBOR2hTWW1LOWFWU3BZSm1t?=
 =?utf-8?B?cUdmQittM0EveFQ3dUxCSVZ5OVc2TmRPbzEwbjdPUGVlR3Y0M2tpRFpnbVFj?=
 =?utf-8?B?YnpxMGZ0Sm5iLzV2V2NmNHJBNnhtQnBLMDBrcjRpckU3clRBNDA2cm14WStO?=
 =?utf-8?B?NVBZR1B3UldCQkJMWUxwbHV2Ny9kUzE3anJQS1VYeGxHWUp3UDU0clNwclJE?=
 =?utf-8?B?UDlFc0V1Rm0yV2xUR25lTGpWbThjaGxEQ3VuVTAybHBqY3RoVmZRcjRlMkhs?=
 =?utf-8?B?S1lNc2Jqbm5jT2RPYnVqTVovRE94cEphQmRYbnJUQ0lsTlZLR0xFWTBTaXl0?=
 =?utf-8?B?dkhHb1JwSE1HSGd6T251Z2lPT3IwTEZCcEcwdVBWeFFNUGg0ck5zQ2pPVGNz?=
 =?utf-8?B?MGlsYSsvM2hNc0syYjVsb3VBanhldVMwcG44dGE3bzU2Tkg0dmtiMXdmekVj?=
 =?utf-8?B?a2VzMGJwWE5aeHphaytVTG52TEFEOERGTHZVZ1lPcXdmcnkyYnNUS0hUcGhk?=
 =?utf-8?B?Y3I1eTZENnBrSzEzVzRncEVMV1RPeWdEOFBLT096REd6anhBWCtoODZNOHhI?=
 =?utf-8?B?aGowQ1drbHJMeVczYUlNRGhGcHVvTDJyTlNsc1hueWh4cm1kdlZVNlpUcFFl?=
 =?utf-8?B?eHZEbHNDYmc2aXFlYlduOGpUdmhrcHNvcnB4SmNYVGtKSEk2ODlSTnJ4d1g4?=
 =?utf-8?B?ckpYL0twVWQrNjYyVWowcitwMzBGZjJGakZUeW5EbDNIdE9YUUMzK2pwQmIy?=
 =?utf-8?B?a25RMmduSUxzaVZZbldRanczTGNmcVk3dGtPMGgwTFV5N00xd0JqeDQyQUxI?=
 =?utf-8?B?d3pMQ2psL0pPV3JKWU83bzczbGsrK1hzbG1TNGluZDlBRGVJZnFEM3IwZStF?=
 =?utf-8?B?WHdtTnhlN1RFRmMxQ0JTL2poKzdHdnNZQmREd01vMjdZdEtXUGF5a2t2cWJn?=
 =?utf-8?B?bWJtYWcyUVRQVWRGcG82b2ZuUDU1aldWRmtWRDRkQTZuWW51d0ZJMTQ3R0pm?=
 =?utf-8?B?VTJBQXNTWC8xNEpEVitYWmdrOVBGaHFFamxJMDlDQ0ZwRzR6dzNDcXdtUVhY?=
 =?utf-8?B?WFZreVY2NHVITGU4ZnQyWHpTWEgrSGJEM0ZvZEJkQURDQyswS0NESGRrYTl1?=
 =?utf-8?B?cVd6dHc2enR2b1hLc2JPL2JhVUMvdW13S2NSdWVMQkVNNFFUSmw1UG1GMzlq?=
 =?utf-8?B?bk90TEhXekNWSWJxM3U5c3dnQktYNjVkVmR1R0Z2QStSZUZab2RyZHYxSkZL?=
 =?utf-8?B?UjJnUHJBMkxPcUVzNGFEUnhhWWZpY0tnc2k4RXVtUWxHSVVibG5RL0JvT0pE?=
 =?utf-8?B?YXU1QWxIWUR1clhjdm81MERpcVBjbFRJSitMcG1WUzlWalkrWWhBcGVnOFU1?=
 =?utf-8?B?OVdGMUlMQmdrVnhLMmx2eXhsYmdNNy9vTm8rUC84S2k2UnZzSVpyRGZ4aW5C?=
 =?utf-8?B?SUxjWUVnUi9CU3hobi9SMFkweUF3ZXJzNnhOSkNEUVN0bjFKYnlOQmpNUFNT?=
 =?utf-8?Q?DlZk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWVNejVtbHozeHZlUHE4MFdsWjVsNzIrdExVUU9UNE9RaWJOTXNCQ0VKV0o0?=
 =?utf-8?B?cUdMRlBzbXBNSWlabDRwcGNHSTJaTWhHOGNRN2c0M2ZpVmtrMWpwbUlCdkZ2?=
 =?utf-8?B?bGFGdG9mZGlsS3JobFRxNWpYOVRaSkJXT0ZJRG5SUkRyQnA3NWROTTY2RFU0?=
 =?utf-8?B?Ky9JL0NlR3RqL0FscTlmODV1OWVkSHp6azYxajBER1lhU3FZbklYTmswcTBk?=
 =?utf-8?B?VFFsQUVIdE5qZVFBTThzQ09TNGxXRmJ3dGFDZUlpRWxCR3NSQWQ4UGUxdHFC?=
 =?utf-8?B?aFNRL2kza2dxd3VhbDdBalU2K1hyQXFpVGt6OG5icDlHdG8wQ1NiUlg4UlJr?=
 =?utf-8?B?M0hDYmk5MTJmOXVDKzJRYlo4N2thRll1ZHExMVpjUERnSmpwVGp3c3BtRVU3?=
 =?utf-8?B?YTZHUDJtK0JOODRvOUZ5RzkzVU5TaVVrRnc2Y2EvWEZpWml3U0ZDaGdYTnlu?=
 =?utf-8?B?SW9ZRThUZnZuM3VoOG8rQnAxeXFhbWJMRS9TUW8wZkdRcXcvZkxsNXNZUnVs?=
 =?utf-8?B?Ui9FOWtrK0hvN0pDZUlFVTQ3Z3Z2d3k0RUl0bzBtRnA2MFdoeTN0ZXMvWkJ5?=
 =?utf-8?B?UDBpQ3JyQ0FrRjllaFR4RWVoNU9NY3EySlpwNzY3VFhpaGNKdUJ1VUhsUXRL?=
 =?utf-8?B?bHA5SHZGeVhENjl0VmRld0JwVXdENzc5c0xaNWR2a3Mvd2c5Ny9vVlZ5UzUz?=
 =?utf-8?B?RFMvTmhPZjVyUnRQMW1UbXZDSlJUb1FrOTNOUVV2aStmNU1tTlc5cGpxWjA0?=
 =?utf-8?B?WGw5WXdhUzV1WGd1VlQxMWZMOFRLeitRYjUzNjlzNjFyTkVzbEFQa29rTXN0?=
 =?utf-8?B?eCtUQ0tyWVZFTDV0VCtCTFoxR05ZNTFDbklzdlU0SDc1aDgxYTBqVDRIek5C?=
 =?utf-8?B?U3QyMlgzL1B1VURNRGN6UnRUUjJ6YkRleUZsR09ZSGFTQTRDa1I1dklMUlov?=
 =?utf-8?B?Qkp3RUJ4dlo0cnRpZEozc09XeWk1eUZWUVdPQXdrNjliaE5DekR2U0E1WkQw?=
 =?utf-8?B?TnBHTXNPUGp2R3Vkd3JRZ1luM3g5RERhaWp0TEtQbzRQWmFTTVNuSU1GN0Vp?=
 =?utf-8?B?SEloNUJWNGNoWEtKcEJnYnI3Uk90MlBRYWVab1RGZXNwb0liUEIvb0QvclJJ?=
 =?utf-8?B?VUdCdTBNQVpqRzNWOStGcEM1UHZmU3R4TzBSdlhjNmVHeDlteSs2RDlMOXlF?=
 =?utf-8?B?N3RNbW5Lc1NxVnQ5NHVDZXc1WWdMcFVXV05SR0NkY0xCOU91VlVXZWNtd2E5?=
 =?utf-8?B?NnFlNUdFTi9kNHl1VEhYc2JWR1JMTi96cWtGYlhCWnNwL3JHTUsra29wVUtJ?=
 =?utf-8?B?MXRpakZob2VFbUt6RjJZTTZsa01Ya0k1ZXl4c1BDUENHYk5ZdnM1MktjbzlM?=
 =?utf-8?B?dTgyNk9VVmkvcCtLN0JRSkJKN3lMRVN1ZkpBU0lYZ0pmTnBSZ2kzUTZ1b1pX?=
 =?utf-8?B?ZGI5ZnJpWEpBVTF0UVRHMko3Ty9WWXdiblI3S0I4cUs0TEhoYS85N29jWnR2?=
 =?utf-8?B?MTN6bDA0YkxsclNia3ZzbWhkR3NzaUs0cVFnUitjSTdpVWdNSWZhcTQwMmlK?=
 =?utf-8?B?VlQyRURCUUQ1aWNTaXZ4NTNwVGRtb0s0dEVJdXpXZW1uR2JWUGFpT3hCbkJY?=
 =?utf-8?B?eWJhUno0TytRN1Q1bktzekk5VlNFYVNqTEcrWjNUcWVkSnBVdWxqTnUvYmlO?=
 =?utf-8?B?THVFN2cvTWthK09rdmQwbmhVVGNOZG9nd2gyNndGaThHR25mUVVXZm1TUEo5?=
 =?utf-8?B?QU5uQ1BiQjVVZHQ4a0tWK1p2VktHTmZZWER6K1JRVE0xNk42RlFGNDRiMHRS?=
 =?utf-8?B?ZFF5NjdQeXRJOE9JRFk5dVh2YmttTTR1VFA2YUZKd0Q4eGxHSTI5V2x4Nml6?=
 =?utf-8?B?L0ZFVjNvdDVQRklvVjkxZ3J5aDZlcllqVE1wVjlWeE1yV3Z3NklyZ3BPMG9k?=
 =?utf-8?B?V2RNMDgwQkx2SEVSMllrUHlxTFErV1RmQlhEbVBRcGVMTk5paFNWQjZ3dXli?=
 =?utf-8?B?Z2FXUnk5V1cvN1pZWjJTdk9zeEY4REVPanVabGQ4eTBoWWhyNnhucStNdU56?=
 =?utf-8?B?bFVERUhSUnZDSTNZS2J2M21kYWdJcWhzZW5CLytJNU5YUHV0YVRZMnJtSzNH?=
 =?utf-8?B?SU1WWGp4bHM5eWNSWUVpVUkvUE5YNElBVjNIYUhXYnhabjR0MHo3ei8wd1JO?=
 =?utf-8?B?elYrRFd5N0pTcGNOaVphd2hGTnQwTVNaYVlLUk1SeEV0d0xVV1MrNVN0NFRi?=
 =?utf-8?B?NDhqOEFtYUIrZnZDZVBlc1prTDQyakFuazBXcE10eTY1ODk1enFGWDRrZG4z?=
 =?utf-8?B?ajUyVlR0cWp1L1FkK3J3U0xtZHUrR3lxUnoyMGozb3I4NTRRV0k0dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b45e1be2-3326-4f9f-4589-08de5a6c758e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:45:01.0536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sANQsgwRIhdvRJNfzhGDeaAxb1AUbGxcwFip3+MT4fFjiwPdm5KoWX282swpYZinI7HfsCj36Po7sDgeru1Mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
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

Hi,

I  will try to improve based on this, also some comments inline.

On 23-Jan-26 12:23 AM, Stephen Hemminger wrote:
> On Thu, 22 Jan 2026 10:25:33 +0000
> Radu Nicolau <radu.nicolau@intel.com> wrote:
>
>> Add support for
>>
>> NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes
>> NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes
>> NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes
>>
>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> Working on AI based patch review and used this pair as a test case.
> The results showed some things (mostly documentation) that could be
> fixed and also some false positives like recommending adding __rte_experimental
> to enum.
>
> <snip>
> ## COMPLIANCE SUMMARY
>
> ### ✅ Correct
>
> 1. **License Headers:** All new files have proper SPDX license identifiers
> 2. **Copyright:** Intel copyright notices present and properly formatted
> 3. **C Style:** Code follows DPDK style guidelines (indentation, braces, naming)
> 4. **Commit Format:** Signed-off-by present, reasonable subject line length
> 5. **Test Infrastructure:** Proper use of `unit_test_suite_runner` framework
> 6. **Code Patterns:** No forbidden tokens, no unnecessary casts
>
> ### ❌ Must Fix (Errors)
>
> 1. Missing release notes update
I have looked prior to send the patches, in the past the additions to 
the crypto lib algorithms enums were not captured in the release notes.
> 2. Missing API stability documentation
The documentation is consistent with all other entries
> 3. Insufficient commit message detail
Will add technical specifications numbers
>
> ### ⚠️ Should Fix (Warnings)
>
> 1. Inconsistent algorithm naming
> 2. Incomplete API documentation
> 3. Test helper error handling issues
> 4. Missing cleanup on error paths
> 5. Magic numbers without constants
> 6. Memory leak potential in tests
Will review and fix if needed.
>
> ### 💡 Consider (Info)
>
> 1. Reducing code repetition with macros
> 2. Improving test vector organization
> 3. Adding more descriptive error messages
> 4. Using constants for magic numbers
>
> ---
>
> ## RECOMMENDATION
>
> **Status:** CHANGES REQUESTED
>
> The patch implements the core functionality correctly and follows most DPDK conventions. However, it requires:
>
> 1. **Mandatory:** Add release notes entry
> 2. **Mandatory:** Expand commit message with context
> 3. **Strongly Recommended:** Fix memory leak potential in test helpers
> 4. **Recommended:** Add comprehensive API documentation
