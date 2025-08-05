Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D02C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 02:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6AC84028E;
	Tue,  5 Aug 2025 04:10:22 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id D2B7E40280
 for <dev@dpdk.org>; Tue,  5 Aug 2025 04:10:18 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bwxbr2yR2z14MDj;
 Tue,  5 Aug 2025 10:06:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 7FA951401F3;
 Tue,  5 Aug 2025 10:10:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 10:10:15 +0800
Message-ID: <b3da43b5-dbf1-428d-ad13-0c787d322654@huawei.com>
Date: Tue, 5 Aug 2025 10:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ethdev: Reject conflicting TX offloads
 configuration
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Ivan
 Malov <ivan.malov@arknetworks.am>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
 <20250803194218.683318-3-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250803194218.683318-3-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 8/4/2025 3:42 AM, Morten Brørup wrote:
> When an ethdev port is configured for fast mbuf release, the driver can
> use a TX burst function relying on the fast mbuf release preconditions.
> Thus, also configuring this port or a queue on the port for transmitting
> segmented packets is prohibited.
> Checks for these conflicting configurations have been added to the ethdev
> library, so the drivers don't have to implement them.

I think the new comment part of ombuf-fast-free and multi-seg in '[PATCH v3 2/3] ethdev: Improve descriptions of RX and TX offloads'
could drop or within this commit.

> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
> v3:
> * Shorten the added log messages. (Stephen Hemminger, Ivan Malov)
> ---
>  lib/ethdev/rte_ethdev.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..00afda873f 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -1531,6 +1531,18 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
>  		goto rollback;
>  	}
>  
> +	/* MBUF_FAST_FREE preconditions conflict with MULTI_SEGS support. */
> +	if ((dev_conf->txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
> +	    (dev_conf->txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"id=%d offload clash, %s vs %s",

Suggest keep the same trace fmt. e.g.: Ethdev port_id=%u
The same below

> +			port_id,
> +			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS),
> +			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE));
> +		ret = -EINVAL;
> +		goto rollback;
> +	}
> +
>  	dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf =
>  		rte_eth_rss_hf_refine(dev_conf->rx_adv_conf.rss_conf.rss_hf);
>  
> @@ -2709,6 +2721,31 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * If the driver uses a Tx function with MBUF_FAST_FREE preconditions,
> +	 * per-queue MULTI_SEGS support is not possible.
> +	 */
> +	if ((dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
> +			(local_conf.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"id=%d txq=%d offload clash, per-queue %s vs per-port %s",
> +			port_id, tx_queue_id,
> +			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS),
> +			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE));
> +		return -EINVAL;
> +	}
> +	/*
> +	 * If the driver uses a Tx function with MULTI_SEGS support,
> +	 * runtime support for per-queue MBUF_FAST_FREE optimization depends on the driver.
> +	 */
> +	if ((dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) &&
> +			(local_conf.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE))
> +		RTE_ETHDEV_LOG_LINE(DEBUG,
> +			"id=%d txq=%d potential offload clash, per-queue %s vs per-port %s: PMD to decide",
> +			port_id, tx_queue_id,
> +			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE),
> +			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS));

1\ The global port configuration will take effect on all queues.
   If it don't support both MBUF_FAST_FREE and MULTI_SEG, why don't ban it here?
2\ Debug level is easy to ignore, how about warning?

> +
>  	rte_ethdev_trace_txq_setup(port_id, tx_queue_id, nb_tx_desc, tx_conf);
>  	return eth_err(port_id, dev->dev_ops->tx_queue_setup(dev,
>  		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));

