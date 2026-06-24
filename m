Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EACD4F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 00:29:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB08A40299;
	Wed, 24 Jun 2026 02:29:20 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 5592D40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 02:29:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jNn/V0wbGAnnC5bTbf8Dq3s+lq/wqrWLW9W0ErFh2wU=;
 b=ryJOcsOTIZJ1dBYFfBYqBVLIaafygsJcRbiZOpBzfvEjrpWQ8RUZR/kFD0UqXSgfWgzFHBOK4
 ffeYDCJLHC7XMI9mjuMon+9ZfO2FX5QDpB0Q3OgclZzUAt4lBYJ+vl5w/trNl7q03KtThMStWEU
 NuVoQOsOjZ+qIF2OqXC6bYM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4glMyZ42tdzmVZX;
 Wed, 24 Jun 2026 08:20:06 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id D214E4056E;
 Wed, 24 Jun 2026 08:29:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 08:29:08 +0800
Message-ID: <ad18b9c7-9eb8-4caf-9e1d-eef19c85e8be@huawei.com>
Date: Wed, 24 Jun 2026 08:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] test/dma: update the sg test to verify wrap around
 case
To: Tejasree Kondoj <ktejasree@marvell.com>, Akhil Goyal <gakhil@marvell.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
References: <20260622135208.87697-1-ktejasree@marvell.com>
 <20260622135208.87697-2-ktejasree@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260622135208.87697-2-ktejasree@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 6/22/2026 9:52 PM, Tejasree Kondoj wrote:
> Run the sg test in a loop to verify wrap around case.
> Total number commands submitted to be more than the number descriptors
> allocated to verify the scenario.
> 
> Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
> Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
> ---
>  app/test/test_dmadev.c     | 45 ++++++++++++++++++++++++--------------
>  app/test/test_dmadev_api.c |  1 -
>  app/test/test_dmadev_api.h |  2 ++
>  3 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index 5488a1af33..b30f2214e5 100644
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

test_enqueue_sg() has protection:
+			if (dst_len == 0 || src_len == 0)
+				continue;

So no need RTE_MIN, just info.max_sges, in this way we will test the device's capability.

> +	len = COPY_LEN;
> +
> +	do {
> +		test_enqueue_sg(dev_id, vchan, n_sge, len);

We need check the retcode of test_enqueue_sg, else this case will return OK even the
copy failed.

> +		loop_count++;
> +	} while (loop_count * n_sge * n_sge < TEST_RINGSIZE * 3);
> +
> +	return 0;
> +}
> +
>  static int
>  test_single_sva_copy(int16_t dev_id, uint16_t vchan, const char *mem_src,
>  		     char *src, char *dst, uint32_t len)
> diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
> index 1ba053696b..4bb8f9e820 100644
> --- a/app/test/test_dmadev_api.c
> +++ b/app/test/test_dmadev_api.c
> @@ -16,7 +16,6 @@ extern int test_dma_api(uint16_t dev_id);
>  
>  #define TEST_MEMCPY_SIZE	1024
>  #define TEST_WAIT_US_VAL	50000
> -#define TEST_SG_MAX		64
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

No need public this macro.

> +
>  int test_dma_api(uint16_t dev_id);

