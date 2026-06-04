Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D721ACD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1436A40430;
	Thu,  4 Jun 2026 11:37:49 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43]) by mails.dpdk.org (Postfix) with ESMTP id 8D10640430
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:37:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzLxPFBSml3F6KaTBayvJZ9fbX9/AS9rOvtA8VwjVUXXIxizzKau3AsfIA1PHxv5cK3kVMdV7X5R1SVRxjiPokXqVQUlMnsOGE7aneTXg7NuCIK/O/IzFDtBHbZ/Bp8YtDnGCaQEtKMjly2DUjXEX7tKEDSUBpV1K7BN6YauyHBmAOVFrDRqkqfrvkwAIdHQWQh6WvxbniMwJVxjpUqjW5aAj3S9t1Gz2VgBimWEojwQuCRoeD3nDaVjSuUV96jInT0JVF8vs98Pb8X4befPM58bFUtY4ga8nczpz/i4SrLvMTVFLmDDnSMHDR5tGRgXbPLK+QdrhJm+/kg0V571rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myEIESGf8xg0yJs7kxubM78FzGAxvIfqvAigI46m3Bs=;
 b=YVci3HdbTNnKESrrAkIy/4amigAnOAxYCvekrpIIrSbhrUTtIb3/+HahxEJ1rZodReJPxJIG1TnGf+2Ke+4hmJOHeggK1cwJGJ2xnfp+B7o6992nC7aOwiY/RIwexMe44psuCVdy/q+BYph2CA7G0kxjVW0Q7fXh7lG7BrqcCsXU5AaCQ4uoIi5Gxl1+MwzYq8+lRDRk2Rsoe/Am0X5nfhgTTRE+e2522oH/bKvbTdl0sh/v7Nif1b3xUAwWY64Ej2Q4zHHo+/X6BB15mKg+DuF2Q8SJxw/R/WnWifz8DgYCTuGHQoQvRr4tTlQYfxr5alzkglu0kONn77kWHOsaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myEIESGf8xg0yJs7kxubM78FzGAxvIfqvAigI46m3Bs=;
 b=S5NlTg9R329E9BgbjirJk8PQ/9l43JbUM00xPux8PWVdSvJq68tiGnZxw5kR9rU4RB19cC15UY0S9MDXZHsDottmjCb2Xa3JiQF3xBmK3EuZJN0lzz6RD8/XJGL8hjr3ux49swSGCTKXhACS1G5arzTvzrL56C8aH4YkBvlABjlminyENsDtbsV1EVeM4OIVTJYt5y1G62fhVNQGdTR+8BNZzuDR3Hfy0/nyE1FM+ktz6QieHKdqUPgRSYmB8ybF/Sch4fWN8baaZ4CoFtod62285z4Y2gNWWIBEH2bblC+Pf9Is/f6ZXmbpWXLrnzj5VHT2TM/Q8YxPU2a9hu1E4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 09:37:44 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:37:38 +0000
Message-ID: <4350e4a1-2ff4-4b27-8811-1917d43b30ad@nvidia.com>
Date: Thu, 4 Jun 2026 12:37:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net/mlx5: prepend implicit items in sync flow creation
 path
To: Maxime Peim <maxime.peim@gmail.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
References: <20260511150854.1398044-1-maxime.peim@gmail.com>
 <20260527103531.1266488-1-maxime.peim@gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260527103531.1266488-1-maxime.peim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 97988d73-0472-4683-cc09-08dec21cea6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: T629BzHHy8qo9Ec0X0J9HVIS2yBugTUC0s7N+o8XUYOB68u1ArSmMj+1eUrn/WAli0jXH4BM7ZjVEHZ0DSP4FyooZewZXoFM0pOlewJxvwGbiLjiI/3XmYVlbOKMHBJHPb1cvShablBxcukp9NOcTZSKjrldC1r2//6turRaExcF5rS65wJtaDBA3//iMmVRfzh65CHBUUZ91G/Zkin6wDpAIRbM5xU3qWRFU2wvpqSb1oJtbBgeY/ScYvlAwVMORG4YO23ZGiekM7RU+O1sYjQuCArx38Z9VzE5UUr8e2HGIN3TP9/Tcdtfmxcbf/XGJjjAYXZrlCx052ZS4p+BKjHGKboTu/I6EazWljdL2nGSoc75Wnh9FkYvSalhYHuCLxJXNsqe1yMfdePvP9KoTl28z/hdjieNIlSQDj4tp9uh+PHDma+RMy11FdfcJM2aZb6lHzIwk0FljAlbY7G2hO3AzDz/NDDk8JKfAZ6ydWhT59qFi02/clQD+1C72MRJGRGyO40EGjX0doPjM3FfBv2gC9+5HROSZoQuI7M4kwAi0ihVwqQkGUw3li5qKZyQRbWEOFAdy+71isQqxWPFFofwBrRD0Qlj5mu3UXXa8r/qc3OhSkOLC1n49iOSt1XEd/jI45sUIWhYaAtyvBnmaFojtfpScR4zv4kJfalOzNN92oPff30Msz0+l7w0vnJd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmp4S0Nka0JHeXdNQ1Bmb2pWMVVZT0hSMHRHdzA4ZnNQQzR4Rk9KZjZHb0E3?=
 =?utf-8?B?cG5SV2FBSWdKTWpGZEFUQWtOL3dleWdEU3Qvb3lhL21sRDROWnp1YlFRUUVS?=
 =?utf-8?B?ZHFvRHhWNTdyNHFBY1BKS3dWeVkvb2pKOWFnL0tuZGlvdEVucUFWaFZzUGkz?=
 =?utf-8?B?Nm9xNmlVR2NBU1ltY3JWYmZpOHpDZTB0UTAyN3dBOVNFeHloeFdOWHR6eE1F?=
 =?utf-8?B?OStQdld5TWhkdXJsSHJRSko5bmNhU0tDWFNNQmRBMk4zVWh1RXpIVXFlQmdX?=
 =?utf-8?B?TTczbFI2N05tekMzZHZNSitXdzV4QzM1b2tYQ054YUVaZEllU3BlSlNDbkJl?=
 =?utf-8?B?MmhnK25nYkNCNkRxSFZEQ1l4MFcwRFhFUGt6OTN2ditEajFjd1F4d0hTR0JN?=
 =?utf-8?B?ZktSbWRENnlvMi9BYzJlTVJ6RWUrWVlBZVJPSmUrZXo4L3EzZk84dzZPYjF3?=
 =?utf-8?B?bHBuOFhSVlhJT2pEREEzYWt1YW0rZGxqNWRLT0RHOXFSN2QrNzRRRERLTS9Y?=
 =?utf-8?B?U3A0OVFLWlFVVVQva09lRHdaRExLTHI4b0wzc1ZMdlBKNnVDOEtoc1BaNkJV?=
 =?utf-8?B?RXBvZlBYMGMvcmpVZUY2SVJwQXNqN1R6cERYYnFLS09HT1NNbUxaVE5rVWtv?=
 =?utf-8?B?SmJKRnQ1NVcvZTZQTmpoeDJ4bmp1czVGRnBEUEx3Ny96Ylg3MG5tTGhtRFRk?=
 =?utf-8?B?ODlKZWkwbDQwSHhaK2NUdWxORk5wVHRxeFpqTEZqS3VLRmkrajFmbTNSRHBB?=
 =?utf-8?B?UXJlK1JMUDhVd0dLR1hUZkpheGgzNGozVlVyb0JBTG1McUxUdGtVUTZKWTNX?=
 =?utf-8?B?bU5iMzI2NFZpK09LRHRvV2RMYTMrcVBpak02eGNDZ1k0ak9BZEJmRm5HZzBF?=
 =?utf-8?B?Q3NKY2RpVy9hMDFpZWIyeE9HZ1BkK2VkZFJLc3RYQnRtc2FTREo3ODZ6SWNm?=
 =?utf-8?B?cm9VVEpLbU9uYnowcEtXdzVab3ZKMGRiNklrWmtQbFREK2ZQNnZ4NklVQ09X?=
 =?utf-8?B?Z1A4L1ZHeUQwSVkxYmlENklGay90N0ZSSGlrWGlDMFhjSFVsZ0w5eE4xRExk?=
 =?utf-8?B?M0NDQmJFcCtmZmV6VU1jSGZtcUxGQ0NzSkU4Z29FY1NiZWhjWHN4Z21KUkRX?=
 =?utf-8?B?ZjZNZTRzUmJXVGxWMlpyOHRiaS9uaE5IT2x1Y0VNblh6eko3UFJkc1NMVWoy?=
 =?utf-8?B?YXZmaXlVUkR1VXRTeHpMekh1RFBwSmJUN3R6MEtYQUNVeGZiazVGaFFqT2Rl?=
 =?utf-8?B?SVVWRUVGbzBtU3ZOOW5ROWFGVG01OGV3WCtwUHJscm1Sdkhzc1JrQUNOTjFW?=
 =?utf-8?B?KzF6TWtFNXE4dm5TblE2Y1RpLzZiVitqZmttVGY4YTgwZ281K3Z2TVVjdTFz?=
 =?utf-8?B?TWRWR2x6bHN0WVQvZmxvTWdGcHNpRSsydmppUjhwNDJzUnMyMnV3ZXAzbnd1?=
 =?utf-8?B?aDlLeW5taitsbXAvdno5WXQzTVNQM2ZRMWQrMzNLdkk3Q0hDc2laY0ZxaWVa?=
 =?utf-8?B?QTZTaUY5MWo3dVFMMHQyZkFqaFBtYURCTUYzVGF4RWd3TzQycG9oU2hicW9s?=
 =?utf-8?B?bisyNUVKSktqeTRTUkVMcTNCZWFMVjNwazc1K3pOVHJEa0ltQ2xFbjlKVEE4?=
 =?utf-8?B?SkVBS3Bva0xHeU9taFF3aHBnS0ZLL00yYnFVaThjTFgrMlJmMWNNK2xZQzZu?=
 =?utf-8?B?VlhMMHVRV0FvbWp2d1V0TDJIZFo4NEx5OUdFU0xjUTFXcEIrd21XTmdjK3pP?=
 =?utf-8?B?UHQzWHgwaUVOZ0FhUmNEQUwyL0hwVTVIUFd5SEpBN3crRCtFS3RmWGM1VThH?=
 =?utf-8?B?RWVNYVRGTGRNajQ0NEZwbWpBeFNwaTNRRFpyYnFaN0JzWVZ1eWhhdzJxc092?=
 =?utf-8?B?OGRXS0xmUXByWDJkTTZyZUFpbmxDWHFVaGt3UUdRUEFXYmQwSW5tbWp1TzJE?=
 =?utf-8?B?TzV3Q1VSMlM0RjZYYkJFckFlbVVYQkt6RFR1TzEyTzdmWWNnczdnenN6WmJj?=
 =?utf-8?B?VlFyOVZPbXQrT1R0Z01GMnFXN0RMVzE1cC9OeVVCNW1GakdBakJFeWEwUG56?=
 =?utf-8?B?VlZESTNpRGJ2N1N5dmdRQmNDSmcxZ091aEZ6a21pVmt0VXhaK3JWdmNnZklS?=
 =?utf-8?B?dzNOTEtEZmdlQ1dFVGM5UGlnUnA2Snc0dmNTdmUrZnplQ2ZianBlbWJIUlZW?=
 =?utf-8?B?bUh1UVJ0S2VMUVZVWW1JMmszeFV0Zjd3SnVCbUorWnJDbktFcXVDenQ1SDdq?=
 =?utf-8?B?VXVKdzJnNTZXbG9TSXRBeVBYVXluSTFpOHArTmVBRnlxYnlYaFdlNS95S3V6?=
 =?utf-8?Q?i4vwFwXpp/76sGRvce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97988d73-0472-4683-cc09-08dec21cea6f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:37:38.2327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1MRV+nIHxDUG9CtiUsIXzgSl5jpLzz26msaxdPR9xRIfJCjTf6T4zvXnKYreqSQOtOblQY2dWs2RrkxcXUmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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


On 27/05/2026 1:35 PM, Maxime Peim wrote:
> In eSwitch mode, the async (template) flow creation path automatically
> prepends implicit match items to scope flow rules to the correct
> representor port:
>    - Ingress: REPRESENTED_PORT item matching dev->data->port_id
>    - Egress: REG_C_0 TAG item matching the port's tx tag value
> 
> The sync path (flow_hw_list_create) was missing this logic, causing all
> flow rules created via the non-template API to match traffic from all
> ports rather than being scoped to the specific representor.
> 
> Add the same implicit item prepending to flow_hw_list_create, right
> after pattern validation and before any branching (sample/RSS/single/
> prefix), mirroring the behavior of flow_hw_pattern_template_create
> and flow_hw_get_rule_items. The ingress case prepends
> REPRESENTED_PORT with the current port_id; the egress case prepends
> MLX5_RTE_FLOW_ITEM_TYPE_TAG with REG_C_0 value/mask (skipped when
> user provides an explicit SQ item).
> 
> Also fix a pre-existing bug where 'return split' on metadata split
> failure returned a negative int cast to uintptr_t, which callers
> would treat as a valid flow handle instead of an error.
> 
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
> v3:
>    - Factor the implicit-item prepend logic out of
>      flow_hw_pattern_template_create() into a new helper
>      flow_hw_adjust_pattern() and reuse it from flow_hw_list_create(),
>      instead of duplicating the prepend logic inline in the sync path.
>    - Zero-initialize item_flags in both callers. The validator is
>      read-modify-write on item_flags (reads MLX5_FLOW_LAYER_TUNNEL on
>      the first iteration), so leaving it uninitialized was UB.
>    - Call __flow_hw_pattern_validate() with nt_flow=true from the sync
>      path (was effectively nt_flow=false via the wrapper), restoring the
>      previous behavior that skips GENEVE_OPT TLV parser validation on
>      the non-template path.
>    - Document flow_hw_adjust_pattern(): the dual role of the nt_flow
>      parameter (template spec-left-zero vs. sync spec-filled + validator
>      flag), the three-way return, and the caller's ownership of
>      *copied_items across every exit path.
>    - Clarify the "omitting implicit REG_C_0 match" debug log now that
>      the helper runs on both the template and sync paths.
>    - Add Fixes: tags for the two original commits.
> 
> v4:
>    - Fix items in case splitted metadata are not needed.
> 
> v5:
>    - Make flow_hw_prepend_item() return a self-contained array. The
>      helper used to shallow-copy the prepended item, leaving its
>      .spec/.mask pointing at flow_hw_adjust_pattern()'s stack locals
>      (port_spec, tag_v, tag_m); once that frame returned, the
>      consumers in flow_hw_list_create() (sample / RSS / single create)
>      and the post-extraction template path dereferenced dangling
>      pointers. The prepended item is now deep-copied via
>      rte_flow_conv(RTE_FLOW_CONV_OP_ITEM, ...) into the tail of the
>      same mlx5_malloc() block, so the lifetime of every byte the
>      consumer can reach equals the lifetime of the returned array.
>      items[] continue to be shallow-copied (their spec/mask blobs are
>      application-owned and outlive the call). One alloc, one free; no
>      call-site or signature changes.
>    - Fix the &item_flags / &orig_item_nb argument order at both
>      flow_hw_adjust_pattern() call sites (introduced in v3 by the
>      helper extraction): the prior order silently stored the item
>      count into it->item_flags / the layer-flag arguments forwarded
>      into mlx5_nta_sample_flow_list_create / mlx5_flow_nta_handle_rss /
>      mlx5_flow_hw_create_flow, and stored the OR-accumulated layer
>      flags into it->orig_item_nb / per-rule item-count uses.
> 
>   drivers/net/mlx5/mlx5_flow_hw.c | 262 +++++++++++++++++++++++---------
>   1 file changed, 194 insertions(+), 68 deletions(-)
> 
--
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

