Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33615C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 10:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 379DD4069D;
	Thu, 27 Mar 2025 11:37:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EECE64066C
 for <dev@dpdk.org>; Thu, 27 Mar 2025 11:37:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743071827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YzvddFLkynuuETfhxZkKw3eE+0anQYpNeKjoFw7QVQ8=;
 b=ZIElkOfiJh35RkbnEwKVsG++fG2vV5MtVlWuDt7I54MI4/4cke3L8k0Wvm1Q3WoLBxkqpl
 ydvfrYuFzfeN91nvpcU1yg4XzMkaYnEgJ+cAoSmlG109c5MJ4UsRR448itSgj/kFEkN2Ms
 E89G6wl885KKnetjbvK47Um3OhezSHE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-7nFoSp6LMgiKEOrK8Vk-9A-1; Thu, 27 Mar 2025 06:37:06 -0400
X-MC-Unique: 7nFoSp6LMgiKEOrK8Vk-9A-1
X-Mimecast-MFC-AGG-ID: 7nFoSp6LMgiKEOrK8Vk-9A_1743071824
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5498ee86adfso899938e87.0
 for <dev@dpdk.org>; Thu, 27 Mar 2025 03:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743071824; x=1743676624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzvddFLkynuuETfhxZkKw3eE+0anQYpNeKjoFw7QVQ8=;
 b=PASkkitL8wxpbmvgoBg1Em+AXoF97mYMr2NPVElQikXdXPaWFOvXUnYmyMWySK386q
 6XcrC1sA8859gH3EcsevXNc+wcuC5w6pTUsr/+8+QmaKOMv1671/BAFntz8suT3E6k1C
 UaF5xpuqBpJxEMd/pEWShZhrJGi3laZDDv8yLTWc9jqZKLSDHOf3laQBO1di4j/76jNy
 aU71P9i98Selevb3bG0O4JpbAtm0wHN9YgmKt4FdiYJmK+Eo0iKH6TR5pikaQxTV7Zrn
 2KzWTRIp4Gn7hL1iTCpoxm2hDOfaECvj8lWLevHJLpBIHm/lttE/gGQjUhO1JmpIp/C7
 tCUA==
X-Gm-Message-State: AOJu0YzdKThFbUZi3wXDsr9Fh9n6JnR3J3TTMYkq9A0+na3EBEWqtlkQ
 yk6D/j1W59isUoyx3+PVkH9Iu/g49Z+YYxRFKeHFECGhatN/n/QwXMvN5YPgZ1ixYtS9SEZgVrv
 oZ99mBAZEyWeRHhuDpkE7zjzPN7HO2+gz0RvhApdIlZImV1aSVUV/Ke6BuK1MdS/RCFOOhPkTya
 S/biK/7X70/Nex1zQ=
X-Gm-Gg: ASbGncuM1KwxspMQcbLH5u4hQePYJ/4prMIl48j5Akb5W0bdKZtCp60siO/7z5StCpm
 PprwmkAD3oty1puetO6YLcbJQk2N7ZkYiVRG7QGNAKZ83WYsufueN0Exga4yIXo5b2ObTLWd+QV
 Y=
X-Received: by 2002:a05:6512:acb:b0:549:8c0c:f059 with SMTP id
 2adb3069b0e04-54b0107f795mr1123427e87.10.1743071824393; 
 Thu, 27 Mar 2025 03:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjc58i8Sn8EOBTlYDmh7+ecZPEAZ3PSdtypS46146s37lFp7+AHveoKbhDF1SNKMRar4UGMwoHffTAXhXTdgQ=
X-Received: by 2002:a05:6512:acb:b0:549:8c0c:f059 with SMTP id
 2adb3069b0e04-54b0107f795mr1123414e87.10.1743071823964; Thu, 27 Mar 2025
 03:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250326103928.1189243-1-david.marchand@redhat.com>
 <Z-USgmK7lRZsjcIn@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-USgmK7lRZsjcIn@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 11:36:52 +0100
X-Gm-Features: AQ5f1JpLNrDpWEjgFd2j8bvErK2wEGhoVYFGIMk8QmFhdLCdHg6ys4TYLcE6EKY
Message-ID: <CAJFAV8xLbR_UD3=i_fR3aLzuciuWbbkkV8DgiXYm6Y1C7RXQug@mail.gmail.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, bluca@debian.org, stable@dpdk.org, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 David Christensen <drc@linux.ibm.com>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PJHFp0NAoB9-5Ce6y6sMwXEnspCeu0Xr5jngWbtcDiI_1743071824
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

On Thu, Mar 27, 2025 at 9:55=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 26, 2025 at 11:39:28AM +0100, David Marchand wrote:
> > Caught in OBS for Fedora Rawhide on aarch64:
> >
> > [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> > [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> > [  198s] In function =E2=80=98alloc_completion=E2=80=99,
> > [  198s]     inlined from =E2=80=98acl_start_next_trie=E2=80=99 at
> >       ../lib/acl/acl_run.h:140:24,
> > [  198s]     inlined from =E2=80=98search_neon_4.isra=E2=80=99 at
> >       ../lib/acl/acl_run_neon.h:239:20:
> > [  198s] ../lib/acl/acl_run.h:93:25: error: =E2=80=98cmplt=E2=80=99 may=
 be used
> >       uninitialized [-Werror=3Dmaybe-uninitialized]
> > [  198s]    93 |                 if (p[n].count =3D=3D 0) {
> > [  198s]       |                     ~~~~^~~~~~
> > [  198s] ../lib/acl/acl_run_neon.h: In function =E2=80=98search_neon_4.=
isra=E2=80=99:
> > [  198s] ../lib/acl/acl_run_neon.h:230:27: note: =E2=80=98cmplt=E2=80=
=99 declared here
> > [  198s]   230 |         struct completion cmplt[4];
> > [  198s]       |                           ^~~~~
> >
> > The code was resetting sequentially cmpl[].count at the exact index tha=
t
> > later call to alloc_completion uses.
> > While this code seems correct, GCC 15 does not understand this (probabl=
y
> > when applying some optimisations).
> >
> > Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup th=
e
> > various vectorized implementations accordingly.
> >
> > Bugzilla ID: 1678
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  lib/acl/acl_run.h         | 5 +++++
> >  lib/acl/acl_run_altivec.h | 8 ++------
> >  lib/acl/acl_run_avx2.h    | 4 +---
> >  lib/acl/acl_run_neon.h    | 8 ++------
> >  lib/acl/acl_run_scalar.c  | 4 +---
> >  lib/acl/acl_run_sse.h     | 8 ++------
> >  6 files changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/lib/acl/acl_run.h b/lib/acl/acl_run.h
> > index 7f092413cd..9fd3e60021 100644
> > --- a/lib/acl/acl_run.h
> > +++ b/lib/acl/acl_run.h
> > @@ -176,6 +176,8 @@ acl_set_flow(struct acl_flow_data *flows, struct co=
mpletion *cmplt,
> >       uint32_t cmplt_size, const uint8_t **data, uint32_t *results,
> >       uint32_t data_num, uint32_t categories, const uint64_t *trans)
> >  {
> > +     unsigned int i;
> > +
> >       flows->num_packets =3D 0;
> >       flows->started =3D 0;
> >       flows->trie =3D 0;
> > @@ -187,6 +189,9 @@ acl_set_flow(struct acl_flow_data *flows, struct co=
mpletion *cmplt,
> >       flows->data =3D data;
> >       flows->results =3D results;
> >       flows->trans =3D trans;
> > +
> > +     for (i =3D 0; i < cmplt_size; i++)
> > +             cmplt[i].count =3D 0;
> >  }
>
> Minor nit, but since we are using c11 standard, is it not better to decla=
re
> "i" inside the "for" statement. Keeps diffs simpler for adding/removing
> code, I think.

I still have this (bad) habit but yes, it looks nicer with declaring
in for() itself.


--=20
David Marchand

