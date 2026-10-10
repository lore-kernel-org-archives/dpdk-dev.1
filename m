Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E97CA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:40:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D375402B4;
	Sat, 10 Oct 2026 04:40:52 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 5ABD04027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:40:50 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=REqfg2QHL0sMNRGaQykcNMWD1liAq9TmJ2T0qzU96GE=;
 b=H89tgZPnrwfjHHaooQ1jwXl12VtinIAP6lyq2UfaIQAhagQgbZ+doL/c9TFtbv0wIixbAbAXM
 GFBB3u4gXcvyaR5gt73b5bERfV5wH+zqTUNmziea/PBZCHiEsqjx+e8SqXLu3UeVAvpREBVJxYE
 kwVLMCsfjwvkUQjUscbgFig=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j1nhv6LgbzLlXC;
 Sat, 10 Oct 2026 10:28:31 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 9754E40580;
 Sat, 10 Oct 2026 10:40:47 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 10:40:47 +0800
Message-ID: <6f3dcc7f-1333-4805-9fac-2e32f6944bdb@huawei.com>
Date: Sat, 10 Oct 2026 10:40:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/65] dma/skeleton: use kvargs numeric helpers
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
 <20260930224340.58580-11-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260930224340.58580-11-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 10/1/2026 6:40 AM, Stephen Hemminger wrote:
> The lcore argument is converted with atoi(), which validates nothing:
> a malformed value such as "abc" becomes zero, and the range check that
> follows only catches a value which happens to land outside it.
> 
> Use rte_kvargs_to_int() with the lcore range, and log the key and the
> range when it does not fit.
> 
> The parsing function returns void and probe does not fail on a bad
> argument, which is left alone here: an unusable lcore still falls back
> to the default. Only the "Parse lcore_id" message is now skipped when
> the conversion failed, since it reported a value which had not been
> parsed at all.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/dma/skeleton/skeleton_dmadev.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
> index e287802eb9..44158d5a7f 100644
> --- a/drivers/dma/skeleton/skeleton_dmadev.c
> +++ b/drivers/dma/skeleton/skeleton_dmadev.c
> @@ -638,19 +638,24 @@ skeldma_destroy(const char *name)
>  }
>  
>  static int
> -skeldma_parse_lcore(const char *key __rte_unused,
> +skeldma_parse_lcore(const char *key,
>  		    const char *value,
>  		    void *opaque)
>  {
> -	int lcore_id;
> +	int64_t lcore_id;
> +	int ret;
>  
> -	if (value == NULL || opaque == NULL)
> +	if (opaque == NULL)
>  		return -EINVAL;
>  
> -	lcore_id = atoi(value);
> -	if (lcore_id >= 0 && lcore_id < RTE_MAX_LCORE)
> -		*(int *)opaque = lcore_id;
> +	ret = rte_kvargs_to_int(value, 0, RTE_MAX_LCORE - 1, &lcore_id);
> +	if (ret < 0) {

Why not if (ret != 0) ?

Thanks

> +		SKELDMA_LOG(ERR, "Invalid %s, must be 0..%u", key,
> +			    RTE_MAX_LCORE - 1);
> +		return ret;
> +	}
>  
> +	*(int *)opaque = lcore_id;
>  	return 0;
>  }
>  
> @@ -673,9 +678,9 @@ skeldma_parse_vdev_args(struct rte_vdev_device *vdev, int *lcore_id)
>  	if (!kvlist)
>  		return;
>  
> -	(void)rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
> -				 skeldma_parse_lcore, lcore_id);
> -	SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
> +	if (rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
> +			       skeldma_parse_lcore, lcore_id) == 0)
> +		SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
>  
>  	rte_kvargs_free(kvlist);
>  }

