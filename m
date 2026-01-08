Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D1D1D467
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 14:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D3334068E;
	Thu,  8 Jan 2026 15:52:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 834744027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 15:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767883959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zm+sIX9km2brizKKQlaYdKBFxechPFjo1zTVRb+8CbU=;
 b=CS2O7cQzjHvELlvmJ3PmU1o35dGigerBbpQSj8hrk6Qvb88Er5/sLFekmvbIaqquRBq/oj
 zRmq2diq0GFPa3jHdy8aUFjBNH86FXO+TxUHsCNwJK1DsQjULHGxVzV/4dV66/mClA2E8T
 YNYF44VYsoR8cOIMaBqF1tMap8GZ7iM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-JpvhjM8ePFWB8LZZA2oD5w-1; Thu, 08 Jan 2026 09:52:38 -0500
X-MC-Unique: JpvhjM8ePFWB8LZZA2oD5w-1
X-Mimecast-MFC-AGG-ID: JpvhjM8ePFWB8LZZA2oD5w_1767883957
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38316f5d922so1768771fa.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 06:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883956; x=1768488756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zm+sIX9km2brizKKQlaYdKBFxechPFjo1zTVRb+8CbU=;
 b=WFzR/pVm4yBKUFNEzI/vr8b7pc2NiOXBHA+OL8X38nFOP9R8t/rmr/6kuH7kOyvwxo
 sGj5X6+ifysaJsSSvkZhw3tj00l8Kj/ziuLgUmS65or8It8x7fvCZDMLQ9OjyKpZfLa7
 vM0yrtZtu9zZRQOO9mfZh76Y/ZIDswdpzlvjc7HztiibssQYaYfri3hV7wx6c5bXAaTo
 aq5v7vSZEMwR/Mb8L18eHkf9tZLV0Ub468HI3cCz4JRA8L5PEX4WkvM+usLzCl8Pz58N
 BYiKm3F3yBOwbbtBM9rYzYwgZ/j6HPNjHmdZhtU9R73AFHoi17WXnaXjq4wbP67buAmK
 bhUQ==
X-Gm-Message-State: AOJu0YwxcD3oi34zJUYKtv3ZhpmHyVCydlJgcb4M63rephMfqM0lplEv
 JCerbUJIwZhwGoOSBW8NBs2H8+QQ1Cy3uqpbzDdXbhZFFpye8YHnh7VHvtNn+ZdeIlCXQCzgRkB
 ilMpKM0YL8c60RQpDcdK9g+U0as6Beo9KJH2GVJ3d4a17FlIu8ykOFUimmGgEhdCQHCaClv+8xC
 JwB8bt7Dnurb/JQaqmyss=
X-Gm-Gg: AY/fxX4K+opXBRsk3brSas5b7U/FTN5q5e6LngTSNlmqeAgsV67L3W+OSz/h3BinZlD
 zNKSTV7yyaDj5+dGaAxUl2NE5O5UZPVc3nUkiaRy++Xuwy83JQRPvwM9B1VdIZ8fWjJhPIZkGLv
 icx2zJUX55TXTZN8zseeYzwXUz5SnGMH53adNvjttUaAhhL4XFfYNh3xwKKZmOZ+xEzYGw
X-Received: by 2002:a05:651c:198e:b0:383:1565:629b with SMTP id
 38308e7fff4ca-383156567eamr4573361fa.1.1767883956466; 
 Thu, 08 Jan 2026 06:52:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTeJvFZENQGwz5zJFK+WJsIf12ZFhoTuJbxy8pStReBIxWQXoj1Gff6sW5z7AaChanMWfywaQV6lLMQXGhcD8=
X-Received: by 2002:a05:651c:198e:b0:383:1565:629b with SMTP id
 38308e7fff4ca-383156567eamr4573201fa.1.1767883955975; Thu, 08 Jan 2026
 06:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
 <20260108134951.3857110-3-maxime.coquelin@redhat.com>
In-Reply-To: <20260108134951.3857110-3-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 8 Jan 2026 15:52:24 +0100
X-Gm-Features: AQt7F2rFi-E4nx0uHreUJkvrsBR1L0VL4L80UmAgdfHUYEnjDn1YRwPQStmb93I
Message-ID: <CAJFAV8yvYLMLO=fx36mnJ9sH+Xm_3yzxVoWAOHW8QhGUpnYbKA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vhost: fix descriptor chain bounds check in control
 queue
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tqN9eKeo8XOIsRuXMC2oYibp5yLNdK30FB0gyeG52oc_1767883957
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

On Thu, 8 Jan 2026 at 14:50, Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>
> The virtio_net_ctrl_pop() function traverses descriptor chains from
> guest-controlled memory without validating that the descriptor index
> stays within bounds and without a counter to prevent infinite loops
> from circular chains.
>
> A malicious guest could craft descriptors with a next field pointing
> out of bounds causing memory corruption, or create circular descriptor
> chains causing an infinite loop and denial of service.
>
> Add bounds checking and a loop counter to both descriptor chain
> traversal loops, similar to the existing protection in virtio_net.c
> fill_vec_buf_split().

Too bad we have two separate implementations..

>
> Fixes: 474f4d7840ad ("vhost: add control virtqueue")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  lib/vhost/virtio_net_ctrl.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
> index 603a8db728..8149885384 100644
> --- a/lib/vhost/virtio_net_ctrl.c
> +++ b/lib/vhost/virtio_net_ctrl.c
> @@ -28,7 +28,7 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
>                 struct virtio_net_ctrl_elem *ctrl_elem)
>         __rte_requires_shared_capability(&cvq->iotlb_lock)
>  {
> -       uint16_t avail_idx, desc_idx, n_descs = 0;
> +       uint16_t avail_idx, desc_idx, n_descs = 0, nr_descs, cnt = 0;
>         uint64_t desc_len, desc_addr, desc_iova, data_len = 0;
>         uint8_t *ctrl_req;
>         struct vring_desc *descs;
> @@ -59,12 +59,19 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
>                         goto err;
>                 }
>
> +               nr_descs = desc_len / sizeof(struct vring_desc);
>                 desc_idx = 0;
>         } else {
>                 descs = cvq->desc;
> +               nr_descs = cvq->size;
>         }
>
>         while (1) {
> +               if (unlikely(desc_idx >= nr_descs || ++cnt > nr_descs)) {

I don't like pre increment.
Can we use post increment and stay aligned with known to work
fill_vec_buf_split?


> +                       VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctrl descriptor chain");
> +                       goto err;
> +               }
> +
>                 desc_len = descs[desc_idx].len;
>                 desc_iova = descs[desc_idx].addr;
>
> @@ -142,12 +149,23 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhost_virtqueue *cvq,
>                         goto free_err;
>                 }
>
> +               nr_descs = desc_len / sizeof(struct vring_desc);
>                 desc_idx = 0;
>         } else {
>                 descs = cvq->desc;
> +               nr_descs = cvq->size;
>         }
>
> -       while (!(descs[desc_idx].flags & VRING_DESC_F_WRITE)) {
> +       cnt = 0;
> +       while (1) {
> +               if (unlikely(desc_idx >= nr_descs || ++cnt > nr_descs)) {

Idem.


> +                       VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctrl descriptor chain");
> +                       goto free_err;
> +               }
> +
> +               if (descs[desc_idx].flags & VRING_DESC_F_WRITE)
> +                       break;
> +
>                 desc_len = descs[desc_idx].len;
>                 desc_iova = descs[desc_idx].addr;
>

I wonder if we are missing some call to vhost_alloc_copy_ind_table() as well.


-- 
David Marchand

