Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF23DF3D601
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 18:22:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D43B402C3;
	Sun, 29 Mar 2026 20:22:15 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 519CD400D6
 for <dev@dpdk.org>; Sun, 29 Mar 2026 20:22:14 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so7434572eec.1
 for <dev@dpdk.org>; Sun, 29 Mar 2026 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774808533;
 x=1775413333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNPib0eAepgzqE5kOJQ2Yy2/yTgWoqFYwfb7h9bk/fg=;
 b=j3cxCwF7pbWa2yPxf+UL2h8ZyutcxmGL0ChLOVkztUyn5bdnXlQWdEaxp3D2aQ4R7m
 YDMPD6FNEMiOOIBh9bN4EgnU1rDexdq5Y7mEKRgYj1UTIKSWsIs6+ytvdt/RFsy1lvFE
 9CLBH2Rd4QIWwk/D2Uvr26oFdVsrsQ9+IKlpKYDVGJvCJGylbGNpEXN/a76ck42P2Nmy
 nHqodjsx9ExuFqhzTLegzpkf2EXOdEmKGPxo1TzH/1DrtFYWjAE5H+yVxG7MP+iXsocm
 a2KrwrGjdh0OVDPBXkjtj7+b/F0aNY7yjfiaWJ4lzXjejhNW/nvpmtlhrGDoO/6KgQCY
 1RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774808533; x=1775413333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oNPib0eAepgzqE5kOJQ2Yy2/yTgWoqFYwfb7h9bk/fg=;
 b=R/ir6J9OwefeFZWrKZWOW+KfaMUAAOkosHq7MctvLr5tmoRFlOH6KoLkVA/hYfbFr4
 0d8Ukr8rR+lpwcdzgELdoxdn9LsuucIjxEd49RgGMqxf1DwF6T07fF2eMybfXBQBKsBs
 aba2VmIfR2QiwWjo/GV8JioM8Gx8F4LMlLT1OR9TJQuvQFSoT29JmMMNHTkv3q+MOhS7
 AHsuclNZUyVzFlbAAsgffUIzrZPE4zj4aKjM0tfK5yRRqr8Lp5vgYtqyG/AseU8eOk8Q
 2Y1flv0E8NcqPNitIsYeww7qaJ1125xcUeBQIP6mTciOT+gvzMxOdfw57bBlX0Dj601I
 IdMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7E0VuwyHbVbK1t61h5oxIeLZGzAfM5hjzvdW8E5X28TRpEJ6PDwhnHXIrvQjoMhm7iuw=@dpdk.org
X-Gm-Message-State: AOJu0Yyf/YkHBZTImF/++Y1a5YZiCxbLDQqCB62SG3MGZo+n6VhQmacO
 Z4vc5QEGnLxovmwQ6ECZcRD/oobXJkiXhS+HOe9B9L7gF9+bFCxA2ottN4Jp2QskrI0=
X-Gm-Gg: ATEYQzxjJ6bJpvvhb26Ry6t8Z1AjKirP6MCStrsZiF9e9MZsYRc+FZDgmEIzn55vWo0
 E3ApicOwVfOIL6u1/T5b7/CrFVgdq3mHETLASpph05Ry8Ia33ai1ig/+FubuzuZ8vx4VtnJ1n6i
 PXiBurQeCLHN+RPGEDsXqqnASbAxCP9/8q6j6wEaDYMz6SwOPmZyg6/YdYpQCtEk40Tu1gS5gOH
 LwA8L9sldqj0AGvuGEintyKhqNaloOKtuIMaj4qcHAPmIaX/8LzfbAQnIeSElKP2ll7yaqUtZ3x
 nLcNxxJsI4Y10XezewPRcF8C383ekTstzWAzOpDWOITCT43B57PgQqrYhVFLS4Ahtq/4RKfWFoW
 Dnm9xqQUVsELSUufmOyiboVO+TCZSv9E1S+SkzSXz5DR32PdCES3/HljqHhfkYKlqTMxz+dI2GM
 DzDqY12GsiwHbcl169gvi138MgeLziPBzlK3o=
X-Received: by 2002:a05:7300:e60b:b0:2be:a2d8:e9e3 with SMTP id
 5a478bee46e88-2c185face1cmr5654128eec.29.1774808533082; 
 Sun, 29 Mar 2026 11:22:13 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c74825a0sm5000383eec.27.2026.03.29.11.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 11:22:12 -0700 (PDT)
Date: Sun, 29 Mar 2026 11:22:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Gregory <code@danielg0.com>
Cc: =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>,
 dev@dpdk.org, Punit Agrawal <punit.agrawal@bytedance.com>, Liang Ma
 <liangma@liangbit.com>, Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>, Daniel Gregory
 <daniel.gregory@bytedance.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: Re: [PATCH v4 00/10] riscv: implement accelerated crc using zbc
Message-ID: <20260329112210.638d1811@phoenix.local>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
> 
> - one in lib/hash/rte_crc_riscv64.h that uses a Barrett reduction to
>   implement the four rte_hash_crc_* functions
> - one in lib/net/net_crc_zbc.c that uses repeated single-folds to reduce
>   the buffer until it is small enough for a Barrett reduction to
>   implement rte_crc16_ccitt_zbc_handler and rte_crc32_eth_zbc_handler
> 
> My approach is largely based on the Intel's "Fast CRC Computation Using
> PCLMULQDQ Instruction" white paper
> https://www.researchgate.net/publication/263424619_Fast_CRC_computation
> and a post about "Optimizing CRC32 for small payload sizes on x86"
> https://mary.rs/lab/crc32/
> 
> Whether these new implementations are enabled is controlled by new
> build-time and run-time detection of the RISC-V extensions present in
> the compiler and on the target system.
> 
> I have carried out some performance comparisons between the generic
> table implementations and the new hardware implementations. Listed below
> is the number of cycles it takes to compute the CRC hash for buffers of
> various sizes (as reported by rte_get_timer_cycles()). These results
> were collected on a Kendryte K230 and averaged over 20 samples:
> 
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
> 
> These results suggest a speed-up of lib/net by thirteen times, and of
> lib/hash by four times.
> 
> I have also run the hash_functions_autotest benchmark in dpdk_test,
> which measures the performance of the lib/hash implementation on small
> buffers, getting the following times:
> 
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
> 
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
> 
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
> 
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
> 

Since don't have riscv hardware or detailed CPU knowledge, turned to AI review for help.
Looks like more work is needed. Not all AI comments are correct; please look at in detail.

Summary of Findings

  The patch series correctly introduces RISC-V Zbc (carryless multiplication) support for CRC acceleration in both hash and
  net libraries, including runtime detection via the Linux hwprobe interface. However, I identified a significant alignment
  bug in the buffer processing logic and a missing header that will likely break the build on some systems.

  ---

  Correctness Bugs (High Priority)

  1. Alignment Logic Error in crc32_eth_calc_zbc (lib/net/net_crc_zbc.c)
  The code attempts to align the input buffer to an 8-byte boundary before performing 64-bit wide operations, but the
  calculation is incorrect:

   1 +    /* Barrett reduce until buffer aligned to 8-byte word */
   2 +    uint32_t misalign = (size_t)data & 7;
   3 +    if (misalign != 0 && misalign <= data_len) {
   4 +        crc = crc32_repeated_barrett_zbc(data, misalign, crc, params);
   5 +        data += misalign;
   6 +        data_len -= misalign;
   7 +    }

  Issue: If data is 0x...001 (1-byte misaligned), misalign is 1. After processing 1 byte and incrementing data, the new
  address is 0x...002, which is still not 8-byte aligned. This leads to misaligned 64-bit loads (*(const uint64_t *)data)
  later in the function, which can cause performance degradation or traps depending on the RISC-V implementation.
  Recommendation: The number of bytes to process to reach alignment should be (8 - ((uintptr_t)data & 7)) & 7.

  2. Missing Header for cpu_set_t (lib/eal/riscv/rte_cpuflags.c)
  In Patch 01/10, the function rte_cpu_hwprobe_ima_ext introduces the use of cpu_set_t:

   1 +    /* empty set of cpus returns extensions present on all cpus */
   2 +    cpu_set_t *cpus = NULL;

  Issue: lib/eal/riscv/rte_cpuflags.c does not include <sched.h>, which is required for the cpu_set_t definition. This will
  cause a compilation error.
  Recommendation: Add #include <sched.h> to the EAL CPU flags implementation.

  3. Algorithm Overriding in rte_hash_crc_set_alg (lib/hash/rte_hash_crc.c)
  The implementation overrides the user's requested algorithm if the Zbc extension is detected:

   1 +    if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_EXT_ZBC))
   2 +        rte_hash_crc32_alg = CRC32_RISCV64;

  Issue: If a user explicitly calls rte_hash_crc_set_alg(CRC32_SW), the code will still force the use of CRC32_RISCV64. While
  this matches the existing (and arguably flawed) pattern for ARM64, it violates the expectation that set_alg respects the
  user's choice.

  ---

  Style and Process Compliance

  4. Inconsistent Assertion Macros
   - Patch 02/10 uses RTE_ASSERT in lib/hash/rte_crc_riscv64.h.
   - Patch 03/10 uses standard C assert() in lib/net/net_crc_zbc.c.
  Recommendation: Use RTE_ASSERT consistently across the codebase per DPDK standards.

  5. Implicit Pointer Comparison Nits
  While most comparisons are explicit, the project style generally favors if (ptr == NULL) over if (!ptr). There are a few
  instances in Patch 01 (Meson logic) and Patch 02 (intrinsics checks) that could be more explicit, though they mostly follow
  the local conventions of those specific files.

  6. Barrett Reduction Constants
  The constants mu and p in lib/hash/rte_crc_riscv64.h are lowercase. While these are static const variables, global/static
  constants in DPDK are often written in ALL_UPPERCASE.

  ---

  Additional Observations

   - Toolchain Requirements: The Meson logic correctly identifies that GCC 14.1+ or Clang 18.1+ is required for the Zbc
     intrinsics.
   - Cross-compilation: The addition of a QEMU cross-build target is a helpful addition for testing these extensions in
     virtualized environments.
   - Hardware Probing: The use of the Linux hwprobe syscall is the correct modern approach for RISC-V extension discovery.
                                          


