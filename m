Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB2EC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D717F40289;
	Wed,  5 Feb 2025 11:05:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BDA6A40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738749944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jl2u6sl7niaideRBrZhHIhp2oiUIM7xv0oTwtSSRVzQ=;
 b=MBddejROSj33Kb9RPIDJMOacIA2Zlg7bD0GThQ/H27rNk/d/K1nKj8WlzvBkagvUokGfGw
 +kxyM4Ju+zaGyDbosW+Sro2eBI+YklfyxsmoXoaEsBS81tvWnFLS51bVgMLDPXOw8vwSpU
 fNo1fvjgx0HzkG5BaniOTH0h0rBbDJM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-LMaqUD03MtSpiNicNXAP_A-1; Wed, 05 Feb 2025 05:05:42 -0500
X-MC-Unique: LMaqUD03MtSpiNicNXAP_A-1
X-Mimecast-MFC-AGG-ID: LMaqUD03MtSpiNicNXAP_A
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-543bb2be3dcso4211540e87.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 02:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738749941; x=1739354741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jl2u6sl7niaideRBrZhHIhp2oiUIM7xv0oTwtSSRVzQ=;
 b=XQW+8P7Z2PYxxuyqbzF/yVhWNzTDncoGwflznfFWunYN6NpAX9VUgQGyaNmobUNlsT
 cLJHc47vQpQCyLo9r04GwWOzMZKx1LAhiIhkPq83L+Uikg83UMko00X1CZgsYu6SwJ92
 HKI3ViHE3S33k1ouGrmwjy4/4pSq98c4GEC6EQupZClHuf/nZf1/ZwrsAdOeT5b5OIfP
 Aodc7OAbAl05tYUr0yd4Tz7bmE0xrv7rZ9fsMiloj/BDy3yWnQWBtlsFFdpbMX2+QBwM
 jmLk2paTdwwqbyQKXA8XnHwXFaMoH3lVfKeCmu7RI6ee1yu2uo0JQV5uDeK3m26wMQrk
 ZJOA==
X-Gm-Message-State: AOJu0YxpXyd3d5eOJ9ReZRsM30t+fvn37SPJzK2eLKkUSQkME1NysXbi
 coac99JUnC58CtoqpiRqk05gTn3gKN+sy47uQWULp2EEdwIVX9rDfZvnl3x3l7+HREiTDs/xay6
 FHE90Zg2JJ0mhR74i0wzcFFBYQz5clp/UhuEQ9Xmu8c4qUL1EOxrfujbLMZ/xxd+jdL6N1HUOaY
 g8ih867ZH6ETHpmhs=
X-Gm-Gg: ASbGncsozw50kJ3kpEC3Uj101K57W4OlYfSMIf/CrkLjX1pcntaU5TNd9asKSTvp9O1
 Hn47OIUPDmYxuI6QBZ3FoJR4cF8WCGKSb5+lMc3y0QCatF8jhJAQ+wVco/BquE6p8
X-Received: by 2002:a05:6512:b97:b0:540:1b07:e033 with SMTP id
 2adb3069b0e04-54405a6a714mr818988e87.45.1738749940607; 
 Wed, 05 Feb 2025 02:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzYFl6RC3JCGynioGNWXGoPQaRBtXWAFX0wLDzFY814kQDZrrj4Adb3BiIvJmuKhunxBKSNcWWhWzoWPRm314=
X-Received: by 2002:a05:6512:b97:b0:540:1b07:e033 with SMTP id
 2adb3069b0e04-54405a6a714mr818958e87.45.1738749939127; Wed, 05 Feb 2025
 02:05:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <CAJFAV8yY+T7S49daG+yRedGzvhis3iUC2yznvae7ZW4WEE4n7Q@mail.gmail.com>
 <ac303c68-e335-41d3-b2c8-721f9f0e3aeb@intel.com>
In-Reply-To: <ac303c68-e335-41d3-b2c8-721f9f0e3aeb@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Feb 2025 11:05:26 +0100
X-Gm-Features: AWEUYZll43kqggWI6O-hL__BE9FKlKdYkx_xBjkIIXbnME775G-VagtnAbbtEds
Message-ID: <CAJFAV8wtmGscd2ujOmLcS5uddQRCob+ywLY44Wn8CaR4wLQ=5Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/42] Merge Intel IGC and E1000 drivers, and update
 E1000 base code
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zs5DQgcrKJsSpGbfor33WuS3Gf3pzgGoSWGw7PCG-RY_1738749941
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

On Tue, Feb 4, 2025 at 4:36=E2=80=AFPM Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 03/02/2025 9:18, David Marchand wrote:
> > Hello Anatoly,
> >
> > On Fri, Jan 31, 2025 at 1:59=E2=80=AFPM Anatoly Burakov
> > <anatoly.burakov@intel.com> wrote:
> >>
> >> Intel IGC and E1000 drivers are distinct, but they are actually genera=
ted
> >> from the same base code. This patchset will merge together all e1000-d=
erived
> >> drivers into one common base, with three different ethdev driver
> >> frontends (EM, IGB, and IGC).
> >>
> >> After the merge is done, base code is also updated to latest snapshot.
> >>
> >> Adam Ludkiewicz (1):
> >>    net/e1000/base: add WoL definitions
> >>
> >> Aleksandr Loktionov (1):
> >>    net/e1000/base: fix mac addr hash bit_shift
> >>
> >> Amir Avivi (1):
> >>    net/e1000/base: fix iterator type
> >>
> >> Anatoly Burakov (13):
> >>    net/e1000/base: add initial support for i225
> >>    net/e1000/base: add link bringup support for i225
> >>    net/e1000/base: add LED blink support for i225
> >>    net/e1000/base: add NVM/EEPROM support for i225
> >>    net/e1000/base: add LTR support in i225
> >>    net/e1000/base: add eee support for i225
> >>    net/e1000/base: add misc definitions for i225
> >>    net/e1000: merge igc with e1000
> >>    net/e1000: add missing i225 devices
> >>    net/e1000: add missing hardware support
> >>    net/e1000/base: correct minor formatting issues
> >>    net/e1000/base: correct mPHY access logic
> >>    net/e1000/base: update readme
> >>
> >> Barbara Skobiej (2):
> >>    net/e1000/base: fix reset for 82580
> >>    net/e1000/base: fix data type in MAC hash
> >>
> >> Carolyn Wyborny (1):
> >>    net/e1000/base: skip MANC check for 82575
> >>
> >> Dima Ruinskiy (4):
> >>    net/e1000/base: make e1000_access_phy_wakeup_reg_bm non-static
> >>    net/e1000/base: make debug prints more informative
> >>    net/e1000/base: hardcode bus parameters for ICH8
> >>    net/e1000/base: fix unchecked return
> >>
> >> Evgeny Efimov (1):
> >>    net/e1000/base: add EEE common API function
> >>
> >> Jakub Buchocki (1):
> >>    net/e1000/base: fix uninitialized variable usage
> >>
> >> Marcin Jurczak (1):
> >>    net/e1000/base: remove non-inclusive language
> >>
> >> Nir Efrati (6):
> >>    net/e1000/base: workaround for packet loss
> >>    net/e1000/base: add definition for EXFWSM register
> >>    net/e1000/base: use longer ULP exit timeout on more HW
> >>    net/e1000/base: remove redundant access to RO register
> >>    net/e1000/base: introduce PHY ID retry mechanism
> >>    net/e1000/base: add PHY read/write retry mechanism
> >>
> >> Pawel Malinowski (1):
> >>    net/e1000/base: fix semaphore timeout value
> >>
> >> Piotr Kubaj (1):
> >>    net/e1000/base: rename NVM version variable
> >>
> >> Piotr Pietruszewski (1):
> >>    net/e1000/base: improve code flow in ICH8LAN
> >>
> >> Przemyslaw Ciesielski (1):
> >>    net/e1000/base: fix static analysis warnings
> >>
> >> Sasha Neftin (4):
> >>    net/e1000/base: add queue select definitions
> >>    net/e1000/base: add profile information field
> >>    net/e1000/base: add LPI counters
> >>    net/e1000/base: improve NVM checksum handling
> >>
> >> Vitaly Lifshits (2):
> >>    net/e1000: add support for more I219 devices
> >>    net/e1000/base: correct disable k1 logic
> >>
> >>   drivers/net/intel/e1000/base/README           |    8 +-
> >>   .../net/intel/e1000/base/e1000_80003es2lan.c  |   10 +-
> >>   drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
> >>   drivers/net/intel/e1000/base/e1000_82575.c    |   21 +-
> >>   drivers/net/intel/e1000/base/e1000_82575.h    |   29 -
> >>   drivers/net/intel/e1000/base/e1000_api.c      |   76 +-
> >>   drivers/net/intel/e1000/base/e1000_api.h      |    4 +-
> >>   drivers/net/intel/e1000/base/e1000_base.c     |    3 +-
> >>   drivers/net/intel/e1000/base/e1000_defines.h  |  259 +-
> >>   drivers/net/intel/e1000/base/e1000_hw.h       |   86 +-
> >>   drivers/net/intel/e1000/base/e1000_i210.c     |   14 +-
> >>   drivers/net/intel/e1000/base/e1000_i210.h     |    4 +
> >>   drivers/net/intel/e1000/base/e1000_i225.c     | 1384 ++++++
> >>   drivers/net/intel/e1000/base/e1000_i225.h     |  117 +
> >>   drivers/net/intel/e1000/base/e1000_ich8lan.c  |  224 +-
> >>   drivers/net/intel/e1000/base/e1000_ich8lan.h  |    3 +-
> >>   drivers/net/intel/e1000/base/e1000_mac.c      |   62 +-
> >>   drivers/net/intel/e1000/base/e1000_mac.h      |    2 +-
> >>   drivers/net/intel/e1000/base/e1000_nvm.c      |    7 +-
> >>   drivers/net/intel/e1000/base/e1000_osdep.h    |   33 +-
> >>   drivers/net/intel/e1000/base/e1000_phy.c      |  447 +-
> >>   drivers/net/intel/e1000/base/e1000_phy.h      |   21 +
> >>   drivers/net/intel/e1000/base/e1000_regs.h     |   48 +-
> >>   drivers/net/intel/e1000/base/e1000_vf.c       |   14 +-
> >>   drivers/net/intel/e1000/base/meson.build      |    1 +
> >>   drivers/net/intel/e1000/em_ethdev.c           |   36 +-
> >>   drivers/net/intel/e1000/igb_ethdev.c          |    1 +
> >>   drivers/net/intel/{igc =3D> e1000}/igc_ethdev.c |  914 ++--
> >>   drivers/net/intel/{igc =3D> e1000}/igc_ethdev.h |   32 +-
> >>   drivers/net/intel/{igc =3D> e1000}/igc_filter.c |   84 +-
> >>   drivers/net/intel/{igc =3D> e1000}/igc_filter.h |    0
> >>   drivers/net/intel/{igc =3D> e1000}/igc_flow.c   |    2 +-
> >>   drivers/net/intel/{igc =3D> e1000}/igc_flow.h   |    0
> >>   drivers/net/intel/{igc =3D> e1000}/igc_logs.c   |    2 +-
> >>   drivers/net/intel/{igc =3D> e1000}/igc_txrx.c   |  376 +-
> >>   drivers/net/intel/{igc =3D> e1000}/igc_txrx.h   |    6 +-
> >>   drivers/net/intel/e1000/meson.build           |   11 +
> >>   drivers/net/intel/igc/base/README             |   29 -
> >>   drivers/net/intel/igc/base/igc_82571.h        |   36 -
> >>   drivers/net/intel/igc/base/igc_82575.h        |  351 --
> >>   drivers/net/intel/igc/base/igc_api.c          | 1853 -------
> >>   drivers/net/intel/igc/base/igc_api.h          |  111 -
> >>   drivers/net/intel/igc/base/igc_base.c         |  190 -
> >>   drivers/net/intel/igc/base/igc_base.h         |  127 -
> >>   drivers/net/intel/igc/base/igc_defines.h      | 1670 -------
> >>   drivers/net/intel/igc/base/igc_hw.h           | 1059 ----
> >>   drivers/net/intel/igc/base/igc_i225.c         | 1372 -----
> >>   drivers/net/intel/igc/base/igc_i225.h         |  110 -
> >>   drivers/net/intel/igc/base/igc_ich8lan.h      |  296 --
> >>   drivers/net/intel/igc/base/igc_mac.c          | 2100 --------
> >>   drivers/net/intel/igc/base/igc_mac.h          |   64 -
> >>   drivers/net/intel/igc/base/igc_manage.c       |  547 --
> >>   drivers/net/intel/igc/base/igc_manage.h       |   65 -
> >>   drivers/net/intel/igc/base/igc_nvm.c          | 1324 -----
> >>   drivers/net/intel/igc/base/igc_nvm.h          |   69 -
> >>   drivers/net/intel/igc/base/igc_osdep.c        |   64 -
> >>   drivers/net/intel/igc/base/igc_osdep.h        |  163 -
> >>   drivers/net/intel/igc/base/igc_phy.c          | 4420 ---------------=
--
> >>   drivers/net/intel/igc/base/igc_phy.h          |  337 --
> >>   drivers/net/intel/igc/base/igc_regs.h         |  732 ---
> >>   drivers/net/intel/igc/base/meson.build        |   19 -
> >>   drivers/net/intel/igc/igc_logs.h              |   43 -
> >>   drivers/net/intel/igc/meson.build             |   21 -
> >>   drivers/net/meson.build                       |    1 -
> >>   64 files changed, 3300 insertions(+), 18218 deletions(-)
> >>   create mode 100644 drivers/net/intel/e1000/base/e1000_i225.c
> >>   create mode 100644 drivers/net/intel/e1000/base/e1000_i225.h
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_ethdev.c (73%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_ethdev.h (91%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_filter.c (81%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_filter.h (100%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_flow.c (99%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_flow.h (100%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_logs.c (90%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_txrx.c (87%)
> >>   rename drivers/net/intel/{igc =3D> e1000}/igc_txrx.h (97%)
> >>   delete mode 100644 drivers/net/intel/igc/base/README
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_82571.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_82575.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_api.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_api.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_base.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_base.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_defines.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_hw.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_i225.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_i225.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_ich8lan.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_mac.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_mac.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_manage.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_manage.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_nvm.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_nvm.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_osdep.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_osdep.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_phy.c
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_phy.h
> >>   delete mode 100644 drivers/net/intel/igc/base/igc_regs.h
> >>   delete mode 100644 drivers/net/intel/igc/base/meson.build
> >>   delete mode 100644 drivers/net/intel/igc/igc_logs.h
> >>   delete mode 100644 drivers/net/intel/igc/meson.build
> >
> > Consolidation is a good thing, there are two small issues with this
> > series though:
> > - the ABI check (as it tracks all .so) reports that librte_net_igc.so
> > disappeared: this will need some waiving, like Bruce did in his
> > series: https://patchwork.dpdk.org/project/dpdk/patch/20250130151222.94=
4561-2-bruce.richardson@intel.com/
> > - with this merge, "users" can't select net/igc compilation anymore
> > and need to be aware that igc support now requires enabling net/e1000,
> > please update the release notes to make this visible,
> >
> > There is also a strange build failure for mingw (see github test report=
).
> >
>
> MinGW issues were fixed, abigail changes and release notes will come in
> (now) V3.

There are quite many warnings on this series.

The main problem is that v2 has some meson style issues:
$ ./devtools/check-meson.py
Error: Incorrect indent at drivers/net/intel/e1000/meson.build:20
Error: Incorrect indent at drivers/net/intel/e1000/meson.build:21
Error: Incorrect indent at drivers/net/intel/e1000/meson.build:22
Error: Incorrect indent at drivers/net/intel/e1000/meson.build:23
Error: Incorrect indent at drivers/net/intel/e1000/meson.build:24

And this is what blocked testing at UNH.
Please fix for v3.


There are also authorship/Sob issues, those can be seen with
./devtools/checkpatches.sh and ./devtools/check-git-log.sh.


--=20
David Marchand

