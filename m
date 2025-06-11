Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828AFC71136
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 20:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22041402DB;
	Wed, 11 Jun 2025 22:29:38 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id D6AEE40144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 22:29:36 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-30e8feb1886so360014a91.0
 for <dev@dpdk.org>; Wed, 11 Jun 2025 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749673776; x=1750278576; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I/jtx1gL52poSgAVSEkhDQ6pFwA0pgkDG3mdiASCnpY=;
 b=HKrAW3PqH4BFPcabxqVOjX2jwAxOT4Rb8myKjCvBYG2icO7bVggIHn84xCp9VP68PX
 eAWZrDTODqvMO///u7qzWDqOH6lhp2mj2ayUsvt7kozWIxKpXqQiSo5MJGCXMJLkyJMk
 zksfhLpGTj5ry4cHvU1tbBr5qM76HDDZAzmMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673776; x=1750278576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/jtx1gL52poSgAVSEkhDQ6pFwA0pgkDG3mdiASCnpY=;
 b=aFwle0la8O18fBRXHMYUEujGYN7RatJcs+SPxMwdtR+QaAlH6gkQV7pK8oSD0mToMa
 C4wDjAtxCp9/CgbEF69OLpPOSTD/pPvFrn34eoyatmnq9W56/nAgM58bu3HFhF51MTpG
 WSKOMK/5/htSbc3vBo7SWlz6ZDR4mMTyoF2oEI1ET/TNw5oGdRVMFxebciU5ESUxq/Lr
 tN+BhRfyOf1gA3FwsQ/Govli81Gi0r1oXXE1KxFgmab9TbsX2JYZp3fjCt/i/10gs3Iq
 o0rxj/cI0GFhBLvEa/Z2rVeOYpSi2994ZjRwWTl+0EHZRiopK2DKe8p15IwJJXkLBnty
 glrw==
X-Gm-Message-State: AOJu0YwsOs1lS0mqdgjQr0HN1Unc/jrDIuoWnfYyRgUNWfBCUPZ00QaY
 v4uzyDOJvMp0bYj6iy95WfjL6s/RF7ovrrcZOVBwSqsDo0LwEFQ/6LNdfcjp1fnVVyfcWAw9XjF
 bBKrghikJE9bjO7Kbyucd5ieVh4PahjC+jnAnLInH1Q==
X-Gm-Gg: ASbGncvzJVp5NnAedhWhW31O0yPMt8wAmcYaYYFj41/BJrpJbuSA2JhBBasbtAdHWLc
 E07FKK9zAWIAz+4zJ6KAuxr4VQixqJMdbgjhCjvaxHc8Hf9Erg3vkbqV9irgKEp3eeycApNMaOs
 Q+YnQ2E74cW0XRFNy5zkxWbdSTdYHaavZVpjcW/QLTy6pA8FSKg5eSbeqF1ONLKASNdlCNkQXba
 vRYIpjn07kEDJQ=
X-Google-Smtp-Source: AGHT+IFoIA8jRG7DBNBMc+RZ3s/3nUh49gcKSASWA/Lut7APHGnSHMCL+bz2Rh2D/u/bBdwG3T6PyNNLQ35Vq0rvbI8=
X-Received: by 2002:a17:90b:3d4e:b0:313:5d2f:5505 with SMTP id
 98e67ed59e1d1-313c08bbaddmr762129a91.16.1749673775721; Wed, 11 Jun 2025
 13:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240821191557.18744-1-jspewock@iol.unh.edu>
 <20250313033611.1896695-1-probb@iol.unh.edu>
 <20250313033611.1896695-2-probb@iol.unh.edu>
In-Reply-To: <20250313033611.1896695-2-probb@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 11 Jun 2025 16:24:25 -0400
X-Gm-Features: AX0GCFuOe4MuGqTmYOsPCVP0PChxlvA6-mUKVA-4zPdMyCcndOvqCWZuGxeIz9A
Message-ID: <CAJvnSUCCU1gVA0tMf-ZUmyAB7tTwd6foL14vhRsb9OMLrz=OEA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: add OS abstractions for creating virtual
 functions
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu, 
 dmarx@iol.unh.edu, Jeremy Spewock <jspewock@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000e008d1063751ab24"
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

--000000000000e008d1063751ab24
Content-Type: text/plain; charset="UTF-8"

Recheck-request: rebase=main, loongarch-compilation

I don't actually need a compile recheck, I'm submitting this recheck solely
as a means of testing/demonstrating the recheck framework rebase function.

--000000000000e008d1063751ab24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span class=3D"gmail-il">Recheck</span>-<=
span class=3D"gmail-il">request</span>:=C2=A0<span class=3D"gmail-il">rebas=
e</span>=3Dmain,=C2=A0loongarch-compilation<div><br></div><div>I don&#39;t =
actually need a compile recheck, I&#39;m submitting this recheck solely as =
a means of testing/demonstrating the recheck framework rebase function.</di=
v></div></div>

--000000000000e008d1063751ab24--
