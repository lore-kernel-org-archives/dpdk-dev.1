Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7971ACA101F
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 06:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 466E540277;
	Mon, 15 Sep 2025 08:37:15 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by mails.dpdk.org (Postfix) with ESMTP id E9D4140262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:37:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc9RP0JT47G44myeLKc9N73Lx6BSaa2SXTU/NJlFhUw6L4Go4wm5U4FCZa5hGv6iM/XT0hEApM3+ai7Bz17PSTk263AljcFrVGHSUC4xWNxWlcaHFIT/B6KSFoTM/+10TrJ1plmtGS18q5djBJKOHCPX7QqQmasBTG5FqbvtBU2ZUqAgvrbNdxXwev0wMZTgAbQG+UA0qBaG89pY682RALAklTkORoxuueQKE8gLJ3gDshCKK431Dsx1ErmEMzuEX1tS5h0iuyFGrx+lq4bLMCWVvs1gYPFshjY1EeGgHtFlTsCFCjvOPWIUOjTnRlibxUeLJ+TTdujEsY4E4usKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFOsZ894qtERKrVTpHnR+bcoXYknT2ztvKbth9kk9qA=;
 b=BAGsvnQkeo56neIH/Myw0AYEmbfsG/z1hkULK9bYkk4h2F9Cy0a8eCIWytkLWFN/k4Z6lkI3/mDLFck1zuHVPNWIKa7/VvuWGgrDbrxAu+cYpup6P2bhPdOqEguZ6V7vhRSgVAaCpkw1iRKdtfQ5VmrmIOviGtxj2NXg2A8VetGVNaf9DlwI33AzhXTM0aK74Gfjs6+/U8y/Ruwm/4+dDeApf0+hi8bjU5mGvgzLZNUkB32oaX3R2jqDfLtgBUfsJMHYN/8aLj1e3J3i8OyNbQrnAylqHRsoEnF83n2b/8E+c72pvXHJMaC80SMLk18Bb5KXX0S6efzC422gHw69ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFOsZ894qtERKrVTpHnR+bcoXYknT2ztvKbth9kk9qA=;
 b=i8jG4klIeD8vKOee5mUH9fYVjRYpScFG/UjFbjt8HLYhB26FetGiofq1fsSPDFCPprbnd1q4WCopqCsCDlnnxjOVFjEoZTQ/aW3hAtkx6TsdPzLLuThuzsUTUUOuWgL0vp8vJRSjcupDDdln2m7LvhzAhFXJbByRlioDEhiFVbv1w+cJSlNBd5osLQ7VfWcZEKDdgG0xixPT+CmhCYGL3QJcI33h2lZ9ZvZqprD0ObzIzOJbWo4KQpXQ3fkYPL9hgUVgh+CKF6//yZ9Y7/EzWIav0O2ADmQCMfreMF2mLUzq5vSB/5k0uPERbBfVwO9sEDbPJsXyVrc8pFgWO64Xvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 06:37:10 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 06:37:10 +0000
Message-ID: <7ce71887-a918-4fbb-8617-92a94dbe5324@nvidia.com>
Date: Mon, 15 Sep 2025 09:37:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/2] resolve flow creation issue for multicast MAC
 addresses
To: Gavin Li <gavinl@nvidia.com>, matan@nvidia.com, viacheslavo@nvidia.com,
 orika@nvidia.com, thomas@monjalon.net
Cc: dev@dpdk.org
References: <20250825141322.974335-3-gavinl@nvidia.com>
 <20250829090830.1049176-1-gavinl@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250829090830.1049176-1-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ffd8da-b0e1-4f2e-3e2c-08ddf4224c3d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elNtVFhTSzAyVGNQMnpMMEVaSjV5OHF1enl3M2lBRXJVaUxrYUtvejRqMEFG?=
 =?utf-8?B?WERsTlo0bVdZdzJhQlZ5SDNSRDBabjJEcVhkSm5rQ2VTekZQRlJOTU5QeDd4?=
 =?utf-8?B?cmhrdStqcnhGR2YrWE5HWm0zK0N1N1NNd3F4QUcxN1VJSGdpSFhhZTAxL1ds?=
 =?utf-8?B?VnpuVHMxeVpOeHNYTkxxOHRqeDVWY3FoVWROOHpwaGtMOHlGNHNxZ2hzSi9r?=
 =?utf-8?B?NEpTb2hseW5LektWZmlRMEF6TWF1TGNnUGUya2NVeGZ5VkhLdUFreFVwSUhE?=
 =?utf-8?B?aVltRy9GZ1NGa25GSUt0Q2UvV2FxSGNjSzI3S0NvaVRJeWEzS3ROYlNKUEhR?=
 =?utf-8?B?dDdNS2NRdmRBUDVEaEZCV0swK1NicytPaGVtclNQdnI0ZTFPc2pIbFhYcjdD?=
 =?utf-8?B?R3VKMXVkYklacUllTTV0MDFVK1FHSlhlZjRkZzBnZTI0SDRUQ0ZtR25oZE9S?=
 =?utf-8?B?b01FNzlGMUVIeUthdDAxTVd0eUYyeThzRXl0Tk5YV09oeE5EQ1BhTE8xTHla?=
 =?utf-8?B?M1dWYVhiNzVMclg3QmQyQUtmVmxvd3lBM0NGTUQrMlk3eUkyQVZxc1oxb1dy?=
 =?utf-8?B?aTFTTWt3cnhvSmlqdVU2aElrS3JIMzVzbDNGYVVKRktNNVg2ZzBDeFpiSENJ?=
 =?utf-8?B?ZDZXNTJlT1NEbjBsMEhzSVczcXNQd09qdUtuTGQ0STdERWtJNlcxV3B1NG40?=
 =?utf-8?B?MzZiVUhvekJldFk0U3Q2dHRFbzdhc1FhS0paWjMwaWIyWDM3SGdnZ01GYWpT?=
 =?utf-8?B?QkZpbEpFZCt3M2ZZTFVjRy9JMk5TaFF6NXNpY2gwWVpxeC85TkJoenlBdTZK?=
 =?utf-8?B?VVNoUkpqMHFuZ2p6UC8xSTcxL3FiY2ltaE1RTXhxYThKRXpabkRKUHJwTEE5?=
 =?utf-8?B?TnRLcFNCTTE1N0Z0TVM3TXRLcXFGZUlnOEVjcnZpOU1vcis0L1B5NWhUVWhT?=
 =?utf-8?B?ZFdFNGdUYUVKV2JjLzY5QUVWdUd4NDAzeWNVU01FK0hHRFRsWkpFNDZxMHhp?=
 =?utf-8?B?R29pQ01FdWx2djBzR1pRSHV6T2k5QmMzeGlRdmtTbzJZL3N2R1pDMjhPNk8z?=
 =?utf-8?B?bHFqU001a05Heml4a2oyZnQ0YzUwWmRwUjE5WjBCQUlUNTdkMU5XNnd4WVpD?=
 =?utf-8?B?THF2UkttVVJWTTBUNkxEZytHRmlTS2tHblZKTmVwWUg1Sk9WbjF4Q0FJS1c1?=
 =?utf-8?B?Tk1SdUVyRXdhOXFYbDdQL0s4RURoRFRVYldic1E3akZzdDNkZ0M4YmxETVFT?=
 =?utf-8?B?SFViL2hBR3BoUFU1TUhpcDBMMWV2cG1UVW5Uc1c2dVZsejdjOTIzRUQxdzdQ?=
 =?utf-8?B?WWFrbm11dlJlSmRGTCtTZy9WOVl5S3ppQUZhMWgvRFd6WTlPRWIycm5VOWFH?=
 =?utf-8?B?Q3VVTkxWU05pMHZ6SzVGWk0zdk5UMnNBZGhzLzJBdFk4SnhVcHROTkVFeGRI?=
 =?utf-8?B?VG9aeit3UjVQVUhoZURNYTIzVVFZSDU2SStBb1V3ODRWcEV4NDM1b1pxaGVL?=
 =?utf-8?B?cTdPN29mYzJya1R2N050Y1FzVUFOeVM3VmRnN2RQd2FUK004bEM3TGZaaHA0?=
 =?utf-8?B?Zi8rbXhJWkxwL3hxL3duaTMvMWI2ZWhSOG1SbkllcHN6ci9PbXMyVUtUVThN?=
 =?utf-8?B?dnZpWEg0T0kvbWpWY0xFK1VqZitzd0pRNDR5aE1DK0ZvdlpCMmtLM0xTWjA1?=
 =?utf-8?B?RU1Mby9UanVzLzU1Yll2L0JsaklXeFJ1U2IxbHdyNllTVkRMNFloTW5PS0ZW?=
 =?utf-8?B?d0xUSHRkb1VXM05veWgranVGL3lkNEdlZkVCUHg4cVZKVFRXcExxTytWU081?=
 =?utf-8?B?S0Y3SlEyM3JNUm5uNkM2Z1RHRVJ3M2hQQmJqVjV1OXh5T2l5RWRaakNQdkxV?=
 =?utf-8?B?aHJSdkhCbHF4VExmUXBPck0zbUcwYmxzRENkL28yZTl0RWFpVytXWit0bEwr?=
 =?utf-8?Q?yS1orjRieKw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aisyQkVBMjUyK0dLcUVmRkhpaTRjUjJkdXJYNnRseE5mN21JNU96L0dsUjZj?=
 =?utf-8?B?N09pMDdVKzVYREVuTTNRaXU4YzdxS0ZHK3R3a2FQOWY5SU5SSUNETHZGNHpj?=
 =?utf-8?B?VXIyWUpmam9tNGRuOGZxM25BUEVIVy9lTkRjajZxTE5NRElaRlk3enpOUnNM?=
 =?utf-8?B?RE9vR1FSOGZZYXhVcEVoSCtYaFZaYVRIemM3VjEwaVRMTTBENUpDdU5hUDc5?=
 =?utf-8?B?aUcvcWJQMTd6YkFFSjVDbzI3YkpDUERmWGJGU0lKVTFiZFh0WG1XTmZ1VzRF?=
 =?utf-8?B?dzZlaFlCZTdzSFV0VGpDNzM1TFVBUk9ybDFQcmhPVUVrWFRoOW1Zc1JqUzdJ?=
 =?utf-8?B?MHM5c1kzamFRU0doRkVQNGtKWi9DYUYreUEvc3lQTkFaOHhub1Z0djRNZmhW?=
 =?utf-8?B?dlRYQk8zSWFFZ0puRmVpSFpXaWhaRDJqREQ4N1FMOFZBZElFb2pEM1B6b2pR?=
 =?utf-8?B?alZmb0xkQ2JOL1ZXdVlaWFRjR2xDREg5cTR6cWRlblRvWG5CT2E0T0NDd2xU?=
 =?utf-8?B?dzIrWWRtUldvM2xRRE1maWU2SlM3YTRHOUQzNjZmUmFOdGVqNkk5bG9wdmI4?=
 =?utf-8?B?Z2Rlb0R3VzUvOXN0cnNSa3Uya21hS002bm5VUm9IRDYyaTVnbW9mRjZ2ekhx?=
 =?utf-8?B?YnMyWktiZXU1VmREVUJDZXRYRzFxYStPeXh4aDZ2V0draEZSVEMzYUxLZnVX?=
 =?utf-8?B?RGZJVXhGU0FrbktrQ3cvNzBrRkQ3STFxRXcrSmdrbmR2RHRCQ284MDJoT1Bv?=
 =?utf-8?B?R284VytWeFlKWXpKUXdGOW56RlJyQXRQOC85eDEybDBzTis2K1VXUmoxVUMw?=
 =?utf-8?B?bGFYMkh0clorc0xNU2tQcDRoeXNUdTQzSi9KRVVVYnlxdHJrbEVBdW5EK29Z?=
 =?utf-8?B?YmFIa1dKRzdzOXl4TWtMVVYySVFaR3pIcUIrVzgwaWpqR2ZkcHdKejJFbTdh?=
 =?utf-8?B?R1dTRnMydlJYOUVWMlhkQnJzQThiTlRjaFVXMFJiMVF4d1psSElBVlRibEJt?=
 =?utf-8?B?WFNEZTVhRUI3UkdTZy9McmQyL3ZLYzFSOHBSMzdLcUNobkNobEI3blI1RlNh?=
 =?utf-8?B?aXVMRkN6VlRjb3MrL0tLUC93RFA5R0c4L3NSV1ZuZUhVVnYyaDBnRWF1U2NQ?=
 =?utf-8?B?ajFQd1BuUXFpcWxzbmRDbDFVa1RaZEdLcnYrbkkrZWYxUWQvbVJxMlgxdkdG?=
 =?utf-8?B?ZnFUVHBwbEh0MXlqTE9USmhsNTFXdDNyU1d2ZlMvR3RGZHZlWTR1SnlBR0R4?=
 =?utf-8?B?SE9MMXBpK3dQbnBEZ3R4bkR5RTEzak0xTU9VRHVvcUNHMFl5a1prSWhjNGlR?=
 =?utf-8?B?NU90VmwybDAvNmpNdW9peVZzSHFXZFl3ayt3c2dRV01mWkRrMnEyUGh2QUpP?=
 =?utf-8?B?QUtJbzVpa3luN20xMExVSnFGbWcxWDNQYnBwRFc0MFp6amk1SGp0VVVRMVNm?=
 =?utf-8?B?d1lKMjZyby9QempxL2p5bFhMSy82OUh2a0R4bFJxdU5Fdmc0YzhROVV1Z0oz?=
 =?utf-8?B?V2h4amUwa0RBQXlITjdOTjM0elFYY3gzQ1VWazE5UkRGSWdBRm5TdjRiTG1v?=
 =?utf-8?B?RGIwM2xMNXIxelB6bGNpSFRFNU03YVFpOXVHUlhTeFRLZjRiYjBMaGZaaGtV?=
 =?utf-8?B?NW84aEZSQTY3c2duRlZVaUtKTFdCYUhqcDJpZERYd1lwZkVpSkRhLzMzRUZV?=
 =?utf-8?B?ZGRkT3lZYTJiUW1vekNXKzRZSC8yM2R1ZVIveUNLZjRkS25MZUdHVlVtTHVs?=
 =?utf-8?B?bnFSWHFwZ21QUWxWMFRIQ0lNclVGcjBVQzQ2czc3cDR6QVhRUVR1aUNaVjJw?=
 =?utf-8?B?aG5iQytnTVdsU2o5d1o1cFF5MjI0K011NHhWTjZJbE5uRWYxS0VnNS9mTjZs?=
 =?utf-8?B?aTBWQVNXbUpoTkZwaUJPTVgzTGl1SGJUVnJaK2RrcXgyT25tbWZkVWQ1NWg2?=
 =?utf-8?B?K2RTUGZYWnhCODNsem1QZGZnOGp6bmYzZ292TnVzZnYvQ3h3R0MyaHZ0Zmpl?=
 =?utf-8?B?YjVxTTdmejFocE01Q0JDcjVTeUhvc0F0bG03ckZJazloaS82Y00ySnNFZjdI?=
 =?utf-8?B?Z0ZWOXFMQjJDVFM0QmFPZEtKSmE5MXd2OXZEbTFBaXRYd2xMRmZUcTBwbnRY?=
 =?utf-8?Q?iD6ZkZDfhGrtscm2ANctMWyMI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffd8da-b0e1-4f2e-3e2c-08ddf4224c3d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 06:37:10.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxiF7ISkc1l3+R0cFY/BAUWiCdJte3swKXwxna4NvSpM++QNJnuvRZLxR5nu/CjIn+ceMYeJdUF487Sw4AnNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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


On 29/08/2025 12:08 PM, Gavin Li wrote:
> A bug was introduced by commit 2d0665a7f771 ("net/mlx5: align PF and
> VF/SF MAC address handling"). Flows for multicast MAC addresses would
> not be created anymore.
> 
> This patch series are to fix the issue.
> 
> Minggang Li (Gavin) (2):
>    net/mlx5: update how MAC address bit-fields are used
>    net/mlx5: add support for flows targeting multicast MAC addresses
> 
>   drivers/common/mlx5/linux/mlx5_nl.c | 26 ++++++++++++--------------
>   drivers/common/mlx5/linux/mlx5_nl.h |  8 ++++----
>   drivers/net/mlx5/linux/mlx5_os.c    | 12 +++++++++---
>   drivers/net/mlx5/mlx5_trigger.c     |  5 ++++-
>   4 files changed, 29 insertions(+), 22 deletions(-)
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

