Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A070C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:10:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3FF140294;
	Tue, 18 Aug 2026 04:10:35 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 5E1134028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:10:34 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-39266382df6so3317366a91.3
 for <dev@dpdk.org>; Mon, 17 Aug 2026 19:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787019033;
 x=1787623833; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uJyoGXqgTu+tLDy1HmDKuQQQr+M37YhwFZV860EFk3M=;
 b=GZnySu6xtugkfvgMaLxZmPSo/KmfWVHgtKk9+G0pbJncRty8NVrWZXoOeWjz8SHPHw
 3qFAYlKoBHgnFfMXxD8xaLNpg9E0wK/fhfyRdjgNngjuyHvwEnSg5coQ0F5AsmPlQbZ1
 LWGYjzv8uWnuuWm63AJfEGDRJktT9S2GVYh88UI2jcAtkphzYa47JjR4kpwH8RufCnrc
 cJslLx799PIicJ5pVIM+ef71Skes2wA+my9rt1RlF4NSEkSdIz0iTYzVtu5LF3ZC9WY6
 Dkb1623VhyWt134+3l96ZPhAFYcrxg4oUq4VBlsD3JlOydKyA2outfO7HS/Rvk0HWgOz
 vCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019033; x=1787623833;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJyoGXqgTu+tLDy1HmDKuQQQr+M37YhwFZV860EFk3M=;
 b=AP+NrR85T7iCO2JIj8kjkP/iuQO1PwXcmVaNFkTNbHNbCtYDGC9ZxpGuL8bkgCs3EX
 r/iAABzwDrH/D4s+zyYB5vbASBr+ZCjQHY4IfrrVQzSp+vbx96Wqg9jDkYFblEcfBZwb
 fMigXvWAkxZpI7b38/d1BwuSoxQYAT/X3hnzlI+ArikKnsVP69iCq8Q9uYliAbqAnt2P
 ZYA5uBTdIjXbPaclVmHcBdUcWCDGseLGP5YSuYyybz/DObaSbTM+zvCLg97k2F4H9D9+
 OpCOpBekYfInKY9b+J5qS4+zT2ITAenCvrgWRMcrhS/KhaSMzBdkeBIsxJo6RGA8MKmD
 Qfow==
X-Gm-Message-State: AOJu0YyF5Mu6aUfBNjQwbWgyclO701AILX6XY790+MhGExZLm2O6w0Wy
 MTGMWFoBTqHCocJvwwUBEF0sN95LzsnT/zOn+vNrriKSvUTluvBtjOISeZg0mv9C5RKZd+N4ecv
 N96cQ
X-Gm-Gg: AR+sD11/Hi0duF/y1b6X72QsTo+1Pfz5ZkYh+ZteMI+I1F0v0HZzlNROzBivmvRr2J1
 Bwam7hFojnRHaoJI13KhAlQunYbGP+ZevCkGf0pqSwCStB5VGTdR2/0ZIVyW4xi/W7nqP4vRMs0
 ZlQ8alxbYtaBStLKaSCsGQ3JW9KGddHfD9T6CaK+Elu8IeIkQ3+o/2vPxXUjrn7fNDZbEvlzQP9
 UmLaQozSIkmdaF8iJSi3foQ3QbTk509UwdTfe9JDpDS7omHvzsaw2MDsSWo/JI4n/xbvWMMNR+W
 qpY9jRWAktY1JWuX3r1MegyjRFnloQuW5B35349GuoR/P8X0C46ByH3BLGAIGAE/wKqcWqKvZpW
 c1s68ZQG2HJOeXjQ7JHmVvYkf4LSYu7WfwhSxPflLxC64MA6Cn4guujPCeKq9akWK8vBLIIIJm3
 trsGOrssFU55b/cl7k64P2ow7ZFmCqfcJeyVRajPoKoF6KuZc9j2WcO48SsLVlHhZXg6ST2Z0hC
 CPoQAqRy0RyVTaET4fWvr5PwECUKg==
X-Received: by 2002:a17:90b:3b84:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3955a3dae07mr3502759a91.4.1787019032913; 
 Mon, 17 Aug 2026 19:10:32 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1415305e48esm11252015c88.5.2026.08.17.19.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 19:10:32 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:09:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/13] fix bugs
Message-ID: <20260817190940.5050d5ad@phoenix.local>
In-Reply-To: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
References: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
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

On Mon, 17 Aug 2026 10:53:26 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> Jie Liu (13):
>   net/sxe2: add Rx queue buffer split fill support
>   net/sxe2: update switchdev repr VSI ID display format
>   net/sxe2: add ACL engine event statistics support
>   net/sxe2: enhance device cap and res management
>   net/sxe2: improve representor device initialization
>   net/sxe2: refactor flow tunnel port handling
>   net/sxe2: validate IPsec key length against maximum limit
>   net/sxe2: enhance repr event handling and  MP code
>   net/sxe2: optimize vectorized Tx/Rx path
>   common/sxe2: allow munmap during kernel reset
>   net/sxe2: clean up duplicate function declarations
>   net/sxe2: clean up structure definitions
>   doc/sxe2: add acl-stat-type parameter documentation
>=20
>  doc/guides/nics/sxe2.rst                   |  33 +--
>  drivers/common/sxe2/sxe2_common.c          |   5 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |   8 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 215 +++++++++++++++--
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  47 ++--
>  drivers/net/sxe2/sxe2_dump.c               |  10 +-
>  drivers/net/sxe2/sxe2_ethdev.c             | 203 +++++++++-------
>  drivers/net/sxe2/sxe2_ethdev.h             |  38 +--
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  13 +-
>  drivers/net/sxe2/sxe2_flow.c               | 259 +++++++++++++++++----
>  drivers/net/sxe2/sxe2_flow.h               |   6 +-
>  drivers/net/sxe2/sxe2_flow_define.h        |  13 +-
>  drivers/net/sxe2/sxe2_flow_parse_action.c  |  37 ++-
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ---------
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   7 -
>  drivers/net/sxe2/sxe2_ipsec.c              |   5 +
>  drivers/net/sxe2/sxe2_irq.c                |  27 ++-
>  drivers/net/sxe2/sxe2_mac.c                |  10 +-
>  drivers/net/sxe2/sxe2_mp.c                 |  59 +++--
>  drivers/net/sxe2/sxe2_queue.c              |   2 +
>  drivers/net/sxe2/sxe2_queue.h              |   7 +-
>  drivers/net/sxe2/sxe2_rx.c                 |   5 +-
>  drivers/net/sxe2/sxe2_security.c           |   1 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  12 +-
>  drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
>  drivers/net/sxe2/sxe2_tx.h                 |   4 +
>  drivers/net/sxe2/sxe2_txrx.c               |  19 +-
>  drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
>  drivers/net/sxe2/sxe2_txrx_vec.c           |  79 +++----
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 133 +----------
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   9 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 219 +++++++++++------
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
>  drivers/net/sxe2/sxe2_vsi.c                |   8 +-
>  37 files changed, 989 insertions(+), 697 deletions(-)
>=20

Multiple build failures.

FAILED: drivers/libtmp_rte_net_sxe2.a.p/net_sxe2_sxe2_txrx_vec_neon.c.o=20
cc -Idrivers/libtmp_rte_net_sxe2.a.p -Idrivers -I../drivers -Idrivers/net/s=
xe2 -I../drivers/net/sxe2 -Idrivers/common/sxe2 -I../drivers/common/sxe2 -I=
lib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -I=
config -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/i=
nclude -I../lib/eal/linux/include -Ilib/eal/arm/include -I../lib/eal/arm/in=
clude -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs=
 -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I..=
/lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ili=
b/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/rin=
g -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../dr=
ivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/=
bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/cryptodev -I=
../lib/cryptodev -Ilib/security -I../lib/security -fdiagnostics-color=3Dalw=
ays -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -in=
clude rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonlite=
ral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-=
externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare -Wst=
rict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missin=
g-field-initializers -D_GNU_SOURCE -fPIC -mcpu=3Dneoverse-n1 -DALLOW_EXPERI=
MENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-pack=
ed-member -g -DRTE_COMPONENT_CLASS=3Dpmd_net -DRTE_COMPONENT_NAME=3Dsxe2 -D=
RTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.sxe2 -MD -MQ drivers/libtmp_rte_net_sxe2.=
a.p/net_sxe2_sxe2_txrx_vec_neon.c.o -MF drivers/libtmp_rte_net_sxe2.a.p/net=
_sxe2_sxe2_txrx_vec_neon.c.o.d -o drivers/libtmp_rte_net_sxe2.a.p/net_sxe2_=
sxe2_txrx_vec_neon.c.o -c ../drivers/net/sxe2/sxe2_txrx_vec_neon.c
../drivers/net/sxe2/sxe2_txrx_vec_neon.c: In function =E2=80=98sxe2_tx_desc=
_fill_4_neon_simple=E2=80=99:
../drivers/net/sxe2/sxe2_txrx_vec_neon.c:79:22: warning: cast discards =E2=
=80=98volatile=E2=80=99 qualifier from pointer target type [-Wcast-qual]
   79 |         vst1q_u64_x4((uint64_t *)desc, v);
      |                      ^
../drivers/net/sxe2/sxe2_txrx_vec_neon.c: In function =E2=80=98sxe2_rx_pkts=
_common_vec_neon=E2=80=99:
../drivers/net/sxe2/sxe2_txrx_vec_neon.c:458:54: error: =E2=80=98struct sxe=
2_adapter=E2=80=99 has no member named =E2=80=98ptype_tbl=E2=80=99
  458 |         const uint32_t *ptype_tbl =3D rxq->vsi->adapter->ptype_tbl;
      |                                                      ^~
