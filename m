Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A1C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93EFB4026F;
	Thu, 26 Jun 2025 14:16:47 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by mails.dpdk.org (Postfix) with ESMTP id 2E0A4400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:16:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnml6iNr61TfPt/678D5H4p7K5tJRe36bKqamzE747rahJUHN2EgnUc21PKalJcgLr6dJ4SYFuuWagZ57RR2vRHDRefhZ3elydeUe+6qhmnuXv3GhhxVLtED7eDAC42HvRqAbLiscGAh0c2zeV2Mzcj27rxHbyhloHV6+84dZTxqrUD1CYx56lfxfv9u9eEVnvogoyfUJhGCmublrbEuN9opj4q7OLKIGlAlrpdVtP89jEhwxDGBIud4tOIhDrkwaUXJ5krPJjL5KoWM44QX8t8zHIQeIoPLskCY/qsauchHcgOYFA1+5TQaXMqZIYAt8oW8WPAxiZPHhFPje6rMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jcqKFlXbrQVW/YbMJuNLs/UtOUCdIGxqtEoLs8dqP8=;
 b=o0hOfXytn82iJD5VqXssHUl8OBjjY+7z0c8be/rm9NBDKNvvJDo2GlBpkX3j4OyIVyKtz3olB7zNvGuTprKxZS1o29a0UEIjxk1RZCsDmZg59baQUktBQ40Ny0YG2MUU60MSwlV2E1eZMF2yi0m+TYw+sRsSV3Mxop4WcDr9dbChm9pEEyIfw4b8sUgwzGNzVzpB9WQKARdfqRD+9+1q/bzyd1+cuEF/YyGt37zm3lMYnXYOyGUOYAGPlHnGfFTZ+3fHOEz19YGEIbw2LRwB5Do2WBSEMkOpjMR2/2oGso7N+W4rBCGW1hRw3W3xbSF4v/i+70M4BrHFdGGO58phLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jcqKFlXbrQVW/YbMJuNLs/UtOUCdIGxqtEoLs8dqP8=;
 b=ORrTjfgGh/70A4UPFsuAH4BPZW2rclBy5nVxYQCIpkajICefaZ7O5xNCywAmI+aJ90Dv4OBvXcJKkWtEE34KbUNevzoeo+MuErh3o9wMPnuCrHYIMXP6H5sCuzxIj8IivtmAl0NIcf0n2yu65u4bsFItOoWb+mWIP3c/7lIkQ0v2qDCg1+uxY7J6WqJKDv6wdMjvTk2jPouPJxPc3oCQY/7WXxSxihC/qIWT/3YuRpVVO1xYDOIwOmYf5Lnq07qn/LgUYVgadS/cNd7VjoRhcQjyzoilrOKrK3c6Tq6Arxn034z9CBnLcWDlAWOF6lqUZs4E1wXm46v546rEKLvumA==
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 26 Jun
 2025 12:16:43 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::4) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 12:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 12:16:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 05:16:29 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 05:16:28 -0700
Date: Thu, 26 Jun 2025 14:15:59 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <viacheslavo@nvidia.com>,
	<bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
	<matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix segfault on indirect action age query with
 conntrack
Message-ID: <20250626121559.gyu7otcoblrx74nb@ds-vm-debian.local>
References: <20250624051015.3145137-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624051015.3145137-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 790ac8c7-facb-4298-8a9f-08ddb4ab4fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oS4UxTOGroLTwxBlyJLkmbqrjoKkJvvdSO3AuHV8eAc9mD5CmK/eS7I+dsfp?=
 =?us-ascii?Q?nXh+4HpzSY/fe/PXX5dlfx7TfzUcGDgv/eQnZ0Zp5uh7CRl57ih1Zb0xlHOM?=
 =?us-ascii?Q?2McAazkUBaD+HlgmMuRB8t63nJZ+CnD2m5aO1TQ4+3HaR5AQ0sVqQYlgI+PM?=
 =?us-ascii?Q?4bevUjA7emSk9CwZp2mBe3rNvcuRJQcTbpjbRmmpNZgXHeyNcFOjZxnaJ9Iw?=
 =?us-ascii?Q?ISxe57rgKbCt4cu9JS7w6hiF2FQ6cB1APfAcH43PHYgI9CX7d2CWpvzqFtSD?=
 =?us-ascii?Q?c9vmfQKyl/+29E9kyYB6e3E42iijUjAosQD+uudyzBtvMgzOkcfmkyuPQSK8?=
 =?us-ascii?Q?+4DJkPmCTQ040Nvw9T8G12FUDgtjeoqqX9l/wcnoUJQH+7cIbqYAV8X/xtwC?=
 =?us-ascii?Q?urxgzCiRtbw/ivxfTmLbXGaR+ASTWRtK9VgrbhFt471OvSRacZGeYYMdc3d4?=
 =?us-ascii?Q?C+BCW7zQCNFz3X4uPbTE52dWjbedB0ZjqbkDa3Wro+dMM5kLFO/rpdBPhsM2?=
 =?us-ascii?Q?gqlFmiTnDSzHHsExp1YfDdr0FqCNj5XCO2pjReRSyS02lM2mnD/o891iJIz4?=
 =?us-ascii?Q?1WPZFKihP/2D99brlUmdjq8XP2CBMsQ4L4ruZt8Qo/gRG+VooTKTDZugILbf?=
 =?us-ascii?Q?Gl03yDWraLLOW/S9tRMHD03Uv0KBoOC8GKdPUgVtoECd5OLdgGTE8Cap8xcF?=
 =?us-ascii?Q?Eq7C8zPlZDhOROnIQT/y4kyHsdwieK3Ey5h432xtFuC4i1yN8wboSoFMmEpx?=
 =?us-ascii?Q?6Uz4tEIQLKqlfC4t9QRZ05ZOq/48dVtHUbVrDI7nM3CG8MU1jAZSEY7Pzl6D?=
 =?us-ascii?Q?pY+KdgW7szpNC/z5kwP6T6vRh9tWSVERRl7WZGJ/UHO1eIDfJWzJStY+8N9o?=
 =?us-ascii?Q?gJu3qrlMPNVdOfpq2uKAxHPSHB2iQxtNuNEVz+D5AdUVc5SepuwzHwh6pV4x?=
 =?us-ascii?Q?F87i0TBGbKABkn5ibjYcyEi6XDa3lA/rYsGD62dXR9NMDo0ht9rf1YSFThmB?=
 =?us-ascii?Q?zSmv7Ub0Ii7RYofNpUSyCo+1joq2998/3yywIXMORlRHHNdHaftHnjBcHvdx?=
 =?us-ascii?Q?Sd4lOb3xpLIalzc0uW6IYWxUWSMtpzQrvxbzKEwdEPOvhuoJy5psmdUSMDdr?=
 =?us-ascii?Q?yLORDaHwPW8iuUGg032k+/j+l7/ITkBvL0+g4vvvZeNMJHJd4dl4Cg+auWo9?=
 =?us-ascii?Q?IvdzGxh/nVDOAnVBpEwTUz2Uam9yRORlEt2pCq2MCz2uMtopdA6VcwwQUj9R?=
 =?us-ascii?Q?oLe/Gzp5vbqJmMrnlVqwk4CjgnWeso408sPl4Dyg7jL7rPfNQA09O3Tc8wAa?=
 =?us-ascii?Q?u+vv9nxVa47/cWBqW9Mmk/K46dDMKLA1dBL9BIVR19GgWd8Hahcp5lfkGr3f?=
 =?us-ascii?Q?fkqoxhL1bOpAT5xBZ1yIvj64XvE4TZ3pmpdvVuMPLvynl/lvG5l/BUWnxC8a?=
 =?us-ascii?Q?7tbODeaTXT0Abbb9MVA+8SBRJEJtOn37pIsd/9NZ7y1gQE9B5b+7g6OndBqJ?=
 =?us-ascii?Q?aqLccxL6nLeu2iiXn7zZnAABLNxkCEbpI2x5?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:16:42.4935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ac8c7-facb-4298-8a9f-08ddb4ab4fb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

+Cc mlx5 maintainers

Thank you for the contribution. Please see the comments inline.

On Tue, Jun 24, 2025 at 01:10:15AM -0400, Khadem Ullah wrote:
> This patch fixes a segmentation fault that occurs when querying the
> age action of an indirect flow rule using connection tracking.
> 
> Steps to reproduce:
>  1. Create an indirect action:
>     flow indirect_action 0 create ingress action conntrack / end
> 
>  2. Create a root flow rule with a jump:
>     flow create 0 ingress pattern eth / ipv4 / tcp / end /
>          actions jump group 3 / end
> 
>  3. Create a group 3 rule using the indirect action:
>     flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end /
>          actions indirect 0 / jump group 5 / end
> 
>  4. Create a group 5 rule matching on conntrack state:
>     flow create 0 group 5 ingress pattern eth / ipv4 / tcp /
>          conntrack is 1 / end actions queue index 5 / end
> 
>  5. Querying the first rule causes a segmentation fault:
>     flow query 0 1 age
> 
> This patch ensures proper handling of the indirect action with
> conntrack to prevent this crash.

Could you please add the following Fixes tag to the commit message?

	Fixes: 2d084f69aa26 ("net/mlx5: add translation of connection tracking action")

This would allow LTS maintainers to pick up the fix for future LTS
releases.

> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  .mailmap                        | 1 +
>  drivers/net/mlx5/mlx5_flow.c    | 2 ++
>  drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 8483d96ec5..5c9ea95346 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -812,6 +812,7 @@ Kevin Scott <kevin.c.scott@intel.com>
>  Kevin Traynor <ktraynor@redhat.com>
>  Ke Xu <ke1.xu@intel.com>
>  Ke Zhang <ke1x.zhang@intel.com>
> +Khadem Ullah <14pwcse@uetpeshawar.edu.pk>

Could you please make sure that the mail address in .mailmap and
Signed-off-by tag match?

>  Khoa To <khot@microsoft.com>
>  Kiran KN <kirankn@juniper.net>
>  Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com> <kiran.kokkilagadda@caviumnetworks.com>
> diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
> index 3d49a2d833..5c799ea4ce 100644
> --- a/drivers/net/mlx5/mlx5_flow.c
> +++ b/drivers/net/mlx5/mlx5_flow.c
> @@ -4550,6 +4550,8 @@ flow_aso_age_get_by_idx(struct rte_eth_dev *dev, uint32_t age_idx)
>  	struct mlx5_aso_age_pool *pool;
>  
>  	rte_rwlock_read_lock(&mng->resize_rwl);
> +	if (mng->pools == NULL)
> +		return NULL;

It is an interesting case.
When DV flow engine is used (current default),
connection tracking and age action cannot be used together.
Because of that, to optimize memory usage, age and CT index
are placed in a union.

The root cause of the crash is not a lack of ageing pools
(they are not initialized since no flow rule uses age action),
but the fact that age and CT index are in the union.
Since flow rule in repro steps use conntrack action,
flow->age value is misinterpreted.

In this case flow_aso_age_get_by_idx() should not be reached at all.

There's a check missing in flow_dv_query() for AGE action:

	flow_dv_query(...) { 
		for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
			switch (actions->type) {

			/* snip */

			case RTE_FLOW_ACTION_TYPE_AGE:
				/* missing check; if true, flow->age should not be read */
				if (flow->indirect_type == MLX5_INDIRECT_ACTION_TYPE_CT)
					return rte_flow_error_set(..., "age not available");
				ret = flow_dv_query_age(dev, flow, data, error);
				break;

			/* snip */
			}
	}

This check should resolve the segfault.

Would you be able to test that approach on your side and if all is good
resend the patch?

>  	pool = mng->pools[pool_idx];
>  	rte_rwlock_read_unlock(&mng->resize_rwl);
>  	return &pool->actions[offset - 1];
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
> index c217634d9b..f81ce20385 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -18086,6 +18086,11 @@ flow_dv_query_age(struct rte_eth_dev *dev, struct rte_flow *flow,
>  	if (flow->age) {
>  		struct mlx5_aso_age_action *act =
>  				     flow_aso_age_get_by_idx(dev, flow->age);
> +		if (!act)
> +			return rte_flow_error_set
> +					(error, EINVAL,
> +					 RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +					 NULL, "cannot read age data");
>  
>  		age_param = &act->age_params;
>  	} else if (flow->counter) {
> -- 
> 2.43.0
> 

Best regards,
Dariusz Sosnowski
