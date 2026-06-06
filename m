Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D876CD8C8C
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Jun 2026 14:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 362614028F;
	Sat,  6 Jun 2026 16:02:56 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BCBD740278
 for <dev@dpdk.org>; Sat,  6 Jun 2026 16:02:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gXg376k8PzHnGds;
 Sat,  6 Jun 2026 22:01:55 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 8852D40571;
 Sat,  6 Jun 2026 22:02:53 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 6 Jun 2026 15:02:53 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sat, 6 Jun 2026 15:02:52 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH v2 2/3] ring: use GCC builtin as alternative to
 rte_atomic32
Thread-Topic: [PATCH v2 2/3] ring: use GCC builtin as alternative to
 rte_atomic32
Thread-Index: AQHc9EBi2t0z9wUFLUi0myyhr0FdirYxkWsQ
Date: Sat, 6 Jun 2026 14:02:52 +0000
Message-ID: <4c3d1e6746e447029cd29a58c96e5dd3@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260604163656.1226902-1-stephen@networkplumber.org>
 <20260604163656.1226902-3-stephen@networkplumber.org>
In-Reply-To: <20260604163656.1226902-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.214]
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


> This patch replaces use of the deprecated rte_atomic32 code with
> GCC builtin atomic operations.
>=20
> Although it would be preferable to use C11 version on all architectures,
> there is a performance loss if we do it that way:
>=20
> Measured on i9-13900H, two physical cores MP/MC bulk n=3D128, 10 runs:
>   with C11 builtin:           5.86 cycles/elem
>   with __sync builtin:        5.36 cycles/elem  (-9.4%)
>=20
> The C11 __atomic_compare_exchange_n builtin writes the actual value back
> to its expected pointer on failure. On x86 this forces GCC
> to emit extra instructions on the critical path between the CAS
> and the success-test.
>=20
> __sync_bool_compare_and_swap returns a plain bool with no pointer
> writeback, allowing GCC to emit tighter code.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/meson.build                          |  2 +-
>  lib/ring/rte_ring_elem_pvt.h                  |  2 +-
>  ..._ring_generic_pvt.h =3D> rte_ring_gcc_pvt.h} | 33 +++++++++++--------
>  3 files changed, 21 insertions(+), 16 deletions(-)
>  rename lib/ring/{rte_ring_generic_pvt.h =3D> rte_ring_gcc_pvt.h} (88%)
>=20
> diff --git a/lib/ring/meson.build b/lib/ring/meson.build
> index 21f2c12989..2ba160b178 100644
> --- a/lib/ring/meson.build
> +++ b/lib/ring/meson.build
> @@ -9,7 +9,7 @@ indirect_headers +=3D files (
>          'rte_ring_elem.h',
>          'rte_ring_elem_pvt.h',
>          'rte_ring_c11_pvt.h',
> -        'rte_ring_generic_pvt.h',
> +        'rte_ring_gcc_pvt.h',
>          'rte_ring_hts.h',
>          'rte_ring_hts_elem_pvt.h',
>          'rte_ring_peek.h',
> diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
> index a0fdec9812..9a0170c4f0 100644
> --- a/lib/ring/rte_ring_elem_pvt.h
> +++ b/lib/ring/rte_ring_elem_pvt.h
> @@ -309,7 +309,7 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t
> cons_head,
>  #ifdef RTE_USE_C11_MEM_MODEL
>  #include "rte_ring_c11_pvt.h"
>  #else
> -#include "rte_ring_generic_pvt.h"
> +#include "rte_ring_gcc_pvt.h"
>  #endif
>=20
>  /**
> diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_gcc_pvt.=
h
> similarity index 88%
> rename from lib/ring/rte_ring_generic_pvt.h
> rename to lib/ring/rte_ring_gcc_pvt.h
> index c044b0824f..68ab1355e8 100644
> --- a/lib/ring/rte_ring_generic_pvt.h
> +++ b/lib/ring/rte_ring_gcc_pvt.h
> @@ -7,11 +7,11 @@
>   * Used as BSD-3 Licensed with permission from Kip Macy.
>   */
>=20
> -#ifndef _RTE_RING_GENERIC_PVT_H_
> -#define _RTE_RING_GENERIC_PVT_H_
> +#ifndef _RTE_RING_GCC_PVT_H_
> +#define _RTE_RING_GCC_PVT_H_
>=20
>  /**
> - * @file rte_ring_generic_pvt.h
> + * @file rte_ring_gcc_pvt.h
>   * It is not recommended to include this file directly,
>   * include <rte_ring.h> instead.
>   * Contains internal helper functions for MP/SP and MC/SC ring modes.
> @@ -25,10 +25,8 @@ static __rte_always_inline void
>  __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
>  		uint32_t new_val, uint32_t single, uint32_t enqueue)
>  {
> -	if (enqueue)
> -		rte_smp_wmb();
> -	else
> -		rte_smp_rmb();
> +	RTE_SET_USED(enqueue);
> +
>  	/*
>  	 * If there are other enqueues/dequeues in progress that preceded us,
>  	 * we need to wait for them to complete
> @@ -37,7 +35,12 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>  		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail,
> old_val,
>  			rte_memory_order_relaxed);
>=20
> -	ht->tail =3D new_val;
> +	/*
> +	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1=
.
> +	 * Ensures that memory effects by this thread on ring elements array
> +	 * is observed by a different thread of the other type.
> +	 */
> +	__atomic_store_n(&ht->tail, new_val, __ATOMIC_RELEASE);
>  }
>=20
>  /**
> @@ -73,7 +76,7 @@ __rte_ring_headtail_move_head_mt(struct
> rte_ring_headtail *d,
>  		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
>  {
>  	unsigned int max =3D n;
> -	int success;
> +	bool success;
>=20
>  	do {
>  		/* Reset n to the initial burst count */
> @@ -81,10 +84,10 @@ __rte_ring_headtail_move_head_mt(struct
> rte_ring_headtail *d,
>=20
>  		*old_head =3D d->head;
>=20
> -		/* add rmb barrier to avoid load/load reorder in weak
> +		/* add fence to avoid load/load reorder in weak
>  		 * memory model. It is noop on x86
>  		 */
> -		rte_smp_rmb();
> +		__atomic_thread_fence(__ATOMIC_ACQUIRE);
>=20
>  		/*
>  		 *  The subtraction is done between two unsigned 32bits value
> @@ -103,10 +106,12 @@ __rte_ring_headtail_move_head_mt(struct
> rte_ring_headtail *d,
>  			return 0;
>=20
>  		*new_head =3D *old_head + n;
> -		success =3D rte_atomic32_cmpset(
> +
> +		success =3D __sync_bool_compare_and_swap(
>  				(uint32_t *)(uintptr_t)&d->head,
>  				*old_head, *new_head);
> -	} while (unlikely(success =3D=3D 0));
> +	} while (unlikely(!success));
> +
>  	return n;
>  }
>=20
> @@ -169,4 +174,4 @@ __rte_ring_headtail_move_head_st(struct
> rte_ring_headtail *d,
>  	return n;
>  }
>=20
> -#endif /* _RTE_RING_GENERIC_PVT_H_ */
> +#endif /* _RTE_RING_GCC_PVT_H_ */
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

