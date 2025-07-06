Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95791C83F05
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Jul 2025 14:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6EAF4025F;
	Sun,  6 Jul 2025 16:15:57 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by mails.dpdk.org (Postfix) with ESMTP id 9C3F64021E;
 Sun,  6 Jul 2025 16:15:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY8T6RWav5ggiuKwwj8PDZNYaGgwULMPStcnl8tSNcA9yBwIoHUI41KaFAV2UDoUdNVwww/juwk02qZ3FeCEixekCc6r4AXUJ8YpPmq4NNZkUkZNjyGu9YH5w90yTqGdkhd2k0skuD007/RJJ227/NC/c/OXYgV+X1kdR1GJB4FqdCxMolFncgD2fX4BrO8Wq4FY9Uj/na2WoNqP8wGr2kyo/1QXp4uBVuWzeJxogZIJFqCo9eHeVh/lR/lyxqQogTjoFzuvSSFWQ82PPlne/9/lA8ua0Q4Qves3GanDbBfAhVfRVDQeYSgvKxEO519ggg9DqI31B3ahc+bMYMHlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzrtdH1T7VunCOsw8esah8OvHopIb+C3pHL5NgwxetA=;
 b=ww9gR+zgSPjJ+MeQ8ZUUsGuoAQdP9iJLUX47GgaFEK1YhpOaKFwHJUw9R6ex/dMOWUGpSrRf131ahN3bquK4HXJOARv3LEwSrs0O3finYootpg5rOBd2+68UDbGkNFFuyBa7Tf/HISM9Ap7OkenG+Z7QsQnrC+0iI4mSUTM9Gzvxp/acBdZGpiVkSaDVP0Kj65jTsDImNdS4Jn29JdgX58SdoWSiQH8aqiMUxTxQoEGFNjJ7IMlNWcmdju2pPh10PScgHk91e//pxOpG1r7lqdadsDFGa799JGvQFO2kDKGLNJzU5cz5dlx9MwFuV6llOgHASq9VnEJ/fw8yv+RLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzrtdH1T7VunCOsw8esah8OvHopIb+C3pHL5NgwxetA=;
 b=iBzaIlV9FGj056vQC4zPRshtWEX/qHGdae9J8vkZ3UhEo20CJCCJIljHXKWZvXp9s6/1L3S/1TuR9XIlfXntc0KAg5kQaipxa4KkadKoeBKRYgsMXn0iUQ6jpZ10wbar29GDud9hmeeyj/ZQhZ9yR/1saXweypFeF2R6hpIJ8u/PiwpN1c1uSz+II6JEKBYHUqzusyV4RkYRsLi6fJmPA4kB4tc5or1eblhCXYhZsPlJcTAhoQz5hjH11TKB8pAv3Yn2lEDCe8VP6Y2xhWXFZGvZ2BrbmMTjBTNOuchMNeWyaR6bnNRoqPzZ+m7oR+u9A0uu3gHxp+Vi/zUWkwNRnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 6 Jul
 2025 14:15:50 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8901.021; Sun, 6 Jul 2025
 14:15:50 +0000
Message-ID: <42663c20-baf3-4985-b4f1-7dd83a1eb2ef@nvidia.com>
Date: Sun, 6 Jul 2025 17:15:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix masked indirect age action validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250701103253.318225-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250701103253.318225-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bb8345-f532-4091-a298-08ddbc979bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1JYcDZHVDI4T0R6RWhvVkFSZXJtQmRQTzBRRC9oVDNEaUFzalFYWlUzMzdk?=
 =?utf-8?B?YWlFbVIxL1BubjJRZXlqRllnTzZLYVNHMkRocW1MV2RqcXI5QkF1TXJLMmFZ?=
 =?utf-8?B?ampwcWZJZ0ZTNjdGMTdwakxxL0VVNTJXSTRiWmJlVXRXZ0FqS1lsd294M1Bv?=
 =?utf-8?B?OWtKUW9Gc2tGVElzQnRJcEcxcmhUQ1BMa0FHbXdWYUs0MSt5cWlCSjY2VkJU?=
 =?utf-8?B?VFEwZW5ZZWlwRVJpZmVLQ2x6L3FVdDZhOTczb29EOVBZVmltZW1kZ001aWJP?=
 =?utf-8?B?Tm5scEs5NTV5VVBmUEFibGFFZzB0bG94Tmx5cWxEVWJXZjYyb0FtREt0RHR6?=
 =?utf-8?B?K081TGhHVEN5L3luWmRhOFp4UVBiWHVoQlZad045Z2lhZUFFVDdPY0dSUDhs?=
 =?utf-8?B?TGFKK3JETTJSQTBjU3dpcUxXVDZNTjNTTEQ2cC96VzlFblVranBmN0hicU5S?=
 =?utf-8?B?Ri9rUmNsK0piVnIwbmViNlEzOTkvbGFoSmZDcHlDbUFyTUtGZTN5S2VEVk1q?=
 =?utf-8?B?REZIWjFjamRWakFhdENSSjdlV3kydXlLUk5LRW5BRG1lT3hkNHIyK05kQmx5?=
 =?utf-8?B?Qm5DYktVNmlNUUdVMkIrS09hSWFXQUVXTTVwS3ZYRG1YcTBLVzZTZytkVVBS?=
 =?utf-8?B?Tk1Ja0NsTzRHRDRUczAzR1Y1bjJWNEVOWERibk1CVng2c05EcEpWMzNaTmRP?=
 =?utf-8?B?cEJLZ2dkUlE2QXkwVzNZK051dG16RmJVQXpXblpqU2VoNzFabkF3NmpMNS8w?=
 =?utf-8?B?VkxTVDV2WHp6R0RsdzlDaG5JTld1T3lLUnYvVUxQTzZYNUJMcEg2TmJONG9R?=
 =?utf-8?B?Q084Rm9yZVhrL0wvNTJzSnFCNlk4NHRmelZNRHYzTkF6UWNMTTRKN0ZoakNL?=
 =?utf-8?B?Mzd5NGR5YTBuRjB0dWhKWE0reXJaT3ZLdGNDVSt1eVhoUzhJV3VwTnZNaWpp?=
 =?utf-8?B?WmZZeDFLMDJtSWU0Umx3ZGJ6L2o1Z3YvUnJkRkVabGNxU1A2NVp0M1dtS3Av?=
 =?utf-8?B?eGhxT1RIMEM0RlEydzVFNlVMSHR5SitTQWRYais1aEFsWEp3bkxDcWNQc2Rq?=
 =?utf-8?B?V0FyNk5sT0o0RUFYeDllZGlhQkJ6Q2FIQnMwV29wQytMOXdKeitqajZ5RkpV?=
 =?utf-8?B?ckNsbGNuTVg0bitwazN6SlRFSEkwQ2dWc2RsTlliaEMzdFR3a3hjTVkvU3Mw?=
 =?utf-8?B?S3FzL003SlVPelpIUlJXUnYvR2ZDdkd3ME5HdkVQaUprNmpUdjFXODI0YmRt?=
 =?utf-8?B?TkhtOHNDR3lGYnU1Q3dEaDZUcnhZZjVnWUVKUHpYbjZOaE13d3RVa0VNR1pj?=
 =?utf-8?B?U1U2YTJIVThYNmdRVEtIWDkzQUtjV0syLzFkVTN6SXZqOCtSNkl5VmVVUDkv?=
 =?utf-8?B?ZjlIY0dCdHI1TkxLRVRaL1Z4bjg3b211clJuSkZwV2JBRkxnalZtclVQYktt?=
 =?utf-8?B?OVJiSVQrZWpxVGZQU0UwMklNYWFkMzdESWUwTlkyUEZHYS9neUM4QnRlMi9K?=
 =?utf-8?B?TjlNOHNCN1VBRWRqTW9neU5BYkV5MjRYUGNnQWR5ZjlvRTRtdU5ZUjVyZHZr?=
 =?utf-8?B?T0k5Zk1ndEV1ellvSTJhZjc3VjJyOE5VdmtnYlFzMDg4SXd5SEFOdS9BTnFj?=
 =?utf-8?B?UjBIUDJrOFN0MUxxR3FJcXZpZEthay91K25FNzBxR1NjQzYwRVJvSEs0WC9o?=
 =?utf-8?B?YzNyTy9WQ2l4S3I2MGVtQTV4eDhsa0hRcUJWeldIZVd1UFRkOURYVVhDckRB?=
 =?utf-8?B?ZEwzNWcrbkJ3K3hnOFdUUVQ1RGVhVDdoOEVaeWFJVDJRVnQ4aWJSa2JyZUhz?=
 =?utf-8?B?Y3VSS25peDNLNXNiTFNyUGw4M1dSUjJRcWxtVURiUGIyZHpDSXJqNEpac3dX?=
 =?utf-8?B?UHd2TTdWa3BDaXd5enlMLzRtTE9wMFpoUTRYUStWVTdSdHoxcjhqQ3RYNHVW?=
 =?utf-8?Q?aBvSbr48da0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxpUFhxOUk5VmtHaHlrQVlVZUhxQ1RFSG5NK3ZEY3h4emxaVGw3RXpQa1Zm?=
 =?utf-8?B?NE9KalQ0dTZ1dTR3VFRKN2Z4dVdZZ3Rkd2ZHOGlKemhBT2VaVGtoNWg3WXov?=
 =?utf-8?B?djNNWlJuNU9ZRDl5UmpVMzdHWjZBK3hzOXJaRGxoYy9EUEZpbCt0bEdFbDEz?=
 =?utf-8?B?MlllRlo0VkRYZHp6MUJKK0QvVEV1N2w5a05zQ3A5dWp4NVcyWDJjNDI3STVa?=
 =?utf-8?B?UHhDL0VJSWJnYXpZYldXelcraDhmUjR6aTR4UEJlVjV0T1BQeENGUDZHMUR4?=
 =?utf-8?B?UU9SUWdhT1U4WXZucHF0aitrL3dMNTVwL1FBcUVsVThHOWVqR3RwV2xHdVRC?=
 =?utf-8?B?Tjl3ZWxYOHJYakVmandkZTZ0bmRMcXF5UElHUUlZaEdubnRDaCtyYldXWGE2?=
 =?utf-8?B?YWxHVXVjbkdJRE5KK3ArWGd3MXI2R3lYd0cxMUZmcHFBVkNwR1dkQ3VLc3RW?=
 =?utf-8?B?SFhwQXBqR3EyRGZoWWwwQ2lxalVtbzlVbEtsc0tlNWo3Ylc3TnZ6T0tvYjN0?=
 =?utf-8?B?SjV0ZjhveVErWDc5RVVKK3oyR3hyaitoSVl6S3VMamRLRi9PeEE1SEViWDFw?=
 =?utf-8?B?TkpSYXFWSUMvNmRLaEEveWNJUUNUZngvRGlDSXRZTExhd0lxZ1BkTERNNWoy?=
 =?utf-8?B?NXJNK011cU1EWlZGaVRMQzd6SkE5RUZUcGhOSE1GNVZtdmYyRjRaUmM5V1pp?=
 =?utf-8?B?RG1XUEJlbUowK20yalNhNFNXbTRWYUFSUi9lWjJ6eDlGZEdoMVdjNjJKYVhu?=
 =?utf-8?B?c29ZbzBkL2VRY1FpT1BGUTZieTVRMmZkS0VwUEt1bTdtVjZmZ2VmbWlHZ0hD?=
 =?utf-8?B?aDNpOHppRDhkNXRUUjVhZDljcGZsWnpTeldHVE1wNEtkbzJ0bjU1U1dRVC91?=
 =?utf-8?B?SnVPVTY5QWZpQWd5UzZBa1pmMURsR2pHUXAzamhzdHJvYm1HaHVpQ3lWSzJp?=
 =?utf-8?B?VmxWcEhoTUw4WkhKWEFNZGpZdVN6NENjaThvZHhpZElpSXc2NGFHZUJFeGNP?=
 =?utf-8?B?S092eGMzZzNtTkRyMExCQ3c5OTlvWHk0bXpNdkdUdk5Hd1JDR0pHZXoxL0xn?=
 =?utf-8?B?L2ZZNzVJUENWUlhDNzJZWUhEaXJJazNrSW5KL1JpZ29FNlErVkdnNE0vUkp4?=
 =?utf-8?B?RXRpNWV1L242MEdyWmNpdUhDb1B4OXl6azdDbXBvc3hncWNIMUVXTi9NSDdn?=
 =?utf-8?B?Mkh2L3B2NTIxc1BROEM3YklLNWllMkZJcnAzRE1ENHVEQ2ZVK05EamZKWVNj?=
 =?utf-8?B?SSs3TEpqMEN5VG5hQTF6YVpRWjN4eVVoQmpOaGgycW1uSWxGcGphTi83Z2RL?=
 =?utf-8?B?UlZ2M1J3MnNHNzNoOHBvMCtITmJSN3ZDaG90QndmRHNNL29oRWg4azd1OEUz?=
 =?utf-8?B?Vk93Z1djQTgxQmdoSmFndHNoY0I4am1GZUQwV2ROajV1Y3hmaDJyTm1rZFNT?=
 =?utf-8?B?Z0JoTGJjRElBeElGdjBJVkZVZUk2czQvZXhZek1tSjJYbUlnakozSnhxRXVF?=
 =?utf-8?B?dkJQV3BKY09CZnpXYUgxRHBQR3hVRFZhMWRWcE41SWRoTHNiZ05TZ3VjVnFx?=
 =?utf-8?B?bTFoMUlmNndLcjVOVG0wWlFRRENKc0ptdThnWU9BYkR6L3lwdkRoUk9CM2xH?=
 =?utf-8?B?d0NEZzk4Tkc2WXBKMWl6YmZETnRrWXgwOEJ2YnZGdEhkM29aRHFFQVNjTzRv?=
 =?utf-8?B?Q0x6bStpVC84eWRxRzBydjZ4VDZ1dDlmd0FDV3JxS1lzK0ZSbjZIMlREbkpy?=
 =?utf-8?B?ZGJtanJvL2RBTXAyQnRBODE1Y0R5dHR4ZnVUUWlVek5JckZON2VtRHpoTnQx?=
 =?utf-8?B?RldLNGliMDNIV1lZWElFSURuSzZOMHlIb0FBZU92NUlwQjlRcnBHZXo2UTZN?=
 =?utf-8?B?NVBGR0RTT2JIa2toYlUzS3R0RFBRclpXaDUveGZvSXJCd0VOcHdPKzJKbW0v?=
 =?utf-8?B?Y05DS1Mxa2c4YUJPY0Nrc3ZRRTZZbGFDR21YMUYweURRajdDaG5oY0U1R0Fw?=
 =?utf-8?B?R2VjS0F6Zk85bitxSTBJQ0k1akowR1B1Y1ZoSmFZdjlXa3QvL0hYQklwd2J1?=
 =?utf-8?B?REtuVVZRc3k2cFdNZVIzbU9nREN1Z1pNa09hVUhXYzhWQlNYZHBFWEtVRncr?=
 =?utf-8?Q?CLrOSSdve2iyKNGvLoA0c/vJH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bb8345-f532-4091-a298-08ddbc979bf1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 14:15:50.1906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaCi4b7qxAwUdExg8h71v8dFpxjq6GMeH//qvIOMg4vJD3zgsmWft/fJPs3bIZKk+bnS6SxOdvw9wpvFIs9haQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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

Hi,


On 01/07/2025 1:32 PM, Dariusz Sosnowski wrote:
> Masked indirect age flow action is not supported in
> actions templates.
> Up to this patch, this case was checked only through
> debug assertion. As a side effect, in a build without assertions,
> this lead to a segfault on the attempt to create
> a table using actions template with masked indirect age action.
> To prevent the segfault, this patch adds relevant validation
> to actions template creation and removes the debug assertion
> which now becomes redundant.
> 
> Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
> Cc: michaelba@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

