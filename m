Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8FC83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 15:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 299274013F;
	Thu, 17 Jul 2025 17:04:25 +0200 (CEST)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48]) by mails.dpdk.org (Postfix) with ESMTP id 1B3A5400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 17:04:24 +0200 (CEST)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-615a4b504b2so231926eaf.1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752764663; x=1753369463; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8w8+HeQ3rQg1NM+gp6wrZmndoaXeRd336MyyWznZMao=;
 b=mGzkIf0SRPiw+tfePrAby5Esf9Q4tRq2PxKRwtdbJrUThCqqAlgZcwpRGBXzUGd7CJ
 dmszyYFZ5fZJJdwxwGdmXNtptXj6EjTVlrMpz4WhZfafHjTaujHEBLkdAQfeXlJAGUUV
 dVRAvHlQdInlzDGuBn+s2RDGirSANUR1cMLg+LeoVEdqPt1561tArWtMCclIU+93E91L
 hLMkdcDpDGNt7NaNzGIwtaqo5krViGivp+N8lRRGo0IBZMMW/b7gmZk3NUHjfG8Rm8+6
 OE2hOzTq7DMIGkPvBomwcuQSS7W4eWaGWqsqjH+/2CvrU8pa1ZZ+Gt+M2lCSiO0xU63o
 TSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752764663; x=1753369463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8w8+HeQ3rQg1NM+gp6wrZmndoaXeRd336MyyWznZMao=;
 b=LF0GLdLcDfZ1KW8Rdul1OyaQQHU75mGr1OWE/I3sGPRxZlLbe7Fff/T0ZBOOChVBLA
 74fQr3SVnuWEShHTQqKtk0Dn6FN9JDos1m/l5GEEI4j/zYXtdUoeI/DFUHTAsRsgWbVJ
 C5t8L/pv63HVbjvNBJ5esxrtfY3+l88Ydx9xAJWmH70OB+LjokhfG4kpYmV/DwxHqpHg
 H56fb9RfgfIQG2K1eRJ85nv2JxXpp4E7HM4G5xZs6a11t8U12dR68zq4lsDGPqpcFuZr
 38Hu9iLq8gYwCta7HnJD/g2BYN0KTqsQ9WOL8e5Kf/JUD+M2eU6dYp6c7G2cmVgBcSAJ
 ZH3A==
X-Gm-Message-State: AOJu0YynEoZtC++q5ebNze5+x/2nnQMrIczPYHVOE0M2/yPJVApwZFFp
 4AD5eraLtuLOh/z2OOibMgY0k/PEmIJdL6TWvmUIyfqkZwURJ5mqwuoHuXkC6DQiRCstFkJJOgC
 XAyqhu7eHW9g/kmn7IfNZEaNwx0n8sPcrmupY
X-Gm-Gg: ASbGncu+89ogH58g8DIHSe+UDHQ9rKJiQlUFek4hd6sHV0dRv1KKByV5UzLQOCrOHFh
 vQFy2Hf3BJ7wv6tuof1KEE8RjSQLdSAMtF+U57u7Ht7ZGaN00dQJ8UwLBDwhvr5RNClPGa56+Tr
 pG8ydDgbuiGLgWhoqbih/nQ2AI3DIyZrjPvgewLwEPNfp5tpUxglSGkmoxn3XE4WWVwugAF6y2E
 38dxuI=
X-Google-Smtp-Source: AGHT+IHGdMefDo0GbxqeJEfUP7WUlRlgAmTLl3RWbXHVUkcWisRY987s547xOVtnSSa4cGbAq4/gH3GMK5sugsclNqI=
X-Received: by 2002:a05:6820:5082:b0:615:96cd:ebfc with SMTP id
 006d021491bc7-615a1fd1324mr5025031eaf.2.1752764663064; Thu, 17 Jul 2025
 08:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250609072347.1748785-1-hengqi.chen@gmail.com>
 <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 17 Jul 2025 23:04:12 +0800
X-Gm-Features: Ac12FXyFUFSFBiWg0uNPHys4dYYRIzBJNsE1kLaD8ch2O9CA9vsukWxOdCCN3Vg
Message-ID: <CAEyhmHSoNF=vJE7jqBhOH+eV2ehqUo63g174tnvp-wf+BMPsaA@mail.gmail.com>
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

Could you please elaborate how to use trex in your reproduce steps ? Thanks=
.

Cheers,
---
Hengqi

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
