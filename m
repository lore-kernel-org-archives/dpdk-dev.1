Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEBCC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB53D402D4;
	Tue, 10 Jun 2025 08:41:12 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 1BBA440299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:41:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bGfJQ3shJz1R87k;
 Tue, 10 Jun 2025 14:38:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A0DD1A0188;
 Tue, 10 Jun 2025 14:41:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 14:41:07 +0800
Message-ID: <e1d12ea6-b57d-4478-b983-e2f0a6aa285b@huawei.com>
Date: Tue, 10 Jun 2025 14:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] test/dma: update the sg test to verify wrap around
 case
To: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <gakhil@marvell.com>, <jerinj@marvell.com>, <anoobj@marvell.com>,
 <asasidharan@marvell.com>, <dev@dpdk.org>, Amit Prakash Shukla
 <amitprakashs@marvell.com>
References: <20250606094031.2961842-1-vvelumuri@marvell.com>
 <20250609030314.4098409-1-vvelumuri@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250609030314.4098409-1-vvelumuri@marvell.com>
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

On 2025/6/9 11:03, Vidya Sagar Velumuri wrote:
> Run the sg test in a loop to verify wrap around case.
> Total number commands submitted to be more than the number descriptors
> allocated to verify the scenario.
> 
> Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>
> 
> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index 9cbb9a6552..88c3d02fd6 100644
> --- a/app/test/test_dmadev.c
> +++ b/app/test/test_dmadev.c
> @@ -393,36 +393,28 @@ test_stop_start(int16_t dev_id, uint16_t vchan)
>  }
>  
>  static int
> -test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
> +test_enqueue_sg(int16_t dev_id, uint16_t vchan, unsigned int n_sge, unsigned int test_len)
>  {
> -	unsigned int src_len, dst_len, n_sge, len, i, j, k;
>  	char orig_src[COPY_LEN], orig_dst[COPY_LEN];
> -	struct rte_dma_info info = { 0 };
> +	unsigned int src_len, dst_len, i, j, k;
>  	enum rte_dma_status_code status;
>  	uint16_t id, n_src, n_dst;
>  
> -	if (rte_dma_info_get(dev_id, &info) < 0)
> -		ERR_RETURN("Failed to get dev info");
> -
> -	if (info.max_sges < 2)
> -		ERR_RETURN("Test needs minimum 2 SG pointers");
> -
> -	n_sge = info.max_sges;
> -
>  	for (n_src = 1; n_src <= n_sge; n_src++) {
>  		for (n_dst = 1; n_dst <= n_sge; n_dst++) {
>  			/* Normalize SG buffer lengths */
> -			len = COPY_LEN;
> -			len -= (len % (n_src * n_dst));

Please keep this line.

> -			dst_len = len / n_dst;
> -			src_len = len / n_src;
> -
>  			struct rte_dma_sge *sg_src = alloca(sizeof(struct rte_dma_sge) * n_sge);
>  			struct rte_dma_sge *sg_dst = alloca(sizeof(struct rte_dma_sge) * n_sge);
>  			struct rte_mbuf **src = alloca(sizeof(struct rte_mbuf *) * n_sge);
>  			struct rte_mbuf **dst = alloca(sizeof(struct rte_mbuf *) * n_sge);
>  			char **src_data = alloca(sizeof(char *) * n_sge);
>  			char **dst_data = alloca(sizeof(char *) * n_sge);
> +			unsigned int len = test_len - (test_len % (n_src * n_dst));
> +
> +			dst_len = len / n_dst;
> +			src_len = len / n_src;
> +			if (dst_len == 0 || src_len == 0)
> +				continue;
>  
>  			for (i = 0 ; i < len; i++)
>  				orig_src[i] = rte_rand() & 0xFF;
> @@ -514,6 +506,27 @@ test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
>  	return 0;
>  }
>  
> +static int
> +test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
> +{
> +	struct rte_dma_info info = { 0 };
> +	unsigned int n_sge, len;
> +	int loop_count = 0;
> +
> +	if (rte_dma_info_get(dev_id, &info) < 0)
> +		ERR_RETURN("Failed to get dev info");
> +
> +	n_sge = RTE_MIN(info.max_sges, TEST_SG_MAX);
> +	len = COPY_LEN;
> +
> +	do {
> +		test_enqueue_sg(dev_id, vchan, n_sge, len);

Need check the function return, return retcode if this function failed.

> +		loop_count++;
> +	} while (loop_count * n_sge * n_sge < TEST_RINGSIZE * 3);
> +
> +	return 0;
> +}
> +
>  /* Failure handling test cases - global macros and variables for those tests*/
>  #define COMP_BURST_SZ	16
>  #define OPT_FENCE(idx) ((fence && idx == 8) ? RTE_DMA_OP_FLAG_FENCE : 0)
> diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
> index fb49fcb56b..c38c4c1f49 100644
> --- a/app/test/test_dmadev_api.c
> +++ b/app/test/test_dmadev_api.c
> @@ -16,7 +16,6 @@ extern int test_dma_api(uint16_t dev_id);
>  
>  #define TEST_MEMCPY_SIZE	1024
>  #define TEST_WAIT_US_VAL	50000
> -#define TEST_SG_MAX		64

No need to public this macro, because test_enqueue_sg already use alloca to hold the dynamic size of sglist.

>  
>  static int16_t test_dev_id;
>  static int16_t invalid_dev_id;
> diff --git a/app/test/test_dmadev_api.h b/app/test/test_dmadev_api.h
> index 33fbc5bd41..a03f7acd4f 100644
> --- a/app/test/test_dmadev_api.h
> +++ b/app/test/test_dmadev_api.h
> @@ -2,4 +2,6 @@
>   * Copyright(c) 2021 HiSilicon Limited
>   */
>  
> +#define TEST_SG_MAX		64
> +
>  int test_dma_api(uint16_t dev_id);

