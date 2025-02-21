Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD778C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 22:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F28C402DE;
	Fri, 21 Feb 2025 23:35:52 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 30B87402CC
 for <dev@dpdk.org>; Fri, 21 Feb 2025 23:35:51 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0b9so4161867a91.0
 for <dev@dpdk.org>; Fri, 21 Feb 2025 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740177350;
 x=1740782150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp2He0OmcwFJqqZ+pZy3cg4c5YBUwmL3PFd+YQRdCu8=;
 b=Lz6kO/wN/g9u/d03Tnd2vjbNzGOsXWa2GL6alhahHuz2u8Yxv99f7YwG4hFbCDPKS3
 Ltf1w+EYDnkN8ibfEXNP4xCbS3VAeQuSMIgw6txHuQbX5e8g1Xrc9POc1Wg8GX89w6fs
 LKV6N+sOFGLIEjeGteZz4Q7a//YZXq/pRDlolC41PFHbcghv1Ih07UXFV0qyi8kqbbUm
 MIDNstPGItIYfODug/D+BEEVglPnZmqc8qRvLbb4If3Rlz8hyTIw50oOAMDMjaFpX8MY
 GZIhWBPRfJPUlvPuGrUP4QvnwtNREch0SgPlZDDe7K5IzymZhttKuNfR7ojJGVd67XG7
 6aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740177350; x=1740782150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lp2He0OmcwFJqqZ+pZy3cg4c5YBUwmL3PFd+YQRdCu8=;
 b=SzFp7Q8gPykdfI2LRN2qfOM7aowNfqkHeeRYpmBi8h69kZG2Luc6OVQIdMK/VaaDry
 D6YGDO0+4ioDREzGDT6gu9kf7a4tqpnO5mTxkVSAR24mimx1ARRyAHemjLe5crYupd/U
 B6Hn+YSM+akP0hNVsSBN8hIEGRGw1+6WHS6+to4n+P04vZOQDyuPotmwP4QUnbMPZaXB
 KGPd2Xe8OxZtH9hhPJSaWlyqLQxQl9Kt1LN+YZh2Pb4+UEF6KP6nIM0gDp9utmcpggXq
 fdvw7iZqZ5n1IOpdFZ1KoZ9gvGQKVA9urqLNWJKf4fT2HsS5ki/lAMHPVD0tXY/qeWuW
 SJBA==
X-Gm-Message-State: AOJu0Yxqr5YekKq04/twUg5V0BTXm1TzLAzoq+jLaf4/YaJ1YG002WWr
 JncH0E3eQ+/Q8oKcxBn8aHreOmE2v1DC1yV/h1txxag2MTqL6Iwd838cxZad+Wo=
X-Gm-Gg: ASbGncvDkDDq/wCC0MK62UgZJZEoB2WHWS/7fwngqethC4bJK1zV5a62U3UB6obiD+U
 LJGTc4316MQI7iIXq9V2tjaKNsegLVgYSRahNIXHBjllwGnZRTP6OT2iJfx4SZIGQNsL4voJAmg
 1GAXWLxXRO5O8r5TcPG/fi2HJemnGVdGLYiWVJHJwWAWNgho6pC1RNzwEcR8zRjv8+qZ7rxYIf8
 YCH6OeWJvyARSOau0MIccnWE/mxho2mmcuz+JfeiHFcQP2x9znWk9lx0A0CmwKFpiC9yoNU28u2
 2CQd7Z1qoVooAfiWWnrDqe+6tOaARSpj6/PGKfNL4H4fPSHKvzPXsTPcY2oA/KG/zwe/J0R7+al
 bhyA=
X-Google-Smtp-Source: AGHT+IFBhc5RoGvFhW+O5ojuml31/szIh0jn8oFq8gwL8T4eZndu42nZxg3nMuuLQO5k7ZeQiv9lyA==
X-Received: by 2002:a17:90b:4c43:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-2fce78ab923mr8769706a91.9.1740177349963; 
 Fri, 21 Feb 2025 14:35:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-addee79a984sm11484255a12.32.2025.02.21.14.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 14:35:49 -0800 (PST)
Date: Fri, 21 Feb 2025 14:35:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/16] net/zxdh: updated net zxdh driver
Message-ID: <20250221143547.27c8b34e@hermes.local>
In-Reply-To: <20250221020346.494392-1-wang.junlong1@zte.com.cn>
References: <20250213064134.88166-2-wang.junlong1@zte.com.cn>
 <20250221020346.494392-1-wang.junlong1@zte.com.cn>
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

On Fri, 21 Feb 2025 10:03:28 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> V2:
>   - modify CI some error results(checkpatches warnings=E3=80=81Wrong head=
line format)
>   - fix warnings when enable extra warnings.
>   - modify apply memcpy script for coccinelle and unnecessary init and
>     unneccessary cast of void when use malloc.
>=20
> V1:
>   - updated net zxdh driver.
>     optimize init and some ops.
>     provided csum/lro/tso =E3=80=81extend stats=E3=80=81fw_version=E3=80=
=81module_info =E3=80=81meter, etc.
>=20
> Junlong Wang (16):
>   net/zxdh: optimize np dtb channel initialization
>   net/zxdh: optimize queue res alloc/free process
>   net/zxdh: optimize link update process
>   net/zxdh: update Rx/Tx to latest
>   net/zxdh: provided PF/VF msg intr callback
>   net/zxdh: optimize MAC ops
>   net/zxdh: optimize promisc ops
>   net/zxdh: optimize VLAN filter/offload ops
>   net/zxdh: optimize RSS/RETA hash config/update/get
>   net/zxdh: optimize MTU set ops
>   net/zxdh: optimize basic stats ops
>   net/zxdh: provided CSUM/TSO/LRO config
>   net/zxdh: provided rxq/txq info get implementations
>   net/zxdh: provide extended stats ops implementations
>   net/zxdh: provide ptypes FW version EEPROM ops
>   net/zxdh: provide meter ops implementations
>=20
>  doc/guides/nics/features/zxdh.ini  |   11 +
>  doc/guides/nics/zxdh.rst           |    5 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.c     |   46 +-
>  drivers/net/zxdh/zxdh_common.h     |    3 +
>  drivers/net/zxdh/zxdh_ethdev.c     |  724 +++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev.h     |   69 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  916 ++++++++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   53 +-
>  drivers/net/zxdh/zxdh_msg.c        |  985 +++++++++++++++++++++-
>  drivers/net/zxdh/zxdh_msg.h        |  175 +++-
>  drivers/net/zxdh/zxdh_mtr.c        | 1223 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_mtr.h        |  114 +++
>  drivers/net/zxdh/zxdh_np.c         |  811 ++++++++++++++++--
>  drivers/net/zxdh/zxdh_np.h         |  262 ++++++
>  drivers/net/zxdh/zxdh_pci.c        |   10 -
>  drivers/net/zxdh/zxdh_queue.c      |  132 +--
>  drivers/net/zxdh/zxdh_queue.h      |  118 +--
>  drivers/net/zxdh/zxdh_rxtx.c       |  695 +++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |   27 +
>  drivers/net/zxdh/zxdh_tables.c     |  378 +++++++--
>  drivers/net/zxdh/zxdh_tables.h     |  220 +++--
>  22 files changed, 6040 insertions(+), 938 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.c
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.h

Still several checklist items, some of these are likely pre-existing condit=
ions.
The one that matters are the build issue with RTE_ASSERT enabled.

Mark items with:
    =E2=9C=94 passed
    =E2=9C=98 Failed
    o N/A

Basic hygiene
    =E2=9C=94 Look at CI results in patchwork
    =E2=9C=94 Merge cleanly with git am
    =E2=9C=94 Run checkpatches
      - bug in checkpatch around __rte_packed_begin macros
      - warning from stub

    =E2=9C=94 Run check-git-log
    =E2=9C=94 Run check-symbol-maps.sh
    =E2=9C=94 Run check-doc-vs-code
    =E2=9C=94 Run check-spdk-tag

Builds
    =E2=9C=94 Normal Gcc build; make sure driver is built!
    =E2=9C=94 Use latest experimental Gcc 15 to catch new warnings
    =E2=9C=94 Clang build using current version (clang-19)
    =E2=9C=94 Doc build
    o Build for 32 bit x86
    o Cross build for Windows (if applicable)
    =E2=9C=94 Debug build
    x Enable asserts
[1594/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_msg.c.o
FAILED: drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o
cc -Idrivers/libtmp_rte_net_zxdh.a.p -Idrivers -I../drivers -Idrivers/net/z=
xdh -I../drivers/net/zxdh -Ilib/ethdev -I../lib/ethdev -I. -I.. -Iconfig -I=
../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I=
../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I.=
./kernel/linux -Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal =
-Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/=
metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbu=
f -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Il=
ib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers=
/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/v=
dev -I/usr/include/x86_64-linux-gnu -fdiagnostics-color=3Dalways -D_FILE_OF=
FSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include rte_conf=
ig.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-s=
ecurity -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-=
style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef=
 -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers -D=
_GNU_SOURCE -DRTE_ENABLE_ASSERT -DRTE_LIBRTE_ETHDEV_DEBUG=3D1 -fPIC -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -Wno-address-of-packed-member -Wno-vla -DRTE_LOG_DEFAULT_LOGTYPE=
=3Dpmd.net.zxdh -MD -MQ drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c=
.o -MF drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o.d -o drivers/l=
ibtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o -c ../drivers/net/zxdh/zxdh_ms=
g.c
In file included from ../lib/eal/x86/include/rte_spinlock.h:11,
                 from ../drivers/net/zxdh/zxdh_msg.c:9:
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_vf_promisc_set=E2=
=80=99:
../drivers/net/zxdh/zxdh_msg.c:1450:41: error: =E2=80=98res_info=E2=80=99 u=
ndeclared (first use in this function)
 1450 |         RTE_ASSERT(!cfg_data || !hw || !res_info || !res_len);
      |                                         ^~~~~~~~
../lib/eal/include/rte_branch_prediction.h:43:45: note: in definition of ma=
cro =E2=80=98unlikely=E2=80=99
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
../lib/eal/include/rte_debug.h:47:25: note: in expansion of macro =E2=80=98=
RTE_VERIFY=E2=80=99
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                         ^~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1450:9: note: in expansion of macro =E2=80=
=98RTE_ASSERT=E2=80=99
 1450 |         RTE_ASSERT(!cfg_data || !hw || !res_info || !res_len);
      |         ^~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1450:41: note: each undeclared identifier is=
 reported only once for each function it appears in
 1450 |         RTE_ASSERT(!cfg_data || !hw || !res_info || !res_len);
      |                                         ^~~~~~~~
../lib/eal/include/rte_branch_prediction.h:43:45: note: in definition of ma=
cro =E2=80=98unlikely=E2=80=99
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
../lib/eal/include/rte_debug.h:47:25: note: in expansion of macro =E2=80=98=
RTE_VERIFY=E2=80=99
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                         ^~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1450:9: note: in expansion of macro =E2=80=
=98RTE_ASSERT=E2=80=99
 1450 |         RTE_ASSERT(!cfg_data || !hw || !res_info || !res_len);
      |         ^~~~~~~~~~
[1603/3244] Compiling C object drivers/libtmp_rte_net_virtio.a.p/net_virtio=
_virtio_rxtx.c.o
ninja: build stopped: subcommand failed.

    =E2=9C=94 Test meson builds

Experimental builds:
    =E2=9C=98 Enable address sanitizer for undefined checks

[1603/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_np.c.o
In function =E2=80=98zxdh_np_dtb_smmu0_write_entry_data=E2=80=99,
    inlined from =E2=80=98zxdh_np_dtb_se_smmu0_ind_write=E2=80=99 at ../dri=
vers/net/zxdh/zxdh_np.c:1104:7,
    inlined from =E2=80=98zxdh_np_dtb_eram_one_entry=E2=80=99 at ../drivers=
/net/zxdh/zxdh_np.c:1181:8,
    inlined from =E2=80=98zxdh_np_dtb_table_entry_write=E2=80=99 at ../driv=
ers/net/zxdh/zxdh_np.c:1452:9:
../drivers/net/zxdh/zxdh_np.c:75:12: warning: =E2=80=98rc=E2=80=99 may be u=
sed uninitialized [-Wmaybe-uninitialized]
   75 |         if ((rc) !=3D 0) {\
      |            ^
../drivers/net/zxdh/zxdh_np.c:1051:17: note: in expansion of macro =E2=80=
=98ZXDH_COMM_CHECK_RC_NO_ASSERT=E2=80=99
 1051 |                 ZXDH_COMM_CHECK_RC_NO_ASSERT(rc, "dpp_dtb_write_tab=
le_cmd");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_np.c: In function =E2=80=98zxdh_np_dtb_table_entry=
_write=E2=80=99:
../drivers/net/zxdh/zxdh_np.c:983:26: note: =E2=80=98rc=E2=80=99 was declar=
ed here
  983 |         uint32_t         rc;
      |                          ^~

    =E2=9C=98 Enable extra warnings (edit meson.build) for
        -Wvla, -Wformat-truncation, -Waddress-of-packed-member

[1600/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_queue.c.o
../drivers/net/zxdh/zxdh_queue.c: In function =E2=80=98zxdh_dev_rx_queue_se=
tup_finish=E2=80=99:
../drivers/net/zxdh/zxdh_queue.c:357:24: warning: ISO C90 forbids variable =
length array =E2=80=98new_pkts=E2=80=99 [-Wvla]
  357 |                 struct rte_mbuf *new_pkts[free_cnt];
      |                        ^~~~~~~~
[1603/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_rxtx.c.o
../drivers/net/zxdh/zxdh_rxtx.c: In function =E2=80=98zxdh_recv_pkts_packed=
=E2=80=99:
../drivers/net/zxdh/zxdh_rxtx.c:903:24: warning: ISO C90 forbids variable l=
ength array =E2=80=98new_pkts=E2=80=99 [-Wvla]
  903 |                 struct rte_mbuf *new_pkts[free_cnt];
      |                        ^~~~~~~~
[1616/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_ethdev_ops.c.o
../drivers/net/zxdh/zxdh_ethdev_ops.c: In function =E2=80=98zxdh_dev_xstats=
_get_names=E2=80=99:
../drivers/net/zxdh/zxdh_ethdev_ops.c:1983:26: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 1359 bytes into a regio=
n of size 64 [-Wformat-truncation=3D]
 1983 |                         "%s", zxdh_np_stat_strings[i].name);
      |                          ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1982:25: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 1360 bytes into a destination of size 64
 1982 |                         snprintf(xstats_names[count].name, sizeof(x=
stats_names[count].name),
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~
 1983 |                         "%s", zxdh_np_stat_strings[i].name);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1989:34: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 2991 bytes into a regio=
n of size 64 [-Wformat-truncation=3D]
 1989 |                                 "%s", zxdh_mac_stat_strings[i].name=
);
      |                                  ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1988:33: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 2992 bytes into a destination of size 64
 1988 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1989 |                                 "%s", zxdh_mac_stat_strings[i].name=
);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1994:34: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 271 bytes into a region=
 of size 64 [-Wformat-truncation=3D]
 1994 |                                 "%s", zxdh_mac_bytes_strings[i].nam=
e);
      |                                  ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1993:33: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 272 bytes into a destination of size 64
 1993 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1994 |                                 "%s", zxdh_mac_bytes_strings[i].nam=
e);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2000:26: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 339 bytes into a region=
 of size 64 [-Wformat-truncation=3D]
 2000 |                         "%s", zxdh_vqm_stat_strings[i].name);
      |                          ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1999:25: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 340 bytes into a destination of size 64
 1999 |                         snprintf(xstats_names[count].name, sizeof(x=
stats_names[count].name),
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~
 2000 |                         "%s", zxdh_vqm_stat_strings[i].name);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2010:41: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 1359 bytes into a regio=
n of size between 54 and 58 [-Wformat-truncation=3D]
 2010 |                                 "rx_q%u_%s", i, zxdh_rxq_stat_strin=
gs[t].name);
      |                                         ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2009:33: note: =E2=80=98snprintf=E2=
=80=99 output between 7 and 1370 bytes into a destination of size 64
 2009 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2010 |                                 "rx_q%u_%s", i, zxdh_rxq_stat_strin=
gs[t].name);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2022:41: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 1291 bytes into a regio=
n of size between 54 and 58 [-Wformat-truncation=3D]
 2022 |                                 "tx_q%u_%s", i, zxdh_txq_stat_strin=
gs[t].name);
      |                                         ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2021:33: note: =E2=80=98snprintf=E2=
=80=99 output between 7 and 1302 bytes into a destination of size 64
 2021 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2022 |                                 "tx_q%u_%s", i, zxdh_txq_stat_strin=
gs[t].name);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~

Look for anti-patterns:
    =E2=9C=94 Do not put brackets on each switch case.
    =E2=9C=94 Driver must not disable warnings with compiler flags or pragm=
a's
    =E2=9C=94 Driver must not use thread and signal
    =E2=9C=94 Driver should not call abort() or assert() directly
    =E2=9C=94 Review exposed symbol names

    =E2=9C=94 Apply coccinelle scripts; look that for example null free che=
cks

  - Apply memcpy script for coccinelle
      Lots of fixed size memcpy's that can get fixed later (see other patch=
 series)

    =E2=9C=94 Review use of malloc
      Several places could use rte_calloc instead of rte_zmalloc (low prior=
ity)

    =E2=9C=98  Review use of memset

Extra memset and cast here:
static int32_t
zxdh_fill_common_msg(struct zxdh_hw *hw, struct zxdh_pci_bar_msg *desc,
		uint8_t type, uint8_t field,
		void *buff, uint16_t buff_size)
{
	uint64_t msg_len =3D sizeof(struct zxdh_common_msg) + buff_size;

	desc->payload_addr =3D rte_zmalloc(NULL, msg_len, 0);
	if (unlikely(desc->payload_addr =3D=3D NULL)) {
		PMD_DRV_LOG(ERR, "Failed to allocate msg_data");
		return -ENOMEM;
	}
	memset(desc->payload_addr, 0, msg_len); // zmalloc memory is already zero!
	desc->payload_len =3D msg_len;
	// payload_addr is void *, cast not needed
	struct zxdh_common_msg *msg_data =3D (struct zxdh_common_msg *)desc->paylo=
ad_addr;
