Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39181C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:57:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 835A440DCB;
	Mon,  7 Apr 2025 17:57:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 308AF40A89
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744041469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLamn0NHRd7kAKMKK+bNDADC+5RO3h66plJU2kXJGWE=;
 b=KgV+wovIZmhL7+BnAX7GAnP/okgc99mMXgP687DIyurQmYecRq979od8YDXjsdCl/pCTbe
 jGBLipQIDqLvh0NXIfJvEk1RsviNHwHPzPGwQ6ty2t3MMdhVKRQtxh72/GVPJqRX8L6Uwz
 eXpJ7Fl42HdJwTGseoKtdACKcE5YFz4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-x57cprF5PL-VnmJ8pUrYXA-1; Mon, 07 Apr 2025 11:57:48 -0400
X-MC-Unique: x57cprF5PL-VnmJ8pUrYXA-1
X-Mimecast-MFC-AGG-ID: x57cprF5PL-VnmJ8pUrYXA_1744041467
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso9792766b.1
 for <dev@dpdk.org>; Mon, 07 Apr 2025 08:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744041467; x=1744646267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLamn0NHRd7kAKMKK+bNDADC+5RO3h66plJU2kXJGWE=;
 b=JxCzYb2NmQd1vXudAE+L4fsg2HSXGTsbca1KqIVQFLBW2xy2Ohx6T+sflk4BKviy1K
 YCar+J4AJmogeK9N6X32iZZFpEfQbpoub3NSQH8vS5GfqgnufaGSQv5o0Wdx+mVn2X6w
 SvJn38B+y68tUHTeGo0EsdMHUF8CxTiu+zGWyaOI3oF++Bkej4GerGV6Hi429LY6FFUI
 UnsStGTgBOL79+z1ADs5Jk5VzIlp3LbdsJTwwE7bvAKbPNntfK038oMsw73mCJcbrN4N
 9w/vh1qf3LXw8RkFL19KIb3xaT8RE39GDECbjdUSzU5nSuT1daxam8Uu4J1QwuCwvsh1
 ZX8g==
X-Gm-Message-State: AOJu0YzvYumwpEcwE6PUuPU9fCytz4OctDAQcJJLHHRcPoSzu9T3ZMO0
 L10Y150WqgmwB1X2azeIF9Cmw4ko9Ss2AFW3uI5rPpmzrWPqy5V7/MfNHueCIB51QCGv2+d4GCQ
 OGiOKKhqEopQAeIazqRr9sh5AK10uhReREwpYLfyumC9Qt4l0douyglhGPHsq5jo3Qr9zZODmpT
 lnLd07fddBTJPMx3fx1Vbfnlk=
X-Gm-Gg: ASbGncvEhYKYWalITLWkL3fgpO54ymm+n7Y145VDBpJPpLJo/G5KgCzGLMy+nVqicpG
 RaxehzQFVPvuILS7T7GhxrvqWi6XqLtMc93TB8ojAtkDXEt+V9tocwjsdLq1qrGvwI/9I/mDqcP
 s=
X-Received: by 2002:a17:907:d91:b0:ac3:773:62a7 with SMTP id
 a640c23a62f3a-ac7d18c1c7amr1112058466b.31.1744041466779; 
 Mon, 07 Apr 2025 08:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFafUUzuORbcFWsZvVZpMzPfvaLuxH6WcaDtzgKeQqHtHIUTIUeeVONsaMXDASKh60Vh4zIM8H1qD0QQ8EwCBM=
X-Received: by 2002:a05:6512:ba8:b0:549:490e:240d with SMTP id
 2adb3069b0e04-54c22792c24mr4019660e87.28.1744040986338; Mon, 07 Apr 2025
 08:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250407152857.2203839-1-bruce.richardson@intel.com>
In-Reply-To: <20250407152857.2203839-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Apr 2025 17:49:34 +0200
X-Gm-Features: ATxdqUEdRzKuUy3vrfUVkmtNqYyPhd7fYlUzk-LOgNp9d-wRnihrPSZOW6i9EQ8
Message-ID: <CAJFAV8zKFof8+_mDc7_Nmf=QkTdVDgBVYY2rc+DVZKXDoR8s8A@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: add generic build of SVE files
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Jie Hai <haijie1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _XPwZ_OG8bz6ADIuYeZTVCgBNXrb0LJCQESp15C-LVw_1744041467
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

On Mon, Apr 7, 2025 at 5:29=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> For SVE, as for AVX2 and AVX-512, support building files for these ISAs
> from the top-level drivers/meson.build file, rather than having each
> driver re-implement it.
>
> This removes the remaining build task for drivers in DPDK which is
> being done by a driver itself, rather than in the generic drivers'
> build rules.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks for working on this additional cleanup.


> ---
>  drivers/meson.build          | 27 +++++++++++++++++++++++++++
>  drivers/net/hns3/meson.build | 22 +---------------------
>  2 files changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/meson.build b/drivers/meson.build
> index b2d2537dc8..a6f0670a2f 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -128,6 +128,7 @@ foreach subpath:subdirs
>          sources =3D []
>          sources_avx2 =3D []
>          sources_avx512 =3D []
> +        sources_sve =3D []
>          headers =3D []
>          driver_sdk_headers =3D [] # public headers included by drivers
>          objs =3D []
> @@ -285,6 +286,32 @@ foreach subpath:subdirs
>              endif
>          endif
>
> +        if (arch_subdir =3D=3D 'arm' and sources_sve.length() > 0
> +                and cc.has_argument('-march=3Darmv8.2-a+sve')
> +                and cc.check_header('arm_sve.h'))
> +
> +            if dpdk_conf.has('RTE_HAS_SVE_ACLE')
> +                sources +=3D sources_sve

Do we need this special case?


> +            else
> +                cflags +=3D ['-DRTE_HAS_SVE_ACLE=3D1']
> +                sve_cflags =3D ['-march=3Darmv8.2-a+sve']
> +                foreach flag: cflags
> +                    if (flag.startswith('-march=3D')
> +                            or flag.startswith('-mcpu=3D')
> +                            or flag.startswith('-mtune=3D'))
> +                        continue
> +                    endif
> +                    sve_cflags +=3D flag
> +                endforeach
> +                sve_lib =3D static_library(libname + '_sve_lib',
> +                        sources_sve,
> +                        dependencies: static_deps,
> +                        include_directories: includes,
> +                        c_args: sve_cflags)
> +                objs +=3D sve_lib.extract_objects(sources_sve)
> +            endif
> +        endif
> +
>          # generate pmdinfo sources by building a temporary
>          # lib and then running pmdinfogen on the contents of
>          # that lib. The final lib reuses the object files and

On the principle, sources_sve must be passed to gen_version_map like
other sources_XXX.


--=20
David Marchand

