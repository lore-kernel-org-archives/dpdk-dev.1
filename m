Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55089CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:57:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7570E402A2;
	Thu, 21 May 2026 17:57:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id AF194400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:57:30 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD0B168F;
 Thu, 21 May 2026 08:57:24 -0700 (PDT)
Received: from [10.122.53.155] (unknown [10.122.53.155])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B56C3F632;
 Thu, 21 May 2026 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779379049; bh=HT//OKwxocpZARrrrY99WJ5YpYO71G1r2PbNa8Lb59c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZZRO//zMNRzVW/cJ8O2IdqE1W8+85rKM8qB3d6D7+nTq1UWZSIYwM0Ta/80wlwmky
 V1m/Qw+MYTp7GDaPY7dHoyc0iscw++e5OmQIRT/Q6fh0KjzDYIx7lxVjC4k1FkWuO8
 Y+0aJyvzoghPLywKvxnglKLc+HWsoR6uS3dQqD84=
Content-Type: multipart/alternative;
 boundary="------------UE866PA3vK8hAGzqxB8WDIVw"
Message-ID: <ec0a1ea7-c7f7-451b-945a-c5d5a87f5799@arm.com>
Date: Thu, 21 May 2026 10:57:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/7] ring: use C11 atomic operations for MP/SP head/tail
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521042043.1590536-4-stephen@networkplumber.org>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20260521042043.1590536-4-stephen@networkplumber.org>
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

This is a multi-part message in MIME format.
--------------UE866PA3vK8hAGzqxB8WDIVw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Already looks good. I have one minor suggestion.

In |rte_ring_c11_pvt.h| (and in the MCS lock code as well), we introduced
a comment style that annotates load-acquire and store-release
operations as |An| and |Rm|, respectively. Each |An| comment refers to the
corresponding |Rm| it synchronizes with, and vice versa, while also 
describing
the intent of the pairing.


--wathsala

On 5/20/26 23:17, Stephen Hemminger wrote:
> Last caller of rte_atomic32_cmpset() in lib/, blocking deprecation
> of the rte_atomicNN_*() family.
>
> Replace cmpset with rte_atomic_compare_exchange_weak_explicit(),
> and convert head/tail loads/stores from implicit seq_cst to explicit
> acquire/release. Matches the HTS/RTS pattern.
>
> Acquire-load of d->head orders the subsequent load of s->tail (was
> rte_smp_rmb()). Acquire-load of s->tail pairs with the release-store
> of the counterpart tail in __rte_ring_update_tail(), which subsumes
> the previous wmb/rmb barriers.
>
> Weak CAS avoids arm64's hidden inner retry; the outer do-while already
> loops. CAS orderings relaxed: no data published by the reservation.
>
> The now-unused 'enqueue' parameter of __rte_ring_update_tail() is
> removed; both call sites updated.
>
> Signed-off-by: Stephen Hemminger<stephen@networkplumber.org>
> ---
>   lib/ring/rte_ring_generic_pvt.h | 64 +++++++++++++++++++++++----------
>   1 file changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_pvt.h
> index affd2d5ba7..9497f6737b 100644
> --- a/lib/ring/rte_ring_generic_pvt.h
> +++ b/lib/ring/rte_ring_generic_pvt.h
> @@ -23,21 +23,25 @@
>    */
>   static __rte_always_inline void
>   __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
> -		uint32_t new_val, uint32_t single, uint32_t enqueue)
> +		uint32_t new_val, uint32_t single,
> +		uint32_t enqueue __rte_unused)
>   {
> -	if (enqueue)
> -		rte_smp_wmb();
> -	else
> -		rte_smp_rmb();
>   	/*
>   	 * If there are other enqueues/dequeues in progress that preceded us,
>   	 * we need to wait for them to complete
>   	 */
>   	if (!single)
> -		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail, old_val,
> -			rte_memory_order_relaxed);
> +		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail,
> +			old_val, rte_memory_order_relaxed);
>   
> -	ht->tail = new_val;
> +	/*
> +	 * Release ordering on the tail store ensures that the slot reads
> +	 * (dequeue) or writes (enqueue) performed by this thread are visible
> +	 * to the other side before the new tail value is observed.
> +	 * Pairs with the acquire load of the counterpart's tail in
> +	 * __rte_ring_headtail_move_head().
> +	 */
> +	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
>   }
>   
>   /**
> @@ -76,25 +80,35 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
>   {
>   	unsigned int max = n;
>   	int success;
> +	uint32_t tail;
>   
>   	do {
>   		/* Reset n to the initial burst count */
>   		n = max;
>   
> -		*old_head = d->head;
> +		/*
> +		 * Acquire load: orders this load before the load of s->tail
> +		 * below (replaces rte_smp_rmb() in the previous version) and
> +		 * re-establishes ordering after a failed CAS on retry.
> +		 */
> +		*old_head = rte_atomic_load_explicit(&d->head,
> +				rte_memory_order_acquire);
>   
> -		/* add rmb barrier to avoid load/load reorder in weak
> -		 * memory model. It is noop on x86
> +		/*
> +		 * Acquire load on the counterpart's tail pairs with the
> +		 * release store in __rte_ring_update_tail() on the other
> +		 * side, ensuring slot operations performed there are visible
> +		 * before the caller accesses the reserved slots.
>   		 */
> -		rte_smp_rmb();
> +		tail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
>   
>   		/*
>   		 *  The subtraction is done between two unsigned 32bits value
>   		 * (the result is always modulo 32 bits even if we have
> -		 * *old_head > s->tail). So 'entries' is always between 0
> +		 * *old_head > tail). So 'entries' is always between 0
>   		 * and capacity (which is < size).
>   		 */
> -		*entries = (capacity + s->tail - *old_head);
> +		*entries = (capacity + tail - *old_head);
>   
>   		/* check that we have enough room in ring */
>   		if (unlikely(n > *entries))
> @@ -106,12 +120,24 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
>   
>   		*new_head = *old_head + n;
>   		if (is_st) {
> -			d->head = *new_head;
> +			rte_atomic_store_explicit(&d->head, *new_head, rte_memory_order_relaxed);
>   			success = 1;
> -		} else
> -			success = rte_atomic32_cmpset(
> -					(uint32_t *)(uintptr_t)&d->head,
> -					*old_head, *new_head);
> +		} else {
> +			/*
> +			 * Weak CAS: the outer do-while handles spurious
> +			 * failures, so we avoid the strong variant's
> +			 * internal retry (which on arm64 wraps the LL/SC
> +			 * pair in a hidden inner loop).
> +			 *
> +			 * Relaxed on both success and failure: this CAS
> +			 * does not publish data. Slot data visibility is
> +			 * provided by the acquire loads above and the
> +			 * release store of tail in __rte_ring_update_tail().
> +			 */
> +			success = rte_atomic_compare_exchange_weak_explicit(
> +				&d->head, old_head, *new_head,
> +				rte_memory_order_relaxed, rte_memory_order_relaxed);
> +		}
>   	} while (unlikely(success == 0));
>   	return n;
>   }
--------------UE866PA3vK8hAGzqxB8WDIVw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p data-start="0" data-end="48">Already looks good. I have one minor
      suggestion.</p>
    <p data-start="50" data-end="366" data-is-last-node=""
      data-is-only-node="">In <code data-start="53" data-end="73">rte_ring_c11_pvt.h</code>
      (and in the MCS lock code as well), we introduced<br>
      a comment style that annotates load-acquire and store-release<br>
      operations as <code data-start="200" data-end="204">An</code> and
      <code data-start="209" data-end="213">Rm</code>, respectively.
      Each <code data-start="234" data-end="238">An</code> comment
      refers to the<br>
      corresponding <code data-start="275" data-end="279">Rm</code> it
      synchronizes with, and vice versa, while also describing<br>
      the intent of the pairing.</p>
    <p><br>
      --wathsala<br>
      <br>
    </p>
    <div class="moz-cite-prefix">On 5/20/26 23:17, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260521042043.1590536-4-stephen@networkplumber.org">
      <pre wrap="" class="moz-quote-pre">Last caller of rte_atomic32_cmpset() in lib/, blocking deprecation
of the rte_atomicNN_*() family.

Replace cmpset with rte_atomic_compare_exchange_weak_explicit(),
and convert head/tail loads/stores from implicit seq_cst to explicit
acquire/release. Matches the HTS/RTS pattern.

Acquire-load of d-&gt;head orders the subsequent load of s-&gt;tail (was
rte_smp_rmb()). Acquire-load of s-&gt;tail pairs with the release-store
of the counterpart tail in __rte_ring_update_tail(), which subsumes
the previous wmb/rmb barriers.

Weak CAS avoids arm64's hidden inner retry; the outer do-while already
loops. CAS orderings relaxed: no data published by the reservation.

The now-unused 'enqueue' parameter of __rte_ring_update_tail() is
removed; both call sites updated.

Signed-off-by: Stephen Hemminger <a class="moz-txt-link-rfc2396E" href="mailto:stephen@networkplumber.org">&lt;stephen@networkplumber.org&gt;</a>
---
 lib/ring/rte_ring_generic_pvt.h | 64 +++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_pvt.h
index affd2d5ba7..9497f6737b 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
@@ -23,21 +23,25 @@
  */
 static __rte_always_inline void
 __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
-		uint32_t new_val, uint32_t single, uint32_t enqueue)
+		uint32_t new_val, uint32_t single,
+		uint32_t enqueue __rte_unused)
 {
-	if (enqueue)
-		rte_smp_wmb();
-	else
-		rte_smp_rmb();
 	/*
 	 * If there are other enqueues/dequeues in progress that preceded us,
 	 * we need to wait for them to complete
 	 */
 	if (!single)
-		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&amp;ht-&gt;tail, old_val,
-			rte_memory_order_relaxed);
+		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&amp;ht-&gt;tail,
+			old_val, rte_memory_order_relaxed);
 
-	ht-&gt;tail = new_val;
+	/*
+	 * Release ordering on the tail store ensures that the slot reads
+	 * (dequeue) or writes (enqueue) performed by this thread are visible
+	 * to the other side before the new tail value is observed.
+	 * Pairs with the acquire load of the counterpart's tail in
+	 * __rte_ring_headtail_move_head().
+	 */
+	rte_atomic_store_explicit(&amp;ht-&gt;tail, new_val, rte_memory_order_release);
 }
 
 /**
@@ -76,25 +80,35 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 {
 	unsigned int max = n;
 	int success;
+	uint32_t tail;
 
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
 
-		*old_head = d-&gt;head;
+		/*
+		 * Acquire load: orders this load before the load of s-&gt;tail
+		 * below (replaces rte_smp_rmb() in the previous version) and
+		 * re-establishes ordering after a failed CAS on retry.
+		 */
+		*old_head = rte_atomic_load_explicit(&amp;d-&gt;head,
+				rte_memory_order_acquire);
 
-		/* add rmb barrier to avoid load/load reorder in weak
-		 * memory model. It is noop on x86
+		/*
+		 * Acquire load on the counterpart's tail pairs with the
+		 * release store in __rte_ring_update_tail() on the other
+		 * side, ensuring slot operations performed there are visible
+		 * before the caller accesses the reserved slots.
 		 */
-		rte_smp_rmb();
+		tail = rte_atomic_load_explicit(&amp;s-&gt;tail, rte_memory_order_acquire);
 
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
 		 * (the result is always modulo 32 bits even if we have
-		 * *old_head &gt; s-&gt;tail). So 'entries' is always between 0
+		 * *old_head &gt; tail). So 'entries' is always between 0
 		 * and capacity (which is &lt; size).
 		 */
-		*entries = (capacity + s-&gt;tail - *old_head);
+		*entries = (capacity + tail - *old_head);
 
 		/* check that we have enough room in ring */
 		if (unlikely(n &gt; *entries))
@@ -106,12 +120,24 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 
 		*new_head = *old_head + n;
 		if (is_st) {
-			d-&gt;head = *new_head;
+			rte_atomic_store_explicit(&amp;d-&gt;head, *new_head, rte_memory_order_relaxed);
 			success = 1;
-		} else
-			success = rte_atomic32_cmpset(
-					(uint32_t *)(uintptr_t)&amp;d-&gt;head,
-					*old_head, *new_head);
+		} else {
+			/*
+			 * Weak CAS: the outer do-while handles spurious
+			 * failures, so we avoid the strong variant's
+			 * internal retry (which on arm64 wraps the LL/SC
+			 * pair in a hidden inner loop).
+			 *
+			 * Relaxed on both success and failure: this CAS
+			 * does not publish data. Slot data visibility is
+			 * provided by the acquire loads above and the
+			 * release store of tail in __rte_ring_update_tail().
+			 */
+			success = rte_atomic_compare_exchange_weak_explicit(
+				&amp;d-&gt;head, old_head, *new_head,
+				rte_memory_order_relaxed, rte_memory_order_relaxed);
+		}
 	} while (unlikely(success == 0));
 	return n;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------UE866PA3vK8hAGzqxB8WDIVw--
