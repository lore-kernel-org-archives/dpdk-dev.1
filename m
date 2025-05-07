Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70033C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 09:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E8824025D;
	Wed,  7 May 2025 11:02:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F04754025A
 for <dev@dpdk.org>; Wed,  7 May 2025 11:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746608557; x=1778144557;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KRbaqgZZTpoI3BXeLQlWmNrDmKMN67Fm9apVPtThtq8=;
 b=hbq/TVyAElSpFhfjRjPrU45wsxwyT7MV3nLnXzG/8Ad/aBCoWP8q/l8B
 6xmNAio8O7av1B9gTaXInkmwc4Opbb7dN9tVxPJRJZFYiXzKctgUPuX9w
 SaE76aGkerMyUUR7/rzzntqaBvUV82H/tbDSWtKZwUG08/tBr7751QVD2
 ernA3u1oDTZqvzANMzD4C2PuP/YrXqAsehC0Vl9Q/KIbTHaQUt0PJ0uZs
 FFFi4YoBQbE/ZUBjdM5a2bX0IhTD1Vcv8sYCcoiX0CD6hrYR6J1jAF+cO
 tEvcJN8lFvms4mqzwytQRFFOj1DQmPKsLTKgL1IjrL1bGsnAN8+nm1nwf A==;
X-CSE-ConnectionGUID: utGgvn2IQ3u8sWdHUqnfDA==
X-CSE-MsgGUID: xJfguFaQRjOMTenl28PJvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="73716446"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="73716446"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 02:02:34 -0700
X-CSE-ConnectionGUID: NP1EoKVORSa70zFXK6KSiw==
X-CSE-MsgGUID: CfG9NwAQTxmoJoRCldfQyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135797516"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 02:02:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 02:02:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 02:02:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 02:02:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E51+Nq5a6ZoO2Eqgu2BYtRr/tfUp382679i3sjieM4PzptWJxx0m7YbzEwOPzj+PPpbeFJFJA14la5VpTSShkfegUGKpnhxwXHX+lYqtN+GSpwyOiQ6dLv3baRy8qP1qkvmHRTibPdg0/UeWdzyjhae4QCbAVsZCw3CMBTMaCxGwx2yaY1b26M6zg0JFoR4xZ2bS42wzjy5ioA3bLVnkQkrNoZdRe5WAGJZmGKz8C7VF6KA6z/Ezdfayg+3ClL76y94uAzYFtl+sB82pJ1EIi/TZ1uvUCRdor2zw0IJfi2iPd/QUsMz0KWAxAHPsxOORKKKk5X9DUJB6dzM9O4jSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy0GL5ID5S82HAzHazJkRMWw8PEieVcJ7p6fCGgnCsI=;
 b=obER7258/ti9eL5x7lT+xnKfIR7vZItqGaUPZYoJf5bbARABU/4X9W6GvTWNzklIBPQVRpy8fd5J65qKcREox06yrM/rTrk/aYC5s31kBlULFnUayUwNxjo53PwKN2Pchdzc1/Sz0hI7FFbEz3M8Q3Oh6J2rjq9Wk6YLo/xB3MIOiAD2kKfNJN70UAk3la4IRJxnqn/VNO1ocMKeVk1Tes0BQAe2ehlssWDJmxfb2CwlFH4hB0b7aFp2gv4rvnfFMBdV8U7ymfbjCOY3gd5AJMAXRWQswKj4SpoXCHLri1g1hVjq1suLj5m4kNmPThi8cA+ORXTqgsmb56IPKMuavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 09:02:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Wed, 7 May 2025
 09:02:25 +0000
Message-ID: <234c2983-e628-40cf-9fd2-f784cbdfc1de@intel.com>
Date: Wed, 7 May 2025 11:02:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cmdline: add floating point support
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <cc5198a753f4a86242c0135914affba97d7d4d1c.1746536891.git.anatoly.burakov@intel.com>
 <aBoQ4Z2EUlNHvoI1@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aBoQ4Z2EUlNHvoI1@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::26) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN6PR11MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e26724e-cfc4-4d57-3f8f-08dd8d45e2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3ExRjJVcVV5a1h6TUFKcno1aU5NeUIrcjlzeXBwTHdXa1drRFJONUtmdUtv?=
 =?utf-8?B?S21DVzdaZUdIK0NxUUtFSS9OUllndkp3aVU3b1JiSFlGZzVsZmVXczI4R3Q1?=
 =?utf-8?B?d0lkSXRNS2pLaXRsMTQxb0RGdktOYm1WSlR0STVkYjgydnZxa0FpUk5PU3lj?=
 =?utf-8?B?bkllWTErcytrT3RkY3lTNGR3U0RtTTVRVDVkM2l4QmZxSnVGek9OMjFRZm45?=
 =?utf-8?B?cUF5azltQmk2R3ZGZjNzZWdlSmRhVXNuNGdjRytBZVM5UHl6RlE0RWJESUts?=
 =?utf-8?B?Z0F5L1hwRy9IYnNlaWZIclF0dmN4Ri9BcCszU3JFdEMveHV3ekhOODlwN0Q3?=
 =?utf-8?B?cjNoQ0ErTGxoaEMxazJjRFA4dE9nczNiVjFrY1FkRnhSN3pOeFFaODVCVnhC?=
 =?utf-8?B?cXhVYjJQL1hNcTdLV3lTZktmNldmTXh2SFRlcEllU0VmcHhid2c5aE1ycmhw?=
 =?utf-8?B?RU5TRG10MU5YNU9vbXJxVE9kcGRweFB1eVliMTBFMGsxaTZ0VHhyaTJNYTQ5?=
 =?utf-8?B?UnRQWjEwRGYzL29aL3B1a0d6MlVJUURXSHM1V0ZIVUZoL1FIdjVUWnJIa2U5?=
 =?utf-8?B?cGJuYjQ4Q1BSTFpQcnhTK0VUa3c4Q1NCYkRzdHV4U3J6elJ6am5xTnB3K1Jh?=
 =?utf-8?B?N096TFB1cFJNeDBhTERzdFNVSTRONnJOMGgzdjVpT1YwZDN6akM3cGwyMDlL?=
 =?utf-8?B?dDlUd0JpbS9uOGFpV1kwOWpKalRHU1J3TnZyWWxIcEpQUVJVN1BSS0NkZUJp?=
 =?utf-8?B?TCtlWVdpMExjbGcvOUNxZDVKbDRuVzR6VmJ1dm9Kbm8xRkN6cWhONWdPWXdT?=
 =?utf-8?B?U2k1NllwVHZTSXRwS2tyOFVvUzBBbkZRQmpRQnNnZjgrRTJDcVViUXhtVVd0?=
 =?utf-8?B?eUhNeU4vaHhEY1F0dEJkVXlBeEk5dU1KWm8wZmVCYTMvNVlUOXc5ZlY5MzQ1?=
 =?utf-8?B?QjlmTTloOGZqdGJMVjdhWlVIUkRyUlJ2ZWhuanppZ3RMczhGVkl0QVBJSlV0?=
 =?utf-8?B?aURjZmVlbGl3R1lyNjBLcm5VcG5CSjR0T081bGNtemp3eVgrMkJNSXFEM3NY?=
 =?utf-8?B?dzhlWFQzV0FFV2Vub2NuOXl5bytZMFNRNEhrSjg3K1pRT29lRGRTU2VhdXY1?=
 =?utf-8?B?Rm4zMzNsTjM0WFZVeXJTMjNXblR3ODFFaUtjYmM0bmpjR2N0VWdEWmZpMmta?=
 =?utf-8?B?V1djWWljTkdsTFpQaWtPcVd3R2JNa3RKaGw4ZkNXdmRkWGp5L3BEYURocTNZ?=
 =?utf-8?B?K0tnRWJrV2R5dks3TkUvM1ZEWFM4SjNiTDNuN2RJTXZwemRRQWhXOU5jTUdI?=
 =?utf-8?B?WTFNUmtFcUlhbFdUcml1SWd6V0x2Y1BLV2V3d3U4blpLcFR6RVVrTzBvS3cy?=
 =?utf-8?B?eU5UVUlFUjNpK1dMOCtKR25LNWhwWUhjUWtxSjRtRFdlWUx2Ti8zUTFvUUh6?=
 =?utf-8?B?RmRlNDYzQnlIR05iNXJsZHBjSGd1Q2w1U05mdnZXS3QrelFCZkpIelJXSWlx?=
 =?utf-8?B?b2orU0F1ZzVsQjZSSlVSbjZOOU1CeCtmWWt1dDF5c05vaDJHR1ZSYXFOKytN?=
 =?utf-8?B?akJaTERvZTNDMkJKengrYWhWMnF2YmIwb2w2aHVyK2k0c0JOMHdSQjJ0ZnhD?=
 =?utf-8?B?RGQzbVFoZUl5L3RVWVoxZzRkdjBlcjRzN0wrMnpBc1JzcGgwaWVrOFNhYzRz?=
 =?utf-8?B?b3JrV28yMUFPbzdmZHdlZlo4UVo0Qy9mc2dWMm5hcDdtUndaQXFlUTRZZXM2?=
 =?utf-8?B?bktiRHNXSFgwS1BVZStOamxpYjBVV2YvQTNkVVgwczRwS01UM2tQRjRqNmMv?=
 =?utf-8?B?S0VlM1R3c0MvelpXc1MzWDhsL1NrQURvek5IQmRiQWxxRElHUHpObDRtMWpY?=
 =?utf-8?B?T2xPNWYvelFvOTB6MjM4T3lJTGE5dEdGcGoySi8yL3JPUzFDUGFlVy9hT2Ra?=
 =?utf-8?Q?1doB/WNjTQo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVGTEx4MGlUb3U2aFlzZm9oT1NDdWs3VGV3ZVF2RUVWN3F2RUh2NjhFUjB5?=
 =?utf-8?B?Y2RXYzhxNXlNaGZRaC9yUmF4aTRZMnpMM2VmaVVCQ3ZKenF5RmpXNGpnQnpU?=
 =?utf-8?B?VHNiSUtRRUhWSzRIRnFEU0FSd3E2OU9sbmhkRHJYclJJM0wyb2hKVUU4N3h1?=
 =?utf-8?B?ckpZc1ZRU1duMnVBVGxFVDhyYVpBSkxTa1J4ZGhuSDFyQnpxa0dsNVdHYnFu?=
 =?utf-8?B?cDNsZWZMZWVVekREL3pudTJLUmJvMkkvSzVxR0xwQTRBbmZFNUdUUWErNjUw?=
 =?utf-8?B?L25VN2JFaXdKTUlZR0JoakxZbUxheHU1RU5mclh6amgyMDVyWExYazg2TUVZ?=
 =?utf-8?B?ZzdYeVNNSDZLTmNkU2liVDRTb3N5RExZZ0Y4M1lSZ0RDakR1THp5TEt4N3Jj?=
 =?utf-8?B?dlk1NTFhV3dOS3pUMDZYVG10SGE1ZU92cGxHekNaVjNSdjROZktIVm1UNG5l?=
 =?utf-8?B?NGIyazd6T0J3VndWcjVzcDZJZ3MxYTdRVkZRZnFkN3BkUkU1NzFqbE1oUXU5?=
 =?utf-8?B?MW13UWcwYjBVYzFWWDZRUyt6TDd1R1o0MGhjMDVPbkdNM0hPZ3oxeXFDZHdp?=
 =?utf-8?B?N2hHSTV5UFdETXlxVnFqNEVIUis2SVpXUWV0MDJNemRLbVRrN2lHMkY1THR0?=
 =?utf-8?B?REVYTHE3ZDdxU3hMdmtadm94SDBqVW9KWHE2cTF1ZTZocldnT2ZXTEE5SmV0?=
 =?utf-8?B?RktqMS95bGZiUFFXTzJPUFJpUnd6bDZwRXNxL3BJdkdkdkxTREpNL1dZdVVa?=
 =?utf-8?B?Mi9hbkZ3NzNCQ0RCK1FReFQvWittMk5nN2FBUngvdXdleEt1QXlxZjJzSHE2?=
 =?utf-8?B?OE9zdEJIMytqMGFmUlc3UndFQmNzd05BcCtZZ0NYZURoNDJCaGNtSEVBM2hz?=
 =?utf-8?B?OEZtaXF4ak03c3hSTHkzSWhOZ08vWlF4T3dwd2ZrdVZ6Q0M0dldKdnhEQ1ph?=
 =?utf-8?B?WHZuSlcvVisvSjdCTXQ1T1d3aTFLL0tFNkpoRnJ6SlE5dDNjWjJjcDdMamJ0?=
 =?utf-8?B?UFFsblhSWmZFZjZmRTRockZGcjJNNWlyOENwYVdRSi9mcjZ5YzZyTjAweEk2?=
 =?utf-8?B?dEM0Z1psWG0wUWhCUytHTWNEcVZQc20zdzJpSlgvSEFwY1JNTG9oY2lHKytN?=
 =?utf-8?B?RU42dkRlRHlLdS90eEpsSVI1K3FJb1FGTFRvNk8rSnF1Y1VsdmM1d0VCbzda?=
 =?utf-8?B?bktnM1lPWGVJUVVNTmFHNDRoMThtUTdudnpXVnZuZmRSRndnUVNQOThLL0RW?=
 =?utf-8?B?cE9WdVNZVHdhSEhQQ0IrakVWTDdmMkExdkg3T2JZd1VyNC9GeWpUZkFHbHpT?=
 =?utf-8?B?MDdncW82eE5ZSmdsZlZOYXVneFlZdkxncWMzejJvUU1LOGF6VWdrRTJMRU5k?=
 =?utf-8?B?SUtxVTJwWE9kSUpEVFZBRGpxRzRaRVB1MlI5R3dDV0ZyWFlLZzVOUXNDWTJv?=
 =?utf-8?B?WHF3ZUZ3Nlk1Ky8yWkRCWFJIV1NPcHoxaDNpTHdDSGdicDdFVm9HVzFEbnpz?=
 =?utf-8?B?WWRLY3lZcjV5S1k4NFJydVd2WjR6TmJQNThWUWtyb0lySFFaUktVdVVXYWVM?=
 =?utf-8?B?MjFlR3c0Zkl5N3RXU09CbmpFTVF1N3FwTVBHaktSc2NvT1ZEYVFwMTg5Rmk5?=
 =?utf-8?B?KzA4WDI1YkZOYzMxZ0hEMjl0Z3lqWnRKaFhaZnJsN2M4Qk0wczlyMHNVRjFS?=
 =?utf-8?B?RU9YZXQzL2dCWndXYUZXWUNHdnFmM0ZPaHVuV1NIb1JwVWJIdlZCaVJmdHpE?=
 =?utf-8?B?TmtZMUtBd2gvaDVzRER5OWk4c0NwdUFITlpMT3BpZE9rVHByR0hxSjBsZ0Nu?=
 =?utf-8?B?YzhIalE2aVRNSitOMEFJNk9yZjBSZFRkVndMQ08xT2p5UkxPUjlBQk8yTXdn?=
 =?utf-8?B?aE9lNmkycmo5RXVoL1VrZHZ4TnJtbHBqNHdYYmFnRXZUNFpTTVd1L0VIUklv?=
 =?utf-8?B?T1Q1SlhRai9UUGhIaUc4YjNZeGVYVEhpMVRsc211cllSZFlmYU9zMFhRWThx?=
 =?utf-8?B?T0pma2NEUXowZ1NvMmVZc0s2bElZRDFQbnJGVlNlOGgxWURHVUR3R0x6dlU3?=
 =?utf-8?B?MmM0NHlDYlloa1BFSWorK3pZMHg0anZmamFvUXVwekVxRENjamo5Yllta0pp?=
 =?utf-8?B?ckJ3TXFORU9FeWMvdEh1V2d3OE9Xb3YwQWVrOW94THVMV3pHZnN0a1Y2bWRm?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e26724e-cfc4-4d57-3f8f-08dd8d45e2cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:02:25.6885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Bls3AqBwKGja6TDvpeeUteO/eK9AxNS/MDyBMsqGo8G3VoQet1iFaiemQGm2zr3J0rWkGATT/xdymAIuwXZL1z5a4JuisXdlDcPFvqr1Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
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

On 5/6/2025 3:38 PM, Bruce Richardson wrote:
> On Tue, May 06, 2025 at 02:08:18PM +0100, Anatoly Burakov wrote:
>> Add support for parsing floating point numbers in cmdline library, as well
>> as unit tests for the new functionality. The parser supports single and
>> double precision floats, and will understand decimal fractions as well as
>> scientific notation.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   app/test/test_cmdline_num.c     | 201 +++++++++++++++++++++++-
>>   lib/cmdline/cmdline_parse_num.c | 261 ++++++++++++++++++++++++++++++++
>>   lib/cmdline/cmdline_parse_num.h |   4 +-
>>   3 files changed, 462 insertions(+), 4 deletions(-)
>>
> This is great to see, thanks. Can you also look to add support to
> buildtools/dpdk-cmdline-gen.py script, to make it possible to use this from
> a cmdline list file as with many of our sample apps?
> 
> /Bruce

Good call, will do!

(also probably needs a doc update somewhere, so i'll see if I can add 
that too)

-- 
Thanks,
Anatoly
