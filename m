Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE9CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FE25402D3;
	Thu,  4 Jun 2026 17:11:29 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8D06C402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:11:27 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWSgD5CmzzHnGhl;
 Thu,  4 Jun 2026 23:10:32 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 70CD640570;
 Thu,  4 Jun 2026 23:11:26 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 16:11:26 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 4 Jun 2026 16:11:26 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH 2/5] ring: use GCC builtin as alternative to rte_atomic32
Thread-Topic: [PATCH 2/5] ring: use GCC builtin as alternative to rte_atomic32
Thread-Index: AQHc8rN+Xems5YrDdEu55QdJffq1xrYue25w
Date: Thu, 4 Jun 2026 15:11:25 +0000
Message-ID: <d65ce1df239445e0bb795c852e075b1a@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260602171552.686349-3-stephen@networkplumber.org>
In-Reply-To: <20260602171552.686349-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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
>  lib/ring/rte_ring_c11_pvt.h                   |  3 +-
>  lib/ring/rte_ring_elem_pvt.h                  |  2 +-
>  ..._ring_generic_pvt.h =3D> rte_ring_gcc_pvt.h} | 37 +++++++++++--------
>  4 files changed, 24 insertions(+), 20 deletions(-)
>  rename lib/ring/{rte_ring_generic_pvt.h =3D> rte_ring_gcc_pvt.h} (87%)
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
> diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
> index 5afc14dec9..8358b0f21f 100644
> --- a/lib/ring/rte_ring_c11_pvt.h
> +++ b/lib/ring/rte_ring_c11_pvt.h
> @@ -43,7 +43,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>  	 */
>  	rte_atomic_store_explicit(&ht->tail, new_val,
> rte_memory_order_release);
>  }
> -
>  /**
>   * @internal This is a helper function that moves the producer/consumer =
head
>   *    optimized for single threaded case
> @@ -82,7 +81,7 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headta=
il
> *d,
>  	/* Single producer: only this thread writes d->head,
>  	 * so a relaxed load is sufficient.
>  	 */
> -	*old_head =3D rte_atomic_load_explicit(&d->head,
> rte_memory_order_relaxed);
> +	*old_head =3D rte_atomic_load_explicit(&d->head,
> 	rte_memory_order_acquire);

Not sure, why it had changed to 'acquire' here?
Looks like just patch splitting mistake, no?

>=20
>  	/* Acquire pairs with the consumer's release-store of tail in
> __rte_ring_update_tail,
>  	 * ensuring the consumer's ring-element reads are complete before
