Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC1C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D672402ED;
	Thu, 12 Jun 2025 13:16:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C37154021F
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726996; x=1781262996;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E1IaDMviRGxB/wmDQrMKDWWkcCrOzYEbCJUbrJkeSN8=;
 b=dFgzMymTa1o7X78LD+KmsYhlQQK5SNX33mpBI5f0VaW9ZVJY39sNXy8j
 RoNI1fu2g7ExQD+o0RbU357VTGjk67s3jJgbNED+LEBxrv8r0y3VJT4UR
 IaT2DTMXtYygEjzJVq8DtEKPG421PVkkhl9YbCpnM/TKHdUrfx5u6HLwX
 kibi9vHFhdJEpKe/Y8PWOizenFHLnCV8AChePzUj0PX724Y9bgpOWX5EU
 Fd47Q5Ls6wUYQ1DsUFY0N74U457CjLZMBSHyinAZA8pyt5NqCveOVghRT
 D8lKeEF6NZYU46lY20ophlLOy09e8mHMMlDQDC3ZGd1tQpRMHO68P9FZr w==;
X-CSE-ConnectionGUID: /Nvn/Jv1RDy009UXmqGRBg==
X-CSE-MsgGUID: Duc/5B7TQuKbGiDnPmUZlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62178217"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62178217"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:16:35 -0700
X-CSE-ConnectionGUID: rYNGlrAVSAOXojPZpMbSyg==
X-CSE-MsgGUID: PERm5O6kStePf3Z1/8OOPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147480433"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:16:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 04:16:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 04:16:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 04:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUdyUHSBbkeUE8VZdcyENY1HTg4aCmGVHlWVztd5/yPVwelEbvMO4MEutG2dTXARdpkXfEDTgkvnNb/rbI2NLY0tih6g0WPnfGwqUpr6HbC9pxsTGx1q9fHn2aeVAHN1uFFwl/izIIca1Mj0D5TbkaSRQxsHhnmOeIf/MgNvwTxscUYcw3QNLOGlJZj3rDL6M+fJDThRWKkVF6gb8dxv8V1WX+MKIASnDR3VyYYgyle51IbwiMSnLsESRi63Vz+22g16T84UhvtUPuGb8mAnp8uiNevGFzV/kC2L+q2jgvN/xRc7C3YAi9AA4fZHLooWw4FXSxltisACH2Ck9rkPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U+Sub8Dw94xSx7h0CeSmjIHxLrWJpMXzxkbIcEGqK8=;
 b=sbv6+e/O3//dsgvV6vVQGQMfatkYl9g4rxgt/weGbyFQGVePMMLBenPXY4Q+At95i/zJPtebQBRwb6siZj1E9WVwa6IQxPiIsUtIY5yl5Y5B8S/fSbTy7HmkcYbOdiBt4KMWM3gEjylS1ESBjwW1XVdy/SoAhRqAQ1goBi/Qf38Z/B/kJ+WOcA1gLnr+6/V3qJ8B3BYmT8xkZxR/eRPZSgab9Bt7UOHz13fsRLO9yIiiYqZNZveJM52ECV8FYfZz1o1pkra+Qg8SwkEd0C9wqRulHnswum4fD1yCHpsAPdqsdt6dI3r00k/KB1SYFVhTjHeJ6Qsu0FBnvuPRKUDIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Thu, 12 Jun
 2025 11:16:32 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 11:16:32 +0000
Message-ID: <ad35e64a-3b2c-4e38-b48e-85dbe354c304@intel.com>
Date: Thu, 12 Jun 2025 13:16:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net/e1000: better clock synchronization workaround
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Vitaly
 Lifshits" <vitaly.lifshits@intel.com>
References: <cover.1749464159.git.anatoly.burakov@intel.com>
 <1a8eb4a20513e1856bba0d6df25ce378aa8d7fae.1749464159.git.anatoly.burakov@intel.com>
 <20250609092310.0d19c68c@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250609092310.0d19c68c@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:10:be::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: eb798481-aad7-4d48-12a8-08dda9a2951a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmgrYjljZU4rTFVyakprQWN0WEtuYm0wNWVUUE0xRjhwTlZaRGFGcUhuSGJh?=
 =?utf-8?B?OEQwODlmQW9DNTZxM2krNmlGM0JtSEgyb20wSzRIQkppNWN4RmVnK3BUemlj?=
 =?utf-8?B?QlRlVmpJYm9rNnF4eW52ODZEUGdRSm1ucThmTkNCc0U2Z2VRdGRqVTFPb3Fx?=
 =?utf-8?B?d2N1S0Q1dU02VTMraEhOUkY1NURNUk9iM0lDU25OWnM1eGg3RlNEUm9UV1BM?=
 =?utf-8?B?elJPTGFYYWRXUUxINTlhOE9vcit4a05KSGtIdHdrL0dnZGVOSU80RStRZVo4?=
 =?utf-8?B?TWNLRzZZZXV5Vy9FQ3ozOWdwekIyWHd2MzJ3Ym9LK1pzVEtjOXZDYkZuVTBp?=
 =?utf-8?B?V1pBVnhvN2JYamxaeCtwV2I0RXJBMFo1NjJNNUpGbjVIcThrU3Z5bEZUUXFP?=
 =?utf-8?B?NkRZQmN4MFh0R3NTWGx5Ulphd0VZMzN3czRtZEtZRm1vMmtQZWNaYzh6Rmtv?=
 =?utf-8?B?WXRaWEt4TFN3ZGl0OVRmdjhuRGxYNmZlUWM4VkN0Z2c1OGVGemY4ZUZna1NS?=
 =?utf-8?B?OVN6N1JlRithUlF0S3RseUg5L0RDc3RBQU5zQUhVRWhYbjFyMEVCdXpZTGRp?=
 =?utf-8?B?dXRiaHZ4elpQcWc0Q2lMNEgzWlZIZVNtOVpWMTVMZkQwVkRMVFdiSHQwcjhS?=
 =?utf-8?B?b3M1ZC94WGQwUzd0OXQ5VGlQZFRJRkUzOXNQSlpaRTJLY2h5eDR0cHdDY1RQ?=
 =?utf-8?B?cURGY1c3eHEvM3RtRW43bGlmUCtzc2VISGo5NDl2b3hYdDk5YTJqT3FkWFVV?=
 =?utf-8?B?UkxPNEIzbDh4MXpSOXhNdUN3ZWNxN3hndUlOTFRLbERmVzR2ODZzeGtSZ0gr?=
 =?utf-8?B?T24rb2FreVduVzlCQVlHSzJxRmYyRUhYLzBYdmp3NTBORGtIbnNId0dIQ0Uv?=
 =?utf-8?B?VXROMEdzck1xczFLMDZJd3RzU3l2SWU3dUFCT0VzajEraHl1TlV0a3FlL1Vm?=
 =?utf-8?B?cEZTWUlwWURLeW4yWTJVbFByOHlhbFJuL1E2NSt3T29NbmR2WDNDcWg2SDZD?=
 =?utf-8?B?dlVEYTJ2cE5OaWIwZkdVeHhvMEx5OFoxRUlZWHljZ1pQQUZOM3BOS1VWeU1D?=
 =?utf-8?B?NEFHazJFamlNYUd1aHFQUjMxaWhSZEk3MFg4am5jRWhkeWh3OHN6dzNqR1Na?=
 =?utf-8?B?bGxiMEk2eGhXczhWN1FMdHdDSElWMlZZZ1NNU3V2aVpkUGMycDRpWFZlb0I4?=
 =?utf-8?B?QUNiUngyaVppKzd2ZXVkSWJGcFpXb3UyMG1NTTlRNmtnR2RzVlNTcTNOYk03?=
 =?utf-8?B?NnF4TTNybW9CdUMvc29PdFlac2RnQThENWpTRVNHVGtBRER0KzRTR2I5OHBw?=
 =?utf-8?B?dlBFZnk1Y0p0ZERLMllyY1dCck16NlN3azdFQTJMeGdEelpCNW1Ua1ZwSlhI?=
 =?utf-8?B?WlM5V2NlQTR3VGtMMTBHYWloa2YwZGRSWGdJdlFCSWZsanY3SGdKQmR5cHBR?=
 =?utf-8?B?dTBBOCtneHByMDVMMG82akZvbVQ2WUE0d2o2RWNUVGdYbVJTaTUxQm8rUC9J?=
 =?utf-8?B?SFJkZW1uWjY3YkYvUzN3eG9HdzhVWmU0SFBwL2xlUlBLVlNtdU1BaElRTjQ4?=
 =?utf-8?B?M2xCTTZ2M3pvZTFwakVnT2hJZWJwNGIweGxyWnFZZWJFR1hKZ2FIeDFVbHhS?=
 =?utf-8?B?ZHJqUDZPK2VxdGU4SGZreG9mZ0kwbndvdGRrcCtONUFqajNuaXJGbzBLU2JK?=
 =?utf-8?B?NnhpV1dtbnprQlFwekg0aDdscC82SEwvaGlBWFI4V0J1MHNXT1dZYXBsSVha?=
 =?utf-8?B?b1BmbnNaM0t2L3NkZks1VDNwTlE1VHZDRDM4ZnBReHhwK3FYZVhsNk04TmlB?=
 =?utf-8?B?U29GZjhnRURyU29yY3hzM0tsZ1JjeS9oczFTM3RSL1pNczNwcHZKa0x5UU02?=
 =?utf-8?B?TjVqMjRjKzRMRWhEcUNwUVFTSFdFK3lCSGIyWFlxRG5sZ3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHYyeVJsVWdKZ2hxUnh5OEkvMzA1S0Q2WjBtdmJNWWM0K2QvVzVHSmNhZkZy?=
 =?utf-8?B?Y21qMysvZjBsSHlsUVdmL2hSZG03TzA1Zm5aOUJGNWRFYm9RMnR0V2s5Nm5E?=
 =?utf-8?B?YmoyeE43OVc4clJVcVpNQVlRQXBQZDJTREJWVkRwQ0daMnRXSHNhY0R2K0li?=
 =?utf-8?B?Q0lVWjRSdEFlQ1A5ZU1xaURZajFkR2pkeUEvbzlhVGVZMG5BbFpXa0NYZU1D?=
 =?utf-8?B?V3pZQW5sTUV6WkFDVUsySU9NZC9wYjJ3VEx6Q0RjQzNtNVkwWTVDbzlQME1n?=
 =?utf-8?B?Z1FMRTRBWk5kUTBtSC9oN2VsSHY4MXFiVEpwZ0tIWE45cVptR3pzWXlRdkxR?=
 =?utf-8?B?YW1abjlRbmNzVk81MmV1cCtPL1AvWjhpallWOGlwL1JadTRpc2pNcDZmdWM4?=
 =?utf-8?B?ZERNOTEwN3VmaW45aHBza3VDNjFzNzc4dFlLRXZFTmN1N3ErTFcwVzVLZ3o3?=
 =?utf-8?B?bnJBQWRYMzZ4ODFLdVJQaTI3VXJaK1QvMTRUS2NkOHM2bXZLVTF0cis0QVpv?=
 =?utf-8?B?SkcxQ2xJS2wwYjJwKy92THNXMzJjU0lDUkN3YjduZHBOUnoxTXExb2RENTI1?=
 =?utf-8?B?SmN1L1d0STlPN05sUi9MdFpWNllzZDVFNDgzZFYxUjUzbHlZZzU2czlxTHd6?=
 =?utf-8?B?Q1h3MDNWd010Qi9nbjBrd0wwSGozTHN6YVNocVJHMlBKNU94WFFwN2k1WUtV?=
 =?utf-8?B?L25BU2VMSXMxM3VyYzI4ejBCWGJBakkrdG1xa0s4WVhhTmxEVjNDQWRNeXVr?=
 =?utf-8?B?WkxkSDBCMmpxRUEyeGNkUTZkaHl4U1FTbTFKUVNSNGVDcDJnQ1R0amxUWTZz?=
 =?utf-8?B?Y0NYNW13R1Z1eFNLd2NDNHlGRkUxa200QTdrYWFwc2s3VFI5eGhyQmpmT00y?=
 =?utf-8?B?REdNRHVyVndocEI1cmJoZ1RhS1NocHFzMzRWbFdVRzdTWmsvL1d6Ui9oYzBq?=
 =?utf-8?B?TW84Z0ZERnhIUUhyeTNyS3h0ZXVwcWF2Zm5yVjdjR1NCNkpWS3RpdzdpNGR4?=
 =?utf-8?B?bjVCUGkxZE1yM2J3UVFPbFF1aDR2aG1jUjF2ZkxBU2YxV20rZE5rdHQ0OTRB?=
 =?utf-8?B?aDBBRU45TE1OdkxTUUxsQ2EyR04vcTdBWUYwUXhjR2ZXaHduZ2k0VzJuaERC?=
 =?utf-8?B?WXVyaTVwQ3didDF1UWF6bmY3dXd6TnkwYUpKbkQ4aE5Jdno0WFNUWW9qTjhX?=
 =?utf-8?B?OTluOStVeTN4T2ZDSU8wY2doaVdLd2xJRkh3VjFQWG5ZSWZMV2JrSGo5T2Fp?=
 =?utf-8?B?T2puRDErMWxmWEY5VHFvbGRwdVVYdjlqSkQ0WlpnWG5BK0U4Q2hNekEwNzR0?=
 =?utf-8?B?cFRudXM0QllPd3hxM1p4amcyWUw3dHZJYkt2VHllQk55eUh5Mi8wZk1tYjVI?=
 =?utf-8?B?M1NVOUM1N0VaQnkvWUNxOHlhbDI1NUk4T0tFSmZjaGJMWFNsOHkrMXJDb1J1?=
 =?utf-8?B?aDZmTlFZanh5bkdkbVlLdlNrZzRBSTR5RGdmVnFZWjFvWVpEeXZ3MkVPM2NE?=
 =?utf-8?B?VWdQWjU3MnAvdjVpVzJ6L25BcG1Ickw3ZUZNZnAxUHhSNXJmSWtQd0ZCQmc1?=
 =?utf-8?B?MjRxT0h2a295RDQxNHM1akFENzUwM0JETU1xL1E0Y0wyVDlWY0lqdUZTZzd2?=
 =?utf-8?B?d1ZINFBGUU16VC9ERWdjanJHMEpydlAzY1VTVmsvU1lBWCtjd2s2d3VXTGhJ?=
 =?utf-8?B?OVJiMkw0MHYzb1ZtQlZSYW9FSTduU0QxYno4dnNlVHhFWHIybXkvWldMa3V0?=
 =?utf-8?B?NFZNdFV6TUVNTGZ6VjJha1R0K0pKeVY3R0VYMEVLc1NtdFg0UXNpTWYwckR4?=
 =?utf-8?B?NzdhWVk5ZFQrTWEvREZjY2xIYTAvM0dURmc4akVaalRUU3A5M2NKc2d2UE9h?=
 =?utf-8?B?aVg2RHQyYVlINEhLSHVyUHhPTGNtWk9HcnIxVStUQ1ArZm9lV3llYm9hYWxn?=
 =?utf-8?B?WElDL3M4aldlb3FGMWxQZndqWFkzcEZQWEluT1duYzlpOXFLQnRsOUJaUi9E?=
 =?utf-8?B?aWlDWXdFYng1VHBiYkdrbEg0Wkt1cjdDVzN6S2E4aGR3bVdUWWxlaXpMUkRh?=
 =?utf-8?B?c0JtZHdCN2czR2JpUnlnbHZGaTUvRXlEazg3QXVaeU1hcDVkRzBZTWFld0Vk?=
 =?utf-8?B?VXhKUVk3bnNLUWxWcFEyWTArd3BXRnd3dkdmTzNVaEExYUN1cTl3VzR5amsz?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb798481-aad7-4d48-12a8-08dda9a2951a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:16:32.0837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZjNbH6IQxUUr7AZMESVClZQusW/wEPYIB+Q9ECvb4haOW6e57lA17WgdCPylZ/vMbnbD9Oug7CHlDXrByzdrlMEuajkWNpK8Y8ZZYaKpIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
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

On 6/9/2025 6:23 PM, Stephen Hemminger wrote:
> On Mon,  9 Jun 2025 11:16:41 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> +	ret_val = hw->phy.ops.write_reg_locked(hw, E1000_PHY_TIMEOUTS_REG,
>> +					       phy_timeout);
>> +
>> +	return ret_val;
> 
> Why use temporary value (ret_val) and not just a return statement?
> 
> 	return hw->phy.ops.write_reg_locked(hw, E1000_PHY_TIMEOUTS_REG, phy_timeout);

I agree with you, but this is not our code, so we can't modify it too 
much to avoid maintaining huge deltas with the base code.

-- 
Thanks,
Anatoly
