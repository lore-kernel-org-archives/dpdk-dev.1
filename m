Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE4CA9EDD
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 15:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7958040272;
	Mon, 12 Oct 2026 17:40:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BE7304026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 17:40:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 153D7169E;
 Mon, 12 Oct 2026 08:40:42 -0700 (PDT)
Received: from [10.122.29.139] (unknown [10.122.29.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5713F7B4;
 Mon, 12 Oct 2026 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791819640; bh=eSBQxv0gZcjW+T+8EQ7BwUwMGNgPdpxzo82o/DutoMk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QmUTINPHVzbn01QOIwwp+Pm/UD6FjLhkX7z/nJFGUQQsPbVeNJeIkJmZvy9nMlCPH
 QPCRcQtxtCkQQejTbRgUnbjhD4qdblQn0gqJ1h1D70ThqpqRRxkIQXffgV1SEXB3x8
 9CXTCN3ncgrEoijM0rk7LYhMi5ONrchf3k+adYkE=
Message-ID: <7355c1fe-b9d3-493e-b8ee-c518ddbc58e5@arm.com>
Date: Mon, 12 Oct 2026 10:40:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <20261009084744.046a7200@phoenix.local>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20261009084744.046a7200@phoenix.local>
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


On 10/9/26 10:48, Stephen Hemminger wrote:
> On Fri, 9 Oct 2026 01:05:56 -0500
> Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
>
>>>    /*
>>>     * Marks given callback as used by datapath.
>>>     */
>>>    static __rte_always_inline void
>>>    bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>>>    {
>>> -	cbi->use++;
>>> -	/* make sure no store/load reordering could happen */
>>> -	rte_smp_mb();
>>> +	rte_atomic_store_explicit(&cbi->use,
>>> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
>>> +		rte_memory_order_relaxed);
>>> +
>>> +	/* full barrier: count must be visible before cb is read */
>>> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>> This is correct but why use a barrier when the above store itself could
>> be SEQ_CST that
>> synchronizes with load in bpf_eth_cbi_wait?
> There are two different things be covered for safety here.
> The counter and the callback pointer. The counter uses atomic
> operations and the callback pointer is referenced without atomic.
> AI explains it as:
>
> A seq_cst store on the counter is not enough. This is a store/load
> pattern across two objects:
>
>    datapath: store use, load cb
>    unload:   store cb,  load use
>
> At least one side has to see the other's store. Making the store
> of use seq_cst does not order the datapath's later load of cb,
> which is a plain load. On arm64 that compiles to stlr followed by
> ldr, and the ldr can be satisfied before the stlr is visible.
> Only stlr/ldar pairs are kept in order.
>
> It can be done without fences by making cb atomic and using
> seq_cst for all four accesses (stlr + ldar on arm64). That touches
> every callback and is a bigger change than replacing the barriers,
> so I would rather do it as a follow-up if at all.
>
> There is no cost difference on x86. A seq_cst store is xchg and
> the fence is lock addl, one locked instruction per burst either
> way.


Agreed, barrier is the better implementation than converting
everything into seq_cst.

Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

--wathsala

