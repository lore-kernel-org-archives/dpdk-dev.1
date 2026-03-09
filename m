Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C51F417E0
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 14:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62DCD402BE;
	Mon,  9 Mar 2026 15:45:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7D0DC40261;
 Mon,  9 Mar 2026 15:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773067520; x=1804603520;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5u9UU04Pu1VfXBJdrbQg7V9zQC9oGEiS8LDZAmLiysU=;
 b=hP90jmnzeve8GbwxYxNJVVd5tKIGvjeQ+vdQt04LD9XQ0QInO2Z4WDMz
 47klED9eAQaOxqkwiduWvgf1E6l98jl91IHRNXWHLeJd7YsAbxE2u4aHi
 gb2jiL6wDRfGOlsiq/UqbRfvOx7Ur5S9qZwLyZf1NskPfUyV9KHPyImK/
 3K8rKA1KpH9U2hy9YVLgVo2PhnVmWQLqO3T0YaEHZV2H0wWj1wG1FjhPA
 KzJhzGWtmqu2/wCahzPo4Np/UXMiAJZk0vgrgvpB16UKDTjt3W5PsEQIL
 vgnAWkX4xdsQj0IrlSyvk8EIr19gXsR51Cd5n91RjjiDvTiwfwC42R4jV Q==;
X-CSE-ConnectionGUID: WItwQ3xbQLaKdqAvfLVn4Q==
X-CSE-MsgGUID: ruVM1ziSTT+cV0u5L7+41Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85440722"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="85440722"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 07:45:19 -0700
X-CSE-ConnectionGUID: cjC4iwU6RwKGnKr0M3x8lA==
X-CSE-MsgGUID: X0J0ifHqSAeb3X1SFvv4rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="216283062"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 07:45:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 07:45:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 07:45:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 07:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0LIs7+k29MLC1zRpFJeyUyYuWw+mrlC7Zc/c0XwgYZMGYWbolovAmA4eTUdxQ/B7heP12qU5HQ9rfCHR6ME0TN2Mn82ZyC4v0H4D7m/MJ2yh6ZUBW6AJNk3tD8j//9RZKtMnbn79eLDYvaJzZbloXKp67OQqATgA29sAAs8fOJ3oqNyIqbMR0bCM5LtONN8HMvOMqHTfdq2739ZZ++NEEjz1eYL35vR2x36aiWUT3Nn3X14IewbXGNAH/3asSfqncv+MAaN2h9iF3N7lqGEBcc/HYQjysYsXHHSplxwf78uNXFX29DrUnf2tNvHTlBp7Q4BLViD7B3rhYCTeF1wIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcZnXNIL2iyMG1u3wXQBKBNuD5kERU0VF5iFzGnIFXs=;
 b=q3RXmvKoFf4ElsrXsmByF96q+OBSq3NNEVfn0VZHm2lbXgd0X6QvW8jsNG3K3v1z6/Iqnp94Z8y4/KBJYh11YbaCQ2nY+ZPTDvo6gX0hei8CPvnOxtn1xgm4aqimnlV/yYXY+RIfn4uu2tmf4kDL+IT4BVliR6mgG4b35+dpveMJM0R0iA4nrAdlz3N662nkXmzYQkmM54Kin916ST7QK47FNeBJsZh56AfmU+w0tkpQTHyq1lgW53WtZaeA/14kY5SKciDh1q+QCpaFxjmlA9rwdqfWXJ2NHdJLzKTvnS24k3hl1mhbqui9h/V9gQrNDvdnncGYinDjLOWGYOJZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 14:45:12 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 14:45:11 +0000
Message-ID: <8e39752e-6430-49a5-a1fe-e92fbe4d6025@intel.com>
Date: Mon, 9 Mar 2026 15:45:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/i40e: fix null dereference in raw flow item
To: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20260309132802.3094565-1-ciara.loftus@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260309132802.3094565-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: a99315f5-3b56-498b-de66-08de7dea7753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 0JEJ6vXQqIeu3f+tKdGN4ij9hgYA5/98bVT+OXjdLrbvCf2sbrEn6cuYawp9Vc8kq/hEOrXhudtkr+1qr95TEj4h7G7rwQiMzS2WFvjU+d18GnImH1DzkbZxXZMwJjMBDFL/NHSeP8mzKBtuhpp2KeJlI8epZKFujNqmyyzmibmYVppBOxYgeiW/4T4L7EbY9i7vhHH2/8RIPe4qRf8iGWKsNmjJNj++Qwd6TTt85vsS77oCiREDUdLtA6clwG0IHKlGC4RpaM4XATYDJxa0529EqFjnCt1/B6VBHHlYBWYt6MY0VmRpfLJ0pOG0WxJpHr+3NkFaRHKu3Ii12MSyfplrkpszp0eCGEOyVY7dfpSBlD3VuzsPEu2nkT7+03K+Caa278T0+nKDcUudqDL9Isf/rlcFQ6ScyD9SiGK2LkES5b5ZhaJ3vZddF2PzK3KDEq/GtW4J36YfKOzk1PxzqMMZNrVs5JstqpsEHabr68DCMtMqrZSaUkvzDLkcfbAuWFHWWtcWfRalHSSX2QnPOZz7Yv1/jfir27f98AztYcWa/i9CpJkLZ/ZAX3v9ndZoQJ9/0I6VSUXjuVIfjqiBoLAAt+xkPY5J8yDrNJQcsPpnpCMOq3uNGOnndqSN77fNxhgUGlffUoIH7b7YEUCFDXGoknohiF4+buds/TZF6tRmp3z756komGJYeNee2TuhseGxe6k4o5HXhWs4JE3+yMeXVPevaq/3ihZev4Ua10E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRoWUp0Wld3cHNoeGMrTlFMR2RvSEtobnZEYWcxNXoxc0RsOEpPSEsvU1Rk?=
 =?utf-8?B?eXJQOVhYa1Y4aDl5TVBKenlGSWQydjVtNlk0aWNhYUFVZ2psakxJbzZtMUpv?=
 =?utf-8?B?WkU1ZXNPTDRWeDcrbXZ0WDBXR0xCUWUxU2JaU0pRbjA2eDQ0cnlCNVJsZWcw?=
 =?utf-8?B?SWtUbTBzZ2hpRSthNS9DTEcvNlZGLzBmU2NBUXdHYXNjaUxwTDRXcHhEVE82?=
 =?utf-8?B?Y1JJNFF6SDNFckdCMW1USnBoaVZNU2w4Z1l6bmt5Skp5cEtWeHdTOHBIOE1T?=
 =?utf-8?B?dUlQQmJWbmhDY3lNakV0NWx4U0NtQ0k5V09UMGpTNU9lR1A5VG8xZTJwNFFr?=
 =?utf-8?B?NXNNZ3hTK0VTbHJtYkZsWlI4RHk2MVFJS0tmM1lwTXhTcUVnZGNhcHVFY3Zp?=
 =?utf-8?B?NFNiTDhsa2J1Znp2Z0pHS3RFcnRNN1ZFQ0NVa3NmRUU4MUlQS0tBbis1VVow?=
 =?utf-8?B?YlNleGd4R1hoeUdNNXB3KzdYY0xuK281WExXSVJmYmdDaktyRlF0RzZ0YVVQ?=
 =?utf-8?B?VFptYVZIbjg4UUhhQStWWE1lTTZlTWphdHk1ZlZHN2E0d1FoZFJZK1RZQzA1?=
 =?utf-8?B?RlpXWDRSRVRVU3hmOXJlYmFEeGFLS3RiK3JQQTNuamI3Qy9ZTWRXczIrTm9J?=
 =?utf-8?B?c2tqaHp6ZUVRZWtsVmJHYjlEVlZDTzZBRVl5YWxwL0htU0NSRFZ0UzZNVkU3?=
 =?utf-8?B?ZlNrOWluWU15TG5HKzB3dWJOSTN2QVNKWTVJTGowOGdrdVl0aHNZN3I4dTFi?=
 =?utf-8?B?bFQwdTdNaktaUmtBcnpiK1BQNllzYkxrUmNMN2xITHZxVWxvVHN1cEUxdnZh?=
 =?utf-8?B?cFBMeXpRU1V2VStGMFMxOFhxMFNOcUc4V0lVakozTktFNWVZNWdTblBPRExF?=
 =?utf-8?B?S3REMGRCVndwczVxL2FSSG1QREw4djNZK295N0tQclJCYXFVN2pRbExzTnJl?=
 =?utf-8?B?QUhPdVAvSk41OHA5RmtwV1RGZ1hjc296OXNaTHJEWWpnaGFkc0dZSnhnV3FX?=
 =?utf-8?B?T3Boa1A3bkFMMnd1UlNmQU5sbjdTV0hYN1VxQjU0eDJjcGxpdGRNVU9Jbk9P?=
 =?utf-8?B?c2lzMXlZbjJTd205cloreHpydWRGRDJmeTZmc2FPVzU5cnVqRWR5UXBhWjBa?=
 =?utf-8?B?Rjl2N1ZOQUVVc3ljR0wxbnZrd0RtMFROOUdCWENadEJ4a0dydG9zcTI1cHM3?=
 =?utf-8?B?cFhyM3RtYnRscGRKYU1Dd3ZYcDhsTHY4YmdtT0dYRk1rUEYyNjkrZWR4RG1C?=
 =?utf-8?B?VWhyc2sxNWovbTdiaklRd0hNUHNVRWdvcXdoUkI3N2VhZmN6OFZZSXRZdjIy?=
 =?utf-8?B?RFVDc1VjWHRPRG9ZZGQ3dURLQ3l1ZE1pSGp5K1VacEk0bmdKb1FuRjdrdnI5?=
 =?utf-8?B?WVRQMTY0WlNFclc5MzZUWE02UEthUDVqQzlkdDVYV05EY1JuejJLdWlpMTYw?=
 =?utf-8?B?QjBWSmVUWmIxeWw0VFVQdVFSZFZ2OU1sUXArMm0rZDIwWXM1TWdGdEtIS2Jy?=
 =?utf-8?B?OVkwdDdHay9uS0RSTUU2c09rOEJlVVNDMWQreXVsOGlZY0plZWtTclNaRUhF?=
 =?utf-8?B?OVBSRUZYdGZJQTVYdTlPcFN5SEFXVXpia3QzMUI0WUQzNCtCWTMxOUV2U2gx?=
 =?utf-8?B?UWNwa1YyV0xHYWRsRFVWUzMyQnNoUmRUam51SEp5eSsrU2hDNFM5SndMRjMy?=
 =?utf-8?B?NWVFWVBUZEtpNEZlUlVEdDhuTVd2V3pHN2F1R3NkdHZBaGs4MlU0OXJkMFVs?=
 =?utf-8?B?M1EveDBSMmFYQUZDTzh4dlR3R0VxQTRWcHNuVGJDVTVhKzlqbVpKWU9VeHE4?=
 =?utf-8?B?SE90anU1cnJCMzNNVUN2aHN0TkN4UUNlZmg1dWNiT3lSSjVLL1JXQ2RQMXlo?=
 =?utf-8?B?TERVSzRrRXJ3TmNFNkxKTWZJcDAxTE9ILzBCVWYyV0dOdHZaa3VUR3lWUmRw?=
 =?utf-8?B?S2pVbUx0a2N1R2RDOW44aGo5cHgvNFRYdnVOSmwwSnpKVURITTllQ2JoVnR5?=
 =?utf-8?B?QlFucFZON1ZoK2pHT0w1Y1NUR2RRT2hXeWF1NlB1YkN1YSt4b0VwR1owM1Rz?=
 =?utf-8?B?TDJrOVNVK09iNlJZaW1LazJsZVo1MkExTkNhZE12QjZLenM5TVNmVCtEOFRl?=
 =?utf-8?B?SzJRcktPUEZXTytDS1VhTk1taVJCRGVMcFp4V2F3SHIycU93aXRLczJKUnFS?=
 =?utf-8?B?R3lWRTB5enZreVN1UVAzcDdRUnJLVVl1T0JsQWNPWklBSklCRDZGdkhnZllw?=
 =?utf-8?B?aTVKWGI5c0hrMy9zTmVpc0VlZUFHU0d4aWdKdFo2YWNhemdKT0lxTy94NjBT?=
 =?utf-8?B?NHNyUlFKWTliK3FRQ3JrMms0bUVkUXhBU1ROMDI3SklnaFYwdWdTYXl1NER2?=
 =?utf-8?Q?EJEpA04xSju46228=3D?=
X-Exchange-RoutingPolicyChecked: pi+SV8J9Kybc5VKT6vPWZBcg5CSqRFAK8jSqP8tbOqNjemG7/+jMOS2eGssOGsRDQlxr4pp+xtOnyilU1jH6UMWxYBE2HgFznBXUXnLjvMG87wSqfKjmZ7mo20Ea1yX3cYsxXV3b7Q8a1S9fmGwubfzhBcn1FfMoo3O/+IvwTqmARjnNsYZCIvOSn6JkYeIs721Bvu4D3+ZGtYSPrb+ICS/N+h9GRvMbONvxplX3SVRu5utG8OEdqqlmuga+I3S6GzgqeRGgKDw/6VMwmJMsTUh9kc7+VCPdFFkrDUTAOFmIlA7B5V+rTN1uSSfgzNcQDfnq1jxi24fDygcubhcvkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a99315f5-3b56-498b-de66-08de7dea7753
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:45:11.5619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzysQoTHRMp8/mWGfA1hg5J92vVRFILhcVjuLyHZIJyVnGDRts8bMzF5Y2OyzbikuSKhc518N3WZHjZlW/tuBp6c6IGq9c5TuQWGZGSEM1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
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

On 3/9/2026 2:28 PM, Ciara Loftus wrote:
> When a RTE_FLOW_ITEM_TYPE_RAW item is used with a non-zero length
> and a NULL pattern pointer in either the spec or mask, a segfault
> occurs as the pattern bytes are accessed unconditionally in a loop.
> Add NULL checks for both spec->pattern and mask->pattern before entering
> the loop that uses those fields.
> 
> Bugzilla ID: 1155
> Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_flow.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
> index 2374b9bbca..6ad3013573 100644
> --- a/drivers/net/intel/i40e/i40e_flow.c
> +++ b/drivers/net/intel/i40e/i40e_flow.c
> @@ -2350,6 +2350,24 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
>   				return -rte_errno;
>   			}
>   
> +			if (raw_spec->length != 0) {
> +				if (raw_spec->pattern == NULL) {
> +					rte_flow_error_set(error, EINVAL,
> +							   RTE_FLOW_ERROR_TYPE_ITEM,
> +							   item,
> +							   "NULL RAW spec pattern");
> +					return -rte_errno;
> +				}
> +
> +				if (raw_mask->pattern == NULL) {
> +					rte_flow_error_set(error, EINVAL,
> +							   RTE_FLOW_ERROR_TYPE_ITEM,
> +							   item,
> +							   "NULL RAW mask pattern");
> +					return -rte_errno;
> +				}
> +			}
> +
>   			for (i = 0; i < raw_spec->length; i++) {
>   				j = i + next_dst_off;
>   				if (j >= RTE_ETH_FDIR_MAX_FLEXLEN ||

Maybe also check if raw_mask length matches raw_spec?

Otherwise,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
