Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA907C369CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 00:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E6A140156;
	Thu, 24 Apr 2025 02:05:39 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 578C7400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 02:05:38 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af50f56b862so237114a12.1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745453137; x=1746057937; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fRNyMldiDPuHa4B1Vh3hA59KipPWPXBoIu/G4hEdLYI=;
 b=HCKfoYju8zfL2wub/fxcoAFFnLAK6bdVZEGifeDnSw6FT2khmPEMW5KcesbKzMgTxM
 MnI0l8pNNm0lqaF68enpOCeTFb65THjsPBvoSt03CYUWmbCkncHYgj+ZSPVIk/PCFBDv
 iTxngISuL0nfdpV1oVOhxxtvi+hqQ+eDSyKGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745453137; x=1746057937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fRNyMldiDPuHa4B1Vh3hA59KipPWPXBoIu/G4hEdLYI=;
 b=r6V4mr+wYW9D6FkX3mVub/UVSgXJvw+ok7KYacoVFMKMlmnaLkTKewoFiPqIxFzLRS
 QOsixu5m/1zn0ODY8kvtMZnJgvQVmGJwrpfrQdMHIimzSM4O9SK5FaymmHAEcqvBy6tX
 qZymjlky0mCEpY3O1ywp0huiF6Cx+T9vjnhUjr61jSGjj/ENEWU05lJMeEK2XpK61aAa
 LtGO6PXrSFXlRJokqrOK8rOPNGIRxgWFasMCjXryLtcamh3c09aAlEI1bogTYmlhcDsI
 qfMRTnrtVMVa6ow6lJd4+7UiLsPNdHSJdJIKMzlbXZ4B+YKb2qgV3UivomjXvl7lb7TJ
 26wQ==
X-Gm-Message-State: AOJu0YznUUM3pbHUGXkmU3/cBlYPMhzQiHnERzJV7yAO9eG9N5DTbVup
 sTjzTOOr6yhpnj8CmyPDHQLpBaHSVSQy4J5K4YeK6+zrNhUtekBIKU8+cjFX/4r5+xdAcz98pj/
 bJrq2SoQd13jKVZJe2kf8w2iTbh5JLN4IGqCHGA==
X-Gm-Gg: ASbGncuWNBDWrjGLoJzheulK0OXWi5meA6JAGjcnDAx4k2CVj3ZcaQb6VKP0OZ5yGIH
 lVmOAGRS4Xsc5k0gTcLaSXey/cKEwwkOoPRRWyTvK/qiKqVfFu/AwikieQOuFoXzALdajvdmCv7
 2NmUhZVXGtPHGFSnTyWoL8dfBTdVfHe5JjOm55GO/kGC1ZWas=
X-Google-Smtp-Source: AGHT+IH9/1aLIb95tZ8PIzd2kaVXcvLAytI2QYCq+iaPBqsprZVOQ0EQ7FrP5Y6li/3BmbmphcV7duDlPaPVsGlz5rI=
X-Received: by 2002:a17:90b:2f0c:b0:2ff:4bac:6fbf with SMTP id
 98e67ed59e1d1-309ed26ac20mr1141935a91.7.1745453137096; Wed, 23 Apr 2025
 17:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-5-nsaxena@marvell.com>
 <CAJvnSUD+DWK3CmzgBxUDe63U6BfeHGnBBPAZaxHuUhewRs-FdQ@mail.gmail.com>
In-Reply-To: <CAJvnSUD+DWK3CmzgBxUDe63U6BfeHGnBBPAZaxHuUhewRs-FdQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 23 Apr 2025 20:01:15 -0400
X-Gm-Features: ATxdqUEtIIFH3Dvw_mZR7U-oxLPLRx7XqRpucnyqOSFiybit_7vRNxjpAGSMBGM
Message-ID: <CAJvnSUDeD7+jmcEU_wEPXxqsZh3mHAXE-UK=bk2H+2AOc7Dhig@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] app/graph: add custom feature nodes for ip4 output
 arc
To: Nitin Saxena <nsaxena@marvell.com>
Cc: dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000358e7b06337afa9c"
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

--000000000000358e7b06337afa9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All tests are passing now:
https://lab.dpdk.org/results/dashboard/patchsets/33044/

Again, sorry about the oversight.

On Wed, Apr 23, 2025 at 4:40=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Hi Nitin,
>
> At the DPDK Community Lab, we inadvertently let CI testing on your patch
> run concurrently with some system maintenance we were doing on testbeds
> yesterday, and I think the testing on your patch was affected (so you got=
 a
> couple fails when you should not have). I'm going to put in some retests
> which will correct the record within the next couple hours.
>
> Recheck-request: iol-intel-Functional, iol-unit-arm64-testing
>

--000000000000358e7b06337afa9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All tests are passing now:=C2=A0<a href=3D"https://lab.dpd=
k.org/results/dashboard/patchsets/33044/">https://lab.dpdk.org/results/dash=
board/patchsets/33044/</a><div><br></div><div>Again, sorry about the oversi=
ght.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 23, 2025 at 4:40=E2=80=AFPM Pat=
rick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr"><div dir=3D"ltr">Hi Nitin,<div><br></div><div>At the DPDK Communi=
ty Lab, we inadvertently let CI testing on your patch run concurrently with=
 some system maintenance we were doing on testbeds yesterday, and I think t=
he testing on your patch was affected (so you got a couple fails when you s=
hould not have). I&#39;m going to put in some retests which will correct th=
e=C2=A0record within the next couple hours.=C2=A0</div><div><br></div><div>=
Recheck-request:=C2=A0iol-intel-Functional,=C2=A0iol-unit-arm64-testing</di=
v></div></div>
</blockquote></div>

--000000000000358e7b06337afa9c--
