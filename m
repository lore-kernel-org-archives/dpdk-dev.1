Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E025BCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 10:40:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3601940395;
	Wed, 13 Aug 2025 12:40:03 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id F20A64021F
 for <dev@dpdk.org>; Wed, 13 Aug 2025 12:40:01 +0200 (CEST)
Received: from debian (unknown [78.109.79.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 5189AE097E;
 Wed, 13 Aug 2025 14:40:01 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 5189AE097E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755081601;
 bh=FyuamGGkjNf50snx2v/poqjHgxviCUGPJRbqiYAS/rs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=jXLrzAPw09T6oGuwAWZjh22LucLhpDx46xks4YdZd1t1K2r0vmva1vnyR8eBVQKL1
 yQVPv5MFWx/RN4JebtplEXGHy8tY2H1aAFV6KBsMjiQ68hZ4SW7u6fgtuFSmUjghmA
 +CN0bKX1RKR0XfjJecmgM+c5gZa6nMIdsAr+XLpgIxmK50wESEmqECemnBRTxK49Hx
 B3IY0BCNkHm9lXQ9GpTnZnI5J3IwP8sHvCthBVrcqxVU6tS0VsUuO4GVHr5t+tJ0lW
 T89J9BTrDb8hq9YNozbHFzvgixik0YR2Eq689Mc4l4QM27lff3FfRtoEda2OR2CUKY
 oQWBbCmWIwwoQ==
Date: Wed, 13 Aug 2025 14:40:00 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, 
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 11/16] net/nbl: add nbl ethdev configuration
In-Reply-To: <20250813064410.3894506-12-dimon.zhao@nebula-matrix.com>
Message-ID: <06eaa13e-6cb0-4fb7-511a-13fc86af1711@arknetworks.am>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-12-dimon.zhao@nebula-matrix.com>
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

Hi Dimon,

On Tue, 12 Aug 2025, Dimon Zhao wrote:

> NBL device add ethdev configuration
>
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
> drivers/net/nbl/nbl_dev/nbl_dev.c         | 33 +++++++++++++++++++++--
> drivers/net/nbl/nbl_include/nbl_include.h |  3 ++-
> 2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
> index c4fd2dbfd6..86defd621d 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> @@ -4,15 +4,44 @@
>
> #include "nbl_dev.h"
>
> -int nbl_dev_configure(struct rte_eth_dev *eth_dev)
> +static int nbl_dev_port_configure(struct nbl_adapter *adapter)
> {
> -	RTE_SET_USED(eth_dev);
> +	adapter->state = NBL_ETHDEV_CONFIGURED;
> +
> 	return 0;
> }
>
> +int nbl_dev_configure(struct rte_eth_dev *eth_dev)
> +{
> +	struct rte_eth_dev_data *dev_data = eth_dev->data;
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	int ret;
> +
> +	NBL_LOG(INFO, "Begin to configure the device, state: %d", adapter->state);
> +
> +	if (dev_data == NULL || adapter == NULL)
> +		return -EINVAL;
> +
> +	dev_data->dev_conf.intr_conf.lsc = 0;
> +
> +	switch (adapter->state) {
> +	case NBL_ETHDEV_CONFIGURED:
> +	case NBL_ETHDEV_INITIALIZED:
> +		ret = nbl_dev_port_configure(adapter);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	NBL_LOG(INFO, "configure the device done %d", ret);
> +	return ret;
> +}
> +
> int nbl_dev_port_start(struct rte_eth_dev *eth_dev)
> {
> 	RTE_SET_USED(eth_dev);
> +

Unrelated?

> 	return 0;
> }
>
> diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
> index 8902c44972..e10fcc9254 100644
> --- a/drivers/net/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/nbl/nbl_include/nbl_include.h
> @@ -132,9 +132,10 @@ struct nbl_common_info {
> 	/* curr_network 0 means kernel network, 1 means user network */
> 	u8 curr_network:1;
> 	u8 is_vf:1;
> +	u8 pf_start:1;

By the looks of it, not used in this patch. Unrelated?

Thank you.

> 	u8 specific_dma:1;
> 	u8 dma_set_msb:1;
> -	u8 rsv:3;
> +	u8 rsv:2;
> 	struct nbl_board_port_info board_info;
> };
>
> -- 
> 2.34.1
>
>
