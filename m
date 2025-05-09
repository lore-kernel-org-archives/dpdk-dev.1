Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1503C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 14:47:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6254025D;
	Fri,  9 May 2025 16:47:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id D2FBA4025A
 for <dev@dpdk.org>; Fri,  9 May 2025 16:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746802027; x=1778338027;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BJrj70GH3F74iC+6Yn0nabAL2whUk1JXI2WTaNgkywQ=;
 b=WcchCD/mzhZTecvSV+btXp1/uveZur27741JKqbKEdeLHAsxy2d8ohkf
 icvcrVae7ubrVrY6MYdPl31zW2+mur3heyRapMBTlP2/BGHJLgXElBLoZ
 rwbOTE7it2Bp4orhHyWxOO+G820purDoGb8hGpo5H1QzXocYpDTD7AI1U
 ht6Tti8uaxy+1sWGdooKEgQL/8B4HnlPrAg8TJnmEFsSolLQUrQt9Kr3L
 a6//x/eiTNho0Y1YNya3W8ra+kZCE5SZLyauKgaQfEgFxATREwiXnRQXN
 QCTIoZtRxKPGTJOqquZTSHHyWlX0zgIBCWOMiekCubGp2cf7DJ/7OW21z A==;
X-CSE-ConnectionGUID: BP/56h7oRY267YEmuguXCQ==
X-CSE-MsgGUID: 8sfs1yA/SM2wzxfgi65CyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47749331"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="47749331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 07:47:06 -0700
X-CSE-ConnectionGUID: FR9g+xqwTZSm0NpY6lZC6g==
X-CSE-MsgGUID: mSoyrl0AR7qkw+OXglLy6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="136660186"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 07:47:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 07:47:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 07:47:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 07:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di7zo0fcNkVVDYWdjQqY+1EU8I57LFUO+ryPQOOk+wG0xe4Ukjtl5Vq61TdtHEUr2/aRk+bYTMl4EblUr0gOvjUFXrmVdjpVf5iwrNpqYhfeXVGR3eVlkm/hYCVIExDC6uOkF3vOixqAoOWPmla+f4ysXLu49dAW5HtsiTeACqzFjTj4870sANMOwx8p47TASt1oNfySMpzOo9tUp1okTTb3pwfqmw/2RfjMRWXvOve2BQO/803CpPy1bpM5pnFRkrLLis/3YeRPAWfOyqvWzZkqhyRD/Z+qVDVuwGHShIH27rKJYCMW22t5lzSSMy/kmFpkex4nVvl1eWYHtQXvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5h7X+YHQ2ajrXgLv4ye+ThWdciS6o7JRWDU+bcavno=;
 b=HblW0fZM1K7o4L4IJ1DPLWH/3YtWkRNpcNUOD05jWo0Z6XMkqBMfOy3DEszSOJjeHH1H2tVYM/C5AijrTHMafaXRV0fUfm9oMDIajz3pECFz8xO/YqCmdgrWf9VX3pdQWI1kWgQKSEdhJob9DBxlRILa8aS1spCGKuLxdHtbNo6qj+gUUj5xqtfmLRoMytq9ngXtKkPagLb0VAcQbyWCmT9HJvYqt3yHIcZWrDIxDd0ibYEjy+G+IZ1WqsErEcMDYduTyOZveTHe4Y4jBAh5YrbbD4W5QByszD4yHsBYoPgQ+G8tsK7tA///ipDrT6QWf47ZbSn589bxbjG6DxSDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Fri, 9 May 2025 14:47:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Fri, 9 May 2025
 14:47:03 +0000
Message-ID: <7eaf4388-a5eb-4ada-a1f2-b1d3e2844857@intel.com>
Date: Fri, 9 May 2025 16:46:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: update log message
To: "Pillai, Dhanya R" <dhanya.r.pillai@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <timothy.miskell@intel.com>
References: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: b42cd1c0-a7a2-4cbd-8fba-08dd8f085c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkhiZWtQVHdHYmNDKzBOVlFsUmlUbW9jbzFFdHg1aE4xV25TQ29QZ1YzbFF4?=
 =?utf-8?B?N2xIaEYwUmlsSUJ5UDBMVm9mM1U0TjFwVFRTQU1CN1RZZW82aGVpcjR0eWVj?=
 =?utf-8?B?bm1EV2dCTFJjcmNabEJ4UmoyYmwvY25EWVIrUjl2aWhsZkgxQUMwKzBoVGhx?=
 =?utf-8?B?eERZRmhpQ1owR0ZVRk1SbE84Y01lY1M3Q2JJSmVsL3Z1TDY1Z3VDMHgzZlN3?=
 =?utf-8?B?ZjBJSzNwb29ROStsaHRMbmdnY1RmQXBrcDEzd2NHWU1lZkhSbVVGM080RFYr?=
 =?utf-8?B?bDVqZ01nYUUyVUJxWHozckRJbVQ1L0FGMWthaGwzQ28yYUZJMU5IYW1OakR2?=
 =?utf-8?B?VkhZY05Rd01CbDBJT3NZSVhYMm9XUTRaZ3IwRlBTckJ1MEl5WkwwQW9nV2pR?=
 =?utf-8?B?c1l6cUw4YkFzOGF1NFF4UWcxalRkVHFNbEV1bm1zdVYrOGkrZ2lDcnNvVUhn?=
 =?utf-8?B?dDI0ejljUGcyZ3p3NWFtQy8vNHJPZ2tQU0ZQbXQrVEhNSWdVUVltK2ZOLy82?=
 =?utf-8?B?RlVpamRteWVjZHVnV2RoUnBPeFZPN1dST2w1bTFGcmdwcnpvcUZEMW1nRVJJ?=
 =?utf-8?B?WnQveExVMWFrYUZydklJeVhyVVBCSHcxZWRvYUhZM3hvMzZtT3pwZmhlRk1C?=
 =?utf-8?B?VnBlT3lhekRCMVNwY2lia3RZL2xiVUh4Y1gxUXpTWHJNNVBlRjNLL2R5OGdm?=
 =?utf-8?B?Z1ZXckZ1VXh6Yk9hN3FQQjZsQnp3Zm1kTCsvdnBMbkNJa01XelRhY2dNMSt4?=
 =?utf-8?B?TWt4SHRMbk0rK0F5R0c1Wnc5SWFqUm5NMDdUQ3JmMnV1OVpCb2dJdDJUakFU?=
 =?utf-8?B?clFYanYwbDNoZ3pvRTArRW56b2J2RWtONnNuT1dPY0FWa0dPZHVlTHZZWnZI?=
 =?utf-8?B?cDVEd2FmbU5ORGM3NkRENnlia0NPRVRLckNLY3ZaUFVQUGFxWGtwUWFCYXVv?=
 =?utf-8?B?RnduZzcwTkpUbkt6YTYzOEZ5bklXQTBwYVI4eDliYTFNNVNnbHhzaEVmYkVx?=
 =?utf-8?B?ZnZwbGtaMGJiYnFrRTdrMUZzR3FZajNSbTNtTWd3TiszRlB4cUtpdU04d28z?=
 =?utf-8?B?c0ZERUdBcEJpSTVaUjcrdXAvMlY2RVNocnIyK0RYNnI5S2xWb3p1TGwzaU1W?=
 =?utf-8?B?dUZqQ3dSWUpXSHVzUjZLTStUZndCZHdYaFRMRWFweWYyYWhyQk9ic1pBeVMr?=
 =?utf-8?B?ZjlhZzh0VDZtcC9JcGhBZnorbVExaHlZU3dxVUhhdVpvNFlqZk5CaDIzLzBp?=
 =?utf-8?B?elJHOUVjQVhKU1k5R05jOHBSVjNFZkRyWnlQekNKNXJJU1JkcURqS3pXd0Zo?=
 =?utf-8?B?b3lrZWZVZ3FXbWlkLzgxNEtNa0hpUHJucUdsTGY3T2Z2OC9ZZ2diNG14UHZN?=
 =?utf-8?B?d1ZRNTBtSzRaaVJ0VjdjQVdiaGc0S210WGRsMnNDc2RTL3A5Q0Z1dWxtY0RH?=
 =?utf-8?B?eGdybGZ4Rm84YXlya3d1Z2ZvUlVPTG00NktCcllqVm9CeUhsV0xuMXo4Y1ky?=
 =?utf-8?B?Z1plT2J0OEtTdGYrUFliYjl4SlZ4QVlCL3hHQ2Frd2EyVi85ZG9xWjdNYSt6?=
 =?utf-8?B?Sncyc1gyZFRZeFpHK1orS1Z6SkRZaTZpOFBHMHBhWlNvY2paTnB0MlE2YlA4?=
 =?utf-8?B?cnZJOHQ0cDZJMHNpcjdYQ3NwMUZEcVk0Zzd3K3hTcEFJREoxaDZCb1p5L1hq?=
 =?utf-8?B?QWlzcjJ4eVhzRElDeGp4U2pKOXN4bENOWTZFenpVUzBBb0dZUkZtNU5MaGhT?=
 =?utf-8?B?a2JxdkZ6aVhWYVh1dzNZTm5FUUw1M2VoemlkTGFBQWc0UUJoZEtucXhUUUJC?=
 =?utf-8?B?dzNmZFBoRmJSSDNXUDRTeUJpVys1V3RuT01vUDJEbVBIeXlKVktMWlhQOGtW?=
 =?utf-8?B?b2J5eEV1MXpnZjRFSkJWQXl4SUdzQWNQVFhvdENFNkNjUkp0MmlXdE9CUDRI?=
 =?utf-8?Q?xoClh+qqKbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNOWGFyNjBZbTdXNU1jSzN5MTFaOFgwYnB0SThwSEZ2WkFCamx5M0VXL0Fn?=
 =?utf-8?B?WitEQjhkcW9UTml6aWFWblBsMkZVb2F6SEwxendkZGJEYnRyWFB4YXRKY3Fa?=
 =?utf-8?B?RGRNRGJYcVVqVDI1dTYxcEV1TWM4WGVzQ2d2VytKMEMzeXYrLzFHb0Fma2wr?=
 =?utf-8?B?RmtvTmxNSngyT3VEUy8zbUNMcC9NbUpzVVE2RzZxSXducG9aL01DOVR0Z1ps?=
 =?utf-8?B?aTUzOU85bERBWGgwaFk3Q09UT0pqSmZLRkNGdTVyK0svb0J5L1lSL0JaZFVS?=
 =?utf-8?B?RGN6dWxIbXpaUUVGWlV5NmFXYnNBQU1ERjZwK3RCS0ZIbUNweUcwcVhMSGps?=
 =?utf-8?B?VksyQ2QvbVdqQ1lERFVwZXMxd0o0cm1tVjkzN0pld3JUNGNkN3pweUs0a0VP?=
 =?utf-8?B?SGNLdndQbnlWUlRBNDJ4WmcrMlZlVzhOdGtyV2ZLVU1HNFd2b0x3V2Z6MlV2?=
 =?utf-8?B?VTROVm1LVU1TemxCQk1RcStyRlZCK0EzODltTEpMNEpzeHNjSmdlYTlwZmw3?=
 =?utf-8?B?RzdwdW93Y0c3N0Q0RXl2U0k2d3dEZ0JNMThuc1BkVjlva1hra0hQenBpV3Qw?=
 =?utf-8?B?bitNMm1VSjJlTytHeFFlK1crelloWGExR2RkWW9ZUlNtOG1CdkpVVTdRR1dl?=
 =?utf-8?B?WlM0cEdEYyt1NWJKV1Z6U1dtWWxGQ0RJbUoxeUd4VVdyQ2xyMlYyVWVUS0Zy?=
 =?utf-8?B?WXlET2poakttdnViQUtOVFR4R2FqS3FJSkliMG41OVFpNjZjT0c1Y0lMTHpY?=
 =?utf-8?B?aWVRZmxnU3YxREp4Q1V5a2NBVTRVYmJaZFFIL3QzR0cxUXFJaU9sZWtmQjNj?=
 =?utf-8?B?MGc4K2JVS0tOaGkyczNiWHlQRk1xWlRSRTViZ3U4UU9VbjJlN3VvMnhsL3dv?=
 =?utf-8?B?bThlVHJ3S0k5dXZmZ2ZXL2JxeEMwUHM1NTE1bG9VdzRWZmprUlcxMTZXR2FK?=
 =?utf-8?B?bFJtLzhZWFJ2MnZyTXhhdndZTEozbUdQZ0pjb05nNERGazR6TkFVMkIxVTkz?=
 =?utf-8?B?UGpldHFjVHI1NGtlQkFuV2ZwNm8ya1dRbFh6eXk3anRKdm5PeWFUSTIzb01l?=
 =?utf-8?B?TkdHYnI5eGlNQlZWalhBb01CZng4d1NTbnFOcHdRSHFIVkVZMjEzdVVsUHU1?=
 =?utf-8?B?R3ZES3o0YWxEOXVXSWNmallRTlhQRUxJWGpuTk1ScWhmN3dQVXI5SUUrbStY?=
 =?utf-8?B?ekw1VUlrUVA3eWV1YUwxNllab1BLcXBVWXBDL1ZRaXVMZUJ1U2RkUUIyTVMw?=
 =?utf-8?B?K3ZHbS9xNDRYN2k0SHNRa0s5emJXMWRHNCtqUGtNbzcveTNlSEkzNXBCanVj?=
 =?utf-8?B?OUxzeGlQRERQcHI0eFN6ajVMTHA0ZWR5YkIwZGdQc081S0U1aW9LOUx1dWYr?=
 =?utf-8?B?aTZCSG13aGtLZVc2dk1TTzN0ZlhuUTZOTnFNM3hOK2ZZSUxZQUNxempvL1ZS?=
 =?utf-8?B?NmtSVmxsYldNRkRjeWIxVE93dFpZN3IxSzFUM0VLcGJOWkQ3Y1BycU5KTmor?=
 =?utf-8?B?VVRFTnpBbkpvNXl6cXZJV09Nc2REWjdXL3Q3alJ1RGF6SUFhWHlJQy9ZL21p?=
 =?utf-8?B?WXhGRFV0a2x1c0JFVVBwNitOSG13R1dPREY4Qkg4UWpyZUdtbHJxaU5OeUJl?=
 =?utf-8?B?emdTdzQ3NFpNVjJucWVPMDZHMzMzZ09yNzdIcnZ4NVYvQmJVNjZPWGlXK2Zk?=
 =?utf-8?B?alhKUnlQNWM1eGEyZkJZY0tkUGJKWERTUXJnOGJyenUzYkg3WTJUQ3lNRUMx?=
 =?utf-8?B?RU85WjFNM0dEaE1jRVpnZ25OZDREYkpxN0M4NlhQSTczdjVFYTMvc1lrSUJJ?=
 =?utf-8?B?RlV2eDRqWndQKzFpTFF5RjdYSnVCZ0RSaG01L3hjOXRvajNVYjlyblgzeXFX?=
 =?utf-8?B?Wkx3bnpMaytFZ1p5aXlwNk9rU1dmNVYrSkhuakVxTm9kbnprLzdRaU9UcFdl?=
 =?utf-8?B?RzJrS3Z5UGtWZmNwemJsUlZKYXdoc2t5dCtSejBtTWRXVUI5K1hoaG5ZV2p2?=
 =?utf-8?B?OTVIL2lLL0JLdzMxOVNBaUdQRkx3ZnROMWNpanRCRkh4V2pITUZEK1BwVFBj?=
 =?utf-8?B?SS9hdWZxUk91RTh2ZGI0SjFoWXRCM3VFbmZ1T005YnNNcjJyN3oxSHR3M3Rh?=
 =?utf-8?B?RUlLdlZ5QnJuVHdFenNDRUtLbXBHV3N2dm9iek9OKzJPYjFUNXJzeW0xSlRk?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b42cd1c0-a7a2-4cbd-8fba-08dd8f085c41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 14:47:03.0733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOuIvdo2yc8ECeS3nhhrk90nOqDUk3OcZPplaHz3OV6ZFJzVDUw/BiXUKAyvKfbvz0XCp4MmVQOol0steif7xnpgzsTh0PwLSfZ+R/kOxco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
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

On 5/2/2025 5:25 PM, Pillai, Dhanya R wrote:
> Added log message for ddp package load failure.
> 

Judging by the code, the log message already existed, so technically 
it's not "adding" anything. IMO a better wording would be:

"Clarified log message for DDP package load failure".

> mailmap: update contributor entry

I don't think it's necessary to call this out.

With above changes (can be done on apply),

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
