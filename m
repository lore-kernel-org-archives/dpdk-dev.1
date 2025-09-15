Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4ECAC599
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 09:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC95B4060B;
	Mon, 15 Sep 2025 11:42:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9E9424060B
 for <dev@dpdk.org>; Mon, 15 Sep 2025 11:42:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757929367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0QIWx+JGZsdxtOGuibc1VXlSug4c+/QjDo+Wyes/xA=;
 b=H+xQc0ECx/m22+yzKVg/F979OfOmCsrIO0ivN0nZpnG9DJfh/f/EYJDgAtontA8czRDg+M
 +9pz404a4gK3d5KkrAsoIj3plYgqUVs2jRMge2AMNT17jC+kqbjAVAgT+vpmeBWgttxgQi
 a+YlBfGZkXbwNLiJY60Y6omJZQtCmsA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ezMGb2_LMs-5C-DfymALOQ-1; Mon, 15 Sep 2025 05:42:46 -0400
X-MC-Unique: ezMGb2_LMs-5C-DfymALOQ-1
X-Mimecast-MFC-AGG-ID: ezMGb2_LMs-5C-DfymALOQ_1757929365
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-571c4a20da8so2242040e87.1
 for <dev@dpdk.org>; Mon, 15 Sep 2025 02:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757929364; x=1758534164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x0QIWx+JGZsdxtOGuibc1VXlSug4c+/QjDo+Wyes/xA=;
 b=tI4+E2tqTDNVcCtKN9N+RbgnOsHw7QWc3l6/F6/7sS1fy61R5GucP7CBeya+ihimhu
 UaEbudnX9kjRWaMgLsRnqdRS2ww4aEVurQnOj5dlPWiTxtHoFRvG9xiB0IwL0tUZVimG
 HqhsBNsUdnBfmv98WcqJjUnmjZSkaQseIdWu0bQewi1zHXBQtSwsr6kr3vAE9jhAmtia
 N+ebokgJXajUGWnfpOMBXEsITna0D3NtbCMnO3KpvNA50mbutrYlRjrxV2Fs8PXSV82A
 K4U1rQ4llWuTRXgyzBWsvpHHARwI5TQ7dEryoDWY6UvI92JI5qGNF0fc1UCzYoTxJx5T
 aj3Q==
X-Gm-Message-State: AOJu0YwjvWfwEBawqDmwKlNQOBq+52TqB9M5HeoRShce6mEIZeDcI1FA
 ro5Hdcv6o5z5RgUI3bk3Bj1yH2fyRJ4VaiA0tNOB/e3otvmSgfTqgGWrdamb0Jh/TzYoxjQgBTs
 rzvhPkJS7MIhFgTv34LWs/DhgsK+iNgSZrW5+9bEG587T2guxrA5Qs4PRuZ29KTrxuYJ2bZmDcM
 EM5T9J7uywBUv9ZWahuhg=
X-Gm-Gg: ASbGnctw27m4g8k5mW99YS2JGsjtc5OHEJeDVDEIegVDxLd5OvkIlic++Geo36sGQ0Y
 0a3xAPvbAusjTNQI3mOIIm14kzF7PV6dplsXtyqynutJlhDDWTJpovojy08acWAFJ+nhjSIyyqh
 yZFXSwjuU4s8Zjmr2Uc6aj1Bs=
X-Received: by 2002:a05:6512:2919:b0:55f:6831:6eed with SMTP id
 2adb3069b0e04-5704a2f2378mr3194840e87.10.1757929364484; 
 Mon, 15 Sep 2025 02:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHla2g5kSLOu6qHNTBlq7TEcvhrfWlhL5OBhHUhl7KX2JtQMqPoTy+ro6RCR1yVBse1jRfKQUkuIcUq5LiSnjs=
X-Received: by 2002:a05:6512:2919:b0:55f:6831:6eed with SMTP id
 2adb3069b0e04-5704a2f2378mr3194822e87.10.1757929363953; Mon, 15 Sep 2025
 02:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250911083607.3676640-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250911083607.3676640-1-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 15 Sep 2025 11:42:32 +0200
X-Gm-Features: Ac12FXwJXniGdf6H7T-widh-Xso7mpDRv1VXPnedMJgUYm2NEDT-lBzQMkjUkGg
Message-ID: <CAJFAV8yxPW7k+mTTZ-9wnfCiMvmqzWeLZ5az5ExCYxfdOotaNg@mail.gmail.com>
Subject: Re: [PATCH] vhost: add VDUSE virtqueue ready state polling workaround
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, amorenoz@redhat.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UdFd9Gyn2hGrF-oondg7-cbr4Mdau-hilepaRNOXZHE_1757929365
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

On Thu, 11 Sept 2025 at 10:36, Maxime Coquelin
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
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  lib/vhost/vduse.c | 62 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
> index 9de7f04a4f..5a6025d702 100644
> --- a/lib/vhost/vduse.c
> +++ b/lib/vhost/vduse.c
> @@ -272,6 +272,56 @@ vduse_vring_cleanup(struct virtio_net *dev, unsigned int index)
>         vq->last_avail_idx = 0;
>  }
>
> +

Nit: no need for double empty lines.

> +/*
> + * Tests show that it succeeds at the first retry at worst,

it?

> + * but let's be on the safe side and allow more retries.
> + */
> +#define VDUSE_VQ_READY_POLL_MAX_RETRIES 100
> +
> +static int
> +vduse_wait_for_virtqueues_ready(struct virtio_net *dev)
> +{
> +       struct vduse_vq_info vq_info;
> +       unsigned int i;
> +       int ret;
> +
> +       for (i = 0; i < dev->nr_vring; i++) {
> +               int retry_count = 0;
> +
> +               while (retry_count < VDUSE_VQ_READY_POLL_MAX_RETRIES) {
> +                       vq_info.index = i;

It is not clear which part of the vduse_vq_info structure is r/o, r/w
or w/o in uapi header
I see that vduse_vring_setup() does nothing more than setting index.
I am probably paranoid but do we need an explicit reset of the whole
vq_info on retry?

Moving the definition of vq_info in this loop (right before setting
vq_info.index) seems better on that topic.


> +                       ret = ioctl(dev->vduse_dev_fd, VDUSE_VQ_GET_INFO, &vq_info);
> +                       if (ret) {
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "Failed to get VQ %u info while polling ready state: %s",
> +                                       i, strerror(errno));
> +                               return -1;
> +                       }
> +
> +                       if (vq_info.ready) {
> +                               VHOST_CONFIG_LOG(dev->ifname, DEBUG,
> +                                       "VQ %u is ready after %u retries", i, retry_count);
> +                               break;
> +                       }
> +
> +                       retry_count++;
> +                       /* Small delay between retries */

I would remove this Lapalissade comment.


> +                       usleep(1000);
> +               }
> +
> +               if (retry_count >= VDUSE_VQ_READY_POLL_MAX_RETRIES) {
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "VQ %u ready state polling timeout after %u retries",
> +                               i, VDUSE_VQ_READY_POLL_MAX_RETRIES);
> +                       return -1;
> +               }
> +       }
> +
> +       VHOST_CONFIG_LOG(dev->ifname, INFO, "All virtqueues are ready after polling");
> +       return 0;
> +}
> +
>  static void
>  vduse_device_start(struct virtio_net *dev, bool reconnect)
>  {
> @@ -414,10 +464,18 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
>         }
>
>         if ((old_status ^ dev->status) & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
> -               if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK)
> +               if (dev->status & VIRTIO_DEVICE_STATUS_DRIVER_OK) {
> +                       /* Poll virtqueues ready states before starting device */
> +                       ret = vduse_wait_for_virtqueues_ready(dev);
> +                       if (ret < 0) {
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "Failed to wait for virtqueues ready, aborting device start");
> +                               return;
> +                       }
>                         vduse_device_start(dev, false);
> -               else
> +               } else {
>                         vduse_device_stop(dev);
> +               }
>         }
>
>         VHOST_CONFIG_LOG(dev->ifname, INFO, "Request %s (%u) handled successfully",
> --
> 2.51.0
>

Aside from those nits, it looks an acceptable workaround for now.
Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

