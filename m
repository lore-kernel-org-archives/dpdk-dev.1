Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D557606A325
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJTdPC26
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8184B402CE;
	Wed, 18 Nov 2026 19:48:05 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by mails.dpdk.org (Postfix) with ESMTPS id B71484029D
 for <dev@dpdk.org>; Wed, 18 Nov 2026 19:48:03 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c50a4a2132cso187163166b.3
 for <dev@dpdk.org>; Wed, 18 Nov 2026 10:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795027683; cv=none;
 d=google.com; s=arc-20260327;
 b=hJDUPVlHSvtltBVdzFZbMQH4q6/KZirme+pHdY297jBCl3jGb5BcPOC3lwjSZV/icU
 zO8QwV25RRsXYTyr7pg0hXENZMv1nqfCatcq8ZnWQ+T8pFZZPrAwU1yBp/37ICje947p
 bB9UOcMJLhY2/d+sUHdKFmbS0mBkkP1oB+Tpj+cOxoD0yfBBz6aiFwamhWIw/nlJw/Jn
 qykeHxue16CRzp01g/J7EhjmPYVRh52weuFo3iIqjC8K3Ejklbfxzs/rGoBShZqt0ho0
 zgAGyhaSiZP1LrUi3agZwd8W9bm8WcNKIPNcPWXe3uP81MLrb4oJs6sT4DbVsZDiG3eq
 daHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QK/N9XR4nXkNNgUnWdZAV1xJmpCw4nZtUQqQhXXn17I=;
 fh=H6pSiQj6muYXHbIYv4oQXBfG6vnPSLsH0/i+8DKC8PY=;
 b=f5mjiCLUNvuDxekmLl85Z8MUlak/RSDhTF3+lx2Q2R7mifFqJk4y2AMDgytpeAbH/L
 iOwJv75t1YqBspo60uMrVEq74gXqBRmnBtQWIYCj7s1SfJrxlR4Rhi/gwSYRuBShFzpP
 c1wLwg33+FFuiioGRQeARetxM7Z1LoTLtqBkWampOjm5oXYGTg/JQLvKyMf7NMkQ3+7y
 iES5COTWrL5QIbX5bqEZpOrns0OXd7O4OgPN3pjfp4IpB/SSh1ttLAzInQ4hXg70bRBD
 nCU8HiBlZ62YFIymmmvpGY3zG93FSv7EM/rorHk1PWrfSMRbAZNGcyodqL39OLD2CtPG
 QYaA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795027683; x=1795632483; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QK/N9XR4nXkNNgUnWdZAV1xJmpCw4nZtUQqQhXXn17I=;
 b=DJTdPC26g4nSFDrZMZMRK2b/MYI8uObdcRGtu2b3e/ayUI1wTCqREgpc0Zp68Cpp9L
 NVxRvOBItW8FXiURXuvz7bkVAk3/CC1NOsfYJu3bjxfzP2VPFf8mwJ5Aqs9E+cUHHpqv
 JatV7/LShwwZD5UYe8erhxXKQzCrOi8yERKdYIp/Ko4uEjVcRdShnuvfPt4WOz1z2e0Q
 hRV3/w6lrVMBc1JmMWc8b1DOzFLSA7EB9QeiyTKbVydlt+orBiaP4UUK4k4sB2bLJ4SR
 4iVqVOZHnIurtrUWD4nAvR+nksloL8x+vz+Nv5f4lOt91Gi915/aszNOtF/nuCneFfH9
 ccHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027683; x=1795632483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QK/N9XR4nXkNNgUnWdZAV1xJmpCw4nZtUQqQhXXn17I=;
 b=Lht3knhsurBrSd7Rt9nj5NnwIULtmuZyByVnIzcNeKKwwP1N2bCsBCcfu1nJOoCNPg
 gZg7t4tPZd4JHfe8QN4vZYMN+lDHcjhi14Mb0wLCpNC71Kx2cwBsd/D20WX7T3AHKrGa
 bu/Jzq5PZiBtOc+oHYmHKLcjxmc+FjaloFw+PPRU2FgLxY1MDe39NV3XwjDhEJ4ubKrA
 Cdf4PuQAfZfhSlrtaAQnVJJfwLFfiNs4H8sPA6JSCrbloiXPsu2hXgxVMlztDGmh29/v
 2MPfPcVza0t3ZYpX5GazsVpmsQZ9/3Eiv5TdekX3h6ZV7JCLg1GWKmOON3TVJsUE/DoQ
 Sk0g==
X-Forwarded-Encrypted: i=1;
 AL+hErHzfC9vDLp6cRS2PvBqddrxZHscsvrorFHTqBk+zOA4Q/uA71QefFAYyPlZizEvPc/xArs=@dpdk.org
X-Gm-Message-State: APuU4Z+N1taXRjQijlhEUxGSZmaA8+lQAwnXcjUhCjt57OspZ2+4F3Tl
 TLFF1duWVJuGqu78DHBnfkme+uiAKjuwxpGjnHAC+OmctfxT661xguerfE7V94AZ6fGHVNm76oC
 fGFDY65b46qWOdn6rcJ1g//Xdlep5WnA=
X-Gm-Gg: AYBFou2JhfIJ08Qd545xfhc2NiZkjODm20pcvnZc6jMilyGdOjK+N90NqFLmvuzCIj4
 zaUaoYQ62fqyTzuEDw7G79nWpfRMdujUP/wbaXrRpWKRRqvMGK4+lzwRR9xzoz7SYLVEgXAln3f
 AN6vizqJ7bCaAshDyyS0uy2XZ3qrh3plkKKedq/8i5QnCefbtEe/789zGJj+PmDgVDZT29OJP9O
 x6TqXtexcq54Na4bBt3d6g/SgaZZGJ0U0bC2kLpfgwOaZCjIeVE4ioXxkaP+L17Kj3Pte9EnBKm
 RN1heCrCTG/NTu2mI/uTNLO2IMKMGqZSV1UEYE0I4nYGNK63tEYnvkj6mjQW7BP7AcOfrMahUQW
 ndODsMb6kgsGypjJaAzC/9Fl8W8zPUXxvNmM3
X-Received: by 2002:a17:907:9304:b0:c4d:212a:192a with SMTP id
 a640c23a62f3a-c510e520f80mr345570166b.48.1795027682884; Wed, 18 Nov 2026
 10:48:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118082752.1043794-1-iboukris@gmail.com>
 <20261118082752.1043794-2-iboukris@gmail.com>
 <CAJFAV8zBwu67PNKXTR9fWDPMEkpp_5dVLouufuEXs0eUGk5xQg@mail.gmail.com>
In-Reply-To: <CAJFAV8zBwu67PNKXTR9fWDPMEkpp_5dVLouufuEXs0eUGk5xQg@mail.gmail.com>
From: Isaac Boukris <iboukris@gmail.com>
Date: Wed, 18 Nov 2026 20:47:50 +0200
X-Gm-Features: AclHuK9gLux-pon0vJo7XLsmgVF5PI5CPZo6eQ4lZOw8w46T6_yfrW05XoLNIPI
Message-ID: <CAC-fF8TGjZCxz7JWGe6vC+ZhFkLDf7DQ4wXkXwbO0tzZVPHTOQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] net/virtio: fix Rx interrupt setup with MSI-X
To: David Marchand <david.marchand@redhat.com>
Cc: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Thomas Monjalon <thomas@monjalon.net>, Chenbo Xia <chenbox@nvidia.com>,
 dev@dpdk.org, 
 Aman Singh <aman.deep.singh@intel.com>, Luca Vizzarro <luca.vizzarro@arm.com>, 
 Patrick Robb <patrickrobb1997@gmail.com>, stable@dpdk.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 4:42=E2=80=AFPM David Marchand
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

Yeah, I reckon it is sketchy.

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

Then perhaps it should set max_queue_pairs, or max MSI-X vectors if it
can be less.

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
>
>
> --
> David Marchand
>
