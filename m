Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19135EB4917
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DD994027A;
	Thu, 12 Feb 2026 13:29:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7AFB640268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:29:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770899351; x=1802435351;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7h6w+HPAcSr7cAfeIaUJwWDcAj1l6J5ANVF3JM+3ELU=;
 b=RROZlWvb4KEfYwgcG1KtYm7Uhh4K3fszxTXm1qX2PtRBlL43CtC8u+zk
 efkdaPvxFz5LJVILTLGnAVyn2ihcILaJmQebtee887NRRDNc6/MWtMqhv
 B4ds757zQCBlsADHO/GOyvUQj6/u8mIVxCEXl1oOhq9Ph8d9T2cQ8ASD/
 ifYLY3Rb/sbD3qvCAeEbIgUSHBXuyLBU2UmIdmMP6Egmv+GpfFB3gdjzT
 TBthVXhp5tRsnEG0yHm+lPrztJ3vsH7fcsOdcmhV3vrZOEDvPGbMoCBW/
 K6VhWIs4eE2R+q2YgZ3lfGBHzLxdswgvBzO5pGGo4D5J9n+ifo0pI5x+V w==;
X-CSE-ConnectionGUID: sR/Axb/PQYW+JFyR/pBR+w==
X-CSE-MsgGUID: pudVZhU2TTGxkhqWoBDytg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75912983"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="75912983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:28:52 -0800
X-CSE-ConnectionGUID: c7ObfegRQ0qLU5WjKtTqiA==
X-CSE-MsgGUID: 1CtQGtqoRlqYC8TmtNh2AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="217062963"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:28:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:28:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:28:51 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:28:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApacWO1rxro/q6QYKBBQ8qbv0PLGHoWxbfDqmTN1+y8mBt4ZLbfXZco4YwJ2JUe5OBNl2B2ZKQvPxUJ3nF0C3wUYUM2pgcpdNV36q7jLClshDaqf0dPPF2Cir8f6V9+YzDonirHax4LwNn+dlC043GrxGTTWfOjeyUaCZZnq7kQxd3njocUabka/GRwBMKona3f4cXXpt+LwQbQTEyJcimyz5y8FwIB9s+AZtwgysTXAA1QZKAU2v6kGHHMwgSgarcvTiwN+Dc+KreilhZKACv9SUowLUG1IRcGH9TNllJkob1+5AAfGi2rI+sYUtwZhp35pgH9ngxP25YISu+BLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o5IerRUkiNARHxlgOz+6ZpACLAsiFo9sY4Hg7brrSo=;
 b=j52qLQrW7aujl7ZEFqAtGpEoEguSQ/13JLTQNB0cDV6eSq7PcI5TQIbPFBRhqpvEddu7Og3b32/8ekx7SP8k28K/RLwYrb6ALkAmq/sQtBy4mJ5i8BBD5UpWIkp6a3/bH2Lg6GDnXdBCP+itQolXaHHKOUjo7p68qrZhjhLgVepRTi8xs6/qUQdqqWs4mMpKe8497i7CjlvZV53jabiqfi2uviGybUmKxNTZFMOIdxuZo2HW4PMvfrjyt3VD+R0gHYNfRxcm5L1vxclAoqXVLbPJrxBOe8Mb3HaQy+IyfV/vj6kyPZ0zXesBaDdzxCWYNwrbaFLZDCpgi/uDaiYxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Thu, 12 Feb
 2026 12:28:49 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:28:48 +0000
Message-ID: <e7f8b156-5ef8-4de9-bf4e-ac6efc11e2bd@intel.com>
Date: Thu, 12 Feb 2026 13:28:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/35] net/idpf: enable simple Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-35-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260211181309.2838042-35-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::39) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA0PR11MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 237169d3-e8a0-4949-1381-08de6a3245c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDFTS1RrdGVkc1dmd2JzNTVnYXJXTFpibmV5VWhSRFlaeW1hNU1ING41UEV3?=
 =?utf-8?B?ekNwSE8xVFQyb3o2aXh0SFBjTXBPSVhnWFBFSy9Vc0M3dWtwR1dpbmZNTGJV?=
 =?utf-8?B?eUx2UHZpbDNaWGwxS2Q0VitxWTk2M3VhZ1VuRFRDNjZwTmVkY2ZKV0d6MXBh?=
 =?utf-8?B?UEkxOTJiMUFMVjY2Tjh3bzNsWWJrRGZkMlNjcVg4ODd1UXBkOXFPa0xGa3N4?=
 =?utf-8?B?cVVUUVF6Q01VTFhoZ3diTmwwVGFCNHlHajVOTXRuWWs3a1laU2JkYzVBOWc5?=
 =?utf-8?B?cmlKbTIvV3dRRmFRdGRXa0tVZEpPK1I3bmJEVXlxL2N6UG5lV3lGYWdyOWF3?=
 =?utf-8?B?UEppdjAwakQ2SFpLVCsvck1uY0Fkek5JK1FTVGpad2RQZHRObGdTZ0UySmRU?=
 =?utf-8?B?OUF5MHVzYzdIQVdEdERTU2VDZXFNdmEwcXRmd0d1Z3lFOWUzUkQwSWowS1Ry?=
 =?utf-8?B?bk5rK2ZyWFdLYVhLUnJIQUxud2tMYlFGaTVDdnlTVXczTGhJZGduMWd0OGRn?=
 =?utf-8?B?QXRLVGlLRnY4c0MzdTRIdmd1UHI3WWkvOWJBbVpqM3daZFd2QThvVlRTbnYv?=
 =?utf-8?B?WjRjSlpGelBiekllSVk2TDhlamVlVGEyRkRITGJpVUFrM2phZXhDNUJiQXdk?=
 =?utf-8?B?UllvenlrUjFCaUJOWmRlZVE1bW5zYUFNV1hzTjRLcTVQVWpUZCs1bHpSVW5T?=
 =?utf-8?B?QW4rMTYrMVp0Zjl5aXBPc25McDVaenJDWEN0U1l4NThrM0NsNm4zdDhKdEto?=
 =?utf-8?B?SlhNc3pXNE1mbG5vcTlaWXpVZjBvVWpta3dhcVgrZ1FiaGtWMnI5STBXekJ3?=
 =?utf-8?B?dEYwNVg5SDZHT1hyM0J6dHA4WjNsdG5JOGJqRko4aXVoTkRRZGtxd2s4VUl3?=
 =?utf-8?B?T3lWcFlXSDJDeXlDVkVSMXdEdFVzcmYzdkxLejhjbGpIak5HM0E1Mm1ORncy?=
 =?utf-8?B?OFRLUzh1V2pHbC8zZ0tXSk5EVTVMYzdRS1R4Si9vVDBxL0pHS0lFVEVKTlBE?=
 =?utf-8?B?eTRGZm04K2pwQU83Sk05eEFocVE5Rkt2QXJZQi8wTHQwRU5zYmsxTjZpeUhR?=
 =?utf-8?B?cXJ3UU5aeVZ3ZkpDY0g1M0JjYmhtVUF6NnpjVlhack9jalFERGFqMnNmdXNq?=
 =?utf-8?B?Vks4a0pWdXlsSmdLQTQ2UnFsU0MwK0pYWWc2YTk1NnBURFlsSGJ3ZFZMNkhz?=
 =?utf-8?B?VUlSd2orVnM3NjlTLzBrc203VC9YYUwybzZWa0ljWm01OTAzRVlaSkEyTmt3?=
 =?utf-8?B?b01pRmhmUTQyTUJyU3BPVzc2VkR3U3BDNExjMDZSRDlxM0VsZExYK1NLend5?=
 =?utf-8?B?Y2duSWV0TlgxODBnbWQybUtzR1dBL2R6b25WU3ZOUmYxcEpMdUNnR1VoNG1m?=
 =?utf-8?B?TmQrelg3MG9jSnMyS1plZW5nRm5FV1Qwc0FNcWV3UEltcjRBeVI3Wi9lNDhH?=
 =?utf-8?B?K3VrZnhnVzdMOHVjbkNrK1RSSjNjcWMxN2RVNlVBSlY5UFJkc0c1ZDA2dzJ5?=
 =?utf-8?B?OUY4eDV2cHE0WGh2UDFLNkdlbXlQZXNVclhibitHTFZocFFSZVR1S3ZsZDZl?=
 =?utf-8?B?TzNOaFhPMUo2ZXJRcVhmTE8zNlhzM1hJMEZZN215LzR3dm1TaGF6RXM0TldH?=
 =?utf-8?B?ZTBSWm9FbWdGalRrTXhqNTBpdjhuU29ZamFNOXhva1pVaWtUVTFvcUhrNzZN?=
 =?utf-8?B?ekN3REUzb09vTEkxYkI2QWxueFYxN0NwNjIweXdMTy9lNjBXdmdYRzllV3pJ?=
 =?utf-8?B?VERSTTRQaStnRU9UYjQxZ25Kb1J0RTBGQnNJYmxXcUZnOG9vNDY5M0VGN2xY?=
 =?utf-8?B?akZQa1JxVjZ6S3c0VS9Yb240Q09sMDhwOEVra1dNN2owSzJ1Y2liMWUxeU83?=
 =?utf-8?B?Z0d2QjZtWithY3UrSVpZaFI5MytkOTVvZVVyNkxGck5wKzB6WDZVUWVzVlAr?=
 =?utf-8?B?cFFwN3VZQkR6YVFZd3VVWktjYW1UZXQrVWczbFhhd0ZhTEd1QUZxMEIvSERq?=
 =?utf-8?B?WXZHc29KSVZ0ZkV0bDdDVW9XV0hqcnJqUmlzOTB2ODBBbXR6SjRlMFZ6UEMz?=
 =?utf-8?B?Ti9IMHdOWEdqb2tqYk93NjdYQUpWVlJOYkNIRkgvQlVKRXVzaFFMZGI4WEFQ?=
 =?utf-8?Q?Xsyo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ptUFVVMDJTbXFINHVxRmRmL3dZV2NwOVpKUEo0U011WEEyNVRHY1ZNRkN3?=
 =?utf-8?B?TmpkY0dkU2I2MUZQRndyTTdiMFBNcHJRdGFIKzNCa2RTeENtMXlkbTN6Tmho?=
 =?utf-8?B?SzIyQ1ltVUhJQlByTVExNTZLRmR3ODdYMVphcnQvTFAra3RSVCtzeGI0ZU9C?=
 =?utf-8?B?OXFNanA2c3E1Rm1wdGprRWJ3d1lBOVQzY2loaUY1TGd5MFhDbTcxMWNGUkZM?=
 =?utf-8?B?TjdSY3FlRlhHTFZSbEFLaDduTEJOOTFxbXR6eXhURGc5TVpwd1YxQk5WV1Nz?=
 =?utf-8?B?Nkp1c01JSWlEa0pMY3M2aGdDNm9IVzFSTi9aUGs4V2FrSXdYbEhuQTVnd2o5?=
 =?utf-8?B?dXlWbXpVQWg2UC9KeUhWdWdOM1NBRFBBNW52NW5NQzZkQ1EwRk16Kzd1UXVo?=
 =?utf-8?B?aVRsNloxckY3VVVnSTFxOUpPQ1hkK01oYVZyZ1lVUlE2alVseWNYbUhLT0hQ?=
 =?utf-8?B?ZThZTHpqK2VNSmx1V1ZTYVltS1FHMGJidHgxSytNa2lqT2N5MERIQ2R3bkU3?=
 =?utf-8?B?NHRqYVM3QWxUUWlCdlZCclF6NHAvL1k3WGdnLyt2T2NpYWQxNzNCdXVxL09u?=
 =?utf-8?B?OTVYajFzT1RZTHVqNlhqRElCMnJqbFJ5Wnc3TEVjazhNZVVKN2F1UUFYQUhE?=
 =?utf-8?B?Z0o3M0NWWGJzSU13L3ZXWHcwMUJqM2NLOFMyWXpUa1FNbHJLTTB1TlRxL3JO?=
 =?utf-8?B?WDNjYTZGcGFtMUxkSDdGd2tlUkxYSkl4eThjT2IwcjFha0xmemJEYk1OSzRP?=
 =?utf-8?B?YkV0MTJFaVRLZFFJZzRSS0IxZHVPdmUxOXhGZGlmOEM5U1lrSjFzOWxtKzV4?=
 =?utf-8?B?cHJBSjEwOE1aZzhuRmZRWGVEc09rcDkzT1Z4dG1ucUlNLy9DUlExZml0SitJ?=
 =?utf-8?B?eHo0aE4wUnEzdjI3dmIyNmF1Uyt4RWV5dWcrbldqR2kxNVRzUEk2TzMrbUpX?=
 =?utf-8?B?UFRodUlWay8vakpMZGNMRS9xMXh2dDBvWXJuKzVTMjlFMWc1NXpxNWlxMXJB?=
 =?utf-8?B?Njd4WXRsUFFrbFJDQ0JIc3lyUEEwa21scERCUnhRZ0Q2MTJHaGZHdzNLS0lk?=
 =?utf-8?B?N2pmMHBCMUJTL1NpL0lxSVJZU1NwVkplODgydjI4Z3NDTlN6Yi9iYWU4QVV4?=
 =?utf-8?B?K05aWTRnbW5UY1VFcm9KZ1FUR2ZEaVY3cGtDazZtM1I1TnA0RXlXbjFwZ3pu?=
 =?utf-8?B?WHNwdFo1QWJsWkhEY29jbE5RVW1oUldmbHF3dU5DUHdlOG5mVTUxVXN4N0sy?=
 =?utf-8?B?ZWg2V0tnNmFRRTZFV0lMNW50M3p5SGpsZDdsamZqdGpPK1NSTm1kazhicERV?=
 =?utf-8?B?ZjNhb3VFeEZDS1l3RVdGcHlUM2x3aWJzcTdJemV4cXlSbGZ4ZHRlbElFOUxV?=
 =?utf-8?B?NXF5d2JUU3NYTlVaSm8yTkhIdGcwbVdRRStFQXVqdzUrR0s0U1J5Z0FQN3RF?=
 =?utf-8?B?c0ErTm10cHUzM1RENGJKU0hPQmVyOTNpbEk1d1Vyak9WckFuQ1B1elNRMUhV?=
 =?utf-8?B?WlkvNnd6aGtvSkllREVqYm50MmNYNGluU0x5QzdaUlVaTVZWMjNoL3kxbVMr?=
 =?utf-8?B?Skd5bjRlRnpsc2l1T0Y1N2NIUjFKbnFRZzYyMEdZa2xma2J0YjFuOURHaUxP?=
 =?utf-8?B?RTlyeHY3a2NGaDY1dGs0Wmthc2lRL2VjRFVlSDBDN09jSUd4TEhXb0FiWGJl?=
 =?utf-8?B?MlZ2L3pKQ2pmdUpqNnRsNGgwQU84ZTNBOUtaZmRGY0NmZVhtY05FdlVzNlc1?=
 =?utf-8?B?V3hqcDUrVGF4OU1RWWFXZVduQ3ZKYWYxeElCSkdURXRkb0dzZVM0bFhEaXZs?=
 =?utf-8?B?ejVrVzlrL09rWmhqa25jZ2lyOFY4SzV6OFBWckU5eldyS0d6NGI2OHFaK1h5?=
 =?utf-8?B?RDBNTFUycjhhR1Z1Wko1RmJMMGlFWHBpQ1hsYkQwemdrTTN6eVd1aFphZDZi?=
 =?utf-8?B?c2lCWk91WG92T2pWN2tTa0JhSkNIRmtDd0FyVXMxZ1FIMHNicElCcU1ITUg2?=
 =?utf-8?B?SzlWR0VWb0MzQW16THgzK0lLWW9zd2xwUDY3ZXFzTHBJT28wYjV1SzJRNHh3?=
 =?utf-8?B?bzFIdWJSeURuQnJrNU14d2hlM1NlQVNaaFVtR3JhUWxHMjBta1Z4WkRhQXc0?=
 =?utf-8?B?aFpvNENZeXdTYjJrRlk2cVQ1MEN4V3FDelMzSEQvaFB3YVNra04wclh1R2I4?=
 =?utf-8?B?T1ZCUGtSOVZGZk9rdUVva0tmc1Vla3FCbjJTU2dzRzRudXJTeHBadzNidUZa?=
 =?utf-8?B?NEdncE14aFBucEVRekhsOUl5NVFQblUyb1UydDhHQ09qOHhvL0FXTlpxcU9x?=
 =?utf-8?B?RWFPSytHQjhQM1REcFpJOHpNVkZNdVNMZDhxTW5pYWliV1FmWmhVWWtOcXVR?=
 =?utf-8?Q?fWKQ2gDaOoaqj7tQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 237169d3-e8a0-4949-1381-08de6a3245c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:28:48.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2uBi8MqtQBJ2ElxteKRKvhuKoFo/EbXir4/MSVD89rgJlUz2pWu0RSUyuooXnDT+tynLOcmKYn+hnLoJqi2Zgo/RFk0P3ycpQdIT+EqBfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
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

On 2/11/2026 7:13 PM, Bruce Richardson wrote:
> The common "simple Tx" function - in some ways a scalar version of the
> vector Tx functions - can be used by the idpf driver as well as i40e and
> ice, so add support for it to the driver.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
