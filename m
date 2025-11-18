Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F13CED617
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7AA40265;
	Tue, 18 Nov 2025 12:31:53 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1B2A340150;
 Tue, 18 Nov 2025 12:31:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWrSDuhbpQmdFitqXTRUPu+GMvIZ6wo6Ej8T4O3SMrC6Dd/ZkEZGX5RuHv3yvXX4rqVUv2z8Rv9ZXn7y6pWSUNxm9BGqj74NjRmFDoVK5bkIt7W5afAH5Mu5vmWZw335Mwjv5HnukD7nRA2JABc8Lh05D6RTUVs4Uk/ipoDXTGmFZPQevDgGWQQsNw1tU9nmh6z47nTZnf62dMskQqw/DusC1NIQMBQEzwxVvbaPV0Poy/2cwthe0BUbTUI05qfHbtbR90oATPfE8GZHSIBLJ5HtkNdT4HbpcD/OkO/6NDYG4ssgRjHGntF9b4BWKojj5pgR1pgQM1LSxM48M2TB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvYD8RxrcNHyGgwjESpzdWdD1XP4zDRjmuaGku5H7JE=;
 b=w46Y2RvP8FJks8d08iTOXjrjPBvOXIXQ5gD/pMPDYtwcE3HT+hQoCP/X5UN7BcWzimUenPEKQ3LlKBI96MCEultYGFCfrpJ16s1EuQXcWEGgVRISzK5hAfUqt+buAEI0UxJI2hoB7elOEvbs5AhlWRPbsaYHt4t/2jfEway3n+PYtt52ZQAPUN5jWqmJjtPhq+SboKdmsqRV7o5vFGnfwYcWzqlvVCAN/9gA5UV0TZzM2KkG2xnz4e31LGmNnlzTK1sDWdJIF1Bx2afsEubCQa68UdJJK32xIhdefb0Ohg3PlHqzvDfQTjSH2kiWE4ygCV6LGa3xD7VJukoCzejvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvYD8RxrcNHyGgwjESpzdWdD1XP4zDRjmuaGku5H7JE=;
 b=V5Mbuw4rhKIUjI7R2BLIwyso1V17ipK/LuLZiuIIsEofSm2m5szyAhnDzC7/WjScBy8bif2AWAJuzFCmJGXAKP3cPE3tKnfwNxh1NwExU5CIFGzC6fbM9qpU3jIxoVeZVx4bNE/X9Z4lG3yBeRj+cqOUVA3CVlv0shJHnLtbVrkugqYlyzWmgwWig4pO+0PsseecTp3nB2ZlRFOY9WM6vinQR7WQx0t+2bp6kfWNeCOlFiuS7UA/yWEet5e9AMocH3i7PVXdLxCNFm4rf51iaBRHd8nPUC2qIhTbM7CzHJ9WO+LIW6X9osmQ7A+vVhsWgIUxUwI6+cLz16prIYRRSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:31:48 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:31:48 +0000
Message-ID: <0c792f20-a091-478e-9ad7-0a004948c473@nvidia.com>
Date: Tue, 18 Nov 2025 13:31:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix segmentation fault in flow destruction path
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251117071536.205328-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251117071536.205328-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 471a754e-4de7-482d-0318-08de26960f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnY4QklGaG5GZVkxNFpodW5GMGZWMXdFaGRXcVZCaWtIWFBzZDJ1endvRTlq?=
 =?utf-8?B?NWtVQVM3OE1CVTFobGJiS29uQWxaUDRYRGNybTVrdHYzY3loeldLVm9ndHRN?=
 =?utf-8?B?TG8zM3dZbmJRcVFaQWRMVUVpU2RrR0tEbnZoVU9PaTZBUDR2eDRibFR5ZlYw?=
 =?utf-8?B?dnhjSGZBU1ZhSjdhZnByRjkveEp2ZldFdklDOXBNcHV0NThTbXlobmFZVnV0?=
 =?utf-8?B?ZmhXTTA2Z2FUeUVoaDJrdHRWUlBMeDF1RXgrMjJyU1g4c0lKcThSbko0aENq?=
 =?utf-8?B?bUZlWG5DUGRwMnJ3YjZLTFRrc2xyODRTZWFodEtvcEkzeTdTMlh3SVMzTjA2?=
 =?utf-8?B?bDltY3VlWU92UU9sUDdjVFcrQ201TnQ2eG4wU1g2aVdZYy9OU1BsYlRhTzJw?=
 =?utf-8?B?YUczVXJrSlIxUFhycnYzeTR4b0RGRWdlRys2MitoQlhJS3J6azVrMlNpY3RD?=
 =?utf-8?B?TUNEY0JEZ0lLR2dOMGNZWXpzamd1VWlJdXdybzFORXFHRmNEUVZkT0FISFBj?=
 =?utf-8?B?bzJzeFMxWWtLTGRCWjB6eFVGRTlOWFg1U0RvNmhTbmlxRTg5aFpqU3VFZWVt?=
 =?utf-8?B?MGxTUWU0UXlXcmhPYUpzNzY0MWRuRkhRR1BvaU1nK1FBUTZLUHFqbmx2di96?=
 =?utf-8?B?NU4xR3NHNUhpdFpyN0xWVXJzTFlERUFsTDNGQ2Jub3c0Q2hPVGxGWC9WODIw?=
 =?utf-8?B?aW9KZmJiS0VCazU3YjN4WDJaMThtMG9XTXVPdXIyWGRUY2hwbDNnU2x5bGRq?=
 =?utf-8?B?NjlqdFVzUHlXL0g0d3JVYlp0cjFSTWdHZTE1dnIxZFhNQk1KNVZLQWVDcDRI?=
 =?utf-8?B?UmFENGZVTE1RVWhQQzdkdTRXNnlYcXRybk9YeEhsa1QvRXJmakpYVEdGdWly?=
 =?utf-8?B?ZnVyYzMrMkJhd1dVWGxxREdOdFVLYmlWUTVhcGlQdTRzbWpkdVZZeUx4WGgz?=
 =?utf-8?B?WFc1azdwSFhSTHRwNlVkNDZjajdmalFvVFFqbEpFbmc4M1gvTGdMTzhaN0lI?=
 =?utf-8?B?NVFqdkI0aUNBbEh0YXFaWkg4dE5yM0U0azA0OElvekVtQVVrY2tPUGh4dnhR?=
 =?utf-8?B?aWRtMnM3TWUvUERDejA2ckdtTVJyNWtFUGw4QStvT0dhZGZvVnlwdWo1eFp5?=
 =?utf-8?B?NTB1TDc2Y1Jnd3NralZOazN1Mzc4YWhjTFR0TnVtRFN3ZkhWcW9UdFp0UTVp?=
 =?utf-8?B?cy9GWTJzMzVUZTZlQWRjdktJV2RkeEcrcXBFK1lUZWM3TnlYTmlIV0dZdm43?=
 =?utf-8?B?ZW91emk2anNLUW5ucDZVY0dSTkZQY1pGZWhSWDBiZEo1MnViQXY5WlFxeGtp?=
 =?utf-8?B?cmFINEE4TDloZG8yL2RSYzkvV1pMTEZjZm1FdHMzcFlLOC8wZFJYOXNXV3Fj?=
 =?utf-8?B?YlRLc1lkYld0MGZRcGw2QStRdU5oeGdBaHJDK3RFSFNreFFaWmxneThMWjRo?=
 =?utf-8?B?aTZKYWpDdHNLOFZUdTZLSnk2YXpDck1HV2hkek5ITE9HT29MUDFIdG5UeGJR?=
 =?utf-8?B?SkZQeHNNWEtvZTR1dzVNbVBjYytJODVJbmV0OE5pQlE5L2VXZWR4YlVrb2tk?=
 =?utf-8?B?bVZNd3VzQnFiN2RSTDh3eUFFQ0RGakxCdDVzSFhjOU1ZY3R6RlplNzlrMmxK?=
 =?utf-8?B?TlBkc1VzcXhPWEVBcDlBN0xOOVRvemlpQk5pcnNGblEzR1Q5TUNhZHRLU3Zo?=
 =?utf-8?B?eUhKV2JhdHNGMm92NVFxQkthcW93QklVMTNINTIvQ3ZpSTNOU1N6Z00zOURr?=
 =?utf-8?B?Z1BnTTkycXZqc0Y3N2ltdDRtUzB0QytEQVlMZFFoeDRSTS95UWgzQTZNREZJ?=
 =?utf-8?B?cHFGRE1pQmdmZCtTZzZ2SEJYanBKb01kZlRleXFoamdxemNIY0tTRWI1Ukxt?=
 =?utf-8?B?Mk9oWDRncFJSUzJZdFQ2UVZ1VUUrT0pEYmJqbHZ2VmYyRFRHRWlwVDlJZ0x5?=
 =?utf-8?Q?0oRjz2Rcw66sY0aI6lDbVofbhE1HOop7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhoV3JBbjd5U0xrWnBINVc0TmsyMHBYVWNORmdTTzZ2ZTZNWW91OFgvWkov?=
 =?utf-8?B?cTBqWFJyMksxdTNtZWloaXRES2ZNUXcrMG9tM3YxNDEyWTlpdFY0NUdtYnd1?=
 =?utf-8?B?SWFCRDFWekNRbFZSbkpHN2ltWU4rZUJ5dGxEVjBDdGhQUGVjd0VJL3VqcnZ2?=
 =?utf-8?B?YlE3VnVUVndzRkg4RkRabmFsZ3VoZTErT1lUVThKcjc0S3kxREFsbDg4Slhl?=
 =?utf-8?B?T3k5enZsbFVMaUNBM0tnL2tyenhOd21TY3pKV2RySlRnSmxQemhFTUkwejZZ?=
 =?utf-8?B?eFNnRGxrUGQwS1drR05STy9LZG1TdENRaSt6QmJXOXpVQjBEWGVUa09aYUZz?=
 =?utf-8?B?SjR6UWlLSVAyRExadkxmUGo5UHl1Z3NqdEU3STVTZ2QrUjIrSktERU4xR0Fw?=
 =?utf-8?B?ZjlaUTA1dTcrMlNLOXJWZFNERmg0R2FuRlN0ZS9PekcvcHFSamtQM1FpTHFt?=
 =?utf-8?B?aVB5ZTJWWkthd2JJSGpmOXNoblhmVEhTdnVoUzQ2UTFBRHM0VmU1RWRIelNj?=
 =?utf-8?B?M3N2aW01cVkzeXlZL3JBR3NNbzFsbkF0TkJCZlVXaDZ4NE9XZm1BZlNkQlJq?=
 =?utf-8?B?UE5ZVlEraS80b0JObTRxT2Jhd0VHVjRTdkxSQXNrN2lJVUtZMnJmM2VkZHh3?=
 =?utf-8?B?TWV1b1NjTWIwTEh1b2FiQTZzVU5mYzhhTENKcEdvOHpVMWxZU1FpVFZjdGZI?=
 =?utf-8?B?SUhnVnVqb0VPbm0yRWhRYjZwb0R6bUcwb0JlUE1GZnUreFVUZlB0Sk5PUXRz?=
 =?utf-8?B?MTZJSjJ0bkVvNndib2oxY0JxNTVGRG5hdzAxdjFsM1ZyVkVKL21PQ1pTZzJM?=
 =?utf-8?B?Q0s4bFpaeG5iYkR5THNZRUhFSnZrdWhrOXlTbU5GbDJsaTV4K1lSSnhHM1Fl?=
 =?utf-8?B?Q2hGZVVwaFBkYlZFcllEVTlKOGs0SUFtMVI4ZjlMeUlHS1IxSlJ4QTlmOEIv?=
 =?utf-8?B?dE9Pa1RxQkxseEtnbklORkxWZ3FqSE5yK2ViQVBOZHVud3hDZmpGYUt0cFdt?=
 =?utf-8?B?cWxxZUFHcHdnZDNFdnUyNjVhTXFZcjJoMmMwcnBoWjNBcWhPZmFDL1c1TWZP?=
 =?utf-8?B?SStQTmd1RlZabGVHdE1Ja2E3YXFZTjJDbHY0SiszVCtvS2krdmtVeE5OaWgv?=
 =?utf-8?B?SHVuN2pxY0lGU0VKZEVWalI0aWQ5OVl1NVdTWGdra1dIT0J0aUpJRzV5dk1F?=
 =?utf-8?B?SkZ2MW4yWW11dXUvQUZWRE5ZSnkzc21OdzhZZER0QzdtK2ozZ1Z6eVQvUG04?=
 =?utf-8?B?SitFSFdXa3NUWnRUR1lvMDBicXdhVGNFT1J2c05kU09TNTZQY2lRR0QveTFh?=
 =?utf-8?B?OWkzRXhHS1Q3cnlyTUJ0aUw0bERBRzQ3SGtMcFFYdXcrZ2d3MEd2UFZoNVFH?=
 =?utf-8?B?Y2xiV3F5S09BY2Y1T3Q3MCtucHIrTDdLYi9md3NjVUZ5ZGJ2anJmandtQ1VX?=
 =?utf-8?B?MVhZOVBjZWJIREVRRS8rcEhRODRscVlZTFdwMmxhZFpNTm1mVG9Oano5WkdV?=
 =?utf-8?B?bWhWMVhUdDFWTk4vVTJFOG9tZ3J3YVg3dThtOWZpMGNURU9WWkswV0loNXV3?=
 =?utf-8?B?V0RmNlRXcjhud1cxNHdpd1E3T3U5YmxCWEdSK09CMTY5TXEvNUNYSVllTFU4?=
 =?utf-8?B?TDhyTDc4ZTFXRytVMDZveHE1MFBrcXhCNVRaUTM2SVgvNWNFMkoxUmNGL3hy?=
 =?utf-8?B?WFk4SU5ybUNBdnJsRlZuVE5ydDVaSC9WcFNqdnRXVE5tUWNHWVpYYzRaZHRU?=
 =?utf-8?B?WUt3NDBxZDJNTlpVZTM2Y0JVMjN3azVUTzZuZk5aWFI0YjNkTXJpenkxWGVm?=
 =?utf-8?B?amdPM1loRFpETnB1UFNhdmpXTldtZG0yaTBaLzdTMERDNGtVV1hTNE4vU1hH?=
 =?utf-8?B?dkFOOGxBNkN2K3JPSjBSVEh0RmNIYjZtSTBYblIrNHNEclJZY2Nxa2tFc1FT?=
 =?utf-8?B?UXlxOEpTM0JZU2pNb01yYmVxMUpvOFI2Tmg1SitSZVNkaytBOEFEL3NCNW1R?=
 =?utf-8?B?TmxDMWZPTWxNUU1nY0ZYbEtkWm5iQkpyRDNOVmQ4NDVMdmFYaXRPSkhnWHgw?=
 =?utf-8?B?MkFtRXFBcjFYb0NCcE1ZS0R2aFJXdlpidUxxVjZPMlBlZnJOWlVlYXlyeGtR?=
 =?utf-8?Q?lDI4lPUDq7l1NytNamCm27R4i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471a754e-4de7-482d-0318-08de26960f98
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:31:48.4078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7TkoBAhW2fNbv3bI22Lj1/F6/btkcpL0de82pcBpMC8wi7b48IkUOm48sZxXNfQW1INfIQbjb7VbmfzTcn8wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

On 17/11/2025 9:15 AM, Maayan Kashani wrote:
> The mlx5_ipool_free() function was called with a NULL pool pointer
> during HW flow destruction, causing a segmentation fault. This occurred
> when flow creation failed and the cleanup path attempted to free
> resources from an uninitialized flow pool.
> 
> The crash happened in the following scenario:
> 1. During device start, a default NTA copy action flow is created
> 2. If the flow creation fails, mlx5_flow_hw_list_destroy() is called
> 3. In hw_cmpl_flow_update_or_destroy(), table->flow pool could be NULL
> 4. mlx5_ipool_free(table->flow, flow->idx) was called without checking
>     if table->flow is NULL
> 5. Inside mlx5_ipool_free(), accessing pool->cfg.per_core_cache caused
>     a segmentation fault due to NULL pointer dereference
> 
> The fix adds two layers of protection,
> 1. Add NULL check for table->flow before calling mlx5_ipool_free() in
>     hw_cmpl_flow_update_or_destroy(), consistent with the existing check
>     for table->resource on the previous line
> 2. Add NULL check for pool parameter in mlx5_ipool_free() as a defensive
>     measure to prevent similar crashes in other code paths
> 
> The fix also renames the ‘flow’ field in rte_flow_template_table
> to ‘flow_pool’ for better code readability.
> 
> Stack trace of the fault:
>    mlx5_ipool_free (pool=0x0) at mlx5_utils.c:753
>    hw_cmpl_flow_update_or_destroy at mlx5_flow_hw.c:4481
>    mlx5_flow_hw_destroy at mlx5_flow_hw.c:14219
>    mlx5_flow_hw_list_destroy at mlx5_flow_hw.c:14279
>    flow_hw_list_create at mlx5_flow_hw.c:14415
>    mlx5_flow_start_default at mlx5_flow.c:8263
>    mlx5_dev_start at mlx5_trigger.c:1420
> 
> Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,
Kindest regards
Raslan Darawsheh

