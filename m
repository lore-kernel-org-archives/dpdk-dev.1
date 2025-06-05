Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DEBC5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 09:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0405A4028E;
	Thu,  5 Jun 2025 11:29:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6EE304026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 11:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749115778; x=1780651778;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MxVtPfb2+POxmtzl6cBbZ21Wp4I/Lji6zUvWkm3RFQs=;
 b=SiPFnx3SDtWFXcHBnHSVBXwXb4uTRksMQaoGdvAVjpDJbU91ctG7Q4T+
 jX9P9xNamnL9eBi0uPAYm/pivM03wf8S7C3+a9ZTUaqf1bgDh6Q+0C4Zm
 +yu2bEeFVscpxIct0SPl3DqObhiAiriy7sFscPCNdDWkj5S1WaHfHXIra
 iCmrcLU7m3qAMXFPU2DpEpga6FRXsJC4ps4Z2sGIeTc473IzXJDF1wUBn
 daE0MGADI2hUTEWsXPzmkR+FK2EpVLmr4NaqdNlKCk+XHacqh7P8DPCCw
 AVZ9Ob8bjfuj2YA5qDvNdYsJMczHixltDzkwUAx1lWTi+b+BcCv+3fbX6 A==;
X-CSE-ConnectionGUID: hoS+RyhxRcCQ1xfSJTeGPg==
X-CSE-MsgGUID: /TWZTnAFTDmUgxjoUJUlpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51224836"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51224836"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:29:37 -0700
X-CSE-ConnectionGUID: N+r7edHxRumZethLjYMrpQ==
X-CSE-MsgGUID: 4MtPVdeWS1OgOUeiWUcsRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="146439733"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:29:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 02:29:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 02:29:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 02:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZEMkCvfbluZOedTau69vef4jWcuGkijvPp8EVKI5mxngqXhMF5j5xuHO+cPfXNM051KHXKm5tT8rKjEt3A0V6rWY05FyL9Il+jIRH4BHdcKPvrLmHJYTizGJScb3Rv+k8ldROH98uyC/4apNrf8yv6XDCGrnhq9ixJr4s1GhvNo/qKNrS9kgcxm4FCaLZyz0Hs7iTn/LSC1T07fY6Q9xcsCOrR8UE56Qz5SLI6EXfWwG7SyW6O5JXBcKyj/tp4dgESDUq/2QKcwQUr8hep7HsstK2furo8YoWhWVqDyRFakpeW1WRTx1tyflKFluKTRYeIAPrvIh0cR0pLY+7bPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcnwK5zAg8pJhWRENngYzV6TSrkmZOjSl37LFfD9NtM=;
 b=imp5fbuhpG+B9JfV7uRyCUc22QEW+9WvuqU296EH9ypIyFuik7CUSDCr8KwuFZhFIWEFONKOnXm1mBuB+cLKk2AfRHyxTjc3uoMIWmFYJ9hEWBZkAUFqwBLYIWJoIVJgD+rcm90RhtVtSn2NWdfihgHa+Fj0waACjrNt1KN62rDZsX5/FozHiMr9zyPk6umfbWAVG73mpJ/KM1tuJ+14z5+venW2DUJYEdyT/4aEbmlR135EpEtLDaPIOrPWy9zWrMlpKQIzOaSLgNJ53yzcUo4XJ5OJLj/c/68yUdLIjVddlosDO5JDjr06nPu3knH+L7dShUcFo2oa2PwFBiv8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 09:29:17 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%5]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 09:29:17 +0000
Message-ID: <e9a7a3e8-2154-4c4f-9846-5d2241627d36@intel.com>
Date: Thu, 5 Jun 2025 11:29:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/25] net/intel: support wider x86 vectors for Rx rearm
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
 <aEBfPb8Imy6nemXw@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aEBfPb8Imy6nemXw@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA3P292CA0003.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::20) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|SJ0PR11MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cda40c0-2f0e-4094-f21c-08dda4137130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1ZiZWxPRG9nLzZEbEVDWWlzTUsyVDhqUVYvSy9XKzh1ektXSGZBd1JsZVNu?=
 =?utf-8?B?NElwWkRPN1NxbUtxcnBJaU11Um00QS9VdFEzaW5ibU9XTGRjdnVCelZHRWp3?=
 =?utf-8?B?clg2eW5KNjloNWFJaENhZ0JOSGwrdlZNQXBXMTFET3RUd3JrTVQxZmlVTXpT?=
 =?utf-8?B?TmpnTVZQU2l3RmFKWS9zWWcweVJVdWRQTmU5VFJJR2c4ZGFjYTRWUTk3aEpv?=
 =?utf-8?B?dHhnc2x3ZGEzci9FWGZDd3EyKzN2T2VsOFdKZWFmYlZmWDgzUnhIbVMwenFE?=
 =?utf-8?B?KzJPSlhSeHpaeFQyKzNLdUdzNThUaGxVTUd5U3NpNXVxaGU4cjhLU1hBQ1pE?=
 =?utf-8?B?M1gvV0pPaENQZ3pQWkFRVjF0NGQ5d2FvZmNQeFJOWVJENTlqZkltWUJDaFRH?=
 =?utf-8?B?YkVEN1NlYW1RREdNdnNLYmg2aStqQ1FscnExOW94S21LOXVNTlhKZDg5VHJT?=
 =?utf-8?B?a0F3MHk1S2lvdWNQVVFHOEZHcjQ5S21zc202YThkRzFrVUpuVldQZWhSbUhS?=
 =?utf-8?B?clNpOFIrUTh3SnRQR1RnOGZES0JwMjZxNTc4R0c5QUNUc294Wm0vSTBlQ2tu?=
 =?utf-8?B?UFA0OTZtR0M4MWhkK0h5WC9scmF3OHVlb0ZvZzhhSDVKZGVEejVtbmlPUGx5?=
 =?utf-8?B?NE5xNFdMdzB3anRqcjdLRWpKcTJyeE5Dbll2c2R5UnIveFUzYTRQTHdiTm1I?=
 =?utf-8?B?aVV3VlFNODhqTUx0eS9JeXZHaEdQSnNiMm1oS01XSDdLWEZjanlJa2E0SGkv?=
 =?utf-8?B?NCt0dVliUWdUbEtLS2VNM3EwanZEZVVQVDY4b2tCcXByeHpTVStTcmo2N2Fr?=
 =?utf-8?B?Z2Y5NjBUMytBYnAxSzJrb0loSWpRenlrbE1iSy9xZ2tLZkNOUDVCaGt4V3RW?=
 =?utf-8?B?dldsbmJrYkZVU1V1QzRoY0xQb25tN2pZcUNGZkIwam1MN3ExT05uU3QzV2Vo?=
 =?utf-8?B?WDRKZzNrZW5ua0xBMjArS1RVaEVENEJwMFFrRVEyOStEa1RDOGttVWViRk1L?=
 =?utf-8?B?SURGTXNFSjBlWk1nS2VZcE10L1B2YnlwbE9OS04rTTBPWlBjTEtoK2tRYmxF?=
 =?utf-8?B?cEFmeHIvOGRpSStla2pQYlNOd3NNTXhNRGNKOEdFVVc3K0FMSHFIa2lKaWN2?=
 =?utf-8?B?TkZkUnJuN3h5bWY0RHFFbldiQ3BrUFlYWDN0bmE5bGU3UGEwbFFTNk1nQjRE?=
 =?utf-8?B?RmNHZFZxN1BmOGZTQ29mcDV3cmRnQ2NtVkJXZm53b0JtMW5aYnlkQ3orN0c3?=
 =?utf-8?B?enZVWmNIVmtFYm1GUnZVQUZrZ1hDRTgvTFZwZGx1RkhveUtBeG42Y09tRzF5?=
 =?utf-8?B?aFFjaUlXcVVuTmJkbkJrZGtKT1dSbVEzbnNpSUNUWWFSWjFmazllTFU5Qkpv?=
 =?utf-8?B?dWFKamQzaWd2UytLRGZHVjBZU29jamYrY1c5OHRvcnh1Qk85RVIreGZzUGVM?=
 =?utf-8?B?cWVVZDc0c0JoSXduN2haaGl6NGNOaXplWjJ3SVhkNDVFamlZaXZSMk9jWlF5?=
 =?utf-8?B?a1JPUWpWSWZYc0lvVWpiR0hZSC8yck9TZk1LVXdNT042bzhpY0l0UkFwK3BI?=
 =?utf-8?B?aEI2NDdjZjFsRU1vNkQvV0x0czErbDlvdHUxcTYvNWVveHhJbDVScnYvSCtN?=
 =?utf-8?B?K3ZkMUYrWVFZTE1FQzJmSjMyZnFzR2VKN3hBMkhxYmhOYlZqNnpmVjNrOVlD?=
 =?utf-8?B?UWNFK3ZQZ21EOXVrZ01lUlArUmhTbVVWcWNIWnAxU29ENWdRcThPUlVmYkor?=
 =?utf-8?B?UE5mOHpFaFFtMU5zL3BVRldSSEl1emRtN1pMVyt4UU9kYTg3WXR0MU5pbUJ4?=
 =?utf-8?B?TVZmU1V3UGlHcHUyUU5scElqUG54ajc0VFh3R0txTXFoSERjTVBqM1gvU1BT?=
 =?utf-8?B?VTNVenkzamx5UU1vS2ovcytCM2grWjB4Z1FhSUJqYXhUNVcydVZ4R3ZIeWxL?=
 =?utf-8?Q?UHWlcCTN2sM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BZdFZPWVhZYkR6WWZMV2RnbUtzWXczQVo5empEZ2hGL3QydTZmS3M1ZzBj?=
 =?utf-8?B?Vko0OGlkMkZzaTZWQUd4MHc3NmVuc3JBZU9vL3VPNGtoMDNKenZlZUdiQWkz?=
 =?utf-8?B?Q1lFV3p3U1BBSjBpdXk0aWtHNXJnTk5zRTBZYVNCY1ZOWERqOS8wV0ZMVHZ6?=
 =?utf-8?B?NlRkOU5DTUo2b1l5b3BUd0lpUWZqcEkrN3hsTXY4U3NiUlRJTkpTZGYyc3NZ?=
 =?utf-8?B?T1RQcWc2cDJiUXZMVUFROXFrUFZoTkZvVm9kbjBjY3JLaHA5ZE1EQXlpRHdE?=
 =?utf-8?B?bXVmbENveUVGSkYydnVjbmhET1FqbUp5VmlBUE5xQnlmL3BReGNrVTk0Z0Np?=
 =?utf-8?B?KzlqNGs0djRSQmpmMEVsbWh0VXRvUnRiRjJZSHJUTTVIaUc1ampDODRvZlpn?=
 =?utf-8?B?R09nYVRIanJGN1BnMTNTd29HeWNkSURBcnJVVnNiRHRjUFVJTEdabTYrODlL?=
 =?utf-8?B?cWl3VGJPbVJtL2drait3VGkrN1ZIeXROYVZrd0VtcU5ROUQzbDZDQkZtZkYv?=
 =?utf-8?B?RGJDQUZVbG5tWGV4U01KU2d3ekVYSmRzMWYyQ0U2SjlJQTJhZVlqclA1a2VL?=
 =?utf-8?B?Z2NWTkxJMkNuWVVjZGg1bFdPNmF1V3Aza0xndTRYdGlmeDJFem9uNDFuZ0Fu?=
 =?utf-8?B?V3dBZiszbEFNVkUwZTJjME82UDdVYlJqY0xSTUlWUmVoSFlKWDloOVphalFH?=
 =?utf-8?B?YndnMityYjM4eGRqMm5aa1FoREtPejVNU0tmMGNWd3NIcytvcW1GWGZ2RUNi?=
 =?utf-8?B?ZlZVSUR2aW1CNEFvcitBZWFOcHcyNXlDbGgwOHNqdUtHeWRvcmFXNWVoSHBM?=
 =?utf-8?B?TmZ5TDI1ay8zdzVTNHliUUlScXNyQXNsUmpvTUFVeC9PQ25uZ295dzgzNFZk?=
 =?utf-8?B?bmt6RTNvUzBPTUY5WTU1dWF3Z2p5WmtGaTc3a2Jpb2haZjE1ZHF1bWNyRFhs?=
 =?utf-8?B?eHhVbW1rMDNBUXVZeUNlZ3ozUUVhZjFyTmJwK2ZveVpmNENWWGJWTmUrTHpq?=
 =?utf-8?B?bFZGYkZmVG9HalF3QkVNQTNpOGQrNXBJR3cva2ZUdlJKelMrVFZacU8vVmhN?=
 =?utf-8?B?bG45TTg2a3RBRDc3Ryt6eVcwZU54N1JQakdWYVdpZTV2ZDlha3BtVmtLZWI3?=
 =?utf-8?B?OVZFTXUvb2Zmam1ZWG9LNzMvdnh5Z0EzUjNXQnJNK0s1VkZlTEhNZ2c4NnJP?=
 =?utf-8?B?OEdST0d0WmVldlkxSFVzQWRITVJXMm90RWI5VlhKYmF1Ymw2Nld1UEpDOTZY?=
 =?utf-8?B?akJvRTUrdzB2TFZXaVdnMmM5b2xoVG1vaFBzZEZCd0JMQ0tPU2tQTzBNLzRk?=
 =?utf-8?B?SWtISngwbHQxcVB0ODMwSDdxRFR0ZjNUNmEvekZTY0pRRmhxUktRNjd5NUhq?=
 =?utf-8?B?b1g0bkg0ZG5qVWF4RnhRdHdxbHdabkRaNDlmbkhON0pRY2dIQ254QmtpUHRX?=
 =?utf-8?B?UUtTTEtOWTYvT2poSzVkNUhuVE5OS1hFMFVUcU9hQW04U2dld1dqdXhJeVYz?=
 =?utf-8?B?TUNtMDE2RUk0QlYyNTRZSFhpeTZkbGhPZ1ZVcFRmK2RhUmQ3c2hhLzJjM1li?=
 =?utf-8?B?UjUzTVJzN0FhM012Vzh5YjQ5NnloQWs0RWVwcFRUNXZ5Sm1WakRqTmZRcnht?=
 =?utf-8?B?c29ycFRwd1kySlpJbmE4WWRXQkt3bUJEVExoQXVvMEUrdWxWWE11ZHNYZDZ4?=
 =?utf-8?B?Q3ZJT0ZwTkxQeE5zS3BCS3VYV1pGTkxJdW1hVmdIZ241Z05Kb3A0UmdXYmdZ?=
 =?utf-8?B?c0ZzMzZXNVhnbkhmcVZXVzk5SkEvOVFYSnhoMGZaSk5OdVFzL25sbG9vMWJt?=
 =?utf-8?B?ajV1U0VEN0RKZG1KQ2pMTVRBT3JBZVVvR1FTTnlNeHF3c0Y2QXRuc1NGcEg4?=
 =?utf-8?B?WVBIa1MvVytwVjhrMlRsUkRiVVJIMzdoWHZqY0NUOTVFZUJVTzNlY3dheC9U?=
 =?utf-8?B?RnFjSzg2d1gxdnBOekdkZUtyQXpqajBBVGhaZ2l6NmFJdDdMSjB4ZVgyUGpZ?=
 =?utf-8?B?UUtpQ3BxZ3N4eVpacy9waFpIMzNWMTBHYWFNSTliUHJPTmJzd0hib3RPd3Vn?=
 =?utf-8?B?OG5tTytqYVNDQXBwZ0MraHZzbVlLU0d1SXo0WHdFZTlQTEdWVlZNVlJzODBh?=
 =?utf-8?B?MVkwdnRmajJOeTMzdUVVemo3d2t0RDlvVVNrRE01ZDhWRVEyUnJHNGZLZEsv?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cda40c0-2f0e-4094-f21c-08dda4137130
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:29:16.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2qLzaaWulbYfYvoA5l77gJ6flIgp4vwgHsw4BJpFfj1vslh3Qm/bxVhyFwxNdugj56JoJq2gOzyOl+FMtjzv+IzokddXp9so79rNysk/70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
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

On 6/4/2025 4:59 PM, Bruce Richardson wrote:
> On Fri, May 30, 2025 at 02:57:19PM +0100, Anatoly Burakov wrote:
>> Currently, for 32-byte descriptor format, only SSE instruction set is
>> supported. Add implementation for AVX2 and AVX512 instruction sets. Since
>> we are using Rx descriptor definitions from common code, we can just use
>> the generic descriptor definition, as we only ever write the first 16 bytes
>> of it, and the layout is always the same for that part.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
> 
> Like the idea. Feedback inline below.
> 
> /Bruce
> 

<snip>

>> -		/**
>> -		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
>> -		 * into the high lanes. Similarly for 2 & 3
>> -		 */
>> -		const __m256i vaddr0_256 = _mm256_castsi128_si256(vaddr0);
>> -		const __m256i vaddr2_256 = _mm256_castsi128_si256(vaddr2);
>> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
>> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
> 
> Minor nit, but do we need to use unaligned loads here? The mbuf is marked
> as cache-aligned, and buf_addr is the first field in it.

It was like that in the original code I think (unless it was a copypaste 
error), but sure, I can make it aligned.

> 
>>   
>> -		__m256i addr0_1 = _mm256_inserti128_si256(vaddr0_256, vaddr1, 1);
>> -		__m256i addr2_3 = _mm256_inserti128_si256(vaddr2_256, vaddr3, 1);
>> +			reg0 = _ci_rxq_rearm_desc_avx2(vaddr0, zero);
>> +			reg1 = _ci_rxq_rearm_desc_avx2(vaddr1, zero);
> 
> The compiler may optimize this away, but rather than calling this function
> with a zero register, we can save the call to insert the zero into the high
> register half by just using the SSE/AVX-128 function, and casting the
> result (which should be a no-op).

Good idea actually, will do.

> 
>> +		} else {
>> +			/* 16 byte descriptor times four */
>> +			const struct rte_mbuf *mb0 = rxp[0].mbuf;
>> +			const struct rte_mbuf *mb1 = rxp[1].mbuf;
>> +			const struct rte_mbuf *mb2 = rxp[2].mbuf;
>> +			const struct rte_mbuf *mb3 = rxp[3].mbuf;
>>   
>> -		/* add headroom to address values */
>> -		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
>> -		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
>> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
>> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
>> +			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
>> +			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
>>   
>> -#if RTE_IOVA_IN_MBUF
>> -		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
>> -		addr0_1 = _mm256_unpackhi_epi64(addr0_1, zero);
>> -		addr2_3 = _mm256_unpackhi_epi64(addr2_3, zero);
>> -#else
>> -		/* erase Header Buffer Address */
>> -		addr0_1 = _mm256_unpacklo_epi64(addr0_1, zero);
>> -		addr2_3 = _mm256_unpacklo_epi64(addr2_3, zero);
>> -#endif
>> +			reg0 = _ci_rxq_rearm_desc_avx2(vaddr0, vaddr1);
>> +			reg1 = _ci_rxq_rearm_desc_avx2(vaddr2, vaddr3);
>> +		}
>>   
>> -		/* flush desc with pa dma_addr */
>> -		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), addr0_1);
>> -		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[2]), addr2_3);
>> +		/* flush descriptors */
>> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), reg0);
>> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[2]), reg1);
> 
> This should be rxdp[desc_per_reg], not rxdp[2].

Right, will fix.

<snip>

>> -		/**
>> -		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
>> -		 * into the high lanes. Similarly for 2 & 3, and so on.
>> -		 */
>> -		const __m256i addr0_256 = _mm256_castsi128_si256(vaddr0);
>> -		const __m256i addr2_256 = _mm256_castsi128_si256(vaddr2);
>> -		const __m256i addr4_256 = _mm256_castsi128_si256(vaddr4);
>> -		const __m256i addr6_256 = _mm256_castsi128_si256(vaddr6);
>> +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
>> +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
>> +			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
>> +			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
>>   
>> -		const __m256i addr0_1 = _mm256_inserti128_si256(addr0_256, vaddr1, 1);
>> -		const __m256i addr2_3 = _mm256_inserti128_si256(addr2_256, vaddr3, 1);
>> -		const __m256i addr4_5 = _mm256_inserti128_si256(addr4_256, vaddr5, 1);
>> -		const __m256i addr6_7 = _mm256_inserti128_si256(addr6_256, vaddr7, 1);
>> +			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, zero, vaddr1, zero);
>> +			reg1 = _ci_rxq_rearm_desc_avx512(vaddr2, zero, vaddr3, zero);
> 
> I can't help but thinking we can probably do a little better than this
> merging in zeros using AVX-512 mask registers, e.g. using
>   _mm256_maskz_broadcastq_epi64()  intrinsic, but it will be ok for now! :-)
> 

You're welcome to submit patches, this is a very welcoming community!

(seriously though, I'll look into it)

<snip>

>> -#if RTE_IOVA_IN_MBUF
>> -		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
>> -		addr0_3 = _mm512_unpackhi_epi64(addr0_3, zero);
>> -		addr4_7 = _mm512_unpackhi_epi64(addr4_7, zero);
>> -#else
>> -		/* erase Header Buffer Address */
>> -		addr0_3 = _mm512_unpacklo_epi64(addr0_3, zero);
>> -		addr4_7 = _mm512_unpacklo_epi64(addr4_7, zero);
>> -#endif
>> +			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, vaddr1, vaddr2, vaddr3);
>> +			reg1 = _ci_rxq_rearm_desc_avx512(vaddr4, vaddr5, vaddr6, vaddr7);
> 
> To shorten the code (and this applies elsewhere too), we can remove the
> vaddr* temporary variables and just do the loads implicitly in the function
> calls, e.g.
> 
> reg0 = _ci_rxq_rearm_desc_avx512((const __m128i *)&mb0->buf_addr,
> 				(const __m128i *)&mb1->buf_addr,
> 				(const __m128i *)&mb2->buf_addr,
> 				(const __m128i *)&mb3->buf_addr);
> 
>> +		}
>>   
>>   		/* flush desc with pa dma_addr */
>> -		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), addr0_3);
>> -		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[4]), addr4_7);
>> +		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), reg0);
>> +		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[4]), reg1);
> 
> Again, the "4" needs to be adjusted based on desc size.

Right, yes.

> 
>>   	}
>>   }
>>   #endif /* __AVX512VL__ */
>> -#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
>>   
>>   static __rte_always_inline void
>>   ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
>> @@ -254,7 +292,6 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
>>   	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
>>   		return;
>>   
> 
> <snip>


-- 
Thanks,
Anatoly
