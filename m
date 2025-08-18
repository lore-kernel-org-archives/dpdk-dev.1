Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF3CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E43D4026A;
	Mon, 18 Aug 2025 08:34:51 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by mails.dpdk.org (Postfix) with ESMTP id 303DA4064A;
 Mon, 18 Aug 2025 08:34:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd4/36Sz0n1QR2TxdQeiqfUV154DAXpWlPxQcnMZCnu0J6mSujAUsI1R9Rcq0KhwUOoaLBajwh20lFldLPnsjgqPbNBOJPePUCjUvpwP3l+qM6q2XX5yK3doCXH1/9X+Dm/n7onDS9UJXJGswtum7Bwr425QbiOimeKg5EAfX2uvH47Bi1rbNB2Lm9pv2cl66g1u7DddjLcHRhZxw83goW+uRiyM7r6KawrxU5xs1JjmYfPASqogzmyMuDVLaVF6B40t79BfKdRIQsp8B7NQ6bLaf8s0PsvlOymX/6+AYeZQSIUzrWcpsg//zfNsVUOTziUjNbOUYklBqgwLoinizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4d/4EGeB/jEGyh3hBqvFzunwOL2KEzpEQjSGgKhaLI=;
 b=vYe/mer7TNN+RwIBnvjUh6X/1iiHUsWTTbJUmlwfv2ZAmz7PGesx+0je49+e8a6ccY4lQYCKoFfX27GeEZJ/CWTVy2DS5ef6RGRk7J9mbNrdsahNmzNJlaVsHUdcMP9evArA7bUFf7qvVohNzgC8Y11wfQKgVLiTzBt8gyQRgtQzDXUYSMfhlL8b+v8iOuViVupr6h1MaiPuRKoP+4Ty2wDclTbm2egt2WDK3HPTlL9ZLw6JtLTgPHPfhDK30Uv9ilrokZnJiyZ9Cp8ny7gQrcyPFIaoewP59tLbt7QkIFBWFtsPMDcwjgGFm1rOzN1WbOKs6sr3dFTYmpVY2okWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4d/4EGeB/jEGyh3hBqvFzunwOL2KEzpEQjSGgKhaLI=;
 b=GObuTzhqxA65cmmGoxNmFIh70csOHoIEpVW4nwA7zCeBQzPh8T6qgaX73IZKmJXGyt/XtrUPNd100h9Bvyg/odoBOd5YVNMNqMqJI4Yupm63zSJwGv3pduP3eg4srKb5imxkF0qKf1s1KmMroLUDNOmr54WDfYwAQb11eI9eSyNdPWIKWe+pY2b4zwE1bXtVIpaDzs60kB1gN3/3zL37cvzS5Ou14swZfk3OhJAozvAoO4+U48kMyWtfzi08x6g8UGj5gEZnCiPVEqEM/8LZOjBw16W/JVM/D6EtezvXCHYQHAd1CG6ZPOneM1UASlgZuIF2GrixE8GLxWGNSvaVSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:34:47 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:34:47 +0000
Message-ID: <99a848a6-218b-4ab6-b729-1c923bed75d6@nvidia.com>
Date: Mon, 18 Aug 2025 09:34:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix unsupported port ID action
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250807091247.155266-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250807091247.155266-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2ae5d5-e3cc-43a0-4c9b-08ddde215389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnhndGd6WU41K1NQMFBPODF2YytiMDRHamhHamJ2Yk1YRDM0Y2FDUDRNTlJ0?=
 =?utf-8?B?ZGp4WDZLSGFjbHFtM0orWVNYQks2RHk2Y05RNnAxOW40anpmRnZSN3dMMlQ5?=
 =?utf-8?B?ZlJ4TndZVFdQOVFjcCtNS2Rid01DcDE2T21LdnRSd1dLL0NGaWIwUXcxYm0z?=
 =?utf-8?B?YXk0NVU1REswNjJmL2haUnIzeWoxRVU0N3czY0JwZ2pPdFBlL0UrODdURXBJ?=
 =?utf-8?B?VzZ0Z1ZFb1VyRjd5NHBBaWQ3RWxUVlhVdGU4QmVyaW9zRTVjeVdzbmVsVjVV?=
 =?utf-8?B?azZRejdYNHYveHJKbE4zNUd1UlVRWUorZG53b1NEUmhYU2IxdEliUnYyUEFG?=
 =?utf-8?B?WTZFa2R5b0huNGpNc1BEVHBXbVFlL1NqKzJiQ2c5dmlFNVFxZ0dDWWphcTda?=
 =?utf-8?B?dzlzS0tMV2ZzOWdZS015Q3hRMWJmTDF6WUNCOThkRlNoUjlnbWVSVUtham15?=
 =?utf-8?B?UjVMcHZIKzVJUGg1WFhuSjlPMW5CTVg2b3VGZHZVSkkxcmZaaXlMVmxBaTlr?=
 =?utf-8?B?TmJsYzhIdnQwUGl5YlpHdVdDM1ZBSDBqNGVUOXVpR29BdUxqOWc0TUhsMnpX?=
 =?utf-8?B?NUZhWWVTWllJVXBkdUNyZFB6SDdoaWV1NG5aVGpkdkpaZVRhbHYrTlZJd0pB?=
 =?utf-8?B?cnFDcitzTlBDckttTWQydWhuUEFBcVliZkVlTm1hVnc2dHhOendDS0kvRXRG?=
 =?utf-8?B?MDVTcjdVNlNPbzZvcFpqV0F3OUU5d1RLQkF3UGdKbFZQL0JidDZUeG1pSGN6?=
 =?utf-8?B?bHBZbVpxeUtORW5MNjJFcXFIaDZqbnFTZzNTS2xvVFdiV1dUbEE4bnhWYVNi?=
 =?utf-8?B?a3ZHam9xUDFqeXRIdXlRdTR5cUNaQWYrVkFtUnNDUEJoTjQ4WHJma09VVzdl?=
 =?utf-8?B?a2dHV0NKc3pqMnZqZXMxdGFkTnI0NEd6MVEvdERoZ3N0elhTUmovcmsrazd2?=
 =?utf-8?B?M3NrakhvTFdHVlBQS2RNQlR1VTQ3elZiQ09QREpSNytERVltbHBTSHNRQm1C?=
 =?utf-8?B?M0dDY3VyQzkyVkFnVlNHUWhBSUltM3JlQ1IzM3h1S25OaFpGT1d1Q2dhTFY5?=
 =?utf-8?B?dElmTEk5TTU4c2NvNGJhbUk4aHBHTk9PdFVxT2oveGFneTdnWFdGSCtLNllm?=
 =?utf-8?B?SFNOSitEMytiZ3hZTGlHbXExa2xPK2NzbGcxYmZrKzN4bVJaNDhiTmZRdEw5?=
 =?utf-8?B?aEE2T1Z5a1ZjN0dmSmZNaGdJN1A1OUdJbkt3Uk5nTTJ3NTVDRmR3V0kxaDU5?=
 =?utf-8?B?WnhkRGdOMk0wR2l0MDBwbngzWE1jajJSSHFScHlwRmIvM01NcEU5MG45VW0v?=
 =?utf-8?B?eDNUUDVPNXVieXRRa2ZsT3BFcjlvM2wrRWRGYzd1TzdhTCtHTVhsaFA5anc4?=
 =?utf-8?B?SHduTmdoNUZiWlV3UDNsRmh4azM0WlZGZUQ1emtqNTFIUXlDTk01WllMODdN?=
 =?utf-8?B?a2Q4cmhmKzgyc0Z4eEd5UUd6QTR4aWV1aXFHbFZ6b0hJUVdPS3R4b0VLMWU3?=
 =?utf-8?B?bklERzBNVitLOWRaY3gvbGFKRDFZSWoxeTRFOXBrdDl0VFE4SWdOUC9WUFYy?=
 =?utf-8?B?cTBZV0lNVmExVmxnMjlDUUpibmdNKzkwZHlpUi9XOW95SDlZb1RzWVFxbURD?=
 =?utf-8?B?N0ZiVkw2ZEVoY2s3SCtSK3pNQ0JBK1hRWnl0eldVNjUyd0VjeXpocjVQZ3Fh?=
 =?utf-8?B?VURhQnllZmUvbVJTWEtFN2EyWWFsZk5mdjA4K3FTTHgwa2ZYSmViTGVZdGFD?=
 =?utf-8?B?ZmlLblFQei9kemsvNGpTZytqZTUrU0ViR3Q4VlFrVGxnaVI3NE4yZTdCSm1r?=
 =?utf-8?B?TGNYNmZ0UmtzZUJmTDBLdm9oVDdVNmJFVUhMaXVlZ0N1am0xeGhBUUFPUWV2?=
 =?utf-8?B?a05kdTliZDhZSzFIaXpRcWlrOGp5NGdsWXVWb0tFMUZxRE03RFJqd09sazFp?=
 =?utf-8?Q?1/OEC+uEuaQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjhGcTVTR3p5cmhiOG9CTVBsOHFFNmt2d3NjWmo3d0tHZDNDbkZzSFVFVVhz?=
 =?utf-8?B?dGZ0SWFxY2FEY1JYcjRLdE1tWC9sazRHL2lOaTFkQnBvM0VtTEoxV0ZFVmFq?=
 =?utf-8?B?NllpbWFtcXJwOU5WZUUrWXZVRGZoYmtnNWd2ZjBWTUtyRHp2YXJzTFFwRC9l?=
 =?utf-8?B?YWlwQkNMWjM1WkNpbnAvcUUyR09kaXl1M093ekx5Yi95WXJaMTRUVWJvSFhM?=
 =?utf-8?B?QjNqWWcrMmFxT0UzSlBJQzN4KzBob0NTV2Nva0lSSWVmall4bjhRV1lYUjla?=
 =?utf-8?B?Q1h0YnFqTnYzYStZTkRvc09meUFmOC9SYXBJbVVmNTUyZjV2YlpYZjlKK2sy?=
 =?utf-8?B?ZWgyenN4cHZtTStSSzBPUFl5VXdzSmNtS1ErU1Q2aFhoQlZjVVorUWFRV1VK?=
 =?utf-8?B?VndsS1BCdDlEWUU2MUtsY2RPekxqOXFEb0prT1VrK04vajBJQzdRZXJ0V3pP?=
 =?utf-8?B?WTcyTVZYRVQxOE1GWlVDbmhMY0o2ZGNqc0JHZ21mQTIxVkJvemtpd2tCa3J1?=
 =?utf-8?B?NXhLYmdUQVZDK0trRWw1b29XWkxMME5wMjlwVk0zY290Rzhja0Y4QThOaGU0?=
 =?utf-8?B?V2lNTlF4ZWN2RUJuK2dnbldYblZNM3MrS1BTaGM1NVd3K3lTQzJmNzdxUE9S?=
 =?utf-8?B?Z2pxSWtSNHRPWC9RVG4vYk0wYzBTb0dZbEtJcEQ0enBlTUNkQnpBWXAxNGx3?=
 =?utf-8?B?UFVXRlpHSUtKR2tvQklSdDZiOVYrMGxvTXBaY1l0cXZsZjZoSTZOTTBzMzBx?=
 =?utf-8?B?OFBXMnZmWEtKS1Y4RWxFeCtidkdITC9EeWttSkJheE5vV1piL3h5Vk9veXFG?=
 =?utf-8?B?Und4TGJCcXJWeWsrMkVnV2lnN3pwWEdBSVFYYThwNkpTZjhRbHBJYVdEVEpM?=
 =?utf-8?B?UjB4a3JYRkxQb0hoTS8rZ0YyclJFdmJpRFJub0c5Vll1N3A3U1lZeHZTYWRr?=
 =?utf-8?B?MDlGVWUxWEw0TzI3R2FoRnRKaUdBcnh6ejMrbFVyUUZJZTRVbU9PWTYzSVRH?=
 =?utf-8?B?ckFqYm1GenR1RWk5QmlzYmkwQmJSRzg0ZWNlVkYwTklkamF2c3Z6MHR3NCtk?=
 =?utf-8?B?bGZzeXR3TEZSZHc0R3ZmMkw4UWZOblkxMW1KQlZlbDdpdEJGZG1TdC9wNGRH?=
 =?utf-8?B?MlpGK1RScGRxblVMYWhEakFRbFZmUEhaUG9zNkx0SVJtQzY4NDY5eDFCMkl1?=
 =?utf-8?B?QktWOXRyZHZnV0RWNUxCaGFTeEEzQzNjSjVsNzMyMHFBelBQTmYvNjl5NDZu?=
 =?utf-8?B?NlpCV1VMVWpkSVB6S0pjVmRFSm5oUTQrOGwxQ0RrVWhocVFJSkd1Um56aG1p?=
 =?utf-8?B?YU5RRE1oTFFsUmQ0S29uWVVEdHl4UzU1dGp6RGVBOXAxSmxGZmp2T201Ymhq?=
 =?utf-8?B?bkZIaDR0bStBM3BVOXkxVXp1NndjMkRsaGtTeUs1dVltOHVxcVRSRzBKbm1l?=
 =?utf-8?B?VVVFWHJXTERXRGc5WEJHZC9OaXczMlU5SkkxQU4wMjNOZDRzVFZ5TGZlUmdY?=
 =?utf-8?B?Vi84NTBlRWc2cU4rY2RDeVpjc0xvSEtDQ0tLSUhaNVBQNlZmdVgrNUZlejRr?=
 =?utf-8?B?TnN0anBpU3JldFB6KzBaUmZxS3dodlRQMTBoTUg5RmN2RVIxK002Zlo5aVVt?=
 =?utf-8?B?UUZabmZGV0RUZkN1L01lTFBXcHY3K09jVDc4S09hQlhua2J6OXZMSlZzOGNU?=
 =?utf-8?B?UEF1Y3F3Q016aHBqbjZGZFQ1V1RyL1Z6K2xjZU5sWnN0c2RDUko0YTI0Q1ly?=
 =?utf-8?B?aU1FQ2tDUXNvWDUvRGMvbWVDL3BRT2FqKzJqREpPalFmVE1BWTJPejNMUTBw?=
 =?utf-8?B?dWZhWFFmRlhrT0NES1B0b1lXN0FVdm1OYzlhWVpoMUEzOVZhMk85cVJUWHZR?=
 =?utf-8?B?VGpiR3kvTm5HTjZXQW1FYkFnblhkSXF4YWxHdDZBZzlxMjdXMDkrdnQ0UVZy?=
 =?utf-8?B?ek5sOS9LdEZWZDNOL2xscTUxUHZPOVNIK1dNSkNkZVZOUUgrOGZjMTFQaVM1?=
 =?utf-8?B?UURDSUdDTitZTVBmalp0WStGV3dZallydUJRV0laR05IS2xadU9xdmVwV0cy?=
 =?utf-8?B?RXRtemErZTlsUGEvajRDT2xBQTdCY3psckhDT3lnaTJrU1I2Vlp5blRqRGJr?=
 =?utf-8?Q?fEgQ1dQUsKP0N22d/BnRnbbTP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2ae5d5-e3cc-43a0-4c9b-08ddde215389
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:34:47.6012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JYMZ9fAb3JxiL3o6EMVkmj7e6QUWl6cuxDy8vtjiFMebrQ87iM9loneAsZecV5XISp/4UwQOtau988eqPNQNw==
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


On 07/08/2025 12:12 PM, Maayan Kashani wrote:
> When dv_flow_en=2, the port ID action is not supported.
> Although a rule can be created successfully in non-template mode,
> the specified action will be silently ignored and not applied.
> 
> To prevent this ambiguous behavior, explicitly return an error
> when a port ID action is used with dv_flow_en=2,
> and recommend using a represented port action instead.
> 
> Fixes: f1fecffa88df ("net/mlx5: support Direct Rules action template API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

