Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E86CCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50547402CC;
	Tue, 14 Oct 2025 14:54:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 29705402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760446461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RfIKFrmUBiG/qN8O/bCT1dp7tzR6lD6wVdF528qpKI=;
 b=FJWa2/Abl4sUGHF9CNAnOrB6+LRiHnAFrZsWot8WMc8jBBBvhMylh3HYOSGcIl1oepFu+E
 CixVdx6qNDT1jCzfOzBfpF2Tf01iVgGxRm8uIh7Y0FpfAMbTbM3I7zksl40uNk/rt+E2On
 c1SUIwoiE5EJiW6Tm0qmn6d7P/mPC7E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4w0zao1XPey7VQXfVxpTlA-1; Tue, 14 Oct 2025 08:54:20 -0400
X-MC-Unique: 4w0zao1XPey7VQXfVxpTlA-1
X-Mimecast-MFC-AGG-ID: 4w0zao1XPey7VQXfVxpTlA_1760446459
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57a31c382b8so4093392e87.0
 for <dev@dpdk.org>; Tue, 14 Oct 2025 05:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760446459; x=1761051259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RfIKFrmUBiG/qN8O/bCT1dp7tzR6lD6wVdF528qpKI=;
 b=qKNSRYURcsruMPOGHiCFXIDsAk1Kz4TdtwgC3YBK++gkHxbpCxjsoJAHlHFhrEivok
 ekv0Ef919CsRKn7fAhMaEusZBjhEjJF6Y08yCAXfzvc3EYHgotYNVSeyW7U6nHnKG4Xc
 3n8ZdTbMIeNrhCjK9/TJYBeU30GmgR9AiLVvqDOyIncS6iI6+OQmV6GJnPowsm26NKCS
 2X6W7ewTZc6k8A9MXWoff10uo6lMI5FXnFmvjMWq2to+sPN+ho+eYvipO1Il42zoKQf0
 pzvgOBBiTDRGBXNia3TCYJl6QFBdvAfnj2xCQcjirhR7ujx7Z97epMYcfxxdwtGRtHVA
 ryHQ==
X-Gm-Message-State: AOJu0YwquUhJM6XKQC25RnFmmtQkxyh58zUOqohKjeqRfx/zuAlgzcHY
 dIfxcoCMzJ8BqM4zp1JJp7zRiNF8hC6WuiCGLxzvoP5mSZxhD/bt61np4pakww3QWYFRW3pGcym
 t+zRG1OP+i/h982U1iQkXXVIxPRfRvJyEkbi2xLbESFnTNpC5fu/w0gDuxDchsPS5Lhj0ApjtFJ
 nyLvRT67EbwYQiRp8WIiY=
X-Gm-Gg: ASbGnctlv6rVJwg04ggkapdiNrGJHtes+WmwmZPgdZ9t4MdKwoLKnBG1rNi9vhMZ44R
 p8hqDO5vmT0ircijB+cZfkcNZFZnE94kve9qSW5pYQs/+ieVgqJ4bgP8Cv7oQa1Hd2sK3xexa1m
 5QuSgeccO3m32AjKkbUHQ=
X-Received: by 2002:a05:6512:e8c:b0:58b:43:9d92 with SMTP id
 2adb3069b0e04-5906dd90644mr7891452e87.51.1760446457509; 
 Tue, 14 Oct 2025 05:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEggYY73I5s9OTV7S4HIfMcJQ981TSgIIvvqCGBIsKzN3RWshF1R8PFm+RHMTIzTz1D5Vn/h0QEM560+egadjM=
X-Received: by 2002:a05:6512:e8c:b0:58b:43:9d92 with SMTP id
 2adb3069b0e04-5906dd90644mr7891156e87.51.1760446456012; Tue, 14 Oct 2025
 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251007145617.2888818-1-sil-plv@napatech.com>
 <20251007150630.2895365-1-sil-plv@napatech.com>
In-Reply-To: <20251007150630.2895365-1-sil-plv@napatech.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 14:54:00 +0200
X-Gm-Features: AS18NWBhhMb9yUUxblFpAtlYIGWwtK7Abk7QrFtcSKFvtvxDTufntsX90XsjGj0
Message-ID: <CAO55cszP6B5aUnRtydZ170WOGCRs1iFe-zgSX2PyJSU4i2HKxA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: always lock all QPs if handlers request it
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com, 
 maxime.coquelin@redhat.com, Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VhuPt_W4fWNDnZLxr4vQr9gCv24g5Co8BTnKgMR5KKw_1760446459
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

Hi Serghii,

On Tue, Oct 7, 2025 at 5:06=E2=80=AFPM Serhii Iliushyk <sil-plv@napatech.co=
m> wrote:
>
> The check for the VIRTIO_DEV_VDPA_CONFIGURED flag is not needed
> since each handler has its own lock_all_qps flag
> to indicate whether it needs all queue pairs.

Hmm, I think this is needed because lock_all_qps is only effective
with the SW datapath.
With vDPA, once the device is configured, we would end-up with
virtqueues modifications
without the HW being stopped or even notified.

> Checking the VIRTIO_DEV_VDPA_CONFIGURED flag caused certain handlers
> (for example, SET_MEM_TABLE for memory hot plug) to run without holding
> the per-vq access_lock and trigger vq_assert_lock failures.

In this specific memory hotplug case, we do the right thing in the handler:

    if (dev->mem) {
        if (dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) {
            struct rte_vdpa_device *vdpa_dev =3D dev->vdpa_dev;

            if (vdpa_dev && vdpa_dev->ops->dev_close)
                vdpa_dev->ops->dev_close(dev->vid);
            dev->flags &=3D ~VIRTIO_DEV_VDPA_CONFIGURED;
        }

Maybe we should also lock all the queue pairs once the vDPA is closed.
The problem is to handle the unlock properly.

Maxime

> Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
> ---
> v2
> * fix typo in commit message
> ---
>  lib/vhost/vhost_user.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 4bfb13fb98..9288da9322 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -3171,10 +3171,8 @@ vhost_user_msg_handler(int vid, int fd)
>          * would cause a dead lock.
>          */
>         if (msg_handler !=3D NULL && msg_handler->lock_all_qps) {
> -               if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
> -                       vhost_user_lock_all_queue_pairs(dev);
> -                       unlock_required =3D 1;
> -               }
> +               vhost_user_lock_all_queue_pairs(dev);
> +               unlock_required =3D 1;
>         }
>
>         handled =3D false;
> --
> 2.47.3
>

