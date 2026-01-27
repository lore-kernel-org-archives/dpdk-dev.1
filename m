Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849B7D2D8F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 11:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35290402CE;
	Tue, 27 Jan 2026 12:16:56 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 960FC400D6;
 Tue, 27 Jan 2026 12:16:54 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 0196516253;
 Tue, 27 Jan 2026 12:16:54 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id E8715161CC; Tue, 27 Jan 2026 12:16:53 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 8FD0616321;
 Tue, 27 Jan 2026 12:16:51 +0100 (CET)
Message-ID: <b4b00e90-e300-4457-aaf6-0c43a430384e@lysator.liu.se>
Date: Tue, 27 Jan 2026 12:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 1/2] eal: remove alloc_size from rte_lcore_var_alloc
To: scott.k.mitch1@gmail.com, dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, mattias.ronnblom@ericsson.com, stable@dpdk.org
References: <20260127020246.53057-1-scott.k.mitch1@gmail.com>
 <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260127052900.68045-2-scott.k.mitch1@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260127052900.68045-2-scott.k.mitch1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 1/27/26 06:28, scott.k.mitch1@gmail.com wrote:
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
> semantically incorrect and causes false positives with FORTIFY_SOURCE
> runtime checks.
> 
> The attribute tells the compiler that the function returns a pointer
> to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
> actually returns a handle to a per-lcore variable scheme. The
> allocator internally allocates 'size' bytes per lcore
> (size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
> The handle points to lcore 0's copy, and accessed via
> RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
> handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
> beyond 'size' bytes beyond the returned pointer when 'lcore_id != 0'
> but FORTIFY_SOURCE may terminate the program due to out of bounds
> access.
> 
> This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
> '*** buffer overflow detected ***: terminated' if pointer provenance
> is preserved (e.g. if offsets avoid casting to uintptr_t).
> 
> Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation facility")
> Cc: mattias.ronnblom@ericsson.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---

Acked-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

Thanks!

>   lib/eal/include/rte_lcore_var.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
> index ca31dff6fd..48b022e84e 100644
> --- a/lib/eal/include/rte_lcore_var.h
> +++ b/lib/eal/include/rte_lcore_var.h
> @@ -202,7 +202,7 @@ rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
>   __rte_experimental
>   void *
>   rte_lcore_var_alloc(size_t size, size_t align)
> -	__rte_alloc_size(1) __rte_alloc_align(2);
> +	__rte_alloc_align(2);
>   
>   #ifdef __cplusplus
>   }

