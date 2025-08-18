Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D0FCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 760E6402E3;
	Mon, 18 Aug 2025 08:28:13 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by mails.dpdk.org (Postfix) with ESMTP id EAC974003C;
 Mon, 18 Aug 2025 08:28:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN39G6WUyxdu++J7xOy7sPyqI6Sm7DoBfOc4xViBFozYcJwPthhPpBwCVwork9OUke6AfZB+rXapgj81WtY9Mggnv696oUV4gCyytaNkywOULXMt55/3Td7Pl6Rhs5yxUtoLe85otedSEZdtz8JWnPp5o/AX497zUDONo2fCysTdT3C5nBfu6M1mva5l8pEm+9M23vymkejSexOcyGvbejw2fEHbfG6bCulbEhW8D2omGY5+fg1O9dcdfbEq6S225AnEOiC/Kq48+yw/sMKrVYqJnwUD2zxZsWLCyq3dZCOAoFX/mmcMKmLzzjlxkzadh9dEC9ZLsQpjeIqNFUjqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6urenOoiEVBi3UMaBLwuqttAaxVcxtn+51BhHj6jzFM=;
 b=CcEpQ61ZONzagycrT35afHI5oPuV8fn7YkwQUd0YIenzIaD7j5NHtH8aWUz15qK1Kn9MxNa+7qmteNqohkx3GugPNt3pKKvkr1CparzW3LuzLgPEAm3nTFosZrkJ6v+YVTKvzbsKUr2dT7J036qbLt/SJeGWpxdql+2UQDyxNiyZ34lE/v7Sxc5/e1A4U7Hqr3ke/Kydtt1PmrVQypYlAsmel/t9lwT5K1sKPM0xKo/YcQAUg9TafdEiEtybQ4xOywDqW71YhxNsqjQXgWO6ZR83mV4UYeOGIM6rQsfR+R2XItTUAREtDUIDgJeIFT+JL2fvg7VVQJ0Njqn8nRBkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6urenOoiEVBi3UMaBLwuqttAaxVcxtn+51BhHj6jzFM=;
 b=qagmX0D6OPQMXiEEU5uHI96Zg9xeKEy2b+EUBAqbOZL1dYa9qU+8+/ie40SSYh/tFWrOoyfdvvbwTu8lR1mPz8peN17WDAefCfoFEG8Cxs6OjEOuYqB22vGOCNwp6UNAVX6SBBi4yv+WEPh9GVrzm2FSFaprlE9pjb/r9kVW1eeX7wNMTSWGi6XtEhpU5Wb2KXOOzyV0TscOdWEqLqNXm3UtDxpOC0bE60wnxbriFshiHfjrI0WZKrruvKn9Bi96BwLcabszCD7QMCQ21abNZdFc8TAFPRIgaR+zIiReiTr+38QoQ4F6FnxJu/YLtZ5eq6x9kF0SA5W/ZzRbaG2Rzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Mon, 18 Aug
 2025 06:28:07 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:28:07 +0000
Message-ID: <48b66c31-04a9-424d-84de-12d1cc8b2525@nvidia.com>
Date: Mon, 18 Aug 2025 09:27:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix min and max MTU reporting
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Didier Pallard <didier.pallard@6wind.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>,
 Francesco Santoro <francesco.santoro@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250716102546.1118749-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250716102546.1118749-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8496f5-acfa-489f-b8a8-08ddde206518
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU9INVhCR3M0RUlJMy83M2NwKytyL080RFY4YTY0SmZ4TUZxRzMrNjRSVnpW?=
 =?utf-8?B?WlF3RlNrR29ZYm9ldm1lMnBoLzdkY1V0dFk5cU1BSzZYYzNZK0NFQVJUY2g0?=
 =?utf-8?B?bG9mS0h5QVZ3Q1o1VUZvWFAvbkh5ZmRmdXpZQjV5cERSUmdZMHd3QUNLN0F5?=
 =?utf-8?B?eFcvWG50aTZxT1hPWnVtZitncjlPeU82RFpMVTA0RmFKZzlxN2YyOGxoNyt1?=
 =?utf-8?B?bkFqODE3QXFZbzl3UTBqaHJQYkVpQXpWOVlpcGpCdU5JQUhkZDExR1A3M3hL?=
 =?utf-8?B?M1B0TGRKVHowUy8zMG82MlE0M0Z6QzB4aDJGOVJQZHkwNTVYQ1ZTekpITmpi?=
 =?utf-8?B?ZWduZy9VUzk2QnhlTDl2Z2I0QnJzYUVTUkxVYmtkdHRXeDdwNmpxbEp0RGRl?=
 =?utf-8?B?UERva09FUU85elVUYmpheGQ5TE9PSlc0YlorVmt4WFQ0dUc4YVE0UnNpUVVY?=
 =?utf-8?B?NkJjU2VxVEozZGQvT2h5OHdaSnNtSXJSb0hCSGZxNStqcXdIYjFMZ09HcEpO?=
 =?utf-8?B?b0VjenJ2SVVJakVJTFIyc0h1QmhZTk0xR2FGTi9MREJJMkxYWlVxYlVNbDMy?=
 =?utf-8?B?cmlqOEdPaWhHVUtuTmFINGxoa0ZDMVBvSlNDNWpQbVgzSGJtRW11U1hKWG5s?=
 =?utf-8?B?M3BBRVBwRzE0ZWFKams3YmVLcGZBRzZxV1EwWHFkT2twdnZBNDdxaU1Pd2hP?=
 =?utf-8?B?angxbmptenZUNThuVlVMWmpnSG05REh1OFJjOWpwVUZhemxHU29Bd1o0ZzR2?=
 =?utf-8?B?STc2VUFXaWFHcXBNbFRoWk5DTG9uSE92YzdTQU8wc3EwNW1taTFLNTAxZU83?=
 =?utf-8?B?RGlKTDJ3YWlTQmwxOWxrRURPMk5XUFlnbG9FNXlkMHU1ZXArL0pYRzNjMStu?=
 =?utf-8?B?QjdKKzArZXNkb1pCVU9lR1BNOEpxNThKT0s5ZDlnQmMyekxQWmI4UXVjREhQ?=
 =?utf-8?B?Ym1tOWRiNWlTWHRSMmpaWWsrekM5dWM3RVQvZEJJZS9makN6VDYxWGFnaGY0?=
 =?utf-8?B?VXJoeFNpSVYraEVvVlJTUVMrZDVuYnUrSkdsaW0zaE5MVTYxNFYrdDArZnV3?=
 =?utf-8?B?K3JpYkU0aDA4ODRhVHlBaVZqcTVDc0p6WTFBQVFYY3VTTVRUU1JXaysyRjJp?=
 =?utf-8?B?aElOemw3VFVMV1FCbnlTSTI2VCtjSGFpaGtHV2ovSU1rRU1kazdrOWRNc2Nr?=
 =?utf-8?B?YlFXbkpmQ3FaQ0Y1VHhmYzBLQ0UvNzIvK2dRTk81ck1JenJpTGMyMWwwTDN2?=
 =?utf-8?B?QUltbDBGNnB3WURoaEpXd3c5eDlLckhjVGEwcDM2ODcvNnVnV0xwTCtWN2Zt?=
 =?utf-8?B?WDF3UkUvUUtOa0JaOXR3MWtGT3htcEVtczVOMnYvMDhEUHdIZnBJUUdPbzNN?=
 =?utf-8?B?TFJ5NUlwNjRGM0pFVEFndnVVV1Zyb3hVZnBkaVkwc0pXdXdBcnloay9rdGxx?=
 =?utf-8?B?RmdTNDlaZ1pWZDhxQkIwZyszV29pQndhUXlZUFNGUVN2YTMySnpZV0VLMTU2?=
 =?utf-8?B?cGwyQnhxWXRTNHRKVktTZnMrNm1hTng5UFk4YWRwNGc5WEFmYWxwQkRpN1JG?=
 =?utf-8?B?ZDFiS3dXSDJPR2s5WXhuS0JoTng0VkhJeGk2MFE2K0poU1lVcDNQWFZpRm9K?=
 =?utf-8?B?UXZQOUpwclRRTWZWN29GbWxnQWpWd2tYenN1bmlxM3V2TkRyK1A2L3kycHg4?=
 =?utf-8?B?dmJoZXZ0RnZlUGoyZjNGbHpBdkVkaXFicEQvVHM5OWhUcHlFeHduYkV3eDdE?=
 =?utf-8?B?T0E0OVhzblJqMkJsR3lQQmREMEd4ZDY4ZVR4KzNZSEVrZVFmb3VUaUdVYm5m?=
 =?utf-8?B?NEkzTlBpTi9GVUFCZDZxcnBrWlVOR2pSOXI1ZjNzRnRCRnltZnhzdGg1c3Zo?=
 =?utf-8?B?WXpCKzVPRGU1VkF6NCtmK0dTRG10Y1paeGZzczNNMmordXkrbldZR0lJcnFZ?=
 =?utf-8?B?UlNlei9yalZvSUZyS1VnY3drSDNjclZ2U2tMSlFHbmdtZDJrYlFWbFdsUDVC?=
 =?utf-8?B?S1RGc05welZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDl4cGJPM1Y1WWVaTW1ZOW1wcDJWQkhlZElFTXZQTCs3UGdhaExqbWJlUFpr?=
 =?utf-8?B?M0xidTZ6YUJaSHFwd2RPTmNaMzVZdW1jTFIxY1ZPUmxOaDJ6RUUybW5xajc4?=
 =?utf-8?B?VC9wS2hqQytTUFhTN1I4UGJqRWh6QlFyc3dBSG45U1pvL1Y3MDZiR1ZpeHFL?=
 =?utf-8?B?K0o4VVFSOHViSXF2MnJtbWNQamRNaFNmenMvUnEyd1F4ZmZmZmJYYlA2Zisw?=
 =?utf-8?B?d0JHeFMxRk1wUWdJQUsydGJkTEVwYjBpSjhEVEtMUGRPSGMrQXpWYzJKSkxN?=
 =?utf-8?B?cGt2K2hpc2NHZm42ZGk4cDhVeUJBbzg2VzVpd01jT094NENYK3B3K2dicDhi?=
 =?utf-8?B?aFRtclRVRmdKOU13ZkN2b1lMMzcvbGp3cTh4dUgvUjBZUXU0Y1dKNk5XVms5?=
 =?utf-8?B?NUdiakJHd09OQnR6OVpvNzZEV283V0VtcTlLVGg0SUxob0ROTTVHVmtsTmtP?=
 =?utf-8?B?bng5Z2dSYnZmSEdKemdJeUxpbmQzeGtMdklFOHFTeVlpUGNDcE5MVkNnMmdC?=
 =?utf-8?B?NkRFZXE3eVZ3VFlzQVdlRFFES2VkZkQ4NWgvNHdwZ0RZOUIvZ3pPNEdXYmhi?=
 =?utf-8?B?NFBabVkrS3VPZitGRVlmMk5UcWlrRkh0aEVZWTUycTY5RG90UitCKzBqeDBz?=
 =?utf-8?B?OXJRMWJJbHgzR2VjV3p5MGJZMWlJSVBMRkFZTzRkZjQrZkdqOXZxUGdueDhP?=
 =?utf-8?B?MFhRdGxJeS9JanZ1MkFCMmF0NldnNzR5K09yRXZoN3JjL1U4dStxV2NHd3cz?=
 =?utf-8?B?bFR2VitMTUtQZ09wcDRic1k4Nkl0cE5tNCtidWZIWXF3N1RTVFpBcWdmcHZ4?=
 =?utf-8?B?T2pjMjFZWWRWTWlwMFVzNDFzdEVHNjNkbk4yWUJ1Z2MzU2J4OFYyeE1Sd3FU?=
 =?utf-8?B?MkF2emlkVFp0NkxxQ1VaOWpyVWlYeHQ1cHZGbkt4VFVwcWxZOVlrSGF1MjF0?=
 =?utf-8?B?dlpVSUxYbGs3TUlzVDVQekJrcUtDa2hkZnRBbjk0ZHlycFhCdVhJaGtoNU8v?=
 =?utf-8?B?YkpGd0xmVVhTWVYvL01HVDEyRExZK1pzQVZGWmgxc0taZDR5VEc5T3pDbVRm?=
 =?utf-8?B?TSs3VkR4ZlNBZEJxU0k1MXp3RjZKd3VQVmp5QVlLZDR0aEpZZ1BPQmJXUExk?=
 =?utf-8?B?UVowZm5sTHpRT2JiZlBxRHlKYXFOTWV4RmRBNkl4dGxsM09TZlVJMi9FdG10?=
 =?utf-8?B?NXl5dmRUNCtqMGdydU1DZHVzVFBTaWg2L0l2aExtcUFadlAyRXBYMDZrUXRJ?=
 =?utf-8?B?QVlYSWU3TUNhQXIrTUpGNnBMM3NoUFVJR29jRFFvUXZyVUo2L25NQSt5M1pW?=
 =?utf-8?B?cHVZdlVBS2ErTk41SmJQeDM2SGdMWnc0ck04K3RxS2FFMzJIUVdSZWlnZWVu?=
 =?utf-8?B?YjVyeGxhczhDZTQva2htL3FMRXRkY1RML0d0Y2E1eFQrcFdRZ1NEUmZ0Z0xv?=
 =?utf-8?B?ZWxTdUpjUTRQajAwc2pIOWFtWGl2QnBjYlh3dlFKYzJaM09XanhhdzNNSWpK?=
 =?utf-8?B?VjVxVDlCcThlbmR4dUxYYThoU1p2SVhPekcwdDRjcCs0Sy95RnI1TWM0eEdo?=
 =?utf-8?B?VEhzSXZuRHgrTXErZDVURFdYVDRZbVRoUnhhTGkvcnd3VG8raHJHUDNCUis1?=
 =?utf-8?B?NTFxNVllTTgwZmEvcWtzc2hlYTBMekp6RlFtSnp1MFZReFNmemNoZ0wvdUFh?=
 =?utf-8?B?bVg3S1BnTjIveFVCM1ZWUWRnQlVKRkUyV3FmaVVTWU01cDdvZUVEM3RsQWlv?=
 =?utf-8?B?VjdTV3J3M0tGcWxxYUhiV1llNGlTUHVQSjNIdjJaQWFFYmh6MFI0UzFyNzhG?=
 =?utf-8?B?ODNLblhrdm9QOTcrbUVydTlhM3RHYzU3dFVuMHV1OHhzR1FtZE9WZ0hPUGVo?=
 =?utf-8?B?Ylh0T2RtY2N5V1Z1K2dFWmt3VmZ4WFQvVGtoTCs3YTMrSDRVcDVYYW5RM1Yz?=
 =?utf-8?B?dHJWWU40a0JCUDI0bTNVSzNERlAyZlN3WHIwSlVPMHcyQmw5OC8wRGRZUUtB?=
 =?utf-8?B?WXl6ZUtxNy9pVHVZamFSc1U2TGpmK2puVFRHMXJydVdpQWQ5eDBieEZ0bFdV?=
 =?utf-8?B?R0tkMlFWL1NzdXVQRXlvcmg4N1NiVms3dVdOSVJqcEF2Qlo4S1luRzd4Lzdt?=
 =?utf-8?Q?i8JCY/wtEC6652HFvVPd1msY/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8496f5-acfa-489f-b8a8-08ddde206518
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:28:07.5670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBU2se2/Bkj1oczJgbiBzuoaTtsug1LFc6ELjCkoWUIIJi0pxPcQ+Oj4k8yUHGkua9VItGGhauwc2xVbBFS3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
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

On 16/07/2025 1:25 PM, Dariusz Sosnowski wrote:
> mlx5 PMD used hardcoded and incorrect values when reporting
> maximum MTU and maximum Rx packet length through rte_eth_dev_info_get().
> 
> This patch adds support for querying OS for minimum and maximum
> allowed MTU values. Maximum Rx packet length is then calculated
> based on these values.
> 
> On Linux, these values are queried through netlink,
> using IFLA_MIN_MTU and IFLA_MAX_MTU attributes added in Linux 4.18.
> 
> Windows API unfortunately does not expose minimum and maximum
> allowed MTU values. In this case, fallback hardcoded values
> (working on currently supported HW) will be used.
> 
> Bugzilla ID: 1719
> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

