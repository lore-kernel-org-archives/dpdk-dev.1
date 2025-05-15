Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283EC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:09:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61EB2402DC;
	Thu, 15 May 2025 13:09:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6909B40289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747307381; x=1778843381;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RMZf4XnC3NqjLYEqr4bkwpxRRNsghUcWjR3gg7v/UvI=;
 b=SY7RIWUv56EsaA/klK3PFP6JU8PM7hvizSqNyJCWGQtDbp8f2SXxJgDN
 gg7HS/H0wHySynqXZtjp0cKODksMsrxHYMjYTW4cv5vO4icTl21ewhvFK
 nQSdHxhABjY7nwyLNWR/AhOFVsLmso2B1+dp32S0GVulpFMFGOQghU3cr
 UuGvHvmiPfDE/jILEWrUi6vpkhKTvT+hPy8txeGFybaG+67BehuLA7hUi
 03uOEaeBmzF89IPl3qncMTFLv5nzYSYpJuhFDp483U6TP27DQiCA37+oA
 yeg1ehMlaFMp5BFsx7E81x/4jr6erNWCn6gmJ6h2iXd0ovjPQi0Qz8S0+ Q==;
X-CSE-ConnectionGUID: ygJ1h6/9STe5Nypvef3eRw==
X-CSE-MsgGUID: nN7q5/L3T02QVzcGfF8acA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59869662"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="59869662"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:09:40 -0700
X-CSE-ConnectionGUID: DjhW+27FQTOZ0SnWXalDBg==
X-CSE-MsgGUID: SU5K2M1KTzGbAIhMvTrTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="139331559"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:09:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 04:09:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 04:09:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 04:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQfKFLmeU/2CfoGNRJZHYLkJFe4kRohSf/yVcXpgq3lPUx5AReq1ZnbbFFSP031JYIwYQpmlTD+Lntg6rgvyegER5lgd3Wcq3LfzrE0bdF5rL5LvxZ4VuniuBbCqniV4lrz/lY0NxyRCy+fSBduWr0Ias60v6frH1eP6n45iTg8LuhKudp/FqMmLe0docATK2ZnBXjnhpLVO7vZBo3UdKIg732AmPU6OUSRlvX//IyhfnJ87uI2e8sVOE5XN4kclz7ByqpYgEhDowqCkDNvhEATk5YM+DV6a/VUK6xp4jyuhxDd8PVULJr2aTNAv84LijPnI4G3l0Gy2r2JyJSpq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99jp6Df+SatIbBHsiis3z/dae6nmWMnjhnAb4wE+vro=;
 b=g/JjpXgvamjLq3V3r290KRcNccp8j9WMNctN8cyGiiLWhqrYiKFu8M5395CModE6ywEvoVjxOro7ZTXYF27ByN3QUPLxn+xpo+viTW+4MI5IEb3RY2cEzGA6Cixooc6mRsk+pdm9ki0cqFHMuyTSCUxJ/6KlOM6kz2oTw9QG+iIQJ0dihA4z/bdpdMkMLFKyHSImRBxyY9bVZP+Td++1VDDetgf014krMUwkPQbv/AuwIKgUXWceXz674f3Wiyc6kJhrjRpzTVIOSzJrJTtlk7GBx932M5jMRD/RdsxUC/pBrVq11mqAwut2NVHcLgR9AGUw+VvwswiQj1Etc5J5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Thu, 15 May 2025 11:09:36 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 15 May 2025
 11:09:36 +0000
Message-ID: <313f5667-0627-4436-815f-bf95d9ffbe87@intel.com>
Date: Thu, 15 May 2025 13:09:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] net/i40e: use the common Rx queue structure
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <d9f86c4577c1b0ee9923fef1d0fa61ac812803d8.1747054471.git.anatoly.burakov@intel.com>
 <aCTKVAL2nSNU4rRP@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aCTKVAL2nSNU4rRP@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab1fde9-1f88-4b08-ffb1-08dd93a0fa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVBqM2hISVNEWExseFZNYUJCS2Y4YkFYa1phYnhuODNWSGlhSWhUVjAxd2oz?=
 =?utf-8?B?ME42UHMxOUpXQ3ZIMzlLczFqdXIxclhDN2hKdGUrL1RmbVl2eWpGMUpDL1Iy?=
 =?utf-8?B?alA3cm9lQ2tsT2s2b1c5aU4yTmhXNk1YMzFXWk9PZ1UrNDN4WTBsMWpabmI3?=
 =?utf-8?B?eVdGVWRobzdUZ1dQbkpBTC9ZNG92OGw2OGhJTmdaYlNYcTJSNzRzNXNxeU56?=
 =?utf-8?B?dExnNFI5Q1N2RmdFcVFCNlF1Uk5ZL3doL3pOWGRLTGVrZTYyMmxpODJPbjBm?=
 =?utf-8?B?VjhOYjBVU1JsL0J1SEphUU1WVDhzTkthUCtqYTB0TDAvUm13UXAwS0M5cTZD?=
 =?utf-8?B?NCtqRi9XeExrQmRnT0txd3hJOEh2dlRBcGNxZjFHWXpkbjFCcTkybHhNYWlP?=
 =?utf-8?B?VVcrWWU0TVlIQW01QzNUaGFYSEdvT2xaVTdPSTR3NksrWWRJd3dPWDVtTGtK?=
 =?utf-8?B?dEYyenU4eXBlTWhCRVVtMHVwUjU4WW1KNDhvSlNxcVJHdzRYQ0hiVzlvSDVq?=
 =?utf-8?B?QkwwR2w5Y3NNVkd3US9lMDF3RktKZHR3SFlieWdHRVVLL1VDby9YY3QwOWJK?=
 =?utf-8?B?TWxRbDNxeVgzd0hqTWUvZVhSdHVneTQ5M0tlMmFCaWVMNyt3bWlpTHNGd3lq?=
 =?utf-8?B?bFpodzdlZUNLWXlhL3IxWHRPWVZyc2Q3ekxXcVBIS3A2SElLMXJQQXByT2xB?=
 =?utf-8?B?WVhSWWNNeHlDTlpTT1c4NmZ4Wk10MEhIVUlYT2lvbzAvQ3Y0RGp0cVQ1VmpT?=
 =?utf-8?B?M1NJemlvelArRDFPcTh4RDJleWg3cXA4elZLamdRY0pBRkZRYWUxZUMreHE5?=
 =?utf-8?B?d2FrTER4WWpPTkpoUFloVTdRRVcycjlMUEpWU1B6S0JSSC9xMGVCQnVGVXIz?=
 =?utf-8?B?ci9FaHNrZGZ3RUZhWks4Q0pnbGU2Z3ExYS9vYlIzMnB5cTdqNUV4akJZZ0pi?=
 =?utf-8?B?cW5SNHF5cG90SmdiK0NVK3ZFeHJnZW95NzBEMHpxWmxEZ2lNbmY1cDF6bzFY?=
 =?utf-8?B?UHhSQjZjYm1aWWxmc0hyOXIvYk5Rd3lxT256WlFMZHdZeVdJWHBiUlJmK2lE?=
 =?utf-8?B?SDFHL1RqQWl4ZG9Va0RaTzBnYVdzV2ErVVBjQ2RXT1pGT3l3OC9OazdyeHVj?=
 =?utf-8?B?c2tuQ0xLMEEwdjZ3TzBzMmxLODRUZ1BpNzJWc3BGTjRzL1RlUGR6QlBOVW5i?=
 =?utf-8?B?dHpIeDUyRk9QMnc1eW1OUm9rVXRwd1JLZDRHVjEzR3ZmSXBKZEhwRXhmZ1cr?=
 =?utf-8?B?ckNpMnc2SWdSclNoSFRqOEl2dFNKNFNiTkEyWXNaSVJNNzBQenhiYXo1NDZ2?=
 =?utf-8?B?cStFcE80UW41L28wWithYktzbkpObEpGOWsyWWpXUjNoS0J1d3M5aTgzTndz?=
 =?utf-8?B?enN2NnBPV1N2RG9rb0ZsdjZYUkI0S3BpUUQvVmMyWTdnMzdrTmpNbWRXdjda?=
 =?utf-8?B?UFV1Y1djK25nUHhudDZkN1JLbjBVY2JhL0ljYTJFQVlaZ0g4ZWJUd3I4VE9J?=
 =?utf-8?B?VHNjR3JmbDdESm83Y2ZUL2p1VndLbldHdU41Tmp4VWF0Y0RzOVNraFpCTjZx?=
 =?utf-8?B?VnhTZmtaejNDbjRiU0RXMWlDZzNSOWhZRTNsdjlNZDgyU2dENDVjWFRDV1BG?=
 =?utf-8?B?M3NuVVQ1V3Vlb21lak44N1YyNnd5WlRzbUF6Z09XZDVIUGNsazNOKzRmVERF?=
 =?utf-8?B?YkE2dkUrQ2lWcjFLWVN4UCtYYWFYcG82TXhmQTJ3Vjl5eWdmWjJUeXpmZlRk?=
 =?utf-8?B?OTdrWWc2Z0VMOFpTRGZub2FvQm1NaklWQjY4WllFYkRHR2E5dEJUU3p4Y2po?=
 =?utf-8?B?aHFEQnQ1ZHFIcHc0RlZWTVB2UVFLK3pUVXVVdVBnZTBJSmtIWnlBVXpQaFpY?=
 =?utf-8?B?RWxpNW1kamhRR2VxaTJ3cnR6UWNuUzFCaExPU0k1bDBtNit4Vzloa0VYUHFX?=
 =?utf-8?Q?Qg3vhQgFNBA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1cxQzFBQktqRVo3eE9MbFBzQzhaTVMvV1NBZHNZbzd6aDNaR0JwNlFSNFlK?=
 =?utf-8?B?blJWOW5mZWduV2U5dE85SEFMc2R2aWNiNnRhb3FwWjFrS20vVkwrZG04MG9v?=
 =?utf-8?B?YjNvZzk4Tlp0d1JZZWh6S1pmYjl3ZTNXaDlWSHBFbFRSdXBtc2dZUSttTkEz?=
 =?utf-8?B?eFc1SzZmNE1ianE4cEIvSE95Y1ZqL1Q1UTRlOTJUcGNPbTMyTXhabzZQWURt?=
 =?utf-8?B?Vzcvbk1MT1NON2h2Z1d0d0x2S1hBSlMrTDdCSXVzNEI0bGg1MHdIVUhCZVBZ?=
 =?utf-8?B?WjVmUGIxc3ZyK0JPejVhY1lReDV5WnZtZDZtcFpFcEJuLzI0NHd5NXhOQ0Fu?=
 =?utf-8?B?cEpKenloc29YK0xCbFJ5SENnZVZMZGFtbUZiMDRPcmFQRnVVYTFLdUUrTmxB?=
 =?utf-8?B?SVQ4aDRERUtVQnRKRVNrNUJVU3ptL3RpQnBXMmNqdExMeVFieGVGM1V5S0Y1?=
 =?utf-8?B?aUFiT0lXY1pmRG52SGYxSHBWZjZGTDZweEQwenQ3bmlwZWFNOE9jZGt2SGQy?=
 =?utf-8?B?Yy9lRHZpaGtrYUFDeHhIR1hLYk8yQ3hjaGd5SHZva0cyeHVMbkpSV2ZnajJZ?=
 =?utf-8?B?UW5QU09EaS9ZZTJpYzVzdytvcEtLTm5RaGYybXhuTm9NZGpzUW10UWZzd2Ni?=
 =?utf-8?B?YzBWbUZoVlJaWm5GU2dmeHdpZVpRVWo4SmFGOWJjRkFDS1dtMHYrNE9pM3Nj?=
 =?utf-8?B?Ry9lOEpVbXRRdGJWekhsOHFWR2VBTjJlN3ZkS21mT1FzRXBJbCtwRXRRYzJa?=
 =?utf-8?B?Z1BwdFcwdUl6NUk4ZEtIM1lxNFRUSmZqb2xYL2xBTVBQWUIzSjJTMkZKMklv?=
 =?utf-8?B?bWg3a3N0SEZRSU01dE5EcmtTR04vTGM4T0VoYlRHKzIrNm4rV2NpaUFNMTBj?=
 =?utf-8?B?SmpVdUtOUm5kM0FabURwbmpEbjRkQUsrNW42VDhpa0pYQXE3S3FMWlRsOWtD?=
 =?utf-8?B?aEVBVjk1WmJ0VXQ2WWZ5WThLaUhDenJxM3hxdWZQOTZlWWh3NUNwZEN3aWxG?=
 =?utf-8?B?NzkxNWo4bWMvdkVlWTg4SFJQWkRyNWtvcVdTWUptekQxNmt1ZmRHeFUweUpp?=
 =?utf-8?B?bVREQUF5MVE3MDZkdzRHcjdVbHNqRUdTSTEyZjJwZU53K3A0ci9FakhMQ1Rw?=
 =?utf-8?B?QjJrRmx1Q3JQbVhNMlhhVEFiWnBwKzBzZk12b1NxZnhtODBUK2UrZ3kvMTRC?=
 =?utf-8?B?cXVYc2ZZT3N3MG5NNGFtaEd0eHd5aFJmQkVnVHEySGgyM3lZRzB5NDFuWFdL?=
 =?utf-8?B?SzlvNW91bk1CVmNhRDRERDQ4N1piM0FWZEJGQmdmTW5RbnhpQjVXakpzbEFI?=
 =?utf-8?B?UnZhVFVHcVVZOThWM3JrNnB6NzM0a1k1TGJyYlJXM3hFVU9DRC90VWgxK2s3?=
 =?utf-8?B?bXNmZE5FM1EzR2lGMEFRNUlZR1JmdkN4enlsQTFLdENwRUdnV1Q1UTdQeTZY?=
 =?utf-8?B?Mzk0aG4vV2g0Z0c5Y2k0SXRDR1cxVVRUK2JEcW5uZy8xbWNsYmYvUmMwbExC?=
 =?utf-8?B?KytlVm04c2JTd2x0VitwMWFqTFJpMGJEQWdmSGhOMGwxRUczZFlHdGQ5azFR?=
 =?utf-8?B?VHNpVFRYS0VCS0h6WWdlcTVhQUpTOGpJSkVJZTA0K04vL3loK2tNT0hpbUNZ?=
 =?utf-8?B?OE5STDVpay9LQTRxUDdsaGkwQVVEUXRsTDRvZCtoRUNJeVV2VjRNb3VMQ3Fj?=
 =?utf-8?B?QldLck5Zck1PRnVTTHlmRll1WnpZcWJueDBvcGVMK1Bpc3hKeGR2eXhhV1VH?=
 =?utf-8?B?bjZpWms0ZlRhZFIrbURXSEN0YUYybVhIdHJ1NVM3dTFmZyt3b2lDSEh0QVVm?=
 =?utf-8?B?TUEzNDFncFd2dW1UaGFrRU9QcHlua0p6ZG9QN1J4bTBrR1VQblphZGhtZGxr?=
 =?utf-8?B?NFk1bVRqV0NxL3VRMlpLL0dUa21lWmpLcHJiNHRyYTNucEhYQkZkdE50RStX?=
 =?utf-8?B?alNNeVJWL3NtSHo4SVZ6VVRsZjBQbEVEWW1ZMGVyWUFtTGpPOGVHTGNaZjFH?=
 =?utf-8?B?enFCYU95RGpuNmJOUVZUNnhpRk1ZelZORzU1cy9vRy8xbmpTSzBHNjVRZ0pT?=
 =?utf-8?B?UWFwT29NS1V3SUVMT2FkbFlGQldJUGF3NXRhYXpUZmQrZy81OVphSDNhRXkx?=
 =?utf-8?B?SkNuOXVLczdXTnIyTzlRd0VTY1JXK1lpWC93elZXTjZTTnFMYVVMUHBZMktt?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab1fde9-1f88-4b08-ffb1-08dd93a0fa9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:09:36.6017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fBzNmjtl9/tpsU3h8ns5iwRax9iBZ9hnOnO5BXhb8mw0YyNt0LPNSNjQufUjbKhrfxa89FSpwJmauy+G1VddAKcbVGvQXV9JZo0akP6xEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
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

On 5/14/2025 6:52 PM, Bruce Richardson wrote:
> On Mon, May 12, 2025 at 01:54:30PM +0100, Anatoly Burakov wrote:
>> Make the i40e driver use the new common Rx queue structure.
>>
>> Because the i40e driver supports both 16-byte and 32-byte descriptor
>> formats (controlled by RTE_LIBRTE_I40E_16BYTE_RX_DESC define), the common
>> queue structure has to take that into account, so the ring queue structure
>> will have both, while the actual descriptor format is picked by i40e at
>> compile time using the above macro. Direct usage of Rx queue structure is
>> now meant to be replaced with a macro access that takes descriptor size
>> into account.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/common/rx.h                 |  14 ++
>>   drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
>>   drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
>>   drivers/net/intel/i40e/i40e_fdir.c            |  16 +--
>>   .../i40e/i40e_recycle_mbufs_vec_common.c      |   6 +-
>>   drivers/net/intel/i40e/i40e_rxtx.c            | 126 +++++++++---------
>>   drivers/net/intel/i40e/i40e_rxtx.h            |  74 +++-------
>>   drivers/net/intel/i40e/i40e_rxtx_common_avx.h |   6 +-
>>   .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  22 +--
>>   drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  12 +-
>>   drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  12 +-
>>   drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
>>   drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  24 ++--
>>   drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  24 ++--
>>   14 files changed, 160 insertions(+), 188 deletions(-)
>>
>> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
>> index 524de39f9c..db49db57d0 100644
>> --- a/drivers/net/intel/common/rx.h
>> +++ b/drivers/net/intel/common/rx.h
>> @@ -30,6 +30,8 @@ struct ci_rx_queue {
>>   	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
>>   	union { /* RX ring virtual address */
>>   		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
>> +		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
>> +		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
> 
> Rather than doing this, would it not be better to keep using the current
> scheme of just having an #ifdef aliasing i40e_rx_desc to either the 16byte
> or 32byte variants?
> 
> /Bruce

I had that in my first iteration, but I don't really like having 
driver-specific #ifdefs in a common header. Plus, it also introduces 
header ordering dependencies (need to include header with definitions 
before including this one), so I decided against it.

-- 
Thanks,
Anatoly
