Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D58CD6E79
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 840A0402D3;
	Fri,  5 Jun 2026 16:47:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D3A7F402BA
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780670856; x=1812206856;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2W/Ox6W0okOnmiyEe+VP4bTxi6OAJXq45lfsBW0r7/M=;
 b=OvPcoB60tOax1VuctPYindMlLTBN9criTDQVE1USxcNWBw1qW1vpmrXj
 oVCc8A2y8VqXWCdROGysf2tZbTp3wj23hz22s3Ou5lkpnBMw4Kac5DekQ
 A1rkUfWfm+Ug6dFqkEx1JpJUAdpSKClqyjJcLk7xa3Kj9RxaZajfS3v3l
 yRWwNUryfXLP9gudBC2u4Pwe5IjjvZiGKzjkgzYBNJaYBh9f88Dh+B8JX
 0flPfdKv3kusKHRxcVqjPCteGA8dMtuLtE6DVG1VpFLFXdp4Ax0opqoxY
 1LjvSbRI6KACFwDD+MTrQsqJfJzGsHPfCfQC85U/jlwCEC3RTf0qhXyMd g==;
X-CSE-ConnectionGUID: m/IBu1nOSTuM70gy7A3eNw==
X-CSE-MsgGUID: ZJotb1WXRimfHdHaGNoh3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81564883"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81564883"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:47:34 -0700
X-CSE-ConnectionGUID: 5A+RpSulTOiv5AIO8dUfYw==
X-CSE-MsgGUID: gdKx5Th3Sq24hKqZk1GG4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="238506369"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:47:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:47:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:47:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9gXQelgFTyRWHxr4zxWgMAdwR6j886lt/RHv7hIbz/xwcAcTZBGZaUhcjRox5qGzAe1IH1f5PpUxRMoeS2zVo3B4eNQzwqedfCL2n4a7WG/NUTyQS66jiROMzIKrCUOeOED5689+Ew3BH781m2VpRba/GfIOopGROqNQhs+rnktpqCJWkNzj/U5NnLPR34Jaj92l/ii3aed3KCjhXRRLZ1JhngmQZ97q1zDXVibsy/7cO2fjQKM6Na7ffMfYRUQzin4CxE1IS9zQA2ladJ5LYphg9InpQeiernujNfRbW68o4cNpD1N6kJRaeDEuU4MVuN1wG7o8eyMqGDFqHcQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUW2r9qyuWthP+FvSxwKfpKnfCw+xN9Px9hcqDwLog0=;
 b=y7XZ/LZKMwQ0fHzCPUqSaoC7yxAnIo/qMo3B4YXpCPnyhZxjPEvb69jbxQ2nGyHMN6BA/rv/+2B7ZxDZqAdLRJxTtiTxNjBbAGgl5IqDVt4swQEXKUg+JzwLILRixT+GtK+tAp0yj8oKcHBZ2qNu0QOldPsFPLwP1K646fi2oOyU85IMQ0sODqv9Uyr1rjZ18BBcZs94lZjbC7fQGkJR9UYeXN2trBKa0OCardNe05h3PFpXH3CHTO0ZhJclndBm2YwvHA6ofmtRPK/+/E4qpPTduvDHrf2Qd1WGhGbfl7bV8LutZFwNMnPglzT/cXymCBqee2+N+CwxyVgLyReqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DSWPR11MB9714.namprd11.prod.outlook.com (2603:10b6:8:354::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 14:47:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:47:25 +0000
Message-ID: <d3559637-f3e5-4cdb-9d67-ab6b3093a845@intel.com>
Date: Fri, 5 Jun 2026 16:47:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net/ice: fix L2TPv2 inner segment header setup
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-4-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-4-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DSWPR11MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b9b68a-b1d1-4491-5451-08dec3115ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x2315DmX60LwmsVfxsg4k/6IdWx4bB719F1ZF+FjVFnC3OiZEX2ofa4bsj3ysgO1fllsGAkEgd4x0ETnnbs2XCMoSv2iGx8RFapw6JFxsIEWOe0623cSJYmFxSGaql4hJhfHrMDbPTKhtX5gU5LJlFtwJtMOhsw8Lbd7klgxVBoO2KJ6LF5oSEnuHBblRpKqSBu4d0wglJzB+c94oQYZI9S2ZGE7l9jOwMhcScw2WlN2+x6o5azoi2t69xxUHGq6SsFK07kbM2VUsesVTqORDrfzcajpLY6ZhUtd49ynKzG8+tzQ0rdSTSicJtq5B5KiR1MP4kP4kHXuyenmqivUi+PJ3fiNLsG/3bvxd9vaMPZ371xqNX+6v1Gtu2NIpqEgisXq96MR2dVoveqGgQjABmif0kgHkhm0uqCbjQpTmTR3DB2KdGFuYBVQ7yVHWaRk0BsZQWQ5m89zAvSjIE9klJMK2M/Hu9F85cu/yWoW7/3igZakeNKe9zzpgqqSYBdNCzDLSb14v60SUS5rCTMtE05CrwWgsC+ZFd5nEZffIvlzB1asvyII0Ksl6rselYbOriMIu+sdrCZKsy0DpNVciLc623IrOizXrEd9dXgMYoD/5bA0JUWYrAlo1Ne/1ud63XeHBEU3LsTjmBaTYKBlvaIA/+tWgBuGKuGDjVQYjz8fXPZMv7Ny/9ZFM37UYuOt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXkrWWdYOHdVRXVDMlM5TFlnRHRWR295c0MvQXdOL1dVa1hVOFZGS2tYazVH?=
 =?utf-8?B?VDBKR01CUFdWd3NhU2VON0gxWHk0T1UzTjV6MTg3MnhWSVRYQ2RjTDUzeVJ3?=
 =?utf-8?B?NlF0ckY0VTlLb0FlaFF2R21PWkJxWUhzeVdJZDVkd2lETkZ3SnRlaTZ5ZVpi?=
 =?utf-8?B?bnFLNXIweHpYbnRIMkRWUjhOeS9RMEI0eEZjSW9hTlEyRVBiTXluTG51ZWRr?=
 =?utf-8?B?Zm5nakh3NUNDUlljZUQvdzk4QjlSMzZkMjFFNkhvaFJuZkhWV093TmhGNkZT?=
 =?utf-8?B?NzVhL1cyVGZtQjNvVGlkc3YyUEhvUDQ2Nk5rT1Zyd2FrS2RqRTIzTytzbUNT?=
 =?utf-8?B?UXlXMzlqelVVV0o1SDZlU0RBSHUxdmYyVkZUbUIvT3hPV1hDVm5XQmNGNlYy?=
 =?utf-8?B?dUozMk5FQTlZcGprREp4bHJIRTZ4NElMc3pHemY4Mm5aRXBUZlFKWnRobVlY?=
 =?utf-8?B?NWhYVDcxNkxkT21uYlJoVEMwL2VYYndOVGFMSTg1dVFzeGc0UW9pRnJ4Zml2?=
 =?utf-8?B?ZHFuclEyVDYveGZYNWtIR0xWUGpuU2U1ajBsR2NrRXVuczUrVVFQVlI5Z01Q?=
 =?utf-8?B?UmJ6aGlzRm9VSUxlYVlKaVVOMjZsdU9Za3h1R21vcXdBMFQ1d29zK3luRllS?=
 =?utf-8?B?bHYxVHVqWjViOTBtdUFlclR0VUluT0lHS0VRd3JzSnZIN2xWN3BDZDdadzFN?=
 =?utf-8?B?b0ZmbmRhUjBRc2NXOVoyWXQrRVBObkZBYzFYK0k5bk5weVFOYUllbGEzT1Ix?=
 =?utf-8?B?M2xKcmhkY1crejZMNnJmdzdFRzg1eXZ1bko3cWxDbDlGSU1xa1hhTHRYdEdT?=
 =?utf-8?B?UktidWV5MXhoQktCdUlFVy9wQWpXeGdRVityelczVVprZmFMLzJGUUhlaXlD?=
 =?utf-8?B?ZGhMYUY3VDBGWm5RUk43OGx0eGR2V0hocVdkQ2NpUXg0VVhjVjhQYUdCLzFI?=
 =?utf-8?B?SkpyeHR3K1BYS2Q2RFByRmhZY3hleHczZXdMeGxKZFFld3V3S3VZakN2MDAw?=
 =?utf-8?B?bWtmYkhWMkRiWU5JTzhSbm1RYUY3RUszR1haRUttY0RuUm81cDc1REVxZThY?=
 =?utf-8?B?OVBETFk4N1U3dnY2cmg1Rmd3NC9tS0kxakRIMElMaEk5Sy9mNjgrQmpZU09z?=
 =?utf-8?B?eWhCbWN6SkF4eWJjQzV5T21MT3hsMXd3ZWs5NG16cWdOVzFEdXVLbHFQTXBz?=
 =?utf-8?B?elcyM1FYU05MZ3RWTG1NaEc0alFaNzRmNW9nMjgwMjkrUWNzNTYwTVRXV2Jl?=
 =?utf-8?B?blc1VGtPQXAvUEsxa3FKa1ByVXUxdUEzUGs0NXNPalRUTk5BT2l6T0J1ZVVL?=
 =?utf-8?B?TmxwUE1UQ3VSQ3BwNGNCL3ROcnc4R3llNmRXVC8ydWwvOFM2amMzZ2g4Y01R?=
 =?utf-8?B?aTVnUHd4bERETlNwSVR1VkdtOVhyQ2U3ejhFQTdsVEowbUx6VTFnNVJ3MCs5?=
 =?utf-8?B?VTlUOW1MVTBNdjE3b0o3Rm5VdkxFTHBEQUR2enYxOGxvellmcHErTzZ1UHZ0?=
 =?utf-8?B?K2hScUplVFg3QjN1OGxpeUFoRU5yK28vaENYT3NCc05kN3pJdTl4c2d3Mk12?=
 =?utf-8?B?ZUpzSGgyRy9aMEFndWovZFNLcFlvbU9oN0lkQU1vYVBDYzkzWTh1emIvRGFa?=
 =?utf-8?B?Y3BTSHlpRjZtM2RQcmhNcjluTzJHVFFCSTBOSTN3U1ZWcHEwRnZFVTNQV0ZP?=
 =?utf-8?B?MVJZY1dZOThpSVoyMEdrbFV6U2FmdEF6UUNGTFFSZEVSbkNKY01KeEFnWFJo?=
 =?utf-8?B?VzIzdWZJeWQrampYcHBJUDlOVThpdDZPOWpFTk9mVnBaTmVLM3FHUjMxTGpF?=
 =?utf-8?B?QUZJblZLMTFWdVN5NGxlbzMzWDF2ZjgwREJiRWF2amhJdTM0Z0JVY1V6OUVM?=
 =?utf-8?B?VnRhbmtKMituRmpjZS96eUNlNjJTRGVNeW9WVDlSRnQ4MmFZdmE3N3g4RGxI?=
 =?utf-8?B?TzJJTWZaWkZSOWd5eFk3NHprL1VwcXJPVlhHWTE0TmlESVJkaU5Yek5uWGtQ?=
 =?utf-8?B?WURZcTBTS05WdUJHMWd4czQvYlQ4Zkx5SFM0cmRCRW5uYVJHRlBiZjFQcUZi?=
 =?utf-8?B?V1lOcVdhSDMzcHZxMVkwT2ZadnZZTm0yUS9GOCtjOHh5UVYxbXFBdmc5Y21S?=
 =?utf-8?B?MjFPbUpzaWMwRU5EUEF1TkRqYVhSaktrQVduN1FrVG5Ra1M5SkpNNnE1OUFG?=
 =?utf-8?B?dWVJeHNSeFVMVS9WeUNNSzhEMTlBL1hYQ1dUV2VnbjQzRm96QU5YY2ZjS3lw?=
 =?utf-8?B?d1R3T2tuc3AvY3lPL2daa2VzcktBMjBQYnMzbHB4cHBwbkduMTdYbkx0NVdF?=
 =?utf-8?B?ZUFLOFNpU0VtUUVzU1JzaW8ralpkOGw0MVBMZUxFdzJtTTVYZm1CVkI3TFdL?=
 =?utf-8?Q?CXO1XX7BYIgDEOvU=3D?=
X-Exchange-RoutingPolicyChecked: G+K4+RlLL/e3uf9qmFl+WAv79WQY1059JUfSb95gz02ALZgyzt97ecgNlvjpslzfiKq3KH5rmJBffwliTYIglNyQrwFv3HPUm222lyxiuV4XTvqvu17q8k6NhJQlmn30KnyYyXnopbV0ta1lIfWE/nsls3inJ16NntCuI4Mra3rc3Zf9h5m58/uKIP1gHjuCaNX3LFBXWojmrK6hkSLk999CauKT3IEl7TfRukp74sdRDt7Hj1w3aRiQtu6loQ59px666D4QGEbSufmCihCeP8DqpXs5tHWP0BN6iWVfEanc+WC7esyz1ixMuY/jKmqimdiBgtJa0PEQ1nrJBxNh6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b9b68a-b1d1-4491-5451-08dec3115ae9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:47:25.0539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFLCNQy7u53N0dnEccsyt0Tcqy8fEbWvgG94pQ9nMaIoQoyrz214+0a7hafJ9My1QZurpbkBholq+jck59afe0EWZO/AhAssDJdX/N1NZAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9714
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> ice_fdir_input_set_hdrs() sets identical headers on both outer and
> inner segments and groups all PPP variants into a single fall-through,
> so the HW cannot distinguish inner IPv4 from IPv6 or TCP from UDP.
> 
> Add a seg_idx parameter and expand each L2TPv2/PPP ptype into its own
> case with per-segment header selection.  Also ensure the inner segment
> headers are always programmed even when no inner fields are extracted,
> so ptype-only narrowing works correctly.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Nitpick: TCP cases can be reordered to slightly reduce code churn. 
Otherwise,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
