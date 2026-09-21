Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DEC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F6244029B;
	Mon, 21 Sep 2026 13:02:42 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by mails.dpdk.org (Postfix) with ESMTP id A15AB4021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:02:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me2x0plr8bHLwwwmmB5anu5PF/xRnHC06XEhjyGjvV15AP0lENEdH1Ggr4f4yFQIClLiEMv5fvaAeE/5WuOF4mcDBsE9qOVj85EanRL/czuKdnErM3YcwYqNTKKkoiPItRIjmlKLJeQU9QgnT3mT+oWliKcmVvuTvgPQ+VQL8w19xx31vVoapkhjxEm/+giJCRIaEcvnOQsF/8VQEdjcSBXq9xZH4TK+x0AdFAmEqEmBZ5ZjiETylcOQPC+3l4ehlf5ErzGb2qVpwPk65FxXnBuJljPq5JQWKvnz5WInEAJ+tPpuKFLewN8CJOt3Ob9PSqx6+1XC+kJ+4VJW5UVzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMF5Pw06222tkhj4OcE/sKyGe2L0eNTvF0Alfr9Uc54=;
 b=kRXEMRlulataqK3pV5OBTpgLxhlHvpiOsrXU1OOO8l89Zzov+KXYvCX/GHIlxV3gjgEoEGTB9IsgUMLoUMMrv454fMXgSyhMJGxzjaoNSk3R4oSG8GkecKaLfZUPngOmfGS2+PF4uADE6F6YqZgyXdrq8W4JezDim2xXSnz4/4sBrsxZ2n/Sy8AGHp1Mvu+/lXnG8VuCOTBxcsWUZjgyhZHZWCPLxsS4QgtJYSQBywMRIVcSfvqbnsiTpRkWvTHy4I6KmWaQvsX8SV2RFqdW4448HDM8+gAqBA7h7trtVdlft7l03+p65ASB7MikxoErgjUbsOEs8I28uRER3lhVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMF5Pw06222tkhj4OcE/sKyGe2L0eNTvF0Alfr9Uc54=;
 b=O5ki1CGpl46GK2XJN0WiuvnjwsMsdfz9ly6ehtl/Vs/G1NbIT1mGn2S5X1AEhued5ao1Lo07XFaco/5lVdyY0orkB1ilWj5+dPApZTXcEQBqo/GNv3OwCTnkEgtfz/nj2KZxB+BcA46utsiK+w1lEe7cmtihik1IH0isshWfM+YQ9gsXhLMhDwqDq6XW+gCV35Fj3j3PGSJohFnHWjm/XBjIBqT5HCinwfB80/FlB1CHR5clV08gxH3Fo1MOP4QQNAVoHkSeMAYEScHen6DcA5vBTP91cyyY2ubAxWHAl1kKrbyIGYKjq8kw5EYuo2MkER+kg5VWvO9ANFYl9YWHog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV0PR12MB162361.namprd12.prod.outlook.com
 (2603:10b6:408:3ef::10) by PH7PR12MB7329.namprd12.prod.outlook.com
 (2603:10b6:510:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 11:02:35 +0000
Received: from LV0PR12MB162361.namprd12.prod.outlook.com
 ([fe80::200f:41f9:11af:41b9]) by LV0PR12MB162361.namprd12.prod.outlook.com
 ([fe80::200f:41f9:11af:41b9%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:02:34 +0000
Message-ID: <60e8c970-f61b-4d93-aa2e-927b24718755@nvidia.com>
Date: Mon, 21 Sep 2026 14:02:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] net/mlx5: remove MAC addresses flush helper on
 Linux
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260921083125.40120-1-rasland@nvidia.com>
 <CAJFAV8yVRB5B1WfZV1AcovESefM9pL8cHRkEsML9bWPZfY8dhA@mail.gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <CAJFAV8yVRB5B1WfZV1AcovESefM9pL8cHRkEsML9bWPZfY8dhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To DS6PR12MB095541.namprd12.prod.outlook.com
 (2603:10b6:8:498::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR12MB162361:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: bb064a51-2c17-4385-188d-08df17cfd6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: EsULvfKXd0nQtsEqy8lh6y2mBqN6LLylLu/te9JfYryqST0BodoqYZEoZIHpaAjYEkexHRIgxZnxD2cYuxH7Wo8lTX2mdwZvmqyIqDuxTSASM1U7wd/TK4J3TNXaFWb+4yvl8Im4fVOwynRANhZGAgmt7RRrUfiiiXNGTx9gK8W9RK5ni+hToYvu7r4cS/dRjpccZwjhHqExXrar3jOj5+7znVBRiZo1uRqkhqZWYFxDmHzqsY2YLZ8XH26OrpBEGXOXSAA1mdjc6Uh6Pmim2+Kas8d9Ri6g04vB2GSFznyBWyWD08f9t+bgzVykNKtxG1lYfRxVMQW8JYElXX3TZWZyAmh9Ht5UZ6jktdGbGpYSM/qr08ZluPsvcnMU3z8J4/bRTuzIEEcUCSI8nAu5ENAOrbTRhOwfezUww010phQx4HMxL3MsE/OGNpqo2mUkaiuiaHavJ2nHGqrfWe6DWiO2YyjW2fCsexDUGSRyOJ7yrRcqnOJYkBPNaZyFgfYcjDC606VDa0sC3aV/Nl+5eSeIfcDPaPfx9ZUf/dAwLrPAaUsH5kyS1YZtaPtiFwr9FWE69+Pp3zipef3staeopblKP3JwDItA2UUAMZBdsIp5FsC0+Zq7BSqEuuOEYIDACiKtfiaMhq3ZYH6gDjnHbKa0f8xuY/5HK0ShPkjfnTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR12MB162361.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVl1czZ0M0R5NC9vVSt2UnVtWUR4VHRManVKRmtwcjQrUzZuTkF4S1ByRlM2?=
 =?utf-8?B?eGc4dlpTck5FdEhYZmFUSEp3OEhPYWY1SXlCbDk5VjBkMng1ejI3TWpZb3BE?=
 =?utf-8?B?ak5RVWpkQ2RMQmswbHZMN1N1ZUpWN09mNGpZSklHQzBoYjRvQXZXSHF1YW5C?=
 =?utf-8?B?eHFVNEp2YUEzaVM5b09UcVhsTjNGbFpXL0dneExSUGNTY2l2L2NpbTN6dHFH?=
 =?utf-8?B?M0RsdnlLRkIxbU5Zdlp4MjlXZnhkcnFYb01DdDA1M2c4Z0NyRVVuaFpycnk1?=
 =?utf-8?B?Mk5WT3lJQ3dMYklXcklDQ0pCTTRSYVRhYVBVbXhzK1hFbnNQUm5HbG1wUFU2?=
 =?utf-8?B?TXNhVWJYNDFqbUdJZzluVG5NSHZHQnZLNFpjOW9vc0xWVmVNNm1ZLzY2Mk1v?=
 =?utf-8?B?VW9VZ0lNZ0pPcVAwYm9uREJWaUNzUXFUeDlzM21UTXg1ZUJtQUVCSUpDR3pY?=
 =?utf-8?B?VFBDSzU4a01ZWFAydkZjOTh2SE1zNHlNSTloTUxVLytubHRhK0FYOE9sby9V?=
 =?utf-8?B?SFhJSjRzT2RXbEtGYkJlaDREYXV2eGUza3FlbkpyZzFyY1VLZTUvc0VPdUNY?=
 =?utf-8?B?aFhnUHZ2SkQrL1ZTanVYK0sxOFFqQ3ZIZjMwQXF3UFFEYXczaWtkM0N6RVNp?=
 =?utf-8?B?bWVaeEE0Tm1IWTQyaVA4WVJtakViSWNOT2VNc2ZJTmVuNjQ4SFlYQzVEQ3FW?=
 =?utf-8?B?aDJ2b2x3Q3VUam5wdW1kZkdzUmUrdVRWOXBNc2VFNUIzV2FqUWRqMjVUYTkw?=
 =?utf-8?B?NXBPL3Q0a3UybEhXaytUdDRNZWlEcG13VnlBNmdhUDhZUHJiN2RLcEVrYnBV?=
 =?utf-8?B?UVJYUCsycjhFeE00SXhJVUdZNjRkQkdEeC9WTU54WW9Jb1pmckVJL3NycTV3?=
 =?utf-8?B?RHVobEg4UFVWMzBibjgybUNwNzFPVmwvZm0rRi9ma3ZtUHVsWjM0VCtaSk5P?=
 =?utf-8?B?OXBOMjVtbXpMRFBVblgwM3JZaWhzMFlnOWJKQnJoVXRDTkUwT09CSUx3MTU5?=
 =?utf-8?B?a0NtcXVUakcvanU3L1l5SXcwOHBYNGpIcVZ5WDZqZzV4OTI3SXBEdjdBWFlr?=
 =?utf-8?B?aGtlRVZFejU5REFZU1RYSWhQaTJMSWZDZStQaUdUOGdET2dkRzZuZHV0aHhF?=
 =?utf-8?B?RVkzMVNOd0xra3htSDNMMFdaSG9WVitHOHBjb2c2cEtXMXRoUVZacFhRNWVG?=
 =?utf-8?B?M1lvNDVPdzU0L2MxVjVIdkt5bEdRbC9ESlFmS2x1K1d4dXFKejBrVEszVkZj?=
 =?utf-8?B?RnhxeVBWTFA0Z1h1NDJuRlNDSlRZMVVQR3hwRkszdjZYVVE0YjUwQ2VHc2hM?=
 =?utf-8?B?MTdGWllUQ2k4elNxQ1I1ZG54RFpZdnJpSE9LYU1Ham1ZMy9MalhYeElnektD?=
 =?utf-8?B?MzloL3owK0k4dDhEWTQxSVZaVElyWklXWjFpUkxHVDlKeFF6V250OXFNcm5R?=
 =?utf-8?B?WXRJeHhGTUVxODI0U0NuUDJ1NGVKVmYrNWV3ald1RnBVdFRYTXhKOUZhMFhw?=
 =?utf-8?B?NEt3WU9TVlFZZGdYR3dWTm9lUk9OcngrNzZmV0FLQkM3SW90VytmZVRGd1pp?=
 =?utf-8?B?d2tDSTFlMVFhR2FSZW83c1p2NFVpYTkvTEl0a0lvT2JFMC9JKzlOYkhXdlBE?=
 =?utf-8?B?QktadzQrN0tnK3V6MG1ZQVV2c3RSNmlkc0FpQVo4K2wxR256ay9Rdkp1QUhM?=
 =?utf-8?B?UHhxdU5IbEdRRjBvbTFtSkdveDNlYjlhcWZKQnAxZkdub01DMURkZForRmlm?=
 =?utf-8?B?QlRmTlg1eTNEQVVkcW9WOUF1NW05ZUk4Q01hUHpHQnJ5VDkyUFhRWEdveTl2?=
 =?utf-8?B?ODlZa0FlN1VSVDBwbVZ0ZE1xVHRBZG9ZcHRCRUxZalU3elBtQ0I2cWd1V3NP?=
 =?utf-8?B?MHkxSjF3UFZrL2k0VHhsUTU5QTNObnlDUHBVWFJyUnIycG5ISUpyTXpTMGdT?=
 =?utf-8?B?blAvREtRN2ozNmRzWFVtZDlLZ0U2SjNZRkh0aDF6aVdjYlBQT2RUWkRqNitV?=
 =?utf-8?B?OTZRMnVNdHNkdXdYLzBHWVl4aG9kdU8xV05sVm55cnhpRXFHQ05idFhtVHdh?=
 =?utf-8?B?QS8wS2JlZUZ6aUNWcGRFbkZpeFVOSmhyZkl2Slg0aWl2aU1UeGt1bldCUW04?=
 =?utf-8?B?L2QyT1JpNUtRTWdPcXhnRGFIMjV2UTJrcElKYklVZjVKV2xJRVFibEIrSXFB?=
 =?utf-8?B?M1hycVAzaStESFgzd1BwWTByMk9rdkdyTEkwWUlEYXVNSmNBVUJCNW9ZNnBa?=
 =?utf-8?B?eHhuT09uRThRY1k5RStiZHROTXRaUnA1bHNWVlJjcTlSa1NodkEraGxsTlJ0?=
 =?utf-8?Q?HaUBUNSOIPOA+bs/t7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb064a51-2c17-4385-188d-08df17cfd6b7
X-MS-Exchange-CrossTenant-AuthSource: DS6PR12MB095541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:02:34.9133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMvghXDixTVp5/qgrdiNtvJjDM9p1uYpuHJFCQDO16lsbrZdVirrvH8FHjdA6nwxbk4OgXUl2VpveDMLyTszmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

Hi David,

On 21/09/2026 1:31 PM, David Marchand wrote:
> On Mon, 21 Sept 2026 at 10:32, Raslan Darawsheh <rasland@nvidia.com> wrote:
>>
>> Hi David,
>>
>> 🤖 This review was drafted with assistance from Claude (Anthropic) and reviewed by me before posting.
>>
>> No functional concerns with this patch in isolation. Flagging for context
>> going into the rest of the series: by the end of it, the fixed
>> MLX5_MAX_MAC_ADDRESSES / MLX5_MAX_UC_MAC_ADDRESSES bound is replaced by a
>> device-reported dynamic limit, but mlx5_flow_hw.c's HWS control-flow paths
>> are never updated to match it (see my reply on patch 5/5,
>> "net/mlx5: accept more unicast MAC addresses").
> 
> While I understand the comment on the last patch, this comment here
> seems gratuitous.. ?
> I don't get what I should change at this point of the series.
> 
> 

Fair, that one was unnecessary on its own — the actual comment is on
patch 5/5. Apologies for the noise.


Kindest regards
Raslan Darawsheh

