Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9DAEA7196
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 11:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DD3D40291;
	Sun, 19 Apr 2026 13:14:38 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by mails.dpdk.org (Postfix) with ESMTP id CCA7E4021E
 for <dev@dpdk.org>; Sun, 19 Apr 2026 13:14:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHkEmSISx+AwoKKB0gPdTsD8pkJSJR8kNjQloOOxNT4p9s9ZYUd8HD1TcgI1V1JQxlxU5CzWxvx4EJTf5MLNDj82ea40IuaVAcKtrasgMYl5fTiMHEmIqq2LHw+63ZSoIgRv1VjT2ONrJCrf+WCXVlqhOWx6Ki1lqCYkNBluBtLIlm5X4VQ2ZygA8wzuM/l3vGB2rYD8AM/9kiKvX2fC1HbpNI93saq12xeUy75/q6jPBtmU9IVOqIcb9DhaGRXfpn1UjvQFqhzD1mWUAw4nR9C/4nK9RnGEMjI2jPzZFbE7UY6DfYd61Urj31aBzZyAE8le+UjGtdhgb2hPoDFc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvbQruk4uL55WBnvUbmoikoIbR0JIurVQeGXt/MHae4=;
 b=aJu3UG3pzgsqdcxSZfSbZAnw2NSfeq/vGzQfN2LM8Ag9HDfINmNX3zbRnMYrYQh+OhU4aXyV8iDWAByGw7gy5fjjp2nkVWzrmseeVK6FLEr8rUdrOzS8PycmgpYYhsZnjUBQqWBUoPXuAiOgactzpPskKodLdP/oaw+thcSFiXo2dn6ubaFRyMLUgbqkjcQ2wBJlgkgEMqrkg15CJMchyek2JHuMqO4ktrh89VRq5rI6yE49Q8b68hJ3wae+AePvzD361h5YenYP7ZQE2zi1u1qz41KuwKUlLkH7JMsjs2eVqx9altFsOT910kAOQlNHIUCbgBLxNIw8yp+vRF7XfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvbQruk4uL55WBnvUbmoikoIbR0JIurVQeGXt/MHae4=;
 b=AXlzed1NcmqO27bRpZTdaN2IBwEaoatuz0qcD5dCRwBVM7XiVoH+wHZTc7n+68sUUj2jrI77oi/GAhHe3kJTJ376xQlmTUETHLFizkQtrkSin7o5lkdXWkx02Od+er40xo5Wx9cLG8339yCCJSyRGfoNfx1hXHzsNFXVRb6KWfEpSB5p19LH2/PT0LjR91Tus7rqrVWtX0PBcTiCZUx/Wr7+ZaYrHY+nl/42bC+U7ql9FnbpB6uaGHg+h9hZvCBOmiR9MOXhYQcXHMk99xb/uf9CLDorIh90PVa7cGUfjVRFej0crqyJx6ENyudYm1orhAMjRAyWR8CdDWyLGr27Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Sun, 19 Apr
 2026 11:14:32 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9846.007; Sun, 19 Apr 2026
 11:14:32 +0000
Message-ID: <e588c722-7c68-44de-a8d8-315cd08fd3e0@nvidia.com>
Date: Sun, 19 Apr 2026 14:14:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26.07 0/5] net/mlx5: legacy vport match support with HWS
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20260325090758.42403-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260325090758.42403-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 2799cef8-b011-424e-3d6d-08de9e04d4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: OUwFUj8i0rCNaF0FXCCtG5SpTojX9ueCL9QgllGVHBf1y+bUE5i8cSwB42Ran/n86amsxoIZiq9gZaGV4KM0E6KMIKMDzK3JMKZa1DAFgcP/ZQrGhNqQ0AHdx0UvEluirjBITTexi6f//amqb8qXvfFty1ZIg0Rk2cHZVxqWThxRvMR5u5FhDKJrVq3WInp7w5IUBCSmInDdZ5tYJ4+TqRB1IkSGOHTfswayfy0QOqys1ptXck7a97EqxDbscr5mu5GkuUKr2krNTMmuLVuIKEVdGcOMqoXB+KpVl1sxy2JDsfNBwtu4sg3uSxmG36DJAsZSUyDF1wmdhplBWGk1vXHAUaIAWkPGt8r5Nbc8h1Njeu1Jaq+3gFNsiG5SZue0T+t28fVwD9tmKFtTdb83nFuHcMGxrOygtmZrUINGKaWUndZUy35oV9JMkzjYWIRYlXcOSBER6LoRh/zdnvfYbOf90qw+ex6TUPwibHxyFX0QrdHw+GE9RaCto7Qy5+5zo0iTMqV8WDlu9oOBefNoJYsIP83OEBXzR+QvOG7C3NWmHc3t3YPU/yvaufKO64ehNhDJ1XzypZkvDBTNUjfYrxwFK0UHfi0aO1jV/7ilg4K5KRukHu9vWROBvtZKvQzypmce9BGGrD0vLPrKaGFRTavWdqhMli+rq9H0jLKtT2L/ay4MuL624XGrN1EiVNk7U5tvGTFRUHbT5Ceivp/OwA25/WipshnRf9DWwTCL9IRi1MQFzEZTAW32gKkgNUjx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXphSVpjanowbk8xdUpuSDRGaDlJSHVrZE1XOHozUDlKTUt3YytvV1JHVDZn?=
 =?utf-8?B?eExSTUh3ckswbUZvSTRiSmx4UXFGeXpVSmdOWDAvQS9tMmg3SktxQVdQZnl3?=
 =?utf-8?B?ZTFoR1ZSZUpJN1dsaHFkZU9VV3F2YWhiK2N0U01kbVVtenBqbHFtUUY3dG1v?=
 =?utf-8?B?WmJ3SXhTMHZ6RHhPYmJtS3V2alcwZ05UcUhPU1lpMjlXbzNvR2ZYazd5bU5X?=
 =?utf-8?B?UUtlRm1WUlM2SldaN2I2bm1aU0NaMERpcnB5QWhBUklMUmwzUm13RGcwcGR0?=
 =?utf-8?B?cWQybmJobnU2NVNUeUNYMGwzK0Q0UFcvSlRRanZYS1ZxRUI0c2JpeE1XNGxu?=
 =?utf-8?B?U1RyQ1FuRk83bGE2QXN0MUM0NmU2SFBOdzlEZFBiSS9QYkhKaEIrMHBqTGt1?=
 =?utf-8?B?eTljWmhsSnN0VW1xdHlkSVhMbjk0V1J4VXFTT2RQQVJpNlRqR21GbGZiOEI4?=
 =?utf-8?B?ajNFNWh6cjVUVmllMnhrYXNZR0xydEpzaGVjM2NScno2MGxJZHBCaDRXVXJY?=
 =?utf-8?B?SnNQRG9HazZQdCtRdjRRT08xb2pBMCs3OXNNUzZzRStqVkN1Ulk2NXhnM3lY?=
 =?utf-8?B?WlhvY1prQ1RhbmN0UGRPZ3ZHaHdvN0pySmdueVJ4S1poTVRoU0NTb0lkaHov?=
 =?utf-8?B?eHNVVTZyeHhDSDFZanJJNzBHM2dGNDNpODY2ejdpL2xjT3RkMjFVdXgwcmdI?=
 =?utf-8?B?VlhpMzBxRGsyRDRMczNpcjJZSmFWZ2pORVVHQjVBTEVoTWpSa0J4clo3QlNI?=
 =?utf-8?B?MnJCRnpHa1Y4V0tkYWlTajBrN0FkWml0TkRubEVlRVdLVm10RklRUmdZalI1?=
 =?utf-8?B?cExkQlZzQytFU3lyWFd3ZXpUSnNjck83UTRhNzNSS0FBYWNWRnR5Z1QxclB5?=
 =?utf-8?B?REhUWXdUYlZ6NTIwaXFQek8xNVg5NnFwZjNjR1pnTmxuazdoYlBpS3dWTHph?=
 =?utf-8?B?cDYxaDdSSis1TW1wSFluQm0wN0w2dll1bWdTaVd0M1NRYU14bVpNOHM4dWVs?=
 =?utf-8?B?RWRNRWo4c1lXa3QzSXJqbHlhM0FjSGZCUnRReW93UGNNcXkrNkV4UTNWb1U5?=
 =?utf-8?B?OVljS3BJbGNlb09zMDh1bTVFS1pFelc2dTZBZkxmdHRTWlpnTEhURkx4S1ZR?=
 =?utf-8?B?cHNQUzFFS3EwMEJlNUlQeFRuYjNZZ2tMNjhqSnFqY0FoazlkcW1yZURPZlBw?=
 =?utf-8?B?Vy9FcXdQTHR2Yzc1dzdyVVEyQjRqNGdTNDRyN0ZvbTVSUjJidGtYMUw1ZTBX?=
 =?utf-8?B?L1NZNnIxWDUxVitUS1JXTG05MUZEbHJwdXBrQnZGYmQ2UXNZOW5iVmZHWnVG?=
 =?utf-8?B?LzcwWDk0bXdUVm4wMmZsMUI0dUNtNTZOWUw1QkIwNWF2ZmwyYmdIc0NsNWw5?=
 =?utf-8?B?dElmRkt6ckxhekl2WUJYYnFyK09QTjFFcXFtbm9GOWxFQ24wSjMycGVyMk1T?=
 =?utf-8?B?NjF1N3dYV3p3TThBcFBiRWYyeWMzeEc0QVUzdlN4TVU0SmUwWXhWZlFnWEZh?=
 =?utf-8?B?dE1QMEtqUDg1OS96R3BLYnE0L3F3UVRRdFg2N2tiRzBLVytCUDFyc21RNlJ0?=
 =?utf-8?B?L0V1UzNtMEZLZ0RadStha2J1REx2RVg2bjhBS0pndHhzK1hOSnBmd2haYit3?=
 =?utf-8?B?RWxpK2czSGtJalF1QXNYcGpBVDQySXN0V2ltdnU3WEZKM2k1ZnlBQStDVm9D?=
 =?utf-8?B?MkpqRkVPL2laanVhRnphSUlEcFgvNC9YTjR4ak5CYlMvNjlVeis4UjExSzVp?=
 =?utf-8?B?MnhmUUlCd1Rnb1FmUDVhdjVYdXU0RnM5aEVxMXk1aVdqR2hQZWhxdXE2RFgw?=
 =?utf-8?B?NzBvbUxMbVVGK3FCVlNEbXZlY3cxNFJsU3ZUWkFCa05iM3k3dnh5S2FKSFNr?=
 =?utf-8?B?VWNUN2FxUElHdFlkUEdnTXkxTDhYVGExL1FSQzYwVURCN1JxRUNEZE9oOHlq?=
 =?utf-8?B?WnFrQ0x2TCtHejE4cS9Fci9IdzBXVEgzeVR1VWNzVFJaa3JjU0xzbk85K3VG?=
 =?utf-8?B?S3M2U3pFeUREWUxWK0p4TTl6NENMb1ZQNlBQSGNaOHdqTHdjcFVFdDRGcVZW?=
 =?utf-8?B?cEtIRFZ0eTh2V3hGVi90eEd2ZEZVOENha0NhWVBsZ2IvVDcxYzFYQStaVWk2?=
 =?utf-8?B?QXVDSHRNejZCTlZMOFYwVG1mdTBJcTV5bW5mRzdkSlc2V3BvSHUrYUM1S2Yz?=
 =?utf-8?B?eWZGSXcyZUR3TEJhVFRaNEJCcDB5czFuczhVRTNwajl0R2xXNmN2TE9sMHBW?=
 =?utf-8?B?dDFyeFBZb2FsRG9rT0hpT2NoUGhFNEcrOVVtbkp0cERVaWg2U0ZhcGVmeFBi?=
 =?utf-8?B?RUN2YVhHc09KRFBpWTEwUlFUNk5vQ2ZkVjF1WFpiQTBHNkdsYnJKZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2799cef8-b011-424e-3d6d-08de9e04d4e1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 11:14:32.4278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF1+iL8JlLdb1EKt9JnQ+Pd4CNbhe/UvehwLKFyZQyoit2LveJOgypEdZJ+Q9uXlbG8JKz3NwO8XvCPLWYzv1g==
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

On 25/03/2026 11:07 AM, Dariusz Sosnowski wrote:
> NVIDIA NICs and DPUs have an embedded switch (E-Switch)
> to which all associated functions (PFs, VFs, SFs) and physical ports
> are connected through virtual ports (vports).
> mlx5 PMD supports devices with E-Switch enabled and
> also exposes flow rule offloading to the E-Switch
> through transfer flow rules.
> 
> Flow rules matching on vports (with flow item REPRESENTED_PORT)
> can match on specific vport using one of the two internal mechanisms:
> 
> - vport metadata - E-Switch internally tags all packets with a metadata value
>    associated with originating vport.
>    mlx5 PMD can match on that metadata through a specialized HW register in each flow rule.
>    vport metadata enables features such as VF-LAG, Multiport E-Switch and
>    others mentioned in [1].
> - legacy match - A static value known as "source vport" is assigned to each vport.
>    These values are not globally unique, because they are statically assigned per E-Switch
>    (e.g., VF0 on each of the PFs will have the same source_vport number).
> 
> Users can select the vport matching mode through devlink [1].
> vport metadata matching mode is the default and is enough for most of the use cases.
> However, internally tagging all the packets with metadata values,
> increases the packet latency in the E-Switch. As described in the linked kernel docs,
> disabling vport metadata matching can increase packet rate up to 20%.
> If features provided by vport metadata matching are not required,
> it can be disabled to increase E-Switch's throughput.
> 
> mlx5 PMD with HW Steering flow engine enabled, only supported
> vport metadata mode when running on a device with enabled E-Switch.
> Goal of this patchset is to enable support of devices with
> disabled vport metadata matching. This is purely an internal change in mlx5 PMD.
> No changes in DPDK applications should be required.
> 
> - Patches 1-2 - Extend information queried from the device by mlx5 PMD
>    to include information necessary to implement legacy vport match.
>    This data is always available, regardless of selected E-Switch matching mode.
> - Patch 3 - Adjusts internal translation of DPDK port ID to flow rule matching data,
>    so that returned data is always valid even if vport metadata matching is disabled.
>    Also adds detection of vport matching mode to HWS layer.
> - Patch 4 - Adds support for REPRESENTED_PORT item in HWS layer
>    whenever vport metadata matching mode is disabled.
>    This involves correctly translating DPDK port index to "source vport".
> - Patch 5 - Removes all validation checks from mlx5 PMD which prevented probing
>    on devices with disabled vport metadata matching mode.
>    Adjusts internal PMD logic to work with "source vport" whenever needed.
> 
> [1]: https://docs.kernel.org/networking/devlink/mlx5.html
> 
> Dariusz Sosnowski (5):
>    common/mlx5: query vport VHCA ID
>    net/mlx5: store port VHCA ID
>    net/mlx5: return port info regardless of register mask
>    net/mlx5/hws: add source vport match in HWS
>    net/mlx5: allow legacy source vport match
> 
>   drivers/common/mlx5/linux/mlx5_glue.c |  4 ++
>   drivers/common/mlx5/linux/mlx5_glue.h |  2 +
>   drivers/net/mlx5/hws/mlx5dr_cmd.c     | 13 +++-
>   drivers/net/mlx5/hws/mlx5dr_cmd.h     |  1 +
>   drivers/net/mlx5/hws/mlx5dr_definer.c | 99 ++++++++++++++++++++++-----
>   drivers/net/mlx5/hws/mlx5dr_definer.h |  2 +
>   drivers/net/mlx5/hws/mlx5dr_table.c   |  6 ++
>   drivers/net/mlx5/linux/mlx5_os.c      | 38 +++-------
>   drivers/net/mlx5/mlx5.h               |  4 ++
>   drivers/net/mlx5/mlx5_flow.h          |  3 +-
>   drivers/net/mlx5/mlx5_flow_dv.c       |  3 +
>   drivers/net/mlx5/mlx5_flow_hw.c       | 34 ++++-----
>   12 files changed, 140 insertions(+), 69 deletions(-)
> 
> --
> 2.47.3
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

