Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6FFCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CAE402A2;
	Thu, 21 May 2026 17:43:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 03E2E400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:43:56 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D33B1C25;
 Thu, 21 May 2026 08:43:50 -0700 (PDT)
Received: from [10.122.53.155] (unknown [10.122.53.155])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F2C3F632;
 Thu, 21 May 2026 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779378235; bh=CyYc1WxvqrOTWE1m4lzR7La43Mc0kEnS7fOGn9iEb70=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rMYiU21LsdwWxuEy+OX0uP6HuFy6Ze+1qw9quz4KNzist3/bJ4UWu2SLiESkUB1fr
 Ln7tC1w8MWLF1ezJW1WMiZr9DQjyK/dC+90O343DWe5QsjGdh5AIqOgTbI0YLz3imx
 W6bfYkHUOcmg3m4znrlKXTl2vFPUdDHEo/VYMsPI=
Message-ID: <a5426f4b-2a3c-45c9-9cdc-c3f436aa3b19@arm.com>
Date: Thu, 21 May 2026 10:43:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/7] eal: reimplement rte_smp_*mb with
 rte_atomic_thread_fence
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521042043.1590536-3-stephen@networkplumber.org>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20260521042043.1590536-3-stephen@networkplumber.org>
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

Hi Stephen,

Suggesting minor changes to comments on acquire and
release fences..

> +/** @name SMP Memory Barrier
> + */
> +///@{
> +/**
> + * General memory barrier between lcores
> + *
> + * Guarantees that the LOAD and STORE operations that precede the
> + * rte_smp_mb() call are globally visible across the lcores
> + * before the LOAD and STORE operations that follows it.
> + */
> +static __rte_always_inline void
> +rte_smp_mb(void)
> +{
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
> +}
> +
> +/**
> + * Write memory barrier between lcores
> + *
> + * Guarantees that the STORE operations that precede the
> + * rte_smp_wmb() call are globally visible across the lcores
> + * before the STORE operations that follows it.
> + */
> +static __rte_always_inline void
> +rte_smp_wmb(void)
> +{
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +}

Release fences order STORE | STORE, and  LOAD | STORE.
Therefor, the comment should be "Guarantees that LOAD
and STORE operations that precede the rte_smp_wmb() call
are globally observed before STORE operations that follows it."

> +
> +/**
> + * Read memory barrier between lcores
> + *
> + * Guarantees that the LOAD operations that precede the
> + * rte_smp_rmb() call are globally visible across the lcores
> + * before the LOAD operations that follows it.
> + */
> +static __rte_always_inline void
> +rte_smp_rmb(void)
> +{
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
> +}

Acquire fences order LOAD | LOAD and LOAD | STORE.
Thus, the comment should be "Guarantees that the LOAD
operations that precede the rte_smp_rmb() call observe
global  state before LOAD and STORE operations that
follows it"


--wathsala

