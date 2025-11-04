Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC1CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 00:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1863E402B1;
	Tue,  4 Nov 2025 01:45:33 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 3A82E40299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 01:45:31 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=IHPZnJ0sOQwRTUE3Xf5Xh6p0sW0d2i3EqE35F0KwC3k=;
 b=knDotWSC7jrSAD+hbwxdcch+ZnSYyy5pg3SNCikPtUe1aw6e70n/WZ1K/1qwrv0OAfOQvUFE0
 zKwBrLXeC0DqWiWB3tqfR5DTUZsqpkO/fREiDnaaMOHPxoylnk4x9sSJ17TIxgtRvVN0ZvPD2f4
 yo1ADC/ll503qyf8SAQE5+8=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d0qT66dTtzcbR5;
 Tue,  4 Nov 2025 08:43:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 163BA1400C8;
 Tue,  4 Nov 2025 08:45:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 08:45:28 +0800
Message-ID: <90a817be-147c-47e1-a570-194c8c96fc53@huawei.com>
Date: Tue, 4 Nov 2025 08:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/1] dmadev: add domain_id field to access group join
 API
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>
References: <20251103102946.2204883-1-vattunuru@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251103102946.2204883-1-vattunuru@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 11/3/2025 6:29 PM, Vamsi Krishna wrote:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Add domain_id field to access group join API, which is required
> to retrieve handler information associated with the specified domain.
> This enhancement ensures that domain-specific context is available
> during group join operations, improving flexibility and traceability
> in multi-domain environments.
> 
> It also aligns the parameters of access group create and join APIs
> for consistency and clarity.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  lib/dmadev/rte_dmadev.c       |  6 +++---
>  lib/dmadev/rte_dmadev.h       | 10 ++++++----
>  lib/dmadev/rte_dmadev_pmd.h   |  4 ++--
>  lib/dmadev/rte_dmadev_trace.h |  6 ++++--
>  4 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
> index c008e829db..b75b4f9bd1 100644
> --- a/lib/dmadev/rte_dmadev.c
> +++ b/lib/dmadev/rte_dmadev.c
> @@ -875,8 +875,8 @@ rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id)
>  
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dma_access_pair_group_join, 25.11)
>  int
> -rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
> -			       rte_dma_access_pair_group_event_cb_t cb)
> +rte_dma_access_pair_group_join(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +			       int16_t group_id, rte_dma_access_pair_group_event_cb_t cb)
>  {
>  	struct rte_dma_info dev_info;
>  	struct rte_dma_dev *dev;
> @@ -899,7 +899,7 @@ rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t toke
>  
>  	if (*dev->dev_ops->access_pair_group_join == NULL)
>  		return -ENOTSUP;
> -	return (*dev->dev_ops->access_pair_group_join)(dev, group_id, token, cb);
> +	return (*dev->dev_ops->access_pair_group_join)(dev, domain_id, token, group_id, cb);
>  }
>  
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dma_access_pair_group_leave, 25.11)
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 0f4f10ec12..5287b0f32d 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -912,10 +912,12 @@ int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
>   *
>   * @param dev_id
>   *   Identifier of the DMA device attempting to join the group.
> - * @param group_id
> - *   ID of the access group to join.
> + * @param domain_id
> + *   Unique identifier representing the process or OS domain.

This domain_id should be local process or OS domain, so how bout: Unique identifier representing my process or OS domain.

And please change the rte_dma_access_pair_group_create 's comment about the domain_id.

>   * @param token
>   *   Authentication token used to validate group membership.
> + * @param group_id
> + *   ID of the access group to join.
>   * @param cb
>   *   Callback function to be invoked when the device leaves the group
>   *   or when the group is destroyed due to some exception or failure.
> @@ -925,8 +927,8 @@ int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
>   *   negative value on failure indicating the error code.
>   */
>  __rte_experimental
> -int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
> -				   rte_dma_access_pair_group_event_cb_t cb);
> +int rte_dma_access_pair_group_join(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +				   int16_t group_id, rte_dma_access_pair_group_event_cb_t cb);
>  
>  /**
>   * Leave an access group, removing the device's entry from the group table
> diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
> index 16fd625c2d..8a6b0a9c98 100644
> --- a/lib/dmadev/rte_dmadev_pmd.h
> +++ b/lib/dmadev/rte_dmadev_pmd.h
> @@ -75,8 +75,8 @@ typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev
>  						   int16_t group_id);
>  
>  /** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
> -typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
> -						rte_uuid_t token,
> +typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, rte_uuid_t domain_id,
> +						rte_uuid_t token, int16_t group_id,
>  						rte_dma_access_pair_group_event_cb_t cb);
>  
>  /** @internal Used to leave an access pair group, removing the device from the group. */
> diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
> index da80a8cb50..7ad00b5bfa 100644
> --- a/lib/dmadev/rte_dmadev_trace.h
> +++ b/lib/dmadev/rte_dmadev_trace.h
> @@ -120,10 +120,12 @@ RTE_TRACE_POINT(
>  
>  RTE_TRACE_POINT(
>  	rte_dma_trace_access_pair_group_join,
> -	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t token),
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +			     int16_t group_id),
>  	rte_trace_point_emit_i16(dev_id);
> -	rte_trace_point_emit_i16(group_id);
> +	rte_trace_point_emit_u8_ptr(&domain_id[0]);
>  	rte_trace_point_emit_u8_ptr(&token[0]);
> +	rte_trace_point_emit_i16(group_id);
>  )

There are one detail missing:
1. every process could generate one unique domain_id
2. process A create the access group, and share it's domain_id, the access group token, group_id to process B
3. process B join the access group, which verify by token and group id obtained in step 2
4. both process use rte_dma_access_pair_group_handler_get() API to get each other's domain.
   This is the detail missing: how process A know the process B's domain_id??? ---by extra communication channel???

Please add such detail on dmadev.rst

Thanks
>  
>  RTE_TRACE_POINT(

