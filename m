Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B771C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 11:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B410402E1;
	Thu,  7 Aug 2025 13:44:31 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id A11A6402E0;
 Thu,  7 Aug 2025 13:44:29 +0200 (CEST)
Received: from debian (unknown [78.109.66.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 7C4A5E035C;
 Thu,  7 Aug 2025 15:44:28 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 7C4A5E035C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754567069;
 bh=EOy0Ghz6nxlOtQ8Sh2a7UUiRubSIfFlnKNCZtO9y+Fk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GPkPsExLjvIgyqG0oeaVgye27IXoSXSk56lp/nq8ShvDWj3TQbITrqbvrSyvRrXOx
 JBBvI9o47F+ucMcy9sJX5/Z35vzs1k16o2401ySov7ELuLLj0IjP2wUU0H6Vk7AlXj
 0SuO29Ld1eKECzhRJ0WSGwArLrHRBKPiBzb34GVKc6HDfywzkZpIwrZNOtBhVZTOdP
 /vn5NVinaEsFyw4OSvKac+kGZ+yCSYRZVYBzzhW65+npPdVbpscfmCZXd7dV9kFGQS
 SsIM4JHUbk1qvZCNmNHrntX9FzGaiOXaZDLAoMOOvVmqarVF55fUkzv6xq2NTp9gPW
 vkk1H2DLAEnIA==
Date: Thu, 7 Aug 2025 15:44:20 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Maayan Kashani <mkashani@nvidia.com>
cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix unsupported port ID action
In-Reply-To: <20250807091247.155266-1-mkashani@nvidia.com>
Message-ID: <85f5793f-232b-ae04-7286-33e27dc83c6d@arknetworks.am>
References: <20250807091247.155266-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Thu, 7 Aug 2025, Maayan Kashani wrote:

> When dv_flow_en=2, the port ID action is not supported.
> Although a rule can be created successfully in non-template mode,
> the specified action will be silently ignored and not applied.
>
> To prevent this ambiguous behavior, explicitly return an error
> when a port ID action is used with dv_flow_en=2,
> and recommend using a represented port action instead.
>
> Fixes: f1fecffa88df ("net/mlx5: support Direct Rules action template API")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Acked-by: Ivan Malov <ivan.malov@arknetworks.am>

> ---
> drivers/net/mlx5/mlx5_flow_hw.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> index 6dc16f80d32..58d4882cb96 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -2913,6 +2913,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
> 		case RTE_FLOW_ACTION_TYPE_END:
> 			actions_end = true;
> 			break;
> +		case RTE_FLOW_ACTION_TYPE_PORT_ID:
> +			DRV_LOG(ERR, "RTE_FLOW_ACTION_TYPE_PORT_ID action is not supported. "
> +				"Use RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT instead.");
> +			goto err;
> 		default:
> 			break;
> 		}
> @@ -7644,7 +7648,11 @@ flow_hw_parse_flow_actions_to_dr_actions(struct rte_eth_dev *dev,
> 		case MLX5_RTE_FLOW_ACTION_TYPE_MIRROR:
> 			at->dr_off[i] = curr_off;
> 			action_types[curr_off++] = MLX5DR_ACTION_TYP_DEST_ARRAY;
> -				break;
> +			break;
> +		case RTE_FLOW_ACTION_TYPE_PORT_ID:
> +			DRV_LOG(ERR, "RTE_FLOW_ACTION_TYPE_PORT_ID action is not supported. "
> +				"Use RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT instead.");
> +			return -EINVAL;
> 		default:
> 			type = mlx5_hw_dr_action_types[at->actions[i].type];
> 			at->dr_off[i] = curr_off;
> -- 
> 2.21.0
>
>
