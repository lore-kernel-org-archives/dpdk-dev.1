Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09EC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 06:21:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 926A24026C;
	Mon, 12 May 2025 08:21:36 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by mails.dpdk.org (Postfix) with ESMTP id 11B914026A
 for <dev@dpdk.org>; Mon, 12 May 2025 08:21:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJwBtnsXraM+0bzGGdiTZFaAhJg9LgGhwxSExT15kGFiOkxjQSEDg+rsiEQbF1WD44Jnwv92glv9o9APvEkdjiiONeVr34n9/nnofsMfJbIokyy6D16F2jhKqy5YXxZo2rnPwJajV3mCyu3g62U2Q4bptqatytp3/STjZ9iSpH4HJOQUL2nEqy9I6OCBbgqe7dC2jINJFBl7biGUv7bRuJMc04ayY8dDXldhzYSI7gviHrunWNdd/y4KKmfpNSdMnzJN8yZ+/oPG96LovwgW3CCeTGmfZrqqwVzQlG6XVGpBK7GvawfZzv1GWJOmzB20cuHoZz3RyfuNYMDB4CI7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV7hteWDnIXzXHzF9L4+igPw1lNi61SOW9kjcBj38qY=;
 b=acfhEoU6ij3CnPzrs4H12j66bcM0NFbzZ70Bdrg7FuHgPMuQZEX+pvWsqMqpz77GAf9ovap/LXfTrCOSDG9pJ2eTZNPvNB2utuFmSYNrJq6lwz2vl4b7z0CVHu2J2mTY1HbA4MRoRakEbh5CAdb+5thLZj12pjjp6UBW/HjViWMvHPRXT5geUA1U4cZ73Ad9G4KIk/vlYm9PLo2G22R1kgXLGciJV+4lqJ/23b1gGoDdpYJft0j2g8/0wyzlnbpZPLRFKufsKdC3izhC5Qcotoc/KYpeGy29vy2WXbCJqOlpZy2xqNm02vgTFytVOLt3gcV1Z15Ip4E4Dy2KRDvJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV7hteWDnIXzXHzF9L4+igPw1lNi61SOW9kjcBj38qY=;
 b=MNrwxd77DoFSpQPGX9R/Xzhx+mAaK2JVoo5EmOqfHnowXnCvTFOqOWSVnnMu5I+GPv0r1/yxcngSL9c+IrxCj54ijX2K85OvhvIBUpDRq5oiX04qxoC9GbGRD5kkDFQIhesKMhkso4I8mxGvwyyfmIn6JajBXvApgbWZ0QxeHA+MY5n/qxDq0ugzBq2bM4PNnzHAyXOXxKFo06UlkmkAhp8Jg0GM138qQ4CTFvrt2757EDUfiB5ORcqjETGfQLLyA1enh/jMoraJ/CzgjsSmwEEH/1m+KKmuLMJOYjrRUMoiqZooeQmdaDVtQveN3k4pUc29+qI68wmLMqTHY8fK+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:21:30 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:21:30 +0000
Message-ID: <138e41cb-59e8-4dce-8da9-306b8c65e739@nvidia.com>
Date: Mon, 12 May 2025 09:21:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: add GRE as L4 layer for entropy calculation
To: Yaniv Rosner <yrosner@nvidia.com>, dev@dpdk.org
Cc: Bing Zhao <bingz@nvidia.com>
References: <20250226095155.55582-1-yrosner@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250226095155.55582-1-yrosner@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2be795-4423-441c-d200-08dd911d3c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE1DWkdZUWc1MGNsRjdwQzRZNnVzYUZ1eXVSY2JvZUIvY3ZNTldCS1VycCtl?=
 =?utf-8?B?azFiY056QWNQQTJoU1FQZ05Cd1Voa2J0UWdWMDR1YUVsb3JPcnhYQ0hCNXNv?=
 =?utf-8?B?SWpqWHE4a3JMZFVCMFFxZk91REU0Z29hbjUyUlJnTnRqQ2Zta2NxTEZZT0lQ?=
 =?utf-8?B?Mk5mL1lSdkRtT3BLUzdaYVlnb2oxeW5mbndHclMvbHNyaWlHRkMySlZiZkJJ?=
 =?utf-8?B?QVpaWEQ2a0dvL0NndUxnNjJkSzl2ZWxqVHhDOHVQWVNHME9EYjh2WXE3Wi96?=
 =?utf-8?B?OU5YTE1tQ2tkbXIyNnBQK2k3MGdPb3krN3pqa2xJTkZPdkFJRWEvc3U3NDRn?=
 =?utf-8?B?b3ZqZ2VjMzcwNWRNSUUveWI4c0ZiNVlqc1h4TG9PVE94a2xXWEdvY3RzS2Vj?=
 =?utf-8?B?YVo5bTBxUFA1WUYreUllR1JBbEJSQ1JTTi9HRUIyL2ZvVVFJbE4zSUpNNHdN?=
 =?utf-8?B?Vm55SjB0ZlpJV1pDUnhGOG1Ea1llV1I4a3kzTzdGRDlRRXpYeVF0ZjFZVER4?=
 =?utf-8?B?UlAyQTJFdTdKLzg2R3VJekw3clpTY295OG1GYU5UZGo4dHBNRGJUSW5lV1Z4?=
 =?utf-8?B?dU94cUxncWFiNVBqUWZicjFYd3NWL0dNTEIvN3p4akc2WkY3R0UrQ0srdEtY?=
 =?utf-8?B?ZDQwMmJKOWduU2V1TlNLc3o5Nnh5ZkNNR2dqVHp2bmIvbUhhd0dyek9CV1FC?=
 =?utf-8?B?TFJjNUNiYjg4ZzN1SXVQNzc2V0Y2Sk1COTA2TXJsMkhRUW15SDdYL0xYOFJa?=
 =?utf-8?B?NXEzS0hkMC9mamloZU1qK3hwYnJTQS9PYVg5R0pBWHpzQkFGNmZKRCtScVJh?=
 =?utf-8?B?aFZtaVhNaUZkcGhxSUwxcURTUmgyT21Vc3ZMdlp2SStkbFV1RTJWNU4ydVJY?=
 =?utf-8?B?enFqS2ZPTEZNSElqMWxQcmJXLzlHM3NnQml5Rjl1UWE1QTk1aHBrZDE2dDB4?=
 =?utf-8?B?bmpRcnl4ZWY5TFdGSjhRaVFhdVZ4NVU1R3lROS9rclNlZzA4TEczNStwZU5V?=
 =?utf-8?B?Ly92Q2ZHT1FjZHdSK0RtWm1RWXpPREZuU3JnZC9jMjRJelBMYmxhSGdsSThY?=
 =?utf-8?B?S1I5dnBncGZSUDJZTlV2OTl5bWw3Q0RnVkRZV3NhWUM3S25aSHFSaVVaWU1Q?=
 =?utf-8?B?ZFhwWGpaaitJVG5CUGhDaDNsaWxrajVpQmRlMEkvUjEwQUxyZ2dnMWpKMDM3?=
 =?utf-8?B?YjhIa1U2Z2NqbUNTVFBJMEpHanlTTWluY2gzNm5TckppaFNMYXJIL2V3cHpK?=
 =?utf-8?B?eFRsUThNOWluTHpxS3JManJRUXFxWUFpaHJQSk5UcmlQMUdQZ2gvT2RjWHNC?=
 =?utf-8?B?OUo4VktUd2JXRnBuOUhmNzEzSzkzUklHZWxyV0puRUswUW96M2svRkdZdkpu?=
 =?utf-8?B?enl3QVZwOTcvSTBYdzlmTTBkUXFERkZUN2NuMTE3dGhWMVhCUnJwSDdrb3J3?=
 =?utf-8?B?eTc1VkZZQ0pxU0VQZmUyT0JtdGtFcjZuTmo1V3N5VUo5WVZxN0pwSnEvWkE1?=
 =?utf-8?B?SjViZWxoN29aN3NSb0FLNmorMG02TGNrVTlXZzQ0M1ZZT3ltREE1OWFGUVRU?=
 =?utf-8?B?cFlMYVpEOW80eDJySVI5L0tMaldoWXBBWVVJZ2oyajBnY0xmejc0cUhIcEZH?=
 =?utf-8?B?K2gzemR6bTJvRUNOZXdLb2ZSQzR6THA5Vy9Od1ZnNjdTczB6SUpxZll5OEdr?=
 =?utf-8?B?SmFNbDkyWXBVdk9pd2dQbzB5MmVUNVJkR3RVL3FUNldrNHlQbUJKWnR6aDh2?=
 =?utf-8?B?TVE3eHZPdUx2ZGRvejUrSkozK1FGMUZwU3UxL0txWWdyQjUzd0pGQzJwZG5P?=
 =?utf-8?B?VzFCWitrZzJqenVxamcveEZXSnBWbUlTdDQxcXMrTGVwcUlpTWVwOWVFTUMv?=
 =?utf-8?B?OGtYQkkzbWkwYVFzVE1zQUMwV1pEdGNNbHFLLzluT2pGczFzdDhjazFXYThI?=
 =?utf-8?Q?ymDptOojfHI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3prZHphd1BOT055ZlhWRy9iSXZwYmF5L0w2Q0xxaFkyZkZDejJwdnB1eTNM?=
 =?utf-8?B?QjF6amVKemVXaWxXdmpncmhpdW42dERmTWI3MWUrT1NSNzZsVFV1N2RzTmJq?=
 =?utf-8?B?ZVRmSGMwTmZqNHNjWWgxeWJxMjlWN0RUV0o0OEJ2UUhhVUdRc0NYUWxlb21H?=
 =?utf-8?B?cVlJbStHUG5STXhBbHEzSVQ1MEJaUVdnS24vdDg1MUlKODRmSVlubk5QSEs3?=
 =?utf-8?B?aDYxR1llT1djWHhyN08ySkVlQjk5NDR6eEhFTVBtZ00xaWMzYi9rMUUrNURn?=
 =?utf-8?B?YzJya3hnNExFUTNHUlM5cmxHVnlTKzBhOUxUK01BZmRyS2kxT0NRR1NQTDVU?=
 =?utf-8?B?enVESWc4YzJHS1BkdFV4aXdzSXc5TGtlTGN6Mm9SdzZNRGtORm84bTBQdzdC?=
 =?utf-8?B?aklvWU5uQkdGRkw1UzIwTllNNndtTyswaEt1eEZHcnFwVXppSlVrSm95aTRS?=
 =?utf-8?B?TWcvZHRMemZoVXJ2b2taZS9vM3pjWDFMUzFUMDdsRTZEZ1Y5UVVoZmM1Ync2?=
 =?utf-8?B?elNMMUZUQ1owamREU29ldkk1SXM4L0s3eHB6dm1MYjdCSVVuNm9ZcXo3Tk42?=
 =?utf-8?B?WTdCZjcvbWY5SkMwczhkVHI2MkRWRFZaN3hrajd0RmtDZFlLdndZUE41ZUtR?=
 =?utf-8?B?RnpVSUYreTZRcmlXamNocGUrN3R4SGZlTnF2d01ka09ob3c4UlpkU09rVnBG?=
 =?utf-8?B?a3k4U096VU81ajRvM2tYdG1KTDNmVmFsdm9nZDc3Y1FCWGl1Y3dWQjMwSzZ3?=
 =?utf-8?B?TjdMVGtJbzdTbzUrUnoza0F5TWM1bFBXd3paSStxSllTVll5emxESGwvQVdk?=
 =?utf-8?B?bTU0Zzc0RENRS2lXa0hyZmJEVHRWZnViZFRuYlhWWXp5S1p5SGJ3Z2FabTFq?=
 =?utf-8?B?OTMraTNYeW55RHprWUM0OWJiR3cvRkduWW9iZk9VUlNpUGQwTnRGdE5SbFk1?=
 =?utf-8?B?Zi9sc2p1K1pqZGN5ajNLWmViNm5MWEs1b1hSRHFnL1V1cWlHU3FrdFdJK2p2?=
 =?utf-8?B?UzQ1cmg0SzlsbnFkRzBBQzgrc3BueWRheE84UndEUXphNFJYK2FwK0gwSllK?=
 =?utf-8?B?Z09IcHBHeC9WcjJ6SzVWTm5Jek44RHNEdXcxL0QxZlJVQlBnNDEwZUJUYlhX?=
 =?utf-8?B?cGNXT09VeXNhWjFqOFlwVlUvaU42Y0VtQXNsWWZpNW9yRlN6cE44dkNtcnFD?=
 =?utf-8?B?cGhOOWVNQ1lQSmMyU2Vja1k3MGdYRU1iSGNxaHA3bGJLWHJwNUhnb0dxZFJB?=
 =?utf-8?B?L3JTRmlFRFZUNDFyU0VKVW1HdmVOYy84T1hhMGVoN2VLbEdleEZqZ29BL2pY?=
 =?utf-8?B?a1B1cE0vUm5DNE03Y01CVmZlb2M3WlBLSEVQR0VsTlI0TWVDeWdtRFVPbll1?=
 =?utf-8?B?YllYbWUrK3pPQVczNVhzaEtJb0JqQUNObitnY3BSWHl3YnZpZTdYY2djdWJi?=
 =?utf-8?B?MTZXUFVyVFF0a1B4UU1CY3lFVXdGamFyR2Jya3lqU1o2aTl5MHh5MFQ1bTlD?=
 =?utf-8?B?VDAyOGZVRHlWZzFKWXRHQU81bER3TDA1RlBNQ3pZTy92ZGNnMTdrN0hhbVND?=
 =?utf-8?B?czRQM0QvcE43dW1Cb1BXWXNTWmRVcThVSjkzTU41NVlBM2dxRzdycG53R2hy?=
 =?utf-8?B?UTk4dHVlbWxKNDc5alV1T3oxeGJEbDVvNTN0TmlSNk1VeGJQYUo0S2dtRUU1?=
 =?utf-8?B?VmhydkVSS3R3N2orbmRVdUZrQnBMRnhCSVJuY3B5d2hrZWpBYmg2NTVTNlhr?=
 =?utf-8?B?NytwRVpTZXhOTmN5ZkovWDh2YkdxTW0xZHphV0QzQjVKbjZZbnZFNVZpZnpB?=
 =?utf-8?B?OE16NHN4SzdPZXdSaWp0V2JrK2owMFpDNkRESTBpSE5QUFNMUFpacWxzK2ZC?=
 =?utf-8?B?U2FGd0hpclJqQVVRRUJIaFIyeHNvRmU3MmhKK0xDSGVmUVdMcEJTeVh6bjBw?=
 =?utf-8?B?c1RLUlRRSG1LWVdIZVJLNmxwS25aeGhoS3ErZ1A3anpwdXdONHJLRklQSzJJ?=
 =?utf-8?B?ZlNiK1B0WldydnFNKzdlaTZ1ZTFYSkpKeEpSSzl1eDhuOEZyc283d3FOaXNr?=
 =?utf-8?B?WVg1OEd3UVpKWG05Mm9rVGRlem14RExtSnVCemJNai9uUnhPRXA0K0ZCaWxR?=
 =?utf-8?Q?ZwuTGzhfIPJmfGLMXaSt5cifa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2be795-4423-441c-d200-08dd911d3c13
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:21:30.6937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6198yxOHPLguDsXj/RvLw9wW4MgwrUY3eukwiRlFUgIPRJhJ4RNdPixM2eEValDi1FqSUPaSq5Gs+0pWKZiKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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


On 26/02/2025 11:51 AM, Yaniv Rosner wrote:
> Signed-off-by: Yaniv Rosner <yrosner@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---
>   drivers/net/mlx5/mlx5_flow_hw.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> index e72b87d70f..27ee9d6cd3 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -14875,6 +14875,9 @@ flow_hw_calc_encap_hash(struct rte_eth_dev *dev,
>   		case RTE_FLOW_ITEM_TYPE_ICMP6:
>   			data.next_protocol = IPPROTO_ICMPV6;
>   			break;
> +		case RTE_FLOW_ITEM_TYPE_GRE:
> +			data.next_protocol = IPPROTO_GRE;
> +			break;
>   		default:
>   			break;
>   		}

Patch applied to next-net-mlx,
-- 
Kindest regards
Raslan Darawsheh

