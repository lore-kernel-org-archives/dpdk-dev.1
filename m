Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B5C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 511584026B;
	Wed, 19 Mar 2025 11:11:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 458464025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742379093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjLVB2HXD0bBauDpzu84Q84sohN/tcrtYH2C9kxOBqo=;
 b=BlDaV6tMlgBp1Yf8k9f92uvuSlIp3fEv68PTc2uh28LgyWtAq/E3ai7rSq1hYFuzqXqAO/
 tCSSi13NxoLUdS8FVIX576qeSsSK7bvkxhXtqdDYVblzDSfy9RbL4WtmZ4otnWYNUcuI4J
 Ds41lbgWP1z+2btqujt+8jYECGCQHpQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-lIrxU28qNempo2YAEYWbaA-1; Wed, 19 Mar 2025 06:11:30 -0400
X-MC-Unique: lIrxU28qNempo2YAEYWbaA-1
X-Mimecast-MFC-AGG-ID: lIrxU28qNempo2YAEYWbaA_1742379089
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30c4cbc324bso29690081fa.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742379089; x=1742983889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjLVB2HXD0bBauDpzu84Q84sohN/tcrtYH2C9kxOBqo=;
 b=f6LhFfVplGdOtMTTS72Sg+I6abTwhyGVqB955leLf1CRNmG69xvGFGZHLSaRfSlYyu
 wNdafBpa1gXaNbzL6h/nRcFeIaeFqtV18rKEx1eHqjVylC6dMsRtNfORV1zKBkXWfwdv
 tujI/jGDORxlT5Vagfxtdrz/j9SdYF+PlEyHqLXubIAoUsKdJmyXKWDTu/iGLx43VUV9
 JjQ4R9yfk4bhFjkza01HDKERw/xLPhvucBLv6pZL5Ht8x20cmm2/3FN9MwDkQZa2ueht
 AbY8TfHSxgbI4993bzO/2T5kfEVAIN3K9cZtr00V9Xl9hRurtSYwk88rsE7y+wVYalIc
 /sTQ==
X-Gm-Message-State: AOJu0YxQSAKCQevdVo+0PU4o15V6MlIipQeIh/MAlaCqsvMWz60O4WV/
 YPgS1mvIIzyg/SM3ff04CVmytmNkrxAthGz1JK6FPshTQlTqxPUQC36q3ZHwPRMo61uAtkPGZIO
 BrkFJ7Kx8iMrokQctXb7zULb3UmMpjaUjgBx2/4Rm7LAkteb1w9a6+RbhMBLQE8nNvA4RDy3QPT
 PJY1PdYWAr5GtQv8Q=
X-Gm-Gg: ASbGncv0VohDhUrb6EunBI0LSCnrbsEkC2DOzAsR39xphw8KywhjiHcw6gafZ9uzxM3
 N1LSHbxiv3BBL6F/lsnu1xXP7hV3din0AV8L3iliteipfQ5WhePA5YhYibLNqJT5lDN2VSBkCo+
 k=
X-Received: by 2002:a05:6512:1107:b0:545:2a96:34f7 with SMTP id
 2adb3069b0e04-54acb1d2337mr775316e87.31.1742379088933; 
 Wed, 19 Mar 2025 03:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkFqxhiF2z9YGUU9Af66TW4nohRJN+/2C/9r3aC9M9r2XdrzAZRBPip2771z3UVvM0o8mPmepy16MY1KU0R1g=
X-Received: by 2002:a05:6512:1107:b0:545:2a96:34f7 with SMTP id
 2adb3069b0e04-54acb1d2337mr775306e87.31.1742379088561; Wed, 19 Mar 2025
 03:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-3-bruce.richardson@intel.com>
In-Reply-To: <20250318173505.314529-3-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 11:11:17 +0100
X-Gm-Features: AQ5f1JoT5Mz5R4wXDsQnk4SmJC-S-pY9ivYdaqy5lYqLX34FYOVqyhAyENnum-4
Message-ID: <CAJFAV8wH9jQNVYpFcvMXQSnChW=6zD2oCxjhFS=ByQUw1-Z6+g@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] net/intel: use common AVX build code
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Ian Stokes <ian.stokes@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pr9Kv0WNdiLIOW3i-7kXlWIWpgy8QHHroFWWmikr2ks_1742379089
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

On Tue, Mar 18, 2025 at 6:35=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Remove driver-specific build instructions for the AVX2 and AVX-512 code,
> and rely instead on the generic driver build file.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

There is a small merge conflict, so a rebase will be needed.

Some nits.

> ---
>  drivers/net/intel/i40e/meson.build | 26 ++------------------------
>  drivers/net/intel/iavf/meson.build | 25 ++-----------------------
>  drivers/net/intel/ice/meson.build  | 25 ++-----------------------
>  drivers/net/intel/idpf/meson.build | 25 ++-----------------------
>  4 files changed, 8 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/=
meson.build
> index 2973ed1a01..25a3d72714 100644
> --- a/drivers/net/intel/i40e/meson.build
> +++ b/drivers/net/intel/i40e/meson.build
> @@ -40,35 +40,13 @@ includes +=3D include_directories('base')
>
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('i40e_rxtx_vec_sse.c')
> +    sources_avx2 =3D files('i40e_rxtx_vec_avx2.c')
> +    sources_avx512 =3D files('i40e_rxtx_vec_avx512.c')

I prefer +=3D (which is also used later in this series).

>
>      if is_windows and cc.get_id() !=3D 'clang'
>          cflags +=3D ['-fno-asynchronous-unwind-tables']
>      endif
>
> -    i40e_avx2_lib =3D static_library('i40e_avx2_lib',
> -            'i40e_rxtx_vec_avx2.c',
> -            dependencies: [static_rte_ethdev, static_rte_kvargs, static_=
rte_hash],
> -            include_directories: includes,
> -            c_args: [cflags, cc_avx2_flags])
> -    objs +=3D i40e_avx2_lib.extract_objects('i40e_rxtx_vec_avx2.c')
> -
> -    if cc_has_avx512
> -        cflags +=3D ['-DCC_AVX512_SUPPORT']
> -        avx512_args =3D cflags + cc_avx512_flags
> -        if cc.has_argument('-march=3Dskylake-avx512')
> -            avx512_args +=3D '-march=3Dskylake-avx512'
> -            if cc.has_argument('-Wno-overriding-option')
> -                avx512_args +=3D '-Wno-overriding-option'
> -            endif
> -        endif
> -        i40e_avx512_lib =3D static_library('i40e_avx512_lib',
> -                'i40e_rxtx_vec_avx512.c',
> -                dependencies: [static_rte_ethdev,
> -                    static_rte_kvargs, static_rte_hash],
> -                include_directories: includes,
> -                c_args: avx512_args)
> -        objs +=3D i40e_avx512_lib.extract_objects('i40e_rxtx_vec_avx512.=
c')
> -    endif
>  elif arch_subdir =3D=3D 'ppc'

Below seems not indented the same as above.

>         sources +=3D files('i40e_rxtx_vec_altivec.c')
>  elif arch_subdir =3D=3D 'arm'


--=20
David Marchand

