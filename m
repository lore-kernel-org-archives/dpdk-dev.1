Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B389E8FDD5
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Dec 2025 08:53:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC0C40267;
	Sat, 27 Dec 2025 09:53:25 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id D04AC40262;
 Sat, 27 Dec 2025 09:53:22 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=GKGsq/zulYs5BydRr+WD/8SKrVWRxHQzeB81nIW62h8=;
 b=nc8AxtCu/VXQdiwObsr9JToa/dYUmLoKnoXrp//oXT7rp22s5mKSvRTzji52Q47jzqtI5WM7C
 p8m180vl1GmfBunLvT3u13Sw5QCTFwoYj+ZWqvTj33OjfQ6Mk0No2XgGRPMw5XQWvviVt+jPvR6
 /6cAAO6vnl+5zfWnbv7wXD8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ddbll2Hx7zRhQq;
 Sat, 27 Dec 2025 16:50:11 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5EEDD40363;
 Sat, 27 Dec 2025 16:53:20 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Dec 2025 16:53:19 +0800
Message-ID: <06d7fffb-558c-4088-8410-8943d12724fe@huawei.com>
Date: Sat, 27 Dec 2025 16:53:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/l3fwd: extend NUMA nodes limit beyond 8
To: Liangxing Wang <wangliangxing@hygon.cn>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20251226081719.1120313-1-wangliangxing@hygon.cn>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251226081719.1120313-1-wangliangxing@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

BTW: Other examples also defined the NB_SOCKTS (e.g. l3fwd-power/l3fwd-graph/ipsec-secgw),
     how about add more commits to fix.

On 12/26/2025 4:17 PM, Liangxing Wang wrote:
> For platforms with more than 8 NUMA nodes, the l3fwd example fails when
> using cores on NUMA node 8 or above.
> 
> Use RTE_MAX_NUMA_NODES instead of 8 to extend NUMA nodes limit.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
> ---
>  examples/l3fwd/l3fwd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
> index 471e3b488f..ca9d0d2dd0 100644
> --- a/examples/l3fwd/l3fwd.h
> +++ b/examples/l3fwd/l3fwd.h
> @@ -33,7 +33,7 @@
>  #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
>  #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
>  
> -#define NB_SOCKETS        8
> +#define NB_SOCKETS        RTE_MAX_NUMA_NODES
>  
>  /* Configure how many packets ahead to prefetch, when reading packets */
>  #define PREFETCH_OFFSET	  3

