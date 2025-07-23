Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153DC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 486D640DF6;
	Wed, 23 Jul 2025 17:51:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6444840267
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753285917; x=1784821917;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=WEX0ksKWd1AFfj7bFWdsYUALMlBJ5WnyulqHRv4bYQc=;
 b=m8MSU1xQj6+5BcJ7txNQcfK3FC2rHwl4mKBv+XKAgRkoAqGO5eaVfEr0
 HME+Fh1RbEjiC8YemH3rMJu5SyWpE3eHqzfsPr4mcBB/vsUxhYdx9OEms
 HRq+WyurcEtshp6G7SzsMakSRkb0imBEmRnCxP1BAXcEqnWFbXKnh0ons
 kxnzGCFcZeAyfh0xEb9cNgxbVIH8PiZDET8hGHHb/7Fx0UdXTILR9KQ3d
 t+I0tIFoWsSIdjVQB7x7FZ4JxyYvwoJ2tKF0/ZL2wgZXFjbsGEAmJWmgJ
 lJ6ZRs/r2jvxsCa3GPf5YE3GIFtaO2pccxT8YtW+8NnbeatpCLkN5/AsB g==;
X-CSE-ConnectionGUID: s1qhA8NFQYa9x8TGYl6dHg==
X-CSE-MsgGUID: 1ohjmmlnSuaPFavpjzfZ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73031028"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="73031028"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:51:46 -0700
X-CSE-ConnectionGUID: OuXlFecETVOrn71pcSwewQ==
X-CSE-MsgGUID: lNPIRpThREGtuXLMuN4hVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="159889772"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:51:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:51:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:51:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.85)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 23 Jul 2025 08:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAKJVCK9R3GBfYy/AdUnVjwkUcTtde71H5+Bnw+Nn1opApGhYZC17eq/PvgJ1PuMS888P+Qh1XUX0G1fHqLf+MLdrUDWH7ZycfKp+sdGZBMw4CZB1GB/wAHjHsHe9HVbtmbYMaw3mCXOCxC2V0dj/yAzUKQqnrstER3Q7kp1ZU7eGgT7iMYphdmLYsV56IaMCUJMU0GWJkc0CUJcq9tolqb3UpRpq14/XYKkSuU6XmtEAmevuYFuiRqoex/uiJU4EhEmMAV8I1u5AyW19WHTkqRx2y9v4iwgYnpypYyIIkG1TeLfUkdYh7VZeVp97ZSHSbL/Xj5Ukisp+TuPQlLAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbmz9zwv/Tf9yS+XsnylDJzxd0nG6cq7xsyfVZLLJto=;
 b=UJ43VJ+0mmh/0tYezJMwNmpbwDplD05J1nIa2c+0q48EoqjI5CQbCzhQDCKJ2TS8CbIN7/zwsmTJ0TYrrdEkdH+tgX9sAfsmDIrfTCjkq3gn5fjHuXKDVRtpGDZTLC/tGLHGSDzqIi57MJcOOwnJy5ywgvxROt0YMhRPsnlp9Q/dbizjqDk/1yAa54q/4TlZwICScCQGEMqgwBUQdjEY7698Xd59G4aX7eSygVJiMloDSJKs0WgCmDRr0WCx4lWOU3ufHAulySIPj74mn5xMFURWi22Zk7/PTAJu77gy6OIdGH9BYUIj81/HF0aCQ0m7A5oznnnxmWgg5d4MyhY3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by MW4PR11MB6812.namprd11.prod.outlook.com (2603:10b6:303:1ee::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 15:51:41 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%4]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 15:51:41 +0000
Message-ID: <32ba7225-12fc-4554-ad05-d2ee19295adf@intel.com>
Date: Wed, 23 Jul 2025 16:51:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/22] rib6: fix some highest bits handling
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-20-david.marchand@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250723133157.159825-20-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::18) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|MW4PR11MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f67c386-4ec7-4e17-2a4e-08ddca00d12a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUFYbTBlRTlZNm41ZVJMZHpXendMZGE3cm1RSDVxZTUrOFFBbUNtUVNSbUFC?=
 =?utf-8?B?TGxCY2lGbjRhZHY1K0taV2hjM1ByTno3dEdmUnZjbE05SVBQRHplejFLVHQ3?=
 =?utf-8?B?WFdtaWFXZUhEekpkVjJCMEMvbXg0dkRJVnhmRGJlNVhiaE84dWF6Zm0xVEdm?=
 =?utf-8?B?QXJyczJkRm1qUjM1Y3JCNnNpQUZKUXJJM2ZOZEZ6NGcwemRBWU5EbXNrTXRs?=
 =?utf-8?B?UGQrbGZzdUIrOTU5aWQ5anBoT0Z4eEhSK0syb3pHWmRsUk5IUFVYb0lrVVVF?=
 =?utf-8?B?SHJKSWI3dHE3bk9xZXd6cWhTWmtDMWw5RGxRVkZrUGprOXM5UVRTK0R2bzdL?=
 =?utf-8?B?TnczUmc0Q2RxM09ETGRmN0t1NkhReW5YenFWOVZDVUxtV3VvWjB3em84SFc0?=
 =?utf-8?B?dTFuRy8vR05EaklVVnVpYytpN1RPeVhidVRrSkVvN1JsL1BEazMvTzZwb3g0?=
 =?utf-8?B?NWxoYnMxSVl4aDAyQ2xvaEdlODV6UEE1R0ZxU2tNRXBhT0ZVcHd0eVBZTUxw?=
 =?utf-8?B?RlltMG9xa1hUL2tJT0JzMVlnbVRxWjE0L1VuNjdwOVhJMVA1MUhjbk8rSDda?=
 =?utf-8?B?L2I4aFluODFFWVk2ZW9wN3N5MUpORUtJWnVuNHlYL3VkZjlzQUVWb3hoclB4?=
 =?utf-8?B?NVkwWk1DUFQ2US9hcjNReWlJeUtUYkNCVko3c2hia2dSbG1aUnYweDFkSHZp?=
 =?utf-8?B?dHZkMXlYWi9jaDdNMWZZdTB0VDlXTG0vbDZzSWJZQ0tnSElpbDBNRCtEOHRu?=
 =?utf-8?B?KzBxYjlzbC9ZV1ZVN2xIVi9zQUJ5U1pxNnZsTmJkeEdkeVBEeXF2U0dBcnpT?=
 =?utf-8?B?d2VTT1o0UlFubHdrTGdSRjV0bUVnWlBwVFI5cnF2eDNTQUtIUXhCMENyb1R2?=
 =?utf-8?B?WXdSNjYyWnFDM3lrS2dMcEhsVk51ZkY0ZlBqWmVFVW10Ym5kQXlFY2t3S0tZ?=
 =?utf-8?B?MWtLUVoxTWhuZmhYUjkwV0dKSUI0S2tOMXU0VGQwU1RlUjRIT0pwVEE5aVNu?=
 =?utf-8?B?MG1DNmpNUEl1T0l2OFVqTUJSUFNRMnh4b1NSSEFRQjd4dU15L1g5SnJKOUpC?=
 =?utf-8?B?ay9CR1ZJT1FwV3pReUpTTitTQXZiaXBPY3I4OVJHU3kxL1JVVUprMFZvb3hY?=
 =?utf-8?B?UlA1L05WVnhuZzFrSitMU1JpR3RLSUdvSUliNFdmYzFzM2JUYjRLZW5yT0Nv?=
 =?utf-8?B?ZlNaUWFkM2U2YmhSVHQ0Uy9ibG56V0lYU0FGTjhuTVY0blhYWXRBSThDOGVJ?=
 =?utf-8?B?MytJcExiSS85UFAzMVV4Wkt4N1l2bkxadk5OTFpsM3kxYXA4eXlrSWpkTDgr?=
 =?utf-8?B?aEp2TTRWdU5OS2VMdGlrZGtLN3lQMFpmdjdxY0pNU2lKTHlpdlBGdEErMGFh?=
 =?utf-8?B?dTc2MTBRRUxpbVpVVHJhdVl1T2J5N1lhN2pOc2dmL0tDcGxXRmVWak5YZzlW?=
 =?utf-8?B?NjdQcnVTT0tHc01nanZvMjVaWnhBbWRQNUZpREZ2MnpsaTgweGJaWlZYZm1y?=
 =?utf-8?B?NSt2T1d4bER4NnMvU2tMMS9lVG5yY3lmWjIvOEpBN2FlbGNlVjk5RGJRZmRn?=
 =?utf-8?B?WEo3WUNKS1NMRjUwTEY4K09xMHlZd0VKaDhDc1VmMkxkOEZsYzBHNUcwTmVw?=
 =?utf-8?B?REl2Y0YzdXNIaTFYUXRwbk5DM0QrU1lpRjdvNFE5S2hLUUllL1R6eW5VMGN6?=
 =?utf-8?B?TndiQktGREZBUkdqTkN3K1Z3cTJseUIyclY4VGhiUVBRVTNJbVM2aHhKc09u?=
 =?utf-8?B?THVFMzV6V2hVYlgyVi9rY3laekdoSm1iK1BpOTFEQ0d0WVV1L2d2ZkV2bW8x?=
 =?utf-8?B?bEMrQ1ZHeGFKTm8wRUFRUzVTS2ZyMDBkd2xhdXRhOGtqSGdjOEdwSkxaVlRM?=
 =?utf-8?B?SStsMm9SRm4rYXkxQ3M3OXd0TDI0YitMYVN4Q1RCU0xIQU1BZVN0N1NnTjVZ?=
 =?utf-8?Q?YMRUaUCPtbw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjlwN2ZDbXUwZ2V6MW9uWUt2dGhtZUtuNE5ZeWpEaXVQcUY3WU5ESFdYSnVy?=
 =?utf-8?B?cHZTK1dhY3FkNkN2Y04xdjFJR0RNOW1sTHVUUmlpU0wvem03cUlodTRrZmtn?=
 =?utf-8?B?Wkp0YWFyNTZqSmNicjdPdWZxK21DREF4MzRnbzBRT0UvcTlvWTVnUDY2NERp?=
 =?utf-8?B?OHZxNDhuRDFrZDVYaUZzZEd1THVGVUFBeWxFUHF1SVBUTmtYUEtack1ybjVR?=
 =?utf-8?B?ZDlNbWVra2trRDBrSzByUU9DWjk1U1ZINWF2S0N2UXA0Tjc2WTVhckMxaGVM?=
 =?utf-8?B?OFI4a3VYQ2ticWN1UkZadzdIRHZIUkpZdUFucnVyb3c5d21qT255YXEzUDh0?=
 =?utf-8?B?c002eC9xblpqbDliMkowQXpoUG9kQjUxOEMyRWNSeFNjZ1hwU3JNeG5rNHpZ?=
 =?utf-8?B?Q3gvQnZJampiR0s0bmFIOGQ3dkFkUTVocUVodlBBd00xd1h4QlN5dVY2SGpP?=
 =?utf-8?B?aStOOC81Wk1SWnl3THVNb0lGajY5QThYM1dHcTkwQVBjRzlYTlZyWWRqc1ln?=
 =?utf-8?B?OHdxYkVabVNjTWgzeDUzMkVPVmRCZllwMEF5WFExa290cG9pdEJOY0laMlhJ?=
 =?utf-8?B?d0piV2xpY0lLTzFlSTg4N0NHSHF3QTROQnNDNThtbHBXZXdtUDVaK2gvT0Zq?=
 =?utf-8?B?Vk9KL3BFMjFxZ0FwUm9Sc1JBOVNjSHd2b21IbDd6ejVteGxvK1NpSDZGd2Ny?=
 =?utf-8?B?NUNvU3h4T1lnZFNYUVlyL1A2RGJqREhaTkFjbWh6cjh4eFdzN0o0aEl0a0xQ?=
 =?utf-8?B?WklaUDdDaWdRc3ozRFpBMVJUTTVPZW9hZFYwZHNoM1czTGZDU2ZzeWNHaW1s?=
 =?utf-8?B?NGt4aXo4eERGUlZHYzNIWWNPVDYxUkRWelBCZ1ROTzBBUktXWkZycStXUGlu?=
 =?utf-8?B?L1VkT1ozNmJwWXpIYWFSbXYxRXJDUWdqMUV2MzBBZFBsN2dSaDRVMEJSQWNs?=
 =?utf-8?B?eVlYRGM1UUY5TlpMMTNla2R1MFhoUGlvRHJNdUlueW9hL2tDT2g1MzlhWlRS?=
 =?utf-8?B?MjRJeXJEaWNranpYSXExUlRwWU1xTjFuNUxPZ2N3bytkaXZaSXNMSGNiTjVK?=
 =?utf-8?B?enlmVlZHVVdFOHRBVWhwalVLLzRpVFl2YnVWQU0rMExqODhERGh2b2wrUzFw?=
 =?utf-8?B?UXJNRXlYSlhZUldXL2VtOFJYMHdxS1lIaWwzZGFWeng0VHBrVGhOYzZMM2tO?=
 =?utf-8?B?QWs0VkdhbGcyRkFvdy9seEQ0dDV0d1NyMDYzdFdONmg5R05oYXUwS1BLRXRG?=
 =?utf-8?B?UytURFhER3kzL21yYXZEcGlzUmZVUzZXMzY1VTFPTzlJNDVNMzZQakxRWmRZ?=
 =?utf-8?B?b3Y1ZUpybmszS1VZbElVS0ZYTnFCNVhTSzlnblFYaW5vRWVWWEFJQVp2dVh0?=
 =?utf-8?B?bnRONTBJOFVPWU1SbjFLT3VtNm1JOUxFeDA2T1BLbURsaXprY0VYVmJiWHB4?=
 =?utf-8?B?RVNmZVdLRFBDdDlKa0JxSnJhTjc1aUhnR1BTY0hEUHI4anNQc0NUVlYyMTlS?=
 =?utf-8?B?VEFOMFhoY3BNWStVeFNjOG1ZM3lscndCOFdqT1hUUER3dExlNTFrYVJiR1N0?=
 =?utf-8?B?Uk1Fc29BSkV3RHNKUkU1WVZ5QkJOYU15S2RaY0d0ellwZkFlT0h3WExLM1Zj?=
 =?utf-8?B?Smhud0hjMG9EL2VEVkhRTDBXNHRaZnJDejhVdmkzMGc1U1JwY3BNMEVXVkRl?=
 =?utf-8?B?a2RBVnVQSFVWZXZ0L2NFK2dQeGZpZHhVdEQ1a3pWMS83aE11Y1VlN0k2V0R4?=
 =?utf-8?B?aU9yeWg2MEYraUdTRzFOSG5pUUtWR3p4Wk5sQUU3Y2wrUXNBQmVyU0FDUDdH?=
 =?utf-8?B?QmR2cGsxMnRRUEpiaFBSbVkrN0s1SG42MnNiSDZCbDV4aVRiNm0zUmpPbmRs?=
 =?utf-8?B?K2pvekIvb1pEbWRsdEZ5Y1d5aWpCWWRzQXR3U09YQlQxNGpjb01ZMlRLSDFI?=
 =?utf-8?B?RjdBMG5uWU04ZVpiekJJMTBOdEZSYk1PV1pMWVN4d000bjVSZ1I0dUQzMVZR?=
 =?utf-8?B?dThPdDRleWN4SWExODIraFBNUVI5Rk1WRGZyQnUxZGRTNjFpUkpYTmUyZVhG?=
 =?utf-8?B?ck1qRDNpR3hYMzE5cHdnM0xaZU9wckliSzFyNzZYS1JGV0VnWms5QUwzL0pN?=
 =?utf-8?B?cTdCdGlrQW9rd0lHMmlxV0hkaUpYZkNPVER4eXIrTnBxV3ROU0Y4LzN6ZzBK?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67c386-4ec7-4e17-2a4e-08ddca00d12a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:51:41.6959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N9EkCA3caA6miZ6w61vegnfFdoFNtykYcE5D2zfYdfXJcw99ZCo6BKrD6ANap7/SzhYtAVIzyvwlZcMdZTvsAqxj4fWmddkxsC3mYt+an4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6812
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

On 7/23/2025 2:31 PM, David Marchand wrote:
> Without an explicit type, ip_xor gets promoted to a int.
>
> ../lib/rib/rte_rib6.c:348:26: runtime error:
> 	left shift of 130 by 24 places cannot be represented in type 'int'
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>   lib/rib/rte_rib6.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
> index ded5fd044f..ec8ff68e87 100644
> --- a/lib/rib/rte_rib6.c
> +++ b/lib/rib/rte_rib6.c
> @@ -352,7 +352,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
>   		if (ip_xor == 0)
>   			d += 8;
>   		else {
> -			d += rte_clz32(ip_xor << 24);
> +			d += rte_clz32((uint32_t)ip_xor << 24);
>   			break;
>   		}
>   	}

-- 
Regards,
Vladimir

