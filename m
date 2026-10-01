Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F692CA5FB3
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 08:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E1D34027A;
	Thu,  1 Oct 2026 10:14:16 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id AAF5D40144
 for <dev@dpdk.org>; Thu,  1 Oct 2026 10:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 8EBC64A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1790842454;
 bh=B8LXSZK/v07xJdrDim9ejreodI85hzqOegVd04qVxxQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V/7ffITsr4y5CvJ6H5nvrGl1N5OJhF8g9cKQ71xr03Z/qVfTQodAm1hDcKgrdHVqM
 RNsI0CYN/E7+rsTp5NIeeqxfZ1zsNrdccaEuliCgrKhdNGkkYO2m7CrhyflsIWWEkU
 LdsIS2oKAvyjqRz39PJUlusNd5TEI4XDLXdpXDyM=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 8EBC64A;
 Thu,  1 Oct 2026 11:14:14 +0300 (MSK)
Message-ID: <e42e8ade-b0e0-438f-b5a0-eb3f7e95397b@oktetlabs.ru>
Date: Thu, 1 Oct 2026 11:14:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethdev: replace rte_memcpy with assignment
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20260929155701.877309-1-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260929155701.877309-1-stephen@networkplumber.org>
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

On 9/29/26 6:57 PM, Stephen Hemminger wrote:
> Can use structure assignment instead of rte_memcpy here.

It would be useful to mention in the description or summary why
it is better.

Right now the description say what is done, but it is obvious
from the code change.

> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   lib/ethdev/rte_ethdev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index 7c57a9bb8f..6f5a957d00 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -16,7 +16,6 @@
>   #include <rte_log.h>
>   #include <rte_interrupts.h>
>   #include <rte_kvargs.h>
> -#include <rte_memcpy.h>
>   #include <rte_common.h>
>   #include <rte_mempool.h>
>   #include <rte_malloc.h>
> @@ -631,7 +630,7 @@ rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
>   	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
>   
>   	if (eth_dev_shared_data_prepare() != NULL) {
> -		rte_memcpy(owner, &ethdev->data->owner, sizeof(*owner));
> +		*owner = ethdev->data->owner;
>   		ret = 0;
>   	} else {
>   		ret = -ENOMEM;

