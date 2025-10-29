Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74259CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 10:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927A6402C0;
	Wed, 29 Oct 2025 11:05:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id AA0DC40288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 11:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761732322; x=1793268322;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=OyPeXbcAA/9nHu+eP2QbB81gvmvrlbW+XWKZv73qfKk=;
 b=mrI1D9BTfHR3DOYSKmu6DUDK/b9SGz9g+aBs9bGhVM88DIvfvvHBkviG
 EKjTezbCzHzFyjoa2AKrNnnKqQcsr8L2fuzqHMB7s37MT7DfHytnyBmSE
 J8HdvpgcvJw9LOzzybvMx4Kqo6Um9BLLf3nPO5WtHGhAjOvR/wE2J1iDH
 0ypfE2lhuYGwq7mmALr+unqCYeXXEQ3UDXu6PXXmjJieP8mbd7Bfs3GOO
 0v6ZWw+YHpYJEFnfV+GtZ6KwhRX8k2jD1vOfBz3GdFgE1/hXUqy6xOC27
 Ycj/8Q2piC9lqTjM2qQepD3zrt1nyt9nBRXwrJPdOtMHiWAmX5F+6t/f+ Q==;
X-CSE-ConnectionGUID: Fj99g2IKTlK+oK62VhwZdQ==
X-CSE-MsgGUID: lRblaLdJQeWMxAAziHAjuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63752451"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63752451"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 03:05:21 -0700
X-CSE-ConnectionGUID: eqHhBpL8S9634yLjZ/2CoA==
X-CSE-MsgGUID: q3VKRxIsTne/OaAgHx04cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="190793472"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 03:05:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 03:05:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 03:05:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 03:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4kjiiCDEL9gU2/xN1rabfECp5mZftEVJodJ4ozbHb7UKlBeAQf5gqJYJgXPK56bMMPzk5XKKgF/nrSNwHJuIO/54accCu7AiMtm8DZJYGrs+20IeJZCrZ02vhoJuUgmUNN6huxpki0cMss9yRiXSI8iBA51wmrD+jZe4cp7bAqjyXU+e1YqLesu0RGhgAFWWZwGxuuZGKKx6g50/Q8hprxffIJxwIQgx47fF9+09pXnPGzFkjDjKmD2xk5wQRMFT5JpeC0zp4dXJztJM4ZxN57fg3TG5Utv3pShqDw1D0UWDlkcE3X+hI5grc18yrqeEuCoVuIetm6zmcrGO+bz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzAVzHx+8dP70B6Sf4tWNInNw8hXbrelaKvq8or/BIg=;
 b=YV8lp1OpdFkzloCO76MeoOoo1fllcBQkY93OxVGmkluJlhT5EWJPh80uYDlbADA9Ugeh3n2LRrtVOZyPDUvs2le5gd9DM3j/FH0h98JA25g0l9hEC3EE75ZSvXH1/1Vm6tgcmx8fnGgYUlMRI7dWdvonLAIgQfbO/sWS4O/Tp0FHWpKQKej7TaLjQRiukPwu1XW4aisqvatehRV8XL0Lg5/Wsd/4yuyL30xrEWo3N8PA1Y36ygXpqjg0sEWJXn/ca5RYxq8eh4fmfrtNJKJ90mHIky7cpqW6CpAW2pE6HsBVZlYqwJzXJnbXYmQza8QpDXmoEcoZf1BAdICVsE0qaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 10:05:13 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:05:06 +0000
Message-ID: <909f51dc-aa74-4cdf-8799-13c7e777117f@intel.com>
Date: Wed, 29 Oct 2025 10:05:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v3] fib6: implement RCU rule reclamation
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20250610145341.38271-2-rjarry@redhat.com>
 <20251028173703.548656-3-rjarry@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251028173703.548656-3-rjarry@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::28) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 92525d48-e64e-4f8b-1f15-08de16d2a2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVF6ZkNOQkl0dGcrUWs3R01RbFo3T28wM0FzNXgzL054cGpwSFA0T2hsb1ZI?=
 =?utf-8?B?VUhiakszenVIdFl6aHlxV0p4b3dMTUpKeE9UZEVIWVdEcmpqNXhKQjlFVTJv?=
 =?utf-8?B?ZUpvZmV6MnFlbDloQlBVbWxIc1RISmFrczhGYS9YYkpuczFVNXZQeitGSUlr?=
 =?utf-8?B?ODZtSSswMUUxRGl0WThOK0YwWWM2ZzRkRVJJK1FnOTU3VmMrL0UyUFM0ODJt?=
 =?utf-8?B?a1pjUjRGR3M0aUFPbDJSVjk3SFVQRW1vZXRYY0RKZEU0Zyt5UTdDZEpwZVhy?=
 =?utf-8?B?SEVjYVZXNXJ2ZzNRUkZHWmZ1RGNQWkRDcFNxRzFYbmlhMERlVy9PMHR6Snpq?=
 =?utf-8?B?OS9HNitSWGJpaEpXMkJDSDB1WnRBOXhrdVFKdTZoTXh4ckRuUWVnbDg3QzlL?=
 =?utf-8?B?bnYvdEMvRjVrZ0FLUFd0cFBrSklXbVFyVW15U29EcjFwaEUwTUtwUTk2KzZx?=
 =?utf-8?B?L0dTUk5nM0dCWGtKa1dVekIwV1ZBelNWWE92OE1rMW5zU0Njc21NNlNtVXVD?=
 =?utf-8?B?VUtyK3pFZ2NPZGJxMHhSVXM2SFZ6b1Z3ekZ1VDZDNU4yZWZRSUpma0xhTjBy?=
 =?utf-8?B?UDNqK2pFNWN5OEx1VFVPZUhYVmFScXVtNHg2d0ozVXNicjFtSnRtTWR4RE9G?=
 =?utf-8?B?OFBFVlUwTEY4b1RqbHQxME9ZUHBzbUJpZ01vOEJRVEZHRXoyajJaSy9iOHBZ?=
 =?utf-8?B?ZVFvYVExNXo4UWVRRmM1NG1HQm5jdHVGYnFKRTI2UlJoRUFFM09GcFVxZ1pI?=
 =?utf-8?B?QjU0MmlaYkVFTUFUN2YwNVhKcFNGS2Z4cHc5UW93WG1WRU9uM3hEL2gwcy9p?=
 =?utf-8?B?WGhzRHZhR0hIalpoYmoxeWlVOFhmTThKOEhtamUxZmJwYTVQYS95NjQveCs4?=
 =?utf-8?B?S0xEQVhxNzZjL1Rod1pDekJJRWlCUGpLc1RpVWs0UDFVazQ2aVFaakJ5UTlZ?=
 =?utf-8?B?clZTRkxvWWtjRHhQR0RtUmdpWVRRRllFMDdGb0pjWVZ1Umw1ZHVubFdheWpI?=
 =?utf-8?B?UFdZdWQwSjgzWndrVHYwODhKSHhvUW1nMmR4K2oyb0tkZGVoTnp6cjRHYmJw?=
 =?utf-8?B?TnJqTVorekRjY3ljSVUwVFBnWVpPWXdEemlCT1BEZjhERnd0SXFrVmhoSGNu?=
 =?utf-8?B?M3hrUms4aUU5VTBpSGhycTlIdmkzb3B3OXZRRG5YYkdoaG9EWE9iMjVBcUNs?=
 =?utf-8?B?R1ZjdHNSMHFJdkJoNHlyb0FPZkZHYk5aQWxsdldPVW1VUHRsMXh3YTBwcjNB?=
 =?utf-8?B?OXB4QmtHeW1Ld1B0eHRGeEIyY3dsTm1MOEJRdlBTc1JJbWNzTVZZd2Q3aWxX?=
 =?utf-8?B?UjlTQTRKWGxhaktFMUswbVV5eHZidUYwQWtUVG96WkpmUXZaSlBWZk9HdVVL?=
 =?utf-8?B?cVE3MnFkT3dzc0tBMzRTN2RCdDJkMWJPcXRPbWE3dTEyMjBhcnl5UTRjeDFo?=
 =?utf-8?B?ZVJuV0RQVmV6TVhTMnRZa3hCcUpDNDlHU1ZIdEtGYTRiTE5yUExYQzhIT1Ux?=
 =?utf-8?B?eG1NTERUNEovY1hONVovU3FMMUw2QXdiR0lBaVVqLzFhTThqcXZXRHZMbnZL?=
 =?utf-8?B?L3BBMTQxNDUwN1oyTUhOV2NFVHBuRngyMXZtN3NiN3kydHFYVGRWcVVRUElO?=
 =?utf-8?B?OGNQRmxlWU03ckpzT3JUN1RNanBNMC96S080UTZYRC90aGhyUUx2RDJTMnFi?=
 =?utf-8?B?SjlIV2xBSWlCaW9McWV4eTZHYlF4ZG1GQnY3UURSTnNQR2s5MUE3Nnh5MEtm?=
 =?utf-8?B?N2o0TFF4R0c0MzNuZUdPb1U4SVFNSVJDQ0xpOSt2Z1hHWFE3KzJHTkhhY3Z5?=
 =?utf-8?B?bWE0NURjQnFHOVh3YmYyaGRHZFhjUFNQTkQvUFIvQXQ5dExoSFB5MjlXT0xu?=
 =?utf-8?B?YU10SHBpclhiSGtHMXZzNlo5QkVDbzdpZTR0UTVKRit1Y1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRlMkxMWDBHTWpYYUpnUnFIbEJ5UVBDcnZTNVhXSEZVVW40WTlIV1FiNGpW?=
 =?utf-8?B?RkN5T0lueFFzMlZGS1hlQ2JBajF2VEhXa3JhMDhwNmFaLzMyTlRFT1FMNWJD?=
 =?utf-8?B?Q29jRnB2dk82WEF4SXVpazhCL1hvZEdRZitjbVNVd3NVTGFoRHVMRHFpdVdn?=
 =?utf-8?B?ZXMzUzdlcVRScThhcjUyUUk3SmtvUkxVKzhQeUx3NXNOelc2OUgzOGd3WFBM?=
 =?utf-8?B?dit5cU00cVRRS0tOeFRvZ0pkQlZIUGVScFQrOTV4UnVZL2E2WkovMkpZNmt2?=
 =?utf-8?B?WjZYVnFDY3hhY0VySjZNeDRZckkxNlRpUFRuVDBiQ1UvL1RGT01ic1BnTE82?=
 =?utf-8?B?QUFNdE9oR3VVUW1SYVV3Q2EwUkk3WU1vTHc2NFhpS3NjYkpNb2Q3WnRPV1B2?=
 =?utf-8?B?cW5XMUYydnJqR1BQaGl2dDJWWEJVdFFwRzdlaUt3ZTZhZTZFc0VXblBXTHRJ?=
 =?utf-8?B?NkEwQkI1SDhmUERtRy9nR1FibS9jNXJjR2piSXBLV1lJcEladDhyak1uZXd5?=
 =?utf-8?B?UFlZeS9HT3pqZ1hwMWhYWGMrVlc1TGZ2QVhhclF4QmZFSU40VVlkK1Z3TXNx?=
 =?utf-8?B?YkJIZzRyQ3dOdDJTWHFldDVzcUlJakc5cnF2SVRCa2lzODhrbGZic0hUb1BN?=
 =?utf-8?B?RnJ5Z2ZvVHNlSk55QTF4TGkrSUpuaXFGQ0hIZTlVTXlrQ0lva21oWFF4SHo5?=
 =?utf-8?B?V1NzTFBmb003QWdEZ3Jaajl4SGQvMU9Cc2ZGek50eDIvM0Z0NmxsVHlrNUw0?=
 =?utf-8?B?MEpsWER2REh3ajgyV2NqQUI1Z1JpUndzSXRTZHo4eFFGME8vZnpCM0thaS8x?=
 =?utf-8?B?ekUzamxaU1cxRy85SVQzZW50V3dTcUlVQzhpWFdBQTZubDZaaUxaTjBZcTN5?=
 =?utf-8?B?Q0VIYklMMElPc2ZDZkx0Zm1yMmFEd3lPbktRaDR3TElFc3pmK3B5S3pOTUFZ?=
 =?utf-8?B?NFc0VzVMV1E2Rko3aVBxZFR6Z21QWFNPVk0zK1hCUFV4UmV4aS8xd0VuWU5Y?=
 =?utf-8?B?WCtyRHVRMXZNUyttb0czL2laWTE3ZFJpZm9iSWtCLzZsZG5sOUd2N2xucUkv?=
 =?utf-8?B?RWhIMnBGcFdOVlNnY3RWUW04QjRUQ3BiS3laaDc0YTBFQ2dlWEQ5Wm02OEI4?=
 =?utf-8?B?VGNtMWxwQXFaMnNjcVBSZFgyM25UMFNhZ0VBSjlNdUFVMTRpbkRKWDJSSmdY?=
 =?utf-8?B?R2Q2azE4TVlyR2ZzSGlwOWp2ODJYVlo3S3Y3Wm9FRUFoV2lYSlpXbklNYWlJ?=
 =?utf-8?B?WDVwelkyS0FCS1l0MkxFWFNBaFRnNDRNdnNqRW1aSWwrM1pBZDV6UnZBKzdX?=
 =?utf-8?B?L2JvVTcxNmR2YlFaOElKTk9RNGo1NS9MMk5DQ1VxWStHTXlrUmg1MGFGM1p1?=
 =?utf-8?B?VzZmT2Q1b25aNzZhZ3UwRGFURmVSZEIwQm9EcmRTNmtHelhKZlNjTDdFMjhs?=
 =?utf-8?B?djFsclFvRnlBbVhYNUpHdFRJdGVwTEQ4NStsdEtaUlZ5U0dyMXFhSFY3ZUFB?=
 =?utf-8?B?RkFNYXdlMTNzS1BsRERJMG1sQlVkTXdiK2pJMTFHR1VJTmZ0RENxOTUzUW9i?=
 =?utf-8?B?Q0o5aFNNbHd4KytTVlh1T0RydnpYUWhyU1dlalFFZWZDejBVMVBEb0xqRGZB?=
 =?utf-8?B?QkVpSXh6K2xISlBEVXlJa0F1bXoyYzFKQTA2OFBoKzBOUEEzYSt4Q291ZXdz?=
 =?utf-8?B?YTZacndLais1MkY0SUJTTmNHN2EwdEV6dUtlTkg3VHFuS2dsUTZWTThSSVd6?=
 =?utf-8?B?R2xqUFIwajNtcktENjZlS3BlNFVHb3ovTUU0MlV6UTdHREs3dmFueHlXYU5Y?=
 =?utf-8?B?bzhpWjF2eGRJOVVtbUxoU0JsVUFNVVY0Z3BPMER2ZC9mT2cwWnA1MzRyaUI0?=
 =?utf-8?B?SHJUdW5yTGFoQzlMRzFYZ3RoeGxtZHpHUjkyY2ZGdVIyUjgxRTRVc1dndG1O?=
 =?utf-8?B?STZqQ3NlY1lWSVpDVE5YRERmeGdZWWdkLzJuQjZRb2p4dmljNHJUb2s5RWFW?=
 =?utf-8?B?aWh0QjNGZ1ZKdkZMbE5tYm9rZExOZEpDRklUVFBXVjVWVUJJZDhwMWpidXhZ?=
 =?utf-8?B?bHFaM0E5TWtUVEJ6cS9sa29HMXo4QUJybTRzNHB0a08xc1gvWHhKZ2NmVDhw?=
 =?utf-8?B?dENiLzN3UnpYNHBnK3NiTmplZEhGZTJ2MSs1czVneEFuTC9abXM2NmI2YU1y?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92525d48-e64e-4f8b-1f15-08de16d2a2da
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:05:06.6393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rttX6tUH64LkAJn2mZ4SRj6HrhmrUYxOs909HALECxPRcOjhuRcNCJxc4ecwlktHH1beEotoHv1Euf/GqzTXbafsr3me+ZMiM7YviS2I6BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
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

On 10/28/2025 5:37 PM, Robin Jarry wrote:
> Currently, for the TRIE algorithm, the tbl8 group is freed even though
> the readers might be using the tbl8 group entries. The freed tbl8 group
> can be reallocated quickly. As a result, lookup may be performed
> incorrectly.
>
> Integrate RCU QSBR support in rte_fib6 objects to support safe tbl8
> group reclamation.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>
> Notes:
>      v3:
>      
>      - Added release notes.
>      - Added missing break.
>      - Updated RTE_EXPORT_EXPERIMENTAL_SYMBOL version tag to 25.11.
>      
>      v2:
>      
>      - Fixed typos in docstrings.
>      - Tests depend on: http://patches.dpdk.org/project/dpdk/list/?series=36356
>
>   app/test/test_fib6.c                   | 214 +++++++++++++++++++++++++
>   doc/guides/rel_notes/release_25_11.rst |   4 +
>   lib/fib/rte_fib6.c                     |  15 ++
>   lib/fib/rte_fib6.h                     |  52 ++++++
>   lib/fib/trie.c                         |  90 ++++++++++-
>   lib/fib/trie.h                         |   8 +
>   6 files changed, 376 insertions(+), 7 deletions(-)
>
-- 
Regards,
Vladimir

