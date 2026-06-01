Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9EBCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7FBB402F1;
	Mon,  1 Jun 2026 20:23:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F0D76402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:23:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gTj4Z4G1yzHnGdP;
 Tue,  2 Jun 2026 02:22:54 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 8DA5540569;
 Tue,  2 Jun 2026 02:23:42 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 1 Jun 2026 19:23:42 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 1 Jun 2026 19:23:42 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Bibo Mao
 <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>, Sun Yuechi
 <sunyuechi@iscas.ac.cn>, Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH v4 01/27] eal: use intrinsics for rte_atomic on all
 platforms
Thread-Topic: [PATCH v4 01/27] eal: use intrinsics for rte_atomic on all
 platforms
Thread-Index: AQHc7Wb/Bk0j7XBYMUmdMlDDcdLLRrYqDJCA
Date: Mon, 1 Jun 2026 18:23:41 +0000
Message-ID: <3e30b54a14ab437c93277895e3cebc2a@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-2-stephen@networkplumber.org>
In-Reply-To: <20260526232542.620966-2-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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


> Next step is to deprecate the rte_atomicNN_*() family. Rather than
> maintaining both the inline asm and intrinsic fallbacks, drop the
> asm paths and use intrinsics everywhere.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/arm/include/rte_atomic_32.h    |   4 -
>  lib/eal/arm/include/rte_atomic_64.h    |   4 -
>  lib/eal/include/generic/rte_atomic.h   |  76 +---------
>  lib/eal/loongarch/include/rte_atomic.h |   4 -
>  lib/eal/ppc/include/rte_atomic.h       | 173 -----------------------
>  lib/eal/riscv/include/rte_atomic.h     |   4 -
>  lib/eal/x86/include/rte_atomic.h       | 172 ----------------------
>  lib/eal/x86/include/rte_atomic_32.h    | 188 -------------------------
>  lib/eal/x86/include/rte_atomic_64.h    | 157 ---------------------
>  9 files changed, 6 insertions(+), 776 deletions(-)
>=20
> diff --git a/lib/eal/arm/include/rte_atomic_32.h
> b/lib/eal/arm/include/rte_atomic_32.h
> index 0b9a0dfa30..696a539fef 100644
> --- a/lib/eal/arm/include/rte_atomic_32.h
> +++ b/lib/eal/arm/include/rte_atomic_32.h
> @@ -5,10 +5,6 @@
>  #ifndef _RTE_ATOMIC_ARM32_H_
>  #define _RTE_ATOMIC_ARM32_H_
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -#  error Platform must be built with RTE_FORCE_INTRINSICS
> -#endif
> -
>  #include "generic/rte_atomic.h"
>=20
>  #ifdef __cplusplus
> diff --git a/lib/eal/arm/include/rte_atomic_64.h
> b/lib/eal/arm/include/rte_atomic_64.h
> index 181bb60929..9f790238df 100644
> --- a/lib/eal/arm/include/rte_atomic_64.h
> +++ b/lib/eal/arm/include/rte_atomic_64.h
> @@ -6,10 +6,6 @@
>  #ifndef _RTE_ATOMIC_ARM64_H_
>  #define _RTE_ATOMIC_ARM64_H_
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -#  error Platform must be built with RTE_FORCE_INTRINSICS
> -#endif
> -
>  #include "generic/rte_atomic.h"
>  #include <rte_branch_prediction.h>
>  #include <rte_debug.h>
> diff --git a/lib/eal/include/generic/rte_atomic.h
> b/lib/eal/include/generic/rte_atomic.h
> index 0a4f3f8528..292e52fade 100644
> --- a/lib/eal/include/generic/rte_atomic.h
> +++ b/lib/eal/include/generic/rte_atomic.h
> @@ -187,13 +187,11 @@ static inline void
> rte_atomic_thread_fence(rte_memory_order memorder);
>  static inline int
>  rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int
>  rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
>  {
>  	return __sync_bool_compare_and_swap(dst, exp, src);
>  }
> -#endif
>=20
>  /**
>   * Atomic exchange.
> @@ -211,15 +209,11 @@ rte_atomic16_cmpset(volatile uint16_t *dst, uint16_=
t
> exp, uint16_t src)
>   *   The original value at that location
>   */
>  static inline uint16_t
> -rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val);
> -
> -#ifdef RTE_FORCE_INTRINSICS
> -static inline uint16_t
>  rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
>  {
> -	return rte_atomic_exchange_explicit(dst, val,
> rte_memory_order_seq_cst);
> +	return rte_atomic_exchange_explicit((volatile __rte_atomic uint16_t
> *)dst,
> +		val, rte_memory_order_seq_cst);
>  }
> -#endif
>=20
>  /**
>   * The atomic counter structure.
> @@ -312,13 +306,11 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
>  static inline void
>  rte_atomic16_inc(rte_atomic16_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic16_inc(rte_atomic16_t *v)
>  {
>  	rte_atomic16_add(v, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically decrement a counter by one.
> @@ -329,13 +321,11 @@ rte_atomic16_inc(rte_atomic16_t *v)
>  static inline void
>  rte_atomic16_dec(rte_atomic16_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic16_dec(rte_atomic16_t *v)
>  {
>  	rte_atomic16_sub(v, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically add a 16-bit value to a counter and return the result.
> @@ -391,13 +381,11 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t
> dec)
>   */
>  static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
>  {
>  	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&=
v-
> >cnt, 1,
>  		rte_memory_order_seq_cst) + 1 =3D=3D 0;
>  }
> -#endif
>=20
>  /**
>   * Atomically decrement a 16-bit counter by one and test.
> @@ -412,13 +400,11 @@ static inline int
> rte_atomic16_inc_and_test(rte_atomic16_t *v)
>   */
>  static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
>  {
>  	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&=
v-
> >cnt, 1,
>  		rte_memory_order_seq_cst) - 1 =3D=3D 0;
>  }
> -#endif
>=20
>  /**
>   * Atomically test and set a 16-bit atomic counter.
> @@ -433,12 +419,10 @@ static inline int
> rte_atomic16_dec_and_test(rte_atomic16_t *v)
>   */
>  static inline int rte_atomic16_test_and_set(rte_atomic16_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
>  {
>  	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically set a 16-bit counter to 0.
> @@ -472,13 +456,11 @@ static inline void rte_atomic16_clear(rte_atomic16_=
t
> *v)
>  static inline int
>  rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int
>  rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
>  {
>  	return __sync_bool_compare_and_swap(dst, exp, src);
>  }
> -#endif
>=20
>  /**
>   * Atomic exchange.
> @@ -496,15 +478,11 @@ rte_atomic32_cmpset(volatile uint32_t *dst, uint32_=
t
> exp, uint32_t src)
>   *   The original value at that location
>   */
>  static inline uint32_t
> -rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val);
> -
> -#ifdef RTE_FORCE_INTRINSICS
> -static inline uint32_t
>  rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
>  {
> -	return rte_atomic_exchange_explicit(dst, val,
> rte_memory_order_seq_cst);
> +	return rte_atomic_exchange_explicit((volatile __rte_atomic uint32_t
> *)dst,
> +					    val, rte_memory_order_seq_cst);
>  }
> -#endif
>=20
>  /**
>   * The atomic counter structure.
> @@ -597,13 +575,11 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
>  static inline void
>  rte_atomic32_inc(rte_atomic32_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic32_inc(rte_atomic32_t *v)
>  {
>  	rte_atomic32_add(v, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically decrement a counter by one.
> @@ -614,13 +590,11 @@ rte_atomic32_inc(rte_atomic32_t *v)
>  static inline void
>  rte_atomic32_dec(rte_atomic32_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic32_dec(rte_atomic32_t *v)
>  {
>  	rte_atomic32_sub(v,1);
>  }
> -#endif
>=20
>  /**
>   * Atomically add a 32-bit value to a counter and return the result.
> @@ -676,13 +650,11 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t
> dec)
>   */
>  static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
>  {
>  	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&=
v-
> >cnt, 1,
>  		rte_memory_order_seq_cst) + 1 =3D=3D 0;
>  }
> -#endif
>=20
>  /**
>   * Atomically decrement a 32-bit counter by one and test.
> @@ -697,13 +669,11 @@ static inline int
> rte_atomic32_inc_and_test(rte_atomic32_t *v)
>   */
>  static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
>  {
>  	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&=
v-
> >cnt, 1,
>  		rte_memory_order_seq_cst) - 1 =3D=3D 0;
>  }
> -#endif
>=20
>  /**
>   * Atomically test and set a 32-bit atomic counter.
> @@ -718,12 +688,10 @@ static inline int
> rte_atomic32_dec_and_test(rte_atomic32_t *v)
>   */
>  static inline int rte_atomic32_test_and_set(rte_atomic32_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
>  {
>  	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically set a 32-bit counter to 0.
> @@ -756,13 +724,11 @@ static inline void rte_atomic32_clear(rte_atomic32_=
t
> *v)
>  static inline int
>  rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int
>  rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
>  {
>  	return __sync_bool_compare_and_swap(dst, exp, src);
>  }
> -#endif
>=20
>  /**
>   * Atomic exchange.
> @@ -780,15 +746,11 @@ rte_atomic64_cmpset(volatile uint64_t *dst, uint64_=
t
> exp, uint64_t src)
>   *   The original value at that location
>   */
>  static inline uint64_t
> -rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val);
> -
> -#ifdef RTE_FORCE_INTRINSICS
> -static inline uint64_t
>  rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
>  {
> -	return rte_atomic_exchange_explicit(dst, val,
> rte_memory_order_seq_cst);
> +	return rte_atomic_exchange_explicit((volatile __rte_atomic uint64_t
> *)dst,
> +					    val, rte_memory_order_seq_cst);
>  }
> -#endif
>=20
>  /**
>   * The atomic counter structure.
> @@ -811,7 +773,6 @@ typedef struct {
>  static inline void
>  rte_atomic64_init(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic64_init(rte_atomic64_t *v)
>  {
> @@ -828,7 +789,6 @@ rte_atomic64_init(rte_atomic64_t *v)
>  	}
>  #endif
>  }
> -#endif
>=20
>  /**
>   * Atomically read a 64-bit counter.
> @@ -841,7 +801,6 @@ rte_atomic64_init(rte_atomic64_t *v)
>  static inline int64_t
>  rte_atomic64_read(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int64_t
>  rte_atomic64_read(rte_atomic64_t *v)
>  {
> @@ -860,7 +819,6 @@ rte_atomic64_read(rte_atomic64_t *v)
>  	return tmp;
>  #endif
>  }
> -#endif
>=20
>  /**
>   * Atomically set a 64-bit counter.
> @@ -873,7 +831,6 @@ rte_atomic64_read(rte_atomic64_t *v)
>  static inline void
>  rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
>  {
> @@ -890,7 +847,6 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value=
)
>  	}
>  #endif
>  }
> -#endif
>=20
>  /**
>   * Atomically add a 64-bit value to a counter.
> @@ -903,14 +859,12 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t
> new_value)
>  static inline void
>  rte_atomic64_add(rte_atomic64_t *v, int64_t inc);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
>  {
>  	rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt,
> inc,
>  		rte_memory_order_seq_cst);
>  }
> -#endif
>=20
>  /**
>   * Atomically subtract a 64-bit value from a counter.
> @@ -923,14 +877,12 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
>  static inline void
>  rte_atomic64_sub(rte_atomic64_t *v, int64_t dec);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
>  {
>  	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt,
> dec,
>  		rte_memory_order_seq_cst);
>  }
> -#endif
>=20
>  /**
>   * Atomically increment a 64-bit counter by one and test.
> @@ -941,13 +893,11 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
>  static inline void
>  rte_atomic64_inc(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic64_inc(rte_atomic64_t *v)
>  {
>  	rte_atomic64_add(v, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically decrement a 64-bit counter by one and test.
> @@ -958,13 +908,11 @@ rte_atomic64_inc(rte_atomic64_t *v)
>  static inline void
>  rte_atomic64_dec(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void
>  rte_atomic64_dec(rte_atomic64_t *v)
>  {
>  	rte_atomic64_sub(v, 1);
>  }
> -#endif
>=20
>  /**
>   * Add a 64-bit value to an atomic counter and return the result.
> @@ -982,14 +930,12 @@ rte_atomic64_dec(rte_atomic64_t *v)
>  static inline int64_t
>  rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int64_t
>  rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
>  {
>  	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&=
v-
> >cnt, inc,
>  		rte_memory_order_seq_cst) + inc;
>  }
> -#endif
>=20
>  /**
>   * Subtract a 64-bit value from an atomic counter and return the result.
> @@ -1007,14 +953,12 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t
> inc)
>  static inline int64_t
>  rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int64_t
>  rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
>  {
>  	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&=
v-
> >cnt, dec,
>  		rte_memory_order_seq_cst) - dec;
>  }
> -#endif
>=20
>  /**
>   * Atomically increment a 64-bit counter by one and test.
> @@ -1029,12 +973,10 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t
> dec)
>   */
>  static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
>  {
>  	return rte_atomic64_add_return(v, 1) =3D=3D 0;
>  }
> -#endif
>=20
>  /**
>   * Atomically decrement a 64-bit counter by one and test.
> @@ -1049,12 +991,10 @@ static inline int
> rte_atomic64_inc_and_test(rte_atomic64_t *v)
>   */
>  static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
>  {
>  	return rte_atomic64_sub_return(v, 1) =3D=3D 0;
>  }
> -#endif
>=20
>  /**
>   * Atomically test and set a 64-bit atomic counter.
> @@ -1069,12 +1009,10 @@ static inline int
> rte_atomic64_dec_and_test(rte_atomic64_t *v)
>   */
>  static inline int rte_atomic64_test_and_set(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
>  {
>  	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
>  }
> -#endif
>=20
>  /**
>   * Atomically set a 64-bit counter to 0.
> @@ -1084,12 +1022,10 @@ static inline int
> rte_atomic64_test_and_set(rte_atomic64_t *v)
>   */
>  static inline void rte_atomic64_clear(rte_atomic64_t *v);
>=20
> -#ifdef RTE_FORCE_INTRINSICS
>  static inline void rte_atomic64_clear(rte_atomic64_t *v)
>  {
>  	rte_atomic64_set(v, 0);
>  }
> -#endif
>=20
>  #endif
>=20
> diff --git a/lib/eal/loongarch/include/rte_atomic.h
> b/lib/eal/loongarch/include/rte_atomic.h
> index c8066a4612..785a452c9e 100644
> --- a/lib/eal/loongarch/include/rte_atomic.h
> +++ b/lib/eal/loongarch/include/rte_atomic.h
> @@ -5,10 +5,6 @@
>  #ifndef RTE_ATOMIC_LOONGARCH_H
>  #define RTE_ATOMIC_LOONGARCH_H
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -#  error Platform must be built with RTE_FORCE_INTRINSICS
> -#endif
> -
>  #include <rte_common.h>
>  #include "generic/rte_atomic.h"
>=20
> diff --git a/lib/eal/ppc/include/rte_atomic.h b/lib/eal/ppc/include/rte_a=
tomic.h
> index 10acc238f9..64f4c3d670 100644
> --- a/lib/eal/ppc/include/rte_atomic.h
> +++ b/lib/eal/ppc/include/rte_atomic.h
> @@ -43,179 +43,6 @@ rte_atomic_thread_fence(rte_memory_order memorder)
>  }
>=20
>  /*------------------------- 16 bit atomic operations -------------------=
------*/
> -#ifndef RTE_FORCE_INTRINSICS
> -static inline int
> -rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
> -{
> -	return rte_atomic_compare_exchange_strong_explicit(dst, &exp, src,
> rte_memory_order_acquire,
> -		rte_memory_order_acquire) ? 1 : 0;
> -}
> -
> -static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
> -{
> -	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void
> -rte_atomic16_inc(rte_atomic16_t *v)
> -{
> -	rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire);
> -}
> -
> -static inline void
> -rte_atomic16_dec(rte_atomic16_t *v)
> -{
> -	rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire);
> -}
> -
> -static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
> -{
> -	return rte_atomic_fetch_add_explicit(&v->cnt, 1,
> rte_memory_order_acquire) + 1 =3D=3D 0;
> -}
> -
> -static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
> -{
> -	return rte_atomic_fetch_sub_explicit(&v->cnt, 1,
> rte_memory_order_acquire) - 1 =3D=3D 0;
> -}
> -
> -static inline uint16_t
> -rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
> -{
> -	return __atomic_exchange_2(dst, val, rte_memory_order_seq_cst);
> -}
> -
> -/*------------------------- 32 bit atomic operations -------------------=
------*/
> -
> -static inline int
> -rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
> -{
> -	return rte_atomic_compare_exchange_strong_explicit(dst, &exp, src,
> rte_memory_order_acquire,
> -		rte_memory_order_acquire) ? 1 : 0;
> -}
> -
> -static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
> -{
> -	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void
> -rte_atomic32_inc(rte_atomic32_t *v)
> -{
> -	rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire);
> -}
> -
> -static inline void
> -rte_atomic32_dec(rte_atomic32_t *v)
> -{
> -	rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire);
> -}
> -
> -static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
> -{
> -	return rte_atomic_fetch_add_explicit(&v->cnt, 1,
> rte_memory_order_acquire) + 1 =3D=3D 0;
> -}
> -
> -static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
> -{
> -	return rte_atomic_fetch_sub_explicit(&v->cnt, 1,
> rte_memory_order_acquire) - 1 =3D=3D 0;
> -}
> -
> -static inline uint32_t
> -rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
> -{
> -	return __atomic_exchange_4(dst, val, rte_memory_order_seq_cst);
> -}
> -
> -/*------------------------- 64 bit atomic operations -------------------=
------*/
> -
> -static inline int
> -rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
> -{
> -	return rte_atomic_compare_exchange_strong_explicit(dst, &exp, src,
> rte_memory_order_acquire,
> -		rte_memory_order_acquire) ? 1 : 0;
> -}
> -
> -static inline void
> -rte_atomic64_init(rte_atomic64_t *v)
> -{
> -	v->cnt =3D 0;
> -}
> -
> -static inline int64_t
> -rte_atomic64_read(rte_atomic64_t *v)
> -{
> -	return v->cnt;
> -}
> -
> -static inline void
> -rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
> -{
> -	v->cnt =3D new_value;
> -}
> -
> -static inline void
> -rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
> -{
> -	rte_atomic_fetch_add_explicit(&v->cnt, inc, rte_memory_order_acquire);
> -}
> -
> -static inline void
> -rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
> -{
> -	rte_atomic_fetch_sub_explicit(&v->cnt, dec,
> rte_memory_order_acquire);
> -}
> -
> -static inline void
> -rte_atomic64_inc(rte_atomic64_t *v)
> -{
> -	rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire);
> -}
> -
> -static inline void
> -rte_atomic64_dec(rte_atomic64_t *v)
> -{
> -	rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire);
> -}
> -
> -static inline int64_t
> -rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
> -{
> -	return rte_atomic_fetch_add_explicit(&v->cnt, inc,
> rte_memory_order_acquire) + inc;
> -}
> -
> -static inline int64_t
> -rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
> -{
> -	return rte_atomic_fetch_sub_explicit(&v->cnt, dec,
> rte_memory_order_acquire) - dec;
> -}
> -
> -static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
> -{
> -	return rte_atomic_fetch_add_explicit(&v->cnt, 1,
> rte_memory_order_acquire) + 1 =3D=3D 0;
> -}
> -
> -static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
> -{
> -	return rte_atomic_fetch_sub_explicit(&v->cnt, 1,
> rte_memory_order_acquire) - 1 =3D=3D 0;
> -}
> -
> -static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
> -{
> -	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void rte_atomic64_clear(rte_atomic64_t *v)
> -{
> -	v->cnt =3D 0;
> -}
> -
> -static inline uint64_t
> -rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
> -{
> -	return __atomic_exchange_8(dst, val, rte_memory_order_seq_cst);
> -}
> -
> -#endif
>=20
>  #ifdef __cplusplus
>  }
> diff --git a/lib/eal/riscv/include/rte_atomic.h b/lib/eal/riscv/include/r=
te_atomic.h
> index 66346ad474..061b175f33 100644
> --- a/lib/eal/riscv/include/rte_atomic.h
> +++ b/lib/eal/riscv/include/rte_atomic.h
> @@ -8,10 +8,6 @@
>  #ifndef RTE_ATOMIC_RISCV_H
>  #define RTE_ATOMIC_RISCV_H
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -#  error Platform must be built with RTE_FORCE_INTRINSICS
> -#endif
> -
>  #include <stdint.h>
>  #include <rte_common.h>
>  #include <rte_config.h>
> diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_a=
tomic.h
> index e071e4234e..4f05302c9f 100644
> --- a/lib/eal/x86/include/rte_atomic.h
> +++ b/lib/eal/x86/include/rte_atomic.h
> @@ -111,178 +111,6 @@ rte_atomic_thread_fence(rte_memory_order
> memorder)
>  extern "C" {
>  #endif
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -static inline int
> -rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
> -{
> -	uint8_t res;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"cmpxchgw %[src], %[dst];"
> -			"sete %[res];"
> -			: [res] "=3Da" (res),     /* output */
> -			  [dst] "=3Dm" (*dst)
> -			: [src] "r" (src),      /* input */
> -			  "a" (exp),
> -			  "m" (*dst)
> -			: "memory");            /* no-clobber list */
> -	return res;
> -}
> -
> -static inline uint16_t
> -rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"xchgw %0, %1;"
> -			: "=3Dr" (val), "=3Dm" (*dst)
> -			: "0" (val),  "m" (*dst)
> -			: "memory");         /* no-clobber list */
> -	return val;
> -}
> -
> -static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
> -{
> -	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void
> -rte_atomic16_inc(rte_atomic16_t *v)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"incw %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: "m" (v->cnt)          /* input */
> -			);
> -}
> -
> -static inline void
> -rte_atomic16_dec(rte_atomic16_t *v)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"decw %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: "m" (v->cnt)          /* input */
> -			);
> -}
> -
> -static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
> -{
> -	uint8_t ret;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"incw %[cnt] ; "
> -			"sete %[ret]"
> -			: [cnt] "+m" (v->cnt),  /* output */
> -			  [ret] "=3Dqm" (ret)
> -			);
> -	return ret !=3D 0;
> -}
> -
> -static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
> -{
> -	uint8_t ret;
> -
> -	asm volatile(MPLOCKED
> -			"decw %[cnt] ; "
> -			"sete %[ret]"
> -			: [cnt] "+m" (v->cnt),  /* output */
> -			  [ret] "=3Dqm" (ret)
> -			);
> -	return ret !=3D 0;
> -}
> -
> -/*------------------------- 32 bit atomic operations -------------------=
------*/
> -
> -static inline int
> -rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
> -{
> -	uint8_t res;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"cmpxchgl %[src], %[dst];"
> -			"sete %[res];"
> -			: [res] "=3Da" (res),     /* output */
> -			  [dst] "=3Dm" (*dst)
> -			: [src] "r" (src),      /* input */
> -			  "a" (exp),
> -			  "m" (*dst)
> -			: "memory");            /* no-clobber list */
> -	return res;
> -}
> -
> -static inline uint32_t
> -rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"xchgl %0, %1;"
> -			: "=3Dr" (val), "=3Dm" (*dst)
> -			: "0" (val),  "m" (*dst)
> -			: "memory");         /* no-clobber list */
> -	return val;
> -}
> -
> -static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
> -{
> -	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void
> -rte_atomic32_inc(rte_atomic32_t *v)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"incl %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: "m" (v->cnt)          /* input */
> -			);
> -}
> -
> -static inline void
> -rte_atomic32_dec(rte_atomic32_t *v)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"decl %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: "m" (v->cnt)          /* input */
> -			);
> -}
> -
> -static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
> -{
> -	uint8_t ret;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"incl %[cnt] ; "
> -			"sete %[ret]"
> -			: [cnt] "+m" (v->cnt),  /* output */
> -			  [ret] "=3Dqm" (ret)
> -			);
> -	return ret !=3D 0;
> -}
> -
> -static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
> -{
> -	uint8_t ret;
> -
> -	asm volatile(MPLOCKED
> -			"decl %[cnt] ; "
> -			"sete %[ret]"
> -			: [cnt] "+m" (v->cnt),  /* output */
> -			  [ret] "=3Dqm" (ret)
> -			);
> -	return ret !=3D 0;
> -}
> -
> -#endif /* !RTE_FORCE_INTRINSICS */
>=20
>  #ifdef __cplusplus
>  }
> diff --git a/lib/eal/x86/include/rte_atomic_32.h
> b/lib/eal/x86/include/rte_atomic_32.h
> index 0f25863aa5..37d139f30d 100644
> --- a/lib/eal/x86/include/rte_atomic_32.h
> +++ b/lib/eal/x86/include/rte_atomic_32.h
> @@ -20,193 +20,5 @@
>=20
>  /*------------------------- 64 bit atomic operations -------------------=
------*/
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -static inline int
> -rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
> -{
> -	uint8_t res;
> -	union {
> -		struct {
> -			uint32_t l32;
> -			uint32_t h32;
> -		};
> -		uint64_t u64;
> -	} _exp, _src;
> -
> -	_exp.u64 =3D exp;
> -	_src.u64 =3D src;
> -
> -#ifndef __PIC__
> -    asm volatile (
> -            MPLOCKED
> -            "cmpxchg8b (%[dst]);"
> -            "setz %[res];"
> -            : [res] "=3Da" (res)      /* result in eax */
> -            : [dst] "S" (dst),      /* esi */
> -             "b" (_src.l32),       /* ebx */
> -             "c" (_src.h32),       /* ecx */
> -             "a" (_exp.l32),       /* eax */
> -             "d" (_exp.h32)        /* edx */
> -			: "memory" );           /* no-clobber list */
> -#else
> -	asm volatile (
> -            "xchgl %%ebx, %%edi;\n"
> -			MPLOCKED
> -			"cmpxchg8b (%[dst]);"
> -			"setz %[res];"
> -            "xchgl %%ebx, %%edi;\n"
> -			: [res] "=3Da" (res)      /* result in eax */
> -			: [dst] "S" (dst),      /* esi */
> -			  "D" (_src.l32),       /* ebx */
> -			  "c" (_src.h32),       /* ecx */
> -			  "a" (_exp.l32),       /* eax */
> -			  "d" (_exp.h32)        /* edx */
> -			: "memory" );           /* no-clobber list */
> -#endif
> -
> -	return res;
> -}
> -
> -static inline uint64_t
> -rte_atomic64_exchange(volatile uint64_t *dest, uint64_t val)
> -{
> -	uint64_t old;
> -
> -	do {
> -		old =3D *dest;
> -	} while (rte_atomic64_cmpset(dest, old, val) =3D=3D 0);
> -
> -	return old;
> -}
> -
> -static inline void
> -rte_atomic64_init(rte_atomic64_t *v)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, 0);
> -	}
> -}
> -
> -static inline int64_t
> -rte_atomic64_read(rte_atomic64_t *v)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		/* replace the value by itself */
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, tmp);
> -	}
> -	return tmp;
> -}
> -
> -static inline void
> -rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, new_value);
> -	}
> -}
> -
> -static inline void
> -rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, tmp + inc);
> -	}
> -}
> -
> -static inline void
> -rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, tmp - dec);
> -	}
> -}
> -
> -static inline void
> -rte_atomic64_inc(rte_atomic64_t *v)
> -{
> -	rte_atomic64_add(v, 1);
> -}
> -
> -static inline void
> -rte_atomic64_dec(rte_atomic64_t *v)
> -{
> -	rte_atomic64_sub(v, 1);
> -}
> -
> -static inline int64_t
> -rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, tmp + inc);
> -	}
> -
> -	return tmp + inc;
> -}
> -
> -static inline int64_t
> -rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
> -{
> -	int success =3D 0;
> -	uint64_t tmp;
> -
> -	while (success =3D=3D 0) {
> -		tmp =3D v->cnt;
> -		success =3D rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
> -		                              tmp, tmp - dec);
> -	}
> -
> -	return tmp - dec;
> -}
> -
> -static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
> -{
> -	return rte_atomic64_add_return(v, 1) =3D=3D 0;
> -}
> -
> -static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
> -{
> -	return rte_atomic64_sub_return(v, 1) =3D=3D 0;
> -}
> -
> -static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
> -{
> -	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void rte_atomic64_clear(rte_atomic64_t *v)
> -{
> -	rte_atomic64_set(v, 0);
> -}
> -#endif
>=20
>  #endif /* _RTE_ATOMIC_I686_H_ */
> diff --git a/lib/eal/x86/include/rte_atomic_64.h
> b/lib/eal/x86/include/rte_atomic_64.h
> index 0a7a2131e0..1cd12695a2 100644
> --- a/lib/eal/x86/include/rte_atomic_64.h
> +++ b/lib/eal/x86/include/rte_atomic_64.h
> @@ -22,163 +22,6 @@
>=20
>  /*------------------------- 64 bit atomic operations -------------------=
------*/
>=20
> -#ifndef RTE_FORCE_INTRINSICS
> -static inline int
> -rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
> -{
> -	uint8_t res;
> -
> -
> -	asm volatile(
> -			MPLOCKED
> -			"cmpxchgq %[src], %[dst];"
> -			"sete %[res];"
> -			: [res] "=3Da" (res),     /* output */
> -			  [dst] "=3Dm" (*dst)
> -			: [src] "r" (src),      /* input */
> -			  "a" (exp),
> -			  "m" (*dst)
> -			: "memory");            /* no-clobber list */
> -
> -	return res;
> -}
> -
> -static inline uint64_t
> -rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"xchgq %0, %1;"
> -			: "=3Dr" (val), "=3Dm" (*dst)
> -			: "0" (val),  "m" (*dst)
> -			: "memory");         /* no-clobber list */
> -	return val;
> -}
> -
> -static inline void
> -rte_atomic64_init(rte_atomic64_t *v)
> -{
> -	v->cnt =3D 0;
> -}
> -
> -static inline int64_t
> -rte_atomic64_read(rte_atomic64_t *v)
> -{
> -	return v->cnt;
> -}
> -
> -static inline void
> -rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
> -{
> -	v->cnt =3D new_value;
> -}
> -
> -static inline void
> -rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"addq %[inc], %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: [inc] "ir" (inc),     /* input */
> -			  "m" (v->cnt)
> -			);
> -}
> -
> -static inline void
> -rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"subq %[dec], %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: [dec] "ir" (dec),     /* input */
> -			  "m" (v->cnt)
> -			);
> -}
> -
> -static inline void
> -rte_atomic64_inc(rte_atomic64_t *v)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"incq %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: "m" (v->cnt)          /* input */
> -			);
> -}
> -
> -static inline void
> -rte_atomic64_dec(rte_atomic64_t *v)
> -{
> -	asm volatile(
> -			MPLOCKED
> -			"decq %[cnt]"
> -			: [cnt] "=3Dm" (v->cnt)   /* output */
> -			: "m" (v->cnt)          /* input */
> -			);
> -}
> -
> -static inline int64_t
> -rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
> -{
> -	int64_t prev =3D inc;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"xaddq %[prev], %[cnt]"
> -			: [prev] "+r" (prev),   /* output */
> -			  [cnt] "=3Dm" (v->cnt)
> -			: "m" (v->cnt)          /* input */
> -			);
> -	return prev + inc;
> -}
> -
> -static inline int64_t
> -rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
> -{
> -	return rte_atomic64_add_return(v, -dec);
> -}
> -
> -static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
> -{
> -	uint8_t ret;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"incq %[cnt] ; "
> -			"sete %[ret]"
> -			: [cnt] "+m" (v->cnt), /* output */
> -			  [ret] "=3Dqm" (ret)
> -			);
> -
> -	return ret !=3D 0;
> -}
> -
> -static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
> -{
> -	uint8_t ret;
> -
> -	asm volatile(
> -			MPLOCKED
> -			"decq %[cnt] ; "
> -			"sete %[ret]"
> -			: [cnt] "+m" (v->cnt),  /* output */
> -			  [ret] "=3Dqm" (ret)
> -			);
> -	return ret !=3D 0;
> -}
> -
> -static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
> -{
> -	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
> -}
> -
> -static inline void rte_atomic64_clear(rte_atomic64_t *v)
> -{
> -	v->cnt =3D 0;
> -}
> -#endif
>=20
>  /*------------------------ 128 bit atomic operations -------------------=
------*/
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

