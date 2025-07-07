Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA48C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 06:47:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDFF540287;
	Mon,  7 Jul 2025 08:47:43 +0200 (CEST)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50]) by mails.dpdk.org (Postfix) with ESMTP id 0971F4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 08:47:42 +0200 (CEST)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-611e20dd2ffso1033812eaf.2
 for <dev@dpdk.org>; Sun, 06 Jul 2025 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751870861; x=1752475661; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKIs3arDxkngAYJSYC0yqZATaQiVvuQZKeptZGNb/h4=;
 b=fz/Rx/bQzCTbFMX/XmWct/Iqh4Rxz38s6xrcXGZ/lVNhNnOQ63xh2kn5WMLyxGNTKl
 tvTaWyKCCIjrobTQx7FoEDFseKphDhS9NC4/ARqxoYzcpaG16tkjNY2YdMy8ynYt+rzD
 UBvYyYy6IhpazO75h02owxV8TyCLKVxWgwUnLHbbGRqHMvg5DdspkIRki4LFDbB6mqr9
 NWhD0NgI1qo4mYsDVt8b1Cm0JVYSHdBAtwqdYq69NZT36cmFT997WuDFSLuE/CjfG44J
 fMcG+1qJX++vm/IqtM6ba7AjM3/Qizl6N3HTp5lCAMMZXvWPo5TuDuCwU6Uf4p6mlSvg
 glyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751870861; x=1752475661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKIs3arDxkngAYJSYC0yqZATaQiVvuQZKeptZGNb/h4=;
 b=Rv8XuD5XcoaekWJplc8Mh5AtxrjhpR8YHyTiG2/GQhS2eMzVObaMu3BFnKFX8sDAwY
 Wsio/EEdsWZV8SyNR1GwKvTY7Avc7Fi5a0B8vx55IhcxsFmUGmluPqdtr5NSagoo+VjA
 hK3gOEE3D727tk2yunJjId/78A8lgUBUvnJ5zcguFj07F/UdUdQ5ls3bmzRkhEjnBw7o
 LPyJBAmXsQcZonhUzbSl8VRM5thjgiRNTRErRK4bGR6OnPvfEeeW7vsC6zg09J+Pk7+r
 6CRchDRytJIXA7bsa3+dL5B3zwAyJs02lHwWYjJlUm5gNSpNu8rVASd+wrrI6rzbrZP7
 eH1A==
X-Gm-Message-State: AOJu0YwLigiZB4rUZUy1OHkrHqXeZp2P79rJjA5cIqGMGOb27Gsl/QGF
 vC6AcJlnJ97Umuiuv+CsQFp6ybAlHVmp0oHAHYqEW2wcCFFzyQ3Zu6CPeuRHW4pG59eJ1s5iqMb
 Pc8cenp+ouyKbERncK17+zUoN3qt5zJI=
X-Gm-Gg: ASbGncu/cslV1RFl5RSIsCldZZXuOOiNjTphSk44oWXklJ1U/O5563qljaW4Z7ZXfUW
 oDblu//rLMUfYrRoOhKUzk6v0ixrLjwMjzmkwaWtQhRHxlrx+WDIhHtpMfDq8NSeQCrI1oYIX0Y
 c6CPdkWmzWNgXIBKQw2mxqBJXBciYLg8o7oLV0A8OG9KA=
X-Google-Smtp-Source: AGHT+IGGbMm8IB33LO5aOAKVhkm0ZZI3NwNhw+bVhXTMAldTzqh9FYOK4pQqQ0j0Nhy3BP3+zL6AhLmlg2X8VGhEQps=
X-Received: by 2002:a05:6820:174b:b0:613:7eb8:a4a6 with SMTP id
 006d021491bc7-6138fd5e525mr8893584eaf.2.1751870860967; Sun, 06 Jul 2025
 23:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250609072347.1748785-1-hengqi.chen@gmail.com>
 <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 7 Jul 2025 14:47:29 +0800
X-Gm-Features: Ac12FXyeOAj15ZgMG8sLRQH6ObKDZZoC3RvftYo1b03cnKaqtYOh5bE4dcXa2WI
Message-ID: <CAEyhmHTQVkY+wrS1js+UMLa0YedeWJ0-E1JcyjZ=LHLEVOxhJA@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Fix check of threshold for Tx freeing
To: "Jiang, YuX" <yux.jiang@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Baoyuan Li <updoing@sina.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
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

Hi Yu,

On Fri, Jul 4, 2025 at 7:29=E2=80=AFPM Jiang, YuX <yux.jiang@intel.com> wro=
te:
>
> Hi Hengqi,
>
> Can you help to check the ticket: https://bugs.dpdk.org/show_bug.cgi?id=
=3D1747? The perf drop is caused by your patch. Thanks so much.
>

The `[Expect Result]` section contains a non-zero `TX-errors` counter,
is this expected ?
BTW, the expected result is done by dropping/reverting the bad commit
ONLY, right ?

> Best regards,
> Yu Jiang
>
> > -----Original Message-----
> > From: Hengqi Chen <hengqi.chen@gmail.com>
> > Sent: Monday, June 9, 2025 3:24 PM
> > To: dev@dpdk.org
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>; Baoyuan Li
> > <updoing@sina.com>; Maxime Coquelin <maxime.coquelin@redhat.com>;
> > Chenbo Xia <chenbox@nvidia.com>
> > Subject: [PATCH] net/virtio: Fix check of threshold for Tx freeing
> >
> > Like most dirvers, make the fast path of virtio_xmit_cleanup() behave a=
s
> > described by the comments of rte_eth_txconf::tx_free_thresh ([0]):
> >     Start freeing Tx buffers if there are
> >     less free descriptors than this value.
> >
> > The rationale behind this change is that:
> >   * vq->vq_nentries is set during device probe with the queue size spec=
ified
> >     by vhost backend, this value does not reflect the real nb_tx_desc
> >   * the real available tx desc is set to vq->vq_free_cnt via the nb_tx_=
desc
> >     param of rte_eth_tx_queue_setup() API
> >   * so `nb_used > vq->vq_nentries - vq->vq_free_thresh` could never be =
true
> >     if say nb_tx_desc=3D2048, vq->vq_nentries=3D4096, vq->vq_free_thres=
h=3D32,
> >     see bug report 1716 ([1]) for details.
> >
> > Bugzilla ID: 1716
> >
> >   [0]: https://github.com/DPDK/dpdk/commit/72514b5d5543
> >   [1]: https://bugs.dpdk.org/show_bug.cgi?id=3D1716
> >
> > Signed-off-by: Baoyuan Li <updoing@sina.com>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  drivers/net/virtio/virtio_rxtx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virt=
io_rxtx.c
> > index edecd2011f..ab97f03d7d 100644
> > --- a/drivers/net/virtio/virtio_rxtx.c
> > +++ b/drivers/net/virtio/virtio_rxtx.c
> > @@ -1873,7 +1873,7 @@ virtio_xmit_pkts(void *tx_queue, struct rte_mbuf
> > **tx_pkts, uint16_t nb_pkts)
> >
> >       nb_used =3D virtqueue_nused(vq);
> >
> > -     if (likely(nb_used > vq->vq_nentries - vq->vq_free_thresh))
> > +     if (likely(vq->vq_free_cnt < vq->vq_free_thresh))
> >               virtio_xmit_cleanup(vq, nb_used);
> >
> >       for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> > --
> > 2.43.5
>
