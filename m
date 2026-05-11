Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D2BCD484E
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 23:29:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28752402BC;
	Tue, 12 May 2026 01:29:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E056040278
 for <dev@dpdk.org>; Tue, 12 May 2026 01:29:35 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C2016F2;
 Mon, 11 May 2026 16:29:29 -0700 (PDT)
Received: from [10.122.52.49] (unknown [10.122.52.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A819F3F85F;
 Mon, 11 May 2026 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778542174; bh=/A/GaYNH+1bfcAJ/CiX98OfhlrHnK7Z+g+o1OcllGUA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q4bFHj7Tw0BvgSrCfc3pdk1QgL7p0lEToPK8U2p7R0GyUAjt/BahnPDui24Pp9MRy
 3lwE3aBpRKnQ06ldNKH658PeBxGEBkzFEWvVam82z895iG1dKtc7poCLYmVK55LQkR
 dKvOXlJMQud1dLz3V58VvmFvz49zoupRo1m2AQmA=
Message-ID: <4d381ed2-5e7c-4f91-a414-7b374f453616@arm.com>
Date: Mon, 11 May 2026 18:29:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ring: add cache guard after ring elements table
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <20260505161329.258182-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20260505161329.258182-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

On 5/5/26 11:13, Morten Brørup wrote:
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
>   lib/ring/rte_ring.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
> index f10050a1c4..10b52dc679 100644
> --- a/lib/ring/rte_ring.c
> +++ b/lib/ring/rte_ring.c
> @@ -73,8 +73,15 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
>   		return -EINVAL;
>   	}
>   
> +	static_assert(sizeof(struct rte_ring) == RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_ring)),
> +			"Size of struct rte_ring not cache line aligned");
>   	sz = sizeof(struct rte_ring) + (ssize_t)count * esize;
> +	/* Add padding, to guard against false sharing-like effects
> +	 * on systems with a next-N-lines hardware prefetcher, when
> +	 * accessing elements at the end of the ring table.
> +	 */
>   	sz = RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
> +	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
>   	return sz;
>   }
>   
