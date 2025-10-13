Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCADCCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 18:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A30DC402AE;
	Mon, 13 Oct 2025 20:09:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BB72E402A0
 for <dev@dpdk.org>; Mon, 13 Oct 2025 20:09:49 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234DA106F;
 Mon, 13 Oct 2025 11:09:41 -0700 (PDT)
Received: from [10.122.3.60] (unknown [10.122.3.60])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9C53F738;
 Mon, 13 Oct 2025 11:09:48 -0700 (PDT)
Message-ID: <566b4c6c-f081-4db8-bc8b-2a576a82e1c3@arm.com>
Date: Mon, 13 Oct 2025 13:09:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Ola Liljedahl <ola.liljedahl@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
 <20251002174137.3612042-2-wathsala.vithanage@arm.com>
 <cfc073b8137541f1be3e01650d6bcf14@huawei.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <cfc073b8137541f1be3e01650d6bcf14@huawei.com>
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


On 10/8/25 03:00, Konstantin Ananyev wrote:
>
>> The function __rte_ring_headtail_move_head() assumes that the barrier
>> (fence) between the load of the head and the load-acquire of the
>> opposing tail guarantees the following: if a first thread reads tail
>> and then writes head and a second thread reads the new value of head
>> and then reads tail, then it should observe the same (or a later)
>> value of tail.
>>
>> This assumption is incorrect under the C11 memory model. If the barrier
>> (fence) is intended to establish a total ordering of ring operations,
>> it fails to do so. Instead, the current implementation only enforces a
>> partial ordering, which can lead to unsafe interleavings. In particular,
>> some partial orders can cause underflows in free slot or available
>> element computations, potentially resulting in data corruption.
>>
>> The issue manifests when a CPU first acts as a producer and later as a
>> consumer. In this scenario, the barrier assumption may fail when another
>> core takes the consumer role. A Herd7 litmus test in C11 can demonstrate
>> this violation. The problem has not been widely observed so far because:
>>    (a) on strong memory models (e.g., x86-64) the assumption holds, and
>>    (b) on relaxed models with RCsc semantics the ordering is still strong
>>        enough to prevent hazards.
>> The problem becomes visible only on weaker models, when load-acquire is
>> implemented with RCpc semantics (e.g. some AArch64 CPUs which support
>> the LDAPR and LDAPUR instructions).
>>
>> Three possible solutions exist:
>>    1. Strengthen ordering by upgrading release/acquire semantics to
>>       sequential consistency. This requires using seq-cst for stores,
>>       loads, and CAS operations. However, this approach introduces a
>>       significant performance penalty on relaxed-memory architectures.
>>
>>    2. Establish a safe partial order by enforcing a pair-wise
>>       happens-before relationship between thread of same role by changing
>>       the CAS and the preceding load of the head by converting them to
>>       release and acquire respectively. This approach makes the original
>>       barrier assumption unnecessary and allows its removal.
>>
>>    3. Retain partial ordering but ensure only safe partial orders are
>>       committed. This can be done by detecting underflow conditions
>>       (producer < consumer) and quashing the update in such cases.
>>       This approach makes the original barrier assumption unnecessary
>>       and allows its removal.
>>
>> This patch implements solution (2) to preserve the “enqueue always
>> succeeds” contract expected by dependent libraries (e.g., mempool).
>> While solution (3) offers higher performance, adopting it now would
>> break that assumption.
>>
>> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
>> Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
>> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
>> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
>> ---
>>   lib/ring/rte_ring_c11_pvt.h | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
>> index b9388af0da..98c6584edb 100644
>> --- a/lib/ring/rte_ring_c11_pvt.h
>> +++ b/lib/ring/rte_ring_c11_pvt.h
>> @@ -78,14 +78,11 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail
>> *d,
>>   	unsigned int max = n;
>>
>>   	*old_head = rte_atomic_load_explicit(&d->head,
>> -			rte_memory_order_relaxed);
>> +			rte_memory_order_acquire);
>>   	do {
>>   		/* Reset n to the initial burst count */
>>   		n = max;
>>
>> -		/* Ensure the head is read before tail */
>> -		rte_atomic_thread_fence(rte_memory_order_acquire);
>> -
>>   		/* load-acquire synchronize with store-release of ht->tail
>>   		 * in update_tail.
>>   		 */
>> @@ -115,8 +112,8 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail
>> *d,
>>   			/* on failure, *old_head is updated */
>>   			success =
>> rte_atomic_compare_exchange_strong_explicit(
>>   					&d->head, old_head, *new_head,
>> -					rte_memory_order_relaxed,
>> -					rte_memory_order_relaxed);
>> +					rte_memory_order_acq_rel,
>> +					rte_memory_order_acquire);
>>   	} while (unlikely(success == 0));
>>   	return n;
>>   }
>> --
> LGTM, though. I think that we also need to make similar changes in
> rte_ring_hts_elem_pvt.h and rte_ring_rts_elem_pvt.h:
> for CAS use 'acq_rel' order instead of simple 'acquire'.
> Let me know would you have a bandwidth to do that.

My bad, I forgot those two cases. I will send a v3.

-- wathsala

>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
>
>> 2.43.0
>>
