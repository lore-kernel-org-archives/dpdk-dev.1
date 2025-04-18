Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B5C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9EFA402E2;
	Fri, 18 Apr 2025 20:20:42 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id CB7BA402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:20:40 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so2358146a91.2
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745000440;
 x=1745605240; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2LRf/Sc64vNxb0FBLiEppSvXi+6HH4Rk2pYqZSFYOU=;
 b=s9fNu31ShIrjdAa3er5PBDLZpyjssaP6k1bQKn2wXkZzFa+DA7utQevlCa4NeO/jYk
 +tSDr4+BnfkkhKPKOTzmizDtZlzxtwCKiDkNI1JAVt8AeCllkq1EtzaENR4s6HIS4are
 N7ceuDfoZkm1dIzwH//NMuvURyv3HRjfE8eBxqqeMsjuCwJgwL+t5BflApLNPVsfFE0c
 yZqL0gQN4EQaVWl75Q0qahxB8K34aEgPPUXn03ZvkcWQSMf5jZk7br8QqiXipg+TNJqJ
 +AIfonJHJqV9vpeLZUbpmkfX+yNp32eLJy4sIs5XmiN8W+GQwoC+W5KFrSVyFRckjCo4
 DyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745000440; x=1745605240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2LRf/Sc64vNxb0FBLiEppSvXi+6HH4Rk2pYqZSFYOU=;
 b=n5mvn15FzoLFaziPAYmBWclQ+vZ7J7g0R8K7gnYEYxzoip8gTmFR5iZJyp9wGifPEi
 EITIjkB5zrAdcKq3i4wqPmrNnTVp4Jisn5Lk0AXo18liFZ4flgUJGH96QcxvedZsrx9d
 g7vf0vM/nOSNleYd3To6JgGb5iHjSQo1HAYo6N2M/7icnG078R6x3UDd+6nqjht707VE
 VfXXxRh8qKy9oMgRiyYlbqUkNP9P3mHzoF4fUgzADJF4bxx2GU5cqb4hmlv0FlTtTs/s
 +ZD0UUolNHmOw71SNnQOBTcuhl9FWjCCKwxCKHtH2w+p3M2aSCni/YtWXl0gfmq4F9FJ
 xfJw==
X-Gm-Message-State: AOJu0Yz+OYdmvgkntY1+xtGfyFSXli0i2aTUGRWqZx468jY9AoSDrN/d
 cUif0HzAseTiTUtN96TWC1HfMdbgSVQg2cDBByNcWFiqbM+jPA4ZdsmSPKD66kc=
X-Gm-Gg: ASbGnctWoQomBwGKWGnsNbWCKfgKU/1oALzlNKePEVmpD7//mXjbkIYmI646yp2HkeZ
 yB7H2FxR33Uel+Cg2Zm8txa4rFPh/4BLolQd7HXH+foMJZLVMEiMTHaD9mBrX7P9/9xjgDrtICR
 4X+5A0XLXjtkMLGj3iiyZdwGTWeJx2vNur+vpruofY+VNEI/vEOCcea+4eXUVJJmz4kJBbi6fty
 lHaq6lrOtT3yzc7Dmg+54Bq0TG+T1+vqD4FA2Z7T+v++RPIfW12iCGIVt1Ei09pBmmim2cvjj2m
 SDboVF6ab4VioIgLvqGvyBLVV/bCiBhl3clVi+ZtnfgpDqtc/U/wpxxSP9cLxFk892+wg1Ol0Hn
 oBZCWJl2HRxOkotY8
X-Google-Smtp-Source: AGHT+IG+epkpO1Y3Q0LQTKX5c9CHakRBur9BU3F1315yB3Zh+NwLYHFGWXSHyIlRT2Igvpt9R+1YmQ==
X-Received: by 2002:a17:90b:5646:b0:305:2d28:c8fd with SMTP id
 98e67ed59e1d1-3087bcc3a54mr5442270a91.24.1745000439834; 
 Fri, 18 Apr 2025 11:20:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e8b6236sm1217577a91.1.2025.04.18.11.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:20:39 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:20:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 00/18] add hinic3 PMD driver
Message-ID: <20250418112038.14b33e6b@hermes.local>
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:05:46 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> *** BLURB HERE ***
> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
>=20
> Feifei Wang (3):
>   net/hinic3: add intro doc for hinic3
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
>=20
> Xin Wang (7):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initailization
>   net/hinic3: add MML and EEPROM access feature
>   net/hinic3: add RSS promiscuous ops
>=20
> Yi Chen (8):
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism function code
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add FDIR flow control module
>   drivers/net: add hinic3 PMD build and doc files
>=20
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |    9 +
>  doc/guides/nics/hinic3.rst                 |   52 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_07.rst     |   32 +-
>  drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  975 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  719 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1392 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  199 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  392 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  121 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1828 +++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1527 ++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  433 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   39 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  148 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   50 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3866 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  167 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1394 +++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
>  drivers/net/hinic3/hinic3_flow.c           | 1700 +++++++++
>  drivers/net/hinic3/hinic3_flow.h           |   80 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  827 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  169 +
>  drivers/net/hinic3/hinic3_rx.c             | 1096 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  356 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  315 ++
>  drivers/net/hinic3/meson.build             |   44 +
>  drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
>  drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
>  drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
>  drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
>  drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
>  drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
>  drivers/net/hinic3/mml/hinic3_mml_lib.h    |  275 ++
>  drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
>  drivers/net/hinic3/mml/hinic3_mml_queue.c  |  749 ++++
>  drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
>  drivers/net/hinic3/mml/meson.build         |   62 +
>  drivers/net/meson.build                    |    1 +
>  57 files changed, 25926 insertions(+), 31 deletions(-)
>  create mode 100644 doc/guides/nics/features/hinic3.ini
>  create mode 100644 doc/guides/nics/hinic3.rst
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
>  create mode 100644 drivers/net/hinic3/base/meson.build
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.c
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.h
>  create mode 100644 drivers/net/hinic3/hinic3_flow.c
>  create mode 100644 drivers/net/hinic3/hinic3_flow.h
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
>  create mode 100644 drivers/net/hinic3/hinic3_rx.c
>  create mode 100644 drivers/net/hinic3/hinic3_rx.h
>  create mode 100644 drivers/net/hinic3/hinic3_tx.c
>  create mode 100644 drivers/net/hinic3/hinic3_tx.h
>  create mode 100644 drivers/net/hinic3/meson.build
>  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h
>  create mode 100644 drivers/net/hinic3/mml/meson.build
>=20


Clang is spotting a possible bug in driver.

FAILED: drivers/net/hinic3/base/libspnic_base.a.p/hinic3_nic_cfg.c.o=20
clang -Idrivers/net/hinic3/base/libspnic_base.a.p -Idrivers/net/hinic3/base=
 -I../drivers/net/hinic3/base -Idrivers/net/hinic3 -I../drivers/net/hinic3 =
-Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/ea=
l/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/i=
nclude -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Il=
ib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Il=
ib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/ethdev=
 -I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/memp=
ool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -I=
drivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -=
I../lib/pci -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fcolor-diagnos=
tics -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc1=
1 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wforma=
t-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes =
-Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -Wst=
rict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_=
GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INT=
ERNAL_API -Wno-address-of-packed-member -DHW_CONVERT_ENDIAN -D__HINIC_HUAWE=
I_SECUREC__ -fPIC -fstack-protector-strong -MD -MQ drivers/net/hinic3/base/=
libspnic_base.a.p/hinic3_nic_cfg.c.o -MF drivers/net/hinic3/base/libspnic_b=
ase.a.p/hinic3_nic_cfg.c.o.d -o drivers/net/hinic3/base/libspnic_base.a.p/h=
inic3_nic_cfg.c.o -c ../drivers/net/hinic3/base/hinic3_nic_cfg.c
../drivers/net/hinic3/base/hinic3_nic_cfg.c:1237:34: error: expression does=
 not compute the number of elements in this array; element type is 'u16' (a=
ka 'unsigned short'), not 'u32' (aka 'unsigned int') [-Werror,-Wsizeof-arra=
y-div]
 1237 |         size =3D sizeof(indir_tbl->entry) / sizeof(u32);
      |                       ~~~~~~~~~~~~~~~~  ^
../drivers/net/hinic3/base/hinic3_nic_cfg.c:1237:34: note: place parenthese=
s around the 'sizeof(u32)' expression to silence this warning


And then lots of other overrun bugs:

*Build Failed #3:
OS: AzureLinux3.0-64
Target: x86_64-native-linuxapp-gcc
FAILED: drivers/net/hinic3/base/libspnic_base.a.p/hinic3_mbox.c.o=20
gcc -Idrivers/net/hinic3/base/libspnic_base.a.p -Idrivers/net/hinic3/base -=
I../drivers/net/hinic3/base -Idrivers/net/hinic3 -I../drivers/net/hinic3 -I=
lib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/=
include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/inc=
lude -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib=
/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib=
/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/ethdev -=
I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempoo=
l -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idr=
ivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I.=
./lib/pci -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-col=
or=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -s=
td=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat =
-Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prot=
otypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compa=
re -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno=
-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALL=
OW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-addres=
s-of-packed-member -DHW_CONVERT_ENDIAN -D__HINIC_HUAWEI_SECUREC__ -fPIC -fs=
tack-protector-strong -MD -MQ drivers/net/hinic3/base/libspnic_base.a.p/hin=
ic3_mbox.c.o -MF drivers/net/hinic3/base/libspnic_base.a.p/hinic3_mbox.c.o.=
d -o drivers/net/hinic3/base/libspnic_base.a.p/hinic3_mbox.c.o -c ../driver=
s/net/hinic3/base/hinic3_mbox.c
In file included from /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/include/immin=
trin.h:43,
                 from ../lib/eal/x86/include/rte_rtm.h:8,
                 from ../lib/eal/x86/include/rte_spinlock.h:9,
                 from ../lib/eal/x86/include/rte_rwlock.h:9,
                 from ../lib/eal/include/rte_eal_memconfig.h:10,
                 from ../lib/eal/include/rte_memory.h:21,
                 from ../lib/eal/include/rte_malloc.h:16,
                 from ../lib/ethdev/ethdev_pci.h:9,
                 from ../drivers/net/hinic3/base/hinic3_compat.h:14,
                 from ../drivers/net/hinic3/base/hinic3_mbox.c:5:
In function =E2=80=98_mm256_storeu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:128:2,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:149:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:160:2,
    inlined from =E2=80=98rte_memcpy_generic=E2=80=99 at ../lib/eal/x86/inc=
lude/rte_memcpy.h:422:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:757:10,
    inlined from =E2=80=98mbox_copy_send_data=E2=80=99 at ../drivers/net/hi=
nic3/base/hinic3_mbox.c:508:3,
    inlined from =E2=80=98send_mbox_seg=E2=80=99 at ../drivers/net/hinic3/b=
ase/hinic3_mbox.c:630:2,
    inlined from =E2=80=98send_mbox_to_func=E2=80=99 at ../drivers/net/hini=
c3/base/hinic3_mbox.c:777:9:
/usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/include/avxintrin.h:935:8: error: a=
rray subscript =E2=80=98__m256i_u[1]=E2=80=99 is partly outside array bound=
s of =E2=80=98u8[48]=E2=80=99 {aka =E2=80=98unsigned char[48]=E2=80=99} [-W=
error=3Darray-bounds=3D]
  935 |   *__P =3D __A;
      |   ~~~~~^~~~~
../drivers/net/hinic3/base/hinic3_mbox.c: In function =E2=80=98send_mbox_to=
_func=E2=80=99:
../drivers/net/hinic3/base/hinic3_mbox.c:504:12: note: at offset 32 into ob=
ject =E2=80=98mbox_max_buf=E2=80=99 of size 48
  504 |         u8 mbox_max_buf[MBOX_SEG_LEN] =3D {0};
      |            ^~~~~~~~~~~~
In function =E2=80=98_mm256_storeu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:128:2,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:148:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:161:2,
    inlined from =E2=80=98rte_memcpy_generic=E2=80=99 at ../lib/eal/x86/inc=
lude/rte_memcpy.h:422:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:757:10,
    inlined from =E2=80=98mbox_copy_send_data=E2=80=99 at ../drivers/net/hi=
nic3/base/hinic3_mbox.c:508:3,
    inlined from =E2=80=98send_mbox_seg=E2=80=99 at ../drivers/net/hinic3/b=
ase/hinic3_mbox.c:630:2,
    inlined from =E2=80=98send_mbox_to_func=E2=80=99 at ../drivers/net/hini=
c3/base/hinic3_mbox.c:777:9:
/usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/include/avxintrin.h:935:8: error: a=
rray subscript 2 is outside array bounds of =E2=80=98u8[48]=E2=80=99 {aka =
=E2=80=98unsigned char[48]=E2=80=99} [-Werror=3Darray-bounds=3D]
  935 |   *__P =3D __A;
      |   ~~~~~^~~~~
../drivers/net/hinic3/base/hinic3_mbox.c: In function =E2=80=98send_mbox_to=
_func=E2=80=99:
../drivers/net/hinic3/base/hinic3_mbox.c:504:12: note
