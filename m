Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3097BCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 07:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30F1140150;
	Tue, 23 Jun 2026 09:11:11 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 21CC94014F
 for <dev@dpdk.org>; Tue, 23 Jun 2026 09:11:09 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9XI78DnGu0/P9g3dYXjcC+Qg5H7GRHb1aXjvb17O9Fc=;
 b=O+D79IFgptLhN9ew3BCXpWRA/PK2xIT/lMGqqnLMRZqBPs4LAwSbbwJtOejPUGlPJnCnPJZ7f
 xoMl+0gwgODlbjP3MLkzRu7Wzk/2qapF4vRbfyBFPDDTYdPGdXYQjAvZzgN+hJaS4CuO60a87vq
 CxUVQ6iuaEJQeHlIUPKaRmY=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gkwxL4LznzcZyn;
 Tue, 23 Jun 2026 15:02:30 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9XI78DnGu0/P9g3dYXjcC+Qg5H7GRHb1aXjvb17O9Fc=;
 b=O+D79IFgptLhN9ew3BCXpWRA/PK2xIT/lMGqqnLMRZqBPs4LAwSbbwJtOejPUGlPJnCnPJZ7f
 xoMl+0gwgODlbjP3MLkzRu7Wzk/2qapF4vRbfyBFPDDTYdPGdXYQjAvZzgN+hJaS4CuO60a87vq
 CxUVQ6iuaEJQeHlIUPKaRmY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gkwxB45VNz1T4HG;
 Tue, 23 Jun 2026 15:02:22 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id D3A3240576;
 Tue, 23 Jun 2026 15:11:01 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 15:11:00 +0800
Message-ID: <f6fdf5cf-fee2-053e-3c78-914450fe925a@huawei.com>
Date: Tue, 23 Jun 2026 15:11:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] common/mlx5: fix high SMMU TLB miss with mempool alignment
Content-Language: en-CA
From: yangxingui <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <thomas@monjalon.net>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <dmitry.kozliuk@gmail.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260612071434.2722918-1-yangxingui@huawei.com>
In-Reply-To: <20260612071434.2722918-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh100016.china.huawei.com (7.202.181.102) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

Friendly ping...

On 2026/6/12 15:14, Xingui Yang wrote:
> From: Shuaisong Yang <yangshuaisong@h-partners.com>
> 
> On Kunpeng SoC with mlx CX7, dpdk-l3fwd with intra-NUMA core pinning
> under SMMU nonstrict/strict mode shows about 30% performance degradation
> compared to cross-NUMA pinning. With SMMU disabled or passthrough mode,
> intra-NUMA performs as expected (slightly better than cross-NUMA).
> 
> CX7 in NUMA1
> NUMA node0 CPU(s):    0-39
> NUMA node1 CPU(s):    40-79
> 
> intra-NUMA:
> dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=1 -- -p 0x1 -P \
>    --config='(0,0,40),(0,1,41),(0,2,42),(0,3,43),(0,4,44),\
>              (0,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\
>              (0,10,50),(0,11,51),(0,12,52),(0,13,53),\
>              (0,14,54),(0,15,55)' \
>    --rx-queue-size=4096 --tx-queue-size=4096 --rx-burst=64
> 
> cross-NUMA:
> dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=1 -- -p 0x1 -P \
>    --config='(0,0,11),(0,1,12),(0,2,13),(0,3,14),(0,4,15),\
>              (0,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\
>              (0,10,21),(0,11,22),(0,12,23),(0,13,24),\
>              (0,14,25),(0,15,26)' \
>    --rx-queue-size=4096 --tx-queue-size=4096 --rx-burst=64
> 
> The root cause is that under SMMU enabled mode, the mempool allocated
> for intra-NUMA pinning is aligned to system page size instead of
> hugepage size, while cross-NUMA pinning correctly uses hugepage size
> alignment. This causes high TLB miss rates under SMMU.
> 
> Align all memory ranges to hugepage boundaries during mempool
> registration to ensure hugepage_sz alignment, thereby reducing TLB
> misses and fixing the intra-NUMA performance degradation.
> 
> Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   .mailmap                             |  1 +
>   drivers/common/mlx5/mlx5_common_mr.c | 53 +++++++++++++++++++---------
>   2 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 4001e5fb0e..e13e88db1b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1979,3 +1979,4 @@ Zongyu Wu <wuzongyu1@huawei.com>
>   Zorik Machulsky <zorik@amazon.com>
>   Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
>   Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
> +Shuaisong Yang <yangshuaisong@h-partners.com>
> diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
> index aa2d5e88a4..aee037abb4 100644
> --- a/drivers/common/mlx5/mlx5_common_mr.c
> +++ b/drivers/common/mlx5/mlx5_common_mr.c
> @@ -1524,7 +1524,9 @@ mlx5_get_mempool_ranges(struct rte_mempool *mp, bool is_extmem,
>    * @param[in] is_extmem
>    *   Whether the pool is contains only external pinned buffers.
>    * @param[out] out
> - *   Receives memory ranges to register, aligned to the system page size.
> + *   Receives memory ranges to register. Aligned to the hugepage size
> + *   if all ranges reside on hugepages of the same size,
> + *   otherwise aligned to the system page size.
>    *   The caller must release them with free().
>    * @param[out] out_n
>    *   Receives the number of @p out items.
> @@ -1541,7 +1543,9 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bool is_extmem,
>   {
>   	struct mlx5_range *ranges = NULL;
>   	unsigned int i, ranges_n = 0;
> +	bool same_hugepage_sz = true;
>   	struct rte_memseg_list *msl;
> +	uint64_t hugepage_sz = 0;
>   
>   	if (mlx5_get_mempool_ranges(mp, is_extmem, &ranges, &ranges_n) < 0) {
>   		DRV_LOG(ERR, "Cannot get address ranges for mempool %s",
> @@ -1552,28 +1556,43 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bool is_extmem,
>   	*share_hugepage = false;
>   	msl = rte_mem_virt2memseg_list((void *)ranges[0].start);
>   	if (msl != NULL) {
> -		uint64_t hugepage_sz = 0;
> +		hugepage_sz = msl->page_sz;
>   
>   		/* Check that all ranges are on pages of the same size. */
>   		for (i = 0; i < ranges_n; i++) {
> -			if (hugepage_sz != 0 && hugepage_sz != msl->page_sz)
> +			struct rte_memseg_list *range_msl;
> +			range_msl = rte_mem_virt2memseg_list(
> +					(void *)ranges[i].start);
> +			if (range_msl == NULL ||
> +			    range_msl->page_sz != hugepage_sz) {
> +				same_hugepage_sz = false;
>   				break;
> -			hugepage_sz = msl->page_sz;
> +			}
>   		}
> -		if (i == ranges_n) {
> -			/*
> -			 * If the entire pool is within one hugepage,
> -			 * combine all ranges into one of the hugepage size.
> -			 */
> -			uintptr_t reg_start = ranges[0].start;
> -			uintptr_t reg_end = ranges[ranges_n - 1].end;
> -			uintptr_t hugepage_start =
> -				RTE_ALIGN_FLOOR(reg_start, hugepage_sz);
> -			uintptr_t hugepage_end = hugepage_start + hugepage_sz;
> -			if (reg_end < hugepage_end) {
> -				ranges[0].start = hugepage_start;
> +	}
> +	if (same_hugepage_sz && hugepage_sz > 0) {
> +		unsigned int orig_ranges_n = ranges_n;
> +
> +		for (i = 0; i < ranges_n; i++) {
> +			ranges[i].start = RTE_ALIGN_FLOOR(ranges[i].start,
> +							  hugepage_sz);
> +			ranges[i].end = RTE_ALIGN_CEIL(ranges[i].end,
> +							hugepage_sz);
> +		}
> +		ranges_n = 1;
> +		for (i = 1; i < orig_ranges_n; i++) {
> +			if (ranges[ranges_n - 1].end >= ranges[i].start)
> +				ranges[ranges_n - 1].end =
> +					RTE_MAX(ranges[ranges_n - 1].end,
> +						ranges[i].end);
> +			else
> +				ranges[ranges_n++] = ranges[i];
> +		}
> +		if (ranges_n == 1) {
> +			uintptr_t hugepage_end = ranges[0].start + hugepage_sz;
> +
> +			if (ranges[0].end <= hugepage_end) {
>   				ranges[0].end = hugepage_end;
> -				ranges_n = 1;
>   				*share_hugepage = true;
>   			}
>   		}
> 
