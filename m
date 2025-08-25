Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82338CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 06:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 866944025E;
	Mon, 25 Aug 2025 08:47:14 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 5F1224025A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:47:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 776B940
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1756104431;
 bh=7iOOnaXqFsTYrxUlwVEjH+xyt36+M+cWtrMnhezYTow=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=gdCu2HSCa/KhfrRUh2T+r5zHp3aBFeCpC7y0RyaBRLv8MRja6qJcSKV+hdMzaJSbo
 ysiHNnkn/d++SwoxlsivQl6gKf4Z3UW5j93b52nqcu09NRczrDfL4KTSmN2A0uoCYd
 F6HZxKR0j5g4WSFGE0cul8GLNriVcpMW1yPIYBkI=
Received: from [192.168.1.42] (unknown [188.170.78.15])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 776B940;
 Mon, 25 Aug 2025 09:47:11 +0300 (MSK)
Message-ID: <beed579e-845b-4cd3-90f4-e28125935243@oktetlabs.ru>
Date: Mon, 25 Aug 2025 09:47:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/43] net/sfc: replace use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
 <20250825034126.12046-30-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250825034126.12046-30-stephen@networkplumber.org>
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

On 8/25/25 06:38, Stephen Hemminger wrote:
> Replace use of system sys/queue.h with DPDK rte_bsd_queue.h
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/net/sfc/sfc_dp.c | 2 +-
>   drivers/net/sfc/sfc_dp.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
> index 7e2a20e4dc..66ff2ed789 100644
> --- a/drivers/net/sfc/sfc_dp.c
> +++ b/drivers/net/sfc/sfc_dp.c
> @@ -7,7 +7,7 @@
>    * for Solarflare) and Solarflare Communications, Inc.
>    */
>   
> -#include <sys/queue.h>
> +#include <rte_bsd_queue.h>

IMHO it is not nice since headers are grouped and rte headers group is
located below.

>   #include <stdalign.h>
>   #include <string.h>
>   #include <errno.h>
> diff --git a/drivers/net/sfc/sfc_dp.h b/drivers/net/sfc/sfc_dp.h
> index 545f0f32bf..6f61b20a0f 100644
> --- a/drivers/net/sfc/sfc_dp.h
> +++ b/drivers/net/sfc/sfc_dp.h
> @@ -11,7 +11,6 @@
>   #define _SFC_DP_H
>   
>   #include <stdbool.h>
> -#include <sys/queue.h>

#include <rte_bsd_queue.h> is required here since TAILQ_HEAD is used 
below in the header.

>   
>   #include <rte_pci.h>
>   

