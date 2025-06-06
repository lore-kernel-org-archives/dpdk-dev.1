Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3FC5B555
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 14:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D2624068E;
	Fri,  6 Jun 2025 16:20:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1E49C40283
 for <dev@dpdk.org>; Fri,  6 Jun 2025 16:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749219633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bf2jNE7MQKBTu/5aYhfW2Fd9g3GPdA+tPXNJT1+S71A=;
 b=XKw38X/r5cUOyu+h/Ee21/hBEYncCmTbHC+HG8BXqYbi/o2fHw2b0ar/vHJfErenYHN31/
 n6U4h+L2OlQDBOTfbl4rWmjHYpGn9qGcn7t8t6l6Lm2p7WnyMMS+MLYWAcUU7/wO5TZG06
 aA+woYkQUSO6ckVq/+QwnfPgiJqfNfg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-l_79zp51PqCcQg8N2m1PhQ-1; Fri, 06 Jun 2025 10:20:32 -0400
X-MC-Unique: l_79zp51PqCcQg8N2m1PhQ-1
X-Mimecast-MFC-AGG-ID: l_79zp51PqCcQg8N2m1PhQ_1749219631
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-55324bc26dcso1126783e87.1
 for <dev@dpdk.org>; Fri, 06 Jun 2025 07:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219631; x=1749824431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bf2jNE7MQKBTu/5aYhfW2Fd9g3GPdA+tPXNJT1+S71A=;
 b=ONw98GfAUYxf2rPi7h8bjeMAHDymrRcNCYrGA8S0I0ZNW+LLMFPszqogYv1iYbktnE
 UZQ1IJKfya7pMS5MBWH/rTa2aMAmhSFNg30Hzx71IjxaCpNjG4ZtX3QDCcsuhAwIuNHQ
 09XTfQdi9bg2CqpKRIq4XPvs15gqtPn9k8atc6P/beI2RXK+tcOGxHsvAqDl7gu8nyrq
 0aRI1AsEJG3TkoNcOS/BhmwCQgbn7hsa2hIYIHXJds14AOGNON77ji60PD5XL3WCD8D9
 kIhPjbb6Wk4pJI5Xm8gu7hIWUW66HK+JJrRPz1SPpY1M4AVxPOxGwfKveExAVNvt9VER
 vFMA==
X-Gm-Message-State: AOJu0YwaQk5dumiN6ZoL/YPXa6OrJOIjE8hZneEubEdJ7IlEIpq8bc9h
 QD1UwjhLyejWU2OjNTgA2r9Jmfmoxnx1EDZkMkbjTMEtfqmo3OTGGkbVbB8u9Cf+4lZBkXH/qIv
 n2JuI25Db4tvT8jhIca9FkPB3NINABDfyEKs1zPuZHokGOkZKCW8TmUn997AZXV2yI1WiTSFVQg
 5uzJGX2eLyF0LTovp6V7U=
X-Gm-Gg: ASbGnctKKYyy4rZ58pZZ5L2zS8cQgpBnmdcF1z+ylEK2dNfyVWBi6Ae698e9pMMpFVI
 gr6nmEAo6PuRutdCCiM0lGG26sY+s9Il+vVE6IeJmngEWWybU+zIvbKZIomYaAwEdpw5EddzPo9
 mIbFCJwQ==
X-Received: by 2002:a05:6512:2c09:b0:553:2308:1ac5 with SMTP id
 2adb3069b0e04-55366bd9a1cmr946592e87.4.1749219630734; 
 Fri, 06 Jun 2025 07:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu5zWQeVqwD7uo2EZ3VDL0T2lp7vtuIkB3UZ+rI2nBCgQrtkd8gw+u7By37ikqOj+kt5rQfj5sbLxJUFBKHv4=
X-Received: by 2002:a05:6512:2c09:b0:553:2308:1ac5 with SMTP id
 2adb3069b0e04-55366bd9a1cmr946582e87.4.1749219630313; Fri, 06 Jun 2025
 07:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250605113552.918120-1-eperezma@redhat.com>
 <CAJFAV8ydHHbbtOYLq4dr+g9qPh52EnNEZU5kieNAY4_BPfsO2A@mail.gmail.com>
 <CAJaqyWf1DMkdf-UNVOpbeqDA0CvMjnWoZ-CDcvFzEeO-1re7Ow@mail.gmail.com>
In-Reply-To: <CAJaqyWf1DMkdf-UNVOpbeqDA0CvMjnWoZ-CDcvFzEeO-1re7Ow@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Jun 2025 16:20:17 +0200
X-Gm-Features: AX0GCFujhci4ANrxwGrxqDiVFLNutZjtNOHR8QKIYK_JRWf93VpUzdnZVMqxv2w
Message-ID: <CAJFAV8wnM+xNLrUbuYbJ7cJY+ZRKN5VcnBKwOtc_HHxj-YoaTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Search the split vq desc and avail in RO areas
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jXqftwYxzqOq97_IFwTicetCbhVLxugSbP2CkVMsrFY_1749219631
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

On Thu, Jun 5, 2025 at 4:55=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Thu, Jun 5, 2025 at 1:50=E2=80=AFPM David Marchand <david.marchand@red=
hat.com> wrote:
> >
> > On Thu, Jun 5, 2025 at 1:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > QEMU's shadow virtqueue and VDUSE exposes these areas as read-only. I=
f
> > > we don't change it, vhost_iova_to_vva do not consider them as valid a=
nd
> > > returns that they're not found.
> > >
> > > Eugenio P=C3=A9rez (2):
> > >   vhost: search the split vq desc and avail in RO areas
> > >   vhost: search the packed vq driver area in RO areas
> > >
> > >  lib/vhost/vhost.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > At a quick glance, no need for two patches.
> >
>
> Sure I can respin with both squashed.
>
> > Sorry, the implication of this issue is not clear to me.
> > What is the impact from a user pov?
> >
>
> QEMU maps the CVQ descriptors and avail vring through as read only
> maps in the case of vDPA. But DPDK is looking for them with RW
> permissions, so the vhost_iova_to_vva function never selects the right
> one as valid.
>
> Looking for them with RO still picks the map if it is mapped as RW,
> but the reverse is not true.

Ok, thanks.
Well, it's better, but still hard to tell how this impacts existing
usecases :-).
After discussing with Maxime, I understand that the shadow CVQ just
can't work =3D> blocking multi queue support with vduse for example.
This is the type of high level impact I was looking for.

> Let me know if you want me to respin the series with this comment too!

Ideally yes, but maybe Maxime can do it when applying.


--=20
David Marchand

