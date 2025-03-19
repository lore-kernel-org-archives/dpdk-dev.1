Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D56C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3843D4026B;
	Wed, 19 Mar 2025 11:25:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD2E84025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742379901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtcDmto6JZaK2EhaKSmDfuVJYPTiwwc/7tt4saM7Bwk=;
 b=Mrf64KuJ38mIAy6tQcOkdLSErHMm8/MgdRRtGEy/QsbNhaKerBVyNXjlIrQR4C5yLpebhC
 cXJrSQzQGSi0eOMUERgWenhhX8JoDL5V++jB5ml00mjOEm5qH2trpV7uGt8CIE9ZjlwPd7
 0tKTaxBjNe8N4y+91glrrGJyZHRyQ1s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-_kpTEqjGMsKFgHou8nsCSg-1; Wed, 19 Mar 2025 06:24:57 -0400
X-MC-Unique: _kpTEqjGMsKFgHou8nsCSg-1
X-Mimecast-MFC-AGG-ID: _kpTEqjGMsKFgHou8nsCSg_1742379896
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30c4cbc324bso29769001fa.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742379896; x=1742984696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtcDmto6JZaK2EhaKSmDfuVJYPTiwwc/7tt4saM7Bwk=;
 b=tNz37Do9dlJ8B+LaEShAxMqYRFCaHIS06MGsQaz6CJbArqk+F1Rz4mpRW5ajDghKm/
 WNNX4NcWgNTHiKvBQgmZbFcufonfSYPra7B57zjXQg/3yz04JhGXSBk0FzddY7dt7kKd
 FvjXVcMR01l/T440NqZpsTXf1clkwb13eZ1XeQbgpqXMtt1kuPDOamzTYxB5beksqVIG
 /eo8ksDyOG5MpqSvvEkan4BDzoHc8QLCTVU1qFw9NU6i2AJfQDO8Nx0VXHD/3q2cSbU1
 mz/if1nULAOO6WUIVWKxK8zjtgvnnLz68G61DRMoMYRauq0IAO3HhaexFnwEF5wB2+jf
 Av1A==
X-Gm-Message-State: AOJu0YwyjXZLwYb8TZBl3cwD3D1pw7fHaW2sB/QOwcRV4xpWoyvbagmA
 +wJ415bsYhxr5mFhvxVX8qJ8ZFRVMUnrIUTqksQ473wHVGs5w620dFPc4M8xxJJ9Rya6ai+V31w
 +H82pPH9ap8Uj2SgwSVskz8Hiog9SLw/Sw5ivj+1LJjK4366ScCMV3qN3TcR2oD7pZ6YqdpN+mq
 qKFBbIB3ArpN6/POQ=
X-Gm-Gg: ASbGncv0F6PVHxRt080DO19H8g3/pz33jb4xinXPnWBJ7ckvIzJRArm5tXaxyMjtpYs
 7Di7qynLnfcoC+NlvMqcJd5txUwndwlCvNHCl8n3I11fzVlhDsNxutlgngrZT1PQVCT6kGohT6W
 c=
X-Received: by 2002:a05:6512:ad1:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-54acb1fdd02mr728919e87.41.1742379895924; 
 Wed, 19 Mar 2025 03:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6hXFtxywC7DWdbbzQJTsifi50Yvw1fIt1sWvVVq/hljNNftWebZlRnwr5bB7qMt+dGXkzfNNHuI3ESvImHs=
X-Received: by 2002:a05:6512:ad1:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-54acb1fdd02mr728916e87.41.1742379895361; Wed, 19 Mar 2025
 03:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-10-bruce.richardson@intel.com>
In-Reply-To: <20250318173505.314529-10-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 11:24:43 +0100
X-Gm-Features: AQ5f1JoOwaIO3I6IFQFCp7HIbsWAeUnrvMz8hZsnwX7BxhCh7rIn1f-2vGK8iC8
Message-ID: <CAJFAV8wi2HU3Z5-1HzoN0UsMCaoPMh9BdUPm1oAbhQgi__HmNw@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] net: simplify build-time logic for x86
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Jasvinder Singh <jasvinder.singh@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yvTivh_U0Ph4KM5NuvrIFxW9J9U_OcK89NK9ETpaZtg_1742379896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 18, 2025 at 6:36=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> All DPDK-supported versions of clang and gcc have the "-mpclmul" and
> "-maes" flags, so we never need to check for those. This allows the SSE
> code path to be unconditionally built on x86.
>
> For the AVX512 code path, simplify it by only checking for the
> build-time support, and always doing a separate build with AVX512
> support when that compiler support is present.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/net/meson.build   | 53 +++++--------------------------------------
>  lib/net/rte_net_crc.c |  8 +++----
>  2 files changed, 10 insertions(+), 51 deletions(-)
>
> diff --git a/lib/net/meson.build b/lib/net/meson.build
> index c9b34afc98..4bbbad3f42 100644
> --- a/lib/net/meson.build
> +++ b/lib/net/meson.build
> @@ -42,57 +42,16 @@ deps +=3D ['mbuf']
>  use_function_versioning =3D true
>
>  if dpdk_conf.has('RTE_ARCH_X86_64')
> -    net_crc_sse42_cpu_support =3D (cc.get_define('__PCLMUL__', args: mac=
hine_args) !=3D '')
> -    net_crc_avx512_cpu_support =3D (
> -            target_has_avx512 and
> -            cc.get_define('__VPCLMULQDQ__', args: machine_args) !=3D ''
> -    )
> -
> -    net_crc_sse42_cc_support =3D (cc.has_argument('-mpclmul') and cc.has=
_argument('-maes'))
> -    net_crc_avx512_cc_support =3D (cc.has_argument('-mvpclmulqdq') and c=
c_has_avx512)
> -
> -    build_static_net_crc_sse42_lib =3D 0
> -    build_static_net_crc_avx512_lib =3D 0
> -
> -    if net_crc_sse42_cpu_support =3D=3D true
> -        sources +=3D files('net_crc_sse.c')
> -        cflags +=3D ['-DCC_X86_64_SSE42_PCLMULQDQ_SUPPORT']
> -        if net_crc_avx512_cpu_support =3D=3D true
> -            sources +=3D files('net_crc_avx512.c')
> -            cflags +=3D ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
> -        elif net_crc_avx512_cc_support =3D=3D true
> -            build_static_net_crc_avx512_lib =3D 1
> -            net_crc_avx512_lib_cflags =3D cc_avx512_flags + ['-mvpclmulq=
dq']
> -            cflags +=3D ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
> -        endif
> -    elif net_crc_sse42_cc_support =3D=3D true
> -        build_static_net_crc_sse42_lib =3D 1
> -        net_crc_sse42_lib_cflags =3D ['-mpclmul', '-maes']
> -        cflags +=3D ['-DCC_X86_64_SSE42_PCLMULQDQ_SUPPORT']
> -        if net_crc_avx512_cc_support =3D=3D true
> -            build_static_net_crc_avx512_lib =3D 1
> -            net_crc_avx512_lib_cflags =3D cc_avx512_flags + ['-mvpclmulq=
dq', '-mpclmul']
> -            cflags +=3D ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
> -        endif
> -    endif
> -
> -    if build_static_net_crc_sse42_lib =3D=3D 1
> -        net_crc_sse42_lib =3D static_library(
> -                'net_crc_sse42_lib',
> -                'net_crc_sse.c',
> -                dependencies: static_rte_eal,
> -                c_args: [cflags,
> -                    net_crc_sse42_lib_cflags])
> -        objs +=3D net_crc_sse42_lib.extract_objects('net_crc_sse.c')
> -    endif
> -
> -    if build_static_net_crc_avx512_lib =3D=3D 1
> +    sources +=3D files('net_crc_sse.c')
> +    cflags +=3D ['-mpclmul', '-maes']
> +    if cc.has_argument('-mvpclmulqdq') and cc_has_avx512
> +        net_crc_avx512_lib_cflags =3D cc_avx512_flags + ['-mvpclmulqdq']

Nit: we don't need this intermediate variable. But well, it gets
removed in next patch.

> +        cflags +=3D ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
>          net_crc_avx512_lib =3D static_library(
>                  'net_crc_avx512_lib',
>                  'net_crc_avx512.c',
>                  dependencies: static_rte_eal,
> -                c_args: [cflags,
> -                    net_crc_avx512_lib_cflags])
> +                c_args: [cflags, net_crc_avx512_lib_cflags])
>          objs +=3D net_crc_avx512_lib.extract_objects('net_crc_avx512.c')
>      endif
>
> diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
> index 2fb3eec231..c9773d6300 100644
> --- a/lib/net/rte_net_crc.c
> +++ b/lib/net/rte_net_crc.c
> @@ -66,7 +66,7 @@ static const rte_net_crc_handler handlers_avx512[] =3D =
{
>         [RTE_NET_CRC32_ETH] =3D rte_crc32_eth_avx512_handler,
>  };
>  #endif
> -#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
> +#ifdef RTE_ARCH_X86_64
>  static const rte_net_crc_handler handlers_sse42[] =3D {
>         [RTE_NET_CRC16_CCITT] =3D rte_crc16_ccitt_sse42_handler,
>         [RTE_NET_CRC32_ETH] =3D rte_crc32_eth_sse42_handler,
> @@ -211,7 +211,7 @@ avx512_vpclmulqdq_init(void)
>  static const rte_net_crc_handler *
>  sse42_pclmulqdq_get_handlers(void)
>  {
> -#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
> +#ifdef RTE_ARCH_X86_64
>         if (SSE42_PCLMULQDQ_CPU_SUPPORTED &&
>                         max_simd_bitwidth >=3D RTE_VECT_SIMD_128)
>                 return handlers_sse42;
> @@ -223,7 +223,7 @@ sse42_pclmulqdq_get_handlers(void)
>  static void
>  sse42_pclmulqdq_init(void)
>  {
> -#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
> +#ifdef RTE_ARCH_x86_64
>         if (SSE42_PCLMULQDQ_CPU_SUPPORTED)
>                 rte_net_crc_sse42_init();
>  #endif
> @@ -316,7 +316,7 @@ handlers_init(enum rte_net_crc_alg alg)
>  #endif
>                 /* fall-through */
>         case RTE_NET_CRC_SSE42:
> -#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
> +#ifdef RTE_ARCH_X86_64
>                 if (SSE42_PCLMULQDQ_CPU_SUPPORTED) {
>                         handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =3D
>                                 rte_crc16_ccitt_sse42_handler;
> --
> 2.43.0
>

--=20
David Marchand

