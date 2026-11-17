Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93D606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mjtc2xDt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD61C402C3;
	Tue, 17 Nov 2026 15:29:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 01AE0402BF
 for <dev@dpdk.org>; Tue, 17 Nov 2026 15:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794925782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KC34jTqnTJZ7cN5vMptLYlgVPGyTO79EiwBLm6+C18A=;
 b=Mjtc2xDt56HwJKkwqORiJ+U8RN/kCYzdTkZAK2yj0XmjxqXI8c8q8F//YhyR9ZgX0dr/RW
 iyJb5T6HNhu7a8DmytIJ08BxaXzEmbC2ZZTk5wqjVbH6tdII/aDjvdCymNQvpuaD5hGTvk
 QN5wu+TOmAPrbxwV7x2nrIY0A6nZMNI=
X-MC-Rep: binary re single
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-qqHFGsvjNOGqhXG-D6j72g-1; Tue, 17 Nov 2026 09:29:39 -0500
X-MC-Unique: qqHFGsvjNOGqhXG-D6j72g-1
X-Mimecast-MFC-AGG-ID: qqHFGsvjNOGqhXG-D6j72g_1794925778
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3adfb79d9acso21112001fa.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 06:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925778; x=1795530578;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KC34jTqnTJZ7cN5vMptLYlgVPGyTO79EiwBLm6+C18A=;
 b=c4CLhDQFsj+JPKTRPdI7kxG9hGTyc1s0H7HlMAE6s8m3ejncXxyds8ONq62/Nbflv9
 atTBl9pOkiMfKyekV8ewG37z7iigSyGP6YFSjg3605lhGageQPtSH7aZ15ZU9yUqlhWS
 TdX/vBf38Y4nM39RJowSvDN+fuJH6CcNK7eHlnlOdAKiSsjHnvkjQw2A0xzBvvYIBam+
 L5luyuT0esCUvg75NpI2ZdXHnApWMhdXEYt9Jkc9B3fXNCm8TP2vIMfvCXahbQURWYBd
 5rJi2DRN/8dnMikEgNR5kCcS+kGQZBMYoI/92Oblaa3KvFpamS5XzzNHyUbSYlEJjXvr
 HJOA==
X-Forwarded-Encrypted: i=1;
 AL+hErEE+O5D0ANrAOOQ2yPhFzvswKi3Ojs0JDg258sSouSsZ/lXl5+g3L1lPV0nDfBTxdHgbEU=@dpdk.org
X-Gm-Message-State: APuU4Z+dkPsyOBtncf+OXLRP2v8p6RsbBjIndoevnCO6ynsANcx+D34h
 9gi4iisPHEPPQuMPfGag5AXnxvm0VCroQUJ+coIR1OM6i4bHWePRlSj+MKpgt7FwbYarjFsxGhG
 v0jLq3mJTxEWTH+DOxf9csS8ILUdLScM3+lHl7oYnkINtEBW7MMy1mXj5hs6+nG3qoxHIYVfyzS
 Z1zsAwjKonqSFT88bg++U=
X-Gm-Gg: AYBFou0inUyIEc6QAou072Dt+2F+VjeLIMlZPsio7SDd16X77cS2mCnZ+t04JA6+LpP
 IdRwAlGU2COSfESqLbHa8tipMQol8DQ4YIY4BQGMVbw8on64iZUmFBmMKY0TAfRXycH/xu5QKi6
 Te1o0hWVB0gjExGBB0HINj3T04FtDy/WA77ePq/fpDtnhgI8zl5guNLGpgE2FxpjzohPcBHpEUq
 uEQVpMuzrCdMNJim04o60PV7/qul7OAMmbC3WVXLu9ey+XQ
X-Received: by 2002:a2e:be8c:0:b0:3a9:9a2e:27fd with SMTP id
 38308e7fff4ca-3ae2b35bc76mr46146291fa.0.1794925777917; 
 Tue, 17 Nov 2026 06:29:37 -0800 (PST)
X-Received: by 2002:a2e:be8c:0:b0:3a9:9a2e:27fd with SMTP id
 38308e7fff4ca-3ae2b35bc76mr46146231fa.0.1794925777423; Tue, 17 Nov 2026
 06:29:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261117124303.717447-2-iboukris@gmail.com>
In-Reply-To: <20261117124303.717447-2-iboukris@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Nov 2026 15:29:25 +0100
X-Gm-Features: Aa3M54pc9pjjFRaKVVgc6dAj8nOyHuvrkQlqgwgiPdgDqUFvT4IILWgF7ncsM0w
Message-ID: <CAJFAV8zyPB1uqYmywdqzwBCO9mhXrpyEJLyPf8bELLSvFK-x1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/virtio: fix Rx interrupt setup with MSI-X
To: Isaac Boukris <iboukris@gmail.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, dev@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FvyMTuv9yknPCwV2_QfAsZaHulOOetTkuuY9DL8AeKE_1794925778
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Tue, 17 Nov 2026 at 13:43, Isaac Boukris <iboukris@gmail.com> wrote:
>
> With Rx interrupts enabled, configuring a port initializes the device,
> and a second time when an offload or RSS is requested. Each
> initialization enables the interrupt eventfds.
>
> EAL now refuses to enable MSI-X eventfds twice, so such a configuration
> fails, and so does configuring a port a second time:
>
>   EAL: Interrupt eventfds are already enabled
>   virtio_configure_intr(): Fail to create eventfd
>   ETHDEV: Port0 dev_configure = -16
>
> Before that EAL change, the previous eventfds were leaked.
>
> Disable the interrupts and release the eventfds before enabling them
> again.
>
> Do it for a VFIO MSI-X handle only, the type whose eventfds EAL
> creates. The other type that gets here is virtio-user's: its eventfds
> are the backend's call fds, set once when the device is created.
> Releasing them would reset their count, which nothing sets again, and
> registering an Rx queue's interrupt would then fail.
>
> To reproduce, with a virtio-net PCI device bound to vfio-pci:
>
>   dpdk-l3fwd-power -l 0 -a 0000:0c:00.0 -- -p 1 --interrupt-only \
>       --parse-ptype --config="(0,0,0)"
>
> Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")
> Cc: stable@dpdk.org
>
> Signed-off-by: Isaac Boukris <iboukris@gmail.com>

Thank you for the testing and report.


> ---
>  drivers/net/virtio/virtio_ethdev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
> index f2302089ee..37fc896fae 100644
> --- a/drivers/net/virtio/virtio_ethdev.c
> +++ b/drivers/net/virtio/virtio_ethdev.c
> @@ -1455,6 +1455,13 @@ virtio_configure_intr(struct rte_eth_dev *dev)
>                 return -ENOTSUP;
>         }
>
> +       /* Reinitialization: release the previous eventfds first. */
> +       if (rte_intr_type_get(dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&
> +           rte_intr_dp_is_en(dev->intr_handle)) {

The rte_intr_cap_multiple() guard right before should enough (for the
interrupt type check).


> +               virtio_intr_disable(dev);
> +               rte_intr_efd_disable(dev->intr_handle);
> +       }
> +

Can the number of rxq change at this point?
I don't think it is the case.

If it can't, why do we need to release/set up new eventfds?

The fix could be a simple:

+ if (rte_intr_dp_is_en(dev->intr_handle)) {

>         ret = rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_queues);
>         if (ret < 0) {
>                 PMD_INIT_LOG(ERR, "Fail to create eventfd");

+ }


We could probably move the rte_intr_vec_list_alloc call under this
check too, but iiuc, this helper does nothing when called multiple
times.


-- 
David Marchand

