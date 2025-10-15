Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96383CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 11:44:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F52E40656;
	Wed, 15 Oct 2025 13:44:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 98E5440276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 13:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=One2roXk0rfixTGFC41I6xz5twnnobzsFFzCag/MVFA=;
 b=dKTR9gRSfIw4ENpvEzWsWVqnjb5MVov6QwzX4u69M1tFQ/G/dJKh8uvMyvmVmejpJRjI+0
 +5z0SJHOpE6S5NwAhXxcoe7JaCTDISsmX9kydLAm/cAaXWPLfkD3G84IBBsEr/GwgarkTh
 A6u9fH9Kc5K18iQqBvzRSmLvQhHWFjw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-znhOlg_QNB-tArEHObUsxQ-1; Wed, 15 Oct 2025 07:44:34 -0400
X-MC-Unique: znhOlg_QNB-tArEHObUsxQ-1
X-Mimecast-MFC-AGG-ID: znhOlg_QNB-tArEHObUsxQ_1760528673
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5906653c9b4so3944531e87.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 04:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760528672; x=1761133472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=One2roXk0rfixTGFC41I6xz5twnnobzsFFzCag/MVFA=;
 b=X+vJelAlsKkyHgVl0X6OUP6J8IKsLxrpmxz2SbZvibJODmxPnXb04T/AtEIa9JGiaN
 eE5FVEwtztQLu+q3/7b2OKQ2xAzLkq2vGXfBkTFG3VqoBjQrZoQhMVXz2FA/XY0o6VVS
 P53WZddr3Ijxs21LBWrKBHuy85MfLrK0zJM8xK0+rLC5n+JofSrezzlSvcV1R4mAhpDE
 ogXcHwObCjfJSa0wT+c7ot/VMlRwKbwKKQqYVGBrRZj5TuzAfvjRgFm2g4WG7Pocz3JA
 gE6qdJ3TvlqF4HxCrqJdfzbSwykM0NikfWrec7HCOjz0UfPgns00aZjpQjnHlJoqCBVm
 bWIQ==
X-Gm-Message-State: AOJu0YwmJLPrNDJkuUyYPJiC2lRQqW7Xt2tfCCcZsBzdcu2CbsQ3fxWe
 C0ph/FPHUkDLMtsJ7F+RwI6D7V4NlMy+JHMXGQ4FvrB2J6SrAiUUTDDB70pC/gCdndPOsv4553F
 rgV7WXSVr/lXBrbZ/KAW3rvfKftYuWTIoAj5VrF9wI339zRGC+8KYUY6djeqlt16449NwjIZN2H
 Bv28iK/Tdw72Ny6+t1HeY=
X-Gm-Gg: ASbGncv72SvZV6U+uNrq2EBSB6slELMC5jbf8xFzKENGK0mRxFHopwO+d11jKus5AJ4
 i/9bd5+L9zBzbMbhL7izRE68fJWiKrmazMv/eMq8Xvv9VwYChpFtyJd/vsXrLzXVPnhxGFyUUne
 B8Ws3jdjdvfqPmZE2Ufr0=
X-Received: by 2002:ac2:5685:0:b0:58a:fa11:b7a1 with SMTP id
 2adb3069b0e04-5906dc16d75mr8609364e87.24.1760528672373; 
 Wed, 15 Oct 2025 04:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXYAwcGWrRKOerEHLofS0czP90FuAU/yKqADlJNHIJ3GHTOaz1FnIv71PvhvEbbDq2BvuuZUl52tOsDaAP0W4=
X-Received: by 2002:ac2:5685:0:b0:58a:fa11:b7a1 with SMTP id
 2adb3069b0e04-5906dc16d75mr8609360e87.24.1760528671885; Wed, 15 Oct 2025
 04:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
 <20250916093550.1345901-2-maxime.coquelin@redhat.com>
In-Reply-To: <20250916093550.1345901-2-maxime.coquelin@redhat.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 13:44:20 +0200
X-Gm-Features: AS18NWDYu10-wuhn3DQolYWwAzK-Y0rg05JBthdhrxtiX5HfWRo9K7FQsWWxmTw
Message-ID: <CAO55csyiR0UQ7DdaT-hXe=QQd4X-EQk0V603t_1r4HoOn-FezA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: add VDUSE virtqueue ready state polling
 workaround
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _3EgmRsXHEHu3wPSoUjUSKmG13CdYIVrWXjfxWzslH4_1760528673
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

Applied to next-virtio/for-next-net.

Thanks,
Maxime

On Tue, Sep 16, 2025 at 11:36=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Add workaround to poll virtqueue ready states before starting device
> when VIRTIO_DEVICE_STATUS_DRIVER_OK is set in vduse_events_handler().
>
> For each virtqueue, poll using VDUSE_VQ_GET_INFO ioctl to check
> vq_info->ready state with configurable retry limit. This addresses
> timing issues where device start was attempted before all virtqueues
> were properly initialized and ready.
>
> A notification mechanism will be introduced in the next version of
> the VDUSE uAPI. When it lands, we would only apply this workaround
> when the kernel does not support it.
>
> Fixes: a9120db8b98b ("vhost: add VDUSE device startup")
> Cc: stable@dpdk.org
>
> Reviewed-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  lib/vhost/vduse.c | 61 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
> index 9de7f04a4f..422c4ab8f3 100644
> --- a/lib/vhost/vduse.c
> +++ b/lib/vhost/vduse.c
> @@ -272,6 +272,55 @@ vduse_vring_cleanup(struct virtio_net *dev, unsigned=
 int index)
>         vq->last_avail_idx =3D 0;
>  }
>
> +/*
> + * Tests show that virtqueues get ready at the first retry at worst,
> + * but let's be on the safe side and allow more retries.
> + */
> +#define VDUSE_VQ_READY_POLL_MAX_RETRIES 100
> +
> +static int
> +vduse_wait_for_virtqueues_ready(struct virtio_net *dev)
> +{
> +       unsigned int i;
> +       int ret;
> +
> +       for (i =3D 0; i < dev->nr_vring; i++) {
> +               int retry_count =3D 0;
> +
> +               while (retry_count < VDUSE_VQ_READY_POLL_MAX_RETRIES) {
> +                       struct vduse_vq_info vq_info =3D { 0 };
> +
> +                       vq_info.index =3D i;
> +                       ret =3D ioctl(dev->vduse_dev_fd, VDUSE_VQ_GET_INF=
O, &vq_info);
> +                       if (ret) {
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "Failed to get VQ %u info while p=
olling ready state: %s",
> +                                       i, strerror(errno));
> +                               return -1;
> +                       }
> +
> +                       if (vq_info.ready) {
> +                               VHOST_CONFIG_LOG(dev->ifname, DEBUG,
> +                                       "VQ %u is ready after %u retries"=
, i, retry_count);
> +                               break;
> +                       }
> +
> +                       retry_count++;
> +                       usleep(1000);
> +               }
> +
> +               if (retry_count >=3D VDUSE_VQ_READY_POLL_MAX_RETRIES) {
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "VQ %u ready state polling timeout after =
%u retries",
> +                               i, VDUSE_VQ_READY_POLL_MAX_RETRIES);
> +                       return -1;
> +               }
> +       }
> +
> +       VHOST_CONFIG_LOG(dev->ifname, INFO, "All virtqueues are ready aft=
er polling");
> +       return 0;
> +}
> +
>  static void
>  vduse_device_start(struct virtio_net *dev, bool reconnect)
>  {
> @@ -414,10 +463,18 @@ vduse_events_handler(int fd, void *arg, int *close =
__rte_unused)
>         }
>
>         if ((old_status ^ dev->status) & VIRTIO_DEVICE_STATUS_DRIVER_OK) =
{
> -               if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK)
> +               if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
> +                       /* Poll virtqueues ready states before starting d=
evice */
> +                       ret =3D vduse_wait_for_virtqueues_ready(dev);
> +                       if (ret < 0) {
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "Failed to wait for virtqueues re=
ady, aborting device start");
> +                               return;
> +                       }
>                         vduse_device_start(dev, false);
> -               else
> +               } else {
>                         vduse_device_stop(dev);
> +               }
>         }
>
>         VHOST_CONFIG_LOG(dev->ifname, INFO, "Request %s (%u) handled succ=
essfully",
> --
> 2.51.0
>

