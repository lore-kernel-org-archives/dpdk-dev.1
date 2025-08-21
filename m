Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A379ACA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 00:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BB7140292;
	Thu, 21 Aug 2025 02:42:55 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 7C4EE4026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 02:42:53 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6kxD4QH0z2Dc8j;
 Thu, 21 Aug 2025 08:40:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 11580140148;
 Thu, 21 Aug 2025 08:42:50 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 08:42:49 +0800
Message-ID: <0b845c31-7c76-4cc4-b1e6-a1912be7898b@huawei.com>
Date: Thu, 21 Aug 2025 08:42:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hash: replace zero length array
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20250820211901.21986-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250820211901.21986-1-stephen@networkplumber.org>
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

On 8/21/2025 5:19 AM, Stephen Hemminger wrote:
> Zero-length arrays are a GNU C extension and instead use the ISO C99
> flexible array member.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/hash/rte_cuckoo_hash.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
> index 26a992419a..cf5cd29144 100644
> --- a/lib/hash/rte_cuckoo_hash.h
> +++ b/lib/hash/rte_cuckoo_hash.h
> @@ -131,7 +131,7 @@ struct rte_hash_key {
>  		RTE_ATOMIC(void *) pdata;
>  	};
>  	/* Variable key size */
> -	char key[0];
> +	char key[];
>  };
>  
>  /** Bucket structure */

