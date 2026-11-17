Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC0606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HUNCs1/V
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92F02402C9;
	Tue, 17 Nov 2026 20:51:18 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by mails.dpdk.org (Postfix) with ESMTPS id EF7B1402BF
 for <dev@dpdk.org>; Tue, 17 Nov 2026 20:51:16 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so10943466b.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 11:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794945076; cv=none;
 d=google.com; s=arc-20260327;
 b=Y2QMFby0b08w2/rdzIwAdKKHMFlaanmaJm3JnWliHCVl6TOGMRkQuYd0A7s/JAzEVY
 jrGv1OsY3sZpEFca7Pj6yHze4FSMN+eJZ/I8Uhu7CbrpHGD6p7qPjMn8d7IlbnQn1AQX
 tFnEUSvFeD1Aj9IKhFbLMDkL4Rlo+kTthTQDj2m7KwhfqrdYku8ni2FbtOg83a6mG1oS
 cUdrWMXH5AUf0Td28kUNWIYfLODLAdzwRyAoI/iJMpcyYXiuKyZMbcJgbs1Ah8lBxOqE
 GJh6TLF8D1GzR3kyGMFVLyIgw9ThEyVIzrX9pPr0ZvP/eh6AA7wr8bpKSl1OipjMn8BS
 gKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HNGuZmaTEszQEJubdPl/OqcCnA/GN4V9ImR9FIgh+uw=;
 fh=hXaxD+23DhiDyZAj3l4CilxvwIsKEwORs7DBkLuQLjk=;
 b=EPOsA9VOG7SJ4f0xMafUcCQ8FxUISjJ0/QikHp7/meY2SEhmRr0JzDDLuygxhAmvAf
 9upeudKRPuhNcbcfQLTnU80PslRyuKFWVfqfr82sW7HlibEEzx2VnbWkXQEMMnYQkm5E
 T7uY/3cut253q0fWTNE5UMx++uArhAu77y72eEBk1FPK9vB9dTP90yqJnwvoxZuSrvSg
 6L3hB4oW8d759S0GwF+gnPSKVsjHTfR19mUpe2M/oDf9Xa5Tl5DB2CeRJEOotQzJZ9DE
 c2+AkWf5XRY1OeSwelIlKpEW6aCAmj0YAa+gCmJwpTevvXQvN60LBjrNBlAz6BjkCjgb
 WDSA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794945076; x=1795549876; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HNGuZmaTEszQEJubdPl/OqcCnA/GN4V9ImR9FIgh+uw=;
 b=HUNCs1/VSuqrwowx1XnUT5oOYZMmLOnXa1IFqun5EHpDQu+duiv/7vkkguoEBzh5h2
 CjpBtkFtrXoEfh+ulmmZLCWdtF3ezK+WMzG9TvATf+os+21aMvfyIZKr2rOVV5uH878o
 8h2vM2qPF7JM7+ziJtfdVS031OoZ3tGYYv6j3Eix3cEOvE1h5zoqAn2z/vHpyb9uXblb
 ilP87PuQGr9NTJb5jjx431P9cC0ZQvoOLxtx1beMVtktEh/1yhbYin8GRtauaOnKvbEM
 GHPwN/KxT+xjKrP68bmzxo22BGNrvk5VvFpAG2B3XhECEJotkt+Xnc4f8SVR7C99zb+6
 i2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945076; x=1795549876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HNGuZmaTEszQEJubdPl/OqcCnA/GN4V9ImR9FIgh+uw=;
 b=XMNxAK8eu0pXTQtdHrOzbG7BuXCwLlazeOUBoJJ0miJ9ZoyF9+zJIM7Rj4vV1FFImI
 zlOUh0pE/29tDauLFyBZf2phBTQcdGTQfvBB75/ICb1rJV1Z7LWkbQR76ka8eTAz+ExD
 gBv2BRXD6MuhxkGtYgWomN9jhKabrD1xPfY+jsd4eVI5Vv4SLBl/X+UXrdhabwjUWvZc
 CLieioTjfAfjFbKTHh1OlZdYHFcKftWC8ZpVN1f2yLUluTrk3fZXcKfHVhrM3ga08LKE
 rCIcmQLCbtYqkXw/Bxpiv7WhllSX414UJy9R3Y3a5jM8YJemnsz4aejPYR6AqZ7fW4Nj
 75hw==
X-Forwarded-Encrypted: i=1;
 AL+hErEtZFzPE2NkZyxzFRaU80UKrmU8m9oz6XehL3v3zzskckjaasrieq444L3ChrzRu73bm5s=@dpdk.org
X-Gm-Message-State: APuU4Z/HuGBnBj67qqR9nlEBDi28VaX1Xqd6B5l0GxerOaj9eP9j+a1V
 +RSLgZ44Qx13oFGxeYM/bF85TyDxwjT0qbmFTCv4p+r1HICo/c3IeUr2Ti2YsUvR0sKXPkDbgRD
 qlNrMFWPWy+BPp3XMWEaFVOAQg4vazNI=
X-Gm-Gg: AYBFou1WFuXB/SgRqPcCQegsaURFhC43dWnGRmn8QAYGQvnL+vLcW1Sb5ILVKRdwXXg
 rtrZSSSQoY07U+YvFp4GCc4Zxb+acmzcaSVVjOKQOUH7ZJ/Kk12f5KrUlEzh77OlDlN7hjVApuW
 Fi1EBff9lr0zgI6xuwXABJLAFW0uP6Iy6OQ0qtstjWCm0uQT9n+h0YsLjWubvdWid0svoZlL4jP
 uTlkBY2CqpAeay9BFxuk8PShzIJQP6XLeVqwNrDlHPCxZsth06HWUqF5aTTzQVMgEnZArZj6X3e
 Seud7abnHetNrrrYJqMysPR8U/4vCk45otS8GVPzhusMcyP9LE0b80OuWiclF9wPohkp7T8ORGh
 5SINCycVDwxsq46F/e03vODNQ0ax8lDRSHpdA
X-Received: by 2002:a17:907:c13:b0:c50:8d2b:4391 with SMTP id
 a640c23a62f3a-c510e3919e5mr26594866b.37.1794945076048; Tue, 17 Nov 2026
 11:51:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261117124303.717447-2-iboukris@gmail.com>
 <CAJFAV8zyPB1uqYmywdqzwBCO9mhXrpyEJLyPf8bELLSvFK-x1Q@mail.gmail.com>
In-Reply-To: <CAJFAV8zyPB1uqYmywdqzwBCO9mhXrpyEJLyPf8bELLSvFK-x1Q@mail.gmail.com>
From: Isaac Boukris <iboukris@gmail.com>
Date: Tue, 17 Nov 2026 21:51:03 +0200
X-Gm-Features: AclHuK81epQ1WZahWpmHH5JEn8oWgxIZsy4JEuw9_8BfvzHlpsD5WOZVZd9Wx1o
Message-ID: <CAC-fF8Tzs4q4xR7DsrPuC9gNM6YyOTH+55MH1oXX9q9exx5Aaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/virtio: fix Rx interrupt setup with MSI-X
To: David Marchand <david.marchand@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, dev@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On Tue, Nov 17, 2026 at 4:29=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> Hello,
>
> On Tue, 17 Nov 2026 at 13:43, Isaac Boukris <iboukris@gmail.com> wrote:
> >
> > With Rx interrupts enabled, configuring a port initializes the device,
> > and a second time when an offload or RSS is requested. Each
> > initialization enables the interrupt eventfds.
> >
> > EAL now refuses to enable MSI-X eventfds twice, so such a configuration
> > fails, and so does configuring a port a second time:
> >
> >   EAL: Interrupt eventfds are already enabled
> >   virtio_configure_intr(): Fail to create eventfd
> >   ETHDEV: Port0 dev_configure =3D -16
> >
> > Before that EAL change, the previous eventfds were leaked.
> >
> > Disable the interrupts and release the eventfds before enabling them
> > again.
> >
> > Do it for a VFIO MSI-X handle only, the type whose eventfds EAL
> > creates. The other type that gets here is virtio-user's: its eventfds
> > are the backend's call fds, set once when the device is created.
> > Releasing them would reset their count, which nothing sets again, and
> > registering an Rx queue's interrupt would then fail.
> >
> > To reproduce, with a virtio-net PCI device bound to vfio-pci:
> >
> >   dpdk-l3fwd-power -l 0 -a 0000:0c:00.0 -- -p 1 --interrupt-only \
> >       --parse-ptype --config=3D"(0,0,0)"
> >
> > Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interr=
upts")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Isaac Boukris <iboukris@gmail.com>
>
> Thank you for the testing and report.
>
>
> > ---
> >  drivers/net/virtio/virtio_ethdev.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/vi=
rtio_ethdev.c
> > index f2302089ee..37fc896fae 100644
> > --- a/drivers/net/virtio/virtio_ethdev.c
> > +++ b/drivers/net/virtio/virtio_ethdev.c
> > @@ -1455,6 +1455,13 @@ virtio_configure_intr(struct rte_eth_dev *dev)
> >                 return -ENOTSUP;
> >         }
> >
> > +       /* Reinitialization: release the previous eventfds first. */
> > +       if (rte_intr_type_get(dev->intr_handle) =3D=3D RTE_INTR_HANDLE_=
VFIO_MSIX &&
> > +           rte_intr_dp_is_en(dev->intr_handle)) {
>
> The rte_intr_cap_multiple() guard right before should enough (for the
> interrupt type check).

Actually this check was added due to a real issue with virtio-user
which also returns true for this guard.

> > +               virtio_intr_disable(dev);
> > +               rte_intr_efd_disable(dev->intr_handle);
> > +       }
> > +
>
> Can the number of rxq change at this point?
> I don't think it is the case.
>
> If it can't, why do we need to release/set up new eventfds?
>
> The fix could be a simple:
>
> + if (rte_intr_dp_is_en(dev->intr_handle)) {
>
> >         ret =3D rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_=
queues);
> >         if (ret < 0) {
> >                 PMD_INIT_LOG(ERR, "Fail to create eventfd");
>
> + }

I think it could change if reconfigure is called multiple times, i'll
try to test it but we could still limit iit to that case, which would
make it even easier on the caller as it doesn't have to get the new
efds if he didn't change rxq number (although for non-virtio drivers
one probably still have to).

> We could probably move the rte_intr_vec_list_alloc call under this
> check too, but iiuc, this helper does nothing when called multiple
> times.
>
>
> --
> David Marchand
>
