Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9B6ECD9B7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CCED4028E;
	Fri,  6 Feb 2026 02:49:10 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id AF6E640264
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:49:08 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso16236515e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770342548;
 x=1770947348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVtGFJQlVjFjGP4cZC8ko0v5tNYJm9kRc3Uj8r0JhYY=;
 b=rAaMyZ0OONsIi4aYJXcNWSjzfj3Kxvuag6uwSbWTjts2svt5ldr0uXSSvNUCFBtLRC
 cbiTWLZgWmi4nW+Cj8IJYPmnUGh36MXPXYGDU7rec2ucF65KkA9IBHmXkss838gyCeVW
 zLCzSfEXmr9WEa3GA8L8TWjAnHPB4j2Vj94orugtrE5dz/XTuAkZGlKx6976UYbVaW5m
 bNNQhlyQxYXx833Ju+6+LwVW0RSAMYBPfdhSI7ujmpJc6KgQMUA6ecjwP/ImQVdcGYNd
 2Cvt46uAHGdVMRD29WKoJi4LFCVx/Aj16dTKLJZAVYqWMpapl6E8uFXlnKym+Bug0sTX
 cBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342548; x=1770947348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vVtGFJQlVjFjGP4cZC8ko0v5tNYJm9kRc3Uj8r0JhYY=;
 b=ccayS3eqZHbeDo18RqyKYr5ZSmyqAn1VN3qcc82A64Ephg/sp4x82QJUO2I6Ddk/N8
 POJn528TkAkpzODQ5bP8rOY8y1ZhsE3q5d9zUlLuEvO7EHIlveKraN6LLAjo6iV44pmZ
 IFzRP52ddjybfARkQpSFrVC6KBDYKkbnwIqrHpLWSRu04c5ozY15c6/P+Q8qix8bDIUp
 1NkuVP0Lb5V2WHqJz255btUiyn1i8ThaSoxgj6CcdjEK2Ct0ajM9LWf0uJeTr0h4XJ6M
 BP0bCKSyqEvKs4/zePuQNA2pkqwCB1Ckp6UFTuidBw8AtHy6cmaLmhIDnEEMvP1HzG1B
 zT6g==
X-Gm-Message-State: AOJu0YwwM4dff4vOJse447abeAqtayA33JOc0vx42ERjgIsp8IN3mVhm
 IWBjfoxnqKREk4VwOFBMIhq0aPVFYdRfyLb5U16mwYQkvDi6n4d0I9/n2UW5Y7SLu3k=
X-Gm-Gg: AZuq6aLVjGDlzdpqB+6W+bple/H2zQHmLiyU0/qvLGNPbl4ZCgZdpxIFOLKiWhBSKG3
 953llN28fImN1aDLvTaMS9kA42qy0Ve1FEJa69KcT2JeO9ks/TVp3o6/sdGVBlu1QGpBEe1PYYL
 3woP2NRkyocdsl/f3GK5IrjCQIXo4NDVIcaAICC7pMFvCf+owmxBnXv6rsVyWmG9D76jXEcpzVR
 2+VssBIf4nS2qlZB11fO8hrYLyEqK/HJdemYsAnAT7KbzeaI5gyjEYv+2kefHGFsJ5N+Hh4WQ7K
 jZoExPUll1nRwef7yx0fyI2J4ycuGDeAsah+hQLNli1vO0Z4u/Hh247qbzxYEiBwuhZbO6Kod+h
 gAEcf+gX6CYN/yrj12G2KDCpb0dprdOgzJSGU/EzB2rPfVhrvXBn4oqI44KA+jcknNKHu4SD54G
 nxGqWPY5P0B9cCyzWmDKL4HjOjt/IN25I2P8ApHmoCb1l1K3nX8wkV
X-Received: by 2002:a05:600c:3582:b0:480:3230:6c89 with SMTP id
 5b1f17b1804b1-48320933594mr11749005e9.12.1770342547972; 
 Thu, 05 Feb 2026 17:49:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206b8ebbsm27202545e9.1.2026.02.05.17.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 17:49:07 -0800 (PST)
Date: Thu, 5 Feb 2026 17:49:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/4] af_packet correctness, performance, cksum
Message-ID: <20260205174901.462eddb1@phoenix.local>
In-Reply-To: <20260206011141.2377-1-scott.k.mitch1@gmail.com>
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
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

On Thu,  5 Feb 2026 17:11:37 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott <scott.k.mitch1@gmail.com>
>=20
> This series fixes critical thread safety bugs in the af_packet PMD
> and adds performance optimizations.
>=20
> Patch 1 fixes two major correctness issues:
> - Thread safety: tp_status was accessed without memory barriers,
>   violating the kernel's PACKET_MMAP protocol. On aarch64 and other
>   weakly-ordered architectures, this causes packet corruption due to
>   missing memory ordering. The fix matches the kernel's memory model:
>   volatile unaligned reads/writes with explicit rte_smp_rmb/wmb
>   barriers and __may_alias__ protection.
>=20
> - Frame calculations: Fixed incorrect frame overhead and address
>   calculations that caused memory corruption when frames don't evenly
>   divide blocks.
>=20
> Patches 2-4 add performance improvements:
> - Patch 2: Bulk mbuf freeing, unlikely annotations
> - Patch 3: TX poll control to reduce syscall overhead
> - Patch 4: Software checksum offload support with shared rte_net
>   utility
>=20
> v6 changes:
> - rte_net_ip_udptcp_cksum_mbuf doxygen EXPERIMENTAL tag
>=20
> v5 changes:
> - rte_net_ip_udptcp_cksum_mbuf moved to rte_net.c (avoid forced inline)
> - rte_net_ip_udptcp_cksum_mbuf remove copy arg, handle more mbuf types
> - af_packet and tap calling code consistent for sw cksum
>=20
> v4 changes:
> - Remove prefetch (perf results didn't show benefit)
> - Fix variable sytle for consistency (declare at start of method)
> - Add release notes for af_packet and documentation for fixes
>=20
> v3 changes:
> - Patch 4: Fix compile error due to implict cast with c++ compiler
>=20
> v2 changes:
> - Patch 1: Rewrote to use volatile + barriers instead of C11 atomics
>   to match kernel's memory model. Added dependency on patch-160274
>   for __rte_may_alias attribute.
> - Patch 4: Refactored to use shared rte_net_ip_udptcp_cksum_mbuf()
>   utility function, eliminating code duplication with tap driver.
>=20
> Scott Mitchell (4):
>   net/af_packet: fix thread safety and frame calculations
>   net/af_packet: RX/TX bulk free, unlikely hint
>   net/af_packet: tx poll control
>   net/af_packet: add software checksum offload support
>=20
>  doc/guides/nics/af_packet.rst             |   6 +-
>  doc/guides/nics/features/afpacket.ini     |   2 +
>  doc/guides/rel_notes/release_26_03.rst    |   9 +-
>  drivers/net/af_packet/rte_eth_af_packet.c | 253 +++++++++++++++-------
>  drivers/net/tap/rte_eth_tap.c             |  70 +-----
>  lib/net/rte_net.c                         |  69 ++++++
>  lib/net/rte_net.h                         |  25 +++
>  7 files changed, 292 insertions(+), 142 deletions(-)
>=20

Why are the header structures marked packed, that is bogus, BSD and Linux d=
on't do it.
Windows probably does but Windows code seems to love packed even when it is=
 not necessary.


This is failing compile on FreeBsd

OS: FreeBSD14-64
Target: x86_64-native-bsdapp-gcc
FAILED: lib/librte_net.a.p/net_rte_net.c.o=20
gcc -Ilib/librte_net.a.p -Ilib -I../lib -Ilib/net -I../lib/net -Ilib/eal/co=
mmon -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I=
../lib/eal/include -Ilib/eal/freebsd/include -I../lib/eal/freebsd/include -=
Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -Ilib/=
kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metric=
s -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib=
/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring=
 -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch =
-Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wde=
precated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarati=
ons -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-=
arith -Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -=
Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -D__BS=
D_VISIBLE -fPIC -march=3Dnative -mno-avx512f -mrtm -DALLOW_EXPERIMENTAL_API=
 -DALLOW_INTERNAL_API -mpclmul -maes -DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.net -M=
D -MQ lib/librte_net.a.p/net_rte_net.c.o -MF lib/librte_net.a.p/net_rte_net=
.c.o.d -o lib/librte_net.a.p/net_rte_net.c.o -c ../lib/net/rte_net.c
../lib/net/rte_net.c: In function 'rte_net_ip_udptcp_cksum_mbuf':
../lib/net/rte_net.c:672:50: error: taking address of packed member of 'str=
uct rte_udp_hdr' may result in an unaligned pointer value [-Werror=3Daddres=
s-of-packed-member]
  672 |                 l4_cksum =3D (unaligned_uint16_t *)&rte_pktmbuf_mto=
d_offset(mbuf,
      |                                                  ^~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
  673 |                                 struct rte_udp_hdr *, l4_offset)->d=
gram_cksum;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
../lib/net/rte_net.c:675:50: error: taking address of packed member of 'str=
uct rte_tcp_hdr' may result in an unaligned pointer value [-Werror=3Daddres=
s-of-packed-member]
  675 |                 l4_cksum =3D (unaligned_uint16_t *)&rte_pktmbuf_mto=
d_offset(mbuf,
      |                                                  ^~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
  676 |                                 struct rte_tcp_hdr *, l4_offset)->c=
ksum;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
cc1: all warnings being treated as errors
