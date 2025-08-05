Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C831C87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 14:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A8E440BA4;
	Tue,  5 Aug 2025 16:45:02 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id A5AC840A4B;
 Tue,  5 Aug 2025 16:45:01 +0200 (CEST)
Received: from debian (unknown [78.109.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8FAB8E04CB;
 Tue,  5 Aug 2025 18:44:59 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8FAB8E04CB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754405100;
 bh=7tFlPQEbWAiGHQzGlyR7/aLiYPWMpKP8g8l7ODf5/d0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=BgsHzlrBthEu9yoIlm2Zcry2FGhI6SHtZJ1MAqFluRQ2eIxInr3AnLpHfvcdckeoV
 Az7ZFs34cGIVk8xYqQZERbJDgjgZxjzWyeJ+aUh6raE5eVbqZ/A1w8ojJqQu1FcK0q
 3TLlm6EQQYtOOyN6zGm9HLWEVAyRbQovxzWHg7or6+pvFXMj1OjnrPoEcCa63PJ5Qx
 KVOR1LTTmALF3HE9UgnwwXlXSl0yqWv3MB4GP95ZGl8R1sJFaB9tyUZxxmxb/cPvz1
 K8faBmVzIT4wZS0bKL5sunAwWwkdeHJ9i86+PCKeMKv/TSfhXPZkbhIWBwBMqRrlkF
 Nggs6g0knumVw==
Date: Tue, 5 Aug 2025 18:44:52 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
cc: Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item
 validation
In-Reply-To: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
Message-ID: <4a26fe30-fb35-f306-d0df-e935ba3a0a89@arknetworks.am>
References: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
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

Hi,

On Tue, 5 Aug 2025, Khadem Ullah wrote:

> This patch validate a connection tracking state when matching
> 'conntrack is' in rte_flow rules. The conntract possible CT states
> are SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, LAST_ACK and
> TIME_WAIT. Therefore the maximum possible value to match on
> in rte_flow is TIME_WAIT but mlx5 allowed matching on any values.
>
> This patch validate the CT state item.
> Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
> Cc: stable@dpdk.org
>
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
> drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
> index 7b9e5018b8..750385cd42 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -3290,6 +3290,11 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
> 						  NULL,
> 						  "Conflict status bits");
> 	}
> +	if (spec->flags > RTE_FLOW_CONNTRACK_STATE_TIME_WAIT)
> +		return rte_flow_error_set(error, EINVAL,
> +					RTE_FLOW_ERROR_TYPE_ITEM,
> +					NULL,
> +					"Invalid CT state matching \n");

It might be better to enclose the multi-line block in brackets.

Also, is it correct to treat 'flags' like enum 'RTE_FLOW_CONNTRACK_STATE'?
I thought it was following 'RTE_FLOW_CONNTRACK_PKT_STATE' flags instead [1].

[1] https://doc.dpdk.org/api-25.07/rte__flow_8h.html#a7a41946aa03ebca8c432279604265b51

Or am I missing something?

Thank you.

> 	/* State change also needs to be considered. */
> 	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
> 	return 0;
> -- 
> 2.43.0
>
>
