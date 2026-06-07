Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67306CD8C8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Jun 2026 17:49:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D005402AD;
	Sun,  7 Jun 2026 19:49:20 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id AF55E40278
 for <dev@dpdk.org>; Sun,  7 Jun 2026 19:49:19 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-137dd4cc208so2081681c88.1
 for <dev@dpdk.org>; Sun, 07 Jun 2026 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780854558;
 x=1781459358; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kS08nK+y10Qj31m/mudfCA5pK9J9TwyJ70g+pesItgM=;
 b=i/2J9WjNUlrR3U/GCfSW9bKhSr/bGpaMLxMDjcYzaPkfhtRBAHUR/ueNLpAAvvZmBv
 X+bOw0AEgXE5g6p8STDIzL7DhMPF9PXpmyAZrjyJSuS/T3Bh0nFiHFCKqeoheY1mnEZh
 0D6cma1HszGEbW8b04guvWf+FOWax0BdjUEGjYojMLKYajhmfaCmXt8s5lKkg5VRBJFC
 JezyYng1sjwMHWBikLgBlf+mHLge9j4LINjo2wh2D7rcLkrFdgPuK9ibGR14E/gIJ9az
 TVCXxaq4GkV+AoLVCzBfAVKpf8ZKvxn3flRAlCkStaVhejYKQwGhCcVM9hWUX6kd6+eF
 swhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780854558; x=1781459358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kS08nK+y10Qj31m/mudfCA5pK9J9TwyJ70g+pesItgM=;
 b=On6udZwWwz+TiAZfNBwJsfDhVCHi0cFeOSgT5IO7ivRK4Uj4VdIIPFMFQyVa/lZYin
 aC15tD69aWBV9EWSHp7G6g+N+1m/RxsrYB/LTjQVUO+hcE4boHgJM+DSG87J0H5q3/2k
 BD131hWSdT0uhjptsO36p9J06GmAk2yumZGZo4ZIlK4BYoOsT4VsPT+Hm5vuy+46j7zI
 pwxzBx0Au3a7VCXyG+tNB6Cvx62PVkXR1MdAYzHfJBSvXLuXdqHQMTPPV76ujXo2WWhw
 e+PjI13cbR45qkmPZA6P8tFYQLEKEEO9lzhbpd4zYk6qjoVPC3oz5Z7Y/hwODXtMZnbg
 k15Q==
X-Gm-Message-State: AOJu0YzKAngBTZkPKH3SxL156NfMcDJvmCUxWmMr4wAcSICLfFN6rxe5
 QXUthsWkRs5qVFnaDAgVqJ0mEndIevMBGr35V5g6FO1Y2BbdYfbdL+EIWT4la75F8ko9Ywe6OiP
 X9aL+
X-Gm-Gg: Acq92OH29bw6U1jA1lcwMlHGKsal9mnA375ZRyV0z9JMCm/Dvj+4xnevHHn3S6oc6/i
 8uTyxPJcIp/7ARftA8qf2Mm2JTFLAUNBpxf0ElXZZ5flWtVHToaMBNvkoYlQAB3siPUZw9fYeWH
 X46OAD96oz30Am2zh/v5JbE/FiB2ya2lQ4TnqmSJ8Z8HNakGKSLfpwuHxboQV38YaptTSfN/qgx
 0yvI38c6MyxEGEvIRZRVOMjd7+KGrXCbN4uvDzKH8kYhrwSgtvZZQIVaXS0cLYlZHguYk09qAms
 1NvpffW97j1LBzVl8gHVoCtanOlWhkDLzPlkhxIufs1uZ7Qf+MuGGmT/Sp1iPyu6hXdUt2CpQeU
 qHK8weHjrgaBL6icmbwJijORUgtB6j+WkKSLilTvjYGGq8gg246ciqFgPJiN0Ip/WRobd0QczI6
 lbn1gVTlwo6ORQdwy89wc50EKqz8pYzoLg6oohulGv7RUC8eu0EGBDEWHYB342uV1/NXCVaPSPN
 pg=
X-Received: by 2002:a05:7022:48d:b0:136:4e2c:95a2 with SMTP id
 a92af1059eb24-13807c24611mr5713505c88.0.1780854558462; 
 Sun, 07 Jun 2026 10:49:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm10825108c88.14.2026.06.07.10.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 10:49:18 -0700 (PDT)
Date: Sun, 7 Jun 2026 10:49:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260607104915.6db15e73@phoenix.local>
In-Reply-To: <20260607013342.2579271-1-liujie5@linkdatatechnology.com>
References: <20260606010726.2256170-21-liujie5@linkdatatechnology.com>
 <20260607013342.2579271-1-liujie5@linkdatatechnology.com>
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

On Sun,  7 Jun 2026 09:33:22 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
>=20
> V11:
>  - Addressed AI comments
>=20
> Jie Liu (20):
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   drivers: add supported packet types get callback
>   net/sxe2: support L2 filtering and MAC config
>   drivers: support RSS feature
>   net/sxe2: support TM hierarchy and shaping
>   net/sxe2: support IPsec inline protocol offload
>   net/sxe2: support statistics and multi-process
>   drivers: interrupt handling
>   net/sxe2: add NEON vec Rx/Tx burst functions
>   drivers: add support for VF representors
>   net/sxe2: add support for custom UDP tunnel ports
>   net/sxe2: support firmware version reading
>   net/sxe2: implement get monitor address
>   common/sxe2: add shared SFP module definitions
>   net/sxe2: support SFP module info and EEPROM access
>   net/sxe2: implement private dump info
>   net/sxe2: add mbuf validation in Tx debug mode
>   drivers: add testpmd commands for private features
>   net/sxe2: update sxe2 feature matrix docs
>=20
>  doc/guides/nics/features/sxe2.ini          |   56 +
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/common/sxe2/sxe2_ptype.h           | 1793 ++++++++++++++++++
>  drivers/net/sxe2/meson.build               |   56 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  521 +++++-
>  drivers/net/sxe2/sxe2_dump.c               |  304 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1531 +++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  115 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  610 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1391 ++++++++++++++
>  drivers/net/sxe2/sxe2_flow.h               |   30 +
>  drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
>  drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 ++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
>  drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
>  drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 ++++++++++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
>  drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
>  drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
>  drivers/net/sxe2/sxe2_irq.c                | 1025 +++++++++++
>  drivers/net/sxe2/sxe2_irq.h                |   25 +
>  drivers/net/sxe2/sxe2_mac.c                |  535 ++++++
>  drivers/net/sxe2/sxe2_mac.h                |   84 +
>  drivers/net/sxe2/sxe2_mp.c                 |  414 +++++
>  drivers/net/sxe2/sxe2_mp.h                 |   67 +
>  drivers/net/sxe2/sxe2_queue.c              |   17 +-
>  drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
>  drivers/net/sxe2/sxe2_rss.h                |   81 +
>  drivers/net/sxe2/sxe2_rx.c                 |   38 +
>  drivers/net/sxe2/sxe2_rx.h                 |    2 +
>  drivers/net/sxe2/sxe2_security.c           |  335 ++++
>  drivers/net/sxe2/sxe2_security.h           |   77 +
>  drivers/net/sxe2/sxe2_stats.c              |  591 ++++++
>  drivers/net/sxe2/sxe2_stats.h              |   39 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
>  drivers/net/sxe2/sxe2_switchdev.h          |   33 +
>  drivers/net/sxe2/sxe2_testpmd.c            |  733 ++++++++
>  drivers/net/sxe2/sxe2_testpmd_lib.c        |  969 ++++++++++
>  drivers/net/sxe2/sxe2_testpmd_lib.h        |  142 ++
>  drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   78 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               |  176 +-
>  drivers/net/sxe2/sxe2_txrx.h               |    4 +
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  243 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  776 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  897 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 +
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  721 ++++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   85 +
>  68 files changed, 26575 insertions(+), 127 deletions(-)
>  create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
>  create mode 100644 drivers/common/sxe2/sxe2_msg.h
>  create mode 100644 drivers/common/sxe2/sxe2_ptype.h
>  create mode 100644 drivers/net/sxe2/sxe2_dump.c
>  create mode 100644 drivers/net/sxe2/sxe2_dump.h
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.c
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.h
>  create mode 100644 drivers/net/sxe2/sxe2_filter.c
>  create mode 100644 drivers/net/sxe2/sxe2_filter.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_define.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.h
>  create mode 100644 drivers/net/sxe2/sxe2_ipsec.c
>  create mode 100644 drivers/net/sxe2/sxe2_ipsec.h
>  create mode 100644 drivers/net/sxe2/sxe2_irq.c
>  create mode 100644 drivers/net/sxe2/sxe2_mac.c
>  create mode 100644 drivers/net/sxe2/sxe2_mac.h
>  create mode 100644 drivers/net/sxe2/sxe2_mp.c
>  create mode 100644 drivers/net/sxe2/sxe2_mp.h
>  create mode 100644 drivers/net/sxe2/sxe2_rss.c
>  create mode 100644 drivers/net/sxe2/sxe2_rss.h
>  create mode 100644 drivers/net/sxe2/sxe2_security.c
>  create mode 100644 drivers/net/sxe2/sxe2_security.h
>  create mode 100644 drivers/net/sxe2/sxe2_stats.c
>  create mode 100644 drivers/net/sxe2/sxe2_stats.h
>  create mode 100644 drivers/net/sxe2/sxe2_switchdev.c
>  create mode 100644 drivers/net/sxe2/sxe2_switchdev.h
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd.c
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.c
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.h
>  create mode 100644 drivers/net/sxe2/sxe2_tm.c
>  create mode 100644 drivers/net/sxe2/sxe2_tm.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
>  create mode 100644 drivers/net/sxe2/sxe2vf_regs.h
>=20

Build fails:
FAILED: [code=3D1] drivers/libtmp_rte_net_sxe2.a.p/net_sxe2_sxe2_irq.c.o=20
ccache gcc -Idrivers/libtmp_rte_net_sxe2.a.p -Idrivers -I../drivers -Idrive=
rs/net/sxe2 -I../drivers/net/sxe2 -Idrivers/common/sxe2 -I../drivers/common=
/sxe2 -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I.=
 -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal=
/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/ea=
l/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../li=
b/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/teleme=
try -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/=
net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I..=
/lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci=
 -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../=
drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/cryp=
todev -I../lib/cryptodev -Ilib/security -I../lib/security -Ilib/cmdline -I.=
./lib/cmdline -fdiagnostics-color=3Dalways -pipe -D_FILE_OFFSET_BITS=3D64 -=
Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h =
-Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-securi=
ty -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style=
-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstrict-prototypes -Wu=
ndef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializer=
s -D_GNU_SOURCE -fPIC -march=3Dcorei7 -mrtm -DALLOW_EXPERIMENTAL_API -DALLO=
W_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -g -DCC=
_AVX512_SUPPORT -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.sxe2 -MD -MQ drivers/li=
btmp_rte_net_sxe2.a.p/net_sxe2_sxe2_irq.c.o -MF drivers/libtmp_rte_net_sxe2=
.a.p/net_sxe2_sxe2_irq.c.o.d -o drivers/libtmp_rte_net_sxe2.a.p/net_sxe2_sx=
e2_irq.c.o -c ../drivers/net/sxe2/sxe2_irq.c
../drivers/net/sxe2/sxe2_irq.c: In function =E2=80=98sxe2_intr_init=E2=80=
=99:
../drivers/net/sxe2/sxe2_irq.c:468:42: error: implicit declaration of funct=
ion =E2=80=98RTE_ETH_DEV_TO_PCI=E2=80=99; did you mean =E2=80=98RTE_ETH_DEV=
_SRIOV=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  468 |         struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);
      |                                          ^~~~~~~~~~~~~~~~~~
      |                                          RTE_ETH_DEV_SRIOV
../drivers/net/sxe2/sxe2_irq.c:468:42: error: nested extern declaration of =
=E2=80=98RTE_ETH_DEV_TO_PCI=E2=80=99 [-Werror=3Dnested-externs]
../drivers/net/sxe2/sxe2_irq.c:468:42: error: initialization of =E2=80=98st=
ruct rte_pci_device *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer fro=
m integer without a cast [-Werror=3Dint-conversion]
../drivers/net/sxe2/sxe2_irq.c: In function =E2=80=98sxe2_intr_uninit=E2=80=
=99:
../drivers/net/sxe2/sxe2_irq.c:550:42: error: initialization of =E2=80=98st=
ruct rte_pci_device *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer fro=
m integer without a cast [-Werror=3Dint-conversion]
  550 |         struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);
      |                                          ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Suggest doing local builds with clang and gcc.
