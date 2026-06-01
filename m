Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F75CD6E57
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:40:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DA8D4042C;
	Mon,  1 Jun 2026 17:40:47 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id F214B4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 17:40:45 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304e6c6464dso7353972eec.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780328445;
 x=1780933245; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDuqUQ6aEpsBGVR1ada9nqxeIZR8mtsgMNzG8fFikgk=;
 b=vSWfzYOuJ44yPPlHiulke6Iwsov09b69cg3LFRiFcUarXq1ufub6pFkQqt6fF3sCM+
 qK+Z/Ti3hhWtQRcsSwZDc1fb2+4BtdWZzLd5AtsPjIY04fzrMzDZ5JzLoZN8WH/tL9nU
 8RijJuLfLRxzEzCU1keRj7WuAaMW+X0qcPYvoTYowfGTwEADB07e8B1BajVKdfbhtwh/
 KelMfWWOqJ1F7zUjZwH1q+qduJMm+J4nTN/o/3McWpYNS6pRbhocl053SNstm3sHu0rV
 tPy3Joj8ogHThxgqUfUEkkIiIjdMRVSQUwQmbGePITzcjbSwCRFxGSPbE12lHMF0TgpL
 wzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780328445; x=1780933245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDuqUQ6aEpsBGVR1ada9nqxeIZR8mtsgMNzG8fFikgk=;
 b=bnTH3k9mOIouwHFj7U16jyeaBKvnI0JCBknicVjQtIAdKk9V6KuqxJ5W4Gp95WJO9p
 LuybHT8cnjfIEN4dghiS6WgrJW3C5OjfJeQnJjerztKJlfeQIvWqtXpM1wBQU7vWROwQ
 +cQP92CepKJ7fiCPBIS1qmFrWghkpRBsdwKwtdBhSWSD/obHKH6qAXaf9Mfqew+CVXok
 BtqB2NhDg9Rtq/FYOjOw7dhhpl3vgT+sPEYm53d1ZJZj3W+lPz7M6fWBGY1wi4uneT3G
 T0WZFBlCe5zEZoyxB8u4TFAAePqp0rQKrAJDP0eH6sty9AxpZmbYmlD5pxvtmZL/j6Ph
 vzIg==
X-Gm-Message-State: AOJu0YxkxWNqjeFDIP4UcSzcORX/gLYmue30Wj/VxZ7nqeecJ3355W0n
 XHjpZhIKf7XjilbHNqNTHYl+XfiAmhlUuB0KxvCmgxvAABYQPvokj/uXc32+Z7b5vfIpejIt4a2
 1+IY7
X-Gm-Gg: Acq92OGiKmS7j/8yQtbwh5k3Zbx06OaZDW2j69VTLIeUQXcpGNXSYxmJZ9QAhFIWSd4
 xiEfUsXHgor5rYEUqpGigqtCdU1A8g8cwfXW9wDxx+Rr7spoqoCq3OQHVhdINB5xLLSSGAyRWM7
 EvMfIwKCq58Y4SGuHEiDT94qjRcmQRZPgGIslSOkBv7+uOS/iqQ5i/AawHD9XFTV6GBkHfjUGKa
 e0gXFMorXiYxw5u2NGjddgJcNHkalfn1VSTsnFK1rNAGc5fcS8lHbvGd4YB8Wv/OPYQK9Kd7S+F
 svQjkBpk3zc+rmQhhU+fR5hdcrm2lwmNnExUba2dZjixqG1o0i8M0axWtTIlh2AqJkBFdHb9v4a
 DAmun1+89n6E46VJKo8NbxJjjtUyl0nULZHF8mUk+rt7yauZd3kon6ou9gwFP4HLr32yRgdCEwm
 qmoF7pcQFuaTtwVt1ICLUFrsnm0ZjOyzWMlh8yV3cgGlnsry/PplLkQekCy1fSN3xAUbtP0OwwE
 jU=
X-Received: by 2002:a05:7300:c87:b0:304:dfae:68a with SMTP id
 5a478bee46e88-304fa6fb226mr5326928eec.28.1780328444615; 
 Mon, 01 Jun 2026 08:40:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm8985694eec.25.2026.06.01.08.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:40:44 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:40:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/20]net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260601084041.3a03be28@phoenix.local>
In-Reply-To: <20260601084950.269887-1-liujie5@linkdatatechnology.com>
References: <20260601063007.230097-21-liujie5@linkdatatechnology.com>
 <20260601084950.269887-1-liujie5@linkdatatechnology.com>
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

On Mon,  1 Jun 2026 16:49:30 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set implements core functionality for the SXE PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS, DCB, PTP etc.).
>=20
> V3:
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
>  doc/guides/nics/features/sxe2.ini          |   66 +
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
>  drivers/net/sxe2/sxe2_ethdev.h             |  112 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  610 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  897 +++++++++
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
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  777 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  897 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 +
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  707 +++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   82 +
>  68 files changed, 26571 insertions(+), 124 deletions(-)
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

Thanks for fixing everything from review.

But CI builds are failing with clang

FAILED: [code=3D1] drivers/libtmp_rte_net_sxe2.a.p/net_sxe2_sxe2_filter.c.o=
=20
ccache clang -Idrivers/libtmp_rte_net_sxe2.a.p -Idrivers -I../drivers -Idri=
vers/net/sxe2 -I../drivers/net/sxe2 -Idrivers/common/sxe2 -I../drivers/comm=
on/sxe2 -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -=
I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/e=
al/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/=
eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../=
lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/tele=
metry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../li=
b/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I=
../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/p=
ci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I.=
./drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/cr=
yptodev -I../lib/cryptodev -Ilib/security -I../lib/security -Ilib/cmdline -=
I../lib/cmdline -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=3D64 =
-Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h=
 -Wvla -Wcast-qual -Wcomma -Wdeprecated -Wformat -Wformat-nonliteral -Wform=
at-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -W=
old-style-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstrict-proto=
types -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE=
 -fPIC -march=3Dcorei7 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API =
-Wno-address-of-packed-member -g -DCC_AVX512_SUPPORT -DRTE_LOG_DEFAULT_LOGT=
YPE=3Dpmd.net.sxe2 -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/lib=
tmp_rte_net_sxe2.a.p/net_sxe2_sxe2_filter.c.o -MF drivers/libtmp_rte_net_sx=
e2.a.p/net_sxe2_sxe2_filter.c.o.d -o drivers/libtmp_rte_net_sxe2.a.p/net_sx=
e2_sxe2_filter.c.o -c ../drivers/net/sxe2/sxe2_filter.c
../drivers/net/sxe2/sxe2_filter.c:401:1: error: expected statement
}
^
1 error generated.
