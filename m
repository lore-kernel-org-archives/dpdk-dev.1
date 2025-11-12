Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD14CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 08:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C4A240280;
	Wed, 12 Nov 2025 09:56:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E2B314014F
 for <dev@dpdk.org>; Wed, 12 Nov 2025 09:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762937815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/5GJ1MfvfYb52RszTsv8TvtL70/U3j0OR/BIumQk1E=;
 b=WPMUb9GXEQ3DeJYUEc5T15HJ24Sw6P6HaRuAS83rPZuTDXhfPTh/s0F0gUuc9jBOFCgUXv
 E3gw3+VF390QkI5NKuesZ1/Mv1R+poXXRz5RTC9Cc3q6JyT5HUOzPj0WidGNe5te881khO
 kiu4PGU/B2wqUCsq6jXK0+NwEjcPreA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-jTWl7fs3O6CQ37zYVrykxQ-1; Wed, 12 Nov 2025 03:56:54 -0500
X-MC-Unique: jTWl7fs3O6CQ37zYVrykxQ-1
X-Mimecast-MFC-AGG-ID: jTWl7fs3O6CQ37zYVrykxQ_1762937813
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-594296f4b23so273403e87.3
 for <dev@dpdk.org>; Wed, 12 Nov 2025 00:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762937812; x=1763542612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F/5GJ1MfvfYb52RszTsv8TvtL70/U3j0OR/BIumQk1E=;
 b=q08JWkP5od0+EwCy3t1iO98SrVS2grQ/ilQ7/nPuZVH9K1nj9aHRA2xUDnbHvSebL0
 LMc6TDkUhD/yYAUPjuiP2vcDMkiqdYX7OC2m1ecChTtqaD70onjYCe9Fk+GNGUwyHPGj
 KyqhH4NNk+JgniLE5K/5gP4tM2lkCO8PXzZVHK8bq4LkXCknLKyeCZUNIcgytymrQtF+
 5X9AOlg1Bt4S+7dbHbsCkgKC7XyKgcihjZANXLQQGPv80r6olOtzmacUWh5U+G21DFnh
 Begp8h6HR1pz88hSl61b1upfOJyoHhbyN9vbobzhv9K34YIEnY3Rbem7DYUBHuLaXOWa
 Zx8w==
X-Gm-Message-State: AOJu0Yxu4ceUqT/C4Xhs7Heo2PnTsHrN0B0qu6+5rhcTGAAffZi97zfN
 VC6Lp0WZa6LHnfPRfjerO/B1M+TcMsc10NRp1JojQ9B/1kHp5Oc3DF5+gt/x+2ur0qfyR5Pymja
 VzhcQJKrL32hAr1rJg5hj9vXzoAcAj6mAldRu1QNQLZcd3xf8qsii+w7wB46SMtOnW10Ei+nV6A
 fPOz+dlN1MGf8AB/76MHk=
X-Gm-Gg: ASbGncvYil3grGmF/WYgga0dn/T2yzF+unPeaZXg3zZB3zloIBD95HPBwINkFtJYNAF
 jMtcVtEtcaInID/cfSQYhiX+wfTCl+j8W/2qWH7P2hVEo2wrI5G41hmU0rpWmVwmu9qaYY4RkBQ
 4VKchyjOHZcn728nNpTN//rRkZFRlCrqxlDHanL5hW0v5Nn+AIVpvi7YTFgQ==
X-Received: by 2002:a05:6512:39c6:b0:594:3340:1b77 with SMTP id
 2adb3069b0e04-59576e02c62mr591716e87.1.1762937812436; 
 Wed, 12 Nov 2025 00:56:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdYzvP+48Sryy7JE+J0u5AAaFsoTushaafxrHDU/ORUFoHwAbDRa+CUDStto71Wp0l5EEPey73aPQ3Z7fixAM=
X-Received: by 2002:a05:6512:39c6:b0:594:3340:1b77 with SMTP id
 2adb3069b0e04-59576e02c62mr591709e87.1.1762937811976; Wed, 12 Nov 2025
 00:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251108153207.1512863-5-david.marchand@redhat.com>
 <CAHHRULVe39Hq3ebQJVMfSfBMppEgZX0gmdzSqGoXNJWK5QtGGg@mail.gmail.com>
In-Reply-To: <CAHHRULVe39Hq3ebQJVMfSfBMppEgZX0gmdzSqGoXNJWK5QtGGg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 12 Nov 2025 09:56:40 +0100
X-Gm-Features: AWmQ_bl6xUyYHHBkXGkkyEATv8SUQFH4sWkVyl_ToHUJMVCQWWjCd5l9-puE-3o
Message-ID: <CAJFAV8x4+2pwC=_NGM7J5ikyCY2tLAaQhS2uHLTG-_mShPAHEg@mail.gmail.com>
Subject: Re: [PATCH 4/5] net/dpaa2: remove ethdev device in bus device
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 85lIzRTDAWItuY75dijdb2mhni_FB2x9dyhXBXzxdkw_1762937813
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

Hi Maxime and Hemant,

On Wed, 12 Nov 2025 at 09:44, Maxime Leroy <maxime@leroys.fr> wrote:
> Le sam. 8 nov. 2025 =C3=A0 16:32, David Marchand
> <david.marchand@redhat.com> a =C3=A9crit :
> >
> > Calling rte_eth_dev_allocated() is enough to retrieve the
> > ethdev device object.
> >
> > This leaves no user of the ethdev field in the fslmc device object.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/bus/fslmc/bus_fslmc_driver.h | 1 -
> >  drivers/net/dpaa2/dpaa2_ethdev.c     | 6 ++++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/b=
us_fslmc_driver.h
> > index efa88754a7..094f885f59 100644
> > --- a/drivers/bus/fslmc/bus_fslmc_driver.h
> > +++ b/drivers/bus/fslmc/bus_fslmc_driver.h
> > @@ -98,7 +98,6 @@ struct rte_dpaa2_device {
> >         TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 devi=
ce. */
> >         struct rte_device device;           /**< Inherit core device */
> >         union {
> > -               struct rte_eth_dev *eth_dev;        /**< ethernet devic=
e */
> >                 struct rte_rawdev *rawdev;          /**< Raw Device */
> >         };
> >         enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
> > diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2=
_ethdev.c
> > index 7da32ce856..2a26a02cb4 100644
> > --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> > +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> > @@ -3320,7 +3320,6 @@ rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_dr=
v,
> >
> >         eth_dev->device =3D &dpaa2_dev->device;
> >
> > -       dpaa2_dev->eth_dev =3D eth_dev;
> >         eth_dev->data->rx_mbuf_alloc_failed =3D 0;
> >
> >         if (dpaa2_drv->drv_flags & RTE_DPAA2_DRV_INTR_LSC)
> > @@ -3349,7 +3348,10 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_=
dev)
> >         struct rte_eth_dev *eth_dev;
> >         int ret;
> >
> > -       eth_dev =3D dpaa2_dev->eth_dev;
> > +       eth_dev =3D rte_eth_dev_allocated(dpaa2_dev->device.name);
> > +       if (!eth_dev)
> > +               return 0;
> > +
> >         dpaa2_dev_close(eth_dev);
> >         dpaa2_valid_dev--;
> >         if (!dpaa2_valid_dev)
>
>
> dpaa2_valid_dev is currently incremented in rte_dpaa2_probe. With your
> modification, dpaa2_valid_dev will never be decremented in
> rte_dpaa2_remove if rte_eth_dev_close has already been called.
> As a consequence, dpaa2_tx_sg_pool will never be freed.
>
> I don=E2=80=99t think dpaa2_tx_sg_pool should be freed in rte_dpaa2_remov=
e; it
> should be freed in dpaa2_dev_close instead.
> For symmetry, dpaa2_tx_sg_pool should also be allocated directly in
> dpaa2_dev_init.

Indeed, moving the dpaa2_tx_sg_pool handling in dev_init/dev_close is
more self contained, and looks cleaner.

Now, taking a step back, I should not try and fix the bug you guys
have been working on.
IOW, the check on !eth_dev in this patch of mine is unrelated to the series=
.

I'll respin a v2 shortly, that focuses on the layer violation only.
For you guys to fix the double close bug.


--=20
David Marchand

