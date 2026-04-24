Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB1FE51F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 09:38:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69DAE402A2;
	Fri, 24 Apr 2026 11:38:00 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5]) by mails.dpdk.org (Postfix) with ESMTP id BBBB0402A0
 for <dev@dpdk.org>; Fri, 24 Apr 2026 11:37:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6XCthxRKeu9Ie2WMeSz3DzgiVh3+bQ3Out3/Bvryy+0zogZypWJKiwJhZZZZvM6Sk0KZyZ+pxe9vhvcp4veiIsNnU7/wHNLIw8QygO5sR9e9lfpXO8PGaiwcTM84yC5ofdbg2nEVBtXdXg5+aL49J9c0qiTWxJHAhe5jBiejLW7fPB6/2uynMYNl4fvINb16IvkBGv6IKXM37GVD/KCZtbD6SoA+DbuCFHzhxMtqrnUCNgIT+pEm/AOpKl4gylkHdmOWgidxJAEV2du+A5WWkOebNljqgUxhIK9D5F5mSsbeLI9xgdhiZeX97l0Dps70XN8KfrozNAj9UWEpbLmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ldp5FpjYq26B9ocsih6k//cp65IG03/GfFxPsybmIo=;
 b=Lv3FqjKUFOjBWn7h/ePRlklMEDnF3pdigtP0VyXI7U5njrD6SPrrcz5qU9ZcJJ9mIqloMbzjZh4fYeTFFtPKen5wMuU+L8Ku3Ve7UUsmeHbn5cGiTaJYkSTc4CuERpd1E3T3QsyNZSnifWg1pDRUaqcZVGUlYXd98uDjFBx2T+V+mBWioUGVvmMIu74KwGZ7aSFKFhWrVWTgM2xqd9qwyEpAb3ime2a1DmVnRzfkGwm5dX2aR3euUKcrfGYoi/skJ1s5WeIv+RvaKTpfjZ+zsOGk/ZZ5f/RWVLx5CFHFyijgaTIE0KhnSMjAmclJAGlcar5MhieCou8zbjV2lQH/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ldp5FpjYq26B9ocsih6k//cp65IG03/GfFxPsybmIo=;
 b=TewTkjNCGc+v54Kh2D1QhBdZW/lxLSZeMGmS6CaCQFnjUvwSi3+j89r/nk9NCG3Y44DOFJStRPD3wgvwXWilwYxsbrj/+vBoxiI9pih4HLpM4k1L46AKt3MBNvC6m4VEGN0iNMAZz6faoLbuc9DXhqx/W924cr/xa2zzr5tj5WFJEzu9e6sFUBKt1Rj9gof+LvgnvPnbISmlj1sGe7cjKTO504vE+PQd2B3c4ZI1H5+4xc9zMwvReh+EnVrBwNI4czlof7tfZfjDPsVRkNKIfsexUJNu6T3nWLQ43vraU2JNEJshwGYremp+nVjWh8Tp5gtSdyJHxkcmVnW7e8AlcQ==
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:37:54 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::14) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Fri,
 24 Apr 2026 09:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:37:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 02:37:41 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 02:37:37 -0700
Date: Fri, 24 Apr 2026 11:37:35 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maxime Peim <maxime.peim@gmail.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: prepend implicit items in sync flow
 creation path
Message-ID: <xkbydtzo3yrelyhg43m3qtblhwfyc7uxofqx35zwe2kahj6ivp@cz6nyloxjrn6>
References: <20260409185634.3996187-1-maxime.peim@gmail.com>
 <20260420085236.2356342-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260420085236.2356342-1-maxime.peim@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff86c59-ee13-4be7-77ff-08dea1e528f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TGnC30uz6/X4CeJ2ZWW9KhJtCQgp0MZUOEVI9h1nQlmWxZjN/qTKOyapIcJnkrkb8n8pkXSjtS75i3+oBJdtS2C4gW/HhRpB/8qR/MMzhHlgOpIH9Kb9NgAA0fathOvmWAmO+AIzfuWuxSd0yivZhixQb6po3sMrmTd2SmAnvNXIhFo9e6dHCUWKkdmQUWH/kcdw/wd76pC/xfxrE7mHwhrxWElnt3qB1YloNSTu1FcVMp0fSGEdE/FRwldLiNUo4URhrunJxkE7BFKMFZ9oW46EE0hxNiVzEfg9r2brT837uZbBRYCNSOae0O19/xV5OsTCHjqfjKNIidatSEcXkWHWtRHIy94hh92V9SRzwXqRv4JTz2tmE735j7L6GcjedrtexsuiL0OwXYlmAAIGCMerAOXtCF2Dbz3Nxqtoq6+2EB2njMCGhwVJZO1uz4HkYn1P2TxgKafx4tey3DQczUTihE3dVZ1Amo3KsPRqBt00SYnKAz0ipDOBaCPGSBIYDo1A2Qx92Oja9OqkoxDgcYn7ZZbXQds/Y7JB4gcBiz8kEzVh+Ow8PlwV6NVUSLUG6jvtySXeU/CxV0P3lkk7GGKI3yUxiSLuJTzkgPRaBfJYpdzW2lIaWjgq7uRot5BvS5MNmh403uWToU3SVeATEPv2+kO4Gd8HXro4m6gQRFUVw1l+9L3zDKbhhT9R/fCZEfquJmyVxNBnCbty+HZi2c54W9K+FDnrZgQwV0UPyzzXik2jIzws7BE70uD44wfs3ZhRnPD3F6H8kY4PlhiZAA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zq1wffyX9LX6sVn/L0Y30sfN3tcn0T8oVcM4qjPDbJR/rzC4Y4N84Pgv9oDLE5z5fZ+KSqpU1ApslyWtEjsu2SOTD+BaAhTWPlaJEtq1twkV3VC6JidsUdzzGcwMOCUxjahpV6cSqIoOZKNGJdecXmPzDj3DMvAoXSoi46SicFH/hGdGMCEDmaZWlkgwGuKW1Iiz5cBFdh9UYVFBfzqFweFLimmKhobEvDVpt9Be3OdbbBJqOYpBaYfJ0VbZmmtGreuT1B8L3DpaCBUnJlEFBeFJ4BPiuy18eSVY2P0atVyHDgZ4N+Gt2MusWpO/WUuGBTUgqOizY2Tl3poXXvDFJC2vfyb4q2VMrApGIxkcsjlbEzO+UbOM1eOmJVQcBJR9qhEQB0gEHyzsz7k4upA08fAx5FypI07Lz+8d38AsU7l5K78tt65ZeR3DNTha/dC7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:37:53.8655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff86c59-ee13-4be7-77ff-08dea1e528f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

Thank you for the contribution.
Please see comments below.

On Mon, Apr 20, 2026 at 10:52:36AM +0200, Maxime Peim wrote:
> In eSwitch mode, the async (template) flow creation path automatically
> prepends implicit match items to scope flow rules to the correct
> representor port:
>   - Ingress: REPRESENTED_PORT item matching dev->data->port_id
>   - Egress: REG_C_0 TAG item matching the port's tx tag value
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

Since this is a fix, this patch should be backported to LTS releases.
Please add the following "Fixes:" tags to the commit message,
which would help LTS maintainers to pick this patch up.

	Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
	Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")

> 
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
>  drivers/net/mlx5/mlx5_flow_hw.c | 76 ++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> index bca5b2769e..21cadcc5bd 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -14275,6 +14275,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  	uint64_t item_flags = 0;
>  	uint64_t action_flags = mlx5_flow_hw_action_flags_get(actions, &qrss, &mark,
>  							 &encap_idx, &actions_n, error);
> +	struct mlx5_priv *priv = dev->data->dev_private;
>  	struct mlx5_flow_hw_split_resource resource = {
>  		.suffix = {
>  			.attr = attr,
> @@ -14282,6 +14283,28 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  			.actions = actions,
>  		},
>  	};
> +	struct rte_flow_item *prepend_items = NULL;
> +	struct rte_flow_item_ethdev port_spec = {.port_id = dev->data->port_id};
> +	struct rte_flow_item port = {
> +		.type = RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT,
> +		.spec = &port_spec,
> +		.mask = &rte_flow_item_ethdev_mask,
> +	};
> +	struct mlx5_rte_flow_item_tag tag_v = {
> +		.id = REG_C_0,
> +		.data = flow_hw_tx_tag_regc_value(dev),
> +	};
> +	struct mlx5_rte_flow_item_tag tag_m = {
> +		.id = REG_C_0,
> +		.data = flow_hw_tx_tag_regc_mask(dev),
> +	};

Please use rte_flow_item_tag struct here,
instead of mlx5_rte_flow_item_tag
(same as in flow_hw_pattern_template_create()).

Underlying HWS code expects the item spec and mask to be
rte_flow_item_tag struct for MLX5_RTE_FLOW_ITEM_TYPE_TAG item type.
(See mlx5dr_definer_conv_item_tag()).

This misalignment should be fixed at some point and it is in our
backlog, but for now rte_flow_item_tag should be used.

> +	struct rte_flow_item tag = {
> +		.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
> +		.spec = &tag_v,
> +		.mask = &tag_m,
> +		.last = NULL,
> +	};
> +	uint32_t nb_items;
>  	struct rte_flow_error shadow_error = {0, };
>  	const struct rte_flow_pattern_template_attr pattern_template_attr = {
>  		.relaxed_matching = 0,
> @@ -14296,13 +14319,48 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  	if (ret < 0)
>  		return 0;
>  
> +	nb_items = ret;
> +
> +	/*
> +	 * In eSwitch mode, the async (template) path automatically prepends
> +	 * implicit items to scope flow rules to the correct representor port:
> +	 *   - Ingress: REPRESENTED_PORT item matching dev->data->port_id
> +	 *   - Egress: REG_C_0 TAG item matching the port's tx tag value
> +	 * Mirror this behavior in the sync path so rules are not shared
> +	 * across all eSwitch ports.
> +	 */
> +	if (priv->sh->config.dv_esw_en &&
> +	    attr->ingress && !attr->egress && !attr->transfer) {
> +		prepend_items = flow_hw_prepend_item(items, nb_items,
> +						     &port, error);
> +		if (!prepend_items)
> +			return 0;
> +		items = prepend_items;
> +	} else if (priv->sh->config.dv_esw_en &&
> +		   !attr->ingress && attr->egress && !attr->transfer) {
> +		if (item_flags & MLX5_FLOW_ITEM_SQ) {
> +			DRV_LOG(DEBUG,
> +				"Port %u omitting implicit REG_C_0 match for egress "
> +				"pattern template",
> +				dev->data->port_id);
> +			goto setup_pattern;
> +		}
> +		prepend_items = flow_hw_prepend_item(items, nb_items,
> +						     &tag, error);
> +		if (!prepend_items)
> +			return 0;
> +		items = prepend_items;
> +	}

Could you please introduce a helper function which could be used
both here and in flow_hw_pattern_template_create()?
I'm thinking about a function with this signature:

	static struct rte_flow_item *
	flow_hw_adjust_pattern(struct rte_eth_dev *dev,
			       const struct rte_flow_item *items,
			       const uint32_t nb_items,
			       struct rte_flow_item **copied_items)

This function would:

- Define port and tag items locally, in a single place.
- Check prepend conditions.
- If prepending was needed:
	- Pointer to allocated items will be stored in *copied_items.
	- *copied_items will be returned.
- Otherwise, original items will be returned.

> +setup_pattern:
>  	RTE_SET_USED(encap_idx);
>  	if (!error)
>  		error = &shadow_error;
>  	split = mlx5_flow_nta_split_metadata(dev, attr, actions, qrss, action_flags,
>  					     actions_n, external, &resource, error);
> -	if (split < 0)
> -		return split;
> +	if (split < 0) {
> +		mlx5_free(prepend_items);
> +		return 0;
> +	}
>  
>  	/* Update the metadata copy table - MLX5_FLOW_MREG_CP_TABLE_GROUP */
>  	if (((attr->ingress && attr->group != MLX5_FLOW_MREG_CP_TABLE_GROUP) ||
> @@ -14315,8 +14373,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
>  		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, items, actions,
>  							item_flags, action_flags, error);
> -		if (flow != NULL)
> +		if (flow != NULL) {
> +			mlx5_free(prepend_items);
>  			return (uintptr_t)flow;
> +		}
>  		goto free;
>  	}
>  	if (action_flags & MLX5_FLOW_ACTION_RSS) {
> @@ -14328,8 +14388,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  		if (flow) {
>  			flow->nt2hws->rix_mreg_copy = cpy_idx;
>  			cpy_idx = 0;
> -			if (!split)
> +			if (!split) {
> +				mlx5_free(prepend_items);
>  				return (uintptr_t)flow;
> +			}
>  			goto prefix_flow;
>  		}
>  		goto free;
> @@ -14343,8 +14405,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  	if (flow) {
>  		flow->nt2hws->rix_mreg_copy = cpy_idx;
>  		cpy_idx = 0;
> -		if (!split)
> +		if (!split) {
> +			mlx5_free(prepend_items);
>  			return (uintptr_t)flow;
> +		}
>  		/* Fall Through to prefix flow creation. */
>  	}
>  prefix_flow:
> @@ -14357,6 +14421,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  		flow->nt2hws->chaned_flow = 1;
>  		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
>  		mlx5_flow_nta_split_resource_free(dev, &resource);
> +		mlx5_free(prepend_items);
>  		return (uintptr_t)prfx_flow;
>  	}
>  free:
> @@ -14368,6 +14433,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
>  	if (split > 0)
>  		mlx5_flow_nta_split_resource_free(dev, &resource);
> +	mlx5_free(prepend_items);
>  	return 0;
>  }
>  

Best regards,
Dariusz Sosnowski
