Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F52C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 10:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52F8540270;
	Fri, 17 Jul 2026 12:08:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 77AF74014F
 for <dev@dpdk.org>; Fri, 17 Jul 2026 12:08:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784282898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OzZ8/APg4O7AgKq9twBMMtk+K/OFu16gxlpLX0iV/0=;
 b=bDZHgIQoxoPqdGpCCO5RpXR0K39z1rnW2P6nPRLxCEe5fHfoPNmu/MZ6zXSOOYMe0nq5aM
 5pCOW/513W0bNpkr/RJb6s9WkBvwthKdyM988Yi2/BU/vkkaxOgFv2JAkUVyRMOOr7yK76
 ojlY9NfJFbd6klyNU9QjybGiMWRLfkk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-U7yoGS8MP_Gn31rBbWu1IA-1; Fri, 17 Jul 2026 06:08:17 -0400
X-MC-Unique: U7yoGS8MP_Gn31rBbWu1IA-1
X-Mimecast-MFC-AGG-ID: U7yoGS8MP_Gn31rBbWu1IA_1784282896
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b291a1420fso382565e87.2
 for <dev@dpdk.org>; Fri, 17 Jul 2026 03:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282896; x=1784887696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9OzZ8/APg4O7AgKq9twBMMtk+K/OFu16gxlpLX0iV/0=;
 b=qrWAIxgEHIs3x8Vezbu0GGEQ/gb5PHVCrrT7CR++PhDvFpqtkzQD+1dFzGCUlM/plh
 Uklly4RZa5PuMocZ7lEHOf9V65b93KvvFoBodBdHatVPAum/XKV6zaxXk11W01SnfIJ8
 F45YxjD0SlJu/50jef4irF7D+Wlt6ZNtcgYz1gvhHBROme313c/NDY3nR4rItdmIucJz
 XYZvab683isKrn850hhA0EBkF5BqpKvYaw+kLc4IuQfjjKAqve68i73ufGZyABU9iC1X
 khFdOap4dIucp1BXzs9tZHzAqWmtV9atKqiX/Bm1WnxDhXfrQMmwjddcDBzYHZSdQTOg
 9WDA==
X-Gm-Message-State: AOJu0YzXclAMcA57hOPT6BEkE3eb7QVzwbml0qWJ6AD+esg/ncpyPfnC
 Tu+a90JMXJ18f7q3rYH1+LoUi71ycTVweX9tEXZ84LbcggpT2OQiQxP4c1kHw7TZhYsRQ9O1BpV
 h5SHWpckjf5+YvkbikZKeskZzaLYZLYovgdSO74f+dzxCHGYGPOEzm0/ULMNcf90qz/5mDwHhpv
 ZBFEQfvKiXA6md8r2zPh//Co7696c=
X-Gm-Gg: AfdE7cnU/ZJlBz2xjk6CE8LCkJhLTD40O489neNVyKYMEgrOHVaITJybV5X6J9/Xe7F
 P3bQ8Twbma92u0+IEvqXOsFQnG59p5DVENMVSesCXTrVGNDvkKAHJb8g9xbwMxjfDJKFDVZy8/R
 swSoDr6tWS4CtYvffI2CSRHnx16EFkTGXIfJM20Tyw3f/PpU6Qb/QSvkc9s9LTF1uY3eOxd27Gh
 45/IJJernrfnUYa6vukJNII7ZuK3rr5ckOaDZ2IdcMMGYzY
X-Received: by 2002:a05:6512:3196:b0:5b1:5d7f:84d8 with SMTP id
 2adb3069b0e04-5b28f9af81emr442295e87.46.1784282895761; 
 Fri, 17 Jul 2026 03:08:15 -0700 (PDT)
X-Received: by 2002:a05:6512:3196:b0:5b1:5d7f:84d8 with SMTP id
 2adb3069b0e04-5b28f9af81emr442284e87.46.1784282895175; Fri, 17 Jul 2026
 03:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-7-david.marchand@redhat.com>
 <aln8LkIk5q74OlpT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aln8LkIk5q74OlpT@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 17 Jul 2026 12:08:01 +0200
X-Gm-Features: AUfX_mwYrloLOMjwQZmMIYyoOnBumCUuZYgq9GQG_r0VX5bj4A0gub9vEjNKYj8
Message-ID: <CAJFAV8zaL+CVOaZ7THPc1yzjC-PYn072sUuSF25WngPdRNBLmw@mail.gmail.com>
Subject: Re: [PATCH 06/10] test/devargs: check driver presence with public API
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OoO5wa0F58AidlSMeis15u-3YGHQN38LOV6HXPps6V4_1784282896
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

On Fri, 17 Jul 2026 at 11:56, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Jul 17, 2026 at 11:30:01AM +0200, David Marchand wrote:
> > Let's avoid calling internal drivers API.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> One suggestion inline below.
>
> >  app/test/test_devargs.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
> > index 0bd14c24ec..6c194ecfc6 100644
> > --- a/app/test/test_devargs.c
> > +++ b/app/test/test_devargs.c
> > @@ -10,7 +10,7 @@
> >  #include <rte_common.h>
> >  #include <rte_devargs.h>
> >  #include <rte_kvargs.h>
> > -#include <bus_driver.h>
> > +#include <rte_bus.h>
> >  #include <rte_class.h>
> >
> >  #include "test.h"
> > @@ -167,14 +167,18 @@ test_valid_devargs(void)
> >               { "net_ring0,iface=3Dtest,path=3D/class/bus/,queues=3D1",
> >                 0, 0, 3, "vdev", "net_ring0", NULL },
> >       };
> > -     struct rte_bus *vdev_bus =3D rte_bus_find_by_name("vdev");
> > +     struct rte_devargs da;
> >       int ret;
> >
> >       ret =3D test_valid_devargs_cases(list, RTE_DIM(list));
> > -     if (vdev_bus !=3D NULL && vdev_bus->parse("net_ring0", NULL) =3D=
=3D 0)
> > +
> > +     memset(&da, 0, sizeof(da));
> > +     if (rte_devargs_parse(&da, "net_ring0") =3D=3D 0)
>
> From what I/AI can see, there is nothing in this test case that requires

(you could write it as "From what A?I can see")

> the ring PMD specifically. I think it would be good if it were updated to
> use net/null, so that we standardize on our basic unit tests only relying
> upon that PMD, rather than requiring a variety of drivers. WDYT?

There may be a hidden (capillotract=C3=A9) reason.
Passing path=3D/class/bus/ seems to be intended at catching errors in
devargs parsing.
No argument in net/null could accept such string.


--=20
David Marchand

