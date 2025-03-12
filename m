Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8261C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:30:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A4B44029E;
	Wed, 12 Mar 2025 16:30:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E625E40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741793398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2AKCpBSz42G3iPUFWWsM/vfALWCeas7ak9b6YNFDXI=;
 b=gvViVsFhW+ZFu02nLJRu+FgJoiZabVWGvCCrYeMAarb0JF0ThUa8+l0UpoDTVMOIKZWCKY
 nuIOUZxrI6n/NuybvwIP71xaSozHMNkBF1igLJruWSgo9d7S3IxrpmGHYlMZuZ9qn7dw/8
 lvQLcx7/0icT1sL5w2tKMDOZt3BXWiU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-V9EcoPfmNOqqxwikYrkEMA-1; Wed, 12 Mar 2025 11:29:54 -0400
X-MC-Unique: V9EcoPfmNOqqxwikYrkEMA-1
X-Mimecast-MFC-AGG-ID: V9EcoPfmNOqqxwikYrkEMA_1741793393
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5495a1c0be4so3884367e87.2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 08:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741793392; x=1742398192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2AKCpBSz42G3iPUFWWsM/vfALWCeas7ak9b6YNFDXI=;
 b=nY15p0RFgH36spwkePvwo5/m+06dCImp+5zjv7KGlJaA+GZAHKaI5AjtBAcxIuqm29
 e3Ou4moAGywQhVZmBe2bydI7DM4XaLclu3UJdQGyGEsHxjwbcN7yG8YQdleosIFxdjJD
 LjeWr8Z9yGktbhRIrvwavV1iy9Mv3tmp6wTR7RRonVFUkq0RS3iEfTmtQKmV/gi9d8df
 VhaW/XFxEVrl99odzk4BGSUY/5vwardVsctuTZrN0+/gZAkyMKt1zZX2+N7iLBBIWmZj
 PwZBZ3xhmdlE9GZKaznj8co8plwj5gkSVxm0TAY4XNtMtBpoeu3uqImw3KMdR1gw5Wfn
 oWDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3zFOuEUnWqTdI6NhDcERKq13AXLRN8XJuzCC4yArEZ323nzeKqO4ZZOVuDHcm8uezkPQ=@dpdk.org
X-Gm-Message-State: AOJu0Yx5vcFSi+jCH6IhYXDxKqKUWt7iuIZZHs4+yX7UbJE2IIh/QSJV
 3gIE6R7EA0Bf/fw3ls6Vcn16EN5nbNwfADSnEWzmhegrWijnudcj0oWWNcP522pWRdoQJATmRmC
 QaARK78mVAPXaFkR0t0CGlVaL54bHzBCaucfS5s5BADeIwwY6uXHhrF02MkwgTLIQSp2lAc3f/o
 ATxRN6YUTK89P5G1Q=
X-Gm-Gg: ASbGncswM/S+jm93kHybV10ZrpdzEl9QIz9XwxN8eVQXsBe6kzXqD7SXH2Ax7m8Y3jw
 VSp9boIXaBevoRT4Nzl8g4Q0Amt965xYdgGKncSxTD1Wln2JPPhLhSnsckVaeRneK+xIsEJeIHA
 o=
X-Received: by 2002:a05:6512:3993:b0:545:353:4d46 with SMTP id
 2adb3069b0e04-54990e6335emr6250456e87.25.1741793392540; 
 Wed, 12 Mar 2025 08:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWVIK94N65RCi0//VHBgk9H3Wne1dq0aLahKTXQZtTDCFHBYXWjYEmxDJa6IQoYIbwUzsK77xHtOx0BXudw/8=
X-Received: by 2002:a05:6512:3993:b0:545:353:4d46 with SMTP id
 2adb3069b0e04-54990e6335emr6250447e87.25.1741793392188; Wed, 12 Mar 2025
 08:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
 <Z9Glyi4qOjAFBHTG@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9Glyi4qOjAFBHTG@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 12 Mar 2025 16:29:40 +0100
X-Gm-Features: AQ5f1JryfjAlmAAGcU90XlkcMyvDG4XmEmFW-DqeJhGctgvpoRHegk7Y97fYro4
Message-ID: <CAJFAV8yS=Lfcv=q0JwrU2+57z=jMz5K2grAsYTU2omOxR62Xww@mail.gmail.com>
Subject: Re: [PATCH] drivers: remove invalid options for MSVC
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Ian Stokes <ian.stokes@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RegqZlx8wGgjT2r8ICzfymOGEt8IFOBPKOR1fDG8yms_1741793393
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

On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ix=
gbe/meson.build
> > index 0ae12dd5ff..3553b0ffe1 100644
> > --- a/drivers/net/intel/ixgbe/meson.build
> > +++ b/drivers/net/intel/ixgbe/meson.build
> > @@ -27,7 +27,7 @@ deps +=3D ['hash', 'security']
> >  if arch_subdir =3D=3D 'x86'
> >      sources +=3D files('ixgbe_rxtx_vec_sse.c')
> >      sources +=3D files('ixgbe_recycle_mbufs_vec_common.c')
> > -    if is_windows and cc.get_id() !=3D 'clang'
> > +    if is_windows and cc.get_id() =3D=3D 'gcc'
> >          cflags +=3D ['-fno-asynchronous-unwind-tables']
> >      endif
> >  elif arch_subdir =3D=3D 'arm'
>
> Out of interest I've just tried compiling up DPDK builds without these
> unwind-tables flag, and they all pass, including the mingw build. This is
> using:
>
> $ x86_64-w64-mingw32-gcc --version
> x86_64-w64-mingw32-gcc (GCC) 13-win32
> Copyright (C) 2023 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
> Therefore, I wonder if we can just remove all these flags completely for
> mingw now? They may only be needed for historical versions.

Here is the original issue:
https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG=
5jg@mail.gmail.com/

It happened with mingw 8.1.0 apparently.


--=20
David Marchand

