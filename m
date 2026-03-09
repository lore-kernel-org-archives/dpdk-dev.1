Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6772EFCD74
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 10:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 764ED40616;
	Mon,  9 Mar 2026 11:19:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C206540261;
 Mon,  9 Mar 2026 11:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773051563; x=1804587563;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g80Zs8+WA3cG1c1QbvdN9Rsqi+zSFjn59+knBKvrwfU=;
 b=RQO45om9eC4mwC4aG7XvA5dKKWSulJ27VnAcxDDIja52ZxVNk2/gxmrW
 FOQeQiLWjoB7g5FjaXRxu7Nn8QY2RDSbDi+uru+FMKh80d4TuIy3dSt3Y
 N5dyFbgMIRbdGf/WdtRf/DKueqmUq03be3FSMRCLKETQTtBMa6n7mMmf8
 yb+DUo1QhYBrpO8wN/wi/f5P4zy7xi6cuW7zZHMNu6X1/fMtYXNory8cs
 buJte7sngzplKjBzjVqRJX617aamQdHb/B4VEk60BPlF8OqvwGiKcXhc/
 pOavwhw3xSqCXzNez5vDU1e2dAYCbZP9MyVH6TjwB057wx3geM7Wp2TTJ Q==;
X-CSE-ConnectionGUID: wq8/qT+xTQu8P09NypyAYg==
X-CSE-MsgGUID: Rporj1AiSZiC5OtWYY9LtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74149396"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74149396"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 03:19:22 -0700
X-CSE-ConnectionGUID: k8WgJO6NR4+jCE/+PRBNuA==
X-CSE-MsgGUID: rAMQ2wD3ThWyvLS4w7o3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="224161319"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 03:19:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:19:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 03:19:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evUJ+0YFlTXdFC8QynzLUfbbYrm0QJIb0wKeB+S1iq2/jdxLQ+EaC0gqZQJCDbAOM/npr5xcojrUtKJRQekllhg4l3SVSC3EBT69Tt1Yy/4JwOP6Xgh4RZI+MOLdD/PJQ+QbT3LNxiFmPfFrI9O+vS8NM8hCcPVplLXnwzf/5bbVabNnYdByMTaFdghJxvf5P9qKZUpCh+sNX4QLthXCtJsgLqwBLajGyTs9s7KTj7Q1OWW8eTnV5hBr5b3FG2LbdiNflYffGAesDho5+2MVfeZ6ZNizGdBabez9XzvuV18zHn9PUHQ0wdKSogrYBSIq3WnvL0S/PotzvrZ0cukTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz4ErSVALEx1RhGPq+vif22duxqfdYAOf8Yw4LMjH1I=;
 b=puWmxV+35LvGRaqTQdt5HWMOhBmcHs+/ZXKeLas65Hh0xVqC1Lg/j2LrhF2akTwTeMemYI1ZtQMV8vNXNikp4rr3yj1D50fZnfHvtGKiRPrDUNfVekmEF7Lp+2msmkX1sEHANyNdkmbEAMlyDU5C4I6LeHSGngmBrvuzKu2YufD6aNwwEZ5yUeL/TVndm7DX5vGW6oaK6MHRViAf1eVF0jGW3HUMrr3vMHhGZc6x3xrU043Q88r9kght2uDKR0hPAwDvRxrcHFUZhPKb+NqNQ1kqr59fubhAb+nhv1rmu5xJ5E6q8fD3CLyMWaO2d+jVweYHmngIsCKcqggEDkSG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 10:19:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 10:19:15 +0000
Message-ID: <eb020e6c-8298-4041-9b16-fa12948dcf62@intel.com>
Date: Mon, 9 Mar 2026 11:19:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix rss simple_xor hash function
To: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <alex.chapman@arm.com>, <stable@dpdk.org>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260309023255.308526-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ1PR11MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc2f72e-bec5-4482-a898-08de7dc550c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info: ViwcXXvWYlWatBxp0/QvD634dKEU4YJogIAuDIpeHR7lS8Pm8Na4Sh+UpNsXcrNYDmDdpN+5lWVuK16nu2WWgqg1yP4DAK3um7eUIg3pdhr6e5665iC1h4e7HQBIuLrHUzjxJaWeriX+WNq0Yzq+xWlNBMvBbquP7QzEy89bST1saJaVN/TlRodvcaMrX8Ly3x24Gn5c4sKHu7ktcBKcoFY+GemGqheERi3dAIBMyoHRJKXSXREcl5TefR6+/Jz+uTHesLxkkWJTCYG0lgXpwh16C4LDPEyOu820wTFq0Lu8JlO6ggGAkViPoi0IMLyAaaqQhDFcCBOY7Q6g8zaNIhwVE0ve1B9X75JwGykVpsQTuudqJ1yoEdxzBhxk3ubQ0fH+9NAgbnWcAowtjeFTPvLcvtG+7MxqLdvAI+4T97zGu9C8owgntrs6LMIAS/NUCyA/I1oXW+dmx8aZY8h2kd3ZqmJlXqVmxdphgfbezHJl3N6dm6HkJNhNgB8Nu9aJmVAxvQTduN0PpZgu5ll2fgb9ek8J9G59JSuVW+ojMFPFToBtIxArhCzTkR9dFyRqqhJVQ5PkMl+D0EXvM5wSQnYfXPF2oFyCsyewM3zslXymzhLMVUGDtMwmgCBkaVEKk/s046K+KGQbzvvHEn4u4GcaSPyWKl13txWLgmPecimN/l6tj3COHUtHwDP8c1aydZIjgIu2rIKHOn2XK3qRDHPoCmmWKvKyfHZixckoHUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxWZVBOdzdHdWVLeFVWVWtLZjdHNkUzMzlVMDVla3pnOWtjYUFIWElMaS9p?=
 =?utf-8?B?Y1p3VGNOeW1XWFdPa0NkWUh5a2ZRNWpMYldoYjhubHJyZ1AxQUF4bmt6QmdF?=
 =?utf-8?B?VUJxcitwa2RnL0pFWlIzS3lPZ0ZmdXVpNjJ1azVUMlV6M3lId0xXaVhYaHY1?=
 =?utf-8?B?d1JPcEhXc3lKNzF6OTAyM0VKWUxxRkV4enFIc2VoVUFMOHpVR0JjYzdtZmd5?=
 =?utf-8?B?ZFluazUvdFhydGdoa1JSc3BOazdRQUJtdWFxOUhyUnhqcEdWbllwY1FtczN2?=
 =?utf-8?B?SUhJbWx4ZGx4SzB3ZElneHB6ZVhjdlN5WVRWSFd5ZXBUSXQxamVMVFFESUxk?=
 =?utf-8?B?bC9MNVZNc1loMk14VHFQUUhrZERzRGFmOU0zV0w3SCtvWElZc0R3YTlCM0d5?=
 =?utf-8?B?cE9uUVN3cDIzaXF4Z1BsdVhSdG9zQjFISUQyU3AwTm1jSEFjbVE2TlNqUVZs?=
 =?utf-8?B?S0F6Ly9kR1NBaysxVTlGQjRjaFhpTVBIcEhGUW93TnlIR3NNZ0VJcjNrNWJ4?=
 =?utf-8?B?bTFkZjNUaEQxdmFURk9FU0Nvd0JIQ0UzUkVmdlo0K1gwRzltUURrV2pwdWNN?=
 =?utf-8?B?SFRlLzEvd2tKYXQ0TGM0WmhIeDI2TkUzcnVoYjNQUVI2anBLTkVwem1TQ202?=
 =?utf-8?B?WEQrZ2E2K3NQWnQxMmF5NHgxNUdGWEd4N0drdTd2dk9rTTR4MUlqcEhsbE9K?=
 =?utf-8?B?RTdyNklSK3FZTVlVa3BOQVlveldka09rbnRnM1o1ZWM0S050a3NTbTg1UGly?=
 =?utf-8?B?ZEhjMzFCSkZ1Y3hUK0VjMnZaVXpWRkRRTW80OWpTb2ZHamtOWW15QzhzWWJq?=
 =?utf-8?B?TTdhc3ZCTGlYSVpHRHA2WFBlVXhWaU5xU0NvNmFiOWZ1SlhwdGpJN2FpUGVa?=
 =?utf-8?B?eVJUZVVqKzAvdjBRcUdLb215aWlENXBOenFrSm9FOVBZZUpxbzdFQms1S0Jn?=
 =?utf-8?B?cmppRmlrY0hrVExLOFhjVDZHTE0zN0tDZXIveENyMmhURGhnSU1pK3ZVT1k4?=
 =?utf-8?B?TzRONnRKalQ5NkkyRnY3ZEQ3QlpRRFpyMkI2Vmp5MnUrbXJFM1FCbWl2MjhO?=
 =?utf-8?B?b0FhMjMrUXExazFDWElWYTBGNlJCQ0pDZGQ0R0ZWUC9BWWpkME0zSkV5SEpV?=
 =?utf-8?B?UXZGRXdjRjZYNXpVNUc1V0VpTEV3ajZ0YXZmdjlQUlNTT1FRZW5aR3pzQmJN?=
 =?utf-8?B?L2lNbmIwZ0RlRlU1M3ZNOXRNYkFsUnUybFJ3T2RtT1hqcEVtdEtmOXR0NGFU?=
 =?utf-8?B?Z0V3b3VBWlRCWWlHemw2akJQRnpTWEExWGtDZ3FhT3oveWhLZVMrYTRXOVJM?=
 =?utf-8?B?UEluelRvK0tZVS85MHdzOTRJTlBja1g5d3krRFYzU3BubWlJL1NiQkZnbGVi?=
 =?utf-8?B?MzFnbjZFeUt4OURNMmxaSENsUktLbU9JNHFsYzlOYXMwZm1kd2I2UlQwTGQw?=
 =?utf-8?B?b1pDMGVZRTlINk5HY0QyRlpJRmt6ekcvcWg0NlRUcW56ZGlaOEtudW95QXZN?=
 =?utf-8?B?RElhdmtlVks2VG9oL2lKMk91TUNmcXMrU3V2WDlXNG1VTllQWjYrOFhhL0Uy?=
 =?utf-8?B?elVlUVhlelR5dzZtV1pndWFaN2RRQzQ5c1BuR0dVNm1XNTdKWFlvNGhKdGdp?=
 =?utf-8?B?SGRDQnhnM1hzZXdVQjVpWVlKdDVNUUlRU1pRNCtmczErTDhIVDBmVmFHY3ph?=
 =?utf-8?B?b0hCR3lWeml0QjBGNUkyWDJyNFRIMEVJT0JKcFRwbElvUHhUbnBVUmhNMENO?=
 =?utf-8?B?R1o3WnhldVFvcjlqNnJsdmZ4TU9VUkNXUzROb2tzV1djN2FkOFBtS1FVQVFP?=
 =?utf-8?B?SlZnZG92aDlOR09WTVVuUnE5bE5wZXQ2NUticW5udUUwRW5lSm45anM1WTBn?=
 =?utf-8?B?YWJ6WkRueFVLSERLTGtyU3loOHVOeVZZZEVsUnFyeU92eFY2YXlWelE5WlFZ?=
 =?utf-8?B?N1UzR2Y0ZUoxdWF5Vm9Ob1BLSmJlK3BpOVplb1BzaVZnU3Y1ZjJSVUlxS3hG?=
 =?utf-8?B?bE5GVStmYk9KT2lsK2YxVE1DNVd1akNERmZZTllkWTUwSGhlSExYcnd0TFhC?=
 =?utf-8?B?L1dsT3R1d1lZNk95d0pERjU0RkxPbkVnS3FHV3hPNWJucjJUOEpZSTRuQW15?=
 =?utf-8?B?bTVDY2cvZmQ5VFoyTGE4QXhnTjczSk93NjczT3NNYncvSDRpVW1WWFkvVGNk?=
 =?utf-8?B?UmI2WVhYN0F1c3VVSjdWbThmb0twNVVNU2FNS0RrR2NiYUdHV3lhaGkzTi9x?=
 =?utf-8?B?WUIyOUlPejRqTDY0TDVYbWVodDN4R0hHd1E5RWlSSjVYb2QvTzhkTG1PUkZ2?=
 =?utf-8?B?bjQvZWdNdytCOTJPNW1Ra3c3YWlTclRIUG0zQVliRWdGZlBOS2o1ZGpvNzJT?=
 =?utf-8?Q?3V1NylzwjsWtQMwI=3D?=
X-Exchange-RoutingPolicyChecked: DqW46r3Dbrfh/3Mq8NE8NjtTALmVJxcUfXL6aYNOemwMDgU9Gya3dnibibJ7Eqei5tWxUtINRR6VXBKHs7dRmttBPjyHxjQrRBjXzVYg0Ma4zfKY8NFRF2sA4aSiYuANt9SskdiDi1vf9YEbbQvQBTZbhnLuzbKDYkhAIgUCcR4Qnom8UUJ0MZA7GZpDQQHgZv44YvU6Jzc0qVnW+Hp/n3mD8UW4boS+Y2tv1/S2q0Q/7iMXFfJbLL/8Aa7iTcxXiLrRnqP2bTTQEZoYtxi0qmY0YXB19+kxP8cN63Ykl194Mv4X6XN/EE4yM3MtWfsbyF21HHvGJwiFDkIlBGqSvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc2f72e-bec5-4482-a898-08de7dc550c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:19:15.3389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBT1sYc5d0nWK/SRrafhj3h0cBbGMF+uKGgUh0QgkC+lmILP0/2LDlYaHW0Z7KdrmpbmhvThBVIBPI39pBHHcPvkcJDHm25DbqPdGx4Cdak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6252
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

On 3/9/2026 3:32 AM, Anurag Mandal wrote:
> RSS Simple XOR hash function is supported by the NIC
> as per datasheet & also in ICE Linux Ethernet kernel
> driver but the same is not enabled in ICE PMD even
> though code support is already present.
> 
> This patch fixes the issue by removing the simple_xor
> check & adding proper error log for empty argument.
> 
> Bugzilla ID: 1518
> Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Hi,

>   drivers/net/intel/ice/ice_hash.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
> index 77829e607b..d57b5ee0e4 100644
> --- a/drivers/net/intel/ice/ice_hash.c
> +++ b/drivers/net/intel/ice/ice_hash.c
> @@ -1109,12 +1109,11 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>   			rss_type = rss->types;
>   
>   			/* Check hash function and save it to rss_meta. */
> -			if (pattern_match_item->pattern_list !=
> -			    pattern_empty && rss->func ==
> -			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
> -				return rte_flow_error_set(error, ENOTSUP,
> +			if (pattern_match_item->pattern_list ==
> +			    pattern_empty) {
> +				return rte_flow_error_set(error, EINVAL,
>   					RTE_FLOW_ERROR_TYPE_ACTION, action,
> -					"Not supported flow");
> +					"Invalid empty argument");

I think this changes existing semantics a little too far.

The original code disallowed simple XOR only for cases where pattern 
wasn't empty (if it was, we allowed it - i.e. if it was a global RSS 
configuration). The fix disallows empty patterns altogether, whereas 
what it should've done instead is remove this check, and instead modify 
the second check to look for empty patterns (because otherwise we would 
go through further checks down the line for non-empty patterns).

>   			} else if (rss->func ==
>   				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
>   				rss_meta->hash_function =


-- 
Thanks,
Anatoly
