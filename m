Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB03CC636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06B62402D8;
	Sun, 22 Feb 2026 19:03:20 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 662A0402B8
 for <dev@dpdk.org>; Sun, 22 Feb 2026 19:03:18 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so3189575a34.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771783397;
 x=1772388197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWkJAYh84/GA+gnYKHmigiwGx06jfn9XQj8EierrRvE=;
 b=RCr76Ro86jEeMpJlSGZfNizZOES5PR925t3lnLpkOOEla5bfuIHaI5sin2740G8f2k
 o1K63pT0vrgckMAWIDpSzKFv9DJH+9g0V4ibJGsYrbNXASVAjie2ZL8Lvrhn/sT3u5kg
 UYtMvafXe0+b8lr+I3k8KYG+Qsu1/VhwC632KVAD6tqdI31rR1Oi8xRGnGlLhKf1y+rf
 Ww+yR4B8/gClKoZ++QGuxTS1JaMAEvNvJ8wNp8XeK6tiso7Z9cV7Yx7Yuo3i8sAHNw1x
 DqiBpMrVprOrT1rQzK9ch3+sZKZXFjS2I2vaBCFTznXDfMSwbmf3fSHuTz8dPDwwfhc0
 LtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771783397; x=1772388197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWkJAYh84/GA+gnYKHmigiwGx06jfn9XQj8EierrRvE=;
 b=Q4tI5HgtV0BuSYIxWiMSylnh1XyqWdfPxyBiXW50kJ459bs9ommRKiT/UsE/Xc+JaU
 NgQDZi/OoBhBACkylz1zG+/3TlNXL4F/HWjo2TkuqQJo1vn1aR/8tQVjxZBcP4C0COgZ
 Q24BDtyxn3WcADt9amTyL4AoZnpqeBTfngG1wafV3Gk039xs2chqCelD5JKi5IRQVE97
 TjT9yib/OvrbjdqNbiGX02sC+wlrbF7B9MO/MeZETtY3TZWck8eSGZRSPYqpklcK0bjp
 skupuwKquGxuKJa6AD3EBrMlK5snnFbak2YNcnfSfqJCCWi+epecU4KvK+o7vZAmTYCC
 CMPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt2ufQDcAm564YHmrdvffbj1SaJaBc52FUlLm04PO9uIX21mxMSE0h6omhdWrWbnuCNBY=@dpdk.org
X-Gm-Message-State: AOJu0YzOdUcU7gmiAZR/6snZuG0nFvPxsfe9PvDjOtD0ZM9ZQTxglgJN
 1+lWdmas8gFHVWYwDNd1po4NpPXrO6m4210v/2lL/eauAC9LVhZinbp07tcHwzJguOo=
X-Gm-Gg: AZuq6aJrYOf5BpoH0eqMCMMNQ0YQPvBLj8QI4Jqdi/3iIjXRkyRIj2BqwOZDFYAuS61
 yqwkX6Y4zatPk5SKJ0lLM/6hWDAkFs0of07XauvQZQpRHSyLY2avvG3BSFgbrLac+vIzeklYNwV
 24S0YGBRAEwsx7TGg+fShy+fykGLBG6wXFNfPi1G4aXDzGAiLI4g/mOTKxd5CjLPghnejhSvyMI
 44JaAp8oENSLIgO+lf6ok/dyNV4e9hAx0sVBdn0BUp+h2XIEMEPaOuw5gSqGNxljJp+WTXugLLA
 iBT7pcfHgUim/98RmOp0g5kKuSaCCVr7L8Pu8mf9PztBbi/gUV5gbMyBFHDNp6hxN4pUVxK8BL5
 NF7hAUG+VJ9ey0lFQsifcHbVlrkvE2bMgQtiByUdcN2AJ/U3KkloO3rHw0Lp4wLFFZomKhxJkEg
 kmRpJA0lBeDcfchDLdFqdb0fnU3jK42ksNn/vL30Ha09xmSzztIaW5v07YXOy8DRF9MlG5W5P9F
 KI=
X-Received: by 2002:a05:6830:719a:b0:7c7:4f2:e15d with SMTP id
 46e09a7af769-7d52be7aa35mr4507620a34.16.1771783397248; 
 Sun, 22 Feb 2026 10:03:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0725eesm5214533a34.28.2026.02.22.10.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 10:03:17 -0800 (PST)
Date: Sun, 22 Feb 2026 10:03:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Gregory <code@danielg0.com>
Cc: =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>,
 dev@dpdk.org, Punit Agrawal <punit.agrawal@bytedance.com>, Liang Ma
 <liangma@liangbit.com>, Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>, Daniel Gregory
 <daniel.gregory@bytedance.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: Re: [PATCH v4 00/10] riscv: implement accelerated crc using zbc
Message-ID: <20260222100313.5fd90e0c@phoenix.local>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
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

On Sun, 22 Feb 2026 16:29:54 +0100
Daniel Gregory <code@danielg0.com> wrote:

> The RISC-V Zbc extension adds instructions for carry-less multiplication
> we can use to implement CRC in hardware. This patch set contains two new
> implementations:
>=20
> - one in lib/hash/rte_crc_riscv64.h that uses a Barrett reduction to
>   implement the four rte_hash_crc_* functions
> - one in lib/net/net_crc_zbc.c that uses repeated single-folds to reduce
>   the buffer until it is small enough for a Barrett reduction to
>   implement rte_crc16_ccitt_zbc_handler and rte_crc32_eth_zbc_handler
>=20
> My approach is largely based on the Intel's "Fast CRC Computation Using
> PCLMULQDQ Instruction" white paper
> https://www.researchgate.net/publication/263424619_Fast_CRC_computation
> and a post about "Optimizing CRC32 for small payload sizes on x86"
> https://mary.rs/lab/crc32/
>=20
> Whether these new implementations are enabled is controlled by new
> build-time and run-time detection of the RISC-V extensions present in
> the compiler and on the target system.
>=20
> I have carried out some performance comparisons between the generic
> table implementations and the new hardware implementations. Listed below
> is the number of cycles it takes to compute the CRC hash for buffers of
> various sizes (as reported by rte_get_timer_cycles()). These results
> were collected on a Kendryte K230 and averaged over 20 samples:
>=20
> |Buffer    | CRC32-ETH (lib/net) | CRC32C (lib/hash)   |
> |Size (MB) | Table    | Hardware | Table    | Hardware |
> |----------|----------|----------|----------|----------|
> |        1 |   155168 |    11610 |    73026 |    18385 |
> |        2 |   311203 |    22998 |   145586 |    35886 |
> |        3 |   466744 |    34370 |   218536 |    53939 |
> |        4 |   621843 |    45536 |   291574 |    71944 |
> |        5 |   777908 |    56989 |   364152 |    89706 |
> |        6 |   932736 |    68023 |   437016 |   107726 |
> |        7 |  1088756 |    79236 |   510197 |   125426 |
> |        8 |  1243794 |    90467 |   583231 |   143614 |
>=20
> These results suggest a speed-up of lib/net by thirteen times, and of
> lib/hash by four times.
>=20
> I have also run the hash_functions_autotest benchmark in dpdk_test,
> which measures the performance of the lib/hash implementation on small
> buffers, getting the following times:
>=20
> | Key Length | Time (ticks/op)     |
> | (bytes)    | Table    | Hardware |
> |------------|----------|----------|
> |          1 |     0.47 |     0.85 |
> |          2 |     0.57 |     0.87 |
> |          4 |     0.99 |     0.88 |
> |          8 |     1.35 |     0.88 |
> |          9 |     1.20 |     1.09 |
> |         13 |     1.76 |     1.35 |
> |         16 |     1.87 |     1.02 |
> |         32 |     2.96 |     0.98 |
> |         37 |     3.35 |     1.45 |
> |         40 |     3.49 |     1.12 |
> |         48 |     4.02 |     1.25 |
> |         64 |     5.08 |     1.54 |
>=20
> v4:
> - rebase on 26.03-rc1
> - RISC64 -> RISCV64 in test_hash.c (Stephen Hemminger)
> - Added section to release notes (Stephen Hemminger)
> - SPDX-License_Identifier -> SPDX-License-Identifier in
>   rte_crc_riscv64.h (Stephen Hemminger)
> - Fix header guard in rte_crc_riscv64.h (Stephen Hemminger)
> - assert -> RTE_ASSERT in rte_crc_riscv64.h (Stephen Hemminger)
> - Fix copyright statement in net_crc_zbc.c (Stephen Hemminger)
> - Make crc context structs static in net_crc_zbc.c (Stephen Hemminger)
> - prefer the optimised crc when zbc present over jhash in rte_fbk_hash.c
> v3:
> - rebase on 24.07
> - replace crc with CRC in commits (check-git-log.sh)
> v2:
> - replace compile flag with build-time (riscv extension macros) and
>   run-time detection (linux hwprobe syscall) (Stephen Hemminger)
> - add qemu target that supports zbc (Stanislaw Kardach)
> - fix spelling error in commit message
> - fix a bug in the net/ implementation that would cause segfaults on
>   small unaligned buffers
> - refactor net/ implementation to move variable declarations to top of
>   functions
> - enable the optimisation in a couple other places optimised crc is
>   preferred to jhash
>   - l3fwd-power
>   - cuckoo-hash
>=20
> Daniel Gregory (10):
>   config/riscv: detect presence of Zbc extension
>   hash: implement CRC using riscv carryless multiply
>   net: implement CRC using riscv carryless multiply
>   config/riscv: add qemu crossbuild target
>   examples/l3fwd: use accelerated CRC on riscv
>   ipfrag: use accelerated CRC on riscv
>   examples/l3fwd-power: use accelerated CRC on riscv
>   hash: use accelerated CRC on riscv
>   member: use accelerated CRC on riscv
>   doc: implement CRC using riscv carryless multiply
>=20
>  .mailmap                                      |   2 +-
>  MAINTAINERS                                   |   2 +
>  app/test/test_crc.c                           |  10 +
>  app/test/test_hash.c                          |   7 +
>  config/riscv/meson.build                      |  33 +++
>  config/riscv/riscv64_qemu_linux_gcc           |  17 ++
>  .../linux_gsg/cross_build_dpdk_for_riscv.rst  |   5 +
>  doc/guides/rel_notes/release_26_03.rst        |   8 +
>  examples/l3fwd-power/main.c                   |   2 +-
>  examples/l3fwd/l3fwd_em.c                     |   2 +-
>  lib/eal/riscv/include/rte_cpuflags.h          |   2 +
>  lib/eal/riscv/rte_cpuflags.c                  | 112 +++++++---
>  lib/hash/meson.build                          |   1 +
>  lib/hash/rte_crc_riscv64.h                    |  90 ++++++++
>  lib/hash/rte_cuckoo_hash.c                    |   3 +
>  lib/hash/rte_fbk_hash.c                       |   3 +
>  lib/hash/rte_hash_crc.c                       |  13 +-
>  lib/hash/rte_hash_crc.h                       |   6 +-
>  lib/ip_frag/ip_frag_internal.c                |   6 +-
>  lib/member/member.h                           |   2 +-
>  lib/net/meson.build                           |   4 +
>  lib/net/net_crc.h                             |  11 +
>  lib/net/net_crc_zbc.c                         | 194 ++++++++++++++++++
>  lib/net/rte_net_crc.c                         |  30 ++-
>  lib/net/rte_net_crc.h                         |   3 +
>  25 files changed, 526 insertions(+), 42 deletions(-)
>  create mode 100644 config/riscv/riscv64_qemu_linux_gcc
>  create mode 100644 lib/hash/rte_crc_riscv64.h
>  create mode 100644 lib/net/net_crc_zbc.c
>=20

AI patch review summary: the overall approach looks good =E2=80=94 the hwpr=
obe
integration is clean and the Barrett reduction math appears correct.
A few issues need addressing before this can be merged:

1. [ERROR, patch 01] 1 << n used for all 26 HWCAP mask entries

   The feature table entries now store masks in a uint64_t field, but
   all 26 existing RISCV_ISA_* entries still use plain '1 << n' (signed
   int). This produces 32-bit values stored in a 64-bit field and causes
   undefined behaviour for n >=3D 31. All entries must use UINT64_C(1) << n:

     FEAT_DEF(RISCV_ISA_A, REG_HWCAP, UINT64_C(1) <<  0)
     ...
     FEAT_DEF(RISCV_ISA_Z, REG_HWCAP, UINT64_C(1) << 25)

2. [WARNING, patches 03-07, 09] Missing Signed-off-by from submitter address

   These patches carry only:
     Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
   but are submitted from code@danielg0.com. The DCO requires a
   Signed-off-by from the address used to submit the patch. Please add:
     Signed-off-by: Daniel Gregory <code@danielg0.com>
   to each of these patches (as done correctly in 01, 08, and 10).

3. [WARNING, patch 02] Inverted condition in rte_hash_crc_set_alg

   The new warning log fires when the caller does *not* request
   CRC32_RISCV64, but the message says the opposite:

     if (!(alg & CRC32_RISCV64))
         HASH_CRC_LOG(WARNING, "Unsupported CRC32 algorithm requested
                               using CRC32_RISCV64");

   Either flip the condition or reword the message to match the intent
   (e.g. "Falling back to CRC32_RISCV64 despite a different algorithm
   being requested").

4. [WARNING, patch 03] Unaligned access in crc32_repeated_barrett_zbc

   The function casts 'data' directly to uint64_t*/uint32_t*/uint16_t*
   and dereferences it. It is called for tail data (after the main fold
   loop and for buffers < 16 bytes) where alignment is not guaranteed.
   RISC-V hardware unaligned access support is optional. Use memcpy into
   a local variable or equivalent to be safe on all implementations.

5. [WARNING, patch 10] .mailmap replaces rather than aliases old address

   The change removes the bytedance entry entirely. The correct form
   maps the old address to the new canonical one:

     Daniel Gregory <code@danielg0.com> <daniel.gregory@bytedance.com>

   Without this, existing commits with the bytedance address will no
   longer be attributed to the canonical identity in git shortlog.

Minor: the Barrett reduction in rte_crc_riscv64.h and net_crc_zbc.c
both truncate a uint64_t result to uint32_t implicitly on return. A
brief comment explaining this is intentional (only the lower 32 bits
are the CRC remainder) would help future readers.

