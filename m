Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3F4CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 12:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F35E3402ED;
	Mon, 18 Aug 2025 14:56:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA2E40262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 14:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755521790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2g75/fb8wPPQSpZzEDDWs4QPYRv9IS3MW74fdqNrl4=;
 b=TgZE7toRhvS2T1TiQOp2n1A+NcB74bJQOZq2242bpDEUABCdtSMf9jX52nwC/DxrEcWGvs
 /Ub7gG/obmWcq+DDfWnmtxtqu6mqaWLnoiixmohhuzOT2Dsdrgd6kxTyAerw+e04hdSj0L
 GkvIavaHm/KOTbnLHSkjxXrGfiRH9Us=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-BUUVcAOtPna36_UVQVi87Q-1; Mon, 18 Aug 2025 08:56:29 -0400
X-MC-Unique: BUUVcAOtPna36_UVQVi87Q-1
X-Mimecast-MFC-AGG-ID: BUUVcAOtPna36_UVQVi87Q_1755521787
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55ce520c261so1766261e87.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 05:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755521787; x=1756126587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2g75/fb8wPPQSpZzEDDWs4QPYRv9IS3MW74fdqNrl4=;
 b=NTNuzOJL9RVBFtZWW3oZHD6LTsQVpQQtpi4IBU40yp2qne32AOQqyQNSYlat/HbBPz
 gKjE/ndCvYAkhlVwE/vc3wpxKRoSd860E7CqG+wfHd0g/vUpwET7KHZPuXuTDQzjCQ71
 htbRkl0tQ3cyXbBOee9VJkhA+uM0poFsWEy4trFg/tXZSzbxKu1rXsqU1P37QwjSej4L
 aqi16ztLLKr39UMAS7gMxp8tNnzuektWDTBaNE4qZDjA4ngOQipit7bAeNTv6spi/6rT
 iiAvjfYameZBL9QxMXtPa/8G734xZvrWsHniTZPKkYOpcuIqmAB6KNeQ8XLPgBR2+KLv
 EMqQ==
X-Gm-Message-State: AOJu0YyaE98P6Gs5RkeJoIUotTXYzj6FmSvi9vkwiAZ1AhwYsxjefHwO
 3lMi3Jdqs6S7SkpsEVBiFDn9dCKOl12ZJ6G2NV3YYdFOAOLUq9LMZnoA3AaYjtQUj5nII94E6Yo
 1FnZ+5fO23eFyrep17NrxLvf9Bl+Jvq6ZWhnszAeMUu3c/1uAhlz9aT3Rj58oh29bVRe35QjtGP
 5WtkZHWbyqQT4sBeSJprw=
X-Gm-Gg: ASbGncul3brkZLlfQpYXWgsXLeW/jf2ozM6pBom3CyoN+v8UfuDgJwrpHLiG/L9hOwu
 1jl4czA8gzQqvN6G2U3p5l4UzlDbSFyQhKgxBAFfSbgXlQaFmekrpoZXxusK3ZdMRVtdGbW8CZV
 5e1w6EQgkkKwfqaWjdhbex97M=
X-Received: by 2002:ac2:5687:0:b0:55a:826d:fa31 with SMTP id
 2adb3069b0e04-55cf2cdcfdemr2477872e87.37.1755521787281; 
 Mon, 18 Aug 2025 05:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX9JoMEFiK7JsIRMBQkL7/qNGWlL9Ls3Pt1oop6OilD0QmvqNUbq/pHbxOlG/AJ1o9LqXAUGi3yPgimyuvRZg=
X-Received: by 2002:ac2:5687:0:b0:55a:826d:fa31 with SMTP id
 2adb3069b0e04-55cf2cdcfdemr2477861e87.37.1755521786793; Mon, 18 Aug 2025
 05:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250805083657.1227817-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250805083657.1227817-1-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 18 Aug 2025 14:56:15 +0200
X-Gm-Features: Ac12FXxlJ_mpToMWbilXyiOr9EEieL1FdEwCrdW5zFomB64aCAsUSEVUqnmFEsQ
Message-ID: <CAJFAV8xpLpaFUyHMpF4jxpJ335YJw=TuCDWzT9oXy1+PXG4BkA@mail.gmail.com>
Subject: Re: [PATCH] net/virtio-user: fix used ring address calculation
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, amorenoz@redhat.com, chenbox@nvidia.com, schalla@marvell.com,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bgJP_nhDFZ6Fc4LgKNGxeMROC9tPAlk4owfAPeePML0_1755521787
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

On Tue, Aug 5, 2025 at 10:37=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch fixes the used ring address calculation, to
> avoid Vhost-vDPA backends (such as VDUSE) to fail while
> trying to translate it.

Maybe update the patch title to reflect that this issue affects
vhost-vdpa backend?


>
> Fixes: 666ef294ddf7 ("net/virtio-user: share descriptor IOVA to backend")
> Cc: stable@dpdk.org
>
> Reported-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/net/virtio/virtio_user/virtio_user_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/n=
et/virtio/virtio_user/virtio_user_dev.c
> index 187f81b066..7789f337f6 100644
> --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> @@ -149,7 +149,8 @@ virtio_user_kick_queue(struct virtio_user_dev *dev, u=
int32_t queue_sel)
>         } else {
>                 desc_addr =3D vring->desc_iova;
>                 avail_addr =3D desc_addr + vring->num * sizeof(struct vri=
ng_desc);
> -               used_addr =3D RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->r=
ing[vring->num]),
> +               used_addr =3D RTE_ALIGN_CEIL(avail_addr + offsetof(struct=
 vring_avail,
> +                                               ring[vring->num]),
>                                            VIRTIO_VRING_ALIGN);

The fix looks good to me, but I would go one step further (as a
followup maybe?).

I see no good reason for computing again the addresses in the kick
helper, while those addresses should be set once and for all at
"setup" time.
Only an offset needs to be applied to account for iova stuff.

What do you think of something like:

diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c
b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index 187f81b066..dcb702ace3 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -118,7 +118,7 @@ virtio_user_kick_queue(struct virtio_user_dev
*dev, uint32_t queue_sel)
        struct vhost_vring_state state;
        struct vring *vring =3D &dev->vrings.split[queue_sel];
        struct vring_packed *pq_vring =3D &dev->vrings.packed[queue_sel];
-       uint64_t desc_addr, avail_addr, used_addr;
+       uint64_t desc_addr, desc_iova_addr, avail_addr, used_addr;
        struct vhost_vring_addr addr =3D {
                .index =3D queue_sel,
                .log_guest_addr =3D 0,
@@ -138,25 +138,22 @@ virtio_user_kick_queue(struct virtio_user_dev
*dev, uint32_t queue_sel)
        }

        if (dev->features & (1ULL << VIRTIO_F_RING_PACKED)) {
-               desc_addr =3D pq_vring->desc_iova;
-               avail_addr =3D desc_addr + pq_vring->num * sizeof(struct
vring_packed_desc);
-               used_addr =3D  RTE_ALIGN_CEIL(avail_addr + sizeof(struct
vring_packed_desc_event),
-                                           VIRTIO_VRING_ALIGN);
-
-               addr.desc_user_addr =3D desc_addr;
-               addr.avail_user_addr =3D avail_addr;
-               addr.used_user_addr =3D used_addr;
+               desc_iova_addr =3D pq_vring->desc_iova;
+               desc_addr =3D (uint64_t)(uintptr_t)pq_vring->desc;
+               avail_addr =3D (uint64_t)(uintptr_t)pq_vring->driver;
+               used_addr =3D (uint64_t)(uintptr_t)pq_vring->device;
+
        } else {
-               desc_addr =3D vring->desc_iova;
-               avail_addr =3D desc_addr + vring->num * sizeof(struct vring=
_desc);
-               used_addr =3D
RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->ring[vring->num]),
-                                          VIRTIO_VRING_ALIGN);
-
-               addr.desc_user_addr =3D desc_addr;
-               addr.avail_user_addr =3D avail_addr;
-               addr.used_user_addr =3D used_addr;
+               desc_iova_addr =3D vring->desc_iova;
+               desc_addr =3D (uint64_t)(uintptr_t)vring->desc;
+               avail_addr =3D (uint64_t)(uintptr_t)vring->avail;
+               used_addr =3D (uint64_t)(uintptr_t)vring->used;
        }

+       addr.desc_user_addr =3D desc_iova_addr;
+       addr.avail_user_addr =3D (desc_iova_addr - desc_addr) + avail_addr;
+       addr.used_user_addr =3D (desc_iova_addr - desc_addr) + used_addr;
+
        state.index =3D queue_sel;
        state.num =3D vring->num;
        ret =3D dev->ops->set_vring_num(dev, &state);




--=20
David Marchand

