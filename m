Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719821062870
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 12:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68DA74067C;
	Wed, 11 Mar 2026 13:15:40 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by mails.dpdk.org (Postfix) with ESMTP id 7E9BA402B8
 for <dev@dpdk.org>; Wed, 11 Mar 2026 13:15:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6QZUAAiYzkTnLz/Q1TeHphom5c/eWlMHAr653wyzRDzUKkkvE3LXEk4nKNtQ/7DnBaHlDlUEu/frNnfKNWxbciiQUnd8jA5OdlmtvXVkX3eYISL/XMzLeexkf8MusA4qdg5iRfnNqKmFuWr9AjOP84eLMiWpBFzGbP8w+L4gko+xgAS6qKcuicfWd1wm1pLDaLdfHP4NG4xBkLmcdSlJfqO3NmvFLZOa/eF8SDAaEGyo79fIHl8u1BmUjHczSveWGRXojNQMG7po3bO4VJiRntEoVgGtgk4xiScHOQuS2wyeatoPtJZUcpGPyGt2O3QmBPiAMZqPRe5zI9LZ/xTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clsHppYhFwm9fJOMx+YJnbHZ0Z6IDDztm0r+NBn9QI0=;
 b=qqeUBamwWehqVcN9zjSYDddMCGLHM5gb0Y7JBpjAUmKFOO4/fA5nRERTBI6TePrzMtJKj2gXftQHuvOivfSPZ5gNWHe6WqzPMYWkqnOeGcE7H0IQOTHcZGtceGcL/Y/eE8eq4UTorMWkDvHa2Za2+0/J/fQvCs1g2OcNx7+B84v0SZTVN4PMw4Ju51Qt9isFsmw7Dvbk8q+tLC/h1spSBwJLvkIle8jh/6RWHGnTg2XhvORVmuPBfMDOSZ2qj0q3kSwG4So1JpdXQqmctw5KW5YvDd4eGboE1DEPe1rFy/JUFuL4WqPJ6r6VR5beuIoDmyI9vZokYseyybLvqpTRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clsHppYhFwm9fJOMx+YJnbHZ0Z6IDDztm0r+NBn9QI0=;
 b=AF2sVDx30+WxeQqJCLb/EVSNMnVHjsk4VcVZl8/y3qfGj4SlpNEWuh5UM1RCluGwYtOt60snFUlCC17mm89XD06AWdz3N2m2bjlywB4JOD7Q5hzXJRIBjaUyxqCMoUELOJ8JPEyPt81urqI8svnbcuhOWRx3xyrj8xUc3I4UujqSafwv8vkCHPFbqOtX+t0R5F4YYZH2G5Z+m3NIJneLgEioTKT3jT15luKvwd/8oI5/HyRrA4du5g3rgmNGTztkRDu0pWOMJpLulUmxIcajRtTAm1M08BCBKOomvaSKmvesyqkqEyACoBbyftxY4Hg43j4nGh0oRP+CLFf/YGCKwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:15:36 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:15:36 +0000
Message-ID: <6b7213e9-6f62-4878-9a6c-3bd8855a2d43@nvidia.com>
Date: Wed, 11 Mar 2026 14:15:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix ignoring PF representor
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20260311075352.266692-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260311075352.266692-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 47171d65-ee67-4866-e91a-08de7f67e68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wyZa3I1+P6rEbSllOoz6PokHZB7c9nqVm0mPWYh5CPkJvkQeAxCCw2ajfd/mEYjUSBV0b2aF4kMRyX5Cf6dU5MTN8XpdtIKVGO6R1w3sD+gLJrNgBp4a1RX46hOxv3/1POgjDP9N6GR1p63W2y/6DeuozoFxN8E5BmNlNvd0rvWIVzEAul5I6rFJXkJRrqSYCrDIcRiTWpQ8zonb8bI2iZei6rsuX+JA4RQxunRVuShAqZQgUGXISzidpf/jjCr3K+TsmgAz2UssANQKRFFeqcXX+4NsYO2w2aBDO8RovUfn1uGoNn++vcbRy/ggm5aBxFkWHY7UP9EnqrgxUyNetwM6KAMr0ZpYL7eILK6zrw4QsxTp6Y6+GnMgC+40GNKb/8dvFULVw/j8GD1FTPPyOeYtut164xdQhq/kI8N9Uf7GG9dvK6HL1kw25hjzCzgsNw6VTjIgNbMS58N6fPMa99rParVgBXoF5mB7kSY9mp7vUqbcvykBE5N1M3/3r4eLdVaxqIIbq6O772svjdcgmWE+H52Pr0+SmeiGavD1xpDDhX1lxNvnqOsFwtZh6+/aQ34NGWMjVull13iGKW/xzSKCPozI8UQX38VbygJXPpCITDV9589+m2871yPrpYfNS08l+0tfVhufKX4N++mn6tzC4USVeYxkiQmfVwdrZOLtMrpQdKIdRsmePwhAsPQBHcJ1t5c9UvnA/tQ7gIoSiUfFx5njrFl1tC5c6fY9Vng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFI3ZFFoazQxM0VpeEN6dGkyM0EyRDJGeU11a05sTUFzS2lOTGFrVTRlbnZJ?=
 =?utf-8?B?UndBcmZvaE95Y3RDUTk0NllROGhZVGFvcnFrdEhpM3NIb3R3S0hTZmJodXlt?=
 =?utf-8?B?UWIvd0xyRStuN21yZ3Bpb3llL2dReGhJK3RSQUIrMUFVa1U2amNxRVlvc1d3?=
 =?utf-8?B?VzhHWlFHMm1wUHVnU0w0REN3YTM4T2pvUm1neW5ydm1SaXpOMjNOU2ZUY3FU?=
 =?utf-8?B?bHhoWXVpOTF1bExUU0gwZ1ZhNUVIazFjd21DR01lYmZNOTBvaG15OU1KRW9z?=
 =?utf-8?B?a3ZGb21XTG8zNlFmWGUzT0daNDI2M2VDSE5PZHp0bHFwTmZsNDJud0lsRmpQ?=
 =?utf-8?B?cEI0SVVnU1poM3Vubm1yajZUZTJESTFyL205eG43N1czcFdnUS9WL0tzSkt6?=
 =?utf-8?B?ZXNRSUM4b0w3QXBPR2F1dXgzTTNBY3lHNHo4SzZaTHNBQzRQZUkrM1FuUUw5?=
 =?utf-8?B?SGFEZDdLN1FBSzduNGxzM1dUYVp4UVZocnFkOWkyaFdMRzNlSGlIZWI2amxs?=
 =?utf-8?B?a2VZYnJ2b3FWd1MxYldvN1JzcmxRY3BwWjBPdHNWWFdaOHZSMS8yOG90YjZm?=
 =?utf-8?B?a2lCT2VVRjJXd1pPeUpScG5ENkhLb0RJallGcndaK1NlanR3dEZaNzRkZ3pu?=
 =?utf-8?B?TmZmSkVkMS94YUlGTDQ5aDZzTjlUaGNUU2tjMDJDbTlJMVVpWHF6a3daM0tG?=
 =?utf-8?B?SHlHUTZGY2dTUnE2Z0hCSVo1d3pJZDh5THFBWGxsWldJTjBLaUxvM2N2Z0pU?=
 =?utf-8?B?UDUzSm5rZDczWGpKVjB6eGMvazNZUFpOTGV1UFVlZnBXaXZZMERkL3hkNEp6?=
 =?utf-8?B?eWZUS1BiRDRoaVdhUGJpelpPdEpBYzh1clNYWEJJNlJKdFFaNjBFT0E4dFR3?=
 =?utf-8?B?Z1ZVRXlyZWh5NHBscGFhaUtYQkJjd3FwRi9YekFzRDE3MzNTeStKYzZDd2gv?=
 =?utf-8?B?cTJoSVlQbmprZ3VHZXVvWHEvTU1DcWRvQmF3TGJsZEt6QjZpWWhvMElnazlY?=
 =?utf-8?B?c0R1b1Y3aDRJWWpMeWYwRFV5N0NDRnppNzc3VkNiaEw2SmF4VXR5ZGwrWGRt?=
 =?utf-8?B?dG1PR2ZuTGdqNjMxYmhXM0V6RVovejN4dmFtaHY3bVlOMVZUa2hBd1Q3K1hG?=
 =?utf-8?B?U3FVTXY3QjRGVFdna0NnUXoyOFNtcCtZZ1RzN1hQVDdmQXkzcTRBRU9EODUx?=
 =?utf-8?B?c1JXaUI4OEY3TUtyS0ZlRmR6ekNHMnFNNTdzaFY5WEp5dFhUVExMcXBsZmlW?=
 =?utf-8?B?bDZBeEozQmN2QmdDaXFvZ1ZnM0tlWFJ1MHExN3FPNXU4VzVFN1crcmo2a0JF?=
 =?utf-8?B?UEJadTJnVkk4VWVwK2s4cjRwdzFuUk40emNSUy9wVzRrbGJJR1B0VlF0T2ZO?=
 =?utf-8?B?WWtQNXJCNzd1TjdFYVRKQXZFUFkzYmtBd2h1bnd5QmdlK3k2SGFtNmVHVXF2?=
 =?utf-8?B?dXJFSm52dTR5MGxrTC8zdmgvbVpWa0oyZFBINzFTNzlqYytENCtGR2YydnJK?=
 =?utf-8?B?eHplMmF4VUd0NFNHWXpWZnhWV0FTVnYwd0ZidDhkSGdueG42aTgyWHBtdmE2?=
 =?utf-8?B?UEplcEF3TkIrSzdmdnZVRFd6R2VqSkhhQW5ZbXRhOW5zbnA3SU9VYzZHTUh2?=
 =?utf-8?B?YW9JNkZadG81VVJhaGI5cEJJWC8xNHRsZ01LT2J2RzhQdU45ZmZMY3Rka3Bv?=
 =?utf-8?B?VDVnNDZrejMvZ00xclQ2bFV0ekhteG9Ea2dUTU9NQ2ZpMnlZbGl4K3YvSlgz?=
 =?utf-8?B?WFRPODA1a1NBb2lpYUhkSmV3ZGN1eXlTMlBRU2NWb05RKy9ycmo3YmpNb2V2?=
 =?utf-8?B?WjkyWjZ3d25RdVlJd25SRHRvYkZhaVhtZ0JkWm1iOVNlVndFNUdFeW9MK0to?=
 =?utf-8?B?SUVxK2kyR2x1MXNyditLR2l5d2lSeGFEMFZxMW8vbEhXMUxkWWdTcmN6djBD?=
 =?utf-8?B?S0ZTMGU1NW9NYWJVWksrSzhzakNHTjhldEd0MkJkTTBpM3poMlk0emNid0Q5?=
 =?utf-8?B?YmE2bDNHbE1GM3BHTC9keTJ5RWRvQ1hsbGRNN0dTZmlRcG1RWHJ2L1lqckFG?=
 =?utf-8?B?YVJXZTdtRkZJc3JtRW05RVRHRUVvOXIvcE93bUI1Nll5ZmRibTJjeTBIZFZJ?=
 =?utf-8?B?QmcwZHlvMlBzM0pmZk1weUhJMm96YzI4bzlhZzVCTjFqNW5qRTEvREdPUnpU?=
 =?utf-8?B?ZUFTK1Z0ZjNSbmZvTHJQcFZ3N3JRMXVyRkE5MVF3bDltQlo0bVNlZmdWMEtO?=
 =?utf-8?B?T3NsUGZ1ZUdld1NKODZXQWtQY2lMZzg0SkxJTEZaQ0R4cGhyS3NFTmxGMHhq?=
 =?utf-8?Q?+xHKNaa3Nz8eMI82RB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47171d65-ee67-4866-e91a-08de7f67e68e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:15:36.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKW5jjmFhJQv9f2NvXtg1HOyPbEyn44CPSOOGE5P2bbEG3BlhFiybTwC+VL3jBG5yOsR3xVvdC4HI33g1u4VtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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


On 11/03/2026 9:53 AM, Dariusz Sosnowski wrote:
> Whenever a new set of representors are probed by mlx5 driver
> on Multiport E-Switch setup using these device arguments:
> 
> 	0000:08:00.0,dv_flow_en=2,representor=(pf1)vf1
> 
> mlx5 driver should create 2 DPDK ports.
> One for 1st physical port (transfer proxy) and another for
> PF1VF1 representor. Parentheses are used in representor argument
> to indicate that physical port related to PF1VF1 should be ignored.
> 
> Offending patch has introduced a regression to ignore logic.
> Whenever mlx5 driver checked if related physical port should be probed
> and if representor_match_uplink() returned false (as it should),
> this result was ignored and probing continued.
> If requested VF/SF index matched PF index, physical port was probed.
> 
> This patch fixes that by adding explicit rejection of spawning physical
> ports for VF/SF representors if checked port is a physical port and
> driver have not already spawned it.
> 
> Fixes: f363bbe2c036 ("net/mlx5: fix probing to allow BlueField Socket Direct")
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch squashed into relevant commit in next-net-mlx,

Kindest regards
Raslan Darawsheh

