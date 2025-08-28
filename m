Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E066CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 15:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F205F4025A;
	Thu, 28 Aug 2025 17:57:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E0CB9400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 17:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756396642; x=1787932642;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=NdEJTqWaMCSsPASywd2wXeXreAW4Da6jJ4L7uCHBeYI=;
 b=KNOnzfFmA1Kwch3lyfdgrPqdCrqItQdmD7nyMlqHhP9AgKLpBDIXz8Yk
 594qvRYI/+vOIMR0JPO6GTqnJEYJA9QYHNcPul60BQlAPGvXsaWELUStg
 D35Z6i9tBiP7tD/hDnrcv7xskfkkuMYnXFUDG5wwos9wf8claNOjLwzgv
 uAu/L+XwEl2xReXIBf5D1h16ks3Buhl/1f3GINpGcJphnzPE0nuYEJbzi
 LqXTamcBBdEBKlxfb/5mwsDpoYqMcwdkULNGSvJzIJ31lD1aqOotcQ/nl
 xApdBWadmx0ET9GvOjsbRFhd5N1KwRIAG+wjTuhBTDRPSSO3hT1Ht+ae6 g==;
X-CSE-ConnectionGUID: 6U8+tvtwR66fpFewQuxsVw==
X-CSE-MsgGUID: lLU86JUXSvGQcW7tVStusQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70044709"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; d="scan'208";a="70044709"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 08:57:21 -0700
X-CSE-ConnectionGUID: DUoLa3r8QAKe947QoZu1lg==
X-CSE-MsgGUID: 1ahqLF8BRqG/bCFTlw0WhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; d="scan'208";a="207293748"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 08:57:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:57:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 08:57:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxSsBYjJZtvcNq8zdxfGx0T8NmvOA1V2SK3ryeZmSceQu/h48SVN4Rt6UEVwtNlrZHzUA9vhMFsO/pkVRptzeLjIX5+VYVL1FbzqQSpOd9+FfZz9qhubjqIxQ3ZKh+MszBbEnCFfvoDibZlix0fPQxxkGuRkr37X15Ja+uKBJLtJzxX9sKnWCh4VqRbhQQTtbmrVHFreRniWi5ys+CEBWr1scODkIlIVrfKLlHxv+Nf8VoSa7ltkcAprQ2CyXLwEU+GV3y2UnThHhcjtUd12NMVFcsop+Lf85akztT9vddX1u+fmp19Zg0uP2SZcHKa104B2aVd05h56RqiJT0F41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNpPCGl0JSXkEQzPD5WNykb7WyGVEhxs8jXVWP/4yXo=;
 b=lfxYTtt6kFFLISpkdd+iCvorCB7ha435U/pfHTX9fBHk/hqP9IhIj0NfYVb2gTCyAdRWN9HL95lvtR8vvt9YLgBurxGcLhlFRVP9qi3kOLyo5biTgdSqg/e2GRwG0ccgQPw8EgFkZ1shQaghjRPyouYQJZgRe7EHnXSPoiZAWlwCSi1CaiHGb2/34UmO26skLTgNaCp+NuzZW9ozPAzHcGHt3KFR3yoax+fnUw/we5ikaQVWWFJeDG6MpVY+vFsjTsr9DY+uD50Y5BpuChHqa/b3Cx60WuMLqjoTYFyCupplhJ0dLjJz0e17vuvNd2h9XYGsWbTmtJy6MFSFkJ2csA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 15:57:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 15:57:12 +0000
Date: Thu, 28 Aug 2025 16:57:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Doraemon <nobitanobi@qq.com>
CC: dev <dev@dpdk.org>
Subject: Re: [Help needed] net_ice: MDD event (Malicious Driver Detection) on
 TX queue when using rte_eth_tx_prepare / rte_eth_tx_burst
Message-ID: <aLB8UeIjprkqLrBm@bricha3-mobl1.ger.corp.intel.com>
References: <tencent_F6CFD7AE41985DA5FB835CDE833F44C6AF06@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_F6CFD7AE41985DA5FB835CDE833F44C6AF06@qq.com>
X-ClientProxiedBy: DB9PR06CA0021.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::26) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c68001-7572-4f5e-5ac3-08dde64b8c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEpEVVd4b0ZHN1BUK0R4VWR5a0c1RzNCeWdpUVZuamExN0pJU1UzOHpoamJi?=
 =?utf-8?B?QlppWjh5TFlINGd5S1p2MDVTbGtPd2FjcVA0NysxVGpPdW9GVDgzWXdVZ3VW?=
 =?utf-8?B?S3ovbUJBOXpQeTRYTndwY3R3di9KVjNEODU4MndBVWhIaWU4eTlNSGhvbWJK?=
 =?utf-8?B?U2ZneW9TdEF1cndmOWhWczNFVU9aQXU1L2xOenBOZm9ndFJ6SmNOdThMYVdy?=
 =?utf-8?B?Vkh0S2R5S0NkNFkwdTQzQmxDLzNONTRJTnNTNmxMZHNyclZOVmQ4Q0pBM2Z2?=
 =?utf-8?B?ekMwRW84Q0E2b3NhRGlvUGplcnBheno0dXRqT3gwL3hxOHVDOHludGpyQXd3?=
 =?utf-8?B?aGw2bUNFZFR6VWV0M1RnaGxaUG5KRVJ6NGVZUGI1Y2JUR09ielhQNGVTbDFK?=
 =?utf-8?B?d2Z3SXFITjZGby9Dd3dzTHVNZXg4Y0ZRT0Z6TWlGS2pLRU5Tak1NdzNrbUVO?=
 =?utf-8?B?LzJQanAzeUdRSWJzT1hVMmFhQjQzanUwQzJiYWE1cDJqNTZrM29NanR6Mk52?=
 =?utf-8?B?N09mSlhJZjFBSjJEK3JpV1hhak5BNkxabVo5Z0NUTitMcm90dmFkS29oS2Z5?=
 =?utf-8?B?Z3R5Q3RFWmpRUmJFTHVZZzVrOW9VVnVFdEdPUGtZQzdHWGg4SGpONER3dTJ2?=
 =?utf-8?B?TzZFQS9iYXZraUxJam44Y29QMTFCcXZKT25lSDhDRy9hdVJzVm9sb1RlTUJh?=
 =?utf-8?B?UEIwZlc4ZTZ4eVFtQmdTSTF3MGVzQzBJRHFacElVZ1FrNFNqaHhCWVlTdVVE?=
 =?utf-8?B?TVpNczJXTkl2ZFBaN0oxSVp6TGhqMWNqUkN5OE54UVNyZUpsdWplMitDWGpS?=
 =?utf-8?B?bnprUmUxZzRseDlqZTRtL0FhODIybG5peFRWcVFGdUFDN09DOHZYN3ZzbERK?=
 =?utf-8?B?ZityL0VvWFVsNEhDaGd0ZEgxUXVjSzhoUHFEKzdzeUE1WUZZNC9IUU9XeEIv?=
 =?utf-8?B?aDJiYSt2Njl1a1JRaDFMbm11bC81MlJPQVBwVHA1RTh4NVE2d0hxVE5Gak42?=
 =?utf-8?B?RjRNZ2lDS1lUZUZOYTBoRkR1MHV2cjc3RElYVy9PbjJXN3RKZk5jKzhCaEkz?=
 =?utf-8?B?aU5BYUFHUm05NVJLNTBTc24yZGFSM3djckRnVExYcFh2ZERGcUJ2YVBITTZ4?=
 =?utf-8?B?U25NK2RlaDlrTU9lZUNoVGYzb2pTclJXTjNMQ21WeGhVUys1MUtNUDBZVXJH?=
 =?utf-8?B?bkhPVllBajg5Y21rK2wxUnM4TzdOK2Y5NitlaExSRUJRSkc2RVBmSVU3TUhC?=
 =?utf-8?B?U3FTbEUwcm14UXo2Sk5DM2JuNm10QjI3dUw1dy9YUHptN1RvMkMwcFlOK1U1?=
 =?utf-8?B?cFo5YjhUdzZiMGVOY1lSV2x5Qi9BWVBEMzQ0N3BzbTdGc0hlaUZzallXTTla?=
 =?utf-8?B?cjFGMjZXbUZ1UWNDcThUNmlpOTVLVkE4dDJYQWhTVlBZYUp5QmM1cFFFdmp0?=
 =?utf-8?B?UTEzUDA3V3pEZC9LNkIxMDB3MDNKYkRpdWRtNmNsZ1Y2ZkZxRk1IKzBRblhR?=
 =?utf-8?B?ZXlyQU5mdlZuUFMrVEh2L1lGeTZXY1hYQ1pFWWdNZXk4aEJpY3hZZ0cvKzl0?=
 =?utf-8?B?SXYzcEpyK0ZJUFdWZGtwcnFYWUJqWjV0NUdhaHNqYmFrYlN5ZlFha2VuVHQx?=
 =?utf-8?B?UXVOOFhQQlAvWjl2N0Y0S2JCM2dUdHBsWWpxdHpRUnJ3YUVXSUc1bEQ4SVJO?=
 =?utf-8?B?c0dXVSt1WFBybVhtdGp5Rm9PQTRQd0h6K1FiekhUSk93TEU2UmM4Nm8wZUZ1?=
 =?utf-8?B?MkVIOWRIRVBqQ05sUkNHa2Fac1ZhYzYxTUJQNlNxQkdHdEhtOFZ0U0x6MFVJ?=
 =?utf-8?B?aGFxNWVLbkNqZFJsQXY4VmhDenBRZElBeTdMdFVJU0QxdVY4UFNBU3VrZnpN?=
 =?utf-8?B?TUhDcjZ6cUJpUFFUaVIvOWFNaE5NSlRVZVREakUwRkhsMHpnZ1JqeVRIbnpI?=
 =?utf-8?Q?+2fipWyPkjQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWltbzkxMDM4Z2FIZko1SDBHeHozZHFtMTBSNmhQNkdzY2JFMWlGRlJKclZS?=
 =?utf-8?B?VS9zZHhDeDFMUGtCWG5vSytrb2pHVGVOK2ZoRUh0VUVycUFXQTMrUE40cGJu?=
 =?utf-8?B?ejhkUVc1c1VNUXovWjdYdURZcUM2Q0NSdlhlamVoMFgydUhNZHYxWWIxbi9l?=
 =?utf-8?B?dEUzNEtKSkpUdmZZTTU0QVJYZEtHMkhVdnFDVDc3clBGd1A1dWNMcU5PM0wr?=
 =?utf-8?B?U29LNUQ4Z2YvUkJPNTlpRVBCem8yU2VOZllKeVgydnNEem1EMkdxak9UcS9J?=
 =?utf-8?B?NzVnc3ZWdXEyWDVoYVFlN0pzRnVaSVFQZlFMZTAxZDVxSHVmWXJUWFcyaHF0?=
 =?utf-8?B?dkJtMUVhaHcxZ1VLK3Z1TzJsNXdZTlphR3JZU1preDh2WWxTZmpEa0hoNDA1?=
 =?utf-8?B?dXo2VTM5bjA0bFVTS3UwREM2M1g1bGsvcWE1cmUySCtkYTBxSkwxbytZVWpZ?=
 =?utf-8?B?aW9BQmhCbkF2STRXV1BrdTVOZ2pKUEw3U0VVR3VVbkVrWTBGajVJa3JjZTND?=
 =?utf-8?B?QTZOUXRjbUlYTmVUNEZxMzFxKzAxa1YxU2QrRWlXekowQ2NGNkhZSHZlQ2FZ?=
 =?utf-8?B?dlJYRmV0eEdSQkdFWklpcUhvaXNNZEZWQVR2bWUzdHVDSDUxZ1ByODBmNDQz?=
 =?utf-8?B?bVpHM1F6WldIY0h6UDdEbHZSRXRrRSszcjFZbmhONnordXp1Ymg1ZVE2Y0dV?=
 =?utf-8?B?QWp3NnZxQ013QkJhb05PbWRBRWdKaDBKVEQ1YTVVTWFUaU96VXVTYzVvTG16?=
 =?utf-8?B?NENucnpnZUN5b2V2bVRrS1VxTlRiQ1drV3RMM0tGSVlkN1g0aDZTYkxBaTcy?=
 =?utf-8?B?dDFSZDJhcURVNFVPS2Z0SExUOGswZFVYNGtLeHZHcDlkY3IyWjF5aW9uM2VZ?=
 =?utf-8?B?KzNEcncrUWcxcldjalNxVmtPbmJlZXI4eGlNNUNjMjNIOXM3VnJTSnBSaUVT?=
 =?utf-8?B?bUE4cE1ERnpVU0FRNS9MZ3QyWEhaNDl3RXQ0ZXR2MmtsVitCMG5tNncycjlR?=
 =?utf-8?B?TDI3N3ZITXk3ZWcxTjNjUFgxQ1JGL3drRHlNNjN0Q1grN0JQc3Z1QkdRcGtY?=
 =?utf-8?B?eGZ2SHY3TmVsc0paRTdPaU1RRmVHL0JYVFp2dEtTaW1nMTdqeHlzZUp1MzY3?=
 =?utf-8?B?UGVUcUNJUXVKNmtXR002R1FSbGlWaTV3czYrVnA4Rkk5VWRNM095SzFaanAz?=
 =?utf-8?B?K0JJY29JMUpEL28zTzV3bWR4SlRIcjlMbncxMm0wdy9vOHczM2o1eEZoMUFh?=
 =?utf-8?B?MytOZ3ovQjdiWkdSc041Y2c2QjVFMURURVc4cDFOTnl1dUJMeHRpZWNaWUpN?=
 =?utf-8?B?bEE1UHFnRTFmQ0tUeHRHWEZRT1lVQXhJYmJNWklPQUtKdUxWOFljMTRUNDc3?=
 =?utf-8?B?N1ovMVpNcnhJZXl5Qm9IeUgxYWpGN0Q4NG9ObVZxNngva2hKWjhJNy91Mjlk?=
 =?utf-8?B?cURTY01jek5PUnJMcFJhcStyd1llMTRxMkFLTGc0M2UwZldaNVBuZ0JCMkpa?=
 =?utf-8?B?bGRqdjVQbm90bXhxaHJ2T3hhWGNPVTByK0xDSVZjQjFDTTVHSXd0a2tXWDY3?=
 =?utf-8?B?TjdFdFJ5MnY2VUZud0QvQXE3eFN5dmZxKzljUXVsTFMzdW5MWmN4Tm9HaWN1?=
 =?utf-8?B?ZEFReW1yM2x1eTdGNEVWV3V4UVBFUWNybWViUGN4VEU5dUp4RitaUnZrODdz?=
 =?utf-8?B?bmlNSHZNR0tsbXlRblQxZ3VHbjVTWEtwN1dXSE5RR0NRc2hwRllwc0lWV1RQ?=
 =?utf-8?B?cnB2TVZVRi9HWDJYRURGQ0pZY3lKcks0cWtnd0wrczBvYS9BalFXRlh5MXJ4?=
 =?utf-8?B?SUdKN1RsOCt1WXc5OVMxUERyTm5xNGJUSHlSalhGWFJJWHdkVEFPQyttUWVW?=
 =?utf-8?B?bVVZRDFRY01Oc0U1TFVCSlpqRnF3a0dvVlJpYkkrV1pMLzA3K2pkNXVsK2Rj?=
 =?utf-8?B?cGNtcUxRYkI4ZXpWZDBoNmJIWjVMLzlTNVlLVXg4ekxPN1hYUmdXOWp4MGRF?=
 =?utf-8?B?ajJlME9odTBMWlRRdXZoWWpzbmg2bVpudUVHVVYxUncrTlM2Z3Q1S1lXdHdD?=
 =?utf-8?B?U2VnaC9JdEh3TnRlTG9CQXE1VTVqcndsU2p6MUhpWUtqdDNjOUZaZ2pQQytM?=
 =?utf-8?B?QmIweXpTdFJDdEl0SEtWNWpLUnkwQ0U5N3IveVVxbkcvUjRhL2pPd1NrOFJy?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c68001-7572-4f5e-5ac3-08dde64b8c9f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:57:11.9132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tdZhXg4EUAcDJ0YtlQNqzlbv/8uIiRQ6krNYcj/5mjvXfN8i47KI6Q5WHqo9ru1OBVynl7D5kloRGyBBl6vzI7g9hN81YwAPY+LIbBvRBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
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

On Wed, Aug 27, 2025 at 08:52:26AM +0800, Doraemon wrote:
>    Hello DPDK / net_ice maintainers,
> 
>    We are seeing a reproducible and concerning issue when using the
>    net_ice PMD with DPDK 22.11.2, and we would appreciate your help
>    diagnosing it.
>    Summary
>    - Environment:
>    - DPDK: 22.11.2
>    - net_ice PCI device: 8086:159b
>    - ice kernel driver: 1.12.7
>    - NIC firmware: FW 7.3.6111681 (NVM 4.30)
>    - IOVA mode: PA, VFIO enabled
>    - Multi-process socket: /var/run/dpdk/PGW/mp_socket
>    - NUMA: 2, detected lcores: 112
>    - Bonding: pmd_bond with bonded devices created (net_bonding0 on port
>    4, net_bonding1 on port 5)
>    - Driver enabled AVX2 OFFLOAD Vector Tx (log shows
>    "ice_set_tx_function(): Using AVX2 OFFLOAD Vector Tx")
>    - Problem statement:
>    - Our application calls rte_eth_tx_prepare before calling
>    rte_eth_tx_burst as part of the normal transmission path.
>    - After the application has been running for some time (not immediate),
>    the kernel/driver emits the following messages repeatedly:
>    - ice_interrupt_handler(): OICR: MDD event
>    - ice_interrupt_handler(): Malicious Driver Detection event 3 by TCLAN
>    on TX queue 1025 PF# 1
>    - We are using a single TX queue (application-level single queue) and
>    are sending only one packet per burst (burst size = 1).
>    - The sequence is: rte_eth_tx_prepare (returns) -> rte_eth_tx_burst ->
>    MDD events occur later.
>    - The events affect stability and repeat over time.
>    Relevant startup logs (excerpt)
>    EAL: Detected CPU lcores: 112
>    EAL: Detected NUMA nodes: 2
>    EAL: Selected IOVA mode 'PA'
>    EAL: VFIO support initialized
>    EAL: Probe PCI driver: net_ice (8086:159b) device: 0000:3b:00.1 (socket
>    0)
>    ice_load_pkg_type(): Active package is: 1.3.45.0, ICE COMMS Package
>    (double VLAN mode)
>    ice_dev_init(): FW 7.3.6111681 API 1.7
>    ...
>    bond_probe(3506) - Initializing pmd_bond for net_bonding0
>    bond_probe(3592) - Create bonded device net_bonding0 on port 4 in mode
>    1 on socket 0.
>    ...
>    ice_set_tx_function(): Using AVX2 OFFLOAD Vector Tx (port 0).
>    TELEMETRY: No legacy callbacks, legacy socket not created
>    What we have tried / preliminary observations
>    - Confirmed application calls rte_eth_tx_prepare prior to
>    rte_eth_tx_burst.
>    - Confirmed single TX queue configuration and small bursts (size = 1)
>    �� not high-rate, not a typical high-burst/malicious pattern.
>    - The MDD log identifies "TX queue 1025";  unclear how that maps to our
>    DPDK queue numbering (we use queue 0 in the app).
>    - No obvious other DPDK errors at startup;  interface initializes
>    normally and vector TX is enabled.
>    - We suspect the driver's Malicious Driver Detection (MDD) is
>    triggering due to some descriptor/doorbell ordering or offload
>    interaction, possibly related to AVX2 Vector Tx offload.
>    Questions / requests to the maintainers
>    1.  What specifically triggers "MDD event 3 by TCLAN" in net_ice?
>    Which driver check/threshold corresponds to event type 3?
>    2.  How is the "TX queue 1025" value computed/mapped in the log?  (Is
>    it queue id + offset, VF mapping, or an internal vector id?)  We need
>    to map that log value to our DPDK queue index.
>    3.  Can the rte_eth_tx_prepare + rte_eth_tx_burst call pattern cause
>    MDD detections under any circumstances?  If so, are there recommended
>    usage patterns or ordering constraints to avoid false positives?
>    4.  Are there known firmware/driver/DPDK version combinations with
>    similar MDD behavior?  Do you recommend specific NIC firmware, kernel
>    driver, or DPDK versions as a workaround/fix?
>    5.  Any suggested workarounds we can test quickly (e.g., disable vector
>    TX offload, disable specific HW offloads, change interrupt/queue
>    bindings, or adjust doorbell behavior)?

While I've not come across this particular issue before in the past, one
immediate suggestion might be to try the latest point release of 22.11,
updating from 22.11.2 to 22.11.9. Checking the diffs, I see that there were
some changes made to the ice_prep_pkts() function between those two
releases. Perhaps those changes may help here.

Regards,
/Bruce
