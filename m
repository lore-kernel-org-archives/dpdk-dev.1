Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72070CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 15:29:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2BF4026C;
	Fri, 15 Aug 2025 17:29:15 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id CBD7F4003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 17:29:14 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-244582a738dso14042385ad.2
 for <dev@dpdk.org>; Fri, 15 Aug 2025 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755271754; x=1755876554; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7wX5LhLBVKzxgwiQSbQ0AcCrkKWAOSX11tug/an5UxQ=;
 b=C5Q1GJI8jUpyyLeRWNTskoLhKOPJLIhE6s7D7EsKML3snpyDDMepZomawJ2X9av8qk
 LBz20wwctaOFrZwKXNdk4bov2aPNlKWIXxppclaK2PkPeLXjLmjTSzLG+f5/xzO+96YA
 EPJm+xxki7WUvU/Vq5TuXwK78sR4c5ejITNos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755271754; x=1755876554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wX5LhLBVKzxgwiQSbQ0AcCrkKWAOSX11tug/an5UxQ=;
 b=n3DRSHIDPoKrppR3eyq5vVXIkPA9wnt9HNG3Y6zO1gifaJwn8uWG88mBTM/hXT4gWC
 kPqGo5BECnKaf4p+QtASkmwGftYK76wIe1ssVBuolhrqeWHYGV8cjwxa8tc/7uV0z9tj
 n9LwZTMntvsFhynIAbU9/DOsSJAScEbEd5y6ThyU7Q2o71NW0FmZls7XHi1Gorqc1pNb
 w7y8QrReNS8zSYz5B+rcrbsWu+s6RALV1VOH48BM9Gxu0ADM00W1OFa7bMuCUrs7nQNO
 244TF4E63gbQQXKW4/uMU3ujH1R3fJ83AUyBgTmgOt2n135TWfylf6SGV7RVY/TqbLSr
 00qw==
X-Gm-Message-State: AOJu0Yw/hUvh1dgjHsnSD5Qv4aVrjzvMdpVew1Jou2/ARt93FQwTz5mY
 2WMLU4ArdofjuTS//h3qKwnsT9UWF0WuZJ1+h6rx/Z8N0k5N8m1d9EAjlV1sPCxKYrTsIxskIh5
 8M2nz9V0Qc9briUIBUiZCydavBMSfNwruX7Llzq4cdOP6zE60M/HMbog=
X-Gm-Gg: ASbGncuhp5NjXeeBfR43MAImwyO3D53oLr+w64etK03xYlgU2T8WpdXXzSZOiYu2+/h
 j/ZMFImg5bGl2fpMxoJZq62Ud4xaErYdrIDPxDNJ27V8zQb3kJ/iX56sjkV6czg7BZ33nU34djD
 mdxof3syWy2bGYvLij/FJnblNK118y3aHYTj8s7JzpOb9qEkXvXHI9uvD2GytbZ8USlxWmnQj2Y
 Zd0Ic5qSqpw2QBHPNt2XgtXqrm8Za65w0MgUk9zOahk+60WuKw=
X-Google-Smtp-Source: AGHT+IE/wmXJY6zRD+/AoX2OSwfnPeTm+UoE1u2qKsApxJKqLqgNSCSVSy88CuNVbeNfMGVjVrpqcaQIswccMNqbzSU=
X-Received: by 2002:a17:902:ea08:b0:243:963:2a70 with SMTP id
 d9443c01a7336-2446d71fb9dmr37691135ad.25.1755271753898; Fri, 15 Aug 2025
 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250813152829.457463-1-thomas@monjalon.net>
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 15 Aug 2025 11:22:48 -0400
X-Gm-Features: Ac12FXzPNw679lf92bc_BxZcY_61Q622YFS4zTlVwSIaD7EgoVRJe497J86aWPo
Message-ID: <CAJvnSUB1b4wNFpHw5NmBssGTN==9UOFonNVqt7QTbfMphXNVnQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix build with MinGW 13
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000060312d063c690d87"
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

--00000000000060312d063c690d87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sending a CI testing retest for this series because of a suspected false
failure on the dynamic config testsuite.

On Wed, Aug 13, 2025 at 11:28=E2=80=AFAM Thomas Monjalon <thomas@monjalon.n=
et>
wrote:

> After an upgrade to MinGW version 13, some compilation errors appear
> in PCI, mlx5 and bbdev code.
> This series fixes them all.
>
> Thomas Monjalon (3):
>   bus/pci: fix build with MinGW 13
>   net/mlx5: fix build with MinGW 13
>   bbdev: wrong fix for MinGW 13
>
>  drivers/bus/pci/windows/pci_netuio.c      | 6 ------
>  drivers/bus/pci/windows/pci_netuio.h      | 4 +++-
>  drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
>  lib/bbdev/rte_bbdev.c                     | 9 +++++++--
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> --
> 2.47.1
>
>

--00000000000060312d063c690d87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sending a CI testing retest for this series because of a s=
uspected false failure on the dynamic config testsuite.</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Aug 13, 2025 at 11:28=E2=80=AFAM Thomas Monjalon &lt;<a href=3D"m=
ailto:thomas@monjalon.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">After an upgrade to MinGW ver=
sion 13, some compilation errors appear<br>
in PCI, mlx5 and bbdev code.<br>
This series fixes them all.<br>
<br>
Thomas Monjalon (3):<br>
=C2=A0 bus/pci: fix build with MinGW 13<br>
=C2=A0 net/mlx5: fix build with MinGW 13<br>
=C2=A0 bbdev: wrong fix for MinGW 13<br>
<br>
=C2=A0drivers/bus/pci/windows/pci_netuio.c=C2=A0 =C2=A0 =C2=A0 | 6 ------<b=
r>
=C2=A0drivers/bus/pci/windows/pci_netuio.h=C2=A0 =C2=A0 =C2=A0 | 4 +++-<br>
=C2=A0drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-<br>
=C2=A0lib/bbdev/rte_bbdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 9 +++++++--<br>
=C2=A04 files changed, 11 insertions(+), 10 deletions(-)<br>
<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div>

--00000000000060312d063c690d87--
