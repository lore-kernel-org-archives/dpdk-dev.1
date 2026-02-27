Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D85FD5316
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 454984027F;
	Fri, 27 Feb 2026 10:20:15 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id E35204003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 10:20:13 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=R+hmh0XS3wx1brfThcg87StgihN2f+ipGhLlOB5/Qvo=;
 b=ARUdpG+u3fo4yvSXhTNb7Yhf4muTbG9bvzEL6fq0a7DxHUpl8yr4Co/lfPRcnM+gRmnpD4BOV
 rjnKMiVeAKUIZzb5fp1jQEMmCvCNI30+7WegezmKyEq7Knt24LJjvGzVEOMJUSIgHvt6rs9KrO/
 xvA4NJHB3lGUIsYCSUoPjB4=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fMjTK73jjz1BG3v
 for <dev@dpdk.org>; Fri, 27 Feb 2026 17:19:49 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=R+hmh0XS3wx1brfThcg87StgihN2f+ipGhLlOB5/Qvo=;
 b=ARUdpG+u3fo4yvSXhTNb7Yhf4muTbG9bvzEL6fq0a7DxHUpl8yr4Co/lfPRcnM+gRmnpD4BOV
 rjnKMiVeAKUIZzb5fp1jQEMmCvCNI30+7WegezmKyEq7Knt24LJjvGzVEOMJUSIgHvt6rs9KrO/
 xvA4NJHB3lGUIsYCSUoPjB4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fMjN253J5z1T4Fq;
 Fri, 27 Feb 2026 17:15:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 51B7740569;
 Fri, 27 Feb 2026 17:20:09 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 17:20:08 +0800
Message-ID: <78c276d7-6d80-408c-a1f2-a92f1a89a9ea@huawei.com>
Date: Fri, 27 Feb 2026 17:20:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mempool: introduce statistics reset function
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Stephen Hemminger
 <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <20260224092802.359592-1-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260224092802.359592-1-mb@smartsharesystems.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Another question:
   How about the overload of mempool stats, If the cost is low, can we
   remove the debug macro? As far as I know, some DPDK applications enable
   mempool statistics (maybe self-impl) in the production environment,
   which is mainly used to help locate problems.

On 2/24/2026 5:28 PM, Morten Brørup wrote:
> Populating a mempool with objects is accounted for in the statistics.
> When analyzing mempool cache statistics, this may distort the data.
> In order to simplify mempool cache statistics analysis, a mempool
> statistics reset function was added.
> 
> Furthermore, details about average burst sizes and mempool cache miss
> rates were added to the statistics shown when dumping a mempool.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v2:
> * Added detailed usage instructions to the function description. (Andrew)
> * Added DEBUG log message to the function. (Andrew)
> ---
>  lib/mempool/mempool_trace.h        |  7 ++++
>  lib/mempool/mempool_trace_points.c |  4 +++
>  lib/mempool/rte_mempool.c          | 51 ++++++++++++++++++++++++++++--
>  lib/mempool/rte_mempool.h          | 29 +++++++++++++++++
>  4 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/mempool/mempool_trace.h b/lib/mempool/mempool_trace.h
> index c595a3116b..23cda1473c 100644
> --- a/lib/mempool/mempool_trace.h
> +++ b/lib/mempool/mempool_trace.h
> @@ -104,6 +104,13 @@ RTE_TRACE_POINT(
>  	rte_trace_point_emit_string(mempool->name);
>  )
>  
> +RTE_TRACE_POINT(
> +	rte_mempool_trace_stats_reset,
> +	RTE_TRACE_POINT_ARGS(struct rte_mempool *mempool),
> +	rte_trace_point_emit_ptr(mempool);
> +	rte_trace_point_emit_string(mempool->name);
> +)
> +
>  RTE_TRACE_POINT(
>  	rte_mempool_trace_cache_create,
>  	RTE_TRACE_POINT_ARGS(uint32_t size, int socket_id,
> diff --git a/lib/mempool/mempool_trace_points.c b/lib/mempool/mempool_trace_points.c
> index ec465780f4..8249981502 100644
> --- a/lib/mempool/mempool_trace_points.c
> +++ b/lib/mempool/mempool_trace_points.c
> @@ -60,6 +60,10 @@ RTE_TRACE_POINT_REGISTER(rte_mempool_trace_populate_default,
>  RTE_TRACE_POINT_REGISTER(rte_mempool_trace_populate_anon,
>  	lib.mempool.populate.anon)
>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_stats_reset, 26.03)
> +RTE_TRACE_POINT_REGISTER(rte_mempool_trace_stats_reset,
> +	lib.mempool.stats_reset)
> +
>  RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_create,
>  	lib.mempool.cache_create)
>  
> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 3042d94c14..d33ea15157 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -1049,6 +1049,29 @@ rte_mempool_in_use_count(const struct rte_mempool *mp)
>  	return mp->size - rte_mempool_avail_count(mp);
>  }
>  
> +/* Reset the statistics of a mempool. */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_stats_reset, 26.03)
> +void
> +rte_mempool_stats_reset(struct rte_mempool *mp)
> +{
> +	RTE_ASSERT(mp != NULL);
> +
> +#ifdef RTE_LIBRTE_MEMPOOL_STATS
> +	memset(&mp->stats, 0, sizeof(mp->stats));
> +	if (mp->cache_size != 0) {
> +		for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
> +			memset(&mp->local_cache[lcore_id].stats, 0,
> +					sizeof(mp->local_cache[lcore_id].stats));
> +		}
> +	}
> +
> +	RTE_MEMPOOL_LOG(DEBUG, "<%s>@%p: statistics reset", mp->name, mp);
> +	rte_mempool_trace_stats_reset(mp);
> +#else
> +	RTE_SET_USED(mp);
> +#endif
> +}
> +
>  /* dump the cache status */
>  static unsigned
>  rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
> @@ -1327,10 +1350,34 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
>  	fprintf(f, "    get_fail_bulk=%"PRIu64"\n", sum.get_fail_bulk);
>  	fprintf(f, "    get_fail_objs=%"PRIu64"\n", sum.get_fail_objs);
>  	if (info.contig_block_size > 0) {
> -		fprintf(f, "    get_success_blks=%"PRIu64"\n",
> -			sum.get_success_blks);
> +		fprintf(f, "    get_success_blks=%"PRIu64"\n", sum.get_success_blks);
>  		fprintf(f, "    get_fail_blks=%"PRIu64"\n", sum.get_fail_blks);
>  	}
> +	fprintf(f, "    avg objs/bulk put=%#Lf, get=%#Lf, get_fail=%#Lf\n",
> +			sum.put_bulk != 0 ? (long double)sum.put_objs / sum.put_bulk : 0,
> +			sum.get_success_bulk != 0 ?
> +			(long double)sum.get_success_objs / sum.get_success_bulk : 0,
> +			sum.get_fail_bulk != 0 ?
> +			(long double)sum.get_fail_objs / sum.get_fail_bulk : 0);
> +	fprintf(f, "    avg common_pool objs/bulk put=%#Lf, get=%#Lf\n",
> +			sum.put_common_pool_bulk != 0 ?
> +			(long double)sum.put_common_pool_objs / sum.put_common_pool_bulk : 0,
> +			sum.get_common_pool_bulk != 0 ?
> +			(long double)sum.get_common_pool_objs / sum.get_common_pool_bulk : 0);
> +	fprintf(f, "    avg cache miss rate put_objs=%s%#Lf, get_objs=%s%#Lf\n",
> +			sum.put_common_pool_objs != 0 ? "1/" : "",
> +			sum.put_common_pool_objs != 0 ?
> +			(long double)sum.put_objs / sum.put_common_pool_objs : 0,
> +			sum.get_common_pool_objs != 0 ? "1/" : "",
> +			sum.get_common_pool_objs != 0 ?
> +			(long double)sum.get_success_objs / sum.get_common_pool_objs : 0);
> +	fprintf(f, "    avg cache miss rate put_bulk=%s%#Lf, get_bulk=%s%#Lf\n",
> +			sum.put_common_pool_bulk != 0 ? "1/" : "",
> +			sum.put_common_pool_bulk != 0 ?
> +			(long double)sum.put_bulk / sum.put_common_pool_bulk : 0,
> +			sum.get_common_pool_bulk != 0 ? "1/" : "",
> +			sum.get_common_pool_bulk != 0 ?
> +			(long double)sum.get_success_bulk / sum.get_common_pool_bulk : 0);
>  #else
>  	fprintf(f, "  no statistics available\n");
>  #endif
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index 1144dca58a..0b62837534 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -1288,6 +1288,35 @@ uint32_t rte_mempool_obj_iter(struct rte_mempool *mp,
>  uint32_t rte_mempool_mem_iter(struct rte_mempool *mp,
>  	rte_mempool_mem_cb_t *mem_cb, void *mem_cb_arg);
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
> + *
> + * Reset the statistics of a mempool.
> + *
> + * This function is intended for use when analyzing mempool statistics
> + * without counting any mempool operations performed during application
> + * initialization.
> + * For example, populating the mempool counts as put operations into the
> + * common pool, and setting up ethdev Rx queues counts as get operations.
> + *
> + * This function should only be called after application initialization,
> + * before the data path is started; otherwise, the mempool statistics may
> + * become inconsistent.
> + *
> + * For a perfectly clean slate, the local caches of the mempools used
> + * during application initialization should be flushed before resetting
> + * the mempool statistics.
> + * For example, mbuf pools used by ethdev Rx queues.
> + *
> + * @see rte_mempool_cache_flush()
> + *
> + * @param mp
> + *   A pointer to the mempool structure.
> + */
> +__rte_experimental
> +void rte_mempool_stats_reset(struct rte_mempool *mp);
> +
>  /**
>   * Dump the status of the mempool to a file.
>   *

