Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B103CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DD8140E2B;
	Thu, 16 Oct 2025 14:17:45 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by mails.dpdk.org (Postfix) with ESMTP id 97A7140269;
 Thu, 16 Oct 2025 14:17:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im5/RNE2dMDdCG6ppj076pXKYfvwEHK/ZDuZK1OolDRaAeoXDDLmIiw6BbevKGZQ2S/MLnbUd2eYzWUmzgt2UE5KZN9MyG9j2gPhmsZ6zMWSV4H1Xx8fbnYvJcNa/5ZdkBkps+M8iSMDAyJLAahOGnwmZnIIo6YZvIOG9B5Yf3jtW5i+QjfHzKrIflW/sgvY3yXme4l2Zr7pa5xbG2W21v8QrMyk6WOJGLs6ZH1jbM10KK01AioqbRuymAvuXwX8eL6PgptpZpzxDMkD8IzBQuydDxHia8R9xOEZsMvsb8lYMb5wZS6+wNJ/hJjRJYW3GIwXCtjFbz33eEu3JB5wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAjGOSaj7PbRQQh42vm1mzsAXOw4ibEcagFBwkzFslw=;
 b=WHHjWwEehXx9NFbr2M5EFVCnCqpFE6H/o2K5VrCN3MpqyXwFvkkE7MPMsGCozQ7bkPuMz+YAsWnj48LE4NJ1ZhYPVvZP+WyneHOkxt6YJIAlqs6K9uJj09sKnq+7mHkt5qSZB82nyDwR0EjtY0NhW18MWTZL/SQotYB0Y4RJiqdc6F6YCL2O5UlYJcMUjYkoKi7N5QdbEAXIwLeVs5NV5tnAzp1Sym2DpBEjO4Dzbl6HcvtzyAdZCT2TLEXtrupFeOljW+kTm1KwL8LbKjTUIiNr/rbSGCDQwRvHgvtIRjBTc54+eASlfZHp4nN3D8R7k0GhROshC5jc11cQk2OmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAjGOSaj7PbRQQh42vm1mzsAXOw4ibEcagFBwkzFslw=;
 b=jr+1ZdCIEmRj6JNu4uXKdWsSsuHRyNHe+lrsk4ZWxRGgW6RFGnoZfASm3LzqVuxr6HHzzLw8RBuC2XSRKzPkw69Jyoa95IpMq8ZPbl3Q8xlvPibvF50to0UDWlsHaR2fAkHfWHASKCWo89Jljve18vXua/2H3FFACXm8gjkOPdRGZxjRpbU3Fk3TXLeTOXTMbAF1+TS0mUDXmmsBj36xeeks+n8eZvsSQMOiMkNoOfi3qedy3WXpP9umWo967QBo5Y/Yu0o8kq2/x1l5D0uJ9FQknjN9sVBxRAMC38NtZFK2ocsdobW3J5yv4lTUP1fb9YDXXBfW8Md8xapp8frYWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 12:17:38 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 12:17:38 +0000
Message-ID: <b41cbaeb-09e0-4333-98d8-4662fc7f515e@nvidia.com>
Date: Thu, 16 Oct 2025 15:17:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: fix age checking crash
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: michaelba@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20251009062924.138382-1-rongweil@nvidia.com>
 <20251009091810.174004-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251009091810.174004-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: fe30af4c-b76c-4c60-1f3b-08de0cadff2b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3ZmbDZYbS90cFVyaWVZWmk2bHpiMkpjcEY0LzFaYTh5VjFmVy9sRjhsT0FX?=
 =?utf-8?B?Q05oVFZmQVdqYkdlOXpVM0g2YkVRT3gwTk4vR0RTYllBVGpVc0FXTXBjRE5P?=
 =?utf-8?B?eFhXUHlJclY0WTk5YkgvYkdidWxhZzBRdDA3VERvaGoxUFB1ckdRNU9VN1F6?=
 =?utf-8?B?a0RTdVdmblA3M1I2UnZ2VmZiampVNlZoQ2NZVkk3dzUyWmZYM2ZYSGxoSlcr?=
 =?utf-8?B?ejNoZFZtemFBMEt0anRxRUlxQ1BxMVlZakdJWlg2TC82NVZITmVWQTBLRHdj?=
 =?utf-8?B?K1Z2Tit2NFhkdkxmTG15akNQcUo3YjByRGprd09yV25ESCtlUEZhZ25hbW5G?=
 =?utf-8?B?cXFDYXUwZHlBR3RpUWVxdVF4eCt1MUZSclVId1VCVklhZ1VKakpmYzdSWnI3?=
 =?utf-8?B?ZTU5MG9RdkVUTzJFcU13ZmtXOEdUenU2ZldieWRMUGV5Mk9WbklxYUZkV2N5?=
 =?utf-8?B?V2VreVZtREdNYzBTcHNhYjVhWEx2Z0IwSjBaTUJLeHRkWmJpSDZTbHhNb3RD?=
 =?utf-8?B?b0Jma0FybnVVd0w5WGpBTlU1dkRhaTAzeWw1RitFMlBvVWRVTjFvcDhNSUFB?=
 =?utf-8?B?Y01IYVJ2RjhtazdYM3ZjZ2xRU0VLNDlhdUlnclhDM2lWd08vRnNMbVpPRFNJ?=
 =?utf-8?B?MDhqSkc4Y2w2NU9KZFBENXFWSnRGb28ydWxWaUpzVFN0bVFGY0czOU4zNFVx?=
 =?utf-8?B?WDNlekw0OUJxRzI1YzdKRnVRYzhkN2RzWVFXQnBLamZkb3ZGVmorZ0kyOVVt?=
 =?utf-8?B?eUdsS1JuNXoxTHAwWVdzUXBjclZWK0RKTnBZbTNPMFcxc2xvYzVuUy9YZmJQ?=
 =?utf-8?B?RDROdUo5NStDWUVDV1NKWUpxWTZCZTBwMTl1cmVYR2lCcXVvY29LU056QSts?=
 =?utf-8?B?cDh4R0Q2am5FYThPbWtNbHFyVk9odXpmNHRyKy83d1VGNEZ3dWs0S2VmMkhI?=
 =?utf-8?B?dk9yQUpncUU0WkNnRVhUSkMvcnl1R3VrZDdJaEYxeDRLNzFOUjZaSCs5dlEz?=
 =?utf-8?B?VEFuVFM3K3hDSXdHMWxkRHRCTW5vVWY1aTV6TjRFZ3llOGlsK05vc2syb21v?=
 =?utf-8?B?aVBCUGwxUVpQTks5TnZKckpHTUZOU1RlY25NTjU4L2NoUWhhUS9uTEplNXJz?=
 =?utf-8?B?c1RjM1ZwVTZJZi9JWGdGM25BMHEzbDJTNm1aM2NnV1B6d1RlZHduc2RkN1B4?=
 =?utf-8?B?cVQvempUUlVxakRoSDRPNm9JRG1GWlRMSlhJUnk2MVlGV0Y0MEJNTEc5VG1t?=
 =?utf-8?B?cFFTSTlLS1FxTVMyYzVzOGRxTVRWa0s2Z1ZWZmorSThlTGNRcUdmVjFqTjlj?=
 =?utf-8?B?TUY2bzlxdlVRNnVZSHZjN3c4MXAxQTBJTXE1L2RINThLVlBSYm9kLzFPZ1BF?=
 =?utf-8?B?MWIwL0EvMnlha2M1K2RYSjFYcmZ0SjBFbzJZeW1qOFpjMitBMVN4TDl6QUpn?=
 =?utf-8?B?RTRDc3poZVEzQWVEeTJFQVozQ0RvVXlTbWREK2NUS0lkSlJKSTIvaC9rRzl0?=
 =?utf-8?B?SnhJVG5MekwzOEFHb1R5d0lKUmdxTlZaYVVqak5ZeUFXY3FqeXIvZ05FU1Rr?=
 =?utf-8?B?Yk1ZY2t6c2ZRZWlDK0NXQUhneVI3YVFYcHBkWnRlYVVDYm1Yb2NBM1VucUU2?=
 =?utf-8?B?c3NTdzRSOU90cytKRXhJbm5lMTBFVWdBZzVSYnRaL25vb2UrKzNzNDBwM1hD?=
 =?utf-8?B?Tm1yWkZodEl4WUwrSmt6TFhmb1Qzd0JRbnBkamNTUmVUd0ZsT3pXMFoxeTk0?=
 =?utf-8?B?cW1Oam5JTkNCQ3ozaHN5T0hQOVMrd29GQlpML3ltN3NSZkxIU1dsNUdab3Jp?=
 =?utf-8?B?VitPL21wREVFcmNYTmZzRCt4aHlvYTRnTktjYjhSVWN3NG9LNWFvVDRVbndC?=
 =?utf-8?B?djkxdE41YnM3UFZhOXRUZkZMelUzNklNVTlEYzdoK1BxOFpRYUxUYzNXcTVx?=
 =?utf-8?Q?g+/c565p66PL+3Ix1Ox7k6O4t91eK16w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJFczkveEtQOHUxTnhhd3Y4clpxa2M0SWU2cTRqbmxxVEZsUWNXZDVOOFRz?=
 =?utf-8?B?b2JYWWlVNGo3NjZYVGh3UUlJSGlpanZ1TzF1R1QwUmI4OHVUUzlNYjRxYWJO?=
 =?utf-8?B?bDI3MUduSDI3NWJmNzNVNDNrK1BUZlZHNU9IdVUxcWhkYzExK1dyaFM2eG9R?=
 =?utf-8?B?NklRK2JHNThYTVptb1BqcjNzUTF2d1ZsZkRMLzF1Q25nU1BuRXFnWTJjSXpw?=
 =?utf-8?B?YTFZY1l3Z09QSjhqWDBLdE9rVE4zeThwS1IwejJHSm8yYUNObXo3VDR6VzRJ?=
 =?utf-8?B?ZnJUT3V3empBMlFaLzFUU0h4QWx3L0tJdDNpMXVWSzQrbHJtWmFJU2lvM0w4?=
 =?utf-8?B?TU0zVXhKZnJGMWNldERWUjQremNFZktvS1g5ejRWSEN4U3JJNnVUUGdYWFNv?=
 =?utf-8?B?bnhES0tGV0VHMUF2L240a2s0dkVuQ0Y2MXRFRFJONlZmbGs4alhQdXdIa0hw?=
 =?utf-8?B?cXhMZTZpbWk0bWpTVlptZHB1SWIrRUxCUFQ2YUJhVzRoY3VwSFg3TDY1STlq?=
 =?utf-8?B?TGNjOXhjRnA5eDZpaVpEUU9vNlR3eWdjL2hOT3NBZjJMR0VHdW5Kcms3VnNq?=
 =?utf-8?B?MmV0YTR5UHlyZzM5Mmw2Qi9FQXhqMUV2aHRmRFpSbGlzeGh6NUR3K0gzLzlt?=
 =?utf-8?B?a296Wi9SZlJBTGVqb1R2b0JRWHQvNkdGWDBFQi9ianVyVGloZFg4Q09PSytn?=
 =?utf-8?B?ZU8vdUxXaUMyVENHcDB4b21KRERHOEY4TGRoWmdGcVdTYzdPSjhJdGVTQ21o?=
 =?utf-8?B?cjBSNzZWSGkvTkxRcmFKSTJ5YklMWTdVWitHYjRscUlTYm5oL0JFTTFSNVBp?=
 =?utf-8?B?NXVZdWhIUU1YNlFWcTRhMlpBRm1mMURZTjRvcy9ocFBBbnl4WGdUcGcwamdF?=
 =?utf-8?B?cWFaV1E2c1ROUEd0cERZTllhUGwvQ2VEUEw3VzNqMFkrQkZhelMxUkdQdlhV?=
 =?utf-8?B?cXROWUw4RGdONVd4QmsyVmlhVzZaSGZySFR5NUNzLzFhL3Z3QmJxZ3Z1SDlL?=
 =?utf-8?B?NWhHS2d6Rjh2bVVUcG8rdzFZMlhUVEhHU2w4OWZ1bTVZUG0zdmllU3FEalFl?=
 =?utf-8?B?K0tTU1MwT3lyVFdEdDVBNXNiSEp1ZHVzeUMyRUhoS3VxS2wwSXNyZ2swWnI3?=
 =?utf-8?B?VGFrMnhrT25HQlluS3h3dzVEZWRZNVErcE9JVTFHckpTVDhUOUh0Uk15U0pv?=
 =?utf-8?B?MEFCaW55OXI5MXlRZlZOME1sWHNUR3MrZUZraGZsbGpJdm9VeUp4S3UwOG84?=
 =?utf-8?B?cm8zVXRuR3FnOGErVDRVZGVlNG5wZjYyeFRZK0xEYk1JMWxHVmdnNk9yWVNI?=
 =?utf-8?B?VDhpbU9UbU1HK3FYcUxReDZWUGR0TWhmYlE5QnpsMXc1ZGZNaThFMEtTdFRP?=
 =?utf-8?B?Tk92YTMrd2c0MlMwKytSVXhCNUlPUnA5cE4zbDJ6VG1zQzRJa294ZFBZemdy?=
 =?utf-8?B?cWkrYmE4dzk3TWNPVDFQR1ZPV2JDdnYwVWU5WmtvVmY3eGZpR3FaMEEwK1pj?=
 =?utf-8?B?aWd1YnNnWFI5c2pzR045TklWNHhFWm96bmFIY2M3a2ZyN3ZFam5OcGdZYTEw?=
 =?utf-8?B?TlZMUkFIRlJ1WTZtdnVJR1ArdVYraFZiSU9aVFFvTlpwQThrWVZhb284SjA3?=
 =?utf-8?B?VFJQNTVkU1RJOU9TOWNLZW1uNnBKV1BoUzd3VTVFUlFicGNOcE9UVlFyTWkz?=
 =?utf-8?B?OG13RWJWSzZGeldNblhGSlpaQzJPUis3d0RrTXhlamZWK2ZtZWpMQ0Y5cG9B?=
 =?utf-8?B?T3dUZGF5V0F4TEEwM0gxNHFsUzJ2VDV6YVVxSDBPQ1J2aGZhcXAvaU9UWHRQ?=
 =?utf-8?B?OEdMdzBNWUY4cGc1V3YxTmcxYkJDZWJOZ0ZZM2hJcm5pY2EvYUM5MDVsZk02?=
 =?utf-8?B?b3B1S1JYMC9WZXVzWHpGT0xzckFBNVR6K2RIaDZtdnJ5em9jUmZhRVlWOHZG?=
 =?utf-8?B?L2RGVW10S0puTTkwMDRDUlRKR0tIV2luRklQMWRDcUlUZ3ZMS1lCTGY0eFVp?=
 =?utf-8?B?Nk00MEYzSGIwT1JOOWhvdExlRVJlR1VEUVhBbDlrRldYdGR1NG16WEVoMXZi?=
 =?utf-8?B?clcrZzh2WE9RSmU0YnJJNlZuNE9uczBPREcyQzBJcHp1YlJTc1EyMW12NnBy?=
 =?utf-8?Q?u7sXazQAVga/T0ImUsTtUmZsG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe30af4c-b76c-4c60-1f3b-08de0cadff2b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:17:38.5582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sasQZnKGll5IXvuahcw3CcQlQ14yX3mW9eh87+WEY1QbVbMh89rTC7tpYbaNl4t41P/+CmaXWKq8geVzB9/e6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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


On 09/10/2025 12:18 PM, Rongwei Liu wrote:
> When aging is configured, there is a background thread
> which queries all the counters in the pool.
> 
> Meantime, per queue flow insertion/deletion/update changes
> the counter pool too. It introduces a race condition between
> resetting counters's in_used and age_idx fields during flow deletion
> and reading them in the background thread.
> 
> To resolve it, all key members of counter's struct
> are placed in a single uint32_t and they are accessed atomically.
> 
> To avoid the occasional timestamp equalization with age_idx,
> query_gen_when_free is moved out of the union. The total memory
> size is kept the same.
> 
> Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
> Cc: michaelba@nvidia.com
> Cc: stable@dpdk.org
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> v3: fix windows compilation error.
> v2: fix clang compilation error.
> ---

  Patch applied to next-net-mlx,
Kindest regards
Raslan Darawsheh

