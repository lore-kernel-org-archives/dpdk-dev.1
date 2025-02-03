Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1AFC02195
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 08:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ED2640B91;
	Mon,  3 Feb 2025 09:18:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 87C7C40264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 09:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738570710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TNMkyd7u7UjHriDc/m9mc126BMj2QYhhog3E/8PdE0=;
 b=cOvzPZiY/6nM7r3Oj+2sLUopXrz39N+EM69rjIdIUaviZ6pSPNIefFpmzuS3gs/TnsmCzA
 bV+MAEDyyBfPBULOsbAlPOL0qlNCjL/uVYbkGbOYYTNKQbD1kHGSKEJT0C8TgQxOy6vxUy
 geF4qZE75nfKivk3mK2dEkVD1MqGvF8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-z4yByPs3PJeTdFuM02wzPg-1; Mon, 03 Feb 2025 03:18:28 -0500
X-MC-Unique: z4yByPs3PJeTdFuM02wzPg-1
X-Mimecast-MFC-AGG-ID: z4yByPs3PJeTdFuM02wzPg
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53e1bddea1dso2148477e87.2
 for <dev@dpdk.org>; Mon, 03 Feb 2025 00:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738570707; x=1739175507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/TNMkyd7u7UjHriDc/m9mc126BMj2QYhhog3E/8PdE0=;
 b=iYHvwKlPKKOnJx7glRzM3MGrCedmzrAKbeyDRv73drX2AH6/JIjd4aeudQc7gNb3Uo
 KhHU5+lClHn0wRXnXTlw9x/GEbPJjP2QcJEO13PYQiRfTZWLGmvaB9088n05k4KkL1gi
 R6/haka0DHhEYtDe833BE4woVkvKYJwPhNmd4sYVZrwaKwgDQyALR6F/skcts7E+S3T5
 A401WNqDhlQnQw3DPgHPUypI1JPOF52boXmEbWhw7GDGwCKvkdRsyoOolu3K74ygDr6R
 0/c9fSaSq9h2rP/n5POKFWglK5uWhcS4AO9WvJjY39k83HbyycubFABFKAE7HaVBvWnc
 YbNQ==
X-Gm-Message-State: AOJu0YxWCPqur/X0CAusIPM4vK9DuemP7wcUkKjxZ6bOrahmHdHW4hzg
 IM0s3rngnvEuvGeHrx2ZQ6feG6EELXau1UU/L7YA17jJHygcYC9n6kLYNSgKgX9G4jLhIIkFHtW
 1Pd+dcItTqLmKfa6AfPNgbIHiZU1PqX5GqGbqJvG4eA1Ei7yQgchWzH/9imR+Q8u+LR6ziX+ryc
 Eg/nMbhhv5EGg/Ni8=
X-Gm-Gg: ASbGnctNQvphn1CZnFFZp970TY80xtjTKFAyYbknSJKtvqRf6MrmB6uNal/80ZMLFYx
 gjM03MgrzTgjCdDLtKbWDMfGTAQiPXwDN1R1LWDwXAwRA25j6q/I4Faqx4QblTmFP
X-Received: by 2002:a05:6512:3b26:b0:540:1c6e:f040 with SMTP id
 2adb3069b0e04-543e4c3c355mr6674502e87.45.1738570706752; 
 Mon, 03 Feb 2025 00:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwjZOStM9lIUn/ezS3El+bVpJPl5N5yn4tc/hCQYN9P4xdeu7lm0vRp2hYOLfz5lc4S1NePncUxpUaBjKmJuY=
X-Received: by 2002:a05:6512:3b26:b0:540:1c6e:f040 with SMTP id
 2adb3069b0e04-543e4c3c355mr6674486e87.45.1738570706291; Mon, 03 Feb 2025
 00:18:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738328106.git.anatoly.burakov@intel.com>
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 3 Feb 2025 09:18:14 +0100
X-Gm-Features: AWEUYZlVSuFUBKH7I7YGAZXbh_7fnNzcZLHUux5GKNeEz7HUvn6SmsgjNvyp3PQ
Message-ID: <CAJFAV8yY+T7S49daG+yRedGzvhis3iUC2yznvae7ZW4WEE4n7Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/42] Merge Intel IGC and E1000 drivers, and update
 E1000 base code
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XiKSGqJNWYRiCMmQGOhTzRUHGxQbGM4zwGEUBv4-M5k_1738570707
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

Hello Anatoly,

On Fri, Jan 31, 2025 at 1:59=E2=80=AFPM Anatoly Burakov
<anatoly.burakov@intel.com> wrote:
>
> Intel IGC and E1000 drivers are distinct, but they are actually generated
> from the same base code. This patchset will merge together all e1000-deri=
ved
> drivers into one common base, with three different ethdev driver
> frontends (EM, IGB, and IGC).
>
> After the merge is done, base code is also updated to latest snapshot.
>
> Adam Ludkiewicz (1):
>   net/e1000/base: add WoL definitions
>
> Aleksandr Loktionov (1):
>   net/e1000/base: fix mac addr hash bit_shift
>
> Amir Avivi (1):
>   net/e1000/base: fix iterator type
>
> Anatoly Burakov (13):
>   net/e1000/base: add initial support for i225
>   net/e1000/base: add link bringup support for i225
>   net/e1000/base: add LED blink support for i225
>   net/e1000/base: add NVM/EEPROM support for i225
>   net/e1000/base: add LTR support in i225
>   net/e1000/base: add eee support for i225
>   net/e1000/base: add misc definitions for i225
>   net/e1000: merge igc with e1000
>   net/e1000: add missing i225 devices
>   net/e1000: add missing hardware support
>   net/e1000/base: correct minor formatting issues
>   net/e1000/base: correct mPHY access logic
>   net/e1000/base: update readme
>
> Barbara Skobiej (2):
>   net/e1000/base: fix reset for 82580
>   net/e1000/base: fix data type in MAC hash
>
> Carolyn Wyborny (1):
>   net/e1000/base: skip MANC check for 82575
>
> Dima Ruinskiy (4):
>   net/e1000/base: make e1000_access_phy_wakeup_reg_bm non-static
>   net/e1000/base: make debug prints more informative
>   net/e1000/base: hardcode bus parameters for ICH8
>   net/e1000/base: fix unchecked return
>
> Evgeny Efimov (1):
>   net/e1000/base: add EEE common API function
>
> Jakub Buchocki (1):
>   net/e1000/base: fix uninitialized variable usage
>
> Marcin Jurczak (1):
>   net/e1000/base: remove non-inclusive language
>
> Nir Efrati (6):
>   net/e1000/base: workaround for packet loss
>   net/e1000/base: add definition for EXFWSM register
>   net/e1000/base: use longer ULP exit timeout on more HW
>   net/e1000/base: remove redundant access to RO register
>   net/e1000/base: introduce PHY ID retry mechanism
>   net/e1000/base: add PHY read/write retry mechanism
>
> Pawel Malinowski (1):
>   net/e1000/base: fix semaphore timeout value
>
> Piotr Kubaj (1):
>   net/e1000/base: rename NVM version variable
>
> Piotr Pietruszewski (1):
>   net/e1000/base: improve code flow in ICH8LAN
>
> Przemyslaw Ciesielski (1):
>   net/e1000/base: fix static analysis warnings
>
> Sasha Neftin (4):
>   net/e1000/base: add queue select definitions
>   net/e1000/base: add profile information field
>   net/e1000/base: add LPI counters
>   net/e1000/base: improve NVM checksum handling
>
> Vitaly Lifshits (2):
>   net/e1000: add support for more I219 devices
>   net/e1000/base: correct disable k1 logic
>
>  drivers/net/intel/e1000/base/README           |    8 +-
>  .../net/intel/e1000/base/e1000_80003es2lan.c  |   10 +-
>  drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
>  drivers/net/intel/e1000/base/e1000_82575.c    |   21 +-
>  drivers/net/intel/e1000/base/e1000_82575.h    |   29 -
>  drivers/net/intel/e1000/base/e1000_api.c      |   76 +-
>  drivers/net/intel/e1000/base/e1000_api.h      |    4 +-
>  drivers/net/intel/e1000/base/e1000_base.c     |    3 +-
>  drivers/net/intel/e1000/base/e1000_defines.h  |  259 +-
>  drivers/net/intel/e1000/base/e1000_hw.h       |   86 +-
>  drivers/net/intel/e1000/base/e1000_i210.c     |   14 +-
>  drivers/net/intel/e1000/base/e1000_i210.h     |    4 +
>  drivers/net/intel/e1000/base/e1000_i225.c     | 1384 ++++++
>  drivers/net/intel/e1000/base/e1000_i225.h     |  117 +
>  drivers/net/intel/e1000/base/e1000_ich8lan.c  |  224 +-
>  drivers/net/intel/e1000/base/e1000_ich8lan.h  |    3 +-
>  drivers/net/intel/e1000/base/e1000_mac.c      |   62 +-
>  drivers/net/intel/e1000/base/e1000_mac.h      |    2 +-
>  drivers/net/intel/e1000/base/e1000_nvm.c      |    7 +-
>  drivers/net/intel/e1000/base/e1000_osdep.h    |   33 +-
>  drivers/net/intel/e1000/base/e1000_phy.c      |  447 +-
>  drivers/net/intel/e1000/base/e1000_phy.h      |   21 +
>  drivers/net/intel/e1000/base/e1000_regs.h     |   48 +-
>  drivers/net/intel/e1000/base/e1000_vf.c       |   14 +-
>  drivers/net/intel/e1000/base/meson.build      |    1 +
>  drivers/net/intel/e1000/em_ethdev.c           |   36 +-
>  drivers/net/intel/e1000/igb_ethdev.c          |    1 +
>  drivers/net/intel/{igc =3D> e1000}/igc_ethdev.c |  914 ++--
>  drivers/net/intel/{igc =3D> e1000}/igc_ethdev.h |   32 +-
>  drivers/net/intel/{igc =3D> e1000}/igc_filter.c |   84 +-
>  drivers/net/intel/{igc =3D> e1000}/igc_filter.h |    0
>  drivers/net/intel/{igc =3D> e1000}/igc_flow.c   |    2 +-
>  drivers/net/intel/{igc =3D> e1000}/igc_flow.h   |    0
>  drivers/net/intel/{igc =3D> e1000}/igc_logs.c   |    2 +-
>  drivers/net/intel/{igc =3D> e1000}/igc_txrx.c   |  376 +-
>  drivers/net/intel/{igc =3D> e1000}/igc_txrx.h   |    6 +-
>  drivers/net/intel/e1000/meson.build           |   11 +
>  drivers/net/intel/igc/base/README             |   29 -
>  drivers/net/intel/igc/base/igc_82571.h        |   36 -
>  drivers/net/intel/igc/base/igc_82575.h        |  351 --
>  drivers/net/intel/igc/base/igc_api.c          | 1853 -------
>  drivers/net/intel/igc/base/igc_api.h          |  111 -
>  drivers/net/intel/igc/base/igc_base.c         |  190 -
>  drivers/net/intel/igc/base/igc_base.h         |  127 -
>  drivers/net/intel/igc/base/igc_defines.h      | 1670 -------
>  drivers/net/intel/igc/base/igc_hw.h           | 1059 ----
>  drivers/net/intel/igc/base/igc_i225.c         | 1372 -----
>  drivers/net/intel/igc/base/igc_i225.h         |  110 -
>  drivers/net/intel/igc/base/igc_ich8lan.h      |  296 --
>  drivers/net/intel/igc/base/igc_mac.c          | 2100 --------
>  drivers/net/intel/igc/base/igc_mac.h          |   64 -
>  drivers/net/intel/igc/base/igc_manage.c       |  547 --
>  drivers/net/intel/igc/base/igc_manage.h       |   65 -
>  drivers/net/intel/igc/base/igc_nvm.c          | 1324 -----
>  drivers/net/intel/igc/base/igc_nvm.h          |   69 -
>  drivers/net/intel/igc/base/igc_osdep.c        |   64 -
>  drivers/net/intel/igc/base/igc_osdep.h        |  163 -
>  drivers/net/intel/igc/base/igc_phy.c          | 4420 -----------------
>  drivers/net/intel/igc/base/igc_phy.h          |  337 --
>  drivers/net/intel/igc/base/igc_regs.h         |  732 ---
>  drivers/net/intel/igc/base/meson.build        |   19 -
>  drivers/net/intel/igc/igc_logs.h              |   43 -
>  drivers/net/intel/igc/meson.build             |   21 -
>  drivers/net/meson.build                       |    1 -
>  64 files changed, 3300 insertions(+), 18218 deletions(-)
>  create mode 100644 drivers/net/intel/e1000/base/e1000_i225.c
>  create mode 100644 drivers/net/intel/e1000/base/e1000_i225.h
>  rename drivers/net/intel/{igc =3D> e1000}/igc_ethdev.c (73%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_ethdev.h (91%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_filter.c (81%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_filter.h (100%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_flow.c (99%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_flow.h (100%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_logs.c (90%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_txrx.c (87%)
>  rename drivers/net/intel/{igc =3D> e1000}/igc_txrx.h (97%)
>  delete mode 100644 drivers/net/intel/igc/base/README
>  delete mode 100644 drivers/net/intel/igc/base/igc_82571.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_82575.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_api.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_api.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_base.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_base.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_defines.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_hw.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_i225.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_i225.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_ich8lan.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_mac.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_mac.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_manage.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_manage.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_nvm.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_nvm.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_osdep.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_osdep.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_phy.c
>  delete mode 100644 drivers/net/intel/igc/base/igc_phy.h
>  delete mode 100644 drivers/net/intel/igc/base/igc_regs.h
>  delete mode 100644 drivers/net/intel/igc/base/meson.build
>  delete mode 100644 drivers/net/intel/igc/igc_logs.h
>  delete mode 100644 drivers/net/intel/igc/meson.build

Consolidation is a good thing, there are two small issues with this
series though:
- the ABI check (as it tracks all .so) reports that librte_net_igc.so
disappeared: this will need some waiving, like Bruce did in his
series: https://patchwork.dpdk.org/project/dpdk/patch/20250130151222.944561=
-2-bruce.richardson@intel.com/
- with this merge, "users" can't select net/igc compilation anymore
and need to be aware that igc support now requires enabling net/e1000,
please update the release notes to make this visible,

There is also a strange build failure for mingw (see github test report).


--=20
David Marchand

