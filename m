Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3A606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VT0hVKn4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB3B40298;
	Wed, 18 Nov 2026 15:54:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id A81C040268
 for <dev@dpdk.org>; Wed, 18 Nov 2026 15:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795013669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orFMWaYdhfnJrtNB1gJW9Ke1hOP38qC3dN5+z6Wtl1E=;
 b=VT0hVKn4StZP/PAk7Bw16uhvmiQ57ILX/yPJPVTjQQJuToN2UsJcz0EevS+dp7uTApRNIZ
 0ItSmc10q6LKA2B6kdSOogZM2T0wlCjhzBKtFwTMCIdalg9p0Uqk6ibyOoesMNV1Wa/gec
 +nnQQukddQam7AVjvvQyKjanJFh6W6Y=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-_dpSme1qMHaGL6FiDHbK2Q-1; Wed, 18 Nov 2026 09:54:28 -0500
X-MC-Unique: _dpSme1qMHaGL6FiDHbK2Q-1
X-Mimecast-MFC-AGG-ID: _dpSme1qMHaGL6FiDHbK2Q_1795013667
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso1291839c88.0
 for <dev@dpdk.org>; Wed, 18 Nov 2026 06:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795013667; x=1795618467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=orFMWaYdhfnJrtNB1gJW9Ke1hOP38qC3dN5+z6Wtl1E=;
 b=vMbN+GEYVqxkLnowNEuNHkqO9U8luwPDe0JuVd6EGoftRFiIY9Rum+npMmHznzFoGv
 ei4JHekhD4G149Oq2Ux5K+AbqN6C4OYFeuhbcMS0bIJVNNG46oCfdpSTboEk6mUKL6rB
 TqwGhGBIIr8DGc9kbF5HUwB1r4dteCcEkmEynobTAQlFlJWYV73DEb7vyropUen+P7a8
 j4+nID99fWoJGOWEvzcnyrUdEmISSxlg+jGPAp4XoEg/qBuVRiqtgG3Fpzy7vjFrzy11
 vgWTvbiI1v1s1x0YMhH9MC2o48MS/KD1lRLVAVBwSafupDV1ECoewLJSDEtI0OOnzyEl
 Zikg==
X-Forwarded-Encrypted: i=1;
 AL+hErFiu/9V0bYTy2Et7ohSnnrIt3a5OXeNd5Etl4D0E83BGbbFO9wdVKuvaQ+SkgXFwN9/p+E=@dpdk.org
X-Gm-Message-State: APuU4Z9OmQF9Zl1Gl9W7PONKIfsdDPrl0fr1pr1QSPQBbXcQcOEFKhH9
 paR6KjzJujawhWtGn+0mRH5K4+wBaUy7ZaHQCnEBl/X9/5sGHL97q4x22g6BR6z18bSnwPo2tpB
 qH4/xuzwK5NWd4eVfeJdI01loeZjuFFU3SkL9YL9bKwQSUi3sjSjvg/H+8vuNvHqxDRZt1hSBq+
 jYG6LTYT5UdGPucbmBb1Q=
X-Gm-Gg: AYBFou2SOMKgDrpjAj6QFFPzpLT4VnfeQXyyDPxZLvkdqRma1b4S3viBAFSwZLWcR4S
 LhHifaNG8EA6H7sCftoxKT7EfokhjiAFu47525ipTt45wf5stsO78xfPlZEwRR50rutxWon5sdx
 jOfmOIwav7zuy3UIY8HkvH3IvZchUuxpBsPaOJpXx5s4PX5A9Y9hOCFu+OtZZx2OnYvIkAMEAS0
 s3RSnKZHEzc1sYyGf9JUqyQKyEh/haMMEFf0zLvjhbA5REGARJk+ccDSXGftJLC5ATQXtWGCW6J
 j+yj4sgfiIYsfLQp2ND1NY7WGkdOsepX/z9OmDQvsak=
X-Received: by 2002:a05:7022:7f12:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-1b543c1319dmr2373712c88.6.1795013666851; 
 Wed, 18 Nov 2026 06:54:26 -0800 (PST)
X-Received: by 2002:a05:7022:7f12:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-1b543c1319dmr2373693c88.6.1795013666298; Wed, 18 Nov 2026
 06:54:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118082752.1043794-1-iboukris@gmail.com>
 <20261118082752.1043794-2-iboukris@gmail.com>
 <CAJFAV8zBwu67PNKXTR9fWDPMEkpp_5dVLouufuEXs0eUGk5xQg@mail.gmail.com>
In-Reply-To: <CAJFAV8zBwu67PNKXTR9fWDPMEkpp_5dVLouufuEXs0eUGk5xQg@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 18 Nov 2026 15:54:12 +0100
X-Gm-Features: AclHuK84RkjLKPcwKRkzLIGFcagUctKRjRtNhuQb4QBh5RNLK-UrwAG-37L6OyI
Message-ID: <CAO55cszUCNX8VL5h2M=m26m=YpZ5jBHHRtYc=Her9kwHwfdgjg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] net/virtio: fix Rx interrupt setup with MSI-X
To: David Marchand <david.marchand@redhat.com>
Cc: Isaac Boukris <iboukris@gmail.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, Chenbo Xia <chenbox@nvidia.com>,
 dev@dpdk.org, 
 Aman Singh <aman.deep.singh@intel.com>, Luca Vizzarro <luca.vizzarro@arm.com>, 
 Patrick Robb <patrickrobb1997@gmail.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1lH1xUeFIpaAfceAJRFYWhSJy7FzZHy86L4gxWVEwhw_1795013667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 3:43=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Wed, 18 Nov 2026 at 09:28, Isaac Boukris <iboukris@gmail.com> wrote:
> >  drivers/net/virtio/virtio_ethdev.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/vi=
rtio_ethdev.c
> > index f2302089ee..8600f3899a 100644
> > --- a/drivers/net/virtio/virtio_ethdev.c
> > +++ b/drivers/net/virtio/virtio_ethdev.c
> > @@ -1455,10 +1455,20 @@ virtio_configure_intr(struct rte_eth_dev *dev)
> >                 return -ENOTSUP;
> >         }
> >
> > -       ret =3D rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_=
queues);
> > -       if (ret < 0) {
> > -               PMD_INIT_LOG(ERR, "Fail to create eventfd");
> > -               return ret;
> > +       /* On reinitialization, release the eventfds if the number of R=
x queues changed. */
> > +       if (rte_intr_type_get(dev->intr_handle) =3D=3D RTE_INTR_HANDLE_=
VFIO_MSIX &&
>
> This still does not feel right to me.
>
>
> > +           rte_intr_dp_is_en(dev->intr_handle) &&
> > +           rte_intr_nb_efd_get(dev->intr_handle) !=3D dev->data->nb_rx=
_queues) {
> > +               virtio_intr_disable(dev);
> > +               rte_intr_efd_disable(dev->intr_handle);
>
> So what happens here iiuc.
>
> For vdev, event FDs are filled by the driver (contrary to MSIX /
> rte_intr_efd_enable) in the virtio-user probe function for example.
> But we have an asymmetry in EAL, where rte_intr_efd_enable is not
> changing the handle for VDEV, but calling rte_intr_efd_disable breaks
> it resetting nb_efd to 0.
>
> Not resetting to 0 in rte_intr_efd_disable for vdev would break
> rte_intr_dp_is_en.
> And it probably has subtle implications on other part of this API...
>
> We should not be building a workaround in drivers, but correctly
> fixing this now in net/virtio is risky:
> - the virtio driver should probably not be calling rte_intr_efd_enable
> here in code common to PCI and VDEV ethdevs.
>   VDEV sets up the interrupt handle once and for all during probing,
> and PCI should be doing the same.
> - or.. calls to rte_intr_efd_disable are missing in the
> virtio_dev_init common code.
>
>
> Taking a step back now.
> The initial eventfd leak fix in EAL changed assumptions for drivers,
> with the expectation now being that the drivers properly
> enable/disable.
> I saw one driver (net/iavf) change on that topic, which is really
> little when compared to the number of users in-tree.
> We likely have bugs in other drivers that were not caught by validation.
>
> Given that we are in rc3 (rc4 by eow), I am for deferring the virtio
> changes to the next release and instead reverting the EAL fix in this
> release until we get a proper pass on each maintainer before
> reapplying.
> I'll send a patch in that direction.

I agree with deferring these changes to the next release, there is a signif=
icant
risk of regressions here, and the EAL changes being backported, could also
introduce regressions in  the stable branches.

Maxime
>
> --
> David Marchand
>

