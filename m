Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD6CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 09:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D0D640290;
	Mon,  5 Oct 2026 11:45:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D3BE34028E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 11:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791193530; x=1822729530;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=M0kbzlGrQEuwAeTj6pt4xXQraeftCJREuXCwyUzPDQE=;
 b=NnrquPPpelIR887aPdtwmqkNetAwFmZyjPV/kMsIQ5hqJDE/qQ2HLwGx
 uObZjULuUILj5BkwgJvt0AsfAh5MqeWQCUckHv31e69p8+oVMe3EByOTO
 X8FLIfD9r4otIMzAPGykPHycFRqzy2akw0QSZLzoLsDflSNSyVi4vyqqD
 HEHRSuUWQ3338xufTdQafJwxysrDRRASD/8FphccqZ8f4jUZh4xSfCXF0
 wtdIJ1q2LuRm6nnduU3+WNlfCjJG4XYt0kZ4rNAwUO5tZSU/RGDgdVpM+
 2fJKp5+EiW0qbBQNYuv0RLo0VuSu5omQgHrEk/86GVWwnDEnwFvGhhVmg Q==;
X-CSE-ConnectionGUID: vb6H6cSkRnm9GH3K68ewUg==
X-CSE-MsgGUID: sSlZiXCUTVCuOd30XRA2Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90917861"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="90917861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 02:45:29 -0700
X-CSE-ConnectionGUID: vQGLqmjySCik9aFRz+0l+g==
X-CSE-MsgGUID: pYOvACIRTS6lvnGf55iuRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="280058847"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 02:45:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 02:45:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 02:45:28 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.39)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 02:45:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET6d+8VdElaa7qCyn9eHT4tOK4BqLqJ1gOV7Pg1Drjs4aB3H84CZn7Chu3f0cMi3XuYo7O8Oy0KSRY6s/hSih+L6vJaNZ4AWEXUNRPZw2o1r7ytUPVodqHEIy/G8Jm9RXwATL3oIJ7tgpbegQjXNpWobYpJ4ipKtLAKZg5nehYJdJ2lWT31w1U+nPTd9nOC6k1J0xEnig+SrSY8JsqwC7lGAjxNRGwhA/iLxfcXEm14KacKAipjh+oXvkKpThb994lRkFsZ7lzhCMoG9WEUZ+Y/SZn78XpdZnY9qdfNqTLybiZHkA9wGfs9x+uFg1Wac32EShiG2Rki/STyeU/fimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPvSi6vB10aTJw/mVn2nlrciOEm1IYFAD6hqyGu3PjA=;
 b=eVN7vXNhhgjfsoP7TxIC9CqCd6uWd5HoFOljLg/MJdSXEo+J/80bwzxwL13F30Th1gbuUfGBzikuhGPJCo+49+2ckd/7yqM7uYW3gBGLblsRad+dQUI2+Uc72G/smfQaytHfiSNXrmhFPErFC3qU/GLlGIEN0gzPZSRRd5zZ1i+Br6BtgouQFU3tRbTYDacTPE0NJwq7qqQLgN3M3chw9Xc9kiWH5AsytEl6Ok54m0KjRYaySl8z7SVDXx7Iz5QoTut2obhVkdyJrB5nbTi2i4hfU/N/mGUKlo7PSgjSbhK1OOjPleuW+S95vVhA6LFW3FDVBpxwqMQBV/uPHG+NSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS6PR11MB203949.namprd11.prod.outlook.com (2603:10b6:8:49a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Mon, 5 Oct 2026 09:45:26 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 09:45:26 +0000
Message-ID: <ae273061-f318-4d21-a7a1-85a402045cc2@intel.com>
Date: Mon, 5 Oct 2026 11:45:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] net/ixgbe: reimplement ntuple parser
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <b3903b1641bb4cb532c01e6094eed08568f3bc82.1789560945.git.anatoly.burakov@intel.com>
 <f53e2ff2-b4b0-4502-86bd-4c948b429c3e@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <f53e2ff2-b4b0-4502-86bd-4c948b429c3e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS6PR11MB203949:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d4e29c-89fa-46fe-8149-08df22c5622c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yaa37Y25o9GRAfOblTCaeQ5n612azHxZmfjADGE97kMPP982BI9iSPO17dnWUei5uZAm0iFYGU/FUQxRh211xJFiVplBUjKel8bj/ZX2hC/jMh3f6q9TlN6F6GqFL0m5ur0zj10APuVa5Fw72vhZ5SfVdJrzHPhb+ODL8TBeD4y8vkZrDNAre5rSGM4kjyo9TgluWr+hZ/smW9EyAbjJ+maW8GVvE4ZtcwXL/IuJaHV5QkQASZ6Nn5aePwJlpcn1liw0e/fx9oB+k1CNpyroNBUu2QGmTvWZ8P/G+ylz/F+8ML+MGas04ktw43tUZn/HIjOV9b1Swn2qi3epkly+T+4zMoL7omOsA1NWZOWfVxVFg1g/a1yFy2pRY8rYE89YNzcLzhBfBw/IUsBMLXB1ZFiCkceU/ZA4+O0L474SJa7J8EGQJLN3gK77FKH0TkozYq+6gJITQ0Ip1tnwLNV2kEgzIU/NoGOJqmv8/cZPJSto+5kzlZ4YjNw+L57XO7VMAPnNlsiENQ700Oyf5MoYPWsbZjlYDjWdE+3+dLCBVtbNdXOfMksO0lj204bE6fJYjoBpKwNyum3vx/rzA+u68kQ6dSj6NfmcnBJGSKk+c20Dynki4vuv+8ZotDu5VU5Xq/KnE2tpb6va9rS7ACqz1bmXdUzxuW8ULgGee7CRfLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JpbGptTFhpT25tKzhocmFabEl3VDBlWWNtQ3cyT3piZ21WVkVFM1YzV3RJ?=
 =?utf-8?B?SUNCZWtSNVY4K04rNW81R2FsVjJRWlhJMDNXU1BCS3Mxa0NBRURjNnRnclpD?=
 =?utf-8?B?SmFXOWNtYUlxSWhNU2I0WVJMWWV0bDVkeHVQMkhRbXpTUVhmYkhSL2N0ZG80?=
 =?utf-8?B?SXcrZ1h5M0tGL2wweDA3QTVYVCs1UkI4TVVPa1NYdlNUemlKcHVkaVlGcGpG?=
 =?utf-8?B?RDZPOTlxQjhvN0VjeUlqOFJvY2VPWFMwSEptZVNsVWFkcUdobnVia0IrMllh?=
 =?utf-8?B?SUkrVnNWejlkNkNhZHFjWmJEQ2daRHIyd3JpY1RocHduZC9UbUxQS0xYcWxt?=
 =?utf-8?B?ZElpVmZaUzMzRnJTRDlUcEt4TE5RZ2JIM2piRE9SOWhuRUVlekZERHBQdzM0?=
 =?utf-8?B?WEhtM1BzM3lNWVJEZnd6WXFYUWFCVlMvMnpRdFFRd1VIWHVPU2lkTzFTMXlL?=
 =?utf-8?B?a3hGNytwT3pIUVZVMFlxVTQ2MHE3bHUwVFdZVVFtT0syZytTMXBzS2ZHem43?=
 =?utf-8?B?cm9JaVpOWHZ1UWNEbmJtTHhLNE00Wm8rSzNWcUorNTJmSnJzVkMwNTh4SU93?=
 =?utf-8?B?eGhyRDV3bWhETmFJMnFUOW1mbjVqNkZtVFczekEvWGJqQm5UTm9KczFndjVl?=
 =?utf-8?B?bnJCODJEZ0pnTTJTQnlGbW9tVTdkQW1Ud1NYYndxVDl2VVVqbTltSUsxc2Qx?=
 =?utf-8?B?SVlIa2ZtTlhDZjNkWENHVkxsVHpDWW9CaEFIOWZseC8zQ2QxN2lWblArR0wx?=
 =?utf-8?B?VUpUSTZJMlV1bUpoOXlTTk83anEvMzdqYkZXTkQ3WWJpTVhuRUFodnc1SlU5?=
 =?utf-8?B?K2YvU0tMejJKZk04cnNnYkk1NzFIUTl1RUVQU3NrM2NVSkVXWEQ3OHV1YlJt?=
 =?utf-8?B?RmptVDBiSU4ybHZnNXBmcmxFV0N2dG1TcXlPb243YUttOGFzVlZ1Yzh0YXVq?=
 =?utf-8?B?U1ZIdXEzTUhwYWZwZ05nQUNZK3k2cTRwT0gvOWw5d1lkWGNhNDhrWDlSa2dF?=
 =?utf-8?B?dVpnQkluTG92QVliSVJGUzZFaU9uVGpVdWxhU2MwZUw1RDQ3SHR1SWRpWEZh?=
 =?utf-8?B?SU5Hem5lOVlYbHpwdUFCNmMrbVV3N0lrbUhOK1V6QnVBaDdWQTBVMFp1Zllh?=
 =?utf-8?B?UElrRS8xVlRSNGJSYzZoVVNYTTdXMVdGb3E5S3lyVXduMkZRYnU2WEdFeDJE?=
 =?utf-8?B?NzZsUlNHUkRFbkpTdTJKME9Gdm5PbGM4UFh0Yk5DTEJWbFZxbXhKd2NpbjBU?=
 =?utf-8?B?MnRNS3pWYURLcHZMSTI1K2M1T2k1VGhYb0djcXpmcWtVVVdUd3ZmSVY1QlJn?=
 =?utf-8?B?eGU3b0h6Q0xrMEJDVnJoeTFtK1JTSTdPM1lYNjVpMDA0azkzWjB5T1AySE9m?=
 =?utf-8?B?YkFteXlTeWJ5dFJBTDIwR1ZWUjhtdTFPaXVCSjFqT3RGamxPekdRVjFHVkNZ?=
 =?utf-8?B?Tmh3UGJqOWlmUjExdGVsMWNKZ2JxOVNZNEQxbjl2THRwMitTKzZvOTNYZnBT?=
 =?utf-8?B?L1VQSmJYcWFINzB0S09TZUV6bFZRQlQxYXhWVE9OZHhHdERKWVNOSWJSaENL?=
 =?utf-8?B?RmRtUFR3dFVxK05yOGVrZDNhYWpmSnBhUmlwY3NnTDNSSkdObkN2anJKZkZV?=
 =?utf-8?B?clcxRlk3TjJOYVBJUFZ1ZTBhRHVjbHNGUHNRUzJsOVNqQlhtekhweVUvckRY?=
 =?utf-8?B?MitKSHdBZ05VUkgxdG40U1VQR3VRYW9rbXoxcWFUaWhJUHp1eElJVWpoVlVx?=
 =?utf-8?B?MTNuTSttZDdObzVBZVV4UDRMMUkrL0JkdUt5THV5UzJlUE4yeDkzZ1pERDVn?=
 =?utf-8?B?b2ljU2lsRnYxUXNNUGpMN3F3eHVJVTdERkQ2bUt0anF1UzI5a2VHRkE0d1J1?=
 =?utf-8?B?N1NLNTdROEdON2ZzaXVJU0ZEVjJIdVN5ZzlmTFc3T1poY2ZpVDdOMEJ1SzVU?=
 =?utf-8?B?Uzg4NWV0QS9nRTFrU0pyN1hUc0FwN29SWWNZSTduZWIxU0hXWU44MGRCSUlp?=
 =?utf-8?B?SG9sZjRwRXR6c0R4Kyt6OERUSkV6bi9pS3J6OWZaMGxQR0t1V3BUb25Kbytz?=
 =?utf-8?B?cWFTcUVyaGRoNFgrNXRvYll1RTNwTklpU21jL2NMK1A1TDJRUm5wT1NJK1Uy?=
 =?utf-8?B?UExDSzN5MjkrUThWZ21QR3BPS29CVGdEcUFrM0E2MkxtT2FCaWhjNHlUQVo2?=
 =?utf-8?B?cVJtdDRkS0RiK3d6MVVlTHltRmVzMzVQc1l3U2N6SzM4WWFuK3lxekVPTTVl?=
 =?utf-8?B?amx3ajY1Mnc4cG5jdkZZd2IrK0ZXME5mb1FsK3JZMExJbFg1d3FKaUxxeml0?=
 =?utf-8?B?bUYvWnUxa0pmZitySDdIR2VKT2tSTkIwWExUS1ZaKzBsd1Y3SUZyMGhkZnNa?=
 =?utf-8?Q?/2MWymVHij4Pd6Bg=3D?=
X-Exchange-RoutingPolicyChecked: hsB7ARJbL9BaR/yGjWB0gKtncIFb3Pl2o2p8L9wU6DlKdlHmvfJxUrx2x1OZ/OG7vXwO+epFcz1CpjzuPv/XVe14RoNXBGyPEzdefOx71BuyNq1sOFDzW9h/ZQmtJOd8GaoyD9kIoezduSMBeFC1N7FqQ3YitPTYMRHPIp3+qkT5zE/uoxYJSnby5sjVzg3uenxnkK9vrxRew605qILpLrU09D/vYn1Rt2ZBZEyJw4UYbUGm9bchCqrxN9dOZsoaPoi8jzpezAepfAxDSlty5PifIbqv2S9uUazWFWuaCfUrjnft60x8nZXMPEkfvQUR8VQ6rsRcZSjWMkbVAnGXiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d4e29c-89fa-46fe-8149-08df22c5622c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:45:26.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co8rczFQtrRKRzEkH78Y9L1V/Xm8DbSS/KtUtXGQjzRINyCPwDCRQ6PUh2VFWxLbGRDa4E/ueEQNtlKoN5tWcIsFHWfyHiheoBbUHq6vMkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB203949
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

On 9/19/2026 6:11 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Use the new flow graph API and the common parsing framework to implement
>> flow parser for ntuple.
>>
>> The 5tuple filter tracking infrastructure is moved completely inside the
>> new engine and is removed from the rest of the driver.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---

<snip>

>> +    priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr- 
>> >priority);
>> +    priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
>> +    priority += IXGBE_MIN_N_TUPLE_PRIO;
>> +    ntuple_ctx->ntuple.priority = priority;
> 
> priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO, 
> RTE_MAX(IXGBE_MIN_N_TUPLE_PRIO, attr->priority))
> 
> otherwise priority 0 maps to 7

According to data sheet and rte_flow API semantics, this should be 
correct. Priority 0 is highest in rte_flow, priority 7 is highest as far 
as ntuple filters are concerned. The old priority assignment was 
semantically incorrect. This probably should be a separate fix.

-- 
Thanks,
Anatoly
