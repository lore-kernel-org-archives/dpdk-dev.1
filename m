Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA407606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V/0ZDGvS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFFB7402BF;
	Wed, 18 Nov 2026 15:42:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A7D040298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 15:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795012977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRmUxZOr0ZHVvntFEyY6ffg2MW8LuF6MmPIfGTPX7rg=;
 b=V/0ZDGvSUmiU5lnTU1+pdrAT3XWFC74lgA1GyuTAxlYah3EH3tWe6yfCHpWgbvxUQz0Ceo
 EAvZTEzjUHtS7GcoXiMBOb1YvmFypqm10Oj11mrX5+VosX1Q2X7NNOtkSO7IC58pXxXbNu
 R5v1DWUuwzUJhR3p5EltfkeYJlgVurQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-XdT0v2IWO0eEtVOJR-7iCA-1; Wed, 18 Nov 2026 09:42:55 -0500
X-MC-Unique: XdT0v2IWO0eEtVOJR-7iCA-1
X-Mimecast-MFC-AGG-ID: XdT0v2IWO0eEtVOJR-7iCA_1795012974
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5bff05f73c9so364727e87.0
 for <dev@dpdk.org>; Wed, 18 Nov 2026 06:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012974; x=1795617774;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iRmUxZOr0ZHVvntFEyY6ffg2MW8LuF6MmPIfGTPX7rg=;
 b=2bYHZa30qKd+9dDsURp7N48ZgSZ81ULonFXS26WOdIyprzxl7c82pTCsYI3DhYeKYo
 +LX0BGUYX6sAEi+4qU5vhVfgGafygDGTHt5ew1AFbJMunewBwtW3jAuutF9CSXhYjj+P
 zlEqCXOqTKucTrHPHIF0JlGoA4B+QJd4NtX1+UpvTFkupoP5fgNJydDEYOAfRF45s+ZC
 KIqq1Iz9atMg05cJ0jyZa3XVSvEk6aqygPq3Jw0YnjD1WuUhCV9VjG43O7ZCIrj/2m7F
 JZOt19O300RBzUWzIDaSwViGRPysbfmMcnu5Jsg5b/imleiy9XSzDlHNmfH6XtNK5Fin
 WmHA==
X-Forwarded-Encrypted: i=1;
 AL+hErH7D+1j1xjMdZSakwv4T+NPbhlCZt4NKyLdNfbnIwz7Ug5xA3OZJ7GolVcuo4l0AJ/VSjc=@dpdk.org
X-Gm-Message-State: APuU4Z/FfdJNZMhEXmKzQXrYRNCpCqC8eL8a2bCbdkyNcPwtAYdItaAq
 1BC2qw5hT0vZ0cMQ2+j22LlbzldkOMz+zBJqSgyTQ+tsPhIRRulp3rJ/7Mfo6kL6Ta6XfwExT6+
 /xeYDN1+GhECChntsBnAhzvqVCimz51ogqJBzbriWosxQKgRgSNg7ZjL2Zj77F1nrWq/c8KuFTk
 9zjxJXrV/ylCUOS+lIHUg=
X-Gm-Gg: AYBFou2/t7vJ3++lKw6gJTs52kov0wiS/kq8Tw3mq4XUTlbYCoppv/jMjJnZS5sWHjK
 cR5WqXtCTY7u/6DIGbR0KCYH4YkLcmWmd7xa9J9g0ARCSfosPePHtwSo9rkgX9YKj5De3NnVzTG
 2Ddp/rA6lMxygKNkq5MUlBTIkJycWoTCTeDPd88XLBRR2ardmlyWUuIUDVZxQy40ohqLxUhUDtn
 aqB4f6LGO247xivBM8MgF5MNEEIoZe2hO1Yx1FeHsXt2FHd
X-Received: by 2002:a05:6512:2314:b0:5be:4d35:c4c1 with SMTP id
 2adb3069b0e04-5c1a9bece7dmr1007470e87.12.1795012974182; 
 Wed, 18 Nov 2026 06:42:54 -0800 (PST)
X-Received: by 2002:a05:6512:2314:b0:5be:4d35:c4c1 with SMTP id
 2adb3069b0e04-5c1a9bece7dmr1007461e87.12.1795012973682; Wed, 18 Nov 2026
 06:42:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118082752.1043794-1-iboukris@gmail.com>
 <20261118082752.1043794-2-iboukris@gmail.com>
In-Reply-To: <20261118082752.1043794-2-iboukris@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Nov 2026 15:42:41 +0100
X-Gm-Features: Aa3M54qsOuaD00iWqrs016VGICuy_9ptSIOHGOGwH5EY5uKxVH2OtR1CMeYfdzg
Message-ID: <CAJFAV8zBwu67PNKXTR9fWDPMEkpp_5dVLouufuEXs0eUGk5xQg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] net/virtio: fix Rx interrupt setup with MSI-X
To: Isaac Boukris <iboukris@gmail.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Chenbo Xia <chenbox@nvidia.com>, dev@dpdk.org, 
 Aman Singh <aman.deep.singh@intel.com>, Luca Vizzarro <luca.vizzarro@arm.com>, 
 Patrick Robb <patrickrobb1997@gmail.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2jUWAh24DZy_PZMcxoNy9VCB2689VIH_t4NWGPelZ1k_1795012974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 18 Nov 2026 at 09:28, Isaac Boukris <iboukris@gmail.com> wrote:
>  drivers/net/virtio/virtio_ethdev.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
> index f2302089ee..8600f3899a 100644
> --- a/drivers/net/virtio/virtio_ethdev.c
> +++ b/drivers/net/virtio/virtio_ethdev.c
> @@ -1455,10 +1455,20 @@ virtio_configure_intr(struct rte_eth_dev *dev)
>                 return -ENOTSUP;
>         }
>
> -       ret = rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_queues);
> -       if (ret < 0) {
> -               PMD_INIT_LOG(ERR, "Fail to create eventfd");
> -               return ret;
> +       /* On reinitialization, release the eventfds if the number of Rx queues changed. */
> +       if (rte_intr_type_get(dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&

This still does not feel right to me.


> +           rte_intr_dp_is_en(dev->intr_handle) &&
> +           rte_intr_nb_efd_get(dev->intr_handle) != dev->data->nb_rx_queues) {
> +               virtio_intr_disable(dev);
> +               rte_intr_efd_disable(dev->intr_handle);

So what happens here iiuc.

For vdev, event FDs are filled by the driver (contrary to MSIX /
rte_intr_efd_enable) in the virtio-user probe function for example.
But we have an asymmetry in EAL, where rte_intr_efd_enable is not
changing the handle for VDEV, but calling rte_intr_efd_disable breaks
it resetting nb_efd to 0.

Not resetting to 0 in rte_intr_efd_disable for vdev would break
rte_intr_dp_is_en.
And it probably has subtle implications on other part of this API...

We should not be building a workaround in drivers, but correctly
fixing this now in net/virtio is risky:
- the virtio driver should probably not be calling rte_intr_efd_enable
here in code common to PCI and VDEV ethdevs.
  VDEV sets up the interrupt handle once and for all during probing,
and PCI should be doing the same.
- or.. calls to rte_intr_efd_disable are missing in the
virtio_dev_init common code.


Taking a step back now.
The initial eventfd leak fix in EAL changed assumptions for drivers,
with the expectation now being that the drivers properly
enable/disable.
I saw one driver (net/iavf) change on that topic, which is really
little when compared to the number of users in-tree.
We likely have bugs in other drivers that were not caught by validation.

Given that we are in rc3 (rc4 by eow), I am for deferring the virtio
changes to the next release and instead reverting the EAL fix in this
release until we get a proper pass on each maintainer before
reapplying.
I'll send a patch in that direction.


-- 
David Marchand

