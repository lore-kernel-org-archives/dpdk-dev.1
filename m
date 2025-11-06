Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D05CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B90B3402D7;
	Thu,  6 Nov 2025 15:04:40 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by mails.dpdk.org (Postfix) with ESMTP id 62A3E4013F;
 Thu,  6 Nov 2025 15:04:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBmH2EcaOsf0Gpen6q15dO/ixcVRiDZOP1svYs0xlYTSU+77x9tgVH5FTPnOG9vFs/NNPU0Mwywi99+N935RrcgTU+/TUN+3eohJFJvcaOBv5+T6/1mAju6+218XOf4/J5j4tsjNYYsadPbC/sh7KkYuEOXGRx+yhWp1UZQIJp86qAIHzOMTHlp12JduEiRgMpRZECmveMZdMoJV+7jM/U2g8wUNY5pE709NZeqHnrfsGF32I1nKCl4jQB3iPBM+tMjbAM8hskv8M+kXYtw1WI6iJ5RNMo/M03uvB/haPljsw8J2sUDA2v06oSSe/bLid9H3RRXI5Dz5CnQMIYE+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGJ1A5LvS0j/mqEaEveasAJdE9LYmVGEL7FTSoLoQcc=;
 b=mB55RYv5kWhvLJqviXDNx8BKdIXx4/MclW3pCJxslFxQMqM1IE4xvVmLfiYfMUiz97BDqRQq3KDUwnBGnlGepUtsXk8jOJiGUWEKI1gZ40U46dZNGfomu5Fj9n8l97NhdEAB1U+enokojt6QiTqXs+sffUFESDOMaWyPkhWZQ406jtFzrN1Qr31HdExDMIfEeTyXgv5j2u+dA24PZMchFhE5YLv6MVOzDwJ2gcdV5aRSq9vVzBpqowWQUQ9tAv4Yhi/EgpupHqoRJjhCEJGMFda7QKj8vMd0VhtZZ8Kv4eVNsSiivOJLKdC3CdP7jqLtZI3po0jcbLF/nj7P/md6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGJ1A5LvS0j/mqEaEveasAJdE9LYmVGEL7FTSoLoQcc=;
 b=ivwFmRJBeiXNmJKsNLkVfxXh72rsxIaVfaZP2emgGakc3fMQg1Yh8bEWDxIytiYIgC7wi1j8TsdyB6PQ7qKx5qqAtebLKHigQhdmD+M8CtdtaPGGjbOTtPynazVGPG4qigJqVD2FQlQ43DxVsB3ntlF9L5Q5m83y8zlds5IHHNnuWrm0em39q5TQUmNCx8Eutyk27PKfm0zFBIwkCG20I2WD4xXTnFEMwBmqQNH7jQNHZjie30GFJntihM7335AIpPR+rlvM+yRkvBsh4EQn0z0Yn/p6f1nH0jxo0827iRqSxBd2teKOL/Lnng0oydxCMV9+SzpPVGxrR3TSBRd7zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 14:04:36 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:04:36 +0000
Message-ID: <2265f1a4-4ffb-4454-9818-e019d78f31d6@nvidia.com>
Date: Thu, 6 Nov 2025 16:04:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix modify field action operation restriction
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
References: <20251105085049.110213-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251105085049.110213-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: a6dbe875-78a6-4663-47f4-08de1d3d6b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDFYd1g5bjhzdys3eTJJaGdIdEREOGhFVnd6cXFnYXdZdGo3Wi8wRzM1bUlp?=
 =?utf-8?B?RTV6aEtQR2lDMk55R1l5K29rWm1uVjlQMTk4S1BQbWYyL3dXWjl4UmtXY1Zv?=
 =?utf-8?B?WXlOWkovdUR0SGRCK0IvREhlS2tSc3VibkxVbnJEWUluSVAzaVphRm92am1V?=
 =?utf-8?B?RWZaQmd2RC9KbkRSZ3pnWWI0amxVbFNad2JNZ1lFaUVGaTVKQlhEWUE0TXNy?=
 =?utf-8?B?UTJIaWFuc3hsOGZocEdHUnNxRWEweDhDR2JYTW9qR1NZZVV1cWc3czkxSnYz?=
 =?utf-8?B?bGRGSE9Fbmtod2ZEUkZIenhwdUZMRnNEU09kV2czSHQxK0FpeVptSXRYY3R6?=
 =?utf-8?B?bEUrQlVPSVZuQzkyRDk2VEkvdDQ5YkdMOU1zbHhRbmd2N3A3OHFuYkxZRDB1?=
 =?utf-8?B?MVhONGlzS2ZYdy9IQVZoRThSRE92V0RoVHVGM2lUZFFjaWRST0I2NFowQ1Rv?=
 =?utf-8?B?aVlvdFVyL1lYWWx1aGEyQ2dVNFZ2MUJOVmpsV3NOeGhrY1RRcEF3NzZzdGh3?=
 =?utf-8?B?Q2RZNkc5RVYrRDZhdlJJNDZwVVFYWG9IcFIrTWcvZWxucXd1aVZkVGVhV3p5?=
 =?utf-8?B?SHRKTnMrUHpNYWpNY2RzN0I3U3o4VWNKR3ZDbEp1Z1pwRnZJNTFaMFBqS1Vw?=
 =?utf-8?B?SmFOUElRa3dLMkZyWkUyYXUzeXlqRWk0MkNxVDUvWHBScEJGd2dYZWlERWtW?=
 =?utf-8?B?d0lSTmx1eFFERjQ3NUdCQ3Uxb1JNNVVjUGEvTGt1dS81VmRoYkZHaWthV3hV?=
 =?utf-8?B?OEZTcnA1Ky9lOW1RbkpncHdjU21lUTRyTnNBRTRaVkF2UTBzTm5wdkp2Y0N4?=
 =?utf-8?B?dHplMGszNkZQaml5V1hUN1RiRkU1cktYckxwTklsbTBHQ3N1M29Jam5VcEFs?=
 =?utf-8?B?YzNDaFJPRWFHbmNXRmYveXhNV1dJMFpEeE5JRFVuZkZjaUFQWXcveXc2bGIr?=
 =?utf-8?B?cHpxbm9HY3Y2cmI3TFh3Y21oSlR3VElRamIwOEt1R1F3c0RwdzBySnZWZHNZ?=
 =?utf-8?B?elg2L1M4RSt3SHpmVVNYeDJxY2pYVloyYjE0OXNNY0tlU1ZOWk9xTE1UZFFE?=
 =?utf-8?B?c2NLSlAwdGtzeDF5aU1Fb2JNdHpBWG9FcjFzb21ISlo3b24rRjFyTUtKUzVP?=
 =?utf-8?B?ZnBuNVBLL0JYZHI3Tkd4RjJYWDBxWjlDcnVJK285S3d3a3NaSlZScUpyaE41?=
 =?utf-8?B?ZnR3OWFobDMxaVBnbE5lSnlXRStFMG5yTy9DZ2ljMGw5dEVCaEthUy9qQjhV?=
 =?utf-8?B?S3l1RExMeHZXRHk2bTdtdGtrZVdiN0Z3K1VCZFJmUVJpYW50Qm9jam9sbW15?=
 =?utf-8?B?SnhveFdVVDRmVXVWSmlPRkVrZ3FNRTZkcmIrWnkxQ3R5U01HQlBhamVYcUFK?=
 =?utf-8?B?L1lYS0lLajIwM3VzaUt4VkdXbkJxOGppdm8vSzQwYThWYTF2emJmc1ZoaGg1?=
 =?utf-8?B?WHFkdXMwYitXZ2N0bFF6Z00rNldHS3N2N0txRFNIR2Y3ZDBKWTEwK29EbWNk?=
 =?utf-8?B?NjRrOURGRWt5R3NaK0pBZkJiMWMyTGlQZWxoT2J4a013WlgwRGhEU1RxbVRm?=
 =?utf-8?B?Smt6QXE1MWJSN2ZIYXR1ZC9uak1jK09wajRlblNDRkpJeWhnQkgydk9VS1A2?=
 =?utf-8?B?YzdhcmF6WWNUM2xxeXhObEs1WEtaRFZweXVPa0tSUWZRUlVJOGlvRGtWSnVo?=
 =?utf-8?B?QWlCTTZkVnJUKyttcjlPRERmWnUzUElEVWJZZExUNTk3RkxjUmZRS1JQUDN0?=
 =?utf-8?B?TzlYalU4TE1rSkM3TU4yWEl0K3UraUl1SU03NXlJT1pwUWVCRlJrMkM5c0xU?=
 =?utf-8?B?bnJEc1NLRTJUZmd5STZVak50OXI0bytYbzRUNzN3aUg4a0FhWlhqaURHVjYy?=
 =?utf-8?B?N25QK29TOUIrcjBwM0dISERRajhDSjRnZzllUjFldktESU4ybmVFQlF3VUxC?=
 =?utf-8?Q?fxmQjDRlAWHNV7C3Le2bJg8UUPtS/Lsd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FKR1U0MmVWVk1oK1lZcGhpSHBqT1laelQ4cVJzZW5iRmlsaWVnMXV1ZmZQ?=
 =?utf-8?B?aVdtU0RnS2YxWFJNWU5RMllCbEl2VmZMendIT1owRFN0UDI4RUJoQThZekRG?=
 =?utf-8?B?OWRtM3FwcDR4U3hVOGFWbnRFbjJvRWFuSWJFaGEyZWRzQzRIR3F2TWRxYTFO?=
 =?utf-8?B?S1ZUZXhzbmZpV29CUnhPR2hDN1FYaVB3N0RqVnZIU1dCQitSWkxHSm1qa1h3?=
 =?utf-8?B?aWRadjc2bmgzUVFRT3hkOXQ4elBKWGhzMlhySzhLSHZlOWsxV0hwNUpzNmxY?=
 =?utf-8?B?cHBiRGNtYlUwbStnWUQ4Z2JsMVRndnErLys3dFhjYXkrb1Y1bWU2MnhaWXFB?=
 =?utf-8?B?TGI1Mnd2WlRJckhQT0Q1QWJzMGEwWkdTcWNSRVRXYVZDTkhTTUdYbXRnbHpp?=
 =?utf-8?B?MndWT0dKSkMxdUlTVXVkZS9CWUplcFN3MXY4RHVleEFreElJRXYrZUxBN1VQ?=
 =?utf-8?B?UUVFYUpBemMxQVZTNG5wMjBydlZGQXZlcW5GYzVkK0pLQU4wVFJNVVJ3ZzhH?=
 =?utf-8?B?RzR3MVRPdDVqdFAyUjl3OTlmbXJTZDNRUWlhYytaTDJFMFl2YXlyZVdkZVdL?=
 =?utf-8?B?ZVdBRk94em5JMjQwb0RHYmFRUTRKNmlkaS9WZFZrT1VteitYcGt0TXE5YWJL?=
 =?utf-8?B?a2YrOVVQdTFwazIrQ1R6d1lkdDBZT056QUVhRE9LWFZtSlUxSGx0cWV4K1BN?=
 =?utf-8?B?ZmJKS3RaSDFSWUNybXQ5ak1hNUxWVWhMY0R0OWlETjN2Y2FvNThjbTgvNWh2?=
 =?utf-8?B?ekVLR3pDdVlvNk1qS1RTbFVOWWxnV0FMRXE3WUNnOWxYTjdpYnBRNTZTUm0x?=
 =?utf-8?B?YUdHNFZMUUdMV1dzaTZObDRJK2liSU9jdXhoSy9udFlDYVN1ZVcyVlNIY2pl?=
 =?utf-8?B?WDhlQk9FeHAvdVdZdUlYQVgrNmJqRkt6ZXZuTTYyYlEvM0FORjlpcXJqMktu?=
 =?utf-8?B?c0lhRzB1R2xJWGpKUkFqVlJKWk1sUTVBV2ptRzBtVitqME16VlNwWEYzYUla?=
 =?utf-8?B?MDNtTUNhNWFvYjNIdld3dzlGelkyN1hZdE1uak51MWxNcFd4bHEvVlY4Z3Rl?=
 =?utf-8?B?alA2UzRSYnh1WDZUYzVhSjNMQTl3cXJGQi93dWtiUGVpSUV4VHpNdkZOUlhQ?=
 =?utf-8?B?MDdWVUxkaDVEaFJaYURhMStHWmN0WGNWb1NtaUhzVU1TVzlHUWk2ak1KWm1C?=
 =?utf-8?B?VHR5WGtLMjA1RkFpTWs3U3oyMXZ2eFZlTWJiR3VLUXF5RWNwTFN5UmZYOWFv?=
 =?utf-8?B?ditaTjFPMkJYYlRkeEI3RWxWY1RNYkgrTUhrZE5GTktpYkFNMVF4REc0cnlh?=
 =?utf-8?B?eGMvT1pWTW5GTGRiV29wWnVXSTNtaVM3dmFHbmhoRG00dGpubTBCSnBEME4v?=
 =?utf-8?B?Q1lPT1d4aTlrYzFkSkpscTdKRVk4VzkycGRDbXViNHE4S3RYU1hhelZJaXgw?=
 =?utf-8?B?czAzbnFoeTRCU0xyUklab0crT0I2UWxGK3Zxams0NTBTN0tBUWtGS29WZHZS?=
 =?utf-8?B?alh3b0tGeG1CaTdMOWdQK2RzOXhSbFpSaW94U2tBRGFSUnVmdjJaZkxPUkpJ?=
 =?utf-8?B?N1RHOEY2N280VkhZalNieE5taVFRd094eCtQSDVWbVE2N3A2L0pYRUY3MG5S?=
 =?utf-8?B?Y282Y2RZaE42T3VEeSt1aUVrK0NLb0xvQlMrTVpmb04zR3Y1ejNNSEJqYnpP?=
 =?utf-8?B?RGVyaTBIb0F5eGJVUWZ1Smd2d3RNTURHbjJsNGIvb3dXbjJwSVR1cGV3N2Ir?=
 =?utf-8?B?Nm56dWxJd2x4aHQ3TURGM1Y1NGt0b29XRzl6UEw4V3NDVENzK2NzRGoyNXRQ?=
 =?utf-8?B?T2pWV2ZONlNYdjN6RWRvSlpPZ0hacmtoMFdHUm96ZW55aWJBTno3M3RmOUNI?=
 =?utf-8?B?U1FtanZXSzByVTk5VUFJQUN2c1NjZXJSUTRoSnByQ3kzL3JqS3U5a0RwNCtv?=
 =?utf-8?B?c1NTVkxhU0l6Ni9oek5jTUwvcFJET3k2dXI1VzAyNkVUV1p3U1hTRE95bUJR?=
 =?utf-8?B?MUZQMk1OT0l6NjIwQ2VwOFMvUEhPWGhUejZNS25FMjljVStZK3V4ZUo2SXc5?=
 =?utf-8?B?RVluSDk0RzBWTDFYWVlVa2FqSWUyajV3dDhzNkRnUm5EVDZiWm5KYU1Mbm1U?=
 =?utf-8?Q?oC6cthrRsMQG04x8qMCyvAX5x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dbe875-78a6-4663-47f4-08de1d3d6b0c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:04:36.3303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfcSvS/33fmL6BNqlbBjK2aJ3Skc5Em/agOKYQ20n+Nj8g4XLrbZD8G/46o1UEFOQ+kgQ2+gCZPw8vMx6mmxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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

On 05/11/2025 10:50 AM, Maayan Kashani wrote:
> Update DV flow engine modify field validation:
> - Reject 'add' and 'sub' operations when source field is not VALUE
>    or POINTER in DV flow engine.
> 
> Update documentation to clarify operation support:
> - 'set' operation is supported in all modes
> - 'add' operation with VALUE/POINTER source fields is
>    supported in DV/HWS mode.
> - Specify relevant HW supporting packet header as 'src' field.
> - List supported 'dst' fields.
> 
> Fixes: 641dbe4fb053 ("net/mlx5: support modify field flow action")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
>   
>   #. In template tables of group 0, the modify action must be fully masked.
>   
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
> index f765f941162..95ca57e8c46 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -5642,6 +5642,13 @@ flow_dv_validate_action_modify_field(struct rte_eth_dev *dev,
>   	}
>   	if (src_data->field != RTE_FLOW_FIELD_VALUE &&
>   	    src_data->field != RTE_FLOW_FIELD_POINTER) {
> +		if (conf->operation != RTE_FLOW_MODIFY_SET)
> +			return rte_flow_error_set(error, ENOTSUP,
> +						  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +						  &conf->operation,
> +						  "modify field action type add is not"
> +						  " supported when src field type is"
> +						  " not value/pointer");
>   		if (root)
>   			return rte_flow_error_set(error, ENOTSUP,
>   					RTE_FLOW_ERROR_TYPE_ACTION, action,


Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

