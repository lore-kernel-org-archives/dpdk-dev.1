Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D46C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:49:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF546402D4;
	Tue, 10 Jun 2025 08:49:05 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 442AB40299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:49:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bGfRp4TLLz1W3Ny;
 Tue, 10 Jun 2025 14:45:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 96AB0180087;
 Tue, 10 Jun 2025 14:49:01 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 14:48:53 +0800
Message-ID: <3051d7ed-ccc8-45c3-8e2e-d76efa1146c5@huawei.com>
Date: Tue, 10 Jun 2025 14:48:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] test/dma: add functions to verify zero and one fill
To: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <gakhil@marvell.com>, <jerinj@marvell.com>, <anoobj@marvell.com>,
 <asasidharan@marvell.com>, <dev@dpdk.org>, Amit Prakash Shukla
 <amitprakashs@marvell.com>
References: <20250606094031.2961842-1-vvelumuri@marvell.com>
 <20250609030314.4098409-1-vvelumuri@marvell.com>
 <20250609030314.4098409-2-vvelumuri@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250609030314.4098409-2-vvelumuri@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Hi Vidya,

How about add a wrap function and keep this function (could modify it's name).

static int
test_enqueue_fill() {
	uint64_t pattern[3] = {0x0, 0xfedcba9876543210, 0xffffffffffffffff};
	int i;
	for (i = 0; i < RTE_DIM(pattern); i++) {
		ret = test_enqueue_fill_patter(dev_id, vchan, pattern[i]);
		if (ret)
			return ret;
	}
	return 0;
}

On 2025/6/9 11:03, Vidya Sagar Velumuri wrote:
> Add test cases to verify zero fill and one fill
> 
> Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>
> 
> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index 88c3d02fd6..0c67aaceb2 100644
> --- a/app/test/test_dmadev.c
> +++ b/app/test/test_dmadev.c
> @@ -872,42 +872,51 @@ test_completion_handling(int16_t dev_id, uint16_t vchan)
>  static int
>  test_enqueue_fill(int16_t dev_id, uint16_t vchan)
>  {
> +	uint64_t pattern[3] = {0x0, 0xfedcba9876543210, 0xffffffffffffffff};
>  	const unsigned int lengths[] = {8, 64, 1024, 50, 100, 89};
> +	unsigned int i, j, k;
>  	struct rte_mbuf *dst;
>  	char *dst_data;
> -	uint64_t pattern = 0xfedcba9876543210;
> -	unsigned int i, j;
>  
>  	dst = rte_pktmbuf_alloc(pool);
>  	if (dst == NULL)
>  		ERR_RETURN("Failed to allocate mbuf\n");
>  	dst_data = rte_pktmbuf_mtod(dst, char *);
>  
> -	for (i = 0; i < RTE_DIM(lengths); i++) {
> -		/* reset dst_data */
> -		memset(dst_data, 0, rte_pktmbuf_data_len(dst));
> +	for (k = 0; k < RTE_DIM(pattern); k++) {
> +		for (i = 0; i < RTE_DIM(lengths); i++) {
> +			/* reset dst_data */
> +			memset(dst_data, 0, rte_pktmbuf_data_len(dst));
> +
> +			/* perform the fill operation */
> +			int id = rte_dma_fill(dev_id, vchan, pattern[k],
> +					rte_pktmbuf_iova(dst), lengths[i], RTE_DMA_OP_FLAG_SUBMIT);
> +			if (id < 0) {
> +				if (id == -ENOTSUP) {
> +					rte_pktmbuf_free(dst);
> +					break;
> +				}
> +				ERR_RETURN("Error with rte_dma_fill\n");
> +			}
> +			await_hw(dev_id, vchan);
>  
> -		/* perform the fill operation */
> -		int id = rte_dma_fill(dev_id, vchan, pattern,
> -				rte_pktmbuf_iova(dst), lengths[i], RTE_DMA_OP_FLAG_SUBMIT);
> -		if (id < 0)
> -			ERR_RETURN("Error with rte_dma_fill\n");
> -		await_hw(dev_id, vchan);
> +			if (rte_dma_completed(dev_id, vchan, 1, NULL, NULL) != 1)
> +				ERR_RETURN("Error: fill operation failed (length: %u)\n",
> +					   lengths[i]);
> +			/* check the data from the fill operation is correct */
> +			for (j = 0; j < lengths[i]; j++) {
> +				char pat_byte = ((char *)&pattern[k])[j % 8];
>  
> -		if (rte_dma_completed(dev_id, vchan, 1, NULL, NULL) != 1)
> -			ERR_RETURN("Error: fill operation failed (length: %u)\n", lengths[i]);
> -		/* check the data from the fill operation is correct */
> -		for (j = 0; j < lengths[i]; j++) {
> -			char pat_byte = ((char *)&pattern)[j % 8];
> -			if (dst_data[j] != pat_byte)
> -				ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
> -						lengths[i], dst_data[j], pat_byte);
> +				if (dst_data[j] != pat_byte)
> +					ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
> +							lengths[i], dst_data[j], pat_byte);
> +			}
> +			/* check that the data after the fill operation was not written to */
> +			for (; j < rte_pktmbuf_data_len(dst); j++)
> +				if (dst_data[j] != 0)
> +					ERR_RETURN("Error, fill operation wrote too far (lengths = %u): got (%x), not (%x)\n",
> +							lengths[i], dst_data[j], 0);
>  		}
> -		/* check that the data after the fill operation was not written to */
> -		for (; j < rte_pktmbuf_data_len(dst); j++)
> -			if (dst_data[j] != 0)
> -				ERR_RETURN("Error, fill operation wrote too far (lengths = %u): got (%x), not (%x)\n",
> -						lengths[i], dst_data[j], 0);
>  	}
>  
>  	rte_pktmbuf_free(dst);

