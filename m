Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C25C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 06:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4782A402EB;
	Tue, 13 May 2025 08:27:00 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by mails.dpdk.org (Postfix) with ESMTP id 458254025F;
 Tue, 13 May 2025 08:26:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV5bDT80rJQbe8W9zJ/EAvwUO57iruDwc7BoGanRA/n2BI/ZXOqLVFK6fjEHsotpMle/KhmGqwLjcOLEaxh91sCbL5OvqgX7jcFw3W94TrlSgzWO7WDnv1aLdl4KGUT13d1si5M/F+Dqh2i49AtvgLFlNYd08yzVNrNMMPB1nzpA512NVcAtN4UtET0UOC/757jMYfzFGat1WPwmpU8TlOaICTUd3UUkHJ/HkKyQCdEQOesGYhu6ad6Afg76QGUJTWOeLcGIwCR1FwQZzYODOMKyQiBDPN+jqsZkCWzc5sjdpx5T+LLBtp+4x6jGRegR8kiqTZmVF2CLZva4DD0/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qjMjc8jhhJbjZ8b5HvBF8/+4HHvMg0ct2BeAYUGYto=;
 b=D+TVBHO+dt3IuhkDV8b4YT5pGXMoLKSHaPwHdkNMM20hR1ya8yiTppEYYKZlkyMh7KYJV+uR5Aqt5NclT0/1xgVbQki4mMu+EGmoAWzpiMmqSd17FTDoAGrrQuz5gacOwhypIXyTNWEOyal9xPWSF9FFHzcUYDI9RNYX8TANU/6od1cWlBDINR16eMt+uyWFt6XFTYv6TE/WX9bOgncHnUe9vHUXMhZQo+67oIJu9fMulXj4H0o/h4nJscKjfceJk5Mv76wcyI98N7WGspOPknUXV+DtbamIprnBgXovnUL1jPTc1w8f6qmiQn3P4BsRox40CWG0smAbl5zlOqkhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qjMjc8jhhJbjZ8b5HvBF8/+4HHvMg0ct2BeAYUGYto=;
 b=DSFdjiU5F3tpCFZjD/faSGiT9yJ0uj+XiN5KhmaH9URrFt4R6qGTJIpb8AHFR1P2PJ/7aSAspKUV5hR8gx1PMtwzpzaBiai9yCMuwAX8/FrRrVwbJj2vHM+LYuwVl64YHiA1IpMJOPd0kFLPbUjFk3netVimWJOGeBJCllmVCIrIf5RRu6ocmlX1JII62AmTec2wesxHcObxGuvhy1JSFAioyiEOivZQuJRVJuTW+Gow6HmaoFutSendxqv7GiJ+yRZr8OVxDUOWHjAhcGHFNYneBaEochFkgS/zza35a7riI+HN6KGGv0qGV1TDU0wvLkXXl/Nl4l1GJGy7z0K3aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 06:26:53 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:26:53 +0000
Message-ID: <5190f6df-80c7-4f52-b009-9f2320436dbe@nvidia.com>
Date: Tue, 13 May 2025 09:26:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/hws: fix send queue drain on FW WQE destroy
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, stable@dpdk.org, Alex Vesker <valex@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250427112821.108929-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250427112821.108929-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5e1ea3-9134-43b1-f457-08dd91e7270c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0dDRWNiOTdZYzIzR1dQdE5NWGE3ZzkzMHZiWFFJSkZJMXR4TkhqZUxEd3Bi?=
 =?utf-8?B?bk9kck5WZklBVW1NSDJGYUQ4Zk1HYWpnT3hFb3pFMzhrZzc4ODd2SjZDMmNo?=
 =?utf-8?B?Wlc5Q01jNnE2OXNLbjU5VVVTbnJVdmR2Zi9rUUZpaFdPMjZsNVlHbFZGRTJH?=
 =?utf-8?B?Vjd5WURDUmpnOWhDeVpBeTNuNUNORU83KzJvSzNyUi8vaEE1eGJZcHhib1pG?=
 =?utf-8?B?RkQ0ZDV0am5YUG05c2dKSmUrbnFDL1BlWGFXcjdCSnRaRmpqVTdOUURNc2Yz?=
 =?utf-8?B?cGlUNUk5aDRxTTcvb0t0Qm9XTHlGa2NyMDJxdEdDYU95S1NOU2ZGTHgxSWpv?=
 =?utf-8?B?a0FlbUV3OXJBclRORFFNWm45TFFuLzNoZHdpdmc5THQyc1BWMS9kMVlJVXdH?=
 =?utf-8?B?RWU1OHNGT1l3cDBhaWlKSy84RWNBNVk4NHY2YkxPNTcvSUxWdzhiTElvTU8w?=
 =?utf-8?B?RUxSOHVIM3hwRnpsZlRUd0hOUnc3d3lzTDZWN1VmUkFHamFTaHh0ekVXM0Zz?=
 =?utf-8?B?dy9EdVlyWjRzZ3E0SEp3OWhTeWlXb2JvaE9lSDk4TGo2YTlCa1FxV1IrUUMr?=
 =?utf-8?B?ZjZLMzNtRkV0NHd5TG5IWDVhRyswV21KQkJVdVZpNk52V2VMZndNYitxZWtp?=
 =?utf-8?B?WU1JU3N4ZWtRRm1pSWFzbjJQSDc3bzJnZDArMGh5TDJoeEE1US9CMG1DVUVV?=
 =?utf-8?B?SHFTb1hlRFRadUxoa0dvR1hjbUpHVzZkRkVYTmYvOUVqdVI1SU5PZmhIWnh6?=
 =?utf-8?B?cy80bEZZeGlJT240YUk4L29RbUVpUjBHdDRFZVR4emM1RVBGUGwveW5rNm5R?=
 =?utf-8?B?Q1oxS0RtK3JvNExkNEZ6TGtxNUFiSkx3RHlyYnA5TDRpYWxKRU5RNUw1YVpN?=
 =?utf-8?B?KzlqS1dJQXdJeWlUSzRhdlpxNXNEOFFxc0xlMSsrekVIaHdIdkVQTmFFSlhy?=
 =?utf-8?B?SndaNWxMNkc3alZoa05rdm1Oenc3bkpLK0hMSkFqZGlaYkMzRjU3WW5vRXRt?=
 =?utf-8?B?MGhmUVFkNVJ0YVZGSzlPY1E4dkdXcWx1b2JmMytJU21sOHRQMEFZUUR2dVYz?=
 =?utf-8?B?MTN6ODZyR3prNElyREhIcFV3M3BJZEJ4WkpPbTdRaG9RQTVGb1hycEZ4L3B3?=
 =?utf-8?B?SFY1Uk5FdkxESVhkL2V1akRqMmRpM1hYTGNkOXY4Q0tNTE9qTm1uaFF3RWx6?=
 =?utf-8?B?c3NSbVpTanpXY1RPN0d5akFXK2hCU1ZPVldOYjI4V1RzUWdQZVRncmo4aHdP?=
 =?utf-8?B?OUtEY0xYVS92dGg0WVFBVjFvNXhEMFRIYkJ6cmpKUzAwZHZqKzUzOVhuV0Jp?=
 =?utf-8?B?dGtOM3l1S01TcG93SFJjWVplRm9WRVd4Y0lBWUpYQ2RPVWJnKy80bVQvNGV0?=
 =?utf-8?B?ZUp2Z3QxYUYyYk13ei85Yk8vdHRRTjhWdG8yTVJ1ZWx6ZFZRZzJMY0oxaFIx?=
 =?utf-8?B?aHBrRW1zanlmajU3VDYzUlpRTnNYTTJYeXJ5RkgxK2lYZVdVb0RBSEM2eWM5?=
 =?utf-8?B?TldJN3RPeW9VVjdDQndvQmpScHdkQVY5eGFldE43VEltVklUVTNFeUNXRnRJ?=
 =?utf-8?B?ODFRL0NHYlJRY1d5cHRUcGJ1eWh0OTZDVG9Kd0taRmNlNFFsUDRkbUUyUlRR?=
 =?utf-8?B?YmYwNjRjQWpaMG1NQjM3NWNxVmc0ZUNrV2ozNWFucU9rWkxnQ0M3TCtQVUhV?=
 =?utf-8?B?alY2UVFPQUdaSk5wb05mRjNDY014QjJKdU0wRGo2QmVUVUUxWFBVR2Z4S04r?=
 =?utf-8?B?cllOR1FpcC90bWdNNzhDaURPZFhUTjVkYVV0Y3E3RWlJYWRSaU00MEFYcm1l?=
 =?utf-8?B?TmxTT2ZxM2dVZG43NENaQXRhdWZpNXp2YWJyOTFOZktTTWhJUHVGeHV5M0tY?=
 =?utf-8?B?a0ZTMWFtdmxOZWZWSmZmUWdxZ2xvVzljQmYwS01oTVZEWGltVzZ2K0ZSbXdZ?=
 =?utf-8?Q?Rip4sBkvVVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhlcU9iVnIxWk9qeGhXNkI1WVJCL0Y5cHE0UjF4QVRUSVFFOU04ZExlNllO?=
 =?utf-8?B?RFpjM1JUZFE0eW43c0paRmgvakhYcTdzOGYwdTRnZHJxOElNRUVrdytaYldQ?=
 =?utf-8?B?V2gyNjZwUi9mNlk1eHY2T3lvWUpySExrVnA3THZVQjJzRHdVRDZhditaSm5u?=
 =?utf-8?B?RE9MVEo2UzR3TytxdUlMclRFQmd2QTR6ZTJsVnA5ZXZpNzV5alZlbCswbkhn?=
 =?utf-8?B?M1FlUTNDMWVCWWZrTWY1MDVBcjBNaTc2MXpmS0FWanpPUENFbWJvK1QvUE9l?=
 =?utf-8?B?a2lMS3B5ZkJoZTZhRmw4WFcvRkxlVklGZTU4NC81WUxUMkhaeG5YUnlXNlRY?=
 =?utf-8?B?Y3NKdmZUZk5vdm9pSThDNVhkb1k4M3Q3Z3RqNHYwekp3T2w0anNWaVgxUFIy?=
 =?utf-8?B?MnczM3BGWTRsYWtRTW5qQUNZRytsbkRMd2twSnZ6STJNbFVTMHVINS9uMkFm?=
 =?utf-8?B?SE1adDI2dGMzd1dUUm9yZmZCcER6bTdubkNVK3NDVWdqM3VEMkdYOFRaWHFV?=
 =?utf-8?B?dWM4Q0NwMFFXam1ZSWdhUDkwMmRPdkZ3Q3I1Z3owSjAyem03a0g1cFpUR2tZ?=
 =?utf-8?B?SEZma2F6d051bE9OczFBMmU1S2JGL0VVNy83VkJ6bnhacWNMZFo5VEJGeTBo?=
 =?utf-8?B?b3Ntd2g4TzgwaEdzdnJ5Mm1PUzdxek5uYkc5VjJpQzVJSDVOZkZhUWZRVCs3?=
 =?utf-8?B?RkRoaVNvUDdaL2NsVE9wekZralhPVnF0cHdoUHJudWZ6RTFqUnJHRXNSMUxk?=
 =?utf-8?B?Yzk1T1N2OWtmT0lBZjl6S0duQTc4cnRrRHBCdnBtZmVUNkxINmtxb0tCdlZ5?=
 =?utf-8?B?UkFjZnNVd2dvQm9BSVZUdFFrWFlIdXpkaDJ4OUQvTVJ4a3JwNUdpQ1pkVU1N?=
 =?utf-8?B?QnBpL3hVYlI4Rzgvck9hdGxOL2ZPRmQ1NXdsV1JIOFZ0V3hORWJldFRadGZr?=
 =?utf-8?B?TWNIY2k0UVN0ZjhQU2E3N2JwK2JPZVlMSlJ6ZjJ4TmpleXlGZnpQL0lQcllP?=
 =?utf-8?B?ZmJLdnZyd2NZbUdUbVB6Uzd4c1lYdjNDOWZzcEwzN0V1TXlLRUVQRVMyTHB6?=
 =?utf-8?B?OHVTNWd0bFFwSzc5cTJldVpxN3l2aVp2OVBSUEIzQm9BcVVsTWxEa1FVMy96?=
 =?utf-8?B?UVJZUC9CTytDa2RtUlB5TVRoV2lqcDlqMnNCdXJkT2JYT1Z5WmM2ZlprN04x?=
 =?utf-8?B?aEdGQkJEMEhyTE5VaEVYeWttSEVIeFE3Wmphb2VKK2pwTk44L0JhbGRUelR0?=
 =?utf-8?B?YkcvWlhkQ1N4UFA1UkNjdmZLR0MzS21HZ2RWUjYvQTJiVXRrN1hNcjcwS2Fo?=
 =?utf-8?B?M1ZjZEJJVkZqbFd1MlVvYTArWFV6Q0R5d3ptSjhwRUVEeFBiSzhrNktvcFRU?=
 =?utf-8?B?QndNNjZjRmQ1VytVc0FLcjJWQVUxYkx0aXNwRnZtOHlRTUh4dnJYdituUXh3?=
 =?utf-8?B?eVNLcUkvV3JCNjFVWFBEUEhpcEVVS29OOWVGRnpqUVdZbi9nMnFURm5CZWVr?=
 =?utf-8?B?QllqR1JQSzN1ZU5MeGh1SkhDRnR0WFJRSUFuZDRaWUJpL01COGFnWGNObHZ2?=
 =?utf-8?B?WHptR2VXMWk1ZExpVmhVZnIvWnRkUUFsajVoMG5md2Q5WWk0MG93Mk1ZL0pM?=
 =?utf-8?B?NDBHd2FXU0IvajZtK1NUKytVeldFZENuODFSOVZmRFhGSEpTU3RucmE2SldS?=
 =?utf-8?B?UzQ5SkJFY1NYbTFXQkQ3aXNZeVk0VUVnbEFTUlBvK3BMczR6MERxSExKYUQx?=
 =?utf-8?B?dk1ySmw5aUxwVVY2K2RzNjFzNTNwMFJieHRFdlpGWWRPeG52L3pLbzUwL1Av?=
 =?utf-8?B?VlVKNTNwa0ppWDRmNVJkampJcGdqYUdFWlFSNEZZMjFKbjNERmxxdlIra2xs?=
 =?utf-8?B?UzdOc3BqdXJBN2U3NXhTbUdjRXN4T2Z4MnUzU20xUFhXNnRiZUpQOGRuOHRI?=
 =?utf-8?B?WlRoU0RKL0VrL281RmJRNk11WDg0eU9saExZbXNNZEJiYldPK3doOWRVOHZo?=
 =?utf-8?B?MkhPRC9hcngyOWtSajE2SUVQVWo3bmo4WVV3ekpMTjVVbERJdGZvbWhkdnpM?=
 =?utf-8?B?SXIvWEdTSGl1bnM4Wkk1Y0VRVUxNVmhoTldLempuZWU0Mmx5dXBlQ25QaTFK?=
 =?utf-8?Q?/OHXSIwpPhwubK1X/ldNRFk6g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5e1ea3-9134-43b1-f457-08dd91e7270c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:26:53.7766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/Nwc6NHLiErLt2zVSkFjNieNkDJF0qNar1OFlX5OaV2awiEH0sBER/5coER6cnSy2N5Vp2GvPOE1/ellfrvmA==
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


On 27/04/2025 2:28 PM, Maayan Kashani wrote:
> Queue sync operation was skipped on rule destroy.
> Unlike on fw wqe rule create in which both fence and notify_hw
> are set to true, on destroy fence was set to false causing
> previous queue operation to be stuck in the queue forever.
> Example:
>     rule_a - HW rule, rule_b - FW WQE rule.
> Sequence:
>     rule_a destroy, burst=1 (HW rule put to queue but no DB)
>     rule_b destroy, burst=0 (FW WQE rule cmd but no queue sync)
> Outcome:
>     rule_a is stuck forever in the queue - no completion.
> 
> Fixes: 338aaf911665 ("net/mlx5/hws: add send FW match STE using gen WQE")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Alex Vesker <valex@nvidia.com>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---

Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

