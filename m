Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A076CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BC8402C9;
	Thu, 18 Sep 2025 11:01:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F08DF402C5
 for <dev@dpdk.org>; Thu, 18 Sep 2025 11:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758186117; x=1789722117;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ud9g0LiRTY+0fPQoKVEaLXZOWb+JzRDwTH3E3fmaXpg=;
 b=BkXfCgCvC5TdVcH6C+wq6roxPJitoNIqxwH6giVLuLgFqC/MSqmITpJW
 +hO8c+BD9VVpSdF9lXEdxEcWMUVmbVU+b153sddzIi3DXb6Z88kq0KygS
 +/Om7rIvGJl+Xu1b+7bqwyoq7PFFbpZ+QT5QqvZo++WJm1v0C8g3WPf6Y
 e6tRpwpFZzUJjZC+6jISEO0jl5bjwPf/KiRQ+JibiVfMACloyZN7WIWjR
 w7Egb20xsEjOied1nujM3hQ4jsGftE86cvFRusMwfcspP42vTSMy7tjvr
 7lpQuKv1NiRooD8of4/GitUWGz3rx4Nax9+Bzjn+MwcHCP4iy1zKwqbG7 g==;
X-CSE-ConnectionGUID: c6U/i2/fSyaNFlSMCJ4NGw==
X-CSE-MsgGUID: i4t8rkc0QCqHFl7fcCS6Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109869"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109869"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 02:01:56 -0700
X-CSE-ConnectionGUID: IjzhyMJQTFW8cI5SzlbG6Q==
X-CSE-MsgGUID: ioBUddGzQx6ogUnY+PHTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175931239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 02:01:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:01:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:01:55 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbwcHVw3/oGVbXubSQYyk4V7VongkY4pN9Ockfrfsn11VVuuNncWdJvdSOjlhJBt50ujhLSHX0CtW+ra+fJpvA1XUJeAOEEqYRnfLgF+bdqtnwtJ9EyqdX9ZhC0s6If/UfyXvThKtmLay9NxR/7/R1AgGjQdzKoJ9z+54q7lZh/tI2r2hGerYcYIXbd1fD/qs2CZzuhwIfQAnwBx1KGoQwYnlEn3YEIEsZdphl20nkA8CF85VfQAH3rAv911zuiVa5z5YckCUH7XGt3/MI8uS7i+U8WOkGjEVEWwRA7N7yAyvS2+wh87JTVmC8M/tH9LpXhGG0UmsvL66/zzjH9sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frCuyknhh3Fmv+TVGhevXeMpm3OQdaF6Ez9jMAzAtxA=;
 b=Ffy3CtP/BwbVcYpOmNcj3TgcpaDRCw8mGw37SWxI+6/L5rOZ/MyIPx1h7djNWc92lB2zn5A61GIeWFkrDk1uwYfDVP9ibP+VZHCtGQtkT2vyHR3lP1+9uf9uoxqHxBkMKH4pOeq2ii57U/GyolVlOfvNAoLhpcdKbsQce200zR9Aqe+DWhqd0RuV61VUm7682sdUkdwO+uQgdM3N3AyasSHTpA9Mzv9gYJmcDaiHHL0UbXg70LkXel77yKCQ8B0TwLnaJkIAqXy2lGxXrHT3v3vkEWEfIvpYSMJtVjTdjxQtXUm36ihVrHtR4JgckFN9842vwIOlas7iXndBn5SdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:01:46 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:01:45 +0000
Message-ID: <7cc3b042-7603-4bc5-ac3d-1c6b37d38c1d@intel.com>
Date: Thu, 18 Sep 2025 11:01:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Error with --no-huge when compiled with -fsanitize=address from
 gcc 15
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
 <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
 <9d2e0536-98af-4532-aa57-dd1605d6e070@intel.com>
 <DCK3KYFOL7EF.1CBE546ZJUS04@redhat.com>
 <45a59471-a515-4595-bf07-a74d1c6e8482@intel.com>
 <DCOK6VADCGM4.147AQDN77QTJO@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <DCOK6VADCGM4.147AQDN77QTJO@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0032.eurprd08.prod.outlook.com (2603:10a6:8::45)
 To DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: c43651de-70f4-423c-0cc4-08ddf691fe5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1p0YnpuckgrNUE3UmJmdkp2T2JSdWQvTEFBQVE2R1ViNTR0SW9EbGtKQmEr?=
 =?utf-8?B?aTIyTTBkNEFwcDBNMmRkeWRyeFc3U3RObXpBem5wYkRYTGxxbEQxYVU4ZEdr?=
 =?utf-8?B?TUU5eldqbm5teUFSWlVJZUJUV0xieUo1K3orNlh4aVlxUk9CM2ZyWGcxSHRh?=
 =?utf-8?B?K0dYd3R3N1pXV2daQm5SME1PWXl4SGU1UXphZHkxVjJXNnVyZ285M1kwMW5B?=
 =?utf-8?B?OE9namhqb3BMTzVLU1dGREJtd3h3NE1XdXlFU05TZTB2bjBvdWVvOGsrUlVL?=
 =?utf-8?B?a3FyTVc5cFNUYWoyK0ZpUnlWNVRkY3ZjNHIyZ1RBR1RsOGh6R0pDODY3QTFa?=
 =?utf-8?B?bjNJSHMyL0hxQ1loRjQ3R29scCs0R0lvbWh6eFJ5OHpmSDU3RC9MVUM4eURs?=
 =?utf-8?B?NVZUZG5CbTZKWElnUzlsZlR4YkE3YVB5VCtja28wbFB2Q0VpSEdhUjdpMktk?=
 =?utf-8?B?djI4R0dzamhoeEZteU14akpHUEFtb05lU2dmTWVGK0RIemtxKzJnM2djTElw?=
 =?utf-8?B?TEZKcVIvZS9JcXVNRi9FWk44enpIbmh3UUdnd3B3bFkrWXFIOEZUVjBwQjFt?=
 =?utf-8?B?Ym1EMys3V2JxaCtHT3VrdVNIRENmdkxEKzZyZGRoZkZadC9DeElNc0NRL1Ir?=
 =?utf-8?B?TUJnTDZjNkNyeUxDUWhWUDNFUjRLSmtNTGkzS2dkL0NLbmkvMEFJTjBCa29N?=
 =?utf-8?B?OG9Ud0p5cHd2bUhqbXRoWUYrZS9rM21PNjFjK05kdWdqMlh6SVJiUER6anBB?=
 =?utf-8?B?OURsWlpYTGNmNU5rcVJicldRdkdUcVN4akM2YzRMK2RpeUpDMXBJSm1Cbnkz?=
 =?utf-8?B?bHVIbG0yVlpka0FBWW5CKzFUWmpWM3oyN08zb1Q3UzRZaTJaSXpmUHMzd1ZF?=
 =?utf-8?B?cEZRd01BVFN2TUVsTXRUVCtBV3lWVFRGcmJmaEhtTzV2OVpEOFM1NmF5aGVL?=
 =?utf-8?B?Q2JJR2xXWDhHRTAvNFMwZ2k0L0R3dHZScWt2K2tJdkpvVk1JM0hCUU1DSnow?=
 =?utf-8?B?U0tNR0FRZFhLam5UdDFNV3RJWko2UXF3TDFFeDlCWVpsRW5UOFdMNGl5VlhW?=
 =?utf-8?B?UG9wUWxFZ0NXVkMwYklJMFBkeXZLdDhTSXR2V3pqWit4LzdGc1VHZjQ5VXEr?=
 =?utf-8?B?S2VsMzZBOHdoNVhWTk9GYlRPT3o2Qm5JQ3Rtalg2L0huS2NJVU5IVGM5ZlIx?=
 =?utf-8?B?QmVDVGlOSFpJdmFndmpVN3FSU2gyb2FrYm9Lbzd3YkJxdHo3SzhPTHo5T21Q?=
 =?utf-8?B?bHFBTEgrbnhaMGNoanZKS1dZVlV2QVJKZE9pdEtUNnhJSzBmeHIxMTZUSjd0?=
 =?utf-8?B?aU0zcGd4RXZCU2YvV205aFJRN2xKbzBSV3J1a1M1YkpMR0EvaWJSTmpMYkx3?=
 =?utf-8?B?L3hsOC9RU3JYRnMwdkF0Wll1a0x4eEpRQ1AxSDdVN2dOSFdUZTh1Q25lSm9s?=
 =?utf-8?B?ZnVobzEzbVl3cjJjL1RackJNRThHNlUzbkQ0ckhxNUdzR0pGWWg0elBTZTJk?=
 =?utf-8?B?ZENTOFk3b2dsSFM1NUhFRkwyTUdobzNEbkZQeTNtOTRmcnVCTTVhdGFQUlRC?=
 =?utf-8?B?V2RrYjJsdWl3cGNnNGNJREhMbURoRkxMYzNVVjNDaWxWcW5tNnlKUllaUFpF?=
 =?utf-8?B?Z0F6M2tTUUFPS2wzbjhFM0J5aEpDNmNhZXp3VWxVY0dycEwrRy9OQ2RkM1ZP?=
 =?utf-8?B?TEVvSUJZOWl6bkpaajRVblhBa2FWVlNhSXl2Wko2UzUwTHNWTHRKQkkxYjdJ?=
 =?utf-8?B?NzUyL09rd1dsMHFOWnBtd1NmTlA4WW1LMjFKWTZUMEc1V2o4R2I1anBaM0ti?=
 =?utf-8?B?WE9wNVhkaitTWktHZmZjNFlVSE9HNVRlTlVMeHZBVXBrcGZuUWhWZTQrMGZO?=
 =?utf-8?B?UmxLOFBKdzdNT212RXVJU043azM2WkZnbXBQbzQzQlp6SGlBNU8rSzNlMFBZ?=
 =?utf-8?Q?yjx/1GHGjLE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RvNm5TejNtVHlKUnNRb1JzUjVXRDYwTGU4Y2gxQTNzUG1hSk1sVUVrWFRV?=
 =?utf-8?B?ZG5nMmRQaldTdlE4NFF6OXdGTjUyZ3Zpa3JldDcwZGFFY3JlTkg0azdxYjFo?=
 =?utf-8?B?MkNvWUI5aDRUbWRhUkozK2IwQ3lUM3Q2c01TYzNEVXQyb3dpQUpKZzJhK2M4?=
 =?utf-8?B?WVY1UGNsV1VJTGN0aDFHOFBKZEFCMDZHYlNEUUZpWWs1Y0NuME1XajJVTlNB?=
 =?utf-8?B?cFpSWTJJVUMzYUZWUzlxYUtyTEhPUktvTWp4em5zYng4d25IUHBVMHZtUldF?=
 =?utf-8?B?MTZEbkFIakd2QlBBRHYwZUYrQTdRQjVjWGZ4ZFRkRklkTmNxc0twWVUreUFi?=
 =?utf-8?B?VnBmK3lBWTlzdkhNYSt3eGJwVnMyQ2Q1MFF6V0ZZcmxneW9KNGlPZm12aUJ1?=
 =?utf-8?B?ckM0b0U1Mkl4VU5yZ0hnckI5SjhVWGQvWkg0U2dURTNVelJLeElOMEc1QlVo?=
 =?utf-8?B?WXRtYWpyclh4alRDTVV1VEd4YVFnS2ZJaWFJUFJIemFvaWt5Mm1Gc29TRUVO?=
 =?utf-8?B?MG0xSk4zUG1Xa1A5VkYyOEE5bWRYQm9BYjJVOVJWWjNtTWZyZ09vc2I5d0dt?=
 =?utf-8?B?MkVGQTdJMXVLKytjTWdJSlV4QVFQTlc3UFVZOHpOdGxaUUJaYTFoSU9IdjRw?=
 =?utf-8?B?eTF2WE1IWmkyU0lZWGY0NW9INFZkemVZeDB2N2VnMDVHUVFGRVdaZmVoSTFT?=
 =?utf-8?B?WUFKNVRZRnhKUUFSZGpDTkdGZmlEaVQ4WERtRGtrQkhodTFJUHRKbWxCaDYz?=
 =?utf-8?B?bjkyVmhkVFRKNnIvN0pmejFwMU0rKzdUeTdmNnZQYWErMm90TzB1c2FUQzNO?=
 =?utf-8?B?YW15MzdYbWlmQ1pOWmlGV3Vxa3V0a29VQUdOdlFWWXRYeGY1SHVGQXI3SGRr?=
 =?utf-8?B?OC9SWEZmaUlWdkxLVjdUZlBoQTB4cTNzTXpqeGVPZ2JHNGphZlVzL2JIOFly?=
 =?utf-8?B?eUJmTjhKVG9Nbi82b3NKUnZqUDdseGJ0MVJQSzJKYW9lc0ZDTUxVOG1VanBI?=
 =?utf-8?B?QWRadWdta2ZXaGhqOWVHTVpQenU4bmVtYXFWTitzR2tFbWd6bmJJK3VCSFJr?=
 =?utf-8?B?cGtEdWxNN2ZqaDV2bGZwRU9Id0MzNFFKMDJ1Y0p3aDlBaVhVK3lvU0x5UTVD?=
 =?utf-8?B?YlptME04Y1lsc3lkNXhtSlJ0clJlOEVkRjc5WWc0Wk5ISGQ5WW8rb1hYb3FP?=
 =?utf-8?B?UEEySWhnelR6dExITXh6M3M0WDJOVmJkcFZTaDk2L1poRGxidG1CT0tNV05r?=
 =?utf-8?B?SUh6ckY5Q1FMa1pyQjB0MWJqUGI4ZlpJMmFlQzhTMnNUS3VIQ0VrY3RBYWZs?=
 =?utf-8?B?a3FtcGhEOWlyQzNwekZDcmtQbDhKei9uYmxDSDhzNGxoS2pRclR5KzNpZGdP?=
 =?utf-8?B?RDhuVXlDME11c0JKQ3lLbG5nYjZnVlQ2N1EyNWN6Ky9uRnJxcFB5N1dVWnhH?=
 =?utf-8?B?amNEWHN4azdvYnBpS25WR2NwUG5rQkJNV0x3Vkloa0xWUUZLQW9iWStOMklN?=
 =?utf-8?B?YnJrZlc4RGREcXBxRUM4d01ob0dGVzg3cDlFZzJxNWJVenZndTBXRVBmdjVY?=
 =?utf-8?B?dXN6V09tb1lTQWxib3NROW5mM25yUE4wY0ErWUM3UkV2Q2NZdjk0K3FlTTc1?=
 =?utf-8?B?Y0YyeDAxb2wvREdaNUhaekRObzdoVFZrMjV6ZWIrYXBGL2ZKcjFtU2ROTFJm?=
 =?utf-8?B?emF5b3laWDR6SXdEd2IyaFNtZ2hhQ1FzNWZqOWY5RDltcXVsbmYyeFpzSTNS?=
 =?utf-8?B?dHJ3MDNKYk5lektqdnprcVh3am5UUXNIS0dvOXBVd3NNU3dRaHFRek5kaUVu?=
 =?utf-8?B?ekdYeFNSc1p1cktCcmdtYnZVRkx1TUlmem83cjFuVTVuWDUzQkUzSzJzMjdw?=
 =?utf-8?B?N2NCVEc1U1ErdGJZR0RrVHk0NlB0alM1RUtlMW9SbXdFazJZSVFZMFJEOTB4?=
 =?utf-8?B?VnJNSDVsbkRHNDJDalNKWmQrbXQ2VXlPNUV6Q2p1WnZ1VXYwYzJ6R0tEclJC?=
 =?utf-8?B?MEVaVUpMa3pvNkNjVnl5WjJWUml4ZDdWU1VHZkJZM2tzRENTR0xnZS84Q25R?=
 =?utf-8?B?Ni9lTkVDM1NUSzhqQ3JpeU80cnlUN0JmWWdNMFZCQUYyQ2UrcGtBRVBueXNQ?=
 =?utf-8?B?SHQzdGVhajBjR2djUHh4WElidUxNTVE2OUlDdDUwbEhZdDJPUmhPZmlNU3Bt?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c43651de-70f4-423c-0cc4-08ddf691fe5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:01:45.8021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3P7eoUxtlL09ye03pSGVFWds/z7R7kDBT7VRzvlupKtReC/1lJV6TthhhjMV4B+xWf39YFs0Zfu58HcmPjDL6gG1qOrXv93Z4eUs5D/245g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
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

On 9/9/2025 10:40 PM, Robin Jarry wrote:
> Hi Anatoly,
> 
> Burakov, Anatoly, Sep 05, 2025 at 11:17:
>> Specifically, it's weird that your DMA width is 42 bits (indicated by
>> "using dma mask fffffc0000000000" log), running on a physical machine -
>> mine sits at 57 bits, so despite having VA's within the same range as
>> yours, this works on my machine because my DMA mask is much wider. Maybe
>> there's a kernel command-line of some sort that limits your DMA width?
>>
>> At first glance I don't think the issue has anything to do with DPDK, at
>> least it doesn't look like it does to me. I do not see how DMA mask
>> width would be affected by libasan or GCC15, to me it sounds more like a
>> kernel configuration/HW setup problem.
> 
> NB: The problem *only* appears when I compile with -fsanitize=address.
> Hence my suspicion around GCC/libasan. There must be something done by
> ASAN that changes the address space.
>

Hi Robin,

ASAN wouldn't interfere with address space itself but it will cause the 
addresses to go higher (the default starting address is such that it 
should fit within even smaller DMA masks so normally this isn't an 
issue) because of shadowing, so while ASAN itself doesn't affect the DMA 
mask, it will affect the addresses you get.


> Digging further with your advice (and some help from AI...), I found
> that the DMA width (42 bits) as reported by EAL debug logs actually come
> from my laptop having a new "security feature" enabled in the BIOS:
> 
> 	Kernel DMA Protection
> 
> When this "feature" is enabled, IOMMU is forced-on during early boot:
> 
> 	DMAR: Intel-IOMMU force enabled due to platform opt in
> 
> Also, my IOMMU exposes a limited DMA width (I don't know why). My CPU
> model is:
> 
> 	Intel(R) Core(TM) Ultra 7 165U
> 
> I have disabled DMA protection in the BIOS, and the problem is now gone.

This is interesting. I've never dealt with running DPDK on a laptop, 
maybe the limited DMA width is endemic to laptops or something.

> 
> Interestingly, whenever I explicitly enable IOMMU in the kernel boot
> arguments (iommu=pt intel_iommu=on), the issue manifests itself again.
> This is therefore a weird interaction between ASAN, the IOMMU on my
> laptop and DPDK memory initialization.
> 
> Anyway, sorry for the noise. Maybe, my experience may be useful to
> others :)
> 
> Thanks for your assistance!
> 

No problem!

-- 
Thanks,
Anatoly
