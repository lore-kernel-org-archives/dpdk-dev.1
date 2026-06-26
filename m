Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04FFC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 17:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E02A4026D;
	Fri, 26 Jun 2026 19:03:25 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id B035E40264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 19:03:24 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso1605811eec.1
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782493403;
 x=1783098203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYNFqtFCn15HABNG7J8yP+Ct3Krzt5pC2nWXGfrWH74=;
 b=x0UzND+dyk5CHE1al6BwkZP/vpTNN1HsFL3iY3bp68LDggEgmZRY1nnizL5xhnc22C
 gi2HOzwz6JgDEh3wwMWsmjImf7h41S/fFQzCWoeI0MLWIk0WmBN4uJLf7RcjJnOZD6CB
 tvLyBonzhKAaUgyryTvS+OYvYmUsDiEOo7OQmAJxb98rJQ2rddS5WZSHYhDHj3c/EM/Q
 3Nf6k4z0uyl7p4W2v9tbLHvsgLdrj5hkrX33yjOOIZ86b1z8aVEZQKiIXzWxjv6CPpxV
 BpIJiMGKGdUf7pX2I63VisS1T1C97UwC2MzwQbhjaWRU8E8fJjd9VQCSPs0vbJJtt62F
 jIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782493403; x=1783098203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYNFqtFCn15HABNG7J8yP+Ct3Krzt5pC2nWXGfrWH74=;
 b=ddjLDsZSuA508OQLS03JMIHTPCS5Aj3lNUW10tsa7ZWCVV6RA4+OqsMrvDbozTIwru
 dpUbiN9W5fxraTAmaxKJbG6OrYvJRiLt2wbX0EHsGmxewsdo+fqbTGTcFbVQJfUb7JWC
 whNTYaVND3X/tzbgddYOqsuyzO1dX4WyjCD7B5so1n6tAb+yTOKw0BZTIp+BUOI4SrWz
 e3AoX3Z8NMvZYAlvGM3hDYuR2bETFuZNp0Gw0WH//+6W/ShMR2q2XkBXCHHoEsjQrT4p
 g+jTq1h+O4U95Rrv8YX/rVXXHbmeHLeAfuhXlq3Ebxrf2hjdQUe+E+k6X/mNHMuZlxFU
 SisQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrS5LewmXZ4UgxuYMuWRW8wAMv3uWJdesrsul6Ebb8K+/LZlHfu0cx5rbApnY58M5u4NDo=@dpdk.org
X-Gm-Message-State: AOJu0Yx1rXQg2oXbgOR8hM2llX5tw83wvCPGoGHRXxKeyVRK0hpjSIN6
 5zp6e4H+38lNiyaEgUI2ASSIVTCR/LI7gLr+DDlm3J5dOe0D7UwhLVvWD/KKXKPC6OY=
X-Gm-Gg: AfdE7clivfZvg5sTmiX9yWMaZKWc0A4NCj6WeIsC92wWLw6EVgo8vDlXL+GH3ZPoKv6
 oJ28TK0T0NGEa+GcrqqsFh89b3w9lxipesT2v2s2jl8GpeP2rU36TUAF5bwB3UdqrqEYZS/dDeK
 FvwSDjF7hA/50E1V264Je0HaFJEsc/QJHv1l2SFIJyEQIJ0OnKGtaGDjdOL4ujLTe02gNDXIWQ0
 a6efhvCwErUOS/b1Hmwn8cTT2k+cTdP9EdeW9y7JVRanD9Lc/+lKbfEeAl+KcBFqpy2LJF3RzLR
 ndzr4k/gcOTQFZK+pfw84tV/X2WdpTBKNblkCK4fDEa8O0PcrTeaCLKiaV1317PEqu+JkJ2l67D
 nMalYKzdazn8rMig/bLbu8UZwmb9XRwi8SsTxf0pfyWDz7LL2fakEnga4y8FgyYN78cyv/A1wf2
 rAAY4TYw7yzReUxC73nenv+sJn3enbMUOtjO4ctK7tXTdLYzcwQDGf9A==
X-Received: by 2002:a05:7300:8c2c:b0:30c:2af0:1cc with SMTP id
 5a478bee46e88-30c84fdf0c5mr8454035eec.34.1782493403158; 
 Fri, 26 Jun 2026 10:03:23 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c944999adsm12611372eec.24.2026.06.26.10.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 10:03:22 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:59:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
Subject: Re: [PATCH v5 17/19] drivers: release DPAA bpid on driver destructor
Message-ID: <20260626095901.5bef5e05@phoenix.local>
In-Reply-To: <20260626065655.279742-18-hemant.agrawal@nxp.com>
References: <20260621172731.2916346-1-hemant.agrawal@nxp.com>
 <20260626065655.279742-1-hemant.agrawal@nxp.com>
 <20260626065655.279742-18-hemant.agrawal@nxp.com>
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

On Fri, 26 Jun 2026 12:26:53 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> From: Jun Yang <jun.yang@nxp.com>
>=20
> Track allocated BPIDs in a static per-BPID flag table and register a
> driver destructor that releases any BPIDs still marked as in use at
> process exit. This prevents BPID leaks when an application exits without
> calling rte_mempool_free(). Also tune the per-lcore mempool cache flush
> threshold to match the hardware bulk release size (DPAA_MBUF_MAX_ACQ_REL)
> so that buffers are returned to HW in optimal burst sizes.
>=20
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> ---

Build with ASAN fails with this patch.
Simple fix is usually replacing all use of rte_memcpy with memcpy.
Rte_memcpy on x86 confuses ASAN and it thinks certain sizes reference past
end of buffer. I would just do a global replace of rte_memcpy with memcpy
across all of drivers/bus/dpaa none of this is performance critical on old
versions of Gcc which is the only reason rte_memcpy still exists.

This needs to be fixed before merging.

In file included from /usr/lib/gcc/x86_64-linux-gnu/15/include/immintrin.h:=
43,
                 from /usr/lib/gcc/x86_64-linux-gnu/15/include/x86intrin.h:=
32,
                 from ../lib/eal/x86/include/rte_vect.h:24,
                 from ../lib/eal/x86/include/rte_memcpy.h:17,
                 from ../drivers/bus/dpaa/base/qbman/bman.c:7:
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:158:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:169:2,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:389:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98bman_release_fast=E2=80=99 at ../drivers/bus/dpaa=
/base/qbman/bman.c:296:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript =E2=80=98__m256i_u[1]=E2=80=99 is partly outside array bounds of=
 =E2=80=98struct bm_buffer[8]=E2=80=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset 40 into objec=
t =E2=80=98bm_bufs=E2=80=99 of size 64
  270 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:157:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:170:2,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:389:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98bman_release_fast=E2=80=99 at ../drivers/bus/dpaa=
/base/qbman/bman.c:296:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript 2 is outside array bounds of =E2=80=98struct bm_buffer[8]=E2=80=
=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset 72 into objec=
t =E2=80=98bm_bufs=E2=80=99 of size 64
  270 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:158:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:170:2,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:389:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98bman_release_fast=E2=80=99 at ../drivers/bus/dpaa=
/base/qbman/bman.c:296:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript 3 is outside array bounds of =E2=80=98struct bm_buffer[8]=E2=80=
=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset 104 into obje=
ct =E2=80=98bm_bufs=E2=80=99 of size 64
  270 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:158:2,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:396:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98bman_release_fast=E2=80=99 at ../drivers/bus/dpaa=
/base/qbman/bman.c:296:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript =E2=80=98__m256i_u[1]=E2=80=99 is partly outside array bounds of=
 =E2=80=98const void[64]=E2=80=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [40, 48] into=
 object =E2=80=98bm_bufs=E2=80=99 of size 64
  270 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [41, 64] into=
 object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [168, 176] in=
to object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [40, 48] into=
 object =E2=80=98bm_bufs=E2=80=99 of size 64
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:401:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98bman_release_fast=E2=80=99 at ../drivers/bus/dpaa=
/base/qbman/bman.c:296:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript [2, 66] is outside array bounds of =E2=80=98const void[64]=E2=80=
=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [8, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
  270 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [9, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [136, 208] in=
to object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [8, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [9, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [136, 208] in=
to object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [8, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:402:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98bman_release_fast=E2=80=99 at ../drivers/bus/dpaa=
/base/qbman/bman.c:296:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript [2, 67] is outside array bounds of =E2=80=98const void[64]=E2=80=
=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [9, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
  270 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [10, 64] into=
 object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [137, 209] in=
to object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [9, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [10, 64] into=
 object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [137, 209] in=
to object =E2=80=98bm_bufs=E2=80=99 of size 64
../drivers/bus/dpaa/base/qbman/bman.c:270:26: note: at offset [9, 64] into =
object =E2=80=98bm_bufs=E2=80=99 of size 64
