Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA360C369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 17:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4B1D40156;
	Sat, 26 Apr 2025 19:07:29 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 01C67400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 19:07:27 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2264aefc45dso52329515ad.0
 for <dev@dpdk.org>; Sat, 26 Apr 2025 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745687247;
 x=1746292047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF3VeyGfzjAG0b2iufiV1bArMNj49nSViet8you6Mt8=;
 b=Zi170eZORmO8vwcMFXjlnFIxWunYSzSyjV3KB8CauR9LLCsOaC+bwnHXGlAs1LUywV
 bmL++j8oZzWuiWi7ZIIwiK2bnJUrXcfbXDrzBAGx+3wpcJpBg7EhW6l1eRuF+BCiQJoM
 Xpn4UtxABXn/onBLQS9mVlIqjQfWp8G3QPrrWieaxnoPZVqLdrR5JMH4YsMO5HURjbpE
 6GxWEXoLDhErwMz6P6G+k1VGrK7BpgCHjReVeNNlb0hZ2oDNv2hpU8YRb0SF0MKuZa/Y
 t36kYdLL42mAkBMfz3zIVfq9WcDRZgygOTgcMIU5zHB7TlWT7rVYBnfrEVfnhaU9oyHs
 APVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745687247; x=1746292047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jF3VeyGfzjAG0b2iufiV1bArMNj49nSViet8you6Mt8=;
 b=RIO6uOkbg1lAMLAwxPGj77j+sALNysi/+xWgV7hWfItWCm8CKPo3dJcNTjK86sJRKx
 JWEp3pq92lh53eQTtHKejDDM0A68TJK5aFTLZc/jWU3lidX3i68KPJq8lofqvY0tVlj6
 i+b4+KAUmp2XjRyut98Y4deckYtFzLmrs1gczwW8bac4i+rHWgW6I7EiHJSy3TPoJZnY
 fEtj+9cLQMllupW5XlQ/JQJSRNa4lLmJtYEuH6MC2ygMfA5XUJj5kEZlAJToAvukWMhY
 HsRd8cjVPHnyo7Ii7QjVjIxJGYt0PlYBUgqssmarHLefUOo532o5L+kWiaKZqrFv8qoS
 5v7A==
X-Gm-Message-State: AOJu0YwiO3MsT96IaBSOR2Xi8s09imXwsJKOIth47kR9t7vCyGkPSlWG
 81FOAhEMtXW9t9w9t/bx5+Yj6xZqtewHJe3kb59Oe/ZH7Ipm2IauPLWtvBTGwGJE6tCZboUqs2o
 b
X-Gm-Gg: ASbGncv+Qn10RAfi9C9yuAAlWcrNj4ZUY30P2yTFyyz1bz0BUzf6/SsS9LBFPl4Tom3
 huAWQ8vm4qnoETaGFQNYh1HGx1X9ZnTBhoUpmQntdmmlgbou6lGmSjgedK7oeIVXQEynrPDwqtq
 SrrBtp+YDlov8g6b41HGjc1J3ju3kQStXKZssPf9NR1mbEQDa3i8LsGgPYrRafzddFak7pJTSMF
 WcCmYM8b61xHVPLo3C33WbkklSkaEob7ARtvVWOWpVFMYtY13kEi3nyaZvcx6WstxIwRITRKmFY
 uiQ8OSXLP8/h0EeFfJw7ErTGR1o9Rc00jXPv6SlLsl8auGtVANsnurkG01ytN/6uUDGEYnV/PEp
 jJDxLePS18aJcf12K
X-Google-Smtp-Source: AGHT+IEKMwuOccEI8wJ9aMFRRoq88jFqch/ruR+6x2lkvkiWNH5p7VjAkSQ8Gy8m8OdbMjIuENyadg==
X-Received: by 2002:a17:903:244c:b0:224:1c1:4ac1 with SMTP id
 d9443c01a7336-22dbf7408dcmr93959015ad.47.1745687246841; 
 Sat, 26 Apr 2025 10:07:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e766bsm52184925ad.149.2025.04.26.10.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 10:07:26 -0700 (PDT)
Date: Sat, 26 Apr 2025 10:07:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 01/13] net/sxe: add base driver directory and doc
Message-ID: <20250426100724.775a25b3@hermes.local>
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:40 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
>=20
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
>=20
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Build test failed for 32 bit x86

DPDK 25.07.0-rc0

  User defined options
    c_args     : -m32
    c_link_args: -m32

Found ninja-1.12.1 at /usr/bin/ninja
FAILED: drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_ethdev.c.o=20
cc -Idrivers/libtmp_rte_net_sxe.a.p -Idrivers -I../drivers -Idrivers/net/sx=
e -I../drivers/net/sxe -I../drivers/net/sxe/base -I../drivers/net/sxe/pf -I=
../drivers/net/sxe/vf -I../drivers/net/sxe/include/sxe -I../drivers/net/sxe=
/include -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common =
-I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/=
eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib=
/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I..=
/lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/tel=
emetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -=
Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib=
/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -I=
lib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I=
../lib/hash -Ilib/rcu -I../lib/rcu -I/usr/include/i386-linux-gnu -fdiagnost=
ics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -st=
d=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -=
Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-proto=
types -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compar=
e -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-=
missing-field-initializers -Wno-pointer-to-int-cast -D_GNU_SOURCE -m32 -fPI=
C -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-=
format-truncation -Wno-address-of-packed-member -Wno-vla -DSXE_DPDK -DSXE_H=
OST_DRIVER -DSXE_DPDK_L4_FEATURES -DSXE_DPDK_SRIOV -DSXE_DPDK_SIMD -DRTE_LO=
G_DEFAULT_LOGTYPE=3Dpmd.net.sxe -MD -MQ drivers/libtmp_rte_net_sxe.a.p/net_=
sxe_pf_sxe_ethdev.c.o -MF drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_eth=
dev.c.o.d -o drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_ethdev.c.o -c ..=
/drivers/net/sxe/pf/sxe_ethdev.c
../drivers/net/sxe/pf/sxe_ethdev.c: In function =E2=80=98sxe_dev_stop=E2=80=
=99:
../drivers/net/sxe/pf/sxe_ethdev.c:342:9: warning: value computed is not us=
ed [-Wunused-value]
  342 |         rte_atomic_exchange_explicit(&adapter->is_stopping, 1, rte_=
memory_order_seq_cst);
../drivers/net/sxe/pf/sxe_ethdev.c: At top level:
../drivers/net/sxe/pf/sxe_ethdev.c:740:35: error: initialization of =E2=80=
=98int (*)(struct rte_eth_dev *, const uint64_t *, uint64_t *, unsigned int=
)=E2=80=99 {aka =E2=80=98int (*)(struct rte_eth_dev *, const long long unsi=
gned int *, long long unsigned int *, unsigned int)=E2=80=99} from incompat=
ible pointer type =E2=80=98s32 (*)(struct rte_eth_dev *, const ulong *, ulo=
ng *, u32)=E2=80=99 {aka =E2=80=98int (*)(struct rte_eth_dev *, const long =
unsigned int *, long unsigned int *, unsigned int)=E2=80=99} [-Wincompatibl=
e-pointer-types]
  740 |         .xstats_get_by_id       =3D sxe_xstats_get_by_id,
      |                                   ^~~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_ethdev.c:740:35: note: (near initialization for =
=E2=80=98sxe_eth_dev_ops.xstats_get_by_id=E2=80=99)
../drivers/net/sxe/pf/sxe_ethdev.c:742:35: error: initialization of =E2=80=
=98int (*)(struct rte_eth_dev *, const uint64_t *, struct rte_eth_xstat_nam=
e *, unsigned int)=E2=80=99 {aka =E2=80=98int (*)(struct rte_eth_dev *, con=
st long long unsigned int *, struct rte_eth_xstat_name *, unsigned int)=E2=
=80=99} from incompatible pointer type =E2=80=98s32 (*)(struct rte_eth_dev =
*, const ulong *, struct rte_eth_xstat_name *, u32)=E2=80=99 {aka =E2=80=98=
int (*)(struct rte_eth_dev *, const long unsigned int *, struct rte_eth_xst=
at_name *, unsigned int)=E2=80=99} [-Wincompatible-pointer-types]
  742 |         .xstats_get_names_by_id =3D sxe_xstats_names_get_by_id,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_ethdev.c:742:35: note: (near initialization for =
=E2=80=98sxe_eth_dev_ops.xstats_get_names_by_id=E2=80=99)
FAILED: drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_stats.c.o=20
cc -Idrivers/libtmp_rte_net_sxe.a.p -Idrivers -I../drivers -Idrivers/net/sx=
e -I../drivers/net/sxe -I../drivers/net/sxe/base -I../drivers/net/sxe/pf -I=
../drivers/net/sxe/vf -I../drivers/net/sxe/include/sxe -I../drivers/net/sxe=
/include -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common =
-I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/=
eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib=
/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I..=
/lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/tel=
emetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -=
Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib=
/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -I=
lib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I=
../lib/hash -Ilib/rcu -I../lib/rcu -I/usr/include/i386-linux-gnu -fdiagnost=
ics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -st=
d=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -=
Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-proto=
types -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compar=
e -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-=
missing-field-initializers -Wno-pointer-to-int-cast -D_GNU_SOURCE -m32 -fPI=
C -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-=
format-truncation -Wno-address-of-packed-member -Wno-vla -DSXE_DPDK -DSXE_H=
OST_DRIVER -DSXE_DPDK_L4_FEATURES -DSXE_DPDK_SRIOV -DSXE_DPDK_SIMD -DRTE_LO=
G_DEFAULT_LOGTYPE=3Dpmd.net.sxe -MD -MQ drivers/libtmp_rte_net_sxe.a.p/net_=
sxe_pf_sxe_stats.c.o -MF drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_stat=
s.c.o.d -o drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_stats.c.o -c ../dr=
ivers/net/sxe/pf/sxe_stats.c
In file included from ../lib/eal/include/rte_debug.h:17,
                 from ../lib/eal/include/rte_bitops.h:23,
                 from ../lib/ethdev/rte_cman.h:8,
                 from ../lib/ethdev/rte_ethdev.h:159,
                 from ../drivers/net/sxe/pf/sxe_stats.h:8,
                 from ../drivers/net/sxe/pf/sxe_stats.c:5:
../drivers/net/sxe/pf/sxe_stats.c: In function =E2=80=98sxe_xstats_get=E2=
=80=99:
../drivers/net/sxe/pf/sxe_stats.c:237:60: warning: format =E2=80=98%llu=E2=
=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99, b=
ut argument 6 has type =E2=80=98unsigned int=E2=80=99 [-Wformat=3D]
  237 |                         SXE_XSTAT_MAC_CNT, SXE_XSTAT_FC_CNT);
      |                                                            ^
../lib/log/rte_log.h:334:39: note: in definition of macro =E2=80=98RTE_LOG=
=E2=80=99
  334 |                  RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)
      |                                       ^
../drivers/net/sxe/base/sxe_logs.h:144:17: note: in expansion of macro =E2=
=80=98RTE_LOG_LINE_PREFIX=E2=80=99
  144 |                 RTE_LOG_LINE_PREFIX(INFO, logtype, "%s(): ",\
      |                 ^~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c:235:9: note: in expansion of macro =E2=80=
=98PMD_LOG_INFO=E2=80=99
  235 |         PMD_LOG_INFO(DRV, "xstat size:%u. hw xstat field cnt: %" SX=
E_PRIU64
      |         ^~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c:237:60: warning: format =E2=80=98%llu=E2=
=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99, b=
ut argument 7 has type =E2=80=98unsigned int=E2=80=99 [-Wformat=3D]
  237 |                         SXE_XSTAT_MAC_CNT, SXE_XSTAT_FC_CNT);
      |                                                            ^
../lib/log/rte_log.h:334:39: note: in definition of macro =E2=80=98RTE_LOG=
=E2=80=99
  334 |                  RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)
      |                                       ^
../drivers/net/sxe/base/sxe_logs.h:144:17: note: in expansion of macro =E2=
=80=98RTE_LOG_LINE_PREFIX=E2=80=99
  144 |                 RTE_LOG_LINE_PREFIX(INFO, logtype, "%s(): ",\
      |                 ^~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c:235:9: note: in expansion of macro =E2=80=
=98PMD_LOG_INFO=E2=80=99
  235 |         PMD_LOG_INFO(DRV, "xstat size:%u. hw xstat field cnt: %" SX=
E_PRIU64
      |         ^~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c: In function =E2=80=98sxe_xstats_names_ge=
t=E2=80=99:
../drivers/net/sxe/pf/sxe_stats.c:349:60: warning: format =E2=80=98%llu=E2=
=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99, b=
ut argument 5 has type =E2=80=98unsigned int=E2=80=99 [-Wformat=3D]
  349 |                                 SXE_XSTAT_CNT, usr_cnt, ret);
      |                                                            ^
../lib/log/rte_log.h:334:39: note: in definition of macro =E2=80=98RTE_LOG=
=E2=80=99
  334 |                  RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)
      |                                       ^
../drivers/net/sxe/base/sxe_logs.h:156:17: note: in expansion of macro =E2=
=80=98RTE_LOG_LINE_PREFIX=E2=80=99
  156 |                 RTE_LOG_LINE_PREFIX(ERR, logtype, "%s(): ",\
      |                 ^~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c:348:17: note: in expansion of macro =E2=
=80=98PMD_LOG_ERR=E2=80=99
  348 |                 PMD_LOG_ERR(DRV, "max: %" SXE_PRIU64 " usr_cnt:%u i=
nvalid.(err:%d)",
      |                 ^~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c: At top level:
../drivers/net/sxe/pf/sxe_stats.c:441:5: error: conflicting types for =E2=
=80=98sxe_xstats_get_by_id=E2=80=99; have =E2=80=98s32(struct rte_eth_dev *=
, const u64 *, u64 *, u32)=E2=80=99 {aka =E2=80=98int(struct rte_eth_dev *,=
 const long long unsigned int *, long long unsigned int *, unsigned int)=E2=
=80=99}
  441 | s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
      |     ^~~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.h:51:5: note: previous declaration of =E2=
=80=98sxe_xstats_get_by_id=E2=80=99 with type =E2=80=98s32(struct rte_eth_d=
ev *, const ulong *, ulong *, u32)=E2=80=99 {aka =E2=80=98int(struct rte_et=
h_dev *, const long unsigned int *, long unsigned int *, unsigned int)=E2=
=80=99}
   51 | s32 sxe_xstats_get_by_id(struct rte_eth_dev *eth_dev,
      |     ^~~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.c:484:5: error: conflicting types for =E2=
=80=98sxe_xstats_names_get_by_id=E2=80=99; have =E2=80=98s32(struct rte_eth=
_dev *, const u64 *, struct rte_eth_xstat_name *, u32)=E2=80=99 {aka =E2=80=
=98int(struct rte_eth_dev *, const long long unsigned int *, struct rte_eth=
_xstat_name *, unsigned int)=E2=80=99}
  484 | s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_stats.h:61:5: note: previous declaration of =E2=
=80=98sxe_xstats_names_get_by_id=E2=80=99 with type =E2=80=98s32(struct rte=
_eth_dev *, const ulong *, struct rte_eth_xstat_name *, u32)=E2=80=99 {aka =
=E2=80=98int(struct rte_eth_dev *, const long unsigned int *, struct rte_et=
h_xstat_name *, unsigned int)=E2=80=99}
   61 | s32 sxe_xstats_names_get_by_id(struct rte_eth_dev *eth_dev,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../lib/eal/include/rte_dev.h:20,
                 from ../lib/eal/include/dev_driver.h:9,
                 from ../lib/ethdev/ethdev_driver.h:19,
                 from ../drivers/net/sxe/pf/sxe_tx.c:12:
../drivers/net/sxe/pf/sxe_tx.c: In function =E2=80=98sxe_tx_function_set=E2=
=80=99:
../drivers/net/sxe/pf/sxe_tx.c:75:69: warning: format =E2=80=98%llx=E2=80=
=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99, but =
argument 5 has type =E2=80=98long unsigned int=E2=80=99 [-Wformat=3D]
   75 |                                         (unsigned long)txq->offload=
s);
      |                                                                    =
 ^
../lib/log/rte_log.h:334:39: note: in definition of macro =E2=80=98RTE_LOG=
=E2=80=99
  334 |                  RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)
      |                                       ^
../drivers/net/sxe/base/sxe_logs.h:144:17: note: in expansion of macro =E2=
=80=98RTE_LOG_LINE_PREFIX=E2=80=99
  144 |                 RTE_LOG_LINE_PREFIX(INFO, logtype, "%s(): ",\
      |                 ^~~~~~~~~~~~~~~~~~~
../drivers/net/sxe/pf/sxe_tx.c:74:17: note: in expansion of macro =E2=80=98=
PMD_LOG_INFO=E2=80=99
   74 |                 PMD_LOG_INFO(INIT, " - offloads =3D 0x%" SXE_PRIX64,
      |                 ^~~~~~~~~~~~
ninja: build stopped: subcommand failed.
