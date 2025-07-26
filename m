Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BDC83F17
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 08:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AEC340144;
	Sat, 26 Jul 2025 10:06:43 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 48FF1400D5
 for <dev@dpdk.org>; Sat, 26 Jul 2025 10:06:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 1D6AD50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753517200;
 bh=tbh/X3WqfS6eZdBqxweR6820t8SVlze9eMCadoNTliM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yUCuGarjuuAAEDQHtrFoUGW/rDCcVuCOn0qOcpFL1Iou1G4qio0EZQCzApyDHgLfg
 hAJ7wEdV/cTpIOWLx3ehSk+lnO/2gQ6I72X7AD7k3fYkA7Tb7+y3HPunp+gGUmTaT7
 84vOiMm8wL9aeK+H5NfiAopkVfkWxnKCio6dZGuo=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 1D6AD50;
 Sat, 26 Jul 2025 11:06:40 +0300 (MSK)
Message-ID: <efb57831-e1fc-499f-b24d-33fe1ce7b111@oktetlabs.ru>
Date: Sat, 26 Jul 2025 11:06:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ethdev: Align enable logic handling with disable
 functions
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>, dev@dpdk.org
Cc: thomas@monjalon.net, ferruh.yigit@amd.com
References: <20250722010916.33536-1-sunyang.wu@jaguarmicro.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250722010916.33536-1-sunyang.wu@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Ack from Morten on v2 is lost.

On 7/22/25 04:09, Sunyang Wu wrote:
> This patch modifies the handling logic of the "enable" related

This patch modifies -> Modify

> operations. The key intention is to align it with the processing
> approach of the "disable" functions.
> Previously, there was an inconsistency in how failure scenarios were
> dealt with between the "enable" and "disable" logic. Now, after
> adjustment, their behaviors in exceptional cases are made more uniform.
> Importantly, this change does not introduce any alteration to the actual
> runtime behavior of the functions; it only serves to enhance code
> consistency and maintainability, making the overall logic easier to
> understand and maintain in the long run.
> In this way, we ensure the codebase follows a more cohesive pattern,
> reducing potential confusion during future development and maintenance
> efforts that could stem from logical disparities.
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

> ---
>   lib/ethdev/rte_ethdev.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..41f96071e2 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3018,7 +3018,8 @@ rte_eth_promiscuous_enable(uint16_t port_id)
>   		return -ENOTSUP;
>   
>   	diag = dev->dev_ops->promiscuous_enable(dev);
> -	dev->data->promiscuous = (diag == 0) ? 1 : 0;
> +	if (diag == 0)
> +		dev->data->promiscuous = 1;

Strictly speaking it changes the behaviour and result could be different
if driver callback modifies the promiscuous or all_multicast itself.
Anyway I agree that the code should be unified and driver should not
touch these flags in data.

>   
>   	diag = eth_err(port_id, diag);
>   
> @@ -3086,7 +3087,8 @@ rte_eth_allmulticast_enable(uint16_t port_id)
>   	if (dev->dev_ops->allmulticast_enable == NULL)
>   		return -ENOTSUP;
>   	diag = dev->dev_ops->allmulticast_enable(dev);
> -	dev->data->all_multicast = (diag == 0) ? 1 : 0;
> +	if (diag == 0)
> +		dev->data->all_multicast = 1;
>   
>   	diag = eth_err(port_id, diag);
>   

