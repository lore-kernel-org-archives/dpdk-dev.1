Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3971C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:23:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C8440292;
	Mon, 16 Jun 2025 09:23:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CEE484027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750058636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXsA3aX4t+hgRqEINuJWkah2WQvlZpnXAzQ7mH7DykA=;
 b=S0El0ttLKhmOhC/0o1f1xs41mczhkHje7J6p0oK5ZKovfQTmKzL3OH5ARKUSgcnZJsvUam
 zy6d3g7YiaztFiQWh342lX311B4kyzXK1K3ubd3Ew02kjTKbQEZ6h/aq5g6Kr45NpzI5qm
 kGn3Rz6Hvz8dr+B0unlTaLLOj4TyzNs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-GheefZTXOaWK0bC8WRTbYA-1; Mon, 16 Jun 2025 03:23:54 -0400
X-MC-Unique: GheefZTXOaWK0bC8WRTbYA-1
X-Mimecast-MFC-AGG-ID: GheefZTXOaWK0bC8WRTbYA_1750058633
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-32b48369fadso8790901fa.0
 for <dev@dpdk.org>; Mon, 16 Jun 2025 00:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750058633; x=1750663433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXsA3aX4t+hgRqEINuJWkah2WQvlZpnXAzQ7mH7DykA=;
 b=rFKmExFYzX2QBz1hC272rtplj0m+UtxZl29BZxLF+/xcyi9waJh28GI71CEbWA3old
 N6qJQV1KIviFA8dusd+w7OpA84YtN60mDYeeLXMfRDmb+2T73IJiQ9NTR8nJnQW1RABc
 fDxFrkIwDKd3HFvZwhtcBKa65xjk4Jl3Zy8I3+g39kQpAMfHp++LEpXItU7O52jkpe6B
 JcFDO/r+9353/Hp307aFMMGh0Vt1jOPPzLv+P8F36+aWeQgEekHgFhB9uKcjjVp7LNQ5
 ff7DRIzr/k0tTVklLCmx8NDa/2EKM4W+iLhIIo76pNlHLmQs+Pw7m1p9/a4NYbNEcWfZ
 3PLg==
X-Gm-Message-State: AOJu0YwlY+CQXPnGkFdo57lZ/gY1nXZFpbW78cp0s5wzkOP7X2s4+SCR
 doDUZYKwWtHyqHZB6QCPVjDmKnGCwbymqMKbJ+9DNRz8+ciDyoAA+dn2EGwEV/4gf6nIL3/5tLa
 dC7vDTUAH3j4cZXQrjtQuleQbnoZ8QwMEBmv/rvQB2mVj66aCkn+I6fuYD1ykaRgiWKz/iSMSCC
 xGxnKcZeQpxrYuL+jFcQU=
X-Gm-Gg: ASbGncsAE1TAKmbmbFiNeexG/4fS16P9TFNmaNBUzRtNWSmodMW6yv3QLHkwSeu8FFb
 SFpWhI7rx3LDkhm/gjfOlcV4CDO0SYAFe3KmCD7Y+/ZZXCXovSm/MsGOGwAHBYPSG96F7/8bwF4
 OQcsvVSA==
X-Received: by 2002:a05:6512:3196:b0:553:9d73:cb15 with SMTP id
 2adb3069b0e04-553b54d984amr2621931e87.15.1750058633242; 
 Mon, 16 Jun 2025 00:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFsA0LtwpTSc5A7tJJ3k++UlI/n3g1NzWvdvpx3jjk97AzUzv7u83qvMdPvk6MnnRGu3Wo/3XRuPMNJDS2zVA=
X-Received: by 2002:a05:6512:3196:b0:553:9d73:cb15 with SMTP id
 2adb3069b0e04-553b54d984amr2621923e87.15.1750058632787; Mon, 16 Jun 2025
 00:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-2-git-send-email-andremue@linux.microsoft.com>
 <aErsNWFWWEoANVyV@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aErsNWFWWEoANVyV@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Jun 2025 09:23:41 +0200
X-Gm-Features: AX0GCFtiIDUyuOQ7FuiJIBy4w253qlkB_YnqUuDnuOc0KPvZcGSfNB00oT8EPSU
Message-ID: <CAJFAV8wx0yZXctq90Q2b4PBoA6GVrpMgKQCudWgij==Lf4cDAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] app/test: remove use of non-standard array range
 initialization
To: Bruce Richardson <bruce.richardson@intel.com>, 
 Andre Muezerie <andremue@linux.microsoft.com>, Akhil Goyal <gakhil@marvell.com>,
 "Ji, Kai" <kai.ji@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UKD7L4jy6Z9FjUD0tC-QSq6toJDCT_UXN3poHcQQmRQ_1750058633
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

Adding Akhil and Kai Ji,

On Thu, Jun 12, 2025 at 5:04=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jun 12, 2025 at 07:17:20AM -0700, Andre Muezerie wrote:
> > Array range initialization is non-standard and is not provided by
> > all compilers. MSVC does not implement it and ends up emitting
> > errors like the one below:
> >
> > drivers/net/r8169/r8169_phy.c(380):
> >     error C2143: syntax error: missing ':' before '...'
> > case CFG_METHOD_48 ... CFG_METHOD_57:
> >
> > The fix is to explicitly initialize each element in the range.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++++++++++++++++-
> >  1 file changed, 153 insertions(+), 3 deletions(-)
> >
> > diff --git a/app/test/test_cryptodev_zuc_test_vectors.h b/app/test/test=
_cryptodev_zuc_test_vectors.h
> > index 714d681fba..e694cc3922 100644
> > --- a/app/test/test_cryptodev_zuc_test_vectors.h
> > +++ b/app/test/test_cryptodev_zuc_test_vectors.h
> > @@ -1067,7 +1067,57 @@ static struct wireless_test_data zuc_test_case_a=
uth_4000b_mac_128b =3D {
> >       },
> >       .plaintext =3D {
> >               .data =3D {
> > -                     [0 ... 499] =3D 0x11,
> > +                     /* [0 ... 499] =3D 0x11, */
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*00*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*01*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*02*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*03*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*04*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*05*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*06*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*07*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*08*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*09*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*00*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*11*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*12*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*13*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*14*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*15*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*16*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*17*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*18*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*19*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*20*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*21*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*22*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*23*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*24*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*25*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*26*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*27*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*28*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*29*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*30*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*31*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*32*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*33*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*34*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*35*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*36*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*37*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*38*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*39*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*40*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*41*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*42*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*43*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*44*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*45*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*46*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*47*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*48*/
> > +                     0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0=
x11, 0x11, /*49*/
> >               },
> >               .len =3D 4000
> >       },
>
> This is very ugly to have the source code. Can we find a better way to do

On the other hand, this file is already full of fixed arrays filled
explicitly (like zuc_test_auth_5670b for example).
I would just drop the comments and avoid a special init case just for
this array.



> this, e.g. init this at runtime using memset, or else just disable the
> build of this test case on windows?


--=20
David Marchand

