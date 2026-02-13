Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E4EDF151
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50E014042E;
	Fri, 13 Feb 2026 11:44:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 1F62140287
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770979485; x=1802515485;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=L0Prl7nBAfPf3Z8EGyGzpm4L6jETL5xxhfM67GBqPmE=;
 b=kBi88J+f6G2WuxTvCwlSm4d5rqpGvy+o+jpQaBcpRv+6chDoUsgv7Qo8
 er/qEK7hfUH3NklF3tM9lNnciViGnQ8dmTzj2FRkC/K8ZlH85uMelQHMk
 qDgDWTUug+UczGXuB10sjLrkSVLHSCQfYo68k6H57in6WmYonVZBEqcD0
 /R9RV23V/Ijdc3R7y5UjWDLchZqiCUjaPaVSLcYgWJ2gS8KGkcIKD7grl
 9qMyIE56TSbhk1vDpnjCDn8CHGPXJbbtQuBMdZYjAliFMMasf2oW+5CiN
 w8mfg7WjEKC/z+uw7TR2uue6d75kylQEaVRpN+EV0Am3729M9LlOs4r0Z Q==;
X-CSE-ConnectionGUID: EK5o3MmySUGS+wdpdfEsKA==
X-CSE-MsgGUID: oClq4TJSRKKVgaLB5iI38g==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="97620499"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="97620499"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:44:44 -0800
X-CSE-ConnectionGUID: pm2pKc1MSTqo+k4JZaUGZg==
X-CSE-MsgGUID: 0OB0kVFzT3K/6IDCbpjuQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="212726679"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:44:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:44:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 02:44:43 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:44:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxiz7rdGGw9QqlOLvqPkwBVq7WjSurKOpJ7qctI4DMNradA+o6n3CiX6usSP2fH5e9GVdbtq+OTGPN7f38QccBSmzmMVsSmsyGiWG9tRkKrqvJUW4yyrLom9hfvJ8t4CDL3ywpCghREelXIv7lhzvKEAd2njUU5c9yfxsATVSUJSteqpmtW3Y24QELseBjuXDfp9Rxj/gxOZwX7LwqWR05bzSYveIyl6XBMWQXi/f+K1H9H+0f38t2HJGsXee3d4MU4d3hZCWi/yXx8WAYq9LQ37hOqyTIwrH6ZsUp797ze6Bw2THNXjjo0e2+69Qe0xTuJMphjiGLsggQr+Vb7ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnAuwO40otTqggOOkxvD00ogG5/7VxQ+rY39OwganPM=;
 b=SnRhrV7+mB2jCm09FnNXs++yqAJ5vol2BmjvxykVE9+iEJ4L2xW9bTolAha+JeBTIAidjGz7dtvSxWlhqN7n7ExLFPvFokxb2pvSxtLP/X4W9UyDkAt2fgXqldTpq1QCdOCZWAp72mQZo+fhB/TgKTWJDIxxwN3OkZNQm8eaVT2K0AEc+te9tB5tEO8Tf6vUNO9z7XQA8pV5zICgnv+p7OPICnSx1GXu+VFs4pE0nrOkKpLixNXphYXw1dtY7Q3l8rVV5N45eIL3swL8iyQFjlk/XFN9/QAUW9flTReFCiYvQiuZXxlIHsyKNt64Lp1xk/gFs3feliJyU88+hDQKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Fri, 13 Feb 2026 10:44:35 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:44:35 +0000
Message-ID: <9f5bad1f-60bf-44ec-a1c4-972af065d496@intel.com>
Date: Fri, 13 Feb 2026 11:44:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
In-Reply-To: <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0035.eurprd06.prod.outlook.com (2603:10a6:8:1::48)
 To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5cecfa-16d6-4b76-840b-08de6aece0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjUvRmovVkdvVkpXbmdCV2Fjck9CWTRIZ3ZFSWRYV2hXY1lER3hHZDgzMHB1?=
 =?utf-8?B?VDZIMDZGSkdXZTFUeUlSbWlOaG43U3VWamRpSUF2eTh2VUJSUHM5L3dvWWZK?=
 =?utf-8?B?dkpNSWpLTjVwUFNWbzcxS1A4STJuSjhMeERid09xRUhvL3pTMmxHM1FtdDM5?=
 =?utf-8?B?VVhpTjkwdlJBUkJVQVJGRUlkaWFEejZ5TEJWblJHOTJrdEJRekcrV0FiY3Zh?=
 =?utf-8?B?cVFScGNNR3h6R0JFMmtCYnE0OFlSUDUyVDVWZ2h0Z1JZU0VpMTVYZ1pzVHBR?=
 =?utf-8?B?eGY4WXk4MkpRcGYvY2xoMmw5R2xIYmRPVjBqY2szemtwYUtzTnJpS3FScDgx?=
 =?utf-8?B?amFKMFQ5aFJ1dmxZTVRzeksxaW15T2pwUEdVZzBBSFVXQ3NQcjY3Zy9YdjBP?=
 =?utf-8?B?K29wSy9XWW1qUndOYXlGeHV0Nmw4OU1HaUhnSjBDMjBxOW12bG0yRElXcm84?=
 =?utf-8?B?S3BmUXpZSXlMK0pQUFNhaXNGMVpWK3k3K1lCelcrUlFqRlVESURobTJFc0FO?=
 =?utf-8?B?SWhVdTRkSDhvMVp3b0NkUHZUT0x5UWtNVzhUREE1bEticWZTWnY1VnZjM2RF?=
 =?utf-8?B?Mk5Md0tHTDYwZ244UTFkSmYzYTFZb1VvTkRHRFpSR0ZqaWZKYXlwMlJ2WTlL?=
 =?utf-8?B?cFRVUnJMU0pqZVNFRTRrOXJOQ05LWUJmbEpPNEpaSG9SQVd4dnAwWVVvZ3Q3?=
 =?utf-8?B?NUl5N1pCdTRKZzVYUDkwZ29SdGVhOHJlQlM3aVF0d2owc2hZcDdPaTByd0FR?=
 =?utf-8?B?dDBzT3VBcXVRekxCejY3eHhoakRWQ3kyaW52Y2ZaaXpGYzJxOWJjeFhab0pW?=
 =?utf-8?B?bEtRWW5LbGEzYkhJRlFxc1U3NUZVeGlIV0Z0MTNFWk85TExoRnRsNFdyYVI1?=
 =?utf-8?B?WEwzejIyNW5ld2FkVW1XcHFUd0c0Qm9OVC9pZDN1cEVDdUpDRnZDNVJqNmVQ?=
 =?utf-8?B?YUVwWDFwVlZ2WnUvbGowSlhLeHhySjlnbkh4ZmdoWlF1WkdzZ1EzeThWaW5j?=
 =?utf-8?B?dUhwKzc0b1E1WWRTZDFDd3lxSkZPRVJZTzdncjVjdFU2OGRCQUNRaDJtaUp0?=
 =?utf-8?B?VTVYWE15QjNweEdNM0pKeWhwbGRmWU9YclZ5RnAveTRMK0RSeXZZeVAvejdh?=
 =?utf-8?B?UkI2ZjFSckcvTmluUUNuajU5WndwR1ltOHdhSmRpRWV0cnh2Zkk3VWNhWEdR?=
 =?utf-8?B?SVZPUVFWam4vajVLZklwRmJWQlA4VDM0c0dQa0IzcjNCcE5EYlcrR0kzQ2F1?=
 =?utf-8?B?dmRxSGJMSlNBK2U1T2JCaGp1ZTJlZ3psdHpVUXQveDB4YTh1Y3M3eW5zaVV2?=
 =?utf-8?B?czB5SDNBWGczWUVmZ1ZJbmo0UlBYcTBpVjYxZTF5TE9za21xdWZNWE5iOWF4?=
 =?utf-8?B?TFErSzB3c3ArRjV2dGtQNUlNcTFaUXV0bGg3WWFZbnQ0VGtHVE14V0w1TXZi?=
 =?utf-8?B?TlpxanNwYkJXTWJhSDBLcWQ3YkRrOGRPaFpPaVdxaDE0OExDSFZoUjNXaG5s?=
 =?utf-8?B?VTRpWVBLSGxTdHRkVFI3aFRtYVJKWXptRjFnYjdONlFWU0srKzRBbVJWbllY?=
 =?utf-8?B?bklrTGVHbVZTUW4ydXEvaExZUnpHTWg4V21idFZvVytpTUI2UkI2UHhwUGxB?=
 =?utf-8?B?cXQ3TlVKWXJ5aXFKeFNRSXB5RXBjclE0T0RLaDRlNHJVQUlvRVhER1ludi80?=
 =?utf-8?B?cHkxTUlqc0FKS0UvUnBWMEVFWW9aaS9BWEtickJKMXFuR1BidEZoSEg5UVQy?=
 =?utf-8?B?UHhaTW9nMm51Uk9aOHRjclR2YW9zRS9rUTB4bG5QcTJYQjJPMDgvRXJLVUQw?=
 =?utf-8?B?S2JrWEFxVDNjaU92bHFpVE1rcVBDOFVPdmF2QVRlNG1VVXI3cjE4SFUzSnpx?=
 =?utf-8?B?N3NCYVpWS3JGN0IrdWFyVDVjVHo2bVZuR3Y1U2ZJNWtuQWt1TWtienphZ2d6?=
 =?utf-8?B?NUdFRUFlSjBreWZQZnZnVmltRGRWT0VJVTJkS0NiU2NCR3NBeG9DRVBtNC9J?=
 =?utf-8?B?ZThzY0tMcFhXUUhuTlVwakp5UEtPdnBlVE9xZzM2bTExVlBqZSs4SGtkcmF1?=
 =?utf-8?B?RmhwUExFeXRIOW9NT3dtSXJOQndvTW4rNk40NkpEbWNqV05jNTRqVTgrTkQx?=
 =?utf-8?Q?Q2PA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZFWnFSMjFkOXFCRjk1SGVrREtIUVAvdy9ndlZOZ2doT094Z3dGejhxUnFk?=
 =?utf-8?B?SlllTmpGYnV5TVdDd1JCRkFKSVJtWjVYUWgzWWlreS9RUFRST1ZMTXpna0pq?=
 =?utf-8?B?RFZBa1lFNkdpRzhja0x3OUlRaTdLTmsraXI2L1d1R05Zakl3TWFWVlBjSTFO?=
 =?utf-8?B?OWU3ZzJ4SFpWTEw1VDc0YXE4NnZOUDRJdjlQdzkzeVVIaEZieWsvQXlxQzlV?=
 =?utf-8?B?QngzSkJNS3lacE52WTVlQ20wYlJwWCtQeFExUkthL3RYbnM2Yk5BbDlNYlRK?=
 =?utf-8?B?Tmx6T0xNbjZSTFUyYk5qRHpnTXhuS212MEhTZ3ZmWnNUTUxGU29nMVlxNzNS?=
 =?utf-8?B?ekk5RnVpVE5MZ3Y3ZEluMFNmM1NOem1aOXAxOWNGREFxcmhHalRtRHI5TVI1?=
 =?utf-8?B?T1IxSERia1BHRVpFckVDem5CS082aFlzYVdWNlFNUWk0Wi9GQTMwQkc1YU9o?=
 =?utf-8?B?d1U4SkJGK1NoeS84Q3YwTDV0MmpmU1lqTXZWSGN6R1ZtTEZOSEZuNHdzOUlZ?=
 =?utf-8?B?ZTI2MnlpV1VMczNRZGlpMVRkb1RKOVBFYVZOaGZ5ZGZ5Rklsem9UWlFabXFK?=
 =?utf-8?B?c3JWQ1JFK2pqMU1NaUV6STY1SFhNb2o1Rk9CR1VuWTA4bThZYkN5b1d2SDNa?=
 =?utf-8?B?bjJ2bFpSOHZiVERjaEVrVnVBR1NyYTA3UnM5ZEVGR29IR3NlMGl0UDJSZjBU?=
 =?utf-8?B?V2hjckMrNGpUYy9MWGozMVR2VHkzWEM4bWVrYktoQXhiSFNrampMUHliVU9Z?=
 =?utf-8?B?aldEakdaRzV4RTM5MGFyQ29YNTB0RnBxRjQvUjZrWEt2aG1yWGlRTTdVWkp3?=
 =?utf-8?B?a2ltS2xKNlVtMVNkd2NzZGEvSFovN1BFT1IycC9odEpySUJGWjR2SjBKQ3Yv?=
 =?utf-8?B?a3JJam95bnBUSjVNMWMxWFN2dnp3VjA5S3h0ZHZoZGxkMzVjYmxBaG1wdjdO?=
 =?utf-8?B?QUJCZnlmUjBWTEVzaHBZSmhrd0RlMjVGVk55dWtQV2VlYkpKSXlzWjliNTZD?=
 =?utf-8?B?NVBVV2gzZ08vMElqajh0RHdhUm8xNlVkV3ptVEV3YmduM2NudXhuMUF4RnJn?=
 =?utf-8?B?TTgvTkRIU1U3TGJJR3FKWkJucytkcFhGZXhhbjFzOXd0VFRPZE1OWURVdjRz?=
 =?utf-8?B?b2FLaDFURFMzckZ3cGdkODBxTW9KV2Nic0dtWGhFRlprVzNnb09XNEhJc2VP?=
 =?utf-8?B?anBSVk9GbnNZRHlXUEtsSmpqbEtFNlBwY3FPbjNWcGM0YURpZy9BckpYT2tN?=
 =?utf-8?B?dzRWMFhiM1JNYTNJcDM4dUxTR2hEMnQ3b09hZkZTN3BuMm5ldTdKT1MvdSt0?=
 =?utf-8?B?Tk9oVm0yVlQxS2N3akw0WjhuUTBaOGM5NVBNTVlnUVV6MWhQWGEyUUVZUkdv?=
 =?utf-8?B?YytzY0N2U01RUTRGWHJtVU1YZW5QVHBKSjBLSzg5V3pNdUk1OW1SbldsbWx2?=
 =?utf-8?B?d29hT3lzMjFNRFVJWjhxak1SQ1NnU01QdzFQUEpVR1hTaUYrV256bG1OTWZF?=
 =?utf-8?B?QzlxTUtSOHNobDZhT3lLaVVUQWUzRjJPYXRlSjFkZzA5eDdYdGMyV1RjRFFL?=
 =?utf-8?B?ZTViTHpiVVFvNWNNT0pXZ3k0Ykk2RmlHWUE3WWxoQ255cjRYT0kwTnJ6Rm82?=
 =?utf-8?B?c0x3bzlmdnE3Mkc5Q3lFczMrVGVMZmE1N2o0MTJicUlCQmtteG1QUGtFaXcw?=
 =?utf-8?B?c0R6TDk1U2tDZys4K3RxSSt2SGRYZzY4S1hCZ2NreFBSQ0RDL05rU2pROGQv?=
 =?utf-8?B?eHR5UG9oU1N0K0xRZkpXRTFtckFBcnNhR0llZklDald2akxMRjg1U3pCYVMv?=
 =?utf-8?B?R2xoWmZSWVlEZkpzMVdzRUVBNmNoaGFDQmM2RUJETDV6WTdyM21VY2JKYTkw?=
 =?utf-8?B?VXNZWWNpTlBoSlhMeFJDc2c1dzhGemJmSFNmTklCU0hMOHNodzIwSTRHa1NB?=
 =?utf-8?B?NjVUVDZySGgvQzZhdlZGb3dlb0NqY0pVVytCVjhaK0RieG1rUHlGVnZMWG9S?=
 =?utf-8?B?dWVSL0V1RjNBaDlJWXhuejY3bWM5dTlxTWN6K2lPakd1VjJuNjB3ek1Rbkcw?=
 =?utf-8?B?MlNESW5kZFdIUCtQYTZXWkJzSnRkbEtKSUplbHNQOHhObXJrR0FaSnBHMkxo?=
 =?utf-8?B?eDZjVS83bVhkWExDWlUxZmdUQnpVT0lkT0RtVldIT2o4dWVhOEVEcEFZSVVz?=
 =?utf-8?B?UmJNUlJuNUxkb3lpek9UVVV3dUNaM2h6M1ZyUCtLMlFDbE84VFA0dG45SFY4?=
 =?utf-8?B?b1d4UG9iWm10Q1VYaWVwak15a0hiQVQrZ3pveDYzdTJVeXVERlJxaWFRQUs3?=
 =?utf-8?B?azdvSjN4dDV5U2M4OHlTa3AxRk9STXFQVHlqOVVxTHB5dUZBbGF2WmVQS1lO?=
 =?utf-8?Q?HdA+3min2cXByXSo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5cecfa-16d6-4b76-840b-08de6aece0ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:44:35.0488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcB6C5lOk7ky/QRk8A/yK7NDcAU3F6y/o1tBMteq4/ppcBp6FssQMyPdqGonHmv/cyz+Kf32U0Asir+DVT7HpdJTYpRwIclw+cQXtD8kCKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
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

On 2/13/2026 11:26 AM, Anatoly Burakov wrote:
> The macros used were not informative and did not add any value beyond code
> golf, so remove them and make MAC type checks explicit.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Missed from v3

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

-- 
Thanks,
Anatoly
