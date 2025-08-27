Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F0CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 14:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2735F40292;
	Wed, 27 Aug 2025 16:14:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 389994028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756304093; x=1787840093;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SpG/xapwQncG2bFVvcUj5/Ft3FmC3QMrzuLH7OC5u+U=;
 b=NmbfeqO6nMyhePyAfLT9uihYD6Zf1Q5yoDr9hz29uK9Lm5UvFYcA9AJY
 dNaCtmot/JMZ9mvMdWrxR8TIjaHkKWrT1w+fTYFL+qHTH+l3HeO+TFH+d
 tV2kd+E1CLKgS1i4OQSaArKik84ct063WkgloGy5uAyRyCxiezKyV/rLZ
 TCXwn11KQSvOJyH5N0CkVnnm0xXg6opwirnkDuufJwOqgLGNyJVFFfrk4
 lBhmVF0aF/Bxtm1riwXLseimgv1jmBwDsyJVCBjVCEPfwoDoUFClnKyFr
 41JBw5LraCRoffGL4kq9JqI/UMZ+VPly+8WT5qMVM035D6CUrRSwpXhSN w==;
X-CSE-ConnectionGUID: 0EWkuitLRxap6a1DtPtqdg==
X-CSE-MsgGUID: h0Ya63iYRB+oPkHMoXjX4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62200665"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62200665"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:14:52 -0700
X-CSE-ConnectionGUID: kt4mAW0RSmiRR3RUpCuAlg==
X-CSE-MsgGUID: GBdAeDKAREiMdcxYsJ30aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="175117124"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:14:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:14:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:14:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:14:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4aPhUwG6+Thg5CoUq/mDuw/IcM3RcUxGYLHXGGWmgpBhQFLTAflSm9k/U4m8gPnDuHjXpsrqR12SaxUMaA8XqwmX/Dn7M4SNXv+TWGARDSe95YExEjpoSTAGvex7ID5kAR7CwvMIQdTvcqIb6taaur3hpUnLeu3g5nKwXwpfmkkInjc8kztqpS7fZxzgCXtBPJQp7NQBVrCSOXPD8VLnxu9fe/5fBOcJA14ZmC71lhCHfyvt6uj78eV7Yp1uPFUXc7Lkrot2a2FmBc0c3Yk/0g/YGFYh8u09NsDfxcGndskXJ4t9owb3MJw1N8YrCRDJbTL/GSqSoxLP7khfWbMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjFFwr1xnJcn/w2LIIHQvag1/oXhgj+8xFgwa8YdZfI=;
 b=Dmccz7pvwJMXOcuYWBEaEp8ObbRsaA/p12XLoe1NHKhhexmSdeOvavCri52gtsL0Y4wNkKpDuXb0RA5CAzGzY8RPicbUAmzlF8cKKcQkM/5TJtowifa3K+PvTT0rI8Tt08HQT7674etTGN7rOpthbimINBc+NJK+x3DZ3GWurAD28DuPKQqnnEqEN4xnCGrPmxJfS107cm/FkOK3l9ccF6DiF7+L3Mhm6UvuTQIWlrfi8R6KQRC5P4JhIjkpyOk5DF65CmLS4dnUCWQGdXWPjofd94HaXHvo0ayLFtu+dq+64wRSEisnW6qn3HDBrpuamkTprimoLbZ1HtVMSdU2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:14:47 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:14:47 +0000
Message-ID: <987b1e02-7e46-4a30-96d7-0dc8ec905344@intel.com>
Date: Wed, 27 Aug 2025 16:14:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] net/ice: replace open coded version of
 LIST_FOREACH_SAFE
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250312231715.222149-10-stephen@networkplumber.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250312231715.222149-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea68f3d-b3a7-4927-f404-08dde574141e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGVNL3JpV2xBMWtaUWVwVkt4VXVVK2dkdzYzZmYwNU1yTnpSakNxRmhEc0Z3?=
 =?utf-8?B?eENwaWkzSDFHYnhoVndmVnEwK01aM1V4TjVIcVJEYWJGZU9pUUp0L1ZKcXp1?=
 =?utf-8?B?MG1oTVVIVXVnWGhDUkJ5aExJVEh6ZExxeFVsSHZKdDNlcEpOWjg5MTZuclBz?=
 =?utf-8?B?US93bnV0bkt5WjhRR2lxb09TY0d3eDFzclVlWGROZldrNWxucUhDVXJlaEFZ?=
 =?utf-8?B?Yng5KzFkd2FOQ3RVOHI2QnZjbThoeUZlTFdyZXQrYWNveU1wYTBaOVdab0o1?=
 =?utf-8?B?QzFNVGU2QjdqL1Jkd1c4YWdaN3VVLy8zNERmMVdMRHVZeFNUOGpjUXR0Wjli?=
 =?utf-8?B?MkJLbzBycGIyVm8vNURwSlhxOVRWcHFJT1JyRWtqYmlYQWtSWmhCZm5ZZW53?=
 =?utf-8?B?Z0czRzFFN3JNQ2FGZ09RdnNmRmNCV2NZS0k3OStEZzNZc1ZPVU9NRUxyVGEr?=
 =?utf-8?B?MXVSWUFhYm9vTFBsYnVxd2o3dmxxcmg4ZE5xUnBxMFlXUzV5RC9hN2pkc0FR?=
 =?utf-8?B?SkxUVHNlSnlUOGY5SktJZE1sTkNrSVkySWl2dzhRUDNSM2dtR0xlUURHbGRG?=
 =?utf-8?B?eDRZODJwMGpXb3FTNWE4bXFVVk16VlhBYy9UQURpTmdiMFpwYVZodXBIYzMz?=
 =?utf-8?B?KzhaRlo4eHFCVGlPbjAyRkZCY1pieEJLZkd5aWcrbUllNkc4MHp1TGU3MEN5?=
 =?utf-8?B?K04wN0xNeDI5MkI1VEtlRkN4dHNmRzgzbDZrblFuZTFaa2lrb3VPTkxZZDJu?=
 =?utf-8?B?aEJQcnV5SFJaMXdUSVk1elRCTU5ieDdlUC9lUnNmQStGSmZLYkU3QzB5SDlW?=
 =?utf-8?B?QlFlMnZTWE1iNlBlN0RLRnl1WTdER0tvSVNzTVhqUUNPeVVPSzJtR3NZSVE0?=
 =?utf-8?B?anlLMDJydDZaVStuQU1qZGtNZG1BVG9OVTZzekpNNGVDUHFkRWdZNnhwa2dx?=
 =?utf-8?B?OW5UT1UxQXlGbStzMzZLN0Y3U3kvNWZDSWFzNUgybnhGS3FUM3I2RDhEdlhk?=
 =?utf-8?B?dTluZVBQdktwWUtab0plVlJyNTdWL0tXRXhLZXdCWndKOHV6KzQ2NVNHVTFh?=
 =?utf-8?B?Vi9VUks2NXlGcjIvbDVVMzN2QjJqZzBtN0QwKzZsOW00NWFkaVl1YVcyRXNY?=
 =?utf-8?B?NmRJM1QxUklsVUd3YzRLUjNLcTh3a1hjeEFabUVRZHBqSXNsK1ZVQjFEZTNv?=
 =?utf-8?B?R1BpOEc3cXE0MVJWVmo1YVFJQ3FVTW1QQWp0RS9MREYrTXR6ZFNPWkxxblBM?=
 =?utf-8?B?S29oWEwzcHdSNWQ3Wkd1U3BNM2NtWWFnejYrUWZkdXZ1YlVNQU9DUkRGcEEz?=
 =?utf-8?B?TDVIeUd1ZjR5RGx3M0RjcXZBMEp6Vmp1bTgrY0hOWWREbWFMbVNkNjJ3TGpU?=
 =?utf-8?B?YjZvWmNNSUwycjFGNGxRRVdyc09IWXZ0My91Mld0am94MUc5TmxqTG1xekIx?=
 =?utf-8?B?S2duR29LZzF6WTM5WDM1SmVkeTl2TFVUZTdzdDJwMnh4a0FPWEtpT0lTa1U5?=
 =?utf-8?B?bXNSc2VOU0ExZVVzUDI5RjR4eW1LV0lzV0VjUlk4U1pJZVhjWGh6dGFPYm4z?=
 =?utf-8?B?VUQrTU9zMXU2dmUyNUpmZzQ4OU5OTFJxa3NaZVptZk9sT0piY0ZranZoTnMy?=
 =?utf-8?B?T2NYVk5za1lJUWp1YWVhZ1AwbnBNOWhzZm1OcWQ5ZWJLNWpzS3VxOXNtRjI0?=
 =?utf-8?B?NHZ6d0ZaamxxUFhGUXhDSmo4d0VGaFBwRmlpLzd4eElsZ3c5ZVlnMG9qRUJO?=
 =?utf-8?B?TmRucGVrNys1bUtSVmd5VkRYa1RnaVcwcXdaQ1BEbEdNc2VQZHhLNTlQRGZv?=
 =?utf-8?B?QjNScitEYStVWUlEYmI0VS9jbit5RU5iY1JTK2xpc1hNOE5RQ0t6cGUzNFk0?=
 =?utf-8?B?ZERGR3p5RStPeUxqcUhNaEVmQUhuUjhaUE9pSHgvdzJRVVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVk1eVF4ZlV6OGtIaWJyd3JPQlBITGYwK1dqVUV5bUNORDdvNFFZT1RNZEcv?=
 =?utf-8?B?YWVPYTVxckM5M2hMM2VTTXFlY25XcFlsczBjL3ZBT2x0NllhQ1k1S0djRmxs?=
 =?utf-8?B?cHU3RFc4em5WVHYyU3lnVzFhUytVVElwYXgrYnRkYXlKQ3ZVeWVOU1JjeG1Y?=
 =?utf-8?B?N08veEF6RnVyYjRxeGR6M2F1MWorU1UvZnI4MWlDL1B5S3JHaEpDNVJHOGRx?=
 =?utf-8?B?YlprNzJqRGtTZ29peVpwRW1DdTdaRlpnQWNaUVZTSWpzSDdhN3BkemdPeXBN?=
 =?utf-8?B?RzM2L0E2VmJCYzVYTHQ0NWhJWnRodzllVzFLcElmMzZEd2M4TlJXcnQ1OVpm?=
 =?utf-8?B?amFHRUdic0VwREpaY1Q1VUxSQmRYTGNhNGxmYUtOVk83YmxpcE1lakk2UUJ1?=
 =?utf-8?B?ZmkxWXdZZFlUZFNKMnB1TWxBWHJNWHh3dTlRL09Sa0xYVnZPTXFLN1hIMGdz?=
 =?utf-8?B?aXlhSkRZNVVuSW9IRVpTWmc0ZURYOGI4NndJMmlrK2x3YW1mNHNEZjQ0OTdD?=
 =?utf-8?B?QklkeEk4QkIyanpTMFI5SGJtREROSHcvbjJuSXIyM2piUkdlOThieUluMlhG?=
 =?utf-8?B?aFZTRlExSXk5MDVjWW1yNE1VVG9ZdXFvdjlkbmhFRVhQeGR1Qm1WZXIwWUQw?=
 =?utf-8?B?QVJkaFJNekc1Tm5kdXg5RkJBdFd3MVFRZUg1RXhsYmpwbUkvL1FhaHNDSkVM?=
 =?utf-8?B?cmtWWVhzK0JIUmRSbmc2VmM4cy9Bc3ZtYUhBYTRHUnZsNThiVUtwY3J5MkpG?=
 =?utf-8?B?SUsyTHJRUXkvRldoWGhGZGx3MXV6dnA2QzZGSFFFbDc1dFl0RTI0WjBUTDNM?=
 =?utf-8?B?V211QWpwbFhlOHlTRkYzSDdQNDdPZmJHcm9UNE03cUx5U3NKNDFzUXpKRGc3?=
 =?utf-8?B?VzJaNm1la0dQY0JPQnJTdzl0WjhZS0ZlblhMMUhQUW5kZmpic2tLeE9uUCtX?=
 =?utf-8?B?VzRiZStSTk9sZWhWWTNZNUVmQjNTNWhxSmZPOHFkdy9laGpPcUhRS09Vem9n?=
 =?utf-8?B?YWtYc1hRRjdVQ0sxeGI3cnNNa2xUT012Y0dsSVFKRGIybGs0WU9FTGVTdUlK?=
 =?utf-8?B?ZGlSQU1LNVFjaHcxd0RiU1BrcDhEOW1XVGJVMTZ4VXdxWHFMaVdVZlY1QWFZ?=
 =?utf-8?B?N05IVjBnOExoZ0ZnQ3ZuRmRzNWZjc0R6amR6Qkx0TW9Pdm5mNlNaQ1VKMjRM?=
 =?utf-8?B?RFJIVU9SSWttTzF4NUd4YWVGOVRCVmVvSmw3emVCOUlwR2g4TUQycG1KMjJh?=
 =?utf-8?B?MUVrcDRaRmVmTHp0RFdtb3lKYjliRGhwMkQ3dVZyRXV3bHEwa2hZM1ZsUGdG?=
 =?utf-8?B?Wk9OUlVEZnovVGVTUHVrWmVrdmpWWkg4Y3dQUnU5UkhVQzRySVdjMFROYlBO?=
 =?utf-8?B?QjRIZmJmNXFVOEYxNDExY3ByT1JQSXpvcjYxRktURlNHbklBbUpZb3VUN1Bz?=
 =?utf-8?B?bk1kbm9zZG5CZGFQUWhYdzcwRXQ4emVLYXh1ZjRvMlppc3M0V2lrNURJb1Q5?=
 =?utf-8?B?aitiajBMcGdybmxZVzR0SWl3UnM4UWRwck5JZ2xLNWhIME9hL3BkLys1NHpQ?=
 =?utf-8?B?SGpEbFVhYUNVQ3FMTk5xNXdJMmdYa2orOXk5bXA5clpwR2hQUEhzRWd6SkdB?=
 =?utf-8?B?SWhQS0RmaXVmL3BqdWdNY3NuK3lmZ1pUMEJnSWc3OTlxMkl5elE5ckFTbTl6?=
 =?utf-8?B?Z3gza1kxVUszN3VVYjdOUUdwUWdJTzYxalJNQmFvL2ZCUHhFekZDSDNvekEw?=
 =?utf-8?B?YjRvSTJ4Yld2ZFpvVnhKbGdPYWZVeGNHeHVVemE3Y3J5a3dacmFKVHhmWW5I?=
 =?utf-8?B?VTlZd3NsS1NGUng4akdOc0hZOGpOMFQ0dEtKaEpGQ3N0MHFNOTdsSFVVb1ZS?=
 =?utf-8?B?dmlqbTl3QzU4azFwNE9VUzJqTFJaNGRVV2FqSmpsKytYdEJ6STgvMmcxVjFM?=
 =?utf-8?B?YTlPbmRSSXlWM0lBc2g2TTdYbWNETXdiZ2tXamV6dDYxaEREOXBhSy9CRWF5?=
 =?utf-8?B?UmhFMHpPckpFOVVPZndudXVCN2dsSTQwZ3A5TjRqWlZkSGpXQU5xSTZCajdq?=
 =?utf-8?B?SHJaSUFFYStqaEpHSjZlb0F1K3NmS2hmQlFBL2RVa2pEaVByYmd4ekI1dmNu?=
 =?utf-8?B?eVk2ZDMzZm15ZURiVjVxaWsyV3NuRDgxN0N2TlNBYnEwZjkrUnhzMGxrUFNs?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea68f3d-b3a7-4927-f404-08dde574141e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:14:47.4114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67sPvvOzfJbeTKCCn32ai1MO9O3yES2yEIafky2dlVa5Rvi75Zlg3o3D2QBsRjBn8Ou4YxrDBdv/FtmmuZFbwMRFU8qVXDLUrUsmTUs8yvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
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

On 3/13/2025 12:15 AM, Stephen Hemminger wrote:
> Use macro instead.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
