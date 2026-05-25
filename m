Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F71CD5BBF
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 07:41:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63F0C402AA;
	Mon, 25 May 2026 09:41:17 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CBF094028A
 for <dev@dpdk.org>; Mon, 25 May 2026 09:41:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gP78m4xcrzHnGjD;
 Mon, 25 May 2026 15:40:40 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id E4D7D40571;
 Mon, 25 May 2026 15:41:13 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 25 May 2026 08:41:13 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 25 May 2026 08:41:13 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Thread-Topic: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Thread-Index: AQHc6u5NLAbvwJxeAEabFVHsQsogoLYeXAgQ
Date: Mon, 25 May 2026 07:41:13 +0000
Message-ID: <b827bdd2f5994f24b9806e5cbae82cd3@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
 <20260523195604.441947-4-stephen@networkplumber.org>
In-Reply-To: <20260523195604.441947-4-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.51]
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


Hi Stephen,

> The rte_atomic32_cmpset is deprecated. Initial attempts at
> changing this with direct conversion to
> rte_atomic_compare_exchange_weak_explicit()
> regressed MP/MC contended performance on x86 by 10-30%,
> because the C11 builtin's failure-writeback semantic forces
> GCC to emit extra instructions on the CAS critical path.
>=20
> Add an internal __rte_ring_compare_and_swap() wrapper that calls
> __sync_bool_compare_and_swap() directly, which keeps the original
> instruction sequence. Add equivalent function for MSVC.

In fact, in rte_ring we do have 2 implementations of the same core function=
s:
lib/ring/rte_ring_c11_pvt.h  - uses C11 atomics
lib/ring/rte_ring_generic_pvt.h - uses legacy instructions (smp_mb, extra),=
=20
If we going remove these legacy instructions anyway (or reimplementing them=
 using C11 atomics),
then there is probably no point to keep rte_ring_generic_pvt.h.
Konstantin

>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/rte_ring_generic_pvt.h | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_=
pvt.h
> index affd2d5ba7..0fb972de9e 100644
> --- a/lib/ring/rte_ring_generic_pvt.h
> +++ b/lib/ring/rte_ring_generic_pvt.h
> @@ -18,6 +18,30 @@
>   * For more information please refer to <rte_ring.h>.
>   */
>=20
> +/**
> + * @internal optimized version of compare exchange
> + *
> + * The C11 builtin's failure-writeback semantic generates worse code on =
x86.
> + * Unlike rte_atomic_compare_exchange_*_explicit(), this wrapper does NO=
T
> + * write the actual value back to a pointer on failure. Callers in a ret=
ry
> + * loop must reload the expected value explicitly on the next iteration.
> + *
> + * Full memory barrier, equivalent to rte_memory_order_seq_cst on both
> + * success and failure.
> + */
> +static __rte_always_inline bool
> +__rte_ring_compare_and_swap(volatile uint32_t *dst,
> +			    uint32_t expected, uint32_t desired)
> +{
> +#if defined(RTE_TOOLCHAIN_MSVC)
> +	return _InterlockedCompareExchange((volatile long *)dst,
> +					   (long)desired, (long)expected)
> +		=3D=3D (long)expected;
> +#else
> +	return __sync_bool_compare_and_swap(dst, expected, desired);
> +#endif
> +}
> +
>  /**
>   * @internal This function updates tail values.
>   */
> @@ -108,10 +132,10 @@ __rte_ring_headtail_move_head(struct
> rte_ring_headtail *d,
>  		if (is_st) {
>  			d->head =3D *new_head;
>  			success =3D 1;
> -		} else
> -			success =3D rte_atomic32_cmpset(
> -					(uint32_t *)(uintptr_t)&d->head,
> -					*old_head, *new_head);
> +		} else {
> +			success =3D __rte_ring_compare_and_swap(
> +					&d->head, *old_head, *new_head);
> +		}
>  	} while (unlikely(success =3D=3D 0));
>  	return n;
>  }
> --
> 2.53.0

