Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF688CD6E79
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 13:04:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF3524060B;
	Fri,  5 Jun 2026 15:04:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id AB1FF4026A;
 Fri,  5 Jun 2026 15:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780664682; x=1812200682;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2Myy5tRQ1ZqCzw4kGjnUTzpZ7v9CfM0U1Zc00eZeOEY=;
 b=Wdtf86Up+9Kjq39y9oucSjUMm26UK5Sz1TkrvCuUqMSf6+cVFcsK5KGc
 1NJKzCVN1V08fv5EDsDOkoFaKsRXgNIyo4Yr7epTp0DUIQhZzzdzeLgcS
 4Dj2bUf5Fu1aV1NiM3O0KaT9NMOQzrt3ymLvNHS5szM0hl0ordlhAfCAE
 MDEFoeE/vOwncES7VyOYSva8ahwK6St2G1cmxS11HyDSU4l85CD2oYwE9
 tDzOqJ+wRgW+hbGUqkrAFFoIgyQ3BniSJx6lEjNtXV1HfWJuWSW6PS0ln
 LDLBei7/zpge9ZbU7ZGHtTS/KkCk6ON9AxokSVOBvTG6pqKlj2zVueaLE A==;
X-CSE-ConnectionGUID: QfTNBNE9Ta2pKL6E/3OMxg==
X-CSE-MsgGUID: JH3vmecOQzWMxe/YUPrQiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80634413"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="80634413"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:04:41 -0700
X-CSE-ConnectionGUID: rvOEzLFJQbGTSqE1t9lU0g==
X-CSE-MsgGUID: Sn7R0zYJS9mND9NWyU6/qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="268767525"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:04:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:04:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 06:04:40 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:04:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgYMJEPogUYWDPD1L6rW9Og+lmBt1MH4LmmKcly9iCaciLW2lBkjDCLvNOf0KIBRD6ahAcd3Qj/HUDzpwSn3McTBp4aU+3JG2RaasMHV3W7rXYhZs+pPA8yDUo9/YOUIxpzF8qg2ON2ene0x4WeP0aAuq/wWmI7ahrR4HJen1a9yrA14wm+GNhVY7QkX45SwgN4g7b5ri60MxL03G3HR8kJnMHUthI0YZdbfU8wzWFMf4MopMpXO20L4xpeSoLj5lNJQHfupFLQR9xqEL9RWwafYQUkg4nwjtCfL0SRxZVpBbXIVTT3lsHOex0mRNqfixIyny/sD4nUTfi9R2PsxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6nlSouC9LvE/bN8x/aJeQXy2e5/2FltdNOE5KE45Cc=;
 b=hBLKQC/M5NqQ+Y18SbagjraSyahp2SutbMtk9Z9VgoPctRCopZ9M4qK8JpTKT0tBxH9n2aKSkLrvxDiJUB0jWyI+Ycvg53PCuIBPUFmaQGu5uFNVRhDPoHEDUuBRx5HoNB7Mgnm6x6NqwJQ0KMMMF5knfOpR/vN+p4ac2D23ZzIkVLigsZKaUkd/nyEec/Z/0L7TyCNayl8sg+i3DNfFJh/GDBsJEs/kfSa6XbcGKRS0o4pqBAil28S5BoN4Iqutk3s3e2pMcQIMt5DxZq6kvPpYtK1IQdmuhmZoKRQQx//TMvCPW2i8rsmuPYaHs0BYyCRawuePMiBUj2oBZTOwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:04:36 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:04:36 +0000
Message-ID: <e25f547a-f1b2-4c40-932d-94bd82a518a8@intel.com>
Date: Fri, 5 Jun 2026 14:04:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] fib6: fix tbl8 reservation drift
To: Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, <stable@dpdk.org>
References: <cover.1778146229.git.maxime@leroys.fr>
 <20260522145855.1748406-1-maxime@leroys.fr>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260522145855.1748406-1-maxime@leroys.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0176.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::31) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ0PR11MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe3e661-69bf-4c23-b813-08dec302fec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QK7Q+IkElT9b35fbbPts46aPkUViPMgz3rhk4roItBuXFlGAYvA0lDYn1dWdRC70RAIcHj8ySdtlLj8rP9b5cKDNlJvkevPHYueSKXGjEutbWckimnbA5g3E5HxeK/ZMxotNvnfXQR3MLnbmWYy7dEWjEG2PbNSm6KcMQB29M8Et9oXr8HXq7G6UnwCFfr2AvoipcA7AahLxlB3NXPfSddjIcuX1QJmS9gl3VoTapUSAb3yKJZc6tzfxnGfxmk/sdIQw/IjuEE1OZlh4ueJKJ5vi9+x/bEytPLUpV1F/0myUDfnjqMJQbPjcXMI04sYSB6fAIPLS513LyvsB+g3BIdE2o52PhAHHjwFAtPlyvhNW6KS38jUGZpiueht3OahqFwSrg04EHZno3jLJObaYSdyRlvL9bsiyjRkR+x6XKBATEtbvQwyXdk1rOLndhHrQoGsTepT4BwC0w/Lrac/Ir39hF9DoPovy8nGHp18cPiKZPAbO2a+LpA7yOHzNUvoiJ9AUbd67o6RqXjchV8AwCsR7DfN86W2Fv9fSWHJvI/BfvAVuVQDvb7YiFhQ7Vyzx6tmeLvemF08z5OsG9tvRLx/5+R3ENxwqHPvYc031CsSWF90bII3g8ZSqj+LBcPqoI5qP6vAcaWTOLkXIAlYVOBEfYZUaiqRCkWtRWM4nChzuc8CStleEiUifjE/RN45TO9ml2U8C06v816jJyOG7Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5qTFEvMmRQRHRSOG5yZXJHQTVyZk5XS1NHZHhKaTZMbjdsSFl2cGwzMDZh?=
 =?utf-8?B?WWVBUmdmZWpIcjIyekQ5Yk1BT1ZuQ0hRTlFiM1JtNno3T3ZGanRvM1pZeEhj?=
 =?utf-8?B?ZUhrWnVuR2w4bFIzYlF4T0N4UUxWblpZbmpETWZqNHNSVUZJUlFPRkU4YUNW?=
 =?utf-8?B?cDhuVmYwU3psR01HaUMwcVNSMm4vWWdXaHJqcDVzSzc1NDJucGUzZ2ZnT2w1?=
 =?utf-8?B?SWRQMTVKMTBaSWYyckc3NkhrWkxvL0syRVdwRU9VR3ZmOHZnR3dHRGFESkN3?=
 =?utf-8?B?Z0hKSGxwWlJ5OFRybktsa21SV2Z6UTE4by9kSnB3WnNIYUJaMmRpUEw4VVM0?=
 =?utf-8?B?K1NMVDdSOHB2WXB3aXY5ck1rdzN6U2ppU05XZnJIRjBOZTlZRUIzUlVjN3NB?=
 =?utf-8?B?RnRCQ2lQZXY1eTIzVEs3V0FIc1RTc2VzM08yTGg3TVpyalVCNGV0L0taS3Jj?=
 =?utf-8?B?ZnBsbnZNTzdQK0hmc0dxMjRlTnc5Z0hUU1hibThiZ3NuY1E1TDJIWGxWSkNS?=
 =?utf-8?B?UVBDRFdwbHg1MWc2YmtjU3N4Qm5pVlMzNXoxWE0wNm9zUTBoU09aWW1tVFBp?=
 =?utf-8?B?cDdDeUV3N1Z6Z245ZUFmWWZCVzNEcWpwQU5kVVNiTW1YQy9DZWt0QkNnSWp1?=
 =?utf-8?B?WUlZM0MxVHZ3bnFHOXlOZmN1UmlkRC9yYlVmZEU3MW1nWW5tdEZVNmEzVUd1?=
 =?utf-8?B?VUJhVldsWnBCYW81ZjJQdW9Ub2NnNnZIWEF6cFRyL0RtWlFtVzVPaTlLallL?=
 =?utf-8?B?ZCs1Skl6ekJwZ3hvcStHVUpCeWR6VFBqRytTWG1QZktEdFl4RGdlUjZBb1gr?=
 =?utf-8?B?ZCtBQitTMGxpdWhLZ1d4NWFkYXpHNW9Vd3RVSlEwaVVKZVYrd1h1SGNUV0Zv?=
 =?utf-8?B?bnVNZmVJWi8rOVJLVW8reUZURW92MkVkVE1SalZic0JiZGpyVm5HU2R2WTNv?=
 =?utf-8?B?ZGJ2NzQyTVlKTkhpSWdwUm5xKzhBSk43aUxrUDB5Qk1iS1JXS2cwQ0Z2cGV0?=
 =?utf-8?B?NHNlUjlOUDlvK1dLUGdSY2kyQkFUUDZEcHJFL3MyYXdUR0xlZ1VvQVhHQmlj?=
 =?utf-8?B?bmVjY1RLREliQ0V5bGxQUjI0aEcxNS9yRUFoNzY4cWx3dnRFKzNyOW43aWxX?=
 =?utf-8?B?S25FdUwxS0Yvc3lwQk1sUDBPelhETkt0TWx5bWJWckR3cWYxMi8zOXd6TTFs?=
 =?utf-8?B?YmpBZ3lJNVc3S1lOZXlMYTVYY2Z6ZGFnV3JHTTk3bFZaYXEzMHpIZ0o3UkZU?=
 =?utf-8?B?ZkFWS28rckU0Y1RYUTVValVkTHQ5bm5rSis1QUVubGFVcmxxck1USHZ4aDQ1?=
 =?utf-8?B?SGpEcHEyKzdjV2daVVh4blhxcEdCTyt0eDJjeUFRbmh5QS9jTlZWM2dDdm05?=
 =?utf-8?B?OFphcklqeW54MERLQnJXME04R21Fa21YQW96ZW1BNEMxWVIreGVZYXVmUy91?=
 =?utf-8?B?RDBmM2wwU0NwNHJNOC9WRm1HN0JPaElNOGhXTHVSaUdFWncvR1E1R1AxclVT?=
 =?utf-8?B?SG9EeDREVUtIVjVtZzZod29IMjR4MTZJelExTE4zeHZseXNKWE03dnppU0NP?=
 =?utf-8?B?cEdpSnpuOHhoeEUxbVhnK0NwZ3dESWg5dXUxdEI2cXNEalJWY3dDN1pTZGVW?=
 =?utf-8?B?cWJYZ3hia0lNY1FIOFQ5VmxaQ0JnMU5qQkUxNUR5bUlhOHdGV2RrSU9rRWtU?=
 =?utf-8?B?dnluUUlaV1pGYjNyclBXR2dCQ2QxWkpFb2hNVktaei91Sm8zWjdaYjAyVUFx?=
 =?utf-8?B?S1dwYlRtMGtYSlJEckFiSksrR1RZdVVOUDJEOGdVMEowTFF2VDRzZEtBUm5r?=
 =?utf-8?B?MlRsTDVtdkV3MmE3aVdLUDFDWmxLV1d0M0Zhb0p6T3o1QjVuZUF1Vks1dlhH?=
 =?utf-8?B?NTlmbXdqTG5abStqVkZ3MWNYK1BGWFFwTkRLRFpMRmFISlZEWjEreERxTUZX?=
 =?utf-8?B?WUg3RjRFL09DQzRIdHlnQlhzdkYreHlhRHV5ajVZTXg1NGwyWSsyL1BHZ3Bw?=
 =?utf-8?B?Qmc3Rmkza0JPTks0VlFqMGFWc2E3UStQNE9RdDRFWDBOL3RBeHBmSGI4dWFu?=
 =?utf-8?B?TWFBZkRUQW5UTGdISW1TK0ZvMFVVOGtRT3hlUkhWWm12bWxrL2Nrem9nZ3Ft?=
 =?utf-8?B?Wm5rWDZKc3E4VzlZN2JnbzFIVkhjcURZeGhTYnVSdTdueEtrWVFYWkltZzNO?=
 =?utf-8?B?S3F2OTAzRmNZMWdLb29GNkRpbE5TMnZPa3FGMHF5dSs3STk2VnpvSGxlbS85?=
 =?utf-8?B?TTFtYWFIaFhtMVViRGpIa2g2YUhNRzh3aGNnZUg1bjNDdFdkQVVDWVZwUmFJ?=
 =?utf-8?B?aDRkVVFXbUpYR1lMVjZDb2pKUXQ1TDBvQkdvZUg1T2JLZnBNaHJqNVdmTmhW?=
 =?utf-8?Q?X5gwZdghGyZQw7po=3D?=
X-Exchange-RoutingPolicyChecked: BNz40FVK31y2Gf2qAqm/kl8MWjzQaoxwZRqL8nZhfqo2M+O6sT4K17IG/HwPe2WFCISKz2Rl63v+r03qpqDAgt/pkrWfCWeRv2c4EA++1I16umkhTRL6//dOqPMRstKPAgdIMP8KZYCHsCXv7zgxDmy8jlAAGpj24JS1BcsfAaADnk7twGPTb0vZcMSRt6AUK5hJNriLr/F9lAhxow6FYNwbVPXTCBCDhr8vY5J0w2WXxHZ37XCeAUrHcGXiyH6dv/XK0iw1fYLNZhRp7RkTeUN/spyqv/X/sjP0bt6/CIA3+Tj0MWkxFEBPtAIU2PBryjeZwCFoj49KJPYQzL4XeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe3e661-69bf-4c23-b813-08dec302fec6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:04:36.6533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3Y+qMirAuTmHTtbOLVRpFi8j09rmEcKbR5AkIEo5uHkjeFf6SqC36ZykvMdXrh81tT1f0Sxq2vGhcyxbwF5bAo9R/WJLyEIkXjisMBu/qE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
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

Hi Maxime,

Thanks for the patches.

For patches 2 and 3 introducing unit tests
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

For patch 1, 4 and 5,
I think both implementations are over-complicated.
I suggest more optimal implementation for the count_empty_levels() (from 
the patch 1/5):
here is a draft based on your 1/5:
https://patches.dpdk.org/project/dpdk/patch/20260605130317.896413-1-vladimir.medvedkin@intel.com/

This implementation can be backported. The function logically belongs to 
trie.c, since it reflects its specifics, and not to the RIB library as 
it's more generic.
You may take this patch and integrate it into v2 replacing your 1/5.

On 5/22/2026 3:58 PM, Maxime Leroy wrote:
> This v1 supersedes the earlier RFC. The RFC dropped rsvd_tbl8s and
> used tbl8_pool_pos in the pre-check, which loses the worst-case
> envelope: a compressed /48 under a /28 allocates zero tbl8s but must
> reserve the boundaries the /48 would need if the /28 is later
> removed (DEL forces mid-flight decompression in modify_dp() with no
> rollback).
>
> This v1 keeps rsvd_tbl8s and computes it the way dir24_8 already
> does for IPv4. dir24_8 counts /24 supernets that contain at least
> one /25..32 prefix: that count is invariant under unrelated RIB
> changes, so the counter cannot drift. trie6 has the same need at
> 13 levels instead of 1 (byte boundaries 24, 32, ..., 120), so v1
> counts, for each L in that set, the /L supernets containing at
> least one prefix with depth > L. ADD/DEL pairs are symmetric by
> construction.
>
> Patch 1 is the minimal self-contained fix (Fixes: + Cc: stable).
> Patches 2-3 add the reproducer and extended regression tests.
> Patches 4-5 are an optimization (not for stable): valid_descendants
> in rte_rib6 + single-descent helper, so trie_modify() walks once
> instead of up to 13 times per ADD/DEL.
>
> Validated on a live BGP router (grout + FRR, 127 IPv6 prefixes):
> RSVD_TBL8 returned to its pre-cycle value after a zebra-kill /
> reconverge cycle.
>
> Maxime Leroy (5):
>    fib6: fix tbl8 reservation drift in trie
>    test/fib6: add reproducer for tbl8 reservation drift
>    test/fib6: extended drift test cases
>    rib: track valid descendant count per node
>    fib6: speed up tbl8 reservation accounting
>
>   app/test/test_fib6.c    | 335 ++++++++++++++++++++++++++++++++++++++++
>   app/test/test_rib6.c    |  92 +++++++++++
>   lib/fib/trie.c          |  47 +-----
>   lib/rib/rib6_internal.h |  37 +++++
>   lib/rib/rte_rib6.c      |  80 ++++++++++
>   5 files changed, 552 insertions(+), 39 deletions(-)
>   create mode 100644 lib/rib/rib6_internal.h
>
> ---
> v1:
> * Keep rsvd_tbl8s; recompute it via topology-stable empty-supernet
>    count (dir24_8 pattern at 13 levels) instead of RIB-derived
>    depth_diff.
> * Drop RFC patch 3/3 (no longer needed).
> * Add extended regression tests.
> * Add patches 4-5: RIB valid_descendants + single-descent helper
>    (optional perf optimization; not for stable).
> * Production-validated on a live BGP router.
>
> --
> 2.43.0

-- 
Regards,
Vladimir

