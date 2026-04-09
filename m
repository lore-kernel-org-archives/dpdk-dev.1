Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61F7E9DE41
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 06:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52F95402D3;
	Thu,  9 Apr 2026 08:59:10 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 9B4EB402D1
 for <dev@dpdk.org>; Thu,  9 Apr 2026 08:59:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 5604938
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1775717947;
 bh=P3bTILI2PNA7m7tWhu+pA3O612NlBn3W56tFBugZq4I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qatgEwNnqpFuDqKYGcI1wzSgYiTx3lTBvzvcZjRqybqGmrXnB9e00T6GYsm4I6u6O
 pTHQin3jiBA9F4uS581+rkODa0qQN8B6YSvjq/iPpHDLunT+5VaxL36Nk86TkJiqgh
 T2JcQcMJZbCWLrX4/ppUGd1k5/ezWC8HWD7hMLgg=
Received: from [192.168.1.42] (unknown [188.170.74.13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 5604938;
 Thu,  9 Apr 2026 09:59:06 +0300 (MSK)
Message-ID: <c04d3145-d6e9-4583-b49c-82341ea9b0aa@oktetlabs.ru>
Date: Thu, 9 Apr 2026 09:59:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260409013658.965613-1-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20260409013658.965613-1-stephen@networkplumber.org>
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

On 4/9/26 4:36 AM, Stephen Hemminger wrote:
> rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
> buffer with no bounds checking. A mistaken caller that supplies a
> buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.
> 
> Add a size parameter and replace strcpy() with strlcpy(), returning
> -ERANGE if the name is truncated. The copy is now performed under
> the ethdev shared data lock so that the name cannot be mutated by
> another process between reading and copying.
> 
> The previous ABI is preserved via symbol versioning (DPDK_26) with a
> thin wrapper that delegates to the new implementation with
> RTE_ETH_NAME_MAX_LEN. The versioned symbol will be removed in 26.11.
> 
> Update all in-tree callers to pass sizeof(name) as the new parameter.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

with notes below fixed

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index 2edc7a362e..586a56bd46 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -721,12 +721,9 @@ rte_eth_dev_count_total(void)
>   	return count;
>   }
>   
> -RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
> -int
> -rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
> +static int
> +eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size)
>   {
> -	char *tmp;
> -
>   	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
>   
>   	if (name == NULL) {
> @@ -735,19 +732,46 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
>   		return -EINVAL;
>   	}
>   
> +	if (size == 0) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"Cannot get ethdev port %u name with zero-size buffer", port_id);
> +		return -EINVAL;
> +	}
> +
>   	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
> -	/* shouldn't check 'rte_eth_devices[i].data',
> -	 * because it might be overwritten by VDEV PMD */
> -	tmp = eth_dev_shared_data->data[port_id].name;
> +	/*
> +	 * Use the shared data name rather than rte_eth_devices[].data->name
> +	 * because VDEV PMDs may overwrite the per-process data pointer.
> +	 */
> +	size_t n = strlcpy(name, eth_dev_shared_data->data[port_id].name, size);

As far as I know typically variable declaration and code are not mixed
in DPDK.

>   	rte_spinlock_unlock(rte_mcfg_ethdev_get_lock());
>   
> -	strcpy(name, tmp);
> +	if (n >= size) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +				    "ethdev port %u name exceeds buffer size %zu",
> +				    port_id, size);
> +		return -ERANGE;
> +	}
>   
>   	rte_ethdev_trace_get_name_by_port(port_id, name);
>   
>   	return 0;
>   }

[...]

> diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
> index ac94efe7ff..57c81d4322 100644
> --- a/lib/pdump/rte_pdump.c
> +++ b/lib/pdump/rte_pdump.c
> @@ -736,7 +736,7 @@ pdump_validate_port(uint16_t port, char *name)
>   		return -1;
>   	}
>   
> -	ret = rte_eth_dev_get_name_by_port(port, name);
> +	ret = rte_eth_dev_get_name_by_port(port, name, sizeof(name));

It is definitely a bug here since name is a pointer.

>   	if (ret < 0) {
>   		PDUMP_LOG_LINE(ERR, "port %u to name mapping failed",
>   			  port);

