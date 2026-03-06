Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC788F0183C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 14:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C412940E27;
	Fri,  6 Mar 2026 15:03:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4C8FF40E27;
 Fri,  6 Mar 2026 15:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772805818; x=1804341818;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bNWFw0yEAajMBwRauSzqNOksWd6n2UZO9k9G0kuc4Fg=;
 b=hBk4QmvenTr7Rajx5C9wUepOUtPQwKPz9fV5569kUEB+QCuUGD+MArxB
 kLSyEIDQ3PKInuodNL6RO7HgufwXUuvV4X9KH+TjsyeYYjPwIQj15Ov+p
 NONTuQr6DFpDAZp6KZFz8Uh4L62setKMLjTPepR5W+RXy8sUBpD52+Ix8
 spbuXq8kzSmPUt/piDYvLBIbDnLNTowuSuIL7w5T27qdSIhtnsygxCHgB
 s4LKvDUK+YxBFXtuq1wHls2aJhf9qFJwk9RxvvJViiImSbvAX8MQ2Jgas
 w0AC4rX3e4fFEJSNXL0qLDdxvisJRt/mJlt7HQ/T6btTNseI6zQ7An6Th A==;
X-CSE-ConnectionGUID: t3AN5oLIRhCjjRdTV7t9Cw==
X-CSE-MsgGUID: ux1iBFFwR7C6+EvFPPG75Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84549047"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84549047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 06:03:37 -0800
X-CSE-ConnectionGUID: P3tfJiYhRMiwzj40RMiYSg==
X-CSE-MsgGUID: bLDQvk05QgieYQC3QUohkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="218171089"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 06:03:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 06:03:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 06:03:36 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 06:03:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjtLhVz+r9PhIYYhnO6ogurfCaUjDMiqygpleO/jOyGLhAMyH48eHZUuu4u3Xg5tS3E4IpcEzz9a9JO254kV4c51rjIq/TpDXc9NYMenJmULwjhTUpoUZf607GIXDUYDk9dGvNJ8XZB5hfvX3BBSEr+mAep5FIRIz9reCLcxlcH5laBG46b1rxQEOHNBCafOZxK9zFUAiGWKcStwp1/ff2jd+KGRmAipcjKqsTu9sGvYFpc0HZQy42xMIjJtVCIRNloGCFosZ2ZTstbeFoZXPyckua96pLrwllHN64+zCu3SFkCZOgGl9bCwS/gBvkOxu9M6u3JC5jKDP5pq1XUkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLjXGfw5zoQpMYZms2iXj3oactJMkGecnJgrXAwprFQ=;
 b=lQQ40CqqcfdHT812s4IUMN4Ypwq5CID5Fu8fT90d/a99Spm9dDPyXT4jAIgLZ+zZ3pY2+e9Y18B4Lc9vqDb5Ur7VmvuoVvYm0zsbw6if5E0u+HOpOqa/bmSqIMrOMoacrAx0E/PPi0A2LtnP48KQqVlt9MC6HnD8ffN5QoXt8O9YbLCcyMSy9G61jJ8jBYr5XpaopcaqIojF9Y1vgm0DeHNJ+ighn/70LCerKR017mvYmE5jPaMACvFb0N2hgtG8W9etCAnragTJIZHIjblMT2+pETTKdJKm+aGBzy5CqqLn5gG1dwPIhy3GYSWsSeWeVW0BcNyozGS18gKMlGmpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Fri, 6 Mar 2026 14:03:33 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 14:03:33 +0000
Message-ID: <02e2c11f-d280-48bb-bb6f-7c28bc3c89ac@intel.com>
Date: Fri, 6 Mar 2026 15:03:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/idpf: handle Tx of mbuf segments larger than 16k
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Xiaoyun Li <xiaoyun.li@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, Junfeng Guo <junfengg@nvidia.com>
References: <20260303150026.1601461-1-bruce.richardson@intel.com>
 <f46aa723-75a0-41dc-a063-d79420365b3a@intel.com>
Content-Language: en-US
In-Reply-To: <f46aa723-75a0-41dc-a063-d79420365b3a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: d3466e13-9a38-4c9f-a9bc-08de7b892728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 6aHk1zsLHzySMc0I96Ibu4XsFxmYB68f+49Ssc8TwnSpwRZphaNsQL60XpKta7snxrCKwwv0y46SEjZWh3wlHXlRjEnLvRetAUUV90s2aROwUZ//Iq4lggzo8OLup5xb4BH+UO7ns2I4PGgJDBjRGtBhr/4GG0vj7MQ0w6B2zlvbE3nywLbRD2Nqn2SI7yIdacQnqX8H9ufccuh/9PTFn0jrfJOpUhkJn8ciESJQDajeKUa6D4wn/GWkQ6LScYZLwSsWDiQVIJ1xLzOofdGEP69VHcUMTp9txtb5boA7MlEDB0rt7N3XFjg9YElvOivAyDgD8EOkvx3Ou8zKVjymyzx/QtQH6KUrM/zdVe0NxRQ61H7ldehObaY5/+i/ZaB7+9X7etLIPvLeNDZvgtkw4O0swiL+KkasUCi0tJSYOs22RB04Zdu7dcmMVivkRBzyTtOOA3IsYS1cj0LVJwyM34Q4q/62KMoORwBG1f8O9gR1RbqCdhEyOE8v22yhOWMuO3GTXLk+Zawgs3Cbws84MWEbUckvG2hVsMgEw00/JduLZZv6mFGzJGoN6LA6NF2Fmlba8v4K5ZFhMe+AuR6ESq+2kRwGUbjh8priYh8s/K4PuHdGIMtiysbp8v/NZ93pl1/UdOKVtgXLGmdOOSriZiJU0xg3ZDPrt0NCun2T/KM9hD4DOw5j7KUL1h2n1lWbkx0QYSg4faRX9e3nxOM9PWnMFGQwl8LOc1VQeFvjjs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJselVTVzZZSWpMbXBUSEZiUGJLb09JTjdwWW9zcmNLeEpiaHhIR24xRFQ1?=
 =?utf-8?B?dU83Vk5ueUdsMURIUWZWVXpaZnovbE5kL0ZrUFVkT1Z3UUoydDNyc2xYOVRU?=
 =?utf-8?B?ZUd2SVJDRnAzMjFjN2txK080UVBWc0F3eFc0eG1DWTRMQUlMcWN6Y3pVMTh5?=
 =?utf-8?B?cTl4S1FTN3BLWE1mZWVaQlR6K1d5OVQ2eWtmaEVHcmpRTDN5ckl3WDgycGFs?=
 =?utf-8?B?Z1VFSEtHTmtpRGs4dWJLZ3V2Z1dsdmxLcmxVWmU3ZExXU3NYTWx6Vkg2VXlQ?=
 =?utf-8?B?NlYwcWRFQkhXNy9OTG5KZ2g0cjU3ei9VWmljVDN4QkxHOVEra01iTnZjWUMw?=
 =?utf-8?B?Z2JNZVdWQXp2UTd5cU1VZVJjdXhXZEwvRG1pTW9CREUwQjRIU09tbE1iSnlx?=
 =?utf-8?B?T3hNbzRoSHA2a2xGYndyYTVuV0FMbTN5akZ6T0lMenJhMlNvcW13emJhTkFF?=
 =?utf-8?B?YTlQQlNTd1pEZVNlb0dBNkszM3JNaGlacW1UQjZWcEpVS0xZTnk4RFhnRlJl?=
 =?utf-8?B?ZDBlUnJXeENydTg0RjdmSGpEL3dCL25JdVJDSjEwS0lkaHRuR3g4eVlOWHBJ?=
 =?utf-8?B?S2tJV3UwSlFyQVR3R1NoaEFXZVB6N3lTWTF1OWt4SVhYbjBvdFNsRHBOV0g4?=
 =?utf-8?B?RlFPeXgzeEd6aWcvWStYV0tRVHRXcU5uVnN5OXZNaThUTTlaQW5MV2ZqK0NE?=
 =?utf-8?B?VldweWVwZlVEeDhOcEF0bC9SNHB0RUwvVEJESVV6Yk1BRzBkdFk2akJNRThU?=
 =?utf-8?B?ZVhYTkl1UWxFZDlPMlpiZW5BYXcvalN3TWJhNkVzemJSaTRLZ3FxVnEyL2NR?=
 =?utf-8?B?a3dOQllGWEZVVE1nTlRCZmFySFpZNnNYRmFqNEN5Z1IvaUhKSzI3Y3NRbjRU?=
 =?utf-8?B?L2MrbWpNNFA0ZWp2ZVBnQ3FVd0NFdVF4cmZrWjVzc0VnRStkNld4aFF5eUor?=
 =?utf-8?B?cWk5L25QNnd1SE5nSnZxekplY1NwY1JtYzNURGZWOXpyZmxTNnpyNmlxMWhM?=
 =?utf-8?B?V2s3UloyZFFOc3lYRHFnZC9qR0tvZWpJbGxqNWZERlRkajdEMXhzK0tpQy8x?=
 =?utf-8?B?QmQ4K2YvVkhXaTQvMGVGODlNVWl4R2QzTy9icWZvVW52MmthOExVU2REK0NJ?=
 =?utf-8?B?V1Y1RlZiUkJTM2NZWERSTXo5MDdVbVJDMUwyeUh2MWNCRUJpY1M2VVpheG9Z?=
 =?utf-8?B?TENVMXBrTDBJQkNUYWR3V0JRV0xaa2l4ZHNtdGNNS1E1c1dqY1ZUWFJhTTBv?=
 =?utf-8?B?blphUll2RjNvcTA5c21lRzFjTlAyZWt5V21Ta0g0aFdDUFhCekN2cENuTUlE?=
 =?utf-8?B?cWJjUFd5TjB4cnlBMnJVOXpyT05jR1ZLYTRheERGcUJzbXE3TDRWQ0NwTFNC?=
 =?utf-8?B?MjkrNEM2ZnRONlc0NnB3b1k4ajJhbjQyTGpqbEQxNSswZHZVSFJCanFTcFZp?=
 =?utf-8?B?dU9SK0NaQk0vRHRDS1l5MnpmUEFEVnVFNFJZbFpjQWRkZ0N2aGJibkhQWVhp?=
 =?utf-8?B?bjUrR09aWnlFYUI5ci9GOGJYRG1yb0pDK3ZVRjZjK1d6TDlsNGllMmI3b1I2?=
 =?utf-8?B?WG43ZlZMQUZwRjJuaVlEeGlIZ01nOWh5N0FuMWJUcHZNUVdnY1FDV0hNcVZJ?=
 =?utf-8?B?QWpwcDRJRWdTaU5WMUVTUmhHa0wrcWphbEpKQXZpSEFsSW83dWZ5T2VjS3dt?=
 =?utf-8?B?alMvaE5yUUlBRnhVY0xRZGJLUmMzM2VzR0pMTHR1T2FjKzhuL1k4UGZLVHFC?=
 =?utf-8?B?RWt5V2toNWxDS0drM0hiVjNSdEg3bVpad3hQVzRkbjRsZlJPeUk1QjFNSENF?=
 =?utf-8?B?NjY4Mk5OUDBIVGdSZEtYcEVMZW1qajJsSUpOcjRHZlo2OEhNMGJxUUExSkEx?=
 =?utf-8?B?WXpoQTM0OWFCeExKMHBYZlRTYVV2NUVQandubldZdjFBbmxuS0NxYW9CdkQ2?=
 =?utf-8?B?VmlzVnRGc3B2MXpsRHdBMzRQV0tEWjI5RDk1c3R2VXBVdHAzNlRXdHMyamNi?=
 =?utf-8?B?RXlndEd3R3Bpc2hNb05QTHdyUlQ3ZUdzM1ZydHdHVlBiVllkM2lJVVNZTk9N?=
 =?utf-8?B?bWxjUHFRNExvSG03cWY4QUFYa1lCd0UwOUhyclBPYzc0TG1CNktWMU1ISXZl?=
 =?utf-8?B?Nlg4VW9vMlYzSG1lVkpON2o4b1hhNEsrcFNQNXBRSXVabnFwVjVEOVk4ZUlj?=
 =?utf-8?B?RXZENEk5ZzZLZG0zWkhFYWhEeURVNGlrYnZwbjAzdTB1cEM0dTJTKzBwWFFU?=
 =?utf-8?B?bU56dHdaays3Qmd4OXhKZlpYRGhOUmZRbUxHRUQ4a0R3V2JqRGtJV3R2YTQv?=
 =?utf-8?B?SnYwYnFqOG1MN21PZmpqVDJneUJqNE1UUWZqNWNlTDR2eXFoUUYwYW9sSm40?=
 =?utf-8?Q?0u9iQsEJsHEy+5JM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3466e13-9a38-4c9f-a9bc-08de7b892728
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:03:33.2764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMrI0pBdHruy8a5j2Q4bzU2F2u0SpWvVOsHqH+s9hbvBDafqJu0YaOUjplMWFywq87hxu5V7E8E4iQN/Pw4rAOO/t7Uv94u1oGkLTEZFVlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
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


> CodeRabbit picked up on something here, and I think it's worth 
> highlighting.
> 
> When we're splitting segments, we assign txe->mbuf to the first segment...
> 
> <snip>
> 
>> +                txe = &sw_ring[sw_id];
>> +                /* sub-descriptor slots do not own the mbuf */
>> +                txe->mbuf = NULL;
> 
> ...then set subsequent segments to NULL...
> 
>> +            }
>> -            /* Setup TX descriptor */
>> -            txd->buf_addr =
>> -                rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
>> -            cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>> +            /* Write the final (or only) descriptor for this segment */
>> +            txd = &txr[tx_id];
>> +            txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
>>               txd->qw1.cmd_dtype = cmd_dtype;
>> -            txd->qw1.rxr_bufsize = tx_pkt->data_len;
>> +            txd->qw1.rxr_bufsize = slen;
>>               txd->qw1.compl_tag = sw_id;
> 
> ...and we're supposed to write the final descriptor here, but we've 
> stored the mbuf pointer in the *first* descriptor, not in the *last* 
> one, which means when this descriptor gets to processing completions, 
> the mbuf pointer of that descriptor will be NULL? Is that intended?

Actually, digging in, I don't see where we free mbufs at all in splitq 
path? Am I missing something here?

-- 
Thanks,
Anatoly
