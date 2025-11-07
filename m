Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF44CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 760C040673;
	Fri,  7 Nov 2025 17:14:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 901C740663
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762532066; x=1794068066;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=aoUZsyFhfjPT2aBdv/IOFLsAXP1pNIJ/XzmiArg10GI=;
 b=ex50XqWevgGFWCd7UTBlhNyQTawJM7rDnulc7HK8cmOGdhzhf5IdjP13
 VNhCDHWLLXWwmw/OK8VeEDGHrvXBfQOtviKNENM+9O0Ydaq6Y2Grryldx
 6p2XlAebr87TBZdPCFYQhAWZAJYV+9tsZily/lavHtQxnioBOAM/cEzLu
 5iasZeK8vVH70U4guXVQtP3YucGLJA0efv3E8Omq5wkxjJc5KFv6UCs2L
 h3tmSXn0CXLK0KcPkAVKzVQIHFY9P7gcVdVylbrLYg29Pv9Cqp1JQTUiP
 s1XLzam5xqp9ac+JuEQyP5NvITS1N38o3lyStGbDuGz5gjoZD/o2ronHd w==;
X-CSE-ConnectionGUID: 3Qft4Vo8TO+oRGKnCCpLFw==
X-CSE-MsgGUID: vWWpewBTRCeYDsBBXEBdIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="63695850"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="63695850"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:14:25 -0800
X-CSE-ConnectionGUID: eX3J6wUESN2xNnQjRS30Vw==
X-CSE-MsgGUID: KEMNFghTTxK8CawHglDJxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187911838"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:14:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 08:14:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 08:14:25 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 08:14:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5x0sdVY4/0pHaVDBXFmHIy3fn9LowLRABKKSm5/qKW5kZjx/DogVuz45UrYEUtuy4C8ixCyOT5DmnfLJvvInGeHyT6wTyGLwf0Lzvc2ENoy9EIRMr4uY5UEI5vfJA/+HPwuESL3yyaMj8lmj+hrbsl1vK+tyPiG3qha0RoZQghsb7uH4/9lb6BkzqEL3at0w1v51F8Y4l3Mf0q4qG/rcPEeKGuEpvQUTcvaoTc/vIOMca0OZAn8g5teZculccoIEmW9vEey61gL4uCVEI2UvIgtyZEFatsG96DfnVpL+Zy9yWd92uGebuKvzC3HBJgcvyMhvOPOQva2kA6bQwTBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpJgvIKExjL3DtRkV//DDXnwbD1fzErcTyYHeiRBqFI=;
 b=ipE1cRSObZV8+2jFzKR4hiNpyJnrbuXhePMq/3pSVoduR3UO0IYkSuXmvavzR9OGOu+AMGe6A6BvPr8mFhAxot65PYPhhb36r46m+6UCZLVU9QPlx7GWoxLfLPwsQa+gu36PHht0YGkipYaIJ+8M3hu71UednwpVIuR1+hhN3SzTDuMdvMkLVv/jIC2gSpsryy3Qw/7PfmjgNmxYtMHHOppUp/+IKa+L2x4ru1doQsRVKNrNWhMEMA6TObSbslHVVdta87/5PL2jsKytT8Cqnr6/wynmXqkUTRskGXSNCEUV/h5+jHFIcNpxJOedjZ2hC/JTdndtd8GVW+hTMGlnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:14:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 16:14:23 +0000
Message-ID: <aa8f56a4-010c-4ef2-9d97-5e61dc892173@intel.com>
Date: Fri, 7 Nov 2025 17:14:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] app/pdump: improve cmdline argument handling
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251017110638.1094371-1-bruce.richardson@intel.com>
 <20251017110638.1094371-2-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251017110638.1094371-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: d920a267-e214-44bc-0d21-08de1e18b6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azBNVEd6RVhYdVNFZS9rci8vS2dSa0w0d1FwWGF3a1RIc0w0RUZOdXBuMFAy?=
 =?utf-8?B?eWI5MG53bThLNlpjNWFWaHpPVmkyTEZrZEhtTm5DZWRsTXlJQis1Q1A1QUsv?=
 =?utf-8?B?VTRQeitmeDAvZzRJaGxIV0poT3ZMcFNNd2JMaHU5Y0lwbHc3ODBKRUJzSGFq?=
 =?utf-8?B?dnd5MWl1MjduWlBwSXVtY21DejdxWWRiNEtEYUVNblZRc2xQS3M3RlJWN0VZ?=
 =?utf-8?B?b2k1SXZYcFhYV01Eb3hQRzhjUjhBWU4rRHJnRmZVT00yVHdCdHh4VVBDQUJT?=
 =?utf-8?B?MDhEQUlQOWoybFp6QnVwbktmak1Td2tTZ3hYeENkWEJvY0pBZGkzMXdSYTlT?=
 =?utf-8?B?ZzdmQS9NZ1dxYzR4enpkamdERE5ramdlbk1OSWJlVnNNUXB1Y0VNc1FUc2RN?=
 =?utf-8?B?ZzdDanphb3Y2NEFUd0xJV09GMTRqNXI3U3J5aTArdmlBWnYzQjFlUlk1cU1G?=
 =?utf-8?B?RDRHb2lsamVmZGtmWTAvVXZqNDdIRjRWUW9vR3dtK0FoQWhXUW5IM2dTRTYx?=
 =?utf-8?B?a3d6Q2hXelNIL3ZzVXJlVzdseXpMd093eUFtaElkVmZqOFNGY0x3UWVtM1cx?=
 =?utf-8?B?eWJRRXBBVEFDR2p0d1ZUeEYweWQ2TFpIcG5uVXhqVmRPQ2Q4cnE1NFNuakwx?=
 =?utf-8?B?dGRDRlgwK1h1S0ZKVjRLU3NmZTNrTm50N3NacjhsV3J2Y203WVEra2RMdE1H?=
 =?utf-8?B?T1VvZkJPbk9YamxKemgwZGJITTNLVHhSVDJDVk0rQ01GSHc5aThLbFg1TlBG?=
 =?utf-8?B?dGFsVVMweWE3ZG4vSEdZM1BOdnd4WStyUXFLbEF0ajhjVXhRTDZ5T2txZE9O?=
 =?utf-8?B?bk9oRXJvQURPUXZBRFJ5NGhnUklhUkt0dlIzMTRjRXNXTG9PeENqMk9kYUhW?=
 =?utf-8?B?aGNzMjFBd2Z2aVVxRVp4ZlpsbjEwMWNlNWpYWFMrYVFSdnc3bFJJUFczbC9Z?=
 =?utf-8?B?R1pGWUpVYmFoTDZseStLMEFUZkJqbzU1OEpLb1l0Rm1VUEYvalJnVkZORm5Q?=
 =?utf-8?B?L09zTG84OVJIRWQ3aks3YXo1aUNYQ3lONVVnaGZTOFladkpkNDFUTnZkMzVp?=
 =?utf-8?B?WVBlZGpJTWRKemE3ai94Y0VoWjduUFNUUDFYakpCK2JkN21oK0p3RmF4SFNa?=
 =?utf-8?B?YVNIRXh0WkJFdFFocVBia3ZWNDF6akxYMFJzT1htdkUxUHFOZFhkWkFFVVVi?=
 =?utf-8?B?UGxlY0pQbm5qMzZoOXN0aEtSMjZTakVjallrSnBMbUlQMGZnYzh2T1EwUkFy?=
 =?utf-8?B?Vmk3WXo5VE9hMEFKcDRIc2ozelQzbHl4b3BtVWFuNnlqSE1GUXRJaVZyOXhJ?=
 =?utf-8?B?c0p0dzlpWHFvVVBaS0dBbGthaUpWU2RTZjV2bVk2QUcxelFsLzdqZUwvVDFB?=
 =?utf-8?B?REZrUm5OdXhRZkU5Z3VlbDErclRjVWRBUzg0bktqeXduMVV6Z05tVWFGSkQ3?=
 =?utf-8?B?cTJHaWU3aXJQSHB3Njh0Q2JVdWoxdWlWdkZpbmNJM04xcEJ5WE9rYjNGUzda?=
 =?utf-8?B?QUo2UWY2VTNOT2w0OHpVV3dBajRrNHp1NVFDUlcwcjlrZFQ5RFRwWXJvZzQ5?=
 =?utf-8?B?ek0rakhMdHFrRkVhN00xc2hab3pHS0N3YURsL2toOEZtTERYVmZLRHZtTWdK?=
 =?utf-8?B?a3NRQ3F3eXU4MFYxeStmOEdrdC9BSThyNTFsNzlkWVRmNlhUbHZBTVEyZG5k?=
 =?utf-8?B?Tk5QZndDbGU3ZVpKbG5ydkJ0dFZxQVhhTXBUNzB6dWhrWVJ3VVB4MFZ6Y0J0?=
 =?utf-8?B?bDNrNnFwSitzU0FSN3YvK1BuV2NNRmV5UTRCczJoRlRpUHNBaU8wZEcyR2g0?=
 =?utf-8?B?cUU1b0J2dC81dWlFa0hvWm05dlBxanU1d0U5RmphcVJLUDUwLzhTbzJ0c21z?=
 =?utf-8?B?VFZmVjhvVXVyMkt0VUViMnprcUJneUF4SlNoYW8zandXNEpPR0lsWDlUUFA5?=
 =?utf-8?Q?ZKl3tyGjCkZ2laROS1l1owYpOSE4CWGz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hoOURwTXZkcWJGNU5VdkM1NjZQeUVkTXhPMVJGc0ZuVUhVNlBpU1phTHBm?=
 =?utf-8?B?L0twVjRBbkZmNmZ4bzJKOU5uRE9SeWVrQ0gvcDV2dThrSkovTnBTOEhsQk4x?=
 =?utf-8?B?RnZDNEJPY3pVSkRhTXRLMjh5VjgrRGF5WFl4eWZQWHZ0ZXhJeWIwczZVZC9M?=
 =?utf-8?B?bTlYbHpoakgvMFFOczc1R24wWWpRS3ZiYmFkejMvL21XR21Cck53N0xBYmlk?=
 =?utf-8?B?SERTeUtnWUUxVXRPQzdxYjZkbSttRDNzMENvT1dQMTh4bUFsUUlBdFErL1dY?=
 =?utf-8?B?cWRjSThtU29mcGNkcUtEelRrNVIrK2dNZnNnL0VNSFo5dkN0STlmQTZZNm9z?=
 =?utf-8?B?UDlmWFB4QnlueHRJcTFjWkNRWUtrQmM2VSs3Sm9wSlIwWk5yM2t3TzNvT0ZL?=
 =?utf-8?B?Vnl0SStxeDdBMlBhZzBLR2RpVFNRZUtSdFZjZ2xTMW44c3BLRWNZREVhaXhY?=
 =?utf-8?B?ZDB0WjRiQklEcVN5aUpaTVBjUmNQZ0I2Y0pIL2s2dXNFUW1manpRNVdhbStG?=
 =?utf-8?B?UzYwZFpHMEt5c3dFS21Kb0hvd3RtSFpNUFVybDhHL2hxMGVPRHlOUzdmMmcw?=
 =?utf-8?B?dWJJei9Vb2RUNEVBZDRFbTBhQ1oyWU1TMkRaOTNSRk1vSnZXNHRBVWxmR1F1?=
 =?utf-8?B?UERxdlA4Z1FNdFNaZWZyYXR2OWpZdmRHQ2pJZktFT0hJL2lrdDlZMThyVVc0?=
 =?utf-8?B?VksxcXkrMytlV041Q1BpSkZ6aEdLaVBCdHAxbm1NcDJlUE10d1NrSUZqa3Zm?=
 =?utf-8?B?Ly9SRnAyc0xyeVlMRUszcE15enQyYVpkYXVTQU9Udm1CZk1ybUtpVzJMTWs0?=
 =?utf-8?B?aHdvek9JZmc4UDVBQkszdTdEZUFxdWFmV3dpUXpkNFh1WXkvZlNEUi9VSHd6?=
 =?utf-8?B?WVJWWHN2bkw3eFNuRk95Q1ZmaFYrVklkaXVjRzlGU2RnV3l3Mno0MGx0Mkt2?=
 =?utf-8?B?YXBGbDhCVTZiS1lMYXZ0WHZzQXB1dVlnbzhRVkg3d2xZT0MyYzlFdmt1bFdm?=
 =?utf-8?B?MC9IUnlRaDhWTGtDQkRzSWNUYUxldEErU2EzRWw3dXJLWHliS1R6dkNWalhM?=
 =?utf-8?B?anhWeGxZUGhZYnRwSm9MMmZXL05OZW5JOU9VS010VGhsUWswY3F0Z2I4eE9s?=
 =?utf-8?B?bElwU01oNVZXcVBvZEFWMURLK1dUaGVTOTdZbWc3SGFCYWM4ai92WDdZU0dC?=
 =?utf-8?B?SlFQWGR3RndOYy92ZWlUYVlZTmxjT1pnck9POXp6aHIzR1BBdmZ4dTlIYys5?=
 =?utf-8?B?ZDVvU1dFSnhlS0NZRWF0dmlHWFJzSURZL1hWZ05oeXBuY09yYWJXNVRyVVdC?=
 =?utf-8?B?RnhlQi9YMWkrQkFQQWlaUTkvbTNZNCtJTzR5cmlZVUM5TDFEbHlaYmZOY3NJ?=
 =?utf-8?B?bDY2Z1ordTJnNTBWR1M0aCtQaFlUNDRzdThSV3p0dGg1OUxJSXc1dURlT3VV?=
 =?utf-8?B?dEFERklvZUNTeTlTczE2Z0hPT2d1bUEySzQycnBlb0R4Kzg0T1RVTUZaaGV3?=
 =?utf-8?B?R3ZjazJaNXFyeGRJY05TYzJxMmZ3bVRid3RIaUhudXNxNUZ1S0Y4bHRLZEhI?=
 =?utf-8?B?N1YzQVFGNEFlcDMzdlo1VW9naDAybVZLb0dBcjUvRXdaZkZXcWRtZmhrUlBD?=
 =?utf-8?B?WWdTeG1RWmFRRHRjTVZETU1meS8zNm9ZUHNXYURpZlcyWnU5NFJaVVZLeDJZ?=
 =?utf-8?B?emxncjE4U1ZwcXNrZEd2eEIrbzNrWlBJS2R3enhENGxkNHZHZ0VjNW5tdEVV?=
 =?utf-8?B?Nk9hcXdFSjVlMERXK2pZUmdVUGx6M2JQU0ZIUVp4eWZjUG9PZEV0c0kwbVp0?=
 =?utf-8?B?bi9nT3FrWk0vaEhZYXlsTTFPVE9TZ3FuZ1QwY2svNEplazIxakpHcEZ2ZXQv?=
 =?utf-8?B?Q1luQldYbXRMTndTK0Y4L3NBNzZRWlpCaWorWUtuenI0Sm11WjhPZWhpYk9K?=
 =?utf-8?B?TXJ2aGlSWm1Yb2FVSnNQQlVxMUVaaWNUd2ordVNhV2M1d1BoR3VieUNGM0Vk?=
 =?utf-8?B?WlQ4TkhoSkZvS0FGSFdQWnZWbHgzcUVEVDNXMldlSkVCVm9yZStzdG9pd2J4?=
 =?utf-8?B?YjZEL3J3NG9rZEg4MmJxRDVkbjE0QktlWVBCN0pNMDYvTllVN1hubHIzZVBy?=
 =?utf-8?B?eGxSVFFhUEF5Z21iYlF4ZUk3MVJrNHVFYmZtQjJnTFlnYVUwZ2oxTGJVSTk5?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d920a267-e214-44bc-0d21-08de1e18b6d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:14:23.0228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X85Tfg8LRmLWn4iAMLdcoeL8uT9Ol7/6lukjfSdHSLUVqe6lpyWepl9iRK01zovkMWlE51CJeCcg1HRp3Rqpr4QXX+FAGbPV/9b+nNcAlx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
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

On 10/17/2025 1:06 PM, Bruce Richardson wrote:
> Rework the argc/argv handling in pdump a little to improve things.
> Issues with the original implementation:
> * assumed user would never pass proc-type parameter on the commandline
> * did not null-terminate the argv array (generally harmless but not in
>    spec)
> * did not handle case where arg processing in eal_init would reorder
>    non-flag args to the end to be handled by the app.
> 
> Fix these - all-be-it minor issues, by having a separate count value for
> the number of arguments we put in the argp array, rather than assuming
> that its argc + 1 (for proc-type flag). Properly set the last argv entry
> to NULL, and when processing app args, reuse the argp array passed to
> eal_init rather than reverting back to the original argv array.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

<snip>

>   
> -	argp[0] = argv[0];
> -	argp[1] = mp_flag;
> +	argp[n_argp++] = argv[0];
> +	argp[n_argp++] = mp_flag;
>   
> -	for (i = 1; i < argc; i++)
> -		argp[i + 1] = argv[i];
> -
> -	argc += 1;
> +	for (i = 1; i < argc; i++) {
> +		argp[n_argp] = argv[i];
> +		/* drop any user-provided proc-type to avoid dup flags */
> +		if (strncmp(argv[i], mp_flag, strlen("--proc-type")) != 0)
> +			n_argp++;

Feels a little odd to assign the value and then overwrite it in next 
iteration, but same end result so no biggie

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>


-- 
Thanks,
Anatoly
