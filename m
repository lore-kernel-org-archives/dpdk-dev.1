Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC7C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 12:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C2E44014F;
	Fri, 18 Jul 2025 14:22:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 464D44013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 14:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752841320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2oOhcH9n13zUirQcmHdAYcaIyKP/eci8vkK3hno6brg=;
 b=cbdOz21elpXADUeoAYlmJ+4/Z75JHmATbN7yvotW/GxyceXdoVv0SR5nSP0lMCip3+yUJp
 jcUWuPB6JQmXAet6PjTFiZzZk+6JpfBJXZe7Q+juJAYEcloFdYDLkAGUiX6lWTKhskvzxE
 wiJAxSStQORdKb7ax3w+NNj6JJ+3qBs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-1bzKGOa5NVKYlhtVv2CXSg-1; Fri, 18 Jul 2025 08:21:59 -0400
X-MC-Unique: 1bzKGOa5NVKYlhtVv2CXSg-1
X-Mimecast-MFC-AGG-ID: 1bzKGOa5NVKYlhtVv2CXSg_1752841318
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b4a06b780so10465041fa.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 05:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752841318; x=1753446118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oOhcH9n13zUirQcmHdAYcaIyKP/eci8vkK3hno6brg=;
 b=ZsTRGvvadd/u7ce9qS8A4KAlzk44xBRhCNfyr7VGn9NB8S8osEGVTNYlgP74yrs4PF
 YAuST42VNdn6mVSa98MzSbPKHVe8u3piPRFe3IAgbG8CgzyFAIgmqqLkm+3/nhIvbYKb
 DnOOMLEn4NPmnhlC3kI0UtODS0AQFMYigODa5OMAyGPsHunz5QvkVcDUDhDTS2UqAGyf
 j+YW4+KHIjUumUbTasbd9pE9cTA0TFaM4utDKMjBACqirOFRA0iA4cR0IT/PnR73/MtD
 uyoRga2TZIrbs8HH63INxxJ7K7N6MeFX6sBFlR67yFXuAEIwVWsVIEHH6B+LVeL7zpgV
 UbIQ==
X-Gm-Message-State: AOJu0YwJyV1q36KuaMqts5pSd+KK72/1ECM9KId24pFihW4CRIyp9N24
 9c/AhW9EWv6+VWJ4CC0j9GCPbspDmdGgv7+ImdLF5uLbjvAcdcJQ2+qBo2Nj8SF1J4C5CeMujz6
 ERGUpd1wep+uP5CkCRQNjKz0fs2ZERnwehdnxuGMxE4Lel9Fy+RZhAu2iG3SDwG2bJTP9CkmkzD
 RJmXfggEoV7EKd3RXC2t4BiIyzT3kTGQ==
X-Gm-Gg: ASbGncu1K3cQDLaVcAt41g3pPxjuGc7qRzc5a0ssWYShIf5EIbsu9MOeAH39Xz91uEG
 AGPdVoZZWvQmRpMtvfM6dDRez4qqk4kUFFQryIValQZw0cKcBhpZCo7gtUKKO/0YJFwe0+zdQEY
 vtHV2QhmmQ4jemZejkYd9RcPw=
X-Received: by 2002:a2e:a98a:0:b0:32c:a097:41bb with SMTP id
 38308e7fff4ca-3308e1c61c0mr29204201fa.5.1752841317772; 
 Fri, 18 Jul 2025 05:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/1IZYCFjP4pEN5eYn/K0+Ktym5Ylgp8W+2Y9NHNIHKonoFP1HdHTMCgZ+clu2kjrOEmI7uvo5jyxeltShnM=
X-Received: by 2002:a2e:a98a:0:b0:32c:a097:41bb with SMTP id
 38308e7fff4ca-3308e1c61c0mr29204131fa.5.1752841317159; Fri, 18 Jul 2025
 05:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250718121402.856265-1-bruce.richardson@intel.com>
In-Reply-To: <20250718121402.856265-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 18 Jul 2025 14:21:45 +0200
X-Gm-Features: Ac12FXwFGdN8NRFDQhg5advxs4Y7f-sMTBsS2kDMepjdX87KtjvmHdjFCTLrbXQ
Message-ID: <CAJFAV8yu1Gf_fQOibjZMd8oh9CYeCEQNSqpSfcfYXNYRhixvFQ@mail.gmail.com>
Subject: Re: [PATCH] build: remove obsolete compiler checks
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L1jjrB1I-FezJ9WMM80ashdOeiehW3r03mD3Zir600M_1752841318
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

On Fri, Jul 18, 2025 at 2:14=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> DPDK now recommends compiler versions GCC 8+, and Clang 7+, so remove
> checks and workarounds for versions old than these.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  config/meson.build                  |  5 ----
>  drivers/event/meson.build           |  5 +---
>  drivers/meson.build                 |  2 +-
>  drivers/net/virtio/meson.build      |  2 +-
>  lib/eal/arm/include/rte_memcpy_64.h |  8 -------
>  lib/eal/arm/include/rte_vect.h      | 37 ++---------------------------
>  lib/eal/ppc/include/rte_altivec.h   |  1 -
>  lib/meson.build                     |  2 +-
>  lib/vhost/meson.build               |  4 ++--
>  lib/vhost/vhost.c                   | 16 -------------
>  10 files changed, 8 insertions(+), 74 deletions(-)

Two nits:

[snip]

> diff --git a/drivers/event/meson.build b/drivers/event/meson.build
> index d6706b57f7..b0bc3f40f1 100644
> --- a/drivers/event/meson.build
> +++ b/drivers/event/meson.build
> @@ -14,9 +14,6 @@ drivers =3D [
>          'opdl',
>          'skeleton',
>          'sw',
> +        'octeontx',
>  ]

Sort alphabetically?


> -if not (toolchain =3D=3D 'gcc' and cc.version().version_compare('<4.8.6'=
) and
> -        dpdk_conf.has('RTE_ARCH_ARM64'))
> -    drivers +=3D 'octeontx'
> -endif
>  std_deps =3D ['eventdev', 'kvargs']

[snip]

> diff --git a/lib/eal/arm/include/rte_memcpy_64.h b/lib/eal/arm/include/rt=
e_memcpy_64.h
> index 90039039be..57fe24eb10 100644
> --- a/lib/eal/arm/include/rte_memcpy_64.h
> +++ b/lib/eal/arm/include/rte_memcpy_64.h
> @@ -89,14 +89,6 @@ n <=3D (size_t)RTE_ARM64_MEMCPY_UNALIGNED_THRESHOLD)
>   **************************************/
>
>
> -#if RTE_CC_IS_GNU && !defined RTE_ARM64_MEMCPY_SKIP_GCC_VER_CHECK
> -#if (GCC_VERSION < 50400)
> -#warning "The GCC version is quite old, which may result in sub-optimal =
\
> -performance of the compiled code. It is suggested that at least GCC 5.4.=
0 \
> -be used."
> -#endif
> -#endif
> -

This flag can be removed from meson too.
config/arm/meson.build:        #
['RTE_ARM64_MEMCPY_SKIP_GCC_VER_CHECK', false],


>  static __rte_always_inline
>  void rte_mov16(uint8_t *dst, const uint8_t *src)
>  {


--=20
David Marchand

