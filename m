Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7747CA6015
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 06:06:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DDA24027A;
	Fri,  9 Oct 2026 08:06:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 19EEB4026D
 for <dev@dpdk.org>; Fri,  9 Oct 2026 08:06:00 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A477D1692;
 Thu,  8 Oct 2026 23:05:56 -0700 (PDT)
Received: from [10.122.30.109] (unknown [10.122.30.109])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12C13F66F;
 Thu,  8 Oct 2026 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791525960; bh=3XYFpwwyQq6cP7zhfAmqpdCljfa7Blf/KhHQfsYgxgk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O7JW6TLY/1nlIUCxU2fjJbHhtqmYNsnkeq9ileaqK4LQwpak3eypLOuy4ElWWbRWu
 pl63CKDEXGYmZHlUl9yYZZ1rk495m45PwHRs+D2KwtB77RghWpogNVixlAPkrajYJ2
 QJO+tsafaPMC6IwHANXWgWsRfcYGmt/K1i0SlA8E=
Message-ID: <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
Date: Fri, 9 Oct 2026 01:05:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20261008233649.1260843-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

>   /*
>    * Marks given callback as used by datapath.
>    */
>   static __rte_always_inline void
>   bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>   {
> -	cbi->use++;
> -	/* make sure no store/load reordering could happen */
> -	rte_smp_mb();
> +	rte_atomic_store_explicit(&cbi->use,
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
> +		rte_memory_order_relaxed);
> +
> +	/* full barrier: count must be visible before cb is read */
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);

This is correct but why use a barrier when the above store itself could 
be SEQ_CST that
synchronizes with load in bpf_eth_cbi_wait?

>   }
>   
>   /*
> @@ -91,9 +106,10 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>   static __rte_always_inline void
>   bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>   {
> -	/* make sure all previous loads are completed */
> -	rte_smp_rmb();
> -	cbi->use++;
> +	/* release: pairs with the acquire bpf_eth_cbi_wait() */
> +	rte_atomic_store_explicit(&cbi->use,
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
> +		rte_memory_order_release);
>   }
>   
>   /*
> @@ -104,15 +120,15 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
>   {
>   	uint32_t puse;
>   
> -	/* make sure all previous loads and stores are completed */
> -	rte_smp_mb();
> +	/* full barrier: cleared cb must be visible before counter is read */
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>   
> -	puse = cbi->use;
> +	puse = rte_atomic_load_explicit(&cbi->use, rte_memory_order_acquire);
>   
>   	/* in use, busy wait till current RX/TX iteration is finished */
>   	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
>   		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
> -			UINT32_MAX, !=, puse, rte_memory_order_relaxed);
> +			UINT32_MAX, !=, puse, rte_memory_order_acquire);
>   	}
>   }
>   
> @@ -439,7 +455,6 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>   {
>   	/* mark this cbi as empty */
>   	bc->cb = NULL;
> -	rte_smp_mb();
>   
>   	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
>   	bpf_eth_cbi_wait(bc);
--wathsala
