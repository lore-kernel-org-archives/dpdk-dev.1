Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306EC9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8917E40DD3;
	Fri, 25 Sep 2026 11:42:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id B780140BA6;
 Fri, 25 Sep 2026 11:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790329326; x=1821865326;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4WuswCJpXR6zlfiKR8d2KUkWvj5K37wFOtU+JOoqGgA=;
 b=dJn89EDpU5jYYywVNglCD04NLbl56x/aybQvVHgbL0PiNZCff5aWeAJV
 TvlJNzfQuZrKvSMJkW15m2E2+zg16eycv6tz8pLg3ogtKLgEVNpMERRV8
 bo5zHxCMazxpoDx8LV1GDAiKCocE6gj0akIEUJ6NzI/A7qR+4t2TV24G0
 /Lt9FwwoSJxaJGD+KaTtuRuHiAuZDdVbP/ggLRU+YQW9Lrppj9AvaM/jh
 kmAjmSnY3QjpYkjaz3RWBPYoNMoD1PeZYq9vmTv77gmkSAPgku9ZCotOO
 JBXKbZfB6zvZt3Lh+vJFmFEZqeUpwxeMRHp3ZLizB/91RD6Rh1hrzDfQy Q==;
X-CSE-ConnectionGUID: PLL9Ho2VSTuzW1vsHrY8EQ==
X-CSE-MsgGUID: YOW/0eHPQHCv9k+xzd0/SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108602593"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="108602593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:42:05 -0700
X-CSE-ConnectionGUID: oxh+yC2/RhyqlIxWnMFNuA==
X-CSE-MsgGUID: IUteNnNIT1uytdcTtl/grQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="278057408"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:42:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:42:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 02:42:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9N6XS4Q1li6YDFcWj5yAumnZuK0orvX+MIduneQQ+T9/VOtalxdyzfviEkT+PAKrmaD+59C3bVKqTusq8y9JE/XjuiU+pAFYQqji+/JGX3oBfCuZnu+4Ktghg24YX+G7hIqLtrEon5imYRN4e/nocOv+mH9KQXh/hiHaO1VInnuNVuHZ0vC90gu8R+m75sOgknsDvm2dBWLlVcAOFGt4OBR0ecSs+uQA9G/k4CXZ1+o0GIsUkflOgxiyFUHXw0nzUuUmHsBo8xp+cAjkpz+bHzMw67MICmLSQEyoNUg8KwInEkJn26bAWqLJcQsLI1V24icQx1i+6HESZpOUVaEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mowWGl0WJXVJbVTzvXM+J2AreylM2wdS0IpS7xmYmK8=;
 b=ZPLTXBvHUn3vSdACoy7yvweFa7dFXAjKqMnbcfmnuGlVyYxb0Fs6e6rd4xR/Xk0kL1ysupRAG1/XQTSy4EhbaZu3ZZz/vhVPoQHxvpT+vk0Y7Dg8J3U+IOdsb3JWH3+Ajr0cGEVaM1b77X5BoPUpabACEglPUfZz+MY1SlJe7Dis4gDWaRSYUf6VkwALXAuIaxcB186W9WQFtNZTFhkQ/N55YZafB7ZBfevfvQCVfMYMAItwn7XEG38WbtIcvdq1Wo8au04VsQXNqWEuq2lOMGdY+aNJ5jnTyxROEdUXnbC+yuvRfTwC7t6yhfJT4Zvt+KmX8LNVyzu3i6xKQW/kzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DSWPR11MB9931.namprd11.prod.outlook.com (2603:10b6:8:3a4::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Fri, 25 Sep 2026 09:41:13 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:41:13 +0000
Message-ID: <5e9888a4-d71a-45b0-a29b-ffa06d117a5b@intel.com>
Date: Fri, 25 Sep 2026 11:41:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix storing field offset arg
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <bug-2038-3@https.bugs.dpdk.org>
 <20260914154559.4045256-1-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260914154559.4045256-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0484.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DSWPR11MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab21406-2da2-4e71-bb4d-08df1ae92349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oHOX7GALHZvE4CWcuIHqL6Ss9dgChUnyDUgQOa7KmzWmGxhp7VQHSGz55S+HQvriIuxZUjqVUSKFij40kPKM4Urod+xnOq26FnYV1lxsHwJ2UYzS/SAWSLwmOBOsC+Jwovn84t9MQil9nEyWgLtzTN27cQNHz3zThDY685/vUHI5wtSY0H+yK8CbgQcaxYOPD9hGrLgQs+ENt25HxNvO+SXWe9R3WPZAdMpnb9Vpi4YeHjusgrNYi14JQNOjRxxI8sD8Kl26VW4hUuX+2lJEXn0KXalSRio4tAsleuXF0DowCt4Ug+//89aBHiRPPouVr15OzhcliPPjOVzxNgrYEBFjtXlk+gem+BzO4xxiCl71fqQ+9xC926ZE3eLKb9JNGZGFiY2vr/o67h1/VXgjcmpHG6qEJ439Mg2tH7tCMQKolREtCzm44pvoFRmQ8CE5qC8IBzwNWzolD25ykxHQjCRpwXLLmoG9u494nx4RPVRp6ugDiNz+eqawALl7rPjaV/eVwScylfGfImter+N/11/OZ1KflLB2lQsZTOay2yQ5eall6Eek4iQwcWnAyYllP3srr45CIBQ6jqaETG9VQ3b5V1sKM1vIqyeQG0E46V0qGBcni0pzScVTA/LHwu3TZjjeHFbrRnYsST74eFM8Wbsfi0WlW45Drwv+9tDMRVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEFKMXB5S1hTbVBWcWVCM1NKbzEyTGUzQ3VGZm0vdEFOK1V6R3Fobnd5SDlm?=
 =?utf-8?B?UEQ4THdBTWRCVUMxQ1VudmVCMzVRMFZ6VHBBZEVJa1ROWDI4RjZPTHgxS1BU?=
 =?utf-8?B?MGJGdUhKY2dQSjNKKytXRDlvL21EWGp5LzhUVEhnc0IvNVZQcGd4YUxsQ21z?=
 =?utf-8?B?cTBRWmxudURlYmI4ZTJET1hkcnc4amIzd3ZSQU95THlaaWRub09DVldIdzht?=
 =?utf-8?B?UXBlM1BWaUxHQ1hpUnVralkwSUxud0FjVHdCdXR0MXVMSS9kL3RGeGNRMlF0?=
 =?utf-8?B?QUJOQzVLelVRM2QySmdRNDN4cW5qazBTdERPSGo4aGJrUWxZQ0xGV05mYUdw?=
 =?utf-8?B?K0JPM1JxdTJzclBBSnVvSFo3MVA3emVLdzhXNWJ4K1pKV2NTbWNXRk1YUk8y?=
 =?utf-8?B?ZnBUZUdqUGhoVWNhNmRBbGI5clFxQVk5WG44QlRzOXVHOHlTOFdzOGN5NC96?=
 =?utf-8?B?OHFXVlpUSGFMSyt4clF2N0JrNmNZZW5zaXdYeTIzVE9uTnJhMnR1L1gwK2ov?=
 =?utf-8?B?TzRhT1pHZmQ2czdwK3RwRkkreHN6cWpad1ZVMk42djVmYmNxZUlielZiTGFL?=
 =?utf-8?B?RkdOdnN5cE1qU0ZRUkN6SHcweEgyNzQrb0p3a0NzRHFoVjJLZ0ZKQ2xmejgr?=
 =?utf-8?B?dlg5ZzVpcjgxUVdFSzhiQU1MaDFGSmhWUGxuc1lIc3VkRTdBY25SV0llb05w?=
 =?utf-8?B?MVVaWHlCMGV3b3BtbThNUUFCR2NWQjBaSkZMRVZtWWJFbVg0S0RlOW4xbjdZ?=
 =?utf-8?B?RDBYMmZzQzdjNHBmLzY3UHMyVzJxbjhCS29BVHcrNGJWbW1nc05NNjlldHdi?=
 =?utf-8?B?bDNlbVlOZGw2Z3EvMEVPTTNoTFFCaUIyS1NXQkR5RlREREYrVVMvZnRTUG52?=
 =?utf-8?B?MEtodmZxZWN1bk1adkJqYUozRXFiSWt6SGFSTVIwYVAyK3JOaGorUFRQVWF1?=
 =?utf-8?B?K1FlZlRUUUVJQUYxK28xTFVIOFFpOUhLLy9WSGwwOWxvbHFacnc1Y2UrdDZB?=
 =?utf-8?B?Z2R3cUJhak54OHRYWHFrOTZrc0kvZEI5Uy9uYzl2ZklYNmpvWXhRZ09SWWx0?=
 =?utf-8?B?bWNWelI3dWR3RGdUNmNoTnhjb1ZwN095VkNpb3R6NnUzMTBnMVh2NDZuY2Ry?=
 =?utf-8?B?dDdyaDVibTBweVE3ZGIyWVhjQWQ2Z2Y0Tm1zV2srNFhEeGxVdXBEdU5rVWlJ?=
 =?utf-8?B?MHBJeUV3T2ZOTVBpSVgvbkYrQTIvWFBlcktaMnpaTXN1b2VhWGkyU2gxbGoy?=
 =?utf-8?B?Mm5TUHdvcmgvMzBhcktPMGdsSlkrMGxmQWJhcnE0b0FudXRRY2o0dWQyWFYv?=
 =?utf-8?B?endqemlLaVZEL3lXQ2EweVBuMTdOdjdQNDNabnQ5SUFWSmZpRUZGOWs0am4r?=
 =?utf-8?B?Nm53WGgvUHRwUVRwQitqWXNZVFd5RmRFbk4yYUkydHFncjh4R09sK094NzY5?=
 =?utf-8?B?QktTSGJHdnZ3VW10bDNnTmdHVENvYzNtS1pmcGVuSEY3UFZmdEdIMU5Gb2Vn?=
 =?utf-8?B?eWxHSUxjTlJSTkZDR09Td1NvSGxrRHJHdFFlWkthd1Iwcnd3cXZaMDdsR1Iy?=
 =?utf-8?B?Y0pPWm8wUERDeWpzbkFQbWZXcWVrblBGbWNFWjMwL0d0Q2o2WGNMaysvTFI2?=
 =?utf-8?B?ZVI5eHdlN0tVWU5iZlFJdXpKbVQyd3lnc3A1cjZNK2RMYUpTUENPaS85ZjM4?=
 =?utf-8?B?Q3p1bnhlOXVTSDNBR3pWUC9nUUY0aGF4dG1taTZyRnVsWDloQ2xDcitTVlcr?=
 =?utf-8?B?ckxnSUxFMGkvaGNGYUtvZ3pZa3ZXWXhTeW5VUGNwRWZERXJHVTZocHpVYVJo?=
 =?utf-8?B?b3BvUnhHRVpMS3lHd3Bzb1Nzby9tRjlEbzlXaXhoL1JKWmh2QWRoMHJYOTFT?=
 =?utf-8?B?NjFqcW5xMVJmOVhQdkZCb0VnbnBVOEZNNnQ1a3NuRGdaYU5KSGhHRmZUNEZ5?=
 =?utf-8?B?NjNPMGs2b3YyR09xdHRtazUrcTlWa1N1V3ZReUp0M3lWLzR2dWZIbU1sQTZs?=
 =?utf-8?B?L0dBU1h3TzFTeDNrTlpHbVY5YTQvYmFCMWp5dGorWjBsdzZZdkI2Ti8wazlE?=
 =?utf-8?B?MENJTHNLWEJ0N3dnTTRObVFjYWphRlBldXZTdTkvWkFBVGNrNzQxUUN6ZjRI?=
 =?utf-8?B?RXo2bnRRSmM2cnd4N1EweHQrNEtYd1F4SElOcGozZUNZYmNsRVZVaHlJMko5?=
 =?utf-8?B?VGo2dC9FV2Vzbi9FQ0dqTVNpNGRLTjRFOHJrK2IwWEhxZkhMVTNBbnJSZlh5?=
 =?utf-8?B?YXdQNDdya1BUaUgzVFpsZUFPMmZ2MWhQMlVzendkc1hLdnBXS3drZXBxeW13?=
 =?utf-8?B?RWkwSmZmdGY0ODROYW56dTJJbG1rZDZxenpwYnZMRzdGSUFqTkVmOFJVenY5?=
 =?utf-8?Q?JOzxLMG1LqlfxiH8=3D?=
X-Exchange-RoutingPolicyChecked: Y+8JnojObjsAZVtSToI4qKObu8dVnyel4WIB6OIDRaZh2tw4WEDg9LWM9QRXutPXBsNDJ8RwuK+UAXrQHoXSmsmO9xLthtlhpirtY+pdPoCazqLqxL8ST1cKCHijUGr4HgrF/NiRDtZVQ0I4gtBbgCFNCx4+hI10vIswlO77mYVEacj9ha9JboE7ffR8W0tAwLvxc9M5ztiE9CTL27wMaIo+6j/mqnBmvaI6LcoNvPqFY1GbTdA+t83PKMXV7fai4jpzlfDRBB77OcJkJ10lXVnqfRLHJB0+nP2V4Xvx4T5kvwxFMXQY6zr58y6tW8/CB/0KNcrheiWvIIrNCsksdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab21406-2da2-4e71-bb4d-08df1ae92349
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:41:13.3149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52HOJQYzF1l4UYx/U0K8kaaxXQvy+0X5sQbx5I7SZFmVK/lk//UJLJLsXgNc9nfeLjQlE9JovFstIXh4zO0b0VU/O5g/Ae6e/Zvqu3c+vBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9931
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

On 9/14/2026 5:45 PM, Bruce Richardson wrote:
> The field offset argument type inside ice driver is of "int" type, but
> when parsing and storing the value from a devarg, a uint8_t type is
> used, leading to 3 bytes being potentially uninitialized. Fix this by
> storing to an int type instead.
> 
> Bugzilla ID: 2038
> Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Note: this fix is superceded by the kvargs numeric args patchset [1].
> However, that patchset relies on new kvargs features unlikely to be
> backported, so this standalone fix is useful for backporting or if the
> whole other set doesn't make the 26.11 release.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=39247
> ---


Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
