Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9248EC54FDF
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 07:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ADCB40274;
	Thu, 30 Jul 2026 09:27:11 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 426EE40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 09:27:10 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zRP9hCYGgAJyedzCVDN0EGCEBg1/nw9kNqrkZXWoCGo=;
 b=Os/rEp+7ixQTKR6WGmSd2YtNS3gT5YcZNoTPE7awwWbNZ/ROpmPNvbI6YWLx9JToO67dp+Nn1
 J5NoT5dAYPMeeHjXAx+YefoBhB0L05I6sArYpaTj4yU7uWb+xnC1mZbqnIB+R0f+WjPOmm0Nuue
 G1TIgR4vEt1qCCZQHGZ73aI=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h9gk25tC3zJ46ZL;
 Thu, 30 Jul 2026 15:26:34 +0800 (CST)
Received: from dubpeml100007.china.huawei.com (unknown [7.214.144.235])
 by mail.maildlp.com (Postfix) with ESMTPS id 8791640572;
 Thu, 30 Jul 2026 15:27:09 +0800 (CST)
Received: from dubpemt100001.china.huawei.com (7.214.147.107) by
 dubpeml100007.china.huawei.com (7.214.144.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Jul 2026 08:27:09 +0100
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpemt100001.china.huawei.com (7.214.147.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 08:27:08 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Jul 2026 08:27:08 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [RFC 17/32] eal/x86: move optimized fence out of SMP barrier
Thread-Topic: [RFC 17/32] eal/x86: move optimized fence out of SMP barrier
Thread-Index: AQHdH4PBtAncOdhDekmKmhZCna7csLaFqmPA
Date: Thu, 30 Jul 2026 07:27:08 +0000
Message-ID: <5d3bf2db70a9434db118aefbf61b1a02@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-18-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-18-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.197.251]
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



> rte_atomic_thread_fence() implemented the seq_cst case by calling the
> deprecated rte_smp_mb(). Invert the dependency: the lock add based
> fence moves into rte_atomic_thread_fence() and rte_smp_mb() becomes a
> wrapper around it, so removing the deprecated barriers later is a pure
> deletion. The optimization itself must stay; a plain seq_cst fence is
> an mfence, about twice the cost. No change in generated code.
>=20
> Drop no longer used rte_smp_mb().
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/x86/include/rte_atomic.h | 37 ++++++++++++++------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>=20
> diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_a=
tomic.h
> index e071e4234e..780fdce871 100644
> --- a/lib/eal/x86/include/rte_atomic.h
> +++ b/lib/eal/x86/include/rte_atomic.h
> @@ -60,23 +60,8 @@ extern "C" {
>   * Basic idea is to use lock prefixed add with some dummy memory locatio=
n
>   * as the destination. From their experiments 128B(2 cache lines) below
>   * current stack pointer looks like a good candidate.
> - * So below we use that technique for rte_smp_mb() implementation.
>   */
>=20
> -static __rte_always_inline void
> -rte_smp_mb(void)
> -{
> -#ifdef RTE_TOOLCHAIN_MSVC
> -	_mm_mfence();
> -#else
> -#ifdef RTE_ARCH_I686
> -	asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
> -#else
> -	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
> -#endif
> -#endif
> -}
> -
>  #define rte_io_mb() rte_mb()
>=20
>  #define rte_io_wmb() rte_compiler_barrier()
> @@ -86,17 +71,27 @@ rte_smp_mb(void)
>  /**
>   * Synchronization fence between threads based on the specified memory o=
rder.
>   *
> - * On x86 the __rte_atomic_thread_fence(rte_memory_order_seq_cst)
> generates full 'mfence'
> - * which is quite expensive. The optimized implementation of rte_smp_mb =
is
> - * used instead.
> + * On x86 the __rte_atomic_thread_fence(rte_memory_order_seq_cst)
> generates
> + * a full 'mfence' which is quite expensive. The optimized lock add on a
> + * dummy stack location (see above) is used instead.
>   */
>  static __rte_always_inline void
>  rte_atomic_thread_fence(rte_memory_order memorder)
>  {
> -	if (memorder =3D=3D rte_memory_order_seq_cst)
> -		rte_smp_mb();
> -	else
> +	if (memorder !=3D rte_memory_order_seq_cst) {
>  		__rte_atomic_thread_fence(memorder);
> +		return;
> +	}
> +
> +#ifdef RTE_TOOLCHAIN_MSVC
> +	_mm_mfence();
> +#else
> +#ifdef RTE_ARCH_I686
> +	asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
> +#else
> +	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
> +#endif
> +#endif
>  }
>=20
>  #ifdef __cplusplus
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

