Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483BCC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 14:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32ADD40277;
	Fri, 27 Jun 2025 16:31:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 754E1400D5;
 Fri, 27 Jun 2025 16:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751034705; x=1782570705;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yYFPe21VneQvS4tifsre7Uw+ZSAZPw/R5nwsLUn6jHk=;
 b=awXaR7rEsa0dqOtdcYEGZ3RS2RiVm9TLgCKpgigbucyaTbL8CIx00DQV
 VIHHlv8TZmrpcx4YBtzVeKDeSVyGdOjQNzVZqchhAsrfJ7a+opLXHn6Wv
 PQBKwyL4FAFbHCbSMROKtrcJRpOW1EC10krYnvteI17kfn9UPZjyWUqOX
 AWV2wqWE1Ld4BbZHhY9Jb41seoEVtT7FyBcI2KxNJKf4VVEPhXYQuh0kp
 ravEvoBwv3Cjzjr1Xwy7BXuZyNo/YlA2fRyhtpM0BRmKUBOv1St/etDmY
 JzbdU0+6iHQhIQBzbWTcCVr18VTcw6++4dMikRVXyEIKWjIKVLJ2z/GkX g==;
X-CSE-ConnectionGUID: srKNVovDTVySIiuNcbORWw==
X-CSE-MsgGUID: SdyYuPkwQnufaaW/wt3iFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="57129947"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="57129947"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:31:44 -0700
X-CSE-ConnectionGUID: nUSKD9TYRxa6/Xsbiun8nQ==
X-CSE-MsgGUID: Y+FhPnjcQ7OEM0Vak6kzHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="176499057"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:31:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:31:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 07:31:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ9iDRH9n0GCJtIaOl/ASrVo6G5bjHOpAcHDbFBgJ8tKiwI4qw4Xz7vDCUYzph80Xw5IVSITl4+NuUq48qE/0MW1t9qqisiheuUm1ScSEvR69mfdBXbkg8UFHDj5u/Beqez6rL6+X2tL15Ms2QaZlkH6cqlUQ7DYXxk9KZSnYptgCZHC4/IcO7L0gvJ1GaKJVa8kxgsHkam7aZfzeQVRRdwKDl/XtGdW2nU8HXCBXoE4wBrVr0tkG8Q4B6zREJHwTMxZMJ/z0xwAbMek+kJNBGj13xhLhtJ0GR9OeAXvxQdev4z7lH0ZS4pFMbPSe/p3QaYZXce3zs8sfuGUwR3R8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHrP6vHwZ30do380iMUEyFVp91KZEDicG6JsT9hOrrY=;
 b=NdvxFuA3yEdN5UaP6FMfJoEmgMY6L1WA1qeRSKg/cQa5NgEVh3IXoZB260c1f7V52TshRVy0GscJWBrZSYGfJE58cy8Xq0BqU9ORNrlWzNhbdHSwT42nwBOE0rBssfR6ctCEDifezfORLwZevRY90+sDlYhI3T/XlLbmdUkd6o9V8UfgwHDjNES9Rv+RxRMZvCHwpEKv4Wu8fZ1ZzhGqNWd9aKXvsQsEW3QF4GJvWhRQyXaYu0kL84c92X8xqFzWk+lVX/PsSCERVxhAKcfAqt4rtqn9E4JL+c2VDznGrNtpGmsxD1S3xkOTIYlNF/ZpEY+OH7hIi/nmZ4OA01wwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9060.namprd11.prod.outlook.com (2603:10b6:208:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 14:31:27 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 14:31:27 +0000
Message-ID: <c58479e7-9a2a-4b8f-b9f3-0b69600aaf0b@intel.com>
Date: Fri, 27 Jun 2025 16:31:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix inconsistency in Rx queue VLAN tag placement
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>, Mingjin Ye
 <mingjinx.ye@intel.com>
References: <20250627135201.1393662-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250627135201.1393662-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0005.eurprd08.prod.outlook.com (2603:10a6:8::18)
 To DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e502dd3-3b8d-4e35-a67f-08ddb5874d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1dnUnJVTk9iRk55T2V2OENSaXlSVXVBREFZRUszbW5ySUoyMXE1NkdhRkZD?=
 =?utf-8?B?bmw2aGNNcEZFMjZxVGp0UEM2TWJmQVZPU3ZOZFE1Z3g1ZHRIK0ViVXFKRnZ5?=
 =?utf-8?B?eVdEajlGTGUwM05tODhlUjd6eTA4OEszdVFCSnl1SGlNSERsZ3FCd1I4TkRn?=
 =?utf-8?B?MkFubFRUd2FIajRubmZTS1BwbmRIQVRQd0VpanBLcDNoTjY0d2FvSmNaaE1S?=
 =?utf-8?B?bzdZelRESkM4SEdOSlgzZGg4Snl4RUhpbGpobnFTYTN4aldDb1R3akZ0akFk?=
 =?utf-8?B?Zlpsd3h0VHE1YmR4RGtHWlYzZDFMaXU0RGtqOEh1UCtVSDhhSjJNWkZkb1h0?=
 =?utf-8?B?U2M1b2YycnVOcm92c1ovZDN1Nk9DbVN5VmdSQWYyQnVDd1huUmFPU2RLb2FS?=
 =?utf-8?B?d1ozWUU1MGEyaGMvWDBUMzl2K2NuUEl0ZCtIN3IzV3B0akdsYjBoNXRJa1Fl?=
 =?utf-8?B?RDVuWE1MdnpZdEJsdllaL2R3SThsYjVTNkxDczNTUE8yalRyMnRnallYVXpt?=
 =?utf-8?B?TE9keXJzMGM3blVNeWZlb1V4dG5xWXRrTytaazNCNmhna0lndDZkb0tKZ2tZ?=
 =?utf-8?B?cWdiQk1VbDZ4NG1BYTdpa3kyanc0Z0VrT000cXR1OE45NWFENFEzQUgwcVd5?=
 =?utf-8?B?NXg2dGJEeEhQVHZxcEpwKzBjUVk2a25pMnhVdVBSN21vekVSSTV1dlY5MzVR?=
 =?utf-8?B?cTJXby9jenpHazl1TEc3ZXI2SWttVFNuWUxuY1IyVGxjY2NTUkZET203b2dT?=
 =?utf-8?B?MGlITWttZzI4cWIrOEt6aWd5UDZCNElrWkZuYzczUUg5QjFvZDJqaWtuQ2FY?=
 =?utf-8?B?TEF3UkpYMWxPTFNXQjlwaXRZcFhKVXREdUZSNjVNS3Zhd0xoWkFKZldRUGxr?=
 =?utf-8?B?UUt5dUUwNTF6MDVjL3B6eEU3N2RKRjBDYkNFQm51VDU1bm4vTGZESHVXSjcy?=
 =?utf-8?B?QWc2VjJPazAxcTBsUlgwVFV2OWtnL2JlbjdrNHo2Q0pnTWRJSzRyZGVvVHJM?=
 =?utf-8?B?NUdabnJEbTlLbDRCMDNJd2t1dCtmN005QkhEcGw1Q08xYVhMTVBFRjBSU1dq?=
 =?utf-8?B?eEtHT0FnYjR1Q2ZPL2JGRlI4Y0pLYWlDN21Gb2FUbURzbDNVUENBcEtiaDNV?=
 =?utf-8?B?NGErVUJPOGY3T1lJVUloWk5ZV2oxNEVhSTFUVUhLSVA3QTJBSjlWd0JldGh6?=
 =?utf-8?B?M0I0RSs5b3o1b0E0VWlWTU5PdzhMY2tuaTFranQxWTk3SGIvQytNcUxiV05S?=
 =?utf-8?B?eXhrcUhEQUpZRU1WVURhVFFqOG53R1lHbUJoQWhhaStmSDIvUEw1TkNyVllm?=
 =?utf-8?B?SWFaYnF2SmZHQ0g4WDZ6Vi94VDlwUVRaQkxpbTBIQlJjNjA1SGZJVDJEcHIx?=
 =?utf-8?B?eVVvWjV4RktzVmEzaHlqSEViWE02cjdlS3BWZ1NuMXhhZ0NiUFJ0SmRWem1L?=
 =?utf-8?B?WmdtUXRBdjJYLzFoVlorYlhyQVNVQlIwL1NhcDFXNWVsY1o0Y0c3V1ozZkNO?=
 =?utf-8?B?a1dYa2JMZU85dms3K1ZkelFkYVpTZ0pDemZvWWVBN1Q0UzJUc0owYTFWZnB3?=
 =?utf-8?B?aVpDdjBDc0VJSjJEZVg2dW5LbVRZOVpaR0tPRlJPNlF0cnM5cXNrY2Fic0hQ?=
 =?utf-8?B?emZkWEtnUDJJMUhpV2MyOFg4aVN0NGZ4RzdTWUU3MUhURzFwZjcyY3NtT2Zk?=
 =?utf-8?B?SUtsSUs0bXRFUThGbjczOHVBTXhEMzY5M2FEMmIxa1habmV0aWNDZVczMW52?=
 =?utf-8?B?VHd4dHpTSkNLY2NmZHphZEdHMzdmTlg2R21kK1N0K1AvZkZBZFpoWHVORC9y?=
 =?utf-8?B?L1FGSTJXSmJEY1JVNVZSanlKWWlWa1NnVFB6SW9VcmJ4RHh2UVRmL1pabHhn?=
 =?utf-8?B?bDVGLzgwYzFVZ203Q0xLMGM1Wk9kYk1uei9JU1FjOEI3cnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndRZ0lycWN6RXJOSFhDb2tEUzJPUDBzY1VoSHhoOHc5eXRLTGNyRmF2TjBX?=
 =?utf-8?B?c1ErNGRHNWR0L204WkQzTktRYlVocThIOFFNbjZKdkdNUVRza1o3UkkxSmFL?=
 =?utf-8?B?QnRiYjQzZHNBWkZzR3lpSXBzQm5TVEZDU0pLK0tzdnBWQXZCakNXVkR0SFJv?=
 =?utf-8?B?RFZkb1RpUVNKTFcvaDRndkRia1grVzdJaFBIVUVkWmxlQ3dJallJY3pOSmts?=
 =?utf-8?B?SHBGL3JYcWxkUUpMczRmVHRQT24rOUdJU1BoZVF3K3Vkbzl2c1hHN0E4ZUxD?=
 =?utf-8?B?MlZoeDdsQlUyaHZoL1FPanVXVDB0enBWdGFsMUZUVGExVW1tckpZTGhVNlQz?=
 =?utf-8?B?eHYvM0xOQ2VUb0s2eTZ4TkJTUnV2QWRqQTlLQVlOelorY2p0Q1lkQS9SMW93?=
 =?utf-8?B?djlPZnVPMXJKMlcwVFpaZWsvWmxyenBOZHZNRzZaMjJpQThKQitqaUR3L0VZ?=
 =?utf-8?B?KzFTZEcrM2pCem51SWp5THhYQk14RVV1Mm95dnZTVzY0UzZUWDI5OTRpVHY5?=
 =?utf-8?B?b0QzUG5VYjZ1OExBQXFvbVZ4YlpZQ002VmQyZWtGTWRtQ09WOUtDMFZONzZO?=
 =?utf-8?B?MzhieXFIalVZMm1HM0xVSHZKZkUzbU1Wem41TEJCSWVTc01uMFRUNjVxL1d6?=
 =?utf-8?B?UzgweExWazFUenNZSnpzWGYyQ1BzMGJyenZiVy9WMUpocnMyRFBtc2toeGxX?=
 =?utf-8?B?M0JzTE9waFR4eXFNTy9MVXMrb2dwV1dBaWhka0c2TTB6U3dwMTFhRHhRdTJX?=
 =?utf-8?B?R3AyS3VHQXhFWXFSdWVVb1NlZ2RKL2hpMFo2QVB0aFZPbzdxc1UvZ3JyQStu?=
 =?utf-8?B?cWFSL1VNMkRGSm5HcUNnZ3o3QXp4OHVzS0tMUTdERFhLMzdDd0xLcXRXMngv?=
 =?utf-8?B?MC9XZ1FJWVhzNk9PS2RGYzFiU2dmcDIrWnhpU3NieDYrajZnWkhobGl5cE5B?=
 =?utf-8?B?YTA1Z25sdFh5aTgyZVgvajVzN2ZOMTNSM05FL3dZUmlZMUhaL2ZJODdQY1Bz?=
 =?utf-8?B?ZktzUzN5aVF4RE9HV2pVbGcybmdvbmVsZGJnckhUVGttYWtkRGFCZXAxUW13?=
 =?utf-8?B?SGZFZnR5WXVCMlFuRW1hSzd0Z0hhZ2FkbE9sZ3VORXRpbTdQdFBPWmoyODFt?=
 =?utf-8?B?aVA3N0J2dFFRMHcwTCtqU2NWWFVLMm93anNmMFY3UlQyKzNiTUVKeWxDSkQ1?=
 =?utf-8?B?cVJCTjVReG1sVm45Y3VxMGNKd0dmOXJxQ2p3dDduMTRXaFliNUNnczYxNlU3?=
 =?utf-8?B?enM3d3grZzNnNml1ZlRNSUNpM25hWTFiZ0JES25HY0dxYjRzdEFwcmhXamFN?=
 =?utf-8?B?a29aRlZzWTlnSWlYeFpXRGs1WEtjbHVXYWFIZFh0dGthTXZucVJKWUlCeFdy?=
 =?utf-8?B?Q25xeUZxV1IvTXFkbUJCMFJvSDVQS2pDS1k0WDNNYXFaOWZ2cDRnQzFFZTVk?=
 =?utf-8?B?VzJGb3N0aXRTcjlieGh2WlBWZE9wdzBnRUc0YW13WlFuNCtKY3BDamNhSzBi?=
 =?utf-8?B?YTBPbmNxTFZzWElNaGI2cjVoWVZCeHI3WkFLZUJ0QllaeklEeUlqV1RiVnFw?=
 =?utf-8?B?aXhkdGNBZTlCUjBER0NyQ0xtM2U2cko3TFRpS2RrZXo3SGR2UWNpUjJXSXpK?=
 =?utf-8?B?RXN6T1BoeVRNM1Y1eGpwQW1LUHd2UlhLVHl2bm0wWHpvcXRvalYraHVCWGJK?=
 =?utf-8?B?Z2phcnBlZTBzSEgwbTZEd05OS21BSXJ4cnNJU29kcHZZRGJ1a0p1K282N2NJ?=
 =?utf-8?B?Vzh1QUJWWng5VDZXbklzci82V2tESHFIVEh3cXRXMHArcDZDYlBYaVdoN25k?=
 =?utf-8?B?YlNFeEZLTHE0TU9yNGNNU1Y3UXNwUUQ4YlZpWXRqSGNySDh6alNMSEIySC9T?=
 =?utf-8?B?YmRZcHJJRWhYa0ZFMnVTcGdRb21CV2xtZlEyUENkN3ZjdTJrNWNnc3VGUGJE?=
 =?utf-8?B?NnZUL3ZXZUR2ZnlDYnJxNWVvek9IOHFveVJON0Ztb25DVXEraGo3cTAxeDVN?=
 =?utf-8?B?YUszU0JieFlxV3NrVVFlYkhOLzd3cHUvZkpDWDNFVGt6RThtZGtQRFJxSjlO?=
 =?utf-8?B?TGc1N25zenl0NjNJM0pjOURod1dVMU1raHVtZk9xVXZLcGFRY0lMRUlhY3h6?=
 =?utf-8?B?VDVUQUJFRlhENjNoREhNS0x1eS9VdFhCQXcxRWJBaXo0emFnNHVCem1WK0cy?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e502dd3-3b8d-4e35-a67f-08ddb5874d1f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:31:27.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihzL2mnC/pVO0BXclYt8qc/wQw4mPO6Y4m0ojE8sJLZRolnVTnG5zx9tjYo0kbgJoZ99Zi41zezidjC0YR6fEQmCJDyXQ2ySvhu4jE+LNDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9060
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

On 6/27/2025 3:52 PM, Bruce Richardson wrote:
> When VLAN or QinQ stripping is enabled in the ice driver, an
> inconsistency was observed between the placement of the VLAN tag in the
> descriptors of the final Rx queue (irrespective of the number of queues)
> vs descriptors of all other queues. This inconsistency was due to the
> fact that the driver - when updating l2tsel (L2 tag selection) field -
> used the queue id, rather than the register index for the queue. Queue 0
> is normally HW queue 1, etc., meaning the final queue never had its
> field updated.
> 
> Fixes: de5da9d16430 ("net/ice: support double VLAN")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
