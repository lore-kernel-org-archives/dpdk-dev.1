Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B4C369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 15:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32B8B40659;
	Thu,  1 May 2025 17:54:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9650340609
 for <dev@dpdk.org>; Thu,  1 May 2025 17:54:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746114893; x=1777650893;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hySDGewHKvQuw/SZhdmqARwlz2weZBtF6RxaGQZr76A=;
 b=dl3esWb0wa/7W+qp7OVDZ5+DoaGDQDbCMXE+KAHAnzjDQX6TuNNVLFx+
 vI0ri4Pu6gbXRczrWtS/YSoXwf7QzSIYSYgPacaxJZH/RTkcVfO28jlU0
 YZDz/9vNJU9jiMOoTdu/vMEwaJamwgLhfDGCSYGQtmNhzGLxmoH4/TjCZ
 vz3tamJJY+1CiMoTsPmKeW+q9vw7lf20gMD2vbboQ+rArpaVxAEj3uBSa
 HqG/PaMrqUkW+QEsLvghygD6I5dC0EKynXy5VBd0nERrfuK9qGZoRYW+c
 YsqR7G6KJXkLljWjZVB3ogXEZ4vHxO8gLkUXrLILBHCtZoLi3U7km75Ga Q==;
X-CSE-ConnectionGUID: DeefG78YT4mkMoJ3FuixWg==
X-CSE-MsgGUID: rJ3nGe+cTBqC//WIQ3X1Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="57999659"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="57999659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 08:54:51 -0700
X-CSE-ConnectionGUID: 232hjOXRSmCzvYoefWPMbw==
X-CSE-MsgGUID: vJ5kH4B0RDOVccpcay5r8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="135378678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 08:54:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 08:54:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 08:54:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 08:54:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLV4SVIYLlM4p2JJlKmnJ3w2ayh0MD6ElSmSNE+m5DlDixqv4zjvntIAC03R6NwJNJY0vCkBO+54Mrl98zQhlVdhIu6ydKdn59MHnDBgJ7JQulIDw+W76B9Fs0TxJBNJFA5+xPQFXPULNAqtZhTJk1EGuHoMwvQGNLJ3ibJRMvEt/fXCcznhM5xwFuluFa0B2+CmENRLQTm9L8hr5uaUOBwAnPVO6TvLxhLtYt9pelPWs16vzyl8pY2LJuC8FbGdpypb50lRAtlrSWNKHQ/dSuaUTpCQVn95ugo0YxxEXUehpJfg+Z5dNlmZv/anwfKcg/bpIbQ1eAFMSxqfIw1aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VquNqonxst/hrecgL0hoBP1BA9ry7z4UE0N08jMyVwI=;
 b=NAPpAvZib4RzWztjnCJ6gL2W6naKlu2fWexeJYtB95QrTJPQcmLlDfq/6i94kpO7wk1OZAIO0SzMdUZSuugdbFVfxcq+5UyXlzx3DQeBHt3IhMx1x6qcDDim8elrPYTnTRwIbHS1MxhqA1118rsYyq2t5dBYX1isW5516H78pU3bNGmiSQ8q+tP3oJtmNlseG7/LhPm02i+Kj7B/ZjWiwzIOzJtl52yEqFUkV2L+0sq73F7GzcYaYASSr9194nz1hK0MKTzWf1oCigSzVoFd8jKNASHp8ys+pIMFRXER8Dg5Lj0kTprGE+FlodEPdfB82DGvlQczRUvJnPHXIh9DGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by PH3PPF5ACB2DC0D.namprd11.prod.outlook.com (2603:10b6:518:1::d23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 15:54:29 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%6]) with mapi id 15.20.8678.025; Thu, 1 May 2025
 15:54:29 +0000
Message-ID: <e762328b-559f-4af5-b387-26808653cf82@intel.com>
Date: Thu, 1 May 2025 16:54:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc/nics: document how to create large VFs for iavf
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
 <20250224152611.1012935-4-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250224152611.1012935-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::15) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|PH3PPF5ACB2DC0D:EE_
X-MS-Office365-Filtering-Correlation-Id: a04cf4d4-8fe7-4c95-5060-08dd88c87496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0NvaFVvcVlZc0ZDT2l4dWp5SC9pV1pJZUkwVW5FMnU5REI3MmsrMHVpTjJL?=
 =?utf-8?B?NXdPK2k4b0Y1RWtORmY3amtWSTdKUkhmRzU5WmowZmxRcjZ6cDVzZ2NkdlEv?=
 =?utf-8?B?a1R2cm1rMnJDVlJsajUyRFV6QVJQYmVjb1U1ZldRa0F0U0ovTDl0NTdBUUNt?=
 =?utf-8?B?SEJPZGM5VjV3T3BMS1RwbktrVms3bUVoejNwSnNNeDR0eGUxN25IYUU5T2pW?=
 =?utf-8?B?eHNWa1l3aXVuZCtueVNBdUdaQ29QUHNYMVVFcnY5T25LY2x2d3YrS2dBbjZI?=
 =?utf-8?B?UTB2NnFrU1lybmpzM1JPM3NmYURWbnZNdlhkaFlWZXFCRzlKZFppQ3BJajZs?=
 =?utf-8?B?dFVHajJBTUwrbWdoMk1mTlBDOU5jcFN2U0hsa2N3b281MjRQanJ1QnR6RzQx?=
 =?utf-8?B?UjdyLzVWYnIraWg5eS9NblE5S09DUGpVNTNMcDhPWHVieWd0RUdwUGdaM3pI?=
 =?utf-8?B?bW1PS0kxbjc5NkFCa25PZDJ2YUl6TDNXQ3lCeWRVeitMODdFRWw1YVRYcEc4?=
 =?utf-8?B?WjZIS3hYejQ5Rmg1MDNBVUEycHNXdzFxcW1GdHhXVWRmc3YraVN1ZU5kTHBY?=
 =?utf-8?B?MkwwVy9Cam5IWFluZUVkQmdPc3AwOTZkb2E3bm9icCt3bFVyTHo5TUNNVVpK?=
 =?utf-8?B?RU5rMUNyTlBGd3loTk5zR1JTcHg1dTQ1b1k2R01WSVB1ejFBQWdScUdqMm0v?=
 =?utf-8?B?QmE2NVp2OTZiLzBFVWR6Ylc2Qkd6Qk1XS2VlRUM1MVkwSnNuMFhZMEFJTEpn?=
 =?utf-8?B?bWNUQmN1Q3FTalViZHZiaDlEZUt2KzBocXFRWiswQVg4RkY0N29GckpoVjdD?=
 =?utf-8?B?bnA2UXFNU1UvOSs0Mzk5T0pYSjZCdlcwRGI0UXhtemxiQWw2QkJhVjhsUWJz?=
 =?utf-8?B?c25qNzVWcnZqTEFQeGRvdm4zcFN5YUQ2aHJaRUVzMGdqclZtOSt4RU1QQVF4?=
 =?utf-8?B?OVFjVXV4SndIb0V6NkprWCttV2F1cUs4Ujc3QllNOXBwakFHL2VQQ2UvNDFV?=
 =?utf-8?B?U1Vad1dpSkkxZmJ0NHNUbFJxYzVlV2JsQzZqZm9WR2EzUWRKRUxHajdyWXpN?=
 =?utf-8?B?VzhYZzFLWE9ST0ptS054RGRRU2FJeHU4eThVU0ptTGJHcFNsNENZd1ppUS9q?=
 =?utf-8?B?NHYvd1pKMkhMblltSlJ0ZEl0a2dIeFI2V1p1N01mMit0VkVDYnRHN3A2dHF0?=
 =?utf-8?B?K0M3NFBsRnZ2OFc1ZWh0YWlkc3VDR0h2S2swVDdFcnVsZU95TFBodncwK2pK?=
 =?utf-8?B?U3BjbUU5UHZVM1ptbFFxSkRLd0VZQTZvN3JwbkF0MEdDL1plRUsxRGRiTVRu?=
 =?utf-8?B?ckdCU2VIR3lXNWZNbk1DT21IYTFlU09tcGhhVHRXTnQ0KzlLUG1PQXFkZUw2?=
 =?utf-8?B?UU1SQUVDV3hIUkh5OGk5c05WSE9tQm9vLzMvb2NCTStZVndaalZieUprajVy?=
 =?utf-8?B?SkdRTnFYU3hVRE9DQkNCcjZHTkJpdXhzeUdwTGlNTjkrRFBPOXRDVmtDdVV2?=
 =?utf-8?B?eUQycERFYnpUMTByR2QwTDJSUWZrSHRsTjRybXF4Q2ExcjUzRm54LzZZSTBq?=
 =?utf-8?B?Wk1SU3lxWkRZM1VnSUlzMkpxOC9iWU5QTllnQm4vU0tVN013aVRnYTB3MFRB?=
 =?utf-8?B?N3hudlR5KzZPU0lpWW1JQUNKVkpVSWo4Zm1CcUQrd29Wc20rV2NNSzFHOHZH?=
 =?utf-8?B?cHpRb2VkNVpnUkxRanJZcGZhRVVlMzliYnFndExuQlVCQ0lTclJtUjJrdWhX?=
 =?utf-8?B?RDJrSC9BSmhkemUvNjYwQk96NWpMOXh3Uy90M0ora2ZYV2cxNkxwN0FVL3Fy?=
 =?utf-8?B?dmVQMzMxdHorak5HWXNTV2VwUEMramlBVFBqTDUwOHdOcTFYZm1iUVFSejRp?=
 =?utf-8?B?dWFFMk1Bd1ViMWUyajhRcXBxaSsxTElnVER3Tkptb2MrVGU4KytnUElHNTYr?=
 =?utf-8?Q?2Pkl63VNqQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elMyNjJwQklqTEFDRk1GRlVKeFlKLzRORmpBUUpVb0JXNEUzRjJVN1pKMnla?=
 =?utf-8?B?RzBJN2hSeUhkUis4VHh4WlBtVzZSQXArVllPR21QT3FyZVF4N0xRZWxTK2RT?=
 =?utf-8?B?d2VCdmVPaXNwUU03Skx1Q1BsdnJNcyt4N0ZSdDAwdVhoWW9QUUNodUFoY2pk?=
 =?utf-8?B?MWxIS2t2ekcxMC91UVJOSzQ1RTVra2o2M1dOTFJBUUlpYklsQ0tRVUFsVlpi?=
 =?utf-8?B?TFVPRHN2RU9JM2VGemViVGtTOVZsS2dpR0dkMXZBNVBydjEwTk9PYmJ3V2lr?=
 =?utf-8?B?d20zanUzcWFqakhZWHZJOW5FUTNyWTBEQ3FGYStLclVqMkJoaWJoendtdWhx?=
 =?utf-8?B?dDJkVXBmTkttOHlrZWpYUXBId2pHR2p0NU90WUVrbzdTT2NTQzU0MDRNUzI1?=
 =?utf-8?B?czB6ZDlmZUJBYU5HUEJqajJ3SzZkclhkN09GcE9yK2JjOGlIQnQreDdLTDgv?=
 =?utf-8?B?RDM4MGRaekplNXFUMHFFaGhaK216OE5odyt5QWVwdlVZazlobkpadGw0eHds?=
 =?utf-8?B?cUtZM3NRMkJUdktESE96Wk9YeUptR0tNb0pXZm9oVmZMcmtkS1czOC9CQmlE?=
 =?utf-8?B?Y0xacVlKVzZSV1RBQ1BicnZPQ3R3T0FNeFhUck1iMXQzYnBMaUpjbXpjdXdF?=
 =?utf-8?B?TFNXazRoTmdMUFhNRE9tYms3SFp2blpIMmlSQWZqT0tVWGhFSlBSMlllNmFp?=
 =?utf-8?B?SnlDYVp6NFBQSWZvNEhpSGYrbFBDZ0NjT29jeFlEMldyNjVIVlBBQ0VXRXhF?=
 =?utf-8?B?WTZsYzhTVmtWK0ZuSXZYVk0zSkcyNU1VOUREb0k5N1BLcFM5aWtEemNFN2I2?=
 =?utf-8?B?dENlZU1SRkNvcFZvaStaeHdOTGhyNHBEdlUxa2tzVmNqSmhteS9MUHBERmM1?=
 =?utf-8?B?ODBnZndiWFBIQTFjWVorQ1p6NWRka25DdlpCQWluekxkY0dTS2l5RlRCVWF4?=
 =?utf-8?B?aFNmMWpMU3NtazNRRnRlUVZkYkRpK3Qyd1BrUm9IL0Z0Z0oyZ2ErWGZDaHdD?=
 =?utf-8?B?UnhXcHNHMU9JOTh1MXBVUnFGWUhWNlJxWFpqaEhIZmdQTUN4c3czVHg4RVVK?=
 =?utf-8?B?dzJObTVIY3BMR3owdnIrbUNjazZUMExsN1M2TXoxMlRyaDBWcEQraVl3TmZw?=
 =?utf-8?B?Z1F5WDl2VktlM3NpRzlYQTJaa1EvTXhnQlp0MTVIMDlXd2J3QzZMWWJ6blVp?=
 =?utf-8?B?Mml2dVFjLzRZRmg2M1N1RHVFWGk5UXRyQ2k0R3pKMVE4clZaNHJXa0hFWjB6?=
 =?utf-8?B?NXVoWWxqMVQzR3B1NURHUkttSGxzdE9UbnNFSWV6TXlZU3hHU0QxNGJlQVlo?=
 =?utf-8?B?WW5uTmJFSjZxeXVYc29OOTlaeGhka0JJYkhWa1RteFVsdVVBdHppTHFVcC9z?=
 =?utf-8?B?Z2NuekthRlBvUytBRDFTdlBjaWdLQ01XWDAyam5zMG5icjZtb2NhUU5mYXZE?=
 =?utf-8?B?L0ZLaUpwN2l2WmVJcDlzb1JYZWl3Tis3eTVFTEtVeG0vK2Z5TWhHZ0F6UkND?=
 =?utf-8?B?WEFud1ZsbFBBazBaQVA3aHlYWjZsV1FuYjl6azFuR0dKWW15a3lPbGtYK09k?=
 =?utf-8?B?dlVqbkppR09EeDNKeUlPcDMzWmlmMmhrLzV0QXdmMDlCUnR2NDNaSUhhV0Mr?=
 =?utf-8?B?UStzUmlpR0F3T0poRkcvZlFEQys0L0RYZGdZRmVuNmZRYWgyZXVnWm9LTGpU?=
 =?utf-8?B?SWgxQjNNNndrNXpRaW1LL0R1TGpNNnNXLzV2UDlYbVBFWXowUGZzT0pxOCtQ?=
 =?utf-8?B?bEh2S09oMnc3ZDkzN3UrVk4zZjNKb3Bvd2JaT2Z6akRqeXUyd2JoZlBjdlNp?=
 =?utf-8?B?VFF2NU9zZDZLS25kYmdQNjdhV3U5azdiR29IcFovdEhpU0JiY2hxMzNlckNs?=
 =?utf-8?B?SDRTSkcvUk9mWUk3QS80Z2Fia1grOE8vWlRnQlVGV2s3Vld2MHErU29XOE1L?=
 =?utf-8?B?dXlwZml5cUZ5dDFHQm5uRTFZdHMwS2ZVYkkyNFd4UDFvSk8ybzJXRHpQS0Fn?=
 =?utf-8?B?QmtpK0EzV3IxbVZRWEY5Y1BOSmlYVU8zL3FmQWNxa1BjdU5pVFFXbEJ2M0U1?=
 =?utf-8?B?WGNOaEZFYityTVRJMy9oclAzbjlvWDNhUzFMa0pGOUlSMWlqbjREZndPT1g3?=
 =?utf-8?B?dW1PdnNPdXEvdFdqY2wyYk1CSWpWR2hEaFB5NG5Qc2JZdlRCOTlaQzg3TDdl?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a04cf4d4-8fe7-4c95-5060-08dd88c87496
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 15:54:28.9986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ5FsjnrHzDiirTWpsUGo621dOL0IMt/THbBF5wiI8ltvSS2ItpFkjkQ0UBKDpddrInZ3YpE9A7q4SI1J7DPxR1e7wU0xzfnrwjIENi+iFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5ACB2DC0D
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
> Document the additional step necessary to create large VFs for iavf when
> using ice kernel driver v1.13.7 or later.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   doc/guides/nics/intel_vf.rst | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index 708cb85417..eb939df41a 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -138,6 +138,11 @@ Intel\ |reg| E800 Series Ethernet devices:
>     for example: ``-a 18:00.0,quanta_size=2048``.
>     The default value is 1024, and quanta size should be set as the product of 64 in legacy host interface mode.
>   
> +* When using the Intel out-of-tree "ice" PF/kernel driver v1.13.7 or later,
> +  to create VFs with >16 queues (aka. "large VFs"),
> +  it is necessary to change the rss_lut_vf_addr setting in sysfs from the default of 64 to 512.
> +  This can be done using the following command for the first VF on an interface:
> +  ``echo 512 > /sys/class/net/<PF interface>/device/virtfn0/rss_lut_vf_attr``
>   
>   The PCIE host-interface of Intel Ethernet Switch FM10000 Series VF infrastructure
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
Regards,
Vladimir

