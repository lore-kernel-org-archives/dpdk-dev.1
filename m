Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F6C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 19:59:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B61940279;
	Wed,  1 Jul 2026 21:59:34 +0200 (CEST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49]) by mails.dpdk.org (Postfix) with ESMTP id C677740264
 for <dev@dpdk.org>; Wed,  1 Jul 2026 21:59:32 +0200 (CEST)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5aea9d606f0so947414e87.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 12:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935972; cv=none;
 d=google.com; s=arc-20260327;
 b=pgF+heiTqEddk2tXsvag3NTZUqzDcnnilhsGvn636EpTGgTVaoFytVT3Q5O7MUqZBW
 UWAXWq+MaBw4mLrzo9JeOLD+FhBWJ/8B9ObL1zyRpYgXglNXCn2CEVL+ff8CGXaTJxJl
 VAA8kZdnLI27lA7iByQEnWgDn+voeRYAnQcvFEAw1rd1UtMGtIGDMNjb8W/oWy1THkqU
 +ZPsyW56kdESDh5VIoZ5bm6JuNMw5lV+g/C1WncroTbZWEEWcCxRw70mI4i5nc4WaYm7
 F+LrjbRQDkqGu1KTD4/hexiW0t8AreQWpWyBhZhmuz3lUEyUNieLD8Xh9AixqkUxK5XS
 sA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nR2+28Y86IV8egrrlvic4WUsizT+K6iSnZTvBUx6330=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=reM9P7IKyDfvzEJuh8kPfYuXPG862A72TNZdJav68Wfg7oXHFlNJBLUrFrvSw6gXfz
 2YCpXknzSZbq0CSzO5VM2zZkMJUCiA6PChP6865fmNsS/6Jts6gJuYwNT448c5tuCr7Z
 N0tVCid1xglf1e68cbx0nLcyfNOdWuPgFD2Sient1Lx8YAwt6zGl3U20TblZ9Q1+8AL4
 IAWMXU73GFhBZazTIwJPCYpJCKJcbmdtqMgSsPo1MPSzD90X9O4JcujXLMUrqGQvV/sl
 nuH4rUsJ8K2JMIns2pLKQnoi+hnHFirHzEYsgTKk0Y4gP+vXw0Sk5ZTFCMuZw8Y6YZ4W
 enKA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782935972; x=1783540772; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nR2+28Y86IV8egrrlvic4WUsizT+K6iSnZTvBUx6330=;
 b=gi57wrppul/1heIymUedXVUJESgvburcW6tjCez2StBCtN8Ek3XMb+JDM3JOqZUgnM
 X5xD6bOagHuL0yIjcyCDchJ4uol/d1swRzeUxzCCJRvSBHDTkWlJvwYPRBrJARy2ici0
 h+RT0i0bp5XZzsjHFPIDWgJiA7p0laCCCIEAaWubXQ6y+kV718L/CC6FS+SWN0JrgEdz
 NSpJIiUAXMU8SJh4R7GifnkHr7vNdW5ad7fRV0OS03bFGhkdsRAxcwhruXEQx6CHtw6C
 dohyGgaUBXdmSDIdyX+ayOH3f28LhVLbCepfxJGVHyBqjsl4JVaSHTtPqrpzy2S2JFit
 PjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782935972; x=1783540772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nR2+28Y86IV8egrrlvic4WUsizT+K6iSnZTvBUx6330=;
 b=KMDPNfNbN9FCzaJUGMto5zVzqxXNeRNQP7IjL5y16gsyIxFWF51ANxKS8PXGeemK0C
 JhrYJSpxH0tqQJ9HzWHdoaKFbi+wLla6i+A0vhwzvpQcKglmktaLIQVU1aq3v8nyFnQN
 fUp8TZz7rrJlABaIojmyQkugpDBUT7j9BpLgDBOpYXZTEdd/PLMZAYULH5C0FdjI8Elj
 xBTVAJ+E5prQghnVw01zmSFmC33iyxQbZ7Fz4pqrMuw0SdS/lrgiMbttM95wxQWsZYwI
 DlRXLrvziOrEeHX0yOvw4xw9FQ+LGgdaF5o/RyUgo8729PiOHsJZmAmETRqQK4hGe9NJ
 vLVA==
X-Gm-Message-State: AOJu0YwVNIHy/JaDym39cemQJ7PKRakOVuRr2aSDin2ugTvz4+cF3m9G
 vvGWTkH1EW/qaiaTBUhUS4pwsLglwzIU04mp3599E6G7RaRNPsvhGOQP2jygVXwbBAxeYMi+0jM
 P3ovt93cjI5bY9sDrAilEpd8OPFnpON7G4In3eORNhjE1yv2MA3Ss/yjS
X-Gm-Gg: AfdE7cn7FefAc4uGNwiYkI7Vx9lFxeCC787nmG2xMTePAZPp86wl2y7ePz7/qaa9yxM
 q9Ddjdgd7QUkfYa47mArLv/I7pn0cFBYHaRuDSP8TtlQSyZD1ml6pIcWyYPbXFDivCjz0rF9p8D
 kmwkjfq+dI+gMqbZtt0qLoPIS6PlNGqqTLWdHcB3fJihqF91wcDVBdGmVuLs+izRJK4YnPXsw4B
 xmXLbHOG34KY5QH71MT3j0Fcs7rQlabQBi8A8HyUhgWbMAFN/iiKXK7vz7WWVDxWTE145FwmPZ/
 Ji/633ynwVnH7d3pzclqfegSu3c=
X-Received: by 2002:a05:6512:22c8:b0:5ae:bdaa:df02 with SMTP id
 2adb3069b0e04-5aec68b82a1mr638929e87.45.1782935971611; Wed, 01 Jul 2026
 12:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
 <20260701115016.39c34f53@phoenix.local>
In-Reply-To: <20260701115016.39c34f53@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Wed, 1 Jul 2026 12:59:18 -0700
X-Gm-Features: AVVi8CeLuddgKljPWTs6ymTtl1UItHz5ShDcq6wC5eVXhyvJIukE8nL-75W07f0
Message-ID: <CALuQH+XNRfWpd1zXm9GOe08h3z7DHb=FdV5jOnqGFP4Y5E8q=Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] Stability fixes for GVE
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jul 1, 2026 at 11:50=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed,  1 Jul 2026 11:35:18 -0700
> Joshua Washington <joshwash@google.com> wrote:
>
> > This patch series consists of mostly unrelated fixes in the GVE driver.
> >
> > Joshua Washington (9):
> >   net/gve: clear out shared memory region for stats report
> >   net/gve: delay adding mbuf head to software ring
> >   net/gve: copy data to QPL buffer when mbuf read does not
> >   net/gve: validate buf ID before processing Rx packet
> >   net/gve: set mbuf to null in software ring after use
> >   net/gve: free ctx mbuf if packet dropped after first segment
> >   net/gve: increase range of DMA memzone ids to 64 bits
> >   net/gve: don't reset ring size bounds to default on reset
> >   net/gve: restrict max ring size in GQ QPL to 2K
> >
> >  drivers/net/gve/base/gve_adminq.c | 12 ++++++---
> >  drivers/net/gve/base/gve_osdep.h  |  4 +--
> >  drivers/net/gve/gve_ethdev.c      |  8 +++---
> >  drivers/net/gve/gve_ethdev.h      |  1 +
> >  drivers/net/gve/gve_rx.c          |  3 +++
> >  drivers/net/gve/gve_rx_dqo.c      |  6 +++++
> >  drivers/net/gve/gve_tx.c          | 42 +++++++++++++++++++------------
> >  7 files changed, 52 insertions(+), 24 deletions(-)
> >
>
> *Build Failed #1:
> OS: OpenAnolis8.10-64
> Target: x86_64-native-linuxapp-gcc
> FAILED: drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o
> gcc -Idrivers/libtmp_rte_net_gve.a.p -Idrivers -I../drivers -Idrivers/net=
/gve -I../drivers/net/gve -I../drivers/net/gve/base -Ilib/ethdev -I../lib/e=
thdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -I=
lib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/l=
inux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/lin=
ux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/l=
og -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/=
argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf =
-Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../li=
b/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -=
Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -fdiagnostic=
s-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werr=
or -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wfo=
rmat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing=
-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshado=
w -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-no=
t-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dnati=
ve -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncati=
on -Wno-vla -DRTE_COMPONENT_CLASS=3Dpmd_net -DRTE_COMPONENT_NAME=3Dgve -DRT=
E_LOG_DEFAULT_LOGTYPE=3Dpmd.net.gve -MD -MQ drivers/libtmp_rte_net_gve.a.p/=
net_gve_gve_tx.c.o -MF drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o.d =
-o drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o -c ../drivers/net/gve/=
gve_tx.c
> ../drivers/net/gve/gve_tx.c: In function =E2=80=98gve_tx_burst_qpl=E2=80=
=99:
> ../drivers/net/gve/gve_tx.c:258:21: error: variable =E2=80=98addr=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>   uint64_t ol_flags, addr, fifo_addr;
>                      ^~~~
> cc1: all warnings being treated as errors
> [1640/3750] Compiling C object drivers/libtmp_rte_net_gve.a.p/net_gve_gve=
_rx.c.o
> [1641/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_base_hinic_pmd_cfg.c.o
> [1642/3750] Compiling C object drivers/libtmp_rte_net_failsafe.a.p/net_fa=
ilsafe_failsafe_ops.c.o
> [1643/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_base_hinic_pmd_api_cmd.c.o
> [1644/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_base_hinic_pmd_cmdq.c.o
> [1645/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_hinic_pmd_rx.c.o
> [1646/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_hinic_pmd_flow.c.o
> [1647/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_hinic_pmd_ethdev.c.o
> [1648/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic=
_hinic_pmd_tx.c.o
> ninja: build stopped

Will fix in v2.
