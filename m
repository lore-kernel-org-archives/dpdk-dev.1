Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70DCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C117340262;
	Tue, 28 Oct 2025 11:42:06 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35]) by mails.dpdk.org (Postfix) with ESMTP id 993DF4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:42:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbdbaWT52pWlctSePTDcSJqmMQwC3aPMJShAH2ApxYSxk2MMupdCGFDCmmDvQaCjJJvmHuHg1tTfKRcXETosWC8fVAIRLJuW22GoJsi2p0PuB9Sok7ws4UvsOI1Wuq/Wc7XPakaRw/EQVjnvNOmtZSAYvOB7CyA/jYZBC12e+qWQMH8k0iT9pmgmGZ93Q/qPlCXBxn057HzIwVscCogpuKWZp/oODiZVG7myX0WGoA2T1o80sJfbIlaKD39jE+JykliLigBuTKe9+AWHzBT4XxmbiZtk7qnRDRij6ZBro/jbKXgl8Pq/nV3auGQZGOBCT2jwdCqGaxSQt1CFr57d2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfdZa3GE99xr4IUtlQADI7jmArtSovkK82wOHVfzeSs=;
 b=BRPbM1hCiAiOtFbB1JjI8kO0PuuVSYgU3Z3pbvegvw7BFjNsdHpWl5/SPsSfxNf4SVT5VFF/twmaZO9qUx97mQIT9I9wQNNFO7FbbXn+0Gku7Hw/z41B90TdM6Y4TufxiUwU/zDHbD4gYHq2F0JRRgJoP58LC436UV23nTljDr0OwHWUJiawKY4B+Atq/ITl4vVTLAyRp5vVpFg3mVvTTmZLEaN9e0B+uIOL5Dyw3tKb4y+gGrvmqGi8uTezyBLGQ3sdacz1hECjIgFF15xoCKoRT7/E5LZdYLjRgtYtqapP4b5yEcjLzwYsGZuGEAZnzOsEb6KeLQX3LKo30eP3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfdZa3GE99xr4IUtlQADI7jmArtSovkK82wOHVfzeSs=;
 b=iEVAe0RHfFKVBtwDAyqPTVCF1kyOtqXxTcHdvgEp21pXf99k6UDty1sylj+dKKaVCBWmlEtzRuFV4bf/hg+51zyTHPQH5idUpgZmQZtyGet9o2fLbblgSkO+juz9W9DP+E5SSxRO+zX737xm8LWFqD7Tqpj6E3SDPwLVSNlvSy/vD0ng4bq6awI6mUN25DjybXVeFHxJTQuOvna0XYwxiRcqg+DCdZ0HlnAuZdWVTwbHCwt8E8jhqAb/OitUQ1KYB5vzd8ppz3Fg/UoApcBGxlUL/elHkCd2KYYes4GuONpyFpXaTbHrQBD54xf8CSp337uOmGNYWtt6S5hyARS43Q==
Received: from PH7P221CA0081.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::33)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 10:42:01 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::e) by PH7P221CA0081.outlook.office365.com
 (2603:10b6:510:328::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 10:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 10:41:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 03:41:45 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 03:41:44 -0700
Date: Tue, 28 Oct 2025 11:40:39 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: <a.schollmeyer@syseleven.de>
CC: <dev@dpdk.org>, Michael Rossberg <michael.rossberg@tu-ilmenau.de>, "Erez
 Ferber" <erezf@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: store rxq MTU at allocation time
Message-ID: <20251028104039.7lz53rweay3i4c5c@ds-vm-debian.local>
References: <20251028095502.1CFB21261CB@dpdk.org>
 <20251028100144.36284-1-a.schollmeyer@syseleven.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 60638078-e89c-4871-844c-08de160e9fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mKETl/mDZ8p2lgmd6VUgXcSaFYiDJNvFxCF4K5PHnYjn9AmhkRN4ibjY+U//?=
 =?us-ascii?Q?ZTpUtw83hM3ZWQt+AHz9fWSPZArdLxLcZBslbvjZbK4y+wSmaD1YYDEnkmAd?=
 =?us-ascii?Q?l0z85LSrnLtcCgn01vTOiETxUK5QXpJSfaUofHiBMpKtzkfoheFKazvLXdkQ?=
 =?us-ascii?Q?QhbBiDDozVj+0zrITbHtlGOYsL7yhx3nsSIwzKT1xh04ukJhsvrFBUYAYrvA?=
 =?us-ascii?Q?reSd+OzA/CsYqsGdQh8LT7K9satwDxz4euxEv1ufiE8OM9UZs78tWcRFrb2N?=
 =?us-ascii?Q?715wCM8O50zhnwN8KsO4/aaz8D7zMF3II3kHmTEp/2dH7MaUEjiSWlD061NK?=
 =?us-ascii?Q?jrmf/lHGl2uwchJ7IG9WNJ29n7WOMyzG54pDPX3pOZzrQ5WxRQC/+PtfYUYo?=
 =?us-ascii?Q?9Y2ehciWYT0r3RX9WWrQx9o2rfF1W54WXtjfVJJPb5rBjp/gxw0aV9wzKNi9?=
 =?us-ascii?Q?d/2IAZ7Ey4yJ9Ngvmzs3pyKWIbDMaSwvhj/O2ChLNx5XopHlCMsnDkR1NPYz?=
 =?us-ascii?Q?Ce7mxTjil/J5m1MB7nZxuUYYEngVAb4uld5LJjCLqe2aFgmtjtyz9OisE0Un?=
 =?us-ascii?Q?JGIO4zApUAPGX8n68JJUCBVteX3N8PFwLU7m0PjVm3jRjc0T9/juHVldI0g4?=
 =?us-ascii?Q?uIdMnyEgXvyr0WmTINJlRdqqh+OW6OwWx4ezooreyXFgyX2Bi5BPKhOko0u7?=
 =?us-ascii?Q?YOUAY5DFGbJdQUoOeZJdE84sNj+sS4yl/QJTdRHymOgWhPI0vk1a55pUUpjJ?=
 =?us-ascii?Q?M5AqE6ei9SuGmRF5UV3aBzaFAISkUj5dAU15cvPuIdQBMG8uTSdvOAxtB1+x?=
 =?us-ascii?Q?iynwvzj2Y3RWIgKseL5lgsLyd7pC3nAEgtsyAAqUbOpQB3vosVzzNIvocjoz?=
 =?us-ascii?Q?Z0bqyavD2/UlmNWWrE+YgFajzHSc5Me8B+XEK0EEEYrj6cXas0rX5RcK1MKF?=
 =?us-ascii?Q?7tnHIIJnd+IStRpKDZXSKp2/3fyLqMTfyrSpOzaVOgpaPobcJNXevqLLpSV4?=
 =?us-ascii?Q?gamvI7hj23oii7Qxl6049pnyLbdV15ZrFJ42AoKKW5B8fgXNOwVSwFpBjzhh?=
 =?us-ascii?Q?dojwBUeDYSNtlKBeLYzZV9p6qz2DgliPthZkwYHwWMxnKmPQ1v+SJst+FccB?=
 =?us-ascii?Q?nCdBR7VSmfs0BT/qDqKpE/v44Yhw12MV+UOFOsob9YYGRVU5VEoOCpwF9qIH?=
 =?us-ascii?Q?bIGDn4o/zuTKPh418EmbvRKi3LApB1ADbsgfH/eguxMMVPsiFNVy4XG4akKE?=
 =?us-ascii?Q?bSkuxJLksy/Sppfh/nVXtSQwyI3ivsGarHL24diGOjcNncWN/m4j+pskRYys?=
 =?us-ascii?Q?b9aI/7NQW25UvmqZIrAADL8ryHNPRMFUbvYH/WXjAmlGVxtjDwUitWPne8Qx?=
 =?us-ascii?Q?Pivn4r8uTlt8/TRB5Q5VGdbmzSf9skFaspat37Sq4o+5k34aANINcEPwn5gd?=
 =?us-ascii?Q?JbvwXbEpKEzrgSxyeVogdUYfVj6u9+wUG9w6AMjgJE/CL7p7zoFofByzogGx?=
 =?us-ascii?Q?KXxsLmqq73NNqIW40k7iWWqX9NgZQsU04rsWVCTAMCK73AAnsQLEIuNxuMXy?=
 =?us-ascii?Q?Io1EGyVp49bankAVrNM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:41:59.7370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60638078-e89c-4871-844c-08de160e9fbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

Thank you very much for your contribution.

Code looks good to me. Please see a small comment below.

On Tue, Oct 28, 2025 at 11:01:44AM +0100, a.schollmeyer@syseleven.de wrote:
> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> For shared Rx queues, equal MTU for all ports sharing queues is enforced
> using mlx5_shared_rxq_match() to make sure, the memory allocated in the
> Rx buffer is large enough. The check uses the MTU as reported by the
> ports' private dev_data structs, which contain the MTU currently set for
> the device. In case one port's MTU is altered after Rx queues are
> allocated and then a second port joins the shared Rx queue with the old,
> yet correct MTU, the check fails despite the fact that the Rx buffer
> size is correct for both ports.
> 
> This patch adds a new entry to the Rx queue control structure that
> captures the MTU at the time the Rx buffer was allocated, since this is
> the relevant information that needs to be checked when a port joins a
> shared Rx queue.
> 
> Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")

The offending patch was part of 21.11,
so this fix is a candidate for backporting to previously released LTS versions.

Could you send a v2 patch with "Cc: stable@dpdk.org" added after "Fixes" tag?

When sending this change, could you also please send the patch directly to mlx5 maintainers as well?
There's a script in DPDK repository which would add relevant people
based on the changed files - devtools/get-maintainer.sh
It's usage is described in here: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches

> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> ---
>  drivers/net/mlx5/mlx5_rx.h  | 1 +
>  drivers/net/mlx5/mlx5_rxq.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
> index 6380895502..58bc2c9f21 100644
> --- a/drivers/net/mlx5/mlx5_rx.h
> +++ b/drivers/net/mlx5/mlx5_rx.h
> @@ -169,6 +169,7 @@ struct __rte_cache_aligned mlx5_rxq_data {
>  /* RX queue control descriptor. */
>  struct mlx5_rxq_ctrl {
>  	struct mlx5_rxq_data rxq; /* Data path structure. */
> +	uint16_t mtu; /* Original MTU that the queue was allocated with. */
>  	LIST_ENTRY(mlx5_rxq_ctrl) next; /* Pointer to the next element. */
>  	LIST_HEAD(priv, mlx5_rxq_priv) owners; /* Owner rxq list. */
>  	struct mlx5_rxq_obj *obj; /* Verbs/DevX elements. */
> diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
> index 5cf7d4971b..c652204ea8 100644
> --- a/drivers/net/mlx5/mlx5_rxq.c
> +++ b/drivers/net/mlx5/mlx5_rxq.c
> @@ -773,7 +773,7 @@ mlx5_shared_rxq_match(struct mlx5_rxq_ctrl *rxq_ctrl, struct rte_eth_dev *dev,
>  			dev->data->port_id, idx);
>  		return false;
>  	}
> -	if (priv->mtu != spriv->mtu) {
> +	if (priv->mtu != rxq_ctrl->mtu) {
>  		DRV_LOG(ERR, "port %u queue index %u failed to join shared group: mtu mismatch",
>  			dev->data->port_id, idx);
>  		return false;
> @@ -1799,6 +1799,10 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
>  	}
>  	LIST_INIT(&tmpl->owners);
>  	MLX5_ASSERT(n_seg && n_seg <= MLX5_MAX_RXQ_NSEG);
> +	/*
> +	 * Save the original MTU to check against for shared rx queues.
> +	 */
> +	tmpl->mtu = dev->data->mtu;
>  	/*
>  	 * Save the original segment configuration in the shared queue
>  	 * descriptor for the later check on the sibling queue creation.
> -- 
> 2.34.1
> 

Best regards,
Dariusz Sosnowski
