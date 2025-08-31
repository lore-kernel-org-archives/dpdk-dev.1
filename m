Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814EECA0FF2
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 12:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFEAA40292;
	Sun, 31 Aug 2025 14:19:25 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by mails.dpdk.org (Postfix) with ESMTP id D299E40263
 for <dev@dpdk.org>; Sun, 31 Aug 2025 14:19:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKpK1yTa+e8itPfAqGLl01OeS0wr8zn9RY9EMnnonwoobbakeH1XkidgoixXvvAHnENHZbrAsVLGl+kWJTBEOGkZeyKnEisrWRDVv3vemyTcvECYaxPcidPgs3yVGWZVTZ3SsEk0zIIeHBlBjnJ1qkN1dbmKtzhEZ1CjLVc7mIBNq7a4T/zGDjbP9ZmWA7BlKQ5EoZ72TB3hVj0yWpd/oG73Z/EyC4kiq0pveLbyKURov939HEZCrfTthHESCRqRquqqf7zGNCsfSn3Vevk6tPZIWSiNwLBwIqzvL1y0JtaIHCrARVQkkd/6eupb/92Ejyg7X3Itmvm0xpcXNP9eLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSfOlxwcCG62Jkk0p75wqE+5QJiNVmpI+VJvGaiLiaE=;
 b=Z3/+oZCZ8DP3aZk1bQaHdE9GmfIpc51K9tE4JPkMvGcHTqjl8MQda5eg1KpS/DuTpL07xocTTE+qsgg2kVYq3VezvcmjVUOoxyi+V2BIYFcF12vcqZmWEBRnpMSPvSW0xzskJ3Pw/BpnS6CZrSv1e6gedW3pFCrXXNR5kMzs/KDbJkT0Ams3T2wM9y/v10DpwwfHmsncJDpXh/5VqUyLt+YVzFQ8ZLWNpXWDZz8IgQtfl7fucFcyEHrbfOYQpQ7NGU9I7RoeZTrqFzfeTcZtLsvfXWDS5dK50VqR/w8eVvmjfh9sK0uNUUDWF7iPbZdolP/uGokhw0SsNllLCUotMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSfOlxwcCG62Jkk0p75wqE+5QJiNVmpI+VJvGaiLiaE=;
 b=qLrrNo6BSoVv7qC8FZLx4R17uSUFNnT3MLpcQQbsT9WUMc19hYKXmq7uWI3Uq5rvZ9WvFS4hploGs3UvJtA78TTWTWJz9ekeot6o5DesOq/NdE8lg1OLvKjxBWf3Vi6s5YekqIU6fRflOItWdHE+Z9MvUdyO12ZpwKPmtolIqLrLBGd27+M5NPbWx28KwHXttT3tuE5FtvJlPZFq14MXM3ZGKVZT0R81wUiAFLX//vxsAipRnKCzopGYpyEobRXiE7Z5rD6PipwQQ+pxPzY50hgVyFUG+bHA5mW4IbQVVVSp3HCEpXZwuarcQGry5vnsuMtCqBnpE8p6CgE8MeUAsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 31 Aug
 2025 12:19:19 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 12:19:19 +0000
Message-ID: <cab3bd69-c338-4d3f-bb39-009507f57b95@nvidia.com>
Date: Sun, 31 Aug 2025 15:19:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix mark action creation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, Erez Shitrit <erezsh@nvidia.com>
References: <20250814132411.799853-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250814132411.799853-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 07891b8a-523b-44dd-15b3-08dde8889c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3JiQTdyNFUwbzRDb1BXN1BCSHl0OHgxb1dFSkJrQ28yMU5BRFJ3Wm5LaVFa?=
 =?utf-8?B?QTlDTlh1enJ5bktxSVhqcThWendDUTAxWGd5bWtkUDdLUDIxVmhnRzRORitY?=
 =?utf-8?B?TWlZMXdldStDT1k1ZkoxQWloQjBMemUzNjlQbFM3QjR5R29xczRnU1UxMURE?=
 =?utf-8?B?MnNMTUpIMStMZzRZMVB2TklRYUtFKzBtNU1XSitnWHJuSFUrQVkwb3JLTEEy?=
 =?utf-8?B?WFZrdkl6Mk1YbThjZElKYXdYYmRDTytDUnA1WjZ3eDNIUmt6eDQ5cG1xbDA4?=
 =?utf-8?B?RTUzOUNQM3RsVm5kLzE2WmJkcE9KT05tdjlkWDZ6WGlodzU3T0JMdUtkTVlT?=
 =?utf-8?B?U1crNUJPd1ZudzNsbHRNb2NJalJaT2ZFVjRQcWFrZnFiMEhNOXRrYkRwRjBS?=
 =?utf-8?B?K3hvTEZHKzU1ckdNeFh2NEpITGN5Y3VtMCtaK3pQeWhiOUgwTTZFNUdoSTda?=
 =?utf-8?B?cTIvbUpSZDZua21nUjlMVXlNby9xcHdDbHJ2UmlHbzhJMW9kd0xzdm5Md0J3?=
 =?utf-8?B?WldYL3cvUzRtT2FZeHAzY2Z3a2trWi84OGNEV0s3YjYyeEw5RHpqRlNldW1k?=
 =?utf-8?B?bUFMUHQwdzNESkxaemV5QXVVZEYwcFB1OGEzNzNBQWNkYm0zZ1ZZMHhsV05Y?=
 =?utf-8?B?cHJNckRuaFdhUDhFcWFBbG5mdXlpZ2ZNMU02cVVMK0hYZk1mMk1IUnJ1N1Ju?=
 =?utf-8?B?QWhnTDBSM2RrQjdSejdWYjk0eFRTOVZkSkR4QklnUTVJS1Bzeno4aURYdFJF?=
 =?utf-8?B?YnF4VjlRTlRRR2dxOHRWN1ZhUGJGU04vUFhCazFUMWlQa2V5Q1hsMW1OUjEy?=
 =?utf-8?B?OE81aDZ4cFZXZHNyckFyaTZIUUE5VnhqTjR5b0lURlBqRG5JVFJDZG1ZQjlE?=
 =?utf-8?B?ZDRyYWNRUC9HN0lBZkFZTktYRnV2T0tVRG9lR2lGUEROMkdUSVdsR0ZSd05u?=
 =?utf-8?B?WTF6VnU2ZVdXZ2t2V1VicDUwRjVOVHdqU21XSndhNGJIQ3NFcy9Ycm5VU29J?=
 =?utf-8?B?b1FDcXVGT2dEejdYWXU0QXRzZEdpT0c3WnV4NTdGbVIwRDBCa2JGSW9IU05r?=
 =?utf-8?B?ZlM2aXZUaVFrU3hDa2wvek9PVkhtdEZzRzVRZDByU242cUhadFllTXhLYXoz?=
 =?utf-8?B?QTdxZyttekZpSnAyU2NndFkrYmUxUnBmNVpvT1BhYXRmaFQ0djI2aGtwUmJz?=
 =?utf-8?B?dzlQNm1xQ1lwQ1Y3bGo1eXk0TUYyNzVRc0VQTy95eTNKL3NBbUYybklONWhU?=
 =?utf-8?B?NDBJc1N0MVVIN3ZBc3hsYmV6RmhsRGZPNTFmYWI5amxpeC92RmE5MDl0dzBi?=
 =?utf-8?B?UXB1K2NPUldmcEpMT3dnY3N6bGU4UXYwdG92ajZVVTAxRUN6STN6VXdXMmNt?=
 =?utf-8?B?REhCekY4U3lxdE1lcjVabWxoS1FScmxCdlJ2Q2FrR3c3VXBPS1lwcXJtYU9P?=
 =?utf-8?B?NFFwMUJwUzlRMjJnWEtMVThuRERKQ0E3THZtVEF2dHhMVklkRjB3ZjgycEIx?=
 =?utf-8?B?R096WFA3UkZwUGgwbG5BSVBLYVQwQjYyRHdqbjFmT29oa2hhcFllUjJZUmlp?=
 =?utf-8?B?dHdwWVBLNXJsMzR5d0sxRHA5WlZpSDNGay91Y1ZRdFhkZXp3SXB6ckVockFM?=
 =?utf-8?B?cjlmMEhVMytKZ2FUSk1tRDFIOVhMMjE5SEhLelRmcjgvVUo5b3U1MjJOTi9C?=
 =?utf-8?B?c2Mzb01VbmNDaEJkdEwxblZEM2poUmYxQWFjdXQ2QmVLQkhrZEJhL2JtOHds?=
 =?utf-8?B?NFhFdEhQMUQwNnlzUmFGcUFGemxUVGRaMTkzUFU1QnRtMTFYYjc0dDlrTXgy?=
 =?utf-8?B?RGIvZ2w5cDVDNEltbXBQcWgrZ1A2K2ppS1NSVVk0NXNPRnF6Tms3QlorSGVS?=
 =?utf-8?B?cGduc29NdUZKSmRnR3BYMnBiK1lwN01QYXYvdDFxZXhIdksrWjY3WVhhbG44?=
 =?utf-8?Q?rCqm6ZE9HD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkpyd1JZbUkxbWlpQUd5YzhhWDlVNnFKNStCQXZ2N2NDVXY2eFJjTDlnZlZm?=
 =?utf-8?B?RG5lalowb3k0cituT1BnQWVjSm5mb01ld3pFR2hJTVd4VkxtZ3V2UTJ2cUpl?=
 =?utf-8?B?dFNLd0lBVFlaTFVXSExObGRORWd6NzRXU2VmVllxQ0hlY3U5SHpISXE1Znlo?=
 =?utf-8?B?U0ZxdTYxbnAxMWpCd3pISVQ0aGdWS1ljZk5WbWY1bzVTVGdiNnQ2ZW9jOGdT?=
 =?utf-8?B?RWRwOHhrYkRwaE9NWk1XV09vOEhiUUt1SVJUdTZMc2p5eG9LbHJHemJ6K0xk?=
 =?utf-8?B?ejBDSU5oRHIrc2EvUGJWU2Z6M3E2OGpYblFyNFNwKzJZM1k5YWVDQ28xa0NV?=
 =?utf-8?B?UFlUNCswVGdabnZaR09sRnBFUVJ1OXk1TjcxNDUwL1NuRkltVnc2ZGw5QitM?=
 =?utf-8?B?VndsQ1cxTXgwOG9PQzNndm5PY21CZW5JeEJhVUZaQWdaYVY4bGRFTTRpemRB?=
 =?utf-8?B?RmtXV1FiLzJFb1ZCSHU3L0twVWpGRk8veEt1RllScDZYeWJNVlJhdEFBbGF5?=
 =?utf-8?B?SEM3UnJRVm9TWFV1ZGptVWxOUkhRbm1CQ0ZMZXhGWTlRMlN1bXpBWXF3aTdr?=
 =?utf-8?B?TnFpVXQ5SUU5MnpuWWJpWnA5OUsybndVM0U3ZjUvY0hqNzFmcWR1cGo2Z2tW?=
 =?utf-8?B?aWFZdWhHZURVb0JGdzBiRGhPNmxkZXlYRVBlckphYjh6QWh2dGp1blo2K0gz?=
 =?utf-8?B?Q2hKYlI4U0xibUJnSzJsZ2NGeUR4bnI0SXFta0VUMHVtQS81czFMWEdlbUZE?=
 =?utf-8?B?RXdTVEg3MnI2TFdvVzNId0RhbVc5bDNIL1BURWk5ZDU2bmtkb1BHNndTaDZ2?=
 =?utf-8?B?WWNxeTZyaXZmT1NqQkhpTmZOWFdiMzk2UDBKMWFza1RqSnI5WVhOM24xRVNH?=
 =?utf-8?B?YXB5L1RYNWtKbnBobHg0ZThDd3lLeWVtZzk0d2hQYXVsNmliRWRIN2JBNUYw?=
 =?utf-8?B?d0NGTzlxQmRXQ2gxbGRDS3VEY05HZkFUeW14eEZiUWEzaDBwWFp6M1k1TFFu?=
 =?utf-8?B?OC9PWkptOFArbmFROXBxMkFrY0hDU1Q5bFJva2RSSER0VW93M05oK2tOaTdB?=
 =?utf-8?B?Mk9qNzN6U1JMZGE5cDdMdXRKUGEwZzNxL21MWmUrM0twTGtFMWtJNnk5eTFy?=
 =?utf-8?B?WUxlalFHN0JRNWpwLzM3SVVIRldNSWFBUERBbzlGd0VORDJVSnc5L0lTMkxm?=
 =?utf-8?B?K0gzWlhyZG1Wc21Wd0I2ODZZcytIY1diZ3BKMjRpcGpza05ocnEzTERUdy9Q?=
 =?utf-8?B?T0tLQzcwK0w1Z245U3U1Sk9uQUZRc3RXMm0zdStDVnhOYjFPMmxBcVJzN0Jx?=
 =?utf-8?B?Z3VLUVR4VHNJUnZvK05iSGZqRmR1Z2cyVWYybXVwZW9tb1BtUkM5QVduTWw1?=
 =?utf-8?B?ZzQ0S0tJcDFXbGd0ZFYyWWsxSTNMQUtPai80WUdkd281Y2k3WjhNSkgwQUsw?=
 =?utf-8?B?WXZEWFRSeEpIU1FzSHFwUUc1NDBseWNaQmFCN0lqajVrRklidndydjNNbW5S?=
 =?utf-8?B?MDNrekJUUGpFS2hjZ1RiRURLd3dJR3B1bXJPWWlHaW5leW1IRW52MWNMY28w?=
 =?utf-8?B?RGlIc0ZHZlV3WmFEaEFOWHNOSjhNNy9SSkRvbitKdk5CL2NGS2Y4ZDVRaDRX?=
 =?utf-8?B?NG1FMXcwQUdCYVVMZUlXUko0NFlzeDhON2puSDEyU3VVeFlBSitGcjNHRk5U?=
 =?utf-8?B?aURYYzlXdXN1T1RnOFN3SFZzSnBTaHcyOThsSGpNT3pqYTE4VWRTS1hXYnVC?=
 =?utf-8?B?aTZ1MVB6VFh1YWJlcmo3ZlVkalM0azNiRHg1YitZOGZQNzRpSm1NR25teWM4?=
 =?utf-8?B?LzA3R2M5WXFGSmcyZXBlMkhVdFFDaGgwQy9DRkVmK3h3NHBDdHM4NXZRMDJi?=
 =?utf-8?B?Tzl4dmtsTDAyR3BmSVg3Z05WY2lKZDU3VXFGbXNCRnU0V2t3TEhkSnUxYXVQ?=
 =?utf-8?B?N2ZDaWZzaWFhOUFOZUVWWGlBUlNXd21PcWhZZlJxOW9hZ2JvSW1NYW9obVls?=
 =?utf-8?B?T2hETUdRN2R2a3kyQW5aUDFWU2poNlFuZ0NRa1VOQ2hkNk5PZHJaME85RXFW?=
 =?utf-8?B?K3pFd2x6cVk0U2dWUFhPeThuSkFIY0MrOGxBbzF0OGloU0IyZkJnNUlEVnln?=
 =?utf-8?Q?N+G6QHh5bSiLkRUeQdeauEA71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07891b8a-523b-44dd-15b3-08dde8889c48
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 12:19:19.4621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2wC3rxH157JlYIJPhnFe0WAhaFj83VitSy2haEIkRCDv8klT+IcaAOD8/TCep+ldZUP+tdpVYQVJ/rosQca1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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


On 14/08/2025 4:24 PM, Dariusz Sosnowski wrote:
> Mark flow action is implemented using a flow tag action
> exposed by HWS layer.
> Whenever flow tag action is used in FDB domain,
> HWS layer has to create relevant STC for both FDB sides,
> i.e., FDB_RX and FDB_TX.
> Flow tag action is not supported on FDB_TX.
> 
> This patch adds missing STC fixup code when FDB domain is used,
> so that on FDB_TX side, NOP action is used in place of flow tag.
> 
> It also updates the higher level mlx5 PMD code to reject usage of mark
> flow action in actions templates with transfer attribute set,
> and prohibits creation of flow tag action on FDB
> if it is not supported by current FW.
> 
> Fixes: 794b9b37922f ("net/mlx5: allow FDB RSS")
> 
> Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Suanming Mou <suanmingm@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

