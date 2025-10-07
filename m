Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C729ACCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 15:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09191402DD;
	Tue,  7 Oct 2025 17:21:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 765A6402D1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 17:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759850473; x=1791386473;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=doY1bwCjU/p3W6E9wrtjtDMFm97Hf2tVA2ncYdzqAgo=;
 b=W3WX8fWpjenRFoL/3kbEjIwoExyjf5QqAA01jONNRv7HqKCAJFojLwbe
 PUVRUFkHKOswJrPBygEizSKSt3m1ZkbqlRQqHBBI4Aozt+BODHGmrimRV
 HZMvY6i6N6jRcuXGL4PuJpghUkWpGtZsuTWYwU+4iokG+gVYFI0/6jxgI
 gyXeUv4i2pQWv0LMwCsRZLRDmU4ujbj4kFe0HkUoN/B5b6X3Y2LPphJPf
 9pVrqDanQHIeNrk/IPWA2gjhfllckZOcFxjAktAX5wJRX8dOce43M+2Hs
 xBPGfJ76EFln/d5WFsuFYrubdgLAmld79jDtggnxpgDgRgLnRmkr6Jpv5 A==;
X-CSE-ConnectionGUID: pR0xwvQlRJ2LyFdjlDNUKw==
X-CSE-MsgGUID: BAZIrbZ2SVmZcxuTu17hGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73460086"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="73460086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:21:12 -0700
X-CSE-ConnectionGUID: lJaRw4nJTZemmNdO1cvRVA==
X-CSE-MsgGUID: 2CEHKD7JTxCkcJwNOSWlrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="180103701"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:21:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:21:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 08:21:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIFvj5J+ncdOp2uR/PgVg5YNeYIFGNJNzMbkaoXQLc8Q5Je7upqn6jrXTDD+lbFBKfGfzuVVIaHBbdKUY6h6WMjMTg+wC5rv5OBKe0iZQUw3aZ/7dlmtla5pH2lVM8AKisG/BiGWWdqNexMSGPFls4MStZVkFvzvo3f086CUYPPFSzsScbF0aTQD8+4B0CPjRc7cbbtbeu5q04vifAmcg5+yhS22v/QGxcxrFXL9jJtv2j+tqnQAahS9oQKwu3S/Dz09zK5PqbdDbIcdSLkDzags37ZZ44MxR1Bly/B5ouspHXS6OxE6A6xUvI003nmPVYVMmxuF7QDFgHNddepVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B02MoJ+YODLCR91xa2ln6E8kveH9fEyOpvp2YrkAhQE=;
 b=dBTbJARTXp1MBqiB/kKUowATxMdF9k6SydKaUeNwWyOPe+wnuMt/IUwbam/yyTydRNd6u2wnAUxe/cHItIaLbbBObuxV5Cm0NC0t/BZ0I1/r5OXQJnlDF6Vr0go1mc+WRb6Pk+XhPVTLRcTa9p2WMhG5qLwhfQBPEYAjydLuF3Iktr4AJ/+/jHe8e0EFzPUCQUesgKN89dWreTCTBdbVh8rqMuYmULDqX6aN5aARXQh96LmlseuccTXpXf7u9hR93swWByQQ39+kvMIfTJcywrc9QcyC2d3osfHQAfKPkWSOy3MqyMv0EI43RQraAKZsgAvpAiPlOazK6/Wza4aRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS4PPF1C4B3BAB7.namprd11.prod.outlook.com (2603:10b6:f:fc02::f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:21:04 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:21:04 +0000
Message-ID: <1313fa61-4141-4840-913a-38221f1c2c0c@intel.com>
Date: Tue, 7 Oct 2025 16:21:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] ethdev: extend VMDq/DCB configuration with queue
 mapping
To: Ivan Malov <ivan.malov@arknetworks.am>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>, 
 <thomas@monjalon.net>, <andrew.rybchenko@oktetlabs.ru>,
 <stephen@networkplumber.org>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-5-vladimir.medvedkin@intel.com>
 <4c1c74c5-5d03-7a00-9dc3-c837a2ec47d2@arknetworks.am>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <4c1c74c5-5d03-7a00-9dc3-c837a2ec47d2@arknetworks.am>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:10:232::14) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS4PPF1C4B3BAB7:EE_
X-MS-Office365-Filtering-Correlation-Id: 101e10aa-73ca-4c96-c9f8-08de05b521a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3d6eEYvMkpCODdWa3lQOXU3UkYxeDc2NXdjdGFMK0lCL1BZZnBwOENxMFRx?=
 =?utf-8?B?NUhOYU1Hb2JqWmFQbFB3SEYyWUZPb2x5WjhXK3JRdjNSbWppMjgxakoza0N5?=
 =?utf-8?B?a0VLcVhmMC96cVE1SnZHN3pTMlJCVkVuNzNNZ1lqS2UyRllUbDNnMXNBSnRz?=
 =?utf-8?B?bjFiYURRaythMzk0c3dXajlXU0xYN01YbUV4YklRY1AybHVqYnBzVlJ3c3Jv?=
 =?utf-8?B?OXM2L3p2Rkx1WEVzbkFQdWJyUkljdDFUb0ViM1FFcGh6Unhnd1RzM2hYMllz?=
 =?utf-8?B?RWlWYUlvd256WHRFNGNsQ2U5K1NCZm1Ta0pIODF0Y2dTU3dDek8wMVFuNzYv?=
 =?utf-8?B?T3J4a1NTdHRBNG1Lc2g5a2FPaUNaeXd1V3JzREFSTyt1MWI4cTJSVDlycysz?=
 =?utf-8?B?VGdYRFpzZUo1cDhCbi9EbkprMzg1N0o4R3crU2NkUmt5Y3FXVDltNUtic1Y5?=
 =?utf-8?B?UERYR1RaMlFDa2M3UTZnN0I4VXBBQVpWOHR0WGJqNTUzdTVicU9jZTlyS1M3?=
 =?utf-8?B?Z1hKanlqdnBqalZFaUlsUlB3OGhCUmlDVjNjTHdNeFdUdEFsRG12VG1BZ2tW?=
 =?utf-8?B?QXNtRjBCQWhrb1BaQmo4cFZWL2EvRkhpVGRyWHVGWUNmcmo1bWU1YWtycnRi?=
 =?utf-8?B?QW1UNUpVWXFmajhNQXBhb3lESDQ2K0RsUyt0QlhlbzY4ZVVqamFKQmVtMjZQ?=
 =?utf-8?B?b09tMG8xa0dZbEZlTm92N0dmTHhvUlhNQ3dHRS90V2FWNStIWTVaMHo0VndB?=
 =?utf-8?B?b1FvaTkxSWFSYXBCdzlDY3BhYzRGNm9sSGZRQzR4VWlyZnhKOWR5b1RzTHFR?=
 =?utf-8?B?aDg2UEo4UEcxQngwUHh0OHlaMzl6dXArNkJ4OVhKaDZ3TUdKQWUzOEhqQVVu?=
 =?utf-8?B?QVJlclVFcUVZY01YWlZyUGp0NFA1eDFrM3UxWE42OU84WjhxVXR0MWVKZ1o0?=
 =?utf-8?B?akhnMGwrY25JNVlXb1Bxd3JJTzM2c3ltRzdXeXRjakkzWERacTNuVkJhWmhI?=
 =?utf-8?B?akFuM0pOU2xia2V0VDc1K3VOeDQzdVk4VUR0b1BqYTdSWmlTb0JwTFp6Ti9t?=
 =?utf-8?B?Mm9JRDY4QzZ0VjJrYUlYQlBmR2JtS2RqaGs2VnhwODcyeG9KcC9mVXNTeDVi?=
 =?utf-8?B?ekRTVE1qVU1jcFVlYVp6ck55bExqZ25peGhxeWhFeG5tZ3MyK1B2eENOZTFu?=
 =?utf-8?B?OHFvWjhSdHovVGoyeitzWHZYcG9LdlBsL3Mzdmw0Q2ZESVNPV0xxN2xsTTVN?=
 =?utf-8?B?MEtiRmNieGV1a3Jvc2pmZ2tFWjZiSXIvYm9QWGVvV0ZaUEgrdjBSSy90SEhq?=
 =?utf-8?B?aXFydDMyd3hCWHpjMVNPa1VBT01qaVZtR3o5citITzZ2dHFtOG5nU3lnWmxW?=
 =?utf-8?B?ajFGZjlIdTFadXlFOWdEMk1HUE9oRHFGeXh2L1BDdEoxZFlDMnBaOVNFVFpW?=
 =?utf-8?B?TStpRFhuRGFDOWczeXYweEVPdkU2RTAyQ2FkUkFVNStWQ0ZYOG1FRUp4NTJr?=
 =?utf-8?B?Z0pWa1hlckVlOGdHVEh1SVpDOVhnRTljMVBlVkduNVVMSDIzdnF1b3JadEVx?=
 =?utf-8?B?K0FWLzA4ejJvUys2TmJCU0syZEczRnAxY3NheFRUQnRXN0FHMXNTcHpXNGlv?=
 =?utf-8?B?RnErMVNOSFMzbHhCMVhVZ2xSTm5EalhTQ01xNkF4dXhTcmFVV2VPUVowb09E?=
 =?utf-8?B?dzJjdW9tOHhZUjlucFU0L2lZMStCNnZCNE5hVGNLdEZFTWI1OHJ4MVVSSi81?=
 =?utf-8?B?Y2NiREpoa0lkeUIxNjZrS3ViWHlXRTduRW55eUJXN0YvKzhHZ2tKQWsxSkhV?=
 =?utf-8?B?OVBOMVM2MElyUjJXcWN5enh6UC9yUllZd3ByWUNyWXIrb2NVVUkzcy9ZRXZT?=
 =?utf-8?B?VUNUUExDNGpYV2hMcmlIdk4yZjJPWDU0ZVUrWU0xcXZiUDByL0VwTUR3N2w0?=
 =?utf-8?Q?bYM28N+2JFp9w+I4Z2hNjjNAXTgkjSe5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ppeWgyUXRzQVA3K2w0MGtKcWlmTm5tc2FkUE5XYnZrVncxK3lSV1VkNHFw?=
 =?utf-8?B?cC9kL011cTNwSzEvZDlKZzczS0YwUkYrWEZoTlVmY3JXWnVIb3A5TGhNQWZC?=
 =?utf-8?B?bElNenJoVFVGYm9DYXppZXI4Z2kxWTRqL29sWEovZlcwL2VCbmVMZW5BQ01Y?=
 =?utf-8?B?Z3huYUM4MVh2bk8rTlpDNldPVjRITk8remhrQXduODMwOWVZOHl0RjZ0T3I0?=
 =?utf-8?B?Tm1GV3JBSmhHbEkxQS9PMnFrc1NxN2M1RUxrcnQzQW1uREVoSFVvcGErbXpV?=
 =?utf-8?B?MXArQXB3SlBUdnhxT2NmaDJxNFI1N2pKcUpOalY0VW0yUkVBZXVGUUdUUjc0?=
 =?utf-8?B?TGlCNU1jZmRjcDFRSkJMRmdBTWtPcld4djVvV3NlRU9UK2JqWlJzeHNaMWVR?=
 =?utf-8?B?Z2o3SHRaTmxQRmVTc3B2UVY5NzFyd0F3cXlGYTlaVEFXZzRWTkJyeCtPcWhw?=
 =?utf-8?B?ZTFQblBmZ1c3NkNmb3hDZnBaZXo2VURKTVpDQ2gwYS9temdoTzZhdWt6ckpN?=
 =?utf-8?B?NVl1UlhDZmRmK0U0ZTgvRmFVTTVSSUYvRG9lL0RxSkVZRHJQSnZMYnI2bFJo?=
 =?utf-8?B?SWJKcTdjSVlObDc4ZlZtam1QeCtHR1ZWVXFMdjRxdUxjeFVhOWZUWGJKNFk0?=
 =?utf-8?B?T2drTUJUdlJHZG1oNVlCWkFPV2Z0dURkbEdhaUFCQ2hEM051SzZMczc3Rldu?=
 =?utf-8?B?Yk1qRi9pQVVVVE1NWHlvYlViejh5RTlZWjJXcVJmQkRUZVh2bzVrTFAvU3Bm?=
 =?utf-8?B?S2JjeDZESXh6dnNuQ1lrcEtDMHZQZEcycEtFSHQ1MHl0OXBwTDR4d3M0VnZY?=
 =?utf-8?B?aVlGQnRtelg3RFh6YStOUUxqRVArWWdteGlxOWV3RHpwdVJ2YXp3Q1h6cDdp?=
 =?utf-8?B?eUUzNVFYVG11dnF2bGdTbXk5emlvNElXWmhscitSUEcrWk9oelhDWklUZDZl?=
 =?utf-8?B?dFIrYk5sa0hxVFU2OS9nRk9wZVUzVkFpUXNBUXdVT3o4RnBvbmUrc1dha1Vp?=
 =?utf-8?B?TDBBZ3B3WnI1S0pveXFETlFwWThCM1c0aGZuQWp1bUo0bWplZDVKVmltZFpH?=
 =?utf-8?B?YWNScVVlbTIyZ3dndXJCbUdXRFZqMjZTZXkxMlN0bFRpaWl5bTlCYTQ1Tmw2?=
 =?utf-8?B?KzZZQTgzbEs4MmRzeGllcGdhcURZOGNDczREY2lqVFcrK0h4RnhjVVRRbGNi?=
 =?utf-8?B?Y3ZNSUl4V3Z5ZFE3bG1rN2pzTlJkM1F6T2VvZFcyNlBFSUdVTEFXc0xaZGpB?=
 =?utf-8?B?MTJwRCtySGFXcEVxQmdqUXBiY2RMRktxemcrRm9tWExtOUkrS0R2NGEzcXZy?=
 =?utf-8?B?YWZTalV1REw1TWdiM3R0ZDN5Um1XdFhJL1I0MGdyN1dDd1pKaTI1eFFPTHh1?=
 =?utf-8?B?NjNYaUlLOWdLbGRmNXF4UlZDK0tuNW1USVc0MGJjMU40NURiSVc4WEpycmZ2?=
 =?utf-8?B?bW02dFB5V08yZ0VJcVJDbmFITm5CVXFWZTFvKzVMd3I1VGpqVittMkFDdis4?=
 =?utf-8?B?MkRkK2dmRzVBYlFXc3hZVFR1OTlFeWRhbE9yTDhFUkFUYklJYWVrMXF5d1gv?=
 =?utf-8?B?RkZudlMvQjN5aG00eThJcittdEdGZ01oM0FNNmZjQ2tObFo5UmtJNFlpbHoy?=
 =?utf-8?B?MmtZUytFOHhsa3RkM0RnakJaa0Z0a2xUR2RuV1RXUTgzeW9uZjJwV2J6NVA3?=
 =?utf-8?B?cFMwQmFzTm84ZDNnZjkrcnkzSGxDRDNnQTN4T1hWY2VxeGdRYnVZZ2ZUTUJ2?=
 =?utf-8?B?a0NMdW5FREVBckpoa3J5ZU15cW52eHFFZ3R5T2VpQ3FTa0VpeG9mL3hLV2lB?=
 =?utf-8?B?KzVZREFpUm5GaEZoOFd2OVo1bWVVYjAxc3hYN1FRMzdDd0lMRG40ZFRCTWJr?=
 =?utf-8?B?SzNMYU9mTkxTSmRPUmtzUml2KytNQWxXN3NsSmxSeWFuUDFEQ3c5RW1rYlZW?=
 =?utf-8?B?N0ZYV3Y3ZG5JNVJwNmk3bHo2Z0dZMm5saS9zMFdHTWpOSnlNajZoSjF1bWRp?=
 =?utf-8?B?c293MXpZU0dUM1g4RCtkUENiSDlsUmZFRm0vR3B6K0ZMUHprb3FES0xmRVFY?=
 =?utf-8?B?ZzE1WWYxWDNzQ0szNC9DamE0dnE3L1JuUXpXR3Y0OFh4ckE4SXc5UWVQbXN4?=
 =?utf-8?B?RTdEcTZ3akw3enlXMXFSY0svTzFMZzhCU08zV2pleFRUU1BPMW0vYmVTR2hp?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 101e10aa-73ca-4c96-c9f8-08de05b521a2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:21:04.7057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEL8i3dG/DtuZuzL5W/Xf2k76Yw/opp8ZBswhy0xgTEBVTNI3hYKL3B6dXiZr1FWOmlr/bI32xlFyWNITXsfWkpnGQ5EdNBvJrk/5sD788I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1C4B3BAB7
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

Hi Ivan,

On 9/25/2025 6:59 PM, Ivan Malov wrote:
> Hi Vladimir,
>
> On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:
>
>> Currently DCB Traffic Class queue mapping is only used when calling get
>> DCB info API, while setting up queue mappings is up to each individual
>> driver. Use the tc queue mapping structure to enable setting up custom
>> mapping explicitly.
>>
>
> snip
>
>> -/**
>> - * A structure used to get the information of queue and
>> - * TC mapping on both Tx and Rx paths.
>> - */
>> -struct rte_eth_dcb_tc_queue_mapping {
>> -    /** Rx queues assigned to tc per Pool */
>> -    struct {
>> -        uint16_t base;
>> -        uint16_t nb_queue;
>> -    } tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
>> -    /** Rx queues assigned to tc per Pool */
>> -    struct {
>> -        uint16_t base;
>> -        uint16_t nb_queue;
>> -    } tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
>> -};
>
> May I clarify: is 'tc_rxq' structure supposed to facilitate the use 
> case where:
> - VLAN ID (VID) of the packet selects a 'pool' containing some entries;

I think it could be VLAN ID and/or dst MAC address

> - VLAN UP (priority) selects an entry in the 'pool' (gives 'base', 
> 'nb_queue);
VLAN UP selects TC (could be many to one mapping). And then TC selects 
an entry
> - if 'nb_queue' is 1, we send the packet to a specific queue ('base');
> - if 'nb_queue > 1', we perform RSS across 'nb_queue' relative to 'base'?
yes
>
> I'm slightly confused, as [3/6] seems to remove 
> 'rte_eth_vmdq_dcb_conf' and
> the 'pool_map' (with 'vlan_id') and I'm not sure where it should 
> resurface.

Correct, I think we should separate DCB from VMDQ configuration. 
Currently rte_eth_vmdq_dcb_conf combines two different technologies 
because of how old NICs were working wit respect to queue assignment.

But now I think it would be better to get rid of `struct 
rte_eth_dcb_tc_queue_mapping`, at least inside the configuration block, 
and replace it with a somehow similar struct, but with one-dimensional 
array indexed only by TC (i.e. remove `[RTE_ETH_MAX_VMDQ_POOL]`), 
implying similar per-TC queue assignment for each pool.

>
> Thank you.

-- 
Regards,
Vladimir

