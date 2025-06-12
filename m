Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142BC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 14:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20A4142796;
	Thu, 12 Jun 2025 16:40:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 233CC42789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 16:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749739227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2tI+gj+D8McWwtGfYftqnmRavYczGUP7PtrBWn/2fo=;
 b=iPpzqOJ/hrZWKaOsnNIvMiPa0D1CBhGcTgtLrEp870bFiRopPvvzUhcArZO15pE+rGfHVh
 JkqFjwsQ7L/btJ8prjDBJvktebrk+oxW4Y5yoQnZnW2aS6pL296WQNZp7fF3L/btmLKBR+
 gDTHQLVN1P1kZCJs+jsfxdFcRyELfpI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452--GAuJxw2NaiJc7nN3Io7hw-1; Thu, 12 Jun 2025 10:40:26 -0400
X-MC-Unique: -GAuJxw2NaiJc7nN3Io7hw-1
X-Mimecast-MFC-AGG-ID: -GAuJxw2NaiJc7nN3Io7hw_1749739225
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-311cc665661so984352a91.2
 for <dev@dpdk.org>; Thu, 12 Jun 2025 07:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749739225; x=1750344025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2tI+gj+D8McWwtGfYftqnmRavYczGUP7PtrBWn/2fo=;
 b=cpjThY3W1P+M3ZQKjWjbImqAoByXuwqwGthTwvdEb8cH2IPVE3qrJExKQevr7/xbD5
 Hg0T+0tmLCh/sLDAUmG6HD+sRjV/lPgdxx8R+AvTVWGM4RlK3GJPYzNbJGiAGNtzg3LS
 F+EuOYekS8bW5ekJ1mea9mon+JPe8RhpIHwB0UI/zAtr4HXIeznv0MNC5fdaFHJuUqil
 ZcFSp3luNy2UbVqbtIwhaJQxvxbiu9FcI+PQ4KWtUB7B2/qOwI46IFVFovmwuw6kZBIh
 w/y9XYKLQWIpth1PzozH6b/9w4LAPWB/xA5LYW/T9I4Eat5CVrs9gl/zqwYtwEMSuBcE
 93bQ==
X-Gm-Message-State: AOJu0YxueOmliHnh1lInws9dQ5p/ltCUbwI0NFHnhS1wmkVaO/XRpO/h
 +E+IlSz0AQT04/E21u6clH7ZaTjOlckb1CS+/ycJEkyya9Kdgd1Kxaru+CDUvmqgamogJlACZAS
 j532nTZgP3FyMMRgMdk6tN9rdU8YdsC5MBnhIKedYoF8GYTM9PGjKUVngMzD4boK5tsL6J8Cp/m
 4A/4PyrbtPtk776VBJGUs=
X-Gm-Gg: ASbGncse9oSBvnuPEUc/fiblV3tdTBkDygFyXHZLe7bYSi26EBHOX9seuaPqSEKgMQJ
 N0qJH2G1fHgII5Gl1Tx6uL+SecTHS9FiCCR9LQUTJYj6pVmspGxLROTK0IPoDLI6cl7feV/90WM
 oEzw==
X-Received: by 2002:a17:90b:2e84:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-313bfbd0171mr5373827a91.19.1749739225262; 
 Thu, 12 Jun 2025 07:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2EawY34LcvidLDuBZEohsEPYSvx8XSSUPJz7jxdABIcELQhU2p0LvRqJmoIQZXy64svBhIUraBYjGX3tR8q8=
X-Received: by 2002:a17:90b:2e84:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-313bfbd0171mr5373787a91.19.1749739224786; Thu, 12 Jun 2025
 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250605113552.918120-1-eperezma@redhat.com>
 <20250605113552.918120-2-eperezma@redhat.com>
 <be8da555-af1c-47af-8225-f5b43d8b6dbf@redhat.com>
In-Reply-To: <be8da555-af1c-47af-8225-f5b43d8b6dbf@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Jun 2025 16:39:47 +0200
X-Gm-Features: AX0GCFtjc2MvxlfyoADdb3p9o9PvzRX0HB1dgZSTTfb-FRZnpDuUTLApJgRBzPM
Message-ID: <CAJaqyWej9mk84Yn3juci9YobBwM2xmNJOVpPVd5jRAVZSLRk=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost: search the split vq desc and avail in RO areas
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kUCSBkhGnqc3XLIs5-cHycXvM16Vfnq4QypY_e-6IC4_1749739225
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

On Thu, Jun 12, 2025 at 3:56=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 6/5/25 1:35 PM, Eugenio P=C3=A9rez wrote:
> > QEMU's shadow virtqueue and VDUSE exposes these areas as read-only. If
> > we don't change it, vhost_iova_to_vva do not consider them as valid and
> > returns that they're not found.
> >
> > Fixes: eefac9536a90 ("vhost: postpone device creation until rings are m=
apped")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   lib/vhost/vhost.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
> > index 0353a04dc8..95a99bace6 100644
> > --- a/lib/vhost/vhost.c
> > +++ b/lib/vhost/vhost.c
> > @@ -497,7 +497,7 @@ vring_translate_split(struct virtio_net *dev, struc=
t vhost_virtqueue *vq)
> >       size =3D req_size;
> >       vq->desc =3D (struct vring_desc *)(uintptr_t)vhost_iova_to_vva(de=
v, vq,
> >                                               vq->ring_addrs.desc_user_=
addr,
> > -                                             &size, VHOST_ACCESS_RW);
> > +                                             &size, VHOST_ACCESS_RO);
> >       if (!vq->desc || size !=3D req_size)
> >               return -1;
> >
> > @@ -508,7 +508,7 @@ vring_translate_split(struct virtio_net *dev, struc=
t vhost_virtqueue *vq)
> >       size =3D req_size;
> >       vq->avail =3D (struct vring_avail *)(uintptr_t)vhost_iova_to_vva(=
dev, vq,
> >                                               vq->ring_addrs.avail_user=
_addr,
> > -                                             &size, VHOST_ACCESS_RW);
> > +                                             &size, VHOST_ACCESS_RO);
> >       if (!vq->avail || size !=3D req_size)
> >               return -1;
> >
>
> I propose below text for the commit message:
>
> "
> The virtqueues driver areas are read-only for the device.
> While they are exposed as Read/Write to Vhost-user and regular VDUSE
> backends, they are only exposed as Read-only when the control Virtqueue
> is shadowed by QEMU with VDUSE backend.
>
> This patch makes the backend to request these areas as Read-only, so
> that it can be accessed in all the configurations.
> "
>
> Also, as requested by David, patch 2 will be squashed into this one.
>
> Eugenio, is that Ok for you?
>

Sure, I'm ok with that.

Thanks!

> With above suggested changes:
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> Thanks,
> Maxime
>

