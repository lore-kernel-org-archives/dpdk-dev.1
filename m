Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C83BD26D71
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 17:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 581424028E;
	Fri,  9 Jan 2026 18:04:40 +0100 (CET)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42]) by mails.dpdk.org (Postfix) with ESMTP id 78FB7400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 18:04:39 +0100 (CET)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-93f69720a7cso2918541241.1
 for <dev@dpdk.org>; Fri, 09 Jan 2026 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767978279; x=1768583079; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2e+mltKebl4guqcyhXmjui4lhuPDwDel4GQHD269mU=;
 b=WK7qNiWITmvQxK1Mqwm6md2ORrI4cifdIrvBXBY+AaU8TurfqNAiF+TY2w+3LzBt73
 ezXDbyVGUGnERA9QcZmhL/bTmZpziH7rQkbqiofdAA1XlWOPUjk9A1emTxyswKfXwIuQ
 R/nwylFXgc/SNKwTBlFH5augz2+uWHMfbwLJKwCXE21CluYWxWNgTh7UjjhokCa0NsHc
 rsMvhOexZr3BO8UByh79OqMV8pQk+yKmxblJ6EuF/jEPbDA5qsq5378e3LTzuBAuNkIS
 JQPVkq1tuI1PEw8aajnO7IcGQ8ExnMgBQgHdQg7j+2eOMa7wxtbbmlAV0+5nIm2AgGIk
 As3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767978279; x=1768583079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2e+mltKebl4guqcyhXmjui4lhuPDwDel4GQHD269mU=;
 b=Fz4ASGengRI2o5IsjSPTsR/IXij4aZfs/B09qYXi//BCtZ8HogqqervU0wIBeQpoca
 Z3+sEfzhjkf+jym3ZsJYJZDYSSfZcuYJPLUUpdjcwFVLVRWYguadOP1BEEhxzfiDtam4
 isOGYzWHgumC7wxYFtrYcrL/5pha/nTsxI0ZE0Y1VYRsamUi7mz6K+MBL0KgvkNZJmdu
 jDx5G7/6zforePGvp9qasGNQJ4ZKyVko8PfdVfi74RJKQVhiMy8cNPrQ1rcF7JlEUqax
 KGUDCXZ1MqLqTjSLmP5mV60ZEOZP3945t82gE+qjqsPrAojPBs4r+AE+98BhNyKQ7GhZ
 rYtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd1zndFUB+4UepqQgylIoIrJKAzrDWTUQ9LPymp24KwCpxdI26IAyqLwNiC2KF9eOO54k=@dpdk.org
X-Gm-Message-State: AOJu0YzsTNfEsRzyeuXVh6WYOW1sx9zm/bXNs9hs7Xk+hjN3ZY+E5yde
 VYD1a18RoRKn1g/Bc9hYjfM/ZfsCnVLlV1XmzZj1ShaR1VRP+5k1Jx4GcuDJBoqU/JE7z4KzyzQ
 kt00ujMpNsnNyG3ajhV/NY9r1kFdHQuc=
X-Gm-Gg: AY/fxX6Jv/DiX1D5lY4GeB9jdu0/pnVcJQbEKdTPi8+RDb/CKey4/buTePBaW0WdtZE
 EV0wFHxYQ24sr8SIxA4llMb9H9XwTeHBhVzLUF++bNCPoZWtQ63X4yEzKgUN8ZSmT5C9HV2wKxf
 zhj/QZ1qWy0Llze2S7TZbG+3kH60Ec6o0DYFcVDzdJMWdFKU+3+1ji6eqfNriTGVUAiIZYnmj68
 GkweYTEo8Un64EhPsAecn3+RD/U1BcfCBA/gZjsIWSEfe1SYB8rD53E4jLr8DCoSXvygswU8BWJ
 GdwNntLLFyhIDrlDtbrfn3GeuN0=
X-Google-Smtp-Source: AGHT+IF+qhsce606QQ6CJ1zoIHAwojxfv8M3lLvPZWPUhL+e+hkf4cnABOpTtfHR9QpytdNInSw0laBMa7eOEbQeQxg=
X-Received: by 2002:a05:6102:568c:b0:5e5:7055:66f5 with SMTP id
 ada2fe7eead31-5ecb68db22bmr4584241137.27.1767978277165; Fri, 09 Jan 2026
 09:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
 <20260108081229.60b095b9@phoenix.local>
 <CAFn2buDp4ffHuSXmTrW8mfNHxm-t3FL=TVgMKFAc2gU7fyXPGg@mail.gmail.com>
 <20260108160058.685cf7a7@phoenix.local>
 <CAFn2buCqxz=43Xy6QycxS0KaY9A49bcLrsBOGFoP6MzHE0fnNg@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65637@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65637@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 12:04:26 -0500
X-Gm-Features: AZwV_QiEtfpSpGbyW_2fa3MOtuToQEi1QVI2bt9AgVbhrjERFslf9Emx5FagKRs
Message-ID: <CAFn2buDa=nAfZwdpssfu7sKVeSYjBdQucNToh_qLFNXhe9AQ-A@mail.gmail.com>
Subject: Re: [PATCH v5] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>, dev@dpdk.org
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

On Fri, Jan 9, 2026 at 4:08=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesys=
tems.com> wrote:
>
> +Aaron, please read up on this discussion, and step in if you can help.
>
> (Aaron is the DPDK Project testing leader, and works at Red Hat.)
>
> > From: Scott Mitchell [mailto:scott.k.mitch1@gmail.com]
> > Sent: Friday, 9 January 2026 05.58
> >
> > On Thu, Jan 8, 2026 at 7:01=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Thu, 8 Jan 2026 16:19:37 -0500
> > > Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > >
> > > > On Thu, Jan 8, 2026 at 11:12=E2=80=AFAM Stephen Hemminger
> > > > <stephen@networkplumber.org> wrote:
> > > > >
> > > > > On Thu,  8 Jan 2026 01:13:38 -0500
> > > > > scott.k.mitch1@gmail.com wrote:
> > > > >
> > > > > > +#ifdef RTE_CC_GCC
> > > > > > +     /* Suppress GCC -Wmaybe-uninitialized false positive. No
> > assembly/runtime impacts. */
> > > > > > +     asm volatile("" : "+m" (psd_hdr));
> > > > > > +#endif
> > > > > >
> > > > >
> > > > > Maybe rte_compiler_barrier() will do same thing?
> > > >
> > > > Agreed it feels like a compiler bug but looking for advice if I'm
> > > > missing something :)
> > > >
> > > > My initial concern with rte_compiler_barrier is its a general
> > barrier
> > > > which may have broader impacts on
> > > > optimizations and compiled code. Will that be an issue in this
> > case? I
> > > > wasn't sure and the approach
> > > > in the patch is targeted at a specific variable and assembly from
> > > > clang/gcc was the same. I will
> > > > introduce a macro to make it cleaner and I can replace it with
> > > > rte_compiler_barrier if preferred.
> > >
> > > Maybe try with -fanalyzer and it might tell you more.
> > > I suspect some of the aliasing setting are causing issues.
> > > Some drivers are turning on no-strict-aliasing
> >
> > I have more evidence this is a GCC optimizer bug.
> > The RTE_SUPPRESS_UNINITIALIZED_WARNING approach serves
> > as a workaround to avoid the bug. I created a more minimal reproducer:
> > https://gist.github.com/Scottmitch/bf23748b4588e68c9bdb8d124f92f1bd
> >
> > Your suspicion was correct, -fno-strict-aliasing avoids the bug but I
> > don't
> > think it is desirable to enable this broadly for DPDK when we have a
> > more targeted workaround.
> >
> > I will reach out to RH to confirm but in the interim I suggest we keep
> > RTE_SUPPRESS_UNINITIALIZED_WARNING (or similar alternative).
>
> If this is a GCC compiler bug limited to the GCC version offered by RHEL =
11, I prefer splitting the patch into a series with the following steps:
> Patch 1/2: Add the optimization and new test cases in their minimal form,=
 designed to work on normal compilers. Disregard bugs/warnings from the wei=
rd RHEL 11 compiler.
> I.e. don't modify lib/eal/include/rte_common.h, lib/net/rte_ip6.h, lib/ne=
t/rte_ip4.h, drivers/net/hinic/hinic_pmd_tx.c, drivers/net/mlx5/mlx5_flow_d=
v.c.
> Patch 2/2: Add the workarounds required by the RHEL 11 compiler.
>
> Also, the change to drivers/net/hinic/hinic_pmd_tx.c should be moved to a=
 patch independent of this series.
> It's not directly related to this series, so let's not add more to the di=
scussion than we need to. ;-)
> And the implementation in the driver only considers RTE_MBUF_F_TX_TCP_SEG=
, whereas the DPDK function also considers RTE_MBUF_F_TX_UDP_SEG, so it war=
rants a separate discussion; it possibly fixes a bug.
>
> Maybe even move the RHEL 11 related patches (my suggested patch 2/2) into=
 a separate series, for the same conceptual reasons as moving the HINIC dri=
ver patch into a separate series.
> You can use the Depends-On tag (https://doc.dpdk.org/guides/contributing/=
patches.html#patch-dependencies) for the follow-on changes to __rte_raw_cks=
um().
>

General strategy makes sense!

The GCC bug showed up on dpdk CI on non-RH platforms too
https://github.com/ovsrobot/dpdk/actions/runs/20744990187/job/59560072349.

There is also a ubsan warning flagged while running the new fuzz test
(https://github.com/ovsrobot/dpdk/actions/runs/20821548318/job/59811205423)=
.
Seems like a false positive and I added __rte_no_ubsan_alignment to
get a clean build.

I'll restructure the changes following this approach:
Series: "net: optimize raw checksum computation" (3 patches)
1/3: net: optimize __rte_raw_cksum and add tests
2/3: add workaround for UBSAN alignment false positive
3/3: add workaround for GCC optimization bug

I'll defer the hinic refactoring (switching to common checksum functions) t=
o
a separate follow-up series as suggested, since it's independent of the cor=
e
