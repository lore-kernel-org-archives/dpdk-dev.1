Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD01CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 12:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06A92402A8;
	Mon, 13 Oct 2025 14:43:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 22E724028C
 for <dev@dpdk.org>; Mon, 13 Oct 2025 14:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760359422; x=1791895422;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wWLzXomPEj9ZE20hDs1fYMgGcsHRPMz7FVNIHroBnak=;
 b=HGW7gduV5T61UHf9maywjcGhCah81pDbOm0MmGu0fCCbAmBZvo79sRjJ
 ILrIOJP3m/UxAbPioYxrDHk7Zwmc7oR4GEHKApjaqE4TJLq6b5rw64dCH
 b2wKMnmqgnVymJ1WMglxHlTzEYluzr3A1KmjU9PKKbdNbW8ggy1tmu1u6
 94Fbjh1c3bUfZiCsfuFNvwRGP1PosLVXPQIJWTQK8lHXAWede9rERSIFF
 kRGLnN3qPqT/yTcaNRG5qsEcHP7c0HLn3ABTSE18wz79I1guKdg70HRXM
 Uw839hZjPbf6MQllKG7BrC+lgxK39EdyNYthB9EFmvNDGcnjl+eKaSAOB Q==;
X-CSE-ConnectionGUID: 7xVyGQElQZKRZKGhsrmlkg==
X-CSE-MsgGUID: zmxDcJ6NRfOCbZaHWIh7aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="79938869"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="79938869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:43:41 -0700
X-CSE-ConnectionGUID: s05OHI6bRQSGDHIN//3Wpg==
X-CSE-MsgGUID: LKCUyeSzTlaFck2SrTjsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="212547467"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:43:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:43:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 05:43:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0BBgRS53qLeUQJtgFmQuLGjxdAw3TVs3tk2TuryMNQ9p4ekwkRRDpwtP72o08XhExFCtwsvp5HwkIkYGETqdNAcc3j9CWcJCa4T1W5oyeG8/k/DiJbnUDtgIHTAFzgVnFDH5V55JNwu2sVtww1WPCujSPUQRYUj5IJqZrGjKIJIVC7MgwL7W1iXSfrCippkkfGHGuegvnbbLlB8i+qa5x/8bXqjS6lowDiTh6mCI2VlEHH8/n+LstoCQl+OZrq03tt9FcElFDTyl0ot9So4Zbg6WkwsrbtjsS466crLGv2L3QOMPL5fvAgrY0gJbFM9DZmGMy9BTaZH63Gs8x6qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eholUpd99814+WcmS9/CjSk04WOyMFJk32FA5FAdW4U=;
 b=InQDmlcJmabUH4ryCNF2H+e4y2rC/q4gMKqEIReovXw3CMJ9Hpvxa18pB3DsWZgMd9FhI3oiOkRiS8zKCiIB7bxa4IUjlZJG5IF3pJw+lzE0EyZPViQnjvu0XBLCZevUP3Yu46LFb7huvuWdXrZnElnZnVrKX2zxX4xQRNKWcm2ewqQWTz78iaApxlq4mJUXyJaQuAc8dWp2B4urcb/lVF+lLZjG8TTGOKrQx14sAUCaz9X94Bwuh03UV+cCniWeV8xP+M7C115HNOs5rwTfOUrNLgfOCCMaUR8b0mMJEbaUQpNB/i+zOKUwnTAQHNTuT8AT65qkWtogBxQAzKFyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 12:43:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:43:38 +0000
Message-ID: <c528f957-3419-457e-8fbd-57e584b9d6a0@intel.com>
Date: Mon, 13 Oct 2025 14:43:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] eal/linux: Check hugepage access permissions
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20250814213246.4141803-4-jfree@FreeBSD.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250814213246.4141803-4-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0203.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::28) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 420eedd4-f02a-4696-4e58-08de0a5620fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wkxmc2xHczV1R2N3S3N3cGZhZ0FRREs0RnpDOUd0VWRRQ2gvRTRJMG51NlRN?=
 =?utf-8?B?emFrd0x1MnRtaWZDb3oydEFaSm93K3Fibzk1T0JEWEV0UnE5M0Z3Y284VEMz?=
 =?utf-8?B?VTFHSjR5bDhHeXdlOFZuMnZlZW85YkFKVVZOOFd2dVNOaFBkeWlXRG9UMFd6?=
 =?utf-8?B?a2V2MzZJaHFmMVdpSkFzQjNRSDMzbXR4ckhxa24rWkZnT2Iwak9kK3FEUlVy?=
 =?utf-8?B?bGE2Wk1uNUhUd1FiMHFqU3VDMmIra1lvNWZuRytHMFFWQkI5M1V1VElvZXhl?=
 =?utf-8?B?TTdxblp2SDJxckZzT1pTM3A2RWIxU2pGZENzNlp2SkRLbGdBSGM5cW9MWVhL?=
 =?utf-8?B?aGhHWTJqVTA1NE11YjdmSWVjeE42WHRyTlBxTE9jZk5nbExLMHM3TCtqRitl?=
 =?utf-8?B?aWg0YytFN1dFWUN4aEN4RFpOTWdNOFFRdDZNRVB2ZVBTWER4a0VEWnkvbWdG?=
 =?utf-8?B?UHNxYVlSYlBIMTd6UEl6TzVYWUZBblNybzRDK0dKOFp5dW5FcTJ1K0JJUW5D?=
 =?utf-8?B?K3hMSHp0WmpFaitxNVd2b0RFQ3NTNjhIOGlFbWR1YkdXbzdBeUZlUTlmbFBo?=
 =?utf-8?B?SDhEYUcwMEI2aEFuZDZ2RVRtbU1iN3lpVzR0OFRKTEZQN1pUdUlqNjlnd0ho?=
 =?utf-8?B?ZnhNMFkzbW9JZEp4bmdORzJKQ1hveXZ4SC90UTRNK1EwT0tMRWltSnIxQkhD?=
 =?utf-8?B?VFEraHoyQkh0TTRjU25IUzJib2ZqNEU5T2FQVTdCRFJWYS9EZWZMVm9YVWd0?=
 =?utf-8?B?Q3lXR2MzSkdFZkFJUmlYYXgxOE5oRG5HZ2hjaitDS2h2cGs4b2JIb29RUGY2?=
 =?utf-8?B?Y3VQR2E3RGRTcmcyQ0JuWXZFVG04bDZPV0tJOEtUZ2ZvajA5NmpwU1BzZFZu?=
 =?utf-8?B?TEZ6d1Y2NXRBREQrR1ZPQlBQdFYxejkrWnRNQ3Nabzk4RkJod1kvUXRlczhu?=
 =?utf-8?B?VytWQlVKK2cySm8xZEtES21KTHMyeFcvRThDUVd2aHV6dmNvZjNCUzV6QTYz?=
 =?utf-8?B?ZWxXbXBvMXdKRVB0S3IyanF1SGo1bEd2NzFwV2dpYVl6cWxSMnUrY2hDUWtk?=
 =?utf-8?B?QnFzQm95MUR2ZUgvOUMrNW1wZkFJU1h2U2p1bXliSzM4QXdRVmovUk52cUhC?=
 =?utf-8?B?WDk2Rmh6cHlTWUl6cFNSUlpJVi82c2w3ekZMRVZoMm01a3VvTWRCUmJ2K2pW?=
 =?utf-8?B?cUNKa1E1ZDBsL1JtTENTTUs3UVpvMktEMGtac0R4Zmxnb3J6NlJhcWF2L0Mz?=
 =?utf-8?B?bG44ajRiQWtkYWFNODl3SFRYdm9FdUNJK1JBVTFmVSthZkpYUEtObEJ4UU9p?=
 =?utf-8?B?VzY2QWFFTVZ5azlTZzI5Tm50YjVtOUp6VDVIWjRtRG85MWhTS1dSL2FxM2JF?=
 =?utf-8?B?Y2prQnhDQ3BNNmlrdWh0TjhVQjVkVFRrS2NFb0tOaWZYYy9IWUlDOGMyTEps?=
 =?utf-8?B?UTFZbFFQOUkyWi9Bc2J3a2ZTNVNhMmNPTlF0c1YwSnQyUWprbTVpdERQck1p?=
 =?utf-8?B?Yk9FUWY1Y3c4akE3U0x6TzY0blJmZTdnaXRnOFRWaTBFanROZldZTUVVVHFw?=
 =?utf-8?B?WXBwUjJCZHlHN3ZFdmxyMUNXcm5rckVTNG5IQWxkdWtBY01MckhiTTkrbDlm?=
 =?utf-8?B?WkRmd2N5Y05ucytHNUFiZTlybDFzTTBWZVY0d3dQK1Q5UHJHeXdHdW1jdGhN?=
 =?utf-8?B?KysvaUQ0M0hFRkFPc1hGTUpRV2czdjVNNS9QRW96ZHFmdjZiRHl3VkF1cXJW?=
 =?utf-8?B?amtxNlBONitXN3FBY3JHMTN3anh1aUo2RktLbm1RZ0JydTFrN0xLSWN5R2Zx?=
 =?utf-8?B?RlpkeVF1OUZVUnQzdThKNzhob0tPTDFyMXIvVDM5MXVPQXBnSE5FYlhmTHpH?=
 =?utf-8?B?dXMvWG9iekVUWTE4R2NPOEJRVHRHRHhDN1dnSm5nOU81WW51UER0bkVUbXZs?=
 =?utf-8?Q?Qzenwz7Vl1HWaQ/g+oGZNJQcrJs1rW5T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZicXRqS2xuOTFySjZveVQreFAvN29WVHBJVGU3RWozVTJaTHhlZ00vSkha?=
 =?utf-8?B?UGljMkVnNmUvVlNCcVBPUFRBUEdGZU9BOHZOVFV4UTN2ZlorMTJ2VDlwVEp3?=
 =?utf-8?B?TGswTExzNW94UFFUVmJRdWFWTDVCVWV2TmR0OVZZbkZJQjFPYm1qSE91cEt2?=
 =?utf-8?B?WTQvUitjam1XZXpUeCtGZU1jcGxTQ3VMZHYxaTVLNDBBRCtYKytzWUJmOVB2?=
 =?utf-8?B?QXh4K0s3M3NLNEFsNlNzUGF6TVlSbFlDaFNoeUdCWkZGbXRpRzdabk50UDVr?=
 =?utf-8?B?NExTZ1JoSnpLVzZZN2x2RGsvZE1GOHFMTERUamszSWVUYnh4WHNWVFlJZElI?=
 =?utf-8?B?SGNsYWc2U1E0UWJZd2RtSXJwdVg5OG1VVnlGcHA3am1HWkFPZ1ZVNmR0djB1?=
 =?utf-8?B?bDg4Q1VDMGk5eWU0bXp0Wno1c0RxK0MxOEJLUjlUb29UZXRhamVYdTcxZVpP?=
 =?utf-8?B?UWJYQ0NmRmhhMGJ5QS90M24wMFBENGdNSVVTQWFPRjRBcUVrRllEeEcvUm9G?=
 =?utf-8?B?cmVJUEs0bktSdVovMDhaQWxjZzdOTlBDZTVIYkpDOGhXRDl0c043UE9KUTRu?=
 =?utf-8?B?QkFFbFdLVHhBTUlVcmJLWXBJd3d1UWs0K1BhOWxmc0xIU0hrWHE5WDllUzE2?=
 =?utf-8?B?SWNvYkZnUkh4cUppTTdpQm4rcllwNXdDdUkwdkFSSjhlMkR1TTFHdVVoM205?=
 =?utf-8?B?Y1Bzd1R5YzI0OWV2K1dtTDJkbDdTRkdQaDhldVpNV1EzYmxUdnFlTzB4UzZO?=
 =?utf-8?B?U3lIcEh5Y0RJZ3ZQY25LelFrRndYMGh1WG1ob2ljcUZHNHpJL3lFbVhLK0pz?=
 =?utf-8?B?elU0MW1EdjVhL1FSeU56a3hlK05JaHhwZVVCMlI1SEJXWjhkL0xiTXlXa0lJ?=
 =?utf-8?B?V0VFQ3VXM3VncU5Oem5KOVFNcmVTb1VZeWl2SldVN2ZKVGFIL21udlpZeWdm?=
 =?utf-8?B?bE1IeHRScGFCMEVlTkdoamt2d2JTQnZjQmY5ejJLaDJjVWkrOUdqcGhnNjE3?=
 =?utf-8?B?ZEd1MDllSjdqSXpxTW0wUjBCczM3SEYyQVQzZS9pd2E5clVibCtCSlhXeUxt?=
 =?utf-8?B?YVh1SjBGSUgxejdsdHFYOGFaSEh0QXVlVjRsTjV6RzdQQlRCbjN6YWQvb2Rt?=
 =?utf-8?B?OFVwMXZDN05Ha3h4NHpDb3hWUUErL0kzMWJQRWtXZmRnRjdKVkU4UG1qWVBF?=
 =?utf-8?B?MkpLU3BRanVVajZOWkNVM2hWM2FlSFkycVdDOTMvVHpsMnBGUFdaeXJXTXNr?=
 =?utf-8?B?bkpvN2R5VEpmbGVrSVZOYW1RbllOVzdSZDJJU1dWdWw1M1BmeVh4eXJXZFVT?=
 =?utf-8?B?dFdGZWh4WGNWZHZ2MVB2ditJeFF0dUxYZmlScXMxblJobDdHNmdqelpoTFIv?=
 =?utf-8?B?UXVGbHNwZGtyOXRibTdxY2VWTy9zNkVPYXBvTG8wdXU5MFE1U0ZQdTFPN3Nk?=
 =?utf-8?B?ZGxBRCtDVDN5TVQvT2Q1SmU4YjVjQmZVZndYVjUrSTU1a0xSQ2d2a3dNdzhN?=
 =?utf-8?B?dnFESE1YeFI3b0FFRUFFdVkrOFNUVzZ5R2hzUXZxVTlXQWRWWlFUdmZNenNT?=
 =?utf-8?B?R1orL3UyamNSNHN4YnpxRjVWcDlETHJQaU9KcFFlcmNGeGM5Zno2YWQxT1dX?=
 =?utf-8?B?MWROb2JXSW5Ba3Fia3ZrL3ZCZzBRMGszZG81Z2dteC9KU241bHBXbGt4U25x?=
 =?utf-8?B?S0tpZUxWZGd5RzI5MExTVzYzSjcvM2tYRkpLSWU3N1M3bjRBeGx5OGxNNWR0?=
 =?utf-8?B?d1FxeUZURnlKR0tlekdjdGZFMnhuTmdxN2xzVjZXb3liblNRcld3Um5Ga2RE?=
 =?utf-8?B?M0hXNyt3aG53SGxmd0lvemNKMmZDVTBWS3g1Wk5ZTTYvZ0hEeDZqQ0RsbmdW?=
 =?utf-8?B?NklLRjV3QVJRT0dIOUpvM20vRExBK2hCdW9pR1QzUFRPODlJb01nQmRzVVZT?=
 =?utf-8?B?UE8xMFNVcnpqbm50eDdxNmtzZ2RkR2hCZmpaMmJKSmh0UXNrMjVFQjJtdzhX?=
 =?utf-8?B?TDVtSTVrS0RnZ0lOemZ5d0dZbnJkVC9FTGozYXQzYXFjMEdpQmR6Z1V0RG9t?=
 =?utf-8?B?dkx2NVRQQytjcmJGVXViUjNZbzQ2TmZqbUw0ZHg5TmpYSDU2aEtDMmZzaFNm?=
 =?utf-8?B?ZS9qK3JTaUc0b0ZZVTVuWFEzMnlrQ1RxSmpGT3VOc0lFZ3FoUnNxeGhJeUEy?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 420eedd4-f02a-4696-4e58-08de0a5620fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:43:38.1638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t/FEioKdUg6HWW5fMkmF0/cn3EFVrZ0mRtGM9aJMzuZgpPew6DL0fTmLzZF99UQ7z1nsCxSVZ5lyLdXm+KXsD+kM539ea41emyvT4jbQ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
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

On 8/14/2025 11:32 PM, Jake Freeland wrote:
> Currently, hugepage mountpoints will be used irrespective of permissions,
> leading to potential EACCES errors during memory allocation. Fix this by
> not using a mountpoint if we do not have read/write permissions on it.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>   lib/eal/linux/eal_hugepage_info.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
> index d47a19c56a..e2ddd6218b 100644
> --- a/lib/eal/linux/eal_hugepage_info.c
> +++ b/lib/eal/linux/eal_hugepage_info.c
> @@ -260,6 +260,13 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
>   				continue;
>   		}
>   
> +		if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
> +			EAL_LOG(NOTICE,
> +				"Skipping hugepage dir '%s': missing r/w perms",

Perhaps should be reworded as:

Skipping hugepage directory '%s': missing R/W permissions"

Otherwise,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

> +				splitstr[MOUNTPT]);
> +			continue;
> +		}
> +
>   		/*
>   		 * If no --huge-dir option has been given, we're done.
>   		 */


-- 
Thanks,
Anatoly
