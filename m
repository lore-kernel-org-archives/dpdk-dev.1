Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EB2C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 13:36:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02BB44069F;
	Fri, 18 Jul 2025 15:36:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9A02B4014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 15:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752845796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8tXxdU9bpWGigofOIvOYx7GdtyNp4uAO2VLqLAN3Lk=;
 b=dQqb4nlJFNXbwzd9VnbX0pmbXrHC52SW3tOMeot60PiM1hu4nFnbfWkIUeIR4+2OyGW7O3
 H77qdACW5qeX9GjUDgDAwEnH+jFbfFPEbZp+zH3AksNxsXsKeD90TwdMFnjJe1y1HXtMaJ
 C+OXZV1mUccSyTSfjwI6cDiJMonccwM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-uxnHo5L7NGGsE2FecMoRIQ-1; Fri, 18 Jul 2025 09:36:34 -0400
X-MC-Unique: uxnHo5L7NGGsE2FecMoRIQ-1
X-Mimecast-MFC-AGG-ID: uxnHo5L7NGGsE2FecMoRIQ_1752845792
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b48369fadso13285361fa.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 06:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752845792; x=1753450592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8tXxdU9bpWGigofOIvOYx7GdtyNp4uAO2VLqLAN3Lk=;
 b=aEwapPjDzRUm/G4xn4aJ8tRRWtcMltwmSzJNdGR7kFwwQ73nZTpATLlNTlZYYs6PhB
 Eja1qBenlb0Ox6ARQgDdnG7N+BZGr8hvX/lcllb01/ZUlP6eqfj5BVrwA5HO1/L0XZMt
 vHtImkVy1G6bFOFoOd5EsX754PCEXVoK9xLHUXpLnzHjoeyqUFSra8rrAjYDlnU+Tuz6
 TooV96GIrn7nEs5Cx89UtM8df7P0K8+h1S6n47T/P/xWco8TIHJ2/e2thYQ1s9nCDtY0
 MOijtSBluw2fJkgV8tBRLwQyT8hRtU+a+07q7NOZNW8iLWZT4K/Bqwrm3BOqFiKc/zs6
 I1Sw==
X-Gm-Message-State: AOJu0YwsJLJC36lXtvsBot3EGHj1+RqD34agd6iXY9/LQpsTKdmJLUY6
 g3eHERZTKNkin7BJwP721VNlOCxBHTWRoyGC9xj3mq0fnvOSEql7o/KG5EfUlYxfZkpdoUycyyK
 PZgYXwVjYlboscRJprsNY792IS2t6zGafZI0OnWqx5ncdrVVGjnfGvWjJJOWvGv7uf9j2knhlSo
 9Ay7mZM2EaF3G4sBesBXA=
X-Gm-Gg: ASbGnctdT2XIPRrhfgUfyXFGM6s2I6mrvyOUlzlBt8WcSqebwD7m+BCfsWySrqjOccS
 lvMSk72OOjFE8IhHktU33zSpsOnNOm/N/B32OMQToOOKwUep1oRt/s5O+pGImnzsq35Z3+2K1FU
 0VwHgM0eT0dWnQ5/3jzNWrn4s=
X-Received: by 2002:a2e:a016:0:20b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-33098f0d4cdmr15893731fa.7.1752845792316; 
 Fri, 18 Jul 2025 06:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3PRtLqnwcQ/EqgTyOgJOXJKdZb3BPnm9m5R3ELm/VtAOy6QkCCVoVCdMfldOYlYxlZq6xySMB2DIihIhb6HA=
X-Received: by 2002:a2e:a016:0:20b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-33098f0d4cdmr15893651fa.7.1752845791774; Fri, 18 Jul 2025
 06:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <CAJFAV8wYyWbdRMTZB7ZJW-6703RPFc+7+v8BhMdvadJcm1Jadw@mail.gmail.com>
 <aHpGsX_il5_oRWBv@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHpGsX_il5_oRWBv@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 18 Jul 2025 15:36:19 +0200
X-Gm-Features: Ac12FXyxXnylp5andWdi2rdPiK-QP50sCC3hjB-urfmWOrEZTHOZcQp1OAi2nTc
Message-ID: <CAJFAV8wG+Y5f_G9t0jOGnyvq0PLwYLVWOHDFPXeQRHPF-tZ4OQ@mail.gmail.com>
Subject: Re: [PATCH] build: remove obsolete compiler checks
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JAV7jZhtdQz7JZ6q7VpRIGXrVp9XVhJq3D3ADKfEEAM_1752845792
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

On Fri, Jul 18, 2025 at 3:06=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Jul 18, 2025 at 02:45:48PM +0200, David Marchand wrote:
> > On Fri, Jul 18, 2025 at 2:14=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > > diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meso=
n.build
> > > index d3caa3a3b4..a9ff87e863 100644
> > > --- a/drivers/net/virtio/meson.build
> > > +++ b/drivers/net/virtio/meson.build
> > > @@ -31,7 +31,7 @@ if arch_subdir =3D=3D 'x86'
> > >          sources_avx512 +=3D files('virtio_rxtx_packed.c')
> > >          if (toolchain =3D=3D 'gcc' and cc.version().version_compare(=
'>=3D8.3.0'))
> > >              cflags +=3D '-DVIRTIO_GCC_UNROLL_PRAGMA'
> > > -        elif (toolchain =3D=3D 'clang' and cc.version().version_comp=
are('>=3D3.7.0'))
> > > +        elif (toolchain =3D=3D 'clang')
> > >              cflags +=3D '-DVIRTIO_CLANG_UNROLL_PRAGMA'
> > >          endif
> > >      endif
> >
> > One other nit, not blocking.
> >
> > There should be no need for special casing clang vs gcc, since clang
> > supports gcc syntax in general.
> > https://clang.llvm.org/docs/AttributeReference.html#pragma-unroll-pragm=
a-nounroll
> >
> I was actually thinking of doing a follow-up patch to remove the "if" and
> instead do:
>
>         cflags +=3D '-DVIRTIO_' + toolchain.to_upper() + "_UNROLL_PRAGMA"
>
> on the basis that having a define for any other unknown compilers would b=
e
> harmless. However, you are right that there seems to be little reason to =
do
> this in meson.build, and the code can do it directly itself. I'll leave
> this part as it is in the patch for now.

Cc: Maxime (who is off atm)

I wonder if this pragma stuff really helps..
One quick test on the loop in vhost_flush_enqueue_batch_packed() shows
the same generated code with gcc 10 and gcc 15 when compiling with -O3
(thanks to godbolt.org).

Let's leave it as is for now, but I would be for dropping this strange
construct, only used with the virtio ring packed layout iirc.


--=20
David Marchand

