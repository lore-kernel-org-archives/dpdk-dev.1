Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE87C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 18:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D362940289;
	Fri, 21 Aug 2026 20:03:41 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2B3814027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 20:03:40 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso27046075ad.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787335419;
 x=1787940219; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yy8Ayzh6p5zhIscFYgwPYAh56SRPLJYN+9WzHDt8gZ8=;
 b=CtvcjnISnn1n1C+8GqrzZFgMHc+IbMq3X/cyrkxNlYmbswUCy2ocDlmc463Q1QkEFu
 QOhOxKNkVTP5Bm9uoLtxzJAy2fttFLkp8pjNxvxnX0YEn2gANtxE+m6XzEn+7CNalHe4
 OPhiE9ZOh99s3li/mtef2uANFXZbUqQGswshi2EebEWMR4tLyPCDAnu/OgHrLKCVqcAq
 kW//XkT7e9n0+Db3aZazPYjreu/tDQr7glCLDlbGUjVMOtSTP1/+olYS3/DbT6wVW5R6
 uZAfCLmKIEFRUTaIM8hNUCRWnsytFQLYwx6gzjEWYXjkqgV19MwbZtocHBiKI0ui0ktI
 GFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787335419; x=1787940219;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yy8Ayzh6p5zhIscFYgwPYAh56SRPLJYN+9WzHDt8gZ8=;
 b=ey5VZC713LNhMhmWJlxhIaNXIkB51oJMC0RVVJDqRH1Eqi8+SzEFjF5UGu6mQAd/vV
 YhaQUekx6wf+dLGzAPxt0IamsMbDzQa4WvV/Tc6WpaI5a6K/bEG7z0EHdIN76hYQxDb4
 RWncmDyxl36I3+QMHcgsKPxISx95TdiajZUJ6F07+VzjKVTrW5eouB3P785qgZ215NN7
 dR+wmqWUbryrIYZWJkU+ZzeVY59s+X6jyCHqM1uglQMMQj7sNbruoHz54tb8kfveYYUd
 TcUYJzxQAOYQ3M2+sgD5vLAFNrNPPr+a1AB3dbA8OENGopd55pXy+/5RdjM2I6EB3vTp
 BXJg==
X-Gm-Message-State: AFuF++nZIEFq3JOSQ6Qa55aBKySmgB8IrCz3W9Sk/zR08rVD1mBZIKOU
 9CBKRa04HZwkD9SrwisUW3DCN2UkGPdClm8sb8txmmoSIqlTRUNGZPG7uceeXMfnl8Q=
X-Gm-Gg: AR+sD12WUCa+dzfxGUAW1JcyBvUuUo8BBykip2U/zxUP8HUgwrAxUORK0CMGpyZRDJD
 5oaCPhr6xSDQES9FHqSs0WEvWawDofhxQ9hc7KGJ1J2u5glU1ov6B8ejv3r+hNrc7QhR/zfFuvm
 lbgOwT2SlDpuRs1PVTJAOpIpSOdhu2L8XeSnVj9h+M2qO7F+/AyGe9408dtDiZmfMr4CPAd6GPq
 4TN78o0yu/Ws6xZwsjPAnJ3K2v1hlNx7QjeyQ7DY6bV6TySV6fAmw8I7shJ1i7PqJU5NVHfVxl4
 uqam/asCy6WKSWo2776eSmxddG3oPl1ckRCanCWy223UxI/TPOP9Q68qT5/ie4QKw3/x0AMfjNu
 p/Rzzt6WBmBDybyA4HRoX/a5jFiHhZfCZwkmkGpVZkxWCF3q5OZyv1rXaAKL7Xxbltr798rTJKC
 lVz8D8iDi4GGf91U4cVF5VddB/O68DpgFLA1TbfBkjKyLXViipkEESvjfd2YnxtZR2kkEKV0zKV
 hX2tWRjrFiLUrrOUnJ41WRlH8TQQA==
X-Received: by 2002:a17:90b:3e8d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-395c4fa444bmr1150958a91.5.1787335418910; 
 Fri, 21 Aug 2026 11:03:38 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b47ae8sm4152166a91.13.2026.08.21.11.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:03:38 -0700 (PDT)
Date: Fri, 21 Aug 2026 11:03:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Konstantin
 Ananyev <konstantin.ananyev@huawei.com>, Jie Liu
 <liujie5@linkdatatechnology.com>
Subject: Re: [dpdk-dev v1] net/sxe2: replace private mempool cache bypass
 with rte_mbuf_raw_free_bulk
Message-ID: <20260821110328.25240bf9@phoenix.local>
In-Reply-To: <20260820155008.1989965-1-kai.ji@intel.com>
References: <20260820155008.1989965-1-kai.ji@intel.com>
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

On Thu, 20 Aug 2026 15:50:08 +0000
Kai Ji <kai.ji@intel.com> wrote:

> The AVX-512 TX completion path directly manipulated the mempool cache
> internals (cache->objs, cache->len, cache->flushthresh) instead of using
> the mempool API.  This pattern is the same private bypass that existed in
> the Intel common TX library before it was removed by commit 062d6fe5d0e4
> ("net/intel: do not bypass mbuf lib for buffer fast-free") for the same
> reason: it omits mbuf instrumentation (history marking) and contains
> dead flush code that accesses cache->objs[cache->size], which is one
> past the end of the array when cache_size =3D=3D RTE_MEMPOOL_CACHE_MAX_SI=
ZE.
>=20
> Replace with a single rte_mbuf_raw_free_bulk() call, matching the Intel
> common library.  The MBUF_FAST_FREE offload guarantee (single pool,
> refcnt =3D=3D 1) makes this correct and the compiler inlines the bulk-free
> call to eliminate the overhead difference.
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---

Looks good but still some leftovers to remove.

FAILED: drivers/net/sxe2/libsxe2_avx512_lib.a.p/sxe2_txrx_vec_avx512.c.o=20
gcc -Idrivers/net/sxe2/libsxe2_avx512_lib.a.p -Idrivers/net/sxe2 -I../drive=
rs/net/sxe2 -Idrivers/common/sxe2 -I../drivers/common/sxe2 -Ilib/ethdev -I.=
./lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../co=
nfig -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../li=
b/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../ker=
nel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I.=
./lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry=
 -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../li=
b/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter =
-I../lib/meter -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/securi=
ty -I../lib/security -Ilib/cryptodev -I../lib/cryptodev -Idrivers/bus/pci -=
I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -fdia=
gnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextr=
a -Werror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecat=
ed -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -W=
missing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith =
-Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-pa=
cked-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -g -DCC_AVX512_SUPPORT -mavx512f -mavx512bw -march=3Dskylake-avx5=
12 -MD -MQ drivers/net/sxe2/libsxe2_avx512_lib.a.p/sxe2_txrx_vec_avx512.c.o=
 -MF drivers/net/sxe2/libsxe2_avx512_lib.a.p/sxe2_txrx_vec_avx512.c.o.d -o =
drivers/net/sxe2/libsxe2_avx512_lib.a.p/sxe2_txrx_vec_avx512.c.o -c ../driv=
ers/net/sxe2/sxe2_txrx_vec_avx512.c
../drivers/net/sxe2/sxe2_txrx_vec_avx512.c: In function =E2=80=98sxe2_tx_bu=
fs_free_vec_avx512=E2=80=99:
../drivers/net/sxe2/sxe2_txrx_vec_avx512.c:47:1: error: label =E2=80=98norm=
al=E2=80=99 defined but not used [-Werror=3Dunused-label]
 normal:
 ^~~~~~
cc1: all warnings being treated as errors
[2434/3759] Generating drivers/rte_net_sxe2_ma
