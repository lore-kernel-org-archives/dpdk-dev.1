Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B156CA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F94840289;
	Tue, 19 Aug 2025 10:10:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A452A40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755591037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUaSatz+jTlr5W0m21BqMVwDZ88xZQpOLy9sYORY/us=;
 b=DY+A0htMojFPXrydWmgrf0KazaBRe3hMmLOnlD8z4/zqzdj5nBIMyx5UgEUgmyjBHvOETQ
 oQrDdRsMFZpugNGDhRhXCbNyfMBdqsc2Ajj/GxDlWQ18OSC3BbWp3+U9FAf+ga8hjzrtif
 AQAFkzqAkB8xB6K44wC//j+spHZzwRE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-IskErZDJMc6-E2yk74Be6A-1; Tue, 19 Aug 2025 04:10:35 -0400
X-MC-Unique: IskErZDJMc6-E2yk74Be6A-1
X-Mimecast-MFC-AGG-ID: IskErZDJMc6-E2yk74Be6A_1755591034
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55ce50b6987so3179772e87.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755591034; x=1756195834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUaSatz+jTlr5W0m21BqMVwDZ88xZQpOLy9sYORY/us=;
 b=YuXuI7gsjhatcnkBBRm3kxOn/6Xf1D3Q9ACCRDqLh7a0bI4lRjpi0fa4W97fPqyMY7
 4rsZy/Ovq6jlV7NoTGs+Rxqs5u501eThkdGG3O8CWUf5jQZrICy7t2NiJaeCe0oXb62F
 KZjQP8g/DvCoEaG0vtQF4AkIm5rmx+KyekZggIC7OR6AIbMUd4ckl4ZB7kYVZfYR37By
 GzkER9oLs9Ua2bzjXaxjPrpYTHKo+nHhtF6bw/4HTyIFaPYp6sn+oMI5+zkW/k8Dh661
 KF5X+tC7ldQfYXVP/szjwocpRbJ/j39B8R+Ly5vmeiKBwCyGGH+t9/0x/CIHB/O/gYs6
 OghQ==
X-Gm-Message-State: AOJu0YwXKPfGb3ThqyOsdnhrecKgS8Lk0sHVDhhdEC3lwjPagRV0I8e9
 qJ0qgN10Z8ToKiWGD3xzcaOC56+mUZzdY2quVnDgps5/FKnsxl+X/8w5+yQL1K/Bl5ybjYR66nr
 ZqS+zlyIcbRVOzrUUbIhx8cQwgl3xFrR3vtoBiqBS6UtUXSfwS/tFRHFws3HlwYpX8pyDvuC8UD
 3duDz1c/soLgZ1ZFALfIU=
X-Gm-Gg: ASbGncutbaxrWYWaECZxVFBh9PplMLS+/MF/hvxJNPnpvS2xdKql6ssVfeH1oKiC4Fu
 ijuAamjuseRSFQ4SaI/Y9V83SODGAoBJDadlO83NQ9pBmjg+axMROU5KJ4JcjXZ5KdQ8AxganXE
 osJylZeNyfdrZYhe8mccOhRAw=
X-Received: by 2002:a05:6512:2351:b0:54f:bdfe:ece5 with SMTP id
 2adb3069b0e04-55e007afc81mr484376e87.14.1755591034134; 
 Tue, 19 Aug 2025 01:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfBLByZYLGDl1jzEaRwNN7bPV8Hc7Wgl/WOrY+vQnAumbin2jz4uCjrivXec60xJkYmUb6pdIB6hWIMtXaZrw=
X-Received: by 2002:a05:6512:2351:b0:54f:bdfe:ece5 with SMTP id
 2adb3069b0e04-55e007afc81mr484370e87.14.1755591033653; Tue, 19 Aug 2025
 01:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <20250725160730.18354-1-bruce.richardson@intel.com>
In-Reply-To: <20250725160730.18354-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 19 Aug 2025 10:10:21 +0200
X-Gm-Features: Ac12FXxfQjImqnhZukUCmiF6kpbRDVqEBkRAA12iKHEiMY00Z__-PnDtkYk-bEs
Message-ID: <CAJFAV8xObjjfq5zFce_kT_ZhsPhiXzixXEdT+G-Mi8OV77sssw@mail.gmail.com>
Subject: Re: [PATCH v2] build: remove obsolete compiler checks
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2-R1Bd5nIV7mK1_dqpuWZ7Q4x6IYo5i1X2Zj2vdnltA_1755591034
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

Hello Bruce,

On Fri, Jul 25, 2025 at 6:07=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.bu=
ild
> index d3caa3a3b4..a9ff87e863 100644
> --- a/drivers/net/virtio/meson.build
> +++ b/drivers/net/virtio/meson.build
> @@ -31,7 +31,7 @@ if arch_subdir =3D=3D 'x86'
>          sources_avx512 +=3D files('virtio_rxtx_packed.c')
>          if (toolchain =3D=3D 'gcc' and cc.version().version_compare('>=
=3D8.3.0'))
>              cflags +=3D '-DVIRTIO_GCC_UNROLL_PRAGMA'
> -        elif (toolchain =3D=3D 'clang' and cc.version().version_compare(=
'>=3D3.7.0'))
> +        elif (toolchain =3D=3D 'clang')
>              cflags +=3D '-DVIRTIO_CLANG_UNROLL_PRAGMA'
>          endif
>      endif

[snip]

> diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
> index 9c6325aa0e..a74d0cff7c 100644
> --- a/lib/vhost/meson.build
> +++ b/lib/vhost/meson.build
> @@ -8,9 +8,9 @@ endif
>  if has_libnuma
>      dpdk_conf.set10('RTE_LIBRTE_VHOST_NUMA', true)
>  endif
> -if (toolchain =3D=3D 'gcc' and cc.version().version_compare('>=3D8.3.0')=
)
> +if (toolchain =3D=3D 'gcc')
>      cflags +=3D '-DVHOST_GCC_UNROLL_PRAGMA'
> -elif (toolchain =3D=3D 'clang' and cc.version().version_compare('>=3D3.7=
.0'))
> +elif (toolchain =3D=3D 'clang')
>      cflags +=3D '-DVHOST_CLANG_UNROLL_PRAGMA'
>  endif
>  dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaul=
tfd.h'))

Sorry, I did not notice in the v1, but lib/vhost and
drivers/net/virtio have the same construct, yet only lib/vhost gets
updated on the gcc version check in this patch.
Is this intentional?

Since GCC 8.0+ is recommended, I would keep the version check in both
vhost and net/virtio.

Other than this, it lgtm.
Reviewed-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

