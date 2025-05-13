Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C4C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 06:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4EBD4026C;
	Tue, 13 May 2025 08:26:05 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by mails.dpdk.org (Postfix) with ESMTP id 9400F4025F
 for <dev@dpdk.org>; Tue, 13 May 2025 08:26:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLyD/0oTdhnL5NsL2M5GTnweueh+zKg2CUhQyMhrMk7kXxcF3oSGPxtL/lwE2sHnZ2IrQ4x6Y5Hibtck9cslnfIBCzake3xGODzKdk8ErbeSI3vyT+lj+y6xAUSNmw2sMbkzMTAT2zC2R9SrACH+BoHwt+tUR24LmWl0ZRWzd1JSLIM/HfWD+PAPIeoyKuqFPgl73juFX3wgDAJwjbek7e8x7Umn5/Ahh21hMg9t6ef8/6ET7i1lae5lURiq+8pUsyMZya6PYPo3Wfps/LoVwA2ALE3ISgysthRG0o9L6ZgoAOITPe/YKr1+JSRtI4FDlCAYs33ZyAPfmvYeWlkE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD5bhBk2J9EcLLrDenQSxoUIJkacmVnqJyRHmH6RvXI=;
 b=nXCWgEqw4ZSqkHo/w+ijZ5P2NEPOQS8oGpA/0X/OOxZzhq0mFIaBoQWgI07+eiO9T/2/uoftYh1ZqiGgzDiyuZZcXG5SaZBVmpVKhraaldRFElBuagDdWkn1JlEi6LyLPnBNGdwq8AmSVSXCJhvM40bGeX9w4QQ+B2XRq3DtENXoEpn23kCpCjk3nnqaude9D6XUC3EWRPiK/eGrevxmHl5Tku+lwJp459gWnIfElj9bqVAXVP5+WIh3mmD8OexdDTTasjLErRTYKgtdslEf6+rnL0ekZar6TUihY2ofVvtUpdRYRoK7BDnNM+U5CUwhPpl9g06ga/h919n75HSTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD5bhBk2J9EcLLrDenQSxoUIJkacmVnqJyRHmH6RvXI=;
 b=jfgX5o5F9TmZNIX51Ip5iADelBvWursWDoSLbY0wuw7oZeEtHIaYROrI9XKRSD3CJj89Dzs8Jv8iqXLnDxvODefwu3E5nF9dryWsTxveaLQ05k8Hql7MgnLhG7UF2vYFgbHIvUsxVagQ9btJ3E0cW+Dz1oCt/p2zXfl1WOqyW7rWkeUgM34G3YABdpdli9CnHY0DzqLG8rM3YaJ+36JYWLzHHOIdt8Ui5IkcuEUk8jklFt+/OmkLYEjY/hGWgPER71whl5NJ40lzFSeSwmLSb3toPBzUtQhwcZlK7XtHX2O1C+LSuBMzQA8T1npSJ32yrO5AFAdPmoOzoJjFdpRIiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 06:25:59 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:25:59 +0000
Message-ID: <a74062e8-3b9c-4b4b-8d11-5b569fef828d@nvidia.com>
Date: Tue, 13 May 2025 09:25:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: add match on IPv6 fragment extension header
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20250427112537.108725-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250427112537.108725-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bfa9f2-d0ae-4003-3e63-08dd91e70692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1FLRmk2T25ldzUrcUJNbzFRZVltREY2NmdpMG5LUjVOYnBVbGtLU0laYzV2?=
 =?utf-8?B?ajd1aEE0QTJmQytSVy92eFhmZUZsK0dRb3hjakRRRTNoV0JURVdGUEpRcU9y?=
 =?utf-8?B?MG5GdE8zd05MaHlIdUN2MFJ6NnJRRFZGbmlZMG9tT1p6cjVaWDdsM1h4bVVD?=
 =?utf-8?B?aE9sam43Q2EyL09RVlFXZ0dPSjBzQlNFSTFiVXRYcDk3Yk11eXlKbkRUazgr?=
 =?utf-8?B?WGxJZG1TYklmNDhWeUU5c0N6OWdiOUV1QnpRRFVjZXVjSHh4V0Z5bnh2Nk1C?=
 =?utf-8?B?T29Gby9IdUNRV3FuWTBiMUZ6OEhsemdERUtOTFdUVFE3MStmK3pGUkFLNkIy?=
 =?utf-8?B?Ny9kZnRrMlVURmRYZDFrQ3JFb2ppaDBnS0R0cmZRSU9yalpQcGNGMU8vT2ts?=
 =?utf-8?B?bkJKQVlKTVd5SG9xU2JuU283WGVOTEwvMW9TNm1xaEQyR0M3RDkxVlZRMnJz?=
 =?utf-8?B?QTl0cFVtYklCU1BvclRNL1hvOUpaaUFTMkdjcmZEMm1mN0NoL1pUR09kZG9W?=
 =?utf-8?B?TGZvNTkxenlwNitvVEJFN3BaTUc0QW0yUGNWK3VUZ1FMakoxOXgzd00yVFg3?=
 =?utf-8?B?cXRFRnRzeXhKOWd2N3lIbG4zN3lyMkhlbi8rOXl5RERyak5MWGdOSCtacXZQ?=
 =?utf-8?B?MjVmK2c3aURUY2l6czVYL1J0UDdNMnV6NUY0VmRQdERjcUtYUmprTTdYcktE?=
 =?utf-8?B?ajExdEdjRWhYWlQ4YjZVbThXMVQwS200N29UMjNyam52eG9oZE9kb0dMTi9H?=
 =?utf-8?B?ZFk1TjJnZlBHajZtRlA4YnF1VXZjQVowNVZVVHBCekZmNFFoQ3FDKzE3UDlB?=
 =?utf-8?B?THgwZ1RHSnUwU1ZKbE51eUxQZmNOa3NjaXozdG1tTkJRUXd2bC83VWtDNENS?=
 =?utf-8?B?dWRWdER0MXNzd1d0VG8wK0M1eWNmai9QN3gvQ3o4eGxqSDAzYi9hOU05M3Qx?=
 =?utf-8?B?eG9sMFNqd0h1MkQ4amJGSkV4WGZMeEFPajNpcXRyUk1YUXc2TDhndUFVS3h3?=
 =?utf-8?B?SjVSdmNjVGZqeERKcVJsMDRtbENuNEdGaHZjV2tJbmhKbjdsVkliN0Z2VUJO?=
 =?utf-8?B?ZEZuTGJpMnU4VDJaLzdsWXRwTm52THlmeXhocGNlYW45OXFodnRqdW9ONXlE?=
 =?utf-8?B?S2l4a09nSFlQYkNrV1B1ako5SEFFLzFlOVVKRDdETW9uck9WK1VFTGx2aWx5?=
 =?utf-8?B?VkJ4eVQ1Q1kxa2VOTzB1bXUzMG9Ec3Nmc2FyWlpWRGlKekdrWVNBRWtvNDhH?=
 =?utf-8?B?YVZvait3cU9TZDNtMlNkZ0JyY0FwSG5FMUxSSnBuNWFKbFlrMW5peU4rU1hM?=
 =?utf-8?B?TDI2WFBlWG14LzJ2V1g5SEtKNHo2S2doQlRzcHF5dnVmbnd6ZXBmcjRNclB2?=
 =?utf-8?B?NHlNNnVaZ0FuUllCeGIyR1k1M0dLWXlYU3pJUDZBc1pNSW1helpMZkVsQnRp?=
 =?utf-8?B?Y1FDQXpxS21EOHFzSkJ3Z0RMK2g1SEYwS1RCV2NGZ1RlVHZCMW0vVXZkeUd1?=
 =?utf-8?B?dHhIT3hrWnMrdDl1WTA5eTlWR2J1T3hUaGE3RDk0RzVPZ0pISVpWNXdqZ0Jt?=
 =?utf-8?B?WWdZVW9wZ2xrRFliWDJuS2w0eTVDK0lHYmZlVGJNVG8xZ0Q5aEp5NFA3Nnoz?=
 =?utf-8?B?MzY3eDZHRlhWQkwzekhoMndLMmhXVFZLakdyTm5WUUczQ1NxeFdHOEVSdWg4?=
 =?utf-8?B?RGszRWp1REY3NkVWSjF3VW5VTWd4MlFINTFDaVo5Tks1cjQzcnNZWmY2bVVv?=
 =?utf-8?B?RkRoUkg0cytrU2oyclNVSzBodXp3M0JJSEIvYjJQYnFCZXNQc2ZMOHhtamhl?=
 =?utf-8?B?dUpHalJrZlY1OVNObmo0eDR6ckdQcWFMWUcyNEllaWVHR1BncDNTMGorU2lq?=
 =?utf-8?B?blhPakFTdXROanNrUU5nc2lIb3ZBM05qQXFxTjdTOXI3elJDazRGaDZNcWJn?=
 =?utf-8?Q?sflNdBsDZO4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERhTW9tV3Q4b1E1NzJETkFLRUZMOXlzK0VYNGt0MHBJU2hzYjIxNjNZVTJi?=
 =?utf-8?B?RE9GdTVtR0RFZW5ubVhPa05rSy9vZk5BSXpNK2hVempENnhwMXRjVFpNT1Ay?=
 =?utf-8?B?UG0xalRrZWx1ZnRicHhSdXN0MDlORGt4eVRDNXNxK0sxN0JYeWdGWHNla2lw?=
 =?utf-8?B?aXEwbktadS9uRmRadzhSRXg3M0hNWGZvVVpGMGptaFlRb3A1Zmxqak9QelFR?=
 =?utf-8?B?ZERoSTVwUVZuV1dkUDV6dDB0SDQrVi8wUFk4SjlhaVJmLzR1NkZXK1BtSmNx?=
 =?utf-8?B?RWp6ekx1R24wWjJxa2VLazc4SzZxcyszcFJYMlVBblYyRjlLc0o4R0VPUk9u?=
 =?utf-8?B?ZmJTaDJNSGR0TDh4ZWZ2U3ZaMXEwRVRwWUM3U213T3p2cjFUc05McHQ1RDRn?=
 =?utf-8?B?VlRScVliQXExbVV3TmF4ME5CNWdKRUJsbzJjWUFQZHVmU042RytzKzVVaVhn?=
 =?utf-8?B?ODJzRWIxcmNwc0t3S1FwWGxydDl5S3VLSzVqcDhIU0ZJZUdIOFByTUZ0Qjdl?=
 =?utf-8?B?RytnZy9oN3NjMDJHZDd6RitZckIyWi9MZ3Fmd2FCa1ppb0lPTWNNR2I0SHM1?=
 =?utf-8?B?SUtGQUlvdGRsWjdYcmNBQzZoWkNzVVBGTm96anlXU04yYVhtNTBPTURRUXp3?=
 =?utf-8?B?MStaLzJOOGJCZVJmNWJWSDlRUGpXcWdER0xLRWJOT1k3cG5EMU0yeEh3YjAv?=
 =?utf-8?B?MlZPMXpOajNibHdWMlNlN1NDVjMzN3NHUTZ1MFZVd2VoQzFmSDRLZ3locTNQ?=
 =?utf-8?B?amFSSDdiZWVQQmF2NDczalVWczEvSjZsRnNiQ2QyWGwyRHQ1YklPbFhsZmg5?=
 =?utf-8?B?WWx4WlRyNFlEdmc1bU0xTm1qN2NQM0xhSHJveUV0bnVPS1V2MUxKOU9TanBF?=
 =?utf-8?B?a0RIczVlNldsb0FpcHhSM25meWFkZzVLVDFqZlVYa3F1VFJtU284VzBtRTky?=
 =?utf-8?B?OUlPcDM4dHoxZXZySm5MZVNFSEZucUpaTC94Q3NYUmlUazNjTUFYK0JWeUl1?=
 =?utf-8?B?NmNXei82UmQ2ZHd6NTFhRXJWWXFWSmQybDhKQjdiSENZcTkreHpZQThGRURW?=
 =?utf-8?B?dHJHdXFOT0hmNFBRSis3WHJIejVGaGdlVnpsdEdQMnNsOEhZeHRRUWxFakw5?=
 =?utf-8?B?aVhHQWdwaHdmdVI1TW05bjJySFhBaEwxOGRVQmRpMTg0NkRyUlVrcExhTnls?=
 =?utf-8?B?T0ZCQ0pCbHpaZDJERElwZnN6MTZ6eWpsbldwaVVBMy8zY2loNDFDbDFWdmY3?=
 =?utf-8?B?VksveWhBT0JqWDJ2ZWxCcTh0Q21LZUQ0b3FnN1RJTWxMaGhXVW5BWnBJcGt5?=
 =?utf-8?B?ODFackR2b0ZPZmVYNGRuWmd5bHUzaXVrUS9BS1M3WitzNFcxMkFLWXVCNHdv?=
 =?utf-8?B?NVF0dFE2UEJMQ2tHYURycTRoN2NRRzIzbWQ0Z21pZ282SWNFeThjMktFbTF6?=
 =?utf-8?B?ZVNhYjZRa2VDKzkzTHFwVDI2MWdCVVpWeGZ3TWhCbWhIQ280T0RsTURabkxS?=
 =?utf-8?B?c2JZUjd2SFBIOW9XS1M3bHlrSzl2RmtmNFlxRUlRU25UUTJ6cVBnK2lEeEFn?=
 =?utf-8?B?Vksva1YzbzZXMW1kZ3hDajlvYy9HY0laTzlweTBsNVkycUZXUFQxc2MvM0dX?=
 =?utf-8?B?eGR5QW15U1hkaVpRTWZsQ2FIaFBVT1puTWJyY1FZS0FTaXJSaUFlT2EzaDcv?=
 =?utf-8?B?OWxoWXBqdGtRTXdTNTRhVmtNeFNVSzA1WVdVamhXYmN1NVlmTlRSSGdpckp3?=
 =?utf-8?B?eWY0VXpnYWFFemxhSG9YTUtFMTFWQlZTQTNiR0lsMHM4Y2tsR1dyMWRVdUls?=
 =?utf-8?B?K002YkpPR29GdGxuT0R6b0d0Q1lKWFhhMmFRSTYvbldRMFBUTXVFdUhycGRZ?=
 =?utf-8?B?WGhRcllOemJTenRVZi9pcDRuNlh3U0VUYUpLTGxoVS9pd0doN245d3E4V2dD?=
 =?utf-8?B?dEE4N0M2VTM3K1BEZmlPOExxVnlycHUzYTh1SnB4aURGdFJXeXc5RGRQUHNj?=
 =?utf-8?B?bVVkbjlBY2FHYWdFckFFcEgvbWZqS1d4NXd3V0d6ZmJtZkYzM3lDQjYwdG45?=
 =?utf-8?B?d3VMSThUYXA2OEVHRTNCbU9wU01LZDg4SDcwUEVxTFdKSFdKdGNzSm9hemZ3?=
 =?utf-8?Q?dTRETZy9ynzVkbgS+N04pdODc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bfa9f2-d0ae-4003-3e63-08dd91e70692
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:25:59.3159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DilY505qhX1SncB/f+crY6Drij5lMNUC0cSc5uvZn5LW0z7In9S6yPll/NZBgsSyv+dDHd9hY2dcARe+e7Nc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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


On 27/04/2025 2:25 PM, Maayan Kashani wrote:
> Add HWS support for IPv6 fragment extension header
> matching for HWS.
> Supported field is next_header.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ----- 

Patch applied to next-net-mlx,

----
Kindest regards
Raslan Darawsheh

