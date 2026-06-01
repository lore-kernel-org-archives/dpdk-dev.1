Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E85CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E704025F;
	Mon,  1 Jun 2026 11:21:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1666E4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780305715; x=1811841715;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jcU2LLKRuzG9AxiYmBGpNwBdEphxUIB+yxeB542oy/Q=;
 b=Un57v9+wUnndmzjuZ/w6N2faAGq8gSHgSIEizvHvtnrvqO5nUdQM8t0o
 vx44yiviIEaFSsC8rRfsTwwXgbKFdzDYD/sWt8hztZyMElITYeXrPZQaW
 ekXEpuirlKKUhuC62vZSOW+RqB6PZk0JkxRUwe6IKBslFB8ol60NBFQJC
 QHfLdu2P1UhqrRyiWczqonRLG2h+SK+9NwaTv9kUR4ffdjt6EkHnZh9Tc
 jpylhoRK4PnBOf4fTrUfVp5f87fuJWYiJxSROyscU2XoS+y3s+GKgZ04m
 0HSwy2BIH8k88Slnx8STrXA+BnH46twu+hrI9Byp4BapK0/oCk+ObIlp1 Q==;
X-CSE-ConnectionGUID: evJLBFiQRRiBzckJZOzpyQ==
X-CSE-MsgGUID: /h8L9cn2RIujCkKNeDVc+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="68594591"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="68594591"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:21:54 -0700
X-CSE-ConnectionGUID: HMzl/xdMRwKi65mKy3wdZg==
X-CSE-MsgGUID: NLhw1cNVQCCoMooAJXZGLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="239340024"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:21:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:21:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:21:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPwd+rjB9uNrPgxHeDBosQU9zNOkMU1G9EzCCnXRSeLwEKEE6scQrboOHsRMRIhOQ4XeKFZXLTKZ3PcqTzEHDYw3q/PIsAEA4m4b/7mEt88IDEK8cBa/1zwNLnZHz7N/ayh3VRpM514TMw9k+UBaov2bX7PwV8D02aPq0j37W+mRx4W3UT/A6ikaqCm1StfPPRtrAibLBrpY1w6VhYLpQ6OQstme/Z1aBSwzZgS/zHbBya2S2kmAOvKDOrU31ZMdj7BOSFMXTM+yS6lqP7jcgct6FgrUwqPEaEZ/FNSd+CdZ+LQIbROYXRZafwW5u6FXbWqv861i2xzJaD3qrhht2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHaQX2v1Hc7EyLKuLJlb+mGDovKTp094JWvPKEHisG4=;
 b=nQthMpAxXSTISuPTKHvtYAEodsIpCbYrwzqP/H56yfyGBn0M1kjN1v9HuRTt01D39A4omXWg7sbV18s1tziOV7dU0U6Tzkn1nqPEr2mYR74IwzrfTSSyqGd/43RwpzkiD7DxQNEHs1iyDdmXofEMoN4hVhou0xP9yG+KK504R36eocQogFeRYQcIOTxs6Y1WjhekYYSTvI8H7U1taZbUKpH/fBU9LGxWyHZp2wpSQZxGHykfCz61FPg/IHhoM1JsUaAONzUncNAspkjnzT+hi7hdN4iFRT4LW8NPfsZ9nTf5AU9rEyeRYug+lQ0bQCJQ8fQIv/M+dHg5/HxdLSwyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.17; Mon, 1 Jun 2026 09:21:46 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:21:46 +0000
Message-ID: <2415d1ee-7134-4678-824b-1a589a14014d@intel.com>
Date: Mon, 1 Jun 2026 11:21:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] eal/memory: add page size VA limits EAL parameter
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <968ab78a3f7bd130287e269dfe82a3481baab161.1773417833.git.anatoly.burakov@intel.com>
 <ahXHZx25kPDmjkMD@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <ahXHZx25kPDmjkMD@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0166.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 33949195-ee8f-48b8-56bb-08debfbf33bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ZLK44OYL6OHfMftHDBey2z+bNmp6ztrSuFWN40nghfAO1vmuifDM9UWrLVbOwS7Zy10NzEjeHf57FF89D1tF5SVGq7pGXPbQD6mMbS8Lu6kESxstWejNhOtZVqic+9SDsxnkDBJTpHhjXlgQohvxWesaARa9JVe5jzVqXfdwOxFw00wvMLG635kdwFKBbi4JTs1V9nvapYxW5zFFSyA4FfKZhQYOykKMvPFfHgrxtt9Lw40CkU/ImNMDaJH3H4PTxJs9KE7Xp1KwIuzJ38GY0B8/VJopQ7BxVrESPKmQNC9vK4iqV24uhe0kggQX6cXGf78lBBTeHMYt6XXgOGLvWvur2A3qkoKIKnOvqZoTEM6kgn9chHkazM/mT2wePE5p9eeH/FKUsRrmIixZsHEuAh++ShoCV+Rz4SgDSJburlluxE+5ZkiD9Ogp714pdyQDFP5oaJaOPLoeeMVquxJdh527aJZuCE9wlNhOVO52tZQ0A8pz/fnt4dqAFqpTmPOk7JaO/O1hdR/rourNAqq+iWxJRMka+sFuHuykSWkfRUr5QPAtrh3juS0TmVUurphg+sT3dy/EzI8kDwfSu+erjF3gVXPZbC0Ci4ZijwZOAR6wBFQh3q0x/BAnYSx5awbxhIkKJjUUJhE1XN5Gd0bzZcsShhv53e7XWS0K2EHLQYqh8lGUIGl40P6I6SEJ8D8R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzl4TlIwWCtBTUVTSGVCMytVR1QvaS9rNkJKcXRsNkFEeEoxZjQyaVMzb0V1?=
 =?utf-8?B?bWZDVy9yak1PYXlPcmFVdDc5M0M2amVsMkdsNURKRlVMS2FVbnBKbGRPYVM1?=
 =?utf-8?B?VVh0Tk1IdGQ3RFp2TGFITTYxV3pwalE2RHU5bmVPWG9oZ1pmOEo4WjQ1VTNM?=
 =?utf-8?B?YUpHYm9qblc5QllNbEpTcU8wVHE5RFNqNTVJT0t0bXhuSHZTcW9YZzJCZzZH?=
 =?utf-8?B?anZIczVuU1VCd0V1MmIrbm5zcXhuaDN4cklrWXQ0U0ZGLzZNVk16U28wMHMw?=
 =?utf-8?B?TGRHUjEyNkRBelRKQVpFRmFiL0ZlZm8ydDZ5MzVKWWdGclQ1TkNYbFQrVFJ2?=
 =?utf-8?B?Y1FDMm14QTl2REdGOE1JWHNkMTFVRkZKamJROEpxL05QekNXZjFGNXZRcXZG?=
 =?utf-8?B?a1p2YVo5YWwzcks2ODBZN1NxQWtxb2tyOXNIVVRIZWw1QVoxOWhVUnBScE5B?=
 =?utf-8?B?ZVBlemQwcEQ1ajA5dGlGL0EyT09YQXQ4SUJhN2ZrZTNaSTdRL1Q0UHFGMVYx?=
 =?utf-8?B?MCtvcTl6TEs4alpVaWVWNmRwd25oTUlYdWVJVi9wNmxGT1M2dFFJOE1qOFNH?=
 =?utf-8?B?MHZZOGZsalVTajZ3d2tyYTkvYk5teU1HZG8wdVA1QlN0OXQzdkpoUFJZemJ3?=
 =?utf-8?B?ZGhzUTAwREU5bjB6QStuMmhPODNiVlBwWlprZDNLZmIxTXMrVXZSUXFrY2E0?=
 =?utf-8?B?OTNyd0pRc3F3a3JSOEJYTy9RaG1Wa3NUYjRJRzVoajljSkNneFVOOUJ6Rlpj?=
 =?utf-8?B?YTFQQWRjRkNSWjNjZFFOSWV3Nmx2NnVLVDlsVmcxN0h1UVdIWFdTUVpwc2R3?=
 =?utf-8?B?RnQ5TmhXYzkyVU9JR2YrandmckZHS2ZDRUsrYWNOTnJCd1RpUU1mQUNObDVG?=
 =?utf-8?B?eTMxU0s4QmUrUnRxMTJHM29VaVJRNDVBNStoVkdxQ3RDMW1XdkI3azRQUGNq?=
 =?utf-8?B?VEw3dlQrWHVSVmFjak1KbzVlZExkaGdYUjgwT1Z6NHowVnlYMGY5THJodkM1?=
 =?utf-8?B?Wlpyc1lYancyai9ObytMM202L2IvbFRLVDhocS8vOTJ3OTl3OEx5dUc2THky?=
 =?utf-8?B?aUE4VmJWVk9qOGVOYkNGbzFqaU5oNzVPZWZyM2drNWhBcm84YTNZeGtiZWEv?=
 =?utf-8?B?MCtJZFRjU242MldyL3ZLKzRzUUdZM2NRczdlRTJ5RmV0ZDdqVjFKSE5BdzBy?=
 =?utf-8?B?eG1JRmhFSkdKMUFIR2k0NVExTkxNZGJkNlpNZHBWM0JzQXBTblF6TmMrczBT?=
 =?utf-8?B?TXVYYkUrVDA2REdWTFJ6SXZJZmtSTnhJZXlSbG1ZakNXOFNaTVZuZjQ0Nytz?=
 =?utf-8?B?R3dDSkJrY29Ua1ZtMFFqenc5TUEreGVFcUxPczA3V0dzQzZYeUlnV21CTXNj?=
 =?utf-8?B?Rjl4TmxaOGk0OEZJT0Zkb2I3MUVCV2kzeUoxamNuSTNkYnJ4ZS9wYnhCV08v?=
 =?utf-8?B?cW82TFlLR1EzbXRpNTN3Q3RLMlJqOXhUQUFxWEZnc05UZE9aRCszbkVZSmZN?=
 =?utf-8?B?RU1TNTR6UXg1aHdZeVNock9qb0t2Vy80dXJqZERKd2tBLzJiZjRpV2RUWnpP?=
 =?utf-8?B?bys1amQ0QUVGZ3JyVklVRVFFYzgrYW9ONTNPYlhualpBV0w1WTF4elFQb2xw?=
 =?utf-8?B?dG00c3Yyc2dOSVZYYXZFLzVHZXZxenIzeUQvWmEzbEZuVkVHdVlsZy9NbGtM?=
 =?utf-8?B?TFdodGhCWmtPV1VpcHRjVWFRSXBpTzA2ekFaaWNyMDkzR2w0NVBLQ1E0d0s2?=
 =?utf-8?B?ams2QzFlbkZLSEx6UE10WExKSXdNazg1RDJRRUs1WDUxWi93OFRIRzRRVmtj?=
 =?utf-8?B?VTl2R2lZdy9iL0lYMFZzUWV4SmZYTzZiMzhOR0N1a1NvM1B1VzlsQnN0Wkdp?=
 =?utf-8?B?c1E0L29ySjFKUDhxUXMveEF6UkdVOVVIcUdGVkkxSnF3c1V5L290S2JPa3dF?=
 =?utf-8?B?QitGalJRTXRRb2ZXbXZwTEhvRHRjY1ByWUdsYTNIK0x4OEVXN3VoekNiNUJW?=
 =?utf-8?B?Y1hBR3pnYjl4L3hFUFJkUmFDK0ZXRVh0K05TRHc4bmJrd3JnS09BelFjK09V?=
 =?utf-8?B?cHQvVG5HRnRSZCtrYlJKNytRSWFkbVdRNS9SOTBrMXI0OXlGVm51dkJKdEd1?=
 =?utf-8?B?bGhhQ1grU1lUam14TE91RUtHOWZCTCtYaWxhWlZ5ZWpFcEF6N0orTkNFbjZZ?=
 =?utf-8?B?L1ZhakhUcVpvWGE1UXRDZDZTOHRVR3VvczJKQkNUOFRuYWhoMHgvemtEcUkx?=
 =?utf-8?B?U3hLdHNBem5Ma3pKenB2aDQ3TEI4ZVdEWTlzUXlIZEphUXQva0VKc0RkeWlQ?=
 =?utf-8?B?cHFVTlk1U1NjWlJSTzZZWW1sWmx4eEMyMkNPN2RiSzNCdjIxUXRMTmVJUHZx?=
 =?utf-8?Q?3J8UcqKrx/UJaNHU=3D?=
X-Exchange-RoutingPolicyChecked: mjKEx+lvUsuSDegADqGwp6q424BNBFZiRoHJDsYbQKcGuidnb2492P4v+E5shRT2ZuyebQMI1KnRr0inHoHhBgxgm8xlgioBAiHJaF2FQbUbKzlPpmgPXEylvObvPq2r1m2sO2c4ZbTQqW1LHTvfiz5ZKw/qYQveZkA4XYkN+h0Jh956UzgDpTUPfBkUXD8MDySxVHQ2tjgDw3iU93/Cj2rxg8HE/RrvfD6RvY7hnUOzc4iSOFDsIqCGlLzZjB89Nfpj2Pztm3lF+ony4nVXXQu0gXI6GcsEFiMSwltsreEo9sm2fXxc1bKI46vQxvrze0fY5vw9C4vv7ND0eLBV9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33949195-ee8f-48b8-56bb-08debfbf33bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:21:46.2175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEsGsw1zz6v6KkZqmtbyNLZtdtAMeKg0C9+6kclLvv6VjgmKcl1hujoxOujT/RrODCLCa7tUj2lUSX1lPa10bEqCSIgKx6gNV8gFRWBpX+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
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

On 5/26/2026 6:16 PM, Bruce Richardson wrote:
> On Fri, Mar 13, 2026 at 04:06:37PM +0000, Anatoly Burakov wrote:
>> Currently, the VA space limits placed on DPDK memory are only informed by
>> the default configuration coming from `rte_config.h` file. Add an EAL flag
>> to specify per-page size memory limits explicitly, thereby overriding the
>> default VA space reservations.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> CI reports some errors with 32-bit builds. Also a couple of small comments
> inline below.
> 
> Thanks for the series, looks some nice simplification.
> 
>>   app/test/test.c                               |   1 +
>>   app/test/test_eal_flags.c                     | 126 ++++++++++++++++++
>>   doc/guides/linux_gsg/linux_eal_parameters.rst |  13 ++
>>   .../prog_guide/env_abstraction_layer.rst      |  27 +++-
>>   lib/eal/common/eal_common_dynmem.c            |   9 ++
>>   lib/eal/common/eal_common_options.c           | 121 +++++++++++++++++
>>   lib/eal/common/eal_internal_cfg.h             |   6 +
>>   lib/eal/common/eal_option_list.h              |   1 +
>>   8 files changed, 302 insertions(+), 2 deletions(-)
>>
>> diff --git a/app/test/test.c b/app/test/test.c
>> index 58ef52f312..c610c3588e 100644
>> --- a/app/test/test.c
>> +++ b/app/test/test.c
>> @@ -80,6 +80,7 @@ do_recursive_call(void)
>>   			{ "test_memory_flags", no_action },
>>   			{ "test_file_prefix", no_action },
>>   			{ "test_no_huge_flag", no_action },
>> +			{ "test_pagesz_mem_flags", no_action },
>>   			{ "test_panic", test_panic },
>>   			{ "test_exit", test_exit },
>>   #ifdef RTE_LIB_TIMER
>> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
>> index b3a8d0ae6f..4e1038be75 100644
>> --- a/app/test/test_eal_flags.c
>> +++ b/app/test/test_eal_flags.c
>> @@ -95,6 +95,14 @@ test_misc_flags(void)
>>   	return TEST_SKIPPED;
>>   }
>>   
>> +static int
>> +test_pagesz_mem_flags(void)
>> +{
>> +	printf("pagesz_mem_flags not supported on Windows, skipping test\n");
>> +	return TEST_SKIPPED;
>> +}
>> +
>> +
>>   #else
>>   
>>   #include <libgen.h>
>> @@ -1502,6 +1510,123 @@ populate_socket_mem_param(int num_sockets, const char *mem,
>>   	offset += written;
>>   }
>>   
>> +/*
>> + * Tests for correct handling of --pagesz-mem flag
>> + */
>> +static int
>> +test_pagesz_mem_flags(void)
>> +{
>> +#ifdef RTE_EXEC_ENV_FREEBSD
>> +	/* FreeBSD does not support --pagesz-mem */
>> +	return 0;
>> +#else
>> +	const char *in_memory = "--in-memory";
>> +
>> +	/* invalid: no value */
>> +	const char * const argv0[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem="};
>> +
>> +	/* invalid: no colon (missing limit) */
>> +	const char * const argv1[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M"};
>> +
>> +	/* invalid: colon present but limit is empty */
>> +	const char * const argv2[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:"};
>> +
>> +	/* invalid: limit not aligned to page size (3M is not a multiple of 2M) */
>> +	const char * const argv3[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:3M"};
>> +
>> +	/* invalid: garbage value */
>> +	const char * const argv4[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=garbage"};
>> +
>> +	/* invalid: garbage value */
>> +	const char * const argv5[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:garbage"};
>> +
>> +	/* invalid: --pagesz-mem combined with --no-huge */
>> +	const char * const argv6[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, no_huge, "--pagesz-mem=2M:2M"};
>> +
>> +	/* valid: single well-formed aligned pair */
>> +	const char * const argv7[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:64M"};
>> +
>> +	/* valid: multiple occurrences */
>> +	const char * const argv8[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory,
>> +			"--pagesz-mem=2M:64M", "--pagesz-mem=1K:8K"};
>> +
>> +	/* valid: fake page size set to zero (ignored but syntactically valid) */
>> +	const char * const argv9[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=1K:0"};
>> +
>> +	/* invalid: page size must be a power of two */
>> +	const char * const argv10[] = {prgname, eal_debug_logs, no_pci,
>> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=3M:6M"};
>> +
>> +	if (launch_proc(argv0) == 0) {
>> +		printf("Error (line %d) - process run ok with empty --pagesz-mem!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv1) == 0) {
>> +		printf("Error (line %d) - process run ok with --pagesz-mem missing colon!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv2) == 0) {
>> +		printf("Error (line %d) - process run ok with --pagesz-mem missing limit!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv3) == 0) {
>> +		printf("Error (line %d) - process run ok with --pagesz-mem unaligned limit!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv4) == 0) {
>> +		printf("Error (line %d) - process run ok with --pagesz-mem garbage value!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv5) == 0) {
>> +		printf("Error (line %d) - process run ok with --pagesz-mem garbage value!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv6) == 0) {
>> +		printf("Error (line %d) - process run ok with --pagesz-mem and --no-huge!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv7) != 0) {
>> +		printf("Error (line %d) - process failed with valid --pagesz-mem!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv8) != 0) {
>> +		printf("Error (line %d) - process failed with multiple valid --pagesz-mem!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv9) != 0) {
>> +		printf("Error (line %d) - process failed with --pagesz-mem zero limit!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +	if (launch_proc(argv10) == 0) {
>> +		printf("Error (line %d) - process run ok with non-power-of-two pagesz!\n",
>> +			__LINE__);
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +#endif /* !RTE_EXEC_ENV_FREEBSD */
>> +}
>> +
>>   /*
>>    * Tests for correct handling of -m and --socket-mem flags
>>    */
>> @@ -1683,5 +1808,6 @@ REGISTER_FAST_TEST(eal_flags_b_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invali
>>   REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_vdev_flag);
>>   REGISTER_FAST_TEST(eal_flags_r_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_r_flag);
>>   REGISTER_FAST_TEST(eal_flags_mem_autotest, NOHUGE_SKIP, ASAN_SKIP, test_memory_flags);
>> +REGISTER_FAST_TEST(eal_flags_pagesz_mem_autotest, NOHUGE_SKIP, ASAN_SKIP, test_pagesz_mem_flags);
>>   REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, NOHUGE_SKIP, ASAN_SKIP, test_file_prefix);
>>   REGISTER_FAST_TEST(eal_flags_misc_autotest, NOHUGE_SKIP, ASAN_SKIP, test_misc_flags);
>> diff --git a/doc/guides/linux_gsg/linux_eal_parameters.rst b/doc/guides/linux_gsg/linux_eal_parameters.rst
>> index 7c5b26ce26..ce38dd128a 100644
>> --- a/doc/guides/linux_gsg/linux_eal_parameters.rst
>> +++ b/doc/guides/linux_gsg/linux_eal_parameters.rst
>> @@ -75,6 +75,19 @@ Memory-related options
>>       Place a per-NUMA node upper limit on memory use (non-legacy memory mode only).
>>       0 will disable the limit for a particular NUMA node.
>>   
>> +*   ``--pagesz-mem <page size:limit>``
>> +
>> +    Set memory limit per hugepage size.
>> +    Each time the option is used, provide a single ``<pagesz>:<limit>`` pair;
>> +    repeat the option to specify additional page sizes.
>> +    Both values support K/M/G/T suffixes (for example ``2M:32G``).
>> +
>> +    The memory limit must be a multiple of page size.
>> +
>> +    For example::
>> +
>> +        --pagesz-mem 2M:32G --pagesz-mem 1G:512G
>> +
>>   *   ``--single-file-segments``
>>   
>>       Create fewer files in hugetlbfs (non-legacy mode only).
>> diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
>> index 63e0568afa..e2adf0a184 100644
>> --- a/doc/guides/prog_guide/env_abstraction_layer.rst
>> +++ b/doc/guides/prog_guide/env_abstraction_layer.rst
>> @@ -204,13 +204,36 @@ of virtual memory being preallocated at startup by editing the following config
>>   variables:
>>   
>>   * ``RTE_MAX_MEMSEG_LISTS`` controls how many segment lists can DPDK have
>> -* ``RTE_MAX_MEMSEG_PER_TYPE`` controls how many segments each memory type
>> +* ``RTE_MAX_MEMSEG_PER_TYPE`` sets the default number of segments each memory type
>>     can have (where "type" is defined as "page size + NUMA node" combination)
>> -* ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
>> +* ``RTE_MAX_MEM_MB_PER_TYPE`` sets the default amount of memory each
>>     memory type can address
>>   
>>   Normally, these options do not need to be changed.
>>   
>> +Runtime Override of Per-Page-Size Memory Limits
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +By default, DPDK uses compile-time configured limits for memory allocation per page size
>> +(as set by ``RTE_MAX_MEM_MB_PER_TYPE``).
>> +These limits apply uniformly across all NUMA nodes for a given page size.
>> +
>> +It is possible to override these defaults at runtime using the ``--pagesz-mem`` option,
>> +which allows specifying custom memory limits for each page size. This is useful when:
>> +
>> +* The default limits may be insufficient or excessive for your workload
>> +* You want to dedicate more memory to specific page sizes
>> +
>> +The ``--pagesz-mem`` option accepts exactly one ``<pagesz>:<limit>`` pair per
>> +occurrence, where ``pagesz`` is a page size (e.g., ``2M``, ``4M``, ``1G``)
>> +and ``limit`` is the maximum memory to reserve for that page size (e.g., ``64G``, ``512M``).
>> +Both values support standard binary suffixes (K, M, G, T).
>> +Memory limits must be aligned to their corresponding page size.
>> +
>> +Multiple page sizes can be specified by repeating the option::
>> +
>> +  --pagesz-mem 2M:64G --pagesz-mem 1G:512G
>> +
>>   .. note::
>>   
>>       Preallocated virtual memory is not to be confused with preallocated hugepage
>> diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
>> index c33fbdea6d..7096f46ff3 100644
>> --- a/lib/eal/common/eal_common_dynmem.c
>> +++ b/lib/eal/common/eal_common_dynmem.c
>> @@ -127,6 +127,11 @@ eal_dynmem_memseg_lists_init(void)
>>   		mem_va_len += type->mem_sz;
>>   	}
>>   
>> +	if (mem_va_len == 0) {
>> +		EAL_LOG(ERR, "No virtual memory will be reserved");
>> +		goto out;
>> +	}
>> +
>>   	mem_va_addr = eal_get_virtual_area(NULL, &mem_va_len,
>>   			mem_va_page_sz, 0, 0);
>>   	if (mem_va_addr == NULL) {
>> @@ -141,6 +146,10 @@ eal_dynmem_memseg_lists_init(void)
>>   		uint64_t pagesz;
>>   		int socket_id;
>>   
>> +		/* skip page sizes with zero memory limit */
>> +		if (type->n_segs == 0)
>> +			continue;
>> +
>>   		pagesz = type->page_sz;
>>   		socket_id = type->socket_id;
>>   
>> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
>> index bbc4427524..0532d27aaa 100644
>> --- a/lib/eal/common/eal_common_options.c
>> +++ b/lib/eal/common/eal_common_options.c
>> @@ -21,6 +21,7 @@
>>   #endif
>>   
>>   #include <rte_string_fns.h>
>> +#include <rte_common.h>
>>   #include <rte_eal.h>
>>   #include <rte_log.h>
>>   #include <rte_lcore.h>
>> @@ -233,6 +234,20 @@ eal_collate_args(int argc, char **argv)
>>   		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
>>   		return -1;
>>   	}
>> +#ifdef RTE_EXEC_ENV_FREEBSD
>> +	if (!TAILQ_EMPTY(&args.pagesz_mem)) {
>> +		EAL_LOG(ERR, "Option pagesz-mem is not supported on FreeBSD");
>> +		return -1;
>> +	}
>> +#endif
>> +	if (!TAILQ_EMPTY(&args.pagesz_mem) && args.no_huge) {
>> +		EAL_LOG(ERR, "Options pagesz-mem and no-huge can't be used at the same time");
>> +		return -1;
>> +	}
>> +	if (!TAILQ_EMPTY(&args.pagesz_mem) && args.legacy_mem) {
>> +		EAL_LOG(ERR, "Options pagesz-mem and legacy-mem can't be used at the same time");
>> +		return -1;
>> +	}
>>   
>>   	/* for non-list args, we can just check for zero/null values using macro */
>>   	if (CONFLICTING_OPTIONS(args, coremask, lcores) ||
>> @@ -511,7 +526,10 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
>>   				sizeof(internal_cfg->hugepage_info[0]));
>>   		internal_cfg->hugepage_info[i].lock_descriptor = -1;
>>   		internal_cfg->hugepage_mem_sz_limits[i] = 0;
>> +		internal_cfg->pagesz_mem_overrides[i].pagesz = 0;
>> +		internal_cfg->pagesz_mem_overrides[i].limit = 0;
>>   	}
>> +	internal_cfg->num_pagesz_mem_overrides = 0;
>>   	internal_cfg->base_virtaddr = 0;
>>   
>>   	/* if set to NONE, interrupt mode is determined automatically */
>> @@ -1867,6 +1885,96 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
>>   	return 0;
>>   }
>>   
>> +static int
>> +eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
>> +{
>> +	char strval_cpy[1024];
>> +	char *fields[3];
>> +	char *pagesz_str, *mem_str;
>> +	int arg_num;
>> +	int len;
>> +	unsigned int i;
>> +	uint64_t pagesz, mem_limit;
>> +	struct pagesz_mem_override *pmo;
>> +
>> +	len = strnlen(strval, 1024);
>> +	if (len >= 1024) {
>> +		EAL_LOG(ERR, "--pagesz-mem parameter is too long");
>> +		return -1;
>> +	}
>> +
>> +	rte_strlcpy(strval_cpy, strval, sizeof(strval_cpy));
>> +
>> +	/* parse exactly one pagesz:mem pair per --pagesz-mem option */
>> +	arg_num = rte_strsplit(strval_cpy, len, fields, RTE_DIM(fields), ':');
>> +	if (arg_num != 2 || fields[0][0] == '\0' || fields[1][0] == '\0') {
>> +		EAL_LOG(ERR, "--pagesz-mem parameter format is invalid, expected <pagesz>:<limit>");
>> +		return -1;
>> +	}
>> +	pagesz_str = fields[0];
>> +	mem_str = fields[1];
>> +
>> +	/* reject accidental multiple pairs in one option */
>> +	if (strchr(mem_str, ',') != NULL) {
>> +		EAL_LOG(ERR, "--pagesz-mem accepts one <pagesz>:<limit> pair per option");
>> +		return -1;
>> +	}
> 
> If multiple options are given, then the rte_strsplit should return >2 when
> splitting on ":". I'd suggest checking for the comma first, before even
> doing the strlcpy.
> 
The intention is to have exactly one pair in one option, so multiple 
options are not, um, an option. However, effectively there should *not* 
be commas anywhere in the string, so perhaps we can check for commas. 
However, *technically* there could be things other than commas, and they 
should really not have any effect on parsing except to trigger an error, 
so perhaps a specific check for comma is not needed as any deviation 
from `--pagesz-mem=A:B` will be invalid.

-- 
Thanks,
Anatoly
