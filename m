Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475DCCA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 14:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DDD24278F;
	Thu,  4 Sep 2025 16:35:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8E0614275D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 16:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756996543; x=1788532543;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=kvl+1FKUPO/3eIKts8/bpbibJjTG5lJqhAReTCNHFsw=;
 b=n2Ho+ETpTfceFAdrQQTGG03gurOJHAjVaoYY7EVMjyYu9FPVsqk/0ooe
 lFZs/Ywpq/oxypjU1pTgjqnxeQvp4qQojf4iSVPzBNiyl+Lh4uNHUOwBs
 cchkIFCZ+/UZ28+aoRTKR6bmNpeENhXe5F1oX0vhTjLMyrHM5dq4YThO1
 0QERbTMeLrGJNOKvrA8HL6E/0aCM+b0XaStpg7bOE2Alw0d4Fr45iBlPB
 9K9OiSZQQtcTN0lmNJydH1RcgNvdzygSnRQAQeuGydNrvOcG+PLONVE6W
 h0kdQC73h9x+gM9rFVmEN0AOdhMVxiN1uGABmBKfBNfieTUO7IOH3OTTN Q==;
X-CSE-ConnectionGUID: O2oXHyPGQ22os6oCSMqEIw==
X-CSE-MsgGUID: mlMRD5a4R8S3Axev+VX3lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59404138"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59404138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 07:35:42 -0700
X-CSE-ConnectionGUID: iXVcaI7cTjGRW7rdmIXceg==
X-CSE-MsgGUID: 0U28qKJYQyuT1pK+UkG3Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="209086893"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 07:35:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 07:35:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 07:35:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.77)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 07:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/skb9c9YdorX/ccYW8FCfKgaO5VdGgUd0S2ccEnWMN3qFIO6nO5VVyG235I0UALyP3t5BPdEyM+iwSbxKJjSJfV99KLzw4qRmdsrWnFkMVlATMq6ajpoyLstWlpt9PTVDjIi/HkxwL0HAoqYLOutiQ4aOCy2ydHJ6trEEZtXFIk1QM16Yoa65NrDC1WdrsK0pbpkvEEylSRGnjj4JtIrph4XhoDoifq4IxkFQhpsnfsGNCogX8uT+/JPRBYK/kHjF0/2LqT3UJj8oSBgVss5nRl9f53XhdMka1Tg7uqRxfIc53x+d8VsYQ7dsCXiASjDT72nEAscMY3707lYgcrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+c5i9UHhP8SWkxNkdDUHFjCmuJOL4BLExEfOnAA7i0=;
 b=sSspFXxmgebwxB5NY5XqomgDHkdpXJks5QgHFXB1d90tpGLQewuh29M3rsJce7viS5PafLYfOhu4E5scZErNjMndsUvgjWiW1t/NoN0z1cEQ3q/gUx1VdW/vQhjqMvIq8+mFkIYf2tRjDbPDjSLOTD/mb0+2GQGZ06SlQHeuQekChCEQx7BmK49eQCOq82ejRTtUf7pnXbKYEpOFU2DNTgxxWyMmvO923QLFjWnf0jb8mdeIhbVi8m/rq3kHEV+uSFrjPLJqasjP06LcPf92gkMx1e4hHpX744AE2jJQdJZ6IlBBZDv+3Uqocd1uO1n0s8tO1Ljg0EhRyYPTcI1I3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.18; Thu, 4 Sep 2025 14:35:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 14:35:38 +0000
Message-ID: <9d2e0536-98af-4532-aa57-dd1605d6e070@intel.com>
Date: Thu, 4 Sep 2025 16:35:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Error with --no-huge when compiled with -fsanitize=address from
 gcc 15
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
 <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH8PR11MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2795d15a-6fa4-458d-b159-08ddebc050ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjY2bjNlL2NDR2YvQ2tKUFJPZi9heGxzNnBVYkRhbC9aOVRYV3ZjR1pOcE9M?=
 =?utf-8?B?N0Q3UUpoZEFHV1M2YTl2TGk0Q3I0RjZINEN4NzVlR3owY0VhVG9HZlNObE5G?=
 =?utf-8?B?RVozbUlIbGZBdkRodU5rSGo2NVdTb3VrQjFKREc3RnFyTlNsMktYS2FXcW1m?=
 =?utf-8?B?KzU2dE40Rm4vS09lbFlTTERQVGFFUGpmMG5Mc1ZnSEI2Rm1YdUtpbStjbnVi?=
 =?utf-8?B?UWt4K2NkNzdZaWFDRmtrMFMyeVNpRHZwMGtDT1NoMmQ4WnZDVUcxMmpuM2tp?=
 =?utf-8?B?WDJYYm5KdTZSaDhySThZdWVsNUd6UmZkdG8vRU1sbHpXckUwZklpbjJHUjZl?=
 =?utf-8?B?Ri9BeVllSHFXZVFQdnkyNlV6WEQ1ZnM5UFpoRWpiMjdKTHNoVGZKOURwcENa?=
 =?utf-8?B?b3VwNFRUZklwTDEvV290WDFQVm9wdm0xbFpZcWk5dDFvZlFvMkIrSEdlQlFM?=
 =?utf-8?B?V1p2WUZzbVZ0allCVUdOVlg0WFNEV2pCQXRiSHp5L0NCOHR5NDB6QzhIZklX?=
 =?utf-8?B?dkVLMEY4Sk1McWlaQU9aUmJLQmtRZmxFcHU2d1V2ZkQ2NW1pZDVPVkZUTlVI?=
 =?utf-8?B?STcxdzVmcDd3L2RUYmw3OTJ3UzlzMExoQWh5YllzOFZmWEh0TVRKRlVyeDJY?=
 =?utf-8?B?ZDFCbklyRVBSdTlKY0dybTRsdlJLTVFEOThROFF5UUJHZ0hBWmFNZjJuSHlu?=
 =?utf-8?B?Ym5FRTIzSk5DY2ZCZE1tOWEweU1PL2ovQUJGRkRDQUFPY3hyMWtJandna2FG?=
 =?utf-8?B?UXRGQVVwTUI4V0sySVpmc1V3eFliZDg3RlA3a3Z1b3FUSnhKOFBCanEzazBa?=
 =?utf-8?B?VVhlRENaUVphOG5KaGs4MEZXL1dZaitjRWNRUkxRL09NNXBxSzdMVEFPZnV6?=
 =?utf-8?B?OEVxVnluN1lWVHFaK1ZBd0U5RVVZZTJYY2s5QTZJWHlJVmpMVFMzalJVUkpn?=
 =?utf-8?B?VmF0K2xIVHVreFo4MnVPZjJJMVhWajMxT1doNmhKTXdtVTdqNEVzNC9UWWg3?=
 =?utf-8?B?UmVJenhCamNsU2xJbFBjbExFNVBDR1JldHArN0oyUmdxNXBNaGovN05BUkVF?=
 =?utf-8?B?cHFkekJwNGo5UnZaTnVpS2Z1WXFDVjdDcktNeVhRZzg2WSs3V1ZaaEJ2UUVF?=
 =?utf-8?B?NUdtTlhPUldZYlFWNVFaUk4zS2JOVlpxcndKZVBCRnFqWkcvNEJHMDJCdHFJ?=
 =?utf-8?B?cEgzL09iaGhZQW5DcUVsclFrSlpFYjRZbTRHZFIrdDZaVWJNcEorQjF0V0lY?=
 =?utf-8?B?L0duZkVybHIyOVFHTGRvTTNVUWVxV00xenNKbnN2SWltdlhmUUc0VkM4cjU5?=
 =?utf-8?B?OUZxbjU5SGtYdzh4ZGJoSjVRMWFTR0pNakVpTndJLy9tS3JJdUlYekhPYlNz?=
 =?utf-8?B?eXlVd2tSdStGNngyRXJXb1Z4L002VnlWK1NYZzNVNEdHMFkvZWlwVFlDSk53?=
 =?utf-8?B?SVBNZGVpdVl6Z3FGOXdxekV4L2gzR1NmY0ZZMUlwVG9sSFNxcmw3aG15OEdi?=
 =?utf-8?B?YzhMZVg3WDZRcWNTT2dhTVUwbHFlbHdGNWx6djFwcG1LelJCZ2VHSmhlYUdR?=
 =?utf-8?B?SjBmT0duUkxYQzhpVjZraEh6Z3hoM05tNk5pNnFabkJ4YTZzWTBoVDdhS0RH?=
 =?utf-8?B?dWtxcDlLZFl1b0lVaHBBbGVqbmk3dFZqS1JqN2ZwWHNSNDFub1N3MnF4dnlP?=
 =?utf-8?B?SERKZHR5cmFTTGEzcDNYUlhYL3VQbkdBQzlnSFBIb0NzcVRLb2VVL1Mwbkt1?=
 =?utf-8?B?SEVQY20wQ2NUcyswTVhQYU1YOVN0V1c0eHpTeEROL0pUa0hPK1Vna0c5NGRj?=
 =?utf-8?B?aWd0WTBMV012UzU0V2lUMlFEcE1nMEdZODRJcVBUdXVQSHFydkdqWG1zdXZ4?=
 =?utf-8?Q?qSoa9g3hw/sQb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW1IS2oraWRaMHdodG9kUlB3dVpQK2U1Q1gxTnd4UDI2NDVLZ01oamVrdlVI?=
 =?utf-8?B?VUpUUW1xTlRzTHJrczFRcDZycW44TnRMWmxhVlBqK2JtcWhabS85VDc5a0Nr?=
 =?utf-8?B?eVJ4a3VwNXYzWTNjczAxdXRrZjZ6UURHUXNXd3RKdURXb0prYWFmbzBETTNO?=
 =?utf-8?B?TktWMGd2eXQxODk2MktsZmNNc3hjYzhpMXplQ1JoOWZlYllUL3RTUTVYRUIx?=
 =?utf-8?B?ck5zVXQvbDQvMGlWSlRxMFAwUmJCaWdxb1FTLzR2ZzZIb1ZXTW5mblh5c2FY?=
 =?utf-8?B?aXg2dTVEcGxUMkJ4WjhYQnNHM203U2dMamxVSjBENjhwNzVVQnowdGJDN1R0?=
 =?utf-8?B?Vlh1Q0w3M0dFT1FCQWZmcUhMOHRhSHZHMFp3V0RaTHMxSmtCbHRoTTUvVmZJ?=
 =?utf-8?B?ZEt0aGpXKzFabnNsNVZQQlA0Q1c3VXJlak5hU0xoTHJ2Y0I4eG52ZzROUXFN?=
 =?utf-8?B?OHU0WnRRVjRBRy81OXo3bStESFc5bGFHM1g1TXZrYytuNWphV0JDT2JDcWNU?=
 =?utf-8?B?VmprUUs4VzRsckIwVkJDZnBSb0lpRVc2dTJxZFJnUStDUVpvcjNUK3FTbm1J?=
 =?utf-8?B?RGJQU3d4V3pjR0tmN0QrcTREQjBPTHFLV0k3ai9xNjVQMloxUjZObEFhUFM2?=
 =?utf-8?B?NXNRQWFndzllVWk1WTRJU1dBTTJJOTF0Wml3KzZyK2dJUUtRY3liL2cyKzhu?=
 =?utf-8?B?TjFaODVlRytqa3V4WGhkanVXb0p5TEp1Mmh0ZUN3NzNwUE1TZWc1b2Q1eWhC?=
 =?utf-8?B?dTdGUUs3aGIxWFFKdzQvbnhvZSt6MmxUL0N4N0dxSUNUaWRCODZmTW82VGZY?=
 =?utf-8?B?TnJwaWpWUHZmWFNOUzV0bnZ3aHJwVkdIampnKzJ5eHRWUlhRd0hmWUdJRVdp?=
 =?utf-8?B?RG1ENXczajB5b0ZuWW1SV0h6dVBHdllaa3BTMDNNYmM0VEhNVmNZanpFWUFx?=
 =?utf-8?B?STE2TG1ETi9QMUZxSG9PTS8zQWdjMzRVV1lFNVVPcGpQY0R6U3JNTXdYb1pa?=
 =?utf-8?B?VHZzSVJUQmcrSWFJTmQ1aVJucHVGdVEydXRyT3hKeGtvUk9IYXZuRkZHMFIw?=
 =?utf-8?B?QkJDVUxJT2cyT3F2T3BPQVlrTDVIRVFQc0Y1NTRVc1JiNm9Bc0k0a1N2THZy?=
 =?utf-8?B?dXpncEJXNE0wZldXZGJxdnNJek8zUUk5R1p4VWI4QksxZkVSYi9iaTd6KzRI?=
 =?utf-8?B?ZzVLNHc4cjFjUkFsT0VxY0phUkx1VTVxemFBelpIQ0tldkV4T250MWZuM241?=
 =?utf-8?B?MGtaTFBjV1RUOVNJMGQzdnpSY3BpcjRhcnY0OS9DVTBNbVZoZUpCSEtyQnRF?=
 =?utf-8?B?NU9malM1K21lTTF1TWFVeEpwU3VuZWI4UUhpN0YzaWhtSGVlSlJzeDY1V1ZS?=
 =?utf-8?B?WDU5VlhwQTZYZ21KVFZLYWVUOEU3TlhUbVMvNHEvaUhGb1ZMNEh4N1R0WWNE?=
 =?utf-8?B?dTlTQkpaWHdKeDRJaHJ4TTIvZytzQjJxMXdhNnErc2I0RDlSN2pzVFl3RWhT?=
 =?utf-8?B?RWc5NkR3VHc4ZkgrckZ5TTFXTmZVT0crMG9WZ2Vla0drSDVjMGJNLzlYQ2tZ?=
 =?utf-8?B?eG9xZ2drL2ZiNWxTY1lXc1Q2NkxYYVh2Qk5zUUlHK0xpMy9oWXV3UWJ3Z2x1?=
 =?utf-8?B?Q3pKZHNkaU5qUG1vK3gvOU5EMXRuaHZEbmFZRHQwdU5oVnkyb3lxZ1ppNERT?=
 =?utf-8?B?SWMwWTBNaFQ0WGUxWVh6U1duUnRCajkvdG9IclFMVlYvUGFNTlZIR1NLYnQv?=
 =?utf-8?B?MWNveEZ4NFQ3b21jVVFSVUdVRkZnUUJ2WEsrRUVUUUFXMk4rYnBIQTJ6cXhO?=
 =?utf-8?B?MGw3TG91YytTaEhqUlBDeUhqN250N3F5K0RadUIxMmxhQUNPZjNPZ2doS2Y4?=
 =?utf-8?B?SVpIYW1VN0doWnI3bW1YeFRTeTB6VmlFQWcreE5Tam8xc2tnZmNkN0Z2YXhq?=
 =?utf-8?B?RDVVOTlWMW9UdEcyOWFMTTVaZXU4dGdRYW93aXkxMlBzZHY5bHN5VDdMUUw0?=
 =?utf-8?B?akoydU4vMHBDSUdKajhKejl4U1lBNDF3ODVuS3lqMk5haVZOQU5kMjk5NVZQ?=
 =?utf-8?B?RVlycXoxN3NMdVNmM0VnQXNxK2h2MWVBMWRqcTFHa0dubCt6NE1EdHVRWmJM?=
 =?utf-8?B?SXJvYjI2TmN0SVkrbmpwVG5IUWVka3dCdzR6STRVZ0NodkVFV0pGWlhtRE1X?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2795d15a-6fa4-458d-b159-08ddebc050ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:35:38.2514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWvvJO2bnuXOzLRjxE6ee3yh8mzCx8zgY/tiQuw+fXwmsjb/ElNHcmnpkb2JQ6Cr+Ts4jlGHnmpSUZUkmPICywZF+DLLrUWXJm6p0u+8LOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
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

On 6/10/2025 10:15 AM, Robin Jarry wrote:
> +Anatoly and Ferruh in direct address.
> 
> Robin Jarry, May 15, 2025 at 12:32:
>> I recently updated to Fedora 42 that comes with GCC 15.
>>
>> When building with -fsanitize=address (libasan.so.8), it seems that
>> the --no-huge mode (along with --no-shconf) fails at initialization for
>> some obscure reason.
>>
>> "couldn't allocate memory due to IOVA exceeding limits of current DMA mask."
> 
> Hi Anatoly, Ferruh, all,
> 
> Allow me to bump this. GCC 15 has been out for quite a while now and it
> seems that libasan cannot be used anymore with the DPDK memory allocator
> as it is.
> 
> I have tracked the commit that introduced this warning up to 2018:
> 
> https://git.dpdk.org/dpdk/commit/?id=165c89b84538f
> 
> I would be much grateful if you could help. I don't know the internals
> of libasan, but I assume it shuffles mapped memory around and it
> conflicts with the DPDK allocator inner workings.
> 
> I have found this libasan commit which "could" be related:
> 
> https://github.com/llvm/llvm-project/commit/7ede1c497302
> 
> In fact, part of it was reverted a while after on macos because of
> suspected breakage:
> 
> https://github.com/llvm/llvm-project/commit/4e332bba2f3a
> 

Hi Robin,

I have been trying to reproduce this but I'm unable to. I run some old 
CentOS so I built GCC15 manually and tried reproducing with that. The 
version I'm using is 15.2, could you please retest with latest GCC15 and 
see if it was fixed?

(if not, I'll try to get a more recent distro and reproduce again)

The DMA mask checking you're referring to is there for cases where e.g. 
in a VM the emulated IOMMU will not have full address width (39 bits was 
common at the time), and thus we couldn't use the full VA space for IOVA 
addressing, and had to resort to using real physical addresses (because 
kernel ensure those are to be within support range of IOMMU). Were you 
running this test in a VM, by any chance?

-- 
Thanks,
Anatoly
