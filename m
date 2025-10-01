Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C29CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 14:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5563402B5;
	Wed,  1 Oct 2025 16:03:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6D6E94028F
 for <dev@dpdk.org>; Wed,  1 Oct 2025 16:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759327415; x=1790863415;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CndKuTaSiLi51B73GMffFN6MwKxXWZG0+xRptdfu4js=;
 b=hAus/sxZz/nyL3ZcKdeiSNuxuvj2mHLLj//ihrnLM/R04NDL7eswOoTn
 h/ItYavykLIcbSOk/+SweHxQYkp8/qPi75YK09x7jP+rzPreGPeADkkX0
 VGqbOxnln3evRwveu6sGzobB9YHYXzYYlDXNnc9WAEppgVCK5940gdREK
 xHrzyIaHm0FTF+llbr4jBrwZq11PJ3C6C5y11adicNT6blIBuZlCBhIaI
 lSrH4VWKvBiGF6xYcvTdmJKYQCGWHpl24kuTjIAjDzKXGcFle55Elu0bS
 L2VKU1TPLy3zHRrdwFagP8llliZ+/fvF/9SnzxesdMnbdZ6ZJ2OOyfkSY w==;
X-CSE-ConnectionGUID: guYjfehmRcOioiUIILr9hg==
X-CSE-MsgGUID: BzCOJXsOTnOcRZYMIyYYnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61514734"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="61514734"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 07:03:33 -0700
X-CSE-ConnectionGUID: F1uRctD7RP2FLoGJWHCGNg==
X-CSE-MsgGUID: dDYwryhrRoqpRmX6FLdrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="215924002"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 07:03:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 07:03:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 07:03:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 07:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLftwEyEZG0ZXvz4hfTa+IeHxxMDFulo0lodcQn+ig2pIo6nusAeRrGlOe3wy9AFd+YjvlHNOAbDYXXUchIHOKYs6e4IphhUY9R4Eow7OSoleaZMamX8uOaNOCyDtq6iFhV0Zgk8aWtko20k2drppnTwUAt89+aQu7vuX8AsbUtKAdOWlKfaSv+DiR/MIwLNFyiYieLWUj0ZCfVky9EcIsYPF/2e5sjlT5YApIYIUHkoHud3rUuxuKX7tHT8rmRk1sPIJKkeGppIXTvCGUeZBtSmabKBQKGEcNQclX/AvXmcXlOm1exip+xBRecYt0dl+dAfOZY8oJlJL8jX5p56hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ALjbiBByBxiGDwHZQJqdQrsY4n2PCPUnlt2XD7Z+2Y=;
 b=YdF9ZOfwN2jX852ASKOS9MrsAnEK0BylwS/Q4T8i/MWWFmjzd+++E5PQJ1CQB4X+CK8cJtVtrHwqOZaF8OnEPvpdrlI9Rb48lCpaoDrbCc3oyPYs3Xi1FhLjqecJPlTllwKl26sOFRXUql9KgkdoJmTc6xKv3lyIR9VOqSAc2W1ZjkGu/bIEJdTAqTf/GyjXxDLHBwvJo84tZH+xGGKsOZHZJ4nRy+vzGP0XooKJvwfXNQi0QwTTrtNjC2BlmXxJLi6Bqfpb0ToIINdor5alhdLECybn8/d4Ib1E7sI62t6WnlDkFP2iIQvuBcjYMsHrf+9EMx2AFrqc1WwdKL9S5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 14:03:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 14:03:28 +0000
Message-ID: <9acb2557-1f42-4880-ba93-020b14e6a0f5@intel.com>
Date: Wed, 1 Oct 2025 16:03:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: configure Coderabbit
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <rjarry@redhat.com>, Aaron Conole <aconole@redhat.com>, Michael Santana
 <maicolgabriel@hotmail.com>, Thomas Monjalon <thomas@monjalon.net>
References: <20251001081825.2638077-1-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251001081825.2638077-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0283.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 563fae9b-d316-425c-bf41-08de00f34bbe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEF0VjZiOWVGYXduS0RrUkhheXA4a3MrSGNGZmo1cGlzL0VsM1pQckNxRytD?=
 =?utf-8?B?NEhPMDNUMEN6d1k5c21iWmVsSGNzSVE0VHVYUFFDdVF2cHpCc2JYUjdRdUo2?=
 =?utf-8?B?ZC96dlhMWk9XdXpQdTJKbTN1ZUtqbklKVERRbWRaczYwVzlEdnFVWDltUmFO?=
 =?utf-8?B?ZlBWUmxOTGY1M3NtWU9weXUySzdlaXp0VmN0amJKcWorZDBlT2pUSWQwSzZz?=
 =?utf-8?B?dWQzMDZETWs5NCtBOHRBOUJoRTlVc1dwdUJBaTRkSTRQZmhkRHpMOXFsZTd4?=
 =?utf-8?B?TllkbEpHZGRNZ0RpL3F5R3ZXbnhJTEd1dHdFcVhDRjBHenRXczg2ZGpxQjNm?=
 =?utf-8?B?amdpWnFyN1RLRTd5WXVmN2k4MnVvdzJISlRwZjh1Ti9OWHhtbXhSRmYwM0Y1?=
 =?utf-8?B?WXlkZEJhemRUakhMQ1ZVcFV6U3hzcHQxRWhwMTFyYUtmUTE0Mng3RERPVWRa?=
 =?utf-8?B?WTNSNlZHUmN0bHVtdWVsZDBVTzd5d0JTeTlkTUZrZXdjb1BpRDgxN2hOOU5q?=
 =?utf-8?B?RWltbjZCV3p3alJrelZJczZaTmxqdjlDbW1ibHFnZmRXa2x2U0taTWJ1SmR2?=
 =?utf-8?B?S3BPNTdIYWhJNjdwK1N6TXNFVGg2OUV6OEJQNHBUbmR4Sm9JU1NQcHNKblcr?=
 =?utf-8?B?QmlrRU1uT3cySXhFektyRHNvaWZnRFUxcFRyblZGbkQrV0tiQ3N4TERWZjcv?=
 =?utf-8?B?bFR6bkJWWE1iSkJGSUR6SUFDOGJRTm5XZXBJV2ZzNWtvTDZpM3dDQjh4V2gy?=
 =?utf-8?B?RWZ2cXZzbnZ0Ym84MkZJa25wclpmcWJEWmdxSGdOVjFWS3cyT1lwMTBjaTJp?=
 =?utf-8?B?bHJPTU15Ky9SRkNORWs1UzRRU1ZNNHVxdDhLZHBCTzBjdVlpcjJHOUVWQTlQ?=
 =?utf-8?B?dzdjWDZkajVzcTIxZUxYQ0NWN1dJZjFabytEb3ROOXFQVHMvOCtlanhra0Uv?=
 =?utf-8?B?M1NpMDRqUHhUM1ZNWjVIbk1kMU9yWnkrZVhPZXBoZUVoeVp3QTNmS01SQkNQ?=
 =?utf-8?B?bVV5bk9aWGIyMEZYSk5SSFJvdVZNU1hRYjVoYmZqNDJHb0F1L25DMHB5RmUx?=
 =?utf-8?B?UFdBWHk3VHA1TXlnZTltU3ZoaXFrY05LM0xOalB2VDNPZWpKdGk0a1htL0hY?=
 =?utf-8?B?WDNZVk9FQ0N2S3EzVmdWMzlESWVCVmp6Nnl4ckJuRFFSQTJyTTZya0pQN0Zp?=
 =?utf-8?B?Tzk5NGxMRmViUEVVYkZ3R2J3MUVlakg2bzhYOCtzam9QZVN1MVhlUFdqczB4?=
 =?utf-8?B?dGFWYVd2U0k1cFpmOWFmSUo0bnFRVUVZeVk5L1JSZWs3c1lGdHVWUjlBeFNy?=
 =?utf-8?B?dzN6cUhueUJ6WXhuejNTYVRabDVVTytGcGtRZXBCUDF4MEc1WkdKeGE2aVBq?=
 =?utf-8?B?R2hTNzlXRFU1c01PeVcydk1EL2wrK2U4UFRTcXNoam1iNDIyZ2NJTjFYMWVi?=
 =?utf-8?B?YUJ6OGNRY3ZlTm1GSDJCTUhZSlp4YTZGT1dXaHl1a21hVUlydWhzNGlTUHlm?=
 =?utf-8?B?REZ5NStTanFjSTlmN1dTQlhsb1VIc1dHRUVMVU5uU09RcVRYK0c3NGxvUnV6?=
 =?utf-8?B?Yk9WSStOektUL3Y5dTY0T1lUZzdFZnlKZDE2Nys3ZkdKcFVuRFAyaTd2dDNK?=
 =?utf-8?B?Rzk4WE9qSFpqdkx3M3BHVTlzVlZPaGl0VnhKclBseG9rUG5rcUZuZnFKdi9J?=
 =?utf-8?B?ZHJ1TnpZVTRVSnV6TWNaMk1FTEs3T3djSldTQXIvVUl6R1hOMGNieTd1YkJk?=
 =?utf-8?B?UEVhclBZQTQ5TTRlU1BMalY2YkV5MWRxeGxvZDExT0lDM0VydUxZNmhINjhN?=
 =?utf-8?B?UTRRaVV6NVJaRVdHK3VnWnJ0czVqd29ldGpRdGJJdk52aFNjcDdZclVmdUUr?=
 =?utf-8?B?VHVzVmw0UnY5NFlkTGdha0RBeUdFTjIxR0hHWGpmdFUzNWh6endvWDkrQ1Fp?=
 =?utf-8?Q?JqAcvgAkF0yUfL2rS7JrtjX9Qpw8ygxA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJsWmFlYlM3ZzNObGl5cTRJckpYOHNka0Q3dytwWDZzL2ZGUGc2eVFsbU15?=
 =?utf-8?B?aWFQRUd0bFJOWnZQMEtWTmxDc1NEa3JuY3o1RHlHRjRZRHdET0hDdVVBQkhF?=
 =?utf-8?B?LzJvZklBMVFtVVlmTkY4cHU5WHZMZmNrMmJrZFJoWUhEdUpmT2lBVWZPdWF3?=
 =?utf-8?B?d1Urb3lFM3FJbDFtVWluWUtXbTIrYldkbkF4c05MNGJpTWZxWXM5ejZ6T29C?=
 =?utf-8?B?U2pvZ1BsL2I0WGFodkpTYkoxYi8xMjc2bWR5NVpsN0EvMEVyeDZFNVpzZWRL?=
 =?utf-8?B?ZUx6QlNtc0FreW5tUzdIVU16NWpwMVEvd0liWlRRWWl5bXkzbXpJOTFpM0NJ?=
 =?utf-8?B?V1Zwckc2ZXp1bmMvRlhZUFVKOHFxT1NJOG51SXcwZ3BtUzNzSElPNjVEK1Zl?=
 =?utf-8?B?YmRoVkx5TjNkNUs1a0hGWHQ0YTEvbFJqVXJhT0E4Vk5XcVU4bU83MFpHRkdZ?=
 =?utf-8?B?RVZvTitPSTZsRUpHZTN1aWUyS0ROU1l3T24zMVFUQlhZWmcybitHQ0ZxdVlL?=
 =?utf-8?B?Z3dzYTUrbUp0WXBHcmxDWm1Mc3hwc3l3cU9ma2dwcEVuSCtlakoxd0JqWWhm?=
 =?utf-8?B?UEJOLzZiRGNYLzNGb3VXYkhmaHdJVTJ5TXFWWFRIUjVKQklFZk5QM25GUE0r?=
 =?utf-8?B?TUZ2cXRLYWowZ0dkT0dmSGNQNURXWCtzcU0zV2kwVnlkdDJDbWVzK053Q2V4?=
 =?utf-8?B?TVZ4bVNGdEVBaXpDU2pHME84ejJtakd1SmdnVEJXYitrZkRwRWJDS05qSEZv?=
 =?utf-8?B?SjB6M3U2eU9kWXdpMVRabHZaTEhvbDFIK3JzRzZvYkpNV1lPbkczZ3N0aEg0?=
 =?utf-8?B?NERKb21VMDlKeG9PTmJWMnNwOUsvWjUzTFBBZkFrSkUvUFV0QndNTVZDcU1C?=
 =?utf-8?B?SUMyelZoYUlOS1hXazB4WE1BOVhra2h4Mld3OXVWc3N4T1Nhbnh2MTQ3WW5p?=
 =?utf-8?B?djdiTjFIZjZ5b1NmSmJIanpHOWhvZmNoVklTY2JpVlV2TmNNQzBZVnR6eStm?=
 =?utf-8?B?a3dMSjFJZFdFaFlMa2dJOEdmb3ppanFBY0xhNU9iYXp6dU81MkxIWWxWQ3du?=
 =?utf-8?B?ZkFRTC9ldnZicjdqVDlyTm82OWpFblhjSkRRSFdEK3BoZ21oZUtwTldjclRp?=
 =?utf-8?B?dTFCd25BQTJMS1lCbTE0UlpVUVFwQW5hS2FFMUpiT3lDc216RHJKWEdPMitT?=
 =?utf-8?B?dVRONXZhTHZUZ1ozbnRaNUVXOVJLVmRIclg0WkgrZGZLSmN5MUdsSERoZkUy?=
 =?utf-8?B?T2MybXBaU3NCTnl3ZXo3OE9Td2I5Q1JvbHZVVUVEclpNd05FeGd1dHJ1bmJ6?=
 =?utf-8?B?bzdLRWNmS0pIei9ObDF3ZGVhWFZKL0ZQN01hVE0vRWdhWktBYjkxMll4d1lU?=
 =?utf-8?B?NE5yajNOYWVBOTZJRlA3MDA3Q0RheDR6UkFkTW13NnNMWVRzSjhRbm0zZGtN?=
 =?utf-8?B?TjcyeTlRSG9ZUXFYZTFYRHNQRE1xWVpCZTBQMGdzbzMwQjJZUlE5ZEdCVThi?=
 =?utf-8?B?RFNYcy90cnRRbU01dVdPNFViT2llYisvZDIrenRlbTlsTzBOOTFSM251ZVkw?=
 =?utf-8?B?OHphVk9yU2R1eVNZMXFvcm01cUtEYy9TeS9qa0p2QlBLZG1SVkxyR2JvUGZK?=
 =?utf-8?B?bnN6Wlc2bkFlc0p6QTlPUi9iSGlNcnhUYmdRSnNWZmRmTVlQLzVoQmpDT0w5?=
 =?utf-8?B?ZHJ3eGQzeXp0c1JXTExrWFlLTWtmbUlhRGtuSEVrOEJLTU9hM0EwNFRUYzIz?=
 =?utf-8?B?RFdjYzNRemxRam5rQ3UxSVJwU1BtY1pnd2VaVEMxcHJ5aGtLZkZUT2ZrdGVB?=
 =?utf-8?B?Q1dERGJWUHZVRnZNZVpZMDhmbnhVaHMrd1loblVwUDBjeVNFL05NMkpVOThW?=
 =?utf-8?B?ZlR0UzRqL00ycE1FNFFkdys2aXJBV25CVjg0VGVtMCtpbENJRklZRjQ5c0VQ?=
 =?utf-8?B?QVFQUkRwWFNlbC9wWW82S1h3amRxQlpDb0Q2RFdwTXJKQld1cGM0Q0ZvS3da?=
 =?utf-8?B?L2NSamdHaWtRMVRFU0cxaFZKS1NUR3dQQXhSSStwU0JXKzFWc2Q0MS90Wk9U?=
 =?utf-8?B?UHl5dzhFaUJFZmtPWTJzQmFVZnFQendJSFFmK2RydG5xT2wwQk8ybWU3dEx3?=
 =?utf-8?B?czhDUW5Ca3o1UmNkckliZDJESWxLVnF3UzFNRm4xRHZ6UTN6WEQ1NXVBUlNY?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 563fae9b-d316-425c-bf41-08de00f34bbe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:03:28.8773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaVLbcKcQtFEMwtC+DmzwFht77agIaEdrvrao6fEvtHtJg/k1uYghYiPKm0Rjx2i+NVoJ6QLrApodykcjLMNhh0lZiqFARPSmaiqLLSnjIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
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

On 10/1/2025 10:18 AM, David Marchand wrote:
> Coderabbit currently runs in ovsrobot repository (and can be used in
> public personal forks).
> 
> poems are funny, but not really helpful.
> Reduce some noise by disabling (or collapsing) some verbose outputs.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> I copied the tone instructions and some settings from grout.
> The docstrings check is noisy, and often wrong for C headers
> (especially EAL arch headers).
> 
> Opinions?
> 
> ---

Hi David,

Can you provide a little more details on what exactly you are proposing?

On the back of this patch, I installed CodeRabbit in my IDE (VSCode), 
and did a review of one of my recent patchsets - it's quite interesting, 
actually, and the comments provided were basic but meaningful, alas the 
free version is limited to like 1 review per 30 minutes or something so 
it's a bit limiting. On top of that, I found the tool a lot more usable 
than GitHub Copilot reviews, which are attached to GH pull requests 
rather than Git branches, and they take a lot less time to boot, so I 
feel like this tool has potential.

That said, I'm not sure what this patch is supposed to do - is it to 
have it set up to review patches automatically?

-- 
Thanks,
Anatoly
