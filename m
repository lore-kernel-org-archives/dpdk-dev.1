Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8FCCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:35:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FB874026A;
	Mon, 18 Aug 2025 08:35:21 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by mails.dpdk.org (Postfix) with ESMTP id C3F204042F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:35:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgilUpRPLlShyc8Mi7Y/KJ7mT4DQi1JoWxySMoeSx7hjMFCvLaLwjgqASuSLQS/C2//SEMU2Npw269u0Xs15xhwfozpMRy8pOcHR0wUw2c2PuiA1bf1BgI+JxOSjAilf8HSbkDSrVcZvOCE3Ox1cUY1BTM2SyLbG24U61YM4MEUrY8sN3zbLKPsmXeM0mqAKIVZnqyDvVvQDGhCxUpE7aT/rNv6f4WcyJeXOWLnm87TpGfXRv3gEpmT83qXUgn+twaC2FViVmgp0SibHbUHzUKoZuXBD5O1ibyS9I2olTU9MPPmnk1ef0kTxzbT6lMP/TGi1woAqNdOxb39yOOodKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMKqos9za6fueZ7z6gbLrXUFdz5yQyYgzEIpyb0y95s=;
 b=TK9ECaDN5TGFvAF8evSxp5VWjSD7JmI+HAizFbCaMs5BT6naAHtkt0nkzo9WKPMDNy4TPYfFAbESyjFJ2y0BHjym9oWOwShxtldJcy2tXF0zFYigF4g1P6HXgwbQ+tlbfbHZG59repk6MUGiDtUsB2/sKo+GQ2/SUcAOXX/9kdRzU3OA7KRHOEuT8QrP9YXhzCqKdgaS66+DKMDMygsLpsVApQkJPwHVuHS54dSb4cr/Lm1fNWcLZX1dKxJS1X8PYycCyL+4+v+J4tpvrAgaVdcAMdBCSU5xvInKqitagCfmPWfYjkejuYN9+yCDMEKqPFxERJsCWS1cMTBy3iiR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMKqos9za6fueZ7z6gbLrXUFdz5yQyYgzEIpyb0y95s=;
 b=CdQ/1rpx2FpjSqfw29k1mo+buAf/OI8azJaDp2GUIxP0l7xzBCdcXlNUvvtd8mrM7y6h4UNVsffxnlMcKFb11kAIYjc3uBdCw1tGDt2xHp5IQ47kpQvxGfzPRCH8ngZuuspT7CgfB+XGBAGITIBxKqngw85WiYRMt3WRhpP4O1m2rVEqqiLZ2bAck3DYsyUd32yw7tVlkGI1VFrRNKgmP+PlAAb7oVw+/Qx0f9ylWWHhX4yXsH1WpEV6kBA7O/YfrVS+GnZfXKBwGKeRF78FsJaJxLqy3AnGiPUFV1ugWSn0NmSD/83t7eXZIFcM1KZ04ZIBEErUPgDPs6StVnlyzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:35:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:35:18 +0000
Message-ID: <8f53d2bf-3ace-43d4-83ed-77059c875183@nvidia.com>
Date: Mon, 18 Aug 2025 09:35:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: update IPv6 5-tuple matching limitation
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20250807091746.155668-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250807091746.155668-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: fa589b3e-3d83-49ec-52f0-08ddde2165b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXNraUVtTHIxRWY2SENkaWVmWE1TNjIxQ3VLNG5iMDN5OGJDaFVOeVV2RGN5?=
 =?utf-8?B?b0ZUTmJacS91Rkt6NmlzdXpyaUlreG5MZ1RVVlBKNlA4OUx0R05QaU1iV2t5?=
 =?utf-8?B?WEtpdnhHcTBPejZaQ2l3OHRzdHJOS3ozLytiMjNoU3pUcHhkcDJsRjhRT0Uy?=
 =?utf-8?B?THByWHpvUmpwdWk0RXJkOHkrOXZVRmJQb3VHU3hYb3VEVlhQajJHampKbW50?=
 =?utf-8?B?L2JieUpXQVBBRHE5bjV3U09NSDRET3dWYW5wMUMyTGkrYTdMZTBJUVBFM052?=
 =?utf-8?B?MU9nTGo3bG1RYUdiMFArVUZHelFUak41SFRid0tkWnBzSzNjamZ3aDBIck1Y?=
 =?utf-8?B?MzBQT0d0SHJxclgrMU9ETjY4M294NHRFVG5qZDkzUEdDQzNJYVVWdHhpRFFx?=
 =?utf-8?B?aTBQSGFnRVVxbktwV01FeW1KSHI0RmdVZDBpbnZQbGdOQm0rMnUxYXpKbXI0?=
 =?utf-8?B?QlZDemxKNG1JV21COEdCR3BQNVdJTm8rRldIYmhZQTE4RHcvNXdaYjlkQmh5?=
 =?utf-8?B?NlVGT1UrN1FNK0phOEpzWGdWYnRid2lCY1E0MzZOUnk4VUNiblE1cHpKVERk?=
 =?utf-8?B?bnJFMDhFc2xLQ3gzT3R3aFdsTEZ0eTJabzhSWUJuN3dPdVVhMnlXc3YxWlVT?=
 =?utf-8?B?TG9iNDF2RGZMUlBDOWhiUjNMNXFVQjVQTmFWKzdXUnpUTnpDRzRQM0hZdG9l?=
 =?utf-8?B?YUtpeXNpVEdxc20xRUg2Yk1Tc0NKYUN2ZWZqMTMwREwwZlBjRmNoajNoRTVT?=
 =?utf-8?B?NHoxYWJqcS9xSkdnbk0rc09EczRndjVWVlBSRXhzcForNHViTTlFWXpwZ1Jt?=
 =?utf-8?B?T3lUS3RodHNTZ1d6WXF3U056R2pGd0l2RmR5UW12V2FhS3NmbzJ4YkdIUDl3?=
 =?utf-8?B?NjVYY2o0aHpEVXg4U01aenJoQng3Q3V5cUdpbXVWajBteUJVaGhQOUxNNm4v?=
 =?utf-8?B?aWhVa2lvSzh3L3dsUnZ5ZHZUbUlwVWRlRWFaVkszaWZ6c1A1R3BVN3dyQzBK?=
 =?utf-8?B?SDQwT3NzTFJTaE5wZmR5R1VIUHByK1VUQjFzRHRCR1JaZGF1dS9OdytvQXN3?=
 =?utf-8?B?VjQ2UG9zUTg4MVFoeExvOG1VZHc5T3RqaWUyR0VGUk9VYWlCVzFLbHFXSzN1?=
 =?utf-8?B?Z1A0UVEzcEd6VkpSTjMyTVNqKy90UCt3MVFBOGpPVUNqdHFnTXRYNkRPWnA4?=
 =?utf-8?B?dk9mSUVvWUFJMS8wS3dhVjMwWS9IYkszYmxJVlV5NWMyL1UvOEZhUC9EcVUz?=
 =?utf-8?B?MXZzM2ljNTI2RnV6empZWnJOU2FHMFdWeUk2SXQ4VGlqa1RlNDlPVVpQekRZ?=
 =?utf-8?B?czhvbm0zMXp3SVpUdStKZklGL3YyNXJqWUJYTnExZzNmZm9wK21nTVpHNFFa?=
 =?utf-8?B?Q1JMSVBYOGxpZ0pZRDJqRlRXa1p4L0t2aHFGV01JdFBWYUw3bDhMUGNaTi9U?=
 =?utf-8?B?b2xVVVdLOEc0K09WaUF3Y3NqNHo5cHBrOHFaMC83WVJ5SDhCdDZFcmlWcmo2?=
 =?utf-8?B?WkpaTnQ5NXduanZnNWI3aHdYRjBhVVZsSkdFZjRxSGpIUFBremNGQmNwN01F?=
 =?utf-8?B?cGlQeVd3WjlIUVdsTWU2Rm1QdmhObDA5WFJ0TFc0Um9uQmx1ZlBGQ3JWdE1t?=
 =?utf-8?B?d1N5c29YVFVDVFlta0ozcUhxMDgzc1d5NUNtS0lqOUVKS3lwZUVacUhheUVZ?=
 =?utf-8?B?TXpla1o4R3RhNXZoelFZbk81ekp2eVU4UVhtMG5pbXhTVTlRKzB4OFQrTGpG?=
 =?utf-8?B?Mml0aGlCQ0poUjZyQmJySGhreERMRm5XU2wxS1RvYzZEMnZFNGtSRUFpcUsw?=
 =?utf-8?B?WFVNclRqTUlBRWJHa1d4TVJvSDF3ZS9nOHMvZWxWd1UwejRabnEzOXlJVjFT?=
 =?utf-8?B?UmEvZlcvQ05hUWllL2ZXN2E5RjFpZlhKV28vNFgzaWFWSEpXL3ZMSDVIaGlG?=
 =?utf-8?Q?unI36SyrUzk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndBM29xemNnVVVoU0l5ZCtCZGN2MEp0TG5MMG5zNWEweFNndURTQkpXWE9Z?=
 =?utf-8?B?cC96ZE1vU1hFQUlJNWFPaFptb1E3RjhIc2FLc0Rib2xXcXRjUmVzVHFtMVpr?=
 =?utf-8?B?dHN5RmhFek00OGhTQjRPdWVMdGlNcXdXSkE0WnEyaXdablBBWS9vOGFXcGZE?=
 =?utf-8?B?NWR1S1loUnVDSFZ1U1BTaHVZd0U4Wk9kQ2Y1U1BBdFdqQzVOYlNxN2ZaenhU?=
 =?utf-8?B?MktsN2NKZHNIV1g2cmRjd1owSWJPVkRxWTdMZGZnempLQ2t1Um5UeWpFSCtx?=
 =?utf-8?B?bFhLWTFackVXWE5nSUhZYlg0YkF3bTRSMERvMElzcERyelNRbDZUVDM5bFZp?=
 =?utf-8?B?ZllvWU9yVVZvNFpSTVQwUjhBdzZtVTFwWUE2UldzUlRTMG1BRWxtOTBNck4z?=
 =?utf-8?B?b3VlM1BSL056L0pRUUhkZ09UZE14ZVRrQnZBS2R4dG1qUWxzRlcwbDhUTjJQ?=
 =?utf-8?B?d2RrZXpOL1lTSUoyZzEzdEIycGU3YnRCWFFSZ0xqQmdTZEhMWURXM0hxYmp4?=
 =?utf-8?B?QnJLelNoWm1LZFNvV2NRYTQ5ZThabHdqK1lFUEZmT3E2bHZ5R1liSmM4b05k?=
 =?utf-8?B?a3loT2pJTDNNb1M3Mnlxb09sVHlkbE9jUWxlWjk4ay9Wb2QrVy9VY3lJaWpw?=
 =?utf-8?B?UWRnbm9kVW9CQ2llRXloQUk4RTQrdzNBeWVrQWZXR2VBay9EVkV0V2dhZzNj?=
 =?utf-8?B?YlgrR0E5cmJEZUtWTkUwR09hejZNQkNIbDlUT0Q4a3VZUmIxVWhHK1NKT255?=
 =?utf-8?B?Zkk3M1hWNkx1cmdOUU5NR3Q1U2hnUHQxMEdwOTUzdDZIaHQ4Ly84ZkpMUFda?=
 =?utf-8?B?VDNVaXZleFpGMkQ2K2MxWXlneEVQSVF3dVRSQlYxSkR1b1BiSWV6eWR4WVFo?=
 =?utf-8?B?TEhOSUlhSjM0cmZ4bmV4dVpHKzAxZFdRQVNsMHZSMlZMNTNFL3ZwZDBhS1JO?=
 =?utf-8?B?aTVxTlFuMTJqUVVTU1VJLy9uT0M5M3pKQVdDSk9BYWNZS2dXK3U0dWxzSjlI?=
 =?utf-8?B?ZVJQYWx1eFNGMTVETHlEcmhHMEVsS1kxenk2M0pUYTlWc2xLQWRzU0RjWE1x?=
 =?utf-8?B?VnFGeGtkQU41ZDRCdzRVMGtFbHhwMzFLWjEwc0VKVERnNUVsY0tISzlGeHg4?=
 =?utf-8?B?WTJwbGRXL2l3QWE4TmR4VFI1Q215N3A2QVR5SVBMK0Y0QXQ2eDdCRkY4eVBi?=
 =?utf-8?B?VTlaZngyby9JbzBIREUxTER1cURSNGNFQ00yQStTQWcyT3NiaXRVVm45M21l?=
 =?utf-8?B?MWZOQThGWGJ1d0k0UzhoZE5RYmRqSW1zMGRNQjBQRWdRRktHZ3lwR1hqODFs?=
 =?utf-8?B?V0FUZEFwRTh2SDhYVFEwZTMxa3F4bkNDbU1EaWd4QVRJOUZTbUE4NlJtQlZO?=
 =?utf-8?B?N0lPc3RGQ2xITm95c3A4c2IxWUhyQ2src1NoRnVsNnhHbVgzOFVmTWlZNjBq?=
 =?utf-8?B?UmVYMnFFZ1VkajN6NEQ1NjY3a0x5UkgzRHI1ald2WTlZQ0lKUzRWNElOcm16?=
 =?utf-8?B?R1AyaGMxTFRVWERoelF5VWRNKytRMDFQRnN6UnZBbCtGdTZNQlJEN01nV0t0?=
 =?utf-8?B?TklNZDJYdU54eHVZVmI5S0tjeWYrQXpaZ3pPMXlEUE1Yd0RyMGhHWmtTSTlz?=
 =?utf-8?B?ekNobG4xWTgyQjdXRk1wNXJGVmhZYVAzeWdRaVJRd1FyZ05UNTJRVWkwVjZ0?=
 =?utf-8?B?dTczaXhKM1pjWDBTQVpVcjF6djQvMm9XRUFHaDBBeWdEVFFmeHJhRStpdi9p?=
 =?utf-8?B?Q21BZXg5ZTk0ZENWWEtSckVGWEI4eDZLOG85N2lTbWJqZGYydEVxUjZtc1Q0?=
 =?utf-8?B?Qmg4REFVQTlsOVVXeERXNTg2d1QySVhvS2ZiZm1qSXlmbXRPUmdPSW41WjB5?=
 =?utf-8?B?UFlsZVBKa1NwbUY4b0hnVmpKbmY5N1F3bSszQ0pkbW02czBENndFSWtNdFdV?=
 =?utf-8?B?R1AwdjdFc2Jwcno0SnB0UWROblMySU8vL2VuV0RkYUdZUGlhL3JDVSs1Qkw1?=
 =?utf-8?B?d1R3Z3hDMDBLT3BFTFp2ZDgrK3JDd1F3aldpUk5mRWExeW54SkRSZnhGaWlt?=
 =?utf-8?B?dHVzK2FKZ2JCR0lXQWtjV1Jyd0libGJJUkVsN0V3OUVwckdzNVNxMlhTcVUy?=
 =?utf-8?Q?/ahtrC+X15WrWm7/pbjNGB1FL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa589b3e-3d83-49ec-52f0-08ddde2165b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:35:18.0926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWqJPlP6mkjs2LeIMrG9UBwDByos8UvHp8BElAtcGAzjyrrTl6x5+Hlaea/w8rJiO4IilqjGmEfwk3rBUPU5iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 07/08/2025 12:17 PM, Maayan Kashani wrote:
> Update IPv6 5-tuple matching limitation,
> in newer HW, IPv6 5-tuple matching is
> supported.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

