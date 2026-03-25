Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D828109C022
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:34:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2453402CE;
	Wed, 25 Mar 2026 15:34:55 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by mails.dpdk.org (Postfix) with ESMTP id 22B4740ED0;
 Wed, 25 Mar 2026 15:34:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIo4/4zJpyj/VSx+kTpxBWndrywlQzCSs1eP57DnTwOygcEGTJGqWGQJmnEdTnkZk+NeI4DqAjJZYLYh9ZWmMdq+Gosl5uxkAH2UCKJOdvfki3EpkjxgXs8JJZSvuaBKeji/APEgsC/ieZ6adCNgfHzVtvKe+m2n9cLrCC6AwqVPx+z4Xd0uje2gFvL7IrP0JYZ4DMp5TfwttzK4xQrcbQuOZ2hxg4sKSFIce6fcDd7QZuV9mHKRqg/uZhLT+tNbO0VfcBm+Eg9p3swC3fZk6ToozbmCqwDp/5Nqgcd0/6qBHalua6UcHmFIoD4L6jDpVcgk3geh+nalmSkdrGOXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT6ulkcfOB8St09I/RIf+NA0IIQWTO89A9cUVNUGMi0=;
 b=rjnauW95Ib1rV8rQWhcib5v0MxGexJUXQEcYD60Q7WJb+bZQ/Xn5ugKN/3IAZT1CVLr5l4CfH3GvhJnzRkXWgFB3hLNwGmdQ8NbntUQFxqtBXuiQhSX8nh1c+oFKWl7UX6c78pFatX5ZquW8DggNBMdFPBUdgkkR/25+lztjnD8wxLMFguiCzS0ouH0H/TSmAyXFgcDv1K+ByEffw6zHoPSuvWxiY/EXEt2dP0K1igT7pKbWcbLbcVlggZpuG+dfRUYWhhQJqB8sGlH4xgq4WsgI+gWwf7APkANxqAc2n401aWRmqbwvlzk5ISZESc0l/7Z0wxV0svO9ErvbskKQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT6ulkcfOB8St09I/RIf+NA0IIQWTO89A9cUVNUGMi0=;
 b=lECNhMw8kmg4qQWagB71WuxsZpopTTpidI296XxXo+xWR6ExfV5EPq7fg66bc/7Ss5iTi9FpJsT49EVA9DuSRPgO1VBuQAPYredLpzKVVYK5KjzEZcnfJimygkpGnMMkuWdVuKtEDsMKKdOySCksVup8xf7O1iVNQWtN+HY6awlA+gEOEJ83f2cLKa7F37bogsvC3Nomdjdtz3b11RM+t+mdA6pOfLSUCMC40fe+gKtHjo0EXfBPWTP/Pt4CdEB8fJTw4VL/Ptc5RrGGZJQCpSDxv/vehOGblQN4Q9sTA2/sdg2U5y+QkU07S8M5YkeL0ylSRHUe+m7Yu9sgWQ8/vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 14:34:51 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 14:34:51 +0000
Message-ID: <8195bee8-64ff-4333-ad96-73899fdeb697@nvidia.com>
Date: Wed, 25 Mar 2026 16:34:41 +0200
User-Agent: Mozilla Thunderbird
From: Raslan Darawsheh <rasland@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix NAT64 HW registers calculation
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, stable@dpdk.org
References: <20260325095826.5459-1-bingz@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260325095826.5459-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: af59d812-e27a-495b-ea6b-08de8a7bab49
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 3TCw1bgxDIuUFFgnqT/OxngQCU6BeJ+8R8+okbBB54PlxvR2OTGhVPnDyZWDaNRid15tWFflOoW8j3u00WgypfU6RQ9AuA+nyD5QC0PqyAf5VGmAf8nq2IE7OL0UMbvAY0sOkEHo+07UN/y6y5ckzx9D6PxQ2IU1Kapu3EGuNZKZyISMdBsC0mp7pWoJ8GWmmwFLwsn+63uq77ccHWcLVY4uaFQeuxLsGVGNUosBtiN0XqOrCJeWBHVRM+asZUzBHuTKcpo4S+AAeX8E0h8sKcPQ0TpXRmeSgouE/1WrRsVxvkDvl1vEKdJgGfUZb/6DmspUTCMjIBBJIx3NN5JCHADnL1avqDf5JPhgscm620WNER7hUD7rarm4AfHSQ3gRTGsrLc9Da6yiZKVW0P/X/HPI9bOOPSsjBPbS4KQleLlZTg521UD0RPGKACaRCb7+26xRcRHCz9dpxfO5kxwvX4hI+hqQblIxaWor2GuOHFaTME4SdH48yjcDikHeNunVWPCDjj4QQZdEYNyL+M0jS8OnveKVYFIEU1nuT4C0QhGV/gpaHztuc6DaYZWhTDjaJLm8XQ8djVdsxCYgKuyuNY6AMNvd81+eWqaV0GK4b53MzzIIGacgrAOs7TfT2/oknU5sYsfWHbPzPJvZSkXFwVKjCAXVAs+48dLKa7V1jmJg/9qU9jnyx4rudgvisYQ9lA7Pgk8pGXxlgHvJhysuTfVzedUC+jpJvGElirsrxZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk4xanJmN09GUGNBQm5pczZGeStPWkpmc2JhemN5andMdVZSOWtVSTRCekcx?=
 =?utf-8?B?R1FJcTN4ek1VdU1wOEwyWVNQL05aQW83MWZOS3hCVEM5dERXWm8zMEV6S1Qy?=
 =?utf-8?B?WlUvZC81VHFsMlEvUXlwSWxya05aK3ZnbmpNUEJLalZMVUlvcE53UncybjF1?=
 =?utf-8?B?ZHRQVTdqeFhLZEVJRmlvdkpjVUtvWDJuZUlxWkFKRnFac1duT00rS2liZ252?=
 =?utf-8?B?bU9ENjRodTB4WnlBS3dBNllpellMTzd1SDJlN2JORXJCYmJDWnIvSEF1OFFt?=
 =?utf-8?B?SjdWc1d4akZnNVdyNmxPRW5xT2cya0x6TUhjaUx6bWR5ZGdiUmNucXZ6UFJY?=
 =?utf-8?B?SFpvZzhPWm5FNy9LWnl2d2hyQitxcnlha2tPTkhMcDh5VXBYR1JHQXpqSFFU?=
 =?utf-8?B?NFJoSXlvZDRrR3BlSUVWN3N3Z0tIbjZYTm1xUFVGT1lLQU82WGgzeGZjc2xK?=
 =?utf-8?B?VFUrUmFaUTFNNU1Xc1dxemRjakp0c0tlK3lKS1RPczdVK0EyWDlIaVEyT1Fh?=
 =?utf-8?B?WnRNdjRnc0FOUUVKWFpjV1VheFVmSWljZTNDR1NvZTE4MlE3UmV3ZnJLVUFC?=
 =?utf-8?B?K2c3RUJyZHVuWlkraDB1dzFPcHd5RlJQL0lYZUphK2JqVlF6eVkwMGp5WVUz?=
 =?utf-8?B?ZzA3MGJGTkRzbi9XT0d1RTdqRlprbm04Q3lvMmtQTGZORm9mM1MwbVZNQWRR?=
 =?utf-8?B?STc4Yk9RTkRGYy9BcjI5UXVsOHFkZC85OVFLT3kxME81eVNjbE5IVkZ0Y01E?=
 =?utf-8?B?VU5qKzZTSkx1bWNWOW5CTE92NVVXL3NLcngrbG1pN2FudGxWbTBxNHp3VUta?=
 =?utf-8?B?MXYvV2xpRGFNcTAvaFloYUUzUHZidThqczl2NTYwMUVaRG9ydWVhc0RFdFJD?=
 =?utf-8?B?Sk1pMkZhNXZmTEdVbkNmRCt1VkhYSkxPR21TbHJIbWNIWXZJUGtMM1prQ1o0?=
 =?utf-8?B?eDlsWEtJdUpMbEg2azNOVk9VVFg1NHRIWEhzbjhEV2NYRUdFb0JRajE5U1Vo?=
 =?utf-8?B?SERoc1VGcVljUXpwUndFbUk4Z05ZbWhXLy9BdjBWSHdPckN0VkJPb054OHJV?=
 =?utf-8?B?V3dpWGpad01VczZJTXB2MkZlVHhNZklMSEV4Njc1ZmRndXFMRUJDNy8vWjUv?=
 =?utf-8?B?QWpDOFRSN25iNTBuQ1dTMVBOb1BLNkRzKzA2NzBKa1ptYU9SYkJ6WDZGN1A1?=
 =?utf-8?B?UC8vTHVFcXRqWk5nQ0JPbkJ1UE05dCtMR3JuOXlNdjNUZWVWTHZyTFYrTzB0?=
 =?utf-8?B?UUpDVTRGSzh1a293UUxEeHBxYVBOQzBsVDhNOXZCby9YUEpXbVhLVi8zWEVO?=
 =?utf-8?B?bmxwTmoyazdyZ1VhdG9vTHhxb1V0R2JvK1VxVjA4VCtyN1JnSldDNDdBNWhi?=
 =?utf-8?B?WXhVbnprT0I0K3VDd25QS2JYOVF3aHdkUlFEajVuS1RRUi8rT2hOSVVUUlF0?=
 =?utf-8?B?WU1YRDFLY1F0UnBxcVFkNUVCWE1mMXA4dGNJNVdrRkV2cVFEZHJkM2xxREhE?=
 =?utf-8?B?Yis5Y0pkUUNRNHlXRGJ6dlZUdE5hekF5LzVVSnprL0hhZTVGNnRoMlNSZGdB?=
 =?utf-8?B?OGpOMHNEb3k4aDc4K0RYbkJvTXkwNCtaWHpXbDVLK3NLVWJ4MFEzK1dLZzF6?=
 =?utf-8?B?UCswY3hFdW0rdVFCbjJzQUo0ZHRqWFlxaUdxdkl0VHZnYndwNEg0dXJVTkZR?=
 =?utf-8?B?N3F5S2plSnBrd25NVkNycGwzV0RrRlBKSm90WGtNb2FNUTZ6b0c0VDlvTTVS?=
 =?utf-8?B?T1FpdHVubnNQZUx2dGtxYXJpRGdRRjczVXJDdTVhNmJ1MVJvRDlOVEJoUy9C?=
 =?utf-8?B?dXJoZXp6dmxPNXJDWW44czZKK2FLRFQzdDlvZjV2Vnk2cVhWOFdzbVI1RmJ6?=
 =?utf-8?B?dnk4Q0ptckZINjhJSlo0c3JUcDlaYnAzOFB0VnFUeXpMOUF1ZURxa1dkWVBx?=
 =?utf-8?B?SkRQTi9GZ3RoK1BldGFuRDVkYjRraXk0LytOY294am93cGVVM0dNYjNLOGx6?=
 =?utf-8?B?UmZDdHlIVGxoaTBKK2JhWVlDelNWaDExL1A2ellESmdRT0toWGJFeXBJanI1?=
 =?utf-8?B?WGhzY3ZlVXowMkp3SzloVVJjdUdjVjdqSWxKNHUyaFBXbHpxOGdCUVJXNkNw?=
 =?utf-8?B?K2pyZjZadkxTNUFqblc0MDZDOEJTakh1MVRHQm1WV0JjM1k0TEF5WmNmRUV3?=
 =?utf-8?B?cjBxRG10dzJNekxyL0UyMDhta0NHT2Ryalpta1FWYlRGamdaNG9OT1dzQytj?=
 =?utf-8?B?TDcxSHlZMVhKM3NuUno3eG1aaEc0dmk0QlJqdE5sYUxTWEUzUVVMSlpwVTFa?=
 =?utf-8?B?dnRRTmJIaDR3WGlQeC9DNHFsWFBoSWlEeWVDRHRleFdPQlhSeER5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af59d812-e27a-495b-ea6b-08de8a7bab49
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:34:50.0696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F63kjoC/pgxzmZDICTidJG4BV8fSFwBKUDI4gtdsmgGF+VpcOhuLlUJUKVG9XRU+WK3a7eNRZONBHISskkjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
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


On 25/03/2026 11:58 AM, Bing Zhao wrote:
> mlx5 PMD needs to select a set of 3 HW registers
> which will be used to implement NAT64 flow action.
> For compatibility reasons one of these registers has to be REG_C_6.
> Offending patch introduced a bug to register selection logic.
> If REG_C_6 was not available for use,
> no registers were selected for NAT64.
> So all the registers' information would not be initialized for the
> temporary storage of headers information of NAT64.
> 
> This patch adds missing logic to use the last 3 available tag registers
> in this case, allowing NAT64 flow action to be used.
> 
> Fixes: f15535128617 ("net/mlx5: fix NAT64 register selection")
> Cc: dsosnowski@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

