Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C5DCCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 10:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E31402DE;
	Sun,  2 Nov 2025 11:28:56 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by mails.dpdk.org (Postfix) with ESMTP id EF39E402D3
 for <dev@dpdk.org>; Sun,  2 Nov 2025 11:28:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg6f3VmR9lbUzXfMq+AfsQzHKhEfU6Az1r2BjK1F+CZT+6Eh0gdNT7cU1WWdYvACFmg/t2ME5zrBvNH3jb0POF1Af+YZ4W6FGVBTaGO39bgzoTlebOMPPk9GPUO5avIUlZyuiQge8RwmCYx+4VcCLBpKzAmWHvyAwmU9+TokNHoB8DyGjk7whbw0G6a0/QE+CeEfldPyG+Y6DPCb4TPxzx0bbA8+AKudlfLuVOALkaUkoKjZTyovDF/NzyYhu+nqLasR7dCbihmadHr3ZdYQz25UKPBktbZ/i1pj52Rmoerq20BqPmGKQkadkDjz77ixBVXm/Da5kc9OF8CyhbSjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQEBdybLaiId6lweGM5iI2P32NQTHYgO8fIkjK9gPLw=;
 b=MVQVdKT7sShu0cWomz4X099qwfnwrFpmH8zfVu7Ysx4nOZenkqZEzWDhYgqAQC8wF4UYdiL1NaHjpenkZNDS5gvt8q93i37ABz7ijUD0kaBQ/YXtw7YPuyMALY+DWsh4uVkDm7JsoaizKYt4vsLAWkvx36HKyTePpA+SBr180R9hcGUr731W621AHo7rNiv5EoGe6Gw9Jaq5+imy9DCVwSLVzDtcDFgQFprbEGq8Jbdvgb7AW2Wul0SsTw8NDf8n5ZLfH7sS6FSXDrFlespP/c6+dk3CKBkHseLHjBEJpeK6QQ3oB5NKUWW3dSq7WuTCVaxeqnGKUl/maJb66X1RKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQEBdybLaiId6lweGM5iI2P32NQTHYgO8fIkjK9gPLw=;
 b=pxS09xhS7U4ioDlS38Q4X9dhA82hd35PZGmU54FoQ3ghfebya/oCepI36aB5zXDO4531H0lXk/PAsYu/N0FUGblXs452p+jT1iOfQdNI4ILvXFwrb+C2GfK5x3IW7+y06A7oc3zITgSm5yNu9ViybcBOkO+H39k2GFG968dTysvBEJKQro72QoeU7osiLGt/kmQP6vrQorWR3c5gexCt3mU6bappwOKsULBP3fmsy/MsZW/4JJM5oyl8JmZZV8R6ZJfsoLM2/z6CzY7JHHx8O2K5Z7OH6bl6+s0sbMDc5fwfWpl+x5NbCTwNxXrvK/4jAOX0pUKzGatEsD/sGwyu2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 10:28:50 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 10:28:50 +0000
Message-ID: <7581816f-36a0-4440-b7d1-04958b4689b7@nvidia.com>
Date: Sun, 2 Nov 2025 12:28:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: remove counter alignment
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20251028101427.7swzqvc5o3ofzdxg@ds-vm-debian.local>
 <20251031025038.62100-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251031025038.62100-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ae973e-4aff-4463-d141-08de19fa9d23
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3JLVlZQT2ZMOFdSM0ozN0N6NmRZZnlnWUFGRnptM1FUZjFoTEhhNU5FdjhD?=
 =?utf-8?B?WklVQXNId0lCeG9zMWZaZHgrckZYNkZkRkJJNk8xeXRuM05zbFpsd1QrVjBW?=
 =?utf-8?B?UmdFVzVBajlMZ0x2VnNwL0dzNmpmclJMeHpyNFNXWDA5UThJODlnb3JERGQ4?=
 =?utf-8?B?Y2pHc1A1NTVJeU8vVGV2aWdNcEJtSW5IeSsxNFlLeUhkZFRFTi93bHhYSUZG?=
 =?utf-8?B?MUhXRGl1YWlSU1M5elRERjE3VDFrdEp4STRpbjlBR0E4S0ZJOHgzY3Z5aUc0?=
 =?utf-8?B?TGYzNDErU1RHalp6ZGxPV1NvVlY2N1JhNDJsSnFtbmdsdGpmR21hWVRHRUhm?=
 =?utf-8?B?L0pTNFRDdzlndkR1RElvaHhkL1NZNHFLVFU4bWNoR3ZNMmhqV1dyK0hLVng0?=
 =?utf-8?B?aEE2Z2VvMGtUUjlIVXYybFBGZjVoMnBUWThxdGhzeHZ4S3J3M0gxY3h2aTVE?=
 =?utf-8?B?NzBmN2VYaS9jZEdRZ1FiNS9Vc0FHczk0dnN3YVcrd25qUDFuK2pxbk8xUkpp?=
 =?utf-8?B?ZVB4Q0JHYm5lSzY2VFpNQ0RaeDJrYTFuWW5FRktFWEg4ZHZvS3oyREdnU3Vk?=
 =?utf-8?B?OEpJNHpwMmcyTzlIMlBDdFlpTVd5anRZOHluZjFoTXJWUEhqMVZjNHd5d0Ex?=
 =?utf-8?B?aElqM1N3RFU1dmJQTEU1U1VuZ3NjSXR0ckdLUGR3Z0ZzRGFzbStaV0w3ZmNM?=
 =?utf-8?B?QlEySk52aHZGYjRPMlp2OGU4QzU5T3creWg1dTllNWhsR0NsWU5ReWswSm1I?=
 =?utf-8?B?MFVuOHA2ZzhyU0VUekNhMmhEZ1dZVFQrbWQ4cUVIeHpSSGNBRXNLb05pc1A1?=
 =?utf-8?B?SWVIeForYWJrOUxSY2d4UzF5c3JjRUpkUUczeDJ6L1JhVHJjT1JKakZRV2pG?=
 =?utf-8?B?bTdXaW5hR003N0hwOVRCVk9lZU1BWlZmR0JFSStCMWMrSFlqcnBoYVhoUHJ5?=
 =?utf-8?B?Nm5FN2d2WHhYNjFEWmcvLzBmSksveFNvcUlJQXI0TnkvaDdSdUg3TE85QWNx?=
 =?utf-8?B?ZU1EL09LUVd0bU5rMmYwTDd5TVhwQ1VJeWFEb29uZUY2NXU0NDhJa3lTQWJy?=
 =?utf-8?B?YXU4cXBqL1ZDR0V2dmFqNlBKcnBKUHNjQ2FndzNUSjU5V0pqM29jQlNzMmFE?=
 =?utf-8?B?RHA5UXZ0alZJOWwzWDdkbGVRK2tNclVzR0gyc0RmMWJWZU1ETFowWHZZZ0JM?=
 =?utf-8?B?OUpSU3FkTGJHOGIwVnVBaE8zUUNDOUt3dVpoYW5Bc0JBdG9nTnREeUk4eCt5?=
 =?utf-8?B?MlFzVUdqRUhxQTdOUCtsTlIyNW55cGRsaE1yK21FaXpPYTEyMUhGNE5aZlY1?=
 =?utf-8?B?NTNrTWZyamJTMTgzY21ndk9hN1JRQ0RTUUFBREIrVUJjUFpLdXpXd1NnSlcw?=
 =?utf-8?B?cUcrRSszSWFSWS9qOHVyNXpBUXhJR3FONTFXRkN4S1V5S09ISWhTdExNNlZE?=
 =?utf-8?B?Tm9hYWlHVGlXWWV2U1k1Yk9GRzFoN1ZsdGM2bEhFLzM1NXh1NFh5bjNUZ0U3?=
 =?utf-8?B?VllDYzhWeHl4R0ZDWFpnUzFBY3lORG1nenJtK0Zxdmp1Z0trT2dSSlhWaGJz?=
 =?utf-8?B?Y0RqQm9qWFNNZjR4UGFQMnNRSjArQytuL2pqd2E4di9qd29helhiWXNBdmxw?=
 =?utf-8?B?cHJEbHA3SU1sYU9FaFYyV2ZxWmpRZ2JPUE96U0d1a0lyUVBFNEhWb3FPTkdU?=
 =?utf-8?B?UGEydUEzOFYzZTZCbU5UZjl5Q3hzWXM0Z2FxeWNXUDJVSXhxMTdnaktsZkNz?=
 =?utf-8?B?K2pPQ3hZWDF1dXdLM294dHFFWlR5VXBCZDI4MkcwVU8xVCtIRktNVUNjZEJl?=
 =?utf-8?B?bXNobzZDWWMxMkhPblg2Tlc0bGNhVDlweVZTdzRRcGI3TTEwTW5DZzQ5Wm44?=
 =?utf-8?B?ZXl4eFhZS010eTNhYU1sbkM1TkVNK3NBVlpIRzhEbjZJWTIzQjRZYnp6M21l?=
 =?utf-8?Q?DCLiMMWd7bnbci2T21gZRnQQhyDgbL2Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2s5SUFyS3hrOER4eVErY3Nja2piRENKUjVRREtVWGVyZlE0bHAwMnZBQ3RT?=
 =?utf-8?B?T0g1WlpCYU93QUZyZEl2akhiZ1FXMHVzT1cyN3RaZi82MVJGR2JYN2NMQWJQ?=
 =?utf-8?B?MWdEYldWQXM4TW4vS2dNZkpnWS9wSFQzam5UUmpGTDNjU21aMHVnTlhvNSs0?=
 =?utf-8?B?R3Rzb0JrRjc1bjVjdGJaN1VyKytqd01RRHRVZGRrWm9TQ3ozUHR6NDdpaVgy?=
 =?utf-8?B?anh5ZHdKT25xRkFibndVd2dVeTE0T0dpS3dvejhPU0RMdlN5ZDNJdHowd0E5?=
 =?utf-8?B?dDYveUFxN0hOb3RXeXhHclhRQW8rVlhuMlU0M0JYNXdXNGg1Vno2em5tYXJ6?=
 =?utf-8?B?K1dtVTVRRUdqMHVOZS9EUnpRR2N5aEdnOGtUVFJ3RURNUGxVS1hVaGhnRHZi?=
 =?utf-8?B?UHBTMGNGMFFuMVVBS0l0dmFCZEVSb3llOEZhL1g1ZU1OVk5KOS8wSkZGSlBy?=
 =?utf-8?B?WEFMaWZRNzhCdHhtbEpJaEwvWEFJSlZqV2dyeTU4NGhXTmEwS3NsNGxUcXdG?=
 =?utf-8?B?V04wenRPcElIYzlGWVpVSENrcU5hOTdyVUZLMlhjUkdEZWhqTjc3YWtuaEhR?=
 =?utf-8?B?Nzc4QlJyYlJIUGh6R2xkMndlQXNDblBHaVZtZ3A0akxmcmZYT0Q4QWFkOWow?=
 =?utf-8?B?dG5ubkNFTFlUeXJueFNJVEMyVWMrVm5namZMTXpXMllCbkxjUmNhQUk5N3FD?=
 =?utf-8?B?dUEyUkEzWVJhc0xSSlpBYzI1eUt0WnE4cUJEdUZ1SXFBR09jM3BMRzNkTk80?=
 =?utf-8?B?S2dBd2ttWGptVk5RbWo2bW90bllaYW9lcUxpOHVDMEVRaUZKY0YwQkhhdzds?=
 =?utf-8?B?YmNnTTJ5NkZxSUpTaC9DSjJNUEtRMitHby9VazNIdDlOa2dFRXJ4bVRFaE1P?=
 =?utf-8?B?RVZZZ3gzekJ4cWVNWFdRN1EzMlo0ZVhtWHR3K2l4MHdXcXFKMEh0Zjh6Z3lH?=
 =?utf-8?B?aUlsQzNyRHcyYzdodUFIRlFob1o4M1lTMlprdzhIclNQQ1hLMzVCSm9TM2o2?=
 =?utf-8?B?Nzdna0N6cnJSV0FmaHY1cXp6bUxLSk5iZjEyR1BhQUorTHlRODJuendHOHJv?=
 =?utf-8?B?S29YdkxCVzhIUmNEZWpTNjYvcXZpNWl1dFp1S3diQ2dNdHhySFZ1VnNSTHZM?=
 =?utf-8?B?RDJXbXo3Y3dnbzFHTDB1azV2WWdIWGNRKzBCQkd2dlhjNTNtSXlhOHkwVWQv?=
 =?utf-8?B?YXp6YVM0NVVQMlpVOXFMNkU1L3pETytRZmlleFM4K0xLbjd3ZWdxMUI3amxR?=
 =?utf-8?B?QW5qMSs5dXlxYWZNZ2JsVjZYTnZRWFFKdmJxelAyckU3R0hvWU9UUXQ5Sjl5?=
 =?utf-8?B?WjV6VVV5ajdlVER2dFFFSHUzOW0zUGcvYXNjQVdtRWlnbmtLdmpxRlNDODQ4?=
 =?utf-8?B?aHQ1MlQ5WGtzODBHRVB3dW5DMVpzeFVvc2x0Q1Z6REM2NTFPcTg2empRUkRC?=
 =?utf-8?B?QWNCUWpGNEdreFhqQ1M3UkoyQXhwRSt0b0NWb1NybWtEYTFmV1RwNFZRR1dP?=
 =?utf-8?B?Q2JxSUw3NE9DRXRYRXRac3pzUDZhcThLU3g0ck9aV0hCUVlBTzBLSHFiS2kr?=
 =?utf-8?B?MXA2TWNZYUFyaFpNcDI4aGlUTXJjWmtya0FzUTd3dGlWNENKQVhjd0NTMWxJ?=
 =?utf-8?B?QUhBdHR1RFhWMks1SzZLQkh0a3FGdmE1N3JMeHFtTlhNaHUxc1RYWjJicFBn?=
 =?utf-8?B?UjBRTlF2Z3ZjcWFQeVFwR0lyY05DS0gyS2V2Vlp3SmNEVG9RRUtxazMvajhO?=
 =?utf-8?B?L1ZoY3hDK1JmOUpNSmdlcFpyNFczUGZLTGJYOHlEcVlEODhZbUpWYitBUk5u?=
 =?utf-8?B?SjkvV1NpcHpJM0NVQkJKM1VwZCtZQjNRcElJc3dmellpVHdCTmZvM1U1THFk?=
 =?utf-8?B?cHpMT0JyTzJzL3dTaHFsWFZvaFpNdFBTQWdoQ2xpenlya0lWTnoxc0tqa2dY?=
 =?utf-8?B?MTFjL1hPenFXcE5xc2lQclFVN0J5a3BDVStSb3M0ZkdLSmF4Y3RlNUFRQW9u?=
 =?utf-8?B?MHpraEJUM3FIbHdCeWJ4RWR5SEpoaTFNT3NZNmxzRUVlaWlQU2p2T0R1MG5l?=
 =?utf-8?B?SnZuOWdiTGNCWnJVRExGWEl2UHpoNjVYVi83aTlhR2V1SitRTXF6VHJjQlNG?=
 =?utf-8?Q?9YjKSe4KPRxTMEGGe/CCiIU9J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae973e-4aff-4463-d141-08de19fa9d23
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 10:28:50.5074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do2iti3wvAutJlJ0qbHgUP+NzKN6tZN4QMds58RAbZ9Dq5KbnjEUqVOh94xM2ozQ3MLxlgxBeV1vGuXhpzH8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614
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


On 31/10/2025 4:50 AM, Rongwei Liu wrote:
> The memory footprint was increased due to the alignment.
> 
> Fixes: 820ca7361bb7fa4 ("net/mlx5: fix flow aging race condition")
> Cc: rongweil@nvidia.com
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> ---

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

