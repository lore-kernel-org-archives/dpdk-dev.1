Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC97CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:04:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA904066A;
	Wed, 15 Oct 2025 21:04:52 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3145540273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:04:50 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-79ef9d1805fso2208992b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760555089;
 x=1761159889; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6ShWKCT/mNSLnzl0N/vVILhePVvA4VtNbh5pPnCsZ4=;
 b=NRv+nwvtSfJwuQyPP/q6hMDuAD7h4G7mkBGPVsy/Dbiiodiw5LDNbMwbxPdnXWZ+SJ
 R1sdJFa3OXQ9XTCNZ/fn/+ygIjroejaVFSYCjz/GgC2mU1WGlZ4yGipbyPBr8y3Ue062
 mJ4ISpmwZECnQvkVuVwCbcdkoIqAA7XG5NRL0xdG96ScjfHq0+XkYIYjt88UIC6lwnP1
 w1L78XJmoFBL6bGP5oDPlwvebAiXYEe0P5eWJRuMRddVH9QP2GdscSwRbkLZWrP7/ZLz
 ArOk9mikUPIyxo7lJi77Kr8+OMVAW2DE7wFsGIoWKQjwWna/dejPdrqTlpqg+EUrMQES
 5jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555089; x=1761159889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6ShWKCT/mNSLnzl0N/vVILhePVvA4VtNbh5pPnCsZ4=;
 b=pFNgOfcTpzOCHjXWzig6n4DzxR9yxn5ABZeDs0Z7TDWRiuoixbPlNOsmQZb9bD2dO3
 t4i101sHfveWqo5USAJOpLoSjJd8VjBCpV1OQ/qYDNz/uZxHt1hBxei0WANK9u5jvNbI
 BdtqCoW2uBpfRgDDpthTbdqnDLAuij/RuEYymfDAxOTGvs8dt1KQehpLTht1y2kpL6t0
 tEuudeqqVAUjMmtl2OqxuxhGvrta8MRZa9QmA5BsYupqXBHIbFmfYvSm2rszdv/x0YW2
 SU9mLdHjrPMCYynhYK1dI/E/uNMkziMKgE09cuMCV5ozih7TQMKGtJvHBAr4rCoB3oRx
 7SzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW5BrGZjRipSpaUD5NuVy2kP97Jw6wDX4CUoSHcvg81wwCjxU//s/dOtRHEYVZacSGzm0=@dpdk.org
X-Gm-Message-State: AOJu0YwtbtUtgJife2Xn5XeXlKvHzaY2k4BdSzC80eFMoIp7QPGTZ0vg
 OWCIkYZy1M+RbEZsnR9Aq023XrgffEn1CO0K/32aKa2IIL3r65DkKvaDT2+Q/2Ilp/sEDT065zf
 YJ9cDIOg=
X-Gm-Gg: ASbGncvn4MF2tHQsnLfLC5OoAxmtUIky1CcS7gzNFyj+xGjsynOBCbp1K4vK4MT4/Fp
 Z0GZdTrPH6aou8pose9dDwnIfaqCJBljN9zrne6LLD13WR5PObwleIQ0KVWsod1P1ln67v4j9e/
 eBhOP3csH0LfBCz8M5W4GaovqHRdgXuEzO13kvLQZKCFr9+6afSwQNgn1t8A1YYscQ68cf82phi
 Rn8J9NoSnIUOftn3fTKBp1PW6v2VQgs3843bMsdaHjI4sfktfaU+et2NAQC5fhmkhfaXvXUmbLI
 tICuFUQtxE+wm9JrydHP6qoZKsQvnJTIo0eQIJ2sfJzp4iPAhMkO3UYcDqEZxwcvH1eaUCLgB16
 peEB2UvIAEEXPdGUqB8BBeSYSH4A2FMaRE9BjF8I4UgXgVtij2Bg4j3WhReZUYSKEv3fCSnnyS/
 gQQ5Mx+Ym01wdYuI6t3srVmBWIoenPupfOPwXT0+SxXIRPgfDYpupJ
X-Google-Smtp-Source: AGHT+IGci87RkYD5DuHE8QiR3Um5O37hgqPHomphA3XvK0nJkOTGGjs9xyea0W/ZBewvGIw6j5H3Kw==
X-Received: by 2002:a17:902:f642:b0:250:999f:31c6 with SMTP id
 d9443c01a7336-290272b4764mr325347865ad.32.1760555089105; 
 Wed, 15 Oct 2025 12:04:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba3fcsm3669675ad.99.2025.10.15.12.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 12:04:48 -0700 (PDT)
Date: Wed, 15 Oct 2025 12:04:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
Cc: kyo.liu@nebula-matrix.com, dev@dpdk.org
Subject: Re: [PATCH v3 00/16] NBL PMD for Nebulamatrix NICs
Message-ID: <20251015120446.5ea148fb@hermes.local>
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

On Thu, 26 Jun 2025 18:40:06 -0700
"dimon.zhao" <dimon.zhao@nebula-matrix.com> wrote:

> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats=C2=A0
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
> Dimon Zhao (16):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl: add PHY layer definitions and implementation
>   net/nbl: add Channel layer definitions and implementation
>   net/nbl: add Resource layer definitions and implementation
>   net/nbl: add Dispatch layer definitions and implementation
>   net/nbl: add Dev layer definitions and implementation
>   net/nbl: add complete device init and uninit functionality
>   net/nbl: add UIO and VFIO mode for nbl
>   net/nbl: add nbl coexistence mode for nbl
>   net/nbl: add nbl ethdev configuration
>   net/nbl: add nbl device rxtx queue setup and release ops
>   net/nbl: add nbl device start and stop ops
>   net/nbl: add nbl device Tx and Rx burst
>   net/nbl: add nbl device xstats and stats
>   net/nbl: nbl device support set MTU and promisc
>=20
>  .mailmap                                      |    4 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |    9 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   42 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_thread.c       |   88 ++
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  743 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  100 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1007 ++++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   65 +
>  drivers/net/nbl/nbl_dispatch.c                | 1227 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  161 +++
>  drivers/net/nbl/nbl_ethdev.h                  |   32 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  853 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  127 ++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.c       |  230 +++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.h       |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_phy.h              |   28 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  153 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  907 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |  136 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  434 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  128 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |  107 ++
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |   95 ++
>  drivers/net/nbl/nbl_include/nbl_def_phy.h     |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   87 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  203 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   37 +
>  41 files changed, 7719 insertions(+)
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

The recent merge VFIO headers changes to main branch now causes
this driver to fail build in next-net.

For now, removing it from next-net. Please resubmit

FAILED: drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_common_nbl_userdev.c.o=20
cc -Idrivers/libtmp_rte_net_nbl.a.p -Idrivers -I../drivers -Idrivers/net/nb=
l -I../drivers/net/nbl -I../drivers/net/nbl/nbl_include -I../drivers/net/nb=
l/nbl_hw -I../drivers/net/nbl/nbl_common -I../drivers/net/nbl/nbl_dev -Ilib=
/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Icon=
fig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/incl=
ude -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/inclu=
de -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -I=
lib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../li=
b/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/m=
buf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -=
Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drive=
rs/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus=
/vdev -I/usr/include/x86_64-linux-gnu -fdiagnostics-color=3Dalways -D_FILE_=
OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include rte_co=
nfig.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat=
-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wol=
d-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wund=
ef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers =
-D_GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_=
INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -DRTE_LOG=
_DEFAULT_LOGTYPE=3Dpmd.net.nbl -MD -MQ drivers/libtmp_rte_net_nbl.a.p/net_n=
bl_nbl_common_nbl_userdev.c.o -MF drivers/libtmp_rte_net_nbl.a.p/net_nbl_nb=
l_common_nbl_userdev.c.o.d -o drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_co=
mmon_nbl_userdev.c.o -c ../drivers/net/nbl/nbl_common/nbl_userdev.c
../drivers/net/nbl/nbl_common/nbl_userdev.c: In function =E2=80=98nbl_vfio_=
dma_mem_map=E2=80=99:
../drivers/net/nbl/nbl_common/nbl_userdev.c:74:41: error: storage size of =
=E2=80=98dma_map=E2=80=99 isn=E2=80=99t known
   74 |         struct vfio_iommu_type1_dma_map dma_map;
      |                                         ^~~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:75:43: error: storage size of =
=E2=80=98dma_unmap=E2=80=99 isn=E2=80=99t known
   75 |         struct vfio_iommu_type1_dma_unmap dma_unmap;
      |                                           ^~~~~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:80:40: error: invalid applicati=
on of =E2=80=98sizeof=E2=80=99 to incomplete type =E2=80=98struct vfio_iomm=
u_type1_dma_map=E2=80=99
   80 |                 dma_map.argsz =3D sizeof(struct vfio_iommu_type1_dm=
a_map);
      |                                        ^~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:84:33: error: =E2=80=98VFIO_DMA=
_MAP_FLAG_READ=E2=80=99 undeclared (first use in this function)
   84 |                 dma_map.flags =3D VFIO_DMA_MAP_FLAG_READ |
      |                                 ^~~~~~~~~~~~~~~~~~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:84:33: note: each undeclared id=
entifier is reported only once for each function it appears in
../drivers/net/nbl/nbl_common/nbl_userdev.c:85:33: error: =E2=80=98VFIO_DMA=
_MAP_FLAG_WRITE=E2=80=99 undeclared (first use in this function); did you m=
ean =E2=80=98NBL_DEV_USER_DMA_MAP_FLAG_WRITE=E2=80=99?
   85 |                                 VFIO_DMA_MAP_FLAG_WRITE;
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
      |                                 NBL_DEV_USER_DMA_MAP_FLAG_WRITE
../drivers/net/nbl/nbl_common/nbl_userdev.c:87:48: error: =E2=80=98VFIO_IOM=
MU_MAP_DMA=E2=80=99 undeclared (first use in this function)
   87 |                 ret =3D ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA=
, &dma_map);
      |                                                ^~~~~~~~~~~~~~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:105:42: error: invalid applicat=
ion of =E2=80=98sizeof=E2=80=99 to incomplete type =E2=80=98struct vfio_iom=
mu_type1_dma_unmap=E2=80=99
  105 |                 dma_unmap.argsz =3D sizeof(struct vfio_iommu_type1_=
dma_unmap);
      |                                          ^~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:109:48: error: =E2=80=98VFIO_IO=
MMU_UNMAP_DMA=E2=80=99 undeclared (first use in this function)
  109 |                 ret =3D ioctl(vfio_container_fd, VFIO_IOMMU_UNMAP_D=
MA, &dma_unmap);
      |                                                ^~~~~~~~~~~~~~~~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:75:43: warning: unused variable=
 =E2=80=98dma_unmap=E2=80=99 [-Wunused-variable]
   75 |         struct vfio_iommu_type1_dma_unmap dma_unmap;
      |                                           ^~~~~~~~~
../drivers/net/nbl/nbl_common/nbl_userdev.c:74:41: warning: unused variable=
 =E2=80=98dma_map=E2=80=99 [-Wunused-variable]
   74 |         struct vfio_iommu_type1_dma_map dma_map;
      |                                         ^~~~~~~

