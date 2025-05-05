Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF7C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 15:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C5384025D;
	Mon,  5 May 2025 17:31:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 510164003C
 for <dev@dpdk.org>; Mon,  5 May 2025 17:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746459086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jj9sAZajws0xo9eFdOK/ML6T+4Awy11McSXlTgyP7So=;
 b=dkoOeG5xDYvcLTZEfi/Br1MN5X1boOnqeX+upjNJNZBc0PwsJ43HvW8nk5sZb9Lu3eK4FA
 oB2sh908Mcsdy/rwCLArEFdCt3w/tJoJT1EGVds5g8Sb7pZZh6VJOw0yTpdab9ehZyIVrK
 5evDYWPcG4lFqzRC+ffKzZmhsYnh6VQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-SAey3xpVMtWuS1-YLKyKQg-1; Mon, 05 May 2025 11:31:25 -0400
X-MC-Unique: SAey3xpVMtWuS1-YLKyKQg-1
X-Mimecast-MFC-AGG-ID: SAey3xpVMtWuS1-YLKyKQg_1746459084
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54c0a1ca4f7so2145637e87.3
 for <dev@dpdk.org>; Mon, 05 May 2025 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459084; x=1747063884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jj9sAZajws0xo9eFdOK/ML6T+4Awy11McSXlTgyP7So=;
 b=FH2HR4yIVQA0LoGhusNP9s1Hp/jmrb/cd17aZAc5YXuIC8qDLGH7ksZU+Qp2jOs6V2
 oajnwihUb8hdy7qBHPTNur/rV8eGoBZD+OjpLcCUZ4j3NGuFHmUHz5LKgr17tE2Cl+Iy
 ghjI4iLgqgQXdPWKSZp3TC6weqfoHGWJCtojVoYmz9/aAJXePNTLy9KkKJc8WPYz1i4E
 BM0JMryN4/CCllOD2SupI76BBbkaAeht0caF+r2hzqAIBBRBLOWDwrH/WDkec0Zs+0GW
 lZlqynOBmS6LXqy4MgpvU6X/cqSq4k0JQg3gqTJtfO0UHwH5OrsGr4Mb8tIbDWhVqPrK
 30uw==
X-Gm-Message-State: AOJu0Yx0iYbEYor4d3avHi42mPxtLzZWWYpHRcNS9XkfpZ+8CxI3UOfh
 h7g1vQITMZhKggWjsj8giHED3i9OJ+hX6D0nvZexITvT8dC5urblJhjQEIE2pYbqMNYCvFyledJ
 /XBKiHk8K4KRrIOMrUBevpFkpkmzmwVhP7K15Kxx18D1BTikQ2aRbw6WOyRuWu+/NLAArV5Czla
 MHO6thDQkfQ4IhfVc=
X-Gm-Gg: ASbGncvHivgR9xXj29dipyb59ucrqik62B/OH66HS4dc0VFgYKOoLjIZgRaKOnyagiQ
 pil3esv72rIFtvPtoYI9PD90fmDGhSlJNaXfaNsR/4qAnqEaAe7G7Wor4bVpAbdhHpxZO67c=
X-Received: by 2002:a05:6512:6c7:b0:54b:1039:fe72 with SMTP id
 2adb3069b0e04-54eb24354fcmr2572380e87.14.1746459084188; 
 Mon, 05 May 2025 08:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCDvcAMcNquDqju9Akost2mbLFlz0PL4i+TWvtOKQW58Q/rTSnDovxFVlPjXxirt1oUGHYr8fOQw7Taodez6M=
X-Received: by 2002:a05:6512:6c7:b0:54b:1039:fe72 with SMTP id
 2adb3069b0e04-54eb24354fcmr2572371e87.14.1746459083764; Mon, 05 May 2025
 08:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
 <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
In-Reply-To: <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 5 May 2025 17:31:10 +0200
X-Gm-Features: ATxdqUEFpIemW7wcWN8RYAK3OaRjatt6THDm2k4O02YvSTZ8D-_omG2GIA_627w
Message-ID: <CAJFAV8xkOQED3U0B9U8HEL88A4s+6+HLPxFWS=zeEJ-i2jm4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: dev@dpdk.org, "Ji, Kai" <kai.ji@intel.com>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ISCZnpcEsqkeIj0Ns1t5x7HcJSs_No_SdyQVOUYcnEI_1746459084
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

Hello,

On Thu, Apr 24, 2025 at 4:26=E2=80=AFPM Yang Ming <ming.1.yang@nokia-sbell.=
com> wrote:
>
> Hi,
>
> On 2025/4/7 13:25, Yang Ming wrote:
> > From: myang <ming.1.yang@nokia-sbell.com>
> >
> > When a secondary process tries to release a queue pair (QP) that
> > does not belong to it, error logs occur:
> > CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> > qp_id=3D0
> > EAL: Message data is too long
> > EAL: Fail to handle message: ipsec_mb_mp_msg
> > EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> > ipsec_mb_mp_msg
> >
> > This patch ensures that a secondary process only frees a QP if
> > it actually owns it, preventing conflicts and resolving the
> > issue.
> >
> > Signed-off-by: myang <ming.1.yang@nokia-sbell.com>
> > ---
> >   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ip=
sec_mb/ipsec_mb_ops.c
> > index 910efb1a97..50ee140ccd 100644
> > --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> > +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> > @@ -138,6 +138,7 @@ int
> >   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
> >   {
> >       struct ipsec_mb_qp *qp =3D dev->data->queue_pairs[qp_id];
> > +     uint16_t process_id =3D (uint16_t)getpid();
> >
> >       if (!qp)
> >               return 0;
> > @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, uin=
t16_t qp_id)
> >               rte_free(qp);
> >               dev->data->queue_pairs[qp_id] =3D NULL;
> >       } else { /* secondary process */
> > -             return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
> > -                                     NULL, 0, RTE_IPSEC_MB_MP_REQ_QP_F=
REE);
> > +             if (qp->qp_used_by_pid =3D=3D process_id)
> > +                     return ipsec_mb_secondary_qp_op(dev->data->dev_id=
,
> > +                                             qp_id, NULL, 0,
> > +                                             RTE_IPSEC_MB_MP_REQ_QP_FR=
EE);
> >       }
> >       return 0;
> >   }
>
> Hi Experts,
>
> Is there any chance to review and accept this patch?

Don't forget to Cc maintainers.


--=20
David Marchand

