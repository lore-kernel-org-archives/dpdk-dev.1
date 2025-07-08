Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DCC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 23:03:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDC5D40E12;
	Wed,  9 Jul 2025 01:03:34 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 630CF40BA0
 for <dev@dpdk.org>; Wed,  9 Jul 2025 01:03:33 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b34a6d0c9a3so4994316a12.3
 for <dev@dpdk.org>; Tue, 08 Jul 2025 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752015812; x=1752620612; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PKnY13UQ2l+eOE1833TlkVoknJ0UUC5AbRLhonTgrPo=;
 b=bgo9UzIQJKViYQFNKok+auh010gznoBZcI25z159d2IQvwTEhogU9jKVA3XunYOgFC
 QpCOUllWE3ehmMkAFAGWwG+ePTzhaWRp+M/wicGOfCtDHuqE+6wnFt0HcTu5vzHTk8O2
 XAz7Dw0D3rdekQxEu9eSmh43ZU92zNAioxU4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752015812; x=1752620612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKnY13UQ2l+eOE1833TlkVoknJ0UUC5AbRLhonTgrPo=;
 b=f6/01JF7YdiLBd9TOVcRcqMkpv3JuckCvU5t7FCHb+f4stmRl+WKEn3iNe+aEP0eIr
 xhyJ27863cLNzz+ayQRIl4j0zbswnRKLIGEjgUir8XIGJd/9koB6bILXbnBXTEbYmKEj
 wRCZWoBOTmbQ5/OcDIiKiX7pqF6zZV5W1WiupdrkU4GLCPv3dQsZ1xx2i5TI/jnbcclW
 6cQt7mGkgc3Ak5kZZTwxmpE5ptsAGwRwUmR/8/3+RopO2i2XhZLgtGbPok4JqwwAS+iG
 P36AKJdzpZIuhY41bMM0+p+qP9a+qM9R/xWUIhtwL0NQG+gieKSGFTdDF3XP8XwTcuH4
 3p/A==
X-Gm-Message-State: AOJu0YyyEGHoECkZ0OOPh8WUy5IJPOWSYA5Sstd4x0z0WxE/YXu8llIK
 GpSDysoeJBkaT6GF89HEgaFN/9Z9MO8+4tdbGN+I86Bm/Ez6+c2wKNgFGBro5Je2/QaxNADyZxi
 tgksvDzvyON56gdH9Ni/VTsp3s+skO4TMDLg9zPayQMgUh74EdqKA
X-Gm-Gg: ASbGncsX7xTge6q7ZOrf8J9RLoJfzW93ohBJqjOPJpbEjcPlg9LfTPw2wlnMyQf8k5T
 GOgGfM2t8OFeikqI/LErSHoCrMgg1eXYygUtZP91TdCgP9OkPKPYBtSrDd7FGYLmSVpUc1ih4ND
 QCidGYX0B+OVAia2YYohnT7H/8BBMuahU0IPaNI1x2Lk8yrPl8NWtl72nGhQ==
X-Google-Smtp-Source: AGHT+IGPLBFhgu73o13M9LxQ+Tk1MP7m3gcgHL7wlj1EiHK4lQtYnTcnwB8gYZD/Z7ZQzHaqRPoRViAYOQ8p9NXms3E=
X-Received: by 2002:a17:90b:35c7:b0:311:f99e:7f4b with SMTP id
 98e67ed59e1d1-31c2fdc600fmr521894a91.28.1752015812079; Tue, 08 Jul 2025
 16:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUCDkunBMDbh+VH2Nzzf-R-h6-PNG-xAJY_zQfRNmhTF7w@mail.gmail.com>
In-Reply-To: <CAJvnSUCDkunBMDbh+VH2Nzzf-R-h6-PNG-xAJY_zQfRNmhTF7w@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 8 Jul 2025 18:57:49 -0400
X-Gm-Features: Ac12FXzKqhDC6OewYoza8Yk1QPDIP4L4OxQs86IwhjfcG9ZNFykwZZBV1h0wKL0
Message-ID: <CAJvnSUBiROu1_iOCb_hPKGF+ggOkRLgeQ0=95oVCmE3ir5DCpw@mail.gmail.com>
Subject: Re: DTS WG Meeting Minutes - July 3, 2025
To: dev <dev@dpdk.org>
Cc: "ci@dpdk.org" <ci@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000001ec7a1063972f886"
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

--0000000000001ec7a1063972f886
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:56=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> #####################################################################
> July 3, 2025
> Attendees
> * Patrick Robb
> * Manit Mahajan
> * Dean Marx
>
> #####################################################################
> Minutes
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> General Discussion
> * NA
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Patch discussions
> * Merged since last meeting:
>    * doc: elaborate on per test suite configuration dts docs
>    * Devbind initialization bug
> https://patchwork.dpdk.org/project/dpdk/patch/20250616183859.646384-1-dma=
rx@iol.unh.edu/
>    * Fix deterministic doc
> https://patchwork.dpdk.org/project/dpdk/patch/20250611140530.51551-1-cfam=
ullaconrad@suse.com/
>    * L4 port # packet matching
>    * Packet capture testsuite:
> https://patchwork.dpdk.org/project/dpdk/patch/20250506132933.1580584-4-lu=
ca.vizzarro@arm.com/
> * Current development:
>    * Single_core_forwarding perf test:
>       * Patrick submitting a new version today
>

Although the single core forwarding test is running, there are some updates
required for the patch which were too significant to fit into this release,
so it has been pushed to the next DPDK release.


>    * VF support and testsuite
>       * Dean submitted new version - this one has VF creation logic moved
> to topology.py and properly resets sut ingress port and sut egress port t=
o
> the VFs
>          * Only supports 1 VF per PF. This allows us to validate most of
> the VF capabilities we are interested in testing, but may limit us on
> testing certain workloads
>       *
> https://patchwork.dpdk.org/project/dpdk/patch/20250617201358.708638-1-dma=
rx@iol.unh.edu/
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Bugzilla discussions
> * None
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Any other business
> * Next meeting is Jul 17, 2025
>

--0000000000001ec7a1063972f886
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 8, =
2025 at 6:56=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.ed=
u">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr">######################################=
###############################<br>July 3, 2025<br>Attendees<br>* Patrick R=
obb<br>* Manit Mahajan<br>* Dean Marx<br><br>##############################=
#######################################<br>Minutes<br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* NA<br=
><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch di=
scussions<br>* Merged since last meeting:<br>=C2=A0 =C2=A0* doc: elaborate =
on per test suite configuration dts docs <br>=C2=A0 =C2=A0* Devbind initial=
ization bug <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/202506=
16183859.646384-1-dmarx@iol.unh.edu/" target=3D"_blank">https://patchwork.d=
pdk.org/project/dpdk/patch/20250616183859.646384-1-dmarx@iol.unh.edu/</a><b=
r>=C2=A0 =C2=A0* Fix deterministic doc <a href=3D"https://patchwork.dpdk.or=
g/project/dpdk/patch/20250611140530.51551-1-cfamullaconrad@suse.com/" targe=
t=3D"_blank">https://patchwork.dpdk.org/project/dpdk/patch/20250611140530.5=
1551-1-cfamullaconrad@suse.com/</a><br>=C2=A0 =C2=A0* L4 port # packet matc=
hing<br>=C2=A0 =C2=A0* Packet capture testsuite: <a href=3D"https://patchwo=
rk.dpdk.org/project/dpdk/patch/20250506132933.1580584-4-luca.vizzarro@arm.c=
om/" target=3D"_blank">https://patchwork.dpdk.org/project/dpdk/patch/202505=
06132933.1580584-4-luca.vizzarro@arm.com/</a><br>* Current development:<br>=
=C2=A0 =C2=A0* Single_core_forwarding perf test:<br>=C2=A0 =C2=A0 =C2=A0 * =
Patrick submitting a new version today<br></div></blockquote><div><br></div=
><div>Although the single core forwarding test is running, there are some u=
pdates required for the patch which were too significant to fit into this r=
elease, so it has been pushed to the next DPDK release.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=C2=
=A0 =C2=A0* VF support and testsuite<br>=C2=A0 =C2=A0 =C2=A0 * Dean submitt=
ed new version - this one has VF creation logic moved to topology.py and pr=
operly resets sut ingress port and sut egress port to the VFs<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* Only supports 1 VF per PF. This allows us to vali=
date most of the VF capabilities we are interested in testing, but may limi=
t us on testing certain workloads <br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"htt=
ps://patchwork.dpdk.org/project/dpdk/patch/20250617201358.708638-1-dmarx@io=
l.unh.edu/" target=3D"_blank">https://patchwork.dpdk.org/project/dpdk/patch=
/20250617201358.708638-1-dmarx@iol.unh.edu/</a><br><br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* None<b=
r><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any othe=
r business<br>* Next meeting is Jul 17, 2025<br></div>
</blockquote></div></div>

--0000000000001ec7a1063972f886--
