Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A4BC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 12:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C3C44026D;
	Mon, 31 Aug 2026 14:11:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8FAC04025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 14:11:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788178271; x=1819714271;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LMtsrCYkfG0VUvmp6oZbM5ELBd8krnhJrcPvbyAKpTY=;
 b=J5A+5YDedDGRr0lhmQpXrL5kLdQ9rj+GZ2Ea31Qtq90Yhsf88rS9rXzU
 6D5pADmKD9S3HaApgj5FoPjAv+9cVUY81MLXNzsFtboRx+vbLLC373nj+
 ryE8r+Hb4rVxDNSH9LI78u6As3PKqNpgRC60tPF0NNJRVJ4VZjtThxupF
 fLVrvdZJELHFcvayCb7rsNak+oJeMX/3leA7yE386cHbb08M/isTVZ6n/
 w5j5HHV2HS0XS7QDkUYgKpLju/oIq8cNfkrhCy6Kj+fjDlHDUDfp/V2hl
 W2aKQVZkPvddMYGGMslEUqTWHUkdEIumLvqzDk8D9niEYP3cwPjt/vZhM Q==;
X-CSE-ConnectionGUID: fz/z9PRBRkuUYb4j5HL6qg==
X-CSE-MsgGUID: l9dWh6omRZ6ohfn0itxKLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92272169"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="92272169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:11:10 -0700
X-CSE-ConnectionGUID: otWDFBdrSdCf7OJvKfyj8Q==
X-CSE-MsgGUID: Zx8YeKxJRIqOHxmoH2XjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="268223152"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:11:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 05:11:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 05:11:10 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 05:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkGVpBFgBCcXO8+GCvMW9ROlkLDyz/M82kALnZ91XQfpczHo6M7zqzu6+uIX+CXOkX794fhQVjV7N3YbUxZxHJJQ19PlbOhdBWJRaMSPS3DGLWbSsE+hkLUjNxfzv6wjB+dArn2aVpTlWkB6T3I5T0DBS95ty1Ha/LWvJPhBztoXB/yDAloONr92ioFD0fpSXrcCFUldJjJ+85XDe4twoUMSxVM7yLVmyYzGDRwxuTpvnuMBTlrRkXqZy5fP0dB/99oyp0BfO8hBUG6UfZQUREZkz4CBP+4aeTN/akSPPG1OV9BweiH2b3zOhVsxg/ThVN2u1e3u9fsELegNCJGHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d874og7RcIcnkGNldZqPTuWIlBWENF8LouI/zevx8l0=;
 b=hmuKAznJrLlJbSa4XrdeAqdSTgnFM4c2mpPoteFmMJLe9ZyYxxPA6898stCWJjLHFhGNcdNns8TL3qMBjAENp1/Z/Eoa5xstlUYHXGQZQ5cWqyA6plPf7Uc7Y5ebRdi+tQ2XtxuSgS/+VZVK29losF9+zrdGRKQlgD3hDV4MHxjXhqTzfohhsQ99TqpaX7a19uaIYo6mARuUFvYl3kfdphQqYMqle3hJ7ePtr3PZ2rgOGoFWsQTCmh+Rvq7pX+Nwv6ubG5WMHDpy3No6GLL9SIShRI7wdAOkzfNvmaAOrkUhZ2Vdi3/cpOVKMFOuky2WMS54yVcpVcrR1RPaM0mzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:11:06 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:11:05 +0000
Message-ID: <8bc07711-804c-4737-acb4-6d16569bc0aa@intel.com>
Date: Mon, 31 Aug 2026 13:11:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] crypto/qat: advertise RSA padding capabilities
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <gmuthukrishn@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260831102328.2813604-6-ssarananaga@marvell.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260831102328.2813604-6-ssarananaga@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::10) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 757215a0-3072-4219-bed4-08df0758eeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: BO3/pNZE4wHzyPhrV4j6A7yX5N2SO+eEYufpfz0FBTyiHR9ccW4IUs+3OPYQnf/LgwjpfvMxP1yu8EmcftzmlrmuCjcTs9FbXScloF3s4eMw39UVFca/0E5mjZZSaVrb8D1+a1TaGgueQ0o666UY2hzfls4ScpsuFnaK4U5DOBVarvueV5gOP0ZnTpgZf7UtdmNjyshBsZlqyZoMwvm9IfuXeNE1ar83olkuWoOqVsLwd0hMUmLOu0Jczwk6tzmwkePkuQoki0E7Pjb5CglgvpIsyEsAo/hmEEY7CTjwcAC5aKauLUsayRJ9tmKTo+MwutXN2Re9uapdGjqgk1JnEtPkyzH1nWRLo0h9nW8A4+T43JCG+WdOUPAQSLxDDxZHp3pgEDAo4aP9gKK5+K1Nw4+H4I4NFj2B1RoddZZb5cDkMI+M6IOoB3iv3bZE48m6xX8t9JdJz9s7jRIYfM8gdzoepgknCV3JZKoVfLFvOyiJvsk2JmgiL6DO2+Y0bT+vLuNx3SSlVQibvHi441MBRiKbpNmKvIyPyx9fY3brh+rqTfXMI8zyT0Leecjd0mKy6Qn5oxPIIAw3YONM3U+HFl/NZS/9wliB+kjglooYn/1ThdflhnuiK6pOMnn4AcMUZbGdpwhKKYA3nkeya95niSfFMbSWt2w9G/dRVutcDHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdtSkovMHNHdFB2cndOWERFZXFCNFA2TUxtZVlWNkM1c1BLRmhZK2RnTDE4?=
 =?utf-8?B?QW1wbnhDd2M0WlBndFErYUthWlR3UFlOK3BOSmlZWDJvMGt1NHcwc1JQMmZB?=
 =?utf-8?B?NlVrMjhQNTA5cmt3ajN1ZFhRWmo4TVZkMWgvL0o1UnU3OTJmNHY1Ukp4NC9u?=
 =?utf-8?B?TGFSblREeGJpNkdzNzlWV0FidVZMY1l2cUhaQjJDb3loaktNbTkrdC9uendq?=
 =?utf-8?B?MGZiOThZVTBNR1BrczdISkVSRVlFTE1tZ3VwOXNaVlZIcFVXNnN2N2NOc2dp?=
 =?utf-8?B?S2xtU2JBSFRScEVoMXhwemhyU2RZM3BwVjZHcjBuZ1lhZWNDbC9YcnNVV1kv?=
 =?utf-8?B?VURKYWFBbjBPMW9COEFWcHowQ09wZ01sK0x3VXhOWUo4RFdoOGZ6ZXVFYlNz?=
 =?utf-8?B?bDdBWms2U0w2SW5GOW54dHJDYVg5L1JOWUgvUW9rMm5qdE11SkJycGgzVXZY?=
 =?utf-8?B?WUM0OE1KTXVvMElkUFdrWHhtclErRnlTV3RLeXQvZXhvQ0hBWjEyckFUcjNF?=
 =?utf-8?B?ZjBLeHIyRmo3a3c0SWVkOUxUY2NKZFZLWjQ5WitvMXA4dVZzTURXV002WXhL?=
 =?utf-8?B?YTdnSFdrYlQvZ29paHJsTW1ZQzN6TWJKU29LaG5KM3Z2czdlSkJzdXl6d0hR?=
 =?utf-8?B?YXBmV28wUjA3UDNhQXN1dnVYeTdCYnJmTXFKbVdobm5jMUdmMmwxajArMXVn?=
 =?utf-8?B?bFFxT0ZtMHF4N3BqaWdQdUhEU2JzQm5DeWdWSGpPVDNJTWw2RmZic3lrdlk0?=
 =?utf-8?B?dDBCUVBIaEhSbmZBM2xQakRXWVRORjJOTU9GbWtxYTR6VkFCdE8weCtSS01m?=
 =?utf-8?B?M2RSaEZoVm8zMlRZOTJET3B3VjNPNllDVFAyRXRuZnYyZGc2dGdVTCtFN29a?=
 =?utf-8?B?R2hVYXhXYWtMTmZFSGhzcS9xRDl4M1dSY3RmUXNINWN4QUFWbEdZaEpMczJ5?=
 =?utf-8?B?bDBpb0svM2I0aVp3eGJlTnVkSk5JbHJXSklYSXg0SVp6d3l6aU9EOXpWTE9i?=
 =?utf-8?B?YkszWU1EQm9TTjVYVmNDUkFnSy95Nnh3N2MyWkd3cG9wK042YitCamlzN2Jp?=
 =?utf-8?B?VE14d000OHlFWVZLMGtGSGlMa1BKdE5MTk1zQ2d2NzBpV0lJbUx4M29Wa01K?=
 =?utf-8?B?bUM2UncvZk5GTVRMSTN2djBzWGNER0srQllGYTlNby9TZk9UZjlnYW5GaFRH?=
 =?utf-8?B?Mm5pT3BIRmNGN3ZmVlR2dHpqY3VVZWpyZ0pKa0J2U0tybzJVaFBLL0tPMXVE?=
 =?utf-8?B?TUY1RElpa1FySUltK3lScTYzcHZjQkZLaC80LzJqbzRURThpTG1iMmU4UWJZ?=
 =?utf-8?B?bVBodk82S29mUmV3bGk2bWlaTzRkRTF6ZnZvMW1yWS8yQUNoOSt4SXdvMk43?=
 =?utf-8?B?em9kQ0cyU0dUZ1UxRmZJMXZ4a2k5Z0tIWVZieUNZNzgwa0JzeDdHcktRSlJp?=
 =?utf-8?B?dmU5OUxKRzQ5TEN4VVVZTWhxcVhCcW1xRjZXS0MwNW1mVEVTcmJlZnpUMkNm?=
 =?utf-8?B?eElzN2srYVZOaktNTG1DY00zRUJCYm9NWWQ4Qjcvemp3ZmVwWWU5OHl4QThU?=
 =?utf-8?B?RUdVeUtwZWdvOU1MN2g0YUJlSmZoeWZGc0JYTmhNejlDcEp5QmJWZXF6T1hW?=
 =?utf-8?B?dmpSV09QL1p6TUgya21kYkxMeFZvVGVDWlRObTd0R015NnEwbzJSZ3IzSTd1?=
 =?utf-8?B?eGdsUWsxUHlqeWRLZWtrRXlHa3Qwa1o0L1hmVUg5TVhDK2dSL3ltNmdYK29x?=
 =?utf-8?B?YXdlS1YyU0xueVk4ZHV5UjI4T0RzL3ZySnMxOFpnT0pUeVhtamVSenRHbElj?=
 =?utf-8?B?WkFTTkF6b01qSUMwOHI1QUpjcVd1c2d2bGc3S3FTTURUbmNZczJNVW5RQUVZ?=
 =?utf-8?B?WjVaVXNpR29JZ0VlU0VoMHpNVllaWUx1Lzk0QllmRWt1cGJncksrbm9uWWNv?=
 =?utf-8?B?dHhMQkgyV2pwck9GNU5KejZJZ0FuUDBtWlZYK3dPS05ZZDNKNGhpRG1XS0RE?=
 =?utf-8?B?TFpha3IvYm8rS3dXZkdIYmdTNm53c08xTlBnd2hzeDlxMkxBOHp4eHF6Rk1k?=
 =?utf-8?B?TnEzUlRhbTAyVU9nY3NZd04zcmtDNDNXVHBJTU9zbXdWeXk3Q2dTZlQ2WkM4?=
 =?utf-8?B?R0pMMXlYbFJTOUdrUTdIRjlSUUF1OEZ2S1ZObk5BcUgyRlBhRVpKSDFFSnEv?=
 =?utf-8?B?T3JLYzdJN3pJRzlmcWcrNHhnQXloWnVxOHRmQ04zQndrdmxWM3RPR2JpVnZT?=
 =?utf-8?B?enVENFovZ3lDV0ZCQzl5MTFPRm5jUkh4TWNJYno2RUtRWG5LT09oY1lhU0NB?=
 =?utf-8?B?aXMySlNBK0lVQ0VVTG5rNEpiV3RDV3ovQ1lxT1JaK1pwVnBhWnM3QT09?=
X-Exchange-RoutingPolicyChecked: 39OqhrFmTBJs+SjclFOMOkzbWLlI0igGJjSNXn0y8XEvvHypU7eojjsnLzZAcmSWqyT5SAbJmpLay3tJwZFsSzfsnth9Gr89Q2KLd+5pOTQE9iPvZi3+XXO78R5/ZOpGBrzGHZPpaZmqE+0ZhY0nfkasoGsPr+7V/DsxaUlB12V8D1y2XecPVQIWbsJNy6cEnAG0eoJCIXRlMcZMjSfv+tFD4bTWJ5Cq93yHxrsgSKIKTC/hJffKhM3B6/k9gsZ5tTpT7nEJ297Z1YETCUAPDTX7ivxzsp3gs2IXgVyVfSoC+veC7wSPwrU/bUoE3MvStsK4JWicHBbcOlhM4gXYUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 757215a0-3072-4219-bed4-08df0758eeed
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:11:05.8534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj3gbl+9PLqvuWS6OWiHlXLOjElA6Nb1aqF2XSrw1YIc3sT45BXkhjeQmkprPCcmrAF/+w++BPuup5hyso3KXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
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


On 31-Aug-26 11:23 AM, Sucharitha Sarananaga wrote:
> Add QAT_ASYM_RSA_CAP macro to report RSA asymmetric capabilities
> using rsa_capa, including modulus length and padding schemes.
>
> Update Gen1 and Gen4 QAT asymmetric PMDs to advertise
> RTE_CRYPTO_RSA_PADDING_NONE via pad_types, matching the padding
> mode supported by the QAT RSA implementation.
>
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> ---
>   drivers/crypto/qat/asym/qat_asym.h           | 20 ++++++++++++++++++++
>   drivers/crypto/qat/dev/qat_asym_pmd_gen1.c   |  5 +++--
>   drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c |  5 +++--
>   3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/crypto/qat/asym/qat_asym.h b/drivers/crypto/qat/asym/qat_asym.h
> index 0ecbc47548..cf40d445df 100644
> --- a/drivers/crypto/qat/asym/qat_asym.h
> +++ b/drivers/crypto/qat/asym/qat_asym.h
> @@ -56,6 +56,26 @@ typedef uint64_t large_int_ptr;
>   		}							\
>   	}
>   
> +#define QAT_ASYM_RSA_CAP(o, l, r, i, p)					\
> +	{								\
> +		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,			\
> +		{.asym = {						\
> +			.xform_capa = {					\
> +				.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA, \
> +				.op_types = o,				\
> +				.rsa_capa = {				\
> +				.modlen = {				\
> +				.min = l,				\
> +				.max = r,				\
> +				.increment = i				\
> +				},					\
> +				.pad_types = p,				\
> +				},					\
> +			}						\
> +		},							\
> +		}							\
> +	}
> +
>   struct __rte_aligned(8) qat_asym_op_cookie {
>   	uint64_t error;
>   	uint32_t alg_bytesize; /* Bytesize of algorithm */
> diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
> index c96608dd37..5b93cf374b 100644
> --- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
> +++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
> @@ -32,12 +32,13 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen1[] = {
>   		0, 1, 512, 1),
>   	QAT_ASYM_CAP(MODINV,
>   		0, 1, 512, 1),
> -	QAT_ASYM_CAP(RSA,
> +	QAT_ASYM_RSA_CAP(
>   			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
>   			(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
>   			(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
>   			(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
> -			64, 512, 64),
> +			64, 512, 64,
> +			(1 << RTE_CRYPTO_RSA_PADDING_NONE)),
>   	QAT_ASYM_CAP(ECDH,
>   			((1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
>   			(1 << RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
> diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
> index 41cad29142..106c512a06 100644
> --- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
> +++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
> @@ -121,12 +121,13 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] = {
>   		0, 1, 512, 1),
>   	QAT_ASYM_CAP(MODINV,
>   		0, 1, 512, 1),
> -	QAT_ASYM_CAP(RSA,
> +	QAT_ASYM_RSA_CAP(
>   			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
>   			(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
>   			(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
>   			(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
> -			64, 512, 64),
> +			64, 512, 64,
> +			(1 << RTE_CRYPTO_RSA_PADDING_NONE)),
>   	{	/* SM2 */
>   		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
>   		{.asym = {.pad_types

These changes are not needed, pad_types field will still be zero.


