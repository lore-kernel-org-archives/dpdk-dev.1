Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C63CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 08:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F91840668;
	Mon, 22 Sep 2025 10:32:03 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45]) by mails.dpdk.org (Postfix) with ESMTP id 8CAA14060B;
 Mon, 22 Sep 2025 10:32:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb7tZhtqW8Mh90tQQY9c5pIIqO7ECIrle4hKjGrz+2Qlsd9BH3GJUaGo1nkYrEsX9z5rG7h1C5cU2nWHPdut39nKNgWt0x7sksA722A5qPQFDfV8OJvd0N2LjM3FaTgax1Tu4HIrhJU0LblWELfNp2Q5ihc6/c6sgAuPKoWOxpM153VmA9+gRsCq6l8yd9wt9YCdqALMC/nPOsTDFR7K/Yxq+6L6vswRdz0xHJOviF8o4VHUeUvdBOVUWaHJpdyDV5ixUjT/pbm0bjttV70zlR1zCrcRXGwZtsmv0m6dFaeMRG5NDXdnbaplJWctTpaqLoDYnzbRxLXzzVVYLldVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfQ9dcQTAIeZOv/23N5TrKbt5RLzR0TRd3Gg59GcY+o=;
 b=VuTmSw7NrzhkYPg2utYRFr5f2qGPnrtumZwAxzE8z3MT6EHQZEE/84KOwkcZc48oS4lEce87G50hWAKlRsSwSbRn+jfUED5TBG/vGdU+cB5PzM8OYXt1mzH166Kg6HyhNEn8StATOD0U+7zBjrjvhdUa3EEtLWw9INZizAnYGNmwVSrfxNJPaLUSca8gF9bgwXlT87pXNuSugJs93pcQXhjNrpOn/5FJ+y7N1nGOSywCwpF4KNc4PiSjZAYJWc4G2LzeAoWGEami5kfg6WksKWuXH24VFGCAC2h58qLfEe+SbFmJf138P0QFDafNwkmudfyTsLxQVmxknNfl5fL5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfQ9dcQTAIeZOv/23N5TrKbt5RLzR0TRd3Gg59GcY+o=;
 b=rODNiL30JaV2vi32Fd+ZRNpqeCEPuGHvzOJBh/K0WVv4LIVehfSTW880fS4VcEimUbue8FbizFolvcHu/04LSctxAWEdne9UekNJf4yY6vLpzpTtyYJPq5230zDmyIbFwetYx3h4RYRk1ndo8LYvVI8ewbZ8GQ99a4H+ehefovIneQ5Xsq7k2pFJPrLl62CRm68CKmaCS52HL046K01eRmBNNKPp2ZTKRb3PcnqLdUDSQjlbtl+4YxaR+Pht+gCIb9t7vHKWgvbUSJ5KP3CAAcOpquA2VnaI8IzijDLiI0ALUI9ViBqfzje1q2WvYzLhT0pYBggVCtd3P/WQgHo/1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 08:31:59 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 08:31:59 +0000
Message-ID: <70b5405f-a866-4cd9-9fd3-88cb24d762a3@nvidia.com>
Date: Mon, 22 Sep 2025 11:31:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix missing next proto in IPv4/6 encap hash calc
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20250915104013.165130-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250915104013.165130-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3ffe56-9676-47bd-9156-08ddf9b27f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGxaaWM2dFBHY2w2bEN0bklCaitNczhTenY4VmROakNTcVhTU3VzeklZS2VS?=
 =?utf-8?B?OWRZenArWEdFS1NSOTAvOEJGaVE2VnZhZ1RWczVQckl5Q3lpbjlPcXgzSlZy?=
 =?utf-8?B?enJSYTkwVFBoSzhLcTdsVmlGY3lnVkQ5TklOb2VVWDFPdE1BaGQwTG9yM2Er?=
 =?utf-8?B?NTNuNzNxdWlxejJOV0ozNFp6Rm80ZGhONWh5YkRycHh4Vjljd3JkT25MTVVF?=
 =?utf-8?B?dWh0RDlwblh5RWQwbEhKQXQ0MlMvNGtTcGJReTIxc01NcWw4Mnh4WUtVSGNO?=
 =?utf-8?B?M1RScFNqbjdxMkZXclptNXdpRkxKMHFNSy80Y2JNb3hOQjh4K0JaR3h6Qmdx?=
 =?utf-8?B?TUxmTC9XRTFDSFpJT3I1TUxlNFVlaHllenpwMmRjaWZwcXB1V1lKTnR1bEdN?=
 =?utf-8?B?WFZYeU5abTVaNWRuYW5lV0JHbWFNYzRGa2F4ekxId0RERW9KbDg3QlhmMkJI?=
 =?utf-8?B?ejhJOWZveGd3eWJ4YmkxbmZmYSsxL1JESjgvZ2JZemtLSjFiWWVuKzZqSGxY?=
 =?utf-8?B?ZnUvSXE2TXFsV2toMXhPZ0N4MXc2Rzd0akhMaXBJWm14VlBxN1RnakZMZDd3?=
 =?utf-8?B?a1JzMlhjazIvaHdPVitURVN2Sy9JamlKcXczb1A5UmJkdzdGWEUyNmFlZFBk?=
 =?utf-8?B?WGJBOGs2ejFRUjVEbGpSeFdpVmw4N0VjWnBmR3NxMDIvU1RxbTN0S0llNkJQ?=
 =?utf-8?B?UFNKWHNMemRxSjNFOTA5ZW16NEpVOEtlNzYvcXUyZ1J4cm1zUmxWclVpUG84?=
 =?utf-8?B?dlZJaXJFSzV5ajN2L2dYcGgvUmk4SXJCNlk1RnhaZ3p1WUFhOFpTQU9qd0dL?=
 =?utf-8?B?eFFDOTZSbDh4RVdzNGZCNWlqdG9uZ05kSkREbmlwWUZCUm1ka2pDcWVDZGF5?=
 =?utf-8?B?TFNONXBJcEtUMCt3RmNyVExSQ1NYc2NRU3loQ203SVFFV014TVAvRzdHSVVj?=
 =?utf-8?B?SWNzaENVRzMveHBPNXJyZk5JUlpJZzBYRkFkUis2ZHZMbUZRdDlmdlJFenlY?=
 =?utf-8?B?QW9TVXFadVRxS1loMG9OaVBqd0pkQm5RbFhsYjg1WUFUNk5XaDRoVDlWczVj?=
 =?utf-8?B?dDZFS200U0RPUTRBQlNtU0d2bFlIVTVLb25hVE9tZzZGKzBBUkx0YnN1OWpD?=
 =?utf-8?B?VXZ6RXIxWHc0SWhUUWgvTTZHbG5tMFU5THFKb0ZiY1hxaGNsS0xqWFVkOEo4?=
 =?utf-8?B?N0hIYm1wUEFYRGhuc1Z1bTZFRXkxSWFmVDBYUTRuZ2dKbGpDYnhpTXNNd00v?=
 =?utf-8?B?N3RKR3lXUGdRQ2F4MkI4RUNIYVJWRVhKMjF1bkYyK2cyZUZ4c1k2Q29TdGJq?=
 =?utf-8?B?TXN6UkhkVFZpMHZ1a1dyd1ZtVmNabDNLSjZFS1lJQWlwS0tDMjE4NG1Lc2hh?=
 =?utf-8?B?cUttbCtaUCtvS1FXSEVkQzJQNEpkUmVtZk0weHdtdkljblE5b2l6VnJzTHpw?=
 =?utf-8?B?NzNueWZUTlBMa1hQZEpLWFJMb2xMVUtrUTZ6ekwzUHQrVXV6WGpaYkM3VUZu?=
 =?utf-8?B?NjFqSjRIQVVpdVVOZFNzRXlROU84TCtxb2xyTnJzZTZKc25YMFlmSXNMQjhF?=
 =?utf-8?B?Zm5adnlRS3ltdWUyUmtXY0hva1FGbE1vTzRCRUw2UVc5eGVpUG5tODc2RTdT?=
 =?utf-8?B?OW9DYjlUUVg3UW5xY1dWWEU0akdac0ZiNi95NHRVbTBCSjBqR2hjci9ad1dD?=
 =?utf-8?B?eXJmTGlYNjQ1RnRnQkJsMkIvSUtENWFPemE5dVRIOXZoaEdET0FnM2R2a1lL?=
 =?utf-8?B?Z1gzVUN1SVdleWJhYVl0STNEQmozUkdnc2ZzbkppRE5zTlY2ZzZCbXZBbzRq?=
 =?utf-8?B?aHVlZmRjM01obnNYdGJJL3M0RmViT1VHNXFlcmpZcnQ4L2dEN0tHa2xLMEJD?=
 =?utf-8?B?dWluMlNEQ2IxQUlKL1FpZGl4VWE2bEhjS3ZsczU5QnUyUnJyMU5ScmoyRU5V?=
 =?utf-8?Q?kkETGs+4ymQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3V6Sit6TXpUSmJwNmNTemZ6Qm5OY1JyaWFVTmlHdDRSQmJ4V1VjdHBmbWFJ?=
 =?utf-8?B?WTN3UjlFcWlhY3ZGcFI5azYwRDJPWjdBNnpneFlpcU5hRkhTd2lhK0lsOGNM?=
 =?utf-8?B?ZHFHRUhyVEhRZmQ2dG00cXc3aWJ2bW5yOXNxVVlTZmN2UWV4dzJZSVlQR01v?=
 =?utf-8?B?RHpSYkw1N2RQc0xVVGQ2MmQ2NmNwVEdXejFaMkVXb2VYYkpibTczSzlkcktP?=
 =?utf-8?B?OEl4M2YzYzViVzR2b3RqcVd6Z2ZNTEdtNERZdzc4MWRXTjk5TElWRlI3Z1Jo?=
 =?utf-8?B?eHlwREg5Zm5IZ1dFNjFKZ0d2eGhTZURDZDZvTmVKWjhXclVRUXhEOEFLUnJH?=
 =?utf-8?B?NlRCRmh2RkU0OVk4eTFIV01LNHcxN21wWDZSMmNkeFJ5V01wWDBCOXI2Wllz?=
 =?utf-8?B?QUNFMlRnbTVSZWN5RmVyWkRUYUFVS2gweG0rOWdOOE5QREdGSys0blM1WFpD?=
 =?utf-8?B?bFVuRVdlMGJWSjltZnRRRzZvazN6ejFnTjVoUUdSY3Y3Sm5EZWVyV25MaDlB?=
 =?utf-8?B?b2g4N1dzRDZsZUxvaVU2WXFST1dVeG1NWW10ZXJteFVMbGgzVTNTeGx4eWtP?=
 =?utf-8?B?TmQwdUZySXBLdENqQWE0MThVRS9wWEg1NG9LRFFmSG5MRU5LZmFvYXdHaFFJ?=
 =?utf-8?B?Q2hHeTN0ZlljL2JBekVnY0s0anNyRzlqM1FPam55dEZwdTEweWlRbXU2ZEgw?=
 =?utf-8?B?K0orZDN2NWg0UzZ5YzdxaUY0eUc3cDFRN0QwS1MzbjgxbFNKVlVBaUdncGo3?=
 =?utf-8?B?N3hzc3M2MDJDRmV5YnBvQjZuR2k5QlVyQ1M0bDVCQ2VBTUlvRGtVcHIwSUpx?=
 =?utf-8?B?QThqcmF2NENGQVNCSUdydW9XRlNyRFJCVnlQRFFELzhoSmxUL1N1R3hGaUVW?=
 =?utf-8?B?eWhPVEYrbm1ldVFnMDZvSFAyTHpsM3FQOWFmUksrSU9vV2ZCcUoxWUc5WTRj?=
 =?utf-8?B?TWwyWWJZQllZYmtoL3lLZnUwYThJUjArVVU0SFhsQU1IeGZPWUFSN3BnTXRC?=
 =?utf-8?B?VDZyMmQzWm1JcVUvM0E2L0pBNUtJVmNiTXIrdFVHWC84dVF1ZkhPTkxkbW1D?=
 =?utf-8?B?QkYwNFBEcUZtZHRPYmNiTGdaQmVleXNHSkRQQ2JDVUFtdEdvMXFwREh6KzUx?=
 =?utf-8?B?UFp2cW5XWm1hZEpHZ29sMVdmMURlUG96aDhxcCtIY1UrMWtZN245bzFEVVZV?=
 =?utf-8?B?OS9Sb2NxRXJyNUFGU1ZDZUdkSC8wRUdiUzNLQ0kxUHlvNkw0blhjbTFoSnU3?=
 =?utf-8?B?OHliaXJBbFJ5b0xKY3RINUR0dkx6YjhDMTN4VXlLcFpCYUVSQllSa0NtU0ZP?=
 =?utf-8?B?QlRoYTVXaHNjRlF4aktkdzUxTlZqN25jRWlPWnVHUm9saGlNZUZoZ1BINzhn?=
 =?utf-8?B?SGFmZHFLcFJRK0F5Q1NjNktEckxxSlJtNGxWaDRocEtZbGZmb3R5UHZveHFG?=
 =?utf-8?B?N0JwangvM0FyZTJCdm1NL0ZCcjliRWhzbUNzejZtdllaZkVtclFOQ291cm1L?=
 =?utf-8?B?R3NUbUdPQUMvUTdnY0FEK3l6V1pIK0l5THRMM3Jid2dpSEZMZExHS2JDcSsw?=
 =?utf-8?B?Sjg0WnZUVVVxL3FyRThiRGYrbkloSXlrM01JTU4xM0hhaXRVUDNHWlZMRExl?=
 =?utf-8?B?aTJzeXVZRi84MVh0ZzhBTGY1MDhzT1NETlBZVkRCWkhEdXplRGFWM3pDdzBX?=
 =?utf-8?B?MjFmb1VlWE9Land1c3BpWVFobmRNRG9Obk5JaVRhdTZ6N24xM2pZYTQzcnVB?=
 =?utf-8?B?VXh3RzUzTHcwZ0N2ZDE1TVZ0Rjg2S1p0TzhITHN4S0VIajFJTCtCc3hGVWdi?=
 =?utf-8?B?aHhib1orbGZGYlpPQkxxM2paVWNIRUpyWmw0QW5JZTFCc3I4Mkp1Zi9MdTJ5?=
 =?utf-8?B?SDJJRDQxRzBhR01MaVEyd21GaGtpcFpkZjJHbkxYNGtzbXUwaG9aRGJHVUM4?=
 =?utf-8?B?ekxvOHVIancwQVNENTBKdGxqT01tYWNzZTNvcm1qdlh1ZEFwSlhzRlFKZXVB?=
 =?utf-8?B?VlN4TDVLUFBrYnVpQ3c5cHhYUU9SSXlSaFpYZDNZa1JyTnNEOXVMSXZ3clhT?=
 =?utf-8?B?MnV0Wm9uZ3M0UC9Ca0FtSWwzMTJvVkpKOVBYOEhYVElTd1Evb3VjOFRydzEr?=
 =?utf-8?Q?eLlbwz7nmJQianYDVlN++wy4h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3ffe56-9676-47bd-9156-08ddf9b27f06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:31:59.0264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7ICjysZY1qeIXfvjoO0PeXA6tWWFZcDuk2sQsvO4zMmfjwA9xDFsW8i6SbHj60CqQAabFv8BuUfC9BpmKRogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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


On 15/09/2025 1:40 PM, Maayan Kashani wrote:
> Add missing memcpy for next_protocol field when processing IPv4/6 items
> in flow_hw_calc_encap_hash function. This ensures the IPv4/6 header's
> proto field is properly copied to the hash calculation data structure.
> 
> Fixes: bb328f44afe9 ("net/mlx5: support encapsulation hash calculation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

