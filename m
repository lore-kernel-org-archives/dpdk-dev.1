Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58853CED619
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95C8F40265;
	Tue, 18 Nov 2025 12:22:11 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by mails.dpdk.org (Postfix) with ESMTP id 262EB40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 12:22:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y61A2SFaCMoksQ0KdtaI4p0UXdqTlDTtftmv89OPeRSNb8tzLr3F/l0DTbYX2DAFcx9HddhOR7nsV6O0dFnIQmkbmj/23opIWdvgLP7OF+HqJAdDpGD+xVtF0CcarnXk9j25GGZR53Ak+h8v9LSZOf/PPL5KmCWQqqCryGrKLJDaNFVQ0EnBasU2I1TlpDOi+L5oX9TqEz0/eYvC2Bm1moS9si9pqAHaAhV/PwPS0mcTx8MJfDfv5bY1/+m6dWF25LVBVVZ2Sq2a2tFxQVlcPQA1f/Hhth11YU6Z6OjSLwY+WZMX6+N7iwxW5DsAKYqr0XcdIG5U4XScSo/NmGX4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS3jBX7TSzLls6+jl/exk9fj2O7DjAN2N67cRA+nb5k=;
 b=QG7PJeZW6lrBLbWPPdhS7tzGDKg10MHrneiTrcye//QBmkfCiDc0NcSEhyqxUQXYjENHXZ2qzQ1XUPHQuJmc50RCVqeZ1P2uzDXfTtZC/zEFUG6kpHOH09uB6hfslLvCAOlVXfMlXOu9o5bOdWkpdq1gAwOPVwyBi4vPKYHJH5ztr5H7avM53ZrJ0Q/pK7re1Pczmd8OI3mlzmTNQHTMvK7ma/+IJVfxbJvCccV219cWTPwmOSl3lRZ1FlXW0/Z2PemySKqIWAkpVf2nmnRh0WnSiFGlDeBxKZMe1BmhZt2S2OCxcT+xoDyKZbVHtPRwdnbodWOf+1p17Sq2WzZ9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS3jBX7TSzLls6+jl/exk9fj2O7DjAN2N67cRA+nb5k=;
 b=PZzZdGkaL/ooH8jSTWMh76xzlQXB8jiqzNi7t4SQSkWUyRGAIG8o4njZxgOj8h58s7GTwNO/wUKq4NcT2zqhnplmm2uexd9T+fKg3NW4+ObuGWFnEwI8hsyQSyjQawrr0FhrgK65HzyyLWG/T4yMBDhuMJylemmx3TrIz0V7EjAC7/KALlSxbn9y1w1qWTaLQE08Df9EDOxtTsDJ8ItSdz53Ubwkh8UFUq1a0PXzuKtfOFbz+8f0AxoHbGZTBKjQi37b69UxKrs9V7uYb4U3e7ecrPwqF2+qhTimBafRrJcgFQC8JHFTfLXD1b3a/zIi8b6zW6d8++QEqqwv83GZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:22:07 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:22:07 +0000
Message-ID: <4fd146b9-6e5c-4f45-b519-26640f0502e2@nvidia.com>
Date: Tue, 18 Nov 2025 13:22:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: improve error on completing table resize
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>
References: <20251114192712.1637369-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251114192712.1637369-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: a33f1522-709c-4787-5552-08de2694b55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2VJSTFHZlVaaEsxRVk3K1Jmbzh5YmNMNEpDQkg3NFNWUERtcS8xQWMyY1pa?=
 =?utf-8?B?RFVMWm5tM0FkdXJlWHY1VUdlUlNQNXJkaDZ5aHZSSExDZjNtblQ3SkJKYVVQ?=
 =?utf-8?B?bzZSMkx4bUcwR01lMW4xU1pPU3Y4QVRXSVpyQkZwMzd0NWlmZ2kyK1lLRDdS?=
 =?utf-8?B?RE1kK1lVZVYvNHRLeTRKK1BPaG81emYxMU15YmdXbml0Vm56eFZiN3lRUTZv?=
 =?utf-8?B?WmxUUlJPUHZlMXNCOE5VS3prSnhKb05VQ3NGZC9yVG9jcWlsY0pETTlna1JO?=
 =?utf-8?B?c1JMNEEyYTMxcGpxQnhzeC9oa2xqdmVBUE1uNnRRSmVHeWRMaks5aTZYWWR1?=
 =?utf-8?B?b0JrajBGVmFaajd5R1ozV253RWE2aTg2Q1RTdXZaeGNsZWdCV2UvWURmQmdV?=
 =?utf-8?B?SXJvcEFDck9KZFdLSHBhb1hTeklvNXo5QmlPUU00STRqQU9ENEg3dDUyc1Vu?=
 =?utf-8?B?UC9JYm16UnNncnpTVXdVa2txQlRKb21XMnR5aVlubDBEeEhMQzdHMFJhRSti?=
 =?utf-8?B?T0FDYktFRW9VaFk1dVpnM1pxZTRmbXNMMFVpNGpBS0FSaVpLMWFYMmVzUkVz?=
 =?utf-8?B?Y2QvWmlEYnJuQzFYRVpxdWdMaDFuR3BDbWxrRkVFTXI1ZWNVYUlHM0o0NG1C?=
 =?utf-8?B?QVJ6Y3IwTmNqaUk1UXZVcXRDcG5Tb3FNK0VCNnRGMjJHanV2dEhncXliWWZu?=
 =?utf-8?B?UlBCNW1MdFJkLzg1a296L2xabmczdkR4WkNIYzFUVDh5T0lFZE5pb2NyalI5?=
 =?utf-8?B?Z0R3UEZmSHFLMGUwVVJlWnhzQ3pxNmFBaEVna2xBUmtDZk44SENoSlJJS0dH?=
 =?utf-8?B?RXlxdVRPS2tQTUFDM0xUd09uSVhPaHRQT3BMUGI2WFQvaFVyTW9EWjJGYWtU?=
 =?utf-8?B?aUdRaGFQZE54Q0NSK0VvaWRjSXhwREdEMVFKd0xCUVl6dG5Vbm9MSm81WFp4?=
 =?utf-8?B?eEs1aUNUZHVPRjBOWERGQ0M3NzRzYWV3Y3pYNXB2YUhkN0hDQlZ3ZWZuU3h6?=
 =?utf-8?B?QnlNSjRZZzhsT1JBWW1tTXV2c3lFTUtKdlNOT3p0U1B3cGZHM3NaOVpQZUVy?=
 =?utf-8?B?RnRaOWtlVy82NDdjSWZxVTBFZFNIL2RJbzZsQll6eFhnUXVGd0NWUzJUZldW?=
 =?utf-8?B?L0ZaUTVyVkFKQi9yUFdtK3AvRkdldlM1M0pEUE1HQ3RWd3Zja2NZNFozdFA5?=
 =?utf-8?B?dE9pWWRvcEIyRGorQlBkWUw0R3didXB6Rkk0eG9ZTlY1ZVFQdG95ODVsUjlU?=
 =?utf-8?B?dlI3am5EbjR1dkJNZ2cvRTRQZXltdFh1dXVJd29OZkt4NjBCUDFEdXJUUFgv?=
 =?utf-8?B?MmF4TWc1M2puWFRIQUYveXZqS0d2Rjd3Ukd1OUJhczB5TzgrajR5RjltbHVn?=
 =?utf-8?B?WnM2VGszc0hqWGxiRDB1SWRkQisvT1ZKbzd5NlpFQmsyck56dnZnczRieHVL?=
 =?utf-8?B?SDdtYXc0K1pJVVdNeU9sTVNXcHBOVkNCT0JvQXFydGJSNFR2bjhwV0dQNzhU?=
 =?utf-8?B?czJwZGJyU0Fyb3NYVnZvOUhJWktSdzhSQmtSbi9FSkVvYmZTUWE3cmtZNHpz?=
 =?utf-8?B?NUJldUFHemY3c3huajJOTG5WN3U2ZElMUk12bFpUaWlzU3d2b0E3RC96eHBS?=
 =?utf-8?B?ZjVOdEp3cG9xMlVacG9GY0lleWU1ZllNRmxRVER5RUpIZG5hRk9WNDFUcm9s?=
 =?utf-8?B?T0VlMTZ3enN1WUNDc21KclNoRWc4VHhFSXNGNDFVOHQxcklKSFZaUmF6M3Fk?=
 =?utf-8?B?aTZPaEc3d3kyQTNWb3pxc1c4c3kvcGNCTWFpOFVJMUZoY0N4ZFRhTVRNM3hU?=
 =?utf-8?B?TUhvdXpPQVBYTGs4elhSVEIwK2luQ0o3SFl5MnVSMnE0YUZJdmVQSjk4Rm5u?=
 =?utf-8?B?V0NCUlNmWnBRY0dVV09WZDhuS1YyVGM2WDN1V2YxR2kwWW15b0htNnk0blBl?=
 =?utf-8?Q?MVFNH77z4gxy3xjxk32Ib039ex0PmfS4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVBbjBTa0orQUUzbnFzQUFJZ3JXb2Nzb2UvaklkNytWZFo0Q0NZR2lFcUFs?=
 =?utf-8?B?cC8xUGJma2JMMU1jUG1zTjVES2pHZWJjVjE5RUkwWUo2Vndub3plWXEzMjVU?=
 =?utf-8?B?SmlLOFFUL1diempnRlM2QjRUbFBWcWdRMVpOMGhYVnI1VjZqSXdhYzZUS1NE?=
 =?utf-8?B?SVFxRm05WlVFdnBiL2RPWEhYMEZSOVVHUnB6bkJCUGt3cHBZdS9ISHk3Nk1N?=
 =?utf-8?B?dHdxZms0bnRyQnRLOXhyQ09TcUcySXl1S04xZ0lNSkNBMldsTlFjc3JvanpI?=
 =?utf-8?B?OWpWdFJ5eGlZTWF6NXo4amRTbllOeWxNTkF5NjVodEVyQ3BUU3dVc2xHei9S?=
 =?utf-8?B?eUxwYnFUMGF5L3NGRnZaL09UVWZWeHRQaHZIRjdTbThkaitWc3lsRXdHU2xw?=
 =?utf-8?B?Q1FsVFFmWUJLOFUzQ3dvUDVjVHlNbjV5Qk1laWcxUFZuaVhUTjBoNjYyeFhP?=
 =?utf-8?B?am80b283QzFLL08rSjZhV1FhR1NCQ0RFR25NNTFsSDdhMkVacHhCd1p6OXpY?=
 =?utf-8?B?Mk5MMzk1U3owTks5NTdIaUUxbU1yOFlnMXBXc09NTmkxeHNtaGFzdWhDejVQ?=
 =?utf-8?B?L0pNT3JCTHUwS1NHbll6Ly9GbnlYREt0MUZRNEJvNGl6WWlHN05QWEtPc09s?=
 =?utf-8?B?Rzdvd1dyc3dUVGdjVDBSV05LZXZQSnIvelRvbUlQVm05bjJnTU01RXNzU2M0?=
 =?utf-8?B?djZlbUVLZU11T3BSR0hndStOcHpyMDI2UHRYOGxVMVZDaWN3RjJiL1VJa01E?=
 =?utf-8?B?U2psWUJjajYvNDk2WVEzTHIwa1ZGdnljUkdmK1RmYXQyNEgrSUlZekx2TCtm?=
 =?utf-8?B?UXpSSU5hcllPTlM3bGgxdG04T3ZtNWhBZXI5UHVFbWoya2l3NTdYRWpaWDZp?=
 =?utf-8?B?anEyMWlldGdrSnI2V2RsdVJib29LVGJzMHZ4UEJha2h5N2U2b2N1Sm0rOXZt?=
 =?utf-8?B?bjZSU25WcG5lSkhtblNPYTdXU2pobHFrQ210TkJIc29EdHhucmw3MldtKzVP?=
 =?utf-8?B?RWF3R3Fyems1clNZUDNqOFdHZmhtL09HV05hbG1TRjhuOStNUXdGRjQ4RzU2?=
 =?utf-8?B?UkxTaHRhVldReDdvdU83QzM4SlIxZUZxbDVTdkhvTWMzYm9ZdVZDOFZ2aGpj?=
 =?utf-8?B?K3RqUUZUTXpNUnh0UVNHTTlBU29xdXBZZWUyWGdjS0I4dDVWYTJVemxsbVlD?=
 =?utf-8?B?eGhCT2VYMGVtN2tWNDFPdFkxZ2lMQU1sWEhuWW8yRk9VeS93UTZzM29DRGNI?=
 =?utf-8?B?R29OekZMdmI3eXlQZ3F2ekM5SjV5bXUwd0FJNndQTy9DUVkvOHppU044ZGdF?=
 =?utf-8?B?YVFuQmNIVTlYTjBMY1B0d2RKeExlOFZWbmNDMDRQeEV3UXpuZWRURWVILzk2?=
 =?utf-8?B?RCsyUDZhUkJSM1RrWjFTRlJ1Z1JGZXRlelk0ekF6QytUOXh0RjVqNUUrWXZk?=
 =?utf-8?B?N3M1MGxVQlBQd2VYSDBmN1d4Ni9JbnV6MnU0Mmo5eWx2RGh3RVJ0dEJaa2xz?=
 =?utf-8?B?dHhzNzVTdXc0T2xRUktWOUk2Q1RlR3UzKys0T2l2V05vZlhhOHFEc2FHa1Fl?=
 =?utf-8?B?SFJLZjNxbnJodDdNRFNVWDhBdE9XRm1ZRk0zeFFZL1NlK0RteWNTVmJrMUVX?=
 =?utf-8?B?OWF6MWZSRzFQdTB1M2NSVko0citCdTM4OFR2cXhPakp4WHBwdjQwNEt5NkNj?=
 =?utf-8?B?bmNNdjNjektOWUtoTFRsV3pVV2NoWE1zZVhVb3BXSUR5bHBXTU1CVForR0lm?=
 =?utf-8?B?K0hWdHZQM3JSRFpweXl5Q2VCMzUzZU0zUDFyQlphQnQvMDVGSGZjekZURVBm?=
 =?utf-8?B?ZEtkQkdjd3lEUEZwWEFBYjJRejhaL25ycFFkOEhZSVIrc3lqVHp4RWFMaHh1?=
 =?utf-8?B?UUtuVmM3aWY2emZuN01qYUhyZmYzWjFPRm5RNGJQOEtTRHhhM0R3QWE4UXpC?=
 =?utf-8?B?TXIwbGZiMndhSnVPVS9tNGFsRnl6SDMyYitPOFBER0g0aFJVQi9oMHJHWk9a?=
 =?utf-8?B?UzJDcENHK3U5NnByY1FJQklEWHJwc3dwZlhkNjl3UnVRclNvWHV6RFFud1NO?=
 =?utf-8?B?b0xoVmxRMk1wR3p6R0lHMDVCMHBPd3F2RXBLaUVXcGdFZE16R0hzU0tKY1No?=
 =?utf-8?Q?Sz8F+jzEKXo+x7CyxX66F2MtZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33f1522-709c-4787-5552-08de2694b55b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:22:07.5307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PArU8N4RN1ODsxEgMcRCIWgJYJKGmk4iatauytXkP9y3QDd3YbsdUYrvpUcZTMDIPdGJjmOLcWIgm8Zy0jXEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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


On 14/11/2025 9:27 PM, Dariusz Sosnowski wrote:
> If flow template table was created with resizable attribute,
> then completing table resize could fail for 2 user-related reasons:
> 
> - not all flow rules were yet updated to use the resized table,
> - resize was not started.
> 
> Both of these were reported with the same error message
> i.e., "cannot complete table resize".
> 
> Since PMD can distinguish these 2 cases, this patch improves the error
> reporting to report these 2 errors separately.
> 
> Also, this patch removes redundant __rte_unused on device parameter.
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Gregory Etelson <getelson@nvidia.com>

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

