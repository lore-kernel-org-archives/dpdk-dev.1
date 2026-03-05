Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E8BEFCE4D
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 00:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB5C4029D;
	Thu,  5 Mar 2026 01:41:46 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id F419D4027A;
 Thu,  5 Mar 2026 01:41:43 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YLyH4fb9xDF1xIBoBPd6cYU7Ax0wsvWLBf8Mb635tHo=;
 b=ujEZljbc9m4Vu0fzKj8aIl9YWiskXIsAHEVMMCoEUBbT1fDYbUCj3WssN4BF8HX7PFuZ7tWbN
 yrhLFwRAkMIKRdpIQ0y7Lvj+vAc7PYxwufBWQRXnG6vjO6jqo23AIaLg4Gl8x4Kyqgd255F4ya2
 KlHgsMYIpDkCI2z6G3/3kZM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fR9Zw6hh0zpSvh;
 Thu,  5 Mar 2026 08:36:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 701312025F;
 Thu,  5 Mar 2026 08:41:41 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 08:41:40 +0800
Message-ID: <544edfc3-0e6f-4c57-8b6b-8d937dd0be4c@huawei.com>
Date: Thu, 5 Mar 2026 08:41:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/test-dma-perf: fix reversed src and dst for memcpy
To: Liangxing Wang <wangliangxing@hygon.cn>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <vipin.varghese@amd.com>, <stable@dpdk.org>
References: <20260303091804.41761-1-wangliangxing@hygon.cn>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260303091804.41761-1-wangliangxing@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 3/3/2026 5:18 PM, Liangxing Wang wrote:
> Fixes: 2f2f7af66791 ("app/dma-perf: fix crash with IOVA as physical address")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
> ---
>  app/test-dma-perf/benchmark.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
> index b6125d86f9..5f6c022ad7 100644
> --- a/app/test-dma-perf/benchmark.c
> +++ b/app/test-dma-perf/benchmark.c
> @@ -520,8 +520,8 @@ do_cpu_mem_copy(void *p)
>  
>  	while (1) {
>  		for (i = 0; i < nr_buf; i++) {
> -			const void *src = rte_pktmbuf_mtod(dsts[i], void *);
> -			void *dst = rte_pktmbuf_mtod(srcs[i], void *);
> +			const void *src = rte_pktmbuf_mtod(srcs[i], void *);
> +			void *dst = rte_pktmbuf_mtod(dsts[i], void *);
>  
>  			/* copy buffer form src to dst */
>  			rte_memcpy(dst, src, (size_t)buf_size);

