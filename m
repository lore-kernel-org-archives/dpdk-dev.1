Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF79C88CB9
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:04:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C2734042E;
	Mon, 11 Aug 2025 13:04:45 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 28CC94013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:04:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru EEA1562
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754910282;
 bh=QYgLNlsIH8nMPH9zZVnfkO1XXoUqwmTHxejDFbakiEI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Tb7BVgC8kGKmQnp91+o8Kc34zqyzf5/+CF+h9j/ImEwXqgiybZ6hyioVM2TQCgqPC
 6yr+POO75Qt5A+IvL9qcv7+g5WYv69a9zPDmBXjFlRdrKpVu5N4/+uVOoc+v7Lg79K
 yvx9sd2KUTXOGwKx7oxUua7amkCtUaf51SMiB7kc=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id EEA1562;
 Mon, 11 Aug 2025 14:04:41 +0300 (MSK)
Message-ID: <ccfed5f1-8a42-44dd-a350-702641064dff@oktetlabs.ru>
Date: Mon, 11 Aug 2025 14:04:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/14] ethdev: add port mirroring feature
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
 <20250808165843.39075-10-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250808165843.39075-10-stephen@networkplumber.org>
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

On 8/8/25 19:55, Stephen Hemminger wrote:
> This adds new feature port mirroring to the ethdev layer.
> And standalone tests for those features.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

[snip]

> @@ -513,23 +551,25 @@ static_assert(sizeof(struct ethdev_mp_response) <= RTE_MP_MAX_PARAM_LEN,
>   int
>   ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
>   {
> -	const struct ethdev_mp_request *req
> -		= (const struct ethdev_mp_request *)mp_msg->param;
> -
>   	struct rte_mp_msg mp_resp = {
>   		.name = ETHDEV_MP,
>   	};
>   	struct ethdev_mp_response *resp;
> +	const struct ethdev_mp_request *req;
>   
>   	resp = (struct ethdev_mp_response *)mp_resp.param;
>   	mp_resp.len_param = sizeof(*resp);
> -	resp->res_op = req->operation;
>   
>   	/* recv client requests */
> -	if (mp_msg->len_param != sizeof(*req))
> +	if (mp_msg->len_param < (int)sizeof(*req)) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "invalid request from secondary");
>   		resp->err_value = -EINVAL;
> -	else
> -		resp->err_value = ethdev_handle_request(req);
> +	} else {
> +		req = (const struct ethdev_mp_request *)mp_msg->param;
> +		resp->res_op = req->operation;
> +		resp->err_value = ethdev_handle_request(req, mp_msg->len_param);
> +
> +	}

Above changes in ethdev_server() looks unrelated to the patch.

>   
>   	return rte_mp_reply(&mp_resp, peer);
>   }
> diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
> index f58f161871..d2fdc20057 100644
> --- a/lib/ethdev/ethdev_private.h
> +++ b/lib/ethdev/ethdev_private.h
> @@ -85,6 +85,9 @@ int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
>   enum ethdev_mp_operation {
>   	ETH_REQ_START,
>   	ETH_REQ_STOP,
> +	ETH_REQ_RESET,

unrelated to the patch

> +	ETH_REQ_ADD_MIRROR,
> +	ETH_REQ_REMOVE_MIRROR,
>   };
>   
>   struct ethdev_mp_request {


> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index adeec575be..ac889c220a 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -14,6 +14,8 @@
>   #include <bus_driver.h>
>   #include <eal_export.h>
>   #include <rte_log.h>
> +#include <rte_cycles.h>
> +#include <rte_alarm.h>

Looks unrelated

>   #include <rte_interrupts.h>
>   #include <rte_kvargs.h>
>   #include <rte_memcpy.h>
> @@ -2041,13 +2043,16 @@ rte_eth_dev_reset(uint16_t port_id)
>   	if (dev->dev_ops->dev_reset == NULL)
>   		return -ENOTSUP;
>   
> -	ret = rte_eth_dev_stop(port_id);
> -	if (ret != 0) {
> -		RTE_ETHDEV_LOG_LINE(ERR,
> -			"Failed to stop device (port %u) before reset: %s - ignore",
> -			port_id, rte_strerror(-ret));
> +	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +		ret = rte_eth_dev_stop(port_id);
> +		if (ret != 0)
> +			RTE_ETHDEV_LOG_LINE(ERR,
> +				    "Failed to stop device (port %u) before reset: %s - ignore",
> +				    port_id, rte_strerror(-ret));
> +		ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));
> +	} else {
> +		ret = ethdev_request(port_id, ETH_REQ_STOP, NULL, 0);
>   	}
> -	ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));
>   
>   	rte_ethdev_trace_reset(port_id, ret);
>   

Abov looks unrelated to the patch. Also it is unclear why just sto is 
done in the case of secondary (without reset).


> diff --git a/lib/ethdev/rte_mirror.c b/lib/ethdev/rte_mirror.c
> new file mode 100644
> index 0000000000..27b613b8ff
> --- /dev/null
> +++ b/lib/ethdev/rte_mirror.c

[snip]

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_add_mirror, 25.11)
> +int
> +rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *conf)
> +{
> +#ifndef RTE_ETHDEV_MIRROR
> +	return -ENOTSUP;
> +#endif
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +
> +	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
> +	struct rte_eth_dev_info dev_info;
> +
> +	if (conf == NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Missing configuration information");

Please, mention "mirror" above to make error less generic. Otherwise, it
could easierly overlap with other messages.

> +		return -EINVAL;
> +	}
> +
> +	if (conf->mp == NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "not a valid mempool");

I'm confused since:
+	struct rte_mempool *mp;	/**< Memory pool for copies, If NULL then 
cloned. */

> +		return -EINVAL;
> +	}
> +
> +	if (conf->flags & ~(RTE_ETH_MIRROR_DIRECTION_MASK | RTE_ETH_MIRROR_FLAG_MASK)) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "unsupported flags");

Same as above, may I suggest to mention mirror here as well.

> +		return -EINVAL;
> +	}
> +

[snip]

> +
> +static inline void

inline looks suspicious here taking into account that the function has
loop. If you really need it, __rte_always_inline shoud be used.
Otherwise, just drop.

> +eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
> +	       struct rte_mbuf **pkts, uint16_t nb_pkts,
> +	       struct rte_eth_mirror *mirror)

[snip]

> +static int
> +ethdev_mirror_stats_reset(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_t target_id)
> +{
> +	struct rte_eth_mirror *mirror;
> +
> +	mirror = ethdev_find_mirror(head, target_id);
> +	if (mirror == NULL)
> +		return -1;
> +
> +	memset(&mirror->stats, 0, sizeof(struct rte_eth_mirror_stats));

You use sizeof(*stats) above, maybe it is better to be consistent here
as well and use sizeof(mirror->stats)?

[snip]

> diff --git a/lib/ethdev/rte_mirror.h b/lib/ethdev/rte_mirror.h
> new file mode 100644
> index 0000000000..593ef477b6
> --- /dev/null
> +++ b/lib/ethdev/rte_mirror.h

IMHO rte_mirror sounds too generic. May be it would be better to name it
ethdev-specific: rte_ethdev_mirror.h

> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
> + */
> +
> +#ifndef RTE_MIRROR_H_
> +#define RTE_MIRROR_H_

If name is changed above, don't forget to fix defines as well.

[snip]

> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
> + *
> + * Create a port mirror instance.
> + *
> + * @param port_id
> + *   The port identifier of the source Ethernet device.
> + * @param conf
> + *   Settings for this MIRROR instance.
> + * @return
> + *   Negative errno value on error, 0 on success.
> + */
> +__rte_experimental
> +int
> +rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *conf);

Please, join above two lines for consistency with style below.

[snip]
