Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1ACDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 09:56:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2316F402EE;
	Wed, 24 Jun 2026 11:56:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69344402EE
 for <dev@dpdk.org>; Wed, 24 Jun 2026 11:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782295003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ucavsAXpnbxKOVPv0UfnrOZJX8FcSXnS71z/vbSC2Ko=;
 b=DJ8wzgd9Skabl7GxUsvASRheeZ+XXsB/dd47cwPDa6eHeasIw/u/p7atzNo59cEE5CiKBY
 2uc7mxo0GB4wJVlo5j2/BCGAJbwsJLQVuI6OPAejvoXidcee+tyBccWfICGRwn6XCdiYJT
 aTbWjDv0l8rtKpaU24SbEEO7j3EaStg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-4CHdKiodNQ-T3Xrp3yAu0Q-1; Wed, 24 Jun 2026 05:56:38 -0400
X-MC-Unique: 4CHdKiodNQ-T3Xrp3yAu0Q-1
X-Mimecast-MFC-AGG-ID: 4CHdKiodNQ-T3Xrp3yAu0Q_1782294997
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa70838d02so586127e87.2
 for <dev@dpdk.org>; Wed, 24 Jun 2026 02:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782294997; x=1782899797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucavsAXpnbxKOVPv0UfnrOZJX8FcSXnS71z/vbSC2Ko=;
 b=C3UVnKQaTTjfy8kzNM9Xwk+apZcPZZqUAgPhvgYAi4Wx5d/YxMQ2d/wC4FOeYpOTEE
 9igp7Dcbun7vWdBLVppfrJjm2ke1powN+RNJ/fXZv6f796YDwjDSfZgixwb46jt+2EVR
 JH8W1zxWBs7hLeRNSVJluKPF0zSzHnWlHe+gMDoV1vcqWwl8pHdR+r+hke1gIdFPu3gX
 cxMULCO7v59+qqFiGrVBQPVWZKEAcK+gsEChQcKVeE7Tt/eINbAWob09zXphae/jrr8N
 NpQmgEniQ0TpO9hES2UcX1LMbNsfX2dfmcw5A/Jov9SBmG2ArIEnBnntyxcsdEJOx07D
 ZLjQ==
X-Gm-Message-State: AOJu0YzIaZV912NQyrKvNzxTZ34HNwIE0naRMZqlUg5O8zjCYsIDdA6i
 iohbz3KWlbXDXVZU7YgaCMuVGpIA+GERdOBXRxDbvHhDBg0e2a+Bx+NcERwZmqDvX7p2d6PxWeB
 yjW3XEGMZXK3ULlk0flLpw3Jxbh0Cj/T+0vY/OOGEbuPNlVWMZ7/fG+lLOHuVpuvHVqLxWrcUYk
 loZFmZ5kbPRSP/3VHPzZM=
X-Gm-Gg: AfdE7cn/KTfjrOtYzn5eSQjNPSwjj3ONQYW6RK8AvweQm2OMrBRbOw/OG/jMtWE4FIX
 tTgedytIGCHaWJkAgSir0XL0BfsEcx2k5gH2jKr89Je2YO/4nNSBif90FLEFGWdBMgYQyHgmw/C
 z1TUMFjh1j3vyYstjoAw3cndYBcM2DGXbLGst05NpnqS/qQ+Lz+UHj4FLq+oNdHfKW6rw6xfL7G
 20ZRm0bHuvm0eTz5IFFEiLVe+TSVh5A9meDo23RBpSNt5eTpznVR14INIY=
X-Received: by 2002:a05:6512:2c0c:b0:5aa:6d0f:d74e with SMTP id
 2adb3069b0e04-5ae9d56fe99mr711870e87.3.1782294997036; 
 Wed, 24 Jun 2026 02:56:37 -0700 (PDT)
X-Received: by 2002:a05:6512:2c0c:b0:5aa:6d0f:d74e with SMTP id
 2adb3069b0e04-5ae9d56fe99mr711848e87.3.1782294996581; Wed, 24 Jun 2026
 02:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-5-david.marchand@redhat.com>
 <c4c30773-40ad-4eca-a369-926886e17ab1@huawei.com>
 <CAJFAV8wGuVYfe7X857EauTHfeHaFEN8AFZteracs9OYFQpVN5Q@mail.gmail.com>
In-Reply-To: <CAJFAV8wGuVYfe7X857EauTHfeHaFEN8AFZteracs9OYFQpVN5Q@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 24 Jun 2026 11:56:24 +0200
X-Gm-Features: AVVi8Cf-U4U_C9HahV5J_gKu-_5FbldxaJW1Ki7jEVJjMY7y73EoMQh6nM_lBVA
Message-ID: <CAJFAV8zzTDx6rOWOTpbHMenPkNH_zVrnNJWJ8ZWbWt6BEgHn3w@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] bus/pci: fix mapping leak in bus cleanup
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com, longli@microsoft.com, hemant.agrawal@nxp.com, 
 stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7rsepRxyXoN7Rr_B_pArtMoBqPDNCVZ3XgBahiqQM9g_1782294997
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 24 Jun 2026 at 08:51, David Marchand <david.marchand@redhat.com> wrote:
> > > diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
> > > index fd18b8772b..791e9a7b49 100644
> > > --- a/drivers/bus/pci/pci_common.c
> > > +++ b/drivers/bus/pci/pci_common.c
> > > @@ -344,6 +344,10 @@ pci_cleanup(void)
> > >                       rte_errno = errno;
> > >                       error = -1;
> > >               }
> > > +
> > > +             if (drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
> > > +                     rte_pci_unmap_device(dev);
> >
> > rte_pci_unmap_device() also invoked in some drivers remove callback, e.g.
> >   eth_virtio_pci_uninit()
> >   ifcvf_pci_remove()
> >   ...
> >
> > In this case it may doulbe-free
>
> $ git grep -l rte_pci_unmap_device drivers :^drivers/bus/pci | cut -d
> / -f 2,3 | sort -u
> net/nbl
> net/virtio
> net/xsc
> vdpa/ifc
> vdpa/nfp
> vdpa/sfc
>
> Those drivers do not set RTE_PCI_DRV_NEED_MAPPING and have their own
> logic when it comes to mapping/unmapping resources.
>
> $ for drv in $(git grep -l rte_pci_unmap_device drivers
> :^drivers/bus/pci | cut -d / -f 2,3 | sort -u); do git grep -l
> RTE_PCI_DRV_NEED_MAPPING drivers/$drv; done
> drivers/vdpa/nfp/nfp_vdpa.c
>
> I suspect calling rte_pci_unmap_device twice will end up with some
> error before a double free.
> Worth a fix on vdpa/nfp regardless, I'll work on it quickly.

Just a note.
On the principle, the vdpa/nfp driver has a double unmap bug on device
unplug, regardless of this change of mine.


-- 
David Marchand

