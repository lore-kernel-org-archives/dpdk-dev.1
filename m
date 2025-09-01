Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273EDCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 08:35:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2419D402A3;
	Mon,  1 Sep 2025 10:35:09 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by mails.dpdk.org (Postfix) with ESMTP id A57734028B;
 Mon,  1 Sep 2025 10:35:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnuSGyx7cNvh9SGnN06vSPmfM5TGbr8g/TTB42t70KaJqB+t1tD0SOgrlX0PvxAgfpKfsctYux3YUnVI18pRSA6A805T3cLS9I2/V0Ox1jPvGMPfc2gtfKBRSRSLI7UwriemwpYKsK7NEEG/2brqEF2c5YGoL8BktdlKuHwJXKq53M10FSqXnO5rbSi6+/gZIV6vv5vEX3h+8RB1hIJFBDkI81wCYAYgQURxWA4b5hF1pXajVHlJ2UyIt0xYrEZa/u8uRyOueaBA6zg+SwBDm02ryHd4EmexgmlRARO9hRyVw672UUj2Nhs8jy30rYeVhqLlznqydEI0jFx/gejTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6BYMrH6Sae3BZvJA9CT9AlWXhoj80lLk6EJ18OHYhM=;
 b=dYtm+9W1fr2kvuvbgWH0FIgG/VVa/lJqikn180hnoRIPcj7+AcCII++FOjEEIt4oFnVAfZ/ePUHz4oxWbHJuBoF57i4rgiHDBU6048uh3W/RZ+dRGcGAwx3fEmmZmQikvrI2Bo3xvNwOV9s4EBLCXXiw5s4e13GCaJgOsOuKtGQJDpdHvEIHLDfrSMAHUBYo1YQigctduxBKQMby5JGFzeC/5+/t65hkfB9KlfrqoFqfQltOg/fyPZHSQpKSYSgVau/PWK1m31210K1MuI8hlsWnO0MHk8Bk/JhcjQdKzq8WolnmEKU494XzRx/vkZxQUo8oOJI6PY+mJraQS0zu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6BYMrH6Sae3BZvJA9CT9AlWXhoj80lLk6EJ18OHYhM=;
 b=bpZ9J3wxjK7CkkMN8Kd3uDi/Wr3ExP+wAFZaMntfI0CbrltZPl+r8/NL37nlnqAorTuiCMOzriCvTdjNisvEdWe8Mo1fJDnHQ4iHSUNtgiDSfsVOVhOPj/qxcn4bDWh0rxsY7h6Gtpowy/1KJyyvn2dPr2rnJ06XeCcgzGf0OUFQD6PiKCPILQpOrQiToisdRmHKA0v2Jka+vRelBYMU3wmizrIAS8+AcVBu4di+SYesYC2lIvlBhmHba5KjU5ovfxLrU1p0AK/foSTCwObOKtEoDh8+tTEYVjBenuHUPrGBg7sPRadlY9vA+qFRagk3hZOdo3UJ13wiw+69WnZ5bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 1 Sep
 2025 08:35:05 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 08:35:04 +0000
Message-ID: <bd44a6c5-c6e9-4c3e-857b-a49d0d5f699c@nvidia.com>
Date: Mon, 1 Sep 2025 11:34:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix matcher flags in counter offset detection
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Andre Muezerie <andremue@linux.microsoft.com>
References: <20250820084521.1088620-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250820084521.1088620-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fe8b93-f552-406c-fd7c-08dde93272fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0haZ0pMaE0rSWRvbFkyeFpUK1UrTTAyMWZpclJMT095VUMvRGFNdmp1Qm5h?=
 =?utf-8?B?OEV3dllNUU1ucHpkcnBlWG93c3lrN0REWG5pS1pqN3daVUcyOFBIODhZYmNW?=
 =?utf-8?B?eXA5M2ltSmtiTXBDZWZMMWZyc1VpcitJN2U1RmsrVUhPOHdKdkRuaWtJS3Fi?=
 =?utf-8?B?ZU54TVV0d2k4djVlbkF5cjRvRVBBa1ZVWmN6ZHhMNlNOTjhvSU1Obzdqc0Fu?=
 =?utf-8?B?MjdNSmg3WmE2QkVCTy9xN08wTENtT1VJeDlJNXNYZk1VT3p1VUJRK2Jha2dH?=
 =?utf-8?B?RytPTkhSdzJpS1F5Z3VZdDVON24za2ZZVnN5eXhCTmRRU0E3MzFBVkJadU4v?=
 =?utf-8?B?MXkrM2FYV3oyQ2dMVFkyVUZSamk1VnM4TEVLbWtyUVVFY0NldUVOK09aWncr?=
 =?utf-8?B?Wm9rWmVWOUI1VERHdzQ4OHVndnJLSklwN09xUGtRV3hYbmxWRDdyRjhSWG1E?=
 =?utf-8?B?WDI5RG5ENnJIL3NlS2NWd09Jd21FU0x3eUlxOGpSVURQNnVFNmlDV2Q0TWdS?=
 =?utf-8?B?RVA3U2JEcU4xcE9Idk55b0U0dlIwZk1abyt2NXVHL0kvTVUxdkFLcmxzbERZ?=
 =?utf-8?B?SHBObXMyRFp0UDhhZmEyMnFscld0RnBqbFFqUi9PTUp3eDR2WUk3anVNQXVE?=
 =?utf-8?B?L1djcEt4VzFJMWdGMFlsaElTaGd0eGs1K04vVTA2d1kxemMyVVAyQko3ME5x?=
 =?utf-8?B?RGpoZERLb0ZtQmx1LzRqbUN1VUFwTmRHYTBxc1dTK3hRbW42V1kyeTZIMGNn?=
 =?utf-8?B?NHFYZmorWDhJUnZVNWhrZFA4NEZ6OTRwVFVBdmxPYzU1L2x6RWdaZjRObEsz?=
 =?utf-8?B?TnBQTzY1M1ZYOStzSnZjNlh6aVJQOEtOMWRidlpOd3ROVmFCbGNwZ0hrN29F?=
 =?utf-8?B?eCttdiswbG1jU3dyMG1tTXdTVi9JbkJZNUNzMzh4YmhaKzhGdlZaMVJzZEZQ?=
 =?utf-8?B?NXZMdWI0NGtadDlKQ25sRk9tdEl2NVhSaHRIcE9xWXk3TWJVMXhwc2o1cUhQ?=
 =?utf-8?B?Z3BWcjRGbWxzRG1QcEI3WEFVbTB5WTNlMjB2VkVRbDhuMXAvdDNsQ05VYzdE?=
 =?utf-8?B?QVIvVnUzMUVTKzA2T2R0enpWd2dOTGs3Wkpmb0FMY3MyY0hETWJPcEhvTXNE?=
 =?utf-8?B?bHJsN0pVakpLc3NKdzU2VVl0aEFnRUhqWmZTZUxPMy9TNERLVDhEYVdBNlFY?=
 =?utf-8?B?RHF1OGRWV0VEaUxCZ3FURUVSMThOQWM1ckN0WjRnTG8xNTJPSjR4UkhUWG9q?=
 =?utf-8?B?RmoxT1lxM3JLQ0lEVzJoUmx3SzRacU8rTmJIL0FGeXhIbm8rV0Z1OHZEdnZF?=
 =?utf-8?B?RDZLUEdxZjAwOVEzMmNkRDA2Z1ZTdWZ3MkFTOGw5eVROUWxjblhSWlpYVWtL?=
 =?utf-8?B?ak9ISEpzeW5Tcm9ObkNTRDU1OGkxbzNFaDBoWkN2dTRvbWRlZnVZVm16akdi?=
 =?utf-8?B?blQzYWFjeEdhNTdSU0tNb0QySDlQTlJxeE01Y1lRTWVVQ3A2Z0MrU3dqNlJT?=
 =?utf-8?B?VldxVzlDQ21rZC9pSmptdzErcDNhOG1abmpDb0xGVmZjUW5GUmtlSjdORXg0?=
 =?utf-8?B?VEFKWURtQVo5d1UvVm1QSXRpVndwNktIbXFvazU4S2xPZkRaTjZTMDc3cHcr?=
 =?utf-8?B?dDhOdm5WYUdyYWlXd2ZuSG1KYnZDMVdVeUVlNjBLSkZFWjAvbFQrZ1BkUmxT?=
 =?utf-8?B?aENtUHl0OWxrMS9ZekdvUHMyZVdzMk1KSGZpQnhESFhmQThORXhJY2s1SHMw?=
 =?utf-8?B?YTVvaEQ2L0d2clBPM3M2bHh6ZjR2ckxyVTRvYmNsYk5xZHl6OU5KOE8remc4?=
 =?utf-8?B?ak9sb1dkNmFyWjdYR0ZpemNkNHNlMWlueW9ubVZMTS9UaFAzYS81RVBZVnd6?=
 =?utf-8?B?eWh0QWhBZ0xXazFrYVpVN2hDa1pmZHFlTHE3aDJTUXRsK3ZIN1daMjVmb1FF?=
 =?utf-8?Q?LuUOvVOlT+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVUalc0M2NaeUd6M3UwTkNrR1hVNDN1bTdNSW9BRC9pbEFzK0ZzM0l3VnVS?=
 =?utf-8?B?WFhBU2s4RGNvNzZtay9sUVp3dGdGRUlOMGo3N3FjaXpXQzdwb3F0SFYrRVMr?=
 =?utf-8?B?RVN2U25OVDZwSUh4cVNybytJc25uSGtGQTVxWGl6K2l5S0dBcXBLVHRUbDFE?=
 =?utf-8?B?YTZkZjdMNENoVzJ5MzhlVWdIMDRLY0c5K0JWQXIrMzh1VDVGQnNaNnY4TExz?=
 =?utf-8?B?TlhqdXdtaXR6L2FGWVZ5Q3kzR2VaWGhqeENFUzljY3RRUGFQQ2R3QnFCZHJV?=
 =?utf-8?B?WlNOUjVDTDZtc2Y3YlhyNWNBT1ZrWUJSdXFwV0dHQ2x0K0lvTnU0bi9PelBq?=
 =?utf-8?B?UFg2V0VrRWlNWlVNOXR1ZXNGU3MvdENranZpa1N3RmMrQmJMMElhcDBUUnVP?=
 =?utf-8?B?REtYZjYvc3pNSHNMeWdFbmJNZVVSOGtqNWF0Y3ZqZlNLNktpTXRocUhFQU5J?=
 =?utf-8?B?dzZ6akpOcWJvZ05vV3dPWXRkNGY0Y2J4OW4zcDM0MU5xa1dZQU1PWmRUTG1Q?=
 =?utf-8?B?T0Rxa0gzb29kallCRUk4MFhkRW9INkN2empjNkh4SWRuOGZyeVhFU21oY24x?=
 =?utf-8?B?UURSdC9wTFNHSzF4RnhyTFNBUng4TkJxd04rdEg2MlJUZVZsZ08zaW10dkNQ?=
 =?utf-8?B?Yll3eUxMTmQxMldMMTJiVE1TakkvcHNqVUZlOUVQcGJtck96MGhGUDZ5UG5H?=
 =?utf-8?B?RHVGNDh0K3ZmWm9EdjJvWk16ejRnbW55VFpPM05iZzB1OXgyeDFTNk94aFBT?=
 =?utf-8?B?NDdmSTQzTE0vY21lWTdwNEJXTVpVdUg4MlJZMlJqTGhIWWF2VCtvdXpqUk0y?=
 =?utf-8?B?VUQwdHdOTHh4VnhKNXZKUkpSYXpvUnFWckVLdFEzYmdDWFRldnM5UjdqSGRJ?=
 =?utf-8?B?c1ltbFFYTFdPOTVBU0t3dlNHQktmUU5ab3ZSL0FMdlg5aHg4WjV3MVFONjZW?=
 =?utf-8?B?NXFpNmxWSXRqNC8wM2ZNQVR0dExoUDRQZ3ZLRUtUUjgwOTQ2MVV3dG9WSkNy?=
 =?utf-8?B?MnVqYWNyQ21INDF2elJqZm5lWE5pNDQ0UnVNTVBiR0R5QUJzY1FLd3V1bmg0?=
 =?utf-8?B?RE9lZHpCNEE4eGdHYWdRUE1wcFdyZlJqWEpKNmk4WVZtQWpPSGVZaVUrYUZJ?=
 =?utf-8?B?UlFlVGxISnZFelZvdE5BdkpZRWZ1d3pPb3dpTjFKOEZuUDVqTFBkVm5oRHNK?=
 =?utf-8?B?NFd1WWNndExDZmUxVVlubE1DNnJLR29zWlVkbXd1RVVjcFB3VlZlUmQ1TVpZ?=
 =?utf-8?B?RDYrRkR6b3NGbmlwOER3SU44bkg5QTFLM1hTYzV0WXdOYXVsK1Z0MWVEWTZw?=
 =?utf-8?B?NFo4K3BqdzdjRXMwN0xFSXAzRC9PemVMdUpwcTl3ZFJ1ZnRwWmlKVGdEUzla?=
 =?utf-8?B?QjZ4VmJIQ0lMcmhGQnV1ZXVJZWs4YWl3Wk5BMm9iNXA0YkZQeW5POXBtVk91?=
 =?utf-8?B?cC9udmlBQm95aXZWMldzRmdtc3NCb2NlNll2eERaQlF5b25nY1VrM2p2N1hV?=
 =?utf-8?B?SGY0UnRHY0lWbHlQZlZpYlJPVmRpVGVOQ2UzMStCdWNUaVZndWFXMlRXWnk2?=
 =?utf-8?B?dy83Q2ZPUUtoQmpFZzJvUzNHZHVEdEtkdTMxNDdKSEIvSitkeE1WNjkvTkJB?=
 =?utf-8?B?WWQxbVRkN2dBbDZnUDFLT2l3REFZajBVdDROQlBWQVA4OTFacnZYUGVJYzBW?=
 =?utf-8?B?Y3o5OTljRVNYV2hMcWdYNnA3alM4dTlib09PYVhnbm5ha3c4RWpWTFNlY2VQ?=
 =?utf-8?B?cWN5R3Z5UkluWnZVM3FvcXpPaTQ5VW9hd0d2WmRnLzNtc09jTW5PbUJsQ1lZ?=
 =?utf-8?B?TiszT2dUV1IwejJKRit5UjV1emhmaDhMM1dFb1psc0JFZEptMWZ0aWhmdnQv?=
 =?utf-8?B?NTZSRmxMdFN0Z3pndExPSG5xY3hjcllkbFpMV0crb3dEN3N1VHE1THg3ckl6?=
 =?utf-8?B?RkMzaUk3UXZ1TzRIYmo1RGNJZWFMeC9PQnhlbzJkTEdUaUhRQitUdUoxczJW?=
 =?utf-8?B?aFNkdmJtODlaWXVyL0xFdmgwdkcvTzhjSktoYmdySVoyVXB5d1VQRUhsVHdO?=
 =?utf-8?B?NUdpMDVwYXFVSGVHbnpoNS9ZUkhaWTUwUHhKNjR5bFM0dmh3V0ZLWG9YUnUw?=
 =?utf-8?Q?jCUbgiQc4FdD5f0W6F3SvZi4r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fe8b93-f552-406c-fd7c-08dde93272fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:35:04.6543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAZr2xBxNLfI3Y9z+sIZ3OdjP48ol0CLGRyZq7p1SzsjzATE7JB6Th6XCj1ORCMu6mZmXd+hvZmJxJa5Op4StQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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


On 20/08/2025 11:45 AM, Dariusz Sosnowski wrote:
> This patch fixes a bug in
> mlx5_flow_dv_discover_counter_offset_support()
> uncovered by a warning reported by MSVC:
> 
>      ../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287:
>          operands are different enum types 'ibv_flow_attr_type' and
>          'ibv_flow_flags';
>          use an explicit cast to silence this warning
> 
> IBV_FLOW_ATTR_FLAGS_EGRESS was incorrectly passed in to
> type field of mlx5dv_flow_matcher_attr struct,
> instead of flags field.
> As a result counter offset support discovery returned a false positive
> result on application with old rdma-core.
> 
> Bugzilla ID: 1758
> Fixes: 4fd5e1484887 ("net/mlx5: fix counter offset detection")
> Cc: suanmingm@nvidia.com
> Cc: stable@dpdk.org
> 
> Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

