Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB8CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A354026A;
	Mon, 18 Aug 2025 08:33:32 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by mails.dpdk.org (Postfix) with ESMTP id D6F3E40267;
 Mon, 18 Aug 2025 08:33:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXFkvQwowcl92+xeweRHPcgTCYeUFijkEQNfPKFXsXtxiqIH15LknaclN2IFTGake9Ta/MRMYAqfdpAv9MtlBX9oguTpws6P33y67ieUGtw7mfJfu1EQVMQgbLJu0tY/yDDYowD0HVa8UwNfhsgAP0zHJyoY8E6bFr87n/AJSgfaJZ9TJit7H5CS3kud0xWUbohXCUnZtzvAcUCjvvGHq6mQyVT9cp/zxic2WIU6kWyQ6JXEb98Y4C4YuUuoLWxU8CoFJD5sriRDjsnfI73IwnENRR4tJtnksgjLFd/JcLWO2tEqAcIxJMzeKL0Augztfkgm7s8540epUi3SHGr4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHaScGKS0oOIxLYz5Nuul3IYUnvikq8cV2+i1ZORTyo=;
 b=xa3/UUvJcXbPBaYtee7OewOrNIz62l5BXWiyKYJgVByNLVbtk3/rKdI20zhXghFKDV1uFAqJfkpOEre27KxuHaxkll1Z688+niwWqMwgnkeoOeFkVXWmunFvwWvc9xIPvVB5Y6z+WYrNX0rCXubTSmLAUjSdfQJTR8vVMHDkP18fe8WuY2SRib2r+r7BcjOB0RTzNCFTr0YF6odZPivEATz9aEPGtHPu7VFHfZJzEPHux7QUQfa4MFOTUuudeKH2CxX5rG7hZUoNLgh1OifooCFQUsEMBrczLNkV66cWCk9ReVJPoS8Pn5utjpeuaN0tkNUqCeJIbwLoesLNoE40vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHaScGKS0oOIxLYz5Nuul3IYUnvikq8cV2+i1ZORTyo=;
 b=fzAnXk0MlNvWbEY5x6yurJBjfXU/PuOM84fUqhRAnZzY8erlELNKtKLYLLddP8L9v7BsZSPjDCTrr7lbJ7mK5jpo+1uM6OWBUtsufhZHJZRngq92S3sctO+y2xFeEgAaGUG8ja2OeTp89tNPyFbGxShY2ZTb2WVg3wpXQPqaEKzai4KH6e2tqa5P9EpzkMlxYFfJzGYd6nVeHyJY/m0b2M5rzjVzVcHsE3+flW+f5dBYUwunDr6WpNqDfq4giNdiMqU0RE1jyWAao1CUK370eLHXnTOmlVpgeeUcI2MU0r4HSM2HLVHKV5W05/Rka+dena1fDbmrjNA61RflWz9wtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:33:28 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:33:28 +0000
Message-ID: <9769c8e7-3259-43c5-812e-c61fe3e3f1ca@nvidia.com>
Date: Mon, 18 Aug 2025 09:33:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/hws: fix ESP header match in strict mode
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250804050514.244896-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c7eb90-034d-468e-209b-08ddde212432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty94V2FVUHhlbWtxZ0F6TG1YMXVEK1pzS20wSXBncXl4ZCtWY3BpNXRzZFI4?=
 =?utf-8?B?aEttTTl4aERGK0F0SGlMVWdNYUt0dndPVzQ4Sk1DU3RSVHVIY1dWUzQrWEtP?=
 =?utf-8?B?S0Q4cVFRdzhyMWlvQmRpOE9qamdCekgxMFBsOXdKRU1nY1lyc3h3RWJXdDVD?=
 =?utf-8?B?L3hadE9YY3YxYXZ5cVQyRDdlUzlZcTh6bWxFTm51c3pBWXh6aFBhajA3RkFO?=
 =?utf-8?B?OUFVSDBxRE9aY3M2ZFFHaHM3RzZwR0VjcEEralY2U1RUNDUwZithM0NBYWt3?=
 =?utf-8?B?UjRFZy9scmtEYkZhdEhaWVgwUWlNM0lwTVhCSm1JSERKVmVDNlo5b3d3VVBs?=
 =?utf-8?B?V1d4ekRqWXYrTzdmUDhnc094Qm1jMXRtRDF2Zmd5VTRoU1ZyK1VYYlZUTWM5?=
 =?utf-8?B?S25pQlZ2RTlaUmR6YjlEaERVNGU0QXh1T0RVUHNGVG4vWkpUQlRtK2FBWVE0?=
 =?utf-8?B?YWpDMWJsSWluallHOEJjTWFXYmZDVFNkUVVXZ0NCSFYrZk5Sc2lvSU5qdkpr?=
 =?utf-8?B?enlNUjFacDlxS3ZNOVpYZ3RKcUUvRVlWdHFQb3ptYmkvUjNUUUh5eE5KWGNP?=
 =?utf-8?B?bUNnRHZZL3duTmN6V1g1U3VFNXlQamNmZWROdEhzdG9rc0Rsdmp4QnNQL1By?=
 =?utf-8?B?SndyMW85NSt3TFZVRURqU05jQWNKcDF4bk4rMnR6bDdOUTFWTjR2WlY5UzlV?=
 =?utf-8?B?ODVhWnBDaWpHaERKWDQxMGRDZmwwNi9oN1owcEZiRitBLzlYeEJYWEMyQzI4?=
 =?utf-8?B?dmkwS2N3cG5BQTlkNXFla29uVkJpSjJaM3N5Z0N3Y3Q5dS93UHZnMWVrNjRK?=
 =?utf-8?B?cmxsb2VicjBrM0JEbWFRaEdBdlp3OTYxblRVOWpPWU5CM1gxanJlT3A0R09r?=
 =?utf-8?B?TktEQ3E0dE1nQTkxR1QxM2VSU05IVGNLRGpVZzBhQ0VoeFpvOW16THlTaTdV?=
 =?utf-8?B?WFFZcnA5TGt5RHRqUXpsemFjTGkxaUVqZ0VUNmZKRnVNV0w5WlhoelhoZlNj?=
 =?utf-8?B?S1BMM2xwYnVGTG9WYnFZZ3dmQUxCTTlxR2YrUFBoT1paRmhhOFFhVm9wK09B?=
 =?utf-8?B?MlkrT29FNVFYWi9jeFdLdHl1VWRjU0J6NDRXaXhBUU12K3ExYk0rRytvR0FX?=
 =?utf-8?B?Q0hUSU9pVlVkdzdkbVh4RXhOVWJuRm9VY3FteEVtdEtoei80aWVGRkdPc0d1?=
 =?utf-8?B?YVduNDBIMFQxZ2xGcU1zMStIMll2MGI4Vkw0RlFuN1FyUm8wRklyTnpmNmg3?=
 =?utf-8?B?MWcrWlU0aGFwc3U5ak1vblNjY1BsR0hKRFRmTzZMYzlYZDVXUjF4NHhwUjNp?=
 =?utf-8?B?L3FHS3Fma2ZaQ2VlTnJ4c20rMGxVMUpEbWxZZ2VTbjZkS0pCQ25kbitFek9C?=
 =?utf-8?B?WUw4UkNvZU5QNFZrZnp5UUpRTWpWWlF0b3JPaDhxZnJiVUEreFdWNXpWUTNw?=
 =?utf-8?B?dlJBZ0xaeVlXRUtWYzJuSVdOQWtwRHlLRWR1M0FVOWRKOGdyaDYzVStBdWhm?=
 =?utf-8?B?T1orQ3E0TmQycXo5ZGI5SHZDZmo4WlBHZlNMSEFNMVlmMG1XMjk0SjIwZGtX?=
 =?utf-8?B?ZVRoZ2doSkxmaVVmeVptQTY3K0lvRk5ZeWNGZ1N0U0J6L1dNVzhEMnE1SWhW?=
 =?utf-8?B?NGtSbHVVZ0hXQWpRNkRlQWdYSElIeTNkaitLejRRTjJ5c081QlhXU2tlWkd3?=
 =?utf-8?B?Q2hNWWdXK0xrRjFtTzJCY0d6M2hOSUgzS0JsdkkxOHFRa0FQa3RrUmRpb0FX?=
 =?utf-8?B?RVFyN3VBMUVHbC9Qc21PT0paRk5qd2J2bHdPVHF5Q0toMjRoTnAvTjl1eGtP?=
 =?utf-8?B?eFRTU3UzaThJb21uaWFZa2ZCejFvcFlCM2d6S09Lak9TNmFQNE95K0ZpTFBi?=
 =?utf-8?B?NHVJNlJJemFjZTJnMlBsQ29DY0FKZFoyd1ZiMnhjYXZMSk0rZzlhYnJOSUNK?=
 =?utf-8?Q?o3xcJ4G48zs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXo2a05rK0lqTU41d0VkbVprOWZidmFyamhha2hQMDd4OE9JZnhxdDdyaFcz?=
 =?utf-8?B?YjRsZzBCK1d6a3dkaDhSZ0JCSllqL3hjZ2cvbUQ2Yk9pVEF3S01naHJpQllQ?=
 =?utf-8?B?amJFaXkycDdnR1JlOWNUUGVFRW9vRk9OTDFyODE2QjFNWlZRMHdPOWZVM0JV?=
 =?utf-8?B?UkJocUVGcFIrVkVzMjVmK3NNUWVENkdkM1FSQXZsSnhOMXpOUjM1OUxieHF1?=
 =?utf-8?B?NTZlcUhmYWdSNW9EN1ZTRi9ybWdocWJkUXdwdnQ3TDY4YjBsM2s1UzNrRXBh?=
 =?utf-8?B?NEdWa0NGcDRKSHJLWlN1ckVNYTRDbzdGb21xczNtbmRmU2J0MFFRVWJUVXMz?=
 =?utf-8?B?bjE0dTlwYVZtWXI3ZE1oTUd6QXlzVWlQdXVlSGxacWVUeGplSWhkT09TN05T?=
 =?utf-8?B?dXlPT1I4T0dOTTFSVXBLQmVBZW5zM241bVlGeVN5aG5MYkVEWDVBVzhGY0lS?=
 =?utf-8?B?ZE53QlhlTWUyaTI2ZFRYMlBQM3lPNXlpY1pYUlNJdXViV0dBQk9HdVZBWFRa?=
 =?utf-8?B?YnZRNktCSWhSUHNpb3pvMnJEUXdLZkZ6NXFleWRiWDNCdGhSOFRDQ01yZUlB?=
 =?utf-8?B?aUIvTFlYTmdGTmFoOEYzUXU2NE43OUtuejNvZU9tcDNTUUxSR2lMVG90R1ZK?=
 =?utf-8?B?QjhtelI5eFJ2c1lHMk9wTngzLzlCbTJQT2NUWDJtS1UrRFUrMFd1ZmJzZkNH?=
 =?utf-8?B?Q0ZNc3RNL1FjaVNGVm5YdFh0aG81TU5vZDhUNXlNNGpqTlFFUVU4QndaMlY5?=
 =?utf-8?B?WkwwWGlHc0V0YTZrN0dscWpxM2VSblFJNGFNdXdUK3ZvS1JHOUgvYmxNRWp1?=
 =?utf-8?B?MW55N01OOWlIRlBkeEF6SkN5TFRnbXVrWGxjUFdhK05xMmhBYzNQK1FHbkNi?=
 =?utf-8?B?U1VDOVRGUW9nMm91WmNMRTE5akxKTDdKbzZFMmJSTGJoQlkvWVdxeHI2ejdw?=
 =?utf-8?B?eXluSTNjc1ZDNGgwOXllYUc3amN1L0tsc1V4RUhrR01jMWliVGV6YUJaUVhB?=
 =?utf-8?B?T3BRNHhjRVdRVXEray9qQ0ZwamhzUlB2U3FUTWZvbG94dTM0QlpQSy9zd1FO?=
 =?utf-8?B?ZHArWU1xd0p0ZSs5ODdleEQrSGlBaDZDT0tMNnl5SzBoWnBIWmJQaG5lbWNC?=
 =?utf-8?B?N0xmNGwreUt1MGt1bU5vYmEybGpVK1ZBV0NGbFRBUFVMR3VZYyt5aC92cWtK?=
 =?utf-8?B?WXVNc1diRVdvaStwSmo1ZmRHMnExbHNSRVRPZVpzSTc3eEpqZ1lxSW9GSTds?=
 =?utf-8?B?MEEzMGV6ZjdSVWtMbmFRMGczcTNpREJQb1ZYZ3ZQSnVlM1dLek9Zd2dFTllI?=
 =?utf-8?B?NE4wZUV0QitNRkRlMmxEcTlYUGtrcXNyRTBwckZwZkRXL1k1TTFkTUU0MFdI?=
 =?utf-8?B?cnE1MXZuS0x5MzI5ZkhFREJYYzZkdktiSENxdSt0dk1Ma0gwS04wUlQ5ZEFN?=
 =?utf-8?B?ZjVtak5wRXdnbE9HOEFLb0RXQlFYZDU0YXRNQjd3ZFZLTkFHdW15WHBITW10?=
 =?utf-8?B?QWNNTkJIWkhhYU94Z3JkT2pwUXRtaUQwa2lvNkpQeUlOb2Y2T1cyMWRsZEdJ?=
 =?utf-8?B?VFF0ZW5JZHdadXMvMVI4VlNieFhXN3MvZ1l3cmMzNUJ3MzJoS0Y3ZkZsU2cz?=
 =?utf-8?B?TTQ3VjI1RVpkOTNibmFPSVZGejJzQXp4dGJOeWU0c2JiMm5ScS85UjE0UEp5?=
 =?utf-8?B?cndoV0R0RjRqNWxEc0hrK2YxM1VKZDZ6Y09uT2FhR1BaSThZb0IyVFpQcFdS?=
 =?utf-8?B?VTNSaHhBeWJUeDBtWDBQY1VwTnNmR0dHS2g2MXRLM0tlcnZtR1ZRUEFvRG5x?=
 =?utf-8?B?WWxwZWhPMUdBRndKK1ovSUdua3owOXBmNldMNEpXbUIvVFd0SWxkZ1EycDZ4?=
 =?utf-8?B?TXN5Y2pMVnBYR2xJaDlkbG1pMzN3TGhoY2V2aUQydWFKa2NGdVQ1czhOWUlx?=
 =?utf-8?B?aEVHZFpGa3BFL3ZnMUV1dDl0ZUZlNkFhelAwMm0zVWhTT1lxV1g5N3gxR0RV?=
 =?utf-8?B?U2J2U1VpcmFibUdRSXdWYjBkaDBmeDZCRkpidFJSRFkwUnF2N0c4WnhxL0oz?=
 =?utf-8?B?Y1owOEpmT2QxRm5JUW5pYUxhK2xaN1lJd3o3Ty94WkxxRkYzNjlmSnVack0v?=
 =?utf-8?Q?UdTchUCb8x0UOIYQnaG0KDwug?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c7eb90-034d-468e-209b-08ddde212432
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:33:28.2158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yCHUiGAjUC5vFLLTBTw4+kme9u6yecF9nMI7Cj/deHezMKLko4s3bkVuXnHBMORn7hnzodYbS5HgmS7MZB9EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 04/08/2025 8:05 AM, Viacheslav Ovsiienko wrote:
> The pattern like "eth / ipv6 / esp / end" matched on any IPv6
> packet in strict mode, because there was no impicit match on the
> IP.proto forced.
> 
> This patch adds the implicit match on IP.proto with value 50 (ESP)
> and adds implicit match on UDP.dport with value 4500 for the case
> ESP over UDP.
> 
> Fixes: 18ca4a4ec73a ("net/mlx5: support ESP SPI match and RSS hash")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

