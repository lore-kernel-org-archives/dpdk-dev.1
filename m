Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464BFEB4913
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A3FC4027A;
	Thu, 12 Feb 2026 13:17:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id F317540268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770898621; x=1802434621;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=o0v26HFO/lTWp/5R7TUKf08S1T+QsTXfQa3kJG7/a54=;
 b=QgWwUcex7H0XYe0/l9gzbS9XBsgrA73WsvH4GBtGY+fJ+INvn2+p2OAr
 LWCeZI/6pUGC3HgV7HUwpK3017JhSKKF7ZFBn0f9hewk11CTzQWnTsxq2
 +iqrzpXzTKAWNNptmFzA+bwBPxj0eEz64Qxo5hKTetqBeqDij9T2wm6pd
 MSAynpjIQZgSv1/PjwKHqxFqdmA3pXk655g0PpZfufS5ZCdjQvoPqTpl7
 L3FOH3/NzFVqmn5MZABBTt27Hh9/kLmZmbz/vbNdhCsd3AS4Cm32uR8sD
 53h3RnBN94yU4iMkIorD2hNqOCqJwNrB4W+Qiz1R46K79/NRhrREaJpG5 w==;
X-CSE-ConnectionGUID: XDRJsUcmT6+5POnIfI38fw==
X-CSE-MsgGUID: 2Hf5ZLeOSfGXUdca5WuTNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75911503"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="75911503"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:17:00 -0800
X-CSE-ConnectionGUID: bxnw998ASmiq8wwopnjC7A==
X-CSE-MsgGUID: CfbI2aXnQpOAyYc5IKogHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="211558999"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:17:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:16:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:16:59 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMMEcTP23miAYgQ8XFgMAvX1MakLY68gUWtiyL+6miRF9lNfQMa7y0Ez6aXrmZLEpFRwDY+RkMuLAm2JlfbvDU/sxqc1eYE8lTndm1ZT+RyR7nyYZDhgTjrBdkzkME9jJRCekJcAvKRbV2goOFkInmbshFp+FXSG7GCnTLUBcSVMBpM3DdKjV3Yr6gAryUT8oJAjXhT+DJIr3Y7SprSzlnA0oHgFrJ4R+8Km+ujQYWl/CSxzKEAr5aVUzlC83rbjfDzFqw7gZnqQZcCU3gvHmKONwE36sM8+q6o5EXlU8xQcfeTRSNBN2UK84tAvPJVYg1cNOZhsLMgqp6oXE8l6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roEa0QqCxVQxL0vv5d3lN5wXOlk3NBGagdT9FCwV26o=;
 b=MCGHTwgtu2ATQaeTihNlZD6xuJ+ZkuP7YxjrHr4D3fejeP3aaj+82Er/LS/2uAK+w+GtYrMyxPFod73bq+FyPmd8J0j7FH2NyiZZchDlSgqBQs5NeUNTId+ye9attkVPL5Cmew/qPM+991TVk5ip4jJiA4Sa6VPlZ1rbF2B0YZUrqfE0T+CWs8iuZCL5E3TBBzu1G7X3Nia3B26VmDYhU3PfO/CS8YeZfHofykcX+VwuPadvUgGGPlqIofqOLtxGC3XAlxpnPRQfK+qnDrTPjVPv+7xfLVMBtoBq2TydwGumSt4+NLR27k/zbXP1J1p5urlvYIoti93yhYzsG2L8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB9496.namprd11.prod.outlook.com (2603:10b6:208:5b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 12:16:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:16:58 +0000
Message-ID: <869ff16c-7809-4b38-84f9-634cac77b8c4@intel.com>
Date: Thu, 12 Feb 2026 13:16:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/35] net/ice: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-8-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260211181309.2838042-8-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0208.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f77351-c194-4a81-8c04-08de6a309e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emdScXZTZWNQUEpvTmkrRk05dFdZUVUzd2cwVE96RDI0T0F0VG5PeXllWWtl?=
 =?utf-8?B?d0lyMW9ORlphdkRmUnJsWUZ6d3BYd0JYTHRxMjNxZ3ZqdUdGZ0lHd3U2eFR2?=
 =?utf-8?B?dEVHVk50WXlScVg4WGhONzFmQmIrYmcxTnJYeHBpU3BVYjBod2xiS2Z1VjBT?=
 =?utf-8?B?RWtROXhHT3Ird25QTHM3UHlIUG1Qcy8zMGhkdithMElvQU1abjMvdytjdFQ4?=
 =?utf-8?B?Um9tRjRRWjM1ZUNVc0VTeFNVU3UyZGpBK3dLRGZvWkVVeDRRcTczYXBXcG1y?=
 =?utf-8?B?TkhHemp4YmVZMG5OWGxVTW80TGswYklBOTQrSjUrK2VzMXJjUWx0UEhqZXRh?=
 =?utf-8?B?eG8rMUxvaE1iWnRiMURQNTFNWXdOSllvcHFyWXBrd3JZSkIvRWJzTFM0KytB?=
 =?utf-8?B?dklxTXpuMzUwUnZCYkZBTWVYZFJsR3dVTkhkcXczN2pYQ0xTRUhPQ0Z6UDJ2?=
 =?utf-8?B?Q1NyM2xxNThtRTU4bG1ZR3VudUppdEhIaEdYeDk0V0xzTEF1eHZBamYrRnhC?=
 =?utf-8?B?SVNnVnhzRmllOTNzaUJwVkxRV04ycTk4MFZjaWJBcTlDbG13QmdXVm1tMDNV?=
 =?utf-8?B?M0dMVFVrZ3F4bzNIWW16SW11QnpTL1c1MG1Bbm1wVktJME0rYXpQTzJ4TWsz?=
 =?utf-8?B?VGk2TzRnaDFNd0hVQ3VzTjJIc1NpcXVZTDhKWmxMMS9qa1ArbW90djlhby94?=
 =?utf-8?B?VHQ4YnhJUWF1YmtoRndxNFVkQXdtNGF3emJtbTNkMDlIK1Jyem1hMFFuVVMy?=
 =?utf-8?B?SVRUTVhlamhjQndCaFlFVDdnZjZvenp0a1E4Yk4yYkxOSzhRQmZiU2JRRHRx?=
 =?utf-8?B?bU14VXJMNm5Xdld1WVFlWnJlZldsREVsNTVsMWRocTY5bFFjVHJ0eUpnckwr?=
 =?utf-8?B?MENYdWs2WEZxVENYbVZjNU96aC94aTJ3L2E5elEzckRvYTJkdWpPZllZc0sy?=
 =?utf-8?B?VXJiOVFRK3NuY09RaGtyeTRVMDdPOS9VMVVyb2o1b1ZTakw3TWJSMkJabEJp?=
 =?utf-8?B?bERMVUZ4RnExN21GVjNwM0MrSkx1TE9zYXBlSTJEeVpYK21yN1dyNUpYVnJv?=
 =?utf-8?B?cHRKdjArS2VyN0sraGhZMnlsSnRVVEplRXo2UWhtTE1xbEdXQ0xiTFFoT3dO?=
 =?utf-8?B?YlBGbzBUcVFqNHFYZ2htWExaMDNYeDBBTGV3dWRpb3NGT3c1UDRWcjF6OXZw?=
 =?utf-8?B?VXFZQ3RRckRnbDdIVFpPejVTREpaeWh2RVN0QXN6Z3dSOU54K3NYbEdTV0Vm?=
 =?utf-8?B?TVdacGo5RWlKMDQ0aGdlUlR3NUN1STZSOG1lVnpJUHdZdDJxQ2lsRTQ3ekhX?=
 =?utf-8?B?aDdFRFdGZDMxV2c1Z1FKeE1EUUF6YWpFbmhXMStiZHBEc2hOYytZdDRUTmZw?=
 =?utf-8?B?SmFIV0UrUHBhdkdVRXFKVjJqSkNiUjFHL1pFQ3Zjc0Q3N3d3THdmdFlJVlFm?=
 =?utf-8?B?NzdjeTZwRGFDMUxhYVJVY1VleTRmVjZiQy9abXJyVkZ6OXliMXdjZzBOZlRL?=
 =?utf-8?B?N0F0UitXN0VPSVZocVlCejRMS2JYVHg5YmFBRFFkVXlQbldnN01LL2hIOGl0?=
 =?utf-8?B?VnhhT1dhNFNJckREcFlMWFRyRHR5S1pVTklNdWpzb2duVG9mbzQ0c1g1WXpF?=
 =?utf-8?B?YnpjNE5ZMndPTTFyTTU0RWM1VW5OMnN3cVRLSHhNSDhMWlBqTmtBdlk0QkpM?=
 =?utf-8?B?SmRUYlFkSmt2M3RjQU1RYlJ6VnhzaTZWN25adkpBZExTcU5iQW9YaGk5SWwx?=
 =?utf-8?B?T0NyQ1JYVE1qUUxOUHZSZmZIMHdZSFRqOUZZOEpUL0k3dlEvanduNXBRcHFp?=
 =?utf-8?B?U2crYy80N0F4VmJpUkZtdUEydU9IS0R6VUw4elgwc0hzWDM0Z0pXUTl1V2RG?=
 =?utf-8?B?L1orZjVsNHo4dWMvd1E1WHZ0WktkbThLOTM0RTdrZlFNUFpDRmhmTmRnUmgw?=
 =?utf-8?B?Q2F3SG96QVdUcmlCR0EzbnZ5ZUwzNklaZktZZGxiVVFkQ2E4TFVWVFJLSmZx?=
 =?utf-8?B?UG11V0liQS9ENk1VZ1cvY3BaYjhJSEx6UnNHSHZUb3NSV1JxNkd2UVRwcGJF?=
 =?utf-8?B?cC9uVWtUcFFCTFNVVUJabEhPYmNrMDkxREN3VitzanVFUVZOMmE2TVNsdDlW?=
 =?utf-8?Q?X3eI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVltazIweVdYMjdEUmxuS1hSeDVIY0FHNVVlR3ZCOTBhV1Z5clFaaWN0L1dW?=
 =?utf-8?B?cVMrcnhyVE9mQW4yRWtISTJnLzF2ZmJMa3dtcktyZ0pqK0VYQWlGblVIVjdh?=
 =?utf-8?B?cjFaNUt6dWpqWVRQcXg3USt1U3g3Q1pzMmdjcE9iWnpVc2dzYk1yTnlnS3Br?=
 =?utf-8?B?eFY0ZDNQbVJOUTF3TS9KT1ozSnZiSkFpdEI3NnY4SVUwVVZ2cXBBajU5N3hT?=
 =?utf-8?B?Z05tN29QOGxsQXNkdmplY0VKSyszeU84SXZkVUNzc0VzdnVVT0szcGhOd2Yv?=
 =?utf-8?B?ZzI1NExCNGJ5Q2g1TzduTFA3cXlCRS9YL1hsZjh2cTdicFVvaVdjdG04QnR3?=
 =?utf-8?B?SW1QT0pBTTB1dkU0RUVVamdKQVJkUDNlSk5OQWJCdUY5anJmT1FIelV4ZGtF?=
 =?utf-8?B?N09NTnRpU1BBcjdkL250NHJwN2xKcWMvOUV3c3dqR0YrcW9sTUVVeGNlOFNU?=
 =?utf-8?B?NTZadksxalBsMW9yZmxoK2VmRDF5OWFJd2dTdDJDdWMrc0t5MUw1UGp4K29t?=
 =?utf-8?B?UFR2SlcyU1h2NHZnWGVua3Y2dkxvMERkSFhLVU54azlOTUlReEVXVTF6Vnk4?=
 =?utf-8?B?QzlVNUJCZ2k0cFRvY3hrU3dMSVZOWm1XYXR2cE1kZ3lKejJlWmkzTHdFTG40?=
 =?utf-8?B?RGFIVnZCa2pDaXQzSmpkRVJQZFBjWXU0TlEwcDhMeXliSmxEMTZYQjZERUR1?=
 =?utf-8?B?VDNKMHNpdVhWb2RsaFhOMDJyNUlIQUk4L2RJZVNwNSsybW03Sk9ocVVLM2Vm?=
 =?utf-8?B?VG42UUVoL2grVjBlUGlCRmU4RUY3bTlUQ2Jaak5xWlVxODYzS2JpTTV5ZWZo?=
 =?utf-8?B?a01FR21kdXh4VThDVnh5b3JjbFZLYWp0eXcyRFRXNnZxWDVzQTZQOVZ3VENT?=
 =?utf-8?B?MXZHWFQ5Z29RNjV4MU55Z3FZZWt1cVZYNTA1aUVBTG5vbnd2TkRxOGx5OTdB?=
 =?utf-8?B?cmdxWGFUZkNFUDZXUzIySVdka2c2Qnl0QXhMMEYvZUtSamxUMi9jUHg3WDJ1?=
 =?utf-8?B?YWtwb0U2dE5NZ0sxUzhKNUVVSjgwMUo5QkNzbXFYOTdaalFGY3d4YWZWLytt?=
 =?utf-8?B?UGJ3ZUVxVjR6V3p2TU00TGtnRjR0UHp1RmROOU5iRzR5bXk5Nmp3OTlzejll?=
 =?utf-8?B?ekxMUVJ0b1pUemlIMElwcS9GVkVvVVlBMm1CL2w0Wk1qNEdLQ3RaUE1rbENC?=
 =?utf-8?B?OTJjMnZwQ1ErRjJpbzJ3TmhsVFpHd01BYWdIRFFVdDB6N1BITDlXU01TQ3Z3?=
 =?utf-8?B?bmxiYVNRdHNSaXRWd3pyTnR4Qk1ISGNGWmphMk52WGo4NHFxTjF4Nm4xQmVk?=
 =?utf-8?B?QUlJOHdpWG1Qa2NIN09YeGV2K1BmMjNVeVNNVEdlTzBhRUZGMEc1MjZqWUZv?=
 =?utf-8?B?VWRTcnU3SFhsVVVrV21uT3VZaTFSZW9wSFZQU3hSMGRGYWgxTnN1Ry8wUTFF?=
 =?utf-8?B?U2hqeDdyeURnbGlrR2lrRHI0NHUyTTVud1dXMC9TMTZyNGVWVjh1cHVFcmtF?=
 =?utf-8?B?YVRWNURacStPdGtwMzBzdmtVaDVJYkR2V1c2SHo2ajFjMlluaGl5SVBKNHRp?=
 =?utf-8?B?RDVmOHV5Zng5WStodVdqdHFvRE8wWUpGbzV1clpyVHBkWENhNHVNanp0WjVZ?=
 =?utf-8?B?VkVSb1ZiRTI2bCt1UjY4Wi9mQ2x5bFBqWE1qeUZhZ2dEcEZTb2FDeGVpYjJu?=
 =?utf-8?B?d0pRdElZcXlKYWd3cG82Mm5hZmZ6R3VYZU5YUTExTEFocVNQQXdwQmZaUjg4?=
 =?utf-8?B?UGd5NG1tUVp6dkVRNlJTZ1hMWEFGVlhqWlc3Q2Z3anNYU3Q4dURXc2NJd21i?=
 =?utf-8?B?c2M3cDNuT2NndmM3NFNzb2NGa2tCQW5QSndHYm9RaFJaRm1EOHVIU0tkcGtP?=
 =?utf-8?B?YUFjdkNOZnlwVXZsOTJNZElpc1ptcWpnSXlDUlRCK1RhNU0vdzN6TUZjVEd1?=
 =?utf-8?B?MW9rUXRqYXJjOTNqL2NkYnp3Y0JsUDFqY1Vzb28xMnIxOFZlbGwxN2lTaGxu?=
 =?utf-8?B?cmQ5UEkxUFJ4OE5yL3I5UGdVa3pvR21xbzdsSnFMWmxZelFscmo1MHBtQ2k2?=
 =?utf-8?B?elN4bGRVcVk5M0tpY1d0TlhndDFTajhDckNjbE15SFloOWZPZUxtRlV4bElo?=
 =?utf-8?B?a2J1UVdhQ3ZhNWtzUExRMWg1QjVnMXpEUXh0aTZyeTFIdFhINGxlQ3lMMG9i?=
 =?utf-8?B?djJmVGd5UEF2VmdOUmpJUUJFZEhBcEppK21EdlVEVEtYd2NsL0hyNGZHWG84?=
 =?utf-8?B?a0dkaFB0YnVlVU1od01OM2lvWDBKdVpZKzZzOUhDOXpYVGV3ek0vQndTOTBx?=
 =?utf-8?B?bVoxVkFpcWUvRngxODJRYkx6U0FoZTJzdFhobEorcmI5WGcrZ3NkZDc1WnBM?=
 =?utf-8?Q?bie4Y4UApKt71RIE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f77351-c194-4a81-8c04-08de6a309e2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:16:58.0324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StLvYH/Bh5DWiPsTHSgaF3DERYIWKBnm0u9Dwoz9y1rKxVhAGlyiVSXf7Fe0SoaedwKOO90RvKkLZZEyxvPmzr3Mlvk6C9x0CyNO6ujYFxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9496
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

On 2/11/2026 7:12 PM, Bruce Richardson wrote:
> Create a single function to manage all context descriptor handling,
> which returns either 0 or 1 depending on whether a descriptor is needed
> or not, as well as returning directly the descriptor contents if
> relevant.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
