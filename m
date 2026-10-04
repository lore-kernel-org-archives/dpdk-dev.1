Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9763BCA5FCE
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 12:58:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86BBC4027F;
	Sun,  4 Oct 2026 14:58:13 +0200 (CEST)
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [178.154.239.82])
 by mails.dpdk.org (Postfix) with ESMTP id B07D740276
 for <dev@dpdk.org>; Sun,  4 Oct 2026 14:58:11 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward502a.mail.yandex.net (postfix) with ESMTPS id 6832380843;
 Sun, 04 Oct 2026 15:58:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id wvJKR2pdMCg0-GMopTOyK; 
 Sun, 04 Oct 2026 15:58:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791118689; bh=/fw6X4xDb1muciV6sJhARx+mpN/73IFDyczdZ4qnzEw=;
 h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
 b=q8LY4Cn4Oav7gRcSqzuholcaGGpROyKkDZX+OTD3wtPgsSfVruYNI3tpsqhHrlQgw
 EOHSclh2oIawfCLtDcQZdmJTJFrpD2E8BbtbG+z5OBKKMMMGJqmJe1Ck398ZMA0FMv
 f4pGYtGHA+iAe4P0SaL2jkKEnX3Lag2rvYLpLIlg=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Message-ID: <cb765588-e72c-4a85-a1f4-3dc3ae4c5820@yandex.ru>
Date: Sun, 4 Oct 2026 13:57:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stephen@networkplumber.org, "dev@dpdk.org" <dev@dpdk.org>
Cc: drc@linux.ibm.com, rileyf@linux.ibm.com, sunyuechi@iscas.ac.cn,
 maobibo@loongson.cn, wathsala.vithanage@arm.com
References: <20260920181347.747210-20-stephen@networkplumber.org>
Subject: Re: [PATCH v2 19/33] test/barrier: test sequentially consistent fence
 only
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20260920181347.747210-20-stephen@networkplumber.org>
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

> te_smp_mb() is removed by this series, leaving the barrier test with
> one case instead of two.  Drop the use type enum and the barrier
> selector wrapper.
>
> Convert the Peterson lock to explicit atomic accesses with relaxed
> ordering, leaving rte_atomic_thread_fence(rte_memory_order_seq_cst)
> as the only thing preventing store-load reordering.


Run it on both x86 and arm boxes, both passed.
Other arch maintainers, pls review, test.
Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Tested-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   app/test/test_barrier.c <https://inbox.dpdk.org/dev/20260920181347.747210-20-stephen@networkplumber.org/#Z31app:test:test_barrier.c> | 105 +++++++++++++---------------------------
>   1 file changed, 34 insertions(+), 71 deletions(-)
>
> diff 
> <https://inbox.dpdk.org/dev/20260920181347.747210-20-stephen@networkplumber.org/#iZ31app:test:test_barrier.c> 
> --git a/app/test/test_barrier.c b/app/test/test_barrier.c index 
> 925a88b68a..cb876d8fda 100644 --- a/app/test/test_barrier.c +++ 
> b/app/test/test_barrier.c @@ -2,51 +2,41 @@   * Copyright(c) 2010-2018 Intel Corporation
>    */
>   
> - /* - * This is a simple functional test for rte_smp_mb() 
> implementation. - * I.E. make sure that LOAD and STORE operations that 
> precede the - * rte_smp_mb() call are globally visible across the 
> lcores - * before the LOAD and STORE operations that follows it. - * 
> The test uses simple implementation of Peterson's lock algorithm - * 
> (https://en.wikipedia.org/wiki/Peterson%27s_algorithm) - * for two 
> execution units to make sure that rte_smp_mb() prevents - * store-load 
> reordering to happen. - * Also when executed on a single lcore could 
> be used as a approximate - * estimation of number of cycles particular 
> implementation of rte_smp_mb() - * will take. - */ +/* + * Functional 
> test for rte_atomic_thread_fence(rte_memory_order_seq_cst). + * I.E. 
> make sure that LOAD and STORE operations that precede the fence + * 
> are globally visible across the lcores before the LOAD and STORE + * 
> operations that follow it. + * The test uses a simple implementation 
> of Peterson's lock algorithm + * 
> (https://en.wikipedia.org/wiki/Peterson%27s_algorithm) + * for two 
> execution units, since that algorithm only works if + * store-load 
> reordering is prevented. + * Also when executed on a single lcore it 
> can be used as an approximate + * estimate of the number of cycles a 
> sequentially consistent fence takes. + */  
> +#include <errno.h>  #include <stdio.h>
> -#include <string.h>  #include <stdint.h>
> +#include <stdlib.h>  #include <inttypes.h>
>   
> -#include <rte_memory.h> -#include <rte_per_lcore.h>  #include <rte_launch.h>
>   #include <rte_eal.h>
>   #include <rte_lcore.h>
>   #include <rte_pause.h>
>   #include <rte_random.h>
>   #include <rte_cycles.h>
> -#include <rte_vect.h> -#include <rte_debug.h> +#include 
> <rte_stdatomic.h>  
>   #include "test.h"
>   
>   #define ADD_MAX		8
>   #define ITER_MAX	0x1000000
>   
> -enum plock_use_type { - USE_MB, - USE_SMP_MB, - USE_NUM -}; -  struct plock {
> - volatile uint32_t flag[2]; - volatile uint32_t victim; - enum 
> plock_use_type utype; + RTE_ATOMIC(uint32_t) flag[2]; + 
> RTE_ATOMIC(uint32_t) victim;  };
>   
>   /*
> @@ -69,19 +59,11 @@ struct lcore_plock_test {  	uint32_t lc;              /* given lcore id */
>   };
>   
> -static inline void -store_load_barrier(uint32_t utype) -{ - if (utype 
> == USE_MB) - rte_mb(); - else if (utype == USE_SMP_MB) - rte_smp_mb(); 
> - else - RTE_VERIFY(0); -} -  /*
>    * Peterson lock implementation.
> + * The stores below are relaxed on purpose: the sequentially 
> consistent + * fence is the only thing keeping them ahead of the loads 
> in the spin + * loop, so a broken fence shows up as two lcores in the 
> critical section.   */
>   static void
>   plock_lock(struct plock *l, uint32_t self)
> @@ -90,29 +72,22 @@ plock_lock(struct plock *l, uint32_t self)  
>   	other = self ^ 1;
>   
> - l->flag[self] = 1; - rte_smp_wmb(); - l->victim = self; + 
> rte_atomic_store_explicit(&l->flag[self], 1, 
> rte_memory_order_relaxed); + rte_atomic_store_explicit(&l->victim, 
> self, rte_memory_order_relaxed);  
> - store_load_barrier(l->utype); + 
> rte_atomic_thread_fence(rte_memory_order_seq_cst);  
> - while (l->flag[other] == 1 && l->victim == self) + while 
> (rte_atomic_load_explicit(&l->flag[other], rte_memory_order_relaxed) 
> == 1 && + rte_atomic_load_explicit(&l->victim, 
> rte_memory_order_relaxed) == self)  		rte_pause();
> - rte_smp_rmb(); -}  
> -static void -plock_unlock(struct plock *l, uint32_t self) -{ - 
> rte_smp_wmb(); - l->flag[self] = 0; + 
> rte_atomic_thread_fence(rte_memory_order_acquire);  }
>   
>   static void
> -plock_reset(struct plock *l, enum plock_use_type utype) 
> +plock_unlock(struct plock *l, uint32_t self)  {
> - memset(l, 0, sizeof(*l)); - l->utype = utype; + 
> rte_atomic_store_explicit(&l->flag[self], 0, rte_memory_order_release);  }
>   
>   /*
> @@ -186,7 +161,7 @@ plock_test1_lcore(void *data)   * and local data are the same.
>    */
>   static int
> -plock_test(uint64_t iter, enum plock_use_type utype) 
> +plock_test(uint64_t iter)  {
>   	int32_t rc;
>   	uint32_t i, lc, n;
> @@ -201,8 +176,7 @@ plock_test(uint64_t iter, enum plock_use_type utype)  	lpt = calloc(n, sizeof(*lpt));
>   	sum = calloc(n + 1, sizeof(*sum));
>   
> - printf("%s(iter=%" PRIu64 ", utype=%u) started on %u lcores\n", - 
> __func__, iter, utype, n); + printf("%s(iter=%" PRIu64 ") started on 
> %u lcores\n", __func__, iter, n);  
>   	if (pt == NULL || lpt == NULL || sum == NULL) {
>   		printf("%s: failed to allocate memory for %u lcores\n",
> @@ -213,9 +187,6 @@ plock_test(uint64_t iter, enum plock_use_type utype)  		return -ENOMEM;
>   	}
>   
> - for (i = 0; i != n + 1; i++) - plock_reset(&pt[i].lock, utype); -  	i = 0;
>   	RTE_LCORE_FOREACH(lc) {
>   
> @@ -263,26 +234,18 @@ plock_test(uint64_t iter, enum plock_use_type 
> utype)  	free(lpt);
>   	free(sum);
>   
> - printf("%s(utype=%u) returns %d\n", __func__, utype, rc); + 
> printf("%s returns %d\n", __func__, rc);  	return rc;
>   }
>   
>   static int
>   test_barrier(void)
>   {
> - int32_t i, ret, rc[USE_NUM]; - - for (i = 0; i != RTE_DIM(rc); i++) 
> - rc[i] = plock_test(ITER_MAX, i); + int rc = plock_test(ITER_MAX);  
> - ret = 0; - for (i = 0; i != RTE_DIM(rc); i++) { - printf("%s for 
> utype=%d %s\n", - __func__, i, rc[i] == 0 ? "passed" : "failed"); - 
> ret |= rc[i]; - } + printf("%s %s\n", __func__, rc == 0 ? "passed" : 
> "failed");  
> - return ret; + return rc;  }
>   
>   REGISTER_PERF_TEST(barrier_autotest, test_barrier);
> -- 
> 2.53.0
