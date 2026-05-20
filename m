Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36B0CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 14:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFC9C40608;
	Wed, 20 May 2026 16:57:29 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id CCC5B4042F
 for <dev@dpdk.org>; Wed, 20 May 2026 16:57:27 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2ee990e8597so12629927eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779289047;
 x=1779893847; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3mVYkOnKkMotJJ/mtNv0u+7keasBhiJ8wXnkOXFTQk=;
 b=GhozJO2IdFYkUWuzgGHLMetDoNNzIJG86DGdJ4+LqTDttfC2UvsNudHIJqYO6xqhdq
 DC2LZz5wNp/mLG1yt5CQUaWL1+cuanJRMczbpmFM7GpwNJZqWwVnHH+HBFXVYWiaDIxl
 DPK+bGjipMdLFKjIGYZIFNdAbmVYAscePxmbsqqOv+mEPpTRMvENcuhgRtKIe4BxZV7q
 XqjbD1gf4jTKqB2ZWFE6xb945OWaMzLdf63i/09o/ddPF/ILpYT7T0hzBTdN0zK8D3sb
 T6ZKvxB7sJ2xXqhAmU97AdeKcfahC1VICfRQH/BsnTyIr+9mxtWuG+fyZQb727b/MRF4
 3avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289047; x=1779893847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3mVYkOnKkMotJJ/mtNv0u+7keasBhiJ8wXnkOXFTQk=;
 b=FMqIv1gupmGlyXDke2BoNhIgvhJms+JgyfumqlHoKEoZqkRTuYPL/dvI553t2xrgk2
 x8YMcGR+VW2kDC4AqG1qJVdTMQThtpwqwueCGL7aSR0djD3h1b7yJ8p1upAFzZyB7lKg
 qqK1yV9w/y2c0MFf/jqmhSsgkrtPMulTQwhmnOOKcY0KwQmAWucn9at4mgvHvYMsYb14
 mk859io4EYyeFsLVlC+q0ln9Y8pSAd//tXUc9LZo2/Ep7QSBKLOcMwciupf0CrgFxW4y
 o2v7VXTKTanH6STo8ON+dosdipo8Csi0TXhXWhk3ZFFak28r8xfur1BQytm2FXllh1dV
 wwAg==
X-Gm-Message-State: AOJu0Yzr8/yWekUyeCfM/BmNIwnchLyI627jcLpdbaZJicVZWBYlpCzy
 r8J0AAsg7Kd6g9RN/3CaXcTQwZllo2ydhq5s/kXrzKEVmTifXKcQo5LsEZrYFTB9zSU=
X-Gm-Gg: Acq92OEa+2G/n5erRF5L7WnVVlj6XZNzinfzCjYWtgHYe34J28lg9qAnF/LGQwfrjew
 ROZIrw+vVlm+YTrHncQKlye2YJJtCMAZoBfMQSxK2CK68wXriqCmjSAStCs7dQYVUZHdwed+GPA
 9yww4y3PZ9eE98RwE2Oe0fAH0ggdZc8IkRCH/Hu4lghXEu2BCbhrikuBN3SseLFXWlxpjPJX9RX
 MrVqe4XNNoCUS38hBVoeKr1sCjDMEFoGprin5WgOWdBXmc+naJb06bxvxHNOyU23zYtf0OzU2S/
 0RMojJPOpaeqOUexY/e1EEKxJbXwqoBSsv4r3+wlx437ekhgj3XByBTek/wVCTiuBjPyr/sQ+Jk
 eAe6uhCpgEDSNoxK4BzpmOH+1DrSfpn1KFXgC9Wk53rGcWR2zWa1UIIm76/QgCH3gM/qDA6wBnD
 yPbyqkhfDB6jD1yPWDdR4crLi8gZw/RujlWDyGbPCM6QE4tHv6TDMj4J+1MVx62D2O
X-Received: by 2002:a05:7300:578a:b0:2f1:6252:f8ef with SMTP id
 5a478bee46e88-30398191595mr12597845eec.1.1779289046753; 
 Wed, 20 May 2026 07:57:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304052f79ecsm5261534eec.11.2026.05.20.07.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:57:26 -0700 (PDT)
Date: Wed, 20 May 2026 07:57:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michal Sieron <michal.sieron@nokia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] linux/mem: atomically prefault hugepages in alloc_seg
Message-ID: <20260520075722.1764cf35@phoenix.local>
In-Reply-To: <20260520125756.530808-1-michal.sieron@nokia.com>
References: <20260520125756.530808-1-michal.sieron@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 20 May 2026 14:57:56 +0200
Michal Sieron <michal.sieron@nokia.com> wrote:

> In rare cases, when a secondary process calls rte_eal_init() it can
> cause a data race during page prefaulting in alloc_seg().
> 
> An atomic compare-exchange in a loop should eliminate the data race.
> 
> Signed-off-by: Michal Sieron <michal.sieron@nokia.com>
> ---
>  lib/eal/linux/eal_memalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
> index a39bc31c7b..cb92fda2e8 100644
> --- a/lib/eal/linux/eal_memalloc.c
> +++ b/lib/eal/linux/eal_memalloc.c
> @@ -30,6 +30,7 @@
>  #include <rte_eal.h>
>  #include <rte_memory.h>
>  #include <rte_cycles.h>
> +#include <rte_atomic.h>
>  
>  #include "eal_filesystem.h"
>  #include "eal_internal_cfg.h"
> @@ -600,7 +601,9 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
>  	 * that is already there, so read the old value, and write itback.
>  	 * kernel populates the page with zeroes initially.
>  	 */
> -	*(volatile int *)addr = *(volatile int *)addr;
> +	int snapshot = *(volatile int *)addr;
> +	while (!rte_atomic_compare_exchange_strong((volatile int *)addr, &snapshot, snapshot))
> +		;
>  
>  	iova = rte_mem_virt2iova(addr);
>  	if (iova == RTE_BAD_PHYS_ADDR) {

No don't use a loop with compare_exchange_strong here.
It could get stuck.
Should just a an relaxed load be enough to get the page in?

