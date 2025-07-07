Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94840C8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 04:08:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 673DA4025D;
	Mon,  7 Jul 2025 06:08:08 +0200 (CEST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id C62814021E
 for <dev@dpdk.org>; Mon,  7 Jul 2025 06:08:07 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-40abe6f8f08so2543141b6e.0
 for <dev@dpdk.org>; Sun, 06 Jul 2025 21:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751861287; x=1752466087; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHTAUm/qzPhmEx//EEr/pHi5yC1L/U9MCQ73t9GHhoc=;
 b=nWbxNV2bneImPKcoxgWncPrJTDgpjwx169yVYV6a/TMc1x6ivPc8WktpbXNEcPCCUs
 YfkGh+q3DIA0HB0UwJqIOsh8U7AZjzQh+/DWzhC2vdL8xGJjOMwxnBDdbv9F4zI8eV2m
 QMv6ZcL6mx7E75yZ68OK30zF4hncBFkpQb1Kfaa6RzQU9CMNl1E+YjpxFJBHwt1T3fjn
 9Sw/ZZUXvnMB8s+WhNrKtus1g6nSuS86YReqXT2gDOagONe1zU6VAHrTAnGcDAlGKQym
 aavnw50CL+E82jCi6Pe5xeQKYiN3A90NDPdc6lkoprYOuxkF8LR7M3jmRt6U/a632dWH
 PV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751861287; x=1752466087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHTAUm/qzPhmEx//EEr/pHi5yC1L/U9MCQ73t9GHhoc=;
 b=oMqlROdX5vsS+SBOoaOCZbdZCIYLg/EKBnLoiP4KJRG1e/8tpxO+5gO54Bclvg1aW4
 hcqs1ZA6qV49BOBeL9k4YFKwBCIl0pwPoxHH8r+hQqQroRh1y/zD52I8CXhpVmaZdpYu
 q+ozID2dscHXBHFpYF5+OOkaCd06l83c2iWacAEruzFFfJwxPiWqaXOFsz+riBG/QZoj
 hw7rK4nB2PcAsIx98IcQ9GNf55aSp7XmvXGaUcISS+4dJYlwGWD4VGjswO0/N8l1fRsr
 WJC8FMRQuWni3y3hq8MThadyEXe1jsQFjP+LiItOMk3OTPrko+k3hVexL+eyGYATm0bJ
 ltWw==
X-Gm-Message-State: AOJu0YyjX1Xq5U4DmKyVwcnEA4rRifhWSx1sqT7Vp3Zt3ygmJpAjWVc7
 5ZCMKvw+H71aXjYkvpKqcUOxuUlFuKrmBiHWczbBqjhTBJ8PWMjbACuUumuKc8lO3hH2TL7y0R8
 qCx1cJYfnECGHY8ZF3V7sljPypjGhSBM=
X-Gm-Gg: ASbGncuimTbjRuVjzPoFiLLzmqbMjhaJq8unOdw05Wonyr8IgTkdb8lYLZGsePsVvWx
 wcMHA0Vs0IVaOgZyZTVN8GONHKIKXwNBeYg4l2lOqGQS9OFEJV3T+EcpLfmFuekCYA/Xpre4L1i
 tjqlRTOrY5ygB30XX/8yWB2A+vRffAZ1oFmWjv8h+2/tqdRlvGmAbctg==
X-Google-Smtp-Source: AGHT+IG5U8geJOjdgJIn4e2b5TPgy6Lp5240lWVcJRKTjbCs1ap9ufeVoWkv3ESWngm9r70sb1Wv0Mtldtw+xwRsACk=
X-Received: by 2002:a05:6808:bc7:b0:408:fef8:9c9e with SMTP id
 5614622812f47-40d073d3709mr7591380b6e.22.1751861286887; Sun, 06 Jul 2025
 21:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250609072347.1748785-1-hengqi.chen@gmail.com>
 <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 7 Jul 2025 12:07:56 +0800
X-Gm-Features: Ac12FXzxP8HlmmOktT0y3w65i70iWyMt5OlHbnNrbJDGX4kCr4gNoG21hF1TPXg
Message-ID: <CAEyhmHSfH0AiGOBPDXCru1hmVGu+=Db2HXwGaWub8B0Dt-ojxQ@mail.gmail.com>
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

Thanks for the testing. Will investigate.

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
