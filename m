Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC36F34C4E
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84D544021E;
	Mon, 13 Apr 2026 15:18:29 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34]) by mails.dpdk.org (Postfix) with ESMTP id 4D92E4014F
 for <dev@dpdk.org>; Mon, 13 Apr 2026 15:18:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2gcn0TBkVMdQ/c7WnV0Hmauuqpa2fiRPLnffoscP34oc29dNu959pGEQL10eOsmuJpBSzbfhVTZnJ7inHVBnC5O/dQaDlQ8PD/8+wDt70S1ZxmLPcM4FuPdxFmFDhOugKsxeH5CgO+OrBQ70hKBtlEuykqb5cHdTXiXKBsimMo5rZMIrJbSqFBsSUA/rCi3dk/n047OCF5OdK5qjZDfkgAmahLVUJBBYsxPKR06ZY7bfB5FRjH4Lxh/DFzZwrWCB3HKfecShXqWsaSp8xshl0MIE5etGuF9mb1kEkzK3Q+eBNh9g/84zh3lOAVCWJB2uiumQC/VLjFSnoRTXZncdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYtCdaGMXv3C9Ytpicd0SExRKJ8Bg+j8kM2DMuvrAyQ=;
 b=TT1bqKra6+kSQxx1jZYL/Lhi99bXjGypI6NDAUu/bHD0IffQbdjObowRwDanlWKPsgDCAW60bwvGgvFFtRjXjbU3Ld+7weOVyIzySrHdi56BkxkPy8hj4JaQ5HVuHwFdQ8nk0sR41dVUDME5K7LCM0ExN0MzqLkRXoQH63eEq7j5/90OtTGC+WEA/KoGluB1P4uSJsv+omxIvr8NcxNhAkLXGlE7Sv2+BHXVDP08/C9wBCUALRCoWy1KPe+j1FpTvaApLhbzQ0NskUkAxPANlZsALZ+K4wvJO05oChWWoo+T+5aLJ6ikPs5jPueAyIFphgnPnEw3c0SMjPuQi0bZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYtCdaGMXv3C9Ytpicd0SExRKJ8Bg+j8kM2DMuvrAyQ=;
 b=d3D+ipma5Qsvrj9fKYPjviqSND/7EauM/THkxvXHWxFaP2zx4Xh6J3/h9qGPy1whllAvVERVoni4b01jVPqaRNX/R2USXClvGrhiZDp0VBDtvCQ1SdQQT/zuQ7WkJp46TLKZmUQoxJzib/SdfqXwmARjxWjOT2T1twD+UkXoXN5xD/A3PO1D19VSvRyTvuzaB0X5XBR7Qr3mqoRrZUIGkq8pS1O+m2+men3GWexTzOetphEWnrT5VaekqAyyBsgH458a0+P1XM/QYv3hTj7fouwlzdfUjX/o7KQHqSwxESfbhn9JBDKV+3u3t+QLaC0M8OkgOPPfbETWlvCJ/Zu0rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 13:18:22 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 13:18:21 +0000
Message-ID: <b9d01844-3867-4a1e-8aab-a7348e5aeedb@nvidia.com>
Date: Mon, 13 Apr 2026 16:18:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] net/mlx5: per-queue Tx rate limiting via packet
 pacing
To: Vincent Jardin <vjardin@free.fr>, dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com
References: <20260322134629.94633-1-vjardin@free.fr>
 <20260324165047.391137-1-vjardin@free.fr>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260324165047.391137-1-vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa47244-d1e1-4e49-f9c0-08de995f22ae
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|11006099003|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: AK+evUdGQhyqX6CMRzPno54w9BaF2u3esTrURDebuKgtSm2G2Tp9gvRv6UitYybL/lvyVz5siZtAG5g8/Crz7dzz+s+ID9QF7GfcqZOWSJ2abIlZFB1ZswDu1usS3H9JKvOdSjWhvMwkWIy+xvfXiPE+DrJ03RawpWu/OQW0ShcA32p53o2y7cHKk9Xg5lRrqGFvwD2LQZy6Taz05+mctiEF/Mfnf6VEBee3buz5kWt12tbmgJEIiNm/oAhfpOj9G4vRIZkfm5DzHf69pSo9K9+FP12/AphZuZAf6rr+lHbSHR6n6M5EzG4jg4dYHQsVStJF50zqWbRhK6OiPUvRkExG3H+6XK0oVQJvwG7Xz9fUKTwF7/jS8kDywu2q25oe6alExkX9DZSXtjnsSWOK0ZRbIGfc7ef0+QLLJrzRlhcpt5h+wDBsVjCuezBKMuL3U0TKpyUiXHg+e/02vFVtrp05lejS6q5Ab6px8yNDoTyhexKn/xh/ADDutvaQhcLvnvbud920eAHxfknKvOa0PDNGsPRq5ZmG/r0i/Aiym5mMueWUfiI24Z5AFKRQDulT5W9kfDbg7HUGPmU0NHB25L8d1mpiUnxnfvM5vpkUvZ2bnbwlqqiF9I9+yB9vbqGsUsF/9q3Q2CAUkLE5Ooa6XAGHWHSCqOaZb0ZRtfuwCYXjX2F7WWDKd21vq7hXN794g7mfy2Q7DIMs9JgnC5AH6N5yAznOVoiWixyBlhTybUaK/lnNxBpSvRZebmE4RKTtJMd3trtZiRGzecq0wNfzIuCxjT2AD/QC+2tM0S9aUbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(11006099003)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0llYnRqRWZxeUVFY2NnZHlPenlvbjFGd0RDekRhWEpnd1BNMjc3aXNobVZM?=
 =?utf-8?B?anptSnlwemVCTEN1Q1N4a1VRQnJRam8zWVBRNnVxanlUN3ZnendBQ2N4ODRG?=
 =?utf-8?B?elNReDRMQ2tJODZrMHg1YjNpVHF6Sk5rbzg1T1ppWW9nQWxyY3Nhemhxc1JC?=
 =?utf-8?B?bEE2SnFkUldiT21QVWdXNWtxK0hyUHEzYVNyN0paTWZOVXVwWGZYU2F6Mi82?=
 =?utf-8?B?Wmg4R2NOMjI4NGFsaDR0WExjRWZXNnU3SngrTXRHMEs4MTZaT3BPaklNWm5C?=
 =?utf-8?B?S2RCaURGdGUwaExTemNabW5DZ3B3dkRYM2lBTVZIbnNnVDRpRjIwVkdhUTNl?=
 =?utf-8?B?ajNwWUpVZVk3bWQ2Vm1hOUpveVJRYk8rTGhvNFVHSUVCaWp3MG03QlhpWVg1?=
 =?utf-8?B?QVFQVk5kMG5YbHlGVjl6Q1o5enlRVUNpRE1YMmlBWnBiZ2E4cFVaZHhlaFlH?=
 =?utf-8?B?S0ozM2d3eVRPYlpkMW5nWGRvR3I1RVl2RnNMaVFINnFKZTQwbGE3OGtFcUo1?=
 =?utf-8?B?Y2R2dUMzVnVPWWYxMW9VNGRPNDJaT05xTG9IbkV2MnhmTVFtQVl3R3JOem85?=
 =?utf-8?B?NXFTc1JIZldWdFdHYmtyc0pXeXdqTzZzaE5KMy9Da0pSbU9oOVBReU1hQTRE?=
 =?utf-8?B?V3JxU0hHY3d1Q01jSHlDc1R3RmFwa2V0L2RXNm9rZWR0eFNjaTZJckRUc2E5?=
 =?utf-8?B?dllqb2gvdVEyZTFpZ3RmdW1jM3o5ZlVaRUtpLzhPeS9haWV5dDNTTGN3dHMz?=
 =?utf-8?B?L3ZwN3JteTc2NVoxN0ZFK0dCSk1RTkx3RGcwRkVJbjdobSt4d3l5bXhpc3A2?=
 =?utf-8?B?OE44RTFnYUhZS2FBclJsZjVUdjBEVWNnSGZvNVVPUWxvaU5OdmI3VGNCZC9s?=
 =?utf-8?B?SDdxUXk4UVA4dzMwRWRybFFRSkxqVllyQ0FpTi9yWDA3YkFvNWFVK3ZLMXpK?=
 =?utf-8?B?OUVaM3EzcExhYXRteFQ1SzFyeU9CUkg0SHMxVVJFMDhJdktMMFNMclBOdURD?=
 =?utf-8?B?S0FtS0dzUzNXKy9wQ214OGExRGM2WnJXUEJyMjdTV0IvNjcyUlZjd0Y4bTFi?=
 =?utf-8?B?VTRHK2tNeURwWFJ5WVZaM1BwL0pBWU9xY3c3NWFINFJwZ0s3ZzNEQ3pZWm9q?=
 =?utf-8?B?RmUzR1F1dTgwSU1iZkZsbEo4NFdnUnN6MTNramtmQzAzVjh4QlJJVFZRcmlp?=
 =?utf-8?B?aE5MUFZBQ3k5TFVQcjJWL3BLUFpsMi8yR1Jqd0l6Q0oxWUVoWE9NWFlZVDdC?=
 =?utf-8?B?K1BzSWJxNUJsdjlRM1hZQkkvdEU4Q2Zmc01hOHJ5bmNYQmo3TDRKd25rRjFy?=
 =?utf-8?B?MXN1a25lSStGc1hSMExlRkhpNE41cXAvY1FaWlFxN1FzT3F6STlPM3YrdHRL?=
 =?utf-8?B?cmNoODFlL2M5OC9JaW9lZTlNRkV2bjRrYXY2S2owT0hGTHdwSGhMQW5kK0hl?=
 =?utf-8?B?b2gza0VxQlE0NzFrYk9kTllSUFUvRjRQVFhlcUE3UEZMYy9UUC91KzB5aWo1?=
 =?utf-8?B?LzVtRlllcmxnSDdmYnFxajc4ak5xSFU3bTRuNmhRU0I1aWtnZlUyT05WdkRH?=
 =?utf-8?B?UHArVGYzMW00WHlYZDNUdVVmVGdKZHpWdHpTUzV5Ull6eEdFellxNDlwUWla?=
 =?utf-8?B?eHdEeHY0dHR2S0hkM3d3SGJ3czZJMVNLZElESThXeUoweTZ6bHpJK2lmTElV?=
 =?utf-8?B?UnBaSHRxSm5hbVpFcHYyRWFzdUJ4OTQ1aFRwQWZRcXNmcm00MUFXZW01NWlX?=
 =?utf-8?B?dUh1MDMvSG5LelpwQURKcjBaL3d1WVRDT25zZDdNc0F6Z2V4RXJYa2hxYlJN?=
 =?utf-8?B?NWZMemVIVjRLbExXdWM3MmRROW1ta0U2U1JoNnRtdUdhc0xKcW94WDR1KzZs?=
 =?utf-8?B?cGgzNTZDemV0RTNXb01JclFOeENVbWVYZGFXSlF3aFQvTmE3QWVHYnRkZ0Zu?=
 =?utf-8?B?bDM1eXlRU2k0ZkxBREdyTU82d01sRDhsNGJIdFMyVDFtZkRPLzdNYjlLV1Fa?=
 =?utf-8?B?NzhIYWc0dFIyQktlM0o0VEgzM1ExU0syeUk2NW1sSWJ2ZFd6NGY4ZTJGRTQv?=
 =?utf-8?B?UlVNT011RHdQWVdIL21lV2d5SWFLdy9DS1FEMWdNZVNHUHRwV25vZVpsNlZR?=
 =?utf-8?B?dmJIOGdvR3Y3Mkh0MzQ3S09ydmVDSU1nWFNwSkJYYmN0ME9RV2ZsRlBRQkR6?=
 =?utf-8?B?TXl4bkZNd1dCVC9sZzZkQUpuY3ZGa0gxMGFNODliQUh3Rkk0bVZzaUJDWWdx?=
 =?utf-8?B?VW5LOENMT0QxTDZKd3MvMWI2TnYwNG0yR2cwQ2h4enN4TFJSeU9oYVVvQ05Y?=
 =?utf-8?Q?+TVK//GgQc5rPDklBF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa47244-d1e1-4e49-f9c0-08de995f22ae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 13:18:21.7908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs3wmQSN2rVmk7TJjoLgS+Sbg3oel6Up8w1EnUereBTT0aCAFCs1LdtU5yKKxhQFG8/9nXe8M+PUQ5p8jED7yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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


On 24/03/2026 6:50 PM, Vincent Jardin wrote:
> 
> This series adds per-queue Tx data-rate limiting to the mlx5 PMD using
> hardware packet pacing (PP), and a symmetric rte_eth_get_queue_rate_limit()
> ethdev API to read back the configured rate.
> 
> Each Tx queue can be assigned an individual rate (in Mbps) at runtime via
> rte_eth_set_queue_rate_limit(). The mlx5 implementation allocates a PP
> context per queue from the HW rate table, programs the PP index into the
> SQ via modify_sq, and relies on the kernel to share identical rates
> across PP contexts to conserve table entries. A PMD-specific API exposes
> per-queue PP diagnostics and rate table capacity.
> 
> Patch breakdown:
> 
>    01/10 doc/nics/mlx5: fix stale packet pacing documentation
>    02/10 common/mlx5: query packet pacing rate table capabilities
>    03/10 common/mlx5: extend SQ modify to support rate limit update
>    04/10 net/mlx5: add per-queue packet pacing infrastructure
>    05/10 net/mlx5: support per-queue rate limiting
>    06/10 net/mlx5: add burst pacing devargs
>    07/10 net/mlx5: add testpmd command to query per-queue rate limit
>    08/10 ethdev: add getter for per-queue Tx rate limit
>    09/10 net/mlx5: implement per-queue Tx rate limit getter
>    10/10 net/mlx5: add rate table capacity query API
> 
> Release notes for the new ethdev API and mlx5 per-queue rate
> limiting can be added to a release_26_07.rst once the file is
> created at the start of the 26.07 development cycle.
> 
> Changes since v4:
> 
>    Addressed review feedback from Stephen Hemminger and added
>    Acked-by from Viacheslav Ovsiienko on patches 03-10.
> 
>    Patch 05/10 (set rate):
>    - Add rate_kbps > UINT32_MAX bounds check before truncating to
>      the PRM rate_limit field, preventing silent overflow when HW
>      reports no maximum rate
> 
>    Patch 07/10 (testpmd + PMD query):
>    - Add NULL check on (*priv->txqs)[queue_id] before container_of()
>      in rte_pmd_mlx5_txq_rate_limit_query(), matching the pattern
>      in the setter
> 
>    Patches 03-10:
>    - Added Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> 
> Changes since v3:
> 
>    Addressed review feedback from Stephen and Slava (nvidia/Mellanox).
> 
>    Patch 02/10 (query caps):
>    - Added Acked-by: Viacheslav Ovsiienko
> 
>    Patch 03/10 (SQ modify):
>    - Define MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_INDEX
>      enum in mlx5_prm.h, following the MLX5_MODIFY_RQ_IN_MODIFY_xxx pattern
>    - Use read-modify-write for modify_bitmask (MLX5_GET64 | OR | MLX5_SET64)
>      instead of direct overwrite, for forward compatibility
> 
>    Patch 04/10 (PP infrastructure):
>    - Rename struct member and parameters from "rl" to "rate_limit"
>      for consistency with codebase naming style
>    - Replace MLX5_ASSERT(rate_mbps > 0) with runtime check returning
>      -EINVAL in non-debug builds
>    - Move mlx5_txq_free_pp_rate_limit() to after txq_obj_release() in
>      mlx5_txq_release() — destroy the SQ before freeing the PP index
>      it references
>    - Clarify commit message: distinct PP handle per queue (for cleanup)
>      but kernel shares the same pp_id for identical rate parameters
> 
>    Patch 05/10 (set rate):
>    - Fix obj->sq vs obj->sq_obj.sq: use obj->sq_obj.sq from the start
>      for non-hairpin queues (was introduced in patch 07 in v3, breaking
>      git bisect)
>    - Move all variable declarations to block top (sq_devx,
>      new_rate_limit)
>    - Add queue state check: reject set_queue_rate_limit if queue is not
>      STARTED (SQ not in RDY state)
>    - Update mlx5 feature matrix: Rate limitation = Y
>    - Add Per-Queue Tx Rate Limiting documentation section in mlx5.rst
>      covering DevX requirement, hardware support, rate table sharing,
>      and testpmd usage
> 
>    Patch 06/10 (burst devargs):
>    - Remove burst_upper_bound/typical_packet_size from Clock Queue
>      path (mlx5_txpp_alloc_pp_index) — Clock Queue uses WQE rate
>      pacing and does not need these parameters
>    - Update commit message and documentation accordingly
> 
>    Patch 07/10 (testpmd + PMD query):
>    - sq_obj.sq accessor change moved to patch 05 (see above)
>    - sq_devx declaration moved to block top
> 
>    Patch 08/10 (ethdev getter) — split from v3 patch 08:
>    - Split into ethdev API (this patch) and mlx5 driver (patch 09)
>    - Add rte_eth_trace_get_queue_rate_limit() trace point matching
>      the existing setter pattern
> 
>    Patch 09/10 — NEW (was part of v3 patch 08):
>    - mlx5 driver implementation of get_queue_rate_limit callback,
>      split out per Slava's request
> 
>    Patch 10/10 (rate table query):
>    - Rename struct field "used" to "port_used" to clarify per-port
>      scope
>    - Strengthen Doxygen: rate table is a global shared HW resource
>      (firmware, kernel, other DPDK instances may consume entries);
>      port_used is a lower bound
>    - Document PP sharing behavior with flags=0
>    - Note that applications should aggregate across ports for
>      device-wide visibility
> 
> Changes since v2:
> 
>    Addressed review feedback from Stephen Hemminger:
> 
>    Patch 04: cleaned redundant cast parentheses on (struct mlx5dv_pp *)
>    Patch 04: consolidated dv_alloc_pp call onto one line
>    Patch 05+08: removed redundant queue_idx bounds checks from driver
>      callbacks — ethdev layer is the single validation point
>    Patch 07: added generic testpmd command: show port <id> queue <id> rate
>    Patch 08+10: removed release notes from release_26_03.rst (targets 26.07)
>    Patch 10: use MLX5_MEM_SYS | MLX5_MEM_ZERO for heap allocation
>    Patch 10: consolidated packet_pacing_rate_table_size onto one line
> 
> Changes since v1:
> 
>    Patch 01: Acked-by Viacheslav Ovsiienko
>    Patch 04: rate bounds validation, uint64_t overflow fix, remove
>      early PP free
>    Patch 05: PP leak fix (temp struct pattern), rte_errno in error paths
>    Patch 07: inverted rte_eth_tx_queue_is_valid() check
>    Patch 10: stack array replaced with heap, per-port scope documented
> 
> Testing:
> 
>    - Build: GCC, no warnings
>    - Hardware: ConnectX-6 Dx
>    - DevX path (default): set/get/disable rate limiting verified
>    - Verbs path (dv_flow_en=0): returns -EINVAL cleanly (SQ DevX
>      object not available), no crash
> 
> Vincent Jardin (10):
>    doc/nics/mlx5: fix stale packet pacing documentation
>    common/mlx5: query packet pacing rate table capabilities
>    common/mlx5: extend SQ modify to support rate limit update
>    net/mlx5: add per-queue packet pacing infrastructure
>    net/mlx5: support per-queue rate limiting
>    net/mlx5: add burst pacing devargs
>    net/mlx5: add testpmd command to query per-queue rate limit
>    ethdev: add getter for per-queue Tx rate limit
>    net/mlx5: implement per-queue Tx rate limit getter
>    net/mlx5: add rate table capacity query API
> 
> Vincent Jardin (10):
>    doc/nics/mlx5: fix stale packet pacing documentation
>    common/mlx5: query packet pacing rate table capabilities
>    common/mlx5: extend SQ modify to support rate limit update
>    net/mlx5: add per-queue packet pacing infrastructure
>    net/mlx5: support per-queue rate limiting
>    net/mlx5: add burst pacing devargs
>    net/mlx5: add testpmd command to query per-queue rate limit
>    ethdev: add getter for per-queue Tx rate limit
>    net/mlx5: implement per-queue Tx rate limit getter
>    net/mlx5: add rate table capacity query API
> 
>   app/test-pmd/cmdline.c               |  69 ++++++++++
>   doc/guides/nics/features/mlx5.ini    |   1 +
>   doc/guides/nics/mlx5.rst             | 180 ++++++++++++++++++++++-----
>   drivers/common/mlx5/mlx5_devx_cmds.c |  23 ++++
>   drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
>   drivers/common/mlx5/mlx5_prm.h       |   7 ++
>   drivers/net/mlx5/mlx5.c              |  46 +++++++
>   drivers/net/mlx5/mlx5.h              |  13 ++
>   drivers/net/mlx5/mlx5_testpmd.c      |  93 ++++++++++++++
>   drivers/net/mlx5/mlx5_tx.c           | 106 +++++++++++++++-
>   drivers/net/mlx5/mlx5_tx.h           |   5 +
>   drivers/net/mlx5/mlx5_txpp.c         |  90 ++++++++++++++
>   drivers/net/mlx5/mlx5_txq.c          | 149 ++++++++++++++++++++++
>   drivers/net/mlx5/rte_pmd_mlx5.h      |  74 +++++++++++
>   lib/ethdev/ethdev_driver.h           |   7 ++
>   lib/ethdev/ethdev_trace.h            |   9 ++
>   lib/ethdev/ethdev_trace_points.c     |   3 +
>   lib/ethdev/rte_ethdev.c              |  35 ++++++
>   lib/ethdev/rte_ethdev.h              |  24 ++++
>   19 files changed, 914 insertions(+), 33 deletions(-)
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

