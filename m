Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14691C5B549
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 01:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A224028E;
	Tue,  3 Jun 2025 03:10:05 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A54B74025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 03:10:03 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9A0E02113A62; Mon,  2 Jun 2025 18:10:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A0E02113A62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748913002;
 bh=o0M9qlZ2AobRPrZQP2F097UV3IuQyJD2Ys4EHNw0LoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YB0Cqz7Nl448ypsIFQl4Sgdq8eMdLqfYr9e4cJUIZvupNBwmuXzPJoCcQsos223U0
 Kkbc/kBQrfVFD+538wnl8eIg7gcAU8KVGLkuF21IUuyJyrkqlxREwQvqC3XRQzwOko
 39ytPZWsvEfX2LQkuHXNPtrcbAoZkV5HPWohxyVw=
Date: Mon, 2 Jun 2025 18:10:02 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/mlx5: use portable version of __builtin_ffsl
Message-ID: <20250603011002.GA1658@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746457492-10012-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746457492-10012-1-git-send-email-andremue@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Mon, May 05, 2025 at 08:04:52AM -0700, Andre Muezerie wrote:
> Builtin __builtin_ffsl is not available with MSVC therefore a
> portable replacement should be used.
> 
> Function rte_ffs32 is already available in eal and should be used
> instead.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/net/mlx5/mlx5_tx.c    | 4 ++--
>  drivers/net/mlx5/mlx5_utils.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
> index 39afca3d64..b2522e7170 100644
> --- a/drivers/net/mlx5/mlx5_tx.c
> +++ b/drivers/net/mlx5/mlx5_tx.c
> @@ -629,8 +629,8 @@ mlx5_select_tx_function(struct rte_eth_dev *dev)
>  		}
>  		if (tmp == diff) {
>  			tmp = txoff_func[i].olx ^ txoff_func[m].olx;
> -			if (__builtin_ffsl(txoff_func[i].olx & ~tmp) <
> -			    __builtin_ffsl(txoff_func[m].olx & ~tmp)) {
> +			if (rte_ffs32(txoff_func[i].olx & ~tmp) <
> +			    rte_ffs32(txoff_func[m].olx & ~tmp)) {
>  				/* Lighter not requested offload. */
>  				m = i;
>  			}
> diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
> index d882af6047..645bb118fb 100644
> --- a/drivers/net/mlx5/mlx5_utils.c
> +++ b/drivers/net/mlx5/mlx5_utils.c
> @@ -84,7 +84,7 @@ mlx5_ipool_create(struct mlx5_indexed_pool_config *cfg)
>  	if (!cfg || (!cfg->malloc ^ !cfg->free) ||
>  	    (cfg->per_core_cache && cfg->release_mem_en) ||
>  	    (cfg->trunk_size && ((cfg->trunk_size & (cfg->trunk_size - 1)) ||
> -	    ((__builtin_ffs(cfg->trunk_size) + TRUNK_IDX_BITS) > 32))))
> +	    ((rte_ffs32(cfg->trunk_size) + TRUNK_IDX_BITS) > 32))))
>  		return NULL;
>  	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool) + cfg->grow_trunk *
>  			   sizeof(pool->grow_tbl[0]), RTE_CACHE_LINE_SIZE,
> -- 
> 2.49.0.vfs.0.2

Would someone be able to review this patchset?
Thanks,

Andre Muezerie
