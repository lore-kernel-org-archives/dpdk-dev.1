Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF08C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5954D40BA6;
	Tue, 17 Jun 2025 15:46:30 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 269ED40BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:46:29 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4a4bb155edeso68896991cf.2
 for <dev@dpdk.org>; Tue, 17 Jun 2025 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750167988;
 x=1750772788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMmBMYInmSdOc3tbzJhfVERKI/GcLJd864tOz7jacaI=;
 b=x4cnmHnMt/8IsWstk9mbMqWhJHSufo14YKRBb5xUfT1wURGAB+6IgVEPAcHAZkv61l
 +z/5+XTRuLHiayxaVG/kaN1NJbxCg+4BhrGimDfmVJVhLjApVo76PsARIWYK5wPR34eV
 s4o1EnSkC/+BsOMK/KR9lNosVCChg7EnxfnlR7BtdJrC7lPj++cDHzR6/rrvsqBr1Kyd
 /9SUvd0BvYizP6jAfshy47WwdTNs2Vc4pIcxfT/nL2WZLG2ulgtgWBN4qgN9aVztK/Hv
 fWh/9oglQJ6ZXe+8O3Cdnfks7HuaPWPty6Sbt+bTE2lhAsonWyPiiRQLF+Y1JH/yTTJU
 VF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750167988; x=1750772788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMmBMYInmSdOc3tbzJhfVERKI/GcLJd864tOz7jacaI=;
 b=fHrFUnSaVanGBwnmSUPdlug5E3gWnoYTfaoGmtYo1vBS8DG8IfIKiO5/YGM0lsnWlg
 fhj+wiU6Slwyf9qlIwV9J+wc0mIzD9HkG1Mytk3wcYGGvLjde8r+qr/1YRAz87Ajn9VU
 FSXWeGGSILYdPqu3e0AC526iMTk/Xtt/BInnMeyeFap2ywvoPg7up2msk3rNRq31Yy+C
 fnTlEaoDLf0paPkj/sSIgFSZEjBrSUxJZ+pVRATBROs+n1ZBYXYmTDJq4VixOPJw/RHg
 7bB1tw4vfS6hcpsqQd7knQgTPuZ67IORfylDMDG9qXcOc8pxvTUpXH6HPmyRm4nQN15w
 cYBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB9zu54lB3oX0zs2Fkd9AtuaSoWYtFwTp2+uagMIipcl3HMfn5qjVeaEZrsRz8PPRoS8U=@dpdk.org
X-Gm-Message-State: AOJu0YyDkIfQVduwgcCg4lYp8tJEw8AMIDn6jE9aWOyzVCq/sEScttxS
 C2uZ67CtVj9PtXhs9ep+ctW+pejeiSXmY6fLwxm4H47FN3YDfgBTvWcXslIoD/kCNcqCO8SiTPa
 SBjqr
X-Gm-Gg: ASbGnctb+2p3f1cQKnAM6WxvAOUb6QlN/dx2a8ZZPlkkUNJyHENCNHHGNYVbfp3BKNy
 ffJqv7VkqVf3KETlGhUuij+VvoUf6SXuVcJ08Lup+SvhiUlPhnRf7w9uFompafk2GdaoP8xCyaV
 /OMRUaDZhIwLAElLi3S+munsFUngO7L8cByKxYv0TeOSVf2i2rR4vfu9RQrB0iXSN6T3ZBN0Wdl
 0cDmK/rLLEE3FogeJArNRjyu8PPR9UogKWQBzMgj8H1vnqu09j2gTpOxCpgkVcMNQhg45/u+T4n
 LCkioIyLcglYVINpqqNNcDJwOQmq5S3C+re0afkC0B/Z2Q7I5Io088B9CUVF647YNa9A+r2ticO
 kjoDi36DnVrctfhg8ImsS/eeV1cSNLzQsY6HPqhs=
X-Google-Smtp-Source: AGHT+IGYuc7gfwiC0kqAnkOyi6ZzPABOjFllTE/nSeENOtslevjE+ejmvDthYQGudJTSJVK1dDZLAg==
X-Received: by 2002:ac8:7f11:0:b0:4a4:2c75:aa5a with SMTP id
 d75a77b69052e-4a73c5fff34mr229729251cf.30.1750167988229; 
 Tue, 17 Jun 2025 06:46:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a2e94fesm61680871cf.24.2025.06.17.06.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 06:46:28 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:46:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
Cc: kyo.liu@nebula-matrix.com, dev@dpdk.org
Subject: Re: [PATCH v2 00/16] NBL PMD for Nebulamatrix NICs
Message-ID: <20250617064622.2977d4a2@hermes.local>
In-Reply-To: <20250617032353.3036379-1-dimon.zhao@nebula-matrix.com>
References: <20250617032353.3036379-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 16 Jun 2025 20:23:37 -0700
"dimon.zhao" <dimon.zhao@nebula-matrix.com> wrote:

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
>  .mailmap                                      |    5 +
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
>  41 files changed, 7720 insertions(+)
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

Looks like missing RTE_ATOMIC() on nbl_dma_memzone_id.
Please fix and send v3

###########################################################################=
#########
#### [Begin job log] "ubuntu-22.04-clang-stdatomic" at step Build and test
###########################################################################=
#########
[1210/3613] Compiling C object drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_hws=
_mlx5dr_crc32.c.o
[1211/3613] Compiling C object drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_hws=
_mlx5dr_definer.c.o
[1212/3613] Compiling C object drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_hws=
_mlx5dr_bwc.c.o
[1213/3613] Compiling C object drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_e=
thdev.c.o
[1214/3613] Compiling C object drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_c=
ore.c.o
[1215/3613] Compiling C object drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_c=
ommon_nbl_common.c.o
FAILED: drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_common_nbl_common.c.o=20
ccache clang -Idrivers/libtmp_rte_net_nbl.a.p -Idrivers -I../drivers -Idriv=
ers/net/nbl -I../drivers/net/nbl -I../drivers/net/nbl/nbl_include -I../driv=
ers/net/nbl/nbl_hw -I../drivers/net/nbl/nbl_common -Ilib/ethdev -I../lib/et=
hdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Il=
ib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/li=
nux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linu=
x -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/lo=
g -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/n=
et -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Il=
ib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../dri=
vers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bu=
s/vdev -I../drivers/bus/vdev -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFS=
ET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include=
 rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -=
Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-exter=
ns -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototype=
s -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE -fP=
IC -march=3Dcorei7 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno=
-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.nbl -DRTE_ANN=
OTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_nbl.a.p/net_nbl_=
nbl_common_nbl_common.c.o -MF drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_co=
mmon_nbl_common.c.o.d -o drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_common_=
nbl_common.c.o -c ../drivers/net/nbl/nbl_common/nbl_common.c
../drivers/net/nbl/nbl_common/nbl_common.c:23:3: error: address argument to=
 atomic operation must be a pointer to _Atomic type ('uint64_t *' (aka 'uns=
igned long *') invalid)
                rte_atomic_fetch_add_explicit(&nbl_dma_memzone_id, 1, rte_m=
emory_order_relaxed));
                ^                             ~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_stdatomic.h:88:2: note: expanded from macro 'rte_ato=
mic_fetch_add_explicit'
        atomic_fetch_add_explicit(ptr, val, memorder)
        ^                         ~~~
/usr/lib/llvm-14/lib/clang/14.0.0/include/stdatomic.h:142:35: note: expande=
d from macro 'atomic_fetch_add_explicit'
#define atomic_fetch_add_explicit __c11_atomic_fetch_add
                                  ^
1 error generated.
[1216/3613] Compiling C object drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_c=
ommon_nbl_thread.c.o
[1217/3613] Compiling C object drivers/libtmp_rte_net_nbl.a.p/net_nbl_nbl_d=
ispatch.c.o
[1218/3613] Compiling C object drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx=
5_tx_empw.c.o
[1219/3613] Compiling C object drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx=
5_tx_txpp.c.o
[1220/3613] Compiling C object drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx=
5_tx_nompw.c.o
