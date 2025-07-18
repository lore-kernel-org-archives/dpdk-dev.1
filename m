Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 12:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFA0A4069F;
	Fri, 18 Jul 2025 14:46:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EE1314014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 14:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752842764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnXmqy75a6wxveRsz69lIyrzTVCLBrT4VvKwyL1BGY4=;
 b=RXL/jK/hr6KrcD8EDmmrXzfRsJ4otrbITvjxS40AqZMmG0XGXPC1p1+iBJxlnN5ql1B9sL
 x3Lgarp002H5hj+K+6u5p3wDncUASlPWkJ5ThL1khrcmDhPyZkRTFGH/8fUCr/ce+EWmhm
 u3ls4Zqv2UhhP0ypVKu03C222btvQ+Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-FEXF6YHKOS6ra3GG4a8p6A-1; Fri, 18 Jul 2025 08:46:02 -0400
X-MC-Unique: FEXF6YHKOS6ra3GG4a8p6A-1
X-Mimecast-MFC-AGG-ID: FEXF6YHKOS6ra3GG4a8p6A_1752842761
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-32cbc4a763eso8222701fa.3
 for <dev@dpdk.org>; Fri, 18 Jul 2025 05:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752842760; x=1753447560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnXmqy75a6wxveRsz69lIyrzTVCLBrT4VvKwyL1BGY4=;
 b=R1jqVH1L9/LS+OBx9SkyN3k9jTc9Hj3IieFDA+jmGuFIRlRaLgL3jNSXlAI86VBk10
 xb1itRLyB3YQh5FdeBqQbt7EG0pT5ddtnwrz9AGtM5ghlReWfZfp4v4plNsJ7Ijr7VEI
 2D0DrxIffz5lWOulTqa39SDxBUOK7SOnkFcSLc6LmOfLbZ3mk173JvIG1wL/hwNGbEcX
 3TRMH2TooTgUMg9ckAjoL50nAfX15DCL9vZkIpi7RwpYetlIvco848MUAI3q8XHdDPMf
 bo5K18+VENXnmygDmQ6P+XLQBVnemmzrbJJDJgV13D1kuGwkMgRxVkBaqHlmj+1BOXQv
 x79g==
X-Gm-Message-State: AOJu0YzxTAqq7j2lxY3TA7JVUiAuLievNSYRVljRutIyJ+XcE1kPgpXX
 OC1kivoqVFtH551cxxR6RZ8CuVLWS1KnPhYO54rjEiBA6XeVJ3Lr/ohWiMTFBKHyYBQ2Jtus/zx
 XE2g8FzN6qM20Gw5wU1m9YnlwKLtb0hebv0epJ+b3xZtmb9qzuxu9qTbIezzVnOsqrb3mVwC9ta
 cbekqlf/Ih2rVZfbKVskA=
X-Gm-Gg: ASbGncsFwyoEfkXl6PIRrZzOUChF0vm1st2I1dpuEaU0NmuD3Kq5hh6by9D0Hvh2Yvy
 t/9s18HbCyGWPFCn9zN/YpYki/enzrAdTcuJ8EFwzK/j+wD9O9qtutusiEn8EbiDXcyny6bGSEQ
 gbBYD15OpEeh5tq+vxbF44Qyk=
X-Received: by 2002:a05:651c:1108:10b0:30b:c91d:35cb with SMTP id
 38308e7fff4ca-3308f4c6f96mr19168921fa.4.1752842760494; 
 Fri, 18 Jul 2025 05:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdaYqMbv4ztBWlL2Ihwcp4zk+TQbOX2LMaLERH0byoWmUU0oaYmRObBzoKg+hpZVIlwwtP2FnFMhRjiXAYs2s=
X-Received: by 2002:a05:651c:1108:10b0:30b:c91d:35cb with SMTP id
 38308e7fff4ca-3308f4c6f96mr19168891fa.4.1752842759991; Fri, 18 Jul 2025
 05:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250718121402.856265-1-bruce.richardson@intel.com>
In-Reply-To: <20250718121402.856265-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 18 Jul 2025 14:45:48 +0200
X-Gm-Features: Ac12FXyubZwCipNjS3tVUv-1aamj3XWi-9xzJ51D8bJobK_txaRNSh86YzkwbJw
Message-ID: <CAJFAV8wYyWbdRMTZB7ZJW-6703RPFc+7+v8BhMdvadJcm1Jadw@mail.gmail.com>
Subject: Re: [PATCH] build: remove obsolete compiler checks
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IiwO609aopRIRUBNKi_fn69yhRzZyoD205RCpLN7FNY_1752842761
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

One other nit, not blocking.

There should be no need for special casing clang vs gcc, since clang
supports gcc syntax in general.
https://clang.llvm.org/docs/AttributeReference.html#pragma-unroll-pragma-no=
unroll

The code could check for RTE_TOOLCHAIN_GCC/CLANG directly, and we
don't need a separate define passed from cmdline.

(idem in lib/vhost)


--=20
David Marchand

