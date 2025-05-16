Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4979CC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 13:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D7B740292;
	Fri, 16 May 2025 15:31:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DC43040430
 for <dev@dpdk.org>; Fri, 16 May 2025 15:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747402280; x=1778938280;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=KXus+zqjP6ZOKNA+/2nyEvVKRP/uSbdJQ3pRkZmGZyE=;
 b=TnD5xDKjKdCRssvfaLkrovuboUDp29e9f3fLcTl835ME6JEDRiZx/edq
 PNPx1kubExeBc7VkX/m8mGU9hm1jX3JgMfVFjV856wbTnHoY18MosWWw3
 uvEJoXzRqsvV2pTCL3OFg8yDT7CV2WVz+DTchySbAkkK414ObTsIWqtXA
 1aS/80p/VbIrxDxsZ2YGbH27n7he7d1MPxS/K9/pkYBMwAVUd6tMY1oUB
 8b2Z2l9GzeusGFDZcwDARTEltLsqwb1hHq3j594nEhWC8bNxjGwd2RQW/
 RGHDtRpsaN9x2n3jjPl2ekLaliKVtpD64V9AT9pQdR/MViFujdk03kSFG w==;
X-CSE-ConnectionGUID: fe8JsuuhTr2UZG1EzNRH5Q==
X-CSE-MsgGUID: 1e2YFNDLQpK76pDssxLD4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53046230"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="53046230"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 06:31:18 -0700
X-CSE-ConnectionGUID: MOQ0WiS5R46IpteSajxrkw==
X-CSE-MsgGUID: 2EaC+ShQR7eZjjWOefG46Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="143936836"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 06:31:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 06:31:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 06:31:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 06:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSpBZwUG2i01dFhNL7afIQtKm7tw52UhKxs51hQdN/YJRnWV5452M47T235eKs/2rvUSNRBvr1U0CfG+lUnZ1Gh/nbsBMjaA9u28DJIH64r5eX81OWT+RRGs9vVVm26Hf11RvZFy2wJgVS6cPqIbLQSr914iP3Lo367CrNzlMfGOCGe6qcqKCwdd+W2xyVYMsHpyJIwURd0t+tNJWBm5kZhwhxofLbU7aoM1oV8AOb612M8f6+RCe4HoaGis25NGKw6frNhykLmGPbLTzxbMFO3PHc2SvUE0NqUhpk/YytyYI22156T3J/uqqQOdYj5TfvH49bDIDtPEiO86N+W5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7hHrVEkd1BTTEZzzEB27rmyWub957CFqhtx7L9LUK8=;
 b=QsLcwOJBTkdY6FebxFsC4QYJjczVsyd3PoAcDiwASNwX/g4utusnfO2cUq2M6oext403upz1jQx5mS6c1DHyQ/rBsQ1AihYWyQiANUoVhDrKMb4Y0WaF4/24vLDQK7shSrxgYGD6Gixceevp+ZqKfkXlkuf+9SK0wFhv0x56HIdo679/1qX+nlAnYFladcDbQuNvh4XwEtXgIDkBKDHxdq5bKcwulBPX+HHZAswsdETKJmUYYPfK0ES/whKskPuSwdAJrILe3LKPO4G4LulUJkZXpLzPrWG+0/pDUbhYfoK8Tq8smLHyDQbi4SPvbfEoEDdM9Ao0iiLj9DFl2LU3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BL3PR11MB6530.namprd11.prod.outlook.com (2603:10b6:208:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 13:30:28 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Fri, 16 May 2025
 13:30:28 +0000
Message-ID: <7e76aaa6-09c3-4721-afbb-aeb3bc9a42e2@intel.com>
Date: Fri, 16 May 2025 15:30:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal/linux: skip vfio for non-privileged container
To: Yang Ming <ming.1.yang@nokia-sbell.com>, <dev@dpdk.org>
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0234.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BL3PR11MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcacba2-f22b-43e9-8226-08dd947dd231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWpZN2h5V2ZQUE9WY3pGeUNCeE5jRFpMTHJlUFNOVlZIbnd2Z1RXVjBWSWw4?=
 =?utf-8?B?U1plTFIzKzNnRllTWnNHTnBJVmhSMnpWYnljNlZMQ0Z6aTg1SjNhWFlhKzB0?=
 =?utf-8?B?cnh1bDNpMTVBWUdQNG5yZUFCeGMxcEQwZ3NJU0lDOURMNFY1aXBSSHVSYUVG?=
 =?utf-8?B?SVB1UUxnV1hwMlJQYjhTbkd5TW5pdlM4cmczQ044bGNqYjU2SnE3blZOUFAx?=
 =?utf-8?B?RGdPd1Y2SExDb0k2VWdtRW9WcFk5bm84ekpTR2g5TC9wbVVhdElSaHVwR1Zy?=
 =?utf-8?B?OWZTTzdWVDZBSSt2Q2YxNVptZTRuMDA1dlJ4U3VSdTNVNXlqS1UwSUszUCtK?=
 =?utf-8?B?bVdINlBxVytIb3cvRmMwbmlMcGdsY0xwMjI3c254ZHNPYkpscFJPS1oyQllj?=
 =?utf-8?B?VWVaeEljdVF0ZElpZ2luQXJaaXQrOTFlVDl0aCtsOEJDaXBSdG0vdEt5NExj?=
 =?utf-8?B?dkJENUdtSXRhWXZTOU1JbHU2VjltRnduc0plYUphbWJVdzBnQitNbVBaTGtG?=
 =?utf-8?B?aFpkS05nenlUMUVxQi9TK1FSYUo3YUVzNkZNM1AwZUxrQUt0MkZiVDllaTZM?=
 =?utf-8?B?L0I0K0YxbzRuNTEzRVpmRFVXbXNWemZwMmZ1dWZwbDE4MkdCV0I0UFFxc3hh?=
 =?utf-8?B?dmZHWUhwRDRKQ1ZObGlyaWh1bm8zbzRibFIwRFpYL1RxN21FUml3aDYzOVhz?=
 =?utf-8?B?NmVxYUZ0M0FBM1NTNkEvakRidXlZaDM5M2ZUN1JjN2xsaUJQNEk0aUg2MS92?=
 =?utf-8?B?ZGNNL1VsQjl4RVVNRGxIdCtCMUxFaTFETCtBbUNnMmdtV3pGTHd0bk83L1pm?=
 =?utf-8?B?a2FPV3JhQ0RKQlBwa3RLRUhRYldIQ21uSkYrUlc0RnA2QkF5VzJzbzdlbjZ2?=
 =?utf-8?B?b1k5TDR0Z3NKRUMwZEVXVkIvU1Y0OUZZUHZUNE1yYlhRVjlaOUphOTFnMWp6?=
 =?utf-8?B?QjhxTGNZMGJGUHhScVk5a2syY1ZTRkZjdldkNHM0SlQ5ZmpQYXFYakRrcVdD?=
 =?utf-8?B?RTUyUEhiYjR5ZDh2UFJNaDU0ZDlCVXROejB4YTIrWmZLNlJhM3J6M2pQSUNN?=
 =?utf-8?B?UEt6NnlnY3ZTeG1CRDk0ZVAvMmNHTmNSY3dwZTN6cmxxcE8ra1RLS0NnK05w?=
 =?utf-8?B?cHkyR0ZJQi93YnFCR2hqVzRnREk4cjV3V2dZdE9YVDgyd2VFNkxiTFpjYm5H?=
 =?utf-8?B?UEFKUnIrc080d3NrbWx3eXI1Z0prc2IzTk8yanN3OEZLUDRWYkxjdktMT0g2?=
 =?utf-8?B?US80YlRxc0ZIYjIvY0pHUXRFYmpWZE5jLzJYdy9zakdYMUFOQ3E3TkY1YUt4?=
 =?utf-8?B?OU93REZmeFZpOFBSOXlMU2ptbTFIN0ZUMkl4NW56bm9DSlkzMDg2aHhLNWxS?=
 =?utf-8?B?eGlqYzlLa0NDb09sZktTY3VQNVZQTDNyUFVkMk5XYWxVbUFvV2VIaDV6cXVa?=
 =?utf-8?B?Sk9jRFVZTlZiUzliRTN4TktzTzVlem5qcjl1ZDRxS2trS0lGbnNlN0JFMU5U?=
 =?utf-8?B?bGdQT1BlTDdCdzdmZURaUkZ2Z3QrcTZaT3N6WE9HOFhsbWR6MGJ5UzlTSXFn?=
 =?utf-8?B?Tmc2dTUyeGZleXhMbUw3djFzbm9EOE91aWg1STRGNFFZTCsrdGlvV0c4WHBU?=
 =?utf-8?B?V0tMQXdjV0RORUFVMWgyTnlaTE9IcWhtYlNiellLd3oxWDlqamsxd1hvT0xT?=
 =?utf-8?B?VWJPdmRmMERqcGZGS0RQaVpzbVdNRzdzZlBZRGhUai9HOGYzbnV2ZWkrbVFr?=
 =?utf-8?B?cHZwYlJXblJGczE5Mmp0ZTdSdzdhekttZWJ2YVc1UGF3MmVyWWg4NUJlb2sz?=
 =?utf-8?B?dDhxZzNtY0FoSFpYM1lZU0ZuSlV1M1RLOGpqWVlwdTRCSkJGajd5ZDRvNXRY?=
 =?utf-8?B?OE5hRkhrSWJuTVIzcFNUeGcwbmNJSnY3b0ltTGZKdTBxVEVwUldGZ1pOMDJU?=
 =?utf-8?Q?Ss1ngifYFcw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXorZHY1emwyR0JSVlduZzNSS0FvQlJmUHBDVUdLY2FsbG5JaTJhQ2ZRUjdt?=
 =?utf-8?B?ek5wVld5cHNNanRpaElydGVtSUlJS0NvMjBVNEpoV3hIRDBXYnlhV2JxODZy?=
 =?utf-8?B?QUM2RlFlZjFOTW9ZZUdEOGVGaFhZVjBPUEd6ZCs4OW9RSS9ZRG5hYWNvY1NE?=
 =?utf-8?B?a2I5VXFOUCtDTjRKTXMraGlDVVUwTEl2QTJTTTJNS2NySFA2RFlZS3phaVYy?=
 =?utf-8?B?UldTTmdNNUxVU0kwZlJoNkR4bzRzaTFtaW9SYW96cHRNRkcyeEZiS0M1Qzcv?=
 =?utf-8?B?eTBpVFhSR01lUC96NzZycjBjTmdJbzVnQk5uU2gxc1JyNnN0UVZsM3hHVmF2?=
 =?utf-8?B?WUVDcG05K3pRRVl4K0Z0MWh6dmFlR1FiVUk4WjZpSk1laHRDWVU2U1VDSVpR?=
 =?utf-8?B?SWxmTGdoRzc2elNBcWM3cEtSamlnWkY5N3c3eUJzRTNGbkllUFQ1RVBjTjFY?=
 =?utf-8?B?TWhKZnVuSkFUdElPZ2NydHFPRkpiS21vaTF4L3JEaE9HTDh3RTUxZWd2dEha?=
 =?utf-8?B?cHdQWDg2YXdRUG9lK2w2WDFiMUw1RDRpRVQvSGQ1VW1aUTZLYjZ5ZHBWK0Yr?=
 =?utf-8?B?NE5EQ0NlZ1BoQ3BqUnMrODNhK05KMnhTMDF6M3VSOGUva28vQi95VGp4ajNE?=
 =?utf-8?B?T2Fuai9FVlA0VStlcnhzNnhlTlZCemNpYXdxY093QjlrV2s5MTVoMDhZZ28r?=
 =?utf-8?B?ems4ODUrbndLQlFyZzIxd2grYWdHQ3VKVlIrTGVmSExMZ0oxaFZzcEdnWFJZ?=
 =?utf-8?B?eTJzZlVucVJhazcrdWYzajNacWdud0tpSE5sZFlGWjY3RkIwSkJwSEQrcGwv?=
 =?utf-8?B?L1ZBR2JqelBISWE4bjl2bnloWWlpY1BrVzJnVkRWUllIUDVoZXZ0emliQXMw?=
 =?utf-8?B?ODlQbHIwc3FRK3V5MWN0U0JwU2RidWxjNTBCb1ZjcklaMStrS25WN2Y4MkUx?=
 =?utf-8?B?d3lIalg5TjFOcWtPWitob3hsbkNENXpzbTFYTlkxbG9SV3huQXZsanloaTkw?=
 =?utf-8?B?TEtMRkpQWDFUWWhVM2lyS1RrNE9acHNUYjFQMys3cExFR09MUWdRMVF5MnFN?=
 =?utf-8?B?eVNxRXNEdmU2aFBmdjRCemUyVXg4WElYOHJxZzFJSlVmTTlDenBuS1NKa29p?=
 =?utf-8?B?M1dpTWZmRDhYM2c4M0xZV2cxUExXWWF5YVE5WU9lL0w4WTRhSmN0V0ZsZjgw?=
 =?utf-8?B?dXgvWUZiVXVhRk9CeThsMXM3ZFBKRVBTaWNrVGlOMk4zY2RTVitQU3A3MFQy?=
 =?utf-8?B?em8ybjVXaDY0cnFZMUdtSnFMK0Fud2YxV2M2NDl6VmdKK0cvdGtvbVpXajB2?=
 =?utf-8?B?aStyOEpSdkI3TW40bXg4bzZCZldjZzJHZ0dodmF2blY2TzRFQXJWREY5OWp3?=
 =?utf-8?B?VHN2cnp5Y2VHVTVNeDBJZHAzUFIwdHhiMlBaNDR4Q0RnUEhMRG01ZHE1ZEha?=
 =?utf-8?B?VWM4cDFtTnNtcjF1VDZCditxbnFENHdSMTUvcm9rc2pteHRyREJ4Z2RSQTRM?=
 =?utf-8?B?T05ZRlN3STRPRzFpTmZ5OE8rSGowelhnTThJU2w2NzQ0d1lZYUFjeVFnUlZT?=
 =?utf-8?B?a3NIbTNjNTdWZE5hOGNFMlhzNnluZVRycmNVeTdETk5LVzB5RE9MY0I2QkM0?=
 =?utf-8?B?V0VFeDBoeWpPN1lnbTNyN2NCUGxMbEZLN1pXRWNVSnVLQ0R2VU5mcUtuclQz?=
 =?utf-8?B?dDJ5WGZvVCtJNHdyZXlyV2xkajRwd0FUWkZKTGZvZ3B6V1hOQWwwb293TExL?=
 =?utf-8?B?SkNZRDNhV0k2VWRkUmNDZ1hKWGdTYmRlaHRMNTJMQlNiRFZVOTNuVm4vSFZR?=
 =?utf-8?B?clVuaVFiMTlhWGhNVEYyM3VRTWR3WDE2UlNXbjVUT2hFYkFITnJ6SkV3UVF4?=
 =?utf-8?B?K3MzdzZvRHZRalFSakh2SkI3QmxkZnFKVFdQOVpuWTlOcjNGVjJ2MXVSNEV5?=
 =?utf-8?B?Wk9QemtqOU9YeVJZNUdBMlFJK1FvK3d1V2xHQ3NXUEFxWFF0QVo4RWUvNnhi?=
 =?utf-8?B?WnZ6RnVJV0UxemNPL2YraWxWbjdBUDJMR0o4MnB4bFhRcnBGQmFERG9ycUM4?=
 =?utf-8?B?SVVZQUdRaDVoeTJBdFFZbXhQRTUraGY5d2dQZHVrSEJObUNIeFg1eFUyUjF5?=
 =?utf-8?B?a01vSDhzUVJqaUVyMEhEYzFiVGtrZGJzOVF5SjFWUVBORzh6QjJReWtYT3FK?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcacba2-f22b-43e9-8226-08dd947dd231
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:30:27.9401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymcCx+UIxOkcQRZdORksioTuoOAqBQEAmFG9Cx2t2MTLa+gGamzvYvoh3zOs4SXJERj1IkjsoQ3+oHmu6f/y6ghQWLU3/oQlU9NWcVwArwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6530
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

On 3/27/2025 8:57 AM, Yang Ming wrote:
> DPDK detect vfio container according the existence of vfio
> module. But for container with non-privileged mode, there is
> possibility that no VFIO_DIR(/dev/vfio) mapping from host to
> container when host have both Intel NIC and Mellanox NIC but
> this conntainer only allocate VFs from Mellanox NIC.
> In this case, vfio kernel module has already been loaded from
> the host.
> This scenario will cause the error log occurs in DPDK primary
> process as below:
> 'EAL:   cannot open VFIO container, error 2 (No such file or
> directory)'
> 'EAL: VFIO support could not be initialized'
> Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
> to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
> O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
> in this container.
> This scenario will also lead to the delay of DPDK secondary
> process because `default_vfio_cfg->vfio_enabled = 0` and
> `default_vfio_cfg->vfio_container_fd = -1`, socket error will
> be set in DPDK primary process when it sync this info to
> the secondary process.
> This patch use to skip this kind of useless detection for this
> scenario.
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>

With a few code grammar fixes below,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

> ---
>   lib/eal/linux/eal_vfio.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
> index 7132e24cba..1679d29263 100644
> --- a/lib/eal/linux/eal_vfio.c
> +++ b/lib/eal/linux/eal_vfio.c
> @@ -7,6 +7,7 @@
>   #include <fcntl.h>
>   #include <unistd.h>
>   #include <sys/ioctl.h>
> +#include <dirent.h>
>   
>   #include <rte_errno.h>
>   #include <rte_log.h>
> @@ -1083,6 +1084,7 @@ rte_vfio_enable(const char *modname)
>   	/* initialize group list */
>   	int i, j;
>   	int vfio_available;
> +	DIR *dir;
>   	const struct internal_config *internal_conf =
>   		eal_get_internal_configuration();
>   
> @@ -1119,6 +1121,15 @@ rte_vfio_enable(const char *modname)
>   		return 0;
>   	}
>   
> +	/* return 0 if VFIO directory not exist for container with non-privileged mode */

/* VFIO directory might not exist (e.g. unprivileged containers) */

> +	dir = opendir(VFIO_DIR);
> +	if (dir == NULL) {
> +		EAL_LOG(DEBUG,

"VFIO directory does not exist, skipping VFIO support..."

> +			"VFIO directory not exist, skipping VFIO support...");
> +		return 0;
> +	}
> +	closedir(dir);
> +
>   	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
>   		if (vfio_mp_sync_setup() == -1) {
>   			default_vfio_cfg->vfio_container_fd = -1;


-- 
Thanks,
Anatoly
