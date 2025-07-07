Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF82FC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 15:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 135EE40287;
	Mon,  7 Jul 2025 17:37:15 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 6733D4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 17:37:13 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-31329098ae8so2538921a91.1
 for <dev@dpdk.org>; Mon, 07 Jul 2025 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751902632; x=1752507432; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OQXiUgtia0yACMoYC5DOuToT6qx73v87N5cwWEyzwx4=;
 b=ECUKYWBylSVjbZyX1llfQWHuNzCSG8IuBCjj36CwGJLw0vh4AFZOrEGfYwOGMaOmFz
 hGaUAOePnpbnZQkx7OJnsp1x91CPXiTF5ID+NSFW5ohj1F1BhlL0KLqTJ99qtVwbhMfh
 0utw0O6/oaKz7m5CwDoTFkFppREhnwMOKDTPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751902632; x=1752507432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OQXiUgtia0yACMoYC5DOuToT6qx73v87N5cwWEyzwx4=;
 b=GBAKtyC2lTyqrcO+NUXpu6L0aQ/mHorll5ipJ8kJWTKR36HUYnphu2bDSYWZbnKLFR
 qjkIjqx7YyT2NKra22TT/A0dOmGoI9Rb8ilwYzohO0T2125zv2vkQpg0AlOsu5nsyUln
 TFko7FFavCZFcjuTYSgOj0rG4UTWMzNHwvRoKOXqyXIvZwiZoGF7RjPo6drbW2jr7+fY
 Wy+DK56K18KvIpZGo6ibarFXqR/AdKK/RTzZi54qPIQZ6KGuViHM3Z51GbGPmIybfBzB
 iLPK9hyM67EsPoEJOS2FwaspoqQTecqSMqcdOYUY3X0VhGaiAax4rEz5t6kWijLyUE/X
 7vYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBISrh291hzfoZptIkq91M9l/0ZcixdOt1iafl32umcp8duqy47NoB9BPtIC7Gk9Ww7Pg=@dpdk.org
X-Gm-Message-State: AOJu0YxUjW97ktYUHiI4fJO7rbfMuHYx9EoHMVPbKSIdMf/sfld3+Oke
 6ezNbly/af+ig1vSKddGPkBGTDvFkezc6B7XYTQiPQ0FNTbVaHIGjgVGLBhen1KLpV5fLDHZXts
 QMVk6NfGiDHwaetqN35Q4g0mtwwXnQIobrQwS68eDsg==
X-Gm-Gg: ASbGncsO3ZKu/dPRuprKBoWpedeEzYg7H7OKdjqUjK4UhNFEuwQat7Y9mFTtz+3OSsC
 TY1S6DIUYiejopS4IYfsbLESd4D8rpq1LJ7yLwQZr8sjdP0Bp/qDSzzL1U5YQ9rgErIekPZT0He
 s9AEH55FmKu0Mprosh9KyzoTv1+rN3yWWOM5rC4qX3j779UEUFXzbDvvLUrOz7axUkxVpV
X-Google-Smtp-Source: AGHT+IFMMlTCaKJv+/NFXUuRr1exdcePmYZCk2YT1g0GoN9Fw4bMqlj34NXtVqdWKT0ddNRv1nZ4VG/bQW/nWOvzmIk=
X-Received: by 2002:a17:90b:280a:b0:311:c970:c9c5 with SMTP id
 98e67ed59e1d1-31aab855a35mr19221587a91.7.1751902632118; Mon, 07 Jul 2025
 08:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
 <CAJvnSUAO7iBHp9Fm7WiCrCfou3JByrYsL8ZyufcO9VZh-yNM1w@mail.gmail.com>
 <CAJvnSUBxJofw934abTkeBX8ConPxUPj=XKSv3u8EuxFBRiZfAg@mail.gmail.com>
 <CAJvnSUA1PM01oHvsRRt7mru5Tuj-rjMh+hOjR3zG9g1WkD-wrw@mail.gmail.com>
In-Reply-To: <CAJvnSUA1PM01oHvsRRt7mru5Tuj-rjMh+hOjR3zG9g1WkD-wrw@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 7 Jul 2025 11:31:31 -0400
X-Gm-Features: Ac12FXwiogxGWqxJ7zkNZp8l7hzi8YCU4jM059rLPUoI8RCsVVD-H5J_WhZ2sNo
Message-ID: <CAJvnSUB=fV6cgkxVsEzdb9ofm9HVN9WxLi3haL8b7=xKgcYUtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dts: add virtual functions to framework
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000011a2ab0639589e27"
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

--00000000000011a2ab0639589e27
Content-Type: text/plain; charset="UTF-8"

FYI based on conversation with Dean I pushed a fixup adding
the use_virtual_functions: false field to the test_run.example.yaml, so
that users can more easily understand how to enable the VF testruns.

https://git.dpdk.org/next/dpdk-next-dts/commit/?id=934206f3bfc10fb8dcd852479f3683c01a18e352

--00000000000011a2ab0639589e27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FYI based=C2=A0on=C2=A0conversation with Dean I pushed a f=
ixup adding the=C2=A0use_virtual_functions: false field to the test_run.exa=
mple.yaml, so that users can more easily understand how to enable the VF te=
struns.<div><br></div><div><a href=3D"https://git.dpdk.org/next/dpdk-next-d=
ts/commit/?id=3D934206f3bfc10fb8dcd852479f3683c01a18e352">https://git.dpdk.=
org/next/dpdk-next-dts/commit/?id=3D934206f3bfc10fb8dcd852479f3683c01a18e35=
2</a></div></div>

--00000000000011a2ab0639589e27--
