Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16845C021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 02:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D6EB402BB;
	Wed, 12 Feb 2025 03:01:19 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 86FC440269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 03:01:16 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yt1fZ3HBBzkXJv;
 Wed, 12 Feb 2025 09:57:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9E7FA14022E;
 Wed, 12 Feb 2025 10:01:14 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 10:01:14 +0800
Message-ID: <49539947-48de-415e-b968-776eab0f3797@huawei.com>
Date: Wed, 12 Feb 2025 10:01:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] eal: add new secure free function
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
 <20250211173720.1188517-3-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250211173720.1188517-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2025/2/12 1:35, Stephen Hemminger wrote:
> Although internally rte_free does poison the buffer in most
> cases, it is useful to have function that explicitly does
> this to avoid any security issues.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/rte_malloc.c  | 30 ++++++++++++++++++++++++------
>  lib/eal/include/rte_malloc.h | 18 ++++++++++++++++++
>  lib/eal/version.map          |  3 +++
>  3 files changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
> index 3eed4d4be6..c9e0f4724f 100644
> --- a/lib/eal/common/rte_malloc.c
> +++ b/lib/eal/common/rte_malloc.c
> @@ -15,6 +15,7 @@
>  #include <rte_eal_memconfig.h>
>  #include <rte_common.h>
>  #include <rte_spinlock.h>
> +#include <rte_string_fns.h>
>  
>  #include <eal_trace_internal.h>
>  
> @@ -27,27 +28,44 @@
>  
>  
>  /* Free the memory space back to heap */
> -static void
> -mem_free(void *addr, const bool trace_ena)
> +static inline void
> +mem_free(void *addr, const bool trace_ena, bool zero)
>  {
> +	struct malloc_elem *elem;
> +
>  	if (trace_ena)
>  		rte_eal_trace_mem_free(addr);
>  
> -	if (addr == NULL) return;
> -	if (malloc_heap_free(malloc_elem_from_data(addr)) < 0)
> +	if (addr == NULL)
> +		return;
> +
> +	elem = malloc_elem_from_data(addr);
> +	if (zero) {
> +		size_t data_len = elem->size - MALLOC_ELEM_OVERHEAD;

this will make rte_malloc know the layout of malloc-elem.
Prefer to add extra paramter, e.g. malloc_heap_free(elem, bool zero)

> +
> +		rte_memset_sensitive(addr, 0, data_len);
> +	}
> +
> +	if (malloc_heap_free(elem) < 0)
>  		EAL_LOG(ERR, "Error: Invalid memory");
>  }
>  
>  void
>  rte_free(void *addr)
>  {
> -	mem_free(addr, true);
> +	mem_free(addr, true, false);
> +}
> +
> +void
> +rte_free_sensitive(void *addr)
> +{
> +	mem_free(addr, true, true);
>  }
>  
>  void
>  eal_free_no_trace(void *addr)
>  {
> -	mem_free(addr, false);
> +	mem_free(addr, false, false);
>  }
>  
>  static void *
> diff --git a/lib/eal/include/rte_malloc.h b/lib/eal/include/rte_malloc.h
> index c8836de67c..d472ebb7db 100644
> --- a/lib/eal/include/rte_malloc.h
> +++ b/lib/eal/include/rte_malloc.h
> @@ -51,6 +51,24 @@ struct rte_malloc_socket_stats {
>  void
>  rte_free(void *ptr);
>  
> +
> +/**
> + * Frees the memory space pointed to by the provided pointer
> + * and guarantees it will be zero'd before reuse.
> + *
> + * This pointer must have been returned by a previous call to
> + * rte_malloc(), rte_zmalloc(), rte_calloc() or rte_realloc(). The behaviour of
> + * rte_free() is undefined if the pointer does not match this requirement.

Suggest add notice: The value may be cleared twice, which affects the performance.

> + *
> + * If the pointer is NULL, the function does nothing.
> + *
> + * @param ptr
> + *   The pointer to memory to be freed.
> + */
> +__rte_experimental
> +void
> +rte_free_sensitive(void *ptr);

one line is OK.
void rte_free_sensitive(void *ptr);

> +
>  /**
>   * This function allocates memory from the huge-page area of memory. The memory
>   * is not cleared. In NUMA systems, the memory allocated resides on the same
> diff --git a/lib/eal/version.map b/lib/eal/version.map
> index a20c713eb1..fa67ff44d5 100644
> --- a/lib/eal/version.map
> +++ b/lib/eal/version.map
> @@ -398,6 +398,9 @@ EXPERIMENTAL {
>  	# added in 24.11
>  	rte_bitset_to_str;
>  	rte_lcore_var_alloc;
> +
> +	# added in 25.03
> +	rte_free_sensitive;
>  };
>  
>  INTERNAL {

