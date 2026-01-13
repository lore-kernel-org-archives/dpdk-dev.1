Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC275CF45C6
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 01:07:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD47E402E8;
	Tue, 13 Jan 2026 02:07:40 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id D9546402E0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 02:07:38 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-650854c473fso2350124a12.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768266458;
 x=1768871258; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCytb58lXU9FNyWbnb1FA4rANwfEG1oaKmHLOiqCGAE=;
 b=hkYBm9JzhfT3uMQPrLpusJZLmdPxMyuVscPqxn2CpqSbMhKtp3+EeLAVPgJpg7WQvT
 8SuM2UnsNAwxUDbbmW7Zuz8GBA4VxWRlyGFUP1oS8ww2/O0250ZLUWeRcidQIcnufYDL
 Mk5S4JkEXYUqpuMYN90ki3fuxNHh/X6+KTOw4YP8597WwLCq+59CR2ShN++ECsdUmEQX
 scRCK3gSuaKtER3WIxICWimouCbaIVS6CbMLvZZ7zTPE4JlqAT0XByjWamg1N/I5zRU2
 GIW/VyucbLhX/fjodAsHomwWNofwLc+r589KZZs6uXCP3HktRzZagV/1novaSiC3OMGA
 +bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768266458; x=1768871258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCytb58lXU9FNyWbnb1FA4rANwfEG1oaKmHLOiqCGAE=;
 b=S/Yi7ZJrULCT+YSqU8K0N1H+gMm9HOVSVxohW3i3qyeKHdHMOfVXJU5c0Fm1tIFO3v
 /mCPYqPYU0B95xSJaxFiv+caF4Fzo6elLyjQZ9BPYureaBwwfmM11c1sDKchMUeEsIsg
 d1PoQBXowNrfI7O+yB5LDfeBhL/e1gKzz8tvd2W2pCb2+WwcxY3iy8lDfazntqULXkHl
 bcXvDbMx9RwyL/MAE5eTayozhfRLGEXTAQm+Vk5+f32ThK1GjyUACEi5yE8mh7eSjX8F
 VputccDxMTAcqvEf/2ulWS7+4y80X3KnygHK+mI8GB4Ds3eMNtOU6vB6I6meEOMx1XiV
 iPAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIoqvVABiBa3H/OFgUP6rI2fHAPlPVRax93SBnYBej73OctMoQh7wOmdV+GDuoiDllE5Y=@dpdk.org
X-Gm-Message-State: AOJu0YwvWo04sdEGSNrritqCw0igwJGeknb3XMWjmbIFc24S15knMXTu
 Uk4BKwLUWPawKsjreqeHjlcGDZj+sDF1WXccdZs10O2oy/78X+ih7VmEL7vfZRB7LW0=
X-Gm-Gg: AY/fxX7rIVYfOY78fD4DxixpKeMlrz0WeqIURYq3LMNlga8qO1zVe6SRSy7aR65P8Z5
 JA6hZwzvJIXg+fVOh3tZ4cG6+kJeSBN2YlJvDdfLrxG8uBb9g8nptqFD0CeHWS/AaNGFWDUNDSd
 US1SdPq0fuxCUg7JULKpEsCvny9WVZxHEhmlM0Kw3T5igECvevAzT+Im9jKMxCtPpCVJUJJklpt
 HdWdfmzH430xxrgFpLx6/yEwV2J5sfONsYEzXef31MKdsnrPOPdZNsq3gDU1C7t2tl4Vv67v7F6
 eK0IEDxOTO5AWzeNIbmgdU+J40gAEOns3Q4GtktZ0Dc56ehp8cM+EgIcwahBM24JmgZL47QiszS
 M0JD3+JPFXY3Ix8d9i4gxx6QqfKGFr53spmxnLBI9C9OiYIofpoKvaQ7YsgbOj7DEJjT7ZIdP2A
 KDPVAiLnfpP+ZCrVoMxQpmn2983TsWqsCYUXCAzB+CJ5eVqoJeu7FRMz5knWiYqRc=
X-Google-Smtp-Source: AGHT+IEUj2pcSCWtdXqDsSZcyWnsuhWqs00/m+QKVcYcWhczcopbgW5JIlZFf89teHmMT/q7uKHb/g==
X-Received: by 2002:aa7:c999:0:b0:649:a157:3327 with SMTP id
 4fb4d7f45d1cf-652e539ae7cmr910216a12.17.1768266458363; 
 Mon, 12 Jan 2026 17:07:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf65c07sm18735363a12.23.2026.01.12.17.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 17:07:38 -0800 (PST)
Date: Mon, 12 Jan 2026 17:07:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Gregory <daniel.gregory@bytedance.com>
Cc: Stanislaw Kardach <stanislaw.kardach@gmail.com>, dev@dpdk.org, Punit
 Agrawal <punit.agrawal@bytedance.com>, Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>, Chunsong Feng
 <fengchunsong@bytedance.com>
Subject: Re: [PATCH v3 0/9] riscv: implement accelerated crc using zbc
Message-ID: <20260112170731.612fc8c7@phoenix.local>
In-Reply-To: <20240827153230.52880-1-daniel.gregory@bytedance.com>
References: <20240712154645.80622-1-daniel.gregory@bytedance.com>
 <20240827153230.52880-1-daniel.gregory@bytedance.com>
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

On Tue, 27 Aug 2024 16:32:20 +0100
Daniel Gregory <daniel.gregory@bytedance.com> wrote:

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
> Daniel Gregory (9):
>   config/riscv: detect presence of Zbc extension
>   hash: implement CRC using riscv carryless multiply
>   net: implement CRC using riscv carryless multiply
>   config/riscv: add qemu crossbuild target
>   examples/l3fwd: use accelerated CRC on riscv
>   ipfrag: use accelerated CRC on riscv
>   examples/l3fwd-power: use accelerated CRC on riscv
>   hash/cuckoo: use accelerated CRC on riscv
>   member: use accelerated CRC on riscv
>=20
>  MAINTAINERS                                   |   2 +
>  app/test/test_crc.c                           |   9 +
>  app/test/test_hash.c                          |   7 +
>  config/riscv/meson.build                      |  44 +++-
>  config/riscv/riscv64_qemu_linux_gcc           |  17 ++
>  .../linux_gsg/cross_build_dpdk_for_riscv.rst  |   5 +
>  examples/l3fwd-power/main.c                   |   2 +-
>  examples/l3fwd/l3fwd_em.c                     |   2 +-
>  lib/eal/riscv/include/rte_cpuflags.h          |   2 +
>  lib/eal/riscv/rte_cpuflags.c                  | 112 +++++++---
>  lib/hash/meson.build                          |   1 +
>  lib/hash/rte_crc_riscv64.h                    |  89 ++++++++
>  lib/hash/rte_cuckoo_hash.c                    |   3 +
>  lib/hash/rte_hash_crc.c                       |  13 +-
>  lib/hash/rte_hash_crc.h                       |   6 +-
>  lib/ip_frag/ip_frag_internal.c                |   6 +-
>  lib/member/rte_member.h                       |   2 +-
>  lib/net/meson.build                           |   4 +
>  lib/net/net_crc.h                             |  11 +
>  lib/net/net_crc_zbc.c                         | 191 ++++++++++++++++++
>  lib/net/rte_net_crc.c                         |  40 ++++
>  lib/net/rte_net_crc.h                         |   2 +
>  22 files changed, 529 insertions(+), 41 deletions(-)
>  create mode 100644 config/riscv/riscv64_qemu_linux_gcc
>  create mode 100644 lib/hash/rte_crc_riscv64.h
>  create mode 100644 lib/net/net_crc_zbc.c
>=20

Not sure all the reasons this never got merged but it won't apply to current
DPDK version and AI review has lots of feedback.  If still interested,
please fix up and resubmit.

# DPDK Patch Review: RISC-V Zbc Extension Series

**Patch Series:** [PATCH v3 1-9/9] RISC-V Zbc extension for hardware CRC =20
**Submitter:** Daniel Gregory <daniel.gregory@bytedance.com> =20
**Date:** August 27, 2024 =20
**Patchwork IDs:** 143405-143413

---

## Overview

This 9-patch series adds support for RISC-V's Zbc (carry-less multiplicatio=
n) extension to implement hardware-accelerated CRC-32C, CRC-32, and CRC-16 =
calculations in DPDK. The series includes build-time and runtime detection,=
 library implementations, and integration into various DPDK components.

---

## ERROR Level Issues (Must Fix)

### 1. **SPDX License Identifier Typo** =E2=80=94 `lib/hash/rte_crc_riscv64=
.h`

```c
/* SPDX-License_Identifier: BSD-3-Clause   =E2=86=90 WRONG: underscore
 * Copyright(c) ByteDance 2024
 */
```

**Required:**
```c
/* SPDX-License-Identifier: BSD-3-Clause   =E2=86=90 hyphen required
 * Copyright(c) 2024 ByteDance
 */
```

**AGENTS.md Reference:** "Every source file must begin with an SPDX license=
 identifier"

---

### 2. **Header Guard After Includes** =E2=80=94 `lib/hash/rte_crc_riscv64.=
h`

The header guard is placed AFTER the `#include` statements, which defeats i=
ts purpose:

```c
/* SPDX-License_Identifier: BSD-3-Clause
 * Copyright(c) ByteDance 2024
 */

#include <assert.h>          =E2=86=90 includes BEFORE guard
#include <stdint.h>

#include <riscv_bitmanip.h>

#ifndef _RTE_CRC_RISCV64_H_  =E2=86=90 guard comes too late
#define _RTE_CRC_RISCV64_H_
```

**Required:** Header guard immediately after blank line following copyright:

```c
/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2024 ByteDance
 */

#ifndef _RTE_CRC_RISCV64_H_
#define _RTE_CRC_RISCV64_H_

#include <assert.h>
#include <stdint.h>

#include <riscv_bitmanip.h>
```

---

### 3. **Missing NULL Check / Logic Bug** =E2=80=94 `lib/net/rte_net_crc.c`

In `rte_crc32_eth_default_handler()`, after adding zbc support:

```c
handlers =3D neon_pmull_get_handlers();
if (handlers !=3D NULL)
    return handlers[RTE_NET_CRC32_ETH](data, data_len);
handlers =3D zbc_clmul_get_handlers();
    return handlers[RTE_NET_CRC32_ETH](data, data_len);  =E2=86=90 Missing =
NULL check!
handlers =3D handlers_scalar;
```

This will crash if `zbc_clmul_get_handlers()` returns NULL. **Required:**

```c
handlers =3D zbc_clmul_get_handlers();
if (handlers !=3D NULL)
    return handlers[RTE_NET_CRC32_ETH](data, data_len);
handlers =3D handlers_scalar;
```

---

### 4. **Test Output Typo** =E2=80=94 `app/test/test_hash.c`

```c
printf("Failed checking CRC32_SW against CRC32_RISC64\n");
                                              ^^^^ Missing 'V'
```

**Should be:** `CRC32_RISCV64`

---

## WARNING Level Issues (Should Fix)

### 5. **Use of Standard `assert()` Instead of RTE_ASSERT**

Multiple files use standard library `assert()`:

- `lib/hash/rte_crc_riscv64.h` line 539
- `lib/net/net_crc_zbc.c` line 896

**AGENTS.md Guidance:** DPDK prefers `RTE_ASSERT()` or `RTE_VERIFY()` for c=
onsistency. Standard `assert()` may be compiled out in release builds unexp=
ectedly.

---

### 6. **Implicit Pointer Comparison in `likely()` Macro**

In `lib/hash/rte_crc_riscv64.h`:

```c
if (likely(rte_hash_crc32_alg & CRC32_RISCV64))
```

This is a bitmask check (integer), which is acceptable. However, for clarit=
y and consistency with DPDK style, explicit comparison is preferred:

```c
if (likely((rte_hash_crc32_alg & CRC32_RISCV64) !=3D 0))
```

---

### 7. **Fall-through Comment Missing** =E2=80=94 `lib/net/rte_net_crc.c`

```c
case RTE_NET_CRC_ZBC:
    handlers =3D zbc_clmul_get_handlers();
    /* fall-through */          =E2=86=90 MISSING
case RTE_NET_CRC_SCALAR:
```

DPDK requires explicit `/* fall-through */` or `/* FALLTHROUGH */` comments=
 (per AGENTS.md Section on switch statements).

---

### 8. **Commit Body Line Length** =E2=80=94 Patch 1/9

Some lines in the commit message body may exceed 75 characters:

```
These let us detect whether the Zbc extension is supported on the
compiler and -march we're building with. The C api also defines Zbc
```

**AGENTS.md:** "Body wrapped at 75 characters"

---

### 9. **Meson Build File Comment at End of Conditionals**

In `lib/net/meson.build`, the endif cascade doesn't clearly indicate which =
condition is being closed. Consider adding comments for maintainability.

---

### 10. **Copyright Format Inconsistency**

The patches use:
```c
Copyright(c) ByteDance 2024
```

DPDK convention (per AGENTS.md examples) typically uses:
```c
Copyright(c) 2024 ByteDance
```

With the year first.

---

## INFO Level Issues (Consider)

### 11. **Static Variables Without `static` at File Scope** =E2=80=94 `lib/=
net/net_crc_zbc.c`

```c
struct crc_clmul_ctx crc32_eth_clmul;
struct crc_clmul_ctx crc16_ccitt_clmul;
```

These should be `static` to limit scope to the translation unit:

```c
static struct crc_clmul_ctx crc32_eth_clmul;
static struct crc_clmul_ctx crc16_ccitt_clmul;
```

---

### 12. **Magic Numbers in Constants**

In `net_crc_zbc.c`, the polynomial constants are well-commented, which is g=
ood. Consider also documenting the mathematical derivation source more expl=
icitly (the Intel whitepaper reference is good).

---

### 13. **Documentation Gap**

The series doesn't include updates to release notes (`doc/guides/rel_notes/=
`). For a feature addition like hardware CRC acceleration on a new architec=
ture, this should be documented.

**AGENTS.md:** "Update release notes in `doc/guides/rel_notes/` for importa=
nt changes"

---

## Commit Message Analysis

| Patch | Subject Length | Format Check |
|-------|---------------|--------------|
| 1/9 | `config/riscv: detect presence of Zbc extension` | 47 chars =E2=9C=
=93 |
| 2/9 | `hash: implement CRC using riscv carryless multiply` | 50 chars =E2=
=9C=93 |
| 3/9 | `net: implement CRC using riscv carryless multiply` | 49 chars =E2=
=9C=93 |
| 4/9 | `config/riscv: add qemu crossbuild target` | 41 chars =E2=9C=93 |
| 5/9 | `examples/l3fwd: use accelerated CRC on riscv` | 45 chars =E2=9C=93=
 |
| 6/9 | `ipfrag: use accelerated CRC on riscv` | 38 chars =E2=9C=93 |
| 7/9 | `examples/l3fwd-power: use accelerated CRC on riscv` | 51 chars =E2=
=9C=93 |
| 8/9 | `hash/cuckoo: use accelerated CRC on riscv` | 42 chars =E2=9C=93 |
| 9/9 | `member: use accelerated CRC on riscv` | 37 chars =E2=9C=93 |

**All subject lines:**
- =E2=9C=93 Under 60 character limit
- =E2=9C=93 Lowercase after colon
- =E2=9C=93 Imperative mood
- =E2=9C=93 No trailing period
- =E2=9C=93 Correct prefixes (config/riscv, hash, net, examples/*, lib name=
s)
- =E2=9C=93 Signed-off-by present on all patches

---

## Positive Observations

1. **Well-structured series** =E2=80=94 The patches are logically ordered: =
detection first, then core implementations, then consumers.

2. **Good documentation** =E2=80=94 Comments explain the Barrett reduction =
algorithm and reference the Intel whitepaper.

3. **Proper runtime detection** =E2=80=94 Uses hwprobe syscall for runtime =
CPU feature detection, with appropriate fallbacks.

4. **Test coverage** =E2=80=94 Adds test cases to existing test suites (tes=
t_hash.c, test_crc.c).

5. **MAINTAINERS updates** =E2=80=94 Properly adds new files to the RISC-V =
maintainer's scope.

6. **Cross-compilation support** =E2=80=94 Includes QEMU target for develop=
ment/testing.

---

## Summary

| Severity | Count | Action Required |
|----------|-------|-----------------|
| **ERROR** | 4 | Must fix before merge |
| **WARNING** | 6 | Should fix |
| **INFO** | 3 | Consider fixing |

### Required Actions Before Merge

1. Fix SPDX identifier typo (`License_Identifier` =E2=86=92 `License-Identi=
fier`)
2. Move header guard before includes in `rte_crc_riscv64.h`
3. Add NULL check after `zbc_clmul_get_handlers()` in `rte_crc32_eth_defaul=
t_handler()`
4. Fix typo `CRC32_RISC64` =E2=86=92 `CRC32_RISCV64` in test output

### Recommended Actions

5. Add fall-through comment in switch statement
6. Make file-scope variables `static`
7. Add release notes entry
8. Consider using `RTE_ASSERT()` instead of `assert()`
