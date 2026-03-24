Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C4E9A77B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 299A84065C;
	Tue, 24 Mar 2026 13:26:57 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23]) by mails.dpdk.org (Postfix) with ESMTP id 05074402BE;
 Tue, 24 Mar 2026 13:26:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZedO5oMgDz2AAAnQAGAb6ZV3fkGex8DAT+NiJMn8n3XaHKK4tZRh0IdjvQPcVAKMg8iyDVcURduaTMramQabMvTbx7mOmu/p2Vbp5x4/WaGFLrjxDhHn7AOAxeHDvpLFLWrM6DnmBSTgG+NhR91IQxftuLeKhws+mZ/BB4tjY1yfDDv4EEoaXNJJ/Awe/eQDku5yl07DckYVi8y8oN3LD+Hnnc79Rfs796pCH6KurVczcytjlZDaPohFrtY6adXY35hkAeTP3kjS1FmQWAeRFhp+GshKt7FYyxRKvqYUUxfUJFuC0v/UOp74Na0IlZjDKm76yGMlLk4t9m0RZtW+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEkjgz3zyMuu/n+DyuSPc2V+vMlWf5O5CcPd7++F5vo=;
 b=sOLxxpOc7Pxn/EANm/zlu95VjpdouZEsueUeEUlDfIDrkJ2UH7DTJYVDUOs5cxbSQf93dWCDFzHh0l5Dd/dUHTtXPoZ+mUMpH1ncL9GzkxFJjlNLNPWPTXPIqXCV4VKffwhaLOlPxwDJQAi6b6rUwOl9V03jgiKyesRInZqjeQOeAW2i/UM1jUNsn/CK4aRQrkCXdjMs1CY4MH/prKmcf3gIIbhuARlwb0oe/3NO5Vvre9C5h2ZY/2NpeGLg9vHoEMt6CnUIxt7pL2eGTextiZfKumn3Fo+5fLazfA0JgyvUZdrrW81ljZlgsfh3AxcgGm6gsL97plpUONnq5IoJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEkjgz3zyMuu/n+DyuSPc2V+vMlWf5O5CcPd7++F5vo=;
 b=S1x4MUW2rAGTMP1onZFzHsUYUr7jd/Xzrv9/6dmaFv3bqPxwQBBJIgkPJu0F6sFaCVlz0x1KDtilmpc83dBK4lImIJUg/8eawcWpBtL1v+5bF2sPIuKgE1Vh+p+Y7Nq76aGAtiV0ERLAvWW2EFWfnGbJ0ypJfl4blpLTMQEttyoDBgCKR166XpBLwmyqkV7yIg5I+F7jBjG5tCRA764CkbgG3GogOQsS3El/dBn5xFDLB6Iuh+bnVtO0HTrTxhX6SI1klzNYG4vNbmYVFBkdKFrQy8u+AW5LXaIXMzWPJ38zxD+JIpMrFwwbDddGKfc+u6kxD/t3jNwp0ahF5xuCFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 12:26:52 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:26:52 +0000
Message-ID: <ca399ed0-d6fe-4ba0-8589-1fdb4c76832b@nvidia.com>
Date: Tue, 24 Mar 2026 14:26:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix heap-buffer-overflow in sample group match
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
References: <20260315084404.94506-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260315084404.94506-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 0deec0d3-a13b-4ee1-8851-08de89a0a120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 0XF6JVSd3OgCtGeagstGhnIV8Myqi0RDUybXc4Kv5MltQaXYZQqquFTFK9CG8MlUZCHLAIzwKpn5rGRZ+4B6Ny3Z8FLeKzCSQtjo7LzC27/NKWgtr4T8fl0/p3pO9WpIGKN9VHGUE5/vMaTNm7LQHZPliCMgAukS7GWbkwEmau5CPGNg57BVU0FiAxSqPtHWu2P2SPVlmg6VtD6B6IPeS3GxoWJqabveEtV1XOX1h1WCa6ztgoVXPFgIvZavTtzzbaSlJD2nDGVXvypHw0g/WqvPrjXNU40AACfiMNZs3dSIhoeSPlZDxVhCoz8L9MFhABIAHk+ksv5b/sFetng/WKTPL6kRYTsPgaWvPGAzZqXSBdEgQOsk1sf8evmBmI/h4BL4Jmju5PO4V/ixoFR1QXNYINvfCOfluseVy0eVjFQbRFThg9vPGrxY4j2TSLbMiSizbnNei0bNZFM816yvVk1twZ7KwRUOX5rDnJ+58zRFzlrSsxhLZhOT+0fhlFn/tXNYmAxMeQoI+Am/wM1TmZrjFh4Ol6subYY+Yox0rPlN1LzjBeuvFQWepDPCE2sRhR1agO3flNVb8sT1ONqL1qtvwK032Hz4s8hJFzZ64owr8iqKFDH4G2ugsCx8aQzQ8dl7TmWlqVrJOJsHDVMgB28bY7PUiJq7TaNNcNQiFIPTH+k/rnbuwpBnTReJS+tdj5adViDjK9zAYVsFLCtj+u2KJTo0AE5UVkahgAVbdwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVd5aStvTVhreExXQjc5SXp5NU0yTDN0WkRYSkhJMGhPamc3Yy9RUEc3ZWh3?=
 =?utf-8?B?Q2xNWjNWNWU1UGlGenJOYi9UMDk3akdEYzB6MUNWbythVGFHV3lLQzYwZmty?=
 =?utf-8?B?T0sxdTlYOHlpcnlETzdsNFlCVzgra1R5cXRTdmNWbnNMclF4allrenhzQXNW?=
 =?utf-8?B?Nk50ZGdUVFNPRlh6TGhXRFJha2prY2M5ZjAxeUEvUFl6WkdVUWpIM0YrR282?=
 =?utf-8?B?VUprcVZwUmpGeXJIdm1HQUhzb3M4N0ZkazdUOGRWWGd6ZE9EZFFia1NvZkli?=
 =?utf-8?B?VU5TMmRTTWlxclJuSXJQRWFjOHl4Vmg3eHQxbVJ5Y3RyR1VmVHpPRndkZFhs?=
 =?utf-8?B?TVkxVVFxbm9sazBObEtuU00xWmFRaEtjT21VV2poZGM4eWs1S1kvMUZ5bHE4?=
 =?utf-8?B?d2Jhb1NUQjBDaFJXR0tGVzJHMENlYXNxelFzd2p4YkpXbzFPbjhpM1J1Z0Z4?=
 =?utf-8?B?bjBPaFpNcXdnMU5oWVkvdW9BUVFuR1F2Q2lRaktXcmJlbFgyazFHMmZTbkZq?=
 =?utf-8?B?SDZlejJvM0FKS2c0dzArNjR1bHE4Mnc2VFZnczFVcElHTVc0MENqZi9JamlD?=
 =?utf-8?B?Z2I0UFBtUVZJbU5QUmtXdkZxTFZRMHl1REEzWXRVWElYaWd5YTd0TFBkdTlP?=
 =?utf-8?B?d2gzYUQreVl3QmJQUUh4TU1UaHF0VGQzT1BlMTdBUDYyQnlha252SmpJOWRz?=
 =?utf-8?B?VWNmWFBIOHEvVGpXWmlZbFd6QmVnN0t6WlljTGRTN3hrZ00yT09FMlVweGhK?=
 =?utf-8?B?MmtFc0F2MlJCVHNKdFVNMW41RFZ0c0xFbGJTWVBZN0ZqVVRFNExQRkxKbEdp?=
 =?utf-8?B?STQ5b0RMUEZBWUFRRkNFV0pTK0d5QzlxN2pQcHhuL0N6MmN5UTdQTmY5L2Na?=
 =?utf-8?B?bnpONmRJbTJIdjY2MnBTMVZoaFdQb0dsS1pBU1VPN05yNDJXOG5zSW5SU2I4?=
 =?utf-8?B?TDJPUXlxMWxGcUtyY0taMWRDa05UMHdqbWxXSG94Vnc2MFRBS1FWem1UWXpM?=
 =?utf-8?B?bEt0Slg1ZmduOWFNU0IwSit2OTZ2MmdtTHZHNVB2Ny8rcW5tUFdDN2UxbHEz?=
 =?utf-8?B?akszT2xoSjlqajN6UXc3NnJNNmplTldsR1NkMzMzaFBmNGI4RHNTZEhSSXVD?=
 =?utf-8?B?eHhvM0d3MFZoZlUvOCt4QW1TMmU1a0d5UHplcG5ZN09NRTdCRGN3ZW81R3JY?=
 =?utf-8?B?TzFPQ2lGY3NRdXBZazhNKzBTd2N0bGJYU1lUQTFJNE9adGVtcE1na1lJMjRs?=
 =?utf-8?B?K3dwWVN3bWhUMkVkR3pOUzZDUEJ4T1N4VzArZERCeGk1Qm5tOTdUYnZ4Y1pz?=
 =?utf-8?B?cWMra0pRYnFwalNzNUVDM0g3MkF3WmlMQ01rTkdyYldPWFFhWVhCalB4TWhP?=
 =?utf-8?B?Qnpra0J0MUVWM3IvQVR3dVVKdkczTXhPc0o1WTZNMGNOcXRqMzl5akp3aWlJ?=
 =?utf-8?B?SlFHTFRTczVkM3ZGbTJqMHFBdExpcHVadU1hTEo1d1F3NE5UbDk3czRnTEFl?=
 =?utf-8?B?cGtQTDNpNTE2bkxWc1dqZlRKbFRsbkNFYVBvSDBKMUpLZjZoWWpFZCtpbjhn?=
 =?utf-8?B?YWR0REF3ZzRvejB4am5ocWw5MW9UdHVwM2tkUDlhNTUrOXlDUHU0M1pHS2ZN?=
 =?utf-8?B?YXMwN2JXNWRNUEY2L0xzdkcrOUlQVGZaOWg4V3RCV0R2Y29pUSt1YXhmcHhy?=
 =?utf-8?B?N0d2NTJNRzZvOTRyeTlLQUZLeUt5dTAyb2dsVmd5eG40MnFJdHpXOUtEN3FO?=
 =?utf-8?B?M3dRN2toNURqZGkyWUhWOHk5QXNYc2doUFllZlVmVDIrSlA1U2xtanJHT2JV?=
 =?utf-8?B?UkY5eVRyV1cwTTBxOEdVRGhRNlc4VXkrSm5tajNtaUxiYVc1U1BxQTlnT2h6?=
 =?utf-8?B?N2xkS2k4em1qYVVNQm9KK3lBTFYvclllRWhEV2oyUytYUnJoS0RDSXpNOXpM?=
 =?utf-8?B?UkhSckdSY3RKQkJhbjBra0VuKy8wR3ZRdFlPQUtNRWV3WS9JNE14YUNUZGdD?=
 =?utf-8?B?eVUrQVJZWnlDTHluL0JvaXdsOHNPejMzcnEyeWlxdFhmS2xWeE1ROUdDaUw4?=
 =?utf-8?B?QjZTZDhVb3hRSzd4cUNNZ2hsVkNEOXZHdUFqODdZMG1FRjNqYTRORnpweHpx?=
 =?utf-8?B?S1czUXVHQkdZUGlTMUdtVHZsdDJRMVp0UW9QQ3Zid05JTDNuSFBQZVJ1UFcv?=
 =?utf-8?B?UHcxZWV4NEMxSHNwVlJGOFlCNlBDandabUJNamptTDZ5cU4xRDUzRDhBMVVQ?=
 =?utf-8?B?RGt3U2R2VHBSVGhJR29Gb0xSaGZTN0NwdTJCREJXcjY1YnpFMnd4Zk9rU2RQ?=
 =?utf-8?B?cm1ITC9wYnVXS0M0Yk5KRHpQTTZrMVZsbTJaTnFiZm9UMTkxZllnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deec0d3-a13b-4ee1-8851-08de89a0a120
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:26:52.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXgpY8ktoosQmSNesBTSG7p9AQ4W1Nkc8cEVKN89bjKDEKamo+7NyhNglpdb1If90LgsfisCP6y1JvMRb1j5qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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


On 15/03/2026 10:44 AM, Shani Peretz wrote:
> The cached group match callback compares serialized actions
> using memcmp with the size of the new actions buffer.
> When the new actions serialize to a larger buffer than an existing
> cached entry, memcmp reads past the cached entry's heap allocation,
> causing a heap-buffer-overflow detected by AddressSanitizer.
> 
> Add a size comparison before the memcmp so that entries with
> different serialized sizes are rejected as non-matching immediately,
> avoiding the out-of-bounds read.
> 
> Fixes: d986f04d6529 ("net/mlx5: add functions for non-template flow sample")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

