Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ACE63F3E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 08:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9353640289;
	Mon, 16 Feb 2026 09:42:17 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5]) by mails.dpdk.org (Postfix) with ESMTP id 7908140269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 09:42:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNVzKqLWaxqxMC9QD/THkFl5SEx+vBQGog6iEvGa5gw6Xj8ijjzNKUiyxfAI6zxGKAcEAGn1gGFka/EMGxjoD02aXpPBUMPoEAouVxz1Pp48jgL1hWf58HD8wwLNn37VMU/BZcxFDDx5WjRNYLXKbbI1hd5GRemAZ5Jd7tG4Bwi7u6cCetzR2CssNq5rVT/8nAJMcQb+Bz2WfPhRJ3BrTHiacZHIbnAf2CgTDWas8tpdqdAvAIB9CkSHhuPtoMEF+X8Obpfid3R6gKEdsT/0+1rNF/0X+GSFbGZHhr3PpDhvEe7GMbE3sa80fpVGDgGr3NM3ZxI8ACLcTzN6p4FKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa2rGgmDShZcV7kqt9+6gFxtLfO3tCdtzoNDN7pe6sU=;
 b=GCeBBgwQCzb6rUxfSnkJMT6tXsQltHKDRxgGhVnE1zPItG/gr9xwABBTpj/ikGt6UySArEcV+LW6cNAG3JjJKCTnPpeza47tjbXKJbxFU7kGIEYvZCpaWqtRDvg3HkVq9IIMc9kWNZiqowz4sIe3c9ExWccKBOyPD+meeZxcx2HD7POkKO6hMFDT24fVhOIKT4Htr5MLOoMnapmaC3EtC6s5/Z26WwV6WS/avo/Xl+TrVDSOYlrN3dpS/n9fhls5MV6BV+U7EvvS4V01PoGC9OZCuJjAFM5FoPaRpppAe94iQLRvnG8hP0iD6wcM/BLtT+ugz11Jv9SmlQf+beUZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa2rGgmDShZcV7kqt9+6gFxtLfO3tCdtzoNDN7pe6sU=;
 b=V184I6MrhrwRuCIBRx96U75f/VEOAbHrhgQbO6p/eISbqHYoIRrpMNZ+WoiYP9FVs1ZNmJnmw6O1fZFz6SLr3CxjULx9ZkC3F6sI/VkewAVsVWlMrh9C/GRHFHbIglVzJLQta4N7S8mO83iiCMIMG65dftsh6iN8a625UjmBbugdhLbIqaI6OXWQXAaUDc9MLS6IiIOHmBXcOSOm5R/uYMeB9hmiyO9q9sfdYyGds0QQ2E17kOngQIg9XaSuHN27QvQzNn9LHZC/0JtHd+T4RUTdqg9FlF7e05N+J4HoHgPknmzL2FBootCg+lw/PVp//nU7PauI6BiJ0hLn4Sy3NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DS4PR12MB9657.namprd12.prod.outlook.com (2603:10b6:8:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:42:13 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 08:42:13 +0000
Message-ID: <c4653a67-14ca-443d-a5a5-6d0252236ed7@nvidia.com>
Date: Mon, 16 Feb 2026 10:42:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] replace RTE_LIBRTE prefix with RTE_PMD
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
References: <20260209135625.165750-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260209135625.165750-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DS4PR12MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 712e1ec0-5ff7-452e-7a75-08de6d3747c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d28yY2VvMW12dEtlNmJTV3poYzM5azFMdlZmMkJJbE9EazU4bEh4SXFNcGFJ?=
 =?utf-8?B?N1VIT0EyaHlZZlJCNmVRVmhQalJJM2pwanRkQlNCcHZHQk1PQU5ZcnFXVWVj?=
 =?utf-8?B?UU5zODV5Tkg0Z1RqTnk0Nm1vbStvS3RNRFJYdFBYMzg5cUtGOXB5Y09KUVFq?=
 =?utf-8?B?MklMZ05jbXhnd0hhRm1hSWl6TldVTGc0b1NQTG5nSlFQT0MvSmdqcE0xbGFn?=
 =?utf-8?B?MkNCMkdKMmhhS016UjI5TEVhV3dma1A3cXF1TERWQjZhOUFDSWZEWXlVY2RX?=
 =?utf-8?B?OEJmOHR1R3VQai81T2gwNjN3bjZsWFVDOUJFU2x6QmhxSnpvclozVTJhTXRt?=
 =?utf-8?B?b2ptaG9WdUI3VjZDeUozOGNjNEhrUXJPVVlKMDkzS0pGN1gzM3lUcFJYQi94?=
 =?utf-8?B?aThES1JnZU9xeUp0TW8xTTVJa0hnMmx1c29vWjJIZVF4OVR0VjZUbUhJSXFa?=
 =?utf-8?B?dXI4OWdFa2w3NTQzRjBtNE9xUWc5WW9vbFl2bEs2S1djZ0NZVG02czRNVnhE?=
 =?utf-8?B?RXd2SjRKOHRSMDloUnJKL2g1cDFTUzFjOFZVelByWWhKNW9zbzBlbENyR2Yx?=
 =?utf-8?B?c1JLQlJUTm5ZOW42U3dCWG1Edldrc2g4NWg5TyttSWhqaW1wZ0x2NmlHK3BX?=
 =?utf-8?B?M3hUdW5HRXVxK0l6WVczbjVXYzFyWW1QRmRtSkIrOFV2Z1dtNHdmTnhqM1k2?=
 =?utf-8?B?a3VQbE83WTdadHM4ai84OXlVQ2U2YTNkZUp0d0VXQXhqQUh4d2dVZkIwYytS?=
 =?utf-8?B?bjU3TzhQT0NWU1N3RjVOenUxK3o3M2FhNm1jVXRvUlZENHdrRkZCczArVk85?=
 =?utf-8?B?SFE1UzV3Vy80NXByejFwTXNrSjdWcHlyVXpZUFEvbVZ0ZGdHcThWZnNUVmJa?=
 =?utf-8?B?aDJmbG1VTThzdW1aU29FQ1R6cHNjQ2pMclVXaUF6S01HS2E3WVZYUlpHZTB5?=
 =?utf-8?B?enl3czk3UHZPL0M2eWN6dkxKS25aYnR6VmFOaWkwRU1rK1pyeENaV1A2a2xk?=
 =?utf-8?B?RU5jQTlHK2Ywb2lJQlBoQzNkQzBHZjhnbDhhcVRxeFVNTWY3UnNKd1dXb0Zl?=
 =?utf-8?B?QVhqMVNxdXR3WTFld3BHZ2NPQm5Nd1YrSXcwNk5UeThvblA2MERPSG1yRmpz?=
 =?utf-8?B?dWV6RlVIWW9yUkkxWUZkQjY4cVJqSE9oYkJWSE5VNjNxa1EwdVVMVTI2a3hm?=
 =?utf-8?B?bE45b2ZhV09kSmhudFgyL3EySkdPK2xna1RudHFvb1M3ZkpERklzbTVNODFB?=
 =?utf-8?B?R2VKRkEzcStQbnBvYkgxa2NEaGZZT0k2ak5mTVhYSTlqdUl4Vi9ac3FMeU9x?=
 =?utf-8?B?dlByQzhLZ3JSUVE0M2RrUEJmelJadk5uTTlERnBmRWJxMkxNK1NGdFJlMGo2?=
 =?utf-8?B?RDNwNDIwT0tYTVVwTVlPc2VreTJXdWJBSjU1U1I2ck9WNlZuQzVJUTlrMVdt?=
 =?utf-8?B?UnNuclBSaVE4a3g5YUQyMW5qK1g0dXJaSHlObCt6dVFhMzFYN09yT1NuMmxa?=
 =?utf-8?B?dUgvVGMrQWJabVdiODhhRmxDZHEyQjZOWkVMclBMOTc1M3o4bVl0RFd4akRI?=
 =?utf-8?B?V2ZUZHpEK3RZajlFNDlYZTZJU1lBR01rdXJFd0VrOFVseUJiWHM4REVQNG4x?=
 =?utf-8?B?ejAzd3BhZ0hqTUh0YWFqSGkzVDRzUlNPeWltWHc1c2kzbzcvL01xYWR2QXZs?=
 =?utf-8?B?SS9Vb0VwVG00R1BPUHJKRVZRb2o0TTVZNFluWlpnZEVITkhXZVJPaFhOOWF2?=
 =?utf-8?B?c21kMWx1Y2t2bmZzeG5hS1ZpMzlHc2hlbHBQbkRMbEIrOEQ2eEx4TUxvSlVZ?=
 =?utf-8?B?UFp6aktNSThQR2EwUThiSXhId08zZk03d3I1WHdOMTVRV2lUdkFCNy9EekQx?=
 =?utf-8?B?Mjc1bUR2MEdaOVNCaldIMHUwQTJVQzhqN05mZGR0QS95OERQZnBZUmNIaEk2?=
 =?utf-8?B?ZncyaklQR0REZE50ODZidDhwb2JLVWVjZGIycWhUWEF2L0VpZHlkU09ZdW5T?=
 =?utf-8?B?TWlxOFFQNnpHODNneEpYVjlLdkRNeGV2ZjVNbFRoM3dGNHd2VW8vOTdoblN1?=
 =?utf-8?B?VklFVzdRUXcraXZoNVNnNCtiQWN1a3hHNU5vMWpyMU10VFZIYTVUMTZlV0lV?=
 =?utf-8?Q?j03g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmwzbTArRzdvQmlNY3ZSZktlWUhVb0NmaldQTkRVVk1EWUl6dThWWDJHdkI3?=
 =?utf-8?B?cXNQdjVRWFMxdlYrbjFHOXBtTk9XQUUxRzdCU0hmR2pubmo2SXM2d2ZJKzNU?=
 =?utf-8?B?dDZ0MmlGV0tTaHl1UlVEaGlPRnVSMzdmUGxKVDVMRzVuSi9YYWJIQ2pwM1hC?=
 =?utf-8?B?cmhSaDRaQXNnVjNwcExFdFVCMSt1dGlmZEFDU3I2TUFpN0hhVWRXQlovQlkw?=
 =?utf-8?B?bVIybGJPRldVOXpBMWg2Y3E2cytRUThrQUdZRjdBeUhuS3kyQi9Gd0lBWVVo?=
 =?utf-8?B?d1c5YnJhQ2dCQy9PT3pmUEJOalU4d3ZtOTJyaHlzMFQ3SEJPOEJPVWlZWkYw?=
 =?utf-8?B?Z1JFdXNYWW5GM2RlZjNBL2xDdmZOVThMNXdJRVczb1krTGRBYkd6bUtEVDdL?=
 =?utf-8?B?T2NiVm1CdlMwS0IyaVMxQkdrcGVvT3JtWnErZ280ZXpJZVlDOTJzL1g2RWts?=
 =?utf-8?B?bm81QkcwUm1aVG1DV095cVZEZVBsVXJWNUs5MkR2TVQrZGZOOW1UUGFMZHlu?=
 =?utf-8?B?cXFDTTJFQ0RObXZaOG1lWDRZVFFwRmRXSEVHc1JyUE16YUhKVGtldDJFeXlC?=
 =?utf-8?B?ekJNMmRYNGJQdEd3REN5TG44RjdQL1JwQ1BwM24vaDJVM1NYbnJYWnVTeUd0?=
 =?utf-8?B?WngveUt1VDRTd2pMUkVNRGN6Vk1KMXFPaVlIZ3gwcHVjRWZnZjJCZUYwcHdl?=
 =?utf-8?B?ajAzdmd0Y0xOOGp0dW1lakIvZWp3b1krM2NtdGNJcXVaUDJQNkJTaXRXRTJs?=
 =?utf-8?B?N2tOdThaNnljbytzOE8yMHFaZDFWWmoyQmxNTzhVaUxwVENqVnhGOUF4dnRK?=
 =?utf-8?B?Tk82Z1p2NEpkeFRuejRiNEppM0dJWFMyM25PMEYzR3lhc1FjOWpzOXpTaWgv?=
 =?utf-8?B?TGlzdTM4R2UrbTcxZ3A5Q3FxY1ZTOVFhajdIMDZTWkxTKzJrZTNMRGpKYnVO?=
 =?utf-8?B?eFpJUmYyQzJGSVBYdFJSVUVma2x0cW9ydmRZNGJBaUtDeUFpYU5YeWVFODAx?=
 =?utf-8?B?MXlmbkJNbW9YMzMweDdsTXpxN1d6NS9oZ29CVDNSbnFBT3BBVjV1aHhvTEJm?=
 =?utf-8?B?NVVQZisySzBhWUcxQlpTUnV5TS9QT29QSVMvMlBsWHNwTDBJWVVwTzRnZVFN?=
 =?utf-8?B?ZlNBWTJiN0JBN3NaTXFQR3laeitKQXZoV0RVK3NmNk5RQnJVRlA1VkZrVUpD?=
 =?utf-8?B?SmtZMmZwajZHL3hqR0lhNHZyMm5jQmV6NXRxRTdmQ1RLVjg2MU5ZeERsMkdK?=
 =?utf-8?B?SHM0bEkrREgwaVJja01RZVBaSVlSQ08wYi9DVXhma01SQjZjWDNac0ZFejJy?=
 =?utf-8?B?MGlwTWhZUDQ3YUR2ejI5eUxHWjJwMGlLUS8wa29TR1Z1NHdidkhabjYyaUVH?=
 =?utf-8?B?OG1xZjZXdmh6aGQvOG1NdHFPcGliVEJyVDJHTWRxekh2bDBucU1aenNFUmtG?=
 =?utf-8?B?ZEdvZzJ5UXZtTlAvMFVmYmRPaXptOGpPMnN4YlQ0NG14RkMrNEU0WUJpZW80?=
 =?utf-8?B?OWpBVExDLzhRdkxHY0FjNjhKd2hGdnhDdEdneExJQms1VzdDbW1qajdVWnN1?=
 =?utf-8?B?ZVY4cUV2KzlDMzhDNzZwdVFLa0o4YmU1YytxRjh3c3dBajhFdmRlODN3YkQ5?=
 =?utf-8?B?bytHc1Q2S3k0V1pDRXJMcm85cGFrN3B2U0RBZ1c1NEdzZERsSC9Vbk9xWVVJ?=
 =?utf-8?B?eU5Kbkg4aGFEZE9HZTNMUmFCZjBwYXB1cEkwVUQ3MUtKaXFxYXBuMTBpYXRh?=
 =?utf-8?B?Vy90aTBNQXZVUkdOQzhMdmVFVHFTditQYWYvL0xPbEc1QlUwUjAzajhLeFJV?=
 =?utf-8?B?Q2FWaDI1STRiYisxYmUvRXpjZGtMeTcxR1B4MU5CRzRQd0FCWFdaZGF5TTRB?=
 =?utf-8?B?UVNEOGx1YktMMzFaVVhySFBzQWpxT243ckpadzRaVkV2ZEJLNitzenhHaE1J?=
 =?utf-8?B?MzVNMUdMNFcwaEM0NEQ1bVZ3cERoYjBPNGlEYkl1emtBUzJTWllNWGozQWdw?=
 =?utf-8?B?U3BUSzk0UTM5T2lHQ2tlYlNrd0tIV1dVbmUvcWd5OHV0SzdrMDk0Sk05MnVn?=
 =?utf-8?B?NGNIcVFNQ0FFZzFNOGt0akhuUWNmY2cweEt3WnRJS3dCNnVQYXFPKzZsM0J4?=
 =?utf-8?B?Sy9BNHhjY0ZVN1RWd2llbVF1K2NZeUxucXVsVkRBbFFJZG1IMzRLNlNUREg0?=
 =?utf-8?B?VWdIcTRvbVY1cFRiSkxTZkxPQ0p5T1lzZjFCWG1JMXhEc2JETFdjdGJNTUJU?=
 =?utf-8?B?aStVdC9zZlRENnMyWlA4TVdHRktsM2JDT1ZRM0YzMy9NOUM0allSTUpLL3ov?=
 =?utf-8?Q?Ys/WMlp3iDFS8rcCIv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712e1ec0-5ff7-452e-7a75-08de6d3747c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:42:13.0024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUg2fS+dDGoH2KfxMZ6Bz1l+pnztmF2pWTihiLnOjC+g923hxihowRWyz+rfQxhCl6NAKDCOSwauFZk6Ux7wIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9657
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


On 09/02/2026 3:56 PM, Shani Peretz wrote:
> rename:
> RTE_LIBRTE_MLX4_DEBUG -> RTE_PMD_MLX4_DEBUG
> RTE_LIBRTE_MLX5_DEBUG -> RTE_PMD_MLX5_DEBUG
> 
> Shani Peretz (2):
>    drivers: replace LIBRTE prefix with mlx5 PMDs
>    net/mlx4: replace LIBRTE prefix with PMD
> 
>   doc/guides/nics/mlx5.rst                   |  2 +-
>   drivers/common/mlx5/linux/mlx5_common_os.c |  2 +-
>   drivers/common/mlx5/linux/mlx5_nl.c        |  4 ++--
>   drivers/common/mlx5/mlx5_common.h          | 14 +++++++-------
>   drivers/common/mlx5/mlx5_common_mr.c       |  4 ++--
>   drivers/common/mlx5/mlx5_malloc.c          | 22 +++++++++++-----------
>   drivers/net/mlx4/mlx4.c                    |  4 ++--
>   drivers/net/mlx4/mlx4_mr.c                 |  8 ++++----
>   drivers/net/mlx4/mlx4_rxtx.c               |  8 ++++----
>   drivers/net/mlx4/mlx4_utils.h              |  6 +++---
>   drivers/net/mlx5/hws/mlx5dr_internal.h     |  3 ++-
>   drivers/net/mlx5/linux/mlx5_os.c           |  2 +-
>   drivers/net/mlx5/mlx5.c                    |  4 ++--
>   drivers/net/mlx5/mlx5_flow_dv.c            |  8 ++++----
>   drivers/net/mlx5/mlx5_flow_hw.c            |  6 +++---
>   drivers/net/mlx5/mlx5_tx.c                 |  2 +-
>   drivers/net/mlx5/mlx5_tx.h                 |  6 +++---
>   drivers/net/mlx5/mlx5_txq.c                |  2 +-
>   drivers/net/mlx5/mlx5_utils.c              |  2 +-
>   drivers/net/mlx5/mlx5_utils.h              |  2 +-
>   drivers/net/mlx5/windows/mlx5_os.c         |  2 +-
>   drivers/regex/mlx5/mlx5_regex_fastpath.c   |  2 +-
>   22 files changed, 58 insertions(+), 57 deletions(-)
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

