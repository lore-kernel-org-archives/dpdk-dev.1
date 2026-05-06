Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C3CD342F
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 01:04:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08DF64025E;
	Wed,  6 May 2026 03:04:39 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 94A0F400D6
 for <dev@dpdk.org>; Wed,  6 May 2026 03:04:36 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=S1F6ZXrBSMh0j9cIbZMDEGd9zhpspHJMcyi6OmP/dS8=;
 b=c3/qlTwOd63tUCBwOnAaWrt1gQNuIhSa1TsjpRKjzCShJgzdtqiiYobop4i+kE0qm/213HdqF
 GBHq4xv7NaSb+OHtSFKai9FxC87ZE88IV55vUfTowdDwBBmRyD3Uihk6oUd/IIE/qUs7VMfARON
 cofSxnxplUdNXWrVuJbtQ/Q=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g9H5m6PgmzRhVs;
 Wed,  6 May 2026 08:57:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 325E340576;
 Wed,  6 May 2026 09:04:33 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 09:04:32 +0800
Message-ID: <da3d7121-9f38-460a-a933-76dd74067d72@huawei.com>
Date: Wed, 6 May 2026 09:04:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ring: add cache guard after ring elements table
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <20260505161329.258182-1-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260505161329.258182-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 5/6/2026 12:13 AM, Morten Brørup wrote:
> Added cache guard after the table holding the ring elements, to avoid
> false sharing conflicts caused by next-line hardware prefetchers when
> accessing elements at the end of the ring table.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
> v2:
> * Added comment describing reason for padding. (Konstantin)
> ---
>  lib/ring/rte_ring.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
> index f10050a1c4..10b52dc679 100644
> --- a/lib/ring/rte_ring.c
> +++ b/lib/ring/rte_ring.c
> @@ -73,8 +73,15 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
>  		return -EINVAL;
>  	}
>  
> +	static_assert(sizeof(struct rte_ring) == RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_ring)),
> +			"Size of struct rte_ring not cache line aligned");
>  	sz = sizeof(struct rte_ring) + (ssize_t)count * esize;
> +	/* Add padding, to guard against false sharing-like effects
> +	 * on systems with a next-N-lines hardware prefetcher, when
> +	 * accessing elements at the end of the ring table.
> +	 */
>  	sz = RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
> +	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
>  	return sz;
>  }
>  

