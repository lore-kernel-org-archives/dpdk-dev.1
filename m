Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1288C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 17:35:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E315C410FB;
	Thu, 12 Jun 2025 19:35:12 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 679E5400D6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 19:35:11 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6faff792f9bso12469786d6.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749749710;
 x=1750354510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxJuMxx6GbEIQfBQ9jjDMsKj4eVvYD1/P6b8aQ/ey/4=;
 b=jmcT3OLkP/Zu4yRBJOm0IRCrTny9vZK640UoGkI3xCnuabMhhMfrHbGFog5LhYcGDz
 2Cb/oxunx+Ua3A1zImM92gMmnVRIjqWR30G2WuCs6wiF7SYcAnc2dcLZPeMAAIlhwPdJ
 K5RFTyvnqtNDHdWcvPE4sBvvZ7pEmzMdV+pSBLgUjeDCX8GOSL+5Fqm5Gy55krlqcdfM
 uHaMbrZz6ofEDKo6PMlgU81gsDCBF7gaQxEyPHe8yktfVBwpQhfJsq59o7auOqHwtJSU
 d/F9tQJZ88emsiLHn9wmOCwcsqWZddHfdA5GfQ2juCxDGG3BCN/TnDVTe0ubq5zvJa+C
 ZJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749749710; x=1750354510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxJuMxx6GbEIQfBQ9jjDMsKj4eVvYD1/P6b8aQ/ey/4=;
 b=VjBKUgf94p58EQ/NsYthhLCowMIL4IP8dJVpCdy60n/+5bynvZxULm4Yo5uKZUMXnS
 peo/g/NL5iPJt2tZN2oo5uGIW3QGkWznxfI07vHcxTMxHcbblckcRTG0UwwVoUkIC3yB
 e4C+LJ+/oXRDmgsJVHXxSDtcItkcyxXuNQlFPuHZl9/kQ7MMioaVi2LSc4ek/Yk/59TS
 CWNCe2lttIXgcjgyKNhpiuzXdUrg7qfKRtMiWozO9dHL8x1cEp7zIxlmGozBm6PO3s9Y
 fQWXVEz3gXaedgfA9qTmF2nyEpBXnblsCbmZsQHagR9FivKGQrGzTWI1abLp7N0Qs4di
 tiJg==
X-Gm-Message-State: AOJu0Yz32shi8y9H8+KyBCxjhSsSG8ASGDYDbF1qBYNvRRPlStnxADQe
 o9sgdX5kPTXDDJwIIinMyjTQ2ypQwVP3WTFEoJuDgP4Duhm3066YydsiUC9SWyU4Gud/o+vsyAD
 coC7g
X-Gm-Gg: ASbGncui+XecCIjacyth2ODHRP1Ay2GV5Y12ZqEo5S04VKVkiFruCCzHiyH3+GT3uNL
 3uYRLuy89pXvAOR/D280NBq5q3ULqOUG4xyv+CSTcHESe7QrEFU12idOL9VwyISLGAwnO83687M
 A6l18ooF0+uhW3/eGxDTTMP8hcG/lHsjgHJHlxs6gsZOiVWDljSPgz1SNe/x5mGDU9pkJP8uqVE
 nShJsjT6n7b7jYtOQJN8ETAbXstXev1GLm5dWYzOATscBN2wmO9HNQQr5I+NvDfZK/AeiNQtvEW
 2l5t2SphRxADF6w+V899f7Ul+3vg3hsZn4tS2T/51RJYruJiBQZVuT9A6GxmwKLS95Nl7/1B+wh
 9zG1QmpMNQLFP+mi/+o+IoJ5QCe0hAeOp0hEMGRk=
X-Google-Smtp-Source: AGHT+IHuxELvv6d0HtAWkXbluSxjw8eVYOfCxQKcj1COg8sYX3AtpCvFBiQT2sV50KwgNhortt0z1Q==
X-Received: by 2002:ad4:5f45:0:b0:6fa:bba5:c617 with SMTP id
 6a1803df08f44-6fb2c3284cbmr143776116d6.10.1749749709769; 
 Thu, 12 Jun 2025 10:35:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35b2fd88sm12489846d6.31.2025.06.12.10.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:35:09 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:35:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20250612103504.152ddb1f@hermes.local>
In-Reply-To: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
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

On Thu, 12 Jun 2025 08:58:21 +0000
Kyo Liu <kyo.liu@nebula-matrix.com> wrote:

> This nbl PMD (**librte_net_nbl**) provides poll mode driver for=20
> NebulaMatrix serials NICs.
>=20
> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats=20
>=20
> Support NICs:
> -------------
> - S1205CQ-A00CHT
> - S1105AS-A00CHT
> - S1055AS-A00CHT
> - S1052AS-A00CHT
> - S1051AS-A00CHT
> - S1045XS-A00CHT
> - S1205CQ-A00CSP
> - S1055AS-A00CSP
> - S1052AS-A00CSP
>=20
>=20
> Kyo Liu (17):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl:=C2=A0 add PHY layer definitions and implementation
>   net/nbl:=C2=A0 add Channel layer definitions and implementation
>   net/nbl:=C2=A0 add Resource layer definitions and implementation
>   net/nbl:=C2=A0 add Dispatch layer definitions and implementation
>   net/nbl:=C2=A0 add Dev layer definitions and implementation
>   net/nbl:=C2=A0 add complete device init and uninit functionality
>   net/nbl:=C2=A0 add uio and vfio mode for nbl
>   net/nbl: =C2=A0bus/pci: introduce get_iova_mode for pci dev
>   net/nbl:=C2=A0 add nbl coexistence mode for nbl
>   net/nbl: add nbl ethdev configuration
>   net/nbl:=C2=A0add nbl device rxtx queue setup and release ops
>   net/nbl: add nbl device start and stop ops
>   net/nbl: add nbl device tx and rx burst
>   net/nbl: add nbl device xstats and stats
>   net/nbl: nbl device support set mtu and promisc
>=20
>  .mailmap                                      |    5 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |    9 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   42 +
>  doc/guides/rel_notes/release_25_07.rst        |    5 +
>  drivers/bus/pci/bus_pci_driver.h              |   11 +
>  drivers/bus/pci/linux/pci.c                   |    2 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_thread.c       |   88 ++
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  758 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  100 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1007 ++++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   65 +
>  drivers/net/nbl/nbl_dispatch.c                | 1226 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  167 +++
>  drivers/net/nbl/nbl_ethdev.h                  |   32 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  853 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  127 ++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.c       |  230 ++++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.h       |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_phy.h              |   28 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  153 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  906 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |  136 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  434 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  128 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |  107 ++
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |   95 ++
>  drivers/net/nbl/nbl_include/nbl_def_phy.h     |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   87 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  212 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   37 +
>  44 files changed, 7766 insertions(+)
>  create mode 100644 doc/guides/nics/features/nbl.ini
>  create mode 100644 doc/guides/nics/nbl.rst
>  create mode 100644 drivers/net/nbl/meson.build
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_thread.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h
>  create mode 100644 drivers/net/nbl/nbl_core.c
>  create mode 100644 drivers/net/nbl/nbl_core.h
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.c
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.h
>  create mode 100644 drivers/net/nbl/nbl_dispatch.c
>  create mode 100644 drivers/net/nbl/nbl_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_ethdev.c
>  create mode 100644 drivers/net/nbl/nbl_ethdev.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_s=
nic.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_s=
nic.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_phy.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_phy.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h
>=20

Build failure on 32 bit. Need to us %zu instead of PRIU64 here.
FAILED: drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_hw_nbl_channel.c.o=20
gcc -Idrivers/libtmp_rte_net_nbl.a.p -Idrivers -I../drivers -Idrivers/net/n=
bl -I../drivers/net/nbl -I../drivers/net/nbl/nbl_include -I../drivers/net/n=
bl/nbl_hw -I../drivers/net/nbl/nbl_common -Ilib/ethdev -I../lib/ethdev -Ili=
b/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/in=
clude -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/inclu=
de -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/e=
al -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/m=
etrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../l=
ib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -=
I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/=
pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I=
../drivers/bus/vdev -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -=
Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wv=
la -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security =
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-de=
finition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite=
-strings -Wno-packed-not-aligned -Wno-missing-field-initializers -Wno-point=
er-to-int-cast -D_GNU_SOURCE -m32 -fPIC -march=3Dnative -mrtm -DALLOW_EXPER=
IMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-pac=
ked-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.nbl -MD -MQ drivers/libtmp_r=
te_net_nbl.a.p/net_nbl_nbl_hw_nbl_channel.c.o -MF drivers/libtmp_rte_net_nb=
l.a.p/net_nbl_nbl_hw_nbl_channel.c.o.d -o drivers/libtmp_rte_net_nbl.a.p/ne=
t_nbl_nbl_hw_nbl_channel.c.o -c ../drivers/net/nbl/nbl_hw/nbl_channel.c
In file included from ../lib/eal/include/rte_debug.h:17,
                 from ../lib/eal/include/rte_bitops.h:23,
                 from ../lib/ethdev/rte_cman.h:8,
                 from ../lib/ethdev/rte_ethdev.h:159,
                 from ../drivers/net/nbl/nbl_include/nbl_include.h:37,
                 from ../drivers/net/nbl/nbl_include/nbl_product_base.h:8,
                 from ../drivers/net/nbl/nbl_core.h:8,
                 from ../drivers/net/nbl/nbl_ethdev.h:8,
                 from ../drivers/net/nbl/nbl_hw/nbl_channel.h:8,
                 from ../drivers/net/nbl/nbl_hw/nbl_channel.c:5:
../drivers/net/nbl/nbl_hw/nbl_channel.c: In function =E2=80=98nbl_chan_upda=
te_txqueue=E2=80=99:
../drivers/net/nbl/nbl_hw/nbl_channel.c:394:76: error: format =E2=80=98%llu=
=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99=
, but argument 5 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned i=
nt=E2=80=99} [-Werror=3Dformat=3D]
  394 |                 NBL_LOG(ERR, "arg_len: %" NBL_PRIU64 ", too long!",=
 arg_len);
      |                                                                    =
        ^
../lib/log/rte_log.h:334:39: note: in definition of macro =E2=80=98RTE_LOG=
=E2=80=99
  334 |                  RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)
      |                                       ^
../drivers/net/nbl/nbl_include/nbl_logs.h:19:9: note: in expansion of macro=
 =E2=80=98RTE_LOG_LINE_PREFIX=E2=80=99
   19 |         RTE_LOG_LINE_PREFIX(level, NBL_DRIVER, "%s: ", __func__, __=
VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~
../drivers/net/nbl/nbl_hw/nbl_channel.c:394:17: note: in expansion of macro=
 =E2=80=98NBL_LOG=E2=80=99
  394 |                 NBL_LOG(ERR, "arg_len: %" NBL_PRIU64 ", too long!",=
 arg_len);
      |                 ^~~~~~~
cc1: all warnings being treated as errors
