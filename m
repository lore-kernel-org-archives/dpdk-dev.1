Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 15:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A82402F0;
	Mon,  3 Nov 2025 16:51:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AB53040281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 16:51:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762185066; x=1793721066;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L18VUVpiO0F2ejXC9X6Ul6MviWG8TGjUqYTTuifeWa8=;
 b=BGXzNOcG1Irv0095OLok8sGfJ5IkFCTxz10VbmF9xHacBGPxukh/rKBC
 YvcB9QoDfILnI55rwdSWOe91cfUpbutn2iIvuFC2EYnhYAqAhXYUy3A0T
 i0SzVockV1iTgJGiiLsg+wW7GMBNQXk0iQrTYVaVjewzGEu4R+xhbdIcM
 t+41vRrUV74G7zcXn8IWBw8BObYecGA8WMJ5d5C4jOpsYhrSoOjC6xAv8
 dOJb/YWNi1iLdcsTIP2kduvIODa0bt/SPq3nc6G542N9OGfXKba9RkBKS
 lqv1dsRIHol5oTTLL++8ZgDPu7bPKzqssd1cMH+ps3lo5uP0TyQS+TYgd Q==;
X-CSE-ConnectionGUID: wwXql4z6SbC/Go9n2Ieomg==
X-CSE-MsgGUID: tYoTJB8eQgOw0u340lPVsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74940620"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="74940620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:51:05 -0800
X-CSE-ConnectionGUID: xpi8Eb4VTuG4nx4vllGbcw==
X-CSE-MsgGUID: ozfDhRmCTFGhvC8/Y9npXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="186574221"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:51:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:51:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:51:04 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:51:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKnYqFoq+NnbOFifSO+tkRSSF/Bh57Xl4Xty4IXJxUYLr53w5HBSGmOrDoslD0HLazQlKu3It1dhW2h78+7av2gcV58tuaQKm9xa9xJ4y3ZXikxWv0w5Y114MKODNou0JU8kPSZKUk1rZi8ekvo5MW5HwonCaPZmhmw/5RBSvfF46YLKMH3jxpDQp6yalwQuKwRlGfkEZdTJ2HFBbpbySmoF1K/e9Jg6yI0r+XZ/cbqUvjjPFUCiwazbdhJXccmfjdBUseBkzfMuNJjo91EUoOO3P+8CzQzCSVCBBDY1WPuawWQLaNB1uRoc0gORWf+O26VfvVLALrhkOkftq9YsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuZf3AZM+jje58Ly1ij9Xg6Qj2Rn0USLMoU/0h3mFT0=;
 b=EIiy795DljxHJ3uLfZx8gF2mIiCEq72hoMgxO8qkvIxI0D00JrNa16J+P7PZtlPX49be2wHidX7cTQbYSmsRdPyG/Z97pk7Q/tgcD7OxUUM4Y8TL2VqPxCSOntdgbfcQ+4jV/9NHhT30nvM3XFixw3hMEtGRf/2W9VnM1pzCB5VorHCFE+Zo/w3IfbOj1EYd/qdHO/2Kj9r5NKpdM2ytr2R5/m80kiyz9BfGSbEh3BH3ifrfbLV53uQTn5JljJjs+d6ps2n250bmuvSGmLIAO3GLj1Povr0HSHx1mpIRYvSL2SkG7gdJVJNMv5YihM0KjG0wj9ef1QXnaYQSbhTE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by BL3PR11MB6434.namprd11.prod.outlook.com (2603:10b6:208:3ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:51:01 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:51:01 +0000
Message-ID: <a208388a-4db1-44d3-8184-f2c3ea355a65@intel.com>
Date: Mon, 3 Nov 2025 15:50:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: update documentation for ICE DCB and PFC features
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
References: <20251103150237.958606-1-vladimir.medvedkin@intel.com>
 <aQjF_6Gne1Wpk1OM@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <aQjF_6Gne1Wpk1OM@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::28) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|BL3PR11MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: fff761ca-038e-44b9-bdac-08de1af0c9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmtBWlh3dGRZcmlBSExvcUxKRG5lZFVpcTR1R3VpMHZ5U3V0NFdsOXNJdnpG?=
 =?utf-8?B?UHlFbjdLVE1nU0VDMWRvai9kZDVhOVZNMmRJUWpzT1NGWVpaQmhxT0UxTkNX?=
 =?utf-8?B?N3lleThzUUhqYjJ5WjU3ejRxTy9UUkkyWC9ZdDMxVDVOdytVcVB5RDI2Yy9k?=
 =?utf-8?B?a2hzWk4wVEtWT3JENENkVEJNRmhDbkxKSTRtNmphWVM0emxNY0taN0U2d29y?=
 =?utf-8?B?cVBQRzZMTWEyY09nMndHMVZqWmxhVHBDVjBtZmgzb1dNQ0JsQlcyWHBHWXVw?=
 =?utf-8?B?c2YvK2JuVFZEVVFCQ3BqQ05XQVRmZ0wvb25QSWtEaFVMU3VzNElwU2s1cCty?=
 =?utf-8?B?cW9IQzFwdEYyTEFGa284OGFNM3h5WFFYREExdHRQRjZqemJXdDB2SERTSFdW?=
 =?utf-8?B?Y1g1ejU3bnU4WE5GY3hvQWVGbFFyL0lwY1ZZNzNBbEIwc01UamFiWUlJQTRC?=
 =?utf-8?B?WVdGaTcveC9Ydjgxb0xLZkJFUGRpaXFQclRIK2l2alErMWhLWGd2TXpQYUlY?=
 =?utf-8?B?aERxQnpaSmJZMW41RjlGNVFXWkJDckVYeXdhY2hrNnh3UVhjZFlmaGRZYW1z?=
 =?utf-8?B?eHNwcG1PNGIvVWpGTEtXL0Z0NkN1b0R1RmNaZ09EaDhtOWI4OXpEdGx6aE4y?=
 =?utf-8?B?K1hJNkp6by9aYmxvNzVVOHlGelZhL1Y1cE9ndHdxR0NwWVVDRlRoMDc2d1V1?=
 =?utf-8?B?cWpmOEQxQlozKzBjSjNFN0t1V0I1THdKOVdHZXBGTTZJZCsxeTlkRS9adjUy?=
 =?utf-8?B?WndBdFZOMi92WkhaYTRGODlUMFNsNStFYzBMclltRnFlQk9jWW1CMnAyM3VF?=
 =?utf-8?B?ZWJ1bkJYcmcyZ0FNYVRvY2o5NE5MK3A1ZmNTODlrWFpzTkRaVWRCemxEbzJu?=
 =?utf-8?B?dDd6WHFBSjNSdXpnQmNBbXFlUjg4MXhWVlpMazJKYzBDQVR2S3U4elA1MGZl?=
 =?utf-8?B?SHNYVHdFV2FpZEVjMnRTakZxbGlhNktlOHNzMmcwM0lMcGVBc2dxM3NKdFM3?=
 =?utf-8?B?RGQ3UUdudWpxaytZeERBU1o2ZjRaMmg1NjBjanFKRW5wRXphSTVYSDh1QUZ2?=
 =?utf-8?B?a1d3ZjFkNEFRc3JSY1RuaFg5UE9uclJlWExuY2VNdVJlaTRCY2dIaTJBeklD?=
 =?utf-8?B?SU5NWVRrcmdFK3N5VHB3Y2Y0a1NHQVp6MGpkTzdzcm4rVmlqNUZjTlpuUURa?=
 =?utf-8?B?QW00SjQ5MGVsTkVwYWJPYmhCN0tnWkJCcUJ0MFExUlJZb0haZDlkcDFjSzFu?=
 =?utf-8?B?NDlETkppMXlKaXFOdXZzcTJYcWJ6ejdzYURhYVVUR2owWmN5WjBIUlZFTFRH?=
 =?utf-8?B?RDdJeU1SVWIzN0pQUSsrM0tPdTF0YUZES1NnZFFNajdFbHhUeGh0YmVBeWRJ?=
 =?utf-8?B?d2d0YzkzdWhCaVFpNlAyYmFqRStUeWt0UDZGZ2IxaFFXUWoyUDdIVy92ZTRC?=
 =?utf-8?B?K0JiUndlV2ptWTUzVlhPZ1ZGZlVQemRlVkxuZjZsZmU1T1NuT21vdDg2VGFJ?=
 =?utf-8?B?bmt4WnUyb3ViK2xGNi9lUTJOUkQxNmdDWTRCWThBTXBWVXVQWmx1ZVFwVkVk?=
 =?utf-8?B?d1NiR3U2cUdONlBXWkQrZHM1bkxuN0FlWlVVaDBQVjRYYk9hRlJtVGNyZUFR?=
 =?utf-8?B?L09aMzg3T2x6bDRhdjVScWxqWnBnM3prRzdkVURlV28zbFllK3NRUVZqeVQ4?=
 =?utf-8?B?ZFhGckdiZmdPcGVxb3lOOGZSSE5EcjRXOCttTFBMOVE4M0h6K3hsL1B5cjF0?=
 =?utf-8?B?NFBhS1dFelMwZ1I2RlpHb000TS9rU3NOVmFta1hGSzkzK1FMa1dRdUtEcy94?=
 =?utf-8?B?VTFRb29XVjBoWGxzbFFVbTRWR0FaQzBMNm9uZ29zMit0dnNDRVFWbngvSzBJ?=
 =?utf-8?B?OUNnWTV5S2t1bXRSb3pzNUQ5U0JYZEkyT1I1Q0NlNmZWMytGYm03SFlKWkhh?=
 =?utf-8?Q?ON/O1RHYVe1hSQpApFpuo5pCY0vcflyJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWc4c01KYlQzMDU3TDFlL3pMMmhtL0o3d3FtakhacnhYRXpNdlFwaGVMeEFD?=
 =?utf-8?B?b1dnN3FSbkRKaDJkYUdxZmY1MGJJbStHcUdZU1J5bHV0MXBNYm90dzJ2S0Rn?=
 =?utf-8?B?TzNiSlFNSnNReGdtOXpVZ0FVZmF4WEc0cldsZ0lsYVQvdHdxd2xkYXVhdlQw?=
 =?utf-8?B?cW4rUzlNcVFWcGtmdnpubEF5UzgyaFlXdG8wODgzQ1MzOXZuSW40SXVEa2Ri?=
 =?utf-8?B?WVhqQ1NTTjJmMyt5Y1dYbWR6ODdXSnVKcjVIQTNxS3g1bTZsUXV1V093cUtZ?=
 =?utf-8?B?ak5WRUEvdWVOaTlWeDdicGh5NEp6ckFYcjkyWmRlcytwM28rdTlTcUxLd25H?=
 =?utf-8?B?dTB4ZGEwSGVnM0h5SEdBM0xmeUVxdFBUUFVnallwaGs1V3A4cnpmeW1YVWRV?=
 =?utf-8?B?UEFrSEI0c1RMWkNvRy93K0Zpek1WV1ZDTi9HbFgrY2czRGVmazgxbVZycjFt?=
 =?utf-8?B?a21RdEZEMDhNN3pSWGFDVHMxb3VBUEhkazNkRVFRaHhTYU05UHBJYXNOcFdU?=
 =?utf-8?B?MitjdXRyMUlvcVRPVlEzQlZlY1YzVTBDSXlEYjZ3YjhCY2J3dllBbk8vbmpS?=
 =?utf-8?B?S3lvSDZvOEl3TWNkdFhHMUNBaS9jbG1nMU5iUkh5NkdBMFdBVGdaUTRsTVVq?=
 =?utf-8?B?dU9FS3JCbDVQTDhaQzZxQWJ0R2pFcUU1UVV4M1dhdTFhT0taWnN1TTQ3b0Jo?=
 =?utf-8?B?bVpvQWNYSXZ1a2FibFpNVXJHa2E3Q1U2bHhNdE9qUXZBdC8rZm9oNDRZQzZk?=
 =?utf-8?B?TGwwTUk0Y3pXNHZvU1M4VHoxQmZmRmVmV2tOTHJFRC9TNGtpYWVHSDM2cHY0?=
 =?utf-8?B?TlhCMUdOalNHUTIraWZFWEpUQXRIWGhCNyttRm5sa2RsTjllbm5oWDVDYzRZ?=
 =?utf-8?B?bTlwOHQ2TGVnWW9XZzZMZkYrRVFicnZzWE1nVXBhS0FqRXcyb1hhT3hJbE1W?=
 =?utf-8?B?aXNhNklyY2taOVQwSDV2YXcvcllVRTBKUHEzYW00bG1OQXk5RVI0cG9aQjZh?=
 =?utf-8?B?RVd2OVo5L3BGRDRxMERzdGRpYkdNVUhxeURrYzM5a3crOWQrUGltSHJ5WkJJ?=
 =?utf-8?B?RVFsc3JsdlJRMk9pWVFaeVhJdWhWa2dYbnJVNGlMczF4dE92c2phR2Z5ckwr?=
 =?utf-8?B?WUNOc1M3ZHIySThRaThOdHJ3aGpONndiNkdMMWt0L3M4UllVUXBja3ZwRnYr?=
 =?utf-8?B?blpyMnN0VDdEbXE2NVhMZVBySjJ2dm10WjJIcEhRK2dDbXg2VHBWR0NaTVJG?=
 =?utf-8?B?WUFPMlI4OFNqZWpDS1BXL1Z0UUdHbTkzVW1BNDVja1JWditTQ2VUY3RYY1k4?=
 =?utf-8?B?VnhHcnI4OGJCd2dQRlArMWYzMkkzaXlsaGk4bnZseXh3bFZqMFY3TmJaTlVt?=
 =?utf-8?B?QXE2YTI1ak91bFp2a05NRm9PY25FVFVibENHWWduWUZmSkw0T3NPd1hjbFpK?=
 =?utf-8?B?N1FPbDhlTENLS1BReEdiMVJSeGl6aFcyWHFHNmkrelFtd2NURm14NFF2c3pR?=
 =?utf-8?B?UitQcVlsb0c1VUlDZDJEUFlzTUt5RE1HNERHckRiZThKQ3VyaTg5bTAwcEdH?=
 =?utf-8?B?VW41dGh4R2l0b1hHUnRwaVJxVXQyekZkOEowSjdnYWpraTdoR0lrRDZpYzZV?=
 =?utf-8?B?NTNJNjNUdy9Lb0pBcW1vVHc0OEpOd0R6VDNwN0Q4UWxURnZGUXh3NWhqRkd0?=
 =?utf-8?B?bk1HUTJBdDV6L0tHdW8wQS85THROeWFQaXlsQ1ppZnoxZXVuajlsa2ZlN2V4?=
 =?utf-8?B?dlFzbGFBTkJLaHpoVmJvQk5UUExoQnlMZUNVeVhFWGZDT2Jqb0pZZVRJL04w?=
 =?utf-8?B?SkQycXJDZlUxSFdYVjltNi9na1pOb3ZqWmhPSHBENUMwak9DZjVQcGw1WmdD?=
 =?utf-8?B?THRPZ1B2YnNrRlhrZ0xocXgvNWlweHUrRnZicGhrK1B0RVFrNktkMll5ekgz?=
 =?utf-8?B?eFh0QllyR2E3b3k0YitVL1ByamRZRnVCRFRhRTRLS29XZlRRUEVhS1N4VFFM?=
 =?utf-8?B?MHNYdWVaaEY5SUFST3RCSEhMbXo4bmlFTE5VdU9XNW9IYWZvUXRBVFhXUDhl?=
 =?utf-8?B?ZHV5NFgyR0lqc0tra1EvNHh4ZytBaFd3UjJvcFRZeHpLV0QrV0YvRDN0eWNS?=
 =?utf-8?B?OFFHaDVSTnN6Vk1HKy9JMkdPRFUvNlFmUFdyV09jVWxFWTR6UVNFNmdFeGUx?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fff761ca-038e-44b9-bdac-08de1af0c9f2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:51:01.7890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg+ysThYS3g3cAs/+0IyB3g6YmEEk6PiKYV7fSheawIfpRQ/oCEnPOL2xN/C4FXmSbwviQZYGLZK+EqWkbpaqb0pI3bDJQB+bMUvBhIN4vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6434
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

Hi Bruce, thanks for reviewing, will send v2 addressing your comments

On 11/3/2025 3:10 PM, Bruce Richardson wrote:
> On Mon, Nov 03, 2025 at 03:02:37PM +0000, Vladimir Medvedkin wrote:
>> Add DCB and PFC documentation. Update feature matrix
>> and release notes.
>>
>> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>> ---
>>   doc/guides/nics/features/ice.ini       |  1 +
>>   doc/guides/nics/ice.rst                | 74 ++++++++++++++++++++++++++
>>   doc/guides/rel_notes/release_25_11.rst |  4 ++
>>   3 files changed, 79 insertions(+)
>>
> I should have noticed that this was all missing from the original patchset
> and flagged it before merge! Sorry.
>
> Anyway, thanks for doing this now - better late than never, as the saying
> goes! Review comments inline below.
>
> Thanks,
> /Bruce
>
<snip>
>> +
>> +PFC operates in VLAN-based mode and requires DCB to be configured first.
>> +
> So this means you need to call APIs in a specific order?

Yes, first we need to enable DCB with rte_eth_dev_configure(), then PFC 
can be configured on each individual TC. Generally speaking, PFC is a 
part of DCB standard so it should be obvious to configure DCB first.

>
<snip>
>> -- 
>> 2.43.0
>>
-- 
Regards,
Vladimir

