Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4193C9830C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 01:04:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFEF740673;
	Mon, 19 Jan 2026 02:04:36 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id C1F3D4025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 02:04:34 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=z2impV++G+naPoC5ReDB8+drpXVHK2BtspxbB1U9MV0=;
 b=mNNp6QPPJ9CXyyfQYjiFbu9b66MR5J+7ihqMBTdpeJ9ZboWAJeugi2rm9zfYI5tKpXCXCDsH+
 uwrKU/L03Z6Z79iQ/HyzBFXZ2BLRlVuXHXrKXXYrqhzerDMIX3ifbKWY0T6Q2TqmCqDDAIOr+Fw
 ES80R9Ajy+8MMEdfam5+nmQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dvXFM4r8dzcZyx;
 Mon, 19 Jan 2026 09:00:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id A346240539;
 Mon, 19 Jan 2026 09:04:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:04:32 +0800
Message-ID: <12514141-a489-4995-a8a7-e6d0fc28f841@huawei.com>
Date: Mon, 19 Jan 2026 09:04:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] ethdev: support selective Rx data
To: Gregory Etelson <getelson@nvidia.com>
CC: <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <viacheslavo@nvidia.com>, <matan@nvidia.com>,
 <stephen@networkplumber.org>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260106154554.40556-1-getelson@nvidia.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260106154554.40556-1-getelson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 1/6/2026 11:45 PM, Gregory Etelson wrote:
> In some cases application does not need to receive entire packet
> from port hardware.

Which scenarios need to be used? What is the behavior when
LRO(TCP packet aggregation is performed by hardware) is enabled?

> If application could receive required Rx data only and safely discard
> the rest of Rx packet data, that could improve port performance by
> reducing PCI bandwidth and application memory consumption.
> 
> Selective Rx data allows application to receive
> only pre-configured packet segments and discard the rest.
> For example:
> - Deliver the first N bytes only.
> - Deliver the last N bytes only.
> - Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.
> 
> Selective Rx data is implemented on-top of the existing Rx
> BUFFER_SPLIT functionality:
> - The rte_eth_rxseg_split will use the NULL mempool for data segments
> that should be discarded.
> - PMD will not create MBUF segments if no data was read.
> 
> For example: Deliver Ethernet header only
> 
> Rx queue segments configuration:
> struct rte_eth_rxseg_split split[2] = {
>     {
>         .mp = <some mempool>,
>         .length = sizeof(struct rte_ether_hdr)
>     },
>     {
>         .mp = NULL, /* discard data */
>         .length = <MTU>
>     }
> };
> 
> Received MBUF configuration:
> mbuf[0].pkt_len = <original packet length>;
> mbuf[0].data_len = sizeof(struct rte_ether_hdr);
> mbuf[0].next = NULL; /* The next segment did not deliver data */
> 
> A PMD activates the selective Rx data capability by setting the
> rte_eth_rxseg_capa.selective_read bit.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
> v3: Change the selective_read bit location.
> ---
>  lib/ethdev/rte_ethdev.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index a66c2abbdb..84769d3d26 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1121,7 +1121,11 @@ struct rte_eth_txmode {
>   *   The rest will be put into the last valid pool.
>   */
>  struct rte_eth_rxseg_split {
> -	struct rte_mempool *mp; /**< Memory pool to allocate segment from. */
> +	/**
> +	 * Memory pool to allocate segment from.
> +	 * NULL means skipped segment in selective Rx data. @see selective_read.
> +	 */
> +	struct rte_mempool *mp;
>  	uint16_t length; /**< Segment data length, configures split point. */
>  	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
>  	/**
> @@ -1758,6 +1762,7 @@ struct rte_eth_rxseg_capa {
>  	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
>  	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
>  	uint32_t offset_align_log2:4; /**< Required offset alignment. */
> +	uint32_t selective_read:1; /**< Supports selective read. */
>  	uint16_t max_nseg; /**< Maximum amount of segments to split. */
>  	uint16_t reserved; /**< Reserved field. */
>  };

