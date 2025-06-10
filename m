Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07F5C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 13:19:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47513402D4;
	Tue, 10 Jun 2025 15:19:12 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by mails.dpdk.org (Postfix) with ESMTP id A29194026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 15:19:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbIIOk5mbu1AE4d9WcpIIaIvXWaUre2xBv+V+SrkAp7ZGjRpqrYG/l/EhIamrg8tWvNuOUqwb3lUchUPjOD2TTffD+qiOgccgxu7f2c6LdCH/t/ImTZUUX7gl4vddVHd7MEsj/HBq3gY4yiiO3sKLz8FVy0hA1zDZOQsRztlzWWRDnkseQJWAdizVtdxrt5ENCSwPJQTANVEaX8xYZBX+CgSNs/eO48qjK+HHOLkBbXAW8mtL66WsfQ8JA8AY1qTC2PpviXumjVwBRFoMa8zZHy052m0sd2t6aAkwyFCMdTLex3Ae55k64lfKnA+koFmOHisHEFXYbLajYnd7LYHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzi+z/40x2ENI9RosRRtjHbA1ZOH5zbeYVtlHNNl5vY=;
 b=IqzR6kB0VuYToOV0bZeHGn7GTlnh/yCoEkrG0B5oNsDaq0M/IWdTRfoDMrmI0in4/6+lroXr+YrXrBW8hpjLFXqxJcC9M5KfnfQV1+mtmzxnqSX9ITJDMFsuBgiXpC7fbtjFB8aFJ5PeF3LNSYOxM6mCq998uyn4BDlzKfsFtypXNEDAMzlINu07pKPPlL4WQhq3gJTKWywUMWfzcvyLW7BrpSAUtpDIa8dKp94lVDfLDtIjZpLUUZ5djFkDKqs7mn1cJmh1EbGI2OPc82gC7/ayJkr3+riiph/jVU9xfCNLzuc+JtxvOijNyASuDgDYBuLa4wEyLWhVBSRpebHSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzi+z/40x2ENI9RosRRtjHbA1ZOH5zbeYVtlHNNl5vY=;
 b=GsSVKy5KqT5VlPW46yXQVu5rMteR1JIlzXrDMK4uAdByGUn8WcAPZKp4WohnCZxP4I/WVIywO3lwylKg3xStKgSEE4Ylr0PIanx4x+PQkcR9PVD6rRKPc2LMFecjgTcka6XS3FpCs+LbmikBnYp0uPDDV1QmdmdiTMeSYMYW35Uew9E1dNgozRsheOA8+BJBEp/XygahcTz0qslnDrD6akPpYA6tSLIhMrIWuGt5Tocl3fJ52y/Ot4Z0z5RbqvgAoLjgtW5rr3BZa+tuiMPiD6+AZ9RYkMrwLE4yGUpDxSWshTTE5AEXwk9282K7Q0NWZZzARuydHA4zWg7RSbb6sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 13:19:04 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:19:04 +0000
Message-ID: <68a33a0f-b72d-4229-88ba-a013ed8e46c8@nvidia.com>
Date: Tue, 10 Jun 2025 16:18:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/mlx5: use intrinsics instead of inline assembly
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bingz@nvidia.com, dev@dpdk.org, dsosnowski@nvidia.com, matan@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com
References: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
 <1749046525-9166-1-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <1749046525-9166-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f6eb20-105b-414f-f54d-08dda8215f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmNpTFpBS0NqNkVVTUpkaHc3alVSaUoyS25mcGRtNzdpUVJWdjFJcTRrT0hV?=
 =?utf-8?B?T2hMVmdjUEREbXVmbkhjanpqd01KK21mWU9BTlBodVdoVU1URzg3TG5yRzlI?=
 =?utf-8?B?N2tpVkt6bW1MSUY3THo3dUYyeUlTaGtuS2NaaS9DZFduK05TNUtkeTdTMmRa?=
 =?utf-8?B?Ui9yL2lpKzVzWWo4SXViSG1LeFNpSGptdytGL3I3ckF0RlVxQ0FJVEU2Zmwx?=
 =?utf-8?B?amlWQUJ5ejNVRXZRTEdqVjIrRTlyZ3AwUGJJVXJ5d3JJaEY0c2p5R2NueGp4?=
 =?utf-8?B?bWhWWVNvR243eVEva2hkdEtDNDVHYVVTbGxGR2NYMUJzbmMxNUd3aWV5QWs0?=
 =?utf-8?B?NWFLbEZ6WHp0VWI0MHpUUm80M1JKNFpZZ2RtdVVRbGNwU1o1VWx6SjR0ZThR?=
 =?utf-8?B?Wi84VTJDemR5dnorRExSTHIzVE9xekNjSnVLQkt1Zm81L2EzcDhFOFRrRjRE?=
 =?utf-8?B?QW1TNTlQQTMxSnVlMEw0UW1VcDl4aXlZcmJ0VytIaStLY056ZlFsMmoxSm82?=
 =?utf-8?B?ekhoWWUzY0JvNjVmU2FHRU4xbnB5bFdiaHQ2cUlzd0FudjNGM0YyUVMxSUNO?=
 =?utf-8?B?dHZ1cUVrMWtMSXEram1GRmlwZzdNbUVXMUc1WXBxdWhOS2h6VkFqRGd6cjRv?=
 =?utf-8?B?MWRoSFp2SnlNYksya3MwQ2poaUVjSjZjd2NYVS82eHgwVEpmaDE2QWZSSFlm?=
 =?utf-8?B?d3dCT2pCOGJxdWdQeTNXRC92U3BjSy9SbUNBN2w2WUY0UFFlMDBpWGN5Q3pT?=
 =?utf-8?B?VnlsTWRNWDNIR0U1eTl1azBWcng0allXWlJPWGZwQWFqZGQ0cDJvVTZZMTVh?=
 =?utf-8?B?NlVxUUZmVWhJa2FOMFNYTGhIbVdRSzRkOE5XbWs5NEVVbnFKWmIvR3I5TXhN?=
 =?utf-8?B?MHJZdGRieG5zNklMeU01WmZFQWJwV2FNaGFDU1RSbmRQRTlCU3o4S09tVUx0?=
 =?utf-8?B?RjkwZnRsM2NZZE9ZK0hGanlLaDBIa3lKQ3kvYjgzbVJFNlM0RDhvNkVUc095?=
 =?utf-8?B?dittcDVwZGh4Z1oxSlRFY05ibHBlTEpHcXFnZ2hOcG1GSGVWK1VzV3czWjdp?=
 =?utf-8?B?WCtrYXJ4MnhZRitMZ0k4MTc1UThub01USUpkd0hqcnoyaGZhalprcFVVUm5Z?=
 =?utf-8?B?SFVHVkNQYzN2R010bmtPSlRXZXBldzV6Z3NKYk14S25YWTk0TmpZV3VBNjAv?=
 =?utf-8?B?RTdOUWxLWHFlRXZZSkZNelc2bldyVTRWQTF6elZaZjlDZzZydGQ3TnVBVTd1?=
 =?utf-8?B?Sy9RbWlnMkw1UkdOVHFSbFpzMkU0c09JM2xTTUJYNlExWUJ1ei9tTGs3ZzlS?=
 =?utf-8?B?a29UV3NVSC94ODFnV2dRanZRbWJMaDBnbjdjTE5NRWRVNFgwSm1qK1JtZ3JX?=
 =?utf-8?B?UDNrcU5laVJrZkEzZWlackNTb0hEeURWRzFFWktkQ0l2STI1L094TTluVWNE?=
 =?utf-8?B?dW1jeDFRdXJuREpyQ1IxNVJDbThmQlJra1F6WVhpejBicHE1Ry9DdHk0V3J0?=
 =?utf-8?B?Z3hYQ2hXcllzbWVLWmdSeE9XbUN3NzhjZ3pjbXcrazlsV0ZseXBQalpHQWZh?=
 =?utf-8?B?eEJPRlBxWEVUbkxPNXJpQWtMaGJVNDJFcXFmYnJRSE5RVlhueVlGT1RrNkRj?=
 =?utf-8?B?dzZtbk5mMFRBcXZ0VlB4RHFEQWMwOTUyajFDYTFGdkNaOEFoNjRNNW15MzR4?=
 =?utf-8?B?V2xTT0o1dFFGNlRhZXlVSkQwVXJCNnFia09Jekw5SUVYZENzTllpZlc1V2pE?=
 =?utf-8?B?UkY1a1dBaThpQThhcUtEZWlCQlQ4dWNOYkt4eUkzemNVeFB2NFJXMXd5ZTBl?=
 =?utf-8?B?ZjVJOEovNjdNSXZLcWkwWlg1OU0yRU8wYnF1bnphbzV1V1NMRUpodHBpM3ZJ?=
 =?utf-8?B?VFg0TXpNMlU4bzFOc0RnUlgyYWpaUEdrZElhQ01xM05Sb0REdHhCbm1wNml1?=
 =?utf-8?Q?T1Tb7HHVHRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25hUkFDV0l1NXdFTDFialN2K1M2WE5rNHlJODB0S0gzdGlqOXU3OFNBYWZM?=
 =?utf-8?B?cEUzNkY3c0lPR1YwaktDUlJSMEkvZHpNbWdNcTlHSmNpNFlZT0c2Q0p4TEJq?=
 =?utf-8?B?VzJGbHJ3aVBZRjcvbGh2UjdLVHpnTGpMbUhONXJGbktoVnlESTNtQ01ZdTlU?=
 =?utf-8?B?UXBIeGRBdkp4aHhmTnpGVEdJamFkN2huWC9DaHZqbUpMbGkvWCtnUTJOYjRW?=
 =?utf-8?B?OCthQldNb3NDRm1pcS9jK2M1L291ZjAvMGNhVGxHSjViTGpQZU91RENCL0Yz?=
 =?utf-8?B?Y0plOXZ0T2tmbjFneWxjbU82WlZrRVZBUld3dHVuamE3Uk55b2Q1WVBmcHEv?=
 =?utf-8?B?d3ZoM21EQlJwY3pMdmZxcGlnN1YzOCtBRWtIQ25XZ2RubnlRZEUxL0VaQlVS?=
 =?utf-8?B?czhKMzJ2WndBL2M1MW93cDZQV1o3bTFFZ0tVU2g0T3IyQXJld3B6TkFlY3FU?=
 =?utf-8?B?K0RzOVJMcWJaMHhWUTlrOWc4WHZRbURDN2MwL0tGbGtnZUVEa1dVSlMwWm1o?=
 =?utf-8?B?SGxoa2Y2V3habHNBcVZzMEJyQzFZSWJBanR0MkttL3gwNUVLelRlYlkrbEZW?=
 =?utf-8?B?Q2F5bGlYWHYwa09DVSt2bnBCTlN0ZU9IRENocWszN2hDN1liM25Iem1ETTBy?=
 =?utf-8?B?ZVVJYXdmUlMzcDBnOXZVRUpyNlVjMTRPZjdnQitYSm9ONDNwWUdPK2lmdDFZ?=
 =?utf-8?B?ZSs2UFErcFJ2d3VnVG1nZXBhWWlNbVUwUmdzWUdLK3Q4a2p0dG1KYWFwNWYv?=
 =?utf-8?B?OUhjemRjeWFxOFVIVERjblNGdTdwaUg5TzNwRy9PY1hUalA0dnQ4Ly95YjZB?=
 =?utf-8?B?bzFoRk1DUXNUdFNWdytoci83ZzhrU1QwTngrMUZhUmc0YTU0b0NSYlUyUEk2?=
 =?utf-8?B?L2tZendHQkprRGN4VGRoQ09nS2pxblRORlU4VDlPa29idzlEY2RXTW0wSE84?=
 =?utf-8?B?b0ZjY2RlRm1tR2RUSGUrRFRvSjcxdHVhMmMxRy92RUk5R2d5K2tGQTBvWGZI?=
 =?utf-8?B?YmRRUDEvQmJWLyswelFrSG9ZdFZXZmkrRFhPajN1YldpeGxUMk1uM1pxZk5B?=
 =?utf-8?B?SFdvYlU2NjRGOUZmTnVQaWcycWVSbzljbGppamFNeU5USnJlK0hKek5mTjJY?=
 =?utf-8?B?SFBEakNIOHVDYU9aam5vU2I4d2RFYmxJY25uUU9DTnBIRDA2Nml4aWYzTGg5?=
 =?utf-8?B?eDE3dmtaRGpBbG5SbzRpemFyUDVZbzlVVDdmdFVCdHgzR2dhYlhsSXZiaWty?=
 =?utf-8?B?eVpNaHovVFdkK0pBMFN1b3lSVVd1cDlNRmQyczZOc1k3dzFxZ1FpLzdIc1BV?=
 =?utf-8?B?UHNCd3NHWmZPSkNDajdRMStjdXNPWEFJUkxTWXlQNmU5aEh5dnkvSGNiTlZo?=
 =?utf-8?B?cXVaUEFxQjhSVzJBMHlxN1ZrMHVCNEdhZHJRSm1GUUZWN3RaM0hRQkZjY1hH?=
 =?utf-8?B?WVJzQy94Q25RcWZKTkZ6TjVERU9IMTRibXR5anVUVWpvMGh5UzVsWGRaME9l?=
 =?utf-8?B?V0pDNjY2ZnZ4SkVVS0lUYjBMMkJjQWdYbmx1YndBMmYydnJlYjFaakFlSERq?=
 =?utf-8?B?SGJHWmkzcjBHOGZNbEozZEpva1d1VEEzZ01DdUduSlY1Kys5bDFiTkF5K2g2?=
 =?utf-8?B?TkR1ZzVhNTU1V3RObGVGc2lqVERJb2M2QmRGeDNoK1pJOElpZkJVc3YvMTVG?=
 =?utf-8?B?SDhrTURqSTVzZzBmblQ4VXBMLy9ZUndFZHgvOGhnVTNzNytrRngzMUxUQmZp?=
 =?utf-8?B?bU81bG5zTVpDVHpHWm9uSmpEY2xHVG83SGdvYkZtQkpIZms1RGZoalhlZlBz?=
 =?utf-8?B?ekxtR29vcVowdjVuMms3WjduZ1lWcS9ScDdtbG5SdVhRQXRzVmlHV0k5dmhS?=
 =?utf-8?B?T3pOUktCNlVDVDkycXlOa2dmSXViOU1GQ2FqbGlMUmU3OVo5Z0JtclhPVFpI?=
 =?utf-8?B?cm1xeWJKYVRHdGVNaloxN2FWcnFRVnp6S3dlcTF1bXQ1c3NyK0dMMTdhRlBN?=
 =?utf-8?B?U3NGdEdJMjFTa1hQaUhhOHRrZkJDZkdjZFJBck0veUxiTlNKSWt2dUJMT1Nr?=
 =?utf-8?B?ZklCVFpLVjBoSkIzcTk4WjJKNEtySURpa3duVzBkL0NMelgzd0MxY0kxQWJk?=
 =?utf-8?Q?iNOzX0IjW2O3g6OgsaWodVKpF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f6eb20-105b-414f-f54d-08dda8215f22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:19:04.2678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj9VaqGVXh9nJDDKrygZcEs8Z/+7ex26buv4f4Tru3mylLLLpjBnimcXEEADu8X8KLNKgMUIVthbKaQiJYjQLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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


On 04/06/2025 5:15 PM, Andre Muezerie wrote:
> When compiling with MSVC the errors below are hit because msvc does not
> support inline assembly:
> 
> 1)
> ../drivers/common/mlx5/mlx5_common.c(86): warning C4013: '__asm__'
>      undefined; assuming extern returning int
> ../drivers/common/mlx5/mlx5_common.c(87): error C2143: syntax error:
>       missing ')' before ':'
> 
> 2)
> ../drivers/net/mlx5/mlx5_txpp.c(510): error C2065: '__asm__':
>      undeclared identifier
> ../drivers/net/mlx5/mlx5_txpp.c(510): error C2143: syntax error:
>      missing ';' before 'volatile'
> 
> The fix for (1) is to use compiler intrinsic __cpuid and for (2)
> intrinsic _InterlockedCompareExchange128 can be used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

