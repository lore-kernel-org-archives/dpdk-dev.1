Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632BFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 16:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA6F7402B5;
	Tue, 28 Apr 2026 18:52:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 193194026E
 for <dev@dpdk.org>; Tue, 28 Apr 2026 18:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777395170; x=1808931170;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C+4nfvBxn+K55n1fiaZ2me/XQnPYD6BLE9jr4Phi5jo=;
 b=MBJDK7YjGh2MWUFIgVwCKVcokWdDWW+uC8ba7YML86NlpZeFJnjsFVIq
 0Qzft7ciJwUnLehrkfXSVhGJjJth64HjG0qGDhHW23/LVvVPYPk6lbKIK
 eYFpiy40J1gmy6T98q67cYRVFXDkfPhiR2JIgBjRgtxEEwAdz5ZbAjI9T
 jJbPimdHzWaBNzF7WyVrdSCCbAI0YUUCr7SYcgdbX0WVdIK+sE3n7mDNk
 LGbOUPRiun3ebVNLvbFft+GjiK0m9EsZ7S6I6wIXwY1lU+4zClNbRQB+B
 wHEQvk9Hk1GKm47mlJ9rXLy4VjH4I3eDC/hzmK/iLy9P64ekA333eenwi A==;
X-CSE-ConnectionGUID: HHLH/tlWSR+JlJwkW5QtTg==
X-CSE-MsgGUID: cfWy79EvRB2jNEtX4zi08A==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="81917225"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="81917225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:52:49 -0700
X-CSE-ConnectionGUID: OKQJ6B6eT6ibDKptag6AdA==
X-CSE-MsgGUID: 1QkW1tRbR3aM6lDBid1L4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="235764884"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:52:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 09:52:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 09:52:47 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 09:52:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmFhEWKCDgA4xYUlSwV+qNFKgFzHTZFo1LZo7Nl/LdkJeFzavaBXDOraMwykjTCRUfU6vEgu9S5ye1azFcFN6WMo44ZTFihdvfFs0Ag2MImnRjlP9c/5Iru5aSVRyJMe88QSO4eNL8CDhWf2/BS5xZR3HQmExsb04eNx36wzARJ5c+oFYr8CvGsw5B2leycyYG0b4dEgh0RZREjffwKaxFiZz3Lzh6Bt/MG62OC0rtXq84M+SHUhDeNbFtKgaXwQHa6yzO+0xTBNj0A2Anx4fXQHkMuhrvlr2F+6gd5uVMbwhBAYn/modgooZgn5JydAqyArSs0yBLuQj83O1/gGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiPD5hNWm5Gg9F4xWLQBDuSVEYUqep/c6PKZn/QMRUE=;
 b=YKbsXzm+wWH2KC9w/pBexFilvh1HofmTQ9hJAarSWnj0YfoXkTVy7NF47QqcFN8c+XHtIq4q6UAHk1zsHMNq4mFquyXCTBLrKpxFRnr4AG1870Th3FPmIlAE6Klc1kmReUJNFVBjN/lk1p7kQDu/A7IaEjYMiQS2x4DCxYDPaOD0qXEb6hXfS3+g6tiP9gyRHpomi94OXEII9AkUUsODm3lSX4SZDGO/H5c2PD2YI9s8YnTw+XOBdIprHR8N2sGUy1kDdVyjFJaVl4Qld3G1VqLKD4p/zyTlmmkmmldbwUvXFqyBJZcDcsHjumwQ3/AyLl11Nx0muAIpSzp9Xu8+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:52:41 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 16:52:41 +0000
Message-ID: <05d9e1ee-19e9-4431-b521-99d0b1881004@intel.com>
Date: Tue, 28 Apr 2026 22:22:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/4] introduce PTP protocol library and software relay
 example
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260427164230.6e015396@phoenix.local>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <20260427164230.6e015396@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::6) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|PH7PR11MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 8595098c-932b-4522-f24c-08dea5468f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: vcDnVIq84kyjnTaruAsWpQywVjY0mIQ29KFLT8Z3QrSJPljOTP4rf4Q/0LxcSX7A+Nu9RyNMTKY+vPx5uNljj6byWMFIrDI2zPnM+bYT5N76Um602sWLNTgvnQeWSmQCd+fAbEK1gOdC42spRMK2RMUwwGsTw+UwmZOtYEw424YMN2efHo/YPr3BPLfipcwesuI2v5A2rw+WnH3jFoph4a6Gue8AwdkUOr6I2B8JY/fqvWNnjiJlOtUdwdKmYiHlQjn84wATwkW4cBmpCWUYe1A47S+91R1Ot12AtPz2XB4i5EU7HhBv4VxFR0NK+IfVAlywM65lBEBOj7Szcm14E19MmhdxlZCPTylXG5uqqhkKsJxwNbPuVlYPcFDQI4bBPi2ZOO2rf/shvo5NED2NMOgQC805PuT/74rmWJYMK8jgpzbSC5o96pDhGf2GHrFAAUb0vr4iuLwixI9MZD5Zuou7FmgIGi/XJiEpHrEUPgUrkcxM9zUic0N1S5thXBOj1D2slRwN9SQgLlG6j9jfD/hMG/yHGsom/l+oqZc6HrKBBW000Dg/vmNdV8aKNVei+iqOy0jAp0CXMwgduKF69Z3Zw7w4jWzHHjkKZO5bJiPQGSdEfFLYN+ychD1dC9auhx+xy6GB1HPDRiVfe7g+WqOxYZb2r8yZhxFbQ8k0k4/hdGVT+96+AM/jHKh6j32kHWzkESziQzaDmoDR/Wl9aRIMPyOU8CQWKjNbGExQ8Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FIbzUyZnNPdmlMNjUxZUFvUWR0UFRxYkloeUFxbEwxUDRvRW1tckN3RzFU?=
 =?utf-8?B?U0tobjB6YWFVbzh5WEdEVUhROS9VU1IzZS9FUjk4TEtveTIxU0d3eU9Fd09n?=
 =?utf-8?B?S2ZQVEhHVmxWN1o0TlR3dVdLakZXU2RmdElCRW50S0pISEp6MWl1bGllZWJ3?=
 =?utf-8?B?WG8rY0d5Zys5aVdNTEQ3NlNOeURCUC84YnZ2V2g2VUpBUFllM0t5YlBuMERU?=
 =?utf-8?B?TXR6aHFDVjFLVkNrOXMvTGZJZjFpMXBXU1pIM1dyaE83NE9rRWFWVGVzSmMz?=
 =?utf-8?B?UHNWdGErVHVVVDRpK1NrRmE5TC9hcGJKcFNFYXdsSVFjUmg4N2syaWdQNSsz?=
 =?utf-8?B?SXY1QUw2WUpEMlNjNWFsUk8zUU1uNE82dFQ0bjMwTE11WFlnRXd1YjY0RzZC?=
 =?utf-8?B?ZW9ZclFiV1UzNHVWZ1VxU0ZkeSs5RFFheGZwdXE2cnczZFdINUJQSGhzVmll?=
 =?utf-8?B?bkpFKzc2ODlmYUtIdVVNbWFvV0M0blVNZ3diajFyZVFWQWl6SWRPNlI4SzNr?=
 =?utf-8?B?dThhKzVYL0dwTDhWNXFIWEdZSVhXbHhiUWpQQUh2VkR1STAvbms1WTF1WDVl?=
 =?utf-8?B?SDcwYTAzV29OaTcwQ2lEdldTVUkxNGU0R2FIZ3d2b1lwWUpQUHJDV2hIN2RO?=
 =?utf-8?B?OXZBZmVBVWM2KzRNcnVTWlFoT1VTK0NackozLzBId05JNFcxTGs1UEZMcEts?=
 =?utf-8?B?YzdxQTB2K2pOZWM0QkkzeUhXZnFYc2RyclVaT0o0SU94Q0hpZTlrRFNubkV3?=
 =?utf-8?B?M0tQVEVwb3gxNGY2Qk9QS2tTMDhDM3hBZWtFUDJwUXV1TXpmZTJYRWhRVEFj?=
 =?utf-8?B?b29ONThRSUFLTGFGQ2owR3d0eTN1c3lQNzJyK1FhM041MUUxVGlPTUc0MTBj?=
 =?utf-8?B?V0ZrLzVod2RhcExzR21uTDIwNi8vZFhiZi9JaHBkYnd5YnE1a1I1c0o5THpG?=
 =?utf-8?B?S2ZQdTZhWkF0aHI2azBUM01LUWgzQlRmMlJVOTc0aVAyVkU2aVEzam9LTlE5?=
 =?utf-8?B?VnlKTFRWQTREdllPRG5Gd3lyYUx0VkFJeHBWQ2NESzhtdzloMHM4eUdvU3Jh?=
 =?utf-8?B?dFJPaExMTzIrMmZwRWJQUm1CWTVkSXp4VlF3U21IVDlzaTN0elk0Z2I5eTJV?=
 =?utf-8?B?QTd4VStLNXJFQ0ZQbzE4SHExdHpna2xJY0dGc1FwaFNyRWgxeWMvUWhrcGNZ?=
 =?utf-8?B?eW9SVDJYNkg1Z0p1Q0tKNTlDUk5sNDRwbDJEL1d3NWhjeDc5b2JnTXd3b0hG?=
 =?utf-8?B?OU91NGg2U0lSR015alJHRmFndUh2UFQyWmlSNjMwWC83K0pncWRzOFE5T0ZF?=
 =?utf-8?B?aWlvN0xVdUl1R0FEMVBra1ZkMXU5ZDJRNmVGWTBJbVYxSnZkRHhXMkRVYTQx?=
 =?utf-8?B?ZzZXaFRjb2RrZkpYR3hTSXpHeWZid1kyVEphNUh1TEtHOFBHOGs1TytERk5N?=
 =?utf-8?B?eUdWYTZLalFhZ3JsMSswOTEvWmF5Z015MGt3ajZWRTFNVkZldVJYVFcvNlI1?=
 =?utf-8?B?MnBmWUVPYkpScHMvY2dwdlNUeUpKNU1NYkV2ZjJwUmtmYVZoY2ZtRUNJSjEx?=
 =?utf-8?B?Um5ucHA1VVlEaTZYSjZMRXMrYXR2UXdxY25oSlNHYmZUOEJUK1J4alJFWHVB?=
 =?utf-8?B?R0lCQk5seDFiRVVFa1J1Vm12aVl3Wk5qMGQyVWNTSU4wVDdBbDVCZ2d1bGtP?=
 =?utf-8?B?alhwWS91dU1ydUdqMWt2cDVYTndBZkpwbk5nTmx1Z3BDclJObUJhbDNIZHlo?=
 =?utf-8?B?SGIyVWFtUU8wTlAvRDYyeGpnU2RaY0g4SVFpYi9rS2ZPajEvbG9GN24xRmo1?=
 =?utf-8?B?eTVuc2VRQW10UUxWbGVlc3lIUXNETjZVdFptOXgxVitDampvcXhTOFptTFpS?=
 =?utf-8?B?UTFmdXA5YmhpS1d5M0c1QmdKOWNxenplQUhwYVVUbDc5RXFVNE8xWGVlQUNj?=
 =?utf-8?B?S1hLazQxNEorYWZoQjY5cjl4ZnRUWlBpejdOdlIvSm81R0ZvdVlBSjB6QmFu?=
 =?utf-8?B?YUJMd2xXeGV4MGd6ZkFFOTVhU0NwNVNaY1ZISytLRlZDSXMrc0lUT3Z2Vm1Z?=
 =?utf-8?B?TmhkZGQ4T1RlQXZGcU1LZWZiYjM0ZDB0V1pNVjBnempHaEdwMW9STnIvWTI5?=
 =?utf-8?B?U294SElOYVAxY0RvbFZiTU9Xc20xY0RESGJOL1g2ZzBvV3BtN0N4bS83SXpO?=
 =?utf-8?B?cVgxNWYxSmtpWWE2V2x4S3ArQUNMUFF3NFg5Wk1INGNyU2pMaGJQVDBtbWMv?=
 =?utf-8?B?eU9KeStwMElzY3FZNEEvVGE2NzRrUjdaYTlrWTBDZkVxT05hNUtWbythRnkz?=
 =?utf-8?B?ZUlEM3E3Q08yUlkwZ212em9vYUNmS0JoMWIvc0w2WjgzS21VR0xENzFPc09R?=
 =?utf-8?Q?8PscJZbA57YdxzbQ=3D?=
X-Exchange-RoutingPolicyChecked: kqGsIKkX6xDU9MB2L1CrNdHjMfpWatMVsnZICGoHOiftViALq9+tyIM6dIBr0xMfNJvZG9Hkw6ismwgm+xHDP5UZdjyt+QDF4tI3HLTP5qy8X7ppGqnvcEb4+DqBkp3Yt2vclN3+4Uv+l+U8lwvSvqN6jP4FC0G5sjprKNEv+cjIxeKVQFWYW//2JxVbEe+6HEm3XonmzmyYqAi5R9F2Uz3/AtgLSV7IHzNQbnDN+kBM1C4GKiO2+kSqqCc/rf2Ez5RQJX9kOU+GTkVmMUMnZCshXEHTYGXFPyxNp3cJ+u2lph71nzF8LO01CvJ8JUSZYGRdceNv95tvkbBLmIYG6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8595098c-932b-4522-f24c-08dea5468f80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:52:41.2695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggWC/2W09t/tfjqN6Bgs6O/OvWkKxD6NepQ3/jlAzv9Cjky2h7W8iItIht6VnCLdvgtvgdFVd13NAooYTFZwsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
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


On 28-04-2026 05:12 am, Stephen Hemminger wrote:
>   things I noticed were:
> Do not use older PTP terminology master/slave; we fixed this in DPDK.
> This would cause a NAK for me, and checkpatch would flag it
Fixed.
