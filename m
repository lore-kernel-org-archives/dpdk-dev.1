Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85351CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:41:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D3D6402A8;
	Tue, 14 Oct 2025 10:41:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B6A3F40288;
 Tue, 14 Oct 2025 10:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431307; x=1791967307;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y7/fPw6TKlEUxcTFZwmJ/clRHF89sp0icjRPXi5HWjg=;
 b=MwzJOCkNNUUoA0r4ds3LxsUwv/Um+RWYlig2Q/V098OnqPipokEzjzzX
 dqY0uJM4f2KtwWKuGapacGqtqo7wY0tb/Tqx5c96hz1cA2j9LXFkd2pNR
 evCWDzJW7Zv7tjeA+nsqjo15cYR0woPPygN+4nR6GXuGN3VWbuK8Hlc9s
 6quYmdPfeAaVpSgzQUoBZwG48xSAdWNx5siJ5PBu3OZ5Hdrc5VXnmSZFz
 0v1bnA6BpWWe61ZC9+Cb3DDpbiFF2lhLHuDEjNSa9LyaWE5lpYjCF13cw
 Rv5nIyXewXynn1wflZMZ+ZoRHvzOW58TLxg3s9/iwLUNz3+FtiSVQaG9p Q==;
X-CSE-ConnectionGUID: mWpQznt6TbKIeYjHxOqrBw==
X-CSE-MsgGUID: PO3vAv2cQoCN2B9yQ4IvFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="50146228"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="50146228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:41:46 -0700
X-CSE-ConnectionGUID: KA9KleVLTs+GerRfP5PFyw==
X-CSE-MsgGUID: GJDpLzr7R7Cdjt6YmjHltw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:41:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 01:41:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 01:41:45 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 01:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHv2uHQXq078wJSRrqUM5JV+iD0O8WBccZ6vEOkJ9ZBvO9uGHd+y6a5VD+A64ThZOUPlVeWg1urcAAO/O2EgiyJTyyPtV0hEllVGT6B8mvh8Q00r+W03H+qBXH1cqm8AbtPSMUKGHeLs2BUQOf/UveDgyqfjdAc4CepSOgDCREzzrQVjFCEHHyMbX+4YCk/zs3Kaf/ofPiMFI7nd5wAKQcGLpbrB8mX6itZ9KPwCzyqm9DfOtUPtd06bgZxkOtGRwo+1b+O29w3QEC1Mxzvo1ocCkl4eWjknMs/JS/gpJtH2r38dJQ7GDaz5y3906H2cIKTQyatH1KQVQylTT4IcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0MAmGPuY7X+rqZpquwNAU0WNhCbHTHCZ8yptfm8mTQ=;
 b=UkUUl6/+NsZWIznMVqqZpYlj/PZsInK7xcFfgIGFvd7Yc34jZ9GMK6aizTwXTPFksPKhb92Lhd4zN0H5fM0PNZni/j6+GFytICyVTXtuqPHi5wvLKmki0SBJdOPCERTwtzHjP4d2DB1sKyOTiGxsvUIre+6vu/y+nBiWWlZQbmlHkeYZr5EsalNpg7pNVXRZjESUtsZ7cptk/1Q7emA+BBz12bdgKIqASP368ChhOAQ+kv5RBJG8E7OnFCqhYm4xLqJTmg+tNTJEVM8P7AvoNjSIbUH6T8qwS2RYpoHZspy72+N0725l8CzDCTQxajxjU+YavJIjg4VRZ9Qd8xpiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by SJ5PPFC362E0A4E.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::854) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 08:41:43 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 08:41:43 +0000
Message-ID: <8ff1b2df-c3bd-45d4-981c-c711409c173d@intel.com>
Date: Tue, 14 Oct 2025 10:41:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: revert count drop-all filter in Rx stats
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
CC: <stable@dpdk.org>
References: <20251014054324.3908737-1-shaiq.wani@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251014054324.3908737-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0265.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::15) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|SJ5PPFC362E0A4E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4572b860-2082-4c58-5606-08de0afd80cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTN0ZE9Zc0lPd2x4SlFRbU13T1VwTjRIMi9xU0JHa0EzVUxPRkY3bWdvOFFB?=
 =?utf-8?B?RE5mdEpZYnNTUHFpWmREellUOTRKRjJqSkdBRjJESTJtUEtnRlUvakg1Mk5r?=
 =?utf-8?B?bSsyRXMxUkNxU0hubzRvU1poeVh1UEEza0o1bGU1UlA2Y05acWZwOWw1dnJ4?=
 =?utf-8?B?RjJ1WTQzU1NqbU9UdlpFaE5BWWNLMWRnNGp4VUJiWG1rMC9pZHBrVDZaWkhP?=
 =?utf-8?B?U1ZEdUVuYVBVd2QxT1l4SFhJNU4zdlZDWHlRUSt0MkxPNnA0clV1MXBtaGIv?=
 =?utf-8?B?dzJ0N2JJaUNXQWhLRWZpTCtSTnl4VXdBTm8zRmhLdE1wcTkrbFFWRFhTY3ZP?=
 =?utf-8?B?ZndzRDFJZXBraGxtY0lkWll6RjJDTFMvSzF6dTNXeUovUjRIMmh0cUNTUExN?=
 =?utf-8?B?NUVLdTFKNFhaOXVBUWhBZnRhbWY1NWtLVFA0eGVRR1QvOWRUSU1vTGFhenVU?=
 =?utf-8?B?RS9IdlBUVUl1WnoyTVFKZXAzN1FrRzZLK0ZSOUFOazVzTEp3SnJLcVg1Rjl1?=
 =?utf-8?B?N1I3WmZWaU5DV3pyY01ldWxORVBxd1dtNnMxMUdMakM3ZlVJYWpib3p5VmJ4?=
 =?utf-8?B?WUVJZ3FvYzdPRkN2OE1nSHVvZ2xIV2o1M2JaNHdIV1Jzb1haRTRjZ0FzdUlW?=
 =?utf-8?B?YTdVdFpTS29mRFRxYi9xUVFkclp4Y1NYY1RuV2JTSnBjdUpneEU1RXdJT21I?=
 =?utf-8?B?VTMxT1lTRkZpL3lVVU1TRUdSTXNObU04UU1QQVFOY0xKYWVaRm5BOWU1YzBm?=
 =?utf-8?B?elZzZHJkWHVtR0pwN1RsMU9MN3RKRk15Y2F4WGZJM1FLaFF2em1kU1lCb0po?=
 =?utf-8?B?MXN1SVk3dk8zSXFYME1iQVlQRGp6YkszaktCVHhFemZIbEtzSkdGU0JrckJ1?=
 =?utf-8?B?aHBtc0pQQU9pVEhIeUwxUm9Rc0p3dE5hOTZtdlVrWkJxRVUzb00yeWNoWVI5?=
 =?utf-8?B?bDQwYVhQejNJRG5FRzJDc1VoNWpiTllxTW1oSlJ1dGtLVGRGRnIwUWU5ZzMx?=
 =?utf-8?B?MkpPb240L25ZM2JYZW9FckpuUE5yMml1NkJGMVNpSzJUbVpyK1hvS0M1MHk5?=
 =?utf-8?B?WDhwM21wU0gvWE53a3dSaWhoVVlpRDQ2SVhGUzUxb2pCMEtSRDRSbXFPTDVW?=
 =?utf-8?B?eHd1MTJlM2cyZlVYK2lYZW1pQkd6TW1CQ3ZYYTVrVStpMWxRd0FHVE5hVGE2?=
 =?utf-8?B?UGJ3TEQyMDhYSHdPZDdtV00xMkZBc2NUeXRNckk5Q1Iva3dlRUtueWIvUTZN?=
 =?utf-8?B?Z0kwSmtaR0xyV1Eyd0hJT3NvS2QvUXg3R0xTWERiUGJHMVJaUm5nWDZJQ1VF?=
 =?utf-8?B?Y094eEtLYmEwVmw1NUxYVmdjTFBqWUpRZE1pdUYyZjZTTjVsYzNHM2UwME42?=
 =?utf-8?B?Mm91ckI0blU1Mi9OVlF1V0JWSWpQZktIbmtKMWtwTEZ4cmRwMkQ3bFdQZTR3?=
 =?utf-8?B?UXowYXRuMzNTdnd6WjNyZWxZKzV3WTZZVmpFbm1yUzlnSGpSMENVaHFiOGQx?=
 =?utf-8?B?enorNHhmZ0V5RFBYWjNaK0VPN0tON3ljTEZhT0YvcnkwL0w1YUNGL1BXaWZs?=
 =?utf-8?B?UTQ3TlkzZm4yeHFKSUtZMjY2U0FKUENFZFlQVDlrL0UvM3VsNXpIMjl0VkZB?=
 =?utf-8?B?RTErelN0cVRZNzFub0t4UWhqRkZHZmdocmI3WUN4S1VNVFJ0eGdkK0Fjci9L?=
 =?utf-8?B?a1RwM1B3bFkrYlhRVFJPNUFFcTgraS9BeEl5WllBRVJxdTZ3ekFkZFcwZHk0?=
 =?utf-8?B?NlR2dnZIT3Brc3ltQnpCZGFhK3BvUVpraUhTdkpxNTZseFBPd0U5bXVUa3Zx?=
 =?utf-8?B?Zy85VW1SYjhCQ1ZFdVpTeUVzMUtuNTdya2VPdCtYY0JScFpVbGRCWVNXWEtT?=
 =?utf-8?B?Yk1kbkkyM1BBc21FNGdtS1hCK2YrS3Y3UVRWNnJYSFpldGhxWFJUT3NiOFpy?=
 =?utf-8?Q?H8akhcfpfu9dkejFM/IJcoOXUWH8NQ+T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9sRWNhdFBFdis5cTNoS3NFekJiNzNjbm9XYkJDOU1ZS3p2VXlDTk9CQVNu?=
 =?utf-8?B?bE51bGgrT29OS1RVbkR6cHRlbG9BK0Job3YvRXlnaUFGOEhxUGZrd3NtL1Bq?=
 =?utf-8?B?aWxXYmZrWEZPVmZUQTBucFJUak1IeUozdDVYSjhCbEx1VDlFUXRYdjk2WDlw?=
 =?utf-8?B?UXk5dXhPSFpRQWg3WHRDMjg2ZUdmaTVaNys2ckJ5bjVLblhCaGhqdFZiSXhm?=
 =?utf-8?B?Q1dMUnBSTE5zTkdvaW1rdXYwOWFZTmlzTGxIM2hQOFBGdzMzOXk1VWxRK0xn?=
 =?utf-8?B?UE5lK09vRkx1cG51YVpaZlg5amFiUHNLWWlPcmlHVTY3b3k0Qzc3bWZNaHl3?=
 =?utf-8?B?ai9Vc3h4cy9lUXR5WXlnUVVzU01QbzhGaVJIWU1wOXd1UEJSNU5HaWF6SU9w?=
 =?utf-8?B?V1RXdlZydXE3WHZHbmFZRWJpK0JkUzBuejVSNEdVWlFscS9ldEFjN0dzdFVQ?=
 =?utf-8?B?Z1gxRWZtZXcvVjQ2M05CeWFKZzgyTEdZRXgrZ1Bzdy82Qk5UZk5YdnMyTFhW?=
 =?utf-8?B?R2I0K1BxaTFMMWlKMkRrVjRBcVJvb2psQS9EWFg2R2JiN1RYK2FTUG9zNnZT?=
 =?utf-8?B?T1FiWXVYWi9RVEFJVWpBWUxYT3p6MXBSRXQ2VWZWeURoczFwOTBFOHNHRWNL?=
 =?utf-8?B?N0hCU1lUSTZqOWtFOXlEZnZGaFBSVk11eUVuS295c3N0SWFsWHBBdXM4TVMy?=
 =?utf-8?B?cW9HQ3ZYVjBiY0x6cXYwc2QzeWUyZnVNQlpEY3VLR05HNjk3RU5qQ1pnYldH?=
 =?utf-8?B?OUhkNlJ1R2lodUNoem1XQjBJcEFxSW1WSGxiSUpXRDRRRkhIZVhnN2VYeXBF?=
 =?utf-8?B?RVcwQVdTYThqMEhTWFFzN2QwcFMwY2N3TWlWbFhSaCswRE8zUEpRNjJKcVRZ?=
 =?utf-8?B?M2FseFJNZHlVclFuS1ZYYjA2Y1NUMDlQdkVPTjlYQmtHeDFHb2M0WVRpYUtF?=
 =?utf-8?B?ZVFOS095dHMvcnQvOXJSMGpJQVpHeGxvM1NuSGxENkFOZllRakpOT25OaVNU?=
 =?utf-8?B?ZGlRbk9YTGYwWUQwc3VyTnFQM3dxR1I0ckxFUThLL1NzQ0QvVC9xczdtaEZL?=
 =?utf-8?B?TU1KVUlQeDllNjNOT09UY0Q4VzIzSHVlMzBPbzZPNlp6N2lkcHp1M25JSmhJ?=
 =?utf-8?B?ZzV4OCs5MEEwN2dCZm9yTXIxZVZZYlE0a0UyeVVST3ROMW5MWUczWEVBT3ZQ?=
 =?utf-8?B?MmE0dVA1cUhCV2x0UHFiM2M5TXlKYUNtd2NYRGh0RElZcXRaWVlxZlhlejRr?=
 =?utf-8?B?UjhoanJDdUk3THlOcnhxWG5OZ1dvNXI3UDg2aUY1cU4xb0JmT2kzQ285enJW?=
 =?utf-8?B?cWgzYS81VHhLK0tWOFV5SFFBTmxtRVFRcEg4MXVmdVhyRlg0enp3M1BHcS9S?=
 =?utf-8?B?RHhKSEVTNlg0ODNOL3dQUVFMVW5tZ0EyalA5YmNoSWtlRjdTMmcySlVqTXht?=
 =?utf-8?B?bWNjMVRyOVltd0w5OWhxY0prZ3o5L3hSR0ZYV0ZsMmMwZXdDanl3eWRQNitk?=
 =?utf-8?B?V2U2eC9zRmZOVjBFTTVJaFZ2NDZoZlZ5Nm9TTWFUaXBSRGgxSGdTRGVuQ2VZ?=
 =?utf-8?B?UzIweTU4bjF6ZXNsTDRiOThHNHlPck14cG9sSUdzOWhWbWtQQVZ0VFpHTE9v?=
 =?utf-8?B?UUt2SU1WVGZWUFIvd2Nsa3lDeklwTVUvWEZQK1Z1MFEwV3IxYk45Tk1rSzAx?=
 =?utf-8?B?SExYMlRxRFFWUE40UkZTL3dTVlI3bUY1US9jcFJsV0pVaHZId3JxSDRqQ1BG?=
 =?utf-8?B?c283Skk2WEgvbmdaS21mOUVWZWVlWXEwU2dOemNFUWtQOGVRVGxUSk54d2NZ?=
 =?utf-8?B?d0tsUllXdnlsdXJGY1loS2h1ellzTXNpYklWSnhHeXRrZ1cxcHp3N01KeGdF?=
 =?utf-8?B?UGd5VWpGc0s0NldORllFUElqYWpRQjFJZmlKRlIxVjZqYVllTm4vVmt5aDVm?=
 =?utf-8?B?MVVvR3N6ZlNYd3JUNk83VXVGWU1aYThrTFo4TzE5SE9UR3RYMWZzcXBoNFp3?=
 =?utf-8?B?MkNkRkEvRWpDQ3A3MlNIYTVxN0VDa3VLVDlMN3d3MERSNXYzMXo4Z0JLRFVT?=
 =?utf-8?B?LzJueVl1SEkySEtmT0dIZUtDcm5kVkw1OUlYNkV4UnhsNUtkcTVyVXVDeWFK?=
 =?utf-8?B?LzA3WDlqRFFnWGF4OUNpSjRqbjJNZWsxcU1pekZuOWpJVUd6ME12MERma2dH?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4572b860-2082-4c58-5606-08de0afd80cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 08:41:43.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rX0jJFvyZXYwpwgVxnjAhCZP7+/TWcwvnHsG0M4rmDQIIqTzc6PWM/R5bl258nb3/YAa2DYsGBOnn2Tkdu29MYxbjjx3ENXJmv7FRU54N+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC362E0A4E
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

On 10/14/2025 7:43 AM, Shaiq Wani wrote:
> This reverts commit af05f9e37153c53335938bcde2978a359c5f4efa
> 
> This patch caused testpmd to count packets not destined for our MAC
> even when promiscuous mode is off.This behaviour is inconsistent with
> other drivers and leads to incorrect Rx statistics.
> 
> Fixes: af05f9e ("net/ice: count drop-all filter in Rx stats")
> Cc: stable@dpdk.org

IIRC this change is still in next-net so no need for CC stable

> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>   drivers/net/intel/ice/ice_ethdev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index a9a49cd924..9d0fbd2a5a 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6353,13 +6353,12 @@ ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
>   
>   	stats->ipackets = pf->main_vsi->eth_stats.rx_unicast +
>   			  pf->main_vsi->eth_stats.rx_multicast +
> -			  ns->eth.rx_unknown_protocol +
>   			  pf->main_vsi->eth_stats.rx_broadcast -
>   			  pf->main_vsi->eth_stats.rx_discards;
>   	stats->opackets = ns->eth.tx_unicast +
>   			  ns->eth.tx_multicast +
>   			  ns->eth.tx_broadcast;
> -	stats->ibytes   = ns->eth.rx_bytes;
> +	stats->ibytes   = pf->main_vsi->eth_stats.rx_bytes;
>   	stats->obytes   = ns->eth.tx_bytes;
>   	stats->oerrors  = ns->eth.tx_errors +
>   			  pf->main_vsi->eth_stats.tx_errors;


-- 
Thanks,
Anatoly
