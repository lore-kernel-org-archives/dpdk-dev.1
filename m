Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D0C55175
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87D2440269;
	Mon,  3 Aug 2026 11:18:38 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37]) by mails.dpdk.org (Postfix) with ESMTP id D66D040269;
 Mon,  3 Aug 2026 11:18:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HATir+0Lnpvww+C6ez5yufpU8dJDUpCDVW5aICzWPCqOuLmXCC5p+XFFXULe7bLWjlrtpKawVK4Wf0BKaE9aMnmKJGio66CPC2dJDtOIovElJ10pvS6KwLu/7DHbhfRk5jbRFp5TRfktZG27Da+lp/FSoWKwfd83BW/eNvgW/paJwgivDQ9lOvdJEZAEBqAUH/eQuK724Q906SAZPJN6GBvxyxArbxSch/TOupYGweHFGBAKwXXBqy6eyVA+pFP/uek3F+0iJyCz7CrssfEEAWS8H6WvAHvmPUyiTlkSbE8qoK4uVElNKs9YlwZk1DY+w+Y1bKXw1VLMPy0BvMADzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN2DrCjKgdOE/KPVwlsLzoOtPcS3Nh5Cf9yY+jnTaFE=;
 b=Bb//18V9N1pcmP9eU3FlO7HWQQDWwxEAvEYPRnjhDhaUnU9vipk/WeykPm50p2j9+qC5LjZU9A28lGGQloRi+8c4dN83I7o4d5bESy5JBbUkNt1MbGgCRg3fXeU9FoE8Mzvr7KiQ5l6xGIJvgbmCTmg/XB3+a8Yy3d7NsY04hobaMCmzly2TvnPI83LG4095wYB5uhturRJ92E/cOGuTZXjXhzO6I7eQGDhkC4MYhN2oZPp4j80P9h91QtBUDGxR8KaKsKUHemn6uP0KR73+pc2qi6aCTHB7nh+Yc7Vp2ln1J5KSLc+RpzzNepZ4RlA2z6fj0wQkUp8jZ6+zX5uBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN2DrCjKgdOE/KPVwlsLzoOtPcS3Nh5Cf9yY+jnTaFE=;
 b=Jzb6A5E/Cgq/gtJ/jI+1dKtxvbgcDLgBiwerQIGye040f5UWnzH0oYYp+/ypDY9tgTs4PVsmxM72DylWcLJ8CjfB/iewfb7RZxnWZa10fj+1Y4St+P5bvlD1LrB3os51p5suDD8XtYE1TaKzP7mtIxbQEPsrK7rzAtDjoMbPtvKNbB9A5fANJq3ZwFZiuRtsGQE9SH3/qKx+jlm3b+87M86SxF5HzkOdBuRLBPhus5u7DGIskjsggB4apICwGNOpX9SBozaxuA+6faGo7HcNVNhkbn9Bcn9touw2q3NdC/ghLEeESdJRp/sxtmyiq83N6McZuhpAdIay0Ji3jZ2dvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 09:18:32 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 09:18:32 +0000
Message-ID: <b62fba61-0317-485a-bb1e-e42cf271ff92@nvidia.com>
Date: Mon, 3 Aug 2026 12:18:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: avoid wildcard drop flow in priority
 discovery
To: Gavin Hu <gahu@nvidia.com>, dev@dpdk.org
Cc: Wei Yan <yanwei.wy@bytedance.com>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
References: <20260713041856.67144-1-gahu@nvidia.com>
 <20260714060751.44814-1-gahu@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260714060751.44814-1-gahu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c584dbd-ef06-4da9-23cd-08def1402f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8qAkBchrM45nRrcWiDjdWKBKWuQvhV/qa59EGPLb9dMc23hYcBwhMXEaOMsHll3/jo4Q3zF27ojO+hPkpUdDnVC5Y+y0gEA3EYbFg83UXkKruRp97FwOsWO0AdnadTrNKqg0OXdsaEYsyQsVZWy8B2RHnNctmE1AHqcYXfwWqN0+QgyOhPfDHCfH2JWLJl8Xwa3hWoC5o7wPdewzAcpVW3un2qTJ5NBgo4weZ0z4Yrp2Bk/zqARkUreS7U4NuUkjdqWH5FdQ8DCYOmWvaTzM5iQe5L6MMm2VbFiJwsz7rpa2x7TMMDyjCTnm+I3F9gxn0hPrdcwqmyNQ1h+RsKlwL0gziCsxaejwZvaSSLle4H+/98dwb3zRpIKFx3t0//H2jd0xWvup1kIXwqZIHjrq9Cdv8gfnJJyJded/AeEXCLXcfA+iYUA+zQO+IpsutWZzDVryQ1LlgUvL4oO/r69XJQBshriq6wrk+C1Vr47zjbiAQPsmrg451JcAEo5TU9LFqZox0BovPRNA5sRTQ3z4dpo8pudrZ2PA5PV4uwbu9UC7iaYnKY2IzRQ9B7YnOnErIP9mW+L9F3/pDBW2jD4BeksBzxDMYh773mKB1sHY6PfaYrnXLwDgXCScZnTU1HgA0e/Os3uKvcIKPPjsNKY8mjZjOwEdIMr6PRiygbQyGGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZuN0k4cGhrR1J1c0dqNDZzUkh5R0R6M1lyblRlL1owWG9mditEVnAxRW5Z?=
 =?utf-8?B?MXAwaWlnR29KNVo3K0lMRG5pTUJIZmNrUVZMVDdJK3RSeFNLZURWZWVpclNU?=
 =?utf-8?B?aitGZ3ZtSjJMZHRsOGJ2aGZmT1FmVE92eU4rWlFmT3h2YUNPWk4vU3FHaisx?=
 =?utf-8?B?K3RGVjM3MTZOeW5iaDhnVTlCMDR2bkIwWS83Z0tuU3Qwb3RBbEtob3BtNEFH?=
 =?utf-8?B?cU9RZ3BTb010Szk5YWNmSlBHZDZmNHpPdEUzZmdtcUxodEx0bHU0R3BlcTM1?=
 =?utf-8?B?dXUwY3ZhRGZkNnV0OFI5amRmdk5ZeEhudlVkZnhxa2EvakFxZE1raWhtOTJm?=
 =?utf-8?B?MDBkUnV6NEN6UXNhN0JjSm5pYWZlOVh0MWc4VkdKTklNWVZnNnNSWjdPaWVn?=
 =?utf-8?B?bTF4QVVZRFIzd2s3bkkyakw3eU5pWHB4REx5dlBZWUMyeU8rWVVwRTZCdGtq?=
 =?utf-8?B?Qlc3Y3RXWG9tbUJaMnJDTmxTNExERG1XbmRyVy9lNmplVEk3czdwaFBSUENW?=
 =?utf-8?B?ZTlzV3B4enF3SE54Q3ZSdjFkeHBLU0gvOU1ZZk1oVUZlVUhrZm9obWR4enJk?=
 =?utf-8?B?d2kwSzB1WFVucE1CZ1lCaUlQcXpUNkFOYTRzaHViS2JnUTRvSTNyQ0c4bUNI?=
 =?utf-8?B?TE5BUE1tQWhidGRUVzkwNzF4YWVzQVZCdmZMRm5xYlgxc0tBTm52VldkSjMz?=
 =?utf-8?B?V2s3NFRCb3p2OWlBT0oyb2wrZWNzRnlBV054QmhFWC9OV2FTR0FTekNaSjQx?=
 =?utf-8?B?MmpXUjRrTUJoZncxQmJmWHF0enFxWVlIY2M2ZmhIeUtWL0RUa3ZwdDBRSmN6?=
 =?utf-8?B?bVdPOUN4WnBhTS9HOGZ2Y29FL0JHdEV1UW1KKzI1NlBmV2E3RjNVR0VaaXA3?=
 =?utf-8?B?QjVXQWZyQlhJb1JjYnE0SzlGU3VUU3FxcHVPZEhiTjZzRXJvMmJaNzhGeXVT?=
 =?utf-8?B?QWx4M01vN3ZmZkY3VnZIZWkySlJIWDNRVXhzUm9JWUxlRi8vUWFGVlhZTGsr?=
 =?utf-8?B?clFiVDFRTmNQNnlXSjFxbkhpamNjekJFSHp1Wk5EZEZ2T3ZKUmZsLzNhZEF4?=
 =?utf-8?B?WGZERkZlbGhUNk8zajlNUGpPOHRQUGpMT3N5STlqS0diNTA4a2JSR2pzQzFS?=
 =?utf-8?B?YzRNRTRuTmg2alNEcTlzRDN4Q3AzMTlBbnNxQmIwZFl5VE5zY3UwTTNCcnFx?=
 =?utf-8?B?M1BJV0s4WmwvR09SY1BzY2VzaUgxaldZOHJQVXJQUmc3OFF2Ylh2T05sVko4?=
 =?utf-8?B?KzhsNHQ5Y2JzMzR6ZzRPZCtkajdWSktzT2YyUktXYlMvMlg5N2o5N1lJOVh3?=
 =?utf-8?B?T0h4K0xkYjhKWnlzcXNNQmJaN3JyZDdVSFgzSzdkRk5sYmcveTdHR2ZrN2dE?=
 =?utf-8?B?QkJTUFdVNEJRaVUrdVE2M1hzdzRvZ2c0YnlLK2RlU1ZyMXI1M0JHc01sWFov?=
 =?utf-8?B?VDFGNWJzV1FEb3lzVmJqaGw1cWNGSTgvakFnVHBza2RrYUozZWcxa1E5dnpS?=
 =?utf-8?B?eW5IZW5FenRwMzNYb1AvZnM5NmNlZThPYXlyWmtPZnN6QTRITXkyMHMrS1M3?=
 =?utf-8?B?OVdULzcrWnp1b043QkdwWXNtZTFFYlkrQWl0dDhsNDZVQlZhOG40anA5QkI2?=
 =?utf-8?B?ZE5vMmh3Wm1pblJsSDVMRU51ZVE2MEpiamVtOFJoZzQ2SXlwbDQzRGdPOVdu?=
 =?utf-8?B?eXNEMDdiVld5aHJKR2pZaWRaSUVpQWN1S1FJYktsdFNRalpVNFFMSWJjMjFZ?=
 =?utf-8?B?U012VnF6dklrR1BLOHRkdE5mN1NFcldUTWR6anZYekVCYnowdThibzAzVU9Q?=
 =?utf-8?B?Y3hXNHVNTklkSk54ZTNzVVVDUVBXTmNTVE1CM3RHdE1kdUVBOGQ4b1VCMmhH?=
 =?utf-8?B?TjBoT2szek0wZFhKOE93OENubmhSM0hVOXlDTjFjckFxaG85dytHOXZNUDAv?=
 =?utf-8?B?WWxkWXFDSlpCTkJMY3lHWFBDcmFhakxVb2hiUWVOVXhvQ20zSVQ5L1QweHpi?=
 =?utf-8?B?b25kSGZFM3FKT2xMQlcrZnZsVTVIUCsyZTVTTkxKYmw3QklDRkRQOWFEYVlk?=
 =?utf-8?B?VG1nU2tZSmZRME55S2czQ2pkM1gyUHNXUVJTTDJpdjBLUmVORjVoYXYvOFFo?=
 =?utf-8?B?ZGJvWnIrTXFSWUVmeHQ1TENkNS8xN1UrQ0E0empjNEkzamt4cXovaUZwOHRJ?=
 =?utf-8?B?MlRwZUE4MlRXbElHeFdGanlZall2bTJzMXVZOUg5cHo5UFVhTTZQZWV2UXBl?=
 =?utf-8?B?eXVaam1HcHY4TkV3dDhjdWZqdlBaQmFNWjBTdUw1SWYxZGJ4ZWZvb2pkOXBn?=
 =?utf-8?Q?RsSoJcy/V8gTuRONKp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c584dbd-ef06-4da9-23cd-08def1402f4c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:18:30.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/vctoywi9l2SL142Dhez7ZcfICKPxTJlfcziOAcfbthaq6Al/ZFAWQMIuCT0FBscFQ+q9GyBxd+H52Z+bY9KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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


On 14/07/2026 9:07 AM, Gavin Hu wrote:
> From: Wei Yan <yanwei.wy@bytedance.com>
> 
> Priority discovery installs temporary drop flows to probe supported flow
> priorities. These flows match a wildcard Ethernet pattern, so they can
> also match real traffic while discovery is running. On shared devices this
> may temporarily drop kernel traffic and cause TCP connection timeouts.
> 
> Constrain the probe flows to match both source and destination MAC
> addresses as ff:ff:ff:ff:ff:ff. This keeps the rule valid for discovery
> while avoiding matches on normal Ethernet traffic.
> 
> Fixes: 3eca5f8a610e ("net/mlx5: move flow priority discovery to Verbs file")
> Fixes: c5042f93a425 ("net/mlx5: discover max flow priority using DevX")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Wei Yan <yanwei.wy@bytedance.com>
> Signed-off-by: Gavin Hu <gahu@nvidia.com>
> ---
> +v2:
> +* Fixed the compiling issue by some compilers in mlx5_flow_verbs.c.
> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

