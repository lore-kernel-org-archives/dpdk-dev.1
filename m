Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83979606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feagw+cX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 311A3402B6;
	Fri, 23 Oct 2026 11:48:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8F07540268;
 Fri, 23 Oct 2026 11:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792748915; x=1824284915;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/SF6J5EkUbwcOp69K8AHJj3IDJ2VryVx/nyV1L6oZsk=;
 b=feagw+cXyLiemyzQ1zonLaidbKN4zR+pqgNsdDfCte8PrNXH2bjCXmBO
 v409nKPIWR5LLuFliGT+QqtrzGK2pO90GlWX9IQ3YkLxCYi0ZCHZahHmZ
 NU5U82Q4bpeXKu4WNVSgyIa4+VE5m9VASFYpj7Zs8RQN60tu1FVbk2GoK
 KA9oQ583JCcG7aLVP3l3jI1+1PV+GnnY7kdiXvb8Iyh0VRbjeqfU0010P
 mStBoL+GgWiVu/RrkvS6vCgiTzCG0s1yoh6OKmPEMkR3nsFDzx2+MGDyi
 op6whSPLHNk7arovuX6ixTeBrUUsmeD+a1Q/frTC2dIwhGVM/d0tugUjQ g==;
X-CSE-ConnectionGUID: 5APoUkJIRUSqA+Z6c98Imw==
X-CSE-MsgGUID: DetqxjAzTDefS5OrnAOUJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1540403"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1540403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:48:33 -0700
X-CSE-ConnectionGUID: OwI4IUKBTCWtqvyBVeD0gQ==
X-CSE-MsgGUID: CucEad7iS0WIHqR84Q/wmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3714551"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:48:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 02:48:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 02:48:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 02:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySreQ+GAeTo+PBDs9OhilOSKL6G5xC3/7fKCtIeg47dZYUOcCfoneoM6ut3B4SI5AY8WhQ0+QVutvqGpzoxByXv8IxljACLGPb3WJO18uo73d64e8ALNOBvGZBwUXQmDw+5yYpUaQJbKNS5jS4CpuObDQ4HtHy/uj7Szhl4QgT2o1EuXJIST/qfUeHTcSOF/6fjeXJlGO0tAxoYI7wjshhyjSNxW69qmW2556JphPAznSyYA3j5oSR+lQXSxzLdd3QduBBGdp+iRpcUWNX9YwvaMXv5IAXmxlkj7easnndn9ovTWyi25c+fJeAK3ITWoDgJBeou7FGpWVEJ0U+/zqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxYCdTs1o81btzlORaYwS3BRiA8fJ6ZCmIURjZVU6oE=;
 b=ySd3k8QizfaNU/a1efrp8iGbgDa51LzpEoHxkeeoX7MgfOwJr9tcfb7ZFyuUAJ8Mh9vlm1POgApKwDO/y/Vi3UrHaBk02xPvl+NKRyRLdv1Lx8XmCumE8K1KsdljG63IAdpm8lVlTHehlBnKn5QBa5nelzl++j1cdFbfyGHd3ASOE6ZgDyVftz9fOetYgiA34hxugvJrLhmFPVAIM3qKPnpzTfjhRv3BOMEiNQ6ZLkUgDF/iO5PJvLWbb0546gghyqCLpPu8eA0bOuY1l19a8JsGKcEoiPvW8k5FSaGJe9/Tz4YFgHGJ3TtK4KuepltRTlo0ztj2CqEgg1uCmoQJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPFEC77118F8.namprd11.prod.outlook.com (2603:10b6:f:fc02::5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 09:48:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 09:48:25 +0000
Message-ID: <666ccda0-f613-4df1-b97a-ae470736f419@intel.com>
Date: Fri, 23 Oct 2026 11:48:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem: fix fbarray placement colliding with PCI BARs
To: Aarnav JP <ajp@marvell.com>, <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <rbhansali@marvell.com>, 
 <stable@dpdk.org>
References: <20261023060523.978899-1-ajp@marvell.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261023060523.978899-1-ajp@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0028.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::33) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPFEC77118F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d308ad3-e902-4d70-c52a-08df30eac825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261021123027099003|261022105027099003|261022075727099003|56012099006|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: qr1sKczoMJ1xEhAV7DzP0DF9EIC3OMMFrzu/Ye3uLKTQw7Qa6iW3XiaPKUOP8lbApgUDTUKx/JF9q04PzfusYk7dtAQc/SCi+QF53WF3fToP3hG9gu1lBVT3wVonWigiXKPJeFMnhjb64/Knln/slPQ9Lsjt+SmYvVESnjy1kMlqkD4rNuH03HdpPaRC8hnyOmPkUPsxSoTKVixF7ivj2QnVTUX2zmG5h0rJySdNDMtJi0OtvqEsbMhB147yCvRs7v0bWnoAJ1n4WHw6tSLSUGz4W1fVboEsQRRrDb40myJ6Jhpp+IM5rGN+yo6bj5O49uYVlVyj5zjVshlFu2nuFgeg4u2FcjhSv9/SSEdadDNyV9F9gvHdYQzkhYZuThRwNzYacSlUVzYoMJ9uGELSSOIFnUQrSdf1WIfqPwN0IAjB36DjAPEgjtSXBpZPFNH3vOCM4EpZGGT44nl3sKsNOREkAAqB+z91pyLZtMyDtJQfqEnNGZ4io5NWYOtUrcvMBN+jooh0qaTEE9vcziWmdiwf6ezCQf/dWVQgT9OE7NairLF+bvBYgHKbc4PB/cJh9weIDJi9r8+vmMZlO4lzz2rKzAjYRdLxxbEFWtmXf2Y3ZDIuqgSL3VzIZPhR4B0sYOewoKuxDkdY+WIEyrI25VaMiY5JEs0L7Ks680+NaFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261021123027099003)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFRb0FFMVNWUFU0N1FqYzJiOVJCK1VvQW5LeVZ1YUxXOE9PQ1BBNTBySjE4?=
 =?utf-8?B?cnhWcDB1REl5bEN0bnJNMUZmRkRHclVDemxOMkNWcUVHRjF4RVlVb1NZT2RR?=
 =?utf-8?B?ZXgxaDhsYjBjOTFEb1dycjNvQXR6eGY3UUdxcHoyTnhjYnVUM1BZOTd0SDl5?=
 =?utf-8?B?M2ltVkdPRml0eDdPQjRibEFSck8wS1liamRlYktSQnZNTHE0eVF6UUl3QVB1?=
 =?utf-8?B?S2oveU5ZMXViRmJ6Rzc0ZmIycWtGK3VkeWR0dGY0NWY0ZHlMamU2NWFGbkda?=
 =?utf-8?B?OGpwelFxM0NXaU56SWFlVXl3Z1ZZU0tzV3RyVFFBVEpNbHMxZlgzQ2w3NkFt?=
 =?utf-8?B?dHJ0VW12SWcwRWdQeUxJUXpJWHdrc0dRc0Y1MFFZbm03dkdmVHVoMnMyNjFP?=
 =?utf-8?B?TW1mNjViTnhyVTk2ZEovRHJVWXFqd1FnSU1oSUprem5qc0RHYzJTaTd1SkVt?=
 =?utf-8?B?eWYxa1k1QzVhVEdES2RqcmdaMkFnb0dpa0k3QXNhYVFxbGhnc1UrMkxZcFVt?=
 =?utf-8?B?TjBJOVZSYVYxaU9hL0J2UXFyK1MyZ0k4eG1GREJ1SW56WmhCaVJEazk0ei90?=
 =?utf-8?B?Ri9qMHpvb0dNUU50b3pLT1k5Q2NTOGMxc3BDU3NleGp1aGhYcGc3VWxwb2pM?=
 =?utf-8?B?aHBFQUpranQ4c05mQ1VaZ1FwZy8xT3JwNDc0SGZOcTJvRWc2ZElBakNjT1pt?=
 =?utf-8?B?LzQzbWluZTZKcUU1SWV4L1VDWmhSanJoR2hHTy90SUZSeXNVbGdoeWorVTM1?=
 =?utf-8?B?cnRPWXBYZGJXWmRzZXZXVTI2VDd5R0JXdS9UYlo5bDdPVk5VLy9uTHU4TXlj?=
 =?utf-8?B?cEszenBLUTFEQXZxSjVGOU1VMGxIOXNBekJSYmxZanlldkNDNU5TellxVlNT?=
 =?utf-8?B?cFFQczZ3bWdoVUh4WFVIZ3dva3B6YW1QMVl6Vi9XTGVxMEtQVW9iT0EyWWhW?=
 =?utf-8?B?bTZIU2FWdDVFME9UZ0JWek41TlUrVDQyelEySDlMRUVVajdpZllZUS9xNWU4?=
 =?utf-8?B?akt0dGlxRlhRaGhZdzZpM1piLy9hYjJ4NWllNnFIUy9PZkw3bG02ZTlVWDVC?=
 =?utf-8?B?cWdsT3FnSVVSSVVCK091QjZiYm90ek5vNWdWYmxSVGNIbWY3NnZpTEUzUnlv?=
 =?utf-8?B?UHo5YVdWOHFtYkxXTmw0K09OZC9hRmcwa1lTMWJmTW0wVkJCSXIzcGRNUWpX?=
 =?utf-8?B?M0pGeVJpWEx4cWo1R0JtNjFhdTJ2SkZKQ0ZYWTBsVFpTYzZZUWZiTWRqdmdw?=
 =?utf-8?B?TFl3UUpjWlZpL044cXJIM2JWWlhVdnFLS01LK1VKaklMZCtteWpjdW1iRWdw?=
 =?utf-8?B?TFYyMDRkRXQ4SFEwQWRFWVVJU2d2N05ML0lCRTBadnROa0l1U0xLNHdMR0Jn?=
 =?utf-8?B?MUFOOVVCa3hNRlZJNFQ5QUJkQWt1TnJJb3g5emJ2Q2lOYWltVHdQbHlQWmt4?=
 =?utf-8?B?dXN3ZVhQODRseTYrN1hZQnBxVGh5YWlaZ0hoQmoyREVhYXluWU9mU3QvcGFQ?=
 =?utf-8?B?SFdRbE44UGlIZXEvYk40eW1iT05FQk9OS3NEWjEvQytOdnpKMmJKRDQ5bSsx?=
 =?utf-8?B?ZGJ4bUhkT2ZueWxKT3cyakdYeE9yejJjY3JFeTRtQ0VrN1JkZWhKM3gzeHpO?=
 =?utf-8?B?YnBydFl1RU5idkxEYzQ1VHVZOHVwbVc2WkNJRnF4Mzd1ck1tdHBiajBNbWlI?=
 =?utf-8?B?ME5XenFMUGs5bHZwL0ZiL3labXdDN2FqMFNsL0NJOGt1NEVxa3lHWW0xa1cr?=
 =?utf-8?B?WnFNMm5ycmlYQWFpWi9zVWJVWCtTeGcrcENrMzhQcStuL1ZGeFoxOUh4Vmdy?=
 =?utf-8?B?WWdtQTZzMGhJTVpXbk1tTTRkUW5ERVV6SHk0Tm5YNW53QjBvZFRIZWY4UUc4?=
 =?utf-8?B?OUJCVFMxZmFkU28rYmc5elZBQmFnYkU2V2xHbTNqaWRqTEV5VWFHUjNCY2lO?=
 =?utf-8?B?bjBxSm91ME51NHlBQ3kyRkowTWZVZGc1ekpYajU4ZUVNSTVScFRHOGx1Rk1l?=
 =?utf-8?B?ZVhiKzBKSEQ2R2RWRUxyTW5QRWFtUFBaUVhUQ2hCY3pnelBuc3hub2d0MmxG?=
 =?utf-8?B?ZnhWNnJ4eU9oZ3lpWlhnOHBHQzNiV2lzblNLMEtScXVDdDBmQ1h6L3Q1elV6?=
 =?utf-8?B?ck9Ta1Zjam04V0NqM3Q2aVoxVWxMMnppSGkwTWNac0MwZGt2L3JBL05WRzI2?=
 =?utf-8?B?NHdFYnM3c3lGbkp6YnB4dXBaOUJId2dmV3dKV1NVbnpjTUFoblNrUXpZUC90?=
 =?utf-8?B?TXYwcmtDV1lIK2hBS0psUUNOZkNqdzVXbUl2Wmp6NzFqd1hhbXZxaVpGelZP?=
 =?utf-8?B?LzVPV1ZaWWd2NnAwb01mQi90Wm9qeCtqcjA1VmtBYVBrR2F4cHNuQm5UaVBS?=
 =?utf-8?Q?feD9S7qBjwh5ERA0=3D?=
X-Exchange-RoutingPolicyChecked: bA7lujOz9X8gU8LG3waLe5GvDROPQVdu/u6wBIVPgDA6g62rrXb6GGD/ESACaUAM2TQueG9T2LP6AqTfXI9p91m/AFtcd3DFSVam82kTSB3CvHQqSbY+U4ZE0K2GVFTlvGjbT3FCG78RMfhR/+muLfrzDZWGm9kd2VMZvuFK54nQuSglv7y2Rrg28TPBnDVDxfhSSwTTlaEcXI4ryHWzDM/GyllO17bdiW0Vat3SexX0EqIVhz+m4e2LQrr5MzDNVkpziW1loq6Dfey0/QXK8GwIrPz5TIpJOtXAtXt5CP9iKc14mohiJSts31qq/z6rexkea3ikKwIwHrnFSDGXKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d308ad3-e902-4d70-c52a-08df30eac825
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:48:25.1680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW6ecyErQBxs53/70rvzWWWskotIjaBI2YDzjIEyKVHzp3LE6IpJSn17zTNVG6ldF4HX1nd4emoN/VXLjFvCwIK7Ci9FZp39J8EDUB87HKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEC77118F8
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 8:05 AM, Aarnav JP wrote:
> Since the VA space of all memseg lists is reserved in one go, it is
> reserved before the memseg lists are created. The fbarray of each list
> is allocated from the same VA allocator, so the first fbarray now ends
> up right after the end of the memseg lists.
> 
> On Linux, the PCI bus maps device BARs in the primary process starting
> at the end of the memseg lists (pci_find_max_end_va()), using it as an
> address hint. This address is now taken by the fbarray, so the hint is
> not honored and the kernel places the first BAR elsewhere in the mmap
> area, among the shared libraries and thread stacks.
> 
> With VFIO, secondary processes map BARs at the addresses chosen by the
> primary process, using MAP_FIXED, which replaces any existing mapping.
> As the mmap area layout is randomized for each process (ASLR), the BAR
> can overlap the secondary process' own libraries or stacks, which are
> then replaced. This intermittently crashes secondary processes during
> EAL init, for example dpdk-proc-info. On arm64 with 64K pages, this
> was seen in about one in ten secondary process starts.
> 
> Create the memseg lists before reserving the VA space, so that, as
> before that change, nothing is mapped right after the memseg lists and
> the BARs can be placed there again. The VA space is still reserved in
> one go.
> 
> Also destroy the memseg lists created so far if a later step fails,
> since their fbarrays now exist before the VA space is reserved.
> 
> Fixes: 3368bc8600e8 ("mem: allocate all VA space in one go")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Aarnav JP <ajp@marvell.com>
> ---
>   lib/eal/common/eal_common_dynmem.c | 46 +++++++++++++++++++++---------
>   1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
> index 868d274dc0..800f1c63c6 100644
> --- a/lib/eal/common/eal_common_dynmem.c
> +++ b/lib/eal/common/eal_common_dynmem.c
> @@ -29,7 +29,7 @@ eal_dynmem_memseg_lists_init(void)
>   		size_t mem_sz;
>   		size_t va_offset;
>   	} memtypes[RTE_MAX_MEMSEG_LISTS] = {0};
> -	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
> +	int i, hpi_idx, msl_idx, n_msl = 0, ret = -1; /* fail unless told to succeed */
>   	struct rte_memseg_list *msl;
>   	size_t mem_va_len, mem_va_page_sz;
>   	unsigned int n_memtypes, cur_type;
> @@ -132,6 +132,31 @@ eal_dynmem_memseg_lists_init(void)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Create the segment lists (and their fbarrays) before reserving the
> +	 * VA space, so that nothing is mapped right after the VA space. PCI
> +	 * BAR mapping uses the end of the VA space as its address hint.
> +	 */
> +	msl_idx = 0;
> +	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
> +		struct memtype *type = &memtypes[cur_type];
> +
> +		/* skip page sizes with zero memory limit */
> +		if (type->n_segs == 0)
> +			continue;
> +
> +		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u socket_id:%i hugepage_sz:%" PRIu64,
> +			type->n_segs, type->socket_id, type->page_sz);
> +
> +		msl = &mcfg->memsegs[msl_idx];
> +
> +		if (eal_memseg_list_init(msl, type->page_sz, type->n_segs,
> +				type->socket_id, msl_idx, true))
> +			goto out;
> +		msl_idx++;
> +		n_msl = msl_idx;
> +	}
> +
>   	mem_va_addr = eal_get_virtual_area(NULL, &mem_va_len,
>   			mem_va_page_sz, 0, 0);
>   	if (mem_va_addr == NULL) {
> @@ -139,28 +164,17 @@ eal_dynmem_memseg_lists_init(void)
>   		goto out;
>   	}
>   
> -	/* go through all mem types and create segment lists */
> +	/* go through all mem types and assign VA space to segment lists */
>   	msl_idx = 0;
>   	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
>   		struct memtype *type = &memtypes[cur_type];
> -		uint64_t pagesz;
> -		int socket_id;
>   
>   		/* skip page sizes with zero memory limit */
>   		if (type->n_segs == 0)
>   			continue;
>   
> -		pagesz = type->page_sz;
> -		socket_id = type->socket_id;
> -
> -		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u socket_id:%i hugepage_sz:%" PRIu64,
> -			type->n_segs, socket_id, pagesz);
> -
>   		msl = &mcfg->memsegs[msl_idx];
>   
> -		if (eal_memseg_list_init(msl, pagesz, type->n_segs, socket_id, msl_idx, true))
> -			goto out;
> -
>   		if (eal_memseg_list_assign(msl,
>   				RTE_PTR_ADD(mem_va_addr, type->va_offset))) {
>   			EAL_LOG(ERR, "Cannot assign VA space for memseg list");
> @@ -172,6 +186,12 @@ eal_dynmem_memseg_lists_init(void)
>   	ret = 0;
>   out:
>   	if (ret != 0) {
> +		/* destroy the segment lists created so far */
> +		for (i = 0; i < n_msl; i++) {
> +			msl = &mcfg->memsegs[i];
> +			rte_fbarray_destroy(&msl->memseg_arr);
> +			memset(msl, 0, sizeof(*msl));

One nit: I'd prefer a struct assignment (`*msl = (struct ...){0}`) 
rather than a memset. AI will probably complain about unchecked destroy 
return value, but I think that if destroy fails in this manner we've got 
bigger problems and there's nothing we can do here.

With the above change,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

> +		}
>   		if (mem_va_addr != NULL)
>   			eal_mem_free(mem_va_addr, mem_va_len);
>   	} else {


-- 
Thanks,
Anatoly
