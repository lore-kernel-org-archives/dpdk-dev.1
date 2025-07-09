Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3157C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 07:56:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E094E4021E;
	Wed,  9 Jul 2025 09:56:23 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by mails.dpdk.org (Postfix) with ESMTP id 2F7CE4013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 09:56:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYCtHEmKghjWepFUlwUtpKCkZgRcT/8EIpiSYjViVUkiB3gVdds23Oz6ZChzZCgsTw1KjAHGTAoS4mM/AACXifbugLdZW49Qg/M/ABSoNNVEZHlHFfjh227PwBdeu6KDrj6LBvAqe6XXzG/wz8bL5YJyxrEs55sc/pajjaquV22rtEHHzVLz0+Vj/Aua6syqC83KZyx2Zq4yZE0oFxKZln6uW/+OF8V99gCOqO+nAjY5wPXPoZLPoRUgMCEgRCZ9doSm8FjbCYL4oImsvEGRB2tG4/aKc0TdoFT0ApC15Tf7rogc0wFiQ7bmPZkmmWiEO5tSiro7YecukXCQ5Axl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nITx26I63qkQadG/Qel+yXIEEXJepJ3zMYlqK2EjwQk=;
 b=o5GdaJrowVJKRSNvEdg7AMwlMKnIN4c0muXex+2kCaw8xYzKAajoNC36kB/BGjguGWcIuUzTPITZfuLFygC6N1Bn5gGp4RnCpWwziDHqCC8mMYspc7WqhlI6qIuD5eNz2stvk9m1EV6P8nn3L3AOtQhKSgI1KqGHX4tmxlBiNfgtJmMtVIouZ80qL+OCeODC9MMEHd4sH0RlgCUwKzrsCBmhwKhRv/3OB4m6tLle8wIeqm/x1eRQJDN81ji1WZbUpvKuGxzcZLQR/Vn4DzA75lB2z2Ij7QjlSEFBHSEArLN7PfD+K9nh9NeH0cIuBIl72+pms04hDYT3+Ud9+cqK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nITx26I63qkQadG/Qel+yXIEEXJepJ3zMYlqK2EjwQk=;
 b=jzcfcdX32O7s65m0f5XFHpoKDD6wwZrUWUONRFoPKP+LKGN+bJ8Y+VFLopSb+V1c02FfpNARdGrJy/TiJCS/LDp7IvzJxHd7JdnciHpYJ8tO236dSRMvH/57YJ18TCncbNmMqg43HDdI0myx/O7oIipoKNd1jxCzxmWu6Qy4Bx7t99cZXKEJ+TUraradG24vnYNudZW3TMeBC8CQSIpMY9iIp/zcC73LrmAc+M4pBDueVWOQo6z5JMc6o2103ijPIOyA/SSiMkLmO3BiuiG0C/877vuXfiK8UiRU22dLv4TtDtU8oKsP6ENhP3dtelxXwCPpGGoC7oFyQKkUrJSw2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 07:56:19 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 07:56:19 +0000
Message-ID: <8f050ac5-a909-4e8a-b647-252fcc757b63@nvidia.com>
Date: Wed, 9 Jul 2025 10:56:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix the queue length checking
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net
References: <20250709040000.112338-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250709040000.112338-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b734bc7-f945-45c7-8a49-08ddbebe16dd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk1qM2ZKN0R4RmlLOFJJOUF5WXRKUGNvcElXZlA1Y21paHZ2dGhWdkRVMlVa?=
 =?utf-8?B?V2l1ZWhEemEzUTVIMU1tRWZ1VkRhQlJoYTZGNHY0WWdpdm9rdzl4N3NQN1d3?=
 =?utf-8?B?RHBCR1MvN1o4N2R5ZGc1UCtmUGg3ZkIxZ2JiejdwUWtjUUwxMkdnMXNmcVFp?=
 =?utf-8?B?RWZsY09obkdwaHVZSUZKWTQ5RVdUS1RHbUdnRVBBTlB3ODN0ZVBiK0p6VWxG?=
 =?utf-8?B?allvamNEd3JMMnZKU2VhRXUrL3FRZVJpK2x2d3ROaFFETFRpMjBDME93Slo3?=
 =?utf-8?B?bzB5M1FHYmpTcTlZQnJpa3lNMFpmRXRJeWJZLzVrWkIyNG1nd2xtZXltR092?=
 =?utf-8?B?KzQ4My9sQUhlM1hOcDBoRzN1MjN0SytIL05ZQUN1NzQ4R0tid2lZYWNpc3h3?=
 =?utf-8?B?azFKRUY4MUNORDBFNWxyNytPdmRSZHpiMkQwbFhHa3hBVEVxeEU2alVleVF1?=
 =?utf-8?B?NCtFSkxDbkZvcjROYmMvMDNDRFZsRVpGSmNzT09xcUlIT2pkL3FCbFJsbXBV?=
 =?utf-8?B?bmRDMHUvM1hMRkcwMmduaFpGTlRERG1aS2dVOStLd1NpL1RVb3B1ZEFFRWF6?=
 =?utf-8?B?ejRaeUNvM3owazI1SGJHNkQ4bXplTWhERkVrN3QrbUlPSHlqcDRQNDZWZE9r?=
 =?utf-8?B?WDYvUDhLTjlwUEg0SjdxQmIwWUJMdllpYlIyVHRYcTFnOEFmeDY5cVJhZmV1?=
 =?utf-8?B?NkdnaE12VzIrZGFXeXQ5NG1NeVpCUmJBQnFaL2JuT0traFNrMVZXRUJRQUEz?=
 =?utf-8?B?ZEh5cGJsdWQyQUd0ZGpkZGN1VTAzQnlhTFV1UFZMYWFCKzVQRUNqbEZNekVN?=
 =?utf-8?B?b3ZSbEdFQU5TT3BXWFhzN0g2bnJTVjI2WFhkb3lLcWo3aUk3S2V1bTFZVktM?=
 =?utf-8?B?cldMVFpCTWxLMW5jamRBY1BBMmo5K3pxbEd5eTlZTkl0YXFZWXVrNE5IRXlB?=
 =?utf-8?B?NUVuQWFpWHdpcHRWT25PVld0REZtOHVKZ1h6cDJNNFkvQTNRdzNxSHBvZWNn?=
 =?utf-8?B?YkNNVzVNTDNOQ0dnbk96NmVFNlFNd2VFZDloY2pWUWVJeTVmNGhraFQ1Wk5Z?=
 =?utf-8?B?YlNoU1RJMUE5eUdMWVlvNXhTR0E3Z1ZqZ1I0OXJDbEk5Z1QwWXNHL0E4bjNl?=
 =?utf-8?B?bFA4VXd1TUxVVU04Y0Y1YVdxRXN3bTgzS1Aycll1d3E0dThxdE81Z3R3dzdO?=
 =?utf-8?B?M3hLVWkrU0phd3Y0b0p1OGFXNFFGR29xTkRKREptU3UrZzRNeVdrc1JFNnY4?=
 =?utf-8?B?bTNiUXkwZHFxRDhRVGQzMzd4MGEyYUEzdkg0K3lVZUlyUUJsYzRWWmNaWHRY?=
 =?utf-8?B?bzBWSWF0eFRDaGJueVJzVzdKclJrMHBSMnNlS2ZiL1ZrWnZmNHNpOGgvMzdZ?=
 =?utf-8?B?cGMwKzBEM1o4TTRaRFFkMHcreXJLYWRSTlFQUmFlRFE3cEdNS2RETTFjUVFR?=
 =?utf-8?B?OCtRNzBESDZGaTFlakdvN1poc3U3anpVWUpNRVFNZXBpS0lueEtjSlFMeUVk?=
 =?utf-8?B?cTllZHZmMkREeEJkQ2VMQllJQTIyZ2s5bWtnMTZUOTI2aHk3QjE4MGI2U0pG?=
 =?utf-8?B?Rzlieit1REZVMm13N2dOU3VxbkFBUVBxaVJucngzUlNUdHR3WVE3NklCalFw?=
 =?utf-8?B?NWJEWGVzZmtRY0pyNVF0L2VvY2syUjBwekQ1N0dGRTZOa1N2cStPTlErUzhB?=
 =?utf-8?B?TXhOQjcwU05zVmdOemZMN3NBbG9VV1h6UXN1QVFvTGNDMHQxeUxIczdta0pH?=
 =?utf-8?B?NjlucmdHZlJXbzlvMDF1TTdWTnFBdTFDSWQrZHVsTjB1aEdvVzRzREFCWU9n?=
 =?utf-8?B?WXdSTDlWdTFSWG5nRllLSTdjUzAzbmlmeHBQei94Ym0yL01Rb0ZXNUdEZ1Mz?=
 =?utf-8?B?MU5DRGFKM1BSdTBPVE91Z2tseXFuQ2dtOVphZlJIVGR1ZVplQWt0T3oyZmt5?=
 =?utf-8?Q?STs0NMW6ly8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtNWjBUdzlWdTdtYU9PYjdNMkN1YWZmbktNWGw4RGIxQVA2TVg2YUk0bjRL?=
 =?utf-8?B?T0JudTZReHMzK1ZGcm5CY3RjeEtjOGxwYlRiWWRMSzZ2ZFNiZTlhczBNN21B?=
 =?utf-8?B?Y3E0YXZrUmtEQ0RtQ1djUU9nYXRHR0xTYWQ4ZEl4WmFpY3pzWVI2UGdxaHIz?=
 =?utf-8?B?SnlSb0gxLzhDQXVsSkZwRGZRMU5FZVlrZE1ONGVIay9IYVpzSSswbENTTmtt?=
 =?utf-8?B?NzhMVkVwU2lZNWZUdlJwY2ZualF1NnNwQWZ2d0paWFppNkNocUNjM3p2YnUy?=
 =?utf-8?B?Y1lkdWZwR2lWQ09TZXNPNFQ4QkRvVWl5UlpZMlZmSUdiUSt6OUdwVHZKQjdw?=
 =?utf-8?B?WWtUVHVZRFdMOHVsYnMrRVFHN0h5TFFmWGR1OEZlNENYK3dseUVIa2l6TlNB?=
 =?utf-8?B?b0ZuNDVpc1FheVNsbHFaZEI5TVJ6aXd6ZDNubTd4a2pIQUZNYXlLbzdLY2p4?=
 =?utf-8?B?ODYxa0h0cjNaeGFIdm5BU05ZUEFHcmNRRjlTc2VjejFVTVFDVlRMVVJpWU5l?=
 =?utf-8?B?UnIrM3Frdms0aCtjVW8zSWNadnZ1WVJkRjZ6STBQOFFkZllFSDZNRE53aEl2?=
 =?utf-8?B?YnVkOHBkUVN3cjFxc2RwUnlHcjg0TjVidnJselkycFIvaTYvNmk5a3RzYW9p?=
 =?utf-8?B?Tm02SHBLbEtPKzVkdGtDRm40alE2U1hvS0JZTWVHcWhJbGdoZmZnOC9DeHow?=
 =?utf-8?B?OTd1b1VybXVKdkI2WEFSK0paejB1UXdtVWx6c25rQ2NqU0ltK3VFVG9Tb0di?=
 =?utf-8?B?ajEwQVhtNzh2My9SM2FHQ0tjNTVCZ3pXWnFhdHpVWEppSkc1blBYMFB0aUl2?=
 =?utf-8?B?UjBIaWVkWmxXNDVkVllSSkR4RTl5a0V0clF2YzdwcGVwNkM4c1NjNy9uYWhq?=
 =?utf-8?B?V1dhdncvS2k0UXBqbStPeVZ4QlNHd0lUTXpZRzRzVVpjYkRwT1JDeFB5bjht?=
 =?utf-8?B?Vzd0Q0U0WThyWDBYcWw3bFlDNHgwMW9LdTJUZ1pxc29Uckgra1JhazRUVjk2?=
 =?utf-8?B?eTJPd2VaQ1I3UGduM29BNmF1Zm1lT2ROUU9DMmVUcXV5TmZoeERBcEIyRmpY?=
 =?utf-8?B?SElaNFQ5QXFUOWdXeXJXQjE0Y2JycHMydTZBUlpFMnROdzdoeVNHeFRqU0FY?=
 =?utf-8?B?cVdIeFdpSkp4bG9uV0p4RGN2S2NWSzIzVVlITG1nSElOTE5Gb25sNTVLWUdu?=
 =?utf-8?B?aWs4eTlxRjhKQXFJQkg2RHZtMmQrcWZ0ZTJXNTZFM1BOMWJkMU5pRTIyTVBT?=
 =?utf-8?B?b2t6bUhNbEYvL1NxUXQ0ZnBrcUhuV3NLNUJ2SzdyZEoyU0NJUGZzdW9DVy8r?=
 =?utf-8?B?elRwLzhLUyswWjVyWm1NenJ1R3RaRjlwMnFSZ2FGWDhIdzFISUtkaVdBc3pm?=
 =?utf-8?B?K2dtZlFTNE5xMEM0dWYwbmY5eWpyNTBkSnJUbXk5cFUrekxoWVhzczBFc3J4?=
 =?utf-8?B?dThJZ1FtTlBldk4wTmtXZ1JLV0xVaG5oZ29jNzRrRXhnZFlIRlZhR2YzNk82?=
 =?utf-8?B?d00ydjV1NXNKME5SQTZjajhVZEN3RU5leTdqZ3Rhb25Hb3FJNXVHR3NWdnB2?=
 =?utf-8?B?M254T3RrVmhhdkdTb0tRVWRsQjhJR2REekNyVStwdHhuZTcrdWs1clN2d25R?=
 =?utf-8?B?T0tKeVpQTWpVeVRZRUNtQ1NIaFRJRTEyOVVHQ2NPa0YwM3RPdFZmVlZ6R1hC?=
 =?utf-8?B?WGxLVzhQWDUzTUdxcWNCRzFvVFZ0bVRYK1A5RGhtUkQzb1dWbDNTTjhveHlx?=
 =?utf-8?B?OEJqcldzTEZEUEJyNGRzQkdmazF3bWxmYVVtS1gvM3lPeUtVSkwzYmZKKzBP?=
 =?utf-8?B?LzVPbXh3ZUJSaW5NWjN6cTY4YXFJU0lnbmk1UmorenJ1Y1pBd1lQY0hzOTJJ?=
 =?utf-8?B?YnhldGlFYlFDNzRoL3dHbG5XYVVaT0k3N0gzbXVqekUvMnZJTEluR3BnOU1P?=
 =?utf-8?B?LyttZHdhdnBYZlJUVDhIU3VWdk1WRDFLRDl5L1ZFY2tHaFhTRmRCejNkUXlu?=
 =?utf-8?B?UEZlQkMvb0dTYm5ENmxCSkJvQlRQcFluSWZKalY2S2VnSjdUOUwwd1l1ZWtG?=
 =?utf-8?B?VDMrZ003NkJSUkdPOC82Zk5NcEp3WkZ6ZjZhYk9hNUpudGwwWE9XWWRyTTNI?=
 =?utf-8?Q?htlQgOZyqvzOuEeoneHqANA3t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b734bc7-f945-45c7-8a49-08ddbebe16dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:56:19.5794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jGv/f+ZcLduntLGlg/TaiGf0jThzALEGBtamT0SXKligZySClyEG7N931WO/QhcJfcdm8LLOAVYD0aMzBmbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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


On 09/07/2025 7:00 AM, Bing Zhao wrote:
> In the new consecutive memory mode of Tx queues allocation, the
> needed WQ length is calculated via txq_calc_wqebb_cnt(). This
> function is used both in Verbs and Devx modes, but in the Devx queue
> creation, the actual length is re-calculated / adjusted for the Devx
> API. The queue parameters 'max_inline_data' and 'inlen_send' are used
> separately for the length calculation for different modes and the
> counts calculated are different as a result.
> 
> So passing the mode as a bool input to adjust the calculation in
> different modes will solve the mismatch. In the meanwhile, since the
> memory and MR are allocated successfully before creating a SQ / CQ.
> So the error is not critical and a warning message is enough, the
> saved length can be used to create the queue.
> 
> Fixes: d94177339289 ("net/mlx5: use consecutive memory for Tx queue creation")
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> ---

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

