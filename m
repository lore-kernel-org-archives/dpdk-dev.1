Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEAA1098786
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E81D740430;
	Fri, 20 Mar 2026 15:01:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 3130A402B2;
 Fri, 20 Mar 2026 15:01:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774015281; x=1805551281;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lJWMBLEkIGBWNzaCPZSCt2+NWCcgZ4pnbegZ28DPbr4=;
 b=ak6+myZG8ZdoH+poHhOi2qIA6IKiXbEVqMYKyR4yXmvjflDN3lPhWC7V
 1C36racGfmbONCvn9FQc+b1vBZvvcL01umWpyCXUMhFuzA9GuyL/WgcxT
 vG6dtKrPIyDBQDGP/mVsE1vSSzBDLStNzVRV16zoOCxdJeOlBvNBlL9a2
 LO5g+sOSUsvV4ShDCCkJ3S7wdkiBzCOxRloufzf41263VAtYuIN9tEiwn
 1oWOxf1b5Fg1gkxBlak4VcZXrOUxL7h3ynHGnNfVMDjA56cVzgPgI2+OJ
 ADG0qKvNNZ16gjgsj6k4hslGU+k7SfpozZIIPc9W3llNzCZfiMMZYj1eD Q==;
X-CSE-ConnectionGUID: mUUPXK5CRGqVkPHqwrV8tw==
X-CSE-MsgGUID: hy7i3jBtS3i90sF1z/59nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="100553788"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100553788"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:01:20 -0700
X-CSE-ConnectionGUID: LA9rxW2tQ3SUbYwJoydPew==
X-CSE-MsgGUID: Uf+g3K9EQIKC0yYOxWmPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="220630655"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:01:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:01:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:01:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IG9UWsX0cb5SGQwXV7OuoM+AqDSdA0t7XrrSqnEzmuwmDfdzP+OIZRQHOJzZiZwulWlKiHqXSRMRX8tePI/bSvimhgio5GplEIyVSUROUHXryW4Pp2ERfTvheGHICDuKygKQlwe0YiPH/q368bfSAmhw7VusgzIM+i2agBptJEJljNWqp8e7jZun26KlYNvzeFuW3VxSOJXegWHeYeC3bfRkdjAS3VjCua33ZRB7l5KSbC1r4jkew9H+w1kPRscJZgw1Zdvcjd3ocSLg8WtwsPCi5puzR39yCqGyAMXhbR8K1r/Rb9y9IIZu352ZusGFMYB9YxZZmnvRlIMx+UsyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG6jKtlFPUvC5VzXhxsjEKLVX/fNt1j4IeSMQH5qe4E=;
 b=C1ZOBOrAEJA/VajfpevuM+Dncc4elTsMXgKxbtOq9aaRDWiGOxN/ztdTvZitpOaGMMKVmh0Ir6VW68XZrfGoMZEJXQUuzTs4u5EqId7VViHnCKhIePjswiVhyRFsnbpDN7GeVEy1WfhAgR/AXsCQrUa3jJNudHs572ugKjptIm54AtzpW5wuUEycK9uCifhMy2m+S/SIihIA22gDcSeHe5XeHd6hrvW6qplr9vk4XHk5xTTuAJqVqXUkzfG/8m6q6QHGtXAxqhpmGh3Ou/+N6Yal8aWQSxPaNVajn6Fij+qD8UctALAThkSGK4hw2qBxZTErlpzdwXi9qaBzfIanNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 14:01:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 14:01:15 +0000
Message-ID: <f607e8be-c863-4be1-b7c0-90068b403626@intel.com>
Date: Fri, 20 Mar 2026 15:01:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] test/interrupts: skip test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>, <david.marchand@redhat.com>, 
 <stable@dpdk.org>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-7-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260319171334.1151425-7-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 403b069c-e839-4465-c9fb-08de868926e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: NHXq0Z52zyukWeYJ3DOeBWshgNOUMFBiQBsP3NmJ/AvjioC1cdn1qHHc2DnHn6zQLqJ3ddNXemiHGp/fHsbSyGvvPTSDbZoLoopTxsW13moclfRWUoMhD9DtNGufvqZW0nIp/SfQF6phacH7ZaW7XKBFZeYzrlz8d1JoI5nTtZZDwmBvJ3tnX+PgQ2ojRISDwwOrG1j8SoCZlF/C/2KwHESGquhe6ufzO2ffayht5+YzG4VAlkB41xh+XJwCXSYgkeDRAIbHFqFkJurl/JCPdEwgVYs9Jr01VYHC9gk4O7Jpw623Zje5vjmbei3z53kIMLfaPU3iTv2LauUsB4Mle4pNl+UD6RsESdgS1gr0gKK/kvtAi/z6NNlohEWNeJMPKC0mtGhGq8dCzd83uKSLNfjzSdxVafRpBJwI+0R9PZtq8gL4+OqwqnOVLd1UT30sRdDsaS1x8ngpnOhnKY+WIf3S1zzA60JsYHmDm7SZ7v0TrpExiuA/xQs9939QxuEjDEXEHVQo8S7X873hPTAzsyZqFEMbnGvBOrhoc18aJCyNxjnbNUa8XlMrdrpdVZw0Ku+GNsThtzjcg6F5iNjyU3e17I33BvtV/C5fHlgDKGXY+ko7pDZdrfYDwQHV+YhS9qKl5PSCFZ1clDgiHNBNHEtkfDbrHJ4ienaNAfpxj61qQkX2k7S50rm+sXPS1/sDmmrJhI2aBzIH/dtLb4ckdF9A/VkhWJ+GHHx3CaK/+HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9HbTIyY0Nra1F2bS81N1RZZzY3YXp5aHlkNklFai9MZXF2ak9ZL1orR3NU?=
 =?utf-8?B?ejVyY2Y5WnVnalBQeC94K1d6MmcwVldIaTROTnVISENqOUcyWlRWbHc1amNs?=
 =?utf-8?B?OUZLeDYvTTBMcHNOUDdjVmNoOVh3RWozM3J3RExuc3dWZWxzUzVuZzgvaGlj?=
 =?utf-8?B?cWZSRHZPYS94ZUQvU2JhZDE2ZSttQ1VlQk9lay9ON21pQnY5MnFwZXRTSXNh?=
 =?utf-8?B?a1hFOGhZSTNzR0NGcnEyQTg0a1owaS9KbVgxeW1uaWdJNXdsU3ZqdVhxYXhK?=
 =?utf-8?B?L09ncURBN0xJWFlMT0FSMkxUVnpPaWI2YUJJNmhUNEJiSmdIbWp0dzBOaDR2?=
 =?utf-8?B?dU9pL0dQU29KVDdBclNjK1V0d3BnTWxrejM4d2E2TDJaWlFiMlZ3YVBjUWRJ?=
 =?utf-8?B?bHI1cEFsSldRQUlGQkl5eWtCaFA3ajB6ZmFxUUl3UTBUKzN2Mkp5Q2dnSG5P?=
 =?utf-8?B?UXlLRzYrSk80YmxyNnFyODFkMTFpa29YNXpQenNKb1dLa1dySjBEM1QzOFJY?=
 =?utf-8?B?L1dKdXZDak12Q2R4ZVRCQlNhVHc2UEVUWk1NVDFiK2VGeTV0aFJ3SE1zN21O?=
 =?utf-8?B?VCttWGR3aTAweUdmajRDRzh6RWVmQVJ3TThOc3hmNTUzeWU4RkhHVzJNWTZn?=
 =?utf-8?B?WWxqY2toR3AzT25VUGpqSVVuamI4WFFDcG03TGxhZk5uNDB3UGVzdnlzV2JS?=
 =?utf-8?B?Uk4xZDV0N1l6dHZ1elE4djNOTTVka0ZCTUQ5Z2lrSjRjMXlKSFhvelZ6cDE4?=
 =?utf-8?B?N3F1TzQ5Q1dBeXhjWEE3SGg1TDhJMVF3WUVzRVdnRjZ6WVZCZTNrbmNKVXY1?=
 =?utf-8?B?VWZIb2tGZjZKK2lGSUp2aXFRU0plY3RsOGR5VGNaNlJIZldyWFlHZWlHQzYy?=
 =?utf-8?B?eW9NWG1OYVcwUnkyYkZHY3NrelhJTEhvZTVmOHNBNGVOY2xHQ2phaHMzQWFJ?=
 =?utf-8?B?UVhzc3FjdzRkN0prSjU3bWpETDVBdUIva3UyTTN3MjVmeFZOcWtZem9jK3Np?=
 =?utf-8?B?VGFsN1BBb05YMVhqc0huU3VLTmh1RnZraEM2RS96UjZUc3J5S0h5dzdhbjU1?=
 =?utf-8?B?TXVncTN4a09MY1B0eldyUCtsdnIwbGpEQnZQSlc0dEtHanFrV2NCSFdDSnZx?=
 =?utf-8?B?RG5pLzlURmcvbWZvaVZSbEFBZ3haelBKeGhTNHJ3SCt0YUloVlBGZFRUMlJw?=
 =?utf-8?B?b3hVbUtGSy93Y3A5RE9mVlRzeHA2N3d6WmJmaC9UQlAyY0pnNVF6dnlvNW1M?=
 =?utf-8?B?cmlnN1ZIR25ZSlVSaDRVbnRwckNnQ3lLTFFnaVV3c3ByeUlTa2NHZmhvSndD?=
 =?utf-8?B?clRzZWJrVDVDWUIwZWV0eU5QT093WHQ5Rlh0dHRtenlWcU93ZGtBdGU0TWh4?=
 =?utf-8?B?d0l5ZlFCVUQ5TFIvd3E0cDd6aEVoV0tTZ09GNmQyLzR2Z2IvVitRNno5YmpZ?=
 =?utf-8?B?TkZNL1o3SWs1L3AwbUpWb0ZPSEkxM1lmWVhBcFpIU2pHRithWGJ0aitYbDBI?=
 =?utf-8?B?UmlpOER5UkRXeTM1R0Z0YXJub2RTLzJjWVRPTDBZcmE2T1NwSGs4Y1phcTJu?=
 =?utf-8?B?WEN0U01XU0dxOWV4TWtReWFUZEI5WE9iaGcwSHZ5Rk5LS1pWaXJ1Vzd5RFVa?=
 =?utf-8?B?ODV4d2o0V3lNM2NWZG1GM0dER3VrMG8va0xpUDVVUUJUaDdxenJLY2dMUE5Q?=
 =?utf-8?B?THRwUGpMV2ozWS9QQkZYN3lOUk9LTElQV0UyQ2UzTllHcWtTMmY0Y1VZTFpZ?=
 =?utf-8?B?VG9EWlFuZzA2VytYaWlxNFNxM2EwQ0toRDE1UTRRQ0ErcUFHN3ZvUE9MVVpF?=
 =?utf-8?B?ZFlFN2xNZndWb2I2cE1MbnhSMkt5Mk1yTFBncU1QMStIdkkyMnhzQW9waE1Z?=
 =?utf-8?B?Mzd3bzlkblhwYVZyLzJLQ2RQU1pRQTZMUUN0bW1YVURpeG81b2ZiR2VXOXVY?=
 =?utf-8?B?YUlqc3F5NWh1bWkxWTljdm90N3BVMDExUFNRRVlqdk9jVHNKMHZyMURGWi82?=
 =?utf-8?B?SHFxUnVQZndDOTE1OUFYd0grYU5mWmlUQ0xzc1g0c2tHUUhXNVNwdk96ZTZk?=
 =?utf-8?B?NVFzWjU3eWhsM295dU9SYjc5eHNxdDU5bjB6Q1k0cSs4OHB2dGQ3MlJ1eldC?=
 =?utf-8?B?aTZvNGhHMmNBdVlIRlFBVFRTWFlrYnJZUmpCS04zR3U0T3FWUm1OK0NlSFpa?=
 =?utf-8?B?MDhPRE5MRTdTN0NTci9YVDVscHV3TjhIb0wrOVdMUThLQyt1c3JCaERJQUFZ?=
 =?utf-8?B?UWFpZkNtMHpOblJkb2J5QkRnakloK3BpNjRFOUpBdk8vdmlJV21iaUxUWVJj?=
 =?utf-8?B?ZzZsbTRpaTlKQnpHODVtNW1FWlNDMTZtQklMVzVXUHJaa2FLQUtCdmhzZFla?=
 =?utf-8?Q?OlmcXcrP81UrNFr0=3D?=
X-Exchange-RoutingPolicyChecked: sSRUMKEBf5OtksTDe5yy43bKQCTGDu83rHYoylqvjepYkNJnl5qR5gVSI9zWQeIDUSxXuD8vVWlwjWiAlapy3kUQcF2q00d1+8JSn8fflk5rb3ipwzY7N3Q0Ij/iG1EZTUp0ZEB8W2HBLVOAGG6/pr6HAHzMFi84mnGC/MQTL4o+6chGyVeu6UdM2zocEt4H7uWNc9EX81mMJmD8Uesk3CLW0eA3K5/wIDRvG6dr/b3cO0ra3n2NojjZ+wxJbTWNi0MxYushv7ScdIe/Azy9CGsbEU5MG5i0DTeX1dlf95XD2nw6fkFI7LrFnVBkHVZLHE6EBYQr0WYj2+uhVRce/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 403b069c-e839-4465-c9fb-08de868926e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:01:15.6082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apU7yC1yXMm7hbu/WCmL1jqewyV6ZdsbvUVZBMu66aSZQfZxFstBJz4FPVVsIRQy+h9jdQ0cWUgAhRYF2cYOLSceUZmY8+otjqE8H6a7iPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
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

On 3/19/2026 6:11 PM, Bruce Richardson wrote:
> FreeBSD does not have interrupt support for DPDK, so skip the test
> associated with that functionality.
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: 764bf26873b9 ("add FreeBSD support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   app/test/test_interrupts.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
> index 2eb876e65a..3a5be92cd7 100644
> --- a/app/test/test_interrupts.c
> +++ b/app/test/test_interrupts.c
> @@ -429,7 +429,7 @@ test_interrupt(void)
>   	int ret = -1;
>   	struct rte_intr_handle *test_intr_handle;
>   
> -	if (RTE_EXEC_ENV_IS_WINDOWS)
> +	if (RTE_EXEC_ENV_IS_WINDOWS || RTE_EXEC_ENV_IS_FREEBSD)
>   		return TEST_SKIPPED;
>   
>   	if (test_interrupt_init() < 0) {

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
