Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C7BE9B36A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A67F402C5;
	Mon,  2 Mar 2026 12:22:41 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by mails.dpdk.org (Postfix) with ESMTP id 8B965402B0
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:22:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO7z3I8k+4PlF0UNiteEjJb6XKT+vN7oltdV61rZY6f1WhJabTFK/4b5djDRhtGvRC+J91BRqGxAMZFR2YdVUe3SsCH6HO3SrtmuDW4ZNviC4BJ0CEuQ9gtRYsu/9o4cNIwUnvwck4ZSNMpd8RWibYh3u9pBu8ZLcNkrflfyjgEAtYCRpDlW5bC/n8MwQow03VeSlRKMUojBVTrpTPd6TX1Msaqeveo1m5JpGQOysrZIcqSQoRhmZynSx8iYva1vX4ZwCtbeSwvEUZxWrFzzQs1T+fNPPI6Y+jEC66RQV4Zjom87X/+6E6jmjqHML0lBg7XVbZQrpkMR0AFAyy2yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQZMa/R6OaeKT3OGwWxZK06u3To7YPus3SLBfb7/Lqc=;
 b=MWHImsnQ97vWziEo339SCrhM9WUzAWuLLFzyZY2WyM7C2t1X+OOQEqx0zVJ/WCax9VWTG2vRGzanW3uqytsQLbBUyLtg7fF6DE++u/yMbWLU7/9NJHaiQXIzjs5KX1n8xdOel3mx4pCoxALkeJ5r6XIy5LgK6AkZBQAlH5WJk/ZjXvZIe6UUcwJv0b09eXcdI4ww7/nF6X5IJKOeL1THf8OlWaoE5kZakGMPLBEcQJWL8Pbc3RLCCOKqh56A4sAJL74k8u4FS4eWC1CGg91lWpfZwoVy4YD3+Ka8zv0BXDRWn4TAdEF+a8hMzxYcp2OQEAkp+YFRnY3S46hTKNUawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQZMa/R6OaeKT3OGwWxZK06u3To7YPus3SLBfb7/Lqc=;
 b=AEkou/eltOBBfdPDYYeGeDvlHdmTHSfJ6yPYgWjV5aDQVWJcXVgPlz+waZJr2Kg5k9+Dbf/awbqZ4pfPb95KsmZGZORsRPPe7/8+SbIVW9Cl5Z9IqSULSI63u/OjI42j7Tk9DMgBV7Ph0L3Koce5P8F7ybSr1zGQc1C7Wvu67D2CQMskQoNE/AXzCgIWAhL8H+0TvVBu+kpql++eZDAmo2bK5RzvPWkc3t0zYPOZFA08VRhCszeY6XbQsO3sVOCU1cU5yal6X1MIJWvRxSVi4KWMzNedqdYFcNjdaEr7W/ew9bSi0beqm3D/veeAjWbedEV+2j+paCqiVml2TCnsfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 11:22:35 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 11:22:34 +0000
Message-ID: <4293b0b4-9f2f-4bab-840a-dbc05e95f95c@nvidia.com>
Date: Mon, 2 Mar 2026 13:22:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net/mlx5: lazily allocate HWS actions
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20260225115918.233843-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260225115918.233843-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ecbaef-f0c4-4e67-e4a3-08de784e0075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: KWpBbDnw144GZJTNUG7BDn4+X1owj96dTTLnFkIJAUQNZyYl8jPOhHEw0eZVwPupk1mRlDYdOBlkzxlX092Mfvs3HGacf8jf7brnqmXf+L9/qtc1wqyFlAr+Ak77LrksonHmPglzJwQMPnYLSVan3I86jCqEd4JTcX6hpOPpVMILO+Un2F2ydAuZvT6gjfwT12ZFH/7MhZeE5LmgI/GjDruGdDKbXRLUxVjFex7gMGY/0Kcj0S6K3ZoqcJGlRkkDc8UiXffy09Yc4Y3VcIvXNAX/xtxjaTSnx77+J6aQTKDjghraWsFytapqlwvp9Z0QF5weWI8g87utFQyyLCtJIGm1PR5IjfAcQ1wNxooVEW1j8B7st3kRaYfXHiXoeKLwZX1iYIE6zo1t0tg/g0QBH2k/OqK1MsWtNNXFkYQXwXCOmPBhBNfRWNj8rRd2J3h8DDsRnXNjWOQBSToRKK/KEdryATK18bA0j5z8NkR5ruF6CVNEzObEg8rvWYxpY4A/n8+sD85T1tyK1BAodejpYbXeWbEniqE6DGyocmLU6CaD9SPx8JZXtebADIDsDyqJ67Wp0JIsoh/fvfD4kVPmeVGigca6WTOGQ6d18oSCOG9aLEdGOqqju5uWumk7im4UL6EUslX+fAxhFjL9HUj45Gc+CjxRq9DTwuRjdDNYztcNVaxt1Z+t8OL7NUS2mFVbCPTdKPxEwWWYI4OCWOIEfGFNqNmassbffA+W1biAEx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lmeUt4MVg3RXhNaTlXbklIbkNhdXlhd3J5Wm5HdWlFZGk0Qk5TOXQyWHpI?=
 =?utf-8?B?aHltNmlDNjhHRUZ1VHJJa0ZJYVloRjgrVkdCcXNNSWpPTkEzZUtDd2xuZ2JZ?=
 =?utf-8?B?U3ViOWlLTVpHMStWQXU1R2JuWEtVaWRJMVc1TGVZN3RxeStrOE9qclNwTFZD?=
 =?utf-8?B?YWdoSUh0aEpRSlliT0luc0pUS3B5WE95Zk5WdnMvYmZDU09RcnhDb3NHdDNj?=
 =?utf-8?B?TFEyM2pvaGVxUGxLMU16b0l2bDkzUEg0THNqZkpkeEtoYm9lWGxlNDQrNm9G?=
 =?utf-8?B?VHZoenFFMUJma1VHSkU1RmxORzk4WVZvaWxGTUE4Vm1qZTZOaGFIMTZyMGNG?=
 =?utf-8?B?b2VRSGlZT2VVM0R4bDJ3NkxkWWxERytuN0JjUGs1OVFPYVNSSjVKS0t2ZUNv?=
 =?utf-8?B?RFVaYzRVcjd6OWxkTHpuemp4ellMaVl3Ym1hUzBteW9TSjIyU003QWo1MU4y?=
 =?utf-8?B?dlgwaEJBR3VCcmRSZlllS2M0TnpUN1BkTG5ielJuNVRyWjV5SkdHYWc3V2xD?=
 =?utf-8?B?OVdVTG9JaU1WNEM5cmZZWU9FcUw2SVYvaGtrSU45bWozbkxmSHcrWUFRcG96?=
 =?utf-8?B?NEM2ZDhGcEN5RkZpR3NTZ0QyZW9XMERuUExWYVc1L3hGNk9XcjYwTmlhTHdO?=
 =?utf-8?B?NnJIUlhvWFhlYTlJeHU3T2Zjb0FIQlRXS1FYY2hER0MyYVFyN3NEd1VtZ1FR?=
 =?utf-8?B?bmJoMkFub0U1V2xaemVTV0VnVjRzcW9QckVsWDFQUERDNU9HWmVJcHZZSVV4?=
 =?utf-8?B?bzRTSWNLeldpS3Z1K0VNdFQxVmUvc3YvODdBM0VuM3d1clZNVEpqQmZLMzlX?=
 =?utf-8?B?THMvZWF6TkJ6ay96UHQ3NEgyRjl5V1U1YjRJOE8zTVE3YjVzVTJ0L2RPR2hj?=
 =?utf-8?B?MHR0ZmhSNnk4WnVSZmUvRFJrd0J6ZE0yMEFYbmlEUEZYd2ZGWWQwcnBFNVI2?=
 =?utf-8?B?VURvRHlOVmpidHh4dEIrZSs4Z0NSN0xQRHpOTmNxd3hMamp3MitWTnNoRmlv?=
 =?utf-8?B?eWQ4dTVaQ3g1eWNvd2YzR3hhRWxJM3k5ZGJBWFRIVzBLQTRnQnd3T1NkOGhT?=
 =?utf-8?B?VGlyaFhndm55MlRVUC9sTkdBTHhGNmdMeE5CUFAvcjZGbmhtTFVzTHFMR05S?=
 =?utf-8?B?TW9ORy9SZUNOMktHVUlaNXJvTVorTDJnRmUraGx2cmQ1WHJFSFdYYVVseGNU?=
 =?utf-8?B?UGVhSms3OG1ST2JZbnJwZXVQUDJBeUQ2dENCRUYrNUhuT2dCcXlBeXBpazU4?=
 =?utf-8?B?eGlycUp2eWVpRm4rM1M5UHUyaWhCNTRVU2xlODJxZmpUZGxMTHNWT1dYbU5O?=
 =?utf-8?B?ZDVmWjNPSkw0enlGczAySGpyMHZkeFhZb2NJK2F6d25WRnFVbWdGcDlFYXFk?=
 =?utf-8?B?S01oS0tBWHcrV2hxWHNCYjY3SG9hV0VJTngxd2owaCtXOFJZcGxDUG5FOEdM?=
 =?utf-8?B?cGNMam10MG5JWmpvOVM4UHRscEowallXOWhjeE14OFBXRGs1eG05d2hRb240?=
 =?utf-8?B?dHpMWVFJWlhodVhwSEYwQllUd1NId1AwNjhOUXpiemlhOE5Nek81VWt6L1Za?=
 =?utf-8?B?ZWFsVkNWb1pUV2ZYTXdhMEZkdGpzcXN2VEFvSjNBY0xNS2ZGL0FnOUlxVUEw?=
 =?utf-8?B?MTREaHhYTnZaUmZTYjdSVXdnUHZIM0pxRXdrbW5jT2FmWTNVaVlPaFRYaGs0?=
 =?utf-8?B?ZEY3dUdrNlcwdjRTSDFzdWo2NWJMYkIyMlNhZWdQc3JhUk91dmhlNFVUN3V1?=
 =?utf-8?B?MERkUWFyLzJBOFBMM0dEaFczbWRYa2wwSWxmTnlZTnlWVkxqeUJDYUFpVWtn?=
 =?utf-8?B?NXFVR2oybFhVM043WXhxdzU0OTZxMlYvV0pyMlNITEQvUTRDTHRFZ3c3L3BC?=
 =?utf-8?B?ZHZ2NDUvRkkvOTVpL01MOXlyZnpYeHBWYUtZMUM0SUE1SkNzMmt1a0JPaHV5?=
 =?utf-8?B?VlIvU3Z0bGNDa3BuSk4zUFNxK1MvK1dDVFd6T0JaejNBTGlVYjRRTlFMV2pr?=
 =?utf-8?B?Q1E1a3hSQ0JScG1iemYvcEVnanJpRlFQem04c2FOdzN3Z1FsaXJoajFOZkZh?=
 =?utf-8?B?ZDJmZFd3ZjVRV0V0b2lOc0tqNmx3bThLMnl2Q2VxNkUyYkN0UFU2Q3hUWVJl?=
 =?utf-8?B?TWFWa015MG1aVHNleHBSTG1rWlUrUXliUnNuNG9USTlwQUYvM1hOdmUveXNj?=
 =?utf-8?B?a2ZCZE92SzFwYkgrMC8wWG1oczg0Rk0rS1k5M2NoeG83ZGwrdzhxM2dOcmVj?=
 =?utf-8?B?YnBaMmRtbWprTythaXcxbEZGTXdScmdqL091T3BEZGVsWXVVb1pzdG5LWjVS?=
 =?utf-8?Q?oH1VSXuvA0iKV0ojCx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ecbaef-f0c4-4e67-e4a3-08de784e0075
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:22:34.6776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxIYqju+pk5JCkPLBtsWIkyRkmXDUuA2IwtfQAIPf+FDMVGWTiCgYolrylUFONAzLALzH6bBA3fQHE1BDOyVHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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


On 25/02/2026 1:59 PM, Dariusz Sosnowski wrote:
> In mlx5 PMD, HWS flow engine is configured either:
> 
> - implicitly on port start or
> - explicitly on rte_flow_configure().
> 
> As part of flow engine configuration, PMD allocates a set of global
> HWS action objects. These are used to implement flow actions such as:
> 
> - DROP
> - MARK and FLAG (HWS tag action)
> - OF_PUSH_VLAN
> - OF_POP_VLAN
> - SEND_TO_KERNEL
> - NAT64
> - PORT_REPRESENTOR (HWS default miss action).
> 
> These actions can be allocated once, for each flow domain,
> and parametrized on runtime.
> Allocation of these actions requires allocation of STCs,
> HW objects used to set up HW actions.
> These STCs are allocated in bulk to reduce amount of syscalls needed.
> 
> In case of global actions listed above, these STCs were allocated always
> even if none of the related flow actions were used by the application.
> This caused unnecessary system memory usage which could reach 4 MB per port.
> On systems with multiple VFs/SFs, memory usage could reach couple of GBs.
> 
> This patchset addresses that by introducing lazy allocation of these actions:
> 
> - Patch 1 - Redefines mlx5dr_action_mh_pattern to use rte_be64_t instead of __be64.
>    This is to prevent compilation issues when mlx5dr.h is included in new files.
> - Patch 2 - Add helpers for translating HWS flow table type to HWS action flags
>    used on allocation to simplify logic added in follow up patches.
> - Patch 3 - Introduces dedicated internal interface for lazily allocating
>    HWS actions. Drop action is handled first.
> - Patch 4-9 - Each patch adjusts one action type to use lazy allocation.
> 
> Dariusz Sosnowski (9):
>    net/mlx5: use DPDK be64 type in modify header pattern
>    net/mlx5/hws: add table type to action flags conversion
>    net/mlx5: lazily allocate drop HWS action
>    net/mlx5: lazily allocate tag HWS action
>    net/mlx5: lazily allocate HWS pop VLAN action
>    net/mlx5: lazily allocate HWS push VLAN action
>    net/mlx5: lazily allocate HWS send to kernel action
>    net/mlx5: lazily allocate HWS NAT64 action
>    net/mlx5: lazily allocate HWS default miss action
> 
>   drivers/net/mlx5/hws/mlx5dr.h              |  19 +-
>   drivers/net/mlx5/hws/mlx5dr_action.c       |  26 +-
>   drivers/net/mlx5/hws/mlx5dr_pat_arg.c      |  20 +-
>   drivers/net/mlx5/hws/mlx5dr_pat_arg.h      |   8 +-
>   drivers/net/mlx5/hws/mlx5dr_table.c        |  75 +++
>   drivers/net/mlx5/meson.build               |   1 +
>   drivers/net/mlx5/mlx5.h                    |  21 +-
>   drivers/net/mlx5/mlx5_flow.h               |   1 +
>   drivers/net/mlx5/mlx5_flow_dv.c            |   2 +-
>   drivers/net/mlx5/mlx5_flow_hw.c            | 557 ++++++---------------
>   drivers/net/mlx5/mlx5_hws_global_actions.c | 273 ++++++++++
>   drivers/net/mlx5/mlx5_hws_global_actions.h |  71 +++
>   12 files changed, 611 insertions(+), 463 deletions(-)
>   create mode 100644 drivers/net/mlx5/mlx5_hws_global_actions.c
>   create mode 100644 drivers/net/mlx5/mlx5_hws_global_actions.h
> 
> --
> 2.47.3
> 


Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

