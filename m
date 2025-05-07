Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C8C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 14:07:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 915644025D;
	Wed,  7 May 2025 16:07:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A816A4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 16:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746626874; x=1778162874;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=pZ0T0bqiipraiw8F69is8jb8RiyzzrdGHNUvz1kLimA=;
 b=MAmEZhzv8k8t+FgYXQnRQgNF838lv+PA5voqSIJBqxYV+XDjh2rHik/o
 Zqt2Kbiokm5NiE7FTy8NDy+dU7K6tBae/57yp5p1nHNHISuvIrpXWMVJ6
 xIFj16pG6ddKbmya26ZOFHwGCuxVphYfebt9Hd9yRZ6QBXCG0aYqbLyVJ
 raIkWgOlED6pOg/yOmmwAHKTSu7laWiiwth0+HGP9F1VdTJMZXek6u5v0
 ZKW2+xzf+leDb1K+AENowwp9vBnPmpiQyrWzSRL2tZLdUC3ph0IQvW2Vv
 axcP3ZO8pZvH1XGbCunyIQYCW9b5e7RCB/5p+4mUCjSkOMWjrobVBj/rf A==;
X-CSE-ConnectionGUID: 6QFtFd+2RYGCJy5JFpJ1pA==
X-CSE-MsgGUID: 8DL2o/WEQ32xF/lYyFeRfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48511629"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="48511629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 07:07:52 -0700
X-CSE-ConnectionGUID: KY/AOOQzQ4CjYweLesn00w==
X-CSE-MsgGUID: eK8aa0QzQDaTjf143/C5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="136485820"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 07:07:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 07:07:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 07:07:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 07:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n19Qhw2O/S1WHto7iHNiaefz3jbXo8lx9l5bQEo54gAGf53d6599IpVH6SI5WcrpraKeH21CWLXsP1vlPpJpSB2romDwtSYdDbrb+a3abuiTBlNXvjEKBzFHjKL/5qkVIjLlvu3vAQTU19IBPBIeFDWAuy8zEL/cyBNHhd7hUDWtgOrMS22zHIOmMD5STmxaFZssH3LLrXTPqC+rADb6388r7IJanRwgdCV9swxhkoCbOfrKQymXticmY+My0soFelos/I8SUrFpetcncxqbWjVjZBMinBDu2h11CS98l13xJe6Dn/U0ZYFq5J20527NwbOVZNOPwZG2nR7R9V9d5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcSyzOi7bX4WvP98gt6p/3+WyNDwqCfAdHdsysPfcEo=;
 b=fVKWDOaD/+/HXhdGQYZTXBFXrSYnmyJjZRP6zRVehZ5LrSIWgSi2fhdn+NWwTo5FEHHxlZzglkHxbcFUpQamUJ3ZIKI6cKhJswx4/h/nxKQes0Tt6JopNm5LQDfc0BU4f8imLLasuEW1AON+kp26esyUyX9ixejPAlCIi+CxL8KS1GGfbEtLgP+PEN4z5dg5nBMdZ35FUElMvAlrVkxvTn8RtlhVnRO8MGfGh+zuG1MwMvFOIdpHd/JirTv0Ym8xjl98ry6jugujAmQ725vTIjCXHt6ZBpK6dboLaXVcYqt/SMNs+m7OkKc1/708yW1qcA2sniKVOcLMPHBtk+i86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Wed, 7 May 2025 14:07:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Wed, 7 May 2025
 14:07:04 +0000
Message-ID: <eaab8e82-9fd4-4040-bcdb-abfbdd40f984@intel.com>
Date: Wed, 7 May 2025 16:06:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cmdline: add floating point support
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
 <73248ba4775b4b95b117890851b8257e@huawei.com>
 <142c9203-11ee-4310-adfc-7657fc8e224d@intel.com>
 <0beab7dd888e4a0cb100a7ef92c90a35@huawei.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <0beab7dd888e4a0cb100a7ef92c90a35@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0241.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: e591ab43-a920-44c4-087d-08dd8d7071de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUd0ejE4OERheFRuSXByTjlSRk9ONGZGd1Q5SmtrcXZFT2ljd0xac1RxQnZW?=
 =?utf-8?B?MzhxeU9QUEthZDdiRU5PUVJvMU16SmFMdUlGWmZmSU1YOEU4bWJpZFR2NE1F?=
 =?utf-8?B?aW9kNG0ycENBaHlLLzBIcUhUTndWV1VkZUU1MGxOTWpxY1BROHhlRHJ1K2R0?=
 =?utf-8?B?V3RselZwVnNGWDF6U2ltT1ZFOVZDazE4WGMxN0E1bURzR3lJM002NDJ5MFhG?=
 =?utf-8?B?SE03WktGdS85a1Rmb3R1WDh2aWhmWDc4L3lBNmVLTXphRTRiM2JLZTN2MlFZ?=
 =?utf-8?B?NVQ3OTZQNGEwR0NLWkJVMC9Cc29hVXhBTXZYZkt0ZXY2Z0hJZG5tQ2x0eGZQ?=
 =?utf-8?B?U29GQTVwRDdiUHE3cDhFWndsaHRXUFdzWTlWc0VLQkQ1djFXZ05MbGU4K2lK?=
 =?utf-8?B?OWFRUjFJdjdoRUZGKzI0RlZzMXRZOVNUa0JaaGNENHlvTEs2cm1OSlFoUTE0?=
 =?utf-8?B?OXo1clFwWFBzd1pwN2lVTkNqQUNIcThla3dCYUdWUlhNVURwR0hsbFF0MmhR?=
 =?utf-8?B?amdlMVRwdEJVQll0TUdxeTFubGoxaFl2dUM2VWFtOFhXM0NSRlcyRGM4aGhz?=
 =?utf-8?B?NGxoTng0VDljV0Iya0w1bld1MllPMzRqUDVRb3BoSW1SZC84M1JxZlVJNGZS?=
 =?utf-8?B?Mk5FNHFSWDBhY1ZYSEpNUUNhMWVQaWl3T3FtWjhRVExRVDJQNEJyL01EK0Q3?=
 =?utf-8?B?ZkxMTklSNlJ2UVBTZnZmcmQ3czJzbmVKT1NQVUEzWHJYU2VvaWc5bXA3YlVY?=
 =?utf-8?B?OGZwcVlmMjlVb1NtSnlrNEZhcTJUQ1lBY3dRVjUxMDFrZFNYTUNUbkJIdXQ1?=
 =?utf-8?B?QUozWlFWNFExdHZBVkNZVmFwazRGbkZpK1Jtdld5QkVuWHlLaDE1eTRzQWNQ?=
 =?utf-8?B?Q2dDL3ExamJ1S0tpbVdJV0docFZicDBaK3QyT3YzOHZsTGExQVl4YU9xbThi?=
 =?utf-8?B?UTZoWlpRMFVqWmR0L1FWdVpWTXhBMFIzemNYM2ZNMFpoZUdkUGpSa0xtNVdO?=
 =?utf-8?B?aDUwNU1SQXJEcFZxK1AvK203QXhhd25oTW5Yak9va2FzNVhIZEJGZ01uMFA1?=
 =?utf-8?B?V09qQ2tFcUFFYktGdkFlY3FleFVxVmY4UndrWkplZDN5MG5VMWVrZUsyMUpy?=
 =?utf-8?B?SUhyd1ROR2FnK1l2TEkzZWFPUmVVT2loV21kak5qU1pYZEEySVdpdC9pL2tl?=
 =?utf-8?B?YTVoZ1ByS0gyVXgwSHN4SGFoL1BDcmt1Z0VFMUVYLzA0ZUx0cXliTVR0dVhl?=
 =?utf-8?B?OGl0b0RvSTBhak16U3pXelF1emtBYmpRWnQ1RE9ac1dsK3ZPV2c1TVZPZmtv?=
 =?utf-8?B?clBWYXdnazFJbnY4K0h5NFlpWnBXWHk1R3BSOVk0eFQ5L0dZa3ZGUm0wa20v?=
 =?utf-8?B?U1FTbEVRVm1mVVNlL2FTQnBDejYvQlROQ0d0WXFNOHUyMGxEM1FEYU12dWdS?=
 =?utf-8?B?ZWZrZDJ0dkpXdElVQ014VU5hTmVRWFduNExUcyt0S1lCS2lCZWhMNWxEdUZC?=
 =?utf-8?B?L0RGTjVDUVMrajlaWEZUbVNNV1hqNm53SFVJS0xrTEFUWi8yWDY0RlhDQWhM?=
 =?utf-8?B?TGZtekJRdS9qa2lKdDZYV0pjODB1NWZlcTJMQ09wTmFvY1QvZVk5ajAwM0dj?=
 =?utf-8?B?dmcvczdCQVRGaTR5M1VLckxCNHZiWHdNc0k3aXprMFRnYjhLZmk3cEt0eUVI?=
 =?utf-8?B?ZkNXZGtLUWRhZHdaTUNjUE5lR3JQQ3E2NWhqaS9PS2hFUmFQaVJvOWwrZ3FV?=
 =?utf-8?B?cHp5UkcycnBQME4rN0FBN29qMC9LQTlNSTRVS2Y1NUEvRzlsRkdBeDlmQXFn?=
 =?utf-8?B?eHFYSnFnWnovS0JaRVByR1RtVGNTT1JDWjNoVkh0bytHTXNwbGpQeC9TSStx?=
 =?utf-8?B?djBxVmFTcXBXNjY5ZHJPSklleGNVZi9uTDV2dnN0dUcyTnU5N3RYMytMNTBR?=
 =?utf-8?Q?MDpE9SVnF2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNScEZrWkNncGJlS296UUZZR29EaXRWcUxRT1pSc2ZJVXlJTFV2Qm9MU1dV?=
 =?utf-8?B?MTY5cUJXRUl0VDJ4N3U3d2xjR0l5UkhKT2wvV2piT2RzdDZhOHlEQmRBbnht?=
 =?utf-8?B?cnh2RHpWazJUZ0FqblczNHJMQlhMUFlhNG5DZTZXaUJxZHkrSm9GVHlVQURR?=
 =?utf-8?B?Vm9QQ0c0MGNvMGs5eGl0VEMybjh6UXlBdjcyQW5HSTA4a0R1SXRqNWZrQXR1?=
 =?utf-8?B?a09vNVc0Zkx2VDJrY21BNE1EdEk3ZEdiVVhrSVBRcmxWUi9UTWdSYXhYcncy?=
 =?utf-8?B?NWU1MGVLb2VJNmV3aXVRSGNFMFo3Z2RVazhmOVZRSFMyYlhQUTZNRW5malhj?=
 =?utf-8?B?TmFaS0pqVHBhUkdveUsvWHhma1NrRmQxcDlsQldNeHdqS25sMlNHaTBqSWwv?=
 =?utf-8?B?ek9ybVRnRHc5UW9XT2U1WHc1cG9KOUxyZGY2R2ZFSXlsNEtWeC9uSGRtMk10?=
 =?utf-8?B?elRUYTJoMHZYVTVRdWRhN2V6R2l1UEUyeC9UWU1NVCsxUVZKVlFQODlGT3ZW?=
 =?utf-8?B?R3lScUlrY3ZENE5LbXY0a25MSFdJZ1o5dzZYVG9MK2FnSWVXWTA1bHFaZWlk?=
 =?utf-8?B?dVp6ZGlPQ3FFeE92cGlJZGdWZmlsQjJEQWp1RFlrYXJCc3gzdVBrcHRKYnk5?=
 =?utf-8?B?Qy9pVVI3WTltMFpwUEM3UTE1V2lhMzlYb0FSNklwS1QvalpQbzl2UmN0dFcx?=
 =?utf-8?B?RFdIVGdBREJ1WnRlS1lNMGpNZ0ZGTnlFVTRIVUU4eWVHRmUydmU1RmphZ2xj?=
 =?utf-8?B?RXNNSEtYWkpkVjVwVDdKYlFDYTlHWnppNFYxZEpFTm9Fb2pUL0x0QnpCUE9O?=
 =?utf-8?B?Q21xT2xWelFCVU41RGhhcUc4YW1uR1AzNHM5THl4S2dXaUNPTE9MeloyNlU2?=
 =?utf-8?B?VTZaVkF6SDBJZkpNTFRLeGx3Rlp6N1RXcklyOS84NFNLOU5IbEgvTnJ1QVI3?=
 =?utf-8?B?RHM1SU9CQjB3K2ZQNXlYOSsyYmYzNm1jd2FQMys0WjJiTjVlOE1xYVd3d1hT?=
 =?utf-8?B?Um5jMGdvOEF3UDVJSS9TYzlnNi9nOWdRZngyV3hkeStQdWtJa1RWMXByZ3Bz?=
 =?utf-8?B?b2djek9ZSFZUS2V3OGxZc2o5dVNNejE3cld6bGsrOUxtbnR3NkdMcXpGenhw?=
 =?utf-8?B?emNOMjgyWlYrMDhNNWpwSEpzdnMzTFIwSThibEwwdDJyUlllZG1ab1pSbG4x?=
 =?utf-8?B?TmNEZGt2eXRPeVZoZ2hOZkVzejdkY2p4eGpsRmNDUmc1NTVjUjRraVJ6QXlj?=
 =?utf-8?B?elRQMFA2ZGpuamVXWWpQUFE2bzY4dzhtREpOYVBBaWxkcU5rVWZrcW5FNXRs?=
 =?utf-8?B?bU05VkVmKzArL0kyOUZLL0Y2dUZjVVZGZC9wdERHMjZvNzdCWDRWL3JONWxx?=
 =?utf-8?B?YVZFQXNLMm9sc0VVYTNZNHN3eXFXQi9BTHVGVlBZUXVEVXpabDNDaFRORlVp?=
 =?utf-8?B?djJqSTFrbkZsZEMvdDJ1UE9uSkFEenozUmdTbmtqQ1ZabDNYdjlNQ2pmNUFW?=
 =?utf-8?B?NENsRVVxaU45YVNFUHE3SUhYNW15ck5QVXJuZ0NLWjNqVVNvSkxVK0pXMWU4?=
 =?utf-8?B?N2ZuM0taUDVTTlBacmRVYnhEcGg5ZEVpZGVOUngzcHFldkJGcTBGY1ZuaW45?=
 =?utf-8?B?dU0xcWdLN0s3a2N1TEtpeERSbzZzL09MMFJ6N1JmLzJ3RUR5eUJFamdpVjkx?=
 =?utf-8?B?TGVRZ1ExTTdPdW50K0NaQmJ6TlhhQnNsM0tYVDVOVkFiSHJVK2tsVGNPNzI2?=
 =?utf-8?B?R0w4d0cySmhwOWcrVVJUdFIrd3JvUjZjaG5CY1puOTNmL0NmUjRJeVNkZU84?=
 =?utf-8?B?dTFHTlNNemJCNDd1ZDVsNFRodVFGOUZWWG9XT1R5VzVHN1RJZnI0amx1UXBr?=
 =?utf-8?B?cXh1SlVzMWZCc2Vxa09FZDF2SUMxOGxQUHlKQzAwYzJWY09qbDJxSUFPT1Nw?=
 =?utf-8?B?OTl4Y1FDM0FlL2VPbk8rYXh0bE8vUWNQcWRmd0R0bWpqb3M3WXpPQURNY3c4?=
 =?utf-8?B?WjBEblduT0gwbXF2V3k3Y1daVHhQRVIxb2hFUzZad2QxekVGbitBVUxtb09z?=
 =?utf-8?B?eiswUWRkcmx5NjF4c3ZnRlpheFlqMHFjcWxYM0JUcUR3TEVHeC93RGdQckM5?=
 =?utf-8?B?dGEreHg1eDJMcFp2WjZSV2pnUUw1T3B5bWVNbjJiQWdWTlVoWU01NENiUkdG?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e591ab43-a920-44c4-087d-08dd8d7071de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:07:04.7174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7e1YsUahJeNXVQENL5yUe4twmEx+4FiwkLJ0/tzEyU2cqpk9DguEUjS1X2F/sfNgum+1wWkAw4M0seoxravHviYO1yMMACAKTO1FxkvKlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7738
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

On 5/7/2025 2:24 PM, Konstantin Ananyev wrote:
> 
> 
>> -----Original Message-----
>> From: Burakov, Anatoly <anatoly.burakov@intel.com>
>> Sent: Wednesday, May 7, 2025 12:07 PM
>> To: Konstantin Ananyev <konstantin.ananyev@huawei.com>; dev@dpdk.org
>> Subject: Re: [PATCH v4 1/2] cmdline: add floating point support
>>
>> On 5/7/2025 12:35 PM, Konstantin Ananyev wrote:
>>>
>>>
>>>> Add support for parsing floating point numbers in cmdline library, as well
>>>> as unit tests for the new functionality. The parser supports single and
>>>> double precision floats, and will understand decimal fractions as well as
>>>> scientific notation.
>>>
>>> There are standard functions for that: strtod/strtof - can't we simply use them?
>>
>> I can ask the same question of the entire existence of this part of the
>> library: there are strtoull-type functions that should be available to
>> all targets,
> 
> Probably due to historical reasons - a while ago DPDK was able to run on bare-metal (not any more).
> 
>> so if we're going to use them for floating point parsing,
>> we might as well remove the number parsing part of the library entirely.
> 
> Sounds like a good cleanup for me.
> +1 for it.
> 
> 
>> Either way is fine by me.
>>
>> --
>> Thanks,
>> Anatoly
> 

There's a small number of differences between what DPDK can do and what 
strtoull/strtod can do. For example strtoull doesn't support binary 
while we do. Strtoull has a concept of "negative hex numbers" while we 
consider them to be invalid. Still, seems to work now so I'll submit a 
v5 with the rework.

-- 
Thanks,
Anatoly
