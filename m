Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7B9C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:33:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13FE0402E4;
	Wed,  5 Feb 2025 18:33:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id E524F402DC
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738776793; x=1770312793;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=av1x8n7DJfevW7s7oLmbapvANShOyLXI74cT5E+EVLI=;
 b=J20/WVBC4tk/LWA9Basq5l/cFb4vL66YoJK2Gh0f4p+9zfPJowcs3LWS
 6v5TRdlfpnh6RmDAk/7LiEJ5oYjSdSi/55Nm/j1ISP8q0Gb7Ug5GV49iL
 N2Uv/mZkGpazay1kbsPT2/Ofzmmw8KRVb0BP4+0iju3Bo6j3ioYa3/G8r
 3yqR56SEIBI1Jn7kgNdivO6GlEXFaQdZt9dMfq1kBXJWel3mxcKxQHFya
 hl+TOPdIsHi3+N50HScsr/n22rfZ0GO9xx0H1j38BGz2uD2uKaY/LcBbT
 fe9NMUPHR2ynTEiRM6fRrYBk1bwDJ2Qxmb56cotl7/WzuDHDgik7zwTq5 w==;
X-CSE-ConnectionGUID: +GRHdEPNShuZQsaToWiD9w==
X-CSE-MsgGUID: nXw6eG69Sya+513SEpAiew==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50000653"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="50000653"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 09:33:12 -0800
X-CSE-ConnectionGUID: Ji3OcO4WShqmPsZsgErMnQ==
X-CSE-MsgGUID: X5zSteq5RSyTaDxepfNODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="116015748"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 09:33:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 09:33:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 09:33:08 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 09:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w26TKo7cMkQGLW0iqCvuepjod3MBt9n+H6UCG47NCDDZvLynG4mFJQt54l99fBAbkEYXDkGodl4oyhVR81qIP6eucsZ8hSnoO8uzrMWjj3Anb0JRHcAaB8Y+FKU/4g6raBsCM3lQQDx98wXBs24SO0qYIDRL+8gwlpt7v+mVkD6yYrGJXe11uA4PCkFaV4MjCEuSvXA6m0nZQK6vp+J+Rjxr4bOCCSFPyhuao58N6fIzRhZD87ysbkxhTc8Nfbx8lg4yghQLWuvJB9lDAZxLserzDcO9Ekhho0pVpIihzSpCC+O5JcglyFEjTRNlseC9HQURSwRhmSnU9KW1JQ2oSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbYsHy7a0t4uFQanFtt6NeDZGyZ9YT4IiUwPzPefybE=;
 b=ua8CfBK77QU8aE+Z6qaA4GDThMDXEuxr+tIPDVJmdsxgHrHi3skc4c0PB4ZEouoHG7W9x915iXKEVGMbMAeb5y/PEoVtO/vHw/vTl/o1rzDKN8WVFoqZPgNteoaf9zUhc94PDQkd67bYM72QYeZn+XFq5vapzhi9dvqqyXyjt/2t58cMPzc7V44CK3rMgEfLT8+QKV2hqo1oREFOjxljy/2U1JIp8vo//aBHv0BuIWbqXrjfDQs1Wzo+Uria79wddib3o9dYYP8enSiRD42Ln5+UaRwZX7ne5TM8y/Qh+bHptZgmm4OOrO7FHX3IbuG1ztvU2SY1Pw8vOFUTMIQPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 17:32:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:32:17 +0000
Date: Wed, 5 Feb 2025 17:32:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <ian.stokes@intel.com>,
 <john.mcnamara@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] build: remove support for icc compiler
Message-ID: <Z6Ogm56u595MFQem@bricha3-mobl1.ger.corp.intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <CAJFAV8w1ROF3rGGyrpDWokpxZT+tiG1vWXbfwFemqSYzt3vPBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w1ROF3rGGyrpDWokpxZT+tiG1vWXbfwFemqSYzt3vPBw@mail.gmail.com>
X-ClientProxiedBy: DU7PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 896261f8-3feb-4ffc-ecd6-08dd460b0994
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlprNVI4elJSWXloT21WR3RGaUVtSHZXUFlXa3VITFhIZjJpSlh2eWdEb1Nz?=
 =?utf-8?B?RHZlLzV1ZzZjQjBaQmtGSU9MYUtlR0RpVUphNlM0QkJSTXIvOEphZE5rczJJ?=
 =?utf-8?B?UFdKQjZPbEdiY1J0cExJUGUyQ05LcGMrUjc1Q3ZnWk8xczBBQm02NlcxUHc1?=
 =?utf-8?B?THFKL0pjTHlmRkRMQ2VOUWp3S09wL2dSWUNTVFNIZXkxR1VZL1ZjK2ZORllW?=
 =?utf-8?B?TmdEd3g3NHc2N0lXRTZZVXp4TDdwR0R0ci96MDdELzNuT0JnTGtKNVczSkJh?=
 =?utf-8?B?YzUxRTJYaE1KSHJobWQ4TG5DalR3QzYxcUFyQkN4WU5mUGNBamFMQ3JpZ0ZD?=
 =?utf-8?B?eHppdHZYck55eFgrZmJFem5YeUtUTzBZYm14T2lkeTI4ZjRtZllHcVdwT1Mr?=
 =?utf-8?B?VVFPR3dsd2RLaGNwanZabnJBaldGa3hGdmUwOWE2amJBMWMza1NaV0I2aURW?=
 =?utf-8?B?dXdsZlBEUFNrREY3UXk4NEFNeXYyQUdiNTIycFNnU2ozSjZIcktMNHFmVVFQ?=
 =?utf-8?B?NjBEMUNqTDNyOFNyNU5MZVUwV1BMYzhGQ3pDa1l3aXBOaHRPd0NQZk5NVFF2?=
 =?utf-8?B?RVMvYXo0aWptc0pLVFVRaFc5LzdGMENiaHhTR3FBNnJML3RqMjh0Z3p6UnRj?=
 =?utf-8?B?Y1ZHVXFZa2d1bUM4V1M3N3NsU1czcGF2UUI5ckFteC9mWHdQU21udEIrQzgv?=
 =?utf-8?B?Um1sc2p6Y3RoenlXenlpS0d6TnVhUDdCZXZITDdQQm1RUCtQbXhRTE5UajFB?=
 =?utf-8?B?YThJTGt6ZGgwUlFkTWp0REQ4c3kweXMwbUpxajliK1YxWUw4SGMvMzEwcURu?=
 =?utf-8?B?NjJ3aXV4Yis4dHdTd1E1MmxjS25CTFJaWWUyWWlEV21FK1RRME10Ulg4ZVg5?=
 =?utf-8?B?R1NQa1Vnc0dBSWp3bXBQOU1OM0s5RVRxODNUYjV2cWlyZUZWSWJFM2NMeld5?=
 =?utf-8?B?V3puVzVZR0lGckE4YUVLclg5a0tjb2V5ZDh1L213Q1RJYVpKWUhQM0s1ZE5S?=
 =?utf-8?B?bGM0c1JWUXZQVDhJYXliTnZta0k4K1RXTW5rRmxGNjIxOVQ1ekhhNXVWRHlU?=
 =?utf-8?B?aFNnUE1CUVovQ0k2VjRJbUhrZWwzMDRTTmV3VE92N1VTa2dvaEs1elk0WEJG?=
 =?utf-8?B?eXJ5SGJnekFwWU0zZ2oweTlpM0JwYjUvSzhRZDdidHV5bThYYUdOcnNIL3NZ?=
 =?utf-8?B?SDhaUitJV3ZIWmkwb1Ruc1FkVlBPTklOV2FzUDlSQmsxQmtBcmdiTy9ZR05x?=
 =?utf-8?B?aTdENlhoZDV6RTNMczc3RmQ5eHNwT1hIT0h4QXZGVVhFQUF4WlF5Vm92S1Ir?=
 =?utf-8?B?TkpJS2g3RlA1dDAvSnc2VHFlcFNtVmhjRlY2R3hxcFBBZ3B5WHBFS2JGM3ZZ?=
 =?utf-8?B?S1FjdVhoRXpaMUM0YmduYW53SEJIOFJta1I1clZFN0VlOEtGRUVGbkV3cSsz?=
 =?utf-8?B?SGh0dHRHZHYzbEwxd20zSXhCaDVZdGp3TXNLYlRPdUNNZ2JaQUM0WDJYZDVP?=
 =?utf-8?B?eS9XUERFeGpkZXpybHY1cFY1ZDNKcXNzWFNodEcrMWhRY3kzU21WNmpFSjVM?=
 =?utf-8?B?SUhDa2t2aUdia1dmazBlRHZXMzNwMG96NTV5U25TWFlobFZCTFJ5Ym9lbWJV?=
 =?utf-8?B?bFEybnBtS1NBdS94Tk9HbVpWRHlzcEMxMDI1azFpbFltcEdzK1AxNnJBYlJ1?=
 =?utf-8?B?THBrNERCeGRNQ1FRT3FNZzI4UTJXZCtPK3dReVVvZnhBbFhURUtLQk50bjNU?=
 =?utf-8?B?Q1p6WkZMbmZIaUtMS1ZDZ3hqZFZsNEtxbkdPT2NHbFNRSmhEakJPU2NqMUEr?=
 =?utf-8?B?VDdCUUxhcncrOFVtU1A0a2VrcjR3M215UmZVQWc5cE1kWXpWbEEyejBGQlJR?=
 =?utf-8?Q?B5sJeMbO/4xbP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZ4R2p1SDFrZ3BBTlhIMXQ4Slo5RVdIcExkdWxQVU5vUnRocEFUMGM3QlVN?=
 =?utf-8?B?SVRzZlMxazR0TnpGbGQ2YXl0cGVXdGV5em9YMk8rMEhWU0xxZTdvdWxGUnA1?=
 =?utf-8?B?NXhOdkJSd0lCak9DQjM1emRKUFFOYXVaV1YzaTlWWnJ3UGpJWHFKN3pKUGt2?=
 =?utf-8?B?RmhlWUFhc2NGRVEvMSs3WlM3UVBzaXR6TXAxOGRSRTlUK0RJaVZGL1VQZ29y?=
 =?utf-8?B?QURYYjh6eHJMT3d6aUlwNkFxeHU4cWVFR3pNWW16bURyRXp4NktoSmRqdFI2?=
 =?utf-8?B?alBORXdDRmFhVnViQStTSXFDRkRJSUtCUjEyaDZwMXRDRnBzdG1mWG5lY1Z0?=
 =?utf-8?B?TWtLcGtCQkw4eHFrd05Pa1ZxWXdIU0dzRnZBVytJM2VrOWg1UUo5Um1NSjNL?=
 =?utf-8?B?a1ViaTZ2cExZemxBK0NMdTVPZWswY0JjVkpmRHUwTk9EUEE4d3hFanJXTDY3?=
 =?utf-8?B?Y0V3Q0kzWWx3aW9VZis4OVJVV3h5ejlPNDRMMEoxRlltdFFwQm9iSE94aVc5?=
 =?utf-8?B?cEl3TjVBb3B4bXYwSVRWT1RpbW5jNm1zYzNSR3hBZHNoL2ExeU9JU09WMnF1?=
 =?utf-8?B?QWxkT1JDUVg4bjZ5Y2dPcCtDV0FZbWM4dHJoQm51a0RmTTY0VTl5WHliN3pi?=
 =?utf-8?B?RHlqVHdwcHRtdDJZRCttcGRTNXlxaTlxN0xGT1gzcnB1VmZueTloNi9kYm1X?=
 =?utf-8?B?NHVPdGVvaERyVDhLMktQd3VyUWdydlZnNkltcnZ0K25BRGRpZXFtaElUQkg5?=
 =?utf-8?B?ckxuWnJZZWVHaFdyeHovMTlxVU81VDFNRTFWdGtIR0ZXT1BQaEowU0VZRjZX?=
 =?utf-8?B?dUg5TWZmdTlpVFlYbi9adHhRQko2ZXNsU2RSRWtUZWl0OWhNQ0lIQ1pMM0RQ?=
 =?utf-8?B?aWtmNWhlZ0tGTmpLNlN0NnI4MVlaNUdnQi9mRE9IbCtFUnQzUzlNWDc1M0hB?=
 =?utf-8?B?RHJKelN5MW5SSk9scUlMNkhDcU82SS9HRXdSaG5MMlhOT0lBU0RyUHIwOHVG?=
 =?utf-8?B?NG54MVRZQVVONno3SW9TYVp4T2tmVlpZanlnM3JCMlVFUnNZSVdXby92ckdI?=
 =?utf-8?B?ejhnaVA3RHF1WGhBZHY0UDFEWEVSUFhkRHA1SWdiUG1jVUhrN05DY2VYZDEx?=
 =?utf-8?B?TVpRVWRJa3ZiMTZmOUNLNjI4TThUeklaSkMvNEdidWZETnhDdGtoZjY3MU9K?=
 =?utf-8?B?U2kyNU05MjQrK05sV1lZZTIvRDlheHpiWXZ5UmsxYWR1MDc5d1RQNkZoN2J2?=
 =?utf-8?B?V3h2cFNucmE3OEpCaGYzQTcydVJtcHByc3NvTmFkSzVQWE81RzBYSmFIRmh2?=
 =?utf-8?B?Sk9DK1RBRUhuRld0REhiRUxDa1hTa09IeTlyTmJYL2tHbmtyVzdnNmlUYkh6?=
 =?utf-8?B?K2JtU21pMkVIZmFHQmplNmZ5elhxOFNKcWxKSTk5b0FWM1R6dVJvaVdsdkhL?=
 =?utf-8?B?OXIwOTV4TXZJU3ZYOHdaZHY1RHdNV1NDeXF2T1NhdGkveGJxelowMHRuQTJJ?=
 =?utf-8?B?a1dVUU1oK3I0SVBJSlNwUm5NMGNYQ1F2S2Q0ZDVoV2hLaFl3bE1IR1laTk1R?=
 =?utf-8?B?bUp0WE9PckNMZUc1QzFXeXo1Ri9DNjBrWTZScUpxSzE3Ni9qcHBsMmZrT1Zx?=
 =?utf-8?B?YmhVTUl3ZFFoTXJrdGRIRU1pdXpuRWxYVFZpZXRWNFFZRFFjNmRBeCs1dk5O?=
 =?utf-8?B?TUNwa1hYWitOTjhYdjYzMkMyOGtZa090c3FqdW1oQXpINGFKdVRWS1dCOFEv?=
 =?utf-8?B?d3B5RnA3Vk1ldzZFTHhCc1VselZmTW5pUGt2eCtDaGhFajJsY25jZU1UWFcv?=
 =?utf-8?B?d3I0RlZ5OEduS2F2eVNpMElYb2hPVlVzTUx1Mlc3KzZWV3FqUlJ2Y1NDL1E5?=
 =?utf-8?B?bEVzSWtLdXdraWpSOW5hVXdOajI0L2dONzcwTEt0Vlh4ZUNSTm1ZWEg1TDRz?=
 =?utf-8?B?ZXBtYk1XdUJJK3FxajIrUlZ6NEZ5eTFmWkFtR1piWFhGVWt3NTVKMzJ6eWs4?=
 =?utf-8?B?Ym9nVDBDdElJV3Z2UnNvczlhLzhQN2tUR0hGUS9zM1VBYzlENlltOWdjc2J1?=
 =?utf-8?B?RjVaZHNMWE5Eb3pkemRCNE5MSysyRlFlZ2tsRUZpNjBmd2xNN0VNY1ZLSEc2?=
 =?utf-8?B?ZkdhRWxDdldJVG1wZFpHUjR6bmRUc1QxS1VFdXQyQXlSbTF6ZHYyckgvL2lp?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 896261f8-3feb-4ffc-ecd6-08dd460b0994
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:32:17.8033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6Lh6+RaPXaNfCfvatFlJ7RU7BcKbG6xTCxoyfLzhRrd07UVDou1DSeDCn33s//0A2ZKGBSoBYT/fIkH0SrCPTCeBu1xmkQ2LuZAi7UgPpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
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

On Wed, Feb 05, 2025 at 06:03:16PM +0100, David Marchand wrote:
> On Wed, Feb 5, 2025 at 5:19 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The Intel-produced compiler "icc" has been replaced by the newer
> > clang-based "icx" compiler. DPDK compilation has also not been tested
> > recently with the icc compiler, so let's remove doc and code references
> > to icc, and any special macros or build support that was added for it.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I noticed remaining references, from which some can be cleaned up too:
> 
> app/test-pmd/testpmd.h: * Work-around of a compilation error with ICC
> on invocations of the
> 

Yes, I spotted this and a few of the others too - but forgot to reference
them in the commit log ntoes.

The trouble is that for a number of these cases I've no idea what specific
part of the code the workaround is, or what it should look like without the
workaround. 

For this specific instance, the ifdefs in the testpmd.h file just refer to
GCC and non-GCC (presumably including clang), so it doesn't seem that there
is code that is ICC specific. Shall I just remove the comment?

> lib/eal/common/eal_common_dynmem.c:                     /* to prevent
> icc errors */

Same here. It's not clear to me what way the code should be reworked if not
supporting ICC. Again, I can just remove the comment and be done with it.

> lib/eal/x86/include/rte_vect.h:#if defined(__ICC) || defined(_WIN64)
> 

This seems as miss on my part. Will fix in a v2.

> buildtools/check-symbols.sh:# Filter out symbols suffixed with a . for icc
> buildtools/check-symbols.sh:# Filter out symbols suffixed with a . for icc
> 

This you may be able to advise me on. I assume that the icc-specific bit is
just he "&& !($NF ~ /\.$/)" bit, and not the whole block the comment is put
on?

> And please add a release note update.
> 
Yes.
I've also been testing with the newer "icx" and will probably add something
in the docs about it working ok as a replacement.

/Bruce
