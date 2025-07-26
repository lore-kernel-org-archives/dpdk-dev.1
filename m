Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBACC87FCA
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 12:28:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BA9E40611;
	Sat, 26 Jul 2025 14:28:28 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 445074060B
 for <dev@dpdk.org>; Sat, 26 Jul 2025 14:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru B684350
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753532905;
 bh=ga2QpX22HHzAzwmuAfbYm0gXzfusyEApm/HwopNKTkI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D8QpApg2MLPouWhghOwKFghyySnyCU80H92qm84aJv4JvQgDluktHu72Ea6sADyan
 ci293ICJJQlqcYxPH78O4lezfdKrq0i1Gd3yUX3e4exLGwlFyUKy7T3HfvjyXpkYl2
 5JEGNb/NFYSyAJY62lnZx9KwWOHO6hpu+JMdWGRw=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id B684350;
 Sat, 26 Jul 2025 15:28:24 +0300 (MSK)
Message-ID: <fd5f0f6a-cc34-4177-80b4-bccacf5e075c@oktetlabs.ru>
Date: Sat, 26 Jul 2025 15:28:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] app/testpmd: cross NUMA support
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, rasland@nvidia.com,
 Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20250617155351.190622-1-mkashani@nvidia.com>
 <20250626175856.1579-1-mkashani@nvidia.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250626175856.1579-1-mkashani@nvidia.com>
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

On 6/26/25 20:58, Maayan Kashani wrote:
> Cross NUMA support means that
> if the current NUMA is out of memory,
> use another available NUMA memory.
> 
> This patch is meant to support cross NUMA in testpmd,
> when disabling gro, gro fix for cross NUMA will come later.
> 
> Replace pdump, metrics and dev shared data
> memory allocations to any socket
> instead of port socket id.
> 
> Replace mbuf pools allocations to any socket
> when --no-numa flag is set.

I think that the patch should be split into few patches.
First of all it would allow to explain in the description
why SOCKET_ID_ANY is the right choice here since it is not
always the right choice. So, explanations are required case by case.
Second, it would allow to use correct prefix in the summary.

Summary should hint which problem is solved, what is the goal of
the patch, since "cross NUMA support" is not the goal.

As I understand the main idea behind that in general
rte_socket_id() should not be used if we don't want to strictly
bind memory allocation to the current socket. SOCKET_ID_ANY
does the same as a priority (as far as I can see), but allows
to fallback to memory which belongs to other NUMA nodes.

> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>   app/test-pmd/testpmd.c      | 8 ++++----
>   lib/ethdev/ethdev_private.c | 2 +-
>   lib/pdump/rte_pdump.c       | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index 344c256c050..92a5d581bb9 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -1729,8 +1729,7 @@ init_config(void)
>   			mempools[i] = mbuf_pool_create
>   					(mbuf_data_size[i],
>   					 nb_mbuf_per_pool,
> -					 socket_num == UMA_NO_CONFIG ?
> -					 0 : socket_num, i);
> +					 SOCKET_ID_ANY, i);
>   	}
>   
>   	init_port_config();
> @@ -3057,7 +3056,8 @@ start_port(portid_t pid)
>   				} else {
>   					struct rte_mempool *mp =
>   						mbuf_pool_find
> -							(port->socket_id, 0);
> +							((numa_support ? port->socket_id :
> +							(unsigned int)SOCKET_ID_ANY), 0);
>   					if (mp == NULL) {
>   						fprintf(stderr,
>   							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
> @@ -4476,7 +4476,7 @@ main(int argc, char** argv)
>   
>   #ifdef RTE_LIB_METRICS
>   	/* Init metrics library */
> -	rte_metrics_init(rte_socket_id());
> +	rte_metrics_init(SOCKET_ID_ANY);
>   #endif
>   
>   #ifdef RTE_LIB_LATENCYSTATS
> diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> index b96d992ea12..285d377d91f 100644
> --- a/lib/ethdev/ethdev_private.c
> +++ b/lib/ethdev/ethdev_private.c
> @@ -343,7 +343,7 @@ eth_dev_shared_data_prepare(void)
>   		/* Allocate port data and ownership shared memory. */
>   		mz = rte_memzone_reserve(MZ_RTE_ETH_DEV_DATA,
>   				sizeof(*eth_dev_shared_data),
> -				rte_socket_id(), flags);
> +				SOCKET_ID_ANY, flags);
>   		if (mz == NULL) {
>   			RTE_ETHDEV_LOG_LINE(ERR, "Cannot allocate ethdev shared data");
>   			goto out;
> diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
> index 79b20ce59b2..ba75b828f2e 100644
> --- a/lib/pdump/rte_pdump.c
> +++ b/lib/pdump/rte_pdump.c
> @@ -426,7 +426,7 @@ rte_pdump_init(void)
>   	int ret;
>   
>   	mz = rte_memzone_reserve(MZ_RTE_PDUMP_STATS, sizeof(*pdump_stats),
> -				 rte_socket_id(), 0);
> +				 SOCKET_ID_ANY, 0);
>   	if (mz == NULL) {
>   		PDUMP_LOG_LINE(ERR, "cannot allocate pdump statistics");
>   		rte_errno = ENOMEM;

