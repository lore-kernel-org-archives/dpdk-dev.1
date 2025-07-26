Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FC1C83F17
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 09:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94370402DD;
	Sat, 26 Jul 2025 11:15:53 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id C756C40144
 for <dev@dpdk.org>; Sat, 26 Jul 2025 11:15:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru F366450
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753521351;
 bh=dteQFKv3jfmrE1s/9p9F6RMsictFE3pEiG8/lgrAB7k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ti8jJfhGp/0mkDrE2ufTvTqE0k/tNsMh7CD2PWIa5tzjcf8qP50F57OlzbLCanOm5
 voU7w9ZCWn0jHPRWgupyrvfAyPV2AsE2vkd+ovRTHja6k3+WVXH4ua00yaMIjYxZWP
 lJfHguzq9PoDFYAwGmrPxKJlJI8wg7lyxPO1yJGs=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id F366450;
 Sat, 26 Jul 2025 12:15:50 +0300 (MSK)
Message-ID: <fb47cc2e-17a2-4e75-8adb-54933a756d00@oktetlabs.ru>
Date: Sat, 26 Jul 2025 12:15:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ethdev: remove callback checks from fast path
To: skori@marvell.com, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250512150732.65743-2-skori@marvell.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250512150732.65743-2-skori@marvell.com>
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

On 5/12/25 18:07, skori@marvell.com wrote:
> From: Sunil Kumar Kori <skori@marvell.com>
> 
> rte_eth_fp_ops contains ops for fast path APIs. Each API
> validates availability of callback and then invoke it.
> These checks impact data path performace.
> 
> Hence removing these NULL checks instead using dummy
> callbacks.
> 
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

with few nits fixed (see below):
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

[snip]

> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 2b4d2ae9c3..71085bddff 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -1874,6 +1874,77 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
>   		struct rte_mbuf **pkts __rte_unused,
>   		uint16_t nb_pkts __rte_unused);
>   
> +/**
> + * @internal
> + * Dummy DPDK callback for Tx packet prepare.
> + *
> + * @param queue
> + *  Pointer to Tx queue
> + * @param pkts
> + *  Packet array
> + * @param nb_pkts
> + *  Number of packets in packet array

Such descriptions do not help. Please, document return value since it is
always the same.

Fix all descriptions in the patch.

