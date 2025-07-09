Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4F1C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 13:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A5AE402DA;
	Wed,  9 Jul 2025 15:31:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 47939402A9;
 Wed,  9 Jul 2025 15:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752067899; x=1783603899;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cjC8751rrqw335wArfjEI5whZytvNyW8mbif1aYVCQA=;
 b=Uanx6QStykvZdktFoaIOoSMlobfooB4dt90qLKOLTtxcbPD7LM/jf4i6
 785Tef9UN84jxfoVqcLbejBpzdWomfAw5WW8UUfG+Tarv8kSqS+vFFANw
 Qqtep0j0iX10YWxnHY8xH/G1FwQEtEt9GlUktSn+5KjgqbCbp4X2yZvqD
 IJCDl2qeDfyaP7pGVXzjavJ0rHhMrhCOagbfZNsHksZXJT52jmEzPlLQK
 atImNeJXvPqThbvk+YiWMmV8oipC7kRJ1AS33YU4OoCqyhk2NZdU7Ahpb
 +81J3bafs/X3sfk+dzbQfHUpb/T4Uvqw2+P148tYvmuxyQ+eY5/Y7sMG8 A==;
X-CSE-ConnectionGUID: B6ZJzmGrS66hVBaxrimTuQ==
X-CSE-MsgGUID: s1v2iLvzTISZJ+rZWY3A0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54455868"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="54455868"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 06:31:38 -0700
X-CSE-ConnectionGUID: HdzsggLOTJ27RMJ75hi9mQ==
X-CSE-MsgGUID: ypGOOS9TQamubxDU73GKoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="155867569"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 06:31:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 06:31:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 06:31:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 06:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7iMxwHT0MQ8+Vogs3wAf1qvSLuakegTcS44JMVcTmuPxFaIadwrOkR+cvfHxjZc5Z5V4701TuMxrXPkpG2F/F6W+IZ+ComIH3TYCiOh7l55IMIwSpT1HVZy3BnS5nRtCNiXuoCCw1CzSNmrU/tDv5ZK90bzd4FkGpbV6N3oNITr28LBiBwZUUvKcZb35odDEmJ62xHt3pT6osjpyH41NwaPDCbalnEOVly7YJc4QoWCpLdmz+z7R3mBftnaifdWvO4ezd2PcbPjnNb7G2UReEWxtKWFlD91r2IhMYxlNDzfi3v4G0320STuddsHPSaHW2W8UrzWrwiKbuOUDiHYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8sjk4ZWSXamo+Pg5x0ppActbF/OMAG0D3hDlxCwMpM=;
 b=RI/6+APQnOeUCNPPfwvgmUxqZO+DIqgQ+DN0D48fuzpNFdrL/K4DGJxBXgy/OlIIucQC8DFK2zGYH1RpZlOd1JOaOHvjpBswHFek2n/4mlgEXCCXH9j0ArfbsQeu0AX/8lhGUYtlb76ekd+gB4Y9mCNsWCtpStqzdCCQPICwIQBKwEQYgCLLkkxEnVyQL7MypgkDshNa9EvgzyPSjeurZzW5O+GWflblGIPzeH/kAZEwyWhJCRjUqBL2aNik3/CZcUevoVlvdQHzMmJs9wyF6b9XqZ1tucGHtfcEuJdsy51q0BjSPbAPIwN4MkfHwA5/ccoXQDqqO5xEdCQaNbHcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.29; Wed, 9 Jul 2025 13:30:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 13:30:53 +0000
Message-ID: <9ad49a76-13c4-4d8c-9de6-6b4a56a1a351@intel.com>
Date: Wed, 9 Jul 2025 15:30:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/multi_process: fix cleanup on exit
To: Maayan Kashani <mkashani@nvidia.com>, <dev@dpdk.org>
CC: <rasland@nvidia.com>, <stable@dpdk.org>
References: <20250708070954.165222-1-mkashani@nvidia.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250708070954.165222-1-mkashani@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0246.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: de6c14c1-2207-4bc6-2024-08ddbeecd40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHNqcGFPOEVyY0kzZ3d4bUtTR1A4MWlZQll6cVdNeUg3Smo5VnFQSXhmTUhz?=
 =?utf-8?B?TzFSMFMyU2VHK1k5eGsrbmxySzYyWkRRamVNTUNHQmhtcE02RHdzQVhQdDND?=
 =?utf-8?B?eE84ZkhEeHROcExmVjZjKzhaNnRSSTNnU2ZXay9zdFMwaTl1TEx3QmplaldL?=
 =?utf-8?B?MTVvOFVCQzNoc1FlZjdBYSszdmZYSnJqdzFkdlFRR3dLVUN5Zkp6MEwvdld0?=
 =?utf-8?B?RjBJWHFIby81Zms1Uzd6VnRKaElwV3J5WEtBbjY0TnlKZDhIY0lwOGdnNTU5?=
 =?utf-8?B?cWFtVFJiNWNPZC9aYVFjNXhLYjFNQWlXOXNqU0MvWTdISmxvWHAwTElDcWNq?=
 =?utf-8?B?M3VWT2x0YVNjL1lUM0U2OW9lRjFuYmFCMjFoZ0VsTjM3TzkzRmNkSTMzUGgy?=
 =?utf-8?B?UE1KM2dIV2JRV3FoQ2JzU0RvTlFjYUdYWldJRFJmRnByNnJuQmtyRVdyUC9F?=
 =?utf-8?B?U2Z0Q3VvNDdJaCtlS3EyQmV3cnhUTnNZZHMvMG55Y21kTlNSYlJ4MkExc1Vv?=
 =?utf-8?B?TkFpbEVsRmhnbmVOVmZGYVNSdGxzT0loUTlackpQUXpLZWF4ZzFINjFJaDc5?=
 =?utf-8?B?WnUzYTdKQi9DMWNOb2d0anJSRm9iZEhiZ3N4ZE8wbkp0SkorS2ZZQmVwSVNx?=
 =?utf-8?B?VVFLYitKajFZellhQ08ydXQrbEprc0RpdUhYQXBkN1dZRFAzUHpFUndNeUpp?=
 =?utf-8?B?S21pcXJ3RkhHYzViWUUyZjZEV3F4S2VoZDJ6MUlrNUxtK0Zhbnk5dm8xWW54?=
 =?utf-8?B?aytvOGpuM25aVnFlVzdEbVovWWFCZERyYmNXS29qYjcxOG9yU1B5UUlYV3o1?=
 =?utf-8?B?azJQRWd6d2d1WXhxdnI4UVE1Tm9FMDFXeElnQzArYTE0dUNnaE13b3VNVE1L?=
 =?utf-8?B?MS9pWnJpamdCMWNTQ1hqYmhVUEJGaXBEdGRrMlZSVC9tQXNVYk9tMDJ3eEtw?=
 =?utf-8?B?YktBanR4NTdRaWxDVjNRcWx1VzNEMkY4ZW82bitwVlpHeXMwRmpHelNLcnBB?=
 =?utf-8?B?NXlMakNaZjZrYllQT1ZnbWRVUW53MzJ0c1I2UHYycVdDZXZVV0hEWnprSS83?=
 =?utf-8?B?aWMzNld5cHkxUzg2eDBTaEJjcHZiVVRma0pKdEhYTy8yN0dlcTJOQ0d2dCtG?=
 =?utf-8?B?THpMdzNwL3BHRUdaR09YN3Q0Qi84UVZwVTBVYldjb05hNFVCS01La3hBTzBK?=
 =?utf-8?B?bEJkMFd3ZVFCWHA5cG0vb3hZVFNLVldCejdYSWEzQ2YzcDZDNkQ0NGlTTnRh?=
 =?utf-8?B?UXNRN1FTNFpSZ0cwcXZrdGgzZzMveEg4eENINHhOTGVoNExyYVQ4QmRKR1Uz?=
 =?utf-8?B?K3NVampLbjZEM1loWjY0MS9obGU4UWxYaDArb3gvY3JaTkNSSDdTT0kzaUx0?=
 =?utf-8?B?WGdTOWFRMzZ5aG41MVlrNWpmSXlmMlBxNm8rMWtnOElBZTloR29WQ1Q1ZFdT?=
 =?utf-8?B?REFnT1hraWxZdVB1MzRCVjJ6M1VRa0RucDBFazA0QnVMY3ZOelRqdzZmclZE?=
 =?utf-8?B?bis4RGY3R3IyTUZ3eERUYjh2bnhod1FKRmtvSjVRa0xHQlFZajBtcEtxS3Bh?=
 =?utf-8?B?eUVaTDRXWGpRc0w2cEtremtSdEY4RFNOZVE5SStZdHBwbi8zQ2lVNnZZYmdz?=
 =?utf-8?B?SmpsSzZWZVdOeENwV1FDNXkyWEhFUGs4eWlkRmMrRnhmZmZzaE82d3crU1lF?=
 =?utf-8?B?ZFVBblpxdjkxM2ZNL1MwMDJKTkhaWjgvMTJEMTVlZ093K2JoeTA3ZTduYXVZ?=
 =?utf-8?B?dDRZWlBacVF6ZldlYjFkRUkxZkRlUDFWZ3A1SDRpY0xFem1zZFZUQ29NTUxS?=
 =?utf-8?B?UHJuZTB1M29xS0RiekhGZDljZGwwYURuM1NHVkZLbHJ3eTErVW5Ca1VDWnhT?=
 =?utf-8?B?RjhUODlqbU15VDhXUnpnc3dNY0pJTnlJUUd1Wmhsb1N6eXZBblVhMzNsZEJ0?=
 =?utf-8?Q?wEy5csC0WzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azRyaEluSmZ3MXdmanYra1FtdktER2xuNmluZkk0dG5tcytxT0pObE9yWFZa?=
 =?utf-8?B?YTJoWnJwYytHRTJicTBxWmpVcFdGcFdRbFVKelRPOUNhdVpSVnFVUFNjZmJ2?=
 =?utf-8?B?SnYrcVgrb29hMGp0bEtYazR0bkZOT0RKbm1TNVlHY1VHN3BNZ1ZGMHBWYWVm?=
 =?utf-8?B?WXlmbCtHb0hYa1N0VHpLZU4yS1ZWWWNkRGFyL2h2TXdYdU5YVlMyOFBJckpC?=
 =?utf-8?B?dkYzQThvdXd2THo5R3RtNmIwYjdyUzJTbFVNYm5uZE9rREptTmgwS0wrZGJn?=
 =?utf-8?B?bEdRdkxMZHlVY0pkVDNhalJUUlM3U0xOOTJCTmdUdmNiZUZLQ1dZRXBPUGI3?=
 =?utf-8?B?UzRPY0JYVUNUODEwdFBIWEdRUjdLOW5XclUrdUNDVU9wSXFKem5RT05LQ0dV?=
 =?utf-8?B?Z2l4N3EwN1N4VDlGcUNvUUlHVENOZjhTM0RNR1o0K3JEWXBHYVFSb3RYTWg5?=
 =?utf-8?B?TTZGNEVPMFJlcGpnY0FLaEFhRysxRFZjYWkxRWpsbk9jUE4rRzlkMmZTTlFO?=
 =?utf-8?B?THJ1RzVGR0FRS0xsUlJaQjlNRWRwY2p3d2pmLzN5YitXcVhBaUpGdjI4VFZJ?=
 =?utf-8?B?UXpvSFdQNGc5R0F5eEVDaExhT1Y1dTBzMHZFSTdQcG9TbGhjdzVaZDZnTGIv?=
 =?utf-8?B?T2M2SmhnTHhUWU4vSCtjQkluejVReFF0YWkzQTROcVZSS01GNk5rWU5Lektx?=
 =?utf-8?B?THZlTEVaSzR0MDltcjFOdTNJZ1V2THRoT2UzcHRsYnFINVRhZWp0VjdqYU5X?=
 =?utf-8?B?dTQ2dlgzQjVzT3hvRWR1bExoT0RVSzVSZDNmbkNaVkE3WGViYTVsWjdjQnYw?=
 =?utf-8?B?d2tESG5aWDMvMC83Q1pQNGh1cVdjWDN6TzZSZ0dHZ2Vyc3pzaVhUTFoySDlv?=
 =?utf-8?B?OUtuNUI5OSszSXlMeGZZTTRzYUp0K2ZzQ3I2QUxIRTFLWFErdDlaeGtDTWtr?=
 =?utf-8?B?Q0QyOGZFTDYzalRlY0FyVmNyUEh6NGYxb1RwOWxaeXBFRmNxVXMvWFdmYzcz?=
 =?utf-8?B?Zms0UHc1WHFtRXdIVlJMNUhPSCs1YzU2VzkvYmpQR05LeVVuNkRPRnRwT2kv?=
 =?utf-8?B?TFJGRi9FckZNNTlac0FXTE8rejNRZGx1THJNUVpCYlBoTEpEWXMzZ01RZWtY?=
 =?utf-8?B?ZUJPcE5JVEN1czhrUTl6VWV2Y0RBcW9FcjNmeGRCOUlSeGEvL2hZNG8rYkY1?=
 =?utf-8?B?NFFhd3BrTzVzQzFhcnpTU2tZQ0ZJYjZycUhKL3ZOQ2RMS0czUmV2dXNZTEN5?=
 =?utf-8?B?b29jcm1YcUNQYk9zaThVSGE3VTh2V0xsbVhBb1hBV1FEM2p6Z2ZrMFhyQWtp?=
 =?utf-8?B?QjVRVzZydFB2YVhmMDU4VjJZTHBNNlVxbTJ2SEphK0xUV1JUckRWL2Q3M0FT?=
 =?utf-8?B?T1c4VXRTS1VKaCtXT1BRNDlZSENaOGl5em1TMWtOM3NUOUxsZUR6N0ZDYnVo?=
 =?utf-8?B?VTJpaThldmhvMGNpVENzRVNwYjE2NzdwWHBCbG1FTXNPWjFGZlB3eUVoa0lK?=
 =?utf-8?B?MWpCdGc3bVJuOFRTbU9xRjFraU9YQW81Z1VHK3lRaFRVTm05K25KaGhVRmEz?=
 =?utf-8?B?NnlvaUE5UFJnU0JMemRJZHppaFJZVlhyTEk5MnQ1TlJEbXBwUStPVmc2UHhF?=
 =?utf-8?B?SzZCMTA0dVpPZmZPci9qczZPbWFnMzRtdG04Nll3WDdneUlJY20vMTNYdWk1?=
 =?utf-8?B?am84ZDByWlREV0d5NGR5QUZZdWE2V01oS0p0VEp0QkRycFlZNytqN2pmc2RX?=
 =?utf-8?B?ZW8xNDJ0ck1MYSs1V2lkNGZNMmdBSC9xTXJIVEFQaEVWOFlGalR3RzNaVGsx?=
 =?utf-8?B?c2lvUWJaeWJNUWJiQUdBa1Vad2FTSHJPR29COGNGcWRVSDJORDMvVVJQeU5V?=
 =?utf-8?B?OWFtWWtLZXQ4RG9UQmZuTkphaHdqUTZ6OFZaWFRMZjFrVnpkOVNwUENHdytN?=
 =?utf-8?B?Sm1XVjUyeG53akV3RndsRkJ2WTZ1aDI0NFF1L2VCZm9JTjBFd0ZFVitudFRl?=
 =?utf-8?B?TWRlVDM2eFFYNFBaTDNzQmdIb24ra094MVJBcXRRU2VQenZjeU1DRG9oQTlt?=
 =?utf-8?B?YjF3V1hKMlZlVzBIMXdETE5JWDhQOFVGVzlUK0VoelJNeExkYjZ1MEZ6V3By?=
 =?utf-8?B?VDlKbUdJSUtDZ2RPblRYeWt4R01WcW5rdUFiQjgvc1FlNFlXU2w3b2pwdEdn?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de6c14c1-2207-4bc6-2024-08ddbeecd40c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:30:53.6660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFw5wnzDEvJnDbBICqNIm/KmC7SAsLmfjdRn6ifECnwuVHFBZLiq8KU9L5pR8KXVFvlcv/GrJxq/2dOh1ZKHPfMoc9bbDCOE5Aax2VuDjaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
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

On 7/8/2025 9:09 AM, Maayan Kashani wrote:
> Device was started but not stopped on exit signal.
> Added port stop and close on exit.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
