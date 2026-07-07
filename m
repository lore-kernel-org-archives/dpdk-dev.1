Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC6C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 01:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8091E40264;
	Tue,  7 Jul 2026 03:41:11 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id ED91B4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 03:41:09 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Ero1T47kqw6Y4NlQezqdruSX9jQN3HgvyowUM7pcz+U=;
 b=5xGk22VHBuFZ47cRIevqYd2+cfwKA+MKshrxjaRRWcM8uL3IOgn4lPUCgwHerpJJOouk+Lb1j
 Yfwzdq+uGUWtlLER9tZWCmEzsmvP+8dagtSebsC1tc0qx2AtM8r7GMfvt7cWeanpKu+osS65l9X
 af+W/SpAEIRJy0gtJYx9ZiI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gvNxQ33rXzLlSL;
 Tue,  7 Jul 2026 09:31:54 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F03E4058A;
 Tue,  7 Jul 2026 09:41:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Jul 2026 09:41:07 +0800
Message-ID: <44a99399-6050-4374-9f3f-64f6b8ed70d2@huawei.com>
Date: Tue, 7 Jul 2026 09:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] test/dma: skip instance suite on low burst capacity
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
 <20260706115533.2937512-5-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260706115533.2937512-5-raghavendra.ningoji@amd.com>
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

On 7/6/2026 7:55 PM, Raghavendra Ningoji wrote:
> test_dmadev_setup() aborts the entire "DMA dev instance" test suite
> with a hard failure when rte_dma_burst_capacity() reports fewer than
> 32 descriptors. Some DMA engines expose a small hardware ring; for
> example a 32-entry ring that reserves one slot to distinguish a full
> ring from an empty one leaves only 31 descriptors usable. Such a
> device genuinely cannot run the instance tests, which enqueue 32-deep
> bursts, but it should be reported as skipped rather than failed.
> 
> Return TEST_SKIPPED instead, matching test_dmadev_burst_setup() which
> already skips (rather than fails) when the capacity is below 64.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  app/test/test_dmadev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index 5488a1af33..1cfa8c1e10 100644
> --- a/app/test/test_dmadev.c
> +++ b/app/test/test_dmadev.c
> @@ -1397,8 +1397,12 @@ test_dmadev_setup(void)
>  	if (rte_dma_stats_get(dev_id, vchan, &stats) != 0)
>  		ERR_RETURN("Error with rte_dma_stats_get()\n");
>  
> -	if (rte_dma_burst_capacity(dev_id, vchan) < 32)
> -		ERR_RETURN("Error: Device does not have sufficient burst capacity to run tests");
> +	if (rte_dma_burst_capacity(dev_id, vchan) < 32) {
> +		RTE_LOG(ERR, USER1,
> +			"DMA Dev %u: insufficient burst capacity (32 required), skipping tests\n",
> +			dev_id);
> +		return TEST_SKIPPED;
> +	}

This approach is also acceptable, but I think this test, as a community
"free gift", should be supported as much as possible. So I would suggest
you modify the relevant code to support this test, but it is not mandatory.

Thanks

>  
>  	if (stats.completed != 0 || stats.submitted != 0 || stats.errors != 0)
>  		ERR_RETURN("Error device stats are not all zero: completed = %"PRIu64", "

