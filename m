Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D9D30CF6
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:26:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F3E40431;
	Wed, 14 Jan 2026 02:26:13 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id D7E1F4029D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:26:10 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b871b6e0c70so450331566b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768353970;
 x=1768958770; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjeYhu2+p1yNlR5NvBJykiE/7OkAJrunCwlByYGwjP8=;
 b=DI1+n4RBgUsPsfT5ApcQPfHuV/B/+XlKBohLwUffqca/MnRtk1PhHuWg0AeRvz5YWI
 9olD7jNihu3RkHnls4GHDTdRz0SAdpi3owOT6tzBLH5NemH2Rt9vqIRg/Cg5RMkZ7yOw
 M7M0b7C0g/6vn77Sdj+Xwadf/IpTnnHwhrM9j2lJ/qG4KoPQDk1IH5PURhEPKNuiT/Sx
 pzYSQy2tv9UmxM8dVElFlYkLvduwINt9b8EATCVmOLii6HHPn8W/1tBVcKkzPjh6XwSH
 DFbu8uci1eK+8fazSLla1gHsoFUFFO7eo87ptI1wqzDp3XNDj1/rhGlF/XhQr9JYGaXZ
 CV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768353970; x=1768958770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wjeYhu2+p1yNlR5NvBJykiE/7OkAJrunCwlByYGwjP8=;
 b=TfN5QtPk3sZn/MBMPNWJ/zbhUmhyDvxBjiH0VH0bLKtNQxgxo2+luv4AVNnSR9oota
 8OhbDeiga6nOpXOHLeryg/LupSo8XEim4W/5wp53Okh8nRpGvElQDOFWdUt9qXEAwxMe
 ZO3SOG2icUP0dRSinuV1M3qkjyprS+Hq4O2A7/hm6pUL1gG93gSKZRLnA9jMJDuJkvm9
 7SclGuK4EZLVXZZO7reOnzhM3I/6DMIHDLOCQWMzYU5hs2ujbE0WO0Qq7i5/CuabmCwA
 HLCj/MqdifgdK2qsq2lBpO7KRDr60Iw0p9aEgrzo54hV4EQn6uEVgV0aZOHAdXYX7jPo
 6K7w==
X-Gm-Message-State: AOJu0YytS2cPU5bSFAtPXkcMu7UCgggI1wrQhNoQwKCGG1WKzuTVj7pB
 dMg62H1qc0t6IUIuSi0stXg2rkeoybYoDsJFpY20kVWmT+q0aypqaqO2b/drD16wwww=
X-Gm-Gg: AY/fxX5jafAycUna4EyRBbZYppgWt7sRmqEja3dpzaVQdwXVnApcc/gia8+ICvvwfcv
 +cA3BUxWR19TYuzi9Y67U2Xm2RztBWIhHshmTJmOmRBbUVgN737ogybwJAH12KALoONIkNFLeuj
 fbq9ZcBW66LSWHRFMgLPfQRKiAsIYx2ni7nWsWzWad7EVVARq0ZiSSh1qWzA/Pr05Dh1vAfiqeL
 srHquX7DDc7i8SxDUNOT5wO6QhX0Xr0FSdY+LbNr4CqhhfOlyxPJNG1B42/z07AdKAF6Ru+PzyC
 m4PbnhzT5xeo/ggVdqQKxiMSIeIGCLHUwGObJlPcwSvEfHmTP2fEWJP0jQOnzBVupM/I/oXqmVy
 1H7BSt1ULh4CigDdinY+ayPn/JXfUvnT6pIJI7ulY3x3EK/vV1Ugm6Vq6c76cJxpH7+2bAMeYYi
 WIjSYrsTdBAr2snTdtgvo0KqUknwSu1YNj6PaC1wayGcdcQdTvlBudLb8UGHfajIs=
X-Received: by 2002:a17:907:6d07:b0:b87:1ffc:2fba with SMTP id
 a640c23a62f3a-b876126d6f0mr88329966b.43.1768353970281; 
 Tue, 13 Jan 2026 17:26:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87693be298sm4664966b.59.2026.01.13.17.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:26:10 -0800 (PST)
Date: Tue, 13 Jan 2026 17:26:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/8] record and rework component dependencies
Message-ID: <20260113172605.3de48b8a@phoenix.local>
In-Reply-To: <cover.1725462264.git.anatoly.burakov@intel.com>
References: <20240730145508.551075-1-bruce.richardson@intel.com>
 <cover.1725462264.git.anatoly.burakov@intel.com>
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

On Wed,  4 Sep 2024 16:08:28 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> As part of the meson build, we can record the dependencies for each
> component as we process it, logging them to a file. This file can be
> used as input to a number of other scripts and tools, for example, to
> graph the dependencies, or to allow higher-level build-config tools to
> automatically enable component requirements, etc.
>=20
> The first patch of this set separates dependencies inside meson into
> optional or mandatory. The second patch of this set generates the basic
> dependency tree. The third patch does some processing of that dependency
> tree to identify cases where dependencies are being unnecessarily
> specified. Reducing these makes it easier to have readable dependency
> graphs in future, without affecting the build.
>=20
> The following 4 patches are based on the output of the second patch, and
> greatly cut down the number of direct dependency links between
> components. Even with the cut-down dependencies, the full dependency
> graph is nigh-unreadable, so the final patch adds a new script to
> generate dependency tree subgraphs, creating dot files for e.g. the
> dependencies of a particular component, or a component class such as
> mempool drivers.
>=20
> v2 -> v3:
> - Split dependencies into optional and mandatory
> - Fixup graph scripts to read and generate graphs that encode optional
>   dependencies into the graph
> - Python version fixes to avoid using features not available in minimum
>   supported Python version
> - Formatting with Ruff, and PEP-484 compliance
>=20
> Anatoly Burakov (1):
>   build: split dependencies into mandatory and optional
>=20
> Bruce Richardson (7):
>   build: output a dependency log in build directory
>   devtools: add script to flag unneeded dependencies
>   build: remove kvargs from driver class dependencies
>   build: reduce library dependencies
>   build: reduce driver dependencies
>   build: reduce app dependencies
>   devtools: add script to generate DPDK dependency graphs
>=20
>  app/dumpcap/meson.build                    |   2 +-
>  app/graph/meson.build                      |   2 +-
>  app/meson.build                            |  11 +-
>  app/pdump/meson.build                      |   2 +-
>  app/proc-info/meson.build                  |   4 +-
>  app/test-bbdev/meson.build                 |   8 +-
>  app/test-crypto-perf/meson.build           |   4 +-
>  app/test-fib/meson.build                   |   2 +-
>  app/test-pmd/meson.build                   |  26 +--
>  app/test-sad/meson.build                   |   2 +-
>  app/test/meson.build                       |  14 +-
>  buildtools/log-deps.py                     |  81 ++++++++
>  buildtools/meson.build                     |   2 +
>  devtools/draw-dependency-graphs.py         | 223 +++++++++++++++++++++
>  devtools/find-duplicate-deps.py            |  53 +++++
>  drivers/baseband/fpga_5gnr_fec/meson.build |   2 +-
>  drivers/baseband/fpga_lte_fec/meson.build  |   2 +-
>  drivers/baseband/la12xx/meson.build        |   2 +-
>  drivers/baseband/null/meson.build          |   2 +-
>  drivers/baseband/turbo_sw/meson.build      |   2 +-
>  drivers/bus/auxiliary/meson.build          |   2 -
>  drivers/bus/dpaa/meson.build               |   2 +-
>  drivers/bus/fslmc/meson.build              |   2 +-
>  drivers/bus/ifpga/meson.build              |   2 +-
>  drivers/bus/pci/meson.build                |   4 +-
>  drivers/bus/platform/meson.build           |   1 -
>  drivers/bus/uacce/meson.build              |   2 -
>  drivers/bus/vdev/meson.build               |   2 -
>  drivers/common/cnxk/meson.build            |   4 +-
>  drivers/common/cpt/meson.build             |   2 +-
>  drivers/common/idpf/meson.build            |   2 +-
>  drivers/common/mlx5/meson.build            |   2 +-
>  drivers/compress/mlx5/meson.build          |   2 +-
>  drivers/compress/nitrox/meson.build        |   2 +-
>  drivers/compress/octeontx/meson.build      |   2 +-
>  drivers/crypto/bcmfs/meson.build           |   2 +-
>  drivers/crypto/cnxk/meson.build            |   2 +-
>  drivers/crypto/dpaa_sec/meson.build        |   2 +-
>  drivers/crypto/ipsec_mb/meson.build        |   2 +-
>  drivers/crypto/mlx5/meson.build            |   2 +-
>  drivers/crypto/nitrox/meson.build          |   2 +-
>  drivers/dma/cnxk/meson.build               |   2 +-
>  drivers/dma/dpaa/meson.build               |   2 +-
>  drivers/dma/dpaa2/meson.build              |   2 +-
>  drivers/dma/odm/meson.build                |   2 +-
>  drivers/dma/skeleton/meson.build           |   2 +-
>  drivers/event/cnxk/meson.build             |   2 +-
>  drivers/event/dlb2/meson.build             |   2 +-
>  drivers/event/dpaa2/meson.build            |   2 +-
>  drivers/event/meson.build                  |   2 +-
>  drivers/event/octeontx/meson.build         |   3 +-
>  drivers/event/sw/meson.build               |   2 +-
>  drivers/mempool/cnxk/meson.build           |   2 +-
>  drivers/mempool/dpaa/meson.build           |   2 +-
>  drivers/mempool/dpaa2/meson.build          |   2 +-
>  drivers/mempool/octeontx/meson.build       |   2 +-
>  drivers/meson.build                        |   9 +-
>  drivers/net/cnxk/meson.build               |   3 +-
>  drivers/net/iavf/meson.build               |   2 +-
>  drivers/net/ice/meson.build                |   2 +-
>  drivers/net/mana/meson.build               |   2 +-
>  drivers/net/meson.build                    |   2 +-
>  drivers/net/mlx5/meson.build               |   2 +-
>  drivers/net/sfc/meson.build                |   2 +-
>  drivers/net/softnic/meson.build            |   2 +-
>  drivers/raw/cnxk_bphy/meson.build          |   2 +-
>  drivers/raw/cnxk_gpio/meson.build          |   2 +-
>  drivers/raw/ntb/meson.build                |   2 +-
>  drivers/raw/skeleton/meson.build           |   2 +-
>  drivers/regex/meson.build                  |   2 +-
>  drivers/regex/mlx5/meson.build             |   2 +-
>  drivers/vdpa/ifc/meson.build               |   2 +-
>  drivers/vdpa/meson.build                   |   3 +-
>  drivers/vdpa/mlx5/meson.build              |   2 +-
>  drivers/vdpa/sfc/meson.build               |   2 +-
>  examples/ethtool/meson.build               |   2 +-
>  examples/l2fwd-crypto/meson.build          |   2 +-
>  examples/l3fwd/meson.build                 |   2 +-
>  examples/meson.build                       |  11 +-
>  examples/vm_power_manager/meson.build      |   6 +-
>  lib/argparse/meson.build                   |   2 +-
>  lib/bbdev/meson.build                      |   2 +-
>  lib/bitratestats/meson.build               |   2 +-
>  lib/bpf/meson.build                        |   2 +-
>  lib/cmdline/meson.build                    |   2 +-
>  lib/compressdev/meson.build                |   2 +-
>  lib/cryptodev/meson.build                  |   2 +-
>  lib/dispatcher/meson.build                 |   2 +-
>  lib/distributor/meson.build                |   2 +-
>  lib/dmadev/meson.build                     |   2 -
>  lib/eal/meson.build                        |   5 +-
>  lib/efd/meson.build                        |   2 +-
>  lib/ethdev/meson.build                     |   2 +-
>  lib/eventdev/meson.build                   |   3 +-
>  lib/fib/meson.build                        |   2 +-
>  lib/gpudev/meson.build                     |   2 +-
>  lib/graph/meson.build                      |   2 +-
>  lib/gro/meson.build                        |   2 +-
>  lib/gso/meson.build                        |   2 +-
>  lib/hash/meson.build                       |   4 +-
>  lib/ip_frag/meson.build                    |   2 +-
>  lib/ipsec/meson.build                      |   2 +-
>  lib/kvargs/meson.build                     |   2 +-
>  lib/latencystats/meson.build               |   2 +-
>  lib/lpm/meson.build                        |   3 +-
>  lib/mbuf/meson.build                       |   2 +-
>  lib/member/meson.build                     |   2 +-
>  lib/mempool/meson.build                    |   2 +-
>  lib/meson.build                            |   8 +-
>  lib/metrics/meson.build                    |   2 +-
>  lib/mldev/meson.build                      |   2 +-
>  lib/net/meson.build                        |   2 +-
>  lib/node/meson.build                       |   2 +-
>  lib/pcapng/meson.build                     |   2 +-
>  lib/pdcp/meson.build                       |   2 +-
>  lib/pdump/meson.build                      |   2 +-
>  lib/pipeline/meson.build                   |   2 +-
>  lib/port/meson.build                       |   2 +-
>  lib/power/meson.build                      |   2 +-
>  lib/rawdev/meson.build                     |   2 -
>  lib/rcu/meson.build                        |   2 +-
>  lib/regexdev/meson.build                   |   2 +-
>  lib/reorder/meson.build                    |   2 +-
>  lib/rib/meson.build                        |   2 +-
>  lib/ring/meson.build                       |   1 -
>  lib/sched/meson.build                      |   2 +-
>  lib/security/meson.build                   |   2 +-
>  lib/table/meson.build                      |   2 +-
>  lib/telemetry/meson.build                  |   2 +-
>  lib/vhost/meson.build                      |   2 +-
>  130 files changed, 533 insertions(+), 171 deletions(-)
>  create mode 100644 buildtools/log-deps.py
>  create mode 100755 devtools/draw-dependency-graphs.py
>  create mode 100755 devtools/find-duplicate-deps.py


This patchset needs to be rebased. Please resubmit.
AI code review only found one minor thing.



## DPDK Patchset Review: build: introduce optional internal dependencies (v=
7)

**Series:** [PATCH v7 1-8/8] by Anatoly Burakov / Bruce Richardson =20
**Patchwork IDs:** 151640-151647

---

### Summary

This 8-patch series introduces a framework for optional internal dependenci=
es in DPDK's Meson build system and reduces unnecessary dependencies across=
 libraries, drivers, and applications. It also adds tooling to log, analyze=
, and visualize the dependency graph.

---

### Patch-by-Patch Review

#### Patch 1/8: `build: introduce optional internal dependencies`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 42 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| No trailing period | =E2=9C=85 PASS | |
| Signed-off-by present | =E2=9C=85 PASS | Two signatures (Bruce Richardson=
, Anatoly Burakov) |
| Body =E2=89=A475 chars | =E2=9C=85 PASS | |
| Body not starting with "It" | =E2=9C=85 PASS | |

**=E2=9A=A0=EF=B8=8F Warning - Typo in commit message body (line 79):**
```
said dependency is not being built. At build
time, the build system will resolve any optional dependencies and add
them to the list of dependencies to be built. Any source files requiring
said optional depepdencies will still have to be added explicitly...
                ^^^^^^^^^^^^
```
Should be: `dependencies`

**Meson Style:** =E2=9C=85 Follows 4-space indentation, proper list formatt=
ing.

---

#### Patch 2/8: `build: output a dependency log in build directory`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 45 characters |
| Signed-off-by present | =E2=9C=85 PASS | Bruce Richardson + Acked-by + An=
atoly |
| From: line | =E2=9C=85 PASS | Correct attribution to Bruce Richardson |
| SPDX in new file | =E2=9C=85 PASS | `buildtools/log-deps.py` line 2 |
| Copyright follows SPDX | =E2=9C=85 PASS | |
| Shebang correct | =E2=9C=85 PASS | `#! /usr/bin/env python3` |

**Code Quality:** `buildtools/log-deps.py` is well-structured with proper d=
ocstrings.

---

#### Patch 3/8: `devtools: add script to find duplicate dependencies`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 46 characters |
| Signed-off-by present | =E2=9C=85 PASS | Bruce Richardson |
| SPDX in new file | =E2=9C=85 PASS | `devtools/find-duplicate-deps.py` |
| Shebang correct | =E2=9C=85 PASS | |

**=E2=84=B9=EF=B8=8F Info - Minor style suggestion:** =20
The class name `dep` at line 934 uses lowercase, which is unconventional fo=
r Python classes. Consider `Dep` for PEP8 compliance (though this is not a =
DPDK requirement).

---

#### Patch 4/8: `drivers: remove kvargs from class dependencies`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 44 characters |
| Signed-off-by present | =E2=9C=85 PASS | Bruce Richardson |
| Correct component prefix | =E2=9C=85 PASS | `drivers:` |

**Changes are minimal and correct** - removes redundant `kvargs` dependency=
 from 4 driver class meson files since `kvargs` is already pulled in via EA=
L.

---

#### Patch 5/8: `lib: reduce library dependencies`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 26 characters |
| Signed-off-by present | =E2=9C=85 PASS | Bruce Richardson |
| Correct component prefix | =E2=9C=85 PASS | `lib:` |

**Code Style:** All changes correctly convert `deps +=3D` to `deps =3D` pat=
tern for direct assignment, leveraging Meson's recursive dependency support.

---

#### Patch 6/8: `drivers: reduce driver dependencies`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 30 characters |
| Signed-off-by present | =E2=9C=85 PASS | Anatoly Burakov |
| Correct component prefix | =E2=9C=85 PASS | `drivers:` |

**Large patch (83 files changed)** but changes are systematic - removing ex=
plicit dependencies that are transitively satisfied.

---

#### Patch 7/8: `app: reduce app dependencies`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 26 characters |
| Signed-off-by present | =E2=9C=85 PASS | Bruce Richardson |
| Notes present | =E2=9C=85 PASS | v6=E2=86=92v7 changelog |
| Correct component prefix | =E2=9C=85 PASS | `app:` |

---

#### Patch 8/8: `devtools: add script to generate DPDK dependency graphs`

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 47 characters |
| Signed-off-by present | =E2=9C=85 PASS | Bruce Richardson, Anatoly Burako=
v |
| SPDX in new file | =E2=9C=85 PASS | |
| Copyright follows SPDX | =E2=9C=85 PASS | |
| Shebang correct | =E2=9C=85 PASS | |

**Code Quality:** Well-structured Python with type hints, docstrings, and p=
roper error handling.

---

### Overall Assessment

| Category | Count |
|----------|-------|
| **Errors** | 0 |
| **Warnings** | 1 |
| **Info** | 1 |

#### =E2=9A=A0=EF=B8=8F Warnings (should fix):
1. **Patch 1/8:** Typo in commit message body - "depepdencies" should be "d=
ependencies"

#### =E2=84=B9=EF=B8=8F Info (consider):
1. **Patch 3/8:** Class `dep` could be `Dep` for Python convention (minor)

---

### Recommendation

**PASS with minor fix required**

The patchset is well-structured and follows DPDK coding guidelines. The onl=
y actionable issue is the typo in patch 1's commit message body. Once that'=
s corrected, this series should be ready for merge.

The changes are functionally sound - they leverage Meson's recursive depend=
ency resolution to eliminate redundant explicit dependencies, which will im=
prove build configuration time and simplify the dependency graph. The new t=
ooling (`log-deps.py`, `find-duplicate-deps.py`, `draw-dependency-graphs.py=
`) provides useful visibility into the dependency structure.


