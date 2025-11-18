Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F5CED61A
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:29:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED7AD40265;
	Tue, 18 Nov 2025 12:29:05 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by mails.dpdk.org (Postfix) with ESMTP id 1934640150;
 Tue, 18 Nov 2025 12:29:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbqcW+Eky5gkHjkZzJ8D32GCwdw2mA+JW9r2elN1TrOJxTva5BeX2v0SviYwek6f0RwZ2LMbLlCZD1u0nVwoDhe8WWiRBnOpKhJQvSd1gONg8fA9Syu7yPiYvX0w7iOX4+PPKqFwNhrAJTbm8B04DoBNbQGDf7dDC01+5OwJGF+U+GJKsESmKpuGDKSQbgTc5Qo/uD96RTpwLWIqMWpRXQ4PyVwIpGUNG4SXS61a7HCloNnDQW/NwkHF8TQhtE9xT7IAsTuQcp3wyZwgN8mvQhca8LT+W1xu8zMM6goheqHzrWFowVTL7lQDHjpT29MRWQeKlASu7oSVt/Ct99plzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6bfl1ucVn9uNIat/Oscci7zRkVJzDsrap34wARNHSU=;
 b=oHILoE3a4YLs1VxShXLJH++8HquLpxMegrErkeznVnCIj5HGEXhrNPj5z0mt6K7onIR551th90hXUQcRKq/Yt6xAov4tSvvQPQLjz4HiMbmMCs4Fp/P//uMR+J6OYpC22eym694+cHCx93RNKSRvUrixQTWY1wEot309Eg9vQOLybG/djt7tiKz5MuZpl49QU3eZi9+gKDXHeBHdN/DsJLVdFlRMnhE4E1jWjkM3DqRnAs2fSU5LWnm2mAq9G2Xh/ciNhWq0CUlkSbiOO45ta8OD0/oT3nApFa1WL36NNLuFAHxFs0JJAKc6zNrXg3P0osreyOHGZTN8lmnQcXLnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6bfl1ucVn9uNIat/Oscci7zRkVJzDsrap34wARNHSU=;
 b=Yo8DGPAtYVOj3dJ3NrsolHqlo6fuH1II+PcVZY25vB2A8GPfagltO/omf/P6Wk4V647BJQp/MSXkhQU2B5zDSEIp3fST0h7ILG9ftF+PU8AbxiTl+n2NgTqkGI0tJemb6lqLrqaSBEUCCdDnRb7uqyMDJJcuYoa0HkuVYebdoOvaF2Mb4M9a8efD+rq5uahsYg6sFckvFwbbwM4EsOGiH2iw9ZUWy3OYec9wHPUnUXzisALNRfXCdFC2kXejv0RAU1YCPxiTVXOdHWUGSMr4+Zjif/iaZ0TLpo7C5pQS1VA9WzlaFC1KJGJ1j+Dr6NoJDPPnwu12F4h12TYSkzLRhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:29:00 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:29:00 +0000
Message-ID: <06b85cd5-1a26-4b2a-a74b-c77451a6e423@nvidia.com>
Date: Tue, 18 Nov 2025 13:28:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix null dereference in modify header
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
References: <20251116121026.180707-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251116121026.180707-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: d1158633-84c3-4205-6a53-08de2695ab55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mk4welExenV2eUVzN2hDVTZkbEFzMkpwOHQrNGR2NU5FMHdHb0FTbS82UWxR?=
 =?utf-8?B?dCtpaE5wOVZ1dGdQaEErRkdwbThFT0ZzMHQ4a1RnMkhTNzdXRzhzVVdFaWhF?=
 =?utf-8?B?b29jQ3JKOHRQR01zOWkzTDZnMmgrUlhSUEo2V1lwTm8vR3UwaWZmN2ZRanh1?=
 =?utf-8?B?QkJLMld1bVlyRjFmb2ozdk9rY2RTTko0UnFLUTE2aU54eFNTdzNQVm9VMzFN?=
 =?utf-8?B?a2w5Z3JUV1g3dWlqcmp3Ymo4Vkt4NUh3Y2dDWjJmZWtPdFlXc1lUVWVsL3B0?=
 =?utf-8?B?UWx0aTFrTlF1ZTRRMm8zUVhiZW0zZUxjWlZha21HQjU2MU5jZzdoVzh4SjFp?=
 =?utf-8?B?TUQ5bnA2bHNMVHFqd0p6Y1hVTTB1TVUvdWN4UTkrc2lzVGdtRzJTRlQwWkZP?=
 =?utf-8?B?K0JSNDI3UGdiYU5XWldFR1pYTzEwMU40L0p4dFA4aG5uenU2OXNlK0NpV2xl?=
 =?utf-8?B?emNsMStPTDYrQkExWlo5Q3dVT09tTGp0UlJQcDZrbmI5VGVrckQ4aUR5L2pz?=
 =?utf-8?B?SDRPeGhiVFcrYWJKVkE2Zk9yYS84S29PQ09vYjlBb0hkeCszak5VZGtSTE5U?=
 =?utf-8?B?Q0FGczI2KzB5M29mNGlXMjQ1VGtFV0FudWFEUWFzcEI4VDlIeVMvdzRSQ3Vu?=
 =?utf-8?B?bm5sd3RRRkFxTEVPMjB3L29EV0FCRmJLTDFYY2lNa2p5UWQ3V29wZWhKMjZk?=
 =?utf-8?B?c1puWnFqVWhNUWdtd2tGL2ZtYmlUaE1TeHZYQnlJeUI2eFVxWDBNTXJTYWJE?=
 =?utf-8?B?WFZVU0pMSXVFSnRJRkpmTFlVVURxYnVrSm1lT0lTY0UyUTVNM2VsWHY5NG1z?=
 =?utf-8?B?SDZXUy9ZVTBSdElkVk9GNUlPQWdWUmJQVWhXZHdab1ZRSUdST1htVHBwYTc4?=
 =?utf-8?B?eUtDc1o3UEdFS29qdGlwN0RaOUZkMG4xWlNnSVRTS3V3enJ6ZVpGV0d6bmxt?=
 =?utf-8?B?WFZzUS95WVJPNnliSFZWcTlyV3A3Qy9Fdm5LZFJWbDFlcDlDTzNlT1RBY3VX?=
 =?utf-8?B?cksrS3lOVWdKU1dvQnlISk9oVTBUUkxieFpmbmpaNThlY3BWUUJ2QU1tRkln?=
 =?utf-8?B?bkxCVVBmbmZUcXMvTGdjRWM3MGcxa0pzY2lBc1dacXUvUHVYOXJmbk5EZm9s?=
 =?utf-8?B?cnA2Q3FjLzV0dVRFZ0RHRm5CeldoajdHRENieFdOUFlHU3dVS05WQ3liNDRG?=
 =?utf-8?B?Uk9sWEY4bHlVVjE4dExNTDFrcHFPLzJ5Y3dHTTRHS2NseFBKVHNDNzJyT3FJ?=
 =?utf-8?B?T1RtU0QxNlNjSEhSMWlCRy9UZ2VGbGl1aWN5TUdUUHk2VE1TVzd1THZ2TnZG?=
 =?utf-8?B?dDZkUFNXQ0VLUlo3djlxREJqM3VTQmxJV0RndWlobjVUc2pDcENGL2RjbVhD?=
 =?utf-8?B?VjJtWWhkM21QTnJxd3F0QzY0VzJLOENPMGZVZWxHMlVKZmVWMExzVERiZzEr?=
 =?utf-8?B?Y0ZETEFqdHJmZkVuZ3JFUEJlMEtDV0RVQWdRUXNpRmcydS9SZmNGdTA2U0ts?=
 =?utf-8?B?SmN5TWhPVlhqU0J4WW5tYTFWOUJPUUtxckR2Sy92V0tMbW1lQk9vYjVMRnY1?=
 =?utf-8?B?aU1UZUhZeFFOcnNDVHFSak1ZWHVUZGdBenU0TGxDZ1Q3MzgxckJSSnlaY29k?=
 =?utf-8?B?RkVqODN2TnhwQmREb1dmV3hzL3p1VG9LRzRSNndyWERLd0pnRDZTNXRWUENP?=
 =?utf-8?B?UjR3eU4yUlBuSVNEdVZLMnYwcEVpNnNKemtNWEI5aUZIWXMvVUUzT1RuSVc5?=
 =?utf-8?B?VzZnR3h5eUZKRi9NbHlGVzZWa0hOMUFWdEhLSGJhSTQyNVA1RWRxcXNkS3hG?=
 =?utf-8?B?UHdqNDlBczV4SGtiNTIvNnBHeFJybHhpTzNuMnErZGYyWHI4Y1VBM1FoeTA0?=
 =?utf-8?B?S0YyaW9ibDVEaEdPVDZEYXlpZ2FyTHFTRzB6MTJLQ0VnMkVSQ3NqVkFsMUpt?=
 =?utf-8?Q?4nOIdPfIyIxObr8ODRfp3oq3Tpvqkon/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG5HK1NEaWt0VS9HQkcvYnVXdzBSTEo4NG1nQ2NrTENiR2hnL2QxOGRLZjZJ?=
 =?utf-8?B?NHlYdzhLMHVuNjV6cHc1Ymh0dFZua1poeC81MjlreC9Eb0xDbkZ3aXRONDQ1?=
 =?utf-8?B?L0NacmNyVktlKzErREppWENiamhCK2lBa0NZL1grcHZNL0J3NU50VHA4ajhx?=
 =?utf-8?B?dWprNzVJMUpjamhkQUErYmVyckQ2QWdubmNvUDNKWUFWYXU4d0ZhenlHUG52?=
 =?utf-8?B?enFwZk9CUm1LSnFiVktQT1VDc2FjV3hhMHFBOFAwM1dpbzlsWk85NzhaOGQz?=
 =?utf-8?B?dmFXQUhROHdjdDh1TjhSNkVjN2hRa3I1RTRrZnN2ZzIxVWkwSHE4bHM5SzF1?=
 =?utf-8?B?UjRoTFB6dGh3NUEwc1cyRG5ETGxqZi9lekdKNVEyUHpCcWpZSFBPMlRvL3lJ?=
 =?utf-8?B?M3VOTXN4MVZraUkyQTB0YWd5Q2hKOWJDUkRwNUVRcEhSeVJPVDJOYUVieXR1?=
 =?utf-8?B?K25na25tTlFQankwVm82dG9ncGJqc1ZPWVAzTUsvVUJiU09ZWTQwTW02ZjRV?=
 =?utf-8?B?MXJRSU4ybzNQcitQSThIVmJsTUZPRUhJaFpoNzJkWkhaKzJHcGpyT0x1bjFo?=
 =?utf-8?B?NG5kb0t4bkFBd0VOM3BnQVBpc0R2U2l6UDJZT1RkY1JIVjM1cGc5aTRFZ21o?=
 =?utf-8?B?TnJzUnNLY2dzY1hXQmM0SXVFNHFkUEdaTlMyZDkwUElMNVhSNVhwZzdwOCtq?=
 =?utf-8?B?WlBZREtVNzVMQTZ0N1drY290RVlCbnZvcFVjL3BseUhsVEo1TjZTRGJLMVU4?=
 =?utf-8?B?YWFBT1dyaEFMOXQrRFpTNWJOQmdRMWthMUpzZnZYMFdIRys5RGlic045bkdi?=
 =?utf-8?B?TWF5cmFpbWFUK0N6Qk94WFVkQm9sUnkvSFVVM2orRDBxcUlHZ0p0WlpmWGc4?=
 =?utf-8?B?YlM5N3NBKzZUSXFuWlJkOVZrMXhVdUptRkRlK3ZtS3pCTi9NVDB6eDV4MkZk?=
 =?utf-8?B?UCtXTWRSa0JISHI2dFZBUVgzaXJJSGxxNjlBQVhJcmR2UUw1WlY1T2lDU1Bu?=
 =?utf-8?B?bUh3WVZ6VEZOV1J5T1h1TDZQYjZLcUtKSHE0cEFuc0xGUmxoUGR4MFltVnNW?=
 =?utf-8?B?UDl2RkFxVjhGcFpxQTRKNEYxSUpFRk1HNXVxMWtxQ3dLSnIzSHVoMnRIcXVX?=
 =?utf-8?B?VWZlNTJJOG41b09mdnlTWWlVMHhyMmtSMjlYLzl4YkVqNms4RGcrNVJiazRv?=
 =?utf-8?B?bktLMDZ6ZDdzS2NyTlpSMkVPNTVBd2ZLTmZXUVh5cDMvRFg4SUwweUsxbUJt?=
 =?utf-8?B?Q3V3SUhCZTNDd0VHVitDWWtQSklxaUE1Sld4N252Tm12TkdhNVIzYWg1NURS?=
 =?utf-8?B?ODJ6b3Bhdkppc0x1cS9lRlFvNXBadXZMYTB3M0Z6RHgxaXI5b0NXTStUWERM?=
 =?utf-8?B?VjhsYnFONkJhTDI5Wm1iUlVhTml6YjlOUkdxSDRoUWgvRU11Q1JCMXZnYitk?=
 =?utf-8?B?L0RuRHNYM1hSR293N1NXNlNjaFJlNWVwWHRDL2xqUmkxSWZXemN5MjV1dmtl?=
 =?utf-8?B?YlZqUGE1dlB4UWpwSDFQSjNXSUtuWTJJUjBmYythZ3pkSk1JNWdWVGZFZ2hR?=
 =?utf-8?B?U1k2VmVDbzBwSWoyWWFidHU4ak9ub0NkZkhsajJaMVhHNlR5cm9YRUJzUzZl?=
 =?utf-8?B?cytxRkJxdjNzandzSVRRdFVRSDNIYkFOUk4rTTJjUmtvdUNuTGo3L2pGalNS?=
 =?utf-8?B?NmF5UGZOUDhNbjNoMTdYa3lHaHpLTDBNeGt4Z0xyZVA4K0hia3hYUi9Ecllo?=
 =?utf-8?B?RWRkMndMdWd5TEN4bHg1Snl0YXdRK3BhNGpiL2VHQmhBOTJCK2puSVBrcWRp?=
 =?utf-8?B?NTRXakxOeUExVkNhSTl4NEtSV2RDbElrK1p2dklsSG9jQTF6RGM0bHZtcVBD?=
 =?utf-8?B?dXBtTERvem5mb1puR0dxSEt2TklKMVo2dmcwRnp6dmw4am0wMTBlVDRLRC9Y?=
 =?utf-8?B?djBNckpXcFRVUHlwNW5nbTJMLytldllib3BxYW9nM2VMQXVsc0l0Z2lOUVNk?=
 =?utf-8?B?bkUwSWxORUY0RFppSE5SMkFjTXUvL2lLNGQ0Z2Y0TllxdDE2WjE5bTR6c0hw?=
 =?utf-8?B?b1dMMnFvMGRVMHBITXMwTWZ3NDFmdVVZRFYwMWtWNFg2UElBZmc2NlUzTUpo?=
 =?utf-8?Q?IeUWTJag79wFs0TEYC0ogrZU/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1158633-84c3-4205-6a53-08de2695ab55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:29:00.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdTJsEtk5BqZYnKOgoN+rEqLz8pfIsNqiM4bSJ2k1ATqNWalQmaFtAPAcGlANVgy8MdRUGzEzMdxE3cmJO/SRg==
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


On 16/11/2025 2:10 PM, Shani Peretz wrote:
> GCC analyzer identified a code path where acts->mhdr could be
> NULL when dereferenced.
> When modify header validation fails in mlx5_tbl_translate_modify_header(),
>   __flow_hw_action_template_destroy() sets acts->mhdr to NULL.
> Add defensive NULL check in mlx5_tbl_ensure_shared_modify_header()
> to prevent the dereference.
> 
> Bugzilla ID: 1521
> Fixes: 12f2ed3f03c8 ("net/mlx5: set modify header as shared flow action")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

