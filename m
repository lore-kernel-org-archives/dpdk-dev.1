Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B83C44520
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C45E4402D4;
	Fri, 17 Jul 2026 14:35:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC6D4028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 14:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784291700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryBMAZWFlLMjM+6VeIoHkciD7NL4JfMQh2J65HaOfTY=;
 b=dPRGSo4Zr07Cv8yT5IyZx89jldl/2WkwaJSUGyfSvDD+Zf7IbLZ5dn4QtyPAf7wRVlKjWK
 2m5vzTXBaNZq+hwGdnTCDAvsZ0jqCLxzYXr1ws8RW/e4Yb6h80AZDAEXuSkgaHYN6+yEPm
 tXbsumJHkhU6yKqQ4t/ntmEx9lkUOko=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-klle_dLYPBWnajBPtfrX3g-1; Fri, 17 Jul 2026 08:34:58 -0400
X-MC-Unique: klle_dLYPBWnajBPtfrX3g-1
X-Mimecast-MFC-AGG-ID: klle_dLYPBWnajBPtfrX3g_1784291697
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aec6240ddbso2499107e87.3
 for <dev@dpdk.org>; Fri, 17 Jul 2026 05:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291697; x=1784896497;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ryBMAZWFlLMjM+6VeIoHkciD7NL4JfMQh2J65HaOfTY=;
 b=E0S3MPdeuy6+WnG6tc5f7BlvxEDR+Gp6e1n+ydz4no6hd2sFAE6FaRxR6KofIVDz8X
 vZpzeVvlGETL4B24Zq/3HRU6ulwsRyv5OsuPJqJKoVSSm87oO7zHgbuKMO04oc3ML7uF
 mYPBCUBUpy6PzjM1z41B1r4FeCmwNk7C7DhjhrPMdPnaCBMoPHir1Lp1u0Zd58fteNku
 mPqDQw95QEJLhhtnS/MXnb0psWjvn+U7U6HQIWWvsjOb/RtBKvfxCtHqOjo9DqY+JHn4
 Ar1OYKkaLXq6hzJttDrFYs8vURiHysagH4XgWLyYJT0owTm2VqmNOGXzt/QCT7YxGJCz
 3cGg==
X-Gm-Message-State: AOJu0YxSTDFVC/pIaZfdT3K1Je/SMIlIl/fQrVbmhVMcnZHnt3AYGyXa
 jntff4l4ITFM/qjavH0ytM+wy+FQZaqhYKx0ATuZi5QkUMHz/6ldPgyanD9Tu/j4Aq+AengIr9x
 oU39xgfMfYflol+q0Vm7R0RvEgPmGt1su7HDMzzay0JnxTrV8KpXcN2aVZFoQRA4yG+0FUOPt7J
 WmPsOp266AJ1344alOM7g=
X-Gm-Gg: AfdE7cleiIvVqFFXR1nxCuM/jJBn6ult9UB2mn1iGnaSriv8RglU3Iw/P5pZTxlNyaS
 SDUsvbLmHgPCHQLsWsKNoOWDnuchgdsC6Am9NOdZ/dbkJQ8NtaelaQaPWMqQ+4qJETROwj7sYtT
 mRR7oESBzERJOjlfwahwiU7lRQzJbVaoQj/U2hBTxaFQQ2ud85f8w4evpDX18xEE7ETVrKWGG4Y
 ON6f8czXqXglw7j1p4bNosIACPRMthtpflhVT8VIsZZVvjj
X-Received: by 2002:a05:6512:63ce:10b0:5ae:d7dd:5815 with SMTP id
 2adb3069b0e04-5b28f9ac979mr404521e87.41.1784291696891; 
 Fri, 17 Jul 2026 05:34:56 -0700 (PDT)
X-Received: by 2002:a05:6512:63ce:10b0:5ae:d7dd:5815 with SMTP id
 2adb3069b0e04-5b28f9ac979mr404510e87.41.1784291696344; Fri, 17 Jul 2026
 05:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-7-david.marchand@redhat.com>
 <aln8LkIk5q74OlpT@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zaL+CVOaZ7THPc1yzjC-PYn072sUuSF25WngPdRNBLmw@mail.gmail.com>
 <aloAfU6IdpZOMAlQ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aloAfU6IdpZOMAlQ@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 17 Jul 2026 14:34:44 +0200
X-Gm-Features: AUfX_mzou34d8QFVrjiYrz05wVz-H84H4sehMjliDUQ0Gy9oSEVR64A-Ps_mZ-Q
Message-ID: <CAJFAV8yr_4Wttt7sDUVzqYnAsMYxoTRg3FcNbZefpYzs1v9e0A@mail.gmail.com>
Subject: Re: [PATCH 06/10] test/devargs: check driver presence with public API
To: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 "Xueming(Steven) Li" <xuemingl@nvidia.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bxgwLeNrhUjqQegrzkXyI6O70vgeHRa7bDgxUymKE84_1784291697
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

On Fri, 17 Jul 2026 at 12:15, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Jul 17, 2026 at 12:08:01PM +0200, David Marchand wrote:
> > On Fri, 17 Jul 2026 at 11:56, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Fri, Jul 17, 2026 at 11:30:01AM +0200, David Marchand wrote:
> > > > Let's avoid calling internal drivers API.
> > > >
> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > ---
> > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > One suggestion inline below.
> > >
> > > >  app/test/test_devargs.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
> > > > index 0bd14c24ec..6c194ecfc6 100644
> > > > --- a/app/test/test_devargs.c
> > > > +++ b/app/test/test_devargs.c
> > > > @@ -10,7 +10,7 @@
> > > >  #include <rte_common.h>
> > > >  #include <rte_devargs.h>
> > > >  #include <rte_kvargs.h>
> > > > -#include <bus_driver.h>
> > > > +#include <rte_bus.h>
> > > >  #include <rte_class.h>
> > > >
> > > >  #include "test.h"
> > > > @@ -167,14 +167,18 @@ test_valid_devargs(void)
> > > >               { "net_ring0,iface=3Dtest,path=3D/class/bus/,queues=
=3D1",
> > > >                 0, 0, 3, "vdev", "net_ring0", NULL },
> > > >       };
> > > > -     struct rte_bus *vdev_bus =3D rte_bus_find_by_name("vdev");
> > > > +     struct rte_devargs da;
> > > >       int ret;
> > > >
> > > >       ret =3D test_valid_devargs_cases(list, RTE_DIM(list));
> > > > -     if (vdev_bus !=3D NULL && vdev_bus->parse("net_ring0", NULL) =
=3D=3D 0)
> > > > +
> > > > +     memset(&da, 0, sizeof(da));
> > > > +     if (rte_devargs_parse(&da, "net_ring0") =3D=3D 0)
> > >
> > > From what I/AI can see, there is nothing in this test case that requi=
res
> >
> > (you could write it as "From what A?I can see")
> >
> > > the ring PMD specifically. I think it would be good if it were update=
d to
> > > use net/null, so that we standardize on our basic unit tests only rel=
ying
> > > upon that PMD, rather than requiring a variety of drivers. WDYT?
> >
> > There may be a hidden (capillotract=C3=A9) reason.
> > Passing path=3D/class/bus/ seems to be intended at catching errors in
> > devargs parsing.
> > No argument in net/null could accept such string.
> >
> Not a path string, no, though it can take other parameters. Do we
> specifically want/need it to take a path string?

This is some special case tested for "legacy".
I prefer asking Xueming and Thomas what the intention was.


--=20
David Marchand

