Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882E0D37E3B
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8A2840659;
	Wed, 14 Jan 2026 16:09:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43575400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768403387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1FzOXOLfLBCYc6dRPukxGKGDCeLgXc5gCK8Mm6asuQ=;
 b=Ikxl5ZZDsNFnrRBDqyLHk9ZbSPxsFLfc9+9SXlm5gtEe0lkv8ptgFpupZebOyeoY49Ds/A
 zvZPvuCe4/lqbEla7O57jPLCvGW7odwffdmKJv44X+sKomNuawXZIH39mqHY+5GCRJ1td0
 TTT+1XY/evF0urw1AJl8oWG4XvnYZu0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-C0uGnWplP6ijeK7nIm95KQ-1; Wed, 14 Jan 2026 10:09:46 -0500
X-MC-Unique: C0uGnWplP6ijeK7nIm95KQ-1
X-Mimecast-MFC-AGG-ID: C0uGnWplP6ijeK7nIm95KQ_1768403385
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b6849824dso6793495e87.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403384; x=1769008184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U1FzOXOLfLBCYc6dRPukxGKGDCeLgXc5gCK8Mm6asuQ=;
 b=Olgx3QbK9oS0MUA7oOQzcwSi1PauIYUvvi8Zm1Vv8r/WAE7ZEjY9F0r4nfafnTh2lT
 aSZSBhXdPEhPoS7OxYY8sOOmlAcy52+t7BFzms7tgZoXeyj/ihYIFJxwaNH5AR8iQwZm
 +RR1RkZhcKMh0hgtxzd+nAUtGZTOhaC2GUbecezkk542dnVZbAzqyEJXv0YA/7F5LXKu
 TjVY+IiDsT5BCxofbEBprwgjc/5vPKKm4U05bSB3Ai4utA5f7X0lpi22h597DX7pymIo
 IipsRzkVIz7pux4uofwjmVDpSth3EfUCiN6jI/cAYEQocbBPX9HAxRi+kNPliVIglNe/
 smTA==
X-Gm-Message-State: AOJu0YzekA5z82IGcVuT25fLwhR0VbuqSFHXXzchZa5Do+s2Vsqs6/P+
 1NalSiqSZSNMHK4qyhkdbgm13MFrID/9cf1dWxrmV0IbExOtITplEZ8jh5DvsGmYXZF0KA+qOfN
 hqJPsfmy+vucVEwy4/nMeyNzn3uPbFJcujeRabPBmvcjnJSBBfAFfKJwOfLJXlt3U/6lnZL+8SW
 +HbEYLew76DpqYeajG4tc=
X-Gm-Gg: AY/fxX5/5WO53qToBx9pT5NRbGG8LXliK9Uqjohgt3HEs4XXnpaRx8/AmwxwsMNnql2
 jwrFTlGR2sOfc52/WbDEpQz4BXZ9THbxxRrPAoj/c1xEElhwM5zBFk1J5il0z1DMuEcjwsMOEPC
 I6cmIaGe0GMYYCSiWxKanE7doS2Y6OCheaqAObHSfWGoopQhOkdyaretzzSBeNrACoWkP3Pr7o5
 ohDWD8GuMihSG+40SGbp3rATSfwqqqWDUk55jFdEitSkiZK1aRMpA==
X-Received: by 2002:a05:6512:61b1:b0:59b:9a9d:dc94 with SMTP id
 2adb3069b0e04-59ba0f6517cmr1014132e87.13.1768403384186; 
 Wed, 14 Jan 2026 07:09:44 -0800 (PST)
X-Received: by 2002:a05:6512:61b1:b0:59b:9a9d:dc94 with SMTP id
 2adb3069b0e04-59ba0f6517cmr1014114e87.13.1768403383504; Wed, 14 Jan 2026
 07:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
 <20260108134951.3857110-3-maxime.coquelin@redhat.com>
 <CAJFAV8yvYLMLO=fx36mnJ9sH+Xm_3yzxVoWAOHW8QhGUpnYbKA@mail.gmail.com>
In-Reply-To: <CAJFAV8yvYLMLO=fx36mnJ9sH+Xm_3yzxVoWAOHW8QhGUpnYbKA@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 14 Jan 2026 16:09:32 +0100
X-Gm-Features: AZwV_Qg1fXygoQ4Vs7bkYxHhMyjoHIK6Lu121BO-WkOR4OQbrGKYVKtuSDOsHWU
Message-ID: <CAO55cszQiN2cqSr18u7E_zapnkAQ5zoMgbg0WfnvcKd3G1MouQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vhost: fix descriptor chain bounds check in control
 queue
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Ed7JBsQFJZy6YhpcBUIfQI_25g5WPdvWAZ5gBRiAdE_1768403385
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

On Thu, Jan 8, 2026 at 3:53=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> On Thu, 8 Jan 2026 at 14:50, Maxime Coquelin <maxime.coquelin@redhat.com>=
 wrote:
> >
> > The virtio_net_ctrl_pop() function traverses descriptor chains from
> > guest-controlled memory without validating that the descriptor index
> > stays within bounds and without a counter to prevent infinite loops
> > from circular chains.
> >
> > A malicious guest could craft descriptors with a next field pointing
> > out of bounds causing memory corruption, or create circular descriptor
> > chains causing an infinite loop and denial of service.
> >
> > Add bounds checking and a loop counter to both descriptor chain
> > traversal loops, similar to the existing protection in virtio_net.c
> > fill_vec_buf_split().
>
> Too bad we have two separate implementations..

It may be possible to refactor into a single implementation,
but I was afraid of the potential performance impact on the datapath.

>
> >
> > Fixes: 474f4d7840ad ("vhost: add control virtqueue")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > ---
> >  lib/vhost/virtio_net_ctrl.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
> > index 603a8db728..8149885384 100644
> > --- a/lib/vhost/virtio_net_ctrl.c
> > +++ b/lib/vhost/virtio_net_ctrl.c
> > @@ -28,7 +28,7 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vh=
ost_virtqueue *cvq,
> >                 struct virtio_net_ctrl_elem *ctrl_elem)
> >         __rte_requires_shared_capability(&cvq->iotlb_lock)
> >  {
> > -       uint16_t avail_idx, desc_idx, n_descs =3D 0;
> > +       uint16_t avail_idx, desc_idx, n_descs =3D 0, nr_descs, cnt =3D =
0;
> >         uint64_t desc_len, desc_addr, desc_iova, data_len =3D 0;
> >         uint8_t *ctrl_req;
> >         struct vring_desc *descs;
> > @@ -59,12 +59,19 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct =
vhost_virtqueue *cvq,
> >                         goto err;
> >                 }
> >
> > +               nr_descs =3D desc_len / sizeof(struct vring_desc);
> >                 desc_idx =3D 0;
> >         } else {
> >                 descs =3D cvq->desc;
> > +               nr_descs =3D cvq->size;
> >         }
> >
> >         while (1) {
> > +               if (unlikely(desc_idx >=3D nr_descs || ++cnt > nr_descs=
)) {
>
> I don't like pre increment.
> Can we use post increment and stay aligned with known to work
> fill_vec_buf_split?

Indeed, I will change that for consistency.

>
>
> > +                       VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctr=
l descriptor chain");
> > +                       goto err;
> > +               }
> > +
> >                 desc_len =3D descs[desc_idx].len;
> >                 desc_iova =3D descs[desc_idx].addr;
> >
> > @@ -142,12 +149,23 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struc=
t vhost_virtqueue *cvq,
> >                         goto free_err;
> >                 }
> >
> > +               nr_descs =3D desc_len / sizeof(struct vring_desc);
> >                 desc_idx =3D 0;
> >         } else {
> >                 descs =3D cvq->desc;
> > +               nr_descs =3D cvq->size;
> >         }
> >
> > -       while (!(descs[desc_idx].flags & VRING_DESC_F_WRITE)) {
> > +       cnt =3D 0;
> > +       while (1) {
> > +               if (unlikely(desc_idx >=3D nr_descs || ++cnt > nr_descs=
)) {
>
> Idem.
>
>
> > +                       VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctr=
l descriptor chain");
> > +                       goto free_err;
> > +               }
> > +
> > +               if (descs[desc_idx].flags & VRING_DESC_F_WRITE)
> > +                       break;
> > +
> >                 desc_len =3D descs[desc_idx].len;
> >                 desc_iova =3D descs[desc_idx].addr;
> >
>
> I wonder if we are missing some call to vhost_alloc_copy_ind_table() as w=
ell.

We could do it, but I would not consider not doing it a security vulnerabil=
ity.
No out of bounds memory accesses can be caused by a malicious guest AFAICT.
Non-contiguous buffer is detected by length checking.

>
>
> --
> David Marchand
>

