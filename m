Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E9C021A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D07D402DA;
	Tue, 11 Feb 2025 17:34:29 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 3A8BA402C9
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:34:27 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fa3fe04dd2so5374096a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291666;
 x=1739896466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qaBlQx/pNSkK772VzKWaacJ5xouh8oZ5qUAnP92Ssc=;
 b=CdDmDQ0HLtqgvP3Dl0TRUjNAlQqH0QSK4kb85ybh7lwWXgihbLM+Wt99Hv3n+BJ664
 dQEa9Yla81bfVePWpyVISyqLI0YcbiOXdZ4VUlWUrtBf03BTxv1XJ6UrBG98kfkUXUCv
 vZ/XcVKul+t4yWPDdbRlQMtYxbyATaSwed5HGByC/eFcbwwhgcA0/WX8Ta+o9JKQVykJ
 czVkfX5OZQbpZDTJFaMWv9+FMbvsY00QX3oCIiREgVNJfumz6yoL7cw9zGLB2o/Er2pw
 zm/CUgpzh8mPnCmH32CkHYUkJ7OvGJTONIxzGXcWO5P/zCSgP9Vbt5Q3B4e3oDXBel9+
 3X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291666; x=1739896466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qaBlQx/pNSkK772VzKWaacJ5xouh8oZ5qUAnP92Ssc=;
 b=D63KejUIHyaLjJEvQAPbypP5VRaGMdBJqT/yYShK0PdVa3nMZ/O9eNCBx9tP/WfV3o
 lAi16UMFxNHEKuHChHSR0sHye42i72aQtBoebxPEPQweGNBw+A28uh2Hp8QEZ0q9qCv0
 ucHwX7c5nlAiydUqggQevwXqHdfW9wFc82+U6NYJXPtZsVVqYMS1/F0TFE15xZKDe6pv
 Q5vb/BnBxcOFoK/PJRmWKDW6BHmLo+aD87EcDoGqbp5OZQJ7DAIdYBECc8x5AO81V0sU
 QC1s7OucUT1bhmHHOFQfKqElyaDZ/1Wr9D6s1YhnqObHkv9aM0M0+7KOaJpvnGL3Ywhd
 HvmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9csLQHWzLKxQRdDripA7BZRHOnexMjfibhC74AvPqdjGJ0zmjkP/dLzwOVhCdw7WNXck=@dpdk.org
X-Gm-Message-State: AOJu0Yzi26km0DSpiPf19VX5sqAbU+Z7nanMXNDNv2D63N2h/Ku7PEZT
 CqiBIyb3vhiJfs201Fcm3RHv4aCbo8d5u/PBKc808ePWbB8xudklHh7j8EBinqU=
X-Gm-Gg: ASbGncu/v+14pJRCsM+3E4J2kI2KSoWrH7oXnX3VULxW5oZO5my7jW76obj/5PLuHaG
 IwO6A1WAKB36lpTVzV1cQihBu9UfJ8IY0SxWoucSDgjo8PVZsMg8r6LbAPMblX+Dz8eX+uQh+Qc
 4isa7KLpaBYHSePH1vjaRtrdaWOGPCKM8o/lPLjRAPXQ5RRjctgwKDXDe70c4nbIanvMTz8S5Va
 pjp5eQM7b6p9hPtO7gztK1ITsb+YFUmGR0GhgS+DqPJnH8zcmqhmXAaSfSUlZfnpXQf6LikNCQJ
 1jfE+SyovKHfiq3wR3sMnlEXcBAXX7OVLXH5ZsLpNi3hOoZayuD9LhMQCMiOioECMAyM
X-Google-Smtp-Source: AGHT+IGoO/CZQ3JokNYsXOcpIDBgUpR123tMi9gV1RYGi7LqwgvoMUn+TZvWHlptrzL70roNRmgl6g==
X-Received: by 2002:a17:90b:368c:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2fa2406434fmr26983459a91.11.1739291666026; 
 Tue, 11 Feb 2025 08:34:26 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa135a3762sm10505448a91.19.2025.02.11.08.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:34:25 -0800 (PST)
Date: Tue, 11 Feb 2025 08:34:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v10 00/28] [v10]drivers/net Add Support mucse N10 Pmd
 Driver
Message-ID: <20250211083423.48a1d3ab@hermes.local>
In-Reply-To: <1739286398-61972-1-git-send-email-caowenbo@mucse.com>
References: <1739286398-61972-1-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 23:06:10 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso=20
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
>=20
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.
>=20
> v10:
>   * fixed mingw windows meson issue
>   * rnp not support windows for now.
>   * change ffs use osdep rte_fls_u32
>=20
> v9:
>   * fixed commit log format check by devtools.
>   * fixed code compile issue.
>=20
> v8:
>   * fixed codespell issue.
>   * fixed MAINTAINERS file
>=20
> v7:
>   * add support nic basic feature such as rss vlan strip/filter,
>   * mtu-change recv/send scater-recv/mutltiple-send.
>   * fixed code rationality, advised by Ferruh Yigit.
> v6:
>   * fixed the doc(rst) format problem advise by Thomas Monjalon
>=20
> v5:
>   * fixed the symbol name require by the style documentation
>=20
> v4:
>   * one patch has been forgot to upload :(
>=20
> v3:
>   * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
>   * change iobar type to void suggest by Stephen Hemminger
>   * add KMOD_DEP support for vfio-pci
>   * change run-cmd argument parse check for invalid extra_args
>=20
> v2:
>   * fixed MAINTAIN maillist fullname format
>   * fixed driver/net/meson the order issue of new driver to driver list
>   * improve virtual point function usage suggest by Stephen Hemminger
>=20
> Wenbo Cao (28):
>   net/rnp: add skeleton
>   net/rnp: add ethdev probe and remove
>   net/rnp: add log
>   net/rnp: support mailbox basic operate
>   net/rnp: add device init and uninit
>   net/rnp: add get device information operation
>   net/rnp: add support MAC promisc mode
>   net/rnp: add queue setup and release operations
>   net/rnp: add queue stop and start operations
>   net/rnp: add support device start stop operations
>   net/rnp: add RSS support operations
>   net/rnp: add support link update operations
>   net/rnp: add support link setup operations
>   net/rnp: add Rx burst simple support
>   net/rnp: add Tx burst simple support
>   net/rnp: add MTU set operation
>   net/rnp: add Rx scatter segment version
>   net/rnp: add Tx multiple segment version
>   net/rnp: add support basic stats operation
>   net/rnp: add support xstats operation
>   net/rnp: add unicast MAC filter operation
>   net/rnp: add supported packet types
>   net/rnp: add support Rx checksum offload
>   net/rnp: add support Tx TSO offload
>   net/rnp: support VLAN offloads
>   net/rnp: add support VLAN filters operations
>   net/rnp: add queue info operation
>   net/rnp: support Rx/Tx burst mode info
>=20
>  .mailmap                            |    1 +
>  MAINTAINERS                         |    6 +
>  doc/guides/nics/features/rnp.ini    |   33 +
>  doc/guides/nics/index.rst           |    1 +
>  doc/guides/nics/rnp.rst             |  101 ++
>  drivers/net/meson.build             |    1 +
>  drivers/net/rnp/base/meson.build    |   28 +
>  drivers/net/rnp/base/rnp_bdq_if.c   |  398 ++++++
>  drivers/net/rnp/base/rnp_bdq_if.h   |  154 +++
>  drivers/net/rnp/base/rnp_bitrev.h   |   64 +
>  drivers/net/rnp/base/rnp_common.c   |  103 ++
>  drivers/net/rnp/base/rnp_common.h   |   17 +
>  drivers/net/rnp/base/rnp_crc32.c    |   37 +
>  drivers/net/rnp/base/rnp_crc32.h    |   10 +
>  drivers/net/rnp/base/rnp_dma_regs.h |   68 +
>  drivers/net/rnp/base/rnp_eth_regs.h |   90 ++
>  drivers/net/rnp/base/rnp_fw_cmd.c   |  162 +++
>  drivers/net/rnp/base/rnp_fw_cmd.h   |  358 ++++++
>  drivers/net/rnp/base/rnp_hw.h       |  136 ++
>  drivers/net/rnp/base/rnp_mac.c      |  366 ++++++
>  drivers/net/rnp/base/rnp_mac.h      |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
>  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
>  drivers/net/rnp/base/rnp_mbx.h      |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
>  drivers/net/rnp/base/rnp_osdep.h    |  175 +++
>  drivers/net/rnp/meson.build         |   27 +
>  drivers/net/rnp/rnp.h               |  258 ++++
>  drivers/net/rnp/rnp_ethdev.c        | 1845 +++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_link.c          |  439 +++++++
>  drivers/net/rnp/rnp_link.h          |   38 +
>  drivers/net/rnp/rnp_logs.h          |   36 +
>  drivers/net/rnp/rnp_rss.c           |  367 ++++++
>  drivers/net/rnp/rnp_rss.h           |   43 +
>  drivers/net/rnp/rnp_rxtx.c          | 1820 ++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_rxtx.h          |  162 +++
>  37 files changed, 8678 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/rnp.rst
>  create mode 100644 drivers/net/rnp/base/meson.build
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h
>  create mode 100644 drivers/net/rnp/base/rnp_bitrev.h
>  create mode 100644 drivers/net/rnp/base/rnp_common.c
>  create mode 100644 drivers/net/rnp/base/rnp_common.h
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.c
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.h
>  create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h
>  create mode 100644 drivers/net/rnp/base/rnp_hw.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac.c
>  create mode 100644 drivers/net/rnp/base/rnp_mac.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h
>  create mode 100644 drivers/net/rnp/base/rnp_osdep.h
>  create mode 100644 drivers/net/rnp/meson.build
>  create mode 100644 drivers/net/rnp/rnp.h
>  create mode 100644 drivers/net/rnp/rnp_ethdev.c
>  create mode 100644 drivers/net/rnp/rnp_link.c
>  create mode 100644 drivers/net/rnp/rnp_link.h
>  create mode 100644 drivers/net/rnp/rnp_logs.h
>  create mode 100644 drivers/net/rnp/rnp_rss.c
>  create mode 100644 drivers/net/rnp/rnp_rss.h
>  create mode 100644 drivers/net/rnp/rnp_rxtx.c
>  create mode 100644 drivers/net/rnp/rnp_rxtx.h
>=20


Also the script devtools/test-meson-builds.sh that runs through
different build options, eventually fails at:


  User defined options
    buildtype             : debugoptimized
    check_includes        : true
    cpu_instruction_set   : nehalem
    default_library       : shared
    enable_deprecated_libs: *
    examples              : all
    libdir                : lib
    werror                : true

Found ninja-1.12.1 at /usr/bin/ninja
ninja: Entering directory `./build-x86-generic'                            =
                                                                           =
                                             =20
[1751/6916] Compiling C object drivers/libtmp_rte_net_rnp.a.p/net_rnp_rnp_e=
thdev.c.o
FAILED: drivers/libtmp_rte_net_rnp.a.p/net_rnp_rnp_ethdev.c.o=20
cc -Idrivers/libtmp_rte_net_rnp.a.p -Idrivers -I../drivers -Idrivers/net/rn=
p -I../drivers/net/rnp -Idrivers/net/rnp/base -I../drivers/net/rnp/base -Il=
ib/ethdev -I../lib/ethdev -I. -I.. -Iconfig -I../config -Ilib/eal/include -=
I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ili=
b/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal/comm=
on -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs =
-Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../=
lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool=
 -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idri=
vers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I..=
/lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -I/usr/include/x86_64-lin=
ux-gnu -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvali=
d-pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-=
qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-=
declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -=
Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -=
Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC =
-march=3Dnehalem -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-f=
ormat-truncation -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3D=
pmd.net.rnp -MD -MQ drivers/libtmp_rte_net_rnp.a.p/net_rnp_rnp_ethdev.c.o -=
MF drivers/libtmp_rte_net_rnp.a.p/net_rnp_rnp_ethdev.c.o.d -o drivers/libtm=
p_rte_net_rnp.a.p/net_rnp_rnp_ethdev.c.o -c ../drivers/net/rnp/rnp_ethdev.c
In file included from ../lib/eal/x86/include/rte_atomic.h:11,
                 from ../lib/eal/include/generic/rte_pause.h:19,
                 from ../lib/eal/x86/include/rte_pause.h:8,
                 from ../lib/eal/include/generic/rte_rwlock.h:31,
                 from ../lib/eal/x86/include/rte_rwlock.h:8,
                 from ../lib/eal/include/rte_eal_memconfig.h:10,
                 from ../lib/eal/include/rte_memory.h:21,
                 from ../lib/eal/include/rte_malloc.h:16,
                 from ../lib/ethdev/ethdev_pci.h:9,
                 from ../drivers/net/rnp/rnp_ethdev.c:5:
In function =E2=80=98_mm_loadu_si128=E2=80=99,
    inlined from =E2=80=98rte_mov16=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:113:9,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:131:2,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:149:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:161:2,
    inlined from =E2=80=98rte_memcpy_generic=E2=80=99 at ../lib/eal/x86/inc=
lude/rte_memcpy.h:615:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:757:10,
    inlined from =E2=80=98rnp_mbx_fw_reply_handler=E2=80=99 at ../drivers/n=
et/rnp/rnp_ethdev.c:75:3,
    inlined from =E2=80=98rnp_process_fw_msg=E2=80=99 at ../drivers/net/rnp=
/rnp_ethdev.c:113:4,
    inlined from =E2=80=98rnp_dev_interrupt_handler=E2=80=99 at ../drivers/=
net/rnp/rnp_ethdev.c:130:2,
    inlined from =E2=80=98rnp_dev_interrupt_handler=E2=80=99 at ../drivers/=
net/rnp/rnp_ethdev.c:123:13:
/usr/lib/gcc/x86_64-linux-gnu/14/include/emmintrin.h:706:10: error: array s=
ubscript 16 is outside array bounds of =E2=80=98uint32_t[64]=E2=80=99 {aka =
=E2=80=98unsigned int[64]=E2=80=99} [-Werror=3Darray-bounds=3D]
  706 |   return *__P;
      |          ^~~~
../drivers/net/rnp/rnp_ethdev.c: In function =E2=80=98rnp_dev_interrupt_han=
dler=E2=80=99:
../drivers/net/rnp/rnp_ethdev.c:103:18: note: at offset 256 into object =E2=
=80=98msgbuf=E2=80=99 of size 256
  103 |         uint32_t msgbuf[64];
      |                  ^~~~~~
cc1: all warnings being treated as errors
[1772/6916] Compiling C object lib/librte_pipeline.a.p/pipeline_rte_table_a=
ction.c.o
ninja: build stopped: subcommand failed.
