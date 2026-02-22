Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F349BC636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:30:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD95402E7;
	Sun, 22 Feb 2026 16:30:38 +0100 (CET)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177]) by mails.dpdk.org (Postfix) with ESMTP id 61C4B402E6
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:32 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coj48eoUMOOF+dm5Vm3onX7DhX/rBVlsb6oF5lbqe1I=;
 b=OWDVOLOgHJj+tCW0IXSzCCXw2QTU0rq4YEnihSnzXYaUdu9fD2Xzf0jbLCZOQMHETiZgJA
 FgCkBJwTmqOs6hFEq6v69LLx4Uwkdw84m8MXSXCwAFQ2F8YX+rNEc/nwn36X/3Dwo1Or7c
 XiZzufOfZ219UxAJ4zzxj5pZncNYIao=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>
Cc: Daniel Gregory <code@danielg0.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Daniel Gregory <daniel.gregory@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 00/10] riscv: implement accelerated crc using zbc
Date: Sun, 22 Feb 2026 16:29:54 +0100
Message-ID: <cover.1771772598.git.code@danielg0.com>
In-Reply-To: <20240827153230.52880-1-daniel.gregory@bytedance.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

The RISC-V Zbc extension adds instructions for carry-less multiplication
we can use to implement CRC in hardware. This patch set contains two new
implementations:

- one in lib/hash/rte_crc_riscv64.h that uses a Barrett reduction to
  implement the four rte_hash_crc_* functions
- one in lib/net/net_crc_zbc.c that uses repeated single-folds to reduce
  the buffer until it is small enough for a Barrett reduction to
  implement rte_crc16_ccitt_zbc_handler and rte_crc32_eth_zbc_handler

My approach is largely based on the Intel's "Fast CRC Computation Using
PCLMULQDQ Instruction" white paper
https://www.researchgate.net/publication/263424619_Fast_CRC_computation
and a post about "Optimizing CRC32 for small payload sizes on x86"
https://mary.rs/lab/crc32/

Whether these new implementations are enabled is controlled by new
build-time and run-time detection of the RISC-V extensions present in
the compiler and on the target system.

I have carried out some performance comparisons between the generic
table implementations and the new hardware implementations. Listed below
is the number of cycles it takes to compute the CRC hash for buffers of
various sizes (as reported by rte_get_timer_cycles()). These results
were collected on a Kendryte K230 and averaged over 20 samples:

|Buffer    | CRC32-ETH (lib/net) | CRC32C (lib/hash)   |
|Size (MB) | Table    | Hardware | Table    | Hardware |
|----------|----------|----------|----------|----------|
|        1 |   155168 |    11610 |    73026 |    18385 |
|        2 |   311203 |    22998 |   145586 |    35886 |
|        3 |   466744 |    34370 |   218536 |    53939 |
|        4 |   621843 |    45536 |   291574 |    71944 |
|        5 |   777908 |    56989 |   364152 |    89706 |
|        6 |   932736 |    68023 |   437016 |   107726 |
|        7 |  1088756 |    79236 |   510197 |   125426 |
|        8 |  1243794 |    90467 |   583231 |   143614 |

These results suggest a speed-up of lib/net by thirteen times, and of
lib/hash by four times.

I have also run the hash_functions_autotest benchmark in dpdk_test,
which measures the performance of the lib/hash implementation on small
buffers, getting the following times:

| Key Length | Time (ticks/op)     |
| (bytes)    | Table    | Hardware |
|------------|----------|----------|
|          1 |     0.47 |     0.85 |
|          2 |     0.57 |     0.87 |
|          4 |     0.99 |     0.88 |
|          8 |     1.35 |     0.88 |
|          9 |     1.20 |     1.09 |
|         13 |     1.76 |     1.35 |
|         16 |     1.87 |     1.02 |
|         32 |     2.96 |     0.98 |
|         37 |     3.35 |     1.45 |
|         40 |     3.49 |     1.12 |
|         48 |     4.02 |     1.25 |
|         64 |     5.08 |     1.54 |

v4:
- rebase on 26.03-rc1
- RISC64 -> RISCV64 in test_hash.c (Stephen Hemminger)
- Added section to release notes (Stephen Hemminger)
- SPDX-License_Identifier -> SPDX-License-Identifier in
  rte_crc_riscv64.h (Stephen Hemminger)
- Fix header guard in rte_crc_riscv64.h (Stephen Hemminger)
- assert -> RTE_ASSERT in rte_crc_riscv64.h (Stephen Hemminger)
- Fix copyright statement in net_crc_zbc.c (Stephen Hemminger)
- Make crc context structs static in net_crc_zbc.c (Stephen Hemminger)
- prefer the optimised crc when zbc present over jhash in rte_fbk_hash.c
v3:
- rebase on 24.07
- replace crc with CRC in commits (check-git-log.sh)
v2:
- replace compile flag with build-time (riscv extension macros) and
  run-time detection (linux hwprobe syscall) (Stephen Hemminger)
- add qemu target that supports zbc (Stanislaw Kardach)
- fix spelling error in commit message
- fix a bug in the net/ implementation that would cause segfaults on
  small unaligned buffers
- refactor net/ implementation to move variable declarations to top of
  functions
- enable the optimisation in a couple other places optimised crc is
  preferred to jhash
  - l3fwd-power
  - cuckoo-hash

Daniel Gregory (10):
  config/riscv: detect presence of Zbc extension
  hash: implement CRC using riscv carryless multiply
  net: implement CRC using riscv carryless multiply
  config/riscv: add qemu crossbuild target
  examples/l3fwd: use accelerated CRC on riscv
  ipfrag: use accelerated CRC on riscv
  examples/l3fwd-power: use accelerated CRC on riscv
  hash: use accelerated CRC on riscv
  member: use accelerated CRC on riscv
  doc: implement CRC using riscv carryless multiply

 .mailmap                                      |   2 +-
 MAINTAINERS                                   |   2 +
 app/test/test_crc.c                           |  10 +
 app/test/test_hash.c                          |   7 +
 config/riscv/meson.build                      |  33 +++
 config/riscv/riscv64_qemu_linux_gcc           |  17 ++
 .../linux_gsg/cross_build_dpdk_for_riscv.rst  |   5 +
 doc/guides/rel_notes/release_26_03.rst        |   8 +
 examples/l3fwd-power/main.c                   |   2 +-
 examples/l3fwd/l3fwd_em.c                     |   2 +-
 lib/eal/riscv/include/rte_cpuflags.h          |   2 +
 lib/eal/riscv/rte_cpuflags.c                  | 112 +++++++---
 lib/hash/meson.build                          |   1 +
 lib/hash/rte_crc_riscv64.h                    |  90 ++++++++
 lib/hash/rte_cuckoo_hash.c                    |   3 +
 lib/hash/rte_fbk_hash.c                       |   3 +
 lib/hash/rte_hash_crc.c                       |  13 +-
 lib/hash/rte_hash_crc.h                       |   6 +-
 lib/ip_frag/ip_frag_internal.c                |   6 +-
 lib/member/member.h                           |   2 +-
 lib/net/meson.build                           |   4 +
 lib/net/net_crc.h                             |  11 +
 lib/net/net_crc_zbc.c                         | 194 ++++++++++++++++++
 lib/net/rte_net_crc.c                         |  30 ++-
 lib/net/rte_net_crc.h                         |   3 +
 25 files changed, 526 insertions(+), 42 deletions(-)
 create mode 100644 config/riscv/riscv64_qemu_linux_gcc
 create mode 100644 lib/hash/rte_crc_riscv64.h
 create mode 100644 lib/net/net_crc_zbc.c

-- 
2.53.0

