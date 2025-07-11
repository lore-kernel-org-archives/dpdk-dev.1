Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CDDC83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 16:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 067034021F;
	Fri, 11 Jul 2025 18:31:29 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4F5FB4021E
 for <dev@dpdk.org>; Fri, 11 Jul 2025 18:31:28 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-235ef62066eso33854735ad.3
 for <dev@dpdk.org>; Fri, 11 Jul 2025 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752251487;
 x=1752856287; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cp6CPX35a5XWrwW7jZpg8G3MF2zgb8POj5g0wT++rrQ=;
 b=tw3eN+ug/FEOa2sXz5McuP4h4zF5OpOdun7qHb0zCooHgibgeQLhG28eN4sqprCHJT
 9G5psrk/8sMqOj2YrI9sg3Ao3aVL2GIi1jtJ1VmnmNgdJj5zhbQWXTjQikMZzRVizSDm
 5cmNQX5s7/yEmEcV9LtrqtcfU9BamUFVGstHwyWzH6eJehEtaBM/MTvZUYkAJ1iOUbsA
 1kjvTrObLCD140OAtp6CHrOSgjkkIKgf6wQufyOnLcWDg959naXNXGn+r3bRsrbPEN6t
 ztfiK9qVlCvVmYZQF8sLCCKLHRrF2tZoZat/Q3G5E2vrwE8aeQa3zHGIstgAe1peeUQ2
 XVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752251487; x=1752856287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cp6CPX35a5XWrwW7jZpg8G3MF2zgb8POj5g0wT++rrQ=;
 b=WN35w0mSsEablJs23eQn4a8NtNEMhEzH5t9S1hK6ckg69bKsgyv6ywy720qNsvzJJ0
 9IYm6sbz5mmGs8OXeLHhrxjSP3EzQ00taIDrMD1Cfe005lDTGcxcQMJjyYOlGB7hjBwE
 pZ5WTZbrmTpRqTTOO6FJtXhMG4l8yrnGx950GJf//t3Hzjg8f5kVXHfeKQuyVa3D/+sv
 ae+PoEzCWaA+Pjw2OzRrV+zjVl745HhTaHbvLsJrdwsk58DRSJS8EfvnKkFXmMRxgV1t
 +fvN7ZlhiVmfPvYswp5N5fkgH6uRLF5BTqQh6KOjyLwb5/Cm3oYX0eMjzeW3duz5ffvM
 ViXg==
X-Gm-Message-State: AOJu0Ywoa626D285zSFKUJ5M2SNxb0/fhg08vS56X7fcZjtljb4KIh9i
 CqtdgQjAaDTR+Qnh1AxJI7xr0NhuYeO/5AyjbMQZtrf3KLmJVtpV1ME645TBkjgGPeE=
X-Gm-Gg: ASbGncsAgIB1bmkeOTC7njIEiiIuDCKi8uu2OmaV4G2pATm0dJWkUAAHItMYZe31+fJ
 /To+dBveUeMpq9nx+9tlkjr3HDDT3Xc6Ph1pITOTGN4fjciu692oQnUh3tls9JtrYwEPYjGIsWs
 EP3ZYlA3DEb54VbbTihpoafdvvrctNtY9YVb5dzGWWMMvh8P5TqVq8kxwUlhM4v1BS/tWtCKndO
 Ac6of2l8gKfpSOrpC7XGvoaAKQTTeF01DsMYQoLL0590TZC55vqYfYRcuxG32PikK+gca6P0Z+a
 PX97G6UbE4SdaYKPqU07ououLiTDldtu35793O/2+vyTcBQm2TqOksWXb2V3ayBnFjae4+AAUu1
 lN0tayHePr/Iv1JxGL/OzTpC/N6G7XkP3LvplNMtJzh6cznn0WQgtGa0bXLk/hqiTrPOk+w1nMI
 0=
X-Google-Smtp-Source: AGHT+IEX8F4cUGji2k09rOZnu7N2qo+VZrPwoeWabtbGAgXsBR4+wxshiOWjLPDVrcbiXQENXTkVnw==
X-Received: by 2002:a17:903:94c:b0:23c:7c59:c74e with SMTP id
 d9443c01a7336-23dedba0963mr47484455ad.0.1752251487239; 
 Fri, 11 Jul 2025 09:31:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43654e7sm47785655ad.244.2025.07.11.09.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 09:31:26 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:31:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/3] common/sfc_efx/base: fix compiler warnings in X4
 netport API
Message-ID: <20250711093125.0592400c@hermes.local>
In-Reply-To: <2f5f5dd0-f183-81ee-480e-8ec7f64f1398@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
 <20250711075544.2fbbd18d@hermes.local>
 <2f5f5dd0-f183-81ee-480e-8ec7f64f1398@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 11 Jul 2025 19:13:01 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> On Fri, 11 Jul 2025, Stephen Hemminger wrote:
>=20
> > On Fri, 11 Jul 2025 18:43:46 +0400
> > Ivan Malov <ivan.malov@arknetworks.am> wrote:
> > =20
> >> The 25.07 release has got support for AMD Solarflare X45xx adapters [1=
].
> >> This series is a follow-up to [1] to fix compiler warnings in the base
> >> driver that are seen in Windows driver build, also based on this drive=
r.
> >>
> >> [1] https://patches.dpdk.org/project/dpdk/list/?series=3D35095
> >>
> >> Ivan Malov (3):
> >>   common/sfc_efx/base: fix compiler warnings in statistic code
> >>   common/sfc_efx/base: fix compiler warnings in PHY link setup
> >>   common/sfc_efx/base: fix compiler warning in PHY link getter
> >>
> >>  drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
> >>  drivers/common/sfc_efx/base/medford4_phy.c | 1 -
> >>  2 files changed, 2 insertions(+), 6 deletions(-)
> >> =20
> >
> > Have your tried enabling -Wshadow and -Wduplicated-branches and -Wdupli=
cated-cond
> > Those flags are finding stuff in other places.
> > =20
> Thanks Stephen. That is very useful. I tried adding these flags via meson=
.build
> for common/sfc_efx, common/sfc_efx/base and for net/sfc trees and the onl=
y thing
> I was able to find is as follows:
>=20
> In file included from ../lib/eal/x86/include/rte_byteorder.h:9,
>                   from ../drivers/net/sfc/sfc_ef10_essb_rx.c:14:
> ../drivers/net/sfc/sfc_ef10_essb_rx.c: In function =E2=80=98sfc_ef10_essb=
_rx_qsize_up_rings=E2=80=99:
> ../drivers/net/sfc/sfc_dp.h:27:27: warning: declaration of =E2=80=98_a=E2=
=80=99 shadows a previous local [-Wshadow]
>     27 |                 typeof(a) _a =3D (a);     \
>        |                           ^~
> ../lib/eal/include/rte_common.h:817:34: note: in definition of macro =E2=
=80=98RTE_MAX=E2=80=99
>    817 |                 typeof (a) _a =3D (a); \
>        |                                  ^
> ../drivers/net/sfc/sfc_ef10_essb_rx.c:535:33: note: in expansion of macro=
 =E2=80=98SFC_DIV_ROUND_UP=E2=80=99
>    535 |         nb_hw_rx_desc =3D RTE_MAX(SFC_DIV_ROUND_UP(nb_rx_desc,
>        |                                 ^~~~~~~~~~~~~~~~
> ../lib/eal/include/rte_common.h:817:28: note: shadowed declaration is here
>    817 |                 typeof (a) _a =3D (a); \
>        |                            ^~
> ../drivers/net/sfc/sfc_ef10_essb_rx.c:535:25: note: in expansion of macro=
 =E2=80=98RTE_MAX=E2=80=99
>    535 |         nb_hw_rx_desc =3D RTE_MAX(SFC_DIV_ROUND_UP(nb_rx_desc,
>        |
>=20
> But no extra warnings in the base driver.
>=20
> Thank you.

Good thanks, RTE_MIN/RTE_MAX has issues when nested. Not sure if there is a=
n easy fix.
