Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB39CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 15:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59AA402E3;
	Sat, 30 Aug 2025 17:42:53 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 2DD7940275
 for <dev@dpdk.org>; Sat, 30 Aug 2025 17:42:53 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7fac0a7d2b1so276608285a.3
 for <dev@dpdk.org>; Sat, 30 Aug 2025 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756568572;
 x=1757173372; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/T0PhtK7lx5fAvcAODnK2voV0KLjdXSVN3ACRezdU6w=;
 b=XCkkdpS1I2/0oPpY3NPy/xmazhRMgw5smmnZ/i7VsJD7063CqJ/YWWe9xcb1jROQLf
 aQWAISbtMUo9vLm4cA9b3xEAys2PxRcLMFJWw+Apa49IiCeTtWTT8PM8b+zKTU5xiSUf
 SEnzMlNBPOEylUKvH9I35xIicgj6o1pofqZ7UgajlhHI2q3hof0q85BX0U7fYf9uGzYJ
 wRuZCGBjcvONEG8MUN7hwsVK1k4IuJfAnp0eEKv3I62vjTUdVrWjJ6xYhzAycEp74PJR
 Hl+WhOEkdevci/TUEanEifHkOlIdlVkh/5u0WCM5PTcMI5TfAw5mzIPSph2GI02jCN1h
 SSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756568572; x=1757173372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T0PhtK7lx5fAvcAODnK2voV0KLjdXSVN3ACRezdU6w=;
 b=WLsfGhzYkNnWy1vVB3H8lyDM3GpZbbJofCawWSLfZ0X6/eIRbUVw/QRKnvOasODI25
 a3EVh9AvAgIw/zLiAyafwBvBxDsGNhSAd7yOUt62e+8sRsowDz0lNPgYu27yxOq3jV4E
 mlfQ3qEwcvccMa5ZvSiIOKDbXTKVXwR0vBsvZ4+ZQL+pUwxrdER2EFgBzkxTndD93hAa
 X3dfAMmo35fB0DYunmXQnebWf9ugJsrhjbWclvFHniKoUYF5QAbPtB6jwRZ7KrmvGaS3
 +Qywvfg6UUr1X6pcPnvtSOQr0ExFOsDA/5oc4hiEPRMVf48pNrqIcHtzVCXK/sNK1yvQ
 It2Q==
X-Gm-Message-State: AOJu0Yx9WcOpz1NGuSXdCBIf+vgxo8WUqL5KVtPsjxsuaYcZ8kFSygfC
 eUyYpgZHgYRz/YD6gjGkeToprDuhZIx/3sFWRTYUrV3zSvmS8nz391hMuz5fbeWKoN3roRyHsSB
 NL0b7
X-Gm-Gg: ASbGncu2I/2Rl4RTvVIR84hI14MrBzRm6NIEmo83KnAtjwuKa1k03/ahiWAG/AUsP8h
 uBsfRmQvmR0++g59G6SwDrfto24QlVxyAX9b+R/Tezh3hnKI8Ooq0dQpi3ou8PXibu92c5TMyJX
 s6TOp42HcRd0xs3XHskgIvNERNVjnlLd5hliyZOBZnNyUZeaW0vuHYp4YzwOkO49pOayD/3qpD0
 vl8djMhO8tHMBa+4CcYrLDXfR9HJw1/FH/vlGrTQhpSIn9cZOg1ZNsq8mPA+rXarW+sUJh/MYev
 4PN1KhYiABkFtwXIhWwuwXLVPmb63F57YqVJWGsVed7gqHUmRb5O1tLTPOfaYlWwg/RsWFYiAYW
 tHmcJFfCRThp1P+HhzyL17gEDzGeP9HVRf9NCSEmhUGYXbFbxbpMr13vxBOBfHsV4/P4ql6XT1s
 g=
X-Google-Smtp-Source: AGHT+IEOusLKp0EGPeLsZUXw2qa9zlbC2yRiPKhnOFYJHf6LD8Oz/iBbic6KiRCiz9hGdn1TCtexrw==
X-Received: by 2002:a05:620a:29d0:b0:7fe:b043:7dfb with SMTP id
 af79cd13be357-7ff26eaaf84mr225561285a.15.1756568572217; 
 Sat, 30 Aug 2025 08:42:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc151f2a12sm373938385a.49.2025.08.30.08.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Aug 2025 08:42:52 -0700 (PDT)
Date: Sat, 30 Aug 2025 08:42:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [V6 00/17] add-hinic3-PMD-driver
Message-ID: <20250830084249.79b85664@hermes.local>
In-Reply-To: <20250830124332.5351-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830124332.5351-1-wff_light@vip.163.com>
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

On Sat, 30 Aug 2025 20:43:04 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> *** BLURB HERE ***
>=20
> Feifei Wang (2):
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
>=20
> Xin Wang (6):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initialization
>   net/hinic3: add RSS promiscuous ops
>=20
> Yi Chen (9):
>   doc: add hinic3 driver
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add flow control and FDIR module
>   drivers/net: add hinic3 PMD build and doc files
>=20
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |   60 +
>  doc/guides/nics/hinic3.rst                 |   47 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_07.rst     |    4 +
>  drivers/net/hinic3/base/hinic3_cmd.h       |  156 +
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  971 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  144 +
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  710 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  193 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  117 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  448 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  557 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  180 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  765 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  144 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1253 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  184 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  373 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  116 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1784 +++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1529 ++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  407 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   38 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  140 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   50 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3782 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  164 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1379 +++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
>  drivers/net/hinic3/hinic3_flow.c           | 1501 ++++++++
>  drivers/net/hinic3/hinic3_flow.h           |  196 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  806 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  171 +
>  drivers/net/hinic3/hinic3_rx.c             | 1094 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  353 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1024 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  313 ++
>  drivers/net/hinic3/meson.build             |   31 +
>  drivers/net/meson.build                    |    1 +
>  46 files changed, 22503 insertions(+), 1 deletion(-)
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

Build fails, please fix and resubmit

*Build Failed #1:
OS: RHEL96-64
Target: x86_64-native-linuxapp-clang
FAILED: drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_rx.c.o=20
clang -Idrivers/libtmp_rte_net_hinic3.a.p -Idrivers -I../drivers -Idrivers/=
net/hinic3 -I../drivers/net/hinic3 -Idrivers/net/hinic3/base -I../drivers/n=
et/hinic3/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/c=
ommon -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include =
-Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I=
../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvarg=
s -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Il=
ib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/=
mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I=
../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/li=
nux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/h=
ash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-color=3Dalways -D_FI=
LE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -inc=
lude rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliter=
al -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-e=
xterns -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-proto=
types -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE=
 -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API =
-Wno-format-truncation -Wno-address-of-packed-member -DHW_CONVERT_ENDIAN -D=
RTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.hinic3 -DRTE_ANNOTATE_LOCKS -Wthread-safe=
ty -MD -MQ drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_rx.c.o -MF d=
rivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_rx.c.o.d -o drivers/libt=
mp_rte_net_hinic3.a.p/net_hinic3_hinic3_rx.c.o -c ../drivers/net/hinic3/hin=
ic3_rx.c
../drivers/net/hinic3/hinic3_rx.c:75:1: error: unused function 'hinic3_upda=
te_rq_hw_pi' [-Werror,-Wunused-function]
   75 | hinic3_update_rq_hw_pi(struct hinic3_rxq *rxq, uint16_t pi)
      | ^~~~~~~~~~~~~
