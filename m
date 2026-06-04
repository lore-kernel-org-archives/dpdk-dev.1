Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704DCD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F52040270;
	Thu,  4 Jun 2026 11:35:51 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by mails.dpdk.org (Postfix) with ESMTP id 678F340270;
 Thu,  4 Jun 2026 11:35:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQTAQSCSwPQAvbL0ePDYwJcZNUAfER0/2Tye29oAuGC2pUy/JZLP4kqjCPiPjFtibjIacHDBZi8nWKORUSLwQ+QoCF85t2N/6IgC2AMJQuJea3qo2mL2lJDEK6gBD4Tqz4I2ytufKRlQSzUusCraA+EnTe1wsU2rC6melHqvMBvx3TuFScs8Tzj/pcLrxyKOZZrLXsdvzzjsEF5P1Uqo2MmU1twl2aGY6J5MQqsNqQIuINr9ZmHiYDOnM9DDwSpExXOqnVwd+GBts5eQaL1gZjxYL96HN16oH+7il/BRGkL8uaXi1Qr4u1L8pnhjAbjQsM+ydsd5lrMkpkgsyWj7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHylBcpZ1yemHzHoOM/pZByAU/ySheIPqgoXKCqupSE=;
 b=eeX+KuT8Wy2iH9MvyfbTvgFTdwJdmmErJqzTzPAGK+3fERoC6dzp0iocDvSwRnnbnQIBMrFqAk9q228z5bQUDQs88bCpdB8bH86sujnJTmRXuoP0UNox4olZhxzy550TG/sA4izT9FSIFNu2q785TRwE7SUW+y3HTL70Vo7dnMJA7QrMWVWFVm3OWoQNdUpYvZlLrKLM52zhp0jJL6rzs6dS9uCWlMzOycBnExX/taUAiG6V8WqmEuGT/ekU6udWKUOSLKrIP9PFcuZ6SsvTuOofvgwfr2YsAhnqpGsZlVFyBFfsMoRBfqDqNSB/PftxDxnPua7JLdLAEP4EgMjkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHylBcpZ1yemHzHoOM/pZByAU/ySheIPqgoXKCqupSE=;
 b=ku/3NSXmMbi5kHno6RiMtbMmQCjBpzpNLKQwhjP6NFDMoxD5yNkhQpU6bjY3D4ELcf0Jdk1nvAKcsWWeRQIw3pB7KRU5Gr1VhyIMythGxjW3GzbLSkk1MeyUWf+mYuxA5FyLOqkCeOZD6I5iq5NT2tsiBipxteWppgKNYEWDOODhwQJ1LmIDxIDz39UX5pr/umlpGUBHPvX0V+siTp0OHYETV71E6jofDEIBlmChcd2AAGU3hXs6Z5uHiYdoLijzbx2CadWr4kX99UdeYJ3eMrP0Ywazev9fw1s7XQeQIUIiOmLblwgJF/8CSKrJUoJw0TK329GpqYfwZXkzpT7vpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:35:45 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:35:44 +0000
Message-ID: <fa112207-0a36-443d-934c-9c1b70755798@nvidia.com>
Date: Thu, 4 Jun 2026 12:35:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix uninitialized skip count
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Cc: dev@dpdk.org, Kiran Vedere <kiranv@nvidia.com>, stable@dpdk.org
References: <20260515123358.354191-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260515123358.354191-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: e83ef472-3d37-4123-2016-08dec21ca6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: enM9ZKTEDV90XEZdb5jZfCghdzXLfhNz4FDTySKM40qwGwCGhu+jAzsQw/P0YdkFwiramjgAz3nbbpRaIb/3VNI+f5wbJILzVAxUiPsYlRf13y/V3qGJqhpjKLAF6kS/2Hqp6zMNOnF8zJhfAWE4H/uQfbbWCD4JTxKzXL4Os3fMh8+2j6VhKFqWcIhNUpvlD9WIBvbwkJPnS46b6HUgQMAoXrjc7F7aK47svWY9O7vL+uswMWxghXXcSIOf2JNCNV2PMC+V1FtVNtB1NitFq1S+fSqQcxSe2ciQ017ZiKR/FTZNCcgh+J0KDj7SgsrH48hUq8W7vohv1WPEEuHwx95NXDbPOWipkHXm2DPdeKW7YHxZYp0UgfwRkQi5kbUxAzijiuJ0uW80EM9VE0lCAurpKwJmAf/2vTORXRLqmLsV7KEtLW1JNj6jyylOtPZWqd3bOWejRH7dKjRAxRodGb6c2SDFGtsHx5TdhCdzbCOmtf1p6/zo5vqm06Rzod2kXGnpaeZvea+tQwSytu3VXitFwJ7jiSMYEIw56sZytCfNTwDkQN7JKPLZlaPf+vtYyhK+p3i2vStoj5meFgU+2B+r7DotPaO74a86JdSJ1HpeUUOfi4TaZyqkjD9hLHIetmcGjtxmfIZ9ADEUQn5fmHu88Ycyle+IkuGeVBesexFlaJg2WJKN6DHq2y06/4n6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDV1aXBmNDNueTdPbU9Ca1JFcVBna2k1TU5NMGswMlFkV3ZDVjd3YnQyY1M2?=
 =?utf-8?B?c1Q3eDZOTUlDaGtBUFVMVVVHS21XWmtLckxIZHBHeHRDRjFzVEgwZ3U5dUpl?=
 =?utf-8?B?ZGtEc1pUYWJabkN5NFI3b3hVWUNCc0N0K2JFOUQrTjFNVkR4TkhTRUxCK2Z1?=
 =?utf-8?B?QTBIMURTZTVEbFFDL0lXeStiWm13UUY0dFlaQ0R0WDFWRE1BK0E5Z3VuTTJw?=
 =?utf-8?B?WlYvSWxodklxVFhsSlNNaG5iMVVPQkFrNFJnNlI0MkJZTkFHZUtzSDRwZzBW?=
 =?utf-8?B?RWUvYmRIRFpvS0MvYVdaTVNZbVp0Z2lmaUloTUVDSXNRbkN2YWp0MVQ1Q2Nl?=
 =?utf-8?B?MGJETWkzcTJsS3k4ZEd1OGM1eWNCdFZGSnorT2VWVituM3dmZHRLaDlzbi9C?=
 =?utf-8?B?MW5qRWR5SjFKbVlQMmdrc2kwbWxIY2VwZEhjVk1KRE5JZkJ1VjViTmlKUGVi?=
 =?utf-8?B?c1Y5SlBpakFMWHJFZVkzRERXSXp1anJSc1cxK2tPOVlLSjhkSHc2RWZwcHFM?=
 =?utf-8?B?OHZEWEI2ZUt6NmxwN1BuWVRlb1JkVXkwZmxUZlF3eTlQVHBJRHlxTEhIcDVR?=
 =?utf-8?B?emNDbW5SZlRmQW00cWp3UlJvWkVJYlA3T0FWcVE4Z0R6OVlmY01uSTZVdjZw?=
 =?utf-8?B?eUNsV2tnK0J3YXhCWWpJTzBES0VoSlA4ck9Vemh2bm50eUU0T0VvRXg2NzBu?=
 =?utf-8?B?ZDkyVFAxZzMxT0puRHh0VGFVNTJRaC9vK281SGdOcHdOS2pBcWwwdGcyWGlo?=
 =?utf-8?B?TjBaakpueUwzV2RzMHlhLzdXQXpBeEFzeHF6NUdsdzVITk9nNjJmNHB4Y2tn?=
 =?utf-8?B?RW5PL1luTDJKMmRPdGNyTlFkNldWWGlWQnVkbnV1RXd1S1NvMXhDR1F5ejdm?=
 =?utf-8?B?RTE0SnF0WjhabFkxd3ZXNDNkRWorMndZSDB5aG5Oc2J1WWtqV3l3VlVLRUpM?=
 =?utf-8?B?Yk5HczFnZHNrUEpzc3NBclJaYktLSG9DVTlpZUxpOEcwWHNid3FjYU0vZHox?=
 =?utf-8?B?ZENCYmFDb01GQjNmS3FlVVhZbjhweFlJUUpiZ1hnMlltM3NpSkx5cE05cEwz?=
 =?utf-8?B?R3IxcUVZN29vUEdNZXRLQXoxdGp4dHdOam9NR0YwbUpqSTZTYURJTE9uK3lV?=
 =?utf-8?B?QURKRnVoUjFYYVJVTG9RWnhqUU44QVNEYTdzMlg4QWlYWVBmeEV3MWxDckFG?=
 =?utf-8?B?YVVIeG4zVXg1TjlROWZXWHI1VnRYdnRHZGxJaWRsMU1iQ0ZOVVFlNVdQZ0ow?=
 =?utf-8?B?a1ZPM2Rjd0pBVHZsTG1zdk4wdzlJY1lIWFBQM05uWU5XUU5pakRVMFNCS0s5?=
 =?utf-8?B?alZyOUs3MFlab2ZaZjhEbmNRSWNkcXRVTVVGeGtOWFBYWmsxQisyb0RZbG92?=
 =?utf-8?B?cnFuNUMxRVJKVmFHRHdkQTVFK0JCRUVDcHl0NHI2QzdQdklPZnNHREFHU2dM?=
 =?utf-8?B?d211L2JEMkxVWmc0Rjd6Q1VhMlhHZFdyd1VCSzNSL090WnNQYytGTDNBWGRs?=
 =?utf-8?B?QTVrRjA3TGFDSjNUSkNWRUhPTVdGUmFQM0wyWExndEluUzMxVm02TmlvUlp3?=
 =?utf-8?B?bi9JN3h1NzlOQ3hVYVlqbGJoQkgxQSt4SDFoRk05RWtDMlI2SFdjb2VPOU1M?=
 =?utf-8?B?UUNYZzdpZGhXZzFtMk9mMnlNU2JUUU1Oa2FrVlNPOElqM1JzYTVSWEFHck92?=
 =?utf-8?B?MzJtZGU1Yjlpa3M4cnZNZCt6d1VBTlhGTDR6RVhmdWVzRmVSd1hocUUram9z?=
 =?utf-8?B?b1NZQW5NbDdwbllHWEpYZy92eGwvQkNuYjBqc0ZIbStCanJSM1hvVDdwOTlR?=
 =?utf-8?B?cFFBRXQ2Y0N0c0JubEdwbzh4SjEwZUtMSnhCUW5FYmUzOWQ2cktCK2FldlNv?=
 =?utf-8?B?eG11UW54LytoUDltVzVReWRsV0lvdGs0bU8zelZSb0tMYlExZmhPR21YZGVl?=
 =?utf-8?B?WDFTRkppdU8yeWRIeDJJL2F2YS9IZ1BvNXViUlVSajF1UVcwR2FMcUNZMjVn?=
 =?utf-8?B?SVBRYkJPT0RseHRVZHl5aWg4djRjK2VuVlRlUk1GNEdGdVJxTjN5UUdzSHla?=
 =?utf-8?B?N0cvbFZUOFVtVGlYYnlFNE8rbzZYekZGRzE2TjdZV3E1MndYcnFhV2d1UE9p?=
 =?utf-8?B?YTVzVCtKcFpEdnJhUkE5MmRBcUVQSGdQd01mNXdlMnoyVFVkTzlxU1ZpWDhC?=
 =?utf-8?B?aG5ycndGTUMxeDJqRUQxaHRNYTRTd3VPSzZQR1RPUFlITmlHWi9JQ3FMYWh4?=
 =?utf-8?B?ZmRyT0w3TXBxRGhuSGtUVkVYNGt1YjBpYVBpNWhqaFF0cHF4QWlRbkg2bExF?=
 =?utf-8?Q?rXapGTKqVBtxoInXA5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83ef472-3d37-4123-2016-08dec21ca6c2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:35:44.8512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lWEbba1oN2XYJdWbuQolcfI5PkZ2LSHGSese+t66l5TQ3x8zkQVwh9iUIzo0gxyR5CZ4N7bbDyEFO5BqLqKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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


On 15/05/2026 3:33 PM, Dariusz Sosnowski wrote:
> From: Kiran Vedere <kiranv@nvidia.com>
> 
> mlx5_rx_poll_len() may return MLX5_ERROR_CQE_MASK when
> mlx5_rx_err_handle() reports MLX5_CQE_STATUS_HW_OWN while the Rx queue
> is in IGNORE error state. In this HW_OWN case mlx5_rx_err_handle()
> does not necessarily write to *skip_cnt, yet the caller (mlx5_rx_burst)
> unconditionally uses skip_cnt to advance rq_ci.
> 
> This can cause rq_ci to jump by an undefined value, desynchronizing the
> RQ and CQ rings and leading to persistent bad packet delivery until the
> queue is reset.
> 
> Fixes: aa67ed308458 ("net/mlx5: ignore non-critical syndromes for Rx queue")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kiran Vedere <kiranv@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

