Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3EAC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B2594029E;
	Wed, 12 Mar 2025 16:59:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 22DE44029E
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741795144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxWI6o2y8WOCxz21Jfj4PHFUFaEJAT2xmfOsc8Qh3yM=;
 b=Pgg68ifveYkDlINCkztakLv4iBWuzc22hhFEvb4r+6KV1xtizkjWIP76t4/5Kzh3Qj4hhT
 qGjeMuGsbPXms00cljBKQarM1+orkUBFpNHP6GjcT+NpWElmuC0Lwq63BWfrOiMY8z+S0P
 uEDkKxRqIvNPwPXVAlY2aNTCwSbxBhA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-QB9B4JRCPquSpS6fA1BkBg-1; Wed, 12 Mar 2025 11:59:03 -0400
X-MC-Unique: QB9B4JRCPquSpS6fA1BkBg-1
X-Mimecast-MFC-AGG-ID: QB9B4JRCPquSpS6fA1BkBg_1741795142
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30c0c56a73aso49501fa.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 08:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741795141; x=1742399941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxWI6o2y8WOCxz21Jfj4PHFUFaEJAT2xmfOsc8Qh3yM=;
 b=PdrNHTF31tJnLe1KieklpZ1INjZXekeJbf0LGdQ4i2667VfnOLlbxXSvN3MhC21/Mh
 nH4bgP5swbmx00e5ai0gbs5Dttq1GIgtegdgBWoW0h1Xx7ZcDdYgB8SnePME2n5wiLw6
 pHkKYFjfKv6v4CYtX8TzxmOBszukLOE2FiZGTViQQWWc8zQHh8nj6LPFEMymoiISzu/I
 FohTlnIooNmg5R6cPfBjBHN0DBjI45Er70Elm8XZf1Mn5M9nimLdjl/xoyq8MndF8PRo
 E77ncPImIqrY8AC1542mHHN/xvyRZ5D35R57qQnDNm18fffN4daaPfOgkNY++WY0RsNo
 17Zg==
X-Gm-Message-State: AOJu0YwwPbf5f5Ku7wroN6E5RMNcVhRwOh6pQY0FaiZan1uwcJ/AFa48
 uOqXE6aRLn9xxiZphI9rARaRFpDg0LD5nqRfsVMElAimWcMROANlNPHm8QaAVVjg/B8daXlDYq/
 0fWG3IIYQZLI6rPOQzmDaJJLyW7ggOPQ8rUSA772xnhZmDUxDjU0XJXb56m9uTIGW2lA4mAAHfj
 UxQ2VksLSC7zJroLo=
X-Gm-Gg: ASbGncuyerXpJXVLYrhsnp5E0LMy+HCjGWGGdhVKtjUb2WM981CDLjczwpp9Vuvov1e
 Ms/KOu/LyutIpn+OiNgg/TCR9KZkIDo82IeEF1BfzAx0wskP/EllwiXsd7a9HNF7IjDBLIY4Uhc
 k=
X-Received: by 2002:a2e:bc27:0:b0:30b:b184:a904 with SMTP id
 38308e7fff4ca-30bf44edde3mr88277591fa.4.1741795141546; 
 Wed, 12 Mar 2025 08:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL2sdqq6tjHBcKHGPlgrHm+DjLGV1DlbXmN5K76/Kv9kjY5mt//AFcmt6l54cSlCvy5RR9NYQEpXfhkIstM4Q=
X-Received: by 2002:a2e:bc27:0:b0:30b:b184:a904 with SMTP id
 38308e7fff4ca-30bf44edde3mr88277561fa.4.1741795141096; Wed, 12 Mar 2025
 08:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250312155458.1395709-1-bruce.richardson@intel.com>
In-Reply-To: <20250312155458.1395709-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 12 Mar 2025 16:58:49 +0100
X-Gm-Features: AQ5f1JqB967XX3pLFALFtF4aMQi4SO5T8oLaKtFSuLAF5_1HWvEDmrtKVFX7X2s
Message-ID: <CAJFAV8zAhG3U9h1A=UEu_eUjLBEV+FjuZffZg8+SwEcSuwN9ww@mail.gmail.com>
Subject: Re: [PATCH] net/intel: remove unnecessary compiler flag for mingw
To: Bruce Richardson <bruce.richardson@intel.com>,
 William Tu <u9012063@gmail.com>
Cc: dev@dpdk.org, andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: orpxa85Jpzy0wmMIwrTnaptN6qOydPi6-KhPp8PjhOA_1741795142
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

On Wed, Mar 12, 2025 at 4:55=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> There was an issue with building DPDK using mingw v8.1[1], which
> required using the "-fno-asynchronous-unwind-tables" compiler flag when
> building using the mingw compiler. However, recent versions of the
> compiler no longer seem to need this flag, so remove it.
>
> [1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrme=
i4hfSG5jg@mail.gmail.com
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Adding William in the loop.

> ---
>  drivers/net/intel/i40e/meson.build     | 4 ----
>  drivers/net/intel/iavf/meson.build     | 4 ----
>  drivers/net/intel/ice/base/meson.build | 4 ----
>  drivers/net/intel/ice/meson.build      | 4 ----
>  drivers/net/intel/ixgbe/meson.build    | 3 ---
>  5 files changed, 19 deletions(-)
>
> diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/=
meson.build
> index 2973ed1a01..15993393fb 100644
> --- a/drivers/net/intel/i40e/meson.build
> +++ b/drivers/net/intel/i40e/meson.build
> @@ -41,10 +41,6 @@ includes +=3D include_directories('base')
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('i40e_rxtx_vec_sse.c')
>
> -    if is_windows and cc.get_id() !=3D 'clang'
> -        cflags +=3D ['-fno-asynchronous-unwind-tables']
> -    endif
> -
>      i40e_avx2_lib =3D static_library('i40e_avx2_lib',
>              'i40e_rxtx_vec_avx2.c',
>              dependencies: [static_rte_ethdev, static_rte_kvargs, static_=
rte_hash],
> diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/=
meson.build
> index f7eac7c57a..833a63e6c8 100644
> --- a/drivers/net/intel/iavf/meson.build
> +++ b/drivers/net/intel/iavf/meson.build
> @@ -29,10 +29,6 @@ includes +=3D include_directories('base')
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('iavf_rxtx_vec_sse.c')
>
> -    if is_windows and cc.get_id() !=3D 'clang'
> -        cflags +=3D ['-fno-asynchronous-unwind-tables']
> -    endif
> -
>      iavf_avx2_lib =3D static_library('iavf_avx2_lib',
>              'iavf_rxtx_vec_avx2.c',
>              dependencies: [static_rte_ethdev],
> diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/i=
ce/base/meson.build
> index 59202df661..38d092c370 100644
> --- a/drivers/net/intel/ice/base/meson.build
> +++ b/drivers/net/intel/ice/base/meson.build
> @@ -49,10 +49,6 @@ if (toolchain =3D=3D 'gcc' and cc.version().version_co=
mpare('>=3D11.0.0'))
>      error_cflags +=3D ['-Wno-array-bounds']
>  endif
>
> -if is_windows and cc.get_id() =3D=3D 'gcc'
> -    cflags +=3D ['-fno-asynchronous-unwind-tables']
> -endif
> -
>  c_args =3D cflags
>
>  foreach flag: error_cflags
> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/me=
son.build
> index cbdf38c1c4..4d8f71cd4a 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -35,10 +35,6 @@ endif
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('ice_rxtx_vec_sse.c')
>
> -    if is_windows and cc.get_id() !=3D 'clang'
> -        cflags +=3D ['-fno-asynchronous-unwind-tables']
> -    endif
> -
>      ice_avx2_lib =3D static_library('ice_avx2_lib',
>              'ice_rxtx_vec_avx2.c',
>              dependencies: [static_rte_ethdev, static_rte_hash],
> diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgb=
e/meson.build
> index 0ae12dd5ff..0bee736a2c 100644
> --- a/drivers/net/intel/ixgbe/meson.build
> +++ b/drivers/net/intel/ixgbe/meson.build
> @@ -27,9 +27,6 @@ deps +=3D ['hash', 'security']
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('ixgbe_rxtx_vec_sse.c')
>      sources +=3D files('ixgbe_recycle_mbufs_vec_common.c')
> -    if is_windows and cc.get_id() !=3D 'clang'
> -        cflags +=3D ['-fno-asynchronous-unwind-tables']
> -    endif
>  elif arch_subdir =3D=3D 'arm'
>      sources +=3D files('ixgbe_rxtx_vec_neon.c')
>      sources +=3D files('ixgbe_recycle_mbufs_vec_common.c')



--=20
David Marchand

