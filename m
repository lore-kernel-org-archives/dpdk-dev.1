Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646C3C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 19:52:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39DF94025F;
	Wed,  5 Mar 2025 20:52:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 123A640156
 for <dev@dpdk.org>; Wed,  5 Mar 2025 20:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741204373; x=1772740373;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AJyHp5gM8981TGf6N11dwUv/dfE/Y8x1RDJkBcRuu2Y=;
 b=P9tPtrDxKZAvehjB69rJVrNnbQc0/I3Jb6gaiipbCRNegKQP6PSnVkVt
 SfjY0ZQE5JGE8v7c+hCbqkUeTKRalARK8PJMO3tc6xzwqMqjOmx3Cj1ym
 8YdxV/B6kAUtaHD7oDS1Y53IyZxxTOPubx7eD/1ZulJjNZxD2d5Y8ZJWy
 ibrwAU8B2MWN5C8TzBWusOxj1nMMfnel6io0/2g8e7xkHO8WgClmYoKWP
 boyud/MbpGkWa4HZ9Fhe5cXg/yJUHGKWMHwviHXZ3tFsa9pAQqAFCUrmn
 lNU667M+e1+2Ohs5hAEM3euR2Ty7Msl/UTuABfyTdgycSUBcFhtQ79O/M g==;
X-CSE-ConnectionGUID: e2XUphoqSl+1CYGQmPfehw==
X-CSE-MsgGUID: iebowdtyS+ilYbOcmj84Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59597629"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; d="scan'208";a="59597629"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 11:52:52 -0800
X-CSE-ConnectionGUID: HTg1py2ZQvKefNNgCfFbng==
X-CSE-MsgGUID: YePNOr8aR1GfBXhmaGCejA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; d="scan'208";a="142024526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 11:52:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 5 Mar 2025 11:52:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 11:52:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 11:52:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiJn55eGy/Gd0PSMBt/sozk/4TILsrVvkOe2ka5jf+w3Vn8abubfj3EINLjjxSUlsRXGsTb4TTuCQFteJxTBb1+9HwQx4SJnvp/nVs/JXpjMIDisYl9FJ/dGB1/YVQC3Mb0ui8nkYR5B/prnqJlz0UnotMYmaus587iCURw3Irpof4BdfC/K7ej1z6GJvdaPWPTUbmBT5r2hJINJkJ5a/k4ll7WQUPHMdDzAQ+uYGlzJR4tAGc4NJwmqZS34i2Fq0n9/cV/DvvU0meT9WPnb62SVUgYFonUtjWxr1YLt6VyBhhqvNuijE0XnEZQ6TTgy8LQKHYk1mu6/Bl5cgTNogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+wYc6oOqN5l1Ggvt8gxDaHds9U+DjHeLv2eH1Q49qU=;
 b=Dg9GMG/Fv/0rlRNShjxw0qF3JBiOtTuxqjZLR6e+zriD+yTsXxyRoFN2lSNmB0WVx5ISYf7ugqAIwOPwBT8XXuQ04YFbGllBPPzeL47gMy6+oX50i0cQ0Ex7oXgOi7jWej742RzSVd6xsEXVoeuVteo5pNmd9DIuyNlw7yy1O6oclcRYwhYi7i3xRvdb3jGDVlX55fsGM7ZlP61CTHys5qm/KqmR/EOieeiTqEFF/fHdPaFm8C+N5GQVJZ/TF1szqt+W+VcqOYjna2ihImeyd4d/yhVvMr3F6tdB2hkEOfy2mBwhOq9fvsuycl8Nzly185Jewr6KrjGWi9ZmGCx8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 19:52:35 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 19:52:35 +0000
Message-ID: <39562477-1bc5-47e2-a750-92b8a27a5838@intel.com>
Date: Wed, 5 Mar 2025 19:52:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/test-fib: enable test-fib on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
References: <1736028594-15393-1-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <1736028594-15393-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::21) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: c01ae733-4ab4-45df-7f81-08dd5c1f4670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1dycTlsS2FpVER5ZU9lVmN2azZtV2NaTURnWWcxeFdlWmZrbmZUNVQ4ejFW?=
 =?utf-8?B?SEExd1BmL1FkT3BNbkZEK1YvbWtndlVpa2lsTlhNbjU4dlpZY2JmRm51cTBF?=
 =?utf-8?B?Zmd0THdOd1RPeFN1N3dqUTdQbVR1N2xBQlJGcVVaMTdiZEJhRGIyOWIwNExw?=
 =?utf-8?B?NHdheXpQVWtWUzFiTmhYdTlWYTVDeVJIcTh0U2lodkJ6aEhMUW9oS1R5d1RW?=
 =?utf-8?B?S1dkdFA1VDBEbXQ2bGZkdFpyY1RXWG9iRDgrU3ltZ3RjNGRtdXJCcUJtSDFr?=
 =?utf-8?B?VS9qMXR3T0FJS3ZDR1U0eTQ4WlMyeHdPZkEraEIrOEhtWXRNZGFJQ2k1S3kv?=
 =?utf-8?B?blVuTU1WN2phZkxVS3pwMG9aeldIN1dUa1R2NGR6QVlYUDFGQ29TNnMzTXo5?=
 =?utf-8?B?aUU5NjFNN0QwNXE4Mnl3bUJoTURaZXZjUEVvZ3lTZHF1bFhvVm1mcnU3dm9t?=
 =?utf-8?B?Vkpmd1FTa1ArZlduR0xmWUwvOE5rNmJ0N3BGWVZwTnM0ZHBXM0l1WGRJNjFT?=
 =?utf-8?B?Q3picUowMHdWRmJRQTBYbEQ5bkFqS3hwdzBIb3laVkFaZnVVMGRFTXZLbWdz?=
 =?utf-8?B?TGNDaERsdGViVTVzQlpaTU5XWS9QQ1pXc2JDdHdqWElRYVBrZk55elFvQTNr?=
 =?utf-8?B?SjhBbmFhSVBpVGUyMTJrdkhPUFpyTXhPVXNabDFISzVlRElYUHJnRGQ1NkVj?=
 =?utf-8?B?ek95eU4zYXFmdko0TGdmSFJKRFI3TXMvbGdsN1loS2FFTHV1amhRaldxQkw2?=
 =?utf-8?B?WEUyNWVjcGFkcGxqU3R5OWtZbm1kamRNQllFQXFkbk0zK0dOZC9RWDRETFZy?=
 =?utf-8?B?UFEvRTNpUEJyc1pvam1VYmNOc2R2U0dRaEg2QUdINkpadklsdFE4Q09IYlMr?=
 =?utf-8?B?cTd3MGFQVVFGdnBML21XT082TklrSXZkdDZUWEhHK2ZBRGRsTUtvZ1BBZFAz?=
 =?utf-8?B?NXVSbHF6cmJWa0xJNHZmRnh4TERvaCt4cXBER0NKUHQ2eGJPaXNCODAzWGR4?=
 =?utf-8?B?NU93M01CME0yVjFTMVJFa3lFVDJjZUsrRkgybXI1eDRHN2J1TGY5N0RRUjNP?=
 =?utf-8?B?YTUwNnlSc01aYndIV2craDYxTE9uK2pEd3FDSEJMVVByTys0blBJb1FXK2JL?=
 =?utf-8?B?NW5rZTVUdkpWSDNXQXlQdkV4bldTYlUyMzBQYWhkczF5S0I3OVQvQXVGOTJN?=
 =?utf-8?B?M3ZFM1JjSW5kUzIzdVJXK1BRWStyTnhiQ2MwaE96NXlnQTJmeUZ6aGxBNi9J?=
 =?utf-8?B?Q3orYWUvbnlQdHJLZ0czSnVtNzBZT0RIdmpvWWdzc0pvZk94aDRQMmZ5Sk5n?=
 =?utf-8?B?ZUd4RzJIakhtZUFFYlFDZ0c4MjNQUkRVZHBra3VnbVlpK0xPQzBXRmpPR0tv?=
 =?utf-8?B?Ui9ORk4vS2tNbUJaMU42d0xYdnJvVklJRzVlbjNQYzUzTjVaOTFPOFZhMnJx?=
 =?utf-8?B?VGVaOTZxSTV3WnoySWJWUGkwOVMzZC96dC8rMS9uVW1WVHZYUURQYXVmaDVh?=
 =?utf-8?B?UGRNYVl2V3ozUVcwbzhWYytYcndPYVhuTVZrVTc1bjk4NHpLT212WkdxM3c5?=
 =?utf-8?B?cytKd0xCRDNPYjdCWVRsWWNZQU1NOFlBZ0JDenJ3MHlWK2lHMUZ6UExrMlNz?=
 =?utf-8?B?NWFPamt2L0tyUU9iSytKekVybGszbWlJNzVWeFh0MVVmY2tvOUZWNkZNWVVJ?=
 =?utf-8?B?bEd3NmZzcmZvWGhVc2VTTU9OTGIwdVB2dDZBUFRhUC9VOXd3Vk9jWlVGWG1T?=
 =?utf-8?B?cnVYOEpBR3FMakRLcVVYMERYQmNxaWY3aTBRZnl2TTZJdlovK3FYNUFUSndC?=
 =?utf-8?B?UE1KdGp2alpHUlRJdEY5TDB2WGVtWGtrbnNSb3VTRHVtMktkM2Jpay9zazZs?=
 =?utf-8?Q?R5mGdRfIKZqB9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUFSYXNPTndJK2VCdXZMNUFOaUE1VE5ONmRWZGFjdzZVT3pCUmJoYlp4UFU5?=
 =?utf-8?B?L2lmYWpxSm9SMGNPbmpJTWpoU3pIVXlieFlhMzRUWWkva05rNExHZ205OEs0?=
 =?utf-8?B?TTFxeFMwRHBqa2QrY0VuNGs0ZTVranB0Wkdyd2RnQjVEbjgvWUlFOFFORFhY?=
 =?utf-8?B?UmIrVTJHKzNZNlgrQzF1djJYaGplbEZlSGJTRFAvMzJpMkdmUVNQSk5BRHNx?=
 =?utf-8?B?MnNoY2pQUXE0cU9XOWZ2cXEwVFo4WXJtdFJMQUZUcWs4OGVxWkJPOFo5TWJ3?=
 =?utf-8?B?UUVCdXJsamtvZys2ejVyd3RUTEk2bHE5U09Celg3VkZTekhOdjY5MnJ1bVZl?=
 =?utf-8?B?cy9oWno5WTNkOGVMN0I1ZGdFcG1oZmEzdWxOcFQwSCtsVUxRbHM2VlA1eWY3?=
 =?utf-8?B?dTFCNjgwSnhnVFVPVURXTExkN0JSRFBQMTdxbEE0ZExzYUJlNWJDR3dHb3NG?=
 =?utf-8?B?TGhhOVdEa2FnYnhRL0QxcnRCcmw1S29MbURtQnFKcEorVzBhZ0JBREVzbk16?=
 =?utf-8?B?QzN0MEcvZ21WWHdYazBBcG1TcmFrMGwybHJHQnN1SjVYM2N2ZW5GejVPbjlV?=
 =?utf-8?B?dm5CSWE5ZEptTXR0V2llRUoweG5jZjV4SFBoWG9sNmNJSmFkR0pab1dWWTlH?=
 =?utf-8?B?REY4eGluTUYyUGdlK1o4THpvZERJRW5WZTRPY2JtTjJta0VndEJSZ2dFdFdh?=
 =?utf-8?B?SUk5TkhrT040V3RHdHRGU0FLOGUyUlpNRnIydTVxQ0VVa3VicEVTaGs3N2dX?=
 =?utf-8?B?NC9DL3hxbytRM1ZaN0hWWXNueCszZEgwTzhlUTdoQzlzLzhuRWYrbTdobUdL?=
 =?utf-8?B?YnhvNEltNVZ2U2NhbHNhTUtUNmNjNVplRy9XYytZRXc3ZUl4cDY1VVFnOCtH?=
 =?utf-8?B?d3ZxcVl1LzNqM09yTVZTbDhEWTRabXRaUEVqeVMrNnF0VHhxYm4rcEh4dkN3?=
 =?utf-8?B?S2c3QVpNV2ZVY0JSTzNKVGJUcUpGVDBpbjlQK21LNDV4NXNVOHNSTmtwcG1j?=
 =?utf-8?B?dFJkdGFXcVZGN29ERWRaQVZtRWFnNU81OGVoc29SVy93N21nV1B4ZXR2ak4x?=
 =?utf-8?B?RWVIdkNpWnZCcmlmdjlvT2dHa3hSbWFHQkU1WWFSbHpDWGRZYzUyQU9zOFJN?=
 =?utf-8?B?OUN3UXQyWi9IV1ZTSkEzT2tMNHIreGJUTDQ5dXJJS3BPRHROcmZNOHNzQ1ZU?=
 =?utf-8?B?OUhDSWorUnRvVHFEalByTERCakxlTTE5Z1NKOFZpYmwxVEtWT2wwa1UrTmUz?=
 =?utf-8?B?L28rbDkvNzl2NHZVcmREZndKdHNRWE8xaVlRVEJMUENnTVlhZlNNNUJnQzNv?=
 =?utf-8?B?Tm9GMnhRMUQ4SVF1ZlM3NWtPdnIyczEyVk1yQ2p0SW05SEdVVzlLK01maU1m?=
 =?utf-8?B?YjRvWjNDb1l5eXBxMnZCTXhIQUt5VEVPc2ZIRmhDUDRHdDB0V3dhZjJ5ZkhE?=
 =?utf-8?B?c1dBZWswU0xWS3lHWmxYbFhHWkpHWUpNMVhWNmE2WDdTR1daanFzSnhZUkxn?=
 =?utf-8?B?cGhsV1VPNFMxQ3hrL0J2bXBNSFl3dXdFWVo0aVhBVjdQWWVwcXZpeGNjSiti?=
 =?utf-8?B?bU1ualg2Mkc4eFJrTkx4WUJTenp4R0VCV090ODk5UUgxcWp0TzlIK3R6K2lH?=
 =?utf-8?B?YzIzRDN2QnpZU1hWUjQ4RmRmajZnLzJ4TUVOZlZCbzE2TXpNV3Y3QUtGaEpy?=
 =?utf-8?B?dkhkUEVxYlplRnZyc1plVnVkUVV3bEtwVjFzZHBBaXErTjlIdHVrTTFsRmgz?=
 =?utf-8?B?aFFMS2xVVm1UbFh6MFl0Q3BoVk5MT3ZocjdCNVVqdWNzR3E5ckFkK1kvN1hj?=
 =?utf-8?B?RlpaWEJaRDVuRnJkUkNvSm1uV3habmVhaGpzWWFEeCtZbkJvZ2lYd1NMVi9k?=
 =?utf-8?B?WEpJOCtaS3JPc3ljRDlRaGNxdHN5YnFuQ05zV0kzbWxsclkvZWlNdTQvYUtF?=
 =?utf-8?B?UCtkbkkrUVkvdk10b3l0cEpYc2RTQm5OMHRmc21hYTJHSUYyc0JQL2tXL1Ju?=
 =?utf-8?B?NUs5bW92ZDllZUgrOC9DUGlvR3MxUnhDQS8xVDZJZlBWSm5PT0xxYzF2VEln?=
 =?utf-8?B?L0VXVlFGRjB6WWtZUHd1b1VxL3c0bDMxbjdmb2FFZWt3ODdzMlV6VUg2d3lL?=
 =?utf-8?B?M2gwNWQrSGNuaHgwdEw1a2prbklXbjF5L09FWDNEUWcvbnh3S2dtc3dzTCtn?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ae733-4ab4-45df-7f81-08dd5c1f4670
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:52:35.5003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLYffRlgQJtzRILN/eueoZlT0jPP1JMuIB297gfabN058+sKd9JBCI0q4MioH8s9/GD2X7n6xFcg6aKgRG3JWCZMfwXY7GVHtHFqIrnjJYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
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

On 04/01/2025 22:09, Andre Muezerie wrote:
> Removed a few includes which were not needed and included
> rte_os_shim.h to handle strtok_r which does not exist on
> Windows with that exact name.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>   app/test-fib/main.c      | 8 ++++++--
>   app/test-fib/meson.build | 6 ------
>   2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/app/test-fib/main.c b/app/test-fib/main.c
> index 6479f48cdf..dd1a6d7297 100644
> --- a/app/test-fib/main.c
> +++ b/app/test-fib/main.c
> @@ -5,8 +5,6 @@
>   #include <getopt.h>
>   #include <stdlib.h>
>   #include <string.h>
> -#include <arpa/inet.h>
> -#include <sys/socket.h>
>   
>   #include <rte_cycles.h>
>   #include <rte_errno.h>
> @@ -15,9 +13,15 @@
>   #include <rte_malloc.h>
>   #include <rte_lpm.h>
>   #include <rte_lpm6.h>
> +#include <rte_os_shim.h>
>   #include <rte_fib.h>
>   #include <rte_fib6.h>
>   
> +#ifndef LINE_MAX
> +/* On Linux this constant is defined in limits.h, but not on Windows */
> +#define LINE_MAX 2048
> +#endif
> +
>   #define	PRINT_USAGE_START	"%s [EAL options] --\n"
>   
>   #define GET_CB_FIELD(in, fd, base, lim, dlm)	do {		\
> diff --git a/app/test-fib/meson.build b/app/test-fib/meson.build
> index eb36772cf3..f74ac651c0 100644
> --- a/app/test-fib/meson.build
> +++ b/app/test-fib/meson.build
> @@ -1,11 +1,5 @@
>   # SPDX-License-Identifier: BSD-3-Clause
>   # Copyright(c) 2019 Intel Corporation
>   
> -if is_windows
> -    build = false
> -    reason = 'not supported on Windows'
> -    subdir_done()
> -endif
> -
>   sources = files('main.c')
>   deps += ['fib', 'lpm', 'net']

-- 
Regards,
Vladimir

