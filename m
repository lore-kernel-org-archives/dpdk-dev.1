Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44906C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A8214026B;
	Wed, 19 Mar 2025 11:16:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9A1F04025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:16:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742379384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4jQd+FE1M8JSqO37RJx+P+yZ4NkYeOO3ZX0ucZoRno=;
 b=QqZaJE51vEiFI/HQpst0lA9taGg60iavQug3uWV05aEV53UDELG38pqUdXnsaxDfSam1Ie
 CnL6aOn0KH8sRLYYKMW0Jb8IANbmt5xUhmLI5uV6lQAPYswFPDUWxFPLv6yB9CC8z4XShP
 CTyCspyCmkikXYgUxsPPrCSOanvyR74=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-s4ivorBqPai_XlEGy1-aXQ-1; Wed, 19 Mar 2025 06:16:22 -0400
X-MC-Unique: s4ivorBqPai_XlEGy1-aXQ-1
X-Mimecast-MFC-AGG-ID: s4ivorBqPai_XlEGy1-aXQ_1742379381
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54996792145so3111736e87.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742379381; x=1742984181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4jQd+FE1M8JSqO37RJx+P+yZ4NkYeOO3ZX0ucZoRno=;
 b=qwtcjXai+so1n0l4Gqg1W0d/WWXiwa41izjKebze8LQD5ysvg3aDQ5Sf6nlNlRgOOe
 nVm9UdGh5nhrleOsP9qek5rRJ3XGcEllQYqRGhyj6oQ4TNXkSTOLk6GH37g0i/vP+3gc
 PCLZ/XqYk8MF0LQMNwGpptNjvvB6+u/LD7RzbNO0PfyeR12GjHkey2PHQJgddd2xtu9G
 pwjDyrllR8wIRXQkSUCb5JWpbvjiJiqDqmBSsxlEsGjbtcA3pCSz5MbNXKW7O3AKlff3
 MUsVIrYdT+Z0VrU0mNwQo/Min8OYSE08ehXlhekAdapyEnK7S1zDO7hiKVS9uXkMX9/D
 qFZQ==
X-Gm-Message-State: AOJu0YwWB/utO2HOtIWGgZKOyDvgpgfqe3KIE90LQ5KgtBOxq6Mn6Ner
 TFSiFgLlwWkMHBcUoR579bVFxljrkp2l4knsur1PP073zkl90WvCCOirw+iFCl4TUpGp92tSx6K
 kw/IXQP0i6wHELJWaMwCqJyASpHV1IiIQ/r0mPoj9eXs/JsQ405amFVSHzY5v3ybWx4PGuhs0II
 UlgAJ5C2/6RCI9eB8=
X-Gm-Gg: ASbGncvCEYSh0CjwFX3OlJ5tbUt272RLfRVTjRD+oGICJMV+LSJr2Ry9vKVZa2byEmS
 uW+0tCADkhGSrksCamolR879xmM7UYjqYF1oJk0bg7FvWKhhHRZ6zZRjzVmpU/GZCxN+coILEyt
 0=
X-Received: by 2002:a05:6512:2342:b0:540:1f7d:8bce with SMTP id
 2adb3069b0e04-54acb1fbdbfmr556693e87.38.1742379381027; 
 Wed, 19 Mar 2025 03:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEf+DcokjzjX9Qeq/toIrNbwLNv1G7aDpoZz5JkqTbKbSGhlPSuarpd4mTzmBkoXA2IEb5dDL/lgyGj7Fn2pA=
X-Received: by 2002:a05:6512:2342:b0:540:1f7d:8bce with SMTP id
 2adb3069b0e04-54acb1fbdbfmr556686e87.38.1742379380649; Wed, 19 Mar 2025
 03:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-8-bruce.richardson@intel.com>
In-Reply-To: <20250318173505.314529-8-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 11:16:09 +0100
X-Gm-Features: AQ5f1JrDpwJarGqkVR3HNwQY5BhAf1Y0nvYAuJv9bRUt2Oa3Tllo6Iayr5XycFo
Message-ID: <CAJFAV8wPvQKHNFgPvYa1k-L6Q46WcsRCq8O64Mxb9_AX34CgUA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] acl: use common AVX build handling
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: unOKr4fuDfz_WjpTm9aPA72zM9gBuh7wIBS2KRChcWs_1742379381
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
> remove custom logic for building AVX2 and AVX-512 files.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/acl/meson.build | 54 ++++-----------------------------------------
>  1 file changed, 4 insertions(+), 50 deletions(-)
>
> diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> index a80c172812..87e9f25f8e 100644
> --- a/lib/acl/meson.build
> +++ b/lib/acl/meson.build
> @@ -15,57 +15,11 @@ headers =3D files('rte_acl.h', 'rte_acl_osdep.h')
>
>  if dpdk_conf.has('RTE_ARCH_X86')
>      sources +=3D files('acl_run_sse.c')
> -
> -    avx2_tmplib =3D static_library('avx2_tmp',
> -            'acl_run_avx2.c',
> -            dependencies: static_rte_eal,
> -            c_args: [cflags, cc_avx2_flags])
> -    objs +=3D avx2_tmplib.extract_objects('acl_run_avx2.c')
> -
> -    # compile AVX512 version if:
> -    # we are building 64-bit binary AND binutils can generate proper cod=
e
> -
> -    if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
> -
> -        # compile AVX512 version if either:
> -        # a. we have AVX512 supported in minimum instruction set
> -        #    baseline
> -        # b. it's not minimum instruction set, but supported by
> -        #    compiler
> -        #
> -        # in former case, just add avx512 C file to files list
> -        # in latter case, compile c file to static lib, using correct
> -        # compiler flags, and then have the .o file from static lib
> -        # linked into main lib.
> -
> -        # check if all required flags already enabled (variant a).
> -        acl_avx512_flags =3D ['__AVX512F__', '__AVX512VL__',
> -            '__AVX512CD__', '__AVX512BW__']

Not sure it is an issue.. CD is not part of common cc_avx512_flags.


--=20
David Marchand

